--------------------------------------
-- SimpleTranqShot localization.lua --
--          zhCN - Chinese          --
-- translated by Eviltiem_PoN@毒霧峰--
--------------------------------------

if ( GetLocale() == "zhCN" ) then

-- Strings that need to be translated for proper mod functionality
STRANQ_STRINGS.HUNTER = "猎人";
STRANQ_STRINGS.TRANQ = "宁神射击";
STRANQ_STRINGS.SPELLSELF = "你对(.+)施放了"..STRANQ_STRINGS.TRANQ.."。";
STRANQ_STRINGS.SPELLOTHER = "(.+)对(.+)施放了"..STRANQ_STRINGS.TRANQ.."。";
STRANQ_STRINGS.SPELLOTHERMISS = "([^%s]+)的"..STRANQ_STRINGS.TRANQ.."没有击中(.+)。";
STRANQ_STRINGS.FRENZY = "疯狂";
STRANQ_STRINGS.FAILSELF = "你未能驱散(.+)的"..STRANQ_STRINGS.FRENZY.."。"
STRANQ_STRINGS.FAILOTHER = "(.+)未能驱散(.+)的"..STRANQ_STRINGS.FRENZY.."。";
STRANQ_STRINGS.GAINFRENZY = "(.+)获得了"..STRANQ_STRINGS.FRENZY.."的效果。";
STRANQ_STRINGS.REMOVED = "(.+)的"..STRANQ_STRINGS.FRENZY.."被移除了。";
STRANQ_STRINGS.FRENZYEMOTE = "变得.*狂.*！"            --"变得极为狂暴！" "变得狂暴起来！" "变得狂怒无比！";

STRANQ_STRINGS.PANIC = "恐慌";
STRANQ_STRINGS.TIMELAPSE = "时间流逝";
STRANQ_STRINGS.TIMESTOP = "时间停止";				-- Brood Affliction: Bronze stun
STRANQ_STRINGS.WYVERNSTING = "翼龙钉刺";
STRANQ_STRINGS.MANABURN = "法力燃烧";
STRANQ_STRINGS.MINDFLAY = "精神鞭笞";
STRANQ_STRINGS.CAUSEINSANITY = "导致疯狂";

STRANQ_STRINGS.FEAR = "恐惧";
STRANQ_STRINGS.STUN = "昏迷";
STRANQ_STRINGS.FLEE = "逃跑";

-- mob names
STRANQ_STRINGS.MAGMADAR = "玛格曼达";
STRANQ_STRINGS.CHROMAGGUS = "克洛玛古斯";
STRANQ_STRINGS.MAWS = "巨齿鲨";
STRANQ_STRINGS.PRINCESS_HUHURAN = "哈霍兰公主";
STRANQ_STRINGS.FLAMEGOR = "弗莱格尔";
STRANQ_STRINGS.GLUTH = "格拉斯";
STRANQ_STRINGS.QIRAJI_SLAYER = "其拉执行者";
STRANQ_STRINGS.DEATH_TALON_SEETHER = "死爪狂乱者";
STRANQ_STRINGS.VEKNISS_DRONE = "维克尼雄蜂";
STRANQ_STRINGS.VEKNISS_SOLDIER = "维克尼士兵";
STRANQ_STRINGS.ROACH = "蟑螂";
STRANQ_STRINGS.BEETLE = "甲虫";
STRANQ_STRINGS.SCORPION = "蠍子";

-- Default broadcast and error messages
STRANQ_STRINGS.CASTMSG = "***对%T施放宁神射击***";
STRANQ_STRINGS.MISSMSG = "== 宁神射击 未命中 %T  ==";
STRANQ_STRINGS.MISSERR = "宁神射击 未命中";
STRANQ_STRINGS.RAIDERR = "%P 宁神射击未命中 ";
STRANQ_STRINGS.FAILMSG = "==  对%T的宁神射击施放失败  ==";
STRANQ_STRINGS.FAILERR = "宁神射击施放失败";
STRANQ_STRINGS.RAIDFAILERR = "%P的宁神射击施放失败";

