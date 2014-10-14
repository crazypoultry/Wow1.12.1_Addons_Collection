ZHunterButtonAspect_MaxButtons = 6

function ZHunterButtonAspect_SetupOptions()
	local temp

	temp = ZHunterMod_Saved["ZHunterButtonAspect"]["children"]["size"]
	ZHunterButtonAspectOptionsButtonSizeSliderText:SetText("Button Size")
	ZHunterButtonAspectOptionsButtonSizeSliderLow:SetText("10")
	ZHunterButtonAspectOptionsButtonSizeSliderHigh:SetText("100")
	ZHunterButtonAspectOptionsButtonSizeSlider:SetMinMaxValues(10, 100)
	ZHunterButtonAspectOptionsButtonSizeSlider:SetValueStep(1)
	ZHunterButtonAspectOptionsButtonSizeSlider:SetValue(temp)
	ZHunterButtonAspectOptionsButtonSizeText:SetText(temp)

	temp = ZHunterMod_Saved["ZHunterButtonAspect"]["parent"]["size"]
	ZHunterButtonAspectOptionsMainButtonSizeSliderText:SetText("Button Size")
	ZHunterButtonAspectOptionsMainButtonSizeSliderLow:SetText("10")
	ZHunterButtonAspectOptionsMainButtonSizeSliderHigh:SetText("100")
	ZHunterButtonAspectOptionsMainButtonSizeSlider:SetMinMaxValues(10, 100)
	ZHunterButtonAspectOptionsMainButtonSizeSlider:SetValueStep(1)
	ZHunterButtonAspectOptionsMainButtonSizeSlider:SetValue(temp)
	ZHunterButtonAspectOptionsMainButtonSizeText:SetText(temp)

	temp = ZHunterMod_Saved["ZHunterButtonAspect"]["count"]
	ZHunterButtonAspectOptionsButtonCountSliderText:SetText("Buttons Displayed")
	ZHunterButtonAspectOptionsButtonCountSliderLow:SetText("2")
	ZHunterButtonAspectOptionsButtonCountSliderHigh:SetText(ZHunterButtonAspect_MaxButtons)
	ZHunterButtonAspectOptionsButtonCountSlider:SetMinMaxValues(2, ZHunterButtonAspect_MaxButtons)
	ZHunterButtonAspectOptionsButtonCountSlider:SetValueStep(1)
	ZHunterButtonAspectOptionsButtonCountSlider:SetValue(temp)
	ZHunterButtonAspectOptionsButtonCountText:SetText(temp)

	temp = ZHunterMod_Saved["ZHunterButtonAspect"]["rows"]
	ZHunterButtonAspectOptionsGraphicRowsSliderText:SetText("Number of Rows")
	ZHunterButtonAspectOptionsGraphicRowsSliderLow:SetText("1")
	ZHunterButtonAspectOptionsGraphicRowsSliderHigh:SetText(ZHunterButtonAspect_MaxButtons)
	ZHunterButtonAspectOptionsGraphicRowsSlider:SetMinMaxValues(1, ZHunterButtonAspect_MaxButtons)
	ZHunterButtonAspectOptionsGraphicRowsSlider:SetValueStep(1)
	ZHunterButtonAspectOptionsGraphicRowsSlider:SetValue(temp)
	ZHunterButtonAspectOptionsGraphicRowsText:SetText(temp)

	temp = ZHunterMod_Saved["ZHunterButtonAspect"]["children"]["hideonclick"]
	ZHunterButtonAspectOptionsButtonHide:SetChecked(temp)
	if temp then
		ZHunterButtonAspect.children:Hide()
	else
		ZHunterButtonAspect.children:Show()
	end
	ZHunterButtonAspect.hideonclick = temp

	temp = ZHunterMod_Saved["ZHunterButtonAspect"]["parent"]["hide"]
	ZHunterButtonAspectOptionsMainButtonHide:SetChecked(temp)
	if temp then
		ZHunterButtonAspect:Hide()
	end

	temp = ZHunterMod_Saved["ZHunterButtonAspect"]["tooltip"]
	ZHunterButtonAspectOptionsButtonTip:SetChecked(temp)
	ZHunterButtonAspect.tooltip = temp

	temp = ZHunterMod_Saved["ZHunterButtonAspect"]["horizontal"]
	if temp then
		ZHunterButtonAspectOptionsGraphicHorizontalDropDownText:SetText("LEFT")
	else
		ZHunterButtonAspectOptionsGraphicHorizontalDropDownText:SetText("RIGHT")		
	end

	temp = ZHunterMod_Saved["ZHunterButtonAspect"]["vertical"]
	if temp then
		ZHunterButtonAspectOptionsGraphicVerticalDropDownText:SetText("TOP")
	else
		ZHunterButtonAspectOptionsGraphicVerticalDropDownText:SetText("BOTTOM")
	end

	temp = ZHunterMod_Saved["ZHunterButtonAspect"]["firstbutton"]
	ZHunterButtonAspectOptionsGraphicFirstButtonDropDownText:SetText(temp)

	temp = ZHunterMod_Saved["ZHunterButtonAspect"]["parent"]["circle"]
	if temp then
		ZHunterButtonAspect.circle:Show()
		ZHunterButtonAspectOptionsMainButtonCircle:SetChecked(1)
	else
		ZHunterButtonAspect.circle:Hide()
		ZHunterButtonAspectOptionsMainButtonCircle:SetChecked(0)
	end

	for i=1, ZHunterButtonAspect_MaxButtons do
		temp = ZHunterMod_Aspect_Spells[ZHunterMod_Saved["ZHunterButtonAspect"]["spells"][i]]
		getglobal("ZHunterButtonAspectOptionsAdvancedOrder"..i.."Text"):SetText(temp)
		getglobal("ZHunterButtonAspectOptionsAdvancedOrder"..i):Show()
		getglobal("ZHunterButtonAspectOptionsAdvancedOrder"..i.."Plus").func = ZHunterButtonAspectOptions_OrderButton
		getglobal("ZHunterButtonAspectOptionsAdvancedOrder"..i.."Minus").func = ZHunterButtonAspectOptions_OrderButton
	end

	ZHunterButtonAspectOptionsHeaderText:SetText("ZAspect Options")
	ZHunterButtonAspectOptionsButtonSizeSlider.func = ZHunterButtonAspectOptions_SliderChanged
	ZHunterButtonAspectOptionsButtonCountSlider.func = ZHunterButtonAspectOptions_SliderChanged
	ZHunterButtonAspectOptionsMainButtonSizeSlider.func = ZHunterButtonAspectOptions_SliderChanged
	ZHunterButtonAspectOptionsGraphicRowsSlider.func = ZHunterButtonAspectOptions_SliderChanged
	ZHunterButtonAspectOptionsButtonHide.func = ZHunterButtonAspectOptions_CheckButton
	ZHunterButtonAspectOptionsButtonTip.func = ZHunterButtonAspectOptions_CheckButton
	ZHunterButtonAspectOptionsMainButtonHide.func = ZHunterButtonAspectOptions_CheckButton
	ZHunterButtonAspectOptionsMainButtonCircle.func = ZHunterButtonAspectOptions_CheckButton
	ZHunterButtonAspectOptionsGraphicHorizontalDropDown.func = function()
		UIDropDownMenu_Initialize(ZHunterButtonAspectOptionsGraphicHorizontalDropDown, ZHunterButtonAspectOptionsHorizontalDropDown_Initialize)
	end
	ZHunterButtonAspectOptionsGraphicVerticalDropDown.func = function()
		UIDropDownMenu_Initialize(ZHunterButtonAspectOptionsGraphicVerticalDropDown, ZHunterButtonAspectOptionsVerticalDropDown_Initialize)
	end
	ZHunterButtonAspectOptionsGraphicFirstButtonDropDown.func = function()
		UIDropDownMenu_Initialize(ZHunterButtonAspectOptionsGraphicFirstButtonDropDown, ZHunterButtonAspectOptionsFirstButtonDropDown_Initialize)
	end
