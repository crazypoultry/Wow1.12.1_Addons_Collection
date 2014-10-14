wd_cc_type, wd_cc_class = nil,nil

function WatchDogOptions_OnLoad()

	WD_Old_TargetFrame_Update = TargetFrame_Update;
	TargetFrame_Update = WD_New_TargetFrame_Update;
	
	WD_Old_SpellClick = SpellButton_OnClick;
	SpellButton_OnClick = WD_New_SpellClick;
	
	wd_cc_type, wd_cc_class = WatchDogOptions_ClickCastings_Friendly, WatchDogOptions_ClickCastings_Global
	
	wd_cc_type:LockHighlight()
	wd_cc_class:LockHighlight()
		
	WatchDogOptions_EnableText:SetText("Enable WatchDog");
	WatchDogOptions_ShowPlayerText:SetText("Show player");
	WatchDogOptions_ShowTargetText:SetText("Show target");
	WatchDogOptions_ShowPetText:SetText("Show pets");
	WatchDogOptions_ShowPartyText:SetText("Show party");
	WatchDogOptions_ShowTooltipText:SetText("Show tooltips");		
	
	WatchDogOptions_ShowBordersText:SetText("Show borders");
	WatchDogOptions_ChooseRankText:SetText("SmartBuffs");
	WatchDogOptions_TOFTText:SetText("Target of Target");
	WatchDogOptions_LockFramesText:SetText("Lock Frames");	
	WatchDogOptions_PartyPetsText:SetText("Show party pets");
	
	WatchDogOptions_ShowBuffsText:SetText("Show");
	WatchDogOptions_FilterBuffsText:SetText("Filter")
	WatchDogOptions_LeftBuffsText:SetText("Left")
	WatchDogOptions_RightBuffsText:SetText("Right")
	WatchDogOptions_BottomBuffsText:SetText("Bottom")
	
	WatchDogOptions_ShowDebuffsText:SetText("Show");
	WatchDogOptions_FilterDebuffsText:SetText("Filter")
	WatchDogOptions_LeftDebuffsText:SetText("Left")
	WatchDogOptions_RightDebuffsText:SetText("Right")
	WatchDogOptions_BottomDebuffsText:SetText("Bottom")
	
	WatchDogOptions_CalculateHPText:SetText("Calculate Hostile HP");
	
	WatchDogOptions_DynamicWidthText:SetText("Dynamic");
	WatchDogOptions_FixedWidthText:SetText("Fixed:");
	
	WatchDogOptions_ShowHPBarText:SetText("Show");
	WatchDogOptions_ReverseHPText:SetText("Reverse");
	WatchDogOptions_HPShadeText:SetText("Gradient");
	
	WatchDogOptions_ReverseMPText:SetText("Reverse");
	WatchDogOptions_ShowMPBarText:SetText("Show");	
	
	WatchDogOptions_DefaultPlayerText:SetText("Default Player");
	WatchDogOptions_DefaultTargetText:SetText("Default Target");
	WatchDogOptions_DefaultPartyText:SetText("Default Party");
	WatchDogOptions_DefaultBuffsText:SetText("Default Buffs");
	WatchDogOptions_DefaultGryphonsText:SetText("Default Gryphons");
	WatchDogOptions_RetainTargetText:SetText("Smart Targeting");
	WatchDogOptions_3DBarsText:SetText("3-D Bars");

	WatchDogOptions_IntegrateCTRAText:SetText("Click-Cast with CTRaidAssist");
	WatchDogOptions_IntegrateBlizzRaidText:SetText("Click-Cast with Blizzard Raid");
	
	WatchDogOptions_CalculateHPSliderText:SetText("Precision");
	WatchDogOptions_CalculateHPSliderLow:SetText("10");
	WatchDogOptions_CalculateHPSliderHigh:SetText("100");
	WatchDogOptions_CalculateHPSlider:SetMinMaxValues(10,100);
	WatchDogOptions_CalculateHPSlider:SetValueStep(5);
	
	WatchDogOptions_SetScaleText:SetText("Scale");
	WatchDogOptions_SetScaleLow:SetText("0.5");
	WatchDogOptions_SetScaleHigh:SetText("2.0");
	WatchDogOptions_SetScale:SetMinMaxValues(0.5,2.0);
	WatchDogOptions_SetScale:SetValueStep(0.05);	
	
	WatchDogOptions_HPHeightText:SetText("Height");
	WatchDogOptions_HPHeightLow:SetText("1")
	WatchDogOptions_HPHeightHigh:SetText("24")
	WatchDogOptions_HPHeight:SetMinMaxValues(1,24)
	WatchDogOptions_HPHeight:SetValueStep(1)
	
	WatchDogOptions_FixedWidthAmount_Description:SetText("");	
	WatchDogOptions_TargetFormat1_Description:SetText("Target Format 1");
	WatchDogOptions_TargetFormat2_Description:SetText("Target Format 2");
	WatchDogOptions_PlayerFormat1_Description:SetText("Player Format 1");
	WatchDogOptions_PlayerFormat2_Description:SetText("Player Format 2");
	WatchDogOptions_PartyFormat1_Description:SetText("Party Format 1");
	WatchDogOptions_PartyFormat2_Description:SetText("Party Format 2");
	WatchDogOptions_PetFormat1_Description:SetText("Pets Format 1");
	WatchDogOptions_PetFormat2_Description:SetText("Pets Format 2");
	
	WatchDogOptions_ClickCastings_LeftButton_Description:SetText("LeftButton");
	WatchDogOptions_ClickCastings_LeftButtonAlt_Description:SetText("LeftButton + Alt");
	WatchDogOptions_ClickCastings_LeftButtonShift_Description:SetText("LeftButton + Shift");
	WatchDogOptions_ClickCastings_LeftButtonControl_Description:SetText("LeftButton + Control");
	
	WatchDogOptions_ClickCastings_MiddleButton_Description:SetText("MiddleButton");
	WatchDogOptions_ClickCastings_MiddleButtonAlt_Description:SetText("MiddleButton + Alt");
	WatchDogOptions_ClickCastings_MiddleButtonShift_Description:SetText("MiddleButton + Shift");
	WatchDogOptions_ClickCastings_MiddleButtonControl_Description:SetText("MiddleButton + Control");
	
	WatchDogOptions_ClickCastings_RightButton_Description:SetText("RightButton");
	WatchDogOptions_ClickCastings_RightButtonAlt_Description:SetText("RightButton + Alt");
	WatchDogOptions_ClickCastings_RightButtonShift_Description:SetText("RightButton + Shift");
	WatchDogOptions_ClickCastings_RightButtonControl_Description:SetText("RightButton + Control");
	
	WatchDogOptions_ClickCastings_Button4_Description:SetText("Button4");
	WatchDogOptions_ClickCastings_Button4Alt_Description:SetText("Button4 + Alt");
	WatchDogOptions_ClickCastings_Button4Shift_Description:SetText("Button4 + Shift");
	WatchDogOptions_ClickCastings_Button4Control_Description:SetText("Button4 + Control");
	
	WatchDogOptions_ClickCastings_Button5_Description:SetText("Button5");
	WatchDogOptions_ClickCastings_Button5Alt_Description:SetText("Button5 + Alt");
	WatchDogOptions_ClickCastings_Button5Shift_Description:SetText("Button5 + Shift");
	WatchDogOptions_ClickCastings_Button5Control_Description:SetText("Button5 + Control");
		
