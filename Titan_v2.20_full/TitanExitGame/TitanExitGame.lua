TITAN_EXITGAME_ID = "ExitGame";

function TitanPanelExitGameButton_OnLoad()
	this.registry = {
		id = TITAN_EXITGAME_ID,
		menuText = TITAN_EXITGAME_MENU_TEXT, 
		tooltipTitle = TITAN_EXITGAME_TOOLTIP, 
		tooltipTextFunction = "TitanPanelExitGameButton_GetTooltipText", 
		icon = TITANEXITGAME_ARTWORK_PATH.."ExitButton",
		iconWidth = 16};
		tinsert(UISpecialFrames,"LogoutFrame");
end

function TitanPanelExitGameButton_GetTooltipText()
	return ""..
		TitanUtils_GetGreenText(TITAN_EXITGAME_TOOLTIP_HINT1);
end

function TitanPanelExitGameButton_OnClick(button)
	if ( button == "LeftButton" ) then
		LogoutFrame:Show();
	else
		ForceQuit();
	end
end

function TitanPanelRightClickMenu_PrepareExitGameMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_EXITGAME_ID].menuText);
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_EXITGAME_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end