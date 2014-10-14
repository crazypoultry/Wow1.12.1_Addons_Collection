--
--	TwinEmps by Tandanu v1.0
--	modivied by Nitram to v1.1 with bug explode
--

LVBM.AddOns.TwinEmps = {
	["Name"] = LVBM_TWINEMPS_NAME,
	["Abbreviation1"] = "twins",
	["Abbreviation2"] = "twinemp",
	["Abbreviation3"] = "twin",
	["Version"] = "1.1",
	["Author"] = "Tandanu",
	["Description"] = LVBM_TWINEMPS_DESCRIPTION,
	["Instance"] = LVBM_AQ40,
	["GUITab"] = LVBMGUI_TAB_AQ40,
	["Sort"] = 6,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
	},
	["InCombat"] = false,
	["Events"] = {
		["CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS"] = true,
	},
	["OnCombatStart"] = function(delay)
		LVBM.Schedule(300 - delay, "LVBM.AddOns.TwinEmps.OnEvent", "EnrageWarning", 10)
		LVBM.Schedule(600 - delay, "LVBM.AddOns.TwinEmps.OnEvent", "EnrageWarning", 5)
		LVBM.Schedule(840 - delay, "LVBM.AddOns.TwinEmps.OnEvent", "EnrageWarning", 1)
		LVBM.Schedule(870 - delay, "LVBM.AddOns.TwinEmps.OnEvent", "EnrageWarning", 0.5)
		LVBM.StartStatusBarTimer(900 - delay, "Enrage");
		
		LVBM.StartStatusBarTimer(30 - delay, "Teleport");
		LVBM.Schedule(20 - delay, "LVBM.AddOns.TwinEmps.OnEvent", "TeleportWarning", 10);
		LVBM.Schedule(25 - delay, "LVBM.AddOns.TwinEmps.OnEvent", "TeleportWarning", 5);
	end,
	["OnEvent"] = function(event, arg1)	
		if ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" and string.find(arg1, LVBM_TWINEMPS_EXPLODE_EXPR) ) then
			LVBM.AddSpecialWarning(LVBM_TWINEMPS_EXPLODE_ANNOUNCE);
		elseif event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" then -- mob casts a spell
			if (arg1 == LVBM_TWINEMPS_CAST_SPELL_1) or (arg1 == LVBM_TWINEMPS_CAST_SPELL_2) then
				LVBM.Announce(LVBM_TWINEMPS_TELEPORT_ANNOUNCE);
				LVBM.EndStatusBarTimer("Teleport");
				LVBM.StartStatusBarTimer(30, "Teleport");
				LVBM.Schedule(20, "LVBM.AddOns.TwinEmps.OnEvent", "TeleportWarning", 10);
				LVBM.Schedule(25, "LVBM.AddOns.TwinEmps.OnEvent", "TeleportWarning", 5);
			end
		elseif event == "TeleportWarning" then
			if arg1 then
				LVBM.Announce(string.format(LVBM_TWINEMPS_TELEPORT_WARNING, arg1));
			end
		elseif event == "EnrageWarning" then
			if arg1 and arg1 >= 1 then
				LVBM.Announce(string.format(LVBM_TWINEMPS_ENRAGE_WARNING, arg1, LVBM_MIN));
			elseif arg1 == 0.5 then
				LVBM.Announce(string.format(LVBM_TWINEMPS_ENRAGE_WARNING, 30, LVBM_SEC));
			end
		end
	end,
};
