
--[[
--AlphaMap Simplified Chinese
--Locolized by springsnow (2006/7/14)(3区-吉安娜-浮云)
--Last Updated:2006/9/23
--之所以汉化此插件其实是因为自己一直在用，以前用的旧版本的有人汉化，大约已经有一年没有更新国汉化了，
--为了自己使用方便，于是就尝试自己汉化了，由于本人基本没进过战场，所以战场部分可能汉化不太完整，
--希望大家能够给予帮助。
--]]






if( GetLocale() == "zhCN" ) then

	SLASH_ALPHAMAPSLASH1 = "/AlphaMap";
	SLASH_ALPHAMAPSLASH2 = "/am";

	AM_SLASH_LOAD_HELP_USAGE	= "Alpha Map"

	BINDING_HEADER_ALPHAMAP        = "AlphaMap 按键绑定";
	BINDING_NAME_TOGGLEALPHAMAP    = "开启/关闭 AlphaMap";
	BINDING_NAME_INCREMENTALPHAMAP = "增加 AlphaMap 透明度";
	BINDING_NAME_DECREMENTALPHAMAP = "减少 AlphaMap 透明度";
	BINDING_NAME_CLEARVIEWALPHAMAP	= "显示/隐藏所有标记/图标";
	BINDING_NAME_CYCLEWMMODE	= "循环世界地图模式";
	BINDING_NAME_HOT_SPOT		= "热点";

	--Colored State values
	ALPHA_MAP_GREEN_ENABLED = "|c0000FF00启用|r";
	ALPHA_MAP_RED_DISABLED = "|c00FF0000禁用|r";

	--Slash Help
	AM_SLASH_HELP_USAGE         = "AlphaMap 使用方法: /alphamap 或 /am:";
	AM_SLASH_HELP_ENABLE        = "/am enable - 启用/重新启用 AlphaMap";
	AM_SLASH_HELP_DISABLE       = "/am disable - 禁用 AlphaMap";
	AM_SLASH_HELP_RESET         = "/am reset - 重置 AlphaMap 选项为默认值.";
	AM_SLASH_HELP_RAID          = "/am raid - 显示团队标记";
	AM_SLASH_HELP_PTIPS         = "/am ptips - 显示队伍提示信息";
	AM_SLASH_HELP_MNTIPS        = "/am mntips - 显示 MapNotes 提示信息";
	AM_SLASH_HELP_GTIPS         = "/am gtips - 显示 Gatherer 提示信息";
	AM_SLASH_HELP_MNGTIPS       = "/am mngtips - 显示 MapNotes Gathering 提示信息";
	AM_SLASH_HELP_MOVESLIDER    = "/am moveslider - 开启/关闭移动透明调节条";
	AM_SLASH_HELP_SLIDER        = "/am slider - 开启/关闭显示透明调节条显示";
	AM_SLASH_HELP_GATHERER      = "/am gatherer - 开启/关闭对 Gatherer 的支持";
	AM_SLASH_HELP_MAPNOTES      = "/am mapnotes - 开启/关闭对 MapNotes 的支持";
	AM_SLASH_HELP_GATHERING     = "/am gathering - 开启/关闭对 MapNotes Gathering 的支持";
	AM_SLASH_HELP_AUTOCLOSE     = "/am combat - 开启/关闭战斗中自动关闭";
	AM_SLASH_HELP_AUTOOPEN	    = "/am reopen - 开启/关闭战斗结束后重新开启";
	AM_SLASH_HELP_WMCLOSE       = "/am wmclose - 开启/关闭世界地图关闭时自动关闭";
	AM_SLASH_HELP_LOCK          = "/am lock - 开启/关闭 AlphaMap 移动功能";
	AM_SLASH_HELP_SCALE         = "/am scale |c0000AA00<数值>|r - 设置 Alphamap 窗口比例 (范围 0.0 - 1.0)";
	AM_SLASH_HELP_TOG           = "|c00FF0000/am tog  - 开启/关闭 Alphamap 显示|r";
	AM_SLASH_HELP_ALPHA         = "/am alpha |c0000AA00<数值>|r - 设置 AlphaMap 透明度 (范围 0.0 - 1.0)";
	AM_SLASH_HELP_MINIMAP	    = "/am minimap - 开启/关闭显示迷你地图按钮";
	AM_SLASH_HELP_HELP	    = "/am help  <或>  /am ?  - 列出 AlphaMap 的命令行";

	ALPHA_MAP_LOAD_CONFIRM = "|c0000BFFFAlphaMap |c0000FF00v."..ALPHA_MAP_VERSION.."|c0000BFFF 载入 - 输入 "..SLASH_ALPHAMAPSLASH1.." 或 "..SLASH_ALPHAMAPSLASH2.." 显示选项|r";

	ALPHA_MAP_ENABLED = "|c0000BFFFAlphaMap 当前已 "..ALPHA_MAP_GREEN_ENABLED;
	ALPHA_MAP_DISABLED = "|c0000BFFFAlphaMap 当前已 "..ALPHA_MAP_RED_DISABLED;

	ALPHA_MAP_UI_LOCKED = "AlphaMap: 用户界面 |c00FF0000锁定|r.";
	ALPHA_MAP_UI_UNLOCKED = "AlphaMap: 用户界面 |c0000FF00未锁定|r.";
	ALPHA_MAP_UI_LOCK_HELP = "如果点选此选项, 那么 AlphaMap 将被锁定在该位置不能再进行移动.";

	ALPHA_MAP_DISABLED_HINT = "提示: AlphaMap 已 "..ALPHA_MAP_RED_DISABLED..".  输入 |C0000AA00'/am Enable'|R 命令重新启用它.";

	ALPHA_MAP_CONFIG_SLIDER_STATE       = "AlphaMap: 透明调节条移动 ";
	ALPHA_MAP_CONFIG_COMBAT_STATE       = "AlphaMap: 战斗时自动关闭 ";
	ALPHA_MAP_CONFIG_REOPEN_STATE	    = "AlphaMap: 战斗结束后重新开启 ";
	ALPHA_MAP_CONFIG_RAID_STATE         = "AlphaMap: 团队标记 ";
	ALPHA_MAP_CONFIG_PTIPS_STATE        = "AlphaMap: 队伍/团队提示信息 ";
	ALPHA_MAP_CONFIG_MNTIPS_STATE       = "AlphaMap: MapNotes 提示信息 ";
	ALPHA_MAP_CONFIG_MNGTIPS_STATE      = "AlphaMap: MapNotes Gathering 提示信息 ";
	ALPHA_MAP_CONFIG_GTIPS_STATE        = "AlphaMap: Gatherer 提示信息 ";
	ALPHA_MAP_CONFIG_WMCLOSE_STATE      = "AlphaMap: 关闭世界地图时关闭 ";
	ALPHA_MAP_CONFIG_GATHERING_STATE    = "AlphaMap: MapNotes Gathering 支持 ";
	ALPHA_MAP_CONFIG_GATHERER_STATE     = "AlphaMap: Gatherer 支持 ";
	ALPHA_MAP_CONFIG_MAPNOTES_STATE     = "AlphaMap: MapNotes 支持 ";

	AM_OPTIONS			= "选项";
	AM_OPTIONS_TITLE		= "AlphaMap "..AM_OPTIONS;
	AM_OPTIONS_RESET		= "重置全部";
	AM_OPTIONS_CLOSE		= "关闭";
	AM_OPTIONS_MAPNOTES		= "显示 Map Notes";
	AM_OPTIONS_MAPNOTES_TOOLTIPS	= "显示 Map Notes 提示信息";
	AM_OPTIONS_MAPNOTESG		= "显示 MapNotes Gathering 图标";
	AM_OPTIONS_MAPNOTESG_TOOLTIPS 	= "显示 MapNotes Gathering 提示信息";
	AM_OPTIONS_GATHERER		= "显示 Gatherer 图标";
	AM_OPTIONS_GATHERER_TOOLTIPS	= "显示 Gatherer 提示信息";
	AM_OPTIONS_PARTY_TOOLTIPS	= "显示队伍/团队提示信息";
	AM_OPTIONS_RAID_PINS		= "显示团队标记 ";
	AM_OPTIONS_SLIDER		= "在地图上显示透明度调节条";
	AM_OPTIONS_SLIDER_MOVE		= "允许移动透明度调节条";
	AM_OPTIONS_AUTOCLOSE_COMBAT	= "战斗开始时关闭地图";
	AM_OPTIONS_AUTOOPEN_COMBAT	= "战斗结束后重新打开地图";
	AM_OPTIONS_AUTOCLOSE_WORLDMAP	= "当世界地图关闭时关闭地图";
	AM_OPTIONS_ANGLESLIDER		= "小地图角度  : ";
	AM_OPTIONS_RADIUSLIDER		= "小地图半径 : ";
	AM_OPTIONS_ALPHASLIDER		= "地图透明度 : ";
	AM_OPTIONS_SCALESLIDER		= " 地图缩放  : ";
	AM_OPTIONS_MAP_LOCK		= "锁定 AlphaMap 位置";
	AM_OPTIONS_MINIMAP		= "显示小地图图标";
	AM_OPTIONS_CLEARVIEW_OFF	= "隐藏已激活的图标";
	AM_OPTIONS_CLEARVIEW_ON		= "|c00FF0000所有图标当前隐藏|r";
	AM_OPTIONS_LEGACYPLAYER		= "显示原始风格玩家图标";
	AM_OPTIONS_ZONE_SELECTOR	= "显示地图选择器";
	AM_OPTIONS_GENERAL		= "综合";
	AM_OPTIONS_GENERAL_CHAT		= "综合聊天";
	AM_OPTIONS_DUNGEON		= "地下城";
	AM_OPTIONS_MAPS			= "地图选择器";
	AM_OPTIONS_ADDONS		= "世界地图标记 & 图标 : ";
	AM_OPTIONS_MISC			= "内部插件选项 : ";
	AM_OPTIONS_DUNGEON_NOTES	= "AlphaMap 标记选项 : ";
	AM_OPTIONS_DUNGEON_FRAMES	= "地下城额外信息 : ";
	AM_OPTIONS_DM_NOTES		= "显示 AlphaMap 标记";
	AM_OPTIONS_DM_NOTES_TOOLTIPS	= "显示 AlphaMap 标记提示信息";
	AM_OPTIONS_DM_NOTES_BCKGRND	= "显示标记背景";
	AM_OPTIONS_DM_NBG_SET		= "设置标记背景颜色";
	AM_OPTIONS_DM_HEADER		= "显示页眉信息";
	AM_OPTIONS_DM_EXTRA		= "显示页脚信息";
	AM_OPTIONS_DM_KEY		= "显示地图关键点";
	AM_OPTIONS_DM_KEY_TOOLTIPS	= "显示地图关键点提示信息";
	AM_OPTIONS_DM_SAVE_LABEL	= "所有副本地图控制设置 : ";
	AM_OPTIONS_DM_ALL		= "改变影响所有副本地图";
	AM_OPTIONS_DM_SAVE		= "应用到所有副本地图";
	AM_OPTIONS_RESTORE		= "应用";
	AM_MISC				= "其他";
	AM_OPTIONS_DM_MISC		= AM_MISC.." : ";
	AM_OPTIONS_DM_MAP_BCKGRND	= "显示地图背景";
	AM_OPTIONS_DM_MBG_SET		= "设置地图背景颜色";
	AM_OPTIONS_DM_TEXT_BCKGRND	= "显示文本背景";
	AM_OPTIONS_DM_TEXTBG_SET	= "设置文本背景颜色";
	AM_OPTIONS_MAP_BOXES		= "AlphaMap 选择器位置 :";
	AM_OPTIONS_UNDOCKED		= "AlphaMap 选择器 : ";
	AM_OPTIONS_FREE			= "自由浮动";
	AM_OPTIONS_FREE_LOCKED		= "(锁定)";
	AM_OPTIONS_MAPPED		= "吸附到 AlphaMap";
	AM_OPTIONS_DOCK_IT		= "嵌入到选项窗口";
	AM_OPTIONS_FREE_IT		= "自由浮动";
	AM_OPTIONS_MAP_IT		= "吸附到 AlphaMap";
	AM_OPTIONS_HOW_TO_MAP		= "嵌入到 AlphaMap 从 : ";
	AM_OPTIONS_MAP_LINK		= "到";
	AM_OPTIONS_HOTSPOT_BEHAVE	= "热点状态 : ";
	AM_OPTIONS_HOTSPOT_DISABLE	= "启用热点功能";
	AM_OPTIONS_HOTSPOT_OPEN		= "如果 AlphaMap 已关闭则开启";
	AM_OPTIONS_HOTSPOT_OPACITY	= "完全不透明 AlphaMap";
	AM_OPTIONS_HOTSPOT_WORLDI	= "开启/关闭世界地图图标/标记";
	AM_OPTIONS_HOTSPOT_DUNGI	= "开启/关闭地下城 AlphaMap 标记";
	AM_OPTIONS_HOTSPOT_NBG		= "开启/关闭标记背景";
	AM_OPTIONS_HOTSPOT_MBG		= "开启/关闭地图背景";
	AM_OPTIONS_HOTSPOT_MINIMAP	= "启用小地图按钮为热点";
	AM_OPTIONS_HOTSPOT_INFO		= "开启/关闭关键点/页眉/页脚";
	AM_OPTIONS_BG_USE_AM		= "当在战场中时使用 AlphaMap 的战场地图作为默认值";
	AM_OPTIONS_BG_SAVE_LABEL	= "所有战场地图控制选项 : ";
	AM_OPTIONS_BG_ALL		= "设置改变影响到所有战场地图";
	AM_OPTIONS_BG_SAVE		= "应用到所有战场地图";
	AM_OPTIONS_RAID_SAVE_LABEL	= "所有非副本地图控制选项 :";
	AM_OPTIONS_RAID_ALL		= "改变影响所有非副本地图";
	AM_OPTIONS_RAID_SAVE		= "Apply to ALL Non-Instance Maps";
	AM_OPTIONS_BG_MESSAGES		= "发送战场信息到 : ";
	AM_OPTIONS_RAID			= "团队";
	AM_OPTIONS_PARTY		= "小队";
	AM_OPTIONS_GUILD		= "公会";
	AM_OPTIONS_GROUP_DEFAULT	= "分组从属";
	AM_OPTIONS_NUN_AUTO		= "自动发送 NuN 标记设置";
	AM_OPTIONS_NUN_FORMAT		= "发送格式化信息";
	AM_OPTIONS_NUN_MESSAGES		= "自动发送 NuN 标记到 : ";
	AM_OPTIONS_WMAP_MODES		= "世界地图查看模式 :";
	AM_OPTIONS_GMAP_MODES		= "暴雪地图设置 :";
	AM_OPTIONS_GMAP_ALLOW		= "允许改变到暴雪地图";
	AM_OPTIONS_GMAP_CHANGE		= "选中以改变暴雪地图";
	AM_OPTIONS_WMAP_SMODE		= "标准";
	AM_OPTIONS_WMAP_OMODE		= "简洁";
	AM_OPTIONS_WMAP_MINIMODE	= "小地图材质";
	AM_OPTIONS_WMAP_ZMINIMODE	= "放大小地图";
	AM_OPTIONS_WMOTHER		= "其他地图控制 : ";
	AM_OPTIONS_WM_ESCAPE		= "启用 <ESC> 关闭";
	AM_OPTIONS_WM_MOUSE		= "启用鼠标交互";
	AM_OPTIONS_MUTE			= "静音";
	AM_OPTIONS_COORDS		= "(x, y)";
	AM_OPTIONS_MAPS1		= "AlphaMap 地图 1";
	AM_OPTIONS_MAPS2		= "  ..... 2";
	AM_OPTIONS_HELP_TIPS		= "帮助提示信息";

	AM_INSTANCE_TITLE_LOCATION	= "位置 ";
	AM_INSTANCE_TITLE_LEVELS	= "等级 ";
	AM_INSTANCE_TITLE_PLAYERS	= "最大玩家数 ";
	AM_INSTANCE_CHESTS		= "箱子 ";
	AM_INSTANCE_STAIRS		= "楼梯";
	AM_INSTANCE_ENTRANCES		= "入口 ";
	AM_INSTANCE_EXITS		= "出口 ";
	AM_LEADSTO			= "通往...";
	AM_INSTANCE_PREREQS		= "先决条件 : ";
	AM_INSTANCE_GENERAL		= "综合标记 : ";
	AM_RARE				= "(稀有)";
	AM_VARIES			= "(多个位置)";
	AM_WANDERS			= "(巡逻)";
	AM_OPTIONAL			= "(可选)";

	AM_NO_LIMIT			= "无玩家限制";

	AM_MOB_LOOT 			= "怪物掉落";
	AM_RBOSS_DROP 			= "随机首领掉落";
	AM_ENCHANTS			= "附魔";
	AM_CLASS_SETS			= "职业套装";
	AM_TIER0_SET			= "T0套装";
	AM_TIER1_SET			= "T1套装";
	AM_TIER2_SET			= "T2套装";
	AM_TIER3_SET			= "T3套装";
	AM_PVP_SET			= "PVP套装";

	AM_ANCHOR_POINT 	= {	{ Display = "上",			-- Localise
					  Command = "TOP" },					-- Do NOT Localise
					{ Display = "右上",		-- Localise
					  Command = "TOPRIGHT" },				-- Do NOT Localise
					{ Display = "右",			-- Localise
					  Command = "RIGHT" },					-- Do NOT Localise
					{ Display = "右下",		-- Localise
					  Command = "BOTTOMRIGHT" },				-- Do NOT Localise
					{ Display = "下",			-- Localise
					  Command = "BOTTOM" },				-- Do NOT Localise
					{ Display = "左下",		-- Localise
					  Command = "BOTTOMLEFT" },				-- Do NOT Localise
					{ Display = "左",			-- Localise
					  Command = "LEFT" },					-- Do NOT Localise
					{ Display = "左上",			-- Localise
					  Command = "TOPLEFT" }				-- Do NOT Localise
				};

	AM_BG_BASE			= "基地";
	AM_BG_BASES			= "基地";
	AM_BG_REQUIRED			= "需要获胜 !";

	AM_EXTERIOR = " 外部";

	AM_RCMENU_INC			= " Inc ";		-- as in 5 inc Blacksmith   or  3 inc farm
	AM_RCMENU_ZERG			= "Zerg";		-- as in Zerg Inc Frostwolf GY
	AM_OK				= "确定";
	AM_RCMENU_HIGHLIGHT		= "高亮";		-- as in leave this note highlighted on the map
	AM_RCMENU_NUN_AUTO		= "自动发送标记";	-- send the NotesUNeed note for the current map note to Raid/Party/...
	AM_RCMENU_NUN_MAN		= "手动发送标记";
	AM_RCMENU_NUN_OPEN		= "打开标记";
	AM_RCMENU_AFLAG			= "联盟军旗 ";
	AM_RCMENU_HFLAG			= "部落军旗 ";
	AM_RCMENU_FLAGLOC		= {	"己方隧道",
						"己方屋顶",
						"到西边区",
						"到东边去",
						"在中间",
						"对方隧道",
						"对方屋顶",
						"对方军旗房间",
						"对方墓地"
					};

	AM_OPENING = "AQ Opening Quest Chain";

	AM_HORDE		= "部落";
	AM_PICKED		= { 	word = "拔起了" };



	-- Deutsch
	--AM_PICKED		= {	word = "aufgenommen" };

	-- Francais
	--AM_PICKED		= {	word = "ramass\195\169",
	--				posWord = " par ",
	--				extraChars = 2 };

	AM_NEUTRAL		= "中立";
	AM_FRIENDLY		= "友善";
	AM_HONOURED		= "尊敬";
	AM_REVERED		= "崇敬";
	AM_EXALTED		= "崇拜";

	AM_CONFIG_SAVED			= "AlphaMap 设置改变为 : ";

	AM_CANCEL			= "取消";

	--------------------------------------------------------------------------------------------------------------------------------------
	-- TOOLTIPS															    --
	--------------------------------------------------------------------------------------------------------------------------------------

	AM_TT_MINIMAP_BUTTON	= "AlphaMap\n左击开启/关闭 AlphaMap\n右击开启/关闭选项";
	AM_TT_ALPHA_BUTTON1	= "AlphaMap";
	AM_TT_ALPHA_BUTTON2	= "左击开启/关闭 AlphaMap\n右击开启/关闭选项";
	AM_TT_PAUSE1		= "暂停";
	AM_TT_PAUSE2		= "点击后暂停地图刷新并允许你打开/关闭而不重置到当前地图\n如果其他相冲突的插件继续重置 AlphaMap 到当前区域则\n仍然起作用";
	AM_TT_PLAY1		= "播放";
	AM_TT_PLAY2		= "即点击后立刻终止暂停地图刷新功能";
	AM_TT_HOTSPOT1		= "热点";
	AM_TT_HOTSPOT2		= "快速将鼠标掠过该工具以改变 AlphaMap 查看方式\n例如显示/隐藏地图或者标记/图标, 或者使其完全显示\n查看选项中的地图选择器标签以获取完整列表\n(可绑定按键)";
	AM_TT_LOCK1		= "锁定地图选择器";
	AM_TT_LOCK2		= "解锁显示一个用来移动地图选择器下拉列表的框体";
	AM_TT_TAB1		= "初始 AlphaMap 选项";
	AM_TT_TAB2A		= "特定选项仅用于 AlphaMap 包含的地图而非暴雪地图.";
	AM_TT_TAB2B		= "例如地图/标记/文本背景, 及显示的标记/额外信息\n注意 : 仅应用于 AlphaMap 地图, 查看世界地图区域时不适用";
	AM_TT_TAB3A		= "进一步设置仅适用于 AlphaMap 地图";
	AM_TT_TAB3B		= "注意 : 仅应用于 AlphaMap 地图, 查看世界地图区域时不适用";
	AM_TT_TAB4		= "设置世界地图选择器下拉列表位置\n及定义热点的状态";
	AM_TT_TAB5		= "其他 AlphaMap 设置及与其他插件的配合";
	AM_TT_MAPNOTES		= "启用显示 MapNotes, CTMap_Mod notes, MetaMapNotes, MapNotes(Cosmos)";
	AM_TT_RAID1		= "反选仅显示小队位置点";
	AM_TT_RAID2		= "(即使在团队中)";
	AM_TT_CLEAR1		= "显示/隐藏所有上面启用的图标/标记\n也有同样功能的按键绑定";
	AM_TT_CLEAR2		= "例如迅速地清理地图\或者\隐藏全部, 并在需要时使用热点来使它们可见";
	AM_TT_SLIDER		= "显示一个透明度滑动控制条在 AlphaMap 上";
	AM_TT_SLIDERM1		= "钩选以启用移动透明度滑动条功能";
	AM_TT_SLIDERM2		= "放置在地图上任意位置以重新定位其在那儿\n放置在'超出' AlphaMap 范围处以分离它\n(在鼠标交互模式下当CTRL键被按下时可以\n随鼠标移动)";
	AM_TT_ACLOSE1		= "当进入战斗时自动关闭 AlphaMap";
	AM_TT_ACLOSE2		= "(如果你总是开启地图进行游戏则非常有用)";
	AM_TT_AOPEN		= "当离开战斗时自动重新打开 AlphaMap";
	AM_TT_LEGACY1		= "原始玩家 & 队伍方向图标";
	AM_TT_LEGACY2		= "也许会遇到小地图图标闪烁的情形";
	AM_TT_AM_NOTES1		= "显示 AlphaMap 地图标记";
	AM_TT_AM_NOTES2		= "(这和 MapNotes 不同\n而且不可以被改变)";
	AM_TT_ALL_INSTANCE1	= "反选单独为每个副本地图保存设置";
	AM_TT_ALL_INSTANCE2	= "例如你也许想为祖尔法拉克设置一个较暗的背景, 而熔火之心则\n设置一个明亮的背景.\n\n请保持钩选如果你确定你希望当你对任意副本地图做出任何改变时\n设该置复制到所有其它副本地图";
	AM_TT_KEY		= "即显示地图说明";
	AM_TT_ALL_BG1		= "反选单独为每个战场地图保存设置";
	AM_TT_ALL_BG2		= "例如你也许想奥特兰克战场地图相对于战歌峡谷显示得更大.\n\n请保持钩选如果你确定你希望当你对任意战场地图做出任何改变时\n该设置复制到所有其它战场地图";
	AM_TT_ALL_NI1		= "反选单独为每个非副本地图保存设置";
	AM_TT_ALL_NI2		= "例如你也许不想为地下城外部显示地图说明\n但是想让它在世界首领地图上显示.\n\n请保持钩选如果你确定你希望当你对任意非副本地图做出任何改变时\n该设置复制到所有其它非副本地图";
	AM_TT_MSG		= "战场信息将被发送到 :";
	AM_TT_MSG_DFLT2		= " - 你的团队, 如果你在进入战场前已经在一个团队中\n - 你的小队, 如果你在进入战场前已经在一个小队中\n - 否则战场频道";
	AM_TT_MSG_PARTY2	= " - 仅你的小队, 如果你在进入战场前已经在一个团队或小队中\n - 否则战场频道";
	AM_TT_MSG_BG2		= " - 仅战场频道";
	AM_TT_AUTO_BG1		= "在战场中使用 AlphaMap 的战场地图作为默认地图";
	AM_TT_AUTO_BG2		= "如果此选项被钩选则当你进入战场时战场地图将自动打开\n\n如果你宁愿在战场中使用普通的暴雪风格地图则反选\n(当你进入战场时地图将不会自动打开)";
	AM_TT_NUN_F1		= "格式化的 NotesUNeed 标记可以被添加到接收到它们的人的数据库中";
	AM_TT_NUN_F2		= "(然后, 没有安装 NotesUNeed 的人将看到额外的文字而不只是标记的文本.)";
	AM_TT_NUN		= "NotesUNeed 标记将被自动发送到:";
	AM_TT_NUN_DFLT2		= " - 你的团队, 如果在团队中\n - 你的小队, 如果在小队中\n - 否则你只能 '/Say' 发送标记\n\n注意除非你在进战场前已经在团队/小队中\n否则在战场中团队/小队信息发送将失败";
	AM_TT_NUN_PARTY2	= " - 仅你的小队, 如果你在团队或者小队中\n - 否则你将只能 '/Say' 发送标记\n\n注意除非你在进战场前已经在团队/小队中\n否则在战场中团队/小队信息发送将失败";
	AM_TT_NUN_GUILD2	= " - 你的公会";
	AM_TT_MOUSE1		= "鼠标交互模式允许你 CTRL-点击 AlphaMap";
	AM_TT_MOUSE2		= "通常 AlphaMap 对于鼠标来说不可见.\n然而, 在鼠标交互\n模式下, 当 CTRL 键被按下你将可以看见你鼠标悬停处的地图地区\n名称, 并且可以 CTRL-左击 和 CTRL-右击来进行缩放.\n\n当在鼠标交互模式时, 你也可以 CTRL-点击 \nAlphaMap 滑动条和地图坐标来重新定位它们";
	AM_TT_MUTE		= "开启/关闭打开/关闭 AlphaMap 的声音";
	AM_TT_XY		= "开启/关闭显示玩家/鼠标坐标";
	AM_TT_STANDARD		= "标准查看 - 世界地图地区与原始暴雪地图一样显示";
	AM_TT_COMPACT1		= "简洁查看 - 仅显示当前地区已探索的区域";
	AM_TT_COMPACT2		= "你尚未探索的区域将不被显示\n除非你已经安装了 MozzFullWorldMap (Fan's Update) 插件";
	AM_TT_BLIZZ_ALLOW1	= "当钩选时, AlphaMap 将保存你对暴雪地图的\n位置/透明度/缩放度所做的任意改变";
	AM_TT_BLIZZ_ALLOW2	= "反选后恢复原始的暴雪地图设置\n这需要'重载用户界面'在此期间游戏将会\n暂停几秒";
	AM_TT_BLIZZ_CHANGE1	= "当钩选时, 下面的透明度和缩放度滑动条\n将仅影响原始的暴雪地图";
	AM_TT_HELP_TIPS1	= "开启/关闭帮助提示信息";
	AM_TT_HELP_TIPS2	= "不影响地图图标提示信息";

	--------------------------------------------------------------------------------------------------------------------------------------
	-- Everything below should be localised apart from the 'filename', 'lootid' entries which should NOT be changed                               --
	-- The first  'name'  field is used to equate with in game Zone name information to help determine when the player is in a specific --
	-- Instance, and must therefore be spelt IDENTICALLY to the names of the Instances as displayed by the WoW Client in other native   --
	-- frames.															    --
	--------------------------------------------------------------------------------------------------------------------------------------

	AM_TYP_WM			= "世界地图";
	AM_TYP_INSTANCE 		= "副本";
	AM_TYP_BG			= "战场地图";
	AM_TYP_RAID			= "非副本地图";
	AM_TYP_GM			= "暴雪地图";

	AM_ALPHAMAP_LIST = {
			{	name = "黑暗深渊",			-- Blackfathom Deeps
				type = AM_TYP_INSTANCE,
				displayname = "黑暗深渊",
				displayshort = "BFD",
				filename = "BlackfathomDeeps",
				location = "灰谷 (14, 14)",
				levels = "24-32",
				players = "10",
				prereq = "",
				general = "有一些水下部分",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {33, 10} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {50, 68} }, symbol = { AM_CHEST_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl3  = { text = "加摩拉", colour = AM_RED, coords = { {23.5, 42} }, symbol = { "1" },
						tooltiptxt = "Lvl25 精英野兽 (巨型海龟)", lootid = "BFDGhamoora" },
				dtl4  = { text = "潮湿的便笺", colour = AM_ORANGE, coords = { {23.5, 30} }, symbol = { "2" },
						tooltiptxt = "箱子中,'深渊中的知识',\n的任务物品" },
				dtl5  = { text = "萨利维丝", colour = AM_RED, coords = { {3, 29} }, symbol = { "3" },
						tooltiptxt = "Lvl25 精英人形生物", lootid = "BFDLadySarevess" },
				dtl6  = { text = "银月守卫塞尔瑞德", colour = AM_BLUE, coords = { {11, 51} }, symbol = { "4" },
						tooltiptxt = "'寻找塞尔瑞德'的任务目标,\n& 任务'黑暗深渊中的邪恶'起始" },
				dtl7  = { text = "格里哈斯特", colour = AM_RED, coords = { {43, 40} }, symbol = { "5" },
						tooltiptxt = "Lvl25 精英人形生物 (鱼人)", lootid = "BFDGelihast" },
				dtl8  = { text = "洛古斯·杰特", colour = AM_RED, coords = { {49, 43}, {55, 46} }, symbol = { "6" },
						tooltiptxt = "Lvl26 精英人形生物", special = AM_VARIES },
				dtl9  = { text = "阿奎尼斯男爵", colour = AM_RED, coords = { {52, 76} }, symbol = { "7" },
						tooltiptxt = "Lvl28 精英人形生物", lootid = "BFDBaronAquanis" },
				dtl10 = { text = "深渊之核", colour = AM_BLUE, coords = { {52, 76} }, symbol = { " " },
						tooltiptxt = "" },
				dtl11 = { text = "梦游者克尔里斯", colour = AM_RED, coords = { {63, 81} }, symbol = { "8" },
						tooltiptxt = "Lvl27 精英人形生物", lootid = "BFDTwilightLordKelris" },
				dtl12 = { text = "黑暗深渊祭坛", colour = AM_BLUE, coords = { {63, 81} }, symbol = { " " },
						tooltiptxt = "" },
				dtl13 = { text = "瑟拉吉斯", colour = AM_RED, coords = { {63, 74} }, symbol = { "9" },
						tooltiptxt = "Lvl26 精英野兽", lootid = "BFDOldSerrakis" },
				dtl14 = { text = "阿库迈尔", colour = AM_RED, coords = { {95, 85} }, symbol = { "10" },
						tooltiptxt = "Lvl29 精英野兽 (九头蛇)", lootid = "BFDAkumai", leaveGap = 1 },
				dtl15 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "BFDTrash", leaveGap = 1 }
			},

			{	name = "黑石深渊",			-- Blackrock Depths
				type = AM_TYP_INSTANCE,
				displayname = "黑石深渊",
				displayshort = "BRD",
				filename = "BlackrockDepths",
				location = "黑石山",
				levels = "52-60",
				players = "10",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {21, 83} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl2  = { text = "洛考尔", colour = AM_RED, coords = { {33, 80} }, symbol = { "1" },
						tooltiptxt = "Lvl51 精英元素生物", lootid = "BRDLordRoccor" },
				dtl3  = { text = "审讯官格斯塔恩", colour = AM_RED, coords = { {38, 95} }, symbol = { "2" },
						tooltiptxt = "Lvl52 精英人形生物", lootid = "BRDHighInterrogatorGerstahn" },
				dtl4  = { text = "温德索尔元帅", colour = AM_BLUE, coords = { {46, 95} }, symbol = { "3" },
						tooltiptxt = "奥妮克希亚任务链中的一个环节" },
				dtl5  = { text = "指挥官哥沙克", colour = AM_BLUE, coords = { {40, 90} }, symbol = { "4" },
						tooltiptxt = "任务'指挥官哥沙克'" },
				dtl6  = { text = "卡兰·巨锤", colour = AM_BLUE, coords = { {44, 86} }, symbol = { "5" },
						tooltiptxt = "任务'卡兰·巨锤'" },
				dtl7  = { text = "法律之环", colour = AM_GREEN, coords = { {42, 73.4} }, symbol = { "6" },
						tooltiptxt = "击败这里的怪物以转换\n上层的观众从\n红色敌对状态到黄色中立状态", lootid = "BRDArena" },
				dtl8  = { text = "塞尔德林", colour = AM_RED, coords = { {42, 73.4} }, symbol = { " " },
						tooltiptxt = "NPC小组队长" , lootid = "BRDArena" },
				dtl9  = { text = "弗兰克罗恩·铸铁的雕像", colour = AM_BLUE, coords = { {45.8, 78.1} }, symbol = { "7" },
						tooltiptxt = "任务'黑铁的遗产'" },
				dtl10 = { text = "控火师罗格雷恩", colour = AM_RED, coords = { {48, 78} }, symbol = { "8" },
						tooltiptxt = "Lvl52 精英人形生物", special = AM_RARE, lootid = "BRDPyromantLoregrain" },
				dtl11 = { text = "黑色宝库", colour = AM_GREEN, coords = { {54, 54} }, symbol = { "9" },
						tooltiptxt = "" },
				dtl12  = { text = "弗诺斯·达克维尔", colour = AM_RED, coords = { {55, 41} }, symbol = { "10" },
						tooltiptxt = "Lvl54 精英人形生物", lootid = "BRDFineousDarkvire" },
				dtl13 = { text = "典狱官斯迪尔基斯", colour = AM_RED, coords = { {48, 55} }, symbol = { "11" },
						tooltiptxt = "Lvl56 精英人形生物", lootid = "BRDWarderStilgiss" },
				dtl14 = { text = "维雷克", colour = AM_RED, coords = { {54, 54} }, symbol = { " " },
						tooltiptxt = "Lvl55 精英" },
				dtl15 = { text = "伊森迪奥斯", colour = AM_RED, coords = { {48.7, 48.1} }, symbol = { "12" },
						tooltiptxt = "任务'伊森迪奥斯!'", lootid = "BRDLordIncendius" },
				dtl16 = { text = "黑铁砧", colour = AM_RED, coords = { {48.7, 48.1} }, symbol = { " " },
						tooltiptxt = "" },
				dtl17 = { text = "暗炉之锁", colour = AM_GREEN, coords = { {31, 72.4} }, symbol = { "13" },
						tooltiptxt = "开启以打开下层到上层区域的通道\n需要暗炉钥匙" },
				dtl18 = { text = "贝尔加", colour = AM_RED, coords = { {8, 62} }, symbol = { "14" },
						tooltiptxt = "Lvl57 精英山岭巨人", lootid = "BRDBaelGar" },
				dtl19 = { text = "安格弗将军", colour = AM_RED, coords = { {24, 64} }, symbol = { "15" },
						tooltiptxt = "Lvl57 精英侏儒", lootid = "BRDGeneralAngerforge" },
				dtl20 = { text = "傀儡统帅阿格曼奇", colour = AM_RED, coords = { {24, 51} }, symbol = { "16" },
						tooltiptxt = "Lvl58 精英侏儒", lootid = "BRDGolemLordArgelmach" },
				dtl21 = { text = "黑铁酒吧", colour = AM_GREEN, coords = { {40, 50} }, symbol = { "17" },
						tooltiptxt = "买6个黑铁酒杯\n然后给他们干杯 ;P", lootid = "BRDGuzzler" },
				dtl22 = { text = "弗莱拉斯大使", colour = AM_RED, coords = { {46, 38} }, symbol = { "18" },
						tooltiptxt = "Lvl57 精英人形生物", lootid = "BRDFlamelash" },
				dtl23 = { text = "无敌的潘佐尔", colour = AM_RED, coords = { {40, 27} }, symbol = { "19" },
						tooltiptxt = "Lvl57 精英机器", special = AM_RARE, lootid = "BRDPanzor" },
				dtl24 = { text = "召唤者之墓", colour = AM_GREEN, coords = { {46, 18} }, symbol = { "20" },
						tooltiptxt = "逐一击败7个首领以到达更深处\n& 获得箱子", lootid = "BRDTomb" },
				dtl25 = { text = "讲学厅", colour = AM_GREEN, coords = { {61, 8.5} }, symbol = { "21" },
						tooltiptxt = "找到并击败2个暗炉持火者\n然后点亮两个火炬以继续.\n从杀死第一个起只有3分钟时间." },
				dtl26 = { text = "玛格姆斯", colour = AM_RED, coords = { {78, 8.5} }, symbol = { "22" },
						tooltiptxt = "Lvl57 精英山岭巨人", lootid = "BRDMagmus" },
				dtl27 = { text = "铁炉堡公主茉艾拉·铜须", colour = AM_RED, coords = { {90, 8} }, symbol = { "23" },
						tooltiptxt = "Lvl58 精英人形生物", lootid = "BRDPrincess" },
				dtl28 = { text = "达格兰·索瑞森大帝", colour = AM_RED, coords = { {93, 8.5} }, symbol = { "24" },
						tooltiptxt = "Lvl59 精英人形生物", lootid = "BRDImperatorDagranThaurissan" },
				dtl29 = { text = "黑熔炉", colour = AM_GREEN, coords = { {63, 22} }, symbol = { "23" },
						tooltiptxt = "熔炼黑铁,\n及制造浓烟山脉之心" },
				dtl30 = { text = "熔火之心", colour = AM_ORANGE, coords = { {65, 30} }, symbol = { "24" },
						tooltiptxt = "任务'熔火之心的传送门'\n熔火之心入口", toMap = "熔火之心", leaveGap = 1 }
			},

			{	name = "黑石塔",		-- Blackrock Spire
				type = AM_TYP_INSTANCE,
				displayname = "黑石塔 (下层)",
				displayshort = "LBRS",
				filename = "LBRS",			-- LBRS
				location = "黑石山",
				levels = "53-60",
				players = "15",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {9, 10} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = "黑石塔 (上层)", colour = AM_BLUE, coords = { {22, 4} }, symbol = { "U" },
						tooltiptxt = "", toMap = "黑石塔 (上层)" },
				dtl3  = { text = AM_LEADSTO, colour = AM_GREEN, coords = { {45.2, 29}, {73, 46} }, symbol = { "x1" },
						tooltiptxt = "" },
				dtl4  = { text = "通往欧莫克大王的桥", colour = AM_GREEN, coords = { {38, 32.1}, {15, 32.1} }, symbol = { "B" },
						tooltiptxt = "" },
				dtl5  = { text = AM_LEADSTO, colour = AM_GREEN, coords = { {71, 22}, {94, 26} }, symbol = { "x2" },
						tooltiptxt = "下层" },
				dtl6  = { text = AM_LEADSTO, colour = AM_GREEN, coords = { {29, 53}, {29, 77} }, symbol = { "x3" },
						tooltiptxt = "" },
				dtl7  = { text = "斜坡", colour = AM_BLUE, coords = { {86, 40}, {89, 58} }, symbol = { "R" },
						tooltiptxt = "", leaveGap = 1 },
				dtl8  = { text = "维埃兰", colour = AM_RED, coords = { {31, 17} }, symbol = { "1" },
						tooltiptxt = "Lvl55 精英\n晋升印章任务"  },
				dtl9  = { text = "瓦罗什", colour = AM_RED, coords = { {53, 14} }, symbol = { "2" },
						tooltiptxt = "Lvl60 精英人形生物"  },
				dtl10 = { text = "尖锐长矛", colour = AM_ORANGE, coords = { {69, 29} }, symbol = { "3" },
						tooltiptxt = "任务物品"  },
				dtl11 = { text = "比修", colour = AM_BLUE, coords = { {62, 25 } }, symbol = { "4" },
						tooltiptxt = "比修任务链\n不在下层" },
				dtl12 = { text = "尖石屠夫", colour = AM_RED, coords = { {42, 32.1} }, symbol = { "5" },
						tooltiptxt = "Lvl59 精英人形生物\n在通往欧莫克大王的桥上巡逻", lootid = "LBRSSpirestoneButcher", special = AM_RARE  },
				dtl13 = { text = "欧莫克大王", colour = AM_RED, coords = { {2, 32.1} }, symbol = { "6" },
						tooltiptxt = "Lvl?? 精英人形生物", lootid = "LBRSOmokk"  },
				dtl14 = { text = "尖石统帅", colour = AM_RED, coords = { {2, 32.1} }, symbol = { " " },
						tooltiptxt = "出现在欧莫克大王附近的小山", lootid = "LBRSSpirestoneLord", special = AM_RARE },
				dtl15 = { text = "暗影猎手沃什加斯", colour = AM_RED, coords = { {77, 64} }, symbol = { "7" },
						tooltiptxt = "Lvl?? 精英人形生物", lootid = "LBRSVosh"  },
				dtl16 = { text = "第五块摩沙鲁石板", colour = AM_ORANGE, coords = { {77, 68} }, symbol = { "8" },
						tooltiptxt = "任务物品"  },
				dtl17 = { text = "班诺克·巨斧", colour = AM_RED, coords = { {41.5, 26.5} }, symbol = { "9" },
						tooltiptxt = "Lvl59 精英人形生物\n在下层", lootid = "LBRSGrimaxe", special = AM_RARE },
				dtl18 = { text = "指挥官沃恩", colour = AM_RED, coords = { {73, 32} }, symbol = { "10" },
						tooltiptxt = "Lvl59 精英人形生物", lootid = "LBRSVoone" },
				dtl19 = { text = "第六块摩沙鲁石板", colour = AM_ORANGE, coords = { {75, 29} }, symbol = { "11" },
						tooltiptxt = "任务物品"  },
				dtl20 = { text = "莫尔·灰蹄", colour = AM_RED, coords = { {75, 35} }, symbol = { "12" },
						tooltiptxt = "Lvl60 精英\n需要召唤火盆\n打断他们的治疗", lootid = "LBRSGrayhoof" },
				dtl21 = { text = "烟网蛛后", colour = AM_RED, coords = { {54, 58} }, symbol = { "13" },
						tooltiptxt = "Lvl59 精英野兽", lootid = "LBRSSmolderweb"  },
				dtl22 = { text = "水晶之牙", colour = AM_RED, coords = { {36, 49} }, symbol = { "14" },
						tooltiptxt = "Lvl60 精英野兽", special = AM_RARE, lootid = "LBRSCrystalFang"  },
				dtl23 = { text = "乌洛克", colour = AM_RED, coords = { {30, 30} }, symbol = { "15" },
						tooltiptxt = "Lvl60 精英人形生物", lootid = "LBRSDoomhowl"  },
				dtl24 = { text = "军需官兹格雷斯", colour = AM_RED, coords = { {50, 89} }, symbol = { "16" },
						tooltiptxt = "Lvl59 精英人形生物", lootid = "LBRSZigris"  },
				dtl25 = { text = "哈雷肯", colour = AM_RED, coords = { {19, 92} }, symbol = { "17" },
						tooltiptxt = "Lvl59 精英野兽\n杀死以触发基兹鲁尔出现", lootid = "LBRSHalycon"  },
				dtl26 = { text = "奴役者基兹鲁尔", colour = AM_RED, coords = { {19, 92} }, symbol = { " " },
						tooltiptxt = "Lvl60 精英野兽\n哈雷肯死亡后触发其出现", lootid = "LBRSSlavener"  },
				dtl27 = { text = "维姆萨拉克", colour = AM_RED, coords = { {42, 62} }, symbol = { "18" },
						tooltiptxt = "Lvl?? 精英龙类", lootid = "LBRSWyrmthalak", leaveGap = 1  },
				dtl28 = { text = AM_TIER0_SET, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "T0SET", leaveGap = 1 },
				dtl29 = { text = AM_MOB_LOOT, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "LBRSTrash", leaveGap = 1 }
			},

			{	name = "黑石塔 (上层)",
				type = AM_TYP_INSTANCE,
				displayname = "黑石塔 (上层)",
				displayshort = "UBRS",
				filename = "UBRS",			-- UBRS
				location = "黑石山",
				levels = "53-60",
				players = "15",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {3, 80.7} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = "黑石塔 (下层)", colour = AM_BLUE, coords = { {18.2, 86.6} }, symbol = { "L" },
						tooltiptxt = "", toMap = "黑石塔", leaveGap = 1 },
				dtl3  = { text = AM_LEADSTO, colour = AM_GREEN, coords = { {11.9, 58.4}, {8.65, 25} }, symbol = { "x1" },
						tooltiptxt = "" },
				dtl4  = { text = "烈焰卫士艾博希尔", colour = AM_RED, coords = { {8.2, 31.0} }, symbol = { "1" },
						tooltiptxt = "Lvl?? 精英元素生物", lootid = "UBRSEmberseer", leaveGap = 1  },
				dtl5  = { text = AM_LEADSTO, colour = AM_GREEN, coords = { {8.6, 38.9}, {36.4, 61.2} }, symbol = { "x2" },
						tooltiptxt = "" },
				dtl6  = { text = "末日扣环", colour = AM_ORANGE, coords = { {41.3, 68.65} }, symbol = { "2" },
						tooltiptxt = "任务物品\n在坍塌的柱子中间的巨大箱子里\n难以辨认\n可以从达基萨斯将军处下来"  },
				dtl7  = { text = "烈焰之父", colour = AM_ORANGE, coords = { {50, 65.45} }, symbol = { "3" },
						tooltiptxt = "战斗触发于门口附近\n阻止群居孵化者孵化蛋", lootid = "UBRSFLAME"  },
				dtl8  = { text = "索拉卡·火冠", colour = AM_RED, coords = { {50, 65.45} }, symbol = { " " },
						tooltiptxt = "Lvl60 精英龙类\n拾取烈焰之父后出现", lootid = "UBRSSolakar" },
				dtl9  = { text = "杰德", colour = AM_RED, coords = { {47, 52.6} }, symbol = { "4" },
						tooltiptxt = "Lvl59 精英人形生物", special = AM_RARE, lootid = "UBRSRunewatcher"  },
				dtl10 = { text = "古拉鲁克", colour = AM_RED, coords = { {34, 52.6} }, symbol = { "5" },
						tooltiptxt = "Lvl61 精英人形生物", lootid = "UBRSAnvilcrack"  },
				dtl11 = { text = "大酋长雷德·黑手", colour = AM_RED, coords = { {67.5, 51} }, symbol = { "6" },
						tooltiptxt = "首领 \n限制性任务'为部落而战!'\n出现时乘坐盖斯", lootid = "UBRSRend"  },
				dtl12 = { text = "盖斯", colour = AM_RED, coords = { {67.5, 51} }, symbol = { " " },
						tooltiptxt = "Lvl?? 精英龙类", lootid = "UBRSGyth" },
				dtl13 = { text = "奥比", colour = AM_BLUE, coords = { {68.1, 65.9} }, symbol = { "7" },
						tooltiptxt = "限制性任务'监护者'"  },
				dtl14 = { text = "比斯巨兽", colour = AM_RED, coords = { {95.7, 60.8} }, symbol = { "8" },
						tooltiptxt = "Lvl?? 精英野兽", lootid = "UBRSBeast"  },
				dtl15 = { text = "瓦塔拉克公爵", colour = AM_RED, coords = { {95.7, 56.5} }, symbol = { "9" },
						tooltiptxt = "Lvl?? 精英\n需要任务召唤\n请首先清理黑手大厅", lootid = "UBRSValthalak" },
				dtl16 = { text = "达基萨斯将军", colour = AM_RED, coords = { {41.6, 73.2} }, symbol = { "10" },
						tooltiptxt = "Lvl?? 精英龙类", lootid = "UBRSDrakkisath"  },
				dtl17 = { text = "黑翼之巢", colour = AM_BLUE, coords = { {78.5, 27.6} }, symbol = { "BWL" },
						tooltiptxt = "", toMap = "黑翼之巢", leaveGap = 1 },
				dtl18 = { text = AM_TIER0_SET, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "T0SET", leaveGap = 1 },
				dtl19 = { text = AM_MOB_LOOT, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "UBRSTrash", leaveGap = 1 }
			},

			{	name = "黑翼之巢",		-- Blackwing Lair
				type = AM_TYP_INSTANCE,
				displayname = "黑翼之巢",
				displayshort = "BWL",
				filename = "BlackwingLair",
				location = "黑石山",
				levels = "60+",
				players = "40",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {65, 72} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", toMap = "黑石塔 (上层)", leaveGap = 1 },
				dtl2 = { text = AM_LEADSTO, colour = AM_GREEN, coords = { {32.8, 78}, {61, 48} }, symbol = { "x1" },
						tooltiptxt = "" },
				dtl3 = { text = AM_LEADSTO, colour = AM_GREEN, coords = { {40, 96}, {68, 65} }, symbol = { "x2" },
						tooltiptxt = "" },
				dtl4 = { text = AM_LEADSTO, colour = AM_GREEN, coords = { {47, 51}, {17, 52} }, symbol = { "x3" },
						tooltiptxt = "", leaveGap = 1 },
				dtl5  = { text = "狂野的拉格佐尔", colour = AM_RED, coords = { {51, 66} }, symbol = { "1" },
						tooltiptxt = "首领", lootid = "BWLRazorgore"  },
				dtl6  = { text = "堕落的瓦拉斯塔兹", colour = AM_RED, coords = { {32.5, 67} }, symbol = { "2" },
						tooltiptxt = "首领", lootid = "BWLVaelastrasz"  },
				dtl7  = { text = "勒什雷尔", colour = AM_RED, coords = { {77, 42} }, symbol = { "3" },
						tooltiptxt = "首领", lootid = "BWLLashlayer"  },
				dtl8  = { text = "费尔默", colour = AM_RED, coords = { {12, 44} }, symbol = { "4" },
						tooltiptxt = "首领", lootid = "BWLFiremaw"  },
				dtl9  = { text = "埃博诺克", colour = AM_RED, coords = { {10, 29} }, symbol = { "5" },
						tooltiptxt = "首领", lootid = "BWLEbonroc"  },
				dtl10 = { text = "弗莱格尔", colour = AM_RED, coords = { {18, 29} }, symbol = { "6" },
						tooltiptxt = "首领", lootid = "BWLFlamegor"  },
				dtl11 = { text = "克洛玛古斯", colour = AM_RED, coords = { {33, 40} }, symbol = { "7" },
						tooltiptxt = "首领", lootid = "BWLChromaggus"  },
				dtl12 = { text = "奈法利安", colour = AM_RED, coords = { {60, 14} }, symbol = { "8" },
						tooltiptxt = "首领", lootid = "BWLNefarian", leaveGap = 1 },
				dtl13 = { text = AM_MOB_LOOT, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "BWLTrashMobs", leaveGap = 1 },
				dtl14 = { text = AM_TIER2_SET, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "T2SET", leaveGap = 1 }
			},

			{	name = "厄运之槌"..AM_EXTERIOR,		-- Dire Maul Exterior
				type = AM_TYP_RAID,
				displayname = AM_EXTERIOR.." - 厄运之槌",
				displayshort = "DM",
				filename = "DireMaulExt",
				location = "菲拉斯 (59, 44)",
				levels = "",
				players = "",
				prereq = "",
				general = "",
				area = "Kalimdor",
				wmData = { minX = 0.4268, maxX = 0.441, minY =  0.6648, maxY = 0.696 },
				amData = { minX = 0.29, maxX = 0.97, minY = 0.025, maxY = 0.98 },
				dtl1  = { text = "入口", colour = AM_GREEN, coords = { {32, 97}  }, symbol = { "X" },
						tooltiptxt = "", toMap = "Dire Maul", leaveGap = 1 },
				dtl2  = { text = "艾德雷斯区", colour = AM_BLUE, coords = { {57, 73} }, symbol = { "1" },
						tooltiptxt = "" },
				dtl3  = { text = "被毁坏的庭院", colour = AM_BLUE, coords = { {62, 50} }, symbol = { "2" },
						tooltiptxt = "" },
				dtl4  = { text = "无敌的斯卡尔", colour = AM_RED, coords = { {62, 33} }, symbol = { "3" },
						tooltiptxt = "Lvl58 精英人形生物" },
				dtl5  = { text = "巨槌竞技场", colour = AM_RED, coords = { {62, 26} }, symbol = { "4" },
						tooltiptxt = "PvP 区域" },
				dtl6  = { text = "通往巨槌竞技场", colour = AM_BLUE, coords = { {44, 47}, {58, 33} }, symbol = { "P" },
						tooltiptxt = "沉睡的戈多克土狼" },
				dtl7  = { text = "顶部为厄运之槌西出口的房间", colour = AM_BLUE, coords = { {85, 19.4} }, symbol = { "5" },
						tooltiptxt = "", leaveGap = 1 },
				dtl8  = { text = "厄运之槌东", colour = AM_GREEN, coords = { {84, 32}, {96, 62} }, symbol = { "E" },
						tooltiptxt = "点击打开厄运之槌东地图", toMap = "厄运之槌 (东)" },
				dtl9  = { text = "厄运之槌北", colour = AM_GREEN, coords = { {62, 4} }, symbol = { "N" },
						tooltiptxt = "点击打开厄运之槌北地图", toMap = "厄运之槌 (北)" },
				dtl10 = { text = "厄运之槌西", colour = AM_GREEN, coords = { {42, 40} }, symbol = { "W" },
						tooltiptxt = "点击打开厄运之槌西地图", toMap = "厄运之槌 (西)", leaveGap = 1 }
			},

			{	name = "厄运之槌",		-- Dire Maul
				type = AM_TYP_INSTANCE,
				displayname = "厄运之槌 - 概貌",
				displayshort = "DM",
				filename = "DireMaul",
				location = "菲拉斯 (59, 44)",
				levels = "56-60",
				players = "5",
				prereq = "",
				general = "",
				dtl1  = { text = "厄运之槌东", colour = AM_GREEN, coords = { {53, 81}, {57, 96}, {100, 80} }, symbol = { "E" },
						tooltiptxt = "点击打开厄运之槌东地图", toMap = "厄运之槌 (东)" },
				dtl2  = { text = "厄运之槌北", colour = AM_GREEN, coords = { {67.5, 38} }, symbol = { "N" },
						tooltiptxt = "点击打开厄运之槌北地图", toMap = "厄运之槌 (北)" },
				dtl3  = { text = "厄运之槌西", colour = AM_GREEN, coords = { {47, 88} }, symbol = { "W" },
						tooltiptxt = "点击打开厄运之槌西地图", toMap = "厄运之槌 (西)", leaveGap = 1 },
				dtl4  = { text = "图书馆", colour = AM_BLUE, coords = { {24, 58}, {41, 41} }, symbol = { "L" },
						tooltiptxt = "从北或西厄运之槌到达", leaveGap = 1 }
			},


			{	name = "厄运之槌 (东)",		-- Dire Maul East
				type = AM_TYP_INSTANCE,
				displayname = "厄运之槌 (东)",
				displayshort = "DM",
				filename = "DMEast",		--DMEast
				location = "厄运之槌 (59, 44)",
				levels = "56-60",
				players = "5",
				prereq = "",
				general = "",
				dtl1  = { text = "入口 : 被毁坏的庭院", colour = AM_GREEN, coords = { {6, 58}  }, symbol = { "X1" },
						tooltiptxt = "", toMap = "Dire Maul"..AM_EXTERIOR },
				dtl2  = { text = "入口 : 艾德雷斯区", colour = AM_GREEN, coords = { {12, 92} }, symbol = { "X2" },
						tooltiptxt = "", toMap = "Dire Maul"..AM_EXTERIOR },
				dtl3  = { text = "入口 : 拉瑞斯小亭", colour = AM_GREEN, coords = { {98, 64} }, symbol = { "X3" },
						tooltiptxt = "" },
				dtl4  = { text = AM_INSTANCE_EXITS, colour = AM_RED, coords = { {8, 40} }, symbol = { AM_EXIT_SYMBOL },
						tooltiptxt = "掉下到达被毁坏的庭院\n旁的房间" },
				dtl5  = { text = AM_LEADSTO, colour = AM_BLUE, coords = { {41, 85}, {61, 93} }, symbol = { "L1" },
						tooltiptxt = "" },
				dtl6  = { text = AM_LEADSTO, colour = AM_BLUE, coords = { {75, 92}, {55, 82} }, symbol = { "L2" },
						tooltiptxt = "" },
				dtl7  = { text = AM_LEADSTO, colour = AM_BLUE, coords = { {67, 63}, {83, 73} }, symbol = { "L3" },
						tooltiptxt = "", leaveGap = 1 },
				dtl8  = { text = "开始追捕普希林", colour = AM_GREEN, coords = { {10, 50} }, symbol = { "P" },
						tooltiptxt = "追捕以获得厄运之槌(月牙)钥匙", lootid = "DMEPusillin"  },
				dtl9  = { text = "结束追捕普希林", colour = AM_RED, coords = { {79, 61} }, symbol = { "P" },
						tooltiptxt = "Oooh, you little Imp!", lootid = "DMEPusillin"  },
				dtl10 = { text = "瑟雷姆·刺蹄", colour = AM_RED, coords = { {83, 88} }, symbol = { "1" },
						tooltiptxt = "Lvl57 精英恶魔", lootid = "DMEZevrimThornhoof"  },
				dtl11 = { text = "海多斯博恩", colour = AM_RED, coords = { {64, 77} }, symbol = { "2" },
						tooltiptxt = "Lvl57 精英元素生物", lootid = "DMEHydro"  },
				dtl12 = { text = "雷瑟塔帝丝", colour = AM_RED, coords = { {46, 66} }, symbol = { "3" },
						tooltiptxt = "Lvl57 精英人形生物", lootid = "DMELethtendris"  },
				dtl13 = { text = "埃隆巴克", colour = AM_RED, coords = { {21, 69} }, symbol = { "4" },
						tooltiptxt = "开门"  },
				dtl14 = { text = "奥兹恩", colour = AM_RED, coords = { {42, 23} }, symbol = { "5" },
						tooltiptxt = "Lvl58 精英恶魔", lootid = "DMEAlzzin"  },
				dtl15 = { text = "伊萨莉恩", colour = AM_RED, coords = { {42, 23} }, symbol = { " " },
						tooltiptxt = "需要召唤火盆召唤\n从黑石山的伯德雷处获取任务", lootid = "DMEIsalien", leaveGap = 2 },
				dtl16 = { text = "书籍", colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DMBooks", leaveGap = 1 },
				dtl17 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DMETrash", leaveGap = 1 }
			},

			{	name = "厄运之槌 (北)",		-- Dire Maul North
				type = AM_TYP_INSTANCE,
				displayname = "厄运之槌 (北)",
				displayshort = "DM",
				filename = "DMNorth",		-- DMNorth
				location = "厄运之槌 (59, 44)",
				levels = "56-60",
				players = "5",
				prereq = "需要从厄运之槌东追捕追捕普希林任务的月牙钥匙",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {74, 74} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", toMap = "Dire Maul"..AM_EXTERIOR },
				dtl2  = { text = "厄运之槌(西)", colour = AM_GREEN, coords = { {9, 98} }, symbol = { "W" },
						tooltiptxt = "", toMap = "厄运之槌 (西)" },
				dtl3  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {49.2, 59.4} }, symbol = { AM_CHEST_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl4  = { text = "卫兵摩尔达", colour = AM_RED, coords = { {76.4, 55.5} }, symbol = { "1" },
						tooltiptxt = "Lvl59 精英人形生物", lootid = "DMNGuardMoldar"  },
				dtl5  = { text = "践踏者克雷格", colour = AM_RED, coords = { {67, 49} }, symbol = { "2" },
						tooltiptxt = "Lvl57 精英恶魔", lootid = "DMNStomperKreeg"  },
				dtl6  = { text = "卫兵芬古斯", colour = AM_RED, coords = { {49.2, 56.1} }, symbol = { "3" },
						tooltiptxt = "Lvl59 精英人形生物", lootid = "DMNGuardFengus"  },
				dtl7  = { text = "卫兵斯里基克", colour = AM_RED, coords = { {17, 41} }, symbol = { "4" },
						tooltiptxt = "Lvl59 精英人形生物", lootid = "DMNGuardSlipkik"  },
				dtl8  = { text = "诺特·希姆加可", colour = AM_RED, coords = { {19, 37} }, symbol = { "5" },
						tooltiptxt = "", lootid = "DMNThimblejack"  },
				dtl9  = { text = "克罗卡斯", colour = AM_RED, coords = { {24.6, 34.8} }, symbol = { "6" },
						tooltiptxt = "", lootid = "DMNCaptainKromcrush"  },
				dtl10 = { text = "戈多克大王", colour = AM_RED, coords = { {24.2, 11.2} }, symbol = { "7" },
						tooltiptxt = "", lootid = "DMNKingGordok"  },
				dtl11 = { text = "图书馆", colour = AM_BLUE, coords = { {20, 89} }, symbol = { "8" },
						tooltiptxt = "", leaveGap = 2  },
				dtl12 = { text = "贡品", colour = AM_PURPLE, coords = { {0, 0 } }, symbol = { " " },
						tooltiptxt = "", lootid = "DMNTRIBUTERUN" },
				dtl13 = { text = "书籍", colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DMBooks", leaveGap = 1 }
			},

			{	name = "厄运之槌 (西)",		-- Dire Maul West
				type = AM_TYP_INSTANCE,
				displayname = "厄运之槌 (西)",
				displayshort = "DM",
				filename = "DMWest",		-- DMWest
				location = "厄运之槌 (59, 44)",
				levels = "56-60",
				players = "5",
				prereq = "需要从厄运之槌东追捕追捕普希林任务的月牙钥匙",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {97, 78} }, symbol = { "X1" },
						tooltiptxt = "", toMap = "Dire Maul"..AM_EXTERIOR },
				dtl2  = { text = "厄运之槌 (北)", colour = AM_GREEN, coords = { {66, 9} }, symbol = { "N" },
						tooltiptxt = "", toMap = "厄运之槌 (北)", leaveGap = 1 },
				dtl3  = { text = "楼梯", colour = AM_BLUE, coords = { {49.2, 25}, {52, 60} }, symbol = { AM_STAIRS_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl4  = { text = "水晶塔", colour = AM_GREEN, coords = { {83, 80}, {64, 61}, {64, 87}, {27, 62}, {27, 37} }, symbol = { "P" },
						tooltiptxt = "摧毁这些", leaveGap = 1 },
				dtl5  = { text = "辛德拉古灵", colour = AM_ORANGE, coords = { {68, 74} }, symbol = { "1" },
						tooltiptxt = "杀死王子的任务" },
				dtl6  = { text = "特迪斯·扭木", colour = AM_RED, coords = { {58, 74} }, symbol = { "2" },
						tooltiptxt = "Lvl60 精英元素生物", lootid = "DMWTendrisWarpwood" },
				dtl7  = { text = "伊琳娜·暗木", colour = AM_RED, coords = { {49, 87} }, symbol = { "3" },
						tooltiptxt = "Lvl60 精英亡灵", lootid = "DMWIllyannaRavenoak" },
				dtl8  = { text = "苏斯", colour = AM_RED, coords = { {48, 60} }, symbol = { "4" },
						tooltiptxt = "Lvl59 精英亡灵", special = AM_RARE, lootid = "DMWTsuzee" },
				dtl9  = { text = "卡雷迪斯镇长", colour = AM_RED, coords = { {53, 51} }, symbol = { "5" },
						tooltiptxt = "Lvl60 精英亡灵", lootid = "DMWMagisterKalendris" },
				dtl10 = { text = "伊莫塔尔", colour = AM_RED, coords = { {19, 49} }, symbol = { "6" },
						tooltiptxt = "Lvl61 精英恶魔", lootid = "DMWImmolthar" },
				dtl11 = { text = "赫尔努拉斯", colour = AM_RED, coords = { { 19, 49} }, symbol = { " " },
						tooltiptxt = "Lvl62 精英恶魔\n术士史诗坐骑任务召唤部分", lootid = "DMWHelnurath" },
				dtl12 = { text = "托塞德林王子", colour = AM_RED, coords = { {41, 26} }, symbol = { "7" },
						tooltiptxt = "Lvl61 精英人形生物", lootid = "DMWPrinceTortheldrin", leaveGap = 1  },
				dtl13 = { text = "图书馆", colour = AM_BLUE, coords = { {51, 20} }, symbol = { "8" },
						tooltiptxt = "", leaveGap = 1 },
				dtl14 = { text = "书籍", colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DMBooks", leaveGap = 1 },
				dtl15 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DMWTrash", leaveGap = 1 }
			},

			{	name = "诺莫瑞根",			-- Gnomeregan
				type = AM_TYP_INSTANCE,
				displayname = "诺莫瑞根",
				filename = "Gnomeregan",
				location = "丹莫罗 (25, 41)",
				levels = "26-33",
				players = "10",
				prereq = "",
				general = "部落经由藏宝海湾传送器进入.\n从奥格瑞玛工程师处获得起始任务.",
				dtl1  = { text = "正门入口 (发条小径)", colour = AM_GREEN, coords = { {70.5, 16} }, symbol = { "X1" },
						tooltiptxt = "", toMap = "诺莫瑞根"..AM_EXTERIOR },
				dtl2  = { text = "后门入口 (车间)", colour = AM_GREEN, coords = { {87, 59} }, symbol = { "X2" },
						tooltiptxt = "需要车间钥匙", toMap = "诺莫瑞根"..AM_EXTERIOR },
				dtl3  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {75, 38}, {79, 56} }, symbol = { AM_CHEST_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl4  = { text = "粘性辐射尘", colour = AM_RED, coords = { {71.5, 33.5} }, symbol = { "1" },
						tooltiptxt = "Lvl30 精英元素生物\n下层", lootid = "GnViscousFallout" },
				dtl5  = { text = "格鲁比斯", colour = AM_RED, coords = { {95, 46} }, symbol = { "2" },
						tooltiptxt = "Lvl32 精英人形生物\n触发出现\n与同一位置的爆破专家艾米·短线交谈", lootid = "GnGrubbis"  },
				dtl6  = { text = "克努比 (The Dormitory)", colour = AM_BLUE, coords = { {76, 54} }, symbol = { "3" },
						tooltiptxt = ""  },
				dtl7  = { text = "矩阵式打孔计算机 3005-B", colour = AM_GREEN, coords = { {70, 50} }, symbol = { "B" },
						tooltiptxt = "卡片升级"  },
				dtl8  = { text = "清洗区", colour = AM_GREEN, coords = { {64, 46} }, symbol = { "4" },
						tooltiptxt = ""  },
				dtl9  = { text = "电刑器6000型", colour = AM_RED, coords = { {30, 49} }, symbol = { "5" },
						tooltiptxt = "Lvl32 精英机械\n掉落车间钥匙", lootid = "GnElectrocutioner6000"  },
				dtl10 = { text = "矩阵式打孔计算机 3005-C", colour = AM_GREEN, coords = { {33.2, 49.6} }, symbol = { "C" },
						tooltiptxt = "卡片升级"  },
				dtl11 = { text = "群体打击者 9-60", colour = AM_RED, coords = { {47.6, 77.3} }, symbol = { "6" },
						tooltiptxt = "Lvl32 精英机械", lootid = "GnCrowdPummeler960"  },
				dtl12 = { text = "矩阵式打孔计算机 3005-D", colour = AM_GREEN, coords = { {48.9, 75.7} }, symbol = { "D" },
						tooltiptxt = "卡片升级"  },
				dtl13 = { text = "黑铁大师", colour = AM_RED, coords = { {9, 52} }, symbol = { "5" },
						tooltiptxt = "Lvl33 精英人形生物", special = AM_RARE, lootid = "GnDIAmbassador"  },
				dtl14 = { text = "麦克尼尔·瑟玛普拉格", colour = AM_RED, coords = { {11.8, 42.2} }, symbol = { "8" },
						tooltiptxt = "Lvl35 精英恶魔", lootid = "GnMekgineerThermaplugg", leaveGap = 1  },
				dtl15 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "GnTrash", leaveGap = 1 }
			},

			{	name = "诺莫瑞根"..AM_EXTERIOR,			-- Gnomeregan
				type = AM_TYP_RAID,
				displayname = AM_EXTERIOR.." - 诺莫瑞根",
				filename = "GnomereganExt",
				location = "丹莫罗 (25, 41)",
				levels = "",
				players = "",
				prereq = "",
				general = "部落经由藏宝海湾传送器进入.\n从奥格瑞玛工程师处获得起始任务.",
				wmData = { minX = 0.42812, maxX = 0.43726, minY =  0.52503, maxY = 0.53932 },
				amData = { minX = 0.198, maxX = 0.905, minY = 0.21, maxY = 0.940 },
				dtl1  = { text = "外部", colour = AM_GREEN, coords = { {91.0, 92.5} }, symbol = { "O" },
						tooltiptxt = "" },
				dtl2  = { text = "升降机", colour = AM_GREEN, coords = { {81.59, 87.65} }, symbol = { "L" },
						tooltiptxt = "" },
				dtl3  = { text = "传送器", colour = AM_GREEN, coords = { {60.95, 72.95} }, symbol = { "P" },
						tooltiptxt = "来自藏宝海湾" },
				dtl4  = { text = "斯普洛克", colour = AM_BLUE, coords = { {60.95, 72.95} }, symbol = { " " },
						tooltiptxt = "Away Team", leaveGap = 1 },
				dtl5  = { text = "矩阵式打孔计算机 3005-A", colour = AM_PURPLE, coords = { {67.29, 42.22}, {61.43, 41.78}, {64.00, 26.52}, {69.46, 26.75} }, symbol = { "A" },
						tooltiptxt = "卡片升级" },
				dtl6  = { text = "尖端机器人", colour = AM_RED, coords = { {44.0, 36.53} }, symbol = { "1" },
						tooltiptxt = "Lvl26 精英机械", leaveGap = 1 },
				dtl7  = { text = "主副本入口", colour = AM_ORANGE, coords = { {18.89, 88.0} }, symbol = { "I" },
						tooltiptxt = "", toMap = "诺莫瑞根" },
				dtl8  = { text = "车间副本入口", colour = AM_ORANGE, coords = { {62.46, 22.75} }, symbol = { "W" },
						tooltiptxt = "需要车间钥匙", toMap = "诺莫瑞根", leaveGap = 1  }
			},

			{	name = "Kazzak",			-- Lord Kazzak
				type = AM_TYP_RAID,
				displayname = "卡扎克",
				filename = "AM_Kazzak_Map",
				location = "诅咒之地 : 腐烂之痕 (32, 44)",
				minimapZoom = 1.42,
				minimapXOffset = 95,
				minimapYOffset = 0,
				area = "BlastedLands",
				levels = "60",
				players = AM_NO_LIMIT,
				prereq = "",
				general = "",
				wmData = { minX = 0.33, maxX = 0.49, minY = 0.47, maxY = 0.79 },
				amData = { minX = 0.25, maxX = 0.99, minY = 0.01, maxY = 0.98 },
				dtl1 = { text = "入口", colour = AM_GREEN, coords = { {79, 30} }, symbol = { AM_ENTRANCE },
						tooltiptxt = "", leaveGap = 1 },
				dtl2 = { text = "卡扎克", colour = AM_RED, coords = { {42, 84} }, symbol = { "1" },
						tooltiptxt = "首领", lootid = "KKazzak", leaveGap = 1 },
				dtl3 = { text = "衰老的戴奥", colour = AM_GREEN, coords = { {29.5, 8.5} }, symbol = { "2" },
						tooltiptxt = "", leaveGap = 1 }
			},

			{	name = "Azuregos",				-- Azuregos
				type = AM_TYP_RAID,
				displayname = "艾索雷葛斯",
				filename = "AM_Azuregos_Map",
				location = "艾萨拉 (大概位置 56, 81)",
				minimapZoom = 1.5385,
				minimapXOffset = 0,
				minimapYOffset = 0,
				area = "Aszhara",				-- Deliberately spelt Aszhara !
				levels = "60",
				players = AM_NO_LIMIT,
				prereq = "",
				general = "",
				wmData = { minX = 0.485, maxX = 0.62743, minY = 0.71498, maxY = 0.917 },
				amData = { minX = 0.005, maxX = 0.995, minY = 0.005, maxY = 0.995 },
				dtl1 = { text = "艾索雷葛斯", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "交谈触发战斗", lootid = "AAzuregos", leaveGap = 1 }
			},

			{	name = "Four Dragons: Duskwood",		-- Four Dragons
				type = AM_TYP_RAID,
				displayname = "四绿龙: 暮色森林",
				filename = "AM_Dragon_Duskwood_Map",
				location = "暮色森林 : 黎明森林 (46, 36)",
				minimapZoom = 2.11,
				minimapXOffset = 54,
				minimapYOffset = 0,
				area = "Duskwood",
				levels = "60",
				players = AM_NO_LIMIT,
				prereq = "",
				general = "",
				wmData = { minX = 0.421, maxX = .526, minY = 0.292, maxY = 0.54 },
				amData = { minX = 0.29, maxX = .85, minY = 0.115, maxY = 0.97 },
				dtl1 = { text = "入口", colour = AM_GREEN, coords = { {48, 96} }, symbol = { AM_ENTRANCE },
						tooltiptxt = "", leaveGap = 1 },
				dtl2 = { text = "翡翠之门", colour = AM_GREEN, coords = { {54, 47} }, symbol = { "1" },
						tooltiptxt = "首领 \n伊森德雷", special = AM_WANDERS, leaveGap = 1 },
				dtl3 = { text = "艾莫莉丝", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DEmeriss" },
				dtl4 = { text = "莱索恩", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DLethon" },
				dtl5 = { text = "泰拉尔", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DTaerar" },
				dtl6 = { text = "伊森德雷", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DYsondre" },
			},

			{	name = "Four Dragons: Hinterlands",			-- Four Dragons
				type = AM_TYP_RAID,
				displayname = "四绿龙: 辛特兰",
				filename = "AM_Dragon_Hinterlands_Map",
				location = "辛特兰 : 瑟拉丹 (46, 36)",
				minimapZoom = 2,
				minimapXOffset = 0,
				minimapYOffset = 0,
				area = "Hinterlands",
				levels = "60",
				players = AM_NO_LIMIT,
				prereq = "",
				general = "有等级 62 & 61 精英三人组巡逻",
				wmData = { minX = 0.561, maxX = .697, minY = 0.159, maxY = 0.362 },
				amData = { minX = 0.005, maxX = .995, minY = 0.005, maxY = 0.995 },
				dtl1 = { text = "入口", colour = AM_GREEN, coords = { {37, 98} }, symbol = { AM_ENTRANCE },
						tooltiptxt = "", leaveGap = 1 },
				dtl2 = { text = "洛索斯", colour = AM_RED, coords = { {52.5, 59} }, symbol = { "1" },
						tooltiptxt = "Lvl62 精英龙类", special = AM_WANDERS },
				dtl3 = { text = "寻梦者", colour = AM_RED, coords = { {51, 49} }, symbol = { "2" },
						tooltiptxt = "Lvl62 精英龙类" },
				dtl4 = { text = "翡翠之门", colour = AM_GREEN, coords = { {46, 39} }, symbol = { "3" },
						tooltiptxt = "首领 \n泰拉尔", leaveGap = 1 },
				dtl5 = { text = "艾莫莉丝", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DEmeriss" },
				dtl6 = { text = "莱索恩", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DLethon" },
				dtl7 = { text = "泰拉尔", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DTaerar" },
				dtl8 = { text = "伊森德雷", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DYsondre" },
			},

			{	name = "Four Dragons: Feralas",			-- Four Dragons
				type = AM_TYP_RAID,
				displayname = "四绿龙: 菲拉斯",
				filename = "AM_Dragon_Feralas_Map",
				location = "菲拉斯 : 梦境之树 (51, 9)",	-- Jademir Lake
				minimapZoom = 2,
				minimapXOffset = 0,
				minimapYOffset = 0,
				area = "Feralas",
				levels = "60",
				players = AM_NO_LIMIT,
				prereq = "",
				general = "有等级 62 & 61 精英三人组巡逻",
				wmData = { minX = 0.47695, maxX = .55113, minY = 0.04585, maxY = 0.15963 },
				amData = { minX = 0.005, maxX = .995, minY = 0.005, maxY = 0.995 },
				dtl1 = { text = "睡梦咆哮者", colour = AM_RED, coords = { {36, 63} }, symbol = { "1" },
						tooltiptxt = "Lvl62 精英龙类\n围绕小岛巡逻", special = AM_WANDERS },
				dtl2 = { text = "莱萨拉斯", colour = AM_RED, coords = { {46, 68} }, symbol = { "2" },
						tooltiptxt = "Lvl62 精英龙类\n围绕小岛巡逻", special = AM_WANDERS },
				dtl3 = { text = "翡翠之门", colour = AM_GREEN, coords = { {45, 57} }, symbol = { "3" },
						tooltiptxt = "首领 \n艾莫莉丝", leaveGap = 1 },
				dtl4 = { text = "艾莫莉丝", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DEmeriss" },
				dtl5 = { text = "莱索恩", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DLethon" },
				dtl6 = { text = "泰拉尔", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DTaerar" },
				dtl7 = { text = "伊森德雷", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DYsondre" },
			},

			{	name = "Four Dragons: Ashenvale",		-- Four Dragons
				type = AM_TYP_RAID,
				displayname = "四绿龙: 灰谷",
				filename = "AM_Dragon_Ashenvale_Map",
				location = "灰谷 : 大树荫 (93, 36)",
				minimapZoom = 2,
				minimapXOffset = 0,
				minimapYOffset = 0,
				area = "Ashenvale",
				levels = "60",
				players = AM_NO_LIMIT,
				prereq = "",
				general = "有等级 62 & 61 精英三人组巡逻",
				wmData = { minX = 0.895, maxX = .984, minY = 0.299, maxY = 0.4286 },
				amData = { minX = 0.005, maxX = .995, minY = 0.005, maxY = 0.995 },
				dtl1 = { text = "范迪姆", colour = AM_RED, coords = { {57, 75} }, symbol = { "1" },
						tooltiptxt = "Lvl62 精英龙类", special = AM_WANDERS },
				dtl2 = { text = "巡梦者", colour = AM_RED, coords = { {50.4, 57} }, symbol = { "2" },
						tooltiptxt = "Lvl62 精英龙类" },
				dtl3 = { text = "翡翠之门", colour = AM_GREEN, coords = { {50.8, 48} }, symbol = { "3" },
						tooltiptxt = "首领 \n莱索恩", leaveGap = 1 },
				dtl4 = { text = "艾莫莉丝", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DEmeriss" },
				dtl5 = { text = "莱索恩", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DLethon" },
				dtl6 = { text = "泰拉尔", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DTaerar" },
				dtl7 = { text = "伊森德雷", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DYsondre" },
			},

			{	name = "玛拉顿",			-- Maraudon
				type = AM_TYP_INSTANCE,
				displayname = "玛拉顿",
				filename = "Maraudon",
				location = "凄凉之地 (29, 62)",
				levels = "40-49",
				players = "10",
				prereq = "",
				general = "",
				dtl1  = { text = "入口 (橙色)", colour = AM_ORANGE, coords = { {71, 12} }, symbol = { "X1" },
						tooltiptxt = "", toMap = "玛拉顿"..AM_EXTERIOR },
				dtl2  = { text = "入口 (紫色)", colour = AM_PURPLE, coords = { {85, 31} }, symbol = { "X2" },
						tooltiptxt = "", toMap = "玛拉顿"..AM_EXTERIOR },
				dtl3  = { text = "入口 (传送)", colour = AM_GREEN, coords = { {36, 55} }, symbol = { "P" },
						tooltiptxt = "", leaveGap = 1 },
				dtl4  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {64, 44}, {39, 31} }, symbol = { AM_CHEST_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl5  = { text = "温格 (第五可汗)", colour = AM_RED, coords = { {59, 6} }, symbol = { "1" },
						tooltiptxt = "", special = AM_WANDERS  },
				dtl6  = { text = "诺克赛恩", colour = AM_RED, coords = { {51, 3} }, symbol = { "2" },
						tooltiptxt = "Lvl48 精英元素生物", lootid = "MaraNoxxion"  },
				dtl7  = { text = "锐刺鞭笞者", colour = AM_RED, coords = { {36, 14} }, symbol = { "3" },
						tooltiptxt = "Lvl47 精英野兽", lootid = "MaraRazorlash"  },
				dtl8  = { text = "玛劳杜斯 (第四可汗)", colour = AM_RED, coords = { {64, 27} }, symbol = { "4" },
						tooltiptxt = ""  },
				dtl9  = { text = "维利塔恩", colour = AM_RED, coords = { {53.3, 32} }, symbol = { "5" },
						tooltiptxt = "Lvl47 精英人形生物", lootid = "MaraLordVyletongue"  },
				dtl10 = { text = "收割者麦什洛克", colour = AM_RED, coords = { {43, 30} }, symbol = { "6" },
						tooltiptxt = "", special = AM_RARE, lootid = "MaraMeshlok"  },
				dtl11 = { text = "被诅咒的塞雷布拉斯", colour = AM_RED, coords = { {31, 35} }, symbol = { "7" },
						tooltiptxt = "Lvl49 精英人形生物", lootid = "MaraCelebras"  },
				dtl12 = { text = "兰斯利德", colour = AM_RED, coords = { {51.3, 60} }, symbol = { "8" },
						tooltiptxt = "Lvl50 精英元素生物", lootid = "MaraLandslide"  },
				dtl13 = { text = "工匠吉兹洛克", colour = AM_RED, coords = { {61, 74} }, symbol = { "9" },
						tooltiptxt = "Lvl50 精英人形生物", lootid = "MaraTinkererGizlock"  },
				dtl14 = { text = "洛特格里普", colour = AM_RED, coords = { {45, 82} }, symbol = { "10" },
						tooltiptxt = "Lvl50 精英野兽", lootid = "MaraRotgrip"  },
				dtl15 = { text = "瑟莱德丝公主", colour = AM_RED, coords = { {32, 85} }, symbol = { "11" },
						tooltiptxt = "Lvl51 精英元素生物", lootid = "MaraPrincessTheradras" },
				dtl16 = { text = "扎尔塔的灵魂", colour = AM_RED, coords = { {32, 85} }, symbol = { " " },
						tooltiptxt = "", leaveGap = 1 }
			},

			{	name = "玛拉顿"..AM_EXTERIOR,		-- Maraudon Exterior
				type = AM_TYP_RAID,
				displayname = AM_EXTERIOR.." - 玛拉顿",
				displayshort = "",
				filename = "MaraudonExt",
				location = "凄凉之地 (29, 62)",
				levels = "40-49",
				players = "",
				prereq = "",
				general = "",
				area = "Kalimdor",
				wmData = { minX = 0.3807325, maxX = 0.393785, minY =  0.5679875, maxY = 0.58772 },
				amData = { minX = 0.02, maxX = 0.92, minY = 0.01, maxY = 0.98 },
				dtl1  = { text = "入口", colour = AM_GREEN, coords = { {23, 59}  }, symbol = { "X" },
						tooltiptxt = "", leaveGap = 1 },
				dtl2  = { text = "第一可汗", colour = AM_RED, coords = { {31, 45} }, symbol = { "1" },
						tooltiptxt = "" },
				dtl3  = { text = "第二可汗", colour = AM_RED, coords = { {24, 29} }, symbol = { "2" },
						tooltiptxt = "中层水池间" },
				dtl4  = { text = "第三可汗", colour = AM_RED, coords = { {80, 46} }, symbol = { "3" },
						tooltiptxt = "" },
				dtl5  = { text = "凯雯德拉", colour = AM_GREEN, coords = { {48, 64} }, symbol = { "4" },
						tooltiptxt = "任务给予者", leaveGap = 1 },
				dtl6  = { text = "玛拉顿大门", colour = AM_BLUE, coords = { {24, 47} }, symbol = { "P" },
						tooltiptxt = "需要塞布雷拉斯节杖" },
				dtl7  = { text = "玛拉顿 (橙色)", colour = AM_ORANGE, coords = { {84, 71} }, symbol = { "X1" },
						tooltiptxt = "点击打开玛拉顿副本地图", toMap = "玛拉顿" },
				dtl8  = { text = "玛拉顿 (紫色)", colour = AM_PURPLE, coords = { {39, 12.4} }, symbol = { "X2" },
						tooltiptxt = "点击打开玛拉顿副本地图", toMap = "玛拉顿" }
			},


			{	name = "熔火之心",			-- Molten Core
				type = AM_TYP_INSTANCE,
				displayname = "熔火之心",
				displayshort = "MC",
				filename = "MoltenCore",
				location = "黑石深渊",
				levels = "60+",
				players = "40",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {3, 20} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", toMap = "黑石深渊", leaveGap = 1 },
				dtl2  = { text = "鲁西弗隆", colour = AM_RED, coords = { {62, 35} }, symbol = { "1" },
						tooltiptxt = "首领 人形生物", lootid = "MCLucifron" },
				dtl3  = { text = "玛格曼达", colour = AM_RED, coords = { {70, 16} }, symbol = { "2" },
						tooltiptxt = "首领 野兽", lootid = "MCMagmadar" },
				dtl4  = { text = "基赫纳斯", colour = AM_RED, coords = { {13, 46} }, symbol = { "3" },
						tooltiptxt = "首领 人形生物", lootid = "MCGehennas" },
				dtl5  = { text = "加尔", colour = AM_RED, coords = { {8, 71} }, symbol = { "4" },
						tooltiptxt = "首领 元素生物", lootid = "MCGarr"  },
				dtl6  = { text = "沙斯拉尔", colour = AM_RED, coords = { {44, 80} }, symbol = { "5" },
						tooltiptxt = "首领 人形生物", lootid = "MCShazzrah"  },
				dtl7  = { text = "迦顿男爵", colour = AM_RED, coords = { {53, 68} }, symbol = { "6" },
						tooltiptxt = "首领 元素生物", lootid = "MCGeddon"  },
				dtl8  = { text = "焚化者古雷曼格", colour = AM_RED, coords = { {66, 57} }, symbol = { "7" },
						tooltiptxt = "首领 巨人", lootid = "MCGolemagg"  },
				dtl9  = { text = "萨弗隆先驱者", colour = AM_RED, coords = { {87, 80} }, symbol = { "8" },
						tooltiptxt = "首领 人形生物", lootid = "MCSulfuron"  },
				dtl10 = { text = "管理者埃克索图斯", colour = AM_RED, coords = { {89, 62} }, symbol = { "9" },
						tooltiptxt = "首领 人形生物", lootid = "MCMajordomo"  },
				dtl11 = { text = "拉格纳罗斯", colour = AM_RED, coords = { {47, 52} }, symbol = { "10" },
						tooltiptxt = "首领 元素生物", lootid = "MCRagnaros", leaveGap = 2  },
				dtl12 = { text = AM_MOB_LOOT, colour = AM_ORANGE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "MCTrashMobs", lootlink = true },
				dtl13 = { text = AM_RBOSS_DROP, colour = AM_ORANGE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "MCRANDOMBOSSDROPPS", leaveGap = 1 },
				dtl14 = { text = AM_TIER1_SET, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "T1SET", leaveGap = 1 }
			},

			{	name = "纳克萨玛斯",			-- Naxxramas
				type = AM_TYP_INSTANCE,
				displayname = "纳克萨玛斯",
				filename = "Naxxramas",
				location = "斯坦索姆",
				levels = "60+",
				players = "40",
				prereq = "",
				general = "",
				dtl1  = { text ="憎恶翼" , colour = AM_BLUE, coords = { {2, 15} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = "帕奇维克", colour = AM_RED, coords = { {22, 36} }, symbol = { "1" },
						tooltiptxt = "憎恶翼", lootid = "NAXPatchwerk" },
				dtl3  = { text = "格罗布鲁斯", colour = AM_RED, coords = { {32, 29} }, symbol = { "2" },
						tooltiptxt = "憎恶翼", lootid = "NAXGrobbulus" },
				dtl4  = { text = "格拉斯", colour = AM_RED, coords = { {20, 20} }, symbol = { "3" },
						tooltiptxt = "憎恶翼", lootid = "NAXGluth" },
				dtl5  = { text = "塔迪乌斯", colour = AM_RED, coords = { {5, 4} }, symbol = { "4" },
						tooltiptxt = "憎恶翼", lootid = "NAXThaddius", leaveGap = 1  },
				dtl6  = { text = "地穴蜘蛛翼", colour = AM_BLUE, coords = { {67, 3} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = ""  },
				dtl7  = { text = "阿努布雷坎", colour = AM_RED, coords = { {45.2, 20} }, symbol = { "1" },
						tooltiptxt = "地穴蜘蛛翼", lootid = "NAXAnubRekhan"  },
				dtl8  = { text = "黑女巫法琳娜", colour = AM_RED, coords = { {55, 16} }, symbol = { "2" },
						tooltiptxt = "地穴蜘蛛翼", lootid = "NAXGrandWidowFaerlina"  },
				dtl9  = { text = "迈克斯纳", colour = AM_RED, coords = { {74, 5} }, symbol = { "3" },
						tooltiptxt = "地穴蜘蛛翼", lootid = "NAXMaexxna", leaveGap = 1  },
				dtl10 = { text = "瘟疫翼", colour = AM_BLUE, coords = { {79, 56} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = ""  },
				dtl11 = { text = "瘟疫使者诺斯", colour = AM_RED, coords = { {47, 64} }, symbol = { "1" },
						tooltiptxt = "瘟疫翼", lootid = "NAXNothderPlaguebringer"  },
				dtl12 = { text = "肮脏的希尔盖", colour = AM_RED, coords = { {60, 58} }, symbol = { "2" },
						tooltiptxt = "瘟疫翼", lootid = "NAXHeiganderUnclean"  },
				dtl13 = { text = "洛欧塞布", colour = AM_RED, coords = { {82, 47} }, symbol = { "3" },
						tooltiptxt = "瘟疫翼", lootid = "NAXLoatheb", leaveGap = 1  },
				dtl14 = { text = "死亡骑士翼", colour = AM_BLUE, coords = { {15, 79} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = ""  },
				dtl15 = { text = "教官拉苏维奥斯", colour = AM_RED, coords = { {18, 58} }, symbol = { "1" },
						tooltiptxt = "死亡骑士翼", lootid = "NAXInstructorRazuvious"  },
				dtl16 = { text = "收割者戈提克", colour = AM_RED, coords = { {37, 64} }, symbol = { "2" },
						tooltiptxt = "死亡骑士翼", lootid = "NAXGothikderHarvester" },
				dtl17 = { text = "四死亡骑士", colour = AM_RED, coords = { {8, 75} }, symbol = { "3" },
						tooltiptxt = "死亡骑士翼", lootid = "NAXTheFourHorsemen" },
				dtl18 = { text = "库尔塔兹领主", colour = AM_RED, coords = { {8, 75} }, symbol = { " " },
						tooltiptxt = "" },
				dtl19 = { text = "瑟里耶克爵士", colour = AM_RED, coords = { {8, 75} }, symbol = { " " },
						tooltiptxt = "" },
				dtl20 = { text = "大领主莫格莱尼", colour = AM_RED, coords = { {8, 75} }, symbol = { " " },
						tooltiptxt = "" },
				dtl21 = { text = "女公爵布劳缪克丝", colour = AM_RED, coords = { {8, 75} }, symbol = { " " },
						tooltiptxt = "", leaveGap = 1 },
				dtl22 = { text = "冰霜飞龙巢穴", colour = AM_BLUE, coords = { {74, 93} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "冰霜飞龙巢穴"  },
				dtl23 = { text = "萨菲隆", colour = AM_RED, coords = { {87, 91} }, symbol = { "1" },
						tooltiptxt = "冰霜飞龙巢穴", lootid = "NAXSapphiron"  },
				dtl24 = { text = "克尔苏加德", colour = AM_RED, coords = { {75, 79} }, symbol = { "2" },
						tooltiptxt = "冰霜飞龙巢穴", lootid = "NAXKelThuzard", leaveGap = 2  },
				dtl25 = { text = AM_TIER3_SET, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "T3SET", leaveGap = 1 },
				dtl26 = { text = AM_MOB_LOOT, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "NAXTrash", leaveGap = 1 }
			},

			{	name = "奥妮克希亚的巢穴",				-- Onyxia's Lair
				type = AM_TYP_INSTANCE,
				displayname = "奥妮克希亚的巢穴",
				filename = "OnyxiasLair",
				location = "尘泥沼泽 (52, 76)",
				levels = "60+",
				players = "40",
				prereq = "需要龙火护符\n(完成在黑石塔上层杀死达基萨斯将军的任务)",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {9, 12} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = "奥妮克希亚守卫", colour = AM_RED, coords = { {26, 41}, {29, 56}, {39, 68}, {50, 80} }, symbol = { "1" },
						tooltiptxt = "Lvl62 精英龙类" },
				dtl3  = { text = "雏龙蛋", colour = AM_RED, coords = { {45, 40}, {51, 54}, {84, 41}, {79, 54} }, symbol = { "2" },
						tooltiptxt = "" },
				dtl4  = { text = "奥妮克希亚", colour = AM_RED, coords = { {66, 27} }, symbol = { "3" },
						tooltiptxt = "首领 龙类", lootid = "Onyxia", leaveGap = 1 }
			},

			{	name = "怒焰裂谷",			-- Ragefire Chasm
				type = AM_TYP_INSTANCE,
				displayname = "怒焰裂谷",
				displayshort = "RFC",
				filename = "RagefireChasm",			-- RagefireChasm
				location = "奥格瑞玛",
				levels = "13-18",
				players = "10",
				general = "",
				dtl1  = { text = "入口", colour = AM_GREEN, coords = { {72, 4} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl2  = { text = "玛尔·恐怖图腾", colour = AM_GOLD, coords = { {71, 53} }, symbol = { "1" },
						tooltiptxt = "背包任务"  },
				dtl3  = { text = "饥饿者塔拉加曼", colour = AM_RED, coords = { {34, 59} }, symbol = { "2" },
						tooltiptxt = "Lvl16 精英恶魔", lootid = "RFCTaragaman" },
				dtl4  = { text = "祈求者耶戈什", colour = AM_RED, coords = { {24, 86} }, symbol = { "3" },
						tooltiptxt = "Lvl16 精英人形生物", lootid = "RFCJergosh" },
				dtl5  = { text = "巴扎兰", colour = AM_RED, coords = { {36, 91} }, symbol = { "4" },
						tooltiptxt = "Lvl16 精英恶魔", leaveGap = 1  }

			},

			{	name = "剃刀高地",			-- Razorfen Downs
				type = AM_TYP_INSTANCE,
				displayname = "剃刀高地",
				displayshort = "RFD",
				filename = "RazorfenDowns",
				location = "南贫瘠之地 (48, 88)",
				levels = "38-43",
				players = "10",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {4, 23} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {77, 45} }, symbol = { AM_CHEST_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl3  = { text = "图特卡什", colour = AM_RED, coords = { {52, 36} }, symbol = { "1" },
						tooltiptxt = "Lvl40 精英亡灵", lootid = "RFDTutenkash" },
				dtl4  = { text = "敲锣召唤图特卡什", colour = AM_GREEN, coords = { {54, 30} }, symbol = { "2" },
						tooltiptxt = "" },
				dtl5  = { text = "亨利·斯特恩,\n& 奔尼斯特拉兹", colour = AM_BLUE, coords = { {76, 27} }, symbol = { "3" },
						tooltiptxt = "学习如何制造 :\n金棘茶, \n强力巨魔之血药水"  },
				dtl6  = { text = "火眼莫德雷斯", colour = AM_RED, coords = { {87, 47} }, symbol = { "4" },
						tooltiptxt = "Lvl39 精英亡灵", lootid = "RFDMordreshFireEye"  },
				dtl7  = { text = "暴食者", colour = AM_RED, coords = { {19, 65} }, symbol = { "5" },
						tooltiptxt = "Lvl40 精英人形生物", lootid = "RFDGlutton"  },
				dtl8  = { text = "拉戈斯诺特", colour = AM_RED, coords = { {41, 67} }, symbol = { "6" },
						tooltiptxt = "Lvl40 精英人形生物", special = AM_RARE, lootid = "RFDRagglesnout"  },
				dtl9  = { text = "寒冰之王亚门纳尔", colour = AM_RED, coords = { {33, 59} }, symbol = { "0" },
						tooltiptxt = "Lvl41 精英亡灵", lootid = "RFDAmnennar", leaveGap = 1 },
				dtl10 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "RFDTrash", leaveGap = 1 }
			},

			{	name = "剃刀沼泽",			-- Razorfen Kraul
				type = AM_TYP_INSTANCE,
				displayname = "剃刀沼泽",
				displayshort = "RFK",
				filename = "RazorfenKraul",
				location = "南贫瘠之地 (42, 86)",
				levels = "28-33",
				players = "10",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {75, 71} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl2  = { text = "鲁古格", colour = AM_RED, coords = { {73, 44} }, symbol = { "1" },
						tooltiptxt = "Lvl28 精英人形生物" },
				dtl3  = { text = "阿格姆", colour = AM_RED, coords = { {88, 48} }, symbol = { "2" },
						tooltiptxt = "Lvl30 精英人形生物" },
				dtl4  = { text = "亡语者贾格巴", colour = AM_RED, coords = { {93, 38} }, symbol = { "3" },
						tooltiptxt = "Lvl30 精英人形生物", lootid = "RFKDeathSpeakerJargba" },
				dtl5  = { text = "主宰拉姆塔斯", colour = AM_RED, coords = { {60, 29} }, symbol = { "4" },
						tooltiptxt = "Lvl32 精英人形生物", lootid = "RFKOverlordRamtusk"  },
				dtl6  = { text = "唤地者哈穆加", colour = AM_RED, coords = { {49, 37} }, symbol = { "5" },
						tooltiptxt = "Lvl32 精英人形生物", special = AM_RARE, lootid = "RFKEarthcallerHalmgar"  },
				dtl7  = { text = "进口商威利克斯,\n& 赫尔拉斯·静水", colour = AM_BLUE, coords = { {35, 33} }, symbol = { "6" },
						tooltiptxt = ""  },
				dtl8  = { text = "卡尔加·刺肋", colour = AM_RED, coords = { {21, 33} }, symbol = { "7" },
						tooltiptxt = "Lvl33 精英人形生物", lootid = "RFKCharlgaRazorflank"  },
				dtl9  = { text = "盲眼猎手", colour = AM_RED, coords = { {6, 32} }, symbol = { "8" },
						tooltiptxt = "Lvl32 精英野兽\n& 箱子", special = AM_RARE, lootid = "RFKBlindHunter"  },
				dtl10 = { text = "Ward Sealing Agathelos", colour = AM_GREEN, coords = { {4, 54} }, symbol = { "9" },
						tooltiptxt = ""  },
				dtl11 = { text = "暴怒的阿迦赛罗斯", colour = AM_RED, coords = { {11, 65} }, symbol = { "10" },
						tooltiptxt = "Lvl33 精英野兽", lootid = "RFKAgathelos", leaveGap = 1  },
				dtl12 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "RFKTrash", leaveGap = 1 }
			},

			{	name = "安其拉废墟",		-- Ruins of Ahn'Qiraj
				type = AM_TYP_INSTANCE,
				displayname = "安其拉废墟",
				displayshort = "AQ20",
				filename = "RuinsofAhnQiraj",		-- RuinsofAhnQiraj
				location = "希利苏斯 (29, 96)",
				levels = "60+",
				players = "20",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {64, 2} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl2  = { text = "库林纳克斯", colour = AM_RED, coords = { {55, 29} }, symbol = { "1" },
						tooltiptxt = "首领 & 精英", lootid = "AQ20Kurinnaxx" },
				dtl3  = { text ="安多洛夫中将,\n&卡多雷四精英", colour = AM_RED, coords = { {55, 29} }, symbol = { " " },
						tooltiptxt = "", lootid = "AQ20Andorov" },
				dtl4  = { text = "奎兹上尉", colour = AM_RED, coords = { {52.1, 46.9} }, symbol = { "2" },
						tooltiptxt = "Lvl63 精英", lootid = "AQ20CAPTIAN" },
				dtl5  = { text = "图比德上尉", colour = AM_RED, coords = { {55.4, 46.9} }, symbol = { "3" },
						tooltiptxt = "Lvl63 精英", lootid = "AQ20CAPTIAN" },
				dtl6  = { text = "德雷恩上尉", colour = AM_RED, coords = { {57.2, 47.9} }, symbol = { "4" },
						tooltiptxt = "Lvl63 精英", lootid = "AQ20CAPTIAN"  },
				dtl7  = { text = "库雷姆上尉", colour = AM_RED, coords = { {59.2, 49.2} }, symbol = { "5" },
						tooltiptxt = "Lvl63 精英", lootid = "AQ20CAPTIAN"  },
				dtl8  = { text = "耶吉斯少校", colour = AM_RED, coords = { {61.3, 50.3} }, symbol = { "6" },
						tooltiptxt = "Lvl63 精英", lootid = "AQ20CAPTIAN"  },
				dtl9  = { text = "帕库少校", colour = AM_RED, coords = { {60, 53.4} }, symbol = { "7" },
						tooltiptxt = "Lvl63 精英", lootid = "AQ20CAPTIAN"  },
				dtl10 = { text = "泽兰上校", colour = AM_RED, coords = { {56, 51.2} }, symbol = { "8" },
						tooltiptxt = "Lvl63 精英", lootid = "AQ20CAPTIAN"  },
				dtl11 = { text = "拉贾克斯将军", colour = AM_RED, coords = { {52.2, 49.5} }, symbol = { "9" },
						tooltiptxt = "首领", lootid = "AQ20Rajaxx"  },
				dtl12 = { text = "莫阿姆", colour = AM_RED, coords = { {13, 31} }, symbol = { "10" },
						tooltiptxt = "首领", lootid = "AQ20Moam"  },
				dtl13 = { text = "吞咽者布鲁", colour = AM_RED, coords = { {83, 55} }, symbol = { "11" },
						tooltiptxt = "首领", lootid = "AQ20Buru"  },
				dtl14 = { text = "安全房间", colour = AM_GREEN, coords = { {65, 70} }, symbol = { "12" },
						tooltiptxt = ""  },
				dtl15 = { text = "狩猎者阿亚米斯", colour = AM_RED, coords = { {67, 91} }, symbol = { "13" },
						tooltiptxt = "首领", lootid = "AQ20Ayamiss"  },
				dtl16 = { text = "无疤者奥斯里安", colour = AM_RED, coords = { {29, 73} }, symbol = { "14" },
						tooltiptxt = "首领", lootid = "AQ20Ossirian", leaveGap = 2  },
				dtl17 = { text = "职业技能书", colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "AQ20ClassBooks" },
				dtl18 = { text = AM_ENCHANTS, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "AQEnchants" },
				dtl19 = { text = "AQ20"..AM_CLASS_SETS, colour = AM_ORANGE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "AQ20SET", leaveGap = 1 }
			},

			{	name = "血色修道院",			-- Scarlet Monastery
				type = AM_TYP_INSTANCE,
				displayname = "血色修道院",
				displayshort = "SM",
				filename = "ScarletMonastery",
				location = "提瑞斯法林地 (83.6, 34)",
				levels = "30-40",
				players = "10",
				prereq = "",
				general = "",
				dtl1  = { text = "墓地入口", colour = AM_GREEN, coords = { {61, 97} }, symbol = { "G" },
						tooltiptxt = "" },
				dtl2  = { text = "铁脊死灵", colour = AM_RED, coords = { {21, 88} }, symbol = { "1" },
						tooltiptxt = "Lvl33 精英亡灵\n墓地", special = AM_RARE, lootid = "SMIronspine"  },
				dtl3  = { text = "永醒的艾希尔", colour = AM_RED, coords = { {5, 88} }, symbol = { "2" },
						tooltiptxt = "Lvl33 精英亡灵\n墓地", special = AM_RARE, lootid = "SMAzshir"  },
				dtl4  = { text = "死灵勇士", colour = AM_RED, coords = { {8, 80} }, symbol = { "3" },
						tooltiptxt = "Lvl33 精英亡灵\n墓地", special = AM_RARE, lootid = "SMFallenChampion" },
				dtl5  = { text = "血法师萨尔诺斯", colour = AM_RED, coords = { {5, 77} }, symbol = { "4" },
						tooltiptxt = "Lvl34 精英亡灵\n墓地", lootid = "SMBloodmageThalnos" },
				dtl6  = { text = "图书馆入口", colour = AM_GREEN, coords = { {56, 74} }, symbol = { "L" },
						tooltiptxt = "" },
				dtl7  = { text = "驯犬者洛克希", colour = AM_RED, coords = { {66.1, 95} }, symbol = { "5" },
						tooltiptxt = "Lvl34 精英人形生物\n图书馆", lootid = "SMHoundmasterLoksey"  },
				dtl8  = { text = "奥法师杜安", colour = AM_RED, coords = { {95.1, 92} }, symbol = { "6" },
						tooltiptxt = "Lvl37 精英人形生物\n图书馆", lootid = "SMDoan", leaveGap = 1  },
				dtl9  = { text = "军械库入口", colour = AM_GREEN, coords = { {54, 65} }, symbol = { "A" },
						tooltiptxt = "" },
				dtl10 = { text = "赫洛德", colour = AM_RED, coords = { {74.8, 6.2} }, symbol = { "7" },
						tooltiptxt = "Lvl40 精英人形生物\n军械库", lootid = "SMHerod", leaveGap = 1  },
				dtl11 = { text = "大教堂入口", colour = AM_GREEN, coords = { {37, 65} }, symbol = { "C" },
						tooltiptxt = "" },
				dtl12 = { text = "大检察官法尔班克斯", colour = AM_RED, coords = { {31, 11} }, symbol = { "8" },
						tooltiptxt = "Lvl40 精英人形生物\n大教堂", lootid = "SMFairbanks"  },
				dtl13 = { text = "血色十字军指挥官莫格莱尼", colour = AM_RED, coords = { {23.4, 12} }, symbol = { "9" },
						tooltiptxt = "Lvl42 精英人形生物\n大教堂", lootid = "SMMograine"  },
				dtl14 = { text = "大检察官怀特迈恩", colour = AM_RED, coords = { {23.4, 4.4} }, symbol = { "10" },
						tooltiptxt = "Lvl42 精英人形生物\n大教堂", lootid = "SMWhitemane", leaveGap = 2  },
				dtl15 = { text = "套装 : 血色十字军链甲", colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "6 部分", lootid = "SMScarletSET", leaveGap = 1 },
				dtl16 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "SMTrash", leaveGap = 1 }
			},

			{	name = "安其拉神殿",			-- Ahn'Qiraj
				type = AM_TYP_INSTANCE,
				displayname = "安其拉神殿",
				displayshort = "AQ40",
				filename = "TempleofAhnQiraj",		-- TempleofAhnQiraj
				location = "希利苏斯 (29, 96)",
				levels = "60+",
				players = "40",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {16, 37} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl2  = { text = "亚雷戈斯\n& 凯雷斯特拉兹\n& 梦境之龙麦琳瑟拉", colour = AM_BLUE, coords = { {21, 56} }, symbol = { "A" },
						tooltiptxt = ""  },
				dtl3  = { text = "安多葛斯\n& 温瑟拉\n& 坎多斯特拉兹", colour = AM_BLUE, coords = { {27, 43} }, symbol = { "B" },
						tooltiptxt = "", leaveGap = 1 },
				dtl4  = { text = "预言者斯克拉姆", colour = AM_RED, coords = { {19, 41} }, symbol = { "1" },
						tooltiptxt = "首领 \n外部", lootid = "AQ40Skeram" },
				dtl5  = { text = "维姆 & 组合", colour = AM_RED, coords = { {15, 52} }, symbol = { "2" },
						tooltiptxt = "首领", special = AM_OPTIONAL, lootid = "AQ40Vem" },
				dtl6  = { text = "沙尔图拉", colour = AM_RED, coords = { {40, 30} }, symbol = { "3" },
						tooltiptxt = "首领", lootid = "AQ40Sartura" },
				dtl7  = { text = "顽强的范克瑞斯", colour = AM_RED, coords = { {67, 14} }, symbol = { "4" },
						tooltiptxt = "首领", lootid = "AQ40Fankriss"  },
				dtl8  = { text = "维希度斯", colour = AM_RED, coords = { {82, 7} }, symbol = { "5" },
						tooltiptxt = "首领", special = AM_OPTIONAL, lootid = "AQ40Viscidus"  },
				dtl9  = { text = "哈霍兰公主", colour = AM_RED, coords = { {41, 49} }, symbol = { "6" },
						tooltiptxt = "首领", lootid = "AQ40Huhuran"  },
				dtl10 = { text = "双子皇帝", colour = AM_RED, coords = { {72, 67} }, symbol = { "7" },
						tooltiptxt = "首领", lootid = "AQ40Emperors"  },
				dtl11 = { text = "奥罗", colour = AM_RED, coords = { { 22, 87 } }, symbol = { "8" },
						tooltiptxt = "首领", special = AM_OPTIONAL, lootid = "AQ40Ouro" },
				dtl12 = { text = "克苏恩之眼", colour = AM_RED, coords = { {25, 50} }, symbol = { "9" },
						tooltiptxt = "", lootid = "AQ40CThun" },
				dtl13 = { text = "克苏恩", colour = AM_RED, coords = { {25, 50} }, symbol = { " " },
						tooltiptxt = "", lootid = "AQ40CThun", leaveGap = 2 },
				dtl14 = { text = AM_MOB_LOOT, colour = AM_ORANGE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "AQ40Trash", leaveGap = 1 },
				dtl15 = { text = "AQ40 "..AM_CLASS_SETS, colour = AM_ORANGE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "AQ40SET", leaveGap = 1 },
				dtl16 = { text = AM_ENCHANTS, colour = AM_BLUE, coords = { {0, 0 } }, symbol = { " " },
						tooltiptxt = "", lootid = "AQEnchants", leaveGap = 1 },
				dtl17 = { text = "AQ Brood Rings", colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "AQBroodRings", leaveGap = 1 },
				dtl18 = { text = AM_OPENING, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "AQOpening", leaveGap = 1 }
			},

			{	name = "死亡矿井",			-- The Deadmines
				type = AM_TYP_INSTANCE,
				displayname = "死亡矿井",
				filename = "TheDeadmines",
				location = "西部荒野 (42, 72)",
				levels = "16-26",
				players = "10",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {12, 23} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = AM_INSTANCE_EXITS, colour = AM_RED, coords = { {99, 42} }, symbol = { AM_EXIT_SYMBOL },
						tooltiptxt = "" },
				dtl3  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {80, 40} }, symbol = { AM_CHEST_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl4  = { text = "拉克佐", colour = AM_RED, coords = { {21, 58} }, symbol = { "1" },
						tooltiptxt = "Lvl19 精英人形生物", lootid = "VCRhahkZor" },
				dtl5  = { text = "矿工约翰森", colour = AM_RED, coords = { {41, 50} }, symbol = { "2" },
						tooltiptxt = "Lvl19 精英人形生物", lootid = "VCMinerJohnson", special = AM_RARE  },
				dtl6  = { text = "斯尼德", colour = AM_RED, coords = { {37, 77} }, symbol = { "3" },
						tooltiptxt = "Lvl20 精英机械 (in Shredder)", lootid = "VCSneed"  },
				dtl7  = { text = "基尔尼格", colour = AM_RED, coords = { {48.8, 60.2} }, symbol = { "4" },
						tooltiptxt = "Lvl20 精英人形生物", lootid = "VCGilnid"  },
				dtl8  = { text = "迪菲亚火药", colour = AM_GREEN, coords = { {55.6, 39} }, symbol = { "5" },
						tooltiptxt = "...爆破粉，用于打破大门"  },
				dtl9  = { text = "重拳先生", colour = AM_RED, coords = { {76, 31} }, symbol = { "6" },
						tooltiptxt = "Lvl20 精英人形生物", lootid = "VCMrSmite"  },
				dtl10 = { text = "曲奇", colour = AM_RED, coords = { {81, 36} }, symbol = { "7" },
						tooltiptxt = "", lootid = "VCCookie"  },
				dtl11 = { text = "绿皮队长", colour = AM_RED, coords = { {76, 37} }, symbol = { "8" },
						tooltiptxt = "Lvl21 精英人形生物", lootid = "VCCaptainGreenskin"  },
				dtl12 = { text = "艾德温·范克利夫", colour = AM_RED, coords = { {79, 37} }, symbol = { "9" },
						tooltiptxt = "Lvl21 精英人形生物", lootid = "VCVanCleef", leaveGap = 2 },
				dtl13 = { text = "套装 : 迪菲亚皮甲", colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "VCDefiasSET", leaveGap = 1 }
			},

			{	name = "监狱",			-- The Stockade
				type = AM_TYP_INSTANCE,
				displayname = "监狱",
				filename = "TheStockade",
				location = "暴风城",
				levels = "24-32",
				players = "10",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {50, 74} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {69, 60}, {75, 40}, {26, 57}, {31, 36}, {18, 29} }, symbol = { AM_CHEST_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl3  = { text = "可怕的塔格尔", colour = AM_RED, coords = { {58, 63}, {41, 55}, {50, 37}, {27, 50} }, symbol = { "1" },
						tooltiptxt = "Lvl24 精英人形生物", special = AM_VARIES },
				dtl4  = { text = "卡姆·深怒", colour = AM_RED, coords = { {73, 43} }, symbol = { "2" },
						tooltiptxt = "Lvl27 精英人形生物", lootid = "SWStKamDeepfury" },
				dtl5  = { text = "哈姆霍克", colour = AM_RED, coords = { {85, 56} }, symbol = { "3" },
						tooltiptxt = "Lvl28 精英人形生物"  },
				dtl6  = { text = "巴吉尔·特雷德", colour = AM_RED, coords = { {95, 62} }, symbol = { "4" },
						tooltiptxt = ""  },
				dtl7  = { text = "迪克斯特·瓦德", colour = AM_RED, coords = { {15, 40} }, symbol = { "5" },
						tooltiptxt = "Lvl26 精英人形生物"  },
				dtl8  = { text = "Bruegal Ironknuckle", colour = AM_RED, coords = { {22, 54} }, symbol = { "6" },
						tooltiptxt = "Lvl26 精英人形生物", special = AM_RARE, lootid = "SWStBruegalIronknuckle", leaveGap = 1 }
			},

			{	name = "T阿塔哈卡神庙",			-- The Sunken Temple
				type = AM_TYP_INSTANCE,
				displayname = "阿塔哈卡神庙",
				displayshort = "ST",
				filename = "TheSunkenTemple",
				location = "悲伤沼泽 (70, 53)",
				levels = "45-60",
				players = "10",
				prereq = "",
				general = "也称为沉没的神庙",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {62, 7} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = "入口通往下层楼梯", colour = AM_GREEN, coords = { {54, 11.3}, {13.9, 47} }, symbol = { "SL" },
						tooltiptxt = "" },
				dtl3  = { text = "入口通往中层楼梯", colour = AM_GREEN, coords = { {69, 11.3} }, symbol = { "SM" },
						tooltiptxt = "", leaveGap = 1 },
				dtl4  = { text = "到达上层楼梯", colour = AM_BLUE, coords = { {52, 18}, {69, 18}, {52, 48}, {69, 48} }, symbol = { AM_STAIRS_SYMBOL },
						tooltiptxt = "" },
				dtl5  = { text = "巨魔小首领 (上层)", colour = AM_RED, coords = { {55, 23}, {66, 23}, {72, 33}, {49, 33}, {54, 43}, {66, 43} }, symbol = { "T1", "T2", "T3", "T4", "T5", "T6" },
						tooltiptxt = "全部杀死, 然后再杀死迦玛兰\n以挑战伊兰尼库斯", lootid = "STTrollMinibosses", leaveGap = 1 },
				dtl6  = { text = "雕像 (下层)", colour = AM_ORANGE, coords = { {22, 82}, {22, 64}, {13, 77}, {30, 77}, {13, 68}, {30, 68} }, symbol = { "S1", "S2", "S3", "S4", "S5", "S6" },
						tooltiptxt = "按数字顺序激活以\n召唤阿塔拉利恩" },
				dtl7  = { text = "哈卡祭坛", colour = AM_ORANGE, coords = { {22, 74} }, symbol = { "1" },
						tooltiptxt = ""  },
				dtl8  = { text = "阿塔拉利恩", colour = AM_RED, coords = { {22, 71} }, symbol = { "2" },
						tooltiptxt = "Lvl50 精英人形生物", lootid = "STAtalalarion", leaveGap = 1  },
				dtl9  = { text = "德姆赛卡尔", colour = AM_RED, coords = { {58, 33} }, symbol = { "3" },
						tooltiptxt = "Lvl53 精英龙类", lootid = "STDreamscythe"  },
				dtl10 = { text = "德拉维沃尔", colour = AM_RED, coords = { {62, 33} }, symbol = { "4" },
						tooltiptxt = "Lvl51 精英龙类", lootid = "STWeaver"  },
				dtl11 = { text = "哈卡的化身", colour = AM_RED, coords = { {32, 33} }, symbol = { "5" },
						tooltiptxt = "Lvl50 精英龙类", lootid = "STAvatarofHakkar"  },
				dtl12 = { text = "预言者迦玛兰", colour = AM_RED, coords = { {88, 27} }, symbol = { "6" },
						tooltiptxt = "Lvl54 精英人形生物", lootid = "STJammalan"  },
				dtl13 = { text = "可悲的奥戈姆", colour = AM_RED, coords = { {88, 31} }, symbol = { "7" },
						tooltiptxt = "Lvl53 精英亡灵", lootid = "STOgom"  },
				dtl14 = { text = "摩弗拉斯", colour = AM_RED, coords = { {59, 62} }, symbol = { "8" },
						tooltiptxt = "Lvl52 精英龙类", lootid = "STMorphaz"  },
				dtl15 = { text = "哈扎斯", colour = AM_RED, coords = { {62, 62} }, symbol = { "9" },
						tooltiptxt = "Lvl53 精英龙类", lootid = "STHazzas"  },
				dtl16 = { text = "伊兰尼库斯的阴影", colour = AM_RED, coords = { {80, 62} }, symbol = { "10" },
						tooltiptxt = "Lvl55 精英龙类", lootid = "STEranikus"  },
				dtl17 = { text = "精华之泉", colour = AM_ORANGE, coords = { {85, 57} }, symbol = { "11" },
						tooltiptxt = "", leaveGap = 1 },
				dtl18 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "STTrash", leaveGap = 1 }
			},

			{	name = "奥达曼",			-- Uldaman
				type = AM_TYP_INSTANCE,
				displayname = "奥达曼",
				filename = "Uldaman",
				location = "荒芜之地 (44, 12)",
				levels = "35-50",
				players = "10",
				prereq = "",
				general = "",
				dtl1  = { text = "前门入口", colour = AM_GREEN, coords = { {89, 73.1} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "点击打开奥达曼外部地图", toMap = "奥达曼"..AM_EXTERIOR },
				dtl2  = { text = "旁门入口", colour = AM_GREEN, coords = { {21, 71} }, symbol = { "XR" },
						tooltiptxt = "", leaveGap = 1 },
				dtl3  = { text = "巴尔洛戈", colour = AM_RED, coords = { {73, 93} }, symbol = { "1" },
						tooltiptxt = "Lvl41 精英" },
				dtl4  = { text = "圣骑士的遗体", colour = AM_ORANGE, coords = { {62.8, 63.2} }, symbol = { "2" },
						tooltiptxt = "" },
				dtl5  = { text = "鲁维罗什", colour = AM_RED, coords = { {64, 73.3} }, symbol = { "3" },
						tooltiptxt = "Lvl40 精英人形生物", lootid = "UldRevelosh"  },
				dtl6  = { text = "艾隆纳亚", colour = AM_RED, coords = { {38, 75} }, symbol = { "4" },
						tooltiptxt = "首领 巨人", lootid = "UldIronaya"  },
				dtl7  = { text = "安诺拉 (大师级附魔师)", colour = AM_BLUE, coords = { {56, 61} }, symbol = { "5" },
						tooltiptxt = ""  },
				dtl8  = { text = "黑曜石哨兵", colour = AM_RED, coords = { {24.4, 62} }, symbol = { "6" },
						tooltiptxt = "Lvl42 精英机械"  },
				dtl9  = { text = "古代的石头看守者", colour = AM_RED, coords = { {54.7, 43} }, symbol = { "7" },
						tooltiptxt = "Lvl44 精英元素生物", lootid = "UldAncientStoneKeeper"  },
				dtl10 = { text = "加加恩·火锤", colour = AM_RED, coords = { {21, 31} }, symbol = { "8" },
						tooltiptxt = "首领 人形生物", lootid = "UldGalgannFirehammer"  },
				dtl11 = { text = "格瑞姆洛克", colour = AM_RED, coords = { {17, 19} }, symbol = { "9" },
						tooltiptxt = "Lvl45 精英人形生物", lootid = "UldGrimlok"  },
				dtl12 = { text = "阿扎达斯", colour = AM_RED, coords = { {45.2, 14.4} }, symbol = { "10" },
						tooltiptxt = "首领 巨人\n下层", lootid = "UldArchaedas"  },
				dtl13 = { text = "诺甘农圆盘", colour = AM_ORANGE, coords = { {39.7, 6.2} }, symbol = { "11" },
						tooltiptxt = "上层"  },
				dtl14 = { text = "古代宝藏", colour = AM_ORANGE, coords = { {42.3, 4.9} }, symbol = { "12" },
						tooltiptxt = "上层", leaveGap = 1 },
				dtl15 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "UldTrash", leaveGap = 1 }
			},

			{	name = "奥达曼"..AM_EXTERIOR,		-- Uldaman Exterior
				type = AM_TYP_RAID,
				displayname = AM_EXTERIOR.." - 奥达曼",
				filename = "UldamanExt",
				location = "荒芜之地 (44, 12)",
				levels = "",
				players = "",
				prereq = "",
				general = "",
				area = "Azeroth",
				wmData = { minX = 0.536226, maxX = 0.544795, minY =  0.57594, maxY = 0.586616 },
				amData = { minX = 0.075, maxX = 0.95, minY = 0.20, maxY = 0.935 },
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {95, 33}  }, symbol = { "X" },
						tooltiptxt = "", leaveGap = 1 },
				dtl2  = { text = AM_INSTANCE_CHESTS, colour = AM_BLUE, coords = { {23, 64}, {33, 88} }, symbol = { AM_CHEST_SYMBOL },
						tooltiptxt = "与任务有关系", leaveGap = 1 },
				dtl3  = { text = "奥达曼", colour = AM_GREEN, coords = { {30.5, 23} }, symbol = { "U" },
						tooltiptxt = "点击打开奥达曼副本地图", toMap = "奥达曼", leaveGap = 1 }
			},

			{ 	name = "哀嚎洞穴",			-- Wailing Caverns
				type = AM_TYP_INSTANCE,
				displayname = "哀嚎洞穴",
				displayshort = "WC",
				filename = "WailingCaverns",
				location = "贫瘠之地 (46, 36)",
				levels = "16-25",
				players = "10",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {44, 58} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", toMap = "哀嚎洞穴"..AM_EXTERIOR },
				dtl2  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {62, 47}, {94, 49} }, symbol = { AM_CHEST_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl3  = { text = "纳拉雷克斯的信徒", colour = AM_BLUE, coords = { {45, 53} }, symbol = { "1" },
						tooltiptxt = "触发副本终结" },
				dtl4  = { text = "考布莱恩", colour = AM_RED, coords = { {14, 55} }, symbol = { "2" },
						tooltiptxt = "Lvl20 精英人形生物", lootid = "WCLordCobrahn" },
				dtl5  = { text = "安娜科德拉", colour = AM_RED, coords = { {39, 35} }, symbol = { "3" },
						tooltiptxt = "Lvl20 精英人形生物", lootid = "WCLadyAnacondra" },
				dtl6  = { text = "克雷什", colour = AM_RED, coords = { {45, 42} }, symbol = { "4" },
						tooltiptxt = "Lvl20 精英人形生物", lootid = "WCKresh"  },
				dtl7  = { text = "变异精灵龙", colour = AM_RED, coords = { {63, 43} }, symbol = { "5" },
						tooltiptxt = "Lvl20 精英龙类", lootid = "WCDeviateFaerieDragon", special = AM_RARE },
				dtl8  = { text = "皮萨斯", colour = AM_RED, coords = { {86, 34} }, symbol = { "6" },
						tooltiptxt = "Lvl22 精英人形生物", lootid = "WCLordPythas"  },
				dtl9  = { text = "斯卡姆", colour = AM_RED, coords = { {93, 69} }, symbol = { "7" },
						tooltiptxt = "Lvl21 精英人形生物", lootid = "WCSkum"  },
				dtl10 = { text = "瑟芬迪斯", colour = AM_RED, coords = { {60, 52} }, symbol = { "8" },
						tooltiptxt = "Lvl22 精英人形生物\n上层", lootid = "WCLordSerpentis"  },
				dtl11 = { text = "永生者沃尔丹", colour = AM_RED, coords = { {56, 48} }, symbol = { "9" },
						tooltiptxt = "Lvl24 精英元素生物\n上层", lootid = "WCVerdan"  },
				dtl12 = { text = "吞噬者穆坦努斯", colour = AM_RED, coords = { {29.9, 23.9} }, symbol = { "10" },
						tooltiptxt = "Lvl22 精英人形生物\n触发出现", lootid = "WCMutanus"  },
				dtl13 = { text = "纳拉雷克斯", colour = AM_RED, coords = { {32.4, 25.4} }, symbol = { "11" },
						tooltiptxt = "Lvl25 精英人形生物", leaveGap = 2  },
				dtl14 = { text = "套装 : 毒蛇的拥抱", colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "WCViperSET", leaveGap = 1 }
			},

			{	name = "哀嚎洞穴"..AM_EXTERIOR,		-- Wailing Caverns Exterior
				type = AM_TYP_RAID,
				displayname = AM_EXTERIOR.." - 哀嚎洞穴",
				filename = "WailingCavernsExt",
				location = "贫瘠之地 (46, 36)",
				levels = "",
				players = "",
				prereq = "",
				general = "",
				area = "Kalimdor",
				wmData = { minX = 0.5178145, maxX = 0.529001, minY =  0.543372, maxY = 0.555871 },
				amData = { minX = 0.05, maxX = 0.97, minY = 0.15, maxY = 0.80 },
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {14.2, 81.5}  }, symbol = { "X" },
						tooltiptxt = "", leaveGap = 1 },
				dtl2  = { text = "哀嚎洞穴", colour = AM_GREEN, coords = { {55.1, 62.2} }, symbol = { "W" },
						tooltiptxt = "点击打开哀嚎洞穴副本地图", toMap = "哀嚎洞穴", leaveGap = 1 }
			},

			{	name = "祖尔法拉克",			-- Zul'Farrak
				type = AM_TYP_INSTANCE,
				displayname = "祖尔法拉克",
				displayshort = "ZF",
				filename = "ZulFarrak",
				location = "塔纳利斯 (37, 15)",
				levels = "43-47",
				players = "10",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {69, 89} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl2  = { text = "泽雷利斯", colour = AM_RED, coords = { {63, 47} }, symbol = { "1" },
						tooltiptxt = "Lvl45 精英人形生物", special = AM_RARE.." "..AM_WANDERS, lootid = "ZFZerillis" },
				dtl3  = { text = "杉达尔·沙掠者", colour = AM_RED, coords = { {55, 59} }, symbol = { "2" },
						tooltiptxt = "Lvl45 精英人形生物", special = AM_RARE },
				dtl4  = { text = "水占师维蕾萨", colour = AM_RED, coords = { {34, 43} }, symbol = { "3" },
						tooltiptxt = "Lvl46 精英人形生物" },
				dtl5  = { text = "加兹瑞拉", colour = AM_RED, coords = { {37, 46} }, symbol = { "4" },
						tooltiptxt = "Lvl46 精英野兽", lootid = "ZFGahzrilla"  },
				dtl6  = { text = "灰尘怨灵", colour = AM_RED, coords = { {32, 46} }, symbol = { "5" },
						tooltiptxt = "Lvl45 精英人形生物", special = AM_RARE, lootid = "ZFDustwraith"  },
				dtl7  = { text = "安图苏尔", colour = AM_RED, coords = { {80, 35} }, symbol = { "6" },
						tooltiptxt = "Lvl48 精英人形生物", lootid = "ZFAntusul"  },
				dtl8  = { text = "殉教者塞卡", colour = AM_RED, coords = { {67, 33} }, symbol = { "7" },
						tooltiptxt = "Lvl46 精英人形生物"  },
				dtl9  = { text = "巫医祖穆拉恩", colour = AM_RED, coords = { {53, 23} }, symbol = { "8" },
						tooltiptxt = "Lvl46 精英人形生物", lootid = "ZFWitchDoctorZumrah"  },
				dtl10 = { text = "祖尔法拉克阵亡英雄", colour = AM_RED, coords = { {51, 27} }, symbol = { "9" },
						tooltiptxt = "Lvl46 精英人形生物"  },
				dtl11 = { text = "暗影祭司塞瑟斯", colour = AM_RED, coords = { {36, 26} }, symbol = { "10" },
						tooltiptxt = "Lvl47 精英人形生物", lootid = "ZFSezzziz" },
				dtl12 = { text = "耐克鲁姆", colour = AM_RED, coords = { {36, 26} }, symbol = { " " },
						tooltiptxt = "Lvl46 精英亡灵"  },
				dtl13 = { text = "布莱中士", colour = AM_ORANGE, coords = { {26, 26} }, symbol = { "11" },
						tooltiptxt = "探水棒任务\n敌对/中立取决于\n阵营及采取的行动" },
				dtl14 = { text = "卢兹鲁", colour = AM_RED, coords = { {51, 39} }, symbol = { "12" },
						tooltiptxt = "Lvl46 精英人形生物"  },
				dtl15 = { text = "乌克兹·沙顶", colour = AM_RED, coords = { {55, 42} }, symbol = { "13" },
						tooltiptxt = "Lvl48 精英人形生物", lootid = "ZFChiefUkorzSandscalp", leaveGap = 1 },
				dtl16 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "ZFTrash", leaveGap = 1 }
			},

			{	name = "祖而格拉布",			-- Zul'Gurub
				type = AM_TYP_INSTANCE,
				displayname = "祖而格拉布",
				displayshort = "ZG",
				filename = "ZulGurub",
				location = "荆棘谷 (54, 17)",
				levels = "60+",
				players = "20",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {12, 50} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = "混浊的水", colour = AM_BLUE, coords = { {33, 41}, {47, 48}, {57, 47}, {60, 32}, {47, 30} }, symbol = { "W" },
						tooltiptxt = "", leaveGap = 1 },
				dtl3  = { text = "高阶祭司耶克里克", colour = AM_RED, coords = { {34, 78} }, symbol = { "1" },
						tooltiptxt = "首领 人形生物", special = "(蝙蝠)", lootid = "ZGJeklik" },
				dtl4  = { text = "高阶祭司温诺西斯", colour = AM_RED, coords = { {56, 57} }, symbol = { "2" },
						tooltiptxt = "首领 人形生物", special = "(毒蛇)", lootid = "ZGVenoxis" },
				dtl5  = { text = "高阶祭司玛尔里", colour = AM_RED, coords = { {48, 85} }, symbol = { "3" },
						tooltiptxt = "首领 人形生物", special = "(蜘蛛)", lootid = "ZGMarli"  },
				dtl6  = { text = "血领主曼多基尔", colour = AM_RED, coords = { {76, 73} }, symbol = { "4" },
						tooltiptxt = "首领 人形生物", special = "(迅猛龙)"..AM_OPTIONAL, lootid = "ZGMandokir"  },
				dtl7  = { text = "疯狂之源", colour = AM_RED, coords = { {72, 47} }, symbol = { "5" },
						tooltiptxt = "", special = AM_OPTIONAL  },
				dtl8  = { text = "格里雷克，钢铁之血", colour = AM_RED, coords = { {72, 47} }, symbol = { " " },
						tooltiptxt = "首领 亡灵", lootid = "ZGGrilek"  },
				dtl9  = { text = "哈扎拉尔，织梦者", colour = AM_RED, coords = { {72, 47} }, symbol = { " " },
						tooltiptxt = "首领 亡灵", lootid = "ZGHazzarah"  },
				dtl10 = { text = "雷纳塔基，千刃之王", colour = AM_RED, coords = { {72, 47} }, symbol = { " " },
						tooltiptxt = "首领 亡灵", lootid = "ZGRenataki"  },
				dtl11 = { text = "雷巫乌苏雷", colour = AM_RED, coords = { {72, 47} }, symbol = { " " },
						tooltiptxt = "首领 亡灵", lootid = "ZGWushoolay"  },
				dtl12 = { text = "加兹兰卡", colour = AM_RED, coords = { {66, 33} }, symbol = { "6" },
						tooltiptxt = "首领 人形生物", special = AM_OPTIONAL, lootid = "ZGGahzranka"  },
				dtl13 = { text = "高阶祭司塞卡尔", colour = AM_RED, coords = { {80, 32} }, symbol = { "7" },
						tooltiptxt = "首领 人形生物", special = "(猛虎)", lootid = "ZGThekal" },
				dtl14 = { text = "高阶祭司娅尔罗", colour = AM_RED, coords = { {49, 16} }, symbol = { "8" },
						tooltiptxt = "首领 人形生物", special = "(猎豹)", lootid = "ZGArlokk"  },
				dtl15 = { text = "妖术师金度", colour = AM_RED, coords = { {20, 18} }, symbol = { "9" },
						tooltiptxt = "首领 人形生物", special = "(亡灵)"..AM_OPTIONAL, lootid = "ZGJindo" },
				dtl16 = { text = "哈卡", colour = AM_RED, coords = { {54, 40} }, symbol = { "10" },
						tooltiptxt = "首领 龙类", lootid = "ZGHakkar", leaveGap = 2 },
				dtl17 = { text = AM_MOB_LOOT, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "ZGTrash", leaveGap = 1 },
				dtl18 = { text = "ZG"..AM_CLASS_SETS, colour = AM_ORANGE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "ZGSET", leaveGap = 1 },
				dtl19 = { text = AM_RBOSS_DROP, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "ZGShared", leaveGap = 1 },
				dtl20 = { text = AM_ENCHANTS, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "ZGEnchants", leaveGap = 1 }
			},

			{	name = "通灵学院",			-- Scholomance
				type = AM_TYP_INSTANCE,
				displayname = "通灵学院",
				filename = "Scholomance",		-- Scholomance*
				location = "西瘟疫之地 (69, 73)",
				levels = "56-60",
				players = "5",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {24, 30} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {28, 38} }, symbol = { AM_CHEST_SYMBOL },
						tooltiptxt = "" },
				dtl3  = { text = AM_INSTANCE_STAIRS, colour = AM_GREEN, coords = { {6.5, 22}, {62, 22} }, symbol = { "S1" },
						tooltiptxt = "" },
				dtl4  = {text = AM_INSTANCE_STAIRS, colour = AM_GREEN, coords = { {41, 41}, {34, 80} }, symbol = { "S2" },
						tooltiptxt = "", leaveGap = 1 },
				dtl5  = { text = "基尔图诺斯的卫士", colour = AM_RED, coords = { {54, 32} }, symbol = { "1" },
						tooltiptxt = "Lvl61 精英恶魔", lootid = "SCHOLOBloodSteward"  },
				dtl6  = { text = "传令官基尔图诺斯", colour = AM_RED, coords = { {30, 5} }, symbol = { "2" },
						tooltiptxt = "", lootid = "SCHOLOKirtonostheHerald" },
				dtl7  = { text = "詹迪斯·巴罗夫", colour = AM_RED, coords = { {96, 8.5} }, symbol = { "3" },
						tooltiptxt = "Lvl61 精英亡灵", lootid = "SCHOLOJandiceBarov"  },
				dtl8  = { text = "血骨傀儡", colour = AM_RED, coords = { {10, 41} }, symbol = { "4" },
						tooltiptxt = "Lvl61 精英亡灵\n下层\n掉落观察室钥匙", lootid = "SCHOLORattlegore"  },
				dtl9  = { text = "死亡骑士达克雷尔", colour = AM_RED, coords = { {10, 41} }, symbol = { " " },
						tooltiptxt = "Lvl62 精英亡灵\n骑士/萨满祭司任务召唤", lootid = "SCHOLODeathKnight" },
				dtl10 = { text = "马杜克·布莱克波尔", colour = AM_BLUE, coords = { {23.7, 42} }, symbol = { "5" },
						tooltiptxt = "Lvl58 精英\n在观察室中放置黎明先锋\n以激怒他", lootid = "SCHOLOMarduk"  },
				dtl11 = { text = "维克图斯", colour = AM_BLUE, coords = { {27.2, 42} }, symbol = { "6" },
						tooltiptxt = "Lvl60 精英亡灵\n在观察室中放置黎明先锋\n以激怒他", lootid = "SCHOLOVectus"  },
				dtl12 = { text = "莱斯·霜语", colour = AM_RED, coords = { {18, 87} }, symbol = { "8" },
						tooltiptxt = "Lvl62 精英亡灵", lootid = "SCHOLORasFrostwhisper"  },
				dtl13 = { text = "库尔莫克", colour = AM_RED, coords = { {18, 80} }, symbol = { "9" },
						tooltiptxt = "Lvl60 精英", lootid = "SCHOLOKormok" },
				dtl14 = { text = "讲师玛丽希亚", colour = AM_RED, coords = { {44.5, 94} }, symbol = { "10" },
						tooltiptxt = "Lvl60 精英人形生物", lootid = "SCHOLOInstructorMalicia"  },
				dtl15 = { text = "瑟尔林·卡斯迪诺夫教授", colour = AM_RED, coords = { {64, 74.2} }, symbol = { "11" },
						tooltiptxt = "Lvl60 精英人形生物", lootid = "SCHOLODoctorTheolenKrastinov"  },
				dtl16 = { text = "博学者普克尔特", colour = AM_RED, coords = { {44.8, 55.2} }, symbol = { "12" },
						tooltiptxt = "Lvl60 精英亡灵", lootid = "SCHOLOLorekeeperPolkelt"  },
				dtl17 = { text = "拉文尼亚", colour = AM_RED, coords = { {75.8, 92} }, symbol = { "13" },
						tooltiptxt = "Lvl60 精英亡灵", lootid = "SCHOLOTheRavenian"  },
				dtl18 = { text = "阿雷克斯·巴罗夫", colour = AM_RED, coords = { {96.2, 74.5} }, symbol = { "14" },
						tooltiptxt = "Lvl60 精英亡灵", lootid = "SCHOLOLordAlexeiBarov"  },
				dtl19 = { text = "伊露希亚·巴罗夫", colour = AM_RED, coords = { {75.6, 54} }, symbol = { "15" },
						tooltiptxt = "Lvl60 精英亡灵", lootid = "SCHOLOLadyIlluciaBarov" },
				dtl20 = { text = "黑暗院长加丁", colour = AM_RED, coords = { {76.2, 74.4} }, symbol = { "16" },
						tooltiptxt = "Lvl61 精英人形生物", lootid = "SCHOLODarkmasterGandling", leaveGap = 1 },
				dtl21 = { text = "火炬", colour = AM_GREEN, coords = { {89, 19} }, symbol = { "T" },
						tooltiptxt = "" },
				dtl22 = { text = "炼金实验室", colour = AM_GREEN, coords = { {14, 70} }, symbol = { "AL" },
						tooltiptxt = "", leaveGap = 1 },
				dtl23 = { text = "南海镇地契", colour = AM_ORANGE, coords = { {56, 25} }, symbol = { "D" },
						tooltiptxt = ""  },
				dtl24 = { text = "塔伦米尔地契", colour = AM_ORANGE, coords = { {11, 36} }, symbol = { "D" },
						tooltiptxt = ""  },
				dtl25 = { text = "布瑞尔地契	", colour = AM_ORANGE, coords = { {15, 77} }, symbol = { "D" },
						tooltiptxt = ""  },
				dtl26 = { text = "凯尔达隆地契", colour = AM_ORANGE, coords = { {94, 72} }, symbol = { "D" },
						tooltiptxt = "Lvl60 精英人形生物", leaveGap = 1},
			},

			{	name = "斯坦索姆",			-- Stratholme
				type = AM_TYP_INSTANCE,
				displayname = "斯坦索姆",
				filename = "Stratholme",
				location = "东瘟疫之地 (30, 12)",
				levels = "55-60",
				players = "5",
				prereq = "",
				general = "旁门入口在 EP (47, 24)",
				dtl1  = { text = "正门入口", colour = AM_GREEN, coords = { {50, 91} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = "旁门入口", colour = AM_GREEN, coords = { {83, 72} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl3  = { text = "弗拉斯·希亚比的邮箱", colour = AM_ORANGE, coords = { {37, 86} }, symbol = { "P1" },
						tooltiptxt = "" },
				dtl4  = { text = "国王广场邮箱", colour = AM_ORANGE, coords = { {47, 74} }, symbol = { "P2" },
						tooltiptxt = "" },
				dtl5  = { text = "十字军广场邮箱", colour = AM_ORANGE, coords = { {24, 66} }, symbol = { "P3" },
						tooltiptxt = "" },
				dtl6  = { text = "市场邮箱", colour = AM_ORANGE, coords = { {50, 62} }, symbol = { "P4" },
						tooltiptxt = ""  },
				dtl7  = { text = "节日小道的邮箱", colour = AM_ORANGE, coords = { {61, 62} }, symbol = { "P5" },
						tooltiptxt = ""  },
				dtl8  = { text = "长者广场邮箱", colour = AM_ORANGE, coords = { {80, 68} }, symbol = { "P6" },
						tooltiptxt = "" },
				dtl9  = { text = "邮差马龙", colour = AM_RED, coords = { {37, 86}, {47, 74}, {24, 66}, {50, 62}, {61, 62}, {80, 68} }, symbol = { " " },
						tooltiptxt = "Lvl60 精英亡灵\n打开第三个邮箱时召唤出来\n邮箱钥匙掉落自信使", leaveGap = 1 },
				dtl10 = { text = "斯库尔", colour = AM_RED, coords = { {42, 83} }, symbol = { "1" },
						tooltiptxt = "Lvl58 精英亡灵", special = AM_RARE.." "..AM_WANDERS, lootid = "STRATSkull" },
				dtl11 = { text = "斯坦索姆信使", colour = AM_RED, coords = { {43, 78} }, symbol = { "2" },
						tooltiptxt = "Lvl57 精英亡灵", lootid = "STRATStratholmeCourier"  },
				dtl12 = { text = "弗拉斯·希亚比", colour = AM_RED, coords = { {39, 83} }, symbol = { "3" },
						tooltiptxt = "Lvl61 精英亡灵", lootid = "STRATFrasSiabi"  },
				dtl13 = { text = "弗雷斯特恩", colour = AM_RED, coords = { {45, 62}, {65, 58}, {66, 66} }, symbol = { "4" },
						tooltiptxt = "Lvl57 精英亡灵\n如果任何出现在他的位置\n的食尸鬼被杀死\n则将连续刷新", special = AM_VARIES, lootid = "STRATHearthsingerForresten" },
				dtl14 = { text = "不可宽恕者", colour = AM_RED, coords = { {56, 57} }, symbol = { "5" },
						tooltiptxt = "Lvl57 精英亡灵", lootid = "STRATTheUnforgiven"  },
				dtl15 = { text = "悲惨的提米", colour = AM_RED, coords = { {26, 61.5} }, symbol = { "6" },
						tooltiptxt = "Lvl58 精英亡灵", lootid = "STRATTimmytheCruel"  },
				dtl16 = { text = "炮手威利", colour = AM_RED, coords = { {1, 74} }, symbol = { "7" },
						tooltiptxt = "Lvl60 精英人形生物", lootid = "STRATCannonMasterWilley"  },
				dtl17 = { text = "档案管理员加尔福特", colour = AM_RED, coords = { {24, 92} }, symbol = { "8" },
						tooltiptxt = "Lvl60 精英人形生物", lootid = "STRATArchivistGalford"  },
				dtl18 = { text = "巴纳扎尔", colour = AM_RED, coords = { {17, 97} }, symbol = { "9" },
						tooltiptxt = "Lvl62 精英恶魔", lootid = "STRATBalnazzar"  },
				dtl19 = { text = "索托斯", colour = AM_RED, coords = { {17, 97} }, symbol = { " " },
						tooltiptxt = "需要亚雷恩 & 索托斯的召唤火盆", lootid = "STRATSothosJarien" },
				dtl20 = { text = "亚雷恩", colour = AM_RED, coords = { {17, 97} }, symbol = { " " },
						tooltiptxt = "需要亚雷恩 & 索托斯的召唤火盆", lootid = "STRATSothosJarien" },
				dtl21 = { text = "奥里克斯", colour = AM_BLUE, coords = { {81, 61} }, symbol = { "10" },
						tooltiptxt = ""  },
				dtl22 = { text = "石脊", colour = AM_RED, coords = { {78, 42} }, symbol = { "11" },
						tooltiptxt = "Lvl60 精英亡灵", special = AM_RARE, lootid = "STRATStonespine"  },
				dtl23 = { text = "安娜丝塔丽男爵夫人", colour = AM_RED, coords = { {90, 39} }, symbol = { "12" },
						tooltiptxt = "Lvl59 精英亡灵", lootid = "STRATBaronessAnastari"  },
				dtl24 = { text = "奈鲁布恩坎", colour = AM_RED, coords = { {64, 39} }, symbol = { "13" },
						tooltiptxt = "Lvl60 精英亡灵", lootid = "STRATNerubenkan"  },
				dtl25 = { text = "苍白的玛勒基", colour = AM_RED, coords = { {81, 14} }, symbol = { "14" },
						tooltiptxt = "Lvl61 精英人形生物", lootid = "STRATMalekithePallid"  },
				dtl26 = { text = "巴瑟拉斯镇长", colour = AM_RED, coords = { {66, 10}, {74, 60} }, symbol = { "15" },
						tooltiptxt = "Lvl58 精英亡灵", special = AM_VARIES, lootid = "STRATMagistrateBarthilas" },
				dtl27 = { text = "吞咽者拉姆斯登", colour = AM_RED, coords = { {56, 15} }, symbol = { "16" },
						tooltiptxt = "Lvl61 精英亡灵", lootid = "STRATRamsteintheGorger"  },
				dtl28 = { text = "瑞文戴尔男爵", colour = AM_RED, coords = { {42, 15} }, symbol = { "17" },
						tooltiptxt = "Lvl62 精英亡灵", lootid = "STRATBaronRivendare", leaveGap = 1 }
			},

			{	name = "影牙城堡",			-- Shadowfang Keep
				type = AM_TYP_INSTANCE,
				displayname = "影牙城堡",
				displayshort = "SFK",
				filename = "ShadowfangKeep",
				location = "银松森林 (45, 67)",
				levels = "20-30",
				players = "10",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {75, 69} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {57, 57}, {36, 55}, {29, 12} }, symbol = { AM_CHEST_SYMBOL },
						tooltiptxt = "" },
				dtl3  = { text = "碉堡", colour = AM_BLUE, coords = { {38, 71}, {54, 93} }, symbol = { "B1" },
						tooltiptxt = "" },
				dtl4  = { text = "碉堡", colour = AM_BLUE, coords = { {69, 85}, {35, 37} }, symbol = { "B2" },
						tooltiptxt = "" },
				dtl5  = { text = "死亡之誓", colour = AM_RED, coords = { {69, 85}, {35, 37} }, symbol = { " " },
						tooltiptxt = "Lvl25 精英亡灵", special = AM_RARE  },
				dtl6  = { text = "楼梯", colour = AM_GREEN, coords = { {29.8, 34.8}, {50, 46.8} }, symbol = { "S1" },
						tooltiptxt = "" },
				dtl7  = { text = "楼梯", colour = AM_GREEN, coords = { {42, 32}, {67, 33} }, symbol = { "S2" },
						tooltiptxt = "", leaveGap = 1 },
				dtl8  = { text = "雷希戈尔", colour = AM_RED, coords = { {70, 78} }, symbol = { "1" },
						tooltiptxt = "Lvl20 精英人形生物\n牢房看守" },
				dtl9  = { text = "巫师阿克鲁比", colour = AM_RED, coords = { {67, 73} }, symbol = { "2" },
						tooltiptxt = "Lvl18 精英人形生物"  },
				dtl10 = { text = "亡灵哨兵阿达曼特", colour = AM_RED, coords = { {71, 74} }, symbol = { "3" },
						tooltiptxt = "Lvl18 精英人形生物"  },
				dtl11 = { text = "夫拉佐克劳", colour = AM_RED, coords = { {25, 59} }, symbol = { "4" },
						tooltiptxt = "Lvl22 精英人形生物", lootid = "BSFRazorclawtheButcher"  },
				dtl12 = { text = "席瓦莱恩男爵", colour = AM_RED, coords = { {13, 87} }, symbol = { "5" },
						tooltiptxt = "Lvl24 精英亡灵", lootid = "BSFSilverlaine" },
				dtl13 = { text = "指挥官斯普林瓦尔", colour = AM_RED, coords = { {26, 69} }, symbol = { "6" },
						tooltiptxt = "Lvl24 精英亡灵", lootid = "BSFSpringvale"  },
				dtl14 = { text = "盲眼守卫奥杜", colour = AM_RED, coords = { {61, 84} }, symbol = { "7" },
						tooltiptxt = "Lvl24 精英人形生物", lootid = "BSFOdotheBlindwatcher"  },
				dtl15 = { text = "吞噬者芬鲁斯", colour = AM_RED, coords = { {53.4, 33.4} }, symbol = { "8" },
						tooltiptxt = "Lvl25 精英野兽", lootid = "BSFFenrustheDevourer"  },
				dtl16 = { text = "狼王南杜斯", colour = AM_RED, coords = { {80, 29} }, symbol = { "9" },
						tooltiptxt = "Lvl25 精英人形生物", lootid = "BSFWolfMasterNandos"  },
				dtl17 = { text = "大法师阿鲁高", colour = AM_RED, coords = { {84, 13} }, symbol = { "10" },
						tooltiptxt = "Lvl26 精英人形生物", lootid = "BSFArchmageArugal", leaveGap = 1 },
				dtl18 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "BSFTrash", leaveGap = 1 }
			},

			{ 	name = "战歌峡谷",			-- Warsong Gulch
				type = AM_TYP_BG,
				displayname = "战歌峡谷",
				displayshort = "WSG",
				filename = "WarsongGulch",
				location = "灰谷 (62, 84) / 贫瘠之地 (47, 8)",
				levels = "10+ 团队",
				players = "10",
				prereq = "",
				general = "",
				wmData = { minX = 0.26, maxX = 0.74, minY =  0.05, maxY = 0.95 },
				amData = { minX = 0.33, maxX = 0.97, minY = 0.12, maxY = 0.88 },
				dtl1  = { text = "联盟旗帜房间", colour = AM_BLUE, coords = { {64.31, 14.15} }, symbol = { "F" },
						tooltiptxt = "联盟玩家开始于这里" },
				dtl2  = { text = "联盟出口", colour = AM_BLUE, coords = { {45.93, 22.34} }, symbol = { AM_EXIT_SYMBOL },
						tooltiptxt = "使用或者输入/afk", leaveGap = 1 },
				dtl3  = { text = "部落旗帜房间", colour = AM_RED, coords = { {70.75, 85.31} }, symbol = { "F" },
						tooltiptxt = "部落玩家开始于这里" },
				dtl4  = { text = "部落出口", colour = AM_RED, coords = { {87.75, 77.12} }, symbol = { AM_EXIT_SYMBOL },
						tooltiptxt = "使用或者输入/afk", leaveGap = 1 },
				dtl5  = { text = "增益", colour = AM_GREEN, coords = { {55.35, 60.26}, {76.26, 39.67} }, symbol = { "P" },
						tooltiptxt = "" },
				dtl6  = { text = "恢复点", colour = AM_GREEN, coords = { {81.09, 61.43}, {56.04, 39.20} }, symbol = { "R" },
						tooltiptxt = "恢复生命值 & 法力值", leaveGap = 2 },
				dtl7  = { text = "联盟旗帜运送者", colour = AM_BLUE, coords = { {30, 15} }, symbol = { "FC" },
						tooltiptxt = "", bgFlag = "A" },
				dtl8  = { text = "部落旗帜运送者", colour = AM_RED, coords = { {30, 85} }, symbol = { "FC" },
						tooltiptxt = "", bgFlag = "H", leaveGap = 2 },
				dtl9  = { text = AM_FRIENDLY, colour = AM_GREEN, coords = { {0, 0 } }, symbol = { " " },
						tooltiptxt = "", lootid = "WSGFriendly" },
				dtl10 = { text = AM_HONOURED, colour = AM_GREEN, coords = { {0, 0 } }, symbol = { " " },
						tooltiptxt = "", lootid = "WSGHonored" },
				dtl11 = { text = AM_REVERED, colour = AM_BLUE, coords = { {0, 0 } }, symbol = { " " },
						tooltiptxt = "", lootid = "WSGRevered" },
				dtl12 = { text = AM_EXALTED, colour = AM_PURPLE, coords = { {0, 0 } }, symbol = { " " },
						tooltiptxt = "", lootid = "WSGExalted", leaveGap = 1 },
				dtl13 = { text = AM_PVP_SET, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "PVPSET", leaveGap = 1 }
			},

			{ 	name = "阿拉希盆地",			-- Arathi Basin
				type = AM_TYP_BG,
				displayname = "阿拉希盆地",
				displayshort = "AB",
				filename = "ArathiBasin",
				location = "阿拉希高地 (73, 28)",
				levels = "20+ 团队",
				players = "15",
				prereq = "",
				general = "",
				wmData = { minX = 0.23, maxX = 0.71, minY =  0.09, maxY = 0.76 },
				amData = { minX = 0.15, maxX = 0.93, minY = 0.05, maxY = 0.87 },
				dtl1  = { text = "联盟起点", colour = AM_BLUE, coords = { {21.8, 12.98} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "联盟玩家开始于这里", bgBase = "A" },
				dtl2  = { text = "部落起点", colour = AM_RED, coords = { {91.89, 80.63} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "部落玩家开始于这里", bgBase = "H", leaveGap = 1 },
				dtl3  = { text = "兽栏", colour = AM_GREEN, coords = { {34.67, 29.6}, {9, 28.0} }, symbol = { "S" },
						tooltiptxt = "", bgPOI = true },
				dtl4  = { text = "金矿", colour = AM_GREEN, coords = { {72.81, 30.54}, {9, 34.0} }, symbol = { "M" },
						tooltiptxt = "占领", bgPOI = true },
				dtl5  = { text = "铁匠铺", colour = AM_GREEN, coords = { {51.9, 50.2}, {9, 50.2} }, symbol = { "B" },
						tooltiptxt = "占领", bgPOI = true },
				dtl6  = { text = "伐木场", colour = AM_GREEN, coords = { {41.10, 62.37}, {9, 62.0} }, symbol = { "L" },
						tooltiptxt = "占领", bgPOI = true },
				dtl7  = { text = "农场", colour = AM_GREEN, coords = { {70.52, 67.75}, {9, 68.0} }, symbol = { "F" },
						tooltiptxt = "占领", bgPOI = true, leaveGap = 1 },
				dtl8  = { text = AM_FRIENDLY, colour = AM_PURPLE, coords = { {0, 0 } }, symbol = { " " },
						tooltiptxt = "", lootid = "ABFriendly" },
				dtl9  = { text = AM_HONOURED, colour = AM_PURPLE, coords = { {0, 0 } }, symbol = { " " },
						tooltiptxt = "", lootid = "ABHonored" },
				dtl10 = { text = AM_REVERED, colour = AM_PURPLE, coords = { {0, 0 } }, symbol = { " " },
						tooltiptxt = "", lootid = "ABRevered" },
				dtl11 = { text = AM_EXALTED, colour = AM_PURPLE, coords = { {0, 0 } }, symbol = { " " },
						tooltiptxt = "", lootid = "ABExalted", leaveGap = 1 },
				dtl12 = { text = AM_PVP_SET, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "PVPSET", leaveGap = 1 }
			},

			{ 	name = "奥特兰克山谷",			-- Alterac Valley
				type = AM_TYP_BG,
				displayname = "奥特兰克山谷",
				displayshort = "AV",
				filename = "AlteracValley",
				location = "奥特兰克山脉 (63, 58)",
				levels = "51-60",
				players = "40",
				prereq = "",
				general = "",
				notescale = 0.7,
				wmData = { minX = 0.395, maxX = 0.586, minY =  0.106, maxY = 0.9187 },
				amData = { minX = 0.65, maxX = 0.95, minY = 0.036, maxY = 0.98 },
				dtl1  = { text = "联盟入口", colour = AM_BLUE, coords = { {87.98, 2.69} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = "部落入口", colour = AM_RED, coords = { {91.01, 71.03} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl3  = { text = "丹巴达尔", colour = AM_BLUE, coords = { {67.38, 6.47} }, symbol = { "!" },
						tooltiptxt = "杀死首领以获得游戏胜利" },
				dtl4  = { text = "霜狼要塞", colour = AM_RED, coords = { {75.38, 92.42} }, symbol = { "!" },
						tooltiptxt = "杀死首领以获得游戏胜利", leaveGap = 1 },
				dtl5  = { text = "墓地", colour = AM_GREEN, coords = { {68.26, 9.55}, {79.29, 8.36}, {83.68, 32.53}, {70.89, 44.37}, {83.49, 60.99}, {80.66, 80.18}, {80.27, 94.31} }, symbol = { " " },
						tooltiptxt = "占领以使你的阵营能在此复活", bgPOI = true },
				dtl6  = { text = "雷矛急救站", colour = AM_GREEN, coords = { {68.26, 9.55}, {57, 9.55} }, symbol = { "1" },
						tooltiptxt = "", bgPOI = true },
				dtl7  = { text = "雷矛墓地", colour = AM_GREEN, coords = { {79.29, 8.36}, {57, 12} }, symbol = { "2" },
						tooltiptxt = "", bgPOI = true },
				dtl8  = { text = "石炉墓地", colour = AM_GREEN, coords = { {83.68, 32.53}, {57, 32.53} }, symbol = { "3" },
						tooltiptxt = "", bgPOI = true },
				dtl9  = { text = "落雪墓地", colour = AM_GREEN, coords = { {72.2, 44.8}, {57, 44.37} }, symbol = { "4" },
						tooltiptxt = "", bgPOI = true },
				dtl10 = { text = "冰血墓地", colour = AM_GREEN, coords = { {83.49, 60.99}, {57, 60.99} }, symbol = { "5" },
						tooltiptxt = "", bgPOI = true },
				dtl11 = { text = "霜狼墓地", colour = AM_GREEN, coords = { {82.0, 80.18}, {57, 80.18} }, symbol = { "6" },
						tooltiptxt = "", bgPOI = true },
				dtl12 = { text = "雷矛急救站", colour = AM_GREEN, coords = { {80.27, 94.31}, {57, 94.31} }, symbol = { "7" },
						tooltiptxt = "", bgPOI = true, leaveGap = 1 },
				dtl13 = { text = "石炉哨站", bgPOI = true, colour = AM_BLUE, coords = { {79, 36.71} }, symbol = { "C" },
						tooltiptxt = "" },
				dtl14 = { text = "巴琳达", colour = AM_BLUE, coords = { {79, 36.71} }, symbol = { " " },
						tooltiptxt = "", bgPOI = true, leaveGap = 1 },
				dtl15 = { text = "冰血要塞", colour = AM_RED, coords = { {73.82, 57.7} }, symbol = { "C" },
						tooltiptxt = "", bgPOI = true },
				dtl16 = { text = "加尔范", colour = AM_RED, coords = { {73.82, 57.7} }, symbol = { " " },
						tooltiptxt = "", bgPOI = true, leaveGap = 1 },
				dtl17 = { text = "联盟碉堡", colour = AM_BLUE, coords = { {85.54, 41.98}, {82.02, 27.16}, {70.50, 13.53}, {73.04, 7.37} }, symbol = { " " },
						tooltiptxt = "部落可以破坏以获得荣誉\n当被破坏后守卫停止刷新", bgPOI = true },
				dtl18 = { text = "石炉碉堡", colour = AM_BLUE, coords = { {85.54, 41.98}, {60, 41.98} }, symbol = { "8" },
						tooltiptxt = "", bgPOI = true },
				dtl19 = { text = "冰翼碉堡", colour = AM_BLUE, coords = { {82.02, 27.16}, {60, 27.16} }, symbol = { "9" },
						tooltiptxt = "联盟空军指挥官卡尔·菲利普\n部落空军指挥官古斯", bgPOI = true },
				dtl20 = { text = "丹巴达尔南部碉堡", colour = AM_BLUE, coords = { {71.00, 13.00}, {60, 13.53} }, symbol = { "10" },
						tooltiptxt = "", bgPOI = true },
				dtl21 = { text = "丹巴达尔北部碉堡", colour = AM_BLUE, coords = { {73.04, 7.37}, {60, 7.37} }, symbol = { "11" },
						tooltiptxt = "部落空军指挥官穆维里克", bgPOI = true, leaveGap = 1 },
				dtl22 = { text = "部落哨塔", colour = AM_RED, coords = { {78.31, 59.29}, {81.83, 67.25}, {80.4, 89.04}, {77, 88.5}  }, symbol = { " " },
						tooltiptxt = "联盟可以破坏以获得荣誉\n当被破坏后守卫停止刷新", bgPOI = true },
				dtl23 = { text = "冰血哨塔", colour = AM_RED, coords = { {78.31, 59.29}, {60, 59.29} }, symbol = { "12" },
						tooltiptxt = "", bgPOI = true },
				dtl24 = { text = "哨塔高地", colour = AM_RED, coords = { {81.83, 67.25}, {60, 67.25} }, symbol = { "13" },
						tooltiptxt = "联盟空军指挥官刘易斯·菲利普\n部落空军指挥官斯里多尔", bgPOI = true },
				dtl25 = { text = "东部霜狼哨塔", colour = AM_RED, coords = { {80.6, 89.04}, {63, 89.05} }, symbol = { "14" },
						tooltiptxt = "", bgPOI = true },
				dtl26 = { text = "西部霜狼哨塔", colour = AM_RED, coords = { {78.5, 88.8}, {60.5, 88.5} }, symbol = { "15" },
						tooltiptxt = "", bgPOI = true, leaveGap = 1 },
				dtl27 = { text = "矿洞", colour = AM_ORANGE, coords = { {81.15, 1.69}, {73.33, 74.61} }, symbol = { " " },
						tooltiptxt = "占领以开采资源", bgPOI = true },
				dtl28 = { text = "深铁矿洞", colour = AM_GREEN, coords = { {81.15, 1.69}, {63, 1.69} }, symbol = { "IM" },
						tooltiptxt = "", bgPOI = true },
				dtl29 = { text = "冷齿矿洞", colour = AM_GREEN, coords = { {73.33, 74.61}, {63, 74.61} }, symbol = {"CM" },
						tooltiptxt = "", bgPOI = true, leaveGap = 1 },
	-- Pad to dtl32 to control the page break
				dtl30 = { text = "", colour = AM_GREEN, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "" },
				dtl31 = { text = "", colour = AM_GREEN, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "" },
				dtl32 = { text = "", colour = AM_GREEN, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "" },
	-- Pad to dtl32 to control the page break
				dtl33 = { text = "召唤区域", colour = AM_GREEN, coords = { {80.76, 44.27}, {73.14, 48.05} }, symbol = { " " },
						tooltiptxt = "在这个点召唤阵营之神" },
				dtl34 = { text = "森林之王伊弗斯", colour = AM_BLUE, coords = { {80.76, 44.27} }, symbol = { "IF" },
						tooltiptxt = "护卫者从丹巴达尔召唤NPC到这个点" },
				dtl35 = { text = "冰雪之王洛克霍拉", colour = AM_RED, coords = { {73.14, 48.05} }, symbol = { "LI" },
						tooltiptxt = "护卫者从霜狼要塞召唤NPC到这个点", leaveGap = 1 },
				dtl36 = { text = "联盟中校", colour = AM_BLUE, coords = { {82.02, 27.16}, {81.05, 85.46}, {81.83, 67.25}, {80.4, 89.04} }, symbol = { " " },
						tooltiptxt = "援救并召唤回基地以获得空中支持", bgPOI = true },
				dtl37 = { text = "卡尔·菲利普 (9 冰翼碉堡)", colour = AM_BLUE, coords = { {82.02, 27.16} }, symbol = { " " },
						tooltiptxt = "", bgPOI = true },
				dtl38 = { text = "斯里多尔 (13 哨塔高地)", colour = AM_BLUE, coords = { {81.83, 67.25} }, symbol = { " " },
						tooltiptxt = "", bgPOI = true },
				dtl39 = { text = "维波里", colour = AM_BLUE, coords = { {81.05, 85.46} }, symbol = { "W" },
						tooltiptxt = "" },
				dtl40 = { text = "艾克曼 (14 东部霜狼哨塔)", colour = AM_BLUE, coords = { {80.4, 89.04} }, symbol = { " " },
						tooltiptxt = "", bgPOI = true, leaveGap = 1 },
				dtl41 = { text = "部落中校", colour = AM_RED, coords = { {81.83, 67.25}, {82.02, 27.16}, {88.96, 23.38}, {73.04, 7.37} }, symbol = { " " },
						tooltiptxt = "援救并召唤回基地以获得空中支持", bgPOI = true },
				dtl42 = { text = "刘易斯·菲利普 (13 哨塔高地)", colour = AM_RED, coords = { {81.83, 67.25} }, symbol = { " " },
						tooltiptxt = "", bgPOI = true },
				dtl43 = { text = "古斯 (9 冰翼碉堡)", colour = AM_RED, coords = { {82.02, 27.16} }, symbol = { " " },
						tooltiptxt = "", bgPOI = true },
				dtl44 = { text = "杰斯托", colour = AM_RED, coords = { {88.96, 23.38} }, symbol = { "W" },
						tooltiptxt = "" },
				dtl45 = { text = "穆维里克 (11 丹巴达尔北部碉堡)", colour = AM_RED, coords = { {73.04, 7.37} }, symbol = { " " },
						tooltiptxt = "", bgPOI = true, leaveGap = 1 },
				dtl46 = { text = "蒸汽锯位置", colour = AM_PURPLE, coords = { {83, 54.72}, {88.57, 15.42} }, symbol = { " " },
						tooltiptxt = "" },
				dtl47 = { text = "联盟蒸汽锯", colour = AM_BLUE, coords = { {83, 54.72} }, symbol = { "S" },
						tooltiptxt = "收割机任务需要" },
				dtl48 = { text = "部落蒸汽锯", colour = AM_RED, coords = { {88.57, 15.42} }, symbol = { "S" },
						tooltiptxt = "收割机任务需要", leaveGap = 1 },
				dtl49 = { text = "洞穴", colour = AM_GREEN, coords = { {64.54, 24.08}, {85.93, 94.71} }, symbol = { " " },
						tooltiptxt = "" },
				dtl50 = { text = "冰翼", colour = AM_GREEN, coords = { {64.54, 24.08} }, symbol = { "IC" },
						tooltiptxt = "" },
				dtl51 = { text = "蛮爪", colour = AM_GREEN, coords = { {85.93, 94.71} }, symbol = { "WC" },
						tooltiptxt = "", leaveGap = 1 },
				dtl52 = { text = "霜狼骑兵指挥官", colour = AM_RED, coords = { {91.2, 86.55} }, symbol = { "WR" },
					tooltiptxt = "驯服狼并上交羊皮以召唤骑兵\n联盟类似地点在丹巴达尔, 就在急救站墓地南部", leaveGap = 2 },
				dtl53 = { text = AM_FRIENDLY, colour = AM_PURPLE, coords = { {0, 0 } }, symbol = { " " },
						tooltiptxt = "", lootid = "AVFriendly" },
				dtl54 = { text = AM_HONOURED, colour = AM_PURPLE, coords = { {0, 0 } }, symbol = { " " },
						tooltiptxt = "", lootid = "AVHonored" },
				dtl55 = { text = AM_REVERED, colour = AM_PURPLE, coords = { {0, 0 } }, symbol = { " " },
						tooltiptxt = "", lootid = "AVRevered" },
				dtl56 = { text = AM_EXALTED, colour = AM_PURPLE, coords = { {0, 0 } }, symbol = { " " },
						tooltiptxt = "", lootid = "AVExalted", leaveGap = 1 },
				dtl57 = { text = AM_PVP_SET, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "PVPSET", leaveGap = 1 }
			}
	};

end