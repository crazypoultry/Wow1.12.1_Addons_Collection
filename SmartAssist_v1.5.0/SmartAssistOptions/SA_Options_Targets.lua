function SA_Options_OnShowListOptions()
	SAShowAvailableCB:SetChecked(SA_OPTIONS.ShowAvailable)
	SAPreservedOrderCB:SetChecked(SA_OPTIONS.PreservedOrder)
	SATankModeCB:SetChecked(SA_OPTIONS.TankMode)
	SAAddMyTargetCB:SetChecked(SA_OPTIONS.AddMyTarget)
	SAOutOfCombatCB:SetChecked(SA_OPTIONS.OutOfCombat)
	SAHideTBYCB:SetChecked(SA_OPTIONS.HideTBY)
	SAHideTitleCB:SetChecked(SA_OPTIONS.HideTitle)
	
	SAListWidthSlider:SetValue(SA_OPTIONS.ListWidth)
	local theme = SA_THEME[SA_OPTIONS.Theme]
	local min = 100
	local max = 200
	if (theme.defaults) then
		if (theme.defaults.widthSlider) then
			min = theme.defaults.widthSlider.min
			max = theme.defaults.widthSlider.max
		end
	end
	SAListWidthSlider:SetMinMaxValues(min,max)
	
	SAListScaleSlider:SetValue(SA_OPTIONS.ListScale)

	SAListSpacingSlider:SetValue(SA_OPTIONS.ListSpacing)
	SAListHorizontalCB:SetChecked(SA_OPTIONS.ListHorizontal)
	SAListTwoRowCB:SetChecked(SA_OPTIONS.ListTwoRow)
	
	SA_Options_UpdateListWidthSlider()
	SA_Options_UpdateListSpacingSlider()
	
	Selection_SetSelectedValue(SAClassIconMode, SA_OPTIONS.ClassIconMode)
	Selection_SetSelectedValue(SATargetIconMode, SA_OPTIONS.TargetIconMode)
	Selection_SetSelectedValue(SAHuntersMarkIconMode, SA_OPTIONS.HuntersMarkIconMode)
	
	SA_Options_DisplayList(true)
end

-------------------------------------------------------------------------------
-- Update list options tab
-------------------------------------------------------------------------------

function SA_Options_ListOnLoad()
	SA_Options_BuildThemeIconPositions()
end

function SA_Options_BuildThemeIconPositions()
	SA_Options_AddIconPositions("SAClassIconMode")
	SA_Options_AddIconPositions("SATargetIconMode")
	SA_Options_AddIconPositions("SAHuntersMarkIconMode")
end

function SA_Options_AddIconPositions(name)
	local c = getglobal(name)
	Selection_ClearValues(c)
	local positions = SA_THEME[SA_OPTIONS.Theme].icons.positions
	for i=1, table.getn(positions) do
		Selection_AddSelection(c, i, positions[i].name)
	end
end

function SA_Options_OnHideListOptions()
	SA_Options_DisplayList(false)
end

function SA_Options_DisplayList(display)
	if (display) then
		SA_List_SetTitleButton(MODE_NORMAL)
	else
		SA_List_SetTitleButton(MODE_OOC)
	end
	for i=1, 10 do
		local tf = SA_TARGET_FRAMES[i]
		if (display) then
			tf.frame:Show()
			tf.mobBar:SetValue(math.random(100))
			tf.mobText:SetText("Name of the mob")
			tf.targetBar:SetValue(math.random(100))
			tf.targetText:SetText("T: target")
			tf.targetOf:SetText("whose target + n")
		else
			tf.frame:Hide()
		end
	end
end

function SA_Options_UpdateListWidthSlider()
	SA_OPTIONS.ListWidth = SAListWidthSlider:GetValue()
	SA_List_UpdateAppearance()
end

function SA_Options_UpdateListScaleSlider()
	SA_OPTIONS.ListScale = SAListScaleSlider:GetValue()
	SAListFrameScaler:SetScale(SA_OPTIONS.ListScale)
	local s = string.sub(tostring(SA_OPTIONS.ListScale),0,4)
	SAListScaleSliderText:SetText("list scale "..s)
end

function SA_Options_UpdateListSpacingSlider()
	SA_OPTIONS.ListSpacing = SAListSpacingSlider:GetValue()
	SA_List_UpdateAppearance()
end

function SA_Options_UpdateListSpacingSliderText()
	if (SA_OPTIONS.ListHorizontal) then
		SAListSpacingSliderHigh:SetText("right")
		SAListSpacingSliderLow:SetText("left")
	else
		SAListSpacingSliderHigh:SetText("up")
		SAListSpacingSliderLow:SetText("down")
	end
end

-- callback from SmartSelection
function SA_Options_ClassIcon(value)
	SA_OPTIONS["ClassIconMode"] = value
	SA_List_UpdateAppearance()
end

-- callback from SmartSelection
function SA_Options_TargetIcon(value)
	SA_OPTIONS["TargetIconMode"] = value
	SA_List_UpdateAppearance()
end

function SA_Options_HuntersMarkIcon(value)
	SA_OPTIONS["HuntersMarkIconMode"] = value
	SA_List_UpdateAppearance()
end


-------------------------------------------------------------------------------
-- Theme dropdown
-------------------------------------------------------------------------------

function SAThemeDD_Initialize()
	SA_THEME_DROPDOWN = {}
	for key,value in pairs(SA_THEMES) do
		item = {}
		item.text = value
		item.func = SAThemeDD_OnClick
		UIDropDownMenu_AddButton(item)
	end
end

function SAThemeDD_OnLoad()
	UIDropDownMenu_Initialize(this, SAThemeDD_Initialize)
	for i,v in pairs(SA_THEMES) do
		if (SA_OPTIONS.Theme==v) then
			UIDropDownMenu_SetSelectedID(this, i)
		end
	end
	UIDropDownMenu_SetWidth(110)
end

function SAThemeDD_OnClick()
	local oldID = UIDropDownMenu_GetSelectedID(SAThemeDD)
	if(oldID ~= this:GetID()) then
		SA_Theme_ChangeTheme(SA_THEMES[this:GetID()])
		SA_Options_BuildThemeIconPositions()
		-- update theme changed controls (icons, spacing)
		SA_Options_OnShowListOptions()
		UIDropDownMenu_SetSelectedID(SAThemeDD, this:GetID())
	end
end