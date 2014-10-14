--
-- Thaddius v1.0 by Tandanu
-- v1.1 modded by Nitram with:  'Phase 1' Start Detection
-- 				'Power Surge' Warning for Stalagg
-- 				'MT Throw' Warning
--

LVBM.AddOns.Thaddius = {
	["Name"] = LVBM_THADDIUS_NAME,
	["Abbreviation1"] = "thad",
	["Abbreviation2"] = "thadd",
	["Version"] = "1.1",
	["Author"] = "Tandanu",
	["Description"] = LVBM_THADDIUS_DESCRIPTION,
	["Instance"] = LVBM_NAXX,
	["GUITab"] = LVBMGUI_TAB_NAXX,
	["Sort"] = 44,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
		["PowerSurge"] = true,
		["WarnWhenNotChanged"] = false,
		["AltStrat"] = false,
		["ReduceLogRange"] = false,
	},
	["oldCharge"] = "",
	["InCombat"] = false,
	["Phase"] = 0,
	["LastPol"] = 0,
	["TeslaCoil"] = false,
	["DropdownMenu"] = {
		[1] = {
			["variable"] = "LVBM.AddOns.Thaddius.Options.PowerSurge",
			["text"] = LVBM_THADDIUS_WARN_POWERSURGE,
			["func"] = function() LVBM.AddOns.Thaddius.Options.PowerSurge = not LVBM.AddOns.Thaddius.Options.PowerSurge; end,
		},
		[2] = {
			["variable"] = "LVBM.AddOns.Thaddius.Options.WarnWhenNotChanged",
			["text"] = LVBM_THADDIUS_WARN_NOT_CHANGED,
			["func"] = function() LVBM.AddOns.Thaddius.Options.WarnWhenNotChanged = not LVBM.AddOns.Thaddius.Options.WarnWhenNotChanged; end,
		},
		[3] = {
			["variable"] = "LVBM.AddOns.Thaddius.Options.AltStrat",
			["text"] = LVBM_THADDIUS_ALT_STRATEGY,
			["func"] = function() LVBM.AddOns.Thaddius.Options.AltStrat = not LVBM.AddOns.Thaddius.Options.AltStrat; end,
		},
		[4] = {
			["variable"] = "LVBM.AddOns.Thaddius.Options.ReduceLogRange",
			["text"] = LVBM_THADDIUS_FIX_LAG,
			["func"] = function() LVBM.AddOns.Thaddius.Options.ReduceLogRange = not LVBM.AddOns.Thaddius.Options.ReduceLogRange; end,
		},
	},
	["Events"] = {
		["CHAT_MSG_MONSTER_YELL"] = true,
		["CHAT_MSG_MONSTER_EMOTE"] = true,
		["CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE"] = true,
		["PLAYER_AURAS_CHANGED"] = true,
		["CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS"] = true,		-- Power Surge
		["CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE"] = true,
		["CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF"] = true,
	},
	["OnCombatEnd"] = function()
		LVBM.AddOns.Thaddius.Phase = 0;
		LVBM.AddOns.Thaddius.oldCharge = "";
		LVBM.EndRepeatingStatusBarTimer("MT throw");

		if LVBM.AddOns.Thaddius.Options.ReduceLogRange and LVBM.SetCombatLogDistance then
			LVBM.SetCombatLogDistance( LVBM.Options.Gui.CombatLogValue );
		end
	end,
	["OnCombatStart"] = function(delay)
		LVBM.Announce(LVBM_THADDIUS_PHASE1_ANNOUNCE);
		LVBM.AddOns.Thaddius.Phase = 1;
		LVBM.StartStatusBarTimer(21.5, "MT throw");
		LVBM.Schedule(21.5 - 5 - delay, "LVBM.AddOns.Thaddius.OnEvent", "NextThrow", 5);
		LVBM.Schedule(21.5 - delay, "LVBM.AddOns.Thaddius.OnEvent", "NextThrow", 0);
		LVBM.Schedule(21.5 - delay, "LVBM.AddOns.Thaddius.OnEvent", "StartThrowLoop");
	end,
	["OnEvent"] = function(event, arg1)		
		if (event == "NextThrow" and LVBM.AddOns.Thaddius.Phase == 1) then
			if arg1 and arg1 ~= 0 then
				LVBM.Announce(string.format(LVBM_THADDIUS_THROW_ANNOUNCE_SOON, arg1));
			else
				LVBM.Announce(LVBM_THADDIUS_THROW_ANNOUNCE);				
				LVBM.Schedule(20.6 - 5, "LVBM.AddOns.Thaddius.OnEvent", "NextThrow", 5);
				LVBM.Schedule(20.6, "LVBM.AddOns.Thaddius.OnEvent", "NextThrow", 0);
			end
		elseif (event == "StartThrowLoop") then
			LVBM.StartRepeatingStatusBarTimer(20.6, "MT throw");
		elseif (event == "CHAT_MSG_MONSTER_EMOTE" and string.find(arg1, LVBM_THADDIUS_PLATFORM_EXPR) ) then
			LVBM.Announce(LVBM_THADDIUS_PLATFORM_ANNOUNCE);

		elseif (event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" 
		     and arg1 == LVBM_THADDIUS_SURGE_EXPR 
		     and LVBM.AddOns.Thaddius.Options.PowerSurge ) then
			LVBM.Announce(LVBM_THADDIUS_SURGE_ANNOUNCE);
			LVBM.StartStatusBarTimer(10, "Power Surge");

		elseif (event == "CHAT_MSG_MONSTER_YELL") then
			if (arg1 == LVBM_THADDIUS_YELL_START1) or (arg1 == LVBM_THADDIUS_YELL_START2) or (arg1 == LVBM_THADDIUS_YELL_START3) then
				LVBM.AddOns.Thaddius.TeslaCoil = false;
				LVBM.AddOns.Thaddius.Phase = 2;

				if LVBM.AddOns.Thaddius.Options.ReduceLogRange and LVBM.SetCombatLogDistance then
					LVBM.SetCombatLogDistance(4);
				end

				LVBM.EndRepeatingStatusBarTimer("MT throw");
				LVBM.Announce(string.format(LVBM_THADDIUS_ENRAGE_WARNING, 5, LVBM_MINUTES));
				LVBM.Schedule(120, "LVBM.AddOns.Thaddius.OnEvent", "EnrageWarning", 180);
				LVBM.Schedule(180, "LVBM.AddOns.Thaddius.OnEvent", "EnrageWarning", 120);
				LVBM.Schedule(240, "LVBM.AddOns.Thaddius.OnEvent", "EnrageWarning", 60);
				LVBM.Schedule(270, "LVBM.AddOns.Thaddius.OnEvent", "EnrageWarning", 30);
				LVBM.Schedule(290, "LVBM.AddOns.Thaddius.OnEvent", "EnrageWarning", 10);
				LVBM.StartStatusBarTimer(300, "Enrage");

			elseif (arg1 == LVBM_THADDIUS_YELL_POL) then
				LVBM.Announce(LVBM_THADDIUS_POL_SHIFT);
				LVBM.EndStatusBarTimer("Polarity Shift");
				LVBM.StartStatusBarTimer(30, "Polarity Shift");
			end
		elseif (event == "CHAT_MSG_MONSTER_EMOTE") then
			if arg1 == LVBM_THADDIUS_TESLA_EMOTE and not LVBM.AddOns.Thaddius.TeslaCoil then --and arg2 == LVBM_THADDIUS_TESLA_COIL then
				LVBM.EndRepeatingStatusBarTimer("MT throw");
				LVBM.AddOns.Thaddius.TeslaCoil = true;
				LVBM.Announce(LVBM_THADDIUS_PHASE_2_SOON);
				LVBM.StartStatusBarTimer(4.3, "Phase 2");
			end
		elseif (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") then
			if arg1 == LVBM_THADDIUS_CAST_POL then
				LVBM.Announce(string.format(LVBM_THADDIUS_POL_WARNING, 3));
				LVBM.EndStatusBarTimer("Polarity Shift");
				LVBM.StartStatusBarTimer(3, "Polarity Shift cast");
			end
		elseif (event == "PLAYER_AURAS_CHANGED") and GetTime() > (LVBM.AddOns.Thaddius.LastPol + 26) then
			local charge, i;
			charge = "";
			i = 1;
			while UnitDebuff("player", i) do
				local texture, stacks;
				texture, stacks = UnitDebuff("player", i)
				if texture == "Interface\\Icons\\Spell_ChargeNegative" then
					if stacks > 1 then
						return; 
					end					
					charge = LVBM_THADDIUS_NEGATIVE;
				elseif texture == "Interface\\Icons\\Spell_ChargePositive" then
					if stacks > 1 then
						return; 
					end					
					charge = LVBM_THADDIUS_POSITIVE;
				end
				i = i + 1;
			end
			if charge == "" then
				return;
			end
			LVBM.AddOns.Thaddius.LastPol = GetTime();
			if LVBM.AddOns.Thaddius.Options.AltStrat then
				if charge ~= LVBM.AddOns.Thaddius.oldCharge then
					LVBM.AddSpecialWarning(LVBM_THADDIUS_RIGHT, true, true);
				else
					LVBM.AddSpecialWarning(LVBM_THADDIUS_LEFT, true, true);
				end
				LVBM.AddOns.Thaddius.oldCharge = charge;
			else
				if charge ~= LVBM.AddOns.Thaddius.oldCharge then
					LVBM.AddSpecialWarning(string.format(LVBM_THADDIUS_CHARGE_CHANGED, charge), true, true);
				elseif LVBM.AddOns.Thaddius.Options.WarnWhenNotChanged then
					LVBM.AddSpecialWarning(LVBM_THADDIUS_CHARGE_NOT_CHANGED, true, true);
				end
				LVBM.AddOns.Thaddius.oldCharge = charge;				
			end
		elseif (event == "EnrageWarning") then
			if arg1 == 180 then
				LVBM.Announce(string.format(LVBM_THADDIUS_ENRAGE_WARNING, 3, LVBM_MINUTES));
			elseif arg1 == 120 then
				LVBM.Announce(string.format(LVBM_THADDIUS_ENRAGE_WARNING, 2, LVBM_MINUTES));
			elseif arg1 == 60 then
				LVBM.Announce(string.format(LVBM_THADDIUS_ENRAGE_WARNING, 1, LVBM_MINUTE));
			elseif arg1 == 30 then
				LVBM.Announce(string.format(LVBM_THADDIUS_ENRAGE_WARNING, 30, LVBM_SECONDS));
			elseif arg1 == 10 then
				LVBM.Announce(string.format(LVBM_THADDIUS_ENRAGE_WARNING, 10, LVBM_SECONDS));
			end
		end
	end,
};

