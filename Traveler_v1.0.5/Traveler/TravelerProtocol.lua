--------------------------------------------------------------------------------
-- 
-- Name: TravelerProtocol.lua
-- Author: Malex-Cenarius
-- Date: 11/21/2006
--
--------------------------------------------------------------------------------





-- Protocol

-- "TP:0:S:"
-- "ProtocolName:Version:MessageType:[MessageDependent]"

-- MessageTypes
-- S = Start Advertisement
-- K = Kill Advertisement
-- R - Request Summon
-- B - Banned message
-- C - Cancel Summon Request

-- Start Advertisement Message
-- "TP:1:S:1:1:1:34,57:1:1:M:W:5000:bla bla bla"
-- "ProtocolName:Version:MessageType:ContinentIndex:Zone:Coords:SubZone:RaceIndex:Gender:Class:CostInCopper:Notes"

-- Kill Advertisement Message
-- "TP:1:K"
-- "ProtocolName:Version:MessageType"

-- Request Summon Message
-- "TP:1:R:1:34,55:1:M"
-- "ProtocolName:Version:MessageType:Zone:Coords:RaceIndex:Gender"

-- Banned Message
-- "TP:1:B"
-- "ProtocolName:Version:MessageType"

-- Cancel Summon Request
-- "TP:1:C"
-- "ProtocolName:Version:MessageType"



--------------------------------------------------------------------------------
--
-- Method: Traveler_Broadcast
-- Description: This method sends a message over the global channel advertising
--	the player's current state.
-- Notes: When the player's state changes, this method should be called, including
--	updates to the cost, notes, location, shard/stone count, etc.
--
--------------------------------------------------------------------------------
function Traveler_Broadcast()

	-- Only allow broadcasting if we are a warlock, have 3 people in the party
	-- and have broadcasting enabled
	--
	if(Traveler_IsMage() or max(GetNumPartyMembers(), GetNumRaidMembers()) >= 2) then
	
		if(TravelerBroadcastEnabled) then

			TravelerLastBroadcastTime = time();

			Traveler_SendAdvertisement();
		
		end
		
	end
		

end

--------------------------------------------------------------------------------
--
-- Method: Traveler_RequestSummon
-- Description: This method is called when the player is requesting a summon 
--	from a warlock.
--
--------------------------------------------------------------------------------
function Traveler_RequestSummon()

	if(TravelerDestinationId ~= 0) then

		local suppliersFiltered = Traveler_Destination_Filter(TravelerSuppliers);	
		local warlock = Traveler_GetValueByIndex(suppliersFiltered, TravelerDestinationId);
		if(warlock) then
		
			local locX, locY = GetPlayerMapPosition("player");
			locX = floor( locX * 100.0 );
			locY = floor( locY * 100.0 );

			local coords = "-,-";
			if(locX ~= 0 and locY ~= 0) then
				coords = locX .. "," .. locY;
			end

			
			local race, raceEn = UnitRace("player");		
			local raceIndex = TravelerRaces[raceEn];
			
			local gender = "M";
			if(UnitSex("player") == 3) then
				gender = "F";
			end
			
			-- Assemble the advertisment message
			--
			local message = string.format("TP:%d:%s:%s:%s:%d:%s", TravelerVersion, "R", GetRealZoneText(), coords, raceIndex, gender);
		
			SendChatMessage(message, "WHISPER", nil, warlock.Name);
		end
	
	end

end

--------------------------------------------------------------------------------
--
-- Method: Traveler_UnRequestSummon
-- Description: This method is called when the player wants to cancel a summon
--	request
--
--------------------------------------------------------------------------------
function Traveler_UnRequestSummon(recipient)

	if(TravelerDestinationId ~= 0) then
	
		local suppliersFiltered = Traveler_Destination_Filter(TravelerSuppliers);	
		local warlock = Traveler_GetValueByIndex(suppliersFiltered, TravelerDestinationId);
		if(warlock) then
		
			local message = string.format("TP:%d:%s", TravelerVersion, "C");
			SendChatMessage(message, "WHISPER", nil, warlock.Name);
		
		end
	
	end

end


