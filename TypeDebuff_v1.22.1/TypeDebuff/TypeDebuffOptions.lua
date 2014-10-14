local TypeDebuffOptions_SetColorFunc = {
	[1] = function(x) TypeDebuffOptions_SetColor(1,"Poison") end,
	[2] = function(x) TypeDebuffOptions_SetColor(2,"Disease") end,
	[3] = function(x) TypeDebuffOptions_SetColor(3,"Curse") end,
	[4] = function(x) TypeDebuffOptions_SetColor(4,"Magic") end,
};

local TypeDebuffOptions_CancelColorFunc = {
	[1] = function(x) TypeDebuffOptions_CancelColor(1,"Poison",x) end,
	[2] = function(x) TypeDebuffOptions_CancelColor(2,"Disease",x) end,
	[3] = function(x) TypeDebuffOptions_CancelColor(3,"Curse",x) end,
	[4] = function(x) TypeDebuffOptions_CancelColor(4,"Magic",x) end,
};

TypeDebuffOptionsFrameColorSwatch = { };
TypeDebuffOptionsFrameColorSwatch [TYPEDEBUFFOPTIONS_COLORWATCH1.name] = { index = 1, TypeDebuffVar = "Poison", tooltipText = TYPEDEBUFFOPTIONS_COLORWATCH1.tooltipText};
TypeDebuffOptionsFrameColorSwatch [TYPEDEBUFFOPTIONS_COLORWATCH2.name] = { index = 2, TypeDebuffVar = "Disease", tooltipText = TYPEDEBUFFOPTIONS_COLORWATCH2.tooltipText};
TypeDebuffOptionsFrameColorSwatch [TYPEDEBUFFOPTIONS_COLORWATCH3.name] = { index = 3, TypeDebuffVar = "Curse", tooltipText = TYPEDEBUFFOPTIONS_COLORWATCH3.tooltipText};
TypeDebuffOptionsFrameColorSwatch [TYPEDEBUFFOPTIONS_COLORWATCH4.name] = { index = 4, TypeDebuffVar = "Magic", tooltipText = TYPEDEBUFFOPTIONS_COLORWATCH4.tooltipText};

