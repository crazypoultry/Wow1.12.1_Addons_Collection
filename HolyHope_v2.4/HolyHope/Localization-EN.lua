------------------------------------------------------------------------------------------------------
-- HolyHope 2.4

-- Addon pour Paladin
-- Gestion des benedictions et Compteur de sympbole des rois

-- Remerciements aux auteurs de Necrosis et KingsCounter

-- Remerciements speciaux à Erosenin, guilde Exodius, Designer de HolyHope

-- Auteur Freeman
-- Pour reporter un bug ou une idée d'amélioration: THEFREEMAN55@free.fr

-- Serveur:
-- Freeman, guilde Exodius, Ner'Zhul FR
------------------------------------------------------------------------------------------------------

if ( GetLocale() == "enUS" ) or ( GetLocale() == "enGB" ) then

HOLYHOPE_UNIT_PALADIN = "Paladin";

-- Points de repère du trimmer
    RECKONING = "Reckoning"; 
    YOUHIT = "You hit";      
    YOUCRIT = "You crit"; 

-- Table des sorts du paladin
HOLYHOPE_SPELL_TABLE = {
	["ID"] = {},
	["Rank"] = {},
	["Name"] = {
		"Summon Warhorse",			          --1
		"Summon Charger",	          	    --2
		"Blessing of Might",              --3
		"Blessing of Wisdom",             --4
		"Blessing of Salvation",          --5
		"Blessing of Light",              --6
		"Blessing of Kings",              --7
		"Blessing of Sanctuary",          --8
		"Blessing of Freedom",            --9
		"Blessing of Sacrifice",          --10		
		"Greater Blessing of Might",      --11
		"Greater Blessing of Wisdom",     --12
		"Greater Blessing of Salvation",  --13
		"Greater Blessing of Light",      --14
		"Greater Blessing of Kings",      --15
		"Greater Blessing of Sanctuary",  --16
		"Seal of Command",                --17
		"Seal of the Crusader",           --18
		"Seal of Justice",                --19
		"Seal of Light",                  --20
		"Seal of Righteousness",          --21
		"Seal of Wisdom",                 --22
		"Judgement",                      --23
		"Hammer of Wrath",                --24
		"Redemption",                     --25
		},
	["Mana"] = {}
};

-- Raccourcis claviers
BINDING_HEADER_HOLYHOPE_BIND = "HolyHope";   
BINDING_NAME_STEED = "Mount";
BINDING_NAME_NORMALSTEED = "Normal Mount";
BINDING_NAME_MIGHT = HOLYHOPE_SPELL_TABLE.Name[3];
BINDING_NAME_WISDOM = HOLYHOPE_SPELL_TABLE.Name[4];
BINDING_NAME_SALVATION = HOLYHOPE_SPELL_TABLE.Name[13];
BINDING_NAME_LIGHT = HOLYHOPE_SPELL_TABLE.Name[6];
BINDING_NAME_KINGS = HOLYHOPE_SPELL_TABLE.Name[7];
BINDING_NAME_SANCTUARY = HOLYHOPE_SPELL_TABLE.Name[8];
BINDING_NAME_FREEDOM = HOLYHOPE_SPELL_TABLE.Name[9];
BINDING_NAME_SACRIFICE = HOLYHOPE_SPELL_TABLE.Name[10];
BINDING_NAME_SCOMMAND = HOLYHOPE_SPELL_TABLE.Name[17];
BINDING_NAME_SCRUSADER = HOLYHOPE_SPELL_TABLE.Name[18];
BINDING_NAME_SJUSTICE = HOLYHOPE_SPELL_TABLE.Name[19];
BINDING_NAME_SLIGHT = HOLYHOPE_SPELL_TABLE.Name[20];
BINDING_NAME_SRIGHTEOUSNESS = HOLYHOPE_SPELL_TABLE.Name[21];
BINDING_NAME_SWISDOM = HOLYHOPE_SPELL_TABLE.Name[22];
BINDING_NAME_JUDGEMENT = HOLYHOPE_SPELL_TABLE.Name[23];
BINDING_NAME_WRATH = HOLYHOPE_SPELL_TABLE.Name[24];
BINDING_NAME_REDEMPTION = HOLYHOPE_SPELL_TABLE.Name[25];

-- Table des items du paladin
HOLYHOPE_ITEM = {
	["Kings"] = "Symbol of Kings",
	["Hearthstone"] = "Hearthstone",
	["QuirajiMount"] = "Qiraji Resonating Crystal",
};

-- Traduction
HOLYHOPE_TRANSLATION = {
	["Cooldown"] = "Cooldown",
	["Rank"] = "Rank",
};

-- Message
HOLYHOPE_MESSAGE = {
  ["SLASH"] = {
    ["InitOn"] = "HolyHope On. /holyhope ou /hh to show options",
  },
  ["TOOLTIP"] = {
    ["Clic"] = "Click:",
    ["RightClic"] = "Right Click: Hearthstone",
    ["NotUp"] = " Class blessing",
    ["Up"] = " Individual blessing",
    ["Judgement"] = "Click to Judge",
  },
  ["nohearthstone"] = "You do not have any Hearthstone in your inventory",
};

-- Monture
MOUNT_ITEM = {
  ["ReinsMount"] = "Reins",
  ["RamMount"] = "Ram",
  ["BridleMount"] = "Bridle",
  ["BridleMount2"] = "Bridle",
  ["BridleMount3"] = "Bridle",
  ["MechanostriderMount"] = "Mechanostrider",
  ["QuirajiMount"] = "Qiraji Resonating Crystal",
};

-- Menu
HOLYHOPE_MENU = {
  ["Lenght"] = "Lenght",
  ["Actif"] = "Actif",
  ["Drag"] = "Drag",
  ["Unlock"] = "HolyHope's frames are now Unlock",
  ["Lock"] = "HolyHope's frames are now Lock",
  ["Tooltips"] = "Tooltips",
  ["Blessing"] = "Blessing",
  ["Seal"] = "Seal",
  ["Mount"] = "Mount",
  ["Off"] = "Off",
  ["Partial"] = "Partials",
  ["Tab1"] = "Generals Options",
  ["Tab2"] = "Pop-up and Tooltips",
  ["Total"] = "Totals",  
};

end
