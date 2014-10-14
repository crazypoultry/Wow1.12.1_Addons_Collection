ZHunterButtonTrap_MaxButtons = 5

function ZHunterButtonTrap_SetupOptions()
	local temp

	temp = ZHunterMod_Saved["ZHunterButtonTrap"]["children"]["size"]
	ZHunterButtonTrapOptionsButtonSizeSliderText:SetText("Button Size")
	ZHunterButtonTrapOptionsButtonSizeSliderLow:SetText("10")
	ZHunterButtonTrapOptionsButtonSizeSliderHigh:SetText("100")
	ZHunterButtonTrapOptionsButtonSizeSlider:SetMinMaxValues(10, 100)
	ZHunterButtonTrapOptionsButtonSizeSlider:SetValueStep(1)
	ZHunterButtonTrapOptionsButtonSizeSlider:SetValue(temp)
	ZHunterButtonTrapOptionsButtonSizeText:SetText(temp)

	temp = ZHunterMod_Saved["ZHunterButtonTrap"]["parent"]["size"]
	ZHunterButtonTrapOptionsMainButtonSizeSliderText:SetText("Button Size")
	ZHunterButtonTrapOptionsMainButtonSizeSliderLow:SetText("10")
	ZHunterButtonTrapOptionsMainButtonSizeSliderHigh:SetText("100")
	ZHunterButtonTrapOptionsMainButtonSizeSlider:SetMinMaxValues(10, 100)
	ZHunterButtonTrapOptionsMainButtonSizeSlider:SetValueStep(1)
	ZHunterButtonTrapOptionsMainButtonSizeSlider:SetValue(temp)
	ZHunterButtonTrapOptionsMainButtonSizeText:SetText(temp)

	temp = ZHunterMod_Saved["ZHunterButtonTrap"]["count"]
	ZHunterButtonTrapOptionsButtonCountSliderText:SetText("Buttons Displayed")
	ZHunterButtonTrapOptionsButtonCountSliderLow:SetText("2")
	ZHunterButtonTrapOptionsButtonCountSliderHigh:SetText(ZHunterButtonTrap_MaxButtons)
	ZHunterButtonTrapOptionsButtonCountSlider:SetMinMaxValues(2, ZHunterButtonTrap_MaxButtons)
	ZHunterButtonTrapOptionsButtonCountSlider:SetValueStep(1)
	ZHunterButtonTrapOptionsButtonCountSlider:SetValue(temp)
	ZHunterButtonTrapOptionsButtonCountText:SetText(temp)

	temp = ZHunterMod_Saved["ZHunterButtonTrap"]["rows"]
	ZHunterButtonTrapOptionsGraphicRowsSliderText:SetText("Number of Rows")
	ZHunterButtonTrapOptionsGraphicRowsSliderLow:SetText("1")
	ZHunterButtonTrapOptionsGraphicRowsSliderHigh:SetText(ZHunterButtonTrap_MaxButtons)
	ZHunterButtonTrapOptionsGraphicRowsSlider:SetMinMaxValues(1, ZHunterButtonTrap_MaxButtons)
	ZHunterButtonTrapOptionsGraphicRowsSlider:SetValueStep(1)
	ZHunterButtonTrapOptionsGraphicRowsSlider:SetValue(temp)
	ZHunterButtonTrapOptionsGraphicRowsText:SetText(temp)

	temp = ZHunterMod_Saved["ZHunterButtonTrap"]["children"]["hideonclick"]
	ZHunterButtonTrapOptionsButtonHide:SetChecked(temp)
	if temp then
		ZHunterButtonTrap.children:Hide()
	else
		ZHunterButtonTrap.children:Show()
	end
	ZHunterButtonTrap.hideonclick = temp

	temp = ZHunterMod_Saved["ZHunterButtonTrap"]["parent"]["hide"]
	ZHunterButtonTrapOptionsMainButtonHide:SetChecked(temp)
	if temp then
		ZHunterButtonTrap:Hide()
	end

	temp = ZHunterMod_Saved["ZHunterButtonTrap"]["tooltip"]
	ZHunterButtonTrapOptionsButtonTip:SetChecked(temp)
	ZHunterButtonTrap.tooltip = temp

	temp = ZHunterMod_Saved["ZHunterButtonTrap"]["horizontal"]
	if temp then
		ZHunterButtonTrapOptionsGraphicHorizontalDropDownText:SetText("LEFT")
	else
		ZHunterButtonTrapOptionsGraphicHorizontalDropDownText:SetText("RIGHT")		
	end

	temp = ZHunterMod_Saved["ZHunterButtonTrap"]["vertical"]
	if temp then
		ZHunterButtonTrapOptionsGraphicVerticalDropDownText:SetText("TOP")
	else
		ZHunterButtonTrapOptionsGraphicVerticalDropDownText:SetText("BOTTOM")
	end

	temp = ZHunterMod_Saved["ZHunterButtonTrap"]["firstbutton"]
	ZHunterButtonTrapOptionsGraphicFirstButtonDropDownText:SetText(temp)

	temp = ZHunterMod_Saved["ZHunterButtonTrap"]["parent"]["circle"]
	if temp then
		ZHunterButtonTrap.circle:Show()
		ZHunterButtonTrapOptionsMainButtonCircle:SetChecked(1)
	else
		ZHunterButtonTrap.circle:Hide()
		ZHunterButtonTrapOptionsMainButtonCircle:SetChecked(0)
	end

	for i=1, ZHunterButtonTrap_MaxButtons do
		temp = ZHunterMod_Trap_Spells[ZHunterMod_Saved["ZHunterButtonTrap"]["spells"][i]]
		getglobal("ZHunterButtonTrapOptionsAdvancedOrder"..i.."Text"):SetText(temp)
		getglobal("ZHunterButtonTrapOptionsAdvancedOrder"..i):Show()
		getglobal("ZHunterButtonTrapOptionsAdvancedOrder"..i.."Plus").func = ZHunterButtonTrapOptions_OrderButton
		getglobal("ZHunterButtonTrapOptionsAdvancedOrder"..i.."Minus").func = ZHunterButtonTrapOptions_OrderButton
	end

	ZHunterButtonTrapOptionsHeaderText:SetText("ZTrap Options")
	ZHunterButtonTrapOptionsButtonSizeSlider.func = ZHunterButtonTrapOptions_SliderChanged
	ZHunterButtonTrapOptionsButtonCountSlider.func = ZHunterButtonTrapOptions_SliderChanged
	ZHunterButtonTrapOptionsMainButtonSizeSlider.func = ZHunterButtonTrapOptions_SliderChanged
	ZHunterButtonTrapOptionsGraphicRowsSlider.func = ZHunterButtonTrapOptions_SliderChanged
	ZHunterButtonTrapOptionsButtonHide.func = ZHunterButtonTrapOptions_CheckButton
	ZHunterButtonTrapOptionsButtonTip.func = ZHunterButtonTrapOptions_CheckButton
	ZHunterButtonTrapOptionsMainButtonHide.func = ZHunterButtonTrapOptions_CheckButton
	ZHunterButtonTrapOptionsMainButtonCircle.func = ZHunterButtonTrapOptions_CheckButton
	ZHunterButtonTrapOptionsGraphicHorizontalDropDown.func = function()
		UIDropDownMenu_Initialize(ZHunterButtonTrapOptionsGraphicHorizontalDropDown, ZHunterButtonTrapOptionsHorizontalDropDown_Initialize)
	end
	ZHunterButtonTrapOptionsGraphicVerticalDropDown.func = function()
		UIDropDownMenu_Initialize(ZHunterButtonTrapOptionsGraphicVerticalDropDown, ZHunterButtonTrapOptionsVerticalDropDown_Initialize)
	end
	ZHunterButtonTrapOptionsGraphicFirstButtonDropDown.func = function()
		UIDropDownMenu_Initialize(ZHunterButtonTrapOptionsGraphicFirstButtonDropDown, ZHunterButtonTrapOptionsFirstButtonDropDown_Initialize)
	end
