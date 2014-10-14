--[[
	WARNING! If you edit this file you need a good editor, not notepad.
	This file HAS to be saved in UTF-8 format (without signature) else we would have to escape
	all special chars
	
	Credits for this locale: jinsong zhao
	Thanks a LOT.
	
]]--

if (GetLocale() == "zhCN") then

SW_DS_START = "开始"; -- name of the first segment
SW_DS_RESET = "重置"; 
SW_DS_ZONED = "区域 %s";
SW_DS_JOINED_GROUP = "加入队伍";
SW_DS_LEFT_GROUP = "离开队伍";
SW_DS_JOINED_RAID = "加入团队";
SW_DS_LEFT_RAID = "离开团队";
SW_DS_MERGED = "合并的"; -- used when merging data segements
SW_DS_SYNC_INIT = "新同步"; -- 2.0.beta.2
-- not used yet
SW_DS_ENCOUNTER = "Started fight with %s";
SW_DS_PHASE_CHANGE = "%s Phase %d";
SW_DS_TIMER = "%d seconds elapsed";


-- special "school" for environmental damage
-- falling drowining etc
SW_STR_ENVIRO = "环境";

SW_CL_SHOOT = "射击"; -- the Wand "Shoot" ability as found in the combat log
SW_MAP_SKILL_DMGSHIELD = "伤害盾"; -- "skill" name to map damge shields to (thorns etc.)

-- strings for detail info on mouse over
SW_TT_SKILL_HEAD = "详细: %s (%s)";
SW_TT_SKILL_SWINGS = "命中:%d 次数:%d 失误:%d 抵抗:%d 无效伤害:%d";
SW_TT_SKILL_CRITS = "暴击:%d 暴击率:%g%% 无效伤害暴率:%g%%";
SW_TT_SKILL_GLCRUSH = "偏斜:%d 碾压:%d";
SW_TT_SKILL_RMP = "躲闪:%g%% 抵抗:%g%% 有效率:%g";
SW_TT_SKILL_AVGMAX = "平均伤害:%g 最大伤害:%d";

SW_TT_UNIT_HEAD = "详细: %s";
SW_TT_UNIT_IN = "受到:";
SW_TT_UNIT_OUT = "输出:";
SW_TT_UNIT_DMGHEAL = "伤害:%d 有效治疗:%d 实际治疗:%d 过量治疗(战斗中):%g%%";
SW_TT_UNIT_CRIT = "伤害暴击:%g%% 治疗暴击:%g%%";

SW_TT_SCHOOL_DONE = "类型:%s (输出者 %s)";
SW_TT_SCHOOL_REC = "类型:%s (获得者 %s)";
SW_TT_SCHOOL_ZERODMG = "抵抗/未命中:%d 其他无效伤害:%d"; -- other = total absorb immune etc
SW_TT_SCHOOL_PARTIAL = "部分抵抗程度:%d";
SW_TT_SCHOOL_PERCENT = "完全抵抗率:%g%% 部分抵抗率:%g%%";
SW_TT_SCHOOL_AVGAPR = "平均伤害:%g 估计抵抗率:%g%%";

--2.0.beta.2
SW_REP_ACTIVE_SEGMENT = "仅活动时间段: %s"; -- used for reporting shows if only the active segment is selected

-- the main slash commands registered (only 2)
SW_RootSlashes = {"/swstats", "/sws"};

