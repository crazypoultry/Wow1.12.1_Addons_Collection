
----------------------------------------------------------------------------------------------------------------
-- GLOBALS
----------------------------------------------------------------------------------------------------------------

-- DEFAULT VARS
ACW_DEFAULT_ON = 1;
ACW_DEFAULT_LOCKED = 1;
ACW_DEFAULT_OFFSET = 0;
ACW_DEFAULT_ALARMON = 0;
ACW_DEFAULT_ALARMHOUR = 0;
ACW_DEFAULT_ALARMMINUTE = 0;
ACW_DEFAULT_SNOOZETIME = 300;
ACW_DEFAULT_DAYNIGHTTEXT = 1;
ACW_ALARM_FONT_SIZE = 40;
ACW_ALARM_DURATION = 3.0;
ACW_REALARMTIME = 6.0;
ACW_SNOOZETIME = 120;
ACW_SET_SCALE = true;
ACW_CENTER_X = 6;
ACW_CENTER_Y = -6;

-- ALARM VARS
ACW_ALARM1_SNOOZING = 0;
ACW_ALARM2_SNOOZING = 0;
ACW_ALARM3_SNOOZING = 0;

ACW_ALARM1_SNOOZE_HOUR = 0;
ACW_ALARM2_SNOOZE_HOUR = 0;
ACW_ALARM3_SNOOZE_HOUR = 0;

ACW_ALARM1_SNOOZE_MINUTE = 0;
ACW_ALARM2_SNOOZE_MINUTE = 0;
ACW_ALARM3_SNOOZE_MINUTE = 0;

ACW_ALARM1_SNOOZE_TIME = 0;
ACW_ALARM2_SNOOZE_TIME = 0;
ACW_ALARM3_SNOOZE_TIME = 0;

ACW_ALARM1_ALARMED = 0;
ACW_ALARM2_ALARMED = 0;
ACW_ALARM3_ALARMED = 0;

ACW_ALARM1_SNOOZE_ALARMED=0;
ACW_ALARM2_SNOOZE_ALARMED=0;
ACW_ALARM3_SNOOZE_ALARMED=0;

ACW_ELAPSE_CTR1 = 0;
ACW_ELAPSE_CTR2 = 0;
ACW_ELAPSE_CTR3 = 0;

ACW_ACKNOWLEDGE_ALARM1 = 0;
ACW_ACKNOWLEDGE_ALARM2 = 0;
ACW_ACKNOWLEDGE_ALARM3 = 0;

ACW_FOUR_DIGITS = 3;

ACW_NIGHT = 0;
ACW_DAY = 1;
ACW_BLACK = 2;
ACW_DAY_NIGHT = ACW_DAY;
ACW_NIGHT_TEX = "Interface\\AddOns\\AlarmClockWrangler\\nightImg2.tga";
--ACW_NIGHT_TEX = "Interface\\AddOns\\AlarmClockWrangler\\dayImg7.tga";
ACW_DAY_TEX = "Interface\\AddOns\\AlarmClockWrangler\\dayImg7.tga";
ACW_BLACK_TEX = "Interface\\AddOns\\AlarmClockWrangler\\black.tga";

ACW_SLASH_ON = "on";
ACW_SLASH_OFF = "off";
ACW_SLASH_HELP = "help";
ACW_SLASH_LOCK = "lock";
ACW_SLASH_UNLOCK = "unlock";
ACW_SLASH_OFFSET_ERROR = "offset";
ACW_SLASH_OFFSET = "offset ";
ACW_SLASH_RESET = "reset";
ACW_SLASH_OPTIONS = "options";


ACW_REALM_NAME = "";
ACW_PLAYER_NAME= "";
ACW_SAVE_PREFIX = "";

--Scaling constants
ACW_SIZE_FRAME = 51;
ACW_SIZE_CIRCLE = 67;
ACW_SIZE_BG = 37;
ACW_SIZE_BG_TEX = 39;
ACW_SIZE_OPTIONS = 31;
ACW_SIZE_OPTIONS_BTN = 11;
ACW_SIZE_SNOOZE = 31;
ACW_SIZE_SNOOZE_BTN = 11;
ACW_SIZE_TEXT = 38;
ACW_SIZE_TEXT_FS = 38;
ACW_SIZE_MERIDIAN_FS = 38;
ACW_SIZE_FONT = 10;


