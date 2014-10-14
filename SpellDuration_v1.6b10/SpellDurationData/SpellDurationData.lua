----------------------------------------------------------------------------------------------------
-- Name	: Spell Duration [Data File]
-- Author	: Sniff
----------------------------------------------------------------------------------------------------

-- Spells table
SDSpellsTable = {
	--[[
	[SPELL PROPERTIES]
	name					(The name of the spell [Initialized by the localization table])
	duration				(How much time the spell last ?)
	targets				(The maximum number of bars that can be created for this spell per this targets [Max Value: 4])
	* If the value of the variables below are equal to false DO NOT add them at all
	aoe = true,				(Is this spell AoE based ?)
	environment = true,		(Is this spell processing through the environment ? Hunter's Traps etc.)
	casting = true,			(Is this spell delivered by casting ?)
	special = true,			(Is this spell delivered by casting and needs a special handler so the spell will be recasted properly ?)
	caststop = true,			(Is this spell triggered through the SPELLCAST_STOP event ?)
	icon = "Texture Name",		(Is this spell appearance will be showing up as a debuff icon ?) 
	selfcast = true,			(Can this spell be casted on yourself and we only need to show it while it effects others ?)
	[CORE VARIABLES]
	stop,
	[HARDCODED SPELLS]
	id = "SpellName",
	]]--
	[SDClassTable.Hunter] = {
		{
			-- Scatter Shot
			name = "",
			duration = 4,
			targets = 1,
			stop,
		},
		{
			-- Concussive Shot
			name = "",
			duration = 4,
			targets = 1,
			stop,
		},
		{
			-- Improved Concussive Shot
			name = "",
			duration = 3,
			targets = 1,
			environment = true,
			stop,
		},
		{
			-- Wing Clip
			name = "",
			duration = 10,
			targets = 2,
			stop,
		},
		{
			-- Improved Wing Clip
			name = "",
			duration = 5,
			targets = 2,
			environment = true,
			stop,
		},
		{
			-- Counterattack
			name = "",
			duration = 5,
			targets = 1,
			stop,
		},
		{
			-- Scare Beast
			name = "",
			duration = 0,
			targets = 1,
			stop,
		},
		{
			-- Freezing Trap
			name = "", 
			duration = 0,
			targets = 1,
			environment = true,
			stop,
		},
		{
			-- Frost Trap
			name = "",
			duration = 0,
			targets = 1,
			environment = true,
			id = "FrostTrap",
			stop,
		},
		{
			-- Immolation Trap
			name = "",
			duration = 15,
			targets = 1,
			environment = true,
			stop,
		},
		{
			-- Explosive Trap
			name = "",
			duration = 20,
			targets = 1,
			environment = true,
			stop,
		},
		{
			-- Scorpid Sting
			name = "",
			duration = 20,
			targets = 2,
			stop,
		},
		{
			-- Serpent Sting
			name = "",
			duration = 15,
			targets = 2,
			stop,
		},
		{
			-- Viper Sting
			name = "",
			duration = 8,
			targets = 2,
			stop,
		},
		{
			-- Wyvern Sting
			name = "",
			duration = 12,
			targets = 1,
			stop,
		},
		{
			-- Hunter's Mark
			name = "",
			duration = 120,
			targets = 1,
			id = "HuntersMark",
			icon = "Ability_Hunter_SniperShot",
			stop,
		},
		{
			-- Flare
			name = "",
			duration = 30,
			targets = 2,
			aoe = true,
			id = "Flare",
			caststop = true,
			icon = "Spell_Fire_Flare",
			stop,
		},
	},
	[SDClassTable.Rogue] = {
		{
			-- Cheap Shot
			name = "",
			duration = 4,
			targets = 1,
			stop,
		},
		{
			-- Gouge
			name = "",
			duration = 0,
			targets = 1,
			stop,
		},
		{
			-- Kidney Shot
			name = "",
			duration = 0,
			targets = 1,
			stop,
		},
		{
			-- Distract
			name = "",
			duration = 10,
			targets = 1,
			caststop = true,
			aoe = true,
			stop,
		},
		{
			-- Sap
			name = "",
			duration = 0,
			targets = 1,
			stop,
		},
		{
			-- Blind
			name = "",
			duration = 10,
			targets = 1,
			stop,
		},
		{
			-- Expose Armor
			name = "",
			duration = 30,
			targets = 1,
			stop,
		},
		{
			-- Garrote
			name = "",
			duration = 18,
			targets = 1,
			stop,
		},
		{
			-- Hemorrhage
			name = "",
			duration = 15,
			targets = 1,
			stop,
		},
		{
			-- Kick
			name = "",
			duration = 5,
			targets = 1,
			caststop = true,
			stop,
		},
		{
			-- Kick - Silenced (Improved Kick)
			name = "",
			duration = 2,
			targets = 1,
			stop,
		},
		{
			-- Premeditation
			name = "",
			duration = 10,
			targets = 1,
			stop,
		},
		{
			-- Riposte
			name = "",
			duration = 6,
			targets = 1,
			caststop = true,
			stop,
		},
		{
			-- Rupture
			name = "",
			duration = 0,
			targets = 1,
			stop,
		},
		{
			-- Deadly Poison
			name = "",
			duration = 12,
			targets = 2,
			stop,
		},
		{
			-- Wound Poison
			name = "",
			duration = 15,
			targets = 2,
			stop,
		},
		{
			-- Mind-numbing Poison
			name = "",
			duration = 0,
			targets = 2,
			stop,
		},
		{
			-- Crippling Poison
			name = "",
			duration = 12,
			targets = 2,
			stop,
		},
	},
	[SDClassTable.Mage] = {
		{
			-- Polymorph
			name = "",
			duration = 0,
			targets = 1,
			casting = true,
			icon = "Spell_Nature_Polymorph",
			stop,
		},
		{
			-- Frost Nova
			name = "",
			duration = 8,
			targets = 1,
			aoe = true,
			stop,
		},
		{
			-- Blast Wave
			name = "",
			duration = 6,
			targets = 1,
			aoe = true,
			stop,
		},
		{
			-- Cone of Cold
			name = "",
			duration = 8,
			targets = 1,
			aoe = true,
			stop,
		},
		{
			-- Counterspell
			name = "",
			duration = 10,
			targets = 1,
			caststop = true,
			stop,
		},
		{
			-- Counterspell - Silenced
			name = "",
			duration = 4,
			targets = 1,
			environment = true,
			stop,
		},
		{
			-- Fireball
			name = "",
			duration = 0,
			casting = true,
			targets = 2,
			stop,
		},
		{
			-- Frostbite
			name = "",
			duration = 5,
			targets = 2,
			environment = true,
			stop,
		},
		{
			-- Frostbolt
			name = "",
			duration = 0,
			special = true,
			casting = true,
			targets = 2,
			stop,
		},
		{
			-- Pyroblast
			name = "",
			duration = 12,
			casting = true,
			targets = 1,
			stop,
		},
		{
			-- Impact
			name = "",
			duration = 2,
			targets = 1,
			environment = true,
			stop,
		},
		{
			-- Polymorph: Pig
			name = "",
			duration = 50,
			targets = 1,
			casting = true,
			icon = "Spell_Nature_Polymorph",
			stop,
		},
		{
			-- Polymorph: Turtle
			name = "",
			duration = 50,
			targets = 1,
			casting = true,
			icon = "Spell_Nature_Polymorph",
			stop,
		},
		{
			-- Fire Vulnerability
			name = "",
			duration = 30,
			targets = 1,
			environment = true,
			icon = "Spell_Fire_Soulburn",
			stop,
		},
		{
			-- Fire Vulnerability (2)
			name = "",
			duration = 30,
			targets = 1,
			environment = true,
			icon = "Spell_Fire_Soulburn",
			stop,
		},
		{
			-- Fire Vulnerability (3)
			name = "",
			duration = 30,
			targets = 1,
			environment = true,
			icon = "Spell_Fire_Soulburn",
			stop,
		},
		{
			-- Fire Vulnerability (4)
			name = "",
			duration = 30,
			targets = 1,
			environment = true,
			icon = "Spell_Fire_Soulburn",
			stop,
		},
		{
			-- Fire Vulnerability (5)
			name = "",
			duration = 30,
			targets = 1,
			environment = true,
			icon = "Spell_Fire_Soulburn",
			stop,
		},
	},
	[SDClassTable.Druid] = {
		{
			-- Entangling Roots
			name = "",
			duration = 0,
			targets = 1,
			casting = true,
			stop,
		},
		{
			-- Hibernate
			name = "",
			duration = 0,
			targets = 1,
			casting = true,
			stop,
		},
		{
			-- Faerie Fire
			name = "",
			duration = 40,
			targets = 2,
			caststop = true,
			stop,
		},
		{
			-- Moonfire
			name = "",
			duration = 0,
			targets = 2,
			debuff = true,
			stop,
		},
		{
			-- Bash
			name = "",
			duration = 0,
			targets = 1,
			stop,
		},
		{
			-- Abolish Poison
			name = "",
			duration = 8,
			targets = 2,
			caststop = true,
			selfcast = true,
			stop,
		},
		{
			-- Challenging Roar
			name = "",
			duration = 6,
			targets = 1,
			aoe = true,
			stop,
		},
		{
			-- Demoralizing Roar
			name = "",
			duration = 30,
			targets = 1,
			aoe = true,
			icon = "Ability_Druid_DemoralizingRoar",
			stop,
		},
		{
			-- Innervate
			name = "",
			duration = 20,
			targets = 1,
			caststop = true,
			selfcast = true,
			icon = "Spell_Nature_Lightning",
			stop,
		},
		{
			-- Insect Swarm
			name = "",
			duration = 12,
			targets = 2,
			stop,
		},
		{
			-- Pounce
			name = "",
			duration = 2,
			targets = 1,
			stop,
		},
		{
			-- Rake
			name = "",
			duration = 9,
			targets = 1,
			caststop = true,
			stop,
		},
		{
			-- Regrowth
			name = "",
			duration = 21,
			targets = 2,
			casting = true,
			caststop = true,
			selfcast = true,
			icon = "Spell_Nature_ResistNature",
			stop,
		},
		{
			-- Rejuvenation
			name = "",
			duration = 12,
			targets = 2,
			selfcast = true,
			caststop = true,
			icon = "Spell_Nature_Rejuvenation",
			stop,
		},
		{
			-- Rip
			name = "",
			duration = 12,
			targets = 1,
			stop,
		},
		{
			-- Soothe Animal
			name = "",
			duration = 15,
			targets = 2,
			casting = true,
			stop,
		},
		{
			-- Faerie Fire (Feral)
			name = "",
			duration = 40,
			targets = 2,
			stop,
		},
	},
	[SDClassTable.Priest] = {
		{
			-- Shackle Undead
			name = "",
			duration = 0,
			targets = 1,
			casting = true,
			special = true,
			stop,
		},
		{
			-- Abolish Disease
			name = "",
			duration = 20,
			targets = 1,
			selfcast = true,
			caststop = true,
			icon = "Spell_Holy_NullifyDisease",
			stop,
		},
		{
			-- Blackout
			name = "",
			duration = 3,
			targets = 2,
			environment = true,
			stop,
		},
		{
			-- Devouring Plague
			name = "",
			duration = 24,
			targets = 1,
			stop,
		},
		{
			-- Holy Fire
			name = "",
			duration = 10,
			targets = 2,
			casting = true,
			stop,
		},
		{
			-- Mind Soothe
			name = "",
			duration = 15,
			targets = 2,
			environment = true,
			special = true,
			stop,
		},
		{
			-- Power Word: Shield
			name = "",
			duration = 30,
			targets = 1,
			selfcast = true,
			caststop = true,
			icon = "Spell_Holy_PowerWordShield",
			stop,
		},
		{
			-- Psychic Scream
			name = "",
			duration = 8,
			targets = 1,
			aoe = true,
			stop,
		},
		{
			-- Renew
			name = "",
			duration = 15,
			targets = 1,
			selfcast = true,
			caststop = true,
			icon = "Spell_Holy_Renew",
			stop,
		},
		{
			-- Shadow Word: Pain
			name = "",
			duration = 0,
			targets = 2,
			stop,
		},
		{
			-- Silence
			name = "",
			duration = 5,
			targets = 1,
			caststop = true,
			stop,
		},
		{
			-- Vampiric Embrace
			name = "",
			duration = 60,
			targets = 2,
			caststop = true,
			icon = "Spell_Shadow_UnsummonBuilding",
			stop,
		},
	},
	[SDClassTable.Warlock] = {
		{
			-- Aftermath
			name = "",
			duration = 5,
			targets = 2,
			environment = true,
			stop,
		},
		{
			-- Banish
			name = "",
			duration = 0,
			targets = 1,
			casting = true,
			environment = true,
			icon = "Spell_Shadow_Cripple",
			stop,
		},
		{
			-- Corruption
			name = "",
			duration = 0,
			targets = 1,
			stop,
		},
		{
			-- Curse of Agony
			name = "",
			duration = 24,
			targets = 1,
			stop,
		},
		{
			-- Curse of Doom
			name = "",
			duration = 60,
			targets = 1,
			icon = "Spell_Shadow_AuraOfDarkness",
			stop,
		},
		{
			-- Curse of Exhaustion
			name = "",
			duration = 12,
			targets = 1,
			stop,
		},
		{
			-- Curse of Recklessness
			name = "",
			duration = 120,
			targets = 1,
			icon = "Spell_Shadow_UnholyStrength",
			stop,
		},
		{
			-- Curse of Tongues
			name = "",
			duration = 30,
			targets = 1,
			icon = "Spell_Shadow_CurseOfTongues",
			stop,
		},
		{
			-- Curse of Weakness
			name = "",
			duration = 120,
			targets = 1,
			icon = "Spell_Shadow_CurseOfMannoroth",
			stop,
		},
		{
			-- Curse of Shadow
			name = "",
			duration = 300,
			targets = 1,
			icon = "Spell_Shadow_CurseOfAchimonde",
			stop,
		},
		{
			-- Curse of the Elements
			name = "",
			duration = 300,
			targets = 1,
			icon = "Spell_Shadow_ChillTouch",
			stop,
		},
		{
			-- Death Coil
			name = "",
			duration = 3,
			targets = 1,
			stop,
		},
		{
			-- Enslave Demon
			name = "",
			duration = 300,
			targets = 1,
			casting = true,
			environment = true,
			icon = "Spell_Shadow_EnslaveDemon",
			stop,
		},
		{
			-- Fear
			name = "",
			duration = 0,
			targets = 1,
			special = true,
			casting = true,
			stop,
		},
		{
			-- Howl of Terror
			name = "",
			duration = 0,
			targets = 1,
			casting = true,
			aoe = true,
			stop,
		},
		{
			-- Immolate
			name = "",
			duration = 15,
			targets = 1,
			casting = true,
			stop,
		},
		{
			-- Inferno
			name = "",
			duration = 300,
			targets = 1,
			casting = true,
			environment = true,
			icon = "Spell_Shadow_SummonInfernal",
			stop,
		},
		{
			-- Pyroclasm
			name = "",
			duration = 3,
			targets = 1,
			environment = true,
			stop,
		},
		{
			-- Siphon Life
			name = "",
			duration = 30,
			targets = 1,
			icon = "Spell_Shadow_Requiem",
			stop,
		},
	},
	[SDClassTable.Paladin] = {
		{
			-- Consecration
			name = "",
			duration = 8,
			targets = 1,
			aoe = true,
			stop,
		},
		{
			-- Hammer of Justice
			name = "",
			duration = 0,
			targets = 1,
			stop,
		},
		{
			-- Repentance
			name = "",
			duration = 6,
			targets = 1,
			stop,
		},
		{
			-- Turn Undead
			name = "",
			duration = 0,
			targets = 1,
			casting = true,
			stop,
		},
		{
			-- Blessing of Protection
			name = "",
			duration = 10,
			targets = 1,
			selfcast = true,
			caststop = true,
			icon = "Spell_Holy_SealOfProtection",
			stop,
		},
		{
			-- Blessing of Freedom
			name = "",
			duration = 10,
			targets = 1,
			selfcast = true,
			caststop = true,
			icon = "Spell_Holy_SealOfValor",
			stop,
		},
	},
	[SDClassTable.Shaman] = {
		{
			-- Flame Shock
			name = "",
			duration = 12,
			targets = 1,
			stop,
		},
		{
			-- Earth Shock
			name = "",
			duration = 2,
			targets = 1,
			caststop = true,
			stop,
		},
		{
			-- Frost Shock
			name = "",
			duration = 8,
			targets = 1,
			stop,
		},
		{
			-- Stoneskin Totem
			name = "",
			duration = 120,
			targets = 1,
			caststop = true,
			icon = "Spell_Nature_StoneSkinTotem",
			stop,
		},
		{
			-- Earthbind Totem
			name = "",
			duration = 45,
			targets = 1,
			caststop = true,
			icon = "Spell_Nature_StrengthOfEarthTotem02",
			stop,
		},
		{
			-- Stoneclaw Totem
			name = "",
			duration = 15,
			targets = 1,
			caststop = true,
			icon = "Spell_Nature_StoneClawTotem",
			stop,
		},
		{
			-- Strength of Earth Totem
			name = "",
			duration = 120,
			targets = 1,
			caststop = true,
			icon = "Spell_Nature_EarthBindTotem",
			stop,
		},
		{
			-- Fire Nova Totem
			name = "",
			duration = 0,
			targets = 1,
			caststop = true,
			stop,
		},
		{
			-- Searing Totem
			name = "",
			duration = 30,
			targets = 1,
			caststop = true,
			icon = "Spell_Fire_SearingTotem",
			stop,
		},
		{
			-- Tremor Totem
			name = "",
			duration = 120,
			targets = 1,
			caststop = true,
			icon = "Spell_Nature_TremorTotem",
			stop,
		},
		{
			-- Poison Cleansing Totem
			name = "",
			duration = 120,
			targets = 1,
			caststop = true,
			icon = "Spell_Nature_PoisonCleansingTotem",
			stop,
		},
		{
			-- Healing Stream Totem
			name = "",
			duration = 60,
			targets = 1,
			caststop = true,
			icon = "INV_Spear_04",
			stop,
		},
		{
			-- Frost Resistance Totem
			name = "",
			duration = 120,
			targets = 1,
			caststop = true,
			icon = "Spell_FrostResistanceTotem_01",
			stop,
		},
		{
			-- Magma Totem
			name = "",
			duration = 20,
			targets = 1,
			caststop = true,
			icon = "Fire_Spell_SelfDestruct",
			stop,
		},
		{
			-- Mana Spring Totem
			name = "",
			duration = 60,
			targets = 1,
			caststop = true,
			icon = "Spell_Nature_ManaRegenTotem",
			stop,
		},
		{
			-- Fire Resistance Totem
			name = "",
			duration = 120,
			targets = 1,
			caststop = true,
			icon = "Spell_FireResistanceTotem_01",
			stop,
		},
		{
			-- Flametongue Totem
			name = "",
			duration = 120,
			targets = 1,
			caststop = true,
			icon = "Spell_Nature_GuardianWard",
			stop,
		},
		{
			-- Grounding Totem
			name = "",
			duration = 45,
			targets = 1,
			caststop = true,
			icon = "Spell_Nature_GroundingTotem",
			stop,
		},
		{
			-- Nature Resistance Totem
			name = "",
			duration = 120,
			targets = 1,
			caststop = true,
			icon = "Spell_Nature_NatureResistanceTotem",
			stop,
		},
		{
			-- Windfury Totem
			name = "",
			duration = 120,
			targets = 1,
			caststop = true,
			icon = "Spell_Nature_Windfury",
			stop,
		},
		{
			-- Sentry Totem
			name = "",
			duration = 300,
			targets = 1,
			caststop = true,
			icon = "Spell_Nature_RemoveCurse",
			stop,
		},
		{
			-- Windwall Totem
			name = "",
			duration = 120,
			targets = 1,
			caststop = true,
			icon = "Spell_Nature_EarthBind",
			stop,
		},
		{
			-- Disease Cleansing Totem
			name = "",
			duration = 120,
			targets = 1,
			caststop = true,
			icon = "Spell_Nature_DiseaseCleansingTotem",
			stop,
		},
		{
			-- Mana Tide Totem
			name = "",
			duration = 12,
			targets = 1,
			caststop = true,
			icon = "Spell_Frost_SummonWaterElemental",
			stop,
		},
		{
			-- Grace of Air Totem
			name = "",
			duration = 120,
			targets = 1,
			caststop = true,
			icon = "Spell_Nature_InvisibilityTotem",
			stop,
		},
		{
			-- Tranquil Air Totem
			name = "",
			duration = 120,
			targets = 1,
			caststop = true,
			icon = "Spell_Nature_Brilliance",
			stop,
		},
	},
	[SDClassTable.Warrior] = {
		{
			-- Challenging Shout
			name = "",
			duration = 6,
			targets = 1,
			caststop= true,
			aoe = true,
			stop,
		},
		{
			-- Concussion Blow
			name = "",
			duration = 5,
			targets = 1,
			stop,
		},
		{
			-- Demoralizing Shout
			name = "",
			duration = 30,
			targets = 1,
			caststop = true,
			aoe = true,
			icon = "Ability_Warrior_WarCry",
			stop,
		},
		{
			-- Disarm
			name = "",
			duration = 0,
			targets = 1,
			caststop = true,
			stop,
		},
		{
			-- Hamstring
			name = "",
			duration = 15,
			targets = 2,
			stop,
		},
		{
			-- Improved Hamstring
			name = "",
			duration = 5,
			targets = 1,
			environment = true,
			stop,
		},
		{
			-- Improved Revenge
			name = "",
			duration = 3,
			targets = 1,
			stop,
		},
		{
			-- Intimidating Shout
			name = "",
			duration = 8,
			targets = 1,
			aoe = true,
			stop,
		},
		{
			-- Mocking Blow
			name = "",
			duration = 6,
			targets = 1,
			stop,
		},
		{
			-- Mortal Strike
			name = "",
			duration = 10,
			targets = 2,
			caststop = true,
			stop,
		},
		{
			-- Piercing Howl
			name = "",
			duration = 6,
			targets = 1,
			aoe = true,
			stop,
		},
		{
			-- Pummel
			name = "",
			duration = 4,
			targets = 1,
			caststop = true,
			stop,
		},
		{
			-- Rend
			name = "",
			duration = 0,
			targets = 2,
			stop,
		},
		{
			-- Shield Bash
			name = "",
			duration = 6,
			targets = 1,
			caststop = true,
			stop,
		},
		{
			-- Improved Shield Bash
			name = "",
			duration = 3,
			targets = 1,
			environment = true,
			stop,
		},
		{
			-- Sunder Armor
			name = "",
			duration = 30,
			targets = 5,
			caststop = true,
			icon = "Ability_Warrior_Sunder",
			stop,
		},
		{
			-- Thunder Clap
			name = "",
			duration = 0,
			targets = 1,
			aoe = true,
			stop,
		},
		{
			-- Charge
			name = "",
			duration = 1,
			targets = 1,
			stop,
		},
		{
			-- Intercept
			name = "",
			duration = 3,
			targets = 1,
			stop,
		},
		{
			-- Deep Wound
			duration = 12,
			targets = 1,
			environment = true,
			stop,
		},
	},
 };
 
-- Talent table
SDTalentTable = {
	--[[
	[Index of the spell name from our localization file].name = {
		{
			rank (The rank of this spell in your spellbook)
			duration (The duration for this rank in your spellbook)
		}
	},
	[Index of the spell talent name from our localization file].talent = {
		{
			rank (The rank of this spell in your talent)
			duration (The duration for this rank in your talent)
			fraction {Is this spell duration in talent appears as a fraction ? true [If not don't add it at all]}
		}
	},
	]]--

	-- HUNTER:
	-- Freezing Trap
	[SDLocalizedSpellsTable[SDClassTable.Hunter][8].name] = {
		{
			rank = 1,
			duration = 10,
		},
		{
			rank = 2,
			duration = 15,
		},
		{
			rank = 3,
			duration = 20,
		},
	},
	[SDLocalizedSpellsTable[SDClassTable.Hunter][8].talent] = {
		{
			rank = 1,
			duration = 15,
			fraction = true,
		},
		{
			rank = 2,
			duration = 30,
			fraction = true,
		},
	},
	-- Frost Trap
	[SDLocalizedSpellsTable[SDClassTable.Hunter][9].name] = {
		{
			rank = 0,
			duration = 30,
		},
	},
	[SDLocalizedSpellsTable[SDClassTable.Hunter][9].talent] = {
		{
			rank = 1,
			duration = 15,
			fraction = true,
		},
		{
			rank = 2,
			duration = 30,
			fraction = true,
		},
	},
	-- Scare Beast
	[SDLocalizedSpellsTable[SDClassTable.Hunter][7].name] = {
		{
			rank = 1,
			duration = 10,
		},
		{
			rank = 2,
			duration = 15,
		},
		{
			rank = 3,
			duration = 20,
		},
	},

	-- ROGUE:
	-- Gouge
	[SDLocalizedSpellsTable[SDClassTable.Rogue][2].name] = { 
		{
			rank = 0,
			duration = 4,
		},
	},
	[SDLocalizedSpellsTable[SDClassTable.Rogue][2].talent] = {
		{
			rank = 1,
			duration = 0.5,
		},
		{
			rank = 2,
			duration = 1,
		},
		{
			rank = 3,
			duration = 1.5,
		},
	},
	-- Sap
	[SDLocalizedSpellsTable[SDClassTable.Rogue][5].name] = {
		{
			rank = 1,
			duration = 25,
		},
		{
			rank = 2,
			duration = 35,
		},
		{
			rank = 3,
			duration = 45,
		},
	},
	-- Hack for Kidney Shot
	[SDLocalizedSpellsTable[SDClassTable.Rogue][3].name] = {
		{
			rank = 0,
			duration = 0,
		},
	},
	-- Hack for Rupture
	[SDLocalizedSpellsTable[SDClassTable.Rogue][14].name] = {
		{
			rank = 0,
			duration = 0,
		},
	},
	-- Mind-numbing Poison
	[SDLocalizedSpellsTable[SDClassTable.Rogue][17].name] = {
		{
			rank = 1,
			duration = 10,
		},
		{
			rank = 2,
			duration = 12,
		},
		{
			rank = 3,
			duration = 14,
		},
	},
	-- MAGE:
	-- Polymorph
	[SDLocalizedSpellsTable[SDClassTable.Mage][1].name] = {
		{
			rank = 1,
			duration = 20,
		},
		{
			rank = 2,
			duration = 30,
		},
		{
			rank = 3,
			duration = 40,
		},
		{
			rank = 4,
			duration = 50,
		},
	},
	-- Fireball
	[SDLocalizedSpellsTable[SDClassTable.Mage][7].name] = {
		{
			rank = 1,
			duration = 6,
		},
		{
			rank = 2,
			duration = 6,
		},
		{
			rank = 3,
			duration = 6,
		},
		{
			rank = 4,
			duration = 8,
		},
		{
			rank = 5,
			duration = 8,
		},
		{
			rank = 6,
			duration = 8,
		},
		{
			rank = 7,
			duration = 8,
		},
		{
			rank = 8,
			duration = 8,
		},
		{
			rank = 9,
			duration = 8,
		},
		{
			rank = 10,
			duration = 8,
		},
		{
			rank = 11,
			duration = 8,
		},
		{
			rank = 12,
			duration = 8,
		},
	},
	-- Frostbolt
	[SDLocalizedSpellsTable[SDClassTable.Mage][9].name] = {
		{
			rank = 1,
			duration = 5,
		},
		{
			rank = 2,
			duration = 6,
		},
		{
			rank = 3,
			duration = 6,
		},
		{
			rank = 4,
			duration = 7,
		},
		{
			rank = 5,
			duration = 7,
		},
		{
			rank = 6,
			duration = 8,
		},
		{
			rank = 7,
			duration = 8,
		},
		{
			rank = 8,
			duration = 9,
		},
		{
			rank = 9,
			duration = 9,
		},
		{
			rank = 10,
			duration = 9,
		},
		{
			rank = 11,
			duration = 9,
		},
	},
	[SDLocalizedSpellsTable[SDClassTable.Mage][9].talent] = {
		{
			rank = 1,
			duration = 1,
		},
		{
			rank = 2,
			duration = 1.5,
		},
		{
			rank = 3,
			duration = 2,
		},
		{
			rank = 4,
			duration = 2.5,
		},
		{
			rank = 5,
			duration = 3,
		},
	},
	
	-- DRUID:
	-- Entangling Roots
	[SDLocalizedSpellsTable[SDClassTable.Druid][1].name] = {
		{
			rank = 1,
			duration = 12,
		},
		{
			rank = 2,
			duration = 15,
		},
		{
			rank = 3,
			duration = 18,
		},
		{
			rank = 4,
			duration = 21,
		},
		{
			rank = 5,
			duration = 24,
		},
		{
			rank = 6,
			duration = 27,
		},
	},
	-- Hibernate
	[SDLocalizedSpellsTable[SDClassTable.Druid][2].name] = {
		{
			rank = 1,
			duration = 20,
		},
		{
			rank = 2,
			duration = 30,
		},
		{
			rank = 3,
			duration = 40,
		},
	},
	-- Moonfire
	[SDLocalizedSpellsTable[SDClassTable.Druid][4].name] = {
		{
			rank = 1,
			duration = 9,
		},
		{
			rank = 2,
			duration = 12,
		},
		{
			rank = 3,
			duration = 12,
		},
		{
			rank = 4,
			duration = 12,
		},
		{
			rank = 5,
			duration = 12,
		},
		{
			rank = 6,
			duration = 12,
		},
		{
			rank = 7,
			duration = 12,
		},
		{
			rank = 8,
			duration = 12,
		},
		{
			rank = 9,
			duration = 12,
		},
		{
			rank = 10,
			duration = 12,
		},
	},
	-- Bash
	[SDLocalizedSpellsTable[SDClassTable.Druid][5].name] = {
		{
			rank = 1,
			duration = 2,
		},
		{
			rank = 2,
			duration = 3,
		},
		{
			rank = 3,
			duration = 4,
		},
	},
	[SDLocalizedSpellsTable[SDClassTable.Druid][5].talent] = {
		{
			rank = 1,
			duration = 0.5,
		},
		{
			rank = 2,
			duration = 1,
		},
	},

	-- PRIEST:
	-- Shackle Undead
	[SDLocalizedSpellsTable[SDClassTable.Priest][1].name] = {
		{
			rank = 1,
			duration = 30,
		},
		{
			rank = 2,
			duration = 40,
		},
		{
			rank = 3,
			duration = 50,
		},
	},
	-- Shadow Word: Pain
	[SDLocalizedSpellsTable[SDClassTable.Priest][10].name] = {
		{
			rank = 0,
			duration = 18,
		},
	},
	[SDLocalizedSpellsTable[SDClassTable.Priest][10].talent] = {
		{
			rank = 1,
			duration = 3,
		},
		{
			rank = 2,
			duration = 6,
		},
	},

	-- WARLOCK
	-- Banish
	[SDLocalizedSpellsTable[SDClassTable.Warlock][2].name] = {
		{
			rank = 1,
			duration = 20,
		},
		{
			rank = 2,
			duration = 30,
		},
	},
	-- Corruption
	[SDLocalizedSpellsTable[SDClassTable.Warlock][3].name] = {
		{
			rank = 1,
			duration = 12,
		},
		{
			rank = 2,
			duration = 15,
		},
		{
			rank = 3,
			duration = 18,
		},
		{
			rank = 4,
			duration = 18,
		},
		{
			rank = 5,
			duration = 18,
		},
		{
			rank = 6,
			duration = 18,
		},
		{
			rank = 7,
			duration = 18,
		},
	},
	-- Fear
	[SDLocalizedSpellsTable[SDClassTable.Warlock][14].name] = {
		{
			rank = 1,
			duration = 10,
		},
		{
			rank = 2,
			duration = 15,
		},
		{
			rank = 3,
			duration = 20,
		},
	},
	-- Howl of Terror
	[SDLocalizedSpellsTable[SDClassTable.Warlock][15].name] = {
		{
			rank = 1,
			duration = 10,
		},
		{
			rank = 2,
			duration = 15,
		},
	},

	-- PALADIN:
	-- Hammer of Justice
	[SDLocalizedSpellsTable[SDClassTable.Paladin][2].name] = {
		{
			rank = 1,
			duration = 3,
		},
		{
			rank = 2,
			duration = 4,
		},
		{
			rank = 3,
			duration = 5,
		},
		{
			rank = 4,
			duration = 6,
		},
	},
	-- Turn Undead
	[SDLocalizedSpellsTable[SDClassTable.Paladin][4].name] = {
		{
			rank = 1,
			duration = 10,
		},
		{
			rank = 2,
			duration = 15,
		},
		{
			rank = 3,
			duration = 20,
		},
	},
	
	-- WARRIOR:
	-- Disarm
	[SDLocalizedSpellsTable[SDClassTable.Warrior][4].name] = {
		{
			rank = 0,
			duration = 10,
		},
	},
	[SDLocalizedSpellsTable[SDClassTable.Warrior][4].talent] = {
		{
			rank = 1,
			duration = 1,
		},
		{
			rank = 2,
			duration = 2,
		},
		{
			rank = 3,
			duration = 3,
		},
	},
	-- Rend
	[SDLocalizedSpellsTable[SDClassTable.Warrior][13].name] = {
		{
			rank = 1,
			duration = 9,
		},
		{
			rank = 2,
			duration = 12,
		},
		{
			rank = 3,
			duration = 15,
		},
		{
			rank = 4,
			duration = 18,
		},
		{
			rank = 5,
			duration = 21,
		},
		{
			rank = 6,
			duration = 21,
		},
		{
			rank = 7,
			duration = 21,
		},
	},
	-- Thunderclap
	[SDLocalizedSpellsTable[SDClassTable.Warrior][17].name] = {
		{
			rank = 1,
			duration = 10,
		},
		{
			rank = 2,
			duration = 14,
		},
		{
			rank = 3,
			duration = 18,
		},
		{
			rank = 4,
			duration = 22,
		},
		{
			rank = 5,
			duration = 26,
		},
		{
			rank = 6,
			duration = 30,
		},
	},
	-- SHAMAN:
	-- Fire Nova Totem
	[SDLocalizedSpellsTable[SDClassTable.Shaman][8].name] = {
		{
			rank = 0,
			duration = 4,
		},
	},
	[SDLocalizedSpellsTable[SDClassTable.Shaman][8].talent] = {
		{
			rank = 1,
			duration = -1,
		},
		{
			rank = 2,
			duration = -2,
		},
	},

 };
 
-- Racial table
SDRacialTable = {
	-- War Stomp
	[SDRaceTable.Tauren] = {
		{
			name = "",
			duration = 2,
			stop,
		},
	},
	-- Berserking
	[SDRaceTable.Troll] = {
		{
			name = "",
			duration = 10,
			id = "Berserking",
			stop,
		},
	},
	-- Stoneform
	[SDRaceTable.Dwarf] = {
		{
			name = "",
			duration = 8,
			caststop = true,
			stop,
		},
	},
};
 
 -- Invetory table (Items, Sets that increase/decrease spells duration)
 SDInvetoryTable = {
	[SDClassTable.Mage] = {
		-- Arcanist Regalia
		{
			item = "Arcanist Belt;Arcanist Bindings;Arcanist Crown;Arcanist Boots;Arcanist Gloves;Arcanist Leggings;Arcanist Mantle;Arcanist Robes",
			bonus = 5,
			-- Polymorph
			effect = SDLocalizedSpellsTable[SDClassTable.Mage][1].name,
			duration = "15",
		},
	},
};