SW_CONSOLE_NOCMD = "没有此命令: ";
SW_CONSOLE_HELP ="说明:"
SW_CONSOLE_NIL_TRAILER = "未定义."; -- space at beginning, but chinese nothing.
SW_CONSOLE_SORTED = "分类";
SW_CONSOLE_NOREGEX = "此事件没有匹配表达式.";
SW_CONSOLE_FALLBACK = "发现匹配表达式 - 添加到列表";
SW_FALLBACK_BLOCK_INFO = "自动更新拒绝了此事件";
SW_FALLBACK_IGRNORED = "此事件被忽略.";
SW_EMPTY_EVENT = "监听不需要的事件?: ";
SW_INFO_PLAYER_NF = "无任何信息:";
SW_PRINT_INFO_FROMTO = "|cffffffff来自:|r%s, |cffffffff目标:|r%s,";
SW_PRINT_ITEM = "|cffffffff%s:|r%s,";
SW_PRINT_ITEM_DMG = "伤害";
SW_PRINT_ITEM_HEAL = "治疗";
SW_PRINT_ITEM_THROUGH = "通过";
SW_PRINT_ITEM_TYPE = "类型";
SW_PRINT_ITEM_CRIT = "|cffff2020致命一击|r";
SW_PRINT_ITEM_WORLD = "世界";
SW_PRINT_ITEM_NORMAL = "一般";
SW_PRINT_ITEM_RECIEVED = "受到";
SW_PRINT_INFO_RECIEVED = "|cffff2020伤害:%s|r, |cff20ff20治疗:%s|r";
SW_PRINT_ITEM_TOTAL_DONE = "全部";
SW_PRINT_ITEM_NON_SCHOOL = "其他";
SW_PRINT_ITEM_IGNORED = "忽略";
SW_PRINT_ITEM_DEATHS = "死亡";

SW_SYNC_CHAN_JOIN = "|cff20ff20SW同步频道:你已经加入:|r";
SW_SYNC_CHAN_FAIL= "|cffff2020SW同步频道:无法加入:|r";
SW_SYNC_JOINCHECK_FROM = "加入同步频道 %s 从: %s?"
SW_SYNC_JOINCHECK_INFO = "原有数据将全部清除!"
SW_SYNC_CURRENT = "目前同步频道: %s";
SW_BARS_WIDTHERROR = "状态条过长!"
SW_B_CONSOLE = "C";
SW_B_SETTINGS = "S";
SW_B_SYNC = "Y";
SW_B_REPORT = "R";
SW_STR_MAX = "Max";
SW_STR_EVENTCOUNT = "#";
SW_STR_AVERAGE = "ø";
SW_STR_PET_PREFIX = "[宠物] "; -- pet prefix for pet info displayed in the bars
SW_STR_VPP_PREFIX = "[所有宠物] "; -- pet prefix for virtual pet per player info displayed in the bars
SW_STR_VPR = "[团队宠物]"; -- pet string for virtual pet per raid info displayed in the bars
-- 1.5.beta.1 Reset vote
SW_STR_RV = "|cffff5d5d重置投票!|r 发起人 |cffff5d5d%s|r.  你是否同意重制同步频道?";
SW_STR_RV_PASSED =  "|cffffff00[SW 同步]|r |cff00ff00重置投票通过!|r";
SW_STR_RV_FAILED = "|cffffff00[SW 同步]|r |cffff5d5d重置投票没通过!|r";
SW_STR_VOTE_WARN = "|cffffff00[SW 同步]|r |cffff5d5d这不要反复提出投票...|r";

--1.5.3
--Raid DPS Strings
SW_RDPS_STRS = {
	["CURR"] = "团队DPS 目前战斗",
	["ALL"] = "团队DPS",
	["LAST"] = "团队DPS 最后战斗",
	["MAX"] = "团队DPS 最大值",
	["TOTAL"] = "团队DPS 计时模式", -- a timer that keeps running, no matter if in or out of fight
}

--[[
   you can ONLY localize the values! NOT the keys
   don't change aynthing like this ["someString"]
--]]
SW_Spellnames = {
	[1] = "解除次级诅咒",
	[2] = "解除诅咒",
	[3] = "驱散魔法",
	[4] = "祛病术",
	[5] = "驱除疾病",
	[6] = "纯凈术",
	[7] = "清洁术",
	[8] = "消毒术",
	[9] = "驱毒术",
	[10] = "凈化术",
}

