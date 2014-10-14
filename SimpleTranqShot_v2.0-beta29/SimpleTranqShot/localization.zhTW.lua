--------------------------------------
-- SimpleTranqShot localization.lua --
--          zhTW - Chinese          --
-- translated by Eviltiem_PoN@毒霧峰--
--------------------------------------

if ( GetLocale() == "zhTW" ) then

-- Strings that need to be translated for proper mod functionality
STRANQ_STRINGS.HUNTER = "獵人";
STRANQ_STRINGS.TRANQ = "寧神射擊";
STRANQ_STRINGS.SPELLSELF = "你對(.+)施放了"..STRANQ_STRINGS.TRANQ.."。";
STRANQ_STRINGS.SPELLOTHER = "(.+)對(.+)施放了"..STRANQ_STRINGS.TRANQ.."。";
STRANQ_STRINGS.SPELLOTHERMISS = "([^%s]+)的"..STRANQ_STRINGS.TRANQ.."沒有擊中(.+)。";
STRANQ_STRINGS.FRENZY = "狂暴";
STRANQ_STRINGS.FAILSELF = "你未能驅散(.+)的"..STRANQ_STRINGS.FRENZY.."。"
STRANQ_STRINGS.FAILOTHER = "(.+)未能驅散(.+)的"..STRANQ_STRINGS.FRENZY.."。";
STRANQ_STRINGS.GAINFRENZY = "(.+)獲得了"..STRANQ_STRINGS.FRENZY.."的效果。";
STRANQ_STRINGS.REMOVED = "(.+)的"..STRANQ_STRINGS.FRENZY.."被移除了。";
STRANQ_STRINGS.FRENZYEMOTE = "變得.*狂暴.*！";            --"變得極為狂暴！" "變得狂暴起來！"

STRANQ_STRINGS.PANIC = "恐慌";
STRANQ_STRINGS.TIMELAPSE = "時間流逝";
STRANQ_STRINGS.TIMESTOP = "時間停止";				-- Brood Affliction: Bronze stun
STRANQ_STRINGS.WYVERNSTING = "翼龍釘刺";
STRANQ_STRINGS.MANABURN = "法力燃燒";
STRANQ_STRINGS.MINDFLAY = "精神鞭笞";
STRANQ_STRINGS.CAUSEINSANITY = "導致瘋狂";

STRANQ_STRINGS.FEAR = "恐懼";
STRANQ_STRINGS.STUN = "昏迷";
STRANQ_STRINGS.FLEE = "逃跑";

-- mob names
STRANQ_STRINGS.MAGMADAR = "瑪格曼達";
STRANQ_STRINGS.CHROMAGGUS = "克洛瑪古斯";
STRANQ_STRINGS.MAWS = "巨齒鯊";
STRANQ_STRINGS.PRINCESS_HUHURAN = "哈霍蘭公主";
STRANQ_STRINGS.FLAMEGOR = "弗萊格爾";
STRANQ_STRINGS.GLUTH = "古魯斯";
STRANQ_STRINGS.QIRAJI_SLAYER = "其拉執行者";
STRANQ_STRINGS.DEATH_TALON_SEETHER = "死爪狂亂者";
STRANQ_STRINGS.VEKNISS_DRONE = "維克尼斯雄蜂";
STRANQ_STRINGS.VEKNISS_SOLDIER = "維克尼斯士兵";
STRANQ_STRINGS.ROACH = "蟑螂";
STRANQ_STRINGS.BEETLE = "甲蟲";
STRANQ_STRINGS.SCORPION = "蠍子";

-- Default broadcast and error messages
STRANQ_STRINGS.CASTMSG = "***對%T施放寧神射擊***";
STRANQ_STRINGS.MISSMSG = "== 寧神射擊 未命中 %T  ==";
STRANQ_STRINGS.MISSERR = "寧神射擊 未命中";
STRANQ_STRINGS.RAIDERR = "%P 寧神射擊未命中 ";
STRANQ_STRINGS.FAILMSG = "==  對%T的寧神射擊施放失敗  ==";
STRANQ_STRINGS.FAILERR = "寧神射擊施放失敗";
STRANQ_STRINGS.RAIDFAILERR = "%P的寧神射擊施放失敗";

-- %t normal case target name
-- %T upper case target name
-- %p normal case player name
-- %P upper case player name
STRANQ_STRINGS.SUB_NORMALCASE_TARGET = "%%t";
STRANQ_STRINGS.SUB_UPPERCASE_TARGET = "%%T";
STRANQ_STRINGS.SUB_NORMALCASE_PLAYER = "%%p";
STRANQ_STRINGS.SUB_UPPERCASE_PLAYER = "%%P";

