--ChatLog: A chat logger
--Author: pb_ee1

StaticPopupDialogs["CHATLOG_CLEARALL"] = {
	text = CHAT_LOG_DIALOG_CLEARALL_TEXT,
	button1 = CHAT_LOG_DIALOG_CLEARALL_BUTTON1,
	button2 = CHAT_LOG_DIALOG_CLEARALL_BUTTON2,
	OnAccept = function ()
		ChatLog_Clear();
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1,
	showAlert = 1,
};

function ChatLog_OnLoad()
	SlashCmdList["CHATLOG"] = function(args)
		ChatLog_SlashCommand(args);
	end
	
	SlashCmdList["COMBATLOG"] = function(args)
	end
	
	ChatLogMaxLogInfoText:SetTextColor(CHAT_LOG_COLORS["MAXLOG_INFO_TEXT"]["r"], CHAT_LOG_COLORS["MAXLOG_INFO_TEXT"]["g"], CHAT_LOG_COLORS["MAXLOG_INFO_TEXT"]["b"]);
	
	ChatLog:RegisterEvent("ADDON_LOADED");
	ChatLog:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE");
	ChatLog:RegisterEvent("CHAT_MSG_WHISPER");
	ChatLog:RegisterEvent("CHAT_MSG_WHISPER_INFORM");
	ChatLog:RegisterEvent("CHAT_MSG_RAID");
	ChatLog:RegisterEvent("CHAT_MSG_RAID_LEADER");
	ChatLog:RegisterEvent("CHAT_MSG_RAID_WARNING");
	ChatLog:RegisterEvent("CHAT_MSG_PARTY");
	ChatLog:RegisterEvent("CHAT_MSG_SAY");
	ChatLog:RegisterEvent("CHAT_MSG_YELL");
	ChatLog:RegisterEvent("CHAT_MSG_OFFICER");
	ChatLog:RegisterEvent("CHAT_MSG_GUILD");
	ChatLog:RegisterEvent("CHAT_MSG_CHANNEL");
	
	ChatLog:RegisterEvent("PARTY_MEMBERS_CHANGED");
	ChatLog:RegisterEvent("RAID_ROSTER_UPDATE");
	ChatLog:RegisterEvent("UPDATE_CHAT_COLOR");
end

