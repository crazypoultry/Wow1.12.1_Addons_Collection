------------------------------------------------------------------------------------------------------
-- Serenity
--
-- Based on Necrosis LdC by Lomig and Nyx (http://necrosis.larmes-cenarius.net)
-- Original Necrosis Idea : Infernal (http://www.revolvus.com/games/interface/necrosis/)
-- Serenity Maintainer : Kaeldra of Aegwynn
--
-- Contact : darklyte@gmail.com
-- Send me in-game mail!  Yersinia on Aegwynn, Horde side.
-- Guild: <Working as Intended>
-- Version Date: 07.14.2006
------------------------------------------------------------------------------------------------------



------------------------------------------------
-- GERMAN VERSION FUNCTIONS --
------------------------------------------------
--
if GetLocale() == "deDE" then

SERENITY_UNIT_PRIEST = "Priester";

-- Word to search for Fire Vulnerability and Winter's shadow  first (.+) is the target, second is the spell
SERENITY_DEBUFF_SRCH = "(.+) ist von (.+) betroffen."
SERENITY_FADE_SRCH = "(.+) schwindet von (.+)."
SERENITY_GAIN_SRCH = "(.+) bekommt (.+)."
SERENITY_CORPSE_SRCH = "Leiche von (.+)"

function Serenity_SpellTableBuild()
	SERENITY_SPELL_TABLE = {
	[1] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Krankheit aufheben",				Length = 0,		Type = 0},
	[2] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Gesegnete Erholung",				Length = 6,		Type = 0},
	[3] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Krankheit heilen",					Length = 0,		Type = 0},
	[4] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Verzweifeltes Gebet",				Length = 600,	Type = 3},
	[5] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Verschlingende Seuche",				Length = 24,	Type = 5},
	[6] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Verschlingende Seuchen ",				Length = 180,	Type = 3},
	[7] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Magiebannung",					Length = 0,		Type = 0},
	[8] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "G\195\182ttlicher Willen",					Length = 1800,	Type = 0},
	[9] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Elunes Anmut",					Length = 300,	Type = 3},
	[10] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Verblassen",							Length = 30,	Type = 3},
	[11] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Furchtbarriere",						Length = 30,	Type = 3},
	[12] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "R\195\188ckkopplung",						Length = 180,	Type = 3},
	[13] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Blitzheilung",					Length = 0,		Type = 0},
	[14] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Gro\195\159e Heilung",					Length = 0,		Type = 0},
	[15] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Heilen",							Length = 0,		Type = 0},
	[16] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Verhexung der Schw\195\164che",				Length = 120,	Type = 5},
	[17] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Heiliges Feuer",						Length = 10,	Type = 5},
	[18] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Heilige Nova",						Length = 0,		Type = 0},
	[19] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Innerer Fokus",					Length = 180,	Type = 3},
	[20] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Inneres Feuer",					Length = 0,		Type = 0},
	[21] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Inspiration",					Length = 15,	Type = 5},
	[22] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Geringes Heilen",					Length = 0,		Type = 0},
	[23] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Levitieren",						Length = 120,	Type = 0},
	[24] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Brunnen des Lichts",						Length = 600,	Type = 3},
 	[25] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Brunnen des Lichts (1)",					Length = 180,	Type = 2},
	[26] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Brunnen des Lichts (2)",					Length = 180,	Type = 2},
	[27] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Brunnen des Lichts (3)",					Length = 180,	Type = 2},
	[28] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Brunnen des Lichts (4)",					Length = 180,	Type = 2},
	[29] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Brunnen des Lichts (5)",					Length = 600,	Type = 2},
	[30] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Manabrand",						Length = 0,		Type = 0},
	[31] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "M\195\164rtyrertum",						Length = 6,		Type = 0},
	[32] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Gedankenschlag",					Length = 8,		Type = 3},
	[33] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Gedankenkontrolle",					Length = 60,	Type = 0},
	[34] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Gedankenschinden",						Length = 3,		Type = 0},
	[35] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Gedankenbes\195\164nftigung",					Length = 15,	Type = 5},
	[36] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Gedankensicht",					Length = 60,	Type = 0},
	[37] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Seele der Macht",				Length = 180,	Type = 3},
	[38] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Machtwort: Seelenst\195\164rke",			Length = 1800,	Type = 0},
	[39] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Machtwort: Schild",			Length = 30,	Type = 5},
	[40] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Machtwort: Schild Cooldown",	Length = 4,		Type = 3},
	[41] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Gebet der Seelenst\195\164rke",			Length = 3600,	Type = 0},
	[42] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Gebet der Heilung",				Length = 0,		Type = 0},
	[43] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Gebet des Schattenschutzes",	Length = 1200,	Type = 0},
	[44] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Gebet der Willenskraft",				Length = 3600,	Type = 0},
	[45] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Psychischer Schrei",				Length = 30,	Type = 3},
 	[46] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Psychischer Schrei Effekt",			Length = 8,		Type = 5},
	[47] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Erneuerung",							Length = 15,	Type = 5},
	[48] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Auferstehung",					Length = 0,		Type = 0},
	[49] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Untote fesseln",				Length = 50,	Type = 2},
	[50] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Schattenwirken",				Length = 0,		Type = 0},
	[51] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Schattenschutz",				Length = 600,	Type = 0},
	[52] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Schattenwort: Schmerz",				Length = 18,	Type = 5},
	[53] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Schattengestalt",					Length = 0,		Type = 0},
	[54] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Schattenschild",					Length = 600,	Type = 0},
	[55] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Stille",						Length = 45,	Type = 3},
	[56] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "G\195\182ttliche Pein",							Length = 0,		Type = 0},
	[57] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Geist der Erl\195\182sung",			Length = 10,	Type = 0},
	[58] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Sternensplitter",					Length = 0,		Type = 0},
	[59] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Ber\195\188hrung der Schw\195\164che",				Length = 120,	Type = 5},
	[60] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Vampirumarmung",				Length = 60,	Type = 5},
	[61] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Geschw\195\164chte Seele",					Length = 15,	Type = 5},
	[62] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Schattenverwundbarkeit",			Length = 15,	Type = 5},
	[63] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Schattenverwundbarkeit (2)",		Length = 15,	Type = 5},
	[64] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Schattenverwundbarkeit (3)",		Length = 15,	Type = 5},
	[65] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Schattenverwundbarkeit (4)",		Length = 15,	Type = 5},
	[66] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Schattenverwundbarkeit (5)",		Length = 15,	Type = 5},
	[67] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Blackout",						Length = 3,		Type = 5},
	[68] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Brunnen des Lichts Erneuerung",				Length = 10,	Type = 5},
	[69] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Vampirumarmung ",				Length = 10,	Type = 3},
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
SERENITY_ITEM = {
	["LightFeather"] = "Leichte Feder",
	["HolyCandle"] = "Heilige Kerze",
	["SacredCandle"] = "Hochheilige Kerze",
	["Potion"] = "trank",
	["Draught"] = "gebr\195\164u",
	["ManaPotion"] = "Manatrank",
	["HealingPotion"] = "Heiltrank",
	["Healthstone"] = "Gesundheitsstein",
	["Hearthstone"] = "Ruhestein",
};
SERENITY_DRINK_SRCH = { "Wasser", "wasser", "Milch", "saft", "Nektar", "tee", "gebr\195\164u", "imonade", "getr\195\164nk", "tau", "saft", };
SERENITY_DRINK = {
	[1] = { Name = "Erfrischendes Quellwasser", 		Energy = 151, Level = 1,
		Length = 18, Conjured = false, PvP = false },
	[2] = { Name = "Herbeigezaubertes Wasser", 				Energy = 151, Level = 1,
		Length = 18, Conjured = true, PvP = false },
	[3] = { Name = "Bohnengebr\195\164u", 			Energy = 436, Level = 5,
		Length = 21, Conjured = false, PvP = false },	
	[4] = { Name = "Eiskalte Milch", 				Energy = 436, Level = 5,
		Length = 21, Conjured = false, PvP = false },	
	[5] = { Name = "Herbeigezaubertes frisches Wasser", 		Energy = 436, Level = 5,
		Length = 21, Conjured = true, PvP = false },	
	[6] = { Name = "Melonensaft", 					Energy = 835, Level = 15,
		Length = 24, Conjured = false, PvP = false },	
	[7] = { Name = "Prickelndes Marktgetr\195\164nk", 			Energy = 835, Level = 15,
		Length = 24, Conjured = false, PvP = false },
	[8] = { Name = "Blubberwasser", 				Energy = 835, Level = 15,
		Length = 24, Conjured = false, PvP = false },
	[9] = { Name = "Herbeigezaubertes gel\195\164utertes Wasser", 		Energy = 835, Level = 15,
		Length = 24, Conjured = true, PvP = false },	
	[10] = { Name = "S\195\188\195\159er Nektar", 				Energy = 1344, Level = 25,
		Length = 27, Conjured = false, PvP = false },	
	[11] = { Name = "Golddorntee", 				Energy = 1344, Level = 25,
		Length = 27, Conjured = false, PvP = false },	
	[12] = { Name = "Verzaubertes Wasser", 				Energy = 1344, Level = 25,
		Length = 27, Conjured = false, PvP = false },	
	[13] = { Name = "Gr\195\188ner Gartentee", 			Energy = 1344, Level = 25,
		Length = 27, Conjured = false, PvP = false },	
	[14] = { Name = "Herbeigezaubertes Quellwasser", 		Energy = 1344, Level = 25,
		Length = 27, Conjured = true, PvP = false },	
	[15] = { Name = "Mondbeerensaft", 				Energy = 1992, Level = 35,
		Length = 30, Conjured = false, PvP = false },	
	[16] = { Name = "Bottled Winterspring Water", 	Energy = 1992, Level = 35,
		Length = 30, Conjured = false, PvP = false },	
	[17] = { Name = "Herbeigezaubertes Mineralwasser", 		Energy = 1992, Level = 35,
		Length = 30, Conjured = true, PvP = false },	
	[18] = { Name = "Trichterwindentau", 			Energy = 2934, Level = 45,
		Length = 30, Conjured = false, PvP = false },	
	[19] = { Name = "Frisch gepresste Limonade", 	Energy = 2934, Level = 45,
		Length = 30, Conjured = false, PvP = false },	
	[20] = { Name = "Gesegneter Sonnenfruchtsaft", 		Energy = 4410, Level = 45,
		Length = 30, Conjured = false, PvP = false },	
	[21] = { Name = "Herbeigezaubertes Sprudelwasser", 	Energy = 2934, Level = 45,
		Length = 30, Conjured = true, PvP = false },	
	[22] = { Name = "Abgef\195\188lltes Alteracquellwasser", Energy = 4410, Level = 55,
		Length = 30, Conjured = false, PvP = false },	
	[23] = { Name = "Herbeigezaubertes Kristallwasser",		Energy = 4200, Level = 55,
		Length = 30, Conjured = true, PvP = false },	
};
SERENITY_MANA_POTION = {
	[1] = { Name = "Schwacher Manatrank", 	Level = 5, 
		EnergyMin = 140, EnergyMax = 180, 	PvP = false},
	[2] = { Name = "Geringer Manatrank", 	Level = 14, 
		EnergyMin = 280, EnergyMax = 360, 	PvP = false},
	[3] = { Name = "Manatrank", 			Level = 14, 
		EnergyMin = 445, EnergyMax = 585, 	PvP = false},
	[4] = { Name = "Gro\195\159er Manatrank", 	Level = 31, 
		EnergyMin = 700, EnergyMax = 900, 	PvP = false},
	[5] = { Name = "\195\156berragendes Managebr\195\164u",Level = 35, 
		EnergyMin = 700, EnergyMax = 900, 	PvP = true},
	[6] = { Name = "\195\156berragender Manatrank",	Level = 41,
		EnergyMin = 900, EnergyMax = 1500, 	PvP = false},
	[7] = { Name = "Erheblicher Manatrank",	Level = 49,
		EnergyMin = 1350, EnergyMax = 2250,	PvP = false},
	[8] = { Name = "Gefechtsmanatrank",	Level = 41,
		EnergyMin = 900, EnergyMax = 1500, 	PvP = false},
	[9] = { Name = "Erhebliches Managebr\195\164u",	Level = 45,
		EnergyMin = 980, EnergyMax = 1260, 	PvP = true},
}
SERENITY_HEALING_POTION = {
	[1] = { Name = "Schwacher Heiltrank", 	Level = 1, 
		EnergyMin = 70, EnergyMax = 90, PvP = false},
	[2] = { Name = "Schwacher Gesundheitsstein", 	Level = 1, 
		EnergyMin = 100, EnergyMax = 120, PvP = false},
	[3] = { Name = "Geringer Heiltrank", Level = 3, 
		EnergyMin = 140, EnergyMax = 180, PvP = false},
	[4] = { Name = "Verf\195\164rbter Heiltrank",Level = 5, 
		EnergyMin = 140, EnergyMax = 180, PvP = false},
	[5] = { Name = "Heiltrank", 	Level = 12, 
		EnergyMin = 280, EnergyMax = 360, PvP = false},
	[6] = { Name = "Geringer Gesundheitsstein", 	Level = 12, 
		EnergyMin = 250, EnergyMax = 300, PvP = false},
	[7] = { Name = "Gro\195\159er Heiltrank",Level = 21, 
		EnergyMin = 455, EnergyMax = 585, PvP = false},
	[8] = { Name = "Gesundheitsstein", 		Level = 24, 
		EnergyMin = 500, EnergyMax = 600, PvP = false},
	[9] = { Name = "\195\156berragender Heiltrank",Level = 35, 
		EnergyMin = 700, EnergyMax = 900, PvP = false},
	[10] = { Name = "Gefechtsheiltrank", Level = 35, 
		EnergyMin = 700, EnergyMax = 900, PvP = false},
	[11] = { Name = "\195\156berragendes Heilgebr\195\164u",Level = 35, 
		EnergyMin = 560, EnergyMax = 720, PvP = true},
	[12] = { Name = "Gro\195\159er Gesundheitsstein", 	Level = 36, 
		EnergyMin = 800, EnergyMax = 960, PvP = false},
	[13] = { Name = "Whipper Root Tuber", Level = 45, 
		EnergyMin = 700, EnergyMax = 900, PvP = false},
	[14] = { Name = "Erheblicher Heiltrank", Level = 45, 
		EnergyMin = 1050, EnergyMax = 1750, PvP = false},
	[15] = { Name = "Erhebliches Heilgebr\195\164u", Level = 45, 
		EnergyMin = 980, EnergyMax = 1260, PvP = true},
	[16] = { Name = "Erheblicher Gesundheitsstein", Level = 48, 
		EnergyMin = 1200, EnergyMax = 1440, PvP = false},
}

