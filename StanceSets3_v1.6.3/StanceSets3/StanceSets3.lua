
local WeaponQuickSwap = {}

local STANCESETS3_MAX_STANCES = 8

tinsert(UISpecialFrames,"StanceSets3Frame");

local DEBUG            = false
local StanceSets3_LastForm;

local function debug (msg)
   if not DEBUG then
      return
   end
   DEFAULT_CHAT_FRAME:AddMessage('[StanceSet3 debug] ' .. msg)
end

function StanceSets3_OnLoad()
  this:RegisterEvent("UPDATE_BONUS_ACTIONBAR");
  this:RegisterEvent("SPELLS_CHANGED");
  this:RegisterEvent("VARIABLES_LOADED");
  this:RegisterEvent("PLAYER_AURAS_CHANGED");   
  
  SlashCmdList["STANCESETS"] = StanceSets3_SlashCmd;
  SLASH_STANCESETS1 = "/stancesets";
  
  if not StanceSetsVars then 
    StanceSetsVars = { }; 
  end

  WeaponQuickSwap.OnLoad();
end

function StanceSets3_OnShow()
  return StanceSets3_UpdateAllStances(); 
end

function StanceSets3_OnEvent(event, arg1)
  if event == "UPDATE_BONUS_ACTIONBAR" then   
    StanceSets3_FormChanged();
  elseif event == "SPELLS_CHANGED" then     
    StanceSets3_SpellsChanged();
  elseif event == "PLAYER_AURAS_CHANGED" then
    StanceSets3_FormChanged();
  elseif event == "VARIABLES_LOADED" then     
    -- register for myaddons
        
    if(myAddOnsFrame) then
      myAddOnsList.StanceSets = {name = "StanceSets 3", description = "StanceSets v3 (modified by Tageshi)", version = 1, category = MYADDONS_CATEGORY_COMBAT, frame = "StanceSets3Frame", optionsframe = "StanceSets3Frame"};
    end
  else
    WeaponQuickSwap.OnEvent(event, arg1);         
  end
end

function StanceSets3_SlashCmd(cmd)
  if cmd == "next" then
    return StanceSets3_Next();
  elseif cmd == "next2" then
    return StanceSets3_Next(2);
  elseif cmd == "next3" then
    return StanceSets3_Next(3);
  elseif cmd == "set1" then
    StanceSets3_EquipSet(0);
  elseif cmd == "set2" then
    StanceSets3_EquipSet(1);
  elseif cmd == "set3" then
    StanceSets3_EquipSet(2);
  elseif cmd == "debug" then
    DEBUG = not DEBUG;
    if DEBUG then
      debug('debug mode ON');
    else
      DEFAULT_CHAT_FRAME:AddMessage('[StanceSet3 debug] ' .. 'debug mode OFF');
    end
  else
    StanceSets3_Toggle();
  end
end

function StanceSets3_Toggle()
  if StanceSets3Frame:IsVisible() then
    HideUIPanel(StanceSets3Frame);
  else
    ShowUIPanel(StanceSets3Frame);
  end
end

function StanceSets3_SpellsChanged()
  -- Spells have changed, this may mean that we've got a new shapeshift form
  if StanceSets3Frame:IsVisible() then
    return StanceSets3_UpdateAllStances();
  end
end

function StanceSets3_SetButtonTextureAndName(suffix,texture,itemName)
  local btn = getglobal("StanceSets3FrameSet"..suffix);
  if btn then
    SetItemButtonTexture(btn, texture);
    btn.itemName = itemName;

    if texture == nil and UnitHasRelicSlot("player") then
      local id = btn:GetID();
      if id == 3 or id == 6 or id == 9 then
        SetItemButtonTexture(btn, "Interface\\Paperdoll\\UI-PaperDoll-Slot-Relic.blp");
      end
    end
  end
end

function StanceSets3_FindAndSetButtonTexture(suffix, itemName)
  if itemName and itemName ~= "" then
    local bag, slot = WeaponQuickSwap.FindItem(itemName);
    if bag and slot then
      local texture;
      if bag == -1 then
        texture = GetInventoryItemTexture("player", slot);
      else
        texture = GetContainerItemInfo(bag, slot);
      end
      StanceSets3_SetButtonTextureAndName(suffix, texture, itemName);
    else
      -- if not found, just use a generic icon
      StanceSets3_SetButtonTextureAndName(suffix, "Interface\\Icons\\INV_Misc_Gift_01", itemName);
    end
  else
    -- no item name, no icon
    StanceSets3_SetButtonTextureAndName(suffix, nil, itemName);
  end
