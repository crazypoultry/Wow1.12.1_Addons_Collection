ZHunterButtonTrack_MaxButtons = 11

function ZHunterButtonTrack_SetupOptions()
	local temp

	temp = ZHunterMod_Saved["ZHunterButtonTrack"]["children"]["size"]
	ZHunterButtonTrackOptionsButtonSizeSliderText:SetText("Button Size")
	ZHunterButtonTrackOptionsButtonSizeSliderLow:SetText("10")
	ZHunterButtonTrackOptionsButtonSizeSliderHigh:SetText("100")
	ZHunterButtonTrackOptionsButtonSizeSlider:SetMinMaxValues(10, 100)
	ZHunterButtonTrackOptionsButtonSizeSlider:SetValueStep(1)
	ZHunterButtonTrackOptionsButtonSizeSlider:SetValue(temp)
	ZHunterButtonTrackOptionsButtonSizeText:SetText(temp)

	temp = ZHunterMod_Saved["ZHunterButtonTrack"]["parent"]["size"]
	ZHunterButtonTrackOptionsMainButtonSizeSliderText:SetText("Button Size")
	ZHunterButtonTrackOptionsMainButtonSizeSliderLow:SetText("10")
	ZHunterButtonTrackOptionsMainButtonSizeSliderHigh:SetText("100")
	ZHunterButtonTrackOptionsMainButtonSizeSlider:SetMinMaxValues(10, 100)
	ZHunterButtonTrackOptionsMainButtonSizeSlider:SetValueStep(1)
	ZHunterButtonTrackOptionsMainButtonSizeSlider:SetValue(temp)
	ZHunterButtonTrackOptionsMainButtonSizeText:SetText(temp)

	temp = ZHunterMod_Saved["ZHunterButtonTrack"]["count"]
	ZHunterButtonTrackOptionsButtonCountSliderText:SetText("Buttons Displayed")
	ZHunterButtonTrackOptionsButtonCountSliderLow:SetText("2")
	ZHunterButtonTrackOptionsButtonCountSliderHigh:SetText(ZHunterButtonTrack_MaxButtons)
	ZHunterButtonTrackOptionsButtonCountSlider:SetMinMaxValues(2, ZHunterButtonTrack_MaxButtons)
	ZHunterButtonTrackOptionsButtonCountSlider:SetValueStep(1)
	ZHunterButtonTrackOptionsButtonCountSlider:SetValue(temp)
	ZHunterButtonTrackOptionsButtonCountText:SetText(temp)

	temp = ZHunterMod_Saved["ZHunterButtonTrack"]["rows"]
	ZHunterButtonTrackOptionsGraphicRowsSliderText:SetText("Number of Rows")
	ZHunterButtonTrackOptionsGraphicRowsSliderLow:SetText("1")
	ZHunterButtonTrackOptionsGraphicRowsSliderHigh:SetText(ZHunterButtonTrack_MaxButtons)
	ZHunterButtonTrackOptionsGraphicRowsSlider:SetMinMaxValues(1, ZHunterButtonTrack_MaxButtons)
	ZHunterButtonTrackOptionsGraphicRowsSlider:SetValueStep(1)
	ZHunterButtonTrackOptionsGraphicRowsSlider:SetValue(temp)
	ZHunterButtonTrackOptionsGraphicRowsText:SetText(temp)

	temp = ZHunterMod_Saved["ZHunterButtonTrack"]["children"]["hideonclick"]
	ZHunterButtonTrackOptionsButtonHide:SetChecked(temp)
	if temp then
		ZHunterButtonTrack.children:Hide()
	else
		ZHunterButtonTrack.children:Show()
	end
	ZHunterButtonTrack.hideonclick = temp

	temp = ZHunterMod_Saved["ZHunterButtonTrack"]["parent"]["hide"]
	ZHunterButtonTrackOptionsMainButtonHide:SetChecked(temp)
	if temp then
		ZHunterButtonTrack:Hide()
	end

	temp = ZHunterMod_Saved["ZHunterButtonTrack"]["tooltip"]
	ZHunterButtonTrackOptionsButtonTip:SetChecked(temp)
	ZHunterButtonTrack.tooltip = temp

	temp = ZHunterMod_Saved["ZHunterButtonTrack"]["horizontal"]
	if temp then
		ZHunterButtonTrackOptionsGraphicHorizontalDropDownText:SetText("LEFT")
	else
		ZHunterButtonTrackOptionsGraphicHorizontalDropDownText:SetText("RIGHT")		
	end

	temp = ZHunterMod_Saved["ZHunterButtonTrack"]["vertical"]
	if temp then
		ZHunterButtonTrackOptionsGraphicVerticalDropDownText:SetText("TOP")
	else
		ZHunterButtonTrackOptionsGraphicVerticalDropDownText:SetText("BOTTOM")
	end

	temp = ZHunterMod_Saved["ZHunterButtonTrack"]["firstbutton"]
	ZHunterButtonTrackOptionsGraphicFirstButtonDropDownText:SetText(temp)

	temp = ZHunterMod_Saved["ZHunterButtonTrack"]["parent"]["circle"]
	if temp then
		ZHunterButtonTrack.circle:Show()
		ZHunterButtonTrackOptionsMainButtonCircle:SetChecked(1)
	else
		ZHunterButtonTrack.circle:Hide()
		ZHunterButtonTrackOptionsMainButtonCircle:SetChecked(0)
	end

	for i=1, ZHunterButtonTrack_MaxButtons do
		temp = ZHunterMod_Track_Spells[ZHunterMod_Saved["ZHunterButtonTrack"]["spells"][i]]
		getglobal("ZHunterButtonTrackOptionsAdvancedOrder"..i.."Text"):SetText(temp)
		getglobal("ZHunterButtonTrackOptionsAdvancedOrder"..i):Show()
		getglobal("ZHunterButtonTrackOptionsAdvancedOrder"..i.."Plus").func = ZHunterButtonTrackOptions_OrderButton
		getglobal("ZHunterButtonTrackOptionsAdvancedOrder"..i.."Minus").func = ZHunterButtonTrackOptions_OrderButton
	end

	ZHunterButtonTrackOptionsHeaderText:SetText("ZTrack Options")
	ZHunterButtonTrackOptionsButtonSizeSlider.func = ZHunterButtonTrackOptions_SliderChanged
	ZHunterButtonTrackOptionsButtonCountSlider.func = ZHunterButtonTrackOptions_SliderChanged
	ZHunterButtonTrackOptionsMainButtonSizeSlider.func = ZHunterButtonTrackOptions_SliderChanged
	ZHunterButtonTrackOptionsGraphicRowsSlider.func = ZHunterButtonTrackOptions_SliderChanged
	ZHunterButtonTrackOptionsButtonHide.func = ZHunterButtonTrackOptions_CheckButton
	ZHunterButtonTrackOptionsButtonTip.func = ZHunterButtonTrackOptions_CheckButton
	ZHunterButtonTrackOptionsMainButtonHide.func = ZHunterButtonTrackOptions_CheckButton
	ZHunterButtonTrackOptionsMainButtonCircle.func = ZHunterButtonTrackOptions_CheckButton
	ZHunterButtonTrackOptionsGraphicHorizontalDropDown.func = function()
		UIDropDownMenu_Initialize(ZHunterButtonTrackOptionsGraphicHorizontalDropDown, ZHunterButtonTrackOptionsHorizontalDropDown_Initialize)
	end
	ZHunterButtonTrackOptionsGraphicVerticalDropDown.func = function()
		UIDropDownMenu_Initialize(ZHunterButtonTrackOptionsGraphicVerticalDropDown, ZHunterButtonTrackOptionsVerticalDropDown_Initialize)
	end
	ZHunterButtonTrackOptionsGraphicFirstButtonDropDown.func = function()
		UIDropDownMenu_Initialize(ZHunterButtonTrackOptionsGraphicFirstButtonDropDown, ZHunterButtonTrackOptionsFirstButtonDropDown_Initialize)
	end
