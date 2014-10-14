-- 
-- Hakkar v1.1
--

LVBM.AddOns.Hakkar = { 
	["Name"] = LVBM_HAKKAR_NAME,
	["Abbreviation1"] = "Hakkar", 
	["Version"] = "1.1",
	["Author"] = "La Vendetta|Nitram",
	["Description"] = LVBM_HAKKAR_INFO,
	["Instance"] = LVBM_ZG,
	["GUITab"] = LVBMGUI_TAB_20PL,
	["Options"] = {  
		["Enabled"] = true,
		["Announce"] = false,
	},
	["Sort"] = 8,
	["LastSuffer"] = 0,		-- prevent Spam (16 Targets == 16 Event calls)
	["Events"] = {
		["CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE"] = true,
--		["CHAT_MSG_MONSTER_YELL"] = true,
	},
	["OnCombatStart"] = function(delay)
		LVBM.StartStatusBarTimer(90-delay, "Life Drain");
		LVBM.Schedule(45-delay, "LVBM.AddOns.Hakkar.OnEvent", "Warning45");
		LVBM.Schedule(75-delay, "LVBM.AddOns.Hakkar.OnEvent", "Warning15");
	end,
	["OnCombatEnd"] = function()
		LVBM.AddOns.Hakkar.LastSuffer = 0;
		LVBM.EndStatusBarTimer("Life Drain");
		LVBM.UnSchedule("LVBM.AddOns.Hakkar.OnEvent");
	end,
	["OnEvent"] = function(event, arg1) 
--[[		if ( event == "CHAT_MSG_MONSTER_YELL" and arg1 == LVBM_HAKKAR_COMBAT_START_YELL) then
			LVBM.AddOns.Hakkar.LastSuffer = time();
			LVBM.EndStatusBarTimer("Life Drain");
			LVBM.StartStatusBarTimer(90, "Life Drain");
			LVBM.Schedule(45, "LVBM.AddOns.Hakkar.OnEvent", "Warning45");
			LVBM.Schedule(75, "LVBM.AddOns.Hakkar.OnEvent", "Warning15");
			LVBM.Announce( string.format(LVBM_HAKKAR_SUFFERLIFE_ANNOUNCE, 90) );
		else
]]
		if ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE" ) then
			local _, _, sArg1, sArg2 = string.find(arg1, LVBM_HAKKAR_SUFFERLIFE_EXPR);
			if ( sArg1 and sArg2 and (time() - LVBM.AddOns.Hakkar.LastSuffer) > 10 ) then
				LVBM.AddOns.Hakkar.LastSuffer = time();

				LVBM.Announce(LVBM_HAKKAR_SUFFERLIFE_NOW);
		
				LVBM.EndStatusBarTimer("Life Drain");
				LVBM.StartStatusBarTimer(90, "Life Drain");

				LVBM.Schedule(45, "LVBM.AddOns.Hakkar.OnEvent", "Warning45");
				LVBM.Schedule(75, "LVBM.AddOns.Hakkar.OnEvent", "Warning15");
			end

		elseif ( event == "Warning45" ) then
			LVBM.Announce( string.format(LVBM_HAKKAR_SUFFERLIFE_ANNOUNCE, 45) );

		elseif ( event == "Warning15" ) then
			LVBM.Announce( string.format(LVBM_HAKKAR_SUFFERLIFE_ANNOUNCE, 15) );

		end

	end,		
};
