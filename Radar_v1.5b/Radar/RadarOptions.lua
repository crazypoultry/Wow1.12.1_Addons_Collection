function RadarOptions_Toggle()
	if(RadarOptionsFrame:IsVisible()) then
		RadarOptionsFrame:Hide();
		Radar_LockMovement();
	else
	    RadarOptions_Init();
		RadarOptionsFrame:Show();
		Radar_UnlockMovement();
	end
end

--****************************************

function RadarSlider_Toggle(type)
	if(not type) then
		RadarSliderFrame:Hide();
		RadarOptions_Toggle();
	else
		RadarOptions_Toggle();
	    RadarSlider_Init(type);
		RadarSliderFrame:Show();
	end
end

--****************************************

function RadarOptions_OnLoad()
	--UIPanelWindows['RadarOptionsFrame'] = {area = 'center', pushable = 0};
end

--****************************************

function RadarSlider_Init(type)
    if( type == 1) then
        RadarSliderSlider:SetMinMaxValues(5,RadarOptions.Display.Time.MThreat);
        RadarSliderSliderLow:SetText("5");
        RadarSliderSliderHigh:SetText(RadarOptions.Display.Time.MThreat);
        RadarSliderSlider:SetValueStep(5);
        RadarSliderSliderText:SetText("High Threat Time: " .. RadarOptions.Display.Time.HThreat);
        RadarOptions_SliderChange = function(x) RadarOptions_SetHThreatTime(x) end;
        RadarSliderSlider:SetValue(RadarOptions.Display.Time.HThreat);
    elseif( type == 2) then
        RadarSliderSlider:SetMinMaxValues(RadarOptions.Display.Time.HThreat,RadarOptions.Display.Time.LThreat);
        RadarSliderSliderLow:SetText(RadarOptions.Display.Time.HThreat);
        RadarSliderSliderHigh:SetText(RadarOptions.Display.Time.LThreat);
        RadarSliderSlider:SetValueStep(5);
        RadarSliderSliderText:SetText("Medium Threat Time: " .. RadarOptions.Display.Time.MThreat);
        RadarOptions_SliderChange = function(x) RadarOptions_SetMThreatTime(x) end;
        RadarSliderSlider:SetValue(RadarOptions.Display.Time.MThreat);
    else -- ( type == 3)
        RadarSliderSlider:SetMinMaxValues(RadarOptions.Display.Time.MThreat,300);
        RadarSliderSliderLow:SetText(RadarOptions.Display.Time.MThreat);
        RadarSliderSliderHigh:SetText("300");
        RadarSliderSlider:SetValueStep(5);
        RadarSliderSliderText:SetText("Low Threat Time: " .. RadarOptions.Display.Time.LThreat);
        RadarOptions_SliderChange = function(x) RadarOptions_SetLThreatTime(x) end;
        RadarSliderSlider:SetValue(RadarOptions.Display.Time.LThreat);
    end  
end

--****************************************

function RadarOptions_Init()
	RadarOptionsBorderButton:SetChecked(RadarOptions.Display.ShowBorder);
	RadarOptionsGuildButton:SetChecked(RadarOptions.Display.ShowGuild);
	RadarOptionsSoundButton:SetChecked(RadarOptions.Sound);
	RadarOptionsDebugButton:SetChecked(RadarOptions.Debug);
	RadarOptionsMaxSizeSlider:SetValue(RadarOptions.Display.MaxSize);
	RadarOptionsWindowColorButton:SetBackdropColor(
		RadarOptions.Display.Colors.Window[1],
		RadarOptions.Display.Colors.Window[2],
		RadarOptions.Display.Colors.Window[3],
		1-RadarOptions.Display.Colors.Window[4]);
	RadarOptionsHThreatColorButton:SetBackdropColor(
		RadarOptions.Display.Colors.HThreat[1],
		RadarOptions.Display.Colors.HThreat[2],
		RadarOptions.Display.Colors.HThreat[3],
		1);
	RadarOptionsMThreatColorButton:SetBackdropColor(
		RadarOptions.Display.Colors.MThreat[1],
		RadarOptions.Display.Colors.MThreat[2],
		RadarOptions.Display.Colors.MThreat[3],
		1);	
	RadarOptionsLThreatColorButton:SetBackdropColor(
		RadarOptions.Display.Colors.LThreat[1],
		RadarOptions.Display.Colors.LThreat[2],
		RadarOptions.Display.Colors.LThreat[3],
		1);
	RadarOptionsHThreatTimeButtonText:SetText("High Threat Time: " .. RadarOptions.Display.Time.HThreat);
	RadarOptionsHThreatTimeButton:SetBackdropColor(0,0,0,1);
	RadarOptionsMThreatTimeButtonText:SetText("Medium Threat Time: " .. RadarOptions.Display.Time.MThreat);
	RadarOptionsMThreatTimeButton:SetBackdropColor(0,0,0,1);
	RadarOptionsLThreatTimeButtonText:SetText("Low Threat Time: " .. RadarOptions.Display.Time.LThreat);
	RadarOptionsLThreatTimeButton:SetBackdropColor(0,0,0,1);		
end

--*******************************************
--*** Functions called from Options frame ***
--*******************************************

