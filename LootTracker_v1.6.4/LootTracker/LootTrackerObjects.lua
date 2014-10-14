--===========================================================================--
----------------------------  LootTracker by PNB  ----------------------------
--===========================================================================--
-- LootTrackerObjects.lua
--
-- Access methods for root level objects.
--===========================================================================--

------------------------------------------------------------------------------
-- GetCurrentSession
-- Gets the current session.
------------------------------------------------------------------------------

function LT_GetCurrentSession()

    local settings = LT_GetSettings();

    local sessionName = settings.CurrentSession;
    if (sessionName == nil) then
        sessionName = LT_DEFAULT_SESSIONNAME;
    end
    
    return LT_GetSession(sessionName, true);
end


------------------------------------------------------------------------------
-- GetSession
-- Gets a session.
------------------------------------------------------------------------------

function LT_GetSession(sessionName, createIfNil)

    if (createIfNil == nil) then
        createIfNil = true;
    end

    local userData = LT_Data[LT_RealmAndPlayer];
    if (userData == nil) then
        userData = {}
        LT_Data[LT_RealmAndPlayer] = userData;
    end
    
    local session = userData[sessionName];
    
    if ((session == nil) and createIfNil) then
        session = {};
        session.Version = LT_Version;
        userData[sessionName] = session;
    end

    return session;
end


------------------------------------------------------------------------------
-- GetAvailableSessions
-- Gets a list of all valid session names.
------------------------------------------------------------------------------

function LT_GetAvailableSessions()

    local userData = LT_Data[LT_RealmAndPlayer];
    local validSessions = {};
    foreach(userData, function(k,v)
        tinsert(validSessions, k);
    end);
    
    return validSessions;

end


------------------------------------------------------------------------------
-- GetSettings
-- Gets the current settings.
------------------------------------------------------------------------------

function LT_GetSettings()

    if (LT_Settings == nil) then
        LT_Settings = {};
    end

    local settings = LT_Settings[LT_RealmAndPlayer];
    if (settings == nil) then
        settings = {};
        LT_Settings[LT_RealmAndPlayer] = settings;
    end
    
    return settings;

end


------------------------------------------------------------------------------
-- GetPendingLoot
-- Gets the current pending loot table.
------------------------------------------------------------------------------

function LT_GetPendingLoot()

    if (LT_PendingLoot == nil) then
        LT_PendingLoot = {};
    end
        
    return LT_PendingLoot;

end


------------------------------------------------------------------------------
-- GetPendingTargets
-- Gets the current pending target table.
------------------------------------------------------------------------------

function LT_GetPendingTargets()

    if (LT_PendingTargets == nil) then
        LT_PendingTargets = {};
    end
        
    return LT_PendingTargets;

end


------------------------------------------------------------------------------
-- GetItems
-- Gets the current item table.
------------------------------------------------------------------------------

function LT_GetItems()

    local session = LT_GetCurrentSession();
    if (session.Items == nil) then
        session.Items = {};
    end

    return session.Items;

end


------------------------------------------------------------------------------
-- GetItemsByQuality
-- Gets a table of the items, but instead of being indexed by name, they're
-- indexed by their quality.
------------------------------------------------------------------------------

function LT_GetItemsByQuality()

    local items = LT_GetItems();
    
    -- Put the items into quality buckets
    local itemsByQuality = {};
    
    foreach(items, function(itemName, item)
    
        -- If this is the first item, create a new table
        if (not LT_TableHasKey(itemsByQuality, item.Quality)) then
            itemsByQuality[item.Quality] = { };
        end

        -- Add the item to the table
        tinsert(itemsByQuality[item.Quality], item);
    
    end);
    
    return itemsByQuality;
    
end


------------------------------------------------------------------------------
-- GetKills
-- Gets the current kill table.
------------------------------------------------------------------------------

function LT_GetKills()

    local session = LT_GetCurrentSession();
    if (session.Kills == nil) then
        session.Kills = {};
    end

    return session.Kills;

end


------------------------------------------------------------------------------
-- GetPlayers
-- Gets the current player table.
------------------------------------------------------------------------------

function LT_GetPlayers()

    local session = LT_GetCurrentSession();
    if (session.Players == nil) then
        session.Players = {};
    end
        
    return session.Players;

end


------------------------------------------------------------------------------
-- SetSession
-- Changes the session.
------------------------------------------------------------------------------

function LT_SetSession(value)

    local settings = LT_GetSettings();
    settings.CurrentSession = value;
    LT_Message(string.format(LT_SLASHCOMMAND_SESSION_CHANGED, settings.CurrentSession));
    
    LT_ValidateCurrentSession();
    
    LT_FireChange();

end


------------------------------------------------------------------------------
-- ValidateSession
-- Validates that the session version is not out of date.
------------------------------------------------------------------------------

