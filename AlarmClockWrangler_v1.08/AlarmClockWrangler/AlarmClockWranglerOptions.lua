-------------------------------------------------------------------------------------------------
-- GLOBALS
-------------------------------------------------------------------------------------------------
ACW_DLG_COLOR = 0.4;
ACW_INVALID_TIME = 30;

MYUIDROPDOWNMENU_BUTTON_HEIGHT = 0;

-------------------------------------------------------------------------------------------------
-- INTERNAL FUNCTIONS
-------------------------------------------------------------------------------------------------
function ACWOptionsFrameTimeFormatDropDown_Initialize()

	local info;

	info = {};
	info.text = "12"..ACW_OPTIONS_HOURS;
	info.func = ACWOptionsFrameTimeFormatDropDown_OnClick;
	info.value = 12;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "24"..ACW_OPTIONS_HOURS;
	info.func = ACWOptionsFrameTimeFormatDropDown_OnClick;
	info.value = 24;
	UIDropDownMenu_AddButton(info);

end

function ACWOptionsFrameOffsetDropDown_Initialize()

	local info;

	for i=-12, 12, 1 do
		info = {};
		info.text = tostring(i);
		if (i>0) then
			info.text = "+"..info.text;
		end
		info.func = ACWOptionsFrameOffsetDropDown_OnClick;
		info.value = i;
		UIDropDownMenu_AddButton(info);
	end

end

function ACWOptionsFrameOffsetMinuteDropDown_Initialize()

	local info;

	for i=-45, 45, 15 do
		info = {};
		info.text = tostring(i);
		if (i>0) then
			info.text = "+"..info.text;
		end
		info.func = ACWOptionsFrameOffsetMinuteDropDown_OnClick;
		info.value = i;
		UIDropDownMenu_AddButton(info);
	end

end

function ACWOptions_Update(insertSavedTime)
	ACWOptionsFrameCheckButton1:SetChecked(ACWOptions.on);
	ACWOptionsFrameCheckButton2:SetChecked(ACWOptions.locked);
	UIDropDownMenu_SetSelectedValue(ACWOptionsFrameTimeFormatDropDown, ACWOptions.timeformat);
	UIDropDownMenu_SetText(ACWOptions.timeformat..ACW_OPTIONS_HOURS, ACWOptionsFrameTimeFormatDropDown);
	UIDropDownMenu_SetSelectedValue(ACWOptionsFrameOffsetDropDown, ACWOptions.offset);
	if (ACWOptions.offset>0) then
		UIDropDownMenu_SetText("+"..ACWOptions.offset, ACWOptionsFrameOffsetDropDown);
	else
		UIDropDownMenu_SetText(ACWOptions.offset, ACWOptionsFrameOffsetDropDown);
	end

	UIDropDownMenu_SetSelectedValue(ACWOptionsFrameOffsetMinuteDropDown, ACWOptions.offsetminute);
	if (ACWOptions.offsetminute>0) then
		UIDropDownMenu_SetText("+"..ACWOptions.offsetminute, ACWOptionsFrameOffsetMinuteDropDown);
	else
		UIDropDownMenu_SetText(ACWOptions.offsetminute, ACWOptionsFrameOffsetMinuteDropDown);
	end

	-- Alarm stuff
	ACWOptionsAlarm1CheckButton:SetChecked(ACWOptions.alarm1on);
	ACWOptionsAlarm2CheckButton:SetChecked(ACWOptions.alarm2on);
	ACWOptionsAlarm3CheckButton:SetChecked(ACWOptions.alarm3on);

	ACWOptionsAlarm1EditBox:SetText(ACWOptions.alarm1text);
	ACWOptionsAlarm2EditBox:SetText(ACWOptions.alarm2text);
	ACWOptionsAlarm3EditBox:SetText(ACWOptions.alarm3text);

	if (insertSavedTime == true) then
		ACWOptionsAlarm1HourEditBox:SetNumber(ACWOptions.alarm1hour);
		ACWOptionsAlarm2HourEditBox:SetNumber(ACWOptions.alarm2hour);
		ACWOptionsAlarm3HourEditBox:SetNumber(ACWOptions.alarm3hour);
	end
	
	if (insertSavedTime == true and ACWOptions.timeformat == 24 ) then

	else
		ACWAlarm1Frame_Adjust();
		ACWAlarm2Frame_Adjust();
		ACWAlarm3Frame_Adjust();
	end

	
	local minuteStr = ""..ACWOptions.alarm1minute;
	if (ACWOptions.alarm1minute < 10) then -- pad
		minuteStr = "0"..minuteStr;
	end
	ACWOptionsAlarm1MinuteEditBox:SetNumber(minuteStr);
	
	minuteStr = ""..ACWOptions.alarm2minute;
	if (ACWOptions.alarm2minute < 10) then -- pad
		minuteStr = "0"..minuteStr;
	end
	ACWOptionsAlarm2MinuteEditBox:SetNumber(minuteStr);

	minuteStr = ""..ACWOptions.alarm3minute;
	if (ACWOptions.alarm3minute < 10) then -- pad
		minuteStr = "0"..minuteStr;
	end
	ACWOptionsAlarm3MinuteEditBox:SetNumber(minuteStr);

	-- Set the misc options
	ACWOptionsSnoozeMinuteEditBox:SetNumber((ACWOptions.snoozetime/60));
	ACWOptionsFrameCheckButton3:SetChecked(ACWOptions.daynighttex);

	-- Set the scale
	--ACWScalingSlider:SetValue(ACWOptions.scale);
