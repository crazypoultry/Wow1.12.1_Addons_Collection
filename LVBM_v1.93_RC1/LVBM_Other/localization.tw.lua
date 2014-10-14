if (GetLocale() == "zhTW") then

-- LVOnyxia
LVBM_ONYXIA_NAME            = "奧妮克希亞";
LVBM_ONYXIA_INFO            = "深呼吸警報";
LVBM_ONYXIA_BREATH_EMOTE    = "深深地吸了一口氣";
LVBM_ONYXIA_BREATH_ANNOUNCE = "*** 奧妮克希亞深呼吸即將出現，向邊緣散開！ ***";
LVBM_ONYXIA_PHASE2_YELL     = "從上空";
LVBM_ONYXIA_PHASE2_ANNOUNCE = "*** 奧妮克希亞進入第二階段 ***";
LVBM_ONYXIA_PHASE3_YELL     = "看起來需要再給你一次教訓";
LVBM_ONYXIA_PHASE3_ANNOUNCE = "*** 奧妮克希亞進入第三階段 ***";

-- LVLordKazzak
LVBM_KAZZAK_NAME            = "卡扎克";
LVBM_KAZZAK_INFO            = "無敵模式倒數計時/擊殺所需時間";
LVBM_KAZZAK_START_YELL      = "為了軍團！為了基爾加德！";
LVBM_KAZZAK_BAR_TEXT        = "無敵模式";
LVBM_KAZZAK_DIES            = "卡扎克死亡了。";
LVBM_KAZZAK_ANNOUNCE_START  = "*** 3 分鐘後進入無敵模式 ***";
LVBM_KAZZAK_ANNOUNCE_TIMENEEDED = "*** %d 秒後擊殺卡扎克 ***";
LVBM_KAZZAK_ANNOUNCE_SEC        = "*** %d 秒後進入無敵模式 ***";

-- LVAzuregos
LVBM_AZUREGOS_NAME                  = "艾索雷葛斯";
LVBM_AZUREGOS_INFO                  = "艾索雷葛斯的傳送以及魔法護盾警告。";
LVBM_AZUREGOS_SHIELDUP_EXPR         = "艾索雷葛斯獲得了反射。";
LVBM_AZUREGOS_SHIELDUP_ANNOUNCE     = "*** 魔法反射 - 所有法係停止攻擊 ***";
LVBM_AZUREGOS_SHIELDDOWN_EXPR       = "反射效果從艾索雷葛斯身上消失。";
LVBM_AZUREGOS_SHIELDDOWN_ANNOUNCE   = "*** 魔法反射消失 - 法係恢復施法攻擊 ***";
LVBM_AZUREGOS_PORT_EXPR             = "來吧，小子。面對我！"
LVBM_AZUREGOS_PORT_ANNOUNCE         = "*** 傳送 ***";

-- LVBattleGrounds
	-- MIX
LVBM_BGMOD_LANG = {}
LVBM_BGMOD_LANG["NAME"] 		= "戰場";
LVBM_BGMOD_LANG["INFO"] 		= "顯示計時條為奧特蘭克山谷及阿拉希盆地旗幟佔領倒數計時. "
					.."顯示戰歌旗幟持有者以及在奧特蘭克山谷自動繳交物資.";
LVBM_BGMOD_LANG["THANKS"] 		= "感謝你使用 La Vendetta BossMods, 快樂的 PvP 吧";
LVBM_BGMOD_LANG["WINS"]			= "(%w+)勝利了！";
LVBM_BGMOD_LANG["BEGINS"]		= "即將開始";	-- BAR
LVBM_BGMOD_LANG["ALLIANCE"]		= "聯盟";
LVBM_BGMOD_LANG["HORDE"]		= "部落";
LVBM_BGMOD_LANG["ALLI_TAKE_ANNOUNCE"] 	= "*** 聯盟佔領了 %s ***";
LVBM_BGMOD_LANG["HORDE_TAKE_ANNOUNCE"]	= "*** 部落佔領了 %s ***";

		-- AV