function LT_ValidateCurrentSession()

    local session = LT_GetCurrentSession();
    assert(session ~= nil);
    
    LT_ValidateSession(session, "current");
   
end


------------------------------------------------------------------------------
-- ValidateSession
-- Validates that the session version is not out of date.
------------------------------------------------------------------------------

function LT_ValidateSession(session, sessionName)

    assert(session ~= nil);
    assert(sessionName ~= nil);

    if ((session.Version == nil) or (session.Version ~= LT_Version)) then

        LT_Message(LT_VERSION_WARNING);
        
        LT_UpdateDataToCurrentVersion(session, sessionName);
        session.Version = LT_Version;

    end

end


------------------------------------------------------------------------------
-- ResetSession
-- Resets the session data.
------------------------------------------------------------------------------

function LT_ResetSession(sessionToReset)

    local settings = LT_GetSettings();
    if (sessionToReset == nil) then
        sessionToReset = settings.CurrentSession;
    end
    
    local userData = LT_Data[LT_RealmAndPlayer];
    
    if (not (LT_TableHasKey(userData, sessionToReset))) then
        LT_Message(string.format(LT_SLASHCOMMAND_RESET_ERROR, sessionToReset));
    else
        LT_Message(string.format(LT_SLASHCOMMAND_RESET_CHANGED, sessionToReset));
        userData[sessionToReset] = nil;
        LT_FireChange();
    end

end


------------------------------------------------------------------------------
-- ExportSession
-- Exports the current session data to a new name.
------------------------------------------------------------------------------

function LT_ExportSession(exportTarget)

    if (LT_StrIsNilOrEmpty(exportTarget)) then
        LT_Message(LT_SLASHCOMMAND_EXPORT_ERROR);
    end

    -- Take the current session and move it to a new place
    local settings = LT_GetSettings();
    local userData = LT_Data[LT_RealmAndPlayer];
    local session = LT_GetCurrentSession();
    userData[exportTarget] = session;
    userData[settings.CurrentSession] = {};
    
    LT_Message(string.format(LT_SLASHCOMMAND_EXPORT_CHANGED, settings.CurrentSession, exportTarget));
    
    LT_FireChange();
            
end


------------------------------------------------------------------------------
-- CreatePendingLoot
-- Creates a pending loot entry.
------------------------------------------------------------------------------

function LT_CreatePendingLoot(slot, source)

    -- Obtain the loot slot data from the WoW APIs
    local link = GetLootSlotLink(slot);
    local lootIcon, lootName, lootQuantity, lootQuality = GetLootSlotInfo(slot);

    -- Create the loot item
    local loot      = {};
    loot.Name       = lootName;
    loot.Source     = source;
    
    if ((lootQuantity ~= nil) and (lootQuantity > 1)) then
        loot.Quantity = lootQuantity;
    end
    
    -- If this is a money drop, set the Name to "Money"
    if (LT_IsMoneyString(lootName)) then
        LT_DebugMessage(3, "Detected a money drop");
        loot.Name = LT_MONEY;
        loot.Value = LT_ParseMoney(lootName);
    end
    
    -- Trace out the state
    LT_DebugMessage(3, "Created pending loot: " .. lootName);	    
    local settings = LT_GetSettings();
    if (settings.DebugLevel >= 3) then
        LT_FormatMessage(loot);
    end
    
    -- Store the loot in the slot indexed data store
    if (LT_PendingLootBySlot == nil) then
        LT_PendingLootBySlot = {}
    end
    LT_PendingLootBySlot[slot] = loot;

    -- Store the loot in the general data store
    local pendingLoot = LT_GetPendingLoot();
    pendingLoot[loot.Name] = loot
    return loot;

end


------------------------------------------------------------------------------
-- CreatePendingTarget
-- Creates a pending target entry.
------------------------------------------------------------------------------

function LT_CreatePendingTarget()
    
    local unitId = "target";
    
    -- Get the name of whoever the player is currently targetting.
    local name = UnitName(unitId);
    if (name == nil) then
        -- No target
        return;
    end
    
    -- Ignore friendly (non-killable) targets
    if (UnitIsFriend("player", unitId)) then
        return;
    end
    
    local kills = LT_GetKills();
    local kill = kills[name];
    if (kill ~= nil) then
        LT_DebugMessage(4, "Repeat target of kill: " .. name);
        return;
    end
    
    -- Create a new unit info blob
    local unit = LT_CreateRawUnitInfo(unitId);
    
    -- Store the item in the data store
    LT_DebugMessage(3, "New target: " .. name);    
    local pendingTargets = LT_GetPendingTargets();
    pendingTargets[name] = unit;

end


------------------------------------------------------------------------------
-- CreateRawUnitInfo
-- Gets lots of relevant information using the Unit APIs and puts it into a
-- table.
------------------------------------------------------------------------------

