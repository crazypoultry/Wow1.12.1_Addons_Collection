--[[

    ShardTracker -- Sorting Code

    Credits to original work by: Ryu (ShardSort)
    Modified by Gottac, Cragganmore
    
  ]]--

-----------------------------------------------------------------------------------
--
-- ShardTracker_UpdateShardSorter: Code by Ryu
--
-- Update the shard sorter engine
--
-----------------------------------------------------------------------------------
function ShardTracker_UpdateShardSorter()

    -- if we're done sorting
    if (ShardTracker_ShardMoverDone) then
        return;
        
    elseif (not ShardTracker_ShardMoverRunning) then
        ShardTracker_ToggleSortFrame(false);
        ShardTracker_ShardMoverDone = true;
    
    -- if we're still cleaning up the shard bag
    elseif (ShardTracker_ShardMoverCleaning) then
        ShardTracker_ShardSortFrameCounter = math.mod(ShardTracker_ShardSortFrameCounter + 1, 10);
        if (ShardTracker_ShardSortFrameCounter == 0) then
            ShardTracker_UpdateShardMoverCleanup();
        end
        
    -- we're done sorting into the shard bag.  initiate cleaning up the shard bag
    elseif (ShardTracker_ShardMoverIndex >= ShardTracker_TotalShardsToMove) then
        
        ShardTracker_ShardMoverCleaning = true;
        ShardTracker_ShardMoverCleanupSlot = 1;
        
    -- else continue sorting into the shardbag
    else
        ShardTracker_ShardSortFrameCounter = math.mod(ShardTracker_ShardSortFrameCounter + 1, 10);
        if (ShardTracker_ShardSortFrameCounter == 0) then
            ShardTracker_SwapShard(ShardTracker_ShardMoverIndex);
            ShardTracker_ShardMoverIndex = ShardTracker_ShardMoverIndex + 1;
        end
    end     
end


-----------------------------------------------------------------------------------
--
-- Cleanup the shards in the shardbag, closing up any empty slots
--
-----------------------------------------------------------------------------------
function ShardTracker_UpdateShardMoverCleanup()

    --ShardTrackerDebug("ShardTracker_UpdateShardMoverCleanup: Entering...");
    
    -- find the next empty slot in the shard bag
    local itemName = "";
    while (ShardTracker_ShardMoverCleanupSlot < GetContainerNumSlots(SHARDTRACKER_CONFIG.THE_SORT_BAG)) do
        itemName = ShardTracker_GetItemNameInBagSlot(SHARDTRACKER_CONFIG.THE_SORT_BAG, ShardTracker_ShardMoverCleanupSlot, true);
        --ShardTrackerDebug("ShardTracker_UpdateShardMoverCleanup: CleanupSlot = "..ShardTracker_ShardMoverCleanupSlot.." itemname = ["..tostring(itemName).."]");
        if (tostring(itemName) == "nil") then
            break;
        else
            ShardTracker_ShardMoverCleanupSlot = ShardTracker_ShardMoverCleanupSlot + 1;
        end
    end
    
    -- if we reached the end of the bag without finding an empty slot
    if (ShardTracker_ShardMoverCleanupSlot == GetContainerNumSlots(SHARDTRACKER_CONFIG.THE_SORT_BAG)) then
        ShardTracker_ShardMoverRunning = nil;
        ShardTracker_ShardMoverCleaning = false;
        --ShardTrackerDebug("ShardTracker_UpdateShardMoverCleanup: Reached end of bag...");
        return;
    end
    
    -- else we found an empty slot 
    local foundAshard = false;
    --ShardTracker("ShardTracker_UpdateShardMoverCleanup: Found empty slot @ "..ShardTracker_ShardMoverCleanupSlot);
    
    -- now look for a shard further on in the bag
    -- updated: start at the bottom of the bag
    --for i = ShardTracker_ShardMoverCleanupSlot + 1, GetContainerNumSlots(SHARDTRACKER_CONFIG.THE_SORT_BAG) do
    for i = GetContainerNumSlots(SHARDTRACKER_CONFIG.THE_SORT_BAG), ShardTracker_ShardMoverCleanupSlot + 1, -1 do


        local itemName = ShardTracker_GetItemNameInBagSlot(SHARDTRACKER_CONFIG.THE_SORT_BAG, i, true);
        
        -- as long as this is a shard, we want to move it into the empty slot
        if (ShardTracker_ShouldBeSorted(itemName)) then
            --ShardTrackerDebug("ShardTracker_UpdateShardMoverCleanup: Found shard to move @ slot "..i.." to slot "..ShardTracker_ShardMoverCleanupSlot);
            PickupContainerItem(SHARDTRACKER_CONFIG.THE_SORT_BAG, i);
            PickupContainerItem(SHARDTRACKER_CONFIG.THE_SORT_BAG, ShardTracker_ShardMoverCleanupSlot);
            foundAshard = true;
            --foundAshard = false;
            ShardTracker_ShardMoverCleanupSlot = ShardTracker_ShardMoverCleanupSlot + 1;
            break;
        end
    end
    
    -- if we didn't find any more shards to move into the empty slot, we're done
    if (not foundAshard) then
        --ShardTrackerDebug("ShardTracker_UpdateShardMoverCleanup: Didn't find a shard to move.  Done!");
        ShardTracker_ShardMoverRunning = nil;
        ShardTracker_ShardMoverCleaning = false;
        ShardTracker_ToggleSortFrame(false);
        return;
    else
        ShardTracker_ShardMoverCleanupSlot = 1;
    end
    
