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
-- Version Date: 07.09.2006
------------------------------------------------------------------------------------------------------



------------------------------------------------
-- ENGLISH  VERSION FUNCTIONS --
------------------------------------------------
--
if  GetLocale() == "frFR" then

CRYOLYSIS_UNIT_MAGE = "Mage";

--CRYOLYSIS_ANTI_FEAR_SPELL = {
--	-- Buffs giving temporary immunity to fear effects
--	["Buff"] = {
--		"Gardien de peur",			-- Dwarf priest racial trait
--		"Volont\195\169 des R\195\169prouv\195\169s",		-- Forsaken racial trait
--		"Dissipation de peur",			-- Trinket
--		"Furie berserker",		-- Warrior Fury talent
--		"T\195\169m\195\169rit\195\169",			-- Warrior Fury talent
--		"Souhait mortel",			-- Warrior Fury talent
--		"Courroux bestial",		-- Hunter Beast Mastery talent (pet only)
--		"Bloc de glace",			-- Mage Ice talent
--		"Protection divine",		-- Paladin Holy buff
--		"Bouclier divin",		-- Paladin Holy buff
--		"Totem de s\195\169isme",			-- Shaman totem
--		"Abolir magie"			-- Majordomo (NPC) spell
--		--  "Grounding Totem" is not considerated, as it can remove other spell than fear, and only one each 10 sec.		
--	},
--
--	-- Debuffs and curses giving temporary immunity to fear effects
--	["Debuff"] = {
--		"Mal\195\169diction de t\195\169m\195\169rit\195\169"		-- Warlock curse
--	}
--};
--
-- Creature type absolutly immune to fear effects
--CRYOLYSIS_ANTI_FEAR_UNIT = {
--	"Morts-Vivants"
--};
--
-- Word to search for Fire Vulnerability and Winter's chill  first (.+) is the target, second is the spell
CRYOLYSIS_DEBUFF_SRCH = "(.+) subit les effets de (.+)."
CRYOLYSIS_POLY_SRCH = "(.+) n'est plus sous l'influence de (.+)."

function Cryolysis_SpellTableBuild()
CRYOLYSIS_SPELL_TABLE = {
	[1] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Amplification de la magie",					Length = 600,	Type = 0},
	[2] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Illumination des arcanes",					Length = 3600,	Type = 0},
	[3] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Explosion des arcanes",						Length = 0,		Type = 0},
	[4] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Intelligence des arcanes",					Length = 1800,	Type = 0},
	[5] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Projectiles des arcanes",					Length = 0,		Type = 0},
	[6] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Vague d'explosions",						Length = 45,	Type = 3},
	[7] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Transfert",									Length = 15,	Type = 3},
	[8] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Blizzard",									Length = 0,		Type = 0},
	[9] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "C\195\180ne de froid",						Length = 10,	Type = 3},
	[10] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Invocation de nourriture",					Length = 0,		Type = 0},
	[11] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Invocation d'eau",							Length = 0,		Type = 0},
	[12] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Contresort",								Length = 30,	Type = 3},
	[13] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Att\195\169nuer la magie",					Length = 600,	Type = 0},
	[14] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Trait de feu",								Length = 8,		Type = 3},
	[15] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Gardien de feu",							Length = 30,	Type = 3},
	[16] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Boule de feu",								Length = 8,		Type = 5},
	[17] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Choc de flammes",							Length = 8,		Type = 3},
	[18] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Armure de glace",							Length = 300,	Type = 0},
	[19] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Nova de glace",								Length = 25,	Type = 3},
	[20] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Gardien de glace",							Length = 30,	Type = 3},
	[21] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Eclair de glace",							Length = 9,		Type = 5},
	[22] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Armure de glace",							Length = 300,	Type = 0},
	[23] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Barri\195\168re de glace",					Length = 30,	Type = 3},
	[24] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Armure du mage",							Length = 300,	Type = 0},
	[25] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Bouclier de mana",							Length = 60,	Type = 0},
	[26] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "M\195\169tamorphose",						Length = 50,	Type = 2},
	[27] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Portail : Darnassus",						Length = 0,		Type = 0},
	[28] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Portail : Ironforge",						Length = 0,		Type = 0},
	[29] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Portail : Stormwind",						Length = 0,		Type = 0},
	[30] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Portail : Thunder Bluff",					Length = 0,		Type = 0},
	[31] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Portail: Undercity",						Length = 0,		Type = 0},
	[32] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Explosion pyrotechnique",					Length = 12,	Type = 5},
	[33] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "D\195\169livrance de la mal\195\169diction mineure",	Length = 0,		Type = 0},
	[34] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Br\195\187lure",							Length = 0,		Type = 0},
	[35] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Chute lente",								Length = 30,	Type = 0},
	[36] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "T\195\169l\195\169portation : Darnassus",	Length = 0,		Type = 0},
	[37] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "T\195\169l\195\169portation : Ironforge",	Length = 0,		Type = 0},
	[38] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "T\195\169l\195\169portation : Orgrimmar",	Length = 0,		Type = 0},
	[39] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "T\195\169l\195\169portation : Thunder Bluff",Length = 0,		Type = 0},
	[40] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "T\195\169l\195\169portation : Undercity",	Length = 0,		Type = 0},
	[41] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Bloc de glace",								Length = 300,	Type = 3},
	[42] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Morsure de glace",							Length = 600,	Type = 3},
	[43] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Combustion",								Length = 180,	Type = 3},
	[44] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Pr\195\169sence spirituelle",				Length = 180,	Type = 3},
	[45] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Puissance des arcanes",						Length = 180,	Type = 3},
	[46] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "T\195\169l\195\169portation : Darnassus",	Length = 0,		Type = 0},
	[47] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Portail: Orgrimmar",						Length = 0,		Type = 0},
	[48] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "M\195\169tamorphose : cochon",				Length = 50,	Type = 2},
	[49] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Evocation",									Length = 480,	Type = 3},
	[50] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "D\195\169tection de la Magie",				Length = 120,	Type = 5},
	[51] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "T\195\169l\195\169portation : Stormwind",	Length = 0,		Type = 0},
	[52] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "M\195\169tamorphose : tortue",				Length = 50,	Type = 2},
	[53] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Frostbite",									Length = 15,	Type = 5},
	[54] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Froid hivernal",							Length = 15,	Type = 5},
	[55] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Froid hivernal (2)",						Length = 15,	Type = 5},
	[56] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Froid hivernal (3)",						Length = 15,	Type = 5},
	[57] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Froid hivernal (4)",						Length = 15,	Type = 5},
	[58] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Froid hivernal (5)",						Length = 15,	Type = 5},
	[59] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Vuln\195\169rabilit\195\169 au feu",		Length = 30,	Type = 5},
	[60] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Vuln\195\169rabilit\195\169 au feu (2)",	Length = 30,	Type = 5},
	[61] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Vuln\195\169rabilit\195\169 au feu (3)",	Length = 30,	Type = 5},
	[62] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Vuln\195\169rabilit\195\169 au feu (4)",	Length = 30,	Type = 5},
	[63] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Vuln\195\169rabilit\195\169 au feu (5)",	Length = 30,	Type = 5},
	[64] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Mana Gem",									Length = 120,	Type = 3},
	[65] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Freeze",									Length = 5,		Type = 5},
	[66] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Frost nova",			Length = 8,		Type = 6},	
	[67] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Poly Diminished",		Length = 15,	Type = 6},	
};
end
Cryolysis_SpellTableBuild()
-- Type 0 = No Timer
-- Type 1 = Principle permanent timer
-- Type 2 = permanent timer
-- Type 3 = Cooldown Timer
-- Type 4 = Debuff Timer
-- Type 5 = Combat Timer

