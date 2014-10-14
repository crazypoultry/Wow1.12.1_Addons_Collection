-- Localization Chinese
-- Translation By LeiLo


if (GetLocale() == "zhCN") then 
MINIMAPBUTTON_TOOLTIP 											= "打开EnchantingSeller";

ENCHANTINGSELL_MSG_LAUNCH										= "EnchantingSeller";
ENCHANTINGSELL_MSG_RESETBD										= "数据库复位.";
ENCHANTINGSELL_MSG_LOADDEFAULTBD								= "读取缺省的数据库.";
ENCHANTINGSELL_MSG_RESETALLDATAAREYOUSURE						= "你确定要复位这个插件吗?";
ENCHANTINGSELL_MSG_LOADDEFAULTDATACOMPONANTAREYOUSURE			= "读取缺省的材料信息会使旧数据被删掉,你确定要执行吗?";
ENCHANTINGSELL_MSG_LOADDEFAULTDATAENCHANTEAREYOUSURE			= "读取缺省的附魔信息会使旧数据被删掉,你确定要执行吗?";


ENCHANTINGSELL_MSG_ERREUR_NOTLOADDEFAULTBD						= "没有发现缺省的数据库.不能读取"
ENCHANTINGSELL_MSG_ERREUR_NEWASKIMPOSSIBLE						= "查询已被请求,在启动拍卖行插件后响应";
ENCHANTINGSELL_MSG_ERREUR_PRICEMODIFCANCEL						= "其他拍卖行插件!修改价格的进度已被取消";

ENCHANTINGSELL_TITLE 											= "Enchanting Seller "..ENCHANTINGSELL_VERSION;
ENCHANTINGSELL_TAB_LIST_ENCHANTE								= "附魔";
ENCHANTINGSELL_TAB_LIST_COMPONENT								= "材料";
ENCHANTINGSELL_TAB_OPTION									= "选项";

ENCHANTINGSELL_CHANGEPRICEFRAME_PRICEWITHPOURCENTHEADER			= "价格调整利润%:";
ENCHANTINGSELL_CHANGEPRICEFRAME_PRICEWITHPOURCENTCHECKBOX		= "自动计算价格.";

ENCHANTINGSELL_PRICE_UNITEGOLD									= "金"; -- Piece of Gold
ENCHANTINGSELL_PRICE_UNITESILVER								= "银"; -- Piece of Silver
ENCHANTINGSELL_PRICE_UNITECOPPER								= "铜"; -- Piece of Copper

ENCHANTINGSELL_ENCHANTE_BUTTON_CREATEENCHANTE					= "附魔";
ENCHANTINGSELL_ENCHANTE_CHECK_SORTBYCRAFT						= "排序";

ENCHANTINGSELL_ENCHANTE_HEADER_NAME								= "附魔名称";
ENCHANTINGSELL_ENCHANTE_HEADER_ONTHIS							= "部位";
ENCHANTINGSELL_ENCHANTE_HEADER_BONUS							= "效果";
ENCHANTINGSELL_ENCHANTE_HEADER_MONEY							= "价格";

ENCHANTINGSELL_ENCHANTE_DETAIL_TOOLNEEDED_HEADER				= "需要:";
ENCHANTINGSELL_ENCHANTE_DETAIL_TOOLNEEDED_ADDNAMEFORINBANK		= " (在银行)";
ENCHANTINGSELL_ENCHANTE_DETAIL_TOOLNEEDED_ADDNOKNOW				= "(未学习这个附魔)";

ENCHANTINGSELL_ENCHANTE_TOOLTIP_HEADER							= "标题 附魔\n\r\n\r点击:排序\n\r再点击:反向排序";
ENCHANTINGSELL_ENCHANTE_TOOLTIP_LIST							= "附魔\n\r\n\rShift+点击:复制附魔信息到聊天框\n\r\n\r颜色:\n\r浅绿色->你有所有材料并且附魔棒在身上.\n\r深绿色->一些必要的材料在银行.\n\r棕色->一些必要的材料在其他人物身上.\n\r灰色->附魔师不会这个附魔.";
ENCHANTINGSELL_ENCHANTE_TOOLTIP_DETAIL_NAMEDESCRIPTION			= "附魔详细信息\n\r\n\rShift+点击:复制(名字和描述)到聊天框";
ENCHANTINGSELL_ENCHANTE_TOOLTIP_REAGENTS						= "需要材料\n\r\n\rShift+点击:复制这个材料,\n\r  (需要名字和数量)到聊天框\n\r双击:显示材料详细信息";
ENCHANTINGSELL_ENCHANTE_TOOLTIP_REAGENTSHEADER					= "标题 材料\n\r\n\rShift+点击:复制所有材料,\n\r (需要名字和数量)到聊天框";
ENCHANTINGSELL_ENCHANTE_TOOLTIP_SEPARATORFORPRICE				= " to "; -- " ?"
ENCHANTINGSELL_ENCHANTE_TOOLTIP_TOTALPRICE						= "附魔定价\n\r\n\r双击:改变附魔定价.\n\r\n\r颜色:\n\r白色->自动计算.\n\r棕色->自定价格."

ENCHANTINGSELL_ENCHANTE_REAGENTS_LISTHEADER_NAME				= "材料名称";
ENCHANTINGSELL_ENCHANTE_REAGENTS_LISTHEADER_NB					= "背包/需要";
ENCHANTINGSELL_ENCHANTE_REAGENTS_LISTHEADER_NBOTHER				= "银行-其他";
ENCHANTINGSELL_ENCHANTE_REAGENTS_LISTHEADER_PRICEUNITE			= "单价";
ENCHANTINGSELL_ENCHANTE_REAGENTS_LISTHEADER_PRICETOTAL			= "总价";

ENCHANTINGSELL_ENCHANTE_REAGENTS_LISTHEADER_PRICETOTALNOBENEF 	= "无利润总价";

ENCHANTINGSELL_COMPONANT_HEADER_NAME							= "材料名称";
ENCHANTINGSELL_COMPONANT_HEADER_NB							= "背包";
ENCHANTINGSELL_COMPONANT_HEADER_NBBANK							= "银行";
ENCHANTINGSELL_COMPONANT_HEADER_NBREROLL						= "其他";
ENCHANTINGSELL_COMPONANT_HEADER_PRICEUNITE						= "单价";
--ENCHANTINGSELL_COMPONANT_HEADER_PRICETOTAL						= "Prix T";

ENCHANTINGSELL_COMPONANT_DETAIL_HEADER_NAMEPLAYER				= "玩家名称";
ENCHANTINGSELL_COMPONANT_DETAIL_HEADER_INBAG					= "背包";
ENCHANTINGSELL_COMPONANT_DETAIL_HEADER_INBANK					= "银行";

ENCHANTINGSELL_OPTION_ENCHANTING_POURCENTBENEFICE				= "利润%:";

ENCHANTINGSELL_OPTION_ENCHANTING_ENCHANTORSELECTED				= "选择附魔师:";
ENCHANTINGSELL_OPTION_ENCHANTING_NOTHINGPLAYER					= "无";
ENCHANTINGSELL_OPTION_ENCHANTING_FORJOINTPLAYERANDSERVER_OF		= " on ";
ENCHANTINGSELL_OPTION_ENCHANTING_MSGYESORNOTCHANGESERVER		= "这个附魔者在其他服务器,在背包,银行,其他人物的数量已被删除.\n\r你确定要继续吗?"

ENCHANTINGSELL_OPTION_CHAT_SHOWPRICEFORCHATINFO					= "在聊天对话框中给出附魔价格";
ENCHANTINGSELL_OPTION_USE_AUCTIONEER						= "使用拍卖行数据库? ";
ENCHANTINGSELL_OPTION_USE_MINIMAP_BUTTON					= "使用小地图图标?";
ENCHANTINGSELL_OPTION_PRICE_TYPECALCULATE					= "价格计算类型";
ENCHANTINGSELL_OPTION_PRICE_TYPECALCULATE_TYPE1					= "无(1金56银33铜)";
ENCHANTINGSELL_OPTION_PRICE_TYPECALCULATE_TYPE2					= "四舍五入xx.xx(1金57银)";
ENCHANTINGSELL_OPTION_PRICE_TYPECALCULATE_TYPE3					= "四舍五入xx(2金)";

ENCHANTINGSELL_OPTION_BD_RESETBUTTON						= "删除所有保存的数据"
ENCHANTINGSELL_OPTION_BD_DEFAULTCOMPONANTEBUTTON				= "读取缺省的材料数据库"
ENCHANTINGSELL_OPTION_BD_DEFAULTENCHANTEBUTTON					= "读取缺省的附魔数据库"
	
ENCHANTINGSELL_OPTION_UI_MINIMAPPOSITION					= "小地图按钮->位置";

ENCHANTINGSELL_TOOLTIPADD_TITLE							= "EnchantingSell信息";
ENCHANTINGSELL_TOOLTIPADD_ONME							= "背包";
ENCHANTINGSELL_TOOLTIPADD_INBANK						= "银行";
ENCHANTINGSELL_TOOLTIPADD_OTHERPLAYER						= "其他";
ENCHANTINGSELL_TOOLTIPADD_PRICEUNITE						= "成本";