end

function WatchDogOptions_ResetFrames()
	WatchDogFrame_target:ClearAllPoints() WatchDogFrame_target:SetPoint("TOPLEFT","WatchDogFrame","TOPLEFT",0,0)
	WatchDogFrame_targettarget:ClearAllPoints() WatchDogFrame_targettarget:SetPoint("TOPLEFT","WatchDogFrame","TOPLEFT",250,0)
	WatchDogFrame_player:ClearAllPoints() WatchDogFrame_player:SetPoint("TOPLEFT","WatchDogFrame","TOPLEFT",0,-33)
	WatchDogFrame_pet:ClearAllPoints() WatchDogFrame_pet:SetPoint("TOPLEFT","WatchDogFrame","TOPLEFT",250,-33)
	WatchDogFrame_partypet1:ClearAllPoints() WatchDogFrame_partypet1:SetPoint("TOPLEFT","WatchDogFrame","TOPLEFT",250,-64)
	WatchDogFrame_partypet2:ClearAllPoints() WatchDogFrame_partypet2:SetPoint("TOPLEFT","WatchDogFrame","TOPLEFT",250,-95)
	WatchDogFrame_partypet3:ClearAllPoints() WatchDogFrame_partypet3:SetPoint("TOPLEFT","WatchDogFrame","TOPLEFT",250,-126)
	WatchDogFrame_partypet4:ClearAllPoints() WatchDogFrame_partypet4:SetPoint("TOPLEFT","WatchDogFrame","TOPLEFT",250,-157)
	WatchDogFrame_party1:ClearAllPoints() WatchDogFrame_party1:SetPoint("TOPLEFT","WatchDogFrame","TOPLEFT",0,-64)
	WatchDogFrame_party2:ClearAllPoints() WatchDogFrame_party2:SetPoint("TOPLEFT","WatchDogFrame","TOPLEFT",0,-95)
	WatchDogFrame_party3:ClearAllPoints() WatchDogFrame_party3:SetPoint("TOPLEFT","WatchDogFrame","TOPLEFT",0,-126)
	WatchDogFrame_party4:ClearAllPoints() WatchDogFrame_party4:SetPoint("TOPLEFT","WatchDogFrame","TOPLEFT",0,-157)
	WatchDogFrame:ClearAllPoints() WatchDogFrame:SetPoint("TOPLEFT","UIParent","CENTER",0,0)
	WatchDog_SaveFramePositions()
	WatchDog_AnchorAll()
