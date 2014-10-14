--[[
PanzaComm.lua

Author:		PAdevs
eMail:		wow-pa-devs@lists.sourceforge.net

Real-Time messages between clients that register.

10-01-06 "for in pairs()" completed for BC

--]]

PANZACOMM_RELEASE					= "3.03"

-------------------------------------------------------
-- Global vaiables and counters for the status messages
-------------------------------------------------------
PanzaComm_status_update_interval 	= 60.0; 	-- Status sent once per
PanzaComm_dest_update_interval		= 10.0;		-- Update Destination (Raid->Battleground) every 10 secs. 
PanzaComm_user_timeout_interval		= 0;  		-- Update to (PanzaComm_status_update_interval * 2)
PanzaComm_ChatFramesUpdate_interval	= 10.0;		-- chat frames updated every 10 secs
PanzaComm_ChatFramesTimer 			= 0;
PanzaComm_Version					= nil;		-- Set by config
PanzaComm_receivers 				= {};
PanzaComm_users 					= {};
PanzaComm_appmsgs					= {};
PanzaComm_ChatFrames				= {};
PanzaComm_Player 					= nil;
PanzaComm_debug						= false;
PanzaComm_enabled					= true;
PanzaComm_transmit					= true;
PanzaComm_chatframe					= nil;
PanzaComm_PlayerLogin				= false;
PanzaComm_Loaded					= false;
PanzaComm_addonmode					= 1;		-- Default Send/Receive Mode for Addons
PanzaComm_Internal					= "Base";	-- By default PanzaComm will use Base Channel unless modified
PanzaComm_autodisable				= false;	-- Track how we became disabled.


--[[
Message Destination Setup.
Destination is specificed in App registration (any of these can be used)
--]]
PanzaComm_msgdest					= {
		["Guild"]					= {Inuse=false,Sent=0,Received=0, Type="Guild",	Name="GUILD", 		desc="Messages Sent to Guild."},
		["Raid"]					= {Inuse=false,Sent=0,Received=0, Type="Raid",	Name="RAID",		desc="Messages Sent to Raid"},
		["Party"]					= {Inuse=false,Sent=0,Received=0, Type="Party",	Name="PARTY",		desc="Messages Sent to Party"},
		["BG"]						= {Inuse=false,Sent=0,Received=0, Type="BG",	Name="BATTLEGROUND",desc="Messages Sent to Battleground"},
		};

PCOM_MATCH_AFK	= gsub(gsub(MARKED_AFK_MESSAGE, "%%s", "(.*)", 1), "%%1%$s", "(.*)", 1);

-----------------------------------------------
-- Mode Text for Registered Addons.
-- An addon may register with (Receive Only)
-- to process messages intended for another app
-- that is not installed locally.
-----------------------------------------------
PanzaComm_Mode_Text	= {
			[1]		= "(Send/Receive)",
			[2]		= "(Receive Only)",
			};

--------------------------
-- Colors used in messages
--------------------------
PCOM_BLUE 	= "|cff6666ff";
PCOM_GREY 	= "|cff999999";
PCOM_GREN	= "|cff66cc33";
PCOM_RED	= "|cffff2020";
PCOM_YEL	= "|cffffff40";
PCOM_BGREY	= "|c00D0D0D0";
PCOM_WHITE	= "|c00FFFFFF";
PCOM_ORANGE	= "|cffff9930";

PanzaCommDetails = {
		name = "PanzaComm",
		version = PANZACOMM_RELEASE,
		releaseDate = "September 14, 2006",
		author = "PADevs",
		email = "wow-pa-devs@lists.sourceforge.net",
		website = "",
		category = MYADDONS_CATEGORY_DEVELOPMENT,
		optionsframe = ""
		};

PanzaCommHelp		= {};
PanzaCommHelp[1]	= "Table of Contents\n1. Index\n2. Overview\n3. Configuration\n4. Operation\n5. API\n";
PanzaCommHelp[2]	= "Overview\n\nPanzaComm is a real-time communications library.\nThis communication uses the SendAddonMessage API function.\nMessages are sent to specific destinations that are specified in the registration process.\nPanzaComm will automatically switch to Battleground destination \"BG\" for apps that register with \"Raid\" or \"Party\". PanzaComm will also switch back to the default destination after leaving the Battleground.";
PanzaCommHelp[3]	= "Configuration\n\nPanzaComm requires no configuration and should perform automatically\nYou may create a chat window named PanzaComm, and all PanzaComm output will be directed to this chat window.";
PanzaCommHelp[4]	= "Operation\n\nCommand line options are available to toggle the state (transmission), completely disable, or enable PanzaComm, view current status, and reset communication data.\nA debug command will show all internal processing of message data and can be used to identify problems that may occur.\nThe cli cmmands may be accessed by typing /pcom <command> in the chat window. typing /pcom by itself will display cmmand line help\n";
PanzaCommHelp[5]	= "PanzaComm API\n\nPanzaComm provides three functions for use in applications. PanzaComm_Register, PanzaComm_ChannelOK, and PanzaComm_Message. These three functions are explained in the Readme.txt file located in the PanzaComm directory.\n";

