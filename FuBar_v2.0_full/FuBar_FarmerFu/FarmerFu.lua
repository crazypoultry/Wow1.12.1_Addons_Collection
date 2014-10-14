local compost = CompostLib:GetInstance("compost-1")
local dewdrop = DewdropLib:GetInstance("1.0")
local tablet = TabletLib:GetInstance("1.0")
local crayon = CrayonLib:GetInstance("1.0")
local sebags = SpecialEventsEmbed:GetInstance("Bags 1")

local locals = FarmerFuLocals
local const = {
  SORT_ITEM  = 1,
  SORT_COUNT = 2,
  SORT_ASC   = 1,
  SORT_DESC  = 2,
}

FarmerFu = FuBarPlugin:GetInstance("1.2"):new({
  name            = locals.Name,
  description     = locals.Description,
  version         = "2.0."..string.sub("$Revision: 1979 $", 12, -3),
  releaseDate     = string.sub("$Date: 2006-05-19 15:27:07 -0700 (Fri, 19 May 2006) $", 8, 17),
  aceCompatible   = 103,
  author          = "Aileen",
  email           = "aileen.wow@gmail.com",
  website         = "http://aileen.wowinterface.com/",
  category        = "inventory",
  db              = AceDatabase:new("FuBar_FarmerFuDB"),
  defaults        = DEFAULT_OPTIONS,
  charDefaults    = {
    items = {},
    sort  = {
      field = const.SORT_ITEM,
      direction = const.SORT_ASC,
    },
  },
  cmd             = AceChatCmd:new(locals.ChatCmd, locals.ChatOpt),
  hasIcon         = "Interface\\Icons\\Spell_Nature_Polymorph",
})

function FarmerFu:Enable()
  sebags:RegisterEvent(self, "SPECIAL_BAGSLOT_UPDATE", "UpdateItems")
  self:Hook("ContainerFrameItemButton_OnClick")

  self.itemData = compost:GetTable()
  self.counts = compost:GetTable()
  self:GetItemCounts()
end

function FarmerFu:Disable()
  sebags:UnregisterEvent(self, "SPECIAL_BAGSLOT_UPDATE")
end

function FarmerFu:MenuSettings(level, value)
  if level == 1 then
    dewdrop:AddLine(
      "text", locals.Menu.Monitor,
      "value", "monitor",
      "hasArrow", TRUE
    )
    dewdrop:AddLine(
      "text", locals.Menu.Remove,
      "value", "remove",
      "hasArrow", TRUE
    )
    dewdrop:AddLine()
    dewdrop:AddLine(
      "text", locals.Menu.Sort,
      "value", "sort",
      "hasArrow", TRUE
    )
  elseif level == 2 then
    if value == "monitor" then
      for item in pairs(self.charData.items) do
        dewdrop:AddLine(
          "text", item,
          "func", "MonitorItem",
          "arg1", self,
          "arg2", item,
          "checked", item == self.charData.monitor
        )
      end
    elseif value == "remove" then
      dewdrop:AddLine(
        "text", locals.Menu.AllItems,
        "func", "RemoveAllItems",
        "arg1", self
      )
      for item in pairs(self.charData.items) do
        dewdrop:AddLine(
          "text", item,
          "func", "RemoveItem",
          "arg1", self,
          "arg2", item
        )
      end
    elseif value == "sort" then
      dewdrop:AddLine(
        "text", locals.Menu.Field,
        "value", "field",
        "hasArrow", TRUE
      )
      dewdrop:AddLine(
        "text", locals.Menu.Direction,
        "value", "direction",
        "hasArrow", TRUE
      )
    end
  elseif level == 3 then
    if value == "field" then
      dewdrop:AddLine(
        "text", locals.Menu.ByItem,
        "func", "SetSortFieldItem",
        "arg1", self,
        "isRadio", TRUE,
        "checked", self:IsSortFieldItem()
      )
      dewdrop:AddLine(
        "text", locals.Menu.ByCount,
        "func", "SetSortFieldCount",
        "arg1", self,
        "isRadio", TRUE,
        "checked", self:IsSortFieldCount()
      )
    elseif value == "direction" then
      dewdrop:AddLine(
        "text", locals.Menu.Ascending,
        "func", "SetSortDirectionAsc",
        "arg1", self,
        "isRadio", TRUE,
        "checked", self:IsSortDirectionAsc()
      )
      dewdrop:AddLine(
        "text", locals.Menu.Descending,
        "func", "SetSortDirectionDesc",
        "arg1", self,
        "isRadio", TRUE,
        "checked", self:IsSortDirectionDesc()
      ) 
    end
  end
end

