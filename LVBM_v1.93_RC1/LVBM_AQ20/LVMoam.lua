-- 
-- Moam Beta v1.0
--

LVBM.AddOns.Moam = { 
	["Name"] = LVBM_MOAM_NAME,
	["Abbreviation1"] = "Moam", 
	["Version"] = "1.0",
	["Author"] = "La Vendetta|Nitram",
	["Description"] = LVBM_MOAM_INFO,
	["Instance"] = LVBM_AQ20,
	["GUITab"] = LVBMGUI_TAB_20PL,
	["Options"] = {  
		["Enabled"] = true,
		["Announce"] = false,
	},
	["Sort"] = 13,
	["Events"] = {
		["CHAT_MSG_MONSTER_EMOTE"] = true,
		["CHAT_MSG_SPELL_AURA_GONE_OTHER"] = true,
	},	
	["OnEvent"] = function(event, arg1) 

		-- Combatstart - until Stone form
		if (event == "CHAT_MSG_MONSTER_EMOTE" and arg1 == LVBM_MOAM_COMBAT_START )  then
			LVBM.Announce( string.format(LVBM_MOAM_STONE_ANNOUNCE_TIME, 90) );

			LVBM.EndStatusBarTimer("Stone form");
			LVBM.StartStatusBarTimer(90, "Stone form");
		
			LVBM.Schedule(30, "LVBM.AddOns.Moam.OnEvent", "StoneWarning", 60);
			LVBM.Schedule(60, "LVBM.AddOns.Moam.OnEvent", "StoneWarning", 30);
			LVBM.Schedule(80, "LVBM.AddOns.Moam.OnEvent", "StoneWarning", 10);

		elseif ( event == "StoneWarning" ) then
			if arg1 then
				LVBM.Announce( string.format(LVBM_MOAM_STONE_ANNOUNCE_TIME, arg1) );	
			end
		end

		-- Gain Stoneform - until transform
		if (event == "CHAT_MSG_MONSTER_EMOTE" and arg1 == LVBM_MOAM_STONE_GAIN )  then
			LVBM.Announce( string.format(LVBM_MOAM_STONE_ANNOUNCE_FADE, 90) );

			LVBM.EndStatusBarTimer("Stone form");
			LVBM.StartStatusBarTimer(90, "Stone form");
		
			LVBM.Schedule(30, "LVBM.AddOns.Moam.OnEvent", "StoneFadeWarning", 60);
			LVBM.Schedule(60, "LVBM.AddOns.Moam.OnEvent", "StoneFadeWarning", 30);
			LVBM.Schedule(80, "LVBM.AddOns.Moam.OnEvent", "StoneFadeWarning", 10);

		elseif ( event == "StoneFadeWarning" ) then
			if arg1 then
				LVBM.Announce( string.format(LVBM_MOAM_STONE_ANNOUNCE_FADE, arg1) );	
			end
		end

		-- Stoneform Fades
		if ( event == "CHAT_MSG_SPELL_AURA_GONE_OTHER" and string.find(arg1, LVBM_MOAM_STONE_FADE_EXPR) ) then
			LVBM.UnSchedule("LVBM.AddOns.Moam.OnEvent");
			LVBM.Announce( LVBM_MOAM_STONE_FADE_ANNOUNCE );

		end
	end,		
};
