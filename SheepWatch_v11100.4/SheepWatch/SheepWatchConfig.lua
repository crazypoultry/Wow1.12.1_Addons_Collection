--------------------------------------------------------
-- Config menu related functions
--------------------------------------------------------
function SheepWatchConfigButtonEnable_OnShow()
	if ( SHEEPWATCH.STATUS == 1 ) then
		this:SetChecked(1);
	else
		this:SetChecked(0);
	end
end

function SheepWatchConfigButtonEnable_OnClick()
	if this:GetChecked() then
		SHEEPWATCH.STATUS = 1;
		PlaySound("igMainMenuOptionCheckBoxOff");
	else
		SHEEPWATCH.STATUS = 0;
		PlaySound("igMainMenuOptionCheckBoxOff");
	end
	SheepWatch_Settings.status = SHEEPWATCH.STATUS;
end

-----------------------

function SheepWatchEditboxAnnounce_OnShow()
	this:SetText(SHEEPWATCH.ANNOUNCEPATTERN);
	SheepWatchEditboxAnnounce:ClearFocus();
end

function SheepWatchEditboxAnnounce_OnLeave()
	SHEEPWATCH.ANNOUNCEPATTERN = this:GetText();
	SheepWatch_Settings.pattern = SHEEPWATCH.ANNOUNCEPATTERN;
end

-----------------------


function SheepWatchConfigButtonMove_OnClick()
	if ( SHEEPWATCH.LOCKED ) then
		SHEEPWATCH.STATUS = 3;
		SheepWatch:Show();
		SheepWatchCounterText:SetText( "00.0s" );
		SheepWatchCounterText:Show();
		SheepWatchConfigButtonMove:SetText( SHEEPWATCH_LABEL_MOVE2 );
		DEFAULT_CHAT_FRAME:AddMessage(SHEEPWATCH_TEXT_UNLOCKED);		
	else
		SHEEPWATCH.STATUS = 1;
		SheepWatch:Hide();
		SheepWatchCounterText:Hide();
		SheepWatchConfigButtonMove:SetText( SHEEPWATCH_LABEL_MOVE );
		DEFAULT_CHAT_FRAME:AddMessage(SHEEPWATCH_TEXT_LOCKED);		
	end
	SHEEPWATCH.LOCKED = not SHEEPWATCH.LOCKED;
end

-----------------------

function SheepWatchConfigButtonClose_OnClick()
	if ( not SHEEPWATCH.LOCKED ) then
		SHEEPWATCH.LOCKED = true;
		SHEEPWATCH.STATUS = 1;
		SheepWatch:Hide();
		SheepWatchCounterText:Hide();
		SheepWatchConfigButtonMove:SetText( SHEEPWATCH_LABEL_MOVE );		
		DEFAULT_CHAT_FRAME:AddMessage(SHEEPWATCH_TEXT_LOCKED);	
	end
	SheepWatchConfig:Hide();
end

-----------------------

function SheepWatchConfigButtonVerbose_OnShow()
	if ( SHEEPWATCH.VERBOSE ) then
		this:SetChecked(1);
	else
		this:SetChecked(0);
	end
end

function SheepWatchConfigButtonVerbose_OnClick()
	if this:GetChecked() then
		SHEEPWATCH.VERBOSE = true;
		PlaySound("igMainMenuOptionCheckBoxOff");
	else
		SHEEPWATCH.VERBOSE = false;
		PlaySound("igMainMenuOptionCheckBoxOff");
	end
	SheepWatch_Settings.verbose = SHEEPWATCH.VERBOSE;
end

-----------------------
function SheepWatchConfigButtonCounterDigits_OnShow()
	if ( SHEEPWATCH.DECIMALS ) then
		this:SetChecked(1);
	else
		this:SetChecked(0);
	end
end

function SheepWatchConfigButtonCounterDigits_OnClick() if this:GetChecked() then 
SHEEPWATCH.DECIMALS = true; PlaySound("igMainMenuOptionCheckBoxOff"); else 
SHEEPWATCH.DECIMALS = false; PlaySound("igMainMenuOptionCheckBoxOff"); end 
SheepWatch_Settings.decimals = SHEEPWATCH.DECIMALS; end

-----------------------
function SheepWatchConfigButtonCounter_OnShow()
	if ( SHEEPWATCH.COUNTER ) then
		this:SetChecked(1);
	else
		this:SetChecked(0);
	end
end

function SheepWatchConfigButtonCounter_OnClick()
	if this:GetChecked() then
		SHEEPWATCH.COUNTER = true;
		PlaySound("igMainMenuOptionCheckBoxOff");
	else
		SHEEPWATCH.COUNTER = false;
		PlaySound("igMainMenuOptionCheckBoxOff");
	end
	SheepWatch_Settings.counter = SHEEPWATCH.COUNTER;