end


-----------------------------------------------------------------------------------
--
-- ShardTracker_Sort: Code by Ryu
--
-- Runs when the user types /sortshards or hits the bound key.
-- First compiles a list of all shards we will move, then starts the sorting
-- by showing the dialog frame (this enables the OnUpdate() method, which will
-- start running once a frame.)
--
-- Note that if we were to call FindShardsToMove() or StoreShards() during the
-- OnUpdate() loop, we could easily slow the frame rate of the game while sorting
-- (a maximum of 16*12 + 4*12*12 = 768 compares per frame.) To avoid this,
-- we call FindShardsToMove() once and store a simple list of all shards to be
-- swapped. We then reference this list during OnUpdate(), reducing our frame-by-frame
-- activity to two PickupContainerItem() calls. 
--
-----------------------------------------------------------------------------------
function ShardTracker_SortShards(button)

	if (button == "RightButton" and ShardTracker_SummonMountSpellID) then
		if SHARDTRACKER_CONFIG.AUTO_SORT == false then
			SHARDTRACKER_CONFIG.AUTO_SORT = true;
			ChatFrame1:AddMessage("ShardTracker: AutoSort ENABLED", 1.0, 1.0, 0.5);
			if (UnitClass("player") == SHARDTRACKER_WARLOCK) then    
				--ShardTrackerDebug("ShardTracker_SortShards: Entering...");
				ShardTracker_FindShardsToMove();
				--ShardTrackerDebug("ShardTracker_SortShards: ShardTracker_TotalShardsToMove = "..ShardTracker_TotalShardsToMove);
	
				ShardTracker_ShardMoverDone = false;
				ShardTracker_ShardMoverRunning = 1;
				if SHARDTRACKER_CONFIG.AUTO_SORT == false then
		      	  	ShardTracker_ToggleSortFrame(true);
		       	end
		        
				if (ShardTracker_TotalShardsToMove > 0) then
					ShardTracker_ShardMoverIndex = 0;
					ShardTracker_ShardMoverCleaning = false;
				else
					ShardTracker_ShardMoverCleaning = true;
					ShardTracker_ShardMoverCleanupSlot = 1;
				end
			end
		else
			SHARDTRACKER_CONFIG.AUTO_SORT = false;
			ChatFrame1:AddMessage("ShardTracker: AutoSort DISABLED", 1.0, 1.0, 0.5);
		end
	else
		if (UnitClass("player") == SHARDTRACKER_WARLOCK) then    
			--ShardTrackerDebug("ShardTracker_SortShards: Entering...");
			ShardTracker_FindShardsToMove();
			--ShardTrackerDebug("ShardTracker_SortShards: ShardTracker_TotalShardsToMove = "..ShardTracker_TotalShardsToMove);
	
			ShardTracker_ShardMoverDone = false;
			ShardTracker_ShardMoverRunning = 1;
			if SHARDTRACKER_CONFIG.AUTO_SORT == false then
		        	ShardTracker_ToggleSortFrame(true);
	       	end
	        
			if (ShardTracker_TotalShardsToMove > 0) then
				ShardTracker_ShardMoverIndex = 0;
				ShardTracker_ShardMoverCleaning = false;
			else
				ShardTracker_ShardMoverCleaning = true;
				ShardTracker_ShardMoverCleanupSlot = 1;
			end
		end
	end
end


