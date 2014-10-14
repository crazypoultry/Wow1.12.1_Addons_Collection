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
-- Traditional Chinese  VERSION FUNCTIONS --- Nightly@布蘭卡德
------------------------------------------------
--
if ( GetLocale() == "zhTW" ) then

CRYOLYSIS_UNIT_MAGE = "法師";

-- Word to search for Fire Vulnerability and Winter's chill  first (.+) is the target, second is the spell
CRYOLYSIS_DEBUFF_SRCH = "(.+)受到了(.+)。"
CRYOLYSIS_POLY_SRCH = "(.+)效果從(.+)身上消失。"

function Cryolysis_SpellTableBuild()
CRYOLYSIS_SPELL_TABLE = {
	[1] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "魔法增效",				Length = 600,	Type = 0},
	[2] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "祕法光輝",				Length = 3600,	Type = 0},
	[3] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "魔爆術",				Length = 0,		Type = 0},
	[4] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "祕法智慧",				Length = 1800,	Type = 0},
	[5] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "祕法飛彈",				Length = 0,		Type = 0},
	[6] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "衝擊波",				Length = 45,	Type = 3},
	[7] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "閃現術",				Length = 15,	Type = 3},
	[8] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "暴風雪",				Length = 0,		Type = 0},
	[9] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "冰錐術",				Length = 10,	Type = 3},
	[10] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "造食術",				Length = 0,		Type = 0},
	[11] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "造水術",				Length = 0,		Type = 0},
	[12] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "法術反制",				Length = 30,	Type = 3},
	[13] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "魔法抑制",				Length = 600,	Type = 0},
	[14] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "火焰衝擊",				Length = 8,		Type = 3},
	[15] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "防護火焰結界",			Length = 30,	Type = 3},
	[16] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "火球術",				Length = 8,		Type = 5},
	[17] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "烈焰風暴",				Length = 8,		Type = 3},
	[18] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "霜甲術",				Length = 300,	Type = 0},
	[19] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "冰霜新星",				Length = 25,	Type = 3},
	[20] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "防護冰霜結界",			Length = 30,	Type = 3},
	[21] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "寒冰箭",				Length = 9,		Type = 5},
	[22] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "冰甲術",				Length = 300,	Type = 0},
	[23] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "寒冰護體",				Length = 30,	Type = 3},
	[24] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "魔甲術",				Length = 300,	Type = 0},
	[25] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "法力護盾",				Length = 60,	Type = 0},
	[26] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "變形術",				Length = 50,	Type = 2},
	[27] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "傳送門：達納蘇斯",		Length = 0,		Type = 0},
	[28] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "傳送門：鐵爐堡",		Length = 0,		Type = 0},
	[29] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "傳送門：暴風城",		Length = 0,		Type = 0},
	[30] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "傳送門：雷霆崖",		Length = 0,		Type = 0},
	[31] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "傳送門：幽暗城",		Length = 0,		Type = 0},
	[32] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "炎爆術",				Length = 12,	Type = 5},
	[33] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "解除次級詛咒",			Length = 0,		Type = 0},
	[34] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "灼燒",				Length = 0,			Type = 0},
	[35] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "緩落術",				Length = 30,	Type = 0},
	[36] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "傳送：達納蘇斯",		Length = 0,		Type = 0},
	[37] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "傳送：鐵爐堡",			Length = 0,		Type = 0},
	[38] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "傳送：奧格瑪",			Length = 0,		Type = 0},
	[39] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "傳送：雷霆崖",				Length = 0,	Type = 0},
	[40] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "傳送：幽暗城",			Length = 0,		Type = 0},
	[41] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "寒冰屏障",			Length = 300,		Type = 3},
	[42] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "急速冷卻",			Length = 600,		Type = 3},
	[43] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "燃燒",					Length = 180,	Type = 3},
	[44] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "氣定神閒",				Length = 180,	Type = 3},
	[45] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "祕法強化",				Length = 180,	Type = 3},
	[46] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "傳送：達納蘇斯",			Length = 0,	Type = 0},
	[47] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "傳送門：奧格瑪",		Length = 0,		Type = 0},
	[48] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "變豬術",				Length = 50,	Type = 2},
	[49] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "喚醒",				Length = 480,		Type = 3},
	[50] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "偵測魔法",				Length = 120,	Type = 5},
	[51] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "傳送：暴風城",				Length = 0,	Type = 0},
	[52] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "變龜術",				Length = 50,	Type = 2},
	[53] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "霜寒刺骨",				Length = 5,		Type = 6},
	[54] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "深冬之寒效果的影響",	Length = 15,	Type = 6},
	[55] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "深冬之寒效果的影響(2)",	Length = 15,	Type = 6},
	[56] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "深冬之寒效果的影響(3)",	Length = 15,	Type = 6},
	[57] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "深冬之寒效果的影響(4)",	Length = 15,	Type = 6},
	[58] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "深冬之寒效果的影響(5)",	Length = 15,	Type = 6},
	[59] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "火焰易傷效果的影響",	Length = 30,	Type = 6},
    [60] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "火焰易傷效果的影響(2)",	Length = 30,	Type = 6},
	[61] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "火焰易傷效果的影響(3)",	Length = 30,	Type = 6},
	[62] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "火焰易傷效果的影響(4)",	Length = 30,	Type = 6},
	[63] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "火焰易傷效果的影響(5)",	Length = 30,	Type = 6},
	[64] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "魔法寶石",				Length = 120,	Type = 3},
	[65] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "冰凍",					Length = 5,		Type = 6},
	[66] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "冰霜新星",				Length = 8,		Type = 6},	
	[67] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Poly Diminished",		Length = 15,	Type = 6},  --變形時間？？
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
	["LightFeather"] = "輕羽毛",
	["ArcanePowder"] = "魔粉",
	["RuneOfTeleportation"] = "傳送符文",
	["RuneOfPortals"] = "傳送門符文",
	["Manastone"] = "法力",
	["Hearthstone"] = "爐石",
	["Provision"] = "製造",
	["Evocation"] = "喚醒",
	["Drink"] = "造水術",
	["Food"] = "造食術",
};
CRYOLYSIS_FOOD_RANK = {
	[1] = " 魔法鬆餅",
	[2] = " 魔法麵包",
	[3] = " 魔法黑麵包",
	[4] = " 魔法粗麵包",
	[5] = " 魔法發酵麵包",
	[6] = " 魔法甜麵包", 
	[7] = " 魔法肉桂麵包",
};
CRYOLYSIS_DRINK_RANK = {
	[1] = " 魔法水",
	[2] = " 魔法淡水",
	[3] = " 魔法純淨水",
	[4] = " 魔法泉水",
	[5] = " 魔法礦泉水",
	[6] = " 魔法蘇打水",
	[7] = " 魔法晶水",
};
CRYOLYSIS_STONE_RANK = {
	[1] = "瑪瑙",		-- Rank Minor
	[2] = "翡翠",		-- Rank Lesser
	[3] = "黃水晶",	-- Rank Greater
	[4] = "紅寶石"		-- Rank Major
};
CRYOLYSIS_STONE_RANK2 = {
	[1] = "法力瑪瑙",		-- Rank Minor
	[2] = "法力翡翠",		-- Rank Lesser
	[3] = "法力黃水晶",	-- Rank Greater
	[4] = "法力紅寶石"		-- Rank Major
};

