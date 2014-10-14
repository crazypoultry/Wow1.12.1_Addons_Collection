
FlagHandler = {
   -- entries will be kept for 30 days.
   --purgeInterval = 2592000;
};

FlagList2 = {};


--[[

FlagHandler.addFlag()

-- Add flag <flag> with value <value> for player <name>.

]]--
function FlagHandler.addFlag(flag, value, name)
   if flag == nil then 
      return;
   end

   if flag == "RPFlag" or flag == "Surname" or flag =="Title" then
      --FlagRSP.printDebug("it is: " .. time() .. " and for " .. name .. " we get " .. flag .. " with value: " .. value);

      if FlagList2[FlagRSP.rName] == nil then
	 FlagList2[FlagRSP.rName] = {};
      end
      if FlagList2[FlagRSP.rName][name] == nil then
	 FlagList2[FlagRSP.rName][name] = {};
	 table.setn(FlagList2[FlagRSP.rName], table.getn(FlagList2[FlagRSP.rName])+1);
      end
      --if FlagList[flag][name] == nil then
	 --FlagList[flag][name] = {};
      --end

      FlagList2[FlagRSP.rName][name][flag] = value;
      FlagList2[FlagRSP.rName][name].timeStamp = time();
      FlagList2[FlagRSP.rName][name].faction = UnitFactionGroup("player");
   end 
end


--[[

FlagHandler.addDesc()

-- Add description <text> revision <rev> part <num> for player <name>. <desc> is for future use.

]]--
function FlagHandler.addDesc(desc, num, text, name, rev, partial)
   if partial == nil then
      partial = false;
   end

   flag = "Desc";

   if FlagList2[FlagRSP.rName] == nil then
      FlagList2[FlagRSP.rName] = {};
   end
   if FlagList2[FlagRSP.rName][name] == nil then
      FlagList2[FlagRSP.rName][name] = {};
      table.setn(FlagList2[FlagRSP.rName], table.getn(FlagList2[FlagRSP.rName])+1);
   end
   if FlagList2[FlagRSP.rName][name][flag] == nil then
      FlagList2[FlagRSP.rName][name][flag] = {};
   end
   if FlagList2[FlagRSP.rName][name][flag][desc] == nil then
      FlagList2[FlagRSP.rName][name][flag][desc] = {};
      FlagList2[FlagRSP.rName][name][flag][desc].complete = false;
   end
   
   --if FlagList[flag][name].value[desc] == nil then
   --   FlagList[flag][name].value[desc] = {};
   --   FlagList[flag][name].value[desc].complete = false;
   --end

   FlagList2[FlagRSP.rName][name][flag][desc][num] = text;

   --FlagList[flag][name].value[desc][num] = text;

   --FlagRSP.printM("Change desc rev for: " .. name .. " to " .. rev);
   --FlagList[flag][name].value[desc].revision = rev;

   FlagList2[FlagRSP.rName][name][flag][desc].revision = rev;
   
   if not partial then
      FlagList2[FlagRSP.rName][name][flag][desc].complete = true;
      --FlagList[flag][name].value[desc].complete = true;
   end

   local i = 1;
   local lastPart;
   --while FlagList[flag][name].value[desc][i] ~= nil do
   while FlagList2[FlagRSP.rName][name][flag][desc][i] ~= nil do
      lastPart = string.sub(FlagList2[FlagRSP.rName][name][flag][desc][i], string.len(FlagList2[FlagRSP.rName][name][flag][desc][i])-3);

      if lastPart == "\\eod" then
	 FlagRSP.printDebug("last part: " .. lastPart);
	 FlagList2[FlagRSP.rName][name][flag][desc].complete = true;
      end
      
      i = i + 1;
   end

   FlagList2[FlagRSP.rName][name].timeStamp = time();
   FlagList2[FlagRSP.rName][name].faction = UnitFactionGroup("player");
end


