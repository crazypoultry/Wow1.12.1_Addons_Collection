LVBM.AddOns.Vaelastrasz = {
	["Name"] = LVBM_VAEL_NAME,
	["Abbreviation1"] = "vael",
	["Version"] = "1.0",
	["Author"] = "Tandanu",
	["Description"] = LVBM_VAEL_DESCRIPTION,
	["Instance"] = LVBM_BWL,
	["GUITab"] = LVBMGUI_TAB_BWL,
	["Sort"] = 2,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
		["Whisper"] = false,
		["SetIcon"] = true,
	},
	["DropdownMenu"] = {
		[1] = {
			["variable"] = "LVBM.AddOns.Vaelastrasz.Options.Whisper",
			["text"] = LVBM_VAEL_SEND_WHISPER,
			["func"] = function() LVBM.AddOns.Vaelastrasz.Options.Whisper = not LVBM.AddOns.Vaelastrasz.Options.Whisper; end,
		},
		[2] = {
			["variable"] = "LVBM.AddOns.Vaelastrasz.Options.SetIcon",
			["text"] = LVBM_VAEL_SET_ICON,
			["func"] = function() LVBM.AddOns.Vaelastrasz.Options.SetIcon = not LVBM.AddOns.Vaelastrasz.Options.SetIcon; end,
		},
	},
	["Events"] = {
		["CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"] = true,
		["CHAT_MSG_SPELL_AURA_GONE_OTHER"] = true,
		["CHAT_MSG_SPELL_AURA_GONE_SELF"] = true,
	},	
	["OnCombatEnd"] = function()
		if( LVBM.AddOns.Vaelastrasz.Options.SetIcon ) then
			LVBM.CleanUp();
		end
	end,		
	["OnEvent"] = function(event, arg1)
		if event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" 
		or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" 
		or event ==  "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" then	

			local _, _, name = string.find(arg1, LVBM_VAEL_BA_REGEXP);
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
				if targetID and LVBM.Rank >= 1 and LVBM.AddOns.Vaelastrasz.Options.SetIcon then
					if GetRaidTargetIndex("raid"..targetID) ~= 8 then
						SetRaidTargetIcon("raid"..targetID, 8);
					end
				end	
					
				LVBM.Announce(string.format(LVBM_VAEL_BA_WARNING, name));
				if name == UnitName("player") then
					LVBM.AddSpecialWarning(LVBM_VAEL_BA, true, true);
				else
					if LVBM.AddOns.Vaelastrasz.Options.Whisper then
						LVBM.SendHiddenWhisper(LVBM_VAEL_BA_WHISPER, name);
					end
				end
			end
			
		elseif ((event == "CHAT_MSG_SPELL_AURA_GONE_OTHER") or (event == "CHAT_MSG_SPELL_AURA_GONE_SELF")) and arg1 then
			local name;
			_, _, name = string.find(arg1, LVBM_VAEL_BA_FADES_REGEXP);
			if Name then
				local targetID;
				for i = 1, GetNumRaidMembers() do
					if UnitName("raid"..i) == name then
						targetID = i;
						break;
					end
				end	
				if targetID and LVBM.Rank >= 1 then
					if GetRaidTargetIndex("raid"..targetID) == 8 and LVBM.AddOns.Vaelastrasz.Options.SetIcon then
						SetRaidTargetIcon("raid"..targetID, 0);
					end
				end	
			end			
		end
	end,
};
