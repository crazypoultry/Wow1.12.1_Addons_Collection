LVBM.AddOns.Gothik = {
	["Name"] = LVBM_GOTH_NAME,
	["Abbreviation1"] = "Gothik",
	["Abbreviation2"] = "gth",	
	["Version"] = "1.0",
	["Author"] = "Tandanu",
	["Description"] = LVBM_GOTH_DESCRIPTION,
	["Instance"] = LVBM_NAXX,
	["GUITab"] = LVBMGUI_TAB_NAXX,
	["Sort"] = 22,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
	},
	["InCombat"] = false,
	["Wave"] = 0,
	["Events"] = {
		["CHAT_MSG_MONSTER_YELL"] = true,
		["CHAT_MSG_COMBAT_HOSTILE_DEATH"] = true,
	},
	["TellMages"] = function()	-- LVBM.AddOns.Gothik.TellMages
		for i=1, GetNumRaidMembers(), 1 do
			if( UnitClass("raid"..i) == LVBM_MAGE ) then
				LVBM.SendHiddenWhisper("Sheep Wave", UnitName("raid"..i));
			end
		end
	end,
	["OnEvent"] = function(event, arg1)
		if event == "CHAT_MSG_MONSTER_YELL" then
			if arg1 == LVBM_GOTH_YELL_START1 then
				LVBM.AddOns.Gothik.InCombat = true;
				LVBM.StartStatusBarTimer(270, "Phase 2");
				LVBM.Schedule(90, "LVBM.AddOns.Gothik.OnEvent", "GothikIncWarning", 180);
				LVBM.Schedule(150, "LVBM.AddOns.Gothik.OnEvent", "GothikIncWarning", 120);
				LVBM.Schedule(210, "LVBM.AddOns.Gothik.OnEvent", "GothikIncWarning", 60);
				LVBM.Schedule(240, "LVBM.AddOns.Gothik.OnEvent", "GothikIncWarning", 30);
				LVBM.Schedule(260, "LVBM.AddOns.Gothik.OnEvent", "GothikIncWarning", 10);
				LVBM.Schedule(270, "LVBM.AddOns.Gothik.OnEvent", "GothikIncWarning", 0);
				LVBM.Schedule(27, "LVBM.AddOns.Gothik.OnEvent", "TraineeWarning", 0);
				LVBM.Schedule(77, "LVBM.AddOns.Gothik.OnEvent", "KnightWarning", 0);
				LVBM.Schedule(137, "LVBM.AddOns.Gothik.OnEvent", "RiderWarning", 0);
				
				LVBM.Schedule(27 - 3, "LVBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 1);
				LVBM.Schedule(47 - 3, "LVBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 2);
				LVBM.Schedule(67 - 3, "LVBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 3);
				LVBM.Schedule(77 - 3, "LVBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 4);
				LVBM.Schedule(87 - 3, "LVBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 5);
				LVBM.Schedule(102 - 3, "LVBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 6);
				LVBM.Schedule(107 - 3, "LVBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 7);
				LVBM.Schedule(127 - 3, "LVBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 8);
				LVBM.Schedule(137 - 3, "LVBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 9);
				LVBM.Schedule(147 - 3, "LVBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 10);
				LVBM.Schedule(152 - 3, "LVBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 11);
				LVBM.Schedule(167 - 3, "LVBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 12);
				LVBM.Schedule(177 - 3, "LVBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 13);
				LVBM.Schedule(187 - 3, "LVBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 14);
				LVBM.Schedule(197 - 3, "LVBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 15);
				LVBM.Schedule(202 - 3, "LVBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 16);
				LVBM.Schedule(207 - 3, "LVBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 17);
				LVBM.Schedule(227 - 3, "LVBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 18);
--				LVBM.Schedule(247 - 3, "LVBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 19);
--				LVBM.Schedule(252 - 3, "LVBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 20);
--				LVBM.Schedule(257 - 3, "LVBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 21);
--				LVBM.Schedule(267 - 3, "LVBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 22);
				
				LVBM.StartStatusBarTimer(137, "Rider");
				LVBM.StartStatusBarTimer(77, "Deathknight");
				LVBM.StartStatusBarTimer(27, "Trainees");
			elseif arg1 == LVBM_GOTH_PHASE2_YELL then
				LVBM.Announce(LVBM_GOTH_PHASE2_WARNING);
			end
		elseif event == "CHAT_MSG_COMBAT_HOSTILE_DEATH" then
			if string.find(arg1, LVBM_GOTH_RIDER) then
				LVBM.AddOns.Gothik.InCombat = true;
				LVBM.Announce(string.format(LVBM_GOTH_DEAD_WARNING, LVBM_GOTH_RIDER_SHORT));
			elseif string.find(arg1, LVBM_GOTH_KNIGHT) then
				LVBM.AddOns.Gothik.InCombat = true;
				LVBM.Announce(string.format(LVBM_GOTH_DEAD_WARNING, LVBM_GOTH_KNIGHT_SHORT));
			end
		elseif event == "GothikIncWarning" then
			LVBM.AddOns.Gothik.InCombat = true;
			if arg1 and arg1 >= 60 then
				LVBM.Announce(string.format(LVBM_GOTH_PHASE2_INC_WARNING, arg1/60, LVBM_MIN));
			elseif arg1 and arg1 > 0 then
				LVBM.Announce(string.format(LVBM_GOTH_PHASE2_INC_WARNING, arg1, LVBM_SEC));
			elseif arg1 == 0 then
				LVBM.AddOns.Gothik.InCombat = false;
				LVBM.UnSchedule("LVBM.AddOns.Gothik.OnEvent");
				LVBM.EndStatusBarTimer("Phase 2");
				LVBM.EndRepeatingStatusBarTimer("Rider");
				LVBM.EndRepeatingStatusBarTimer("Deathknight");
				LVBM.EndRepeatingStatusBarTimer("Trainees");
			end
		elseif event == "TraineeWarning" then
			LVBM.AddOns.Gothik.InCombat = true;
			if arg1 == 3 then
--				LVBM.Announce(string.format(LVBM_GOTH_INC_WARNING, LVBM_GOTH_TRAINEE_SHORT, arg1));
--				LVBM.Schedule(3, "LVBM.AddOns.Gothik.OnEvent", "TraineeWarning", 0);
			elseif arg1 == 0 then
				LVBM.StartRepeatingStatusBarTimer(20, "Trainees", 10);
			end
		elseif event == "KnightWarning" then
			LVBM.AddOns.Gothik.InCombat = true;
			if arg1 == 3 then
--				LVBM.Announce(string.format(LVBM_GOTH_INC_WARNING, LVBM_GOTH_KNIGHT_SHORT, arg1));
--				LVBM.Schedule(3, "LVBM.AddOns.Gothik.OnEvent", "KnightWarning", 0);
			elseif arg1 == 0 then
				LVBM.StartRepeatingStatusBarTimer(25, "Deathknight", 6);
			end
		elseif event == "RiderWarning" then
			LVBM.AddOns.Gothik.InCombat = true;
			if arg1 == 3 then
--				LVBM.Announce(string.format(LVBM_GOTH_INC_WARNING, LVBM_GOTH_RIDER_SHORT, arg1));
--				LVBM.Schedule(3, "LVBM.AddOns.Gothik.OnEvent", "RiderWarning", 0);
			elseif arg1 == 0 then
				LVBM.StartRepeatingStatusBarTimer(30, "Rider", 3);
			end
		elseif event == "WaveIncWarning" then
			LVBM.AddOns.Gothik.Wave = arg1;
			if arg1 == 1 then
				LVBM.Announce(string.format(LVBM_GOTH_WAVE_INC_WARNING1, arg1, 3, LVBM_GOTH_TRAINEE_SHORT));
			elseif arg1 == 2 then
				LVBM.Announce(string.format(LVBM_GOTH_WAVE_INC_WARNING1, arg1, 3, LVBM_GOTH_TRAINEE_SHORT));
			elseif arg1 == 3 then
				LVBM.Announce(string.format(LVBM_GOTH_WAVE_INC_WARNING1, arg1, 3, LVBM_GOTH_TRAINEE_SHORT));
			elseif arg1 == 4 then
				LVBM.Announce(string.format(LVBM_GOTH_WAVE_INC_WARNING1, arg1, 2, LVBM_GOTH_KNIGHTS_SHORT));
			elseif arg1 == 5 then
				LVBM.Announce(string.format(LVBM_GOTH_WAVE_INC_WARNING1, arg1, 3, LVBM_GOTH_TRAINEE_SHORT));
			elseif arg1 == 6 then
				LVBM.Announce(string.format(LVBM_GOTH_WAVE_INC_WARNING1, arg1, 2, LVBM_GOTH_KNIGHTS_SHORT));
			elseif arg1 == 7 then
				LVBM.Announce(string.format(LVBM_GOTH_WAVE_INC_WARNING1, arg1, 3, LVBM_GOTH_TRAINEE_SHORT));
			elseif arg1 == 8 then
				LVBM.Announce(string.format(LVBM_GOTH_WAVE_INC_WARNING2, arg1, 2, LVBM_GOTH_KNIGHTS_SHORT, 3, LVBM_GOTH_TRAINEE_SHORT));
			elseif arg1 == 9 then
				LVBM.Announce(string.format(LVBM_GOTH_WAVE_INC_WARNING1, arg1, 1, LVBM_GOTH_RIDER_SHORT));
				-- LVBM.AddOns.Gothik.TellMages();
			elseif arg1 == 10 then
				LVBM.Announce(string.format(LVBM_GOTH_WAVE_INC_WARNING1, arg1, 3, LVBM_GOTH_TRAINEE_SHORT));
			elseif arg1 == 11 then
				LVBM.Announce(string.format(LVBM_GOTH_WAVE_INC_WARNING1, arg1, 2, LVBM_GOTH_KNIGHTS_SHORT));
			elseif arg1 == 12 then
				LVBM.Announce(string.format(LVBM_GOTH_WAVE_INC_WARNING2, arg1, 1, LVBM_GOTH_RIDER_SHORT, 3, LVBM_GOTH_TRAINEE_SHORT))
				-- LVBM.AddOns.Gothik.TellMages();
			elseif arg1 == 13 then
				LVBM.Announce(string.format(LVBM_GOTH_WAVE_INC_WARNING1, arg1, 2, LVBM_GOTH_KNIGHTS_SHORT));
			elseif arg1 == 14 then
				LVBM.Announce(string.format(LVBM_GOTH_WAVE_INC_WARNING1, arg1, 3, LVBM_GOTH_TRAINEE_SHORT));
			elseif arg1 == 15 then
				LVBM.Announce(string.format(LVBM_GOTH_WAVE_INC_WARNING1, arg1, 1, LVBM_GOTH_RIDER_SHORT));
			elseif arg1 == 16 then
				LVBM.Announce(string.format(LVBM_GOTH_WAVE_INC_WARNING1, arg1, 2, LVBM_GOTH_KNIGHTS_SHORT));
			elseif arg1 == 17 then
				LVBM.Announce(string.format(LVBM_GOTH_WAVE_INC_WARNING1, arg1, 3, LVBM_GOTH_TRAINEE_SHORT));
			elseif arg1 == 18 then
				LVBM.Announce(string.format(LVBM_GOTH_WAVE_INC_WARNING3, arg1, 1, LVBM_GOTH_RIDER_SHORT, 2, LVBM_GOTH_KNIGHTS_SHORT, 3, LVBM_GOTH_TRAINEE_SHORT));
--[[		elseif arg1 == 19 then
				LVBM.Announce(string.format(LVBM_GOTH_WAVE_INC_WARNING1, arg1, 3, LVBM_GOTH_TRAINEE_SHORT));
			elseif arg1 == 20 then
				LVBM.Announce(string.format(LVBM_GOTH_WAVE_INC_WARNING1, arg1, 2, LVBM_GOTH_KNIGHTS_SHORT));
			elseif arg1 == 21 then
				LVBM.Announce(string.format(LVBM_GOTH_WAVE_INC_WARNING1, arg1, 1, LVBM_GOTH_RIDER_SHORT));
			elseif arg1 == 22 then
				LVBM.Announce(string.format(LVBM_GOTH_WAVE_INC_WARNING1, arg1, 3, LVBM_GOTH_TRAINEE_SHORT)); ]]
			end
		end
	end,
};
