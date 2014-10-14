-- 
-- Azuregos (Azshara Dragon) beta v0.1
--

LVBM.AddOns.Azuregos = { 
	["Name"] = LVBM_AZUREGOS_NAME,
	["Abbreviation1"] = "Azu", 
	["Version"] = "0.1",
	["Author"] = "La Vendetta|Nitram",
	["Description"] = LVBM_AZUREGOS_INFO,
	["Instance"] = LVBM_OTHER,
	["GUITab"] = LVBMGUI_TAB_OTHER,
	["Options"] = {  
		["Enabled"] = true,
		["Announce"] = false,
	},
	["Events"] = {
		["CHAT_MSG_MONSTER_YELL"] = true,
		["CHAT_MSG_SPELL_AURA_GONE_OTHER"] = true,
		["CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS"] = true,
	},	
	["OnEvent"] = function(event, arg1)
		if( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" and arg1 == LVBM_AZUREGOS_SHIELDUP_EXPR ) then
			LVBM.Announce(LVBM_AZUREGOS_SHIELDUP_ANNOUNCE);

		elseif( event == "CHAT_MSG_SPELL_AURA_GONE_OTHER" and arg1 == LVBM_AZUREGOS_SHIELDDOWN_EXPR ) then
			LVBM.Announce(LVBM_AZUREGOS_SHIELDDOWN_ANNOUNCE);

		elseif( event == "CHAT_MSG_MONSTER_YELL" and arg1 == LVBM_AZUREGOS_PORT_EXPR ) then
			LVBM.Announce(LVBM_AZUREGOS_PORT_ANNOUNCE);
			
		end
	end,
};
