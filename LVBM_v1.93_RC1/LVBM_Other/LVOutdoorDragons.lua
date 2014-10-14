LVBM.AddOns.OutdoorDragons = { 
	["Name"] = LVBM_OUTDOOR_NAME,
	["Abbreviation1"] = "Dragons", 
	["Version"] = "1.0",
	["Author"] = "Tandanu",
	["Description"] = LVBM_OUTDOOR_DESCRIPTION,
	["Instance"] = LVBM_OTHER,
	["GUITab"] = LVBMGUI_TAB_OTHER,
	["Options"] = {  
		["Enabled"] = true,
		["Announce"] = false,
		["SetIcon"] = true,
		["SendWhisper"] = false,
	},
	["DropdownMenu"] = {
		[1] = {
			["variable"] = "LVBM.AddOns.OutdoorDragons.Options.Whisper",
			["text"] = LVBM_SEND_WHISPER,
			["func"] = function() LVBM.AddOns.OutdoorDragons.Options.Whisper = not LVBM.AddOns.OutdoorDragons.Options.Whisper; end,
		},
		[2] = {
			["variable"] = "LVBM.AddOns.OutdoorDragons.Options.SetIcon",
			["text"] = LVBM_SET_ICON,
			["func"] = function() LVBM.AddOns.OutdoorDragons.Options.SetIcon = not LVBM.AddOns.OutdoorDragons.Options.SetIcon; end,
		},
	},
	["CastingBreath"] = false,
	["Events"] = {
		["CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE"] = true,
	},
	["OnCombatStart"] = function()
		LVBM.AddOns.OutdoorDragons.CastingBreath = false;
	end,
	["OnCombatEnd"] = function()
		LVBM.AddOns.OutdoorDragons.CastingBreath = false;
		if( LVBM.AddOns.OutdoorDragons.Options.SetIcon ) then
			LVBM.CleanUp();
		end
	end,
	["OnEvent"] = function(event, arg1)

		if event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" 
		or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE"
		or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" then

			if (string.find(arg1, LVBM_OUTDOOR_NOX_BREATH) 
			 or string.find(arg1, LVBM_OUTDOOR_NOX_RESIST)) 
			 and not LVBM.AddOns.OutdoorDragons.CastingBreath then

				LVBM.AddOns.OutdoorDragons.CastingBreath = true;
				LVBM.Announce(LVBM_OUTDOOR_BREATH_NOW);
				LVBM.Schedule(25, "LVBM.AddOns.OutdoorDragons.OnEvent", "BreathWarning", 5);
				LVBM.StartStatusBarTimer(30, "Noxious Breath");

			elseif string.find(arg1, LVBM_OUTDOOR_INFECTION) 
			   and ( GetRealZoneText() == LVBM_OUTDOOR_LOCATION_1
			    or   GetRealZoneText() == LVBM_OUTDOOR_LOCATION_2
			    or   GetRealZoneText() == LVBM_OUTDOOR_LOCATION_3
			    or   GetRealZoneText() == LVBM_OUTDOOR_LOCATION_4 ) then

				local _, _, name = string.find(arg1, LVBM_OUTDOOR_INFECTION);
				if name == LVBM_YOU then
					name = UnitName("player");
				end					
				if name then
					local targetID;
					for i = 1, GetNumRaidMembers() do
						if UnitName("raid"..i) == name then
							targetID = i;
							break;
						end
					end
					if targetID and LVBM.Rank >= 1 and LVBM.AddOns.OutdoorDragons.Options.SetIcon then
						if GetRaidTargetIndex("raid"..targetID) ~= 8 then
							SetRaidTargetIcon("raid"..targetID, 8);
						end
					end	
						
					LVBM.Announce(string.format(LVBM_OUTDOOR_INFECT_WARN, name));
					if name == UnitName("player") then
						LVBM.AddSpecialWarning(LVBM_OUTDOOR_INFECT_SPECIAL, true, true);
					else
						if LVBM.AddOns.OutdoorDragons.Options.Whisper and LVBM.AddOns.OutdoorDragons.Options.Announce then
							LVBM.SendHiddenWhisper(LVBM_OUTDOOR_INFECT_SPECIAL, name);
						end
					end
				end
			end

		elseif event == "BreathWarning" then
			if arg1 then
				LVBM.AddOns.OutdoorDragons.CastingBreath = false;
				LVBM.Announce(string.format(LVBM_OUTDOOR_BREATH_WARNING, arg1));
			end
		end
	end,		
};
