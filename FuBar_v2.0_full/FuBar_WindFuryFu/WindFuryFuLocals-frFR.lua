local L = AceLibrary("AceLocale-2.2"):new("WindFuryFu")

L:RegisterTranslations("frFR", function() return {
	-- Slashcommands
	["SLASHCMD_LONG"] = "/windfuryfu",
	["SLASHCMD_SHORT"] = "/wffu",

	-- Options
	["Tooltip Options"] = "Options Tooltip",
	["Set the Tooltip Properties"] = true,

	["Display Options"] = "Afficher les Options",
	["Set the Display Properties"] = true,

	["Show Label Text"] = "Voir les Textes",
	["Toggle text labels on FuBar"] = true,

	["Reset Scores"] = true,
	["Reset your Windfury scores"] = true,

	["Session"] = true,	
	["Reset your Windfury stats for this session"] = true,

	["Lifetime"] = "Toujours",
	["Reset your lifetime Windfury stats"] = true,

	["Show Last WF Hit"] = "Afficher le Dernier WindFury",
	["Toggle showing your LAST Windfury hit"] = true,

	["Show Best WF Hit"] = "Afficher le Meilleur WindFury",
	["Toggle showing your BEST Windfury hit"] = true,
	
	["Show Five Last WF Hits"] = "Afficher les Cinq Derniers WindFury",
	["Toggle showing the last five Windfury hits in the tooltip"] = true,

	["Show Hint"] = true,

	["Shift-Click to insert your stats into a chat message."] = true,

	["No Weapon Equipped"] = true,

	["WF"] = true,
	["Last"] = "Dernier",
	["Best"] = "Meilleur",
	["Status"] = "Etat",

	["Weapon"] = true,
	["This Session"] = "Cette Session",

	["Last"] = "Dernier 1",
	["2nd Last"] = "Dernier 2",
	["3rd Last"] = "Dernier 3",
	["4th Last"] = "Dernier 4",
	["5th Last"] = "Dernier 5",

	["Best Single Hit"] = "Meilleur Coup",
	["Procs"] = "Procs",
	["Crits"] = "Crits",
	["Total WF damage"] = "Dommages Totaux WF",
	["Average"] = "Moyenne",

	["Windfury"] = "Furie%-des%-vents",
	["Windfury Totem"] = "Totem Furie%-des%-vents",
	["You hit (.+) for (%d+)"] = "Vous touchez (.+) et infligez (%d+) points de d\195\169g\195\162ts.",
	["You crit (.+) for (%d+)"] = "Vous infligez un coup critique \195\160 (.+) %((%d+) points de d\195\169g\195\162ts%).",
	["You gain 2 extra attacks through Windfury Weapon"] = "Vous gagnez 2 attaques suppl\195\169mentaires gr\195\162ce \195\160 Attaque Furie%-des%-vents.",
} end)