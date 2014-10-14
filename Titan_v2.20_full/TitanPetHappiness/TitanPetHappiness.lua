TITAN_PH_ID = "PetHappiness";
TITAN_PH_VERSION = "1.11";

function TitanPanelPetHappinessButton_OnLoad()
	this.registry = {
		id = TITAN_PH_ID,
		version = TITAN_PH_VERSION,
		category = "Information",
		menuText = "Pet Happiness",
		buttonTextFunction = "TitanPanelPetHappinessButton_GetButtonText", 
		tooltipTitle = "Pet Happiness", 
		tooltipTextFunction = "TitanPanelPetHappinessButton_GetTooltipText", 
		icon = "Interface\\Icons\\Ability_Hunter_Pet_Cat",
		iconWidth = 16,
		savedVariables = {
			ShowIcon = 1,
			ShowFeeding = TITAN_NIL,
		}

	};	

	this:RegisterEvent("UNIT_HAPPINESS");
	this:RegisterEvent("UNIT_PET");
	this:RegisterEvent("UNIT_AURA");
end

function TitanPanelPetHappinessButton_OnEvent()
	TitanPanelButton_UpdateButton(TITAN_PH_ID);		
end

function TitanPanelPetHappinessButton_OnClick(button)

end

function TitanPanelPetHappinessButton_GetButtonText(id)
	local button, id = TitanUtils_GetButton(id, true);
	local petHapiness, petDMGPercent, petLoyaltyrate;
	local returnText;

	petHappiness, petDMGPercent, petLoyaltyrate = GetPetHappiness();

	if (petHappiness == 1) then
		returnText = "Pet: "..TitanUtils_GetColoredText("Unhappy", RED_FONT_COLOR);
	elseif (petHappiness == 2) then
		returnText = "Pet: "..TitanUtils_GetColoredText("Content", NORMAL_FONT_COLOR);
	elseif (petHappiness == 3) then
		returnText = "Pet: "..TitanUtils_GetColoredText("Happy", GREEN_FONT_COLOR);
	else
		returnText = "Pet: "..TitanUtils_GetHighlightText("No Pet");
	end

	if TitanPanelPetHappiness_CheckFeeding() == true and TitanGetVar(TITAN_PH_ID, "ShowFeeding") then
		returnText = returnText.." "..TitanUtils_GetHighlightText("(Feeding)");
	end

	return returnText;
end

function TitanPanelPetHappinessButton_GetTooltipText()
	local petHapiness, petDMGPercent, petLoyaltyrate;

	petHappiness, petDMGPercent, petLoyaltyrate = GetPetHappiness();

	if (petHappiness == 1) then
		toolTip = "Your pet is currently "..TitanUtils_GetColoredText("unhappy", RED_FONT_COLOR).." and is loosing loyalty.\nWhen unhappy your pet can only do 75% damage";
	elseif (petHappiness == 2) then
		toolTip = "Your pet is currently "..TitanUtils_GetColoredText("content", NORMAL_FONT_COLOR).." and is gaining loyalty.\nWhen content your pet does 100% damage";
	elseif (petHappiness == 3) then
		toolTip = "Your pet is currently "..TitanUtils_GetColoredText("happy", GREEN_FONT_COLOR).." and is gaining loyalty.\nWhen happy, your pet does 125% damage";
	else
		toolTip = "You do not have an active pet.";
	end

	return toolTip;
end

function TitanPanelPetHappiness_CheckFeeding()
	local i = 1;
	local buff;
	buff = UnitBuff("pet", i);
	while buff do
		if ( string.find(buff, "Ability_Hunter_BeastTraining") ) then
			return true;
		end
		i = i + 1;
		buff = UnitBuff("pet", i);
	end
	return false;
end

function TitanPanelRightClickMenu_PreparePetHappinessMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_PH_ID].menuText);
	TitanPanelRightClickMenu_AddSpacer();

	local info = {};
	info.text = "Show feeding status";
	info.func = TitanPanelPetHappinessButton_ToggleFeeding;
	info.checked = TitanGetVar(TITAN_PH_ID, "ShowFeeding");
	UIDropDownMenu_AddButton(info);
	
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_BAG_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

function TitanPanelPetHappinessButton_ToggleFeeding()
	TitanToggleVar(TITAN_PH_ID, "ShowFeeding");
	TitanPanelButton_UpdateButton(TITAN_PH_ID);
end