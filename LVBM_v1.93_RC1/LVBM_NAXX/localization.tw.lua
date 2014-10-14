if (GetLocale() == "zhTW") then

--Patchwerk
LVBM_PW_NAME                    = "縫補者";
LVBM_PW_DESCRIPTION             = "提供縫補者狂暴計時";
LVBM_PW_OPTION1                 = "憎恨打擊廣播";
LVBM_PW_OPTION2                 = "顯示狀態";
LVBM_PW_OPTION3                 = "顯示資訊框";

LVBM_PW_ENRAGE_WARNING          = "*** 狂暴時間剩下: %s %s ***";
LVBM_PW_HS_ANNOUNCE             = "憎恨打擊 --> %s [%s]";

LVBM_PW_YELL_1                  = "縫補者要跟你玩！";
LVBM_PW_YELL_2                  = "縫補者是科爾蘇加德的戰神！";

LVBM_PW_HS_YOU_HIT              = "縫補者的憎恨打擊擊中你造成(%d+)點傷害。";
LVBM_PW_HS_YOU_MISS             = "縫補者的憎恨打擊沒有擊中你。";
LVBM_PW_HS_YOU_DODGE            = "縫補者的憎恨打擊被閃躲過去。";
LVBM_PW_HS_YOU_PARRY            = "縫補者的憎恨打擊被招架過去。";
LVBM_PW_HS_PARTY_HIT            = "縫補者的憎恨打擊擊中(.+)造成(%d+)點傷害。";
LVBM_PW_HS_PARTY_MISS           = "縫補者的憎恨打擊沒有擊中(.+)。";
LVBM_PW_HS_PARTY_DODGE          = "縫補者的憎恨打擊擊被(.+)閃躲過去。";
LVBM_PW_HS_PARTY_PARRY          = "縫補者的憎恨打擊被(.+)招架了。";

LVBM_PWSTATS_STATS              = "*** 縫補者 攻擊狀態 ***";
LVBM_PWSTATS_STRIKES            = "憎恨打擊： %s (%.0f%%)";
LVBM_PWSTATS_HITS               = "命中:  %s (%.0f%%)";
LVBM_PWSTATS_DODGES             = "閃躲:  %s (%.0f%%)";
LVBM_PWSTATS_PARRIES            = "招架:  %s (%.0f%%)";
LVBM_PWSTATS_MISSES             = "沒有擊中:  %s (%.0f%%)";
LVBM_PWSTATS_AVG_DMG            = "每下攻擊平均傷害:  %.0f";
LVBM_PWSTATS_MAX_HIT            = "最大命中:  %s on %s";
LVBM_PWSTATS_PER_PLAYER         = "%s 憎恨打擊 on %s (%s 命中)";
LVBM_PWSTATS_NOT_AVAILABLE      = "攻擊狀態統計未被啟用";


--Grobbulus
LVBM_GROBB_NAME                 = "葛羅巴斯";
LVBM_GROBB_DESCRIPTION          = "對受注射玩家設置圖示(骷髏). 只能一人開啟 \"設置圖示\".";
LVBM_GROBB_SEND_WHISPER         = "發送密語";
LVBM_GROBB_SET_ICON             = "設置圖示";

LVBM_GROBB_YOU_ARE_INJECTED     = "你被注射!";
LVBM_GROBB_INJECTED_WARNING     = "*** %s 被注射 ***";
LVBM_GROBB_INJECTED             = "突變注射";

LVBM_GROBB_INJECTION_REGEXP         = "(.+)受到突變注射效果的影響。";
LVBM_GROBB_INJECTION_FADES_REGEXP   = "突變注射效果從(.+)身上消失。";

LVBM_GROBB_CLOUD_POISON             = "葛羅巴斯施放了毒雲術。";



--Gluth
LVBM_GLUTH_NAME                     = "古魯斯";
LVBM_GLUTH_DESCRIPTION              = "對古魯斯的恐懼, 狂暴和屠殺發出警告.";
LVBM_GLUTH_ANNOUNCE_FRENZY          = "狂暴警告";

