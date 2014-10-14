LVBM.AddOns.Ebonroc = {
	["Name"] = LVBM_EBONROC_NAME,
	["Abbreviation1"] = "ebon",
	["Version"] = "1.0",
	["Author"] = "Tandanu",
	["Description"] = LVBM_EBONROC_DESCRIPTION,
	["Instance"] = LVBM_BWL,
	["GUITab"] = LVBMGUI_TAB_BWL,
	["Sort"] = 5,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
		["SetIcon"] = true,
	},
	["DropdownMenu"] = {	
		[1] = {
			["variable"] = "LVBM.AddOns.Ebonroc.Options.SetIcon",
			["text"] = LVBM_EBONROC_SET_ICON,
			["func"] = function() LVBM.AddOns.Ebonroc.Options.SetIcon = not LVBM.AddOns.Ebonroc.Options.SetIcon; end,
		},
	},
	["Events"] = {
		["CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"] = true,
		["CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE"] = true,
		["CHAT_MSG_SPELL_AURA_GONE_OTHER"] = true,
		["CHAT_MSG_SPELL_AURA_GONE_SELF"] = true,
	},	
	["OnCombatStart"] = function(delay)
		LVBM.StartStatusBarTimer(31 - delay, "Wing Buffet");
		LVBM.Schedule(28 - delay, "LVBM.AddOns.Ebonroc.OnEvent", "WingBuffetWarning", 3);
	end,
	["OnCombatEnd"] = function()
		if( LVBM.AddOns.Ebonroc.Options.SetIcon ) then
			LVBM.CleanUp();
		end
	end,
	["OnEvent"] = function(event, arg1)
		if event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" then
			if arg1 == LVBM_EBONROC_WING_BUFFET then
				LVBM.Announce(string.format(LVBM_WING_BUFFET_WARNING, 1));
				LVBM.StartStatusBarTimer(1, "Wing Buffet Cast");
				LVBM.Schedule(29, "LVBM.AddOns.Ebonroc.OnEvent", "WingBuffetWarning", 3);
				LVBM.Schedule(1, "LVBM.AddOns.Ebonroc.OnEvent", "WingBuffetWarning", 31);
			elseif arg1 == LVBM_EBONROC_SHADOW_FLAME then
				LVBM.Announce(LVBM_SHADOW_FLAME_WARNING);
				LVBM.StartStatusBarTimer(2, "Shadow Flame Cast");
			end
			
		elseif event == "WingBuffetWarning" then
			if arg1 == 3 then
				LVBM.Announce(string.format(LVBM_WING_BUFFET_WARNING, 3));
			elseif arg1 == 31 then
				LVBM.EndStatusBarTimer("Wing Buffet");
				LVBM.StartStatusBarTimer(31, "Wing Buffet");
			end
			
		elseif event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" then
			local _, _, name = string.find(arg1, LVBM_EBONROC_SHADOW_REGEXP);
			if name == LVBM_YOU then
				name = UnitName("player");
			end		
			
			if name then
				local targetID;
				for i = 1, GetNumRaidMembers() do
					if UnitName("raid"..i) == name then
						targetID = i;
						break;
					end
				end
				if targetID and LVBM.Rank >= 1 and LVBM.AddOns.Ebonroc.Options.SetIcon then
					if GetRaidTargetIndex("raid"..targetID) ~= 8 then
						SetRaidTargetIcon("raid"..targetID, 8);
					end
				end	
					
				LVBM.Announce(string.format(LVBM_EBONROC_SHADOW_WARNING, name));
			end
		elseif ((event == "CHAT_MSG_SPELL_AURA_GONE_OTHER") or (event == "CHAT_MSG_SPELL_AURA_GONE_SELF")) and arg1 then
			local name;
			_, _, name = string.find(arg1, LVBM_EBONROC_SHADOW_REGEXP2);
			if Name then
				local targetID;
				for i = 1, GetNumRaidMembers() do
					if UnitName("raid"..i) == name then
						targetID = i;
						break;
					end
				end	
				if targetID and LVBM.Rank >= 1 and LVBM.AddOns.Ebonroc.Options.SetIcon then
					if GetRaidTargetIndex("raid"..targetID) == 8 then
						SetRaidTargetIcon("raid"..targetID, 0);
					end
				end	
			end
		end
	end,
};
