--============================================================================================--
--============================================================================================--
--                                                                                            --
--                              ITEM, BAG, TOOLTIP FUNCTIONS                                  --
--                                                                                            --
--============================================================================================--
--============================================================================================--


---------------------------------------------------------------------------------
-- Given the full text of a tooltip, return just the name of the item
---------------------------------------------------------------------------------
function Wardrobe_GetItemNameFromTooltip(itemTip)
    if (type(itemTip) ~= "table") then
        return itemTip;
    elseif (type(itemTip[1]) == "table") then
        return itemTip[1]["left"];
    else
        return "NIL";
    end
end


---------------------------------------------------------------------------------
-- Return the name of the item in the specified player's inventory slot number 
-- (1 = "headslot" etc - see Wardrobe_InventorySlots above for a full list of the slots)
---------------------------------------------------------------------------------
function Wardrobe_GetItemNameAtInventorySlotNumber(slotNum)

    local itemName = "";
    
    -- get the id number for the item slot
    local id = GetInventorySlotInfo(Wardrobe_InventorySlots[slotNum]);

    -- point the tooltip at this slot
    local hasItem = WardrobeTooltip:SetInventoryItem("player", id);
    if (hasItem) then
        itemName = Wardrobe_GetItemNameFromToolTip();
    end
    
    return itemName;
end


---------------------------------------------------------------------------------
-- Find the named item on the character's inventory (head slot, hand slot, etc -- not bags)
---------------------------------------------------------------------------------
function Wardrobe_FindInventoryItem(targetItemName)

    local foundItem = false;
    
    for i = 1, table.getn(Wardrobe_InventorySlots) do
    
        if (Wardrobe_GetItemNameAtInventorySlotNumber(i) == targetItemName) then
            foundItem = true;
            break;
        end
    end
    
    return foundItem;
end


---------------------------------------------------------------------------------
-- Return the name of the item in the specified bag and slot
---------------------------------------------------------------------------------
function Wardrobe_GetItemNameInBagSlot(bagNum, slotNum)

    WardrobeTooltip:SetBagItem(bagNum, slotNum);
    itemName = Wardrobe_GetItemNameFromToolTip();
    
    return itemName;
end


---------------------------------------------------------------------------------
-- Return the name of the item that the tooltip is pointing at
---------------------------------------------------------------------------------
function Wardrobe_GetItemNameFromToolTip()

    local itemName = "";
    
    ttext = getglobal("WardrobeTooltipTextLeft1");
    if (ttext and ttext:IsShown() and ttext:GetText() ~= nil) then
        itemName = ttext:GetText();
    end
    
    return itemName;
end


---------------------------------------------------------------------------------
-- Given the name of an item, find the bag and slot the item is in
---------------------------------------------------------------------------------
function Wardrobe_FindContainerItem(targetItemName)
    local foundBag = nil;
    local foundSlot = nil;
    --WardrobeDebug("    Looking in inventory for ["..targetItemName.."]");    
    
   -- for each bag and slot
   if ( Wardrobe_InventorySearchForward == 1 ) then
    bagcounterA = 0
    bagcounterB = NUM_CONTAINER_FRAMES
   else
    bagcounterB = 0
    bagcounterA = NUM_CONTAINER_FRAMES
   end

    for bag = bagcounterA, bagcounterB, Wardrobe_InventorySearchForward do
        local frame = getglobal("ContainerFrame"..bag);
    local counterA = 1
    local counterB = 1

    if ( Wardrobe_InventorySearchForward == 1 ) then
        counterA = 1
        counterB = GetContainerNumSlots(bag)
    else
        counterB = 1
        counterA = GetContainerNumSlots(bag)
    end
        for slot = counterA, counterB, Wardrobe_InventorySearchForward do
        
            -- get the name of the item in this bag/slot
            bagItemName = Wardrobe_GetItemNameInBagSlot(bag, slot);
            WardrobeDebug("         Comparing with "..bagItemName.." Bag:"..bag.." Slot:"..slot);
            
            -- if it matches what we're looking for
            if (targetItemName == bagItemName) then
               WardrobeDebug("           FOUND in bag = "..bag.." slot = "..slot);
                foundBag  = bag;
                foundSlot = slot;
                break;
            end
        end
        if (foundBag and foundSlot) then
            break;
        end
    end

    if ( Wardrobe_InventorySearchForward == 1 ) then
        Wardrobe_InventorySearchForward = -1
    else
        Wardrobe_InventorySearchForward = 1
    end
    
    return foundBag, foundSlot;
