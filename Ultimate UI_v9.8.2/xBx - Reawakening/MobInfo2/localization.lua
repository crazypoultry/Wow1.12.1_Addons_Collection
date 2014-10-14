-- 
-- Localisation for MobInfo
--
-- created by Stephan Wilms on the 27th of July 2005
-- last update: 07-Aug-2005
--

--
-- Default / English localization
--



miSkinLoot = { };
miSkinLoot["Ruined Leather Scraps"]=1;
miSkinLoot["Light Leather"]=1;
miSkinLoot["Medium Leather"]=1;
miSkinLoot["Heavy Leather"]=1;
miSkinLoot["Thick Leather"]=1;
miSkinLoot["Rugged Leather"]=1;

miSkinLoot["Light Hide"]=1;
miSkinLoot["Medium Hide "]=1;
miSkinLoot["Heavy Hide "]=1;
miSkinLoot["Thick Hide"]=1;
miSkinLoot["Rugged Hide "]=1; 

miSkinLoot["Chimera Leather"]=1;
miSkinLoot["Develsaur Leather"]=1;
miSkinLoot["Frostsaber Leather"]=1;
miSkinLoot["Warbear Leather"]=1;

miClothLoot = { };
miClothLoot["Linen Cloth"]=1;
miClothLoot["Wool Cloth"]=1;
miClothLoot["Silk Cloth"]=1;
miClothLoot["Mageweave Cloth"]=1;
miClothLoot["Felcloth"]=1;
miClothLoot["Runecloth"]=1;

MI_DESCRIPTION = "Adds a wealth of information to the tooltip about a mob";

MI_MOB_DIES_WITH_XP = "(.+) dies, you gain (%d+) experience";
MI_MOB_DIES_WITHOUT_XP = " dies";
MI_PARSE_SPELL_DMG = "(.+)'s (.+) hits you for (%d+)";
MI_PARSE_COMBAT_DMG = "(.+) hits you for (%d+)";

MI_TXT_GOLD   = " Gold";
MI_TXT_SILVER = " Silver";
MI_TXT_COPPER = " Copper";

MI_TXT_CLASS        = "Class ";
MI_TXT_HEALTH       = "Health ";
MI_TXT_KILLS        = "Kills ";
MI_TXT_DAMAGE       = "Damage ";
MI_TXT_TIMES_LOOTED = "Times Looted ";
MI_TXT_EMPTY_LOOTS  = "Empty Loots ";
MI_TXT_TO_LEVEL     = "# to Level ";
MI_TXT_QUALITY      = "Quality ";
MI_TXT_CLOTH_DROP   = "Cloth drops ";
MI_TXT_COIN_DROP    = "Avg Coin Drop ";
MI_TEXT_ITEM_VALUE  = "Avg Item Value ";
MI_TXT_MOB_VALUE    = "Total Mob Value ";
MI_TXT_COMBINED     = "Combined: ";

MI_TXT_CONFIG_TITLE = "MobInfo-2 Options";

MI2_FRAME_TEXTS = {};
MI2_FRAME_TEXTS["MI2_FrmTooltipOptions"] = "Tooltip Options";
MI2_FRAME_TEXTS["MI2_FrmGeneralOptions"] = "General Options";
MI2_FRAME_TEXTS["MI2_FrmHealthOptions"]  = "Mob Health Options";


--
-- This section defines all buttons in the options dialog
--   text : the text displayed on the button
--   cmnd : the command which is executed when clicking the button
--          cmnd must not be given for the translated texts
--   help : the (short) one line help text for the button
--   info : additional multi line info text for button
--          info is displayed in the help tooltip below the "help" line
--          info is optional and can be omitted if not required
--

MI2_OPTIONS = {};

MI2_OPTIONS["MI2_OptShowClass"] = 
  { text = "Show Class"; cmnd = "showclass";  help = "Show Mob class info"; }
  
MI2_OPTIONS["MI2_OptShowHealth"] = 
  { text = "Show Health"; cmnd = "showhealth";  help = "Show Mob health info (current/max)"; }
  
MI2_OPTIONS["MI2_OptShowDamage"] = 
  { text = "Show Damage Range"; cmnd = "showdamage";  help = "Show Mob damage range (Min/Max)"; 
    info = "Damage range is calculated and stored\nseparately per char." }
    
MI2_OPTIONS["MI2_OptShowCombined"] = 
  { text = "Show Combined Info"; cmnd = "showcombined";  help = "Show combined mode message in tooltip";
    info = "Show a mesage in the tooltip indicating that combined mode\nis active and listing all mob levels that have been combined\ninto one tooltip." }
  
MI2_OPTIONS["MI2_OptShowKills"] = 
  { text = "Show Kills"; cmnd = "showkills";  help = "Show number of times you killed the Mob";
    info = "The kill count is calculated and stored\nseparately per char." }
  
MI2_OPTIONS["MI2_OptShowLoots"] = 
  { text = "Show Total Looted"; cmnd = "showloots";  help = "Show number of times a Mob has been looted"; }
  
MI2_OPTIONS["MI2_OptShowEmpty"] = 
  { text = "Show Empty Loots"; cmnd = "showempty";  help = "Show number of empty corpses found (num/percent)";
    info = "This counter gets incremented when you open\n a corpse that has no loot." }
  
MI2_OPTIONS["MI2_OptShowXp"] = 
  { text = "Show XP"; cmnd = "showxp";  help = "Show number of experience points this Mob gives";
    info = "This is the actual last XP value that the Mob \ngave you. \n(not shown for Mobs that are grey to you)" }
  
