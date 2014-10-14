--
-- La Vendetta Instructor Razuvious Raid Warning AddOn
-- (c) by Nitram from La Vendetta on DE-Azshara
--

LVBM.AddOns.Razuvious = {
	["Name"] = LVBM_IR_NAME,
	["Abbreviation1"] = "Razu",
	["Abbreviation2"] = "Razuvious",
	["Abbreviation3"] = "ir",
	["Version"] = "1.6",
	["Author"] = "Nitram",
	["Description"] = LVBM_IR_DESCRIPTION,
	["Instance"] = LVBM_NAXX,
	["GUITab"] = LVBMGUI_TAB_NAXX,
	["Sort"] = 21,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
		["10SecWarning"] = false,
	},
	["Lastshout"] = 0,
	["OnLoop"] = false,
	["LastAnnounce"] = 0,
	["DropdownMenu"] = {
		[1] = {
			["variable"] = "LVBM.AddOns.Razuvious.Options['10SecWarning']",
			["text"] = LVBM_IR_SHOW_10SEC_WARNING,
			["func"] = function() LVBM.AddOns.Razuvious.Options["10SecWarning"] = not LVBM.AddOns.Razuvious.Options["10SecWarning"]; end,
		},
	},
	["Events"] = {
		["CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE"] = true,		-- Disrupting Shout on YOU
		["CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE"] = true,		-- on Party
		["CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE"] = true,		-- on Raid / Pet
	},
	["OnCombatStart"] = function(delay)
		LVBM.AddOns.Razuvious.OnEvent("StartNewDShoutTimer");
		LVBM.AddOns.Razuvious.Lastshout = GetTime();
		LVBM.StartRepeatingStatusBarTimer(25, "Disrupting Shout");
	end,
	["OnEvent"] = function(event, arg1)			
		if ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" or 				
			 event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE" or
			 event == "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE" ) then
			
			if( string.find(arg1, LVBM_IR_SPELL_1) )then
				if( LVBM.AddOns.Razuvious.Lastshout > 0 and math.floor(GetTime() - LVBM.AddOns.Razuvious.Lastshout) > 0 ) then
					LVBM.AddOns.Razuvious.InCombat = true;
					LVBM.AddMsg(LVBM_IR_TIMER_UPDATED);		-- To see that the Loop is Sync'd to the Shout
					
--					LVBM.AddMsg("Time since last D-Shout : ".. (time() - LVBM.AddOns.Razuvious.Lastshout) );
					LVBM.AddOns.Razuvious.OnEvent("StartNewDShoutTimer");
					LVBM.AddOns.Razuvious.Lastshout = GetTime();
					LVBM.EndRepeatingStatusBarTimer("Disrupting Shout");
					LVBM.StartRepeatingStatusBarTimer(25, "Disrupting Shout");
				else
					LVBM.AddOns.Razuvious.OnEvent("StartNewDShoutTimer");
					LVBM.AddOns.Razuvious.Lastshout = GetTime();
				end
			end
		end
			
		if (event == "StartNewDShoutTimer") then
			if (GetTime() - LVBM.AddOns.Razuvious.Lastshout) < 2  then return true; end	-- Don't need Spam
				
			LVBM.UnSchedule("LVBM.AddOns.Razuvious.OnEvent");			-- Don't need the Loop & Warnings
				
			if (GetTime() - LVBM.AddOns.Razuvious.LastAnnounce) > 4 then
				LVBM.Announce(string.format(LVBM_IR_SHOUT_WARNING, 25));		-- Callout Warning
				LVBM.AddOns.Razuvious.LastAnnounce = GetTime();
			end
			LVBM.Schedule(15, "LVBM.AddOns.Razuvious.OnEvent", "DShout10SecWarning");			-- Schedule Warnings
			LVBM.Schedule(20, "LVBM.AddOns.Razuvious.OnEvent", "DShout5SecWarning");
			LVBM.Schedule(22, "LVBM.AddOns.Razuvious.OnEvent", "DShout3SecWarning");
				
			LVBM.AddOns.Razuvious.OnLoop = true;
		elseif (event == "DShout10SecWarning") and LVBM.AddOns.Razuvious.Options["10SecWarning"] then
			LVBM.Announce(string.format(LVBM_IR_SHOUT_WARNING, 10));
			
		elseif (event == "DShout5SecWarning") then
			LVBM.Announce(string.format(LVBM_IR_SHOUT_WARNING, 5));
			
		elseif (event == "DShout3SecWarning") then
--			LVBM.Announce("*** Disrupting Shout in 3 Sec ***", "RAID_WARNING");
			
			LVBM.Schedule(4, "LVBM.AddOns.Razuvious.OnEvent", "StartNewDShoutTimer");			-- Schedule Loop
		end
	end,
}
