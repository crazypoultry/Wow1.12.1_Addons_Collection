LVBM.AddOns.Loatheb = {
	["Name"] = LVBM_LOATHEB_NAME,
	["Abbreviation1"] = "Loa",
	["Abbreviation2"] = "Lolotheb",
	["Version"] = "1.0",
	["Author"] = "Tandanu",
	["Description"] = LVBM_LOATHEB_DESCRIPTION,
	["SlashCmdHelpText"] = {
		[1] = "/loatheb setup - shows a dialog to setup the heal rotation",
		[2] = "/loatheb show - shows the heal rotation dialog",
		[3] = "/loatheb hide - hides the heal rotation dialog",
		[4] = "/loatheb broadcast - sends the healer setup to the raid chat (alias: /loatheb bc)",
		[5] = "/loatheb undelete - undeletes deleted healers, set a healer's sort ID to 0 to delete him",
	},
	["Instance"] = LVBM_NAXX,
	["GUITab"] = LVBMGUI_TAB_NAXX,
	["Sort"] = 33,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
		["AnnounceHealRaid"] = true,
		["AnnounceHealRaidWarning"] = false,
		["AnnounceHealWhisper"] = false,
		["ShowHealFrame"] = true,
		["FrameLocked"] = false,
		["PotAnnounce"] = true,
		["PotSpecialWarning"] = true,
		["AnnounceSpores"] = true,
		["AnnounceSporesBackward"] = false,
	},
	["InCombat"] = false,
	["CastingDoom"] = false,
	["DoomCounter"] = 0,
	["CountSpore"] = 0,
	["Healers"] = {
	},
	["DeletedHealers"] = {
	},
	["LongMsg"] = "",
	["HealersSorted"] = false,
	["SpamProt"] = {
	},
	["AutoShown"] = false,
	["DropdownMenu"] = {
		[1] = {
			["variable"] = "LVBM.AddOns.Loatheb.Options.AnnounceSpores",
			["text"] = LVBM_LOATHEB_ANNOUNCE_SPORES,
			["func"] = function() LVBM.AddOns.Loatheb.Options.AnnounceSpores = not LVBM.AddOns.Loatheb.Options.AnnounceSpores; end,
		},		
--[[	[2] = {
			["variable"] = "LVBM.AddOns.Loatheb.Options.AnnounceSporesBackward",
			["text"] = LVBM_LOATHEB_ANNOUNCE_SPORES_BACKWARDS,
			["func"] = function() LVBM.AddOns.Loatheb.Options.AnnounceSporesBackward = not LVBM.AddOns.Loatheb.Options.AnnounceSporesBackward; end,
		},]]
		[2] = {
			["variable"] = "LVBM.AddOns.Loatheb.Options.AnnounceHealRaid",
			["text"] = LVBM_LOATHEB_HEAL_RAID,
			["func"] = function() LVBM.AddOns.Loatheb.Options.AnnounceHealRaid = not LVBM.AddOns.Loatheb.Options.AnnounceHealRaid; end,
		},
		[3] = {
			["variable"] = "LVBM.AddOns.Loatheb.Options.AnnounceHealRaidWarning",
			["text"] = LVBM_LOATHEB_HEAL_RAID_WARN,
			["func"] = function() LVBM.AddOns.Loatheb.Options.AnnounceHealRaidWarning = not LVBM.AddOns.Loatheb.Options.AnnounceHealRaidWarning; end,
		},
		[4] = {
			["variable"] = "LVBM.AddOns.Loatheb.Options.AnnounceHealWhisper",
			["text"] = LVBM_LOATHEB_HEAL_WHISPER,
			["func"] = function() LVBM.AddOns.Loatheb.Options.AnnounceHealWhisper = not LVBM.AddOns.Loatheb.Options.AnnounceHealWhisper; end,
		},
		[5] = {
			["variable"] = "LVBM.AddOns.Loatheb.Options.PotAnnounce",
			["text"] = LVBM_LOATHEB_ANNOUNCE_POT_OPTION,
			["func"] = function() LVBM.AddOns.Loatheb.Options.PotAnnounce = not LVBM.AddOns.Loatheb.Options.PotAnnounce; end,
		},
		[6] = {
			["variable"] = "LVBM.AddOns.Loatheb.Options.PotSpecialWarning",
			["text"] = LVBM_LOATHEB_SPECIALWARN_POT_OPTION,
			["func"] = function() LVBM.AddOns.Loatheb.Options.PotSpecialWarning = not LVBM.AddOns.Loatheb.Options.PotSpecialWarning; end,
		},
		[7] = {
			["variable"] = "LVBM.AddOns.Loatheb.Options.ShowHealFrame",
			["text"] = LVBM_LOATHEB_HEAL_SHOW_AUTO,
			["func"] = function() LVBM.AddOns.Loatheb.Options.ShowHealFrame = not LVBM.AddOns.Loatheb.Options.ShowHealFrame; end,
		},
		[8] = {
			["variable"] = "LVBMLoathebFrameDrag:IsShown()",
			["text"] = LVBM_LOATHEB_HEAL_SHOW_NOW,
			["func"] = function() if LVBMLoathebFrameDrag:IsShown() then LVBMLoathebFrameDrag:Hide(); else LVBMLoathebFrameDrag:Show(); end end,
		},
		[9] = {
			["variable"] = "LVBMLoathebFrameDrag.ConfigMode",
			["text"] = LVBM_LOATHEB_HEAL_SETUP,
			["func"] = function() LVBM.AddOns.Loatheb.OnSlashCommand("setup") end,
		},		
	},
	["Events"] = {
		["CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF"] = true,
		["CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE"] = true,
	},
	["OnUpdate"] = function(elapsed)
		LVBM.AddOns.Loatheb.OnEvent("UpdateHealerFrame", elapsed);
	end,
	["OnLoad"] = function()
		if UnitClass("player") == LVBM_PRIEST or UnitClass("player") == LVBM_DRUID or UnitClass("player") == LVBM_PALADIN or UnitClass("player") == LVBM_SHAMAN then
			LVBM.AddOns.Loatheb.Options.ShowHealFrame = true;
		else
			LVBM.AddOns.Loatheb.Options.ShowHealFrame = false;
		end
	end,
	["OnSlashCommand"] = function(msg)
		if string.lower(msg) == "show" then
			LVBMLoathebFrameDrag:Show();
			return true;
		elseif string.lower(msg) == "hide" then
			LVBMLoathebFrameDrag:Hide();
			return true;
		elseif string.lower(msg) == "setup" or string.lower(msg) == "config" then
				LVBMLoathebFrameDrag:Show();
				LVBMLoathebFrameDrag.ConfigMode = true;
			if LVBM.Rank >= 1 then
				LVBMLoathebButton:SetText(LVBM_LOATHEB_SET_HEAL_ROTATION);
			else
				LVBM.AddMsg(LVBM_LOATHEB_NO_BC_INFO);
				LVBMLoathebButton:SetText(LVBM_LOATHEB_SET_HEAL_ROTATION_NO_BC);
			end
			return true;
		elseif string.lower(msg) == "broadcast" or string.lower(msg) == "bc" then
			local healerSetup = {};
			local i = 1;
			local j = 1;
			while LVBM.AddOns.Loatheb.Healers[i] do
				if not healerSetup[j] then
					healerSetup[j] = "";
				end
				if string.len(healerSetup[j]..i..". "..LVBM.AddOns.Loatheb.Healers[i].Name.." / ") < 254 then
					healerSetup[j] = healerSetup[j]..i..". "..LVBM.AddOns.Loatheb.Healers[i].Name.." / ";
				else
					j = j + 1;
					if not healerSetup[j] then
						healerSetup[j] = "";
					end
					healerSetup[j] = healerSetup[j]..i..". "..LVBM.AddOns.Loatheb.Healers[i].Name.." / ";
				end
				i = i + 1;
			end
			for index, value in pairs(healerSetup) do
				healerSetup[index] = string.gsub(healerSetup[index], " / $", "");
				SendChatMessage(healerSetup[index], "RAID");
			end
			LVBM.AddOns.Loatheb.OnEvent("SendHealList");
			return true;
		elseif string.lower(msg) == "undelete" then
			LVBM.AddOns.Loatheb.DeletedHealers = {};
			LVBM.AddOns.Loatheb.OnEvent("RAID_ROSTER_UPDATE");
			return true;
		end
	end,
	["OnCombatStart"] = function(delay)
		LVBM.AddOns.Loatheb.InCombat = true;
		LVBM.AddOns.Loatheb.DoomCounter = 0;
		LVBM.AddOns.Loatheb.CastingDoom = false;
		LVBM.Schedule(110 - delay, "LVBM.AddOns.Loatheb.OnEvent", "DoomWarning", 10);
		LVBM.StartStatusBarTimer(120 - delay, "Inevitable Doom");
		if LVBM.AddOns.Loatheb.Options.ShowHealFrame and not LVBMLoathebFrameDrag:IsShown() then
			LVBMLoathebFrameDrag:Show();
			LVBM.AddOns.Loatheb.AutoShown = true;
		end
	end,
	["OnEvent"] = function(event, arg1)
		if event == "CHAT_MSG_ADDON" and arg3 == "RAID" then
			if arg1 == "LVBMLOATHEB" then
				if arg2 == "REQLIST" then
					if LVBM.Rank >= 1 then
						LVBM.AddOns.Loatheb.OnEvent("SendHealList");
					end
				end
			elseif arg1 == "LVBMLOALISTL" and arg2 then
				local rank;
				for i = 1, GetNumRaidMembers() do
					if UnitName("raid"..i) == arg4 then
						_, _, rank = GetRaidRosterInfo(i);
						break;
					end
				end
				if rank >= 1 then
					LVBM.AddOns.Loatheb.LongMsg = LVBM.AddOns.Loatheb.LongMsg..arg2;
				end
			elseif arg1 == "LVBMLOALISTS" and arg2 then
				local rank;
				for i = 1, GetNumRaidMembers() do
					if UnitName("raid"..i) == arg4 then
						_, _, rank = GetRaidRosterInfo(i);
						break;
					end
				end
				if rank >= 1 then
					arg2 = LVBM.AddOns.Loatheb.LongMsg..arg2;
					LVBM.AddOns.Loatheb.LongMsg = "";
					LVBM.AddOns.Loatheb.DeletedHealers = {};
					LVBM.AddOns.Loatheb.OnEvent("RAID_ROSTER_UPDATE");
					for sort, player in string.gfind(arg2, "(%d+)([^%s]-) ") do
						for index, value in pairs(LVBM.AddOns.Loatheb.Healers) do
							if value.Name and value.Name == player and tonumber(sort) then
								LVBM.AddOns.Loatheb.Healers[index].Sort = tonumber(sort);
								break;
							end
						end
					end
					for index, value in pairs(LVBM.AddOns.Loatheb.Healers) do
						if value and value.Sort == 0 then
							LVBM.AddOns.Loatheb.DeletedHealers[value.Name] = true;
							table.remove(LVBM.AddOns.Loatheb.Healers, index);
						elseif value and value.Sort ~= 0 and LVBM.AddOns.Loatheb.DeletedHealers[value.Name] then
							LVBM.AddOns.Loatheb.DeletedHealers[value.Name] = nil;
						end
					end
					LVBM.AddOns.Loatheb.OnEvent("RAID_ROSTER_UPDATE");
					LVBM.AddOns.Loatheb.HealersSorted = true;
					table.sort(LVBM.AddOns.Loatheb.Healers, function(v1, v2) return v1.Sort < v2.Sort end);
				end
			elseif arg1 == "LVBMLOAHEAL" and arg2 then
				if LVBM.AddOns.Loatheb.SpamProt[arg2] then
					return;
				end
				LVBM.AddOns.Loatheb.SpamProt[arg2] = 1;
				LVBM.AddOns.Loatheb.OnEvent("DetectHeal", arg2);
			end
		elseif event == "PotionWarning" then
			local pot;
			if LVBM.AddOns.Loatheb.DoomCounter == 1 then --2:10
				pot = LVBM_LOATHEB_SHADOW_PROT_POT;
			elseif LVBM.AddOns.Loatheb.DoomCounter == 2 then --2:40
				--shadow protection potion active 
			elseif LVBM.AddOns.Loatheb.DoomCounter == 3 then --3:10
				pot = LVBM_LOATHEB_BANDAGE
			elseif LVBM.AddOns.Loatheb.DoomCounter == 4 then --3:40
				pot = LVBM_LOATHEB_HEALTHSTONE
			elseif LVBM.AddOns.Loatheb.DoomCounter == 5 then --4:10
				pot = LVBM_LOATHEB_SHADOW_PROT_POT.."/"..LVBM_LOATHEB_BANDAGE;
			elseif LVBM.AddOns.Loatheb.DoomCounter == 6 then --4:40 
				--shadow protection potion active
			elseif LVBM.AddOns.Loatheb.DoomCounter == 7 then --5:10
				pot = LVBM_LOATHEB_BANDAGE 
			elseif LVBM.AddOns.Loatheb.DoomCounter == 8 then --5:25 (enrage --> 15 sec CD)
				--Loatheb should be dead
			elseif LVBM.AddOns.Loatheb.DoomCounter == 9 then --5:40
				--okay, wipe :)
			end
			if pot then
				if LVBM.AddOns.Loatheb.Options.PotSpecialWarning then
					LVBM.AddSpecialWarning(string.format(LVBM_LOATHEB_POT_WARNING, pot), true, true);
				end
				if LVBM.AddOns.Loatheb.Options.PotAnnounce and LVBM.AddOns.Loatheb.Options.Announce and LVBM.Rank >= 1 then
					LVBM.Announce(string.format(LVBM_LOATHEB_POT_ANNOUNCE, pot));
				end
			end
		elseif event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" then
			if string.find(arg1, LVBM_LOATHEB_DOOM_REGEXP) and not LVBM.AddOns.Loatheb.CastingDoom then
				LVBM.AddOns.Loatheb.CastingDoom = true;
				LVBM.AddOns.Loatheb.DoomCounter = LVBM.AddOns.Loatheb.DoomCounter + 1;
				LVBM.Schedule(10, "LVBM.AddOns.Loatheb.OnEvent", "PotionWarning");
				if LVBM.AddOns.Loatheb.DoomCounter <= 7 then
					LVBM.Announce(string.format(LVBM_LOATHEB_DOOM_NOW, LVBM.AddOns.Loatheb.DoomCounter, 30))
					LVBM.Schedule(25, "LVBM.AddOns.Loatheb.OnEvent", "DoomWarning", 5);
					LVBM.StartStatusBarTimer(30, "Inevitable Doom");
				else
					LVBM.Announce(string.format(LVBM_LOATHEB_DOOM_NOW, LVBM.AddOns.Loatheb.DoomCounter, 15))
					LVBM.Schedule(10, "LVBM.AddOns.Loatheb.OnEvent", "DoomWarning", 5);
					LVBM.StartStatusBarTimer(15, "Inevitable Doom");
				end
			elseif string.find(arg1, LVBM_LOATHEB_HEAL_REGEXP) then
				local sArg1, sArg2;
				_, _, sArg1, sArg2 = string.find(arg1, LVBM_LOATHEB_HEAL_REGEXP)
				if sArg1 == LVBM_YOU and sArg2 == LVBM_ARE then
					sArg1 = UnitName("player");
				end				
				if sArg1 and LVBM.AddOns.Loatheb.InCombat then
					for i = 1, GetNumRaidMembers() do
						if UnitName("raid"..i) == sArg1 then
							if UnitClass("raid"..i) == LVBM_PRIEST or UnitClass("raid"..i) == LVBM_PALADIN or UnitClass("raid"..i) == LVBM_DRUID or UnitClass("raid"..i) == LVBM_SHAMAN then
								local j, texture, foundDebuff;
								j = 1;
								while UnitDebuff("raid"..i, j) do
									texture = UnitDebuff("raid"..i, j);
									j = j + 1;
									if texture == "Interface\\Icons\\Spell_Shadow_AuraOfDarkness" then
