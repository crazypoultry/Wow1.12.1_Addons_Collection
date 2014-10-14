LVBM.AddOns.Magmadar = { 
	["Name"] = LVBM_MAGMADAR_NAME,
	["Abbreviation1"] = "Magma", 
	["Version"] = "1.0",
	["Author"] = "La Vendetta|Nitram",
	["Description"] = LVBM_MAGMADAR_INFO,
	["Instance"] = LVBM_MC,
	["GUITab"] = LVBMGUI_TAB_MC,
	["Sort"] = 2,
	["Options"] = {  
		["Enabled"] = true,
		["Announce"] = false,
		["Frenzy"] = true,
	},
	["Fearing"] = false,
	["DropdownMenu"] = {
		[1] = {
			["variable"] = "LVBM.AddOns.Magmadar.Options.Frenzy",
			["text"] = LVBM_MAGMADAR_ANNOUNCE_FRENZY,
			["func"] = function() LVBM.AddOns.Magmadar.Options.Frenzy = not LVBM.AddOns.Magmadar.Options.Frenzy; end,
		},
	},
	["Events"] = {
		["CHAT_MSG_MONSTER_EMOTE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE"] = true,
	},	
	["OnEvent"] = function(event, arg1) 
		if ( (event == "CHAT_MSG_MONSTER_EMOTE") and ( arg1 == LVBM_MAGMADAR_FRENZY ) and ( arg2 == LVBM_MAGMADAR_NAME ) ) then
			LVBM.EndStatusBarTimer("Frenzy")
			LVBM.StartStatusBarTimer(10, "Frenzy");
			if LVBM.AddOns.Magmadar.Options.Frenzy then
				LVBM.Announce(LVBM_MAGMADAR_FRENZY_WARNING);
			end
		elseif ( event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" ) then
			if ( string.find(arg1, LVBM_MAGMADAR_FEAR) ) and not LVBM.AddOns.Magmadar.Fearing then
				LVBM.AddOns.Magmadar.Fearing = true;
				LVBM.Announce(LVBM_MAGMADAR_FEAR_WARNING1);
				LVBM.Schedule(25, "LVBM.AddOns.Magmadar.OnEvent", "FearWarning");
				LVBM.EndStatusBarTimer("Fear");
				LVBM.StartStatusBarTimer(30, "Fear");
			end
		elseif (event == "FearWarning") then
			LVBM.Announce(LVBM_MAGMADAR_FEAR_WARNING2);
			LVBM.AddOns.Magmadar.Fearing = false;
		end
	end,		
};
