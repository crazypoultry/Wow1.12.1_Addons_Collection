function DRUIDBAROptionsFrame_Toggle()
	if(DRUIDBAROptionsFrame:IsVisible()) then
		DRUIDBAROptionsFrame:Hide();
	else
		DRUIDBAR_FrameSet();
		DRUIDBAROptionsFrame:Show();
	end
end

function DRUIDBAROptions_OnLoad()
	UIPanelWindows['DRUIDBAROptionsFrame'] = {area = 'center', pushable = 0};
end

function DRUIDBAROptions_CheckWeight()
	if ( DRUIDBAROptionsWeightEditBox:GetText() < "1" ) then
		DRUIDBAROptionsWeightEditBox:SetText("1");							
		DruidBarKey.xvar = this:GetNumber();
		DruidBarKey.tempW = DruidBarKey.xvar;
	elseif( DRUIDBAROptionsWeightEditBox:GetText() > "9999" ) then
		DRUIDBAROptionsWeightEditBox:SetText("9999");							
		DruidBarKey.xvar = this:GetNumber();
		DruidBarKey.tempW = DruidBarKey.xvar;
	else
		DruidBarKey.xvar = this:GetNumber();
		DruidBarKey.tempW = DruidBarKey.xvar;
	end
end

function DRUIDBAROptions_CheckHeight()
	if ( DRUIDBAROptionsHeightEditBox:GetText() < "1" ) then
		DRUIDBAROptionsHeightEditBox:SetText("1");							
		DruidBarKey.yvar = this:GetNumber();
		DruidBarKey.tempH = DruidBarKey.yvar;
	elseif( DRUIDBAROptionsHeightEditBox:GetText() > "999" ) then
		DRUIDBAROptionsHeightEditBox:SetText("999");							
		DruidBarKey.yvar = this:GetNumber();
		DruidBarKey.tempH = DruidBarKey.yvar;
	else
		DruidBarKey.yvar = this:GetNumber();
		DruidBarKey.tempH = DruidBarKey.yvar;
	end
end

function DRUIDBAROptions_Toggle()
	if(DruidBarKey.Enabled) then
		DruidBarKey.Enabled = false;
	else
		DruidBarKey.Enabled = true;
	end
	DRUIDBAR_FrameSet();
end

function DRUIDBAROptions_Vis()
	if(DruidBarKey.Graphics) then
		DruidBarKey.Graphics = false;
	else
		DruidBarKey.Graphics = true;
	end
	DRUIDBAR_FrameSet();
end

function DRUIDBAROptions_KMG()
	if(DruidBarKey.kmg) then
		DruidBarKey.kmg = false;
	else
		DruidBarKey.kmg = true;
	end
	DRUIDBAR_FrameSet();
end

function DRUIDBAROptions_Replace()
	DruidBarKey.Replace = true;
	DruidBarKey.XPBar = false;
	DruidBarKey.Lock = true;
	DRUIDBAR_FrameSet();
end

function DRUIDBAROptions_Player()
	DruidBarKey.XPBar = true;
	DruidBarKey.xvar = 150;
	DruidBarKey.yvar = 18;
	DruidBarKey.Replace = false;
	DruidBarKey.Lock = true;
	DRUIDBAR_FrameSet();
end

function DRUIDBAROptions_Custom()
	DruidBarKey.Replace = false;
	DruidBarKey.XPBar = false;
	DruidBarKey.xvar = DruidBarKey.tempW;
	DruidBarKey.yvar = DruidBarKey.tempH;
	DRUIDBAR_FrameSet();
end

function DRUIDBAROptions_Lock()
	if(DruidBarKey.Lock) then
		DruidBarKey.Lock = false;
	else
		DruidBarKey.Lock = true;
	end
	DRUIDBAR_FrameSet();
end