end

function ZHunterButtonAspectOptions_SliderChanged(slider)
	if not slider then
		slider = this
	end
	local id = slider:GetID()
	local value = slider:GetValue()
	if id == 1 then
		ZHunterButtonAspectOptionsButtonSizeText:SetText(value)
		ZHunterMod_Saved["ZHunterButtonAspect"]["children"]["size"] = value
	elseif id == 2 then
		if value > ZHunterButtonAspect.found then
			value = ZHunterButtonAspect.found
			slider:SetValue(value)
		end
		ZHunterButtonAspectOptionsButtonCountText:SetText(value)
		ZHunterMod_Saved["ZHunterButtonAspect"]["count"] = value
	elseif id == 3 then
		ZHunterButtonAspectOptionsMainButtonSizeText:SetText(value)
		ZHunterMod_Saved["ZHunterButtonAspect"]["parent"]["size"] = value
	elseif id == 4 then
		ZHunterButtonAspectOptionsGraphicRowsText:SetText(value)
		ZHunterMod_Saved["ZHunterButtonAspect"]["rows"] = value
	end
	ZHunterButtonAspect_SetupSizeAndPosition()
end

function ZHunterButtonAspectOptions_CheckButton(button)
	if not button then
		button = this
	end
	local id = button:GetID()
	local checked = button:GetChecked()
	if id == 1 then
		if checked == 1 then
			ZHunterMod_Saved["ZHunterButtonAspect"]["children"]["hideonclick"] = 1
		else
			ZHunterMod_Saved["ZHunterButtonAspect"]["children"]["hideonclick"] = nil
		end
		ZHunterButtonAspect.hideonclick = ZHunterMod_Saved["ZHunterButtonAspect"]["children"]["hideonclick"]
	elseif id == 2 then
		if checked == 1 then
			ZHunterMod_Saved["ZHunterButtonAspect"]["parent"]["hide"] = 1
			ZHunterButtonAspect:Hide()
		else
			ZHunterMod_Saved["ZHunterButtonAspect"]["parent"]["hide"] = nil
			ZHunterButtonAspect:Show()
		end
	elseif id == 3 then
		if checked == 1 then
			ZHunterMod_Saved["ZHunterButtonAspect"]["parent"]["circle"] = 1
			ZHunterButtonAspect.circle:Show()
		else
			ZHunterMod_Saved["ZHunterButtonAspect"]["parent"]["circle"] = nil
			ZHunterButtonAspect.circle:Hide()
		end
		ZHunterButtonAspect_SetupSizeAndPosition()
	elseif id == 4 then
		if checked == 1 then
			ZHunterMod_Saved["ZHunterButtonAspect"]["tooltip"] = 1
		else
			ZHunterMod_Saved["ZHunterButtonAspect"]["tooltip"] = nil
		end
		ZHunterButtonAspect.tooltip = ZHunterMod_Saved["ZHunterButtonAspect"]["tooltip"]
	end
