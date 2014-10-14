local Locale = AceLibrary("AceLocale-2.0"):new("ShardAceEngine")

Locale:RegisterTranslations("deDE", function()
	return {
		["Minor"] = "schwach",
		["Lesser"] = "gering",
		["Greater"] = "gro\195\159",
		["Major"] = "erheblich",

		["ShardPouch1"] = "Seelenbeutel", -- 20 slot bag from gadgetzan
		["ShardPouch2"] = "Teufelsstofftasche", -- 24 slot from Scholomance 
		["ShardPouch3"] = "Kernteufelsstofftasche", --Core Felcloth Bag from MC
	}
end)