-- WARNING
-- THE COMMENTED OUT ABILITIES ARE THERE FOR A REASON
-- PLEASE DO NOT UNCOMMENT THEM, OTHERWISE THINGS WILL PROBABLY BREAK

if ( GetLocale() == "enUS" or GetLocale() == "enGB" ) then

	-- Internal Spell Names
	CECB_SPELL_STUN_DR = "Stun DR";
	CECB_SPELL_FRENZY_CD = "Frenzy (CD)";

	CEnemyCastBar_Spells = {

		-- IMPORTANT: Maybe some spells which cause debuffs have to be moved to CEnemyCastBar_Afflicitions to be shown
		-- "t=x" defines the normal length of the castbar. "d=x" will add a cooldown timer for spells with a casttime and for gains.
		-- "g=0" prevents a bar if a player gains this spell. "g=x" shows a bar of x seconds instead of "t=x" if it's a gain.
		-- "i=x" shows a bar of x seconds additional to "t" (everytime)

		-- All Classes
			-- General
		["Hearthstone"] = {t=10.0, icontex="INV_Misc_Rune_01"};

			-- Trinkets & Racials
		["Brittle Armor"] = 		{t=20.0, d=120, icontex="Spell_Shadow_GrimWard"}; -- gain
		["Unstable Power"] = 		{t=20.0, d=120, icontex="Spell_Lightning_LightningBolt01"}; -- gain
		["Restless Strength"] = 	{t=20.0, d=120, icontex="Spell_Shadow_GrimWard"}; -- gain
		["Ephemeral Power"] = 		{t=15.0, d=90, icontex="Spell_Holy_MindVision"}; -- gain
		["Arcane Power"] = 		{t=15.0, d=180, icontex="Spell_Nature_Lightning"}; -- gain
		["Massive Destruction"] = 	{t=20.0, d=180, icontex="Spell_Fire_WindsofWoe"}; -- gain
		["Arcane Potency"] = 		{t=20.0, d=180, icontex="Spell_Arcane_StarFire"}; -- gain
		["Energized Shield"] = 		{t=20.0, d=180, icontex="Spell_Nature_CallStorm"}; -- gain
		["Brilliant Light"] = 		{t=20.0, d=180, icontex="Spell_Holy_MindVision"}; -- gain
		["Will of the Forsaken"] = 	{t=5.0, d=120, icontex="Spell_Shadow_RaiseDead"}; -- gain
		["Perception"] = 		{t=20.0, d=180, icontex="Spell_Nature_Sleep"}; -- gain
		["Mar'li's Brain Boost"] = 	{t=30.0, d=180, icontex="INV_ZulGurubTrinket"}; -- gain
		["War Stomp"] = 		{t=0.5, d=120, icontex="Ability_WarStomp"};
		["Stoneform"] = 		{t=8.0, d=180, icontex="Spell_Shadow_UnholyStrength"};

		["Earthstrike"] = 		{t=20.0, d=120, icontex="Spell_Nature_AbolishMagic"}; -- gain
		["Gift of Life"] = 		{t=20.0, d=300, icontex="INV_Misc_Gem_Pearl_05"}; -- gain
		["Nature Aligned"] = 		{t=20.0, d=300, icontex="Spell_Nature_SpiritArmor"}; -- gain

			-- Engineering
		["Frost Reflector"] = 		{t=5.0, d=300.0, icontex="Spell_Frost_FrostWard"}; -- gain
		["Shadow Reflector"] = 		{t=5.0, d=300.0, icontex="Spell_Shadow_AntiShadow"}; -- gain
		["Fire Reflector"] = 		{t=5.0, d=300.0, icontex="Spell_Fire_SealOfFire"}; -- gain
		
			-- First Aid
		["First Aid"] = 		{t=8.0, d=60, icontex="Spell_Holy_Heal"}; -- gain
		["Linen Bandage"] = 		{t=3.0, icontex="INV_Misc_Bandage_15"};
		["Heavy Linen Bandage"] = 	{t=3.0, icontex="INV_Misc_Bandage_18"};
		["Wool Bandage"] = 		{t=3.0, icontex="INV_Misc_Bandage_14"};
		["Heavy Wool Bandage"] = 	{t=3.0, icontex="INV_Misc_Bandage_17"};
		["Silk Bandage"] = 		{t=3.0, icontex="INV_Misc_Bandage_01"};
		["Heavy Silk Bandage"] = 	{t=3.0, icontex="INV_Misc_Bandage_02"};
		["Mageweave Bandage"] = 	{t=3.0, icontex="INV_Misc_Bandage_19"};
		["Heavy Mageweave Bandage"] = 	{t=3.0, icontex="INV_Misc_Bandage_20"};
		["Runecloth Bandage"] = 	{t=3.0, icontex="INV_Misc_Bandage_11"};
		["Heavy Runecloth Bandage"] = 	{t=3.0, icontex="INV_Misc_Bandage_12"};
		
		-- Druid
		["Healing Touch"] = 		{t=3.0, icontex="Spell_Nature_HealingTouch"};
		["Regrowth"] = 			{t=2.0, g=21.0, icontex="Spell_Nature_ResistNature"};
		["Rebirth"] = 			{t=2.0, d=1800.0, icontex="Spell_Nature_Reincarnation"};
		["Starfire"] = 			{t=3.0, icontex="Spell_Arcane_StarFire"};
		["Wrath"] = 			{t=1.5, icontex="Spell_Nature_AbolishMagic"};
		["Entangling Roots"] = 		{t=1.5, icontex="Spell_Nature_StrangleVines"};
		["Dash"] = 			{t=15.0, d=300.0, icontex="Ability_Druid_Dash"}; -- gain
		["Hibernate"] = 		{t=1.5, icontex="Spell_Nature_Sleep"};
		["Soothe Animal"] = 		{t=1.5, icontex="Ability_Hunter_BeastSoothe"};
		["Barkskin"] = 			{t=15.0, d=60, icontex="Spell_Nature_StoneClawTotem"}; -- gain
		["Innervate"] = 		{t=20.0, icontex="Spell_Nature_Lightning"}; -- gain
		["Teleport: Moonglade"] = 	{t=10.0, icontex="Spell_Arcane_TeleportMoonglade"};
		["Tiger's Fury"] = 		{t=6.0, icontex="Ability_Mount_JungleTiger"}; -- gain
		["Frenzied Regeneration"] = 	{t=10.0, d=180.0, icontex="Ability_BullRush"}; -- gain
		["Rejuvenation"] = 		{t=12.0, icontex="Spell_Nature_Rejuvenation"}; -- gain
		["Abolish Poison"] = 		{t=8.0, icontex="Spell_Nature_NullifyPoison_02"}; -- gain
		["Tranquility"] = 		{t=10.0, d=300.0, icontex="Spell_Nature_Tranquility"};
		["Nature's Grasp"] = 		{t=45, d=60, icontex="Spell_Nature_NaturesWrath"}; -- talent gain
		--["Cyclone"] = 		{t=1.5, icontex=""};
		--["Lifebloom"] = 		{t=7, icontex=""}; -- gain
		
		-- Hunter
		["Aimed Shot"] = 		{t=3.0, d=6.0, icontex="INV_Spear_07"};
		["Scare Beast"] = 		{t=1.0, d=30.0, icontex="Ability_Druid_Cower"};
		["Volley"] = 			{t=6.0, d=60.0, icontex="Ability_Marksmanship"};
		["Dismiss Pet"] = 		{t=5.0, icontex="Spell_Nature_SpiritWolf"};
		["Revive Pet"] = 		{t=10.0, icontex="Ability_Hunter_BeastSoothe"};
		["Eyes of the Beast"] = 	{t=2.0, icontex="Ability_EyeOfTheOwl"};
		["Rapid Fire"] = 		{t=15.0, d=300.0, icontex="Ability_Hunter_RunningShot"}; -- gain
		["Deterrence"] = 		{t=10, d=300.0, icontex="Ability_Whirlwind"}; -- gain
		["Multi-Shot"] = 		{d=10.0, icontex="Ability_UpgradeMoonGlaive"};
		["Bestial Wrath"] = 		{t=18, d=120.0, icontex="Ability_Druid_FerociousBite"}; -- Pet gain
		--["The Beast Within"] =	{t=18, d=120, icontex=""}; -- gain, Talent

		
		-- Mage
		["Frostbolt"] = {t=2.5, icontex="Spell_Frost_FrostBolt02"};
		["Fireball"] = {t=3.0, icontex="Spell_Fire_FlameBolt"};
		["Conjure Water"] = {t=3.0, icontex="INV_Drink_18"};
		["Conjure Food"] = {t=3.0, icontex="INV_Misc_Food_33"};
		["Conjure Mana Ruby"] = {t=3.0, icontex="INV_Misc_Gem_Ruby_01"};
		["Conjure Mana Citrine"] = {t=3.0, icontex="INV_Misc_Gem_Opal_01"};
		["Conjure Mana Jade"] = {t=3.0, icontex="INV_Misc_Gem_Emerald_02"};
		["Conjure Mana Agate"] = {t=3.0, icontex="INV_Misc_Gem_Emerald_01"};
		["Polymorph"] = {t=1.5, icontex="Spell_Nature_Polymorph"};
		["Polymorph: Pig"] = {t=1.5, icontex="Spell_Magic_PolymorphPig"};
		["Polymorph: Turtle"] = {t=1.5, icontex="Ability_Hunter_Pet_Turtle"};
		["Pyroblast"] = {t=6.0, icontex="Spell_Fire_Fireball02"};
		["Scorch"] = {t=1.5, icontex="Spell_Fire_SoulBurn"};
		["Flamestrike"] = {t=3.0, r="Death Talon Hatcher", a=2.5, icontex="Spell_Fire_SelfDestruct"};
		["Slow Fall"] = {t=30.0, icontex="Spell_Magic_FeatherFall"}; -- gain
		["Portal: Darnassus"] = {t=10.0, icontex="Spell_Arcane_PortalDarnassus"};
		["Portal: Thunder Bluff"] = {t=10.0, icontex="Spell_Arcane_PortalThunderBluff"};
		["Portal: Ironforge"] = {t=10.0, icontex="Spell_Arcane_PortalIronForge"};
		["Portal: Orgrimmar"] = {t=10.0, icontex="Spell_Arcane_PortalOrgrimmar"};
		["Portal: Stormwind"] = {t=10.0, icontex="Spell_Arcane_PortalStormWind"};
		["Portal: Undercity"] = {t=10.0, icontex="Spell_Arcane_PortalUnderCity"};
		["Teleport: Darnassus"] = {t=10.0, icontex="Spell_Arcane_TeleportDarnassus"};
		["Teleport: Thunder Bluff"] = {t=10.0, icontex="Spell_Arcane_TeleportThunderBluff"};
		["Teleport: Ironforge"] = {t=10.0, icontex="Spell_Arcane_TeleportIronForge"};
		["Teleport: Orgrimmar"] = {t=10.0, icontex="Spell_Arcane_TeleportOrgrimmar"};
		["Teleport: Stormwind"] = {t=10.0, icontex="Spell_Arcane_TeleportStormWind"};
		["Teleport: Undercity"] = {t=10.0, icontex="Spell_Arcane_TeleportUnderCity"};
		["Fire Ward"] = {t=30.0, icontex="Spell_Fire_FireArmor"}; -- gain
		["Frost Ward"] = {t=30.0, icontex="Spell_Frost_FrostWard"}; -- gain
		["Evocation"] = {t=8.0, icontex="Spell_Nature_Purge"}; -- gain
		["Ice Block"] = {t=10.0, d=300.0, icontex="Spell_Frost_Frost"}; -- gain
		["Ice Barrier"] = {d=30.0, icontex="Spell_Ice_Lament"};
		["Blink"] = {d=15.0, icontex="Spell_Arcane_Blink"};
		--["Invisibility"] = {t=8, d=300, icontex=""}; -- gain
		--["Ice Lance"] = {t=1.5, icontex=""};
		--["Waterbolt"] = {t=2.5, icontex=""}; -- Mage Talent ('Pet' Spell)

		
		-- Paladin
		["Holy Light"] = {t=2.5, icontex="Spell_Holy_HolyBolt"};
		["Flash of Light"] = {t=1.5, icontex="Spell_Holy_FlashHeal"};
		["Summon Charger"] = {t=3.0, g=0.0, icontex="Ability_Mount_Charger"};
		["Summon Warhorse"] = {t=3.0, g=0.0, icontex="Spell_Nature_Swiftness"};
		["Hammer of Wrath"] = {t=1.0, d=6.0, icontex="Ability_ThunderClap"};
		["Holy Wrath"] = {t=2.0, d=60.0, icontex="Spell_Holy_Excorcism"};
		["Turn Undead"] = {t=1.5, d=30.0, icontex="Spell_Holy_TurnUndead"};
		["Redemption"] = {t=10.0, icontex="Spell_Holy_Resurrection"};
		["Divine Protection"] = {t=8.0, d=300.0, icontex="Spell_Holy_Restoration"}; -- gain
		["Divine Shield"] = {t=12.0, d=300.0, icontex="Spell_Holy_DivineIntervention"}; -- gain
		["Blessing of Freedom"] = {t=16.0, icontex="Spell_Holy_SealOfValor"}; -- gain
		["Blessing of Protection"] = {t=10.0, d=300.0, icontex="Spell_Holy_SealOfProtection"}; -- gain
		["Blessing of Sacrifice"] = {t=30.0, icontex="Spell_Holy_SealOfSacrifice"}; -- gain
		["Vengeance"] = {t=8.0, icontex="Ability_Racial_Avatar"}; -- gain, Talent
		--["Avenging Wrath"] = {t=20, d=180, icontex=""}; -- gain
		--["Divine Illumination"] = {t=10, d=180, icontex=""}; -- gain, Talent
		--["Avenger's Shild"] = {t=1, d=30, icontex=""}; -- Talent

	
		-- Priest
		["Greater Heal"] = {t=2.5, g=15, icontex="Spell_Holy_GreaterHeal"};
		["Heal"] = {t=2.5, icontex="Spell_Holy_Heal"};
		["Flash Heal"] = {t=1.5, icontex="Spell_Holy_FlashHeal"};
		["Resurrection"] = {t=10.0, icontex="Spell_Holy_Resurrection"};
		["Smite"] = {t=2.0, icontex="Spell_Holy_HolySmite"};
		["Mind Blast"] = {t=1.5, d=8.0, icontex="Spell_Shadow_UnholyFrenzy"};
		["Mind Control"] = {t=3.0, g=0.0, icontex="Spell_Shadow_ShadowWordDominate"};
		["Mana Burn"] = {t=3.0, icontex="Spell_Shadow_ManaBurn"};
		["Holy Fire"] = {t=3.0, icontex="Spell_Holy_SearingLight"};
		["Mind Soothe"] = {t=1.5, icontex="Spell_Holy_MindSooth"};
		["Prayer of Healing"] = {t=3.0, icontex="Spell_Holy_PrayerOfHealing02"};
		["Shackle Undead"] = {t=1.5, icontex="Spell_Nature_Slow"};
		["Fade"] = {t=10.0, d=30.0, icontex="Spell_Magic_LesserInvisibilty"}; -- gain
		["Renew"] = {t=15.0, icontex="Spell_Holy_Renew"}; -- gain
		["Abolish Disease"] = {t=20.0, icontex="Spell_Nature_NullifyDisease"}; -- gain
		["Feedback"] = {t=15.0, icontex="Spell_Shadow_RitualOfSacrifice"}; -- gain
		["Inspiration"] = {t=15.0, icontex="INV_Shield_06"}; -- gain (target), Talent
		["Power Infusion"] = {t=15.0, icontex="Spell_Holy_PowerInfusion"}; -- gain, Talent
		["Focused Casting"] = {t=6.0, icontex="Spell_Arcane_Blink"}; -- gain, Talent
		["Power Word: Shield"] = {t=30, d=15.0, icontex="Spell_Holy_PowerWordShield"}; -- gain
		["Armor of Faith"] = {t=30.0, icontex="Spell_Holy_BlessingOfProtection"}; -- gain, Priest Tier 3 [Vestments of Faith] 4/9 Proc
		["Inner Focus"] = {d=180, icontex="Spell_Frost_WindWalkOn"}; -- gain, Talent
		--["Mass Dispel"] = {t=1.5, icontex=""};
		--["Binding Heal"] = {t=1.5, icontex=""};
		--["Pain Suppression"] = {t=8, d=180, icontex=""}; -- gain, Talent
		--["Vampiric Touch"] = {t=1.5, icontex=""}; -- Talent
		
		-- Rogue
		["Disarm Trap"] = {t=2.0, icontex="Spell_Shadow_GrimWard"};
		["Sprint"] = {t=15.0, d=300.0, icontex="Ability_Rogue_Sprint"}; -- gain
		["Pick Lock"] = {t=5.0, icontex="Spell_Nature_MoonKey"};
		["Evasion"] = {t=15.0, d=300, icontex="Spell_Shadow_ShadowWard"}; -- gain
		["Vanish"] = {t=10.0, d=300, icontex="Ability_Vanish"}; -- gain
		["Blade Flurry"] = {t=15.0, d=120, icontex="Ability_Rogue_SliceDice"}; -- gain

		["Instant Poison VI"] = {t=3.0, icontex="Ability_Poisons"};
		["Deadly Poison V"] = {t=3.0, icontex="Ability_Rogue_DualWeild"};
		["Crippling Poison"] = {t=3.0, icontex="Ability_PoisonSting"};
		["Crippling Poison II"] = {t=3.0, icontex="Ability_PoisonSting"};
		["Mind-numbing Poison"] = {t=3.0, icontex="Spell_Nature_NullifyDisease"};
		["Mind-numbing Poison II"] = {t=3.0, icontex="Spell_Nature_NullifyDisease"};
		["Mind-numbing Poison III"] = {t=3.0, icontex="Spell_Nature_NullifyDisease"};
		--["Adrenaline Rush"] = {t=15, d=300, icontex=""}; -- gain, Talent
		--["Cloak of Shadows"] = {t=5, d=120, icontex=""}; -- gain, Talent

		
		-- Shaman
		["Lesser Healing Wave"] = {t=1.5, icontex="Spell_Nature_HealingWaveLesser"};
		["Healing Wave"] = {t=2.5, icontex="Spell_Nature_MagicImmunity"}; -- talent
		["Ancestral Spirit"] = {t=10.0, icontex="Spell_Nature_Regenerate"};
		["Chain Lightning"] = {t=1.5, d=6.0, icontex="Spell_Nature_ChainLightning"}; -- Talent counted
		["Ghost Wolf"] = {t=1.0, icontex="Spell_Nature_SpiritWolf"};
		["Astral Recall"] = {t=10.0, icontex="Spell_Nature_AstralRecal"};
		["Chain Heal"] = {t=2.5, icontex="Spell_Nature_HealingWaveGreater"};
		["Lightning Bolt"] = {t=2.0, icontex="Spell_Nature_Lightning"}; -- Talent counted
		["Far Sight"] = {t=2.0, icontex="Spell_Nature_FarSight"};
		["Stoneclaw Totem"] = {t=15.0, d=30.0, icontex="Spell_Nature_StoneClawTotem"}; -- '?-- works? -- gain
		["Mana Tide Totem"] = {t=15.0, d=300.0, icontex="Spell_Frost_SummonWaterElemental"}; -- '?-- works? -- gain
		["Fire Nova Totem"] = {t=5.0, d=15.0, icontex="Spell_Fire_SealOfFire"}; -- '?-- works? -- gain
		["Stormstrike"] = {t=12.0, d=25, icontex="Spell_Holy_SealOfMight"}; -- gain
		["Ancestral Fortitude"] = {t=15.0, icontex="Spell_Nature_UndyingStrength"}; -- gain (target), Talent
		["Healing Way"] = {t=15.0, icontex="Spell_Nature_HealingWay"}; -- gain (target), Talent
		["Grounding Totem"] = {d=15.0, icontex="Spell_Nature_GroundingTotem"}; -- works?
		["Elemental Mastery"] = {d=180, icontex="Spell_Nature_WispHeal"}; -- gain, Talent
		--["Shamanistic Rage"] = {t=30, d=120, icontex=""}; -- gain, Talent

		
		-- Warlock
		["Shadow Bolt"] = {t=2.5, icontex="Spell_Shadow_ShadowBolt"};
		["Immolate"] = {t=1.5, icontex="Spell_Fire_Immolation"};
		["Soul Fire"] = {t=4.0, d=60.0, icontex="Spell_Fire_Fireball02"};
		["Searing Pain"] = {t=1.5, icontex="Spell_Fire_SoulBurn"};
		["Summon Dreadsteed"] = {t=3.0, g=0.0, icontex="Ability_Mount_Dreadsteed"};
		["Summon Felsteed"] = {t=3.0, g=0.0, icontex="Spell_Nature_Swiftness"};
		["Summon Imp"] = {t=6.0, icontex="Spell_Shadow_Imp"};
		["Summon Succubus"] = {t=6.0, icontex="Spell_Shadow_SummonSuccubus"};
		["Summon Voidwalker"] = {t=6.0, icontex="Spell_Shadow_SummonVoidWalker"};
		["Summon Felhunter"] = {t=6.0, icontex="Spell_Shadow_SummonFelHunter"};
		["Fear"] = {t=1.5, icontex="Spell_Shadow_Possession"};
		["Howl of Terror"] = {t=2.0, d=40.0, g=0.0, icontex="Spell_Shadow_DeathScream"};
		["Banish"] = {t=1.5, icontex="Spell_Shadow_Cripple"};
		["Ritual of Summoning"] = {t=5.0, icontex="Spell_Shadow_Twilight"};
		["Ritual of Doom"] = {t=10.0, icontex="Spell_Shadow_AntiMagicShell"};
		["Create Spellstone"] = {t=5.0, icontex="INV_Misc_Gem_Sapphire_01"};
		["Create Soulstone"] = {t=3.0, icontex="Spell_Shadow_SoulGem"};
		["Create Healthstone"] = {t=3.0, icontex="INV_Stone_04"};
		["Create Major Healthstone"] = {t=3.0, icontex="INV_Stone_04"};
		["Create Firestone"] = {t=3.0, icontex="INV_Ammo_FireTar"};
		["Enslave Demon"] = {t=3.0, icontex="Spell_Shadow_EnslaveDemon"};
		["Inferno"] = {t=2.0, d=3600, icontex="Spell_Fire_Incinerate"};
		["Shadow Ward"] = {t=30.0, icontex="Spell_Shadow_AntiShadow"}; -- gain
		["Amplify Curse"] = {t=30.0, d=180, icontex="Spell_Shadow_Contagion"}; -- gain
		--["Seed of Corruption"] = {t=2, icontex=""};
		--["Ritual of Souls"] = {t=3, d=300, icontex=""};
		--["Incinerate"] = {t=2.5, icontex=""};

			-- Imp
			["Firebolt"] = {t=1.5, icontex="Spell_Fire_FireBolt"};
			
			-- Succubus
			["Seduction"] = {t=1.5, icontex="Spell_Shadow_MindSteal"};
			["Soothing Kiss"] = {t=4.0, d=4.0, icontex="Spell_Shadow_SoothingKiss"};
			
			-- Voidwalker
			["Consume Shadows"] = {t=10.0, icontex="Spell_Shadow_AntiShadow"}; -- gain
		
		-- Warrior
		["Bloodrage"] = {t=10.0, d=60, icontex="Ability_Racial_BloodRage"}; -- gain
		["Bloodthirst"] = {t=8.0, icontex="Spell_Nature_BloodLust"}; -- gain
		["Shield Wall"] = {t=10.0, d=1800.0, icontex="Ability_Warrior_ShieldWall"}; -- gain
		["Recklessness"] = {t=15.0, d=1800.0, icontex="Ability_CriticalStrike"}; -- gain
		["Retaliation"] = {t=15.0, d=1800.0, icontex="Ability_Warrior_Challange"}; -- gain
		["Berserker Rage"] = {t=10.0, d=30, icontex="Spell_Nature_AncestralGuardian"}; -- gain
		["Last Stand"] = {t=20.0, d=600, icontex="Spell_Holy_AshesToAshes"}; -- gain
		--["Last Stand"] = {t=20.0, d=480, icontex="Spell_Holy_AshesToAshes"}; -- gain
		["Death Wish"] = {t=30.0, d=180, icontex="Spell_Shadow_DeathPact"}; -- gain
		-- ["Enrage"] = {t=12.0, icontex="Spell_Shadow_UnholyFrenzy"}; -- gain
		["Shield Block"] = {t=5.5, icontex="Ability_Defend"}; -- gain, 1 Talent point in impr. block
		--["Victory Rush"] = {t=30, icontex=""}; -- gain
		--["Spell Reflection"] = {t=5, d=10, icontex=""}; -- gain


		-- Mobs
		["Shrink"] = {t=3.0, icontex="Spell_Ice_MagicDamage"};
		["Banshee Curse"] = {t=2.0, icontex="Spell_Nature_Drowsy"};
		["Shadow Bolt Volley"] = {t=3.0, icontex="Spell_Shadow_ShadowBolt"};
		["Cripple"] = {t=3.0, icontex="Spell_Shadow_Cripple"};
		["Dark Mending"] = {t=3.5, icontex="Spell_Shadow_ChillTouch"}; -- gain
		["Spirit Decay"] = {t=2.0, icontex="Spell_Holy_HarmUndeadAura"};
		["Gust of Wind"] = {t=2.0, icontex="Spell_Nature_EarthBind"};
		["Black Sludge"] = {t=3.0, icontex="Spell_Shadow_CallofBone"};
		["Toxic Bolt"] = {t=2.0, icontex="Spell_Nature_CorrosiveBreath"};
		["Poisonous Spit"] = {t=2.0, icontex="Spell_Nature_CorrosiveBreath"};
		["Wild Regeneration"] = {t=3.0, g=0, icontex="Spell_Nature_Rejuvenation"};
		["Curse of the Deadwood"] = {t=2.0, icontex="Spell_Shadow_GatherShadows"};
		["Curse of Blood"] = {t=2.0, icontex="Spell_Shadow_RitualOfSacrifice"};
		["Dark Sludge"] = {t=5.0, icontex="Spell_Shadow_CreepingPlague"};
		["Plague Cloud"] = {t=2.0, icontex="Spell_Shadow_CallofBone"};
		["Wandering Plague"] = {t=2.0, icontex="Spell_Shadow_CallofBone"};
		["Wither Touch"] = {t=2.0, icontex="Spell_Nature_Drowsy"};
		["Fevered Fatigue"] = {t=3.0, icontex="Spell_Nature_NullifyDisease"};
		["Encasing Webs"] = {t=2.0, icontex="Spell_Nature_EarthBind"};
		["Crystal Gaze"] = {t=2.0, icontex="Ability_GolemThunderClap"};
		["Flamespit"] = {t=3.0, icontex="Spell_Fire_FlameBolt"};
		["Lizard Bolt"] = {t=2.0, icontex="Spell_Nature_Lightning"};
		["Plague Mind"] = {t=4.0, icontex="Spell_Shadow_CallofBone"};

		
	}
	
	CEnemyCastBar_Raids = {

		-- "mcheck" to only show a bar if cast from this mob. Shows a spell if the mobname is a part of 'mcheck'. mcheck="Ragnaros - Princess Yauj" possible!
		-- "m" sets a mob's name for the castbar; "i" shows a second bar; "r" sets a different CastTime for this Mob (r = "Mob1 Mob2 Mob3" possible *g*)
		-- "active" only allows this spell to be an active cast, no afflictions and something else!
		-- "global" normally is used for afflictions to be shown even it's not your target, but here the important feature is that the castbar won't be updated if active!
		-- "checktarget" checks if the mob casted this spell is your current target. Normally this isn't done with RaidSpells.
		-- "icasted" guides this spell through the instant cast protection
		-- checkevent="Event1 - Event2" to bind spells to only trigger a castbar if these events were fired. (Example: checkevent="CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE - CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" )
		-- checkengage="true" will only trigger a castbar if the engage protection is running! (Used for Yauj fear for example to prevent CBs at other Mobs that fear players within AQ!)
		-- aZone="InstanceName" to only allow this spell to trigger a CastBar in the specific (Main)Zone. (Not the minimap zone, but the big global Zone e.g. Stormwind, not Trade District! Example: aZone="Ahn'Qiraj"
		-- aBar="NextSpellName" will trigger the defined spell instantly when the source CastBar runs out (e.g. 'Dark Glare'). Will only do that if the User is in combat or dead! Won't broadcast the next triggered spell to the raid!
		-- pBar="NextSpellName" will trigger the defined spell instantly when the source CastBar APPEARS! (e.g. 'Web Spray'). Won't broadcast the next triggered spell to the raid!
		-- delBar="SpellName" will delete the defined spell instantly when the source CastBar runs out! (e.g. 'Locust Swarm').
		-- tchange={"SpellName", duration1, duration2} will change the duration of defined Spell when the CastBar runs out (e.g. tchange={"Inevitable Doom", 30, 15} for '15 sec Doom CD!' Bar). Duration1 is applied (reset) if the EngageProtection is disabled and the player enters combat the next time! Enables the EngageProtection!

		-- Naxxramas

			["Necro Stalker"] = {t=1800.0, c="cooldown", global="true", m="Respawn", icontex="Spell_Holy_Resurrection"};

			-- Anub'Rekhan
			["First Locust Swarm"] = {t=90, c="cooldown", icontex="Spell_Nature_InsectSwarm"};
			["Locust Swarm"] = {t=23, i=3, c="gains", delBar="Locust Swarm CD", aBar="Locust Swarm CD", active="true", icontex="Spell_Nature_InsectSwarm"};
			["Locust Swarm CD"] = {t=70, c="cooldown", icontex="Spell_Nature_InsectSwarm"};

			-- Patchwerk
			["Enraged Mode"] = {t=420, c="cooldown", icontex="Spell_Shadow_UnholyFrenzy"}; -- don't translate, used internally!

			-- Razuvious
			["Disrupting Shout"] = {t=25, c="cooldown", active="true", icontex="Ability_Creature_Disease_02"};

			-- Gluth
			["Terrifying Roar"] = {t=20.0, c="cooldown", m="Gluth", icontex="Ability_Devour"}; -- Gluth Fears every 20seconds
			["Decimate"] = {t=105, c="cooldown", active="true", icontex="Ability_Creature_Disease_02"};

			-- Maexxna
			["Web Spray"] = {t=40, c="cooldown", pBar="Mini Spiders", m="Maexxna", aZone="Naxxramas", icontex="Ability_Ensnare"};
			["Mini Spiders"] = {t=30, c="cooldown", pBar="Web Wrap CD", icontex="INV_Misc_MonsterSpiderCarapace_01"};
			["Web Wrap CD"] = {t=20, c="cooldown", icontex="Spell_Nature_Web"};

			-- Thaddius
			["Polarity Shift"] = {t=30, i=3, c="cooldown", pBar="Becomes enraged!", mcheck="Thaddius", icontex="Spell_Nature_Lightning"};
			["Power Surge"] = {t=10, c="gains", mcheck="Stalagg", icontex="Spell_Shadow_SpectralSight"};
			["Becomes enraged!"] = {t=290, c="cooldown", global="true", tchange={"Becomes enraged!", 290, 0}, icontex="Spell_Shadow_UnholyFrenzy"}; -- don't translate, used internally! -- wont be updated

			-- Faerlina
			["Enrage"] = {t=60, c="cooldown", mcheck="Grand Widow Faerlina", icontex="Spell_Shadow_UnholyFrenzy"};
			["Widow's Embrace"] = {t=30, c="cooldown", mcheck="Grand Widow Faerlina", icontex="Spell_Arcane_Blink"}; -- Fearlina

			-- Loatheb
			["15 sec Doom CD!"] = {t=299, tchange={"Inevitable Doom", 30, 15}, c="cooldown", m="Loatheb", icontex="Spell_Shadow_NightOfTheDead"}; -- don't translate, used internally!
			["First Inevitable Doom"] = {t=120, c="cooldown", m="Loatheb", icontex="Spell_Shadow_NightOfTheDead"}; -- don't translate, used internally!
			["Inevitable Doom"] = {t=30, c="cooldown", m="Loatheb", icontex="Spell_Shadow_NightOfTheDead"};

			["Summon Spore"] = {t=12.5, icasted="true", c="cooldown", mcheck="Loatheb", icontex="Spell_Nature_AbolishMagic"};
			["Remove Curse on Loatheb"] = {t=0.1, icasted="true", c="cooldown", pBar="Curses Removed", mcheck="Loatheb"};
			["Curses Removed"] = {t=30, c="cooldown", icontex="Spell_Nature_RemoveCurse"};

			-- Gothik
			-- don't translate, ALL used internally!
			["Comes Down"] = {t=270, c="cooldown", aBar="del1", icontex="Spell_Shadow_RaiseDead"};
			["del1"] = {t=0.1, pBar="del2", delBar="Trainees INC"};
			["del2"] = {t=0.1, pBar="del3", delBar="Deathknights INC"};
			["del3"] = {t=0.1, delBar="Rider INC"};
			
			["First Trainees"] = {t=27, c="cooldown", aBar="Trainees INC", icontex="INV_Misc_Head_Undead_01"};
			["First Deathknights"] = {t=77, c="cooldown", aBar="Deathknights INC", icontex="Spell_Shadow_ShadowWard"};
			["First Rider"] = {t=137, c="cooldown", aBar="Rider INC", icontex="Ability_Mount_Undeadhorse"};
			["Trainees INC"] = {t=20, c="cooldown", aBar="Trainees INC", icontex="INV_Misc_Head_Undead_01"};
			["Deathknights INC"] = {t=25, c="cooldown", aBar="Deathknights INC", icontex="Spell_Shadow_ShadowWard"};
			["Rider INC"] = {t=30, c="cooldown", aBar="Rider INC", icontex="Ability_Mount_Undeadhorse"}; 

			-- Noth
			["Blink"] = {t=30, c="cooldown", mcheck="Noth the Plaguebringer", aZone="Naxxramas", icontex="Spell_Arcane_Blink"}; --Noth blinks every 30sec, agro reset.
			["First Teleport"] = {t=90, c="cooldown", aBar="On Balcony 1", aZone="Naxxramas", icontex="Spell_Nature_AstralRecalGroup"};
			["On Balcony 1"] = {t=70, c="cooldown", aBar="Second Teleport", icontex="Spell_Nature_AstralRecalGroup"};
			["Second Teleport"] = {t=110, c="cooldown", aBar="On Balcony 2", icontex="Spell_Nature_AstralRecalGroup"};
			["On Balcony 2"] = {t=95, c="cooldown", aBar="Third Teleport", icontex="Spell_Nature_AstralRecalGroup"};
			["Third Teleport"] = {t=180, c="cooldown", aBar="On Balcony 3", icontex="Spell_Nature_AstralRecalGroup"};
			["On Balcony 3"] = {t=120, c="cooldown", icontex="Spell_Nature_AstralRecalGroup"};

			-- Heigan
			["On Platform"] = {t=45, c="cooldown", aBar="Teleport CD", icontex="INV_Enchant_EssenceAstralLarge"};
			["Teleport CD"] = {t=90, c="cooldown", icontex="INV_Enchant_EssenceAstralLarge"};

			-- Sapphiron
			["Life Drain"] = {t=24, c="cooldown", m="Sapphiron", aZone="Naxxramas", icontex="Spell_Shadow_LifeDrain02"};

		-- Ahn'Qiraj
		
			-- 40 Man
				["Obsidian Eradicator"] = {t=1800.0, c="cooldown", global="true", m="Respawn", icontex="Spell_Holy_Resurrection"};
	
				-- Twin Emperors
				["Twin Teleport"] = {t=30.0, c="cooldown", icasted="true", icontex="Spell_Arcane_Blink"};
				["Explode Bug"] = {t=5.0, c="gains", icontex="Spell_Fire_Fire"};
				["Mutate Bug"] = {t=5.0, c="gains", icontex="Ability_Hunter_Pet_Scorpid"};

				-- Ouro
				["Sand Blast"] = {t=2.0, c="hostile", mcheck="Ouro", icontex="Spell_Nature_Cyclone"};
				["Sweep"] = {t=21, i=1.0, c="cooldown", mcheck="Ouro", icontex="Spell_Nature_Thorns"};

				["Summon Ouro Mounds"] = {t="0.1", delBar="Possible Ouro Submerge", icasted="true", pBar="Submerged"};
				["Submerged"] = {t=30, c="cooldown", delBar="Ouro Submerges", aBar="Possible Ouro Submerge", icontex="INV_Qiraj_OuroHide"};
				["Possible Ouro Submerge"] = {t=90, c="cooldown", pBar="Ouro Submerges", icontex="Spell_Shadow_DemonBreath"};
				["Ouro Submerges"] = {t=180, c="cooldown", icontex="Spell_Shadow_DemonBreath"}; 


				-- C'Thun
				["First Dark Glare"] = {t=48, c="cooldown", aBar="Dark Glare", icontex="Spell_Nature_CallStorm"}; -- don't translate, used internally!
				["Weakened!"] = {t=45, c="gains", delBar="Small Eyes P2", aBar="After Weakened Eyes", icontex="Ability_Hunter_SniperShot"}; -- don't translate, used internally!
				["Dark Glare"] = {t=86, i=40, c="cooldown", active="true", aBar="Dark Glare", icontex="Spell_Nature_CallStorm"}; -- don't translate, used internally!
				["Small Eyes P1"] = {t=45, c="cooldown", aBar="Small Eyes P1", icontex="Spell_Shadow_SiphonMana"}; -- don't translate, used internally!
				["First Small Eyes P2"] = {t=42, c="cooldown", aBar="Small Eyes P2", icontex="Spell_Shadow_SiphonMana"}; -- don't translate, used internally!
				["Small Eyes P2"] = {t=30, c="cooldown", aBar="Small Eyes P2", icontex="Spell_Shadow_SiphonMana"}; -- don't translate, used internally!
				["After Weakened Eyes"] = {t=38, c="cooldown", aBar="Small Eyes P2", icontex="Spell_Shadow_SiphonMana"}; -- don't translate, used internally!

				-- Skeram
				["Arcane Explosion"] = {t=1.2, c="hostile", mcheck="The Prophet Skeram", icontex="Spell_Nature_WispSplode"};

				-- Sartura (Twin Emps enrage + Hakkar enrage)
				["Whirlwind"] = {t=15.0, c="gains", mcheck="Battleguard Sartura", icontex="Ability_Whirlwind"};
				["Enraged mode"] = {t=900, r="Sartura Hakkar", a=600, c="cooldown", icontex="Spell_Shadow_UnholyFrenzy"}; -- don't translate, used internally! +if player enters combat and target are twins!
				["Enters Enraged mode"] = {t=3, c="gains", icontex="Spell_Shadow_UnholyFrenzy"}; -- don't translate, used internally!

				-- Huhuran
				["Berserk mode"] = {t=300, c="cooldown", icontex="Racial_Troll_Berserk"}; -- don't translate, used internally! if player enters combat and target is Huhuran!
				["Enters Berserk mode"] = {t=3, c="gains", icontex="Racial_Troll_Berserk"}; -- don't translate, used internally!
				["Wyvern Sting"] = {t=25, c="cooldown", m="Huhuran", aZone="Ahn'Qiraj", checkevent="CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE - CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE - CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", icontex="INV_Spear_02"};

				-- Yauj
				["Fear"] = {t=20, c="cooldown", checkengage="true", m="Yauj", aZone="Ahn'Qiraj", checkevent="CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE - CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE - CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", icontex="Spell_Shadow_Possession"};
				["Great Heal"] = {t=2.0, c="hostile", m="Yauj", mcheck="Princess Yauj", icontex="Spell_Holy_Heal"};
    				
			
			-- 20 Man

				["Explode"] = {t=6.0, c="hostile", icontex="Spell_Fire_SelfDestruct"};

				-- Ossirian
				["Arcane Weakness"] = {t=45, c="gains", mcheck="Ossirian the Unscarred", icontex="INV_Misc_QirajiCrystal_01"};
				["Fire Weakness"] = {t=45, c="gains", mcheck="Ossirian the Unscarred", icontex="INV_Misc_QirajiCrystal_02"};
				["Nature Weakness"] = {t=45, c="gains", mcheck="Ossirian the Unscarred", icontex="INV_Misc_QirajiCrystal_03"};
				["Frost Weakness"] = {t=45, c="gains", mcheck="Ossirian the Unscarred", icontex="INV_Misc_QirajiCrystal_04"};
				["Shadow Weakness"] = {t=45, c="gains", mcheck="Ossirian the Unscarred", icontex="INV_Misc_QirajiCrystal_05"};
	
				-- Moam
				["Until Stoneform"] = {t=90, c="grey", icontex="Spell_Shadow_UnholyStrength"}; -- don't translate, used internally!
				["Energize"] = {t=90, c="gains", icontex="Spell_Nature_Cyclone"};

		-- Zul'Gurub

			-- Hakkar
			["Blood Siphon"] = {t=90.0, c="cooldown", mcheck="Hakkar", checkevent="CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", icontex="Spell_Shadow_LifeDrain02"};

		-- Molten Core

			-- Shazzrah
			["Gate of Shazzrah"] = {t=45.0, c="cooldown", icasted="true", icontex="Spell_Arcane_Blink"};
		
			-- Lucifron
			["Impending Doom"] = {t=20.0, c="cooldown", m="Lucifron", icontex="Spell_Shadow_NightOfTheDead"};
			["Lucifron's Curse"] = {t=20.0, c="cooldown", m="Lucifron", icontex="Spell_Shadow_BlackPlague"};
		
			-- Magmadar
			["Panic"] = {t=30.0, c="cooldown", m="Magmadar", icontex="Spell_Shadow_DeathScream"};

			-- Gehennas
			["Gehennas' Curse"] = {t=30.0, c="cooldown", m="Gehennas", icontex="Spell_Shadow_GatherShadows"};

			-- Geddon
			["Inferno"] = {t=8.0, c="gains", mcheck="Baron Geddon", icontex="Spell_Fire_Incinerate"};

			-- Majordomo
			["Magic Reflection"] = {t=30.0, i=10.0, c="cooldown", m="Majordomo", aZone="Molten Core", icontex="Spell_Frost_FrostShock"};
			["Damage Shield"] = {t=30.0, i=10.0, c="cooldown", m="Majordomo", icontex="Spell_Nature_LightningShield"};
			
			-- Ragnaros
			["Submerge"] = {t=180.0, c="cooldown", icontex="Spell_Fire_Volcano"}; -- don't translate, used internally!
			["Knockback"] = {t=28.0, c="cooldown", icontex="Ability_Kick"}; -- don't translate, used internally!
			["Sons of Flame"] = {t=90.0, c="cooldown", icontex="ell_Fire_LavaSpawn"}; -- don't translate, used internally!

		-- Onyxia
			["Flame Breath"] = {t=2.0, c="hostile", active="true", icontex="Spell_Fire_Fire"};
			["Deep Breath"] = {t=5.0, c="hostile", icontex="Spell_Fire_Incinerate"}; 
			
		-- Blackwing Lair

			-- Razorgore
			["Mob Spawn (45sec)"] = {t=45.0, c="cooldown", icontex="Spell_Shadow_RaiseDead"}; -- don't translate, used internally!

			-- Firemaw/Flamegor/Ebonroc
			["Wing Buffet"] = {t=31.5, i=1.2, c="cooldown", r="Onyxia", a=0, icontex="INV_Misc_MonsterScales_14"};
			["First Wingbuffet"] = {t=30.0, c="cooldown", icontex="INV_Misc_MonsterScales_14"}; -- don't translate, used internally! if player enters combat and target is firemaw or flamegor this castbar appears to catch the first wingbuffet!
			["Shadow Flame"] = {t=2.0, c="hostile", active="true", icontex="Spell_Fire_Incinerate"};
			
			-- Flamegor
			[CECB_SPELL_FRENZY_CD] = {t=10.0, c="cooldown", icontex="INV_Misc_MonsterClaw_03"}; -- don't translate, used internally!
			
			-- Chromaggus
			["Frost Burn"] = {t=60.0, i=2.0, c="cooldown", active="true", icontex="Spell_Frost_ChillingBlast"};
			["Time Lapse"] = {t=60.0, i=2.0, c="cooldown", active="true", icontex="Spell_Arcane_PortalOrgrimmar"};
			["Ignite Flesh"] = {t=60.0, i=2.0, c="cooldown", active="true", icontex="Spell_Fire_Fire"};
			["Corrosive Acid"] = {t=60.0, i=2.0, c="cooldown", active="true", icontex="Spell_Nature_Acid_01"};
			["Incinerate"] = {t=60.0, i=2.0, c="cooldown", active="true", mcheck="Chromaggus", icontex="Spell_Fire_FlameShock"};
			["Killing Frenzy"] = {t=15.0, c="cooldown", icontex="INV_Misc_MonsterClaw_03"}; -- don't translate, used internally!
				-- Chromaggus, Flamegor, Magmadar etc.
			["Frenzy"] = {t=8.0, c="gains", checktarget="true", icontex="INV_Misc_MonsterClaw_03"};
			
			-- Neferian/Onyxia
			["Bellowing Roar"] = {t=2.0, c="hostile", r="Onyxia", a=1.5, active="true", icontex="Spell_Shadow_Charm"};
			
			-- Nefarian			
			["Nefarian calls"] = {t=30.0, c="gains", icontex="INV_Misc_Head_Dragon_Black"}; -- don't translate, used internally!
			["Mob Spawn"] = {t=8.0, c="hostile", icontex="Spell_Shadow_RaiseDead"}; -- don't translate, used internally!
			["Landing"] = {t=10.0, c="hostile", icontex="INV_Misc_Head_Dragon_Black"}; -- don't translate, used internally!
			
		-- Outdoor
		
			-- Azuregos
			["Manastorm"] = {t=10.0, c="hostile", icontex="Spell_Frost_IceStorm"};

		-- Other

			["Boss incoming"] = {t=0}; -- don't translate, used internally!

	}


	CEnemyCastBar_Afflictions = {

	-- Warning: only add Spells with the "CEnemyCastBar_SPELL_AFFLICTED" pattern here!
	-- fragile="true", if mob with the same name dies, the bar won't be removed
	-- multi="true", the bar is not removed if debuff fades earlier (usefull if one spell is allowed to produce multiple afflictions)
	-- stun="true", flags all spells which use the same Diminishing Return timer. These 8 Spells were tested to use one and the same timer.
		-- stuntype="true", forces non stun="true" CastBars to use the stun-color
	-- death="true", removes the castbar although it is a "fragile"
	-- periodicdmg="true" -> don't update and remove those castbars, only allows periodic damage done by yourself
	-- spellDR="true", triggers a separate class DR Timer;
		-- always(!) use spellDR together with sclass="PlayersCLASS", or you will produce errors!
	-- affmob="true", this stun triggers a class specific DR Timer on a mob (not player), too
	-- drshare="name", all spells with the same drshare name will trigger the same DR Timer called 'name'
	-- checkclass="classname", will only show this spell to specified class
	-- tskill={talentTab, talentNumber, talentTimeBonus, talentClass, offset, relativeTimeBonus(optional) }, adds "talentTimeBonus" to the duration of this skill depending on invested skillpoints! "Offset" is additionally added to the duration if at least one talentpoint is invested.
	-- more to tskill: if "talentTimeBonus" is 0 then the relativeTimeBonus(optional) is used (percentage), needed for hunters talent
	-- plevel={durationBonusPerSkillLevel, PlayerLevelAbleToLearnNewSkillLevel (e.g. 60, 40, 20), exchangeLowestLevelWith "0" ALWAYS!} (correct examples are below)
	-- aZone="InstanceName" to only allow this spell to trigger a CastBar in the specific (Main)Zone. (Not the minimap zone, but the big global Zone e.g. Stormwind, not Trade District! Example: aZone="Ahn'Qiraj"
	-- blockZone="ZoneName" blocks the spell for the specified Zone (example: blockZone="Ahn'Qiraj" for 'Entangling Roots')
	-- cpinterval=X, reduces spell duration by X for every ComboPoint lower than 5 (maximum); ALWAYS use with cpclass="CHARACTERCLASS"!

		-- Naturfreund | Warrior Afflicions
		["Taunt"] = {t=3.0, multi="true", icontex="Spell_Nature_Reincarnation"};
		["Mocking Blow"] = {t=6.0, multi="true", icontex="Ability_Warrior_PunishingBlow"};
		["Challenging Shout"] = {t=6, multi="true", icontex="Ability_BullRush"};
		["Hamstring"] = {t=15.0, icontex="Ability_ShockWave"};
		["Piercing Howl"] = {t=6.0, icontex="Spell_Shadow_DeathScream"};
			["Shield Bash - Silenced"] = {t=4, solo="true", icontex="Ability_Warrior_ShieldBash"};
			["Concussion Blow"] = {t=5, solo="true", stun="true", icontex="Ability_ThunderBolt"};
			["Charge Stun"] = {t=1, solo="true", stun="true", icontex="Ability_Warrior_Charge"};
			["Intercept Stun"] = {t=3, solo="true", stun="true", icontex="Ability_Rogue_Sprint"};
			["Revenge Stun"] = {t=3, solo="true", stuntype="true", icontex="Ability_Warrior_Revenge"};
			["Intimidating Shout"] = {t=8, solo="true", icontex="Ability_GolemThunderClap"};
			["Disarm"] = {t=10, solo="true", icontex="Ability_Warrior_Disarm"};
			["Mortal Strike"] = {t=10, solo="true", icontex="Ability_Warrior_SavageBlow"};
		["Demoralizing Shout"] = {t=30, checkclass="WARRIOR", icontex="Ability_Warrior_WarCry"};
		["Thunder Clap"] = {t=30, checkclass="WARRIOR", icontex="Spell_Nature_ThunderClap"};
			-- periodic damage spells
				["Rend"] = {t=21, periodicdmg="true", icontex="Ability_Gouge"};

		-- Naturfreund | Mage Afflicions
		["Blast Wave"] = {t=6.0, solo="true", stuntype="true", icontex="Spell_Holy_Excorcism_02"};
		--["Slow"] = {t=15.0, icontex=""};
			["Frost Nova"] = {t=8.0, magecold="true", icontex="Spell_Frost_FrostNova"};
			["Frostbite"] = {t=5.0, magecold="true", icontex="Spell_Frost_FrostArmor"};
			["Chilled"] = {t=5.0, magecold="true", icontex="Spell_Frost_IceStorm"};
			["Cone of Cold"] = {t=8.0, magecold="true", icontex="Spell_Frost_Glacier"}; -- slightly improved with talents (+1 sec)
			["Frostbolt"] = {t=9, magecold="true", icontex="Spell_Frost_FrostBolt02"}; -- slightly improved with talents (+1 sec)
			["Winter's Chill"] = {t=15, magecold="true", icontex="Spell_Frost_ChillingBlast"};
			["Fire Vulnerability"] = {t=30, magecold="true", icontex="Spell_Fire_SoulBurn"};
		["Polymorph"] = {t=50, plevel={10, 60, 40, 20, 0}, fragile="true", spellDR="true", drshare="Polymorph", sclass="MAGE", icontex="Spell_Nature_Polymorph"};
		["Polymorph: Pig"] = {t=50, plevel={10, 60, 40, 20, 0}, fragile="true", spellDR="true", drshare="Polymorph", sclass="MAGE", icontex="Spell_Magic_PolymorphPig"};
		["Polymorph: Turtle"] = {t=50, plevel={10, 60, 40, 20, 0}, fragile="true", spellDR="true", drshare="Polymorph", sclass="MAGE", icontex="Ability_Hunter_Pet_Turtle"};
			["Counterspell - Silenced"] = {t=4, solo="true", icontex="Spell_Frost_IceShock"};
			-- periodic damage spells
				["Flamestrike"] = {t=8, periodicdmg="true", icontex="Spell_Fire_SelfDestruct"};

		-- Naturfreund | Hunter Afflicions
		["Wing Clip"] = {t=10, icontex="Ability_Rogue_Trip"};
			["Improved Concussive Shot"] = {t=3, solo="true", stuntype="true", icontex="Spell_Frost_Stun"};
		["Freezing Trap Effect"] = {t=20.0, plevel={5, 60, 40, 0}, tskill={3, 7, 0, "HUNTER", 0, 0.15}, fragile="true", spellDR="true", sclass="HUNTER", icontex="Spell_Frost_ChainsOfIce"};
		["Expose Weakness"] = {t=7.0, checkclass="HUNTER", icontex="Ability_Hunter_SniperShot"};
		["Concussive Shot"] = {t=4, icontex="Spell_Frost_Stun"}; 
		["Viper Sting"] = {t=8, checkclass="HUNTER", icontex="Ability_Hunter_AimedShot"};
		["Counterattack"] = {t=5, icontex="Ability_Warrior_Challange"};
		["Scorpid Sting"] = {t=20, checkclass="HUNTER", icontex="Ability_Hunter_CriticalShot"};
			["Wyvern Sting"] = {t=12, solo="true", icontex="INV_Spear_02"};
			["Scatter Shot"] = {t=4.0, solo="true", icontex="Ability_GolemStormBolt"}; 
			-- periodic damage spells
				["Serpent Sting"] = {t=15, periodicdmg="true", icontex="Ability_Hunter_Quickshot"};

		-- Naturfreund | Priest Afflicions
		["Shadow Vulnerability"] = {t=15, magecold="true", icontex="Spell_Shadow_ShadowBolt"};
		["Mind Soothe"] = {t=15, icontex="Spell_Holy_MindSooth"};
		["Shackle Undead"] = {t=50, plevel={10, 60, 40, 0}, fragile="true", spellDR="true", sclass="PRIEST", icontex="Spell_Nature_Slow"};
			["Psychic Scream"] = {t=8, solo="true", icontex="Spell_Shadow_PsychicScream"};
			["Silence"] = {t=5, solo="true", icontex="Spell_Shadow_ImpPhaseShift"};
			-- periodic damage spells
				["Shadow Word: Pain"] = {t=18, tskill={3, 4, 3, "PRIEST", 0}, periodicdmg="true", icontex="Spell_Shadow_ShadowWordPain"};
				["Devouring Plague"] = {t=24, periodicdmg="true", icontex="Spell_Shadow_BlackPlague"};
				["Holy Fire"] = {t=10, periodicdmg="true", directhit="true", icontex="Spell_Holy_SearingLight"};
				--["Vampiric Touch"] = {t=15, periodicdmg="true", icontex=""};

		-- Naturfreund | Warlock Afflicions
		["Banish"] = {t=30, plevel={10, 48, 0}, fragile="true", icontex="Spell_Shadow_Cripple"};
		-- Succubus
		["Seduction"] = {t=15, fragile="true", spellDR="true", sclass="WARLOCK", drshare="Sed., Fear", icontex="Spell_Shadow_MindSteal"};
			["Fear"] = {t=20, solo="true", spellDR="true", sclass="WARLOCK", drshare="Sed., Fear", icontex="Spell_Shadow_Possession"};
		["Curse of Exhaustion"] = {t=12, icontex="Spell_Shadow_GrimWard"};
			["Curse of Tongues"] = {t=30, checkclass="WARLOCK", icontex="Spell_Shadow_CurseOfTounges"};
			["Curse of Doom"] = {t=60, checkclass="WARLOCK", icontex="Spell_Shadow_AuraOfDarkness"};
			-- periodic damage spells
				["Curse of Agony"] = {t=24, periodicdmg="true", icontex="Spell_Shadow_CurseOfSargeras"};
				["Corruption"] = {t=18, periodicdmg="true", icontex="Spell_Shadow_AbominationExplosion"};
				["Immolate"] = {t=15, periodicdmg="true", directhit="true", icontex="Spell_Fire_Immolation"};
				["Siphon Life"] = {t=30, periodicdmg="true", icontex="Spell_Shadow_Requiem"};
				--["Seed of Corruption"] = {t=18, periodicdmg="true", icontex=""};

			["Shadowburn"] = {t=5, periodicdmg="true", icontex="Spell_Shadow_ScourgeBuild"}; -- special case

		-- Naturfreund | Rogue Afflicions
		["Crippling Poison"] = {t=12, icontex="Ability_PoisonSting"};
		["Sap"] = {t=45, plevel={10, 48, 28, 0}, fragile="true", spellDR="true", sclass="ROGUE", drshare="Sap, Gouge", icontex="Ability_Sap"};
			["Kidney Shot"] = {t=6, cpinterval=1, cpclass="ROGUE", solo="true", stuntype="true", spellDR="true", sclass="ROGUE", affmob="true", icontex="Ability_Rogue_KidneyShot"}; -- own DR
			["Cheap Shot"] = {t=4, solo="true", stun="true", icontex="Ability_CheapShot"}; 
			["Gouge"] = {t=4, tskill={2, 1, 0.5, "ROGUE", 0}, solo="true", stuntype="true", spellDR="true", sclass="ROGUE", drshare="Sap, Gouge", icontex="Ability_Gouge"}; -- normal 4sec impr. 5.5sec (no DR)
			["Blind"] = {t=10, solo="true", spellDR="true", sclass="ROGUE", icontex="Spell_Shadow_MindSteal"};
			["Kick - Silenced"] = {t=2, solo="true", icontex="Ability_Kick"};
			["Riposte"] = {t=6, solo="true", icontex="Ability_Warrior_Disarm"};
			["Expose Armor"] = { t=30.0, checkclass="ROGUE", icontex="Ability_Warrior_Riposte" };
			-- periodic damage spells
				["Garrote"] = {t=18, periodicdmg="true", icontex="Ability_Rogue_Garrote"};
				["Rupture"] = {t=16, cpinterval=2, cpclass="ROGUE", periodicdmg="true", icontex="Ability_Rogue_Rupture"};

		-- Naturfreund | Druid Afflicions
		["Growl"] = {t=3, multi="true", icontex="Ability_Physical_Taunt"};
		["Challenging Roar"] = {t=6, multi="true", icontex="Ability_Druid_ChallangingRoar"};
		--["Cyclone"] =	{t=6, spellDR="true", sclass="DRUID", icontex=""};
		--["Maim"] = {t=6, cpinterval=1, cpclass="DRUID", spellDR="true", sclass="DRUID", solo="true", icontex=""};
		["Entangling Roots"] = {t=27, fragile="true", death="true", blockZone="Ahn'Qiraj", spellDR="true", sclass="DRUID", icontex="Spell_Nature_StrangleVines"};
		["Hibernate"] = {t=40, plevel={10, 58, 38, 0}, fragile="true", icontex="Spell_Nature_Sleep"};
			["Bash"] = {t=4, tskill={2, 4, 0.5, "DRUID", 0}, plevel={1, 46, 30, 0}, solo="true", stun="true", icontex="Ability_Druid_Bash"};
			["Pounce"] = {t=2, tskill={2, 4, 0.5, "DRUID", 0}, solo="true", stun="true", icontex="Ability_Druid_SupriseAttack"};
			["Feral Charge"] = {t=4, solo="true", icontex="Ability_Hunter_Pet_Bear"};
		["Faerie Fire"] = {t=40, checkclass="DRUID", icontex="Spell_Nature_FaerieFire"};
		["Faerie Fire (Feral)"] = {t=0, tskill={2, 14, 0, "DRUID", 40, 0}, checkclass="DRUID", icontex="Spell_Nature_FaerieFire"}; -- only druids with the talent see the spell
		["Demoralizing Roar"] = {t=30, checkclass="DRUID", icontex="Ability_Druid_DemoralizingRoar"};
		--["Mangle"] =	{t=10, checkclass="DRUID", icontex=""};
			-- periodic damage spells
				["Insect Swarm"] = {t=12, periodicdmg="true", icontex="Spell_Nature_InsectSwarm"};
				["Moonfire"] = {t=12, periodicdmg="true", directhit="true", icontex="Spell_Nature_StarFall"};
				["Rip"] = {t=12, periodicdmg="true", icontex="Ability_GhoulFrenzy"};

		-- Naturfreund | Paladin Afflicions
			["Hammer of Justice"] = {t=6, solo="true", stun="true", icontex="Spell_Holy_SealOfMight"};
			["Repentance"] = {t=6, solo="true", icontex="Spell_Holy_PrayerOfHealing"};

		-- Naturfreund | Shaman Afflicions
		["Frost Shock"] = {t=8.0, magecold="true", spellDR="true", sclass="SHAMAN", icontex="Spell_Frost_FrostShock"};
			-- periodic damage spells
				["Flame Shock"] = {t=12, periodicdmg="true", directhit="true", icontex="Spell_Fire_FlameShock"};


	-- Naturfreund | Raidencounter Afflicions
	-- gobal="true" creates a castbar even without a target!

		-- Naxxramas
		["Mortal Wound"] = {t=15, global="true", icontex="Ability_CriticalStrike"}; -- Gluth's Healing Debuff
		["Mutating Injection"] = {t=10.0, global="true", icontex="Spell_Shadow_CallofBone"}; -- Grobbulus' Mutagen
		["Web Wrap"] = {t=60.0, global="true", icontex="Spell_Nature_Web"}; -- Maexxna Web Wraps 3 people after a random ammount of time
		["Necrotic Poison"] = {t=30.0, global="true", icontex="Ability_Creature_Poison_03"}; -- Maexxna MT -healing Debuff(poison)
		["Detonate Mana"] = {t=5, global="true", icontex="Spell_Nature_WispSplode"}; -- Kel'Thuzads Mana Bomb

		-- Zul'Gurub
		["Delusions of Jin'do"] = {t=20, global="true", icontex="Spell_Shadow_UnholyFrenzy"}; -- Delusions of Jin'do
		["Cause Insanity"] = {t=9.5, global="true", icontex="Spell_Shadow_ShadowWordDominate"}; -- Hakkars Mind Control
		["Threatening Gaze"] = {t=5.7, global="true", icontex="Spell_Shadow_Charm"}; -- Mandokir's Gaze

		-- MC
		["Living Bomb"] = {t=8, global="true", icontex="INV_Enchant_EssenceAstralSmall"}; -- Geddon's Bomb

		-- BWL
		["Conflagration"] = {t=10.0, global="true", aZone="Blackwing Lair", icontex="Spell_Fire_Incinerate"}; -- Razorgores (and Drakkisaths) Burning
		["Burning Adrenaline"] = {t=20.0, global="true", icontex="INV_Gauntlets_03"}; -- Vaelastrasz BA
		["Shadow of Ebonroc"] = {t=8.0, global="true", icontex="Spell_Shadow_GatherShadows"}; -- Ebonroc selfheal debuff

		-- AQ40
		["True Fulfillment"] = {t=20, global="true", icontex="Spell_Shadow_Charm"}; -- Skeram MindControl
		["Plague"] = {t=40, global="true", icontex="Spell_Shadow_CurseOfTounges"}; -- Anubisath Defenders Plague
		["Entangle"] = {t=10, global="true", icontex="Spell_Nature_StrangleVines"}; -- Fankriss the Unyielding's Entangle

		-- AQ20
		["Paralyze"] = {t=10, global="true", aZone="Ruins of Ahn'Qiraj", icontex="Ability_Creature_Poison_05"}; -- Ayamiss the Hunter

		-- Non Boss DeBuffs:
		["Greater Polymorph"] = {t=20.0, fragile="true", icontex="Spell_Nature_Brilliance"}; -- Polymorph of BWL Spellbinders


	-- REMOVALS
	-- just to remove the bar if this spell fades (t is useless here) | only the spells in "CEnemyCastBar_Afflictions" are checked by the "fade-engine"
		-- Moam
		["Energize"] = {t=0, global="true"};
		-- Other
		["Frenzy"] = {t=0, global="true"};
		[CECB_SPELL_STUN_DR] = {t=0}; -- don't translate, used internally! clear the dimishing return timer if mob dies


	}

	-- Spell Interruptions
	NECB_Interruptions = "Earth Shock, Gouge, Pounce, Stun, Intercept Stun, Scatter Shot, War Stomp, Polymorph: Pig, Fear, Hammer of Justice, Sap, Charge Stun, Stunning Blast, Stunning Blow, Seduction, Kidney Shot, Cheap Shot, Concussion Blow, Improved Concussive Shot, Wyvern Sting, Revenge Stun, Intimidating Shout, Polymorph: Turtle, Psychic Scream, Bash, Blast Wave, Shackle Undead, Banish, Blind, Mind Control";


	-- Zul'Gurub
	CEnemyCastBar_HAKKAR_YELL			= "PRIDE HERALDS THE END OF YOUR WORLD";

	-- Naxxramas
	CEnemyCastBar_HEIGAN_YELL1			= "I see you...";
	CEnemyCastBar_HEIGAN_YELL2			= "You are mine now.";
	CEnemyCastBar_HEIGAN_YELL3			= "You... are next.";
	CEnemyCastBar_HEIGAN_TELEPORT_YELL		= "The end is upon you.";

	CEnemyCastBar_FAER_YELL1			= "Kneel before me, worm!";
	CEnemyCastBar_FAER_YELL2			= "You cannot hide from me!";
	CEnemyCastBar_FAER_YELL3			= "Run while you still can!";
	CEnemyCastBar_FAER_YELL4			= "Slay them in the master's name!"; 

	CEnemyCastBar_PATCHWERK_NAME			= "Patchwerk";

	CEnemyCastBar_GOTHIK_YELL			= "Foolishly you have sought your own demise.";

	CEnemyCastBar_ANUB_YELL1			= "Just a little taste...";
	CEnemyCastBar_ANUB_YELL2			= "Yes, run! It makes the blood pump faster!";
	CEnemyCastBar_ANUB_YELL3			= "There is no way out.";

	-- AQ40
	CEnemyCastBar_SARTURA_CALL			= "You will be judged for defiling";
	CEnemyCastBar_SARTURA_CRAZY			= "becomes enraged";

	CEnemyCastBar_HUHURAN_CRAZY			= "goes into a berserker rage";

	CEnemyCastBar_CTHUN_NAME1	 		= "Eye of C'Thun";
	CEnemyCastBar_CTHUN_WEAKENED			= "is weakened!";

	-- Ruins of AQ
	CEnemyCastBar_MOAM_STARTING			= "senses your fear.";

	-- MC
	CEnemyCastBar_RAGNAROS_STARTING			= "NOW FOR YOU,";
	CEnemyCastBar_RAGNAROS_KICKER			= "TASTE THE FLAMES";
	CEnemyCastBar_RAGNAROS_SONS	 		= "COME FORTH, MY SERVANTS!";

	-- BWL
	CEnemyCastBar_RAZORGORE_CALL			= "Intruders have breached";

	CEnemyCastBar_FIREMAW_NAME			= "Firemaw";
	CEnemyCastBar_EBONROC_NAME			= "Ebonroc";
	CEnemyCastBar_FLAMEGOR_NAME			= "Flamegor";
	CEnemyCastBar_FLAMEGOR_FRENZY			= "goes into a frenzy";
	CEnemyCastBar_CHROMAGGUS_FRENZY			= "goes into a killing frenzy";
	
	CEnemyCastBar_NEFARIAN_STARTING			= "Let the games begin!";
	CEnemyCastBar_NEFARIAN_LAND			= "Well done, my minions";
	CEnemyCastBar_NEFARIAN_SHAMAN_CALL		= "Shamans, show me";
	CEnemyCastBar_NEFARIAN_DRUID_CALL		= "Druids and your silly";
	CEnemyCastBar_NEFARIAN_WARLOCK_CALL		= "Warlocks, you shouldn't be playing";
	CEnemyCastBar_NEFARIAN_PRIEST_CALL		= "Priests! If you're going to keep";
	CEnemyCastBar_NEFARIAN_HUNTER_CALL		= "Hunters and your annoying";
	CEnemyCastBar_NEFARIAN_WARRIOR_CALL		= "Warriors, I know you can hit harder";
	CEnemyCastBar_NEFARIAN_ROGUE_CALL		= "Rogues";
	CEnemyCastBar_NEFARIAN_PALADIN_CALL		= "Paladins";
	CEnemyCastBar_NEFARIAN_MAGE_CALL		= "Mages";

	-- ONY
	CEnemyCastBar_ONY_DB				= "takes in a deep breath..."; 
	

	-- Event Pattern
	CEnemyCastBar_MOB_DIES					= "(.+) dies"
	CEnemyCastBar_SPELL_GAINS 				= "(.+) gains (.+)."
	CEnemyCastBar_SPELL_CAST 				= "(.+) begins to cast (.+)."
	CEnemyCastBar_SPELL_PERFORM				= "(.+) begins to perform (.+)."
	CEnemyCastBar_SPELL_CASTS				= "(.+) casts (.+)."
	CEnemyCastBar_SPELL_AFFLICTED				= "(.+) (.+) afflicted by (.+).";
	CEnemyCastBar_SPELL_AFFLICTED2				= "-- dummy --";
	CEnemyCastBar_SPELL_DAMAGE 				= "(.+) suffers (.+) from (.+)'s (.+).";

	-- Natufreund
	CEnemyCastBar_SPELL_HITS 				= "(.+)'s (.+) hits (.+) for (.+).";
	--							mob	spell	target		damage
	CEnemyCastBar_SPELL_DAMAGE_SELFOTHER			= "(.+) suffers (.+) from your (.+).";

	CEnemyCastBar_SPELL_FADE 				= "(.+) fades from (.+).";
	--							effect			mob

	CEnemyCastBar_SPELL_REMOVED 				= "(.+) (.+) is removed." -- correct pattern for engl. client?
	--							mob	spell
	-- It is an extra check to see if an affliction has fade off

	CEnemyCastBar_SPELL_HITS_SELFOTHER			= "Your (.+) hits (.+) for (.+) damage.";
	--								spell	       mob  (damage)
	CEnemyCastBar_SPELL_CRITS_SELFOTHER			= "Your (.+) crits (.+) for (.+) damage.";

	CEnemyCastBar_SPELL_INTERRUPTED				= "You interrupt (.+)'s (.+).";
	--									mob	spell
	CEnemyCastBar_SPELL_INTERRUPTED_OTHER			= "(.+) interrupts (.+)'s (.+).";
	--							interrupter	mob	spell

	CECB_SELF1	= "You";
	CECB_SELF2	= "you";

	CECB_MISC_IMMUNE = "immune";

end