TypeDebuffOptionsFrameSliders = { };
TypeDebuffOptionsFrameSliders [TYPEDEBUFFOPTIONS_SLIDER1.name] = { index = 1, TypeDebuffVar = "Poison", TypeDebuffVar2 = "PositionH", minValue = -32, maxValue = 32, valueStep = 1, minText=TYPEDEBUFFOPTIONS_SLIDER1.minText, maxText=TYPEDEBUFFOPTIONS_SLIDER1.maxText, tooltipText = TYPEDEBUFFOPTIONS_SLIDER1.tooltipText};
TypeDebuffOptionsFrameSliders [TYPEDEBUFFOPTIONS_SLIDER2.name] = { index = 2, TypeDebuffVar = "Poison", TypeDebuffVar2 = "PositionV", minValue = -32, maxValue = 32, valueStep = 1, minText=TYPEDEBUFFOPTIONS_SLIDER2.minText, maxText=TYPEDEBUFFOPTIONS_SLIDER2.maxText, tooltipText = TYPEDEBUFFOPTIONS_SLIDER2.tooltipText};
TypeDebuffOptionsFrameSliders [TYPEDEBUFFOPTIONS_SLIDER3.name] = { index = 3, TypeDebuffVar = "Disease", TypeDebuffVar2 = "PositionH", minValue = -32, maxValue = 32, valueStep = 1, minText=TYPEDEBUFFOPTIONS_SLIDER3.minText, maxText=TYPEDEBUFFOPTIONS_SLIDER3.maxText, tooltipText = TYPEDEBUFFOPTIONS_SLIDER3.tooltipText};
TypeDebuffOptionsFrameSliders [TYPEDEBUFFOPTIONS_SLIDER4.name] = { index = 4, TypeDebuffVar = "Disease", TypeDebuffVar2 = "PositionV", minValue = -32, maxValue = 32, valueStep = 1, minText=TYPEDEBUFFOPTIONS_SLIDER4.minText, maxText=TYPEDEBUFFOPTIONS_SLIDER4.maxText, tooltipText = TYPEDEBUFFOPTIONS_SLIDER4.tooltipText};
TypeDebuffOptionsFrameSliders [TYPEDEBUFFOPTIONS_SLIDER5.name] = { index = 5, TypeDebuffVar = "Curse", TypeDebuffVar2 = "PositionH", minValue = -32, maxValue = 32, valueStep = 1, minText=TYPEDEBUFFOPTIONS_SLIDER5.minText, maxText=TYPEDEBUFFOPTIONS_SLIDER5.maxText, tooltipText = TYPEDEBUFFOPTIONS_SLIDER5.tooltipText};
TypeDebuffOptionsFrameSliders [TYPEDEBUFFOPTIONS_SLIDER6.name] = { index = 6, TypeDebuffVar = "Curse", TypeDebuffVar2 = "PositionV", minValue = -32, maxValue = 32, valueStep = 1, minText=TYPEDEBUFFOPTIONS_SLIDER6.minText, maxText=TYPEDEBUFFOPTIONS_SLIDER6.maxText, tooltipText = TYPEDEBUFFOPTIONS_SLIDER6.tooltipText};
TypeDebuffOptionsFrameSliders [TYPEDEBUFFOPTIONS_SLIDER7.name] = { index = 7, TypeDebuffVar = "Magic", TypeDebuffVar2 = "PositionH", minValue = -32, maxValue = 32, valueStep = 1, minText=TYPEDEBUFFOPTIONS_SLIDER7.minText, maxText=TYPEDEBUFFOPTIONS_SLIDER7.maxText, tooltipText = TYPEDEBUFFOPTIONS_SLIDER7.tooltipText};
TypeDebuffOptionsFrameSliders [TYPEDEBUFFOPTIONS_SLIDER8.name] = { index = 8, TypeDebuffVar = "Magic", TypeDebuffVar2 = "PositionV", minValue = -32, maxValue = 32, valueStep = 1, minText=TYPEDEBUFFOPTIONS_SLIDER8.minText, maxText=TYPEDEBUFFOPTIONS_SLIDER8.maxText, tooltipText = TYPEDEBUFFOPTIONS_SLIDER8.tooltipText};
TypeDebuffOptionsFrameSliders [TYPEDEBUFFOPTIONS_SLIDER9.name] = { index = 9, TypeDebuffVar = "Poison", TypeDebuffVar2 = "Size", minValue = 6, maxValue = 32, valueStep = 1, minText=TYPEDEBUFFOPTIONS_SLIDER9.minText, maxText=TYPEDEBUFFOPTIONS_SLIDER9.maxText, tooltipText = TYPEDEBUFFOPTIONS_SLIDER9.tooltipText};
TypeDebuffOptionsFrameSliders [TYPEDEBUFFOPTIONS_SLIDER10.name] = { index = 10, TypeDebuffVar = "Disease", TypeDebuffVar2 = "Size", minValue = 6, maxValue = 32, valueStep = 1, minText=TYPEDEBUFFOPTIONS_SLIDER10.minText, maxText=TYPEDEBUFFOPTIONS_SLIDER10.maxText, tooltipText = TYPEDEBUFFOPTIONS_SLIDER10.tooltipText};
TypeDebuffOptionsFrameSliders [TYPEDEBUFFOPTIONS_SLIDER11.name] = { index = 11, TypeDebuffVar = "Curse", TypeDebuffVar2 = "Size", minValue = 6, maxValue = 32, valueStep = 1, minText=TYPEDEBUFFOPTIONS_SLIDER11.minText, maxText=TYPEDEBUFFOPTIONS_SLIDER11.maxText, tooltipText = TYPEDEBUFFOPTIONS_SLIDER11.tooltipText};
TypeDebuffOptionsFrameSliders [TYPEDEBUFFOPTIONS_SLIDER12.name] = { index = 12, TypeDebuffVar = "Magic", TypeDebuffVar2 = "Size", minValue = 6, maxValue = 32, valueStep = 1, minText=TYPEDEBUFFOPTIONS_SLIDER12.minText, maxText=TYPEDEBUFFOPTIONS_SLIDER12.maxText, tooltipText = TYPEDEBUFFOPTIONS_SLIDER12.tooltipText};

TypeDebuffOptionsFrameEvents = { };
TypeDebuffOptionsFrameEvents [TYPEDEBUFFOPTIONS_CHECK1.name]  = { index = 1, tooltipText = TYPEDEBUFFOPTIONS_CHECK1.tooltipText, TypeDebuffVar = "Enabled"};
TypeDebuffOptionsFrameEvents [TYPEDEBUFFOPTIONS_CHECK2.name]  = { index = 2, tooltipText = TYPEDEBUFFOPTIONS_CHECK2.tooltipText, TypeDebuffVar = "Text"};
TypeDebuffOptionsFrameEvents [TYPEDEBUFFOPTIONS_CHECK3.name]  = { index = 3, tooltipText = TYPEDEBUFFOPTIONS_CHECK3.tooltipText, TypeDebuffVar = "Icon"};
TypeDebuffOptionsFrameEvents [TYPEDEBUFFOPTIONS_CHECK4.name]  = { index = 4, tooltipText = TYPEDEBUFFOPTIONS_CHECK4.tooltipText, TypeDebuffVar = "Poison", TypeDebuffVar2 = "Enabled"};
TypeDebuffOptionsFrameEvents [TYPEDEBUFFOPTIONS_CHECK5.name]  = { index = 5, tooltipText = TYPEDEBUFFOPTIONS_CHECK5.tooltipText, TypeDebuffVar = "Disease", TypeDebuffVar2 = "Enabled"};
TypeDebuffOptionsFrameEvents [TYPEDEBUFFOPTIONS_CHECK6.name]  = { index = 6, tooltipText = TYPEDEBUFFOPTIONS_CHECK6.tooltipText, TypeDebuffVar = "Curse", TypeDebuffVar2 = "Enabled"};
TypeDebuffOptionsFrameEvents [TYPEDEBUFFOPTIONS_CHECK7.name]  = { index = 7, tooltipText = TYPEDEBUFFOPTIONS_CHECK7.tooltipText, TypeDebuffVar = "Magic", TypeDebuffVar2 = "Enabled"};

