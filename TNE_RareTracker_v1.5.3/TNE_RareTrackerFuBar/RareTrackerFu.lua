  
RareTrackerFu = FuBarPlugin:new({
  name          = "FuBar - RareTracker",
  description   = RareTrackerFuLocals.DESCRIPTION,
  version       = "1.5.3",
  releaseDate   = "2006-04-19",
  aceCompatible = 103,
  fuCompatible  = 10000,
  author        = "Silent",
  email         = "silentaddons@gmail.com",
  website       = "http://www.curse-gaming.com/mod.php?addid=3415",
  category      = "others",
  db            = AceDatabase:new("RareTrackerFuDB"),
  defaults      = {
    sortBySubzone = false,
  },
  cmd           = AceChatCmd:new(RareTrackerFuLocals.COMMANDS, RareTrackerFuLocals.CMD_OPTIONS),
  loc           = RareTrackerFuLocals,
  hasIcon       = false,
  showOnRight   = false,
 
  -- addon loading and initialization
  --------------------------------------------------------------------------------

  Initialize = function(self)

    self.GetOpt = function(var) local v=self.db:get(self.profilePath, var) return v end
    self.TogOpt = function(var) return self.db:toggle(self.profilePath, var) end
    UIParentLoadAddOn("TNE_RareTrackerCore")
    RareTracker:RegisterForNotification("RareTrackerFu_OnRareFound")

  end,

  Enable = function(self)

    RareTrackerFu:RegisterEvent("ZONE_CHANGED_NEW_AREA", "UpdateText")
    RareTrackerFu:RegisterEvent("ZONE_CHANGED", "UpdateText")

  end,

  MenuSettings = function(self, level, value)
    if (level == 1) then
      UIDropDownMenu_AddButton({
        text = RareTrackerFuLocals.MENU_SCAN,
        func = function()
          RareTracker:Scan();
        end,
        checked = nil
      })
      UIDropDownMenu_AddButton({
        text = RareTrackerFuLocals.MENU_AUTOTARGET,
        func = function()
          TNE_RareTrackerCore_AutoTarget = not TNE_RareTrackerCore_AutoTarget;
        end,
        checked = TNE_RareTrackerCore_AutoTarget
      })
      UIDropDownMenu_AddButton({
        text = RareTrackerFuLocals.MENU_SORT_BY_SUBZONE,
        func = function()
          self.TogOpt("sortBySubzone")
        end,
        checked = self.GetOpt("sortBySubzone")
      })
  
      for index, item in TNE_RTFUBAR_MENU_ITEMS do
  
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
  end,

  UpdateText = function(self)

    local mobs = RareTracker:GetZone(GetRealZoneText())
    local submobs = RareTracker:GetZone(GetRealZoneText(), GetSubZoneText())
    local inZone, inSubZone = TNEUtils.TableLength(mobs) or "0", TNEUtils.TableLength(submobs)
    if (inSubZone) then
      self:SetText(format(RareTrackerFuLocals.DISPLAY_SUBZONE, inZone, inSubZone))
    else
      self:SetText(format(RareTrackerFuLocals.DISPLAY_ZONE, inZone))
    end

  end,

  -- tooltip and reporting functions
  --------------------------------------------------------------------------------

  UpdateTooltip = function(self)
    if (self.GetOpt("sortBySubzone")) then
      self:AddSortedZoneToTooltip(GetRealZoneText())
    else
      self:AddZoneToTooltip(RareTrackerFuLocals.TOOLTIP_MOBS_KNOWN_IN_ZONE, GetRealZoneText())
      self:AddZoneToTooltip(RareTrackerFuLocals.TOOLTIP_MOBS_KNOWN_IN_SUB_ZONE, GetRealZoneText(), GetSubZoneText())
    end
    self.tooltip:SetHint(RareTrackerFuLocals.TOOLTIP_HINT)
  end,

  AddZoneToTooltip = function(self, header, zone, subZone)

    local mobs = RareTracker:GetZone(zone, subZone)
    local num = TNEUtils.TableLength(mobs)

    if (num == 0) then --  no mobs
      if (not subZone) then -- add line only if we're adding an empty zone
        self.tooltip:AddLine(nil, format(RareTrackerFuLocals.TOOLTIP_NO_KNOWN_MOBS, zone), 1, 1, 1)
      end
      return
    end

    if (subZone) then -- add some space before we add a subzone
      self.tooltip:AddBlankLine(nil)
    end
    self.tooltip:AddDoubleLine(nil, format(header, num, zone), RareTrackerFuLocals.TOOLTIP_SEEN_AT, 1, 1, 1, 1, 1, 1)

    for key, data in mobs do
      local name, stats, coords = unpack(data)
      self.tooltip:AddDoubleLine(nil, format(RareTrackerFuLocals.TOOLTIP_MOB, name, FuBarUtils.White(stats)), format(RareTrackerFuLocals.TOOLTIP_COORDS, coords), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1, 1, 1)
    end
  
  end,

  AddSortedZoneToTooltip = function(self, zone)

    local num, mobs = RareTracker:GetSortedZoneData(zone)
  
    if (num == 0) then --  no mobs
      self.tooltip:AddLine(nil, format(RareTrackerFuLocals.TOOLTIP_NO_KNOWN_MOBS, zone), 1, 1, 1)
      return
    end

    -- add all mobs in the zone
    for subZone, data in mobs do
      if (not (subZone == "")) then
        self.tooltip:AddLine(nil, format(RareTrackerFuLocals.TOOLTIP_MOBS_KNOWN_IN_SUB_ZONE_ONLY, subZone), 1, 1, 1)
        for name, mob in data do
          local name, stats, coords = unpack(mob)
          self.tooltip:AddDoubleLine(nil, format(RareTrackerFuLocals.TOOLTIP_MOB, name, FuBarUtils.White(stats)), coords, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b  , 1, 1, 1)
        end
      end
    end

    if (table.getn(mobs[""]) > 0) then
      self.tooltip:AddLine(nil, RareTrackerFuLocals.TOOLTIP_MOBS_KNOWN_IN_UNKNOWN, 1, 1, 1)
      for name, mob in mobs[""] do
        local name, stats, coords = unpack(mob)
        self.tooltip:AddDoubleLine(nil, format(RareTrackerFuLocals.TOOLTIP_MOB, name, FuBarUtils.White(stats)), coords, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b  , 1, 1, 1)
      end
    end

  end,

  OnClick = function(self)
    RareTracker:Scan()
  end,

  })

  RareTrackerFu:RegisterForLoad()

  function RareTrackerFu_OnRareFound()
    RareTrackerFu:UpdateText()
  end