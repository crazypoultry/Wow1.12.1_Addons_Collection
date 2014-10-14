LVBM.AddOns.Huhuran = {
	["Name"] = LVBM_HUHURAN_NAME,
	["Abbreviation1"] = "Huhuran",
	["Abbreviation2"] = "Huhu",
	["Version"] = "1.0",
	["Author"] = "Tandanu",
	["Description"] = LVBM_HUHURAN_DESCRIPTION,
	["Instance"] = LVBM_AQ40,
	["GUITab"] = LVBMGUI_TAB_AQ40,
	["Sort"] = 5,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
		["Frenzy"] = true,
	},
	["WyvernSting"] = false,
	["DropdownMenu"] = {
		[1] = {
			["variable"] = "LVBM.AddOns.Huhuran.Options.Frenzy",
			["text"] = LVBM_HUHURAN_ANNOUNCE_FRENZY,
			["func"] = function() LVBM.AddOns.Huhuran.Options.Frenzy = not LVBM.AddOns.Huhuran.Options.Frenzy; end,
		},
	},
	["Events"] = {
		["CHAT_MSG_MONSTER_EMOTE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE"] = true,
	},	
	
	["OnEvent"] = function(event, arg1)	
		if event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" then
			if (string.find(arg1, LVBM_HUHURAN_WYVERN_REGEXP) and (not LVBM.AddOns.Huhuran.WyvernSting)) then
				LVBM.Schedule(20, "LVBM.AddOns.Huhuran.OnEvent", "WyvernStingWarning", 5);
				LVBM.StartStatusBarTimer(25, "Wyvern Sting Cooldown");
				LVBM.AddOns.Huhuran.WyvernSting = true;
				LVBM.Schedule(15, "LVBM.AddOns.Huhuran.OnEvent", "ResetWyvernSting"); 
			end         
		elseif event == "ResetWyvernSting"  then
			LVBM.AddOns.Huhuran.WyvernSting = false;			
		elseif event == "WyvernStingWarning" then
			if arg1 == 5 then
				LVBM.Announce(LVBM_HUHURAN_WYVERN_WARNING);
			end
		elseif (event == "CHAT_MSG_MONSTER_EMOTE") then
			if (arg2 == LVBM_HUHURAN_HUHURAN) and (arg1 == LVBM_HUHURAN_FRENZY) then
				if (LVBM.AddOns.Huhuran.Options.Frenzy) then
					LVBM.Announce(LVBM_HUHURAN_FRENZY_ANNOUNCE);
				end
			end		
		end
   end,   
};
