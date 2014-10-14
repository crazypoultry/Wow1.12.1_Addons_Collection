

TNE_RTMAP_MENU_ITEMS = { }

TNE_RTMAP_INTERFACES_DATA = {
  ["RareTrackerFrame"] = "RTS", -- [frameName] = code
  ["TitanPanelRareTrackerButton"] = "RTTITAN",
  ["RareTrackerFu"] = "RTFUBAR",
}

TNE_RTMAP_MAPADDON_DATA = {
  ["CT_MapMod_AddNote"] = { -- function name for which, when it exists, the following menu items are added
    {
      "Create notes using CT MapMod", -- item text
      "CT MapMod Integration", -- tooltip header
      "RareTracker can store the locations of the rare spawns you find as 'notes' on your world map. Enable this to create notes with CT Map Mod.", -- tooltip text
      function() TNE_RareTrackerMap_SaveNotes_CT = not TNE_RareTrackerMap_SaveNotes_CT end, -- onclick function
      "TNE_RareTrackerMap_SaveNotes_CT", -- checked variable
    },
  },
  ["MapNotes_GetNoteBySlashCommand"] = {
    {
      "Create notes using MapNotes",
      "MapNotes Integration",
      "RareTracker can store the locations of the rare spawns you find as 'notes' on your world map. Enable this to create notes with MapNotes.",
      function() TNE_RareTrackerMap_SaveNotes_MapNotes = not TNE_RareTrackerMap_SaveNotes_MapNotes end,
      "TNE_RareTrackerMap_SaveNotes_MapNotes",
    },
  },
}

if (GetLocale() == "deDE") then

elseif (GetLocale() == "frFR") then

end