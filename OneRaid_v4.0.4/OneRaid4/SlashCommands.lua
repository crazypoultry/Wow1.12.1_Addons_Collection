SlashCmdList["OneRaidHelp"] = function (msg)
	getglobal("OneRaid_HelpFile_" .. GetLocale()):Show();
end
SLASH_OneRaidHelp1 = "/orhelp"
SLASH_OneRaidHelp2 = "/or"

SlashCmdList["OneRaidNotes"] = function (msg)
	OneRaid_VersionNotes:Show();
end
SLASH_OneRaidNotes1 = "/ornotes";

SlashCmdList["OneRaidSave"] = function (msg)
	if (IsRaidLeader()) then
		OneRaid.savedRaid = {};
		for i = 1, GetNumRaidMembers() do
			local name, rank, subgroup = GetRaidRosterInfo(i);
			OneRaid.savedRaid[name] = subgroup;
		end
		OneRaid:Print(ONERAID_MEMBER_LAYOUT_SAVED);
	else
		OneRaid:Print(ONERAID_LEADERSHIP_REQUIRED);
	end
end
SLASH_OneRaidSave1 = "/orsave";

SlashCmdList["OneRaidLoad"] = function (msg)
	if (IsRaidLeader()) then
		OneRaid:ResetRaidPositions(1);
		OneRaid:Print(ONERAID_MEMBER_LAYOUT_LOADED);
	else
		OneRaid:Print(ONERAID_LEADERSHIP_REQUIRED);
	end
end
SLASH_OneRaidLoad1 = "/orload";

SlashCmdList["OneRaidPassword"] = function (msg)
	if (msg ~= "") then
		local found, found, pass = string.find(msg, "^(%S+)$");
		if (found) then
			OneRaid_Options.password = pass;
			OneRaid:Print(string.format(ONERAID_PASSWORD_SET, pass));
		else
			OneRaid:Print(string.format(ONERAID_PASSWORD_SET, msg));
		end
	else
		OneRaid_Options.password = nil;
		OneRaid:Print(ONERAID_PASSWORD_CLEARED, pass);
	end
end
SLASH_OneRaidPassword1 = "/orpassword";

SlashCmdList["OneRaidTalent"] = function (msg)
	if (IsRaidLeader() or IsRaidOfficer()) then
		if (msg ~= "") then
			OneRaid:AddonMessage("GET_TALENTS", msg);
		end
	else
    	--OneRaid:Print(ONERAID_PROMOTION_REQUIRED);
	end
end
SLASH_OneRaidTalent1 = "/ortalent";

SlashCmdList["OneRaidAssist"] = function (msg)
	if (OneRaid.mainAssist) then
		unit = OneRaid:GetUnit(OneRaid.mainAssist);
		if (unit) then
			AssistUnit(unit);
		end
	end
end
SLASH_OneRaidAssist1 = "/orassist";

SlashCmdList["OneRaidReady"] = function (msg)
	if (IsRaidLeader() or IsRaidOfficer()) then
		OneRaid:AddonMessage("READY_REQUEST");
	else
		OneRaid:Print(ONERAID_PROMOTION_REQUIRED);
	end
end
SLASH_OneRaidReady1 = "/orready";

SlashCmdList["OneRaidCure"] = function (msg)
    OneRaid:CureDebuffs();
end;
SLASH_OneRaidCure1 = "/orcure";

SlashCmdList["OneRaidSay"] = function (msg)
    if (IsRaidLeader() or IsRaidOfficer()) then
		if (msg ~= "") then
			OneRaid:AddonMessage("SAY", msg);
			SendChatMessage(msg, "RAID");
		end
	else
    	OneRaid:Print(ONERAID_PROMOTION_REQUIRED);
	end
end;
SLASH_OneRaidSay1 = "/ors";

SlashCmdList["OneRaidSound"] = function (msg)
	if (IsRaidLeader() or IsRaidOfficer()) then
		if (msg ~= "") then
	        OneRaid:AddonMessage("SOUND", msg);
		end
	else
    	OneRaid:Print(ONERAID_PROMOTION_REQUIRED);
	end
end;
SLASH_OneRaidSound1 = "/orsound";