LVBM_GLUTH_DECIMATE_WARN1           = "*** 2分鐘內施放狂暴 ***";
LVBM_GLUTH_DECIMATE_WARN2           = "*** 狂暴 - 2分鐘內施放下一次 ***";
LVBM_GLUTH_DECIMATE_1MIN_WARNING    = "*** 1分鐘內施放狂暴 ***";
LVBM_GLUTH_DECIMATE_SOON_WARNING    = "*** 即將狂暴 ***";
LVBM_GLUTH_DECIMATE_WARNING         = "*** %s 秒內發動狂暴 ***"
LVBM_GLUTH_FEAR_WARNING             = "*** 恐懼 - 20秒後下一次 ***";
LVBM_GLUTH_FEAR_5SEC_WARNING        = "*** 5秒後恐懼 ***";

LVBM_GLUTH_DECIMATE_REGEXP          = "古魯斯的殘殺擊中(.+)造成(%d+)點傷害。";
LVBM_GLUTH_FEAR_REGEXP              = "(.+)受到(.*)恐嚇咆哮的傷害";
LVBM_GLUTH_FRENZY                   = "變得狂暴起來！"
LVBM_GLUTH_FRENZY_ANNOUNCE          = "*** 狂暴 ***";
LVBM_GLUTH_GLUTH                    = "古魯斯";

LVBM_SBT["Fear"]                    = "恐懼";
LVBM_SBT["Decimate"]                = "殘殺";


--Razuvious
LVBM_IR_NAME                    = "講師拉祖維斯";
LVBM_IR_DESCRIPTION             = "提供講師混亂怒吼計時.";
LVBM_IR_SHOW_10SEC_WARNING      = "顯示 10 秒警告";

LVBM_IR_TIMER_UPDATED           = "計時器更新";
LVBM_IR_SHOUT_WARNING           = "*** %s 秒後施放混亂怒吼 ***"

LVBM_IR_SPELL_1                 = "混亂怒吼";
LVBM_IR_YELL_1                  = "練習時間到此為止！都拿出真本事來！";
LVBM_IR_YELL_2                  = "絆腿……有什麼問題嗎？";
LVBM_IR_YELL_3                  = "照我教你的做！";
LVBM_IR_YELL_4                  = "仁慈無用！";

LVBM_SBT["Disruption Shout"]    = "混亂怒吼";


--Noth the Plaguebringer
LVBM_NTP_NAME                   = "瘟疫者諾斯";
LVBM_NTP_DESCRIPTION            = "提供諾斯傳送和閃現計時.";
LVBM_NTP_OPTION_WARN_SPAWN      = "小兵警告";
LVBM_NTP_OPTION_WARN_CURSE      = "詛咒警告";

LVBM_NTP_BACK_WARNING           = "*** 諾斯回來 (%s 秒) - 攻擊 ***";
LVBM_NTP_TELEPORT_WARNING       = "*** %s 秒後傳送 ***";
LVBM_NTP_NOTH_GAINS_BLINK       = "*** 閃現 ***";
LVBM_NTP_BLINK_5SEC_WARNING     = "*** 5 秒內閃現 ***";
LVBM_NTP_BLINK_0SEC_WARNING     = "*** 閃現準備 - 停止遠程攻擊！ ***";
LVBM_NTP_TELEPORT_10SEC_WARNING = "*** 10 秒內閃現 ***"
LVBM_NTP_BACK_10SEC_WARNING     = "*** 10 秒後諾斯回來 ***";
LVBM_NTP_ADD_WARNING            = "*** 5 秒內出現小兵 ***";
LVBM_NTP_CURSE_WARNING          = "*** 詛咒！快解掉！ ***";
LVBM_NTP_NEXT_WAVE_SOON         = "*** 10 秒後下一波 ***";

LVBM_NTP_SPELL_1                = "瘟疫者諾斯獲得了閃現的效果。";
LVBM_NTP_CURSE_AFFLICT          = "瘟疫者詛咒"; -- AOE curse
LVBM_NTP_ADDS_SPAWN             = "起來吧，我的戰士們！起來，再為主人盡忠一次！"; -- Adds spawn
LVBM_NTP_YELL_START1            = "死吧，入侵者！";
LVBM_NTP_YELL_START2            = "榮耀歸於我主！";
LVBM_NTP_YELL_START3            = "我要沒收你的生命！";

LVBM_SBT["Teleport to Balcony"] = "傳送到看台";
LVBM_SBT["Teleport back"]       = "傳送回來";
LVBM_SBT["Blink"]               = "閃現術";


--Heigan the Unclean
LVBM_HTU_NAME           = "骯髒者海根";
LVBM_HTU_DESCRIPTION    = "提供海根傳送計時.";

