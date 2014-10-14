
-- Module: MehTrinketeer
-- Author: Mehran Shahir
-- Description: Automatically tracks and makes the most efficient use of your trinkets

-- global vars

gVersion = "1.31"

gSetupList = {
   [1] = {
      name        = MT_TXT_DEFAULT,
      passiveList = {},
      numPassives = 0,
      cooldownList = {},
      numCooldowns = 0,
      autoload = 1,
      zone = 0,
      zonename = ""
   }
}

gCurrSetup = 1

gPassiveTrinkets = {}
gNumPassiveTrinkets = 0
gCooldownTrinkets = {}
gNumCooldownTrinkets = 0
gTrinketsMinWidth = 400
gTrinketsMinHeight = 174
gAdvancedHeight = 76
gPassivesXstart = 10
gPassivesYstart = -39
gCooldownsXstart = 200
gCooldownsYstart = -39
gPaletteXstart = 8
gPaletteYstart = -20
gButtonsScale = 0.6
gButtonNext = 40
gMaxNumCols = 5
gMaxNumRows = 7
gPassivesOn = true
gCooldownsOn = true
gLastPassiveHighlight = -1
gLastCooldownHighlight = -1
gLock1 = false
gLock2 = false
gAutoTrinketEquip1 = false
gAutoTrinketEquip2 = false
gDialogFunc = nil
gEquipADTrinket = false
gAdvancedOpen = false
gMinimapRadius = 78
gRightDragActive = false
gCursorX = 0
gCursorY = 0
gCurrOptBtX = -gMinimapRadius
gCurrOptBtY = 0
gOpts = { AutoEquipCarrot = true, AskArgentDawn = true, LockFrame = false }
gPalettes = {}
gPaletteFuncs = {}
gPaletteOpts = {}
gRefresh = false

-- my debugging buddy
cnt = 0

WEARING = -1
TRINKETSLOT1 = -1
TRINKETSLOT2 = -2

-- functions

-- copy by value
function MTTCopy(to, from)
   for k,v in pairs(from) do
      if type(v)=="table" then
         to[k] = {}
         MTTCopy(to[k], v);
      else
         to[k] = v;
      end
   end
end

local function MTFindInArray(array, find)

   for i=1,getn(array) do
      if array[i] == find then
         return i
      end
   end

   return 0
end

local function MTFindInLists(itemName)
   
   tobeequipped = {}

   for i = 0,gNumCooldownTrinkets-1 do
      cdstart, cdduration = GetContainerItemCooldown(gCooldownTrinkets[i].bag, gCooldownTrinkets[i].slot)
      if GetTime() > cdstart+cdduration-30 and getn(tobeequipped) < 2 then
         tinsert(tobeequipped, gCooldownTrinkets[i].name)
      end
      if gCooldownTrinkets[i].name == itemName then
         return true, i, "Cooldown", (MTFindInArray(tobeequipped, itemName) > 0)
      end
   end

   for i = 0,gNumPassiveTrinkets-1 do
      cdstart, cdduration = GetContainerItemCooldown(gPassiveTrinkets[i].bag, gPassiveTrinkets[i].slot)
      if GetTime() > cdstart+cdduration-30 and getn(tobeequipped) < 2 then
         tinsert(tobeequipped, gPassiveTrinkets[i].name)
      end
      if gPassiveTrinkets[i].name == itemName then
         return true, i, "Passive", (MTFindInArray(tobeequipped, itemName) > 0)
      end
   end

   return false, -1, "Unknown", false
end

local function MTRemoveFromList(list, len, i)

   --message("removing "..i.." from list")

   -- force copy by value
   removedTrinket          = {}

   MTTCopy(removedTrinket, list[i])

   for j = i,len-2 do
      MTTCopy(list[j], list[j+1])
   end

   return removedTrinket
end


local function MTIsInBags(trinket)

   itemLink = GetContainerItemLink(trinket.bag, trinket.slot)
         
   if itemLink then
      _,_,itemName = string.find(itemLink or "","item:%d+.+%[(.+)%]")
      if itemName == trinket.name then
         return true
      end
   end

   return false
end

local function MTIsInInventory(trinket)

   itemLink = GetInventoryItemLink("player", 12-trinket.slot)
         
   if itemLink then
      _,_,itemName = string.find(itemLink or "","item:%d+.+%[(.+)%]")
      if itemName == trinket.name then
         return true
      end
   end

   return false
end


equipped1frame = -1.0
equipped2frame = -1.0

local function EquipFirstPassive(slot, stop)

   -- if cursor has an object in it, don't mess with it and return failure
   if CursorHasItem() then
      return false
   end

   if stop then
      lastCheck = stop-1
   else
      lastCheck = gNumPassiveTrinkets-1
   end

   if slot == 13 then
      timesinceequip = (updateframe-equipped1frame) + totalupdateelapsed
      canequip = timesinceequip > 1.0
   else
      timesinceequip = (updateframe-equipped2frame) + totalupdateelapsed
      canequip = timesinceequip > 1.0
   end

   if not canequip then
      return false
   end
   
   for i=0,lastCheck do
      if gPassiveTrinkets[i].bag ~= WEARING and MTIsInBags(gPassiveTrinkets[i]) then
         
         PickupContainerItem(gPassiveTrinkets[i].bag, gPassiveTrinkets[i].slot)
         if not CursorHasItem() then
            return false
         end
         PickupInventoryItem(slot)
         if CursorHasItem() then
            EquipCursorItem(slot)
         end
    
         gPassiveTrinkets[i].bag = WEARING
         gPassiveTrinkets[i].slot = 12 - slot

         updateframe = 0.0
         
         if slot == 13 then
            equipped1frame = updateframe
         else
            equipped2frame = updateframe
         end            
         return true
      end
   end

   return false
end

local function EquipFirstCooldown(slot, stop)

   -- if cursor has an object in it, don't mess with it and return failure
   if CursorHasItem() then
      return false
   end

   if stop then
      lastCheck = stop-1
   else
      lastCheck = gNumCooldownTrinkets-1
   end

   if slot == 13 then
      timesinceequip = (updateframe-equipped1frame) + totalupdateelapsed
      canequip = timesinceequip > 1.0
   else
      timesinceequip = (updateframe-equipped2frame) + totalupdateelapsed
      canequip = timesinceequip > 1.0
   end

   if not canequip then
      return false
   end

   for i=0,lastCheck do
      if gCooldownTrinkets[i].bag ~= WEARING and MTIsInBags(gCooldownTrinkets[i]) then

         cdstart, cdduration = GetContainerItemCooldown(gCooldownTrinkets[i].bag, gCooldownTrinkets[i].slot)
         if GetTime() > cdstart+cdduration-30 then
            PickupContainerItem(gCooldownTrinkets[i].bag, gCooldownTrinkets[i].slot)
            if not CursorHasItem() then
               return false
            end
            PickupInventoryItem(slot)
            if CursorHasItem() then
               EquipCursorItem(slot)
            end
            
            gCooldownTrinkets[i].bag = WEARING
            gCooldownTrinkets[i].slot = 12 - slot

            updateframe = 0.0
            if slot == 13 then
               equipped1frame = updateframe
            else
               equipped2frame = updateframe
            end
            return true
         end
      end
   end

   return false
end

local function TryPassiveEquip(slot, trinket)
   for i=0,gNumPassiveTrinkets-1 do
      if gPassiveTrinkets[i].bag ~= WEARING and gPassiveTrinkets[i].name == trinket and MTIsInBags(gPassiveTrinkets[i]) then

         PickupContainerItem(gPassiveTrinkets[i].bag, gPassiveTrinkets[i].slot)
         if not CursorHasItem() then
            return false
         end
         PickupInventoryItem(slot)
         if CursorHasItem() then
            EquipCursorItem(slot)
         end
    
         gPassiveTrinkets[i].bag = WEARING
         gPassiveTrinkets[i].slot = 12 - slot

         updateframe = 0.0
         
         if slot == 13 then
            equipped1frame = updateframe
         else
            equipped2frame = updateframe
         end            
         return true
      end
   end

   return false
end

-- note this function assumes carrot is in passives list
local function EquipCarrot(slot)

   -- if it is already equipped return "success" so the equip logic doesn't run
   itemLink = GetInventoryItemLink("player", slot)
   _,_,trinket = string.find(itemLink or "","item:%d+.+%[(.+)%]")

   if trinket == "Carrot on a Stick" then      
      return true
   end

   -- return false for the other slot so normal equip logic will run
   itemLink = GetInventoryItemLink("player", 27-slot)
   _,_,trinket = string.find(itemLink or "","item:%d+.+%[(.+)%]")

   if trinket == "Carrot on a Stick" then
      return false
   end
   
   -- if cursor has an object in it, don't run the rest of the equip logic
   if CursorHasItem() then
      return true
   end

   if slot == 13 then
      timesinceequip = (updateframe-equipped1frame) + totalupdateelapsed
      canequip = timesinceequip > 1.0
   else
      timesinceequip = (updateframe-equipped2frame) + totalupdateelapsed
      canequip = timesinceequip > 1.0
   end

   if not canequip then
      return false
   end

   return TryPassiveEquip(slot, "Carrot on a Stick")   
end

function MTFlagEquipADTrinket(equip)
   gEquipADTrinket = equip   
   ADEquippedTime = GetTime()
end

-- note this function assumes AD trinket is in passives list
local function EquipADTrinket(slot)

   -- if it is already equipped return "success" so the equip logic doesn't run
   itemLink = GetInventoryItemLink("player", slot)
   _,_,trinket = string.find(itemLink or "","item:%d+.+%[(.+)%]")

   if trinket == MT_TXT_ARGENT_DAWN_COMM or
      trinket == MT_TXT_ARGENT_DAWN_SEAL or
      trinket == MT_TXT_ARGENT_DAWN_RUNE then
      ADAlreadyEquipped = true
      return true
    else
      ADAlreadyEquipped = false
    end

   -- return false for the other slot so normal equip logic will run
   itemLink = GetInventoryItemLink("player", 27-slot)
    _,_,trinket = string.find(itemLink or "","item:%d+.+%[(.+)%]")

    if trinket == MT_TXT_ARGENT_DAWN_COMM or
      trinket == MT_TXT_ARGENT_DAWN_SEAL or
      trinket == MT_TXT_ARGENT_DAWN_RUNE then
      return false
    end
   
   -- if cursor has an object in it, don't run the rest of the equip logic
   if CursorHasItem() then
      return true
   end

   if slot == 13 then
      timesinceequip = (updateframe-equipped1frame) + totalupdateelapsed
      canequip = timesinceequip > 1.0
   else
      timesinceequip = (updateframe-equipped2frame) + totalupdateelapsed
      canequip = timesinceequip > 1.0
   end

   if not canequip then
      return false
   end

   ret = TryPassiveEquip(slot, MT_TXT_ARGENT_DAWN_SEAL)
   if not ret then
      ret = TryPassiveEquip(slot, MT_TXT_ARGENT_DAWN_RUNE)
   end
   if not ret then
      ret = TryPassiveEquip(slot, MT_TXT_ARGENT_DAWN_COMM)
   end

   return ret
end

local function MTPlayerDead()
   pdead = UnitIsDeadOrGhost("player")

	for i=1,16 do      
      icon = UnitBuff("player",i)

      -- no buffs left, return false
      if not icon then
         return pdead
      end

		if icon == "Interface\\Icons\\Ability_Rogue_FeignDeath" then
			pdead = false
         break
		end
	end

   return pdead
end

local function MTJustEnteredUndead()
   
   nowZone = GetRealZoneText()

   --message(nowZone..","..gLastZone)

   if nowZone ~= gLastZone and (nowZone == "Eastern Plaguelands" or nowZone == "Western Plaguelands" or
      nowZone == "Stratholme" or nowZone == "Scholomance") then
      return true
   end

   return false
end

local function MTIsOnMount()
   for i=0,15 do
      -- check for mount buffs
      MTBuffTool:SetOwner(WorldFrame, "ANCHOR_NONE");
      MTBuffTool:SetPlayerBuff(i, "HELPFUL")

      mountText = MTBuffToolTextLeft2:GetText()

      if mountText == nil then
         break
      end

      if string.find(mountText, "60%%") or string.find(mountText, "100%%") then
         return true
      end
   end
   
   return false
end

-- minimap button and options

function MTLoadOptions()
   MTOptionsCarrot:SetChecked(gOpts.AutoEquipCarrot)
   MTOptionsAD:SetChecked(gOpts.AskArgentDawn)
   MTOptionsLock:SetChecked(gOpts.LockFrame)
   MTOptionsHideIcon:SetChecked(gOpts.HideIcon)
end