function DRUIDBAROptions_Hide()
	if(DruidBarKey.Hide) then
		DruidBarKey.Hide = false;
	else
		DruidBarKey.Hide = true;
	end
	DRUIDBAR_FrameSet();
end

function DRUIDBAROptions_Full()
	if(DruidBarKey.Full) then
		DruidBarKey.Full = false;
	else
		DruidBarKey.Full = true;
	end
	DRUIDBAR_FrameSet();
end

function DRUIDBAROptions_Text_Initialize()
	local info;
	for i = 0, 2, 1 do
		info = { };
		info.text = DRUIDBAR_OPTIONS_DROP.Text[i];
		info.func = DRUIDBAROptions_Text_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function DRUIDBAROptions_Text_OnShow()
	UIDropDownMenu_Initialize(DRUIDBAROptionsTextDropDown, DRUIDBAROptions_Text_Initialize);
	if( DruidBarKey.Text == 0 ) then
		UIDropDownMenu_SetSelectedID(DRUIDBAROptionsTextDropDown, 1);
	elseif( DruidBarKey.Text == 1 ) then
		UIDropDownMenu_SetSelectedID(DRUIDBAROptionsTextDropDown, 2);
	elseif( DruidBarKey.Text == nil ) then
		UIDropDownMenu_SetSelectedID(DRUIDBAROptionsTextDropDown, 3);
	end
	UIDropDownMenu_SetWidth(100, DRUIDBAROptionsTextDropDown);
end

function DRUIDBAROptions_Text_OnClick()
	i = this:GetID();
	UIDropDownMenu_SetSelectedID(DRUIDBAROptionsTextDropDown, i);
	if(i == 1) then
		DruidBarKey.Text = 0;
	elseif(i == 2) then
		DruidBarKey.Text = 1;
	elseif(i == 3) then
		DruidBarKey.Text = nil;
	end
end

function DRUIDBAROptions_Percent_Initialize()
	local info;
	for i = 0, 2, 1 do
		info = { };
		info.text = DRUIDBAR_OPTIONS_DROP.Percent[i];
		info.func = DRUIDBAROptions_Percent_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function DRUIDBAROptions_Percent_OnShow()
	UIDropDownMenu_Initialize(DRUIDBAROptionsPercentDropDown, DRUIDBAROptions_Percent_Initialize);
	if( DruidBarKey.Percent == 0 ) then
		UIDropDownMenu_SetSelectedID(DRUIDBAROptionsPercentDropDown, 1);
	elseif( DruidBarKey.Percent == 1 ) then
		UIDropDownMenu_SetSelectedID(DRUIDBAROptionsPercentDropDown, 2);
	elseif( DruidBarKey.Percent == nil ) then
		UIDropDownMenu_SetSelectedID(DRUIDBAROptionsPercentDropDown, 3);
	end
	UIDropDownMenu_SetWidth(112, DRUIDBAROptionsPercentDropDown);
end

function DRUIDBAROptions_Percent_OnClick()
	i = this:GetID();
	UIDropDownMenu_SetSelectedID(DRUIDBAROptionsPercentDropDown, i);
	if(i == 1) then
		DruidBarKey.Percent = 0;
	elseif(i == 2) then
		DruidBarKey.Percent = 1;
	elseif(i == 3) then
		DruidBarKey.Percent = nil;
	end
end

function DRUIDBAROptions_Message()
	if(DruidBarKey.message) then
		DruidBarKey.message = false;
	else
		DruidBarKey.message = true;
	end
	DRUIDBAR_FrameSet();
end