------------------------------
-- Register Events when loaded
------------------------------
function PanzaComm_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("CHAT_MSG_ADDON");
	this:RegisterEvent("CHAT_MSG_SYSTEM");
	this:RegisterEvent("PLAYER_LOGIN");
end

------------------------------------------------------------
-- General message output from addon. Use Panza Frame first
------------------------------------------------------------
function PanzaComm_Print(message)
	if (PanzaComm_chatframe and message) then
		getglobal("ChatFrame"..PanzaComm_chatframe):AddMessage(PCOM_GREN..message);
	elseif (DEFAULT_CHAT_FRAME and message) then
		DEFAULT_CHAT_FRAME:AddMessage(PCOM_GREN..message);
	end
end

-----------------------------------------------------
-- Register, or Re-Register to change our own channel
-----------------------------------------------------
function PanzaComm_InternalRegister()
	if (not PanzaComm_Register("PanzaComm", PanzaComm_Receiver, 1, "Guild")) then
		PanzaComm_Print(PCOM_RED..PANZACOMM_MSG_INT_REGISTER_FAIL);
	end
end

-------------------------------------
-- returns true if you are in a party
-------------------------------------
function PanzaComm_IsInParty()
	return GetNumPartyMembers()~=0;
end

------------------------------------------
-- returns true if you are in a raid party
------------------------------------------
function PanzaComm_IsInRaid()
	return GetNumRaidMembers()~=0;
end

---------------------------------
-- returns BattleGround we are in
---------------------------------
function PanzaComm_IsInBattleground()
	for i=1, MAX_BATTLEFIELD_QUEUES do
		local bgstatus, BGName, instanceID = GetBattlefieldStatus(i);
		if (instanceID~=0  and bgstatus=="active") then
			return true, BGName;
		end
	end
	return false, nil;
end

----------------------------------------------
-- Return UnitID of Unit knowing only the Name
----------------------------------------------
function PanzaComm_FindUnitFromName(name)
	local unit, Index = nil, nil;

	if (name == UnitName("player")) then
		return "player";
	end

	if (PanzaComm_IsInParty()) then
		for Index = 1, 5 - 1 do
			unit = "party"..Index;
			if (UnitName(unit)==name) then
				return unit;
			end
		end
	end

	if (PanzaComm_IsInRaid()) then
		for Index = 1, 40 do
			unit = "raid"..Index;
			if (UnitName(unit)==name) then
				return unit;
			end
		end
	end
	return unit;
end

-------------------------------------
-- Mark/Purge User status in Database
-------------------------------------
function PanzaComm_UpdateUsers()

	if (PanzaComm_enabled==false) then return;end

	local updatetime = GetTime();

	for user in PanzaComm_users do
		if (PanzaComm_users[user].Name ~= PanzaComm_Player) then
			if (PanzaComm_users[user].Last + (PanzaComm_user_timeout_interval * 4) < updatetime) then
				PanzaComm_users[user] = nil;
			elseif (PanzaComm_users[user].Last + PanzaComm_user_timeout_interval < updatetime) then
				PanzaComm_users[user].Status = string.format("Inactive %.0f seconds.", (updatetime - PanzaComm_users[user].Last));
			else
				PanzaComm_users[user].Status = "Active";
			end
		end
	end
end

------------------
-- Enable PanzaComm
-------------------
function PanzaComm_Enable()
	PanzaComm_Print(PCOM_WHITE..PANZACOMM_MSG_ENABLE);
	PanzaComm_transmit = true;
	PanzaComm_enabled = true;
	PanzaComm_users[PanzaComm_Player].Status="Active";
end

--------------------
-- Disable PanzaComm
--------------------
function PanzaComm_Disable()
	PanzaComm_Print(PCOM_ORANGE..PANZACOMM_MSG_DISABLE);
	PanzaComm_transmit = false;
	PanzaComm_enabled = false;
	PanzaComm_users[PanzaComm_Player].Status="Inactive";
end

