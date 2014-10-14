-- [[
-- Traditional Chinese
-- Externalized by: Arith Hsu
-- Original translated and maintained by: Alfred (http://statue.sayya.org/QuestLibrary)
-- Last Updated: 2006/09/01
-- ]]
--------------------------
-- Translatable strings --
--------------------------

if (GetLocale() == "zhTW") then
--
FQ_FORMAT0 = 		"任務名稱";
FQ_FORMAT1 = 		"[任務等級] 任務名稱";
FQ_FORMAT2 =		"[任務等級+] 任務名稱";
FQ_FORMAT3 =		"[任務等級] 任務名稱 (精英)";
--
FQ_EPA_PATTERN1 = 	"^(.+): %s*[-%d]+%s*/%s*[-%d]+%s*$";
FQ_EPA_PATTERN2 = 	"^(.+)\(已完成\)%s$";
FQ_EPA_PATTERN3 = 	"^(.+)完成。$";
FQ_EPA_PATTERN4 = 	"^獲得經驗值: .+$";
FQ_EPA_PATTERN5 = 	"^發現.+$";
FQ_EPA_PATTERN6 = 	"^(.+)\(完成\)%s$";
FQ_EPA_PATTERN7 = 	"^接受任務：.+$";
--
FQ_LOADED = 		"|cff00ffffFastQuest 2.11.3 已載入. 輸入 /fq 以取得更多的設定資訊.";
FQ_INFO =			"|cff00ffff任務追蹤: |r|cffffffff";
--
FQ_INFO_QUEST_TAG =		"顯示任務追蹤視窗困難度: ";
FQ_INFO_AUTOADD = 		"自動添加當前的任務到任務追蹤視窗並移出已完成的任務: ";
FQ_INFO_AUTONOTIFY = 	"自動通知隊友任務進展情況於隊伍頻道中: ";
FQ_INFO_AUTOCOMPLETE = 	"自動完成提交任務: ";
FQ_INFO_ALLOWGUILD = 	"在公會頻道中通知任務進展: ";
FQ_INFO_ALLOWRAID = 	"在團隊頻道中通知任務進展: ";
FQ_INFO_ALWAYSNOTIFY = 	"總是通知任務進展: ";
FQ_INFO_DETAIL =		"詳細的通知任務進展: ";
FQ_INFO_LOCK =			"任務追蹤視窗已|cffff0000鎖定|r|cffffffff";
FQ_INFO_UNLOCK =		"任務追蹤視窗已|cff00ff00解鎖|r|cffffffff";
FQ_INFO_NODRAG =		"移動任務追蹤視窗現在是: ";
FQ_INFO_RESET = 		"重新設定任務追蹤視窗為可移動";
FQ_INFO_FORMAT =		"選擇在聊天框中顯示任務名稱的格式";
FQ_INFO_DISPLAY_AS =	"任務顯示格式: ";
FQ_INFO_CLEAR =			"清除所有任務追蹤視窗中的任務";
FQ_INFO_USAGE = 		"指令 /fastquest [command] 或 /fq [command]";
FQ_INFO_COLOR =			"在任務追蹤視窗依任務難易度以不同的顏色顯示任務標題: ";
--
FQ_MUST_RELOAD =		"你必需輸入 /console reloadui 本功能才可作用";
--
FQ_USAGE_TAG =			"顯示任務追蹤視窗困難度 (菁英, 團隊,等等) ";
FQ_USAGE_LOCK =			"任務追蹤視窗";
FQ_USAGE_NODRAG =		"可否移動任務追蹤視窗, 設定後須打 /console reloadui 才可作用";
FQ_USAGE_AUTOADD =		"添加當前的任務到任務跟蹤欄並移出已完成的任務";
FQ_USAGE_AUTONOTIFY =	"通知隊友任務進展於隊伍頻道中";
FQ_USAGE_AUTOCOMPLETE =	"自動完成提交任務";
FQ_USAGE_ALLOWGUILD =	"在公會頻道中通知任務進展";
FQ_USAGE_ALLOWRAID =	"在團隊頻道中通知任務進展";
FQ_USAGE_ALWAYSNOTIFY =	"通知任務進展於非隊伍頻道";
FQ_USAGE_DETAIL =		"詳細的通知任務進展情況";
FQ_USAGE_RESET =		"重新設定任務追蹤視窗為可移動, 任務追蹤視窗必須設為可移動";
FQ_USAGE_STATUS =		"顯示所有任務追蹤的設定狀態";
FQ_USAGE_CLEAR =		"清除所有任務追蹤視窗中的任務";
FQ_USAGE_FORMAT =		"(按 Ctrl 點選任務) 在聊天框中顯示任務名稱格式共4種每輸入一次切換一種, 如:[10+]任務名稱,[10]任務名稱(精英)";
FQ_USAGE_COLOR =		"設定在任務追蹤視窗中是否依任務難易度以不同的顏色顯示任務標題.";
--
FQ_BINDING_CATEGORY_FASTQUEST		= "任務增強";
FQ_BINDING_HEADER_FASTQUEST			= "快速任務";
FQ_BINDING_NAME_FASTQUEST_T			= "任務追蹤視窗困難度";
FQ_BINDING_NAME_FASTQUEST_F			= "選擇聊天任務名稱格式";
FQ_BINDING_NAME_FASTQUEST_AOUTP		= "自動通知隊友";
FQ_BINDING_NAME_FASTQUEST_AOUTC		= "自動完成提交任務";
FQ_BINDING_NAME_FASTQUEST_AOUTA		= "自動添加任務追蹤視窗";
FQ_BINDING_NAME_FASTQUEST_NOHEADERS	= "任務追蹤視窗解鎖/鎖定";
--
FQ_SELECT_FORMAT =		"選擇顯示聊天任務名稱的格式 (按住 Ctrl 點選任務)";
--
FQ_QUEST_PROGRESS =		"任務進度: ";
--
FQ_QUEST = 				"任務追蹤: ";
FQ_QUEST_ISDONE =		"已完成! ";
FQ_QUEST_COMPLETED =	" (任務完成)";
FQ_DRAG_DISABLED =		"任務追蹤: 移動任務追蹤視窗現在是關閉的, 輸入 /fq nodrag 來設定. 你必須重新載入 UI 來使這改變生效.";
--
FQ_ENABLED =			"|cff00ff00啟動|r|cffffffff";
FQ_DISABLED =			"|cffff0000關閉|r|cffffffff";
FQ_LOCK =				"|cffff0000鎖定|r|cffffffff";
FQ_UNLOCK =				"|cff00ff00解除|r|cffffffff";
--
end