function DRUIDBAROptions_MessageBear_Initialize()
	local info;
	for i = 0, 3, 1 do
		info = { };
		info.text = DRUIDBAR_OPTIONS_DROP.Message[i];
		info.func = DRUIDBAROptions_MessageBear_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function DRUIDBAROptions_MessageBear_OnShow()
		UIDropDownMenu_Initialize(Bear_Message, DRUIDBAROptions_MessageBear_Initialize);
		if( DruidBarKey.BearMessage[2] == "SAY") then
			UIDropDownMenu_SetSelectedID(Bear_Message, 1);
		elseif( DruidBarKey.BearMessage[2] == "PARTY") then
			UIDropDownMenu_SetSelectedID(Bear_Message, 2);
		elseif( DruidBarKey.BearMessage[2] == "RAID") then
			UIDropDownMenu_SetSelectedID(Bear_Message, 3);
		elseif( DruidBarKey.BearMessage[2] == "EMOTE") then
			UIDropDownMenu_SetSelectedID(Bear_Message, 4);
		elseif( not DruidBarKey.BearMessage[2]) then
			UIDropDownMenu_SetSelectedID(Bear_Message, 1);
			DruidBarKey.BearMessage[2] = "SAY";
		end
	UIDropDownMenu_SetWidth(80, Bear_Message);
end

function DRUIDBAROptions_MessageBear_OnClick()
	i = this:GetID();
	UIDropDownMenu_SetSelectedID(Bear_Message, i);
	
	if(i == 1) then
			DruidBarKey.BearMessage[2] = "SAY";
	elseif(i == 2) then
			DruidBarKey.BearMessage[2] = "PARTY";
	elseif(i == 3) then
			DruidBarKey.BearMessage[2] = "RAID";
	elseif(i == 4) then
			DruidBarKey.BearMessage[2] = "EMOTE";
	end
end

function DRUIDBAROptions_MessageAqua_Initialize()
	local info;
	for i = 0, 3, 1 do
		info = { };
		info.text = DRUIDBAR_OPTIONS_DROP.Message[i];
		info.func = DRUIDBAROptions_MessageAqua_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function DRUIDBAROptions_MessageAqua_OnShow()
		UIDropDownMenu_Initialize(Aqua_Message, DRUIDBAROptions_MessageAqua_Initialize);
		if( DruidBarKey.AquaMessage[2] == "SAY") then
			UIDropDownMenu_SetSelectedID(Aqua_Message, 1);
		elseif( DruidBarKey.AquaMessage[2] == "PARTY") then
			UIDropDownMenu_SetSelectedID(Aqua_Message, 2);
		elseif( DruidBarKey.AquaMessage[2] == "RAID") then
			UIDropDownMenu_SetSelectedID(Aqua_Message, 3);
		elseif( DruidBarKey.AquaMessage[2] == "EMOTE") then
			UIDropDownMenu_SetSelectedID(Aqua_Message, 4);
		elseif( not DruidBarKey.AquaMessage[2]) then
			UIDropDownMenu_SetSelectedID(Aqua_Message, 1);
			DruidBarKey.AquaMessage[2] = "SAY";
		end
	UIDropDownMenu_SetWidth(80, Aqua_Message);
end

function DRUIDBAROptions_MessageAqua_OnClick()
	i = this:GetID();
	UIDropDownMenu_SetSelectedID(Aqua_Message, i);
	
	if(i == 1) then
			DruidBarKey.AquaMessage[2] = "SAY";
	elseif(i == 2) then
			DruidBarKey.AquaMessage[2] = "PARTY";
	elseif(i == 3) then
			DruidBarKey.AquaMessage[2] = "RAID";
	elseif(i == 4) then
			DruidBarKey.AquaMessage[2] = "EMOTE";
	end
end