end

function WatchDogOptions_ShowColorSelect()						
	ColorPickerFrame.func = function () 
		WatchDog.colorback.r,WatchDog.colorback.g,WatchDog.colorback.b=ColorPickerFrame:GetColorRGB()
		for k,v in wd_visible do
			getglobal("WatchDogFrame_"..k):SetBackdropColor(WatchDog.colorback.r,WatchDog.colorback.g,WatchDog.colorback.b,WatchDog.colorback.a)
		end
	end
	ColorPickerFrame.hasOpacity = true;
	ColorPickerFrame.opacityFunc = function () 
		WatchDog.colorback.a = 1.0 - OpacitySliderFrame:GetValue()
		for k,v in wd_visible do
			getglobal("WatchDogFrame_"..k):SetBackdropColor(WatchDog.colorback.r,WatchDog.colorback.g,WatchDog.colorback.b,WatchDog.colorback.a)
		end
	end
	ColorPickerFrame.opacity = 1.0 - WatchDog.colorback.a
	ColorPickerFrame:SetColorRGB(WatchDog.colorback.r, WatchDog.colorback.g, WatchDog.colorback.b);
	ColorPickerFrame.previousValues = {r = WatchDog.colorback.r, g = WatchDog.colorback.g, b = WatchDog.colorback.b, opacity = WatchDog.colorback.a};
	ColorPickerFrame.cancelFunc = function (t) if (t.r) then WatchDog.colorback.r=t.r WatchDog.colorback.g=t.g WatchDog.colorback.b=t.b end end
	ShowUIPanel(ColorPickerFrame);
end

function WatchDogOptions_LoadSpell()
	if string.find(wd_subSpellName,"Rank") then
		this:SetText(wd_spellName.."("..wd_subSpellName..")");
	else
		this:SetText(wd_spellName)
	end
	this:ClearFocus()
	wd_spellName, wd_subSpellName = nil, nil
	PickupSpell(MAX_SPELLS,1) 
end

function WD_New_TargetFrame_Update()
	if WatchDog.defaulttarget then
		WD_Old_TargetFrame_Update();
	end		
end

function WD_New_SpellClick(drag)
	WD_Old_SpellClick(drag);
	if (drag) then	
		wd_spellName, wd_subSpellName = GetSpellName(SpellBook_GetSpellID(this:GetID()), SpellBookFrame.bookType);
	end	
end

function WatchDogOptions_ChangeClickCastings()
	WatchDogOptions_SaveClickCastings()
	
	if (this:GetID() > 10) then
		if wd_cc_type then wd_cc_type:UnlockHighlight() end
		wd_cc_type=this
	else
		if wd_cc_class then wd_cc_class:UnlockHighlight(); end
		wd_cc_class=this;
	end
	
	this:LockHighlight();	
	WatchDogOptions_LoadClickCastings();	
end

