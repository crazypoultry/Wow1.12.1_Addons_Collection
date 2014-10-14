local L = AceLibrary("AceLocale-2.0"):new("Caterer")
L:RegisterTranslations("enUS", function()

	return {
				--Classes (When you localize make sure it's still caps)
				["WARLOCK"] = true,
				["WARRIOR"] = true,
				["PRIEST"] = true,
				["ROGUE"] = true,
				["HUNTER"] = true,		
				["PALADIN"] = true,				
				["DRUID"] = true,
				["MAGE"] = true,
				["SHAMAN"] = true,

				--Options
        ["add"] = true,
        ["Add an entry to the caterer list. (Usage /caterer add <name> [Item Link] #)"] = true,
        ["<name/class> [Item Link] <number of items>"] = true,

        ["options"] = true,
        ["Change or view the options. (Usage /caterer option |cffff9966show|r|group||raid|guild|anyone)"] = true,
        ["|cffff9966show|r|group||raid|guild|anyone"] = true,
        
        --Command Line
        ["/caterer"] = true,
        ["/cater"] = true,

				--Misc
        ["On"] = true,
        ["Off"] = true,				
        ["In development"] = true,

				--Errors        
        ["|cffff9966Data mismatch between item and count for |r"] = true,
        ["|cffff9966Unable to load item data for |r"] = true,
        ["|cffff9966Unable to load count data for |r"] = true,
        ["|cffff9966Ran out of space in trade window!|r"] = true,
        ["|cffff9966Had a problem picking things up!|r"] = true,
        ["|cffff9966Unable to trade: Not enough |r"] = true,
        ["|cffff9966Unable to parse %s. Please try again.|r"] = true,
        ["I can't complete the trade right now. I'm out of "] = true,
        
        --Options Handlers
        ["Adding %s: %s-(%s) x%s"] = true,
        ["Unable to add entry."] = true,
        [" (bad number)"] = true,
        [" (bad target)"] = true,
        [" (bad item)"] = true,
				["show"] = true,
				["group"] = true,
				["raid"] = true,
				["guild"] = true,				
				["anyone"] = true,				
				["Trade with anyone: "] = true,
				["Trade with group/raid: "] = true,
				["Trade with guild: "] = true,
				["Trade with friends: "] = true,
				["Trade blacklist time: "] = true,
				["Setting trade with group/raid to: "] = true,
				["Setting trade with group/raid to: "] = true,
				["Setting trade with guild to: "] = true,
				["Setting trade with anyone to: "] = true,

    }
end)