TypeDebuffOptionsFrameEditBox = { };
TypeDebuffOptionsFrameEditBox [TYPEDEBUFFOPTIONS_EDITBOX1.name]  = { index = 1, TypeDebuffVar = "Poison", TypeDebuffVar2 = "Text"};
TypeDebuffOptionsFrameEditBox [TYPEDEBUFFOPTIONS_EDITBOX2.name]  = { index = 2, TypeDebuffVar = "Disease", TypeDebuffVar2 = "Text"};
TypeDebuffOptionsFrameEditBox [TYPEDEBUFFOPTIONS_EDITBOX3.name]  = { index = 3, TypeDebuffVar = "Curse", TypeDebuffVar2 = "Text"};
TypeDebuffOptionsFrameEditBox [TYPEDEBUFFOPTIONS_EDITBOX4.name]  = { index = 4, TypeDebuffVar = "Magic", TypeDebuffVar2 = "Text"};

TypeDebuffOptionsDropDown = { };
TypeDebuffOptionsDropDown [1] = { };
TypeDebuffOptionsDropDown [1][1]  = { name = TYPEDEBUFFOPTIONS_DROPDOWN11.name, tooltipText = TYPEDEBUFFOPTIONS_DROPDOWN11.tooltipText, value = 1};
TypeDebuffOptionsDropDown [1][2]  = { name = TYPEDEBUFFOPTIONS_DROPDOWN12.name, tooltipText = TYPEDEBUFFOPTIONS_DROPDOWN12.tooltipText, value = 2};
TypeDebuffOptionsDropDown [1][3]  = { name = TYPEDEBUFFOPTIONS_DROPDOWN13.name, tooltipText = TYPEDEBUFFOPTIONS_DROPDOWN13.tooltipText, value = 3};
TypeDebuffOptionsDropDown [1][4]  = { name = TYPEDEBUFFOPTIONS_DROPDOWN14.name, tooltipText = TYPEDEBUFFOPTIONS_DROPDOWN14.tooltipText, value = 4};
TypeDebuffOptionsDropDown [2] = { };
TypeDebuffOptionsDropDown [2][1]  = { name = TYPEDEBUFFOPTIONS_DROPDOWN21.name, tooltipText = TYPEDEBUFFOPTIONS_DROPDOWN21.tooltipText, value = 1};
TypeDebuffOptionsDropDown [2][2]  = { name = TYPEDEBUFFOPTIONS_DROPDOWN22.name, tooltipText = TYPEDEBUFFOPTIONS_DROPDOWN22.tooltipText, value = 2};
TypeDebuffOptionsDropDown [2][3]  = { name = TYPEDEBUFFOPTIONS_DROPDOWN23.name, tooltipText = TYPEDEBUFFOPTIONS_DROPDOWN23.tooltipText, value = 3};
TypeDebuffOptionsDropDown [2][4]  = { name = TYPEDEBUFFOPTIONS_DROPDOWN24.name, tooltipText = TYPEDEBUFFOPTIONS_DROPDOWN24.tooltipText, value = 4};
TypeDebuffOptionsDropDown [3] = { };
TypeDebuffOptionsDropDown [3][1]  = { name = TYPEDEBUFFOPTIONS_DROPDOWN31.name, tooltipText = TYPEDEBUFFOPTIONS_DROPDOWN31.tooltipText, value = 1};
TypeDebuffOptionsDropDown [3][2]  = { name = TYPEDEBUFFOPTIONS_DROPDOWN32.name, tooltipText = TYPEDEBUFFOPTIONS_DROPDOWN32.tooltipText, value = 2};
TypeDebuffOptionsDropDown [3][3]  = { name = TYPEDEBUFFOPTIONS_DROPDOWN33.name, tooltipText = TYPEDEBUFFOPTIONS_DROPDOWN33.tooltipText, value = 3};
TypeDebuffOptionsDropDown [3][4]  = { name = TYPEDEBUFFOPTIONS_DROPDOWN34.name, tooltipText = TYPEDEBUFFOPTIONS_DROPDOWN34.tooltipText, value = 4};
TypeDebuffOptionsDropDown [4] = { };
TypeDebuffOptionsDropDown [4][1]  = { name = TYPEDEBUFFOPTIONS_DROPDOWN41.name, tooltipText = TYPEDEBUFFOPTIONS_DROPDOWN41.tooltipText, value = 1, TypeDebuffVar = "Magic"};
TypeDebuffOptionsDropDown [4][2]  = { name = TYPEDEBUFFOPTIONS_DROPDOWN42.name, tooltipText = TYPEDEBUFFOPTIONS_DROPDOWN42.tooltipText, value = 2, TypeDebuffVar = "Magic"};
TypeDebuffOptionsDropDown [4][3]  = { name = TYPEDEBUFFOPTIONS_DROPDOWN43.name, tooltipText = TYPEDEBUFFOPTIONS_DROPDOWN43.tooltipText, value = 3, TypeDebuffVar = "Magic"};
TypeDebuffOptionsDropDown [4][4]  = { name = TYPEDEBUFFOPTIONS_DROPDOWN44.name, tooltipText = TYPEDEBUFFOPTIONS_DROPDOWN44.tooltipText, value = 4, TypeDebuffVar = "Magic"};