function WatchDogOptions_SaveClickCastings()
	local type = (wd_cc_type:GetText()== "Friendly") and "friendly_click" or "enemy_click"
	local class = string.upper(wd_cc_class:GetText())
	
	local config = WatchDog[class][type]	
	if not config then return; end
	
	config.LeftButton = ( strlen(WatchDogOptions_ClickCastings_LeftButton:GetText())>0 ) and WatchDogOptions_ClickCastings_LeftButton:GetText() or nil;
	config.LeftButtonAlt = ( strlen(WatchDogOptions_ClickCastings_LeftButtonAlt:GetText())>0 ) and WatchDogOptions_ClickCastings_LeftButtonAlt:GetText() or nil;
	config.LeftButtonShift = ( strlen(WatchDogOptions_ClickCastings_LeftButtonShift:GetText())>0 ) and WatchDogOptions_ClickCastings_LeftButtonShift:GetText() or nil;
	config.LeftButtonControl = ( strlen(WatchDogOptions_ClickCastings_LeftButtonControl:GetText())>0 ) and WatchDogOptions_ClickCastings_LeftButtonControl:GetText() or nil;

	config.MiddleButton = ( strlen(WatchDogOptions_ClickCastings_MiddleButton:GetText())>0 ) and WatchDogOptions_ClickCastings_MiddleButton:GetText() or nil;
	config.MiddleButtonAlt = ( strlen(WatchDogOptions_ClickCastings_MiddleButtonAlt:GetText())>0 ) and WatchDogOptions_ClickCastings_MiddleButtonAlt:GetText() or nil;
	config.MiddleButtonShift = ( strlen(WatchDogOptions_ClickCastings_MiddleButtonShift:GetText())>0 ) and WatchDogOptions_ClickCastings_MiddleButtonShift:GetText() or nil;
	config.MiddleButtonControl = ( strlen(WatchDogOptions_ClickCastings_MiddleButtonControl:GetText())>0 ) and WatchDogOptions_ClickCastings_MiddleButtonControl:GetText() or nil;

	config.RightButton = ( strlen(WatchDogOptions_ClickCastings_RightButton:GetText())>0 ) and WatchDogOptions_ClickCastings_RightButton:GetText() or nil;
	config.RightButtonAlt = ( strlen(WatchDogOptions_ClickCastings_RightButtonAlt:GetText())>0 ) and WatchDogOptions_ClickCastings_RightButtonAlt:GetText() or nil;
	config.RightButtonShift = ( strlen(WatchDogOptions_ClickCastings_RightButtonShift:GetText())>0 ) and WatchDogOptions_ClickCastings_RightButtonShift:GetText() or nil;
	config.RightButtonControl = ( strlen(WatchDogOptions_ClickCastings_RightButtonControl:GetText())>0 ) and WatchDogOptions_ClickCastings_RightButtonControl:GetText() or nil;

	config.Button4 = ( strlen(WatchDogOptions_ClickCastings_Button4:GetText())>0 ) and WatchDogOptions_ClickCastings_Button4:GetText() or nil;
	config.Button4Alt = ( strlen(WatchDogOptions_ClickCastings_Button4Alt:GetText())>0 ) and WatchDogOptions_ClickCastings_Button4Alt:GetText() or nil;
	config.Button4Shift = ( strlen(WatchDogOptions_ClickCastings_Button4Shift:GetText())>0 ) and WatchDogOptions_ClickCastings_Button4Shift:GetText() or nil;
	config.Button4Control = ( strlen(WatchDogOptions_ClickCastings_Button4Control:GetText())>0 ) and WatchDogOptions_ClickCastings_Button4Control:GetText() or nil;

	config.Button5 = ( strlen(WatchDogOptions_ClickCastings_Button5:GetText())>0 ) and WatchDogOptions_ClickCastings_Button5:GetText() or nil;
	config.Button5Alt = ( strlen(WatchDogOptions_ClickCastings_Button5Alt:GetText())>0 ) and WatchDogOptions_ClickCastings_Button5Alt:GetText() or nil;
	config.Button5Shift = ( strlen(WatchDogOptions_ClickCastings_Button5Shift:GetText())>0 ) and WatchDogOptions_ClickCastings_Button5Shift:GetText() or nil;
	config.Button5Control = ( strlen(WatchDogOptions_ClickCastings_Button5Control:GetText())>0 ) and WatchDogOptions_ClickCastings_Button5Control:GetText() or nil;

end