LVBM_HTU_TELEPORT_WARNING       = "*** %s 秒後傳送 ***";
LVBM_HTU_TELEPORT_BACK_WARNING  = "*** %s 秒後傳送回來 ***";

LVBM_HTU_YELL_START1 = "你……就是下一個。";
LVBM_HTU_YELL_START2 = "我看到你了……";
LVBM_HTU_YELL_START3 = "你是我的了。";

LVBM_SBT["Teleport"]        = "傳送";
LVBM_SBT["Teleport Back"]   = "傳送回來";


--Anub'Rekhan
LVBM_AR_NAME            = "阿努比瑞克漢";
LVBM_AR_DESCRIPTION     = "當阿努比瑞克漢施放蝗蟲風暴時發出警報.";

LVBM_AR_LOCUST_WARNING      = "*** %s 秒後蝗蟲風暴 ***";
LVBM_AR_LOCUST_SOON_WARNING = "*** 蝗蟲風暴即將來臨 ***";
LVBM_AR_LOCUST_INC_WARNING  = "*** 蝗蟲風暴來臨 - 3 秒 ***";
LVBM_AR_GAIN_LOCUST_WARNING = "*** 蝗蟲風暴 - 20 秒後結束 ***";
LVBM_AR_LOCUST_END_WARNING  = "*** 蝗蟲風暴 %s 秒後結束 ***";

LVBM_AR_YELL_1 = "你們逃不掉的。";
LVBM_AR_YELL_2 = "一些小點心……";
LVBM_AR_YELL_3 = "對，跑吧！那樣傷口出血就更多了！";
LVBM_AR_CAST_LOCUST_SWARM = "阿努比瑞克漢開始施放蝗蟲風暴。";
LVBM_AR_GAIN_LOCUST_SWARM = "阿努比瑞克漢獲得了蝗蟲風暴的效果。";

LVBM_SBT["Locust Swarm"]        = "蝗蟲風暴";
LVBM_SBT["Locust Swarm Cast"]   = "施放蝗蟲風暴";


--Grand Widow Faerlina
LVBM_GWF_NAME                   = "大寡婦費琳娜";
LVBM_GWF_DESCRIPTION            = "為大寡婦費琳娜的激怒提供一個計時器";

LVBM_GWF_ENRAGE_WARNING1        = "*** 激怒 - 60 秒後下一次 ***";
LVBM_GWF_ENRAGE_WARNING2        = "*** %s 秒後激怒 ***";
LVBM_GWF_ENRAGE_CD_READY        = "*** 即將激怒 ***"
LVBM_GWF_EMBRACE_WARNING        = "*** 寡婦之擁將在 %s 秒後結束 ***"
LVBM_GWF_NEXT_ENRAGE_IN         = "*** 下一次激怒在 %s 秒內 ***";

LVBM_GWF_YELL_1                 = "休想從我面前逃掉！";
LVBM_GWF_YELL_2                 = "以主人之名，殺了他們！";
LVBM_GWF_YELL_3                 = "逃啊！有本事就逃啊！";
LVBM_GWF_YELL_4                 = "跪下求饒吧，懦夫！";
LVBM_GWF_DEBUFF                 = "大寡婦費琳娜受到寡婦之擁的傷害";
LVBM_GWF_GAIN_ENRAGE            = "大寡婦費琳娜獲得了狂怒的效果。";

--LVBM_SBT["Enrage"]              = "激怒";
LVBM_SBT["Widow's Embrace"]     = "寡婦之擁";


--Maexxna
LVBM_MAEXXNA_NAME               = "梅克絲娜";
LVBM_MAEXXNA_DESCRIPTION        = "為梅克絲娜的撒網和小蜘蛛出生提供計時器.";
LVBM_MAEXXNA_YELL_ON_WRAP       = "被蜘蛛網纏繞時大喊";

LVBM_MAEXXNA_WEB_WRAP_YELL      = "%s 被蜘蛛網纏繞. 小隊: %s.";
LVBM_MAEXXNA_WRAP_WARNING       = "*** %s 被纏繞 ***";
LVBM_MAEXXNA_SPRAY_WARNING      = "*** %s 秒後撒網 ***";
LVBM_MAEXXNA_SPIDER_WARNING     = "*** %s 秒後出現梅克絲娜之子 ***";
LVBM_MAEXXNA_SPIDERS_SPAWNED    = "*** 梅克絲娜之子出現 ***";

