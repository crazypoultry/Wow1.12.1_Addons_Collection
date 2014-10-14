--
-- SmartMedic -- Find and use the right bandage/potion/food/water for the job.
--
-- (formerly SmartBandage)
--
-- Copyright (c) 2005 Steve Kehlet
--

SLASH_SMARTMEDIC1 = "/smartmedic"
-- argh, can't use /sm, /sm is ShieldMod from CT
--SLASH_SMARTMEDIC2 = "/sm"
BINDING_HEADER_SMARTMEDICHEADER = "SmartMedic"

sm.version = "2.1.3"
sm.playerIsUndead = false
sm.cannibalizeSlot = nil
sm.inCombat = false

smConf = {}
smConf.confVersion = 2
smConf.debug = false
smConf.retargetLast = true
smConf.cannibalizeEnabled = true
smConf.allowBandagingNonPartymates = true
smConf.allowEatingBuffFood = false
smConf.goalHealthPctIfRegening = 80

-- Thanks to Jooky/Greeze for allowing me to rip these items from his AutoPotion addon.
sm.bandages = {
   -- {itemId, power [, battleground]}
   {1251,  66}, -- Linen Bandage
   {2581,  114}, -- Heavy Linen Bandage
   {3530,  161}, -- Wool Bandage
   {3531,  301}, -- Heavy Wool Bandage
   {6450,  400}, -- Silk Bandage
   {6451,  640}, -- Heavy Silk Bandage
   {8544,  800}, -- Mageweave Bandage
   {8545,  1104}, -- Heavy Mageweave Bandage
   {14529, 1360}, -- Runecloth Bandage
   {14530, 2000}, -- Heavy Runecloth Bandage
   {19307, 2000, "Alterac Valley"}, -- Alterac Heavy Runecloth Bandage
   {20067, 640,  "Arathi Basin"}, -- Arathi Basin Silk Bandage
   {20235, 640,  "Arathi Basin"}, -- Defiler's Silk Bandage
   {20244, 640,  "Arathi Basin"}, -- Highlander's Silk Bandage
   {20065, 1104, "Arathi Basin"}, -- Arathi Basin Mageweave Bandage
   {20232, 1104, "Arathi Basin"}, -- Defiler's Mageweave Bandage
   {20237, 1104, "Arathi Basin"}, -- Highlander's Mageweave Bandage
   {20066, 2000, "Arathi Basin"}, -- Arathi Basin Runecloth Bandage
   {20234, 2000, "Arathi Basin"}, -- Defiler's Runecloth Bandage
   {20243, 2000, "Arathi Basin"}, -- Highlander's Runecloth Bandage
   {19068, 640,  "Warsong Gulch"}, -- Warsong Gulch Silk Bandage
   {19067, 1104, "Warsong Gulch"}, -- Warsong Gulch Mageweave Bandage
   {19066, 2000, "Warsong Gulch"}, -- Warsong Gulch Runecloth Bandage
}

sm.healthPotions = {
   {118,   (70+90)/2},     -- Minor Healing Potion - 70-90
   {858,   (140+180)/2},   -- Lesser Healing Potion - 140-180
   {4596,  (140+180)/2},   -- Discolored Healing Potion - 140-180
   {929,   (280+360)/2},   -- Healing Potion - 280-360
   {1710,  (455+585)/2},   -- Greater Healing Potion - 455-585
   {3928,  (700+900)/2},   -- Superior Healing Potion - 700-900
   {18839, (700+900)/2},   -- Combat Healing Potion - 700-900
   {13446, (1050+1750)/2}, -- Major Healing Potion - 1050-1750
   {17349, (560+720)/2, "Alterac Valley"},  -- Superior Healing Draught
   {17348, (980+1260)/2, "Alterac Valley"}, -- Major Healing Draught
}

