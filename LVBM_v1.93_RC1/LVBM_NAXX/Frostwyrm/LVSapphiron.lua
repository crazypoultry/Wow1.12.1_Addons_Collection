--
--  Sapphiron - v1.0 by Nitram
--

LVBM.AddOns.Sapphiron = {
	["Name"] = LVBM_SAPPHIRON_NAME,
	["Abbreviation1"] = "sapphiron",
	["Version"] = "1.0",
	["Author"] = "Nitram",
	["Description"] = LVBM_SAPPHIRON_INFO,
	["Instance"] = LVBM_NAXX,
	["GUITab"] = LVBMGUI_TAB_NAXX,
	["Sort"] = 51,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
		["Yell"] = true,
	},
	["DropdownMenu"] = {
		[1] = {
			["variable"] = "LVBM.AddOns.Sapphiron.Options.Yell",
			["text"] = LVBM_SAPPHIRON_YELL_INFO,
			["func"] = function() LVBM.AddOns.Sapphiron.Options.Yell = not LVBM.AddOns.Sapphiron.Options.Yell; end,
		},
	},
	["Events"] = {
		["CHAT_MSG_MONSTER_EMOTE"] = true,				-- IceBomb
		["CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE"] = true,		-- LifeDrain
		["CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE"] = true,	-- LifeDrain
		["CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"] = true,			-- LifeDrain // Icebolt
		["CHAT_MSG_SPELL_AURA_GONE_SELF"] = true,			-- Icebolt
	},
	["LastDrain"] = 0,
	["InCombat"] = false, 
	["OnCombatStart"] = function(delay)
		LVBM.Schedule(810 - delay, "LVBM.AddOns.Sapphiron.OnEvent", "EnrageWarning", 90);
		LVBM.Schedule(870 - delay, "LVBM.AddOns.Sapphiron.OnEvent", "EnrageWarning", 30);
		LVBM.StartStatusBarTimer(900 - delay, "Enrage");
		LVBM.StartStatusBarTimer(10 - delay, "Life Drain");
		LVBM.AddOns.Sapphiron.InCombat = true;
	end,
	["OnCombatEnd"] = function()
		LVBM.AddOns.Sapphiron.InCombat = false;
		LVBM.AddOns.Sapphiron.PingStartedTime = 0;
		LVBM.UnSchedule("LVBM.AddOns.Sapphiron.OnEvent", "EnrageWarning");
		LVBM.UnSchedule("LVBM.AddOns.Sapphiron.PingMiniMap");
	end,
	["TargetTime"] = 0,
	["LastTarget"] = "",
	["OnUpdate"] = function(elapsed)
		if (not LVBM.AddOns.Sapphiron.InCombat) then  return; end

		local FoundSapphiron = false;
		local newTarget;
			
		if (UnitName("target") == LVBM_SAPPHIRON_NAME) then
			newTarget = UnitName("targettarget")
			FoundSapphiron = true;
		else
			for i = 1, GetNumRaidMembers() do
				if (UnitName("raid"..i.."target") == LVBM_SAPPHIRON_NAME) then
					newTarget = UnitName("Raid"..i.."targettarget")
					FoundSapphiron = true;
					break;
				end
			end
		end
		if (FoundSapphiron) then
			if (newTarget == LVBM.AddOns.Sapphiron.LastTarget) then
				LVBM.AddOns.Sapphiron.TargetTime = LVBM.AddOns.Sapphiron.TargetTime + elapsed;
			else
				LVBM.AddOns.Sapphiron.LastTarget = newTarget;
				LVBM.AddOns.Sapphiron.TargetTime = 0;
			end

			if (not newTarget and LVBM.AddOns.Sapphiron.TargetTime > 2 and not LVBM.GetStatusBarTimerTimeLeft("Frost Breath")) then
				LVBM.StartStatusBarTimer(23-LVBM.AddOns.Sapphiron.TargetTime, "Frost Breath");
			end
		end
	end,
	["UpdateInterval"] = 0.2,
	["PingStartedTime"] = 0,
	["PingMiniMap"] = function()
		if( (time() - LVBM.AddOns.Sapphiron.PingStartedTime) < 35 ) then	-- Protect Ping Spam !! :)
			Minimap:PingLocation(CURSOR_OFFSET_X, CURSOR_OFFSET_Y);
			LVBM.Schedule(2, "LVBM.AddOns.Sapphiron.PingMiniMap");		-- Ping all 2 Sec
		else
			LVBM.AddOns.Sapphiron.PingStartedTime = 0;
		end
	end,
	["OnEvent"] = function(event, arg1)
		-------------------------
		-- Icebolt PingMinimap --
		-------------------------
		if (event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" and string.find(arg1, LVBM_SAPPHIRON_FROSTBOLT_GAIN_EXPR)) then
			LVBM.AddOns.Sapphiron.PingStartedTime = time();
			LVBM.AddOns.Sapphiron.PingMiniMap();

			if( LVBM.AddOns.Sapphiron.Options.Yell ) then
				SendChatMessage( LVBM_SAPPHIRON_YELL_ANNOUNCE, "YELL");
			end

		elseif (event == "CHAT_MSG_SPELL_AURA_GONE_SELF" and string.find(arg1, LVBM_SAPPHIRON_FROSTBOLT_FADE_EXPR)) then
			LVBM.UnSchedule("LVBM.AddOns.Sapphiron.PingMiniMap");
		end
		
		---------------------
		-- Enrage Warnings --
		---------------------
		if (event == "EnrageWarning") then
			LVBM.Announce(string.format(LVBM_SAPPHIRON_ENRAGE_ANNOUNCE, arg1));
		end

		------------------------
		-- Life Drain Warning --
		------------------------
		if ((event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE"
		 or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE"
		 or event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE")
		 and (time() - LVBM.AddOns.Sapphiron.LastDrain) > 5 
		 and (string.find(arg1, LVBM_SAPPHIRON_LIFEDRAIN_EXPR1) 
		   or string.find(arg1, LVBM_SAPPHIRON_LIFEDRAIN_EXPR2)) ) then
			LVBM.AddOns.Sapphiron.LastDrain = time();
			LVBM.Announce(LVBM_SAPPHIRON_LIFEDRAIN_ANNOUNCE);
			LVBM.Schedule(19, "LVBM.AddOns.Sapphiron.OnEvent", "LifeDrainWarn", 5);
			LVBM.StartStatusBarTimer(24, "Life Drain");
			
		elseif (event == "LifeDrainWarn") then
			LVBM.Announce(string.format(LVBM_SAPPHIRON_LIFEDRAIN_WARN, arg1));
		end

		-----------------
		-- Deep Breath --
		-----------------
		if (event == "CHAT_MSG_MONSTER_EMOTE" and string.find(arg1, LVBM_SAPPHIRON_DEEPBREATH_EXPR)) then
			LVBM.Announce(LVBM_SAPPHIRON_DEEPBREATH_ANNOUNCE);
			LVBM.StartStatusBarTimer(7, "Deep Breath");
		end
	end,
}


