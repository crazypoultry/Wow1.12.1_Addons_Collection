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

if ( GetLocale() == "frFR" ) then

HOLYHOPE_UNIT_PALADIN = "Paladin";

-- Points de repère du trimmer
    RECKONING = "R\195\169tribution"; 
    YOUHIT = "Vous touchez";      
    YOUCRIT = "Vous infligez un coup critique";     


-- Table des sorts du paladin
HOLYHOPE_SPELL_TABLE = {
	["ID"] = {},
	["Rank"] = {},
	["Name"] = {
		"Invocation d'un cheval de guerre",			         --1
		"Invocation de destrier",	          	                 --2
		"B\195\169n\195\169diction de puissance",                        --3
		"B\195\169n\195\169diction de sagesse",                          --4
		"B\195\169n\195\169diction de salut",                            --5
		"B\195\169n\195\169diction de lumi\195\168re",                   --6
		"B\195\169n\195\169diction des rois",                            --7
		"B\195\169n\195\169diction du sanctuaire",                       --8
		"B\195\169n\195\169diction de libert\195\169",                   --9
		"B\195\169n\195\169diction de sacrifice",                        --10		
		"B\195\169n\195\169diction de puissance sup\195\169rieure",      --11
		"B\195\169n\195\169diction de sagesse sup\195\169rieure",        --12
		"B\195\169n\195\169diction de salut sup\195\169rieure",          --13
		"B\195\169n\195\169diction de lumi\195\168re sup\195\169rieure", --14
		"B\195\169n\195\169diction des rois sup\195\169rieure",          --15
		"B\195\169n\195\169diction du sanctuaire sup\195\169rieure",     --16
		"Sceau d'autorit\195\169",                                       --17
		"Sceau du Crois\195\169",                                        --18
		"Sceau de justice",                                              --19
		"Sceau de lumi\195\168re",                                       --20
		"Sceau de pi\195\169t\195\169",                                  --21
		"Sceau de sagesse",                                              --22
		"Jugement",                                                      --23
		"Marteau de courroux",                                           --24
		"R\195\169demption",                                             --25
		},
	["Mana"] = {}
};

-- Raccourcis claviers
BINDING_HEADER_HOLYHOPE_BIND = "HolyHope";   
BINDING_NAME_STEED = "Monture";
BINDING_NAME_NORMALSTEED = "Monture Normal";
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
	["Kings"] = "Symbole des rois",
	["Hearthstone"] = "Pierre de foyer",
	["QuirajiMount"] = "Cristal de r\195\169sonance qiraji",
};

-- Traduction
HOLYHOPE_TRANSLATION = {
	["Cooldown"] = "Temps",
	["Rank"] = "Rang",
};

-- Message
HOLYHOPE_MESSAGE = {
  ["SLASH"] = {
    ["InitOn"] = "HolyHope activ\195\169. /holyhope ou /hh pour les options",
  },
  ["TOOLTIP"] = {
    ["Clic"] = "Clic: B\195\169n\195\169diction",
    ["RightClic"] = "Clic Droit: Pierre de foyer",
    ["NotUp"] = " de Classe",
    ["Up"] = " Individuel",
    ["Judgement"] = "Cliquer pour juger",
  },
  ["nohearthstone"] = "Vous n'avez pas de pierre de foyer dans votre inventaire",
};

-- Monture
MOUNT_ITEM = {
  ["ReinsMount"] = "R\195\170nes",
  ["RamMount"] = "B\195\169lier",
  ["BridleMount"] = "Bride",
  ["BridleMount2"] = "Palefroi",
  ["BridleMount3"] = "Palomino",
  ["MechanostriderMount"] = "M\195\169canotrotteur",
  ["QuirajiMount"] = "Cristal de r\195\169sonance qiraji",
};

-- Menu
HOLYHOPE_MENU = {
  ["Actif"] = "Actif",
  ["Blessing"] = "B\195\169n\195\169diction",
  ["Drag"] = "Bloquage",
  ["Lenght"] = "Taille de l'icone",  
  ["Lock"] = "Les fen\195\170tres de HolyHope sont maintenant bloqu\195\169es",
  ["Mount"] = "Monture",
  ["Off"] = "Aucunes",
  ["Partial"] = "Partiels",
  ["Seal"] = "Sceau",
  ["Tab1"] = "Options G\195\169n\195\169rales",
  ["Tab2"] = "Pop-up et Aides",
  ["Tooltips"] = "Aides",
  ["Total"] = "Totales",
  ["Unlock"] = "Les fen\195\170tres de HolyHope sont maintenant libres",  
};

end
