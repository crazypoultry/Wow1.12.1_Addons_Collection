-- create the plugin object and configure
OutfitterFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceDB-2.0", "AceEvent-2.0")
OutfitterFu.version = "2.0." .. string.sub("$Revision: 22422 $", 12, -3)
OutfitterFu.date = string.sub("$Date: 2006-12-28 05:13:14 -0500 (Thu, 28 Dec 2006) $", 8, 17)
OutfitterFu.hasIcon = "Interface\\AddOns\\Outfitter\\Textures\\Icon"
OutfitterFu.defaultPosition = "CENTER"
OutfitterFu.clickableTooltip = true
OutfitterFu:RegisterDB("OutfitterFuDB", "OutfitterFuDBPerChar")
OutfitterFu:RegisterDefaults('char', {
   hiddenCategories = {},
   hideMissing = false,
})

-- locals for library access
local Tablet = AceLibrary("Tablet-2.0")
local Crayon = AceLibrary("Crayon-2.0")
local L = AceLibrary("AceLocale-2.2"):new("FuBar_OutfitterFu")

-- locals for static properties
local BANKED_FONT_COLOR = {r = 0.25, g = 0.2, b = 1.0}
local BANKED_FONT_COLOR_CODE = '|cff4033ff'

-- event hook registered with Outfitter
function OutfitterFu_OutfitEvent(pEvent, pOutfitName, pOutfit)
   OutfitterFu:Update()
end

-- define options context menu
OutfitterFu.OnMenuRequest = {
   type = 'group',
   args = {
      value = {
         type = "toggle",
         name = L["Hide Missing"],
         desc = L["Hide outfits with missing items"],
         get = "IsHideMissing",
         set = "ToggleHideMissing",
      }
   }
}

function OutfitterFu:IsHideMissing()
   return self.db.char.hideMissing
end

function OutfitterFu:ToggleHideMissing()
   if self:IsHideMissing() then
      self.db.char.hideMissing = false
   else
      self.db.char.hideMissing = true
   end
   self:UpdateTooltip()
end

-- registers event callbacks with Outfitter and WoW
function OutfitterFu:OnEnable()
   -- TODO KTP detect these missing globals: Outfitter_RegisterOutfitEvent, Outfitter_IsInitialized,
   -- Outfitter_GetCurrentOutfitInfo, Outfitter_GetCategoryOrder, Outfitter_GetOutfitsByCategoryID,
   -- Outfitter_HasVisibleOutfits, Outfitter_OutfitIsVisible

   Outfitter_RegisterOutfitEvent('OUTFITTER_INIT', OutfitterFu_OutfitEvent)
   Outfitter_RegisterOutfitEvent('WEAR_OUTFIT', OutfitterFu_OutfitEvent)
   Outfitter_RegisterOutfitEvent('UNWEAR_OUTFIT', OutfitterFu_OutfitEvent)
   self:RegisterEvent('PLAYER_ENTERING_WORLD', 'Update')
   self:RegisterEvent('ZONE_CHANGED_NEW_AREA', 'Update')
   self:RegisterEvent('BANKFRAME_OPENED', 'Update')
   self:RegisterEvent('BANKFRAME_CLOSED', 'Update')
end

-- updates text in FuBar
function OutfitterFu:OnTextUpdate()
   if not Outfitter_IsInitialized() then
      self:SetText(NORMAL_FONT_COLOR_CODE .. L["Initializing"] .. '|r')
      return
   end
   
   local name, vOutfit = Outfitter_GetCurrentOutfitInfo()
   local vEquippableItems = OutfitterItemList_GetEquippableItems()
   local vMissingItems, vBankedItems = OutfitterItemList_GetMissingItems(vEquippableItems, vOutfit)

   local vItemColor = NORMAL_FONT_COLOR_CODE
   if vMissingItems then
      vItemColor = RED_FONT_COLOR_CODE
   elseif vBankedItems then
      vItemColor = BANKED_FONT_COLOR_CODE
   end
   
   self:SetText(vItemColor .. name .. "|r")
end

-- updates FuBar tooltip
function OutfitterFu:OnTooltipUpdate()
   if not Outfitter_IsInitialized() then
      Tablet:AddCategory():AddLine(
        'text', L["Initializing"]
      )
      return
   end
   
   -- Tablet:SetHint(L["Click to toggle Outfitter window"])

   local vEquippableItems = OutfitterItemList_GetEquippableItems()
   local category
   
   for vCategoryIndex, vCategoryID in ipairs(Outfitter_GetCategoryOrder()) do
      local vCategoryName = getglobal("Outfitter_c" .. vCategoryID .. "Outfits")
      local vOutfits = Outfitter_GetOutfitsByCategoryID(vCategoryID)
      
      if Outfitter_HasVisibleOutfits(vOutfits) then
         category = Tablet:AddCategory(
            'id', vCategoryID,
            'text', vCategoryName,
            'textR', 1,
            'textG', 1,
            'textB', 1,
            'hideBlankLine', true,
            'showWithoutChildren', true,
            'hasCheck', true,
            'checked', true,
            'checkIcon', self.db.char.hiddenCategories[vCategoryID] and 'Interface\\Buttons\\UI-PlusButton-Up' or 'Interface\\Buttons\\UI-MinusButton-Up',
            'func', 'ToggleCategory',
            'arg1', self,
            'arg2', vCategoryID,
            'child_func', 'OutfitClick',
            'child_arg1', self
         )
         
         if (not self.db.char.hiddenCategories[vCategoryID]) then
            for vIndex, vOutfit in pairs(vOutfits) do
               if Outfitter_OutfitIsVisible(vOutfit) then
                  local vMissingItems, vBankedItems = OutfitterItemList_GetMissingItems(vEquippableItems, vOutfit)

		  if not vMissingItems or not self:IsHideMissing() then
                     local vWearingOutfit = Outfitter_WearingOutfit(vOutfit)
                     local vItemColor = NORMAL_FONT_COLOR
                  
                     if vMissingItems then
                        vItemColor = RED_FONT_COLOR
                     elseif vBankedItems then
                        vItemColor = BANKED_FONT_COLOR
                     end
                  
                     category:AddLine(
                        'text', ' ' .. vOutfit.Name,
                        'textR', vItemColor.r,
                        'textG', vItemColor.g,
                        'textB', vItemColor.b,
                        'arg2', {CategoryID = vCategoryID, Index = vIndex},
                        'hasCheck', true,
                        'checked', vWearingOutfit,
                        'indentation', 12
                     )
		  end
               end
            end
         end
      end
   end
end

-- callback for tooltip menu category click
function OutfitterFu:ToggleCategory(id, button)
   if self.db.char.hiddenCategories[id] then
      self.db.char.hiddenCategories[id] = false
   else
      self.db.char.hiddenCategories[id] = true
   end
   self:UpdateTooltip()
end

-- callback for tooltip menu outfit click
function OutfitterFu:OutfitClick(outfitRef, button)
   OutfitterMinimapButton_ItemSelected(nil, outfitRef)
   self:Update()
end

-- toggles the Outfitter frame
function OutfitterFu:OnClick()
   if (CharacterFrame:IsVisible() and OutfitterFrame:IsVisible()) then
      HideUIPanel(CharacterFrame)
      OutfitterFrame:Hide()
   else
      ShowUIPanel(CharacterFrame)
      CharacterFrame_ShowSubFrame("PaperDollFrame")
      OutfitterFrame:Show()
   end
end