function ChatLog_OnEvent(event)
	local msg, tindex;
	
	--ADDON LOADED EVENT
	if ( event == "ADDON_LOADED" ) then
		if ( arg1 == "ChatLog" ) then
			-- Inits the structure of saved data
			ChatLog_InitStructure();
			
			--Enables logging to file if SavedVariables says to
			if (CHAT_LOG_CHAT_ENABLED == 1) then
				LoggingChat(1);
				ChatLogChatCheckBox:SetChecked(1);
			else
				LoggingChat(0);
				ChatLogChatCheckBox:SetChecked(0);
			end
			if (CHAT_LOG_COMBATCHAT_ENABLED == 1) then
				LoggingCombat(1);
				ChatLogCombatChatCheckBox:SetChecked(1);
			else
				LoggingCombat(0);
				ChatLogCombatChatCheckBox:SetChecked(0);
			end
			
			--Set current log index to default log index
			CHAT_LOG_CURRENT_INDEX = CHAT_LOG_DEFAULT_INDEX;
			
			--Enables logging by default if SavedVariables says to
			if (CHAT_LOG_ENABLED_DEFAULT == 1) then
				ChatLogEnabledDefaultCheckBox:SetChecked(1);
			else
				ChatLogEnabledDefaultCheckBox:SetChecked(0);
			end
			
			--Adds headers if necessary
			for index, itable in ipairs(ChatLog_Logs) do
				if (itable["enabled"] == 1) then
					ChatLog_AddHeader(index);
					ChatLog_CheckTableSize(itable["logs"]);
				end
			end
			
			--Gets the status of party
			CHAT_LOG_NUM_PARTY_MEMBERS = GetNumPartyMembers();
			CHAT_LOG_NUM_RAID_MEMBERS = GetNumRaidMembers();
			
			--Sets the alpha value of the main window
			ChatLogAlphaSlider:SetValue(CHAT_LOG_ALPHA);
			
			--Shows the default log
			ChatLog_ShowLog(CHAT_LOG_CURRENT_INDEX);
			
			--Shows the log
			DEFAULT_CHAT_FRAME:AddMessage("|c" .. ChatLog_MakeHex(CHAT_LOG_COLORS["SYSTEM"]["r"], CHAT_LOG_COLORS["SYSTEM"]["g"], CHAT_LOG_COLORS["SYSTEM"]["b"]) .. CHAT_LOG_LOADED_MESSAGE .. "|r");
		end
	end
	
	--UPDATE CHAT COLORS EVENT
	if ( event == "UPDATE_CHAT_COLOR" ) then
		ChatLog_ShowLog(CHAT_LOG_CURRENT_INDEX);
	end
	
	--CHAT EVENTS
	--Chat joining/changing/leaving
	if ( event == "CHAT_MSG_CHANNEL_NOTICE" ) then
		if (arg1 == "YOU_JOINED") then
			if (not (arg8 == nil)) then
				--arg8 contains a ChannelID
				if (not ChatLog_IsLogStructureDefined(arg8)) then
					tindex = ChatLog_CreateNewLogStructure(arg8);
					if (CHAT_LOG_ENABLED_DEFAULT == 1) then
						ChatLog_AddHeader(tindex);
					end
				end
				ChatLog_UpdateLogButtons();
			end
		elseif (arg1 == "YOU_CHANGED") then
			if (not (arg8 == nil)) then
				--arg8 contains a ChannelID
				if (not ChatLog_IsLogStructureDefined(arg8)) then
					tindex = ChatLog_CreateNewLogStructure(arg8);
					if (CHAT_LOG_ENABLED_DEFAULT == 1) then
						ChatLog_AddHeader(tindex);
					end
				end
				ChatLog_UpdateLogButtons();
			end
		elseif (arg1 == "YOU_LEFT") then
			if (not (arg8 == nil)) then
				--arg8 contains a ChannelID
				if (ChatLog_GetChatLogIndexByChannelID(arg8) == CHAT_LOG_CURRENT_INDEX) then
					ChatLog_SetEnableButton(ChatLogDelete, true);
				end
			end
		end
	end
	
	--Receiving/Sending
	if ( event == "CHAT_MSG_WHISPER" and ChatLog_Logs[CHAT_LOG_WHISPER_INDEX]["enabled"] == 1) then
		msg = "[" .. date("%H:%M:%S") .. "] |Hplayer:" .. arg2 .. "|h[" .. arg2 .. "]|h " .. CHAT_LOG_PLAYER_RECEIVE_WHISPER .. ": " .. arg1;

		ChatLog_LogInsert (ChatLog_Logs[CHAT_LOG_WHISPER_INDEX]["logs"], msg);
		ChatLog_CheckTableSize(ChatLog_Logs[CHAT_LOG_WHISPER_INDEX]["logs"]);
		if (CHAT_LOG_CURRENT_INDEX == CHAT_LOG_WHISPER_INDEX) then
			ChatLog_CurrentChatUpdateWithMessage(ChatLog_Logs[CHAT_LOG_WHISPER_INDEX]["logs"], msg);
		end
	end
	if ( event == "CHAT_MSG_WHISPER_INFORM" and ChatLog_Logs[CHAT_LOG_WHISPER_INDEX]["enabled"] == 1) then
		msg = "[" .. date("%H:%M:%S") .. "] " .. CHAT_LOG_PLAYER_SEND_WHISPER .. " |Hplayer:" .. arg2 .. "|h[" .. arg2 .. "]|h: " .. arg1;
			
		ChatLog_LogInsert (ChatLog_Logs[CHAT_LOG_WHISPER_INDEX]["logs"], msg);		
		ChatLog_CheckTableSize(ChatLog_Logs[CHAT_LOG_WHISPER_INDEX]["logs"]);
		if ( CHAT_LOG_CURRENT_INDEX == CHAT_LOG_WHISPER_INDEX) then
			ChatLog_CurrentChatUpdateWithMessage(ChatLog_Logs[CHAT_LOG_WHISPER_INDEX]["logs"], msg);
		end
	end
	if ( ((event == "CHAT_MSG_RAID") or (event == "CHAT_MSG_RAID_LEADER") or (event == "CHAT_MSG_RAID_WARNING")) and ChatLog_Logs[CHAT_LOG_RAID_INDEX]["enabled"] == 1) then
		if ( event == "CHAT_MSG_RAID_LEADER" ) then
			msg = "|c" .. ChatLog_MakeHex(ChatTypeInfo["RAID_LEADER"]["r"], ChatTypeInfo["RAID_LEADER"]["g"], ChatTypeInfo["RAID_LEADER"]["b"]) .. "[" .. date("%H:%M:%S") .. "] |Hplayer:" .. arg2 .. "|h[|c" .. ChatLog_MakeHex(CHAT_LOG_COLORS["RAID_LEADER"]["r"], CHAT_LOG_COLORS["RAID_LEADER"]["g"], CHAT_LOG_COLORS["RAID_LEADER"]["b"]) .. arg2 .. "|r]|h: " .. arg1 .. "|r";
		elseif ( event == "CHAT_MSG_RAID_WARNING" ) then
			msg = "|c" .. ChatLog_MakeHex(ChatTypeInfo["RAID_WARNING"]["r"], ChatTypeInfo["RAID_WARNING"]["g"], ChatTypeInfo["RAID_WARNING"]["b"]) .. "[" .. date("%H:%M:%S") .. "] |Hplayer:" .. arg2 .. "|h[" .. arg2 .. "]|h: " .. arg1 .. "|r";
		else
			msg = "[" .. date("%H:%M:%S") .. "] |Hplayer:" .. arg2 .. "|h[" .. arg2 .. "]|h: " .. arg1;
		end
		
		if (msg == nil) then
			msg = "DEBUG!";
		elseif (msg == "") then
			msg = "DEBUG2!";
		end
		
		ChatLog_LogInsert (ChatLog_Logs[CHAT_LOG_RAID_INDEX]["logs"], msg);
		ChatLog_CheckTableSize(ChatLog_Logs[CHAT_LOG_RAID_INDEX]["logs"]);
		if ( CHAT_LOG_CURRENT_INDEX == CHAT_LOG_RAID_INDEX) then
			ChatLog_CurrentChatUpdateWithMessage(ChatLog_Logs[CHAT_LOG_RAID_INDEX]["logs"], msg);
		end
	end
	if ( event == "CHAT_MSG_PARTY" and ChatLog_Logs[CHAT_LOG_PARTY_INDEX]["enabled"] == 1) then
		msg = "[" .. date("%H:%M:%S") .. "] |Hplayer:" .. arg2 .. "|h[" .. arg2 .. "]|h: " .. arg1;
		
		if (msg == nil) then
			msg = "DEBUG!";
		elseif (msg == "") then
			msg = "DEBUG2!";
		end
		
		ChatLog_LogInsert (ChatLog_Logs[CHAT_LOG_PARTY_INDEX]["logs"], msg);
		ChatLog_CheckTableSize(ChatLog_Logs[CHAT_LOG_PARTY_INDEX]["logs"]);
		if ( CHAT_LOG_CURRENT_INDEX == CHAT_LOG_PARTY_INDEX) then
			ChatLog_CurrentChatUpdateWithMessage(ChatLog_Logs[CHAT_LOG_PARTY_INDEX]["logs"], msg);
		end
	end
	if ( event == "CHAT_MSG_SAY" and ChatLog_Logs[CHAT_LOG_SAY_INDEX]["enabled"] == 1) then
		msg = "[" .. date("%H:%M:%S") .. "] |Hplayer:" .. arg2 .. "|h[" .. arg2 .. "]|h: " .. arg1;
		
		ChatLog_LogInsert (ChatLog_Logs[CHAT_LOG_SAY_INDEX]["logs"], msg);
		ChatLog_CheckTableSize(ChatLog_Logs[CHAT_LOG_SAY_INDEX]["logs"]);
		if ( CHAT_LOG_CURRENT_INDEX == CHAT_LOG_SAY_INDEX) then
			ChatLog_CurrentChatUpdateWithMessage(ChatLog_Logs[CHAT_LOG_SAY_INDEX]["logs"], msg);
		end
	end
	if ( event == "CHAT_MSG_YELL" and ChatLog_Logs[CHAT_LOG_YELL_INDEX]["enabled"] == 1) then
		msg = "[" .. date("%H:%M:%S") .. "] |Hplayer:" .. arg2 .. "|h[" .. arg2 .. "]|h: " .. arg1;
		
		ChatLog_LogInsert (ChatLog_Logs[CHAT_LOG_YELL_INDEX]["logs"], msg);
		ChatLog_CheckTableSize(ChatLog_Logs[CHAT_LOG_YELL_INDEX]["logs"]);
		if ( CHAT_LOG_CURRENT_INDEX == CHAT_LOG_YELL_INDEX) then
			ChatLog_CurrentChatUpdateWithMessage(ChatLog_Logs[CHAT_LOG_YELL_INDEX]["logs"], msg);
		end
	end
	if ( event == "CHAT_MSG_OFFICER" and ChatLog_Logs[CHAT_LOG_OFFICER_INDEX]["enabled"] == 1) then
		msg = "[" .. date("%H:%M:%S") .. "] |Hplayer:" .. arg2 .. "|h[" .. arg2 .. "]|h: " .. arg1;
		
		ChatLog_LogInsert (ChatLog_Logs[CHAT_LOG_OFFICER_INDEX]["logs"], msg);
		ChatLog_CheckTableSize(ChatLog_Logs[CHAT_LOG_OFFICER_INDEX]["logs"]);
		if ( CHAT_LOG_CURRENT_INDEX == CHAT_LOG_OFFICER_INDEX) then
			ChatLog_CurrentChatUpdateWithMessage(ChatLog_Logs[CHAT_LOG_OFFICER_INDEX]["logs"], msg);
		end
	end
	if ( event == "CHAT_MSG_GUILD" and ChatLog_Logs[CHAT_LOG_GUILD_INDEX]["enabled"] == 1) then
		msg = "[" .. date("%H:%M:%S") .. "] |Hplayer:" .. arg2 .. "|h[" .. arg2 .. "]|h: " .. arg1;
		
		ChatLog_LogInsert (ChatLog_Logs[CHAT_LOG_GUILD_INDEX]["logs"], msg);
		ChatLog_CheckTableSize(ChatLog_Logs[CHAT_LOG_GUILD_INDEX]["logs"]);
		if ( CHAT_LOG_CURRENT_INDEX == CHAT_LOG_GUILD_INDEX) then
			ChatLog_CurrentChatUpdateWithMessage(ChatLog_Logs[CHAT_LOG_GUILD_INDEX]["logs"], msg);
		end
	end
	
	if (event == "CHAT_MSG_CHANNEL") then
		if (not (arg8 == nil)) then
			local id, name = GetChannelName(arg8);
			local index;
			
			index = ChatLog_GetChatLogIndexByChannelID(ChatLog_MakeID(name));
			
			if (not (index == nil)) then
				if (ChatLog_Logs[index]["enabled"] == 1) then
					msg = "[" .. date("%H:%M:%S") .. "] |Hplayer:" .. arg2 .. "|h[" .. arg2 .. "]|h: " .. arg1;
					ChatLog_LogInsert (ChatLog_Logs[index]["logs"], msg);
					ChatLog_CheckTableSize(ChatLog_Logs[index]["logs"]);
					if ( CHAT_LOG_CURRENT_INDEX == index) then
						ChatLog_CurrentChatUpdateWithMessage(ChatLog_Logs[index]["logs"], msg);
					end
				end
			end
		end
	end
	
	--PARTY/RAID EVENTS
	if ( event == "PARTY_MEMBERS_CHANGED") then
		if ( not (GetNumPartyMembers() == CHAT_LOG_NUM_PARTY_MEMBERS) ) then
			if (GetNumPartyMembers() == 0) then
				msg = "|c" .. ChatLog_MakeHex(CHAT_LOG_COLORS["SYSTEM"]["r"], CHAT_LOG_COLORS["SYSTEM"]["g"], CHAT_LOG_COLORS["SYSTEM"]["b"]) .. "* You leave the group.|r";
			end
			if (CHAT_LOG_NUM_PARTY_MEMBERS == 0 and GetNumPartyMembers() > 0) then
				ChatLog_LogInsert (ChatLog_Logs[CHAT_LOG_PARTY_INDEX]["logs"], " ");
				ChatLog_CurrentChatUpdateWithMessage(ChatLog_Logs[CHAT_LOG_PARTY_INDEX]["logs"], " ");
				
				msg = "|c" .. ChatLog_MakeHex(CHAT_LOG_COLORS["SYSTEM"]["r"], CHAT_LOG_COLORS["SYSTEM"]["g"], CHAT_LOG_COLORS["SYSTEM"]["b"]) .. "* You joined a group. Members:";
				--For next release
				--if ( UnitIsPartyLeader("PLAYER") ) then
					--msg = msg .. " @" .. UnitName("PLAYER");
				--else
					--msg = msg .. " " .. UnitName("PLAYER");
				--end
				msg = msg .. " " .. UnitName("PLAYER");
				for i=1, MAX_PARTY_MEMBERS do
					if ( not (UnitName("PARTY" .. i) == nil) ) then
						--if ( UnitIsPartyLeader("PARTY" .. i) ) then
							--msg = msg .. " @" .. UnitName("PARTY" .. i);
						--else
							--msg = msg .. " " .. UnitName("PARTY" .. i);
						--end
						msg = msg .. " " .. UnitName("PARTY" .. i);
					end
				end
				msg = msg .. ".|r";
			end
			CHAT_LOG_NUM_PARTY_MEMBERS = GetNumPartyMembers();
			
			ChatLog_LogInsert (ChatLog_Logs[CHAT_LOG_PARTY_INDEX]["logs"], msg);
			ChatLog_CheckTableSize(ChatLog_Logs[CHAT_LOG_PARTY_INDEX]["logs"]);
			if ( CHAT_LOG_CURRENT_INDEX == CHAT_LOG_PARTY_INDEX) then
				ChatLog_CurrentChatUpdateWithMessage(ChatLog_Logs[CHAT_LOG_PARTY_INDEX]["logs"], msg);
			end
		end
	end
	
	if ( event == "RAID_ROSTER_UPDATE" ) then
		if ( not (GetNumRaidMembers() == CHAT_LOG_NUM_RAID_MEMBERS) ) then
			if ( GetNumRaidMembers() == 0 ) then
				msg = "|c" .. ChatLog_MakeHex(CHAT_LOG_COLORS["SYSTEM"]["r"], CHAT_LOG_COLORS["SYSTEM"]["g"], CHAT_LOG_COLORS["SYSTEM"]["b"]) .. "* You have left the raid group.|r";
			end
			if (CHAT_LOG_NUM_RAID_MEMBERS == 0 and GetNumRaidMembers() > 0) then
				ChatLog_LogInsert (ChatLog_Logs[CHAT_LOG_RAID_INDEX]["logs"], " ");
				ChatLog_CurrentChatUpdateWithMessage(ChatLog_Logs[CHAT_LOG_RAID_INDEX]["logs"], " ");
				
				msg = "|c" .. ChatLog_MakeHex(CHAT_LOG_COLORS["SYSTEM"]["r"], CHAT_LOG_COLORS["SYSTEM"]["g"], CHAT_LOG_COLORS["SYSTEM"]["b"]) .. "* You have joined a raid group. Members:";
				for i=1, MAX_RAID_MEMBERS do
					name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i);
					if ( not (name == nil) ) then
						--For next release
						--msg = msg .. " ";
						--if ( rank == 2 ) then
						--	msg = msg .. "@";
						--elseif ( rank == 1 ) then
						--	msg = msg .. "*";
						--end
						--msg = msg .. name;
						msg = msg .. " " .. name;
					end
				end
				msg = msg .. ".|r";
			end
			
			CHAT_LOG_NUM_RAID_MEMBERS = GetNumRaidMembers();
			
			ChatLog_LogInsert (ChatLog_Logs[CHAT_LOG_RAID_INDEX]["logs"], msg);
			ChatLog_CheckTableSize(ChatLog_Logs[CHAT_LOG_RAID_INDEX]["logs"]);
			if ( CHAT_LOG_CURRENT_INDEX == CHAT_LOG_RAID_INDEX) then
				ChatLog_CurrentChatUpdateWithMessage(ChatLog_Logs[CHAT_LOG_RAID_INDEX]["logs"], msg);
			end
		end
	end