function FarmerFu:UpdateData()
  compost:Erase(self.itemData)
  for item in pairs(self.charData.items) do
    tinsert(self.itemData, {item = item, count = self.counts[item] or 0})
  end
  if self:IsSortFieldItem() and self:IsSortDirectionAsc() then
    table.sort(self.itemData, function(a, b) return a.item < b.item end)
  elseif self:IsSortFieldItem() and self:IsSortDirectionDesc() then
    table.sort(self.itemData, function(a, b) return a.item > b.item end)
  elseif self:IsSortFieldCount() and self:IsSortDirectionAsc() then
    table.sort(self.itemData, function(a, b) return a.count < b.count end)
  elseif self:IsSortFieldCount() and self:IsSortDirectionDesc() then
    table.sort(self.itemData, function(a, b) return a.count > b.count end)
  end
end

function FarmerFu:UpdateText()
  local item = self.charData.monitor
  if item and self.charData.items[item] then
    self:SetText(crayon:Green(item).." ("..(self.counts[item] or 0)..")")
  else
    self:SetText(self:GetTitle())
  end
end

function FarmerFu:UpdateTooltip()
  local r, g, b = 1, 1, 0;
  local r2, g2, b2 = 1, 1, 1;
  local cat = tablet:AddCategory(
    "columns", 2,
    "child_textR", r,
    "child_textG", g,
    "child_textB", b,
    "child_text2R", r2,
    "child_text2G", g2,
    "child_text2B", b2
  )

  for _, data in pairs(self.itemData) do
    cat:AddLine(
      "text", data.item,
      "text2", data.count
    )
  end

  tablet:SetHint(locals.Tooltip.Hint)
end

function FarmerFu:ContainerFrameItemButton_OnClick(button, index)
  if IsShiftKeyDown() and IsControlKeyDown() then
    local item = GetContainerItemLink(this:GetParent():GetID(), this:GetID()) or ""
    self:AddItem(item)
  else
    self:CallHook("ContainerFrameItemButton_OnClick", button, index)
  end
end

function FarmerFu:AddItem(item)
  item = self:RemoveHyperlink(item)
  if item and not self.charData.items[item] then
    self.charData.items[item] = 0
    self.counts[item] = 0
    self:GetItemCounts()
    self:Update()
  end
end

function FarmerFu:RemoveItem(item)
  item = self:RemoveHyperlink(item)
  if item and self.charData.items[item] then
    self.charData.items[item] = nil
    self.counts[item] = nil
    if item == self.charData.monitor then
      self.charData.monitor = nil
    end
    self:Update()
  end
end

function FarmerFu:MonitorItem(item)
  if item and self.charData.items[item] then
    if item == self.charData.monitor then
      self.charData.monitor = nil
    else
      self.charData.monitor = item
    end
  end
  self:UpdateText()
end

function FarmerFu:RemoveAllItems()
  self.charData.monitor = nil
  compost:Erase(self.charData.items)
  compost:Erase(self.counts)
  self:Update()
end

function FarmerFu:UpdateItems()
  self:GetItemCounts()
  self:Update()
end

function FarmerFu:GetItemCounts()
  compost:Erase(self.counts)
  for bag = 0, NUM_BAG_FRAMES do
    for slot = 1, GetContainerNumSlots(bag) do
      local item = GetContainerItemLink(bag, slot) or ""
      item = self:RemoveHyperlink(item)
      local _, count = GetContainerItemInfo(bag, slot)
      if item and count and self.charData.items[item] then
        if not self.counts[item] then
          self.counts[item] = count
        else
          self.counts[item] = self.counts[item] + count
        end
      end
    end
  end
end

function FarmerFu:IsWatchingItem(item)
  for _, i in pairs(self.charData.items) do
    if i == item then
      return TRUE
    end
  end
end

function FarmerFu:RemoveHyperlink(item)
  return gsub(item, ".*%[(.*)%].*", "%1")
end

function FarmerFu:SetSortFieldItem()
  self.charData.sort.field = const.SORT_ITEM
  self:UpdateDisplay()
end
 
function FarmerFu:SetSortFieldCount()
  self.charData.sort.field = const.SORT_COUNT
  self:UpdateDisplay()
end

function FarmerFu:SetSortDirectionAsc()
  self.charData.sort.direction = const.SORT_ASC
  self:UpdateDisplay()
end

function FarmerFu:SetSortDirectionDesc()
  self.charData.sort.direction = const.SORT_DESC
  self:UpdateDisplay()
end

function FarmerFu:IsSortFieldItem()
  return self.charData.sort.field == const.SORT_ITEM
end

function FarmerFu:IsSortFieldCount()
  return self.charData.sort.field == const.SORT_COUNT
end

function FarmerFu:IsSortDirectionAsc()
  return self.charData.sort.direction == const.SORT_ASC
end

function FarmerFu:IsSortDirectionDesc()
  return self.charData.sort.direction == const.SORT_DESC
end

function FarmerFu:Msg(msg, ...)
  self.cmd:result(format(msg, unpack(arg)))
end

FarmerFu:RegisterForLoad()