--------------------------------------
-- Timer functions from PanzaCommFrame
--------------------------------------
function PanzaComm_OnUpdate(elapsed)
	PanzaComm_dest_update_time		= (PanzaComm_dest_update_time or 0) + elapsed;
	PanzaComm_status_update_time	= (PanzaComm_status_update_time or 0) + elapsed;
	PanzaComm_user_timeout			= (PanzaComm_user_timeout or 0) + elapsed;
	PanzaComm_ChatFramesTimer		= (PanzaComm_ChatFramesTimer or 0) + elapsed;

	-- broadcast status every update interval for status
	if (PanzaComm_Loaded and PanzaComm_status_update_time > PanzaComm_status_update_interval and PanzaComm_transmit==true) then
		PanzaComm_status_update_time = 0;
		PanzaComm_Message("PanzaComm","Status, "..PanzaComm_users[PanzaComm_Player].Name..", "..PanzaComm_users[PanzaComm_Player].Class..", "..PanzaComm_users[PanzaComm_Player].Version..", "..PanzaComm_users[PanzaComm_Player].Sent..", "..PanzaComm_users[PanzaComm_Player].Received..", "..PanzaComm_users[PanzaComm_Player].Rejected);
	end

	-- update all users status every status update internal.
	if (PanzaComm_Loaded and PanzaComm_user_timeout > PanzaComm_status_update_interval) then
		PanzaComm_user_timeout = 0;
		PanzaComm_UpdateUsers();
	end

	-- update chat frames database after trigger
	if (PanzaComm_Loaded and PanzaComm_ChatFramesTimer > PanzaComm_ChatFramesUpdate_interval) then
		PanzaComm_ChatFramesTimer = 0;
		PanzaComm_UpdateChatFrames();
	end
	
	-- update destination if we are in a battleground and are using Raid
	if (PanzaComm_Loaded and PanzaComm_dest_update_time > PanzaComm_dest_update_interval) then
		PanzaComm_dest_update_time = 0;
		PanzaComm_UpdateDest();
	end	
end


-----------------------------
-- Event processor from frame
-----------------------------
function PanzaComm_OnEvent()
	if (event == "VARIABLES_LOADED") then

		PanzaComm_user_timeout_interval	= (PanzaComm_status_update_interval * 2)

		PanzaComm_Player = UnitName("player");

		-- Setup ChatFrame
		PanzaComm_UpdateChatFrames();

		PanzaComm_Print(PCOM_BLUE.."PanzaComm v"..PANZACOMM_RELEASE..""..PCOM_GREN.." Use "..PCOM_YEL.."/panzacomm "..PCOM_GREN.."or "..PCOM_YEL.."/pcom "..PCOM_GREN.."for help.");

		if (PanzaComm_Version~=nil and PanzaComm_Version ~= PANZACOMM_RELEASE) then
			PanzaComm_Print(PCOM_BLUE.."Old Version "..PCOM_WHITE..PanzaComm_Version..PCOM_BLUE.." New Version "..PCOM_WHITE..PANZACOMM_RELEASE);
		end

		PanzaComm_Version = PANZACOMM_RELEASE;

		PanzaComm_Loaded = true;

		-- Register ourselves for channel management and status collection
		PanzaComm_InternalRegister();

		-- Setup CLI
		SlashCmdList["PANZACOMM"] = PanzaComm_SlashHandler;
		SLASH_PANZACOMM1 = "/panzacomm";
		SLASH_PANZACOMM2 = "/pcom";
		QUEST_FADING_ENABLE = nil;

		-- Setup our own databae entry
		PanzaComm_users[PanzaComm_Player] = {
				["Name"]=PanzaComm_Player,
				["Class"]=UnitClass("player"),
				["Version"]=PANZACOMM_RELEASE,
				["Sent"]=0,
				["Received"]=0,
				["Rejected"]=0,
				["Status"]="Active";
				["Last"]=GetTime();
				};

		-- If we were brought up in a disabled state, Mark ourselves as inactive, and disable automatically.
		if (PanzaComm_enabled==false) then
			PanzaComm_Disable();
		end

		-- Register with myAddons
		if(myAddOnsFrame_Register) then
			myAddOnsFrame_Register(PanzaCommDetails, PanzaCommHelp);
		end

	-- Mark ourselves as ready
	--------------------------
	elseif (event == "PLAYER_LOGIN") then
		PanzaComm_PlayerLogin = true;
		if (PanzaComm_enabled==true) then
			PanzaComm_dest_update_time = -2;
			PanzaComm_Print("(PanzaComm) "..PCOM_BLUE.."Ready and Active.");
			PanzaComm_Message("PanzaComm","Status, "..PanzaComm_users[PanzaComm_Player].Name..", "..PanzaComm_users[PanzaComm_Player].Class..", "..PanzaComm_users[PanzaComm_Player].Version..", "..PanzaComm_users[PanzaComm_Player].Sent..", "..PanzaComm_users[PanzaComm_Player].Received..", "..PanzaComm_users[PanzaComm_Player].Rejected);
		else
			PanzaComm_Print("(PanzaComm) "..PCOM_ORANGE.."Ready but Inactive.");
		end

	-- Process system chat messages. Make sure we observe AFK
	---------------------------------------------------------
	elseif (event == "CHAT_MSG_SYSTEM" and arg1) then

		if (PanzaComm_Player~=nil) then
			if (string.find(arg1, PCOM_MATCH_AFK) or arg1==MARKED_AFK) then
				if (PanzaComm_debug) then PanzaComm_Print(PCOM_ORANGE..PANZACOMM_MSG_XMIT_DISABLED); end
				PanzaComm_transmit = false;
				PanzaComm_users[PanzaComm_Player].Status="AFK";
				PanzaComm_autodisable = true;
			elseif (arg1 == CLEARED_AFK) then
				if (PanzaComm_enabled==true) then
					PanzaComm_transmit = true;
					PanzaComm_autodisable = false;
					if (PanzaComm_debug) then PanzaComm_Print(string.format(PCOM_BLUE..PANZACOMM_CLEARINGAFK,PCOM_WHITE..arg1)); end
					if (PanzaComm_debug) then PanzaComm_Print(PCOM_BLUE..PANZACOMM_MSG_XMIT_ENABLED); end
					PanzaComm_users[PanzaComm_Player].Status="Active";
				else
					PanzaComm_users[PanzaComm_Player].Status="Inactive";
				end
			end
		end

	-- Process chat messages sent to our destination.
	---------------------------------------------------------
	elseif (event == "CHAT_MSG_ADDON") then
		-- PA:ShowText("CHAT_MSG_ADDON event arg1=", arg1, " arg2=", arg2, " arg3=", arg3, " arg4=", arg4);
		if (arg3 and arg3==PanzaComm_msgdest["Guild"].Name) then
			PanzaComm_msgdest["Guild"].Received = PanzaComm_msgdest["Guild"].Received + 1;
		elseif (arg3 and arg3==PanzaComm_msgdest["Raid"].Name) then
			PanzaComm_msgdest["Raid"].Received = PanzaComm_msgdest["Raid"].Received + 1;
		elseif (arg3 and arg3==PanzaComm_msgdest["Party"].Name) then
			PanzaComm_msgdest["Party"].Received = PanzaComm_msgdest["Party"].Received + 1;
		elseif (arg3 and arg3==PanzaComm_msgdest["BG"].Name) then
			PanzaComm_msgdest["BG"].Received = PanzaComm_msgdest["BG"].Received + 1;
		end
		if (PanzaComm_debug) then PanzaComm_Print(PCOM_BLUE.."CHAT_MSG_ADDON: arg1.."..PCOM_WHITE..arg1..PCOM_BLUE.." arg2 "..PCOM_WHITE..arg2..PCOM_BLUE.." arg3 "..PCOM_WHITE..arg3..PCOM_BLUE.." arg4 "..PCOM_WHITE..arg4  );end
		PanzaComm_ProcessChat(arg1,arg2,arg4);
	end
