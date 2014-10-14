LVBM.AddOns.Gehennas = { 
	["Name"] = LVBM_GEHENNAS_NAME,
	["Abbreviation1"] = "Gehennas", 
	["Version"] = "1.0",
	["Author"] = "La Vendetta|Nitram",
	["Description"] = LVBM_GEHENNAS_INFO,
	["Instance"] = LVBM_MC,
	["GUITab"] = LVBMGUI_TAB_MC,
	["Sort"] = 3,
	["isCasting"] = false,
	["Options"] = {  
		["Enabled"] = true,
		["Announce"] = false,
	},
	["Events"] = {
		["CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE"] = true,
	},	
	["OnEvent"] = function(event, arg1) 
		if ( event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" ) then
			if ( string.find(arg1, LVBM_GEHENNAS_CURSE_REGEXP) ) and not LVBM.AddOns.Gehennas.isCasting then
				LVBM.AddOns.Gehennas.isCasting = true;
				LVBM.Schedule(25, "LVBM.AddOns.Gehennas.OnEvent", "CurseWarning", 5);
				LVBM.EndStatusBarTimer("Curse");
				LVBM.StartStatusBarTimer(30, "Curse");
				LVBM.Announce(LVBM_GEHENNAS_CURSE_WARNING);
			end
		elseif (event == "CurseWarning") then
			if arg1 then
				LVBM.Announce(string.format(LVBM_GEHENNAS_CURSE_SOON_WARN, arg1));
				LVBM.AddOns.Gehennas.isCasting = false;
			end
		end
	end,		
};
