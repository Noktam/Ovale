import AceGUI from "AceGUI-3.0";
import Masque from "Masque";
import { OvaleBestAction } from "./BestAction";
import { OvaleCompile } from "./Compile";
import { OvaleDebug } from "./Debug";
import { futureState } from "./FutureState";
import { OvaleGUID } from "./GUID";
import { OvaleSpellFlash } from "./SpellFlash";
import { OvaleState, baseState, BaseState } from "./State";
import { Ovale } from "./Ovale";
import { OvaleIcon } from "./Icon";
import { EnemiesState } from "./Enemies";
import { lists, checkBoxes } from "./Controls";
let _ipairs = ipairs;
let _next = next;
let _pairs = pairs;
let _wipe = wipe;
let _type = type;
let strmatch = string.match;
let API_CreateFrame = CreateFrame;
let API_GetItemInfo = GetItemInfo;
let API_GetTime = GetTime;
let API_RegisterStateDriver = RegisterStateDriver;
let API_UnitHasVehicleUI = UnitHasVehicleUI;
let API_UnitExists = UnitExists;
let API_UnitIsDead = UnitIsDead;
let API_UnitCanAttack = UnitCanAttack;
let INFINITY = math.huge;
let MIN_REFRESH_TIME = 0.05;

interface Action {
    secure?: boolean;
    secureIcons: LuaArray<OvaleIcon>;
    icons: LuaArray<OvaleIcon>;
    spellId?:number;
    waitStart?:number;
    left?:number;
    top?:number;
    scale?: number;
    dx?: number;
    dy?: number;
}


class OvaleFrame extends AceGUI.WidgetContainerBase {
    checkBoxWidget: LuaObj<AceGUIWidgetCheckBox> = {}
    listWidget: LuaObj<AceGUIWidgetDropDown> = {}
        
    ToggleOptions() {
        if ((this.content.IsShown())) {
            this.content.Hide();
        } else {
            this.content.Show();
        }
    }
    
    Hide() {
        this.frame.Hide();
    }

    Show() {
        this.frame.Show();
    }

    OnAcquire() {
        this.frame.SetParent(UIParent);
    }

    OnRelease() {
    }

    OnWidthSet(width) {
        let content = this.content;
        let contentwidth = width - 34;
        if (contentwidth < 0) {
            contentwidth = 0;
        }
        content.SetWidth(contentwidth);
    }

    OnHeightSet(height) {
        let content = this.content;
        let contentheight = height - 57;
        if (contentheight < 0) {
            contentheight = 0;
        }
        content.SetHeight(contentheight);
    }

    OnLayoutFinished(width, height) {
        if ((!width)) {
            width = this.content.GetWidth();
        }
        this.content.SetWidth(width);
        this.content.SetHeight(height + 50);
    }
        
    // TODO need to be moved elsewhere
    // GetScore(spellId) {
    //     for (const [, action] of _pairs(this.actions)) {
    //         if (action.spellId == spellId) {
    //             if (!action.waitStart) {
    //                 return 1;
    //             } else {
    //                 let now = API_GetTime();
    //                 let lag = now - action.waitStart;
    //                 if (lag > 5) {
    //                     return undefined;
    //                 } else if (lag > 1.5) {
    //                     return 0;
    //                 } else if (lag > 0) {
    //                     return 1 - lag / 1.5;
    //                 } else {
    //                     return 1;
    //                 }
    //             }
    //         }
    //     }
    //     return 0;
    // }

    UpdateVisibility() {
        let visible = true;
        let profile = Ovale.db.profile;
        if (!profile.apparence.enableIcons) {
            visible = false;
        } else if (!this.hider.IsVisible()) {
            visible = false;
        } else {
            if (profile.apparence.hideVehicule && API_UnitHasVehicleUI("player")) {
                visible = false;
            }
            if (profile.apparence.avecCible && !API_UnitExists("target")) {
                visible = false;
            }
            if (profile.apparence.enCombat && !Ovale.inCombat) {
                visible = false;
            }
            if (profile.apparence.targetHostileOnly && (API_UnitIsDead("target") || !API_UnitCanAttack("player", "target"))) {
                visible = false;
            }
        }
        if (visible) {
            this.Show();
        } else {
            this.Hide();
        }
    }

