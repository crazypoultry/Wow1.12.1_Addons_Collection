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
-- SIMPLIFIED CHINESE VERSION FUNCTIONS --
------------------------------------------------

if GetLocale() == "zhCN" then

SERENITY_UNIT_PRIEST = "牧师";

-- Word to search for Fire Vulnerability and Winter's shadow  first (.+) is the target, second is the spell
SERENITY_DEBUFF_SRCH = "(.+)受到(.+)"
SERENITY_FADE_SRCH = "(.+)效果从(.+)身上消失。"
SERENITY_GAIN_SRCH = "(.+)获得了(.+)的效果。"
SERENITY_CORPSE_SRCH = "(.+)的尸体"

function Serenity_SpellTableBuild()
	SERENITY_SPELL_TABLE = {
	[1] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "驱除病术",						Length = 10,	Type = 7},
	[2] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "祝福复元",						Length = 6,		Type = 0},
	[3] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "祛病术",						Length = 0,		Type = 0},
	[4] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "绝望祷言",						Length = 600,	Type = 3},
	[5] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "噬灵瘟疫",						Length = 24,	Type = 5},
	[6] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "噬灵瘟疫",						Length = 180,	Type = 3},
	[7] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "驱散魔法",						Length = 0,		Type = 0},
	[8] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "神圣之灵",						Length = 1800,	Type = 0},
	[9] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "伊露恩的赐福",					Length = 300,	Type = 3},
	[10] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "渐隐术",						Length = 30,	Type = 3},
	[11] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "防护恐惧结界",					Length = 30,	Type = 3},
	[12] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "回馈",							Length = 180,	Type = 3},
	[13] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "快速治疗",						Length = 0,		Type = 0},
	[14] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "强效治疗术",					Length = 15,	Type = 7},
	[15] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "治疗术",						Length = 0,		Type = 0},
	[16] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "虚弱妖术",						Length = 120,	Type = 5},
	[17] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "神圣之火",						Length = 10,	Type = 5},
	[18] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "神圣新星",						Length = 0,		Type = 0},
	[19] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "心灵专注",						Length = 180,	Type = 3},
	[20] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "心灵之火",						Length = 0,		Type = 0},
	[21] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "灵感",							Length = 15,	Type = 5},
	[22] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "次级治疗术",					Length = 0,		Type = 0},
	[23] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "漂浮术",						Length = 120,	Type = 0},
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
		Name = "法力燃烧",						Length = 0,		Type = 0},
	[31] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "殉难",							Length = 6,		Type = 0},
	[32] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "心灵震爆",						Length = 8,		Type = 3},
	[33] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "精神控制",						Length = 60,	Type = 0},
	[34] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "精神鞭笞",						Length = 3,		Type = 0},
	[35] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "安抚心灵",						Length = 15,	Type = 5},
	[36] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "心灵视界",						Length = 60,	Type = 0},
	[37] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "能量灌注",						Length = 180,	Type = 3},
	[38] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "真言术：韧",					Length = 1800,	Type = 0},
	[39] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "真言术：盾",					Length = 30,	Type = 5},
	[40] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "真言术：盾冷却",				Length = 4,		Type = 3},
	[41] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "坚韧祷言",						Length = 3600,	Type = 0},
	[42] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "治疗祷言",						Length = 0,		Type = 0},
	[43] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "暗影防护祷言",					Length = 1200,	Type = 0},
	[44] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "精神祷言",						Length = 3600,	Type = 0},
	[45] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "心灵尖啸",						Length = 30,	Type = 3},
 	[46] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "心灵尖啸效果的影响",			Length = 8,		Type = 5},
	[47] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "恢复",							Length = 15,	Type = 7},
	[48] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "复活术",						Length = 0,		Type = 0},
	[49] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "束缚亡灵",						Length = 50,	Type = 2},
	[50] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "暗影之波",						Length = 0,		Type = 0},
	[51] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "防护暗影",						Length = 600,	Type = 0},
	[52] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "暗言术：痛",					Length = 18,	Type = 5},
	[53] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "暗影形态",						Length = 0,		Type = 0},
	[54] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "暗影守卫",						Length = 600,	Type = 0},
	[55] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "沉默",							Length = 45,	Type = 3},
	[56] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "惩击",							Length = 0,		Type = 0},
	[57] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "救赎之魂",						Length = 10,	Type = 0},
	[58] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "星辰碎片",						Length = 0,		Type = 0},
	[59] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "虚弱之触",						Length = 120,	Type = 6},
	[60] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "吸血鬼的拥抱",					Length = 60,	Type = 5},
	[61] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "虚弱灵魂",						Length = 15,	Type = 7},
	[62] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "暗影易伤",						Length = 15,	Type = 6},
	[63] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "暗影易伤(2)",					Length = 15,	Type = 6},
	[64] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "暗影易伤(3)",					Length = 15,	Type = 6},
	[65] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "暗影易伤(4)",					Length = 15,	Type = 6},
	[66] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "暗影易伤(5)",					Length = 15,	Type = 6},
	[67] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "昏厥",							Length = 3,		Type = 5},
	[68] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "恢复光束泉",					Length = 10,	Type = 7},
	[69] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "吸血鬼的拥抱 ",					Length = 10,	Type = 3},
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
	["LightFeather"] = "轻羽毛",
	["HolyCandle"] = "圣洁蜡烛",
	["SacredCandle"] = "神圣蜡烛",
	["Potion"] = "药水",
	["Draught"] = "药膏",
	["ManaPotion"] = "法力药水",
	["HealingPotion"] = "治疗药水",
	["Healthstone"] = "治疗石",
	["Hearthstone"] = "炉石",
};
SERENITY_DRINK_SRCH = { "水", "豆酒", "牛奶", "果汁", "饮料", "茶", "酒", "柠檬汁", };
SERENITY_DRINK = {
	[1] = { Name = "清凉的泉水", 		Energy = 151, Level = 1,
		Length = 18, Conjured = false, PvP = false },
	[2] = { Name = "魔法水", 				Energy = 151, Level = 1,
		Length = 18, Conjured = true, PvP = false },
	[3] = { Name = "混制豆酒", 			Energy = 436, Level = 5,
		Length = 21, Conjured = false, PvP = false },	
	[4] = { Name = "冰镇牛奶", 				Energy = 436, Level = 5,
		Length = 21, Conjured = false, PvP = false },	
	[5] = { Name = "魔法淡水", 		Energy = 436, Level = 5,
		Length = 21, Conjured = true, PvP = false },	
	[6] = { Name = "果汁", 					Energy = 835, Level = 15,
		Length = 24, Conjured = false, PvP = false },	
	[7] = { Name = "泡沫饮料", 			Energy = 835, Level = 15,
		Length = 24, Conjured = false, PvP = false },
	[8] = { Name = "泡沫水", 				Energy = 835, Level = 15,
		Length = 24, Conjured = false, PvP = false },
	[9] = { Name = "魔法纯净水", 		Energy = 835, Level = 15,
		Length = 24, Conjured = true, PvP = false },	
	[10] = { Name = "蜂蜜饮料", 				Energy = 1344, Level = 25,
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
	[17] = { Name = "魔法矿泉水", 		Energy = 1992, Level = 35,
		Length = 30, Conjured = true, PvP = false },	
	[18] = { Name = "晨露酒", 			Energy = 2934, Level = 45,
		Length = 30, Conjured = false, PvP = false },	
	[19] = { Name = "现榨的柠檬汁", 	Energy = 2934, Level = 45,
		Length = 30, Conjured = false, PvP = false },	
	[20] = { Name = "神圣太阳果汁", 		Energy = 4410, Level = 45,
		Length = 30, Conjured = false, PvP = false },	
	[21] = { Name = "魔法苏打水", 	Energy = 2934, Level = 45,
		Length = 30, Conjured = true, PvP = false },	
	[22] = { Name = "奥特兰克瓶装泉水", Energy = 4410, Level = 55,
		Length = 30, Conjured = false, PvP = false },	
	[23] = { Name = "可口的魔法点心", Energy = 4410, Level = 45,
		Length = 30, Conjured = false, PvP = false },
	[24] = { Name = "魔法晶水",		Energy = 4200, Level = 55,
		Length = 30, Conjured = true, PvP = false },	
};
SERENITY_MANA_POTION = {
	[1] = { Name = "初级法力药水", 	Level = 5, 
		EnergyMin = 140, EnergyMax = 180, 	PvP = false},
	[2] = { Name = "次级法力药水", 	Level = 14, 
		EnergyMin = 280, EnergyMax = 360, 	PvP = false},
	[3] = { Name = "法力药水", 			Level = 14, 
		EnergyMin = 445, EnergyMax = 585, 	PvP = false},
	[4] = { Name = "强效法力药水", 	Level = 31, 
		EnergyMin = 700, EnergyMax = 900, 	PvP = false},
	[5] = { Name = "超强法力药膏",Level = 35, 
		EnergyMin = 700, EnergyMax = 900, 	PvP = true},
	[6] = { Name = "超强法力药水",	Level = 41,
		EnergyMin = 900, EnergyMax = 1500, 	PvP = false},
	[7] = { Name = "特效法力药水",	Level = 49,
		EnergyMin = 1350, EnergyMax = 2250,	PvP = false},
	[8] = { Name = "作战法力药水",	Level = 41,
		EnergyMin = 900, EnergyMax = 1500, 	PvP = false},
	[9] = { Name = "特效法力药膏",	Level = 45,
		EnergyMin = 980, EnergyMax = 1260, 	PvP = true},
}
SERENITY_HEALING_POTION = {
	[1] = { Name = "初级治疗药水", 	Level = 1, 
		EnergyMin = 70, EnergyMax = 90, PvP = false},
	[2] = { Name = "初级治疗石", 	Level = 1, 
		EnergyMin = 100, EnergyMax = 120, PvP = false},
	[3] = { Name = "次级治疗药水", Level = 3, 
		EnergyMin = 140, EnergyMax = 180, PvP = false},
	[4] = { Name = "透明治疗药水",Level = 5, 
		EnergyMin = 140, EnergyMax = 180, PvP = false},
	[5] = { Name = "治疗药水", 	Level = 12, 
		EnergyMin = 280, EnergyMax = 360, PvP = false},
	[6] = { Name = "次级治疗石", 	Level = 12, 
		EnergyMin = 250, EnergyMax = 300, PvP = false},
	[7] = { Name = "强效治疗药水",Level = 21, 
		EnergyMin = 455, EnergyMax = 585, PvP = false},
	[8] = { Name = "治疗石", 		Level = 24, 
		EnergyMin = 500, EnergyMax = 600, PvP = false},
	[9] = { Name = "超强治疗药水",Level = 35, 
		EnergyMin = 700, EnergyMax = 900, PvP = false},
	[10] = { Name = "作战治疗药水", Level = 35, 
		EnergyMin = 700, EnergyMax = 900, PvP = false},
	[11] = { Name = "超强治疗药膏",Level = 35, 
		EnergyMin = 560, EnergyMax = 720, PvP = true},
	[12] = { Name = "强效治疗石", 	Level = 36, 
		EnergyMin = 800, EnergyMax = 960, PvP = false},
	[13] = { Name = "鞭根块茎", Level = 45, 
		EnergyMin = 700, EnergyMax = 900, PvP = false},
	[14] = { Name = "特效治疗药水", Level = 45, 
		EnergyMin = 1050, EnergyMax = 1750, PvP = false},
	[15] = { Name = "特效治疗药膏", Level = 45, 
		EnergyMin = 980, EnergyMax = 1260, PvP = true},
	[16] = { Name = "特效治疗石", Level = 48, 
		EnergyMin = 1200, EnergyMax = 1440, PvP = false},
}

SERENITY_MOUNT_TABLE = {
	-- [1] Frostwolf Howler Icon
	{ "霜狼嗥叫者的号角" }, 
	-- [2] Ram Icon
	{ "雷矛军用坐骑", "黑山羊", "黑色战羊", "棕山羊", "白山羊", "灰山羊", "迅捷棕山羊", "迅捷灰山羊", "迅捷白山羊", },
	-- [3] Raptor Icon            
	{ "拉扎什迅猛龙", "迅捷蓝色迅猛龙", "迅捷绿色迅猛龙", "迅捷橙色迅猛龙", "黑色战斗迅猛龙之哨", "绿色迅猛龙之哨", "象牙迅猛龙之哨", "红色迅猛龙之哨", "青色迅猛龙之哨", "紫色迅猛龙之哨" },
	-- [4] Yellow Tiger Icon
	{ "迅捷祖利安猛虎" },
	-- [5] Undead Horse Icon
	{ "蓝色骸骨军马", "蓝色骷髅战马", "死亡军马的缰绳", "棕色骸骨军马", "绿色骸骨军马", "紫色骷髅战马", "红色骸骨军马", "红色骷髅战马" },
	-- [6] Mechanostrider Icon
	{ "黑色作战机械陆行鸟", "蓝色机械陆行鸟", "绿色机械陆行鸟", "冰蓝色机械陆行鸟A型", "红色机械陆行鸟", "迅捷绿色机械陆行鸟", "迅捷白色机械陆行鸟", "迅捷黄色机械陆行鸟", "未涂色的机械陆行鸟", "白色机械陆行鸟A型" },
	-- [7] Brown Horse Icon
	{ "黑马缰绳", "棕马缰绳", "栗色马缰绳", "褐色马缰绳", "杂色马缰绳", "迅捷棕马", "迅捷褐色马", "迅捷白马", "白马缰绳" },
	-- [8] Brown Kodo Icon
	{ "黑色作战科多兽", "棕色科多兽", "大型棕色科多兽" },
	-- [9] War Steed Icon
	{ "黑色战驹缰绳" },
	-- [10] Gray Kodo Icon
	{ "灰色科多兽", "大型灰色科多兽", "大型白色科多兽" },
	-- [11] Green Kodo Icon 
	{ "绿色科多兽", "蓝色科多兽" },
	-- [12] White Wolf Icon    
	{ "北极狼号角", "恐狼号角", "迅捷灰狼号角", "迅捷森林狼号角" },
	-- [13] Black Wolf Icon    
	{ "黑色战狼号角", "棕狼号角", "赤狼号角", "迅捷棕狼号角", "森林狼号角" },
	-- [14] Black Tiger Icon   
	{ "黑色战豹缰绳", "条纹夜刃豹缰绳" },
	-- [15] White Tiger Icon   
	{ "霜刃豹缰绳", "夜刃豹缰绳", "斑点霜刃豹缰绳", "条纹霜刃豹缰绳", "迅捷霜刃豹缰绳", "迅捷雾刃豹缰绳", "迅捷雷刃豹缰绳" },
	-- [16] Red Tiger Icon
	{ "冬泉霜刃豹缰绳" },
	-- [17] Black Qiraji Resonating Crystal
	{ "黑色其拉共鸣水晶" },
}
SERENITY_MOUNT_PREFIX = {
	"号角",
	"之哨",
	"缰绳",	
}
SERENITY_AQMOUNT_TABLE = {
	"蓝色其拉共鸣水晶",
 	"绿色其拉共鸣水晶",
 	"红色其拉共鸣水晶",
	"黄色其拉共鸣水晶",
}
SERENITY_AQMOUNT_NAME = {
	"召唤黑色其拉作战坦克",
	"召唤蓝色其拉作战坦克",
 	"召唤绿色其拉作战坦克",
 	"召唤红色其拉作战坦克",
	"召唤黄色其拉作战坦克",
}

SERENITY_TRANSLATION = {
	["Cooldown"] = "冷却时间",
	["Hearth"] = "炉石",
	["Rank"] = "等级",
	["Drink"] = "饮料",
	["Dwarf"] = "矮人",
	["NightElf"] = "暗夜精灵",
	["Human"] = "人类",
	["Gnome"] = "侏儒",
	["Orc"] = "兽人",
	["Troll"] = "巨魔",
	["Forsaken"] = "亡灵",
	["Tauren"] = "牛头人",
};
end