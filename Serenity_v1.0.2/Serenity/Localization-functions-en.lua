------------------------------------------------------------------------------------------------------
-- Serenity
--
-- Based on Necrosis LdC by Lomig and Nyx (http://necrosis.larmes-cenarius.net)
-- Original Necrosis Idea : Infernal (http://www.revolvus.com/games/interface/necrosis/)
-- Serenity Maintainer : Kaeldra of Aegwynn
--
-- Contact : darklyte@gmail.com
-- Send me in-game mail!  Nethaera on Aegwynn, Horde side.
-- Guild: <Working as Intended>
-- Version Date: 08.16.2006
------------------------------------------------------------------------------------------------------



------------------------------------------------
-- ENGLISH  VERSION FUNCTIONS --
------------------------------------------------
--
if ( GetLocale() == "enUS" ) or ( GetLocale() == "enGB" ) then

SERENITY_UNIT_PRIEST = "Priest";

-- Word to search for Fire Vulnerability and Winter's shadow  first (.+) is the target, second is the spell
SERENITY_DEBUFF_SRCH = "(.+) is afflicted by (.+)."
SERENITY_FADE_SRCH = "(.+) fades from (.+)."
SERENITY_GAIN_SRCH = "(.+) gains (.+)."
SERENITY_CORPSE_SRCH = "Corpse of (.+)"

function Serenity_SpellTableBuild()
	SERENITY_SPELL_TABLE = {
	[1] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Abolish Disease",				Length = 10,	Type = 7},
	[2] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Blessed Recovery",				Length = 6,		Type = 0},
	[3] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Cure Disease",					Length = 0,		Type = 0},
	[4] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Desperate Prayer",				Length = 600,	Type = 3},
	[5] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Devouring Plague",				Length = 24,	Type = 5},
	[6] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Devouring Plague ",				Length = 180,	Type = 3},
	[7] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Dispel Magic",					Length = 0,		Type = 0},
	[8] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Divine Spirit",					Length = 1800,	Type = 0},
	[9] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Elune's Grace",					Length = 300,	Type = 3},
	[10] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Fade",							Length = 30,	Type = 3},
	[11] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Fear Ward",						Length = 30,	Type = 3},
	[12] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Feedback",						Length = 180,	Type = 3},
	[13] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Flash Heal",					Length = 0,		Type = 0},
	[14] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Greater Heal",					Length = 15,		Type = 7},
	[15] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Heal",							Length = 0,		Type = 0},
	[16] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Hex of Weakness",				Length = 120,	Type = 5},
	[17] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Holy Fire",						Length = 10,	Type = 5},
	[18] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Holy Nova",						Length = 0,		Type = 0},
	[19] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Inner Focus",					Length = 180,	Type = 3},
	[20] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Inner Fire",					Length = 0,		Type = 0},
	[21] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Inspiration",					Length = 15,	Type = 7},
	[22] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Lesser Heal",					Length = 0,		Type = 0},
	[23] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Levitate",						Length = 120,	Type = 0},
	[24] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Lightwell",						Length = 600,	Type = 3},
 	[25] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Lightwell (1)",					Length = 180,	Type = 2},
	[26] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Lightwell (2)",					Length = 180,	Type = 2},
	[27] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Lightwell (3)",					Length = 180,	Type = 2},
	[28] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Lightwell (4)",					Length = 180,	Type = 2},
	[29] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Lightwell (5)",					Length = 600,	Type = 2},
	[30] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Mana Burn",						Length = 0,		Type = 0},
	[31] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Martyrdom",						Length = 6,		Type = 0},
	[32] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Mind Blast",					Length = 8,		Type = 3},
	[33] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Mind Control",					Length = 60,	Type = 0},
	[34] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Mind Flay",						Length = 3,		Type = 0},
	[35] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Mind Soothe",					Length = 15,	Type = 5},
	[36] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Mind Vision",					Length = 60,	Type = 0},
	[37] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Power Infusion",				Length = 180,	Type = 3},
	[38] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Power Word: Fortitude",			Length = 1800,	Type = 0},
	[39] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Power Word: Shield",			Length = 30,	Type = 5},
	[40] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Power Word: Shield Cooldown",	Length = 4,		Type = 3},
	[41] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Prayer of Fortitude",			Length = 3600,	Type = 0},
	[42] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Prayer of Healing",				Length = 0,		Type = 0},
	[43] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Prayer of Shadow Protection",	Length = 1200,	Type = 0},
	[44] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Prayer of Spirit",				Length = 3600,	Type = 0},
	[45] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Psychic Scream",				Length = 30,	Type = 3},
 	[46] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Psychic Scream Effect",			Length = 8,		Type = 5},
	[47] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Renew",							Length = 15,	Type = 7},
	[48] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Resurrection",					Length = 0,		Type = 0},
	[49] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Shackle Undead",				Length = 50,	Type = 2},
	[50] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Shadow Weaving",				Length = 0,		Type = 0},
	[51] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Shadow Protection",				Length = 600,	Type = 0},
	[52] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Shadow Word: Pain",				Length = 18,	Type = 5},
	[53] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Shadowform",					Length = 0,		Type = 0},
	[54] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Shadowguard",					Length = 600,	Type = 0},
	[55] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Silence",						Length = 45,	Type = 3},
	[56] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Smite",							Length = 0,		Type = 0},
	[57] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Spirit of Redemption",			Length = 10,	Type = 0},
	[58] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Starshards",					Length = 0,		Type = 0},
	[59] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Touch of Weakness",				Length = 120,	Type = 6},
	[60] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Vampiric Embrace",				Length = 60,	Type = 5},
	[61] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Weakened Soul",					Length = 15,	Type = 7},
	[62] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Shadow Vulnerability",			Length = 15,	Type = 6},
	[63] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Shadow Vulnerability (2)",		Length = 15,	Type = 6},
	[64] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Shadow Vulnerability (3)",		Length = 15,	Type = 6},
	[65] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Shadow Vulnerability (4)",		Length = 15,	Type = 6},
	[66] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Shadow Vulnerability (5)",		Length = 15,	Type = 6},
	[67] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Blackout",						Length = 3,		Type = 5},
	[68] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Lightwell Renew",				Length = 10,	Type = 7},
	[69] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Vampiric Embrace ",				Length = 10,	Type = 3},
	};
end
Serenity_SpellTableBuild()
-- Type 0 = No Timer
-- Type 1 = Principle permanent timer
-- Type 2 = permanent timer
-- Type 3 = Cooldown Timer
-- Type 4 = Debuff Timer
-- Type 5 = Combat Timer
-- Type 6 = Non-cast debuff.  Not to be removed by normal means
-- Type 7 = friendly timer
SERENITY_ITEM = {
	["LightFeather"] = "Light Feather",
	["HolyCandle"] = "Holy Candle",
	["SacredCandle"] = "Sacred Candle",
	["Potion"] = "Potion",
	["Draught"] = "Draught",
	["ManaPotion"] = "Mana Potion",
	["HealingPotion"] = "Healing Potion",
	["Healthstone"] = "Healthstone",
	["Hearthstone"] = "Hearthstone",
};
SERENITY_DRINK_SRCH = { "Water", "Bean Brew", "Milk", "Juice", "Nectar", "Tea", "Dew", "Lemonade", };
SERENITY_DRINK = {
	[1] = { Name = "Refreshing Spring Water", 		Energy = 151, Level = 1,
		Length = 18, Conjured = false, PvP = false },
	[2] = { Name = "Conjured Water", 				Energy = 151, Level = 1,
		Length = 18, Conjured = true, PvP = false },
	[3] = { Name = "Blended Bean Brew", 			Energy = 436, Level = 5,
		Length = 21, Conjured = false, PvP = false },	
	[4] = { Name = "Ice Cold Milk", 				Energy = 436, Level = 5,
		Length = 21, Conjured = false, PvP = false },	
	[5] = { Name = "Conjured Fresh Water", 		Energy = 436, Level = 5,
		Length = 21, Conjured = true, PvP = false },	
	[6] = { Name = "Melon Juice", 					Energy = 835, Level = 15,
		Length = 24, Conjured = false, PvP = false },	
	[7] = { Name = "Fizzy Faire Drink", 			Energy = 835, Level = 15,
		Length = 24, Conjured = false, PvP = false },
	[8] = { Name = "Bubbling Water", 				Energy = 835, Level = 15,
		Length = 24, Conjured = false, PvP = false },
	[9] = { Name = "Conjured Purified Water", 		Energy = 835, Level = 15,
		Length = 24, Conjured = true, PvP = false },	
	[10] = { Name = "Sweet Nectar", 				Energy = 1344, Level = 25,
		Length = 27, Conjured = false, PvP = false },	
	[11] = { Name = "Goldthorn Tea", 				Energy = 1344, Level = 25,
		Length = 27, Conjured = false, PvP = false },	
	[12] = { Name = "Enchanted Water", 			Energy = 1344, Level = 25,
		Length = 27, Conjured = false, PvP = false },	
	[13] = { Name = "Green Garden Tea", 			Energy = 1344, Level = 25,
		Length = 27, Conjured = false, PvP = false },	
	[14] = { Name = "Conjured Spring Water", 		Energy = 1344, Level = 25,
		Length = 27, Conjured = true, PvP = false },	
	[15] = { Name = "Moonberry Juice", 			Energy = 1992, Level = 35,
		Length = 30, Conjured = false, PvP = false },	
	[16] = { Name = "Bottled Winterspring Water", 	Energy = 1992, Level = 35,
		Length = 30, Conjured = false, PvP = false },	
	[17] = { Name = "Conjured Mineral Water", 		Energy = 1992, Level = 35,
		Length = 30, Conjured = true, PvP = false },	
	[18] = { Name = "Morning Glory Dew", 			Energy = 2934, Level = 45,
		Length = 30, Conjured = false, PvP = false },	
	[19] = { Name = "Freshly-Squeezed Lemonade", 	Energy = 2934, Level = 45,
		Length = 30, Conjured = false, PvP = false },	
	[20] = { Name = "Blessed Sunfruit Juice", 		Energy = 4410, Level = 45,
		Length = 30, Conjured = false, PvP = false },	
	[21] = { Name = "Conjured Sparkling Water", 	Energy = 2934, Level = 45,
		Length = 30, Conjured = true, PvP = false },	
	[22] = { Name = "Bottled Alterac Spring Water", Energy = 4410, Level = 55,
		Length = 30, Conjured = false, PvP = false },	
	[23] = { Name = "Enriched Manna Biscuit", Energy = 4410, Level = 45,
		Length = 30, Conjured = false, PvP = false },		
	[24] = { Name = "Conjured Crystal Water",		Energy = 4200, Level = 55,
		Length = 30, Conjured = true, PvP = false },	
};
SERENITY_MANA_POTION = {
	[1] = { Name = "Minor Mana Potion", 	Level = 5, 
		EnergyMin = 140, EnergyMax = 180, 	PvP = false},
	[2] = { Name = "Lesser Mana Potion", 	Level = 14, 
		EnergyMin = 280, EnergyMax = 360, 	PvP = false},
	[3] = { Name = "Mana Potion", 			Level = 14, 
		EnergyMin = 445, EnergyMax = 585, 	PvP = false},
	[4] = { Name = "Greater Mana Potion", 	Level = 31, 
		EnergyMin = 700, EnergyMax = 900, 	PvP = false},
	[5] = { Name = "Superior Mana Draught",Level = 35, 
		EnergyMin = 700, EnergyMax = 900, 	PvP = true},
	[6] = { Name = "Superior Mana Potion",	Level = 41,
		EnergyMin = 900, EnergyMax = 1500, 	PvP = false},
	[7] = { Name = "Major Mana Potion",	Level = 49,
		EnergyMin = 1350, EnergyMax = 2250,	PvP = false},
	[8] = { Name = "Combat Mana Potion",	Level = 41,
		EnergyMin = 900, EnergyMax = 1500, 	PvP = false},
	[9] = { Name = "Major Mana Draught",	Level = 45,
		EnergyMin = 980, EnergyMax = 1260, 	PvP = true},
}
SERENITY_HEALING_POTION = {
	[1] = { Name = "Minor Healing Potion", 	Level = 1, 
		EnergyMin = 70, EnergyMax = 90, PvP = false},
	[2] = { Name = "Minor Healthstone", 	Level = 1, 
		EnergyMin = 100, EnergyMax = 120, PvP = false},
	[3] = { Name = "Lesser Healing Potion", Level = 3, 
		EnergyMin = 140, EnergyMax = 180, PvP = false},
	[4] = { Name = "Discolored Healing Potion",Level = 5, 
		EnergyMin = 140, EnergyMax = 180, PvP = false},
	[5] = { Name = "Healing Potion", 	Level = 12, 
		EnergyMin = 280, EnergyMax = 360, PvP = false},
	[6] = { Name = "Lesser Healthstone", 	Level = 12, 
		EnergyMin = 250, EnergyMax = 300, PvP = false},
	[7] = { Name = "Greater Healing Potion",Level = 21, 
		EnergyMin = 455, EnergyMax = 585, PvP = false},
	[8] = { Name = "Healthstone", 		Level = 24, 
		EnergyMin = 500, EnergyMax = 600, PvP = false},
	[9] = { Name = "Superior Healing Potion",Level = 35, 
		EnergyMin = 700, EnergyMax = 900, PvP = false},
	[10] = { Name = "Combat Healing Potion", Level = 35, 
		EnergyMin = 700, EnergyMax = 900, PvP = false},
	[11] = { Name = "Superior Healing Draught",Level = 35, 
		EnergyMin = 560, EnergyMax = 720, PvP = true},
	[12] = { Name = "Greater Healthstone", 	Level = 36, 
		EnergyMin = 800, EnergyMax = 960, PvP = false},
	[13] = { Name = "Whipper Root Tuber", Level = 45, 
		EnergyMin = 700, EnergyMax = 900, PvP = false},
	[14] = { Name = "Major Healing Potion", Level = 45, 
		EnergyMin = 1050, EnergyMax = 1750, PvP = false},
	[15] = { Name = "Major Healing Draught", Level = 45, 
		EnergyMin = 980, EnergyMax = 1260, PvP = true},
	[16] = { Name = "Major Healthstone", Level = 48, 
		EnergyMin = 1200, EnergyMax = 1440, PvP = false},
}

SERENITY_MOUNT_TABLE = {
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
SERENITY_MOUNT_PREFIX = {
	"Horn of the ",
	"Whistle of the ",
	"Reins of the ",	
}
SERENITY_AQMOUNT_TABLE = {
	"Blue Qiraji Resonating Crystal",
 	"Green Qiraji Resonating Crystal",
 	"Red Qiraji Resonating Crystal",
	"Yellow Qiraji Resonating Crystal",
}
SERENITY_AQMOUNT_NAME = {
	"Summon Black Qiraji Tank",
	"Summon Blue Qiraji Tank",
 	"Summon Green Qiraji Tank",
 	"Summon Red Qiraji Tank",
	"Summon Yellow Qiraji Tank",
}

SERENITY_TRANSLATION = {
	["Cooldown"] = "Cooldown",
	["Hearth"] = "Hearthstone",
	["Rank"] = "Rank",
	["Drink"] = "Drink",
	["Dwarf"] = "Dwarf",
	["NightElf"] = "Night Elf",
	["Human"] = "Human",
	["Gnome"] = "Gnome",
	["Orc"] = "Orc",
	["Troll"] = "Troll",
	["Forsaken"] = "Undead",
	["Tauren"] = "Tauren",
};
end