    OnUpdate(elapsed) {
        let guid = OvaleGUID.UnitGUID("target") || OvaleGUID.UnitGUID("focus");
        if (guid) {
            Ovale.refreshNeeded[guid] = true;
        }
        this.timeSinceLastUpdate = this.timeSinceLastUpdate + elapsed;
        let refresh = OvaleDebug.trace || this.timeSinceLastUpdate > MIN_REFRESH_TIME && _next(Ovale.refreshNeeded);
        if (refresh) {
            Ovale.AddRefreshInterval(this.timeSinceLastUpdate * 1000);
            OvaleState.InitializeState();
            if (OvaleCompile.EvaluateScript()) {
                this.UpdateFrame();
            }
            const profile = Ovale.db.profile;
            let iconNodes = OvaleCompile.GetIconNodes();
            for (const [k, node] of _ipairs(iconNodes)) {
                if (node.namedParams && node.namedParams.target) {
                    baseState.defaultTarget = node.namedParams.target;
                } else {
                    baseState.defaultTarget = "target";
                }
                if (node.namedParams && node.namedParams.enemies) {
                    EnemiesState.enemies = node.namedParams.enemies;
                } else {
                    EnemiesState.enemies = undefined;
                }
                OvaleState.Log("+++ Icon %d", k);
                OvaleBestAction.StartNewAction();
                let atTime = futureState.nextCast;
                if (futureState.lastSpellId != futureState.lastGCDSpellId) {
                    atTime = baseState.currentTime;
                }
                let [timeSpan, element] = OvaleBestAction.GetAction(node, baseState, atTime);
                let start;
                if (element && element.offgcd) {
                    start = timeSpan.NextTime(baseState.currentTime);
                } else {
                    start = timeSpan.NextTime(atTime);
                }
                if (profile.apparence.enableIcons) {
                    this.UpdateActionIcon(baseState, node, this.actions[k], element, start);
                }
                if (profile.apparence.spellFlash.enabled && OvaleSpellFlash) {
                    OvaleSpellFlash.Flash(baseState, node, element, start);
                }
            }
            _wipe(Ovale.refreshNeeded);
            OvaleDebug.UpdateTrace();
            Ovale.PrintOneTimeMessages();
            this.timeSinceLastUpdate = 0;
        }
    }
    UpdateActionIcon(state: BaseState, node, action: Action, element, start, now?) {
        const profile = Ovale.db.profile;
        let icons = action.secure && action.secureIcons || action.icons;
        now = now || API_GetTime();
        if (element && element.type == "value") {
            let value;
            if (element.value && element.origin && element.rate) {
                value = element.value + (now - element.origin) * element.rate;
            }
            state.Log("GetAction: start=%s, value=%f", start, value);
            let actionTexture;
            if (node.namedParams && node.namedParams.texture) {
                actionTexture = node.namedParams.texture;
            }
            icons[1].SetValue(value, actionTexture);
            if (lualength(icons) > 1) {
                icons[2].Update(element, undefined);
            }
        } else {
            let [actionTexture, actionInRange, actionCooldownStart, actionCooldownDuration, actionUsable, actionShortcut, actionIsCurrent, actionEnable, actionType, actionId, actionTarget, actionResourceExtend] = OvaleBestAction.GetActionInfo(element, state, now);
            if (actionResourceExtend && actionResourceExtend > 0) {
                if (actionCooldownDuration > 0) {
                    state.Log("Extending cooldown of spell ID '%s' for primary resource by %fs.", actionId, actionResourceExtend);
                    actionCooldownDuration = actionCooldownDuration + actionResourceExtend;
                } else if (element.namedParams.pool_resource && element.namedParams.pool_resource == 1) {
                    state.Log("Delaying spell ID '%s' for primary resource by %fs.", actionId, actionResourceExtend);
                    start = start + actionResourceExtend;
                }
            }
            state.Log("GetAction: start=%s, id=%s", start, actionId);
            if (actionType == "spell" && actionId == futureState.currentSpellId && start && futureState.nextCast && start < futureState.nextCast) {
                start = futureState.nextCast;
            }
            if (start && node.namedParams.nocd && now < start - node.namedParams.nocd) {
                icons[1].Update(element, undefined);
            } else {
                icons[1].Update(element, start, actionTexture, actionInRange, actionCooldownStart, actionCooldownDuration, actionUsable, actionShortcut, actionIsCurrent, actionEnable, actionType, actionId, actionTarget, actionResourceExtend);
            }
            if (actionType == "spell") {
                action.spellId = actionId;
            } else {
                action.spellId = undefined;
            }
            if (start && start <= now && actionUsable) {
                action.waitStart = action.waitStart || now;
            } else {
                action.waitStart = undefined;
            }
            if (profile.apparence.moving && icons[1].cooldownStart && icons[1].cooldownEnd) {
                let top = 1 - (now - icons[1].cooldownStart) / (icons[1].cooldownEnd - icons[1].cooldownStart);
                if (top < 0) {
                    top = 0;
                } else if (top > 1) {
                    top = 1;
                }
                icons[1].SetPoint("TOPLEFT", this.frame, "TOPLEFT", (action.left + top * action.dx) / action.scale, (action.top - top * action.dy) / action.scale);
                if (icons[2]) {
                    icons[2].SetPoint("TOPLEFT", this.frame, "TOPLEFT", (action.left + (top + 1) * action.dx) / action.scale, (action.top - (top + 1) * action.dy) / action.scale);
                }
            }
            if ((node.namedParams.size != "small" && !node.namedParams.nocd && profile.apparence.predictif)) {
                if (start) {
                    state.Log("****Second icon %s", start);
                    futureState.ApplySpell(actionId, OvaleGUID.UnitGUID(actionTarget), start);
                    let atTime = futureState.nextCast;
                    if (actionId != futureState.lastGCDSpellId) {
                        atTime = state.currentTime;
                    }
                    let [timeSpan, nextElement] = OvaleBestAction.GetAction(node, state, atTime);
                    if (nextElement && nextElement.offgcd) {
                        start = timeSpan.NextTime(state.currentTime);
                    } else {
                        start = timeSpan.NextTime(atTime);
                    }
                    icons[2].Update(nextElement, start, OvaleBestAction.GetActionInfo(nextElement, state, start));
                } else {
                    icons[2].Update(element, undefined);
                }
            }
        }
    }
    UpdateFrame() {
        const profile = Ovale.db.profile;
        this.frame.SetPoint("CENTER", this.hider, "CENTER", profile.apparence.offsetX, profile.apparence.offsetY);
        this.frame.EnableMouse(!profile.apparence.clickThru);
        // this.frame.ReleaseChildren();
        this.UpdateIcons();
        this.UpdateControls();
        this.UpdateVisibility();
    }

    
    