sm.manaPotions = {
   {2455,  (140+180)/2},   -- Minor Mana Potion - 140-180
   {3385,  (280+360)/2},   -- Lesser Mana Potion - 280-360
   {3827,  (455+585)/2},   -- Mana Potion - 455-585
   {6149,  (700+900)/2},   -- Greater Mana Potion - 700-900
   {13443, (900+1500)/2},  -- Superior Mana Potion - 900-1500
   {18841, (900+1500)/2},  -- Combat Mana Potion - 900-1500
   {13444, (1350+2250)/2}, -- Major Mana Potion - 1350-2250
   {17352, (560+720)/2, "Alterac Valley"},   -- Superior Mana Draught
   {17351, (980+1260)/2, "Alterac Valley"},  -- Major Mana Draught
}

function sm.Help()
   sm.chat("SmartMedic v"..sm.version..".")
   sm.chat("Commands:")
   sm.chat("/smartmedic bandage")
   sm.chat("/smartmedic health")
   sm.chat("/smartmedic mana")
   sm.chat("/smartmedic food")
   sm.chat("/smartmedic water")
   sm.chat("/smartmedic help - this message")
   sm.chat("/smartmedic retargetlast - toggle retargeting last enemy (currently "..
           sm.bool2OnOff(smConf.retargetLast)..")")
   if (sm.playerIsUndead) then
      sm.chat("/smartmedic cannibalize - toggle enabling Cannibalize (currently "..
              sm.bool2OnOff(smConf.cannibalizeEnabled)..")")
   end
   sm.chat("/smartmedic bandageNonPartymates - toggle allowing bandaging of non-partymates (currently "..
           sm.bool2OnOff(smConf.allowBandagingNonPartymates)..")")
   sm.chat("/smartmedic eatBuffFood - toggle allowing eating food that gives you buffs, as a last resort (currently "..
           sm.bool2OnOff(smConf.allowEatingBuffFood)..")")
   sm.chat("/smartmedic goalHealthPctIfRegening ## - health/mana percentage goal, while regenerating (currently "..
           smConf.goalHealthPctIfRegening..")")
   sm.chat("/smartmedic debug - toggle debug flag (currently "..
           sm.bool2OnOff(smConf.debug)..")")
end

function sm.OnLoad()
   sm.chat("SmartMedic v"..sm.version.." loaded.")
   this:RegisterEvent("PLAYER_ENTERING_WORLD")
   this:RegisterEvent("VARIABLES_LOADED")
   SlashCmdList["SMARTMEDIC"] = sm.SlashCommand
end

function sm.OnEvent(event)
   if (event == "PLAYER_ENTERING_WORLD") then

      race, raceEn = UnitRace("player")
      if (raceEn == "Scourge") then
         sm.d("You are undead, enabling Cannibalize support")
         sm.playerIsUndead = true
         this:RegisterEvent("ACTIONBAR_SLOT_CHANGED")
      end

      this:RegisterEvent("PLAYER_REGEN_ENABLED")
      this:RegisterEvent("PLAYER_REGEN_DISABLED")

   elseif (event == "VARIABLES_LOADED") then
      -- our chance to upgrade any old saved variables
      if (not smConf.confVersion) then
         -- smConf.version wasn't defined until 2.1b2
         smConf.confVersion = 1
      end

      if (smConf.confVersion < 2) then
         smConf.confVersion = 2
         smConf.allowBandagingNonPartymates = true
         smConf.allowEatingBuffFood = false
         smConf.goalHealthPctIfRegening = 80
      end

   elseif (event == "ACTIONBAR_SLOT_CHANGED") then
      sm.cannibalizeSlot = nil

   elseif (event == "PLAYER_REGEN_ENABLED") then
      sm.inCombat = false

   elseif (event == "PLAYER_REGEN_DISABLED") then
      sm.inCombat = true
   end
end     

function sm.SplitArgs(line)
   local args = {}
   for arg in string.gfind(line, "[^%s]+") do
      table.insert(args, arg)
   end
   return args
end

