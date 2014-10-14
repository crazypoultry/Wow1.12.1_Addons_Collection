LVBM.AddOns.Razorgore = {
	["Name"] = LVBM_RG_NAME,
	["Abbreviation1"] = "rg",
	["Abbreviation2"] = "razor",
	["Version"] = "1.0",
	["Author"] = "Tandanu",
	["Description"] = LVBM_RG_DESCRIPTION,
	["Instance"] = LVBM_BWL,
	["GUITab"] = LVBMGUI_TAB_BWL,
	["Sort"] = 1,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
	},
	["Events"] = {
	},	
	["OnCombatStart"] = function(delay)
		LVBM.StartStatusBarTimer(45 - delay, "Add Spawn");
	end,
};