-- %t normal case target name
-- %T upper case target name
-- %p normal case player name
-- %P upper case player name
STRANQ_STRINGS.SUB_NORMALCASE_TARGET = "%%t";
STRANQ_STRINGS.SUB_UPPERCASE_TARGET = "%%T";
STRANQ_STRINGS.SUB_NORMALCASE_PLAYER = "%%p";
STRANQ_STRINGS.SUB_UPPERCASE_PLAYER = "%%P";

STRANQ_STRINGS.CHATHEADER = "<STranq>";
STRANQ_STRINGS.BROADCASTROTHEADER = STRANQ_STRINGS.CHATHEADER.."运作中，TS名单如下 - ";

STRANQ_STRINGS.GROUP = "队伍%d: %s  ";
STRANQ_STRINGS.BACKUP = "侯补: %s  ";

STRANQ_STRINGS.ROTATION_OF = "准备之%d";
STRANQ_STRINGS.GROUPS_OF = "%d 队伍之%d";
STRANQ_STRINGS.GROUP_OF = "队伍之%d";
STRANQ_STRINGS.IN_RESERVE = "%d 待命中";

STRANQ_STRINGS.NOTFOUND = "未找到";

STRANQ_STRINGS.MISSED = "未命中";
STRANQ_STRINGS.FAILED = "失败";

STRANQ_STRINGS.NEW_FRENZY_MOB = "Found new mob that frenzies.  Adding %s to the list of known mobs.";
STRANQ_STRINGS.ROTBROADCASTEDBY = "New tranq rotation recieved from %s.";
STRANQ_STRINGS.VERSIONCOMPARE = "%s is using SimpleTranqShot %s, which appears to be a more recent version.  An update may be available."

STRANQ_STRINGS.DEAD = "死亡";
STRANQ_STRINGS.LOWMANA = "low mana";
STRANQ_STRINGS.OFFLINE = "断线";


-- Strings for the UI
STRANQ_TITLE = "SimpleTranqShot";
STRANQ_TITLESHORT = "STranq";

STRANQ_LOADED = " |c99999999: loaded :|r /stranq";

STRANQ_BROADCAST_ERROR_NOCHANNEL = "Cast Message Broadcast Channel is not set.  Yelling instead.  Type /stranq and choose a channel.";
STRANQ_BROADCAST_ERROR_CHANNEL = "Cast Message Broadcast Channel |r%s|c99999999 is not a currently joined channel.  Yelling instead.";

STRANQ_BROADCAST_TEXT = "广播讯息";
STRANQ_ERROR_TEXT = "错误讯息";
STRANQ_TIMERS_TEXT = "计时器设定";
STRANQ_CASTMSG_TEXT = "成功施放讯息";
STRANQ_MISSMSG_TEXT = "未命中讯息";
STRANQ_MISSERR_TEXT = "未命中错误讯息";
STRANQ_RAIDERR_TEXT = "团队未命中错误讯息";
STRANQ_FAILMSG_TEXT = "宁神射击失败讯息";
STRANQ_FAILERR_TEXT = "宁神射击失败错误讯息";
STRANQ_RAIDFAILERR_TEXT = "团队宁神射击失败错误讯息";
STRANQ_CASTTYPE_TEXT = "广播类型";
STRANQ_CASTCHAN_TEXT = "频道";
STRANQ_CASTPLAY_TEXT = "目标玩家";

STRANQ_NOCHANNEL_TEXT = "无频道";
STRANQ_NOPLAYER_TEXT = "无玩家";

STRANQ_TEST_TEXT = "Test";
STRANQ_DEFAULTSALL_TEXT = "All Defaults";

STRANQ_MISSCOLOR_TEXT = "未命中讯息颜色";
STRANQ_RAIDCOLOR_TEXT = "团队未命中讯息颜色";
STRANQ_RAIDMISS_TEXT = "显示团队未命中";
STRANQ_SOUNDS_TEXT = "未命中时音效";
STRANQ_RS_TEXT = "重播至 /rs";
STRANQ_HIDEBARS_TEXT = "不显示讯息条";
STRANQ_AUTOHIDEBARS_TEXT = "隐藏於团队外";
STRANQ_LOCKBARS_TEXT = "锁定讯息条位置";
STRANQ_BARSGROWUP_TEXT = "讯息条向上";
STRANQ_LOCKROT_TEXT = "锁定运作中猎人";
STRANQ_HIDEEXTRA_TEXT = "隐藏额外的猎人";
STRANQ_SHOWOTHERCLASSES_TEXT = "对非猎人显示";
STRANQ_HIDEROT_TEXT = "循环广播";
STRANQ_OFFICERSONLY_TEXT = "只有团队干部播放";

