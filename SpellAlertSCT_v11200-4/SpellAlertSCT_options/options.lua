local playerName = nil;
local settingupoptions = false;

function SpellAlertSCTOptionsFrame_OnShow()
	settingupoptions = true;
	
	if (GetLocale()=="koKR") then
		playerName = GetCVar("realmName").." ??? "..UnitName("player");
	else
		playerName = UnitName("player").." of "..GetCVar("realmName");
	end

	
	SpellAlertSCT_print("Displaying Options Frame.")
	
	SASCTToggleText:SetText(SASCTOPTIONS_Toggle)
	SASCTCritText:SetText(SASCTOPTIONS_Crit)
	SASCTTargetOnlyText:SetText(SASCTOPTIONS_TargetOnly)
	SASCTReTargetText:SetText(SASCTOPTIONS_ReTarget)
	SASCTCompactText:SetText(SASCTOPTIONS_Compact)
	SASCTColorizeText:SetText(SASCTOPTIONS_Colorize)
	SASCTEmotesText:SetText(SASCTOPTIONS_Emotes)
	SASCTBossWarnsText:SetText(SASCTOPTIONS_BossWarns)
	SASCTStyleLabel:SetText(SASCTOPTIONS_Style.name)
	SASCTTILabel:SetText(SASCTOPTIONS_TargetIndicator)

	SASCTToggle:SetChecked(SpellAlertSCTDB[playerName].Toggle)
	SASCTCrit:SetChecked(SpellAlertSCTDB[playerName].Crit)
	SASCTTargetOnly:SetChecked(SpellAlertSCTDB[playerName].TargetOnly)
	SASCTReTarget:SetChecked(SpellAlertSCTDB[playerName].Retarget)
	SASCTCompact:SetChecked(SpellAlertSCTDB[playerName].Compact)
	SASCTColorize:SetChecked(SpellAlertSCTDB[playerName].Colorize)
	SASCTEmotes:SetChecked(SpellAlertSCTDB[playerName].Emotes)
	SASCTBossWarns:SetChecked(SpellAlertSCTDB[playerName].BossWarnings)

	SASCTTIEdit:SetText(SpellAlertSCTDB[playerName].TargetIndicator)
	
		--Dropdowns
	--for key, value in SASCT.FrameSelections do
		
		--option2 = getglobal("SCTOptionsFrame_Selection"..value.index.."Label");
		--option1.SCTVar = value.SCTVar;
		--option1.SCTTable = value.SCTTable;
		--lookup table cause of WoW's crappy dropdown UI.
	SASCTStyle.lookup = SASCTOPTIONS_Style.table;
		--if (option1.SCTTable) then
		--	getvalue = self.db.profile[SCT.FRAMES_DATA_TABLE][option1.SCTTable][value.SCTVar];
		--else
		--	getvalue = self.db.profile[value.SCTVar];
		--end
		
	UIDropDownMenu_SetSelectedID(SASCTStyle, SpellAlertSCT_GetStyleNum());
		--not sure why I have to do this, but only way to make it show correctly cause of WoW's crappy dropdown UI.
	UIDropDownMenu_SetText(SASCTOPTIONS_Style.table[SpellAlertSCT_GetStyleNum()], SASCTStyle);
	SASCTStyle.tooltipText = SASCTOPTIONS_Style.tooltipText;
		--option2:SetText(key);
	--end
	
	option1 = getglobal("SASCTFrameSliderSlider");
	textstring = getglobal("SASCTFrameSliderSliderText");
	option2 = getglobal("SASCTFrameSliderSliderLow");
	option3 = getglobal("SASCTFrameSliderSliderHigh");
	option4 = getglobal("SASCTFrameSliderEditBox");
	--option1.SCTVar = value.SCTVar;
	--option1.SCTTable = value.SCTTable;
	--if (option1.SCTTable) then
		getvalue = SpellAlertSCTDB[playerName].Frame;
	--else
	--	getvalue = self.db.profile[value.SCTVar];
	--end
	--option1.SCTLabel = key;
	option1:SetMinMaxValues(SASCTOPTIONS_FrameSlider.minValue, SASCTOPTIONS_FrameSlider.maxValue);
	option1:SetValueStep(SASCTOPTIONS_FrameSlider.valueStep);
	option1.tooltipText = SASCTOPTIONS_FrameSlider.tooltipText;
	option1:SetValue(getvalue);
	textstring:SetText(SASCTOPTIONS_FrameSlider.name);
	option4:SetText(getvalue)
	option2:SetText(SASCTOPTIONS_FrameSlider.minText);
	option3:SetText(SASCTOPTIONS_FrameSlider.maxText);
	
	SASCTFrameSlider:SetScale(0.75)
	
	settingupoptions = false;
end