end

---------------------------------
-- Process Received Chat Messages
---------------------------------
function PanzaComm_ProcessChat(arg1,arg2,arg4)

	local id, message, author = arg1, arg2, arg4;

	-- and send the message to the right addon if its registered
	if (id and message and PanzaComm_receivers[id]) then
		-- Maintain our Player Counts
		PanzaComm_users[PanzaComm_Player].Received = PanzaComm_users[PanzaComm_Player].Received + 1;

		-- Maintain Message Counts per Addon
		PanzaComm_appmsgs[id] = (PanzaComm_appmsgs[id] or {});
		PanzaComm_appmsgs[id]["Received"] = PanzaComm_appmsgs[id].Received + 1;

		if (PanzaComm_debug) then PanzaComm_Print("(PanzaComm) Passing "..PCOM_WHITE..""..message..""..PCOM_GREN.." from "..PCOM_WHITE..""..arg4..""..PCOM_GREN.." to "..PCOM_WHITE..""..id..""..PCOM_GREN); end

		-- Call the Receiver Function specified in Registration
		PanzaComm_receivers[id](arg4, message);
	end
end

-----------------------------------------------------------------------------------
-- Returns True of False when queried with application id for channel availability.
-----------------------------------------------------------------------------------
function PanzaComm_ChannelOK(id)
	if (id==nil) then
		if (PanzaComm_debug) then PanzaComm_Print(PCOM_RED..PANZACOMM_INVALIDCALL_CHANNELOK); end
		return false;
	end
	if (PanzaComm_appmsgs[id]==nil or PanzaComm_appmsgs[id]["Sent"]==nil) then
		if (PanzaComm_debug) then PanzaComm_Print(format(PANZACOMM_CHECK_UNREGISTERED, PCOM_WHITE..id)); end
		return false;
	end;
	if (PanzaComm_appmsgs[id].Dest==nil) then
		if (PanzaComm_debug) then PanzaComm_Print(format(PANZACOMM_CHECK_NODESTDEFINED,PCOM_WHITE..id));end
		return false;
	end
	
	if (PanzaComm_transmit==false) then return false; end
	if (PanzaComm_enabled==false) then return false; end

	return(true)
end

--------------------------------------------
-- Store Chat Frame Names with Index Numbers
--------------------------------------------
function PanzaComm_UpdateChatFrames()
	local i=nil;
	for i=1, NUM_CHAT_WINDOWS do
		local name = GetChatWindowInfo(i);
		if (i==1) then name="General"; end;
		if (i==2) then name="Combat"; end;

		PanzaComm_ChatFrames[name] = (PanzaComm_ChatFrames[name] or {});
		PanzaComm_ChatFrames[name].Id=i;

		if (string.lower(name) == "panzacomm") then
			PanzaComm_chatframe = i;
			PanzaComm_channel_update_time = 0;
		end
	end
