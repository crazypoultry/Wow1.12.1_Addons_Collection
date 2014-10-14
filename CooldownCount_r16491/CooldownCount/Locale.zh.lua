--[[ $Id: Locale.zh.lua 14604 2006-10-21 07:13:16Z hshh $ ]]--

local L = AceLibrary("AceLocale-2.2"):new("CooldownCount")

L:RegisterTranslations("zhCN", function()
	return {
		["Reset all settings."] = "重置设置.",
		["Reset to default settings."] = "已重置到默认设置.",
		["Toggle icon shine display after finish cooldown."] = "设置冷却完毕后图标闪烁提示.",
		["Adjust icon shine scale."] = "设置图标闪烁的大小.",
		["Set cooldown value display font."] = "设置冷却数字字体.",

		["Setup cooldown value display font size."] = "设置冷却显示的字体大小.",
		["Small font size for cooldown is longer than 10 minutes."] = "设置大于10分钟的冷却显示的字体大小.",
		["Medium font size for cooldown is longer than 1 minute and less than 10 minutes."] = "设置1~10分钟的冷却显示的字体大小.",
		["Large font size for cooldown is longer than 10 seconds and less than 1 minutes."] = "设置10秒~1分钟的冷却显示的字体大小.",
		["Warning font size for cooldown is less than 10 seconds."] = "设置小于10秒的冷却显示的字体大小.",

		["Setup the common color for value display."] = "设置冷却显示字体的普通颜色.",
		["Setup the warning color for value display."] = "设置冷却显示字体的警告颜色.",

		["Minimum duration for display cooldown count."] = "设置显示倒计时需要的最小冷却时间.",
		["Hide Bliz origin cooldown animation."] = "隐藏暴雪原有的冷却动画."
	}
end)
