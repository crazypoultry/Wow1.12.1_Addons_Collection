local Locale = AceLibrary("AceLocale-2.0"):new("ShardAceEngine")

Locale:RegisterTranslations("enUS", function()
	return {
		["Minor"] = "Minor",
		["Lesser"] = "Lesser",
		["Greater"] = "Greater",
		["Major"] = "Major",
		
		["ShardPouch1"] = "Soul Pouch", -- 20 slot bag from gadgetzan
		["ShardPouch2"] = "Felcloth Bag", -- 24 slot from Scholomance 
		["ShardPouch3"] = "Core Felcloth Bag", --Core Felcloth Bag from MC
	}
end)