SW_LocalizedGUI ={
	["SW_FrameConsole_Title"] = "SW v"..SW_VERSION,
	["SW_FrameConsole_Tab1"] = "一般",
	["SW_FrameConsole_Tab2"] = "事件信息",
	--["SW_FrameConsole_Tab3"] = "设置",
	["SW_BarSettingsFrameV2_Tab1"] = "数据",
	["SW_BarSettingsFrameV2_Tab2"] = "外观设置",
	["SW_BarSettingsFrameV2_Tab3"] = "宠物",
	["SW_Chk_ShowEventText"] = "显示事件->匹配表达式",
	["SW_Chk_ShowOrigStrText"] = "显示日志信息",
	["SW_Chk_ShowRegExText"] = "显示匹配表达式",
	["SW_Chk_ShowMatchText"] = "显示匹配",
	["SW_Chk_ShowSyncInfoText"] = "显示同步信息",
	--["SW_Chk_ShowOnlyFriendsText"] = "只显示友方角色",
	["SW_Chk_ShowTLBText"] = "显示时间段按键",
	["SW_Chk_ShowSyncBText"] = "显示同步按钮",
	["SW_Chk_ShowConsoleBText"] = "显示控制台按钮",
	["SW_Chk_MergePetsText"] = "合并宠物数据到主人",
	["SW_Chk_ShowDPSText"] = "DPS";
	["SW_RepTo_SayText"] = "说",
	["SW_RepTo_GroupText"] = "队伍",
	["SW_RepTo_RaidText"] = "团队",
	["SW_RepTo_GuildText"] = "工会",
	["SW_RepTo_ChannelText"] = "频道",
	["SW_RepTo_WhisperText"] = "悄悄话",
	["SW_RepTo_ClipboardText"] = "剪贴板",
	["SW_RepTo_OfficerText"] = "队长",
	["SW_BarReportFrame_Title_Text"] = "发送给..",
	["SW_Chk_RepMultiText"] = "多行显示",
	["SW_Filter_PCText"] = "PC",
	["SW_Filter_NPCText"] = "NPC",
	["SW_Filter_GroupText"] = "目前的队伍/团队",
	["SW_Filter_EverGroupText"] = "最后的队伍/团队",
	["SW_Filter_NoneText"] = "无",
	["SW_GeneralSettings_Title_Text"] = "一般设置",
	["SW_BarSyncFrame_Title_Text"] = "同步频道设置",
	["SW_BarSettingsFrameV2_Title_Text"] = "设置",
	["SW_BarSyncFrame_SyncLeave"] = "离开",
	["SW_BarSyncFrame_OptGroupText"] = "队伍",
	["SW_BarSyncFrame_OptRaidText"] = "团队",
	["SW_BarSyncFrame_OptGuildText"] = "工会",
	["SW_BarSyncFrame_SyncSend"] = "发送给",
	["SW_CS_Damage"] = "颜色: 伤害",
	["SW_CS_Heal"] = "颜色: 治疗",
	["SW_CS_BarC"] = "颜色: 状态条",
	["SW_CS_FontC"] = "颜色: 字体",
	["SW_CS_OptC"] = "颜色: 按钮",
	["SW_TextureSlider"] = "背景:",
	["SW_FontSizeSlider"] = "字体大小:",
	["SW_BarHeightSlider"] = "高度:",
	--["SW_BarWidthSlider"] = "宽度:", removed 1.4.2
	["SW_ColCountSlider"] = "显示列数:", 
	["SW_OptChk_NumText"] = "总数",
	["SW_OptChk_RankText"] = "序号",
	["SW_OptChk_PercentText"] = "百分比",
	["SW_VarInfoLbl"] = "该信息需要一个目标. 输入名称或点击'使用目标'按键选择当前的目标",
	["SW_NoPetInfoLabel"] = "没有信息不包括任何宠物过滤设置.",
	["SW_SetInfoVarFromTarget"] = "使用目标",
	["SW_ColorsOptUseClassText"] = "职业色彩",
	["SW_TextWindow_Title_Text"] = "使用Ctrl+c复制.",
	["SW_BarSyncFrame_SyncARPY"] = "允许",--{["s"] = "允许", ["f"] = SetButtonText },
	["SW_BarSyncFrame_SyncARPN"] = "阻止",--{["s"] = "阻止", ["f"] = SetButtonText },
	-- 1.5 new pet filter labels 
	["SW_PF_InactiveText"] = "不活动",
	["SW_PF_ActiveText"] = "活动",
	["SW_PF_MMText"] = "合并输出量",
	["SW_PF_MRText"] = "合并承受量",
	["SW_PF_MBText"] = "合并两者",
	["SW_PF_CurrentText"] = "目前",
	["SW_PF_VPPText"] = "显示玩家宠物",
	["SW_PF_VPRText"] = "显示团队宠物",
	["SW_PF_IgnoreText"] = "忽略所有宠物信息",

	-- 1.5.3 new color settings
	["SW_CS_TitleBar"] = "标题栏颜色",
	["SW_CS_TitleFont"] = "标题栏字体",
	["SW_CS_Backdrops"] = "窗口和标签颜色",
	["SW_CS_MainWinBack"] = "主窗口背景",
	["SW_CS_ClassCAlpha"] = "职业色彩透明度",

	["SW_Chk_TL_SafeModeText"] = "安全模式",
	["SW_Chk_TL_SingleSelectText"] = "单一时间段",
	["SW_TL_Merge"]  = "合并",
	["SW_TL_Select"] = "重新计算",
	["SW_TL_ReloadUI"] = "重置UI",
	["SW_TL_Nuke"] = "重置数据",
	["SW_HealOpt_EffText"] = "有效",
	["SW_HealOpt_OHText"] = "过量",
	["SW_HealOpt_IFText"] = "战斗中",
	
	["SW_TimeLine_Title_Text"] = "时间段",	
	["SW_BarSyncFrame_InfoText"] = "这是空栏目,除非你在一个小队/团队里",
	["SW_Chk_TL_AutoZoneText"] = "自动区域",
	["SW_AutoVoteYesText"] = "自动投票:是",
	["SW_AutoVoteNoText"] = "自动投票:否",
	["SW_Chk_TL_AutoDeleteText"] = "自动删除",

}

