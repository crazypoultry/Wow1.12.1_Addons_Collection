--[[ $Id: Locale.lua 13336 2006-10-08 10:22:16Z hshh $ ]]--
local L = AceLibrary("AceLocale-2.1")

L:RegisterTranslation("PartyQuestComm", "enUS", function()
	return {
		["COMPLETED"]	= "Completed",
		["FAILED"]		= TEXT(FAILED),

		["Display Quest Progess Info in UIErrorsFrame."] = true,
		["UIErrorsFrame Display Enabled."] = true,
		["UIErrorsFrame Display Disabled."]	= true,

		["Display Quest Progess Info in ChatFrame."] = true,
		["ChatFrame Display Enabled."] = true,
		["ChatFrame Display Disabled."] = true,

		["Reset ALL settings to default."] = true,
		["ALL settings have been reset to default."] = true,

		["Show PartyQuest GUI."] = true,

		["BINDING_HEADER_PARTYQUESTCOMM"] = "PartyQuestComm",
		["BINDING_NAME_PARTYQUESTCOMMGUI"] = "PartyQuestComm Logs",
		["log_detail"] = "Player: %s\nDate: %s\n\nDetail:\n%s",
		["Money Requirement: "] = true,
		["Time Left: "] = true,
		["display_log"] = "PartyQuest Log",
		["choose_action"] = "Choose Action",
		["clean_log"] = "Clean Logs",
		["update_all"] = "Update all PartyQuest",
		["update_single_all"] = "Update player PartyQuest",
		["update_single"] = "Update selected PartyQuest",
		["sync_single"] = "Sync player quest list",
		["Right Click to update this quest detail."] = true,
		["PartyQuestCommFrame_UpdateAllButton_OnEnter"] = "Update all party member quest log.",
		["PartyQuestCommFrame_UpdateButton_OnEnter"] = "Update only this player quest log.",
		["PartyQuestCommFrame_SyncButton_OnEnter"] = "Sync this player quest list (only difference).",
	}
end)

L:RegisterTranslation("PartyQuestComm", "zhCN", function()
	return {
		["COMPLETED"]	= TEXT(COMPLETE),
		["FAILED"]		= TEXT(FAILED),

		["Display Quest Progess Info in UIErrorsFrame."] = "在主屏幕显示任务进度.",
		["UIErrorsFrame Display Enabled."] = "主屏幕信息显示开启.",
		["UIErrorsFrame Display Disabled."] = "主屏幕信息显示关闭.",

		["Display Quest Progess Info in ChatFrame."] = "在聊天信息框显示任务进度.",
		["ChatFrame Display Enabled."] = "聊天信息框显示开启.",
		["ChatFrame Display Disabled."] = "聊天信息框显示关闭.",

		["Reset ALL settings to default."] = "重置所有选项为默认值.",
		["ALL settings have been reset to default."] = "所有选项已经重置为默认值.",

		["Show PartyQuest GUI."] = "显示 PartyQuest 日志界面.",

		["BINDING_HEADER_PARTYQUESTCOMM"] = "PartyQuestComm",
		["BINDING_NAME_PARTYQUESTCOMMGUI"] = "PartyQuestComm日志",
		["log_detail"] = "玩家: %s\n日期: %s\n\n详情:\n%s",
		["Money Requirement: "] = "金钱需求: ",
		["Time Left: "] = "时间剩余: ",
		["display_log"] = "队友任务记录",
		["choose_action"] = "操作选项",
		["clean_log"] = "清除日志",
		["update_all"] = "获取所有队员任务",
		["update_single_all"] = "获取该队友任务",
		["update_single"] = "获取该队友所选任务",
		["sync_single"] = "同步该队友任务列表",
		["Right Click to update this quest detail."] = "右键点击更新该任务详情.",
		["PartyQuestCommFrame_UpdateAllButton_OnEnter"] = "获取所有队员任务记录.",
		["PartyQuestCommFrame_UpdateButton_OnEnter"] = "获取该队友所有任务记录.",
		["PartyQuestCommFrame_SyncButton_OnEnter"] = "同步该队友任务列表 (只同步与当前有差别的).",
	}
end)