function TypeDebuffOptions_OnLoad()
	UIPanelWindows["TypeDebuffOptionsFrame"] = {area = "center", pushable = 0};
end

function TypeDebuffOptions_OnShow()
	
	local button, checked;
	for key, value in TypeDebuffOptionsFrameEvents do
		button = getglobal("TypeDebuffOptionsFrame_CheckButton"..value.index);
		checked = nil;
		button.disabled = nil;		
		if ( value.TypeDebuffVar ~= nil ) then
			if ( value.TypeDebuffVar2 ~= nil ) then
				if ( TypeDebuff_Get2(value.TypeDebuffVar, value.TypeDebuffVar2) == 1 ) then
					checked = 1;
				else
					checked = 0;
				end
			else
				if ( TypeDebuff_Get(value.TypeDebuffVar) == 1 ) then
				checked = 1;
				else
					checked = 0;
				end
			end
		else
			checked = 0;
		end
		OptionsFrame_EnableCheckBox(button);
		button:SetChecked(checked);
		getglobal("TypeDebuffOptionsFrame_CheckButton"..value.index.."Text"):SetText(key);
		button.tooltipText = value.tooltipText;
	end
	
	local frame,sRed,sGreen,sBlue,sColor;
	for key, value in TypeDebuffOptionsFrameColorSwatch do
		frame = getglobal("TypeDebuffSwatchFrame"..value.index);
		frame.tooltipText = value.tooltipText;
		sColor = TypeDebuff_GetColor(value.TypeDebuffVar);
		sRed = sColor.r;
		sGreen = sColor.g;
		sBlue = sColor.b;
		frame.r = sRed;
		frame.g = sGreen;
		frame.b = sBlue;
		frame.swatchFunc = TypeDebuffOptions_SetColorFunc[value.index];
		frame.cancelFunc = TypeDebuffOptions_CancelColorFunc[value.index];
		getglobal("TypeDebuffSwatchFrame"..value.index.."_ColorSwatchNormalTexture"):SetVertexColor(sRed,sGreen,sBlue);
	end

	local slider, getvalue;
	for key, value in TypeDebuffOptionsFrameSliders do
		slider = getglobal("TypeDebuffOptionsFrame_Slider"..value.index);
		if ( value.TypeDebuffVar2 ~= nil ) then
			getvalue = TypeDebuff_Get2(value.TypeDebuffVar, value.TypeDebuffVar2);
		else
			getvalue = TypeDebuff_Get(value.TypeDebuffVar);
		end
		OptionsFrame_EnableSlider(slider);
		slider:SetMinMaxValues(value.minValue, value.maxValue);
		slider:SetValueStep(value.valueStep);
		slider:SetValue(getvalue);
		getglobal("TypeDebuffOptionsFrame_Slider"..value.index.."TextValue"):SetText(getvalue);
		getglobal("TypeDebuffOptionsFrame_Slider"..value.index.."Text"):SetText(key);
		getglobal("TypeDebuffOptionsFrame_Slider"..value.index.."Low"):SetText(value.minText);
		getglobal("TypeDebuffOptionsFrame_Slider"..value.index.."High"):SetText(value.maxText);
		slider.tooltipText = value.tooltipText;
	end
	
	local editbox;
	for key, value in TypeDebuffOptionsFrameEditBox do
		editbox = getglobal("TypeDebuffOptionsFrame_EditBox"..value.index);
		editbox:SetText(TypeDebuff_Get2(value.TypeDebuffVar, value.TypeDebuffVar2));
	end
		
	TypeDebuffOptions_UpdateDependencies();
	
