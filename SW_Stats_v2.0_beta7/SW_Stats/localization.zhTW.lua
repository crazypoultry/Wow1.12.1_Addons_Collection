--[[
	WARNING! If you edit this file you need a good editor, not notepad.
	This file HAS to be saved in UTF-8 format (without signature) else we would have to escape
	all special chars

	Credits for zhTW translation: apa1102 / jinsong zhao
	Thanks a LOT!
]]--

if (GetLocale() == "zhTW") then

SW_DS_START = "開始"; -- name of the first segment
SW_DS_RESET = "重置"; 
SW_DS_ZONED = "區域 %s";
SW_DS_JOINED_GROUP = "加入隊伍";
SW_DS_LEFT_GROUP = "離開隊伍";
SW_DS_JOINED_RAID = "加入團隊";
SW_DS_LEFT_RAID = "離開團隊";
SW_DS_MERGED = "合幷的"; -- used when merging data segements
SW_DS_SYNC_INIT = "新同步"; -- 2.0.beta.2
-- not used yet
SW_DS_ENCOUNTER = "Started fight with %s";
SW_DS_PHASE_CHANGE = "%s Phase %d";
SW_DS_TIMER = "%d seconds elapsed";


-- special "school" for environmental damage
-- falling drowining etc
SW_STR_ENVIRO = "環境";

SW_CL_SHOOT = "射擊"; -- the Wand "Shoot" ability as found in the combat log
SW_MAP_SKILL_DMGSHIELD = "傷害盾"; -- "skill" name to map damge shields to (thorns etc.)

-- strings for detail info on mouse over
SW_TT_SKILL_HEAD = "詳細: %s (%s)";
SW_TT_SKILL_SWINGS = "命中:%d 次數:%d 失誤:%d 抵抗:%d 無效傷害:%d";
SW_TT_SKILL_CRITS = "暴擊:%d 暴擊率:%g%% 無效傷害暴率:%g%%";
SW_TT_SKILL_GLCRUSH = "偏斜:%d 碾壓:%d";
SW_TT_SKILL_RMP = "躲閃:%g%% 抵抗:%g%% 有效率:%g";
SW_TT_SKILL_AVGMAX = "平均傷害:%g 最大傷害:%d";

SW_TT_UNIT_HEAD = "詳細: %s";
SW_TT_UNIT_IN = "受到:";
SW_TT_UNIT_OUT = "輸出:";
SW_TT_UNIT_DMGHEAL = "傷害:%d 有效治療:%d 實際治療:%d 過量治療(戰鬥中):%g%%";
SW_TT_UNIT_CRIT = "傷害暴擊:%g%% 治療暴擊:%g%%";

SW_TT_SCHOOL_DONE = "類型:%s (輸出者 %s)";
SW_TT_SCHOOL_REC = "類型:%s (獲得者 %s)";
SW_TT_SCHOOL_ZERODMG = "抵抗/未命中:%d 其他無效傷害:%d"; -- other = total absorb immune etc
SW_TT_SCHOOL_PARTIAL = "部分抵抗程度:%d";
SW_TT_SCHOOL_PERCENT = "完全抵抗率:%g%% 部分抵抗率:%g%%";
SW_TT_SCHOOL_AVGAPR = "平均傷害:%g 估計抵抗率:%g%%";

--2.0.beta.2
SW_REP_ACTIVE_SEGMENT = "僅活動時間段: %s"; -- used for reporting shows if only the active segment is selected

-- the main slash commands registered (only 2)
SW_RootSlashes = {"/swstats", "/sws"};