end

function ZHunterButtonTrackOptions_SliderChanged(slider)
	if not slider then
		slider = this
	end
	local id = slider:GetID()
	local value = slider:GetValue()
	if id == 1 then
		ZHunterButtonTrackOptionsButtonSizeText:SetText(value)
		ZHunterMod_Saved["ZHunterButtonTrack"]["children"]["size"] = value
	elseif id == 2 then
		if value > ZHunterButtonTrack.found then
			value = ZHunterButtonTrack.found
			slider:SetValue(value)
		end
		ZHunterButtonTrackOptionsButtonCountText:SetText(value)
		ZHunterMod_Saved["ZHunterButtonTrack"]["count"] = value
	elseif id == 3 then
		ZHunterButtonTrackOptionsMainButtonSizeText:SetText(value)
		ZHunterMod_Saved["ZHunterButtonTrack"]["parent"]["size"] = value
	elseif id == 4 then
		ZHunterButtonTrackOptionsGraphicRowsText:SetText(value)
		ZHunterMod_Saved["ZHunterButtonTrack"]["rows"] = value
	end
	ZHunterButtonTrack_SetupSizeAndPosition()
end

function ZHunterButtonTrackOptions_CheckButton(button)
	if not button then
		button = this
	end
	local id = button:GetID()
	local checked = button:GetChecked()
	if id == 1 then
		if checked == 1 then
			ZHunterMod_Saved["ZHunterButtonTrack"]["children"]["hideonclick"] = 1
		else
			ZHunterMod_Saved["ZHunterButtonTrack"]["children"]["hideonclick"] = nil
		end
		ZHunterButtonTrack.hideonclick = ZHunterMod_Saved["ZHunterButtonTrack"]["children"]["hideonclick"]
	elseif id == 2 then
		if checked == 1 then
			ZHunterMod_Saved["ZHunterButtonTrack"]["parent"]["hide"] = 1
			ZHunterButtonTrack:Hide()
		else
			ZHunterMod_Saved["ZHunterButtonTrack"]["parent"]["hide"] = nil
			ZHunterButtonTrack:Show()
		end
	elseif id == 3 then
		if checked == 1 then
			ZHunterMod_Saved["ZHunterButtonTrack"]["parent"]["circle"] = 1
			ZHunterButtonTrack.circle:Show()
		else
			ZHunterMod_Saved["ZHunterButtonTrack"]["parent"]["circle"] = nil
			ZHunterButtonTrack.circle:Hide()
		end
		ZHunterButtonTrack_SetupSizeAndPosition()
	elseif id == 4 then
		if checked == 1 then
			ZHunterMod_Saved["ZHunterButtonTrack"]["tooltip"] = 1
		else
			ZHunterMod_Saved["ZHunterButtonTrack"]["tooltip"] = nil
		end
		ZHunterButtonTrack.tooltip = ZHunterMod_Saved["ZHunterButtonTrack"]["tooltip"]
	end
