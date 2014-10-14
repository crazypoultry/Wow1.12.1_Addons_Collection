LVBM.AddOns.Fankriss = {
	["Name"] = LVBM_FANKRISS_NAME,
	["Abbreviation1"] = "FANKRISS",
	["Version"] = "1.5",
	["Author"] = "Tandanu",
	["Description"] = LVBM_FANKRISS_DESCRIPTION,
	["Instance"] = LVBM_AQ40,
	["GUITab"] = LVBMGUI_TAB_AQ40,
	["Sort"] = 4,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
	},	
	["Events"] = {
		["CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF"] = true,
	},	

	["OnEvent"] = function(event, arg1)
		if (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF") then
			if arg1 == LVBM_FANKRISS_WORM_SPAWNED then
				LVBM.Announce(LVBM_FANKRISS_SPAWN_WARNING);
			end
		end
	end,
};