end

function ZHunterButtonTrapOptions_SliderChanged(slider)
	if not slider then
		slider = this
	end
	local id = slider:GetID()
	local value = slider:GetValue()
	if id == 1 then
		ZHunterButtonTrapOptionsButtonSizeText:SetText(value)
		ZHunterMod_Saved["ZHunterButtonTrap"]["children"]["size"] = value
	elseif id == 2 then
		if value > ZHunterButtonTrap.found then
			value = ZHunterButtonTrap.found
			slider:SetValue(value)
		end
		ZHunterButtonTrapOptionsButtonCountText:SetText(value)
		ZHunterMod_Saved["ZHunterButtonTrap"]["count"] = value
	elseif id == 3 then
		ZHunterButtonTrapOptionsMainButtonSizeText:SetText(value)
		ZHunterMod_Saved["ZHunterButtonTrap"]["parent"]["size"] = value
	elseif id == 4 then
		ZHunterButtonTrapOptionsGraphicRowsText:SetText(value)
		ZHunterMod_Saved["ZHunterButtonTrap"]["rows"] = value
	end
	ZHunterButtonTrap_SetupSizeAndPosition()
end

function ZHunterButtonTrapOptions_CheckButton(button)
	if not button then
		button = this
	end
	local id = button:GetID()
	local checked = button:GetChecked()
	if id == 1 then
		if checked == 1 then
			ZHunterMod_Saved["ZHunterButtonTrap"]["children"]["hideonclick"] = 1
		else
			ZHunterMod_Saved["ZHunterButtonTrap"]["children"]["hideonclick"] = nil
		end
		ZHunterButtonTrap.hideonclick = ZHunterMod_Saved["ZHunterButtonTrap"]["children"]["hideonclick"]
	elseif id == 2 then
		if checked == 1 then
			ZHunterMod_Saved["ZHunterButtonTrap"]["parent"]["hide"] = 1
			ZHunterButtonTrap:Hide()
		else
			ZHunterMod_Saved["ZHunterButtonTrap"]["parent"]["hide"] = nil
			ZHunterButtonTrap:Show()
		end
	elseif id == 3 then
		if checked == 1 then
			ZHunterMod_Saved["ZHunterButtonTrap"]["parent"]["circle"] = 1
			ZHunterButtonTrap.circle:Show()
		else
			ZHunterMod_Saved["ZHunterButtonTrap"]["parent"]["circle"] = nil
			ZHunterButtonTrap.circle:Hide()
		end
		ZHunterButtonTrap_SetupSizeAndPosition()
	elseif id == 4 then
		if checked == 1 then
			ZHunterMod_Saved["ZHunterButtonTrap"]["tooltip"] = 1
		else
			ZHunterMod_Saved["ZHunterButtonTrap"]["tooltip"] = nil
		end
		ZHunterButtonTrap.tooltip = ZHunterMod_Saved["ZHunterButtonTrap"]["tooltip"]
	end
