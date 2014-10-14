local ICON_SPELL=         "Interface\\Icons\\Spell_Shadow_Twilight";

local updateTimer=        0;      -- update interval timer
local blinkState=         nil;    -- array containing Ritual of Summoning actionbuttons
local cacheRitualAction=  0;      -- cached action ID for Ritual of Summoning
local realUseAction=      nil;    -- original UseAction function
local realSetAction=      nil;    -- original GameTooltip's SetAction function

-- return button-name(s) associated with action "id"
local function GetActionBlinkTargets(id)
  local barName= nil;
  local multiName= nil;
  local buttonID= 0;

  bottomLeftState, bottomRightState, sideRightState, sideRight2State = GetActionBarToggles();

  -- determine button id
  if (id > 0 and id <= 12) then
    buttonID= id;
    if (CURRENT_ACTIONBAR_PAGE == 1) then
      barName= "Action";
    end;

  elseif (id > 12 and id <= 24) then
    buttonID= id -12;
    if (CURRENT_ACTIONBAR_PAGE == 2) then
      barName= "Action";
    end;

  elseif (id > 24 and id <= 36) then
    buttonID= id -24;
    if (CURRENT_ACTIONBAR_PAGE == 3) then
      barName= "Action";
    end;
    if (sideRightState) then
      multiName= "MultiBarRight";
    end;

  elseif (id > 36 and id <= 48) then
    buttonID= id -36;
    if (CURRENT_ACTIONBAR_PAGE == 4) then
      barName= "Action";
    end;
    if (sideRight2State) then
      multiName= "MultiBarLeft";
    end;

  elseif (id > 48 and id <= 60) then
    buttonID= id -48;
    if (CURRENT_ACTIONBAR_PAGE == 5) then
      barName= "Action";
    end;
    if (bottomRightState) then
      multiName= "MultiBarBottomRight";
    end;

  elseif (id > 60 and id <= 72) then
    buttonID= id -60;
    if (CURRENT_ACTIONBAR_PAGE == 6) then
      barName= "Action";
    end;
    if (bottomLeftState) then
      multiName= "MultiBarBottomLeft";
    end;

  end;

  return buttonID, barName, multiName;
end;

-- find Ritual of Summoning action and cause it to blink (used when summons are requested)
local function BlinkRitual()
  -- if still buttons highlighted, remove highlight
  if (blinkState) then
    if (blinkState[1] and blinkState[1]:IsShown()) then
      blinkState[1]:Hide();
    end;
    if (blinkState[2] and blinkState[2]:IsShown()) then
      blinkState[2]:Hide();
    end;
    blinkState= nil;

  -- otherwise find the ritual and highlight it
  elseif (rsmSaved.enabled and rsmSaved.flashAction and rsm.GetNumPlayerQueued() > 0) then
    local ritualAction= 0;

    if (cacheRitualAction ~= 0 and GetActionTexture(cacheRitualAction) == ICON_SPELL) then
      ritualAction= cacheRitualAction;
    else
      for i= 72, 1, -1 do
        if (GetActionTexture(i) == ICON_SPELL) then
          ritualAction= i;
          break;
        end;
      end;
      cacheRitualAction= ritualAction;
    end;

    if (ritualAction ~= 0) then
      local buttonID, barName, multiName= GetActionBlinkTargets(ritualAction);

      blinkState= { };
      if (barName) then
        blinkState[1]= getglobal(barName.."Button"..buttonID.."Border");
      end;
      if (multiName) then
        blinkState[2]= getglobal(multiName.."Button"..buttonID.."Border");
      end;

      if (blinkState[1] and not blinkState[1]:IsShown()) then
        blinkState[1]:SetVertexColor(1.0, 0.4, 0, 1.0);
        blinkState[1]:Show();
      end;
      if (blinkState[2] and not blinkState[2]:IsShown()) then
        blinkState[2]:SetVertexColor(1.0, 0.4, 0, 1.0);
	      blinkState[2]:Show();
      end;
    end;

  end;
end;

-- close dropdownmenu
local function CloseActionMenu()
  DropDownList1:Hide();
end;