SW_CONSOLE_NOCMD = "沒有此命令: ";
SW_CONSOLE_HELP ="說明:"
SW_CONSOLE_NIL_TRAILER = "未定義."; -- space at beginning, but chinese nothing.
SW_CONSOLE_SORTED = "分類";
SW_CONSOLE_NOREGEX = "此事件沒有匹配表達式.";
SW_CONSOLE_FALLBACK = "發現匹配表達式 - 添加到列表";
SW_FALLBACK_BLOCK_INFO = "自動更新拒絕了此事件";
SW_FALLBACK_IGRNORED = "此事件被忽略.";
SW_EMPTY_EVENT = "監聽不需要的事件?: ";
SW_INFO_PLAYER_NF = "無任何信息:";
SW_PRINT_INFO_FROMTO = "|cffffffff來自:|r%s, |cffffffff目標:|r%s,";
SW_PRINT_ITEM = "|cffffffff%s:|r%s,";
SW_PRINT_ITEM_DMG = "傷害";
SW_PRINT_ITEM_HEAL = "治療";
SW_PRINT_ITEM_THROUGH = "通過";
SW_PRINT_ITEM_TYPE = "類型";
SW_PRINT_ITEM_CRIT = "|cffff2020致命一擊|r";
SW_PRINT_ITEM_WORLD = "世界";
SW_PRINT_ITEM_NORMAL = "一般";
SW_PRINT_ITEM_RECIEVED = "受到";
SW_PRINT_INFO_RECIEVED = "|cffff2020傷害:%s|r, |cff20ff20治療:%s|r";
SW_PRINT_ITEM_TOTAL_DONE = "全部";
SW_PRINT_ITEM_NON_SCHOOL = "其他";
SW_PRINT_ITEM_IGNORED = "忽略";
SW_PRINT_ITEM_DEATHS = "死亡";

SW_SYNC_CHAN_JOIN = "|cff20ff20SW同步頻道:你已經加入:|r";
SW_SYNC_CHAN_FAIL= "|cffff2020SW同步頻道:無法加入:|r";
SW_SYNC_JOINCHECK_FROM = "加入同步頻道 %s 從: %s?"
SW_SYNC_JOINCHECK_INFO = "原有數據將全部清除!"
SW_SYNC_CURRENT = "目前同步頻道: %s";
SW_BARS_WIDTHERROR = "狀態條過長!"
SW_B_CONSOLE = "C";
SW_B_SETTINGS = "S";
SW_B_SYNC = "Y";
SW_B_REPORT = "R";
SW_STR_MAX = "Max";
SW_STR_EVENTCOUNT = "#";
SW_STR_AVERAGE = "ø";
SW_STR_PET_PREFIX = "[寵物] "; -- pet prefix for pet info displayed in the bars
SW_STR_VPP_PREFIX = "[所有寵物] "; -- pet prefix for virtual pet per player info displayed in the bars
SW_STR_VPR = "[團隊寵物]"; -- pet string for virtual pet per raid info displayed in the bars
-- 1.5.beta.1 Reset vote
SW_STR_RV = "|cffff5d5d重置投票!|r 發起人 |cffff5d5d%s|r.  你是否同意重制同步頻道?";
SW_STR_RV_PASSED =  "|cffffff00[SW 同步]|r |cff00ff00重置投票通過!|r";
SW_STR_RV_FAILED = "|cffffff00[SW 同步]|r |cffff5d5d重置投票沒通過!|r";
SW_STR_VOTE_WARN = "|cffffff00[SW 同步]|r |cffff5d5d這不要反復提出投票...|r";

--1.5.3
--Raid DPS Strings
SW_RDPS_STRS = {
	["CURR"] = "團隊DPS 目前戰鬥",
	["ALL"] = "團隊DPS",
	["LAST"] = "團隊DPS 最後戰鬥",
	["MAX"] = "團隊DPS 最大值",
	["TOTAL"] = "團隊DPS 計時模式", -- a timer that keeps running, no matter if in or out of fight
}

--[[
   you can ONLY localize the values! NOT the keys
   don't change aynthing like this ["someString"]
--]]
SW_Spellnames = {
	[1] = "解除次級詛咒",
	[2] = "解除詛咒",
	[3] = "驅散魔法",
	[4] = "祛病術",
	[5] = "驅除疾病",
	[6] = "純凈術",
	[7] = "清潔術",
	[8] = "消毒術",
	[9] = "驅毒術",
	[10] = "凈化術",
}