STRANQ_CASTMSG_TIP = "这段讯息将在宁神射击成功时被播放";
STRANQ_CASTMSGTEST_TIP = "测试成功时播放讯息";
STRANQ_MISSMSG_TIP = "这段讯息将在宁神射击未命中时被播放";
STRANQ_MISSMSGTEST_TIP = "测试未命中时播放讯息";
STRANQ_FAILMSG_TIP = "这段讯息将在宁神射击失败未能驱散目标的狂暴状态时被播放";
STRANQ_FAILMSGTEST_TIP = "测试驱散失败时讯息";

STRANQ_MISSERR_TIP = "这段讯息将在宁神射击未命中时显示於萤幕中"
STRANQ_MISSERRTEST_TIP = "测试未命中时播放讯息於萤幕中";
STRANQ_RAIDERR_TIP = "这段讯息将在团队里其他人宁神射击未命中时显示於萤幕中"
STRANQ_RAIDERRTEST_TIP = "测试团队里其他人未命中时播放讯息於萤幕中";
STRANQ_FAILERR_TIP = "这段讯息将在宁神射击驱散失败时显示於萤幕中"
STRANQ_FAILERRTEST_TIP = "测试驱散失败时播放讯息於萤幕中";
STRANQ_RAIDFAILERR_TIP = "测试团队里其他人驱散失败时播放讯息於萤幕中"
STRANQ_RAIDFAILERRTEST_TIP = "测试团队里其他人驱散失败时播放讯息於萤幕中";

STRANQ_CASTTYPE_TIP = "当成功，未命中及失败时广播讯息显示之位置"
STRANQ_CASTCHAN_TIP = "播放的频道或玩家(如果播放类型有指定)"
STRANQ_RS_TIP = "勾选将播放到CT_RaidAssist /rs(如果是有效的,不然讯息将显示於/raid)"
STRANQ_HIDEBARS_TIP = "隐藏猎人计时器和狂暴讯息条"
STRANQ_AUTOHIDEBARS_TIP = "当你不在团体时隐藏猎人计时器和狂暴讯息条";
STRANQ_LOCKBARS_TIP = "锁定计时器位置防止不慎移动";
STRANQ_BARSGROWUP_TIP = "改变猎人计时器位置於狂暴讯息条上方";
STRANQ_LOCKROT_TIP = "关掉其他运作中的猎人计时器";
STRANQ_HIDEEXTRA_TIP = "隐藏其他不在宁神射击名单中的猎人";
STRANQ_SHOWOTHERCLASSES_TIP = "除猎人之外，显示计时器和警告讯息(非猎人职业请勾选)";
STRANQ_HIDEROT_TIP = "广播猎人施放讯息至团队中或着指定频道";
STRANQ_OFFICERSONLY_TIP = "只有指定的宁神射击运作中猎人为队长或其助理";

STRANQ_MISSCOLOR_TIP = "改变未命中或失败时警告讯息颜色"
STRANQ_RAIDCOLOR_TIP = "改变团队未命中或失败时警告讯息颜色"
STRANQ_RAIDMISS_TIP = "显示附近团队玩家宁神射击未命中或失败时的警告讯息"
STRANQ_SOUND_TIP = "当团队未命中和自己未命中时播放音效"

STRANQ_BARALPHA_TIP = "调整计时器讯息条透明度";
STRANQ_BARSCALE_TIP = "调整计时器讯息条尺寸大小";

STRANQ_DROPDOWN_BARS_TEXT = "计时器讯息条设定";
STRANQ_DROPDOWN_ROT_TEXT = "猎人运作";

