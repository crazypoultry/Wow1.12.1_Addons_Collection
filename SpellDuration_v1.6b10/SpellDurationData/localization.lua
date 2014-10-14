----------------------------------------------------------------------------------------------------
-- Translated By		: Sniff
-- Localization		: English
-- Last Update		: 07/17/2006
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
-- Classes
----------------------------------------------------------------------------------------------------
SDClassTable = 
{
	Hunter = "Hunter",
	Rogue = "Rogue",
	Mage = "Mage",
	Druid = "Druid",
	Priest = "Priest",
	Warlock = "Warlock",
	Warrior = "Warrior",
	Paladin = "Paladin",
	Shaman = "Shaman",
};

----------------------------------------------------------------------------------------------------
-- Races  
----------------------------------------------------------------------------------------------------
SDRaceTable = 
{
	Tauren = "Tauren",
	Troll = "Troll",
	Dwarf = "Dwarf",
};

----------------------------------------------------------------------------------------------------
-- Regular Expressions
----------------------------------------------------------------------------------------------------
SD_RANK_REGEX = "Rank (%d+)";

----------------------------------------------------------------------------------------------------
-- Spells table
----------------------------------------------------------------------------------------------------
SDLocalizedSpellsTable = {
	[SDClassTable.Hunter] = {
		{
			name = "Scatter Shot",
			talent = "",
		},
		{
			name = "Concussive Shot",
			talent = "",
		},
		{
			name = "Improved Concussive Shot",
			talent = "",
		},
		{
			name = "Wing Clip",
			talent = "",
		},
		{
			name = "Improved Wing Clip",
			talent = "",
		},
		{
			name = "Counterattack",
			talent = "",
		},
		{
			name = "Scare Beast",
			talent = "",
		},
		{
			name = "Freezing Trap Effect",
			talent = "Clever Traps",
		},
		{
			name = "Frost Trap Effect",
			talent = "Clever Traps",
		},
		{
			name = "Immolation Trap",
			talent = "",
		},
		{
			name = "Explosive Trap Effect",
			talent = "",
		},
		{
			name = "Scorpid Sting",
			talent = "",
		},
		{
			name = "Serpent Sting",
			talent = "",
		},
		{
			name = "Viper Sting",
			talent = "",
		},
		{
			name = "Wyvern Sting",
			talent = "",
		},
		{
			name = "Hunter's Mark",
			talent = "",
		},
		{
			name = "Flare",
			talent = "",
		},
	},
	[SDClassTable.Rogue] = {
		{
			name = "Cheap Shot",
			talent = "",
		},
		{
			name = "Gouge",
			talent = "Improved Gouge",
		},
		{
			name = "Kidney Shot",
			talent = "",
		},
		{
			name = "Distract",
			talent = "",
		},
		{
			name = "Sap",
			talent = "",
		},
		{
			name = "Blind",
			talent = "",
		},
		{
			name = "Expose Armor",
			talent = "",
		},
		{
			name = "Garrote",
			talent = "Improved Garotte",
		},
		{
			name = "Hemorrhage",
			talent = "",
		},
		{
			name = "Kick",
			talent = "",
		},
		{
			name = "Kick - Silenced", -- Improved Kick
			talent = "",
		},
		{
			name = "Premeditation",
			talent = "",
		},
		{
			name = "Riposte",
			talent = "",
		},
		{
			name = "Rupture",
			talent = "",
		},
		{
			name = "Deadly Poison",
			talent = "",
		},
		{
			name = "Wound Poison",
			talent = "",
		},
		{
			name = "Mind-numbing Poison",
			talent = "",
		},
		{
			name = "Crippling Poison",
			talent = "",
		},
	},
	[SDClassTable.Mage] = {
		{
			name = "Polymorph",
			talent = "",
		},
		{
			name = "Frost Nova",
			talent = "",
		},
		{
			name = "Blast Wave",
			talent = "",
		},
		{
			name = "Cone of Cold",
			talent = "",
		},
		{
			name = "Counterspell",
			talent = "",
		},
		{
			name = "Counterspell - Silenced", -- Improved Counterspell
			talent = "",
		},
		{
			name = "Fireball",
			talent = "",
		},
		{
			name = "Frostbite",
			talent = "",
		},
		{
			name = "Frostbolt",
			talent = "Permafrost",
		},
		{
			name = "Pyroblast",
			talent = "",
		},
		{
			name = "Impact",
			talent = "",
		},
		{
			name = "Polymorph: Pig",
			talent = "",
		},
		{
			name = "Polymorph: Turtle",
			talent = "",
		},
		{
			name = "Fire Vulnerability", -- Improved Scorch
			talent = "",
		},
		{
			name = "Fire Vulnerability (2)",
			talent = "",
		},
		{
			name = "Fire Vulnerability (3)",
			talent = "",
		},
		{
			name = "Fire Vulnerability (4)",
			talent = "",
		},
		{
			name = "Fire Vulnerability (5)",
			talent = "",
		},
	},
	[SDClassTable.Druid] = {
		{
			name = "Entangling Roots",
			talent = "",
		},
		{
			name = "Hibernate",
			talent = "",
		},
		{
			name = "Faerie Fire",
			talent = "",
		},
		{
			name = "Moonfire",
			talent = "",
		},
		{
			name = "Bash",
			talent = "Brutal Impact",
		},
		{
			name = "Abolish Poison",
			talent = "",
		},
		{
			name = "Challenging Roar",
			talent = "",
		},
		{
			name = "Demoralizing Roar",
			talent = "",
		},
		{
			name = "Innervate",
			talent = "",
		},
		{
			name = "Insect Swarm",
			talent = "",
		},
		{
			name = "Pounce",
			talent = "Brutal Impact",
		},
		{
			name = "Rake",
			talent = "",
		},
		{
			name = "Regrowth",
			talent = "",
		},
		{
			name = "Rejuvenation",
			talent = "",
		},
		{
			name = "Rip",
			talent = "",
		},
		{
			name = "Soothe Animal",
			talent = "",
		},
		{
			name = "Faerie Fire (Feral)",
			talent = "",
		},
	},
	[SDClassTable.Priest] = {
		{
			name = "Shackle Undead",
			talent = "",
		},
		{
			name = "Abolish Disease",
			talent = "",
		},
		{
			name = "Blackout",
			talent = "",
		},
		{
			name = "Devouring Plague",
			talent = "",
		},
		{
			name = "Holy Fire",
			talent = "",
		},
		{
			name = "Mind Soothe",
			talent = "",
		},
		{
			name = "Power Word: Shield",
			talent = "",
		},
		{
			name = "Psychic Scream",
			talent = "",
		},
		{
			name = "Renew",
			talent = "",
		},
		{
			name = "Shadow Word: Pain",
			talent = "Improved Shadow Word: Pain",
		},
		{
			name = "Silence",
			talent = "",
		},
		{
			name = "Vampiric Embrace",
			talent = "",
		},
	},
	[SDClassTable.Warlock] = {
		{
			name = "Aftermath",
			talent = "",
		},
		{
			name = "Banish",
			talent = "",
		},
		{
			name = "Corruption",
			talent = "",
		},
		{
			name = "Curse of Agony",
			talent = "",
		},
		{
			name = "Curse of Doom",
			talent = "",
		},
		{
			name = "Curse of Exhaustion",
			talent = "",
		},
		{
			name = "Curse of Recklessness",
			talent = "",
		},
		{
			name = "Curse of Tongues",
			talent = "",
		},
		{
			name = "Curse of Weakness",
			talent = "",
		},
		{
			name = "Curse of Shadow",
			talent = "",
		},
		{
			name = "Curse of the Elements",
			talent = "",
		},
		{
			name = "Death Coil",
			talent = "",
		},
		{
			name = "Enslave Demon",
			talent = "",
		},
		{
			name = "Fear",
			talent = "",
		},
		{
			name = "Howl of Terror",
			talent = "",
		},
		{
			name = "Immolate",
			talent = "",
		},
		{
			name = "Inferno",
			talent = "",
		},
		{
			name = "Pyroclasm",
			talent = "",
		},
		{
			name = "Siphon Life",
			talent = "",
		},
	},
	[SDClassTable.Warrior] = {
		{
			name = "Challenging Shout",
			talent = "",
		},
		{
			name = "Concussion Blow",
			talent = "",
		},
		{
			name = "Demoralizing Shout",
			talent = "",
		},
		{
			name = "Disarm",
			talent = "Improved Disarm",
		},
		{
			name = "Hamstring",
			talent = "",
		},
		{
			name = "Improved Hamstring",
			talent = "",
		},
		{
			name = "Improved Revenge",
			talent = "",
		},
		{
			name = "Intimidating Shout",
			talent = "",
		},
		{
			name = "Mocking Blow",
			talent = "",
		},
		{
			name = "Mortal Strike",
			talent = "",
		},
		{
			name = "Piercing Howl",
			talent = "",
		},
		{
			name = "Pummel",
			talent = "",
		},
		{
			name = "Rend",
			talent = "",
		},
		{
			name = "Shield Bash",
			talent = "",
		},
		{
			name = "Improved Shield Bash",
			talent = "",
		},
		{
			name = "Sunder Armor",
			talent = "",
		},
		{
			name = "Thunder Clap",
			talent = "",
		},
		{
			name = "Charge",
			talent = "",
		},
		{
			name = "Intercept",
			talent = "",
		},
		{
			name = "Deep Wound",
			talent = "",
		},
	},
	[SDClassTable.Paladin] = {
		{
			name = "Consecration",
			talent = "",
		},
		{
			name = "Hammer of Justice",
			talent = "",
		},
		{
			name = "Repentance",
			talent = "",
		},
		{
			name = "Turn Undead",
			talent = "",
		},
		{
			name = "Blessing of Protection",
			talent = "",
		},
		{
			name = "Blessing of Freedom",
			talent = "",
		},
	},
	[SDClassTable.Shaman] = {
		{
			name = "Flame Shock",
			talent = "",
		},
		{
			name = "Earth Shock",
			talent = "",
		},
		{
			name = "Frost Shock",
			talent = "",
		},
		{
			name = "Stoneskin Totem",
			talent = "",
		},
		{
			name = "Earthbind Totem",
			talent = "",
		},
		{
			name = "Stoneclaw Totem",
			talent = "",
		},
		{
			name = "Strength of Earth Totem",
			talent = "",
		},
		{
			name = "Fire Nova Totem",
			talent = "Improved Fire Totems",
		},
		{
			name = "Searing Totem",
			talent = "",
		},
		{	
			name = "Tremor Totem",
			talent = "",
		},
		{
			name = "Poison Cleansing Totem",
			talent = "",
		},
		{
			name = "Healing Stream Totem",
			talent = "",
		},
		{
			name = "Frost Resistance Totem",
			talent = "",
		},
		{
			name = "Magma Totem",
			talent = "",
		},
		{
			name = "Mana Spring Totem",
			talent = "",
		},
		{
			name = "Fire Resistance Totem",
			talent = "",
		},
		{
			name = "Flametongue Totem",
			talent = "",
		},
		{
			name = "Grounding Totem",
			talent = "",
		},
		{
			name = "Nature Resistance Totem",
			talent = "",
		},
		{
			name = "Windfury Totem",
			talent = "",
		},
		{
			name = "Sentry Totem",
			talent = "",
		},
		{
			name = "Windwall Totem",
			talent = "",
		},
		{
			name = "Disease Cleansing Totem",
			talent = "",
		},
		{
			name = "Mana Tide Totem",
			talent = "",
		},
		{
			name = "Grace of Air Totem",
			talent = "",
		},
		{
			name = "Tranquil Air Totem",
			talent = "",
		},
	},
};

----------------------------------------------------------------------------------------------------
-- Racial table
----------------------------------------------------------------------------------------------------
SDLocalizedRacialTable = {
	[SDRaceTable.Tauren] = {
		{
			name = "War Stomp",
		},
	},
	[SDRaceTable.Troll] = {
		{
			name = "Berserking",
		},
	},
	[SDRaceTable.Dwarf] = {
		{
			name = "Stoneform",
		},
	},
};

----------------------------------------------------------------------------------------------------
-- Critters table [Ignore List]
----------------------------------------------------------------------------------------------------
SDCritterTable = {
	"Rat", 
	"Roach", 
	"Sheep",
	"Adder",
	"Cow",
	"Toad",
	"Snake",
	"Frog",
	"Hare",
	"Squirrel",
	"Rabbit",
	"Black Rat",
	"Prairie Dog",
	"Biletoad",
	"Serpentbloom Snake",
	"Sickly Gazelle",
	"Fawn",
	"Tainted Cockroach",
};