function DRUIDBAROptions_MessageCat_Initialize()
	local info;
	for i = 0, 3, 1 do
		info = { };
		info.text = DRUIDBAR_OPTIONS_DROP.Message[i];
		info.func = DRUIDBAROptions_MessageCat_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function DRUIDBAROptions_MessageCat_OnShow()
		UIDropDownMenu_Initialize(Cat_Message, DRUIDBAROptions_MessageCat_Initialize);
		if( DruidBarKey.CatMessage[2] == "SAY") then
			UIDropDownMenu_SetSelectedID(Cat_Message, 1);
		elseif( DruidBarKey.CatMessage[2] == "PARTY") then
			UIDropDownMenu_SetSelectedID(Cat_Message, 2);
		elseif( DruidBarKey.CatMessage[2] == "RAID") then
			UIDropDownMenu_SetSelectedID(Cat_Message, 3);
		elseif( DruidBarKey.CatMessage[2] == "EMOTE") then
			UIDropDownMenu_SetSelectedID(Cat_Message, 4);
		elseif( not DruidBarKey.CatMessage[2]) then
			UIDropDownMenu_SetSelectedID(Cat_Message, 1);
			DruidBarKey.CatMessage[2] = "SAY";
		end
	UIDropDownMenu_SetWidth(80, Cat_Message);
end

function DRUIDBAROptions_MessageCat_OnClick()
	i = this:GetID();
	UIDropDownMenu_SetSelectedID(Cat_Message, i);
	
	if(i == 1) then
			DruidBarKey.CatMessage[2] = "SAY";
	elseif(i == 2) then
			DruidBarKey.CatMessage[2] = "PARTY";
	elseif(i == 3) then
			DruidBarKey.CatMessage[2] = "RAID";
	elseif(i == 4) then
			DruidBarKey.CatMessage[2] = "EMOTE";
	end
end

function DRUIDBAROptions_MessageTrav_Initialize()
	local info;
	for i = 0, 3, 1 do
		info = { };
		info.text = DRUIDBAR_OPTIONS_DROP.Message[i];
		info.func = DRUIDBAROptions_MessageTrav_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function DRUIDBAROptions_MessageTrav_OnShow()
		UIDropDownMenu_Initialize(Trav_Message, DRUIDBAROptions_MessageTrav_Initialize);
		if( DruidBarKey.TravMessage[2] == "SAY") then
			UIDropDownMenu_SetSelectedID(Trav_Message, 1);
		elseif( DruidBarKey.TravMessage[2] == "PARTY") then
			UIDropDownMenu_SetSelectedID(Trav_Message, 2);
		elseif( DruidBarKey.TravMessage[2] == "RAID") then
			UIDropDownMenu_SetSelectedID(Trav_Message, 3);
		elseif( DruidBarKey.TravMessage[2] == "EMOTE") then
			UIDropDownMenu_SetSelectedID(Trav_Message, 4);
		elseif( not DruidBarKey.TravMessage[2]) then
			UIDropDownMenu_SetSelectedID(Trav_Message, 1);
			DruidBarKey.TravMessage[2] = "SAY";
		end
	UIDropDownMenu_SetWidth(80, Trav_Message);
end

function DRUIDBAROptions_MessageTrav_OnClick()
	i = this:GetID();
	UIDropDownMenu_SetSelectedID(Trav_Message, i);
	
	if(i == 1) then
			DruidBarKey.TravMessage[2] = "SAY";
	elseif(i == 2) then
			DruidBarKey.TravMessage[2] = "PARTY";
	elseif(i == 3) then
			DruidBarKey.TravMessage[2] = "RAID";
	elseif(i == 4) then
			DruidBarKey.TravMessage[2] = "EMOTE";
	end
end


function DRUIDBAROptions_MessageOOM_Initialize()
	local info;
	for i = 0, 3, 1 do
		info = { };
		info.text = DRUIDBAR_OPTIONS_DROP.Message[i];
		info.func = DRUIDBAROptions_MessageOOM_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function DRUIDBAROptions_MessageOOM_OnShow()
		UIDropDownMenu_Initialize(OOM_Message, DRUIDBAROptions_MessageOOM_Initialize);
		if( DruidBarKey.OOMMessage[2] == "SAY") then
			UIDropDownMenu_SetSelectedID(OOM_Message, 1);
		elseif( DruidBarKey.OOMMessage[2] == "PARTY") then
			UIDropDownMenu_SetSelectedID(OOM_Message, 2);
		elseif( DruidBarKey.OOMMessage[2] == "RAID") then
			UIDropDownMenu_SetSelectedID(OOM_Message, 3);
		elseif( DruidBarKey.OOMMessage[2] == "EMOTE") then
			UIDropDownMenu_SetSelectedID(OOM_Message, 4);
		elseif( not DruidBarKey.OOMMessage[2]) then
			UIDropDownMenu_SetSelectedID(OOM_Message, 1);
			DruidBarKey.OOMMessage[2] = "SAY";
		end
	UIDropDownMenu_SetWidth(80, OOM_Message);
