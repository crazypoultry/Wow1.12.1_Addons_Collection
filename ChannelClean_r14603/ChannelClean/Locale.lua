--[[ $Id: Locale.lua 14413 2006-10-19 16:13:43Z hshh $ ]]--
local L = AceLibrary("AceLocale-2.2"):new("ChannelClean")

L:RegisterTranslations("enUS", function()
	return {
		["Converted old message block lists."] = true,
		["Converted old player block lists."] = true,

		["Reset all settings. Clear all block rules."] = true,
		["Reset to default settings, all block rules are cleared."] = true,

		["Bypass messages send by self."] = true,

		["Toggle blocked notice enabled or disabled."] = true,
		["Blocked notice is enabled."] = true,
		["Blocked notice is disabled."] = true,

		["Setting channel monitor lists."] = true,
		["Toggle block chat channel messages."] = true,
		["Toggle block say messages."] = true,
		["Toggle block whisper messages."] = true,
		["Toggle block yell messages."] = true,
		["Toggle block guild messages."] = true,
		["Toggle block party messages."] = true,
		["Toggle block raid messages."] = true,
		["Toggle block raid leader messages."] = true,
		["Toggle block battleground messages."] = true,
		["Toggle block battleground leader messages."] = true,
		["Toggle block system messages."] = true,

		["Add a new rule set."] = true,
		["Add a message block rule."] = true,
		["Add a player block rule."] = true,
		["Add a trigger block rule."] = true,

		["Delete a exist rule set."] = true,
		["Delete a message block rule."] = true,
		["Delete a player block rule."] = true,
		["Delete a trigger block rule."] = true,

		["Clear a group rule sets."] = true,
		["Clear message block rules."] = true,
		["Clear player block rules."] = true,
		["Clear trigger block rules."] = true,
		["Clear trigger blocked players."] = true,
		["RuleClearedFormat"] = "%s block rules are cleared.",

		["List a group rule sets."] = true,
		["List message block rules."] = true,
		["List player block rules."] = true,
		["List trigger block rules."] = true,
		["List trigger blocked players."] = true,
		["List all block rules."] = true,
		["ListFormat"] = "%s block rules:",
		["ListRulesFormat"] = "#%d: %s",

		["RuleAddedFormat"] = "%s block rule added: %s",
		["RuleDeletedFormat"] = "%s block rule deleted: %s",
		["RuleDeleteNotFoundFormat"] = "%s block rule you want to delete is not found: %s",
		["RuleGroup_message"] = "Message",
		["RuleGroup_player"] = "Player",
		["RuleGroup_trigger"] = "Trigger",
		["RuleGroup_trigger_session"] = "Session Trigger",

		["Change message block trigger mode."] = true,
		["Rule is already exist."] = true,

		["NOTICE_message"] = "Message block: %s (#%d)",
		["NOTICE_player"] = "Player block: %s (#%d)",
		["NOTICE_trigger"] = "Message trigger: %s (#%d)",
		["NOTICE_trigger_temp"] = "Player block by trigger: %s",
		["NOTICE_rate"] = "Fluch block: %s",

		["Setup speak rate control."] = true,
		["Toggle speak rate control."] = true,
		["Speak rate control only process Channel message."] = true,
		["Speak rate control for same sender with same message."] = true,
		["Speak rate control time interval."] = true,
		["Setup temp db clean interval."] = true,
		["Setup notice interval for same sender."] = true,

		["DEFAULT_RULES_MESSAGE"] = {},
		["DEFAULT_RULES_TRIGGER"] = {},
	}
end)

