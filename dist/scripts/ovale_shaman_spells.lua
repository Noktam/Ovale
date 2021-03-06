local __exports = LibStub:NewLibrary("ovale/scripts/ovale_shaman_spells", 80000)
if not __exports then return end
local __Scripts = LibStub:GetLibrary("ovale/Scripts")
local OvaleScripts = __Scripts.OvaleScripts
__exports.register = function()
    local name = "ovale_shaman_spells"
    local desc = "[8.1] Ovale: Shaman spells"
    local code = [[Define(ancestral_call 274738)
# Invoke the spirits of your ancestors, granting you their power for 15 seconds.
  SpellInfo(ancestral_call cd=120 duration=15 gcd=0 offgcd=1)
  SpellAddBuff(ancestral_call ancestral_call=1)
Define(battle_potion_of_agility 279152)
# Increases your Agility by s1 for 25 seconds.
  SpellInfo(battle_potion_of_agility cd=1 duration=25 gcd=0 offgcd=1)
  # Agility increased by w1.
  SpellAddBuff(battle_potion_of_agility battle_potion_of_agility=1)
Define(battle_potion_of_intellect 279151)
# Increases your Intellect by s1 for 25 seconds.
  SpellInfo(battle_potion_of_intellect cd=1 duration=25 gcd=0 offgcd=1)
  # Intellect increased by w1.
  SpellAddBuff(battle_potion_of_intellect battle_potion_of_intellect=1)
Define(berserking 26297)
# Increases your haste by s1 for 12 seconds.
  SpellInfo(berserking cd=180 duration=12 gcd=0 offgcd=1)
  # Haste increased by s1.
  SpellAddBuff(berserking berserking=1)
Define(bloodlust 2825)
# Increases Haste by (25 of Spell Power) for all party and raid members for 40 seconds.rnrnAllies receiving this effect will become Sated and unable to benefit from Bloodlust or Time Warp again for 600 seconds.
  SpellInfo(bloodlust cd=300 duration=40 channel=40 gcd=0 offgcd=1)
  # Haste increased by s1.
  SpellAddBuff(bloodlust bloodlust=1)
Define(capacitor_totem 192058)
# Summons a totem at the target location that gathers electrical energy from the surrounding air and explodes after s2 sec, stunning all enemies within 118905A1 yards for 3 seconds.
  SpellInfo(capacitor_totem cd=60 duration=3 gcd=1)
Define(chain_lightning_elemental 188443)
# Hurls a lightning bolt at the enemy, dealing (34.5 of Spell Power) Nature damage and then jumping to additional nearby enemies. Affects x1 total targets.rnrn|cFFFFFFFFGenerates s2 Maelstrom per target hit.|r 
  SpellInfo(chain_lightning_elemental)
Define(crash_lightning 187874)
# Electrocutes all enemies in front of you, dealing s1*<CAP>/AP Nature damage. Hitting 2 or more targets enhances your weapons for 10 seconds, causing Stormstrike and Lava Lash to also deal 195592s1*<CAP>/AP Nature damage to all targets in front of you.  rnrnEach target hit by Crash Lightning increases the damage of your next Stormstrike by s2.
  SpellInfo(crash_lightning maelstrom=20 cd=6)
Define(earth_elemental 198103)
# Calls forth a Greater Earth Elemental to protect you and your allies for 60 seconds.
  SpellInfo(earth_elemental cd=300)
Define(earth_shock 8042)
# Instantly shocks the target with concussive force, causing (210 of Spell Power) Nature damage.
  SpellInfo(earth_shock maelstrom=60)
Define(earthen_spike 188089)
# Summons an Earthen Spike under an enemy, dealing s1 Physical damage and increasing Physical and Nature damage you deal to the target by s2 for 10 seconds.
  SpellInfo(earthen_spike maelstrom=20 cd=20 duration=10 talent=earthen_spike_talent)
  # Suffering s2 increased Nature and Physical damage from the Shaman.
  SpellAddTargetDebuff(earthen_spike earthen_spike=1)
Define(earthquake 61882)
# Causes the earth within a1 yards of the target location to tremble and break, dealing <damage> Physical damage over 6 seconds and sometimes knocking down enemies.
  SpellInfo(earthquake maelstrom=60 duration=6 tick=1)
  SpellAddBuff(earthquake earthquake=1)
Define(elemental_blast 117014)
# Harnesses the raw power of the elements, dealing (63 of Spell Power) Elemental damage and increasing your Critical Strike, Haste, or Mastery by 118522s1 for 10 seconds.rnrnCan cause an Elemental Overload?PL<78[ when at or above level 78][].
  SpellInfo(elemental_blast cd=12 talent=elemental_blast_talent)
Define(feral_lunge 196884)
# Lunge at your enemy as a ghostly wolf, biting them to deal 215802s1 Physical damage.
  SpellInfo(feral_lunge cd=30 gcd=0.5 talent=feral_lunge_talent)

Define(feral_spirit 51533)
# Summons two Spirit ?s147783[Raptors][Wolves] that aid you in battle for 15 seconds. They are immune to movement-impairing effects?a231723[ and grant you 190185s1 Maelstrom each time they attack][].
# Rank 2: Feral Spirits grant you 190185s1 Maelstrom each time they attack.
  SpellInfo(feral_spirit cd=120)
Define(fire_elemental 198067)
# Calls forth a Greater Fire Elemental to rain destruction on your enemies for 30 seconds.rnrnWhile the Greater Fire Elemental is active, Flame Shock generates 263819s1 Maelstrom when it deals damage over time.
  SpellInfo(fire_elemental cd=150)
Define(fireblood 265221)
# Removes all poison, disease, curse, magic, and bleed effects and increases your ?a162700[Agility]?a162702[Strength]?a162697[Agility]?a162698[Strength]?a162699[Intellect]?a162701[Intellect][primary stat] by 265226s1*3 and an additional 265226s1 for each effect removed. Lasts 8 seconds. 
  SpellInfo(fireblood cd=120 gcd=0 offgcd=1)
Define(flame_shock 188389)
# Sears the target with fire, causing (35 of Spell Power) Fire damage and then an additional o2 Fire damage over 24 seconds.
  SpellInfo(flame_shock cd=6 duration=24 tick=2)
  # Suffering w2 Fire damage every t2 sec.
  SpellAddTargetDebuff(flame_shock flame_shock=1)
Define(flametongue 193796)
# Scorches your target, dealing s2 Fire damage, and enhances your weapons with fire for 16 seconds, causing each weapon attack to deal up to <coeff>*AP Fire damage.
  SpellInfo(flametongue cd=12)
  # Each of your weapon attacks causes up to <coeff>*AP additional Fire damage.
  SpellAddBuff(flametongue flametongue_buff=1)
Define(flametongue_buff 194084)
# Scorches your target, dealing s2 Fire damage, and enhances your weapons with fire for 16 seconds, causing each weapon attack to deal up to <coeff>*AP Fire damage.
  SpellInfo(flametongue_buff duration=16 gcd=0 offgcd=1 tick=8)
  # Each of your weapon attacks causes up to <coeff>*AP additional Fire damage.
  SpellAddBuff(flametongue_buff flametongue_buff=1)
Define(frost_shock 196840)
# Chills the target with frost, causing (45 of Spell Power) Frost damage and reducing the target's movement speed by s2 for 6 seconds. 
  SpellInfo(frost_shock duration=6)
  # Movement speed reduced by s2.
  SpellAddTargetDebuff(frost_shock frost_shock=1)
Define(frostbrand 196834)
# Chills your target, dealing s1 Frost damage and applying Frostbrand to them, reducing their movement speed by 147732s1 for 3 seconds. Enhances your weapons for 16 seconds, causing your attacks to apply Frostbrand.
  SpellInfo(frostbrand maelstrom=20 duration=16 tick=5)
  # Melee attacks reduce target's movement speed by 147732s1 for 147732d.
  SpellAddBuff(frostbrand frostbrand=1)

Define(fury_of_air 197211)
# Creates a vortex of wind 197385A1 yards around you, dealing 197385s1*<CAP>/AP Nature damage every t1 sec to enemies caught in the storm, and slowing them by 197385s2 for 3 seconds.
  SpellInfo(fury_of_air maelstrom=3 tick=1 talent=fury_of_air_talent)

Define(heroism 32182)
# Increases haste by (25 of Spell Power) for all party and raid members for 40 seconds.rnrnAllies receiving this effect will become Exhausted and unable to benefit from Heroism or Time Warp again for 600 seconds.
  SpellInfo(heroism cd=300 duration=40 channel=40 gcd=0 offgcd=1)
  # Haste increased by s1.
  SpellAddBuff(heroism heroism=1)
Define(hex 51514)
# Transforms the enemy into a frog for 60 seconds. While hexed, the victim is incapacitated, and cannot attack or cast spells. Damage may cancel the effect. Limit 1. Only works on Humanoids and Beasts.
  SpellInfo(hex cd=30 duration=60 channel=60)
  # Incapacitated.
  SpellAddTargetDebuff(hex hex=1)
Define(hot_hand_buff 215785)
# Melee attacks with Flametongue active have a chance to make your next Lava Lash cost no Maelstrom and deal 215785s1 increased damage.
  SpellInfo(hot_hand_buff duration=15 gcd=0 offgcd=1)
  # Lava Lash damage increased by s1 and cost reduced by s2.
  SpellAddBuff(hot_hand_buff hot_hand_buff=1)
Define(icefury 210714)
# Hurls frigid ice at the target, dealing (55.00000000000001 of Spell Power) Frost damage and causing your next n Frost Shocks to deal s3 increased damage and generate 190493s9 Maelstrom.rnrn|cFFFFFFFFGenerates 190493s7 Maelstom.|rrnrnCan cause an Elemental Overload?PL<78[ when at or above level 78][].
  SpellInfo(icefury cd=30 duration=15 maelstrom=0 talent=icefury_talent)
  # Frost Shock damage increased by s3 and generates 190493s9 Maelstrom.
  SpellAddBuff(icefury icefury=1)
Define(landslide_buff 202004)
# ?s201897[Boulderfist][Rockbiter] has a h chance to increase the damage of your next Stormstrike by 202004s1.
  SpellInfo(landslide_buff duration=10 gcd=0 offgcd=1)
  # Your next Stormstrike will deal s1 increased damage.
  SpellAddBuff(landslide_buff landslide_buff=1)
Define(lava_beam 114074)
# Unleashes a blast of superheated flame at the enemy, dealing (43 of Spell Power) Fire damage and then jumping to additional nearby enemies. Damage is increased by s2 after each jump. Affects x1 total targets.  rnrn|cFFFFFFFFGenerates s3 Maelstrom per target hit.|r 
  SpellInfo(lava_beam)
Define(lava_burst 51505)
# Hurls molten lava at the target, dealing (53.125 of Spell Power) Fire damage.?a231721[ Lava Burst will always critically strike if the target is affected by Flame Shock.][]?s137039[][rnrn|cFFFFFFFFGenerates 190493s2 Maelstrom.|r ]
# Rank 2: Lava Burst will always critically strike if the target is affected by Flame Shock.
  SpellInfo(lava_burst cd=8 maelstrom=0)

Define(lava_lash 60103)
# Charges your off-hand weapon with lava and burns your target, dealing s1 Fire damage.
  SpellInfo(lava_lash maelstrom=40)
Define(lightning_bolt_elemental 188196)
# Hurls a bolt of lightning at the target, dealing (70.39999999999999 of Spell Power) Nature damage.?a187828[rnrn|cFFFFFFFFGenerates 190493s1 Maelstrom.|r ][]
  SpellInfo(lightning_bolt_elemental)
Define(lightning_bolt_enhancement 187837)
# Fires a bolt of lightning at the target, dealing ?s210727[up to (1+210727m2/100)*(8.4375 of Spell Power)][(8.4375 of Spell Power)] Nature damage.
  SpellInfo(lightning_bolt_enhancement)
Define(lightning_conduit_debuff 275388)
# Stormstrike marks the target as a Lightning Conduit for 60 seconds. Stormstrike deals s1 Nature damage to all enemies you've marked as Conduits.
  SpellInfo(lightning_conduit_debuff channel=0 gcd=0 offgcd=1)

Define(lightning_shield 192106)
# Surround yourself with a shield of lightning for 3600 seconds.rnrnMelee attackers have a chance to suffer 192109s1 Nature damage, and add a charge to your shield.rnWhen you Stormstrike, it gains s1 charges.rnrnAt 192106u charges, the shield overcharges, causing you to deal an additional 273324s1 Nature damage with each attack for 10 seconds.
  SpellInfo(lightning_shield duration=3600 channel=3600 max_stacks=20 talent=lightning_shield_talent)
  # Chance to deal 192109s1 Nature damage when you take melee damage.
  SpellAddBuff(lightning_shield lightning_shield=1)
Define(liquid_magma_totem 192222)
# Summons a totem at the target location for 15 seconds that hurls liquid magma at a random nearby target every 192226t1 sec, dealing (15 of Spell Power)*(1+(137040s3/100)) Fire damage to all enemies within 192223A1 yards.
  SpellInfo(liquid_magma_totem cd=60 duration=15 gcd=1 talent=liquid_magma_totem_talent)
Define(master_of_the_elements_buff 260734)
# Casting Lava Burst increases the damage of your next Nature, Physical, or Frost spell by 260734s1.
  SpellInfo(master_of_the_elements_buff duration=15 channel=15 gcd=0 offgcd=1)
  # Your next Nature, Physical, or Frost spell will deal s1 increased damage.
  SpellAddBuff(master_of_the_elements_buff master_of_the_elements_buff=1)
Define(natural_harmony_fire 279028)
# Dealing Fire damage grants s1 Critical Strike for 12 seconds. rnDealing Frost damage grants s2 Mastery for 12 seconds.rnDealing Nature damage grants s3 Haste for 12 seconds.
  SpellInfo(natural_harmony_fire duration=12 channel=12 gcd=0 offgcd=1)
  # Critical Strike increased by w1.
  SpellAddBuff(natural_harmony_fire natural_harmony_fire=1)

Define(natural_harmony_frost 279029)
# Dealing Fire damage grants s1 Critical Strike for 12 seconds. rnDealing Frost damage grants s2 Mastery for 12 seconds.rnDealing Nature damage grants s3 Haste for 12 seconds.
  SpellInfo(natural_harmony_frost duration=12 channel=12 gcd=0 offgcd=1)
  # Mastery increased by w1.
  SpellAddBuff(natural_harmony_frost natural_harmony_frost=1)

Define(natural_harmony_nature 279033)
# Dealing Fire damage grants s1 Critical Strike for 12 seconds. rnDealing Frost damage grants s2 Mastery for 12 seconds.rnDealing Nature damage grants s3 Haste for 12 seconds.
  SpellInfo(natural_harmony_nature duration=12 channel=12 gcd=0 offgcd=1)
  # Haste increased by w1.
  SpellAddBuff(natural_harmony_nature natural_harmony_nature=1)

Define(primal_primer 273006)
# Melee attacks with Flametongue active increase the damage the target takes from your next Lava Lash by s1/2, stacking up to 273006u times.
  SpellInfo(primal_primer duration=30 channel=30 max_stacks=10 gcd=0 offgcd=1)
  # Increases damage taken from Lava Lash by w1/2.
  SpellAddTargetDebuff(primal_primer primal_primer=1)
Define(quaking_palm 107079)
# Strikes the target with lightning speed, incapacitating them for 4 seconds, and turns off your attack.
  SpellInfo(quaking_palm cd=120 duration=4 gcd=1)
  # Incapacitated.
  SpellAddTargetDebuff(quaking_palm quaking_palm=1)
Define(rockbiter 193786)
# Assaults your target with earthen power, dealing s1 Nature damage.rnrn|cFFFFFFFFGenerates s2 Maelstrom.|r
  SpellInfo(rockbiter cd=6 maelstrom=-25)
Define(storm_elemental 192249)
# Calls forth a Greater Storm Elemental to hurl gusts of wind that damage the Shaman's enemies for 30 seconds.rnrnWhile the Storm Elemental is active, each time you cast Lightning Bolt or Chain Lightning, the cast time of Lightning Bolt and Chain Lightning is reduced by 263806s1, stacking up to 263806u times.
  SpellInfo(storm_elemental cd=150 talent=storm_elemental_talent)
Define(stormkeeper 191634)
# Charge yourself with lightning, causing your next n Lightning Bolts to deal s2 more damage, and also causes your next n Lightning Bolts or Chain Lightnings to be instant cast and trigger an Elemental Overload on every target.
  SpellInfo(stormkeeper cd=60 duration=15 talent=stormkeeper_talent)
  # Your next Lightning Bolt will deal s2 increased damage, and your next Lightning Bolt or Chain Lightning will be instant cast and cause an Elemental Overload to trigger on every target hit.
  SpellAddBuff(stormkeeper stormkeeper=1)
Define(stormstrike 17364)
# Energizes both your weapons with lightning and delivers a massive blow to your target, dealing a total of 32175sw1+32176sw1 Physical damage.
  SpellInfo(stormstrike maelstrom=30 cd=9)


Define(strength_of_earth_buff 273463)
# Rockbiter causes your next melee ability, other than Rockbiter, to deal an additional s1 Nature damage.
  SpellInfo(strength_of_earth_buff channel=-0.001 gcd=0 offgcd=1)

Define(sundering 197214)
# Shatters a line of earth in front of you with your main hand weapon, causing s1 Flamestrike damage and Incapacitating any enemy hit for 2 seconds.
  SpellInfo(sundering maelstrom=20 cd=40 duration=2 talent=sundering_talent)
  # Incapacitated.
  SpellAddTargetDebuff(sundering sundering=1)
Define(surge_of_power_buff 285514)
# Earth Shock also enhances your next spell cast within 15 seconds:rnrn|cFFFFFFFFFlame Shock|r: The next cast also applies Flame Shock to 287185s1 additional target within 287185A1 yards of the target.rn|cFFFFFFFFLightning Bolt|r: Your next cast will cause an additional s2-s3 Elemental Overloads.rn|cFFFFFFFFLava Burst|r: Reduces the cooldown of your ?s192249[Storm][Fire] Elemental by m1/1000.1 sec.rn|cFFFFFFFFFrost Shock|r: Freezes the target in place for 6 seconds.rn
  SpellInfo(surge_of_power_buff duration=15 channel=15 gcd=0 offgcd=1)
  # Your next spell cast will be enhanced.
  SpellAddBuff(surge_of_power_buff surge_of_power_buff=1)
Define(war_stomp 20549)
# Stuns up to i enemies within A1 yds for 2 seconds.
  SpellInfo(war_stomp cd=90 duration=2 gcd=0 offgcd=1)
  # Stunned.
  SpellAddTargetDebuff(war_stomp war_stomp=1)
Define(wind_shear 57994)
# Disrupts the target's concentration with a burst of wind, interrupting spellcasting and preventing any spell in that school from being cast for 3 seconds.
  SpellInfo(wind_shear cd=12 duration=3 gcd=0 offgcd=1 interrupt=1)
Define(windstrike 115356)
# Hurl a staggering blast of wind at an enemy, dealing a total of 115357sw1+115360sw1 Physical damage, bypassing armor.
  SpellInfo(windstrike maelstrom=30 cd=9)

Define(ascendance_talent 21) #21675
# Transform into a Flame Ascendant for 15 seconds, replacing Chain Lightning with Lava Beam, removing the cooldown on Lava Burst, and increasing the damage of Lava Burst by an amount equal to your critical strike chance.
Define(ascendance_talent_enhancement 21) #21972
# Transform into an Air Ascendant for 15 seconds, reducing the cooldown and cost of Stormstrike by s4, and transforming your auto attack and Stormstrike into Wind attacks which bypass armor and have a s1 yd range.
Define(boulderfist_talent 1) #22354
# Rockbiter's recharge time is reduced by s1 and it deals s2 increased damage.
Define(call_the_thunder_talent 5) #22139
# Your maximum Maelstrom increased by s2, and the Maelstrom cost of Earth Shock?PL<48[][ and Earthquake] is reduced by s1.
Define(crashing_storm_talent 16) #21973
# Crash Lightning also electrifies the ground, leaving an electrical field behind which damages enemies within it for 7*210801s1 Nature damage over 6 seconds. 
Define(earthen_spike_talent 20) #22977
# Summons an Earthen Spike under an enemy, dealing s1 Physical damage and increasing Physical and Nature damage you deal to the target by s2 for 10 seconds.
Define(elemental_blast_talent 3) #22358
# Harnesses the raw power of the elements, dealing (63 of Spell Power) Elemental damage and increasing your Critical Strike, Haste, or Mastery by 118522s1 for 10 seconds.rnrnCan cause an Elemental Overload?PL<78[ when at or above level 78][].
Define(feral_lunge_talent 14) #22149
# Lunge at your enemy as a ghostly wolf, biting them to deal 215802s1 Physical damage.
Define(forceful_winds_talent 5) #22150
# Windfury causes each successive Windfury attack within 15 seconds to increase the damage of Windfury by 262652s1 and the Maelstrom generated by 262652s2, stacking up to 262652u times.
Define(fury_of_air_talent 17) #22352
# Creates a vortex of wind 197385A1 yards around you, dealing 197385s1*<CAP>/AP Nature damage every t1 sec to enemies caught in the storm, and slowing them by 197385s2 for 3 seconds.
Define(hailstorm_talent 11) #23090
# Frostbrand now also enhances your weapon's damage, causing each of your weapon attacks to also deal 210854sw1 Frost damage.
Define(hot_hand_talent 2) #22355
# Melee attacks with Flametongue active have a chance to make your next Lava Lash cost no Maelstrom and deal 215785s1 increased damage.
Define(icefury_talent 18) #23111
# Hurls frigid ice at the target, dealing (55.00000000000001 of Spell Power) Frost damage and causing your next n Frost Shocks to deal s3 increased damage and generate 190493s9 Maelstrom.rnrn|cFFFFFFFFGenerates 190493s7 Maelstom.|rrnrnCan cause an Elemental Overload?PL<78[ when at or above level 78][].
Define(landslide_talent 4) #22636
# ?s201897[Boulderfist][Rockbiter] has a h chance to increase the damage of your next Stormstrike by 202004s1.
Define(lightning_shield_talent 3) #22353
# Surround yourself with a shield of lightning for 3600 seconds.rnrnMelee attackers have a chance to suffer 192109s1 Nature damage, and add a charge to your shield.rnWhen you Stormstrike, it gains s1 charges.rnrnAt 192106u charges, the shield overcharges, causing you to deal an additional 273324s1 Nature damage with each attack for 10 seconds.
Define(liquid_magma_totem_talent 12) #19273
# Summons a totem at the target location for 15 seconds that hurls liquid magma at a random nearby target every 192226t1 sec, dealing (15 of Spell Power)*(1+(137040s3/100)) Fire damage to all enemies within 192223A1 yards.
Define(master_of_the_elements_talent 10) #19271
# Casting Lava Burst increases the damage of your next Nature, Physical, or Frost spell by 260734s1.
Define(overcharge_talent 12) #22171
# Lightning Bolt now consumes up to s1 Maelstrom for up to s2 increased damage, but has a 213498t1 sec cooldown.
Define(primal_elementalist_talent 17) #19266
# Your Earth, Fire, and Storm Elementals are drawn from primal elementals s1 more powerful than regular elementals, with additional abilities, and you gain direct control over them.
Define(searing_assault_talent 10) #23089
# Flametongue now causes the target to burn for 268429o1 Fire damage over 6 seconds.
Define(storm_elemental_talent 11) #19272
# Calls forth a Greater Storm Elemental to hurl gusts of wind that damage the Shaman's enemies for 30 seconds.rnrnWhile the Storm Elemental is active, each time you cast Lightning Bolt or Chain Lightning, the cast time of Lightning Bolt and Chain Lightning is reduced by 263806s1, stacking up to 263806u times.
Define(stormkeeper_talent 20) #22153
# Charge yourself with lightning, causing your next n Lightning Bolts to deal s2 more damage, and also causes your next n Lightning Bolts or Chain Lightnings to be instant cast and trigger an Elemental Overload on every target.
Define(sundering_talent 18) #22351
# Shatters a line of earth in front of you with your main hand weapon, causing s1 Flamestrike damage and Incapacitating any enemy hit for 2 seconds.
Define(surge_of_power_talent 16) #22145
# Earth Shock also enhances your next spell cast within 15 seconds:rnrn|cFFFFFFFFFlame Shock|r: The next cast also applies Flame Shock to 287185s1 additional target within 287185A1 yards of the target.rn|cFFFFFFFFLightning Bolt|r: Your next cast will cause an additional s2-s3 Elemental Overloads.rn|cFFFFFFFFLava Burst|r: Reduces the cooldown of your ?s192249[Storm][Fire] Elemental by m1/1000.1 sec.rn|cFFFFFFFFFrost Shock|r: Freezes the target in place for 6 seconds.rn
Define(totem_mastery_talent_elemental 6) #23190
# Summons four totems that increase your combat capabilities for 120 seconds.rnrn|cFFFFFFFFResonance Totem|rrnGenerates 202192s1 Maelstrom every 202192t1 sec.rnrn|cFFFFFFFFStorm Totem|rrnIncreases the chance for Lightning Bolt and Chain Lightning to trigger Elemental Overload by 210651s1.rnrn|cFFFFFFFFEmber Totem|rrnIncreases Flame Shock damage over time by 210658s1.rnrn|cFFFFFFFFTailwind Totem|rrnIncreases your Haste by 210659s1.
Define(ancestral_resonance_trait 277666)
Define(echo_of_the_elementals_trait 275381)
Define(natural_harmony_trait 278697)
Define(lightning_conduit_trait 275388)
Define(primal_primer_trait 272992)
Define(strength_of_earth_trait 273461)
    ]]
    code = code .. [[

# Alias
SpellList(lava_burst_nocd ascendance_elemental_buff lava_surge_buff)

# Spells
Define(ancestral_guidance 108281)
	SpellInfo(ancestral_guidance cd=120)
	SpellAddBuff(ancestral_guidance ancestral_guidance_buff=1)
Define(ancestral_guidance_buff 108281)
	SpellInfo(ancestral_guidance_buff duration=10)
Define(ancestral_protection_totem 207399)
	SpellInfo(ancestral_protection_totem cd=300)
Define(ancestral_spirit 2008)
Define(ancestral_vigor_buff 207400)
	SpellInfo(ancestral_vigor_buff duration=10)
Define(ancestral_vision 212048)
Define(ascendance_elemental 114050)
	SpellInfo(ascendance_elemental cd=180)
	SpellAddBuff(ascendance_elemental ascendance_elemental_buff=1)
Define(ascendance_elemental_buff 114050)
	SpellInfo(ascendance_elemental_buff duration=15)
Define(ascendance_enhancement 114051)
	SpellInfo(ascendance_enhancement cd=180)
	SpellAddBuff(ascendance_enhancement ascendance_enhancement_buff=1)
Define(ascendance_enhancement_buff 114051)
	SpellInfo(ascendance_enhancement_buff duration=15)
Define(ascendance_restoration 114052)
	SpellInfo(ascendance_restoration cd=180)
Define(ascendance_restoration_buff 114052)
	SpellInfo(ascendance_restoration_buff duration=15)
Define(astral_recall 556)
	SpellInfo(astral_recall cd=600)
Define(astral_shift 108271)
	SpellInfo(astral_shift cd=90 gdc=0 offgcd=1)
	SpellAddBuff(astral_shift astral_shift_buff=1)
Define(astral_shift_buff 108271)
	SpellInfo(astral_shift_buff duration=8)

	SpellInfo(bloodlust cd=300 gcd=0 offgcd=1)
	SpellAddBuff(bloodlust bloodlust_buff=1)
Define(bloodlust_buff 2825)
	SpellInfo(bloodlust_buff duration=40)

	SpellInfo(capacitor_totem cd=60 interrupt=1)
Define(chain_heal 1064)
	SpellAddBuff(chain_heal tidal_waves_buff=1)
	SpellAddBuff(chain_heal ancestral_vigor_buff=1 talent=ancestral_vigor_talent)
Define(chain_lightning_restoration 421)	
Define(chain_lightning 188443)
	SpellInfo(chain_lightning maelstrom=-4)
	SpellRequire(chain_lightning replace lava_beam=buff,ascendance_elemental_buff)
	SpellAddBuff(chain_lightning stormkeeper_buff=-1 talent=stormkeeper_talent)
	SpellAddBuff(chain_lightning master_of_the_elements_buff=-1 talent=master_of_the_elements_talent specialization=elemental)
Define(cleanse_spirit 51886)
	SpellInfo(cleanse_spirit cd=8)
Define(cloudburst_totem 157153)
	SpellInfo(cloudburst_totem cd=30)

	SpellInfo(crash_lightning maelstrom=20 cd=6 cd_haste=melee)
	SpellAddBuff(crash_lightning gathering_storms_buff=1)
Define(crash_lightning_buff 187878)
Define(downpour 207778)

    SpellInfo(earth_elemental totem=1 max_totems=1)
	
Define(earth_shield 974)
	SpellAddTargetBuff(earth_shield earth_shield_buff=9)
Define(earth_shield_buff 974)
	SpellInfo(earth_shield_buff duration=600 max_charges=9)

	
	SpellAddTargetDebuff(earth_shock exposed_elements_debuff=1)
	SpellAddBuff(earth_shock master_of_the_elements_buff=-1 talent=master_of_the_elements_talent specialization=elemental)
Define(earthbind_totem 2484)
	SpellInfo(earthbind_totem cd=30)
Define(earthen_wall_buff 201633)
Define(earthen_wall_totem 198838)
	SpellInfo(earthen_wall_totem cd=60)

	SpellInfo(earthen_spike cd=20 maelstrom=20)
	SpellAddTargetDebuff(earthen_spike earthen_spike_debuff=1)
Define(earthen_spike_debuff 188089)
	SpellInfo(earthen_spike_debuff duration=10)
Define(earthen_wall_totem 198838)
Define(earthgrab_totem 51485)
	SpellInfo(earthgrab_totem cd=30)

	SpellInfo(earthquake maelstrom=60)
Define(earthquake_debuff 182387)
  
	SpellInfo(elemental_blast cd=12 travel_time=1)
	SpellAddBuff(elemental_blast master_of_the_elements_buff=-1 talent=master_of_the_elements_talent specialization=elemental)
Define(elemental_blast_crit_buff 118522)
	SpellInfo(elemental_blast_crit_buff duration=10)
Define(elemental_blast_haste_buff 173183)
	SpellInfo(elemental_blast_haste_buff duration=10)
Define(elemental_blast_mastery_buff 173184)
	SpellInfo(elemental_blast_mastery_buff duration=10)
Define(elemental_spirits_talent 19)
Define(exposed_elements_debuff 269808)
	SpellInfo(exposed_elements_debuff duration=15)
Define(far_sight 6196)

	SpellInfo(feral_lunge cd=30)

	SpellInfo(feral_spirit cd=120 duration=15 totem=1 max_totems=2)
	SpellInfo(feral_spirit add_cd=-30 talent=elemental_spirits_talent)
	SpellAddBuff(feral_spirit icy_edge_buff=1)
	SpellAddBuff(feral_spirit molten_weapon_buff=1)

	
	SpellInfo(fire_elemental totem=1 max_totems=1)
    SpellInfo(fire_elemental replaced_by=storm_elemental talent=storm_elemental_talent)

	SpellInfo(flame_shock cd=6)
	SpellAddTargetDebuff(flame_shock flame_shock_debuff=1)
Define(flame_shock_debuff 188389)
	SpellInfo(flame_shock_debuff duration=18 haste=spell tick=2)
Define(flame_shock_restoration 188838)
	SpellInfo(flame_shock_restoration cd=6)
Define(flame_shock_restoration_debuff 188389)
	SpellInfo(flame_shock_restoration_debuff duration=21 haste=spell tick=3)

	SpellInfo(flametongue cd=12 cd_haste=melee)
	
	SpellAddTargetDebuff(flametongue searing_assault_debuff=1 talent=searing_assault_talent)
Define(flametongue_buff 193796)
	SpellInfo(flametongue_buff duration=16)

	SpellAddTargetDebuff(frost_shock frost_shock_debuff=1)
	SpellAddBuff(frost_shock icefury_buff=-1)
	SpellAddBuff(frost_shock master_of_the_elements_buff=-1 talent=master_of_the_elements_talent specialization=elemental)
Define(frost_shock_debuff 196840)
	SpellInfo(frost_shock_debuff duration=6)

	SpellInfo(frostbrand maelstrom=20)
	SpellAddBuff(frostbrand frostbrand_buff=1)
Define(frostbrand_buff 196834)
	SpellInfo(flametongue_buff duration=16)

	SpellInfo(fury_of_air maelstrom=3)
	SpellAddBuff(fury_of_air fury_of_air_buff=1)
	SpellAddTargetDebuff(fury_of_air fury_of_air_debuff=1)
	SpellRequire(fury_of_air unusable 1=buff,fury_of_air_buff)
Define(fury_of_air_buff 197211)
Define(fury_of_air_debuff 197385)
	SpellInfo(fury_of_air_debuff duration=3)
Define(gathering_storms_buff 198300)
	SpellInfo(gathering_storms_buff duration=10)
Define(ghost_wolf 2645)
	SpellAddBuff(ghost_wolf ghost_wolf_buff=1)
Define(ghost_wolf_buff 2645)
Define(healing_rain 73920)
	SpellInfo(healing_rain cd=10)
	SpellAddBuff(healing_rain healing_rain_buff=1)
Define(healing_rain_buff 73920)
	SpellInfo(healing_rain_buff duration=10)
Define(healing_stream_totem 5394)
	SpellInfo(healing_stream_totem cd=30)
	SpellInfo(healing_stream_totem charges=2 talent=resto_echo_of_the_elements_talent)
Define(healing_surge 188070)
Define(healing_surge_restoration 8004)
	SpellAddBuff(healing_surge_restoration ancestral_vigor_buff=1 talent=ancestral_vigor_talent)
Define(healing_tide_totem 108280)
	SpellInfo(healing_tide_totem cd=60)
Define(healing_wave 77472)
	SpellAddBuff(healing_wave tidal_waves_buff=-1)
	SpellAddBuff(healing_wave ancestral_vigor_buff=1 talent=ancestral_vigor_talent)

	SpellInfo(heroism cd=300 gcd=0)
	SpellAddBuff(heroism heroism_buff=1)
Define(heroism_buff 32182)
	SpellInfo(heroism_buff duration=40)

	SpellInfo(hex cd=30)
	SpellAddTargetDebuff(hex hex_debuff=1)
Define(hex_debuff 51514)
	SpellInfo(hex_debuff duration=60)

	SpellInfo(hot_hand_buff duration=15)

	SpellInfo(icefury maelstrom=-15 cd=30)
	SpellAddBuff(icefury icefury_buff=4)
	SpellAddBuff(icefury master_of_the_elements_buff=-1 talent=master_of_the_elements_talent specialization=elemental)
Define(icefury_buff 210714)
	SpellInfo(icefury_buff duration=15)
Define(icy_edge_buff 224126)
    SpellInfo(icy_edge_buff duration=15)

	SpellInfo(landslide_buff duration=10)

	SpellInfo(lava_beam maelstrom=-3)
	SpellRequire(lava_beam unusable 1=buff,!ascendance_elemental_buff)

	SpellInfo(lava_burst cd=8 travel_time=1 maelstrom=-10 charges=1)
	SpellInfo(lava_burst charges=2 talent=echo_of_the_elements_talent specialization=elemental)
	SpellInfo(lava_burst charges=2 talent=resto_echo_of_the_elements_talent specialization=restoration)
	SpellAddBuff(lava_burst master_of_the_elements_buff=1 talent=master_of_the_elements_talent specialization=elemental)
	SpellRequire(lava_burst cd_percent 0=buff,lava_burst_nocd)

	
	SpellRequire(lava_lash maelstrom_percent 0=buff,hot_hand_buff)
Define(lava_surge_buff 77762)
	SpellInfo(lava_surge_buff duration=10)

	SpellInfo(lightning_bolt_elemental maelstrom=-8 cd=0)
	SpellAddBuff(lightning_bolt_elemental stormkeeper_buff=-1 talent=stormkeeper_talent)
	SpellAddBuff(lightning_bolt_elemental master_of_the_elements_buff=-1 talent=master_of_the_elements_talent specialization=elemental)

	SpellInfo(lightning_bolt_enhancement cd=12 cd_haste=melee)
	SpellInfo(lightning_bolt_enhancement maelstrom=0 max_maelstrom=40 talent=overcharge_talent)
Define(lightning_bolt 403)
Define(lightning_crash_buff 187874)
Define(lightning_rod_debuff 197209)

	SpellAddBuff(lightning_shield lightning_shield_buff=1)
	SpellRequire(lightning_shield unusable 1=buff,lightning_shield_buff)
Define(lightning_shield_buff 192106)
	SpellInfo(lightning_shield_buff duration=3600)

	SpellInfo(liquid_magma_totem cd=60)

	SpellInfo(master_of_the_elements_buff duration=15)
Define(molten_weapon_buff 224125)
    SpellInfo(molten_weapon_buff duration=15)
Define(purge 370)
Define(purify_spirit 77130)
	SpellInfo(purify_spirit cd=8)
Define(resurgence 16196)
Define(riptide 61295)
	SpellInfo(riptide cd=6)
	SpellInfo(riptide charges=2 talent=resto_echo_of_the_elements_talent)
	SpellAddTargetBuff(riptide riptide_buff=1)
	SpellAddBuff(riptide tidal_waves_buff=1)
	SpellAddBuff(riptide ancestral_vigor_buff=1 talent=ancestral_vigor_talent)
Define(riptide_buff 61295)
	SpellInfo(riptide_buff duration=18 tick=3 haste=spell)

	SpellInfo(rockbiter maelstrom=-25 charges=2 cd=6 cd_haste=melee)
	SpellInfo(rockbiter cd=5.1 talent=boulderfist_talent)
Define(searing_assault_debuff 268429)
	SpellInfo(searing_assault_debuff duration=6)
Define(spirit_link_totem 98008)
	SpellInfo(spirit_link_totem cd=180)
Define(spirit_link_totem_buff 98008)
Define(spirit_walk 58875)
	SpellInfo(spirit_walk cd=60)
Define(spirit_wolf_buff 260881)
Define(spiritwalkers_grace 79206)
	SpellInfo(spiritwalkers_grace cd=120)
	SpellInfo(spiritwalkers_grace add_cd=-60 talent=graceful_spirit_talent)
Define(spiritwalkers_grace_buff 79206)
	SpellInfo(spiritwalkers_grace_buff duration=15)

	SpellInfo(storm_elemental cd=150 totem=1 max_totems=1)

Define(stormbringer_buff 201846)
	SpellInfo(stormbringer_buff duration=12)

	SpellInfo(stormkeeper cd=60)
	SpellAddBuff(stormkeeper stormkeeper_buff=2)
Define(stormkeeper_buff 191634)
	SpellInfo(stormkeeper_buff duration=15)

	SpellInfo(stormstrike cd=9 cd_haste=melee maelstrom=30)
	SpellAddBuff(stormstrike gathering_storms_buff=-1)
	SpellAddBuff(stormstrike stormbringer_buff=-1)
	SpellRequire(stormstrike replace windstrike=buff,ascendance_enhancement_buff)
	SpellRequire(stormstrike cd_percent 0=buff,stormbringer_buff)
	SpellRequire(stormstrike maelstrom_percent 0=buff,stormbringer_buff)

	SpellInfo(sundering maelstrom=20 cd=40 tag=main)
Define(thunderstorm 51490)
	SpellInfo(thunderstorm cd=45)
Define(tidal_waves 51564)
Define(tidal_waves_buff 53390)
	SpellInfo(tidal_waves_buff duration=15 max_stacks=2)
Define(totem_mastery_elemental 210643)
    SpellInfo(totem_mastery_elemental totem=1 buff_totem=ele_resonance_totem_buff)
	SpellAddBuff(totem_mastery_elemental ele_resonance_totem_buff=1)
	SpellAddBuff(totem_mastery_elemental ele_tailwind_totem_buff=1)
	SpellAddBuff(totem_mastery_elemental ele_ember_totem_buff=1)
	SpellAddBuff(totem_mastery_elemental ele_strom_totem_buff=1)
Define(totem_mastery_enhancement 262395)
    SpellInfo(totem_mastery_enhancement totem=1 buff_totem=enh_resonance_totem_buff)
	SpellAddBuff(totem_mastery_enhancement enh_resonance_totem_buff=1)
	SpellAddBuff(totem_mastery_enhancement enh_tailwind_totem_buff=1)
	SpellAddBuff(totem_mastery_enhancement enh_ember_totem_buff=1)
	SpellAddBuff(totem_mastery_enhancement enh_strom_totem_buff=1)
Define(tremor_totem 8143)
	SpellInfo(tremor_totem cd=60)
Define(unleash_life 73685)
	SpellInfo(unleash_life cd=15)
Define(unleash_life_buff 73685)
	SpellInfo(unleash_life_buff duration=10)
Define(unlimited_power_buff 272737)
Define(water_walking 546)
	SpellAddBuff(water_walking water_walking_buff=1)
Define(water_walking_buff 546)
	SpellInfo(water_walking_buff duration=600)
Define(wellspring 197995)
	SpellInfo(wellspring cd=20)
Define(wind_gust_buff 263806)
Define(wind_rush_totem 192077)
	SpellInfo(wind_rush_totem cd=120)
	SpellAddBuff(wind_rush_totem wind_rush_totem_buff=1)
Define(wind_rush_totem_buff 192082)
	SpellInfo(wind_rush_totem_buff duration=5)

	SpellInfo(wind_shear cd=12 gcd=0 offgcd=1 interrupt=1)

	SpellInfo(windstrike maelstrom=10 cd=3 cd_haste=melee)
	SpellRequire(windstrike unusable 1=buff,!ascendance_enhancement_buff)
	SpellAddBuff(windstrike stormbringer_buff=-1)
	SpellRequire(windstrike cd_percent 0=buff,stormbringer_buff)
	SpellRequire(windstrike maelstrom_percent 0=buff,stormbringer_buff)

# Totems Buffs
Define(ele_resonance_totem_buff 202192)
	SpellInfo(resonance_totem_buff duration=120)
Define(ele_tailwind_totem_buff 210659)
	SpellInfo(tailwind_totem_buff duration=120)
Define(ele_ember_totem_buff 210658)
	SpellInfo(ember_totem_buff duration=120)
Define(ele_strom_totem_buff 210652)
	SpellInfo(strom_totem_buff duration=120)

Define(enh_resonance_totem_buff 262417)
	SpellInfo(resonance_totem_buff duration=120)
Define(enh_tailwind_totem_buff 262400)
	SpellInfo(tailwind_totem_buff duration=120)
Define(enh_ember_totem_buff 262399)
	SpellInfo(ember_totem_buff duration=120)
Define(enh_strom_totem_buff 262397)
	SpellInfo(strom_totem_buff duration=120)

# Azerite Traits
Define(lightning_conduit_trait 275391)
Define(lightning_conduit_debuff 275391)

# Legendary items
Define(echoes_of_the_great_sundering_item 137074)
Define(echoes_of_the_great_sundering_buff 208723)
	SpellAddBuff(earthquake echoes_of_the_great_sundering_buff=0)
	SpellRequire(earthquake maelstrom_percent 0=buff,echoes_of_the_great_sundering_buff)
Define(smoldering_heart_item 151819)
Define(the_deceivers_blood_pact_item 137035)

# Talents
Define(aftershock_talent 4)
Define(ancestral_guidance_talent 14)
Define(ancestral_protection_totem_talent 12)
Define(ancestral_vigor_talent 10)

Define(boulderfist_talent 1)
Define(cloudburst_totem_talent 18)

Define(deluge_talent 5)
Define(downpour_talent 17)
Define(earth_shield_talent 8)
Define(earth_shield_talent_restoration 6)
Define(earthen_rage_talent 16)

Define(earthen_wall_totem_talent 11)
Define(earthgrab_totem_talent 8)
Define(echo_of_the_elements_talent 2)
Define(resto_echo_of_the_elements_talent 4)




Define(flash_flood_talent 16)


Define(graceful_spirit_talent 14)

Define(high_tide_talent 19)
Define(high_voltage_talent 10)






Define(natures_guardian_talent 13)

Define(primal_elementalist_talent 17)

Define(spirit_wolf_talent 7)
Define(static_charge_talent 9)



Define(torrent_talent 1)

Define(undulation_talent 2)
Define(unleash_life_talent 3)
Define(unlimited_power_talent 19)
Define(wellspring_talent 20)
Define(wind_rush_totem_talent 15)

]]
    OvaleScripts:RegisterScript("SHAMAN", nil, name, desc, code, "include")
end