end


---------------------------------------------------------------------------------
-- Build a list of items in our bags and on our person
---------------------------------------------------------------------------------
function Wardrobe_BuildItemList()

    tempList = {};
    
    -- for each bag and slot
    for bag = 0, NUM_CONTAINER_FRAMES, 1 do
        local frame = getglobal("ContainerFrame"..bag);
        for slot = 1, GetContainerNumSlots(bag) do
        
            -- get the name of the item in this bag/slot
            local itemName = Wardrobe_GetItemNameInBagSlot(bag, slot);
            if (itemName ~= "") then
                table.insert(tempList, itemName);          
            end
        end
    end

    -- for each inventory item
    for i = 1, table.getn(Wardrobe_InventorySlots) do   
        local itemName = Wardrobe_GetItemNameAtInventorySlotNumber(i);
        if (itemName ~= "") then
            table.insert(tempList, itemName);          
        end
    end

    
    return tempList;    
end



---------------------------------------------------------------------------------
-- Equip the specified item into the specified slot on our character (hands, chest, etc)
---------------------------------------------------------------------------------
function Wardrobe_Equip(itemName, equipSlot)

    -- if we're already holding something, bail
    if (CursorHasItem()) then
        return false;
    end
    
    -- find the bag and slot of this item
    local bag, slot = Wardrobe_FindContainerItem(itemName);
    if (bag and slot) then
        PickupContainerItem(bag, slot);
        if (equipSlot) then
            PickupInventoryItem(equipSlot);
        else
            AutoEquipCursorItem();
        end
        return true;
    end
    return false;
end


---------------------------------------------------------------------------------
-- Check to see if the specified outfit name is already being used
---------------------------------------------------------------------------------
function Wardrobe_FoundOutfitName(outfitName)
    local foundOutfit = false;
    
    for i = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit) do
        if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].OutfitName == outfitName) then
            foundOutfit = true;
            break;
        end
    end
    
    return foundOutfit;
end


---------------------------------------------------------------------------------
-- Return the index of the specified outfitName
---------------------------------------------------------------------------------
function Wardrobe_GetOutfitNum(outfitName)
    local outfitNum = nil;
    
    for i = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit) do
        if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].OutfitName == outfitName) then
            outfitNum = i;
            break;
        end
    end
    
    return outfitNum;
end



---------------------------------------------------------------------------------
-- See if this bag / slot is being used or is free
---------------------------------------------------------------------------------
function Wardrobe_UsedThisSlot(freeBagSpacesUsed, theBag, theSlot)
    for i = 1, table.getn(freeBagSpacesUsed) do
        if (freeBagSpacesUsed[i][1] == theBag and freeBagSpacesUsed[i][2] == theSlot) then
            return true;
        end
    end
    return false;
end


---------------------------------------------------------------------------------
-- Put an item into a free bag slot
---------------------------------------------------------------------------------
function BagItem(freeBagSpacesUsed)

    -- for each bag and slot
    for theBag = 0, 4, 1 do
        local numSlot = GetContainerNumSlots(theBag);
        for theSlot = 1, numSlot, 1 do
        
            -- get info about the item here
            local texture, itemCount, locked = GetContainerItemInfo(theBag, theSlot);
            
            -- if we found nothing, add us to the list of free bag slots
            if (not texture and not Wardrobe_UsedThisSlot(freeBagSpacesUsed, theBag, theSlot)) then
                PickupContainerItem(theBag,theSlot);
                table.insert(freeBagSpacesUsed, {theBag, theSlot});
                return true, freeBagSpacesUsed;
            end
        end
    end
    
    AutoEquipCursorItem();
    
    return false, freeBagSpacesUsed;
end