end

-----------------------
function SheepWatchConfigDropdownDirection_Initialize()
	local info;
	for i = 1, getn(SHEEPWATCH_LIST_DIRECTIONS), 1 do
		info = {
			text = SHEEPWATCH_LIST_DIRECTIONS[i].name;
			func = SheepWatchConfigDropdownDirection_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end

function SheepWatchConfigDropdownDirection_OnLoad()
	UIDropDownMenu_SetWidth(110);
	UIDropDownMenu_SetButtonWidth(24);
	UIDropDownMenu_JustifyText("LEFT", SheepWatchConfigDropdownDirection);
end

function SheepWatchConfigDropdownDirection_OnShow()
	UIDropDownMenu_Initialize(SheepWatchConfigDropdownDirection, SheepWatchConfigDropdownDirection_Initialize);
	UIDropDownMenu_SetSelectedID( SheepWatchConfigDropdownDirection, SHEEPWATCH.DIRECTION );
	UIDropDownMenu_SetWidth(110);
end

function SheepWatchConfigDropdownDirection_OnClick()
	i = this:GetID();
	UIDropDownMenu_SetSelectedID( SheepWatchConfigDropdownDirection, i );
	SHEEPWATCH.DIRECTION = i;
	SheepWatch_Settings.direction = SHEEPWATCH.DIRECTION;
end

-----------------------
function SheepWatchConfigButtonAnnounce_OnShow()
	if ( SHEEPWATCH.ANNOUNCE ) then
		this:SetChecked(1);
	else
		this:SetChecked(0);
	end
end

function SheepWatchConfigButtonAnnounce_OnClick()
	if this:GetChecked() then
		SHEEPWATCH.ANNOUNCE = true;
		PlaySound("igMainMenuOptionCheckBoxOff");
	else
		SHEEPWATCH.ANNOUNCE = false;
		PlaySound("igMainMenuOptionCheckBoxOff");
	end
	SheepWatch_Settings.announce = SHEEPWATCH.ANNOUNCE;
end

------------------------------------------

function SheepWatchConfigDropdownAnnounceTarget_Initialize()
	local info;
	for i = 1, getn(SHEEPWATCH_LIST_ANNOUNCETARGETS), 1 do
		info = {
			text = SHEEPWATCH_LIST_ANNOUNCETARGETS[i].name;
			func = SheepWatchConfigDropdownAnnounceTarget_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end

function SheepWatchConfigDropdownAnnounceTarget_OnLoad()
	UIDropDownMenu_SetWidth(110);
	UIDropDownMenu_SetButtonWidth(24);
	UIDropDownMenu_JustifyText("LEFT", SheepWatchConfigDropdownAnnounceTarget);
end

function SheepWatchConfigDropdownAnnounceTarget_OnShow()
	UIDropDownMenu_Initialize(SheepWatchConfigDropdownAnnounceTarget, SheepWatchConfigDropdownAnnounceTarget_Initialize);
	UIDropDownMenu_SetSelectedID( SheepWatchConfigDropdownAnnounceTarget, SHEEPWATCH.ANNOUNCE_TARGET_ID );
	UIDropDownMenu_SetWidth(110);
end

function SheepWatchConfigDropdownAnnounceTarget_OnClick()
	i = this:GetID();
	UIDropDownMenu_SetSelectedID( SheepWatchConfigDropdownAnnounceTarget, i );

	SHEEPWATCH.ANNOUNCE_TARGET_ID = i;
	SheepWatch_Settings.targetid = SHEEPWATCH.ANNOUNCE_TARGET_ID;
	SHEEPWATCH.ANNOUNCE_TARGET = SHEEPWATCH_LIST_ANNOUNCETARGETS[SHEEPWATCH.ANNOUNCE_TARGET_ID].name;
end

------------------------------------------

function SheepWatchConfigDropdownAnnounceTime_Initialize()
	local info;
	for i = 1, getn(SHEEPWATCH_LIST_ANNOUNCETIME), 1 do
		info = {
			text = SHEEPWATCH_LIST_ANNOUNCETIME[i].name;
			func = SheepWatchConfigDropdownAnnounceTime_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end

function SheepWatchConfigDropdownAnnounceTime_OnLoad()
	UIDropDownMenu_SetWidth(110);
	UIDropDownMenu_SetButtonWidth(24);
	UIDropDownMenu_JustifyText("LEFT", SheepWatchConfigDropdownAnnounceTime);
end

function SheepWatchConfigDropdownAnnounceTime_OnShow()
	UIDropDownMenu_Initialize(SheepWatchConfigDropdownAnnounceTime, SheepWatchConfigDropdownAnnounceTime_Initialize);
	UIDropDownMenu_SetSelectedID( SheepWatchConfigDropdownAnnounceTime, SHEEPWATCH.ANNOUNCE_TIME_ID );
	UIDropDownMenu_SetWidth(110);
end

function SheepWatchConfigDropdownAnnounceTime_OnClick()
	i = this:GetID();
	UIDropDownMenu_SetSelectedID( SheepWatchConfigDropdownAnnounceTime, i );

	SHEEPWATCH.ANNOUNCE_TIME_ID = i;
	SheepWatch_Settings.timeid = SHEEPWATCH.ANNOUNCE_TIME_ID;
end

------------------------------------------

function SheepWatchConfigAlphaSlider_Onload()
	getglobal(this:GetName().."Text"):SetText(SHEEPWATCH_LABEL_TRANSPARENCY);
	getglobal(this:GetName().."High"):SetText("1");
	getglobal(this:GetName().."Low"):SetText("0");
	this:SetMinMaxValues(0,1);
	this:SetValueStep(0.1);
	this.tooltipText = SHEEPWATCH_TOOLTIP_TRANSPARENCY
end

function SheepWatchConfigAlphaSlider_OnShow()
	if ( SHEEPWATCH.ALPHA ) then
		this:SetValue(SHEEPWATCH.ALPHA);
	else
		this:SetValue(1);
	end
end

function SheepWatchConfigAlphaSlider_OnValueChanged()
	SHEEPWATCH.ALPHA = SheepWatchConfigAlphaSlider:GetValue();
	SheepWatch_Settings.alpha = SHEEPWATCH.ALPHA;
	SheepWatch:SetAlpha( SHEEPWATCH.ALPHA );
end

------------------------------------------

function SheepWatchConfigScaleSlider_Onload()
	getglobal(this:GetName().."Text"):SetText(SHEEPWATCH_LABEL_SCALING);
	getglobal(this:GetName().."High"):SetText("3");
	getglobal(this:GetName().."Low"):SetText("0.25");
	this:SetMinMaxValues(0.25,3);
	this:SetValueStep(0.25);
	this.tooltipText = SHEEPWATCH_TOOLTIP_SCALING;
end

function SheepWatchConfigScaleSlider_OnShow()
	if ( SHEEPWATCH.SCALE ) then
		this:SetValue(SHEEPWATCH.SCALE);
	else
		this:SetValue(1);
	end
end

function SheepWatchConfigScaleSlider_OnValueChanged()
	SHEEPWATCH.SCALE = SheepWatchConfigScaleSlider:GetValue();
	SheepWatch_Settings.scale = SHEEPWATCH.SCALE;
	SheepWatch:SetScale(UIParent:GetScale() * SHEEPWATCH.SCALE);
end

------------------------------------------

function SheepWatchConfigBarColorSwatch_ShowColorPicker(frame)
--	if ( not SheepWatch_Settings["barcolor"] ) then
--		SheepWatch_Settings["barcolor"] = { };
--		SheepWatch_Settings["barcolor"] = {
--			r = 1, g = 1, b = 0, enabled = true
--		};
--	end
	frame.r = SheepWatch_Settings["barcolor"].r;
	frame.g = SheepWatch_Settings["barcolor"].g;
	frame.b = SheepWatch_Settings["barcolor"].b;
	frame.swatchFunc = SheepWatchConfigBarColor_SetColor;
	frame.cancelFunc = SheepWatchConfigBarColor_CancelColor;
	UIDropDownMenuButton_OpenColorPicker(frame);
end

function SheepWatchConfigBarColor_SetColor()
	local r, g, b = ColorPickerFrame:GetColorRGB();
	SheepWatch_Settings["barcolor"].r = r;
	SheepWatch_Settings["barcolor"].g = g;
	SheepWatch_Settings["barcolor"].b = b;
	SheepWatchConfigBarColorSwatchNormalTexture:SetVertexColor(SheepWatch_Settings["barcolor"].r, SheepWatch_Settings["barcolor"].g, SheepWatch_Settings["barcolor"].b);
	SheepWatchFrameStatusBar:SetStatusBarColor(SheepWatch_Settings["barcolor"].r, SheepWatch_Settings["barcolor"].g, SheepWatch_Settings["barcolor"].b);
end

function SheepWatchConfigBarColor_CancelColor()
	SheepWatch_Settings["barcolor"].r = SheepWatchConfigBarColorSwatch.r;
	SheepWatch_Settings["barcolor"].g = SheepWatchConfigBarColorSwatch.g;
	SheepWatch_Settings["barcolor"].b = SheepWatchConfigBarColorSwatch.b;
	SheepWatchConfigBarColorSwatchNormalTexture:SetVertexColor(SheepWatch_Settings["barcolor"].r, SheepWatch_Settings["barcolor"].g, SheepWatch_Settings["barcolor"].b);
end

-----------------------

