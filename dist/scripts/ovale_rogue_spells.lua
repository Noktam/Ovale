local __exports = LibStub:NewLibrary("ovale/scripts/ovale_rogue_spells", 10000)
if not __exports then return end
local __Scripts = LibStub:GetLibrary("ovale/Scripts")
local OvaleScripts = __Scripts.OvaleScripts
__exports.register = function()
    local name = "ovale_rogue_spells"
    local desc = "[7.0] Ovale: Rogue spells"
    local code = [[
# Rogue spells and functions.

# Items
Define(bleeding_hollow_toxin_vessel 124520)
Define(denial_of_the_halfgiants 137100)
Define(duskwalkers_footpads 137030)
Define(greenskins_waterlogged_wristcuffs 137099)
Define(greenskins_waterlogged_wristcuffs_buff 209423)
Define(insignia_of_ravenholdt 137049)
Define(mantle_of_the_master_assassin 144236)
	Define(master_assassins_initiative 235022)
		SpellInfo(master_assassins_initiative duration=6)
Define(the_dreadlords_deceit 137021)
Define(the_dreadlords_deceit_buff 208692)
Define(thraxis_tricksy_treads 137031)
Define(shadow_satyrs_walk 137032)
Define(shivarran_symmetry 141321)

# Learned spells.
Define(blindside 121152)
	SpellInfo(blindside learn=1 level=40 specialization=assassination)

Define(adrenaline_rush 13750)
	SpellInfo(adrenaline_rush cd=180 gcd=0)
	SpellInfo(adrenaline_rush buff_cdr=cooldown_reduction_agility_buff)
	SpellAddBuff(adrenaline_rush adrenaline_rush_aura=1)
Define(adrenaline_rush_aura 13750)
	SpellInfo(adrenaline_rush_aura duration=15)
Define(adrenaline_rush_t20_aura 246558)
	SpellInfo(adrenaline_rush_t20_aura duration=8)
SpellList(adrenaline_rush_buff adrenaline_rush_aura adrenaline_rush_t20_aura)
Define(alacrity_buff 193538)
Define(alacrity_talent 17)
Define(ambush 8676)
	SpellInfo(ambush combopoints=-2 energy=60 stealthed=1)
Define(anticipation 114015)
Define(anticipation_talent 8)
Define(backstab 53)
	SpellInfo(backstab combopoints=-1 energy=35)
Define(bag_of_tricks 192657)
Define(between_the_eyes 199804)
	SpellInfo(between_the_eyes combopoints=1 max_combopoints=5 energy=35 cd=20)
Define(blade_flurry 13877)
	SpellInfo(blade_flurry cd=10 gcd=0 offgcd=1)
	SpellAddBuff(blade_flurry blade_flurry_buff=toggle)
Define(blade_flurry_buff 13877)
Define(blunderbuss_buff 202895)
Define(broadsides_buff 193356)
Define(cannonball_barrage 185767)
	SpellInfo(cannonball_barrage cd=60)
Define(cheap_shot 1833)
	SpellInfo(cheap_shot combopoints=-2 energy=40 interrupt=1)
Define(crippling_poison 3408)
	SpellAddBuff(crippling_poison crippling_poison_buff=1)
Define(crippling_poison_buff 3408)
	SpellInfo(crippling_poison_buff duration=3600)
Define(curse_of_the_dreadblades 202665)
	SpellInfo(curse_of_the_dreadblades cd=90 tag=cd)
Define(curse_of_the_dreadblades_buff 202665)
Define(deadly_poison 2823)
	SpellAddBuff(deadly_poison deadly_poison_buff=1)
Define(deadly_poison_buff 2823)
	SpellInfo(deadly_poison_buff duration=3600)
Define(deadly_poison_dot_debuff 2818)
	SpellInfo(deadly_poison_dot_debuff duration=12 tick=3)
Define(death_from_above 152150)
	SpellInfo(death_from_above combopoints=1 max_combopoints=5 energy=25)
	SpellAddBuff(death_from_above envenom_buff=1 specialization=assassination)
	SpellAddBuff(death_from_above surge_of_toxins_debuff=1 trait=surge_of_toxins)
Define(death_from_above_buff 152150)
Define(death_from_above_talent 21)
Define(deceit_buff 166878) #TODO
	SpellInfo(deceit_buff duration=10)
Define(deeper_stratagem_talent 7)
Define(elaborate_planning_buff 193640)
	SpellInfo(elaborate_planning_buff duration=5)
Define(envenom 32645)
	SpellInfo(envenom combopoints=1 max_combopoints=5 energy=35)
	SpellAddBuff(envenom envenom_buff=1)
	SpellAddBuff(envenom surge_of_toxins_debuff=1 trait=surge_of_toxins)
Define(envenom_buff 32645)
	SpellInfo(envenom_buff duration=1 add_duration_combopoints=1 tick=1)
Define(eviscerate 196819)
	SpellInfo(eviscerate combopoints=1 max_combopoints=5 energy=35)
	SpellRequire(eviscerate energy_percent 0=buff,goremaws_bite_buff)
Define(exsanguinate 200806)
	SpellInfo(exsanguinate cd=45 tag=main)
	SpellAddTargetDebuff(exsanguinate rupture_debuff_exsanguinated=1 if_target_debuff=rupture_debuff) #TODO if_target_debuff is not implemented here
	SpellAddTargetDebuff(exsanguinate garrote_debuff_exsanguinated=1 if_target_debuff=garrote_debuff)
Define(exsanguinate_talent 18)
SpellList(exsanguinated rupture_debuff_exsanguinated garrote_debuff_exsanguinated)
Define(fan_of_knives 51723)
	SpellInfo(fan_of_knives combopoints=-1 energy=35)
Define(faster_than_light_trigger_buff 197270) #Remove?
Define(feeding_frenzy_buff 242705)
Define(finality 197406)
Define(finality_eviscerate_buff 197496)
Define(finality_nightblade_buff 197498)
Define(find_weakness 91023)
Define(find_weakness_debuff 91021)
	SpellInfo(find_weakness_debuff duration=10)
Define(garrote 703)
	SpellInfo(garrote cd=15 combopoints=-1 energy=45)
	SpellInfo(garrote add_cd=-12 add_energy=-20 itemset=T20 itemcount=4)
	SpellAddTargetDebuff(garrote garrote_debuff=1)
Define(garrote_debuff 703)
	SpellInfo(garrote_debuff duration=18 tick=2)
Define(garrote_debuff_exsanguinated -703) #TODO negative number for hidden auras?
	SpellInfo(garrote_debuff_exsanguinated duration=garrote_debuff) #TODO use an aura as a duration to mirror the duration
Define(ghostly_strike 196937)
	SpellInfo(ghostly_strike combopoints=-1 energy=30)
	SpellAddTargetDebuff(ghostly_strike ghostly_strike_debuff=1)
Define(ghostly_strike_debuff 196937)
	SpellInfo(ghostly_strike_debuff duration=15)
Define(ghostly_strike_talent 1)
Define(gloomblade 200758)
	SpellInfo(gloomblade combopoints=-1 energy=35)
	SpellInfo(gloomblade replace=backstab talent=gloomblade_talent)
Define(goremaws_bite 209782)
	SpellInfo(goremaws_bite cd=60 combopoints=-3)
	SpellAddBuff(goremaws_bite goremaws_bite_buff=1)
Define(goremaws_bite_buff 242705)
Define(gouge 1776)
	SpellInfo(gouge combopoints=-1 cd=10 energy=25 tag=main)
	SpellInfo(gouge combopoints=-1 cd=10 energy=0 talent=dirty_tricks_talent)
Define(hemorrhage 16511)
	SpellInfo(hemorrhage combopoints=-1 energy=30)
	SpellAddTargetDebuff(hemorrhage hemorrhage_debuff=1)
Define(hemorrhage_debuff 16511)
	SpellInfo(hemorrhage_debuff duration=20)
Define(hemorrhage_talent 3)
Define(hidden_blade_buff 202754)
Define(internal_bleeding 154904)
Define(internal_bleeding_talent 15)
Define(internal_bleeding_debuff 154953)
	SpellInfo(internal_bleeding_debuff duration=12 tick=2)
Define(kick 1766)
	SpellInfo(kick cd=15 gcd=0 interrupt=1 offgcd=1)
Define(kidney_shot 408)
	SpellInfo(kidney_shot cd=20 combopoints=1 max_combopoints=5 energy=25 interrupt=1)
	SpellAddTargetDebuff(kidney_shot internal_bleeding_debuff=1 if_spell=internal_bleeding)
	SpellAddBuff(kidney_shot surge_of_toxins_debuff=1 trait=surge_of_toxins)
Define(killing_spree 51690)
	SpellInfo(killing_spree cd=120)
	SpellAddBuff(killing_spree killing_spree_buff=1)
Define(killing_spree_buff 51690)
	SpellInfo(killing_spree_buff duration=3)
Define(kingsbane 192759)
	SpellAddTargetDebuff(kingsbane kingsbane_debuff=1)
Define(kingsbane_debuff 192759)
	SpellInfo(kingsbane_debuff duration=14)
Define(leeching_poison 108211)
	SpellAddBuff(leeching_poison leeching_poison_buff=1)
Define(leeching_poison_buff 108211)
	SpellInfo(leeching_poison_buff duration=3600)
SpellList(lethal_poison_buff deadly_poison_buff wound_poison_buff)
Define(marked_for_death 137619)
	SpellInfo(marked_for_death cd=60 combopoints=-6 gcd=0 offgcd=1)
Define(marked_for_death_talent 20)
Define(master_assassin 192349)
Define(master_of_shadows_talent 19)
Define(master_of_subtlety_buff 31665)
Define(mutilate 1329)
	SpellInfo(mutilate combopoints=-2 energy=55)
Define(mutilated_flesh_debuff 211672) #Remove?
Define(nightblade 195452)
	SpellInfo(nightblade energy=25 combopoints=1 max_combopoints=5)
	SpellAddTargetDebuff(nightblade nightblade_debuff=1)
	SpellRequire(nightblade energy_percent 0=buff,goremaws_bite_buff)
Define(nightblade_debuff 195452)
	SpellInfo(nightblade_debuff duration=6 add_duration_combopoints=2 tick=2)
Define(nightstalker_talent 4)
SpellList(non_lethal_poison_buff crippling_poison_buff leeching_poison_buff)
Define(opportunity_buff 195627)
	SpellInfo(opportunity_buff duration=10)
Define(pistol_shot 185763)
	SpellInfo(pistol_shot combopoints=-1 energy=40)
	SpellAddBuff(pistol_shot opportunity_buff=-1)
	SpellRequire(pistol_shot energy_percent 0=buff,opportunity_buff)
Define(quick_draw_talent 3)
Define(roll_the_bones 193316)
	SpellInfo(roll_the_bones energy=25 combopoints=1 max_combopoints=5)

	Define(grand_melee_buff 193358)
		SpellInfo(grand_melee_buff duration=12 add_duration_combopoints=6)
	Define(jolly_roger_buff 199603)
		SpellInfo(grand_melee_buff duration=12 add_duration_combopoints=6)
	Define(true_bearing_buff 193359)
		SpellInfo(true_bearing_buff duration=12 add_duration_combopoints=6)
	Define(buried_treasure_buff 199600)
		SpellInfo(buried_treasure_buff duration=12 add_duration_combopoints=6)
	Define(broadside_buff 193356)
		SpellInfo(broadside_buff duration=12 add_duration_combopoints=6)
	Define(shark_infested_waters_buff 193357)
		SpellInfo(shark_infested_waters_buff duration=12 add_duration_combopoints=6)
	SpellList(roll_the_bones_buff grand_melee_buff broadside_buff jolly_roger_buff shark_infested_waters_buff true_bearing_buff buried_treasure_buff)

Define(run_through 2098)
	SpellInfo(run_through energy=35 combopoints=1 max_combopoints=5)
Define(rupture 1943)
	SpellInfo(rupture combopoints=1 max_combopoints=5 energy=25)
	SpellAddTargetDebuff(rupture rupture_debuff=1)
	SpellAddBuff(rupture surge_of_toxins_debuff=1 trait=surge_of_toxins)
Define(rupture_debuff 1943)
	SpellInfo(rupture_debuff add_duration_combopoints=4 duration=4 tick=2)
Define(rupture_debuff_exsanguinated -1943)
	SpellInfo(rupture_debuff_exsanguinated duration=rupture_debuff)
Define(saber_slash 193315)
	SpellInfo(saber_slash combopoints=-1 energy=50)
Define(shadow_blades 121471)
	SpellInfo(shadow_blades cd=180)
	SpellAddBuff(shadow_blades shadow_blades_buff=1)
Define(shadow_blades_buff 121471)
	SpellInfo(shadow_blades_buff duration=15)
Define(shadow_dance 185313)
	SpellInfo(shadow_dance cd=60 gcd=0)
	SpellInfo(shadow_dance energy=-60 itemset=T17 itemcount=2 specialization=subtlety)
	SpellInfo(shadow_dance buff_cdr=cooldown_reduction_agility_buff)
	SpellAddBuff(shadow_dance shadow_dance_buff=1)
Define(shadow_dance_buff 185422)
	SpellInfo(shadow_dance_buff duration=4)
Define(shadow_focus 108209)
Define(shadow_focus_talent 6)
	SpellRequire(ambush energy_percent 75=buff,stealthed_buff talent=shadow_focus_talent specialization=subtlety)
	SpellRequire(ambush energy_percent 25=buff,stealthed_buff talent=shadow_focus_talent specialization=assassination)
	SpellRequire(backstab energy_percent 75=buff,stealthed_buff talent=shadow_focus_talent specialization=subtlety)
	SpellRequire(cheap_shot energy_percent 75=buff,stealthed_buff talent=shadow_focus_talent specialization=subtlety)
	SpellRequire(cheap_shot energy_percent 25=buff,stealthed_buff talent=shadow_focus_talent specialization=assassination)
	SpellRequire(death_from_above energy_percent 75=buff,stealthed_buff talent=shadow_focus_talent specialization=subtlety)
	SpellRequire(death_from_above energy_percent 25=buff,stealthed_buff talent=shadow_focus_talent specialization=assassination)
	SpellRequire(eviscerate energy_percent 75=buff,stealthed_buff talent=shadow_focus_talent specialization=subtlety)
	SpellRequire(fan_of_knives energy_percent 25=buff,stealthed_buff talent=shadow_focus_talent specialization=assassination)
	SpellRequire(hemorrhage energy_percent 25=buff,stealthed_buff talent=shadow_focus_talent specialization=assassination)
	SpellRequire(kidney_shot energy_percent 75=buff,stealthed_buff talent=shadow_focus_talent specialization=subtlety)
	SpellRequire(kidney_shot energy_percent 25=buff,stealthed_buff talent=shadow_focus_talent specialization=assassination)
	SpellRequire(mutilate energy_percent 25=buff,stealthed_buff talent=shadow_focus_talent specialization=assassination)
	SpellRequire(rupture energy_percent 25=buff,stealthed_buff talent=shadow_focus_talent specialization=assassination)
	SpellRequire(shiv energy_percent 75=buff,stealthed_buff talent=shadow_focus_talent specialization=subtlety)
	SpellRequire(shiv energy_percent 25=buff,stealthed_buff talent=shadow_focus_talent specialization=assassination)
	SpellRequire(shuriken_toss energy_percent 75=buff,stealthed_buff talent=shadow_focus_talent specialization=subtlety)
Define(shadowstep 36554)
	SpellInfo(shadowstep cd=30 gcd=0 offgcd=1)
Define(shadowstrike 185438)
	SpellInfo(shadowstrike combopoints=-2 energy=40 stealthed=1)
Define(shiv 5938)
	SpellInfo(shiv cd=10 energy=20)
Define(shuriken_storm 197835)
	SpellInfo(shuriken_storm energy=35 combopoints=-1)
Define(shuriken_toss 114014)
	SpellInfo(shuriken_toss combopoints=-1 energy=40 travel_time=1)
	SpellInfo(shuriken_toss buff_energy=silent_blades_buff buff_energy_amount=-6 itemset=T16_melee itemcount=2 specialization=assassination)
	SpellAddBuff(shuriken_toss silent_blades_buff=0 itemset=T16_melee itemcount=2)
Define(silent_blades_buff 145193)
	SpellInfo(silent_blades_buff duration=30 stacking=1)
Define(sinister_circulation 238138)
Define(sinister_strike 1752)
	SpellInfo(sinister_strike combopoints=-1 energy=50)
	SpellInfo(sinister_strike buff_energy=silent_blades_buff buff_energy_amount=-15 itemset=T16_melee itemcount=2 specialization=combat)
	SpellAddBuff(sinister_strike bandits_guile_buff=1 if_spell=bandits_guile)
	SpellAddBuff(sinister_strike silent_blades_buff=0 itemset=T16_melee itemcount=2)
Define(sleight_of_hand_buff 145211)
	SpellInfo(sleight_of_hand_buff duration=10)
Define(slice_and_dice 5171)
	SpellInfo(slice_and_dice combopoints=1 max_combopoints=5 energy=25)
	SpellAddBuff(slice_and_dice slice_and_dice_buff=1)
	SpellInfo(slice_and_dice replace=roll_the_bones talent=slice_and_dice_talent)
Define(slice_and_dice_buff 5171)
	SpellInfo(slice_and_dice add_duration_combopoints=6 duration=6 tick=3)
	#SpellInfo(roll_the_bones unusable=1 talent=slice_and_dice_talent)
Define(slice_and_dice_talent 19)
Define(sprint 2983)
	SpellInfo(sprint cd=60)
	SpellAddBuff(sprint sprint_buff=1)
Define(sprint_buff 2983)
	SpellInfo(sprint_buff duration=8)
Define(stealth 1784)
	SpellInfo(stealth cd=6 to_stance=rogue_stealth)
	SpellRequire(stealth unusable 1=stealthed,1)
	SpellRequire(stealth unusable 1=combat,1)
	SpellAddBuff(stealth stealth_buff=1)
Define(stealth_buff 1784)
Define(subterfuge 108208)
Define(subterfuge_buff 115192)
	SpellInfo(subterfuge_buff duration=3)
Define(subterfuge_talent 5)
Define(surge_of_toxins 192424)
Define(surge_of_toxins_debuff 192425)
	SpellInfo(surge_of_toxins_debuff duration=5)
Define(symbols_of_death 212283)
	SpellInfo(symbols_of_death cd=30 energy=35 tag=shortcd)
	SpellAddBuff(symbols_of_death symbols_of_death_buff=1)
	SpellAddBuff(symbols_of_death death_buff=1)
Define(symbols_of_death_buff 212283)
	SpellInfo(symbols_of_death_buff duration=35)
Define(the_first_of_the_dead 151818)
Define(the_first_of_the_dead_buff 248210)
Define(t18_class_trinket 124520)
Define(toxic_blade 245388)
	SpellInfo(toxic_blade energy=20 cd=25 combopoints=-1 tag=main)
	SpellAddTargetDebuff(toxic_blade toxic_blade_debuff=1)
Define(toxic_blade_debuff 245389)
	SpellInfo(toxic_blade_debuff duration=9)
Define(urge_to_kill 192384)
Define(vanish 1856)
	SpellInfo(vanish cd=120 gcd=0)
	SpellAddBuff(vanish vanish_aura=1 if_spell=!subterfuge)
	SpellAddBuff(vanish vanish_subterfuge_buff=1 if_spell=subterfuge)
	SpellRequire(vanish unusable 1=stealthed,1)
Define(vanish_aura 11327)
	SpellInfo(vanish_aura duration=3)
Define(vanish_buff 1856)
Define(vanish_subterfuge_buff 115193)
	SpellInfo(vanish_subterfuge_buff duration=3)
SpellList(vanish_buff vanish_aura vanish_subterfuge_buff)
Define(vendetta 79140)
	SpellInfo(vendetta cd=120)
	SpellAddTargetDebuff(vendetta vendetta_debuff=1)
Define(vendetta_debuff 79140)
	SpellInfo(vendetta_debuff duration=20)
Define(wound_poison 8679)
	SpellAddBuff(wound_poison wound_poison_buff=1)
Define(wound_poison_buff 8679)
	SpellInfo(wound_poison_buff duration=3600)

# Talents
Define(dark_shadow_talent 16)
Define(deeper_strategem_talent 7)
Define(dirty_tricks_talent 15)
Define(elaborate_planning_talent 2)
Define(enveloping_shadows_talent 18)
Define(master_poisoner_talent 1)
Define(venom_rush_talent 19)
Define(vigor_talent 9)
Define(gloomblade_talent 3)

#Artifact traits
Define(loaded_dice_buff 240837)

#Legendaries
Define(the_first_of_the_dead 151818)

# Non-default tags for OvaleSimulationCraft.
	SpellInfo(vanish tag=shortcd)
	SpellInfo(goremaws_bite tag=main)
]]
    OvaleScripts:RegisterScript("ROGUE", nil, name, desc, code, "include")
end