end

function ChatLog_LogInsert(logs, msg)
	logs[getn(logs)+1] = msg;
end

function ChatLog_GetChatLogIndexByChannelID(ChannelID)
	local cid, cname = "", "";
	if ( type(ChannelID) ) then
		cid, cname = GetChannelName(ChannelID);
		if (cname == nil) then
			return nil;
		end
		cid = ChatLog_MakeID(cname);
	else
		cid = ChannelID;
	end
	
	for index, itable in ipairs(ChatLog_Logs) do
		if (itable["id"] == cid) then
			return index;
		end
	end
	
	return nil;
end

function ChatLog_CurrentChatUpdateWithMessage(msgTable, msg)
	if ((CHAT_LOG_CURRENT_MAXLINE == getn(msgTable)-1)) then
		ChatLog_AddLine(msg);
		CHAT_LOG_CURRENT_MAXLINE = getn(msgTable);
		ChatLog_SetCurrentLineText(getn(msgTable));
	elseif (CHAT_LOG_CURRENT_MAXLINE == CHAT_LOG_MAXSIZE) then
		ChatLog_AddLine(msg);
	end
end

function ChatLog_InitStructure()
	local ChannelList;
	local id, name, tindex;
	
	--Inits the name of logs in current locale
	ChatLog_Logs[CHAT_LOG_WHISPER_INDEX]["name"] = CHAT_LOG_WHISPER_NAME;
	ChatLog_Logs[CHAT_LOG_RAID_INDEX]["name"] = CHAT_LOG_RAID_NAME;
	ChatLog_Logs[CHAT_LOG_PARTY_INDEX]["name"] = CHAT_LOG_PARTY_NAME;
	ChatLog_Logs[CHAT_LOG_SAY_INDEX]["name"] = CHAT_LOG_SAY_NAME;
	ChatLog_Logs[CHAT_LOG_YELL_INDEX]["name"] = CHAT_LOG_YELL_NAME;
	ChatLog_Logs[CHAT_LOG_OFFICER_INDEX]["name"] = CHAT_LOG_OFFICER_NAME;
	ChatLog_Logs[CHAT_LOG_GUILD_INDEX]["name"] = CHAT_LOG_GUILD_NAME;
	
	ChannelList = { GetChannelList() };
	for index, value in ipairs(ChannelList) do
		if (type(value) == "number") then
			--value contains a ChannelID
			if (not ChatLog_IsLogStructureDefined(value)) then
				tindex = ChatLog_CreateNewLogStructure(value);
				if (CHAT_LOG_ENABLED_DEFAULT == 1) then
					ChatLog_AddHeader(tindex);
				end
			end
		end
	end