end

function StanceSets3_UpdateAllStances()
  local allstances = StanceSets3_GetAllForms();
  
  for i=1,STANCESETS3_MAX_STANCES do
    local stanceName = allstances[i];
    local frameStance = getglobal("StanceSets3FrameSet"..i);
    local frameLabel = getglobal("StanceSets3FrameSet"..i.."Title");
    
    if frameStance then
      local chkForceFirst = getglobal(frameStance:GetName().."ForceFirst");

      if stanceName then
        frameStance.StanceName = stanceName;

        if stanceName == STANCESETS3_SETGROUP2 or stanceName == STANCESETS3_SETGROUP3 then
          chkForceFirst:Hide();
        else
          chkForceFirst:Show();
        end
      
        frameStance:Show();
        if frameLabel then frameLabel:SetText(stanceName); end
        
        local setName = stanceName;
        
        if (StanceSetsVars[setName]) then
          local stanceSet = StanceSetsVars[setName];
        
          if StanceSetsVars[setName.."_ForceFirst"] then
            chkForceFirst:SetChecked(1);
          else
            chkForceFirst:SetChecked(nil);
          end

          StanceSets3_FindAndSetButtonTexture(i.."MainHand1", stanceSet[1]);
          StanceSets3_FindAndSetButtonTexture(i.."OffHand1", stanceSet[2]);
          StanceSets3_FindAndSetButtonTexture(i.."Ranged1", stanceSet[3]);
          StanceSets3_FindAndSetButtonTexture(i.."MainHand2", stanceSet[4]);
          StanceSets3_FindAndSetButtonTexture(i.."OffHand2", stanceSet[5]);
          StanceSets3_FindAndSetButtonTexture(i.."Ranged2", stanceSet[6]);
          StanceSets3_FindAndSetButtonTexture(i.."MainHand3", stanceSet[7]);
          StanceSets3_FindAndSetButtonTexture(i.."OffHand3", stanceSet[8]);
          StanceSets3_FindAndSetButtonTexture(i.."Ranged3", stanceSet[9]);
        else
          StanceSets3_SetButtonTextureAndName(i.."MainHand1", nil, nil);
          StanceSets3_SetButtonTextureAndName(i.."OffHand1", nil, nil);
          StanceSets3_SetButtonTextureAndName(i.."Ranged1", nil, nil);
          StanceSets3_SetButtonTextureAndName(i.."MainHand2", nil, nil);
          StanceSets3_SetButtonTextureAndName(i.."OffHand2", nil, nil);
          StanceSets3_SetButtonTextureAndName(i.."Ranged2", nil, nil);
          StanceSets3_SetButtonTextureAndName(i.."MainHand3", nil, nil);
          StanceSets3_SetButtonTextureAndName(i.."OffHand3", nil, nil);
          StanceSets3_SetButtonTextureAndName(i.."Ranged3", nil, nil);
        end
      else        
        frameStance:Hide();
      end
    end  -- if frame found
  end  -- for i 1,MAX
end

function StanceSets3_GetCurrentStanceSet(arg)
  debug('2');
  local currentForm = StanceSets3_GetCurrentForm(arg);
  
  local setName = currentForm;
  local sets = StanceSetsVars[setName];
  if not sets or
     (not sets[1] and not sets[2] and not sets[3] and
      not sets[4] and not sets[5] and not sets[6] and
      not sets[7] and not sets[8] and not sets[9]) then
    setName = "Default";
  end
  debug('3');
  return StanceSetsVars[setName], setName;
end

function StanceSets3_Next(arg)
  debug('1');
  local sets = StanceSets3_GetCurrentStanceSet(arg);
  if sets then
    return WeaponQuickSwap.WeaponSwap(sets[1], sets[2], sets[3], sets[4], sets[5], sets[6], sets[7], sets[8], sets[9]);
  end
  --debug('StanceSets3_Next end');
end