    GetCheckBox(name: number|string) {
        let widget: AceGUIWidgetCheckBox;
        if (_type(name) == "string") {
            widget = this.checkBoxWidget[name];
        } else if (_type(name) == "number") {
            let k = 0;
            for (const [, frame] of _pairs(this.checkBoxWidget)) {
                if (k == name) {
                    widget = frame;
                    break;
                }
                k = k + 1;
            }
        }
        return widget;
    }
    IsChecked(name) {
        let widget = this.GetCheckBox(name);
        return widget && widget.GetValue();
    }
    GetListValue(name) {
        let widget = this.listWidget[name];
        return widget && widget.GetValue();
    }
    SetCheckBox(name, on) {
        let widget = this.GetCheckBox(name);
        if (widget) {
            let oldValue = widget.GetValue();
            if (oldValue != on) {
                widget.SetValue(on);
                this.OnCheckBoxValueChanged(widget);
            }
        }
    }
    ToggleCheckBox(name) {
        let widget = this.GetCheckBox(name);
        if (widget) {
            let on = !widget.GetValue();
            widget.SetValue(on);
            this.OnCheckBoxValueChanged(widget);
        }
    }

    OnCheckBoxValueChanged = (widget: AceGUIWidgetCheckBox) => {
        let name = widget.GetUserData<string>("name");
        Ovale.db.profile.check[name] = widget.GetValue();
        OvaleFrameModule.SendMessage("Ovale_CheckBoxValueChanged", name);
    }

    OnDropDownValueChanged = (widget: AceGUIWidgetCheckBox) => {
        let name = widget.GetUserData<string>("name");
        Ovale.db.profile.list[name] = widget.GetValue();
        OvaleFrameModule.SendMessage("Ovale_ListValueChanged", name);
    }
    FinalizeString(s) {
        let [item, id] = strmatch(s, "^(item:)(.+)");
        if (item) {
            s = API_GetItemInfo(id);
        }
        return s;
    }

