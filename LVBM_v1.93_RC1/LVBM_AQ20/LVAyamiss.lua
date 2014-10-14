-- 
-- Ayamiss the Hunter Beta v0.1
--

LVBM.AddOns.Ayamiss = { 
	["Name"] = LVBM_AYAMISS_NAME,
	["Abbreviation1"] = "Ayamiss", 
	["Version"] = "0.1",
	["Author"] = "La Vendetta|Nitram",
	["Description"] = LVBM_AYAMISS_INFO,
	["Instance"] = LVBM_AQ20,
	["GUITab"] = LVBMGUI_TAB_20PL,
	["Options"] = {  
		["Enabled"] = true,
		["Announce"] = false,
	},
	["Sort"] = 15,
	["Events"] = {
		["CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE"] = true,
	},	
	["OnEvent"] = function(event, arg1) 
			local _, _, sArg1, sArg2 = string.find(arg1, LVBM_AYAMISS_SACRIFICE_EXPR);
		
			if ( sArg1 and sArg2 ) then
				if ( sArg1 == LVBM_YOU and sArg2 == LVBM_ARE ) then
					sArg1 = UnitName("player");
				end
			
				LVBM.Announce( string.format(LVBM_AYAMISS_SACRIFICE_ANNOUNCE, sArg1) );
			end
	end,		
};