function sm.SlashCommand(cmd)
   local args = sm.SplitArgs(cmd)
   local cmd = args[1]

   local goalOverridden = nil
   if (cmd == "bandage" or cmd == "health" or cmd == "mana" or cmd == "food" or cmd == "water") then
      if (args[2] and tonumber(args[2]) ~= smConf.goalHealthPctIfRegening) then
         goalOverridden = smConf.goalHealthPctIfRegening
         smConf.goalHealthPctIfRegening = tonumber(args[2])
         sm.d("temporarily adjusting goal percent to "..smConf.goalHealthPctIfRegening)
      end
   end

   if (not cmd or cmd == "" or cmd == "help") then
      sm.Help()
   elseif (cmd == "bandage") then
      sm.SmartBandage()
   elseif (cmd == "health") then
      sm.SmartHealth()
   elseif (cmd == "mana") then
      sm.SmartMana()
   elseif (cmd == "food") then
      sm.SmartFood()
   elseif (cmd == "water") then
      sm.SmartWater()
   elseif (cmd == "retargetLast") then
      smConf.retargetLast = not smConf.retargetLast
      sm.p("Toggling re-target last enemy, now: "..sm.bool2OnOff(smConf.retargetLast))
   elseif (cmd == "cannibalize") then
      smConf.cannibalizeEnabled = not smConf.cannibalizeEnabled
      sm.p("Toggling Cannibalize support, now: "..sm.bool2OnOff(smConf.cannibalizeEnabled))
   elseif (cmd == "bandageNonPartymates") then
      smConf.allowBandagingNonPartymates = not smConf.allowBandagingNonPartymates
      sm.p("Toggling bandaging of non-partymates, now: "..sm.bool2OnOff(smConf.allowBandagingNonPartymates))
   elseif (cmd == "eatBuffFood") then
      smConf.allowEatingBuffFood = not smConf.allowEatingBuffFood
      sm.p("Toggling eating buff foods (as a last resort), now: "..sm.bool2OnOff(smConf.allowEatingBuffFood))
   elseif (cmd == "goalHealthPctIfRegening" and args[2]) then
      smConf.goalHealthPctIfRegening = tonumber(args[2])
      sm.p("Adjusting health/mana goal percentage while target is regening, now: "..smConf.goalHealthPctIfRegening)
   elseif (cmd == "debug") then
      smConf.debug = not smConf.debug
      sm.p("Toggling debugging output, now: "..sm.bool2OnOff(smConf.debug))
   else
      sm.Help()
   end

   if (goalOverridden) then
      smConf.goalHealthPctIfRegening = goalOverridden
   end
end


-- BEGIN common functions

function sm.IsTargetPartymate()
   if (UnitInParty("target")) then
      -- returns true for self as well
      return true
   end

   if (UnitInRaid("target")) then
      return true
   end

   -- argh, UnitInParty() and UnitInRaid() don't return true for pets.
   -- painstakingly poll party or raid group members' pets as necessary

   if (UnitIsUnit("target", "pet")) then
      return true
   end

   if (GetNumPartyMembers() > 0) then
      for i = 1, 4 do
         if (UnitIsUnit("target", "partypet"..i)) then
            return true
         end
      end
   end

   if (GetNumRaidMembers() > 0) then
      for i = 1, 40 do
         if (UnitIsUnit("target", "raidpet"..i)) then
            return true
         end
      end
   end

   return false
end

