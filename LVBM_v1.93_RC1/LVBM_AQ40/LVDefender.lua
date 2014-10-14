LVBM.AddOns.Defender = {
	["Name"] = LVBM_DEFENDER_NAME,
	["Abbreviation1"] = "Defender",
	["Version"] = "1.0",
	["Author"] = "Tandanu",
	["Description"] = LVBM_DEFENDER_DESCRIPTION,
	["Instance"] = LVBM_AQ40,
	["GUITab"] = LVBMGUI_TAB_AQ40,
	["Sort"] = 5.5,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
		["Whisper"] = false,
		["Plague"] = true,
	},
	["DropdownMenu"] = {
		[1] = {
			["variable"] = "LVBM.AddOns.Defender.Options.Whisper",
			["text"] = LVBM_DEFENDER_WHISPER,
			["func"] = function() LVBM.AddOns.Defender.Options.Whisper = not LVBM.AddOns.Defender.Options.Whisper; end,
		},
		[2] = {
			["variable"] = "LVBM.AddOns.Defender.Options.Plague",
			["text"] = LVBM_DEFENDER_PLAGUE,
			["func"] = function() LVBM.AddOns.Defender.Options.Plague = not LVBM.AddOns.Defender.Options.Plague; end,
		},
	},
	["Events"] = {
		["CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS"] = true,
		["CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE"] = true,
	},	
	
	["OnEvent"] = function(event, arg1)	
		if (event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS") then
			if arg1 == LVBM_DEFENDER_GAIN_EXPLODE then
				LVBM.Announce(LVBM_DEFENDER_ANNOUNCE_EXPLODE);
				LVBM.StartStatusBarTimer(6, "Explode");
			end
		elseif (event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE") then
			if string.find(arg1, LVBM_DEFENDER_PLAGUE_REGEXP) then
				local player;
				_, _, player = string.find(arg1, LVBM_DEFENDER_PLAGUE_REGEXP);
				if player == LVBM_YOU then
					player = UnitName("player");
				end
				if player then
					if LVBM.AddOns.Defender.Options.Plague then
						LVBM.Announce(string.format(LVBM_DEFENDER_ANNOUNCE_PLAGUE, player));
					end
					if player == UnitName("player") then
						LVBM.AddSpecialWarning(LVBM_DEFENDER_PLAGUE_WARNING, true, true);
					else
						if LVBM.AddOns.Defender.Options.Whisper then
							LVBM.SendHiddenWhisper(LVBM_DEFENDER_WHISPER_PLAGUE, player);					
						end
					end
				end
			end
		end
   end,   
};
