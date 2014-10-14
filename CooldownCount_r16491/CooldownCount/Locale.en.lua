--[[ $Id: Locale.en.lua 14691 2006-10-21 20:09:52Z damjau $ ]]--

local L = AceLibrary("AceLocale-2.2"):new("CooldownCount")

L:RegisterTranslations("enUS", function()
	return {
		["reset"] = true,
		["Reset all settings."] = true,
		["Reset to default settings."] = true,
		["shine"] = true,
		["Toggle icon shine display after finish cooldown."] = true,
		["shinescale"] = true,
		["Adjust icon shine scale."] = true,
		["font"] = true,
		["Set cooldown value display font."] = true,

		["font size"] = true,
		["Setup cooldown value display font size."] = true,
		["small size"] = true,
		["Small font size for cooldown is longer than 10 minutes."] = true,
		["medium size"] = true,
		["Medium font size for cooldown is longer than 1 minute and less than 10 minutes."] = true,
		["large size"] = true,
		["Large font size for cooldown is longer than 10 seconds and less than 1 minutes."] = true,
		["warning size"] = true,
		["Warning font size for cooldown is less than 10 seconds."] = true,

		["common color"] = true,
		["Setup the common color for value display."] = true,
		["warning color"] = true,
		["Setup the warning color for value display."] = true,

		["d"] = true,
		["h"] = true,
		["m"] = true,

		["Fonts\\FRIZQT__.TTF"] = true,

		["minimum duration"] = true,
		["Minimum duration for display cooldown count."] = true,
		["hide animation"] = true,
		["Hide Bliz origin cooldown animation."] = true,
		["2002"] = true, 
		["FRIZQT__"] = true, 
		["ARIALN"] = true, 
		["K_Damage"] = true, 
		["K_Pagetext"] = true, 
	}
end)