function sm.ComputeNeed(unitId, healthOrMana)
   local need = 0

   if (unitId == "player" or 
       (unitId == "target" and sm.IsTargetPartymate())) then
      -- desired health is 80% if out of combat (regen'ing), 100% if in
      local goalPct = smConf.goalHealthPctIfRegening
      if (UnitAffectingCombat(unitId)) then
         goalPct = 100
      end

      if (healthOrMana == "health") then
         need = (UnitHealthMax(unitId) * goalPct/100) - UnitHealth(unitId)
      elseif (healthOrMana == "mana") then
         need = (UnitManaMax(unitId) * goalPct/100) - UnitMana(unitId)
      end

   else
      -- not player nor partymate. 
      -- note: only case we could be here is if bandaging a friendly, non-partymate
      if (UnitHealth(unitId) ~= 100) then
         -- quik 'n dirty hack to support non-party mates: force use of best bandage
         sm.d("target is not in party, will use best available")
         need = 1000000
      end
   end

   if (need <= 0) then
      return false
   end

   return need
end

function sm.IsConjured(smItem)
   -- TBD: internationalize
   if (string.find(smItem.localName, "Conjured ")) then
      return true
   end
   return false
end

--
-- In addition to keeping the table sorted by power, we place Conjured
-- items at the head of a group of equivalently powered items so
-- they'll get used first.  Also smaller stacks of equivalently
-- powered items get placed first.  Finally, put "precious" items
-- last.
-- TBD: precious items last... I think there might be a problem here...
--
function sm.AddCandidate(candidates, smItem)
   if (not smItem.isPrecious) then
      for idx, candidate in candidates do
         if ((smItem.power < candidate.power) or
             (smItem.power == candidate.power and sm.IsConjured(smItem)) or
             (smItem.power == candidate.power and smItem.count < candidate.count) or
             (not smItem.isPrecious and candidate.isPrecious)) then
            table.insert(candidates, idx, smItem)
            return
         end
      end
   end
   table.insert(candidates, smItem)
end

-- TBD: this seems expensive, it's yet another backpack search just to
-- find out if the items are in cooldown.  Assumes if one item is in
-- cooldown, they're all in cooldown.
function sm.IsInCooldownByItemTable(itemTable)
   for bag = 4, 0, -1 do
      for slot = 1, GetContainerNumSlots(bag) do
         local link = GetContainerItemLink(bag, slot)
         if (link) then
            local itemId, itemName = sm.IdAndNameFromLink(link)
            for idx, item in itemTable do
               if (itemId == item[1]) then
                  -- found an item -- is it in cooldown or not?
                  return (GetContainerItemCooldown(bag, slot) ~= 0)
               end
            end
         end
      end
   end
   return false
end

function sm.FindCandidatesByItemTable(itemTable)
   local candidates = {}

   for bag = 4, 0, -1 do
      for slot = 1, GetContainerNumSlots(bag) do
         local link = GetContainerItemLink(bag, slot)
         if (link) then
            if (GetContainerItemCooldown(bag, slot) == 0) then
               local itemId, itemName = sm.IdAndNameFromLink(link)
               for idx, item in itemTable do
                  if (itemId == item[1]) then
                     -- found an item
                     local _, itemCount = GetContainerItemInfo(bag, slot)
                     sm.d("found "..itemName.." at "..bag.."/"..slot..", "..item[2].." power ("..itemCount.." stack)")
                     local smItem = sm.SMItem:new(itemId, item[2], item[3], itemName, bag, slot, itemCount)
                     sm.AddCandidate(candidates, smItem)
                     break
                  end
               end
            end
         end
      end
   end

   return candidates
end

function sm.ScanToolTip(bag, slot, regex)
   SmartMedic_Tooltip:ClearLines()
   SmartMedic_Tooltip:SetBagItem(bag, slot)
   local text, starts, ends, power

   -- I've seen the "Use: Restores XX health" on tooltips 2, 3, and 4
   for i = 2, SmartMedic_Tooltip:NumLines() do
      local tipObj = getglobal("SmartMedic_TooltipTextLeft"..i)
      local text = tipObj:GetText()
      starts, ends, power = string.find(text, regex)
      if (starts) then
         return text, power
      end
   end

   return nil
end

-- TBD: expensive, see comment for IsInCooldownByItemTable()
function sm.IsInCooldownByToolTip(regex)
   for bag = 4, 0, -1  do
      for slot = 1, GetContainerNumSlots(bag) do
         local link = GetContainerItemLink(bag, slot)
         if (link) then
            local text, power = sm.ScanToolTip(bag, slot, regex)
            if (text) then
               -- found an item -- is it in cooldown or not?
               return (GetContainerItemCooldown(bag, slot) ~= 0)
            end
         end
      end
   end
   return false
end

function sm.FindCandidatesByTooltip(regex)
   local candidates = {}

   for bag = 4, 0, -1  do
      for slot = 1, GetContainerNumSlots(bag) do
         local link = GetContainerItemLink(bag, slot)
         if (link) then
            if (GetContainerItemCooldown(bag, slot) == 0) then
               local text, power = sm.ScanToolTip(bag, slot, regex)
               if (text) then
                  power = tonumber(power)
                  local itemId, itemName = sm.IdAndNameFromLink(link)

                  local isPrecious = false
                  -- TBD: localization
                  if (string.find(text, "If you spend at least ") or
                      string.find(text, "If you eat for ") or
                      string.find(text, "Also increases your ")) then
                     isPrecious = true
                  end
                  if (isPrecious and not smConf.allowEatingBuffFood) then
                     sm.d("Skipping "..itemName.." because it adds buffs.")
                  else
                     -- Check for Battlegrounds, e.g. "Usable only inside Warsong Gulch."
                     local starts, ends, battleground = string.find(text, "Usable only inside ([^\.]+)\.")
                     local _, itemCount = GetContainerItemInfo(bag, slot)
                     sm.d("found "..itemName.." at "..bag.."/"..slot..", "..power.." power, ("..itemCount.." stack) ("..sm.nonil(battleground).."), precious: "..sm.bool2OnOff(isPrecious))
                     local smItem = sm.SMItem:new(itemId, power, battleground, itemName, bag, slot, itemCount, isPrecious)
                     sm.AddCandidate(candidates, smItem)
                  end
               end
            end
         end
      end
   end

   return candidates
end

function sm.FindBestItem2(candidates, need, bgMapName, preciousOkay, conjuredOnly)
   local bestSoFar = nil
   local bestPower = 0
   
   for idx, candidate in candidates do
      -- TBD: this is getting a bit messy, chaining all these if's together.  If I get 
      -- one more if, then I need to figure some other way to do this.
      -- TBD: localize the battleground name?
      if (bgMapName == candidate.battleground) then -- works properly when bgMapName is nil too
         if (preciousOkay or (not preciousOkay and not candidate.isPrecious)) then
            if (not conjuredOnly or (conjuredOnly and sm.IsConjured(candidate))) then
               if (candidate.power > bestPower) then
                  -- remember the best one we've seen so far.  but only
                  -- remember the first in a series of identically-powered
                  -- items, as the most desireable will be placed up front.
                  bestPower = candidate.power
                  bestSoFar = candidate
               end
               if (candidate.power >= need) then
                  sm.d(candidate.localName.." will do the job")
                  return candidate
               end
            end
         end
      end
   end

   -- none found that are good enough, just use the best we've got (if anything)
   if (not bestSoFar) then
      sm.d("no items found")
      return false
   end

   sm.d(bestSoFar.localName.." will have to do")
   return bestSoFar
end

function sm.FindBestItem(candidates, need)
   local smItem = nil

   -- First try Conjured items, if good enough or better than what we need
   smItem = sm.FindBestItem2(candidates, need, nil, nil, true)
   if (smItem and smItem.power < need) then
      smItem = nil
   end
   
   -- Then, if in a Battleground, try to use BG items first
   if (not smItem) then
      for i = 1, MAX_BATTLEFIELD_QUEUES do
         status, mapName, instanceID = GetBattlefieldStatus(i)
         if (status == "active") then
            sm.d("you're in batteground: "..mapName)
            smItem = sm.FindBestItem2(candidates, need, mapName)
            break
         end
      end
   end

   -- normal search
   if (not smItem) then
      smItem = sm.FindBestItem2(candidates, need)
   end

   -- if still nothing found, dip into the precious items
   if (not smItem) then
      smItem = sm.FindBestItem2(candidates, need, nil, true)
   end

   if (smItem) then
      sm.d("FindBestItem: "..smItem.localName.." at "..smItem.bag.."/"..smItem.slot.." is the best")
   end

   return smItem
end

-- either pass itemTable or ttRegex
function sm.SmartItem(itemTable, ttRegex, unitId, healthOrMana, itemText)
   need = sm.ComputeNeed(unitId, healthOrMana)
   if (not need) then
      sm.p("not enough need")
      return false
   end

   local candidates
   if (itemTable) then
      if (sm.IsInCooldownByItemTable(itemTable)) then
         sm.p("All "..itemText.." are in cooldown!")
         return false
      end
      candidates = sm.FindCandidatesByItemTable(itemTable)
   else
      if (sm.IsInCooldownByToolTip(ttRegex)) then
         sm.p("All "..itemText.." are in cooldown!")
         return false
      end
      candidates = sm.FindCandidatesByTooltip(ttRegex)
   end

   smItem = sm.FindBestItem(candidates, need)
   if (not smItem) then
      sm.p("Couldn't find any "..itemText.."!")
      return false
   end

   -- count how many are left, possibly in multiple stacks
   local howManyLeft = 0
   for idx, candidate in candidates do
      if (candidate.itemId == smItem.itemId) then
        howManyLeft = howManyLeft + candidate.count
      end
   end
   howManyLeft = howManyLeft - 1

   sm.p("Using "..smItem.localName.." ("..smItem.power.." "..healthOrMana..") on "..
        UnitName(unitId).." ("..howManyLeft.." left)")

   UseContainerItem(smItem.bag, smItem.slot)

   return true
end

-- END common functions

-- BEGIN bandage section

function sm.TryCannibalize()
   -- XXX hmm... dup code?
   local need = sm.ComputeNeed("player", "health")
   if (not need) then
      return false
   end

   -- if this function is called, we know we're undead, cannibalizeSlot is not nil,
   -- and the current target is the player.

   sm.d("Considering Cannibalize...")

   TargetLastEnemy()
   if (UnitHealth("target") == 0) then -- make sure he's dead :-)
      local creatureType = UnitCreatureType("target")
      if (creatureType == "Humanoid" or creatureType == "Undead") then
         -- IsActionInRange() doesn't seem to work right for Cannibalize... however,
         -- we can target our last enemy and use CheckInteractDistance()
         if (CheckInteractDistance("target", 1) == 1) then -- 1 is 5 yards
            if (IsUsableAction(sm.cannibalizeSlot) == 1) then
               if (GetActionCooldown(sm.cannibalizeSlot) == 0) then
                  UseAction(sm.cannibalizeSlot)
                  sm.p("Cannibalizing.")
                  return true
               end
            end
         end
      end
   end

   TargetUnit("player")
   return false
end

function sm.TryBandages()
   return sm.SmartItem(sm.bandages, nil, "target", "health", "bandages")
end

function sm.SmartBandage()
   if (not UnitName("target")) then
      TargetUnit("player")
   end

   local lastTargetWasEnemy = false
   if (not UnitIsFriend("player","target")) then
      TargetUnit("player")
      lastTargetWasEnemy = true
   end

   if (not smConf.allowBandagingNonPartymates and
       not UnitIsUnit("target", "player") and
       not sm.IsTargetPartymate()) then
      sm.p("Target is not partymate.")

   else

      -- first try Cannibalize, a special case
      if (smConf.cannibalizeEnabled and 
          sm.playerIsUndead and 
             sm.FindCannibalize() and 
             UnitIsUnit("target", "player") and
             sm.TryCannibalize()) then
         -- Cannibalize worked

      else
         -- Or bandage (if target isn't Recently Bandaged nor Poisoned)
         if (sm.IsDebuffedBy("target", "Recently Bandaged")) then
            sm.p("Can't bandage "..UnitName("target").." right now, recently bandaged.")
         elseif (sm.IsDebuffedByType("target", "poison")) then
            sm.p("Can't bandage "..UnitName("target").." right now, poisoned.")
         else
            sm.TryBandages()
         end
      end

   end

   if (lastTargetWasEnemy and smConf.retargetLast) then
      TargetLastEnemy()
      -- but if dead, de-target
      if (UnitHealth("target") == 0) then
         sm.d("clearing your target, it's dead")
         ClearTarget()
      end
   end
end

function sm.SmartHealth()
   sm.SmartItem(sm.healthPotions, nil, "player", "health", "health potions")
end

function sm.SmartMana()
   sm.SmartItem(sm.manaPotions, nil, "player", "mana", "mana potions")
end

function sm.SmartFood()
   if (sm.inCombat) then
      sm.p("You can't eat right now, you are in combat.")
      return false
   end
   if (sm.IsBuffedBy("player", "Food")) then
      sm.p("Can't eat right now, already eating.")
      return false
   end
   sm.SmartItem(nil, "Use: Restores (%d+) health", "player", "health", "food items")
end

function sm.SmartWater()
   if (sm.inCombat) then
      sm.p("You can't drink right now, you are in combat.")
      return false
   end
   if (sm.IsBuffedBy("player", "Drink")) then
      sm.p("Can't drink right now, already drinking.")
      return false
   end
   sm.SmartItem(nil, "Use: Restores (%d+) mana", "player", "mana", "water items")
end


-- Utilities

function sm.FindCannibalize()
   if (not sm.cannibalizeSlot) then
      for slot = 1, 120 do 
         if (not GetActionText(slot)) then -- ignore any Player macros :-)
            local text = GetActionTexture(slot)
            if (text and string.find(text, "Ability_Racial_Cannibalize")) then 
               sm.d("found Cannibalize at slot "..slot)
               sm.cannibalizeSlot = slot
               break
            end
         end
      end
   end
   return sm.cannibalizeSlot
end

-- pretty much ripped from AutoPotion (with permission), thanks Jooky/Greeze
-- debuffType is "poison", "magic", etc.
function sm.IsDebuffedByType(unitId, debuffType)
   local i = 1
   while UnitDebuff(unitId, i) do
      SmartMedic_Tooltip:ClearLines()
      SmartMedic_Tooltip:SetUnitDebuff(unitId, i)
      local thisDebuffType = SmartMedic_TooltipTextRight1:GetText()
      if (thisDebuffType == nil) then
         thisDebuffType = ""
      end
      sm.d("debuff tooltip type, got: "..thisDebuffType)
      thisDebuffType = string.lower(thisDebuffType)
      if thisDebuffType == debuffType then
         return true, SmartMedic_TooltipTextLeft1:GetText()
      end
      i = i + 1
   end
   return false
end

function sm.IsBuffedBy(unitId, buff)
   local i = 1
   while UnitBuff(unitId, i) do
      SmartMedic_Tooltip:ClearLines()
      SmartMedic_Tooltip:SetUnitBuff(unitId, i)
      local thisBuff = SmartMedic_TooltipTextLeft1:GetText()
      if (thisBuff == nil) then
         thisBuff = ""
      end
      sm.d("buff tooltip, got: "..thisBuff)
      if buff == thisBuff then
         return true
      end
      i = i + 1
   end
   return false
end

function sm.IsDebuffedBy(unitId, debuff)
   local i = 1
   while UnitDebuff(unitId, i) do
      SmartMedic_Tooltip:ClearLines()
      SmartMedic_Tooltip:SetUnitDebuff(unitId, i)
      local thisDebuff = SmartMedic_TooltipTextLeft1:GetText()
      if (thisDebuff == nil) then
         thisDebuff = ""
      end
      sm.d("debuff tooltip, got: "..thisDebuff)
      if debuff == thisDebuff then
         return true
      end
      i = i + 1
   end
   return false
end

function sm.chat(msg, r, g, b)
   if (not r) then
--      r = 1
--      g = 1
--      b = .4
      r = 1
      g = .2
      b = 0
   end
   DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b)
end

function sm.p(msg)
   sm.chat("## SmartMedic: "..msg)
   sm.trace(msg)
end

function sm.d(msg)
   if (smConf.debug) then
      sm.chat("### SmartMedic: "..msg, .6, .2, 0)
   end
   sm.trace(msg)
end

-- provide optional Tracer module support, for debugging problems
function sm.trace(msg)
   if (tracer) then
      tracer.Log("SmartMedic", msg)
   end
end

function sm.bool2OnOff(bool)
   if (bool) then
      return "on"
   end
   return "off"
end

function sm.nonil(str)
   if (not str) then
      str = ""
   end
   return str
end

function sm.IdAndNameFromLink(link)
   local name
   if (not link) then
      return ""
   end
   for id, name in string.gfind(link, "|c%x+|Hitem:(%d+):%d+:%d+:%d+|h%[(.-)%]|h|r$") do
      return tonumber(id), name
   end
   return nil
end