function MTSaveOptions()
   gOpts.AutoEquipCarrot = MTOptionsCarrot:GetChecked()
   gOpts.AskArgentDawn = MTOptionsAD:GetChecked()
   gOpts.LockFrame = MTOptionsLock:GetChecked()
   gOpts.HideIcon = MTOptionsHideIcon:GetChecked()
   if gOpts.HideIcon then
      MTOptionsButton:Hide()
   else
      MTOptionsButton:Show()
   end
end

function MTOptionsButtonInit()
   MTOptionsButton:SetPoint("CENTER", "Minimap", "CENTER", gCurrOptBtX, gCurrOptBtY)
   if gOpts.HideIcon then
      MTOptionsButton:Hide()
   end
end

function MTOptionsButtonUpdate(elapsed)
   if not gRightDragActive then
      return
   end

   currx, curry = GetCursorPosition()

   if currx == gCursorX and curry == gCursorY then
      return
   end

   dx = currx - gCursorX
   dy = curry - gCursorY

   gCursorX = currx
   gCursorY = curry

   mx, my = Minimap:GetCenter()
   btX, btY = MTOptionsButton:GetCenter()
   btX = btX - mx
   btY = btY - my

   dx = min(max(btX + dx, -gMinimapRadius), gMinimapRadius)
   dy = min(max(btY + dy, -gMinimapRadius), gMinimapRadius)

   ntheta = atan(dy/dx)
   if dx < 0 then
      ntheta = ntheta + 180
   end

   gCurrOptBtX = gMinimapRadius * cos(ntheta)
   gCurrOptBtY = gMinimapRadius * sin(ntheta)

   MTOptionsButton:SetPoint("CENTER", "Minimap", "CENTER", gCurrOptBtX, gCurrOptBtY)
end

function MTDialog(msg, func)
   gDialogFunc = func

   --message("dialog called")
   YesNoPrompt:SetText(msg)
   YesNoDialog:Show()
end

local function MTFixOlderVersions()
   if gSetupList[1].numPassives == 0 and gSetupList[1].numCooldowns == 0 then
      if gNumPassiveTrinkets > 0 or gNumCooldownTrinkets > 0 then
         MTTCopy(gSetupList[1].passiveList, gPassiveTrinkets)
         MTTCopy(gSetupList[1].cooldownList, gCooldownTrinkets)
         gSetupList[1].numPassives = gNumPassiveTrinkets
         gSetupList[1].numCooldowns = gNumCooldownTrinkets
         gNumPassiveTrinkets = 0
         gNumCooldownTrinkets = 0
         gPassiveTrinkets = {}
         gCooldownTrinkets = {}
         gCurrSetup = 1
      end
   end
end

function MTLinkPaletteSlotClick(button)
   this:SetChecked(false)   
end

gCurrLinkButton = nil

function MTPickupAction(id)
   --_,_,bar,id = string.find(this:GetName(), "(%a+)(%d+)")

   if IsControlKeyDown() and IsShiftKeyDown() then

      --message(this:GetTop())
      --message(UIParent:GetHeight())

      if gCurrLinkButton == this then
         MTFrameLinks:Hide()
         gCurrLinkButton = nil
         return
      end

      lblButton:SetText(this:GetName())

      maxTop = UIParent:GetHeight() - Minimap:GetHeight()
      maxRight = UIParent:GetWidth()
      minLeft = 0
      cx,cy = this:GetCenter()

      left = cx - MTFrameLinks:GetWidth() / 2.0
      xoffset = max(-left, minLeft)

      right = cx + MTFrameLinks:GetWidth() / 2.0 + MTFrameLinkPalette:GetWidth()
      xoffset = min(maxRight - right, xoffset)

      top = cy + this:GetHeight() / 2.0 + 10 + MTFrameLinks:GetHeight()
      yoffset = min(maxTop - top, 0)

      MTFrameLinks:ClearAllPoints()
      MTFrameLinks:SetPoint("BOTTOM", this:GetName(), "TOP", xoffset, 10 + yoffset)
      MTFrameLinks:Show()
      if gCurrLinkButton then
         gCurrLinkButton:SetChecked(false)
      end
      this:SetChecked(true)
      gCurrLinkButton = this
   else
      oldfPickupAction(id)
   end
end

function MTActionButton_UpdateState()
   
   if this ~= gCurrLinkButton then
      oldfActionButton_UpdateState()
   end
end

function MTActionButton_SetTooltip()
   ttMinWidth = 270
   ttPlusHeight = 15

   oldfActionButton_SetTooltip()
   GameTooltip:AddLine("Ctrl+Shift+Click for MehTrinketeer Link", 0.5, 0.5, 1.0)

   GameTooltip:SetWidth(max(GameTooltip:GetWidth(), ttMinWidth))
   GameTooltip:SetHeight(GameTooltip:GetHeight()+ttPlusHeight)
end

function MTSetPortraitTexture(unit, portrait)
   oldfSetPortraitTexture(unit, portrait)

   if unit == "Player" or unit == "player" or unit == "PLAYER" then
      oldfSetPortraitTexture(unit, MTPlayerPortrait)
   end
end

-- no need to pass arguments, it's faster this way
function MTFindEquippedTrinkets()

   local foundIdx = nil

   -- find the 2 equipped trinkets (if any) in our lists
   itemLink = GetInventoryItemLink("player", 13)
    _,_,trinketid1,trinket1name = string.find(itemLink or "","item:(%d+).+%[(.+)%]")
   if trinketid1 then
      --start, duration = GetInventoryItemCooldown("player", 13)

      for i=0,gNumPassiveTrinkets-1 do         
         if gPassiveTrinkets[i].slot == TRINKETSLOT1 and MTIsInInventory(gPassiveTrinkets[i]) then
            foundIdx = i
            break
         end
      end

      if not foundIdx then
         for i=0,gNumCooldownTrinkets-1 do         
            if gCooldownTrinkets[i].slot == TRINKETSLOT1 and MTIsInInventory(gCooldownTrinkets[i]) then
               foundIdx = i
               break
            end
         end
         type1 = "Cooldown"
         trinket1 = foundIdx
      else
         type1 = "Passive"
         trinket1 = foundIdx
      end
   end

   foundIdx = nil

   itemLink = GetInventoryItemLink("player", 14)
    _,_,trinketid2,trinket2name = string.find(itemLink or "","item:(%d+).+%[(.+)%]")
   if trinketid2 then
      for i=0,gNumPassiveTrinkets-1 do         
         if gPassiveTrinkets[i].slot == TRINKETSLOT2 and MTIsInInventory(gPassiveTrinkets[i]) then
            foundIdx = i
            break
         end
      end

      if not foundIdx then
         for i=0,gNumCooldownTrinkets-1 do         
            if gCooldownTrinkets[i].slot == TRINKETSLOT2 and MTIsInInventory(gCooldownTrinkets[i]) then
               foundIdx = i
               break
            end
         end
         type2 = "Cooldown"
         trinket2 = foundIdx
      else
         type2 = "Passive"
         trinket2 = foundIdx
      end
   end
end

function MTCalcEquippedPriorities()

   trink1Priority = trinket1
   trink2Priority = trinket2

   if not trink1Priority then 
      trink1Priority = 3 * gMaxNumCols * gMaxNumRows
   else
      if type1 == "Passive" then
         trink1Priority = trink1Priority + gMaxNumCols * gMaxNumRows
      end
      cdstart, cdduration = GetInventoryItemCooldown("player", 13)
      if GetTime() < cdstart+cdduration-30 then
         trink1Priority = trink1Priority + 2 * gMaxNumCols * gMaxNumRows
      end
   end
   
   if not trink2Priority then
      trink2Priority = 3 * gMaxNumCols * gMaxNumRows
   else
      if type2 == "Passive" then
         trink2Priority = trink2Priority + gMaxNumCols * gMaxNumRows
      end
      cdstart, cdduration = GetInventoryItemCooldown("player", 14)
      if GetTime() < cdstart+cdduration-30 then
         trink2Priority = trink2Priority + 2 * gMaxNumCols * gMaxNumRows
      end
   end
end

local function MTAutoUseHook()

   if not MTAutoUseActive:GetChecked() or not UnitAffectingCombat("player") then
      return
   end

   MTFindEquippedTrinkets()
   MTCalcEquippedPriorities()

   --message("auto-use called")
   
   _,cdduration = GetInventoryItemCooldown("player",13)
   if trink1Priority < trink2Priority and cdduration == 0 and type1 == "Cooldown" then
      if gCooldownTrinkets[trinket1].autoUseOn then
         useit = true

         plyhealth = UnitHealth("player")/UnitHealthMax("player")
         
         if gCooldownTrinkets[trinket1].playerCheck and
            (plyhealth < gCooldownTrinkets[trinket1].playerMin or
            plyhealth > gCooldownTrinkets[trinket1].playerMax) then
            
            useit = false
         end

         enyhealth = UnitHealth("target")/100.0

         if gCooldownTrinkets[trinket1].enemyCheck and
            (enyhealth < gCooldownTrinkets[trinket1].enemyMin or
            enyhealth > gCooldownTrinkets[trinket1].enemyMax) then
            useit = false
         end

         if useit then
            UseInventoryItem(13)
         end
      end
   elseif type2 == "Cooldown" then
      _,cdduration = GetInventoryItemCooldown("player",14)
      if cdduration == 0 then
         if gCooldownTrinkets[trinket2].autoUseOn then
            useit = true

            plyhealth = UnitHealth("player")/UnitHealthMax("player")
            
            if gCooldownTrinkets[trinket2].playerCheck and
               (plyhealth < gCooldownTrinkets[trinket2].playerMin or
               plyhealth > gCooldownTrinkets[trinket2].playerMax) then
               
               useit = false
            end

            enyhealth = UnitHealth("target")/100.0

            if gCooldownTrinkets[trinket2].enemyCheck and
               (enyhealth < gCooldownTrinkets[trinket2].enemyMin or
               enyhealth > gCooldownTrinkets[trinket2].enemyMax) then
               
               useit = false
            end

            if useit then
               UseInventoryItem(14)
            end
         end
      end
   end
end

local function MTSpecialCase(slot)

   checkTrinket = nil

   if trinket1 then
      if type1 == "Passive" then
         if gPassiveTrinkets[trinket1].slot == slot then
            checkTrinket = trinket1name
         end
      elseif gCooldownTrinkets[trinket1].slot == slot then
         checkTrinket = trinket1name
      end
   end
   if trinket2 then
      if type2 == "Passive" then
         if gPassiveTrinkets[trinket2].slot == slot then
            checkTrinket = trinket2name
         end
      elseif gCooldownTrinkets[trinket2].slot == slot then
         checkTrinket = trinket2name
      end
   end

   if not checkTrinket then
      return
   end

   for i=0,15 do
      -- check for special buffs for trinkets
      MTBuffTool:SetOwner(WorldFrame, "ANCHOR_NONE");
      MTBuffTool:SetPlayerBuff(i, "HELPFUL")

      tooltipText = MTBuffToolTextLeft1:GetText()

      if tooltipText == nil then
         break
      end

      if not gSpecialCases[checkTrinket] then
         if tooltipText == checkTrinket then
            return true
         end
      else
         if string.find(tooltipText, gSpecialCases[checkTrinket]) then
            return true
         end
      end
	end

   return false
end

function MTUseAction(id, flag, onself)
   MTAutoUseHook()
   oldfUseAction(id, flag, onself)
end

function MTKeyBindingFrame_OnKeyDown(button)
   MTAutoUseHook()
   oldfKeyBindingFrame_OnKeyDown(button)
end

function MTWorldFrame_OnUpdate(arg1)
   oldfWorldFrame_OnUpdate(arg1)
   MTUpdate(arg1)
end

gUseTimer1 = 0
gUseTimer2 = 0

function MTUseInventoryItem(slot)
   oldfUseInventoryItem(slot)

   if MTSpecialCase(12-slot) then
      if slot == 13 then
         gUseTimer1 = 0
      else
         gUseTimer2 = 0
      end
   end
end

function MTErrorWithStack(msg)
   msg = msg.."\n"..debugstack()
   _ERRORMESSAGE(msg)
end

