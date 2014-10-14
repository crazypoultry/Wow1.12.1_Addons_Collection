
  RareTrackerStandard = {
    version = "1.5.3",
    supportedbuild = "11000",
    lastupdate = "April 19, 2006",
    author = "Silent",
    email = "silentaddons@gmail.com",
    name = "RareTracker",
    frame = "RareTrackerFrame",
    cmd = "/raretracker",
    events = {
      "VARIABLES_LOADED",
      "ZONE_CHANGED_NEW_AREA",
      "ZONE_CHANGED",
    },
    help = {
      ["about"] = "$v/fs about$ev: Displays infomation about this addon.",
    },
  }


  -- addon initialization and screen output
  --------------------------------------------------------------------------------

  function RareTrackerStandard:Initialize()

    local coreName = "TNE_RareTrackerCore"
    UIParentLoadAddOn(coreName)

    TNEUtils.RegisterEvents(RareTrackerStandard.frame, RareTrackerStandard.events)
    RareTracker:RegisterForNotification("RareTrackerFrame_OnEvent")

  end

  function RareTrackerStandard:UpdateDisplay()

    local zone, subZone = self:GetDisplayText()
    RareTrackerFrameZone1:SetText(format(RARETRACKER_FRAME_ZONE, zone))
    if (subZone) then
      RareTrackerFrameZone2:SetText(format(RARETRACKER_FRAME_SUBZONE, subZone))
      RareTrackerFrameZone2:Show()
    else
      RareTrackerFrameZone2:Hide()
    end

  end

  function RareTrackerStandard:GetDisplayText()
    
    local mobs = RareTracker:GetZone(GetRealZoneText())
    local submobs = RareTracker:GetZone(GetRealZoneText(), GetSubZoneText())
  
    return TNEUtils.TableLength(mobs) or "0", TNEUtils.TableLength(submobs)
  
  end


  -- dropdown menu and settings
  --------------------------------------------------------------------------------

  function RareTrackerStandard:SetDropDownMenu()

    --local anchor = RareTrackerStandard.frame
    local anchor = "cursor"
    local menu = getglobal(RareTrackerStandard.frame.. "Menu")
    local initializer = function(n)
      for index, item in TNE_RTS_MENU_ITEMS do

        local info = {}
        info.text, info.tooltipTitle, info.tooltipText, info.func, info.checked = unpack(item)

        if (info.func and info.checked) then
          -- both variable and function means it's a toggle
          info.checked = getglobal(info.checked) -- it gets unpacked as a string
          info.keepShownOnClick = true
        elseif (info.func) then
          -- just a function means it's an action -- add special settings for actions here if needed later
        else
          -- it's a static header otherwise
          info.checked, info.isTitle, info.notClickable, info.notCheckable = false, true, true, true
        end

        UIDropDownMenu_AddButton(info)

      end

      local info = { func = function() RareTrackerFrameMenu:Hide() end, text = "Hide menu", tooltipTitle = "Hide menu", tooltipText = "Hides this menu. Changes will be saved regardless of how you close the menu." }
      UIDropDownMenu_AddButton(info)

    end

    UIDropDownMenu_Initialize(menu, initializer, "MENU")
    ToggleDropDownMenu(1, nil, menu, anchor, 0, 0)

    --menu.oldUberTooltipValue = GetCVar("UberTooltips")
    --SetCVar("UberTooltips", 1)
    menu.oldShowNewbieTips = SHOW_NEWBIE_TIPS
    SHOW_NEWBIE_TIPS = "1"

  end


  -- tooltip and reporting functions
  --------------------------------------------------------------------------------

  function RareTrackerStandard:HideTooltip()

    TNETooltip.Release()

  end

  function RareTrackerStandard:ShowTooltip()

    local frame = getglobal(RareTrackerStandard.frame)

    TNETooltip.Release() -- reset and reposition
    if (TNE_RareTrackerStandard_UseDefaultTooltip) then
      GameTooltip_SetDefaultAnchor(GameTooltip, frame)
    else
      TNETooltip.AnchorTo(frame)
    end

    TNETooltip.SetHeader(RareTrackerStandard.name) -- RareTracker header
    if (TNE_RareTrackerStandard_SortBySubzone) then
      self:AddSortedZoneToTooltip(GetRealZoneText())
    else
      self:AddZoneToTooltip(RARETRACKER_TOOLTIP_MOBS_KNOWN_IN_ZONE, GetRealZoneText())
      self:AddZoneToTooltip(RARETRACKER_TOOLTIP_MOBS_KNOWN_IN_SUB_ZONE, GetRealZoneText(), GetSubZoneText())
    end
    GameTooltip:Show()
    if (not TNE_RareTrackerStandard_UseDefaultTooltip) then
      TNETooltip.KeepOnScreen(frame)
    end
  end

  function RareTrackerStandard:AddSortedZoneToTooltip(zone)

    local num, mobs = RareTracker:GetSortedZoneData(zone)
  
    if (num == 0) then --  no mobs
      TNETooltip.Add(format(RARETRACKER_TOOLTIP_NO_KNOWN_MOBS, zone))
      return
    end

    --TNETooltip.Add(format(RARETRACKER_TOOLTIP_MOBS_KNOWN_IN_ZONE, num, zone), RARETRACKER_TOOLTIP_SEEN_AT)

    -- add all mobs in the zone
    for subZone, data in mobs do
      if (not (subZone == "")) then
        TNETooltip.Add(format(RARETRACKER_TOOLTIP_MOBS_KNOWN_IN_SUB_ZONE_ONLY, subZone))
        for name, mob in data do
          local name, stats, coords = unpack(mob)
          TNETooltip.Add(format(RARETRACKER_TOOLTIP_MOB, TNEUtils.ApplyColorTags("$v"..name.."$ev", "normal"), stats), coords)
        end
      end
    end

    if (table.getn(mobs[""]) > 0) then
      TNETooltip.Add(RARETRACKER_TOOLTIP_MOBS_KNOWN_IN_UNKNOWN)
      for name, mob in mobs[""] do
        local name, stats, coords = unpack(mob)
        TNETooltip.Add(format(RARETRACKER_TOOLTIP_MOB, TNEUtils.ApplyColorTags("$v"..name.."$ev", "normal"), stats), coords)
      end
    end

  end

  function RareTrackerStandard:AddZoneToTooltip(header, zone, subZone)

    local mobs = RareTracker:GetZone(zone, subZone)
    local num = TNEUtils.TableLength(mobs)
  
    if (num == 0) then --  no mobs
      if (not subZone) then -- add line only if we're adding an empty zone
        TNETooltip.Add(format(RARETRACKER_TOOLTIP_NO_KNOWN_MOBS, zone))
      end
      return
    end
  
    local details = zone
    if (subZone) then -- add some space before we add a subzone
      TNETooltip.Add() -- no args gives a blank line
      details = subZone
    end
    TNETooltip.Add(format(header, num, details), RARETRACKER_TOOLTIP_SEEN_AT)

    -- add all mobs in the zone
    for key, data in mobs do
      local name, stats, coords = unpack(data)
      TNETooltip.Add(format(RARETRACKER_TOOLTIP_MOB, TNEUtils.ApplyColorTags("$v"..name.."$ev", "normal"), stats), coords)
    end
  
  end


  -- frame scripts
  --------------------------------------------------------------------------------

  function RareTrackerFrame_OnLoad()

    RareTrackerFrameTitle:SetText("Rares: ")
    RareTrackerFrameZone1:SetText("0")
    RareTrackerFrameZone2:SetText("0")
    this:SetBackdropColor(0.5, 0.5, 0.5, 0.5)
    this:SetBackdropBorderColor(0.5, 0.5, 0.5)

    this:RegisterForDrag("LeftButton")
    this:RegisterForClicks("LeftButtonUp", "RightButtonUp");

    TNE_RareTrackerStandard_Locked = false
    TNE_RareTrackerStandard_UseDefaultTooltip = true
    TNE_RareTrackerStandard_SortBySubzone = false

    RareTrackerStandard:Initialize()

  end

  function RareTrackerFrame_OnEvent()
    if (event == "ZONE_CHANGED_NEW_AREA") then
      SetMapToCurrentZone() -- attempt to fix some issues with 0,0 coordinates in 1.10
    end
    RareTrackerStandard:UpdateDisplay()
  end

  function RareTrackerFrame_OnEnter()
    RareTrackerStandard:ShowTooltip()
  end
  
  function RareTrackerFrame_OnLeave()
    RareTrackerStandard:HideTooltip()
  end

  function RareTrackerFrame_OnClick(arg1)
    HideDropDownMenu(1)
    if (arg1 == "RightButton") then
      RareTrackerStandard:SetDropDownMenu()
      RareTrackerFrame_OnLeave()
    else
      PlaySound("igMiniMapZoomIn")
      RareTracker:Scan()
    end
  end

  function RareTrackerFrame_OnDragStart()
    if (not TNE_RareTrackerStandard_Locked) then
      this:StartMoving()
      HideDropDownMenu(1)
      RareTrackerFrame_OnLeave()
    end
  end

  function RareTrackerFrame_OnDragStop()
    this:StopMovingOrSizing()
    RareTrackerFrame_OnEnter()
  end

  function RareTrackerFrame_OnShow()
    RareTrackerStandard:UpdateDisplay()
  end