--------------------------------------------------------------------------------
--
-- Method: Traveler_SendAdvertisement
-- Description: This method assembles and sends an advertisement message for
--	the player to the global channel.  The message describes the current position
--	of the player, cost, notes, etc.
--
--------------------------------------------------------------------------------
function Traveler_SendAdvertisement()

	-- Make sure we have joined the proper channel
	--
	local id = GetChannelName(TravelerChannel);
	if(id) then
	

		local locX, locY = GetPlayerMapPosition("player");
		locX = floor( locX * 100.0 );
		locY = floor( locY * 100.0 );

		local coords = "-,-";
		if(locX ~= 0 and locY ~= 0) then
			coords = locX .. "," .. locY;
		else
			-- If there is no coords, it means we're in an instance, so
			-- don't broadcast
			--
			return;
		end

		
		local race, raceEn = UnitRace("player");
		local raceIndex = TravelerRaces[raceEn];
		
		local gender = "M";
		if(UnitSex("player") == 3) then
			gender = "F";
		end
		
		local class = "W";
		if(Traveler_IsMage()) then
			class = "M";
		end
		
		local subZone = Traveler_GetSubZone();
		
		local zone = GetRealZoneText();
		if(TravelerAdInstanceId > 1) then
			zone = UIDropDownMenu_GetText(TravelerFrame_FrameAdvertise_DropDownInstance);
		end

		-- Assemble the advertisment message
		--
		local message = string.format("TP:%d:%s:%d:%s:%s:%s:%d:%s:%s:%d:%s", TravelerVersion, "S", GetCurrentMapContinent(), zone, coords, subZone, raceIndex, gender, class, TravelerOptions.CostInCopper, TravelerNotes);

		SendChatMessage(message, "CHANNEL", nil, id);
	
	end

end

--------------------------------------------------------------------------------
--
-- Method: Traveler_SendKill
-- Description: This method is called when the player wants to stop advertising,
--	runs out of shards/stones, or is otherwise unable to provide traveler 
--	services.  It sends a message to the global channel that the user is no longer
--	available.
--
--------------------------------------------------------------------------------
function Traveler_SendKill()

	-- Make sure we have joined the proper channel
	--
	local id = GetChannelName(TravelerChannel);
	if(id) then

		-- Assemble the advertisment message
		--
		local message = string.format("TP:%d:%s", TravelerVersion, "K");

		SendChatMessage(message, "CHANNEL", nil, id);
	
	end


end

--------------------------------------------------------------------------------
--
-- Method: Traveler_SendBanned
-- Description: This method is called when the player receives a summon/port 
--	request from someone on their banned list.  It sends a message back to the 
--	banned player letting them know that they have been banned.
--
--------------------------------------------------------------------------------
function Traveler_SendBanned(recipient)

	-- Assemble the advertisment message
	--
	local message = string.format("TP:%d:%s", TravelerVersion, "B");

	SendChatMessage(message, "WHISPER", nil, recipient);
	
end




--------------------------------------------------------------------------------
--
-- Method: Traveler_ParseMessage
-- Description: This method is called when an incoming message is received on
--	the global channel.  It parses the protocol and version, passing the remaining
--	message along to the next protocol layer.
-- Arguments:
--	sender - [in] The author of the remote message
--  msg - [in] The message text
-- Returns: True if the message was handled, false otherwise
-- Notes: It is at this layer that banned users are filtered
--
--------------------------------------------------------------------------------
function Traveler_ParseMessage(sender, msg)
	
	local startIndex, endIndex, protocolName, version = string.find(msg, "(%u%u):(%d+)");
	
	if(startIndex) then
		if(protocolName == "TP") then
			if(tonumber(version) <= TravelerVersion) then
						
				if(tonumber(version) == 1) then	
					Traveler_ParseMessage_V1(sender, string.sub(msg, endIndex + 2, -1));					
				end
			else
			
				-- A higher version message has been detected.  Let the user know that
				-- there is an updated version available.
				--
				TravelerFrame_FrameVersion_TextVersion:SetTextColor(1.0, 0.0, 0.0);		
				TravelerProtocolUpdateDetected = true;		
						
			end
			
			return true;
		end		
	end
	
	return false;		
		
end

