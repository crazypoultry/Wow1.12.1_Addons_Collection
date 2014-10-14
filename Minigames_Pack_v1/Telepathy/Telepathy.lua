--[[
--
--	Telepathy
--		Addon Hidden Chat Communication Library
--
--	By Karl Isenberg (AnduinLothar)
--
--
--
--	$Id: Telepathy.lua 3777 2006-07-11 11:11:44Z karlkfi $
--	$Rev: 3777 $
--	$LastChangedBy: karlkfi $
--	$Date: 2006-07-11 06:11:44 -0500 (Tue, 11 Jul 2006) $
--]]

local TELEPATHY_NAME 			= "Telepathy"
local TELEPATHY_VERSION 		= 1.21
local TELEPATHY_LAST_UPDATED	= "August 6, 2006"
local TELEPATHY_AUTHOR 			= "AnduinLothar"
local TELEPATHY_EMAIL			= "karlkfi@cosmosui.org"
local TELEPATHY_WEBSITE			= "http://www.wowwiki.com/Telepathy"

------------------------------------------------------------------------------
--[[ Embedded Sub-Library Load Algorithm ]]--
------------------------------------------------------------------------------

if (not Telepathy) then
	Telepathy = {};
end
local isBetterInstanceLoaded = (Telepathy.version and Telepathy.version >= TELEPATHY_VERSION);