end

function ChatLog_MakeID(name)
	return string.lower(name);
end

function ChatLog_IsLogStructureDefined(ChannelID)
	local id, name = GetChannelName(ChannelID);
	
	id = ChatLog_MakeID(name);
	
	for index, itable in ipairs(ChatLog_Logs) do
		if (itable["id"] == id) then
			return true;
		end
	end
	return false;
end

function ChatLog_IsPlayerOnChannel(ChannelIDorName)
	local id, name, cid, cname;
	
	if (type(ChannelIDorName) == "number") then
		id, name = GetChannelName(ChannelIDorName);
		id = ChatLog_MakeID(name);
	else
		id = ChatLog_MakeID(ChannelIDorName);
	end
	
	ChannelList = { GetChannelList() };
	for index, value in ipairs(ChannelList) do
		if (type(value) == "number") then
			cid, cname = GetChannelName(value);
			cid = ChatLog_MakeID(cname);
			
			if (id == cid) then
				return true;
			end
		end
	end
	return false;
end

function ChatLog_CreateNewLogStructure(ChannelID)
	local id, name = GetChannelName(ChannelID);
	
	id = ChatLog_MakeID(name);
	
	tinsert(ChatLog_Logs, {
		["id"] = id,
		["name"] = name,
		["enabled"] = CHAT_LOG_ENABLED_DEFAULT,
		["logs"] = {},
	} );
	
	return getn(ChatLog_Logs);
end

function ChatLog_SetEnable(ChannelID, isEnabled)
	local id, name = GetChannelName(ChannelID);
	
	id = ChatLog_MakeID(name);
	
	for index=8, getn(ChatLog_Logs) do
		if (ChatLog_Logs[index]["id"] == id) then
			ChatLog_Logs[index]["enabled"] = isEnabled;
		end
	end
end