--------------------------------------------------------------------------------
--
-- Method: Traveler_ParseMessage_V1
-- Description: Handles incoming messages from the global channel for a particular
--	protocol version.
-- Arguments:
--	sender - [in] The author of the message
--	msg - [in] The message text
--
--------------------------------------------------------------------------------
function Traveler_ParseMessage_V1(sender, msg)
	
	
	-- Extract the messageType
	--
	local startIndex, endIndex, messageType = string.find(msg, "(%u)");
	
	if(startIndex) then
	
		-- Strip the messageType from the msg
		--
		msg = string.sub(msg, endIndex + 2, -1);
		
		local continentIndex, zone, coords, subZoneIndex, race, gender, costInCopper, notes;
	
		-- Handle new advertisement
		--
		if(messageType == "S") then
		
			-- Check the ban list
			--
			if(TravelerBanList[sender] ~= nil) then			
				return;
			end				
		
			startIndex, endIndex, continentIndex, zone, coords, subZone, raceIndex, gender, class, costInCopper, notes = string.find(msg, "(%d):([%w%s%p]*):([%d-]+,[%d-]+):([%w%s%p]*):(%d):(%u):(%u):(%d+):([%w%s%p]*)");			
			if(startIndex) then
				
				Traveler_OnAdvertisement(sender, continentIndex, zone, coords, subZone, raceIndex, gender, class, costInCopper, notes);
				
			end
		-- Handle a Stop Advertisement
		--			
		elseif(messageType == "K") then
		
			Traveler_OnKill(sender);
			
		-- Handle a Request Summon
		--
		elseif(messageType == "R") then				
			
			-- Check the ban list
			--
			if(TravelerBanList[sender] ~= nil) then
			
				-- Send a banned message to the sender
				--
				Traveler_SendBanned(sender);
				return;
			end			
			
			startIndex, endIndex, zone, coords, raceIndex, gender = string.find(msg, "([%w%s%p]*):([%d-]+,[%d-]+):(%d):(%u)");			
			if(startIndex) then
							
				Traveler_OnRequestSummon(sender, zone, coords, raceIndex, gender);
				
			end
		
		-- Handle a banned message
		--
		elseif(messageType == "B") then
		
			Traveler_OnBanned(sender);					
		
		-- Handle a cancel request message
		--
		elseif(messageType == "C") then
		
			Traveler_OnCancelRequest(sender);
		
		end
	end		
	
end


--------------------------------------------------------------------------------
--
-- Method: Traveler_OnAdvertisement
-- Description: Handles incoming advertisments from remote warlocks/mages
-- Arguments:
--  sender - [in] The remote author of the message
--	continentIndex - [in] A 1-based continent index that the remote warlock/mage
--		is located at.
--	zone - [in] The text name of the zone in which the remote warlock/mage is located
--	coords - [in] The coordinates of the remote warlock/mage
--	subZone - [in] The text name of the sub zone of the remote warlock/mage
--	raceIndex - [in] The race index of the remote warlock/mage's race from the global
--		TravelerRaces array.
--	gender - [in] M/F text value representing the gender of the remote mage/warlock
--  class - [in] W/M the class of the supplier
--	costInCopper - [in] The cost the remote mage/warlock is charging
--	notes - [in] Any notes provided by the remote mage/warlock
--
--------------------------------------------------------------------------------
function Traveler_OnAdvertisement(sender, continentIndex, zone, coords, subZone, raceIndex, gender, class, costInCopper, notes)

	-- Create an entry in the warlock table for the sender if it doesn't exist
	--
	if(TravelerSuppliers[sender] == nil) then
	
		TravelerSuppliers[sender] = {};	
		TravelerSuppliers[sender].RequestSent = false;	
		TravelerSuppliers.Size = TravelerSuppliers.Size + 1;	
					
	end
	
	-- Set the data for the sender
	--
	TravelerSuppliers[sender].Name = sender;
	TravelerSuppliers[sender].ContinentIndex = continentIndex;
	TravelerSuppliers[sender].Zone = zone;
	TravelerSuppliers[sender].Coords = coords;
	TravelerSuppliers[sender].SubZone = subZone;
	TravelerSuppliers[sender].RaceIndex = raceIndex;
	TravelerSuppliers[sender].Gender = gender;
	TravelerSuppliers[sender].Class = class;
	TravelerSuppliers[sender].CostInCopper = costInCopper;
	TravelerSuppliers[sender].Notes = notes;	
	TravelerSuppliers[sender].LastPing = time();