SW_LocalizedGUI ={
	["SW_FrameConsole_Title"] = "SW v"..SW_VERSION,
	["SW_FrameConsole_Tab1"] = "一般",
	["SW_FrameConsole_Tab2"] = "事件信息",
	--["SW_FrameConsole_Tab3"] = "設置",
	["SW_BarSettingsFrameV2_Tab1"] = "數據",
	["SW_BarSettingsFrameV2_Tab2"] = "外觀設置",
	["SW_BarSettingsFrameV2_Tab3"] = "寵物",
	["SW_Chk_ShowEventText"] = "顯示事件->匹配表達式",
	["SW_Chk_ShowOrigStrText"] = "顯示日志信息",
	["SW_Chk_ShowRegExText"] = "顯示匹配表達式",
	["SW_Chk_ShowMatchText"] = "顯示匹配",
	["SW_Chk_ShowSyncInfoText"] = "顯示同步信息",
	--["SW_Chk_ShowOnlyFriendsText"] = "只顯示友方角色",
	["SW_Chk_ShowTLBText"] = "顯示時間段按鍵",
	["SW_Chk_ShowSyncBText"] = "顯示同步按鈕",
	["SW_Chk_ShowConsoleBText"] = "顯示控制臺按鈕",
	["SW_Chk_MergePetsText"] = "合幷寵物數據到主人",
	["SW_Chk_ShowDPSText"] = "DPS";
	["SW_RepTo_SayText"] = "說",
	["SW_RepTo_GroupText"] = "隊伍",
	["SW_RepTo_RaidText"] = "團隊",
	["SW_RepTo_GuildText"] = "工會",
	["SW_RepTo_ChannelText"] = "頻道",
	["SW_RepTo_WhisperText"] = "悄悄話",
	["SW_RepTo_ClipboardText"] = "剪貼板",
	["SW_RepTo_OfficerText"] = "隊長",
	["SW_BarReportFrame_Title_Text"] = "發送給..",
	["SW_Chk_RepMultiText"] = "多行顯示",
	["SW_Filter_PCText"] = "PC",
	["SW_Filter_NPCText"] = "NPC",
	["SW_Filter_GroupText"] = "目前的隊伍/團隊",
	["SW_Filter_EverGroupText"] = "最後的隊伍/團隊",
	["SW_Filter_NoneText"] = "無",
	["SW_GeneralSettings_Title_Text"] = "一般設置",
	["SW_BarSyncFrame_Title_Text"] = "同步頻道設置",
	["SW_BarSettingsFrameV2_Title_Text"] = "設置",
	["SW_BarSyncFrame_SyncLeave"] = "離開",
	["SW_BarSyncFrame_OptGroupText"] = "隊伍",
	["SW_BarSyncFrame_OptRaidText"] = "團隊",
	["SW_BarSyncFrame_OptGuildText"] = "工會",
	["SW_BarSyncFrame_SyncSend"] = "發送給",
	["SW_CS_Damage"] = "顔色: 傷害",
	["SW_CS_Heal"] = "顔色: 治療",
	["SW_CS_BarC"] = "顔色: 狀態條",
	["SW_CS_FontC"] = "顔色: 字體",
	["SW_CS_OptC"] = "顔色: 按鈕",
	["SW_TextureSlider"] = "背景:",
	["SW_FontSizeSlider"] = "字體大小:",
	["SW_BarHeightSlider"] = "高度:",
	--["SW_BarWidthSlider"] = "寬度:", removed 1.4.2
	["SW_ColCountSlider"] = "顯示列數:", 
	["SW_OptChk_NumText"] = "總數",
	["SW_OptChk_RankText"] = "序號",
	["SW_OptChk_PercentText"] = "百分比",
	["SW_VarInfoLbl"] = "該信息需要一個目標. 輸入名稱或點擊'使用目標'按鍵選擇當前的目標",
	["SW_NoPetInfoLabel"] = "沒有信息不包括任何寵物過濾設置.",
	["SW_SetInfoVarFromTarget"] = "使用目標",
	["SW_ColorsOptUseClassText"] = "職業色彩",
	["SW_TextWindow_Title_Text"] = "使用Ctrl+c複製.",
	["SW_BarSyncFrame_SyncARPY"] = "允許",--{["s"] = "允許", ["f"] = SetButtonText },
	["SW_BarSyncFrame_SyncARPN"] = "阻止",--{["s"] = "阻止", ["f"] = SetButtonText },
	-- 1.5 new pet filter labels 
	["SW_PF_InactiveText"] = "不活動",
	["SW_PF_ActiveText"] = "活動",
	["SW_PF_MMText"] = "合幷輸出量",
	["SW_PF_MRText"] = "合幷承受量",
	["SW_PF_MBText"] = "合幷兩者",
	["SW_PF_CurrentText"] = "目前",
	["SW_PF_VPPText"] = "顯示玩家寵物",
	["SW_PF_VPRText"] = "顯示團隊寵物",
	["SW_PF_IgnoreText"] = "忽略所有寵物信息",

	-- 1.5.3 new color settings
	["SW_CS_TitleBar"] = "標題欄顔色",
	["SW_CS_TitleFont"] = "標題欄字體",
	["SW_CS_Backdrops"] = "窗口和標簽顔色",
	["SW_CS_MainWinBack"] = "主窗口背景",
	["SW_CS_ClassCAlpha"] = "職業色彩透明度",

	["SW_Chk_TL_SafeModeText"] = "安全模式",
	["SW_Chk_TL_SingleSelectText"] = "單一時間段",
	["SW_TL_Merge"]  = "合幷",
	["SW_TL_Select"] = "重新計算",
	["SW_TL_ReloadUI"] = "重置UI",
	["SW_TL_Nuke"] = "重置數據",
	["SW_HealOpt_EffText"] = "有效",
	["SW_HealOpt_OHText"] = "過量",
	["SW_HealOpt_IFText"] = "戰鬥中",
	
	["SW_TimeLine_Title_Text"] = "時間段",	
	["SW_BarSyncFrame_InfoText"] = "這是空欄目,除非你在一個小隊/團隊裏",
	["SW_Chk_TL_AutoZoneText"] = "自動區域",
	["SW_AutoVoteYesText"] = "自動投票:是",
	["SW_AutoVoteNoText"] = "自動投票:否",
	["SW_Chk_TL_AutoDeleteText"] = "自動删除",

}