end

function TypeDebuffOptions_CheckButtonOnClick()
	for key, value in TypeDebuffOptionsFrameEvents do
		if (this:GetName() == "TypeDebuffOptionsFrame_CheckButton"..value.index) then
			local enable = nil;
			if ( this:GetChecked() ) then
				enable = 1;
			else
				enable = 0;
			end		
			
			if ( value.TypeDebuffVar ~= nil ) then
				if ( value.TypeDebuffVar2 ~= nil ) then
					TypeDebuff_Set2(value.TypeDebuffVar, value.TypeDebuffVar2, enable);
				else
					TypeDebuff_Set(value.TypeDebuffVar, enable);
				end
			end
		end
	end
	
	TypeDebuffOptions_UpdateDependencies();
	
end

function TypeDebuffOptions_SliderOnValueChanged()
	local slider;
	for key, value in TypeDebuffOptionsFrameSliders do
		if (this:GetName() == "TypeDebuffOptionsFrame_Slider"..value.index) then
			getglobal("TypeDebuffOptionsFrame_Slider"..value.index.."TextValue"):SetText(this:GetValue());
			if ( value.TypeDebuffVar2 ~= nil ) then
				TypeDebuff_Set2( value.TypeDebuffVar, value.TypeDebuffVar2, this:GetValue() );
			else
				TypeDebuff_Set( value.TypeDebuffVar, this:GetValue() );
			end
		end
	end
end

function TypeDebuffOptions_SetColor(key, var)
	local r,g,b = ColorPickerFrame:GetColorRGB();
	local swatch,frame;
	swatch = getglobal("TypeDebuffSwatchFrame"..key.."_ColorSwatchNormalTexture");
	frame = getglobal("TypeDebuffSwatchFrame"..key);
	swatch:SetVertexColor(r,g,b);
	frame.r = r;
	frame.g = g;
	frame.b = b;
	TypeDebuff_SetColor(var, r, g, b)
end

function TypeDebuffOptions_CancelColor(key, var, prev)
	local r = prev.r;
	local g = prev.g;
	local b = prev.b;
	local swatch, frame;
	swatch = getglobal("TypeDebuffSwatchFrame"..key.."_ColorSwatchNormalTexture");
	frame = getglobal("TypeDebuffSwatchFrame"..key);
	swatch:SetVertexColor(r, g, b);
	frame.r = r;
	frame.g = g;
	frame.b = b;
	--TypeDebuff_SetColor(var, r, g, b)
end

function TypeDebuffOptions_OpenColorPicker(button)
	CloseMenus();
	if ( not button ) then
		button = this;
	end
	ColorPickerFrame.func = button.swatchFunc;
	ColorPickerFrame:SetColorRGB(button.r, button.g, button.b);
	ColorPickerFrame.previousValues = {r = button.r, g = button.g, b = button.b, opacity = button.opacity};
	ColorPickerFrame.cancelFunc = button.cancelFunc;
	ColorPickerFrame:Show();
end

function TypeDebuffOptions_SetText()
	for key, value in TypeDebuffOptionsFrameEditBox do
		if (this:GetName() == "TypeDebuffOptionsFrame_EditBox"..value.index) then
			TypeDebuff_Set2(value.TypeDebuffVar, value.TypeDebuffVar2, this:GetText());
		end
	end
	
end

function TypeDebuffOptions_SaveText()
	TypeDebuffOptions_SetText("Poison", getglobal("TypeDebuffOptionsFrame_EditBox1"):GetText());
	TypeDebuffOptions_SetText("Disease", getglobal("TypeDebuffOptionsFrame_EditBox2"):GetText());
	TypeDebuffOptions_SetText("Curse", getglobal("TypeDebuffOptionsFrame_EditBox3"):GetText());
	TypeDebuffOptions_SetText("Magic", getglobal("TypeDebuffOptionsFrame_EditBox4"):GetText());
end

function TypeDebuffOptions_DropDown_OnLoad1()
	UIDropDownMenu_Initialize(this, TypeDebuffOptions_DropDown_Initialize1);
	for key, value in TypeDebuffOptionsDropDown[1] do
		if (value.value == TypeDebuff_Get2("Poison", "Font") ) then
			UIDropDownMenu_SetSelectedID(TypeDebuffOptionsFrame_DropDown1, key);
		end
	end
	TypeDebuffOptionsFrame_DropDown1.tooltip = TypeDebuffOptionsDropDown[1][UIDropDownMenu_GetSelectedID(TypeDebuffOptionsFrame_DropDown1)].tooltipText;
	UIDropDownMenu_SetWidth(120, TypeDebuffOptionsFrame_DropDown1);
	getglobal(this:GetName().."Label"):SetText(TYPEDEBUFFOPTIONS_DROPDOWNNAME1);