--									if texture == "Interface\\Icons\\Spell_Holy_AshesToAshes" then
										foundDebuff = true;
										break;
									end
								end
								if not foundDebuff then
									return;
								end
								for index, value in pairs(LVBM.AddOns.Loatheb.Healers) do
									if value.Name == sArg1 then
										if not value.Cooldown then
											LVBM.AddOns.Loatheb.OnEvent("DetectHeal", sArg1);
											if not LVBM.AddOns.Loatheb.SpamProt[sArg1] then
												SendAddonMessage("LVBMLOAHEAL", sArg1, "RAID");
												LVBM.AddOns.Loatheb.SpamProt[sArg1] = 1;
											end											
										end
										break;
									end
								end
							end
							break;
						end
					end
				end
			end
		elseif event == "GetNextHealer" and arg1 then
			if not arg1 then
				return;
			end
			local unitIDs = {};
			local i = arg1 + 1;
			for i = 1, GetNumRaidMembers() do
				if UnitClass("raid"..i) == LVBM_PRIEST or UnitClass("raid"..i) == LVBM_PALADIN or UnitClass("raid"..i) == LVBM_DRUID or UnitClass("raid"..i) == LVBM_SHAMAN then
					unitIDs[UnitName("raid"..i)] = "raid"..i;
				end
			end
			while LVBM.AddOns.Loatheb.Healers[i] do
				if not UnitIsDeadOrGhost(unitIDs[LVBM.AddOns.Loatheb.Healers[i].Name]) and UnitIsConnected(unitIDs[LVBM.AddOns.Loatheb.Healers[i].Name]) then
					return i, LVBM.AddOns.Loatheb.Healers[i].Name;
				end
				i = i + 1;
			end
			i = 1;
			while LVBM.AddOns.Loatheb.Healers[i] and i < arg1 do
				if not UnitIsDeadOrGhost(unitIDs[LVBM.AddOns.Loatheb.Healers[i].Name]) and UnitIsConnected(unitIDs[LVBM.AddOns.Loatheb.Healers[i].Name]) then
					return i, LVBM.AddOns.Loatheb.Healers[i].Name;
				end
				i = i + 1;
			end
		elseif event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF" then
			if arg1 == LVBM_LOATHEB_REMOVE_CURSE then
				LVBM.Announce(LVBM_LOATHEB_DECURSE_NOW);
			--	LVBM.Schedule(25, "LVBM.AddOns.Loatheb.OnEvent", "DecurseWarning", 5);
				LVBM.StartStatusBarTimer(30, "Decurse");
			elseif arg1 == LVBM_LOATHEB_SUMMON_SPORE then
				if LVBM.AddOns.Loatheb.Options.AnnounceSpores then
