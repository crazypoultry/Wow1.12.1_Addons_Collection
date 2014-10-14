function RaidHealer_AnnounceAssignment(channel, aType, filter)
	local whisperStack = { };
	local announceStack = { };
	local addonMsgStack = { };
	
	-- purge leved users
	RaidHealer_PurgeAssignments();
	
	if (aType == "HEAL") then
		
		local alternate = {};
		
		-- send message to clear all assigned targets
		table.insert(addonMsgStack, "RESETHEAL");
		for healer, targets in RaidHealer_pairsByKeys(RaidHealer_Assignments[aType]) do

			if (RaidHealer_PlayerInRaid(healer) and targets ~= nil) then
				-- filter names by class if class is set
				if (filter ~= nil) then
					targets = RaidHealer_FilterNamesByClass(targets, filter);
				end
				-- announce only when at least one target exists
				if (table.getn(targets) > 0) then
					-- sort targets by Name
					table.sort(targets);
					-- insert msg's into stack
					if ( RaidHealer_GlobalConfig["ANNOUNCE_ALTERNATE"] ) then
						for i=1, table.getn(targets), 1 do
							if ( alternate[targets[i]] and type(alternate[targets[i]]) == "table" ) then
								table.insert(alternate[targets[i]], healer);
							else
								alternate[targets[i]] = { healer };
							end
						end
					else
						table.insert(announceStack, healer.." >>> "..table.concat(targets, ", "));
					end
					
					table.insert(addonMsgStack, "HEAL "..healer.." "..table.concat(targets, ","));
					table.insert(whisperStack, {["MSG"] = getglobal("RAIDHEALER_YOU_"..aType)..table.concat(targets, ", "), ["PLAYER"] = healer});
				end
			end
		end
		
		-- create output for alternate announcement
		if ( RaidHealer_GlobalConfig["ANNOUNCE_ALTERNATE"] and type(alternate) == "table" ) then
			for tank, healers in RaidHealer_pairsByKeys(alternate) do
				if ( table.getn(healers) > 0 ) then
					table.sort(healers);
					table.insert(announceStack, tank.." <<< "..table.concat(healers, ", "));
				end
			end
		end
		
	elseif (aType == "BUFF") then
		-- buff announce
		-- send message to clear all assigned targets
		table.insert(addonMsgStack, "RESETBUFF");
		for buff, ass in pairs(RaidHealer_Assignments[aType]) do
			if (filter == nil or buff == RAIDHEALER_BUFFS[filter]["BUFF"]) then
				for buffer, groups in RaidHealer_pairsByKeys(ass) do
					if ( type(groups) == "table" and table.getn(groups) > 0 ) then
						table.sort(groups);
						-- insert msg's into stack
						table.insert(announceStack, buff..": "..buffer.." >>> "..RAIDHEALER_GROUP..table.concat(groups, "+"));
						table.insert(addonMsgStack, "BUFF "..buff.." "..buffer.." "..table.concat(groups, ","));
						table.insert(whisperStack, {["MSG"] = getglobal("RAIDHEALER_YOU_"..aType)..buff.." "..RAIDHEALER_GROUP..table.concat(groups, "+"), ["PLAYER"] = buffer});
					end
				end
			end
		end
	end
	
	-- announce messages if not disabled
	if ( not RaidHealer_GetGC("HIDE_ANNOUNCE_"..aType) ) then
		RaidHealer_AnnounceAssignments(channel, aType, announceStack);
	end
	
	RaidHealer_SendAddonMessages(addonMsgStack);
	
	if (RaidHealer_GlobalConfig["WHISPER_ASSIGNMENT"] == true and table.getn(whisperStack) > 0 ) then
		RaidHealer_WhisperAssignment(whisperStack);
	end
	
end	

function RaidHealer_AnnounceAssignments(channel, aType, msgStack)
	if ( type(msgStack) == "table" and table.getn(msgStack) > 0 ) then
		RaidHealer_SendToChannel(channel, getglobal("RAIDHEALER_"..aType.."_ASSIGNMENT_SEP"));
		RaidHealer_SendToChannel(channel, getglobal("RAIDHEALER_"..aType.."_ASSIGNMENT"));
		RaidHealer_SendToChannel(channel, getglobal("RAIDHEALER_"..aType.."_ASSIGNMENT_SEP"));
		
		for i=1, table.getn(msgStack), 1 do
			RaidHealer_SendToChannel(channel, msgStack[i]);
		end
		
		RaidHealer_SendToChannel(channel, getglobal("RAIDHEALER_"..aType.."_ASSIGNMENT_SEP"));
	end
end