function MTInit()
   this:RegisterEvent("PLAYER_LOGIN")
   this:RegisterEvent("VARIABLES_LOADED")

   SlashCmdList["MehTrinketeerHelp"] = MTSlashHelp
   SlashCmdList["MehTrinketeerShow"] = MTSlashShow
   SlashCmdList["MehTrinketeerLoad"] = MTSlashLoad
   SlashCmdList["MehTrinketeerUse"] = MTSlashUse
   SlashCmdList["MehTrinketeerShowOpts"] = MTSlashShowOpts
	
   SLASH_MehTrinketeerHelp1 = MT_TXT_COMMAND_HELP
	SLASH_MehTrinketeerShow1 = MT_TXT_COMMAND_SHOW
   SLASH_MehTrinketeerLoad1 = MT_TXT_COMMAND_LOAD
   SLASH_MehTrinketeerUse1 = MT_TXT_COMMAND_USE
   SLASH_MehTrinketeerShowOpts1 = MT_TXT_COMMAND_SHOW_OPTS

   -- it's HIJACKING time!
   --oldfPickupAction = PickupAction
   --PickupAction = MTPickupAction

   --oldfActionButton_SetTooltip = ActionButton_SetTooltip
   --ActionButton_SetTooltip = MTActionButton_SetTooltip

   --oldfActionButton_UpdateState = ActionButton_UpdateState
   --ActionButton_UpdateState = MTActionButton_UpdateState

   oldfUseAction = UseAction
   UseAction = MTUseAction

   oldfKeyBindingFrame_OnKeyDown = KeyBindingFrame_OnKeyDown
   KeyBindingFrame_OnKeyDown = MTKeyBindingFrame_OnKeyDown

   oldfWorldFrame_OnUpdate = WorldFrame_OnUpdate
   WorldFrame_OnUpdate = MTWorldFrame_OnUpdate

   oldfUseInventoryItem = UseInventoryItem
   UseInventoryItem = MTUseInventoryItem

   tinsert(gPalettes, "MTFramePalette")
   gPaletteFuncs["MTFramePalette"] = MTPaletteSlotClick
   tinsert(gPalettes, "MTFrameAutoUse")
   gPaletteFuncs["MTFrameAutoUse"] = MTAutoUseSlotClick
   
   gPaletteOpts["MTFrameAutoUse"] = {}
   tinsert(gPaletteOpts["MTFrameAutoUse"], "NOPASSIVES")

   --seterrorhandler(MTErrorWithStack)

   DEFAULT_CHAT_FRAME:AddMessage("[MehTrinketeer] "..MT_TXT_LOAD_SUCCESS, 225, 225, 0)
   DEFAULT_CHAT_FRAME:AddMessage("[MehTrinketeer] "..MT_TXT_USE_HELP, 225, 225, 0)
end

function MTLoad()

   -- check tooltrinket slots now
   itemLink = GetInventoryItemLink("player", 13)
   _,_,currTrinket1ID,currTrinket1 = string.find(itemLink or "","item:(%d+).+%[(.+)%]")
   itemLink = GetInventoryItemLink("player", 14)
   _,_,currTrinket2ID,currTrinket2 = string.find(itemLink or "","item:(%d+).+%[(.+)%]")

   if currTrinket1ID then
      _,_,_,_,_,_,_,_,itemTexture = GetItemInfo(currTrinket1ID or "")
      MTEquipped1Icon:SetTexture(itemTexture)

      found, idx, listtype = MTFindInLists(currTrinket1)

      if not found then
         if not gPassiveTrinkets[gNumPassiveTrinkets] then
            gPassiveTrinkets[gNumPassiveTrinkets] = {}
         end
                
         gPassiveTrinkets[gNumPassiveTrinkets].bag = WEARING
         gPassiveTrinkets[gNumPassiveTrinkets].slot = TRINKETSLOT1
         gPassiveTrinkets[gNumPassiveTrinkets].name = currTrinket1
         gPassiveTrinkets[gNumPassiveTrinkets].texture = itemTexture
         gNumPassiveTrinkets = gNumPassiveTrinkets + 1
      else
         if listtype == "Passive" then
            -- make sure this is not run on the first update
            if gPassiveTrinkets[idx].bag ~= WEARING and (gLastPassiveHighlight >= 0 and gLastCooldownHighlight >= 0) then
               if not gAutoTrinketEquip1 then
                  gLock1 = true;
                  MTLock1:SetChecked(true)
                end

               gAutoTrinketEquip1 = false
            end            
            gPassiveTrinkets[idx].bag = WEARING
            gPassiveTrinkets[idx].slot = TRINKETSLOT1
            gPassiveTrinkets[idx].name = currTrinket1
            gPassiveTrinkets[idx].texture = itemTexture
         elseif listtype == "Cooldown" then
            -- make sure this is not run on the first update
            if gCooldownTrinkets[idx].bag ~= WEARING and (gLastPassiveHighlight >= 0 and gLastCooldownHighlight >= 0) then
               if not gAutoTrinketEquip1 then
                  gLock1 = true;
                  MTLock1:SetChecked(true)
                end

               gAutoTrinketEquip1 = false
            end   

            gCooldownTrinkets[idx].bag = WEARING
            gCooldownTrinkets[idx].slot = TRINKETSLOT1
            gCooldownTrinkets[idx].name = currTrinket1
            gCooldownTrinkets[idx].texture = itemTexture
         end
      end
   end

   if currTrinket2ID then
      _,_,_,_,_,_,_,_,itemTexture = GetItemInfo(currTrinket2ID or "")
      MTEquipped2Icon:SetTexture(itemTexture)

      found, idx, listtype = MTFindInLists(currTrinket2)

      if not found then
         if not gPassiveTrinkets[gNumPassiveTrinkets] then
            gPassiveTrinkets[gNumPassiveTrinkets] = {}
         end         
                    
         gPassiveTrinkets[gNumPassiveTrinkets].bag = WEARING
         gPassiveTrinkets[gNumPassiveTrinkets].slot = TRINKETSLOT2
         gPassiveTrinkets[gNumPassiveTrinkets].name = currTrinket2
         gPassiveTrinkets[gNumPassiveTrinkets].texture = itemTexture
         gNumPassiveTrinkets = gNumPassiveTrinkets + 1
      else
         if listtype == "Passive" then
            if gPassiveTrinkets[idx].bag ~= WEARING and (gLastPassiveHighlight >= 0 and gLastCooldownHighlight >= 0) then
               if not gAutoTrinketEquip2 then
                  gLock2 = true;
                  MTLock2:SetChecked(true)
                end

               gAutoTrinketEquip2 = false
            end 
            gPassiveTrinkets[idx].bag = WEARING
            gPassiveTrinkets[idx].slot = TRINKETSLOT2
            gPassiveTrinkets[idx].name = currTrinket2
            gPassiveTrinkets[idx].texture = itemTexture
         elseif listtype == "Cooldown" then
            if gCooldownTrinkets[idx].bag ~= WEARING and (gLastPassiveHighlight >= 0 and gLastCooldownHighlight >= 0) then
               if not gAutoTrinketEquip2 then
                  gLock2 = true;
                  MTLock2:SetChecked(true)
                end

               gAutoTrinketEquip2 = false
            end
            gCooldownTrinkets[idx].bag = WEARING
            gCooldownTrinkets[idx].slot = TRINKETSLOT2
            gCooldownTrinkets[idx].name = currTrinket2
            gCooldownTrinkets[idx].texture = itemTexture
         end
      end
   end

   bogus = false
   -- Check for loading
   if gBagUpdateTimer < 3.0 then
      bogus = true
   else
      for i = 0,4 do
         if GetBagName(i) and GetContainerNumSlots(i) == 0 then
            bogus = true
            --message("bogus")
            break
         end
      end
   end

   -- only trust bags if they are all there
   if not bogus then
   
      -- build checklists
      passiveChecklist = {}
      cooldownChecklist = {}
      oldNumPassiveTrinkets = gNumPassiveTrinkets
      oldNumCooldownTrinkets = gNumCooldownTrinkets

      for i = 0,oldNumPassiveTrinkets-1 do
         if not passiveChecklist[i] then
            passiveChecklist[i] = {}
         end
         passiveChecklist[i].name = gPassiveTrinkets[i].name
         if currTrinket1 == passiveChecklist[i].name or currTrinket2 == passiveChecklist[i].name then
            passiveChecklist[i].present = true
         else
            passiveChecklist[i].present = false
         end
      end
      for i = 0,oldNumCooldownTrinkets-1 do
         if not cooldownChecklist[i] then
            cooldownChecklist[i] = {}
         end
         cooldownChecklist[i].name = gCooldownTrinkets[i].name
         if currTrinket1 == gCooldownTrinkets[i].name or currTrinket2 == gCooldownTrinkets[i].name then
            cooldownChecklist[i].present = true
         else
            cooldownChecklist[i].present = false
         end
      end

      -- any newly equipped tooltrinkets go into passive list   
      for i = 0,4 do
         for j = 1,GetContainerNumSlots(i) do
            itemLink = GetContainerItemLink(i,j)
         
            if itemLink then
               _,_,itemID,itemName = string.find(itemLink or "","item:(%d+).+%[(.+)%]")
               _,_,_,_,_,_,_,equipSlot,itemTexture = GetItemInfo(itemID or "")            
                  
               if equipSlot=="INVTYPE_TRINKET" then
                  -- flag that it has been found
                  for k = 0,oldNumPassiveTrinkets-1 do
                     if itemName == passiveChecklist[k].name then
                        passiveChecklist[k].present = true
                     end
                  end
                  for k = 0,oldNumCooldownTrinkets-1 do
                     if itemName == cooldownChecklist[k].name then
                        cooldownChecklist[k].present = true
                     end
                  end

                  found, idx, listtype = MTFindInLists(itemName)
                
                  if not found then
                     if not gPassiveTrinkets[gNumPassiveTrinkets] then
                        gPassiveTrinkets[gNumPassiveTrinkets] = {}
                     end
                   
                        gPassiveTrinkets[gNumPassiveTrinkets].bag = i
                        gPassiveTrinkets[gNumPassiveTrinkets].slot = j
                        gPassiveTrinkets[gNumPassiveTrinkets].name = itemName
                        gPassiveTrinkets[gNumPassiveTrinkets].texture = itemTexture
                        gNumPassiveTrinkets = gNumPassiveTrinkets + 1
                  else
                     if listtype == "Passive" then
                        gPassiveTrinkets[idx].bag = i
                        gPassiveTrinkets[idx].slot = j
                     elseif listtype == "Cooldown" then
                        gCooldownTrinkets[idx].bag = i
                        gCooldownTrinkets[idx].slot = j
                     end                  
                  end
               end
            end
         end
      end

      if gRefresh then
         gRefresh = false
         -- remove anything that was destroyed or put back in bank
         for i = 0,oldNumPassiveTrinkets-1 do
            if passiveChecklist[i].present == false then
               if (passiveChecklist[i].name) then
                  MTRemoveFromList(gPassiveTrinkets, gNumPassiveTrinkets, i)            
                  gNumPassiveTrinkets = gNumPassiveTrinkets - 1
       
                  -- if empty, hide last slot
                  if gNumPassiveTrinkets == 0 then
                     MTPassive1:Hide()
                  end

                  if gLastPassiveHighlight > 0 then
                     getglobal("MTPassive"..gLastPassiveHighlight):SetChecked(false)
                  end
               end
            end
         end
         for i = 0,oldNumCooldownTrinkets-1 do
            if cooldownChecklist[i].present == false then
               if (cooldownChecklist[i].name) then
                  MTRemoveFromList(gCooldownTrinkets, gNumCooldownTrinkets, i)            
                  gNumCooldownTrinkets = gNumCooldownTrinkets - 1
       
                  -- if empty, hide last slot
                  if gNumCooldownTrinkets == 0 then
                     MTCooldown1:Hide()
                  end

                  if gLastCooldownHighlight > 0 then
                     getglobal("MTCooldown"..gLastCooldownHighlight):SetChecked(false)
                  end
               end
            end
         end
      end
   end

   -- set scale now
   MTTrinkets:SetScale(gButtonsScale)

   -- arrange passives
   numRows = math.ceil(math.min(gNumPassiveTrinkets,gMaxNumCols*gMaxNumRows) / gMaxNumCols)
   --if (gNumPassiveTrinkets < 5) then
   --   numCols = math.mod(math.min(gNumPassiveTrinkets,gMaxNumCols*gMaxNumRows), gMaxNumCols)
   --else
      numCols = gMaxNumCols
   --end      

   local i, j

   for j = 1,numRows do
      for i = 1,numCols do
         if ((j-1)*numCols+i) > gNumPassiveTrinkets then
            break;
         end
         currTrinket = getglobal("MTPassive"..((j-1)*numCols+i))
         getglobal("MTPassive"..((j-1)*numCols+i).."Icon"):SetTexture(gPassiveTrinkets[((j-1)*numCols+i-1)].texture)
         currTrinket:SetPoint("TOPLEFT","MTFrameTrinkets","TOPLEFT", gPassivesXstart*1/gButtonsScale + gButtonNext*(i-1), 
                              gPassivesYstart*1/gButtonsScale - gButtonNext*(j-1))
      end
   end

   -- queue arrows
   local qarrowsXStart = 8 + gMaxNumCols * gButtonNext * gButtonsScale + 40   -- 16 + 8 + 16
   local qarrowsYStart = -50;

   MTQueueLeft:SetPoint("CENTER","MTFrameTrinkets","TOPLEFT", qarrowsXStart - 16, qarrowsYStart)
   MTQueueUp:SetPoint("CENTER","MTFrameTrinkets","TOPLEFT", qarrowsXStart, qarrowsYStart + 16)
   MTQueueRight:SetPoint("CENTER","MTFrameTrinkets","TOPLEFT", qarrowsXStart + 16, qarrowsYStart)
   MTQueueDown:SetPoint("CENTER","MTFrameTrinkets","TOPLEFT", qarrowsXStart, qarrowsYStart - 16)
   
   lblQueueArrows:SetPoint("CENTER","MTFrameTrinkets","TOPLEFT", qarrowsXStart, -10)

   qarrowsYStart = qarrowsYStart - 44  -- 8 + 16 + 20
   lblSendArrows:SetPoint("CENTER","MTFrameTrinkets","TOPLEFT", qarrowsXStart, qarrowsYStart)

   qarrowsYStart = qarrowsYStart - 28  -- 12 + 16
   MTTypeRight:SetPoint("CENTER","MTFrameTrinkets","TOPLEFT", qarrowsXStart, qarrowsYStart + 10)
   MTTypeLeft:SetPoint("CENTER","MTFrameTrinkets","TOPLEFT", qarrowsXStart, qarrowsYStart - 10)

   -- arrange cooldowns
   numRows = math.ceil(math.min(gNumCooldownTrinkets,gMaxNumCols*gMaxNumRows) / gMaxNumCols)
   --if (gNumPassiveTrinkets < 5) then
   --   numCols = math.mod(math.min(gNumCooldownTrinkets,gMaxNumCols*gMaxNumRows), gMaxNumCols)
   --else
      numCols = gMaxNumCols
   --end

   gCooldownsXstart = qarrowsXStart + 40 -- 8 + 16 + 16

   for j = 1,numRows do
      for i = 1,numCols do
         if ((j-1)*numCols+i) > gNumCooldownTrinkets then
            break;
         end
         currTrinket = getglobal("MTCooldown"..((j-1)*numCols+i))
         getglobal("MTCooldown"..((j-1)*numCols+i).."Icon"):SetTexture(gCooldownTrinkets[((j-1)*numCols+i-1)].texture)
         currTrinket:SetPoint("TOPLEFT","MTFrameTrinkets","TOPLEFT", gCooldownsXstart*1/gButtonsScale + gButtonNext*(i-1), 
                              gCooldownsYstart*1/gButtonsScale - gButtonNext*(j-1))
      end
   end

   -- the following is = 8 + numCols * gButtonNext * gButtonsScale + 16 + 16 * 3 + 16 + numCols * gButtonNext * gButtonScale + 8
   local tooltrinketsWidth = 2 * numCols * gButtonNext * gButtonsScale + 96
   -- the following is = 35 + numRows * gButtonNext * gButtonsScale + 25
   if gAdvancedOpen then
      advanced = gAdvancedHeight
   else
      advanced = 0
   end
   local tooltrinketsHeight = math.max(60 + numRows * gButtonNext * gButtonsScale + advanced, gTrinketsMinHeight + advanced)

   MTFrameTrinkets:SetWidth(tooltrinketsWidth)
   MTFrameTrinkets:SetHeight(tooltrinketsHeight)
 
   MTCooldownOn:SetPoint("LEFT", "MTFrameTrinkets", "TOPRIGHT", -132, -27)
   lblCooldownOn:SetPoint("LEFT", "MTCooldownOn", "RIGHT", 0, 0)

   -- draw selectors 1st frame only
   if gLastPassiveHighlight < 0 or gLastCooldownHighlight < 0 then      

      -- might as well do other first frame only stuff here
      -- sync checkboxes
      MTPassiveOn:SetChecked(gPassivesOn)
      MTCooldownOn:SetChecked(gCooldownsOn)

      -- make cooldowns visible
      --MTEquipped1Cooldown:Show()
      --MTEquipped2Cooldown:Show()

      if gNumPassiveTrinkets == 0 then
         MTCooldown1:SetChecked(true)
         gLastPassiveHighlight = 0
         gLastCooldownHighlight = 1
      else
         MTPassive1:SetChecked(true)
         gLastPassiveHighlight = 1
         gLastCooldownHighlight = 0
      end
   end

   -- make the palettes

   for k = 1, getn(gPalettes) do
      getglobal(gPalettes[k].."Trinkets"):SetScale(gButtonsScale)

      numRows = math.ceil(math.min(gNumPassiveTrinkets,gMaxNumCols*gMaxNumRows) / gMaxNumCols)
      currY = gPaletteYstart

      local i, j

      if not gPaletteOpts[gPalettes[k]] or MTFindInArray(gPaletteOpts[gPalettes[k]], "NOPASSIVES") == 0 then

         getglobal(gPalettes[k].."lblPassives"):Show()

         for j = 1,numRows do
            for i = 1,numCols do
               if ((j-1)*numCols+i) > gNumPassiveTrinkets then
                  break;
               end
               currTrinket = getglobal(gPalettes[k].."TrinketsPassive"..((j-1)*numCols+i))
               getglobal(gPalettes[k].."TrinketsPassive"..((j-1)*numCols+i).."Icon"):SetTexture(gPassiveTrinkets[((j-1)*numCols+i-1)].texture)
               currTrinket:SetPoint("TOPLEFT",gPalettes[k].."Trinkets","TOPLEFT", gPaletteXstart*1/gButtonsScale + gButtonNext*(i-1), 
                                    currY*1/gButtonsScale - gButtonNext*(j-1))
            end
         end

         currY = currY - 5 - gButtonNext*numRows*gButtonsScale
      else
         getglobal(gPalettes[k].."lblPassives"):Hide()
         currY = currY + 10
      end

      getglobal(gPalettes[k].."lblCooldowns"):SetPoint("TOP", gPalettes[k], "TOP", 0, currY)

      currY = currY - 15

      numRows = math.ceil(math.min(gNumCooldownTrinkets,gMaxNumCols*gMaxNumRows) / gMaxNumCols)

      for j = 1,numRows do
         for i = 1,numCols do
            if ((j-1)*numCols+i) > gNumCooldownTrinkets then
               break;
            end

            currTrinket = getglobal(gPalettes[k].."TrinketsCooldown"..((j-1)*numCols+i))
            getglobal(gPalettes[k].."TrinketsCooldown"..((j-1)*numCols+i).."Icon"):SetTexture(gCooldownTrinkets[((j-1)*numCols+i-1)].texture)
            currTrinket:SetPoint("TOPLEFT",gPalettes[k].."Trinkets","TOPLEFT", gPaletteXstart*1/gButtonsScale + gButtonNext*(i-1), 
                                 currY*1/gButtonsScale - gButtonNext*(j-1))                              
         end
      end


      tooltrinketsWidth = numCols * gButtonNext * gButtonsScale + 8 + 8*gButtonsScale
      tooltrinketsHeight = gPaletteYstart - currY + gButtonNext*numRows*gButtonsScale + 26

      getglobal(gPalettes[k].."Trinkets"):SetWidth(tooltrinketsWidth*1/gButtonsScale)
      getglobal(gPalettes[k].."Trinkets"):SetHeight(tooltrinketsHeight*1/gButtonsScale)
      getglobal(gPalettes[k]):SetWidth(tooltrinketsWidth)
      getglobal(gPalettes[k]):SetHeight(tooltrinketsHeight)

   end -- build palettes

   -- Auto-Use
   starty = -MTFrameAutoUse:GetHeight() + 6
   curry = starty
   MTAutoUseOn:SetPoint("TOPLEFT", "MTFrameAutoUse", "TOPLEFT", 8, curry)
   curry = curry - 25

   if MTAutoUseOn:GetChecked() then
      
      MTAutoUsePlayerCheckOn:Show()
      MTAutoUsePlayerCheckOn:SetPoint("TOPLEFT", "MTFrameAutoUse", "TOPLEFT", 25, curry)
      curry = curry - 35

      if MTAutoUsePlayerCheckOn:GetChecked() then
         MTPlyHealthRange:Show()
         MTPlyHealthRange:SetPoint("TOP", "MTFrameAutoUse", "TOP", 0, curry)
         curry = curry - 27
         MTPlayerTexFrame:Show()
         MTPlayerTexFrame:SetPoint("CENTER", "MTFrameAutoUse", "TOPLEFT", 50, curry)
         curry = curry - 40
      else
         MTPlyHealthRange:Hide()
         MTPlayerTexFrame:Hide()
      end         
   
      MTAutoUseEnemyCheckOn:Show()
      MTAutoUseEnemyCheckOn:SetPoint("TOPLEFT", "MTFrameAutoUse", "TOPLEFT", 25, curry)
      curry = curry - 35

      if MTAutoUseEnemyCheckOn:GetChecked() then
         MTEnyHealthRange:Show()
         MTEnyHealthRange:SetPoint("TOP", "MTFrameAutoUse", "TOP", 0, curry)
         curry = curry - 27
         MTEnemyTexFrame:Show()
         MTEnemyTexFrame:SetPoint("CENTER", "MTFrameAutoUse", "TOPLEFT", 50, curry)
         curry = curry - 40
      else
         MTEnyHealthRange:Hide()
         MTEnemyTexFrame:Hide()
      end
   else
      MTAutoUsePlayerCheckOn:Hide()
      MTPlyHealthRange:Hide()
      MTPlayerTexFrame:Hide()
      MTAutoUseEnemyCheckOn:Hide()
      MTEnyHealthRange:Hide()
      MTEnemyTexFrame:Hide()
   end


   tooltrinketsHeight = -curry + 7
   MTFrameAutoUse:SetHeight(tooltrinketsHeight)
   MTFrameAutoUse:SetWidth(300)

   MTFrameAutoUseTrinkets:ClearAllPoints()
   MTFrameAutoUseTrinkets:SetPoint("TOP", "MTFrameAutoUse", "TOP", 0, 0)
