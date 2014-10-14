TITAN_RELOADUI_ID = "ReloadUI";

--
-- OnFunctions
--
function TitanPanelReloadUIButton_OnLoad()
	this.registry = { 
		id = TITAN_RELOADUI_ID,
		menuText = TITAN_RELOADUI_MENU_TEXT, 
		buttonTextFunction = "TitanPanelReloadUIButton_GetButtonText",
		tooltipTitle = TITAN_RELOADUI_TOOLTIP,
		tooltipTextFunction = "TitanPanelReloadUIButton_GetTooltipText",
		savedVariables = {
			ShowLabelText = 1,
		}
	};
end


function TitanPanelReloadUIButton_OnEvent()
	TitanPanelButton_UpdateButton(TITAN_RELOADUI_ID);	
	TitanPanelButton_UpdateTooltip();
end 

function TitanPanelReloadUIButton_OnClick(button)
	if (button == "LeftButton") then
		ReloadUI();
	end
end

--
-- Titan functions
--
function TitanPanelReloadUIButton_GetButtonText(id)
	local buttonRichText = "";
	return TITAN_RELOADUI_BUTTON_LABEL, buttonRichText;
end


function TitanPanelReloadUIButton_GetTooltipText()	
	local tooltipRichText = TitanUtils_GetGreenText(TITAN_RELOADUI_HINT_TEXT);
	return tooltipRichText;
end

--
-- create menus
--
function TitanPanelRightClickMenu_PrepareReloadUIMenu()

	local info = {};
	
	if ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) then		
		if ( UIDROPDOWNMENU_MENU_VALUE == "DisplayAbout" ) then
			info.text = TITAN_RELOADUI_ABOUT_POPUP_TEXT;
			info.value = "AboutTextPopUP";
			info.notClickable = 1;
			info.isTitle = 0;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		end
		return;
	end
	
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_RELOADUI_ID].menuText);

	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE,TITAN_RELOADUI_ID,TITAN_PANEL_MENU_FUNC_HIDE);

	-- info about plugin
	local info = {};
	info.text = TITAN_RELOADUI_ABOUT_TEXT;
	info.value = "DisplayAbout";
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info);
end