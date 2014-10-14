-- **************************************************************************
-- * TitanInventoryOnPar.lua
-- **************************************************************************

-- ************************** Constants *************************************
TITAN_INVENTORYONPAR_ID = "InventoryOnPar";
TITAN_INVENTORYONPAR_TOOLTIP = "InventoryOnPar Tooltip\n";
TITAN_INVENTORYONPAR_MENUTEXT = "Inventory On Par"
TITAN_INVENTORYONPAR_BUTTON_LABEL = "Par:"

-- ************************** Variables *******************************************
IOP_Score = 0;

-- ************************** Functions *******************************************

function TitanPanelInventoryOnParButton_OnLoad()
	this.registry = {
		id = TITAN_INVENTORYONPAR_ID,
		menuText = TITAN_INVENTORYONPAR_MENUTEXT,
		buttonTextFunction = "TitanPanelInventoryOnParButton_GetButtonText",
		tooltipTitle = TITAN_INVENTORYONPAR_TOOLTIP,
		tooltipTextFunction = "TitanPanelInventoryOnParButton_GetTooltipText",
		category = "Information",
		savedVariables = {
			ShowLabelText = 1,  -- Default to 1
		}
	};
	this:RegisterEvent("UNIT_INVENTORY_CHANGED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_LEVEL_UP");
end

function TitanPanelInventoryOnParButton_OnEvent()
	_, IOP_Score = IOP_GetItemLevels("player");
	TitanPanelButton_UpdateButton(TITAN_INVENTORYONPAR_ID);
	TitanPanelButton_UpdateTooltip();
end

function TitanPanelInventoryOnParButton_OnClick()
	ShowUIPanel(InventoryOnParUIFrame);
end


function TitanPanelInventoryOnParButton_GetButtonText(id)
	_ , IOP_Score = IOP_GetItemLevels("player");
	local countText = format("%.2f", IOP_Score);
	return TITAN_INVENTORYONPAR_BUTTON_LABEL, TitanUtils_GetHighlightText(countText);
end

function TitanPanelInventoryOnParButton_GetTooltipText()
	local tooltiptext, _ = IOP_GetItemLevels("player");
	return tooltiptext;
end

function TitanPanelRightClickMenu_PrepareInventoryOnParMenu()
	TitanPanelRightClickMenu_AddTitle(TITAN_INVENTORYONPAR_MENUTEXT);	
	TitanPanelRightClickMenu_AddSpacer();	
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_INVENTORYONPAR_ID);
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_INVENTORYONPAR_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end
