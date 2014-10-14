function ER_InitConfig()
	ER_Config = { };
	
	ER_Config["version"] = ER_VERSION_NUMBER;
	
	ER_InitRaidConfig();
	ER_InitBuffsConfig();
	ER_InitMainTanksConfig();
	ER_InitTargetsConfig();
	ER_InitMiscConfig();
end

function ER_InitRaidConfig()
	ER_Config["playerGroupIsShown"] = true;
	
	ER_Config["groups"] = {
		{ ["number"] = 1, ["isShown"] = false },
		{ ["number"] = 2, ["isShown"] = false },
		{ ["number"] = 3, ["isShown"] = false },
		{ ["number"] = 4, ["isShown"] = false },
		{ ["number"] = 5, ["isShown"] = false },
		{ ["number"] = 6, ["isShown"] = false },
		{ ["number"] = 7, ["isShown"] = false },
		{ ["number"] = 8, ["isShown"] = false }
	};

	ER_Config["classes"] = {
		{ ["name"] = "WARRIOR", ["isShown"] = true },
		{ ["name"] = "MAGE", ["isShown"] = true },
		{ ["name"] = "WARLOCK", ["isShown"] = true },
		{ ["name"] = "ROGUE", ["isShown"] = true },
		{ ["name"] = "HUNTER", ["isShown"] = true },
		{ ["name"] = "PRIEST", ["isShown"] = true },
		{ ["name"] = "DRUID", ["isShown"] = true },
		{ ["name"] = "PALADIN", ["isShown"] = true },
	};
	
	ER_SetPaladinOrShaman();

	ER_Config["alreadyDisplayedPlayersAreHidden"] = true;
	ER_Config["playerIsHidden"] = true;
	ER_Config["alignment"] = "SMART";
	ER_Config["scale"] = 100;
	ER_Config["backgroundIsShown"] = true;
	
	ER_Config["optionsSideIsShown"] = true;
	
	ER_ContainerFrame_InitLocation();

	HIDE_PARTY_INTERFACE = "1";
end

function ER_InitBuffsConfig()
	SHOW_CASTABLE_BUFFS = "1";
	SHOW_DISPELLABLE_DEBUFFS = "0";
	
	ER_Config["buffsAreShown"] = false;
	ER_Config["allGroupsAreShownWhenBuffsAreShown"] = true;
	ER_Config["maxBuffs"] = 4;
	ER_Config["debuffsAreShownInCombat"] = false;
	ER_Config["maxDebuffs"] = 2;
end

function ER_InitMainTanksConfig()
	ER_Config["mainTanksAreShown"] = true;
	ER_Config["mainTanksAreAttached"] = true;
	ER_Config["mainTanksAttachment"] = "RAID";
	ER_Config["mainTanksAlignment"] = "SMART";
	ER_Config["mainTanksScale"] = 100;
	
	ER_MainTanksPlaceHolder_UpdateScale();
	ER_MainTanksPlaceHolder_InitLocation();
end

function ER_InitTargetsConfig()
	ER_Config["targetsAreShown"] = true;
	ER_Config["targetsAlignment"] = "SMART";
	ER_Config["targetsScale"] = 100;
	ER_Config["showHostileTargetsOnly"] = true;
	ER_Config["duplicatedTargetsAreHidden"] = true;
	ER_Config["automaticallySetTargetsIcons"] = false;
	
	ER_TargetsFrame_UpdateScale();
	ER_TargetsFrame_InitLocation();
end

function ER_InitMiscConfig()
	ER_Config["titleOfTheFramesIsShown"] = true;
	ER_Config["highlightAttackedPlayers"] = true;
	ER_Config["soundsOnAggro"] = true;
	ER_Config["useAssist"] = true;
end

