-- Titan Panel support

FB_Titan = {};

FB_Titan.OnLoad = function()
   if not TitanPanelButton_UpdateButton then
      return;
   end

   this.registry = {
      id = FBConstants.ID,
      menuText = FBConstants.NAME,
      version = FBConstants.VERSION,
      category = "Profession",
      icon = "Interface\\AddOns\\FishingBuddy\\Icons\\Fishing-Icon",
      iconWidth = 16,
      tooltipTitle = FBConstants.NAME,
      tooltipTextFunction = "TitanPanelFishingBuddyButton_GetTooltipText",
      savedVariables = {
	     ShowIcon = 1,
      }
   };	

   this:RegisterEvent("PLAYER_ENTERING_WORLD");
end

FB_Titan.OnClick = function(button)
   if ( button == "LeftButton" ) then
      if ( FishingBuddy.IsSwitchClick() ) then
	 FishingBuddy.Command(FBConstants.SWITCH);
      else
	 FishingBuddy.Command("");
      end
   end
end

FB_Titan.OnEvent = function()
   if TitanPanelButton_UpdateButton then
      TitanPanelButton_UpdateButton(FBConstants.ID);	
      TitanPanelButton_UpdateTooltip();
   end
end

function TitanPanelFishingBuddyButton_GetTooltipText()
   return FishingBuddy.TooltipBody("ClickToSwitch");
end

function TitanPanelRightClickMenu_PrepareFishingBuddyMenu()
   TitanPanelRightClickMenu_AddTitle(TitanPlugins[FBConstants.ID].menuText);

   FishingBuddy.MakeDropDown(FBConstants.CLICKTOSWITCH_ONOFF, "ClickToSwitch");

   TitanPanelRightClickMenu_AddSpacer();	
   TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE,
				       FBConstants.ID,
				       TITAN_PANEL_MENU_FUNC_HIDE);
end

