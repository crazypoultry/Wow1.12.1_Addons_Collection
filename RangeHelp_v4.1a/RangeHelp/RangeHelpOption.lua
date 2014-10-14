local enable_cust_spell = 0;

function RangeHelpOption_OnLoad()
	MeleeSpell_Description:SetText(RHOPTION_TEXT1);
	RangeSpell_Description:SetText(RHOPTION_TEXT2);
	MeleeBar_Description:SetText(RHOPTION_TEXT3);
	RangeBar_Description:SetText(RHOPTION_TEXT4);
	LockCombatBarText:SetText(RHOPTION_TEXT5);
	HideRangeInfoText:SetText(RHOPTION_TEXT6);
	EnableRangeHelpText:SetText(RHOPTION_TEXT7);
	DeadZoneBarSwitchText:SetText(RHOPTION_TEXT8);
	DisableBarSwitchText:SetText(RHOPTION_TEXT9);
	SetupVersionText:SetText("RangeHelp v"..RangeHelp_curVer);
	OptionApply:SetText(RHOPTION_XML_APPLY);
	OptionConfirm:SetText(RHOPTION_XML_CONFIRM);
	OptionCancel:SetText(RHOPTION_XML_CANCEL);
	OptionCust:SetText(RHOPTION_XML_CUSTOMISEUI);
	OptionSpellKeyBind:SetText(RHOPTION_XML_SPELLKEYBIND);
	OptionCustSpell:SetText(RHOPTION_XML_ENABLECUSTSPELL);
end

function RangeHelpOption_OnShow()
	local playerClass, englishClass = UnitClass("player");
	if(UnitLevel("player") < 12 and englishClass == "HUNTER") then
		_ERRORMESSAGE(RHOPTION_LEVEL_NOT_MET);
	end
	RangeHelpUpdateSlot();
	RangeHelpOption_CustSpellDisp();
	MeleeBar:SetText(RangeConfig[RangeHelp_playerID]["melee page"]);
	RangeBar:SetText(RangeConfig[RangeHelp_playerID]["range page"]);
	LockCombatBar:SetChecked(RangeConfig[RangeHelp_playerID]["lock"]);	
	HideRangeInfo:SetChecked(RangeConfig[RangeHelp_playerID]["hide rangeinfo"]);	
	DeadZoneBarSwitch:SetChecked(RangeConfig[RangeHelp_playerID]["switch at deadzone"]);
	DisableBarSwitch:SetChecked(RangeConfig[RangeHelp_playerID]["enable barswitch"]);
	EnableRangeHelp:SetChecked(RangeConfig[RangeHelp_playerID]["enable rangehelp"]);	
end

function RangeHelpOption_ApplyBut()
	local success = 0;
	local mp = 1;
	local rp = 2;
	if(EnableRangeHelp:GetChecked() == 1) then
		RangeConfig[RangeHelp_playerID]["enable rangehelp"] = 1;
		RangeHelp:RegisterEvent("ACTIONBAR_SLOT_CHANGED");	
	else
		RangeConfig[RangeHelp_playerID]["enable rangehelp"] = 0;
		RangeHelp:UnregisterEvent("ACTIONBAR_SLOT_CHANGED");	
		HideUIPanel(TargetRangeInfo);
		return 1;
	end
	if((MeleeSpell:GetText() == "" or RangeSpell:GetText() == "")  or 
		((MeleeBar:GetText() == "" or RangeBar:GetText() == "") and DisableBarSwitch:GetChecked() == 1)) then
		_ERRORMESSAGE(RHOPTION_APPLY_ERR1);
	else
		if(DisableBarSwitch:GetChecked() == 1) then
			mp = abs(MeleeBar:GetText());
			rp = abs(RangeBar:GetText());
			if(mp < 1 or mp > NUM_ACTIONBAR_PAGES or rp < 1 or rp > NUM_ACTIONBAR_PAGES) then
				_ERRORMESSAGE(RHOPTION_APPLY_ERR2);
				return 0;
			end
		end

		if(enable_cust_spell == 1) then
			RangeConfig[RangeHelp_playerID]["melee name"] = MeleeSpell:GetText();
			RangeConfig[RangeHelp_playerID]["range name"] = RangeSpell:GetText();
		end
		RangeConfig[RangeHelp_playerID]["melee page"] = mp;
		RangeConfig[RangeHelp_playerID]["range page"] = rp;
		if(LockCombatBar:GetChecked() == 1) then
			RangeConfig[RangeHelp_playerID]["lock"] = 1;
		else
			RangeConfig[RangeHelp_playerID]["lock"] = 0;
		end
		if(HideRangeInfo:GetChecked() == 1) then
			RangeConfig[RangeHelp_playerID]["hide rangeinfo"] = 1;
		else
			RangeConfig[RangeHelp_playerID]["hide rangeinfo"] = 0;
		end
		if(DeadZoneBarSwitch:GetChecked() == 1) then
			RangeConfig[RangeHelp_playerID]["switch at deadzone"] = 1;
		else
			RangeConfig[RangeHelp_playerID]["switch at deadzone"] = 0;
		end
		if(DisableBarSwitch:GetChecked() == 1) then
			RangeConfig[RangeHelp_playerID]["enable barswitch"] = 1;
		else
			RangeConfig[RangeHelp_playerID]["enable barswitch"] = 0;
		end
		RangeHelpUpdateSlot();
		RangeHelpOption_OnShow();
		success = 1;
	end
	return success;	
end

function RangeHelpOption_CustSpell()
	if(enable_cust_spell == 0) then
		enable_cust_spell = 1;
	else
		enable_cust_spell = 0;
		RangeConfig[RangeHelp_playerID]["melee name"] = RH_MELEESPELL[1];
		RangeConfig[RangeHelp_playerID]["range name"] = RH_RANGESPELL[1];
	end
		
	RangeHelpOption_CustSpellDisp();
end

