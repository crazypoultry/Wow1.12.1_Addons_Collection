-- -------------------------------------------- --
-- La Vendetta Boss Mods - Chinese localization --
--       by Diablohu<白银之手>@轻风之语         --
--             www.dreamgen.net                 --
--                11/14/2006                    --
-- -------------------------------------------- --

if (GetLocale() == "zhCN") then

-- LVOnyxia
	LVBM_ONYXIA_NAME				= "奥妮克希亚";
	LVBM_ONYXIA_INFO				= "警报深呼吸";
	LVBM_ONYXIA_BREATH_EMOTE 		= "%s深深地吸了一口气……";
	LVBM_ONYXIA_BREATH_ANNOUNCE		= "*** 深呼吸 ***"
	LVBM_ONYXIA_PHASE2_YELL			= "这些毫无意义的行动叫我很厌烦。我会在上空中把你们都烧成灰！";
	LVBM_ONYXIA_PHASE2_ANNOUNCE		= "*** 第二阶段 ***"
	LVBM_ONYXIA_PHASE3_YELL			= "看来需要再给你一次教训，凡人！";
	LVBM_ONYXIA_PHASE3_ANNOUNCE		= "*** 第三阶段 ***"


-- LVLordKazzak
	LVBM_KAZZAK_NAME				= "卡扎克";
	LVBM_KAZZAK_INFO				= "警报上帝模式剩余时间";
	LVBM_KAZZAK_START_YELL			= "为了军团！为了基尔加丹！";
	LVBM_KAZZAK_NAME				= "卡扎克";
	LVBM_KAZZAK_BAR_TEXT			= "上帝模式";
	LVBM_KAZZAK_DIES				= "卡扎克死亡了。";
	LVBM_KAZZAK_ANNOUNCE_START		= "*** 3分钟后卡扎克进入上帝模式 ***";
	LVBM_KAZZAK_ANNOUNCE_TIMENEEDED = "*** %d秒内干掉它！ ***";
	LVBM_KAZZAK_ANNOUNCE_SEC		= "*** %d秒后卡扎克进入上帝模式 ***";


-- LVAzuregos
	LVBM_AZUREGOS_NAME					= "艾索雷葛斯";
	LVBM_AZUREGOS_INFO					= "警报传送和魔法反射";
	LVBM_AZUREGOS_SHIELDUP_EXPR			= "艾索雷葛斯获得了反射的效果。";
	LVBM_AZUREGOS_SHIELDUP_ANNOUNCE		= "*** 魔法反射 - 停止对其施法 ***";
	LVBM_AZUREGOS_SHIELDDOWN_EXPR 		= "反射效果从艾索雷葛斯身上消失。";
	LVBM_AZUREGOS_SHIELDDOWN_ANNOUNCE	= "*** 魔法反射消失 ***";
	LVBM_AZUREGOS_PORT_EXPR 			= "来吧，小家伙们。面对我！"
	LVBM_AZUREGOS_PORT_ANNOUNCE			= "*** 传送 ***";


