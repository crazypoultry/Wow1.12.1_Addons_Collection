ZHunterButtonPet_MaxButtons = 9

function ZHunterButtonPet_SetupOptions()
	local temp

	temp = ZHunterMod_Saved["ZHunterButtonPet"]["children"]["size"]
	ZHunterButtonPetOptionsButtonSizeSliderText:SetText("Button Size")
	ZHunterButtonPetOptionsButtonSizeSliderLow:SetText("10")
	ZHunterButtonPetOptionsButtonSizeSliderHigh:SetText("100")
	ZHunterButtonPetOptionsButtonSizeSlider:SetMinMaxValues(10, 100)
	ZHunterButtonPetOptionsButtonSizeSlider:SetValueStep(1)
	ZHunterButtonPetOptionsButtonSizeSlider:SetValue(temp)
	ZHunterButtonPetOptionsButtonSizeText:SetText(temp)

	temp = ZHunterMod_Saved["ZHunterButtonPet"]["parent"]["size"]
	ZHunterButtonPetOptionsMainButtonSizeSliderText:SetText("Button Size")
	ZHunterButtonPetOptionsMainButtonSizeSliderLow:SetText("10")
	ZHunterButtonPetOptionsMainButtonSizeSliderHigh:SetText("100")
	ZHunterButtonPetOptionsMainButtonSizeSlider:SetMinMaxValues(10, 100)
	ZHunterButtonPetOptionsMainButtonSizeSlider:SetValueStep(1)
	ZHunterButtonPetOptionsMainButtonSizeSlider:SetValue(temp)
	ZHunterButtonPetOptionsMainButtonSizeText:SetText(temp)

	temp = ZHunterMod_Saved["ZHunterButtonPet"]["count"]
	ZHunterButtonPetOptionsButtonCountSliderText:SetText("Buttons Displayed")
	ZHunterButtonPetOptionsButtonCountSliderLow:SetText("2")
	ZHunterButtonPetOptionsButtonCountSliderHigh:SetText(ZHunterButtonPet_MaxButtons)
	ZHunterButtonPetOptionsButtonCountSlider:SetMinMaxValues(2, ZHunterButtonPet_MaxButtons)
	ZHunterButtonPetOptionsButtonCountSlider:SetValueStep(1)
	ZHunterButtonPetOptionsButtonCountSlider:SetValue(temp)
	ZHunterButtonPetOptionsButtonCountText:SetText(temp)

	temp = ZHunterMod_Saved["ZHunterButtonPet"]["rows"]
	ZHunterButtonPetOptionsGraphicRowsSliderText:SetText("Number of Rows")
	ZHunterButtonPetOptionsGraphicRowsSliderLow:SetText("1")
	ZHunterButtonPetOptionsGraphicRowsSliderHigh:SetText(ZHunterButtonPet_MaxButtons)
	ZHunterButtonPetOptionsGraphicRowsSlider:SetMinMaxValues(1, ZHunterButtonPet_MaxButtons)
	ZHunterButtonPetOptionsGraphicRowsSlider:SetValueStep(1)
	ZHunterButtonPetOptionsGraphicRowsSlider:SetValue(temp)
	ZHunterButtonPetOptionsGraphicRowsText:SetText(temp)

	temp = ZHunterMod_Saved["ZHunterButtonPet"]["children"]["hideonclick"]
	ZHunterButtonPetOptionsButtonHide:SetChecked(temp)
	if temp then
		ZHunterButtonPet.children:Hide()
	else
		ZHunterButtonPet.children:Show()
	end
	ZHunterButtonPet.hideonclick = temp

	temp = ZHunterMod_Saved["ZHunterButtonPet"]["parent"]["hide"]
	ZHunterButtonPetOptionsMainButtonHide:SetChecked(temp)
	if temp then
		ZHunterButtonPet:Hide()
	end

	temp = ZHunterMod_Saved["ZHunterButtonPet"]["tooltip"]
	ZHunterButtonPetOptionsButtonTip:SetChecked(temp)
	ZHunterButtonPet.tooltip = temp

	temp = ZHunterMod_Saved["ZHunterButtonPet"]["horizontal"]
	if temp then
		ZHunterButtonPetOptionsGraphicHorizontalDropDownText:SetText("LEFT")
	else
		ZHunterButtonPetOptionsGraphicHorizontalDropDownText:SetText("RIGHT")		
	end

	temp = ZHunterMod_Saved["ZHunterButtonPet"]["vertical"]
	if temp then
		ZHunterButtonPetOptionsGraphicVerticalDropDownText:SetText("TOP")
	else
		ZHunterButtonPetOptionsGraphicVerticalDropDownText:SetText("BOTTOM")
	end

	temp = ZHunterMod_Saved["ZHunterButtonPet"]["firstbutton"]
	ZHunterButtonPetOptionsGraphicFirstButtonDropDownText:SetText(temp)

	temp = ZHunterMod_Saved["ZHunterButtonPet"]["parent"]["circle"]
	if temp then
		ZHunterButtonPet.circle:Show()
		ZHunterButtonPetOptionsMainButtonCircle:SetChecked(1)
	else
		ZHunterButtonPet.circle:Hide()
		ZHunterButtonPetOptionsMainButtonCircle:SetChecked(0)
	end

	for i=1, ZHunterButtonPet_MaxButtons do
		temp = ZHunterMod_Pet_Spells[ZHunterMod_Saved["ZHunterButtonPet"]["spells"][i]]
		getglobal("ZHunterButtonPetOptionsAdvancedOrder"..i.."Text"):SetText(temp)
		getglobal("ZHunterButtonPetOptionsAdvancedOrder"..i):Show()
		getglobal("ZHunterButtonPetOptionsAdvancedOrder"..i.."Plus").func = ZHunterButtonPetOptions_OrderButton
		getglobal("ZHunterButtonPetOptionsAdvancedOrder"..i.."Minus").func = ZHunterButtonPetOptions_OrderButton
	end

	ZHunterButtonPetOptionsHeaderText:SetText("ZPet Options")
	ZHunterButtonPetOptionsButtonSizeSlider.func = ZHunterButtonPetOptions_SliderChanged
	ZHunterButtonPetOptionsButtonCountSlider.func = ZHunterButtonPetOptions_SliderChanged
	ZHunterButtonPetOptionsMainButtonSizeSlider.func = ZHunterButtonPetOptions_SliderChanged
	ZHunterButtonPetOptionsGraphicRowsSlider.func = ZHunterButtonPetOptions_SliderChanged
	ZHunterButtonPetOptionsButtonHide.func = ZHunterButtonPetOptions_CheckButton
	ZHunterButtonPetOptionsButtonTip.func = ZHunterButtonPetOptions_CheckButton
	ZHunterButtonPetOptionsMainButtonHide.func = ZHunterButtonPetOptions_CheckButton
	ZHunterButtonPetOptionsMainButtonCircle.func = ZHunterButtonPetOptions_CheckButton
	ZHunterButtonPetOptionsGraphicHorizontalDropDown.func = function()
		UIDropDownMenu_Initialize(ZHunterButtonPetOptionsGraphicHorizontalDropDown, ZHunterButtonPetOptionsHorizontalDropDown_Initialize)
	end
	ZHunterButtonPetOptionsGraphicVerticalDropDown.func = function()
		UIDropDownMenu_Initialize(ZHunterButtonPetOptionsGraphicVerticalDropDown, ZHunterButtonPetOptionsVerticalDropDown_Initialize)
	end
	ZHunterButtonPetOptionsGraphicFirstButtonDropDown.func = function()
		UIDropDownMenu_Initialize(ZHunterButtonPetOptionsGraphicFirstButtonDropDown, ZHunterButtonPetOptionsFirstButtonDropDown_Initialize)
	end
