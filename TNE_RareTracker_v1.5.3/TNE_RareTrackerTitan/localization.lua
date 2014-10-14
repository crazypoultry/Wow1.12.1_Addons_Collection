
  TNE_RTTITAN_MENU_ITEMS = {
    { "Scan",
      "Scanning",
      "Causes RareTracker to check if any known rares are nearby. It will NOT discover new rares this way.",
      function() RareTracker:Scan() end,
    },
    { "Allow automatic targeting",
      "Automatic targeting",
      "RareTracker can sometimes automatically target rare spawns you find.",
      function() TNE_RareTrackerCore_AutoTarget = not TNE_RareTrackerCore_AutoTarget end,
      "TNE_RareTrackerCore_AutoTarget",
    },
    { "Sort tooltip by subzone",
      "Sorting",
      "RareTracker can sort data by subzone or display it as a list. Sorting by subzone makes most sense when you have found more than half the mobs in a zone, and for small zones",
      function() TNE_RTTitan_SortBySubzone = not TNE_RTTitan_SortBySubzone end,
      "TNE_RTTitan_SortBySubzone",
    },
  }

  RT_NO_MOBS_KNOWN_IN_ZONE = "No rare mobs known in %s."
  RT_MOBS_KNOWN_IN_ZONE = "%s rare mobs known in %s:\t%s"
  RT_MOBS_KNOWN_IN_SUB_ZONE = "%s of them near or in %s:\t%s"
  RT_TOOLTIP_MOBS_KNOWN_IN_SUB_ZONE_ONLY = "%s:"
  RT_TOOLTIP_MOBS_KNOWN_IN_UNKNOWN = "No subzone/never seen:"
  RT_TOOLTIP_LINE_MOB = " - %s, %s\t%s"

  RT_SEEN_AT = "Seen at:"
  RT_PANEL_TEMPLATE = "%s"
  RT_PANEL_TEMPLATE2 = "%s (%s)"
  RT_TOOLTIP_HINT = "Hint: Left-click to scan your surroundings."

