--La Vendetta Grand Widow Faerlina Raid Warning AddOn
-- Edited by Hye of Kilrogg
-- Changes:
--  Removed using Yells to determine enrage, they're used only to determine start of combat
--  Enrage determined from CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS
--  Made Enrage timer smart (doesn't get out of sync when embraced before she enrages)

LVBM.AddOns.GrandWidowFaerlina = {
	["Name"] = LVBM_GWF_NAME,
	["Abbreviation1"] = "Faerlina",
	["Abbreviation2"] = "Widow",
	["Abbreviation3"] = "GWF",
	["Version"] = "1.7",
	["Author"] = "Tandanu",
	["Description"] = LVBM_GWF_DESCRIPTION,
	["Instance"] = LVBM_NAXX,
	["GUITab"] = LVBMGUI_TAB_NAXX,
	["Sort"] = 12,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
	},
	["Enraged"] = false,
	["Events"] = {
		["CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS"] = true,
		["CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE"] = true,
		["CHAT_MSG_ADDON"] = true, 					-- Enrage Sync
	},
	["OnCombatStart"] = function(delay)
		LVBM.Announce(string.format(LVBM_GWF_ENRAGE_WARNING2, 60));
		LVBM.StartStatusBarTimer(54, "Enrage");
		LVBM.Schedule(39, "LVBM.AddOns.GrandWidowFaerlina.OnEvent", "EnrageWarning", 15);
		LVBM.Schedule(44, "LVBM.AddOns.GrandWidowFaerlina.OnEvent", "EnrageWarning", 10);
		LVBM.Schedule(49, "LVBM.AddOns.GrandWidowFaerlina.OnEvent", "EnrageWarning", 5);
		LVBM.Schedule(54, "LVBM.AddOns.GrandWidowFaerlina.OnEvent", "EnrageWarning", 0);
		LVBM.AddOns.GrandWidowFaerlina.Enraged = false;
	end,
	["OnEvent"] = function(event, arg1)
		if (event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS") then
			if arg1 == LVBM_GWF_GAIN_ENRAGE then
				LVBM.AddOns.GrandWidowFaerlina.Enraged = true;

				SendAddonMessage("LVGWF ENRAGE", "enrage", "RAID");

				LVBM.Announce(LVBM_GWF_ENRAGE_WARNING1);
				if UnitClass("player") == LVBM_PRIEST and LVBM.GetBuff("player", LVBM_MINDCONTROL) then
					LVBM.AddSpecialWarning("Enrage", true, true)
				end
				LVBM.EndStatusBarTimer("Enrage");
				LVBM.UnSchedule("LVBM.AddOns.GrandWidowFaerlina.OnEvent");
			end

		elseif (event == "CHAT_MSG_ADDON" and arg1 == "LVGWF ENRAGE" and arg2 == "enrage" and arg3 == "RAID") then
			if (not LVBM.AddOns.GrandWidowFaerlina.Enraged) then
				LVBM.AddOns.GrandWidowFaerlina.Enraged = true;
				LVBM.Announce(LVBM_GWF_ENRAGE_WARNING1);
				if UnitClass("player") == LVBM_PRIEST and LVBM.GetBuff("player", LVBM_MINDCONTROL) then
					LVBM.AddSpecialWarning("Enrage", true, true)
				end
				LVBM.EndStatusBarTimer("Enrage");
				LVBM.UnSchedule("LVBM.AddOns.GrandWidowFaerlina.OnEvent");
			end

		elseif (event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE") then
			if arg1 == LVBM_GWF_DEBUFF then				
				local tmpEnrageTime
				local timeLeft, timeElapsed = LVBM.GetStatusBarTimerTimeLeft("Enrage");
				if not timeLeft then
					timeLeft = 0;
				end
				if LVBM.AddOns.GrandWidowFaerlina.Enraged then
					tmpEnrageTime = 54;
				else
					tmpEnrageTime = 30;
				end

				if (timeLeft < tmpEnrageTime) then
					LVBM.UnSchedule("LVBM.AddOns.GrandWidowFaerlina.OnEvent");
					LVBM.EndStatusBarTimer("Enrage");
					LVBM.StartStatusBarTimer(tmpEnrageTime, "Enrage");

					LVBM.Announce(string.format(LVBM_GWF_NEXT_ENRAGE_IN, tmpEnrageTime));
					LVBM.Schedule(tmpEnrageTime-15, "LVBM.AddOns.GrandWidowFaerlina.OnEvent", "EnrageWarning", 15);
					LVBM.Schedule(tmpEnrageTime-10, "LVBM.AddOns.GrandWidowFaerlina.OnEvent", "EnrageWarning", 10);
					LVBM.Schedule(tmpEnrageTime-5, "LVBM.AddOns.GrandWidowFaerlina.OnEvent", "EnrageWarning", 5);
					LVBM.Schedule(tmpEnrageTime, "LVBM.AddOns.GrandWidowFaerlina.OnEvent", "EnrageWarning", 0);
				else
					-- Enrage not prevention not prolonged by *this* embrace, so...
					  -- Use enrage timer that is currently going
					  -- Use Scheduled Timers that are currently in place
				end

				LVBM.EndStatusBarTimer("Widow's Embrace");
				LVBM.StartStatusBarTimer(30, "Widow's Embrace");
				LVBM.Schedule(20, "LVBM.AddOns.GrandWidowFaerlina.OnEvent", "EmbraceWarning", 10);
				LVBM.Announce(string.format(LVBM_GWF_EMBRACE_WARNING, 30));
				
				LVBM.AddOns.GrandWidowFaerlina.Options.Enraged = false;
			end
		elseif (event == "EmbraceWarning") then
			if arg1 then
				LVBM.Announce(string.format(LVBM_GWF_EMBRACE_WARNING, arg1));
			end
		elseif (event == "EnrageWarning") then
			if arg1 and arg1 > 0 then
				LVBM.Announce(string.format(LVBM_GWF_ENRAGE_WARNING2, arg1));
			elseif arg1 == 0 then
				LVBM.Announce(LVBM_GWF_ENRAGE_CD_READY);
			end
		end
	end,
};
