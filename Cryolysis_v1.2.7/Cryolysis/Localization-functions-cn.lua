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
-- SIMPLIFIED CHINESE VERSION FUNCTIONS --
------------------------------------------------

if GetLocale() == "zhCN" then

CRYOLYSIS_UNIT_MAGE = "法师";

-- Word to search for Fire Vulnerability and Winter's chill  first (.+) is the target, second is the spell
CRYOLYSIS_DEBUFF_SRCH = "(.+)受到了(.+)效果的影响。"
CRYOLYSIS_POLY_SRCH = "(.+)效果从(.+)身上消失。"

function Cryolysis_SpellTableBuild()
CRYOLYSIS_SPELL_TABLE = {
	[1] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "魔法增效",				Length = 600,	Type = 0},
	[2] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "奥术光辉",				Length = 3600,	Type = 0},
	[3] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "魔爆术",				Length = 0,		Type = 0},
	[4] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "奥术智慧",				Length = 1800,	Type = 0},
	[5] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "奥术飞弹",				Length = 0,		Type = 0},
	[6] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "冲击波",				Length = 45,	Type = 3},
	[7] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "闪现术",				Length = 15,	Type = 3},
	[8] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "暴风雪",				Length = 0,		Type = 0},
	[9] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "冰锥术",				Length = 10,	Type = 3},
	[10] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "造食术",				Length = 0,		Type = 0},
	[11] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "造水术",				Length = 0,		Type = 0},
	[12] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "魔法反制",				Length = 30,	Type = 3},
	[13] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "魔法抑制",				Length = 600,	Type = 0},
	[14] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "火焰冲击",				Length = 8,		Type = 3},
	[15] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "防护火焰结界",			Length = 30,	Type = 3},
	[16] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "火球术",				Length = 8,		Type = 5},
	[17] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "烈焰风暴",				Length = 8,		Type = 3},
	[18] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "霜甲术",				Length = 300,	Type = 0},
	[19] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "冰霜新星",				Length = 25,	Type = 3},
	[20] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "防护冰霜结界",			Length = 30,	Type = 3},
	[21] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "寒冰箭",				Length = 9,		Type = 5},
	[22] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "冰甲术",				Length = 300,	Type = 0},
	[23] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "寒冰护体",				Length = 30,	Type = 3},
	[24] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "魔甲术",				Length = 300,	Type = 0},
	[25] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "法力护盾",				Length = 60,	Type = 0},
	[26] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "变形术",				Length = 50,	Type = 2},
	[27] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "传送门：达纳苏斯",		Length = 0,		Type = 0},
	[28] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "传送门：铁炉堡",		Length = 0,		Type = 0},
	[29] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "传送门：暴风城",		Length = 0,		Type = 0},
	[30] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "传送门：雷霆崖",		Length = 0,		Type = 0},
	[31] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "传送门：幽暗城",		Length = 0,		Type = 0},
	[32] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "炎爆术",				Length = 12,	Type = 5},
	[33] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "解除次级诅咒",			Length = 0,		Type = 0},
	[34] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "灼烧",				Length = 0,			Type = 0},
	[35] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "缓落术",				Length = 30,	Type = 0},
	[36] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "传送：达纳苏斯",		Length = 0,		Type = 0},
	[37] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "传送：铁炉堡",			Length = 0,		Type = 0},
	[38] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "传送：奥格瑞玛",		Length = 0,		Type = 0},
	[39] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "传送：雷霆崖",				Length = 0,	Type = 0},
	[40] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "传送：幽暗城",			Length = 0,		Type = 0},
	[41] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "寒冰屏障",			Length = 300,		Type = 3},
	[42] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "急速冷却",			Length = 600,		Type = 3},
	[43] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "燃烧",					Length = 180,	Type = 3},
	[44] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "气定神闲",				Length = 180,	Type = 3},
	[45] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "奥术强化",				Length = 180,	Type = 3},
	[46] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "传送：达纳苏斯",			Length = 0,	Type = 0},
	[47] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "传送门：奥格瑞玛",		Length = 0,		Type = 0},
	[48] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "变形术：猪",			Length = 50,	Type = 2},
	[49] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "唤醒",				Length = 480,		Type = 3},
	[50] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "侦测魔法",				Length = 120,	Type = 5},
	[51] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "传送：暴风城",				Length = 0,	Type = 0},
	[52] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "变形术：龟",			Length = 50,	Type = 2},
	[53] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "刺骨寒冰",				Length = 5,		Type = 6},
	[54] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "深冬之寒",				Length = 15,	Type = 6},
	[55] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "深冬之寒 (2)",			Length = 15,	Type = 6},
	[56] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "深冬之寒 (3)",			Length = 15,	Type = 6},
	[57] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "深冬之寒 (4)",			Length = 15,	Type = 6},
	[58] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "深冬之寒 (5)",			Length = 15,	Type = 6},
	[59] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "火焰易伤",				Length = 30,	Type = 6},
	[60] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "火焰易伤 (2)",			Length = 30,	Type = 6},
	[61] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "火焰易伤 (3)",			Length = 30,	Type = 6},
	[62] = {ID = nil, Rank = nil, 		CastTime = nil, Mana = nil,
		Name = "火焰易伤 (4)",			Length = 30,	Type = 6},
	[63] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "火焰易伤 (5)",			Length = 30,	Type = 6},
	[64] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "魔法水晶",				Length = 120,	Type = 3},
	[65] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "冰冻",					Length = 5,		Type = 6},
	[66] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "冰霜新星",				Length = 8,		Type = 6},	
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
	["LightFeather"] = "轻羽毛",
	["ArcanePowder"] = "魔粉",
	["RuneOfTeleportation"] = "传送符文",
	["RuneOfPortals"] = "传送门符文",
	["Manastone"] = "法力",
	["Hearthstone"] = "炉石",
	["Provision"] = "制造",
	["Evocation"] = "唤醒",
	["Drink"] = "魔法水",
	["Food"] = "魔法食物",
};
CRYOLYSIS_FOOD_RANK = {
	[1] = " 魔法松饼",
	[2] = " 魔法面包",
	[3] = " 魔法黑面包",
	[4] = " 魔法粗面包",
	[5] = " 魔法酵母",
	[6] = " 魔法甜面包", 
	[7] = " 魔法肉桂面包",
};
CRYOLYSIS_DRINK_RANK = {
	[1] = " 魔法水",
	[2] = " 魔法淡水",
	[3] = " 魔法纯净水",
	[4] = " 魔法泉水",
	[5] = " 魔法矿泉水",
	[6] = " 魔法苏打水",
	[7] = " 魔法晶水",
};
CRYOLYSIS_STONE_RANK = {
	[1] = "玛瑙",		-- Rank Minor
	[2] = "翡翠",		-- Rank Lesser
	[3] = "黄水晶",		-- Rank Greater
	[4] = "红宝石",		-- Rank Major
};
CRYOLYSIS_STONE_RANK2 = {
	[1] = "法力玛瑙",		-- Rank Minor
	[2] = "法力翡翠",		-- Rank Lesser
	[3] = "法力黄水晶",		-- Rank Greater
	[4] = "法力红宝石",		-- Rank Major
};