end

function ZHunterButtonAspectOptions_OrderButton(button)
	if not button then
		button = this
	end
	local id = this:GetParent():GetID()
	local prevButton = getglobal("ZHunterButtonAspectOptionsAdvancedOrder"..(id-1))
	local currButton = this:GetParent()
	local nextButton = getglobal("ZHunterButtonAspectOptionsAdvancedOrder"..(id+1))
	if button:GetID() == 1 then
		if id ~= 1 then
			local prevID = prevButton:GetID()
			local prevVal = ZHunterMod_Saved["ZHunterButtonAspect"]["spells"][prevID]
			ZHunterMod_Saved["ZHunterButtonAspect"]["spells"][prevID] = ZHunterMod_Saved["ZHunterButtonAspect"]["spells"][id]
			ZHunterMod_Saved["ZHunterButtonAspect"]["spells"][id] = prevVal
			local prevText = getglobal(prevButton:GetName().."Text")
			local currText = getglobal(currButton:GetName().."Text")
			local saveText = prevText:GetText()
			prevText:SetText(currText:GetText())
			currText:SetText(saveText)
		end
	else
		if id ~= ZHunterButtonAspect_MaxButtons then
			local nextID = nextButton:GetID()
			local nextVal = ZHunterMod_Saved["ZHunterButtonAspect"]["spells"][nextID]
			ZHunterMod_Saved["ZHunterButtonAspect"]["spells"][nextID] = ZHunterMod_Saved["ZHunterButtonAspect"]["spells"][id]
			ZHunterMod_Saved["ZHunterButtonAspect"]["spells"][id] = nextVal
			local nextText = getglobal(nextButton:GetName().."Text")
			local currText = getglobal(currButton:GetName().."Text")
			local saveText = nextText:GetText()
			nextText:SetText(currText:GetText())
			currText:SetText(saveText)
		end
	end
	local info = {}
	for i=1, ZHunterButtonAspect_MaxButtons do
		info[i] = ZHunterMod_Aspect_Spells[ZHunterMod_Saved["ZHunterButtonAspect"]["spells"][i]]
	end
	ZSpellButton_SetButtons(ZHunterButtonAspect, info)
end

function ZHunterButtonAspectOptionsHorizontalDropDown_Initialize()
	info = {}
	info.func = function()
		UIDropDownMenu_SetSelectedID(ZHunterButtonAspectOptionsGraphicHorizontalDropDown, this:GetID(), 1)
		if this:GetID() == 1 then
			ZHunterMod_Saved["ZHunterButtonAspect"]["horizontal"] = nil
		else
			ZHunterMod_Saved["ZHunterButtonAspect"]["horizontal"] = 1
		end
		ZHunterButtonAspect_SetupSizeAndPosition()
	end
	info.text = "RIGHT"
	UIDropDownMenu_AddButton(info)
	info.text = "LEFT"
	UIDropDownMenu_AddButton(info)
end

function ZHunterButtonAspectOptionsVerticalDropDown_Initialize()
	info = {}
	info.func = function()
		UIDropDownMenu_SetSelectedID(ZHunterButtonAspectOptionsGraphicVerticalDropDown, this:GetID(), 1)
		if this:GetID() == 1 then
			ZHunterMod_Saved["ZHunterButtonAspect"]["vertical"] = nil
		else
			ZHunterMod_Saved["ZHunterButtonAspect"]["vertical"] = 1
		end
		ZHunterButtonAspect_SetupSizeAndPosition()
	end
	info.text = "BOTTOM"
	UIDropDownMenu_AddButton(info)
	info.text = "TOP"
	UIDropDownMenu_AddButton(info)
end

function ZHunterButtonAspectOptionsFirstButtonDropDown_Initialize()
	info = {}
	info.func = function()
		UIDropDownMenu_SetSelectedID(ZHunterButtonAspectOptionsGraphicFirstButtonDropDown, this:GetID(), 1)
		ZHunterMod_Saved["ZHunterButtonAspect"]["firstbutton"] = ZHunterButtonAspectOptionsGraphicFirstButtonDropDownText:GetText()
		ZHunterButtonAspect_SetupSizeAndPosition()
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