end

function TypeDebuffOptions_DropDown_OnLoad2()
	UIDropDownMenu_Initialize(this, TypeDebuffOptions_DropDown_Initialize2);
	for key, value in TypeDebuffOptionsDropDown[2] do
		if (value.value == TypeDebuff_Get2("Disease", "Font") ) then
			UIDropDownMenu_SetSelectedID(TypeDebuffOptionsFrame_DropDown2, key);
		end
	end
	TypeDebuffOptionsFrame_DropDown2.tooltip = TypeDebuffOptionsDropDown[2][UIDropDownMenu_GetSelectedID(TypeDebuffOptionsFrame_DropDown2)].tooltipText;
	UIDropDownMenu_SetWidth(120, TypeDebuffOptionsFrame_DropDown2);
	getglobal(this:GetName().."Label"):SetText(TYPEDEBUFFOPTIONS_DROPDOWNNAME2);
end

function TypeDebuffOptions_DropDown_OnLoad3()
	UIDropDownMenu_Initialize(this, TypeDebuffOptions_DropDown_Initialize3);
	for key, value in TypeDebuffOptionsDropDown[3] do
		if (value.value == TypeDebuff_Get2("Curse", "Font") ) then
			UIDropDownMenu_SetSelectedID(TypeDebuffOptionsFrame_DropDown3, key);
		end
	end
	TypeDebuffOptionsFrame_DropDown3.tooltip = TypeDebuffOptionsDropDown[3][UIDropDownMenu_GetSelectedID(TypeDebuffOptionsFrame_DropDown3)].tooltipText;
	UIDropDownMenu_SetWidth(120, TypeDebuffOptionsFrame_DropDown3);
	getglobal(this:GetName().."Label"):SetText(TYPEDEBUFFOPTIONS_DROPDOWNNAME3);
end

function TypeDebuffOptions_DropDown_OnLoad4()
	UIDropDownMenu_Initialize(this, TypeDebuffOptions_DropDown_Initialize4);
	for key, value in TypeDebuffOptionsDropDown[4] do
		if (value.value == TypeDebuff_Get2("Magic", "Font") ) then
			UIDropDownMenu_SetSelectedID(TypeDebuffOptionsFrame_DropDown4, key);
		end
	end
	TypeDebuffOptionsFrame_DropDown4.tooltip = TypeDebuffOptionsDropDown[4][UIDropDownMenu_GetSelectedID(TypeDebuffOptionsFrame_DropDown4)].tooltipText;
	UIDropDownMenu_SetWidth(120, TypeDebuffOptionsFrame_DropDown4);
	getglobal(this:GetName().."Label"):SetText(TYPEDEBUFFOPTIONS_DROPDOWNNAME4);
end

function TypeDebuffOptions_DropDown_Initialize1()
	local dropdown = getglobal("TypeDebuffOptionsFrame_DropDown1");
	local selectedValue = UIDropDownMenu_GetSelectedValue(dropdown);
	local info;
	
	for key, value in TypeDebuffOptionsDropDown[1] do
		info = { };
		info.text = value.name;
		info.func = TypeDebuffOptions_DropDown_OnClick1;
		info.value = key;
		if ( info.value == selectedValue ) then
			info.checked = 1;
		end
		info.tooltipText = value.tooltipText;
		UIDropDownMenu_AddButton(info);
	end
end

function TypeDebuffOptions_DropDown_Initialize2()
	local dropdown = getglobal("TypeDebuffOptionsFrame_DropDown2");
	local selectedValue = UIDropDownMenu_GetSelectedValue(dropdown);
	local info;
	
	for key, value in TypeDebuffOptionsDropDown[2] do
		info = { };
		info.text = value.name;
		info.func = TypeDebuffOptions_DropDown_OnClick2;
		info.value = key;
		if ( info.value == selectedValue ) then
			info.checked = 1;
		end
		info.tooltipText = value.tooltipText;
		UIDropDownMenu_AddButton(info);
	end
end

function TypeDebuffOptions_DropDown_Initialize3()
	local dropdown = getglobal("TypeDebuffOptionsFrame_DropDown3");
	local selectedValue = UIDropDownMenu_GetSelectedValue(dropdown);
	local info;
	
	for key, value in TypeDebuffOptionsDropDown[3] do
		info = { };
		info.text = value.name;
		info.func = TypeDebuffOptions_DropDown_OnClick3;
		info.value = key;
		if ( info.value == selectedValue ) then
			info.checked = 1;
		end
		info.tooltipText = value.tooltipText;
		UIDropDownMenu_AddButton(info);
	end
