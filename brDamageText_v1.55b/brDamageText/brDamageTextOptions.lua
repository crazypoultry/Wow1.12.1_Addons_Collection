VARIABLESLOADED=false;

function brDamageTextOptions_OnLoad()

	this:RegisterEvent("VARIABLES_LOADED");

	getglobal(this:GetName().."Caption"):SetText(BRDAMAGETEXT_OPTIONS_CAPTION);

	this:RegisterForDrag("LeftButton");
	this:SetBackdropBorderColor(1,1,1,1);
end

function brDamageTextOptions_OnEvent()
	if (event == "VARIABLES_LOADED") then
		brDamageTextOptions_Init();
	end
end

function brDamageTextOptions_Init()

	brDamageText_LoadVarsFirstTime();
	
	VARIABLESLOADED=true;
	
	brDamageTextOptionsFrameCheckButtonBorder:SetChecked(BRDAMAGETEXT["FrameBorder"]);
	brDamageTextOptionsFrameCheckButtonMoveable:SetChecked(BRDAMAGETEXT["FrameMoveable"]);
	brDamageTextOptionsFrameCheckButtonDots:SetChecked(BRDAMAGETEXT["Dots"]);
	brDamageTextOptionsFrameCheckButtonWord:SetChecked(BRDAMAGETEXT["Words"]);
	brDamageTextOptionsFrameCheckButtonFade:SetChecked(BRDAMAGETEXT["Fade"]);
	
	UIDropDownMenu_SetSelectedID(brDamageTextOptionsFrameDropDown, BRDAMAGETEXT["Frame"]);
	UIDropDownMenu_SetText(BRDAMAGETEXT_VALUES_ID[BRDAMAGETEXT["Frame"]], brDamageTextOptionsFrameDropDown)
	brDamageTextOptionsFrameDropDown.tooltip = BRDAMAGETEXT_TOOLTIP_ID[BRDAMAGETEXT["Frame"]];

	UIDropDownMenu_SetSelectedName(brDamageTextOptionsFrameFontDropDown, BRDAMAGETEXT["FontName"], true);
	UIDropDownMenu_SetText(BRDAMAGETEXT["FontName"], brDamageTextOptionsFrameFontDropDown)
	
	if (BRDAMAGETEXT["Frame"] ~= 2) then
		brDamageTextOptionsFrameCheckButtonBorder:Disable();
		brDamageTextOptionsFrameCheckButtonMoveable:Disable();
	end
	
	brDamageTextOptionsFrameSliderFontSize:SetValue(BRDAMAGETEXT["FontSize"]);
	
	brDamageTextOwnFrame:SetBackdropBorderColor(1,1,1,BRDAMAGETEXT["FrameBorder"]);
	brDamageTextOwnFrame:SetBackdropColor(1,1,1,BRDAMAGETEXT["FrameBorder"]);
end

function brDamageTextOptions_OnReset()
	brDamageTextOwnFrame:ClearAllPoints();
	brDamageTextOwnFrame:SetPoint("CENTER","UIParent");
	
	BRDAMAGETEXT = nil;
	
	brDamageTextOptions_Init();
	brDamageText_Init();
end

function brDamageTextOptions_OnClose()
	getglobal(this:GetParent():GetName()):Hide();
end

function brDamageTextOptionsFrameDropDown_OnLoad()

	getglobal(this:GetName() .. "Label"):SetText(BRDAMAGETEXT_OPTIONS_DISPLAY);

	UIDropDownMenu_Initialize(this, brDamageTextOptionsFrameDropDown_Initialize);
	UIDropDownMenu_SetSelectedID(this, 1);
	brDamageTextOptionsFrameDropDown.tooltip = BRDAMAGETEXT_TOOLTIP_ID[1];
	UIDropDownMenu_SetWidth(160);
end

