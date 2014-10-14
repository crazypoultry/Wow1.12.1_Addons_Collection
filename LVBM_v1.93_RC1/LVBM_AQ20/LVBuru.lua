-- 
-- Buru the Gorger Beta v1.0
--

LVBM.AddOns.Buru = { 
	["Name"] = LVBM_BURU_NAME,
	["Abbreviation1"] = "Buru", 
	["Version"] = "1.0",
	["Author"] = "La Vendetta|Nitram",
	["Description"] = LVBM_BURU_INFO,
	["Instance"] = LVBM_AQ20,
	["GUITab"] = LVBMGUI_TAB_20PL,
	["Options"] = {  
		["Enabled"] = true,
		["Announce"] = false,
		["Whisper"] = false,
		["SetIcon"] = false,
	},
	["DropdownMenu"] = {
		[1] = {
			["variable"] = "LVBM.AddOns.Buru.Options.Whisper",
			["text"] = LVBM_BURU_WHISPER_INFO,
			["func"] = function() LVBM.AddOns.Buru.Options.Whisper = not LVBM.AddOns.Buru.Options.Whisper; end,
		},
		[2] = {
			["variable"] = "LVBM.AddOns.Buru.Options.SetIcon",
			["text"] = LVBM_BURU_SETICON_INFO,
			["func"] = function() LVBM.AddOns.Buru.Options.SetIcon = not LVBM.AddOns.Buru.Options.SetIcon; end,
		},
	},
	["Sort"] = 14,
	["Events"] = {
		["CHAT_MSG_MONSTER_EMOTE"] = true,
	},	
	["OnEvent"] = function(event, arg1) 

			local _, _, sArg1 = string.find(arg1, LVBM_BURU_EYE_EXPR);
			if ( sArg1 ) then
				
				if ( sArg1 == UnitName("player") ) then
					sArg1 = UnitName("player");
					LVBM.AddSpecialWarning(LVBM_BURU_EYE_SELFWARNING, true, true);
				end
				
				if LVBM.AddOns.Buru.Options.Whisper and sArg1 ~= UnitName("player") then
					LVBM.SendHiddenWhisper(LVBM_BURU_WHISPER_TEXT, sArg1);
				end

				if LVBM.AddOns.Buru.Options.SetIcon then
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

				LVBM.Announce( string.format(LVBM_BURU_EYE_ANNOUNCE, sArg1) );
			end
	end,		
};
