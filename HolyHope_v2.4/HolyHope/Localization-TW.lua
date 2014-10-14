------------------------------------------------------------------------------------------------------
-- HolyHope 2.4

-- Addon pour Paladin
-- Gestion des benedictions et Compteur de sympbole des rois

-- Remerciements aux auteurs de Necrosis et KingsCounter

-- Remerciements speciaux � Erosenin, guilde Exodius, Designer de HolyHope

-- Auteur Freeman
-- Pour reporter un bug ou une id�e d'am�lioration: THEFREEMAN55@free.fr

-- Serveur:
-- Freeman, guilde Exodius, Ner'Zhul FR
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

-- Traditionnal Chinese Translation by BestSteve, Thanks to him :)

------------------------------------------------------------------------------------------------------

if ( GetLocale() == "zhTW" ) then

HOLYHOPE_UNIT_PALADIN = "聖騎士";

-- Table des sorts du paladin
HOLYHOPE_SPELL_TABLE = {
	["ID"] = {},
	["Rank"] = {},
	["Name"] = {
		"召喚軍馬",        --1
		"召喚戰馬",        --2
		"力量祝福",        --3
		"智慧祝福",        --4
		"拯救祝福",        --5
		"光明祝福",        --6
		"王者祝福",        --7
		"庇護祝福",        --8
		"自由祝福",        --9
		"犧牲祝福",        --10
		"強效力量祝福",  --11
		"強效智慧祝福",  --12
		"強效拯救祝福",  --13
		"強效光明祝福",  --14
		"強效王者祝福",  --15
		"強效庇護祝福",  --16
		"命令聖印",        --17
		"十字軍聖印",     --18
		"正義聖印",        --19
		"光明聖印",        --20
		"公正聖印",        --21
		"智慧聖印",        --22
		"審判",              --23
		"憤怒之鎚",        --24
		"救贖",              --25
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
	["Kings"] = "王者印記",
	["Hearthstone"] = "爐石",
	["QuirajiMount"] = "其拉共鳴水晶",
};

-- Traduction
HOLYHOPE_TRANSLATION = {
	["Cooldown"] = "冷卻時間",
	["Rank"] = "等級 ",
};

-- Message
HOLYHOPE_MESSAGE = {
  ["SLASH"] = {
    ["InitOn"] = "HolyHope 啟用。 /holyhope 或者 /hh 顯示選項",
  },
  ["TOOLTIP"] = {
    ["Clic"] = "點擊切換：",
    ["RightClic"] = "右鍵點擊：爐石",
    ["NotUp"] = " 強效祝福",
    ["Up"] = " 普通祝福",
    ["Judgement"] = "點擊以審判",
  },
  ["nohearthstone"] = "你的包裹裡沒有爐石",
};

-- Monture
MOUNT_ITEM = {
  ["ReinsMount"] = "馬",
  ["RamMount"] = "山羊",
  ["BridleMount"] = "韁繩",
  ["BridleMount2"] = "雷矛軍用坐騎",
  ["BridleMount3"] = "霜狼嗥叫者的號角",
  ["MechanostriderMount"] = "機械陸型鳥",
  ["QuirajiMount"] = "黑色其拉共鳴水晶",
};

-- Menu
HOLYHOPE_MENU = {
  ["Lenght"] = "Lenght",
  ["Actif"] = "Actif",
  ["Drag"] = "Drag",
  ["Unlock"] = "HolyHope's frames are now Unlock",
  ["Lock"] = "HolyHope's frames are now Lock",
  ["Tooltips"] = "Tooltips",
  ["Blessing"] = "祝福",
  ["Seal"] = "聖印",
  ["Mount"] = "Mount",
  ["Off"] = "Off",
  ["Partial"] = "Partials",
  ["Tab1"] = "Generals Options",
  ["Tab2"] = "Pop-up and Tooltips",
  ["Total"] = "Totals",  
};

end