end

function MTShow()
   MTFrameEquipped:Show()

   -- show equipped

   itemLink = GetInventoryItemLink("player", 13)
   _,_,trinketid = string.find(itemLink or "","item:(%d+).+%[(.+)%]")

   if trinketid then
      MTEquipped1Icon:Show()
   else
      MTEquipped1Icon:Hide()
   end

   itemLink = GetInventoryItemLink("player", 14)
   _,_,trinketid = string.find(itemLink or "","item:(%d+).+%[(.+)%]")

   if trinketid then
      MTEquipped2Icon:Show()
   else
      MTEquipped2Icon:Hide()
   end

   MTLock1:SetChecked(gLock1)
   MTLock2:SetChecked(gLock2)

   

   -- show passives
   numRows = math.ceil(math.min(gNumPassiveTrinkets,gMaxNumCols*gMaxNumRows) / gMaxNumCols)
   -- go one more row just in case a type switch just happened
   numRows = numRows + 1
   for j = 1,numRows do
      for i = 1,gMaxNumCols do
         if ((j-1)*gMaxNumCols+i) > gNumPassiveTrinkets then
            getglobal("MTPassive"..((j-1)*gMaxNumCols+i)):Hide()
         else
            getglobal("MTPassive"..((j-1)*gMaxNumCols+i)):Show()
            getglobal("MTPassive"..((j-1)*gMaxNumCols+i).."Cooldown"):Show()
         end           
      end
   end

   -- palette passives
   for k = 1,getn(gPalettes) do
      for j = 1,numRows do
         for i = 1,gMaxNumCols do
            if ((j-1)*gMaxNumCols+i) > gNumPassiveTrinkets then
               getglobal(gPalettes[k].."TrinketsPassive"..((j-1)*gMaxNumCols+i)):Hide()
            else
               getglobal(gPalettes[k].."TrinketsPassive"..((j-1)*gMaxNumCols+i)):Show()
               getglobal(gPalettes[k].."TrinketsPassive"..((j-1)*gMaxNumCols+i).."Cooldown"):Show()
            end           
         end
      end
   end

   -- show cooldowns
   numRows = math.ceil(math.min(gNumCooldownTrinkets,gMaxNumCols*gMaxNumRows) / gMaxNumCols)
   -- go one more row just in case a type switch just happened
   numRows = numRows + 1
   for j = 1,numRows do
      for i = 1,gMaxNumCols do
         if ((j-1)*gMaxNumCols+i) > gNumCooldownTrinkets then
            getglobal("MTCooldown"..((j-1)*gMaxNumCols+i)):Hide()
         else
            getglobal("MTCooldown"..((j-1)*gMaxNumCols+i)):Show()
            getglobal("MTCooldown"..((j-1)*gMaxNumCols+i).."Cooldown"):Show()
         end           
      end
   end

   -- palette cooldowns
   for k = 1, getn(gPalettes) do
      for j = 1,numRows do
         for i = 1,gMaxNumCols do
            if ((j-1)*gMaxNumCols+i) > gNumCooldownTrinkets then
               getglobal(gPalettes[k].."TrinketsCooldown"..((j-1)*gMaxNumCols+i)):Hide()
            else
               getglobal(gPalettes[k].."TrinketsCooldown"..((j-1)*gMaxNumCols+i)):Show()
               getglobal(gPalettes[k].."TrinketsCooldown"..((j-1)*gMaxNumCols+i).."Cooldown"):Show()
            end           
         end
      end
   end
