


--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
function mq.CompileItemStack(objItemLink, tradeCount)
  for bagIndex=0, 4, 1 do
    for slotIndex=1, 16, 1 do
      local tmpLink = GetContainerItemLink(bagIndex, slotIndex);
      if (tmpLink ~= nil) then
        tmpLink = string.gsub(tmpLink, "|cff(.*)|H(.*)|h(.*)|h|r.*", "%2");
        if (tmpLink == objItemLink) then
          local texture, itemCount, locked, quality, readable = GetContainerItemInfo(bagIndex, slotIndex);
          if (itemCount == tradeCount and not locked) then
            -- exact stack count found - return the bag and slot index of this stack.
            return bagIndex, slotIndex;
          end
        end
      end
    end
  end

  -- no stack matching 'tradeCount', we need to compile one

  -- find a free bag slot
  local freeBagIndex, freeSlotIndex = mq.GetFreeBagSlot();
  if (freeBagIndex == nil) then
    mq.IO.error("No free slot available for item split.");
    -- send an error
    return nil, nil;
  end
  
  local stackCount = 0;
  local stackFound = false;
  
  for bagIndex=0, 4, 1 do
    for slotIndex=1, 16, 1 do
      local tmpLink = GetContainerItemLink(bagIndex, slotIndex);
      if (tmpLink ~= nil) then
        tmpLink = string.gsub(tmpLink, "|cff(.*)|H(.*)|h(.*)|h|r.*", "%2");
        local texture, itemCount, locked, quality, readable = GetContainerItemInfo(bagIndex, slotIndex);

        if (tmpLink == objItemLink and not locked) then
          stackFound = true;
          
          local missingCount = tradeCount - stackCount;
          local splitCount = math.min(missingCount, itemCount);
          
          SplitContainerItem(bagIndex, slotIndex, splitCount);
          PickupContainerItem(freeBagIndex, freeSlotIndex);
          
          stackCount = stackCount + splitCount;

          -- return if the stack has been completed          
          if (stackCount == tradeCount) then
            return freeBagIndex, freeSlotIndex;
          end
        end
      end
    end
  end
  
  if (stackFound) then
    return freeBagIndex, freeSlotIndex;
  else
    return nil, nil;
  end
end

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
function mq.GetFreeBagSlot()
  for bagIndex=0, 4, 1 do
    for slotIndex=1, 16, 1 do
      local itemLink = GetContainerItemLink(bagIndex, slotIndex)
      if (itemLink == nil) then
        return bagIndex, slotIndex
      end
    end
  end

  return nil, nil;
end

    --local objItemLink = myquests.QuestLog[1].objectives[1].item.link;
    --local objItemLink = "item:2592:0:0:0";
    
