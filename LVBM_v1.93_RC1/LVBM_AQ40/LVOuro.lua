LVBM.AddOns.Ouro = {
	["Name"] = LVBM_OURO_NAME,
	["Abbreviation1"] = "ouru",
	["Version"] = "1.1",
	["Author"] = "Tandanu",
	["Description"] = LVBM_OURO_DESCRIPTION,
	["Instance"] = LVBM_AQ40,
	["GUITab"] = LVBMGUI_TAB_AQ40,
	["Sort"] = 8,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
	},	
	["Events"] = {
		["CHAT_MSG_MONSTER_EMOTE"] = true,
		["CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE"] = true,
		["CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF"] = true,
	},
	["Submerged"] = false,
	["Enraged"] = false,
	["InCombat"] = false,
	["OnCombatStart"] = function(delay)
		LVBM.AddOns.Ouro.Enraged = false;
		LVBM.AddOns.Ouro.Submerged = false;
		LVBM.Announce("*** Ouro has emerged - 3 minutes until submerge ***");
		LVBM.Schedule(80 - delay, "LVBM.AddOns.Ouro.OnEvent", "SubmergeWarning", 100);
		LVBM.Schedule(120 - delay, "LVBM.AddOns.Ouro.OnEvent", "SubmergeWarning", 60);
		LVBM.Schedule(165 - delay, "LVBM.AddOns.Ouro.OnEvent", "SubmergeWarning", 15);
		LVBM.StartStatusBarTimer(180 - delay, "Submerge");
	end,
	["OnCombatEnd"] = function()
		LVBM.AddOns.Ouro.Enraged = false;
		LVBM.AddOns.Ouro.Submerged = false;
	end,
	["OnEvent"] = function(event, arg1)
		if (event == "CHAT_MSG_MONSTER_EMOTE") then
			if arg1 == LVBM_OURO_ENRAGE and arg2 == LVBM_OURO_OURO then
				LVBM.Announce(LVBM_OURO_ENRAGE_ANNOUNCE);
				LVBM.AddOns.Ouro.Enraged = true;
				LVBM.UnSchedule("LVBM.AddOns.Ouro.OnEvent", "SubmergeWarning", 100); --ouro does not submerge when enraged
				LVBM.UnSchedule("LVBM.AddOns.Ouro.OnEvent", "SubmergeWarning", 60);
				LVBM.UnSchedule("LVBM.AddOns.Ouro.OnEvent", "SubmergeWarning", 15);
				LVBM.EndStatusBarTimer("Submerge");
			end
		elseif (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") or (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF") then
			if (arg1 == LVBM_OURO_CAST_SWEEP) then
				LVBM.AddOns.Ouro.InCombat = true;
				LVBM.Announce(LVBM_OURO_SWEEP_WARNING);
				LVBM.Schedule(16, "LVBM.AddOns.Ouro.OnEvent", "SweepWarning", 5);
				LVBM.EndStatusBarTimer("Sweep")
				LVBM.StartStatusBarTimer(1.5, "Sweep Cast");
				LVBM.Schedule(1.5, "LVBM.AddOns.Ouro.OnEvent", "StartNewTimer", "Sweep");
			elseif (arg1 == LVBM_OURO_CAST_SAND_BLAST) then
				LVBM.AddOns.Ouro.InCombat = true;
				LVBM.Announce(LVBM_OURO_BLAST_WARNING);				
				LVBM.Schedule(18, "LVBM.AddOns.Ouro.OnEvent", "SandBlastWarning", 5);
				LVBM.EndStatusBarTimer("Sand Blast");
				LVBM.StartStatusBarTimer(2, "Sand Blast Cast");
				LVBM.Schedule(2, "LVBM.AddOns.Ouro.OnEvent", "StartNewTimer", "Sand Blast");
			elseif (not LVBM.AddOns.Ouro.Submerged) and (not LVBM.AddOns.Ouro.Enraged) and string.find(arg1, LVBM_OURO_DIRT_MOUND_QUAKE) and ((not LVBM.GetStatusBarTimerTimeLeft("Emerge")) or (LVBM.GetStatusBarTimerTimeLeft("Emerge") > 22)) then
				LVBM.AddOns.Ouro.InCombat = true;
				LVBM.AddOns.Ouro.Submerged = true;
				LVBM.Announce(LVBM_OURO_SUBMERGED_WARNING);
				LVBM.Schedule(22, "LVBM.AddOns.Ouro.OnEvent", "EmergeWarning", 5);
				LVBM.Schedule(27, "LVBM.AddOns.Ouro.OnEvent", "OuroEmerge");
				LVBM.Schedule(34, "LVBM.AddOns.Ouro.OnEvent", "ResetSubmergeVar");
				LVBM.UnSchedule("LVBM.AddOns.Ouro.OnEvent", "SubmergeWarning", 100);
				LVBM.UnSchedule("LVBM.AddOns.Ouro.OnEvent", "SubmergeWarning", 60);
				LVBM.UnSchedule("LVBM.AddOns.Ouro.OnEvent", "SubmergeWarning", 15);
				LVBM.UnSchedule("LVBM.AddOns.Ouro.OnEvent", "SandBlastWarning", 5);
				LVBM.UnSchedule("LVBM.AddOns.Ouro.OnEvent", "SweepWarning", 5);
				LVBM.EndStatusBarTimer("Submerge");
				LVBM.EndStatusBarTimer("Sweep");
				LVBM.EndStatusBarTimer("Sand Blast");
				LVBM.StartStatusBarTimer(27, "Emerge");
			end
		elseif (event == "StartNewTimer") then
			if arg1 == "Sweep" then
				LVBM.StartStatusBarTimer(19, "Sweep");
			elseif arg1 == "Sand Blast" then
				LVBM.StartStatusBarTimer(21, "Sand Blast");
			end
		elseif (event == "ResetSubmergeVar") then
			LVBM.AddOns.Ouro.Submerged = false;
		elseif (event == "SweepWarning") then		
			if arg1 == 5 then
				LVBM.Announce(LVBM_OURO_SWEEP_SOON_WARNING);
			end
		elseif (event == "SandBlastWarning") then
			if arg1 == 5 then
				LVBM.Announce(LVBM_OURO_BLAST_SOON_WARNING);
			end
		elseif (event == "EmergeWarning") then
			LVBM.Announce(LVBM_OURO_EMERGE_SOON_WARNING);
		elseif (event == "OuroEmerge") then
			LVBM.Announce(LVBM_OURO_EMERGED_WARNING);
			LVBM.Schedule(80, "LVBM.AddOns.Ouro.OnEvent", "SubmergeWarning", 100);
			LVBM.Schedule(120, "LVBM.AddOns.Ouro.OnEvent", "SubmergeWarning", 60);
			LVBM.Schedule(165, "LVBM.AddOns.Ouro.OnEvent", "SubmergeWarning", 15);
			LVBM.EndStatusBarTimer("Emerge");
			LVBM.StartStatusBarTimer(180, "Submerge");
		elseif (event == "SubmergeWarning") then
			if arg1 == 100 then
				LVBM.Announce(LVBM_OURO_POSSIBLE_SUBMERGE_WARNING);
			elseif arg1 then				
				LVBM.Announce(string.format(LVBM_OURO_SUBMERGE_WARNING, arg1));
			end
		end
	end,
};