SERENITY_MOUNT_TABLE = {
	-- [1] Frostwolf Howler Icon
	{ "Horn des Frostwolfheulers" }, 
	-- [2] Ram Icon
	{ "Streitwidder der Stormpike", "Wei\195\159er Widder", "Schwarzer Widder", "Schwarzer Kriegswidder", "Brauner Widder", "Frostwidder", "Grauer Widder", "Schneller brauner Widder", "Schneller grauer Widder", "Schneller wei\195\159er Widder", },
	-- [3] Raptor Icon            
	{ "Schneller Razzashiraptor", "Schneller blauer Raptor", "Schneller olivfarbener Raptor", "Schneller orangener Raptor", "Pfeife des schwarzen Kriegsraptors", "Pfeife des smaragdfarbenen Raptors", "Pfeife des elfenbeinfarbenen Raptors", "Pfeife des scheckigen roten Raptors", "Pfeife des t\195\188rkisfarbenen Raptors", "Pfeife des violetten Raptors" },
	-- [4] Yellow Tiger Icon
	{ "Schneller zulianischer Tiger" },
	-- [5] Undead Horse Icon
	{ "Blaues Skelettpferd", "Z\195\188gel des Todesstreitrosses", "Braunes Skelettpferd", "Gr\195\188nes Skelettschlachtross", "Purpurnes Skelettschlachtross", "Rotes Skelettpferd", "Rotes Skelettschlachtross" },
	-- [6] Mechanostrider Icon
	{ "Schwarzer Schlachtenschreiter", "Blauer Roboschreiter", "Gr\195\188ner Roboschreiter", "Eisblauer Roboschreiter Mod. A", "Roter Roboschreiter", "Schneller gr\195\188ner Roboschreiter", "Schneller wei\195\159er Roboschreiter", "Schneller gelber Roboschreiter", "Unlackierter Roboschreiter", "Wei\195\159er Roboschreiter Mod. A" },
	-- [7] Brown Horse Icon
	{ "Rappenzaumzeug", "Braunes Pferd", "Kastanienbraune Stute", "Palominozaumzeug", "Schecke", "Schneller Brauner", "Schnelles Palomino", "Schnelles wei\195\159es Ross", "Schimmelzaumzeug" },
	-- [8] Brown Kodo Icon
	{ "Schwarzer Kriegskodo", "Brauner Kodo", "Groﬂer brauner Kodo" },
	-- [9] War Steed Icon
	{ "Schwarzes Schlachtrosszaumzeug" },
	-- [10] Gray Kodo Icon
	{ "Grauer Kodo", "Gro\195\159er grauer Kodo", "Gro\195\159er wei\195\159er Kodo" },
	-- [11] Green Kodo Icon 
	{ "Gr\195\188ner Kodo", "Graublauer Kodo" },
	-- [12] White Wolf Icon    
	{ "Horn des arktischen Wolfs", "Horn des Terrorwolfs", "Horn des schnellen Grauwolfs", "Horn des schnellen Waldwolfs" },
	-- [13] Black Wolf Icon    
	{ "Horn des schwarzen Kriegswolfs", "Horn des braunen Wolfs", "Horn des roten Wolfs", "Horn des schnellen braunen Wolfs", "Horn des Waldwolfs" },
	-- [14] Black Tiger Icon   
	{ "Z\195\188gel des schwarzen Kriegstigers", "Z\195\188gel des gestreiften Nachts\195\164blers" },
	-- [15] White Tiger Icon   
	{ "Z\195\188gel des Frosts\195\164blers", "Z\195\188gel des Nachts\195\164blers", "Z\195\188gel des gefleckten Frosts\195\164blers", "Z\195\188gel des gestreiften Frosts\195\164blers", "Z\195\188gel des schnellen Frosts\195\164blers", "Z\195\188gel des schnellen Schattens\195\164blers", "Z\195\188gel des schnellen Sturms\195\164blers" },
	-- [16] Red Tiger Icon
	{ "Z\195\188gel des Winterspringfrosts\195\164blers" },
	-- [17] Black Qiraji Resonating Crystal
	{ "Black Qiraji Resonating Crystal" },
}
SERENITY_MOUNT_PREFIX = {
	"Horn des ",
	"Pfeife des ",
	"Z\195\188gel des ",	
}
SERENITY_AQMOUNT_TABLE = {
	"Blauer Qirajiresonanzkristall",
 	"Gr\195\188ner Qirajiresonanzkristall",
 	"Roter Qirajiresonanzkristall",
	"Gelber Qirajiresonanzkristall",
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
	["Hearth"] = "Ruhestein",
	["Rank"] = "Rang",
	["Drink"] = "Trank",
	["Dwarf"] = "Zwerg",
	["NightElf"] = "Nachtelf",
	["Human"] = "Mensch",
	["Gnome"] = "Gnom",
	["Orc"] = "Ork",
	["Troll"] = "Troll",
	["Forsaken"] = "Untoter",
	["Tauren"] = "Taure",
};
end