--SW_GS_Tooltips["SW_Chk_ShowOnlyFriends"] = "此选项仅被使用于,过滤发送给控制台信息的 /sws 命令.";
SW_GS_Tooltips["SW_Chk_ShowTLB"] = "在主窗口标题栏显示时间段设置按钮.";
SW_GS_Tooltips["SW_Chk_ShowSyncB"] = "在主窗口标题栏显示数据类型设置按钮.";
SW_GS_Tooltips["SW_Chk_ShowConsoleB"] = "在主窗口标题栏显示扩展控制台按钮.";
SW_GS_Tooltips["SW_CS_Damage"] = "伤害条颜色. 例如: 查看细节时的颜色.";
SW_GS_Tooltips["SW_CS_Heal"] = "治疗条颜色. 例如: 查看细节时的颜色.";
SW_GS_Tooltips["SW_CS_BarC"] = "状态条颜色. 可能被显示数据的颜色代替.";
SW_GS_Tooltips["SW_CS_FontC"] = "字体颜色.";
SW_GS_Tooltips["SW_CS_OptC"] = "改变主窗口下按钮颜色.";
SW_GS_Tooltips["SW_TextureSlider"] = "改变状态条背景";
SW_GS_Tooltips["SW_FontSizeSlider"] = "改变状态条中字体大小";
SW_GS_Tooltips["SW_BarHeightSlider"] = "改变状态条高度";
--SW_GS_Tooltips["SW_BarWidthSlider"] = "改变状态条宽度"; removed 1.4.2
SW_GS_Tooltips["SW_ColCountSlider"] = "改变主窗口显示的列数."; 
SW_GS_Tooltips["SW_SetOptTxtFrame"] = "改变主窗口下按钮文字.";
SW_GS_Tooltips["SW_SetFrameTxtFrame"] = "改变主窗口标题栏的文字.";
SW_GS_Tooltips["SW_OptChk_Num"] = "显示数值. (例如.伤害、治疗等等.).";
SW_GS_Tooltips["SW_OptChk_Rank"] = "显示排名序号.";
SW_GS_Tooltips["SW_OptChk_Percent"] = "显示百分比. (显示在团队中的比例.)";
SW_GS_Tooltips["SW_Filter_None"] = "无 PC/NPC/队伍/团队 过滤. 所有数据显示在状态条";
SW_GS_Tooltips["SW_Filter_PC"] = "玩家角色过滤. 玩家角色在你的队伍里或者是你当前目标时有效.";
SW_GS_Tooltips["SW_Filter_NPC"] = "NPC过滤, 你需要选择一个角色 , 目标不是玩家控制的.";
SW_GS_Tooltips["SW_Filter_Group"] = "仅显示在你队伍/团队中的玩家及宠物.";
SW_GS_Tooltips["SW_Filter_EverGroup"] = "显示最后一次参加的团队活动数据."; 
SW_GS_Tooltips["SW_ClassFilterSlider"] = "职业过滤. 仅显示指定职业的数据. (第一次运行将显示英文职业名,各职业需要加入过一次你的队伍/团队,将显示本地语言名)";
SW_GS_Tooltips["SW_InfoTypeSlider"] = "设置要显示哪种数据. (同步)标示表示该数据类型是否支持同步.";
SW_GS_Tooltips["SW_ColorsOptUseClass"] = "使用职业色彩. 使用颜色区分玩家职业. (已知玩家及怪物的职业将代替状态条的颜色) ";
SW_GS_Tooltips["SW_Chk_ShowDPS"] = "是否显示DPS到主窗口界面?";
SW_GS_Tooltips["SW_OptCountSlider"] = "改变主窗口下按键总数";
SW_GS_Tooltips["SW_AllowARP"] = "允许报告到RAID.";
SW_GS_Tooltips["SW_DisAllowARP"] = "阻止报告到RAID";
SW_GS_Tooltips["SW_OptChk_Running"] = "取消选择将暂停搜集数据. 选择上继续收集数据. 但是你在一个同步频道里不能暂停收集数据."; 
-- 1.5 new pet filter Tooltips
SW_GS_Tooltips["SW_PF_Inactive"] = "新的宠物统计已经完成,可以在这里设置宠物相关信息.";
SW_GS_Tooltips["SW_PF_Active"] = "活动,"..SW_STR_PET_PREFIX.." 控制/奴役并且显示在拥有者记录里. 仅宠物存在时统计. (控制其他怪物时不会显示在拥有者上,只会显示在团队中)";
SW_GS_Tooltips["SW_PF_MM"] = "隐藏宠物产生的伤害/治疗,将其合并在拥有者上..";
SW_GS_Tooltips["SW_PF_MR"] = "隐藏宠物获得的伤害/治疗,将其合并在拥有者上.";
SW_GS_Tooltips["SW_PF_MB"] = "隐藏宠物获得和产生的伤害/治疗,将其合并在拥有者上..";
SW_GS_Tooltips["SW_PF_Current"] = "拥有宠物的才显示.";
SW_GS_Tooltips["SW_PF_VPP"] = "所有宠物都被合并在一起.";
SW_GS_Tooltips["SW_PF_VPR"] = "所有团队宠物都被合并在一起.";
SW_GS_Tooltips["SW_PF_Ignore"] = "所有宠物信息忽略.";
--1.5.3 new color options
SW_GS_Tooltips["SW_CS_TitleBar"] =  "改变所有的标题栏和按键色彩. 可能(修改到设置) 改变主窗口上的按键颜色.";
SW_GS_Tooltips["SW_CS_TitleFont"] =  "改变所有伤害/治疗条的字体和按键的颜色.";
SW_GS_Tooltips["SW_CS_Backdrops"] =  "改变窗口周围的颜色. 标签颜色也会改变,但是不改变透明通道.";
SW_GS_Tooltips["SW_CS_MainWinBack"] = "改变主窗格背景色彩.";
SW_GS_Tooltips["SW_CS_ClassCAlpha"] = "仅仅修改被职业色彩使用的透明通道";