end


function ACWOptionsFrame_SetDefaults()
	-- Reset myClock options to defaults
	ACW_Reset();
	
	-- Update the display
	ACWOptions_Update(true);
end

-- Return the hour in 24 hour format if valid
function ACWValidateTime(hour,minute,meridian)
	--message(meridian);
	if (ACWOptions.timeformat == 12) then
		if ((hour <= 12 and hour > 0) and (minute < 60 and minute >= 0)) then
			if (hour == 12 and meridian == 1) then
				return hour;
			elseif (hour == 12 and meridian == nil) then
				return 0;
			elseif (meridian == 1) then
				hour = hour + 12;
				if (hour == 24) then
					hour = 0;
				end

				return hour;
			else
				return hour;
			end
		end
	else -- 24
		if ((hour <= 23 and hour >= 0) and (minute < 60 and minute >= 0)) then
			return hour;
		end
	end

	return ACW_INVALID_TIME;
end

-------------------------------------------------------------------------------------------------
-- EVENT HANDLERS
-------------------------------------------------------------------------------------------------

-- Main Frame
function ACWOptionsFrame_OnLoad()
	UIPanelWindows["ACWOptionsFrame"] = {area = "center", pushable = 0};

	ACWOptionsFrameCheckButton1Text:SetText(ACW_OPTIONS_ON);
	ACWOptionsFrameCheckButton2Text:SetText(ACW_OPTIONS_LOCK);
	ACWOptionsFrameCheckButton3Text:SetText(ACW_OPTIONS_TEXTURE);
	UIDropDownMenu_Initialize(ACWOptionsFrameTimeFormatDropDown, ACWOptionsFrameTimeFormatDropDown_Initialize);
	UIDropDownMenu_SetWidth(80, ACWOptionsFrameTimeFormatDropDown);
	UIDropDownMenu_Initialize(ACWOptionsFrameOffsetDropDown, ACWOptionsFrameOffsetDropDown_Initialize);
	UIDropDownMenu_SetWidth(80, ACWOptionsFrameOffsetDropDown);
	UIDropDownMenu_Initialize(ACWOptionsFrameOffsetMinuteDropDown, ACWOptionsFrameOffsetMinuteDropDown_Initialize);
	UIDropDownMenu_SetWidth(80, ACWOptionsFrameOffsetMinuteDropDown);
end

function ACWOptionsFrame_OnShow()
	-- Use smaller font for dropdown menus
	MYUIDROPDOWNMENU_BUTTON_HEIGHT = UIDROPDOWNMENU_BUTTON_HEIGHT;
	UIDROPDOWNMENU_BUTTON_HEIGHT = 12;

	-- Update the display
	ACWOptions_Update(true);
end

function ACWOptionsFrame_OnHide()
	-- Restore standard font for dropdown menus
	UIDROPDOWNMENU_BUTTON_HEIGHT = MYUIDROPDOWNMENU_BUTTON_HEIGHT;
