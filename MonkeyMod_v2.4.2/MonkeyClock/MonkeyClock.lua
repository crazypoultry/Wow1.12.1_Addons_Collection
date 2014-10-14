--[[

MonkeyClock
A simplified and modified version of:

	Clock: a simple in-game clock window
		copyright 2004 by Telo

	- Displays the time in a small, movable window
	- Displays time-based character information in a tooltip on mouseover

]]

-- define the dialog box for reseting config
StaticPopupDialogs["MONKEYCLOCK_RESET"] = {
	text = TEXT(MONKEYCLOCK_CONFIRM_RESET),
	button1 = TEXT(OKAY),
	button2 = TEXT(CANCEL),
	OnAccept = function()
		MonkeyClock_ResetConfig();
	end,
	timeout = 0,
	exclusive = 1
};

StaticPopupDialogs["MONKEYCLOCK_ALARM"] = {
	text = TEXT(MONKEYCLOCK_CONFIRM_ALARM),
	button1 = TEXT(MONKEYCLOCK_SNOOZE),
	button2 = TEXT(OKAY),
	OnAccept = function()
		MonkeyClock_AlarmSnooze();
	end,
	timeout = 0
};

-- Script array, not saved
MonkeyClock = {};
MonkeyClock.m_iDeltaTime = 0;
MonkeyClock.m_bLoaded = false;
MonkeyClock.m_strPlayer = "";
--MonkeyClock.m_iPrevHour, MonkeyClock.m_iPrevMinute = GetGameTime();

MonkeyClock.m_iPrevAlarmHour = nil;			-- used to prevent the alarm from ringing twice
MonkeyClock.m_iPrevAlarmMinute = nil;


function MonkeyClock_Init()
	-- double check that we are getting the player's name update
	if ((MonkeyClock.m_bLoaded == false) and (MonkeyClock.m_bVariablesLoaded == true)) then
		
		-- add the realm to the "player's name" for the config settings
		MonkeyClock.m_strPlayer = GetCVar("realmName") .. "|" .. MonkeyClock.m_strPlayer;
		
		-- Make sure MonkeyClockConfig is ready
		if (not MonkeyClockConfig) then
			MonkeyClockConfig = { };
		end
		
		-- Check if there's not an entry for this player
		if (not MonkeyClockConfig[MonkeyClock.m_strPlayer]) then
			MonkeyClockConfig[MonkeyClock.m_strPlayer] = {};
		end
		
		-- set the defaults
		if (MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bDisplay == nil) then
			MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bDisplay = true;
		end
		if (MonkeyClockConfig[MonkeyClock.m_strPlayer].m_iOffsetHour == nil) then
			MonkeyClockConfig[MonkeyClock.m_strPlayer].m_iOffsetHour = 0;
		end
		if (MonkeyClockConfig[MonkeyClock.m_strPlayer].m_iOffsetMinute == nil) then
			MonkeyClockConfig[MonkeyClock.m_strPlayer].m_iOffsetMinute = 0;
		end
		if (MonkeyClockConfig[MonkeyClock.m_strPlayer].m_fUpdateRate == nil) then
			MonkeyClockConfig[MonkeyClock.m_strPlayer].m_fUpdateRate = 1.0;
		end
		if (MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bNoBorder == nil) then
			MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bNoBorder = false;
		end
		if (MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bMilitaryTime == nil) then
			MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bMilitaryTime = false;
		end
		if (MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bLocked == nil) then
			MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bLocked = false;
		end
		if (MonkeyClockConfig[MonkeyClock.m_strPlayer].m_iAlarmHour == nil) then
			MonkeyClockConfig[MonkeyClock.m_strPlayer].m_iAlarmHour = 0;
		end
		if (MonkeyClockConfig[MonkeyClock.m_strPlayer].m_iAlarmMinute == nil) then
			MonkeyClockConfig[MonkeyClock.m_strPlayer].m_iAlarmMinute = 0;
		end
		if (MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bChatAlarm == nil) then
			MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bChatAlarm = false;
		end
		if (MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bDialogAlarm == nil) then
			MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bDialogAlarm = false;
		end

		-- show or hide the right options
		if (MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bDisplay == true) then
			MonkeyClockFrame:Show();
		else
			MonkeyClockFrame:Hide();
		end
		
		MonkeyClockFrame:SetBackdropColor(0.0, 0.0, 0.0, 0.0);
		if (MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bNoBorder == true) then
			MonkeyClockFrame:SetBackdropBorderColor(0.0, 0.0, 0.0, 0.0);
		else
			MonkeyClockFrame:SetBackdropBorderColor(1.0, 0.6901960784313725, 0.0, 1.0);
		end
		
		
		-- variables are loaded, ready to go
		MonkeyClock.m_bLoaded = true;

		if (DEFAULT_CHAT_FRAME) then
			DEFAULT_CHAT_FRAME:AddMessage(MONKEYCLOCK_LOADED);
		end
	end
