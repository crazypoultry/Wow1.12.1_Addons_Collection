local L = AceLibrary("AceLocale-2.2"):new("WindFuryFu")

L:RegisterTranslations("deDE", function() return {
	-- Slashcommands
	["SLASHCMD_LONG"] = "/windfuryfu",
	["SLASHCMD_SHORT"] = "/wffu",

	-- Options
	["Tooltip Options"] = "Tooltip Optionen",
	["Set the Tooltip Properties"] = true,

	["Display Options"] = "Anzeige Optionen",
	["Set the Display Properties"] = true,

	["Show Label Text"] = "Zeige Beschreibung",
	["Toggle text labels on FuBar"] = true,

	["Reset Scores"] = true,
	["Reset your Windfury scores"] = true,

	["Session"] = true,	
	["Reset your Windfury stats for this session"] = true,

	["Lifetime"] = "Insgesamt",
	["Reset your lifetime Windfury stats"] = true,

	["Show Last WF Hit"] = "Zeige Letzten WF",
	["Toggle showing your LAST Windfury hit"] = true,

	["Show Best WF Hit"] = "Zeige Besten WF",
	["Toggle showing your BEST Windfury hit"] = true,
	
	["Show Five Last WF Hits"] = "Zeige die Letzten F\195\188nf WF",
	["Toggle showing the last five Windfury hits in the tooltip"] = true,

	["Show Hint"] = true,

	["Shift-Click to insert your stats into a chat message."] = true,

	["No Weapon Equipped"] = true,

	["WF"] = true,
	["Last"] = "Zuletzt",
	["Best"] = "Bester",
	["Status"] = true,

	["Weapon"] = "Weapon",
	["This Session"] = "Dieses Spiel",

	["Last"] = "Letzter WF",
	["2nd Last"] = "Vorletzter WF",
	["3rd Last"] = "3 Letzter WF",
	["4th Last"] = "4 Letzter WF",
	["5th Last"] = "5 Letzter WF",

	["Best Single Hit"] = "Bester Einzelschlag",
	["Procs"] = "Anzahl WF",
	["Crits"] = "Kritisch",
	["Total WF damage"] = "WF Schaden gesamt",
	["Average"] = "Durchschnitt",

	["Windfury"] = "Windfuror",
	["Windfury Totem"] = "Totem des Windzorns",
	["You hit (.+) for (%d+)"] = "Ihr trefft (.+). Schaden: (%d+)",
	["You crit (.+) for (%d+)"] = "Ihr trefft (.+) kritisch f\195\188r (%d+) Schaden",
	["You gain 2 extra attacks through Windfury Weapon"] = "Ihr (.+) Windfurors",
} end)