end

function TypeDebuffOptions_DropDown_Initialize4()
	local dropdown = getglobal("TypeDebuffOptionsFrame_DropDown4");
	local selectedValue = UIDropDownMenu_GetSelectedValue(dropdown);
	local info;
	
	for key, value in TypeDebuffOptionsDropDown[4] do
		info = { };
		info.text = value.name;
		info.func = TypeDebuffOptions_DropDown_OnClick4;
		info.value = key;
		if ( info.value == selectedValue ) then
			info.checked = 1;
		end
		info.tooltipText = value.tooltipText;
		UIDropDownMenu_AddButton(info);
	end
end

function TypeDebuffOptions_DropDown_OnClick1()
	UIDropDownMenu_SetSelectedValue(TypeDebuffOptionsFrame_DropDown1, this.value);
	TypeDebuffOptionsFrame_DropDown1.tooltip = TypeDebuffOptionsDropDown[1][UIDropDownMenu_GetSelectedID(TypeDebuffOptionsFrame_DropDown1)].tooltipText;
	TypeDebuff_Set2("Poison", "Font", TypeDebuffOptionsDropDown[1][UIDropDownMenu_GetSelectedID(TypeDebuffOptionsFrame_DropDown1)].value);	
end

function TypeDebuffOptions_DropDown_OnClick2()
	UIDropDownMenu_SetSelectedValue(TypeDebuffOptionsFrame_DropDown2, this.value);
	TypeDebuffOptionsFrame_DropDown2.tooltip = TypeDebuffOptionsDropDown[2][UIDropDownMenu_GetSelectedID(TypeDebuffOptionsFrame_DropDown2)].tooltipText;
	TypeDebuff_Set2("Disease", "Font", TypeDebuffOptionsDropDown[2][UIDropDownMenu_GetSelectedID(TypeDebuffOptionsFrame_DropDown2)].value);	
end

function TypeDebuffOptions_DropDown_OnClick3()
	UIDropDownMenu_SetSelectedValue(TypeDebuffOptionsFrame_DropDown3, this.value);
	TypeDebuffOptionsFrame_DropDown3.tooltip = TypeDebuffOptionsDropDown[3][UIDropDownMenu_GetSelectedID(TypeDebuffOptionsFrame_DropDown3)].tooltipText;
	TypeDebuff_Set2("Curse", "Font", TypeDebuffOptionsDropDown[3][UIDropDownMenu_GetSelectedID(TypeDebuffOptionsFrame_DropDown3)].value);	
end

function TypeDebuffOptions_DropDown_OnClick4()
	UIDropDownMenu_SetSelectedValue(TypeDebuffOptionsFrame_DropDown4, this.value);
	TypeDebuffOptionsFrame_DropDown4.tooltip = TypeDebuffOptionsDropDown[4][UIDropDownMenu_GetSelectedID(TypeDebuffOptionsFrame_DropDown4)].tooltipText;
	TypeDebuff_Set2("Magic", "Font", TypeDebuffOptionsDropDown[4][UIDropDownMenu_GetSelectedID(TypeDebuffOptionsFrame_DropDown4)].value);	
end