function RangeHelpOption_CustSpellDisp()
	if(enable_cust_spell == 0) then
		MeleeSpell:EnableKeyboard(false);
		RangeSpell:EnableKeyboard(false);
		OptionCustSpell:SetText(RHOPTION_XML_ENABLECUSTSPELL);
		if(RangeConfig[RangeHelp_playerID]["melee slot"] ~= -1) then
			MeleeSpell:SetText(RHOPTION_SPELLDISP_OK);
		else
			MeleeSpell:SetText(RHOPTION_SPELLDISP_NOTFOUND);
		end
		if(RangeConfig[RangeHelp_playerID]["range slot"] ~= -1) then
			RangeSpell:SetText(RHOPTION_SPELLDISP_OK);
		else
			RangeSpell:SetText(RHOPTION_SPELLDISP_NOTFOUND);
		end
	else
		MeleeSpell:EnableKeyboard(true);
		RangeSpell:EnableKeyboard(true);
		OptionCustSpell:SetText(RHOPTION_XML_DISABLECUSTSPELL);
		MeleeSpell:SetText(RangeConfig[RangeHelp_playerID]["melee name"]);
		RangeSpell:SetText(RangeConfig[RangeHelp_playerID]["range name"]);
	end
end

function RangeHelpOption_ConfirmBut()
	hide = RangeHelpOption_ApplyBut();
	if(hide == 1) then
		HideUIPanel(RangeHelpSetup);
	end
end

function RangeHelpOption_CancelBut()
	HideUIPanel(RangeHelpSetup);
end

function RangeHelpOption_CustBut()
	ShowUIPanel(RangeHelpUISetup);
end

-------- UI Customisation Functions
local oldRangeInfoPos = { x=0.0, y=0.0 };

local TempColor = { ["melee ui"] = { BGColor = {r=0.0, g=0.0, b=0.0, alpha=0.7},
								BorColor = {r=0.0, g=0.0, b=0.0, alpha=0.7},
								FontColor = {r=0.0, g=0.0, b=0.0},
								Text = "" },
					["range ui"] = { BGColor = {r=0.0, g=0.0, b=0.0, alpha=0.7},
								BorColor = {r=0.0, g=0.0, b=0.0, alpha=0.7},
								FontColor = {r=0.0, g=0.0, b=0.0},
								Text = "" },
					["dead ui"] = { BGColor = {r=0.0, g=0.0, b=0.0, alpha=0.7},
								BorColor = {r=0.0, g=0.0, b=0.0, alpha=0.7},
								FontColor = {r=0.0, g=0.0, b=0.0},
								Text = "" },
					["oorange ui"] = { BGColor = {r=0.0, g=0.0, b=0.0, alpha=0.7},
								BorColor = {r=0.0, g=0.0, b=0.0, a=0.0, alpha=0.7},
								FontColor = {r=0.0, g=0.0, b=0.0},
								Text = "" },
					["all"] = { BGColor = {r=0.0, g=0.0, b=0.0, alpha=0.7},
								BorColor = {r=0.0, g=0.0, b=0.0, alpha=0.7},
								FontColor = {r=0.0, g=0.0, b=0.0},
								Text = "ALL" } }
local colIndex = "";
local colorModState = "";

RangeHelp_UISetup = 0;

function RangeHelpUIOption_OnLoad()
	ResizeCheckText:SetText(RHUISETUP_TEXT1);
	MoveCheckText:SetText(RHUISETUP_TEXT2);
	FontHeightText:SetText(RHUISETUP_TEXT3);
	FontHeightLow:SetText("0.0");
	FontHeightHigh:SetText("3.0");
	FontHeight:SetMinMaxValues(0, 3);
	FontHeight:SetValueStep(0.1);
	BGLockText:SetText(RHUISETUP_TEXT4);
	BorderLockText:SetText(RHUISETUP_TEXT5);
	FontLockText:SetText(RHUISETUP_TEXT6);
	BGBorLinkText:SetText(RHUISETUP_TEXT7);
	StateText_Description:SetText(RHUISETUP_TEXT8);
	StateText_Description:SetPoint("TOPLEFT", "StateText", "TOPLEFT", -40, -8);
	RangeStateText:SetText(RHUISETUP_XML_RANGESTATE);
	BGColorSel:SetText(RHUISETUP_XML_BACKCOLOUR);
	BorColorSel:SetText(RHUISETUP_XML_BORDERCOLOUR);
	FontColorSel:SetText(RHUISETUP_XML_FONTCOLOUR);
	UIOptionApply:SetText(RHOPTION_XML_APPLY);
	UIOptionConfirm:SetText(RHOPTION_XML_CONFIRM);
	UIOptionCancel:SetText(RHOPTION_XML_CANCEL);
	UIOptionDefault:SetText(RHUISETUP_XML_DEFAULT);
	UIOptionResetFrameLoc:SetText(RHUISETUP_XML_RESETFRAMELOC);
	UIVersionText:SetText("RangeHelp v"..RangeHelp_curVer);
	this:RegisterEvent("VARIABLES_LOADED");
	RangeHelp_UISetup = 0;
end