end

function MTEquippedSlotClick(button)
   
   this:SetChecked(false)

   if button=="RightButton" and not MerchantFrame:IsVisible() then
      _,_,bnum = string.find(this:GetName(),"MTEquipped(%d+)")
      bnum = tonumber(bnum)-1

      -- don't check cooldown so user gets error msg
      --_, cdduration = GetInventoryItemCooldown("player",13+bnum)
      --if cdduration == 0 then
         UseInventoryItem(13+bnum)
      --end
   end
end

-- highlight and (deprecated) manual trinket equip

function MTListSlotClick(button)
   _,_,typ, bnum = string.find(this:GetName(),"MT(%a+)(%d+)")

   bnum = tonumber(bnum)

   if typ == "Passive" then
      if bnum == gLastPassiveHighlight then
         -- keep it highlighted
         getglobal("MTPassive"..gLastPassiveHighlight):SetChecked(true)
         return
      end

      if gLastPassiveHighlight > 0 then
         getglobal("MTPassive"..gLastPassiveHighlight):SetChecked(false)
      end
      if gLastCooldownHighlight > 0 then
         getglobal("MTCooldown"..gLastCooldownHighlight):SetChecked(false)
      end

      gLastPassiveHighlight = bnum
      gLastCooldownHighlight = 0

      --if not gPassivesOn then
         -- manual equip
      --   PickupContainerItem(gPassiveTrinkets[bnum-1].bag, gPassiveTrinkets[bnum-1].slot)
         
      --   if button == "LeftButton" then
      --      PickupInventoryItem(13)
      --   else
      --      PickupInventoryItem(14)
      --   end
      --end
   else
      if bnum == gLastCooldownHighlight then
         -- keep it highlighted
         getglobal("MTCooldown"..gLastCooldownHighlight):SetChecked(true)
         return
      end

      if gLastPassiveHighlight > 0 then
         getglobal("MTPassive"..gLastPassiveHighlight):SetChecked(false)
      end
      if gLastCooldownHighlight > 0 then
         getglobal("MTCooldown"..gLastCooldownHighlight):SetChecked(false)
      end

      gLastPassiveHighlight = 0
      gLastCooldownHighlight = bnum

      --if not gCooldownsOn then
         -- manual equip
      --   PickupContainerItem(gCooldownTrinkets[bnum-1].bag, gCooldownTrinkets[bnum-1].slot)
         
      --   if button == "LeftButton" then
      --      PickupInventoryItem(13)
      --   else
      --      PickupInventoryItem(14)
      --   end         
      --end
   end
end

local function MTGetEquippedName(slot)
   itemLink = GetInventoryItemLink("player", slot)
    _,_,name = string.find(itemLink or "","item:%d+.+%[(.+)%]")
    return name
end

local function MTDoNothing()

end

function MTLockChkClick()
   if this:GetID() == 1 then
      gLock1 = not gLock1
      MTLock1:SetChecked(gLock1)
   else
      gLock2 = not gLock2
      MTLock2:SetChecked(gLock2)
   end
end

function MTTrinketChkClick()
   if this:GetID() == 1 then
      gPassivesOn = not gPassivesOn
      MTPassiveOn:SetChecked(gPassivesOn)
   else
      gCooldownsOn = not gCooldownsOn
      MTCooldownOn:SetChecked(gCooldownsOn)
   end
end
      

-- change priorities

local function MTSwapCooldowns(trink1, trink2)
   temp = {}

   MTTCopy(temp, gCooldownTrinkets[trink1])

   MTTCopy(gCooldownTrinkets[trink1], gCooldownTrinkets[trink2])

   MTTCopy(gCooldownTrinkets[trink2], temp)
end

function MTSwapPassives(trink1, trink2)
   temp = {}

   MTTCopy(temp, gPassiveTrinkets[trink1])

   MTTCopy(gPassiveTrinkets[trink1], gPassiveTrinkets[trink2])

   MTTCopy(gPassiveTrinkets[trink2], temp)
end

function MTChgPriorityLeft()
   if gLastPassiveHighlight == 0 then
      -- already has top priority
      if gLastCooldownHighlight == 1 then
         return
      end
      MTSwapCooldowns(gLastCooldownHighlight-1, gLastCooldownHighlight-2)

      getglobal("MTCooldown"..gLastCooldownHighlight):SetChecked(false)
      getglobal("MTCooldown"..gLastCooldownHighlight-1):SetChecked(true)
      gLastCooldownHighlight = gLastCooldownHighlight-1
   else
      -- already has top priority
      if gLastPassiveHighlight == 1 then
         return
      end
      MTSwapPassives(gLastPassiveHighlight-1, gLastPassiveHighlight-2)

      getglobal("MTPassive"..gLastPassiveHighlight):SetChecked(false)
      getglobal("MTPassive"..gLastPassiveHighlight-1):SetChecked(true)
      gLastPassiveHighlight = gLastPassiveHighlight-1
   end

   MTLoad()
   MTShow()
end

function MTChgPriorityUp()
   if gLastPassiveHighlight == 0 then
      -- already has top priority
      if gLastCooldownHighlight == 1 then
         return
      end
      destination = math.max(gLastCooldownHighlight-5, 1)
      for i=destination-1, gLastCooldownHighlight-2 do
         MTSwapCooldowns(gLastCooldownHighlight-1-i, gLastCooldownHighlight-2-i)
      end

      getglobal("MTCooldown"..gLastCooldownHighlight):SetChecked(false)
      getglobal("MTCooldown"..destination):SetChecked(true)
      gLastCooldownHighlight = destination
   else
      -- already has top priority
      if gLastPassiveHighlight == 1 then
         return
      end
      destination = math.max(gLastPassiveHighlight-5, 1)
      for i=destination-1, gLastPassiveHighlight-2 do
         MTSwapPassives(gLastPassiveHighlight-1-i, gLastPassiveHighlight-2-i)
      end

      getglobal("MTPassive"..gLastPassiveHighlight):SetChecked(false)
      getglobal("MTPassive"..destination):SetChecked(true)
      gLastPassiveHighlight = destination
   end

   MTLoad()
   MTShow()
end

function MTChgPriorityRight()
   if gLastPassiveHighlight == 0 then
      -- already has lowest priority
      if gLastCooldownHighlight == gNumCooldownTrinkets then
         return
      end
      MTSwapCooldowns(gLastCooldownHighlight-1, gLastCooldownHighlight)

      getglobal("MTCooldown"..gLastCooldownHighlight):SetChecked(false)
      getglobal("MTCooldown"..gLastCooldownHighlight+1):SetChecked(true)
      gLastCooldownHighlight = gLastCooldownHighlight+1
   else
      -- already has lowest priority
      if gLastPassiveHighlight == gNumPassiveTrinkets then
         return
      end
      MTSwapPassives(gLastPassiveHighlight-1, gLastPassiveHighlight)

      getglobal("MTPassive"..gLastPassiveHighlight):SetChecked(false)
      getglobal("MTPassive"..gLastPassiveHighlight+1):SetChecked(true)
      gLastPassiveHighlight = gLastPassiveHighlight+1
   end

   MTLoad()
   MTShow()
end

function MTChgPriorityDown()
   if gLastPassiveHighlight == 0 then
      -- already has lowest priority
      if gLastCooldownHighlight == gNumCooldownTrinkets then
         return
      end
      destination = math.min(gLastCooldownHighlight+5, gNumCooldownTrinkets)
      for i=gLastCooldownHighlight-1, destination-2 do
         MTSwapCooldowns(i, i+1)
      end

      getglobal("MTCooldown"..gLastCooldownHighlight):SetChecked(false)
      getglobal("MTCooldown"..destination):SetChecked(true)
      gLastCooldownHighlight = destination
   else
      -- already has lowest priority
      if gLastPassiveHighlight == gNumPassiveTrinkets then
         return
      end
      destination = math.min(gLastPassiveHighlight+5, gNumPassiveTrinkets)
      for i=gLastPassiveHighlight-1, destination-2 do
         MTSwapPassives(i, i+1)
      end

      getglobal("MTPassive"..gLastPassiveHighlight):SetChecked(false)
      getglobal("MTPassive"..destination):SetChecked(true)
      gLastPassiveHighlight = destination
   end

   MTLoad()
   MTShow()
end

-- transfer lists

function MTXPassiveToCooldown()
   if gNumPassiveTrinkets == 0 or gLastPassiveHighlight == 0 then
      return
   end
   
   tooltrinket = MTRemoveFromList(gPassiveTrinkets, gNumPassiveTrinkets, gLastPassiveHighlight-1)
   gNumPassiveTrinkets = gNumPassiveTrinkets - 1
 
   -- if empty, hide last slot
   if gNumPassiveTrinkets == 0 then
      MTPassive1:Hide()
      for i = 1, getn(gPalettes) do
         getglobal(gPalettes[i].."TrinketsPassive1"):Hide()
      end
   end

   if not gCooldownTrinkets[gNumCooldownTrinkets] then
      gCooldownTrinkets[gNumCooldownTrinkets] = {}
   end

   MTTCopy(gCooldownTrinkets[gNumCooldownTrinkets], tooltrinket)
   gNumCooldownTrinkets = gNumCooldownTrinkets + 1

   getglobal("MTPassive"..gLastPassiveHighlight):SetChecked(false)
   getglobal("MTCooldown"..gNumCooldownTrinkets):SetChecked(true)

   gLastCooldownHighlight = gNumCooldownTrinkets
   gLastPassiveHighlight = 0

   -- refresh auto-use
   MTRefreshAutoUseState()

   -- update display
   MTLoad()
   MTShow()
end

function MTXCooldownToPassive()
   if gNumCooldownTrinkets == 0 or gLastCooldownHighlight == 0 then
      return
   end

   tooltrinket = MTRemoveFromList(gCooldownTrinkets, gNumCooldownTrinkets, gLastCooldownHighlight-1)
   gNumCooldownTrinkets = gNumCooldownTrinkets - 1

   -- if empty, hide last slot
   if gNumCooldownTrinkets == 0 then
      MTCooldown1:Hide()
      for i = 1, getn(gPalettes) do
         getglobal(gPalettes[i].."TrinketsCooldown1"):Hide()
      end
   end
 
   if not gPassiveTrinkets[gNumPassiveTrinkets] then
      gPassiveTrinkets[gNumPassiveTrinkets] = {}
   end

   MTTCopy(gPassiveTrinkets[gNumPassiveTrinkets], tooltrinket)
   gNumPassiveTrinkets = gNumPassiveTrinkets + 1

   getglobal("MTCooldown"..gLastCooldownHighlight):SetChecked(false)
   getglobal("MTPassive"..gNumPassiveTrinkets):SetChecked(true)

   gLastCooldownHighlight = 0
   gLastPassiveHighlight = gNumPassiveTrinkets

   -- refresh auto-use
   MTRefreshAutoUseState()

   -- update display
   MTLoad()
   MTShow()
end
     
-- moving window around
function MTMoveOnMouseUp(arg1, frame)
	if arg1=="LeftButton" then
		frame:StopMovingOrSizing()
   end
end
function MTMoveOnMouseDown(arg1, frame)
   if not gOpts.LockFrame and arg1=="LeftButton" then
		frame:StartMoving()
	end
end

-- tooltip

-- deprecated
--function MTShowChkTooltip()

--   if this:GetRight()+200 < GetScreenWidth() then
--      GameTooltip:SetOwner(this,"ANCHOR_BOTTOMRIGHT")
--	else
--	   GameTooltip:SetOwner(this,"ANCHOR_BOTTOMLEFT")
--   end

--   GameTooltip:AddLine("If this is unchecked, you can right/left")
--   GameTooltip:AddLine("click to equip trinkets yourself.")

--   GameTooltip:Show()
--end

function MTShowLockTooltip()
   GameTooltip:SetOwner(this,"ANCHOR_BOTTOMRIGHT")
   GameTooltip:AddLine(MT_TXT_LOCKED_Q)
   GameTooltip:Show()   
end

totaltooltipelapsed = 0

function MTUpdateTooltip(elapsed)
   if not GameTooltip:IsOwned(this) then
      return
   end

   totaltooltipelapsed = totaltooltipelapsed + elapsed

   if totaltooltipelapsed > TOOLTIP_UPDATE_TIME then
      MTShowTooltip()
      totaltooltipelapsed = 0
   end
end

local function MTIsPassivePalette(btyp)
   local i

   for i = 1, getn(gPalettes) do
      if btyp == gPalettes[i].."TrinketsPassive" then
         return true
      end
   end

   return false
end

local function MTIsCooldownPalette(btyp)
   local i

   for i = 1, getn(gPalettes) do
      if btyp == gPalettes[i].."TrinketsCooldown" then
         return true
      end
   end

   return false
end

