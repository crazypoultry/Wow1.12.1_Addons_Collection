SmartPet_OPTIONS_TITLE = "SmartPet Options";

SPOptions_SUBFRAMES = { "SmartPet_AllOptions", "SmartPet_AttackOptions"};


SMARTPET_CHANNELS_DROPDOWN_LIST = {
	"Say",
	"Group",
	"Guild",
	"Raid",
	"Channel"
};

PET_MOODS_DROPDOWN_LIST = {
	"No Change",
	"Defensive",
	"Passive"
};

PET_COMMANDS_DROPDOWN_LIST = {
	"No Change",
	"Stay",
	"Follow"
};

function SmartPet_Options_Toggle() --Toggles SmartPet GUI
	if (SmartPetOptionsFrame:IsVisible()) then
		SmartPetOptionsFrame:Hide();
	else
		SmartPetOptionsFrame:Show();
	end
end

function SmartPetEnable_Toggle() --Toggles SmartPet On/Off
	if (SmartPet_Config.Enabled) then
		SmartPet_Config.Enabled = false;
		SmartPet_AllOptions:Hide();
	else
		SmartPet_Config.Enabled = true;
		SmartPet_AllOptions:Show();
	end
	SmartPet_UpdateActionIcons(true);
end

function SmartPet_ChannelSet()	--Sets Pet Health Warning Channel
	if ( (SmartPetAutoWarnChannelEditBox:GetNumber() < 0 )  or (SmartPetAutoWarnChannelEditBox == nil) )then
		SmartPet_Config.ChannelNumber = 1;
	else
		SmartPet_Config.ChannelNumber = SmartPetAutoWarnChannelEditBox:GetNumber();
	end
	--SmartPet_Config.Channel = "channel";
end

function SmartPet_AlertChannelSet()	--Sets Pet Health Warning Channel
	if ( (SmartPet_AttackAlertChannelEditBox:GetNumber() < 0 )  or (SmartPet_AttackAlertChannelEditBox == nil) )then
		SmartPet_Config.AlertChannelNumber = 1;
	else
		SmartPet_Config.AlertChannelNumber = SmartPet_AttackAlertChannelEditBox:GetNumber();
	end
	--SmartPet_Config.Channel = "channel";
end

function SmartPet_Autowarn_Toggle()
	SmartPet_OnSlashCommand(SMARTPET_AUTOWARN);
end

function SmartPet_Options_OnLoad()
	UIPanelWindows['SmartPetOptionsFrame'] = {area = 'center', pushable = 0};
	tinsert(UISpecialFrames, "SmartPetOptionsFrame");

	--PanelTemplates_SetNumTabs(SmartPetOptionsFrame, 2);
	--PanelTemplates_SetTab(SmartPetOptionsFrame, 1);

end