function RangeHelpUIOption_OnEvent(event)
	if(event == "VARIABLES_LOADED") then
		if (not RangeHelpOption) then
			RangeHelpOption = {};
			RangeHelpOption["Version"] = RangeHelp_curVer;
		else
			if(not RangeHelpOption["Version"]) then
				RangeHelpOption["Version"] = "2.1";
				RangeHelpOption["font height"] = 1.0;
			end
			if(RangeHelpOption["Version"] == "2.1") then		
				newRangeUI = {};
				newRangeUI[RangeHelp_playerID] = {};
				CopyTable(RangeHelpOption, newRangeUI[RangeHelp_playerID]);
				RangeHelpOption = newRangeUI;
				RangeHelpOption["Version"] = RangeHelp_curVer;
			end
		end
		RangeHelpOption["Version"] = RangeHelp_curVer;
		if(not RangeHelpOption[RangeHelp_playerID]) then
			RangeHelpOption[RangeHelp_playerID] = {};
			RangeHelpOption[RangeHelp_playerID]["resize"] = 0;
			RangeHelpOption[RangeHelp_playerID]["move"] = 1;
			RangeHelpOption[RangeHelp_playerID]["lock back"] = 0;
			RangeHelpOption[RangeHelp_playerID]["lock border"] = 0;
			RangeHelpOption[RangeHelp_playerID]["lock font"] = 0;
			RangeHelpOption[RangeHelp_playerID]["link backbg"] = 0;
			RangeHelpOption[RangeHelp_playerID]["melee ui"] = { BGColor={r=0.0,g=1.0,b=0.0,alpha=0.7},
										 BorColor={r=0.0,g=1.0,b=0.0,alpha=0.7},
										 FontColor={r=1.0,g=1.0,b=1.0},
										 Text=RHUISETUP_MELEE  };
			RangeHelpOption[RangeHelp_playerID]["range ui"] = { BGColor={r=0.0,g=0.0,b=1.0,alpha=0.7},
										 BorColor={r=0.0,g=0.0,b=1.0,alpha=0.7},
										 FontColor={r=1.0,g=1.0,b=1.0},
										 Text=RHUISETUP_RANGE };
			RangeHelpOption[RangeHelp_playerID]["dead ui"] = { BGColor={r=1.0,g=0.5,b=0.0,alpha=0.7},
										 BorColor={r=1.0,g=0.5,b=0.0,alpha=0.7},
										 FontColor={r=1.0,g=1.0,b=1.0},
										 Text=RHUISETUP_DEADZONE };										 
			RangeHelpOption[RangeHelp_playerID]["oorange ui"] = { BGColor={r=1.0,g=0.0,b=0.0,alpha=0.7},
										 BorColor={r=1.0,g=0.0,b=0.0,alpha=0.7},
										 FontColor={r=1.0,g=1.0,b=1.0},
										 Text=RHUISETUP_OUTOFRANGE };
			RangeHelpOption[RangeHelp_playerID]["font height"] = 1.0;	
		end
		
		RangeHelpSetUI();
	end
end

function RangeHelpSetUI()
	if(RangeHelpOption[RangeHelp_playerID]["move"] == 0 and RangeHelpOption[RangeHelp_playerID]["resize"] == 0) then
		TargetRangeInfo:EnableMouse("false");
	else
		TargetRangeInfo:EnableMouse("true");
	end
end

function RangeDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, RangeDropDown_Initialize);
end

function RangeHelpUIOption_OnShow()
	BGColorSel:Disable();
	BorColorSel:Disable();
	FontColorSel:Disable();
	UIDropDownMenu_ClearAll(RangeDropDown);	
	ResizeCheck:SetChecked(RangeHelpOption[RangeHelp_playerID]["resize"]);
	MoveCheck:SetChecked(RangeHelpOption[RangeHelp_playerID]["move"]);
	BGLock:SetChecked(RangeHelpOption[RangeHelp_playerID]["lock back"]);
	BorderLock:SetChecked(RangeHelpOption[RangeHelp_playerID]["lock border"]);
	FontLock:SetChecked(RangeHelpOption[RangeHelp_playerID]["lock font"]);
	BGBorLink:SetChecked(RangeHelpOption[RangeHelp_playerID]["link backbg"]);
	if(BGBorLink:GetChecked() == 1) then
		BorderLock:SetChecked(0);
		BorderLock:Disable();
	end
	FontHeight:SetValue(RangeHelpOption[RangeHelp_playerID]["font height"]);
	colIndex = "";
	
	RangeHelp_UISetup = 1;	
	TargetRangeInfo:Show();
	TargetRange:SetText("UI Customise");
	TargetRange:SetTextColor(1,1,1);
	TargetRangeInfo:SetBackdropColor(1, 1, 1, 1);
	TargetRangeInfo:SetBackdropBorderColor(1, 1, 1, 1);
	StateText:SetText("");
	StateText:EnableKeyboard(false);
	CopyTable(RangeHelpOption[RangeHelp_playerID]["melee ui"], TempColor["melee ui"]);
	CopyTable(RangeHelpOption[RangeHelp_playerID]["dead ui"], TempColor["dead ui"]);
	CopyTable(RangeHelpOption[RangeHelp_playerID]["range ui"], TempColor["range ui"]);
	CopyTable(RangeHelpOption[RangeHelp_playerID]["oorange ui"], TempColor["oorange ui"]);
	CopyTable(RangeHelpOption[RangeHelp_playerID]["melee ui"], TempColor["all"]);
end

function CopyTable(srcTable, destTable)
	local si, sv = next(srcTable, nil);
	while si do
		if(type(sv) ~= "table") then
			destTable[si] = srcTable[si];
		else
			destTable[si] = {};
			dv = destTable[si];
			CopyTable(sv, dv);
		end
		si, sv = next(srcTable, si);
	end
end

function RangeDropDown_Initialize()
	local info = {};
	info.text = RHUISETUP_MELEE;
	info.value = 0;
	info.func = RangeDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = RHUISETUP_DEADZONE;
	info.value = 1;
	info.func = RangeDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = RHUISETUP_RANGE;
	info.value = 2;
	info.func = RangeDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = RHUISETUP_OUTOFRANGE;
	info.value = 3;
	info.func = RangeDropDown_OnClick;
	UIDropDownMenu_AddButton(info);	
	
	info = {};
	info.text = RHUISETUP_ALLSTATE;
	info.value = 4;
	info.func = RangeDropDown_OnClick;
	UIDropDownMenu_AddButton(info);	
end

function RangeDropDown_OnClick()
	UIDropDownMenu_SetSelectedValue(RangeDropDown, this.value);
	RangeHelpUIOption_ColorSetup(this.value);
	
	TargetRangeInfo:Show();
	TargetRange:SetText(TempColor[colIndex].Text);	
	if(this.value ~= 4) then
		StateText:SetText(TempColor[colIndex].Text);
		StateText:EnableKeyboard(true);
	else
		StateText:EnableKeyboard(false);
		StateText:SetText("");
	end