LVBM_BGMOD_LANG["AV_ZONE"] 		= "奧特蘭克山谷";
LVBM_BGMOD_LANG["AV_START60SEC"]	= "奧特蘭克山谷1分鐘後開始戰鬥。";
LVBM_BGMOD_LANG["AV_START30SEC"]	= "奧特蘭克山谷30秒後開始戰鬥。";
LVBM_BGMOD_LANG["AV_TURNININFO"] 	= "自動繳交聲望物品";
LVBM_BGMOD_LANG["AV_NPC"] = {}
LVBM_BGMOD_LANG["AV_NPC"]["SMITHREGZAR"] 			= "鐵匠雷格薩";			-- armor
LVBM_BGMOD_LANG["AV_NPC"]["PRIMALISTTHURLOGA"] 			= "指揮官瑟魯加";			-- icelord
LVBM_BGMOD_LANG["AV_NPC"]["WINGCOMMANDERJEZTOR"] 		= "空軍指揮官傑斯托";		
LVBM_BGMOD_LANG["AV_NPC"]["WINGCOMMANDERGUSE"] 			= "空軍指揮官古斯";
LVBM_BGMOD_LANG["AV_NPC"]["WINGCOMMANDERMULVERICK"]	 	= "空軍指揮官穆維里克";
LVBM_BGMOD_LANG["AV_NPC"]["MURGOTDEEPFORGE"] 			= "莫高特‧深爐";			-- armor
LVBM_BGMOD_LANG["AV_NPC"]["ARCHDRUIDRENFERAL"] 			= "大德魯伊雷弗拉爾";		-- forestlord
LVBM_BGMOD_LANG["AV_NPC"]["WINGCOMMANDERVIPORE"] 		= "空軍指揮官維波里";
LVBM_BGMOD_LANG["AV_NPC"]["WINDCOMMANDERSLIDORE"]	 	= "空軍指揮官斯里多爾";
LVBM_BGMOD_LANG["AV_NPC"]["WINGCOMMANDERICHMAN"] 		= "空軍指揮官艾克曼";
LVBM_BGMOD_LANG["AV_NPC"]["STORMPIKERAMRIDERCOMMANDER"]		= "雷矛山羊騎兵指揮官";
LVBM_BGMOD_LANG["AV_NPC"]["FROSTWOLFWOLFRIDERCOMMANDER"]	= "霜狼騎兵指揮官";
LVBM_BGMOD_LANG["AV_ITEM"] = {}
LVBM_BGMOD_LANG["AV_ITEM"]["ARMORSCRAPS"] 	    = "護甲碎片";
LVBM_BGMOD_LANG["AV_ITEM"]["SOLDIERSBLOOD"] 	= "聯盟士兵的血";
LVBM_BGMOD_LANG["AV_ITEM"]["LIEUTENANTSFLESH"] 	= "聯盟士官的食物";
LVBM_BGMOD_LANG["AV_ITEM"]["SOLDIERSFLESH"] 	= "聯盟士兵的食物";
LVBM_BGMOD_LANG["AV_ITEM"]["COMMANDERSFLESH"] 	= "聯盟指揮官的食物";
LVBM_BGMOD_LANG["AV_ITEM"]["STORMCRYSTAL"]    	= "風暴水晶";
LVBM_BGMOD_LANG["AV_ITEM"]["LIEUTENANTSMEDAL"] 	= "部落士官的勳章";
LVBM_BGMOD_LANG["AV_ITEM"]["SOLDIERSMEDAL"] 	= "部落士兵的勳章";
LVBM_BGMOD_LANG["AV_ITEM"]["COMMANDERSMEDAL"] 	= "部落指揮官的勳章";
LVBM_BGMOD_LANG["AV_ITEM"]["FROSTWOLFHIDE"] 	= "霜狼毛皮";
LVBM_BGMOD_LANG["AV_ITEM"]["ALTERACRAMHIDE"] 	= "奧特蘭克山羊皮";
LVBM_BGMOD_LANG["AV_TARGETS"] = {
        "雷矛急救站",
        "丹巴達爾北部碉堡",
        "丹巴達爾南部碉堡",
        "雷矛墓地",
        "冰翼碉堡",
        "石爐墓地",
        "石爐碉堡",
        "落雪墓地",
        "冰血哨塔",
        "冰血墓地",
        "哨塔高地",
        "霜狼墓地",
        "西部霜狼哨塔",
        "東部霜狼哨塔",
        "霜狼急救站"
	};
