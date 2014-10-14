local L = AceLibrary("AceLocale-2.2"):new("ManaPerc")

L:RegisterTranslations("enUS", function() return {
	["COMMANDS"] = { "/manaperc", "/mperc" },
	["TOTAL_DESC"] = "Displays % mana cost based on total mana",
	["CURRENT_DESC"] = "Displays % mana cost based on current mana",
	["COLOUR_DESC"] = "Colour code tooltip info (Green=Current, Yellow=Total)"
	}
end)