function LT_CreateRawUnitInfo(unitId)

    LT_DebugMessage(2, "Creating raw unit info: " .. unitId .. " = " .. UnitName(unitId));
    LT_MessageIndent();

    -- Create a new unit info blob
    local unit = {};
    unit.Level = UnitLevel(unitId);
    unit.Class = UnitClass(unitId);
    unit.CreatureFamily = UnitCreatureFamily(unitId);
    unit.CreatureType = UnitCreatureType(unitId);
    unit.Race = UnitRace(unitId);

    if (UnitIsPlusMob(unitId)) then
        unit.Elite = true;
        LT_DebugMessage(3, "Elite");
    end

    if (UnitIsCivilian(unitId)) then
        unit.Civilian = true;
        LT_DebugMessage(3, "Civilian");
    end

    local classification = UnitClassification(unitId);
    if (classification == "rare" or classification == "rareelite") then
        unit.Rare = true;
        LT_DebugMessage(3, "Rare");
    end
    if (classification == "worldboss") then
        unit.Boss = true;
        LT_DebugMessage(3, "Boss");
    end

    local gender = UnitSex(unitId);
    if (gender == 0) then
        unit.Gender = "Male";
        LT_DebugMessage(3, unit.Gender);
    elseif (gender == 1) then
        unit.Gender = "Female";
        LT_DebugMessage(3, unit.Gender);
    end
    
    LT_MessageUnindent();
    
    return unit;

end


------------------------------------------------------------------------------
-- CreateItem
-- Creates an item entry if none already existed and adds it to the global
-- item table.  If one already existed, its information is updated.
------------------------------------------------------------------------------

function LT_CreateItem(itemId)

    local rawItem = LT_GetItem(itemId);

    if (rawItem == nil) then
        LT_DebugMessage(2, "Unable to create item info from reference: " .. itemId);
        return nil;
    end
    
    local item, quantity = LT_CreateItemFromRaw(rawItem);
    
    return item, quantity;

end


------------------------------------------------------------------------------
-- CreateItemFromRaw
-- Creates an item entry if none already existed and adds it to the global
-- item table.  If one already existed, its information is updated.
------------------------------------------------------------------------------

function LT_CreateItemFromRaw(rawItem, source)

    local items         = LT_GetItems();
    
    local zoneText      = LT_GetZoneString();
    local currentTime   = time();
    LT_OnSessionEvent(currentTime);
    
    -- If we've already looted this item, use the existing entry
    local item = items[rawItem.Name];
    local new = false;
    if (item ~= nil) then

        -- Add the zone, but don't include duplicates
        LT_AddIfNotPresent(item.Zones, zoneText);
        
        -- Add another "time looted", even if its a duplicate
        tinsert(item.TimesLooted, currentTime);
        
        -- Trace out the results of the update
        local settings = LT_GetSettings();
        if (settings.DebugLevel >= 3) then
            LT_FormatMessage(item);
        end
    else
        new = true;
        
        -- Create a new item
        item                = {};
        item.Name           = rawItem.Name;
        item.Quality        = rawItem.Quality;
        item.Zones          = { zoneText };
        item.TimesLooted    = { currentTime };
        item.Link           = rawItem.Link;
        item.MinLevel       = rawItem.MinLevel;
        item.Class          = rawItem.Class;
        item.SubClass       = rawItem.SubClass;
        item.MaxStack       = rawItemMaxStack;
        item.EquipLoc       = rawItem.EquipLoc;
        item.Texture        = rawItem.Texture;
        
        -- Update extended metadata
        LT_UpdateItem(item);
                
        -- Store the item in the data store
        items[item.Name] = item;
    end
    
    LT_FireChange();
    
    local quantity = 1;
    
    -- Check any pending loot for matches
    local pendingLoot = LT_GetPendingLoot();
    local pendingLootMatch = pendingLoot[item.Name];
    if (pendingLootMatch ~= nil) then
        if (source == nil) then
            -- Get the source from the pending loot
            source = pendingLootMatch.Source;        
            if (source ~= nil) then
                LT_DebugMessage(3, "Matched to pending loot from " .. source);
            end
        end
        
        if (LT_IsPlayerSolo() and pendingLootMatch.Quantity ~= nil) then
            quantity = pendingLootMatch.Quantity;
        end
        
        -- Remove the pending loot
        pendingLoot[item.Name] = nil;
    end
    
    if (source ~= nil) then
        -- Add this source to the sources list
        if (item.Sources == nil) then
            item.Sources = {};
        end
        LT_AddCountEntry(item.Sources, source, quantity);
            
        -- Add this loot to the matching kill's Loot list
        local kills = LT_GetKills();
        if (LT_TableHasKey(kills, source)) then
            local kill = kills[source];
            
            if (kill.Drops == nil) then
                kill.Drops = {};
            end
            LT_AddCountEntry(kill.Drops, item.Name, quantity);
        end
       
    else
        LT_DebugMessage(3, "Source unknown");
    end
    
    
    local trace = "Repeat item";
    local traceLevel = 2;
    if (new) then
        trace = "New item";
        traceLevel = 1;
    end
        
    if (quantity > 1) then
        trace = string.format("%s (x%d): ", trace, quantity);
    else
        trace = trace .. ": "
    end
   
    LT_DebugMessage(traceLevel, trace .. LT_GetItemSummary(item));
    

    -- Trace out the initial state of the item        
    if (new) then
        local settings = LT_GetSettings();
        if (settings.DebugLevel >= 3) then
            LT_FormatMessage(item);
        end
    end
    
    LT_FireChange();
    return item, quantity;
    
