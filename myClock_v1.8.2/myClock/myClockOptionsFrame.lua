-- myClock v1.8 --


--------------------------------------------------------------------------------------------------
-- Event functions
--------------------------------------------------------------------------------------------------

-- OnLoad event
function myClockOptionsFrame_OnLoad()

	-- Register the events that need to be watched
	this:RegisterEvent("ADDON_LOADED");

end

-- OnEvent event
function myClockOptionsFrame_OnEvent()

	-- Check the current event
	if (event == "ADDON_LOADED" and arg1 == "myClock") then
		-- Initialize the options frame
		myClockOptionsFrame_Initialize();
	end

end

-- OnShow event
function myClockOptionsFrame_OnShow()

	-- Use a smaller font for dropdown menus
	MYUIDROPDOWNMENU_BUTTON_HEIGHT = UIDROPDOWNMENU_BUTTON_HEIGHT;
	UIDROPDOWNMENU_BUTTON_HEIGHT = 12;
	
	-- Update the display
	myClockOptionsFrame_Update();

end

-- OnHide event
function myClockOptionsFrame_OnHide()

	-- Restore the standard font for dropdown menus
	UIDROPDOWNMENU_BUTTON_HEIGHT = MYUIDROPDOWNMENU_BUTTON_HEIGHT;

end

-- Checkbuttons OnClick event
function myClockOptionsCheckButton_OnClick()

	-- Check if the checkbutton is checked or not
	if (this:GetChecked()) then
		PlaySound("igMainMenuOptionCheckBoxOff");
	else
		PlaySound("igMainMenuOptionCheckBoxOn");
	end
	
	-- Get the ID of the checkbutton
	local checkButtonID = this:GetID();
		
	-- Check which checkbutton was clicked
	if (checkButtonID == 1) then
		myClockOptions.showClock = this:GetChecked();
	elseif (checkButtonID == 2) then
		myClockOptions.showDayNight = this:GetChecked();
	elseif (checkButtonID == 3) then
		myClockOptions.lock = this:GetChecked();
	elseif (checkButtonID == 4) then
		myClockOptions.halfhourOffsets = this:GetChecked();
	end
	
	-- Update the display
	myClockFrame_Update();
	
	-- Update the display
	myClockOptionsFrame_Update();

end

-- Timeformat dropdown menu OnClick event
function myClockOptionsFrameTimeFormatDropDown_OnClick()

	-- Save the selected timeformat
	UIDropDownMenu_SetSelectedValue(myClockOptionsFrameTimeFormatDropDown, this.value);
	myClockOptions.timeFormat = this.value;

end

-- Offset dropdown menu OnClick event
function myClockOptionsFrameOffsetDropDown_OnClick()

	-- Save the selected offset
	UIDropDownMenu_SetSelectedValue(myClockOptionsFrameOffsetDropDown, this.value);
	myClockOptions.offset = this.value;

end


--------------------------------------------------------------------------------------------------
-- Initialize functions
--------------------------------------------------------------------------------------------------

-- Initialize the options frame
function myClockOptionsFrame_Initialize()

	-- Initialize the options checkbutton
	myClockOptionsFrameShowClockCheckButtonText:SetText(MYCLOCK_OPTIONS_SHOW_CLOCK);
	myClockOptionsFrameShowDayNightCheckButtonText:SetText(MYCLOCK_OPTIONS_SHOW_DAYNIGHT);
	myClockOptionsFrameLockCheckButtonText:SetText(MYCLOCK_OPTIONS_LOCK);
	myClockOptionsFrameHalfhourOffsetsCheckButtonText:SetText(MYCLOCK_OPTIONS_HALFHOUR_OFFSETS);
	
	-- Initialize the timeformat dropdown menu
	UIDropDownMenu_Initialize(myClockOptionsFrameTimeFormatDropDown, myClockOptionsFrameTimeFormatDropDown_Initialize);
	UIDropDownMenu_SetWidth(80, myClockOptionsFrameTimeFormatDropDown);
	
	-- Initialize the offset dropdown menu
	UIDropDownMenu_Initialize(myClockOptionsFrameOffsetDropDown, myClockOptionsFrameOffsetDropDown_Initialize);
	UIDropDownMenu_SetWidth(80, myClockOptionsFrameOffsetDropDown);

end

-- Initialize the timeformat dropdown menu
function myClockOptionsFrameTimeFormatDropDown_Initialize()

	local info;
	
	info = {};
	info.text = "12"..MYCLOCK_OPTIONS_HOURS;
	info.func = myClockOptionsFrameTimeFormatDropDown_OnClick;
	info.value = 12;
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = "24"..MYCLOCK_OPTIONS_HOURS;
	info.func = myClockOptionsFrameTimeFormatDropDown_OnClick;
	info.value = 24;
	UIDropDownMenu_AddButton(info);

end

-- Initialize the offset dropdown menu
function myClockOptionsFrameOffsetDropDown_Initialize()

	local info;
	
	for i=-12, 12, 1 do
		info = {};
		if (myClockOptions.halfhourOffsets) then
			info.text = tostring(i + 0.5);
		else
			info.text = tostring(i);
		end
		if (tonumber(info.text) > 0) then
			info.text = "+"..info.text;
		end
		info.func = myClockOptionsFrameOffsetDropDown_OnClick;
		info.value = i;
		UIDropDownMenu_AddButton(info);
	end

end


--------------------------------------------------------------------------------------------------
-- Display functions
--------------------------------------------------------------------------------------------------

-- Update the display
function myClockOptionsFrame_Update()

	-- Update the checkbuttons values
	myClockOptionsFrameShowClockCheckButton:SetChecked(myClockOptions.showClock);
	myClockOptionsFrameShowDayNightCheckButton:SetChecked(myClockOptions.showDayNight);
	myClockOptionsFrameLockCheckButton:SetChecked(myClockOptions.lock);
	myClockOptionsFrameHalfhourOffsetsCheckButton:SetChecked(myClockOptions.halfhourOffsets);
	
	-- Set the timeformat dropdown menu value
	UIDropDownMenu_SetSelectedValue(myClockOptionsFrameTimeFormatDropDown, myClockOptions.timeFormat);
	UIDropDownMenu_SetText(myClockOptions.timeFormat..MYCLOCK_OPTIONS_HOURS, myClockOptionsFrameTimeFormatDropDown);
	
	-- Get the base offset
	local offset = myClockOptions.offset;
	
	-- Set the offset dropdown menu value
	UIDropDownMenu_SetSelectedValue(myClockOptionsFrameOffsetDropDown, offset);
	
	-- Get the real offset
	if (myClockOptions.halfhourOffsets) then
		offset = offset + 0.5;
	end
	
	-- Check if the offset text needs a "+"
	if (offset > 0) then
		UIDropDownMenu_SetText("+"..offset, myClockOptionsFrameOffsetDropDown);
	else
		UIDropDownMenu_SetText(offset, myClockOptionsFrameOffsetDropDown);
	end

end

-- Reset options to defaults
function myClockOptionsFrame_SetDefaults()

	-- Clear the options
	myClockOptions = {};
	
	-- Initialize the options
	myClockFrame_InitializeOptions();
	
	-- Set the default position
	myClockFrame:SetPoint("TOPLEFT", "UIParent", "TOPRIGHT", -70, -28);
	
	-- Update the clock display
	myClockFrame_Update();
	
	-- Update the options display
	myClockOptionsFrame_Update();

end