STRANQ_STRINGS.CHATHEADER = "<STranq>";
STRANQ_STRINGS.BROADCASTROTHEADER = STRANQ_STRINGS.CHATHEADER.."運作中，TS名單如下 - ";

STRANQ_STRINGS.GROUP = "隊伍%d: %s  ";
STRANQ_STRINGS.BACKUP = "侯補: %s  ";

STRANQ_STRINGS.ROTATION_OF = "準備之%d";
STRANQ_STRINGS.GROUPS_OF = "%d 隊伍之%d";
STRANQ_STRINGS.GROUP_OF = "隊伍之%d";
STRANQ_STRINGS.IN_RESERVE = "%d 待命中";

STRANQ_STRINGS.NOTFOUND = "未找到";

STRANQ_STRINGS.MISSED = "未命中";
STRANQ_STRINGS.FAILED = "失敗";

STRANQ_STRINGS.NEW_FRENZY_MOB = "Found new mob that frenzies.  Adding %s to the list of known mobs.";
STRANQ_STRINGS.ROTBROADCASTEDBY = "New tranq rotation recieved from %s.";
STRANQ_STRINGS.VERSIONCOMPARE = "%s is using SimpleTranqShot %s, which appears to be a more recent version.  An update may be available."

STRANQ_STRINGS.DEAD = "死亡";
STRANQ_STRINGS.LOWMANA = "low mana";
STRANQ_STRINGS.OFFLINE = "斷線";


-- Strings for the UI
STRANQ_TITLE = "SimpleTranqShot";
STRANQ_TITLESHORT = "STranq";

STRANQ_LOADED = " |c99999999: loaded :|r /stranq";

STRANQ_BROADCAST_ERROR_NOCHANNEL = "Cast Message Broadcast Channel is not set.  Yelling instead.  Type /stranq and choose a channel.";
STRANQ_BROADCAST_ERROR_CHANNEL = "Cast Message Broadcast Channel |r%s|c99999999 is not a currently joined channel.  Yelling instead.";

STRANQ_BROADCAST_TEXT = "廣播訊息";
STRANQ_ERROR_TEXT = "錯誤訊息";
STRANQ_TIMERS_TEXT = "計時器設定";
STRANQ_CASTMSG_TEXT = "成功施放訊息";
STRANQ_MISSMSG_TEXT = "未命中訊息";
STRANQ_MISSERR_TEXT = "未命中錯誤訊息";
STRANQ_RAIDERR_TEXT = "團隊未命中錯誤訊息";
STRANQ_FAILMSG_TEXT = "寧神射擊失敗訊息";
STRANQ_FAILERR_TEXT = "寧神射擊失敗錯誤訊息";
STRANQ_RAIDFAILERR_TEXT = "團隊寧神射擊失敗錯誤訊息";
STRANQ_CASTTYPE_TEXT = "廣播類型";
STRANQ_CASTCHAN_TEXT = "頻道";
STRANQ_CASTPLAY_TEXT = "目標玩家";

STRANQ_NOCHANNEL_TEXT = "無頻道";
STRANQ_NOPLAYER_TEXT = "無玩家";

STRANQ_TEST_TEXT = "Test";
STRANQ_DEFAULTSALL_TEXT = "All Defaults";

STRANQ_MISSCOLOR_TEXT = "未命中訊息顏色";
STRANQ_RAIDCOLOR_TEXT = "團隊未命中訊息顏色";
STRANQ_RAIDMISS_TEXT = "顯示團隊未命中";
STRANQ_SOUNDS_TEXT = "未命中時音效";
STRANQ_RS_TEXT = "重播至 /rs";
STRANQ_HIDEBARS_TEXT = "不顯示訊息條";
STRANQ_AUTOHIDEBARS_TEXT = "隱藏於團隊外";
STRANQ_LOCKBARS_TEXT = "鎖定訊息條位置";
STRANQ_BARSGROWUP_TEXT = "訊息條向上";
STRANQ_LOCKROT_TEXT = "鎖定運作中獵人";
STRANQ_HIDEEXTRA_TEXT = "隱藏額外的獵人";
STRANQ_SHOWOTHERCLASSES_TEXT = "對非獵人顯示";
STRANQ_HIDEROT_TEXT = "循環廣播";
STRANQ_OFFICERSONLY_TEXT = "只有團隊幹部播放";