--SW_GS_Tooltips["SW_Chk_ShowOnlyFriends"] = "此選項僅被使用于,過濾發送給控制臺信息的 /sws 命令.";
SW_GS_Tooltips["SW_Chk_ShowTLB"] = "在主窗口標題欄顯示時間段設置按鈕.";
SW_GS_Tooltips["SW_Chk_ShowSyncB"] = "在主窗口標題欄顯示數據類型設置按鈕.";
SW_GS_Tooltips["SW_Chk_ShowConsoleB"] = "在主窗口標題欄顯示擴展控制臺按鈕.";
SW_GS_Tooltips["SW_CS_Damage"] = "傷害條顔色. 例如: 查看細節時的顔色.";
SW_GS_Tooltips["SW_CS_Heal"] = "治療條顔色. 例如: 查看細節時的顔色.";
SW_GS_Tooltips["SW_CS_BarC"] = "狀態條顔色. 可能被顯示數據的顔色代替.";
SW_GS_Tooltips["SW_CS_FontC"] = "字體顔色.";
SW_GS_Tooltips["SW_CS_OptC"] = "改變主窗口下按鈕顔色.";
SW_GS_Tooltips["SW_TextureSlider"] = "改變狀態條背景";
SW_GS_Tooltips["SW_FontSizeSlider"] = "改變狀態條中字體大小";
SW_GS_Tooltips["SW_BarHeightSlider"] = "改變狀態條高度";
--SW_GS_Tooltips["SW_BarWidthSlider"] = "改變狀態條寬度"; removed 1.4.2
SW_GS_Tooltips["SW_ColCountSlider"] = "改變主窗口顯示的列數."; 
SW_GS_Tooltips["SW_SetOptTxtFrame"] = "改變主窗口下按鈕文字.";
SW_GS_Tooltips["SW_SetFrameTxtFrame"] = "改變主窗口標題欄的文字.";
SW_GS_Tooltips["SW_OptChk_Num"] = "顯示數值. (例如.傷害、治療等等.).";
SW_GS_Tooltips["SW_OptChk_Rank"] = "顯示排名序號.";
SW_GS_Tooltips["SW_OptChk_Percent"] = "顯示百分比. (顯示在團隊中的比例.)";
SW_GS_Tooltips["SW_Filter_None"] = "無 PC/NPC/隊伍/團隊 過濾. 所有數據顯示在狀態條";
SW_GS_Tooltips["SW_Filter_PC"] = "玩家角色過濾. 玩家角色在你的隊伍裏或者是你當前目標時有效.";
SW_GS_Tooltips["SW_Filter_NPC"] = "NPC過濾, 你需要選擇一個角色 , 目標不是玩家控制的.";
SW_GS_Tooltips["SW_Filter_Group"] = "僅顯示在你隊伍/團隊中的玩家及寵物.";
SW_GS_Tooltips["SW_Filter_EverGroup"] = "顯示最後一次參加的團隊活動數據."; 
SW_GS_Tooltips["SW_ClassFilterSlider"] = "職業過濾. 僅顯示指定職業的數據. (第一次運行將顯示英文職業名,各職業需要加入過一次你的隊伍/團隊,將顯示本地語言名)";
SW_GS_Tooltips["SW_InfoTypeSlider"] = "設置要顯示哪種數據. (同步)標示表示該數據類型是否支持同步.";
SW_GS_Tooltips["SW_ColorsOptUseClass"] = "使用職業色彩. 使用顔色區分玩家職業. (已知玩家及怪物的職業將代替狀態條的顔色) ";
SW_GS_Tooltips["SW_Chk_ShowDPS"] = "是否顯示DPS到主窗口界面?";
SW_GS_Tooltips["SW_OptCountSlider"] = "改變主窗口下按鍵總數";
SW_GS_Tooltips["SW_AllowARP"] = "允許報告到RAID.";
SW_GS_Tooltips["SW_DisAllowARP"] = "阻止報告到RAID";
SW_GS_Tooltips["SW_OptChk_Running"] = "取消選擇將暫停搜集數據. 選擇上繼續收集數據. 但是你在一個同步頻道裏不能暫停收集數據."; 
-- 1.5 new pet filter Tooltips
SW_GS_Tooltips["SW_PF_Inactive"] = "新的寵物統計已經完成,可以在這裏設置寵物相關信息.";
SW_GS_Tooltips["SW_PF_Active"] = "活動,"..SW_STR_PET_PREFIX.." 控制/奴役幷且顯示在擁有者記錄裏. 僅寵物存在時統計. (控制其他怪物時不會顯示在擁有者上,只會顯示在團隊中)";
SW_GS_Tooltips["SW_PF_MM"] = "隱藏寵物産生的傷害/治療,將其合幷在擁有者上..";
SW_GS_Tooltips["SW_PF_MR"] = "隱藏寵物獲得的傷害/治療,將其合幷在擁有者上.";
SW_GS_Tooltips["SW_PF_MB"] = "隱藏寵物獲得和産生的傷害/治療,將其合幷在擁有者上..";
SW_GS_Tooltips["SW_PF_Current"] = "擁有寵物的才顯示.";
SW_GS_Tooltips["SW_PF_VPP"] = "所有寵物都被合幷在一起.";
SW_GS_Tooltips["SW_PF_VPR"] = "所有團隊寵物都被合幷在一起.";
SW_GS_Tooltips["SW_PF_Ignore"] = "所有寵物信息忽略.";
--1.5.3 new color options
SW_GS_Tooltips["SW_CS_TitleBar"] =  "改變所有的標題欄和按鍵色彩. 可能(修改到設置) 改變主窗口上的按鍵顔色.";
SW_GS_Tooltips["SW_CS_TitleFont"] =  "改變所有傷害/治療條的字體和按鍵的顔色.";
SW_GS_Tooltips["SW_CS_Backdrops"] =  "改變窗口周圍的顔色. 標簽顔色也會改變,但是不改變透明通道.";
SW_GS_Tooltips["SW_CS_MainWinBack"] = "改變主窗格背景色彩.";
SW_GS_Tooltips["SW_CS_ClassCAlpha"] = "僅僅修改被職業色彩使用的透明通道";

