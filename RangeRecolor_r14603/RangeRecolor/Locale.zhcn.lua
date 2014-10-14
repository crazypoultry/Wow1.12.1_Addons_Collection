--[[ $Id: Locale.zhcn.lua 14438 2006-10-19 22:51:26Z hshh $ ]]--
local L = AceLibrary("AceLocale-2.2"):new("RangeRecolor")
L:RegisterTranslations("zhCN", function()
	return {
		["toggleEnable_desc"] = "切换 RangeRecolor 启用或禁用.",
		["style_desc"] = "按钮颜色配色更改.",
		["custom_desc"] = "默认配色.",
		["custom_usage"] = "<r=num,g=num,b=num>",
		["reset_desc"] = "重置所有选项为默认值.",
		["MSG_RR_ON"] = "RangeRecolor 启用.",
		["MSG_RR_OFF"] = "RangeRecolor 禁用.",
		["MSG_RESETED"] = "所有选项已经重置为默认值."
	}
end)