L:RegisterTranslations("zhCN", function()
	return {
		["Converted old message block lists."] = "已升级旧的内容过滤列表.",
		["Converted old player block lists."] = "已升级旧的玩家过滤列表.",

		["Reset all settings. Clear all block rules."] = "重置所有设置. 清除所有过滤规则.",
		["Reset to default settings, all block rules are cleared."] = "设置已重置, 过滤规则已清除.",

		["Bypass messages send by self."] = "不过滤自己发出的信息.",

		["Toggle blocked notice enabled or disabled."] = "设置是否开启显示已禁止内容提示.",
		["Blocked notice is enabled."] = "显示已禁止内容提示.",
		["Blocked notice is disabled."] = "不显示已禁止内容提示.",

		["Setting channel monitor lists."] = "设置内容过滤范围(频道).",
		["Toggle block chat channel messages."] = "设置是否过滤频道聊天内容.",
		["Toggle block say messages."] = "设置是否过滤普通闲聊内容.",
		["Toggle block whisper messages."] = "设置是否过滤悄悄话内容.",
		["Toggle block yell messages."] = "设置是否过滤叫喊内容.",
		["Toggle block guild messages."] = "设置是否过滤公会聊天内容.",
		["Toggle block party messages."] = "设置是否过滤队伍聊天内容.",
		["Toggle block raid messages."] = "设置是否过滤团队聊天内容.",
		["Toggle block system messages."] = "设置是否过滤系统信息内容.",
		["Toggle block raid leader messages."] = "设置是否过滤团队领袖聊天内容.",
		["Toggle block battleground messages."] = "设置是否过滤战场聊天内容.",
		["Toggle block battleground leader messages."] = "设置是否过滤战场领袖聊天内容.",

		["Add a new rule set."] = "增加一条新的过滤规则.",
		["Add a message block rule."] = "增加一条新的内容过滤规则.",
		["Add a player block rule."] = "增加一条新的玩家过滤规则.",
		["Add a trigger block rule."] = "增加一条新的触发器过滤规则.",

		["Delete a exist rule set."] = "删除一条过滤规则.",
		["Delete a message block rule."] = "删除一条内容过滤规则.",
		["Delete a player block rule."] = "删除一条玩家过滤规则.",
		["Delete a trigger block rule."] = "删除一条触发器过滤规则.",

		["Clear a group rule sets."] = "清除一组过滤规则.",
		["Clear message block rules."] = "清除所有内容过滤规则.",
		["Clear player block rules."] = "清除所有玩家过滤规则.",
		["Clear trigger block rules."] = "清除所有触发器过滤规则.",
		["Clear trigger blocked players."] = "清除所有由触发器自动过滤的玩家列表.",
		["RuleClearedFormat"] = "所有 %s 过滤规则已清除.",

		["List a group rule sets."] = "列出一组过滤规则.",
		["List message block rules."] = "列出所有内容过滤规则.",
		["List player block rules."] = "列出所有玩家过滤规则.",
		["List trigger block rules."] = "列出所有触发器过滤规则.",
		["List trigger blocked players."] = "列出所有由触发器自动过滤的玩家列表.",
		["List all block rules."] = "列出所有过滤规则和临时自动过滤玩家列表.",
		["ListFormat"] = "%s 过滤规则:",
		["ListRulesFormat"] = "#%d: %s",

		["RuleAddedFormat"] = "%s 过滤规则已添加: %s",
		["RuleDeletedFormat"] = "%s 过滤规则已删除: %s",
		["RuleDeleteNotFoundFormat"] = "你要删除的 %s 过滤规则没有找到: %s",
		["RuleGroup_message"] = "内容",
		["RuleGroup_player"] = "玩家",
		["RuleGroup_trigger"] = "触发器",
		["RuleGroup_trigger_session"] = "临时列表",

		["Change message block trigger mode."] = "更改内容触发器禁止模式.",
		["Rule is already exist."] = "规则已存在.",

		["NOTICE_message"] = "内容过滤: %s (#%d)",
		["NOTICE_player"] = "玩家过滤: %s (#%d)",
		["NOTICE_trigger"] = "内容触发器: %s (#%d)",
		["NOTICE_trigger_temp"] = "触发器自动过滤玩家: %s",
		["NOTICE_rate"] = "刷屏过滤: %s",

		["Setup speak rate control."] = "刷屏控制.",
		["Toggle speak rate control."] = "开关刷屏控制.",
		["Speak rate control only process Channel message."] = "只对普通频道内容过滤.",
		["Speak rate control for same sender with same message."] = "只对同一发言者的相同内容过滤",
		["Speak rate control time interval."] = "刷屏过滤间隔.",
		["Setup temp db clean interval."] = "临时数据清理.",
		["Setup notice interval for same sender."] = "设置对同一个玩家过滤提示间隔.",

		["DEFAULT_RULES_MESSAGE"] = {},
		["DEFAULT_RULES_TRIGGER"] = {"★","☆","●","◆","■"},
	}
end)