    UpdateControls() {
        let profile = Ovale.db.profile;
        _wipe(this.checkBoxWidget);
        for (const [name, checkBox] of _pairs(checkBoxes)) {
            if (checkBox.text) {
                let widget = AceGUI.Create("CheckBox");
                let text = this.FinalizeString(checkBox.text);
                widget.SetLabel(text);
                if (profile.check[name] == undefined) {
                    profile.check[name] = checkBox.checked;
                }
                if (profile.check[name]) {
                    widget.SetValue(profile.check[name]);
                }
                widget.SetUserData("name", name);
                widget.SetCallback("OnValueChanged", this.OnCheckBoxValueChanged);
                this.AddChild(widget);
                this.checkBoxWidget[name] = widget;
            } else {
                Ovale.OneTimeMessage("Warning: checkbox '%s' is used but not defined.", name);
            }
        }
        _wipe(this.listWidget);
        for (const [name, list] of _pairs(lists)) {
            if (_next(list.items)) {
                let widget = AceGUI.Create("Dropdown");
                widget.SetList(list.items);
                if (!profile.list[name]) {
                    profile.list[name] = list.default;
                }
                if (profile.list[name]) {
                    widget.SetValue(profile.list[name]);
                }
                widget.SetUserData("name", name);
                widget.SetCallback("OnValueChanged", this.OnDropDownValueChanged);
                this.AddChild(widget);
                this.listWidget[name] = widget;
            } else {
                Ovale.OneTimeMessage("Warning: list '%s' is used but has no items.", name);
            }
        }
    }
    

    UpdateIcons() {
        for (const [, action] of _pairs(this.actions)) {
            for (const [, icon] of _pairs(action.icons)) {
                icon.Hide();
            }
            for (const [, icon] of _pairs(action.secureIcons)) {
                icon.Hide();
            }
        }
        const profile = Ovale.db.profile;
        this.frame.EnableMouse(!profile.apparence.clickThru);
        let left = 0;
        let maxHeight = 0;
        let maxWidth = 0;
        let top = 0;
        let BARRE = 8;
        let margin = profile.apparence.margin;
        let iconNodes = OvaleCompile.GetIconNodes();
        for (const [k, node] of _ipairs(iconNodes)) {
            if (!this.actions[k]) {
                this.actions[k] = {
                    icons: {
                    },
                    secureIcons: {
                    }
                }
            }
            let action = this.actions[k];
            let width, height, newScale;
            let nbIcons;
            if ((node.namedParams != undefined && node.namedParams.size == "small")) {
                newScale = profile.apparence.smallIconScale;
                width = newScale * 36 + margin;
                height = newScale * 36 + margin;
                nbIcons = 1;
            } else {
                newScale = profile.apparence.iconScale;
                width = newScale * 36 + margin;
                height = newScale * 36 + margin;
                if (profile.apparence.predictif && node.namedParams.type != "value") {
                    nbIcons = 2;
                } else {
                    nbIcons = 1;
                }
            }
            if ((top + height > profile.apparence.iconScale * 36 + margin)) {
                top = 0;
                left = maxWidth;
            }
            action.scale = newScale;
            if ((profile.apparence.vertical)) {
                action.left = top;
                action.top = -left - BARRE - margin;
                action.dx = width;
                action.dy = 0;
            } else {
                action.left = left;
                action.top = -top - BARRE - margin;
                action.dx = 0;
                action.dy = height;
            }
            action.secure = node.secure;
            for (let l = 1; l <= nbIcons; l += 1) {
                let icon: OvaleIcon;
                if (!node.secure) {
                    if (!action.icons[l]) {
                        action.icons[l] = new OvaleIcon(`Icon${k}n${l}`, this, false);
                    }
                    icon = action.icons[l];
                } else {
                    if (!action.secureIcons[l]) {
                        action.secureIcons[l] = new OvaleIcon(`SecureIcon${k}n${l}`, this, true);
                    }
                    icon = action.secureIcons[l];
                }
                let scale = action.scale;
                if (l > 1) {
                    scale = scale * profile.apparence.secondIconScale;
                }
                icon.SetPoint("TOPLEFT", this.frame, "TOPLEFT", (action.left + (l - 1) * action.dx) / scale, (action.top - (l - 1) * action.dy) / scale);
                icon.SetScale(scale);
                icon.SetRemainsFont(profile.apparence.remainsFontColor);
                icon.SetFontScale(profile.apparence.fontScale);
                icon.SetParams(node.positionalParams, node.namedParams);
                icon.SetHelp((node.namedParams != undefined && node.namedParams.help) || undefined);
                icon.SetRangeIndicator(profile.apparence.targetText);
                icon.EnableMouse(!profile.apparence.clickThru);
                icon.cdShown = (l == 1);
                if (Masque) {
                    this.skinGroup.AddButton(icon.frame);
                }
                if (l == 1) {
                    icon.Show();
                }
            }
            top = top + height;
            if ((top > maxHeight)) {
                maxHeight = top;
            }
            if ((left + width > maxWidth)) {
                maxWidth = left + width;
            }
        }
        if ((profile.apparence.vertical)) {
            this.barre.SetWidth(maxHeight - margin);
            this.barre.SetHeight(BARRE);
            this.frame.SetWidth(maxHeight + profile.apparence.iconShiftY);
            this.frame.SetHeight(maxWidth + BARRE + margin + profile.apparence.iconShiftX);
            this.content.SetPoint("TOPLEFT", this.frame, "TOPLEFT", maxHeight + profile.apparence.iconShiftX, profile.apparence.iconShiftY);
        } else {
            this.barre.SetWidth(maxWidth - margin);
            this.barre.SetHeight(BARRE);
            this.frame.SetWidth(maxWidth);
            this.frame.SetHeight(maxHeight + BARRE + margin);
            this.content.SetPoint("TOPLEFT", this.frame, "TOPLEFT", maxWidth + profile.apparence.iconShiftX, profile.apparence.iconShiftY);
        }
    }

