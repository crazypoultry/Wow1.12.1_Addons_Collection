TITAN_FSSWITCH_ID = "FSSwitch";
TITAN_FSSWITCH_MENU_TEXT = "FSSwitch";
TITAN_FSSWITCH_TOOLTIP_WND = "Switch to Fullscreen";
TITAN_FSSWITCH_TOOLTIP_FS = "Switch to windowed";
TITAN_FSSWITCH_ARTWORK_PATH = "Interface\\AddOns\\TitanFSSwitch\\";

function TitanPanelFSSwitchButton_OnLoad()
	this.registry = {
		id = TITAN_FSSWITCH_ID,
		builtIn = 1,
		menuText = TITAN_FSSWITCH_MENU_TEXT, 
		tooltipTitle = TITAN_FSSWITCH_TOOLTIP, 
	};
end

function TitanPanelFSSwitchButton_OnShow()
	TitanPanelFSSwitchButton_SetIcon();
end

function TitanPanelFSSwitchButton_OnClick(button)
	if (button == "LeftButton") then
		if(GetCVar("gxWindow") == "1") then
		
			SetCVar("gxWindow",0) ;
		else	
			SetCVar("gxWindow",1) ;
		end
		RestartGx();
		TitanPanelFSSwitchButton_SetIcon()
	end
end

function TitanPanelFSSwitchButton_SetIcon()
	local icon = TitanPanelFSSwitchButtonIcon;
	if (GetCVar("gxWindow") == "0") then
		icon:SetTexture(TITAN_FSSWITCH_ARTWORK_PATH.."TitanFSSwitchFS");
		TitanPlugins[TITAN_FSSWITCH_ID].tooltipTitle = TITAN_FSSWITCH_TOOLTIP_FS;
	else
		icon:SetTexture(TITAN_FSSWITCH_ARTWORK_PATH.."TitanFSSwitchWND");
		TitanPlugins[TITAN_FSSWITCH_ID].tooltipTitle = TITAN_FSSWITCH_TOOLTIP_WND;
	end	
end

function TitanPanelRightClickMenu_PrepareFSSwitchMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_FSSWITCH_ID].menuText);
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_FSSWITCH_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end