-- begin original blizzard DropDown function. Titan Panel overrides this one with it's own version on global scale and renders it incompatible for us
-- fixme: find better solution
local function BlizzardToggleDropDownMenu(level, value, dropDownFrame, anchorName, xOffset, yOffset)
	if ( not level ) then
		level = 1;
	end
	UIDROPDOWNMENU_MENU_LEVEL = level;
	UIDROPDOWNMENU_MENU_VALUE = value;
	local listFrame = getglobal("DropDownList"..level);
	local listFrameName = "DropDownList"..level;
	local tempFrame;
	local point, relativePoint, relativeTo;
	if ( not dropDownFrame ) then
		tempFrame = this:GetParent();
	else
		tempFrame = dropDownFrame;
	end
	if ( listFrame:IsVisible() and (UIDROPDOWNMENU_OPEN_MENU == tempFrame:GetName()) ) then
		listFrame:Hide();
	else
		-- Set the dropdownframe scale
		local uiScale = 1.0;
		if ( GetCVar("useUiScale") == "1" ) then
			if ( tempFrame ~= WorldMapContinentDropDown and tempFrame ~= WorldMapZoneDropDown ) then
				uiScale = tonumber(GetCVar("uiscale"));
			end
		end
		listFrame:SetScale(uiScale);
		
		-- Hide the listframe anyways since it is redrawn OnShow() 
		listFrame:Hide();
		
		-- Frame to anchor the dropdown menu to
		local anchorFrame;

		-- Display stuff
		-- Level specific stuff
		if ( level == 1 ) then
			if ( not dropDownFrame ) then
				dropDownFrame = this:GetParent();
			end
			UIDROPDOWNMENU_OPEN_MENU = dropDownFrame:GetName();
			listFrame:ClearAllPoints();
			-- If there's no specified anchorName then use left side of the dropdown menu
			if ( not anchorName ) then
				-- See if the anchor was set manually using setanchor
				if ( dropDownFrame.xOffset ) then
					xOffset = dropDownFrame.xOffset;
				end
				if ( dropDownFrame.yOffset ) then
					yOffset = dropDownFrame.yOffset;
				end
				if ( dropDownFrame.point ) then
					point = dropDownFrame.point;
				end
				if ( dropDownFrame.relativeTo ) then
					relativeTo = dropDownFrame.relativeTo;
				else
					relativeTo = UIDROPDOWNMENU_OPEN_MENU.."Left";
				end
				if ( dropDownFrame.relativePoint ) then
					relativePoint = dropDownFrame.relativePoint;
				end
			elseif ( anchorName == "cursor" ) then
				relativeTo = nil;
				local cursorX, cursorY = GetCursorPosition();
				cursorX = cursorX/uiScale;
				cursorY =  cursorY/uiScale;

				if ( not xOffset ) then
					xOffset = 0;
				end
				if ( not yOffset ) then
					yOffset = 0;
				end
				xOffset = cursorX + xOffset;
				yOffset = cursorY + yOffset;
			else
				relativeTo = anchorName;
			end
			if ( not xOffset or not yOffset ) then
				xOffset = 8;
				yOffset = 22;
			end
			if ( not point ) then
				point = "TOPLEFT";
			end
			if ( not relativePoint ) then
				relativePoint = "BOTTOMLEFT";
			end
			listFrame:SetPoint(point, relativeTo, relativePoint, xOffset, yOffset);
		else
			if ( not dropDownFrame ) then
				dropDownFrame = getglobal(UIDROPDOWNMENU_OPEN_MENU);
			end
			listFrame:ClearAllPoints();
			-- If this is a dropdown button, not the arrow anchor it to itself
			if ( strsub(this:GetParent():GetName(), 0,12) == "DropDownList" and strlen(this:GetParent():GetName()) == 13 ) then
				anchorFrame = this:GetName();
			else
				anchorFrame = this:GetParent():GetName();
			end
			listFrame:SetPoint("TOPLEFT", anchorFrame, "TOPRIGHT", 0, 0);
		end
		
		-- Change list box appearance depending on display mode
		if ( dropDownFrame and dropDownFrame.displayMode == "MENU" ) then
			getglobal(listFrameName.."Backdrop"):Hide();
			getglobal(listFrameName.."MenuBackdrop"):Show();
		else
			getglobal(listFrameName.."Backdrop"):Show();
			getglobal(listFrameName.."MenuBackdrop"):Hide();
		end

		UIDropDownMenu_Initialize(dropDownFrame, dropDownFrame.initialize, nil, level);
		-- If no items in the drop down don't show it
		if ( listFrame.numButtons == 0 ) then
			return;
		end

		-- Check to see if the dropdownlist is off the screen, if it is anchor it to the top of the dropdown button
		listFrame:Show();
		-- Hack since GetCenter() is returning coords relative to 1024x768
		local x, y = listFrame:GetCenter();
		-- Hack will fix this in next revision of dropdowns
		if ( not x or not y ) then
			listFrame:Hide();
			return;
		end
		-- Determine whether the menu is off the screen or not
		local offscreenY, offscreenX;
		if ( (y - listFrame:GetHeight()/2) < 0 ) then
			offscreenY = 1;
		end
		if ( listFrame:GetRight() > GetScreenWidth() ) then
			offscreenX = 1;	
		end
		
		--  If level 1 can only go off the bottom of the screen
		if ( level == 1 ) then
			if ( offscreenY and offscreenX ) then
				anchorPoint = "BOTTOMRIGHT";
				relativePoint = "BOTTOMLEFT";
			elseif ( offscreenY ) then
				anchorPoint = "BOTTOMLEFT";
				relativePoint = "TOPLEFT";
			elseif ( offscreenX ) then
				anchorPoint = "TOPRIGHT";
				relativePoint = "TOPLEFT";
			else
				anchorPoint = "TOPLEFT";
			end
			
			listFrame:ClearAllPoints();
			if ( anchorName == "cursor" ) then
				listFrame:SetPoint(anchorPoint, relativeTo, "BOTTOMLEFT", xOffset, yOffset);
			else
				listFrame:SetPoint(anchorPoint, relativeTo, relativePoint, xOffset, yOffset);
			end
		else
			local anchorPoint, relativePoint, offsetX, offsetY;
			if ( offscreenY and offscreenX ) then
				anchorPoint = "BOTTOMRIGHT";
				relativePoint = "BOTTOMLEFT";
				offsetX = -11;
				offsetY = -14;
			elseif ( offscreenY ) then
				anchorPoint = "BOTTOMLEFT";
				relativePoint = "BOTTOMRIGHT";
				offsetX = 0;
				offsetY = -14;
			elseif ( offscreenX ) then
				anchorPoint = "TOPRIGHT";
				relativePoint = "TOPLEFT";
				offsetX = -11;
				offsetY = 14;
			else
				anchorPoint = "TOPLEFT";
				relativePoint = "TOPRIGHT";
				offsetX = 0;
				offsetY = 14;
			end
			
			listFrame:ClearAllPoints();
			listFrame:SetPoint(anchorPoint, anchorFrame, relativePoint, offsetX, offsetY);
		end
	end
