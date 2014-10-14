---------------------------------------------------------------------------------
--
-- Guild Mailing List
-- GuildML.lua
-- Based on GuildMailer by Cragganmore
--
-- Author: Paul Barbeau
-- URL : http://www.enrguild.com/GuildML
-- Licence: GPL version 2 (General Public License)
--
--
-- In the mail frame, a button next to the "To:" field will open a mailing
-- list search frame. To send to a mailing list define who you want to sent
-- to and select "Use" 
--
-- If you are the Guild Master and you want to limit who can send enter the index number
-- of the level can want send in your MemberOfficerNote in the format [GML #] otherwise
-- the default is anyone less than or equal to 3
-- 
-- If you like it and are on argent dawn (oedi) or firetree (eviloedi) send me some gold lol
--
-- /gml version 
--		tells you the version
-- /gml timeout [1-60]]
--		set the message timeout where 1-60 is number of seconds
-- /gml debug
--		turn debuging on 
-- /gml nodebug
--		turn debuging off
-- /gml reset
-- 		reset your who can send
-- /gml reload
-- 		reload the UI
-- /gml help
--		shows some help
-- /gml settings
--		shows your settings
---------------------------------------------------------------------------------

---------------------------------------------------------------------------------
--
-- Constants
-- 
---------------------------------------------------------------------------------
GuildML_VERSION     = 208;
GuildML_DEBUG 		= false;
GuildML_SendLevel	= 12;
GuildML_AppName		= GuildML_TITLE;
GuildML_TIMEOUT 	= 20;
GuildML_MAILINGLISTS = { };
GuildML_LastSuccessfulRecipient = "";

----------------------------------------------------------------------------------
--
-- Print a debug string to the chat frame
--	msg - message to print
-- 
---------------------------------------------------------------------------------
local function DEBUG_MSG(msg)
	if (GuildML_DEBUG) then
		ChatFrame1:AddMessage(msg, 1.0, 1.0, 0.5);
	end
end

---------------------------------------------------------------------------------
--
-- gets rid of nil for string and numbers
-- 
---------------------------------------------------------------------------------

function NoNil(param)
	if (param == nil) then
		return "<nil>";
	else
		return param
	end
end

function NoNilN(param)
	if (param == nil) then
		return 0;
	else
		return param
	end
end

---------------------------------------------------------------------------------
--
-- Called by WoW when this add-on is loaded.  Register for events we are interested in.
-- 
---------------------------------------------------------------------------------
function GuildML_OnLoad()
	DEBUG_MSG("[GuildML_ONLOAD]");

	-- Slash commands
	SlashCmdList["GML"] = GuildML_SlashHandler;
	SLASH_GML1 = "/guildmaillist";
	SLASH_GML2 = "/gml";
	
    this:RegisterEvent("GUILD_ROSTER_UPDATE");
    this:RegisterEvent("MAIL_FAILED");
    this:RegisterEvent("MAIL_CLOSED");
    this:RegisterEvent("MAIL_SEND_SUCCESS");
    
    -- the structure to store the outgoing mail queue
    GuildML_MailQueue = { };
    GuildML_MailQueue.Body = "";
    GuildML_MailQueue.Subject = "";
    GuildML_MailQueue.Recipients = { };
        
    GuildML_SendingMail = false;
	GuildML_Exported	= false;

	GuildML_AppName		= GuildML_TITLE .. "  V" .. GuildML_GetVersionAsString();

	GuildML_SendLevel	= 3; 	
	GuildML_YourLevel	= 99; 
	GuildRoster();
    
    -- hook the sendMail function so we can take it over to do our bidding
    GuildML_HookSendMail(true); 
end

---------------------------------------------------------------------------------
--
-- Some new Functions from Omicron @ Frostwolf, for Export your mails.
-- 
---------------------------------------------------------------------------------
function GuildML_MakeMyTime()
	local hour, minute = GetGameTime();
	GuildML_Time = tostring(hour)..":"..tostring(minute);
	return tostring(GuildML_Time);
end

function GuildML_ExportMyML()
	-- 
	local GuildML_Time = GuildML_MakeMyTime();
	-- 
	GuildMLSendExport = { };
	GuildMLSendExport[GuildML_Time] = GuildML_tablecopy(GuildML_MailQueue);
	-- 
end

