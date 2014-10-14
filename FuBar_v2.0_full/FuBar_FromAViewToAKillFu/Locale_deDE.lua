local AceLocale = AceLibrary("AceLocale-2.1")

AceLocale:RegisterTranslation("FuBar_FromAViewToAKillFu", "deDE", function()
	return {
		["youleader"]		= "Du bist Raidleiter.",
		["younotinraid"]	= "Du bist in keinem Raid.",
		["funcenabled"]		= "Funktionen aktiviert.",
		["funcdisabled"]	= "Funktionen deaktiviert.",
		["younotleader"]	= "Du bist nicht der Raidleiter.",
		["RMBclick"]		= "Rechtsklick",
		["access"]			= " um die RaidTargetIcon-Liste zu bearbeiten.",
		["CtrlLMBclick"]	= "Strg-Linksklick",
		["clear"]			= " um die Liste zu löschen.",
		
		["unassigned"]		= "... nicht zugewiesen",
		
		["noRTIsset"]		= "Es sind keine dynamischen RTIs gesetzt.",
		["listcleared"]		= "Liste gelöscht.",
		["unit"]			= "Einheit ",
		["hasnoRaidID"]		= " hat keine RaidID.",
	}
end)