function ER_UpdateConfig()
	if ( type(ER_Config["version"]) == "string" ) then
		ER_Config["version"] = 000902;
	end
	
	if ( ER_Config["version"] < 000903 ) then
		ER_Config["scale"] = 100;
	end

	if ( ER_Config["version"] < 000904 ) then
		SHOW_CASTABLE_BUFFS = "1";
		SHOW_DISPELLABLE_DEBUFFS = "0";
		
		ER_Config["buffsAreShown"] = false;
		ER_Config["maxBuffs"] = 4;
		ER_Config["maxDebuffs"] = 2;
		ER_Config["backgroundIsShown"] = true;
	end

	if ( ER_Config["version"] < 000906 ) then		
		ER_Config["alignment"] = "SMART";
	end

	if ( ER_Config["version"] < 000907 ) then		
		ER_Config["optionsSideIsShown"] = true;
	end
	
	if ( ER_Config["version"] < 010003 ) then		
		ER_InitMainTanksConfig();
		ER_InitTargetsConfig();
		ER_InitMiscConfig();
	end	

	if ( ER_Config["version"] < 010410 ) then		
		ER_Config["mainTanksAreAttached"] = true;
		ER_Config["mainTanksAttachment"] = "RAID";
		ER_Config["duplicatedTargetsAreHidden"] = true;
		if ( ER_Config["groupNumbersAndClassNamesAreShown"] ~= nil) then
			ER_Config["titleOfTheFramesIsShown"] = ER_Config["groupNumbersAndClassNamesAreShown"];
			ER_Config["groupNumbersAndClassNamesAreShown"] = nil;
		else
			ER_Config["titleOfTheFramesIsShown"] = true;
		end

		ER_MainTanksPlaceHolder_InitLocation();
	end

	if ( ER_Config["version"] < 010411 ) then		
		ER_Config["allGroupsAreShownWhenBuffsAreShown"] = true;
		ER_Config["debuffsAreShownInCombat"] = true;
	end
		
	if ( ER_Config["version"] < 010412 ) then		
		ER_Config["mainTanksAlignment"] = "SMART";
		ER_Config["mainTanksScale"] = 100;
		ER_Config["targetsAlignment"] = "SMART";
	end
	
	if ( ER_Config["version"] < 010413 ) then
		ER_MainTanksPlaceHolder_InitLocation();
		ER_TargetsFrame_InitLocation();
	end

	if ( ER_Config["version"] < 020100 ) then
		if ( ER_Config["useRightClickToAssist"] ~= nil) then
			ER_Config["useCtrlClickToAssist"] = ER_Config["useRightClickToAssist"];
			ER_Config["useRightClickToAssist"] = nil;
		else
			ER_Config["useCtrlClickToAssist"] = true;
		end
	end

	if ( ER_Config["version"] < 020101 ) then
		if ( ER_Config["useCtrlClickToAssist"] ~= nil) then
			ER_Config["useAssist"] = ER_Config["useCtrlClickToAssist"];
			ER_Config["useCtrlClickToAssist"] = nil;
		else
			ER_Config["useAssist"] = true;
		end
	end

	if ( ER_Config["version"] < 020201 ) then		
		ER_Config["automaticallySetTargetsIcons"] = false;
	end
	
	ER_Config["version"] = ER_VERSION_NUMBER;
end

function ER_SetPaladinOrShaman()
	local faction = UnitFactionGroup("player");

	if ( faction ) then
		local class;
		for _, class in ER_Config.classes do
			if ( faction == "Horde" ) then
				if ( class.name == "PALADIN" ) then
					class.name = "SHAMAN";
				end
			else
				if ( class.name == "SHAMAN" ) then
					class.name = "PALADIN";
				end
			end
		end
	end
end

function ER_RaidFrame_OnShow()
	RequestRaidInfo();

	RaidFrame_Update();

	-- Sorry, CTRA drop down loot menu must be hidden	
	if ( CT_RATabLootDropDown ) then
		CT_RATabLootDropDown:Hide();
	end

	if ( ER_Config["optionsSideIsShown"] ) then
		ER_OptionsSideFrame:Show();
	end
	
	ER_RaidFrameOptionsButton_Update();
end