end

function ACWOptionsToggleCheckButton_OnClick()
	if (this == ACWOptionsAlarm1AMCheckButton) then
		if (ACWOptionsAlarm1AMCheckButton:GetChecked() == 1) then
			ACWOptionsAlarm1PMCheckButton:SetChecked(0);
			PlaySound("igMainMenuOptionCheckBoxOn");
		else
			ACWOptionsAlarm1AMCheckButton:SetChecked(1);
		end
	elseif (this == ACWOptionsAlarm1PMCheckButton) then
		if (ACWOptionsAlarm1PMCheckButton:GetChecked() == 1) then
			ACWOptionsAlarm1AMCheckButton:SetChecked(0);
			PlaySound("igMainMenuOptionCheckBoxOn");
		else
			ACWOptionsAlarm1PMCheckButton:SetChecked(1);
		end
	elseif (this == ACWOptionsAlarm2AMCheckButton) then
		if (ACWOptionsAlarm2AMCheckButton:GetChecked() == 1) then
			ACWOptionsAlarm2PMCheckButton:SetChecked(0);
			PlaySound("igMainMenuOptionCheckBoxOn");
		else
			ACWOptionsAlarm2AMCheckButton:SetChecked(1);
		end
	elseif (this == ACWOptionsAlarm2PMCheckButton) then
		if (ACWOptionsAlarm2PMCheckButton:GetChecked() == 1) then
			ACWOptionsAlarm2AMCheckButton:SetChecked(0);
			PlaySound("igMainMenuOptionCheckBoxOn");
		else
			ACWOptionsAlarm2PMCheckButton:SetChecked(1);
		end
	elseif (this == ACWOptionsAlarm3AMCheckButton) then
		if (ACWOptionsAlarm3AMCheckButton:GetChecked() == 1) then
			ACWOptionsAlarm3PMCheckButton:SetChecked(0);
			PlaySound("igMainMenuOptionCheckBoxOn");
		else
			ACWOptionsAlarm3AMCheckButton:SetChecked(1);
		end
	elseif (this == ACWOptionsAlarm3PMCheckButton) then
		if (ACWOptionsAlarm3PMCheckButton:GetChecked() == 1) then
			ACWOptionsAlarm3AMCheckButton:SetChecked(0);
			PlaySound("igMainMenuOptionCheckBoxOn");
		else
			ACWOptionsAlarm3PMCheckButton:SetChecked(1);
		end
	end
end

function ACWOptionsCheckButton_OnClick()
	-- Check which checkbutton was clicked
	if (this == ACWOptionsFrameCheckButton1) then
		ACWOptions.on = this:GetChecked();
	elseif (this == ACWOptionsFrameCheckButton2) then
		ACWOptions.locked = this:GetChecked();
	elseif (this == ACWOptionsFrameCheckButton3) then
		ACWOptions.daynighttex = this:GetChecked();
		ACW_SetDayNightTexture();
	end

	-- Play sound
	if (this:GetChecked()) then
		PlaySound("igMainMenuOptionCheckBoxOff");
	else
		PlaySound("igMainMenuOptionCheckBoxOn");
	end

	-- Update display
	ACW_Update();
end