end


------------------------------------------------------------------------------
-- UpdateItem
------------------------------------------------------------------------------

function LT_UpdateItem(item)

    if (item.Link == nil) then
        return;
    end
    
    local itemId = LT_ExtractItemIDFromLink(item.Link);
    
    
    local totalValues = 0;
    local totalValueSources = 0;

    -- This code uses the Auctioner APIs:
    --
    --      Auctioneer_GetVendorSellPrice(itemId)
    --
    --      This function gets the sell price (how much it the player will get if they sell it)
    --      from Auctioneer's database of item prices.
    --      @param itemId The ID portion of the item link (the first of the four numbers).
    --      @returns A price if known (may be 0 if known to have no price) or nil if unknown.
    --
    -- Auctioneer is an optional dependency, so we must check for nil here.
    
    if (Auctioneer_GetVendorSellPrice ~= nil) then
    
        LT_DebugMessage(4, "Scrounging for item info using " .. item.Link);
            
        if (itemId ~= nil) then
        
            local value = Auctioneer_GetVendorSellPrice(itemId);
            
            if (value ~= nil) then
                LT_DebugMessage(3, "Auctioneer reported value for " .. item.Name .. ": " .. tostring(value));
                totalValues = totalValues + value;
                totalValueSources = totalValueSources + 1;
            else
                LT_DebugMessage(3, "Auctioneer had no value for " .. itemId);
            end
        else
            LT_DebugMessage(2, "Unable to parse link: " .. item.Link);
        end
    else
        LT_DebugMessage(3, "Auctioneer not loaded, unable to get value");
    end
    
    
    -- PriceMaster
    
    if (CompletePrices ~= nil) then
        local priceEntry = CompletePrices[itemId];
        if (priceEntry ~= nil) then
            local value = priceEntry.p;
            if (value ~= nil) then
                LT_DebugMessage(3, "PriceMaster reported value for " .. item.Name .. ": " .. tostring(value));
                totalValues = totalValues + value;
                totalValueSources = totalValueSources + 1;
            else
                LT_DebugMessage(3, "PriceMaster had no value for " .. itemId);
            end
        else
            LT_DebugMessage(3, "PriceMaster had no entry for " .. itemId);
        end
    end
    
    if (totalValueSources > 0) then
        averageValue = totalValues / totalValueSources;
        LT_DebugMessage(3, "Averaged value from " .. totalValueSources .. " for " .. item.Name .. ": " .. averageValue);
        
        if (averageValue > 0) then
            item.Value = averageValue;
        end
    end
    
end


------------------------------------------------------------------------------
-- CreatePlayer
-- Creates a player entry if none already existed and adds it to the global
-- player table.
------------------------------------------------------------------------------

function LT_CreatePlayer(name)

    local players = LT_GetPlayers();
    LT_OnSessionEvent();
    
    -- We've already logged this player - no modifications are necessary
    local existingEntry = players[name];
    if (existingEntry ~= nil) then
        return existingEntry;
    end;
    
    -- Create a new player object
    local player = { };
    player.Name = name;
    
    -- Update unit information
    LT_UpdatePlayer(player);

    -- Trace out the initial state of the player
    LT_DebugMessage(1, "New player: " .. LT_GetPlayerSummary(player));	    
    
    local settings = LT_GetSettings();
    if (settings.DebugLevel >= 3) then
        LT_FormatMessage(player);
    end
    
    -- Store the player in the data store
    players[name] = player;
    LT_FireChange();
    
    return player;

end


------------------------------------------------------------------------------
-- UpdatePlayer
-- Updates the unit information on the given player object.
------------------------------------------------------------------------------