end

-- OnLoad Function
function MonkeyClock_OnLoad()
	
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("UNIT_NAME_UPDATE");			-- this is the event I use to get per character config settings
	this:RegisterEvent("PLAYER_ENTERING_WORLD");	-- this event gives me a good character name in situations where "UNIT_NAME_UPDATE" doesn't even trigger

	-- register chat slash commands
	-- this command toggles the clock display
	SlashCmdList["MONKEYCLOCK_DISPLAY"] = MonkeyClockToggleDisplay;
	SLASH_MONKEYCLOCK_DISPLAY1 = "/monkeyclock";
	SLASH_MONKEYCLOCK_DISPLAY2 = "/mclock";
	
	-- this command sets the hour offset
	SlashCmdList["MONKEYCLOCK_HOUR"] = MonkeyClockSetHour;
	SLASH_MONKEYCLOCK_HOUR1 = "/monkeyclockhour";
	SLASH_MONKEYCLOCK_HOUR2 = "/mchour";
	
	-- this command sets the minute offset
	SlashCmdList["MONKEYCLOCK_MINUTE"] = MonkeyClockSetMinute;
	SLASH_MONKEYCLOCK_MINUTE1 = "/monkeyclockminute";
	SLASH_MONKEYCLOCK_MINUTE2 = "/mcminute";
	
	-- this command toggles the 24 hour clock
	SlashCmdList["MONKEYCLOCK_MILITARY"] = MonkeyClockToggle24;
	SLASH_MONKEYCLOCK_MILITARY1 = "/monkeyclocktoggle24";
	SLASH_MONKEYCLOCK_MILITARY2 = "/mctoggle24";
	
	-- this command toggles the border
	SlashCmdList["MONKEYCLOCK_BORDER"] = MonkeyClockToggleBorder;
	SLASH_MONKEYCLOCK_BORDER1 = "/monkeyclocktoggleborder";
	SLASH_MONKEYCLOCK_BORDER2 = "/mctoggleborder";
	
	-- this command toggles the lock
	SlashCmdList["MONKEYCLOCK_LOCK"] = MonkeyClockToggleLock;
	SLASH_MONKEYCLOCK_LOCK1 = "/monkeyclocktogglelock";
	SLASH_MONKEYCLOCK_LOCK2 = "/mctogglelock";

	-- Set the border colour
	MonkeyClockFrame:SetBackdropBorderColor(1.0, 0.6901960784313725, 0.0, 1.0);
end