MI2_OPTIONS["MI2_OptShowNo2lev"] = 
  { text = "Show Number to Level"; cmnd = "showno2lev";  help = "Show number of kills needed to level";
    info = "This tells you how often you must kill the \nsame Mob you just killed to reacht he next level\n(not shown for Mobs that are grey to you)" }
      
MI2_OPTIONS["MI2_OptShowQuality"] = 
  { text = "Show Loot Quality"; cmnd = "showquality";  help = "Show loot quality counters and percentage";
    info = "This counts how many items out of the 5 rarity categories\nthe Mob has given as loot. Categories with 0 drops dont\nget shown. The percentage is the persent chance to get\nan item of the specific rarety from the monster as loot." }
  
MI2_OPTIONS["MI2_OptShowCloth"] = 
  { text = "Show Cloth Pickups"; cmnd = "showcloth";  help = "Show how often the Mob has given cloth loot"; }
  
MI2_OPTIONS["MI2_OptShowCoin"] = 
  { text = "Show Avg. Coin Drop"; cmnd = "showcoin";  help = "Show average coin drop per Mob";
    info = "The total coin value is accumulated and divided\nby the looted counter.\n(does not get shown if coin count is 0)" }
  
MI2_OPTIONS["MI2_OptShowIV"] = 
  { text = "Show Avg. Item Value"; cmnd = "showiv";  help = "Show average item value per Mob";
    info = "The total item value is accumulated and divided\nby the looted counter.\n(does not get shown if item value is 0)" }
  
MI2_OPTIONS["MI2_OptShowTotal"] = 
  { text = "Show Total Mob Value"; cmnd = "showtotal";  help = "Show total average Mob value";
    info = "This is the sum of average coin drop and \naverage item value." }
  
MI2_OPTIONS["MI2_OptShowBlankLines"] = 
  { text = "Show Blank Lines"; cmnd = "showblanklines";  help = "Show Blank lines in ToolTip";
    info = "Blank lines are meant to improve readability by\ncreating sections in the tooltip" }
  
MI2_OPTIONS["MI2_OptSaveAllValues"] = 
  { text = "Save All Values"; cmnd = "saveallvalues";  help = "Always save all Mob data in database";
    info = "Always saving all Mob data allows you to change\nYour display option at any time and have the other\ndata available for showing. If not selected only\nthe data you choose to display will get stored in\nthe database. " }
  
MI2_OPTIONS["MI2_OptCombinedMode"] = 
  { text = "Combine Same Mobs"; cmnd = "combinedmode";  help = "Combine data for Mob with same name";
    info = "Combined mode will accumulate the data for Mobs with\nthe same name but different level. When enabled a\nindicator gets displayed in the tooltip" }
  
MI2_OPTIONS["MI2_OptKeypressMode"] = 
  { text = "Press ALT Key for Mob Info"; cmnd = "keypressmode";  help = "Only Show MobInfo in tooltip when ALT key is pressed"; }
  
MI2_OPTIONS["MI2_OptClearOnExit"] = 
  { text = "Clear all data on logout"; cmnd = "clearonexit";  help = "Clear entire MobInfo database each time you logout"; }

MI2_OPTIONS["MI2_OptDisableHealth"] = 
  { text = "Disable Mob Health"; cmnd = "disablehealth";  help = "Disable all integrated Mob health functionality";
    info = "The MobHelath functionality built into MobInfo can be\n disabled entirely. This is necessary to run an external\nMobHealth AddOn"; }
  
MI2_OPTIONS["MI2_OptStableMax"] = 
  { text = "Show Stable Health Max"; cmnd = "stablemax";  help = "Show a stable health maximum in target frame";
    info = "When enabled the health maximum displayed in the \nMob target frame is not changed during a fight\nThe updated value is show when the next fight begins."; }
  
MI2_OPTIONS["MI2_OptShowPercent"] = 
  { text = "Show percent for health and mana"; cmnd = "showpercent";  help = "Add percentage to health/mana in target frame"; }
  
MI2_OPTIONS["MI2_OptHealthPosX"] = 
  { text = "Horizontal Position"; cmnd = "healthposx";  help = "Adjust horizontal position of health/mana in target frame"; }

MI2_OPTIONS["MI2_OptHealthPosY"] = 
  { text = "Vertical Position"; cmnd = "healthposy";  help = "Adjust vertical position of health/mana in target frame"; }

MI2_OPTIONS["MI2_OptManaDistance"] = 
  { text = "Mana Distance"; cmnd = "manadistance";  help = "Adjust distance of health/mana in target frame"; }

MI2_OPTIONS["MI2_OptAllOn"] = 
  { text = "All ON"; cmnd = "allon";  help = "Switch all MobInfo show options to ON"; }
  
MI2_OPTIONS["MI2_OptAllOff"] = 
  { text = "All OFF"; cmnd = "alloff";  help = "Switch all MobInfo show options to OFF"; }
  
MI2_OPTIONS["MI2_OptMinimal"] = 
  { text = "Minimal"; cmnd = "minimal";  help = "Show a minimum of useful Mob info"; }
  
MI2_OPTIONS["MI2_OptDefault"] = 
  { text = "Default"; cmnd = "default";  help = "Show a default set of useful Mob info"; }
  
MI2_OPTIONS["MI2_OptBtnDone"] = 
  { text = "Done"; cmnd = "";  help = "Close MobInfo options dialog"; }