function RadarOptions_ToggleBorderShow()
	if( RadarOptions.Display.ShowBorder) then
		RadarOptions.Display.ShowBorder = false;
	else
		RadarOptions.Display.ShowBorder = true;
	end
	Radar_InitUI();
end

--****************************************

function RadarOptions_ToggleGuildShow()
	if( RadarOptions.Display.ShowGuild) then
		RadarOptions.Display.ShowGuild = false;
	else
		RadarOptions.Display.ShowGuild = true;
	end
	Radar_InitUI();
end

--****************************************

function RadarOptions_ToggleSound()
	if( RadarOptions.Sound) then
		RadarOptions.Sound = false;
	else
		RadarOptions.Sound = true;
	end
end

--****************************************

function RadarOptions_ToggleDebug()
	if( RadarOptions.Debug) then
		RadarOptions.Debug = false;
	else
		RadarOptions.Debug = true;
	end
end

--****************************************
local Radar_ColorPickerFrameColorChanges = {
	["Window"] = function(x) Radar_ColorPickerFrameColorChange("Window",x) end,
	["HThreat"] = function(x) Radar_ColorPickerFrameColorChange("HThreat",x) end,
	["MThreat"] = function(x) Radar_ColorPickerFrameColorChange("MThreat",x) end,
	["LThreat"] = function(x) Radar_ColorPickerFrameColorChange("LThreat",x) end
};

local Radar_ColorPickerFrameCancels = {
	["Window"] = function(x) Radar_ColorPickerFrameCancel("Window",x) end,
	["HThreat"] = function(x) Radar_ColorPickerFrameCancel("HThreat",x) end,
	["MThreat"] = function(x) Radar_ColorPickerFrameCancel("MThreat",x) end,
	["LThreat"] = function(x) Radar_ColorPickerFrameCancel("LThreat",x) end
};

local Radar_ColorPickerFrameHasOpacity = {
	["Window"] = true,
	["HThreat"] = false,
	["MThreat"] = false,
	["LThreat"] = false
};

local Radar_ColorPickerFrameOpacityChanges = {
	["Window"] = function(x) Radar_ColorPickerFrameOpacityChange("Window",x) end
};





function RadarOptions_SetColor(path)
    if (Radar_ColorPickerFrameHasOpacity[path]) then
	    ColorPickerFrame.hasOpacity = true;
	    ColorPickerFrame.opacityFunc = Radar_ColorPickerFrameOpacityChanges[path];
	    ColorPickerFrame.opacity = RadarOptions.Display.Colors[path][4];
	else
	    ColorPickerFrame.hasOpacity = false;
	end
	
	ColorPickerFrame.func = Radar_ColorPickerFrameColorChanges[path];
	ColorPickerFrame.cancelFunc = Radar_ColorPickerFrameCancels[path];
	ColorPickerFrame.previousValues = {RadarOptions.Display.Colors[path][1],RadarOptions.Display.Colors[path][2],RadarOptions.Display.Colors[path][3],RadarOptions.Display.Colors[path][4]};
	ColorPickerFrame:SetColorRGB(RadarOptions.Display.Colors[path][1],RadarOptions.Display.Colors[path][2],RadarOptions.Display.Colors[path][3]);
	
	RadarOptionsFrame:Hide();
	ColorPickerFrame:Show();
end

function Radar_ColorPickerFrameColorChange(path)
    -- this function is also activated when OK button is pressed
    if( not ColorPickerFrame:IsVisible()) then
        RadarOptions_Init();
        RadarOptionsFrame:Show();
    else
	    local R,G,B = ColorPickerFrame:GetColorRGB();
	    RadarOptions.Display.Colors[path][1] = R;
	    RadarOptions.Display.Colors[path][2] = G;
	    RadarOptions.Display.Colors[path][3] = B;
        Radar_InitUI();
	end
end

function Radar_ColorPickerFrameOpacityChange(path)
	local O = OpacitySliderFrame:GetValue();
	RadarOptions.Display.Colors[path][4] = O;
	Radar_InitUI();
end

function Radar_ColorPickerFrameCancel(path,prevvals)
    local R,G,B,O = unpack(prevvals);
	RadarOptions.Display.Colors[path][1] = R;
	RadarOptions.Display.Colors[path][2] = G;
	RadarOptions.Display.Colors[path][3] = B;
	RadarOptions.Display.Colors[path][4] = O;
	RadarOptions_Init();
    RadarOptionsFrame:Show();
	Radar_InitUI();
end;

--****************************************

function RadarOptions_SetMaxSize(lines)
	RadarOptions.Display.MaxSize = lines;
	Radar_InitUI();
end

--****************************************

function RadarOptions_SliderChange(time)
    
end

function RadarOptions_SetHThreatTime(time)
    RadarOptions.Display.Time.HThreat = time;
    RadarSliderSliderText:SetText("High Threat Time: " .. RadarOptions.Display.Time.HThreat);
end

function RadarOptions_SetMThreatTime(time)
    RadarOptions.Display.Time.MThreat = time;
    RadarSliderSliderText:SetText("Medium Threat Time: " .. RadarOptions.Display.Time.MThreat);
end

function RadarOptions_SetLThreatTime(time)
    RadarOptions.Display.Time.LThreat = time;
    RadarSliderSliderText:SetText("Low Threat Time: " .. RadarOptions.Display.Time.LThreat);
end