LVBM_MAEXXNA_WEB_SPRAY          = "撒網";
LVBM_MAEXXNA_MAEXXNA            = "梅克絲娜";
--LVBM_MAEXXNA_WEB_WRAP_REGEXP    = "(.+)受到纏繞的蜘蛛網";
LVBM_MAEXXNA_WEB_WRAP_REGEXP    = "([^%s]+)受到(.*)撒網";

LVBM_SBT["Web Spray"]       = "梅克絲娜的撒網";
LVBM_SBT["Spider Spawn"]    = "梅克絲娜之子";


--Gothik the Harvester
LVBM_GOTH_NAME          = "收割者高希";
LVBM_GOTH_DESCRIPTION   = "提供其小怪計時及死亡通告.";

LVBM_GOTH_PHASE2_WARNING        = "*** 收割者高希出現 ***";
LVBM_GOTH_PHASE2_INC_WARNING    = "*** %s %s 後進入第2階段 ***";
LVBM_GOTH_DEAD_WARNING          = "*** %s 死亡 ***";
LVBM_GOTH_INC_WARNING           = "*** %s 出現還剩 %s 秒 ***";
LVBM_GOTH_WAVE_INC_WARNING1     = "*** 3秒後 %s/18 波 - %s %s  ***";
LVBM_GOTH_WAVE_INC_WARNING2     = "*** 3秒後 %s/18 波 - %s %s 和 %s %s ***";
LVBM_GOTH_WAVE_INC_WARNING3     = "*** 3秒後 %s/18 波 - %s %s, %s %s 和 %s %s ***";

LVBM_GOTH_YELL_START1   = "你們這些蠢貨已經主動步入了陷阱。"
LVBM_GOTH_PHASE2_YELL   = "我已經等待很久了。現在你們將面對靈魂的收割者。";

LVBM_GOTH_RIDER         = "無情的騎兵";
LVBM_GOTH_RIDER_SHORT   = "騎兵";
LVBM_GOTH_KNIGHT        = "無情的死騎";
LVBM_GOTH_KNIGHT_SHORT  = "死騎";
LVBM_GOTH_KNIGHTS_SHORT = "死騎";
LVBM_GOTH_TRAINEE       = "無情的訓練師";
LVBM_GOTH_TRAINEE_SHORT = "訓練師";

-- FourHorsemen
LVBM_FOURHORSEMEN_NAME                      = "四騎士";
LVBM_FOURHORSEMEN_INFO                      = "提供四騎士的戰鬥計時條";
LVBM_FOURHORSEMEN_SHOW_5SEC_MARK_WARNING    = "顯示五秒印記警告";
LVBM_FOURHORSEMEN_THANE                     = "寇斯艾茲族長";
LVBM_FOURHORSEMEN_LADY                      = "女公爵布勞繆克絲";
LVBM_FOURHORSEMEN_MOGRAINE                  = "莫格萊尼公爵";
LVBM_FOURHORSEMEN_ZELIEK                    = "札里克爵士";
LVBM_FOURHORSEMEN_REAL_NAME                 = "四騎士";

LVBM_FOURHORSEMEN_MARK_EXPR                 = "受到了 %d 印記效果的影響。";
LVBM_FOURHORSEMEN_MARK_ANNOUNCE             = "*** %d 印記***";
LVBM_FOURHORSEMEN_MARK_WARNING              = "*** %d 印記 5秒後來臨 ***";

LVBM_FOURHORSEMEN_METEOR_EXPR               = "寇斯艾茲族長的隕石術擊中([^%s]+)造成(%d+)點火焰傷害。";
LVBM_FOURHORSEMEN_METEOR_ANNOUNCE           = "*** 隕石術 ***";

LVBM_FOURHORSEMEN_VOID_EXPR                 = "女公爵布勞繆克絲施放了虛空地區。";
LVBM_FOURHORSEMEN_VOID_ANNOUNCE             = "*** 虛空地區 ***";
LVBM_FOURHORSEMEN_VOID_WHISPER              = "你被施放了虛空地區!";