end

-------------------------------------------------------------------------
-- Update Message Destinations when in Battlegrounds for Raid and Party
-- If BG was not the destination when not in BattleGrounds, switch back 
-- Check Guild Status and modify Destinations if Guild Info is available
-------------------------------------------------------------------------
function PanzaComm_UpdateDest()

	-- Get Guild Info, use to modify destinations that should be using Guild
	local guildName, ___, ___ = GetGuildInfo("player");

	-- Switch between Battleground and Raid/Party
	if (PanzaComm_IsInBattleground()) then
		for id in PanzaComm_receivers do
			if (PanzaComm_appmsgs[id].Dest=="Raid" or PanzaComm_appmsgs[id].Dest=="Party") then
				PanzaComm_Print(string.format(PANZACOMM_MSG_SWITCH, PCOM_BLUE..id, PCOM_WHITE..PanzaComm_appmsgs[id].Dest, PCOM_WHITE.."BattleGround"));
				PanzaComm_appmsgs[id].Dest="BG";
				PanzaComm_msgdest["BG"].Inuse=true;
			end	
		end
		
	-- Otherwise switch back to whatever we were in if we changed	
	else
		for id in PanzaComm_receivers do
			if (PanzaComm_appmsgs[id].Dest=="BG" and PanzaComm_appmsgs[id].Dest~=PanzaComm_appmsgs[id].DefDest) then
				PanzaComm_Print(string.format(PANZACOMM_MSG_SWITCH, PCOM_BLUE..id, PCOM_WHITE..PanzaComm_appmsgs[id].Dest, PCOM_WHITE..PanzaComm_appmsgs[id].DefDest));
				PanzaComm_appmsgs[id].Dest=PanzaComm_appmsgs[id].DefDest;
				PanzaComm_msgdest[PanzaComm_appmsgs[id].DefDest].Inuse=true;
			end	
		end
	end	
	
	-- Switch to Guild if we are supposed to use Guild and currently are not
	if (guildName~=nil) then
		for id in PanzaComm_receivers do
			if (PanzaComm_appmsgs[id].Dest~=PanzaComm_appmsgs[id].DefDest and PanzaComm_appmsgs[id].DefDest=="Guild") then
				PanzaComm_Print(string.format(PANZACOMM_MSG_SWITCH, PCOM_BLUE..id, PCOM_WHITE..PanzaComm_appmsgs[id].Dest, PCOM_WHITE..PanzaComm_appmsgs[id].DefDest));
				PanzaComm_appmsgs[id].Dest=PanzaComm_appmsgs[id].DefDest;
				PanzaComm_msgdest[PanzaComm_appmsgs[id].DefDest].Inuse=true;
			end
		end
		
	-- Otherwise if we are supposed to use Guild and are not in one (maybe a recent /gquit), switch to Raid	
	elseif (PanzaComm_msgdest["Guild"].Inuse==true) then
		for id in PanzaComm_receivers do
			if (PanzaComm_appmsgs[id].Dest=="Guild") then
				PanzaComm_Print(string.format(PANZACOMM_MSG_SWITCH, PCOM_BLUE..id, PCOM_WHITE..PanzaComm_appmsgs[id].Dest, PCOM_WHITE.."Raid"));
				PanzaComm_appmsgs[id].Dest="Raid";
				PanzaComm_msgdest["Raid"].Inuse=true;
				PanzaComm_msgdest["Guild"].Inuse=false;
			end
		end
	end	
end