function GuildML_tablecopy(tbl)
	if type(tbl) ~= "table" then
		return tbl
	end
	local t = {}
	for i,v in pairs(tbl) do
		t[i] = GuildML_tablecopy(v)
	end
	table.setn(t, table.getn(tbl))
	return setmetatable(t, GuildML_tablecopy(getmetatable(tbl)))
end

---------------------------------------------------------------------------------/
--
-- GetVersionAsString
-- 
---------------------------------------------------------------------------------
function GuildML_GetVersionAsString()
	local addThis;
	local major = floor(GuildML_VERSION);
	local minor = floor((GuildML_VERSION - major)*10 + 0.5);
	if minor>0 then
		local minorToString = {
			[1] = "Alpha",
			[2] = "Beta",
			[3] = "Beta 2",
			[4] = "Beta 3",
			[5] = "Beta 4",
			[6] = "Beta 5",
			[7] = "RC 1",
			[8] = "RC 2",
			[9] = "RC 3"
		}
		addThis = " "..minorToString[minor];
	else
		addThis = "";
	end
	return string.format("%0.2f", major/100)..addThis;
end

---------------------------------------------------------------------------------
--
-- Set the timeout for sending mail
-- 
---------------------------------------------------------------------------------
function GuildMLM_SetTimeout(theSecs)
    if (theSecs == nil or tonumber(theSecs) == nil) then
        ChatFrame1:AddMessage(GuildML_TITLE..GuildML_tSet3, 1.0, 1.0, 0.5);
        return
    end

    theSeconds = tonumber(theSecs);
    if ((theSeconds > 0) and (theSeconds < 60)) then
        GuildML_TIMEOUT = theSeconds;
        ChatFrame1:AddMessage(GuildML_TITLE..GuildML_tSet1..theSeconds..GuildML_tSet2, 1.0, 1.0, 0.5);
    else
        ChatFrame1:AddMessage(GuildML_TITLE..GuildML_tSet3, 1.0, 1.0, 0.5);
    end
end

----------------------------------------------------------------------------------
--
-- Called by /gmm
-- 
---------------------------------------------------------------------------------

function GuildML_SlashHandler(msg)
	iStart, iEnd, command = string.find(msg, "(%w+)( ?)");
	if (iEnd) then
		param = string.sub(msg, iEnd+1)
	else
		param = "";
	end
	
	if (msg == "") then
		GuildML_ShowHelp();
	elseif (command == "version") then
		ChatFrame1:AddMessage(GuildML_TITLE.." Version: "..NoNil(GuildML_GetVersionAsString()));
	elseif (command == "help") then
		GuildML_ShowHelp();
	elseif (command == "reset") then
		ChatFrame1:AddMessage("Resetting", 1.0, 1.0, 0.5);
		GuildMLFrame_MinLevel:SetText("");
		GuildMLFrame_MaxLevel:SetText("");
		GuildMLFrame_LastOn:SetText("");
		GuildRoster();
		UIDropDownMenu_SetSelectedValue(GuildMLFrame_Class,"All");
		UIDropDownMenu_SetSelectedValue(GuildMLFrame_Rank_Qualifier,"<=");
		UIDropDownMenu_SetSelectedValue(GuildMLFrame_Rank, "All");
	elseif (command == "reload") then
		ChatFrame1:AddMessage("Resetting UI", 1.0, 1.0, 0.5);
		ReloadUI();
    elseif (command == "timeout") then
           GuildML_SetTimeout(var);
	elseif (command == "debug") then
		GuildML_DEBUG = true;
		DEBUG_MSG("Debuging turned on");
	elseif (command == "nodebug") then
		GuildML_DEBUG = false;
		DEBUG_MSG("Debuging turned off");
	elseif (command == "settings") then
		ChatFrame1:AddMessage(GuildML_TITLE.." Version: "..NoNil(GuildML_GetVersionAsString()), 1.0, 1.0, 0.5);
		if (GuildML_DEBUG) then
			ChatFrame1:AddMessage("Debug = On", 1.0, 1.0, 0.5);
		else
			ChatFrame1:AddMessage("Debug = Off", 1.0, 1.0, 0.5);
		end
		ChatFrame1:AddMessage("Send RLevel = "..GuildML_SendLevel, 1.0, 1.0, 0.5);
		ChatFrame1:AddMessage("Your RLevel = "..GuildML_YourLevel, 1.0, 1.0, 0.5);
		ChatFrame1:AddMessage("Timeout = "..GuildML_TIMEOUT, 1.0, 1.0, 0.5);
	end