function MTShowTooltip()
   if not this:GetRight() then
      return;
   end

   _,_,btyp,bnum = string.find(this:GetName(),"(%a+)(%d+)")

   bnum = tonumber(bnum)

   local tooltrinket = nil

   if btyp == "MTPassive" or MTIsPassivePalette(btyp) then
      if gPassiveTrinkets[bnum-1].bag == WEARING then
         if not MTIsInInventory(gPassiveTrinkets[bnum-1]) then
            return
         end
         bnum = gPassiveTrinkets[bnum-1].slot * -1
      else
         if not MTIsInBags(gPassiveTrinkets[bnum-1]) then
            return
         end
         tooltrinket = gPassiveTrinkets[bnum-1]
      end
      cmpscale = gButtonsScale
   elseif btyp == "MTCooldown" or MTIsCooldownPalette(btyp) then
      if gCooldownTrinkets[bnum-1].bag == WEARING then
         if not MTIsInInventory(gCooldownTrinkets[bnum-1]) then
            return
         end
         bnum = gCooldownTrinkets[bnum-1].slot * -1
      else
         if not MTIsInBags(gCooldownTrinkets[bnum-1]) then
            return
         end
         tooltrinket = gCooldownTrinkets[bnum-1]
      end
      cmpscale = gButtonsScale
   elseif btyp == "MTEquipped" then      
      --if bnum == 1 then
      --   itemLink = GetInventoryItemLink("player", 13)
      --   _,_,trinketid = string.find(itemLink or "","item:(%d+).+%[(.+)%]")
      --else
      --   itemLink = GetInventoryItemLink("player", 14)
      --   _,_,trinketid = string.find(itemLink or "","item:(%d+).+%[(.+)%]")
      --end
      cmpscale = 1.0
   end

   if this:GetRight()*cmpscale+300 < GetScreenWidth() then
      GameTooltip:SetOwner(this,"ANCHOR_BOTTOMRIGHT")
	else
	   GameTooltip:SetOwner(this,"ANCHOR_BOTTOMLEFT")
   end
   --GameTooltip:SetOwner(this,"ANCHOR_CURSOR")

   if not tooltrinket then      
      if bnum == 1 then
         GameTooltip:SetInventoryItem("player", 13)
      else
         GameTooltip:SetInventoryItem("player", 14)
      end
   else     
      GameTooltip:SetBagItem(tooltrinket.bag, tooltrinket.slot)
   end

   GameTooltip:Show()
end

gCurrAutoUseSlot = -1
gCurrAutoUseTyp = nil

local function MTLoadCurrAutoUseData()

   local oldfunc = MTSaveCurrAutoUseData
   MTSaveCurrAutoUseData = MTDoNothing

   --assert(gCurrAutoUseSlot >= 0)
   --message(debugstack())

   --if MTIsPassivePalette(gCurrAutoUseTyp) then
   
   --else

      --if gCooldownTrinkets[gCurrAutoUseSlot].autoUseOn == nil then
      --   gCooldownTrinkets[gCurrAutoUseSlot].autoUseOn = false
      --end
      MTAutoUseOn:SetChecked(gCooldownTrinkets[gCurrAutoUseSlot].autoUseOn)
      
      --if gCooldownTrinkets[gCurrAutoUseSlot].playerCheck == nil then
      --   gCooldownTrinkets[gCurrAutoUseSlot].playerCheck = false
      --end
      MTAutoUsePlayerCheckOn:SetChecked(gCooldownTrinkets[gCurrAutoUseSlot].playerCheck)

      if not gCooldownTrinkets[gCurrAutoUseSlot].playerMin then
         gCooldownTrinkets[gCurrAutoUseSlot].playerMin = 0.5
      end
      MTPlyHealthRangeSliderLeft:SetValue(gCooldownTrinkets[gCurrAutoUseSlot].playerMin)
      
      if not gCooldownTrinkets[gCurrAutoUseSlot].playerMax then
         gCooldownTrinkets[gCurrAutoUseSlot].playerMax = 0.5
      end
      MTPlyHealthRangeSliderRight:SetValue(gCooldownTrinkets[gCurrAutoUseSlot].playerMax)

      --if gCooldownTrinkets[gCurrAutoUseSlot].enemyCheck == nil then
      --   gCooldownTrinkets[gCurrAutoUseSlot].enemyCheck = false
      --end
      MTAutoUseEnemyCheckOn:SetChecked(gCooldownTrinkets[gCurrAutoUseSlot].enemyCheck)

      if not gCooldownTrinkets[gCurrAutoUseSlot].enemyMin then
         gCooldownTrinkets[gCurrAutoUseSlot].enemyMin = 0.5
      end
      MTEnyHealthRangeSliderLeft:SetValue(gCooldownTrinkets[gCurrAutoUseSlot].enemyMin)

      if not gCooldownTrinkets[gCurrAutoUseSlot].enemyMax then
         gCooldownTrinkets[gCurrAutoUseSlot].enemyMax = 0.5
      end
      MTEnyHealthRangeSliderRight:SetValue(gCooldownTrinkets[gCurrAutoUseSlot].enemyMax)
   --end

   MTSaveCurrAutoUseData = oldfunc
end

function MTSaveCurrAutoUseData()
   --if MTIsPassivePalette(gCurrAutoUseTyp) then
   --   gPassiveTrinkets[gCurrAutoUseSlot].autoUseOn = MTAutoUseOn:GetChecked()
   --   gPassiveTrinkets[gCurrAutoUseSlot].playerCheck = MTAutoUsePlayerCheckOn:GetChecked()
   --   gPassiveTrinkets[gCurrAutoUseSlot].playerMin = MTPlyHealthRangeSliderLeft:GetValue()
   --   gPassiveTrinkets[gCurrAutoUseSlot].playerMax = MTPlyHealthRangeSliderRight:GetValue()
   --   gPassiveTrinkets[gCurrAutoUseSlot].enemyCheck = MTAutoUseEnemyCheckOn:GetChecked()
   --   gPassiveTrinkets[gCurrAutoUseSlot].enemyMin = MTEnyHealthRangeSliderLeft:GetValue()
   --   gPassiveTrinkets[gCurrAutoUseSlot].enemyMax = MTEnyHealthRangeSliderRight:GetValue()
   --else
      gCooldownTrinkets[gCurrAutoUseSlot].autoUseOn = MTAutoUseOn:GetChecked()
      gCooldownTrinkets[gCurrAutoUseSlot].playerCheck = MTAutoUsePlayerCheckOn:GetChecked()
      gCooldownTrinkets[gCurrAutoUseSlot].playerMin = MTPlyHealthRangeSliderLeft:GetValue()
      gCooldownTrinkets[gCurrAutoUseSlot].playerMax = MTPlyHealthRangeSliderRight:GetValue()
      gCooldownTrinkets[gCurrAutoUseSlot].enemyCheck = MTAutoUseEnemyCheckOn:GetChecked()
      gCooldownTrinkets[gCurrAutoUseSlot].enemyMin = MTEnyHealthRangeSliderLeft:GetValue()
      gCooldownTrinkets[gCurrAutoUseSlot].enemyMax = MTEnyHealthRangeSliderRight:GetValue()
   --end

end

function MTRefreshAutoUseState()
   --if gNumPassiveTrinkets == 0 and gNumCooldownTrinkets == 0 then
   if gNumCooldownTrinkets == 0 then
      MTShowAutoUse:Disable()
      lblShowAutoUse:SetTextColor(0.5, 0.5, 0.5)
   else
      MTShowAutoUse:Enable()
      lblShowAutoUse:SetTextColor(1.0, 0.8196078431372, 0.0)
   end
end

local function MTAutoUseClearSelectors()

   for i=1,35 do
      --getglobal("MTFrameAutoUseTrinketsPassive"..i):SetChecked(false)
      getglobal("MTFrameAutoUseTrinketsCooldown"..i):SetChecked(false)
   end

end

function MTAutoUseInit()
   MTRefreshAutoUseState()

   if gCurrAutoUseSlot <= 0 then
      
      MTAutoUseClearSelectors()
      
      --if gNumPassiveTrinkets > 0 then
      --   gCurrAutoUseSlot = 0
      --   gCurrAutoUseTyp = "MTFrameAutoUseTrinketsPassive"         
      --   MTFrameAutoUseTrinketsPassive1:SetChecked(true)
      --   MTLoadCurrAutoUseData()
      --elseif gNumCooldownTrinkets > 0 then
      if gNumCooldownTrinkets > 0 then
         -- oh no you don't!
         local oldfunc = MTSaveCurrAutoUseData
         MTSaveCurrAutoUseData = MTDoNothing
         gCurrAutoUseSlot = 0
         gCurrAutoUseTyp = "MTFrameAutoUseTrinketsCooldown"
         MTFrameAutoUseTrinketsCooldown1:SetChecked(true)
         MTLoadCurrAutoUseData()
         MTSaveCurrAutoUseData = oldfunc
      end
   end

   MTLoad()
end

function MTAutoUseSlotClick(button)
   _,_,typ,bnum = string.find(this:GetName(),"(%a+)(%d+)")

   getglobal(gCurrAutoUseTyp..(gCurrAutoUseSlot+1)):SetChecked(false)

   bnum = tonumber(bnum)-1
   gCurrAutoUseSlot = bnum
   gCurrAutoUseTyp = typ

   getglobal(gCurrAutoUseTyp..(gCurrAutoUseSlot+1)):SetChecked(true)

   MTLoadCurrAutoUseData()
   MTLoad()
end

gDisableManualSwap = false

function MTPaletteSlotClick(button)
   this:SetChecked(false)

   -- if cursor has an object in it or Update is running, don't mess with it and return failure
   if CursorHasItem() or gDisableManualSwap then
      return
   end

   -- hijack update
   local oldfunc = MTUpdate
   MTUpdate = MTDoNothing
 
   _,_,typ, bnum = string.find(this:GetName(),"(%a+)(%d+)")

   bnum = tonumber(bnum)-1

   MTLoad()

   if MTIsPassivePalette(typ) then
      if gPassiveTrinkets[bnum].slot == TRINKETSLOT1 then
         if not MTIsInInventory(gPassiveTrinkets[bnum]) then
            MTUpdate = oldfunc
            return
         end
         PickupInventoryItem(13)
      elseif gPassiveTrinkets[bnum].slot == TRINKETSLOT2 then
         if not MTIsInInventory(gPassiveTrinkets[bnum]) then
            MTUpdate = oldfunc
            return
         end
         PickupInventoryItem(14)
      else
         if not MTIsInBags(gPassiveTrinkets[bnum]) then
            MTUpdate = oldfunc
            return
         end
         PickupContainerItem(gPassiveTrinkets[bnum].bag, gPassiveTrinkets[bnum].slot)
      end

      if not CursorHasItem then
         MTUpdate = oldfunc
         return
      end
      
      if button == "LeftButton" then
         PickupInventoryItem(13)
         if CursorHasItem() then
            EquipCursorItem(13)
         end
      else
         PickupInventoryItem(14)
         if CursorHasItem() then
            EquipCursorItem(14)
         end
      end         
   else
      if gCooldownTrinkets[bnum].slot == TRINKETSLOT1 then
         if not MTIsInInventory(gCooldownTrinkets[bnum]) then
            MTUpdate = oldfunc
            return
         end
         PickupInventoryItem(13)
      elseif gCooldownTrinkets[bnum].slot == TRINKETSLOT2 then
         if not MTIsInInventory(gCooldownTrinkets[bnum]) then
            MTUpdate = oldfunc
            return
         end
         PickupInventoryItem(14)
      else
         if not MTIsInBags(gCooldownTrinkets[bnum]) then
            MTUpdate = oldfunc
            return
         end
         PickupContainerItem(gCooldownTrinkets[bnum].bag, gCooldownTrinkets[bnum].slot)
      end

      if not CursorHasItem then
         MTUpdate = oldfunc
         return
      end
      
      if button == "LeftButton" then
         PickupInventoryItem(13)
         if CursorHasItem() then
            EquipCursorItem(13)
         end
      else
         PickupInventoryItem(14)
         if CursorHasItem() then
            EquipCursorItem(14)
         end
      end         
   end

   if button == "LeftButton" then
      gAutoTrinketEquip1 = false
      gLock1 = true
   else
      gAutoTrinketEquip2 = false
      gLock2 = true
   end

   MTLoad()
   MTShow()
   MTUpdate = oldfunc  
end

-- reset lists
function MTReset()
   for i=1,gNumCooldownTrinkets do
      getglobal("MTCooldown"..i):Hide()
   end
   
   gNumPassiveTrinkets = 0
   gNumCooldownTrinkets = 0

   MTLoad()
   MTShow()
end