-- The name of jobs, this for check is enchantor or not, give exact name in game
NAME_SPELL_CRAFT_ENCHANTE										= "附魔";

ENCHANTINGSELL_ERRORMSG_INCOMPATIBLESORTENCHANTE				= "不能启动EnchantingSeller!\n\r附魔种类和EnchantingSeller不兼容."

--~ ---------------------------
EnchantingSell_ToolsEnchanting = {
	{"符文铜棒"},
	{"符文银棒"},
	{"符文金棒"},
	{"符文真银棒"},
	{"符文奥金棒"},
};

EnchantingSell_ArmorCarac = {
	[1] = {"靴子", "靴子"};
	[2] = {"护腕", "护腕"};
	[3] = {"胸甲", "胸甲"};
	[4] = {"披风", "披风"};
	[5] = {"手套", "手套"};
	[6] = {"魔油", "魔油"};
	[7] = {"附魔棒", "附魔棒"};
	[8] = {"盾牌", "盾牌"};
	[9] = {"魔杖", "魔杖"};
	[10] = {"双手武器", "双手武器"};
	[11] = {"武器", "武器"};
	[12] = {"其他", "其他"};
	Other = "其他";
	All = "所有";
};

EnchantingSell_Objet = {
	{"符文铜棒", "符文铜棒", "附魔棒"},
	{"符文银棒", "符文银棒", "附魔棒"},
	{"符文金棒", "符文金棒", "附魔棒"},
	{"符文真银棒", "符文真银棒", "附魔棒"},
	{"符文奥金棒", "符文奥金棒", "附魔棒"},
	{"次级魔法仗", "(奥术)DPS:11.3", "魔杖"},
	{"强效魔法仗", "(奥术)DPS:17.5", "魔杖"},
	{"次级秘法魔仗", "(奥术)DPS:25.4", "魔杖"},
	{"强效秘法仗", "(奥术)DPS:29.0", "魔杖"},
	{"初级法力之油", "4MP/5s", "魔油"},
	{"次级法力之油", "8MP/5s", "魔油"},
	{"卓越法力之油", "12MP/5s", "魔油"},
	{"初级巫师之油", "+8伤/30M", "魔油"},
	{"次级巫师之油", "+16伤/30M", "魔油"},
	{"巫师之油", "+24伤/30M", "魔油"},
	{"卓越法力之油", "+36伤/30M", "魔油"},
};

EnchantingSell_Quality = {
	["Quality_Health"] = {
		[1] = {"初级"; 5};
		[2] = {"次级"; 15};
		[3] = {"无"; 25};
		[4] = {"强效"; 35};
		[5] = {"超强"; 50};
		[6] = {"极效"; 100};
	};
	["Quality_Deflect"] = {
		[1] = {"初级"; 1};
		[2] = {"次级"; 2};
		[3] = {"无"; 3};
	};	
	["Quality_Deflection"] = {
		[1] = {"次级"; 2};
		[2] = {"无"; 3};
	};	
	["Quality_Mana"] = {
		[1] = {"初级"; 5};
		[2] = {"次级"; 20};
		[3] = {"无"; 30};
		[4] = {"强效"; 50};
		[5] = {"超强"; 65};
		[6] = {"极效"; 100};
	};
	["Quality_Absorption"] = {
		[1] = {"初级"; "2% 10吸收"};
		[2] = {"次级"; "5% 25吸收"};
--~ 		[3] = {"None"; 0};
	};	
	["Quality_OneCarac"] = {
		[1] = {"初级"; 1};
		[2] = {"次级"; 3};
		[3] = {"无"; 5};
		[4] = {"强效"; 7};
		[5] = {"超强"; 9};
		[6] = {"极效"; 9};
	};
	["Quality_Int_Weapon"] = {
		[1] = {"初级"; 1};
		[2] = {"次级"; 3};
		[3] = {"无"; 5};
		[4] = {"强效"; 7};
		[5] = {"超强"; 9};
		[6] = {"极效"; 9};
		[7] = {"极效"; 22};
	};
	["Quality_Spirit_Weapon"] = {
		[1] = {"初级"; 1};
		[2] = {"次级"; 3};
		[3] = {"无"; 5};
		[4] = {"强效"; 7};
		[5] = {"超强"; 9};
		[6] = {"极效"; 9};
		[7] = {"极效"; 20};
	};
	["Quality_Caract"] = {
		[1] = {"初级"; 1};
		[2] = {"次级"; 2};
		[3] = {"无"; 3};
	};	
	["Quality_Armure"] = {
		[1] = {"初级"; 10};
		[2] = {"次级"; 20};
		[3] = {"无"; 30};
		[4] = {"强效"; 50};
		[5] = {"超强"; 70};
	};	
	["Quality_Degat1M"] = {
		[1] = {"初级"; 1};
		[2] = {"次级"; 2};
		[3] = {"无"; 3};
		[4] = {"强效"; 4};
		[5] = {"超强"; 5};
	};	
	["Quality_Degat2M"] = {
		[1] = {"初级"; 2};
		[2] = {"次级"; 3};
		[3] = {"无"; 5};
		[4] = {"强效"; 7};
		[5] = {"超强"; 9};
	};	
	["Quality_Tueur"] = {
		[1] = {"初级"; 2};
		[2] = {"次级"; 6};
--~ 		[3] = {"None"; 0};
	};	
	["Quality_Metier"] = {
		[1] = {"无"; 2};
		[2] = {"高级"; 5};
	};	
	["Quality_FireResist"] = {
		[1] = {"次级"; 5};
		[2] = {"无"; 7};
	};	
	["Quality_Agility_2HWeapon"] = {
		[1] = {"无"; 25};
	};
	["Quality_AllResist"] = {
		[1] = {"初级"; 1};
		[2] = {"无"; 3};
		[3] = {"强效"; 5};
	};	
	["Quality_ForNew"] = {
		[1] = {"初级"; 0};
		[2] = {"次级"; 0};
		[3] = {"无"; 0};
		[4] = {"强效"; 0};
		[5] = {"超强"; 0};
		[6] = {"极效"; 0};
	};	
};


-- for separer the name of Quality add, use LUA code, look at http://www.lua.org/pil/20.2.html
-- in french is [name (Quality add)], in english is [name - Quality add]

-- english
-- Enchant Boots - Lesser Stamina

-- german
--2H-Waffe - Schwacher Einschlag

-- Chinese
--附魔护腕 - 初级耐力

EnchantingSell_ForTakeNameCaracBonusModel = "^(.+)%s%-%s.+"; 	-- Take name			[(name) - Quality add]
EnchantingSell_ForTakeQualityBonusModel = "^.+%s%-%s(.+)";		-- Take Quality add		[name - (Quality add)]

-- to transform (Quality add) to (ShortQuality +number)
-- exemple : for (Enchant Bracer - Minor Stamina)
-- name is (Enchant Bracer); and Quality is (Minor Stamina)
-- for the name the mod check if exist in table EnchantingSell_ArmorCarac[i][1];
-- 		EnchantingSell_ArmorCarac[2][1] == Bracer, ok is good; show in framemod EnchantingSell_ArmorCarac[2][2] (Bracer)
-- for the quality the mod check if exist in table EnchantingSell_BonusCarac[i][1];
--		EnchantingSell_BonusCarac[7][1] == Stamina, ok is good; show in framemod EnchantingSell_BonusCarac[7][1] (Sta);
--		now for add check in table EnchantingSell_BonusCarac[7][3](ref in other table EnchantingSell_Quality) if exist,
--		ok for Minor in ["Quality_OneCarac"] is (1)
-- (Enchant Bracer - Minor Stamina) become (Bracer Sta +1)
-- the fourting param (EnchantingSell_BonusCarac[i][4]) is for characteristic, exemple for protection on the shield Lesser = +30 and normally is +20
EnchantingSell_BonusCarac = {
	{"防护";							"护甲";					{[1] = {"次级"; 30}};								"盾牌"};
	{"敏捷";								"敏捷";					{[1] = {"无"; 15}};								"武器"};
	{"敏捷";								"敏捷";					EnchantingSell_Quality["Quality_Agility_2HWeapon"];					"双手武器"};
	{"力量";							"力量";						{[1] ={"无"; 15}};								"武器"};
	{"智力";							"智力";						EnchantingSell_Quality["Quality_Int_Weapon"];		"武器"};
	{"精神";								"精神";						EnchantingSell_Quality["Quality_Spirit_Weapon"];	"武器"};
	{"防护";							"护甲";					EnchantingSell_Quality["Quality_Armure"];			nil};
	{"防御";								"护甲";					EnchantingSell_Quality["Quality_Armure"];			nil};
	{"偏斜";								"防御";						EnchantingSell_Quality["Quality_Deflect"];			"护腕"};
	{"偏斜";							"防御";						EnchantingSell_Quality["Quality_Deflect"];			nil};
	{"加速";								"加速";					{[1] = {"Minor"; "1%"}};							nil};
	{"耐力";								"耐力";						EnchantingSell_Quality["Quality_OneCarac"];			nil};
	{"精神";								"精神";						EnchantingSell_Quality["Quality_OneCarac"];			nil};
	{"敏捷";								"敏捷";						EnchantingSell_Quality["Quality_OneCarac"];			nil};
	{"力量";							"力量";						EnchantingSell_Quality["Quality_OneCarac"];			nil};
	{"智力";							"智力";						EnchantingSell_Quality["Quality_OneCarac"];			nil};
	{"状态";								"全属性";					EnchantingSell_Quality["Quality_Caract"];			nil};
	{"法力";								"法力";						EnchantingSell_Quality["Quality_Mana"];				nil};
	{"生命";								"生命";					EnchantingSell_Quality["Quality_Health"];			nil};
	{"吸收";							"";							EnchantingSell_Quality["Quality_Absorption"];		nil};
	{"屠兽";							"屠兽";				EnchantingSell_Quality["Quality_Tueur"];			nil};
	{"元素杀手";					"元素杀手";			EnchantingSell_Quality["Quality_Tueur"];			nil};
	{"屠魔";						"屠魔";				nil;												nil};
	{"打击";							"伤害";					EnchantingSell_Quality["Quality_Degat1M"];			nil};
	{"冲击";								"伤害";					EnchantingSell_Quality["Quality_Degat2M"];			nil};
	{"火焰抗性";						"火焰抗性";				EnchantingSell_Quality["Quality_FireResist"];		nil};
	{"冰霜抗性";					"冰霜抗性";				{[1] = {"无"; 8}};								nil};
	{"暗影抗性";					"暗影抗性";				{[1] = {"次级"; 10}};								nil};
	{"抗性";							"抗性";				EnchantingSell_Quality["Quality_AllResist"];		nil};
	{"采药";							"采药";				EnchantingSell_Quality["Quality_Metier"];			nil};
	{"采矿";								"采矿";					EnchantingSell_Quality["Quality_Metier"];			nil};
	{"钓鱼";								"钓鱼";					EnchantingSell_Quality["Quality_Metier"];			nil};
	{"剥皮";							"剥皮";					{[1] = {"无"; 5}};								nil};
	{"挡格";								"挡格";					{[1] = {"次级"; "2%"}};							nil};
};

