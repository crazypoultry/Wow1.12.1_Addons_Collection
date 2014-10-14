-- constants
local ICON_SHARD=            "Interface\\Icons\\INV_Misc_Gem_Amethyst_02";
local SOULSHARD_ID=          6265;      -- soulshard item ID
local SOUND_REQUEST=         "Sound\\interface\\iCreateCharacterA.wav";
local SOUND_FAILED=          "Sound\\interface\\igQuestFailed.wav";
local MAP_ASPECT=            1.5;       -- main map aspect ratio
local MAP_YARD_UNIT_RATIO=   0.000036;  -- conversion ratio main map units to yards

-- private internal state
local registeredForUpdate=   { };    -- list of functions to call during UpdateInterfaces()

-- check if item is a soulshard
local function IsSoulshard(bag, slot)
  local link= GetContainerItemLink(bag, slot);
  if (link) then
    local _,_, itemID= string.find(link, "item:(%d+):");
    if (itemID and tonumber(itemID) == SOULSHARD_ID) then
      return true;
    end;
  end;
  return false;
end;

-- returns raid, 40 or party, 4, depending on group type
local function GetGroupDescriptor()
  if (GetNumRaidMembers() > 0) then
    return "raid", 40;
  elseif (GetNumPartyMembers() > 0) then
    return "party", 4;
  else
    return nil, 0;
  end;
end;

-- remove short color codes from text
local function StripColorCodes(lstring)
  local result= string.gsub(lstring, "%<h%>", "");
  result= string.gsub(result, "%<%/h%>", "");
  return result;
end;

-- convert short color codes to wow codes
local function ProcessColorCodes(lstring)
  local result= string.gsub(lstring, "%<h%>", NORMAL_FONT_COLOR_CODE);
  result= string.gsub(result, "%<%/h%>", FONT_COLOR_CODE_CLOSE);
  return result;
end;


