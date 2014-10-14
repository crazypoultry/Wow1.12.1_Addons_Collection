-- 
-- Onyxia Beta v1.0
--

LVBM.AddOns.Onyxia = { 
	["Name"] = LVBM_ONYXIA_NAME,
	["Abbreviation1"] = "ony", 
	["Version"] = "1",
	["Author"] = "La Vendetta|Nitram",
	["Description"] = LVBM_ONYXIA_INFO,
	["Instance"] = LVBM_OTHER,
	["GUITab"] = LVBMGUI_TAB_OTHER,
	["Options"] = {  
		["Enabled"] = true,
		["Announce"] = false,
	},
	["Events"] = {
		["CHAT_MSG_MONSTER_EMOTE"] = true,
		["CHAT_MSG_MONSTER_YELL"] = true,
	},	
	["OnEvent"] = function(event, arg1) 
		if ( (event == "CHAT_MSG_MONSTER_EMOTE") and ( arg1 == LVBM_ONYXIA_BREATH_EMOTE ) ) then
			LVBM.Announce(LVBM_ONYXIA_BREATH_ANNOUNCE);

		elseif ( (event == "CHAT_MSG_MONSTER_YELL") and (arg1 == LVBM_ONYXIA_PHASE2_YELL) ) then
			LVBM.Announce(LVBM_ONYXIA_PHASE2_ANNOUNCE);

		elseif ( (event == "CHAT_MSG_MONSTER_YELL") and (arg1 == LVBM_ONYXIA_PHASE3_YELL) ) then
			LVBM.Announce(LVBM_ONYXIA_PHASE3_ANNOUNCE);

		end
	end,		
};