end

function DRUIDBAROptions_MessageOOM_OnClick()
	i = this:GetID();
	UIDropDownMenu_SetSelectedID(OOM_Message, i);
	
	if(i == 1) then
			DruidBarKey.OOMMessage[2] = "SAY";
	elseif(i == 2) then
			DruidBarKey.OOMMessage[2] = "PARTY";
	elseif(i == 3) then
			DruidBarKey.OOMMessage[2] = "RAID";
	elseif(i == 4) then
			DruidBarKey.OOMMessage[2] = "EMOTE";
	end
end

function DRUIDBAR_FrameSet()
	if not DruidBarKey then return end
	if not DruidBarKey.tempW then DruidBarKey.tempW = 0; end
	if not DruidBarKey.tempH then DruidBarKey.tempH = 0; end
	DRUIDBAROptionsToggle:SetChecked(DruidBarKey.Enabled);
	DRUIDBAROptionsVis:SetChecked(DruidBarKey.Graphics);
	DRUIDBAROptionsReplace:SetChecked(DruidBarKey.Replace);
	DRUIDBAROptionsPlayer:SetChecked(DruidBarKey.XPBar);
	DRUIDBAROptionsLock:SetChecked(DruidBarKey.Lock);
	DRUIDBAROptionsHide:SetChecked(DruidBarKey.Hide);
	DRUIDBAROptionsFull:SetChecked(DruidBarKey.Full);
	DRUIDBAROptionsMessage:SetChecked(DruidBarKey.message);
	DRUIDBAROptionsWeightEditBox:SetText(DruidBarKey.tempW);
	DRUIDBAROptionsHeightEditBox:SetText(DruidBarKey.tempH);
	Bear_Message_EditBox:SetText(DruidBarKey.BearMessage[1]);
	Aqua_Message_EditBox:SetText(DruidBarKey.AquaMessage[1]);
	Cat_Message_EditBox:SetText(DruidBarKey.CatMessage[1]);
	Trav_Message_EditBox:SetText(DruidBarKey.TravMessage[1]);
	OOM_Message_EditBox:SetText(DruidBarKey.OOMMessage[1]);
	ManaBar_FrameLevel_EditBox:SetText(DruidBarKey.manatexture);
	ManaBorder_FrameLevel_EditBox:SetText(DruidBarKey.bordertexture);
	DRUIDBAROptionsKMG:SetChecked(DruidBarKey.kmg);
	
	if(MGplayer_ManaBar) then
		DRUIDBAROptionsKMG:Enable();
		DRUIDBAROptionsKMGText:SetText(DRUIDBAR_OPTIONS_KMG);
	else
		DRUIDBAROptionsKMG:Disable();
		DRUIDBAROptionsKMGText:SetText("|cff9d9d9d"..DRUIDBAR_OPTIONS_KMG.."|r");		
	end
	
	if(DruidBarKey.XPBar == false and DruidBarKey.Replace == false) then
		DRUIDBAROptionsCustom:SetChecked("true");
		DRUIDBAROptionsWeightText:SetText(DRUIDBAR_OPTIONS_Weight);	
		DRUIDBAROptionsHeightText:SetText(DRUIDBAR_OPTIONS_Height);	
	else
		DRUIDBAROptionsCustom:SetChecked("false");
		DRUIDBAROptionsWeightText:SetText("|cff9d9d9d"..DRUIDBAR_OPTIONS_Weight.."|r");	
		DRUIDBAROptionsHeightText:SetText("|cff9d9d9d"..DRUIDBAR_OPTIONS_Height.."|r");	
	end
	
	if(DruidBarKey.Enabled and DruidBarKey.Graphics) then
		DRUIDBAROptionsVis:Enable();
		DRUIDBAROptionsVisText:SetText(DRUIDBAR_OPTIONS_Vis);
		DRUIDBAROptionsReplace:Enable();
		DRUIDBAROptionsReplaceText:SetText(DRUIDBAR_OPTIONS_Replace);
		DRUIDBAROptionsPlayer:Enable();
		DRUIDBAROptionsPlayerText:SetText(DRUIDBAR_OPTIONS_Player);
		DRUIDBAROptionsCustom:Enable();
		DRUIDBAROptionsCustomText:SetText(DRUIDBAR_OPTIONS_Custom);
		DRUIDBAROptionsHide:Enable();
		DRUIDBAROptionsHideText:SetText(DRUIDBAR_OPTIONS_Hide);		
		DRUIDBAROptionsFull:Enable();
		DRUIDBAROptionsFullText:SetText(DRUIDBAR_OPTIONS_Full);		
		DRUIDBAROptionsLock:Enable();
		DRUIDBAROptionsLockText:SetText(DRUIDBAR_OPTIONS_Lock);
	elseif DruidBarKey.Enabled and not DruidBarKey.Graphics then
		DRUIDBAROptionsVis:Enable();
		DRUIDBAROptionsVisText:SetText(DRUIDBAR_OPTIONS_Vis);
		DRUIDBAROptionsReplace:Disable();
		DRUIDBAROptionsReplaceText:SetText("|cff9d9d9d"..DRUIDBAR_OPTIONS_Replace.."|r");		
		DRUIDBAROptionsPlayer:Disable();
		DRUIDBAROptionsPlayerText:SetText("|cff9d9d9d"..DRUIDBAR_OPTIONS_Player.."|r");		
		DRUIDBAROptionsCustom:Disable();
		DRUIDBAROptionsCustomText:SetText("|cff9d9d9d"..DRUIDBAR_OPTIONS_Custom.."|r");		
		DRUIDBAROptionsHide:Disable();
		DRUIDBAROptionsHideText:SetText("|cff9d9d9d"..DRUIDBAR_OPTIONS_Hide.."|r");		
		DRUIDBAROptionsFull:Disable();
		DRUIDBAROptionsFullText:SetText("|cff9d9d9d"..DRUIDBAR_OPTIONS_Full.."|r");		
		DRUIDBAROptionsLock:Disable();
		DRUIDBAROptionsLockText:SetText("|cff9d9d9d"..DRUIDBAR_OPTIONS_Lock.."|r");	
	elseif not DruidBarKey.Enabled then
		DRUIDBAROptionsVis:Disable();
		DRUIDBAROptionsVisText:SetText("|cff9d9d9d"..DRUIDBAR_OPTIONS_Vis.."|r");
		DRUIDBAROptionsReplace:Disable();
		DRUIDBAROptionsReplaceText:SetText("|cff9d9d9d"..DRUIDBAR_OPTIONS_Replace.."|r");		
		DRUIDBAROptionsPlayer:Disable();
		DRUIDBAROptionsPlayerText:SetText("|cff9d9d9d"..DRUIDBAR_OPTIONS_Player.."|r");		
		DRUIDBAROptionsCustom:Disable();
		DRUIDBAROptionsCustomText:SetText("|cff9d9d9d"..DRUIDBAR_OPTIONS_Custom.."|r");		
		DRUIDBAROptionsHide:Disable();
		DRUIDBAROptionsHideText:SetText("|cff9d9d9d"..DRUIDBAR_OPTIONS_Hide.."|r");		
		DRUIDBAROptionsFull:Disable();
		DRUIDBAROptionsFullText:SetText("|cff9d9d9d"..DRUIDBAR_OPTIONS_Full.."|r");		
		DRUIDBAROptionsLock:Disable();
		DRUIDBAROptionsLockText:SetText("|cff9d9d9d"..DRUIDBAR_OPTIONS_Lock.."|r");		
	end