end

----------------------------------------------------------------------------------
--
-- Toggle hidden status of import frame
-- 
---------------------------------------------------------------------------------

function GuildML_Toggle() 
	DEBUG_MSG("[GuildML_Toggle]");
	if ( GuildMLFrame:IsVisible() ) then
		GuildMLFrame:Hide();
	else
		if (GuildML_YourLevel == 99) and (IsInGuild()) then
			GuildRoster();
			GuildML_WhoCanSend();
		end;
		GuildML_Count("count");		
		GuildMLFrame:Show();
	end
end

-----------------------------------------------------------------------------------
--
-- Count or Save the mailing list
--
-----------------------------------------------------------------------------------

function GuildML_Count(mode)
	-- First empty the last array
	local recipCount = table.getn(GuildML_MAILINGLISTS);
	for j=1, recipCount, 1 do
		local memberNamej = GuildML_MAILINGLISTS[1];
		table.remove(GuildML_MAILINGLISTS, 1);
	end;
		
	local min, max, laston, rank, pass;
	
	DEBUG_MSG("[GuildML_Count] Mode: ".. mode);

	if string.len(GuildMLFrame_MinLevel:GetText()) > 0 then
		min = tonumber(GuildMLFrame_MinLevel:GetText());
	else
		min = 0;
	end

	rank = tonumber(UIDropDownMenu_GetSelectedValue(GuildMLFrame_Rank));

	if string.len(GuildMLFrame_MaxLevel:GetText()) > 0 then
		max = tonumber(GuildMLFrame_MaxLevel:GetText());
	else
		max = 90;
	end
	if string.len(GuildMLFrame_LastOn:GetText()) > 0 then
		laston = tonumber(GuildMLFrame_LastOn:GetText());
	else
		laston = 180;
	end

	local cnt = 0
	if UIDropDownMenu_GetSelectedValue(GuildMLFrame_Dlv) == 'Guild' then
		local MemberCount = GetNumGuildMembers(true);
		DEBUG_MSG("[Total Guild Members: ".. MemberCount.."]");
		for i=1, MemberCount, 1 do
			local MemberName, MemberRank, MemberRankIndex, MemberLevel, MemberClass, MemberZone, MemberNote, MemberOfficerNote, MemberIsOnline, MemberStatus = GetGuildRosterInfo(i);
			local yearsOffline, monthsOffline, daysOffline, hoursOffline = GetGuildRosterLastOnline(i); 
			local totalday = 0;
			pass = 0;
			if monthsOffline ~= nul then
				totalday = totalday + (monthsOffline * 30);
			end;
			if daysOffline ~= nul then
				totalday = totalday + (daysOffline);
			end;
			-- Dont send to self...
			if (MemberName ~= UnitName("player")) then
				DEBUG_MSG("passed self");
				-- Don't spam members with "GMLNOSPAM" in thier note.
				spamMe = DEBUG_MSG( "find " .. NoNil(string.find(MemberNote,"GMLNOSPAM")));
				if ( string.find(MemberNote,"GMLNOSPAM") == nil) then
					DEBUG_MSG("passed nospam");
					-- If All Is Selected or the correct class is selected.
					if ( UIDropDownMenu_GetSelectedValue(GuildMLFrame_Class) == MemberClass) or (UIDropDownMenu_GetSelectedValue(GuildMLFrame_Class) == 'All') then
						DEBUG_MSG("passed class");
						--if they meet the lvl requirements
						if (MemberLevel >= min) and (MemberLevel <= max) then
							DEBUG_MSG("passed lvl req");
							-- If they meet the last on requirements
							if (totalday <= laston) then
								DEBUG_MSG("passed laston");
								-- So far so good, now check Rank
								DEBUG_MSG("MemberRank: " .. MemberRankIndex .. ": SelectedRank: " .. NoNil(rank) .. "Qualifier: " .. UIDropDownMenu_GetSelectedValue(GuildMLFrame_Rank_Qualifier) );
								if ( UIDropDownMenu_GetSelectedValue(GuildMLFrame_Rank) == "All") then
									pass = 1;
								elseif ((UIDropDownMenu_GetSelectedValue(GuildMLFrame_Rank_Qualifier) == ">=") and MemberRankIndex <= (rank -1) ) then
									pass = 1;
								elseif ((UIDropDownMenu_GetSelectedValue(GuildMLFrame_Rank_Qualifier) == "==") and MemberRankIndex == (rank -1) ) then
									pass = 1;
								elseif ((UIDropDownMenu_GetSelectedValue(GuildMLFrame_Rank_Qualifier) == "<=") and MemberRankIndex >= (rank -1) ) then
									pass = 1;
								end			
							end
						end		
					end		
				end
			end

			if (pass == 1) then
				cnt = cnt + 1;
				table.insert( GuildML_MAILINGLISTS, MemberName);
			end
		end
	else
		local MemberCount = GetNumFriends(true);
		DEBUG_MSG("[Total Friends: ".. MemberCount.."]");
		for i=1, MemberCount, 1 do
			SetSelectedFriend(i);
			local MemberName, MemberLevel, MemberClass, MemberZone, MemberIsOnline = GetFriendInfo(i);
			DEBUG_MSG("[Info] Name: ".. MemberName.." Level: ".. MemberLevel.." Class: ".. MemberClass);

			if (UIDropDownMenu_GetSelectedValue(GuildMLFrame_Class) == MemberClass) or (UIDropDownMenu_GetSelectedValue(GuildMLFrame_Class) == 'All') then
				pass = 1;
			else
				pass = 0;
			end;
			if (MemberLevel >= min) and (MemberLevel <= max) and (pass == 1) then
				pass = 1;
			else
				pass = 0;
			end;
			DEBUG_MSG("[Pass/Fail] ".. pass);

			if (pass == 1) then
				cnt = cnt + 1;
				table.insert( GuildML_MAILINGLISTS, MemberName);
			end
		end
	end
	if mode == 'Use' then
		DEBUG_MSG("[GuildML_Count - Use]");
	else
		local recipCount = table.getn(GuildML_MAILINGLISTS);
		DEBUG_MSG("[GuildML_Count - Count]");
		for j=1, recipCount, 1 do
			local memberNamej = GuildML_MAILINGLISTS[j];
			--DEBUG_MSG("Will Send to "..memberNamej);
		end;
		
		local copper = cnt * 30;
		local gold = math.floor(copper/10000);
		copper = copper - (gold * 10000);
		local silver = math.floor(copper/100)
		copper = copper - (silver * 100);
		ChatFrame1:AddMessage(GuildML_tNumCount	.. cnt, 1.0, 1.0, 0.5);
		ChatFrame1:AddMessage(GuildML_tCost .. " " .. gold .."g "..silver.."s "..copper.."c", 1.0, 1.0, 0.5);
		GuildMLFrame_price:SetText(GuildML_tsNumCount .. cnt .. " " .. GuildML_tsCost .. " " .. gold .."g "..silver.."s "..copper.."c")
	end;