function SmartPet_Options_OnShow()
	UIDropDownMenu_SetSelectedValue(AutoWarnDropDown,SMARTPET_CHANNELS_DROPDOWN_LIST[SmartPet_Config.Channel]);
	UIDropDownMenu_SetText(SMARTPET_CHANNELS_DROPDOWN_LIST[SmartPet_Config.Channel], AutoWarnDropDown);
	SmartPet_AttackAlertChannelEditBox:SetText(SmartPet_Config.AlertChannelNumber);

	UIDropDownMenu_SetSelectedValue(AttackAlertDropDown,SMARTPET_CHANNELS_DROPDOWN_LIST[SmartPet_Config.AlertChannel]);
	UIDropDownMenu_SetText(SMARTPET_CHANNELS_DROPDOWN_LIST[SmartPet_Config.AlertChannel], AttackAlertDropDown);

	UIDropDownMenu_SetSelectedValue(SmartPetScatterMoodDropDown,PET_MOODS_DROPDOWN_LIST[SmartPet_Config.ScatterMoodsetting]);
	UIDropDownMenu_SetText(PET_MOODS_DROPDOWN_LIST[SmartPet_Config.ScatterMoodsetting], SmartPetScatterMoodDropDown);

	UIDropDownMenu_SetSelectedValue(SmartPetScatterCommandDropDown,PET_COMMANDS_DROPDOWN_LIST[SmartPet_Config.ScatterOrdersetting]);
	UIDropDownMenu_SetText(PET_COMMANDS_DROPDOWN_LIST[SmartPet_Config.ScatterOrdersetting], SmartPetScatterCommandDropDown);

	SmartPetEnableToggleButton:SetChecked(SmartPet_Config.Enabled);

	SmartPetToolTipsToggleButton:SetChecked(SmartPet_Config.ToolTips);

	SmartPetAutoWarnToggleButton:SetChecked(SmartPet_Config.AutoWarn);
	SmartPetAutoWarnPercentEditBox:SetText(SmartPet_Config.WarnHealth);

	SmartPetAutoCowerToggleButton:SetChecked(SmartPet_Config.AutoCower);
	SmartPetAutoCowerPercentEditBox:SetText(SmartPet_Config.CowerHealth);

	SmartPetNoChaseToggleButton:SetChecked(SmartPet_Config.NoChase);
	SmartPetOptionsToggleButton:SetChecked(SmartPet_Config.Icon);
	SmartPetSmartFocusCheckBox:SetChecked(SmartPet_Config.SmartFocus);
	SmartPetAttackAlert:SetChecked(SmartPet_Config.Alert);
	SmartPetScatterToggleButton:SetChecked(SmartPet_Config.Scatter);
	SmartPetSpellOnAttackToggleButton:SetChecked(SmartPet_Config.SpellAttack);
	SmartPetAttackAlertDelayEditBox:SetText(SmartPet_Config.AlertTimeout);
	SmartPetAutoWarnChannelEditBox:SetText(SmartPet_Config.ChannelNumber);
	SmartPetDebuffCheckButton:SetChecked(SmartPet_Config.DebufCheck);
	SmartPetAutoFeedToggleButton:SetChecked(SmartPet_Config.AutoFeed);
	SmartPetAttackRunCheckBox:SetChecked(SmartPet_Config.RushAttack);
	SmartPetRecallAlert:SetChecked(SmartPet_Config.RecallWarn);

	if (SmartPet_Config.AlertChannel == 5) then
		SmartPet_AttackAlertChannelEditBox:Show();
	else 
		SmartPet_AttackAlertChannelEditBox:Hide();
	end

		if (SmartPet_Config.Channel == 5) then
		SmartPetAutoWarnChannelEditBox:Show();
	else 
		SmartPetAutoWarnChannelEditBox:Hide();
	end
	if (SmartPet_Config.Spell ~= "") then
		local spellName, spellRank = GetSpellName(SmartPet_Config.Spell, SmartPet_Config.SpellBook);
		SmartPetAttackSpell:SetNormalTexture(GetSpellTexture(SmartPet_Config.Spell, SmartPet_Config.SpellBook));
		SmartPetAttackSpellText:SetText(spellName.." "..spellRank);
	end
	
	SmartPet_LoadFoodIcon();

	if (SmartPet_Config.Enabled) then
		SmartPet_AllOptions:Show();
	else
		SmartPet_AllOptions:Hide();
	end

	if (SmartPet_Config.Alert) then
		SmartPet_AttackAlertFrame:Show();
	end

	if (SmartPet_Config.AutoWarn) then
		SmartPet_HealthWarningChannels:Show();
	else 
		SmartPet_HealthWarningChannels:Hide();
	end
	if (SmartPet_Config.Scatter) then
		SmartPet_ScatterOptions:Show();
	else 
		SmartPet_ScatterOptions:Hide();
	end


