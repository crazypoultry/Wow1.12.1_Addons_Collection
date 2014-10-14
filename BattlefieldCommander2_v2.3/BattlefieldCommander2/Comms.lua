-- Comms.lua
-- This file handles the sending and receiving of mod-to-mod communications.
-- 
-- Each message is associated with a unique *component* and *command*.
-- Anything that needs to receive a message registers a unique component-command combination, along
-- with a function callback. When a message is received matching that component and command, the
-- message is split into an array (semicolon-delimited) and passed as an argument to the callback,
-- along with the name of the sender.
--
-- NOTE 1: Component and command names may NOT contain semicolons. Messages should contain semicolons
-- ONLY if they are to delimit data elements.
--
-- NOTE 2: There is no technical reason for seperate component and command names, it is the way it is
-- to prevent name collisions in the (hopeful) event that 3rd parties implement helper addons.
--
-- Message format (on the wire): component;cmd;data1;data2;dataN
-- Example usage:
-- A: BFC_Comms.RegisterMessage("MAP", "PING", HandlePing)
-- B: BFC_Comms.SendMessage("MAP", "PING", {0.75, 0.661})
-- Message sent: MAP;PING;0.75;0.661
-- A then receives the message and calls: HandlePing(NameOfPlayerB, {0.75, 0.661})



BFC_Comms = {}; -- Initialize the namespace
BFC_Comms.DebugLoopback = true; -- For testing when not in a group

BFC_Comms.msgPrefix = "BFC"
local registeredCommands = {};

function BFC_Comms.Init()
	BFC_Comms_EventFrame:RegisterEvent("CHAT_MSG_ADDON");
end


function BFC_Comms.OnEvent()
	if(event == "CHAT_MSG_ADDON") then
		BFC_Comms.HandleIncomingMessage(arg1, arg2, arg3, arg4);
	end
end


-- msg can be either a table or a semicolon-delimited string
-- component and cmd CANNOT contain semicolons
function BFC_Comms.SendMessage(component, cmd, msg)
	local channel = "RAID";
	if(MiniMapBattlefieldFrame.status == "active") then
		channel = "BATTLEGROUND";
	end
	
	if(type(msg) == "table") then
		msg = table.concat(msg, ";");
	end
	
	local finalstring = component .. ";" .. cmd .. ";" .. msg;
	BFC.Log(BFC.LOG_DEBUG, "sending: " .. finalstring .. " over " .. channel);
	SendAddonMessage(BFC_Comms.msgPrefix, finalstring, channel);
	
	if(BFC_Comms.DebugLoopback == true and GetNumPartyMembers() == 0 and GetNumRaidMembers() == 0) then
		BFC_Comms.HandleIncomingMessage(BFC_Comms.msgPrefix, finalstring, "DEBUG", UnitName("player"));
	end
end


function BFC_Comms.HandleIncomingMessage(prefix, msg, channel, sender)
	-- If this isn't a message from BFC, don't process
	if(prefix ~= BFC_Comms.msgPrefix) then return end;
	
	-- If we're in a BG and a party/raid at the same time, only process messages from the BG
	if(MiniMapBattlefieldFrame.status == "active" and channel ~= "BATTLEGROUND") then
		BFC.Log(BFC.LOG_DEBUG, "Suppressing non-BF message");
		return;
	end
	
	BFC.Log(BFC.LOG_DEBUG, "Got " .. msg);
	
	local bits = BFC_Util.SplitString(";", msg);
	local index = bits[1] .. ";" .. bits[2];
	
	-- easy-out if nobody has this command registered
	if(not registeredCommands[index]) then return end;
	
	-- slice the first 2 args
	local size = getn(bits);
	local argsarray = {};
	for i=3,size do
		tinsert(argsarray,bits[i])
	end
	
	registeredCommands[index](sender, argsarray);
end


-- component and cmd CANNOT contain semicolons
-- callback should expect 2 arguments: the name of the sender and a table containing all of the sent values
function BFC_Comms.RegisterMessage(component, cmd, callback)
	local index = component .. ";" .. cmd;
	
	if(registeredCommands[index]) then
		BFC.Log(BFC.LOG_ERROR, string.format(BFC_Strings.Errors.ccpairregistered, index));
		return false;
	end
	
	BFC.Log(BFC.LOG_DEBUG, "Registering component-command pair '" .. index .. "'.");
	registeredCommands[index] = callback;
end


function BFC_Comms.UnregisterMessage(component, cmd)
	local index = component .. ";" .. cmd;
	
	if(not registeredCommands[index]) then
		BFC.Log(BFC.LOG_ERROR, string.format(BFC_Strings.Errors.noccpairregistered, index));
		return false;
	end
	
	BFC.Log(BFC.LOG_DEBUG, "Unregistering component-command pair '" .. index .. "'.");
	registeredCommands[index] = nil;
end


-- Send a message to the raid/party
function BFC_Comms.SendPartyMessage(msg)
	
	if(msg == nil or msg == "") then return end
	if(GetNumRaidMembers() == 0 and GetNumPartyMembers() == 0) then return end
	
	if(MiniMapBattlefieldFrame.status == "active") then
		SendChatMessage(msg, "BATTLEGROUND");
	elseif(GetNumRaidMembers() > 0) then
		SendChatMessage(msg, "RAID");
	elseif(GetNumPartyMembers() > 0) then
		SendChatMessage(msg, "PARTY");
	else
		BFC.Log(BFC.LOG_DEBUG, "<BFC> " .. msg);
		BFC.Log(BFC.LOG_ERROR, BFC_Strings.error_notingroup);
	end
end