end

-----------------------------------------------------------------------------------
--
-- Class Pull Down Functions
--
-----------------------------------------------------------------------------------

function GuildML_Class_OnLoad()
	UIDropDownMenu_Initialize(this, GuildML_Class_Init);
	UIDropDownMenu_SetWidth(160, this);
	UIDropDownMenu_SetSelectedValue(this, "All");
end
function GuildML_Class_Init()
	for id, name in GuildML_CLASSES do
		UIDropDownMenu_AddButton {value = name , text = name , func = GuildML_Class_OnClick}
	end
end	
function GuildML_Class_OnClick()
	UIDropDownMenu_SetSelectedValue(GuildMLFrame_Class, this.value);
end

-----------------------------------------------------------------------------------
--
-- Guild Rank Qualifier Pull Down Functions
--
-----------------------------------------------------------------------------------
function GuildML_Rank_Qualifier_OnLoad()
	DEBUG_MSG("Rank Qualifier onLoad");
	UIDropDownMenu_Initialize(this, GuildML_Rank_Qualifier_Init);
	UIDropDownMenu_SetWidth(40, this);
	UIDropDownMenu_SetSelectedValue(this, "<=");
	-- Disable the qualifier until we have a rank selected.
	getglobal(this:GetName().."Button"):Disable();
	DEBUG_MSG("To Disable use name "..this:GetName());
end
function GuildML_Rank_Qualifier_Init()
	DEBUG_MSG("Rank Qualifier Init");
	for id, name in GuildML_RANK_QUALIFIER do
		DEBUG_MSG("Adding " .. name .. " to dropdown" );
		UIDropDownMenu_AddButton {value = name , text = name , func = GuildML_RANK_QUALIFIER_OnClick}
	end