STRANQ_CASTMSG_TIP = "這段訊息將在寧神射擊成功時被播放";
STRANQ_CASTMSGTEST_TIP = "測試成功時播放訊息";
STRANQ_MISSMSG_TIP = "這段訊息將在寧神射擊未命中時被播放";
STRANQ_MISSMSGTEST_TIP = "測試未命中時播放訊息";
STRANQ_FAILMSG_TIP = "這段訊息將在寧神射擊失敗未能驅散目標的狂暴狀態時被播放";
STRANQ_FAILMSGTEST_TIP = "測試驅散失敗時訊息";

STRANQ_MISSERR_TIP = "這段訊息將在寧神射擊未命中時顯示於螢幕中"
STRANQ_MISSERRTEST_TIP = "測試未命中時播放訊息於螢幕中";
STRANQ_RAIDERR_TIP = "這段訊息將在團隊裡其他人寧神射擊未命中時顯示於螢幕中"
STRANQ_RAIDERRTEST_TIP = "測試團隊裡其他人未命中時播放訊息於螢幕中";
STRANQ_FAILERR_TIP = "這段訊息將在寧神射擊驅散失敗時顯示於螢幕中"
STRANQ_FAILERRTEST_TIP = "測試驅散失敗時播放訊息於螢幕中";
STRANQ_RAIDFAILERR_TIP = "測試團隊裡其他人驅散失敗時播放訊息於螢幕中"
STRANQ_RAIDFAILERRTEST_TIP = "測試團隊裡其他人驅散失敗時播放訊息於螢幕中";

STRANQ_CASTTYPE_TIP = "當成功，未命中及失敗時廣播訊息顯示之位置"
STRANQ_CASTCHAN_TIP = "播放的頻道或玩家(如果播放類型有指定)"
STRANQ_RS_TIP = "勾選將播放到CT_RaidAssist /rs(如果是有效的,不然訊息將顯示於/raid)"
STRANQ_HIDEBARS_TIP = "隱藏獵人計時器和狂暴訊息條"
STRANQ_AUTOHIDEBARS_TIP = "當你不在團體時隱藏獵人計時器和狂暴訊息條";
STRANQ_LOCKBARS_TIP = "鎖定計時器位置防止不慎移動";
STRANQ_BARSGROWUP_TIP = "改變獵人計時器位置於狂暴訊息條上方";
STRANQ_LOCKROT_TIP = "關掉其他運作中的獵人計時器";
STRANQ_HIDEEXTRA_TIP = "隱藏其他不在寧神射擊名單中的獵人";
STRANQ_SHOWOTHERCLASSES_TIP = "除獵人之外，顯示計時器和警告訊息(非獵人職業請勾選)";
STRANQ_HIDEROT_TIP = "廣播獵人施放訊息至團隊中或著指定頻道";
STRANQ_OFFICERSONLY_TIP = "只有指定的寧神射擊運作中獵人為隊長或其助理";

STRANQ_MISSCOLOR_TIP = "改變未命中或失敗時警告訊息顏色"
STRANQ_RAIDCOLOR_TIP = "改變團隊未命中或失敗時警告訊息顏色"
STRANQ_RAIDMISS_TIP = "顯示附近團隊玩家寧神射擊未命中或失敗時的警告訊息"
STRANQ_SOUND_TIP = "當團隊未命中和自己未命中時播放音效"

STRANQ_BARALPHA_TIP = "調整計時器訊息條透明度";
STRANQ_BARSCALE_TIP = "調整計時器訊息條尺寸大小";

STRANQ_DROPDOWN_BARS_TEXT = "計時器訊息條設定";
STRANQ_DROPDOWN_ROT_TEXT = "獵人運作";

STRANQ_TOOLTIP_INACTIVE = "靜止";
STRANQ_TOOLTIP_RESERVE = "侯補";
STRANQ_TOOLTIP_GROUP = "隊伍";
STRANQ_TOOLTIP_IN_ROTATION = "待命中";
STRANQ_TOOLTIP_DEAD = "死亡";
STRANQ_TOOLTIP_FEIGN_DEATH = "假死";

