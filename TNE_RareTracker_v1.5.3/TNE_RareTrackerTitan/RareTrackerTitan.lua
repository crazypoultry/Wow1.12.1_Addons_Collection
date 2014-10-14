
  -- Titan functions
  --------------------------------------------------------------------------------

  function TitanPanelRareTrackerButton_OnLoad()
  
    this.registry = {
      id = "RareTracker",
      version = "1.5.3",
      menuText = "RareTracker", 
      tooltipTitle = "RareTracker", 
      category = "Information",
      buttonTextFunction = "RareTrackerTitan_GetDisplayText",
      tooltipTextFunction = "RareTrackerTitan_GetTooltip",
      frequency = 10,
      updateType = TITAN_PANEL_UPDATE_BUTTON,
      savedVariables = {
        ShowLabelText = 1,
      }
    }

    TNE_RTTITAN_SortBySubzone = false

    UIParentLoadAddOn("TNE_RareTrackerCore")

  end

  function TitanPanelRareTrackerButton_OnClick(button)
    if (button == "LeftButton") then
      RareTracker:Scan()
    end
  end

  function TitanPanelRightClickMenu_PrepareRareTrackerMenu() 
    TitanPanelRightClickMenu_AddTitle("RareTracker")
    RareTrackerTitan_AddMoreDropDownMenuOptions()
    TitanPanelRightClickMenu_AddSpacer()
    TitanPanelRightClickMenu_AddToggleLabelText("RareTracker")
    TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, "RareTracker", TITAN_PANEL_MENU_FUNC_HIDE)
    --TNE_RTTITAN_SHOW_NEWBIE_TIPS = SHOW_NEWBIE_TIPS
    --SHOW_NEWBIE_TIPS = "1"
  end

  function RareTrackerTitan_AddMoreDropDownMenuOptions()

    -- I added this 'hack' because TitanPanel's function for dropdown menus can't
    -- handle global variables. I need to access to the variables from the core

    for index, item in TNE_RTTITAN_MENU_ITEMS do

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

  end

  function RareTrackerTitan_GetTooltip()
    local tooltipText = ""
    if (TNE_RTTITAN_SortBySubzone) then
      tooltipText = tooltipText.. RareTrackerTitan_AddSortedZoneToTooltip(GetRealZoneText())
    else
      tooltipText = tooltipText.. RareTrackerTitan_AddZoneToTooltip(RT_MOBS_KNOWN_IN_ZONE, GetRealZoneText())
      tooltipText = tooltipText.. RareTrackerTitan_AddZoneToTooltip(RT_MOBS_KNOWN_IN_SUB_ZONE, GetRealZoneText(), GetSubZoneText())
    end
    tooltipText = tooltipText.. "\n".. TitanUtils_GetGreenText(RT_TOOLTIP_HINT)
    return tooltipText
  end

  function RareTrackerTitan_AddZoneToTooltip(header, zone, subZone)

    local text = ""

    local mobs = RareTracker:GetZone(zone, subZone)  
    local num = TNEUtils.TableLength(mobs)

    if (num == 0) then --  no mobs
      if (not subZone) then
        return format(RT_NO_MOBS_KNOWN_IN_ZONE, zone)
      end
      return text
    end

    local details = zone
    if (subZone) then -- change template if we add a subzone
      text = text.. "\n"
      if (not (subZone == "")) then
        details = subZone
      end
    end
    text = text.. TitanUtils_GetHighlightText(format(header, num, details, TitanUtils_GetHighlightText(RT_SEEN_AT)))
    text = text.. "\n"

    -- add all mobs in the zone
    for key, data in mobs do
      local name, stats, coords = unpack(data)
      local line = format(RT_TOOLTIP_LINE_MOB, name, TitanUtils_GetHighlightText(stats), coords)
      text = text.. line.. "\n"
    end

    return text 

  end

  function RareTrackerTitan_AddSortedZoneToTooltip(zone)

    local num, mobs = RareTracker:GetSortedZoneData(zone)
    local text = ""
  
    if (num == 0) then --  no mobs
      return format(RT_NO_MOBS_KNOWN_IN_ZONE, zone)
    end

    --TNETooltip.Add(format(RARETRACKER_TOOLTIP_MOBS_KNOWN_IN_ZONE, num, zone), RARETRACKER_TOOLTIP_SEEN_AT)

    -- add all mobs in the zone
    for subZone, data in mobs do
      if (not (subZone == "")) then
        text = text.. TitanUtils_GetHighlightText(format(RT_TOOLTIP_MOBS_KNOWN_IN_SUB_ZONE_ONLY, subZone)).. "\n"
        for name, mob in data do
          local name, stats, coords = unpack(mob)
          text = text.. format(RT_TOOLTIP_LINE_MOB, name, TitanUtils_GetHighlightText(stats), coords).. "\n"
        end
      end
    end

    if (table.getn(mobs[""]) > 0) then
      text = text.. TitanUtils_GetHighlightText(RT_TOOLTIP_MOBS_KNOWN_IN_UNKNOWN).. "\n"
      for name, mob in mobs[""] do
        local name, stats, coords = unpack(mob)
        text = text.. format(RT_TOOLTIP_LINE_MOB, name, TitanUtils_GetHighlightText(stats), coords).. "\n"
      end
    end

    return text

  end

  function RareTrackerTitan_GetDisplayText()

    local title = "Rares: "
    local mobs = RareTracker:GetZone(GetRealZoneText())
    local submobs = RareTracker:GetZone(GetRealZoneText(), GetSubZoneText())
  
    if (not TNEUtils.TableLength(submobs) == 0) then
      return title, format(RT_PANEL_TEMPLATE, TitanUtils_GetHighlightText(TNEUtils.TableLength(mobs)))
    else
      return title, format(RT_PANEL_TEMPLATE2, TitanUtils_GetHighlightText(TNEUtils.TableLength(mobs)), TitanUtils_GetHighlightText(TNEUtils.TableLength(submobs)))
    end

  
  end