SW_GS_Tooltips["SW_Chk_TL_SafeMode"] = "选择该项, 你将发布你的删除以及合并时间标记给同步频道.";
SW_GS_Tooltips["SW_Chk_TL_SingleSelect"] = "选择该项,产生的数据将在一个合并的时间段内. 使用重新计算也能得到整个数据.";
SW_GS_Tooltips["SW_HealOpt_Eff"] = "选择该项,过量治疗将被减去.";
SW_GS_Tooltips["SW_HealOpt_OH"] = "选择该项,将只显示过量治疗.";
SW_GS_Tooltips["SW_HealOpt_IF"] = "选择该项,将计算战斗中的 治疗/过量治疗";
SW_GS_Tooltips["SW_Chk_TL_AutoZone"] = "选择该项,进入新的区域将自动创建时间段.";
SW_GS_Tooltips["SW_TL_ReloadUI"] = "执行它避免 \"重复数据\" 建议只有在没有时间段载入时使用(或你的同步没有激活时使用)";
SW_GS_Tooltips["SW_AutoVoteYes"] = "选择该项,所有重置投票你自带回复是.";
SW_GS_Tooltips["SW_AutoVoteNo"] = "选择该项,所有重置投票你自带回复否";
SW_GS_Tooltips["SW_Chk_TL_AutoDelete"] = "如果选择该项,将自动删除大于"..SW_TL_AUTO_THRESH.."小时的数据.";