function StanceSets3_FormChanged()
  local curForm = StanceSets3_GetCurrentForm();
  if StanceSets3_LastForm then
    if curForm == StanceSets3_LastForm then
      return;
    end
  end
  StanceSets3_LastForm = curForm;

  local playerFormSet, setName = StanceSets3_GetCurrentStanceSet();
  if playerFormSet then   
    if StanceSetsVars[setName.."_ForceFirst"] then
      -- must have at least one thing to do a swap
      if playerFormSet[1] or playerFormSet[2] or playerFormSet[3] then
        return WeaponQuickSwap.WeaponSwap(playerFormSet[1], playerFormSet[2], playerFormSet[3]);
      end
    end
  end
end

function StanceSets3_EquipSet(num) 
  local playerFormSet, setName = StanceSets3_GetCurrentStanceSet();
  if playerFormSet then   
    -- must have at least one thing to do a swap    
    if playerFormSet[1+(num*3)] or playerFormSet[2+(num*3)] or playerFormSet[3+(num*3)] then
        WeaponQuickSwap.WeaponSwap(playerFormSet[1+(num*3)], playerFormSet[2+(num*3)], playerFormSet[3+(num*3)]);
    end
  end
end


function StanceSets3_GetCurrentForm(arg)
  if arg == 2 then
    return STANCESETS3_SETGROUP2;
  elseif arg == 3 then
    return STANCESETS3_SETGROUP3;
  else
    for i=1,GetNumShapeshiftForms(),1 do
      local _, name, isActive = GetShapeshiftFormInfo(i);
      if isActive then      
        return name;
      end
    end
  end
  
  return "Default";
end

function StanceSets3_GetAllForms()
  local retVal = { };
  table.insert(retVal, "Default");

  for i=1,GetNumShapeshiftForms() do
    local _, name = GetShapeshiftFormInfo(i);
    table.insert(retVal, name);
  end
  table.insert(retVal, STANCESETS3_SETGROUP2);
  table.insert(retVal, STANCESETS3_SETGROUP3);
  
  local maxnum = GetNumShapeshiftForms() + 3;
  if maxnum > STANCESETS3_MAX_STANCES then
    maxnum = STANCESETS3_MAX_STANCES;
  end
  local height = 40 + (maxnum * 70);
  StanceSets3Frame:SetHeight(height);
  
  return retVal;
end

function StanceSets3Slot_OnEnter()
  if this.itemName and this.itemName ~= "" then
    GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
    
    local bag,slot = WeaponQuickSwap.FindItem(this.itemName);
    if bag and slot then
      if bag == -1 then
        GameTooltip:SetInventoryItem("player", slot);
      else
        GameTooltip:SetBagItem(bag,slot);
      end
    else
      GameTooltip:SetText(this.itemName, 1.0, 1.0, 1.0);
    end
    
    GameTooltip:Show();
  end
end

function StanceSets3Slot_IDToSlotID(id)
  if id == 1 or id == 4 or id == 7 then
    return 16;
  elseif id == 2 or id == 5 or id == 8 then
    return 17;
  else
    return 18;
  end
end

function StanceSets3Slot_OnDragStart()
  local frmParent = this:GetParent();
  local setName = frmParent.StanceName;
  
  if StanceSetsVars[setName] then
    StanceSetsVars[setName][this:GetID()] = nil;
    ResetCursor();
    StanceSets3_UpdateAllStances();
  end
end

function StanceSets3Slot_TakeItemOffCursor(srcBag, srcSlot)
  if srcBag == -1 then
    PickupInventoryItem(srcSlot);
  else
    PickupContainerItem(srcBag, srcSlot);
  end
end

function StanceSets3Slot_OnReceiveDrag()
  StanceSets3Slot_OnClick("LeftButton");
end

StanceSets3_PickedupItem = {};

function StanceSets3Slot_OnClick(arg1)
  local slotID = StanceSets3Slot_IDToSlotID(this:GetID());
  
  arg1 = arg1 or "";
  if arg1 == "LeftButton" then
    if CursorHasItem() and StanceSets3_PickedupItem.bag then
      local itemName = WeaponQuickSwap.GetItemLink(StanceSets3_PickedupItem.bag, StanceSets3_PickedupItem.slot);
        
      -- Cursor item can go in the slot or is Egan's Blaster.
      if CursorCanGoInSlot(slotID) or string.find(itemName, "item:13289:") then
        local frmParent = this:GetParent();
        local setName = frmParent.StanceName;

        if not StanceSetsVars then
          StanceSetsVars = {};
        end
        if not StanceSetsVars[setName] then
          StanceSetsVars[setName] = {};
        end
        StanceSetsVars[setName][this:GetID()] = itemName;
         
        StanceSets3_UpdateAllStances();
      else
        Print(itemName.." can not go in that slot!");
      end
  
      ClearCursor();
      ResetCursor();
    end  -- if has item and we know where it came from

    StanceSets3_PickedupItem.bag = nil;  
  end  -- if left button
