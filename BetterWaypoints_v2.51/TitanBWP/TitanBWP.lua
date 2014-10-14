BWP_ID= "BWP"
BWPMENU_Text = "Better Waypoints"
BWP_ICON 				= "Interface\\Addons\\BetterWaypoints\\Artwork\\Titan_Button"; --Location of Icon

function TitanPanelBWPButton_OnLoad()

  this.registry = {
    id = BWP_ID,
    menuText = BWPMENU_Text,
    tooltipTitle = BWP_BUTTON_TOOLTIP ,
    buttonTextFunction = "TitanPanelBetterWaypoints_GetButtonText",
	iconWidth = 16,
	icon = BWP_ICON,
	savedVariables = {
			ShowLabel = 1,		--Show Label will be stored between session
			ShowIcon = 1,	
	}
  };
end

function TitanPanelBetterWaypoints_GetButtonText()
	BWPTitanlabel = BWPgetnumpoints()
  return "BWP:",BWPTitanlabel;
end

function TitanPanelRightClickMenu_PrepareBWPMenu()
  
	BetterWaypointsFrameDropDown_Initialize()
	if(UIDROPDOWNMENU_MENU_LEVEL == 1 ) then
		TitanPanelRightClickMenu_AddSpacer()
		TitanPanelRightClickMenu_AddToggleLabelText(BWP_ID)
	end
end
function BWP_TITAN_OnEvent(event)
	
	if(event == "VARIABLES_LOADED") then
		TitanPanelBWPButton_OnLoad();
		TitanPanelButton_OnLoad();
	elseif(event == "WORLD_MAP_UPDATE") or (string.find(event,"ZONE")) then
	
		BetterWaypoints_Generate()
		TitanPanelButton_UpdateButton(BWP_ID)
	end
	
end

	