end

function ZHunterButtonTrackOptions_OrderButton(button)
	if not button then
		button = this
	end
	local id = this:GetParent():GetID()
	local prevButton = getglobal("ZHunterButtonTrackOptionsAdvancedOrder"..(id-1))
	local currButton = this:GetParent()
	local nextButton = getglobal("ZHunterButtonTrackOptionsAdvancedOrder"..(id+1))
	if button:GetID() == 1 then
		if id ~= 1 then
			local prevID = prevButton:GetID()
			local prevVal = ZHunterMod_Saved["ZHunterButtonTrack"]["spells"][prevID]
			ZHunterMod_Saved["ZHunterButtonTrack"]["spells"][prevID] = ZHunterMod_Saved["ZHunterButtonTrack"]["spells"][id]
			ZHunterMod_Saved["ZHunterButtonTrack"]["spells"][id] = prevVal
			local prevText = getglobal(prevButton:GetName().."Text")
			local currText = getglobal(currButton:GetName().."Text")
			local saveText = prevText:GetText()
			prevText:SetText(currText:GetText())
			currText:SetText(saveText)
		end
	else
		if id ~= ZHunterButtonTrack_MaxButtons then
			local nextID = nextButton:GetID()
			local nextVal = ZHunterMod_Saved["ZHunterButtonTrack"]["spells"][nextID]
			ZHunterMod_Saved["ZHunterButtonTrack"]["spells"][nextID] = ZHunterMod_Saved["ZHunterButtonTrack"]["spells"][id]
			ZHunterMod_Saved["ZHunterButtonTrack"]["spells"][id] = nextVal
			local nextText = getglobal(nextButton:GetName().."Text")
			local currText = getglobal(currButton:GetName().."Text")
			local saveText = nextText:GetText()
			nextText:SetText(currText:GetText())
			currText:SetText(saveText)
		end
	end
	local info = {}
	for i=1, ZHunterButtonTrack_MaxButtons do
		info[i] = ZHunterMod_Track_Spells[ZHunterMod_Saved["ZHunterButtonTrack"]["spells"][i]]
	end
	ZSpellButton_SetButtons(ZHunterButtonTrack, info)