-- OnEvent Function
function MonkeyClock_OnEvent(event)
	
	if (event == "VARIABLES_LOADED") then
		-- this event gets called whenever a unit's name changes (supposedly)
		--  Note: Sometimes it gets called when unit's name gets set to
		--  UNKNOWNOBJECT
		
		MonkeyClock.m_bVariablesLoaded = true;
		
		-- double check that we are getting the player's name update
		if (not MonkeyClock.m_bLoaded) then
			-- this is the first place I know that reliably gets the player name
			MonkeyClock.m_strPlayer = UnitName("player");
			
			-- if MonkeyClock.m_strPlayer is UNKNOWNOBJECT get out, need a real name
			if (MonkeyClock.m_strPlayer ~= nil and MonkeyClock.m_strPlayer ~= UNKNOWNOBJECT) then
				-- should have a valid player name here
				MonkeyClock_Init();
			end
		end
		
		-- exit this event
		return;
	end
	
	if (event == "UNIT_NAME_UPDATE") then
		-- this event gets called whenever a unit's name changes (supposedly)
		--  Note: Sometimes it gets called when unit's name gets set to
		--  UNKNOWNOBJECT
				
		-- double check that we are getting the player's name update
		if (arg1 == "player" and not MonkeyClock.m_bLoaded) then
			-- this is the first place I know that reliably gets the player name
			MonkeyClock.m_strPlayer = UnitName("player");
			
			-- if MonkeyClock.m_strPlayer is UNKNOWNOBJECT get out, need a real name
			if (MonkeyClock.m_strPlayer ~= nil and MonkeyClock.m_strPlayer ~= UNKNOWNOBJECT) then
				-- should have a valid player name here
				MonkeyClock_Init();
			end
		end
		
		-- exit this event
		return;
		
	end -- UNIT_NAME_UPDATE
	if (event == "PLAYER_ENTERING_WORLD") then
		-- this event gets called when the player enters the world
		--  Note: on initial login this event will not give a good player name
		
		-- double check that the mod isn't already loaded
		if (not MonkeyClock.m_bLoaded) then
			
			MonkeyClock.m_strPlayer = UnitName("player");
			
			-- if MonkeyClock.m_strPlayer is UNKNOWNOBJECT get out, need a real name
			if (MonkeyClock.m_strPlayer ~= nil and MonkeyClock.m_strPlayer ~= UNKNOWNOBJECT) then
				-- should have a valid player name here
				MonkeyClock_Init();
			end
		end
		
		-- exit this event
		return;
		
	end -- PLAYER_ENTERING_WORLD
end

-- OnUpdate Function
function MonkeyClock_OnUpdate(arg1)

	-- if the clock's not loaded yet, just exit
	if (not MonkeyClock.m_bLoaded) then
		return;
	end
	
	-- how long since the last update?
	MonkeyClock.m_iDeltaTime = MonkeyClock.m_iDeltaTime + arg1;
	
	-- is it time for an update?
	if (MonkeyClock.m_iDeltaTime > MonkeyClockConfig[MonkeyClock.m_strPlayer].m_fUpdateRate) then
		-- check the alarm
		MonkeyClock_AlarmCheck();

		-- Set the text for the clock
		MonkeyClockText:SetText(MonkeyClock_GetTimeText());
		MonkeyClock.m_iDeltaTime = 0;
	end
end

function MonkeyClock_AlarmCheck()
	if (MonkeyBuddyClockFrame) then
		if (MonkeyBuddyClockFrame:IsVisible()) then
			return;
		end
	end

	local	iAlarmHour = MonkeyClockConfig[MonkeyClock.m_strPlayer].m_iAlarmHour;
	local	iAlarmMinute = MonkeyClockConfig[MonkeyClock.m_strPlayer].m_iAlarmMinute;

	local	iHour, iMinute = GetGameTime();
	
	iHour = iHour + MonkeyClockConfig[MonkeyClock.m_strPlayer].m_iOffsetHour;
	iMinute = iMinute + MonkeyClockConfig[MonkeyClock.m_strPlayer].m_iOffsetMinute;
	
	-- fix up the hours and mins
	if (iMinute > 59) then
		iMinute = iMinute - 60;
		iHour = iHour + 1
	elseif (iMinute < 0) then
		iMinute = 60 + iMinute;
		iHour = iHour - 1;
	end
	if (iHour > 23) then
		iHour = iHour - 24;
	elseif (iHour < 0) then
		iHour = 24 + iHour;
	end


	-- considering the clock updates once every 1 second,
	-- this condition should always catch the alarm unless loading time interfers
	if ((iMinute == iAlarmMinute) and (iHour == iAlarmHour)) then
		if ((MonkeyClock.m_iPrevAlarmHour ~= iHour) or (MonkeyClock.m_iPrevAlarmMinute ~= iMinute)) then
			-- alarm hasn't rung yet
			MonkeyClock.m_iPrevAlarmHour = iHour;
			MonkeyClock.m_iPrevAlarmMinute = iMinute;

			if (MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bChatAlarm == true) then
				if (DEFAULT_CHAT_FRAME) then
					DEFAULT_CHAT_FRAME:AddMessage(MONKEYCLOCK_CONFIRM_ALARM .. "\n");
				end
			end
			
			if (MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bDialogAlarm == true) then
				StaticPopup_Show("MONKEYCLOCK_ALARM");
			end
		end
	end
end