function LT_UpdatePlayer(player)

    local unitId = LT_GetPlayerUnitID(player.Name);

    if (unitId == nil) then
        LT_DebugMessage(2, "Unable to get unit ID for player \"" .. player.Name .. "\"");
        return false;
    end
    
    local unitInfo = LT_CreateRawUnitInfo(unitId);
    local guildName, guildRankName, guildRankIndex = GetGuildInfo(unitId);
    local rankNumber = UnitPVPRank(unitId);
    
    player.Level    = unitInfo.Level;
    player.Class    = unitInfo.Class;
    player.Race     = unitInfo.Race;
    player.Gender   = unitInfo.Gender;
    
    player.Guild    = guildName;
    player.PVPRank  = rankNumber;
    player.Gear     = LT_GetGear(unitId);
    
    
    local maxHealth = UnitHealthMax(unitId);
    player.Health = maxHealth;
    LT_DebugMessage(2, "Health: " .. player.Health);
    
    -- Mana is power type 0
    local powerType = UnitPowerType(unitId);
    if (powerType == 0) then
        local maxMana = UnitManaMax(unitId);
        player.Mana = maxMana;
        LT_DebugMessage(2, "Mana: " .. player.Mana);
    end
    
    -- Armor (May only work for local player)
    local baseArmor, effectiveArmor, unbuffedArmor, posBuffArmor, negBuffArmor = UnitArmor(unitId);
    LT_DebugMessage(2, "Armor: " .. effectiveArmor);
    if (effectiveArmor > 0) then
        player.Armor = effectiveArmor;
    end
    
    -- AttackPower (May only work for local player
    local baseAP, posBuffAP, negBuffAP = UnitAttackPower(unitId);
    local effectiveAP = baseAP + posBuffAP + negBuffAP;
    LT_DebugMessage(2, "AttackPower: " .. effectiveAP);
    if (effectiveAP > 0) then
        player.AttackPower = effectiveAP;
    end
    
    local stats = {[1]="Strength", [2]="Agility", [3]="Stamina", [4]="Intellect", [5]="Spirit"};
    foreach(stats, function(statId,statName)
        local baseStat, effectiveStat, posBuffStat, negBuffStat = UnitStat(unitId, statId);
        LT_DebugMessage(2, statName .. ": " .. effectiveStat);
        if (effectiveStat > 0) then
            player[statName] = effectiveStat;
        end
    end);
    
    -- TODO: Investigate
    -- lowDmg, hiDmg, offlowDmg, offhiDmg, posBuff, negBuff, percentmod = UnitDamage("unit");
    -- speed, lowDmg, hiDmg = UnitRangedDamage("player");
    -- base, posBuff, negBuff = UnitRangedAttackPower("unit");
    
    return true;

end


------------------------------------------------------------------------------
-- CreateKill
-- Creates a kill entry if none already existed and adds it to the global
-- kill table.  If one already existed, its count is updated.
------------------------------------------------------------------------------

function LT_CreateKill(name)

    local kills = LT_GetKills();
    
    local zoneText      = LT_GetZoneString();
    local currentTime   = time();
    LT_OnSessionEvent(currentTime);
    
    -- If we've already killed this mob, use the existing entry
    local existingEntry = kills[name]
    if (existingEntry ~= nil) then
    
        LT_DebugMessage(2, "Repeat kill: " .. name);
    
        -- Add the zone, but don't include duplicates
        LT_AddIfNotPresent(existingEntry.Zones, zoneText);
        
        -- Add another "time killed", even if its a duplicate
        tinsert(existingEntry.TimesKilled, currentTime);
        
        -- Trace out the results of the update
        
        local settings = LT_GetSettings();
        if (settings.DebugLevel >= 3) then
            LT_FormatMessage(existingEntry);
        end
        
        LT_FireChange();
        return;
    end
    
    -- Create a new kill entry
    local kill          = { };
    kill.Name           = name;
    kill.Zones          = { zoneText };
    kill.TimesKilled    = { currentTime };
    
    -- Update unit information
    LT_UpdateKill(kill);
    
    -- Trace out the initial state of the kill
    LT_DebugMessage(1, "New kill: " .. LT_GetKillSummary(kill));	    
    
    local settings = LT_GetSettings();
    if (settings.DebugLevel >= 3) then
        LT_FormatMessage(kill);
    end
    
    -- Store the kill in the data store
    kills[name] = kill;
    LT_FireChange();
    
    return kill;

end


------------------------------------------------------------------------------
-- UpdateKill
-- Updates the unit information on the given kill object.
------------------------------------------------------------------------------

function LT_UpdateKill(kill)

    local pendingTargets = LT_GetPendingTargets();
    local pendingTarget = pendingTargets[kill.Name];

    if (pendingTarget == nil) then
        LT_DebugMessage(3, "Unable to get target info for kill \"" .. kill.Name .. "\"");
        return false;
    end
    
    LT_DebugMessage(3, "Found pending target info for kill \"" .. kill.Name .. "\"");
    
    kill.Level = pendingTarget.Level;
    kill.Class = pendingTarget.Class;
    kill.CreatureFamily = pendingTarget.CreatureFamily;
    kill.CreatureType = pendingTarget.CreatureType;
    kill.Race = pendingTarget.Race;
    
    kill.Elite = pendingTarget.Elite;
    kill.Rare = pendingTarget.Rare;
    kill.Boss = pendingTarget.Boss;
    kill.Civilian = pendingTarget.Civilian;
    kill.Gender = pendingTarget.Gender;
    
    -- Remove the pending entry
    pendingTargets[kill.Name] = nil;
    
    return false;

end


------------------------------------------------------------------------------
-- UpdateObject
-- Updates the data on an item, kill, or player.
------------------------------------------------------------------------------

function LT_UpdateObject(name)

    local items     = LT_GetItems();
    local kills     = LT_GetKills();
    local players   = LT_GetPlayers();

    if (LT_TableHasKey(items, name)) then

        LT_DebugMessage(1, "Updating item: " .. name);
        LT_UpdateItem(items[name]);

    elseif (LT_TableHasKey(kills, name)) then

        LT_DebugMessage(1, "Updating kill: " .. name);
        LT_UpdateKill(kills[name]);

    elseif (LT_TableHasKey(players, name)) then

        LT_DebugMessage(1, "Updating player: " .. name);
        LT_UpdatePlayer(players[name]);

    elseif (name == "items") then
    
        -- Update all items
        foreach(items, function(k,v)
            LT_DebugMessage(1, "Updating item: " .. k);
            LT_UpdateItem(v);
        end);
        
    elseif (name == "kills") then
    
        -- Update all items
        foreach(kills, function(k,v)
            LT_DebugMessage(1, "Updating kill: " .. k);
            LT_UpdateKill(v);
        end);
        
    elseif (name == "players") then
    
        -- Update all items
        foreach(players, function(k,v)
            LT_DebugMessage(1, "Updating player: " .. k);
            LT_UpdatePlayer(v);
        end);
    
    else
        LT_Message(string.format(LT_SLASHCOMMAND_UPDATE_ERROR2, name));

    end

end


------------------------------------------------------------------------------
-- TransferItem
-- Move an item from one player to another.
------------------------------------------------------------------------------

function LT_TransferItem(playerNameSource, playerNameTarget, itemName)

    local playerSource = LT_CreatePlayer(playerNameSource);
    local playerTarget = LT_CreatePlayer(playerNameTarget);
    
    local items = LT_GetItems();
    local item = items[itemName];
    if (item ~= nil) then
        local removedSuccessfully = LT_RemoveLootFromPlayer(item, playerSource);
        
        if (removedSuccessfully) then
            LT_AddLootToPlayer(item, playerTarget);
        else
            -- Item does not exist on player
            LT_Message(string.format(LT_SLASHCOMMAND_TRANSFER_ERROR3, playerNameSource));    
            return;
        end
    else
        -- Item does not exist
        LT_Message(string.format(LT_SLASHCOMMAND_TRANSFER_ERROR2, itemName));
        return;
    end
    
    LT_Message(string.format(LT_SLASHCOMMAND_TRANSFER_MSG, itemName, playerNameSource, playerNameTarget));

end


------------------------------------------------------------------------------
-- AddLootToPlayer
-- Link this item and player together.
------------------------------------------------------------------------------

function LT_AddLootToPlayer(item, player)
    
    -- Add this player to the item's Recipients list
    if (item.Recipients == nil) then
        item.Recipients = { };
    end
    LT_AddCountEntry(item.Recipients, player.Name, 1);
    
    -- Add this loot to the player's Loot list
    if (player.Loot == nil) then
        player.Loot = { };
    end
    LT_AddCountEntry(player.Loot, item.Name, 1);

end


------------------------------------------------------------------------------
-- RemoveLootFromPlayer
-- Unlink this item and player.
------------------------------------------------------------------------------

function LT_RemoveLootFromPlayer(item, player)

    if (item.Recipients == nil) then
        return false;
    end
    
    if (player.Loot == nil) then
        return false;
    end
    
    local removedFromRecipients = LT_AddCountEntry(item.Recipients, player.Name, -1);
    local removedFromLoot = LT_AddCountEntry(player.Loot, item.Name, -1);
    
    return (removedFromRecipients and removedFromLoot);

end


------------------------------------------------------------------------------
-- AddNameCountDupleEntry
-- Add a [Name]=Count style entry to the given table.  If an
-- entry already exists of this name, increment the count.
------------------------------------------------------------------------------

function LT_AddCountEntry(t, name, add)

    local existing = t[name];
    if (existing == nil) then
        existing = 0;
    end
    
    t[name] = existing + add;
    return (existing > 0);

end


------------------------------------------------------------------------------
-- LT_AddSource
-- Adds a source entry to the given item.
------------------------------------------------------------------------------

function LT_AddSource(item, source, amount)

    if (item == nil) then
        return;
    end
    
    LT_DebugMessage(3, string.format("Marking source as \"%s\"", source));
    if (item.Sources == nil) then
        item.Sources = {};
    end
    LT_AddCountEntry(item.Sources, source, amount);
    
end


------------------------------------------------------------------------------
-- OnSessionEvent
-- Logs the time of the event to get a good idea of when the session really
-- started and ended.
------------------------------------------------------------------------------

function LT_OnSessionEvent(currentTime, session)

    if (currentTime == nil) then
        currentTime = time();
    end

    if (session == nil) then
        session = LT_GetCurrentSession();
    end
    
    -- First event
    if (session.FirstEventTime == nil) then
        local currentDate = date(nil, currentTime);
        LT_DebugMessage(2, "First session event: " .. currentDate);
        session.FirstEventTime = currentTime;
    end
    
    -- Last event
    session.MostRecentEventTime = currentTime;

end


--===========================================================================--
-- Backwards Compatibility
--===========================================================================--

------------------------------------------------------------------------------
-- UpdateDataToCurrentVersion
-- Attempt to correct known changes to get this session data looking 
-- a little closer.
------------------------------------------------------------------------------

function LT_UpdateDataToCurrentVersion(session, sessionName)
    
    LT_Message("Updating \"" .. sessionName .. "\" data to comply with version " .. LT_Version);
    
    local currentTime = time();

    -- FirstEventTime was added in version 1.5.1.        
    if (session.FirstEventTime == nil) then
        LT_DebugMessage(2, "Adding FirstEventTime entry");
        session.FirstEventTime = currentTime;
    end
    -- MostRecentEventTime was added in version 1.5.1.
    if (session.MostRecentEventTime == nil) then
        LT_DebugMessage(2, "Adding MostRecentEventTime entry");
        session.MostRecentEventTime = currentTime;
    end
    -- FirstEvent was removed in version 1.6.
    if (session.FirstEvent ~= nil) then
        LT_DebugMessage(2, "Removing FirstEvent entry");
        session.FirstEvent = nil;
    end
    -- MostRecentEvent was removed in version 1.6.
    if (session.MostRecentEvent ~= nil) then
        LT_DebugMessage(2, "Removing MostRecentEvent entry");
        session.MostRecentEvent = nil;
    end
    
    local items = session.Items;
    if (items ~= nil) then
        foreach (items, function(itemName, item)
            
            -- TimesLooted in version 1.5.1 and earlier was represented as a string.
            -- It was changed in 1.6 to be just a number.
            if (item.TimesLooted ~= nil) then
            
                local newTimesLooted = LT_Version_UpdateTimeFormat(item.TimesLooted, currentTime);
            
                if (newTimesLooted) then
                    LT_DebugMessage(3, "Updating TimesLooted entries for " .. itemName);
                    item.TimesLooted = newTimesLooted;
                end
            end
            
            -- The Recipients list was represented as a Name,Count pair in pre 0.9.5 versions.
            -- We need to convert it to just be the count value.
            if (item.Recipients ~= nil) then

                local newRecipients = LT_Version_UpdateCountFormat(item.Recipients);
                
                if (newRecipients) then
                    LT_DebugMessage(2, "Updating Recipients entries for " .. itemName);
                    item.Recipients = newRecipients;
                end

            end
            
            -- The Sources list was represented as a Name,Count pair in pre 0.9.5 versions.
            -- We need to convert it to just be the count value.
            if (item.Sources ~= nil) then

                local newSources = LT_Version_UpdateCountFormat(item.Sources);
                                
                if (newSources) then
                    LT_DebugMessage(2, "Updating Sources entries for " .. itemName);
                    item.Sources = newSources;
                end

            end
            
            if (itemName == LT_MONEY) then

                -- In version 1.6 Money was changed from a running average Value to
                -- having the count pushed to the recipients.                                    
                if (item.Value ~= 1) then
                
                    local averageValue = item.Value;
                    item.Value = 1;
                    
                    LT_DebugMessage(2, "Updating " .. LT_MONEY .. " entry (previous average value was " .. tostring(averageValue) .. ")");
                    
                    local newRecipients = {};
                    foreach (item.Recipients, function(recipientName, recipientCount)
                        newRecipients[recipientName] = floor(averageValue * recipientCount);
                        LT_DebugMessage(3, "Changing money for " .. recipientName .. " from " .. tostring(recipientCount) .. " to " .. tostring(newRecipients[recipientName]));
                    end);
                    item.Recipients = newRecipients;
                end
                
                -- In version 1.6 the Everyone recipient keyword was removed.
                local everyoneCount = 0;
                foreach (item.Recipients, function(recipientName, recipientCount)
                    if (recipientName == "Everyone") then
                        everyoneCount = recipientCount;
                    end
                end);
                if (everyoneCount > 0) then
                
                    LT_DebugMessage(2, "Updating " .. LT_MONEY .. " entry.  Distributing \"Everyone\" count: " .. tostring(everyoneCount));
                
                    -- Who is "Everyone"?  Consider it to be all player entries.
                    local playerNames = {};
                    local players = session.Players;
                    if (players ~= nil) then
                        foreach (players, function(playerName,player)
                            tinsert(playerNames, playerName);
                        end);
                    end
                                            
                    local newRecipients = {};
                    
                    -- Copy over the old entries
                    foreach (item.Recipients, function(recipientName, recipientCount)
                        if (recipientName ~= "Everyone") then
                            newRecipients[recipientName] = recipientCount;
                        end
                    end);
                    
                    -- Apply the count to "Everyone"
                    foreach (playerNames, function(k, recipientName)
                        if (newRecipients[recipientName] == nil) then
                            newRecipients[recipientName] = 0;
                        end
                        
                        newRecipients[recipientName] = newRecipients[recipientName] + everyoneCount;
                        LT_DebugMessage(3, "Added " .. tostring(everyoneCount) .. " to " .. recipientName .. " for a new total of " .. newRecipients[recipientName]);
                    end);
                    
                    item.Recipients = newRecipients;
                end
            
            end

        end);

    end
    
    
    local kills = session.Kills;
    if (kills ~= nil) then
        foreach (kills, function(killName, kill)
        
            -- The Drops list was represented as a Name,Count pair in pre 0.9.5 versions.
            -- We need to convert it to just be the count value.
            if (kill.Drops ~= nil) then

                local newDrops = LT_Version_UpdateCountFormat(kill.Drops);
                
                if (newDrops) then
                    LT_DebugMessage(2, "Updating Drops entries for " .. killName);
                    kill.Drops = newDrops;
                end

            end
            
            -- TimesKilled in version 1.5.1 and earlier was represented as a string.
            -- It was changed in 1.6 to be just a number.
            if (kill.TimesKilled ~= nil) then
            
                local newTimesKilled = LT_Version_UpdateTimeFormat(kill.TimesKilled, currentTime);
            
                if (newTimesKilled) then
                    LT_DebugMessage(3, "Updating TimesLooted entries for " .. killName);
                    kill.TimesKilled = newTimesKilled;
                end
            end

        end);
    end
    
    
    local players = session.Players;
    if (players ~= nil) then
        foreach (players, function(playerName, player)
        
            -- The Loot list was represented as a Name,Count pair in pre 0.9.5 versions.
            -- We need to convert it to just be the count value.
            if (player.Loot ~= nil) then

                local newLoot = LT_Version_UpdateCountFormat(player.Loot);
                
                if (newLoot) then
                    LT_DebugMessage(2, "Updating Loot entries for " .. playerName);
                    player.Loot = newLoot;
                end

            end
            
            -- TimesKilled in version 1.5.1 and earlier was represented as a string.
            -- It was changed in 1.6 to be just a number.
            if (player.TimesKilled ~= nil) then
            
                local newTimesKilled = LT_Version_UpdateTimeFormat(player.TimesKilled, currentTime);
            
                if (newTimesKilled) then
                    LT_DebugMessage(3, "Updating TimesLooted entries for " .. playerName);
                    player.TimesKilled = newTimesKilled;
                end
            end

        end);
    end
    
    LT_Message("Done updating");
    
end


------------------------------------------------------------------------------
-- LT_Version_UpdateTimeFormat
-- Take data that used to be:
--   [1] = "03/21/06 23:35:05",
-- And change it to be:
--   [1] = 123456789,
------------------------------------------------------------------------------

function LT_Version_UpdateTimeFormat(times, currentTime)

    assert(times ~= nil);
    assert(currentTime ~= nil);
    
    local newTimes = {};
    local change = false;
    
    foreach (times, function(k, v)
        if (type(v) == "string") then
            -- Try to parse the time.  But if that doesn't work (which won't
            -- if the locale doesn't match, just give up and use the current
            -- time instead.
            local time = LT_ParseTime(v);
            if (time == nil) then
                time = currentTime;
            end
            
            LT_DebugMessage(4, "Changing " .. v .. " to " .. tostring(time));
            
            v = time;
            change = true;
        end
        newTimes[k] = v;
    end);
    
    -- Only return the list if there was a change.
    if (change) then
        return newTimes;
    end
    
    return nil;

end


------------------------------------------------------------------------------
-- Version_UpdateCountFormat
-- Take data that used to be:
--   ["Name"] = {"Name"=Name, "Count"=Count} 
-- And change it to be:
--   ["Name"] = Count
------------------------------------------------------------------------------

function LT_Version_UpdateCountFormat(counts)

    assert(counts ~= nil);

    local newCounts = {};
    local change = false;

    foreach (counts, function(k, v)
        if (type(v) == "table") then
            v = v.Count;
            change = true;
        end
        newCounts[k] = v;
    end);
    
    -- Only return the list if there was a change.
    if (change) then
        return newCounts;
    end
    
    return nil;
    
end