SW_GS_Tooltips["SW_Chk_TL_SafeMode"] = "選擇該項, 你將發布你的删除以及合幷時間標記給同步頻道.";
SW_GS_Tooltips["SW_Chk_TL_SingleSelect"] = "選擇該項,産生的數據將在一個合幷的時間段內. 使用重新計算也能得到整個數據.";
SW_GS_Tooltips["SW_HealOpt_Eff"] = "選擇該項,過量治療將被减去.";
SW_GS_Tooltips["SW_HealOpt_OH"] = "選擇該項,將只顯示過量治療.";
SW_GS_Tooltips["SW_HealOpt_IF"] = "選擇該項,將計算戰鬥中的 治療/過量治療";
SW_GS_Tooltips["SW_Chk_TL_AutoZone"] = "選擇該項,進入新的區域將自動創建時間段.";
SW_GS_Tooltips["SW_TL_ReloadUI"] = "執行它避免 \"重復數據\" 建議只有在沒有時間段載入時使用(或你的同步沒有激活時使用)";
SW_GS_Tooltips["SW_AutoVoteYes"] = "選擇該項,所有重置投票你自帶回復是.";
SW_GS_Tooltips["SW_AutoVoteNo"] = "選擇該項,所有重置投票你自帶回復否";
SW_GS_Tooltips["SW_Chk_TL_AutoDelete"] = "如果選擇該項,將自動删除大于"..SW_TL_AUTO_THRESH.."小時的數據.";

