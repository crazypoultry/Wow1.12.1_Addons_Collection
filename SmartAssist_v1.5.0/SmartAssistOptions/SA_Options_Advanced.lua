
ASSIST_MODIFIER_TEXTS = {"Shift", "Ctrl ", "Alt", "None" };
SA_DROPDOWN_WIDTH=110;

-------------------------------------------------------------------------------
-- Update advanced options tab
-------------------------------------------------------------------------------

function SA_Options_Advanced_OnShow()
	-- set disable slider value & update text
	SADisableSlider:SetValue(SA_OPTIONS.DisableSliderValue);
	SA_Options_UpdateDisableSlider();

	-- checkboxes
	SAPauseResetsOrderCB:SetChecked(SA_OPTIONS.PauseResetsOrder);
	SADisableTargetNearestCB:SetChecked(SA_OPTIONS.DisableTargetNearest);
	SADisablePriorityHealthCB:SetChecked(SA_OPTIONS.DisablePriorityHealth);
	SADisableAssistWithoutPullerCB:SetChecked(SA_OPTIONS.DisableAssistWithoutPuller);
end


function SA_Options_UpdateModifierText()
	if (SA_OPTIONS.AssistKeyMode == 4) then
		SASelectModifierDDInfo:SetText("assisting when selecting players");
	else
		SASelectModifierDDInfo:SetText("assists selected player");
	end
end

-------------------------------------------------------------------------------
-- update disable target
-------------------------------------------------------------------------------

function SA_Options_UpdateDisableSlider()
	SA_OPTIONS.DisableSliderValue = SADisableSlider:GetValue();
	SADisableSliderText:SetText("members > "..SA_OPTIONS.DisableSliderValue);
end

-------------------------------------------------------------------------------
-- SELECT MODIFIER
-------------------------------------------------------------------------------

SELECT_MODIFIER_TEXTS = {"Shift - select", "Ctrl - select", "Alt - select", "Disabled" };

function SASelectModifierDD_Initialize()
	for _,value in SELECT_MODIFIER_TEXTS do
		item = {};
		item.text = value;
		item.func = SASelectModifierDDButton_OnClick; 
		UIDropDownMenu_AddButton(item);
	end
end

function SASelectModifierDD_OnLoad()
	UIDropDownMenu_Initialize(this, SASelectModifierDD_Initialize);
	UIDropDownMenu_SetSelectedID(this, SA_OPTIONS.AssistKeyMode);
	UIDropDownMenu_SetWidth(SA_DROPDOWN_WIDTH);
	SA_Options_UpdateModifierText();
end

function SASelectModifierDDButton_OnClick()
	local oldID = UIDropDownMenu_GetSelectedID(SASelectModifierDD);
	if(oldID ~= this:GetID()) then
		SA_OPTIONS["AssistKeyMode"]=this:GetID()
		UIDropDownMenu_SetSelectedID(SASelectModifierDD, SA_OPTIONS.AssistKeyMode);
		SA_Options_UpdateModifierText();
	end
end

-------------------------------------------------------------------------------
-- ASSIST MODIFIER
-------------------------------------------------------------------------------

function SAAssistModifierDD_Initialize()
	for _,value in ASSIST_MODIFIER_TEXTS do
		item = {};
		item.text = value;
		item.func = SAAssistModifierDDButton_OnClick; 
		UIDropDownMenu_AddButton(item);
	end
end

function SAAssistModifierDD_OnLoad()
	UIDropDownMenu_Initialize(this, SAAssistModifierDD_Initialize);
	UIDropDownMenu_SetSelectedID(this, SA_OPTIONS["DisableAutoCastKeyMode"]);
	UIDropDownMenu_SetWidth(SA_DROPDOWN_WIDTH);
end

function SAAssistModifierDDButton_OnClick()
	local oldID = UIDropDownMenu_GetSelectedID(SAAssistModifierDD);
	if(oldID ~= this:GetID()) then
		SA_OPTIONS["DisableAutoCastKeyMode"]=this:GetID()
		UIDropDownMenu_SetSelectedID(SAAssistModifierDD, SA_OPTIONS.DisableAutoCastKeyMode);
	end
end

-------------------------------------------------------------------------------
-- ASSIST MA ONLY MODIFIER
-------------------------------------------------------------------------------

function SAMAOnlyModifierDD_Initialize()
	for _,value in ASSIST_MODIFIER_TEXTS do
		item = {};
		item.text = value;
		item.func = SAMAOnlyModifierDD_OnClick; 
		UIDropDownMenu_AddButton(item);
	end
end

function SAMAOnlyModifierDD_OnLoad()
	UIDropDownMenu_Initialize(this, SAMAOnlyModifierDD_Initialize);
	UIDropDownMenu_SetSelectedID(this, SA_OPTIONS["AssistMAOnlyMode"]);
	UIDropDownMenu_SetWidth(SA_DROPDOWN_WIDTH);
end

function SAMAOnlyModifierDD_OnClick()
	local oldID = UIDropDownMenu_GetSelectedID(SAMAOnlyModifierDD);
	if(oldID ~= this:GetID()) then
		SA_OPTIONS["AssistMAOnlyMode"]=this:GetID()
		UIDropDownMenu_SetSelectedID(SAMAOnlyModifierDD, SA_OPTIONS.AssistMAOnlyMode);
	end
end


-------------------------------------------------------------------------------
-- RESET MODIFIER
-------------------------------------------------------------------------------

function SAResetModifierDD_Initialize()
	for _,value in ASSIST_MODIFIER_TEXTS do
		item = {};
		item.text = value;
		item.func = SAResetModifierDD_OnClick; 
		UIDropDownMenu_AddButton(item);
	end
end

function SAResetModifierDD_OnLoad()
	UIDropDownMenu_Initialize(this, SAResetModifierDD_Initialize);
	UIDropDownMenu_SetSelectedID(this, SA_OPTIONS["AssistResetMode"]);
	UIDropDownMenu_SetWidth(SA_DROPDOWN_WIDTH);
end

function SAResetModifierDD_OnClick()
	local oldID = UIDropDownMenu_GetSelectedID(SAResetModifierDD);
	if(oldID ~= this:GetID()) then
		SA_OPTIONS["AssistResetMode"]=this:GetID()
		UIDropDownMenu_SetSelectedID(SAResetModifierDD, SA_OPTIONS.AssistResetMode);
	end
end