end
function GuildML_RANK_QUALIFIER_OnClick()
	DEBUG_MSG("Rank Qualifier OnClicked " .. this.value );
	UIDropDownMenu_SetSelectedValue(GuildMLFrame_Rank_Qualifier, this.value);
end

-----------------------------------------------------------------------------------
--
-- Guild Rank Pull Down Functions
--
-----------------------------------------------------------------------------------

function GuildML_Rank_OnLoad()
	DEBUG_MSG("[Rank onLoad]");
	UIDropDownMenu_Initialize(this, GuildML_Rank_Init)
	UIDropDownMenu_SetWidth(105, this)
	UIDropDownMenu_SetSelectedValue(this, "All");
	-- Disable rank until Guild has been chosen from the dropdown.
	getglobal(this:GetName().."Button"):Disable();
end
function GuildML_Rank_Init()
	DEBUG_MSG("[Rank Init]");
	UIDropDownMenu_AddButton {value = "All" , text = "All", func = GuildML_Rank_OnClick}
	for i=GuildControlGetNumRanks(), 1, -1 do
		UIDropDownMenu_AddButton {value = i , text = GuildControlGetRankName(i) , func = GuildML_Rank_OnClick}
	end;
end	
function GuildML_Rank_OnClick()
	DEBUG_MSG("[Rank OnClick]");
	UIDropDownMenu_SetSelectedValue(GuildMLFrame_Rank, this.value);
	if ( this.value == "All" ) then
		getglobal("GuildMLFrame_Rank_Qualifier".."Button"):Disable();
	else
		getglobal("GuildMLFrame_Rank_Qualifier".."Button"):Enable();
	end
end


-----------------------------------------------------------------------------------
--
-- Delivery Pull Down Functions
--
-----------------------------------------------------------------------------------

function GuildML_Dlv_OnLoad()
	UIDropDownMenu_Initialize(this, GuildML_Dlv_Init)
	UIDropDownMenu_SetWidth(128, this)
	if 	GuildML_SendLevel >= GuildML_YourLevel then
		UIDropDownMenu_SetSelectedValue(this, "Guild");
	else
		UIDropDownMenu_SetSelectedValue(this, "Friends");
	end
end
function GuildML_Dlv_Init()
	DEBUG_MSG(GuildML_SendLevel..">="..GuildML_YourLevel);
	if 	GuildML_SendLevel >= GuildML_YourLevel then
		UIDropDownMenu_AddButton {value = "Guild" , text = "Guild", func = GuildML_Dlv_OnClick}
	end
	UIDropDownMenu_AddButton {value = "Friends" , text = "Friends", func = GuildML_Dlv_OnClick}
end	
function GuildML_Dlv_OnClick()
	UIDropDownMenu_SetSelectedValue(GuildMLFrame_Dlv, this.value);
	if ( this.value == "Guild" ) then
		getglobal("GuildMLFrame_Rank".."Button"):Enable();
	else
		getglobal("GuildMLFrame_Rank".."Button"):Disable();
	end
end

--------------------------------------------------------------------------------
--
-- Show the tooltip text
-- 
---------------------------------------------------------------------------------
function GuildML_ShowTooltip(theText1, theText2, theText3, theText4, theText5)

	DEBUG_MSG("[GuildML_ShowTooltip]");
    -- Set the anchor and text for the tooltip.
    GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
    GameTooltip:SetText(theText1);
    
    if (theText2) then
        GameTooltip:AddLine(theText2);
    end
    if (theText3) then
        GameTooltip:AddLine(theText3);
    end
    if (theText4) then
        GameTooltip:AddLine(theText4);
    end
    if (theText5) then
        GameTooltip:AddLine(theText5);
    end

    GameTooltip:Show();
end

---------------------------------------------------------------------------------
--
-- Hook us onto the original sendmail() function
-- 
---------------------------------------------------------------------------------
function GuildML_HookSendMail(toggle)
	DEBUG_MSG("[GuildML_HookSendMail]");

    if (toggle) then
        GuildML_SendMail_Orig = SendMailFrame_SendMail;
        SendMailFrame_SendMail = GuildML_SendMail;
    else
        SendMailFrame_SendMail = GuildML_SendMail_Orig;
        GuildML_SendMail_Orig = nil;
    end
