--<< ====================================================================== >>--
-- Setup Timers                                                               --
--<< ====================================================================== >>--
local BS = AceLibrary("Babble-Spell-2.2")
local L = AceLibrary("AceLocale-2.2"):new("Antagonist")


-- table values are: time, class, school, icon
Antagonist.spells.casts = {
	-- racials/items
	[BS["War Stomp"]] = 			{0.5,"general","physical"},
	[BS["Escape Artist"]] =			{0.5,"general","physical"},	
	[L["Hearthstone"]] =			{10,"general","magic","INV_Misc_Rune_01"},
	
	-- mage
	[BS["Frostbolt"]] =			{2.5,"mage","frost"},
	[BS["Fireball"]] =			{3,  "mage","fire"},
	[BS["Flamestrike"]] =			{3,  "mage","fire"},
	[BS["Ice Lance"]] =			{1.5,"mage","frost"},
	[BS["Invisibility"]] =			{8,  "mage","arcane"},
	[BS["Polymorph"]] =			{1.5,"mage","arcane"},
	[BS["Polymorph: Pig"]] =		{1.5,"mage","arcane"},
	[BS["Polymorph: Turtle"]] =		{1.5,"mage","arcane"},
	[BS["Pyroblast"]] =			{6,  "mage","fire"},
	[BS["Scorch"]] =			{1.5,"mage","fire"},
	[BS["Slow Fall"]] =			{30, "mage","magic"}, 
	[BS["Teleport: Darnassus"]] =		{10, "mage","magic"},
	[BS["Teleport: Thunder Bluff"]] =	{10, "mage","magic"},
	[BS["Teleport: Ironforge"]] =		{10, "mage","magic"},
	[BS["Teleport: Orgrimmar"]] =		{10, "mage","magic"},
	[BS["Teleport: Stormwind"]] =		{10, "mage","magic"},
	[BS["Teleport: Undercity"]] =		{10, "mage","magic"},
	[BS["Summon Water Elemental"]] =	{0,  "mage","frost"},

	-- water elemental
	[BS["Waterbolt"]] =			{2.5,"mage","frost"},

	-- paladin
	[BS["Avenger's Shield"]] =		{1,  "paladin","holy"},
	[BS["Holy Light"]] =			{2.5,"paladin","holy"},
	[BS["Flash of Light"]] =		{1.5,"paladin","holy"},
	[BS["Summon Charger"]] =		{3,  "paladin","holy"},
	[BS["Summon Warhorse"]] =		{3,  "paladin","holy"},
	[BS["Hammer of Wrath"]] =		{1,  "paladin","holy"},
	[BS["Holy Wrath"]] =			{2,  "paladin","holy"},
	[BS["Turn Undead"]] =			{1.5,"paladin","holy"},
	[BS["Redemption"]] =			{10, "paladin","holy"},

	-- warlock
	[BS["Shadow Bolt"]] =			{2.5,"warlock","shadow"},
	[BS["Immolate"]] =			{1.5,"warlock","fire"},
	[BS["Soul Fire"]] =			{4,  "warlock","fire"},
	[BS["Searing Pain"]] =			{1.5,"warlock","fire"},
	[BS["Fear"]] =				{1.5,"warlock","shadow"},
	[BS["Howl of Terror"]] =		{2,  "warlock","shadow"},
	[BS["Summon Dreadsteed"]] =		{3,  "warlock","shadow"},
	[BS["Summon Felsteed"]] =		{3,  "warlock","shadow"},
	[BS["Summon Imp"]] =			{6,  "warlock","shadow"},
	[BS["Summon Succubus"]] =		{6,  "warlock","shadow"},
	[BS["Summon Voidwalker"]] =		{6,  "warlock","shadow"},
	[BS["Summon Felhunter"]] =		{6,  "warlock","shadow"},
	[BS["Summon Felguard"]] =		{10, "warlock","shadow"},
	[BS["Banish"]] =			{1.5,"warlock","shadow"},
	[BS["Ritual of Summoning"]] =		{5,  "warlock","shadow"},
	[BS["Ritual of Doom"]] =		{10, "warlock","shadow"},
	[BS["Enslave Demon"]] =			{3,  "warlock","shadow"},
	[BS["Inferno"]] =			{2,  "warlock","shadow"},
	[BS["Seed of Corruption"]] =		{2,  "warlock","shadow"},
	[BS["Incinerate"]] =			{2.5,"warlock","fire"},
	[BS["Unstable Affliction"]] =		{1.5,"warlock","shadow"},
	[BS["Ritual of Souls"]] =		{3,  "warlock","shadow"},
	[BS["Shadowfury"]] =			{0.5,"warlock","shadow"},

	-- succubus
	[BS["Seduction"]] =			{1.5,"warlock","shadow"},

	-- priest
	[BS["Binding Heal"]] =			{1.5,"priest","holy"},
	[BS["Greater Heal"]] =			{2.5,"priest","holy"},
	[BS["Flash Heal"]] =			{1.5,"priest","holy"},
	[BS["Heal"]] =				{2.5,"priest","holy"},
	[BS["Holy Fire"]] =			{3,  "priest","holy"},
	[BS["Mass Dispel"]] =			{1.5,"priest","holy"},
	[BS["Mind Blast"]] =			{1.5,"priest","shadow"},
	[BS["Mind Control"]] =			{3,  "priest","shadow"},
	[BS["Mana Burn"]] =			{3,  "priest","shadow"},
	[BS["Mind Soothe"]] =			{1.5,"priest","holy"},
	[BS["Prayer of Healing"]] =		{3,  "priest","holy"},
	[BS["Resurrection"]] =			{10, "priest","holy"},
	[BS["Smite"]] =				{2,  "priest","holy"},
	[BS["Shackle Undead"]] =		{1.5,"priest","holy"},
	[BS["Vampiric Touch"]] =		{1.5,"priest","shadow"},

	-- rogue
	[BS["Disarm Trap"]] =			{2,  "rogue","physical"},
	[BS["Pick Lock"]] =			{5,  "rogue","physical"},

	-- hunter
	[BS["Multi-Shot"]] = 			{0,  "hunter","physical"},
	[BS["Aimed Shot"]] = 			{3,  "hunter","physical"},
	[BS["Scare Beast"]] = 			{1,  "hunter","physical"},
	[BS["Volley"]] = 			{6,  "hunter","physical"},
	[BS["Dismiss Pet"]] = 			{5,  "hunter","nature"},
	[BS["Revive Pet"]] = 			{10, "hunter","physical"},
	[BS["Eyes of the Beast"]] = 		{2,  "hunter","physical"},
	[BS["Mongoose Bite"]] =			{0,  "hunter","physical"}, -- cd only
	[BS["Raptor Strike"]] =			{0,  "hunter","physical"}, -- cd only
	[BS["Scatter Shot"]] =			{0,  "hunter","physical"}, -- cd only
	[BS["Steady Shot"]] =			{1.5,"hunter","physical"},
	[BS["Wyvern Sting"]] =			{0,  "hunter","physical"}, -- cd only

	-- druid
	[BS["Cyclone"]] =			{1.5,"druid","nature"},
	[BS["Healing Touch"]] = 		{3,  "druid","nature"},
	[BS["Regrowth"]] = 			{2,  "druid","nature"},
	[BS["Rebirth"]] = 			{2,  "druid","nature"},
	[BS["Starfire"]] = 			{3.5,"druid","nature"},
	[BS["Wrath"]] = 			{2,  "druid","nature"},
	[BS["Entangling Roots"]] = 		{1.5,"druid","nature"},
	[BS["Hibernate"]] = 			{1.5,"druid","nature"},
	[BS["Soothe Animal"]] = 		{1.5,"druid","nature"},
	[BS["Teleport: Moonglade"]] = 		{10, "druid","arcane"},
	[BS["Tranquility"]] = 			{10, "druid","nature"},
	[BS["Hurricane"]] =			{10, "druid", "nature"},
	[BS["Tranquility"]] =			{10, "druid", "nature"},

	-- shaman
	[BS["Lesser Healing Wave"]] =		{1.5,"shaman","nature"},
	[BS["Healing Wave"]] =			{2.5,"shaman","nature"},
	[BS["Chain Lightning"]] =		{2.5,"shaman","nature"},
	[BS["Ghost Wolf"]] =			{3,  "shaman","nature"},
	[BS["Chain Heal"]] =			{2.5,"shaman","nature"},
	[BS["Lightning Bolt"]] =		{3,  "shaman","nature"},
	[BS["Ancestral Spirit"]] =		{10, "shaman","nature"},
	[BS["Astral Recall"]] =			{10, "shaman","nature"},
	[BS["Chain Heal"]] =			{2.5,"shaman","nature"},
	[BS["Lightning Bolt"]] =		{3,  "shaman","nature"},
	[BS["Far Sight"]] =			{2,  "shaman","nature"},

	-- mobs
	[L["Shrink"]] =				{3,  "general","shadow","Spell_Ice_MagicDamage"},
	[L["Banshee Curse"]] =			{2,  "general","shadow","Spell_Nature_Drowsy"},
	[L["Shadow Bolt Volley"]] =		{3,  "general","shadow","Spell_Shadow_ShadowBolt"},
	[L["Cripple"]] =			{3,  "general","shadow","Spell_Shadow_Cripple"},
        [L["Dark Mending"]] =			{3.5,"general","shadow","Spell_Shadow_ChillTouch"},
	[L["Spirit Decay"]] =			{2,  "general","shadow","Spell_Holy_HarmUndeadAura"},
	[L["Gust of Wind"]] =			{2,  "general","nature","Spell_Nature_EarthBind"},
	[L["Black Sludge"]] =			{3,  "general","shadow","Spell_Shadow_CallofBone"},
	[L["Toxic Bolt"]] =			{2,  "general","nature","Spell_Nature_CorrosiveBreath"},
	[L["Poisonous Spit"]] =			{2,  "general","nature","Spell_Nature_CorrosiveBreath"},
	[L["Wild Regeneration"]] =		{3,  "general","nature","Spell_Nature_Rejuvenation"},
	[L["Curse of the Deadwood"]] =		{2,  "general","shadow","Spell_Shadow_GatherShadows"},
	[L["Curse of Blood"]] =			{2,  "general","shadow","Spell_Shadow_RitualOfSacrifice"},
	[L["Dark Sludge"]] =			{5,  "general","shadow","Spell_Shadow_CreepingPlague"},
	[L["Plague Cloud"]] =			{2,  "general","shadow","Spell_Shadow_CallofBone"},
	[L["Wandering Plague"]] =		{2,  "general","shadow","Spell_Shadow_CallofBone"},
	[L["Wither Touch"]] =			{2,  "general","shadow","Spell_Nature_Drowsy"},
	[L["Fevered Fatigue"]] =		{3,  "general","shadow","Spell_Nature_NullifyDisease"},
	[L["Encasing Webs"]] =			{2,  "general","shadow","Spell_Nature_EarthBind"},
	[L["Crystal Gaze"]] =			{2,  "general","shadow","Ability_GolemThunderClap"},
}