STRANQ_TOOLTIP_INACTIVE = "静止";
STRANQ_TOOLTIP_RESERVE = "侯补";
STRANQ_TOOLTIP_GROUP = "队伍";
STRANQ_TOOLTIP_IN_ROTATION = "待命中";
STRANQ_TOOLTIP_DEAD = "死亡";
STRANQ_TOOLTIP_FEIGN_DEATH = "假死";

STRANQ_MENU_UNLOCK_POSITION = "不锁定位置";
STRANQ_MENU_LOCK_POSITION = "锁定位置";
STRANQ_MENU_GROW_DOWN = "向下";
STRANQ_MENU_GROW_UP = "向上";
STRANQ_MENU_SHOW_OUTSIDE_RAID = "显示於团队外";
STRANQ_MENU_HIDE_OUTSIDE_RAID = "隐藏於团队外";
STRANQ_MENU_UNLOCK_ROTATION = "不锁定运作";
STRANQ_MENU_LOCK_ROTATION = "锁定运作";
STRANQ_MENU_SHOW_EXTRA = "显示额外的猎人";
STRANQ_MENU_HIDE_EXTRA = "隐藏额外的猎人";
STRANQ_MENU_BROADCAST_ROT = "发布名单";
STRANQ_MENU_CLOSE_OPTIONS = "关毕 STranq 设定";
STRANQ_MENU_OPEN_OPTIONS = "开启 STranq 设定";

STRANQ_ROTATION_GROUP = "每队的猎人";
STRANQ_ROTATION_BACKUP = "执行的猎人切换";
STRANQ_ROTATION_GROUPS = "队伍的数字";

STRANQ_DEFAULTS_POPUP = "警告！这个动作将会使您重新设置到预设值。\n您确定要做此动作?\n\n|cffbbbbbb如果您早先已储存您的设定，它们将不会被存取直到您再次改变设定并按下储存键";
STRANQ_DEFAULTSALL_POPUP = "所有设定将会重新设置到预设值。\n您确定要做此动作??\n\n|cffbbbbbb如果您早先已储存您的设定，它们将不会被存取直到您再次改变设定并按下储存键";
STRANQ_NEEDSAVE_POPUP = "您有未储存的变动，您是否想要现在储存？";
STRANQ_NOVALID_MSG_POPUP = "没有找到任何频道或玩家";
STRANQ_NOVALID_SAVE_POPUP = STRANQ_NOVALID_MSG_POPUP.."\n无效的储存设定.";
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
	"|cffffffff"..STRANQ_COMMAND_RESET.." |cff999999: 重置所有设定於预设值",
	"|cffffffff"..STRANQ_COMMAND_VER.." |cff999999: 检查所有人版本",
	"|cffffffff"..STRANQ_COMMAND_ROT.." |cff999999: 广播运作中的猎人顺序",
	"|cffffffff"..STRANQ_COMMAND_ENABLEALL.." |cff999999: 开启 stranq 功能对所有职业",
	"|cffffffff"..STRANQ_COMMAND_DISABLEALL.." |cff999999: 关毕 stranq 功能对所有职业除了猎人",
	"|cffffffff"..STRANQ_COMMAND_SHOWBARS.." |cff999999: 显示计时器讯息条",
	"|cffffffff"..STRANQ_COMMAND_HIDEBARS.." |cff999999: 隐藏计时器讯息条",
	"|cffffffff"..STRANQ_COMMAND_BARS.." |cff999999:  计时器讯息条",
	"No command will show the options window.",
	};

STRANQ_CONSOLE_RESETTING = "重置至预设值";
STRANQ_CONSOLE_NOTHUNTER = "这个插件预设不是对非猎人职业开启,如要开启请输入:\n/stranq enableall";
STRANQ_CONSOLE_ENABLEALL = "SimpleTranqShot 目前是对所有职业开启中.如要关毕请输入:\n/stranq disableall";
STRANQ_CONSOLE_DISABLEALL = "SimpleTranqShot 目前是对所有职业关毕中除了猎人.这改变将不会产生效果直到你重新登入这个角色";

BINDING_HEADER_SIMPLETRANQSHOT = "Simple Tranq Shot"
BINDING_NAME_TOGGLESTRANQTIMERS = "Toggle Timer Bars";
BINDING_NAME_TOGGLESTRANQOPTIONS = "Toggle Options";

end