end

--------------------------------------------------------------------------------
--
-- Method: Traveler_OnKill
-- Description: Handles incoming kill messages from remote mages/warlocks
-- Arguments:
--	sender - [in] The author of the kill message
--
--------------------------------------------------------------------------------
function Traveler_OnKill(sender)

	-- Remove the sender from the warlock table if he exists
	--
	if(TravelerSuppliers[sender] ~= nil) then
	
		TravelerSuppliers[sender] = nil;
		TravelerSuppliers.Size = TravelerSuppliers.Size - 1;
		
	end

end

--------------------------------------------------------------------------------
--
-- Method: Traveler_OnCancelRequest
-- Description: Handles incoming cancel request messages
-- Arguments:
--	sender - [in] The author of the cancel message
--
--------------------------------------------------------------------------------
function Traveler_OnCancelRequest(sender)

	-- Remove the sender from the customer table if it exists
	--
	if(TravelerCustomers[sender] ~= nil) then
	
		TravelerCustomers[sender] = nil;
		TravelerCustomers.Size = TravelerCustomers.Size - 1;
		
	end

end

--------------------------------------------------------------------------------
--
-- Method: Traveler_OnBanned
-- Description: Handles incoming banned messages from remote mages/warlocks
-- Arguments:
--	sender - [in] The author of the banned message
--
--------------------------------------------------------------------------------
function Traveler_OnBanned(sender)

	-- Make sure the banned message is from a supplier that has been sent
	-- a request
	--
	if(TravelerSuppliers[sender] ~= nil) then
	
		if(TravelerSuppliers[sender].RequestSent) then
		
			-- Reset the request sent flag
			--
			TravelerSuppliers[sender].RequestSent = false;
		
			-- Show a popup letting the user know they have been banned
			--
			message("You have been banned by " .. sender);			
		
		end
		
	end

end

--------------------------------------------------------------------------------
--
-- Method: Traveler_OnRequestSummon
-- Description: Handles incoming summon requests
-- Arguments:
--	sender - [in] The remote author of the message
--	zone - [in] The text name of the zone in which the remote customer is located
--	coords - [in] The coordinates of the remote customer
--	raceIndex - [in] The race index of the remote customer's race from the global
--		Races array.
--	gender - [in] M/F text value representing the gender of the remote customer
--
--------------------------------------------------------------------------------
function Traveler_OnRequestSummon(sender, zone, coords, raceIndex, gender)

	-- Make sure we have enabled
	--
	if(TravelerBroadcastEnabled == false) then
		return;
	end

	-- Create an entry in the TravelerCustomers table for the sender if it doesn't exist
	--
	if(TravelerCustomers[sender] == nil) then
	
		TravelerCustomers[sender] = {};
		TravelerCustomers.Size = TravelerCustomers.Size + 1;
	
	end
	
	-- Set the data for the sender
	--
	TravelerCustomers[sender].Name = sender;
	TravelerCustomers[sender].Zone = zone;
	TravelerCustomers[sender].Coords = coords;
	TravelerCustomers[sender].RaceIndex = raceIndex;
	TravelerCustomers[sender].Gender = gender;
	TravelerCustomers[sender].LastPing = time();	
	
	-- Play a sound if this is the first request
	--
	PlaySoundFile("Interface\\Addons\\Traveler\\firstqueue.wav");

end

--------------------------------------------------------------------------------
--
-- Method: Traveler_OnRandomPortalRequest
-- Description: Handles incoming portal requests from random people
-- Arguments:
--	sender - [in] The remote author of the message
--	message - [in] The text of the incoming whisper
-- Returns: True if the message was handled and should not be passed to the
--	normal message system, false otherwise
--
--------------------------------------------------------------------------------
function Traveler_OnRandomPortalRequest(sender, message) 

	-- If you are a mage
	--
	if(Traveler_IsMage()) then

		-- Make sure the sender isn't someone already in your group
		--
		if(Traveler_IsUserInPartyOrRaid(sender) == false) then
		
			-- If you are accepting requests, then send them your current price
			-- and directions.
			--
			if(TravelerBroadcastEnabled) then
		
				Traveler_SendPortalPrice(sender);
		
			-- Otherwise let them know you are not accepting portal requests at this time
			--
			else
			
				Traveler_SendDenyPortal(sender);
		
			end
			
		end

	end
	
	return false;