function MonkeyClock_AlarmSnooze()
	local	iAlarmHour = MonkeyClockConfig[MonkeyClock.m_strPlayer].m_iAlarmHour;
	local	iAlarmMinute = MonkeyClockConfig[MonkeyClock.m_strPlayer].m_iAlarmMinute;

	iAlarmMinute = iAlarmMinute + 5;
	
	-- fix up the hours and mins
	if (iAlarmMinute > 59) then
		iAlarmMinute = iAlarmMinute - 60;
		iAlarmHour = iAlarmHour + 1
	elseif (iAlarmMinute < 0) then
		iAlarmMinute = 60 + iAlarmMinute;
		iAlarmHour = iAlarmHour - 1;
	end
	if (iAlarmHour > 23) then
		iAlarmHour = iAlarmHour - 24;
	elseif (iAlarmHour < 0) then
		iAlarmHour = 24 + iAlarmHour;
	end

	MonkeyClockConfig[MonkeyClock.m_strPlayer].m_iAlarmHour = iAlarmHour;
	MonkeyClockConfig[MonkeyClock.m_strPlayer].m_iAlarmMinute = iAlarmMinute;
end

-- when the mouse goes over the main frame, this gets called
function MonkeyClock_OnEnter()
	-- put the tool tip in the default position
	GameTooltip_SetDefaultAnchor(GameTooltip, this);
	
	-- set the tool tip text
	GameTooltip:SetText(MONKEYCLOCK_TITLE_VERSION, MONKEYLIB_TITLE_COLOUR.r, MONKEYLIB_TITLE_COLOUR.g, MONKEYLIB_TITLE_COLOUR.b, 1);
	GameTooltip:AddLine(MONKEYCLOCK_DESCRIPTION, GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b, 1);
	GameTooltip:Show();
end

function MonkeyClock_OnMouseDown(arg1)
	-- if not loaded yet then get out
	if (MonkeyClock.m_bLoaded == false) then
		return;
	end
	
	if (arg1 == "LeftButton" and MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bLocked == false) then
		MonkeyClockFrame:StartMoving();
	end
	
	-- right button on the title or frame opens up the MonkeyBuddy, if it's there
	if (arg1 == "RightButton") then
		if (MonkeyBuddyFrame ~= nil) then
			ShowUIPanel(MonkeyBuddyFrame);
			
			-- make MonkeyBuddy show the MonkeyClock config
			MonkeyBuddyClockTab_OnClick();
		end
	end
end

function MonkeyClock_OnMouseUp(arg1)
	-- if not loaded yet then get out
	if (MonkeyClock.m_bLoaded == false) then
		return;
	end
	
	if (arg1 == "LeftButton") then
		MonkeyClockFrame:StopMovingOrSizing();
	end
end

-- This function returns the time in a human readable string
function MonkeyClock_GetTimeText()
	local iHour, iMinute = GetGameTime();
	local bPM;
	
	-- offset the local time from server time
	iHour = iHour + MonkeyClockConfig[MonkeyClock.m_strPlayer].m_iOffsetHour;
	iMinute = iMinute + MonkeyClockConfig[MonkeyClock.m_strPlayer].m_iOffsetMinute;
	
	-- fix up the hours and mins
	if (iMinute > 59) then
		iMinute = iMinute - 60;
		iHour = iHour + 1
	elseif (iMinute < 0) then
		iMinute = 60 + iMinute;
		iHour = iHour - 1;
	end
	if (iHour > 23) then
		iHour = iHour - 24;
	elseif (iHour < 0) then
		iHour = 24 + iHour;
	end
	
	-- format the return string according to config settings
	if (MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bMilitaryTime) then
		return format(TEXT(TIME_TWENTYFOURHOURS), iHour, iMinute);
	else
		if (iHour >= 12) then
			bPM = 1;
			iHour = iHour - 12;
		else
			bPM = 0;
		end
		if (iHour == 0) then
			iHour = 12;
		end
		if (bPM == 1) then
			return format(TEXT(TIME_TWELVEHOURPM), iHour, iMinute);
		else
			return format(TEXT(TIME_TWELVEHOURAM), iHour, iMinute);
		end
	end
end

function MonkeyClockToggleDisplay()
	-- if not loaded yet then get out
	if (MonkeyClock.m_bLoaded == false) then
		return;
	end
	
	if (MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bDisplay) then
		MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bDisplay = false;
		MonkeyClockFrame:Hide();
	else
		MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bDisplay = true;
		MonkeyClockFrame:Show();
	end
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyClockFrame_Refresh ~= nil) then
		MonkeyBuddyClockFrame_Refresh();
	end
