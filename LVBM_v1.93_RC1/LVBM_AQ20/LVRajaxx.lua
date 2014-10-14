-- 
-- General Rajaxx v1.0
--

LVBM.AddOns.Rajaxx = { 
	["Name"] = LVBM_RAJAXX_NAME,
	["Abbreviation1"] = "Rajaxx", 
	["Version"] = "1.0",
	["Author"] = "La Vendetta|Nitram",
	["Description"] = LVBM_RAJAXX_INFO,
	["Instance"] = LVBM_AQ20,
	["GUITab"] = LVBMGUI_TAB_20PL,
	["Options"] = {  
		["Enabled"] = true,
		["Announce"] = false,
	},
	["Sort"] = 12,
	["Events"] = {
		["CHAT_MSG_MONSTER_YELL"] = true,
	},	
	["OnEvent"] = function(event, arg1) 

		if ( event == "CHAT_MSG_MONSTER_YELL" ) then
			if (    string.find(arg1, LVBM_RAJAXX_WAVE1_EXPR)) then LVBM.Announce(string.format(LVBM_RAJAXX_WAVE_ANNOUNCE, 1));
				-- no yell @ wave 2 -.- we could count the mobs killed after wave 1....but....bah.
			elseif (string.find(arg1, LVBM_RAJAXX_WAVE3_EXPR)) then LVBM.Announce(string.format(LVBM_RAJAXX_WAVE_ANNOUNCE, 3));
			elseif (string.find(arg1, LVBM_RAJAXX_WAVE4_EXPR)) then LVBM.Announce(string.format(LVBM_RAJAXX_WAVE_ANNOUNCE, 4));
			elseif (string.find(arg1, LVBM_RAJAXX_WAVE5_EXPR)) then LVBM.Announce(string.format(LVBM_RAJAXX_WAVE_ANNOUNCE, 5));
			elseif (string.find(arg1, LVBM_RAJAXX_WAVE6_EXPR)) then LVBM.Announce(string.format(LVBM_RAJAXX_WAVE_ANNOUNCE, 6));
			elseif (string.find(arg1, LVBM_RAJAXX_WAVE7_EXPR)) then LVBM.Announce(string.format(LVBM_RAJAXX_WAVE_ANNOUNCE, 7));
			elseif (string.find(arg1, LVBM_RAJAXX_WAVE8_EXPR)) then LVBM.Announce(LVBM_RAJAXX_WAVE_RAJAXX);
			end

			local _, _, sArg1 = string.find(arg1, LVBM_RAJAXX_KILL_EXPR);
			if ( sArg1 ) then
				LVBM.Announce( string.format(LVBM_RAJAXX_KILL_ANNOUNCE, sArg1) );
			end
		end		
	end,		
};