end

--------------------------------------------------------------------------------
--
-- Method: Traveler_SendPortalPrice
-- Description: Sends a message to a random portal requestor that isn't using
--	Traveler what the current price is for a portal with directions.
-- Arguments:
--	recipient - [in] The recipient of the message
--
--------------------------------------------------------------------------------
function Traveler_SendPortalPrice(recipient)

	local gold = floor(TravelerOptions.CostInCopper / 10000);
	local silver = floor((TravelerOptions.CostInCopper - (gold * 10000)) / 100);
	local copper = mod(TravelerOptions.CostInCopper, 100);

	-- Put together a string representing the current cost for services
	--
	local cost = ""
	if(gold > 0) then
		cost = gold .. "g";
	end
	
	if(silver > 0) then
		cost = cost .. " " .. silver .. "s";
	end
	
	if(copper > 0) then
		cost = cost .. " " .. copper .. "c";
	end

	local message = "Welcome to " .. UnitName("player") .. "'s travel service.  The service fee is: " .. cost .. ".  The fee must be paid before services are delivered.";

	SendChatMessage(message, "WHISPER", nil, recipient);

end

--------------------------------------------------------------------------------
--
-- Method: Traveler_SendDenyPortal
-- Description: Sends a message to a random portal requestor that isn't using
--	Traveler that you are not currently accepting portal requests.
-- Arguments:
--	recipient - [in] The recipient of the message
--
--------------------------------------------------------------------------------
function Traveler_SendDenyPortal(recipient)

	local message = UnitName("player") .. TravelerRandomPortResponse;

	SendChatMessage(message, "WHISPER", nil, recipient);

end


--------------------------------------------------------------------------------
--
-- Method: Traveler_VersionTextTooltipConditional
-- Description: Determines if the version tooltip should be displayed
--
--------------------------------------------------------------------------------
function Traveler_VersionTextTooltipConditional()
	
	if(TravelerProtocolUpdateDetected) then
		return true;
	else
		return false;
	end
	
end

--------------------------------------------------------------------------------
--
-- Method: Traveler_ThrottleSendRate
-- Description: Called once per second to update the send rate
--
--------------------------------------------------------------------------------
function Traveler_ThrottleSendRate()

	-- Add the messages per second for the last second to the running average
	--
	if(TravelerChannelRunningAverage[TravelerChannelRunningAverageNextIndex] ~= nil) then
		TravelerChannelRunningAverageTotal = TravelerChannelRunningAverageTotal - TravelerChannelRunningAverage[TravelerChannelRunningAverageNextIndex];
	end
		
	TravelerChannelRunningAverage[TravelerChannelRunningAverageNextIndex] = TravelerChannelMessagesThisSecond;
	TravelerChannelRunningAverageTotal = TravelerChannelRunningAverageTotal + TravelerChannelRunningAverage[TravelerChannelRunningAverageNextIndex];		
	
	-- Update the next index
	--
	TravelerChannelRunningAverageNextIndex = mod(TravelerChannelRunningAverageNextIndex + 1, TravelerChannelRunningAverageSamples);	
	
	-- Reset the per-second accumulator
	--
	TravelerChannelMessagesThisSecond = 0;

	local averageDataRate = TravelerChannelRunningAverageTotal / TravelerChannelRunningAverageSamples;
	
	-- Throttle the send rate based on the current running average
	--
	if(averageDataRate > TravelerChannelMessagePeak) then
	
		-- Reduce the send rate
		--
		TravelerBroadcastFrequency = min(TravelerBroadcastFrequency + 1, TravelerDestinationExpiration);
	
	else
	
		-- Increase the send rate
		--
		TravelerBroadcastFrequency = max(TravelerBroadcastFrequency - 1, 10);
	
	end

end