    type = "Frame";
 //   frame: UIFrame;
    localstatus = {}
    actions: LuaArray<Action> = {}
    hider: UIFrame;
    updateFrame: UIFrame;
   // content: UIFrame;
    timeSinceLastUpdate: number;
    barre: UITexture;
    skinGroup: MasqueSkinGroup;

    constructor() {
        super();
        let hider = API_CreateFrame("Frame", `${Ovale.GetName()}PetBattleFrameHider`, UIParent, "SecureHandlerStateTemplate");
        let frame = API_CreateFrame("Frame", undefined, hider);
        hider.SetAllPoints(UIParent);
        API_RegisterStateDriver(hider, "visibility", "[petbattle] hide; show");
        
        const profile = Ovale.db.profile;
        
        this.frame = frame;
        this.hider = hider;
        this.updateFrame = API_CreateFrame("Frame", `${Ovale.GetName()}UpdateFrame`);
        this.barre = this.frame.CreateTexture();
        this.content = API_CreateFrame("Frame", undefined, this.updateFrame);
        if (Masque) {
            this.skinGroup = Masque.Group(Ovale.GetName());
        }
        this.timeSinceLastUpdate = INFINITY;
        frame.SetWidth(100);
        frame.SetHeight(100);
        this.UpdateFrame();
        frame.SetMovable(true);
        frame.SetFrameStrata("MEDIUM");
        frame.SetScript("OnMouseDown", () => {
            if ((!Ovale.db.profile.apparence.verrouille)) {
                frame.StartMoving();
                AceGUI.ClearFocus();
            }
        });
        frame.SetScript("OnMouseUp", () => {
            frame.StopMovingOrSizing();
            const profile = Ovale.db.profile;
            let [x, y] = frame.GetCenter();
            let [parentX, parentY] = frame.GetParent().GetCenter();
            profile.apparence.offsetX = x - parentX;
            profile.apparence.offsetY = y - parentY;
        });
        frame.SetScript("OnEnter", () => {
            const profile = Ovale.db.profile;
            if (!(profile.apparence.enableIcons && profile.apparence.verrouille)) {
                this.barre.Show();
            }
        });
        frame.SetScript("OnLeave", () => {
            this.barre.Hide();
        });
        frame.SetScript("OnHide", () => this.Hide());
        frame.SetAlpha(profile.apparence.alpha);
        this.updateFrame.SetScript("OnUpdate", (updateFrame, elapsed) => this.OnUpdate(elapsed));
        this.barre.SetTexture(0, 0.8, 0);
        this.barre.SetPoint("TOPLEFT", 0, 0);
        this.barre.Hide();
        let content = this.content;
        content.SetWidth(200);
        content.SetHeight(100);
        content.Hide();
        content.SetAlpha(profile.apparence.optionsAlpha);        
        AceGUIRegisterAsContainer(this)
    }
}

export const frame = new OvaleFrame();

const OvaleFrameBase = Ovale.NewModule("OvaleFrame", "AceEvent-3.0");
class OvaleFrameModuleClass extends OvaleFrameBase {
    
    Ovale_OptionChanged(event, eventType) {
        if (eventType == "visibility") {
            frame.UpdateVisibility();
        }
        else {
            if (eventType == "layout") {
                frame.UpdateFrame(); // TODO
            }
            frame.UpdateFrame();
        }    
    }

    PLAYER_TARGET_CHANGED() {
        frame.UpdateVisibility();
    }
    Ovale_CombatStarted(event, atTime) {
        frame.UpdateVisibility();
    }
    Ovale_CombatEnded(event, atTime) {
        frame.UpdateVisibility();
    }
    
    constructor(){
        super();
        this.RegisterMessage("Ovale_OptionChanged");
        this.RegisterMessage("Ovale_CombatStarted");
        this.RegisterEvent("PLAYER_TARGET_CHANGED");
    }
}

export const OvaleFrameModule = new OvaleFrameModuleClass();