local function dout(msg)
	if( DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(msg,1.0,0,0);
	end
end

----------------------------------------------------------------------------------------------------------------
-- UTILITY FUNCTIONS
----------------------------------------------------------------------------------------------------------------
function ACW_SetDayNightTextureUpdate(hour,minute)
	if (ACWOptions.daynighttex == 1) then
		-- Set the day/night texture
		local time = (hour * 60) + minute;
		if(time < GAMETIME_DAWN or time >= GAMETIME_DUSK) then -- night
			if (ACW_DAY_NIGHT ~= ACW_NIGHT) then
				-- Switch
				ACWDayNight:SetTexture(ACW_NIGHT_TEX);
				ACW_DAY_NIGHT = ACW_NIGHT;
			end
		else -- day
			if (ACW_DAY_NIGHT ~= ACW_DAY) then
				-- Switch
				ACWDayNight:SetTexture(ACW_DAY_TEX);
				ACW_DAY_NIGHT = ACW_DAY;
			end
		end
	else
		if (ACW_DAY_NIGHT ~= ACW_BLACK) then
			ACWDayNight:SetTexture(ACW_BLACK_TEX);
			ACW_DAY_NIGHT = ACW_BLACK;
		end
	end
end

function ACW_SetDayNightTexture()
	-- Get server time
	local hour, minute = GetGameTime();
	
	if (ACWOptions.daynighttex == 1) then
		local time = (hour * 60) + minute;
		if(time < GAMETIME_DAWN or time >= GAMETIME_DUSK) then -- night
			ACWDayNight:SetTexture(ACW_NIGHT_TEX);
			ACW_DAY_NIGHT = ACW_NIGHT;
		else -- day
			-- Switch
			ACWDayNight:SetTexture(ACW_DAY_TEX);
			ACW_DAY_NIGHT = ACW_DAY;
		end
	else
		ACWDayNight:SetTexture(ACW_BLACK_TEX);
		ACW_DAY_NIGHT = ACW_BLACK;
	end
end


function ACW_SlashCommand(msg)
	if (msg) then
		local command = string.lower(msg);
		if (command == "" or command == ACW_SLASH_HELP) then
			DEFAULT_CHAT_FRAME:AddMessage(ACW_HELP, 1.0, 1.0, 0.0);
		elseif (command == ACW_SLASH_ON) then
			ACWOptions.on = 1;
			ACW_Update();
			ACWOptions_Update(true);
			DEFAULT_CHAT_FRAME:AddMessage(ACW_ON, 1.0, 1.0, 0.0);
		elseif (command == ACW_SLASH_OFF) then
			ACWOptions.on = nil;
			ACW_Update();
			ACWOptions_Update(true);
			DEFAULT_CHAT_FRAME:AddMessage(ACW_OFF, 1.0, 1.0, 0.0);
		elseif (command == ACW_SLASH_RESET) then
			ACW_Reset();
			ACWOptions_Update(true);
			DEFAULT_CHAT_FRAME:AddMessage(ACW_RESET, 1.0, 1.0, 0.0);
		elseif (command == ACW_SLASH_OPTIONS) then
			ShowUIPanel(ACWOptionsFrame);
		else
			DEFAULT_CHAT_FRAME:AddMessage(ACW_UNKNOWN, 1.0, 0.0, 0.0);
		end
	end
end

function ACWSnooze()
	if (ACW_ALARM1_ALARMED == 1) then
		ACW_ALARM1_SNOOZING = 1;
		ACW_ALARM1_SNOOZE_HOUR, ACW_ALARM1_SNOOZE_MINUTE = GetGameTime();
		ACW_ALARM1_SNOOZE_TIME = 0;
		DEFAULT_CHAT_FRAME:AddMessage(ACW_SNOOZE..ACW_ALARM1.." "..ACW_SNOOZING, 1.0, 0.0, 0.0);
		ACW_ALARM1_ALARMED=0;
		ACW_ELAPSE_CTR1 = 0;
		ACW_ACKNOWLEDGE_ALARM1 = 1;
		ACWBlueButton:SetTexture("Interface\\AddOns\\AlarmClockWrangler\\greyLight.tga");
	end

	if (ACW_ALARM2_ALARMED == 1) then
		ACW_ALARM2_SNOOZING = 1;
		ACW_ALARM2_SNOOZE_HOUR, ACW_ALARM2_SNOOZE_MINUTE = GetGameTime();
		ACW_ALARM2_SNOOZE_TIME = 0;
		DEFAULT_CHAT_FRAME:AddMessage(ACW_SNOOZE..ACW_ALARM2.." "..ACW_SNOOZING, 1.0, 0.0, 0.0);
		ACW_ALARM2_ALARMED=0;
		ACW_ELAPSE_CTR2 = 0;
		ACW_ACKNOWLEDGE_ALARM2 = 1;
		ACWBlueButton:SetTexture("Interface\\AddOns\\AlarmClockWrangler\\greyLight.tga");
	end

	if (ACW_ALARM3_ALARMED == 1) then
		ACW_ALARM3_SNOOZING = 1;
		ACW_ALARM3_SNOOZE_HOUR, ACW_ALARM3_SNOOZE_MINUTE = GetGameTime();
		ACW_ALARM3_SNOOZE_TIME = 0;
		DEFAULT_CHAT_FRAME:AddMessage(ACW_SNOOZE..ACW_ALARM3.." "..ACW_SNOOZING, 1.0, 0.0, 0.0);
		ACW_ALARM3_ALARMED=0;
		ACW_ELAPSE_CTR3 = 0;
		ACW_ACKNOWLEDGE_ALARM3 = 1;
		ACWBlueButton:SetTexture("Interface\\AddOns\\AlarmClockWrangler\\greyLight.tga");
	end
end

function ACWAcknowledgeAlarm()
	if (ACW_ALARM1_ALARMED == 1 or ACW_ALARM1_SNOOZING == 1) then
		DEFAULT_CHAT_FRAME:AddMessage(ACW_SNOOZE..ACW_ALARM1.." "..ACW_ACKNOWLEDGED, 1.0, 0.0, 0.0);
		ACW_ALARM1_ALARMED=0;
		ACW_ALARM1_SNOOZING = 0;
		ACW_ACKNOWLEDGE_ALARM1 = 1;
		ACWSnoozeButton:Hide();
		ACWOptionsButton:Hide();
	end

	if (ACW_ALARM2_ALARMED == 1 or ACW_ALARM2_SNOOZING == 1) then
		DEFAULT_CHAT_FRAME:AddMessage(ACW_SNOOZE..ACW_ALARM2.." "..ACW_ACKNOWLEDGED, 1.0, 0.0, 0.0);
		ACW_ALARM2_ALARMED=0;
		ACW_ALARM2_SNOOZING = 0;
		ACW_ACKNOWLEDGE_ALARM2 = 1;
		ACWSnoozeButton:Hide();
		ACWOptionsButton:Hide();
	end

	if (ACW_ALARM3_ALARMED == 1 or ACW_ALARM3_SNOOZING == 1) then
		DEFAULT_CHAT_FRAME:AddMessage(ACW_SNOOZE..ACW_ALARM3.." "..ACW_ACKNOWLEDGED, 1.0, 0.0, 0.0);
		ACW_ALARM3_ALARMED=0;
		ACW_ALARM3_SNOOZING = 0;
		ACW_ACKNOWLEDGE_ALARM3 = 1;
		ACWSnoozeButton:Hide();
		ACWOptionsButton:Hide();
	end
end

function ACW_Update()
	if (ACWOptions) then
		if (ACWOptions.on) then
			ACWFrame:Show();
		else
			ACWFrame:Hide();
		end
	end
end

function ACW_Reset()
	ACWOptions.on = ACW_DEFAULT_ON;
	ACWOptions.locked = ACW_DEFAULT_LOCKED;
	ACWOptions.timeformat = ACW_DEFAULT_TIMEFORMAT;
	ACWOptions.offset = ACW_DEFAULT_OFFSET;
	ACWOptions[ACW_SAVE_PREFIX.."offset"] = ACWOptions.offset;
	ACWOptions.offsetminute = ACW_DEFAULT_OFFSET;
	ACWOptions[ACW_SAVE_PREFIX.."offsetminute"] = ACWOptions.offsetminute;
	--ACWFrame:ClearAllPoints();
	ACWFrame:SetPoint("TOPLEFT", "MinimapCluster", "TOPLEFT", 145, -19);

	ACWOptions.alarm1on = ACW_DEFAULT_ALARMON;
	ACWOptions.alarm2on = ACW_DEFAULT_ALARMON;
	ACWOptions.alarm3on = ACW_DEFAULT_ALARMON;
	
	ACWOptions.alarm1text = ACW_DEFAULT_ALARMTEXT;
	ACWOptions.alarm2text = ACW_DEFAULT_ALARMTEXT;
	ACWOptions.alarm3text = ACW_DEFAULT_ALARMTEXT;

	ACWOptions.alarm1hour = ACW_DEFAULT_ALARMHOUR;
	ACWOptions.alarm2hour = ACW_DEFAULT_ALARMHOUR;
	ACWOptions.alarm3hour = ACW_DEFAULT_ALARMHOUR;

	ACWOptions.alarm1minute = ACW_DEFAULT_ALARMMINUTE;
	ACWOptions.alarm2minute = ACW_DEFAULT_ALARMMINUTE;
	ACWOptions.alarm3minute = ACW_DEFAULT_ALARMMINUTE;

	ACWOptions.snoozetime = ACW_DEFAULT_SNOOZETIME;

	ACWOptions.daynighttex = ACW_DEFAULT_DAYNIGHTTEXT;

	ACWOptions.scale = 1.029999;
	ACW_SET_SCALE = true;

	ACW_ALARM1_SNOOZING = 0;
	ACW_ALARM2_SNOOZING = 0;
	ACW_ALARM3_SNOOZING = 0;

	ACW_ALARM1_SNOOZE_HOUR = 0;
	ACW_ALARM2_SNOOZE_HOUR = 0;
	ACW_ALARM3_SNOOZE_HOUR = 0;

	ACW_ALARM1_SNOOZE_MINUTE = 0;
	ACW_ALARM2_SNOOZE_MINUTE = 0;
	ACW_ALARM3_SNOOZE_MINUTE = 0;

	ACW_ALARM1_SNOOZE_TIME = 0;
	ACW_ALARM2_SNOOZE_TIME = 0;
	ACW_ALARM3_SNOOZE_TIME = 0;

	ACW_ALARM1_ALARMED = 0;
	ACW_ALARM2_ALARMED = 0;
	ACW_ALARM3_ALARMED = 0;

	ACW_ALARM1_SNOOZE_ALARMED=0;
	ACW_ALARM2_SNOOZE_ALARMED=0;
	ACW_ALARM3_SNOOZE_ALARMED=0;

	ACW_ELAPSE_CTR1 = 0;
	ACW_ELAPSE_CTR2 = 0;
	ACW_ELAPSE_CTR3 = 0;

	ACW_ACKNOWLEDGE_ALARMS = 0;

	ACWSnoozeButton:Hide();
	ACWOptionsButton:Hide();
	
	ACWOptions.xOffset = ACW_CENTER_X;
	ACWOptions.yOffset = ACW_CENTER_Y;
	
	ACWXSlider:SetValue(0);
	ACWYSlider:SetValue(0);
	
	ACWTextFrame:SetPoint("TOPLEFT","ACWFrame","TOPLEFT",ACWOptions.xOffset,ACWOptions.yOffset);

	ACW_Update();
end

function ACWAlarm(msg)
	UIErrorsFrame:AddMessage(msg, 1.0, 0.0, 0.0, 1.0, ACW_ALARM_DURATION);
	
	ACWBlueButton:SetTexture("Interface\\AddOns\\AlarmClockWrangler\\blueLight.tga");
	ACWSnoozeButton:Show();
	ACWOptionsButton:Show();
	PlaySoundFile("Interface\\AddOns\\AlarmClockWrangler\\bell.wav");
end

function ACWStatusTooltip()
	local statusStr1 = ACW_STATUS;
	local statusStr2 = ACW_CURRENTLY_ALARMING;
	local statusStr3 = ACW_CURRENTLY_SNOOZING;
	local statusStr4 = ACW_ALARM_STATUS;
	local statusStr5 = ACW_ALARM1..": ";
	local statusStr5a = "";
	local statusStr6 = ACW_ALARM2..": ";
	local statusStr6a = "";
	local statusStr7 = ACW_ALARM3..": ";
	local statusStr7a = "";
	local statusStr8 = ACW_SERVER_TIME_STATUS;
	local statusStr9 = ACW_TIME;
	local statusStr10 = ACW_TOD;

	local firstItem = true;

	if (ACW_ALARM1_ALARMED == 1) then
		statusStr2 = statusStr2..ACW_ALARM1;
		firstItem = false;
	end
	if (ACW_ALARM2_ALARMED == 1) then
		if (firstItem == false) then
			statusStr2 = statusStr2..", ";
		end
		statusStr2 = statusStr2..ACW_ALARM2;
		firstItem = false;
	end
	if (ACW_ALARM3_ALARMED == 1) then
		if (firstItem == false) then
			statusStr2 = statusStr2..", ";
		end
		statusStr2 = statusStr2..ACW_ALARM3;
		firstItem = false;
	end
	if (firstItem == true) then
		statusStr2 = statusStr2..ACW_NONE;
	end

	
	firstItem = true;
	if (ACW_ALARM1_SNOOZING == 1) then
		statusStr3 = statusStr3..ACW_ALARM1;
		firstItem = false;
	end
	if (ACW_ALARM2_SNOOZING == 1) then
		if (firstItem == false) then
			statusStr3 = statusStr3..", ";
		end
		statusStr3 = statusStr3..ACW_ALARM2;
		firstItem = false;
	end
	if (ACW_ALARM3_SNOOZING == 1) then
		if (firstItem == false) then
			statusStr3 = statusStr3..", ";
		end
		statusStr3 = statusStr3..ACW_ALARM3;
		firstItem = false;
	end
	if (firstItem == true) then
		statusStr3 = statusStr3..ACW_NONE;
	end


	local meridian1 = "";
	local meridian2 = "";
	local meridian3 = "";
	if (ACWOptions.timeformat == 24) then
		statusStr5a = statusStr5a.."("..ACWOptions.alarm1hour..":";
		statusStr6a = statusStr6a.."("..ACWOptions.alarm2hour..":";
		statusStr7a = statusStr7a.."("..ACWOptions.alarm3hour..":";
	else 
		local hour = ACWOptions.alarm1hour;
		
		if (hour > 12) then
			hour = hour -12;
			meridian1 = " PM";
		elseif (hour >= 12) then
			meridian1 = " PM";	
		elseif (hour == 0) then
			hour = 12;
			meridian1 = " AM";
		else
			meridian1 = " AM";
		end
		statusStr5a = statusStr5a.."("..hour..":";

		hour = ACWOptions.alarm2hour;
		
		if (hour > 12) then
			hour = hour -12;
			meridian2 = " PM";
		elseif (hour >= 12) then
			meridian2 = " PM";
		elseif (hour == 0) then
			hour = 12;
			meridian2 = " AM";
		else
			meridian2 = " AM";
		end
		statusStr6a = statusStr6a.."("..hour..":";

		hour = ACWOptions.alarm3hour;
		
		if (hour > 12) then
			hour = hour -12;
			meridian3 = " PM";
		elseif (hour >= 12) then
			meridian3 = " PM";
		elseif (hour == 0) then
			hour = 12;
			meridian3 = " AM";
		else
			meridian3 = " AM";
		end
		statusStr7a = statusStr7a.."("..hour..":";
	end

	local minuteStr = ""..ACWOptions.alarm1minute;
	if (ACWOptions.alarm1minute < 10) then -- pad
		minuteStr = "0"..minuteStr;
	end
	local onStr = ACW_STR_OFF;
	if (ACWOptions.alarm1on == 1) then
		onStr = ACW_STR_ON;
	end

	statusStr5 = statusStr5..onStr;
	statusStr5a = statusStr5a..minuteStr..meridian1..")";


	minuteStr = ""..ACWOptions.alarm2minute;
	if (ACWOptions.alarm2minute < 10) then -- pad
		minuteStr = "0"..minuteStr;
	end
	local onStr = ACW_STR_OFF;
	if (ACWOptions.alarm2on == 1) then
		onStr = ACW_STR_ON;
	end

	statusStr6 = statusStr6..onStr;
	statusStr6a = statusStr6a..minuteStr..meridian2..")";


	minuteStr = ""..ACWOptions.alarm3minute;
	if (ACWOptions.alarm3minute < 10) then -- pad
		minuteStr = "0"..minuteStr;
	end
	local onStr = ACW_STR_OFF;
	if (ACWOptions.alarm3on == 1) then
		onStr = ACW_STR_ON;
	end

	statusStr7 = statusStr7..onStr;
	statusStr7a = statusStr7a..minuteStr..meridian3..")";

	-- Check the time format option
	local hour, minute = GetGameTime();
	local time = (hour * 60) + minute;
	
	if(time < GAMETIME_DAWN or time >= GAMETIME_DUSK) then -- night
		statusStr10 = statusStr10..ACW_STR_NIGHT;
	else
		statusStr10 = statusStr10..ACW_STR_DAY;
	end
	
	
	if (ACWOptions.timeformat == 24) then
		statusStr9 = statusStr9.."("..format(TEXT(TIME_TWENTYFOURHOURS), hour, minute)..")";
	else
		local pm = 0;
		if (hour >= 12) then
			pm = 1;
		end
		if (hour > 12) then
			hour = hour - 12;
		end
		if (hour == 0) then
			hour = 12;
		end
		if (pm == 0) then
			statusStr9 = statusStr9.."("..string.gsub(string.sub(format(TEXT(TIME_TWELVEHOURAM), hour, minute),1,5)," ","").." AM"..")";
		else
			statusStr9 = statusStr9.."("..string.gsub(string.sub(format(TEXT(TIME_TWELVEHOURPM), hour, minute),1,5)," ","").." PM"..")";
		end
	end

	
	
	GameTooltip:SetOwner(this, "ANCHOR_NONE");

	local x,y = this:GetCenter();
	local xPos = 0;
	local yPos = 0;
	local anchor,relative;
	if( y  < GetScreenHeight() / 2 ) then
		anchor = "BOTTOM";
		relative = "TOP";
		yPos = yPos + 5;
	else
		anchor = "TOP";
		relative = "BOTTOM";
		yPos = yPos - 5;
	end	

	if( x < GetScreenWidth() / 2 ) then
		anchor = anchor.."LEFT";
		relative = relative.."LEFT";
	else
		anchor = anchor.."RIGHT";
		relative = relative.."RIGHT";
	end

	GameTooltip:SetPoint(anchor, "ACWTextFrame", relative, xPos,yPos );	

	GameTooltip:AddLine(statusStr1,1,1,1);
	GameTooltip:AddLine(statusStr2,0.72,0.2,0.2);
	GameTooltip:AddLine(statusStr3,0.84,0.42,0.19);
	GameTooltip:AddLine(statusStr4,0.29,0.52,0.72);
	GameTooltip:AddDoubleLine(statusStr5,statusStr5a,0.55,0.56,0.28,0.55,0.56,0.28);
	GameTooltip:AddDoubleLine(statusStr6,statusStr6a,0.55,0.56,0.28,0.55,0.56,0.28);
	GameTooltip:AddDoubleLine(statusStr7,statusStr7a,0.55,0.56,0.28,0.55,0.56,0.28);
	GameTooltip:AddLine(" ",1,1,1);
	GameTooltip:AddLine(statusStr8,1,1,1);
	GameTooltip:AddLine(statusStr9,0.72,0.2,0.2);
	GameTooltip:AddLine(statusStr10,0.84,0.42,0.19);
	GameTooltip:Show();
end
----------------------------------------------------------------------------------------------------------------
-- HANDLER FUNCTIONS
----------------------------------------------------------------------------------------------------------------

function ACW_OnLoad()
	--RegisterForSave("ACWOptions");
	
	-- Register the events that need to be watched
	this:RegisterEvent("VARIABLES_LOADED");

	-- Register the slash command
	SLASH_ACW1 = "/alarmclockwrangler";
	SLASH_ACW2 = "/acw";
	SlashCmdList["ACW"] = function(msg)
		ACW_SlashCommand(msg);
	end

	ACWOptions = { };

	-- clock stuff
	ACWOptions.on = ACW_DEFAULT_ON;
	ACWOptions.locked = ACW_DEFAULT_LOCKED;
	ACWOptions.timeformat = ACW_DEFAULT_TIMEFORMAT;
	ACWOptions.offset = ACW_DEFAULT_OFFSET;
	ACWOptions.offsetminute = ACW_DEFAULT_OFFSET;

	-- alarm stuff
	ACWOptions.alarm1on = ACW_DEFAULT_ALARMON;
	ACWOptions.alarm2on = ACW_DEFAULT_ALARMON;
	ACWOptions.alarm3on = ACW_DEFAULT_ALARMON;

	ACWOptions.alarm1text = ACW_DEFAULT_ALARMTEXT;
	ACWOptions.alarm2text = ACW_DEFAULT_ALARMTEXT;
	ACWOptions.alarm3text = ACW_DEFAULT_ALARMTEXT;

	ACWOptions.alarm1hour = ACW_DEFAULT_ALARMHOUR;
	ACWOptions.alarm2hour = ACW_DEFAULT_ALARMHOUR;
	ACWOptions.alarm3hour = ACW_DEFAULT_ALARMHOUR;

	ACWOptions.alarm1minute = ACW_DEFAULT_ALARMMINUTE;
	ACWOptions.alarm2minute = ACW_DEFAULT_ALARMMINUTE;
	ACWOptions.alarm3minute = ACW_DEFAULT_ALARMMINUTE;

	ACWOptions.snoozetime = ACW_DEFAULT_SNOOZETIME;

	ACWOptions.daynighttex = ACW_DEFAULT_DAYNIGHTTEXT;

	ACWOptions.scale = 1.029999;
	
	-- Display a message in the ChatFrame indicating a successful load of this addon
	DEFAULT_CHAT_FRAME:AddMessage(ACW_LOADED, 1.0, 1.0, 0.0);
	
	-- Display a popup message indicating a successful load of this addon
	UIErrorsFrame:AddMessage(ACW_LOADED, 1.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
end

function ACW_OnEvent()
	if (event == "VARIABLES_LOADED") then
		-- per character settings
		ACW_REALM_NAME = GetCVar("realmName");
		--ACW_PLAYER_NAME= UnitName("player");
		ACW_SAVE_PREFIX = ACW_REALM_NAME;
				
		ACWOptions.offset = ACWOptions[ACW_SAVE_PREFIX.."offset"];
		if (ACWOptions.offset == nil) then
			ACWOptions.offset = ACW_DEFAULT_OFFSET;
		end

		ACWOptions.offsetminute = ACWOptions[ACW_SAVE_PREFIX.."offsetminute"];
		if (ACWOptions.offsetminute == nil) then
			ACWOptions.offsetminute = ACW_DEFAULT_OFFSET;
		end

		if (ACWOptions.scale == nil) then
			ACWOptions.scale = 1.029999;
		end
		
		-- Initialize the display
		ACW_Update();
		ACW_SetDayNightTexture();

		if (ACWOptions.xOffset == nil) then
			ACWOptions.xOffset = ACW_CENTER_X;
		end
		
		if (ACWOptions.yOffset == nil) then
			ACWOptions.yOffset = ACW_CENTER_Y;
		end
		
		ACWXSlider:SetValue(ACWOptions.xOffset - ACW_CENTER_X)
		ACWYSlider:SetValue(ACWOptions.yOffset - ACW_CENTER_Y);
		
		ACWTextFrame:SetPoint("TOPLEFT","ACWFrame","TOPLEFT",ACWOptions.xOffset,ACWOptions.yOffset);
	end
end

function ACW_OnMouseDown(arg1)
	if (arg1 == "RightButton") then
		ShowUIPanel(ACWOptionsFrame);
		PlaySound("igMainMenuClose");
	else
		if (ACWOptions.locked ~= 1) then
			ACWFrame:StartMoving();
		end
	end	
end

function ACWButtonTooltips()
	GameTooltip:SetOwner(this, "ANCHOR_NONE");
	
	local x,y = this:GetCenter();
	local xPos = 0;
	local yPos = 0;
	local anchor,relative;
	if( y  < GetScreenHeight() / 2 ) then
		anchor = "BOTTOM";
		relative = "TOP";
	else
		anchor = "TOP";
		relative = "BOTTOM";
		yPos = yPos - 15;
	end	

	if( x < GetScreenWidth() / 2 ) then
		anchor = anchor.."LEFT";
		relative = relative.."LEFT";
	else
		anchor = anchor.."RIGHT";
		relative = relative.."RIGHT";
	end

	GameTooltip:SetPoint(anchor, "ACWTextFrame", relative, xPos,yPos );	
	
	if (this == ACWSnoozeButton) then
		GameTooltip:SetText(ACW_SNOOZE_BUTTON);
	else
		GameTooltip:SetText(ACW_ACKNOWLEDGE_ALARMS_BUTTON);
	end

	--GameTooltip:Show();
end

function ACW_ScaleClock()
	--dout("Scale: "..ACWOptions.scale);
	ACWFrame:SetWidth(ACW_SIZE_FRAME*ACWOptions.scale);
	ACWFrame:SetWidth(ACW_SIZE_FRAME*ACWOptions.scale);

	ACWCircle:SetWidth(ACW_SIZE_CIRCLE*ACWOptions.scale);
	ACWCircle:SetHeight(ACW_SIZE_CIRCLE*ACWOptions.scale);

	ACWBGFrame:SetWidth(ACW_SIZE_BG*ACWOptions.scale);
	ACWBGFrame:SetHeight(ACW_SIZE_BG*ACWOptions.scale);

	ACWDayNight:SetWidth(ACW_SIZE_BG_TEX*ACWOptions.scale);
	ACWDayNight:SetHeight(ACW_SIZE_BG_TEX*ACWOptions.scale);

	ACWOptionsButton:SetWidth(ACW_SIZE_OPTIONS*ACWOptions.scale);
	ACWOptionsButton:SetHeight(ACW_SIZE_OPTIONS*ACWOptions.scale);
	ACWOptionsButton:SetPoint("TOPLEFT","ACWFrame","TOPLEFT",4*ACWOptions.scale,-40*ACWOptions.scale)

	ACWRedButton:SetWidth(ACW_SIZE_OPTIONS_BTN*ACWOptions.scale);
	ACWRedButton:SetHeight(ACW_SIZE_OPTIONS_BTN*ACWOptions.scale);

	ACWSnoozeButton:SetWidth(ACW_SIZE_SNOOZE*ACWOptions.scale);
	ACWSnoozeButton:SetHeight(ACW_SIZE_SNOOZE*ACWOptions.scale);
	ACWSnoozeButton:SetPoint("TOPLEFT","ACWFrame","TOPLEFT",28*ACWOptions.scale,-40*ACWOptions.scale)

	ACWBlueButton:SetWidth(ACW_SIZE_SNOOZE_BTN*ACWOptions.scale);
	ACWBlueButton:SetHeight(ACW_SIZE_SNOOZE_BTN*ACWOptions.scale);

	ACWTextFrame:SetWidth(ACW_SIZE_TEXT*ACWOptions.scale);
	ACWTextFrame:SetHeight(ACW_SIZE_TEXT*ACWOptions.scale);
	ACWTextFrame:SetScale((UIParent:GetScale() / GameTooltip:GetEffectiveScale()) * ACWOptions.scale);
end


function ACW_OnUpdate(elapsed)
	if (ACW_SET_SCALE == true) then
		ACW_SET_SCALE = false;
		ACW_ScaleClock();
	end

	-- Get server time
	local hour, minute = GetGameTime();
	
	ACW_SetDayNightTextureUpdate(hour,minute);
	-- Apply the offset option
	hour = hour + ACWOptions.offset;
	if (hour >= 24) then
		hour = hour - 24;
	elseif (hour < 0) then
		hour = hour + 24;
	end

	-- Apply the minute offset option
	minute = minute + ACWOptions.offsetminute;
	if (minute < 0) then
		minute = minute + 60;
		hour = hour - 1;

		if (hour < 0) then
			hour = 23;
		end
	elseif (minute >= 60) then
		minute = minute - 60;
		hour = hour + 1;

		if (hour > 23) then
			hour = 0;
		end
	end

	-- Check for alarms
	if (ACWOptions.alarm1on == 1) then
		if (ACW_ALARM1_ALARMED==1 or ACW_ALARM1_SNOOZING == 1) then
			ACW_ELAPSE_CTR1 = ACW_ELAPSE_CTR1 + elapsed;
		end
		
		if (ACW_ACKNOWLEDGE_ALARM1 == 0) then
			if ((ACWOptions.alarm1hour == hour and ACWOptions.alarm1minute == minute and ACW_ALARM1_ALARMED==0) 
				or (ACW_ALARM1_ALARMED==1 and ACW_ELAPSE_CTR1 >= ACW_REALARMTIME) 
				or (ACW_ALARM1_SNOOZING == 1 and ACW_ELAPSE_CTR1 >= ACWOptions.snoozetime)) then
				ACW_ALARM1_ALARMED=1;
				ACWAlarm(ACWOptions.alarm1text);
				ACW_ELAPSE_CTR1 = 0;
				ACW_ALARM1_SNOOZING = 0;
			end		
		end

		if (ACW_ACKNOWLEDGE_ALARM1 == 1 and ACWOptions.alarm1minute ~= minute) then
			ACW_ACKNOWLEDGE_ALARM1 = 0;
		end
	end
	if (ACWOptions.alarm2on == 1) then
		if (ACW_ALARM2_ALARMED==1 or ACW_ALARM2_SNOOZING == 1) then
			ACW_ELAPSE_CTR2 = ACW_ELAPSE_CTR2 + elapsed;
		end
		
		if (ACW_ACKNOWLEDGE_ALARM2 == 0) then
			if ((ACWOptions.alarm2hour == hour and ACWOptions.alarm2minute == minute and ACW_ALARM2_ALARMED==0) 
				or (ACW_ALARM2_ALARMED==1 and ACW_ELAPSE_CTR2 >= ACW_REALARMTIME) 
				or (ACW_ALARM2_SNOOZING == 1 and ACW_ELAPSE_CTR2 >= ACWOptions.snoozetime)) then
				ACW_ALARM2_ALARMED=1;
				ACWAlarm(ACWOptions.alarm2text);
				ACW_ELAPSE_CTR2 = 0;
				ACW_ALARM2_SNOOZING = 0;
			end		
		end

		if (ACW_ACKNOWLEDGE_ALARM2 == 1 and ACWOptions.alarm2minute ~= minute) then
			ACW_ACKNOWLEDGE_ALARM2 = 0;
		end
	end
	if (ACWOptions.alarm3on == 1) then
		if (ACW_ALARM3_ALARMED==1 or ACW_ALARM3_SNOOZING == 1) then
			ACW_ELAPSE_CTR3 = ACW_ELAPSE_CTR3 + elapsed;
		end
		
		if (ACW_ACKNOWLEDGE_ALARM3 == 0) then
			if ((ACWOptions.alarm3hour == hour and ACWOptions.alarm3minute == minute and ACW_ALARM3_ALARMED==0) 
				or (ACW_ALARM3_ALARMED==1 and ACW_ELAPSE_CTR3 >= ACW_REALARMTIME) 
				or (ACW_ALARM3_SNOOZING == 1 and ACW_ELAPSE_CTR3 >= ACWOptions.snoozetime)) then
				ACW_ALARM3_ALARMED=1;
				ACWAlarm(ACWOptions.alarm3text);
				ACW_ELAPSE_CTR3 = 0;
				ACW_ALARM3_SNOOZING = 0;
			end		
		end

		if (ACW_ACKNOWLEDGE_ALARM3 == 1 and ACWOptions.alarm3minute ~= minute) then
			ACW_ACKNOWLEDGE_ALARM3 = 0;
		end
	end

	-- Check the time format option
	if (ACWOptions.timeformat == 24) then
		if (hour < 10 and ACW_FOUR_DIGITS ~= 0) then -- only 3 digits
			ACW_FOUR_DIGITS = 0;
			ACWText:SetPoint("TOP","ACWTextFrame","TOP",-1,-14);
		elseif (hour >= 10 and ACW_FOUR_DIGITS ~= 1) then
			ACW_FOUR_DIGITS = 1;
			ACWText:SetPoint("TOP","ACWTextFrame","TOP",-2,-14);
		end
		ACWText:SetText(format(TEXT(TIME_TWENTYFOURHOURS), hour, minute));
		ACWMeridianText:SetText(" ");
	else
		local pm = 0;
		if (hour >= 12) then
			pm = 1;
		end
		if (hour > 12) then
			hour = hour - 12;
		end
		if (hour == 0) then
			hour = 12;
		end
		
		if (hour < 10 and ACW_FOUR_DIGITS ~= 0) then -- only 3 digits
			ACW_FOUR_DIGITS = 0;
			ACWText:SetPoint("TOP","ACWTextFrame","TOP",-1,-10);
		elseif (hour >= 10 and ACW_FOUR_DIGITS ~= 1) then
			ACW_FOUR_DIGITS = 1;
			ACWText:SetPoint("TOP","ACWTextFrame","TOP",-1,-10);
		end

		if (pm == 0) then
			ACWText:SetText(string.gsub(string.sub(format(TEXT(TIME_TWELVEHOURAM), hour, minute),1,5)," ",""));
			--ACWText:SetText(hour..":"..minute);
			ACWMeridianText:SetText("AM");
		else
			ACWText:SetText(string.gsub(string.sub(format(TEXT(TIME_TWELVEHOURPM), hour, minute),1,5)," ",""));
			--ACWText:SetText(hour..":"..minute);
			ACWMeridianText:SetText("PM");
		end
	end
end