function SpellAlertSCTDropDown_Initialize()
	local info = {};
	--ChatFrame1:AddMessage(this:GetName())
	if (this:GetName() == "SASCTStyleButton") then
		--ChatFrame1:AddMessage("check")
		for key, name in SASCTOPTIONS_Style.table do
			info = {};
			info.text = name;
			info.func = function(x) SpellAlertSCTDropDown_OnClick(x) end;
			info.arg1 = key;
			UIDropDownMenu_AddButton(info);
		end
	end
end

function SpellAlertSCTDropDown_OnClick(x)
	--ChatFrame1:AddMessage("Clicked "..x)
	SpellAlertSCT_SetStyleByNum(x)
	UIDropDownMenu_SetSelectedID(SASCTStyle, SpellAlertSCT_GetStyleNum());
	UIDropDownMenu_SetText(SASCTOPTIONS_Style.table[SpellAlertSCT_GetStyleNum()], SASCTStyle);
	
	SpellAlertSCT_test()
end

function SpellAlertSCTToggle()
	if (this:GetChecked()) then
		SpellAlertSCTDB[playerName].Toggle = true
	else
		SpellAlertSCTDB[playerName].Toggle = false
	end
		
	SpellAlertSCT_test()
end

function SpellAlertSCTOptionsCritToggle()
	if (this:GetChecked()) then
		SpellAlertSCTDB[playerName].Crit = true
	else
		SpellAlertSCTDB[playerName].Crit = false
	end
		
	SpellAlertSCT_test()
end

function SpellAlertSCTOptionsTargetOnlyToggle()
	if (this:GetChecked()) then
		SpellAlertSCTDB[playerName].TargetOnly = true
	else
		SpellAlertSCTDB[playerName].TargetOnly = false
	end
end

function SpellAlertSCTOptionsReTargetToggle()
	if (this:GetChecked()) then
		SpellAlertSCTDB[playerName].Retarget = true
	else
		SpellAlertSCTDB[playerName].Retarget = false
	end
end

function SpellAlertSCTOptionsCompactToggle()
	if (this:GetChecked()) then
		SpellAlertSCTDB[playerName].Compact = true
	else
		SpellAlertSCTDB[playerName].Compact = false
	end
		
	SpellAlertSCT_test()
end

function SpellAlertSCTOptionsColorizeToggle()
	if (this:GetChecked()) then
		SpellAlertSCTDB[playerName].Colorize = true
	else
		SpellAlertSCTDB[playerName].Colorize = false
	end
		
	SpellAlertSCT_test()
end

function SpellAlertSCTOptionsEmotesToggle()
	if (this:GetChecked()) then
		SpellAlertSCTDB[playerName].Emotes = true
	else
		SpellAlertSCTDB[playerName].Emotes = false
	end
end

function SpellAlertSCTOptionsBossWarnsToggle()
	if (this:GetChecked()) then
		SpellAlertSCTDB[playerName].BossWarnings = true
	else
		SpellAlertSCTDB[playerName].BossWarnings = false
	end
end

function SpellAlertSCTSliderValueChanged()
	if (settingupoptions) then return end

	local string, editbox;
	string = getglobal(this:GetName().."Text");
	editbox = getglobal(this:GetParent():GetName().."EditBox");
	editbox:SetText(this:GetValue())
	SpellAlertSCTDB[playerName].Frame = this:GetValue()

	SpellAlertSCT_test()
end

function SpellAlertSCTEditBoxValueChanged()
	if (settingupoptions) then return end

	local slider = getglobal(this:GetParent():GetName().."Slider");
	local getvalue = tonumber(this:GetText());
	
	if (getvalue < SASCTOPTIONS_FrameSlider.minValue or getvalue > SASCTOPTIONS_FrameSlider.maxValue) then
		SpellAlertSCT_print("Frame must be between "..SASCTOPTIONS_FrameSlider.minText.." and "..SASCTOPTIONS_FrameSlider.maxText..".")
		return
	end
	--	self.db.profile[SCT.FRAMES_DATA_TABLE][slider.SCTTable][slider.SCTVar] = getvalue;
	--else
	SpellAlertSCTDB[playerName].Frame = getvalue;
	--end
	-- disable update change,set slider,setonchance back
	slider:SetScript("OnValueChanged", nil);
	slider:SetValue(getvalue);
	slider:SetScript("OnValueChanged", function() SpellAlertSCTSliderValueChanged() end);
	--update Example
	SpellAlertSCT_test()
end

function SpellAlertSCTTargetIndicatorChanged()
	if (settingupoptions) then return end
	
	if (this:GetText() == SpellAlertSCTDB[playerName].TargetIndicator) then return end
	
	SpellAlertSCTDB[playerName].TargetIndicator = this:GetText()
	SpellAlertSCT_print(SASCT_OPT_TARGETINDICATOR_SET..this:GetText());
	
	SpellAlertSCT_test()
end

function SpellAlertSCTTargetIndicatorSetOld()
	SASCTTIEdit:SetText(SpellAlertSCTDB[playerName].TargetIndicator)
end

function SpellAlertSCTEnterWarn()
	SpellAlertSCT_print(SASCTOPTIONS_MustHitEnter)
end
