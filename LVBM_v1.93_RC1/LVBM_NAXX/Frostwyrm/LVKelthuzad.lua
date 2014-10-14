--
--  Kel'Thuzad - v1.0 by Nitram
--

LVBM.AddOns.Kelthuzad = {
	["Name"] = LVBM_KELTHUZAD_NAME,
	["Abbreviation1"] = "kel",
	["Version"] = "1.0",
	["Author"] = "Nitram",
	["Description"] = LVBM_KELTHUZAD_INFO,
	["Instance"] = LVBM_NAXX,
	["GUITab"] = LVBMGUI_TAB_NAXX,
	["Sort"] = 52,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
		["Whisper"] = false,
		["SetIcon"] = true,
		["RangeCheck"] = true,
	},
	["Events"] = {
		["CHAT_MSG_MONSTER_YELL"] = true,					-- Many
		["CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE"] = true,			-- Fissure
		["CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"] = true,				-- Frostblast / Detonate
		["CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE"] = true,		-- Frostblast / Detonate
		["CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE"] = true,			-- Frostblast / Detonate
	},
	["DropdownMenu"] = {
		[1] = {
			["variable"] = "LVBM.AddOns.Kelthuzad.Options.Whisper",
			["text"] = LVBM_SEND_WHISPER,
			["func"] = function() LVBM.AddOns.Kelthuzad.Options.Whisper = not LVBM.AddOns.Kelthuzad.Options.Whisper; end,
		},
		[2] = {
			["variable"] = "LVBM.AddOns.Kelthuzad.Options.SetIcon",
			["text"] = LVBM_SET_ICON,
			["func"] = function() LVBM.AddOns.Kelthuzad.Options.SetIcon = not LVBM.AddOns.Kelthuzad.Options.SetIcon; end,
		},
		[3] = {
			["variable"] = "LVBM.AddOns.Kelthuzad.Options.RangeCheck",
			["text"] = LVBM_KELTHUZAD_RANGECHECK,
			["func"] = function() LVBM.AddOns.Kelthuzad.Options.RangeCheck = not LVBM.AddOns.Kelthuzad.Options.RangeCheck; end,
		},
	},
	["InCombat"] = false,
	["IsRangeShown"] = false,
	["LastMindControl"] = 0,
	["LastFrostBlast"] = 0,
	["OnCombatStart"] = function()
		if (LVBM.AddOns.Kelthuzad.Options.RangeCheck and LVBMDistanceFrame and LVBMDistanceFrame:GetObject():IsShown()) then
			LVBM.AddOns.Kelthuzad.Options.IsRangeShown = true;
		else
			LVBM.AddOns.Kelthuzad.Options.IsRangeShown = false;
		end
	end,
	["OnCombatEnd"] = function()
		LVBM.AddOns.Kelthuzad.InCombat = false;
		if (LVBM.AddOns.Kelthuzad.Options.RangeCheck and not LVBM.AddOns.Kelthuzad.Options.IsRangeShown) then
			LVBM_Gui_DistanceFrame(false);
		end
	end,
	["OnEvent"] = function(event, arg1)
		if (event == "CHAT_MSG_MONSTER_YELL" and arg1 == LVBM_KELTHUZAD_PHASE1_EXPR) then		-- Phase 1 Start
			LVBM.AddOns.Kelthuzad.InCombat = true;
			LVBM.Announce( LVBM_KELTHUZAD_PHASE1_ANNOUNCE );
			LVBM.StartStatusBarTimer(320, "Phase 2");

		elseif (event == "CHAT_MSG_MONSTER_YELL" and arg1 == LVBM_KELTHUZAD_PHASE2_EXPR) then		-- Phase 2 Start
			if (LVBM.AddOns.Kelthuzad.Options.RangeCheck) then
				LVBM_Gui_DistanceFrame(true);
			end
			LVBM.Announce( LVBM_KELTHUZAD_PHASE2_ANNOUNCE );
			LVBM.EndStatusBarTimer("Phase 2");
			LVBM.StartStatusBarTimer(20, "Kel'Thuzad incoming");

		elseif (event == "CHAT_MSG_MONSTER_YELL" and arg1 == LVBM_KELTHUZAD_PHASE3_EXPR) then		-- Phase 3 Start
			LVBM.Announce( LVBM_KELTHUZAD_PHASE3_ANNOUNCE );

		elseif (event == "CHAT_MSG_MONSTER_YELL" and arg1 == LVBM_KELTHUZAD_GUARDIAN_EXPR) then		-- Guardian Warning
			LVBM.Announce( LVBM_KELTHUZAD_PHASE3_ANNOUNCE );
			LVBM.StartStatusBarTimer(10, "Guardians incoming");

		elseif (event == "CHAT_MSG_MONSTER_YELL" 
		   and (arg1 == LVBM_KELTHUZAD_MC_EXPR1 or arg1 == LVBM_KELTHUZAD_MC_EXPR2)
		   and (time() - LVBM.AddOns.Kelthuzad.LastMindControl) > 2 ) then				-- Mind Control
		   	LVBM.AddOns.Kelthuzad.LastMindControl = time();
			LVBM.Announce( LVBM_KELTHUZAD_MC_ANNOUNCE );
			LVBM.StartStatusBarTimer(20, "Mindcontrol");

		elseif (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" 
		    and arg1 == LVBM_KELTHUZAD_FISSURE_EXPR ) then						-- Fissure Warning
		    	LVBM.Announce( LVBM_KELTHUZAD_FISSURE_ANNOUNCE );

		elseif (event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"
		     or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE"
		     or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE") then					-- Frostblast // Detonate

			if ((time() - LVBM.AddOns.Kelthuzad.LastFrostBlast > 2) 
			 and string.find(arg1, LVBM_KELTHUZAD_FROSTBLAST_EXPR)) then
			   	LVBM.AddOns.Kelthuzad.LastFrostBlast = time();
				LVBM.Announce( LVBM_KELTHUZAD_FROSTBLAST_ANNOUNCE );
				LVBM.StartStatusBarTimer(25, "Frost Blast", true);
			end
		     	if (string.find(arg1, LVBM_KELTHUZAD_DETONATE_EXPR)) then
				local _, _, sArg1, sArg2 = string.find(arg1, LVBM_KELTHUZAD_DETONATE_EXPR);
				if (sArg1 == LVBM_YOU and sArg2 == LVBM_ARE) then
					sArg1 = UnitName("player");
					LVBM.AddSpecialWarning(LVBM_KELTHUZAD_DETONATE_SELFWARN);
					LVBM.StartStatusBarTimer(5, "Detonate Mana", true);

				elseif( LVBM.AddOns.Kelthuzad.Options.Whisper ) then
					LVBM.SendHiddenWhisper(LVBM_KELTHUZAD_DETONATE_WHISPER, sArg1);

				end
				if( LVBM.AddOns.Kelthuzad.Options.SetIcon ) then
					LVBM.SetIconByName(sArg1, 8);
					LVBM.Schedule(5, "LVBM.AddOns.Kelthuzad.OnEvent", "cleanicon", sArg1)
				end
				LVBM.Announce( string.format(LVBM_KELTHUZAD_DETONATE_ANNOUNCE, sArg1) );
				LVBM.StartStatusBarTimer(20, "Possible next Detonate");
			end

		elseif (event == "cleanicon" and arg1) then
			LVBM.ClearIconByName(arg1);
		end
	end,
}


