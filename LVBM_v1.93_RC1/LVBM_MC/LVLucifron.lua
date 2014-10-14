LVBM.AddOns.Lucifron = { 
	["Name"] = LVBM_LUCIFRON_NAME,
	["Abbreviation1"] = "Luci", 
	["Version"] = "1.0",
	["Author"] = "La Vendetta|Nitram",
	["Description"] = LVBM_LUCIFRON_INFO,
	["Instance"] = LVBM_MC,
	["GUITab"] = LVBMGUI_TAB_MC,
	["Sort"] = 1,
	["Curse"] = false,
	["Doom"] = false,
	["Options"] = {  
		["Enabled"] = true,
		["Announce"] = false,
	},
	["Events"] = {
		["CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"] = true,
	},	
	["OnEvent"] = function(event, arg1)
		if ( event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" ) then
			if ( string.find(arg1, LVBM_LUCIFRON_CURSE_REGEXP) ) and not LVBM.AddOns.Lucifron.Curse then
				LVBM.AddOns.Lucifron.Curse = true;
				LVBM.Announce(LVBM_LUCIFRON_CURSE_WARNING);
				LVBM.Schedule(15, "LVBM.AddOns.Lucifron.OnEvent", "CurseWarning", 5);
				LVBM.EndStatusBarTimer("Curse");
				LVBM.StartStatusBarTimer(20, "Curse");
			elseif ( string.find(arg1, LVBM_LUCIFRON_DOOM_REGEXP) ) and not LVBM.AddOns.Lucifron.Doom then
				LVBM.AddOns.Lucifron.Doom = true;
				LVBM.Announce(LVBM_LUCIFRON_DOOM_WARNING);
				LVBM.Schedule(15, "LVBM.AddOns.Lucifron.OnEvent", "DoomWarning", 5);
				LVBM.EndStatusBarTimer("Impending Doom");
				LVBM.StartStatusBarTimer(20, "Impending Doom");
			end
		elseif (event == "CurseWarning") then
			if arg1 then
				LVBM.Announce(string.format(LVBM_LUCIFRON_CURSE_SOON_WARNING, arg1));
				LVBM.AddOns.Lucifron.Curse = false;
			end
		elseif (event == "DoomWarning") then
			if arg1 then
				LVBM.Announce(string.format(LVBM_LUCIFRON_DOOM_SOON_WARNING, arg1));
				LVBM.AddOns.Lucifron.Doom = false;
			end
		end
	end,		
};