-- edit boxes
SW_GS_EditBoxes["SW_SetOptTxtFrame"] = {"更改","按钮名: ", "新按钮名:" };
SW_GS_EditBoxes["SW_SetFrameTxtFrame"] = {"更改","标题: ", "新标题:" };
SW_GS_EditBoxes["SW_SetInfoVarTxtFrame"] = {"更改","来源信息: ", "新玩家或NPC名字:" };
SW_GS_EditBoxes["SW_SetSyncChanTxtFrame"] = {"更改","同步频道: ", "新同步频道:" };

--popups
StaticPopupDialogs["SW_Mem_Warning"]["text"] = "存储的历史数据量过多. 请从时间段中删除过时数据.\r\n (删除按键在显示时间段界面里)";
StaticPopupDialogs["SW_TL_Delete"]["text"] = "你需要删除这段数据吗?";
StaticPopupDialogs["SW_TL_Nuke"]["text"] = "你需要删除所有的数据吗?";
StaticPopupDialogs["SW_TL_Merge"]["text"] = "你需要合并选择的数据段吗?";
StaticPopupDialogs["SW_Reset"]["text"] = "你需要重置数据吗?";
StaticPopupDialogs["SW_ResetSync"]["text"] = "你正在一个同步频道,该操作将使所有同步玩家创建新的时间段!你需要这样做吗?";
StaticPopupDialogs["SW_ResetFailInfo"]["text"] = "你正在一个同步频道,无法重置数据,只有队长/团长才有权利重置,或者使用/sws rv命令投票!";
StaticPopupDialogs["SW_PostFail"]["text"] = "抱歉, 你不能发送到这个频道. 需要RAID队长允许你才可以发送数据到该频道!";
StaticPopupDialogs["SW_InvalidChan"]["text"] = "无效的频道名.";

-- Minimap Icon Menu strings
SW_MiniIconMenu[2]["textShow"] = "显示主窗口";
SW_MiniIconMenu[2]["textHide"] = "隐藏主窗口";
SW_MiniIconMenu[3]["textShow"] = "显示控制台";
SW_MiniIconMenu[3]["textHide"] = "隐藏控制台";
SW_MiniIconMenu[4]["textShow"] = "显示常规设置";
SW_MiniIconMenu[4]["textHide"] = "隐藏常规设置";
SW_MiniIconMenu[5]["textShow"] = "显示同步设置";
SW_MiniIconMenu[5]["textHide"] = "隐藏同步设置";
SW_MiniIconMenu[6]["textShow"] = "显示时间段";
SW_MiniIconMenu[6]["textHide"] = "隐藏时间段";
SW_MiniIconMenu[8]["text"] = "重置数据";