SlashCmdList["OneRaidDing"] = function (msg)
    if (IsRaidLeader() or IsRaidOfficer()) then
		OneRaid:AddonMessage("SOUND", "Sound\\Doodad\\BoatDockedWarning.wav");
		if (msg ~= "") then
		    OneRaid:AddonMessage("SAY", msg);
		    SendChatMessage(msg, "RAID");
		end
    else
    	OneRaid:Print(ONERAID_PROMOTION_REQUIRED);
	end
end;
SLASH_OneRaidDing1 = "/ording";
SLASH_OneRaidDing2 = "/ord";

SlashCmdList["OneRaidDurability"] = function (msg)
	if (IsRaidLeader() or IsRaidOfficer()) then
		OneRaid:AddonMessage("DURABILITY_REQUEST");
	else
		OneRaid:Print(ONERAID_PROMOTION_REQUIRED);
	end
end;
SLASH_OneRaidDurability1 = "/ordur";

SlashCmdList["OneRaidResists"] = function (msg)
	if (IsRaidLeader() or IsRaidOfficer()) then
		OneRaid:AddonMessage("RESISTS_REQUEST");
	else
		OneRaid:Print(ONERAID_PROMOTION_REQUIRED);
	end
end;
SLASH_OneRaidResists1 = "/orres";

SlashCmdList["OneRaidItem"] = function (msg)
	if (msg) then
		OneRaid:AddonMessage("ITEM_REQUEST", msg);
	end
end;
SLASH_OneRaidItem1 = "/oritem";


SlashCmdList["OneRaidMurloc"] = function (msg)
    OneRaid:AddonMessage("SOUND", "Sound\\Creature\\BabyMurloc\\BabyMurlocDance.wav");
end;
SLASH_OneRaidMurloc1 = "/ormurloc";

--/orinvite
SlashCmdList["OneRaidInvite"] = function (msg)

	if (IsRaidLeader() or IsRaidOfficer()) then

		local found = nil;
		local minLevel = nil;
		local maxLevel = nil;
		local zone = nil;

		if (msg ~= "") then

			local pattern = "%-\"(.-)\"";

			--Get Zone
			found, found, zone = string.find(msg, "^.*z" .. pattern .. ".*$");
			if (zone) then
				msg = string.gsub(msg, "z%-\"" .. zone .. "\"", "");
				if (zone == "") then
					zone = GetRealZoneText();
				end
			end
			--Get Rank
			found, found, rank = string.find(msg, "^.*r" .. pattern .. ".*$");
			if (rank) then
				msg = string.gsub(msg, "r%-\"" .. rank .. "\"", "");
				if (rank == "") then
					rank = nil;
				end
			end
			msg = string.gsub(msg, " ", "");
			--Get Level
			found, found, minLevel, maxLevel = string.find(msg, "^(%d+)-(%d+)$");
			if (not minLevel or not maxLevel) then
				found, found, maxLevel = string.find(msg, "^(%d+)$");
				if (not maxLevel) then
					minLevel = 1;
					maxLevel = 60;
				else
					minLevel = maxLevel;
				end
			end
			
			if (minLevel > maxLevel) then
				OneRaid:Print(ONERAID_INVALID_LEVEL);
				return;
			end
			
			if (tonumber(minLevel) < 1) then minLevel = 1; end
			if (tonumber(maxLevel) > 60) then maxLevel = 60; end
			
			local inviteStr = "";
			local levelStr = "";
			
			if (minLevel ~= maxLevel) then
				levelStr = minLevel .. " - " .. maxLevel;
			else
				levelStr = maxLevel;
			end
			
			if (rank and zone) then
				inviteStr = string.format(ONERAID_INVITE_ZONE_RANK, levelStr, zone, rank);
			elseif (not rank and zone) then
				inviteStr = string.format(ONERAID_INVITE_ZONE, levelStr, zone);
			elseif (not zone and rank) then
				inviteStr = string.format(ONERAID_INVITE_RANK, levelStr, rank);
			else
				inviteStr = string.format(ONERAID_INVITE, levelStr);
			end
			
			if (zone) then
				zone = string.lower(zone);
			end
			if (rank) then
				rank = string.lower(rank);
			end

			SendChatMessage(inviteStr, "GUILD");
			
			GuildRoster();

			OneRaid.inviteMin = tonumber(minLevel);
			OneRaid.inviteMax = tonumber(maxLevel);
			OneRaid.inviteRank = rank;
			OneRaid.inviteZone = zone;
			OneRaid.invited = {};

			local inRaid = nil;
			if (GetNumPartyMembers() > 0) then
				ConvertToRaid();
				inRaid = 1;
			end

			OneRaid:Timer(10, OneRaid, "InviteGuild", inRaid);

		end
	else
		OneRaid:Print(ONERAID_PROMOTION_REQUIRED);
	end

