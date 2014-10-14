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
------------------------------------------------------------------------------------------------------

-- German Translation by Faryn, Thanks to him :)

------------------------------------------------------------------------------------------------------

if ( GetLocale() == "deDE" ) then

HOLYHOPE_UNIT_PALADIN = "Paladin";

-- Points de repère du trimmer
    RECKONING = "Abrechnung"; 
    YOUHIT = "Ihr trefft";      
    YOUCRIT = "Ihr trefft (.+) kritisch"; 

-- Table des sorts du paladin
HOLYHOPE_SPELL_TABLE = {
	["ID"] = {},
	["Rank"] = {},
	["Name"] = {
		"Schlachtross beschw\195\182ren",	 --1
		"Streitross beschw\195\182ren",	         --2
		"Segen der Macht",                       --3
		"Segen der Weisheit",                    --4
		"Segen der Rettung",                     --5
		"Segen des Lichts",                      --6
		"Segen der K\195\182nige",               --7
		"Segen des Refugiums",                   --8
		"Segen der Freiheit",                    --9
		"Segen der Opferung",                    --10		
		"Gro\195\159er Segen der Macht",         --11
		"Gro\195\159er Segen der Weisheit",      --12
		"Gro\195\159er Segen der Rettung",       --13
		"Gro\195\159er Segen des Lichts",        --14
		"Gro\195\159er Segen der K\195\182nige", --15
		"Gro\195\159er Segen des Refugiums",     --16
		"Siegel des Befehls",                    --17
		"Siegel des Kreuzfahrers",               --18
		"Siegel der Gerechtigkeit",              --19
		"Siegel des Lichts",                     --20
		"Siegel der Rechtschaffenheit",          --21
		"Siegel der Weisheit",                   --22
		"Richturteil",                           --23
		"Hammer des Zorns",                      --24
		"Erl\195\182sung",                       --25
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
	["Kings"] = "Symbol der K\195\182nige",
	["Hearthstone"] = "Ruhestein",
	["QuirajiMount"] = "Qirajiresonanzkristall",
};

-- Traduction
HOLYHOPE_TRANSLATION = {
	["Cooldown"] = "Abklingzeit",
	["Rank"] = "Rang",
};

-- Message
HOLYHOPE_MESSAGE = {
  ["SLASH"] = {
    ["InitOn"] = "HolyHope An. /holyhope oder /hh f\195\188r Optionen *Deutsche \195\188bersetzung von Faryn@Nathrezim*",
  },
  ["TOOLTIP"] = {
    ["Clic"] = "Klick:",
    ["RightClic"] = "Rechtsklick: Ruhestein",
    ["NotUp"] = " Gruppenbuffs",
    ["Up"] = " Einzelbuffs",
    ["Judgement"] = "Klicke zum Richten",
  },
  ["nohearthstone"] = "Ihr habt keinen Ruhestein im Inventar",
};

-- Monture
MOUNT_ITEM = {
  ["ReinsMount"] = "Z\195\188gel",
  ["RamMount"] = "Widder",
  ["BridleMount"] = "Zaumzeug",
  ["BridleMount2"] = "zaumzeug",
  ["BridleMount3"] = "Zaumzeug",
  ["MechanostriderMount"] = "Roboschreiter",
  ["QuirajiMount"] = "Qirajiresonanzkristall",
};

-- Menu
HOLYHOPE_MENU = {
  ["Lenght"] = "Lenght",
  ["Actif"] = "Actif",
  ["Drag"] = "Bewegen",
  ["Unlock"] = "HolyHope's frames are now Unlock",
  ["Lock"] = "HolyHope's frames are now Lock",
  ["Tooltips"] = "Tooltips",
  ["Blessing"] = "Segen",
  ["Seal"] = "Siegel",
  ["Mount"] = "Mount",
  ["Off"] = "Aus",
  ["Partial"] = "Minimal",
  ["Tab1"] = "Generals Options",
  ["Tab2"] = "Pop-up and Tooltips",
  ["Total"] = "Kompletter",  
};

end
