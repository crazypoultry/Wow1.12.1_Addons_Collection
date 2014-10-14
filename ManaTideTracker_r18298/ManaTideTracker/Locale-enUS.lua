local L = AceLibrary("AceLocale-2.2"):new("ManaTideTracker")

L:RegisterTranslations("enUS", function() return {
	["Slash-Commands"] = { "/manatidetracker", "/mtt" },

	["Anchor"] = true,
	["Shows the dragable anchor."] = true,

	["Show Timer Bars"] = true,
	["If set, timer bars will be displayed."] = true,

	["Verbose Bar Text"] = true,
	["If set, timer bar text will contain the name of the spell."] = true,

	["Grow Up"] = true,
	["If set, timer bars will grow up instead of down."] = true,
	
	["ManaTideTracker"] = true,
	
	["mana tide totem"] = true,
	["enamored water spirit"] = true,
	["Mount"] = true,
     
} end)