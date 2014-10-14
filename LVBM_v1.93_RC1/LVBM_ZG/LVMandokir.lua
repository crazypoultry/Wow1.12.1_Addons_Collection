-- 
-- Broodlord Mandokir v1.0
--

LVBM.AddOns.Mandokir = { 
	["Name"] = LVBM_MANDOKIR_NAME,
	["Abbreviation1"] = "Mandokir", 
	["Version"] = "1.0",
	["Author"] = "La Vendetta|Nitram",
	["Description"] = LVBM_MANDOKIR_INFO,
	["Instance"] = LVBM_ZG,
	["GUITab"] = LVBMGUI_TAB_20PL,
	["Options"] = {  
		["Enabled"] = true,
		["Announce"] = false,
		["Wisper"] = false,
		["SetIcon"] = true,
	},
	["DropdownMenu"] = {
		[1] = {
			["variable"] = "LVBM.AddOns.Mandokir.Options.Whisper",
			["text"] = LVBM_MANDOKIR_WHISPER_INFO,
			["func"] = function() LVBM.AddOns.Mandokir.Options.Whisper = not LVBM.AddOns.Mandokir.Options.Whisper; end,
		},
		[2] = {
			["variable"] = "LVBM.AddOns.Mandokir.Options.SetIcon",
			["text"] = LVBM_MANDOKIR_SETICON_INFO,
			["func"] = function() LVBM.AddOns.Mandokir.Options.SetIcon = not LVBM.AddOns.Mandokir.Options.SetIcon; end,
		},
	},
	["Sort"] = 4,
	["Events"] = {
		["CHAT_MSG_MONSTER_YELL"] = true,
	},	
	["OnEvent"] = function(event, arg1) 
		if ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, LVBM_MANDOKIR_WATCH_EXPR) ) then
			local _, _, sArg1 = string.find(arg1, LVBM_MANDOKIR_WATCH_EXPR);
			if ( sArg1 ) then
				if ( sArg1 == UnitName("player") ) then
					LVBM.AddSpecialWarning(LVBM_MANDOKIR_SELFWARN);
					sArg1 = UnitName("player");

				else
					if LVBM.AddOns.Mandokir.Options.Whisper then
						LVBM.SendHiddenWhisper(LVBM_MANDOKIR_WHISPER_TEXT, sArg1);
					end
				end

				if LVBM.AddOns.Mandokir.Options.SetIcon then
					local targetID;
					for i = 1, GetNumRaidMembers() do
						if UnitName("raid"..i) == sArg1 then
							targetID = i;
							break;
						end
					end
					if targetID and LVBM.Rank >= 1 then
						if GetRaidTargetIndex("raid"..targetID) ~= 8 then
							SetRaidTargetIcon("raid"..targetID, 8);
						end
					end	
				end
				LVBM.Announce(string.format(LVBM_MANDOKIR_WATCH_ANNOUNCE, sArg1));
			end
		end
	end,		
};
