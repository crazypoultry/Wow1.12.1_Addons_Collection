-- 
-- Jin'do the Hexxer Beta v0.1
--

LVBM.AddOns.Jindo = { 
	["Name"] = LVBM_JINDO_NAME,
	["Abbreviation1"] = "Jindo", 
	["Version"] = "1.0",
	["Author"] = "La Vendetta|Nitram",
	["Description"] = LVBM_JINDO_INFO,
	["Instance"] = LVBM_ZG,
	["GUITab"] = LVBMGUI_TAB_20PL,
	["Options"] = {  
		["Enabled"] = true,
		["Announce"] = false,
		["Whisper"] = false,
		["HealTotem"] = true,
		["MindControlTotem"] = true,
		["AnnounceCurse"] = true,
	},
	["DropdownMenu"] = {
		[1] = {
			["variable"] = "LVBM.AddOns.Jindo.Options.Whisper",
			["text"] = LVBM_JINDO_WHISPER_INFO,
			["func"] = function() LVBM.AddOns.Jindo.Options.Whisper = not LVBM.AddOns.Jindo.Options.Whisper; end,
		},
		[2] = {
			["variable"] = "LVBM.AddOns.Jindo.Options.HealTotem",
			["text"] = LVBM_JINDO_HEAL_TOTEM_INFO,
			["func"] = function() LVBM.AddOns.Jindo.Options.HealTotem = not LVBM.AddOns.Jindo.Options.HealTotem; end,
		},
		[3] = {
			["variable"] = "LVBM.AddOns.Jindo.Options.MindControlTotem",
			["text"] = LVBM_JINDO_MC_TOTEM_INFO,
			["func"] = function() LVBM.AddOns.Jindo.Options.MindControlTotem = not LVBM.AddOns.Jindo.Options.MindControlTotem; end,
		},
		[4] = {
			["variable"] = "LVBM.AddOns.Jindo.Options.AnnounceCurse",
			["text"] = LVBM_JINDO_CURSE_INFO,
			["func"] = function() LVBM.AddOns.Jindo.Options.AnnounceCurse = not LVBM.AddOns.Jindo.Options.AnnounceCurse; end,
		},
	},
	["Sort"] = 7,
	["Events"] = {
		["CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"] = true,
		["CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF"] = true,
	},	
	["OnEvent"] = function(event, arg1) 
		if (( 	event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" or 
			event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or 
			event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" ) 
			and LVBM.AddOns.Jindo.Options.AnnounceCurse) then

			local _, _, sArg1, sArg2 = string.find(arg1, LVBM_JINDO_CURSE_EXPR);
			if ( sArg1 and sArg2 ) then
				if ( sArg1 == LVBM_YOU and sArg2 == LVBM_ARE ) then
					LVBM.AddSpecialWarning( LVBM_JINDO_CURSE_SELF_ANNOUNCE );
					sArg1 = UnitName("player");	
	
				else
					if LVBM.AddOns.Jindo.Options.Whisper then
						LVBM.SendHiddenWhisper(LVBM_JINDO_WHISPER_TEXT, sArg1);
					end
				end
				LVBM.Announce( string.format(LVBM_JINDO_CURSE_ANNOUNCE, sArg1) );
			end
		elseif ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF" ) then
			if ( arg1 == LVBM_JINDO_MIND_CONTROL_TOTEM ) and ( LVBM.AddOns.Jindo.Options.MindControlTotem ) then
				LVBM.Announce(LVBM_JINDO_MC_TOTEM_WARNING);
			elseif ( arg1 == LVBM_JINDO_HEAL_TOTEM ) and ( LVBM.AddOns.Jindo.Options.HealTotem ) then
				LVBM.Announce(LVBM_JINDO_HEAL_TOTEM_WARNING);
			end
		end
	end,
};