end

function RangeHelpUIOption_ColorSetup(value)
	if(value == nil) then
		value = UIDropDownMenu_GetSelectedValue(RangeDropDown);
	end
	if(value ~= nil) then
		HideUIPanel(RangeHelpColorPicker);
		BGColorSel:Disable();
		BorColorSel:Disable();
		FontColorSel:Disable();
		if(value ~= 4) then
			if(value == 0) then
				colIndex = "melee ui";
			elseif(value == 2) then
				colIndex = "range ui";
			elseif(value == 1) then
				colIndex = "dead ui";
			elseif(value == 3) then
				colIndex = "oorange ui";
			end

			if(BGLock:GetChecked() == nil) then
				BGColorSel:Enable();
				TargetRangeInfo:SetBackdropColor(TempColor[colIndex].BGColor.r,
									TempColor[colIndex].BGColor.g,
									TempColor[colIndex].BGColor.b,
									TempColor[colIndex].BGColor.alpha);
			else
				TargetRangeInfo:SetBackdropColor(TempColor["all"].BGColor.r,
										TempColor["all"].BGColor.g,
										TempColor["all"].BGColor.b,
										TempColor["all"].BGColor.alpha);
			end 
			if(BorderLock:GetChecked() == nil and BGBorLink:GetChecked() == nil) then
				BorColorSel:Enable();
				TargetRangeInfo:SetBackdropBorderColor(TempColor[colIndex].BorColor.r,
														TempColor[colIndex].BorColor.g,
														TempColor[colIndex].BorColor.b,
														TempColor[colIndex].BorColor.alpha);
			elseif(BGLock:GetChecked() == 1 and BGBorLink:GetChecked() == 1) then
				TargetRangeInfo:SetBackdropBorderColor(TempColor["all"].BGColor.r,
														TempColor["all"].BGColor.g,
														TempColor["all"].BGColor.b,
														TempColor["all"].BGColor.alpha);
			elseif(BorderLock:GetChecked() == 1) then
				TargetRangeInfo:SetBackdropBorderColor(TempColor["all"].BorColor.r,
														TempColor["all"].BorColor.g,
														TempColor["all"].BorColor.b,
														TempColor["all"].BorColor.alpha);
			elseif(BGBorLink:GetChecked() == 1) then
				TargetRangeInfo:SetBackdropBorderColor(TempColor[colIndex].BGColor.r,
														TempColor[colIndex].BGColor.g,
														TempColor[colIndex].BGColor.b,
														TempColor[colIndex].BGColor.alpha);
			end
			if(FontLock:GetChecked() == nil) then
				FontColorSel:Enable();
				TargetRange:SetTextColor(TempColor[colIndex].FontColor.r,
											TempColor[colIndex].FontColor.g,
											TempColor[colIndex].FontColor.b);
			else
				TargetRange:SetTextColor(TempColor["all"].FontColor.r,
											TempColor["all"].FontColor.g,
											TempColor["all"].FontColor.b);
			end
		elseif(value == 4) then
			colIndex = "all";
			if(BGLock:GetChecked() == 1) then
				BGColorSel:Enable();
				TargetRangeInfo:SetBackdropColor(TempColor[colIndex].BGColor.r,
									TempColor[colIndex].BGColor.g,
									TempColor[colIndex].BGColor.b,
									TempColor[colIndex].BGColor.alpha);
			else
				TargetRangeInfo:SetBackdropColor(0,0,0,0);
			end 
			if(BorderLock:GetChecked() == 1 and BGBorLink:GetChecked() == nil) then
				BorColorSel:Enable();
				TargetRangeInfo:SetBackdropBorderColor(TempColor[colIndex].BorColor.r,
														TempColor[colIndex].BorColor.g,
														TempColor[colIndex].BorColor.b,
														TempColor[colIndex].BorColor.alpha);
			elseif(BGLock:GetChecked() == 1 and BGBorLink:GetChecked() == 1) then
				TargetRangeInfo:SetBackdropBorderColor(TempColor[colIndex].BGColor.r,
														TempColor[colIndex].BGColor.g,
														TempColor[colIndex].BGColor.b,
														TempColor[colIndex].BGColor.alpha);
			else
				TargetRangeInfo:SetBackdropBorderColor(0,0,0,0);
			end
			if(FontLock:GetChecked() == 1) then
				FontColorSel:Enable();
				TargetRange:SetTextColor(TempColor[colIndex].FontColor.r,
											TempColor[colIndex].FontColor.g,
											TempColor[colIndex].FontColor.b);
				TempColor[colIndex].Text = "Text Colour";
				TargetRange:SetText(TempColor[colIndex].Text);
			else
				TempColor[colIndex].Text = "";
				TargetRange:SetText(TempColor[colIndex].Text);				
			end
		end
	end
end

function RangeHelpUIOption_MoveCheck()
	if(MoveCheck:GetChecked() == 1) then
		RangeHelpOption[RangeHelp_playerID]["move"] = 1;
	else
		RangeHelpOption[RangeHelp_playerID]["move"] = 0;
	end
	RangeHelpSetUI();
end

function RangeHelpUIOption_ResizeCheck()
	if(ResizeCheck:GetChecked() == 1) then
		RangeHelpOption[RangeHelp_playerID]["resize"] = 1;
	else
		RangeHelpOption[RangeHelp_playerID]["resize"] = 0;
	end
	RangeHelpSetUI();
end

function RangeHelpUIOption_FontHeightChanged()
	RangeInfoFontFrame:SetScale(FontHeight:GetValue());
end

function RangeHelpUIOption_BGColourSel()
	colorModState = "BGColor";
	RangeHelpColorPicker:SetColorRGB(TempColor[colIndex].BGColor.r, 
										TempColor[colIndex].BGColor.g,
										TempColor[colIndex].BGColor.b);
	RangeHelpOpacitySlider:SetValue(TempColor[colIndex].BGColor.alpha);
	ShowUIPanel(RangeHelpColorPicker);