function WatchDogOptions_LoadClickCastings()
	local type = (wd_cc_type:GetText()== "Friendly") and "friendly_click" or "enemy_click"
	local class = string.upper(wd_cc_class:GetText())
	
	local config = WatchDog[class][type]
	if not config then return; end
	
	WatchDogOptions_ClickCastings_LeftButton:SetText( config.LeftButton or "" )
	WatchDogOptions_ClickCastings_LeftButtonAlt:SetText( config.LeftButtonAlt or ""  )
	WatchDogOptions_ClickCastings_LeftButtonShift:SetText( config.LeftButtonShift or ""  )
	WatchDogOptions_ClickCastings_LeftButtonControl:SetText( config.LeftButtonControl or ""  )
	
	WatchDogOptions_ClickCastings_MiddleButton:SetText( config.MiddleButton or ""  )
	WatchDogOptions_ClickCastings_MiddleButtonAlt:SetText( config.MiddleButtonAlt or ""  )
	WatchDogOptions_ClickCastings_MiddleButtonShift:SetText( config.MiddleButtonShift or ""  )
	WatchDogOptions_ClickCastings_MiddleButtonControl:SetText( config.MiddleButtonControl or ""  )
	
	WatchDogOptions_ClickCastings_RightButton:SetText( config.RightButton or ""  )
	WatchDogOptions_ClickCastings_RightButtonAlt:SetText( config.RightButtonAlt or ""  )
	WatchDogOptions_ClickCastings_RightButtonShift:SetText( config.RightButtonShift or ""  )
	WatchDogOptions_ClickCastings_RightButtonControl:SetText( config.RightButtonControl or ""  )	

	WatchDogOptions_ClickCastings_Button4:SetText( config.Button4 or ""  )
	WatchDogOptions_ClickCastings_Button4Alt:SetText( config.Button4Alt or ""  )
	WatchDogOptions_ClickCastings_Button4Shift:SetText( config.Button4Shift or ""  )
	WatchDogOptions_ClickCastings_Button4Control:SetText( config.Button4Control or ""  )	

	WatchDogOptions_ClickCastings_Button5:SetText( config.Button5 or ""  )
	WatchDogOptions_ClickCastings_Button5Alt:SetText( config.Button5Alt or ""  )
	WatchDogOptions_ClickCastings_Button5Shift:SetText( config.Button5Shift or ""  )
	WatchDogOptions_ClickCastings_Button5Control:SetText( config.Button5Control or ""  )	
end



