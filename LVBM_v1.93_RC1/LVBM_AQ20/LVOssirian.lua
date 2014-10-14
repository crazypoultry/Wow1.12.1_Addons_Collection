-- 
-- Ossirian the Unscarred v1.0
--

LVBM.AddOns.Ossirian = { 
	["Name"] = LVBM_OSSIRIAN_NAME,
	["Abbreviation1"] = "Ossirian", 
	["Version"] = "1.0",
	["Author"] = "La Vendetta|Nitram",
	["Description"] = LVBM_OSSIRIAN_INFO,
	["Instance"] = LVBM_AQ20,
	["GUITab"] = LVBMGUI_TAB_20PL,
	["Options"] = {  
		["Enabled"] = true,
		["Announce"] = false,
		["AnnounceCurse"] = false,
	},
	["DropdownMenu"] = {
		[1] = {
			["variable"] = "LVBM.AddOns.Ossirian.Options.AnnounceCurse",
			["text"] = LVBM_OSSIRIAN_CURSE_INFO,
			["func"] = function() LVBM.AddOns.Ossirian.Options.AnnounceCurse = not LVBM.AddOns.Ossirian.Options.AnnounceCurse; end,
		},
	},
	["Sort"] = 16,
	["LastCurse"] = 0,
	["Events"] = {
		["CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS"] = true,
		["CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE"] = true,
		["CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE"] = true,
		["CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE"] = true,
		["CHAT_MSG_MONSTER_YELL"] = true,
	},	
	["OnEvent"] = function(event, arg1) 

		-- Announce Curse of Ossirian
		if ((time() - LVBM.AddOns.Ossirian.LastCurse) > 10
		    and arg1 ~= nil
		    and string.find(arg1,LVBM_OSSIRIAN_CURSE_EXPR) ) then

				LVBM.AddOns.Ossirian.LastCurse = time();
		    		if( LVBM.AddOns.Ossirian.Options.AnnounceCurse ) then
					LVBM.Announce( LVBM_OSSIRIAN_CURSE_ANNOUNCE );
					LVBM.Schedule(18, "LVBM.AddOns.Ossirian.OnEvent", "CurseWarning5");
				end
			
				LVBM.EndStatusBarTimer("Ossirians Curse");
				LVBM.StartStatusBarTimer(23, "Ossirians Curse");

		elseif( event == "CurseWarning5" and LVBM.AddOns.Ossirian.Options.AnnounceCurse ) then
			LVBM.Announce( LVBM_OSSIRIAN_CURSE_PREANNOUNCE );
		end
				
		-- Announce vulnerability
		if ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE" ) then
			local _, _, sArg1 = string.find(arg1, LVBM_OSSIRIAN_WEAK_EXPR);
		
			if ( sArg1 ) and ( sArg ~= "Expose" ) then
				LVBM.Announce( string.format(LVBM_OSSIRIAN_WEAK_ANNOUNCE, sArg1) );
				LVBM.UnSchedule("LVBM.AddOns.Ossirian.OnEvent", "Supreme25");
				LVBM.UnSchedule("LVBM.AddOns.Ossirian.OnEvent", "Supreme15");
				LVBM.UnSchedule("LVBM.AddOns.Ossirian.OnEvent", "Supreme10");
				LVBM.Schedule(20, "LVBM.AddOns.Ossirian.OnEvent", "Supreme25");
				LVBM.Schedule(30, "LVBM.AddOns.Ossirian.OnEvent", "Supreme15");
				LVBM.Schedule(35, "LVBM.AddOns.Ossirian.OnEvent", "Supreme10");
				
				if sArg1 == "Arkan" then sArg1 = "Arcane"; --you may _never_ use localized strings to start status bars...use the LVBM_SBT table to localize status bar strings!
				elseif sArg1 == "Feuer" then sArg1 = "Fire";
				elseif sArg1 == "Frost" then sArg1 = "Frost";
				elseif sArg1 == "Natur" then sArg1 = "Nature";
				elseif sArg1 == "Schatten" then sArg1 = "Shadow";
				end
				
				LVBM.EndStatusBarTimer(sArg1.." vulnerability");
				LVBM.StartStatusBarTimer(45, sArg1.." vulnerability");
			end
		elseif( event == "Supreme25" ) then	LVBM.Announce( string.format(LVBM_OSSIRIAN_WEAK_RUNOUT, 25) );
		elseif( event == "Supreme15" ) then	LVBM.Announce( string.format(LVBM_OSSIRIAN_WEAK_RUNOUT, 15) );
		elseif( event == "Supreme10" ) then	LVBM.Announce( string.format(LVBM_OSSIRIAN_WEAK_RUNOUT, 10) );
		end

		-- Supreme Mode warning
		if ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" and arg1 == LVBM_OSSIRIAN_SUPREME_EXPR) then
			LVBM.Announce( LVBM_OSSIRIAN_SUPREME_ANNOUNCE );

			LVBM.UnSchedule("LVBM.AddOns.Ossirian.OnEvent", "Supreme25");
			LVBM.UnSchedule("LVBM.AddOns.Ossirian.OnEvent", "Supreme15");
			LVBM.UnSchedule("LVBM.AddOns.Ossirian.OnEvent", "Supreme10");
			LVBM.EndStatusBarTimer("Ossirians weakening");
		end
	
		-- Ossirian dies
		if ( event == "CHAT_MSG_MONSTER_YELL" and arg1 == LVBM_OSSIRIAN_DEATH_EXPR ) then
			LVBM.UnSchedule("LVBM.AddOns.Ossirian.OnEvent");
			LVBM.EndStatusBarTimer("Ossirians weakening");
			LVBM.EndStatusBarTimer("Ossirians Curse");
		end

	end,		
};