--[[				-- Grp #1 always the MT Group
					if( LVBM.AddOns.Loatheb.Options.AnnounceSporesBackward ) then
						if( LVBM.AddOns.Loatheb.CountSpore <= 1 ) then 		LVBM.AddOns.Loatheb.CountSpore = 9;
						end
						LVBM.AddOns.Loatheb.CountSpore = LVBM.AddOns.Loatheb.CountSpore - 1;
					else
						if( LVBM.AddOns.Loatheb.CountSpore >= 8 ) then 		LVBM.AddOns.Loatheb.CountSpore = 0;
						end
						LVBM.AddOns.Loatheb.CountSpore = LVBM.AddOns.Loatheb.CountSpore + 1;
					end]]
					LVBM.AddOns.Loatheb.CountSpore = LVBM.AddOns.Loatheb.CountSpore + 1;
					LVBM.Announce(string.format(LVBM_LOATHEB_SPORE_SPAWNED, LVBM.AddOns.Loatheb.CountSpore));
				end
				LVBM.StartStatusBarTimer(12, "Spore");
			end
		elseif event == "DoomWarning" then
			if arg1 and arg1 > 0 then
				LVBM.Announce(string.format(LVBM_LOATHEB_DOOM_WARNING, (LVBM.AddOns.Loatheb.DoomCounter + 1), arg1));
				LVBM.AddOns.Loatheb.CastingDoom = false;
			end
		elseif event == "DecurseWarning" then
			if arg1 and arg1 > 0 then
				LVBM.Announce(string.format(LVBM_LOATHEB_DECURSE_WARNING, arg1));
			end
		elseif event == "PLAYER_LOGIN" then
			LVBM.AddOns.Loatheb.OnEvent("RAID_ROSTER_UPDATE");
		elseif event == "RAID_ROSTER_UPDATE" then
			if GetNumRaidMembers() <= 1 then
				LVBM.AddOns.Loatheb.Healers = {};
				LVBM.AddOns.Loatheb.HealersSorted = false;
			end
			local playersInRaidGrp = {};
			for i = 1, GetNumRaidMembers() do
				if UnitClass("raid"..i) == LVBM_PRIEST or UnitClass("raid"..i) == LVBM_PALADIN or UnitClass("raid"..i) == LVBM_DRUID or UnitClass("raid"..i) == LVBM_SHAMAN then
					local exists;
					playersInRaidGrp[UnitName("raid"..i)] = UnitClass("raid"..i);
					for index, value in pairs(LVBM.AddOns.Loatheb.Healers) do
						if value.Name and value.Name == UnitName("raid"..i) then
							exists = true;
							break;
						end
					end
					if not exists and not LVBM.AddOns.Loatheb.DeletedHealers[UnitName("raid"..i)] then
						table.insert(LVBM.AddOns.Loatheb.Healers, {["Name"] = UnitName("raid"..i), ["Class"] = UnitClass("raid"..i), ["Cooldown"] = false, ["Sort"] = 99})
						if not LVBM.AddOns.Loatheb.HealersSorted then
							table.sort(LVBM.AddOns.Loatheb.Healers, function(v1, v2) return v1.Name < v2.Name end)
						end
					end
				end				
			end
			for index, value in pairs(LVBM.AddOns.Loatheb.Healers) do
				if value and value.Name and not playersInRaidGrp[value.Name] then
					table.remove(LVBM.AddOns.Loatheb.Healers, index);
				end
			end
			local frameCount = 1;
			while getglobal("LVBMLoathebHealerFrame"..frameCount) and getglobal("LVBMLoathebHealerFrame"..frameCount):IsShown() do
				frameCount = frameCount + 1;
			end
			frameCount = frameCount - 1;
			for i = (frameCount + 1), table.getn(LVBM.AddOns.Loatheb.Healers) do
				if getglobal("LVBMLoathebHealerFrame"..i) then
					getglobal("LVBMLoathebHealerFrame"..i):Show();					
				else
					local newFrame;
					newFrame = CreateFrame("Frame", "LVBMLoathebHealerFrame"..i, LVBMLoathebFrameDrag, "LVBMLoathebHealerTemplate");
					if i == 1 then
						newFrame:SetPoint("TOP", "LVBMLoathebFrameDrag", "BOTTOM", 0, 0);
					else
						newFrame:SetPoint("TOP", "LVBMLoathebHealerFrame"..(i - 1), "BOTTOM", 0, 3);
					end
					newFrame:Show();
				end
			end
			for i = frameCount, (table.getn(LVBM.AddOns.Loatheb.Healers) + 1), - 1 do
				if i > 0 then
					getglobal("LVBMLoathebHealerFrame"..i):Hide();
				end
			end
		elseif event == "SendHealList" then
			local message = "";
			if not LVBM.AddOns.Loatheb.HealersSorted then
				return;
			end
			for index, value in pairs(LVBM.AddOns.Loatheb.Healers) do
				message = message..value.Sort..value.Name.." ";
			end			
			while string.len(message) > 240 do
				SendAddonMessage("LVBMLOALISTL", string.sub(message, 1, 240), "RAID");
				message = string.sub(message, 241);
			end
			SendAddonMessage("LVBMLOALISTS", message, "RAID");
		elseif event == "DetectHeal" and arg1 and LVBM.AddOns.Loatheb.InCombat then
			for index, value in pairs(LVBM.AddOns.Loatheb.Healers) do
				if value.Name == arg1 then
					if not value.Cooldown then
						LVBM.AddOns.Loatheb.Healers[index].Cooldown = 60;
						if LVBM.AddOns.Loatheb.HealersSorted then
							local nextHealer, nextHealerID, soonHealer, soonHealerID;
							nextHealerID, nextHealer = LVBM.AddOns.Loatheb.OnEvent("GetNextHealer", index);
							soonHealerID, soonHealer = LVBM.AddOns.Loatheb.OnEvent("GetNextHealer", (LVBM.AddOns.Loatheb.OnEvent("GetNextHealer", (LVBM.AddOns.Loatheb.OnEvent("GetNextHealer", index)))));
							if nextHealerID and nextHealer then
								if nextHealer == UnitName("player") then
									LVBM.AddSpecialWarning(LVBM_LOATHEB_YOU_ARE_NEXT, true, true)
								end
								if LVBM.AddOns.Loatheb.Options.Announce and LVBM.Rank >= 1 then
									if LVBM.AddOns.Loatheb.Options.AnnounceHealRaid then
										SendChatMessage(string.format(LVBM_LOATHEB_HEAL_WARNING, index, nextHealer), "RAID")
									end
									if LVBM.AddOns.Loatheb.Options.AnnounceHealRaidWarning then
										SendChatMessage(string.format(LVBM_LOATHEB_HEAL_WARNING, index, nextHealer), "RAID_WARNING")
									end							
									if LVBM.AddOns.Loatheb.Options.AnnounceHealWhisper and soonHealer then
										LVBM.SendHiddenWhisper(LVBM_LOATHEB_YOU_ARE_SOON, soonHealer);
										LVBM.SendHiddenWhisper(LVBM_LOATHEB_YOU_ARE_NEXT, nextHealer);
									end
								end
								
								if not LVBMLoathebArrowRight then
									local arrowRight, arrowRightTexture;
									arrowRight = CreateFrame("Frame", "LVBMLoathebArrowRight", LVBMLoathebFrameDrag);
									arrowRight:SetWidth(32);
									arrowRight:SetHeight(32);
									arrowRightTexture = arrowRight:CreateTexture("LVBMLoathebArrowRightTexture", "BACKGROUND");
									arrowRightTexture:SetTexture("Interface\\AddOns\\LVBM_API\\Textures\\Arrow-Right.tga");
									arrowRightTexture:SetBlendMode("ALPHAKEY");
									arrowRightTexture:SetAllPoints(arrowRight);
								elseif not LVBMLoathebArrowRight:IsShown() then
									LVBMLoathebArrowRight:Show();
								end							
								
								LVBMLoathebArrowRight:ClearAllPoints();
								if getglobal("LVBMLoathebHealerFrame"..nextHealerID) then
									LVBMLoathebArrowRight:SetPoint("RIGHT", "LVBMLoathebHealerFrame"..nextHealerID, "LEFT", 0, 0);
									local i = 1;
									while getglobal("LVBMLoathebHealerFrame"..i.."BarBorder") do
										getglobal("LVBMLoathebHealerFrame"..i.."BarBorder"):SetNormalTexture("Interface\\PaperDollInfoFrame\\UI-Character-Skills-BarBorder");
										i = i + 1;
									end
									getglobal("LVBMLoathebHealerFrame"..nextHealerID.."BarBorder"):SetNormalTexture("Interface\\PaperDollInfoFrame\\UI-Character-Skills-BarBorderHighlight");
									LVBMLoathebFrameDrag.ArrowPosition = nextHealerID;
									LVBM.Schedule(35, "LVBM.AddOns.Loatheb.OnEvent", "HideArrow", nextHealerID);
								end
							end
						end
					end
					break;
				end
			end
		elseif event == "HideArrow" and LVBMLoathebFrameDrag.ArrowPosition then
			getglobal("LVBMLoathebHealerFrame"..arg1.."BarBorder"):SetNormalTexture("Interface\\PaperDollInfoFrame\\UI-Character-Skills-BarBorder");
			if LVBMLoathebArrowRight and LVBMLoathebFrameDrag.ArrowPosition == arg1 then
				LVBMLoathebArrowRight:Hide();
			end
		elseif event == "UpdateHealerFrame" and arg1 then
			for index, value in pairs(LVBM.AddOns.Loatheb.Healers) do
				if type(LVBM.AddOns.Loatheb.Healers[index].Cooldown) == "number" then
					LVBM.AddOns.Loatheb.Healers[index].Cooldown = LVBM.AddOns.Loatheb.Healers[index].Cooldown - arg1;
					if LVBM.AddOns.Loatheb.Healers[index].Cooldown <= 0 then
						LVBM.AddOns.Loatheb.Healers[index].Cooldown = false;
					end
				end
			end
			for index, value in pairs(LVBM.AddOns.Loatheb.SpamProt) do
				if type(LVBM.AddOns.Loatheb.SpamProt[index]) == "number" then
					LVBM.AddOns.Loatheb.SpamProt[index] = LVBM.AddOns.Loatheb.SpamProt[index] - arg1;
					if LVBM.AddOns.Loatheb.SpamProt[index] <= 0 then
						LVBM.AddOns.Loatheb.SpamProt[index] = false;
					end
				end
			end
			if LVBMLoathebFrameDrag:IsShown() then
				local unitIDs = {};
				local i = arg1 + 1;
				for i = 1, GetNumRaidMembers() do
					if UnitClass("raid"..i) == LVBM_PRIEST or UnitClass("raid"..i) == LVBM_PALADIN or UnitClass("raid"..i) == LVBM_DRUID or UnitClass("raid"..i) == LVBM_SHAMAN then
						unitIDs[UnitName("raid"..i)] = "raid"..i;
					end
				end
				if table.getn(LVBM.AddOns.Loatheb.Healers) == 0 then
					LVBM.AddOns.Loatheb.OnEvent("RAID_ROSTER_UPDATE");
				end
				local frameID = 0;
				for index, value in pairs(LVBM.AddOns.Loatheb.Healers) do
					frameID = frameID + 1;
					local frame = getglobal("LVBMLoathebHealerFrame"..frameID);
					local frameName = getglobal("LVBMLoathebHealerFrame"..frameID.."BarName");
					local frameCooldown = getglobal("LVBMLoathebHealerFrame"..frameID.."BarCooldown");
					local frameSpark = getglobal("LVBMLoathebHealerFrame"..frameID.."BarSpark");
					local frameBar = getglobal("LVBMLoathebHealerFrame"..frameID.."Bar");					
					if frame then
						frameName:SetText(value.Name.." ("..value.Class..")");
						if value.Name == UnitName("player") then
							frameName:SetTextColor(0, 0.82, 1);
							frameCooldown:SetTextColor(0, 0.82, 1);
						else
							frameName:SetTextColor(1, 0.82, 0);
							frameCooldown:SetTextColor(1, 0.82, 0);
						end
						if UnitIsDeadOrGhost(unitIDs[value.Name]) or not UnitIsConnected(unitIDs[value.Name]) then
							if UnitIsDeadOrGhost(unitIDs[value.Name]) then
								frameCooldown:SetText(LVBM_DEAD);
							elseif not UnitIsConnected(unitIDs[value.Name]) then
								frameCooldown:SetText(LVBM_OFFLINE);
							end
							frameBar:SetValue(0);
							frameSpark:Hide();							
							frame:SetAlpha(0.5);
						else
							frame:SetAlpha(1);
							if type(value.Cooldown) == "number" and value.Cooldown > 0 then
								frameCooldown:SetText(LVBM.SecondsToTime(value.Cooldown));
								frameBar:SetValue(value.Cooldown);						
								frameSpark:ClearAllPoints();
								frameSpark:SetPoint("CENTER", frameBar, "LEFT", ((frameBar:GetValue() / 60) * frameBar:GetWidth()), 0);
								frameSpark:Show();
							else
								frameCooldown:SetText(LVBM_LOATHEB_NO_CD);
								frameBar:SetValue(0);
								frameSpark:Hide();
							end
						end
					end
					if LVBMLoathebFrameDrag.ConfigMode then
						local editBox;
						if not getglobal("LVBMLoathebHealerFrame"..frameID.."EditBox") then
							CreateFrame("Frame", "LVBMLoathebHealerFrame"..frameID.."EditBox", LVBMLoathebFrameDrag, "LVBMLoathebEditBoxTemplate")
						end
						editBox = getglobal("LVBMLoathebHealerFrame"..frameID.."EditBox");
						editBox:SetID(frameID);
						editBox:SetPoint("LEFT", "LVBMLoathebHealerFrame"..frameID, "RIGHT", -4, 0);
						editBox:Show();
						if not LVBMLoathebButton:IsShown() then
							local i = 1;
							while getglobal("LVBMLoathebHealerFrame"..i) do
								i = i + 1;
							end
							i = i - 1;
							LVBMLoathebButton:ClearAllPoints()
							LVBMLoathebButton:SetPoint("TOP", "LVBMLoathebHealerFrame"..i, "BOTTOM", 0, 0);
							LVBMLoathebButton:Show();
						end
					end
				end
			end
		end
	end,
	["OnCombatEnd"] = function()
		LVBM.AddOns.Loatheb.InCombat = false;
		LVBM.AddOns.Loatheb.CountSpore = 0;
		LVBM.AddOns.Loatheb.DoomCounter = 0;
		LVBM.AddOns.Loatheb.CastingDoom = false;				
		if LVBM.AddOns.Loatheb.AutoShown then
			LVBMLoathebFrameDrag:Hide();
		end
		LVBM.AddOns.Loatheb.AutoShown = false;
		for index, value in pairs(LVBM.AddOns.Loatheb.Healers) do
			if getglobal("LVBMLoathebHealerFrame"..index.."BarBorder") then
				getglobal("LVBMLoathebHealerFrame"..index.."BarBorder"):SetNormalTexture("Interface\\PaperDollInfoFrame\\UI-Character-Skills-BarBorder");
			end
		end	
		if LVBMLoathebArrowRight then
			LVBMLoathebArrowRight:Hide();
		end
	end,
	["InitializeMenu"] = function()
		local info = {};
		info.text = "Loatheb";
		info.notClickable = 1;
		info.isTitle = 1;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info, 1);
		
		local info = {};
		info.text = "Lock window";
		info.value = LVBM.AddOns.Loatheb.Options.FrameLocked;
		info.func = function() LVBM.AddOns.Loatheb.Options.FrameLocked = not LVBM.AddOns.Loatheb.Options.FrameLocked; end;
		info.checked = LVBM.AddOns.Loatheb.Options.FrameLocked;
		info.keepShownOnClick = 1;
		UIDropDownMenu_AddButton(info, 1);
		local info = {};
		info.text = "Close";
		info.func = function() LVBMLoathebFrameDrag.ConfigMode = false; LVBMLoathebFrameDrag:Hide() end;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info, 1);
	end,
};
