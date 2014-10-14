--[[ $Id: Locale.zhcn.lua 14413 2006-10-19 16:13:43Z hshh $ ]]--
local L = AceLibrary("AceLocale-2.2"):new("PlayerMenu")

L:RegisterTranslations("zhCN", function()
	return {
		["toggleEnable_desc"] = "启用或禁用 PlayerMenu.",
		["leftButton_desc"] = "启用或禁用鼠标左键菜单",
		["reset_desc"] = "重置所有选项.",
		["order_desc"] = "调整菜单项目的位置和是否可见.",
		["order_usage"] = "<调整>",
		["TEXT_GUILD_INVITE"] = "公会邀请",
		["TEXT_GET_NAME"] = "获取姓名",
		["MSG_PM_ON"] = "PlayerMenu 启用.",
		["MSG_PM_OFF"] = "PlayerMenu 禁用.",
		["MSG_LEFT_ON"] = "左键菜单启用.",
		["MSG_LEFT_OFF"] = "左键菜单禁用.",
		["MSG_RESETED"] = "所有设置已恢复到默认值.",
		["MSG_MENU_ORDER_CHANGED"] = "菜单项目已更改.",
	}
end)