-- LVBattleGrounds
	-- MIX
	LVBM_BGMOD_LANG = {}
	LVBM_BGMOD_LANG["NAME"] 				= "战场";
	LVBM_BGMOD_LANG["INFO"] 				= "显示阿拉希盆地和奥特兰克山谷的旗帜信息，"
								.."显示战歌峡谷的旗帜携带者，并可自动上交奥特兰克山谷声望物品";
	LVBM_BGMOD_LANG["THANKS"] 				= "感谢您使用 La Vendetta BossMods, 享受 PvP";
	LVBM_BGMOD_LANG["WINS"]					= "([^%s]+)获胜";
	LVBM_BGMOD_LANG["BEGINS"]				= "战斗即将开始";	-- BAR
	LVBM_BGMOD_LANG["ALLIANCE"]				= "联盟";
	LVBM_BGMOD_LANG["HORDE"]				= "部落";
	LVBM_BGMOD_LANG["ALLI_TAKE_ANNOUNCE"] 	= "*** 联盟夺取了%s ***";
	LVBM_BGMOD_LANG["HORDE_TAKE_ANNOUNCE"]	= "*** 部落夺取了%s ***";
	
	-- AV
	LVBM_BGMOD_LANG["AV_ZONE"] 			= "奥特兰克山谷";
	LVBM_BGMOD_LANG["AV_START60SEC"]	= "奥特兰克山谷的战斗将在1分钟之后开始。";
	LVBM_BGMOD_LANG["AV_START30SEC"]	= "奥特兰克山谷的战斗将在30秒之后开始。";
	LVBM_BGMOD_LANG["AV_TURNININFO"] 	= "自动上交声望物品";
	LVBM_BGMOD_LANG["AV_NPC"] = {
			["SMITHREGZAR"] 				= "铁匠雷格萨",			-- armor
			["PRIMALISTTHURLOGA"] 			= "指挥官瑟鲁加",		-- icelord
			["WINGCOMMANDERJEZTOR"] 		= "空军指挥官杰斯托",		
			["WINGCOMMANDERGUSE"] 			= "空军指挥官古斯",
			["WINGCOMMANDERMULVERICK"] 		= "空军指挥官穆维里克",
			["MURGOTDEEPFORGE"] 			= "莫高特·深炉",		-- armor
			["ARCHDRUIDRENFERAL"] 			= "大德鲁伊雷弗拉尔",	-- forestlord
			["WINGCOMMANDERVIPORE"] 		= "空军指挥官维波里",
			["WINDCOMMANDERSLIDORE"] 		= "空军指挥官斯里多尔",
			["WINGCOMMANDERICHMAN"] 		= "空军指挥官艾克曼",
			["STORMPIKERAMRIDERCOMMANDER"]	= "雷矛山羊骑兵指挥官",
			["FROSTWOLFWOLFRIDERCOMMANDER"]	= "霜狼骑兵指挥官",
		};
	LVBM_BGMOD_LANG["AV_ITEM"] = {
			["ARMORSCRAPS"] 		= "护甲碎片",
			["SOLDIERSBLOOD"] 		= "联盟士兵的血",
			["LIEUTENANTSFLESH"] 	= "联盟士官的食物",
			["SOLDIERSFLESH"] 		= "联盟士兵的食物",
			["COMMANDERSFLESH"] 	= "联盟指挥官的食物",
			["STORMCRYSTAL"] 		= "风暴水晶",
			["LIEUTENANTSMEDAL"] 	= "部落士官的勋章",
			["SOLDIERSMEDAL"] 		= "部落士兵的勋章",
			["COMMANDERSMEDAL"] 	= "部落指挥官的勋章",
			["FROSTWOLFHIDE"]		= "霜狼毛皮",
			["ALTERACRAMHIDE"] 		= "奥特兰克山羊皮",
		};
	LVBM_BGMOD_LANG["AV_TARGETS"] = {
			"雷矛急救站",
			"丹巴达尔北部碉堡",
			"丹巴达尔南部碉堡",
			"雷矛墓地",
			"冰翼碉堡",
			"石炉墓地",
			"石炉碉堡",
			"落雪墓地",
			"冰血哨塔",
			"冰血墓地",
			"哨塔高地",
			"霜狼墓地",
			"西部霜狼哨塔",
			"东部霜狼哨塔",
			"霜狼急救站"
		};
	LVBM_BGMOD_LANG["AV_UNDERATTACK"]	= "([^%s]+)受到攻击！如果我们不尽快采取措施，([^%s]+)会([^%s]+)它的！";	-- Graveyard // Tower
	LVBM_BGMOD_LANG["AV_WASTAKENBY"]	= "([^%s]+)被([^%s]+)占领了！";
	LVBM_BGMOD_LANG["AV_WASDESTROYED"]	= "([^%s]+)被([^%s]+)摧毁了！";
	LVBM_BGMOD_LANG["AV_IVUS"]			= "Wicked, Wicked, Mortals! The forest weeps";
	LVBM_BGMOD_LANG["AV_ICEY"]			= "WHO DARES SUMMON LOKHOLAR";
	
	-- AB
	LVBM_BGMOD_LANG["AB_ZONE"] 				= "阿拉希盆地";
	LVBM_BGMOD_LANG["AB_START60SEC"]		= "阿拉希盆地的战斗将在1分钟后开始。";
	LVBM_BGMOD_LANG["AB_START30SEC"]		= "阿拉希盆地的战斗将在30秒后开始。";
	LVBM_BGMOD_LANG["AB_CLAIMSTHE"]			= "([^%s]+)攻占([^%s]+)！如果不赶快采取行动的话，([^%s]+)在1分钟内([^%s]+)它！";
	LVBM_BGMOD_LANG["AB_HASTAKENTHE"]		= "([^%s]+)夺取([^%s]+)！";
	LVBM_BGMOD_LANG["AB_HASDEFENDEDTHE"]	= "([^%s]+)守住([^%s]+)！";
	LVBM_BGMOD_LANG["AB_HASASSAULTED"]		= "突袭";
	LVBM_BGMOD_LANG["AB_SCOREEXP"] 			= "基地：(%d+)  资源：(%d+)/2000";
	LVBM_BGMOD_LANG["AB_WINALLY"] 			= "联盟即将获胜";
	LVBM_BGMOD_LANG["AB_WINHORDE"] 			= "部落即将获胜";
	LVBM_BGMOD_LANG["AB_TARGETS"] = {
			"了农场",
			"了伐木场",
			"了铁匠铺",
			"了矿洞",
			"了兽栏"
		};
	
	-- WSG
	LVBM_BGMOD_LANG["WSG_ZONE"] 			= "战歌峡谷";
	LVBM_BGMOD_LANG["WSG_START60SEC"]		= "战歌峡谷战斗将在1分钟内开始。";
	LVBM_BGMOD_LANG["WSG_START30SEC"]		= "战歌峡谷战斗将在30秒钟内开始。做好准备！";
	LVBM_BGMOD_LANG["WSG_INFOFRAME_INFO"]	= "在战歌峡谷中显示旗帜监视窗口";
	LVBM_BGMOD_LANG["WSG_FLAG_PICKUP"] 		= "([^%s]+)的旗帜被([^%s]+)拔起了！";
	LVBM_BGMOD_LANG["WSG_FLAG_RETURN"]		= "([^%s]+)的旗帜被([^%s]+)还到了它的基地中！";
	LVBM_BGMOD_LANG["WSG_ALLYFLAG"]			= "联盟旗帜: ";
	LVBM_BGMOD_LANG["WSG_HORDEFLAG"]		= "部落旗帜: ";
	LVBM_BGMOD_LANG["WSG_FLAG_BASE"]		= "基地";
	LVBM_BGMOD_LANG["WSG_HASCAPTURED"]		= "([^%s]+)夺取([^%s]+)的旗帜！";
	LVBM_BGMOD_LANG["WSG_FLAGRESPAWN"] 		= "旗帜即将刷新";

	-- NEW Added 08.11.06
	LVBM_BGMOD_LANG["WSG_INFOFRAME_TITLE"]	= "战歌峡谷旗帜监视";
	LVBM_BGMOD_LANG["WSG_INFOFRAME_TEXT"]	= "显示旗帜携带者";
	LVBM_BGMOD_LANG["AB_STRINGALLIANCE"]	= "联盟: ";
	LVBM_BGMOD_LANG["AB_STRINGHORDE"]		= "部落: ";
	LVBM_BGMOD_LANG["WSG_BOOTS_EXPR"]		= "受到了加速效果的影响。";

	LVBM_BGMOD_EN_TARGET_AV = LVBM_BGMOD_LANG.AV_TARGETS;
	LVBM_BGMOD_EN_TARGET_AB = LVBM_BGMOD_LANG.AB_TARGETS;
	
	--LVBM_SBT["Alliance: Lumber mill"] = "Alliance: Lumber Mill";
	--LVBM_SBT["Horde: Lumber mill"] = "Horde: Lumber Mill";
	--LVBM_SBT["Ivus spawn"] = LVBM_BGMOD_LANG["IVUSTXT"];
	--LVBM_SBT["Ice spawn"] = LVBM_BGMOD_LANG["ICEYTXT"];
	
	LVBM_SBT["Begins"] 			= LVBM_BGMOD_LANG.BEGINS;
	LVBM_SBT["Flag respawn"] 	= LVBM_BGMOD_LANG.WSG_FLAGRESPAWN;
	LVBM_SBT["AB_WINHORDE"] 	= LVBM_BGMOD_LANG.AB_WINHORDE;
	LVBM_SBT["AB_WINALLY"] 		= LVBM_BGMOD_LANG.AB_WINALLY;
	LVBM_SBT["Speed Boots"] 	= "加速靴效果";


