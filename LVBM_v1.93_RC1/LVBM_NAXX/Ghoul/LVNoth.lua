--
-- La Vendetta Noth the Plaguebringer Raid Warning AddOn
-- (c) by Nitram from La Vendetta on DE-Azshara
--
-- Edited Hye/Ajaaja of Kilrogg (first blink timer and spawn warning during balcony phase) - thank you!

LVBM.AddOns.Noth = {
	["Name"] = LVBM_NTP_NAME,
	["Abbreviation1"] = "Noth",
	["Abbreviation2"] = "NTP",
	["Version"] = "1.6",
	["Author"] = "Nitram",
	["Description"] = LVBM_NTP_DESCRIPTION,
	["Instance"] = LVBM_NAXX,
	["GUITab"] = LVBMGUI_TAB_NAXX,
	["Sort"] = 31,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
		["TimeOnBalcony"] = 70;
		["TimeInRoom"] = 90;
		["OnBalcony"] = false,
		["AnnounceSpawn"] = false,
		["AnnounceCurse"] = true,
	},
	["Phase"] = 0,
	["DropdownMenu"] = {
		[1] = {
			["variable"] = "LVBM.AddOns.Noth.Options.AnnounceSpawn",
			["text"] = LVBM_NTP_OPTION_WARN_SPAWN,
			["func"] = function() LVBM.AddOns.Noth.Options.AnnounceSpawn = not LVBM.AddOns.Noth.Options.AnnounceSpawn; end,
		},
		[2] = {
			["variable"] = "LVBM.AddOns.Noth.Options.AnnounceCurse",
			["text"] = LVBM_NTP_OPTION_WARN_CURSE,
			["func"] = function() LVBM.AddOns.Noth.Options.AnnounceCurse = not LVBM.AddOns.Noth.Options.AnnounceCurse; end,
		},
	},
	["LastCurse"] = 0,
	["Events"] = {
		["CHAT_MSG_MONSTER_YELL"] = true,
		["CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS"] = true,
		["CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS"] = true,
		["CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE"] = true,
	},
	["OnEvent"] = function(event, arg1)
		if (event == "CHAT_MSG_MONSTER_YELL" and ((arg1 == LVBM_NTP_YELL_START1) 
			                               or (arg1 == LVBM_NTP_YELL_START2) 
						       or (arg1 == LVBM_NTP_YELL_START3))) 
		  or (event == "BACKINROOM") then

			LVBM.AddOns.Noth.InCombat = true;
			LVBM.AddOns.Noth.Options.OnBalcony = false;					
			if (event == "BACKINROOM") then
				LVBM.Announce(string.format(LVBM_NTP_BACK_WARNING, LVBM.AddOns.Noth.Options.TimeInRoom));
			else
				LVBM.AddOns.Noth.Options.TimeOnBalcony = 70;
				LVBM.AddOns.Noth.Options.TimeInRoom = 90;
				LVBM.Announce(string.format(LVBM_NTP_TELEPORT_WARNING, LVBM.AddOns.Noth.Options.TimeInRoom));
				LVBM.Schedule(25, "LVBM.AddOns.Noth.OnEvent", "NTP5SecWarningBlink");
				LVBM.Schedule(30, "LVBM.AddOns.Noth.OnEvent", "NTP0SecWarningBlink");
				LVBM.StartStatusBarTimer(30, "Blink Cooldown");
			end
			LVBM.Schedule((LVBM.AddOns.Noth.Options.TimeInRoom-10), "LVBM.AddOns.Noth.OnEvent", "NTP10SecWarningTeleport");
			LVBM.Schedule(LVBM.AddOns.Noth.Options.TimeInRoom, "LVBM.AddOns.Noth.OnEvent", "NTPGoToBalcony");
			LVBM.StartStatusBarTimer(LVBM.AddOns.Noth.Options.TimeInRoom, "Teleport to Balcony");
		end
	
		if( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" ) then			
			if arg1 == LVBM_NTP_SPELL_1 then
				LVBM.Announce(LVBM_NTP_NOTH_GAINS_BLINK);
				LVBM.Schedule(25, "LVBM.AddOns.Noth.OnEvent", "NTP5SecWarningBlink");
				LVBM.EndStatusBarTimer("Blink");
				LVBM.StartStatusBarTimer(30, "Blink");
			end
		end

		if( event == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS" 
		 or event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" 
		 or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" ) then

			if (LVBM.AddOns.Noth.Options.AnnounceCurse 
			and (time() > (LVBM.AddOns.Noth.LastCurse+10) )
			and string.find(arg1, LVBM_NTP_CURSE_AFFLICT)) then

				LVBM.AddOns.Noth.LastCurse = time();
				LVBM.Announce(LVBM_NTP_CURSE_WARNING);
				
				-- LVBM.StartStatusBarTimer(57, "Possible AE Curse");			(need more Tests)
				LVBM.StartStatusBarTimer(9, "Curse Timeout");
			end
		end
		
		if( event == "CHAT_MSG_MONSTER_YELL" and (string.find(arg1, LVBM_NTP_ADDS_SPAWN))) and LVBM.AddOns.Noth.Options.AnnounceSpawn then
			LVBM.Announce(LVBM_NTP_ADD_WARNING);
		end
			
		if (event == "NTP5SecWarningBlink") then							-- Blink System
			LVBM.Announce(LVBM_NTP_BLINK_5SEC_WARNING);
		elseif (event == "NTP0SecWarningBlink") then
			LVBM.Announce(LVBM_NTP_BLINK_0SEC_WARNING);	
		elseif (event == "NTP10SecWarningTeleport") then
			LVBM.Announce(LVBM_NTP_TELEPORT_10SEC_WARNING);				
		elseif (event == "NTP10SECUNTILBACK" ) then
			LVBM.Announce(LVBM_NTP_BACK_10SEC_WARNING);
		elseif (event == "NTP10SecWarningWave2") then
			LVBM.Announce(LVBM_NTP_NEXT_WAVE_SOON);
			
		elseif (event == "NTPGoToBalcony" ) then
			LVBM.AddOns.Noth.Options.OnBalcony = true;
			LVBM.Schedule((LVBM.AddOns.Noth.Options.TimeOnBalcony-10), "LVBM.AddOns.Noth.OnEvent", "NTP10SECUNTILBACK");
			LVBM.Schedule(LVBM.AddOns.Noth.Options.TimeOnBalcony, "LVBM.AddOns.Noth.OnEvent", "BACKINROOM");
			LVBM.StartStatusBarTimer(LVBM.AddOns.Noth.Options.TimeOnBalcony, "Teleport back");
			if (LVBM.AddOns.Noth.Options.TimeOnBalcony == 70 ) then
				LVBM.AddOns.Noth.Phase = 1;
				LVBM.AddOns.Noth.Options.TimeOnBalcony = 95;
				LVBM.AddOns.Noth.Options.TimeInRoom = 110;
				-- Wave1/Wave2 Announce/Scheduling
				LVBM.Schedule(30, "LVBM.AddOns.Noth.OnEvent", "NTP10SecWarningWave2");
				LVBM.StartStatusBarTimer(10, "Wave 1");
				LVBM.StartStatusBarTimer(40, "Wave 2");
			elseif (LVBM.AddOns.Noth.Options.TimeOnBalcony == 95) then
				LVBM.AddOns.Noth.Phase = 2;
				LVBM.AddOns.Noth.Options.TimeOnBalcony = 120;
				LVBM.AddOns.Noth.Options.TimeInRoom = 180;
				-- Wave1/Wave2 Announce/Scheduling
				LVBM.Schedule(45, "LVBM.AddOns.Noth.OnEvent", "NTP10SecWarningWave2");
				LVBM.StartStatusBarTimer(10, "Wave 1");
				LVBM.StartStatusBarTimer(55, "Wave 2");
			end
	
			LVBM.EndStatusBarTimer("Blink");
			LVBM.UnSchedule("LVBM.AddOns.Noth.OnEvent", "NTP5SecWarningBlink");
		end
	end,
}