function TypeDebuffOptions_UpdateDependencies()
 	if ( not TypeDebuffOptionsFrame_CheckButton1:GetChecked() ) then
		OptionsFrame_DisableCheckBox(TypeDebuffOptionsFrame_CheckButton2);
		OptionsFrame_DisableCheckBox(TypeDebuffOptionsFrame_CheckButton3);
		OptionsFrame_DisableCheckBox(TypeDebuffOptionsFrame_CheckButton4);
		OptionsFrame_DisableCheckBox(TypeDebuffOptionsFrame_CheckButton5);
		OptionsFrame_DisableCheckBox(TypeDebuffOptionsFrame_CheckButton6);
		OptionsFrame_DisableCheckBox(TypeDebuffOptionsFrame_CheckButton7);
		OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider1);
		OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider2);
		OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider3);
		OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider4);
		OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider5);
		OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider6);
		OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider7);
		OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider8);
		OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider9);
		OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider10);
		OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider11);
		OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider12);	
		OptionsFrame_DisableDropDown(TypeDebuffOptionsFrame_DropDown1);
		OptionsFrame_DisableDropDown(TypeDebuffOptionsFrame_DropDown2);
		OptionsFrame_DisableDropDown(TypeDebuffOptionsFrame_DropDown3);
		OptionsFrame_DisableDropDown(TypeDebuffOptionsFrame_DropDown4);
	else
		OptionsFrame_EnableCheckBox(TypeDebuffOptionsFrame_CheckButton2, TypeDebuff_Get("Text") );
		OptionsFrame_EnableCheckBox(TypeDebuffOptionsFrame_CheckButton3, TypeDebuff_Get("Icon") );	
		if ( not TypeDebuffOptionsFrame_CheckButton2:GetChecked() ) then
			OptionsFrame_DisableCheckBox(TypeDebuffOptionsFrame_CheckButton4);
			OptionsFrame_DisableCheckBox(TypeDebuffOptionsFrame_CheckButton5);
			OptionsFrame_DisableCheckBox(TypeDebuffOptionsFrame_CheckButton6);
			OptionsFrame_DisableCheckBox(TypeDebuffOptionsFrame_CheckButton7);	
			OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider1);
			OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider2);
			OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider3);
			OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider4);
			OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider5);
			OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider6);
			OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider7);
			OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider8);
			OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider9);
			OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider10);
			OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider11);
			OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider12);
			OptionsFrame_DisableDropDown(TypeDebuffOptionsFrame_DropDown1);
			OptionsFrame_DisableDropDown(TypeDebuffOptionsFrame_DropDown2);
			OptionsFrame_DisableDropDown(TypeDebuffOptionsFrame_DropDown3);
			OptionsFrame_DisableDropDown(TypeDebuffOptionsFrame_DropDown4);
		else
			OptionsFrame_EnableCheckBox(TypeDebuffOptionsFrame_CheckButton4, TypeDebuff_Get2("Poison", "Enabled") );
			OptionsFrame_EnableCheckBox(TypeDebuffOptionsFrame_CheckButton5, TypeDebuff_Get2("Disease", "Enabled") );
			OptionsFrame_EnableCheckBox(TypeDebuffOptionsFrame_CheckButton6, TypeDebuff_Get2("Curse", "Enabled") );
			OptionsFrame_EnableCheckBox(TypeDebuffOptionsFrame_CheckButton7, TypeDebuff_Get2("Magic", "Enabled") );
			if ( not TypeDebuffOptionsFrame_CheckButton4:GetChecked() ) then
				OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider1);
				OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider2);
				OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider9);
				OptionsFrame_DisableDropDown(TypeDebuffOptionsFrame_DropDown1);
			else
				OptionsFrame_EnableSlider(TypeDebuffOptionsFrame_Slider1);
				OptionsFrame_EnableSlider(TypeDebuffOptionsFrame_Slider2);
				OptionsFrame_EnableSlider(TypeDebuffOptionsFrame_Slider9);
				OptionsFrame_EnableDropDown(TypeDebuffOptionsFrame_DropDown1);
			end
			if ( not TypeDebuffOptionsFrame_CheckButton5:GetChecked() ) then
				OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider3);
				OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider4);
				OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider10);
				OptionsFrame_DisableDropDown(TypeDebuffOptionsFrame_DropDown2);
			else
				OptionsFrame_EnableSlider(TypeDebuffOptionsFrame_Slider3);
				OptionsFrame_EnableSlider(TypeDebuffOptionsFrame_Slider4);
				OptionsFrame_EnableSlider(TypeDebuffOptionsFrame_Slider10);
				OptionsFrame_EnableDropDown(TypeDebuffOptionsFrame_DropDown2);
			end
			if ( not TypeDebuffOptionsFrame_CheckButton6:GetChecked() ) then
				OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider5);
				OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider6);
				OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider11);
				OptionsFrame_DisableDropDown(TypeDebuffOptionsFrame_DropDown3);
			else
				OptionsFrame_EnableSlider(TypeDebuffOptionsFrame_Slider5);
				OptionsFrame_EnableSlider(TypeDebuffOptionsFrame_Slider6);
				OptionsFrame_EnableSlider(TypeDebuffOptionsFrame_Slider11);
				OptionsFrame_EnableDropDown(TypeDebuffOptionsFrame_DropDown3);
			end
			if ( not TypeDebuffOptionsFrame_CheckButton7:GetChecked() ) then
				OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider7);
				OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider8);
				OptionsFrame_DisableSlider(TypeDebuffOptionsFrame_Slider12);
				OptionsFrame_DisableDropDown(TypeDebuffOptionsFrame_DropDown4);
			else
				OptionsFrame_EnableSlider(TypeDebuffOptionsFrame_Slider7);
				OptionsFrame_EnableSlider(TypeDebuffOptionsFrame_Slider8);
				OptionsFrame_EnableSlider(TypeDebuffOptionsFrame_Slider12);
				OptionsFrame_EnableDropDown(TypeDebuffOptionsFrame_DropDown4);
			end
		end
	end
end