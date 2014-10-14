--[[

EFM_GUI.lua

This lua file handles the GUI options screen functions.

]]

-- Function: Display GUI options frame.
function EFM_GUI_Toggle()
	if(EFM_GUI_Options_Frame:IsVisible()) then
		EFM_GUI_Options_Frame:Hide();
	else
		EFM_GUI_Options_Frame:Show();
	end
end

-- Function: handle the events we are registered to receive
function EFM_GUI_Init()
	-- Set the button text.
	for key,val in pairs(EFM_MyConf) do
		if (key ~= "TimerPosition") then
			-- Debugging
			--DEFAULT_CHAT_FRAME:AddMessage("key: "..key);
			-- Debugging
		
			-- Set button text
			local myText = getglobal("EFM_GUITEXT_"..key);
			getglobal("EFM_GUI_Options_Frame_Toggle_"..key.."Text"):SetText(myText);
			
			-- Set button tooltip
			local myTooltip = getglobal("EFM_GUITEXT_Tooltip_"..key);
			if (myTooltip ~= nil) then
				local myButton = getglobal("EFM_GUI_Options_Frame_Toggle_"..key);
				myButton.tooltipText = myTooltip;
			end
		else
			-- Slider - Display position
			EFM_GUI_Options_Frame_Slider_DisplayText:SetText(format(EFM_GUITEXT_DisplaySlider, EFM_MyConf.TimerPosition));
			EFM_GUI_Options_Frame_Slider_DisplayHigh:SetText("200");
			EFM_GUI_Options_Frame_Slider_DisplayLow:SetText("-200");
			EFM_GUI_Options_Frame_Slider_Display:SetMinMaxValues(-200, 200);
			EFM_GUI_Options_Frame_Slider_Display:SetValueStep(10);
			EFM_GUI_Options_Frame_Slider_Display.tooltipText = EFM_GUITEXT_Tooltip_DisplaySlider;
		end
	end
end

-- Function: Set the various options to their current settings.
function EFM_GUI_OnShow()
	-- Make sure the various options are set.
	for key,val in pairs(EFM_MyConf) do
		if (key ~= "TimerPosition") then
			getglobal("EFM_GUI_Options_Frame_Toggle_"..key):SetChecked(EFM_MyConf[key]);
		else
			EFM_GUI_Options_Frame_Slider_DisplayText:SetText(format(EFM_GUITEXT_DisplaySlider, EFM_MyConf.TimerPosition));
			EFM_GUI_Options_Frame_Slider_Display:SetValue(EFM_MyConf.TimerPosition);
		end
	end
end

-- Function: What to do when the button is "clicked"
function EFM_GUI_Button_OnEvent(myOption)
	local myOptionName = myOption:GetName();

	if (string.find(myOptionName, "EFM_GUI_Options_Frame_Toggle_") ~= nil) then
		local value = string.sub(myOptionName, (string.len("EFM_GUI_Options_Frame_Toggle_") + 1));

		if (EFM_MyConf[value]) then
			if (value == "Timer") then
				EFM_Timer_HideTimers();
			end
			EFM_MyConf[value] = false;
			myOption:SetChecked(false);
		else
			EFM_MyConf[value] = true;
			myOption:SetChecked(true);
		end
	elseif (myOptionName == "EFM_GUI_Options_Frame_Done") then
		EFM_GUI_Options_Frame:Hide();
	elseif (myOptionName == "EFM_GUI_Options_Frame_Defaults") then
		EFM_MyConf.Timer		= true;
		EFM_MyConf.ZoneMarker	= true;
		EFM_MyConf.DruidPaths	= true;
		EFM_MyConf.ShowTimerBar	= false;
		EFM_MyConf.ShowLargeBar	= false;
		EFM_MyConf.TimerPosition	= -150;
		EFM_MyConf.LoadAll		= true;
		EFM_GUI_OnShow();
	elseif (myOptionName == "EFM_GUI_Options_Frame_LoadAlliance") then
		if (EFM_MyConf.LoadAll == true) then
			EFM_Load_Stored_Data("Alliance");
		else
			EFM_Data_ImportKnownTimes("Alliance");
		end
	elseif (myOptionName == "EFM_GUI_Options_Frame_LoadHorde") then
		if (EFM_MyConf.LoadAll == true) then
			EFM_Load_Stored_Data("Horde");
		else
			EFM_Data_ImportKnownTimes("Horde");
		end
	elseif (myOptionName == "EFM_GUI_Options_Frame_LoadDruid") then
		EFM_Load_Stored_Data("Druid");
	end
end

-- Function: Handler routine for the divider OnShow events
function EFM_GUI_DividerOnShow(myOption)
	if (myOption:GetName() == "EFM_GUI_Options_Frame_LoadDivider") then
		EFM_GUI_Options_Frame_LoadDividerHeaderText:SetText(EFM_GUITEXT_LoadHeader);
	end
end

-- Function: Handler for when a slider value is changed.
function EFM_GUI_SliderChanged(mySlider)
	local sliderName	= mySlider:GetName();
	local myValue	= mySlider:GetValue();

	if (sliderName == "EFM_GUI_Options_Frame_Slider_Display") then
		EFM_MyConf.TimerPosition = myValue;
	end

	EFM_GUI_OnShow();
end
