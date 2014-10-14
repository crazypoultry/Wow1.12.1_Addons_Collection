local Locale = AceLibrary("AceLocale-2.0"):new("ShardAceEngine")

Locale:RegisterTranslations("frFR", function()
	return {
		["Minor"] = "mineure",
		["Lesser"] = "inf\195\169rieure",
		["Greater"] = "sup\195\169rieure",
		["Major"] = "majeure",
		
		["ShardPouch1"] = "Bourse d'\195\162me", -- 20 slot bag from gadgetzan
		["ShardPouch2"] = "Sac en gangr\195\169toffe", -- 24 slot from Scholomance 
		["ShardPouch3"] = "Sac en gangr\195\169toffe du Magma", --Core Felcloth Bag from MC
	}
end)