end

function ZHunterButtonTrapOptions_OrderButton(button)
	if not button then
		button = this
	end
	local id = this:GetParent():GetID()
	local prevButton = getglobal("ZHunterButtonTrapOptionsAdvancedOrder"..(id-1))
	local currButton = this:GetParent()
	local nextButton = getglobal("ZHunterButtonTrapOptionsAdvancedOrder"..(id+1))
	if button:GetID() == 1 then
		if id ~= 1 then
			local prevID = prevButton:GetID()
			local prevVal = ZHunterMod_Saved["ZHunterButtonTrap"]["spells"][prevID]
			ZHunterMod_Saved["ZHunterButtonTrap"]["spells"][prevID] = ZHunterMod_Saved["ZHunterButtonTrap"]["spells"][id]
			ZHunterMod_Saved["ZHunterButtonTrap"]["spells"][id] = prevVal
			local prevText = getglobal(prevButton:GetName().."Text")
			local currText = getglobal(currButton:GetName().."Text")
			local saveText = prevText:GetText()
			prevText:SetText(currText:GetText())
			currText:SetText(saveText)
		end
	else
		if id ~= ZHunterButtonTrap_MaxButtons then
			local nextID = nextButton:GetID()
			local nextVal = ZHunterMod_Saved["ZHunterButtonTrap"]["spells"][nextID]
			ZHunterMod_Saved["ZHunterButtonTrap"]["spells"][nextID] = ZHunterMod_Saved["ZHunterButtonTrap"]["spells"][id]
			ZHunterMod_Saved["ZHunterButtonTrap"]["spells"][id] = nextVal
			local nextText = getglobal(nextButton:GetName().."Text")
			local currText = getglobal(currButton:GetName().."Text")
			local saveText = nextText:GetText()
			nextText:SetText(currText:GetText())
			currText:SetText(saveText)
		end
	end
	local info = {}
	for i=1, ZHunterButtonTrap_MaxButtons do
		info[i] = ZHunterMod_Trap_Spells[ZHunterMod_Saved["ZHunterButtonTrap"]["spells"][i]]
	end
	ZSpellButton_SetButtons(ZHunterButtonTrap, info)
end

function ZHunterButtonTrapOptionsHorizontalDropDown_Initialize()
	info = {}
	info.func = function()
		UIDropDownMenu_SetSelectedID(ZHunterButtonTrapOptionsGraphicHorizontalDropDown, this:GetID(), 1)
		if this:GetID() == 1 then
			ZHunterMod_Saved["ZHunterButtonTrap"]["horizontal"] = nil
		else
			ZHunterMod_Saved["ZHunterButtonTrap"]["horizontal"] = 1
		end
		ZHunterButtonTrap_SetupSizeAndPosition()
	end
	info.text = "RIGHT"
	UIDropDownMenu_AddButton(info)
	info.text = "LEFT"
	UIDropDownMenu_AddButton(info)
end

function ZHunterButtonTrapOptionsVerticalDropDown_Initialize()
	info = {}
	info.func = function()
		UIDropDownMenu_SetSelectedID(ZHunterButtonTrapOptionsGraphicVerticalDropDown, this:GetID(), 1)
		if this:GetID() == 1 then
			ZHunterMod_Saved["ZHunterButtonTrap"]["vertical"] = nil
		else
			ZHunterMod_Saved["ZHunterButtonTrap"]["vertical"] = 1
		end
		ZHunterButtonTrap_SetupSizeAndPosition()
	end
	info.text = "BOTTOM"
	UIDropDownMenu_AddButton(info)
	info.text = "TOP"
	UIDropDownMenu_AddButton(info)
end

function ZHunterButtonTrapOptionsFirstButtonDropDown_Initialize()
	info = {}
	info.func = function()
		UIDropDownMenu_SetSelectedID(ZHunterButtonTrapOptionsGraphicFirstButtonDropDown, this:GetID(), 1)
		ZHunterMod_Saved["ZHunterButtonTrap"]["firstbutton"] = ZHunterButtonTrapOptionsGraphicFirstButtonDropDownText:GetText()
		ZHunterButtonTrap_SetupSizeAndPosition()
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