function ER_RaidFrame_OnHide()
	ER_OptionsSideFrame:Hide();
	if ( RaidGroupFrame_OnHide ) then
		RaidGroupFrame_OnHide();
	end
end

function ER_RaidFrameOptionsButton_Update()
	if ( ER_OptionsSideFrame:IsShown() ) then
		ER_RaidFrameOptionsButton:SetNormalTexture("Interface\\AddOns\\EasyRaid\\Textures\\MinusButton-Up");
		ER_RaidFrameOptionsButton:SetPushedTexture("Interface\\AddOns\\EasyRaid\\Textures\\MinusButton-Down");
	else
		ER_RaidFrameOptionsButton:SetNormalTexture("Interface\\AddOns\\EasyRaid\\Textures\\PlusButton-Up");
		ER_RaidFrameOptionsButton:SetPushedTexture("Interface\\AddOns\\EasyRaid\\Textures\\PlusButton-Down");
	end
end

function ER_OptionsSideFrame_Update()
	if ( ER_OptionsSideFrame:IsShown() ) then
		local i;

		-- Raid
		
		for i=1, getn(ER_Config.groups) do
			local group = ER_Config.groups[i];
			getglobal("ER_Group"..i.."CheckButtonText"):SetText(GROUP.." "..group.number);
			getglobal("ER_Group"..i.."CheckButton"):SetChecked(group.isShown);
		end
	
		for i=1, getn(ER_Config.classes) do
			local class = ER_Config.classes[i];
			getglobal("ER_Class"..i.."CheckButtonText"):SetText(ER_CLASSES_NAME[class.name]);
			getglobal("ER_Class"..i.."CheckButton"):SetChecked(class.isShown);
		end
		
		ER_Class1MoveUp:Disable();
		getglobal("ER_Class"..getn(ER_Config.classes).."MoveDown"):Disable();	

		ER_ShowPlayerGroupCheckButton:SetChecked(ER_Config.playerGroupIsShown);	
		ER_HideAlreadyDisplayedPlayersCheckButton:SetChecked(ER_Config.alreadyDisplayedPlayersAreHidden);
		ER_HidePlayerCheckButton:SetChecked(ER_Config.playerIsHidden);
		UIDropDownMenu_SetSelectedValue(ER_AlignmentDropDownMenu, ER_Config.alignment);
		ER_ScaleSliderText:SetText(ER_SCALE.." "..ER_Config.scale.."%");
		ER_ScaleSlider:SetValue(ER_Config.scale);

		-- Buffs
		
		ER_ShowBuffsCheckButton:SetChecked(ER_Config.buffsAreShown);
		ER_ShowCastableBuffsCheckButton:SetChecked(SHOW_CASTABLE_BUFFS == "1");
		ER_ShowAllGroupsCheckButton:SetChecked(ER_Config.allGroupsAreShownWhenBuffsAreShown);
		ER_MaxBuffsSliderText:SetText(ER_MAX_DISPLAYABLE_BUFFS.." "..ER_Config.maxBuffs);
		ER_MaxBuffsSlider:SetValue(ER_Config.maxBuffs);
	
		ER_ShowDebuffsCheckButton:SetChecked(not ER_Config.buffsAreShown);
		ER_ShowDispellableDebuffsCheckButton:SetChecked(SHOW_DISPELLABLE_DEBUFFS == "1");
		ER_ShowDebuffsInCombatCheckButton:SetChecked(ER_Config.debuffsAreShownInCombat);
		ER_MaxDebuffsSliderText:SetText(ER_MAX_DISPLAYABLE_DEBUFFS.." "..ER_Config.maxDebuffs);
		ER_MaxDebuffsSlider:SetValue(ER_Config.maxDebuffs);

		-- Main Tanks
		
		if ( ER_RaidAssistHasMTSupport() ) then
			ER_ShowMainTanksCheckButton:SetChecked(ER_Config.mainTanksAreShown);
			ER_AttachMainTanksCheckButton:SetChecked(ER_Config.mainTanksAreAttached);
			UIDropDownMenu_SetSelectedValue(ER_MainTanksAttachmentDropDownMenu, ER_Config.mainTanksAttachment);
			if ( ER_Config.mainTanksAreAttached ) then
				OptionsFrame_EnableDropDown(ER_MainTanksAttachmentDropDownMenu);
			else
				OptionsFrame_DisableDropDown(ER_MainTanksAttachmentDropDownMenu);
			end
			if ( not ER_Config.mainTanksAreAttached ) then
				ER_MainTanksOptionsFrameBox:SetHeight(108);
				UIDropDownMenu_SetSelectedValue(ER_MainTanksAlignmentDropDownMenu, ER_Config.mainTanksAlignment);
				ER_MainTanksAlignmentDropDownMenu:Show();
				ER_MainTanksScaleSlider:Show();
				ER_MainTanksScaleSliderText:SetText(ER_SCALE.." "..ER_Config.mainTanksScale.."%");
				ER_MainTanksScaleSlider:SetValue(ER_Config.mainTanksScale);
				ER_MainTanksFrameBox:SetPoint("TOPLEFT", ER_MainTanksOptionsFrameBox, "BOTTOMLEFT", 0, -4);
				ER_MainTanksFrameBox:SetPoint("TOPRIGHT", ER_MainTanksOptionsFrameBox, "BOTTOMRIGHT", 0, -4);
			else
				ER_MainTanksOptionsFrameBox:SetHeight(66);
				ER_MainTanksAlignmentDropDownMenu:Hide();
				ER_MainTanksScaleSlider:Hide();
				ER_MainTanksFrameBox:SetPoint("TOPLEFT", ER_MainTanksOptionsFrameBox, "BOTTOMLEFT", 0, -8);
				ER_MainTanksFrameBox:SetPoint("TOPRIGHT", ER_MainTanksOptionsFrameBox, "BOTTOMRIGHT", 0, -8);
			end

			if ( IsRaidLeader() or IsRaidOfficer() ) then
				ER_MainTanksAdviceText:SetText("");
				ER_MainTanksFrameBox:SetHeight(200);
			else
				ER_MainTanksAdviceText:SetText(ER_MAIN_TANKS_MEMBER_ADVICE);
				ER_MainTanksFrameBox:SetHeight(222);
			end
		else
			PanelTemplates_DisableTab(ER_OptionsSideFrame, 3);
		end

		-- Targets

		if ( ER_RaidAssistHasMTSupport() ) then
			ER_ShowTargetsCheckButton:SetChecked(ER_Config.targetsAreShown);
			ER_ShowHostileTargetsOnlyCheckButton:SetChecked(ER_Config.showHostileTargetsOnly);
			ER_HideDuplicatedTargetsCheckButton:SetChecked(ER_Config.duplicatedTargetsAreHidden);
			if ( IsRaidLeader() or IsRaidOfficer() ) then
				ER_AutomaticallySetTargetsIconsCheckButton:Enable();
				ER_AutomaticallySetTargetsIconsCheckButtonText:SetFontObject(GameFontNormalSmall);
				ER_AutomaticallySetTargetsIconsCheckButton:SetChecked(ER_Config.automaticallySetTargetsIcons);
			else
				ER_AutomaticallySetTargetsIconsCheckButton:Disable();
				ER_AutomaticallySetTargetsIconsCheckButtonText:SetFontObject(GameFontDisableSmall);
				ER_AutomaticallySetTargetsIconsCheckButton:SetChecked(false);
			end
			UIDropDownMenu_SetSelectedValue(ER_TargetsAlignmentDropDownMenu, ER_Config.targetsAlignment);
			ER_TargetsScaleSliderText:SetText(ER_SCALE.." "..ER_Config.targetsScale.."%");
			ER_TargetsScaleSlider:SetValue(ER_Config.targetsScale);
		else
			PanelTemplates_DisableTab(ER_OptionsSideFrame, 4);
		end

		-- Misc

		ER_ShowTitleOfTheFramesCheckButton:SetChecked(ER_Config.titleOfTheFramesIsShown);
		if ( ER_RaidAssistHasMTSupport() ) then
			ER_HighlightAttackedPlayersCheckButton:SetChecked(ER_Config.highlightAttackedPlayers);
			ER_SoundsOnAggroCheckButton:SetChecked(ER_Config.soundsOnAggro);
			ER_UseAssist:SetChecked(ER_Config.useAssist);
		else
			ER_HighlightAttackedPlayersCheckButton:Disable();
			ER_HighlightAttackedPlayersCheckButtonText:SetFontObject(GameFontDisableSmall);
			ER_SoundsOnAggroCheckButton:Disable();
			ER_SoundsOnAggroCheckButtonText:SetFontObject(GameFontDisableSmall);
			ER_UseAssist:Disable();
			ER_UseAssistText:SetFontObject(GameFontDisableSmall);
		end
		
		local version = ER_VERSION_STRING;
		if ( ER_RaidAssistHasMTSupport() ) then
			version = version.." / "..ER_RaidAssistVersion();
		end
		ER_OptionsSideFrameVersion:SetText(version);
	end