end

function RangeHelpUIOption_BorColourSel()
	colorModState = "BorColor";
	RangeHelpColorPicker:SetColorRGB(TempColor[colIndex].BorColor.r, 
										TempColor[colIndex].BorColor.g,
										TempColor[colIndex].BorColor.b);
	RangeHelpOpacitySlider:SetValue(TempColor[colIndex].BorColor.alpha);
	ShowUIPanel(RangeHelpColorPicker);
end

function RangeHelpUIOption_FontColourSel()
	colorModState = "FontColor";
	RangeHelpColorPicker:SetColorRGB(TempColor[colIndex].FontColor.r, 
										TempColor[colIndex].FontColor.g,
										TempColor[colIndex].FontColor.b);
	RangeHelpOpacitySlider:SetValue(0.0);
	ShowUIPanel(RangeHelpColorPicker);
end

function RangeHelpUIOption_StateTextChanged()
	value = UIDropDownMenu_GetSelectedValue(RangeDropDown);
	if(value ~= 4 and value ~= nil) then
		TargetRange:SetText(StateText:GetText());
		TempColor[colIndex].Text = StateText:GetText();
	end
end

function RangeHelpUIOption_ApplyBut()
	RangeHelpOption[RangeHelp_playerID]["font height"] = FontHeight:GetValue();

	if(BGLock:GetChecked() == 1) then
		RangeHelpOption[RangeHelp_playerID]["lock back"] = 1;
	else
		RangeHelpOption[RangeHelp_playerID]["lock back"] = 0;	
	end 
	
	if(BorderLock:GetChecked() == 1) then
		RangeHelpOption[RangeHelp_playerID]["lock border"] = 1;	
	else
		RangeHelpOption[RangeHelp_playerID]["lock border"] = 0;
	end
	
	if(FontLock:GetChecked() == 1) then
		RangeHelpOption[RangeHelp_playerID]["lock font"] = 1;
	else
		RangeHelpOption[RangeHelp_playerID]["lock font"] = 0;	
	end
	
	if(BGBorLink:GetChecked() == 1) then
		RangeHelpOption[RangeHelp_playerID]["link backbg"] = 1;
	else
		RangeHelpOption[RangeHelp_playerID]["link backbg"] = 0;
	end
	
	CopyTable(TempColor["melee ui"], RangeHelpOption[RangeHelp_playerID]["melee ui"]);
	CopyTable(TempColor["dead ui"], RangeHelpOption[RangeHelp_playerID]["dead ui"]);
	CopyTable(TempColor["range ui"], RangeHelpOption[RangeHelp_playerID]["range ui"]);
	CopyTable(TempColor["oorange ui"], RangeHelpOption[RangeHelp_playerID]["oorange ui"]);
	
	if(RangeHelpOption[RangeHelp_playerID]["lock back"] == 0 and RangeHelpOption[RangeHelp_playerID]["link backbg"] == 1) then
		CopyTable(TempColor["melee ui"].BGColor, RangeHelpOption[RangeHelp_playerID]["melee ui"].BorColor);
		CopyTable(TempColor["dead ui"].BGColor, RangeHelpOption[RangeHelp_playerID]["dead ui"].BorColor);
		CopyTable(TempColor["range ui"].BGColor, RangeHelpOption[RangeHelp_playerID]["range ui"].BorColor);
		CopyTable(TempColor["oorange ui"].BGColor, RangeHelpOption[RangeHelp_playerID]["oorange ui"].BorColor);
	end
	if(RangeHelpOption[RangeHelp_playerID]["lock back"] == 1) then
		CopyTable(TempColor["all"].BGColor, RangeHelpOption[RangeHelp_playerID]["melee ui"].BGColor);
		CopyTable(TempColor["all"].BGColor, RangeHelpOption[RangeHelp_playerID]["dead ui"].BGColor);
		CopyTable(TempColor["all"].BGColor, RangeHelpOption[RangeHelp_playerID]["range ui"].BGColor);
		CopyTable(TempColor["all"].BGColor, RangeHelpOption[RangeHelp_playerID]["oorange ui"].BGColor);
	end
	if(RangeHelpOption[RangeHelp_playerID]["lock back"] == 1 and RangeHelpOption[RangeHelp_playerID]["link backbg"] == 1) then
		CopyTable(TempColor["all"].BGColor, RangeHelpOption[RangeHelp_playerID]["melee ui"].BorColor);
		CopyTable(TempColor["all"].BGColor, RangeHelpOption[RangeHelp_playerID]["dead ui"].BorColor);
		CopyTable(TempColor["all"].BGColor, RangeHelpOption[RangeHelp_playerID]["range ui"].BorColor);
		CopyTable(TempColor["all"].BGColor, RangeHelpOption[RangeHelp_playerID]["oorange ui"].BorColor);
	end
	if(RangeHelpOption[RangeHelp_playerID]["lock border"] == 1) then
		CopyTable(TempColor["all"].BorColor, RangeHelpOption[RangeHelp_playerID]["melee ui"].BorColor);
		CopyTable(TempColor["all"].BorColor, RangeHelpOption[RangeHelp_playerID]["dead ui"].BorColor);
		CopyTable(TempColor["all"].BorColor, RangeHelpOption[RangeHelp_playerID]["range ui"].BorColor);
		CopyTable(TempColor["all"].BorColor, RangeHelpOption[RangeHelp_playerID]["oorange ui"].BorColor);	
	end
	if(RangeHelpOption[RangeHelp_playerID]["lock font"] == 1) then
		CopyTable(TempColor["all"].FontColor, RangeHelpOption[RangeHelp_playerID]["melee ui"].FontColor);
		CopyTable(TempColor["all"].FontColor, RangeHelpOption[RangeHelp_playerID]["dead ui"].FontColor);
		CopyTable(TempColor["all"].FontColor, RangeHelpOption[RangeHelp_playerID]["range ui"].FontColor);
		CopyTable(TempColor["all"].FontColor, RangeHelpOption[RangeHelp_playerID]["oorange ui"].FontColor);	
	end
	RangeHelpSetUI();
