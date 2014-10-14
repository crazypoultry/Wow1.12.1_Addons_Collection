-- -------------------------------------------- --
-- La Vendetta Boss Mods - Chinese localization --
--                by Diablohu                   --
--          http://www.dreamgen.net             --
--                11/14/2006                    --
-- -------------------------------------------- --

if (GetLocale() == "zhCN") then

--classes
	LVBM_MAGE		= "法师";
	LVBM_PRIEST		= "牧师";
	LVBM_PALADIN	= "圣骑士";
	LVBM_DRUID		= "德鲁伊";
	LVBM_WARLOCK	= "术士";
	LVBM_ROGUE		= "盗贼";
	LVBM_HUNTER		= "猎人";
	LVBM_WARRIOR	= "战士";
	LVBM_SHAMAN		= "萨满祭司";

--zones
	LVBM_NAXX			= "纳克萨玛斯";
	LVBM_AQ40			= "安其拉";
	LVBM_BWL			= "黑翼之巢";
	LVBM_MC				= "熔火之心";
	LVBM_AQ20			= "安其拉废墟";
	LVBM_ZG				= "祖尔格拉布";
	LVBM_ONYXIAS_LAIR	= "奥妮克希亚的巢穴";
	LVBM_DUSKWOOD		= "暮色森林";
	LVBM_ASHENVALE		= "灰谷";
	LVBM_FERALAS		= "菲拉斯";
	LVBM_HINTERLANDS	= "辛特兰";
	LVBM_BLASTED_LANDS	= "诅咒之地";
	LVBM_AZSHARA		= "艾萨拉";
	LVBM_OTHER			= "其他";

--spells/buffs
	LVBM_CHARGE			= "冲锋";
	LVBM_FERALCHARGE	= "野性冲锋";
	LVBM_BLOODRAGE		= "血性狂暴";
	LVBM_REDEMPTION 	= "救赎之魂";
	LVBM_FEIGNDEATH		= "假死";
	LVBM_MINDCONTROL	= "精神控制";

--create status bar timer localization table
	LVBM_SBT = {};

--key bindings
	BINDING_HEADER_LVBM = "La Vendetta 首领模块";
	BINDING_NAME_TOGGLE = "打开图形界面";

--OnLoad messages
	LVBM_LOADED			= "La Vendetta Boss Mods v%s by Destiny|Tandanu and La Vendetta|Nitram @ EU-Azshara loaded.";
	LVBM_MODS_LOADED	= "%s %s 模块开启"

--Slash command messages
	LVBM_MOD_ENABLED		= "首领模块开启";
	LVBM_MOD_DISABLED		= "首领模块关闭";
	LVBM_ANNOUNCE_ENABLED	= "通告开启";
	LVBM_ANNOUNCE_DISABLED	= "通告关闭";
	LVBM_MOD_STOPPED		= "计时停止";
	LVBM_MOD_INFO			= "Boss mod v%s by %s";
	LVBM_SLASH_HELP1		= " 开启/关闭";
	LVBM_SLASH_HELP2		= " 通告开启/关闭";
	LVBM_SLASH_HELP3		= " 停止";
	LVBM_SLASH_HELP4		= "你可以使用 %s 替代 /%s.";
	LVBM_RANGE_CHECK		= "距离你超过30码的成员: ";
	LVBM_FOUND_CLIENTS		= "找到%s名玩家正在使用 La Vendetta Boss Mods";

--Sync options
	LVBM_SOMEONE_SET_SYNC_CHANNEL	= "%s设置同步频道为: %s";
	LVBM_SET_SYNC_CHANNEL			= "同步频道设为: %s";
	LVBM_CHANNEL_NOT_SET			= "未设置频道。无法广播";
	LVBM_NEED_LEADER				= "你必须为助理或团长才能广播频道！";
	LVBM_NEED_LEADER_STOP_ALL		= "你必须为助理或团长才能使用此功能！";
	LVBM_ALL_STOPPED				= "所有计时停止";
	LVBM_REC_STOP_ALL				= "停止接收来自%s的所有命令";

--Update dialog
	LVBM_UPDATE_DIALOG		= "你的 La Vendetta Boss Mods 已经过期！\n%s 和 %s 有版本 %s。\n请访问 www.curse-gaming.com 获取最新版本。";
	LVBM_YOUR_VERSION_SUCKS	= "你的 La Vendetta Boss Mods 已经过期！\n请访问 www.curse-gaming.com 获取最新版本。";
	LVBM_REQ_PATCHNOTES		= "向%s请求更新记录...请等待";
	LVBM_SHOW_PATCHNOTES	= "显示更新记录";
	LVBM_PATCHNOTES			= "更新记录";
	LVBM_COPY_PASTE_URL		= "复制并粘贴地址";
	LVBM_COPY_PASTE_NOW		= "按下 CTRL-C 以复制地址到剪贴板";

