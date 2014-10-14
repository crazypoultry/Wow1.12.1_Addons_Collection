local L = AceLibrary("AceLocale-2.2"):new("WindFuryFu")

L:RegisterTranslations("enUS", function() return {
	-- Slashcommands
	["SLASHCMD_LONG"] = "/windfuryfu",
	["SLASHCMD_SHORT"] = "/wffu",

	-- Options
	["Tooltip Options"] = true,
	["Set the Tooltip Properties"] = true,

	["Display Options"] = true,
	["Set the Display Properties"] = true,

	["Show Label Text"] = true,
	["Toggle text labels on FuBar"] = true,

	["Reset Scores"] = true,
	["Reset your Windfury scores"] = true,

	["Session"] = true,	
	["Reset your Windfury stats for this session"] = true,

	["Lifetime"] = true,
	["Reset your lifetime Windfury stats"] = true,

	["Show Last WF Hit"] = true,
	["Toggle showing your LAST Windfury hit"] = true,

	["Show Best WF Hit"] = true,
	["Toggle showing your BEST Windfury hit"] = true,
	
	["Show Five Last WF Hits"] = true,
	["Toggle showing the last five Windfury hits in the tooltip"] = true,

	["Show Hint"] = true,

	["Shift-Click to insert your stats into a chat message."] = true,

	["No Weapon Equipped"] = true,

	["WF"] = true,
	["Last"] = true,
	["Best"] = true,
	["Status"] = true,

	["Weapon"] = true,
	["This Session"] = true,

	["Last"] = true,
	["2nd Last"] = true,
	["3rd Last"] = true,
	["4th Last"] = true,
	["5th Last"] = true,

	["Best Single Hit"] = true,
	["Procs"] = true,
	["Crits"] = true,
	["Total WF damage"] = true,
	["Average"] = true,

	["Windfury"] = true,
	["Windfury Totem"] = true,
	["You hit (.+) for (%d+)"] = true,
	["You crit (.+) for (%d+)"] = true,
	["You gain 2 extra attacks through Windfury Weapon"] = true,
} end)