CRYOLYSIS_ITEM = {
	["LightFeather"] = "Plume l\195\169g\195\168re",
	["ArcanePowder"] = "Poudre des arcanes",
	["RuneOfTeleportation"] = "Rune de t\195\169l\195\169portation",
	["RuneOfPortals"] = "Rune des portails",
	["Manastone"] = "Pierre de mana",
	["Hearthstone"] = "Pierre de foyer",
	["Provision"] = "Invoqu\195\169",
	["Evocation"] = "Evocation",
	["Drink"] = "Eau",
	["Food"] = "Nourriture",
};
CRYOLYSIS_FOOD_RANK = {
	[1] = " Muffin ",
	[2] = " Pain ",
	[3] = " Pain de voyage ",
	[4] = " Pain noir ",
	[5] = " Pain de route ",
	[6] = " Pain au lait ", 
	[7] = " Roul\195\169s \195\160 la cannelle ",
};
CRYOLYSIS_DRINK_RANK = {
	[1] = " Eau ",
	[2] = " Eau fra\195\174che ",
	[3] = " Eau purifi\195\169e ",
	[4] = " Eau de source ",
	[5] = " Eau min\195\169rale ",
	[6] = " Eau p\195\169tillante ",
	[7] = " Eau cristalline ",
};
CRYOLYSIS_STONE_RANK = {
	[1] = " Agate",		-- Rank Minor
	[2] = " Jade",		-- Rank Lesser
	[3] = " Citrine",	-- Rank Greater
	[4] = " Rubis"		-- Rank Major
};
CRYOLYSIS_STONE_RANK2 = {
	[1] = "Agate",		-- Rank Minor
	[2] = "Jade",		-- Rank Lesser
	[3] = "Citrine",	-- Rank Greater
	[4] = "Rubis"		-- Rank Major
};

CRYOLYSIS_MANASTONE_NAMES = {
	[1] = "Invoquer une Agate de Mana",
	[2] = "Invoquer une Jade de Mana",
	[3] = "Invoquer une Citrine de Mana",
	[4] = "Invoquer un Rubis de Mana"
};
CRYOLYSIS_CREATE = {
	[1] = "Evocation",
	[2] = "Invocation de pierre de mana",
	[3] = "Invocation d'eau",
	[4] = "Invocation de nourriture"
};

