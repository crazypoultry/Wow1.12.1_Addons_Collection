
  -- TODO: option to return 0,0 or nothing for unknown coordinates

  RareTracker = {
    version = "1.5.3",
    supportedbuild = "11000",
    lastupdate = "May 04, 2006",
    author = "Silent",
    email = "silentaddons@gmail.com",
    name = "RareTracker",
    frame = "RareTrackerCore",
    cmd = "/raretracker",
    events = {
      "PLAYER_TARGET_CHANGED",
      "UPDATE_MOUSEOVER_UNIT",
    },
    help = {
      ["scan"] = "$v/raretracker scan$ev: Search your surroundings for rare spawns (you cannot find new rares this way).",
      ["autotarget"] = "$v/raretracker autotarget$ev <$von$ev | $voff$ev>: You can allow RareTracker to target mobs.",
      --["about"] = "$v/raretracker about$ev: Displays infomation about this addon.",
    },
  }

  -- addon loading and initialization
  --------------------------------------------------------------------------------

  function RareTracker:OnLoad()

    RareTrackerCore:RegisterEvent("VARIABLES_LOADED")

    TNE_RareTrackerCore_AutoTarget_Default = false
    TNE_RareTrackerCore_AutoTarget = TNE_RareTrackerCore_AutoTarget_Default

    TNE_RareTracker_HitList = {}
    TNE_RareTracker_RegisteredFunctions = {}

    SlashCmdList["RARETRACKERCMD"] = RareTrackerCore_Command
    SLASH_RARETRACKERCMD1 = RareTracker.cmd
  
    TNEUtils.Help(RareTracker, "onload")

  end

  function RareTracker:Initialize()

    RareTracker:ZoneFix()

    TNEUtils.CombatEcho(RareTracker.name.. ": Database loaded.")
    TNEUtils.RegisterEvents(RareTracker.frame, RareTracker.events)

  end

  function RareTracker:OnEvent()

    local target = TNEUtils.Select(event == "PLAYER_TARGET_CHANGED", "target", "mouseover")
    RareTracker:TargetChanged(target)

  end

  function RareTracker:ZoneFix()

    --[[ fix German zones
    if (GetLocale() == "deDE") then
      local articles = {"Der", "Die", "Das"}
      for _, article in articles do
        for zone, data in RT_Database do
          local _, _, realZone = string.find(zone, "^"..article.." (.+)$"))
          if (realZone) then
            RT_Database[realZone] = data
            RT_Database[zone] = nil
          end
        end
      end
    end ]]--

    if (RT_Database["Stormwind Stockade"]) then
      RT_Database["The Stockades"] = RT_Database["Stormwind Stockade"]
      RT_Database["Stormwind Stockade"] = nil
    end

    if (RT_Database["Scarlet Monastary"]) then
      RT_Database["Scarlet Monastery"] = RT_Database["Scarlet Monastary"]
      RT_Database["Scarlet Monastary"] = nil
    end

  end


  -- detection functions
  --------------------------------------------------------------------------------

  function RareTracker:TargetChanged(target)

    if (UnitExists(target) and (UnitClassification(target) == "rare" or UnitClassification(target) == "rareelite")) then
      local zone, name, discovery = RareTracker:AddToDatabase(target) -- add or update
      RareTracker:Announce(zone, name, discovery) -- tell player with a message on the screen
    end

  end


  -- database functions
  --------------------------------------------------------------------------------

  function RareTracker:AddToDatabase(target)
  
    local zone, name, level, creatureType = GetRealZoneText(), UnitName(target), UnitLevel(target), UnitCreatureType(target)
    local discovery = false
 
    if (not (RT_Database and zone and name and level and creatureType)) then
      return nil -- something's fishy
    end
  
    -- make sure the zone exists
    if (not RT_Database[zone]) then
      RT_Database[zone] = {}
    end

    -- add new mobs
    if (not RT_Database[zone][name]) then
      RT_Database[zone][name] = {}
      RT_Database[zone][name].level = level
      RT_Database[zone][name].creatureType = creatureType
      discovery = true
    end

    -- skip displaying some mobs
    if (RT_Database[zone][name].disabled) then -- currently: VanCleef
      return nil
    end
  
    -- don't add it all the time
    if (RareTracker:SpamPrevention(name)) then
      return nil
    end

    -- we cannot get position for mobs, so our own position is the closest we get
    local x, y = GetPlayerMapPosition("player")
  
    -- gather mob stats
    RT_Database[zone][name].creatureFamily = TNEUtils.Select(creatureType == RT_CREATURETYPE_BEAST, UnitCreatureFamily(target), nil)
    RT_Database[zone][name].elite = UnitIsPlusMob(target)
    RT_Database[zone][name].subZone = GetSubZoneText()
    if (not RT_Database[zone][name].locX or RT_Database[zone][name].locX == 0) then
      RT_Database[zone][name].locX, RT_Database[zone][name].locY = x, y
    end
  
    return zone, name, discovery
  
  end


  -- feedback functions
  --------------------------------------------------------------------------------

  
  function RareTracker:SpamPrevention(name)
  
    if (not TNE_RareTracker_HitList[name]) then
      TNE_RareTracker_HitList[name] = GetTime() -- add it to the list of rares we've seen this session
    else
      if (GetTime() - TNE_RareTracker_HitList[name] > 600) then 
        TNE_RareTracker_HitList[name] = GetTime() -- we saw it more than 10 minutes ago, lets redetect it
      else
        return true -- we've recently seen it, don't redetect it
      end
    end
    return nil

  end
  
  
  function RareTracker:Announce(zone, name, discovery)
  
    if (not zone) then return end
 
    local msg = format(TNEUtils.Select(discovery, RT_DISCOVERED, RT_DETECTED), name, RT_Database[zone][name])
    TNEUtils.Alert(msg, 0.13, 1, 0.05, 5) -- TODO: magic color numbers

    RareTracker:Notify(zone, name) -- tell other addons
  
    if (TNE_RareTrackerCore_AutoTarget) then
      TargetByName(name)
    end
  
  end



  -- exporting functions
  --------------------------------------------------------------------------------


  -- local mobs = GetZone(string zone [, string subZone])
  -- params:
    -- zone is a localized zone, ie "Arathi Highlands", as returned by GetRealZoneName()
    -- subZone is a localized part of a zone, returned by GetSubZoneText()
  -- returns:
    -- a table in this format:
    --  {
    --    { "Mob Name 1", "lvl x Elite Humanoid", "58,29", },
    --    { "Mob Name 1", "lvl x Elite Humanoid", "58,29", },
    --  }

  function RareTracker:GetZone(zone, subZone)
    local mobs = RareTracker:GetZoneData(zone, subZone)
    local result = {}
    if (mobs) then
      table.foreach(mobs, function(mob, data) local t={RareTracker:GetMobStrings(mob, data)} table.insert(result, t) end)
    end
    return result

  end


  -- local mobData = GetZoneData(string zone [, string subZone])
  -- params:
    -- zone is a localized zone, ie "Arathi Highlands", as returned by GetRealZoneName()
    -- subZone is a localized part of a zone, returned by GetSubZoneText()
  -- returns:
    -- a table with parts of the 'raw' data. Examine RareTrackerDatabase.lua for format.

  function RareTracker:GetZoneData(zone, subZone)

    if (not RT_Database or not RT_Database[zone]) then
      return nil
    end

    local mobs = {}
    if (subZone) then
      if (subZone == "") then return mobs end
      for mob, data in RT_Database[zone] do
        if (data.subZone and data.subZone == subZone) then
          mobs[mob] = RT_Database[zone][mob]
        end
      end
    else
      mobs = RT_Database[zone]
    end
    return mobs
  
  end

  -- TODO: docs
  
  function RareTracker:GetSortedZoneData(zone)

    if (not RT_Database or not RT_Database[zone]) then
      return 0, nil
    end

    local mobs = {}
    mobs[""] = {}
    for name, data in RT_Database[zone] do
      if (not data.subZone or (data.subZone and data.subZone == "")) then
        table.insert(mobs[""], { RareTracker:GetMobStrings(name, data) })
      elseif (data.subZone) then
        if (not mobs[data.subZone]) then
          mobs[data.subZone] = {}
        end
        table.insert(mobs[data.subZone], { RareTracker:GetMobStrings(name, data) })
      end
    end
    return TNEUtils.TableLength(RT_Database[zone]) or 0, mobs
  end

  -- local name, stats, coords = GetMobStrings(string name, table data)
  -- params:
    -- name is a string of one mob's name, ie "Singer"
    -- data is a table with 'raw' data, from GetZoneData()
  -- returns:
    -- a triplet of formated data:
       -- name: same as parameter name
       -- stats: a string with formated stats returned by GetStats(data)
       -- coords: a string with coordinates, returned by GetCoords(data)

  function RareTracker:GetMobStrings(name, data)

    local stats = format(RT_MOB_STATS, RareTracker:GetStats(data))
    local coords = format(RT_COORDS, RareTracker:GetCoords(data))
    return name, stats, coords
    --return RareTracker_ConvertAsciiData(name), stats, coords

  end
  

  -- local coords = GetCoords(table data)
  -- params:
    -- data is a table with 'raw' data, from GetZoneData()
  -- returns:
     -- coords: a string with coordinates, ie "39,21" or "0,0" if unknown

  function RareTracker:GetCoords(data)

    if (data.locX and data.locY) then
      return math.floor(data.locX * 100), math.floor(data.locY * 100)
    else
      return 0, 0
    end

  end


  -- local stats = GetStats(table data)
  -- params:
    -- data is a table with 'raw' data, from GetZoneData()
  -- returns:
     -- stats: a string with formated stats depending on mob,
     --        ie "lvl 13 Humanoid", or "lvl 49 Elite Cat"
     -- note: default type for beasts are "Beast", but this is replaced
     --       with family types when they are found.

  function RareTracker:GetStats(data)

    local lvl = data.level
    local elite = TNEUtils.Select(data.elite, ELITE.." ", "")
    local family = TNEUtils.Select(data.creatureType == RT_CREATURETYPE_BEAST and data.creatureFamily, data.creatureFamily, data.creatureType)
    return lvl, elite, family

  end


  -- addon interactive functions
  --------------------------------------------------------------------------------

  -- bool success = RegisterForNotification(string functionName, bool asRawData)
  -- params:
    -- functionName is the name of function to call when a rare is found
    -- asRawData, if true, will pass unformated data to the function; else name, stats and coords are passed
  -- returns:
     -- success: true if the function will be notified, else false

  function RareTracker:RegisterForNotification(functionName, asRawData)
    if (getglobal(functionName)) then
      local data = { functionName, asRawData, }
      table.insert(TNE_RareTracker_RegisteredFunctions, data)
      return true
    end
    return false
  end


  -- Notify(string zone, string name)
  -- params:
    -- zone is where mob has been found
    -- name is the name of the mob
  -- description:
    -- notifies all registered functions that 'name' has been found in 'zone',
    -- and passes table data or formated strings to each depending on the asRawData flag
  -- returns:
     -- nothing

  function RareTracker:Notify(zone, name)

    local data = RT_Database[zone][name]
    local _, stats, coords = RareTracker:GetMobStrings(name, data)

    for key, value in TNE_RareTracker_RegisteredFunctions do
      local fun, raw = unpack(value)
      fun = getglobal(fun)
      if (fun) then
        if (raw) then
          fun(name, data)
        elseif (fun) then
          fun(name, stats, coords)
        end
      end
    end
  end


  -- user interactive functions
  --------------------------------------------------------------------------------
  
  -- nil = Scan()
  -- this function will attempt to target all known rares for the current zone.
  -- the other core code will catch any rares, so it's fire-and-forget

  function RareTracker:Scan()

    local mobs = RareTracker:GetZoneData(GetRealZoneText())
    if (not mobs) then return end

    -- hook the error frame to prevent spam
    RareTracker:HookUIErrorsFrame()

    -- search, fido, search!
    local currentTarget, rareTarget = UnitName("target"), nil
    local dead = nil
    for name in mobs do
      TargetByName(name)
      local newTarget = UnitName("target")
      if (newTarget and newTarget == name) then
        dead = UnitIsDead("target")
        rareTarget = name
      end
      if (currentTarget and not (newTarget and newTarget == currentTarget)) then
        TargetLastTarget()
      elseif (newTarget and not (newTarget == currentTarget)) then
        ClearTarget()
      end
    end

    -- target rares
    if (TNE_RareTrackerCore_AutoTarget) then
      if (rareTraget and not (currentTarget or dead)) then
        TargetByName(rareTarget)
      end
    end

    -- ... or fail
    if (not rareTarget) then
      UIErrorsFrame:AddMessage(RT_SCAN_FAILED, 1, 0, 0, 1, UIERRORS_HOLD_TIME)
    end

    -- restore error frame
    RareTracker:ReleaseUIErrorsFrame()

  end

  -- aux functions for Scan()

  function RareTracker:HookUIErrorsFrame()
    TNE_Old_UIErrorsFrame_AddMessage = UIErrorsFrame.AddMessage
    UIErrorsFrame.AddMessage = TNE_UIErrorsFrame_AddMessage
  end

  function RareTracker:ReleaseUIErrorsFrame()
    UIErrorsFrame.AddMessage = TNE_Old_UIErrorsFrame_AddMessage
  end

  function TNE_UIErrorsFrame_AddMessage(data, msg, r, g, b, a, d)
    if (msg == ERR_UNIT_NOT_FOUND) then
      return -- this will filter the "Unknown unit." message
    end
    TNE_Old_UIErrorsFrame_AddMessage(data, msg, r, g, b, a, d)
  end


  -- command handler

  function RareTrackerCore_Command(msg)

    if (not msg) then
      return
    end

    if (string.find(msg, "^scan$")) then
      RareTracker:Scan()
      return
    elseif (string.find(msg, "^autotarget")) then
      TNE_RareTrackerCore_AutoTarget =
        TNEUtils.SetVar(RareTracker, TNE_RareTrackerCore_AutoTarget, string.find(msg, " on$"), "Autotargeting", "autotarget", true)
      return
    elseif (string.find(msg, "^about$")) then
      TNEUtils.About(RareTracker)
    else
      TNEUtils.Help(RareTracker, "list")
    end

  end