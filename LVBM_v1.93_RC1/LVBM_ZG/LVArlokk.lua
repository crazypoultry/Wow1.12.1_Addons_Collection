-- 
-- High Priestess Arlokk Beta v1.0
--

LVBM.AddOns.Arlokk = { 
	["Name"] = LVBM_ARLOKK_NAME,
	["Abbreviation1"] = "Arlokk", 
	["Version"] = "1.0",
	["Author"] = "La Vendetta|Nitram",
	["Description"] = LVBM_ARLOKK_INFO,
	["Instance"] = LVBM_ZG,
	["GUITab"] = LVBMGUI_TAB_20PL,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
		["Whisper"] = false,
	},
	["Sort"] = 6,
	["DropdownMenu"] = {
		[1] = {
			["variable"] = "LVBM.AddOns.Arlokk.Options.Whisper",
			["text"] = LVBM_ARLOKK_WHISPER_INFO,
			["func"] = function() LVBM.AddOns.Arlokk.Options.Whisper = not LVBM.AddOns.Arlokk.Options.Whisper; end,
		},
	},
	["Events"] = {
		["CHAT_MSG_MONSTER_YELL"] = true,
	},	
	["OnEvent"] = function(event, arg1) 
		if ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, LVBM_ARLOKK_MARK_EXPR) ) then
			local _, _, sArg1 = string.find(arg1, LVBM_ARLOKK_MARK_EXPR);
			if ( sArg1 ) then
				LVBM.Announce(string.format(LVBM_ARLOKK_MARK_ANNOUNCE, sArg1));
				if( LVBM.AddOns.Arlokk.Options.Whisper and sArg1 ~= UnitName("player") ) then
					LVBM.SendHiddenWhisper(LVBM_ARLOKK_MARK_WHISPER, sArg1);
				end
			end
		end
	end,		
};