if (not isBetterInstanceLoaded) then
	
	Telepathy.version = TELEPATHY_VERSION;

	------------------------------------------------------------------------------
	--[[ Table Initialization ]]--
	------------------------------------------------------------------------------
	
	local function VarInitTable(key)
		if (not Telepathy[key]) then
			Telepathy[key] = {};
		end
	end
	
	-- A list containing the known GlobalComm channel users
	VarInitTable("GlobalCommMemberList");
	
	-- A list containing addons that use the GlobalComm channel
	VarInitTable("GlobalChannelUsers");
	
	-- Event map
	VarInitTable("eventMap");
	
	-- Chat Message Listeners
	VarInitTable("Listeners");
	
	-- Storage for incomplete messages
	VarInitTable("partialMessages");
	
	--init selection
	SELECTED_CHAT_FRAME = DEFAULT_CHAT_FRAME;
	
	------------------------------------------------------------------------------
	--[[ Variable Sync ]]--
	------------------------------------------------------------------------------
	
	--Saved Config Variables
	if (not Telepathy_Config) then
		Telepathy_Config = {};
		-- Init Auto-join: Enabled by default (only actually joins if an addon registers for it)
		Telepathy_Config.AllowAutoJoin = true;
	end
	
	------------------------------------------------------------------------------
	--[[ Global Keywords ]]--
	------------------------------------------------------------------------------
	
	-- Channel name generating functions
	Telepathy.GLOBAL_CHANNEL = "GlobalComm";
	Telepathy.WHISPER_TAG = "<T>";
	Telepathy.OBJECT_TAG = "<O>";
	Telepathy.CURRENT_OBJECT = 0;
	
	------------------------------------------------------------------------------
	--[[ Local Regex ]]--
	------------------------------------------------------------------------------
	
	local SLURRED_SPEECH_REGEX = string.gsub(SLURRED_SPEECH, "%%s", "(.*)", 1); --SLURRED_SPEECH = "(.*) ...hic!";
	
	------------------------------------------------------------------------------
	--[[ Debug Print Variables ]]--
	------------------------------------------------------------------------------

	Telepathy.Debug = {
		MESSAGES = false;
		CHANNELMANAGER = false;
		EVENTS = false;
		TESTER_MODE = false;
		CHAT = false;
	};
	
	
	------------------------------------------------------------------------------
	--[[ User Functions: Outbound Messages ]]--
	------------------------------------------------------------------------------
	
	--[[
	--	sendMessage ( id, message, method [, target [, priority] ] )
	--
	--		Sends a hidden text message to a specified target or channel.
	--
	--	Args:
	--		id - text id passed to identify sending and recieving addon
	--		message - the text to be delivered
	--		method - "GLOBAL", "PARTY", "RAID", "GUILD", "BATTLEGROUND" or "WHISPER"
	--		target - player name for "WHISPER" target (Optional)
	--		priority - "ALERT", "NORMAL", "BULK" (Optional - Defaults to "NORMAL")
	--
	--]]
	function Telepathy.sendMessage(id, message, method, target, priority)
		
		if (type(id) ~= "string") then
			Sea.io.error("Invalid id (", id, ") passed for sendMessage from ", this:GetName());
			return;
		end
		
		if (strfind(id, "\t")) then
			Sea.io.error("Invalid id containing \t (", id, ") passed for sendMessage from ", this:GetName());
			return;
		end
		
		if (not message) then
			Sea.io.error("Nil message passed to Telepathy.sendMessage by: ", this:GetName(), " ", id, ", ", message, ", ", method, ", ", target);
			return;
		end
	
		if (type(message) ~= "string" and type(message) ~= "number") then
			Sea.io.error("Invalid message sent to Telepathy.sendMessage by : ", this:GetName(), " type: ", type(message));
			return;
		end
		
		if (strfind(message, "\006") or strfind(message, "\007") or strfind(message, "\008")  or strfind(message, "\009")) then
			Sea.io.error("Invalid message (", message, ") containing \\006 or \\007 or \\008 or \\009 which are reserved for Telepathy formatting passed for sendMessage from ", this:GetName());
			return;
		end
	
		if (not method or method ~= "GLOBAL" and method ~= "PARTY" and method ~= "RAID" and method ~= "GUILD" and method ~= "BATTLEGROUND" and method ~= "WHISPER") then
			Sea.io.error("Invalid method sent to Telepathy.sendMessage by : ", this:GetName(), " method: ", method);
			return;
		end
	
		if (method == "WHISPER" and not target) then
			Sea.io.error("No player target sent for message to Telepathy by: ", this:GetName());
			return;
		end
		
		if (not priority) then
			priority = "NORMAL";
		elseif (priority ~= "ALERT" and priority ~= "NORMAL" and priority ~= "BULK") then
			Sea.io.error("Invalid priority sent to Telepathy.sendMessage by : ", this:GetName(), " priority: ", priority);
			return;
		end
		
		local globalChanIndex;
		if (method == "GLOBAL") then
			globalChanIndex = GetChannelName(Telepathy.GLOBAL_CHANNEL);
			if (globalChanIndex == 0) then
				Sea.io.error("Can't send a message to the GlobalComm channel when you are not in it! ", this:GetName());
				return;
			end
		end

		local datagrams, size = Telepathy.packetizeMessage(id, message, method);
		for i=1, size do
			if (method == "GLOBAL") then
				ChatThrottleLib:SendChatMessage(priority, id, datagrams[i], "CHANNEL", nil, globalChanIndex);
			elseif (method == "WHISPER") then
				ChatThrottleLib:SendChatMessage(priority, id, datagrams[i], "WHISPER", nil, target);
			else
				ChatThrottleLib:SendAddonMessage(priority, id, datagrams[i], method);
			end
		end
	end
	
	--[[
	--	sendTable ( id, object, method [, target [, priority] ] )
	--
	--		Sends a lua serialized object using Telepathy.
	--		See sendMessage for argument details
	--
	--]]
	function Telepathy.sendTable(id, object, method, target, priority)
	
		if ( not object ) then
			Sea.io.error("No object sent to Telepathy.sendTable by: ",this:GetName());
			return;
		end
	
		local serializedObject = Sea.string.objectToString(object);
		local tag = Telepathy.OBJECT_TAG;
		serializedObject = tag..serializedObject;
		Telepathy.sendMessage(id, serializedObject, method, target, priority);
	end
	
	
	------------------------------------------------------------------------------
	--[[ User Functions: Inbound Messages ]]--
	------------------------------------------------------------------------------
	
	--[[
	--
	--	registerListener ( id, method, callback, partialCallback )
	--
	--		Registers a listener which will call a callback function when a message is recieved.
	--
	--	args:
	--		id - text id passed to identify sending and recieving addon
	--		method - table or string of events to listen for ("GLOBAL", "PARTY", "RAID", "GUILD", "BATTLEGROUND" or "WHISPER")
	--			ex: "GLOBAL" 
	--			ex: { "GLOBAL", "WHISPER" }
	--		callback - function(message, sender, method)
	--				[called when a complete message is recieved]
	--			message - message recieved
	--			sender - person who sent the message
	--			method - "GLOBAL", "PARTY", "RAID", "GUILD", "BATTLEGROUND" or "WHISPER"
	--		partialCallback - function(sender, method, sequenceNumber, sequenceCount, numberRecieved)
	--				[called when a partial message is recieved; not called for the final piece]
	--			sender - person who sent the datagram (partial message)
	--			method - "GLOBAL", "PARTY", "RAID", "GUILD", "BATTLEGROUND" or "WHISPER"
	--			sequenceNumber - currently recieved datagram sequence number
	--			sequenceCount - total datagrams expected
	--			numberRecieved - total number of recieved datagrams (out of sequenceCount)
	--
	--	returns:
	--		true if successful
	--		false if unable to register
	--]]
	function Telepathy.registerListener(id, method, callback, partialCallback)
		
		if (type(id) ~= "string") then
			Sea.io.error("Invalid id (", id, ") passed for Listener from ", this:GetName());
			return;
		end
		
		if (strfind(id, "\t")) then
			Sea.io.error("Invalid id containing \t (", id, ") passed for Listener from ", this:GetName());
			return;
		end
		
		if (type(method) == "table") then
			for i, currMethod in ipairs(method) do
				if (currMethod ~= "GLOBAL" and currMethod ~= "PARTY" and currMethod ~= "RAID" and currMethod ~= "GUILD" and currMethod ~= "BATTLEGROUND" and currMethod ~= "WHISPER") then
					Sea.io.error("Invalid method (", currMethod, ") specified for Listener: ", id);
					return;
				end
			end
		elseif (type(method) == "string") then
			if (method ~= "GLOBAL" and method ~= "PARTY" and method ~= "RAID" and method ~= "GUILD" and method ~= "BATTLEGROUND" and method ~= "WHISPER") then
				Sea.io.error("Invalid method (", method, ") specified for Listener: ", id);
				return;
			end
		else
			Sea.io.error("Invalid method (", method, ") specified for Listener: ", id);
			return;
		end
		
		if (not callback or type(callback) ~= "function") then
			Sea.io.error("Invalid callback function specified for Listener: ", id);
			return;
		end
	
		if (partialCallback and type(partialCallback) ~= "function") then
			Sea.io.error("Invalid partialCallback function specified for Listener: ", id);
			return
		end
		
		if ( Telepathy.Listeners[id] ) then
			if (type(method) == "table") then
				for i, currMethod in ipairs(method) do
					if ( Telepathy.Listeners[id][currMethod] ) then
						Sea.io.dprint(Telepathy.Debug.MESSAGES, "Duplicate Listener ID (", id, ") and METHOD (", currMethod, ") from ", this:GetName());
					end
				end
			elseif ( Telepathy.Listeners[id][method] ) then
				Sea.io.dprint(Telepathy.Debug.MESSAGES, "Duplicate Listener ID (", id, ") and METHOD (", method, ") from ", this:GetName());
			end
		end
		
		if (not Telepathy.Listeners[id]) then
			Telepathy.Listeners[id] = {};
		end
		
		local global;
		if (type(method) == "table") then
			for i, currMethod in ipairs(method) do
				if (currMethod == "GLOBAL") then
					global = true;
				end
				Telepathy.Listeners[id][currMethod] = { callback=callback, partialCallback=partialCallback };
			end
		else
			global = (method == "GLOBAL");
			Telepathy.Listeners[id][method] = { callback=callback, partialCallback=partialCallback };
		end
		
		if (method == "GLOBAL") then
			-- Only join immediately if auto-join is enabled and it is after init
			if (ChronosData.initialized and Telepathy_Config.AllowAutoJoin) then
				JoinChannelByName(Telepathy.GLOBAL_CHANNEL);
			end
		end
		
		return true;
	end
	
	--[[
	--	unregisterListener ( id [, method] )
	--		unregisters the mailbox with the specified id
	--
	--	args:
	--		id - string id of the mailbox
	--		method - method listened for (Optional)
	--]]
	function Telepathy.unregisterListener(id, method)
		if (not Telepathy.Listeners[id]) then
			return;
		end
		
		if (method) then
			if (not Telepathy.Listeners[id][method]) then
				return;
			end
			
			Telepathy.Listeners[id][method] = nil;
			
			local found;
			for id, info in Telepathy.Listeners[id] do
				found = true;
				break;
			end
			if (not found) then
				Telepathy.Listeners[id] = nil;
			end
		else
			Telepathy.Listeners[id] = nil;
		end
		
		if (not Telepathy.isGlobalChannelRegisteredForUse()) then
			local number = GetChannelName(Telepathy.GLOBAL_CHANNEL);
			if (number > 0) then
				LeaveChannelByName(Telepathy.GLOBAL_CHANNEL);
			end
		end
	end
	
	--[[
	--	isListener ( id [, method] )
	--		returns true if the id/method is already in use
	--		by a mailbox
	--
	--	args:
	--		id - string id
	--		method - method listened for (Optional)
	--
	--	returns:
	--		boolean - listener is registered
	--]]
	function Telepathy.isListener(id, method)
		if (method) then
			return (Telepathy.Listeners[id] ~= nil and Telepathy.Listeners[id][method] ~= nil);
		else
			return (Telepathy.Listeners[id] ~= nil);
		end
	end
	
	
	------------------------------------------------------------------------------
	--[[ User Functions: Global Channel Management ]]--
	------------------------------------------------------------------------------
	
	--[[
	--	isInGlobalChannel ( username )
	--		Checks if a username is in the GlobalComm channel
	--
	--		Due to the way the list updates,
	--		You should do this a seconds or two after joining the channel.
	--
	--	returns:
	--		boolean - is in the global channel
	--]]
	function Telepathy.isInGlobalChannel(username)
		local number, name = GetChannelName(Telepathy.GLOBAL_CHANNEL);
		if (not name) then
			return false;
		elseif (not username) then
			return true;
		elseif ( type ( username ) ~= "string" ) then
			Sea.io.error("Invalid username sent to Telepathy.isInGlobalChannel: ", username, " from ", this:GetName());
			return;
		end
		return Telepathy.GlobalCommMemberList[username];
	end
	
	--[[
	--	getCurrentChannelTable()
	--		Gets an iteratable list of active channels.
	--
	--	returns: 
	--		currChannelList table { [index] = name }: 
	--			index - the current numerical index of the channel.
	--			name - the full name of the channel.
	--]]
	function Telepathy.getCurrentChannelTable()
		local list = {GetChannelList()};
		local currChannelList = {};
		for i=1, getn(list), 2 do
			table.insert(currChannelList, tonumber(list[i]), list[i+1]);
		end
		return currChannelList;
	end
	
	--[[
	--	getChannelCount()
	--		returns the number of channels you are currently in
	--]]
	function Telepathy.getChannelCount()
		local count = 0;
		local currChannelList = Telepathy.getCurrentChannelTable();
	
		for k,v in currChannelList do
			count = count + 1;
		end
		--doesn't count possibly hidden trade channel
		return count;
	end
	
	------------------------------------------------------------------------------
	--[[ Global Channel Auto-Join Management ]]--
	------------------------------------------------------------------------------
	
	--[[
	--	enableGlobalChannelAutoJoin ()
	--		Enable auto-join for a GlobalComm channel
	--		Channel Auto-Join is a user (not addon) controlled setting that overrides channel registration.
	--
	--]]
	function Telepathy.enableGlobalChannelAutoJoin()
		Telepathy_Config.AllowAutoJoin = true;
		-- Join if changed, after init, registered for by an addon and not currently active
		if (ChronosData.initialized and Telepathy.isGlobalChannelRegisteredForUse()) then
			local number = GetChannelName();
			-- Only join if you aren't already in it
			if (number == 0) then
				JoinChannelByName(Telepathy.GLOBAL_CHANNEL);
			end
		end
	end
	
	--[[
	--	disableGlobalChannelAutoJoin ()
	--		Disable auto-join for a GlobalComm channel
	--		Channel Auto-Join is a user (not addon) controlled setting that overrides channel registration.
	--
	--]]
	function Telepathy.disableGlobalChannelAutoJoin()
		Telepathy_Config.AllowAutoJoin = nil;
		-- leave if currently active
		local number = GetChannelName();
		if (number > 0) then
			LeaveChannelByName(Telepathy.GLOBAL_CHANNEL);
		end
	end
	
	--[[
	--	isGlobalChannelRegisteredForUse ()
	--		Checks if a GlobalComm is registered for use
	--
	--]]
	function Telepathy.isGlobalChannelRegisteredForUse()
		for addon, value in Telepathy.Listeners do
			if (value["GLOBAL"]) then
				return true;
			end
		end
		return false;
	end
	
	--[[
	--	updateGlobalChannel()
	--		Join/Leaves the GlobalComm channel
	--]]
	function Telepathy.updateGlobalChannel(delay)
		if ( Telepathy.online ) then
			if (delay or not ChronosData.initialized) then
				Sea.io.dprint(Telepathy.Debug.CHANNELMANAGER, "Delaying Channel Refresh...");
				Chronos.scheduleByName("TelepathyChannelMonitor", 1, Telepathy.updateGlobalChannel );
			else
				Sea.io.dprint(Telepathy.Debug.CHANNELMANAGER, "Channel Refreshed!");
				local number, name = GetChannelName(Telepathy.GLOBAL_CHANNEL);
				if (number == 0) then
					-- Not Active
					if (Telepathy_Config.AllowAutoJoin and Telepathy.isGlobalChannelRegisteredForUse() and Telepathy.getChannelCount() < 10) then
						JoinChannelByName(Telepathy.GLOBAL_CHANNEL);
					end
				else
					-- Active
					if (Telepathy_Config.AllowAutoJoin and not Telepathy.isGlobalChannelRegisteredForUse()) then
						LeaveChannelByName(number);
					end
				end
			end
		end
	end
	
	
	------------------------------------------------------------------------------
	--[[ Message Processing ]]--
	------------------------------------------------------------------------------
	
	--[[
	--	fragmentMessage()
	--
	--		This function breaks a text string (message) into packaged datagrams.
	--]]
	function Telepathy.packetizeMessage(id, message, method)
		
		-- Bell conversion converts all outgoing linebreaks to Bells (\007) and then back again when recieved.
		message =  string.gsub(message, "\n", "\007");
		-- Pipes indicate links in wow chat
		message =  string.gsub(message, "|", "\008");
		
		if (method == "GLOBAL" or method == "WHISPER") then
			-- Sobriety filter
			message =  string.gsub(message, "s", "\009");
			message =  string.gsub(message, "S", "\006");
		end
		
		Telepathy.CURRENT_OBJECT = Telepathy.CURRENT_OBJECT + 1;
		if (Telepathy.CURRENT_OBJECT > 99) then
			Telepathy.CURRENT_OBJECT = 0;
		end
		local currObj = format("%.2d", Telepathy.CURRENT_OBJECT);
		
		--local maxMessageLength = 254;
		--local sluredMaxLength = 10;
		--local datagramSize = maxMessageLength - sluredMaxLength;
		local datagramSize = 244;
		
		--[[
			-- Datagram Packaging --
			Message Size Components:
		 		"GLOBAL":
		 			id:##:##/##:message
		 		"WHISPER":
		 			<T>id:##:##/##:message
		 		"PARTY", "RAID", "GUILD", "BATTLEGROUND":
		 			##:##/##:message

		]]--
		
		local datagrams = {};
		local numDatagrams, part;
		
		if (method == "GLOBAL") then
			datagramSize = datagramSize - strlen(id) - 10;
			numDatagrams = math.ceil(strlen(message) / datagramSize);
			for i=1, numDatagrams do
				part = strsub(message, 1, datagramSize);
				message = strsub(message, datagramSize+1);
				table.insert(datagrams, id..":"..currObj..":"..i.."/"..numDatagrams..":"..part);
			end
			
		elseif (method == "WHISPER") then
			local tag = Telepathy.WHISPER_TAG;
			local tagSize = strlen(tag);
			datagramSize = datagramSize - tagSize - strlen(id) - 10;
			numDatagrams = math.ceil(strlen(message) / datagramSize);
			for i=1, numDatagrams do
				part = strsub(message, 1, datagramSize);
				message = strsub(message, datagramSize+1);
				table.insert(datagrams, tag..id..":"..currObj..":"..i.."/"..numDatagrams..":"..part);
			end
			
		else
			datagramSize = datagramSize - 13;
			numDatagrams = math.ceil(strlen(message) / datagramSize);
			for i=1, numDatagrams do
				part = strsub(message, 1, datagramSize);
				message = strsub(message, datagramSize+1);
				table.insert(datagrams, currObj..":"..i.."/"..numDatagrams..":"..part);
			end
		end
		
		return datagrams, numDatagrams;
	end
	

	--[[
	--	unwrapDatagram(id, message, method)
	--
	--		Creates a datagram from a text string (message)
	--
	--	returns:
	--		table - the datagram
	--]]
	function Telepathy.unwrapDatagram(id, message, method)
		
		--[[
			-- Datagram Packaging --
			Message Size Components:
		 		"GLOBAL":
		 			id:##:##/##:message
		 		"WHISPER":
		 			<T>id:##:##/##:message
		 		"PARTY", "RAID", "GUILD", "BATTLEGROUND":
		 			##:##/##:message

		]]--
		if (type(message) ~= "string") then
			return;
		end
		
		-- Bell conversion converts all incomming bells (\007) to line breaks since sending linebreaks causes disconnects.
		message = string.gsub(message, "\007", "\n");
		-- Pipes indicate links in wow chat
		message = string.gsub(message, "\008", "|");
		
		if (method == "GLOBAL" or method == "WHISPER") then
			-- Sobriety filter
			message = string.gsub(message, "\009", "s");
			message = string.gsub(message, "\006", "S");
			message = string.gsub(message, SLURRED_SPEECH_REGEX, "%1");
		end
		
		local _, objIndex, sequenceNumber, sequenceCount;
		if (method == "GLOBAL") then
			_, _, id, objIndex, sequenceNumber, sequenceCount, message = strfind(message,
				"(.+):(%d+):(%d+)%/(%d+):(.*)"
			);
		elseif (method == "WHISPER") then
			_, _, id, objIndex, sequenceNumber, sequenceCount, message = strfind(message,
				Telepathy.WHISPER_TAG.."(.+):(%d+):(%d+)%/(%d+):(.*)"
			);
		else
			_, _, objIndex, sequenceNumber, sequenceCount, message = strfind(message,
				"(%d+):(%d+)%/(%d+):(.*)"
			);
		end
		
		return id, tonumber(objIndex), tonumber(sequenceNumber), tonumber(sequenceCount), message;
	end
	
	
	------------------------------------------------------------------------------
	--[[ Chat Event Parsing ]]--
	------------------------------------------------------------------------------
	
	--[[
	--	scanMessage (envelope)
	--		Scans an envelope, and put it in the appropriate mailbox if accepted
	--
	--]]
	function Telepathy.scanMessage(id, method, message, sender, sequenceNumber, sequenceCount, objectID)
		Sea.io.dprint(Telepathy.Debug.MESSAGES, "Scanning Envelope ", id, method, message, sender, sequenceNumber, sequenceCount, objectID);
		local listener = Telepathy.Listeners[id];
		if (not listener) then
			return;
		end
		if (not listener[method]) then
			return;
		else
			listener = listener[method];
		end
		
		if (sequenceCount == 1) then
			if (Sea.string.startsWith(message, Telepathy.OBJECT_TAG)) then
				message = Sea.string.stringToObject(strsub(message, strlen(Telepathy.OBJECT_TAG)+1));
			end
			listener.callback(message, sender, method, objectID);
		else
			table.insert(Telepathy.partialMessages, { id=id, method=method, message=message, sender=sender, sequenceNumber=sequenceNumber, sequenceCount=sequenceCount, objectID=objectID });
			
			local messageTable = {};
			for i, datagram in ipairs(Telepathy.partialMessages) do
				if (datagram.id == id and datagram.method == method and datagram.sender == sender and datagram.sequenceCount == sequenceCount and datagram.objectID == objectID) then
					table.insert(messageTable, datagram.sequenceNumber, datagram);
				end
			end
			
			local size = getn(messageTable);
			if (size == sequenceCount) then
				-- Have Complete Message
				message = "";
				for i, datagram in messageTable do
					message = message..datagram.message;
				end
				
				local datagram, incomplete;
				for i=size, 1, -1 do
					datagram = Telepathy.partialMessages[i];
					if (not datagram) then
						-- Incomplete message, never recieved this datagram
						incomplete = true;
					elseif (datagram.id == id and datagram.method == method and datagram.sender == sender and datagram.sequenceCount == sequenceCount and datagram.objectID == objectID) then
						table.remove(Telepathy.partialMessages, i);
					end
				end
				
				if (incomplete) then
					return;
				end
				
				if (Sea.string.startsWith(message, Telepathy.OBJECT_TAG)) then
					message = Sea.string.stringToObject(strsub(message, strlen(Telepathy.OBJECT_TAG)+1));
				end
				listener.callback(message, sender, method, objectID);
			else
				if (listener.partialCallback) then
					listener.partialCallback(sender, method, sequenceNumber, sequenceCount, getn(messageTable), objectID);
				end
			end
		end
	end
	
	
	--[[
	--	parseChannelList ( message, channel )
	--		Parses a message string to check the list of active users in the channel
	--]]
	function Telepathy.parseChannelList( msg, userList )
		if( type(userList) ~= "table" ) then
			return;
		end
		
		local users = Sea.string.split(msg, ",");
		-- Strip out * and spaces
		for k,v in ipairs(users) do
			k2 = string.gsub(v, "%s*%*?%@?%#?(.+)", "%1");
			userList[k2] = true;
		end
	end
		
	------------------------------------------------------------------------------
	--[[ Telepathy Initialization ]]--
	------------------------------------------------------------------------------
	
	--[[
	-- 	enable()
	--		Turns Telepathy on
	--]]
	function Telepathy.enable()
		if ( not Telepathy.online ) then
			Telepathy.InitLoaded = true;
			if (ChronosData.initialized) then
				Telepathy.updateGlobalChannel();
			else
				Chronos.afterInit(Telepathy.updateGlobalChannel);
			end
			
			Sea.io.derror(Telepathy.Debug.MESSAGES, "Telepathy On");
			Telepathy.online = true;
	
			Sea.util.hook("ChatFrame_OnEvent", "Telepathy.ChatFrame_OnEvent_hook", "replace");
			Sea.util.hook("SlashCmdList.JOIN", "Telepathy.joinParser", "replace");
			Sea.util.hook("SlashCmdList.LEAVE", "Telepathy.leaveParser", "before");
			
			Sea.util.hook("FCFDropDown_LoadChannels", "Telepathy.FCFDropDown_LoadChannels_hook", "replace");
		end
	end
	
	--[[
	--	disable()
	--		Turns Telepathy off
	--]]
	function Telepathy.disable()
		if ( Telepathy.online ) then
			Sea.io.derror(Telepathy.Debug.MESSAGES, "Telepathy Off");
			Telepathy.online = false;
	
			Sea.util.unhook("ChatFrame_OnEvent", "Telepathy.ChatFrame_OnEvent_hook", "replace");
			Sea.util.unhook("SlashCmdList.JOIN", "Telepathy.joinParser", "replace");
			Sea.util.unhook("SlashCmdList.LEAVE", "Telepathy.leaveParser", "before");
			
			Sea.util.unhook("FCFDropDown_LoadChannels", "Telepathy.FCFDropDown_LoadChannels_hook", "replace");
		end
	end
	
	------------------------------------------------------------------------------
	--[[ Channel Slash Command Hooks ]]--
	------------------------------------------------------------------------------
	
	-- Join parser "/join msg"
	function Telepathy.joinParser(msg)
		local name = gsub(msg, "%s*([^%s]+).*", "%1");
		if (name == Telepathy.GLOBAL_CHANNEL or name == strlower(Telepathy.GLOBAL_CHANNEL)) then
			JoinChannelByName(Telepathy.GLOBAL_CHANNEL);
			return;
		else
			return true;
		end
	end
	
	-- Leave parser "/leave msg"
	function Telepathy.leaveParser(msg)
		local name = gsub(msg, "%s*([^%s]+).*", "%1");
		if ( channel == Telepathy.GLOBAL_CHANNEL ) then
			Sea.io.printfc(chatFrame,  ChatTypeInfo["SYSTEM"], TELEPATHY_LEAVE_WARNING );
		end
	end
	
	------------------------------------------------------------------------------
	--[[ Other Hooks ]]--
	------------------------------------------------------------------------------
	
	--[[
	--	ChatFrame_OnEvent_hook(event)
	--		Hides messages as needed.
	--
	--		For CHAT_MSG types:
	--			arg1 - message
	--			arg2 - player
	--			arg3 - language (or nil)
	--			arg4 - fancy channel name (5. General - Stormwind City)
	--				   *Zone is always current zone even if not the same as the channel name
	--			arg5 - Second player name when two users are passed for a CHANNEL_NOTICE_USER (E.G. x kicked y)
	--			arg6 - AFK/DND "CHAT_FLAG_"..arg6 flags
	--			arg7 - zone ID
	--				1 (2^0) - General
	--				2 (2^1) - Trade
	--				2097152 (2^21) - LocalDefense
	--				8388608 (2^23) - LookingForGroup
	--				(these numbers are added bitwise)
	--			arg8 - channel number (5)
	--			arg9 - Full channel name (General - Stormwind City)
	--				   *Not from GetChannelList
	--]]
	function Telepathy.ChatFrame_OnEvent_hook(event)
		if (Telepathy.Debug.CHAT) then
			return true;
		end
		
		local blocked = false;
		
		-- Optional hiding of individual channel user lists
		if (event == "CHAT_MSG_CHANNEL_LIST") then
			if (arg8 ~= 0) then	-- channel number indicates user list
				if (arg9 == "GlobalComm") then
					blocked = true;
				end
			end
		elseif (event == "CHAT_MSG_CHANNEL_NOTICE") then
			if (arg9 == "GlobalComm") then
				blocked = true;
			end
		elseif (Sea.string.startsWith(event, "CHAT_MSG_CHANNEL")) then
			-- Hide all GlobalComm messages
			if (arg9 == "GlobalComm") then
				blocked = true;
			end

		elseif (event == "CHAT_MSG_WHISPER" or event == "CHAT_MSG_WHISPER_INFORM") then
			-- Hide Telepathy whispers
			if (Sea.string.startsWith(arg1, Telepathy.WHISPER_TAG)) then
				blocked = true;
			end
		end
		
		return (not blocked);
	end
	
	--[[
	--	FCFDropDown_LoadChannels_hook()
	--		Hides the GlobalComm channel in the channel filter menu
	--]]
	function Telepathy.FCFDropDown_LoadChannels_hook(...)
		local checked;
		local channelList = FCF_GetCurrentChatFrame().channelList;
		local zoneChannelList = FCF_GetCurrentChatFrame().zoneChannelList;
		local channelIndex;
		local channelName;
		for i=1, arg.n, 2 do
			channelIndex = arg[i]
			channelName = arg[i+1];
			if (not channelName) then
				break;
			end
			if  (channelName ~= Telepathy.GLOBAL_CHANNEL) then
	
				checked = nil;
				if ( channelList ) then
					for index, value in channelList do
						if ( value == channelName ) then
							checked = 1;
						end
					end
				end
				if ( zoneChannelList ) then
					for index, value in zoneChannelList do
						if ( value == channelName ) then
							checked = 1;
						end
					end
				end
				local info = {};
				info.text = channelName;
				info.value = "CHANNEL"..channelIndex;
				info.func = FCFChannelDropDown_OnClick;
				info.checked = checked;
				info.keepShownOnClick = 1;
				-- Color the chat channel
				local color = ChatTypeInfo[info.value];
				info.hasColorSwatch = 1;
				info.r = color.r;
				info.g = color.g;
				info.b = color.b;
				-- Set the function the color picker calls
				info.swatchFunc = FCF_SetChatTypeColor;
				info.cancelFunc = FCF_CancelFontColorSettings;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
			end
		end
	end
	
	
	------------------------------------------------------------------------------
	--[[ Tester Mode: Example Use ]]--
	------------------------------------------------------------------------------
	
	--[[
	--	TesterMode()
	--		Enables tester mode and some simple slash commands for confirming basic functionality.
	--]]
	function Telepathy.TesterMode()
		-- Register the Test function
		Satellite.registerSlashCommand(
			{
				id="TelepathyTest1";
				commands = {"/teletest1"};
				onExecute=function() Telepathy.sendMessage("TelepathyTester1", "Global Test Complete", "GLOBAL") end;
			},
			{
				id="TelepathyTest2";
				commands = {"/teletest2"};
				onExecute=function() Telepathy.sendMessage("TelepathyTester2", "Whisper Test Complete", "WHISPER", UnitName('player')) end;
			},
			{
				id="TelepathyTest3";
				commands = {"/teletest3"};
				onExecute=function() Telepathy.sendMessage("TelepathyTester3", "Whisper Test Complete", "PARTY") end;
			},
			{
				id="TelepathyTest4";
				commands = {"/teletest4"};
				onExecute=function() Telepathy.sendMessage("TelepathyTester4", "Whisper Test Complete", "RAID") end;
			},
			{
				id="TelepathyTest5";
				commands = {"/teletest5"};
				onExecute=function() Telepathy.sendMessage("TelepathyTester5", "Whisper Test Complete", "BATTLEGROUND") end;
			},
			{
				id="TelepathyTest6";
				commands = {"/teletest6"};
				onExecute=function() 
					local name = UnitName('player');
					Telepathy.sendMessage("TelepathyTester2", "ALERT Test Complete #1", "WHISPER", name, "ALERT");
					Telepathy.sendMessage("TelepathyTester2", "NORMAL Test Complete #2", "WHISPER", name, "NORMAL");
					Telepathy.sendMessage("TelepathyTester2", "BULK Test Complete #3", "WHISPER", name, "BULK");
					Telepathy.sendMessage("TelepathyTester2", "ALERT Test Complete #4", "WHISPER", name, "ALERT");
					Telepathy.sendMessage("TelepathyTester2", "NORMAL Test Complete #5", "WHISPER", name, "NORMAL");
					Telepathy.sendMessage("TelepathyTester2", "BULK Test Complete #6", "WHISPER", name, "BULK");
				end;
			},
			{
				id="TelepathyTest7";
				commands = {"/teletest7"};
				onExecute=function() 
					local name = UnitName('player');
					Telepathy.sendMessage("TelepathyTester2",
						"This is a really long message meant to test the datagram packetization of Telepathy to make sure that messages over 254 characters are correctly split and reassembled.\nIn the case that it does not reassemble correctly and things explode, be sure to call the doctor and get some asprin, because it is garenteed to be a pain in the ass to fix.",
						"WHISPER", name, "BULK"
					);
				end;
			},
			{
				id="TelepathyTest8";
				commands = {"/teletest8"};
				onExecute=function() 
					local name = UnitName('player');
					for i=1, 20 do
						Telepathy.sendMessage("TelepathyTester2", "Spam Test Complete #"..i, "WHISPER", name, "NORMAL");
					end
				end;
			}
		);

		-- Register a test program
		Telepathy.registerListener("TelepathyTester1", "GLOBAL",
			function(msg, sender) Sea.io.printComma("TelepathyTester1: ", msg, sender) end
		);
		Telepathy.registerListener("TelepathyTester2", "WHISPER",
			function(msg, sender) Sea.io.printComma("TelepathyTester2: ", msg, sender) end
		);
		Telepathy.registerListener("TelepathyTester3", "PARTY",
			function(msg, sender) Sea.io.printComma("TelepathyTester3: ", msg, sender) end
		);
		Telepathy.registerListener("TelepathyTester4", "RAID",
			function(msg, sender) Sea.io.printComma("TelepathyTester4: ", msg, sender) end
		);
		Telepathy.registerListener("TelepathyTester5", "BATTLEGROUND",
			function(msg, sender) Sea.io.printComma("TelepathyTester5: ", msg, sender) end
		);
	end
	
	
	------------------------------------------------------------------------------
	--[[ Frame Scripts ]]--
	------------------------------------------------------------------------------
	
	function Telepathy.OnLoad()
	
		this:RegisterEvent("ADDON_LOADED");
		this:RegisterEvent("VARIABLES_LOADED");
		this:RegisterEvent("CHAT_MSG_CHANNEL_LIST");
		this:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE");
		this:RegisterEvent("CHAT_MSG_CHANNEL_JOIN");
		this:RegisterEvent("CHAT_MSG_CHANNEL_LEAVE");
		this:RegisterEvent("CHAT_MSG_CHANNEL");
		this:RegisterEvent("CHAT_MSG_WHISPER");
		this:RegisterEvent("CHAT_MSG_ADDON");
	
		-- Start Telepathy
		Telepathy.enable();
		
		-- Register the AutoJoin Command
		Satellite.registerSlashCommand(
			{
				id="TelepathyAutoJoin";
				commands = TELEPATHY_AUTOJOIN_COMMANDS;
				onExecute = function(msg)
					if (msg == "1") then
						Telepathy.enableGlobalChannelAutoJoin();
					elseif (msg == "0") then
						Telepathy.disableGlobalChannelAutoJoin();
					else
						Sea.io.print(TELEPATHY_AUTOJOIN_COMMANDS[1].." - "..TELEPATHY_AUTOJOIN_HELP);
					end
				end;
				helpText = TELEPATHY_AUTOJOIN_HELP;
				replace = true;
			}
		);
	
		if ( Telepathy.Debug.TESTER_MODE ) then
			Telepathy.TesterMode();
		end
	
	end
	
	
	--[[
	--	Telepathy.OnEvent()
	--		processes our events.
	--		arg1, arg2, ... arg9 are all global values
	--
	--		For CHAT_MSG types:
	--			arg1 - message
	--			arg2 - player
	--			arg3 - language (or nil)
	--			arg4 - fancy channel name (5. General - Stormwind City)
	--				   *Zone is always current zone even if not the same as the channel name
	--			arg5 - Second player name when two users are passed for a CHANNEL_NOTICE_USER (E.G. x kicked y)
	--			arg6 - AFK/DND "CHAT_FLAG_"..arg6 flags
	--			arg7 - zone ID
	--				1 (2^0) - General
	--				2 (2^1) - Trade
	--				2097152 (2^21) - LocalDefense
	--				8388608 (2^23) - LookingForGroup
	--				(these numbers are added bitwise)
	--			arg8 - channel number (5)
	--			arg9 - Full channel name (General - Stormwind City)
	--				   *Not from GetChannelList
	--]]
	function Telepathy.OnEvent()
	
		if (not Telepathy.online) then
			return;
		end
	
		if ( Telepathy.Debug.EVENTS ) then
			Sea.io.printComma(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
		end
	
		if (event == "VARIABLES_LOADED") or (event == "ADDON_LOADED" and arg1 == "Telepathy") then
			if (arg1 == "Telepathy") then
				--Default Config Variables
				if (not Telepathy_Config) then
					Telepathy_Config = {};
					Telepathy_Config.AllowAutoJoin = true;
				end
			end
	
		elseif ( event == "CHAT_MSG_CHANNEL_LIST" ) then
			-- Channel list printing
			if ( arg8 == 0 ) then
				return;
			else
				-- channel number indicates user list
				if (arg9 == Telepathy.GLOBAL_CHANNEL) then
					-- Parse the list
					if (not Telepathy.GlobalCommMemberList) then
						Telepathy.GlobalCommMemberList = {};
					end
					Telepathy.parseChannelList( arg1, Telepathy.GlobalCommMemberList );
				end
			end
	
		elseif ( event == "CHAT_MSG_CHANNEL_NOTICE" ) then
			-- YOU_JOINED, YOU_LEFT or YOU_CHANGED
			if (arg9 == Telepathy.GLOBAL_CHANNEL) then
				if ( arg1 == "YOU_JOINED" ) then
					-- If we are joining the channel then we should reset the user list as we don't know if the old stuff is valid
					Telepathy.GlobalCommMemberList = {};
					Telepathy.GlobalCommMemberList[UnitName("player")] = true;
					ListChannelByName(arg9);	--Request new user list for this channel, hidden
					Telepathy.updateGlobalChannel(true);
				elseif ( arg1 == "YOU_LEFT" ) then
					Telepathy.GlobalCommMemberList = {};
					Telepathy.updateGlobalChannel(true);
				end
			end
	
		elseif ( event == "CHAT_MSG_CHANNEL_JOIN" ) then
			if (arg9 == Telepathy.GLOBAL_CHANNEL) then
				Telepathy.GlobalCommMemberList[arg2] = true;
			end

		elseif ( event == "CHAT_MSG_CHANNEL_LEAVE" ) then
			if (arg9 == Telepathy.GLOBAL_CHANNEL) then
				Telepathy.GlobalCommMemberList[arg2] = nil;
			end
	
		elseif ( event == "CHAT_MSG_CHANNEL" ) then
			if (arg9 == Telepathy.GLOBAL_CHANNEL) then
				local id, objCount, sequenceNumber, sequenceCount, message = Telepathy.unwrapDatagram(nil, arg1, "GLOBAL");
				Telepathy.scanMessage(id, "GLOBAL", message, arg2, sequenceNumber, sequenceCount, objCount);
			end
		
		elseif ( event == "CHAT_MSG_WHISPER" ) then
			if ( Sea.string.startsWith(arg1, Telepathy.WHISPER_TAG) ) then
				local id, objCount, sequenceNumber, sequenceCount, message = Telepathy.unwrapDatagram(nil, arg1, "WHISPER");
				Telepathy.scanMessage(id, "WHISPER", message, arg2, sequenceNumber, sequenceCount, objCount);
			end
		
		elseif ( event == "CHAT_MSG_ADDON" ) then
			--[[
			arg1 - id
			arg2 - message
			arg3 - "PARTY","RAID", "GUILD" or "BATTLEGROUND"
			arg4 - sender 
			]]--
			Sea.io.dprint(Telepathy.Debug.CHAT, GREEN_FONT_COLOR_CODE,"[",arg3,"][",arg4,"]<",arg1,">: ",arg2,"|r");
			local id, objCount, sequenceNumber, sequenceCount, message = Telepathy.unwrapDatagram(arg1, arg2, arg3);
			Telepathy.scanMessage(id, arg3, message, arg4, sequenceNumber, sequenceCount, objCount);

		end
	
	end
	
	
	------------------------------------------------------------------------------
	--[[ Frame Script Assignment ]]--
	------------------------------------------------------------------------------
	
	--Event Driver
	if (not TelepathyFrame) then
		CreateFrame("Frame", "TelepathyFrame");
	end
	TelepathyFrame:Hide();
	--Frame Scripts
	TelepathyFrame:SetScript("OnEvent", Telepathy.OnEvent);
	--OnLoad Call (this masked)
	local tempThis = this;
	this = TelepathyFrame;
	Telepathy.OnLoad();
	this = tempThis;
	

end