function brDamageTextOptionsFrameDropDown_Initialize()
	for i, v in ipairs(BRDAMAGETEXT_VALUES_ID) do
		local info = {};
		info.text = v;
		info.func = brDamageTextOptionsFrameDropDown_OnClick;
		if (BRDAMAGETEXT_ADDON and BRDAMAGETEXT_ADDON[i] and BRDAMAGETEXT_ADDON[i] ~= "") then
			if (not IsAddOnLoaded(BRDAMAGETEXT_ADDON[i])) then
				info.disabled = 1;
			end
		end
		
		UIDropDownMenu_AddButton(info);
	end
end


function brDamageTextOptionsFrameDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(brDamageTextOptionsFrameDropDown, this:GetID());
	brDamageTextOptionsFrameDropDown.tooltip = BRDAMAGETEXT_TOOLTIP_ID[this:GetID()];
	BRDAMAGETEXT["Frame"] = this:GetID();

	if (this:GetID() == 2) then
		brDamageTextOptionsFrameCheckButtonBorder:Enable();
		brDamageTextOptionsFrameCheckButtonMoveable:Enable();
		brDamageTextOwnFrame:Show();
	else
		brDamageTextOptionsFrameCheckButtonBorder:Disable();
		brDamageTextOptionsFrameCheckButtonMoveable:Disable();
		brDamageTextOwnFrame:Hide();
	end
	
	if (BRDAMAGETEXT_FRAMENAMES[this:GetID()] == nil or BRDAMAGETEXT_FRAMENAMES[this:GetID()] == "") then
		brDamageText:ClearAllPoints();
		brDamageText:SetPoint("CENTER","TargetFramePortrait","CENTER", 0, 0);
	else
		brDamageText:ClearAllPoints();
		brDamageText:SetPoint("CENTER",BRDAMAGETEXT_FRAMENAMES[this:GetID()],"CENTER", 0, 0);
	end
end

function brDamageTextOptionsFrameFontDropDown_OnLoad()

	getglobal(this:GetName() .. "Label"):SetText(BRDAMAGETEXT_OPTIONS_FONTNAME);

	UIDropDownMenu_Initialize(this, brDamageTextOptionsFrameFontDropDown_Initialize);
	
	brDamageTextOptionsFrameFontDropDown.tooltip = BRDAMAGETEXT_TOOLTIP_FONTNAME;
	
	UIDropDownMenu_SetSelectedID(this, 1);
	UIDropDownMenu_SetWidth(160);
end

function brDamageTextOptionsFrameFontDropDown_Initialize()
	local info = {};
	info.func = brDamageTextOptionsFrameFontDropDown_OnClick;
	info.text = "skurri";
	info.arg1 = "Fonts\\skurri.ttf";
	UIDropDownMenu_AddButton(info);
	
	local info = {};
	info.func = brDamageTextOptionsFrameFontDropDown_OnClick;
	info.text = "skurri outline";
	info.arg1 = "Fonts\\skurri.ttf";
	info.arg2 = "OUTLINE";
	UIDropDownMenu_AddButton(info);
	
	local info = {};
	info.func = brDamageTextOptionsFrameFontDropDown_OnClick;
	info.text = "skurri thickoutline (Default)";
	info.arg1 = "Fonts\\skurri.ttf";
	info.arg2 = "OUTLINE, THICKOUTLINE";
	UIDropDownMenu_AddButton(info);

	local info = {};
	info.func = brDamageTextOptionsFrameFontDropDown_OnClick;
	info.text = "FRIZQT";
	info.arg1 = "Fonts\\FRIZQT__.TTF";
	UIDropDownMenu_AddButton(info);
	
	local info = {};
	info.func = brDamageTextOptionsFrameFontDropDown_OnClick;
	info.text = "FRIZQT OUTLINE";
	info.arg1 = "Fonts\\FRIZQT__.TTF";
	info.arg2 = "OUTLINE";
	UIDropDownMenu_AddButton(info);
	
	local info = {};
	info.func = brDamageTextOptionsFrameFontDropDown_OnClick;
	info.text = "FRIZQT THICKOUTLINE";
	info.arg1 = "Fonts\\FRIZQT__.TTF";
	info.arg2 = "OUTLINE, THICKOUTLINE";
	UIDropDownMenu_AddButton(info);
	
	local info = {};
	info.func = brDamageTextOptionsFrameFontDropDown_OnClick;
	info.text = "ARIALN";
	info.arg1 = "Fonts\\ARIALN.TTF";
	UIDropDownMenu_AddButton(info);
	
	local info = {};
	info.func = brDamageTextOptionsFrameFontDropDown_OnClick;
	info.text = "ARIALN OUTLINE";
	info.arg1 = "Fonts\\ARIALN.TTF";
	info.arg2 = "OUTLINE";
	UIDropDownMenu_AddButton(info);
	
	local info = {};
	info.func = brDamageTextOptionsFrameFontDropDown_OnClick;
	info.text = "ARIALN THICKOUTLINE";
	info.arg1 = "Fonts\\ARIALN.TTF";
	info.arg2 = "OUTLINE, THICKOUTLINE";
	UIDropDownMenu_AddButton(info);
