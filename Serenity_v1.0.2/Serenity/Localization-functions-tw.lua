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
-- Version Date: 08.16.2006
------------------------------------------------------------------------------------------------------



------------------------------------------------
-- Traditional Chinese  VERSION FUNCTIONS --- Nightly@布蘭卡德  感謝巴哈(Grisbank) 提供協助
------------------------------------------------
--
if ( GetLocale() == "zhTW" ) then

SERENITY_UNIT_PRIEST = "牧師";

-- Word to search for Fire Vulnerability and Winter's shadow  first (.+) is the target, second is the spell
SERENITY_DEBUFF_SRCH = "(.+)受到(.+)的傷害"
SERENITY_FADE_SRCH = "(.+)效果從(.+)身上消失。"
SERENITY_GAIN_SRCH = "(.+)獲得了(.+)的效果。"
SERENITY_CORPSE_SRCH = "(.+)的屍體"

function Serenity_SpellTableBuild()
	SERENITY_SPELL_TABLE = {
	[1] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "驅除疾病",						Length = 10,	Type = 7},
	[2] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "祝福復元",						Length = 6,		Type = 0},
	[3] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "祛病術",						Length = 0,		Type = 0},
	[4] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "絕望禱言",						Length = 600,	Type = 3},
	[5] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "噬靈瘟疫",						Length = 24,	Type = 5},
	[6] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "噬靈瘟疫",						Length = 180,	Type = 3},
	[7] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "驅散魔法",						Length = 0,		Type = 0},
	[8] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "神聖之靈",						Length = 1800,	Type = 0},
	[9] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "伊露恩的賜福",					Length = 300,	Type = 3},
	[10] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "漸隱術",						Length = 30,	Type = 3},
	[11] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "防護恐懼結界",					Length = 30,	Type = 3},
	[12] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "回饋",							Length = 180,	Type = 3},
	[13] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "快速治療",						Length = 0,		Type = 0},
	[14] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "強效治療術",					Length = 15,	Type = 7},
	[15] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "治療術",						Length = 0,		Type = 0},
	[16] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "虛弱妖術",						Length = 120,	Type = 5},
	[17] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "神聖之火",						Length = 10,	Type = 5},
	[18] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "神聖新星",						Length = 0,		Type = 0},
	[19] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "心靈專注",						Length = 180,	Type = 3},
	[20] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "心靈之火",						Length = 0,		Type = 0},
	[21] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "靈感",							Length = 15,	Type = 5},
	[22] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "次級治療術",					Length = 0,		Type = 0},
	[23] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "漂浮術",						Length = 120,	Type = 0},
	[24] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "光束泉",						Length = 600,	Type = 3},
 	[25] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "光束泉(1)",						Length = 180,	Type = 2},
	[26] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "光束泉(2)",						Length = 180,	Type = 2},
	[27] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "光束泉(3)",						Length = 180,	Type = 2},
	[28] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "光束泉(4)",						Length = 180,	Type = 2},
	[29] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "光束泉(5)",						Length = 600,	Type = 2},
	[30] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "法力燃燒",						Length = 0,		Type = 0},
	[31] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "殉難",							Length = 6,		Type = 0},
	[32] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "心靈震爆",						Length = 8,		Type = 3},
	[33] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "精神控制",						Length = 60,	Type = 0},
	[34] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "精神鞭笞",						Length = 3,		Type = 0},
	[35] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "安撫心靈",						Length = 15,	Type = 5},
	[36] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "心靈視界",						Length = 60,	Type = 0},
	[37] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "注入能量",						Length = 180,	Type = 3},
	[38] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "真言術：韌",					Length = 1800,	Type = 0},
	[39] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "真言術：盾",					Length = 30,	Type = 5},
	[40] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "真言術：盾冷卻",				Length = 4,		Type = 3},
	[41] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "堅韌禱言",						Length = 3600,	Type = 0},
	[42] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "治療禱言",						Length = 0,		Type = 0},
	[43] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "暗影防護禱言",					Length = 1200,	Type = 0},
	[44] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "精神禱言",						Length = 3600,	Type = 0},
	[45] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "心靈尖嘯",						Length = 30,	Type = 3},
 	[46] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "心靈尖嘯效果的影響",			Length = 8,		Type = 5},
	[47] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "恢復",							Length = 15,	Type = 7},
	[48] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "復活術",						Length = 0,		Type = 0},
	[49] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "束縛不死生物",					Length = 50,	Type = 2},
	[50] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "暗影之波",						Length = 0,		Type = 0},
	[51] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "暗影防護",						Length = 600,	Type = 0},
	[52] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "暗言術：痛",					Length = 18,	Type = 5},
	[53] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "暗影形態",						Length = 0,		Type = 0},
	[54] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "暗影守衛",						Length = 600,	Type = 0},
	[55] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "沉默",							Length = 45,	Type = 3},
	[56] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "懲擊",							Length = 0,		Type = 0},
	[57] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "救贖之魂",						Length = 10,	Type = 0},
	[58] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "星辰碎片",						Length = 0,		Type = 0},
	[59] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "虛弱之觸",						Length = 120,	Type = 6},
	[60] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "吸血鬼的擁抱",					Length = 60,	Type = 5},
	[61] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "虛弱靈魂",						Length = 15,	Type = 7},
	[62] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "暗影易傷",						Length = 15,	Type = 6},
	[63] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "暗影易傷(2)",					Length = 15,	Type = 6},
	[64] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "暗影易傷(3)",					Length = 15,	Type = 6},
	[65] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "暗影易傷(4)",					Length = 15,	Type = 6},
	[66] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "暗影易傷(5)",					Length = 15,	Type = 6},
	[67] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "昏厥",							Length = 3,		Type = 5},
	[68] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "恢復光束泉",					Length = 10,	Type = 7},
	[69] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "吸血鬼的擁抱 ",					Length = 10,	Type = 3},
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
	["LightFeather"] = "輕羽毛",
	["HolyCandle"] = "聖潔蠟燭",
	["SacredCandle"] = "神聖蠟燭",
	["Potion"] = "藥水",
	["Draught"] = "藥膏",
	["ManaPotion"] = "法力藥水",
	["HealingPotion"] = "治療藥水",
	["Healthstone"] = "治療石",
	["Hearthstone"] = "爐石",
};
SERENITY_DRINK_SRCH = { "水", "豆酒", "牛奶", "果汁", "飲料", "茶", "酒", "檸檬汁", };
SERENITY_DRINK = {
	[1] = { Name = "清涼的泉水", 		Energy = 151, Level = 1,
		Length = 18, Conjured = false, PvP = false },
	[2] = { Name = "魔法水", 				Energy = 151, Level = 1,
		Length = 18, Conjured = true, PvP = false },
	[3] = { Name = "混製豆酒", 			Energy = 436, Level = 5,
		Length = 21, Conjured = false, PvP = false },	
	[4] = { Name = "冰鎮牛奶", 				Energy = 436, Level = 5,
		Length = 21, Conjured = false, PvP = false },	
	[5] = { Name = "魔法淡水", 		Energy = 436, Level = 5,
		Length = 21, Conjured = true, PvP = false },	
	[6] = { Name = "果汁", 					Energy = 835, Level = 15,
		Length = 24, Conjured = false, PvP = false },	
	[7] = { Name = "泡沫飲料", 			Energy = 835, Level = 15,
		Length = 24, Conjured = false, PvP = false },
	[8] = { Name = "泡沫水", 				Energy = 835, Level = 15,
		Length = 24, Conjured = false, PvP = false },
	[9] = { Name = "魔法純淨水", 		Energy = 835, Level = 15,
		Length = 24, Conjured = true, PvP = false },	
	[10] = { Name = "蜂蜜飲料", 				Energy = 1344, Level = 25,
		Length = 27, Conjured = false, PvP = false },	
	[11] = { Name = "金棘茶", 				Energy = 1344, Level = 25,
		Length = 27, Conjured = false, PvP = false },	
	[12] = { Name = "魔法水", 				Energy = 1344, Level = 25,
		Length = 27, Conjured = false, PvP = false },	
	[13] = { Name = "Green Garden Tea", 			Energy = 1344, Level = 25,
		Length = 27, Conjured = false, PvP = false },	
	[14] = { Name = "魔法泉水", 		Energy = 1344, Level = 25,
		Length = 27, Conjured = true, PvP = false },	
	[15] = { Name = "草莓汁", 				Energy = 1992, Level = 35,
		Length = 30, Conjured = false, PvP = false },	
	[16] = { Name = "冬泉之水", 	Energy = 1992, Level = 35,
		Length = 30, Conjured = false, PvP = false },	
	[17] = { Name = "魔法礦泉水", 		Energy = 1992, Level = 35,
		Length = 30, Conjured = true, PvP = false },	
	[18] = { Name = "晨露酒", 			Energy = 2934, Level = 45,
		Length = 30, Conjured = false, PvP = false },	
	[19] = { Name = "現搾的檸檬汁", 	Energy = 2934, Level = 45,
		Length = 30, Conjured = false, PvP = false },	
	[20] = { Name = "神聖太陽果汁", 		Energy = 4410, Level = 45,
		Length = 30, Conjured = false, PvP = false },	
	[21] = { Name = "魔法蘇打水", 	Energy = 2934, Level = 45,
		Length = 30, Conjured = true, PvP = false },	
	[22] = { Name = "奧特蘭克瓶裝泉水", Energy = 4410, Level = 55,
		Length = 30, Conjured = false, PvP = false },	
	[23] = { Name = "可口的魔法點心", Energy = 4410, Level = 45,
		Length = 30, Conjured = false, PvP = false },	
	[24] = { Name = "魔法晶水",		Energy = 4200, Level = 55,
		Length = 30, Conjured = true, PvP = false },	
};
SERENITY_MANA_POTION = {
	[1] = { Name = "初級法力藥水", 	Level = 5, 
		EnergyMin = 140, EnergyMax = 180, 	PvP = false},
	[2] = { Name = "次級法力藥水", 	Level = 14, 
		EnergyMin = 280, EnergyMax = 360, 	PvP = false},
	[3] = { Name = "法力藥水", 			Level = 14, 
		EnergyMin = 445, EnergyMax = 585, 	PvP = false},
	[4] = { Name = "強效法力藥水", 	Level = 31, 
		EnergyMin = 700, EnergyMax = 900, 	PvP = false},
	[5] = { Name = "超強法力藥膏",Level = 35, 
		EnergyMin = 700, EnergyMax = 900, 	PvP = true},
	[6] = { Name = "超強法力藥水",	Level = 41,
		EnergyMin = 900, EnergyMax = 1500, 	PvP = false},
	[7] = { Name = "極效法力藥水",	Level = 49,
		EnergyMin = 1350, EnergyMax = 2250,	PvP = false},
	[8] = { Name = "作戰法力藥水",	Level = 41,
		EnergyMin = 900, EnergyMax = 1500, 	PvP = false},
	[9] = { Name = "極效法力藥膏",	Level = 45,
		EnergyMin = 980, EnergyMax = 1260, 	PvP = true},
}
SERENITY_HEALING_POTION = {
	[1] = { Name = "初級治療藥水", 	Level = 1, 
		EnergyMin = 70, EnergyMax = 90, PvP = false},
	[2] = { Name = "初級治療石", 	Level = 1, 
		EnergyMin = 100, EnergyMax = 120, PvP = false},
	[3] = { Name = "次級治療藥水", Level = 3, 
		EnergyMin = 140, EnergyMax = 180, PvP = false},
	[4] = { Name = "透明治療藥水",Level = 5, 
		EnergyMin = 140, EnergyMax = 180, PvP = false},
	[5] = { Name = "治療藥水", 	Level = 12, 
		EnergyMin = 280, EnergyMax = 360, PvP = false},
	[6] = { Name = "次級治療石", 	Level = 12, 
		EnergyMin = 250, EnergyMax = 300, PvP = false},
	[7] = { Name = "強效治療藥水",Level = 21, 
		EnergyMin = 455, EnergyMax = 585, PvP = false},
	[8] = { Name = "治療石", 		Level = 24, 
		EnergyMin = 500, EnergyMax = 600, PvP = false},
	[9] = { Name = "超強治療藥水",Level = 35, 
		EnergyMin = 700, EnergyMax = 900, PvP = false},
	[10] = { Name = "作戰治療藥水", Level = 35, 
		EnergyMin = 700, EnergyMax = 900, PvP = false},
	[11] = { Name = "超強治療藥膏",Level = 35, 
		EnergyMin = 560, EnergyMax = 720, PvP = true},
	[12] = { Name = "強效治療石", 	Level = 36, 
		EnergyMin = 800, EnergyMax = 960, PvP = false},
	[13] = { Name = "鞭根塊莖", Level = 45, 
		EnergyMin = 700, EnergyMax = 900, PvP = false},
	[14] = { Name = "極效治療藥水", Level = 45, 
		EnergyMin = 1050, EnergyMax = 1750, PvP = false},
	[15] = { Name = "極效治療藥膏", Level = 45, 
		EnergyMin = 980, EnergyMax = 1260, PvP = true},
	[16] = { Name = "極效治療石", Level = 48, 
		EnergyMin = 1200, EnergyMax = 1440, PvP = false},
}