----------------------------------------------------------------------------
-- Every addon that wants to use PanzaComm must register
-- id = Prefix to use in SendAddonMessage()
-- receiver - what function should receive messages from other clients
-- PanzaComm_addonmode - 1 = Reda/Write, 2 = Read Only
-- PanzaComm_Dest = "Guild"|"Party"|"Raid"|"BG"
-- Returns true for success, false for failure
----------------------------------------------------------------------------
function PanzaComm_Register(id, receiver, PanzaComm_addonmode, PanzaComm_Dest)
	if (not id or not receiver) then
		PanzaComm_Print(PCOM_RED..PANZACOMM_INVALIDCALL_REGISTER);
		return false;
	end;
	
	local PanzaComm_DefDest;
	
	if (PanzaComm_Dest==nil) then 
		PanzaComm_DefDest = "Guild";
		PanzaComm_Dest = "Guild";
	else
		PanzaComm_DefDest = PanzaComm_Dest;
	end	
	
	-- Set the Addon Mode. If Not Passed, Use Send/Receive Mode.
	if (PanzaComm_addonmode==nil) then PanzaComm_addonmode = PANZACOMM_MODE_SEND_RECEIVE; end
		if (PanzaComm_addonmode~=PANZACOMM_MODE_SEND_RECEIVE and PanzaComm_addonmode~=PANZACOMM_MODE_RECEIVE_ONLY) then PanzaComm_addmode=PANZACOMM_MODE_SEND_RECEIVE;end

	-- Get Guild Info, if not in a guild, replace Guild Registration with Raid.
	local guildName, ___, ___ = GetGuildInfo("player");

	-- Determine Destination requested if any
	if (PanzaComm_Dest=="Guild" and guildName==nil) then
		PanzaComm_Dest="Raid";
	elseif (PanzaComm_Dest~=PANZACOMM_DEST_GUILD and PanzaComm_Dest~=PANZACOMM_DEST_RAID and PanzaComm_Dest~=PANZACOMM_DEST_BG and PanzaComm_Dest~=PANZACOMM_DEST_PARTY) then 
		if (guildName) then PanzaComm_Dest="Guild"; else PanzaComm_Dest="Raid";end
	end

	if (not guildName and PanzaComm_Dest=="Guild") then Dest="Raid";end

	local TypeText=PanzaComm_msgdest[PanzaComm_Dest].Type;

	-- Check Receiver function passed. Make sure a function was passed
	if (type(receiver)=="function") then
		PanzaComm_receivers[id] = receiver;
	else
		PanzaComm_Print(string.format(PANZACOMM_MSG_INVALIDRECEIVER,PCOM_RED..id));
		return false;
	end

	if (PanzaComm_debug) then
		PanzaComm_Print(string.format(PANZACOMM_MSG_RECEIVER, PCOM_BLUE..id, PCOM_WHITE..PanzaComm_Mode_Text[PanzaComm_addonmode], PCOM_BLUE..PanzaComm_Dest));
	end

	PanzaComm_msgdest[PanzaComm_Dest].Inuse=true;
	
	-- Setup Message Counters per app
	PanzaComm_appmsgs[id] = (PanzaComm_appmsgs[id] or {});
	PanzaComm_appmsgs[id]["Sent"]=0;
	PanzaComm_appmsgs[id]["Received"]=0;
	PanzaComm_appmsgs[id]["Mode"]=PanzaComm_addonmode;
	PanzaComm_appmsgs[id]["Dest"]=PanzaComm_Dest;
	PanzaComm_appmsgs[id]["DefDest"]=PanzaComm_DefDest;

	return true;
end

-------------------------------------------====-----------------------------------------------
-- Send a message to the configured destination (Used by addons that cooperate with PanzaComm)
-- id = Name of Addon that Registered
-- message = message to send
----------------------------------------------------------------------------------------------
function PanzaComm_Message(id, message)
	if (not id or not message) then
		if (PanzaComm_debug) then PanzaComm_Print(PCOM_RED..PANZACOMM_INVALIDCALL_MESSAGE); end
		return false;
	end

	if (not PanzaComm_ChannelOK(id)) then
		if (PanzaComm_debug) then PanzaComm_Print(PCOM_RED..PANZACOMM_MSG_SEND_FAIL_CHECK); end
		return false;
	end

	-- See if we allowed to speak
	if (PanzaComm_transmit == false) then
		if (PanzaComm_enable == true and PanzaComm_autodisable == true) then
			if (PanzaComm_debug) then PanzaComm_Print(string.format(PANZACOMM_MSG_XMIT_SKIP,PCOM_WHITE..message,PCOM_WHITE..id,PCOM_ORANGE..PANZACOMM_MSG_XMIT_DISABLE_SHORT));end
			return false;
		elseif (PanzaComm_enable == true and PanzaComm_autodisable == false) then
			PanzaComm_Enable();
		end
	end


	PanzaComm_msgdest[PanzaComm_appmsgs[id].Dest].Sent = PanzaComm_msgdest[PanzaComm_appmsgs[id].Dest].Sent + 1;

	--PA:ShowText("Sending message: id=", id, " message=", message);
	--PA:ShowText("dest=", PanzaComm_appmsgs[id].Dest);
	--PA:ShowText("name=", PanzaComm_msgdest[PanzaComm_appmsgs[id].Dest].Name);
	SendAddonMessage(id, message, PanzaComm_msgdest[PanzaComm_appmsgs[id].Dest].Name);

	PanzaComm_users[PanzaComm_Player].Sent = PanzaComm_users[PanzaComm_Player].Sent + 1;
	PanzaComm_appmsgs[id]["Sent"] = PanzaComm_appmsgs[id].Sent + 1;
	return true;
end