--Hides settings not relevent to warlocks
	if (SmartPet_Vars.Class == "WARLOCK") then
		SmartPetAutoCowerToggleButton:Hide();
		SmartPetAutoCowerPercentEditBox:Hide();
		SmartPetSmartFocusCheckBox:Hide();
		SmartPetAttackRunCheckBox:Hide();
		SmartPetScatterToggleButton:Hide();
		SmartPet_ScatterOptions:Hide();
	end

end


function SmartPet_Options_Init()
end


function SmartPet_Options_OnHide()
	if(MYADDONS_ACTIVE_OPTIONSFRAME == this) then
		ShowUIPanel(myAddOnsFrame);
	end
end

--Sets spell to use on attack when dropped in attack spell slot
function SmartPet_SelectedSpell()
	if (SmartPet_Vars.PickedUp_Spell == "" or not CursorHasSpell()) then
		SmartPet_ClearSpell();
		return
	end

	local spellName, spellRank = GetSpellName( SmartPet_Vars.PickedUp_Spell , SmartPet_Vars.PickedUp_SpellBook);
	SmartPetAttackSpell:SetNormalTexture(GetSpellTexture(SmartPet_Vars.PickedUp_Spell , SmartPet_Vars.PickedUp_SpellBook  ));
	ResetCursor();
	PickupSpell(SmartPet_Vars.PickedUp_Spell , SmartPet_Vars.PickedUp_SpellBook) ;
	SmartPetAttackSpellText:SetText(spellName.." "..spellRank);
	SmartPet_Config.Spell = SmartPet_Vars.PickedUp_Spell;
	SmartPet_Config.SpellBook = SmartPet_Vars.PickedUp_SpellBook;
	SmartPet_Vars.PickedUp_Spell = "";
	SmartPet_Vars.PickedUp_SpellBook = "";
end

--removes selected spell from cursor when droping on attack spell slot
function SmartPet_ClearSpell()
	SmartPetAttackSpell:SetNormalTexture("Interface\\Buttons\\UI-EmptySlot-Disabled");
	SmartPetAttackSpellText:SetText("None");
	SmartPet_Config.Spell = "";
	SmartPet_Config.SpellBook = "";
end

--Initialise the food icon on frame load
function SmartPet_LoadFoodIcon()
	if (SmartPet_Config.Food.name ~= "" and SmartPet_Config.Food.texture ~= "") then
		SmartPetFeedFood:SetNormalTexture(SmartPet_Config.Food.texture);
		SmartPetFeedFoodTexture:SetVertexColor(1.0, 1.0, 1.0);
		SmartPetFeedFoodText:SetText(SmartPet_Config.Food.name);
		
		local bag, slot = SmartPet_FindFood();

		if (not SmartPet_FindFood()) then
			SmartPetFeedFoodTexture:SetVertexColor(0.5, 0.5, 0.5);
			SmartPetFeedFoodText:SetText(gsub(SMARTPET_FOOD_NOFOODINBAGS, "%%f", SmartPet_Config.Food.name));
		end
	else
		SmartPet_ClearFoodIcon();
	end
end

--Show the icon when food is dropped in feed item slot
function SmartPet_ShowFoodIcon()
	if (SmartPet_Vars.CursorItem.slot == 0 or not CursorHasItem()) then
		SmartPet_ClearFoodIcon();
		return
	end

	if (SmartPet_SetCursorItemAsFood()) then
		SmartPet_AddDebugMessage(SmartPet_Config.Food.name.."is used as a Food.", "food");
		SmartPetFeedFood:SetNormalTexture(SmartPet_Config.Food.texture);
		SmartPetFeedFoodTexture:SetVertexColor(1.0, 1.0, 1.0);
		SmartPetFeedFoodText:SetText(SmartPet_Config.Food.name);
		ResetCursor();
		PickupContainerItem(SmartPet_Config.Food.bag, SmartPet_Config.Food.slot);
	else
		local cursorItemName = SmartPet_GetCursorItemInfo();
		SmartPet_AddInfoMessage(string.gsub(SMARTPET_FOOD_NOTAFOOD, '%%n', cursorItemName));
	end