-- edit boxes
SW_GS_EditBoxes["SW_SetOptTxtFrame"] = {"更改","按鈕名: ", "新按鈕名:" };
SW_GS_EditBoxes["SW_SetFrameTxtFrame"] = {"更改","標題: ", "新標題:" };
SW_GS_EditBoxes["SW_SetInfoVarTxtFrame"] = {"更改","來源信息: ", "新玩家或NPC名字:" };
SW_GS_EditBoxes["SW_SetSyncChanTxtFrame"] = {"更改","同步頻道: ", "新同步頻道:" };

--popups
StaticPopupDialogs["SW_Mem_Warning"]["text"] = "存儲的歷史數據量過多. 請從時間段中删除過時數據.\r\n (删除按鍵在顯示時間段界面裏)";
StaticPopupDialogs["SW_TL_Delete"]["text"] = "你需要删除這段數據嗎?";
StaticPopupDialogs["SW_TL_Nuke"]["text"] = "你需要删除所有的數據嗎?";
StaticPopupDialogs["SW_TL_Merge"]["text"] = "你需要合幷選擇的數據段嗎?";
StaticPopupDialogs["SW_Reset"]["text"] = "你需要重置數據嗎?";
StaticPopupDialogs["SW_ResetSync"]["text"] = "你正在一個同步頻道,該操作將使所有同步玩家創建新的時間段!你需要這樣做嗎?";
StaticPopupDialogs["SW_ResetFailInfo"]["text"] = "你正在一個同步頻道,無法重置數據,只有隊長/團長才有權利重置,或者使用/sws rv命令投票!";
StaticPopupDialogs["SW_PostFail"]["text"] = "抱歉, 你不能發送到這個頻道. 需要RAID隊長允許你才可以發送數據到該頻道!";
StaticPopupDialogs["SW_InvalidChan"]["text"] = "無效的頻道名.";