function ACW_OnOK()
	--Get times and validate
	local hidePanel = true;
	local hour,minute,meridian;
	
	-- ** 1 ** --
	-- Time
	hour = ACWOptionsAlarm1HourEditBox:GetNumber();
	minute = ACWOptionsAlarm1MinuteEditBox:GetNumber();
	meridian = ACWOptionsAlarm1PMCheckButton:GetChecked();

	hour = ACWValidateTime(hour,minute,meridian);
	if (hour ~= ACW_INVALID_TIME) then
		ACWOptions.alarm1hour = hour;
		ACWOptions.alarm1minute = minute;
	else
		hidePanel = false;
		message(ACW_ERROR_ALARMTIME);
		ACWOptionsAlarm1HourEditBox:SetFocus();
	end

	-- Text
	if (ACWOptionsAlarm1EditBox:GetNumLetters() > 0) then
		ACWOptions.alarm1text = ACWOptionsAlarm1EditBox:GetText();
	else
		hidePanel = false;
		message(ACW_ERROR_ALARMMESSAGE);
		ACWOptionsAlarm1EditBox:SetFocus();
	end

	-- On/Off
	ACWOptions.alarm1on = ACWOptionsAlarm1CheckButton:GetChecked();

	-- ** 2 ** --
	-- Time
	hour = ACWOptionsAlarm2HourEditBox:GetNumber();
	minute = ACWOptionsAlarm2MinuteEditBox:GetNumber();
	meridian = ACWOptionsAlarm2PMCheckButton:GetChecked();

	hour = ACWValidateTime(hour,minute,meridian);
	if (hour ~= ACW_INVALID_TIME) then
		ACWOptions.alarm2hour = hour;
		ACWOptions.alarm2minute = minute;
	else
		hidePanel = false;
		message(ACW_ERROR_ALARMTIME);
		ACWOptionsAlarm2HourEditBox:SetFocus();
	end

	-- Text
	if (ACWOptionsAlarm2EditBox:GetNumLetters() > 0) then
		ACWOptions.alarm2text = ACWOptionsAlarm2EditBox:GetText();
	else
		hidePanel = false;
		message(ACW_ERROR_ALARMMESSAGE);
		ACWOptionsAlarm2EditBox:SetFocus();
	end

	-- On/Off
	ACWOptions.alarm2on = ACWOptionsAlarm2CheckButton:GetChecked();

	
	-- ** 3 ** --
	-- Time
	hour = ACWOptionsAlarm3HourEditBox:GetNumber();
	minute = ACWOptionsAlarm3MinuteEditBox:GetNumber();
	meridian = ACWOptionsAlarm3PMCheckButton:GetChecked();

	hour = ACWValidateTime(hour,minute,meridian);
	if (hour ~= ACW_INVALID_TIME) then
		ACWOptions.alarm3hour = hour;
		ACWOptions.alarm3minute = minute;
	else
		hidePanel = false;
		message(ACW_ERROR_ALARMTIME);
		ACWOptionsAlarm3HourEditBox:SetFocus();
	end

	-- Text
	if (ACWOptionsAlarm3EditBox:GetNumLetters() > 0) then
		ACWOptions.alarm3text = ACWOptionsAlarm3EditBox:GetText();
	else
		hidePanel = false;
		message(ACW_ERROR_ALARMMESSAGE);
		ACWOptionsAlarm3EditBox:SetFocus();
	end

	-- On/Off
	ACWOptions.alarm3on = ACWOptionsAlarm3CheckButton:GetChecked();

	-- grab the options
	

	if (ACWOptionsSnoozeMinuteEditBox:GetNumLetters() > 0) then
		local snoozeTime = ACWOptionsSnoozeMinuteEditBox:GetNumber();
		ACWOptions.snoozetime = (snoozeTime * 60);
	else
		hidePanel = false;
		message(ACW_ERROR_SNOOZEMESSAGE);
		ACWOptionsSnoozeMinuteEditBox:SetFocus();
	end

	if (hidePanel == true) then
		HideUIPanel(ACWOptionsFrame);
	end
end

-- Children
function ACWOptionsFrameTimeFormatDropDown_OnClick()
	if (ACWOptions.timeformat ~= this.value) then
		UIDropDownMenu_SetSelectedValue(ACWOptionsFrameTimeFormatDropDown, this.value);
		ACWOptions.timeformat = this.value;
		ACWOptions_Update(false);
		ACW_FOUR_DIGITS = 3;
	end
end


function ACWOptionsFrameOffsetDropDown_OnClick()
	UIDropDownMenu_SetSelectedValue(ACWOptionsFrameOffsetDropDown, this.value);
	ACWOptions.offset = this.value;
	ACWOptions[ACW_SAVE_PREFIX.."offset"] = ACWOptions.offset;
end

function ACWOptionsFrameOffsetMinuteDropDown_OnClick()
	UIDropDownMenu_SetSelectedValue(ACWOptionsFrameOffsetMinuteDropDown, this.value);
	ACWOptions.offsetminute = this.value;
	ACWOptions[ACW_SAVE_PREFIX.."offsetminute"] = ACWOptions.offsetminute;