-- This is for componantes descrition add
DescritionDefaultReagents = {
	[1] = {
		["Name"] = "奇异之尘",
		["Description"] = "这个通常由护甲得到.绿色物品 等级1-20.",
	},
	[2] = {
		["Name"] = "灵魂之尘",
		["Description"] = "这个通常由护甲得到.绿色物品 等级21-30.",
	},
	[3] = {
		["Name"] = "幻象之尘",
		["Description"] = "这个通常由护甲得到.绿色物品 等级31-40.",
	},
	[4] = {
		["Name"] = "梦境之尘",
		["Description"] = "这个通常由护甲得到.绿色物品 等级41-50.",
	},
	[5] = {
		["Name"] = "幻影之尘",
		["Description"] = "这个通常由护甲得到.绿色物品 等级51-60.",
	},
	[6] = {
		["Name"] = "次级魔法精华",
		["Description"] = "这个通常由武器得到.绿色物品 等级1-10.",
	},
	[7] = {
		["Name"] = "强效魔法精华",
		["Description"] = "这个通常由武器得到.绿色物品 等级11-15.",
	},
	[8] = {
		["Name"] = "次级星界精华",
		["Description"] = "这个通常由武器得到.绿色物品 等级16-20.",
	},
	[9] = {
		["Name"] = "强效星界精华",
		["Description"] = "这个通常由武器得到.绿色物品 等级21-25.",
	},
	[10] = {
		["Name"] = "次级秘法精华",
		["Description"] = "这个通常由武器得到.绿色物品 等级26-30.",
	},
	[11] = {
		["Name"] = "强效秘法精华",
		["Description"] = "这个通常由武器得到.绿色物品 等级31-35.",
	},
	[12] = {
		["Name"] = "次级虚空精华",
		["Description"] = "这个通常由武器得到.绿色物品 等级36-40.",
	},
	[13] = {
		["Name"] = "强效虚空精华",
		["Description"] = "这个通常由武器得到.绿色物品 等级41-45.",
	},
	[14] = {
		["Name"] = "次级不灭精华",
		["Description"] = "这个通常由武器得到.绿色物品 等级46-50.",
	},
	[15] = {
		["Name"] = "强效不灭精华",
		["Description"] = "这个通常由武器得到.绿色物品 等级51-60.",
	},
	[16] = {
		["Name"] = "小块微光碎片",
		["Description"] = "仅仅由蓝色物品得到(包括紫色).绿色物品 等级1-20.",
	},
	[17] = {
		["Name"] = "大块微光碎片",
		["Description"] = "仅仅由蓝色物品得到(包括紫色).绿色物品 等级21-25.",
	},
	[18] = {
		["Name"] = "小块闪光碎片",
		["Description"] = "仅仅由蓝色物品得到(包括紫色).绿色物品 等级26-30.",
	},
	[19] = {
		["Name"] = "大块闪光碎片",
		["Description"] = "仅仅由蓝色物品得到(包括紫色).绿色物品 等级31-35.",
	},
	[20] = {
		["Name"] = "小块强光碎片",
		["Description"] = "仅仅由蓝色物品得到(包括紫色).绿色物品 等级36-40.",
	},
	[21] = {
		["Name"] = "大块强光碎片",
		["Description"] = "仅仅由蓝色物品得到(包括紫色).绿色物品 等级41-45.",
	},
	[22] = {
		["Name"] = "小块魔光碎片",
		["Description"] = "仅仅由蓝色物品得到(包括紫色).绿色物品 等级46-50.",
	},
	[23] = {
		["Name"] = "大块强光碎片",
		["Description"] = "仅仅由蓝色物品得到(包括紫色).绿色物品 等级51-60.",
	},
	[24] = {
		["Name"] = "铜棒",
		["Description"] = "由附魔供应商提供.",
	},
	[25] = {
		["Name"] = "银棒",
		["Description"] = "由技能100的铁匠制造.",
	},
	[26] = {
		["Name"] = "金棒",
		["Description"] = "由技能150的铁匠制造.",
	},
	[27] = {
		["Name"] = "真银棒",
		["Description"] = "由技能200的铁匠制造.",
	},
	[28] = {
		["Name"] = "奥金棒",
		["Description"] = "由技能275的铁匠制造.",
	},
	[29] = {
		["Name"] = "普通木柴",
		["Description"] = "由附魔供应商提供.",
	},
	[30] = {
		["Name"] = "星木",
		["Description"] = "由附魔供应商提供.",
	},
};