---------------------------------------
-- Command Line Interface for PanzaComm
---------------------------------------
function PanzaComm_SlashHandler(msg)
	msg = strlower(msg);

	-- Print Help
	if (msg== "") then
		PanzaComm_Print(PCOM_BLUE.."PanzaComm v"..PanzaComm_Version);
		PanzaComm_Print(PCOM_YEL.."/pcom toggle "..PCOM_WHITE..PANZACOMM_MSG_HELP_TOGGLE);
		PanzaComm_Print(PCOM_YEL.."/pcom enable "..PCOM_WHITE..PANZACOMM_MSG_HELP_ENABLE);
		PanzaComm_Print(PCOM_YEL.."/pcom disable "..PCOM_WHITE..PANZACOMM_MSG_HELP_DISABLE);
		PanzaComm_Print(PCOM_YEL.."/pcom status "..PCOM_WHITE..PANZACOMM_MSG_HELP_STATUS);
		PanzaComm_Print(PCOM_YEL.."/pcom reset "..PCOM_WHITE..PANZACOMM_MSG_HELP_RESET);
		PanzaComm_Print(PCOM_YEL.."/pcom defaults "..PCOM_WHITE..PANZACOMM_MSG_HELP_DEFAULTS);
		PanzaComm_Print(PCOM_YEL.."/pcom debug "..PCOM_WHITE..PANZACOMM_MSG_HELP_DEBUG);

	-- Toggle State
	elseif (msg=="toggle") then
		if (PanzaComm_transmit == true or PanzaComm_enabled == true) then
			PanzaComm_Disable();
		else
			PanzaComm_Enable();
		end

	-- Enable PanzaComm
	elseif (msg=="enable") then
		PanzaComm_Enable();

	-- Disable PanzaComm
	elseif (msg=="disable") then
		PanzaComm_Disable();

	-- Print Status
	elseif (msg=="status") then
		PanzaComm_Print(PCOM_BLUE.."PanzaComm v"..PanzaComm_Version.." Status:");

		if (PanzaComm_debug==true) then
			PanzaComm_Print(PCOM_ORANGE..PANZACOMM_MSG_DEBUG_ENABLED);
		else
			PanzaComm_Print(PCOM_YEL..PANZACOMM_MSG_DEBUG_DISABLED);
		end

		if (PanzaComm_transmit==true) then
			PanzaComm_Print(PCOM_YEL..PANZACOMM_MSG_XMIT_ENABLED);
		else
			PanzaComm_Print(PCOM_ORANGE..PANZACOMM_MSG_XMIT_DISABLED);
		end

		PanzaComm_Print("Player Status:");
		PanzaComm_Print(PCOM_WHITE.."Player "..PCOM_WHITE..", "..PCOM_BLUE.."Version "..PCOM_WHITE..", "..PCOM_YEL.."Sent "..PCOM_WHITE..", "..PCOM_ORANGE.."Received "..PCOM_WHITE..", "..PCOM_RED.."Rejected "..PCOM_WHITE..", "..PCOM_GREN.."Status");
		for who, whodata in pairs(PanzaComm_users) do
			PanzaComm_Print(PCOM_WHITE..""..PanzaComm_users[who].Name.." "..PCOM_WHITE..", "..PCOM_BLUE..PanzaComm_users[who].Version.." "..PCOM_WHITE..", "..PCOM_YEL.." "..PanzaComm_users[who].Sent.." "..PCOM_WHITE..", "..PCOM_ORANGE.." "..PanzaComm_users[who].Received.." "..PCOM_WHITE..", "..PCOM_RED.." "..PanzaComm_users[who].Rejected.." "..PCOM_WHITE..", "..PCOM_GREN.." "..PanzaComm_users[who].Status);
		end

		PanzaComm_Print("Registered Addons:");
		PanzaComm_Print(PCOM_WHITE.."ID".." "..PCOM_BLUE.."Dest".." "..PCOM_YEL.."Sent "..PCOM_WHITE.." "..PCOM_ORANGE.."Received");
		for id in PanzaComm_receivers do
			if (PanzaComm_appmsgs[id].Mode == PANZACOMM_MODE_SEND_RECEIVE) then
				PanzaComm_Print(PCOM_WHITE..""..id..", "..PCOM_BLUE.." "..PanzaComm_appmsgs[id].Dest..PCOM_WHITE..", "..PCOM_YEL.." "..PanzaComm_appmsgs[id].Sent.." "..PCOM_WHITE..", "..PCOM_ORANGE.." "..PanzaComm_appmsgs[id].Received);
			else
				PanzaComm_Print(PCOM_WHITE..""..id..", "..PCOM_BLUE.." "..PanzaComm_appmsgs[id].Dest..PCOM_WHITE..", "..PCOM_YEL.." N/A "..PCOM_WHITE..", "..PCOM_ORANGE.." "..PanzaComm_appmsgs[id].Received);
			end
		end

		-- Print Destination Status
		PanzaComm_Print(PCOM_GREN.."Destination "..PCOM_YEL.."Sent "..PCOM_ORANGE.."Received");
		if (PanzaComm_enabled==false) then
			PanzaComm_Print(PCOM_ORANGE..PANZACOMM_MSG_STATUS_DISABLED);
		else
			if (PanzaComm_msgdest["Guild"].Inuse==true) then PanzaComm_Print("Guild: "..PCOM_WHITE..""..PCOM_YEL..PanzaComm_msgdest["Guild"].Sent.." "..PCOM_ORANGE..PanzaComm_msgdest["Guild"].Received);end;
			if (PanzaComm_msgdest["Raid"].Inuse==true) then PanzaComm_Print("Raid: "..PCOM_WHITE..""..PCOM_YEL..PanzaComm_msgdest["Raid"].Sent.." "..PCOM_ORANGE..PanzaComm_msgdest["Raid"].Received);end;
			if (PanzaComm_msgdest["Party"].Inuse==true) then PanzaComm_Print("Party: "..PCOM_WHITE..""..PCOM_YEL..PanzaComm_msgdest["Party"].Sent.." "..PCOM_ORANGE..PanzaComm_msgdest["Party"].Received);end;
			if (PanzaComm_msgdest["BG"].Inuse==true) then PanzaComm_Print("BG: "..PCOM_WHITE..""..PCOM_YEL..PanzaComm_msgdest["BG"].Sent.." "..PCOM_ORANGE..PanzaComm_msgdest["BG"].Received);end;
		end

	-- Toggle Debug Mode
	elseif (msg=="debug") then
		if (PanzaComm_debug == true) then
			PanzaComm_Print(PCOM_YEL..PANZACOMM_MSG_DEBUG_DISABLED);
			PanzaComm_debug = false;
		else
			PanzaComm_Print(PCOM_ORANGE..PANZACOMM_MSG_DEBUG_ENABLED);
			PanzaComm_debug = true
		end

	-- Reset Data and comminications channel
	elseif (msg=="reset") then
		PanzaComm_Print(PCOM_BLUE..PANZACOMM_MSG_RESET);

		PanzaComm_users			= 	{};

		PanzaComm_users[PanzaComm_Player] = {
						["Name"]=PanzaComm_Player,
						["Class"]=UnitClass("player"),
						["Version"]=PanzaComm_Version,
						["Sent"]=0,
						["Received"]=0,
						["Rejected"]=0,
						["Last"]=GetTime(),
						["Status"]="Active",
						};

		-- Reset App Messages
		for id in PanzaComm_receivers do
			PanzaComm_appmsgs[id]["Sent"] = 0;
			PanzaComm_appmsgs[id]["Received"] = 0;
		end

		-- Give ourselves the correct status if disabled
		if (PanzaComm_enabled==false or PanzaComm_transmit==false) then
			PanzaComm_users[PanzaComm_Player].Status="Inactive";
		end

	else
		PanzaComm_Print(string.format(PCOM_ORANGE..PANZACOMM_MSG_UNKNOWN, PCOM_WHITE..msg));
	end