function WatchDogOptions_LoadValues()
	WatchDogOptions_Enable:SetChecked(WatchDog.visible);
	WatchDogOptions_ShowPlayer:SetChecked(WatchDog.player.visible);
	WatchDogOptions_ShowPet:SetChecked(WatchDog.pet.visible);
	WatchDogOptions_ShowTarget:SetChecked(WatchDog.target.visible);
	WatchDogOptions_ShowParty:SetChecked(WatchDog.party.visible);
	WatchDogOptions_ShowBuffs:SetChecked(WatchDog.buffs);
	WatchDogOptions_ShowDebuffs:SetChecked(WatchDog.debuffs);
	WatchDogOptions_ShowBorders:SetChecked(WatchDog.showborder);
	WatchDogOptions_ChooseRank:SetChecked(WatchDog.bestrank);
	WatchDogOptions_TOFT:SetChecked(WatchDog.toft);	
	WatchDogOptions_ShowTooltip:SetChecked(WatchDog.tooltips);
	WatchDogOptions_PartyPets:SetChecked(WatchDog.partypets);
	
	WatchDogOptions_CalculateHP:SetChecked(WatchDog.targethp);	
	WatchDogOptions_LockFrames:SetChecked(WatchDog.locked);
	WatchDogOptions_ShowHPBar:SetChecked(WatchDog.showhpbar);
	WatchDogOptions_ShowMPBar:SetChecked(WatchDog.showmpbar);
	WatchDogOptions_ReverseHP:SetChecked(WatchDog.hpreverse);
	WatchDogOptions_HPShade:SetChecked(WatchDog.hpsmooth);
	WatchDogOptions_ReverseMP:SetChecked(WatchDog.mpreverse);
	WatchDogOptions_FilterBuffs:SetChecked(WatchDog.filterbuffs);
	WatchDogOptions_FilterDebuffs:SetChecked(WatchDog.filterdebuffs);
	
	if WatchDog.dynamicwidth then
		WatchDogOptions_DynamicWidth:SetChecked(true)
	else
		WatchDogOptions_FixedWidth:SetChecked(true)
	end
	
	
	if WatchDog.buffsanchor=="RIGHT" then
		WatchDogOptions_RightBuffs:SetChecked(true)
	elseif WatchDog.buffsanchor=="LEFT" then
		WatchDogOptions_LeftBuffs:SetChecked(true)
	elseif WatchDog.buffsanchor=="BOTTOM" then	
		WatchDogOptions_BottomBuffs:SetChecked(true)
	end
	
	if WatchDog.debuffsanchor=="RIGHT" then
		WatchDogOptions_RightDebuffs:SetChecked(true)
	elseif WatchDog.debuffsanchor=="LEFT" then
		WatchDogOptions_LeftDebuffs:SetChecked(true)
	elseif WatchDog.debuffsanchor=="BOTTOM" then
		WatchDogOptions_BottomDebuffs:SetChecked(true)
	end
		
	WatchDogOptions_DefaultPlayer:SetChecked(WatchDog.defaultplayer);	
	WatchDogOptions_DefaultTarget:SetChecked(WatchDog.defaulttarget);	
	WatchDogOptions_DefaultParty:SetChecked(WatchDog.defaultparty);	
	WatchDogOptions_DefaultBuffs:SetChecked(WatchDog.defaultbuffs);
	WatchDogOptions_DefaultGryphons:SetChecked(WatchDog.defaultbirds);
	WatchDogOptions_3DBars:SetChecked(WatchDog.newbars);
	WatchDogOptions_RetainTarget:SetChecked(WatchDog.targetless);
	WatchDogOptions_IntegrateCTRA:SetChecked(WatchDog.ctraidassist);
	WatchDogOptions_IntegrateBlizzRaid:SetChecked(WatchDog.blizzraid);
	
	WatchDogOptions_CalculateHPSlider:SetValue(WatchDog.precision);
	WatchDogOptions_SetScale:SetValue(WatchDog.scale);
	WatchDogOptions_FixedWidthAmount:SetNumber(WatchDog.fixedwidth);
	WatchDogOptions_HPHeight:SetValue(WatchDog.hpheight);
	WatchDogOptions_TargetFormat1:SetText(WatchDog["target"].format1);
	WatchDogOptions_TargetFormat2:SetText(WatchDog["target"].format2);
	WatchDogOptions_PlayerFormat1:SetText(WatchDog["player"].format1);
	WatchDogOptions_PlayerFormat2:SetText(WatchDog["player"].format2);
	WatchDogOptions_PartyFormat1:SetText(WatchDog["party"].format1);
	WatchDogOptions_PartyFormat2:SetText(WatchDog["party"].format2);
	WatchDogOptions_PetFormat1:SetText(WatchDog["pet"].format1);
	WatchDogOptions_PetFormat2:SetText(WatchDog["pet"].format2);
	
	WatchDogOptions_Save:Show();
	WatchDogOptions_Cancel:Show();  
end

function getbool(arg1)
	if arg1 then return true; else return false; end;
end

