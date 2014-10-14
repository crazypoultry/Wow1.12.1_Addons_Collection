-- 
-- High Priestess Mar'li v1.0
--

LVBM.AddOns.Marli = { 
	["Name"] = LVBM_MARLI_NAME,
	["Abbreviation1"] = "Marli", 
	["Version"] = "1.0",
	["Author"] = "La Vendetta|Nitram",
	["Description"] = LVBM_MARLI_INFO,
	["Instance"] = LVBM_ZG,
	["GUITab"] = LVBMGUI_TAB_20PL,
	["Options"] = {  
		["Enabled"] = true,
		["Announce"] = false,
	},
	["Sort"] = 3,
	["Events"] = {
		["CHAT_MSG_MONSTER_YELL"] = true,
	},	
	["OnEvent"] = function(event, arg1) 
		if ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, LVBM_MARLI_SPIDER_EXPR) ) then
			LVBM.Announce(LVBM_MARLI_SPIDER_ANNOUNCE);

		end
	end,		
};