function ShardTracker_ToggleSortFrame(toggle)
    if (toggle) then
        ShardTrackerSortText:SetText(SHARDTRACKERSORT_SORTING);
        ShardTrackerSortText:SetTextColor(0.52,0.22,0.86);
        ShardTrackerSortFrame:SetAlpha(1.0);
        if (ColorCycle_Exists) then
            ColorCycle_AlternateColors(
                {
                    ID = "ShardTrackerSortText";
                    globalName = "ShardTrackerSortText";
                    cycleType = "FontText";
                    color1 = {0.50, 0.00, 1.00};
                    color2 = {0.50, 1.00, 0.00};
                    unique = true;
                }
            );
        end
        getglobal("ShardTrackerSortFrame"):Show();
    else
        if (ColorCycle_Exists) then
            ColorCycle_AlternateColors(
                {
                    ID = "ShardTrackerSortText";
                    remove = true;
                }
            );
        end
        getglobal("ShardTrackerSortFrame"):Hide();
    end
end


-----------------------------------------------------------------------------------
--
-- ShardTracker_FindShardsToMove: Code by Ryu
--
-- The idea is pretty simple.
-- Take a look at each bag slot.
-- For every bag slot that is not empty and ISN'T the shard bag, look for shards.
-- If we find a shard, run StoreShard (this searches for an empty slot in the shard bag.)
-- If the shard bag is full, stop looking, since we can't put any more shards in there.
--
-- Note the ShardTracker_ShardMoverFilled array. We need this because we aren't actually MOVING shards
-- right now, only making a list of where we want to move shards TO. We use the ShardTracker_ShardMoverFilled
-- list to keep track of spots in the shard bag that we've already decided to move a shard
-- into. Otherwise, we try to move all the shards into one spot and nothing happens.
--
-----------------------------------------------------------------------------------
function ShardTracker_FindShardsToMove()

    local tooManyShards = nil;
    ShardTracker_TotalShardsToMove = 0;
    ShardTracker_ShardMoverFilled = {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil};

    if (not SHARDTRACKER_CONFIG.THE_SORT_BAG) then
        SHARDTRACKER_CONFIG.THE_SORT_BAG = 4;
    end
    --ShardTrackerDebug("ShardTracker_FindShardsToMove: THE_SORT_BAG = "..SHARDTRACKER_CONFIG.THE_SORT_BAG);
    
    for theBag = 0, 4 do
	    --ShardTrackerDebug("ShardTracker_FindShardsToMove: Checking bag "..theBag);

        local bagSize = GetContainerNumSlots(theBag);
        if (bagSize > 0 and theBag ~= SHARDTRACKER_CONFIG.THE_SORT_BAG) then
            for theSlot = 1, bagSize do
		    --ShardTrackerDebug("ShardTracker_FindShardsToMove: Checking slot "..theSlot);

                local itemName = "";
                itemName = ShardTracker_GetItemNameInBagSlot(theBag, theSlot, true);
                if (itemName) then
				--ShardTrackerDebug("ShardTracker_FindShardsToMove: Found item = ["..itemName.."] in bag = "..theBag.." slot = "..theSlot)
		    end
                if (ShardTracker_ShouldBeSorted(itemName)) then
                     tooManyShards = ShardTracker_StoreShard(theBag, theSlot);   
                end

                if (tooManyShards) then
                    --ShardTrackerDebug("ShardTracker_FindShardsToMove: after StoreShard, tooManyShard = TRUE");
                    break;
                else
                    --ShardTrackerDebug("ShardTracker_FindShardsToMove: after StoreShard, tooManyShard = FALSE");
                end
            end   
        end

        if (tooManyShards) then
            break;
        end
    end
end


-----------------------------------------------------------------------------------
--
-- Returns true if this item should be sorted (shards, soulstones?, healthstones?)
--
-----------------------------------------------------------------------------------
function ShardTracker_ShouldBeSorted(itemName)
    if (not itemName) then return false end;
    
	if (itemName == SHARDTRACKER_SOULSHARD) then
    --if (itemName == SHARDTRACKER_SOULSHARD or string.find(itemName, SHARDTRACKER_SOULSTONE, 1, true) or string.find(itemName, SHARDTRACKER_HEALTHSTONE, 1, true)) then
        return true;
    else
        return false;
    end
end



