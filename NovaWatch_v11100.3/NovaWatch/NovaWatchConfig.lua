--------------------------------------------------------
-- Config menu related functions
--------------------------------------------------------
function NovaWatchConfigButtonEnable_OnShow()
	if ( NOVAWATCH.STATUS == 1 ) then
		this:SetChecked(1);
	else
		this:SetChecked(0);
	end
end

function NovaWatchConfigButtonEnable_OnClick()
	if this:GetChecked() then
		NOVAWATCH.STATUS = 1;
		PlaySound("igMainMenuOptionCheckBoxOff");
	else
		NOVAWATCH.STATUS = 0;
		PlaySound("igMainMenuOptionCheckBoxOff");
	end
	NovaWatch_Settings.status = NOVAWATCH.STATUS;
end

-----------------------

function NovaWatchConfigButtonMove_OnClick()
	if ( NOVAWATCH.LOCKED ) then
		NOVAWATCH.STATUS = 3;
		NovaWatch:Show();
		NovaWatchCounterText:SetText( "00.0s" );
		NovaWatchCounterText:Show();
		NovaWatchConfigButtonMove:SetText( NOVAWATCH_LABEL_MOVE2 );
		DEFAULT_CHAT_FRAME:AddMessage(NOVAWATCH_TEXT_UNLOCKED);		
	else
		NOVAWATCH.STATUS = 1;
		NovaWatch:Hide();
		NovaWatchCounterText:Hide();
		NovaWatchConfigButtonMove:SetText( NOVAWATCH_LABEL_MOVE );
		DEFAULT_CHAT_FRAME:AddMessage(NOVAWATCH_TEXT_LOCKED);		
	end
	NOVAWATCH.LOCKED = not NOVAWATCH.LOCKED;
end

-----------------------

function NovaWatchConfigButtonClose_OnClick()
	if ( not NOVAWATCH.LOCKED ) then
		NOVAWATCH.LOCKED = true;
		NOVAWATCH.STATUS = 1;
		NovaWatch:Hide();
		NovaWatchCounterText:Hide();
		NovaWatchConfigButtonMove:SetText( NOVAWATCH_LABEL_MOVE );		
		DEFAULT_CHAT_FRAME:AddMessage(NOVAWATCH_TEXT_LOCKED);	
	end
	NovaWatchConfig:Hide();
end

-----------------------

function NovaWatchConfigButtonVerbose_OnShow()
	if ( NOVAWATCH.VERBOSE ) then
		this:SetChecked(1);
	else
		this:SetChecked(0);
	end
end

function NovaWatchConfigButtonVerbose_OnClick()
	if this:GetChecked() then
		NOVAWATCH.VERBOSE = true;
		PlaySound("igMainMenuOptionCheckBoxOff");
	else
		NOVAWATCH.VERBOSE = false;
		PlaySound("igMainMenuOptionCheckBoxOff");
	end
	NovaWatch_Settings.verbose = NOVAWATCH.VERBOSE;
end

-----------------------
function NovaWatchConfigButtonCounterDigits_OnShow()
	if ( NOVAWATCH.DECIMALS ) then
		this:SetChecked(1);
	else
		this:SetChecked(0);
	end
end

function NovaWatchConfigButtonCounterDigits_OnClick() if this:GetChecked() then 
NOVAWATCH.DECIMALS = true; PlaySound("igMainMenuOptionCheckBoxOff"); else 
NOVAWATCH.DECIMALS = false; PlaySound("igMainMenuOptionCheckBoxOff"); end 
NovaWatch_Settings.decimals = NOVAWATCH.DECIMALS; end

-----------------------
function NovaWatchConfigButtonCounter_OnShow()
	if ( NOVAWATCH.COUNTER ) then
		this:SetChecked(1);
	else
		this:SetChecked(0);
	end
end

function NovaWatchConfigButtonCounter_OnClick()
	if this:GetChecked() then
		NOVAWATCH.COUNTER = true;
		PlaySound("igMainMenuOptionCheckBoxOff");
	else
		NOVAWATCH.COUNTER = false;
		PlaySound("igMainMenuOptionCheckBoxOff");
	end
	NovaWatch_Settings.counter = NOVAWATCH.COUNTER;
end