EnchantingSell_DefaultList = {

	Componantes = {
		[1] = {
			["PriceUnite"] = 3000,
			["Link"] = "|cff1eff00|Hitem:7909:0:0:0|h[青绿石]|h|r",
			["Name"] = "青绿石",
			["Texture"] = "Interface\\Icons\\INV_Misc_Gem_Crystal_02",
		},
		[2] = {
			["PriceUnite"] = 7500,
			["Link"] = "|cff1eff00|Hitem:7971:0:0:0|h[黑珍珠]|h|r",
			["Name"] = "黑珍珠",
			["Texture"] = "Interface\\Icons\\INV_Misc_Gem_Pearl_01",
		},
		[3] = {
			["PriceUnite"] = 1750,
			["Link"] = "|cffffffff|Hitem:6370:0:0:0|h[黑口鱼油]|h|r",
			["Name"] = "黑口鱼油",
			["Texture"] = "Interface\\Icons\\INV_Drink_12",
		},
		[4] = {
			["PriceUnite"] = 124,
			["Link"] = "|cffffffff|Hitem:6217:0:0:0|h[铜棒]|h|r",
			["Name"] = "铜棒",
			["Texture"] = "Interface\\Icons\\INV_Misc_Flute_01",
		},
		[5] = {
			["PriceUnite"] = 5000,
			["Link"] = "|cffffffff|Hitem:11176:0:0:0|h[梦境之尘]|h|r",
			["Name"] = "梦境之尘",
			["Texture"] = "Interface\\Icons\\INV_Enchant_DustDream",
		},
		[6] = {
			["PriceUnite"] = 4696,
			["Link"] = "|cffffffff|Hitem:7068:0:0:0|h[元素火焰]|h|r",
			["Name"] = "元素火焰",
			["Texture"] = "Interface\\Icons\\Spell_Fire_Fire",
		},
		[7] = {
			["PriceUnite"] = 2505,
			["Link"] = "|cffffffff|Hitem:6371:0:0:0|h[火焰之油]|h|r",
			["Name"] = "火焰之油",
			["Texture"] = "Interface\\Icons\\INV_Potion_38",
		},
		[8] = {
			["PriceUnite"] = 15000,
			["Link"] = "|cffffffff|Hitem:3829:0:0:0|h[冰霜之油]|h|r",
			["Name"] = "冰霜之油",
			["Texture"] = "Interface\\Icons\\INV_Potion_20",
		},
		[9] = {
			["PriceUnite"] = 7711,
			["Link"] = "|cffffffff|Hitem:11128:0:0:0|h[金棒]|h|r",
			["Name"] = "金棒",
			["Texture"] = "Interface\\Icons\\INV_Staff_10",
		},
		[10] = {
			["PriceUnite"] = 7750,
			["Link"] = "|cff1eff00|Hitem:11082:0:0:0|h[强效星界精华]|h|r",
			["Name"] = "强效星界精华",
			["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceAstralLarge",
		},
		[11] = {
			["PriceUnite"] = 2400,
			["Link"] = "|cff1eff00|Hitem:10939:0:0:0|h[强效魔法精华]|h|r",
			["Name"] = "强效魔法精华",
			["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceMagicLarge",
		},
		[12] = {
			["PriceUnite"] = 7300,
			["Link"] = "|cff1eff00|Hitem:11135:0:0:0|h[强效秘法精华]|h|r",
			["Name"] = "强效秘法精华",
			["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceMysticalLarge",
		},
		[13] = {
			["PriceUnite"] = 33950,
			["Link"] = "|cff1eff00|Hitem:11175:0:0:0|h[强效虚空精华]|h|r",
			["Name"] = "强效虚空精华",
			["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceNetherLarge",
		},
		[14] = {
			["PriceUnite"] = 675,
			["Link"] = "|cffffffff|Hitem:7392:0:0:0|h[绿色幼龙鳞片]|h|r",
			["Name"] = "绿色幼龙鳞片",
			["Texture"] = "Interface\\Icons\\INV_Misc_MonsterScales_03",
		},
		[15] = {
			["PriceUnite"] = 6000,
			["Link"] = "|cff1eff00|Hitem:5500:0:0:0|h[彩色珍珠]|h|r",
			["Name"] = "彩色珍珠",
			["Texture"] = "Interface\\Icons\\INV_Misc_Gem_Pearl_02",
		},
		[16] = {
			["PriceUnite"] = 698,
			["Link"] = "|cffffffff|Hitem:2772:0:0:0|h[铁矿石]|h|r",
			["Name"] = "铁矿石",
			["Texture"] = "Interface\\Icons\\INV_Ore_Iron_01",
		},
		[17] = {
			["PriceUnite"] = 1191,
			["Link"] = "|cffffffff|Hitem:5637:0:0:0|h[大牙齿]|h|r",
			["Name"] = "大牙齿",
			["Texture"] = "Interface\\Icons\\INV_Misc_Bone_08",
		},
		[18] = {
			["PriceUnite"] = 15000,
			["Link"] = "|cff0070dd|Hitem:11084:0:0:0|h[大块微光碎片]|h|r",
			["Name"] = "大块®光碎片",
			["Texture"] = "Interface\\Icons\\INV_Enchant_ShardGlimmeringLarge",
		},
		[19] = {
			["PriceUnite"] = 30000,
			["Link"] = "|cff0070dd|Hitem:11139:0:0:0|h[大块闪光碎片]|h|r",
			["Name"] = "大块闪光碎片",
			["Texture"] = "Interface\\Icons\\INV_Enchant_ShardGlowingLarge",
		},
		[20] = {
			["PriceUnite"] = 70000,
			["Link"] = "|cff0070dd|Hitem:11178:0:0:0|h[大块强光碎片]|h|r",
			["Name"] = "大块强光碎片",
			["Texture"] = "Interface\\Icons\\INV_Enchant_ShardRadientLarge",
		},
		[21] = {
			["PriceUnite"] = 1500,
			["Link"] = "|cff1eff00|Hitem:10998:0:0:0|h[次级星界精华]|h|r",
			["Name"] = "次级星界精华",
			["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceAstralSmall",
		},
		[22] = {
			["PriceUnite"] = 13000,
			["Link"] = "|cff1eff00|Hitem:16202:0:0:0|h[次级不灭精华]|h|r",
			["Name"] = "次级不灭精华",
			["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceEternalSmall",
		},
		[23] = {
			["PriceUnite"] = 1000,
			["Link"] = "|cff1eff00|Hitem:10938:0:0:0|h[次级魔法精华]|h|r",
			["Name"] = "次级魔法精华",
			["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceMagicSmall",
		},
		[24] = {
			["PriceUnite"] = 3000,
			["Link"] = "|cff1eff00|Hitem:11134:0:0:0|h[次级秘法精华]|h|r",
			["Name"] = "次级秘法精华",
			["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceMysticalSmall",
		},
		[25] = {
			["PriceUnite"] = 10000,
			["Link"] = "|cff1eff00|Hitem:11174:0:0:0|h[次级虚空精华]|h|r",
			["Name"] = "次级虚空精华",
			["Texture"] = "Interface\\Icons\\INV_Enchant_EssenceNetherSmall",
		},
		[26] = {
			["PriceUnite"] = 1000,
			["Link"] = "|cffffffff|Hitem:8170:0:0:0|h[硬甲皮]|h|r",
			["Name"] = "硬甲皮",
			["Texture"] = "Interface\\Icons\\INV_Misc_LeatherScrap_02",
		},
		[27] = {
			["PriceUnite"] = 600,
			["Link"] = "|cff1eff00|Hitem:1210:0:0:0|h[暗影石]|h|r",
			["Name"] = "暗影石",
			["Texture"] = "Interface\\Icons\\INV_Misc_Gem_Amethyst_01",
		},
		[28] = {
			["PriceUnite"] = 2500,
			["Link"] = "|cffffffff|Hitem:6338:0:0:0|h[银棒]|h|r",
			["Name"] = "银棒",
			["Texture"] = "Interface\\Icons\\INV_Staff_01",
		},
		[29] = {
			["PriceUnite"] = 38,
			["Link"] = "|cffffffff|Hitem:4470:0:0:0|h[普通木柴]|h|r",
			["Name"] = "普通木柴",
			["Texture"] = "Interface\\Icons\\INV_TradeskillItem_01",
		},
		[30] = {
			["PriceUnite"] = 3000,
			["Link"] = "|cff0070dd|Hitem:10978:0:0:0|h[小块微光碎片]|h|r",
			["Name"] = "小块微光碎片",
			["Texture"] = "Interface\\Icons\\INV_Enchant_ShardGlimmeringSmall",
		},
		[31] = {
			["PriceUnite"] = 10000,
			["Link"] = "|cff0070dd|Hitem:11138:0:0:0|h[小块闪光碎片]|h|r",
			["Name"] = "小块闪光碎片",
			["Texture"] = "Interface\\Icons\\INV_Enchant_ShardGlowingSmall",
		},
		[32] = {
			["PriceUnite"] = 35000,
			["Link"] = "|cff0070dd|Hitem:11177:0:0:0|h[小块强光碎片]|h|r",
			["Name"] = "小块强光碎片",
			["Texture"] = "Interface\\Icons\\INV_Enchant_ShardRadientSmall",
		},
		[33] = {
			["PriceUnite"] = 800,
			["Link"] = "|cffffffff|Hitem:11083:0:0:0|h[灵魂之尘]|h|r",
			["Name"] = "灵魂之尘",
			["Texture"] = "Interface\\Icons\\INV_Enchant_DustSoul",
		},
		[34] = {
			["PriceUnite"] = 4500,
			["Link"] = "|cffffffff|Hitem:11291:0:0:0|h[星木]|h|r",
			["Name"] = "星木",
			["Texture"] = "Interface\\Icons\\INV_TradeskillItem_03",
		},
		[35] = {
			["PriceUnite"] = 500,
			["Link"] = "|cffffffff|Hitem:10940:0:0:0|h[奇异之尘]|h|r",
			["Name"] = "奇异之尘",
			["Texture"] = "Interface\\Icons\\INV_Enchant_DustStrange",
		},
		[36] = {
			["PriceUnite"] = 2250,
			["Link"] = "|cffffffff|Hitem:12359:0:0:0|h[瑟银锭]|h|r",
			["Name"] = "瑟银锭",
			["Texture"] = "Interface\\Icons\\INV_Ingot_07",
		},
		[37] = {
			["PriceUnite"] = 4500,
			["Link"] = "|cff1eff00|Hitem:6037:0:0:0|h[真银锭]|h|r",
			["Name"] = "真银锭",
			["Texture"] = "Interface\\Icons\\INV_Ingot_08",
		},
		[38] = {
			["PriceUnite"] = 12250,
			["Link"] = "|cffffffff|Hitem:11144:0:0:0|h[真银棒]|h|r",
			["Name"] = "真银棒",
			["Texture"] = "Interface\\Icons\\INV_Staff_11",
		},
		[39] = {
			["PriceUnite"] = 1990,
			["Link"] = "|cffffffff|Hitem:11137:0:0:0|h[幻象之尘]|h|r",
			["Name"] = "幻象之尘",
			["Texture"] = "Interface\\Icons\\INV_Enchant_DustVision",
		},
		[40] = {
			["PriceUnite"] = 8400,
			["Link"] = "|cffffffff|Hitem:8153:0:0:0|h[野葡萄藤]|h|r",
			["Name"] = "野葡萄藤",
			["Texture"] = "Interface\\Icons\\INV_Misc_Herb_03",
		},
	},
	Enchantes = {
		[1] = {
			["OnThis"] = "双手武器",
			["Required"] = "符文铜棒",
			["LongName"] = "附魔双手武器 - 初级冲击",
			["BonusNb"] = 2,
			["Name"] = "附魔双手武器",
			["Reagents"] = {
				[1] = {
					["Name"] = "奇异之尘",
					["Count"] = 4,
				},
				[2] = {
					["Name"] = "小块微光碎片",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["Description"] = "Permanently enchant a Two-Handed Melee Weapon to do 2 additional points of damage.",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "伤害",
		},
		[2] = {
			["OnThis"] = "双手武器",
			["Required"] = "符文银棒",
			["LongName"] = "附魔双手武器 - 次级冲击",
			["BonusNb"] = 3,
			["Name"] = "附魔双手武器",
			["Reagents"] = {
				[1] = {
					["Name"] = "灵魂之尘",
					["Count"] = 3,
				},
				[2] = {
					["Name"] = "大块微光碎片",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["Description"] = "Permanently enchant a Two-handed Melee Weapon to do 3 additional points of damage.",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "伤害",
		},
		[3] = {
			["OnThis"] = "双手武器",
			["Required"] = "符文金棒",
			["LongName"] = "附魔双手武器 - 冲击",
			["BonusNb"] = 5,
			["Name"] = "附魔双手武器",
			["Reagents"] = {
				[1] = {
					["Name"] = "幻象之尘",
					["Count"] = 4,
				},
				[2] = {
					["Name"] = "大块闪光碎片",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["Description"] = "Permanently enchant a Two-handed Melee Weapon to do 5 additional points of damage.",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "伤害",
		},
		[4] = {
			["OnThis"] = "双手武器",
			["Required"] = "符文真银棒",
			["LongName"] = "附魔双手武器 - 强效冲击",
			["BonusNb"] = 7,
			["Name"] = "附魔双手武器",
			["Reagents"] = {
				[1] = {
					["Name"] = "大块强光碎片",
					["Count"] = 2,
				},
				[2] = {
					["Name"] = "梦境之尘",
					["Count"] = 2,
				},
				["Etat"] = -2,
			},
			["Description"] = "Permanently enchant a two-handed melee weapon to do +7 damage.",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "伤害",
		},
		[5] = {
			["OnThis"] = "双手武器",
			["Required"] = "符文铜棒",
			["LongName"] = "附魔双手武器 - 次级智力",
			["BonusNb"] = 3,
			["Name"] = "附魔双手武器",
			["Reagents"] = {
				[1] = {
					["Name"] = "强效魔法精华",
					["Count"] = 3,
				},
				["Etat"] = -2,
			},
			["Description"] = "Permanently enchant a Two-Handed Melee Weapon to add 3 to intellect.",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "智力",
		},
		[6] = {
			["OnThis"] = "双手武器",
			["Required"] = "符文铜棒",
			["LongName"] = "附魔双手武器 - 次级精神",
			["BonusNb"] = 3,
			["Name"] = "附魔双手武器",
			["Reagents"] = {
				[1] = {
					["Name"] = "次级星界精华",
					["Count"] = 1,
				},
				[2] = {
					["Name"] = "奇异之尘",
					["Count"] = 6,
				},
				["Etat"] = -2,
			},
			["Description"] = "Permanently enchant a Two-Handed Melee Weapon to add 3 to Spirit.",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "精神",
		},
		[7] = {
			["OnThis"] = "靴子",
			["Required"] = "符文金棒",
			["LongName"] = "附魔靴子 - 次级敏捷",
			["BonusNb"] = 3,
			["Name"] = "附魔靴子",
			["Reagents"] = {
				[1] = {
					["Name"] = "灵魂之尘",
					["Count"] = 1,
				},
				[2] = {
					["Name"] = "次级秘法精华",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["Description"] = "Permanently enchant boots to give +3 Agility.",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "敏捷",
		},
		[8] = {
			["OnThis"] = "靴子",
			["Required"] = "符文真银棒",
			["LongName"] = "附魔靴子 - 敏捷",
			["BonusNb"] = 5,
			["Name"] = "附魔靴子",
			["Reagents"] = {
				[1] = {
					["Name"] = "强效虚空精华",
					["Count"] = 2,
				},
				["Etat"] = -2,
			},
			["Description"] = "Permanently enchant boots to give +5 Agility.",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "敏捷",
		},
		[9] = {
			["OnThis"] = "靴子",
			["Required"] = "符文真银棒",
			["LongName"] = "附魔靴子 - 初级速度",
			["Name"] = "附魔靴子",
			["Reagents"] = {
				[1] = {
					["Name"] = "小块强光碎片",
					["Count"] = 1,
				},
				[2] = {
					["Name"] = "青绿石",
					["Count"] = 1,
				},
				[3] = {
					["Name"] = "次级虚空精华",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["Description"] = "Permanently enchant boots to give a slight movement speed increase.",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "初级速度",
		},
		[10] = {
			["OnThis"] = "靴子",
			["Required"] = "符文金棒",
			["LongName"] = "附魔靴子 - 次级精神",
			["BonusNb"] = 3,
			["Name"] = "附魔靴子",
			["Reagents"] = {
				[1] = {
					["Name"] = "强效秘法精华",
					["Count"] = 1,
				},
				[2] = {
					["Name"] = "次级秘法精华",
					["Count"] = 2,
				},
				["Etat"] = -2,
			},
			["Description"] = "Permanently enchant boots to give +3 Spirit.",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "精神",
		},
		[11] = {
			["OnThis"] = "靴子",
			["Required"] = "符文银棒",
			["LongName"] = "附魔靴子 - 初级耐力",
			["BonusNb"] = 1,
			["Name"] = "附魔靴子",
			["Reagents"] = {
				[1] = {
					["Name"] = "奇异之尘",
					["Count"] = 8,
				},
				["Etat"] = -2,
			},
			["Description"] = "Permanently enchant a pair of boots so they increase the wearer's Stamina by 1.",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "耐力",
		},
		[12] = {
			["OnThis"] = "靴子",
			["Required"] = "符文金棒",
			["LongName"] = "附魔靴子 - 次级耐力",
			["BonusNb"] = 3,
			["Name"] = "附魔靴子",
			["Reagents"] = {
				[1] = {
					["Name"] = "灵魂之尘",
					["Count"] = 4,
				},
				["Etat"] = -2,
			},
			["Description"] = "Permanently enchant boots to give +3 Stamina.",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "耐力",
		},
		[13] = {
			["OnThis"] = "靴子",
			["Required"] = "符文真银棒",
			["LongName"] = "附魔靴子 - 耐力",
			["BonusNb"] = 5,
			["Name"] = "附魔靴子",
			["Reagents"] = {
				[1] = {
					["Name"] = "幻象之尘",
					["Count"] = 5,
				},
				["Etat"] = -2,
			},
			["Description"] = "Permanently enchant boots to give +5 Stamina.",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "耐力",
		},
		[14] = {
			["OnThis"] = "靴子",
			["Description"] = "Permanently enchant boots to give +7 Stamina.",
			["Reagents"] = {
				[1] = {
					["Name"] = "梦境之尘",
					["Count"] = 10,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔靴子 - 强效耐力",
			["BonusNb"] = 7,
			["Name"] = "附魔靴子",
			["Required"] = "符文真银棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "耐力",
		},
		[15] = {
			["OnThis"] = "护腕",
			["Description"] = "Permanently enchant bracers so they increase the wearer's Agility by 1.",
			["Reagents"] = {
				[1] = {
					["Name"] = "奇异之尘",
					["Count"] = 2,
				},
				[2] = {
					["Name"] = "强效魔法精华",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔护腕 - 初级敏捷",
			["BonusNb"] = 1,
			["Name"] = "附魔护腕",
			["Required"] = "符文铜棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "敏捷",
		},
		[16] = {
			["OnThis"] = "护腕",
			["Description"] = "Permanently enchant bracers so that the defense skill of the wearer is increased by 1.",
			["Reagents"] = {
				[1] = {
					["Name"] = "次级魔法精华",
					["Count"] = 1,
				},
				[2] = {
					["Name"] = "奇异之尘",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔护腕 - 初级偏斜",
			["BonusNb"] = 1,
			["Name"] = "附魔护腕",
			["Required"] = "符文铜棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "Def",
		},
		[17] = {
			["OnThis"] = "护腕",
			["Description"] = "Permanently enchant bracers to increase the health of the wearer by 5.",
			["Reagents"] = {
				[1] = {
					["Name"] = "奇异之尘",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔护腕 - 初级生命",
			["BonusNb"] = 5,
			["Name"] = "附魔护腕",
			["Required"] = "符文铜棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "生命",
		},
		[18] = {
			["OnThis"] = "护腕",
			["Description"] = "Permanently enchant a bracer so it increases the wearer's Intellect by 3.",
			["Reagents"] = {
				[1] = {
					["Name"] = "强效星界精华",
					["Count"] = 2,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔护腕 - 次级智力",
			["BonusNb"] = 3,
			["Name"] = "附魔护腕",
			["Required"] = "符文银棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "智力",
		},
		[19] = {
			["OnThis"] = "护腕",
			["Description"] = "Permanently enchants bracers to give +5 Intellect.",
			["Reagents"] = {
				[1] = {
					["Name"] = "次级虚空精华",
					["Count"] = 2,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔护腕 - 智力",
			["BonusNb"] = 5,
			["Name"] = "附魔护腕",
			["Required"] = "符文真银棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "智力",
		},
		[20] = {
			["OnThis"] = "护腕",
			["Description"] = "Permanently enchant bracers so they increase the wearer's Spirit by 1.",
			["Reagents"] = {
				[1] = {
					["Name"] = "次级魔法精华",
					["Count"] = 2,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔护腕 - 初级精神",
			["BonusNb"] = 1,
			["Name"] = "附魔护腕",
			["Required"] = "符文铜棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "精神",
		},
		[21] = {
			["OnThis"] = "护腕",
			["Description"] = "Permanently enchant a bracer so it increases the wearer's Spirit by 3.",
			["Reagents"] = {
				[1] = {
					["Name"] = "次级星界精华",
					["Count"] = 2,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔护腕 - 次级精神",
			["BonusNb"] = 3,
			["Name"] = "附魔护腕",
			["Required"] = "符文银棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "精神",
		},
		[22] = {
			["OnThis"] = "护腕",
			["Description"] = "Permanently enchants bracers to give +5 Spirit.",
			["Reagents"] = {
				[1] = {
					["Name"] = "次级秘法精华",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔护腕 - 精神",
			["BonusNb"] = 5,
			["Name"] = "附魔护腕",
			["Required"] = "符文金棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "精神",
		},
		[23] = {
			["OnThis"] = "护腕",
			["Description"] = "Permanently enchant bracers so they increase the wearer's Stamina by 1.",
			["Reagents"] = {
				[1] = {
					["Name"] = "奇异之尘",
					["Count"] = 3,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔护腕 - 初级耐力",
			["BonusNb"] = 1,
			["Name"] = "附魔护腕",
			["Required"] = "符文铜棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "耐力",
		},
		[24] = {
			["OnThis"] = "护腕",
			["Description"] = "Permanently enchant a bracer so it increases the wearer's Stamina by 3.",
			["Reagents"] = {
				[1] = {
					["Name"] = "灵魂之尘",
					["Count"] = 2,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔护腕 - 次级耐力",
			["BonusNb"] = 3,
			["Name"] = "附魔护腕",
			["Required"] = "符文银棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "耐力",
		},
		[25] = {
			["OnThis"] = "护腕",
			["Description"] = "Permanently enchants bracers to give +5 Stamina.",
			["Reagents"] = {
				[1] = {
					["Name"] = "灵魂之尘",
					["Count"] = 6,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔护腕 - 耐力",
			["BonusNb"] = 5,
			["Name"] = "附魔护腕",
			["Required"] = "符文金棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "耐力",
		},
		[26] = {
			["OnThis"] = "护腕",
			["Description"] = "Permanently enchant bracers so they increase the wearer's Strength by 1.",
			["Reagents"] = {
				[1] = {
					["Name"] = "奇异之尘",
					["Count"] = 5,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔护腕 - 初级力量",
			["BonusNb"] = 1,
			["Name"] = "附魔护腕",
			["Required"] = "符文铜棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "力量",
		},
		[27] = {
			["OnThis"] = "护腕",
			["Description"] = "Permanently enchants bracers to give +5 Strength.",
			["Reagents"] = {
				[1] = {
					["Name"] = "幻象之尘",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔护腕 - 力量",
			["BonusNb"] = 5,
			["Name"] = "附魔护腕",
			["Required"] = "符文金棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "力量",
		},
		[28] = {
			["OnThis"] = "护腕",
			["Description"] = "Permanently enchants bracers to give +7 Strength.",
			["Reagents"] = {
				[1] = {
					["Name"] = "梦境之尘",
					["Count"] = 2,
				},
				[2] = {
					["Name"] = "强效虚空精华",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔护腕 - 强效力量",
			["BonusNb"] = 7,
			["Name"] = "附魔护腕",
			["Required"] = "符文真银棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "力量",
		},
		[29] = {
			["OnThis"] = "胸甲",
			["Description"] = "Permanently enchant a piece of chest armor to grant +1 to all stats.",
			["Reagents"] = {
				[1] = {
					["Name"] = "强效星界精华",
					["Count"] = 1,
				},
				[2] = {
					["Name"] = "灵魂之尘",
					["Count"] = 1,
				},
				[3] = {
					["Name"] = "大块微光碎片",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔胸甲 - 初级属性",
			["BonusNb"] = 1,
			["Name"] = "附魔胸甲",
			["Required"] = "符文银棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "全属性",
		},
		[30] = {
			["OnThis"] = "胸甲",
			["Description"] = "Permanently enchant a piece of chest armor to grant +2 to all stats.",
			["Reagents"] = {
				[1] = {
					["Name"] = "强效秘法精华",
					["Count"] = 2,
				},
				[2] = {
					["Name"] = "幻象之尘",
					["Count"] = 2,
				},
				[3] = {
					["Name"] = "大块闪光碎片",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔胸甲 - 次级状态",
			["BonusNb"] = 2,
			["Name"] = "附魔胸甲",
			["Required"] = "符文金棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "全属性",
		},
		[31] = {
			["OnThis"] = "胸甲",
			["Description"] = "Permanently enchant a piece of chest armor to grant +3 to all stats.",
			["Reagents"] = {
				[1] = {
					["Name"] = "大块强光碎片",
					["Count"] = 1,
				},
				[2] = {
					["Name"] = "梦境之尘",
					["Count"] = 3,
				},
				[3] = {
					["Name"] = "强效虚空精华",
					["Count"] = 2,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔胸甲 - 状态",
			["BonusNb"] = 3,
			["Name"] = "附魔胸甲",
			["Required"] = "符文真银棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "全属性",
		},
		[32] = {
			["OnThis"] = "胸甲",
			["Description"] = "Permanently enchant a piece of chest armor so that it increases the health of the wearer by 5.",
			["Reagents"] = {
				[1] = {
					["Name"] = "奇异之尘",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔胸甲 - 初级生命",
			["BonusNb"] = 5,
			["Name"] = "附魔胸甲",
			["Required"] = "符文铜棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "生命",
		},
		[33] = {
			["OnThis"] = "胸甲",
			["Description"] = "Permanently enchant a piece of chest armor so that it increases the health of the wearer by 15.",
			["Reagents"] = {
				[1] = {
					["Name"] = "奇异之尘",
					["Count"] = 2,
				},
				[2] = {
					["Name"] = "次级魔法精华",
					["Count"] = 2,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔胸甲 - 次级生命",
			["BonusNb"] = 15,
			["Name"] = "附魔胸甲",
			["Required"] = "符文铜棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "生命",
		},
		[34] = {
			["OnThis"] = "胸甲",
			["Description"] = "Permanently enchant a piece of chest armor to increase the health of the wearer by 25.",
			["Reagents"] = {
				[1] = {
					["Name"] = "奇异之尘",
					["Count"] = 4,
				},
				[2] = {
					["Name"] = "次级星界精华",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔胸甲 - 生命",
			["BonusNb"] = 25,
			["Name"] = "附魔胸甲",
			["Required"] = "符文银棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "生命",
		},
		[35] = {
			["OnThis"] = "胸甲",
			["Description"] = "Permanently enchant a piece of chest armor to give +35 health.",
			["Reagents"] = {
				[1] = {
					["Name"] = "灵魂之尘",
					["Count"] = 3,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔胸甲 - 强效生命",
			["BonusNb"] = 35,
			["Name"] = "附魔胸甲",
			["Required"] = "符文金棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "生命",
		},
		[36] = {
			["OnThis"] = "胸甲",
			["Description"] = "Permanently enchant a piece of chest armor to grant +50 health.",
			["Reagents"] = {
				[1] = {
					["Name"] = "幻象之尘",
					["Count"] = 6,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔胸甲 - 超强生命",
			["BonusNb"] = 50,
			["Name"] = "附魔胸甲",
			["Required"] = "符文真银棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "生命",
		},
		[37] = {
			["OnThis"] = "胸甲",
			["Description"] = "Permanently enchant a piece of chest armor so that it increases the mana of the wearer by 5.",
			["Reagents"] = {
				[1] = {
					["Name"] = "次级魔法精华",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔胸甲 - 初级法力",
			["BonusNb"] = 5,
			["Name"] = "附魔胸甲",
			["Required"] = "符文铜棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "法力",
		},
		[38] = {
			["OnThis"] = "胸甲",
			["Description"] = "Permanently enchant a piece of chest armor to increase the mana of the wearer by 30.",
			["Reagents"] = {
				[1] = {
					["Name"] = "强效星界精华",
					["Count"] = 1,
				},
				[2] = {
					["Name"] = "次级星界精华",
					["Count"] = 2,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔胸甲 - 法力",
			["BonusNb"] = 30,
			["Name"] = "附魔胸甲",
			["Required"] = "符文银棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "法力",
		},
		[39] = {
			["OnThis"] = "胸甲",
			["Description"] = "Permanently enchant a piece of chest armor to give +50 mana.",
			["Reagents"] = {
				[1] = {
					["Name"] = "强效秘法精华",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔胸甲 - 强效法力",
			["BonusNb"] = 50,
			["Name"] = "附魔胸甲",
			["Required"] = "符文金棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "法力",
		},
		[40] = {
			["OnThis"] = "胸甲",
			["Description"] = "Permanently enchant a piece of chest armor to give +65 mana.",
			["Reagents"] = {
				[1] = {
					["Name"] = "强效虚空精华",
					["Count"] = 1,
				},
				[2] = {
					["Name"] = "次级虚空精华",
					["Count"] = 2,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔胸甲 - 超强法力",
			["BonusNb"] = 65,
			["Name"] = "附魔胸甲",
			["Required"] = "符文真银棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "法力",
		},
		[41] = {
			["OnThis"] = "胸甲",
			["Description"] = "Enchant a piece of chest armor so it has a 2% chance per hit of giving you 10 points of damage absorption.",
			["Reagents"] = {
				[1] = {
					["Name"] = "奇异之尘",
					["Count"] = 2,
				},
				[2] = {
					["Name"] = "次级魔法精华",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔胸甲 - 初级吸收",
			["BonusNb"] = "2% Abs10pv",
			["Name"] = "附魔胸甲",
			["Required"] = "符文铜棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "",
		},
		[42] = {
			["OnThis"] = "胸甲",
			["Description"] = "Enchant a piece of chest armor so it has a 5% chance per hit of giving you 25 points of damage absorption.",
			["Reagents"] = {
				[1] = {
					["Name"] = "奇异之尘",
					["Count"] = 2,
				},
				[2] = {
					["Name"] = "强效星界精华",
					["Count"] = 1,
				},
				[3] = {
					["Name"] = "大块微光碎片",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔胸甲 - 次级吸收",
			["BonusNb"] = "5% Abs25pv",
			["Name"] = "附魔胸甲",
			["Required"] = "符文银棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "",
		},
		[43] = {
			["OnThis"] = "披风",
			["Description"] = "Permanently enchant a cloak to grant +1 Agility.",
			["Reagents"] = {
				[1] = {
					["Name"] = "次级星界精华",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔披风 - 初级敏捷",
			["BonusNb"] = 1,
			["Name"] = "附魔披风",
			["Required"] = "符文银棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "敏捷",
		},
		[44] = {
			["OnThis"] = "披风",
			["Description"] = "Permanently enchant a cloak to give 3 Agility.",
			["Reagents"] = {
				[1] = {
					["Name"] = "次级虚空精华",
					["Count"] = 2,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔披风 - 次级敏捷",
			["BonusNb"] = 3,
			["Name"] = "附魔披风",
			["Required"] = "符文真银棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "敏捷",
		},
		[45] = {
			["OnThis"] = "披风",
			["Description"] = "Enchant a cloak to provide 10 additional points of armor.",
			["Reagents"] = {
				[1] = {
					["Name"] = "奇异之尘",
					["Count"] = 3,
				},
				[2] = {
					["Name"] = "强效魔法精华",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔披风 - 初级防护",
			["BonusNb"] = 10,
			["Name"] = "附魔披风",
			["Required"] = "符文铜棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "护甲",
		},
		[46] = {
			["OnThis"] = "披风",
			["Description"] = "Permanently enchant a cloak to increase armor by 20.",
			["Reagents"] = {
				[1] = {
					["Name"] = "奇异之尘",
					["Count"] = 6,
				},
				[2] = {
					["Name"] = "小块微光碎片",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔披风 - 次级防护",
			["BonusNb"] = 20,
			["Name"] = "附魔披风",
			["Required"] = "符文铜棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "护甲",
		},
		[47] = {
			["OnThis"] = "披风",
			["Description"] = "Permanently enchant a cloak to give 30 additional armor.",
			["Reagents"] = {
				[1] = {
					["Name"] = "小块闪光碎片",
					["Count"] = 1,
				},
				[2] = {
					["Name"] = "灵魂之尘",
					["Count"] = 3,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔披风 - 防御",
			["BonusNb"] = 30,
			["Name"] = "附魔披风",
			["Required"] = "符文金棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "护甲",
		},
		[48] = {
			["OnThis"] = "披风",
			["Description"] = "Permanently enchant a cloak to give 50 additional armor.",
			["Reagents"] = {
				[1] = {
					["Name"] = "幻象之尘",
					["Count"] = 3,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔披风 - 强效防御",
			["BonusNb"] = 50,
			["Name"] = "附魔披风",
			["Required"] = "符文真银棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "护甲",
		},
		[49] = {
			["OnThis"] = "披风",
			["Description"] = "Permanently enchant a cloak so that it increases resistance to fire by 5.",
			["Reagents"] = {
				[1] = {
					["Name"] = "火焰之油",
					["Count"] = 1,
				},
				[2] = {
					["Name"] = "次级星界精华",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔披风 - 次级火焰抗性",
			["BonusNb"] = 5,
			["Name"] = "附魔披风",
			["Required"] = "符文银棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "Fire Resistance",
		},
		[50] = {
			["OnThis"] = "披风",
			["Description"] = "Permanently enchant a cloak to give 7 Fire Resistance.",
			["Reagents"] = {
				[1] = {
					["Name"] = "次级秘法精华",
					["Count"] = 1,
				},
				[2] = {
					["Name"] = "元素火焰",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔披风 - 火焰抗性",
			["BonusNb"] = 7,
			["Name"] = "附魔披风",
			["Required"] = "符文金棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "Fire Resistance",
		},
		[51] = {
			["OnThis"] = "披风",
			["Description"] = "Permanently enchant a cloak so that it increases the resistance to all schools of magic by 1.",
			["Reagents"] = {
				[1] = {
					["Name"] = "奇异之尘",
					["Count"] = 1,
				},
				[2] = {
					["Name"] = "次级魔法精华",
					["Count"] = 2,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔披风 - 初级抗性",
			["BonusNb"] = 1,
			["Name"] = "附魔披风",
			["Required"] = "符文铜棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "抗性",
		},
		[52] = {
			["OnThis"] = "披风",
			["Description"] = "Permanently enchant a cloak to give 3 to all resistances.",
			["Reagents"] = {
				[1] = {
					["Name"] = "次级虚空精华",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔披风 - 抗性",
			["BonusNb"] = 3,
			["Name"] = "附魔披风",
			["Required"] = "符文真银棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "抗性",
		},
		[53] = {
			["OnThis"] = "手套",
			["Description"] = "Permanently enchant gloves to grant +5 Agility.",
			["Reagents"] = {
				[1] = {
					["Name"] = "次级虚空精华",
					["Count"] = 1,
				},
				[2] = {
					["Name"] = "幻象之尘",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔手套 - 敏捷",
			["BonusNb"] = 5,
			["Name"] = "附魔手套",
			["Required"] = "符文真银棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "敏捷",
		},
		[54] = {
			["OnThis"] = "手套",
			["Description"] = "Permanently enchant gloves to grant a +1% attack speed bonus.",
			["Reagents"] = {
				[1] = {
					["Name"] = "大块强光碎片",
					["Count"] = 2,
				},
				[2] = {
					["Name"] = "野葡萄藤",
					["Count"] = 2,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔手套 - 初级加速",
			["BonusNb"] = "1%",
			["Name"] = "附魔手套",
			["Required"] = "符文真银棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "加速",
		},
		[55] = {
			["OnThis"] = "手套",
			["Description"] = "Permanently enchant gloves to grant +2 fishing skill.",
			["Reagents"] = {
				[1] = {
					["Name"] = "灵魂之尘",
					["Count"] = 1,
				},
				[2] = {
					["Name"] = "黑口鱼油",
					["Count"] = 3,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔手套 - 钓鱼",
			["BonusNb"] = 2,
			["Name"] = "附魔手套",
			["Required"] = "符文银棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "钓鱼",
		},
		[56] = {
			["OnThis"] = "手套",
			["Description"] = "Permanently enchant gloves to grant +2 mining skill.",
			["Reagents"] = {
				[1] = {
					["Name"] = "灵魂之尘",
					["Count"] = 1,
				},
				[2] = {
					["Name"] = "Iron Ore",
					["Count"] = 3,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔手套 - 采矿",
			["BonusNb"] = 2,
			["Name"] = "附魔手套",
			["Required"] = "符文银棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "采矿",
		},
		[57] = {
			["OnThis"] = "手套",
			["Description"] = "Permanently enchant gloves to grant +5 mining skill.",
			["Reagents"] = {
				[1] = {
					["Name"] = "幻象之尘",
					["Count"] = 3,
				},
				[2] = {
					["Name"] = "真银锭",
					["Count"] = 3,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔手套 - 高级采矿",
			["Name"] = "附魔手套",
			["Required"] = "符文真银棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "采矿",
		},
		[58] = {
			["OnThis"] = "手套",
			["Description"] = "Permanently enchant gloves to grant +5 skinning skill.",
			["Reagents"] = {
				[1] = {
					["Name"] = "幻象之尘",
					["Count"] = 1,
				},
				[2] = {
					["Name"] = "绿色幼龙鳞片",
					["Count"] = 3,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔手套 - 剥皮",
			["BonusNb"] = 5,
			["Name"] = "附魔手套",
			["Required"] = "符文金棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "剥皮",
		},
		[59] = {
			["OnThis"] = "手套",
			["Description"] = "Permanently enchant gloves to grant +5 Strength.",
			["Reagents"] = {
				[1] = {
					["Name"] = "次级虚空精华",
					["Count"] = 2,
				},
				[2] = {
					["Name"] = "幻象之尘",
					["Count"] = 3,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔手套 - 力量",
			["BonusNb"] = 5,
			["Name"] = "附魔手套",
			["Required"] = "符文真银棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "力量",
		},
		[60] = {
			["OnThis"] = "盾牌",
			["Description"] = "Permanently enchant a shield to increase its armor by 30.",
			["Reagents"] = {
				[1] = {
					["Name"] = "次级星界精华",
					["Count"] = 1,
				},
				[2] = {
					["Name"] = "奇异之尘",
					["Count"] = 1,
				},
				[3] = {
					["Name"] = "小块微光碎片",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔盾牌 - 次级防护",
			["BonusNb"] = 30,
			["Name"] = "附魔盾牌",
			["Required"] = "符文银棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "护甲",
		},
		[61] = {
			["OnThis"] = "盾牌",
			["Description"] = "Permanently enchant a shield to give +8 Frost Resistance.",
			["Reagents"] = {
				[1] = {
					["Name"] = "大块强光碎片",
					["Count"] = 1,
				},
				[2] = {
					["Name"] = "Frost Oil",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔盾牌 - 冰霜抗性",
			["BonusNb"] = 8,
			["Name"] = "附魔盾牌",
			["Required"] = "符文真银棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "冰霜抗性",
		},
		[62] = {
			["OnThis"] = "盾牌",
			["Description"] = "Permanently enchant a shield to give 3 spirit.",
			["Reagents"] = {
				[1] = {
					["Name"] = "次级星界精华",
					["Count"] = 2,
				},
				[2] = {
					["Name"] = "奇异之尘",
					["Count"] = 4,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔盾牌 - 次级精神",
			["BonusNb"] = 3,
			["Name"] = "附魔盾牌",
			["Required"] = "符文银棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "精神",
		},
		[63] = {
			["OnThis"] = "盾牌",
			["Description"] = "Permanently enchant a shield to give 5 Spirit.",
			["Reagents"] = {
				[1] = {
					["Name"] = "强效秘法精华",
					["Count"] = 1,
				},
				[2] = {
					["Name"] = "幻象之尘",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔盾牌 - 精神",
			["BonusNb"] = 5,
			["Name"] = "附魔盾牌",
			["Required"] = "符文金棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "精神",
		},
		[64] = {
			["OnThis"] = "盾牌",
			["Description"] = "Permanently enchant a shield to give +7 Spirit.",
			["Reagents"] = {
				[1] = {
					["Name"] = "强效虚空精华",
					["Count"] = 1,
				},
				[2] = {
					["Name"] = "梦境之尘",
					["Count"] = 2,
				},
				["Etat"] = -2,
			},
			["LongName"] = "附魔盾牌 - 强效精神",
			["BonusNb"] = 7,
			["Name"] = "附魔盾牌",
			["Required"] = "符文真银棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "精神",
		},
		[65] = {
			["OnThis"] = "盾牌",
			["Required"] = "符文铜棒",
			["LongName"] = "附魔盾牌 - 初级耐力",
			["BonusNb"] = 1,
			["Name"] = "附魔盾牌",
			["Reagents"] = {
				[1] = {
					["Name"] = "次级星界精华",
					["Count"] = 1,
				},
				[2] = {
					["Name"] = "奇异之尘",
					["Count"] = 2,
				},
				["Etat"] = -2,
			},
			["Description"] = "Permanently enchant a shield so that it increases the Stamina of the bearer by 1.",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "耐力",
		},
		[66] = {
			["OnThis"] = "盾牌",
			["Required"] = "符文金棒",
			["LongName"] = "附魔盾牌 - 次级耐力",
			["BonusNb"] = 3,
			["Name"] = "附魔盾牌",
			["Reagents"] = {
				[1] = {
					["Name"] = "次级秘法精华",
					["Count"] = 1,
				},
				[2] = {
					["Name"] = "灵魂之尘",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["Description"] = "Permanently enchant a shield to give 3 Stamina.",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "耐力",
		},
		[67] = {
			["OnThis"] = "盾牌",
			["Required"] = "符文真银棒",
			["LongName"] = "附魔盾牌 - 耐力",
			["BonusNb"] = 5,
			["Name"] = "附魔盾牌",
			["Reagents"] = {
				[1] = {
					["Name"] = "幻象之尘",
					["Count"] = 5,
				},
				["Etat"] = -2,
			},
			["Description"] = "Permanently enchant a shield to give +5 Stamina.",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "耐力",
		},
		[68] = {
			["OnThis"] = "手套",
			["Required"] = "符文真银棒",
			["LongName"] = "附魔手套 - 强效敏捷",
			["BonusNb"] = 7,
			["Name"] = "附魔手套",
			["Reagents"] = {
				[1] = {
					["Name"] = "次级不灭精华",
					["Count"] = 3,
				},
				[2] = {
					["Name"] = "幻影之尘",
					["Count"] = 3,
				},
				["Etat"] = -2,
			},
			["Description"] = "Permanently enchant gloves to grant +7 Agility.",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Bonus"] = "敏捷",
		},
		[69] = {
			["OnThis"] = "魔油",
			["Description"] = "制造次级法力之油.",
			["Link"] = "|cffffffff|Henchant:25127|h[次级法力之油]|h|r",
			["Price"] = 21600,
			["IdOriginal"] = 109,
			["LongName"] = "次级法力之油",
			["PriceNoBenef"] = 18757,
			["Name"] = "次级法力之油",
			["TypePrice"] = 1,
			["IsKnow"] = true,
			["Required"] = "符文真银棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Reagents"] = {
				[1] = {
					["Name"] = "梦境之尘",
					["Count"] = 3,
				},
				[2] = {
					["Name"] = "紫莲花",
					["Count"] = 2,
				},
				[3] = {
					["Name"] = "水晶瓶",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["Bonus"] = "+8 mana",
		},
		[70] = {
			["OnThis"] = "魔油",
			["Description"] = "制造次级巫师之油.",
			["Link"] = "|cffffffff|Henchant:25126|h[次级巫师之油]|h|r",
			["Price"] = 6055,
			["IdOriginal"] = 111,
			["LongName"] = "次级巫师之油",
			["PriceNoBenef"] = 5266,
			["Name"] = "次级巫师之油",
			["TypePrice"] = -1,
			["IsKnow"] = true,
			["Required"] = "符文金棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Reagents"] = {
				[1] = {
					["Name"] = "幻象之尘",
					["Count"] = 3,
				},
				[2] = {
					["Name"] = "荆棘种子",
					["Count"] = 2,
				},
				[3] = {
					["Name"] = "铅瓶",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["Bonus"] = "+16 spell dmg",
		},
		[71] = {
			["OnThis"] = "魔油",
			["Description"] = "制造初级法力之油.",
			["Link"] = "|cffffffff|Henchant:25125|h[初级法力之油]|h|r",
			["Price"] = 3903,
			["IdOriginal"] = 112,
			["LongName"] = "初级法力之油",
			["PriceNoBenef"] = 3394,
			["Name"] = "初级法力之油",
			["TypePrice"] = -1,
			["IsKnow"] = true,
			["Required"] = "符文银棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Reagents"] = {
				[1] = {
					["Name"] = "灵魂之尘",
					["Count"] = 3,
				},
				[2] = {
					["Name"] = "枫树种子",
					["Count"] = 2,
				},
				[3] = {
					["Name"] = "铅瓶",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["Bonus"] = "+4 mana",
		},
		[72] = {
			["OnThis"] = "魔油",
			["Description"] = "制造初级巫师之油.",
			["Link"] = "|cffffffff|Henchant:25124|h[初级巫师之油]|h|r",
			["Price"] = 892,
			["IdOriginal"] = 113,
			["LongName"] = "初级巫师之油",
			["PriceNoBenef"] = 776,
			["Name"] = "初级巫师之油",
			["TypePrice"] = -1,
			["IsKnow"] = true,
			["Required"] = "符文铜棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Reagents"] = {
				[1] = {
					["Name"] = "奇异之尘",
					["Count"] = 2,
				},
				[2] = {
					["Name"] = "枫树种子",
					["Count"] = 1,
				},
				[3] = {
					["Name"] = "空瓶",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["Bonus"] = "+8 spell dmg",
		},
		[73] = {
			["OnThis"] = "魔油",
			["Description"] = "制造巫师之油.",
			["Link"] = "|cffffffff|Henchant:25128|h[巫师之油]|h|r",
			["Price"] = 36700,
			["IdOriginal"] = 23,
			["LongName"] = "巫师之油",
			["PriceNoBenef"] = 31835,
			["Name"] = "巫师之油",
			["TypePrice"] = 1,
			["IsKnow"] = true,
			["Required"] = "符文真银棒",
			["Icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
			["Reagents"] = {
				[1] = {
					["Name"] = "幻象之尘",
					["Count"] = 3,
				},
				[2] = {
					["Name"] = "火焰花",
					["Count"] = 2,
				},
				[3] = {
					["Name"] = "水晶瓶",
					["Count"] = 1,
				},
				["Etat"] = -2,
			},
			["Bonus"] = "+24 spell dmg",
		},
	}
};
end