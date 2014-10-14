LVBM.AddOns.Viscidus = {
	["Name"] = LVBM_VISCIDUS_NAME,
	["Abbreviation1"] = "Vis",
	["Version"] = "1.3",
	["Author"] = "Tandanu",
	["Description"] = LVBM_VISCIDUS_DESCRIPTION,
	["Instance"] = "Ahn'Qiraj",	
	["GUITab"] = LVBMGUI_TAB_AQ40,
	["Sort"] = 7,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
		["MainTank"] = "",
		["Whisper"] = false,
	},
	["InCombat"] = false,
	["SpamProtection"] = {},
	["Stats"] = {
		["Freeze0"] = 0,
		["Freeze1"] = 0,
		["Freeze2"] = 0,
		["FrostHits"] = 0,
		["TotalFrostHits"] = 0,
		["MeleeHits"] = 0,
		["TotalMeleeHits"] = 0,
		["P1Hits"] = 0,
		["P2Hits"] = 0,
		["P3Hits"] = 0,
		["P4Hits"] = 0,
		["P5Hits"] = 0,
		["P6Hits"] = 0,
		["Frozen"] = false,	
	},
	["DropdownMenu"] = {
		[1] = {
			["variable"] = "LVBM.AddOns.Viscidus.Options.Whisper",
			["text"] = LVBM_VISCIDUS_SEND_WHISPER,
			["func"] = function() LVBM.AddOns.Viscidus.Options.Whisper = not LVBM.AddOns.Viscidus.Options.Whisper; end,
		},
	},
	["Events"] = {		
		["CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS"] = true,
		["CHAT_MSG_COMBAT_HITS"] = true,
		["CHAT_MSG_COMBAT_PARTY_HITS"] = true,
		["CHAT_MSG_COMBAT_SELF_DAMAGE"] = true,
		["CHAT_MSG_COMBAT_SELF_HITS"] = true,	
		["CHAT_MSG_MONSTER_EMOTE"] = true,
		["PLAYER_REGEN_DISABLED"] = true,
		["CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE"] = true,
		["CHAT_MSG_SAY"] = true,
		["CHAT_MSG_MONSTER_YELL"] = true,
		["CHAT_MSG_MONSTER_EMOTE"] = true,
		["CHAT_MSG_MONSTER_SAY"] = true,
		["CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE"] = true,
		["CHAT_MSG_COMBAT_SELF_HITS"] = true,
		["CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PARTY_DAMAGE"] = true,
		["CHAT_MSG_SPELL_SELF_DAMAGE"] = true,
		["CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS"] = true,
		["CHAT_MSG_COMBAT_SELF_HITS"] = true,
		["CHAT_MSG_COMBAT_PARTY_HITS"] = true,
		["CHAT_MSG_COMBAT_HITS"] = true,
		["CHAT_MSG_COMBAT_SELF_DAMAGE"] = true,
	},	
	
	["SlashCmdHelpText"] = {
		[1] = LVBM_VISCIDUS_SLASHHELP1,
	},
	["OnSlashCommand"] = function(msg)
		if string.find(string.lower(msg), "mt (%w+)") then		
			LVBM.AddOns.Viscidus.Options.MainTank = string.sub(msg, 4);
			LVBM.AddMsg(LVBM_VISCIDUS_MT_SET..LVBM.AddOns.Viscidus.Options.MainTank);
			return true;
		end
	end,
	["OnEvent"] = function(event, arg1)	
		if (event == "CHAT_MSG_MONSTER_EMOTE") then
			if (arg1 == LVBM_VISCIDUS_SLOW_1) and (arg2 == LVBM_VISCIDUS_VISCIDUS) then				
				LVBM.Announce(string.format(LVBM_VISCIDUS_FREEZE_WARNING, 1));
				LVBM.AddOns.Viscidus.Stats.P1Hits = LVBM.AddOns.Viscidus.Stats.FrostHits;
				LVBM.AddOns.Viscidus.Stats.FrostHits = 0;
				LVBM.AddOns.Viscidus.Stats.Frozen = false;
				LVBM.AddOns.Viscidus.Stats.MeleeHits = 0;
				LVBM.AddOns.Viscidus.Stats.TotalMeleeHits = 0;
			elseif (arg1 == LVBM_VISCIDUS_SLOW_2) and (arg2 == LVBM_VISCIDUS_VISCIDUS) then				
				LVBM.Announce(string.format(LVBM_VISCIDUS_FREEZE_WARNING, 2));
				LVBM.AddOns.Viscidus.Stats.P2Hits = LVBM.AddOns.Viscidus.Stats.FrostHits;
				LVBM.AddOns.Viscidus.Stats.FrostHits = 0;
				LVBM.AddOns.Viscidus.Stats.Frozen = false;
				LVBM.AddOns.Viscidus.Stats.MeleeHits = 0;
				LVBM.AddOns.Viscidus.Stats.TotalMeleeHits = 0;
			elseif (arg1 == LVBM_VISCIDUS_SLOW_3) and (arg2 == LVBM_VISCIDUS_VISCIDUS) then				
				LVBM.Announce(LVBM_VISCIDUS_FROZEN_WARNING);
				LVBM.Schedule(7, "LVBM.AddOns.Viscidus.OnEvent", "FrozenWarning", 8);
				LVBM.Schedule(12,"LVBM.AddOns.Viscidus.OnEvent", "FrozenWarning", 3);
				LVBM.StartStatusBarTimer(15, "Frozen");
				LVBM.AddOns.Viscidus.Stats.P3Hits = LVBM.AddOns.Viscidus.Stats.FrostHits;
				LVBM.AddOns.Viscidus.Stats.FrostHits = 0;
				LVBM.AddOns.Viscidus.Stats.MeleeHits = 0;
				LVBM.AddOns.Viscidus.Stats.Frozen = true;
				LVBM.AddOns.Viscidus.Stats.TotalFrostHits = 0;
				LVBM.AddOns.Viscidus.Stats.MeleeHits = 0;
				LVBM.AddOns.Viscidus.Stats.TotalMeleeHits = 0;
			elseif (arg1 == LVBM_VISCIDUS_SHATTER_1) and (arg2 == LVBM_VISCIDUS_VISCIDUS) then				
				LVBM.Announce(string.format(LVBM_VISCIDUS_SHATTER_WARNING, 1));
				LVBM.AddOns.Viscidus.Stats.P4Hits = LVBM.AddOns.Viscidus.Stats.FrostHits;
				LVBM.AddOns.Viscidus.Stats.MeleeHits = 0;
				LVBM.AddOns.Viscidus.Stats.Frozen = true;
				LVBM.AddOns.Viscidus.Stats.TotalFrostHits = 0;
			elseif (arg1 == LVBM_VISCIDUS_SHATTER_2) and (arg2 == LVBM_VISCIDUS_VISCIDUS) then				
				LVBM.Announce(string.format(LVBM_VISCIDUS_SHATTER_WARNING, 2));
				LVBM.AddOns.Viscidus.Stats.P5Hits = LVBM.AddOns.Viscidus.Stats.FrostHits;
				LVBM.AddOns.Viscidus.Stats.MeleeHits = 0;
				LVBM.AddOns.Viscidus.Stats.Frozen = true;
				LVBM.AddOns.Viscidus.Stats.TotalFrostHits = 0;
			end
		elseif (event == "FrozenWarning") then
			if arg1 then			
				LVBM.Announce(string.format(LVBM_VISCIDUS_FROZEN_LEFT_WARNING, 8));
			end
		elseif (event == "PLAYER_REGEN_DISABLED") and GetRealZoneText() == LVBM_AQ40 and (not LVBM.AddOns.Viscidus.InCombat) then
			if LVBM.UnitExists(LVBM_VISCIDUS_VISCIDUS) then
				if LVBM.AddOns.Viscidus.Options.MainTank == nil or LVBM.AddOns.Viscidus.Options.MainTank == "" or LVBM.AddOns.Viscidus.Options.MainTank == " " then
					LVBM.AddMsg(LVBM_VISCIDUS_MT_NOT_SET1);
					LVBM.AddMsg(LVBM_VISCIDUS_MT_NOT_SET2);
				end
				LVBM.AddOns.Viscidus.Stats = {
					["Freeze0"] = 0,
					["Freeze1"] = 0,
					["Freeze2"] = 0,
					["FrostHits"] = 0,
					["TotalFrostHits"] = 0,
					["MeleeHits"] = 0,
					["TotalMeleeHits"] = 0,
					["P1Hits"] = 0,
					["P2Hits"] = 0,
					["P3Hits"] = 0,
					["P4Hits"] = 0,
					["P5Hits"] = 0,
					["P6Hits"] = 0,
					["Frozen"] = false,
				}
				LVBM.AddOns.Viscidus.InCombat = true;
			end
		elseif (event == "ConfirmCombatEnd") then
			if (not UnitAffectingCombat("player")) and (not UnitIsDeadOrGhost("player")) then
				LVBM.AddOns.Viscidus.InCombat = false;
				LVBM.UnSchedule("LVBM.AddOns.Viscidus.OnEvent");
			end
		elseif type(arg1) == "string" then
			if (string.find(arg1, LVBM_HIT) or string.find(arg1, LVBM_CRIT)) and string.find(arg1, LVBM_VISCIDUS_VISCIDUS) then
				if string.find(arg1, LVBM_FROST) then
					LVBM.AddOns.Viscidus.Stats.TotalFrostHits = LVBM.AddOns.Viscidus.Stats.TotalFrostHits + 1;
					LVBM.AddOns.Viscidus.Stats.FrostHits = LVBM.AddOns.Viscidus.Stats.FrostHits + 1;
					if not LVBM.AddOns.Viscidus.Stats.Frozen then
						if (mod(LVBM.AddOns.Viscidus.Stats.TotalFrostHits , 25) == 0) then 
							LVBM.AddMsg(LVBM_VISCIDUS_FROST_HITS..LVBM.AddOns.Viscidus.Stats.TotalFrostHits);
						end
						if (mod(LVBM.AddOns.Viscidus.Stats.TotalFrostHits, 50) == 0) then
							LVBM.Announce(string.format(LVBM_VISCIDUS_FROST_HITS_WARNING, LVBM.AddOns.Viscidus.Stats.TotalFrostHits));
						end
						if LVBM.AddOns.Viscidus.Stats.TotalFrostHits >= 300 then
							LVBM.AddOns.Viscidus.Stats.MeleeHits = 0;
							LVBM.AddOns.Viscidus.Stats.Frozen = true;
							LVBM.AddOns.Viscidus.Stats.TotalFrostHits = 0;
						end
					end
				elseif not (string.find(arg1, LVBM_ARCANE) or string.find(arg1, LVBM_HOLY) or string.find(arg1, LVBM_NATURE) or string.find(arg1, LVBM_SHADOW) or string.find(arg1, LVBM_FIRE)) then
					LVBM.AddOns.Viscidus.Stats.MeleeHits = LVBM.AddOns.Viscidus.Stats.MeleeHits + 1;
					LVBM.AddOns.Viscidus.Stats.TotalMeleeHits = LVBM.AddOns.Viscidus.Stats.TotalMeleeHits + 1;
					if LVBM.AddOns.Viscidus.Stats.Frozen then
						if (mod(LVBM.AddOns.Viscidus.Stats.TotalMeleeHits, 25) == 0) then 
							LVBM.AddMsg(LVBM_VISCIDUS_MELEE_HITS..LVBM.AddOns.Viscidus.Stats.TotalMeleeHits);
						end
						if (mod(LVBM.AddOns.Viscidus.Stats.TotalMeleeHits, 50) == 0) then
							LVBM.Announce(string.format(LVBM_VISCIDUS_MELEE_HITS_WARNING, LVBM.AddOns.Viscidus.Stats.TotalMeleeHits));
						end
						if LVBM.AddOns.Viscidus.Stats.TotalMeleeHits >= 200 then
							LVBM.AddOns.Viscidus.Stats.Frozen = false;
							LVBM.AddOns.Viscidus.Stats.MeleeHits = 0;
							LVBM.AddOns.Viscidus.Stats.TotalMeleeHits = 0;
						end
					end
				end
			end
		end	
	end,

	["OnUpdate"] = function(elapsed)
		if LVBM.AddOns.Viscidus.InCombat then
			if (not UnitAffectingCombat("player")) and (not UnitIsDeadOrGhost("player")) and (not LVBM.GetScheduleTimeLeft("LVBM.AddOns.Viscidus.OnEvent", "ConfirmCombatEnd")) then
				LVBM.Schedule(7.5, "LVBM.AddOns.Viscidus.OnEvent", "ConfirmCombatEnd");
				return;
			end
			local Vis_CurrentTarget = "";
			for i = 1, GetNumRaidMembers() do
				if UnitName("Raid"..i.."target") == LVBM_VISCIDUS_VISCIDUS then
					Vis_CurrentTarget = UnitName("Raid"..i.."targettarget");
					break;
				end
			end
			if Vis_CurrentTarget and Vis_CurrentTarget ~= "" and string.lower(Vis_CurrentTarget) ~= string.lower(LVBM.AddOns.Viscidus.Options.MainTank) then
				if LVBM.AddOns.Viscidus.SpamProtection[Vis_CurrentTarget] and LVBM.AddOns.Viscidus.SpamProtection[Vis_CurrentTarget] <= 15 then		
					return;
				else		
					LVBM.Announce(LVBM_VISCIDUS_TOXIN_ON..Vis_CurrentTarget.." ***");					
					if Vis_CurrentTarget == UnitName("player") then
						LVBM.AddSpecialWarning("Toxin", true, true);
					elseif LVBM.AddOns.Viscidus.Options.Whisper then
						LVBM.SendHiddenWhisper(LVBM_VISCIDUS_TOXIN_ON_YOU, Vis_CurrentTarget);
					end
					LVBM.AddOns.Viscidus.SpamProtection[Vis_CurrentTarget] = 0;
				end
			end	
		end
	end,
	["UpdateInterval"] = 0,
};
