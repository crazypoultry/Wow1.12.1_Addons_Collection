
  RareTrackerMap = {
    version = "1.5.3",
    supportedbuild = "11000",
    lastupdate = "April 19, 2006",
    author = "Silent",
    email = "silentaddons@gmail.com",
    name = "RareTracker Map",
    frame = "RareTrackerMapFrame",
    cmd = "/raretracker",
    events = {
      "VARIABLES_LOADED",
    },
    help = {
      ["about"] = "$v/fs about$ev: Displays infomation about this addon.",
    },
  }


  -- addon loading and initialization
  --------------------------------------------------------------------------------

  function RareTrackerMap:Initialize()

    local coreName = "TNE_RareTrackerCore"
    UIParentLoadAddOn(coreName)

    TNEUtils.RegisterEvents(RareTrackerMap.frame, RareTrackerMap.events)
    RareTracker:RegisterForNotification("RareTrackerMap_Notify")

  end


  -- interaction with other addons
  --------------------------------------------------------------------------------

  function RareTrackerMap:Integrate()

    -- scan for and add available map addons

    for dependency, data in TNE_RTMAP_MAPADDON_DATA do
      if (getglobal(dependency)) then
        for _, item in data do
          table.insert(TNE_RTMAP_MENU_ITEMS, item)
        end
      end
    end

    -- copy settings to available interfaces

    for frame, code in TNE_RTMAP_INTERFACES_DATA do
      if (getglobal(frame)) then
        local items = getglobal("TNE_".. code.. "_MENU_ITEMS")
        for _, item in TNE_RTMAP_MENU_ITEMS do
          table.insert(items, item)
        end
      end
    end

    return table.getn(TNE_RTMAP_MENU_ITEMS)

  end


  -- reporting functions
  --------------------------------------------------------------------------------

  function RareTrackerMap_Notify(name, stats, coords)

    local x,y = GetPlayerMapPosition("player")

    -- CT MapMod
    if (TNE_RareTrackerMap_SaveNotes_CT and CT_MapMod_AddNote) then
      RareTrackerMap:CreateNoteCT(name, stats, x, y)
    end

    -- MapNotes
    if (TNE_RareTrackerMap_SaveNotes_MapNotes and MapNotes_GetNoteBySlashCommand) then
      RareTrackerMap:CreateNoteMapNotes(name, stats, x, y)
    end

  end

  function RareTrackerMap:CreateNoteCT(name, stats, x, y)
    CT_MapMod_AddNote(x, y, GetRealZoneText(), name, stats, 4, 3) -- simplicity ftw
  end

  function RareTrackerMap:CreateNoteMapNotes(name, stats, x, y)

    local old_SetNextAsMiniNote = MapNotes_SetNextAsMiniNote -- override quick note settings
    MapNotes_SetNextAsMiniNote = 0

    local continent = GetCurrentMapContinent()
    local zone = TNEUtils.Select(continent == -1, 0, MapNotes_ZoneShift[continent][GetCurrentMapZone()])
    local creator = UnitName("player")

    local pattern = "c<%d> z<%d> x<%f> y<%f> t<%s> i1<%s> i2<%s> cr<%s> i<%d> tf<%d> i1f<%d> i2f<%d>"
    local msg = format(pattern, continent, zone, x, y, name, stats, "", creator, 5, 0, 9, 0)
    MapNotes_GetNoteBySlashCommand(msg)

    MapNotes_SetNextAsMiniNote = old_SetNextAsMiniNote

  end


  -- frame scripts
  --------------------------------------------------------------------------------

  function RareTrackerMapFrame_OnLoad()

    TNE_RareTrackerMap_SaveNotes_CT = true
    TNE_RareTrackerMap_SaveNotes_MapNotes = true

    RareTrackerMap:Initialize()

  end

  function RareTrackerMapFrame_OnEvent()

    RareTrackerMap:Integrate()

  end
