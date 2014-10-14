local AceLocale = AceLibrary("AceLocale-2.1")

AceLocale:RegisterTranslation("FuBar_FromAViewToAKillFu", "enUS", function()
	return {
		["youleader"]		= "You are the leader of a raid.",
		["younotinraid"]	= "You are not in a raid.",
		["funcenabled"]		= "Functions enabled.",
		["funcdisabled"]	= "Functions disabled",
		["younotleader"]	= "You are not the raid's leader.",
		["RMBclick"]		= "Rightclick",
		["access"]			= " to access the RaidTargetIcon list.",
		["CtrlLMBclick"]	= "Crtl-Leftclick",
		["clear"]			= " to clear the list.",
		
		["unassigned"]		= "... not assigned",
		
		["noRTIsset"]		= "No dynamic RTIs set.",
		["listcleared"]		= "List cleared.",
		["unit"]			= "Unit ",
		["hasnoRaidID"]		= " does not have a RaidID.",
	}
end)