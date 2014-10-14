-- Minimap Button Handling

FishingBuddy.UseButtonHole = function()
   if ( ButtonHole and FishingBuddy.GetSetting("UseButtonHole") == 1 ) then
      return true;
   else
      return false;
   end
end

FishingBuddy.Minimap = {};

FishingBuddy.Minimap.OnLoad = function()
   this:RegisterEvent("VARIABLES_LOADED");
end

FishingBuddy.Minimap.OnEvent = function()
   if ( FishingBuddy.UseButtonHole() ) then
      local info = {};
      info.id=FBConstants.ID;
      info.name=FBConstants.NAME;
      info.tooltip=FBConstants.DESCRIPTION;
      info.buttonFrame="FishingBuddyMinimapFrame";
      info.updateFunction="FishingBuddyMinimapButton_MoveButton";
      ButtonHole.application.RegisterMod(info);
   elseif ( ButtonHole ) then
      -- hack, hack, hack
      local playerName = UnitName("player");
      if ( ButtonHoleConfig[playerName] and
	   ButtonHoleConfig[playerName].visibleMod == FBConstants.ID ) then
	 ButtonHoleConfig[playerName].visibleMod = nil;
      end
   end
end

FishingBuddy.Minimap.Button_OnLoad = function()
   this:SetFrameLevel(this:GetFrameLevel()+1)
   this:RegisterForDrag("LeftButton");
   this:RegisterForClicks("LeftButtonUp", "RightButtonUp");
   this:RegisterEvent("VARIABLES_LOADED");
end

FishingBuddy.Minimap.Button_OnClick = function(button)
   if ( button == "RightButton" ) then
      if ( IsAltKeyDown() ) then
	 ToggleFishingBuddyFrame("FishingOptionsFrame");
      else
	 -- Toggle menu
	 local menu = getglobal("FishingBuddyMinimapMenu");
	 menu.point = "TOPRIGHT";
	 menu.relativePoint = "CENTER";
	 ToggleDropDownMenu(1, nil, menu, "FishingBuddyMinimapButton", 0, 0);
      end
   elseif ( FishingBuddy.IsSwitchClick("MinimapClickToSwitch") ) then
      FishingBuddy.Command(FBConstants.SWITCH);
   else
      FishingBuddy.Command("");
   end
end

local function BeingDragged()
   -- Thanks to Gello for this code
   local xpos,ypos = GetCursorPosition();
   local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom();

   xpos = xmin-xpos/UIParent:GetScale()+80;
   ypos = ypos/UIParent:GetScale()-ymin-80;

   local ang = math.deg(math.atan2(ypos,xpos));
   if ( ang < 0 ) then
      ang = ang + 360;
   end
   FishingBuddy.SetSetting("MinimapButtonPosition", ang);
   FishingBuddyMinimapButton_MoveButton();
end

FishingBuddy.Minimap.Button_OnDragStart = function(button)
   this:SetScript("OnUpdate", BeingDragged);
end

FishingBuddy.Minimap.Button_OnDragStop = function(button)
   this:SetScript("OnUpdate", nil);
end

FishingBuddyMinimapButton_MoveButton = function()
   if ( FishingBuddy.IsLoaded() ) then
      local where = FishingBuddy.GetSetting("MinimapButtonPosition");
      FishingBuddyMinimapFrame:ClearAllPoints();
      FishingBuddyMinimapFrame:SetPoint("TOPLEFT", "Minimap", "TOPLEFT",
					 52 - (80 * cos(where)),
					 (80 * sin(where)) - 52);
   end
end

FishingBuddy.UpdateMinimap = function()
   FishingBuddyMinimapButton_MoveButton();
   if ( FishingBuddy.GetSetting("MinimapButtonVisible") == 1 and
        Minimap:IsVisible() ) then
      FishingBuddyMinimapButton:EnableMouse(true);
      FishingBuddyMinimapButton:Show();
      FishingBuddyMinimapFrame:Show();
   else
      FishingBuddyMinimapButton:EnableMouse(false);
      FishingBuddyMinimapButton:Hide();
      FishingBuddyMinimapFrame:Hide();
   end
end

FishingBuddy.Minimap.Button_OnEvent = function()
   FishingBuddy.UpdateMinimap();
end

FishingBuddy.Minimap.Button_OnEnter = function()
   if ( GameTooltip.fbmmbfinished ) then
      return;
   end
   if ( FishingBuddy.GetSetting("UseButtonHole") == 0 ) then
      GameTooltip.fbmmbfinished = 1;
      GameTooltip:SetOwner(FishingBuddyMinimapFrame, "ANCHOR_LEFT");
      GameTooltip:AddLine(FBConstants.NAME);
      local text = FishingBuddy.TooltipBody("MinimapClickToSwitch");
      GameTooltip:AddLine(text,.8,.8,.8,1);
      GameTooltip:Show();
   end
end

FishingBuddy.Minimap.Button_OnLeave = function()
   GameTooltip:Hide();
   GameTooltip.fbmmbfinished = nil;
end

function FishingBuddy_ToggleMinimap()
   FishingBuddy.SavedToggleMinimap();
   FishingBuddy.UpdateMinimap();
end

FishingBuddy.Minimap.Menu_Initialize = function()
   FishingBuddy.MakeDropDown(FBConstants.CLICKTOSWITCH_ONOFF,
		"MinimapClickToSwitch");
end

