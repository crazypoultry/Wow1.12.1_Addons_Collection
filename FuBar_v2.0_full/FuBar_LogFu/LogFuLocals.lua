if not ace:LoadTranslation("LogFu") then

LogFuLocals = {
	NAME = "FuBar - LogFu",
	DESCRIPTION = "Allows Enabling/Disabling of Chat and Combat logs.",
	
	DEFAULT_ICON = "Interface\\Icons\\INV_Misc_LuckyMoneyEnvelope",
	
	MENU_COMBATLOG_NAME = "Combat Logging",
	MENU_CHATLOG_NAME = "Chat Logging",
	
	BAR_TEXT_COMBAT = "Combat",
	BAR_TEXT_CHAT = "Chat",
	BAR_TEXT_BOTH = "Both",
	BAR_TEXT_DISABLED = "Disabled",
	
	WINDOW_BOTH_ENABLED = "Both combat and chat logging are enabled. Please see WOWChatLog.txt and WOWCombatLog.txt in the logs directoy",
	WINDOW_BOTH_DISABLED = "All logging disabled",
	WINDOW_COMBAT_ENABLED = "Combat logging is enabled. Please see WOWCombatLog.txt in the logs directoy.",
	WINDOW_COMBAT_DISABLED = "Combat logging is disabled.",
	WINDOW_CHAT_ENABLED = "Chat logging is enabled. Please see WOWChatLog.txt in the logs directoy.",
	WINDOW_CHAT_DISABLED = "Chat logging is disabled.",

	TOOLTIP_LOG_WARNING = "Due to Blizzard design logs are only written on logout or zoning.",
	
	TOOLTIP_CAT_COMBAT = "Combat Log",
	TOOLTIP_CAT_CHAT = "Chat Log",
	
	TOOLTIP_FPATH = "logs",
	TOOLTIP_FNAME_COMBAT = "WOWCombatLog.txt",
	TOOLTIP_FNAME_CHAT = "WOWChatLog.txt",
	
	TOOLTIP_STATE = "State",	
	TOOLTIP_PATH = "Relative Path",
	TOOLTIP_ENABLED = "Enabled",
	TOOLTIP_DISABLED = "Disabled",
	
	
	ENDLOCALE = true
}

end