function RaidHealer_WhisperAssignment(whisperStack)
	for i=1, table.getn(whisperStack), 1 do
		RaidHealer_SendToChannel("WHISPER", whisperStack[i]["MSG"], whisperStack[i]["PLAYER"]);		
	end
end

function RaidHealer_WhisperAssignmentToPlayer(aType, playerName)
	-- purge user have left
	RaidHealer_PurgeAssignments();
	-- check if player in raid
	if (RaidHealer_PlayerInRaid(playerName) == false) then
		RaidHealer_SendToChannel("WHISPER", RAIDHEALER_NOT_IN_GROUP, playerName);
		return;
	end
	-- check healer
	local _, playerClass = UnitClass(RaidHealer_GetUnitIDByName(playerName));
	if (aType=="HEAL" and RaidHealer_IsHealClass(playerClass) == false) then
		-- not a healer
		RaidHealer_SendToChannel("WHISPER", RAIDHEALER_NOT_A_HEALER, playerName);
		return;
	end
	-- check buffer
	if (aType=="BUFF" and RaidHealer_IsBuffClass(playerClass) == false) then
		-- not a buffer
		RaidHealer_SendToChannel("WHISPER", RAIDHEALER_NOT_A_BUFFER, playerName);
		return;
	end
	-- whisper assignment
	if (aType == "HEAL") then
		if (RaidHealer_Assignments[aType][playerName] ~= nil and table.getn(RaidHealer_Assignments[aType][playerName])>0 ) then
			table.sort(RaidHealer_Assignments[aType][playerName]);
			RaidHealer_SendToChannel("WHISPER", getglobal("RAIDHEALER_YOU_"..aType)..table.concat(RaidHealer_Assignments[aType][playerName], ", "), playerName);
		else
			RaidHealer_SendToChannel("WHISPER", getglobal("RAIDHEALER_YOU_"..aType.."_NOTHING"), playerName);
		end
	elseif (aType == "BUFF") then
		local whispers = 0;
		for buff, ass in pairs(RaidHealer_Assignments[aType]) do
			for buffer, groups in RaidHealer_pairsByKeys(ass) do
				if (buffer == playerName) then
					if ( type(groups) == "table" and table.getn(groups) > 0 ) then
						RaidHealer_SendToChannel("WHISPER", getglobal("RAIDHEALER_YOU_"..aType)..buff.." "..RAIDHEALER_GROUP.." "..table.concat(groups, "+"), playerName);
						whispers = whispers+1
					end
				end
			end
		end
		-- nothing to buff
		if (whispers == 0) then
			RaidHealer_SendToChannel("WHISPER", getglobal("RAIDHEALER_YOU_"..aType.."_NOTHING"), playerName);
		end
	end
end

function RaidHealer_SendToChannel(channel, msg, recipient)
	if (channel == "PARTY" or channel == "GUILD" or channel == "RAID" or channel == "SAY") then
		-- sends to party, raid or guild
		SendChatMessage(msg, channel, this.language);
	elseif (channel == "WHISPER" and recipient ~= nil) then
		if (RAIDHEALER_DEBUG) then
			recipient = UnitName("player");
		end
		-- chatches userName as channel and sends a whisper
		SendChatMessage("<"..RAIDHEALER_NAME..">: "..msg, channel, this.language, recipient);
	else
		-- sends to specific channel
		SendChatMessage(msg, "CHANNEL", this.language, GetChannelName(channel));
	end
end

function RaidHealer_SendAddonMessage(msg)
	if ( UnitInRaid("player") ) then
		SendAddonMessage("RAIDHEALER", msg, "RAID");
	end
end

function RaidHealer_SendAddonMessages(msgStack)
	if ( type(msgStack) == "table" and table.getn(msgStack) > 0 ) then
		for i=1, table.getn(msgStack), 1 do
			RaidHealer_SendAddonMessage(msgStack[i]);
		end
	end
end

function RaidHealer_GetCommChannels()
	local chans = {"RAID"};
	-- get channels from default chat frame
	local cfc = { GetChatWindowChannels(DEFAULT_CHAT_FRAME:GetID()) };
	for i=1, table.getn(cfc), 2 do
		-- only add none-zone channels
		if (cfc[i+1] == 0 and RaidHealer_IsSpecialGlobalChannel(cfc[i]) == false) then
			table.insert(chans, cfc[i]);
		end
	end

	return chans;
end

function RaidHealer_IsSpecialGlobalChannel(channelName)
	for i=1, table.getn(RAIDHEALER_SPECIALGLOBALCHANNELS), 1 do
		if (RAIDHEALER_SPECIALGLOBALCHANNELS[i] == channelName) then
			return true;
		end
	end
	return false;
end