ACCOUNTANT_OPTIONS_TITLE = "Accountant Options";

function AccountantOptions_Toggle()
	if(AccountantOptionsFrame:IsVisible()) then
		AccountantOptionsFrame:Hide();
	else
		AccountantOptionsFrame:Show();
	end
end

function AccountantOptions_OnLoad()
	UIPanelWindows['AccountantOptionsFrame'] = {area = 'center', pushable = 0};
end


function AccountantOptions_OnShow()
	AccountantOptionsFrameToggleButtonText:SetText(ACCLOC_MINIBUT);
	AccountantSliderButtonPosText:SetText(ACCLOC_BUTPOS);
	AccountantOptionsFrameWeekLabel:SetText(ACCLOC_STARTWEEK);



	AccountantOptionsFrameToggleButton:SetChecked(Accountant_SaveData[UnitName("player")]["options"].showbutton);
	AccountantSliderButtonPos:SetValue(Accountant_SaveData[UnitName("player")]["options"].buttonpos);
	UIDropDownMenu_Initialize(AccountantOptionsFrameWeek, AccountantOptionsFrameWeek_Init);
	UIDropDownMenu_SetSelectedID(AccountantOptionsFrameWeek, Accountant_SaveData[Accountant_Player]["options"].weekstart);
end

function AccountantOptions_OnHide()
	if(MYADDONS_ACTIVE_OPTIONSFRAME == this) then
		ShowUIPanel(myAddOnsFrame);
	end
end

function AccountantOptionsFrameWeek_Init()
	local info;
	Accountant_DayList = {ACCLOC_WD_SUN,ACCLOC_WD_MON,ACCLOC_WD_TUE,ACCLOC_WD_WED,ACCLOC_WD_THU,ACCLOC_WD_FRI,ACCLOC_WD_SAT};
	for i = 1, getn(Accountant_DayList), 1 do
		info = { };
		info.text = Accountant_DayList[i];
		info.func = AccountantOptionsFrameWeek_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function AccountantOptionsFrameWeek_OnClick()
	UIDropDownMenu_SetSelectedID(AccountantOptionsFrameWeek, this:GetID());
	Accountant_SaveData[Accountant_Player]["options"].weekstart = this:GetID();
end