-- Minimap Icon Menu strings
SW_MiniIconMenu[2]["textShow"] = "顯示主窗口";
SW_MiniIconMenu[2]["textHide"] = "隱藏主窗口";
SW_MiniIconMenu[3]["textShow"] = "顯示控制臺";
SW_MiniIconMenu[3]["textHide"] = "隱藏控制臺";
SW_MiniIconMenu[4]["textShow"] = "顯示常規設置";
SW_MiniIconMenu[4]["textHide"] = "隱藏常規設置";
SW_MiniIconMenu[5]["textShow"] = "顯示同步設置";
SW_MiniIconMenu[5]["textHide"] = "隱藏同步設置";
SW_MiniIconMenu[6]["textShow"] = "顯示時間段";
SW_MiniIconMenu[6]["textHide"] = "隱藏時間段";
SW_MiniIconMenu[8]["text"] = "重置數據";


-- key bindig strings
BINDING_HEADER_SW_BINDINGS = "數據同步...";
BINDING_NAME_SW_BIND_TOGGLEBARS = "顯示/隱藏主窗口.";
BINDING_NAME_SW_BIND_CONSOLE = "顯示/隱藏控制臺.";
BINDING_NAME_SW_BIND_PAGE1 = "信息欄 1";
BINDING_NAME_SW_BIND_PAGE2 = "信息欄 2";
BINDING_NAME_SW_BIND_PAGE3 = "信息欄 3";
BINDING_NAME_SW_BIND_PAGE4 = "信息欄 4";
BINDING_NAME_SW_BIND_PAGE5 = "信息欄 5";
BINDING_NAME_SW_BIND_PAGE6 = "信息欄 6";
BINDING_NAME_SW_BIND_PAGE7 = "信息欄 7";
BINDING_NAME_SW_BIND_PAGE8 = "信息欄 8";
BINDING_NAME_SW_BIND_PAGE9 = "信息欄 9";
BINDING_NAME_SW_BIND_PAGE10 = "信息欄 10";
BINDING_NAME_SW_BIND_PAGENEXT ="後翻";
BINDING_NAME_SW_BIND_PAGEPREV ="前翻";

--info types
SW_InfoTypes[1]["t"] = "傷害列表 (同步)";
SW_InfoTypes[1]["d"] = "顯示傷害列表.";
SW_InfoTypes[2]["t"] = "治療列表 (同步)";
SW_InfoTypes[2]["d"] = "顯示治療列表. (包括過量治療).";
SW_InfoTypes[3]["t"] = "獲得傷害 (同步)";
SW_InfoTypes[3]["d"] = "顯示受到的傷害列表. (誰受到最多傷害?)";
SW_InfoTypes[4]["t"] = "獲得治療 (同步)";
SW_InfoTypes[4]["d"] = "顯示受到治療的目標. (誰得到最多治療?)";
SW_InfoTypes[5]["t"] = "治療目標 (不同步)";
SW_InfoTypes[5]["d"] = "顯示詳細治療目標信息. (設定的目標治療了誰?)";
SW_InfoTypes[6]["t"] = "治療者 (不同步)";
SW_InfoTypes[6]["d"] = "顯示某人詳細治療者信息. (誰治療了某人?)";
SW_InfoTypes[7]["t"] = "詳情 (不同步)";
SW_InfoTypes[7]["d"] = "詳細的技能信息.(使用了什麽技能?) 括號中的數字表示此技能造成的最大傷害/治療";
SW_InfoTypes[8]["t"] = "詳情/事件 (不同步)";
SW_InfoTypes[8]["d"] = "顯示技能平均信息.(例如玩家使用寒冰箭造成的平均傷害?)後面數字表示技能使用的次數. 注意: 非常大的傷害或非常小的DOT可能帶小數.";
SW_InfoTypes[9]["t"] = "傷害類型 (不同步)";
SW_InfoTypes[9]["d"] = "顯示傷害類型信息. (玩家造成的主要傷害? 例如: 火,冰等等.)";
SW_InfoTypes[10]["t"] = "受到傷害的類型 (不同步)";
SW_InfoTypes[10]["d"] = "顯示受到傷害的類型. (玩家受到傷害的類型? 例如: 火,冰等等.)";
SW_InfoTypes[11]["t"] = "總傷害類型 (不同步)";
SW_InfoTypes[11]["d"] = "顯示傷害類型.(團隊造成的主要傷害類型? 例如: 火,冰 等等.) 注意: 使用職業過濾.";
SW_InfoTypes[12]["t"] = "獲得傷害的類型 (不同步)";
SW_InfoTypes[12]["d"] = "顯示團隊受到的傷害類型.(團隊受到的傷害類型? 例如: 火,冰等等.) 注意: 使用職業過濾.";