end

-----------------------------------------------------------------------------------
--
-- Overloads the original SendMailFrame_SendMail() function
--
-----------------------------------------------------------------------------------
function GuildML_SendMail()
	DEBUG_MSG("[GuildML_SendMail]");

    if (SendMailNameEditBox:GetText() == "Mailing List") then
		DEBUG_MSG("[Sending List]");
        GuildML_MailQueue = { };
        GuildML_MailQueue.Body = SendMailBodyEditBox:GetText();
        GuildML_MailQueue.Subject = SendMailSubjectEditBox:GetText();
        GuildML_MailQueue.Recipients = GuildML_MAILINGLISTS;
	    
        DEBUG_MSG("GuildML_MailQueue = "..asText(GuildML_MailQueue));
        GuildML_MailQueueFrameCounter = 1;      
        GuildML_SendingMail = true;
        GuildML_ReadyToSendNextMessage = true;
        GuildML_TimeLastMailSent = GetTime();
        ChatFrame1:AddMessage(GuildML_TITLE..GuildML_sendTxt1..GuildML_MailQueue.Subject..GuildML_sendTxt2, 1.0, 1.0, 0.5);
		-- 
		if not GuildML_Exported then
			GuildML_ExportMyML();
			GuildML_Exported = true;
		end
		-- 
    else
		DEBUG_MSG("[Normal Send]");
        GuildML_SendMail_Orig(SendMailNameEditBox:GetText(), SendMailSubjectEditBox:GetText(), SendMailBodyEditBox:GetText());
    end
end

-----------------------------------------------------------------------------------
--
-- Finds out what guild level the player is and also what the GM set as the level
--
-----------------------------------------------------------------------------------

function GuildML_WhoCanSend()
	DEBUG_MSG("[GuildML_WhoCanSend]")
	if (GuildML_YourLevel == 99) and (IsInGuild()) then
		local MemberCount = GetNumGuildMembers(true);
		local spot = 0
		while IsInGuild() and (MemberCount == 0) and (spot < 5000) do
			spot = spot + 1;
			MemberCount = GetNumGuildMembers(true);
		end
		spot = 0;
		for i=1, MemberCount, 1 do
			local MemberName, MemberRank, MemberRankIndex, MemberLevel, MemberClass, MemberZone, MemberNote, MemberOfficerNote, MemberIsOnline, MemberStatus = GetGuildRosterInfo(i);
			if (MemberName == UnitName("player")) then
				GuildML_YourLevel = MemberRankIndex;
			end
			spot = NoNilN(string.find(MemberOfficerNote,"GML"));
			if (MemberRankIndex == 1) and spot > 0 then
				GuildML_SendLevel = string.sub(MemberOfficerNote,spot+3);
				GuildML_SendLevel = string.sub(GuildML_SendLevel,1,string.find(GuildML_SendLevel,string.char(93))-1);
				GuildML_SendLevel = tonumber(GuildML_SendLevel);
			end
		end
	end
	DEBUG_MSG("[Your Level] "..GuildML_YourLevel);
	DEBUG_MSG("[Send Level] "..GuildML_SendLevel);
end

-----------------------------------------------------------------------------------
--
-- Debug function to view any lua object as text
--
-----------------------------------------------------------------------------------
function asText(obj)

    visitRef = {}
    visitRef.n = 0

    asTxRecur = function(obj, asIndex)
        if type(obj) == "table" then
            if visitRef[obj] then
                return "@"..visitRef[obj]
            end
            visitRef.n = visitRef.n +1
            visitRef[obj] = visitRef.n

            local begBrac, endBrac
            if asIndex then
                begBrac, endBrac = "[{", "}]"
            else
                begBrac, endBrac = "{", "}"
            end
            local t = begBrac
            local k, v = nil, nil
            repeat
                k, v = next(obj, k)
                if k ~= nil then
                    if t > begBrac then
                        t = t..", "
                    end
                    t = t..asTxRecur(k, 1).."="..asTxRecur(v)
                end
            until k == nil
            return t..endBrac
        else
            if asIndex then
                -- we're on the left side of an "="
                if type(obj) == "string" then
                    return obj
                else
                    return "["..obj.."]"
                end
            else
                -- we're on the right side of an "="
                if type(obj) == "string" then
                    return '"'..obj..'"'
                else
                    return tostring(obj)
                end
            end
        end
    end -- asTxRecur

    return asTxRecur(obj)