end
SLASH_OneRaidInvite1 = "/orinvite";


SlashCmdList["OneRaidReform"] = function (msg)
	if (IsRaidLeader() or IsRaidOfficer()) then
		OneRaid.currentRaid = {};
		OneRaid.invited = {};
		for i = 1, GetNumRaidMembers() do
			table.insert(OneRaid.currentRaid, UnitName("raid" .. i));
		end			
		OneRaid:Timer(10, OneRaid, "ReformRaid");
		OneRaid:AddonMessage("REFORM");
		LeaveParty();
	else
		OneRaid:Print(ONERAID_PROMOTION_REQUIRED);
	end
end
SLASH_OneRaidReform1 = "/orreform";

SlashCmdList["OneRaidDisband"] = function (msg)
	if (IsRaidLeader() or IsRaidOfficer()) then
		OneRaid:AddonMessage("DISBAND");
		LeaveParty();
	else
		OneRaid:Print(ONERAID_PROMOTION_REQUIRED);
	end
end
SLASH_OneRaidDisband1 = "/ordisband";

SlashCmdList["OneRaidSwitch"] = function (msg)

	local player1 = UnitName("player");
	local player2 = UnitName("target");
	local group = nil;
	local isGroupSwitch = nil;
	local groups = {};
	
	if (GetNumRaidMembers() == 0) then return; end
	
	for i = 1, GetNumRaidMembers() do
		local name, rank, subgroup, level, class, fileName, zone, online = GetRaidRosterInfo(i);
		if (not groups[subgroup]) then
			groups[subgroup] = { size = 0, units = {}, priests = {} };
		end
		groups[subgroup].size = groups[subgroup].size + 1;
		table.insert(groups[subgroup].units, "raid" .. i);
		if (class == ONERAID_PRIEST) then
			table.insert(groups[subgroup].priests, "raid" .. i);
		end
	end

	if (msg == "") then
		if (UnitName("target")) then
			if (not OneRaid:GetUnit(UnitName("target"))) then
				OneRaid:Print(string.format(ONERAID_NOT_RAID_MEMBER, UnitName("target")));
				return;
			end
		else
			OneRaid:Print(ONERAID_NO_SWITCH_TARGET);
			return;
		end
	end
	
	--/orsw Group
	local found, found, g = string.find(msg, "^(%d+)$");
	if (found) then
		group = g;
		isGroupSwitch = 1;
	else
		--/orsw Player1
		local found, found, p2 = string.find(msg, "^(%S+)$");
		if (found) then
			if (p2 == "target" or p2 == "player") then
				p2 = UnitName(p2);
			end
			player2 = p2
		end		
	end		
	
	--/orsw Player1 Group
	local found, found, p1, g = string.find(msg, "^(%S+) (%d+)$");
	if (found) then
		if (p1 == "target" or p1 == "player") then
			p1 = UnitName(p1);
		end
		if (not p1) then
			OneRaid:Print(ONERAID_NO_SWITCH_TARGET);
			return;
		end
		if (OneRaid:GetUnit(p1)) then
			player1 = p1;
		else
			OneRaid:Print(string.format(ONERAID_NOT_RAID_MEMBER, p1));
			return;
		end
		group = g;
		isGroupSwitch = 1;
	else		
		--/orsw Player1 Player2
		local found, found, p1, p2 = string.find(msg, "^(%S+) (%S+)$");
		if (found) then
			if (p1 == "target" or p1 == "player") then
				p1 = UnitName(p1);
			end
			if (p2 == "target" or p2 == "player") then
				p2 = UnitName(p2);
			end
			if (OneRaid:GetUnit(p1)) then
				player1 = p1;
			else
				OneRaid:Print(string.format(ONERAID_NOT_RAID_MEMBER, p1));
				return;
			end
			if (OneRaid:GetUnit(p2)) then
				player2 = p2;
			else
				OneRaid:Print(string.format(ONERAID_NOT_RAID_MEMBER, p2));
				return;
			end
		end
	end
	
	if (isGroupSwitch or msg == "vael") then
			
		if (msg == "vael") then
			local classes = {
				[ONERAID_WARRIOR] 	= 1,
				[ONERAID_ROGUE] 	= 2,
				[ONERAID_HUNTER] 	= 3,
				[ONERAID_WARLOCK] 	= 4,
				[ONERAID_MAGE] 		= 4,
				[ONERAID_DRUID] 	= 5,
				[ONERAID_SHAMAN] 	= 6,
				[ONERAID_PALADIN]	= 6,
			};
			
			local priest, withRoom, needsPriest, priestFound;
			
			for k, v in groups do					
				if (table.getn(v.priests) > 0) then
					for k1, v1 in v.priests do
						if (not UnitIsDead(v1) and not UnitIsGhost(v1) and UnitIsConnected(v1)) then
							priest = v1;
							break;
						end
					end
					if (priest) then
						if (v.size == 5) then
							for k1, v1 in v.units do
								if (UnitIsDead(v1) or UnitIsGhost(v1) or not UnitIsConnected(v1)) then
									withRoom = v1;
									break;
								end
							end
							if (withRoom) then
								break;
							end
						else
							group = k;
							isGroupSwitch = 1;
							withRoom = 0;
							break;
						end
					end
				end
			end
			
			local priority = { current = 10, id = nil };
			if (withRoom) then
				for k, v in groups do
					priestFound = nil;
					if (table.getn(v.priests) > 0) then
						for k1, v1 in v.priests do
							if (not UnitIsDead(v1) and not UnitIsGhost(v1) and UnitIsConnected(v1)) then
								priestFound = v1;
								break;
							end
						end
					end
					if (not priestFound) then
						for k1, v1 in v.units do
							if (not UnitIsDead(v1) and not UnitIsGhost(v1) and UnitIsConnected(v1)) then
								if (classes[UnitClass(v1)] < priority.Current) then
									priority.id = v1;
									priority.current = classes[UnitClass(v1)];
								end
							end
						end
					end
				end
			end
			
			if (withRoom and priority.id) then
				if (withRoom == 0) then
					isGroupSwitch = 1;
					player1 = UnitName(priority.id);
				else
					isGroupSwitch = nil;
					group = nil;
					player1 = UnitName(withRoom);
					player2 = UnitName(priority.id);
				end
			else
				return;
			end
		
		else
			
			if (groups[tonumber(group)] and groups[tonumber(group)].size == 5) then
				--switch to smart mode
				for k, v in groups[tonumber(group)].units do
					--Switch player1 not with group, but with someone that is dead/ghost/offline
					if (UnitIsDead(v) or UnitIsGhost(v) or not UnitIsConnected(v)) then
						player2 = UnitName(v);
						isGroupSwitch = nil;
						group = nil;
					end
				end
				if (isGroupSwitch) then
					return;
				end				
			end
			
		end
		
	end
	
	if (isGroupSwitch) then
		if (player1) then
			if (not OneRaid:GetUnit(player1)) then
				OneRaid:Print(string.format(ONERAID_NOT_RAID_MEMBER, player1));
				return;
			end
		else
			OneRaid:Print(ONERAID_NO_PLAYER1);
			return;
		end
		if (not group or tonumber(group) < 1 or tonumber(group) > 8) then
			OneRaid:Print(ONERAID_INVALID_GROUP);
			return;
		end
		OneRaid:AddonMessage("MOVE", player1, group);
	else
		if (player1) then
			if (not OneRaid:GetUnit(player1)) then
				OneRaid:Print(string.format(ONERAID_NOT_RAID_MEMBER, player1));
				return;
			end
		else
			OneRaid:Print(ONERAID_NO_PLAYER1);
			return;
		end
		if (player2) then
			if (not OneRaid:GetUnit(player2)) then
				OneRaid:Print(string.format(ONERAID_NOT_RAID_MEMBER, player2));
				return;
			end
		else
			OneRaid:Print(ONERAID_NO_PLAYER2);
			return;
		end
		OneRaid:AddonMessage("SWAP", player1, player2);
	end

end
SLASH_OneRaidSwitch1 = "/orswitch";
SLASH_OneRaidSwitch2 = "/orsw";