end

local StanceSets3_Save_PickupContainerItem = PickupContainerItem;
PickupContainerItem = function (bag,slot)
  StanceSets3_PickedupItem.bag = bag;
  StanceSets3_PickedupItem.slot = slot;
  return StanceSets3_Save_PickupContainerItem(bag,slot);
end

local StanceSets3_Save_PickupInventoryItem = PickupInventoryItem;
PickupInventoryItem = function (slot)
  StanceSets3_PickedupItem.bag = -1;
  StanceSets3_PickedupItem.slot = slot;
  return StanceSets3_Save_PickupInventoryItem(slot);
end

function StanceSets3ForceCheck_OnClick()
  local frmParent = this:GetParent();
  local setName = frmParent.StanceName.."_ForceFirst";
  
  if (this:GetChecked()) then
    StanceSetsVars[setName] = true;
    PlaySound("igMainMenuOptionCheckBoxOff");
  else
    StanceSetsVars[setName] = nil;
    PlaySound("igMainMenuOptionCheckBoxOn");
  end
end     

--[[
  WeaponQuickSwap - by CapnBry
  A script for moving weapons by name between hands, taking slot locking into account.
  
  Public Domain.  Feel free to use any of this code or ideas in your own mods
--]]

-- Unit variable to hold the stack of weapon swaps
local wswap = { c = 0, sb = {}, si = {}, db = {}, di = {} };
local WeaponSwap_IsSwapping = nil;

local rarg = {};

--
-- "Exported" functions for the user
--
function WeaponQuickSwap.WeaponSwap(...)
  debug('4');

  rarg[1] = nil; rarg[2] = nil; rarg[3] = nil;
  rarg[4] = nil; rarg[5] = nil; rarg[6] = nil;
  rarg[7] = nil; rarg[8] = nil; rarg[9] = nil;

  local p = 1;

  -- Regularize argument list
  -- Here is a tiny limitation:
  -- You can not use a single ranged slot as a set such as [empty][empty][ranged].
  -- Such configuration will be ignored, because WeaponQuickSwap cannot remove two items at once.
  for i = 1,7,3 do
    if (arg[i] and arg[i] ~= "") or (arg[i+1] and arg[i+1] ~= "") then
      if not arg[i] then
        rarg[p] = "";
      else
        rarg[p] = arg[i];
      end
      if not arg[i+1] then
        rarg[p+1] = "";
      else
        rarg[p+1] = arg[i+1];
      end
      if not arg[i+2] then
        rarg[p+2] = "";
      else
        rarg[p+2] = arg[i+2];
      end
      p = p + 3;
    end
  end

  debug('5');

  return WeaponQuickSwap.WeaponSwapCommon(rarg);
end
WeaponSwap = WeaponQuickSwap.WeaponSwap

--
-- Internal functions and callbacks
--
function WeaponQuickSwap.OnLoad()
  if not Print then Print = function (x)
    ChatFrame1:AddMessage(x, 1.0, 1.0, 1.0);
    end
  end
 
  this:RegisterEvent("ITEM_LOCK_CHANGED");
end

function WeaponQuickSwap.OnEvent(...)
  if (arg[1] == "ITEM_LOCK_CHANGED") and not arg[2] then
    if not WeaponQuickSwap.InExecuteProcess then
      return WeaponQuickSwap.ExecuteSwapIteration();
    end
  end
end

local function swaplist_push(list, sb, si, db, di)
debug('push: list.c='..list.c..','..sb..','..si..','..db..','..di);
  local i = list.c + 1;
  list.c, list.sb[i], list.si[i], list.db[i], list.di[i] = i, sb, si, db, di;
end

local function swaplist_popfirst(list)
  if list.c == 0 then return; end
  list.c = list.c - 1;
end

function WeaponQuickSwap.ItemIsLocked(bag,slot)
  if bag == -1 and slot == -1 then return false; end

  if bag == -1 then
    return IsInventoryItemLocked(slot);
  else
    local _,_,retVal = GetContainerItemInfo(bag,slot);
    return retVal;
  end