end

function ZHunterButtonTrackOptionsHorizontalDropDown_Initialize()
	info = {}
	info.func = function()
		UIDropDownMenu_SetSelectedID(ZHunterButtonTrackOptionsGraphicHorizontalDropDown, this:GetID(), 1)
		if this:GetID() == 1 then
			ZHunterMod_Saved["ZHunterButtonTrack"]["horizontal"] = nil
		else
			ZHunterMod_Saved["ZHunterButtonTrack"]["horizontal"] = 1
		end
		ZHunterButtonTrack_SetupSizeAndPosition()
	end
	info.text = "RIGHT"
	UIDropDownMenu_AddButton(info)
	info.text = "LEFT"
	UIDropDownMenu_AddButton(info)
end

function ZHunterButtonTrackOptionsVerticalDropDown_Initialize()
	info = {}
	info.func = function()
		UIDropDownMenu_SetSelectedID(ZHunterButtonTrackOptionsGraphicVerticalDropDown, this:GetID(), 1)
		if this:GetID() == 1 then
			ZHunterMod_Saved["ZHunterButtonTrack"]["vertical"] = nil
		else
			ZHunterMod_Saved["ZHunterButtonTrack"]["vertical"] = 1
		end
		ZHunterButtonTrack_SetupSizeAndPosition()
	end
	info.text = "BOTTOM"
	UIDropDownMenu_AddButton(info)
	info.text = "TOP"
	UIDropDownMenu_AddButton(info)
end

function ZHunterButtonTrackOptionsFirstButtonDropDown_Initialize()
	info = {}
	info.func = function()
		UIDropDownMenu_SetSelectedID(ZHunterButtonTrackOptionsGraphicFirstButtonDropDown, this:GetID(), 1)
		ZHunterMod_Saved["ZHunterButtonTrack"]["firstbutton"] = ZHunterButtonTrackOptionsGraphicFirstButtonDropDownText:GetText()
		ZHunterButtonTrack_SetupSizeAndPosition()
	end
	info.text = "RIGHT"
	info.value = "RIGHT"
	UIDropDownMenu_AddButton(info)
	info.text = "LEFT"
	info.value = "LEFT"
	UIDropDownMenu_AddButton(info)
	info.text = "TOP"
	info.value = "TOP"
	UIDropDownMenu_AddButton(info)
	info.text = "BOTTOM"
	info.value = "BOTTOM"
	UIDropDownMenu_AddButton(info)
end