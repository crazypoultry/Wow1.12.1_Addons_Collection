local AceLocale = AceLibrary("AceLocale-2.2"):new("QuestAnnouncer")

AceLocale:RegisterTranslations("zhCN", function()
	return {
		["SLASHCMD_LONG"] = "/questannouncer",
		["SLASHCMD_SHORT"] = "/qa",
		["ADDON_PREFIX"] = "QuestAnnouncer",

		["OPT_SHOWDEBUG_NAME"] = "Debug 模式",
		["OPT_SHOWDEBUG_DESC"] = "切换显示 Debug 信息",
		["OPT_SHOWDEBUG_ON"] = "打开 Debug 模式",
		["OPT_SHOWDEBUG_OFF"] = "关闭 Debug 模式",
		["OPT_ANNOUNCE_NAME"] = "通告类型",
		["OPT_ANNOUNCE_DESC"] = "任务通告发送形式：\naddon - 仅加载此插件的队友取得\nchar - 通过小队频道发送通告t\nboth - 以两种形式同时发送\nnone - 不发送通告",
		["OPT_ANNOUNCE_ADDON"] = "在插件频道发布任务通告",
		["OPT_ANNOUNCE_CHAT"] = "在队伍频道发布任务通告",
		["OPT_ANNOUNCE_BOTH"] = "在插件频道和队伍频道同时发布任务通告",
		["OPT_ANNOUNCE_BOTH"] = "无通告发表",
		["OPT_DISPLAY_NAME"] = "显示类型",
		["OPT_DISPLAY_DESC"] = "设置加载此插件的队友显示任务通告形式:\nUI - 屏幕中央 (UI 错误框)\nchat - 聊天窗口\nboth - 屏幕中央与聊天窗口同时显示\nnone - 不显示",
		["OPT_DISPLAY_UI"] = "在屏幕中央显示通告",
		["OPT_DISPLAY_CHAT"] = "在聊天窗口显示通告",
		["OPT_DISPLAY_BOTH"] = "同时在屏幕中央和聊天窗口显示通告",
		["OPT_DISPLAY_NONE"] = "不显示任务通告",

		["FUBAR_TOOLTIP_HINT"] = "用 Fubar 设置任务通告",

		["ADVMSG"] = "$NumItems $ItemName 于 $NumNeeded (剩余 $NumLeft)",
		["FINMSG"] = "$NumItems $ItemName 于 $NumNeeded (已完成)",
	}
end)