end

function RangeHelpUIOption_ConfirmBut()
	RangeHelpUIOption_ApplyBut();
	RangeHelpUIOption_CancelBut();
end

function RangeHelpUIOption_CancelBut()
	HideUIPanel(RangeHelpUISetup);
	HideUIPanel(RangeHelpColorPicker);
	RangeHelp_UISetup = 0;
	--TargetRangeInfo:SetPoint("BOTTOM", "UIParent", "TOP", 0, -oldRangeInfoPos.y);
	--DEFAULT_CHAT_FRAME:AddMessage("coord x:"..oldRangeInfoPos.x.." coord y:"..oldRangeInfoPos.y);
end

function RangeHelpUIOption_DefaultBut()
	BGLock:SetChecked(0);
	BorderLock:SetChecked(0);
	FontLock:SetChecked(1);
	BGBorLink:SetChecked(1);
	TempColor["melee ui"] = { BGColor={r=0.0,g=1.0,b=0.0,alpha=0.7},
								 BorColor={r=0.0,g=1.0,b=0.0,alpha=0.7},
								 FontColor={r=1.0,g=1.0,b=1.0},
								 Text="Melee" };
	TempColor["range ui"] = { BGColor={r=0.0,g=0.0,b=1.0,alpha=0.7},
								 BorColor={r=0.0,g=0.0,b=1.0,alpha=0.7},
								 FontColor={r=1.0,g=1.0,b=1.0},
								 Text="Range" };
	TempColor["dead ui"] = { BGColor={r=1.0,g=0.5,b=0.0,alpha=0.7},
								 BorColor={r=1.0,g=0.5,b=0.0,alpha=0.7},
								 FontColor={r=1.0,g=1.0,b=1.0},
								 Text="Dead Zone" };										 
	TempColor["oorange ui"] = { BGColor={r=1.0,g=0.0,b=0.0,alpha=0.7},
								 BorColor={r=1.0,g=0.0,b=0.0,alpha=0.7},
								 FontColor={r=1.0,g=1.0,b=1.0},
								 Text="Out of Range" };	
	FontHeight:SetValue(1.0);
	
	BGColorSel:Disable();
	BorColorSel:Disable();
	FontColorSel:Disable();
	UIDropDownMenu_ClearAll(RangeDropDown);	
	colIndex = "";
	RangeHelp_UISetup = 1;	
	TargetRangeInfo:Show();
	TargetRange:SetText("UI Customise");
	TargetRange:SetTextColor(1,1,1);
	TargetRangeInfo:SetBackdropColor(1, 1, 1, 1);
	TargetRangeInfo:SetBackdropBorderColor(1, 1, 1, 1);
	StateText:SetText("");
end

function RangeHelpUIOption_ResetFrameLocBut()
	TargetRangeInfo:ClearAllPoints();
	TargetRangeInfo:SetPoint("TOP", "UIParent", "TOP", 0, -20);
end

---- Color select functions
function RangeHelpUIOption_ColorOkay()
	TempColor[colIndex][colorModState].r, 
		TempColor[colIndex][colorModState].g, 
		TempColor[colIndex][colorModState].b = RangeHelpColorPicker:GetColorRGB();
	if(colorModState ~= "FontColor") then
		TempColor[colIndex][colorModState].alpha = RangeHelpOpacitySlider:GetValue(); 
	end
end

function RangeHelpUIOption_ColorCancel()
	RangeHelpUIOption_ColorSetup();
end

function RangeHelpUIOption_ColorOpacityChange()
	r, g, b = RangeHelpColorPicker:GetColorRGB();
	if(colorModState == "BGColor") then
		TargetRangeInfo:SetBackdropColor(r,g,b, RangeHelpOpacitySlider:GetValue());
		if(BGBorLink:GetChecked() == 1) then
			TargetRangeInfo:SetBackdropBorderColor(r,g,b, RangeHelpOpacitySlider:GetValue());		
		end
	elseif(colorModState == "BorColor") then
		TargetRangeInfo:SetBackdropBorderColor(r,g,b, RangeHelpOpacitySlider:GetValue());
	end
end

function RangeHelpUIOption_ColorSelect()
	r, g, b = RangeHelpColorPicker:GetColorRGB();
	if(colorModState == "BGColor") then
		TargetRangeInfo:SetBackdropColor(r,g,b, RangeHelpOpacitySlider:GetValue());
		if(BGBorLink:GetChecked() == 1) then
			TargetRangeInfo:SetBackdropBorderColor(r,g,b, RangeHelpOpacitySlider:GetValue());		
		end
	elseif(colorModState == "BorColor") then
		TargetRangeInfo:SetBackdropBorderColor(r,g,b, RangeHelpOpacitySlider:GetValue());
	elseif(colorModState == "FontColor") then
		TargetRange:SetTextColor(r,g,b);
	end
end

---- RangeHelp Key Binding Spell Setup
local TempSpells = { };

local PickupSpellOverride = PickupSpell;
local SpellType = {};

function PickupSpell(spellID, bookType) 
	PickupSpellOverride(spellID, bookType);
	SpellType.Type = "Spell";
	SpellType.SpellID = spellID;
	SpellType.BookType = bookType;
	SpellType.Texture = GetSpellTexture(spellID, bookType);
	SpellType.Name = GetSpellName(spellID, bookType);
end

local PickupMacroOverride = PickupMacro;

function PickupMacro(index)
	PickupMacroOverride(index);
	SpellType.Type = "Macro";
	SpellType.Name, SpellType.Texture = GetMacroInfo(index);
	SpellType.MacroID = index;
end

local PickupActionOverride = PickupAction;

