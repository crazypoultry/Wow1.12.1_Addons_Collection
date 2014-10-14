local AceLocale = AceLibrary("AceLocale-2.2"):new("QuestAnnouncer")

AceLocale:RegisterTranslations("enUS", function()
	return {
		["SLASHCMD_LONG"] = "/questannouncer",
		["SLASHCMD_SHORT"] = "/qa",
		["ADDON_PREFIX"] = "QuestAnnouncer",

		["OPT_SHOWDEBUG_NAME"] = "Debug Mode",
		["OPT_SHOWDEBUG_DESC"] = "Toggle the display of debug information",
		["OPT_SHOWDEBUG_ON"] = "debug mode turned on",
		["OPT_SHOWDEBUG_OFF"] = "debug mode turned off",
		["OPT_ANNOUNCE_NAME"] = "announcement type",
		["OPT_ANNOUNCE_DESC"] = "How an announcement should be send.\naddon - Just party members with this addon gets informed\nchar - Your party would be informed via group chat\nboth - Your party would be informed in both ways\nnone - No information is done",
		["OPT_ANNOUNCE_ADDON"] = "Announcements would be send to your party members with this addon",
		["OPT_ANNOUNCE_CHAT"] = "Announcements would be send to group chat",
		["OPT_ANNOUNCE_BOTH"] = "Announcements would be send to group chat and would be send to your party members with this addon",
		["OPT_ANNOUNCE_BOTH"] = "No annoucements would be done",
		["OPT_DISPLAY_NAME"] = "display type",
		["OPT_DISPLAY_DESC"] = "How announcements of other players with this addon should be displayed.\nui - In the middle of the screen (UIErrorFrame)\nchat - In the chat frame\nboth - In the chat frame and in the middle of the screen\nnone - Don't display them",
		["OPT_DISPLAY_UI"] = "Announcements will be shown in the middle of the screen",
		["OPT_DISPLAY_CHAT"] = "Announcements will be shown in the chat frame",
		["OPT_DISPLAY_BOTH"] = "Announcements will be shown in the chat frame and in the middle of the screen",
		["OPT_DISPLAY_NONE"] = "Announccements won't be displayed",

		["FUBAR_TOOLTIP_HINT"] = "QuestAnnouncer configuration with FuBar",

		["ADVMSG"] = "$NumItems $ItemName of $NumNeeded ($NumLeft left)",
		["FINMSG"] = "$NumItems $ItemName of $NumNeeded (done)",
	}
end)