end

function DRUIDBAROptions_GetColor()
	if not DruidBarKey then return end
		local info;
		info = this;
		info.hasColorSwatch = 1;
		info.r = DruidBarKey.color[1];
		info.g = DruidBarKey.color[2];
		info.b = DruidBarKey.color[3];
		info.notCheckable = 1;
		info.opacity = 1.0 - DruidBarKey.color[4];
		info.swatchFunc = function() DruidBarKey.color[1], DruidBarKey.color[2], DruidBarKey.color[3] = ColorPickerFrame:GetColorRGB(); end
		info.func = UIDropDownMenuButton_OpenColorPicker;
		info.hasOpacity = 0;
		info.opacityFunc = function() DruidBarKey.color[4] = 1.0 - OpacitySliderFrame:GetValue(); end;
		info.cancelFunc = function()    DruidBarKey.color[1] = ColorPickerFrame.previousValues.r;
										DruidBarKey.color[2] = ColorPickerFrame.previousValues.g;
										DruidBarKey.color[3] = ColorPickerFrame.previousValues.b;
										DruidBarKey.color[4] = 1.0 - ColorPickerFrame.previousValues.opacity; end;
		getglobal(this:GetName().."_SwatchBg"):SetVertexColor(DruidBarKey.color[1], DruidBarKey.color[2], DruidBarKey.color[3]);