end


function brDamageTextOptionsFrameFontDropDown_OnClick(fontpath, fontflags)
	UIDropDownMenu_SetSelectedID(brDamageTextOptionsFrameFontDropDown, this:GetID());

	BRDAMAGETEXT["FontName"] = this:GetText();
	BRDAMAGETEXT["FontPath"] = fontpath;
	if (fontflags) then
		BRDAMAGETEXT["FontFlags"] = fontflags;
	else
		BRDAMAGETEXT["FontFlags"] = "";
	end

	brDamageText:SetFont(BRDAMAGETEXT["FontPath"], BRDAMAGETEXT["FontSize"], BRDAMAGETEXT["FontFlags"]);
end

function brDamageTextOptionsSliderFontSize_OnValueChanged()
	if (VARIABLESLOADED==true) then
		BRDAMAGETEXT["FontSize"] = this:GetValue();
		getglobal(this:GetName().."Mid"):SetText(this:GetValue());
		brDamageTextFrame:SetScale(0.5);
		brDamageText:SetTextHeight(this:GetValue());
		brDamageTextFrame:SetScale(1);
	end
end

function brDamageTextOptionsFrameCheckButtonBorder_OnClick()
	if (this:GetChecked()==1) then
		BRDAMAGETEXT["FrameBorder"] = 1;
	else
		BRDAMAGETEXT["FrameBorder"] = 0;
	end
	brDamageTextOwnFrame:SetBackdropBorderColor(1,1,1,BRDAMAGETEXT["FrameBorder"]);
	brDamageTextOwnFrame:SetBackdropColor(1,1,1,BRDAMAGETEXT["FrameBorder"]);
end

function brDamageTextOptionsFrameCheckButtonMoveable_OnClick()
	if (this:GetChecked()==1) then
		BRDAMAGETEXT["FrameMoveable"]=1;
	else
		BRDAMAGETEXT["FrameMoveable"]=0;
	end
end

function brDamageTextOptionsFrameCheckButtonDots_OnClick()
	if (this:GetChecked()==1) then
		BRDAMAGETEXT["Dots"] = 1;
	else
		BRDAMAGETEXT["Dots"] = 0;
	end
end

function brDamageTextOptionsFrameCheckButtonWord_OnClick()
	if (this:GetChecked()==1) then
		BRDAMAGETEXT["Words"] = 1;
	else
		BRDAMAGETEXT["Words"] = 0;
	end
end

function brDamageTextOptionsFrameCheckButtonFade_OnClick()
	if (this:GetChecked()==1) then
		BRDAMAGETEXT["Fade"] = 1;
	else
		BRDAMAGETEXT["Fade"] = 0;
	end
end