function PickupAction(slot)
	PickupActionOverride(slot);
	SpellType = {};
end

local PickupContainerItemOverride = PickupContainerItem;

function PickupContainerItem(bagID, slot) 
	PickupContainerItemOverride(bagID, slot);
	SpellType = {};
end

local PickupInventoryItemOverride = PickupInventoryItem;

function PickupInventoryItem(slot) 
	PickupInventoryItemOverride(slot);
	SpellType = {};
end 

local PickupPetActionOverride = PickupPetAction;

function PickupPetAction(index) 
	PickupPetActionOverride(index);
	SpellType = {};
end

function RHKeySpellOption_OnLoad()
	UIDropDownMenu_SetWidth(220, RHKeySpellDropDown);
	RHKeySpellDDText:SetText(RHKEYSPELL_SELTEXT);
	RHKeySpellOORText:SetText(RHUISETUP_OUTOFRANGE);
	RHKeySpellRangeText:SetText(RHUISETUP_RANGE);
	RHKeySpellDZText:SetText(RHUISETUP_DEADZONE);
	RHKeySpellMeleeText:SetText(RHUISETUP_MELEE);
	RHKeySpellNoTargText:SetText(RHUISETUP_NOTARG);
	
	RHKeySpellOptionApply:SetText(RHOPTION_XML_APPLY);
	RHKeySpellOptionConfirm:SetText(RHOPTION_XML_CONFIRM);
	RHKeySpellOptionCancel:SetText(RHOPTION_XML_CANCEL);
	
	RHKeySpellVersionText:SetText("RangeHelp v"..RangeHelp_curVer);
	this:RegisterEvent("VARIABLES_LOADED");
end

function RHKeySpellOption_OnEvent(event)
	if(event == "VARIABLES_LOADED") then
		if(not RangeHelpSpellSetup) then
			RangeHelpSpellSetup = {};
		end
		RangeHelpSpellSetup["Version"] = RangeHelp_curVer;
		if(not RangeHelpSpellSetup[RangeHelp_playerID]) then
			RangeHelpSpellSetup[RangeHelp_playerID] = {};
		end
		RangeHelp_SetupKeyBinding();
	end
end

function RHKeySpellOption_OnShow()
	UIDropDownMenu_ClearAll(RHKeySpellDropDown);	
	TempSpells = {};
	CopyTable(RangeHelpSpellSetup[RangeHelp_playerID], TempSpells);
	RHKeySpellOORButtIcon:SetTexture("");
	RHKeySpellRangeButtIcon:SetTexture("");
	RHKeySpellDZButtIcon:SetTexture("");
	RHKeySpellMeleeButtIcon:SetTexture("");
	RHKeySpellNoTargButtIcon:SetTexture("");
	RHKeySpellOORButt:Disable();
	RHKeySpellRangeButt:Disable();
	RHKeySpellDZButt:Disable();
	RHKeySpellMeleeButt:Disable();
	RHKeySpellNoTargButt:Disable();
	RHKeySpellOORCheck:Disable();
	RHKeySpellOORCheck:SetChecked(0);
	RHKeySpellRangeCheck:Disable();
	RHKeySpellRangeCheck:SetChecked(0);
	RHKeySpellDZCheck:Disable();
	RHKeySpellDZCheck:SetChecked(0);
	RHKeySpellMeleeCheck:Disable();
	RHKeySpellMeleeCheck:SetChecked(0);
	RHKeySpellNoTargCheck:Disable();
	RHKeySpellNoTargCheck:SetChecked(0);
end

function RHKeySpellDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, RHKeySpellDropDown_Initialize);
end

function RHKeySpellDropDown_Initialize()
	local info = {};
	local name;
	local i;
	local key1, key2;
	for i=1,4 do
		name = "RHSPELLKEY"..i;
		key1, key2 = GetBindingKey(name);
		if(key1 or key2) then
			info.text = getglobal("BINDING_NAME_"..name)..": ";
			if(key1) then
				info.text = info.text.."'"..key1.."' ";
			end
			if(key2) then
				info.text = info.text.."'"..key2.."' ";
			end
			info.value = name;
			info.func = RHKeySpellDropDown_OnClick;
			UIDropDownMenu_AddButton(info);
			if(TempSpells[name] == nil) then
				TempSpells[name] = {};
			end
		end	
	end
end

function RHKeySpellDropDown_OnClick()
	UIDropDownMenu_SetSelectedValue(RHKeySpellDropDown, this.value);
	if(this.value) then
		RHKeySpell_UpdateButtonTexutre();
		RHKeySpellOORCheck:Enable();
		RHKeySpellOORCheck:SetChecked(0);
		RHKeySpellRangeCheck:Enable();
		RHKeySpellRangeCheck:SetChecked(0);
		RHKeySpellDZCheck:Enable();
		RHKeySpellDZCheck:SetChecked(0);
		RHKeySpellMeleeCheck:Enable();
		RHKeySpellMeleeCheck:SetChecked(0);
		RHKeySpellNoTargCheck:Enable();
		RHKeySpellNoTargCheck:SetChecked(0);
		RHKeySpellOORButt:Enable();
		RHKeySpellRangeButt:Enable();
		RHKeySpellDZButt:Enable();
		RHKeySpellMeleeButt:Enable();		
		RHKeySpellNoTargButt:Enable();		
		
		if(TempSpells[RHKeySpellDropDown.selectedValue]["oorange ui"]) then
			RHKeySpellOORCheck:SetChecked(TempSpells[RHKeySpellDropDown.selectedValue]["oorange ui"].Check);
		end
		if(TempSpells[RHKeySpellDropDown.selectedValue]["range ui"]) then
			RHKeySpellRangeCheck:SetChecked(TempSpells[RHKeySpellDropDown.selectedValue]["range ui"].Check);
		end
		if(TempSpells[RHKeySpellDropDown.selectedValue]["dead ui"]) then
			RHKeySpellDZCheck:SetChecked(TempSpells[RHKeySpellDropDown.selectedValue]["dead ui"].Check);
		end
		if(TempSpells[RHKeySpellDropDown.selectedValue]["melee ui"]) then
			RHKeySpellMeleeCheck:SetChecked(TempSpells[RHKeySpellDropDown.selectedValue]["melee ui"].Check);
		end	
		if(TempSpells[RHKeySpellDropDown.selectedValue]["notarg ui"]) then
			RHKeySpellNoTargCheck:SetChecked(TempSpells[RHKeySpellDropDown.selectedValue]["notarg ui"].Check);
		end	
	end