--[[

FlagHandler.delDesc()

-- Delete description for player <name>. <desc> is for future use.

]]--
function FlagHandler.delDesc(desc, name)
   flag = "Desc";

   --FlagRSP.printM("Delete desc for: " .. name);

   if FlagList2[FlagRSP.rName] ~= nil and FlagList2[FlagRSP.rName][name] ~= nil and FlagList2[FlagRSP.rName][name][flag] ~= nil and FlagList2[FlagRSP.rName][name][flag][desc] ~= nil then
      local i = 1;
      --FlagRSP.printDebug("Deleting old lines: " .. name);
      --FlagRSP.printDebug("First line is: " .. FlagList[flag][name].value[desc][i]);
      while FlagList2[FlagRSP.rName][name][flag][desc][i] ~= nil do
	 --FlagRSP.printDebug("line " .. i .. "(" .. name .. ")");
	 FlagList2[FlagRSP.rName][name][flag][desc][i] = nil;
	 i = i + 1;
      end

      FlagList2[FlagRSP.rName][name][flag][desc].revision = -1;
      FlagList2[FlagRSP.rName][name][flag][desc].complete = false;
   end
end


--[[

FlagHandler.purgeFlags()

-- Purges old flags that haven't been seen for quite some time.

]]--
function FlagHandler.purgeFlags()
   --FlagRSP.printM("Purging cached flags (all flags that are older than " .. FlagRSPSettings.FlagPurgeInterval .. " seconds)...");

   FlagHandler.setn();

   -- oldest timestamp we accept.
   local delTime = time() - FlagRSPSettings.FlagPurgeInterval;
   local entriesDeleted = 0;
   local entriesDeletedRealm = 0;

   for realm, list in FlagList2 do
      -- e.g. list is FlagList["RPFlag"]
      -- e.g. flag is "RPFlag"
      
      --FlagRSP.print("flag is: " .. flag);

      entriesDeletedRealm = 0;

      for name, entry in list do
	 --FlagRSP.print("name is: " .. name);

	 if entry.timeStamp == nil then
	    list[name] = nil;
	    entriesDeleted = entriesDeleted + 1;
	    entriesDeletedRealm = entriesDeletedRealm + 1;
	 elseif entry.timeStamp < delTime then
	    --FlagRSP.printM("name " .. name .. "is too old. Deleting...");
	    list[name] = nil;
	    entriesDeleted = entriesDeleted + 1;
	    entriesDeletedRealm = entriesDeletedRealm + 1;
	 end
      end

      table.setn(list, table.getn(list) - entriesDeletedRealm);
   end
   
   if entriesDeleted > 0 then
      local msg = string.gsub(FlagRSP_Locale_EntriesPurged, "%%s", entriesDeleted);
      FlagRSP.printM(msg);
   end
end


--[[

FlagHandler.purgeAllFlags()

-- Purges ALL saved flags.

]]--
function FlagHandler.purgeAllFlags()

   local entriesDeleted, flags = FlagHandler.getStats();

   FlagList2 = nil;
   FlagList2 = {}; 
 
   local msg = string.gsub(FlagRSP_Locale_EntriesPurged, "%%s", entriesDeleted);
   FlagRSP.printM(msg);
end


--[[

FlagHandler.getFlag()

-- Get flag <flag> for player <name>.

]]--
function FlagHandler.getFlag(flag, name)
   local value = "";

   if FlagList2[FlagRSP.rName] ~= nil and FlagList2[FlagRSP.rName][name] ~= nil and FlagList2[FlagRSP.rName][name][flag] ~= nil then
      value = FlagList2[FlagRSP.rName][name][flag];
   end

   if value == nil then
      value = "";
   end

   return value;
end