STRANQ_MENU_UNLOCK_POSITION = "不鎖定位置";
STRANQ_MENU_LOCK_POSITION = "鎖定位置";
STRANQ_MENU_GROW_DOWN = "向下";
STRANQ_MENU_GROW_UP = "向上";
STRANQ_MENU_SHOW_OUTSIDE_RAID = "顯示於團隊外";
STRANQ_MENU_HIDE_OUTSIDE_RAID = "隱藏於團隊外";
STRANQ_MENU_UNLOCK_ROTATION = "不鎖定運作";
STRANQ_MENU_LOCK_ROTATION = "鎖定運作";
STRANQ_MENU_SHOW_EXTRA = "顯示額外的獵人";
STRANQ_MENU_HIDE_EXTRA = "隱藏額外的獵人";
STRANQ_MENU_BROADCAST_ROT = "發佈名單";
STRANQ_MENU_CLOSE_OPTIONS = "關畢 STranq 設定";
STRANQ_MENU_OPEN_OPTIONS = "開啟 STranq 設定";

STRANQ_ROTATION_GROUP = "每隊的獵人";
STRANQ_ROTATION_BACKUP = "執行的獵人切換";
STRANQ_ROTATION_GROUPS = "隊伍的數字";

STRANQ_DEFAULTS_POPUP = "警告！這個動作將會使您重新設置到預設值。\n您確定要做此動作?\n\n|cffbbbbbb如果您早先已儲存您的設定，它們將不會被存取直到您再次改變設定並按下儲存鍵";
STRANQ_DEFAULTSALL_POPUP = "所有設定將會重新設置到預設值。\n您確定要做此動作??\n\n|cffbbbbbb如果您早先已儲存您的設定，它們將不會被存取直到您再次改變設定並按下儲存鍵";
STRANQ_NEEDSAVE_POPUP = "您有未儲存的變動，您是否想要現在儲存？";
STRANQ_NOVALID_MSG_POPUP = "沒有找到任何頻道或玩家";
STRANQ_NOVALID_SAVE_POPUP = STRANQ_NOVALID_MSG_POPUP.."\n無效的儲存設定.";
STRANQ_NEWROTATION_POPUP = "%s wants to change the hunter rotation, accept?";

STRANQ_SLASH1 = "/simpletranq";
STRANQ_SLASH2 = "/stranq";

STRANQ_COMMAND_RESET = "reset";
STRANQ_COMMAND_VER = "ver";
STRANQ_COMMAND_ROT = "rot";
STRANQ_COMMAND_ENABLEALL = "enableall";
STRANQ_COMMAND_DISABLEALL = "disableall";
STRANQ_COMMAND_SHOWBARS = "show";
STRANQ_COMMAND_HIDEBARS = "hide";
STRANQ_COMMAND_BARS = "bars";

STRANQ_CONSOLE_HELP = {
	"/stranq console commands are:",
	"|cffffffff"..STRANQ_COMMAND_RESET.." |cff999999: 重置所有設定於預設值",
	"|cffffffff"..STRANQ_COMMAND_VER.." |cff999999: 檢查所有人版本",
	"|cffffffff"..STRANQ_COMMAND_ROT.." |cff999999: 廣播運作中的獵人順序",
	"|cffffffff"..STRANQ_COMMAND_ENABLEALL.." |cff999999: 開啟 stranq 功能對所有職業",
	"|cffffffff"..STRANQ_COMMAND_DISABLEALL.." |cff999999: 關畢 stranq 功能對所有職業除了獵人",
	"|cffffffff"..STRANQ_COMMAND_SHOWBARS.." |cff999999: 顯示計時器訊息條",
	"|cffffffff"..STRANQ_COMMAND_HIDEBARS.." |cff999999: 隱藏計時器訊息條",
	"|cffffffff"..STRANQ_COMMAND_BARS.." |cff999999:  計時器訊息條",
	"No command will show the options window.",
	};

STRANQ_CONSOLE_RESETTING = "重置至預設值";
STRANQ_CONSOLE_NOTHUNTER = "這個插件預設不是對非獵人職業開啟,如要開啟請輸入:\n/stranq enableall";
STRANQ_CONSOLE_ENABLEALL = "SimpleTranqShot 目前是對所有職業開啟中.如要關畢請輸入:\n/stranq disableall";
STRANQ_CONSOLE_DISABLEALL = "SimpleTranqShot 目前是對所有職業關畢中除了獵人.這改變將不會產生效果直到你重新登入這個角色";

BINDING_HEADER_SIMPLETRANQSHOT = "Simple Tranq Shot"
BINDING_NAME_TOGGLESTRANQTIMERS = "Toggle Timer Bars";
BINDING_NAME_TOGGLESTRANQOPTIONS = "Toggle Options";

end