end

--Remove the food icon
function SmartPet_ClearFoodIcon()
	SmartPetFeedFood:SetNormalTexture("Interface\\Buttons\\UI-EmptySlot-Disabled");
	SmartPetFeedFoodText:SetText("None");
	SmartPet_ClearSelectedFood();
end

--
function SmartPet_ScatterMoodToggle(mood)
	if (mood == "Passive") then
		SmartPet_Config.ScatterMood = PetPassiveMode;
		SmartPet_Config.ScatterMoodsetting = 3;

	elseif (mood == "Defensive") then
		SmartPet_Config.ScatterMood = PetDefensiveMode;
		SmartPet_Config.ScatterMoodsetting = 2;

	else
		SmartPet_Config.ScatterMood = "";
		SmartPet_Config.ScatterMoodsetting  = 1;

	end
end

function SmartPet_ScatterCommandToggle(order)
	if (order == "Follow") then
		SmartPet_Config.ScatterOrder = PetFollow;
		SmartPet_Config.ScatterOrdersetting = 3; 

	elseif (order == "Stay") then
		SmartPet_Config.ScatterOrder = PetWait;
		SmartPet_Config.ScatterOrdersetting = 2; 

	else
		SmartPet_Config.ScatterOrder = "";
		SmartPet_Config.ScatterOrdersetting = 1; 

	end
end