-- Auto-Use
function MTHealthRangeInit()

   if string.find(this:GetName(), "Left") then
      undertxt = MT_TXT_MINIMUM
   else
      undertxt = MT_TXT_MAXIMUM
   end
   getglobal(this:GetName().."Text"):SetText(undertxt)
   getglobal(this:GetName().."Low"):SetText("0%")
   getglobal(this:GetName().."High"):SetText("100%")

   this:SetMinMaxValues(0, 1)
   this:SetValueStep(0.01)
   this:SetValue(0.5)
   this.tooltipText = "Set the range for which the trinket will be used"
end

function MTHealthRangeChanged()

   _,_,basename = string.find(this:GetName(), "(%a+)[LR][ei][fg][th]")
   left = getglobal(basename.."Left")
   right = getglobal(basename.."Right")

   -- left side
   if this:GetID() == 1 then
      if right then
         if this:GetValue() > right:GetValue() then
            right:SetValue(this:GetValue())
         end
      end
   else
      if left then
         if this:GetValue() < left:GetValue() then
            left:SetValue(this:GetValue())
         end
      end
   end
   
   if left then
      formatpct = string.format("%.0f%%", left:GetValue()*100)
      pcttext = getglobal(this:GetParent():GetName().."lblTopPct")
      pcttext:SetText(formatpct)
      if left:GetValue() < 0.10 then
         red = 1.0
         green = 0.0
      else
         if left:GetValue() > 0.90 then
            green = 1.0
            red = 0.0
         else
            if left:GetValue() > 0.40 then
               if left:GetValue() < 0.60 then
                  green = 1.0
                  red = 1.0
               else
                  t = (left:GetValue()-0.60)/0.30
                  red = 1 - t
                  green = 1.0
               end
            else
               t = (left:GetValue()-0.10)/0.30
               red = 1.0
               green = t
            end
         end
      end
      pcttext:SetTextColor(red, green, 0.0)
   end
   if right then
      formatpct = string.format("%.0f%%", right:GetValue()*100)
      pcttext = getglobal(this:GetParent():GetName().."lblBottomPct")
      pcttext:SetText(formatpct)
      if right:GetValue() < 0.10 then
         red = 1.0
         green = 0.0
      else
         if right:GetValue() > 0.90 then
            green = 1.0
            red = 0.0
         else
            if right:GetValue() > 0.40 then
               if right:GetValue() < 0.60 then
                  green = 1.0
                  red = 1.0
               else
                  t = (right:GetValue()-0.60)/0.30
                  red = 1 - t
                  green = 1.0
               end
            else
               t = (right:GetValue()-0.10)/0.30
               red = 1.0
               green = t
            end
         end
      end
      pcttext:SetTextColor(red, green, 0.0)
   end

   if gCurrAutoUseSlot >= 0 then
      MTSaveCurrAutoUseData()
   end
end

local function MTUpdateAdvanced()
   if gAdvancedOpen then
      MTAdvanced:SetText(MT_TXT_ADVANCED.." <<")
      Advanced:Show()      
   else
      MTAdvanced:SetText(MT_TXT_ADVANCED.." >>")
      Advanced:Hide()
   end

   MTLoad()
   MTShow()
end

function MTToggleAdvanced()
   gAdvancedOpen = not gAdvancedOpen
   MTUpdateAdvanced()
end

local function MTSaveCurrentSetup()
   gSetupList[gCurrSetup].numPassives = gNumPassiveTrinkets
   gSetupList[gCurrSetup].numCooldowns = gNumCooldownTrinkets

   total = gNumPassiveTrinkets + gNumCooldownTrinkets

   local i

   for i=gNumPassiveTrinkets,total do
      if gSetupList[gCurrSetup].passiveList[i] then
         gSetupList[gCurrSetup].passiveList[i] = nil
      end
   end
   for i=gNumCooldownTrinkets,total do
      if gSetupList[gCurrSetup].cooldownList[i] then
         gSetupList[gCurrSetup].cooldownList[i] = nil
      end
   end
end

local function MTSetCurrentSetup()
   gPassiveTrinkets = gSetupList[gCurrSetup].passiveList
   gNumPassiveTrinkets = gSetupList[gCurrSetup].numPassives
   gCooldownTrinkets = gSetupList[gCurrSetup].cooldownList
   gNumCooldownTrinkets = gSetupList[gCurrSetup].numCooldowns
  
   -- prevent locking
   gAutoTrinketEquip1 = true
   gAutoTrinketEquip2 = true

   -- hijack update
   oldfunc = MTUpdate
   MTUpdate = MTDoNothing

   MTLoad()
   if MTFrameEquipped:IsVisible() then
      MTShow()
   end

   MTUpdate = oldfunc
end

function MTDeleteSetup()
   if gCurrSetup == 1 then
      return
   end

   tremove(gSetupList, gCurrSetup)
   gCurrSetup = 1
   MTSetCurrentSetup()
   MTSetupDropDownInit()
   MTContinentDropDownInit()
   MTZoneDropDownInit()
end

gSetupDDElapsed = 0

function MTSetupDropDownUpdate(elapsed)
   
   gSetupDDElapsed = gSetupDDElapsed + elapsed

   if gSetupDDElapsed > 15.0 then
      CloseDropDownMenus()
   end
end

function MTToggleDropDownMenu(arg1, arg2, arg3, arg4, arg5, arg6)

   gOldToggleDropDownMenu(arg1, arg2, arg3, arg4, arg5, arg6)

   if not MTCurrentSetupDropDown:IsVisible() then
      return
   end

   gSetupDDElapsed = 0
end

function MTSetupDDEnter(arg1)

   gOldUIDropDownMenu_StopCounting(arg1)

   if not MTCurrentSetupDropDown:IsVisible() then
      return
   end

   gSetupDDElapsed = -1000
end

function MTSetupDDLeave(arg1)

   gOldUIDropDownMenu_StartCounting(arg1)

   if not MTCurrentSetupDropDown:IsVisible() then
      return
   end

   gSetupDDElapsed = 0
end

------------------- Setup drop down

function MTAddNewSetup()
   newsetup = MTNewSetupText:GetText()
   
   if newsetup ~= "" then

      tinsert(gSetupList, {
                              name = newsetup,
                              passiveList = {},
                              numPassives = 0,
                              cooldownList = {},
                              numCooldowns = 0,
                              autoload = 1,
                              zone = 0,
                              zonename = ""
                           })
      MTSaveCurrentSetup()
      gCurrSetup = getn(gSetupList)
      MTSetCurrentSetup()
      MTSetupDropDownInit()
      MTContinentDropDownInit()
      MTZoneDropDownInit()
   end
end

function MTSetupDropDownOnClick()
   UIDropDownMenu_SetSelectedID(MTCurrentSetupDropDown, this:GetID());
   MTSaveCurrentSetup()
   gCurrSetup = MTCurrentSetupDropDown.selectedID         
   MTSetCurrentSetup()
   MTContinentDropDownInit()
   MTZoneDropDownInit()
   MTAutoUseInit()
end

gOldToggleDropDownMenu = 0
gOldUIDropDownMenu_StopCounting = 0
gOldUIDropDownMenu_StartCounting = 0

function MTSetupDropDownInit()
   local info

   UIDropDownMenu_ClearAll(MTCurrentSetupDropDown)
   DropDownList1.numButtons = 0

   for i=1,getn(gSetupList) do 
      info = {}
      info.text = gSetupList[i].name
      info.func = MTSetupDropDownOnClick
      UIDropDownMenu_AddButton(info)
   end

   UIDropDownMenu_SetSelectedID(MTCurrentSetupDropDown, gCurrSetup, 1);
end

function MTLoadSetupDropDown()
   UIDropDownMenu_Initialize(MTCurrentSetupDropDown, MTSetupDropDownInit)
   UIDropDownMenu_SetWidth(130, MTCurrentSetupDropDown)
   
   gOldToggleDropDownMenu = ToggleDropDownMenu
   gOldUIDropDownMenu_StopCounting = UIDropDownMenu_StopCounting
   gOldUIDropDownMenu_StartCounting = UIDropDownMenu_StartCounting

   ToggleDropDownMenu = MTToggleDropDownMenu
   UIDropDownMenu_StopCounting = MTSetupDDEnter
   UIDropDownMenu_StartCounting = MTSetupDDLeave
end

------------------- Continent drop down

local function MTGetZones(...)
   zones = {}

   for i=1,arg.n do
      tinsert(zones, arg[i])
   end

   return zones
end

local function MTGetInstances()
   
   instances = MT_TXT_DUNGEONS_LIST
   
   return instances
end

local function MTGetPVPs()
   
   PVPs = MT_TXT_PVPS_LIST

   return PVPs
end

function MTContinentDropDownOnClick()
   UIDropDownMenu_SetSelectedID(MTContinentDropDown, this:GetID())

   -- current zone
   if gCurrSetup ~= 1 and MTContinentDropDown.selectedID == 2 then

      zones = MTGetInstances()
      idx = MTFindInArray(zones, gLastZone)
      if idx > 0 then
         gSetupList[gCurrSetup].autoload = getn(continents)-1
         gSetupList[gCurrSetup].zone = idx
         gSetupList[gCurrSetup].zonename = gLastZone
      end

      if idx == 0 then
         zones = MTGetPVPs()
         idx = MTFindInArray(zones, gLastZone)
         if idx > 0 then
            gSetupList[gCurrSetup].autoload = getn(continents)
            gSetupList[gCurrSetup].zone = idx
            gSetupList[gCurrSetup].zonename = gLastZone
         end
      end

      if idx == 0 then
         currcont = GetCurrentMapContinent()
         gSetupList[gCurrSetup].autoload = currcont+2
         zones = MTGetZones(GetMapZones(currcont))
         idx = MTFindInArray(zones, gLastZone)
         if idx > 0 then
            gSetupList[gCurrSetup].autoload = currcont+2
            gSetupList[gCurrSetup].zone = idx
            gSetupList[gCurrSetup].zonename = gLastZone
         end
      end

      UIDropDownMenu_SetSelectedID(MTContinentDropDown, gSetupList[gCurrSetup].autoload, 1);
      --UIDropDownMenu_SetSelectedID(MTZoneDropDown, gSetupList[gCurrSetup].zone, 1)
      MTZoneDropDownInit()
   else
      gSetupList[gCurrSetup].autoload = MTContinentDropDown.selectedID
      gSetupList[gCurrSetup].zone = 0
      MTZoneDropDownInit()
   end

   if gSetupList[gCurrSetup].autoload == 1 or (gCurrSetup == 1 and gSetupList[1].autoload == 2) then
      MTZoneDropDown:Hide()
      return
   end
   
   MTZoneDropDown:Show()
end

local function MTGetContinents(...)
   continents = {}

   for i=1,arg.n do
      tinsert(continents, arg[i])
   end

   return continents
end

function MTContinentDropDownInit()
   local info

   UIDropDownMenu_ClearAll(MTContinentDropDown)
   DropDownList1.numButtons = 0

   if gCurrSetup == 1 then
      continents = {}
      tinsert(continents, MT_TXT_LOAD_IF_ELSE)
   else
      continents = MTGetContinents(GetMapContinents())
      tinsert(continents, MT_TXT_DUNGEONS)
      tinsert(continents, MT_TXT_PVP)
      tinsert(continents, 1, MT_TXT_CURRENT_ZONE)
   end
   
   tinsert(continents, 1, MT_TXT_LOAD_MYSELF)

   for i=1,getn(continents) do 
      info = {}
      info.text = continents[i]
      info.func = MTContinentDropDownOnClick
      UIDropDownMenu_AddButton(info)
   end

   UIDropDownMenu_SetSelectedID(MTContinentDropDown, gSetupList[gCurrSetup].autoload, 1);

   if gSetupList[gCurrSetup].autoload == 1 or (gCurrSetup == 1 and gSetupList[1].autoload == 2) then
      MTZoneDropDown:Hide()
   else
      MTZoneDropDown:Show()
   end
end

function MTLoadContinentDropDown()
   UIDropDownMenu_Initialize(MTContinentDropDown, MTContinentDropDownInit)
   UIDropDownMenu_SetWidth(95, MTContinentDropDown)
end

------------------- Zone drop down

function MTZoneDropDownOnClick()
   UIDropDownMenu_SetSelectedID(MTZoneDropDown, this:GetID())
   gSetupList[gCurrSetup].zone = MTZoneDropDown.selectedID
   gSetupList[gCurrSetup].zonename = MTZoneDropDownText:GetText()
end

function MTZoneDropDownInit()
   local info

   if MTContinentDropDown.selectedID == 1 then
      return
   end

   UIDropDownMenu_ClearAll(MTZoneDropDown)
   DropDownList1.numButtons = 0
   gZoneList = {}

   if MTContinentDropDown.selectedID == getn(continents)-1 then
      gZoneList = MTGetInstances()
   elseif MTContinentDropDown.selectedID == getn(continents) then  
      gZoneList = MTGetPVPs()
   else
      gZoneList = MTGetZones(GetMapZones(MTContinentDropDown.selectedID-2))
   end

   for i=1,getn(gZoneList) do 
      info = {}
      info.text = gZoneList[i]
      info.func = MTZoneDropDownOnClick
      UIDropDownMenu_AddButton(info)
   end

   if gSetupList[gCurrSetup].zone > 0 then
      UIDropDownMenu_SetSelectedID(MTZoneDropDown, gSetupList[gCurrSetup].zone, 1)
   end
