--
-- v1.7 old version from Tanda
-- v1.8 Fixed C'Thun Timers - Nitram (1.12.0)
-- v1.81 re-used old timers (1.12.1)
-- v1.9 Added Option to do not hide Distance Frame during Phase2
-- 	Auto Cleanup after Bossfight if SetIcon is true
--

LVBM.AddOns.CThun = {
	["Name"] = LVBM_CTHUN_NAME,
	["Abbreviation1"] = "CThun",
	["Abbreviation2"] = "ct",
	["Version"] = "1.90",
	["Author"] = "Tandanu",
	["Description"] = LVBM_CTHUN_DESCRIPTION,
	["SlashCmdHelpText"] = {
		[1] = LVBM_CTHUN_SLASHHELP1, 
	},
	["Instance"] = LVBM_AQ40,
	["GUITab"] = LVBMGUI_TAB_AQ40,
	["Sort"] = 9,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
		["Whisper"] = true,
		["SetIcon"] = true,
		["RangeCheck"] = true,
		["RangeCheckPhase2"] = false,
	},
	["NextSpawn"] = LVBM_CTHUN_CLAW,
	["CurrentTarget"] = "",
	["LastTarget"] = "",
	["LastTargetChange"] = GetTime(),
	["InCombat"] = false,
	["Phase2JustStarted"] = false,
	["DropdownMenu"] = {
		[1] = {
			["variable"] = "LVBM.AddOns.CThun.Options.Whisper",
			["text"] = LVBM_CTHUN_SEND_WHISPER,
			["func"] = function() LVBM.AddOns.CThun.Options.Whisper = not LVBM.AddOns.CThun.Options.Whisper; end,
		},
		[2] = {
			["variable"] = "LVBM.AddOns.CThun.Options.SetIcon",
			["text"] = LVBM_CTHUN_SET_ICON,
			["func"] = function() LVBM.AddOns.CThun.Options.SetIcon = not LVBM.AddOns.CThun.Options.SetIcon; end,
		},
		[3] = {
			["variable"] = "LVBM.AddOns.CThun.Options.RangeCheck",
			["text"] = LVBM_CTHUN_RANGE_CHECK,
			["func"] = function() LVBM.AddOns.CThun.Options.RangeCheck = not LVBM.AddOns.CThun.Options.RangeCheck; end,
		},
		[4] = {
			["variable"] = "LVBM.AddOns.CThun.Options.RangeCheckPhase2",
			["text"] = LVBM_CTHUN_RANGE_CHECK_PHASE2,
			["func"] = function() LVBM.AddOns.CThun.Options.RangeCheckPhase2 = not LVBM.AddOns.CThun.Options.RangeCheckPhase2; end,
		},
	},
	["Events"] = {
		["CHAT_MSG_MONSTER_EMOTE"] = true,
		["PLAYER_REGEN_DISABLED"] = true,
		["CHAT_MSG_COMBAT_HOSTILE_DEATH"] = true,
		["CHAT_MSG_ADDON"] = true,
	},
	["OnSlashCommand"] = function(msg)
		if string.lower(msg) == "start" and not LVBM.AddOns.CThun.InCombat then
			LVBM.AddOns.CThun.InCombat = true;
			LVBM.Schedule(44.5, "LVBM.AddOns.CThun.OnEvent", "DarkGlareWarning", 5);
			LVBM.Schedule(49.5, "LVBM.AddOns.CThun.OnEvent", "DarkGlareWarning", 0);
			LVBM.Schedule(39.5, "LVBM.AddOns.CThun.OnEvent", "SmallEyeWarning", 5);
			LVBM.Schedule(44.5, "LVBM.AddOns.CThun.OnEvent", "SmallEyeWarning", 0);
			if (not LVBM.GetStatusBarTimerTimeLeft("Dark Glare")) and LVBM.AddOns.CThun.Options.Announce then --synced timer is better!
				LVBM.StartStatusBarTimer(49.5, "Dark Glare")
			end
			if (not LVBM.GetStatusBarTimerTimeLeft("Eye Tentacles")) and LVBM.AddOns.CThun.Options.Announce then
				LVBM.StartStatusBarTimer(44.5, "Eye Tentacles")
			end
			if LVBM.AddOns.CThun.Options.RangeCheck then
				LVBM_Gui_DistanceFrame(true);
			end
			LVBM.AddMsg("C'Thun timers started!", "C'Thun");
			return true;
		end
	end,
	["OnCombatStart"] = function(delay)		
		LVBM.AddOns.CThun.Phase2 = false;
		LVBM.Schedule(37 + 7.5 - delay, "LVBM.AddOns.CThun.OnEvent", "DarkGlareWarning", 5);
		LVBM.Schedule(42 + 7.5 - delay, "LVBM.AddOns.CThun.OnEvent", "DarkGlareWarning", 0);
		LVBM.Schedule(32 + 7.5 - delay, "LVBM.AddOns.CThun.OnEvent", "SmallEyeWarning", 5);
		LVBM.Schedule(37 + 7.5 - delay, "LVBM.AddOns.CThun.OnEvent", "SmallEyeWarning", 0);
		if (not LVBM.GetStatusBarTimerTimeLeft("Dark Glare")) and LVBM.AddOns.CThun.Options.Announce then --synced timer is better!
			LVBM.StartStatusBarTimer(48 + 7.5 - delay, "Dark Glare")
		end
		if (not LVBM.GetStatusBarTimerTimeLeft("Eye Tentacles")) and LVBM.AddOns.CThun.Options.Announce then
			LVBM.StartStatusBarTimer(43 + 7.5 - delay, "Eye Tentacles")
		end
		if LVBM.AddOns.CThun.Options.RangeCheck then
			LVBM_Gui_DistanceFrame(true);
		end
	end,
	["OnCombatEnd"] = function()
		LVBM.AddOns.CThun.Phase2 = false;
		if LVBM.AddOns.CThun.Options.RangeCheck then
			LVBM_Gui_DistanceFrame(false);
		end
		if LVBM.AddOns.CThun.Options.SetIcon then
			LVBM.CleanUp();
		end
	end,
	["OnEvent"] = function(event, arg1)
		if event == "CHAT_MSG_ADDON" and arg3 == "RAID" then
			if arg1 == "LVBMCTHUN" then
				if arg2 == "GOGO2" then
					if not LVBM.AddOns.CThun.Phase2 then
						LVBM.AddOns.CThun.InCombat = true;
						LVBM.AddOns.CThun.Phase2 = true;
						LVBM.UnSchedule("LVBM.AddOns.CThun.OnEvent");
						LVBM.EndStatusBarTimer("Dark Glare");
						LVBM.EndStatusBarTimer("Dark Glare End");
						LVBM.EndStatusBarTimer("Eye Tentacles");
						LVBM.Schedule(2, "LVBM.AddOns.CThun.OnEvent", "Phase2OrWeakenedEnd");
						LVBM.AddOns.CThun.Phase2JustStarted = true; --because of out of combat bug
						LVBM.Schedule(40, "LVBM.AddOns.CThun.OnEvent", "ResetPhase2Var");
						if LVBM.AddOns.CThun.Options.RangeCheck then
							LVBM_Gui_DistanceFrame(false);
						end
					end
				end
			end
		elseif (event == "SmallEyeWarning") then
			if arg1 == 5 then
				LVBM.Announce(string.format(LVBM_CTHUN_SMALL_EYE_WARNING, 5));
			elseif arg1 == 0 then
				LVBM.Schedule(40, "LVBM.AddOns.CThun.OnEvent", "SmallEyeWarning", 5);
				LVBM.Schedule(45, "LVBM.AddOns.CThun.OnEvent", "SmallEyeWarning", 0);
				if ((not LVBM.GetStatusBarTimerTimeLeft("Eye Tentacles")) or (LVBM.GetStatusBarTimerTimeLeft("Eye Tentacles") < 1.5)) and LVBM.AddOns.CThun.Options.Announce then
					LVBM.StartStatusBarTimer(45, "Eye Tentacles")
				end
			end
		elseif (event == "DarkGlareWarning") then
			if arg1 == 5 then
				LVBM.Announce(string.format(LVBM_CTHUN_DARK_GLARE_WARNING, 5));
				LVBM.Schedule(1, "LVBM.AddOns.CThun.OnEvent", "CheckDarkGlareTarget");
			end		
		elseif (event == "CheckDarkGlareTarget") then
			if (LVBM.AddOns.CThun.CurrentTarget and (LVBM.AddOns.CThun.LastTargetChange + 4.5 > GetTime()))  then
				local name, subgroup, name2, subgroup2, iconCounter;
				iconCounter = 3;
				for i = 1, GetNumRaidMembers() do
					name, _, subgroup = GetRaidRosterInfo(i);
					if name == LVBM.AddOns.CThun.CurrentTarget then
						break;
					end
				end

				if (name and subgroup) then
					LVBM.Announce(LVBM_CTHUN_DARK_GLARE_ON_GROUP..subgroup.." ***");
					for i = 1, GetNumRaidMembers()do
						name2, _, subgroup2 = GetRaidRosterInfo(i);			
						if subgroup2 == subgroup then
							if LVBM.AddOns.CThun.Options.SetIcon and LVBM.Rank >= 1 then
								SetRaidTargetIcon("raid"..i, iconCounter);
							end
							LVBM.Schedule(15, "LVBM.AddOns.CThun.OnEvent", "ResetRaidTargetIcon", name2);
							iconCounter = iconCounter + 1;
							if name2 == UnitName("player") then
								LVBM.AddSpecialWarning(LVBM_CTHUN_DARK_GLARE, true, true);
							else
								if LVBM.AddOns.CThun.Options.Announce and LVBM.AddOns.CThun.Options.Whisper and LVBM.Rank >= 1 then
									LVBM.SendHiddenWhisper(LVBM_CTHUN_DARK_GLARE_ON_YOU, name2);
								end
							end
						end
					end	
				end
			end
			LVBM.Schedule(4, "LVBM.AddOns.CThun.OnEvent", "GetDarkGlareDuration");

		elseif (event == "GetDarkGlareDuration") then
			local delta = - GetTime() + LVBM.AddOns.CThun.LastTargetChange + 6.66; --timers by Mukka (AddOn: AQ_BossMod) - thx for this great idea to announce the targeted group :)
			if (delta < -1.5) or (delta > 1.8) then
				delta = 0;
				if LVBM.AddOns.CThun.Options.Announce then
					LVBM.AddMsg(LVBM_CTHUN_DARK_GLARE_TIMER_FAILED);
				end
			end
			local glareEnd = 38 - 4 + delta + 3; -- +3 adjustment by me...Mukka's timers did not work 100% correct..."dark glare end" must be 3 seconds longer (and "dark glare" bar was 3 seconds too long --> wasn't a big problem)
			LVBM.Schedule((glareEnd - 5), "LVBM.AddOns.CThun.OnEvent", "DarkGlareEndWarning", 5);
			LVBM.Schedule(glareEnd, "LVBM.AddOns.CThun.OnEvent", "DarkGlareEndWarning", 0);
			if (not LVBM.GetStatusBarTimerTimeLeft("Dark Glare End")) and LVBM.AddOns.CThun.Options.Announce then
				LVBM.StartStatusBarTimer(glareEnd, "Dark Glare End");
			end		
		elseif (event == "DarkGlareEndWarning") then
			if arg1 == 5 then
				LVBM.Announce(string.format(LVBM_CTHUN_DARK_GLARE_END_WARNING, 5));
			elseif arg1 == 0 then
				LVBM.Schedule(44.2, "LVBM.AddOns.CThun.OnEvent", "DarkGlareWarning", 5);
				if (not LVBM.GetStatusBarTimerTimeLeft("Dark Glare")) and LVBM.AddOns.CThun.Options.Announce then
					LVBM.StartStatusBarTimer(49, "Dark Glare");
				end
			end
		elseif (event == "CHAT_MSG_COMBAT_HOSTILE_DEATH") then
			if (arg1 == LVBM_CTHUN_DIES) and not LVBM.AddOns.CThun.Phase2 then
				LVBM.AddOns.CThun.InCombat = true;
				LVBM.AddOns.CThun.Phase2 = true;
				LVBM.UnSchedule("LVBM.AddOns.CThun.OnEvent");
				LVBM.EndStatusBarTimer("Dark Glare");
				LVBM.EndStatusBarTimer("Dark Glare End");
				LVBM.EndStatusBarTimer("Eye Tentacles");
				LVBM.Schedule(2, "LVBM.AddOns.CThun.OnEvent", "Phase2OrWeakenedEnd");
				LVBM.AddOns.CThun.Phase2JustStarted = true; --because of out of combat bug
				LVBM.Schedule(40, "LVBM.AddOns.CThun.OnEvent", "ResetPhase2Var");
				if (LVBM.AddOns.CThun.Options.RangeCheck and not LVBM.AddOns.CThun.Options.RangeCheckPhase2) then
					LVBM_Gui_DistanceFrame(false);
				end
				SendAddonMessage("LVBMCTHUN", "GOGO2", "RAID");
			end
		elseif (event == "ResetPhase2Var") then
			LVBM.AddOns.CThun.Phase2JustStarted = false;
		elseif (event == "Phase2OrWeakenedEnd") then
			LVBM.AddOns.CThun.NextSpawn = LVBM_CTHUN_CLAW;
			LVBM.Announce(LVBM_CTHUN_GIANT_CLAW_WARNING);
			LVBM.Schedule(10, "LVBM.AddOns.CThun.OnEvent", "GiantTentacleSpawn", 0);
			LVBM.StartStatusBarTimer(10, "Giant Claw Tentacle");
		elseif (event == "GiantTentacleSpawn") then
			LVBM.AddOns.CThun.InCombat = true;
			if arg1 == 10 then
				LVBM.Announce(string.format(LVBM_CTHUN_GIANT_AND_EYES_WARNING, LVBM.AddOns.CThun.NextSpawn));
			elseif arg1 == 0 then
				if LVBM.AddOns.CThun.NextSpawn == LVBM_CTHUN_CLAW then
					LVBM.AddOns.CThun.NextSpawn = LVBM_CTHUN_EYE;
					LVBM.StartStatusBarTimer(30, "Giant Eye Tentacle");
				elseif LVBM.AddOns.CThun.NextSpawn == LVBM_CTHUN_EYE then
					LVBM.AddOns.CThun.NextSpawn = LVBM_CTHUN_CLAW;
					LVBM.StartStatusBarTimer(30, "Giant Claw Tentacle");
				end
				LVBM.Schedule(20, "LVBM.AddOns.CThun.OnEvent", "GiantTentacleSpawn", 10);
				LVBM.Schedule(30, "LVBM.AddOns.CThun.OnEvent", "GiantTentacleSpawn", 0);
				LVBM.StartStatusBarTimer(30, "Eye Tentacles");
			end
		elseif (event == "CHAT_MSG_MONSTER_EMOTE") then
			if arg1 == LVBM_CTHUN_WEAKENED and arg2 == LVBM_CTHUN_NAME then
				LVBM.AddOns.CThun.InCombat = true;
				LVBM.UnSchedule("LVBM.AddOns.CThun.OnEvent");
				LVBM.EndStatusBarTimer("Giant Claw Tentacle");
				LVBM.EndStatusBarTimer("Giant Eye Tentacle");
				LVBM.EndStatusBarTimer("Eye Tentacles");
				
				LVBM.Announce(LVBM_CTHUN_WEAKENED_WARNING);
				LVBM.Schedule(20, "LVBM.AddOns.CThun.OnEvent", "WeakenedWarning", 25);
				LVBM.Schedule(35, "LVBM.AddOns.CThun.OnEvent", "WeakenedWarning", 10);
				LVBM.Schedule(45, "LVBM.AddOns.CThun.OnEvent", "Phase2OrWeakenedEnd", 0);
				LVBM.StartStatusBarTimer(45, "Weakened");
			end
		elseif (event == "WeakenedWarning") then
			if arg1 then
				LVBM.Announce(string.format(LVBM_CTHUN_WEAKENED_ENDS_WARNING, arg1));
			end
		elseif (event == "ResetRaidTargetIcon") and arg1 then
			local name;
			for i = 1, GetNumRaidMembers() do
				name = GetRaidRosterInfo(i);
				if name == arg1 then
					SetRaidTargetIcon("raid"..i, 0);
					break;
				end
			end
		end
	end,

	["OnUpdate"] = function(elapsed)
		if (not LVBM.AddOns.CThun.InCombat) or (GetRealZoneText() ~= LVBM_AQ40) then		
			return;
		end
			
		local UnitID, newTarget;
			
		if UnitName("target") == LVBM_CTHUN_EYE_OF_CTHUN then
			newTarget = UnitName("targettarget")
		else
			for i = 1, GetNumRaidMembers() do
				if UnitName("raid"..i.."target") == LVBM_CTHUN_EYE_OF_CTHUN then
					newTarget = UnitName("Raid"..i.."targettarget")
					break;
				end
			end
		end
		if newTarget ~= LVBM.AddOns.CThun.LastTarget then
			if newTarget then
				if (LVBM.AddOns.CThun.LastTargetChange + 1 < GetTime()) then
					local targetIcon = 3;
					for i = 1, GetNumRaidMembers() do
						if GetRaidRosterInfo(i) == newTarget then
							if GetRaidTargetIndex("raid"..i) ~= 8 and LVBM.AddOns.CThun.Options.SetIcon and LVBM.Rank >= 1 then
								SetRaidTargetIcon("raid"..i, 8);
							end
							if newTarget == UnitName("player") then
								LVBM.AddSpecialWarning(LVBM_CTHUN_EYE_BEAM, false, true);
							end
						end
					end
				end
				LVBM.AddOns.CThun.CurrentTarget = newTarget
				LVBM.AddOns.CThun.LastTarget = newTarget
				LVBM.AddOns.CThun.LastTargetChange = GetTime()
			else
				LVBM.AddOns.CThun.LastTarget = nil
			end
		end
	end,
	["UpdateInterval"] = 0.2,
};
