LVBM.AddOns.Firemaw = {
	["Name"] = LVBM_FIREMAW_NAME,
	["Version"] = "1.0",
	["Author"] = "Tandanu",
	["Description"] = LVBM_FIREMAW_DESCRIPTION,
	["Instance"] = LVBM_BWL,
	["GUITab"] = LVBMGUI_TAB_BWL,
	["Sort"] = 4,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
	},
	["Events"] = {
		["CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE"] = true,
	},	
	["OnCombatStart"] = function(delay)
		LVBM.StartStatusBarTimer(31 - delay, "Wing Buffet");
		LVBM.Schedule(28 - delay, "LVBM.AddOns.Firemaw.OnEvent", "WingBuffetWarning", 3);
	end,
	["OnEvent"] = function(event, arg1)
		if event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" then
			if arg1 == LVBM_FIREMAW_WING_BUFFET then
				LVBM.Announce(string.format(LVBM_WING_BUFFET_WARNING, 1));
				LVBM.StartStatusBarTimer(1, "Wing Buffet Cast");
				LVBM.Schedule(29, "LVBM.AddOns.Firemaw.OnEvent", "WingBuffetWarning", 3);
				LVBM.Schedule(1, "LVBM.AddOns.Firemaw.OnEvent", "WingBuffetWarning", 31);
			elseif arg1 == LVBM_FIREMAW_SHADOW_FLAME then
				LVBM.Announce(LVBM_SHADOW_FLAME_WARNING);
				LVBM.StartStatusBarTimer(2, "Shadow Flame Cast");
			end
		elseif event == "WingBuffetWarning" then
			if arg1 == 3 then
				LVBM.Announce(string.format(LVBM_WING_BUFFET_WARNING, 3));
			elseif arg1 == 31 then
				LVBM.EndStatusBarTimer("Wing Buffet");
				LVBM.StartStatusBarTimer(31, "Wing Buffet");
			end
		end
	end,
};