CRYOLYSIS_MOUNT_TABLE = {
	-- [1] Frostwolf Howler Icon
	{ "Cor du hurleur Frostwolf" }, 
	-- [2] Ram Icon
	{ "Destrier de bataille Stormpike", "B\195\169lier noir", "B\195\169lier de guerre noir", "B\195\169lier brun", "B\195\169lier blanc", "B\195\169lier gris", "B\195\169lier brun rapide", "B\195\169lier gris rapide", "B\195\169lier blanc rapide", },
	-- [3] Raptor Icon            
	{ "Raptor Razzashi rapide", "Raptor bleu rapide", "Raptor vert olive rapide", "Raptor orange rapide", "Sifflet de Raptor de guerre noir", "Sifflet de Raptor \195\169meraude", "Sifflet de Raptor Ivoire", "Sifflet de Raptor tigr\195\169 rouge", "Sifflet de Raptor turquoise", "Sifflet de Raptor Violet" },
	-- [4] Yellow Tiger Icon
	{ "Tigre Zulien rapide" },
	-- [5] Undead Horse Icon
	{ "R\195\168nes de Deathcharger", "Cheval squelette bai", "Cheval de guerre squelette vert ", "Cheval de guerre squelette violet", "Cheval squelette rouge", "Cheval de guerre squelette rouge" },
	-- [6] Mechanostrider Icon
	{ "Strider de bataille noir", "M\195\169canotrotteur bleu", "M\195\169canotrotteur vert", "M\195\169canotrotteur bleu Mod A", "M\195\169canotrotteur rouge", "M\195\169canotrotteur vert rapide", "M\195\169canotrotteur blanc rapide", "M\195\169canotrotteur jaune rapide", "M\195\169canotrotteur brut", "M\195\169canotrotteur blanc Mod A" },
	-- [7] Brown Horse Icon
	{ "Bride d'Etalon noir", "Bride de Jument alezane", "Bride de Cheval bai", "Bride de Palomino", "Bride de Pinto", "Palefroi bai rapide", "Palomino rapide", "Palefroi blanc rapide", "Bride d'Etalon blanc" },
	-- [8] Brown Kodo Icon
	{ "Kodo de guerre noir", "Kodo marron", "Grand kodo marron" },
	-- [9] War Steed Icon
	{ "Palefroi de guerre noir" },
	-- [10] Gray Kodo Icon
	{ "Kodo gris", "Grand kodo gris", "Grand kodo blanc" },
	-- [11] Green Kodo Icon 
	{ "Kodo vert", "Kodo bleut\195\169" },
	-- [12] White Wolf Icon    
	{ "Cor de Loup Artique", "Cor de loup sauvage de monte", "Cor de Loup gris rapide", "Cor de Loup des bois rapide" },
	-- [13] Black Wolf Icon    
	{ "Cor de Loup de guerre noir", "Cor de Loup brun", "Cor de Loup rouge", "Cor de Loup brun rapide", "Corne de Loup forestier de monte" },
	-- [14] Black Tiger Icon   
	{ "R\195\168nes de Tigre de guerre noir", "R\195\168nes de Sabre-de-nuit de monte ray\195\169" },
	-- [15] White Tiger Icon   
	{ "R\195\168nes de Sabre-de-givre", "R\195\168nes de Sabre-de-nuit", "R\195\168nes de Sabre-de-givre mouchet\195\169", "R\195\168nes de Sabre-de-givre ray\195\169", "R\195\168nes de Sabre-de-givre rapide", "R\195\168nes de Sabre-de-brume", "R\195\168nes de Sabre-temp\195\170te rapide" },
	-- [16] Red Tiger Icon
	{ "R\195\168nes de Sabre-de-givre du Berceau de l'Hiver" },
	-- [17] Black Qiraji Resonating Crystal
	{ "Black Qiraji Resonating Crystal" },
}

CRYOLYSIS_MOUNT_PREFIX = {
	"Cor du ",
	"Sifflet de ",
	"R\195\168nes de ",	
}

CRYOLYSIS_AQMOUNT_TABLE = {
	"Blue Qiraji Resonating Crystal",
 	"Green Qiraji Resonating Crystal",
 	"Red Qiraji Resonating Crystal",
	"Yellow Qiraji Resonating Crystal",
}
CRYOLYSIS_TRANSLATION = {
	["Cooldown"] = "Temps de recharge",
	["Hearth"] = "Pierre de Foyer",
	["Rank"] = "Rang",
	["Invisible"] = "D\195\169tection de l'invisibilit\195\169",
	["LesserInvisible"] = "D\195\169tection de l'invisibilit\195\169 inf\195\169rieure",
	["GreaterInvisible"] = "D\195\169tection de l'invisibilit\195\169 sup\195\169rieure",
	["SoulLinkGain"] = "Vous gagnez Lien Spirituel.",
	["SacrificeGain"] = "Vous gagnez Sacrifice.",
	["SummoningRitual"] = "Rituel d'Invocation"
};
end