function ChatLogFrameDropDown_Initialize()
	local arg1, arg2;
	if (not (UIDROPDOWNMENU_MENU_VALUE == nil)) then
		arg1 = string.gsub(UIDROPDOWNMENU_MENU_VALUE, "^([^ ]+)[ ]*([^ ]*)$", "%1");
		arg2 = string.gsub(UIDROPDOWNMENU_MENU_VALUE, "^([^ ]+)[ ]*([^ ]*)$", "%2");
		if (arg2 == "") then
			arg2 = 0;
		else
			arg2 = tonumber(arg2);
		end
	end
	
	if (arg1 == "general") then
		if (arg2 == 0) then
			ChatLogFrameDropDown_AddButton("Next " .. CHAT_LOG_DROPDOWN_MAXBUTTONS .. " channels", 1, nil, 1, 1, "general " .. CHAT_LOG_DROPDOWN_MAXBUTTONS, ChatLogFrameDropDownOnClick);
		end
		
		local cCount=0, cMax;
		cMax = arg2+CHAT_LOG_DROPDOWN_MAXBUTTONS;
		for index=8, getn(ChatLog_Logs)  do
			if (ChatLog_MakeID(string.gsub(ChatLog_Logs[index]["name"], "(%w+) - (.+)", "%1")) == CHAT_LOG_GENERAL_STR) then
				cCount=cCount+1;
				if (cCount > cMax) then
					break;
				end
				if (cCount > arg2) then
					ChatLogFrameDropDown_AddButton(ChatLog_Logs[index]["name"], nil, ChatLog_Logs[index]["enabled"], ChatLog_IsPlayerOnChannel(ChatLog_Logs[index]["name"]), nil, ChatLog_Logs[index]["id"], ChatLogFrameDropDownOnClick);
				end
			end
		end
		return;
	elseif (arg1 == "trade") then
		if (arg2 == 0) then
			ChatLogFrameDropDown_AddButton("Next " .. CHAT_LOG_DROPDOWN_MAXBUTTONS .. " channels", 1, nil, 1, 1, "trade " .. CHAT_LOG_DROPDOWN_MAXBUTTONS, ChatLogFrameDropDownOnClick);
		end
		
		local cCount=0, cMax;
		cMax = arg2+CHAT_LOG_DROPDOWN_MAXBUTTONS;
		for index=8, getn(ChatLog_Logs)  do
			if (ChatLog_MakeID(string.gsub(ChatLog_Logs[index]["name"], "(%w+) - (.+)", "%1")) == CHAT_LOG_TRADE_STR) then
				cCount=cCount+1;
				if (cCount > cMax) then
					break;
				end
				if (cCount > arg2) then
					ChatLogFrameDropDown_AddButton(ChatLog_Logs[index]["name"], nil, ChatLog_Logs[index]["enabled"], ChatLog_IsPlayerOnChannel(ChatLog_Logs[index]["name"]), nil, ChatLog_Logs[index]["id"], ChatLogFrameDropDownOnClick);
				end
			end
		end
		return;
	elseif (arg1 == "localdefense") then
		if (arg2 == 0) then
			ChatLogFrameDropDown_AddButton("Next " .. CHAT_LOG_DROPDOWN_MAXBUTTONS .. " channels", 1, nil, 1, 1, "localdefense " .. CHAT_LOG_DROPDOWN_MAXBUTTONS, ChatLogFrameDropDownOnClick);
		end
		
		local cCount=0, cMax;
		cMax = arg2+CHAT_LOG_DROPDOWN_MAXBUTTONS;
		for index=8, getn(ChatLog_Logs)  do
			if (ChatLog_MakeID(string.gsub(ChatLog_Logs[index]["name"], "(%w+) - (.+)", "%1")) == CHAT_LOG_LOCALDEFENSE_STR) then
				cCount=cCount+1;
				if (cCount > cMax) then
					break;
				end
				if (cCount > arg2) then
					ChatLogFrameDropDown_AddButton(ChatLog_Logs[index]["name"], nil, ChatLog_Logs[index]["enabled"], ChatLog_IsPlayerOnChannel(ChatLog_Logs[index]["name"]), nil, ChatLog_Logs[index]["id"], ChatLogFrameDropDownOnClick);
				end
			end
		end
		return;
	elseif (arg1 == "worlddefense") then
		if (arg2 == 0) then
			ChatLogFrameDropDown_AddButton("Next " .. CHAT_LOG_DROPDOWN_MAXBUTTONS .. " channels", 1, nil, 1, 1, "worlddefense " .. CHAT_LOG_DROPDOWN_MAXBUTTONS, ChatLogFrameDropDownOnClick);
		end
		
		local cCount=0, cMax;
		cMax = arg2+CHAT_LOG_DROPDOWN_MAXBUTTONS;
		for index=8, getn(ChatLog_Logs)  do
			if (ChatLog_MakeID(string.gsub(ChatLog_Logs[index]["name"], "(%w+) - (.+)", "%1")) == CHAT_LOG_WORLDDEFENSE_STR) then
				cCount=cCount+1;
				if (cCount > cMax) then
					break;
				end
				if (cCount > arg2) then
					ChatLogFrameDropDown_AddButton(ChatLog_Logs[index]["name"], nil, ChatLog_Logs[index]["enabled"], ChatLog_IsPlayerOnChannel(ChatLog_Logs[index]["name"]), nil, ChatLog_Logs[index]["id"], ChatLogFrameDropDownOnClick);
				end
			end
		end
		return;
	elseif (arg1 == "lookingforgroup") then
		if (arg2 == 0) then
			ChatLogFrameDropDown_AddButton("Next " .. CHAT_LOG_DROPDOWN_MAXBUTTONS .. " channels", 1, nil, 1, 1, "lookingforgroup " .. CHAT_LOG_DROPDOWN_MAXBUTTONS, ChatLogFrameDropDownOnClick);
		end
		
		local cCount=0, cMax;
		cMax = arg2+CHAT_LOG_DROPDOWN_MAXBUTTONS;
		for index=8, getn(ChatLog_Logs)  do
			if (ChatLog_MakeID(string.gsub(ChatLog_Logs[index]["name"], "(%w+) - (.+)", "%1")) == CHAT_LOG_LOOKINGFORGROUP_STR) then
				cCount=cCount+1;
				if (cCount > cMax) then
					break;
				end
				if (cCount > arg2) then
					ChatLogFrameDropDown_AddButton(ChatLog_Logs[index]["name"], nil, ChatLog_Logs[index]["enabled"], ChatLog_IsPlayerOnChannel(ChatLog_Logs[index]["name"]), nil, ChatLog_Logs[index]["id"], ChatLogFrameDropDownOnClick);
				end
			end
		end
		return;
	elseif (arg1 == "guildrecruitment") then
		if (arg2 == 0) then
			ChatLogFrameDropDown_AddButton("Next " .. CHAT_LOG_DROPDOWN_MAXBUTTONS .. " channels", 1, nil, 1, 1, "guildrecruitment " .. CHAT_LOG_DROPDOWN_MAXBUTTONS, ChatLogFrameDropDownOnClick);
		end
		
		local cCount=0, cMax;
		cMax = arg2+CHAT_LOG_DROPDOWN_MAXBUTTONS;
		for index=8, getn(ChatLog_Logs)  do
			if (ChatLog_MakeID(string.gsub(ChatLog_Logs[index]["name"], "(%w+) - (.+)", "%1")) == CHAT_LOG_GUILDRECRUITMENT_STR) then
				cCount=cCount+1;
				if (cCount > cMax) then
					break;
				end
				if (cCount > arg2) then
					ChatLogFrameDropDown_AddButton(ChatLog_Logs[index]["name"], nil, ChatLog_Logs[index]["enabled"], ChatLog_IsPlayerOnChannel(ChatLog_Logs[index]["name"]), nil, ChatLog_Logs[index]["id"], ChatLogFrameDropDownOnClick);
				end
			end
		end
		return;
	end
	
	ChatLogFrameDropDown_AddButton("Game chats", 1, nil, nil, nil, 0, ChatLogFrameDropDownOnClick);
	for index=1, 7 do
		ChatLogFrameDropDown_AddButton(ChatLog_Logs[index]["name"], nil, ChatLog_Logs[index]["enabled"], true, nil, ChatLog_Logs[index]["id"], ChatLogFrameDropDownOnClick);
	end
	
	ChatLogFrameDropDown_AddButton("General chats", 1, nil, true, nil, 0, ChatLogFrameDropDownOnClick);
	ChatLogFrameDropDown_AddButton(CHAT_LOG_GENERAL_NAME, nil, nil, true, 1, "general", ChatLogFrameDropDownOnClick);
	ChatLogFrameDropDown_AddButton(CHAT_LOG_TRADE_NAME, nil, nil, true, 1, "trade", ChatLogFrameDropDownOnClick);
	ChatLogFrameDropDown_AddButton(CHAT_LOG_LOCALDEFENSE_NAME, nil, nil, true, 1, "localdefense", ChatLogFrameDropDownOnClick);
	ChatLogFrameDropDown_AddButton(CHAT_LOG_WORLDDEFENSE_NAME, nil, nil, true, 1, "worlddefense", ChatLogFrameDropDownOnClick);
	ChatLogFrameDropDown_AddButton(CHAT_LOG_LOOKINGFORGROUP_NAME, nil, nil, true, 1, "lookingforgroup", ChatLogFrameDropDownOnClick);
	ChatLogFrameDropDown_AddButton(CHAT_LOG_GUILDRECRUITMENT_NAME, nil, nil, true, 1, "guildrecruitment", ChatLogFrameDropDownOnClick);
	
	ChatLogFrameDropDown_AddButton("Other chats", 1, nil, nil, nil, 0, ChatLogFrameDropDownOnClick);
	for index=8, getn(ChatLog_Logs)  do
		local chname = string.lower(string.gsub(ChatLog_Logs[index]["name"], "(%w+) - (.+)", "%1"));
		if (
				not (chname == CHAT_LOG_GENERAL_STR)
			and not (chname == CHAT_LOG_TRADE_STR)
			and not (chname == CHAT_LOG_LOCALDEFENSE_STR)
			and not (chname == CHAT_LOG_WORLDDEFENSE_STR)
			and not (chname == CHAT_LOG_LOOKINGFORGROUP_STR)
			and not (chname == CHAT_LOG_GUILDRECRUITMENT_STR)
		) then
			ChatLogFrameDropDown_AddButton(ChatLog_Logs[index]["name"], nil, ChatLog_Logs[index]["enabled"], ChatLog_IsPlayerOnChannel(ChatLog_Logs[index]["name"]), nil, ChatLog_Logs[index]["id"], ChatLogFrameDropDownOnClick);
		end
	end
end

function ChatLogFrameDropDown_AddButton(text, isTitle, isChecked, isOn, hasArrow, value, func)
	local info = {};
	
	info.text = text;
	info.isTitle = isTitle;
	info.value = value;
	info.func = func;
	if (isChecked == 1) then
		info.checked = 1;
	else
		info.checked = nil;
	end
	info.hasArrow = hasArrow;
	if (not isOn) then
		info.textR = 0.4;
		info.textG = 0.4;
		info.textB = 0.4;
	end
	
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
end