end


function ACWAlarm1Frame_Adjust()
	ACWOptionsAlarm1AMCheckButtonText:SetText("AM");
	ACWOptionsAlarm1PMCheckButtonText:SetText("PM");

	if (ACWOptions.timeformat == 12) then
		ACWOptionsAlarm1PMCheckButton:Show();
		ACWOptionsAlarm1AMCheckButton:Show();
		local hour = ACWOptionsAlarm1HourEditBox:GetNumber();
		if (hour > 12) then
			ACWOptionsAlarm1HourEditBox:SetNumber(hour-12);
			ACWOptionsAlarm1PMCheckButton:SetChecked(1);
			ACWOptionsAlarm1AMCheckButton:SetChecked(0);
		elseif (hour == 12) then
			ACWOptionsAlarm1PMCheckButton:SetChecked(1);
			ACWOptionsAlarm1AMCheckButton:SetChecked(0);
		elseif (hour == 0) then	
			ACWOptionsAlarm1HourEditBox:SetNumber(12);
			ACWOptionsAlarm1PMCheckButton:SetChecked(0);
			ACWOptionsAlarm1AMCheckButton:SetChecked(1);
		else -- hour < 12
			ACWOptionsAlarm1HourEditBox:SetNumber(hour);
			ACWOptionsAlarm1PMCheckButton:SetChecked(0);
			ACWOptionsAlarm1AMCheckButton:SetChecked(1);
		end
	else
		ACWOptionsAlarm1AMCheckButton:Hide();
		ACWOptionsAlarm1PMCheckButton:Hide();
		local hour = ACWOptionsAlarm1HourEditBox:GetNumber();
		if (ACWOptionsAlarm1PMCheckButton:GetChecked() and hour == 12) then
			ACWOptionsAlarm1PMCheckButton:SetChecked(1);
			ACWOptionsAlarm1AMCheckButton:SetChecked(0);
		elseif (ACWOptionsAlarm1PMCheckButton:GetChecked()) then
			hour = hour + 12;
			if (hour == 24) then
				hour = 0;
			end
			ACWOptionsAlarm1HourEditBox:SetNumber(hour);
			ACWOptionsAlarm1PMCheckButton:SetChecked(1);
			ACWOptionsAlarm1AMCheckButton:SetChecked(0);
		elseif (hour == 12) then
			ACWOptionsAlarm1HourEditBox:SetNumber(0);
			ACWOptionsAlarm1PMCheckButton:SetChecked(0);
			ACWOptionsAlarm1AMCheckButton:SetChecked(1);
		end
	end

end

function ACWAlarm2Frame_Adjust()
	ACWOptionsAlarm2AMCheckButtonText:SetText("AM");
	ACWOptionsAlarm2PMCheckButtonText:SetText("PM");

	if (ACWOptions.timeformat == 12) then
		ACWOptionsAlarm2PMCheckButton:Show();
		ACWOptionsAlarm2AMCheckButton:Show();
		local hour = ACWOptionsAlarm2HourEditBox:GetNumber();
		if (hour > 12) then
			ACWOptionsAlarm2HourEditBox:SetNumber(hour-12);
			ACWOptionsAlarm2PMCheckButton:SetChecked(1);
			ACWOptionsAlarm2AMCheckButton:SetChecked(0);
		elseif (hour == 12) then
			ACWOptionsAlarm2PMCheckButton:SetChecked(1);
			ACWOptionsAlarm2AMCheckButton:SetChecked(0);
		elseif (hour == 0) then
			ACWOptionsAlarm2HourEditBox:SetNumber(12);
			ACWOptionsAlarm2PMCheckButton:SetChecked(0);
			ACWOptionsAlarm2AMCheckButton:SetChecked(1);
		else -- hour < 12
			ACWOptionsAlarm2HourEditBox:SetNumber(hour);
			ACWOptionsAlarm2PMCheckButton:SetChecked(0);
			ACWOptionsAlarm2AMCheckButton:SetChecked(1);
		end
	else
		ACWOptionsAlarm2AMCheckButton:Hide();
		ACWOptionsAlarm2PMCheckButton:Hide();

		local hour = ACWOptionsAlarm2HourEditBox:GetNumber();
		if (ACWOptionsAlarm2PMCheckButton:GetChecked() and hour == 12) then
			ACWOptionsAlarm2PMCheckButton:SetChecked(1);
			ACWOptionsAlarm2AMCheckButton:SetChecked(0);
		elseif (ACWOptionsAlarm2PMCheckButton:GetChecked()) then
			hour = hour + 12;
			if (hour == 24) then
				hour = 0;
			end
			ACWOptionsAlarm2HourEditBox:SetNumber(hour);
			ACWOptionsAlarm2PMCheckButton:SetChecked(1);
			ACWOptionsAlarm2AMCheckButton:SetChecked(0);
		elseif (hour == 12) then
			ACWOptionsAlarm2HourEditBox:SetNumber(0);
			ACWOptionsAlarm2PMCheckButton:SetChecked(0);
			ACWOptionsAlarm2AMCheckButton:SetChecked(1);
		end
	end
