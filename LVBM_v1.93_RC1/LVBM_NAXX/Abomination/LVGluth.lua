LVBM.AddOns.Gluth = {
	["Name"] = LVBM_GLUTH_NAME,
	["Abbreviation1"] = "Glu",
	["Version"] = "1.3",
	["Author"] = "Tandanu",
	["Description"] = LVBM_GLUTH_DESCRIPTION,
	["Instance"] = LVBM_NAXX,
	["GUITab"] = LVBMGUI_TAB_NAXX,
	["Sort"] = 43,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
		["Frenzy"] = true,
	},
	["Decimated"] = false,
	["Fearing"] = 0,
	["DropdownMenu"] = {
		[1] = {
			["variable"] = "LVBM.AddOns.Gluth.Options.Frenzy",
			["text"] = LVBM_GLUTH_ANNOUNCE_FRENZY,
			["func"] = function() LVBM.AddOns.Gluth.Options.Frenzy = not LVBM.AddOns.Gluth.Options.Frenzy; end,
		},
	},
	["Events"] = {
		["CHAT_MSG_MONSTER_EMOTE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE"] = true,
		["CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE"] = true,
		["CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE"] = true,
		["CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE"] = true,
	},		
	["OnCombatStart"] = function(delay)
		LVBM.AddOns.Gluth.Decimated = false;
		LVBM.Announce(LVBM_GLUTH_DECIMATE_WARN1);
		LVBM.Schedule(50 - delay, "LVBM.AddOns.Gluth.OnEvent", "DecimateWarning", 60);
		LVBM.Schedule(90 - delay, "LVBM.AddOns.Gluth.OnEvent", "DecimateWarning", 20);				
		LVBM.Schedule(105 - delay, "LVBM.AddOns.Gluth.OnEvent", "DecimateWarning", 5);
		LVBM.EndStatusBarTimer("Decimate");
		LVBM.StartStatusBarTimer(110 - delay, "Decimate");
	end,
	["OnCombatEnd"] = function()
		LVBM.AddOns.Gluth.Decimated = false;
	end,
	["OnEvent"] = function(event, arg1)
		if (event == "CHAT_MSG_MONSTER_EMOTE") then
			if (arg2 == LVBM_GLUTH_GLUTH) and (arg1 == LVBM_GLUTH_FRENZY) then
				LVBM.EndStatusBarTimer("Frenzy")
				LVBM.StartStatusBarTimer(9, "Frenzy");
				if (LVBM.AddOns.Gluth.Options.Frenzy) then
					LVBM.Announce(LVBM_GLUTH_FRENZY_ANNOUNCE);
				end
			end		

		elseif event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" 
		    or event == "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE" 
		    or event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE" then

			if (not LVBM.AddOns.Gluth.Decimated) and string.find(arg1, LVBM_GLUTH_DECIMATE_REGEXP) then
				LVBM.AddOns.Gluth.Decimated = true;
				LVBM.Announce(LVBM_GLUTH_DECIMATE_WARN2);
				LVBM.UnSchedule("LVBM.AddOns.Gluth.OnEvent", "DecimateWarning", 5)
				LVBM.Schedule(10, "LVBM.AddOns.Gluth.OnEvent", "ResetDecimate");
				LVBM.Schedule(50, "LVBM.AddOns.Gluth.OnEvent", "DecimateWarning", 60);
				LVBM.Schedule(90, "LVBM.AddOns.Gluth.OnEvent", "DecimateWarning", 20);				
				LVBM.Schedule(105, "LVBM.AddOns.Gluth.OnEvent", "DecimateWarning", 5);
				LVBM.EndStatusBarTimer("Decimate");
				LVBM.StartStatusBarTimer(110, "Decimate");
			end					

		elseif (event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" 
		     or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" 
		     or event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE") then

			if string.find(arg1, LVBM_GLUTH_FEAR_REGEXP) and (time() - LVBM.AddOns.Gluth.Fearing) > 5 then
				LVBM.AddOns.Gluth.Fearing = time();
				LVBM.Announce(LVBM_GLUTH_FEAR_WARNING);
				LVBM.Schedule(15, "LVBM.AddOns.Gluth.OnEvent", "FearWarning", 5);
				LVBM.EndStatusBarTimer("Fear");
				LVBM.StartStatusBarTimer(20, "Fear");
			end	

		elseif (event == "DecimateWarning") then
			if arg1 == 60 then		LVBM.Announce(LVBM_GLUTH_DECIMATE_1MIN_WARNING);
			elseif arg1 == "soon" then	LVBM.Announce(LVBM_GLUTH_DECIMATE_SOON_WARNING);
			elseif arg1 then		LVBM.Announce(string.format(LVBM_GLUTH_DECIMATE_WARNING, arg1));
			end

		elseif (event == "ResetDecimate") then
			LVBM.AddOns.Gluth.Decimated = false;

		elseif (event == "FearWarning") then
			LVBM.Announce(LVBM_GLUTH_FEAR_5SEC_WARNING);
		end
	end,
};