LVBM_BGMOD_LANG["AV_UNDERATTACK"]	= "(.+) is under attack!  If left unchecked, the (%w+) will (%w+) it!";	-- Graveyard // Tower
LVBM_BGMOD_LANG["AV_WASTAKENBY"]	= "(.+) was taken by the (%w+)!";
LVBM_BGMOD_LANG["AV_WASDESTROYED"]	= "(.+) was destroyed by the (%w+)!";
LVBM_BGMOD_LANG["AV_IVUS"]		= "Wicked, Wicked, Mortals! The forest weeps";
LVBM_BGMOD_LANG["AV_ICEY"]		= "WHO DARES SUMMON LOKHOLAR";

		-- AB
LVBM_BGMOD_LANG["AB_ZONE"] 		    = "阿拉希盆地";
LVBM_BGMOD_LANG["AB_START60SEC"]	= "阿拉希盆地的戰鬥將在1分鐘後開始。";
LVBM_BGMOD_LANG["AB_START30SEC"]	= "阿拉希盆地的戰鬥將在30秒後開始。";
LVBM_BGMOD_LANG["AB_CLAIMSTHE"]	    = "(.+)突襲了(%w+)！如果沒有其他人採取行動的話,，(.+)將在一分鐘內控制它！";
LVBM_BGMOD_LANG["AB_HASTAKENTHE"]	= "(%w+)奪取了(%w+)！";
LVBM_BGMOD_LANG["AB_HASDEFENDEDTHE"]    = "(%w+)守住了(%w+)！";
LVBM_BGMOD_LANG["AB_HASASSAULTED"]	= "攻佔了";
LVBM_BGMOD_LANG["AB_SCOREEXP"] 		= "基地： (%d+)  資源： (%d+)/2000";
LVBM_BGMOD_LANG["AB_WINALLY"] 		= "聯盟勝利還有：";
LVBM_BGMOD_LANG["AB_WINHORDE"] 		= "部落勝利還有：";
LVBM_BGMOD_LANG["AB_TARGETS"] 		= {
        "農場",
        "伐木場",
        "鐵匠舖",
        "礦坑",
        "獸欄"
	};

		-- WSG
LVBM_BGMOD_LANG["WSG_ZONE"] 		= "戰歌峽谷";
LVBM_BGMOD_LANG["WSG_START60SEC"]	= "戰歌峽谷戰鬥將在1分鐘內開始。";
LVBM_BGMOD_LANG["WSG_START30SEC"]	= "戰歌峽谷戰鬥將在30秒鐘內開始。做好準備！";
LVBM_BGMOD_LANG["WSG_INFOFRAME_INFO"]	= "在戰歌峽谷中顯示搶奪旗幟視窗";
LVBM_BGMOD_LANG["WSG_FLAG_PICKUP"] 	= "(%w+)的旗幟被(.+)丟掉了！";			-- . because the F is not allways large char 
LVBM_BGMOD_LANG["WSG_FLAG_RETURN"]	= "(%w+)的旗幟被(.+)還到了它的基地！";
LVBM_BGMOD_LANG["WSG_ALLYFLAG"]		= "聯盟旗幟： ";
LVBM_BGMOD_LANG["WSG_HORDEFLAG"]	= "部落旗幟： ";
LVBM_BGMOD_LANG["WSG_FLAG_BASE"]	= "基地";
LVBM_BGMOD_LANG["WSG_HASCAPTURED"]	= "(.+)佔據了(%w+)的旗幟！";

		-- NEW Added 08.11.06