end
-- end original blizzard function


-- hook UseAction function to detect when the player is about to cast "Ritual of Summoning"
local function HookedUseAction(id, ex, onSelf, ...)
  -- return if addon disabled or drag and drop action taking place (cannot check for macro drag&drop)
  if (not rsmSaved.enabled or CursorHasItem() or CursorHasSpell()) then
    return realUseAction(id, ex, onSelf, unpack(arg));
  end;

  -- if it's the ritual, cast it, otherwise use default action
  local isMacro= (GetActionText(id) ~= nil);
  local texture= GetActionTexture(id);  
  if (texture == ICON_SPELL and not isMacro and not IsEquippedAction(id)) then

    -- if clicked with right mouse, show dropdown menu
    if (arg1 and arg1 == "RightButton") then
      local x, y= GetCursorPosition();
      GameTooltip:Hide();
      BlizzardToggleDropDownMenu(1, nil, RSM_DropDownMenu, "RSM_DropDownMenu", x, y);
      return;
    else
      CloseActionMenu();
      rsm.SummonAuto();
    end;

  else
    return realUseAction(id, ex, onSelf, unpack(arg));

  end;
end;

-- hook action tooltip to enhance "Ritual of Summoning" tooltip
local function HookedSetAction(self, id, ...)
  local rettab= { realSetAction(self, id, unpack(arg)) };

  if (rsmSaved.enabled) then
    local isMacro=    (GetActionText(id) ~= nil);
    local texture=    GetActionTexture(id);
    local queueCount= rsm.GetNumPlayerQueued();
    local queue;

    -- check if selected action is a ritual of summoning
    if (texture == ICON_SPELL and not isMacro and not IsEquippedAction(id)) then
      if (tonumber(GetCVar("UberTooltips")) == 1) then
        GameTooltipTextLeft5:SetText(RSM_SPELL_HELP.."\n\n");
      end;
    
      -- add queue information in a new line
      if (queueCount == 0) then
        queue= NORMAL_FONT_COLOR_CODE..RSM_SPELL_QUEUE_EMPTY..FONT_COLOR_CODE_CLOSE.."\n";
      else
        queue= NORMAL_FONT_COLOR_CODE..RSM_SPELL_QUEUE..FONT_COLOR_CODE_CLOSE;
        for i= 1, queueCount -1 do
          queue= queue..rsm.GetPlayerQueued(i)..", ";
        end;
        queue= queue..rsm.GetPlayerQueued(queueCount)..".";
      end;
      GameTooltip:AddLine(queue, 1.0, 1.0, 1.0, 1);
      GameTooltip:Show();
    end;
  end;

  return unpack(rettab);
end;

  
-- public interface
rsmActionButton= {

  -- called by RaidSummon.lua's OnLoad
  OnLoad= function()
    -- replace normal "Ritual of Summoning" with our improved version
    realUseAction=         UseAction;
    UseAction=             HookedUseAction;

    -- enhance the tooltip for the ritual
    realSetAction=         GameTooltip.SetAction;
    GameTooltip.SetAction= HookedSetAction;
  end;

  -- called by RaidSummon.lua's OnUpdate
  OnUpdate= function(elapsed)
    updateTimer= updateTimer +elapsed;

    if (updateTimer > 0.8) then
      updateTimer= 0;
      BlinkRitual();
    end;
  end;
    
  -- extend basemenu with action-specific entries
  BuildMenu= function()
    rsmDropdownMenu.BuildBaseMenu();
    if (UIDROPDOWNMENU_MENU_LEVEL == 1) then
      rsmDropdownMenu.AddToggle(RSM_MENU_FLASHING, true, rsmSaved.flashAction, rsmSettings.ToggleFlashing);
      rsmDropdownMenu.AddSpacer();
      rsmDropdownMenu.AddCommand(RSM_MENU_CLOSE, true, CloseActionMenu);
    end;
  end;  

}