end

function WeaponQuickSwap.AnyItemLocked()
  -- Checks all the bags and the 3 equip slots to see if any slot is still locked
  for i=0,NUM_BAG_FRAMES do
    for j=1,GetContainerNumSlots(i) do
      local _,_,retVal = GetContainerItemInfo(i,j);
      if retVal then
        return retVal;
      end
    end
  end
  return IsInventoryItemLocked(16) or IsInventoryItemLocked(17) or IsInventoryItemLocked(18);
end

WeaponQuickSwap.InExecuteProcess = false;

function WeaponQuickSwap.ExecuteSwapIteration()
  if wswap.c == 0 then 
    if WeaponSwap_IsSwapping and not WeaponQuickSwap.AnyItemLocked() then
      debug('10');
      return WeaponQuickSwap.OnSwapComplete();
    end
    
    return;
  end

  debug('8  '..wswap.sb[wswap.c]..':'..wswap.si[wswap.c]..','..wswap.db[wswap.c]..':'..wswap.di[wswap.c]..' swap');
  if WeaponQuickSwap.ItemIsLocked(wswap.sb[wswap.c], wswap.si[wswap.c]) or
    WeaponQuickSwap.ItemIsLocked(wswap.db[wswap.c], wswap.di[wswap.c]) then
    debug('locked');
    return;
  end

  WeaponQuickSwap.InExecuteProcess = true;
  ClearCursor();

  if wswap.sb[wswap.c] == -1 then
    PickupInventoryItem(wswap.si[wswap.c]);
  else
    PickupContainerItem(wswap.sb[wswap.c], wswap.si[wswap.c]);
  end

  if wswap.db[wswap.c] == -1 then
    if wswap.di[wswap.c] == -1 then
      PutItemInBackpack();
    else
      PickupInventoryItem(wswap.di[wswap.c]);
    end
  else
    PickupContainerItem(wswap.db[wswap.c], wswap.di[wswap.c]);
  end

  WeaponQuickSwap.InExecuteProcess = false;

  swaplist_popfirst(wswap);
  if wswap.c > 0 and not WeaponQuickSwap.PerformSlowerSwap then
    debug('repeat');
    return WeaponQuickSwap.ExecuteSwapIteration();
  end
  debug('9');
end

function WeaponQuickSwap.OnSwapComplete()
  WeaponSwap_IsSwapping = nil;
  wswap.c = 0;

  -- this is just here to allow people to hook the completion event
end

function WeaponQuickSwap.OnSwapError(error)
  WeaponSwap_IsSwapping = nil;
  wswap.c = 0;

  -- this is just here to allow people to hook the completion event
  return Print(error);
end

function WeaponQuickSwap.GetItemName(bag, slot)
  local linktext = nil;
  
  if (bag == -1) then
    linktext = GetInventoryItemLink("player", slot);
  else
    linktext = GetContainerItemLink(bag, slot);
  end

  if linktext then
    -- local _,_,name = string.find(linktext, "(%b[])");
    local _,_,name = string.find(linktext, "^.*%[(.*)%].*$");
    return name;
  else
    return "";
  end
end

function WeaponQuickSwap.GetItemLink(bag, slot)
  local linktext = nil;
  
  if (bag == -1) then
    linktext = GetInventoryItemLink("player", slot);
  else
    linktext = GetContainerItemLink(bag, slot);
  end

  if linktext then
    return linktext;
  else
    return "";
  end
end

function WeaponQuickSwap.IsItem(bag, slot, name)
  return WeaponQuickSwap.GetItemName(bag, slot) == name or 
         WeaponQuickSwap.GetItemLink(bag, slot) == name;
end


function WeaponQuickSwap.FindItem(name, skipcount)
  skipcount = skipcount or 0;
  
  -- First check the inventory slots 16, 17 and 18
  for i= 16,18,1 do
    if (WeaponQuickSwap.IsItem(-1,i, name)) then 
      if skipcount == 0 then return -1,i; end
      skipcount = skipcount - 1;
    end
  end

  -- not found check bags
  for i=NUM_BAG_FRAMES,0,-1 do
    for j=GetContainerNumSlots(i),1,-1 do
      if (WeaponQuickSwap.IsItem(i,j, name)) then 
        if skipcount == 0 then return i,j; end
        skipcount = skipcount - 1;
      end
    end
  end

  -- not found return nil,nil implicitly