function ChatLogFrameDropDownOnClick()
	local tindex;
	
	for index=1, getn(ChatLog_Logs) do
		if (ChatLog_Logs[index]["id"] == this.value) then
			CHAT_LOG_CURRENT_INDEX = index;
			ChatLog_ShowLog(index);
			break;
		end
	end
	
	CloseMenus();
end

function ChatLog_AddHeader(index)
	if (not (getn(ChatLog_Logs[index]["logs"]) == 0)) then
		ChatLog_LogInsert (ChatLog_Logs[index]["logs"], " ");
		ChatLog_LogInsert (ChatLog_Logs[index]["logs"], " ");
	end
	
	ChatLog_LogInsert (ChatLog_Logs[index]["logs"], "|c" .. ChatLog_MakeHex(CHAT_LOG_COLORS["SYSTEM"]["r"], CHAT_LOG_COLORS["SYSTEM"]["g"], CHAT_LOG_COLORS["SYSTEM"]["b"]) .. CHAT_LOG_LOGGING_STARTED_ON .. " " .. date("%m/%d/%Y") .. " " .. CHAT_LOG_LOGGING_STARTED_AT .. " " .. date("%H:%M:%S") .. ":|r");
end

function ChatLog_AddLine(line)
	ChatLogScrollMessageFrame:AddMessage(line);
end

function ChatLog_CheckTableSize(msgTable)
	while ( getn(msgTable) >  CHAT_LOG_MAXSIZE) do
		tremove(msgTable, 1);
	end
	
	if (CHAT_LOG_CURRENT_MAXLINE > CHAT_LOG_MAXSIZE) then
		CHAT_LOG_CURRENT_MAXLINE = CHAT_LOG_MAXSIZE;
	end
end

function ChatLog_ShowLog(index)
	CHAT_LOG_CURRENT_INDEX = index;
	
	ChatLog_SetCurrentTabText(index);
	
	ChatLog_SetColor(ChatLogScrollMessageFrame);
	ChatLog_SetColor(ChatLogWhichTabText);
	
	ChatLog_UpdateLogButtons();
	
	ChatLog_ExtractAndDisplayInfo(ChatLog_Logs[CHAT_LOG_CURRENT_INDEX]["logs"]);
end

function ChatLog_SetColor(obj)
	if (ChatLog_Logs[CHAT_LOG_CURRENT_INDEX]["id"] == CHAT_LOG_WHISPER_ID) then
		obj:SetTextColor(ChatTypeInfo["WHISPER"]["r"], ChatTypeInfo["WHISPER"]["g"], ChatTypeInfo["WHISPER"]["b"]);
	elseif (ChatLog_Logs[CHAT_LOG_CURRENT_INDEX]["id"] == CHAT_LOG_RAID_ID) then
		obj:SetTextColor(ChatTypeInfo["RAID"]["r"], ChatTypeInfo["RAID"]["g"], ChatTypeInfo["RAID"]["b"]);
	elseif (ChatLog_Logs[CHAT_LOG_CURRENT_INDEX]["id"] == CHAT_LOG_PARTY_ID) then
		obj:SetTextColor(ChatTypeInfo["PARTY"]["r"], ChatTypeInfo["PARTY"]["g"], ChatTypeInfo["PARTY"]["b"]);
	elseif (ChatLog_Logs[CHAT_LOG_CURRENT_INDEX]["id"] == CHAT_LOG_SAY_ID) then
		obj:SetTextColor(ChatTypeInfo["SAY"]["r"], ChatTypeInfo["SAY"]["g"], ChatTypeInfo["SAY"]["b"]);
	elseif (ChatLog_Logs[CHAT_LOG_CURRENT_INDEX]["id"] == CHAT_LOG_YELL_ID) then
		obj:SetTextColor(ChatTypeInfo["YELL"]["r"], ChatTypeInfo["YELL"]["g"], ChatTypeInfo["YELL"]["b"]);
	elseif (ChatLog_Logs[CHAT_LOG_CURRENT_INDEX]["id"] == CHAT_LOG_OFFICER_ID) then
		obj:SetTextColor(ChatTypeInfo["OFFICER"]["r"], ChatTypeInfo["OFFICER"]["g"], ChatTypeInfo["OFFICER"]["b"]);
	elseif (ChatLog_Logs[CHAT_LOG_CURRENT_INDEX]["id"] == CHAT_LOG_GUILD_ID) then
		obj:SetTextColor(ChatTypeInfo["GUILD"]["r"], ChatTypeInfo["GUILD"]["g"], ChatTypeInfo["GUILD"]["b"]);
	else
		obj:SetTextColor(ChatTypeInfo["CHANNEL"]["r"], ChatTypeInfo["CHANNEL"]["g"], ChatTypeInfo["CHANNEL"]["b"]);
	end
end

function ChatLog_ToggleEnableThisLog()
	local msg = "|c" .. ChatLog_MakeHex(CHAT_LOG_COLORS["SYSTEM"]["r"], CHAT_LOG_COLORS["SYSTEM"]["g"], CHAT_LOG_COLORS["SYSTEM"]["b"]) .. CHAT_LOG_LOGGING_STOPPED_AT .. " " .. date("%H:%M:%S") .. ".|r";
	
	CloseMenus();
	
	if (ChatLog_Logs[CHAT_LOG_CURRENT_INDEX]["enabled"] == 1) then
		ChatLog_Logs[CHAT_LOG_CURRENT_INDEX]["enabled"] = 0;
		ChatLog_LogInsert (ChatLog_Logs[CHAT_LOG_CURRENT_INDEX]["logs"], msg);
		
		ChatLog_UpdateLogButtons();
	else
		ChatLog_Logs[CHAT_LOG_CURRENT_INDEX]["enabled"] = 1;
		ChatLog_AddHeader(CHAT_LOG_CURRENT_INDEX);
		
		ChatLog_UpdateLogButtons();
	end
	
	ChatLog_ShowLog(CHAT_LOG_CURRENT_INDEX);
end

function ChatLog_UpdateLogButtons()
	if (ChatLog_Logs[CHAT_LOG_CURRENT_INDEX]["enabled"] == 1) then
		ChatLog_SetEnableButton(ChatLogEnable, true, CHAT_LOG_DISABLE_THIS_LOG);
	else
		ChatLog_SetEnableButton(ChatLogEnable, true, CHAT_LOG_ENABLE_THIS_LOG);
	end
	
	if (
			ChatLog_Logs[CHAT_LOG_CURRENT_INDEX]["id"] == CHAT_LOG_WHISPER_ID
		or	ChatLog_Logs[CHAT_LOG_CURRENT_INDEX]["id"] == CHAT_LOG_RAID_ID
		or	ChatLog_Logs[CHAT_LOG_CURRENT_INDEX]["id"] == CHAT_LOG_PARTY_ID
		or	ChatLog_Logs[CHAT_LOG_CURRENT_INDEX]["id"] == CHAT_LOG_SAY_ID
		or	ChatLog_Logs[CHAT_LOG_CURRENT_INDEX]["id"] == CHAT_LOG_YELL_ID
		or	ChatLog_Logs[CHAT_LOG_CURRENT_INDEX]["id"] == CHAT_LOG_OFFICER_ID
		or	ChatLog_Logs[CHAT_LOG_CURRENT_INDEX]["id"] == CHAT_LOG_GUILD_ID
		or	ChatLog_IsPlayerOnChannel(ChatLog_Logs[CHAT_LOG_CURRENT_INDEX]["id"]) == true
	) then
		ChatLog_SetEnableButton(ChatLogDelete, false);
	else
		ChatLog_SetEnableButton(ChatLogDelete, true);
	end
