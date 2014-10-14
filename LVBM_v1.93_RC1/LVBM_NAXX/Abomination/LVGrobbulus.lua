--
--  Grobbulus - v1.2 by Tandanu
--  v1.3 Updated by Nitram - Fixed Promoted Bug - Added TimerBar for Injection
--

LVBM.AddOns.Grobbulus = {
	["Name"] = LVBM_GROBB_NAME,
	["Abbreviation1"] = "grob",
	["Abbreviation2"] = "grobb",
	["Version"] = "1.3",
	["Author"] = "Tandanu + Nitram",
	["Description"] = LVBM_GROBB_DESCRIPTION,
	["Instance"] = LVBM_NAXX,
	["GUITab"] = LVBMGUI_TAB_NAXX,
	["Sort"] = 42,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
		["Whisper"] = false,
		["SetIcon"] = true,
	},
	["UsedIcons"] = {
		[8]	= false,
		[7]	= false,
		[6]	= false,
		[5]	= false,
		[4]	= false,
		[3]	= false,
		[2]	= false,
		[1]	= false,
	},
	["DropdownMenu"] = {
		[1] = {
			["variable"] = "LVBM.AddOns.Grobbulus.Options.Whisper",
			["text"] = LVBM_GROBB_SEND_WHISPER,
			["func"] = function() LVBM.AddOns.Grobbulus.Options.Whisper = not LVBM.AddOns.Grobbulus.Options.Whisper; end,
		},
		[2] = {
			["variable"] = "LVBM.AddOns.Grobbulus.Options.SetIcon",
			["text"] = LVBM_GROBB_SET_ICON,
			["func"] = function() LVBM.AddOns.Grobbulus.Options.SetIcon = not LVBM.AddOns.Grobbulus.Options.SetIcon; end,
		},
	},
	["Events"] = {
		["CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE"] = true,
		["CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF"] = true,
		["CHAT_MSG_SPELL_AURA_GONE_OTHER"] = true,
		["CHAT_MSG_SPELL_AURA_GONE_SELF"] = true,
	},
	["OnCombatStart"] = function(delay)
		LVBM.StartStatusBarTimer(600-delay, "Enrage");
	end,
	["OnCombatEnd"] = function()
		if( LVBM.AddOns.Grobbulus.Options.SetIcon ) then
			LVBM.CleanUp();
		end
	end,
	["OnEvent"] = function(event, arg1) 
		if (event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE") 
		or (event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE") 
		or (event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE") then

			local Name, Type;
			_, _, Name, Type = string.find(arg1, LVBM_GROBB_INJECTION_REGEXP);
			if (Name == LVBM_YOU) and (Type == LVBM_ARE) then
				Name = UnitName("player");
			end
			if Name then
				local targetID;
				for i = 1, GetNumRaidMembers() do
					if UnitName("raid"..i) == Name then
						targetID = i;
					end
				end
				if targetID and LVBM.Rank >= 1 and LVBM.AddOns.Grobbulus.Options.SetIcon and LVBM.AddOns.Grobbulus.Options.Announce then
					local iconToUse;
					for index, value in pairs(LVBM.AddOns.Grobbulus.UsedIcons) do
						if value == false then
							iconToUse = index;
						end
					end
					if (not GetRaidTargetIndex("raid"..targetID)) or (not LVBM.AddOns.Grobbulus.UsedIcons[GetRaidTargetIndex("raid"..targetID)] == Name) then
						if UnitExists("raid"..targetID) and iconToUse and iconToUse <= 8 and iconToUse >= 1 then
							SetRaidTargetIcon("raid"..targetID, iconToUse);
							LVBM.AddOns.Grobbulus.UsedIcons[iconToUse] = Name;
							LVBM.Schedule(10, "LVBM.AddOns.Grobbulus.OnEvent", "ClearIcon"..Name, iconToUse);
						end
					end
				end

				if LVBM.AddOns.Grobbulus.Options.Whisper and Name ~= UnitName("player") then
					LVBM.SendHiddenWhisper(LVBM_GROBB_YOU_ARE_INJECTED, Name);
				end
				if Name == UnitName("player") then
					LVBM.AddSpecialWarning(LVBM_GROBB_INJECTED, true, true);
				end
				LVBM.Announce(string.format(LVBM_GROBB_INJECTED_WARNING, Name));
				LVBM.StartStatusBarTimer(10, "Injection: "..Name);
			end

		elseif string.sub(event, 1, 9) == "ClearIcon" and arg1 then
			local player = string.sub(event, 10);
			if player then
				local targetID;
				for i = 1, GetNumRaidMembers() do
					if UnitName("raid"..i) == player then
						targetID = i;
						break;
					end
				end
				if targetID and LVBM.Rank >= 1 and LVBM.AddOns.Grobbulus.Options.SetIcon and LVBM.AddOns.Grobbulus.Options.Announce then
					if GetRaidTargetIndex("raid"..targetID) == arg1 then
						SetRaidTargetIcon("raid"..targetID, 0)
						LVBM.AddOns.Grobbulus.UsedIcons[arg1] = false;
					end
				end
			end

		elseif ((event == "CHAT_MSG_SPELL_AURA_GONE_OTHER") or (event == "CHAT_MSG_SPELL_AURA_GONE_SELF")) and arg1 then
			local Name;
			_, _, Name = string.find(arg1, LVBM_GROBB_INJECTION_FADES_REGEXP);
			if Name then
				local targetID;
				for i = 1, GetNumRaidMembers() do
					if UnitName("raid"..i) == Name then
						targetID = i;
						break;
					end
				end	
				if targetID and LVBM.Rank >= 1 then
					if LVBM.AddOns.Grobbulus.Options.SetIcon and GetRaidTargetIndex("raid"..targetID) then
						LVBM.AddOns.Grobbulus.UsedIcons[GetRaidTargetIndex("raid"..targetID)] = false;
						LVBM.UnSchedule("LVBM.AddOns.Grobbulus.OnEvent", "ClearIcon"..UnitName("raid"..targetID), GetRaidTargetIndex("raid"..targetID));
						SetRaidTargetIcon("raid"..targetID, 0);						
					end
				end	
			end

		elseif (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF"
		    and string.find(arg1, LVBM_GROBB_CLOUD_POISON) ) then

			LVBM.StartStatusBarTimer(15, "Cloud Poison");	
		end
	end,
};