end

---------------------------------------------------------------------
-- Internal Receiver to Manage Channel, Reports, and Status Messages.
---------------------------------------------------------------------
function PanzaComm_Receiver(author, message)
	if (PanzaComm_debug==true) then PanzaComm_Print("(PanzaComm) "..PCOM_WHITE..""..author..""..PCOM_GREN.." sent "..PCOM_WHITE..""..message..""..PCOM_GREN); end

	-- check for self, or this player is in the party or raid
	if (author == (UnitName("player"))) then return; end

	-- person sending message is not in party or raid
	--[[
	if (not PanzaComm_FindUnitFromName(author)) then
		PanzaComm_users[PanzaComm_Player].Rejected = PanzaComm_users[PanzaComm_Player].Rejected + 1;
		if (PanzaComm_debug) then
			PanzaComm_Print(string.format(PCOM_ORANGE..PANZACOMM_MSG_RCVD_REJECT_1,PCOM_WHITE..author));
		end
		return;
	end
	--]]

	-- PanzaComm_Message("PanzaComm", "Channel/Status, " ..Field1.. ", " .. Field2 .. ", " .. Field3 .. ", " .. Field4 (Number).. ", " .. Field5 (Number) .. ", " .. Field6 (Number));

	-- Extract message. This message will come from PanzaComm.
	local start, stop, what, field1, field2, field3, field4, field5, field6 = string.find(message, "^(.+), (.+), (.+), (.+), (%d+%.?%d*), (%d+%.?%d*), (%d+%.?%d*)");

	-- message not understood
	if (not start) then
		PanzaComm_users[PanzaComm_Player].Rejected = PanzaComm_users[PanzaComm_Player].Rejected + 1;
		if (PanzaComm_debug) then PanzaComm_Print(format(PCOM_ORANGE..PANZACOMM_MSG_RCVD_REJECT_2,PCOM_WHITE..author)); end
		return;
	end

	-- Update our own counters
	PanzaComm_users[PanzaComm_Player].Received = PanzaComm_users[PanzaComm_Player].Received + 1;

	if (what=="Status") then
		PanzaComm_users[author] = (PanzaComm_users[author] or {});

		PanzaComm_users[author].Name=field1;
		PanzaComm_users[author].Class=field2;
		PanzaComm_users[author].Version=field3;
		PanzaComm_users[author].Sent=field4;
		PanzaComm_users[author].Received=field5;
		PanzaComm_users[author].Rejected=field6;
		PanzaComm_users[author].Last=GetTime();
		PanzaComm_users[author].Status="Active";
	end
end