LVBM_FOURHORSEMEN_SHIELDWALL_EXPR           = "(.*)獲得了盾牆的效果。";
LVBM_FOURHORSEMEN_SHIELDWALL_ANNOUNCE       = "*** %s: 獲得20秒盾牆效果 ***";
LVBM_FOURHORSEMEN_SHIELDWALL_FADE           = "*** %s 身上的盾牆效果消失***";

LVBM_FOURHORSEMEN_WHISPER_INFO          = "當玩家進入虛空地區時密語提醒";

LVBM_FOURHORSEMEN_TAUNTRESIST_INFO		= "Inform about Taunt resists";
LVBM_FOURHORSEMEN_TAUNTRESIST_TAUNT		= "Taunt";
LVBM_FOURHORSEMEN_TAUNTRESIST_MOKING		= "Mocking Blow";
LVBM_FOURHORSEMEN_TAUNTRESIST_CSHOUT		= "Challenging Shout";
LVBM_FOURHORSEMEN_TAUNTRESIST_RESIST		= "resist";
LVBM_FOURHORSEMEN_TAUNTRESIST_PARRY		= "parry";
LVBM_FOURHORSEMEN_TAUNTRESIST_DODGE		= "dodge";
LVBM_FOURHORSEMEN_TAUNTRESIST_MISS		= "miss";
LVBM_FOURHORSEMEN_TAUNTRESIST_BLOCK		= "block";
LVBM_FOURHORSEMEN_TAUNTRESIST_SELFWARN		= "TAUNT FAILED";
LVBM_FOURHORSEMEN_TAUNTRESIST_MESSAGE		= "--> Taunt failed! <--";

--Thaddius
LVBM_THADDIUS_NAME          = "泰迪斯";
LVBM_THADDIUS_DESCRIPTION   = "提供激怒和兩極移形計時.";
LVBM_THADDIUS_WARN_NOT_CHANGED      = "極性未改變時提示";
LVBM_THADDIUS_ALT_STRATEGY      = "Alternative strategy (顯示 左/右 警告)";
LVBM_THADDIUS_WARN_POWERSURGE       = "斯塔拉格的力量澎湃警告 (200% 攻擊速度)";

LVBM_THADDIUS_ENRAGE_WARNING        = "*** %s %s 後激怒 ***";
LVBM_THADDIUS_POL_SHIFT             = "*** 兩極移形 ***";
LVBM_THADDIUS_SURGE_WARNING         = "*** 力量振蕩 ***";
LVBM_THADDIUS_POL_WARNING           = "*** %s 秒後兩極移形 ***";
LVBM_THADDIUS_PHASE_2_SOON      = "*** 4秒後進入第二階段 ***";
LVBM_THADDIUS_CHARGE_CHANGED        = "充電變為%s!";
LVBM_THADDIUS_CHARGE_NOT_CHANGED    = "充電未改變";
LVBM_THADDIUS_RIGHT         = "右！";
LVBM_THADDIUS_LEFT          = "左！";

LVBM_THADDIUS_GAINS_SURGE   = "斯塔拉格獲得了力量澎湃的效果。";
LVBM_THADDIUS_CAST_POL      = "泰迪斯開始施放極性轉化。";
LVBM_THADDIUS_POL_REGEXP    = "你受到了(%w+)電荷。";
LVBM_THADDIUS_YELL_START1   = "殺……";
LVBM_THADDIUS_YELL_START2   = "咬碎……你的……骨頭……";
LVBM_THADDIUS_YELL_START3   = "打……爛……你！";
LVBM_THADDIUS_YELL_POL      = "你感受到痛苦的滋味了吧……";
LVBM_THADDIUS_ENRAGE        = "變得極度狂暴而憤怒！";
LVBM_THADDIUS_TESLA_EMOTE       = "%s overloads!";
LVBM_THADDIUS_TESLA_COIL        = "泰斯拉·寇歐";
LVBM_THADDIUS_THADDIUS      = "泰迪斯";
LVBM_THADDIUS_POSITIVE      = "正";
LVBM_THADDIUS_NEGATIVE      = "負";

