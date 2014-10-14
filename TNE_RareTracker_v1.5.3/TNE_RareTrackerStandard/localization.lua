
  -- To localize this addon:
  --   1: translate the English strings to your language, skip the
  --      lines where there's a comment saying you shouldn't
  --   2: write a short comment somewhere in this file; let me know
  --      under what name you want to be credited, and anything else
  --      you'd like to add,
  --   3: save and send this whole file to: silentaddons@gmail.com
  --   4: Thank you :)

  -- global strings
  RARETRACKER_FRAME_ZONE = "%d"
  RARETRACKER_FRAME_SUBZONE = "(%d)"

  RARETRACKER_TOOLTIP_NO_KNOWN_MOBS = "No rare mobs known in %s."
  RARETRACKER_TOOLTIP_MOBS_KNOWN_IN_ZONE = "%d rare mobs known in %s:"
  RARETRACKER_TOOLTIP_MOBS_KNOWN_IN_SUB_ZONE = "%d in or near %s:"
  RARETRACKER_TOOLTIP_MOBS_KNOWN_IN_SUB_ZONE_ONLY = "%s:"
  RARETRACKER_TOOLTIP_MOBS_KNOWN_IN_UNKNOWN = "No subzone/never seen:"
  RARETRACKER_TOOLTIP_SEEN_AT = "Seen at:"
  RARETRACKER_TOOLTIP_MOB = " - %s, %s"

  -- drop down menu items
  TNE_RTS_MENU_ITEMS = {
    { "Actions:",  -- item text (this is the only required line)
      nil,         -- tooltip header
      nil,         -- tooltip text
      nil,         -- function for onclick                         -- don't localize
      nil,         -- variable name for check or not checked state -- don't localize
    },
    { "Scan",
      "Scanning",
      "Causes RareTracker to check if any known rares are nearby. It will NOT discover new rares this way.",
      function() RareTracker:Scan() end,
    },
    { "Settings:",
    },
    { "Lock position",
      "Locking",
      "You can move the RareTracker frame using left mouse button. Lock it when you are happy with its location.",
      function() TNE_RareTrackerStandard_Locked = not TNE_RareTrackerStandard_Locked end,
      "TNE_RareTrackerStandard_Locked",
    },
    { "Sort tooltip by subzone",
      "Sorting",
      "RareTracker can sort data by subzone or display it as a list. Sorting by subzone makes most sense when you have found more than half the mobs in a zone, and for small zones.",
      function() TNE_RareTrackerStandard_SortBySubzone = not TNE_RareTrackerStandard_SortBySubzone end,
      "TNE_RareTrackerStandard_SortBySubzone",
    },
    { "Allow automatic targeting",
      "Automatic targeting",
      "RareTracker can sometimes automatically target rare spawns you find.",
      function() TNE_RareTrackerCore_AutoTarget = not TNE_RareTrackerCore_AutoTarget end,
      "TNE_RareTrackerCore_AutoTarget",
    },
    { "Use default tooltip location",
      "Tooltip location",
      "RareTracker can position the tooltip near its frame or use the default tooltip location.",
      function() TNE_RareTrackerStandard_UseDefaultTooltip = not TNE_RareTrackerStandard_UseDefaultTooltip end,
      "TNE_RareTrackerStandard_UseDefaultTooltip",
    },
  }


if (GetLocale() == "deDE") then

elseif (GetLocale() == "frFR") then

end