LVBM_BGMOD_LANG["WSG_INFOFRAME_TITLE"]	= "戰歌旗幟所在";
LVBM_BGMOD_LANG["WSG_INFOFRAME_TEXT"]	= "顯示旗幟持有者";
LVBM_BGMOD_LANG["AB_STRINGALLIANCE"]	= "聯盟:";
LVBM_BGMOD_LANG["AB_STRINGHORDE"]	= "部落:";
LVBM_BGMOD_LANG["WSG_BOOTS_EXPR"]	= "afflicted by Speed";



LVBM_BGMOD_EN_TARGET_AV = LVBM_BGMOD_LANG.AV_TARGETS;
LVBM_BGMOD_EN_TARGET_AB = LVBM_BGMOD_LANG.AB_TARGETS;

-- LVBM_SBT["Alliance: Lumber mill"] = "聯盟: 伐木場";
-- LVBM_SBT["Horde: Lumber mill"] = "部落: 伐木場";
-- LVBM_SBT["Flag respawn"] = "";
-- LVBM_SBT["Ivus spawn"] = "";
-- LVBM_SBT["Ice spawn"] = "";
LVBM_SBT["Begins"] = LVBM_BGMOD_LANG["BEGINS"];
LVBM_SBT["AB_WINHORDE"] = LVBM_BGMOD_LANG.AB_WINHORDE;
LVBM_SBT["AB_WINALLY"] = LVBM_BGMOD_LANG.AB_WINALLY;


--Outdoor Dragons
LVBM_OUTDOOR_NAME       = "雷索, 泰拉爾, 艾莫莉絲及伊索德雷";
LVBM_OUTDOOR_DESCRIPTION    = "對毒性吐息以及艾莫莉絲的快速傳染發出警報.";
LVBM_OUTDOOR_YSONDRE    = "伊索德雷";
LVBM_OUTDOOR_EMERISS    = "艾莫莉絲";
LVBM_OUTDOOR_TAERAR     = "泰拉爾";
LVBM_OUTDOOR_LETHON     = "雷索";

LVBM_OUTDOOR_BREATH_NOW     = "*** 毒性吐息 - 30 秒後再次發動 ***";
LVBM_OUTDOOR_BREATH_WARNING = "*** %s 秒內發動毒性吐息 ***";
LVBM_OUTDOOR_INFECT_WARN    = "*** %s 中了快速傳染 ***";
LVBM_OUTDOOR_INFECT_SPECIAL = "你中了快速傳染！";

LVBM_OUTDOOR_NOX_BREATH     = "^(.+)受到(.*)毒性吐息";
LVBM_OUTDOOR_NOX_RESIST     = "^(.+)毒性吐息被(.*)抵抗了。";
LVBM_OUTDOOR_INFECTION      = "^(.+)受到(.*)快速傳染";

LVBM_OUTDOOR_LOCATION_1     = LVBM_DUSKWOOD;
LVBM_OUTDOOR_LOCATION_2     = LVBM_ASHENVALE;
LVBM_OUTDOOR_LOCATION_3     = LVBM_FERALAS;
LVBM_OUTDOOR_LOCATION_4     = LVBM_HINTERLANDS;

--Runecloth
LVBM_RUNECLOTH_NAME         = "符文布";
LVBM_RUNECLOTH_DESCRIPTION  = "允許自動繳交符文布.";
LVBM_RAEDONDUSKSTRIKER      = "萊頓·暗影";
LVBM_CLAVICUSKNAVINGHAM     = "克拉維斯·納文哈姆";
LVBM_BUBULOACERBUS          = "巴巴羅·阿克巴斯";
LVBM_MISTINASTEELSHIELD     = "米斯蒂娜·鋼盾";
LVBM_RUNECLOTH_THANKS       = "感謝您使用 La Vendetta Boss Mods!" 

end