function SmartPet_AutoWarnDropDown_Initialize()
	local info;
	for i = 1, getn(SMARTPET_CHANNELS_DROPDOWN_LIST), 1 do
		info = {
			text = SMARTPET_CHANNELS_DROPDOWN_LIST[i];
			func = SmartPet_AutoWarnDropDown_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end

function SmartPet_AutoWarnDropDown_OnLoad()
	UIErrorsFrame:AddMessage(SmartPet_Config.Channel, 0, 0, 1, 1.0, UIERRORS_HOLD_TIME);
	UIDropDownMenu_Initialize(AutoWarnDropDown, SmartPet_AutoWarnDropDown_Initialize);
	UIDropDownMenu_SetSelectedValue(AutoWarnDropDown,1);
	UIDropDownMenu_SetText(SMARTPET_CHANNELS_DROPDOWN_LIST[SmartPet_Config.Channel], AutoWarnDropDown);
	UIDropDownMenu_SetWidth(75);
end

function SmartPet_AutoWarnDropDown_OnClick()
	local oldID = UIDropDownMenu_GetSelectedID(AutoWarnDropDown);
	UIDropDownMenu_SetSelectedID(AutoWarnDropDown, this:GetID());
	if(oldID ~= this:GetID()) then
		SmartPet_Config.Channel = this:GetID();
	end
	if (SmartPet_Config.Channel == 5) then
		SmartPetAutoWarnChannelEditBox:Show();
	else 
		SmartPetAutoWarnChannelEditBox:Hide();
	end
end



function SmartPet_ScatterMoodDropDown_Initialize()
	local info;
	for i = 1, getn(PET_MOODS_DROPDOWN_LIST), 1 do
		info = {
			text = PET_MOODS_DROPDOWN_LIST[i];
			func = SmartPet_MoodDropDown_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end

function SmartPet_ScatterMoodDropDown_OnLoad()
	UIDropDownMenu_Initialize(SmartPetScatterMoodDropDown, SmartPet_ScatterMoodDropDown_Initialize);
	UIDropDownMenu_SetSelectedID(SmartPetScatterMoodDropDown, 1);
	UIDropDownMenu_SetWidth(85);
end

function SmartPet_MoodDropDown_OnClick()
	local oldID = UIDropDownMenu_GetSelectedID(SmartPetScatterMoodDropDown);
	UIDropDownMenu_SetSelectedID(SmartPetScatterMoodDropDown, this:GetID());
	if(oldID ~= this:GetID()) then
		SmartPet_ScatterMoodToggle(PET_MOODS_DROPDOWN_LIST[this:GetID()]);
	end
end


function SmartPet_ScatterCommandDropDown_Initialize()
	local info;
	for i = 1, getn(PET_COMMANDS_DROPDOWN_LIST), 1 do
		info = {
			text = PET_COMMANDS_DROPDOWN_LIST[i];
			func = SmartPet_CommandDropDown_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end

function SmartPet_ScatterCommandDropDown_OnLoad()
	UIDropDownMenu_Initialize(SmartPetScatterCommandDropDown, SmartPet_ScatterCommandDropDown_Initialize);
	UIDropDownMenu_SetSelectedID(SmartPetScatterCommandDropDown, 1);
	UIDropDownMenu_SetWidth(85);
end

function SmartPet_CommandDropDown_OnClick()
	local oldID = UIDropDownMenu_GetSelectedID(SmartPetScatterCommandDropDown);
	UIDropDownMenu_SetSelectedID(SmartPetScatterCommandDropDown, this:GetID());
	if(oldID ~= this:GetID()) then
		SmartPet_ScatterCommandToggle(PET_COMMANDS_DROPDOWN_LIST[this:GetID()]);
	end
end

function SmartPet_AttackAlertDropDown_Initialize()
	local info;
	for i = 1, getn(SMARTPET_CHANNELS_DROPDOWN_LIST), 1 do
		info = {
			text = SMARTPET_CHANNELS_DROPDOWN_LIST[i];
			func = SmartPet_AttackAlertDropDown_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end

function SmartPet_AttackAlertDropDown_OnLoad()
	UIErrorsFrame:AddMessage(SmartPet_Config.Channel, 0, 0, 1, 1.0, UIERRORS_HOLD_TIME);
	UIDropDownMenu_Initialize(AttackAlertDropDown, SmartPet_AttackAlertDropDown_Initialize);
	UIDropDownMenu_SetSelectedValue(AttackAlertDropDown,1);
	UIDropDownMenu_SetText(SMARTPET_CHANNELS_DROPDOWN_LIST[SmartPet_Config.Channel], AttackAlertDropDown);
	UIDropDownMenu_SetWidth(75);
end

function SmartPet_AttackAlertDropDown_OnClick()
	local oldID = UIDropDownMenu_GetSelectedID(AttackAlertDropDown);
	UIDropDownMenu_SetSelectedID(AttackAlertDropDown, this:GetID());
	if(oldID ~= this:GetID()) then
		SmartPet_Config.AlertChannel = this:GetID();
	end
	if (SmartPet_Config.AlertChannel == 5) then
		SmartPet_AttackAlertChannelEditBox:Show();
	else 
		SmartPet_AttackAlertChannelEditBox:Hide();
	end
end

function SmartPetTab_OnClick()
	if ( this:GetName() == "SmartPetOptionsFrameTab1" ) then
		ToggleSP("SmartPet_AllOptions");
	elseif ( this:GetName() == "SmartPetOptionsFrameTab2" ) then
		ToggleSP("SmartPet_AttackOptions");
	end
	PlaySound("igCharacterInfoTab");
end

function ToggleSP(tab)
	local subFrame = getglobal(tab);
	if ( subFrame ) then
		if ( SmartPetOptionsFrame:IsVisible() ) then
			if ( subFrame:IsVisible() ) then	
			else
				PlaySound("igCharacterInfoTab");
				SP_ShowSubFrame(tab);
			end
		else
			SP_ShowSubFrame(tab);
		end
	end
end

function SP_ShowSubFrame(frameName)

for index = 1, getn(SPOptions_SUBFRAMES), 1 do
		if ( SPOptions_SUBFRAMES[index] == frameName ) then
			getglobal(SPOptions_SUBFRAMES[index]):Show()
		else
			getglobal(SPOptions_SUBFRAMES[index]):Hide();	
		end	
	end 
end