end

function ChatLog_DeleteThisLog()
	CloseMenus();
	
	tremove(ChatLog_Logs, CHAT_LOG_CURRENT_INDEX);
		
	CHAT_LOG_CURRENT_INDEX = CHAT_LOG_DEFAULT_INDEX;
	ChatLog_ShowLog(CHAT_LOG_CURRENT_INDEX);
end

function ChatLog_SetEnableButton(obj, isEnabled, text)
	if (not (text == nil)) then
		obj:SetText(text);
	end
	if (isEnabled == false) then
		obj:Disable();
	else
		obj:Enable();
	end
end

function ChatLog_ExtractAndDisplayInfo (msgTable, currentMaxLine)
	ChatLogScrollMessageFrame:Clear();
	
	if (not (currentMaxLine == nil)) then
		CHAT_LOG_CURRENT_MAXLINE = currentMaxLine;
		if (CHAT_LOG_CURRENT_MAXLINE > getn(msgTable)) then
			CHAT_LOG_CURRENT_MAXLINE = getn(msgTable);
		elseif (CHAT_LOG_CURRENT_MAXLINE < 1) then
			CHAT_LOG_CURRENT_MAXLINE = 1;
		end
	else
		CHAT_LOG_CURRENT_MAXLINE = getn(msgTable);
	end
	
	local i=0;
	for index, value in ipairs(msgTable) do
		i = i+1;
		if ( (i > (CHAT_LOG_CURRENT_MAXLINE-CHAT_LOG_SCROLLING_MESSAGE_FRAME_MAXLINES))
			and
		   ( (i <= CHAT_LOG_CURRENT_MAXLINE) ) ) then
		   ChatLog_AddLine(msgTable[index]);
		end
	end
	
	ChatLog_SetCurrentLineText(getn(msgTable));
end

function ChatLog_SetCurrentLineText(maxLines)
	ChatLogCurrentLineText:SetText(CHAT_LOG_CURRENT_MAXLINE .. " / " .. maxLines);
end

function ChatLog_OnCopyButtonClick ()
	ChatLogCopyFrame:Hide();
	
	ChatLog_ExtractCurrentAndDisplayCopyInfo(ChatLog_Logs[CHAT_LOG_CURRENT_INDEX]["logs"]);
	
	ChatLogCopyFrame:Show();
end

function ChatLog_ExtractCurrentAndDisplayCopyInfo (msgTable)
	ChatLogCopyEditBox:SetText("");
	
	local i, imax = 0, getn(msgTable);
	for index, value in ipairs(msgTable) do
		i = i+1;
		if ( (i > (imax-CHAT_LOG_COPY_MAXSIZE))
			and
		   ( (i <= imax) ) ) then
			ChatLogCopyEditBox:SetText(ChatLogCopyEditBox:GetText() .. value .. "\n");
		end
	end
end

function ChatLog_SetCurrentTabText()
	ChatLogWhichTabText:SetText("<" .. ChatLog_Logs[CHAT_LOG_CURRENT_INDEX]["name"] .. ">");
end

function ChatLog_Clear(index)
	local istart, iend;
	
	if (not (index == nil)) then
		istart = index;
		iend = index;
		DEFAULT_CHAT_FRAME:AddMessage(CHAT_LOG_TITLE .. ": " .. ChatLog_Logs[index]["name"] .. CHAT_LOG_CLEARED_MESSAGE);
	else
		istart = 1;
		iend = getn(ChatLog_Logs);
		DEFAULT_CHAT_FRAME:AddMessage(CHAT_LOG_ALLCLEARED_MESSAGE);
	end
	
	for index=istart, iend do
		ChatLog_Logs[index]["logs"] = {};
		if (ChatLog_Logs[index]["enabled"] == 1) then
			ChatLog_AddHeader(index);
		end
	end
	
	if (index == nil or index == CHAT_LOG_CURRENT_INDEX) then
		ChatLog_ShowLog(CHAT_LOG_CURRENT_INDEX);
	end
end

function ChatLog_EnableAll()
	for index=1, getn(ChatLog_Logs) do
		ChatLog_Logs[index]["enabled"] = 1;
	end
	
	DEFAULT_CHAT_FRAME:AddMessage(CHAT_LOG_ENABLED_ALL);
end

function ChatLog_DisableAll()
	for index=1, getn(ChatLog_Logs) do
		ChatLog_Logs[index]["enabled"] = 0;
	end
	
	DEFAULT_CHAT_FRAME:AddMessage(CHAT_LOG_DISABLED_ALL);
end

function ChatLog_SetTooltipText(title, msg1, msg2, msg3, msg4, msg5)
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	GameTooltip:SetText(title);
	GameTooltip:AddLine(msg1);
	GameTooltip:AddLine(msg2);
	GameTooltip:AddLine(msg3);
	GameTooltip:AddLine(msg4);
	GameTooltip:AddLine(msg5);
	GameTooltip:Show();
end

function ChatLog_Toggle()
	if(ChatLogFrame:IsVisible()) then
		HideUIPanel(ChatLogFrame);
	else
		ShowUIPanel(ChatLogFrame);
	end
end

function ChatLog_SlashCommand(args)
	local arg1, arg2;
	local index;
	
	arg1 = string.lower(string.gsub(args, "^([^ ]+)[ ]+(.*)$", "%1"));
	arg2 = string.lower(string.gsub(args, "^([^ ]+)[ ]+(.*)$", "%2"));
	
	if ( (arg1 == CHAT_LOG_PCLEAR) ) then
		index = ChatLog_GetChatLogIndexByChannelID(ChatLog_MakeID(arg2));
		
		if (arg2 == CHAT_LOG_PCLEAR_WHISPER) then
			ChatLog_Clear(CHAT_LOG_WHISPER_INDEX);
			if (CHAT_LOG_CURRENT_INDEX == CHAT_LOG_WHISPER_INDEX) then
				ChatLog_ShowLog(CHAT_LOG_CURRENT_INDEX);
			end
		elseif (arg2 == CHAT_LOG_PCLEAR_RAID) then
			ChatLog_Clear(CHAT_LOG_RAID_INDEX);
			if (CHAT_LOG_CURRENT_INDEX == CHAT_LOG_RAID_INDEX) then
				ChatLog_ShowLog(CHAT_LOG_CURRENT_INDEX);
			end
		elseif (arg2 == CHAT_LOG_PCLEAR_PARTY) then
			ChatLog_Clear(CHAT_LOG_PARTY_INDEX);
			if (CHAT_LOG_CURRENT_INDEX == CHAT_LOG_PARTY_INDEX) then
				ChatLog_ShowLog(CHAT_LOG_CURRENT_INDEX);
			end
		elseif (arg2 == CHAT_LOG_PCLEAR_SAY) then
			ChatLog_Clear(CHAT_LOG_SAY_INDEX);
			if (CHAT_LOG_CURRENT_INDEX == CHAT_LOG_SAY_INDEX) then
				ChatLog_ShowLog(CHAT_LOG_CURRENT_INDEX);
			end
		elseif (arg2 == CHAT_LOG_PCLEAR_YELL) then
			ChatLog_Clear(CHAT_LOG_YELL_INDEX);
			if (CHAT_LOG_CURRENT_INDEX == CHAT_LOG_YELL_INDEX) then
				ChatLog_ShowLog(CHAT_LOG_CURRENT_INDEX);
			end
		elseif (arg2 == CHAT_LOG_PCLEAR_OFFICER) then
			ChatLog_Clear(CHAT_LOG_OFFICER_INDEX);
			if (CHAT_LOG_CURRENT_INDEX == CHAT_LOG_OFFICER_INDEX) then
				ChatLog_ShowLog(CHAT_LOG_CURRENT_INDEX);
			end
		elseif (arg2 == CHAT_LOG_PCLEAR_GUILD) then
			ChatLog_Clear(CHAT_LOG_GUILD_INDEX);
			if (CHAT_LOG_CURRENT_INDEX == CHAT_LOG_GUILD_INDEX) then
				ChatLog_ShowLog(CHAT_LOG_CURRENT_INDEX);
			end
		elseif (not (index == nil)) then
			ChatLog_Clear(index);
			if (CHAT_LOG_CURRENT_INDEX == index) then
				ChatLog_ShowLog(CHAT_LOG_CURRENT_INDEX);
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage(CHAT_LOG_WRONG_PARAMETER_MESSAGE);
		end
	elseif (arg1 == CHAT_LOG_PRESET) then
		ChatLog_ResetPosition();
		ChatLog_ResetCopyPosition();
	elseif (arg1 == CHAT_LOG_PRESETBUTTON) then
		ChatLog_ResetButtonPosition();
	elseif (arg1 == CHAT_LOG_PHELP) then
		ChatLog_ShowHelp();
	elseif (arg1 == CHAT_LOG_PALLCLEAR) then
		ChatLog_Clear();
	elseif (arg1 == "") then
		ChatLog_Toggle();
	else
		ChatLog_ShowHelp();
	end