--[[

FlagHandler.getDesc()

-- Get description <desc> for player <name>.

]]--
function FlagHandler.getDesc(desc, name)
   local rev = -1;
   local descLines = {};
   local complete = false;

   flag = "Desc";

   if FlagList2[FlagRSP.rName] ~= nil and FlagList2[FlagRSP.rName][name] ~= nil and FlagList2[FlagRSP.rName][name][flag] ~= nil and FlagList2[FlagRSP.rName][name][flag][desc] ~= nil then
   --if FlagList[flag] ~= nil and FlagList[flag][name] ~= nil and FlagList[flag][name].value ~= nil and FlagList[flag][name].value[desc] ~= nil then
      rev = FlagList2[FlagRSP.rName][name][flag][desc].revision;
      --FlagList[flag][name].value[desc].revision;
      
      if FlagList2[FlagRSP.rName][name][flag][desc].complete ~= nil then
	 complete = FlagList2[FlagRSP.rName][name][flag][desc].complete;
      end
      
      local i = 1;
      while FlagList2[FlagRSP.rName][name][flag][desc][i] ~= nil do
	 lastPart = string.sub(FlagList2[FlagRSP.rName][name][flag][desc][i], string.len(FlagList2[FlagRSP.rName][name][flag][desc][i])-3);
	 
	 if lastPart == "\\eod" then
	    descLines[i] = string.sub(FlagList2[FlagRSP.rName][name][flag][desc][i], 1, string.len(FlagList2[FlagRSP.rName][name][flag][desc][i])-4);
	    i = -2;
	 else
	    descLines[i] = FlagList2[FlagRSP.rName][name][flag][desc][i];   
	 end
	 
	 i = i + 1;
      end
   end

   return complete, rev, descLines;
end


--[[

FlagHandler.getDescRev()

-- Get description revision <rev> for player <name>.

]]--
function FlagHandler.getDescRev(desc, name)
   local rev = -1;
   flag = "Desc";

   if FlagList2[FlagRSP.rName] ~= nil and FlagList2[FlagRSP.rName][name] ~= nil and FlagList2[FlagRSP.rName][name][flag] ~= nil and FlagList2[FlagRSP.rName][name][flag][desc] ~= nil then
      rev = FlagList2[FlagRSP.rName][name][flag][desc].revision;
   end

   return rev;
end


--[[

FlagHandler.getStats()

-- Returns some statistics about saved flags.

]]--
function FlagHandler.getStats()
   local numEntries = 0;
   local flags = {};
   local numEntriesRealm = 0;

   for i = 0, 4 do
      flags[i] = 0;
   end

   --FlagRSP.printDebug("on realm: naga there are " .. table.getn(FlagList2) .. " entries.");   

   for realm, list in FlagList2 do
      numEntriesRealm = 0;
      --FlagRSP.printDebug("on realm: " .. realm .. " there are " .. table.getn(FlagList2[FlagRSP.rName]) .. " entries.");
      --numEntries = numEntries + table.getn(FlagList2[realm]);

      for name, entry in list do
	 numEntries = numEntries + 1;
	 numEntriesRealm = numEntriesRealm + 1;
	 if entry.RPFlag ~= nil then
	    --FlagRSP.printDebug("on realm: " .. realm .. " there is: " .. name .. " with RP flag: " .. entry.RPFlag);
	    flags[entry.RPFlag] = flags[entry.RPFlag] + 1;
	 end
      end

      if numEntriesRealm ~= table.getn(list) then
	 FlagRSP.printE("On realm: " .. realm .. " number of entries in FlagList is: " .. numEntriesRealm .. ", table size is: " .. table.getn(list) .. ". Values should NOT differ.");
      else
	 FlagRSP.printDebug("num entries and table size match on " .. realm);
      end

      --FlagRSP.printDebug("on realm: " .. realm .. " there are " .. numEntries .. " entries.");
   end

   return numEntries, flags;
end


--[[

FlagHandler.setn()

-- counts number of FlagList2 entries.

]]--
function FlagHandler.setn()
   local n;

   --FlagRSP.printM("SETN");

   for realm, list in FlagList2 do
      n = 0;
      
      for name, entry in list do
	 n = n + 1;
      end

      table.setn(list, n);
   end
end