end

function ZHunterButtonPetOptions_SliderChanged(slider)
	if not slider then
		slider = this
	end
	local id = slider:GetID()
	local value = slider:GetValue()
	if id == 1 then
		ZHunterButtonPetOptionsButtonSizeText:SetText(value)
		ZHunterMod_Saved["ZHunterButtonPet"]["children"]["size"] = value
	elseif id == 2 then
		if value > ZHunterButtonPet.found then
			value = ZHunterButtonPet.found
			slider:SetValue(value)
		end
		ZHunterButtonPetOptionsButtonCountText:SetText(value)
		ZHunterMod_Saved["ZHunterButtonPet"]["count"] = value
	elseif id == 3 then
		ZHunterButtonPetOptionsMainButtonSizeText:SetText(value)
		ZHunterMod_Saved["ZHunterButtonPet"]["parent"]["size"] = value
	elseif id == 4 then
		ZHunterButtonPetOptionsGraphicRowsText:SetText(value)
		ZHunterMod_Saved["ZHunterButtonPet"]["rows"] = value
	end
	ZHunterButtonPet_SetupSizeAndPosition()
end

function ZHunterButtonPetOptions_CheckButton(button)
	if not button then
		button = this
	end
	local id = button:GetID()
	local checked = button:GetChecked()
	if id == 1 then
		if checked == 1 then
			ZHunterMod_Saved["ZHunterButtonPet"]["children"]["hideonclick"] = 1
		else
			ZHunterMod_Saved["ZHunterButtonPet"]["children"]["hideonclick"] = nil
		end
		ZHunterButtonPet.hideonclick = ZHunterMod_Saved["ZHunterButtonPet"]["children"]["hideonclick"]
	elseif id == 2 then
		if checked == 1 then
			ZHunterMod_Saved["ZHunterButtonPet"]["parent"]["hide"] = 1
			ZHunterButtonPet:Hide()
		else
			ZHunterMod_Saved["ZHunterButtonPet"]["parent"]["hide"] = nil
			ZHunterButtonPet:Show()
		end
	elseif id == 3 then
		if checked == 1 then
			ZHunterMod_Saved["ZHunterButtonPet"]["parent"]["circle"] = 1
			ZHunterButtonPet.circle:Show()
		else
			ZHunterMod_Saved["ZHunterButtonPet"]["parent"]["circle"] = nil
			ZHunterButtonPet.circle:Hide()
		end
		ZHunterButtonPet_SetupSizeAndPosition()
	elseif id == 4 then
		if checked == 1 then
			ZHunterMod_Saved["ZHunterButtonPet"]["tooltip"] = 1
		else
			ZHunterMod_Saved["ZHunterButtonPet"]["tooltip"] = nil
		end
		ZHunterButtonPet.tooltip = ZHunterMod_Saved["ZHunterButtonPet"]["tooltip"]
	end