-- key bindig strings
BINDING_HEADER_SW_BINDINGS = "数据同步...";
BINDING_NAME_SW_BIND_TOGGLEBARS = "显示/隐藏主窗口.";
BINDING_NAME_SW_BIND_CONSOLE = "显示/隐藏控制台.";
BINDING_NAME_SW_BIND_PAGE1 = "信息栏 1";
BINDING_NAME_SW_BIND_PAGE2 = "信息栏 2";
BINDING_NAME_SW_BIND_PAGE3 = "信息栏 3";
BINDING_NAME_SW_BIND_PAGE4 = "信息栏 4";
BINDING_NAME_SW_BIND_PAGE5 = "信息栏 5";
BINDING_NAME_SW_BIND_PAGE6 = "信息栏 6";
BINDING_NAME_SW_BIND_PAGE7 = "信息栏 7";
BINDING_NAME_SW_BIND_PAGE8 = "信息栏 8";
BINDING_NAME_SW_BIND_PAGE9 = "信息栏 9";
BINDING_NAME_SW_BIND_PAGE10 = "信息栏 10";
BINDING_NAME_SW_BIND_PAGENEXT ="后翻";
BINDING_NAME_SW_BIND_PAGEPREV ="前翻";

--info types
SW_InfoTypes[1]["t"] = "伤害列表 (同步)";
SW_InfoTypes[1]["d"] = "显示伤害列表.";
SW_InfoTypes[2]["t"] = "治疗列表 (同步)";
SW_InfoTypes[2]["d"] = "显示治疗列表. (包括过量治疗).";
SW_InfoTypes[3]["t"] = "获得伤害 (同步)";
SW_InfoTypes[3]["d"] = "显示受到的伤害列表. (谁受到最多伤害?)";
SW_InfoTypes[4]["t"] = "获得治疗 (同步)";
SW_InfoTypes[4]["d"] = "显示受到治疗的目标. (谁得到最多治疗?)";
SW_InfoTypes[5]["t"] = "治疗目标 (不同步)";
SW_InfoTypes[5]["d"] = "显示详细治疗目标信息. (设定的目标治疗了谁?)";
SW_InfoTypes[6]["t"] = "治疗者 (不同步)";
SW_InfoTypes[6]["d"] = "显示某人详细治疗者信息. (谁治疗了某人?)";
SW_InfoTypes[7]["t"] = "详情 (不同步)";
SW_InfoTypes[7]["d"] = "详细的技能信息.(使用了什么技能?) 括号中的数字表示此技能造成的最大伤害/治疗";
SW_InfoTypes[8]["t"] = "详情/事件 (不同步)";
SW_InfoTypes[8]["d"] = "显示技能平均信息.(例如玩家使用寒冰箭造成的平均伤害?)后面数字表示技能使用的次数. 注意: 非常大的伤害或非常小的DOT可能带小数.";
SW_InfoTypes[9]["t"] = "伤害类型 (不同步)";
SW_InfoTypes[9]["d"] = "显示伤害类型信息. (玩家造成的主要伤害? 例如: 火,冰等等.)";
SW_InfoTypes[10]["t"] = "受到伤害的类型 (不同步)";
SW_InfoTypes[10]["d"] = "显示受到伤害的类型. (玩家受到伤害的类型? 例如: 火,冰等等.)";
SW_InfoTypes[11]["t"] = "总伤害类型 (不同步)";
SW_InfoTypes[11]["d"] = "显示伤害类型.(团队造成的主要伤害类型? 例如: 火,冰 等等.) 注意: 使用职业过滤.";
SW_InfoTypes[12]["t"] = "获得伤害的类型 (不同步)";
SW_InfoTypes[12]["d"] = "显示团队受到的伤害类型.(团队受到的伤害类型? 例如: 火,冰等等.) 注意: 使用职业过滤.";