SW_InfoTypes[13]["t"] = "技能-魔法 用量(不同步)";
SW_InfoTypes[13]["d"] = "顯示每點魔法産生的傷害和治療總量. 該數據顯示出魔法使用效率 (僅對自己有效).";
SW_InfoTypes[14]["t"] = "死亡次數 (同步)";
SW_InfoTypes[14]["d"] = "哪些人經常死亡? 這個計數統計死亡的次數!";
SW_InfoTypes[15]["t"] = "解除詛咒次數(同步)";
SW_InfoTypes[15]["d"] = "某人解除的詛咒?:"..SW_GetSpellList();
SW_InfoTypes[16]["t"] = "獲得解除詛咒次數 (同步)";
SW_InfoTypes[16]["d"] = "被解除的詛咒?:"..SW_GetSpellList();
SW_InfoTypes[17]["t"] = "有效每秒傷害-DPS (同步)";
SW_InfoTypes[17]["d"] = "可能和個人統計的DPS數值有些不同,因爲采用團隊'進入戰鬥'的計時器(可能成員在團隊裏的某些動作,比如假死)";
SW_InfoTypes[18]["t"] = "每秒受到的傷害(同步)";
SW_InfoTypes[18]["d"] = "這個通常用來檢測團隊給怪物的每秒傷害輸出(使用NPC過濾)";
SW_InfoTypes[19]["t"] = "每秒治療量-HPS(同步)";
SW_InfoTypes[19]["d"] = "像每秒傷害那樣的列表,不過顯示的是治療數據.";
SW_InfoTypes[20]["t"] = "最大一擊列表(不同步)";
SW_InfoTypes[20]["d"] = "顯示每個人最大傷害值列表(最大暴擊列表).";
SW_InfoTypes[21]["t"] = "最大治療列表(不同步)";
SW_InfoTypes[21]["d"] = "顯示每個人最大治療值列表(它不考慮過量治療因素)";
SW_InfoTypes[22]["t"] = "抵抗率統計(不同步)";
SW_InfoTypes[22]["d"] = "顯示對各種傷害類型的抵抗百分比";
SW_InfoTypes[23]["t"] = "對目標的傷害(不同步)";
SW_InfoTypes[23]["d"] = "顯示對選擇目標的傷害(誰對該目標進行了傷害?)";

SW_LocalizedCommands = {
	["help"] = {	["c"] = "?",
					["si"] = "顯示控制臺幫助.",
	},
	["console"] = {["c"] = "con",
				   ["si"] = "打開控制臺",
	},
	["dumpVar"] = {["c"] = "dump",
				   ["si"] = "清除變量",
				   ["u"] = "用法:"..SW_RootSlashes[1].." dump 變量名",
	},
	["reset"] = {	["c"] = "reset",
					["si"] = "創建新的數據段或時間段. 假如你不提供數據段或時間段的名字它將\""..SW_DS_RESET.."\".",
					["u"] = "Usage:"..SW_RootSlashes[1].." reset [名字]",
	},
	["toggleBars"]={["c"] = "bars",
					["si"] = "顯示或隱藏主窗口",
					
	},
	["toggleGS"] = {["c"] = "gs",
					["si"] = "顯示或隱藏常規設置窗口",
	},
	["nukeDS"] ={["c"] = "nuke",
					["si"] = "重置所有同步成員的數據.",
	},
	["resetVote"]={ ["c"] = "rv",
					["si"] = "開始投票來重置某個時間段或數據段的同步.如果你不提供數據段或時間段名字將\""..SW_DS_RESET.."\".",
					["u"] = "Usage:"..SW_RootSlashes[1].." rv [名字]",
	},
}

-- this MUST go at the end of a localization
-- Again if you create a localization put SW_mergeLocalization(); at the end!!!
SW_mergeLocalization();
end