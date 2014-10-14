-- Plug-in for Titan Panel to show your current Inn Hearth.

TITAN_INN_FREQUENCY=10;

-- Version information
local TitanInnName = "TitanInn";
local TitanInnVersion = "1.3.4";

function TitanPanelInnButton_OnLoad()
	this.registry={
		id="Inn",
		menuText=TITAN_INN_MENU_TEXT,
		buttonTextFunction="TitanPanelInnButton_GetButtonText",
		tooltipTitle = TITAN_INN_TOOLTIP,
		tooltipTextFunction = "TitanPanelInnButton_GetTooltipText",
		frequency=TITAN_INN_FREQUENCY,
		savedVariables = {
			ShowLabelText = 1,
		}
	}
end

function TitanPanelInnButton_OnEvent()

	TitanPanelButton_UpdateButton("Inn");
	TitanPanelButton_UpdateTooltip();
        
end

function TitanPanelInnButton_GetButtonText(id)
	local buttontext = "";
	local inn=GetBindLocation()
	buttontext = format(TITAN_INN_BUTTON_TEXT,TitanUtils_GetHighlightText(inn))

	-- supports turning off labels
	return TITAN_INN_BUTTON_LABEL, buttontext;
end

function TitanPanelInnButton_GetTooltipText()
	local inn=GetBindLocation()
	return format(TITAN_INN_TOOLTIP_INN,TitanUtils_GetHighlightText(inn))
end

function TitanPanelRightClickMenu_PrepareInnMenu()
	local id="Inn"
	local info
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[id].menuText)

	TitanPanelRightClickMenu_AddSpacer();

	TitanPanelRightClickMenu_AddToggleLabelText("Inn");

	TitanPanelRightClickMenu_AddSpacer();

	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_CUSTOMIZE..TITAN_PANEL_MENU_POPUP_IND,id,TITAN_PANEL_MENU_FUNC_CUSTOMIZE)
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE,id,TITAN_PANEL_MENU_FUNC_HIDE)
end