end -- asText

---------------------------------------------------------------------------------
--
-- Show the help msg for gml
-- 
---------------------------------------------------------------------------------

function GuildML_ShowHelp()
    ChatFrame1:AddMessage(GuildML_tHelp, 1.0, 1.0, 0.5);
end

-----------------------------------------------------------------------------------
--
-- Checks for events 
--
-----------------------------------------------------------------------------------
function GuildML_OnEvent(event)
    if (event == "MAIL_SEND_SUCCESS") then
        DEBUG_MSG("[GuildML_OnEvent] Got MAIL_SEND_SUCCESS!");
        if (GuildML_SendingMail) then
            DEBUG_MSG("[GuildML_OnEvent] Successfully sent message \""..GuildML_MailQueue.Subject.."\" to "..GuildML_LastAttempedRecipient.."...");
            GuildML_TimeLastMailSent = GetTime();
			GuildML_LastSuccessfulRecipient = GuildML_LastAttempedRecipient;
        end
        GuildML_ReadyToSendNextMessage = true;
	elseif (event == "MAIL_FAILED") then
        DEBUG_MSG("[GuildML_OnEvent] Got MAIL_FAILED!");
        if (GuildML_SendingMail and (GuildML_LastSuccessfulRecipient ~= GuildML_LastAttempedRecipient and GuildML_LastAttempedRecipient ~= UnitName("player") )) then
			ChatFrame1:AddMessage(GuildML_TITLE..GuildML_sendFail1..GuildML_MailQueue.Subject..GuildML_sendFail2..GuildML_LastAttempedRecipient..GuildML_sendFail3, 1.0, 0.0, 0.0);
            GuildML_TimeLastMailSent = GetTime();       
        end
        GuildML_ReadyToSendNextMessage = true;
	elseif (event == "MAIL_CLOSED") then
        DEBUG_MSG("[GuildML_OnEvent] Got MAIL_CLOSED!");
        GuildMLFrame:Hide();
	elseif (event == "GUILD_ROSTER_UPDATE") then
        DEBUG_MSG("[GuildML_OnEvent] Got GUILD_ROSTER_UPDATE!");
		GuildML_WhoCanSend();
    end
end

-----------------------------------------------------------------------------------
--
-- Update
--
-----------------------------------------------------------------------------------
function GuildML_OnUpdate()
	if (GuildML_SendingMail) then
		if (table.getn(GuildML_MailQueue.Recipients) > 0) then
			if (GuildML_ReadyToSendNextMessage) then
				GuildML_MailQueueFrameCounter = math.mod(GuildML_MailQueueFrameCounter + 1, 30);
				if (GuildML_MailQueueFrameCounter == 0) then
					GuildML_SendNextMessage();
				end
			elseif (GetTime() - GuildML_TimeLastMailSent > GuildML_TIMEOUT) then
				GuildML_TimeOutMessageSend();
			end
		elseif (GuildML_ReadyToSendNextMessage) then
			GuildML_SendingMail = false;
            ChatFrame1:AddMessage(GuildML_TITLE..GuildML_UpdTxt1..GuildML_MailQueue.Subject..">", 1.0, 1.0, 0.5);
		end
	end
	
end


---------------------------------------------------------------------------------
--
-- Handle when a message times out trying to send
-- 
---------------------------------------------------------------------------------
function GuildML_TimeOutMessageSend()
    ChatFrame1:AddMessage(GuildML_TITLE..GuildML_sendFail1..GuildML_MailQueue.Subject..GuildML_sendFail2..GuildML_LastAttempedRecipient..GuildML_sendFail3, 1.0, 0.0, 0.0);
    GuildML_SendNextMessage();
end

-----------------------------------------------------------------------------------
--
-- Send the next message in the outgoing queue
--
-----------------------------------------------------------------------------------
function GuildML_SendNextMessage()
    GuildML_ReadyToSendNextMessage = false;
    GuildML_LastAttempedRecipient = GuildML_MailQueue.Recipients[1];
    table.remove(GuildML_MailQueue.Recipients, 1);
	ChatFrame1:AddMessage(GuildML_sendStatus.. GuildML_LastAttempedRecipient, 1.0, 1.0, 0.5);
    SendMail(GuildML_LastAttempedRecipient, GuildML_MailQueue.Subject, GuildML_MailQueue.Body);
end