SW_InfoTypes[13]["t"] = "技能-魔法 用量(不同步)";
SW_InfoTypes[13]["d"] = "显示每点魔法产生的伤害和治疗总量. 该数据显示出魔法使用效率 (仅对自己有效).";
SW_InfoTypes[14]["t"] = "死亡次数 (同步)";
SW_InfoTypes[14]["d"] = "哪些人经常死亡? 这个计数统计死亡的次数!";
SW_InfoTypes[15]["t"] = "解除诅咒次数(同步)";
SW_InfoTypes[15]["d"] = "某人解除的诅咒?:"..SW_GetSpellList();
SW_InfoTypes[16]["t"] = "获得解除诅咒次数 (同步)";
SW_InfoTypes[16]["d"] = "被解除的诅咒?:"..SW_GetSpellList();
SW_InfoTypes[17]["t"] = "有效每秒伤害-DPS (同步)";
SW_InfoTypes[17]["d"] = "可能和个人统计的DPS数值有些不同,因为采用团队'进入战斗'的计时器(可能成员在团队里的某些动作,比如假死)";
SW_InfoTypes[18]["t"] = "每秒受到的伤害(同步)";
SW_InfoTypes[18]["d"] = "这个通常用来检测团队给怪物的每秒伤害输出(使用NPC过滤)";
SW_InfoTypes[19]["t"] = "每秒治疗量-HPS(同步)";
SW_InfoTypes[19]["d"] = "像每秒伤害那样的列表,不过显示的是治疗数据.";
SW_InfoTypes[20]["t"] = "最大一击列表(不同步)";
SW_InfoTypes[20]["d"] = "显示每个人最大伤害值列表(最大暴击列表).";
SW_InfoTypes[21]["t"] = "最大治疗列表(不同步)";
SW_InfoTypes[21]["d"] = "显示每个人最大治疗值列表(它不考虑过量治疗因素)";
SW_InfoTypes[22]["t"] = "抵抗率统计(不同步)";
SW_InfoTypes[22]["d"] = "显示对各种伤害类型的抵抗百分比";
SW_InfoTypes[23]["t"] = "对目标的伤害(不同步)";
SW_InfoTypes[23]["d"] = "显示对选择目标的伤害(谁对该目标进行了伤害?)";

SW_LocalizedCommands = {
	["help"] = {	["c"] = "?",
					["si"] = "显示控制台帮助.",
	},
	["console"] = {["c"] = "con",
				   ["si"] = "打开控制台",
	},
	["dumpVar"] = {["c"] = "dump",
				   ["si"] = "清除变量",
				   ["u"] = "用法:"..SW_RootSlashes[1].." dump 变量名",
	},
	["reset"] = {	["c"] = "reset",
					["si"] = "创建新的数据段或时间段. 假如你不提供数据段或时间段的名字它将\""..SW_DS_RESET.."\".",
					["u"] = "Usage:"..SW_RootSlashes[1].." reset [名字]",
	},
	["toggleBars"]={["c"] = "bars",
					["si"] = "显示或隐藏主窗口",
					
	},
	["toggleGS"] = {["c"] = "gs",
					["si"] = "显示或隐藏常规设置窗口",
	},
	["nukeDS"] ={["c"] = "nuke",
					["si"] = "重置所有同步成员的数据.",
	},
	["resetVote"]={ ["c"] = "rv",
					["si"] = "开始投票来重置某个时间段或数据段的同步.如果你不提供数据段或时间段名字将\""..SW_DS_RESET.."\".",
					["u"] = "Usage:"..SW_RootSlashes[1].." rv [名字]",
	},
}

-- this MUST go at the end of a localization
-- Again if you create a localization put SW_mergeLocalization(); at the end!!!
SW_mergeLocalization();
end