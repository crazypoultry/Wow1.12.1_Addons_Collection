-- 
-- High Priestess Jeklik v1.0
--

LVBM.AddOns.Jeklik = { 
	["Name"] = LVBM_JEKLIK_NAME,
	["Abbreviation1"] = "Jeklik", 
	["Version"] = "1.0",
	["Author"] = "La Vendetta|Nitram",
	["Description"] = LVBM_JEKLIK_INFO,
	["Instance"] = LVBM_ZG,
	["GUITab"] = LVBMGUI_TAB_20PL,
	["Sort"] = 1,
	["Options"] = {  
		["Enabled"] = true,
		["Announce"] = false,
	},
	["Events"] = {
		["CHAT_MSG_MONSTER_YELL"] = true,
		["CHAT_MSG_MONSTER_EMOTE"] = true,
	},	
	["OnEvent"] = function(event, arg1) 
		if ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, LVBM_JEKLIK_BOMBBATS_EXPR) ) then
			LVBM.Announce(LVBM_JEKLIK_BOMBBATS_ANNOUNCE);

		elseif ( event == "CHAT_MSG_MONSTER_EMOTE" and string.find(arg1, LVBM_JEKLIK_CASTHEAL_EXPR) ) then
			LVBM.Announce(LVBM_JEKLIK_CASTHEAL_ANNOUNCE);

		elseif ( event == "CHAT_MSG_MONSTER_EMOTE" and string.find(arg1, LVBM_JEKLIK_BATS_EXPR) ) then
			LVBM.Announce(LVBM_JEKLIK_BATS_ANNOUNCE);

		end
	end,		
};
