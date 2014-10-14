LVBM.AddOns.Chromaggus = {
	["Name"] = LVBM_CHROMAGGUS_NAME,
	["Abbreviation1"] = "chrom",
	["Version"] = "1.2",
	["Author"] = "Tandanu",
	["Description"] = LVBM_CHROMAGGUS_DESCRIPTION,
	["Instance"] = LVBM_BWL,
	["GUITab"] = LVBMGUI_TAB_BWL,
	["Sort"] = 7,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
		["Frenzy"] = true,
		["Vulnerability"] = true,
	},
	["InCombat"] = false,
	["Breath1"] = LVBM_CHROMAGGUS_BREATH_1,
	["Breath2"] = LVBM_CHROMAGGUS_BREATH_2,
	["Vulnerability"] = "",
	["InCombat"] = false,
	["DropdownMenu"] = {
		[1] = {
			["variable"] = "LVBM.AddOns.Chromaggus.Options.Frenzy",
			["text"] = LVBM_CHROMAGGUS_ANNOUNCE_FRENZY,
			["func"] = function() LVBM.AddOns.Chromaggus.Options.Frenzy = not LVBM.AddOns.Chromaggus.Options.Frenzy; end,
		},
		[2] = {
			["variable"] = "LVBM.AddOns.Chromaggus.Options.Vulnerability",
			["text"] = LVBM_CHROMAGGUS_ANNOUNCE_VULNERABILITY,
			["func"] = function() LVBM.AddOns.Chromaggus.Options.Vulnerability = not LVBM.AddOns.Chromaggus.Options.Vulnerability; end,
		},
	},
	["Events"] = {
		["CHAT_MSG_MONSTER_EMOTE"] = true,
		["CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE"] = true,
		["CHAT_MSG_SPELL_SELF_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PARTY_DAMAGE"] = true,
		["CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE"] = true,
	},
	["OnCombatStart"] = function(delay)
		LVBM.Schedule(22 - delay, "LVBM.AddOns.Chromaggus.OnEvent", "BreathWarning", 1);
		LVBM.Schedule(54 - delay, "LVBM.AddOns.Chromaggus.OnEvent", "BreathWarning", 2);
		LVBM.StartStatusBarTimer(30 - delay, "Breath 1");
		LVBM.StartStatusBarTimer(60 - delay, "Breath 2");
	end,
	["OnEvent"] = function(event, arg1)
		if event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" and arg1 then
			local breath;
			_, _, breath = string.find(arg1, LVBM_CHROMAGGUS_BREATH_REGEXP);
			if breath then
				LVBM.AddOns.Chromaggus.InCombat = true;
				if LVBM.AddOns.Chromaggus.Breath1 == LVBM_CHROMAGGUS_BREATH_1 then
					LVBM.EndStatusBarTimer("Breath 1");
					LVBM.AddOns.Chromaggus.Breath1 = breath;
				elseif LVBM.AddOns.Chromaggus.Breath2 == LVBM_CHROMAGGUS_BREATH_2 then
					LVBM.EndStatusBarTimer("Breath 2");
					LVBM.AddOns.Chromaggus.Breath2 = breath;
				end
				
				LVBM.Announce(string.format(LVBM_CHROMAGGUS_BREATH_CAST_WARNING, breath));
				
				LVBM.EndStatusBarTimer(breath);
				LVBM.StartStatusBarTimer(2, breath.." cast");
				LVBM.Schedule(2, "LVBM.AddOns.Chromaggus.OnEvent", "StartNewBreathTimer", breath);
			end
		elseif event == "StartNewBreathTimer" and arg1 then
			LVBM.EndStatusBarTimer(tostring(arg1));
			LVBM.StartStatusBarTimer(60, tostring(arg1));
			if arg1 == LVBM.AddOns.Chromaggus.Breath1 then
				LVBM.Schedule(50, "LVBM.AddOns.Chromaggus.OnEvent", "BreathWarning", 1);
			elseif arg1 == LVBM.AddOns.Chromaggus.Breath2 then
				LVBM.Schedule(50, "LVBM.AddOns.Chromaggus.OnEvent", "BreathWarning", 2);
			end
		elseif event == "BreathWarning" then
			if arg1 then
				LVBM.Announce(string.format(LVBM_CHROMAGGUS_BREATH_WARNING, LVBM.AddOns.Chromaggus['Breath'..tostring(arg1)]));
			end
		elseif event == "CHAT_MSG_SPELL_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_PARTY_DAMAGE" or event == "CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE" then		
			if LVBM.AddOns.Chromaggus.Options.Vulnerability and LVBM.AddOns.Chromaggus.Vulnerability == "" then
				local hitcrit, damage, damagetype;
				_, _, hitcrit, damage, damagetype = string.find(arg1, LVBM_CHROMAGGUS_VULNERABILITY_REGEXP);
				
				if (hitcrit == LVBM_HITS or hitcrit == LVBM_CRITS) and tonumber(damage) and damagetype then
					LVBM.AddOns.Chromaggus.InCombat = true;
					if (hitcrit == LVBM_HITS and tonumber(damage) >= 666) or (hitcrit == LVBM_CRITS and tonumber(damage) >= 1337) then
						LVBM.AddOns.Chromaggus.Vulnerability = damagetype;
						LVBM.Announce("*** New vulnerability: "..damagetype.." ***");
					end
				end
			end
		elseif event == "CHAT_MSG_MONSTER_EMOTE" then
			if arg1 == LVBM_CHROMAGGUS_FRENZY_EXPR and arg2 == LVBM_CHROMAGGUS_CHROMAGGUS then
				LVBM.EndStatusBarTimer("Frenzy")
				LVBM.StartStatusBarTimer(15.6, "Frenzy");
				if LVBM.AddOns.Chromaggus.Options.Frenzy then
					LVBM.Announce(LVBM_CHROMAGGUS_FRENZY_ANNOUNCE);
				end
			elseif arg1 == LVBM_CHROMAGGUS_VULNERABILITY_EXPR and arg2 == LVBM_CHROMAGGUS_CHROMAGGUS then
				if LVBM.AddOns.Chromaggus.Options.Vulnerability then
					LVBM.Announce(LVBM_CHROMAGGUS_VULNERABILITY_ANNOUNCE);
					LVBM.Schedule(3, "LVBM.AddOns.Chromaggus.OnEvent", "ClearVulnerability");
				end
			end
		elseif event == "ClearVulnerability" then
			LVBM.AddOns.Chromaggus.Vulnerability = "";
		end
	end,
	["OnCombatEnd"] = function()
		LVBM.AddOns.Chromaggus.Breath1 = "Breath 1";
		LVBM.AddOns.Chromaggus.Breath2 = "Breath 2";
		LVBM.AddOns.Chromaggus.Vulnerability = "";
	end,
};