CRYOLYSIS_MANASTONE_NAMES = {
	[1] = "製造法力瑪瑙",
	[2] = "製造魔法翡翠",
	[3] = "製造魔法黃水晶",
	[4] = "製造魔法紅寶石"
};
	

CRYOLYSIS_CREATE = {
	[1] = "喚醒",
	[2] = "製造魔法寶石",
	[3] = "造水術",
	[4] = "造食術"
};

CRYOLYSIS_MOUNT_TABLE = {
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
CRYOLYSIS_MOUNT_PREFIX = {
	"號角",
	"之哨",
	"韁繩",	
}
CRYOLYSIS_AQMOUNT_TABLE = {
	"藍色其拉共鳴水晶",
 	"綠色其拉共鳴水晶",
 	"紅色其拉共鳴水晶",
	"黃色其拉共鳴水晶",
}
CRYOLYSIS_AQMOUNT_NAME = {
	"召喚黑色其拉作戰坦克",
	"召喚藍色其拉作戰坦克",
 	"召喚綠色其拉作戰坦克",
 	"召喚紅色其拉作戰坦克",
	"召喚黃色其拉作戰坦克",
}

CRYOLYSIS_TRANSLATION = {
	["Cooldown"] = "冷卻時間",
	["Hearth"] = "爐石",
	["Rank"] = "等級",
};
end