end

function DRUIDBAROptions_GetBGColor()
	if not DruidBarKey then return end
		local info;
		info = this;
		info.hasColorSwatch = 1;
		info.r = DruidBarKey.bgcolor[1];
		info.g = DruidBarKey.bgcolor[2];
		info.b = DruidBarKey.bgcolor[3];
		info.notCheckable = 1;
		info.opacity = 1.0 - DruidBarKey.bgcolor[4];
		info.swatchFunc = function() DruidBarKey.bgcolor[1], DruidBarKey.bgcolor[2], DruidBarKey.bgcolor[3] = ColorPickerFrame:GetColorRGB(); end
		info.func = UIDropDownMenuButton_OpenColorPicker;
		info.hasOpacity = 0;
		info.opacityFunc = function() DruidBarKey.bgcolor[4] = 1.0 - OpacitySliderFrame:GetValue(); end;
		info.cancelFunc = function()    DruidBarKey.bgcolor[1] = ColorPickerFrame.previousValues.r;
										DruidBarKey.bgcolor[2] = ColorPickerFrame.previousValues.g;
										DruidBarKey.bgcolor[3] = ColorPickerFrame.previousValues.b;
										DruidBarKey.bgcolor[4] = 1.0 - ColorPickerFrame.previousValues.opacity; end;
		getglobal(this:GetName().."_SwatchBg"):SetVertexColor(DruidBarKey.bgcolor[1], DruidBarKey.bgcolor[2], DruidBarKey.bgcolor[3]);
end