end

function WeaponQuickSwap.IsNormalBag(id)
  if id == 0 then
    return true;
  end
  local link = GetInventoryItemLink("player", ContainerIDToInventoryID(id));
  if link then
    local _, _, id = string.find(link, "item:(%d+)");
    if id then
      local _, _, _, _, itemType, subType = GetItemInfo(id);
      if not (itemType == "Quiver" or string.find(subType, " ")) then
        return true;
      end
    end
  end
  return false;
end

function WeaponQuickSwap.FindLastEmptyBagSlot(skipcount, bag_affinity, slot_affinity)
  skipcount = skipcount or 0;
  
  -- try to put the item in the requested affinity, if possible
  if bag_affinity and slot_affinity and 
    not GetContainerItemInfo(bag_affinity, slot_affinity) then
    return bag_affinity, slot_affinity;
  end
  
  -- if we couldn't get the bag and slot we wanted, just try the same bag
  if bag_affinity then
    for j=GetContainerNumSlots(bag_affinity),1,-1 do
      if not GetContainerItemInfo(bag_affinity,j) then
        if skipcount == 0 then return bag_affinity,j; end
        skipcount = skipcount - 1;
      end
    end
  end

  -- no affinity, chek all bags
  for i=NUM_BAG_FRAMES,0,-1 do
    -- but skip any bag we already have affinity for (because it might have 
    -- already modified skipcount 
    if bag_affinity ~= i then
      -- Make sure this isn't a quiver nor profession bag, those won't hold shit
      if WeaponQuickSwap.IsNormalBag(i) then
        for j=GetContainerNumSlots(i),1,-1 do
          if not GetContainerItemInfo(i,j) then
            if skipcount == 0 then return i,j; end
            skipcount = skipcount - 1;
          end  -- if empty
        end  -- for slots
      end  -- if normal bag
    end -- if not affinity bag
  end  -- for bags

  -- not found return nil,nil implicitly
end

function WeaponQuickSwap.FindCurrentSetIndex(mainhandslot, offhandslot, rangedslot, startIndex, setsList)
  -- loop through the paramters and find what we have in our hands  
  local main, off;
  local argidx = startIndex;
  local retVal;
  while setsList[argidx] do
    main, off, ranged = setsList[argidx], setsList[argidx+1], setsList[argidx+2];
    
    if not main then break; end
    
    -- don't need to specify the offhand if this is just a single deal
    if not off then off = ""; end
    if not ranged then ranged = ""; end

    if (main == "*" or WeaponQuickSwap.IsItem(-1, mainhandslot, main)) and 
      (off == "*" or WeaponQuickSwap.IsItem(-1, offhandslot, off)) and
      (ranged == "*" or WeaponQuickSwap.IsItem(-1, rangedslot, ranged)) then
      retVal = argidx;
      break;
    end

    argidx = argidx + 3;
  end
  
  return retVal;
end

WeaponQuickSwap.LastOffSource = {};

function WeaponQuickSwap.WeaponSwapCommon(arg)
  debug('6');
  -- I explicitly use arg as a parameter instead of ... to prevent
  -- having to call unpack on the arg list from the caller

  if WeaponSwap_IsSwapping then 
    if wswap.c == 0 and not WeaponQuickSwap.AnyItemLocked() then
      debug("Removed false WeaponSwap_IsSwapping flag.");
      WeaponSwap_IsSwapping = nil;
    end
    return
  end

  WeaponSwap_IsSwapping = 1;
  wswap.c = 0;
  WeaponQuickSwap.PerformSlowerSwap = nil;

  local mainhandslot, offhandslot, rangedslot = 16, 17, 18;
  local main, off, ranged;

  local matchingsetidx = WeaponQuickSwap.FindCurrentSetIndex(mainhandslot, offhandslot, rangedslot, 1, arg);
  
  -- if we found a match, and there is at least one weapon speficied in the next
  -- set, then use that set.  Else use the first 3
  if matchingsetidx and arg[matchingsetidx+3] then
    main, off, ranged = arg[matchingsetidx+3], arg[matchingsetidx+4], arg[matchingsetidx+5];
  else
    main, off, ranged = arg[1], arg[2], arg[3];
  end

  -- don't need to specify the offhand if this is just a single deal
  if not off then off = ""; end
  
  if not main then
    return WeaponQuickSwap.OnSwapError("No weapons set found to switch.  Not enough arguments?");
  end
  
  -- see what's already set up
  local m_ok = main == "*" or WeaponQuickSwap.IsItem(-1, mainhandslot, main);
  local o_ok = off == "*" or WeaponQuickSwap.IsItem(-1, offhandslot, off);
  local r_ok = ranged == "*" or WeaponQuickSwap.IsItem(-1, rangedslot, ranged);
  
  local m_sb, m_si = -1, mainhandslot;
  if not m_ok then 
    if main == "" then
      m_sb, m_si = -1, -1;
    else
      m_sb, m_si = WeaponQuickSwap.FindItem(main);
      -- if FindItem returned the offhand weapon and it is already ok
      -- don't remove it.  Look harder
      if o_ok and m_sb == -1 and m_si == offhandslot then
        m_sb, m_si = WeaponQuickSwap.FindItem(main, 1);
      end
    end
    if not (m_sb and m_si) then
      return WeaponQuickSwap.OnSwapError("Can not find mainhand item: "..main);
    end
  end -- if not m_ok

  local multiinst;
  -- if you're using 2 of the same weapon FindItem needs to 
  -- know not to just return the first
  if main == off then multiinst = 1; else multiinst = 0; end
  
  local o_sb, o_si = -1, offhandslot;
  if not o_ok then 
    if off == "" then
      o_sb, o_si = -1, -1;
    else
      o_sb, o_si = WeaponQuickSwap.FindItem(off, multiinst);
      -- note that here we don't have to "look harder" because
      -- that would mean that both weapons are the same so multinst
      -- would already be set to 1
    end
    if not (o_sb and o_si) then
      return WeaponQuickSwap.OnSwapError("Can not find offhand item: "..off);
    end
  end  -- if not o_ok

  local r_sb, r_si = -1, rangedslot;
  if not r_ok then 
    if ranged == "" then
      r_sb, r_si = -1, -1;
    else
      r_sb, r_si = WeaponQuickSwap.FindItem(ranged);
    end
    if not (r_sb and r_si) then
      return WeaponQuickSwap.OnSwapError("Can not find ranged item: "..ranged);
    end
  end  -- if not r_ok

  -- Moving ranged equipment from a bag
  if r_sb ~= -1 then
    ClearCursor();
    PickupContainerItem(r_sb, r_si);
    PickupInventoryItem(rangedslot);
    r_ok = true;
  end

  -- Moving both hands from bags, that's easy
  if m_sb ~= -1 and o_sb ~= -1 then
    -- Load main first because if it is a 2h and we try to load offhand
    -- we get a "Cannot Equip that with a Two-handed weapon" error
    debug('7');
    ClearCursor();
    PickupContainerItem(m_sb, m_si);
    PickupInventoryItem(mainhandslot);
    debug('8');
    PickupContainerItem(o_sb, o_si);
    PickupInventoryItem(offhandslot);
    WeaponQuickSwap.LastOffSource.bag = o_sb;
    WeaponQuickSwap.LastOffSource.slot = o_si;
    debug('9');

    m_ok = true;
    o_ok = true;
  end

  -- Simple hand swap
  if m_sb == -1 and m_si == offhandslot and o_sb == -1 and o_si == mainhandslot then
    debug('7');
    ClearCursor();
    PickupInventoryItem(mainhandslot);
    debug('8');
    PickupInventoryItem(offhandslot);
    debug('9');

    m_ok = true;
    o_ok = true;
  end

  -- Push the list.  We want to:
  -- Take the mainhand weapon out if it isn't going to offhand
  -- Move from wherever to the offhand.  If offhand is supposed to be empty, empty it.
  -- Install the main hand weapon.  No blank main hand is supported unless are going to be.
  --
  -- Do it backward, the swaplist is a stack

  local skipcount = 0;
  
  -- Install main hand
  if not m_ok then
    -- if nothing going to the main hand
    if (m_sb == -1 and m_si == -1) then
      -- and the main is not going to the off: put it in a bag
      if not (o_sb == -1 and o_si == mainhandslot) then
        local bb, bi = WeaponQuickSwap.FindLastEmptyBagSlot(skipcount);
        if not (bb and bi) then 
          return WeaponQuickSwap.OnSwapError("Not enough empty bag slots to perform swap."); 
        end
        skipcount = skipcount + 1;
        swaplist_push(wswap, -1, mainhandslot, bb, bi);
        
        -- when moving A,"" -> "",B where A is a 2h, the offhand doesn't lock properly
        -- so work around it by swapping slowly (only one swap per lock notify)
        WeaponQuickSwap.PerformSlowerSwap = true;
      end
    else
      swaplist_push(wswap, m_sb, m_si, -1, mainhandslot);
    end
  end
  
  -- Load offhand if not already there
  if not o_ok then
    if (o_sb == -1 and o_si == -1) then
      if not (m_sb == -1 and m_si == offhandslot) then
   
        local bb, bi;
        if WeaponQuickSwap.LastOffSource.bag then
          bb, bi = WeaponQuickSwap.FindLastEmptyBagSlot(skipcount, 
            WeaponQuickSwap.LastOffSource.bag, WeaponQuickSwap.LastOffSource.slot);
        else
          bb, bi = WeaponQuickSwap.FindLastEmptyBagSlot(skipcount);
        end
        
        if not (bb and bi) then 
          return WeaponQuickSwap.OnSwapError("Not enough empty bag slots to perform swap."); 
        end
        skipcount = skipcount + 1;
        swaplist_push(wswap, -1, offhandslot, bb, bi);
      end
    else
      -- if the main hand weapon is coming from the offhand slot
      -- we need to fix up its source to be where the offhand is 
      -- GOING to be after the bag->off swap
      if wswap.c > 0 and (m_sb == -1 and m_si == offhandslot) then
        wswap.sb[wswap.c] = o_sb;
        wswap.si[wswap.c] = o_si;
        -- don't set o_sb, o_si they're tested later
      end
      
      if WeaponQuickSwap.PerformSlowerSwap then
        --We need another workaround when moving 2H,"" -> "", 1H .
        --Do mainhand first by swapping list:
        swaplist_push(wswap, wswap.sb[wswap.c], wswap.si[wswap.c], wswap.db[wswap.c], wswap.di[wswap.c]);
        wswap.c = wswap.c - 2;
        swaplist_push(wswap, o_sb, o_si, -1, offhandslot);
        wswap.c = wswap.c + 1;
      else
        swaplist_push(wswap, o_sb, o_si, -1, offhandslot);
      end
    end
  end
  
  -- Special Case: Moving off to main, and not main to off
  -- This is because maybe the main hand weapon is main only
  if (m_sb == -1 and m_si == offhandslot) and not (o_sb == -1 and o_si == mainhandslot) then
    local bb, bi = WeaponQuickSwap.FindLastEmptyBagSlot(skipcount);
    if not (bb and bi) then 
      return WeaponQuickSwap.OnSwapError("Not enough empty bag slots to perform swap."); 
    end
    skipcount = skipcount + 1;
    swaplist_push(wswap, -1, mainhandslot, bb, bi);
  end

  -- Same thing for off hand
  if (o_sb == -1 and o_si == mainhandslot) and not (m_sb == -1 and m_si == offhandslot) then
    local bb, bi = WeaponQuickSwap.FindLastEmptyBagSlot(skipcount);
    if not (bb and bi) then 
      return WeaponQuickSwap.OnSwapError("Not enough empty bag slots to perform swap."); 
    end
    skipcount = skipcount + 1;
    swaplist_push(wswap, -1, 17, bb, bi);
  end

  if o_sb ~= -1 then 
    WeaponQuickSwap.LastOffSource.bag = o_sb; 
    WeaponQuickSwap.LastOffSource.slot = o_si;
  end
  
  if not r_ok then
    -- if nothing going to the ranged slot
    if (r_sb == -1 and r_si == -1) then
      local bb, bi = WeaponQuickSwap.FindLastEmptyBagSlot(skipcount);
      if not (bb and bi) then 
        return WeaponQuickSwap.OnSwapError("Not enough empty bag slots to perform swap."); 
      end
      skipcount = skipcount + 1;
      swaplist_push(wswap, -1, rangedslot, bb, bi);
        
    else
      swaplist_push(wswap, r_sb, r_si, -1, rangedslot);
    end
  end
  
  -- Start moving
  debug('7');
  return WeaponQuickSwap.ExecuteSwapIteration(); 
end