end

function ER_AlignmentDropDownMenu_Initialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue(this);

	local func;
	if ( this == ER_AlignmentDropDownMenu or this == ER_AlignmentDropDownMenuButton ) then
		func = ER_AlignmentDropDownMenu_OnClick;
	elseif ( this == ER_MainTanksAlignmentDropDownMenu or this == ER_MainTanksAlignmentDropDownMenuButton ) then
		func = ER_MainTanksAlignmentDropDownMenu_OnClick;
	elseif ( this == ER_TargetsAlignmentDropDownMenu or this == ER_TargetsAlignmentDropDownMenuButton ) then
		func = ER_TargetsAlignmentDropDownMenu_OnClick;
	end	

	local info;

	info = {};
	info.text = ER_SMART;
	info.func = func;
	info.value = "SMART"
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = ER_TOP_LEFT;
	info.func = func;
	info.value = "TOPLEFT"
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = ER_TOP_RIGHT;
	info.func = func;
	info.value = "TOPRIGHT"
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = ER_BOTTOM_LEFT;
	info.func = func;
	info.value = "BOTTOMLEFT"
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = ER_BOTTOM_RIGHT;
	info.func = func;
	info.value = "BOTTOMRIGHT"
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info);
end

function ER_AlignmentDropDownMenu_OnClick()
	UIDropDownMenu_SetSelectedValue(ER_AlignmentDropDownMenu, this.value);
	ER_Config.alignment = this.value;
	ER_RaidPulloutFrame_Update();
