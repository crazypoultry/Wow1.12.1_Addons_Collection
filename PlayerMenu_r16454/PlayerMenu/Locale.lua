--[[ $Id: Locale.lua 14413 2006-10-19 16:13:43Z hshh $ ]]--
local L = AceLibrary("AceLocale-2.2"):new("PlayerMenu")

L:RegisterTranslations("enUS", function()
	return {
		["toggleEnable_desc"] = "Toggle PlayerMenu enable or disable.",
		["leftButton_desc"] = "Toggle left button to active menu enable or disable.",
		["reset_desc"] = "Reset ALL settings.",
		["order_desc"] = "Change menu item's order and visable.",
		["order_usage"] = "<menu orders>",
		["TEXT_GUILD_INVITE"] = "Guild Invite",
		["TEXT_GET_NAME"] = "Get Name",
		["MSG_PM_ON"] = "PlayerMenu enabled.",
		["MSG_PM_OFF"] = "PlayerMenu disabled.",
		["MSG_LEFT_ON"] = "Left button menu enabled.",
		["MSG_LEFT_OFF"] = "Left button menu disabled.",
		["MSG_RESETED"] = "All settings are reseted to default.",
		["MSG_MENU_ORDER_CHANGED"] = "Menu Order Changed.",
	}
end)