end

function RHKeySpell_UpdateButtonTexutre()
	if(TempSpells[RHKeySpellDropDown.selectedValue]["oorange ui"]) then
		RHKeySpellOORButtIcon:SetTexture(TempSpells[RHKeySpellDropDown.selectedValue]["oorange ui"].Texture);
	else
		RHKeySpellOORButtIcon:SetTexture("");
	end
	if(TempSpells[RHKeySpellDropDown.selectedValue]["range ui"]) then		
		RHKeySpellRangeButtIcon:SetTexture(TempSpells[RHKeySpellDropDown.selectedValue]["range ui"].Texture);
	else
		RHKeySpellRangeButtIcon:SetTexture("");
	end
	if(TempSpells[RHKeySpellDropDown.selectedValue]["dead ui"]) then	
		RHKeySpellDZButtIcon:SetTexture(TempSpells[RHKeySpellDropDown.selectedValue]["dead ui"].Texture);
	else
		RHKeySpellDZButtIcon:SetTexture("");
	end
	if(TempSpells[RHKeySpellDropDown.selectedValue]["melee ui"]) then		
		RHKeySpellMeleeButtIcon:SetTexture(TempSpells[RHKeySpellDropDown.selectedValue]["melee ui"].Texture);
	else
		RHKeySpellMeleeButtIcon:SetTexture("");
	end
	if(TempSpells[RHKeySpellDropDown.selectedValue]["notarg ui"]) then		
		RHKeySpellNoTargButtIcon:SetTexture(TempSpells[RHKeySpellDropDown.selectedValue]["notarg ui"].Texture);
	else
		RHKeySpellNoTargButtIcon:SetTexture("");
	end
end

function RHKeySpellButt_OnEnter(state)
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	if(TempSpells[RHKeySpellDropDown.selectedValue]) then
		if(TempSpells[RHKeySpellDropDown.selectedValue][state]) then
			if(TempSpells[RHKeySpellDropDown.selectedValue][state].Type == "Spell") then
				GameTooltip:SetSpell(TempSpells[RHKeySpellDropDown.selectedValue][state].SpellID, TempSpells[RHKeySpellDropDown.selectedValue][state].BookType);
			elseif(TempSpells[RHKeySpellDropDown.selectedValue][state].Type == "Macro") then
				GameTooltip:SetText(TempSpells[RHKeySpellDropDown.selectedValue][state].Name);
			end
		else
			GameTooltip:SetText(RHKEYSPELL_DRAGINSTR, 1, 1, 1, 1, 1);
		end
	else
		GameTooltip:SetText(RHKEYSPELL_DRAGINSTR, 1, 1, 1, 1, 1);
	end
end

function RHKeySpellButt_OnReceiveDrag(state)
	if(TempSpells[RHKeySpellDropDown.selectedValue]) then
		if(SpellType.Type) then
			TempSpells[RHKeySpellDropDown.selectedValue][state] = {};
			CopyTable(SpellType, TempSpells[RHKeySpellDropDown.selectedValue][state]);
			getglobal(this:GetName().."Icon"):SetTexture(SpellType.Texture);
			getglobal(gsub(this:GetName(),"Butt","Check")):SetChecked(0);
			PutItemInBackpack();
		end
	end
end

function RHKeySpellButt_OnDragStart(state)
	if(TempSpells[RHKeySpellDropDown.selectedValue]) then
		if(TempSpells[RHKeySpellDropDown.selectedValue][state]) then
			if(TempSpells[RHKeySpellDropDown.selectedValue][state].Type == "Spell") then
				PickupSpell(TempSpells[RHKeySpellDropDown.selectedValue][state].SpellID, TempSpells[RHKeySpellDropDown.selectedValue][state].BookType);
				TempSpells[RHKeySpellDropDown.selectedValue][state] = nil;
				getglobal(gsub(this:GetName(),"Butt","Check")):SetChecked(0);
				RHKeySpell_UpdateButtonTexutre();
			elseif(TempSpells[RHKeySpellDropDown.selectedValue][state].Type == "Macro") then
				PickupMacro(TempSpells[RHKeySpellDropDown.selectedValue][state].MacroID);
				TempSpells[RHKeySpellDropDown.selectedValue][state] = nil;
				getglobal(gsub(this:GetName(),"Butt","Check")):SetChecked(0);
				RHKeySpell_UpdateButtonTexutre()
			end
		end
	end
end

function RHKeySpellButt_OnCheckClick(state)
	if(TempSpells[RHKeySpellDropDown.selectedValue]) then
		if(TempSpells[RHKeySpellDropDown.selectedValue][state]) then
			if(this:GetChecked() == 1) then
				TempSpells[RHKeySpellDropDown.selectedValue][state].Check = 1;
			else
				TempSpells[RHKeySpellDropDown.selectedValue][state].Check = 0;
			end
		else
			this:SetChecked(0);
		end
	end
end

function RHKeySpellOption_ApplyBut()
	CopyTable(TempSpells, RangeHelpSpellSetup[RangeHelp_playerID]);
	RangeHelp_SetupKeyBinding();
end

function RHKeySpellUIOption_ConfirmBut()
	RHKeySpellOption_ApplyBut();
	HideUIPanel(RangeHelpKeySpellSetup);
end

function RHKeySpellUIOption_CancelBut()
	HideUIPanel(RangeHelpKeySpellSetup);
end