-- Phase1
LVBM_THADDIUS_PHASE1_YELL1      = "斯特拉格要輾碎你！";
LVBM_THADDIUS_PHASE1_YELL2      = "主人要吃了你！";
LVBM_THADDIUS_PHASE1_ANNOUNCE   = "*** 型態 1 ***";
LVBM_THADDIUS_SURGE_EXPR        = "斯塔拉格獲得了力量澎湃的效果。";
LVBM_THADDIUS_SURGE_ANNOUNCE    = "*** 10秒後 力量澎湃 ***";
LVBM_THADDIUS_THROW_ANNOUNCE    = "*** MT 投擲 ***";
LVBM_THADDIUS_THROW_ANNOUNCE_SOON   = "*** MT 即將在 %s 秒後被投擲 ***";
LVBM_THADDIUS_PLATFORM_EXPR     = "失去聯繫！";
LVBM_THADDIUS_PLATFORM_ANNOUNCE = "*** 警告 - Add 離開平台 ***";


--Loatheb
LVBM_LOATHEB_NAME           = "洛斯伯";
LVBM_LOATHEB_DESCRIPTION        = "洛斯伯無可避免的末日警告，以及顯示治療冷卻時間。使用 /loatheb setup 或 /loatheb config 設置治療鏈，如果沒有設定治療鏈治療者警告將不會作用。 Setting a healer's sort ID to 0 will remove him from the list. To re-add him use /loa undelete.";
LVBM_LOATHEB_ANNOUNCE_SPORES        = "孢子廣告"
--LVBM_LOATHEB_ANNOUNCE_SPORES_BACKWARDS        = "Announce spores to Groups Backwards";
LVBM_LOATHEB_HEAL_RAID              = "治療頻道";
LVBM_LOATHEB_HEAL_RAID_WARN         = "治療警報頻道";
LVBM_LOATHEB_HEAL_WHISPER           = "發送密語給下一各治療者";
LVBM_LOATHEB_ANNOUNCE_POT_OPTION    = "消耗品通告";
LVBM_LOATHEB_SPECIALWARN_POT_OPTION = "當你使用消耗品時顯示特別警告訊息";
LVBM_LOATHEB_HEAL_SHOW_AUTO     = "當與洛斯柏戰鬥時，顯示治療相關訊息"
LVBM_LOATHEB_HEAL_SHOW_NOW      = "顯示治療資訊框"
LVBM_LOATHEB_HEAL_SETUP         = "設定治療鏈"
LVBM_LOATHEB_NO_BC_INFO             = "You are not raid leader or promoted. Your changes will not be broadcasted to the raid and broadcasted settings will overwrite yours.";
LVBM_LOATHEB_NO_CD          = "無CD";
LVBM_LOATHEB_SET_HEAL_ROTATION      = "儲存 & 同步";
LVBM_LOATHEB_SET_HEAL_ROTATION_NO_BC        = "Save";
LVBM_LOATHEB_SHADOW_PROT_POT        = "強效暗影防護藥水"
LVBM_LOATHEB_BANDAGE            = "繃帶";
LVBM_LOATHEB_HEALTHSTONE        = "治療石";

LVBM_LOATHEB_DOOM_WARNING       = "*** 無可避免的末日 #%s 在 %s 秒內 ***";
LVBM_LOATHEB_DOOM_NOW           = "*** 無可避免的末日 #%s - 下一次在 %s 秒內 ***";
LVBM_LOATHEB_DECURSE_NOW        = "*** 詛咒消除 - 30秒後再次解除 ***";
LVBM_LOATHEB_DECURSE_WARNING        = "*** %s 秒後自我移除詛咒 ***";
LVBM_LOATHEB_SPORE_SPAWNED      = "*** 孢子 出來了 ***";
LVBM_LOATHEB_POT_ANNOUNCE       = "*** 現在使用 %s ！ ***";
LVBM_LOATHEB_POT_WARNING        = "現在使用 %s ！";
LVBM_LOATHEB_HEAL_WARNING       = "治療 #%s 完成 - 下一個: %s";
LVBM_LOATHEB_YOU_ARE_NEXT       = "你是下一個！";
LVBM_LOATHEB_YOU_ARE_SOON       = "準備治療！";

LVBM_LOATHEB_DOOM_REGEXP        = "^(.+)受到(.*)無可避免的末日";
LVBM_LOATHEB_REMOVE_CURSE       = "洛斯伯對洛斯伯施放了消除詛咒";
LVBM_LOATHEB_HEAL_REGEXP        = "^(.+)受到(.*)墮落思想";
LVBM_LOATHEB_SUMMON_SPORE       = "洛斯伯施放了召換孢子。";
LVBM_LOATHEB_LOATHEB            = "洛斯伯";

LVBM_SBT["Inevitable Doom"]     = "無可避免的末日";


