
  -- Default English

  RT_Database = TNE_RareTracker_Default_Database
  
  RT_CREATURETYPE_BEAST = "Beast"
  RT_DISCOVERED = "Rare spawn %s discovered!"
  RT_DETECTED = "Rare spawn %s detected!"
  RT_ADDED_TO_DB = "Added %s to database."

  RT_SCAN_FAILED = "No rare mobs were found."
 
  -- probably won't have to localize these:
  RT_MOB = "%s, %s" -- "Name, stats"
  RT_MOB_STATS = "lvl %d %s%s"  -- becomes "lvl X Elite CreatureType"
  RT_COORDS = "%d,%d"

  BINDING_HEADER_RARETRACKER = "RareTracker bindings";
  BINDING_NAME_SCAN = "Scan for nearby rares";


if (GetLocale() == "deDE") then 

  -- German localization
  RT_Database = TNE_RareTracker_Default_Database_deDE

elseif (GetLocale() == "frFR") then 

  -- French localization
  RT_Database = TNE_RareTracker_Default_Database_frFR

end
