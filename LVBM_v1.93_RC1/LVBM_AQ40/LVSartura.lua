LVBM.AddOns.Sartura = {
	["Name"] = LVBM_SARTURA_NAME,
	["Abbreviation1"] = "Sartura",
	["Version"] = "1.5",
	["Author"] = "Tandanu",
	["Description"] = LVBM_SARTURA_DESCRIPTION,
	["Instance"] = LVBM_AQ40,
	["GUITab"] = LVBMGUI_TAB_AQ40,
	["Sort"] = 3,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
	},	
	["Events"] = {
		["CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS"] = true,
		["CHAT_MSG_SPELL_AURA_GONE_OTHER"] = true,
		["CHAT_MSG_MONSTER_EMOTE"] = true,		
	},
	["OnEvent"] = function(event, arg1)
		if (event == "CHAT_MSG_MONSTER_EMOTE") then
			if (string.find(string.lower(arg1), string.lower(LVBM_SARTURA_ENRAGE))) and (arg2 == LVBM_SARTURA_SARTURA) then
				LVBM.Announce("*** Enrage ***");
			end
		elseif (event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS") or (event == "CHAT_MSG_SPELL_AURA_GONE_OTHER") then
			if (arg1 == LVBM_SARTURA_GAIN_WHIRLWIND) then
				LVBM.Announce(LVBM_SARTURA_ANNOUNCE_WHIRLWIND);
				LVBM.StartStatusBarTimer(15, "Whirlwind");
			elseif (arg1 == LVBM_SARTURA_WHIRLWIND_FADES) then		
				LVBM.Announce(LVBM_SARTURA_WHIRLWIND_FADED);				
			end
		end
	end,
};
