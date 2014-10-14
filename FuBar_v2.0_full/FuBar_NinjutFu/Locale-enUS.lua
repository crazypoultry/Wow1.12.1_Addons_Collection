local L = AceLibrary("AceLocale-2.2"):new("NinjutFu")

L:RegisterTranslations("enUS", function()
    return {
	["PoisonsTS"] = "Poisons", -- Name of the tradeskill
	["Pick Lock"] = true, -- Name of the spell
	["Hint"] = "Click to Lockpick. Ctrl-Click to open Poison crafting.", -- Note that these are flipped from the old versions due to personal preference. If people ask politly I'll add an option for it.

	-- Titles in the Tooltip
	["Powders"] = true,
	["Poisons"] = true,

	-- Item names
	["Flash Powder"] = true,
        ["Blinding Powder"] = true,
	["Thistle Tea"] = true,
	["Crippling Poison"] = true,
	["Crippling Poison II"] = true,
	["Deadly Poison"] = true,
	["Deadly Poison II"] = true,
	["Deadly Poison III"] = true,
	["Deadly Poison IV"] = true,
	["Deadly Poison V"] = true,
	["Instant Poison"] = true,
	["Instant Poison II"] = true,
	["Instant Poison III"] = true,
	["Instant Poison IV"] = true,
	["Instant Poison V"] = true,
	["Instant Poison VI"] = true,
	["Mind-numbing Poison"] = true,
	["Mind-numbing Poison II"] = true,
	["Mind-numbing Poison III"] = true,
	["Wound Poison"] = true,
	["Wound Poison II"] = true,
	["Wound Poison III"] = true,
	["Wound Poison IV"] = true,
	["Rough Sharpening Stone"] = true,
	["Coarse Sharpening Stone"] = true,
	["Heavy Sharpening Stone"] = true,
	["Solid Sharpening Stone"] = true,
	["Dense Sharpening Stone"] = true,
	["Consecrated Sharpening Stone"] = true,
	["Elemental Sharpening Stone"] = true,
	["Rough Weightstone"] = true,
	["Coarse Weightstone"] = true,
	["Heavy Weightstone"] = true,
	["Solid Weightstone"] = true,
	["Dense Weightstone"] = true,

	["Apply %s to MH"] = true, -- %s gets replaced with the specific poison/stone, For example: "Apply Wound Poison IV to MH"
	["Apply %s to OH"] = true,
	["Apply to MH"] = true,
	["Apply to OH"] = true,

	["Options"] = true,
	["OptionsDesc"] = "Options",
	["Text Options"] = true,
	["TextOptsDesc"] = "Configure what to show on the plugin",
	["Tooltip Options"] = true,
	["TooltipOptsDesc"] = "Configure what to show in the tooltip",
	["buyFlash"] = "Refill Flash Powder",
	["buyFlashDesc"] = "Automaticly restock Flash Powder when at a vendor.",
	["threshCount"] = "Flash Powder Amount",
	["threshCountDesc"] = "Prefered amount of Flash Powder.",
	["highend"] = "High-end Mode",
	["highendDesc"] = "Save some memory and CPU-cycles by only scanning for the high-end items.",
	["Show Flash Powder"] = true,
	["ShowFlashDesc"] = "Toggles if the amount of Flash Powder is shown.",
	["Show Blinding Powder"] = true,
	["ShowBlindDesc"] = "Toggles if the amount of Blinding Powder is shown.",
	["Show Thistle Tea"] = true,
	["ShowTeaDesc"] = "Toggles if the amount of Thistle Tea is shown.",
	["Compact Mode"] = true,
	["CompactModeDesc"] = "Toggles compact mode.",
	["Show Titles"] = true,
	["ShowTitlesDesc"] = "Toggles Titles for each category.",
	["Show Powders"] = true,
	["ShowPowdersDesc"] = "Toggles if Powders is shown.",
	["ShowTTeaDesc"] = "Toggles if Thistle Tea is shown.",
	["Show Poisons"] = true,
	["ShowPoisonsDesc"] = "Toggles if Poisons is shown.",
    }
end)