--Status Bar Timers
	LVBM_SBT_TIMELEFT				= "剩余时间:"
	LVBM_SBT_TIMEELAPSED			= "已用时间:"
	LVBM_SBT_TOTALTIME				= "总时间:"
	LVBM_SBT_REPETITIONS			= "循环:";
	LVBM_SBT_INFINITE				= "无限";
	LVBM_SBT_BOSSMOD				= "模块:"
	LVBM_SBT_STARTEDBY				= "开始于:"
	LVBM_SBT_RIGHTCLICK				= "右键点击以隐藏"
	LVBM_SBT_LEFTCLICK				= "Shift + 单击以公布计时";
	LVBM_TIMER_IS_ABOUT_TO_EXPIRE	= "计时器\"%s\"即将到期";
	LVBM_BAR_STYLE_DEFAULT			= "默认";
	LVBM_BAR_STYLE_MODERN			= "现代";
	LVBM_BAR_STYLE_CLOUDS			= "云雾";
	LVBM_BAR_STYLE_PERL				= "Perl";

--Combat messages
	LVBM_BOSS_ENGAGED			= "%s战斗开始。祝你好运！ :)";
	LVBM_BOSS_SYNCED_BY			= "(从%s接收到同步指令)";
	LVBM_BOSS_DOWN				= "%s被击杀！用时%s";
	LVBM_COMBAT_ENDED			= "战斗结束。用时%s";
	LVBM_DEFAULT_BUSY_MSG		= "%P正在忙禄。(%B作战中 - %HP - %ALIVE/%RAID幸存)。在战斗结束后我会通知你。请等待。";
	LVBM_RAID_STATUS_WHISPER	= "%B - %HP - %ALIVE/%RAID幸存";
	LVBM_SEND_STATUS_INFO		= "对我密语\"status\"可查询战斗状况。";
	LVBM_AUTO_RESPOND_SHORT		= "自动回复。";
	LVBM_AUTO_RESPOND_LONG		= "已自动回复%s";
	LVBM_MISSED_WHISPERS		= "战斗中收到的密语:";
	LVBM_SHOW_MISSED_WHISPER	= "|Hplayer:%1\$s|h[%1\$s]|h: %2\$s";
	LVBM_BALCONY_PHASE			= "平台阶段 #%s";

--Misc stuff
	LVBM_YOU					= "你";
	LVBM_ARE					= "到了";
	LVBM_IS						= "is";
	LVBM_OR						= "或";
	LVBM_AND					= "和";
	LVBM_UNKNOWN			 	= "未知";
	LVBM_LOCAL					= "本地";
	LVBM_DEFAULT_DESCRIPTION	= "无描述";
	LVBM_SEC					= "秒";
	LVBM_MIN					= "分";
	LVBM_SECOND					= "秒";
	LVBM_SECONDS				= "秒";
	LVBM_MINUTES				= "分钟";
	LVBM_MINUTE					= "分钟";
	LVBM_HIT					= "击中";
	LVBM_HITS					= "击中";
	LVBM_CRIT					= "致命一击对";
	LVBM_CRITS					= "致命一击对";
	LVBM_MISS					= "没有击中";
	LVBM_DODGE					= "闪躲";
	LVBM_PARRY					= "招架";
	LVBM_FROST					= "冰霜";
	LVBM_ARCANE					= "奥术";
	LVBM_FIRE					= "火焰";
	LVBM_HOLY					= "神圣";
	LVBM_NATURE					= "自然";
	LVBM_SHADOW					= "暗影";
	LVBM_CLOSE					= "关闭";
	LVBM_AGGRO_FROM				= "获得仇恨: ";
	LVBM_SET_ICON				= "添加标注";
	LVBM_SEND_WHISPER			= "密语玩家";
	LVBM_DEAD					= "死亡";
	LVBM_OFFLINE				= "离线";
	LVBM_PHASE					= "第%s阶段";
	LVBM_WAVE					= "第%s波";
	
-- Added 11.11.06
	LVBM_NOGUI_ERROR	= "对不起，请开启 LVBM GUI 来进行操作";
	LVBM_NOSYNCBARS		= "目前没有计时条";
end