function WatchDogOptions_SaveValues()

	if ( WatchDog.visible ~= getbool(WatchDogOptions_Enable:GetChecked()) ) then
		if (WatchDogOptions_Enable:GetChecked()) then 
			WatchDog_Show();
		else
			WatchDog_Hide();
		end
	end
	
	WatchDog.tooltips = getbool(WatchDogOptions_ShowTooltip:GetChecked())
	WatchDog.partypets = getbool(WatchDogOptions_PartyPets:GetChecked())
	
	WatchDog.visible = getbool(WatchDogOptions_Enable:GetChecked());
	WatchDog.player.visible = getbool(WatchDogOptions_ShowPlayer:GetChecked());
	WatchDog.pet.visible = getbool(WatchDogOptions_ShowPet:GetChecked());
	WatchDog.target.visible = getbool(WatchDogOptions_ShowTarget:GetChecked());
	WatchDog.party.visible = getbool(WatchDogOptions_ShowParty:GetChecked());
	WatchDog.buffs = getbool(WatchDogOptions_ShowBuffs:GetChecked());
	WatchDog.debuffs = getbool(WatchDogOptions_ShowDebuffs:GetChecked());
	WatchDog.showborder = getbool(WatchDogOptions_ShowBorders:GetChecked());
	WatchDog.toft = getbool(WatchDogOptions_TOFT:GetChecked());
	WatchDog.bestrank = getbool(WatchDogOptions_ChooseRank:GetChecked());
	WatchDog.showhpbar = getbool(WatchDogOptions_ShowHPBar:GetChecked());
	WatchDog.showmpbar = getbool(WatchDogOptions_ShowMPBar:GetChecked());
	WatchDog.targethp = getbool(WatchDogOptions_CalculateHP:GetChecked());
	WatchDog.locked = getbool(WatchDogOptions_LockFrames:GetChecked());
	WatchDog.precision = WatchDogOptions_CalculateHPSlider:GetValue();
	WatchDog.scale = WatchDogOptions_SetScale:GetValue();
	WatchDog.dynamicwidth = getbool(WatchDogOptions_DynamicWidth:GetChecked());
	WatchDog.fixedwidth = WatchDogOptions_FixedWidthAmount:GetNumber();
	WatchDog.hpheight = WatchDogOptions_HPHeight:GetValue();
	WatchDog.hpreverse = getbool(WatchDogOptions_ReverseHP:GetChecked());
	WatchDog.hpsmooth = getbool(WatchDogOptions_HPShade:GetChecked());
	WatchDog.mpreverse = getbool(WatchDogOptions_ReverseMP:GetChecked());
	WatchDog.filterbuffs = getbool(WatchDogOptions_FilterBuffs:GetChecked())
	WatchDog.filterdebuffs = getbool(WatchDogOptions_FilterDebuffs:GetChecked())
	
	WatchDog.defaultplayer = getbool(WatchDogOptions_DefaultPlayer:GetChecked());	
	WatchDog.defaulttarget = getbool(WatchDogOptions_DefaultTarget:GetChecked());	
	WatchDog.defaultparty = getbool(WatchDogOptions_DefaultParty:GetChecked());	
	WatchDog.defaultbuffs = getbool(WatchDogOptions_DefaultBuffs:GetChecked());
	WatchDog.defaultbirds = getbool(WatchDogOptions_DefaultGryphons:GetChecked());
	WatchDog.newbars = getbool(WatchDogOptions_3DBars:GetChecked());
	WatchDog.targetless = getbool(WatchDogOptions_RetainTarget:GetChecked());
	WatchDog.ctraidassist = getbool(WatchDogOptions_IntegrateCTRA:GetChecked());
	WatchDog.blizzraid = getbool(WatchDogOptions_IntegrateBlizzRaid:GetChecked());
	
	if WatchDogOptions_LeftBuffs:GetChecked() then
		WatchDog.buffsanchor = "LEFT"
	elseif WatchDogOptions_RightBuffs:GetChecked() then
		WatchDog.buffsanchor = "RIGHT"
	elseif WatchDogOptions_BottomBuffs:GetChecked() then
		WatchDog.buffsanchor = "BOTTOM"
	end
	
	if WatchDogOptions_LeftDebuffs:GetChecked() then
		WatchDog.debuffsanchor = "LEFT"
	elseif WatchDogOptions_RightDebuffs:GetChecked() then
		WatchDog.debuffsanchor = "RIGHT"
	elseif WatchDogOptions_BottomDebuffs:GetChecked() then
		WatchDog.debuffsanchor = "BOTTOM"
	end		

 	WatchDog.target.format1 = WatchDogOptions_TargetFormat1:GetText();
	WatchDog.target.format2 = WatchDogOptions_TargetFormat2:GetText();
	
	WatchDog.player.format1 = WatchDogOptions_PlayerFormat1:GetText();
	WatchDog.player.format2 = WatchDogOptions_PlayerFormat2:GetText();
	
	WatchDog.party.format1 = WatchDogOptions_PartyFormat1:GetText();
	WatchDog.party.format2 = WatchDogOptions_PartyFormat2:GetText();
	
	WatchDog.pet.format1 = WatchDogOptions_PetFormat1:GetText();
	WatchDog.pet.format2 = WatchDogOptions_PetFormat2:GetText();
	
	if WatchDog_ShowHideDefaults then WatchDog_ShowHideDefaults() end;
	--WDHooks:RunHooks();
	WatchDog_SetTextFormats();
	WatchDog_UpdateVisibility();
	WatchDog_UpdateFrame();
	WatchDog_AnchorAll();
end