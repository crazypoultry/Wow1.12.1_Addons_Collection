LVBM.AddOns.Ragnaros = { 
	["Name"] = LVBM_RAGNAROS_NAME,
	["Abbreviation1"] = "Ragna",
	["Abbreviation1"] = "Rag",
	["Version"] = "1.0",
	["Author"] = "La Vendetta|Nitram",
	["Description"] = LVBM_RAGNAROS_INFO,
	["Instance"] = LVBM_MC,
	["GUITab"] = LVBMGUI_TAB_MC,
	["Sort"] = 10,
	["Options"] = {  
		["Enabled"] = true,
		["Announce"] = false,
	},
	["InCombat"] = false,
	["Submerged"] = false,
	["Events"] = {
		["CHAT_MSG_MONSTER_YELL"] = true,
	},
	["OnCombatStart"] = function(delay)
		LVBM.AddOns.Ragnaros.Submerged = false;
		LVBM.Announce(LVBM_RAGNAROS_EMERGED);
		LVBM.Schedule(60 - delay, "LVBM.AddOns.Ragnaros.OnEvent", "SubmergeWarning", 120);
		LVBM.Schedule(120 - delay, "LVBM.AddOns.Ragnaros.OnEvent", "SubmergeWarning", 60);
		LVBM.Schedule(150 - delay, "LVBM.AddOns.Ragnaros.OnEvent", "SubmergeWarning", 30);
		LVBM.Schedule(165 - delay, "LVBM.AddOns.Ragnaros.OnEvent", "SubmergeWarning", 15);
		LVBM.StartStatusBarTimer(180 - delay, "Submerge");
	end,
	["OnCombatEnd"] = function()
		LVBM.AddOns.Ragnaros.Submerged = false;
	end,
	["OnEvent"] = function(event, arg1) 
		if ( event == "CHAT_MSG_MONSTER_YELL" ) then
			if ( arg1 == LVBM_RAGNAROS_WRATH ) then
				LVBM.Announce(LVBM_RAGNAROS_WRATH_WARN1);
				LVBM.EndStatusBarTimer("Wrath of Ragnaros");
				LVBM.StartStatusBarTimer(30, "Wrath of Ragnaros");
				LVBM.Schedule(25, "LVBM.AddOns.Ragnaros.OnEvent", "WrathWarning", 5);
			elseif ( arg1 == LVBM_RAGNAROS_SUBMERGE ) then
				LVBM.AddOns.Ragnaros.Submerged = true;
				LVBM.UnSchedule("LVBM.AddOns.Ragnaros.OnEvent", "WrathWarning", 5);
				LVBM.EndStatusBarTimer("Wrath of Ragnaros");
				LVBM.EndStatusBarTimer("Submerge");
				LVBM.StartStatusBarTimer(90, "Emerge");
				LVBM.Schedule(30, "LVBM.AddOns.Ragnaros.OnEvent", "EmergeWarning", 60);
				LVBM.Schedule(60, "LVBM.AddOns.Ragnaros.OnEvent", "EmergeWarning", 30);
				LVBM.Schedule(75, "LVBM.AddOns.Ragnaros.OnEvent", "EmergeWarning", 15);
			end
			if ( arg1 ~= LVBM_RAGNAROS_SUBMERGE ) and ( arg2 == LVBM_RAGNAROS_NAME ) and ( LVBM.AddOns.Ragnaros.Submerged ) then
				LVBM.AddOns.Ragnaros.OnEvent("Emerge");
			end
		elseif ( event == "Emerge" ) then
			LVBM.UnSchedule("LVBM.AddOns.Ragnaros.OnEvent", "Emerge");
			LVBM.UnSchedule("LVBM.AddOns.Ragnaros.OnEvent", "EmergeWarning", 60);
			LVBM.UnSchedule("LVBM.AddOns.Ragnaros.OnEvent", "EmergeWarning", 30);
			LVBM.UnSchedule("LVBM.AddOns.Ragnaros.OnEvent", "EmergeWarning", 15);
			LVBM.AddOns.Ragnaros.Submerged = false;
			LVBM.EndStatusBarTimer("Emerge");
			LVBM.Announce(LVBM_RAGNAROS_EMERGED);
			LVBM.Schedule(60, "LVBM.AddOns.Ragnaros.OnEvent", "SubmergeWarning", 120);
			LVBM.Schedule(120, "LVBM.AddOns.Ragnaros.OnEvent", "SubmergeWarning", 60);
			LVBM.Schedule(150, "LVBM.AddOns.Ragnaros.OnEvent", "SubmergeWarning", 30);
			LVBM.Schedule(165, "LVBM.AddOns.Ragnaros.OnEvent", "SubmergeWarning", 15);
			LVBM.StartStatusBarTimer(180, "Submerge");
		elseif ( event == "WrathWarning" ) then
			if arg1 then
				LVBM.Announce(string.format(LVBM_RAGNAROS_WRATH_WARN2, arg1));
			end
		elseif ( event == "SubmergeWarning" ) then
			if type(arg1) == "number" then
				if arg1 > 60 then
					LVBM.Announce(string.format(LVBM_RAGNAROS_SUBMERGE_WARN, arg1/60, LVBM_MINUTES))
				elseif arg1 == 60 then
					LVBM.Announce(string.format(LVBM_RAGNAROS_SUBMERGE_WARN, arg1/60, LVBM_MINUTE))
				else
					LVBM.Announce(string.format(LVBM_RAGNAROS_SUBMERGE_WARN, arg1, LVBM_SECONDS))
				end
			end
		elseif ( event == "EmergeWarning" ) then
			if type(arg1) == "number" then
				if arg1 > 60 then
					LVBM.Announce(string.format(LVBM_RAGNAROS_EMERGE_WARN, arg1/60, LVBM_MINUTES))
				elseif arg1 == 60 then
					LVBM.Announce(string.format(LVBM_RAGNAROS_EMERGE_WARN, arg1/60, LVBM_MINUTE))
				else
					LVBM.Announce(string.format(LVBM_RAGNAROS_EMERGE_WARN, arg1, LVBM_SECONDS))
				end
			end
		end
	end,
};