-----------------------------------------------------------------------------------
--
-- ShardTracker_StoreShard: Code by Ryu
--
-- Here, we've found a shard we want to move and are looking for a slot in the
-- shard bag to put it. We search for a slot that is not already a shard and also
-- hasn't already been marked by a shard we've already found (ShardTracker_ShardMoverFilled array.)
-- If we find one, we set up the array entries and increment ShardTracker_TotalShardsToMove.
-- If not, we return tooManyShards as 1 to indicate the bag is full (or will be full)
-- and we should stop searching.
-- Before we do anything, we verify that the user actually has a bag in the slot
-- indicated by /shardbag.
--
-----------------------------------------------------------------------------------
function ShardTracker_StoreShard(shardBag, shardSlot)

    local theShardBagSize = GetContainerNumSlots(SHARDTRACKER_CONFIG.THE_SORT_BAG);
    local tooManyShards = 1;
 
    --ShardTrackerDebug("ShardTracker_StoreShard: SHARDTRACKER_CONFIG.THE_SORT_BAG = "..SHARDTRACKER_CONFIG.THE_SORT_BAG);
    --ShardTrackerDebug("ShardTracker_StoreShard: theShardBagSize = "..theShardBagSize);
    
    -- if we have no shard sort bag
    if (theShardBagSize == 0) then
--        UIErrorsFrame:AddMessage("Shard Bag doesn't exist! Use /shardtracker bag [bagnum]", 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);  
        return tooManyShards;
    end
 
    -- for each slot in the shard sort bag
    for theShardBagSlot = 1, theShardBagSize do
        --ShardTrackerDebug("ShardTracker_StoreShard: calling ShardTracker_GetItemNameInBagSlot, bag = "..SHARDTRACKER_CONFIG.THE_SORT_BAG.." slot = "..theShardBagSlot);
        local itemName = ShardTracker_GetItemNameInBagSlot(SHARDTRACKER_CONFIG.THE_SORT_BAG, theShardBagSlot, true);
        if (itemName) then
            --ShardTrackerDebug("ShardTracker_StoreShard: looking at itemname = ["..itemName.."] in slot "..theShardBagSlot);
        else
            --ShardTrackerDebug("ShardTracker_StoreShard: looking at itemname = NIL in slot "..theShardBagSlot);
        end
        
        if (not ShardTracker_ShouldBeSorted(itemName)) then
            --ShardTrackerDebug("ShardTracker_StoreShard: itemName ~= soulshard");
            if (ShardTracker_ShardMoverFilled[theShardBagSlot-1] == nil) then   
            	--ShardTrackerDebug("ShardTracker_StoreShard: Adding item to be moved.  shardBag = "..shardBag.." shardSlot = "..shardSlot.." THE_SORT_BAG = "..SHARDTRACKER_CONFIG.THE_SORT_BAG.." theShardBagSlot = "..theShardBagSlot);
            	ShardTracker_ShardMoverArray[ShardTracker_TotalShardsToMove*4 + 0] = shardBag;
            	ShardTracker_ShardMoverArray[ShardTracker_TotalShardsToMove*4 + 1] = shardSlot;
            	ShardTracker_ShardMoverArray[ShardTracker_TotalShardsToMove*4 + 2] = SHARDTRACKER_CONFIG.THE_SORT_BAG;
            	ShardTracker_ShardMoverArray[ShardTracker_TotalShardsToMove*4 + 3] = theShardBagSlot;
            	ShardTracker_ShardMoverFilled[theShardBagSlot-1] = 1;
            	ShardTracker_TotalShardsToMove = ShardTracker_TotalShardsToMove + 1;
            	tooManyShards = nil;
            	break;
            end
        end
    end 
 
    return tooManyShards;
end
 
 
-----------------------------------------------------------------------------------
--
-- ShardTracker_SwapShard: Code by Ryu
--
-----------------------------------------------------------------------------------
function ShardTracker_SwapShard(index)

    -- Take an item, put it somewhere else. Easy!
    PickupContainerItem(ShardTracker_ShardMoverArray[index*4 + 0],ShardTracker_ShardMoverArray[index*4 + 1]);
    PickupContainerItem(ShardTracker_ShardMoverArray[index*4 + 2],ShardTracker_ShardMoverArray[index*4 + 3]);
end


-----------------------------------------------------------------------------------
--
-- ShardTracker_SetShardBag: Code by Ryu
--
-----------------------------------------------------------------------------------
function ShardTracker_SetShardBag(msg)

    if (UnitClass("player") == SHARDTRACKER_WARLOCK) then
        if (msg == "" or tonumber(msg) < 0 or tonumber(msg) > 4) then
            if ( ChatFrame1 ) then
                ChatFrame1:AddMessage("Usage: /shardtracker bag [0-4]. Sets the default bag for shards.");
                ChatFrame1:AddMessage("0 is the backpack, 1-4 are rightmost to leftmost bag slots.");
            end
            return;
        else
            SHARDTRACKER_CONFIG.THE_SORT_BAG = tonumber(msg);
            if ( ChatFrame1 ) then
                 ChatFrame1:AddMessage("Default shard bag is now "..SHARDTRACKER_CONFIG.THE_SORT_BAG..".");
            end
        end
    else
        
    end
end