-- Sapphiron
LVBM_SAPPHIRON_NAME             = "薩菲隆";
LVBM_SAPPHIRON_INFO         = "寒冰炸彈, 生命虹吸和激怒的警告。";

LVBM_SAPPHIRON_YELL_INFO        = "Yell when afflicted by Ice Block";
LVBM_SAPPHIRON_YELL_ANNOUNCE        = "I'm an Ice Block, stay behind me!";

LVBM_SAPPHIRON_LIFEDRAIN_EXPR1      = "受到了吸取生命效果的影響。";
LVBM_SAPPHIRON_LIFEDRAIN_EXPR2      = "Life Drain was resisted by";
LVBM_SAPPHIRON_LIFEDRAIN_ANNOUNCE   = "*** 吸取生命 - 下一次將在24秒後出現 ***";
LVBM_SAPPHIRON_LIFEDRAIN_WARN       = "*** 吸取生命在 %d 秒後到來 ***";

LVBM_SAPPHIRON_DEEPBREATH_EXPR      = "%s深深地吸了一口氣...";
LVBM_SAPPHIRON_DEEPBREATH_ANNOUNCE  = "*** 寒冰炸彈即將降臨，不想死的快閃開！ ***";

LVBM_SAPPHIRON_FROSTBOLT_GAIN_EXPR  = "You are afflicted by Icebolt";
LVBM_SAPPHIRON_FROSTBOLT_FADE_EXPR  = "Icebolt fades from you";

LVBM_SAPPHIRON_ENRAGE_ANNOUNCE      = "*** 激怒將在 %d 秒後到來 ***";


-- Kel'Thuzad
LVBM_KELTHUZAD_NAME         = "科爾蘇加德";
LVBM_KELTHUZAD_INFO         = "科爾蘇加德的型態變換以及能力警告。";

LVBM_KELTHUZAD_RANGECHECK       = "Show distance frame during phase 2 and 3";

LVBM_KELTHUZAD_PHASE1_EXPR      = "僕從們，侍衛們，隸屬於黑暗與寒冷的戰士！聽從科爾蘇加德的召換！";
LVBM_KELTHUZAD_PHASE1_ANNOUNCE      = "*** 型態 1 ***";
LVBM_KELTHUZAD_PHASE2_EXPR      = "Pray for mercy!";
LVBM_KELTHUZAD_PHASE2_ANNOUNCE      = "*** 型態 2 - 科爾蘇加德開始憤怒了 ***";
LVBM_KELTHUZAD_PHASE3_EXPR      = "Master, I require aid!";
LVBM_KELTHUZAD_PHASE3_ANNOUNCE      = "*** 型態 3 - 15秒後 寒冰皇冠守衛者出現 ***";

LVBM_KELTHUZAD_MC_EXPR1         = "Your soul is bound to me, now!";
LVBM_KELTHUZAD_MC_EXPR2         = "There will be no escape!";
LVBM_KELTHUZAD_MC_ANNOUNCE      = "*** 心靈控制 ***";
LVBM_KELTHUZAD_GUARDIAN_EXPR        = "Very well. Warriors of the frozen wastes, rise up! I command you to fight, kill and die for your master! Let none survive!";
LVBM_KELTHUZAD_GUARDIAN_ANNOUNCE    = "*** 10秒後 寒冰皇冠守衛者出現 ***";
LVBM_KELTHUZAD_FISSURE_EXPR     = "科爾蘇加德施放了暗影裂縫。";
LVBM_KELTHUZAD_FISSURE_ANNOUNCE     = "*** 暗影裂縫 ***";
LVBM_KELTHUZAD_FROSTBLAST_EXPR      = "^(.+)受到(.+)冰霜衝擊效果的影響。";
LVBM_KELTHUZAD_FROSTBLAST_ANNOUNCE  = "*** 冰霜衝擊 ***";
LVBM_KELTHUZAD_DETONATE_EXPR        = "^(.+)受到(.+)爆裂法力效果的影響。";
LVBM_KELTHUZAD_DETONATE_ANNOUNCE    = "*** 爆裂法力 - %s ***";
LVBM_KELTHUZAD_DETONATE_SELFWARN    = "你快要爆炸了！";
LVBM_KELTHUZAD_DETONATE_WHISPER     = "你是個炸彈人！ 遠離人群至少10碼！";

end