SERENITY_MOUNT_TABLE = {
	-- [1] Frostwolf Howler Icon
	{ "霜狼嗥叫者的號角" }, 
	-- [2] Ram Icon
	{ "雷矛軍用坐騎", "黑山羊", "黑色戰羊", "棕山羊", "白山羊", "灰山羊", "迅捷棕山羊", "迅捷灰山羊", "迅捷白山羊", },
	-- [3] Raptor Icon            
	{ "拉扎什迅猛龍", "迅捷藍色迅猛龍", "迅捷綠色迅猛龍", "迅捷橙色迅猛龍", "黑色戰鬥迅猛龍之哨", "綠色迅猛龍之哨", "象牙迅猛龍之哨", "紅色迅猛龍之哨", "青色迅猛龍之哨", "紫色迅猛龍之哨" },
	-- [4] Yellow Tiger Icon
	{ "迅捷祖利安猛虎" },
	-- [5] Undead Horse Icon
	{ "藍色骸骨軍馬", "藍色骷髏戰馬", "死亡軍馬的韁繩", "棕色骸骨軍馬", "綠色骸骨軍馬", "紫色骷髏戰馬", "紅色骸骨軍馬", "紅色骷髏戰馬" },
	-- [6] Mechanostrider Icon
	{ "黑色作戰機械陸行鳥", "藍色機械陸行鳥", "綠色機械陸行鳥", "冰藍色機械陸行鳥A型", "紅色機械陸行鳥", "迅捷綠色機械陸行鳥", "迅捷白色機械陸行鳥", "迅捷黃色機械陸行鳥", "未塗色的機械陸行鳥", "白色機械陸行鳥A型" },
	-- [7] Brown Horse Icon
	{ "黑馬韁繩", "棕馬韁繩", "栗色馬韁繩", "褐色馬韁繩", "雜色馬韁繩", "迅捷棕馬", "迅捷褐色馬", "迅捷白馬", "白馬韁繩" },
	-- [8] Brown Kodo Icon
	{ "黑色作戰科多獸", "棕色科多獸", "大型棕色科多獸" },
	-- [9] War Steed Icon
	{ "黑色戰駒韁繩" },
	-- [10] Gray Kodo Icon
	{ "灰色科多獸", "大型灰色科多獸", "大型白色科多獸" },
	-- [11] Green Kodo Icon 
	{ "綠色科多獸", "藍色科多獸" },
	-- [12] White Wolf Icon    
	{ "北極狼號角", "恐狼號角", "迅捷灰狼號角", "迅捷森林狼號角" },
	-- [13] Black Wolf Icon    
	{ "黑色戰狼號角", "棕狼號角", "赤狼號角", "迅捷棕狼號角", "森林狼號角" },
	-- [14] Black Tiger Icon   
	{ "黑色戰豹韁繩", "條紋夜刃豹韁繩" },
	-- [15] White Tiger Icon   
	{ "霜刃豹韁繩", "夜刃豹韁繩", "斑點霜刃豹韁繩", "條紋霜刃豹韁繩", "迅捷霜刃豹韁繩", "迅捷霧刃豹韁繩", "迅捷雷刃豹韁繩" },
	-- [16] Red Tiger Icon
	{ "冬泉霜刃豹韁繩" },
	-- [17] Black Qiraji Resonating Crystal
	{ "黑色其拉共鳴水晶" },
}
SERENITY_MOUNT_PREFIX = {
	"號角",
	"之哨",
	"韁繩",	
}
SERENITY_AQMOUNT_TABLE = {
	"藍色其拉共鳴水晶",
 	"綠色其拉共鳴水晶",
 	"紅色其拉共鳴水晶",
	"黃色其拉共鳴水晶",
}
SERENITY_AQMOUNT_NAME = {
	"召喚黑色其拉作戰坦克",
	"召喚藍色其拉作戰坦克",
 	"召喚綠色其拉作戰坦克",
 	"召喚紅色其拉作戰坦克",
	"召喚黃色其拉作戰坦克",
}

SERENITY_TRANSLATION = {
	["Cooldown"] = "冷卻時間",
	["Hearth"] = "爐石",
	["Rank"] = "等級",
	["Drink"] = "飲料",
	["Dwarf"] = "矮人",
	["NightElf"] = "夜精靈",
	["Human"] = "人類",
	["Gnome"] = "地精",
	["Orc"] = "獸人",
	["Troll"] = "食人妖",
	["Forsaken"] = "不死族",
	["Tauren"] = "牛頭人",
};
end