------------------------------------------------------------------------------------------------------
-- Cryolysis
--
-- Based on Necrosis LdC by Lomig and Nyx (http://necrosis.larmes-cenarius.net)
-- Original Necrosis Idea : Infernal (http://www.revolvus.com/games/interface/necrosis/)
-- Cryolysis Maintainer : Kaeldra of Aegwynn
--
-- Contact : darklyte@gmail.com
-- Send me in-game mail!  Yersinia on Aegwynn, Horde side.
-- Guild: <Working as Intended>
-- Version Date: 07.14.2006
------------------------------------------------------------------------------------------------------



------------------------------------------------
-- ENGLISH  VERSION FUNCTIONS --
------------------------------------------------
--
if ( GetLocale() == "enUS" ) or ( GetLocale() == "enGB" ) then

CRYOLYSIS_UNIT_MAGE = "Mage";

-- Word to search for Fire Vulnerability and Winter's chill  first (.+) is the target, second is the spell
CRYOLYSIS_DEBUFF_SRCH = "(.+) is afflicted by (.+)."
CRYOLYSIS_POLY_SRCH = "(.+) fades from (.+)."

function Cryolysis_SpellTableBuild()
	CRYOLYSIS_SPELL_TABLE = {
	[1] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Amplify Magic",			Length = 600,	Type = 0},
	[2] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Arcane Brilliance",		Length = 3600,	Type = 0},
	[3] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Arcane Explosion",		Length = 0,		Type = 0},
	[4] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Arcane Intellect",		Length = 1800,	Type = 0},
	[5] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Arcane Missiles",		Length = 0,		Type = 0},
	[6] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Blast Wave",			Length = 45,	Type = 3},
	[7] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Blink",					Length = 15,	Type = 3},
	[8] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Blizzard",				Length = 0,		Type = 0},
	[9] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Cone of Cold",			Length = 10,	Type = 3},
	[10] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Conjure Food",			Length = 0,		Type = 0},
	[11] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Conjure Water",			Length = 0,		Type = 0},
	[12] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Counterspell",			Length = 30,	Type = 3},
	[13] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Dampen Magic",			Length = 600,	Type = 0},
	[14] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Fire Blast",			Length = 8,		Type = 3},
	[15] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Fire Ward",				Length = 30,	Type = 3},
	[16] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Fireball",				Length = 8,		Type = 5},
	[17] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Flamestrike",			Length = 8,		Type = 3},
	[18] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Frost Armor",			Length = 300,	Type = 0},
	[19] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Frost Nova",			Length = 25,	Type = 3},
	[20] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Frost Ward",			Length = 30,	Type = 3},
	[21] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Frostbolt",				Length = 9,		Type = 5},
	[22] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Ice Armor",				Length = 300,	Type = 0},
	[23] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Ice Barrier",			Length = 30,	Type = 3},
	[24] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Mage Armor",			Length = 300,	Type = 0},
	[25] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Mana Shield",			Length = 60,	Type = 0},
	[26] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Polymorph",				Length = 50,	Type = 2},
	[27] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Portal: Darnassus",		Length = 0,		Type = 0},
	[28] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Portal: Ironforge",		Length = 0,		Type = 0},
	[29] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Portal: Stormwind",		Length = 0,		Type = 0},
	[30] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Portal: Thunder Bluff",	Length = 0,		Type = 0},
	[31] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Portal: Undercity",		Length = 0,		Type = 0},
	[32] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Pyroblast",				Length = 12,	Type = 5},
	[33] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Remove Lesser Curse",	Length = 0,		Type = 0},
	[34] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Scorch",			Length = 0,			Type = 0},
	[35] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Slow Fall",				Length = 30,	Type = 0},
	[36] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Teleport: Darnassus",	Length = 0,		Type = 0},
	[37] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Teleport: Ironforge",	Length = 0,		Type = 0},
	[38] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Teleport: Orgrimmar",	Length = 0,		Type = 0},
	[39] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Teleport: Thunder Bluff",	Length = 0,	Type = 0},
	[40] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Teleport: Undercity",	Length = 0,		Type = 0},
	[41] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Ice Block",			Length = 300,		Type = 3},
	[42] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Cold Snap",			Length = 600,		Type = 3},
	[43] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Combustion",			Length = 180,	Type = 3},
	[44] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Presence of Mind",		Length = 180,	Type = 3},
	[45] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Arcane Power",			Length = 180,	Type = 3},
	[46] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Teleport: Darnassus",		Length = 0,	Type = 0},
	[47] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Portal: Orgrimmar",		Length = 0,		Type = 0},
	[48] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Polymorph: Pig",		Length = 50,	Type = 2},
	[49] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Evocation",			Length = 480,		Type = 3},
	[50] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Detect Magic",			Length = 120,	Type = 5},
	[51] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Teleport: Stormwind",		Length = 0,	Type = 0},
	[52] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Polymorph: Turtle",		Length = 50,	Type = 2},
	[53] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Frostbite",				Length = 5,		Type = 6},
	[54] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Winter's Chill",		Length = 15,	Type = 6},
	[55] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Winter's Chill (2)",	Length = 15,	Type = 6},
	[56] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Winter's Chill (3)",	Length = 15,	Type = 6},
	[57] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Winter's Chill (4)",	Length = 15,	Type = 6},
	[58] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Winter's Chill (5)",	Length = 15,	Type = 6},
	[59] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Fire Vulnerability",	Length = 30,	Type = 6},
    [60] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Fire Vulnerability (2)",Length = 30,	Type = 6},
	[61] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Fire Vulnerability (3)",Length = 30,	Type = 6},
	[62] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Fire Vulnerability (4)",Length = 30,	Type = 6},
	[63] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Fire Vulnerability (5)",Length = 30,	Type = 6},
	[64] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Mana Gem",				Length = 120,	Type = 3},
	[65] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Freeze",				Length = 5,		Type = 6},
	[66] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Frost nova",			Length = 8,		Type = 6},
	[67] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Poly Diminished",		Length = 15,	Type = 6},
	};
end
Cryolysis_SpellTableBuild();
-- Type 0 = No Timer
-- Type 1 = Principle permanent timer
-- Type 2 = permanent timer
-- Type 3 = Cooldown Timer
-- Type 4 = Debuff Timer
-- Type 5 = Combat Timer
-- Type 6 = Non-cast debuff.  Not to be removed by normal means
CRYOLYSIS_ITEM = {
	["LightFeather"] = "Light Feather",
	["ArcanePowder"] = "Arcane Powder",
	["RuneOfTeleportation"] = "Rune of Teleportation",
	["RuneOfPortals"] = "Rune of Portals",
	["Manastone"] = "Mana",
	["Hearthstone"] = "Hearthstone",
	["Provision"] = "Conjured",
	["Evocation"] = "Evocation",
	["Drink"] = "Drink",
	["Food"] = "Food",
};
CRYOLYSIS_FOOD_RANK = {
	[1] = " Muffin",
	[2] = " Bread",
	[3] = " Rye",
	[4] = " Pumpernickel",
	[5] = " Sourdough",
	[6] = " Sweet Roll", 
	[7] = " Cinnamon Roll",
};
CRYOLYSIS_DRINK_RANK = {
	[1] = " Water",
	[2] = " Fresh Water",
	[3] = " Purified Water",
	[4] = " Spring Water",
	[5] = " Mineral Water",
	[6] = " Sparkling Water",
	[7] = " Crystal Water",
};
CRYOLYSIS_STONE_RANK = {
	[1] = " Agate",		-- Rank Minor
	[2] = " Jade",		-- Rank Lesser
	[3] = " Citrine",	-- Rank Greater
	[4] = " Ruby"		-- Rank Major
};
CRYOLYSIS_STONE_RANK2 = {
	[1] = "Agate",		-- Rank Minor
	[2] = "Jade",		-- Rank Lesser
	[3] = "Citrine",	-- Rank Greater
	[4] = "Ruby"		-- Rank Major
};

CRYOLYSIS_MANASTONE_NAMES = {
	[1] = "Conjure Mana Agate",
	[2] = "Conjure Mana Jade",
	[3] = "Conjure Mana Citrine",
	[4] = "Conjure Mana Ruby"
};
	

CRYOLYSIS_CREATE = {
	[1] = "Evocation",
	[2] = "Conjure Mana",
	[3] = "Conjure Drink",
	[4] = "Conjure Food"
};

CRYOLYSIS_MOUNT_TABLE = {
	-- [1] Frostwolf Howler Icon
	{ "Horn of the Frostwolf Howler" }, 
	-- [2] Ram Icon
	{ "Stormpike Battle Charger", "Black Ram", "Black War Ram", "Brown Ram", "Frost Ram", "Gray Ram", "Swift Brown Ram", "Swift Gray Ram", "Swift White Ram", "White Ram", },
	-- [3] Raptor Icon            
	{ "Swift Razzashi Raptor", "Swift Blue Raptor", "Swift Olive Raptor", "Swift Orange Raptor", "Whistle of the Black War Raptor", "Whistle of the Emerald Raptor", "Whistle of the Ivory Raptor", "Whistle of the Mottled Red Raptor", "Whistle of the Turquoise Raptor", "Whistle of the Violet Raptor" },
	-- [4] Yellow Tiger Icon
	{ "Swift Zulian Tiger" },
	-- [5] Undead Horse Icon
	{ "Blue Skeletal Horse", "Blue Skeletal Warhorse", "Deathcharger's Reins", "Brown Skeletal Horse", "Green Skeletal Warhorse", "Purple Skeletal Warhorse", "Red Skeletal Horse", "Red Skeletal Warhorse" },
	-- [6] Mechanostrider Icon
	{ "Black Battlestrider", "Blue Mechanostrider", "Green Mechanostrider", "Icy Blue Mechanostrider Mod A", "Red Mechanostrider", "Swift Green Mechanostrider", "Swift White Mechanostrider", "Swift Yellow Mechanostrider", "Unpainted Mechanostrider", "White Mechanostrider Mod A" },
	-- [7] Brown Horse Icon
	{ "Black Stallion Bridle", "Brown Horse Bridle", "Chestnut Mare Bridle", "Palomino Bridle", "Pinto Bridle", "Swift Brown Steed", "Swift Palomino", "Swift White Steed", "White Stallion Bridle" },
	-- [8] Brown Kodo Icon
	{ "Black War Kodo", "Brown Kodo", "Great Brown Kodo" },
	-- [9] War Steed Icon
	{ "Black War Steed" },
	-- [10] Gray Kodo Icon
	{ "Gray Kodo", "Great Gray Kodo", "Great White Kodo" },
	-- [11] Green Kodo Icon 
	{ "Green Kodo", "Teal Kodo" },
	-- [12] White Wolf Icon    
	{ "Horn of the Arctic Wolf", "Horn of the Dire Wolf", "Horn of the Swift Gray Wolf", "Horn of the Swift Timber Wolf" },
	-- [13] Black Wolf Icon    
	{ "Horn of the Black War Wolf", "Horn of the Brown Wolf", "Horn of the Red Wolf", "Horn of the Swift Brown Wolf", "Horn of the Timber Wolf" },
	-- [14] Black Tiger Icon   
	{ "Reins of the Black War Tiger", "Reins of the Striped Nightsaber" },
	-- [15] White Tiger Icon   
	{ "Reins of the Frostsaber", "Reins of the Nightsaber", "Reins of the Spotted Frostsaber", "Reins of the Striped Frostsaber", "Reins of the Swift Frostsaber", "Reins of the Swift Mistsaber", "Reins of the Swift Stormsaber" },
	-- [16] Red Tiger Icon
	{ "Reins of the Winterspring Frostsaber" },
	-- [17] Black Qiraji Resonating Crystal
	{ "Black Qiraji Resonating Crystal" },
}
CRYOLYSIS_MOUNT_PREFIX = {
	"Horn of the ",
	"Whistle of the ",
	"Reins of the ",	
}
CRYOLYSIS_AQMOUNT_TABLE = {
	"Blue Qiraji Resonating Crystal",
 	"Green Qiraji Resonating Crystal",
 	"Red Qiraji Resonating Crystal",
	"Yellow Qiraji Resonating Crystal",
}
CRYOLYSIS_AQMOUNT_NAME = {
	"Summon Black Qiraji Tank",
	"Summon Blue Qiraji Tank",
 	"Summon Green Qiraji Tank",
 	"Summon Red Qiraji Tank",
	"Summon Yellow Qiraji Tank",
}

CRYOLYSIS_TRANSLATION = {
	["Cooldown"] = "Cooldown",
	["Hearth"] = "Hearthstone",
	["Rank"] = "Rank",
	["Invisible"] = "Detect Invisibility",
	["LesserInvisible"] = "Detect Lesser Invisibility",
	["GreaterInvisible"] = "Detect Greater Invisibility",
	["SoulLinkGain"] = "You gain Soul Link.",
	["SacrificeGain"] = "You gain Sacrifice.",
	["SummoningRitual"] = "Ritual of Summoning"
};
end