end

function ChatLog_ShowHelp()
	DEFAULT_CHAT_FRAME:AddMessage("|c" .. ChatLog_MakeHex(CHAT_LOG_COLORS["SYSTEM"]["r"], CHAT_LOG_COLORS["SYSTEM"]["g"], CHAT_LOG_COLORS["SYSTEM"]["b"]) .. CHAT_LOG_PHELP_TITLE .. "|r");
	DEFAULT_CHAT_FRAME:AddMessage("/chatlog -- " .. CHAT_LOG_PHELP_TOGGLE);
	DEFAULT_CHAT_FRAME:AddMessage("/chatlog " .. CHAT_LOG_PRESET .. " -- " .. CHAT_LOG_PHELP_RESET);
	DEFAULT_CHAT_FRAME:AddMessage("/chatlog " .. CHAT_LOG_PRESETBUTTON .. " -- " .. CHAT_LOG_PHELP_RESETBUTTON);
	DEFAULT_CHAT_FRAME:AddMessage("/chatlog " .. CHAT_LOG_PCLEAR .. " <name> -- " .. CHAT_LOG_PHELP_CLEAR);
	DEFAULT_CHAT_FRAME:AddMessage("/chatlog " .. CHAT_LOG_PALLCLEAR .. " -- " .. CHAT_LOG_PHELP_ALLCLEAR);
	DEFAULT_CHAT_FRAME:AddMessage("/chatlog " .. CHAT_LOG_PHELP .. " -- " .. CHAT_LOG_PHELP_HELP);
end

function ChatLog_ResetPosition()
	ChatLogFrame:ClearAllPoints();
	ChatLogFrame:SetPoint("TOP", 0, -100);
	
	if (not ChatLogFrame:IsVisible()) then
		ShowUIPanel(ChatLogFrame);
	end
end

function ChatLog_ResetCopyPosition()
	ChatLogCopyFrame:ClearAllPoints();
	ChatLogCopyFrame:SetPoint("TOP", 0, -150);
end

function ChatLog_ResetButtonPosition()
	ChatLogFrameMenuButton:ClearAllPoints();
	ChatLogFrameMenuButton:SetPoint("BOTTOM", "ChatFrameMenuButton", "TOP");
end

function ChatLog_ScrollUp()
	ChatLogScrollMessageFrame:ScrollUp();
end

function ChatLog_ScrollDown()
	ChatLogScrollMessageFrame:ScrollDown();
end

function ChatLog_LogChatIntoFile_Toggle()
	if (ChatLogChatCheckBox:GetChecked() == 1) then
		LoggingChat(1);
		CHAT_LOG_CHAT_ENABLED = 1;
	else
		LoggingChat(0);
		CHAT_LOG_CHAT_ENABLED = 0;
	end
end

function ChatLog_EnabledDefault_Toggle()
	if (ChatLogEnabledDefaultCheckBox:GetChecked() == 1) then
		CHAT_LOG_ENABLED_DEFAULT = 1;
	else
		CHAT_LOG_ENABLED_DEFAULT = 0;
	end
end

function ChatLog_LogCombatChatIntoFile_Toggle()
	if (ChatLogCombatChatCheckBox:GetChecked() == 1) then
		LoggingCombat(1);
		CHAT_LOG_COMBATCHAT_ENABLED = 1;
	else
		LoggingCombat(0);
		CHAT_LOG_COMBATCHAT_ENABLED = 0;
	end
end

function ChatLog_OnSliderValueChange(value)
	CHAT_LOG_ALPHA = value;
	ChatLog_SetAlpha (value);
end

function ChatLog_SetAlpha (alpha)
	if (alpha < 0) then
		alpha = 0;
	elseif (alpha > 1) then
		alpha = 1;
	end
	
	ChatLog:SetAlpha(alpha);
end

function ChatLog_OnMouseWheel(arg1)
	if (arg1 > 0) then
		ChatLog_ExtractAndDisplayInfo(ChatLog_Logs[CHAT_LOG_CURRENT_INDEX]["logs"], CHAT_LOG_CURRENT_MAXLINE-2);
	elseif (arg1 < 0) then
		ChatLog_ExtractAndDisplayInfo(ChatLog_Logs[CHAT_LOG_CURRENT_INDEX]["logs"], CHAT_LOG_CURRENT_MAXLINE+2);
	end
end

function ChatLog_AlphaSlider_OnLoad()
	ChatLogAlphaSliderText:SetText(CHAT_LOG_ALPHA_SLIDER_TITLE);
	ChatLogAlphaSliderHigh:SetText();
	ChatLogAlphaSliderLow:SetText();
	ChatLogAlphaSlider:SetMinMaxValues(0.25,1.0);
	ChatLogAlphaSlider:SetValueStep(0.01);
end

function ChatLog_MakeHex (r, g, b)
	r = string.format("%x", r*255);
	g = string.format("%x", g*255);
	b = string.format("%x", b*255);
	
	if ( strlen(r) < 1 ) then
		r = "00";
	elseif ( strlen(r) < 2 ) then
		r = "0" .. r;
	end
	if ( strlen(g) < 1 ) then
		g = "00";
	elseif ( strlen(g) < 2 ) then
		g = "0" .. g;
	end
	if ( strlen(b) < 1 ) then
		b = "00";
	elseif ( strlen(b) < 2 ) then
		b = "0" .. b;
	end
	
	return ("00" .. r .. g .. b);
end