end

function ACWAlarm3Frame_Adjust()
	ACWOptionsAlarm3AMCheckButtonText:SetText("AM");
	ACWOptionsAlarm3PMCheckButtonText:SetText("PM");

	if (ACWOptions.timeformat == 12) then
		ACWOptionsAlarm3PMCheckButton:Show();
		ACWOptionsAlarm3AMCheckButton:Show();
		local hour = ACWOptionsAlarm3HourEditBox:GetNumber();
		if (hour > 12) then
			ACWOptionsAlarm3HourEditBox:SetNumber(hour-12);
			ACWOptionsAlarm3PMCheckButton:SetChecked(1);
			ACWOptionsAlarm3AMCheckButton:SetChecked(0);
		elseif (hour == 12) then
			ACWOptionsAlarm3PMCheckButton:SetChecked(1);
			ACWOptionsAlarm3AMCheckButton:SetChecked(0);
		elseif (hour == 0) then
			ACWOptionsAlarm3HourEditBox:SetNumber(12);
			ACWOptionsAlarm3PMCheckButton:SetChecked(0);
			ACWOptionsAlarm3AMCheckButton:SetChecked(1);
		else -- hour < 12
			ACWOptionsAlarm3HourEditBox:SetNumber(hour);
			ACWOptionsAlarm3PMCheckButton:SetChecked(0);
			ACWOptionsAlarm3AMCheckButton:SetChecked(1);
		end
	else
		ACWOptionsAlarm3AMCheckButton:Hide();
		ACWOptionsAlarm3PMCheckButton:Hide();

		local hour = ACWOptionsAlarm3HourEditBox:GetNumber();

		if (ACWOptionsAlarm3PMCheckButton:GetChecked() and hour == 12) then
			ACWOptionsAlarm3PMCheckButton:SetChecked(1);
			ACWOptionsAlarm3AMCheckButton:SetChecked(0);
		elseif (ACWOptionsAlarm3PMCheckButton:GetChecked()) then
			hour = hour + 12;
			if (hour == 24) then
				hour = 0;
			end
			ACWOptionsAlarm3HourEditBox:SetNumber(hour);
			ACWOptionsAlarm3PMCheckButton:SetChecked(1);
			ACWOptionsAlarm3AMCheckButton:SetChecked(0);
		elseif (hour == 12) then
			ACWOptionsAlarm3HourEditBox:SetNumber(0);
			ACWOptionsAlarm3PMCheckButton:SetChecked(0);
			ACWOptionsAlarm3AMCheckButton:SetChecked(1);
		end
	end
end


function ACW_Update_XScale()
	local scale = ACWXSlider:GetValue();
	
	ACWOptions.xOffset = ACW_CENTER_X + scale;
	
	ACWTextFrame:SetPoint("TOPLEFT","ACWFrame","TOPLEFT",ACWOptions.xOffset,ACWOptions.yOffset);
	
end

function ACW_Update_YScale()
	local scale = ACWYSlider:GetValue();
	
	ACWOptions.yOffset = ACW_CENTER_Y + scale;
	
	ACWTextFrame:SetPoint("TOPLEFT","ACWFrame","TOPLEFT",ACWOptions.xOffset,ACWOptions.yOffset);
end