-----------------------
function NovaWatchConfigDropdownDirection_Initialize()
	local info;
	for i = 1, getn(NOVAWATCH_LIST_DIRECTIONS), 1 do
		info = {
			text = NOVAWATCH_LIST_DIRECTIONS[i].name;
			func = NovaWatchConfigDropdownDirection_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end

function NovaWatchConfigDropdownDirection_OnLoad()
	UIDropDownMenu_SetWidth(110);
	UIDropDownMenu_SetButtonWidth(24);
	UIDropDownMenu_JustifyText("LEFT", NovaWatchConfigDropdownDirection);
end

function NovaWatchConfigDropdownDirection_OnShow()
	UIDropDownMenu_Initialize(NovaWatchConfigDropdownDirection, NovaWatchConfigDropdownDirection_Initialize);
	UIDropDownMenu_SetSelectedID( NovaWatchConfigDropdownDirection, NOVAWATCH.DIRECTION );
	UIDropDownMenu_SetWidth(110);
end

function NovaWatchConfigDropdownDirection_OnClick()
	i = this:GetID();
	UIDropDownMenu_SetSelectedID( NovaWatchConfigDropdownDirection, i );
	NOVAWATCH.DIRECTION = i;
	NovaWatch_Settings.direction = NOVAWATCH.DIRECTION;
end


------------------------------------------

function NovaWatchConfigAlphaSlider_Onload()
	getglobal(this:GetName().."Text"):SetText(NOVAWATCH_LABEL_TRANSPARENCY);
	getglobal(this:GetName().."High"):SetText("1");
	getglobal(this:GetName().."Low"):SetText("0");
	this:SetMinMaxValues(0,1);
	this:SetValueStep(0.1);
	this.tooltipText = NOVAWATCH_TOOLTIP_TRANSPARENCY
end

function NovaWatchConfigAlphaSlider_OnShow()
	if ( NOVAWATCH.ALPHA ) then
		this:SetValue(NOVAWATCH.ALPHA);
	else
		this:SetValue(1);
	end
end

function NovaWatchConfigAlphaSlider_OnValueChanged()
	NOVAWATCH.ALPHA = NovaWatchConfigAlphaSlider:GetValue();
	NovaWatch_Settings.alpha = NOVAWATCH.ALPHA;
	NovaWatch:SetAlpha( NOVAWATCH.ALPHA );
end

------------------------------------------

function NovaWatchConfigScaleSlider_Onload()
	getglobal(this:GetName().."Text"):SetText(NOVAWATCH_LABEL_SCALING);
	getglobal(this:GetName().."High"):SetText("3");
	getglobal(this:GetName().."Low"):SetText("0.25");
	this:SetMinMaxValues(0.25,3);
	this:SetValueStep(0.25);
	this.tooltipText = NOVAWATCH_TOOLTIP_SCALING;
end

function NovaWatchConfigScaleSlider_OnShow()
	if ( NOVAWATCH.SCALE ) then
		this:SetValue(NOVAWATCH.SCALE);
	else
		this:SetValue(1);
	end
end

function NovaWatchConfigScaleSlider_OnValueChanged()
	NOVAWATCH.SCALE = NovaWatchConfigScaleSlider:GetValue();
	NovaWatch_Settings.scale = NOVAWATCH.SCALE;
	NovaWatch:SetScale(UIParent:GetScale() * NOVAWATCH.SCALE);
end

------------------------------------------

function NovaWatchConfigBarColorSwatch_ShowColorPicker(frame)
--	if ( not NovaWatch_Settings["barcolor"] ) then
--		NovaWatch_Settings["barcolor"] = { };
--		NovaWatch_Settings["barcolor"] = {
--			r = 1, g = 1, b = 0, enabled = true
--		};
--	end
	frame.r = NovaWatch_Settings["barcolor"].r;
	frame.g = NovaWatch_Settings["barcolor"].g;
	frame.b = NovaWatch_Settings["barcolor"].b;
	frame.swatchFunc = NovaWatchConfigBarColor_SetColor;
	frame.cancelFunc = NovaWatchConfigBarColor_CancelColor;
	UIDropDownMenuButton_OpenColorPicker(frame);
end

function NovaWatchConfigBarColor_SetColor()
	local r, g, b = ColorPickerFrame:GetColorRGB();
	NovaWatch_Settings["barcolor"].r = r;
	NovaWatch_Settings["barcolor"].g = g;
	NovaWatch_Settings["barcolor"].b = b;
	NovaWatchConfigBarColorSwatchNormalTexture:SetVertexColor(NovaWatch_Settings["barcolor"].r, NovaWatch_Settings["barcolor"].g, NovaWatch_Settings["barcolor"].b);
	NovaWatchFrameStatusBar:SetStatusBarColor(NovaWatch_Settings["barcolor"].r, NovaWatch_Settings["barcolor"].g, NovaWatch_Settings["barcolor"].b);
end

function NovaWatchConfigBarColor_CancelColor()
	NovaWatch_Settings["barcolor"].r = NovaWatchConfigBarColorSwatch.r;
	NovaWatch_Settings["barcolor"].g = NovaWatchConfigBarColorSwatch.g;
	NovaWatch_Settings["barcolor"].b = NovaWatchConfigBarColorSwatch.b;
	NovaWatchConfigBarColorSwatchNormalTexture:SetVertexColor(NovaWatch_Settings["barcolor"].r, NovaWatch_Settings["barcolor"].g, NovaWatch_Settings["barcolor"].b);
end

-----------------------

