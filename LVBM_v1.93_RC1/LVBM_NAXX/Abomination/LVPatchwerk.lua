--
--  La Vendetta BossMod for Patchwerk v1.2
--
--  v1.0 Based on Tandanus Enrage Timer
--  v1.1 Modified version with HFS Announce
--  v1.2 Modified version by Nitram 
--  v1.3 Modified version by Nitram - bugfix Druid HFS

LVBM.AddOns.Patchwerk = {
	["Name"] = LVBM_PW_NAME,
	["Abbreviation1"] = "pw",
	["Version"] = "1.2",
	["Author"] = "La Vendetta|Nitram",
	["Description"] = LVBM_PW_DESCRIPTION,
	["Instance"] = LVBM_NAXX,
	["GUITab"] = LVBMGUI_TAB_NAXX,
	["Sort"] = 41,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
		["HatefulStrike"] = true,
	},
	["DropdownMenu"] = {
		[1] = {
			["variable"] = "LVBM.AddOns.Patchwerk.Options.HatefulStrike",
			["text"] = LVBM_PW_OPTION1,
			["func"] = function() LVBM.AddOns.Patchwerk.Options.HatefulStrike = not LVBM.AddOns.Patchwerk.Options.HatefulStrike; end,
		},
		[2] = {
			["variable"] = "false",
			["notCheckable"] = 1,
			["text"] = LVBM_PW_OPTION2,
			["func"] = function() LVBM.AddOns.Patchwerk.OnSlashCommand("stats"); end,
		},
	},
	["SlashCmdHelpText"] = {
		[1] = "/patchwerk stats - shows statistics for the last fight",
	},
	["Stats"] = {
		["damage"] = 0,
		["max"] = {
			["damage"] = 0,
			["target"] = "",
		},
		["hitsPerPlayer"] = {
		},
		["strikes"] = 0,
		["hits"] = 0,
		["misses"] = 0,
		["parries"] = 0,
		["dodges"] = 0,
	},
	["Events"] = {
		["CHAT_MSG_MONSTER_YELL"] = true,
		["CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE"] = true,
		["CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE"] = true,
		["CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE"] = true,
	},
	["OnSlashCommand"] = function(msg)
		if string.lower(msg) == "stats" then
			if LVBM.AddOns.Patchwerk.Stats.strikes > 0 then
				SendChatMessage(LVBM_PWSTATS_STATS , "RAID");
				SendChatMessage(string.format(LVBM_PWSTATS_STRIKES, LVBM.AddOns.Patchwerk.Stats.strikes, (LVBM.AddOns.Patchwerk.Stats.strikes/LVBM.AddOns.Patchwerk.Stats.strikes)*100), "RAID");
				SendChatMessage(string.format(LVBM_PWSTATS_HITS, LVBM.AddOns.Patchwerk.Stats.hits, (LVBM.AddOns.Patchwerk.Stats.hits/LVBM.AddOns.Patchwerk.Stats.strikes)*100), "RAID");
				SendChatMessage(string.format(LVBM_PWSTATS_DODGES, LVBM.AddOns.Patchwerk.Stats.dodges, (LVBM.AddOns.Patchwerk.Stats.dodges/LVBM.AddOns.Patchwerk.Stats.strikes)*100), "RAID");
				SendChatMessage(string.format(LVBM_PWSTATS_PARRIES, LVBM.AddOns.Patchwerk.Stats.parries, (LVBM.AddOns.Patchwerk.Stats.parries/LVBM.AddOns.Patchwerk.Stats.strikes)*100), "RAID");
				SendChatMessage(string.format(LVBM_PWSTATS_MISSES, LVBM.AddOns.Patchwerk.Stats.misses, (LVBM.AddOns.Patchwerk.Stats.misses/LVBM.AddOns.Patchwerk.Stats.strikes)*100), "RAID");
				SendChatMessage(string.format(LVBM_PWSTATS_AVG_DMG, LVBM.AddOns.Patchwerk.Stats.damage/LVBM.AddOns.Patchwerk.Stats.hits), "RAID");
				SendChatMessage(string.format(LVBM_PWSTATS_MAX_HIT, LVBM.AddOns.Patchwerk.Stats.max.damage, LVBM.AddOns.Patchwerk.Stats.max.target), "RAID");
				local hitsPerPlayer = {};
				for index, value in pairs(LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer) do
					if type(value) == "table" then
						table.insert(hitsPerPlayer, {["hits"] = value.hits, ["strikes"] = value.strikes, ["name"] = index});
					end
				end				
				table.sort(hitsPerPlayer, function(v1, v2) return v1.strikes > v2.strikes end);
				
				for index, value in pairs(hitsPerPlayer) do
					if value.hits > 2 then
						SendChatMessage(string.format(LVBM_PWSTATS_PER_PLAYER, value.strikes, value.name, value.hits), "RAID");
					end
				end
			else
				LVBM.AddMsg(LVBM_PWSTATS_NOT_AVAILABLE);
			end
			return true;
		end
	end,
	["OnEvent"] = function(event, arg1)
		if (event == "CHAT_MSG_MONSTER_YELL") then
			if (arg1 == LVBM_PW_YELL_1) or (arg1 == LVBM_PW_YELL_2) then
				LVBM.Announce(string.format(LVBM_PW_ENRAGE_WARNING, 7, LVBM_MINUTES));
				LVBM.Schedule(120, "LVBM.AddOns.Patchwerk.OnEvent", "EnrageWarning", 300);
				LVBM.Schedule(240, "LVBM.AddOns.Patchwerk.OnEvent", "EnrageWarning", 180);
				LVBM.Schedule(360, "LVBM.AddOns.Patchwerk.OnEvent", "EnrageWarning", 60);
				LVBM.Schedule(390, "LVBM.AddOns.Patchwerk.OnEvent", "EnrageWarning", 30);
				LVBM.Schedule(405, "LVBM.AddOns.Patchwerk.OnEvent", "EnrageWarning", 15);
				LVBM.Schedule(420, "LVBM.AddOns.Patchwerk.OnEvent", "EnrageWarning", 0);				
				LVBM.StartStatusBarTimer(420, "Enrage");
				LVBM.AddOns.Patchwerk.InCombat = true;
				LVBM.AddOns.Patchwerk.Stats = {
					["damage"] = 0,
					["max"] = {
						["damage"] = 0,
						["target"] = "",
					},
					["hitsPerPlayer"] = {
					},
					["strikes"] = 0,
					["hits"] = 0,
					["misses"] = 0,
					["parries"] = 0,
					["dodges"] = 0,
				};
			end

		elseif (event == "EnrageWarning") then
			if arg1 == 300 then
				LVBM.Announce(string.format(LVBM_PW_ENRAGE_WARNING, 5, LVBM_MINUTES));
			elseif arg1 == 180 then
				LVBM.Announce(string.format(LVBM_PW_ENRAGE_WARNING, 3, LVBM_MINUTES));
			elseif arg1 == 60 then
				LVBM.Announce(string.format(LVBM_PW_ENRAGE_WARNING, 1, LVBM_MINUTE));
			elseif arg1 == 30 then
				LVBM.Announce(string.format(LVBM_PW_ENRAGE_WARNING, 30, LVBM_SECONDS));
			elseif arg1 == 15 then
				LVBM.Announce(string.format(LVBM_PW_ENRAGE_WARNING, 15, LVBM_SECONDS));
			end
		elseif (event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE") 
		    or (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") 
		    or (event == "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE") then
			local announceHS = false;
			if LVBM.AddOns.Patchwerk.Options.HatefulStrike and LVBM.AddOns.Patchwerk.Options.Announce and LVBM.Rank >= 1 then
				announceHS = true;
			end
			local _, _, target, damage;
			if string.find(arg1, LVBM_PW_HS_YOU_HIT) then
				_, _, damage = string.find(arg1, LVBM_PW_HS_YOU_HIT);
				target = UnitName("player");
				if announceHS then
					SendChatMessage(string.format(LVBM_PW_HS_ANNOUNCE, UnitName("player"), damage), "RAID");
				end
				LVBM.AddOns.Patchwerk.Stats.strikes = LVBM.AddOns.Patchwerk.Stats.strikes + 1;
				LVBM.AddOns.Patchwerk.Stats.hits = LVBM.AddOns.Patchwerk.Stats.hits + 1;
				LVBM.AddOns.Patchwerk.Stats.damage = LVBM.AddOns.Patchwerk.Stats.damage + (tonumber(damage) or 0);
				if not LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target] then
					LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target] = {};
					LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].strikes = 0;
					LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].hits = 0;
				end
				LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].strikes = LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].strikes + 1;
				LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].hits = LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].hits + 1;
				
				if (tonumber(damage) or 0) > LVBM.AddOns.Patchwerk.Stats.max.damage then
					LVBM.AddOns.Patchwerk.Stats.max.damage = (tonumber(damage) or 0);
					LVBM.AddOns.Patchwerk.Stats.max.target = UnitName("player");
				end

			elseif string.find(arg1, LVBM_PW_HS_YOU_MISS) then
				target = UnitName("player");
				LVBM.AddOns.Patchwerk.Stats.strikes = LVBM.AddOns.Patchwerk.Stats.strikes + 1;
				LVBM.AddOns.Patchwerk.Stats.misses = LVBM.AddOns.Patchwerk.Stats.misses + 1;
				if not LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target] then
					LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target] = {};
					LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].strikes = 0;
					LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].hits = 0;
				end
				LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].strikes = LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].strikes + 1;

				if announceHS then
					SendChatMessage(string.format(LVBM_PW_HS_ANNOUNCE, UnitName("player"), LVBM_MISS), "RAID");
				end

			elseif string.find(arg1, LVBM_PW_HS_YOU_DODGE) then
				target = UnitName("player");
				LVBM.AddOns.Patchwerk.Stats.strikes = LVBM.AddOns.Patchwerk.Stats.strikes + 1;
				LVBM.AddOns.Patchwerk.Stats.dodges = LVBM.AddOns.Patchwerk.Stats.dodges + 1;
				if not LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target] then
					LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target] = {};
					LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].strikes = 0;
					LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].hits = 0;
				end
				LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].strikes = LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].strikes + 1;
				
				if announceHS then
					SendChatMessage(string.format(LVBM_PW_HS_ANNOUNCE, UnitName("player"), LVBM_DODGE), "RAID");
				end

			elseif string.find(arg1, LVBM_PW_HS_YOU_PARRY) then
				target = UnitName("player");
				LVBM.AddOns.Patchwerk.Stats.strikes = LVBM.AddOns.Patchwerk.Stats.strikes + 1;
				LVBM.AddOns.Patchwerk.Stats.parries = LVBM.AddOns.Patchwerk.Stats.parries + 1;
				if not LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target] then
					LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target] = {};
					LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].strikes = 0;
					LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].hits = 0;
				end
				LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].strikes = LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].strikes + 1;
				
				if announceHS then
					SendChatMessage(string.format(LVBM_PW_HS_ANNOUNCE, UnitName("player"), LVBM_PARRY), "RAID");
				end

			elseif string.find(arg1, LVBM_PW_HS_PARTY_HIT) then
				_, _, target, damage = string.find(arg1, LVBM_PW_HS_PARTY_HIT);
				LVBM.AddOns.Patchwerk.Stats.strikes = LVBM.AddOns.Patchwerk.Stats.strikes + 1;
				LVBM.AddOns.Patchwerk.Stats.hits = LVBM.AddOns.Patchwerk.Stats.hits + 1;
				LVBM.AddOns.Patchwerk.Stats.damage = LVBM.AddOns.Patchwerk.Stats.damage + (tonumber(damage) or 0);
				if not LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target] then
					LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target] = {};
					LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].strikes = 0;
					LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].hits = 0;
				end
				LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].strikes = LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].strikes + 1;
				LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].hits = LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].hits + 1;
				
				if (tonumber(damage) or 0) > LVBM.AddOns.Patchwerk.Stats.max.damage then
					LVBM.AddOns.Patchwerk.Stats.max.damage = (tonumber(damage) or 0);
					LVBM.AddOns.Patchwerk.Stats.max.target = target;
				end
				if announceHS then
					SendChatMessage(string.format(LVBM_PW_HS_ANNOUNCE, target, damage), "RAID");
				end

			elseif string.find(arg1, LVBM_PW_HS_PARTY_MISS) then
				_, _, target = string.find(arg1, LVBM_PW_HS_PARTY_MISS);
				LVBM.AddOns.Patchwerk.Stats.strikes = LVBM.AddOns.Patchwerk.Stats.strikes + 1;
				LVBM.AddOns.Patchwerk.Stats.misses = LVBM.AddOns.Patchwerk.Stats.misses + 1;
				if not LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target] then
					LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target] = {};
					LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].strikes = 0;
					LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].hits = 0;
				end
				LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].strikes = LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].strikes + 1;
				
				if announceHS then
					SendChatMessage(string.format(LVBM_PW_HS_ANNOUNCE, target, LVBM_MISS), "RAID");
				end

			elseif string.find(arg1, LVBM_PW_HS_PARTY_DODGE) then
				_, _, target = string.find(arg1, LVBM_PW_HS_PARTY_DODGE);
				LVBM.AddOns.Patchwerk.Stats.strikes = LVBM.AddOns.Patchwerk.Stats.strikes + 1;
				LVBM.AddOns.Patchwerk.Stats.dodges = LVBM.AddOns.Patchwerk.Stats.dodges + 1;
				if not LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target] then
					LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target] = {};
					LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].strikes = 0;
					LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].hits = 0;
				end
				LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].strikes = LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].strikes + 1;
				
				if announceHS then
					SendChatMessage(string.format(LVBM_PW_HS_ANNOUNCE, target, LVBM_DODGE), "RAID");
				end

			elseif string.find(arg1, LVBM_PW_HS_PARTY_PARRY) then
				_, _, target = string.find(arg1, LVBM_PW_HS_PARTY_PARRY);
				LVBM.AddOns.Patchwerk.Stats.strikes = LVBM.AddOns.Patchwerk.Stats.strikes + 1;
				LVBM.AddOns.Patchwerk.Stats.parries = LVBM.AddOns.Patchwerk.Stats.parries + 1;
				if not LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target] then
					LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target] = {};
					LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].strikes = 0;
					LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].hits = 0;
				end
				LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].strikes = LVBM.AddOns.Patchwerk.Stats.hitsPerPlayer[target].strikes + 1;
				
				if announceHS then
					SendChatMessage(string.format(LVBM_PW_HS_ANNOUNCE, target, LVBM_PARRY), "RAID");
				end
			end
		end
	end,
};