end

function ZHunterButtonPetOptions_OrderButton(button)
	if not button then
		button = this
	end
	local id = this:GetParent():GetID()
	local prevButton = getglobal("ZHunterButtonPetOptionsAdvancedOrder"..(id-1))
	local currButton = this:GetParent()
	local nextButton = getglobal("ZHunterButtonPetOptionsAdvancedOrder"..(id+1))
	if button:GetID() == 1 then
		if id ~= 1 then
			local prevID = prevButton:GetID()
			local prevVal = ZHunterMod_Saved["ZHunterButtonPet"]["spells"][prevID]
			ZHunterMod_Saved["ZHunterButtonPet"]["spells"][prevID] = ZHunterMod_Saved["ZHunterButtonPet"]["spells"][id]
			ZHunterMod_Saved["ZHunterButtonPet"]["spells"][id] = prevVal
			local prevText = getglobal(prevButton:GetName().."Text")
			local currText = getglobal(currButton:GetName().."Text")
			local saveText = prevText:GetText()
			prevText:SetText(currText:GetText())
			currText:SetText(saveText)
		end
	else
		if id ~= ZHunterButtonPet_MaxButtons then
			local nextID = nextButton:GetID()
			local nextVal = ZHunterMod_Saved["ZHunterButtonPet"]["spells"][nextID]
			ZHunterMod_Saved["ZHunterButtonPet"]["spells"][nextID] = ZHunterMod_Saved["ZHunterButtonPet"]["spells"][id]
			ZHunterMod_Saved["ZHunterButtonPet"]["spells"][id] = nextVal
			local nextText = getglobal(nextButton:GetName().."Text")
			local currText = getglobal(currButton:GetName().."Text")
			local saveText = nextText:GetText()
			nextText:SetText(currText:GetText())
			currText:SetText(saveText)
		end
	end
	local info = {}
	for i=1, ZHunterButtonPet_MaxButtons do
		info[i] = ZHunterMod_Pet_Spells[ZHunterMod_Saved["ZHunterButtonPet"]["spells"][i]]
	end
	ZSpellButton_SetButtons(ZHunterButtonPet, info)
end

function ZHunterButtonPetOptionsHorizontalDropDown_Initialize()
	info = {}
	info.func = function()
		UIDropDownMenu_SetSelectedID(ZHunterButtonPetOptionsGraphicHorizontalDropDown, this:GetID(), 1)
		if this:GetID() == 1 then
			ZHunterMod_Saved["ZHunterButtonPet"]["horizontal"] = nil
		else
			ZHunterMod_Saved["ZHunterButtonPet"]["horizontal"] = 1
		end
		ZHunterButtonPet_SetupSizeAndPosition()
	end
	info.text = "RIGHT"
	UIDropDownMenu_AddButton(info)
	info.text = "LEFT"
	UIDropDownMenu_AddButton(info)
end

function ZHunterButtonPetOptionsVerticalDropDown_Initialize()
	info = {}
	info.func = function()
		UIDropDownMenu_SetSelectedID(ZHunterButtonPetOptionsGraphicVerticalDropDown, this:GetID(), 1)
		if this:GetID() == 1 then
			ZHunterMod_Saved["ZHunterButtonPet"]["vertical"] = nil
		else
			ZHunterMod_Saved["ZHunterButtonPet"]["vertical"] = 1
		end
		ZHunterButtonPet_SetupSizeAndPosition()
	end
	info.text = "BOTTOM"
	UIDropDownMenu_AddButton(info)
	info.text = "TOP"
	UIDropDownMenu_AddButton(info)
end

function ZHunterButtonPetOptionsFirstButtonDropDown_Initialize()
	info = {}
	info.func = function()
		UIDropDownMenu_SetSelectedID(ZHunterButtonPetOptionsGraphicFirstButtonDropDown, this:GetID(), 1)
		ZHunterMod_Saved["ZHunterButtonPet"]["firstbutton"] = ZHunterButtonPetOptionsGraphicFirstButtonDropDownText:GetText()
		ZHunterButtonPet_SetupSizeAndPosition()
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