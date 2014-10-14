TITAN_LOOTHOG_ID = "LootHog"
TITANLOOTHOG_MENUTEXT = "LootHog"
TITANLOOTHOG_TOOLTIP = "LootHog"
--TITAN_LOOTHOG_BUTTON_LABEL =  "LootHog: "
TITAN_LOOTHOG_BUTTON_LABEL =  ""
TITANLOOTHOG_ICON = "Interface\\Buttons\\UI-GroupLoot-Dice-Up"


function TitanPanelLootHogButton_OnLoad()

	if (TitanPlugins) then
		this.registry = {
			id = TITAN_LOOTHOG_ID,
			menuText = TITANLOOTHOG_MENUTEXT,
			buttonTextFunction = "TitanPanelLootHogButton_GetButtonText",
			tooltipTitle = TITANLOOTHOG_TOOLTIP,
			tooltipTextFunction = "TitanPanelLootHogButton_GetTooltipText",
			icon = TITANLOOTHOG_ICON,
			iconWidth = 16,
			frequency = 1,
			updateType = TITAN_PANEL_UPDATE_TOOLTIP, 
			savedVariables = {
				ShowIcon = 1,
				ShowLabelText = 1,
			}
		};
		TitanPanelButton_OnLoad();
	end
end

function TitanPanelLootHogButton_OnClick(button)
	if (( button == "LeftButton" ) and IsShiftKeyDown()) then
		loothog_countdown()
	elseif (( button == "LeftButton" ) and (IsControlKeyDown()) and (IsAltKeyDown()) ) then
		loothog_holdclicked()
	elseif (( button == "LeftButton" ) and (IsControlKeyDown()) ) then
		loothog_announce_winner()
		loothog_clear_clicked()
	elseif (( button == "LeftButton" ) and IsAltKeyDown()) then
		loothog_clear_clicked()
	elseif ( button ==  "LeftButton" ) then
		loothog_rollclicked()
	elseif (button == "RightButton") then
		loothog_toggle_visible()
	end
	TitanPanelButton_OnClick(arg1);
end

function TitanPanelLootHogButton_OnEvent()
end

function TitanPanelLootHogButton_OnUpdate(arg1)
	TitanPanelButton_UpdateTooltip();
	TitanPanelButton_UpdateButton(TITAN_LOOTHOG_ID)
end

function TitanPanelLootHogButton_UpdateText()
	TitanPanelButton_UpdateButton(TITAN_LOOTHOG_ID)
end

function TitanPanelLootHogButton_GetButtonText()
	local buttonText = loothog_getwinner();
	if (buttonText == "") then
		buttonText = TITAN_LOOTHOG_LABEL_NOROLLS
	end
	return TITAN_LOOTHOG_BUTTON_LABEL, buttonText;
end

function TitanPanelLootHogButton_GetTooltipText()
	local green = loothog_getrolls();
	local red = loothog_getnonrolls(); 
	local tooltipText = "\n" .. TitanUtils_GetGreenText(green) .. 
		"------------------------------\n" .. 
		TitanUtils_GetRedText(red) .. "\n" ..
		loothog_getstatus().. "\n" ..
		TitanUtils_GetNormalText(TITAN_LOOTHOG_TIP1) ..
		TITAN_LOOTHOG_TIP2 ..
		TITAN_LOOTHOG_TIP3 ..
		TITAN_LOOTHOG_TIP4 ..
		TITAN_LOOTHOG_TIP5 ..
		TITAN_LOOTHOG_TIP6;
		--tooltipText:SetFont("FRIZQT__.TTF",8)
	return tooltipText;
end

function TitanPanelRightClickMenu_PrepareLootHogMenu()
	-- Menu title
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_LOOTHOG_ID].menuText);	
	
	-- TitanPanelRightClickMenu_AddCommand() adds an entry in the menu which triggers a function when clicked
	TitanPanelRightClickMenu_AddCommand(TITAN_LOOTHOG_MENU_OPTIONS, TITAN_LOOTHOG_ID, "loothog_toggle_options");

	-- A blank line in the menu
	TitanPanelRightClickMenu_AddSpacer();	
	
	-- Generic function to toggle label text
	TitanPanelRightClickMenu_AddToggleIcon(TITAN_LOOTHOG_ID);
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_LOOTHOG_ID);
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_LOOTHOG_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end