end

gZoneList = nil

function MTLoadZoneDropDown()
   UIDropDownMenu_Initialize(MTZoneDropDown, MTZoneDropDownInit)
   UIDropDownMenu_SetWidth(85, MTZoneDropDown)
end

gLastZone = nil

local function MTListFindZone(zone)
   for i=1,getn(gSetupList) do
      if gSetupList[i].zonename == zone then
         return i
      end
   end

   return 0
end

function MTWorldUpdate()
   currzone = GetRealZoneText()

   lastidx = MTListFindZone(gLastZone)
   nowidx = MTListFindZone(currzone)

   --message(gLastZone..currzone)
   --message(lastidx..","..nowidx)

   if nowidx > 0 and lastidx ~= nowidx then
      MTSaveCurrentSetup()
      gCurrSetup = nowidx
      MTSetCurrentSetup()
      MTSetupDropDownInit()
      MTContinentDropDownInit()
      MTZoneDropDownInit()
      MTLoad()
      if MTFrameEquipped:IsVisible() then
         MTShow()
      end
   else
      if lastidx > 0 and lastidx ~= 1 and gSetupList[1].autoload == 2 then
         MTSaveCurrentSetup()
         gCurrSetup = 1
         MTSetCurrentSetup()
         MTSetupDropDownInit()
         MTContinentDropDownInit()
         MTZoneDropDownInit()
         MTLoad()
         if MTFrameEquipped:IsVisible() then
            MTShow()
         end
      end
   end

   if not UnitAffectingCombat("player") and not MTPlayerDead() then

      -- Plaguelands check

      dontask = not gOpts.AskArgentDawn
      if not dontask then
         _,_,_,dontask = MTFindInLists(MT_TXT_ARGENT_DAWN_SEAL)
      end
      if not dontask then
         _,_,_,dontask = MTFindInLists(MT_TXT_ARGENT_DAWN_RUNE)
      end
      if not dontask then
         _,_,_,dontask = MTFindInLists(MT_TXT_ARGENT_DAWN_COMM)
      end

      if MTJustEnteredUndead() and not dontask then
         itemLink = GetInventoryItemLink("player", 13)
         _,_,trinket1name = string.find(itemLink or "","item:%d+.+%[(.+)%]")
         itemLink = GetInventoryItemLink("player", 14)
         _,_,trinket2name = string.find(itemLink or "","item:%d+.+%[(.+)%]")

         if not string.find(trinket1name..trinket2name, MT_TXT_ARGENT_DAWN_COMM) and
            not string.find(trinket1name..trinket2name, MT_TXT_ARGENT_DAWN_SEAL) and
            not string.find(trinket1name..trinket2name, MT_TXT_ARGENT_DAWN_RUNE) then
            MTDialog(MT_TXT_ARGENT_DAWN_Q, MTFlagEquipADTrinket)
         end
      end
   end

   gLastZone = currzone
end

-- cooldowns

--totalcooldownelapsed = 0

function MTUpdateCooldown(elapsed)

   --totalcooldownelapsed = totalcooldownelapsed + elapsed

   --if totalcooldownelapsed < 0.5 then
      --return
   --end

   _,_,typ,bnum = string.find(this:GetName(),"(%a+)(%d+)")

   bnum = tonumber(bnum)

   cooldown = getglobal(this:GetName().."Cooldown")

   if typ == "MTEquipped" then
      start, duration, enable = GetInventoryItemCooldown("player", bnum+12)
   elseif typ == "MTPassive" or  MTIsPassivePalette(typ) then
      if bnum > gNumPassiveTrinkets then
         return
      end
      
      if gPassiveTrinkets[bnum-1].bag == WEARING then
         if MTIsInInventory(gPassiveTrinkets[bnum-1]) then
            start, duration, enable = GetInventoryItemCooldown("player", 12-gPassiveTrinkets[bnum-1].slot)
         else
            start, duration, enable = 0, 0, false
         end
      else
         if MTIsInBags(gPassiveTrinkets[bnum-1]) then
            start, duration, enable = GetContainerItemCooldown(gPassiveTrinkets[bnum-1].bag, gPassiveTrinkets[bnum-1].slot)
         else
            start, duration, enable = 0, 0, false
         end
      end
   else -- "Cooldown"
      if bnum > gNumCooldownTrinkets then
         return
      end

      if gCooldownTrinkets[bnum-1].bag == WEARING then
         if MTIsInInventory(gCooldownTrinkets[bnum-1]) then
            start, duration, enable = GetInventoryItemCooldown("player", 12-gCooldownTrinkets[bnum-1].slot)
         else
            start, duration, enable = 0, 0, false
         end
      else
         if MTIsInBags(gCooldownTrinkets[bnum-1]) then
            start, duration, enable = GetContainerItemCooldown(gCooldownTrinkets[bnum-1].bag, gCooldownTrinkets[bnum-1].slot)
         else
            start, duration, enable = 0, 0, false
         end
      end
      --message("setting "..start..", "..duration.." for bag "..gCooldownTrinkets[bnum-1].bag.." slot "..gCooldownTrinkets[bnum-1].slot)
   end

   CooldownFrame_SetTimer(cooldown, start, duration, enable)

   --totalcooldownelapsed = 0
end

-- main update loop

totalupdateelapsed = 0.0
updateframe = 0.0
sincebegan = 0.0

function MTSwap1()
   if not gLock1 and not MTSpecialCase(TRINKETSLOT1) and gUseTimer1 > 2.0 then
      
      local success = false

      -- equip carrot if player is on mount
      if gOpts.AutoEquipCarrot and MTIsOnMount() then
         success = EquipCarrot(13)
      end

      if gEquipADTrinket then
         success = EquipADTrinket(13)
         gLock1 = true
         gEquipADTrinket = false
      end

      if not success then
         if trinketid1 then            
            if type1 == "Passive" then
               if gCooldownsOn then
                  success = EquipFirstCooldown(13)
               end
               -- get the best passive one then
               if not success then
                  success = EquipFirstPassive(13, trinket1)
               end
            else
               -- if cooldowns are off, we need to switch out with passives
               if not gCooldownsOn then
                  success = EquipFirstPassive(13)
               else                  
                  -- only way we'd equip now is if there was something better ready
                  success = EquipFirstCooldown(13, trinket1)

                  if not success then
                     equipstart, equipduration = GetInventoryItemCooldown("player", 13)
                     -- if duration is greater than 30s it needs to be swapped
                     if GetTime() < equipstart+equipduration-30 then
                        if gCooldownsOn then 
                           success = EquipFirstCooldown(13)
                        end
                        if gPassivesOn and not success then
                           success = EquipFirstPassive(13)
                        end
                     end
                  end
               end
            end
         else
            -- just equip first cooldown or passive
            if gCooldownsOn then 
               success = EquipFirstCooldown(13)               
            end
            if gPassivesOn and not success then
               success = EquipFirstPassive(13)
            end
         end
      end

      if success and not ADAlreadyEquipped then
         gAutoTrinketEquip1 = true
      end            
   end
end

function MTSwap2()
   if not gLock2 and not MTSpecialCase(TRINKETSLOT2) and gUseTimer2 > 2.0 then
      
      local success = false

      -- equip carrot if player is on mount
      if gOpts.AutoEquipCarrot and MTIsOnMount() then
         success = EquipCarrot(14)
      end

      if gEquipADTrinket then
         success = EquipADTrinket(14)
         gLock2 = true
         gEquipADTrinket = false
      end
      
      if not success then
         if trinketid2 then
            if type2 == "Passive" then
               if gCooldownsOn then
                  success = EquipFirstCooldown(14)
               end
               -- get the best passive one then
               if not success then
                  success = EquipFirstPassive(14, trinket2)
               end
            else
               -- if cooldowns are off, we need to switch out with passives
               if not gCooldownsOn then
                  success = EquipFirstPassive(14)
               else
                  -- only way we'd equip now is if there was something better ready
                  success = EquipFirstCooldown(14, trinket2)

                  if not success then
                     equipstart, equipduration = GetInventoryItemCooldown("player", 14)
                     -- if duration is greater than 30s it needs to be swapped
                     if GetTime() < equipstart+equipduration-30 then
                        if gCooldownsOn then 
                           success = EquipFirstCooldown(14)
                        end
                        if gPassivesOn and not success then
                           success = EquipFirstPassive(14)
                        end
                     end
                  end
               end
            end
         else
            -- just equip first cooldown or passive
            if gCooldownsOn then 
               success = EquipFirstCooldown(14)               
            end
            if gPassivesOn and not success then
               success = EquipFirstPassive(14)
            end  
         end
      end

      if success and not ADAlreadyEquipped then
         gAutoTrinketEquip2 = true
      end 
   end
end

gBagUpdateTimer = 0.0

function MTUpdate(updateelapsed)

   sincebegan = sincebegan + updateelapsed

   gBagUpdateTimer = gBagUpdateTimer + updateelapsed

   totalupdateelapsed = totalupdateelapsed + updateelapsed

   gUseTimer1 = gUseTimer1 + updateelapsed
   gUseTimer2 = gUseTimer2 + updateelapsed

   if (totalupdateelapsed < 1.0) then
      return
   end

   --disable manual swapping while update is running
   gDisableManualSwap = true

   updateframe = updateframe + 1.0

   trinket1 = nil
   trinket2 = nil

   -- do a nice refresh
   MTLoad()
   
   MTFindEquippedTrinkets()

   if not UnitAffectingCombat("player") and not MTPlayerDead() then
      -- check to see if the equipped trinkets have a cooldown

      --if trinket1 and trinket2 then
         
         MTCalcEquippedPriorities()

         if trink1Priority > trink2Priority then
            MTSwap1()
            MTSwap2()
            --message("1,2")
         else
            MTSwap2()
            MTSwap1()
            --message("2,1")
         end
      --end
   end

   MTLoad()
   if MTFrameEquipped:IsVisible() then
      MTShow()
   end
   MTSaveCurrentSetup()

   gDisableManualSwap = false

   totalupdateelapsed = 0

end

-- event handler

function MTHandleEvent(event, arg1, arg2)
   if event == "PLAYER_LOGIN" then
      this:RegisterEvent("BAG_UPDATE")
      this:RegisterEvent("MINIMAP_ZONE_CHANGED")

      gLastZone = GetRealZoneText()
      
      MTFixOlderVersions()

      MTSetCurrentSetup()
      
      MTLoadSetupDropDown()
      MTLoadContinentDropDown()
      MTLoadZoneDropDown()
      
      MTUpdateAdvanced()
      MTLoadOptions()
      MTOptionsButtonInit()

      MTAutoUseInit()
      
      MTLoad()
      MTShow()

   elseif event == "VARIABLES_LOADED" then

   elseif event == "MINIMAP_ZONE_CHANGED" then
      
      MTWorldUpdate()

   elseif event == "BAG_UPDATE" then
      MTBagUpdateTimer = 0.0
      MTRefreshAutoUseState()
   end
end


-- slash handlers

function MTSlashHelp(arg1)

   local i

   for i=1,getn(MT_TXT_HELP_LIST) do
      DEFAULT_CHAT_FRAME:AddMessage(MT_TXT_HELP_PREFIX..MT_TXT_HELP_LIST[i], 225, 225, 0)
   end

end

function MTSlashShow(arg1)
   if MTFrameEquipped:IsVisible() then
      MTFrameEquipped:Hide()
      MTFrameTrinkets:Hide()
      MTFramePalette:Hide()
   else
      MTFrameEquipped:Show()
      if MTShowSetup:GetChecked() then
         MTFrameTrinkets:Show()
      end
      if MTShowPalette:GetChecked() then
         MTFramePalette:Show()
      end
   end
end

function MTSlashLoad(arg1)
   local i
   for i=1,getn(gSetupList) do
      if strlower(gSetupList[i].name) == strlower(arg1) then
         MTSetupDropDownInit()
         UIDropDownMenu_SetSelectedID(MTCurrentSetupDropDown, i)
         MTSaveCurrentSetup()
         gCurrSetup = MTCurrentSetupDropDown.selectedID
         MTSetCurrentSetup()
         MTContinentDropDownInit()
         MTZoneDropDownInit()
         MTAutoUseInit()
         break
      end
   end
end

function MTSlashUse(arg1)
   UseInventoryItem(12+arg1)
end

function MTSlashShowOpts(arg1)
   if MTOptionsFrame:IsVisible() then
      MTOptionsFrame:Hide()
   else
      MTOptionsFrame:Show()
   end
end