end

function MonkeyClockSetHour(msg)
	-- if not loaded yet then get out
	if (MonkeyClock.m_bLoaded == false) then
		return;
	end
	
	if (not(tonumber(msg, 10) == nil)) then
		MonkeyClockConfig[MonkeyClock.m_strPlayer].m_iOffsetHour = tonumber(msg, 10);
	end
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyClockFrame_Refresh ~= nil) then
		MonkeyBuddyClockFrame_Refresh();
	end
end

function MonkeyClockSetMinute(msg)
	-- if not loaded yet then get out
	if (MonkeyClock.m_bLoaded == false) then
		return;
	end
	
	if (not(tonumber(msg, 10) == nil)) then
		MonkeyClockConfig[MonkeyClock.m_strPlayer].m_iOffsetMinute = tonumber(msg, 10);
	end
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyClockFrame_Refresh ~= nil) then
		MonkeyBuddyClockFrame_Refresh();
	end
end

function MonkeyClockToggle24()
	-- if not loaded yet then get out
	if (MonkeyClock.m_bLoaded == false) then
		return;
	end
	
	MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bMilitaryTime = not MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bMilitaryTime;
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyClockFrame_Refresh ~= nil) then
		MonkeyBuddyClockFrame_Refresh();
	end
end

function MonkeyClockToggleBorder()
	-- if not loaded yet then get out
	if (MonkeyClock.m_bLoaded == false) then
		return;
	end	
	
	MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bNoBorder = not MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bNoBorder;
		
	if (MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bNoBorder == true) then
		MonkeyClockFrame:SetBackdropBorderColor(0.0, 0.0, 0.0, 0.0);
	else
		MonkeyClockFrame:SetBackdropBorderColor(1.0, 0.6901960784313725, 0.0, 1.0);
	end
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyClockFrame_Refresh ~= nil) then
		MonkeyBuddyClockFrame_Refresh();
	end
end

function MonkeyClockSlash_CmdOpen(bOpen)
	-- if not loaded yet then get out
	if (MonkeyClock.m_bLoaded == false) then
		return;
	end
	
	if (bOpen == true) then
		MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bDisplay = true;
		MonkeyClockFrame:Show();
	else
		MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bDisplay = false;
		MonkeyClockFrame:Hide();
	end
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyClockFrame_Refresh ~= nil) then
		MonkeyBuddyClockFrame_Refresh();
	end
end

function MonkeyClockSlash_CmdHideBorder(bHide)
	-- if not loaded yet then get out
	if (MonkeyClock.m_bLoaded == false) then
		return;
	end	
	
	MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bNoBorder = bHide;
		
	if (MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bNoBorder == true) then
		MonkeyClockFrame:SetBackdropBorderColor(0.0, 0.0, 0.0, 0.0);
	else
		MonkeyClockFrame:SetBackdropBorderColor(1.0, 0.6901960784313725, 0.0, 1.0);
	end
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyClockFrame_Refresh ~= nil) then
		MonkeyBuddyClockFrame_Refresh();
	end
end

function MonkeyClockSlash_CmdUseMilitaryTime(bMilitaryTime)
	-- if not loaded yet then get out
	if (MonkeyClock.m_bLoaded == false) then
		return;
	end
	
	MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bMilitaryTime = bMilitaryTime;
	
	MonkeyClockText:SetText(MonkeyClock_GetTimeText());

	-- check for MonkeyBuddy
	if (MonkeyBuddyClockFrame_Refresh ~= nil) then
		MonkeyBuddyClockFrame_Refresh();
	end
end

function MonkeyClockSlash_CmdSetHour(iOffsetHour)
	-- if not loaded yet then get out
	if (MonkeyClock.m_bLoaded == false) then
		return;
	end
	
	MonkeyClockConfig[MonkeyClock.m_strPlayer].m_iOffsetHour = iOffsetHour;
	
	MonkeyClockText:SetText(MonkeyClock_GetTimeText());

	-- check for MonkeyBuddy
	if (MonkeyBuddyClockFrame_Refresh ~= nil) then
		MonkeyBuddyClockFrame_Refresh();
	end
end