--Outdoor Dragons
	LVBM_OUTDOOR_NAME			= "梦魇巨龙";
	LVBM_OUTDOOR_DESCRIPTION	= "警报毒性吐息和艾莫莉丝的快速传染";
	LVBM_OUTDOOR_YSONDRE		= "伊森德雷";
	LVBM_OUTDOOR_EMERISS		= "艾莫莉丝";
	LVBM_OUTDOOR_TAERAR			= "泰拉尔";
	LVBM_OUTDOOR_LETHON			= "莱索恩";
	
	LVBM_OUTDOOR_BREATH_NOW		= "*** 毒性吐息 - 30妙后再次施放 ***";
	LVBM_OUTDOOR_BREATH_WARNING	= "*** 毒性吐息 - %妙后施放 ***";
	LVBM_OUTDOOR_INFECT_WARN	= "*** %s受到了快速传染 ***";
	LVBM_OUTDOOR_INFECT_SPECIAL	= "你受到了快速传染！";
	
	LVBM_OUTDOOR_NOX_BREATH		= "([^%s]+)受到了毒性吐息效果的影响。";
	LVBM_OUTDOOR_NOX_RESIST		= "([^%s]+)毒性吐息被([^%s]+)抵抗了。";
	LVBM_OUTDOOR_INFECTION		= "([^%s]+)受到了快速传染效果的影响。";
	
	LVBM_OUTDOOR_LOCATION_1		= LVBM_DUSKWOOD;
	LVBM_OUTDOOR_LOCATION_2		= LVBM_ASHENVALE;
	LVBM_OUTDOOR_LOCATION_3		= LVBM_FERALAS;
	LVBM_OUTDOOR_LOCATION_4		= LVBM_HINTERLANDS;
	
	LVBM_SBT["Noxious Breath"]	= "毒性吐息";

end
