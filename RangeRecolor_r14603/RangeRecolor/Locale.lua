--[[ $Id: Locale.lua 14438 2006-10-19 22:51:26Z hshh $ ]]--
local L = AceLibrary("AceLocale-2.2"):new("RangeRecolor")
L:RegisterTranslations("enUS", function()
	return {
		["toggleEnable_desc"] = "Toggle RangeRecolor enable or disable.",
		["style_desc"] = "Button re-color style is changed.",
		["custom_desc"] = "Custom color style.",
		["custom_usage"] = "<r=num,g=num,b=num>",
		["reset_desc"] = "Reset all settings to default.",
		["MSG_RR_ON"] = "RangeRecolor enabled.",
		["MSG_RR_OFF"] = "RangeRecolor disabled.",
		["MSG_RESETED"] = "All settings are reseted to default."
	}
end)