function MonkeyClockSlash_CmdSetMinute(iOffsetMinute)
	-- if not loaded yet then get out
	if (MonkeyClock.m_bLoaded == false) then
		return;
	end
	
	MonkeyClockConfig[MonkeyClock.m_strPlayer].m_iOffsetMinute = iOffsetMinute;
	
	MonkeyClockText:SetText(MonkeyClock_GetTimeText());

	-- check for MonkeyBuddy
	if (MonkeyBuddyClockFrame_Refresh ~= nil) then
		MonkeyBuddyClockFrame_Refresh();
	end
end

function MonkeyClockSlash_CmdSetAlarmHour(iAlarmHour)
	-- if not loaded yet then get out
	if (MonkeyClock.m_bLoaded == false) then
		return;
	end
	
	MonkeyClockConfig[MonkeyClock.m_strPlayer].m_iAlarmHour = iAlarmHour;

	-- check for MonkeyBuddy
	if (MonkeyBuddyClockFrame_Refresh ~= nil) then
		MonkeyBuddyClockFrame_Refresh();
	end
end

function MonkeyClockSlash_CmdSetAlarmMinute(iAlarmMinute)
	-- if not loaded yet then get out
	if (MonkeyClock.m_bLoaded == false) then
		return;
	end
	
	MonkeyClockConfig[MonkeyClock.m_strPlayer].m_iAlarmMinute = iAlarmMinute;

	-- check for MonkeyBuddy
	if (MonkeyBuddyClockFrame_Refresh ~= nil) then
		MonkeyBuddyClockFrame_Refresh();
	end
end

function MonkeyClockSlash_CmdUseChatAlarm(bChatAlarm)
	-- if not loaded yet then get out
	if (MonkeyClock.m_bLoaded == false) then
		return;
	end
	
	MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bChatAlarm = bChatAlarm;

	-- check for MonkeyBuddy
	if (MonkeyBuddyClockFrame_Refresh ~= nil) then
		MonkeyBuddyClockFrame_Refresh();
	end
end

function MonkeyClockSlash_CmdUseDialogAlarm(bDialogAlarm)
	-- if not loaded yet then get out
	if (MonkeyClock.m_bLoaded == false) then
		return;
	end
	
	MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bDialogAlarm = bDialogAlarm;

	-- check for MonkeyBuddy
	if (MonkeyBuddyClockFrame_Refresh ~= nil) then
		MonkeyBuddyClockFrame_Refresh();
	end
end

function MonkeyClockToggleLock()
	MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bLocked = not MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bLocked;
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyClockFrame_Refresh ~= nil) then
		MonkeyBuddyClockFrame_Refresh();
	end
end

function MonkeyClockSlash_CmdLock(bLocked)
	MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bLocked = bLocked;
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyClockFrame_Refresh ~= nil) then
		MonkeyBuddyClockFrame_Refresh();
	end
end

function MonkeyClockSlash_CmdReset()
	-- if not loaded yet then get out
	if (MonkeyClock.m_bLoaded == false) then
		return;
	end
	
	StaticPopup_Show("MONKEYCLOCK_RESET");
end

function MonkeyClock_ResetConfig()
	-- set the defaults
	MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bDisplay = true;
	MonkeyClockConfig[MonkeyClock.m_strPlayer].m_iOffsetHour = 0;
	MonkeyClockConfig[MonkeyClock.m_strPlayer].m_iOffsetMinute = 0;
	MonkeyClockConfig[MonkeyClock.m_strPlayer].m_fUpdateRate = 1.0;
	MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bNoBorder = false;
	MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bMilitaryTime = false;
	MonkeyClockConfig[MonkeyClock.m_strPlayer].m_bLocked = false;
	

	-- update the frame
	MonkeyClockFrame:ClearAllPoints();
	MonkeyClockFrame:SetPoint("TOP", "UIParent", "BOTTOMLEFT", 512, 384);

	MonkeyClockFrame:Show();
	MonkeyClockFrame:SetBackdropColor(0.0, 0.0, 0.0, 0.0);
	MonkeyClockFrame:SetBackdropBorderColor(1.0, 0.6901960784313725, 0.0, 1.0);
	
	MonkeyClockText:SetText(MonkeyClock_GetTimeText());

	-- check for MonkeyBuddy
	if (MonkeyBuddyClockFrame_Refresh ~= nil) then
		MonkeyBuddyClockFrame_Refresh();
	end
end