rsmUtil= {

  -- return location of a unit on the worldmap
  UnitCoords= function(unitID, fast)
    -- backup map incase we want to restore it later
    local backupContinent= GetCurrentMapContinent();
    local backupZone= GetCurrentMapZone();  
    
    -- zoom out to global view and get unit positions
    SetMapZoom(0);
    local Ux, Uy= GetPlayerMapPosition(unitID);
    
    -- restore previous map
    if (not fast) then
      SetMapZoom(backupContinent, backupZone);
    end;
        
    return Ux, Uy
  end;
  
  -- tries to determine if unit in instance
  UnitInInstance= function(unitID, fast)
    local x, y= rsmUtil.UnitCoords(unitID, fast); 
    if (x == 0 and y == 0) then
      return true;
    else
      return false;
    end;
  end;
  
  -- return distance between two units in yards. works outside of instances only
  -- specify nil for unit2 to cause the function to use specified coords Uxy instead
  UnitDistance= function(unitID1, unitID2, Ux, Uy, fast)
    -- backup map incase we want to restore it later
    local backupContinent= GetCurrentMapContinent();
    local backupZone= GetCurrentMapZone();  
    
    -- zoom out to global view and get unit positions
    SetMapZoom(0);
    local Ax, Ay= GetPlayerMapPosition(unitID1);
    local Bx, By;
    if (unitID2) then
      Bx, By= GetPlayerMapPosition(unitID2);
    else
      Bx= Ux;
      By= Uy;
    end;
    
    -- restore previous map
    if (not fast) then
      SetMapZoom(backupContinent, backupZone);
    end;
    
    -- check if target and player are visible on the map
    if ((Ax == 0 and Ay == 0) or (Bx == 0 and By == 0)) then
      return 0;
    end;
    
    -- work around aspect ratio (round about)
    Ax= Ax *MAP_ASPECT;
    Bx= Bx *MAP_ASPECT;
    
    -- calculate distance and return it
    local dist= math.sqrt((Ax-Bx)^2 + (Ay-By)^2) / MAP_YARD_UNIT_RATIO;
    return dist;
  end;

  -- check if unit has other raidunits in proximity and return number
  UnitNumCompany= function(poiUnitID, maxDist, fast)
    local param, maxID= GetGroupDescriptor();
    if (not param) then
      return nil;
    end;

    -- these will be changed by UnitDistance
    local backupContinent= GetCurrentMapContinent();
    local backupZone= GetCurrentMapZone();  
    
    -- scan through all units
    numCompany= 0;
    for i= 1, maxID do
      local unitID= param..i;
      if (UnitExists(unitID) and not UnitIsDeadOrGhost(unitID) and not UnitIsUnit(unitID, poiUnitID) and UnitIsConnected(unitID)) then
        local unitDist= rsmUtil.UnitDistance(unitID, poiUnitID, nil, nil, true);
        if (unitDist < maxDist) then
          numCompany= numCompany +1;
        end;
      end;
    end;

    -- restore mapsettings changed by UnitDistance
    if (not fast) then
      SetMapZoom(backupContinent, backupZone);
    end;
    
    return numCompany;
  end;    
  
  -- check if another warlock is within interact distance of this player (used within instances since no coords are available)
  FindInteractWarlock= function(selectFunc)
    local param, maxID= GetGroupDescriptor();
    if (not param) then
      return nil;
    end;
    
    -- scan for warlocks in range and if they have raidsummon, check if they have shards
    local candidates= { };
    for i= 1, maxID do
      local unitID= param..i;
      if (UnitExists(unitID) and not UnitIsDeadOrGhost(unitID) and UnitIsConnected(unitID)) then
        local _, unitClass= UnitClass(unitID);
        if (unitClass == "WARLOCK" and not UnitIsUnit("player", unitID) and (not selectFunc or selectFunc(unitID))) then
          table.insert(candidates, { id= unitID, name= unitName });
        end;
      end;
    end;
    
    -- randomly select one
    local num= table.getn(candidates);
    if (num > 0) then
      local select= math.random(num);
      return candidates[select].id, candidates[select].name;
    else
      return nil, nil;
    end;
  end;
  
  -- used to check if there are any warlocks outside the instance
  -- either uses location of poiUnitID or manually specified coords Ux and Uy if poiUnitID== nil
  -- previously this always selected the closest warlock with company, but this leads to all the requests
  -- being redirected to the same warlock (unless he runs away), which is quite inefficient and also unfair ;)
  FindNearbyWarlock= function(maxDist, poiUnitID, Ux, Uy, selectFunc)
    local param, maxID= GetGroupDescriptor();
    if (not param) then
      return nil;
    end;

    -- these will be changed by UnitDistance
    local backupContinent= GetCurrentMapContinent();
    local backupZone= GetCurrentMapZone();      

    -- scan for locks in range
    local candidates= { };
    local numCandidates= 0;
    for i= 1, maxID do
      local unitID= param..i;
      if (UnitExists(unitID) and not UnitIsDeadOrGhost(unitID) and UnitIsConnected(unitID)) then
        local _, unitClass= UnitClass(unitID);
        if (unitClass == "WARLOCK" and not UnitIsUnit("player", unitID)) then
          local unitDist= rsmUtil.UnitDistance(unitID, poiUnitID, Ux, Uy, true);
          if ((unitDist < maxDist) and (not selectFunc or selectFunc(unitID))) then
            local unitHasCompany= (rsmUtil.UnitNumCompany(unitID, 100, true) >= 2);
            candidates[unitID]= { name= unitName, dist= unitDist, hasCompany= unitHasCompany };
            numCandidates= numCandidates +1;
          end;
        end;
      end;
    end;
    
    -- restore mapsettings changed by UnitDistance
    SetMapZoom(backupContinent, backupZone);
    
    -- check if warlocks with assistants in range were found. if so,  remove all others
    for _, info in candidates do
      if (info.hasCompany) then
        for unitID, innerInfo in candidates do
          if (not innerInfo.hasCompany) then
            candidates[unitID]= nil;
            numCandidates= numCandidates -1;
          end;
        end;
        break;
      end;
    end;

    -- check if warlocks are within half the specified range, if so, prefer those
    for _, info in candidates do
      if (info.dist <= maxDist / 2) then
        for unitID, innerInfo in candidates do
          if (innerInfo.dist > maxDist / 2) then
            candidates[unitID]= nil;
            numCandidates= numCandidates -1;
          end;
        end;
        break;
      end;
    end;
    
    -- randomly pick one of the remaining candidates
    if (numCandidates > 0) then
      local select= math.random(numCandidates);
      local i= 1;
      for unitID, info in candidates do
        if (i == select) then
          return unitID, info.name;
        end;
        i= i +1;
      end;
    end;
    return nil, nil;
  end;  
  
  -- scans for the most distant members in the raid/party
  FindDistantMember= function(minDist, ignoreFunc)
    local param, max= GetGroupDescriptor();
    if (not param) then
      return nil;
    end;

    -- these will be changed by UnitDistance
    local backupContinent= GetCurrentMapContinent();
    local backupZone= GetCurrentMapZone();  
    
    -- scan through all units
    local warlock=     nil; -- contains name of a warlock that could be summoned, if any
    local member=      nil; -- name of a raidmember that could be summoned, if any
    local warlockDist= 0;   -- last max. distance to another warlock
    local memberDist=  0;   -- last max. distance to normal member to make sure we start with most distant
    for i= 1, max do
      local unitID= param..i;

      -- if unit exists, check if warlock and/or in same location
      if (UnitExists(unitID) and not UnitIsDeadOrGhost(unitID) and UnitIsConnected(unitID)) then
        local _, unitClass= UnitClass(unitID);
        local unitName, _= UnitName(unitID);
        local unitDist= rsmUtil.UnitDistance("player", unitID, nil, nil, true);
        
        -- if further away than last possible target, select this player as target        
        if ((unitDist > minDist) and (not ignoreFunc or ignoreFunc(unitName))) then
          if (unitClass == "WARLOCK") then
            if (unitDist > warlockDist) then
              warlock, _= UnitName(unitID);
              warlockDist= unitDist;
            end;
          else
            if (unitDist > memberDist) then
              member, _= UnitName(unitID);
              memberDist= unitDist;
            end;
          end;
        end;
      end;
    end;

    -- restore mapsettings changed by UnitDistance
    SetMapZoom(backupContinent, backupZone);
    
    -- if warlocks found, return the most distant one, otherwise return most distant member, otherwise nil
    if (warlock ~= nil) then
      return warlock;
    elseif (member ~= nil) then
      return member;
    else
      return nil;
    end;
  end;
  
  -- split a string
  SplitString= function(delimiter, text)
    local list= {};
    local pos= 1;
    if strfind("", delimiter, 1) then -- this would result in endless loops
      return nil;
    end;
    while 1 do
      local first, last= strfind(text, delimiter, pos);
      if first then -- found?
        tinsert(list, strsub(text, pos, first-1));
        pos= last +1;
      else
        tinsert(list, strsub(text, pos));
        break;
      end;
    end;
    return list;
  end;  
 
  -- display a message in the upper center of the screen
  DisplayMessage= function(msg, isError)
    msg= ProcessColorCodes(msg);
    if (isError) then
      UIErrorsFrame:AddMessage(msg, 1.0, 0.0, 0.0, 1.0, 3);
    else
      UIErrorsFrame:AddMessage(msg, 0.9, 0.7, 0.0, 1.0, 3);
    end;
  end;

  -- print a chatmessage to the default chat frame
  PrintChatMessage= function(msg)
    msg= ProcessColorCodes(msg);  
    DEFAULT_CHAT_FRAME:AddMessage(msg);
  end;

  -- send a message to party or raidchat
  PartyOrRaidMessage= function(msg)
    msg= StripColorCodes(msg);
    if (GetNumRaidMembers() > 0) then
      SendChatMessage(msg, "RAID");
    elseif (GetNumPartyMembers() > 0) then
      SendChatMessage(msg, "PARTY");
    end;
  end;

  -- play sound events
  PlaySoundRequest= function()
    PlaySoundFile(SOUND_REQUEST);
  end;
  PlaySoundFailed= function()
    PlaySoundFile(SOUND_FAILED);
  end;

  -- returns localized string for table entry s
  GetLocalized= function(s)
    local lstring;

    -- make sure table is loaded
    if (RSM_LANG ~= nil) then
      -- reset to english, if language invalid
      if (RSM_LANG[rsmSaved.interactLang] == nil) then
        rsmSaved.interactLang= "en";
      end;
      -- if table now valid return string - if found
      if (RSM_LANG[rsmSaved.interactLang] ~= nil) then
        lstring= RSM_LANG[rsmSaved.interactLang][s];
        if (lstring == nil) then
          lstring= "";
          rsmUtil.PrintChatMessage("RaidSummon: Internal error: Invalid translation table entry.");
        end;
        return lstring;
         
      -- if table still invalid, something is really wrong
      else
        rsmUtil.PrintChatMessage("RaidSummon: Internal error: Translation table corrupted!");
        return "";

      end;
   
    -- table is not loaded, something is really really wrong
    else
      rsmUtil.PrintChatMessage("RaidSummon: Internal error: No translation table found!");
      return "";
    end;
  end;

  -- send localized tell to a player
  -- replace %n with playername, %g{"a","b"} with genderspecific string "a" or "b"
  SendTell= function(msgID, player, otherUnit)
    if (rsmSaved.whisper) then
      local msg= rsmUtil.GetLocalized(msgID);
      local myself, _= UnitName("player");
      msg= string.gsub(msg, "%%n", myself);
      msg= string.gsub(msg, "%%g%{(%a+),(%a+)%}", "%"..(UnitSex("player") -1));
      if (otherUnit) then
        local otherNick, _= UnitName(otherUnit);
        msg= string.gsub(msg, "%%w", otherNick);
        msg= string.gsub(msg, "%%h%{(%a+),(%a+)%}", "%"..(UnitSex(otherUnit) -1));
      end;
      msg= StripColorCodes(msg);
      SendChatMessage(msg, "WHISPER", this.language, player);
    end;
  end;

  -- count available shards
  GetNumShards= function()
    local shardCount= 0;
    for bag= 4, 0, -1 do
      local size= GetContainerNumSlots(bag);
      if (size > 0) then
        for slot= 1, size, 1 do
          local texture= GetContainerItemInfo(bag, slot);
          if ((texture == ICON_SHARD) and IsSoulshard(bag, slot)) then
            shardCount= shardCount +1;
          end;
        end;
      end;
    end;
    return shardCount;
  end;

  -- return unitID of nickname
  GetPID= function(nickname)
    local myself, _= UnitName("player");
    if (nickname == myself) then
      return "player";
    end;
    
    local param, num= GetGroupDescriptor();
    if (param) then
      for i= 1, num do
        local unitID= param..i;
        local unitName, _= UnitName(unitID);
        if (nickname == unitName) then
          return unitID;
        end;
      end;
    end;
    return nil;
  end;

  -- returns a hash containing all raidmembers
  GetRaidSnapshot= function()
    local result= { };
    local param, num= GetGroupDescriptor();
    if (param) then
      for i= 1, num do
        local unitID= param..i;
        if (UnitExists(unitID)) then
          local _, unitClass= UnitClass(unitID);
          local unitName, _= UnitName(unitID);
          result[unitName]= { id= unitID, class= unitClass };
        end;
      end;
    end;
    return result;
  end;

  -- update registered external interface addons
  UpdateInterfaces= function()
    for _, func in registeredForUpdate do
      func();
    end;
  end;

  -- register function to be called on interface update
  RegisterForUpdate= function(func)
    if (type(func) == "function") then
      table.insert(registeredForUpdate, func);
    end;
  end;
  
}