function DRUIDBAROptions_GetBorderColor()
	if not DruidBarKey then return end
		local info;
		info = this;
		info.hasColorSwatch = 1;
		info.r = DruidBarKey.bordercolor[1];
		info.g = DruidBarKey.bordercolor[2];
		info.b = DruidBarKey.bordercolor[3];
		info.notCheckable = 1;
		info.opacity = 1.0 - DruidBarKey.bordercolor[4];
		info.swatchFunc = function() DruidBarKey.bordercolor[1], DruidBarKey.bordercolor[2], DruidBarKey.bordercolor[3] = ColorPickerFrame:GetColorRGB(); end
		info.func = UIDropDownMenuButton_OpenColorPicker;
		info.hasOpacity = 0;
		info.opacityFunc = function() DruidBarKey.bordercolor[4] = 1.0 - OpacitySliderFrame:GetValue(); end;
		info.cancelFunc = function()    DruidBarKey.bordercolor[1] = ColorPickerFrame.previousValues.r;
										DruidBarKey.bordercolor[2] = ColorPickerFrame.previousValues.g;
										DruidBarKey.bordercolor[3] = ColorPickerFrame.previousValues.b;
										DruidBarKey.bordercolor[4] = 1.0 - ColorPickerFrame.previousValues.opacity; end;
		getglobal(this:GetName().."_SwatchBg"):SetVertexColor(DruidBarKey.bordercolor[1], DruidBarKey.bordercolor[2], DruidBarKey.bordercolor[3]);
end



function DRUIDBAROptions_ManaBarFrameLevel_Initialize()
	local info;
	for i = 0, 3, 1 do
		info = { };
		info.text = DRUIDBAR_OPTIONS_DROP.Strata[i];
		info.func = DRUIDBAROptions_ManaBarFrameLevel_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function DRUIDBAROptions_ManaBarFrameLevel_OnShow()
		UIDropDownMenu_Initialize(ManaBar_FrameLevel, DRUIDBAROptions_ManaBarFrameLevel_Initialize);
		if DruidBarKey.barstrata then
			UIDropDownMenu_SetSelectedID(ManaBar_FrameLevel, DruidBarKey.barstrata+1);
		elseif not DruidBarKey.barstrata then
			UIDropDownMenu_SetSelectedID(ManaBar_FrameLevel, 2);
			DruidBarKey.barstrata = 2;
		end
	UIDropDownMenu_SetWidth(80, ManaBar_FrameLevel);
end

function DRUIDBAROptions_ManaBarFrameLevel_OnClick()
	i = this:GetID();
	DruidBarKey.barstrata = i-1;
	UIDropDownMenu_SetSelectedID(ManaBar_FrameLevel, i);
	DEFAULT_CHAT_FRAME:AddMessage(i);
end

function DRUIDBAROptions_ManaBorderFrameLevel_Initialize()
	local info;
	for i = 0, 3, 1 do
		info = { };
		info.text = DRUIDBAR_OPTIONS_DROP.Strata[i];
		info.func = DRUIDBAROptions_ManaBorderFrameLevel_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function DRUIDBAROptions_ManaBorderFrameLevel_OnShow()
		UIDropDownMenu_Initialize(ManaBorder_FrameLevel, DRUIDBAROptions_ManaBorderFrameLevel_Initialize);
		if DruidBarKey.borderstrata then
			local i;
			local j = DruidBarKey.borderstrata;
			if j == "BACKGROUND" then i = 1; elseif j == "BORDER" then i = 2; elseif j == "ARTWORK" then i = 3; elseif j == "OVERLAY" then i = 4; end
			UIDropDownMenu_SetSelectedID(ManaBorder_FrameLevel, i+1);
		elseif not DruidBarKey.borderstrata then
			UIDropDownMenu_SetSelectedID(ManaBorder_FrameLevel, 1);
			DruidBarKey.borderstrata = "BACKGROUND";
		end
	UIDropDownMenu_SetWidth(80, ManaBorder_FrameLevel);
end

function DRUIDBAROptions_ManaBorderFrameLevel_OnClick()
	i = this:GetID();
	local j;
	if i == 1 then j = "BACKGROUND"; elseif i == 2 then j = "BORDER"; elseif i == 3 then j = "ARTWORK"; elseif i == 4 then j = "OVERLAY"; end
	DruidBarKey.borderstrata = j;
	UIDropDownMenu_SetSelectedID(ManaBorder_FrameLevel, i);
end