CRYOLYSIS_MANASTONE_NAMES = {
	[1] = "制造魔法玛瑙",
	[2] = "制造魔法翡翠",
	[3] = "制造魔法黄水晶",
	[4] = "制造魔法红宝石",
};	


CRYOLYSIS_CREATE = {
	[1] = "唤醒",
	[2] = "制造魔法宝石",
	[3] = "造水术",
	[4] = "造食术",
};

CRYOLYSIS_MOUNT_TABLE = {
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
CRYOLYSIS_MOUNT_PREFIX = {
	"号角",
	"之哨",
	"缰绳",	
}
CRYOLYSIS_AQMOUNT_TABLE = {
	"蓝色其拉共鸣水晶",
 	"绿色其拉共鸣水晶",
 	"红色其拉共鸣水晶",
	"黄色其拉共鸣水晶",
}
CRYOLYSIS_AQMOUNT_NAME = {
	"召唤黑色其拉作战坦克",
	"召唤蓝色其拉作战坦克",
 	"召唤绿色其拉作战坦克",
 	"召唤红色其拉作战坦克",
	"召唤黄色其拉作战坦克",
}

CRYOLYSIS_TRANSLATION = {
	["Cooldown"] = "冷却时间",
	["Hearth"] = "炉石",
	["Rank"] = "等级",
};

end