end

function ER_MainTanksAlignmentDropDownMenu_OnClick()
	UIDropDownMenu_SetSelectedValue(ER_MainTanksAlignmentDropDownMenu, this.value);
	ER_Config.mainTanksAlignment = this.value;
	ER_MainTanksPlaceHolder_SaveLocation();
	ER_RaidPulloutFrame_Update();
end

function ER_TargetsAlignmentDropDownMenu_OnClick()
	UIDropDownMenu_SetSelectedValue(ER_TargetsAlignmentDropDownMenu, this.value);
	ER_Config.targetsAlignment = this.value;
	ER_TargetsFrame_SaveLocation();
end

function ER_MainTanksAttachmentDropDownMenu_Initialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue(ER_MainTanksAttachmentDropDownMenu);
	local info;

	info = {};
	info.text = ER_RAID_ATTACHMENT;
	info.func = ER_MainTanksAttachmentDropDownMenu_OnClick;
	info.value = "RAID"
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = ER_TARGETS_ATTACHMENT;
	info.func = ER_MainTanksAttachmentDropDownMenu_OnClick;
	info.value = "TARGETS"
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info);
end

function ER_MainTanksAttachmentDropDownMenu_OnClick()
	UIDropDownMenu_SetSelectedValue(ER_MainTanksAttachmentDropDownMenu, this.value);
	ER_Config.mainTanksAttachment = this.value;
	ER_RaidPulloutFrame_Refresh();
end