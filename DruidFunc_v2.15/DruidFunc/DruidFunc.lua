-- -------------------------------------------------------------------------------------
--
-- DruidFunc
--     Version 2.15
--
-- -------------------------------------------------------------------------------------
--
-- Original Source by Gabraelle
-- http://ruined-by-experience.com/nocturnum/DruidFunc.html  (Defunct link)
--
-- Incorporated some functionality by Adora (Detect max spell rank)
-- http://www.gerdofal.net/wow/druid_mod.html
--
-- This update by Patrick Hunlock  AkA Amid (Dark Iron-horde) (Version 2.0 forward)
-- http://www.hunlock.com/df.php
--
-- Additional code contributions and suggestions by:
--    Bitbyte of Icecrown, Joave (Alliance/Shadowsong EU), Threbrilith, Kagar of Azgalor and Salex.
--
-- Copyright: None.   Modify, change, distribute as you see fit.  But please retain the author/credit information.
--
-- -------------------------------------------------------------------------------------
--
-- Roadmap (Todo):
--                  - Merge healrange into this mod, remove hanging spell targeting, always show in/out of range for ctraid
--                  - Decursive?  really?  really really?  Maybe.  Not being supported by the author anymore, maybe this would be a good addition.
--                  - Raid & Dungeon edition
--                  -     Rejuv raid members who have damage but no hot
--                  -     Heal lowest health raid member
--                  -   Healing touch out of party/raid cast should scale better with target level

-- Version History:
--   9/02/06- v2.15 -                   
--                  - Moonfire now looks for moonfire dots on the target and if found will cast the next lower rank of moonfire instead.
--                  -   Props to bitbyte of icecrown for this new trick.
--                  -   This allows the higher level moonfire damage over time to keep ticking while you spam for direct damage.
--                  -   This effectively raises your dps noticably and lowers your mana usage also noticably.
--                  -   NOTE--If your target is a rogue your maxrank moonfire will ALWAYS be cast (so he can't vanish!)
--                  -   Moonkin rejoyce!
--                  - Moonfire now passes the target name through the totemrank function so it should be a bit more reliable
--                  -    It also hits max-rank if you're on a special totem (like jindo or naxx)
--                  -    But rank 2 if you have a totem targeted
--                  - Added macro/keybind markRogues.   This is like a totemstomper, but it stomps rogues instead.
--                  -    Looks through your available targets for rogues
--                  -    Casts faerie fire on the first rogue it finds without faerie fire already applied.
--                  -    If all rogues have faerie fire on them it casts moonfire on the last rogue it found.
--                  - If you're low on mana, healing touch will drop up to 4 spell ranks to try and get a heal off.
--                  -    The number of spell ranks that can be shed will most likely be user defined in a future patch.
--                  - ManaMe now calls Innervate in a way which doesn't whisper yourself that you're being innervated.
--                  - Added function/keybind weakestLink( healerOnly )
--                  -    seeks out the nearby target with the least amount of health.
--                  -    If you pass true to weakestLink it will look for the healer with lowest health
--                  -       If no healer was found it will target the enemy with the lowest health
--                  -    While functional, it is not recommended you bind these to your tab key.
--                  - Added /druid port or /druid moonglade  -- both will port you to moonglade.  (Tired of it taking up a toolbar slot)
--                  - Added /druid home -- will use your hearthstone (tired of trying to find it in my bag)
--                  - Rejuvenation will no longer give a warning if the target's health is below 1/2 (it will allow immediate swiftmend)
--                  - ManaMe and Innervervate are a bit more reliable in equipping your inenrvate set weapons now.
--                  - Added /druid manaswap [0-100]
--                  -   Lets you specify the threshold low mana weapon swaps happen.
--                  -   The default is 85%, valid values are 0% (off) - 100% (wierd)
--                  - Most all messages sent to the chat window will now be preceeded by "DruidFunc:" so as not to be confused with real wow messages.
--                  - If healing touch is being chatty, it will now show you the maximum health of your target.
--                  - The Prowl macro/keybind will no longer unstealth you if you are already stealthed.
--                  - A localization file has been added to the files in this directory
--                  -   Localization.lua
--                  -   This will allow the eventual translation of druidfunc for use in international clients.
--                  -   It also means this version is going to be buggy as all getout.  sorry.
--                  - Added new function: checkBuffByName( Unit, Buffname ) returns true if Buffname is found
--                  -   This is a technical, back-end toolbox function used to make complex macros, most end users can ignore this addition.
--                  -   This is more reliable than isUnitBuffUp.
--                  -   This works with the buff name rather than the icon filename.
--                  -   Unit = standard "player" or "target"
--                  -   buffname = name of the buff (as it appears in the tooltip, "mark of the wild" for instance.)
--                  - Thanks to the above function, innervate is more reliable (can't confuse innervate with some other buffs)
--                  - Re-implemented warsong gulch flag checking in Prowl() 
--                  -   since we can now differentiate between the wsg flag and plagueland tower buffs with checkBuffByName()
--   9/01/06- v2.14b- Fixed a problem with international versions of the WoW Client (Thanks for all the help Chris!)
--   8/27/06- v2.14a- Fixed moonbar so it can now be disabled. (was not letting user set moonbar to zero)
--                  - Removed WSG flag checking since plagueland uses same icon
--                  - Desperate heal will now cast regrow if player's health is above the threshold set in /druid prayer 
--                  - Tightened up innervate's target checking to reduce the possibility that innervate will be cast on a mana-less target.
--   8/04/06- v2.14 - The Prowl macro will now try to shadowmeld you if you're in humanoid form.
--                  - Innervate now sends a wisper to your target letting them know they recieved the buff.
--                  -    "You've been Innervated!  Cast normally for best results" (because, you know, a lot of priests just stop casting...)
--                  -    The macro Innervate(partychat, targetlastenemy) has been changed to (partychat, noWhisper)
--                  -    If you pass true as noWhisper, innervate won't whisper your target.
--                  -    Thanks to the new targeting code, targetlastenemy isn't needed any longer.
--                  - Added /druid ichat "what you want to whisper to your innervate target"
--                  -    Allows you to customize what you send to your innervate targets
--                  - Innervate now does cooldown checks and will abort before doing weaponswaps, whispers if it's uncastable.
--                  - Rejuvenation now works better if you're one of those druids that just mindlessly spams the rejuv key hoping for a swiftmend (like me)
--                  - Fixed a binding description, thanks Ragnorok
--                  - Fixed names of Jindo's totems so totem stomper should work now (Thanks BitByte!)
--                  - Lightning Totem added to totem list, set to max-rank moonfire (Naxx totem) 
--                  - Added Frost, Shadow, Arcane, Temp, and Heal as set names to the outfitter.
--                  - Added Frost, Shadow, Arcane, Temp, and Heal sets to keybinds.
--                  - Desperate Prayer should allow healing touch and regrow to continue casting if you're spamming the key ( Thanks BitByte! ) 
--                  - Added /druid smartcast [on/off]
--                  -   Smartcast is extreemly useful if you use target of target displays on your interface.  When enabled...
--                  -   If your target is hostile:
--                  -      Any attack spells will be cast on your target.
--                  -      Any healing spells will be cast on your target's target (who the enemy was attacking)
--                  -   If your target is friendly
--                  -      Any healing spells will be cast on your target.
--                  -      Any damage spells will be cast on your target's target.
--                  -   Smartcast defaults to off, you must specifically enable it before you can use this feature.
--                  -   Smartcasting overrides /druid assist, always.
--                  -   Smartcasting won't work if healrange is installed and you are in a raid.
--                  - Most all /d commands have been removed and consolodated under /druid.  This is a major change
--                  -    however this allows for a better help system and reduces the system resources this mod needs to function.
--                  -    /doutfit remains the same, you can also use the new /do shortcut  /do bear for example
--                  -    /dtrinkets [on/off] has been removed and changed to
--                  -      /druid trinkets [on/off]
--                  -    /dprayer [25-100] has been removed and changed to...
--                  -      /druid prayer [25-100]
--                  -    /dhardshift [on/off] has been removed and changed to...
--                  -      /druid hardshift [on/off]
--                  -    /dtarget [on/off] has been removed and changed to
--                  -      /druid target [on/off]
--                  -    /dmanac has been removed and changed to
--                  -       /druid manac [off/silent/announce/10-100]
--                  -    /dplusheal has been removed and changed to
--                  -       /druid plusheal [off/auto/#]
--                  - Added /druid stats
--                  -   Shows you stats about your character (+heal,mana5/spirit regen/est innervate mana)
--                  - Added shortcuts... /df for /druid, and /do for /doutfit  (you can use /df for /druid and /do instead of /doutfit if you want)
--                  - Added /druid moonbar [0-6]
--                  -   This will let you specify which toolbar will be switched to when you go moonkin (the default is 5)
--                  -   When you shift from moonkin to humanoid form your toolbar will go back to toolbar #1
--                  -   If you set moonbar to 0 it will disable all toolbar swaps when switching both in and out of moonkin form
--                  - Fixed a text display bug when setting your base set to mount
--                  - Hopefully fixed a bug finding the next spell rank when you learn a new spell.
--                  - Fixed a bug when passing False to desperateprayer macro (should now properly self-cast.) (Thanks Bitbyte of Icecrown!)
--                  - Changed some display messages to give the name of the player instead of saying DF_TARGET  (Thanks BitByte of Icecrown!)
--                  - Salex sent in a major new feature of druid func.
--                  -    Macro Command Added: Druid.QuickShift("potion string", "Buff name")
--                  -       This macro will shift you out of feral form, drink the potion if you have it in your inventory, then shift you back to your original form.
--                  -    Macro Command Added: Druid.PatchWerk()
--                  -       This macro is specifically for the patchwerk encounter, shifting to drink a greater stoneshield potion
--                  -    Macro Command Added: Druid.BearBark()
--                  -       This macro shifts you to human, casts barkskin then shifts back.
--                  - If druidfunc has never run before, forced initialization of important saved variables in onload to prevent an error
--                  - Big Fuzzy Bear sent some code to tighten up /dtarget 
--                  - Bitbyte of Icecrown sent several tweaks to enhance the efficiency and readability of the code
--                  - Desperate Prayer now looks for the nature's swiftness buff already on you and will cast healing touch if found
--                  -    For those times when WoW will cast nature's swiftness but not healing touch in one cast.
--                  -    Desperate Prayer now will cast healing touch if the ZG class trinket was found and used, and regrowth otherwise.
--                  - Druid.testTrinket will now return true if the trinket was successfully used, and false if it wasn't
--                  - 
-- -------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------   
--These variables are registered for save by character in the .TOC file
-----------------------------------------------------------------------------------   

DFUNCPlusHeal   = 0;                                                                      -- The value of +heal from items
DFUNCHardShift  = DF_OFF                                                                  -- Hardshifting functionality
DFUNCManaC      = DF_OFF                                                                  -- Either "off" or a number which is the abort percentage
DFUNCSwap       = true;                                                                   -- True if weapon/outfit swaps are enabled.
DFUNCSwiftTarget= true;                                                                   -- Changes the function of swiftshift keypresses
DFUNCSilent     = false;                                                                  -- True keeps mana conserve messages out of chat.
DFUNCWeapon     = false;                                                                  -- True if only swap weapons/false to swap everything
DFUNCTrinkets   = false;                                                                  -- True if built in auto-trinket rules should be activated
DFUNCPrayer     = 50                                                                      -- Defaults to 50% the threashold a desperate prayer will attempt NS/Swiftmend heals.
DFUNCMoonbar    = 5;                                                                      -- Action bar to shift to when user goes moonkin
DFUNCSmartCast  = false;                                                                  -- Set to true if smartcast is enabled.
DFUNCIChat      = DF_ICHAT                                                                -- Default starting message for the innerate whisper
DFUNCManaSwap   = 85                                                                      -- Percent at which low mana swaps change weapons.

DFUNCHumanSet = {}                                                                        -- An array which holds all of the inventory items for the humanoid set
DFUNCCatSet   = {}                                                                        -- An array which holds all of the inventory items for the cat form set
DFUNCBearSet  = {}                                                                        -- An array which holds all of the inventory items for the bear form set
DFUNCMoonSet  = {}                                                                        -- An array which holds all of the inventory items for the moonkin form set (heh)
DFUNCTravelSet= {}                                                                        -- An array which holds all of the inventory items for the travel form set.
DFUNCAquaSet  = {}                                                                        -- An array which holds all of the inventory items for the aquatic form set
DFUNCManaSet  = {}                                                                        -- An array which holds all of the inventory items for the low mana set.
DFUNCISet     = {}                                                                        -- An array which holds all of the inventory items for the innervate set.
DFUNCMountSet = {}                                                                        -- An array which holds all of the inventory items for the player's mount set.


DFUNCFireSet = {}                                                                         -- An array which holds the user's fire resistance set
DFUNCPvPSet = {}                                                                          -- An Array which holds the user's pvp set
DFUNCNatureSet = {}                                                                       -- An Array which holds the user's nature set
DFUNCWSGSet = {}                                                                          -- An Array which holds the user's Warsong Gulch Set
DFUNCShadowSet = {}                                                                       -- An Array which holds the user's Shadow resist set 
DFUNCFrostSet = {}                                                                        -- An Array which holds the user's Frost resist set
DFUNCArcaneSet = {}                                                                       -- An Array which holds the user's arcane set
DFUNCHealSet = {}                                                                         -- An Array which holds the user's +heal set.
DFUNCSpecial1 = {}                                                                        -- An Array which holds a user defined set 
DFUNCSPecial2 = {}                                                                        -- An Array which holds a user defined set
DFUNCSpecial3 = {}                                                                        -- An array which holds a user defined set
DFUNCTempSet = {}

-----------------------------------------------------------------------------------   
-- Global variables (not saved)
-----------------------------------------------------------------------------------   

DFUNCVersion    = 2.15                                                                    -- Version number and identifier so other mods can test for this function
DFUNCLastForm   = DF_HUMANFORM                                                            -- Last form the player was in.
DFUNCNoScan     = false                                                                   -- True if inventory checks should be disabled
DFUNCIsMounted  = false                                                                   -- True if player is on a mount
DFUNCInnervate  = false                                                                   -- True during Innervates
DFUNCRejuvWarn  = ""                                                                      -- Last player that got a "rejuvenation already active" warning
DFUNCTrinketHeal= 0                                                                       -- Heal modifier from activated trinkets
DFUNCHealRange  = false;                                                                  -- True if the HealRange mod is present
DFUNCBaseSet    = {}                                                                      -- The base humanoid/caster wardrobe set to use.
DFUNCRunOnce    = false                                                                   -- Set to true after we force a maxspellrank check on zone
DFUNCShiftPot   = false;                                                                  -- Set to true if we're cycling forms to drink a pot in quickshift
DFUNCPrayerFlag = false;                                                                  -- Set to true if we're casting a heal spell



-----------------------------------------------------------------------------------   
--Begin Druid Func
-----------------------------------------------------------------------------------   
  
Druid = {                                                                                 -- BEGIN DRUIDFUNC

-- -------------------------------------------------------------------------------------
-- These functions setup initial variables and states.
-- -------------------------------------------------------------------------------------

   SetAllMaxRanks = function()
      -- -------------------------------------------------------------------------------------
      -- Find the maximum ranks for the various spells.
      --    MAXRANKNAME_ = a string "Rank 10"  for instance, this is really not used.
      --    MAXRANK_     = a number indicating the rank of the spell.  10 for instnace.  
      --                   This is used extensively to determine the spells' maximum rank.
      --    BOOKINDEX_   = a number indicating the position of the ability in the user's 
      --                   spellbook.  This is used mostly to determine if an ability exists.
      --    SLOTINDEX_   = the location of the ability on the user's toolbar.  
      --                   This is used to determine if an ability can be used by some functions.
      --                   Mostly by the assist handler 
      -- --------------------------------------------------------------------------------------
      MAXRANKNAME_HealingTouch,  MAXRANK_HealingTouch,  BOOKINDEX_HealingTouch,  SLOTINDEX_HealingTouch   = Druid.maxRank(DF_HEALINGTOUCH);
      MAXRANKNAME_Rejuv,         MAXRANK_Rejuv,         BOOKINDEX_Rejuv,         SLOTINDEX_Rejuv          = Druid.maxRank(DF_REJUVENATION);
      MAXRANKNAME_Regrow,        MAXRANK_Regrow,        BOOKINDEX_Regrow,        SLOTINDEX_Regrow         = Druid.maxRank(DF_REGROWTH);
      MAXRANKNAME_Thorns,        MAXRANK_Thorns,        BOOKINDEX_Thorns,        SLOTINDEX_Thorns         = Druid.maxRank(DF_THORNS);
      MAXRANKNAME_MoTW,          MAXRANK_MoTW,          BOOKINDEX_MoTW,          SLOTINDEX_MoTW           = Druid.maxRank(DF_MOTW);
      MAXRANKNAME_Moonfire,      MAXRANK_Moonfire,      BOOKINDEX_Moonfire,      SLOTINDEX_Moonfire       = Druid.maxRank(DF_MOONFIRE);
      MAXRANKNAME_Starfire,      MAXRANK_Starfire,      BOOKINDEX_Starfire,      SLOTINDEX_Starfire       = Druid.maxRank(DF_STARFIRE);
      MAXRANKNAME_Wrath,         MAXRANK_Wrath,         BOOKINDEX_Wrath,         SLOTINDEX_Wrath          = Druid.maxRank(DF_WRATH);
      MAXRANKNAME_InsectSwarm,   MAXRANK_InsectSwarm,   BOOKINDEX_InsectSwarm,   SLOTINDEX_InsectSwarm    = Druid.maxRank(DF_INSECTSWARM);
      MAXRANKNAME_FF,            MAXRANK_FF,            BOOKINDEX_FF,            SLOTINDEX_FF             = Druid.maxRank(DF_FAERIEFIRE);
      MAXRANKNAME_FFF,           MAXRANK_FFF,           BOOKINDEX_FFF,           SLOTINDEX_FFF            = Druid.maxRank(DF_FAERIEFIREFERAL);
      MAXRANKNAME_Hibernate,     MAXRANK_Hibernate,     BOOKINDEX_Hibernate,     SLOTINDEX_Hibernate      = Druid.maxRank(DF_HIBERNATE);
      MAXRANKNAME_Rebirth,       MAXRANK_Rebirth,       BOOKINDEX_Rebirth,       SLOTINDEX_Rebirth        = Druid.maxRank(DF_REBIRTH);
      MAXRANKNAME_NaturesGrasp,  MAXRANK_NaturesGrasp,  BOOKINDEX_NaturesGrasp,  SLOTINDEX_NaturesGrasp   = Druid.maxRank(DF_NATURESGRASP);
      MAXRANKNAME_Hurricane,     MAXRANK_Hurricane,     BOOKINDEX_Hurricane,     SLOTINDEX_Hurricane      = Druid.maxRank(DF_HURRICANE);
      MAXRANKNAME_Tranquility,   MAXRANK_Tranquility,   BOOKINDEX_Tranquility,   SLOTINDEX_Tranquility    = Druid.maxRank(DF_TRANQUILITY);
      MAXRANKNAME_Roots,         MAXRANK_Roots,         BOOKINDEX_Roots,         SLOTINDEX_Roots          = Druid.maxRank(DF_ROOTS);
      MAXRANKNAME_Ravage,        MAXRANK_Ravage,        BOOKINDEX_Ravage,        SLOTINDEX_Ravage         = Druid.maxRank(DF_RAVAGE);
      MAXRANKNAME_Shred,         MAXRANK_Shred,         BOOKINDEX_Shred,         SLOTINDEX_Shred          = Druid.maxRank(DF_SHRED);
      MAXRANKNAME_Claw,          MAXRANK_Claw,          BOOKINDEX_Claw,          SLOTINDEX_Claw           = Druid.maxRank(DF_CLAW);
      MAXRANKNAME_Prowl,         MAXRANK_Prowl,         BOOKINDEX_Prowl,         SLOTINDEX_Prowl          = Druid.maxRank(DF_PROWL);
      MAXRANKNAME_Rake,          MAXRANK_Rake,          BOOKINDEX_Rake,          SLOTINDEX_Rake           = Druid.maxRank(DF_RAKE);
      MAXRANKNAME_Pounce,        MAXRANK_Pounce,        BOOKINDEX_Pounce,        SLOTINDEX_Pounce         = Druid.maxRank(DF_POUNCE);
      MAXRANKNAME_Cower ,        MAXRANK_Cower,         BOOKINDEX_Cower,         SLOTINDEX_Cower          = Druid.maxRank(DF_COWER);
      MAXRANKNAME_Dash,          MAXRANK_Dash,          BOOKINDEX_Dash,          SLOTINDEX_Dash           = Druid.maxRank(DF_DASH);
      MAXRANKNAME_Rip,           MAXRANK_Rip,           BOOKINDEX_Rip,           SLOTINDEX_Rip            = Druid.maxRank(DF_RIP);
      MAXRANKNAME_FerociousBite, MAXRANK_FerociousBite, BOOKINDEX_FerociousBite, SLOTINDEX_FerociousBite  = Druid.maxRank(DF_FEROCIOUSBITE);
      MAXRANKNAME_FeralCharge,   MAXRANK_FeralCharge,   BOOKINDEX_FeralCharge,   SLOTINDEX_FeralCharge    = Druid.maxRank(DF_FERALCHARGE);
      MAXRANKNAME_TigersFury,    MAXRANK_TigersFury,    BOOKINDEX_TigersFury,    SLOTINDEX_TigersFury     = Druid.maxRank(DF_TIGERSFURY);
      MAXRANKNAME_Maul,          MAXRANK_Maul,          BOOKINDEX_Maul,          SLOTINDEX_Maul           = Druid.maxRank(DF_MAUL);
      MAXRANKNAME_Bash,          MAXRANK_Bash,          BOOKINDEX_Bash,          SLOTINDEX_Bash           = Druid.maxRank(DF_BASH);
      MAXRANKNAME_Swipe,         MAXRANK_Swipe,         BOOKINDEX_Swipe,         SLOTINDEX_Swipe          = Druid.maxRank(DF_SWIPE);
      MAXRANKNAME_FrenziedRegen, MAXRANK_FrenziedRegen, BOOKINDEX_FrenziedRegen, SLOTINDEX_FrenziedRegen  = Druid.maxRank(DF_FRENZIEDREGEN);
      MAXRANKNAME_DemRoar,       MAXRANK_DemRoar,       BOOKINDEX_DemRoar,       SLOTINDEX_DemRoar        = Druid.maxRank(DF_DEMROAR);
      MAXRANKNAME_Swiftmend,     MAXRANK_Swiftmend,     BOOKINDEX_Swiftmend,     SLOTINDEX_Swiftmend      = Druid.maxRank(DF_SWIFTMEND);
      MAXRANKNAME_Attack,        MAXRANK_Attack,        BOOKINDEX_Attack,        SLOTINDEX_Attack         = Druid.maxRank(DF_ATTACK);
      MAXRANKNAME_NS,            MAXRANK_NS,            BOOKINDEX_NS,            SLOTINDEX_NS             = Druid.maxRank(DF_NATURESWIFTNESS);
      MAXRANKNAME_Innervate,     MAXRANK_Innervate,     BOOKINDEX_Innervate,     SLOTINDEX_Innervate      = Druid.maxRank(DF_INNERVATE);
   end;

   -- -------------------------------------------------------------------------------------
   -- This function is called automatically by WoW when the interface first loads as set up in the .xml file.
   -- -------------------------------------------------------------------------------------

   onLoad = function()
   
      -----------------------------------------------------------------------------------   
      --Set up initial variables
      -----------------------------------------------------------------------------------   
      DFUNC_assist      = "off";                                                          -- Initial setting for assisting a target
      assistName        = nil;                                                            -- The name of the person to assist.
      DFUNC_Casting     = false                                                           -- Set to true by the onEvent funciton during spellcast

            
      -----------------------------------------------------------------------------------   
      --Set up an event handler & slash command handler
      --Registered events are processed in DonEvent (set up in the xml file)
      -----------------------------------------------------------------------------------   
      this:RegisterEvent(DF_UI_ERROR_MESSAGE)                                              -- Catch User Interface error messages
      this:RegisterEvent(DF_LEARNED_SPELL_IN_TAB)                                          -- Was the spellbook updated?
      this:RegisterEvent(DF_SPELLCAST_START);                                              -- User starts casting
      this:RegisterEvent(DF_SPELLCAST_STOP);                                               -- User stops casting
      this:RegisterEvent(DF_SPELLCAST_INTERRUPTED);                                        -- !@$# pally stuns
      this:RegisterEvent(DF_SPELLCAST_FAILED);                                             -- !@#$ user running away from his healer
      this:RegisterEvent(DF_PLAYER_REGEN_ENABLED);                                         -- Health started regenning (user out of combat)
      this:RegisterEvent(DF_UNIT_INVENTORY_CHANGED);                                       -- Inventory changed
      this:RegisterEvent(DF_PLAYER_ENTERING_WORLD);                                        -- Player entered world/Zoned into instance
      this:RegisterEvent(DF_PLAYER_AURAS_CHANGED);                                         -- A buff changed (added or expired)
      this:RegisterEvent(DF_PLAYER_UNGHOST);                                               -- Player is no longer a ghost
      this:RegisterEvent(DF_PLAYER_ALIVE);                                                 -- Player alive (after being a ghost)
      this:RegisterEvent(DF_SPELLCAST_CHANNEL_STOP)                                        -- Channeled spell stopped.

      SLASH_DOutfit1 = DF_DOUTFIT1                                                         -- Setup wardrobe changes
      SLASH_DOutfit2 = DF_DOUTFIT2                                                         -- Can also use /DO instead of /DOUTFIT
      SlashCmdList["DOutfit"] = Druid.Outfit;                                              -- /Doutfit and /do call the outfit function.

      SLASH_Druid1 = DF_DRUID1                                                             -- The /druid slash command handler
      SLASH_Druid2 = DF_DRUID2                                                             -- Can also use /DF instead of /Druid
      SlashCmdList["Druid"] = Druid.DCmd;                                                  -- /druid and /df call the DCmd function.
       
     
      -----------------------------------------------------------------------------------   
      -- Since finding spell maxRank is a somewhat consuming process we'll find all the max ranks
      -- when the interface first loads.   Then we're set. If a skill is trained the
      -- max ranks are recalculated thanks to the event handler.
      -----------------------------------------------------------------------------------   

      Druid.SetAllMaxRanks()

      -----------------------------------------------------------------------------------   
      -- Hello World!
      -----------------------------------------------------------------------------------   
      DEFAULT_CHAT_FRAME:AddMessage( DF_WELCOME1..DFUNCVersion..DF_WELCOME2);
   end;

   -- -------------------------------------------------------------------------------------
   -- This function is called BY WoW whenever WoW finds an event we asked for in 
   -- the onload area.  This function is actually registered in the .xml file
   -- -------------------------------------------------------------------------------------

   DonEvent = function (event, reason)
       if (event == DF_UI_ERROR_MESSAGE) then                                              -- User interface caught an error
         if string.find(arg1, DF_CANTWHENSWIM) then                                        -- If error was cannot use while swimming (user tried travel form in water)
            Druid.ChangeShapeshiftForm(DF_AQUAFORM)                                        -- Trip aquatic form instead.
         end                                                                               -- End check for swimming
         if string.find(arg1, DF_ONLYWHENSWIM) then                                        -- If error was "can only use while swimming" (user tried aquatic form on land)
            Druid.ChangeShapeshiftForm(DF_TRAVELFORM)                                      -- Trip travel form instead
         end                                                                               -- End check for not swimming
      end                                                                                  -- End user interface error
      
      if (event == DF_LEARNED_SPELL_IN_TAB) then                                          -- Player learned a new spell, re-check all the max ranks used by this mod.
         Druid.SetAllMaxRanks()                                                           -- Call the calculate all maxranks function
      end;                                                                                -- End spells changed.
      
      if (event == DF_SPELLCAST_START) then                                               -- Keeps track of when we start a spell so we don't spam the chat box if user is mashing the keys.
         DFUNC_Casting=true;                                                              -- Toggle the global variable to true.
         if DFUNCSwap and UnitAffectingCombat(DF_PLAYER) then                             -- If weapon swaps are enabled and player is in combat
            if (Druid.GetCurrentForm() == 0) then                                         -- And if player is in humanoid form
               Druid.LowManaSwap(85);                                                     -- Do a low mana swap check
            end                                                                           -- End player form check
         end                                                                              -- End swap/combat check
      end                                                                                 -- End spellcast start
      
      if (event == DF_UNIT_INVENTORY_CHANGED) then                                         -- Something in the user's inventory change
         if not(DFUNCNoScan) then                                                         -- If the inventory scans enabled
            Druid.ScanInventory();                                                        -- Rescan inventory (getting +heal values)
         end 
      end                                                                                 -- End Inventory changed
      
      if (event == DF_SPELLCAST_STOP) then                                                 -- Spellcast ended or was otherwise stopped
         DFUNC_Casting=false;                                                             -- Set the global variable appropriately
         DFUNCPrayerFlag = false;                                                         -- Spellcast ended
      end                                                                                 -- End Spellcast Stop
      
      if (event == DF_SPELLCAST_CHANNEL_STOP) then                                         -- Channeled spell ended (hurricane/tranquility)
         DFUNC_Casting = false                                                            -- Note the end of the spellcast
         DFUNCPrayerFlag = false                                                          -- Note the end of the spellcast
      end                                                                                 -- End channeled spell stop
      
      if (event == DF_SPELLCAST_INTERRUPTED) then                                          -- Spellcast ended (stun/silence or other effect)
         DFUNC_Casting=false;                                                             -- Set the global variable appropriately
         DFUNCPrayerFlag = false;                                                         -- Spellcast ended
      end                                                                                 -- End Spellcast Interrupted
      
      if (event == DF_SPELLCAST_FAILED) then                                               -- Spellcast ended (target out of range/not visible)
         DFUNC_Casting=false;                                                             -- Set the global variable appropriately
         DFUNCPrayerFlag = false;                                                         -- Spellcast ended
      end
      
      if (event == DF_PLAYER_UNGHOST) or (event == DF_PLAYER_ALIVE) then                    -- Player recently rezzed or zoned, adjust his wardrobe
         if (DFUNCSwap) and not(UnitIsDeadOrGhost(DF_PLAYER)) then                         -- If weapon Swaps enabled and Player is not dead
            Druid.LoadWardrobe(DFUNCBaseSet)                                              -- Equip the base set
         end                                                                              -- End swap/dead check
      end                                                                                 -- End UNGHOST/ALIVE check
      
      if (event == DF_PLAYER_ENTERING_WORLD) then                                          -- The game begins or the player has finished zoning.
         
         
         DFUNCIsMounted = false;                                                          -- Player never enters the world on a mount

         if HealRange ~= nil then                                                         -- Is the player using the healrange mod?
            DFUNCHealRange = true;                                                        -- Yes he is.   Alter the way we deal with spell targeting in raids.
            DEFAULT_CHAT_FRAME:AddMessage( DF_HEALRANGE );
         end                                                                              -- End healrange check
         if (DFUNCSwap) then
            DFUNCBaseSet = DFUNCHumanSet
            Druid.LoadWardrobe(DFUNCBaseSet)
            DEFAULT_CHAT_FRAME:AddMessage( DF_BASE_HUMAN);
         end
         DFUNC_Casting = false;                                                           -- Can't zone and cast
         DFUNCPrayerFlag = false;                                                         -- Spellcast ended
         
         if not(DFUNCRunOnce) then                                                        -- This is security blanket code to make sure we've calculated
            Druid.SetAllMaxRanks()                                                        -- All the maximum spell ranks.
            DFUNCRunOnce = true;                                                          -- Because when you FIRST zone into the world it onload doesn't always run this

            if (DFUNCManaC == nil) then                                                   -- Druidfunc has never run, initialize important variables
               DFUNCPlusHeal   = 0;                                                       -- The value of +heal from items
               DFUNCHardShift  = DF_OFF                                                   -- Hardshifting functionality
               DFUNCManaC      = DF_OFF                                                   -- Either "off" or a number which is the abort percentage
               DFUNCSwap       = true;                                                    -- True if weapon/outfit swaps are enabled.
               DFUNCSwiftTarget= true;                                                    -- Changes the function of swiftshift keypresses
               DFUNCSilent     = false;                                                   -- True keeps mana conserve messages out of chat.
               DFUNCWeapon     = false;                                                   -- True if only swap weapons/false to swap everything
               DFUNCTrinkets   = false;                                                   -- True if built in auto-trinket rules should be activated
               DFUNCPrayer     = 50                                                       -- Defaults to 50% the threashold a desperate prayer will attempt NS/Swiftmend heals.
               DFUNCMoonbar    = 5;                                                       -- Action bar to shift to when user goes moonkin
               DFUNCSmartCast  = false;                                                   -- Set to true if smartcast is enabled.
               DFUNCIChat      = DF_ICHAT                                                 -- Default starting message for the innerate whisper
            end
         end                                                                              -- End security blanket. 
         if (DFUNCManaSwap == nil ) then
            DFUNCManaSwap = 85                                                            -- Initialize the default low mana swap percentage
         end
      end                                                                                 -- End PLAYER ENTERING WORLD
      
      if (event == DF_PLAYER_AURAS_CHANGED) then                                           -- A buff was added or removed here we check for healing trinkets and if player mounted/dismounted
         
         DFUNCTrinketHeal = 0                                                             -- Assume no healing trinket modifiers are active to start.
                  
         if Druid.checkBuffByName(DF_PLAYER, DF_UNSTABLE_POWER) then                       -- Check to see if zandalar hero charm buff is up
            DFUNCTrinketHeal = DFUNCTrinketHeal + 400                                     -- Indeed it is.  Assume +400 healing until we check again
         end                                                                              -- End Zandalar Hero Charm buff check
         
         if Druid.checkBuffByName(DF_PLAYER, DF_HIBERNATION) then                         -- Check to see if the hibneration crystal buff is up
            DFUNCTrinketHeal = DFUNCTrinketHeal + 350                                     -- Indeed it is.  Assume +350 healing until we check again
         end                                                                              -- End hibernation crystal check
                  
         if DFUNCIsMounted ~= Druid.UnitMounted() then                                    -- Mount state changed
            DFUNCIsMounted = Druid.UnitMounted()                                          -- Find out if we're mounted now.
            if DFUNCSwap then                                                             -- Are we doing wardrobe changes?
               if DFUNCIsMounted then                                                     -- We're mounted!
                  Druid.LoadWardrobe(DFUNCMountSet)                                       -- Load up the mounted set.
               else                                                                       -- We're not mounted.
                  Druid.LoadWardrobe(DFUNCBaseSet)                                        -- Load up our base set.
               end                                                                        -- End isMounted
            end                                                                           -- End swaps enabled check
         else                                                                             -- Mounted state didn't change so...
            Druid.WeaponShift();                                                          -- Check for shapeshift change.
         end                                                                              -- End mounted state check  
         Druid.ScanInventory()                                                                            
      end                                                                                 -- end PLAYER AURAS CHANGED
      
      if (event == DF_PLAYER_REGEN_ENABLED) then                                          -- REGEN_ENABLED means the user has started regenerating health this only happens when a player leaves comabt.
         
         if DFUNCSwap then                                                                -- Are weapon swaps enabled?
            if (Druid.GetCurrentForm() == 0) and not(Druid.isUnitBuffUp(DF_PLAYER, DF_ABILITY_MOUNT)) then  -- If user is humanoid and player isn't mounted
               Druid.LoadWardrobe(DFUNCBaseSet);                                          -- Load the current base armor set
            end                                                                           -- End form/mount check
         end                                                                              -- End swap enabled check
         DFUNC_Casting = false;                                                           -- If we left combat assume we're not casting spells either (this is a failsafe)
      end                                                                                 -- end REGEN ENABLED check

   end;                                                                                   -- End on event function

-- -------------------------------------------------------------------------------------
-- testTrinket
--
-- This function looks for the specified string (IE "Zandalarian Hero Charm")
-- If the specified trinket is equipped and it's not in cooldown
-- this function will use that trinket.
--
-- Example  Druid.testTrinket("Zandalarian Hero Charm")
-- 
-- It's important that any trinket useage be done BEFORE you attempt to cast a spell.
-- A spell starts the global cooldown, using trinkets does not.  Therefore you can
-- use both trinkets and then cast a spell, but if you cast a spell first this function
-- will fail because the trinkets will be locked in the global cooldown.
--
-- Sample Macro usage
-- /script Druid.testTrinket("Zandalarian Hero Charm")
-- /script Druid.Moonfire()
--
-- This macro would automatically attempt to use any equiped hero charms every time you use moonfire.
--
-- Trinket code for the Zandalarin Hero charm and Mar'li's Eye are included (but commented out) 
-- in this lua.  If you're reading this file you probably have the skills to restore the functionality.
-- -------------------------------------------------------------------------------------


   testTrinket = function(lookfor) 
      local trinket1=GetInventoryItemLink(DF_PLAYER,GetInventorySlotInfo(DF_TRINKET0SLOT))  -- Get trinket1 info 
      local trinket2=GetInventoryItemLink(DF_PLAYER,GetInventorySlotInfo(DF_TRINKET1SLOT))  -- Get trinket2 info
      local usedTrinket = false

      lookfor = string.lower(lookfor);                                                    -- set the lookfor text to lower case

      --Check Trinket Slot 0
      if (trinket1 ~= nil) then                                                           -- If a trinket is in the first slot
         local _, _, itemCode = strfind(trinket1, "(%d+):");                              -- Get the item code for the trinket
         local itemName, _, _, _, _, itemType = GetItemInfo(itemCode);                    -- get the item name for the trinket
         itemName = string.lower(itemName)                                                -- convert name to lower case
         if (itemName == lookfor) then                                                    -- if trinket is what we're looking for then
           if GetInventoryItemCooldown(DF_PLAYER,13)==0 then                               -- check trinket cooldown, if it's not on cooldown
               UseInventoryItem( GetInventorySlotInfo(DF_TRINKET0SLOT) );                 -- USE IT!
               usedTrinket = true;
           end; -- { check cooldown }                                                     -- End Check cooldown
         end; -- { check trinket0 }                                                       -- End check trinket
      end; -- {trinket1 not nil}                                                          -- end trinket not nill

      --Check Trinket Slot 1
      if (trinket2 ~= nil) then                                                           -- If a trinket is in the second slot
         local _, _, itemCode2 = strfind(trinket2, "(%d+):");                             -- Get the item code
         local itemName2, _, _, _, _, itemType2 = GetItemInfo(itemCode2);                 -- Get the name of the trinket
         itemName2 = string.lower(itemName2)                                              -- convert name to lower case
         if (itemName2 == lookfor) then                                                   -- if trinket is what we're looking for then
            if GetInventoryItemCooldown(DF_PLAYER,14)==0 then                              -- check trinket cooldown, if it's not on cooldown
               UseInventoryItem( GetInventorySlotInfo(DF_TRINKET1SLOT) );                 -- USE IT!
               usedTrinket = true;
            end; -- { check cooldown }                                                    -- End check cooldown
         end; -- {Check Trinket1 }                                                        -- End check trinket
      end; -- {trinket2 not nil}                                                          -- End trinket not nil
      return usedTrinket
   end; -- {testTrinket}                                                                  -- End function


-- -------------------------------------------------------------------------------------
-- This function is called whenver the player starts or changes equipment.
-- It scans all the items the player is wearing and calcuates the +heal value
-- -------------------------------------------------------------------------------------

   FindPattern = function (text, pattern, start)                                          -- This is a tiny function to return a patern found in a string
      return string.sub(text, string.find(text, pattern, start))
   end;

   ScanInventory = function()                                                             -- Function ScanInventory (the drama begins)

      if DFUNCNoScan then                                                                 -- If the global constant DFUNCNoScan is true
         return                                                                           -- Don't scan anything and return (user is doing a full wardrobe slot)
      end
      DFUNCMana5Offset = 0;                                                               -- Mana 5 offset from potions
      DFUNC_HealOffset = 0;                                                               -- Initialize the base heal offset to zero
      ManaSet = false;                                                                    -- Set to true once we scan the first piece with a set bonus (mana over 5)
      HealSet = false;                                                                    -- Set to true once we scan the first piece with a set bonus (+heal)
      DMana5  = 0;                                                                        -- Initialize Base mana over five to zero
      
      DFunc_Tooltip:SetOwner(UIParent, DF_ANCHOR_NONE);                                    -- Initialize the tooltip
      
      for x, slotName in DFUNC_Slots do                                                   -- For each item in the DFUNC_Slots array (see global variables top of file)
         slotid, _ = GetInventorySlotInfo(slotName.. DF_SLOT);                            -- Get slot info for current slot
         DFunc_Tooltip:ClearLines()
         foundItem = DFunc_Tooltip:SetInventoryItem(DF_PLAYER, slotid);                   -- Set the tooltip to the current slot item
         if ( foundItem ) then                                                            -- If we have a tooltip then scan it line by line
            local numLines = DFunc_Tooltip:NumLines();                                    -- Get number of lines in the tooltip
            for i=1, numLines, 1 do                                                       -- for each line
               tmp = getglobal(DF_DFunc_TooltipTextLeft..i);                               -- Get the text of the line
               tmpLine = tmp:GetText();                                                   -- Get the text of the line
               tmpLine = string.lower(tmpLine);                                           -- convert it to lower case

               if tmpLine then                                                            -- If line isn't nil
                  if string.find(tmpLine,DF_IOR) or string.find(tmpLine, DF_HC) or string.find(tmpLine, DF_ZHC) then
                     break                                                                -- Ignore the item if it's a "situational" or user activated item
                  end
                  if string.find(tmpLine,DF_SET) then                                    -- If we see the string ") set" it means user doesn't have enough pieces for this set bonus
                     break                                                                -- so break out of this item, we don't need to see any more
                  end

                  if string.find(tmpLine,DF_BMO) then                                     -- Brilliant mana oil check
                     DMana5 = DMana5 + 12
                     DFUNC_HealOffset = DFUNC_HealOffset + 25
                  end
                  
                  if string.find(tmpLine,DF_MP5_1) then                                   -- If line is mana per 5 bonus then 
                     aString = Druid.FindPattern(tmpLine, "%d+");                         -- get the number
                     if string.find(tmpLine,DF_SET2) then                                  -- If we're dealing with a set then
                        if not ManaSet then                                               -- if it's the first encounter
                           ManaSet = true;                                                -- fix it so we ignore subsequent encounters
                        else                                                              -- if it's not the first encounter
                           aString = 0                                                    -- set the number to zero
                        end
                     end
                     DMana5 = DMana5 + aString;                                           -- Increase mana over 5
                  end
                  
                  if string.find(tmpLine,DF_MP5_2) then                                   -- if line is mana regen (same as mana per 5)
                     aString = Druid.FindPattern(tmpLine, "%d+");                         -- get the value
                     if string.find(tmpLine,DF_SET2) then                                 -- if we're dealing with a set bonus
                        if not ManaSet then                                               -- Is this the first encounter?
                           ManaSet = true;                                                -- Yes, flag it so we don't count it again
                        else                                                              -- Not first encounter?
                           aString = 0                                                    -- set value to zero then
                        end
                     end
                     DMana5 = DMana5 + aString;                                           -- Increase mana over 5 found
                  end                   

                  if string.find(tmpLine,DF_HDB)  then                                    -- If line is healing done (+heal)
                     if not(string.find(tmpLine,DF_CREJUV)) then                          -- If line isn't idol of rejuvenation
                        aString = Druid.FindPattern( tmpLine, DF_UPTO)                    -- Snag the value
                        aString = string.sub(aString,7,100);                              -- trim the value
                        if string.find(tmpLine,DF_SET2) then                              -- If we're dealing with a set bonus
                           if not HealSet then                                            -- Is this the first encounter?
                              HealSet = true;                                             -- Yes, flag it so we don't count it again
                           else                                                           -- Not first encounter?
                              aString = 0                                                 -- Set value to zero
                           end
                        end
                        DFUNC_HealOffset = DFUNC_HealOffset + aString;                    -- Increase +heal 
                     end
                  end

                  if string.find(tmpLine,DF_HEAL_1)  then                                 -- If line is healing done (+heal)
                     if not(string.find(tmpLine,"rejuvenation")) then                     -- If line isn't idol of rejuvenation
                        aString = Druid.FindPattern( tmpLine, DF_HEAL_3)                   -- Snag the value
                        aString = Druid.FindPattern( aString, "%d+")                      -- Trim the value
                        if string.find(tmpLine,DF_SET2) then                              -- Are we dealing with a set bonus?
                           if not HealSet then                                            -- Is this the first encounter?
                              HealSet = true;                                             -- Yes, flag it so we don't count it again
                           else                                                           -- Not first encounter?
                              aString = 0                                                 -- Then set it to zero
                           end
                        end
                        DFUNC_HealOffset = DFUNC_HealOffset + aString;                    -- Increase +heal value
                     end
                  end

                  if string.find(tmpLine,DF_HEAL_2)  then                                 -- Another variation on +healing 
                     if not(string.find(tmpLine,"rejuvenation")) then                     -- If we're not dealing with rejuvenation
                        aString = Druid.FindPattern( tmpLine, DF_HEAL_2)                  -- Snag the value
                        aString = Druid.FindPattern( aString, "%d+")                      -- Trim the value
                        if string.find(tmpLine,DF_SET2) then                               -- Are we dealing with a set bonus?
                           if not HealSet then                                            -- Is this the first encoutner?
                              HealSet = true;                                             -- Yes? then flag it so we don't count it again
                           else                                                           -- Not first encounter?
                              aString = 0                                                 -- Then set value to zero
                           end
                        end
                        DFUNC_HealOffset = DFUNC_HealOffset + aString;                    -- Increase +heal value
                     end
                  end
                                     
               end                                                                        -- End if line isn't nil
            end                                                                           -- End for each line in tooltip
         end                                                                              -- end found item in equipment slot
      end                                                                                 -- end for each equipment slot
      DFunc_Tooltip:Hide()                                                                -- Dispose of the tooltip
   end;                                                                                   -- end function ScanInventory
   

-- -------------------------------------------------------------------------------------
-- MaxRank -- Attempt to discover the maximum rank of a spell
-- Credit to Adora -- http://www.gerdofal.net/wow/druid_mod.html
-- -------------------------------------------------------------------------------------

   maxRank = function(spell)
      local i = 1;                                                                        -- Initialize counter
      local maxrank = "rank 0";                                                           -- initialize max rank (text)
      local found = false;                                                                -- Initialize spell found
      bookindex = -1                                                                      -- Initialize spellbook position
      maxranknum = 0                                                                      -- initialize max rank (number)
      actionslot = -1                                                                     -- Location on the toolbar of this ability (if any)
      
      while true do                                                                       -- Endless loop
         local spellName, spellRank = GetSpellName(i,BOOKTYPE_SPELL)                      -- Get spellname and rank from spellbook
         if not spellName then                                                            -- If we didn't find a spell (at end of spellbook)
            do break end                                                                  -- break out of the endless loop
         end                                                                              -- guess it really isn't an endless loop eh?

         if (spellName == spell) then                                                     -- if the spellname we found matches the spell we passed
            maxrank = spellRank;                                                          -- Note the rank of the spell
            bookindex = i                                                                 -- Note the index where spell was found in spellbook
            found = true;                                                                 -- Note that we actually found the spell
         end
         i=i+1;                                                                           -- Increase the counter
      end

      if not found then                                                                   -- We didn't find anything
         return maxrank, -1, -1, -1;                                                      -- So return -1 as ranks
      end
      
      actionslot = Druid.FindActionButton(spell)                                          -- Find the action slot
      
      local a=string.find(maxrank," ");                                                   -- Convert (rank #) to an actual number.  Find the space
      local b=string.len(maxrank);                                                        -- Now find the length of the string
      if (b == nil) or (a == nil) then                                                    -- if there's no rank to spell
         maxranknum = 0                                                                   -- set maxranknum to zero (we found the spell but it has no rank, like swiftmend or nature's swiftness)
      else                                                                                -- maxrank has a length
         maxranknum = tonumber(string.sub(maxrank,a,b));                                  -- so capture everything after the space and convert it to a real number
      end                                                                                 -- and now we have maxrank as a usable number

      return maxrank,maxranknum, bookindex, actionslot;                                   -- return maxrank (rank x), maxranknum (x), and bookindex (where it was found in spellbook)
   end;                                                                                   -- End function maxrank   
   
-- -------------------------------------------------------------------------------------
-- Find skill on action bar
-- -------------------------------------------------------------------------------------

   FindActionButton = function ( spell )
      -- This procedure tries to find out where that spell is on the action bar
      -- once we locate the spell on the action bar we get all kinds
      -- of very nifty range and usability information about that spell.
      -- if the user doesn't have the spell on his toolbars then we return zero :(
      -- This procedure is heavilly modified from decursive so all credit and props where it is due.

      DFunc_Tooltip:SetOwner(UIParent, DF_ANCHOR_NONE);                                   -- Initialize the tooltip
      local i = 0;                                                                        -- initialize the counter 
      for i = 1, 120 do                                                                   -- count for way more than you actually have action slots in the toolbar
         if (HasAction(i)) then                                                           -- if the action slot actually does something
            if (GetActionText(i) == nil) then                                             -- get the text
               DFunc_Tooltip:ClearLines();                                                -- Clear old tooltips
               DFunc_Tooltip:SetAction(i);                                                -- Set tooltip to the current action slot
               local slotName = DFunc_TooltipTextLeft1:GetText();                         -- get its text
               if (spell == slotName) then                                                -- if current action slot = what was passed (found what we're looking for)
                  return i;                                                               -- return the slot where it was found
               end                                                                        -- End action slot = what was passed
            end                                                                           -- End check if action slot has text
         end                                                                              -- End check if action slot has item in it
      end                                                                                 -- End for loop
      DFunc_Tooltip:Hide()                                                                -- Dispose of the tooltip.
      return 0;                                                                           -- We found NOTHING, NOTHING!  so return zero.
   end;                                                                                   -- End function FindActionButton

-- -------------------------------------------------------------------------------------
-- This area holds some basic, internal tools and utilities, mostly to see what buffs are
-- active or not.
-- -------------------------------------------------------------------------------------

   dump = function ()                                                                     -- Debug function, shows buffs on the player (icon file name)
     local iIterator = 1
     while (UnitBuff(DF_PLAYER, iIterator)) do
       DEFAULT_CHAT_FRAME:AddMessage( "DruidFunc: -->".. UnitBuff(DF_PLAYER, iIterator) );
       iIterator = iIterator + 1
     end
     return false
   end;

   dedump = function ()                                                                   -- Debug function, shows debuffs on the target (icon file name)
     local iIterator = 1
     while (UnitDebuff(DF_TARGET, iIterator)) do
       DEFAULT_CHAT_FRAME:AddMessage( "DruidFunc: -->".. UnitDebuff(DF_TARGET, iIterator) );
       iIterator = iIterator + 1
     end
     return false
   end;

   isUnitBuffUp = function (sUnitname, sBuffname)                                         -- Returns true if sBuffname is active on sUnitname (target/player)
   
     -------------------------------------------------------------------------------------
     -- This procedure scans the buffs on the target and returns the TEXTURE name
     -- since several buffs/debuffs share the same texture this function is here
     -- mostly for legacy purposes.  checkBuffByName returns the actuall
     -- buff name and is far more reliable
     -------------------------------------------------------------------------------------
   
     local iIterator = 1                                                                  -- Counter
     while (UnitBuff(sUnitname, iIterator)) do                                            -- While we found a buff on the player
       if (string.find(UnitBuff(sUnitname, iIterator), sBuffname)) then                   -- see if buff matches what was passed
          return true                                                                     -- Buff was found
       end
       iIterator = iIterator + 1                                                          -- Increase counter
     end
     return false                                                                         -- Buff was not found
   end;

   checkBuffByName = function( sUnit, sBuffname )

    	local buffIndex = 1
    	local txt = ""

      DFunc_Tooltip:SetOwner(UIParent, DF_ANCHOR_NONE);                                    -- Initialize the tooltip
      
	    sBuffname = string.lower(sBuffname)
	
	    while UnitBuff(sUnit, buffIndex) and (buffIndex < 50) do

         DFunc_Tooltip:ClearLines() 
		     DFunc_Tooltip:SetUnitBuff(sUnit,buffIndex)
         txt = DFunc_TooltipTextLeft1:GetText()		     
         if txt ~= nil then         
            txt = string.lower(txt)
            if string.find(txt,sBuffname) then
               return true
            end
         else
            break
         end
         buffIndex = buffIndex + 1
      end
      DFunc_Tooltip:Hide()
      return false
   end;

   checkDebuffByName = function( sUnit, sBuffname )

      DFunc_Tooltip:SetOwner(UIParent, DF_ANCHOR_NONE);                                    -- Initialize the tooltip

    	local buffIndex = 1
    	local txt = ""

	    
      if sBuffname == nil then
         return false
      end	    
	    sBuffname = string.lower(sBuffname)
	
	    while UnitDebuff(sUnit, buffIndex) and (buffIndex < 50) do

         DFunc_Tooltip:ClearLines() 
		     DFunc_Tooltip:SetUnitDebuff(sUnit,buffIndex)
         txt = DFunc_TooltipTextLeft1:GetText()		     
         if txt ~= nil then
            txt = string.lower(txt)
            if string.find(txt,sBuffname) then
               return true
            end
         else
            break
         end
         buffIndex = buffIndex + 1
      end
      DFunc_Tooltip:Hide()
      return false
   end;

   isUnitDebuffUp = function (sBuffname)                                                  -- Returns true if sBuffname is a debuff on the target
     local iIterator = 1                                                                  -- Initialize counter
     while (UnitDebuff(DF_TARGET, iIterator)) do                                           -- While we found a debuff
       if (string.find(UnitDebuff(DF_TARGET, iIterator), sBuffname)) then                  -- see if debuff matches what was passed
          return true                                                                     -- debuff was found
       end
       iIterator = iIterator + 1                                                          -- Increase counter
     end
     return false                                                                         -- Debuff was not found
   end;

   UnitMounted = function ()                                                              -- Returns true if the player is mounted
      local i = 1                                                                         -- Initialize counter
      Mounted = false                                                                     -- Initialize the mount flag
      while (UnitBuff(DF_PLAYER, i)) do                                                    -- While we found a buff
         if (string.find(UnitBuff(DF_PLAYER, i), DF_ABILITY_MOUNT)) then                    -- is "ability mount" part of the buff name?
            if not(string.find(UnitBuff(DF_PLAYER, i), DF_JUNGLE_TIGER)) then                -- Yes?  Well make sure JungleTiger isn't part of name (That's tiger's fury and it looks like a mount buff!)
               Mounted = true                                                             -- Ability mount without jungle tiger? then we're mounted, return true
            end
         end
         i = i + 1                                                                        -- Increase counter
      end
      return Mounted                                                                      -- Return mounted.
   end;

   ChatTarget = function()                                                                -- A nifty little function that determins where we should send spam
      local Target = DF_SAY                                                                -- While I'm an advocate of /dev/null we'll set the default to be a "say" chatbubble
      if UnitInRaid( DF_PLAYER ) then                                                      -- Is unit in a raid?
         Target = DF_RAID                                                                 -- Yes, unit is in a raid so set spam target = raid chat
      else                                                                                -- Nope, player isn't in a raid
         if ( GetNumPartyMembers() > 0 ) then                                             -- Is the player in a party?
            Target = DF_PARTY                                                             -- Yup, so set spam target = party chat.
         end                                                                              -- End party check
      end                                                                                 -- End raid check
      return Target                                                                       -- Return spam target
   end;                                                                                   -- End ChatTarget function


-- -------------------------------------------------------------------------------------
-- Mark of the wild
--
-- This function attempts to cast the highest possible rank of mark of the wild
-- on the selected target.
--
-- Sample Macro
-- /script Druid.MarkOfTheWild()
-- -------------------------------------------------------------------------------------

   MarkOfTheWild = function()                                                             -- Function mark of the wild
      local spellLevel  = { 1, 10, 20, 30, 40, 50, 60 };                                  -- Set spell level index
      local friend      = UnitExists(DF_TARGET) and not UnitCanAttack(DF_PLAYER, DF_TARGET); -- Determine if target is a friend (we can cast on)
      local targetLevel = UnitLevel( DF_TARGET );                                          -- Get level of target
      local onSelf = false                                                                -- Will be set to true if we change target to player
      
      if not friend then                                                                  -- If we can't cast this buff on the player
         targetLevel = UnitLevel( DF_PLAYER );                                             -- So onSelf the player
         onSelf = true                                                                    -- Note that we onSelfed the player
      end                                                                                 -- End check friend

      for i = MAXRANK_MoTW, 1, -1 do                                                      -- Go from max rank to 0
         if( targetLevel >= spellLevel[i] - 10 ) then                                     -- If target level > spell index then we found a castable range
            CastSpellByName( DF_MOTWRANK..i..")", onSelf );                               -- Cast spell (note onSelf can make this self-cast if true)
            break;                                                                        -- Break out of the loop
         end; -- { target >= level }                                                      -- End level check
      end; -- { for }                                                                     -- End for loop
   end; -- {End MarkOfTheWild}                                                            -- End function markofthewild

-- -------------------------------------------------------------------------------------
-- Thorns
-- -------------------------------------------------------------------------------------

   Thorns = function()
      local spellLevel  = { 6, 14, 24, 34, 44, 54, 54, 54 };                              -- The spell level index
      local targetLevel = UnitLevel( DF_TARGET );                                          -- Level of the spelltarget
      local friend = UnitExists(DF_TARGET) and not UnitCanAttack(DF_PLAYER, DF_TARGET);      -- Determine if target is a friend (we can cast on)
      local onSelf = false                                                                -- Will be set to true if we change target to player

      if not friend then                                                                  -- If we can't cast on the target
         targetLevel = UnitLevel( DF_PLAYER );                                             -- Set spell target to be the player
         onSelf = true                                                                    -- Note the change
      end; -- { not friend }

      for i = MAXRANK_Thorns, 1, -1 do                                                    -- For loop starting at maxrank and working backwards
         if( targetLevel >= spellLevel[i] - 10 ) then                                     -- If target level >= level of spell
            CastSpellByName( DF_THORNSRANK..i..")", onSelf );                            -- Cast the spell (note onSelf can make this self-cast)
            break;                                                                        -- Spell is cast, break out of the loop
         end; -- { target > level }                                                       -- End target > level
      end; -- { for }                                                                     -- End for
   end; -- { Thorns }                                                                     -- End thorns

-- -------------------------------------------------------------------------------------
-- Abolish Poison
-- This is mostly in just to be in.  You should be using decursive or racure
-- -------------------------------------------------------------------------------------

   AbolishPoison = function()
      local friend = UnitExists(DF_TARGET) and not UnitCanAttack(DF_PLAYER, DF_TARGET);      -- Determine if target is a friend (we can cast on)
      local onSelf = false                                                                -- Will be true if we onSelf from target to player
      
      if not friend then                                                                  -- If target is not a friend
         onSelf = true                                                                    -- note that we changed the spelltarget
      end                                                                                 -- End friend check
	
      CastSpellByName(DF_ABOLISHPOISON, onSelf );                                         -- Cast abolish poison (note onSelf can make this a self buff)

   end; -- {Abolish Poison}

-- -------------------------------------------------------------------------------------
-- Remove Curse
-- This is mostly in just to be in.  You should be using decursive or racure
-- -------------------------------------------------------------------------------------

   RemoveCurse = function()
      local friend = UnitExists(DF_TARGET) and not UnitCanAttack(DF_PLAYER, DF_TARGET);      -- Determine if target is a friend (we can cast on)
      local onSelf = false                                                                -- Will be true if we onSelf from target to player

      if not friend then                                                                  -- If target is not a friend
         onSelf = true                                                                    -- note that we changed the spell target
      end                                                                                 -- End friend check

      CastSpellByName( DF_REMOVECURSE, onSelf );                                          -- Cast remove curse (note onSelf can make this a self buff)

   end; -- {Remove Curse}

-- -------------------------------------------------------------------------------------
-- Regrowth
-- -------------------------------------------------------------------------------------

   Regrowth = function( sendChat, targetEnemy )
      local l = { 12, 18, 24, 30, 36, 42, 48, 54, 60 };                                   -- The target level index
      local friend = UnitExists(DF_TARGET) and not UnitCanAttack(DF_PLAYER, DF_TARGET);      -- Determine if target is a friend (we can cast on)
      local setTarget = DF_TARGET                                                          -- Initial target is user's target
      local onSelf = false                                                                -- Will be set to true if we onSelf spell to the player
      local retarget = false                                                              -- Set to true if we're doing to do a targetlasttarget at end
       
      if not friend and not(LeaveTargeting) then                                          -- If target is not friendly then
         if DFUNCSmartCast and UnitExists(DF_TARGET) then                                  -- Is smartcasting enabled?
            local targetName = UnitName(DF_TARGET)                                         -- Get the name of the target
            AssistUnit(DF_TARGET)                                                          -- Yes, target is hostile, get target's target
            if targetName ~= UnitName(DF_TARGET) then                                      -- Did we actually target something?
               retarget = true                                                            -- Make sure we go back to original target after spellcast
               friend = UnitExists(DF_TARGET) and not UnitCanAttack(DF_PLAYER, DF_TARGET)    -- Determine if new target is a friend (we can cast on)
            else                                                                          -- No we didn't
               friend = false                                                             -- set friend to false so we retarget player later
            end                                                                           -- End unit exists check
         end                                                                              -- End smartcast check
         if not friend then                                                               -- Is the target hostile?
            setTarget = DF_PLAYER;                                                         -- Regrowth will be cast on the player
            onSelf = true;                                                                -- Make a note that we changed the spell target
         end                                                                              -- End friend check
      end                                                                                 -- End friend check

      local name = UnitName( setTarget );                                                 -- Get the name of the target

      if name == nil then                                                                 -- This is safety code just to make sure name isn't nil                              
         name = " "                                                                       -- This code should never execute
      end

      local h = UnitHealthMax( setTarget ) - UnitHealth( setTarget );                     -- Calculate the health the target needs.
      local t = UnitLevel( setTarget );                                                   -- Get the level of the target

      if DFUNCTrinkets then                                                               -- Are auto trinkets enabled?  If so then
         local pmana = UnitManaMax( DF_PLAYER ) - UnitMana( DF_PLAYER );                    -- Calculate how much mana the user has
         if (pmana > 600) then                                                            -- If more than 600 mana has been used...
            Druid.testTrinket(DF_MARLISEYE);                                              -- Trip Mar'li's eye (which restores 600 mana!)
         end;          
         Druid.testTrinket(DF_HC)                                                         -- Try and trip the hibernation crystal <3         
      end;
      
      for i = MAXRANK_Regrow, 1, -1 do
         if( t >= l[i] - 10 )  then                                                       -- Compare the target's level with the level index.
                                                                                          -- Found the maximum level we can cast on this target level
            if ( h > 2000 ) and DFUNCTrinkets then                                        -- If the target needs more health than this spell will give
               Druid.testTrinket(DF_ZHC);                                                 -- Trip the Zandalarian hero charm for that extra oomph
            end; -- { h > 2000 }                                                          -- If auto-trinkets are enabled of course.

            if sendChat and not DFUNC_Casting then
               DEFAULT_CHAT_FRAME:AddMessage( DF_CASTING_REGROWTH_1..name..DF_CASTING_REGROWTH_2..i.." )");
            end

            CastSpellByName( DF_CASTING_REGROWTH_3..i..")", onSelf );                          -- Cast the spell (note onSelf, if true is self cast)
            
            local LeaveTargeting = false;                                                 -- This section is for the healrange mod.
            if DFUNCHealRange and UnitInRaid(DF_PLAYER) then                               -- If healrange is installed and user is in the raid
               LeaveTargeting = true;                                                     -- Then we'll leave the spell targeting if it didn't actually cast before
            else
               if SpellIsTargeting() then                                                 -- If something happened and the spell is "targeting" that is it didn't cast and is waiting for user to click on a player....
                  SpellStopCasting()                                                      -- If healrange isn't installed then abort the spell
                  DEFAULT_CHAT_FRAME:AddMessage( DF_FAILCAST, 1.0, 0.0, 0.0, 1.0, 5 );
               end
            end                                                                         
            break;                                                                        -- Break out of the for loop, we don't need to do anything else
         end; -- { target > level }
      end; -- { for }
      
      if retarget then
         TargetLastTarget()
      end
      
   end; -- { Regrowth }

-- -------------------------------------------------------------------------------------
-- Rejuvenation -- Modified function.   This rejuvenation is extended to work with swiftmend
-- -------------------------------------------------------------------------------------

   Rejuvenation = function( sendChat, targetEnemy )
      local level = { 4, 10, 16, 22, 28, 34, 40, 46, 52, 58, 60 };                        -- The spell level index 
      local friend = UnitExists(DF_TARGET) and not UnitCanAttack(DF_PLAYER, DF_TARGET);      -- Determine if target is a friend (we can cast on)
      local setTarget = DF_TARGET;                                                         -- Initial target = user's target
      local onSelf = false;                                                               -- Will be true if we set spell target = player
      local retarget = false;                                                             -- set to true if we retarget at end of function

      local LeaveTargeting = false;                                                       -- Healrange mod support block
      if DFUNCHealRange and UnitInRaid(DF_PLAYER) then                                     -- If healrange installed and user is in a raid
         LeaveTargeting = true;                                                           -- Set the leave spell targeting flag true   
      end                                                                                 -- End healrange check

      if not friend and not(LeaveTargeting) then                                          -- If target is not friendly then
         if DFUNCSmartCast and UnitExists(DF_TARGET) then                                  -- Is smartcasting enabled?
            local targetName = UnitName(DF_TARGET)                                         -- Get the name of the target
            AssistUnit(DF_TARGET)                                                          -- Yes, target is hostile, get target's target
            if targetName ~= UnitName(DF_TARGET) then                                      -- Did we actually target something?
               retarget = true                                                            -- Make sure we go back to original target after spellcast
               friend = UnitExists(DF_TARGET) and not UnitCanAttack(DF_PLAYER, DF_TARGET)    -- Determine if new target is a friend (we can cast on)
            else                                                                          -- No we didn't
               friend = false                                                             -- set friend to false so we retarget player later
            end                                                                           -- End unit exists check
         end                                                                              -- End smartcast check
         if not friend then                                                               -- Is the target hostile?
            setTarget = DF_PLAYER;                                                         -- Regrowth will be cast on the player
            onSelf = true;                                                                -- Make a note that we changed the spell target
         end                                                                              -- End friend check
      end                                                                                 -- End friend check

      local name        = UnitName( setTarget );                                          -- Get the name of the target 
      if name == nil then                                                                 -- This is security code in case the name is nil
         name = " "                                                                       -- Which it never should be, but still, just in case
      end                                                                                 -- End security blanket
      
      if (Druid.checkBuffByName( setTarget, DF_REJUVENATION)) then                         -- See if target already has rejuvenation on him (yes?)
      
         threshold = UnitHealthMax(setTarget) / 2                                         -- Find the halfway mark of the target's health
         if UnitHealth(setTarget) < threshold then                                        -- Is the unit's health lower than half?
            name = DFUNCRejuvWarn                                                         -- If so, skip the warning and allow immediate swiftmend
         end                                                                              -- End check target health block
         
         if name ~= DFUNCRejuvWarn then                                                   -- See if we've warned the player rejuv is already up (not warned?)
            if (BOOKINDEX_Swiftmend >= 0) then                                            -- Does the user have swiftmend?  Then warn the player
               DEFAULT_CHAT_FRAME:AddMessage( DF_REJUV_WARN_1..name..DF_REJUV_WARN_2, 1.0, 0.0, 0.0, 1.0, 5  );
               PlaySound("Deathbind Sound")                                               -- Play a discrete sound
            else                                                                          -- User doesn't have swiftmend so we're refreshing rejuv
               DEFAULT_CHAT_FRAME:AddMessage( DF_REJUV_WARN_1..name..DF_REJUV_WARN_3, 1.0, 0.0, 0.0, 1.0, 5  );
               PlaySound("Deathbind Sound")                                               -- Play a discrete sound
            end
            DFUNCRejuvWarn = name                                                         -- Ok we've warned the player so remember the name of target (global)
            if retarget then
               TargetLastTarget()
            end
            return                                                                        -- We've issued warning so nothing left to do, end the function
         end                                                                              -- End warning block
         
         if (BOOKINDEX_Swiftmend >=0) then                                                -- Does user have swiftmend?
            CastSpellByName(DF_SWIFTMEND, onSelf)                                         -- He's got a hot on, warning was issued, so cast swiftmend!

            if DFUNCSwap and UnitAffectingCombat(DF_PLAYER) then                           -- Do a low mana check and see if we need to equip our low mana staff
               if (Druid.GetCurrentForm() == 0) then                                      -- If we're in humanoid form
                  Druid.LowManaSwap(DFUNCManaSwap);                                       -- Call the low mana swap function
               end                                                                        -- End check humanoid form
            end;                                                                          -- End outfit swap check and combat check
         end                                                                              -- End check for swiftmend
         if retarget then
            TargetLastTarget()
         end
         return
      end                                                                                 -- End check for rejuvenation already up

      DFUNCRejuvWarn = ""                                                                 -- Clear all outstanding warnings.

      local targetLevel = UnitLevel( setTarget );                                         -- Get the level of the target

      if DFUNCTrinkets then                                                               -- Are auto trinkets set up?
         local pmana = UnitManaMax( DF_PLAYER ) - UnitMana( DF_PLAYER );                    -- Check player mana
         if (pmana > 600) then                                                            -- If we've burned more than 600 mana
            Druid.testTrinket(DF_MARLISEYE);                                            -- Trip Mar'li's eye which restores 600 mana
         end;                                                                             -- End 600 mana check
         Druid.testTrinket(DF_HC                )                                         -- Check and use the hibernation crystal if equipped.
      end;                                                                                -- End auto-trinkets block

      for i = MAXRANK_Rejuv, 1, -1 do                                                     -- For maxrank_rejuv to rank 1 do...
         if( targetLevel >= level[i] - 10 ) or (name == " ") then                         -- Is player target level compatible with the spell level?
            if sendChat and not DFUNC_Casting then                                        -- Are we being chatty?
               DEFAULT_CHAT_FRAME:AddMessage( DF_REJUV_WARN_4..name..DF_REJUV_WARN_5..i..")" );  -- Be chatty
            end;                                                                          -- End chatty.

            CastSpellByName( DF_REJUVRANK..i..")", onSelf );                              -- Actually cast rejuvenation!  (gasp)  Note onSelf if true makes this self cast

            break;                                                                        -- We cast rejuv so break out of the loop
         end; -- { target > level }                                                       -- End target > level
      end; -- { for }                                                                     -- End for loop

      if DFUNCSwap and UnitAffectingCombat(DF_PLAYER) then                                 -- If weapon swaps are enabled and player is in combat
         if (Druid.GetCurrentForm() == 0) then                                            -- and if player is in humanoid form
            Druid.LowManaSwap(DFUNCManaSwap);                                             -- call the low mana swap function
         end                                                                              -- end check current form
      end                                                                                 -- End swap/combat check

      if retarget then
         TargetLastTarget()
      end

   end; -- { Rejuvenation }                                                               -- End rejuvenation

-- -------------------------------------------------------------------------------------
-- Rejuvenation -- Original function.  This is the original, unrestricted rejuvenation
-- rejuv will not attempt to use swiftmend, it will always cast, it will not warn you 
-- if the target already has rejuvenation running.
-- -------------------------------------------------------------------------------------

   Rejuv = function( sendChat, targetEnemy )
      local level = { 4, 10, 16, 22, 28, 34, 40, 46, 52, 58, 60 };                        -- Spell level index
      local friend = UnitExists(DF_TARGET) and not UnitCanAttack(DF_PLAYER, DF_TARGET);      -- Friend check
      local setTarget = DF_TARGET;                                                         -- Initial target is player's target
      local onSelf = false;                                                               -- Will be set to true if spell target is changed to player
      local retarget = false

      local LeaveTargeting = false;                                                       -- Assume not in raid and no healrange mod
      if DFUNCHealRange and UnitInRaid(DF_PLAYER) then                                     -- If healrange mod installed and user is in raid
         LeaveTargeting = true;                                                           -- We'll let the spell stay targeting if it can't cast
      end                                                                                 -- End healrange check

      if not friend and not(LeaveTargeting) then                                          -- If target is not friendly then
         if DFUNCSmartCast and UnitExists(DF_TARGET) then                                  -- Is smartcasting enabled?
            local targetName = UnitName(DF_TARGET)                                         -- Get the name of the target
            AssistUnit(DF_TARGET)                                                          -- Yes, target is hostile, get target's target
            if targetName ~= UnitName(DF_TARGET) then                                      -- Did we actually target something?
               retarget = true                                                            -- Make sure we go back to original target after spellcast
               friend = UnitExists(DF_TARGET) and not UnitCanAttack(DF_PLAYER, DF_TARGET)    -- Determine if new target is a friend (we can cast on)
            else                                                                          -- No we didn't
               friend = false                                                             -- set friend to false so we retarget player later
            end                                                                           -- End unit exists check
         end                                                                              -- End smartcast check
         if not friend then                                                               -- Is the target hostile?
            setTarget = DF_PLAYER;                                                         -- Regrowth will be cast on the player
            onSelf = true;                                                                -- Make a note that we changed the spell target
         end                                                                              -- End friend check
      end                                                                                 -- End friend check

      local name        = UnitName( setTarget );                                          -- Get the Name of the target
      local targetLevel = UnitLevel( setTarget );                                         -- Get the Level of the target

      if DFUNCTrinkets then                                                               -- Are auto trinkets activated?
         local pmana = UnitManaMax( DF_PLAYER ) - UnitMana( DF_PLAYER );                    -- Do a mana check
         if (pmana > 600) then                                                            -- Does player need more than 600 mana?
            Druid.testTrinket(DF_MARLISEYE);                                            -- If so trip mar'li's eye if user has it on
         end;                                                                             -- End mana check
         Druid.testTrinket(DF_HC)                                         -- Check to see if we can use the hibernation crystal
      end;                                                                                -- End auto trinket block

      for i = MAXRANK_Rejuv, 1, -1 do                                                     -- For maxrank of rejuvenation to rank 1...
         if( targetLevel >= level[i] - 10 ) or (name == " ") then                         -- Is player level compatible with level of spell?

            if sendChat and not DFUNC_Casting then                                        -- Are we being chatty?
               DEFAULT_CHAT_FRAME:AddMessage( DF_REJUV_WARN_4..name..DF_REJUV_WARN_5..i..")" );  -- Yea, I guess we are
            end;                                                                          -- End chatty block       

            CastSpellByName( DF_REJUVRANK..i..")", onSelf );                      -- Cast rejuvenation! (note onSelf can make this self targeting)

            break;                                                                        -- We cast rejuv so get out of the loop
         end; -- { target > level }                                                       -- End spell level/target level check
      end; -- { for }                                                                     -- End for loop

      if DFUNCSwap and UnitAffectingCombat(DF_PLAYER) then                                 -- Are weapon swaps enabled?  And is player in combat?
         if (Druid.GetCurrentForm() == 0) then                                            -- Is the player in humanoid form?
            Druid.LowManaSwap(DFUNCManaSwap);                                             -- Call the low mana swap function
         end                                                                              -- End check current form
      end                                                                                 -- End swap/combat check

      if retarget then
         TargetLastTarget()
      end
   end; -- { Rejuv }                                                                      -- End function rejuv

-- -------------------------------------------------------------------------------------
-- Swiftmend
-- Functionality suggested by Threbrilith EU Aszune
-- -------------------------------------------------------------------------------------

   Swiftmend = function()
      if BOOKINDEX_Swiftmend >= 0 then						                                        -- Make sure we actually HAVE swiftmend before we try to do anything
         local friend = UnitExists(DF_TARGET) and not UnitCanAttack(DF_PLAYER, DF_TARGET);   -- True if spell can be cast on target.
         local setTarget = DF_TARGET;                                                      -- Default spell target (user's target)
         local onSelf = false;                                                            -- Default spell target was changed (default false)
         local retarget = false;
         
      if not friend and not(LeaveTargeting) then                                          -- If target is not friendly then
         if DFUNCSmartCast and UnitExists(DF_TARGET) then                                  -- Is smartcasting enabled?
            local targetName = UnitName(DF_TARGET)                                         -- Get the name of the target
            AssistUnit(DF_TARGET)                                                          -- Yes, target is hostile, get target's target
            if targetName ~= UnitName(DF_TARGET) then                                      -- Did we actually target something?
               retarget = true                                                            -- Make sure we go back to original target after spellcast
               friend = UnitExists(DF_TARGET) and not UnitCanAttack(DF_PLAYER, DF_TARGET)    -- Determine if new target is a friend (we can cast on)
            else                                                                          -- No we didn't
               friend = false                                                             -- set friend to false so we retarget player later
            end                                                                           -- End unit exists check
         end                                                                              -- End smartcast check
         if not friend then                                                               -- Is the target hostile?
            setTarget = DF_PLAYER;                                                         -- Regrowth will be cast on the player
            onSelf = true;                                                                -- Make a note that we changed the spell target
         end                                                                              -- End friend check
      end                                                                                 -- End friend check

         local name = UnitName( setTarget );                                              -- Name of the target
         local start, duration = GetSpellCooldown(BOOKINDEX_Swiftmend, BOOKTYPE_SPELL);   -- Get the cooldown value of spell (we're looking for zero)
         if (duration - ( GetTime() - start) <= 0.001) then                               -- If swiftmend is not on cooldown then
            if not(Druid.checkBuffByName( setTarget, DF_REJUVENATION)) and not(Druid.checkBuffByName( setTarget, DF_REGROWTH)) then
                                                                                          --Target has neither rejuvenation or regrowth on.
               DEFAULT_CHAT_FRAME:AddMessage( DF_SWIFTMEND_WARN_1, 1.0, 0.0, 0.0, 1.0, 5  );
               
               Druid.Rejuv(false, false)                                                  -- Be lazy and call the rejuv function
            else
                                                                                          -- Target has a Hot on.
               CastSpellByName(DF_SWIFTMEND, onSelf);                                     -- Cast swiftmend
            
            end                                                                           -- End hot check
            
         else                                                                             -- Swiftmend is on cooldown
            DEFAULT_CHAT_FRAME:AddMessage( DF_SWIFTMEND_WARN_2, 1.0, 0.0, 0.0, 1.0, 5  );
            CastSpellByName(DF_SWIFTMEND, onSelf);                                         -- We'll try to cast anyway so user get's wow's default error messages
         end                                                                              -- End cooldown check
      else                                                                                -- User doesn't know swiftmend
         DEFAULT_CHAT_FRAME:AddMessage( DF_SWIFTMEND_WARN_3, 1.0, 0.0, 0.0, 1.0, 5  );
      end                                                                                 -- End user knows swiftmend check
      if retarget then
         TargetLastTarget()
      end
   end;                                                                                   -- End swiftmend function

-- -------------------------------------------------------------------------------------
-- Healing Touch (trinket version)
-- PowerTouch exists soley to trip the zandalaar druid class trinket before calling
-- Healing touch.
-- -------------------------------------------------------------------------------------

   PowerTouch = function( minRank, sendChat, targetEnemy )
      Druid.testTrinket(DF_WUSHCHARMNATURE);                                              -- Trip the ZG druid trinket if worn
      Druid.testTrinket(DF_ZHC);                                                          -- Trip the ZG hero charm trinket if worn
      Druid.testTrinket(DF_HC);                                                           -- Trip the hibernation crystal if worn
      Druid.HealingTouch( minRank, sendChat, targetEnemy )                                -- Cast healing touch
   end;                                                                                   -- End PowerTouch function

-- -------------------------------------------------------------------------------------
-- Healing Touch
--    LevelPenalty by DrakkDude (Tichondrius), and Threbrilith (EU Aszune)
-- -------------------------------------------------------------------------------------

   deRank = function( targetRank )
      local manaCost = {22, 49, 99, 166, 243, 301, 364, 445, 540, 648, 720}                   -- Mana cost of healing touch.
      local playerMana = UnitMana(DF_PLAYER)
      local testRank = targetRank

      while (manaCost[testRank] > playerMana) do
         if (targetRank-testRank > 3) then
            return targetRank                                                                -- went down 4 ranks and couldn't cast so just abort.
         end
         testRank = testRank - 1
         if testRank < 1 then
            testRank = 1
            break
         end
      end
      if targetRank ~= testRank then
         DEFAULT_CHAT_FRAME:AddMessage( DF_DERANK_WARN_1..targetRank..DF_DERANK_WARN_2..testRank..".", 1.0, 0.0, 0.0);
      end
      return testRank
   end;

   HealingTouch = function( minRank, sendChat, targetEnemy, forceRank )
      local friend = UnitExists(DF_TARGET) and not UnitCanAttack(DF_PLAYER, DF_TARGET); 	    -- The standard "friend" formula.  True if unit is friendly.
      local setTarget = DF_TARGET;                                                            -- The spell DF_TARGET, may change to DF_PLAYER later.
      local onSelf = false                                                                    -- True if we change from DF_TARGET to DF_PLAYER
      local retarget = false
      local offset = 0                                                                        -- Initialize the offset variable
      local LeaveTargeting = false;                                                           -- Healrange mod support block
      if DFUNCHealRange and UnitInRaid(DF_PLAYER) then                                        -- If healrange installed and user is in a raid
         LeaveTargeting = true;                                                               -- Set the leave spell targeting flag true   
      end                                                                                     -- End healrange check

      if not friend and not(LeaveTargeting) then                                              -- If target is not friendly then
         if DFUNCSmartCast and UnitExists(DF_TARGET) then                                     -- Is smartcasting enabled?
            local targetName = UnitName(DF_TARGET)                                            -- Get the name of the target
            AssistUnit(DF_TARGET)                                                             -- Yes, target is hostile, get target's target
            if targetName ~= UnitName(DF_TARGET) then                                         -- Did we actually target something?
               retarget = true                                                                -- Make sure we go back to original target after spellcast
               friend = UnitExists(DF_TARGET) and not UnitCanAttack(DF_PLAYER, DF_TARGET)    -- Determine if new target is a friend (we can cast on)
            else                                                                          -- No we didn't
               friend = false                                                             -- set friend to false so we retarget player later
            end                                                                           -- End unit exists check
         end                                                                              -- End smartcast check
         if not friend then                                                               -- Is the target hostile?
            setTarget = DF_PLAYER;                                                         -- Regrowth will be cast on the player
            onSelf = true;                                                                -- Make a note that we changed the spell target
         end                                                                              -- End friend check
      end                                                                                 -- End friend check
     
      local name = UnitName( setTarget );                                                 -- Remember the name of the target of the spell
      
      if name == nil then							                                                    -- Precautionary code in case target name is nil (This should never execute)
         name = " "                                                                       -- So we don't get an error message later on.
      end

      if DFUNCTrinkets then                                                               -- If automatic trinkets are activated do some checks.
         local pmana = UnitManaMax( DF_PLAYER ) - UnitMana( DF_PLAYER );                  -- Find out how much mana the player has.
         if (pmana > 600) then                                                            -- If the player is missing more than 600 mana
            Druid.testTrinket(DF_MARLISEYE);                                              -- Trip Mar'li's eye, the mana trinket from Zul'Gurub
         end;
         Druid.testTrinket(DF_HC)                                                         -- Check to see if the user is wearing the hibernation crystal.
      end;

      if (UnitHealthMax( setTarget ) > 100) then                                        
         -- If target is hostile or not in party/raid it will never have more than 100 max health
         -- So if we're getting more than 100 max health we can accurately figure out exact heal ranks.
         
         local sr = { 0, 51, 112, 243, 445, 694, 894, 1120, 1427, 1796, 2230 };           -- The "floor", spell ranks work from highest to lowest so SR1 shows the absolute minimum a spell rank will heal for.
         local sr2= { 51, 112, 243, 445, 694, 894, 1120, 1427, 1796, 2230, 2677 };        -- This is the baseline that a rank will heal for (for display purposes)
         local PlusHealBonus = {.12, .31, .56, .85, 1, 1, 1, 1, 1, 1, 1 };                -- This is the "penalty" +heal items get with each spell rank (only ranks 1-4)
         local healthmax = UnitHealthMax ( setTarget )                                    -- This is how much health the target has.
         local h = healthmax - UnitHealth( setTarget );                                   -- This is how much health the target needs.

         for i = MAXRANK_HealingTouch, 1, -1 do                                           -- Work from maxrank backwards.
            if DFUNCPlusHeal == DF_AUTO then                                              -- If we have an "auto" detect of +heal
               offset = tonumber(DFUNC_HealOffset)                                        -- Use the auto-detected +heal value (set when you change gear)
            else
               offset = tonumber( DFUNCPlusHeal )                                         -- Otherwise use the user-defined heal offset (or zero if its off)
            end
            if tonumber(offset) == nil then
               offset = 0
            end

            if offset > 0 then                                                            -- If offset isn't zero (IE off)
               offset = offset + DFUNCTrinketHeal                                         -- Add in any active healing trinket values (zandalar hero charm/hibernation crystal)
            end
            
            poffset= floor(offset * PlusHealBonus[i])                                     -- Calculate the +heal bonus for ranks 1-4
            healpower = sr[i] + poffset;                                                  -- Add spell-rank power and the calculated heal offset.
            
            if ( (h >= healpower) or ( sr[i]==0 ) ) then                                  -- See if health neededed is greater than the current spell rank/offset (we force a true condition at rank 1)
               if ( i < minRank ) then                                                    -- If our spell rank went below the user defined minrank (passed to the function) then reset rank to user defined minimum rank
                  i = minRank
               end

               if (forceRank) then                                                        -- If the user has decided to force a rank, use that rank
                  i = minRank;
               end
               
               offset = floor(offset * PlusHealBonus[i])                                  -- Recalcualte the offset in case minrank or forcerank increased level of the spell.

               if sendChat and not DFUNC_Casting then                                     -- If we're chatty and we're not already casting a spell.   Be chatty.
                  DEFAULT_CHAT_FRAME:AddMessage( DF_HT_WARN_1..name..DF_HT_WARN_2..i..") "..sr2[i]+offset..DF_HT_WARN_3..h..DF_HT_WARN_4.. healthmax ..DF_HT_WARN_4_1);
               end 
                              
               if not DFUNC_Casting then                                                  -- If we're not already casting then Attempt to cast the spell.
                  i = Druid.deRank(i)                                                     -- See if we have the mana to do this.
                  CastSpellByName( DF_HTRANK..i..")", onSelf );                           -- DFUNC_Casting is set by the event handler so no need to set the variable here.
               else                                                                       -- We're casting the spell so check to see if we should abort.
                  if (DFUNCManaC ~= "off") then                                           -- If Mana conserve is not off then...
                     local percentHealth = floor(UnitHealth( setTarget ) / UnitHealthMax( setTarget ) * 100);    -- Check the percent health of the target.
                     if ( percentHealth >= tonumber(DFUNCManaC) ) then                    -- If PercentHealth > value of DFUNCManaC percentage then abort the heal.
                        if not(DFUNCSilent) then                                          -- If user hasn't silneced notices, spam the chat frame with abort message
                           DEFAULT_CHAT_FRAME:AddMessage( DF_HT_WARN_5..percentHealth..DF_HT_WARN_6..DFUNCManaC.."%", 1.0, 0.0, 0.0, 1.0, 5 );
                        end
                        SpellStopCasting()                                                -- Blizzard's api.
                        DFUNC_Casting = false;                                            -- Reset casting just in case event handler stuff didn't catch it.
                     end
                  end
               end
               local LeaveTargeting = false;                                              -- Assume no heal-range mod.
               if DFUNCHealRange and UnitInRaid(DF_PLAYER) then                           -- Check for heal range mod.
                  LeaveTargeting = true;                                                  -- Installed and we're in a raid so flag targeting true.
               end

               if SpellIsTargeting() and not(LeaveTargeting) then                         -- If something happened and the spell is "targeting" that is it didn't cast and is waiting for user to click on a player....
                  SpellStopCasting()                                                      -- If healrange isn't installed then abort the spell
                  DEFAULT_CHAT_FRAME:AddMessage( DF_FAILCAST, 1.0, 0.0, 0.0, 1.0, 5 );
               end
               break;                                                                     -- Break out of the loop
            end
         end
      else                                                                                -- User is targeting something which doesn't return exact health needed.
         local level = { 0, 8, 14, 20, 26, 32, 38, 44, 50, 56, 60 };                      -- We can't go by target's health so go by his level.
         local t = UnitLevel( setTarget );                                                -- Find out the level of the target.
         local h1 = UnitHealthMax( setTarget );                                           -- This is just for display purposes, the unit's max health (100 in this case)
         local h2 = UnitHealth( setTarget );                                              -- The unit's current health (a percentage from 1-100)

         for i = MAXRANK_HealingTouch, 1, -1 do                                           -- From maxrank to rank 1 do loop
            if( t >= level[i] - 10 ) then                                                 -- if target > level[spell rank], we're really checking the level the spell was learned against the level of the target.  If there's a match we're probably not going to overheal too much.
               if ( i < minRank ) then                                                    -- Respect the minimum rank of the macro
                  i = minRank
               end
               if forceRank then                                                          -- Respect the forced rank passed to the procedure.
                  i = minRank;
               end
               if sendChat and not DFUNC_Casting then                                     -- If we're chatty and not already casting, drop a message
                  DEFAULT_CHAT_FRAME:AddMessage( DF_HT_WARN_7 ..i.. DF_HT_WARN_8..h2..DF_HT_WARN_9.. h1 .. DF_HT_WARN_10 .. h2 .. ")" );
               end
               i = Druid.deRank(i)                                                        -- Check to see if we have mana for this
               CastSpellByName( DF_HTRANK..i..")", onSelf );                  -- Cast the spell.
               if SpellIsTargeting() then
                  SpellStopCasting()                                                      -- Something went wrong with spell, target moved out of range or out of line of sight most likely, so abort it.
                  DEFAULT_CHAT_FRAME:AddMessage( DF_FAILCAST, 1.0, 0.0, 0.0, 1.0, 5 );
               end                                                                        -- end spell not cast block
               break;                                                                     -- We cast the spell so break out of the for loop
            end                                                                           -- End spell level/target level check
         end                                                                              -- End for loop
      end                                                                                 -- End check for target's actual health (full number or percent #)
      if retarget then
         TargetLastTarget()
      end      
   end;                                                                                   -- End healing touch function

-- -------------------------------------------------------------------------------------
-- Self Cast Innervate
--     This will cast innervate only on the player, regardless of his target.
-- -------------------------------------------------------------------------------------

   ManaMe = function ()       
      TargetUnit(DF_PLAYER)                                                                -- Target the player
      Druid.Innervate(false, true)                                                        -- Call the innervate function
      TargetLastTarget()                                                                  -- Target the last target the player had
   end;                                                                                   -- End function maname

-- -------------------------------------------------------------------------------------
-- Innervate
-- -------------------------------------------------------------------------------------

   Innervate = function( sendChat, noWhisper )
      local friend = UnitExists(DF_TARGET) and not UnitCanAttack(DF_PLAYER, DF_TARGET);      -- Check if target is friend 
      local setTarget = DF_TARGET                                                          -- Set initial target to user's target
      local onSelf = false                                                                -- Will be true if we change target to "player"

      Istart, Iduration=GetSpellCooldown(BOOKINDEX_Innervate, BOOKTYPE_SPELL); -- If we do, get cooldown info
      Icooldown = floor(Iduration - ( GetTime() - Istart))                 -- Calculate cooldown
      
      if Icooldown > 0 then
         DEFAULT_CHAT_FRAME:AddMessage( DF_I_WARN_1, 1.0, 0.0, 0.0, 1.0, 5  );
         return
      end
      
      if not(friend) then
         setTarget = DF_PLAYER 
        onSelf = true
      else
         if (UnitClass(DF_TARGET)~=DF_DRUID) and (UnitPowerType(DF_TARGET)~= 0) then
            setTarget=DF_PLAYER
            onSelf = true
         end
      end
      
      local name = UnitName( setTarget );                                                 -- Get the name of the spell target
      local playerName = UnitName (DF_PLAYER)
      
      if name == playerName then
         onSelf = true
         setTarget = DF_PLAYER
      end

      if name == nil then                                                                 -- This is security blanket code, it should never execute 
         setTarget = DF_PLAYER                                                             -- onSelf player
         onSelf = true                                                                    -- Set to true so spell casts on the player 
         name = UnitName( DF_PLAYER )                                                      -- Get the name of the player
      end                                                                                 -- End security blanket
      
      if Druid.checkBuffByName(setTarget, DF_INNERVATE) then                              -- Is innervate already active on the target?
         DEFAULT_CHAT_FRAME:AddMessage( DF_I_WARN_2..name..DF_I_WARN_3, 1.0, 0.0, 0.0, 1.0, 5  ); -- Yea, spam an error message 
         return                                                                           -- and abort out of the function
      end                                                                                 -- End Innervate already up block

      local pmana = floor(UnitMana( setTarget ) / UnitManaMax( setTarget ) * 100);        -- Get percentage of mana the target has
      
      if pmana > 50 then                                                                  -- If player has more than 50% mana then abort
         DEFAULT_CHAT_FRAME:AddMessage( DF_I_WARN_4..name..DF_I_WARN_5, 1.0, 0.0, 0.0, 1.0, 5 ); -- Spam an error message
         return                                                                           -- Abort out of function
      end                                                                                 -- End target mana check.

      CastSpellByName(DF_INNERVATE, onSelf)                                                -- Cast innervate, note onSelf can make this self-cast

      if noWhisper == nil then
         noWhisper = false
      end
      if (not noWhisper) and not(onSelf) then                                             -- For legacy purposes ensure if nothing is passed (function header)
         SendChatMessage(DFUNCIChat, DF_WHISPER, nil, UnitName(setTarget));                -- And of course we don't want to whisper ourself.
      end                                                                                 -- End nowhisper check

      if not(onSelf) then                                                                 -- If Target is the player's target and not the player 
         if (sendChat) then                                                               -- and we're being chatty
            SendChatMessage(DF_I_WARN_6..name, Druid.ChatTarget());           -- Be chatty (we came up with chat target earlier in block)
         end                                                                              -- End sendchat check
      else                                                                                -- We retarged so this innervate is going on the player
         DEFAULT_CHAT_FRAME:AddMessage( DF_I_WARN_6..name );                             -- Send private message to player 
         if DFUNCSwap then                                                                -- Are weapon swaps enabled?
            Druid.LoadWardrobe(DFUNCISet)                                                 -- If they are load the innervate set
         end                                                                              -- End weapon swap check
      end                                                                                 -- End "did we onSelf" check 
      
   end;                                                                                   -- End function innervate

-- -------------------------------------------------------------------------------------
-- Moonfire
--   Lower Rank Moonfire suggestion by Bitbyte of Icecrown
-- -------------------------------------------------------------------------------------

   Moonfire = function()

      Druid.HandleAssist( SLOTINDEX_Moonfire );                                           -- Call the assist handler to set the target (slotindex is a global variable)

      if DFUNCTrinkets then                                                               -- If auto trinkets are on
         Druid.testTrinket(DF_ZHC);                                                       -- Trip the hero charm if user has it
      end                                                                                 -- End trinket check

      local name = UnitName(DF_TARGET)
      
      if( name ~= nil ) then                                                              -- If we actually have a target
         totemCheck = Druid.CheckRank(name)                                               -- See if this is a totem.
         if (totemCheck >= 0) and (totemCheck < 24) then                                   -- Did we find a totem (>=0) and is it not the need max rank variety? (< 24)
            CastSpellByName( "Moonfire(Rank 2)" )                                         -- Yes we do, so cast moonfire rank 2 instead of maxrank
         else                                                                             -- We do not have a totem targeted
            local newRank = MAXRANK_Moonfire;                                             -- Note the current maxrank of moonfire
            local localizedClass, englishClass = UnitClass(DF_TARGET);                     -- Get the class of our target
            if englishClass ~= "ROGUE" then                                               -- If the target is NOT a rogue
               if Druid.checkDebuffByName(DF_TARGET, DF_MOONFIRE) then                    -- and if the target already has moonfire on it.
                  newRank = newRank - 1                                                   -- Reduce the rank we're going to cast by 1 (so the existing dot doesn't stop ticking)
                  if newRank < 1 then                                                            
                     newRank = 1                                                          -- Make sure we don't take the rank below castable levels
                  end
               end
            end                                                                           -- End maxrank already on.
            CastSpellByName( DF_MOONFIRERANK..newRank..")" )                             -- So cast moonfire
         end                                                                              -- End check totem in name
      end                                                                                 -- End target name not nil

      Druid.CleanupAssist()                                                               -- Call the assist handler to get the original target                                                              
   end;                                                                                   -- End function moonfire

-- -------------------------------------------------------------------------------------
-- Starfire
-- -------------------------------------------------------------------------------------

   Starfire = function()
      Druid.HandleAssist( SLOTINDEX_Starfire );                                           -- Call the assist handler to set the target
      
      if DFUNCTrinkets then                                                               -- If autotrinkets are on
         Druid.testTrinket(DF_ZHC);                                                       -- Trip the hero charm if user has it on
      end                                                                                 -- End autotrinkets
      
      CastSpellByName( DF_STARFIRE );                                                     -- Cast starfire maxrank
      
      Druid.CleanupAssist();                                                              -- Call assist  handler to get the original target
   end;                                                                                   -- End function starfire

-- -------------------------------------------------------------------------------------
-- Wrath
-- -------------------------------------------------------------------------------------
 
   Wrath = function()
      Druid.HandleAssist( SLOTINDEX_Wrath );                                              -- Call the assist handler to set the target
      
      if DFUNCTrinkets then                                                               -- If autotrinkets are on
         Druid.testTrinket(DF_ZHC);                                                       -- Trip the hero charm if user has it on
      end                                                                                 -- End autotrinkets

      CastSpellByName( DF_WRATH );                                                        -- Cast wrath maxrank

      Druid.CleanupAssist();                                                              -- Call assist handler to get the original target
   end;                                                                                   -- End function wrath

-- -------------------------------------------------------------------------------------
-- Insect Swarm
-- -------------------------------------------------------------------------------------

   InsectSwarm = function()
      Druid.HandleAssist( SLOTINDEX_InsectSwarm );                                        -- Call assist handler to set the target

      if DFUNCTrinkets then                                                               -- If autotrinkets are on
         Druid.testTrinket(DF_ZHC);                                                       -- Trip the hero charm if user has it on
      end                                                                                 -- End autotrinkets

      CastSpellByName( DF_INSECTSWARM );                                                  -- Cast insect swarm, maxrank      

      Druid.CleanupAssist();                                                              -- Call the assist hanlder to get the original target
   end;                                                                                   -- End function insect swarm

-- -------------------------------------------------------------------------------------
-- Faerie Fire
-- -------------------------------------------------------------------------------------

   FaerieFire = function()

      Druid.HandleAssist( SLOTINDEX_FF );                                                 -- Call assist handler to set the target

      if (Druid.GetCurrentForm() == 0) then                                               -- If user is humanoid
         CastSpellByName( DF_FAERIEFIRE );                                                -- Cast faerie fire max rank
      else                                                                                -- If user is not humanoid
         CastSpellByName( DF_FAERIEFIREFERAL );                                           -- Cast faerie fire (feral) maxrank
      end;                                                                                -- End check current form block

      Druid.CleanupAssist();                                                              -- Call assist handler to get the original target
   end;                                                                                   -- End function faerie fire

-- -------------------------------------------------------------------------------------
-- Barkskin
-- -------------------------------------------------------------------------------------
	
   Barkskin = function ()
      if DFUNCTrinkets then                                                               -- If auto trinkets are enabled
         Druid.testTrinket(DF_DT);                                                        -- Try and activate the defiler's talisman
      end                                                                                 -- end auto-trinket check
      CastSpellByName( DF_BARKSKIN );                                                     -- Cast barkskin
   end;

-- -------------------------------------------------------------------------------------
-- Nature's Grasp
-- -------------------------------------------------------------------------------------
	
   NaturesGrasp = function ()
      CastSpellByName( DF_NATURESGRASP );                                                 -- Cast nature's grasp
   end;                                                                                   -- exciting, no?

-- -------------------------------------------------------------------------------------
-- Hurricane
-- -------------------------------------------------------------------------------------
	
   Hurricane = function ()
      CastSpellByName( DF_HURRICANE );                                                    -- Cast Hurricane                      
   end;                                                                                   -- Why did we do this again?  Oh right, automatic-max-rank and keybinds
   
-- -------------------------------------------------------------------------------------
-- Entangling Roots
-- -------------------------------------------------------------------------------------
	
   Roots = function ()
      CastSpellByName( DF_ROOTS );                                                        -- Cast max-rank roots!
   end;                                                                                   -- Wheee
   
-- -------------------------------------------------------------------------------------
-- Tranquility
-- -------------------------------------------------------------------------------------
	
   Tranquility = function ()
      CastSpellByName( DF_TRANQUILITY );                                                  -- Cast maxrank tranquility
   end;                                                                                   -- This is why the priest just passed you on the heal meters
   
-- -------------------------------------------------------------------------------------
-- Hibernate
-- if partyChat is true this will inform the raid/party that you have hibernated a target
-- This function is not bound to the auto-assist routies.
-- -------------------------------------------------------------------------------------
   
   Hibernate = function ( partyChat ) 

      if not DFUNC_Casting then                                                           -- If user didn't mash the cast key while a spell was already casting...      
         if UnitCreatureType(DF_TARGET)==DF_BEAST or UnitCreatureType(DF_TARGET)==DF_DRAGONKIN then -- and if we're targeting a beast or dragonkin and not anythign else...
            if not Druid.checkDebuffByName(DF_HIBERNATE) then                             -- If the target isn't already slept                        
               if partyChat then                                                          -- And the user wants us to be spammy
                  
                  SendChatMessage(DF_HIBERNATE_WARN_1..name..DF_HIBERNATE_WARN_2, Druid.ChatTarget() );  -- SPAM SPAM SPAM SPAM SPAM SPAM SPAM!
                        
               end                                                                        -- End are we chatty? test
            end                                                                           -- End debuff already on test
            
            CastSpellByName( DF_HIBERNATE )                                               -- Cast maxrank hibernate
         else                                                                             -- Target is not a beast or a dragonkin
            DEFAULT_CHAT_FRAME:AddMessage( DF_HIBERNATE_WARN_3 );                         -- Toss out an error message
         end                                                                              -- End target creature type check
      end                                                                                 -- End already casting check
   end;                                                                                   -- End function hibernate

-- -------------------------------------------------------------------------------------
-- Rebirth
-- if partyChat is true this will inform the raid/party that you have hibernated a target
-- This function is not bound to the auto-assist routies.
-- -------------------------------------------------------------------------------------
   
   Rebirth = function ( partyChat )
      local name   = UnitName( DF_TARGET )                                                 -- Get the name of the target
      local friend = UnitExists(DF_TARGET) and not UnitCanAttack(DF_PLAYER, DF_TARGET);      -- Determine if we can cast on it

      if not DFUNC_Casting then                                                           -- If we're not already casting a spell
         if friend then                                                                   -- And the target can be cast on
            CastSpellByName( DF_REBIRTH )                                                 -- Cast max-rank rebirth
            if partyChat then                                                             -- Are we being chatty?
               SendChatMessage(DF_REBIRTH_WARN_1..name, Druid.ChatTarget() );    -- Yes?  Ok, inform the world of our game-saving resurrection!
            end                                                                           -- End chat test
         else                                                                             -- We can't cast on this target
            DEFAULT_CHAT_FRAME:AddMessage( DF_REBIRTH_WARN_2);                            -- So throw out an error message
         end                                                                              -- end is friend check
      end                                                                                 -- end casting check
      
   end;                                                                                   -- end function rebirth

-- -------------------------------------------------------------------------------------
-- Desperate Prayer (Automatically casts a maximum heal on the player -- with nature's swiftness if available)
-- Contributors to this block:
--      Joave (Alliance/Shadowsong EU) -- Detect NS cooldown, attempt swiftmend
--      BitByte (Icecrown) -- Efficency & functionality
--
-- Rules:
--    If NS is up, cast NS and then healing touch (max rank)
--    If NS not trained or on cooldown attempt rejuv + swiftmend
--    If Swiftmend not trained or on cooldown (IE out of options) cast maxrank regrow.
--    if (setPlayer) is true it will attempt to use the player's target as the destination 
--    if (setPlayer) is nill or false it will target the player.
-- -------------------------------------------------------------------------------------

   DesperatePrayer = function ( setOther )
      local start = 0                                                                     -- The start time of nature's swiftness cooldown
      local duration = 0                                                                  -- The durration of nature's swiftness cooldown
      local cooldown = 0                                                                  -- The cooldown left of nature's swiftness
      local swiftstart = 0                                                                -- The start time of swiftmend's cooldown
      local swiftduration = 0                                                             -- The duration of swiftmend's cooldown
      local swiftcooldown = 0                                                             -- The cooldown left of swiftmend's cooldown
      local onSelf = true                                                                 -- True means spell is casting on ourself.
      local setTarget = DF_PLAYER                                                          -- Initial target is the player

      if DFUNCPrayerFlag then                                                             -- Is prayer being spammed when it's already started a timed cast?
         return                                                                           -- Yes.   So do nothing.
      end                                                                                 -- End heal already in progress check
      
      if (setOther ~= nil) then                                                           -- Was a parameter passed to this function?
         local friend = UnitExists(DF_TARGET) and not UnitCanAttack(DF_PLAYER, DF_TARGET)    -- Determine if we can cast on it
         if friend and setOther then                                                      -- Is target castable and true was passed to cast on target?
            setTarget = DF_TARGET                                                          -- Then set target to be target
            onSelf = false                                                                -- Set the onself flag to be false
         end                                                                              -- End friend/setOther check
      end                                                                                 -- End parameter was passed check.

      local percentHealth=floor(UnitHealth( setTarget )/UnitHealthMax( setTarget )*100)   -- Calculate the percent health left of the player

      if onSelf then
         Druid.testTrinket(DF_DT);                                                        -- If the defiler's talisman is on, use it. (always)
         if (Druid.GetCurrentForm() ~= 0) then                                            -- If player is not in humanoid form then switch out
            Druid.ShiftHuman();                                                           -- Shift into human form
         end                                                                              -- End check current form
      end

      SpellStopCasting();                                                                 -- Terminate all spellcasting in progress

      if ( BOOKINDEX_NS >= 0 ) then                                                       -- Check to see if we have nature's swiftness
         start, duration = GetSpellCooldown(BOOKINDEX_NS, BOOKTYPE_SPELL);                -- If we do, get cooldown info
         cooldown = floor( duration - ( GetTime() - start ) )                             -- Calculate the cooldown
      end
      
      if ( BOOKINDEX_Swiftmend >= 0) then                                                 -- Check to see if we have swiftmend
         swiftstart, swiftduration=GetSpellCooldown(BOOKINDEX_Swiftmend, BOOKTYPE_SPELL); -- If we do, get cooldown info
         swiftcooldown = floor(swiftduration - ( GetTime() - swiftstart))                 -- Calculate cooldown
      end
      
      if (percentHealth <= DFUNCPrayer) then                                              -- See if player's health is below the user defined threshold
         Druid.testTrinket(DF_HC);                                                        -- Trip the hibernation crystal if worn (always)
         Druid.testTrinket(DF_ZHC);                                                       -- Trip the hero charm if active (always)

         if Druid.checkBuffByName(DF_PLAYER, "nature's swiftness") then                   -- If Nature's swiftness is already tripped.
               CastSpellByName( DF_HEALINGTOUCH, onSelf) -- Cast maxrank healing touch
         end 
         if (BOOKINDEX_NS >= 0) and ( cooldown <= 0.001) then                             -- If we have nature's swiftness and it's not on cooldown
            CastSpellByName( DF_NATURESWIFTNESS, onSelf );                                -- Cast nature's swiftness
            SpellStopCasting();                                                           -- Terminate outstanding spell casts 
            CastSpellByName( DF_HEALINGTOUCH, onSelf)                                     -- Cast maxrank healing touch
         else                                                                             -- We don't have nature's swiftness or it's on cooldown
            if (BOOKINDEX_Swiftmend >= 0) and (swiftcooldown <= 0.001) then               -- Do we have swiftmend?
               if (Druid.checkBuffByName( setTarget, DF_REJUVENATION)) or (Druid.checkBuffByName(setTarget,DF_REGROWTH)) then
                  CastSpellByName( DF_SWIFTMEND, onSelf );                                 -- We have swiftmend AND there's a hot up, so swiftmend
               else                                                                       -- We have swiftmend but there's no Hot up
                  CastSpellByName( DF_REJUVENATION, onSelf)                               -- So cast maxrank rejuv
                  DEFAULT_CHAT_FRAME:AddMessage( DF_PRAYER_WARN_1);                       -- Notify user.
               end                                                                        -- End hot on player check
            else                                                                          -- User doesn't have swiftmend or its on cooldown
               Druid.testTrinket(DF_WUSHCHARMNATURE)                                      -- Try and use the ZG trinket
               if Druid.checkBuffByName(DF_PLAYER, DF_HC_BUFF) then                       -- Was the ZG class trinket effect on?
                  CastSpellByName( DF_HEALINGTOUCH,onSelf) -- We tripped charm of nature so do healing touch
                  DFUNCPrayerFlag = true;                                                 -- Spam-proof this spell so we don't abort it.
               else
                 CastSpellByName( DF_REGROWTH, onSelf);	                                  -- No NS, No Swiftmend, no ZG trinket so try a regrow
                 DFUNCPrayerFlag = true;                                                  -- Spam-proof this spell so we don't abort it.
               end      
            end                                                                           -- End do we have swiftmend check
         end                                                                              -- End do we have nature's swiftness check
      else
         CastSpellByName( DF_REGROWTH, onSelf);	                                          -- Player's health is fine, queue up a regrowth tho
         DFUNCPrayerFlag = true;                                                          -- Spam-proof this spell so we don't abort it.
      end                                                                                 -- End check player's health
   end;                                                                                   -- End function desperate prayer

-- -------------------------------------------------------------------------------------
-- Feral Section: where the wild things are.
-- -------------------------------------------------------------------------------------

   Ravage = function ()
      CastSpellByName( DF_RAVAGE );                                                       -- Maxrank ravage, just for the ever-increasing auto-rank & keybind
   end;

   Shred = function ()
      CastSpellByName( DF_SHRED );                                                        -- Maxrank shred, for keybinds and auto-increasing rank
   end;

   Claw = function ()
      CastSpellByName( DF_CLAW );                                                         -- Maxrank claw
   end;
   
   Prowl = function ()
      if Druid.checkBuffByName(DF_PLAYER, DF_PROWL) then                                  -- If user is already prowling
         return                                                                           -- do nothing, exit out.
      end
      if Druid.checkBuffByName(DF_PLAYER, DF_WSG_FLAG_A) or Druid.checkBuffByName(DF_PLAYER, DF_WSG_FLAG_H) then
         DEFAULT_CHAT_FRAME:AddMessage( DF_PROWL_WARN_1, 1.0, 0.0, 0.0, 1.0, 5 );         -- Spam an error message
         PlaySound(DF_DEATHBIND_SOUND)                                                    -- Play a discrete sound
         return
      end
      if (Druid.GetCurrentForm() == 0) then                                               -- if player is in humanoid form
         CastSpellByName(DF_SHADOWMELD)                                                   -- Try to shadowmeld         
      else                                                                                -- Player is not in humanoid form
         CastSpellByName( DF_PROWL )                                                      -- Try to Stealth
      end
   end;                                                                                   -- End Prowl

   Rake = function ()
      CastSpellByName( DF_RAKE );                                                         -- Maxrank Rake
   end;

   Rip = function ()
      CastSpellByName( DF_RIP );                                                          -- Maxrank rip
   end;

   Pounce = function ()
      CastSpellByName( DF_POUNCE );                                                       -- Maxrank pounce
   end;
   
   FeralCharge = function ()
      CastSpellByName ( DF_FERALCHARGE );                                                 -- Feral Charge, just here for keybind
   end;

   FerociousBite = function ()
      CastSpellByName ( DF_FEROCIOUSBITE );                                               -- Ferocious bite
   end;

   TigersFury = function ()
      CastSpellByName ( DF_TIGERSFURY );                                                  -- Tiger's fury
   end;

   Cower = function ()
      CastSpellByName ( DF_COWER );                                                       -- Cower, the least used and understood skill
   end;

   Dash = function ()
      CastSpellByName ( DF_DASH );                                                        -- Dash away dash away dash away all!
   end;

   Maul = function ()
      CastSpellByName( DF_MAUL );                                                         -- Maul
   end;

   Swipe = function ()
      CastSpellByName( DF_SWIPE );                                                        -- Swipe
   end;

   Bash = function ()
      CastSpellByName( DF_BASH );                                                         -- Bash
   end;

   Growl = function ()
      CastSpellByName( DF_GROWL );                                                        -- Growl
   end;

   Enrage = function ()
      CastSpellByName( DF_ENRAGE );                                                       -- Enrage
   end;

   ChalRoar = function ()
      CastSpellByName( DF_CHALROAR );                                                     -- Challenging roar
   end;

   FrenziedRegen = function ()
      CastSpellByName( DF_FRENZIEDREGEN );                                                -- Frenzied regeneration
   end;

   DemRoar = function ()
      CastSpellByName( DF_DEMROAR );                                                      -- Demoralizing roar
   end;

   BestAttackCat = function ()                                                            -- Use the best attack available in cat form

      if UnitAffectingCombat( DF_PLAYER ) then                                             -- Is player in combat (can't be stealthed)
         if (GetComboPoints() >= 5) then                                                  -- Does target have 5 combo points?
            Druid.FerociousBite();                                                        -- Yes, 5 combo points so ferocious bite
         else                                                                             -- Target doesn't have 5 combo points
            if (UnitMana(DF_PLAYER) > 35) or (Druid.checkBuffByName( DF_PLAYER, DF_OMEN)) then -- Does target have 35 energy or omen of clarity up?
               Druid.Claw();                                                              -- Yes, do a claw
            else                                                                          -- Player has no energy
               if not(Druid.checkDebuffByName(DF_TARGET, DF_FAERIEFIRE)) then              -- Does the target have farie fire on it?
                  Druid.FaerieFire()                                                      -- No, attempt farie fire (feral)
               end                                                                        -- End faerie fire check
            end                                                                           -- End energy/omen check
         end                                                                              -- End combo point check
      else                                                                                -- Player is NOT in combat
         if Druid.checkBuffByName(DF_PLAYER, DF_PROWL) then                                 -- Player is already stealthed         
            if UnitMana(DF_PLAYER) > 90 or (Druid.checkBuffByName( DF_PLAYER, DF_OMEN)) then -- If player has enough energy (for both tigers fury AND ravage)
               Druid.TigersFury();                                                        -- Cast tiger's fury
               SpellStopCasting();                                                        -- Clear spell casting so we can prep the next spell
            end                                                                           -- End energy/Omen check
            Druid.Ravage();                                                               -- Backstab/ravage
         else                                                                             -- Player is not stealthed and is out of combat
            CastSpellByName(DF_TRACKHUMANOIDS);                                           -- Turn on track humanoids
            SpellStopCasting()                                                            -- Stop spellcasting
            Druid.Prowl();                                                                -- Prowl
         end                                                                              -- End stealth check
      end;                                                                                -- End combat check
   end;                                                                                   -- End best attack cat function

-- -------------------------------------------------------------------------------------
-- Swiftshift section -- This area holds functions and procedures which handle shapeshifting
-- -------------------------------------------------------------------------------------

   GetCurrentForm = function ()                                                           -- Find out what form we're in
      local maxForms = GetNumShapeshiftForms();                                           -- Get number of forms the user has
      local currentForm = 0;                                                              -- Set current form to 0 (which is humanoid)
      local currentName = "";                                                             -- Initialize name of form
      for i=1, maxForms, 1 do                                                             -- For each form
        icon, name, active, castable = GetShapeshiftFormInfo(i);                          -- Get the name, is it active, can it be used
        if (active ~= nil) then                                                           -- If this form is active
           currentForm = i                                                                -- Get the form index
           currentName = name                                                             -- Get the name of the form
        end                                                                               -- End active check
      end                                                                                 -- End for ech form
      if currentForm == 0 then                                                            -- If form is 0
         currentName = "Humanoid Form"                                                    -- Give it our own name (forget why)
      end                                                                                 -- End is form 0
      return currentForm, currentName;                                                    -- Return form index and name
   end;                                                                                   -- End function get current form

   WeaponShift = function()                                                               -- Called when the user changes forms
      
      if not Druid.checkBuffByName(DF_PLAYER, DF_INNERVATE) and (DFUNCSwap) then            -- If innervate isn't active and weaponswapping is...
         currentForm, name = Druid.GetCurrentForm()                                       -- Get the current form
         name=string.lower(name);                                                         -- Convert it to lower case
         if name ~= DFUNCLastForm then                                                    -- If current form (name) doesn't match last form then...
            DFUNCLastForm = name;                                                         -- Set last form = current form
            if string.find(name, DF_BEAR) then                                             -- Are we now a bear?
               if DFUNCBearSet ~= nil then                                             -- Is bear outfit enabled?
                  Druid.LoadWardrobe(DFUNCBearSet);                                       -- Outfit our bear gear
               end                                                                        -- End bear outfit enabled
            end                                                                           -- End check if we're bear            
            if string.find(name, DF_CAT) then                                              -- Are we now a cat?
               if DFUNCCatSet ~= nil then                                              -- Is the cat wardrobe enabled?
                  Druid.LoadWardrobe(DFUNCCatSet)                                         -- Yes to both, so outfit our cat gear
               end                                                                        -- End cat outfit check
            end                                                                           -- End catform check
            if string.find(name, DF_HUMAN) then                                         -- Are we now humanoid?
               if (DFUNCHumanSet ~= nil) then                                          -- Is human form outfit enabled?
                  if not(UnitAffectingCombat(DF_PLAYER)) then                              -- and if we're not in combat
                     Druid.LoadWardrobe(DFUNCBaseSet)                                     -- Equip our base set
                  end                                                                     -- End combat check
               end                                                                        -- End human outfit check
            end                                                                           -- End humanform check
            if string.find(name, DF_MOON) then                                          -- Are we a moonkin (heh)
               if DFUNCMoonSet ~= nil then                                             -- Is the moonkin set enbaled?
                  Druid.LoadWardrobe(DFUNCMoonSet);                                       -- Yes & Yes so equip the moonkin set
               end                                                                        -- End moonkin set check
            end                                                                           -- End moonkin check
            if string.find(name, DF_TRAVEL) then                                           -- Are we in travel form?
               if DFUNCHumanSet ~= nil then                                            -- Is there a travel form set?
                  Druid.LoadWardrobe(DFUNCTravelSet);                                     -- Equip travel form gear
               end                                                                        -- End gear check
            end                                                                           -- End travel form check
            if string.find(name, DF_AQUA) then                                             -- Are we in aquatic form
               if DFUNCAquaSet ~= nil then                                             -- Is there an aquatic form outfit?  (really?)
                  Druid.LoadWardrobe(DFUNCAquaSet);                                       -- Equip the aquatic form outfit
               end                                                                        -- End aquatic outfit check
            end                                                                           -- End aquatic form check
         end                                                                              -- End current form/last form check
      end                                                                                 -- End innervate/swap checks
   end;                                                                                   -- End function weapon shift

   ChangeShapeshiftForm = function ( shift )                                              -- Change the current form
            	
 	    local i = 1                                                                         -- Initialize the counter
	    local target =0;                                                                    -- Initialize our target form (default human)
	    local current = 0;                                                                  -- Initialize our current form (default human)
 	    local maxForms = GetNumShapeshiftForms();                                           -- Get the maximum number of forms
 	    local curName = "None"

	
	    if UnitClass(DF_PLAYER) ~= DF_DRUID then                                            -- Is the character a druid?  (paladin auras and warrior stances count as shapeshifts so if we're not a druid we need to get out of here)
	       return                                                                           -- Not a druid, goodbye!
	    end                                                                                 -- End is player a druid check.

       if Druid.isUnitBuffUp(DF_PLAYER,DF_ABILITY_MOUNT) then                             -- Is the player mounted?
          local i = 0                                                                     -- Initialize counter to 0
          while (GetPlayerBuffTexture(i)) do                                              -- While there's a buff at this slot
             if (string.find(GetPlayerBuffTexture(i), DF_ABILITY_MOUNT)) then             -- Is the buff a mount?
                if not(string.find(GetPlayerBuffTexture(i), DF_JUNGLE_TIGER)) then        -- Yes?  But make sure it's not tiger's fury (which looks like a mount)
                   CancelPlayerBuff(i);                                                   -- Player's mounted so dismount him
                   SpellStopCasting();                                                    -- Cancel spellcasting
                end                                                                       -- End tiger's fury check
             end                                                                          -- End mounted buff check
             i = i + 1                                                                    -- Increment counter
         end                                                                              -- End while loop
       end;                                                                               -- end mount check
	
	     if DFUNCTrinkets then                                                              -- Are auto trinkets activated?
          Druid.testTrinket(DF_RUNEMETAMORPH);                                            -- Try the rune of metamorphasis
       end                                                                                -- End auto-trinket check
        
       for i = 1, maxForms, 1 do                                                          -- For each of the available forms
          icon, name, active, castable = GetShapeshiftFormInfo(i);                        -- Get name, isactive, iscastable for that form
          if (active ~= nil) then                                                         -- Is this form active?
             current = i
             curName = name                                                               -- Yes,  note it in current
          end                                                                             -- end active check
          if ( string.find( name, shift ) ~= nil ) then                                   -- Does the form name match what we're looking form (passed in function header)
             target = i                                                                   -- Yes, this is our target form, remember it
          end                                                                             -- End name match
       end;
       if (target==0) and (current==0) then                                               --User wants humanoid and is already humanoid
          if (DFUNCHardShift=="on") and (DFUNCSwiftTarget) then                           --If hardshifting is on and swifttarget is on
             TargetUnit( DF_PLAYER )                                                       -- Just target the player (emulate default wow behavior in humanoid form)
          else                                                                            -- Hardshifting is off or swifttarget is off
             if (DFUNCSwiftTarget) then                                                   -- Is swifttargeting set to player?
                TargetUnit( DF_PLAYER )                                                    -- Then target the player
            else                                                                          -- Otherwise call
                Druid.DesperatePrayer()                                                   -- Desperate prayer for an emergency heal
            end                                                                           -- End swifttarget check.
          end                                                                             -- End harshift/swifttarget check
       else                                                                               -- We're not humanoid or target isn't humanoid
          if (current==0) then                                                            -- If current = human it means target is not (we checked that above)
             CastShapeshiftForm(target);                                                  -- So give the user his requested form
          else                                                                            -- User is not presently a human
             if (DFUNCHardShift==DF_ON) and (shift ~=DF_TRAVELFORM) then                   -- Is hardshifting on and we're not trying for travel form?
                if (current ~= target) then                                               -- Yes.  Is our destination different than our current form?
                   CastShapeshiftForm(current);                                           -- Yes.  We need to get back to humanoid form so we just cast our current form to get there
                else                                                                      -- User is already in the form being requested so lets add some functionality
                   if (shift=="Cat Form") then                                            -- If the user is a cat
                      Druid.BestAttackCat()                                               -- Cycle through the best attack cat stuff.
                   end                                                                    -- End cat check
                   if (shift=="Bear Form") then                                           -- Is the user a bear?
                      Druid.FeralCharge();                                                -- Try a feral charge
                      Druid.Maul();                                                       -- If we can't do that, try to maul
                   end                                                                    -- End bear check
                end                                                                       -- End current/target form check
             else                                                                         -- Hardshifting is off or we're trying for travel form (travel form always shifts back to humanoid when you hit it)
               if curName == DF_MOONFORM then
                   if DFUNCMoonbar > 0 then
                     CURRENT_ACTIONBAR_PAGE = 1;                                                -- Set the action bar to default back to 1
                     ChangeActionBarPage();                                                     -- Change the action bar
                   end
               end
                if (target==0) then                                                       -- If the target is humanoid then
                   target=current                                                         -- Cast the current shapeshift form to get out of form and back in humanoid
                end                                                                       -- End is human check                                                                        
                CastShapeshiftForm(current);                                              -- Cast the current form to revert to human
             end                                                                          -- End hardshift/travel form check
          end                                                                             -- End current form humanoid check
      end;                                                                                -- End target and destination both human check             
   end;                                                                                   -- End shapeshift function
      
   ShiftBear = function ()
      Druid.ChangeShapeshiftForm(DF_BEARFORM)                                             -- Shift to bear form
      
   end;
   
   ShiftCat = function ()
      Druid.ChangeShapeshiftForm(DF_CATFORM)                                              -- Shift to cat form
   end;
   
   ShiftTravel = function ()
      Druid.ChangeShapeshiftForm(DF_TRAVELFORM)                                           -- Shift to travel form
   end;

   ShiftAqua = function ()
      Druid.ChangeShapeshiftForm(DF_AQUAFORM)                                          -- Shift to aquatic form
   end;
   
   ShiftMoon = function ()
      Druid.ChangeShapeshiftForm(DF_MOONFORM)                                             -- Shift to moonkin form
      if DFUNCMoonbar > 0 then                                                            -- Is moonbar set to any toolbar but zero?
         CURRENT_ACTIONBAR_PAGE = DFUNCMoonbar;                                           -- Yup.  Set the action bar to user's preference
         ChangeActionBarPage();                                                           -- Change the action bar  (so moonkin gets its own toolbar)
      end                                                                                 -- End moonbar check    
   end;

   ShiftHuman = function ()   
      Druid.ChangeShapeshiftForm(DF_HUMANFORM)                                            -- Shift to humanoid form
   end;
   
-- -------------------------------------------------------------------------------------
-- Assist section
--
-- These functions handle auto assist.  
-- If the assist is a ghost (dead) you'll attack whatever you have targeted.
--
-- It's recommended you activate this function only in raid dungeons
-- In PvP and dynamic outdoor situations setting an assist will get you killed more often than not.
--
-- Usage:
-- /dassist                         With no arguments this just shows who you are assisting
-- /dassist <name>                  This turns on the assist
-- /dassist off                     This turns off the assist
-- /dassist on                      This turns on the assist and uses the last assist name.
-- -------------------------------------------------------------------------------------
   
   HandleAssist = function (actionSlot)
   
      if DFUNCSmartCast then
         local friend = UnitExists(DF_TARGET) and not UnitCanAttack(DF_PLAYER, DF_TARGET);  -- Determine if target is a friend (we can cast on)
         if friend then
            targetName = UnitName(DF_TARGET)
            AssistUnit(DF_TARGET)
            if targetName ~= UnitName(DF_TARGET) then
               DFUNC_LastTarget = true
            else
               DFUNC_LastTarget = false
            end
         else
            DFUNC_LastTarget = false
         end
         return
      end      
                                                      
      DFUNC_LastTarget = nil;                                                             -- Set the last target to nil (global constant)

      if DFUNC_assist ~= DF_OFF then                                                      -- If assist is on (IE not off)
         DFUNC_LastTarget = UnitName( DF_TARGET );                                         -- Get the current target and stuff it in a global constant
         if (DFUNC_LastTarget == nil) then                                                -- If the player wasn't looking at anything redirect his attention
            DFUNC_LastTarget = UnitName( DF_PLAYER );                                      -- and target the player
         end                                                                              -- End check last target.
         TargetByName(DFUNC_assist);                                                      -- Target the person we're supposed to be assisting.
         if UnitAffectingCombat(DF_TARGET) then                                            -- Is our assist person in combat?
            if not UnitIsDeadOrGhost( DF_TARGET ) then                                     -- Is he dead or a ghost?
               AssistByName(DFUNC_assist);                                                -- Ok he's in combat and not dead, snag his target
               local friend = UnitExists(DF_TARGET) and not UnitCanAttack(DF_PLAYER, DF_TARGET); -- is his target friendly?           
               if (not UnitIsVisible(DF_TARGET)) or friend then                            -- Is the target visible or friendly?
                  TargetByName(DFUNC_LastTarget);                                         -- If target is friendly or not visible return to the original target.
                  DEFAULT_CHAT_FRAME:AddMessage( DF_ASSIST_WARN_1);  -- Spam error message
               else                                                                       -- Unit is visible or hostile
                  if actionSlot > 0 then                                                  -- Is our attack spell on the toolbar somewhere?
                     if IsActionInRange(actionSlot) ~= 1 then                             -- Yes!  Lets see if target is in range of the attack
                        TargetByName(DFUNC_LastTarget);                                   -- It's not.  Get user's original target
                        DEFAULT_CHAT_FRAME:AddMessage( DF_ASSIST_WARN_2 );  -- And spam an error message
                     end;                                                                 -- End range check
                  end;                                                                    -- End action on toolbar check
               end;                                                                       -- End visible/friend check
            else                                                                          -- Assist dude is dead, we should trust his judgment? I think not.
               TargetByName(DFUNC_LastTarget);                                            -- onSelf user's original target
               DEFAULT_CHAT_FRAME:AddMessage( DF_ASSIST_WARN_3 ); -- Give an abort message
            end                                                                           -- End dead check
         else                                                                             -- Unit is not in combat
            TargetByName(DFUNC_LastTarget);                                               -- Get player's original target
            DEFAULT_CHAT_FRAME:AddMessage( DF_ASSIST_WARN_4 ); -- Spam error message
         end                                                                              -- End combat check
      end                                                                                 -- End check assist enabled
   end;                                                                                   -- End function handle assist
   
   CleanupAssist = function ()                                                            -- Try to onSelf the user's original target before the assist
      if DFUNCSmartCast then
         if DFUNC_LastTarget then
            TargetLastTarget()
         end
         return
      end      
      if (DFUNC_LastTarget ~= nil) and (DFUNC_assist ~= nil) then                         -- If we have a target saved, and assists are on
         TargetByName(DFUNC_LastTarget);                                                  -- Attempt to target the user's last target
      end                                                                                 -- End rules check
   end;                                                                                   -- End function Cleanup assist
   
-- -------------------------------------------------------------------------------------
-- Slash Command Handlers
-- -------------------------------------------------------------------------------------

   trim = function( aString )
      if aString ~= nil then
         aString = string.gsub( aString, "^[%c%s]+", "" )
         aString = string.gsub( aString, "[%s%c]+$", "" )
      end
      return aString
   end;
  
 
   DCmd = function (msg)
      local flag1 = ""
      local flag2 = ""
      local flag3 = ""      
      local ca = {}
      
      -- Parse the incomming message (The part after /druid)

      local findspace = string.find(string.lower(msg), " ");
      if findspace ~= nil then
         flag1 = string.sub(msg,1, findspace-1);
         temp = string.sub(msg, findspace+1).." ";
         findspace = string.find(temp," ");
         if findspace ~= nil then
            allArgs = temp;
            flag2 = string.sub(temp, 1, findspace-1);
            flag3 = string.sub(temp, findspace+1);
            flag3 = Druid.trim(flag3);
         else
            flag2 = temp;
            flag3 = "";
         end
      else
         flag1 = msg;
         flag2 = "";
         flag3 = "";
      end;
      flag1 = string.lower(flag1)
      flag2 = string.lower(flag2)
      flag3 = string.lower(flag3)

      if flag1 == DF_HOME then
         local invBag, invLocation = Druid.FindItem(DF_HEARTHSTONE)
         if (GetContainerItemCooldown(invBag,invLocation) ==0) then
              DEFAULT_CHAT_FRAME:AddMessage( DF_HOME_WARN_1 );
              UseContainerItem(invBag, invLocation);
         else
            DEFAULT_CHAT_FRAME:AddMessage( DF_HOME_WARN_2 );
         end
         return
      end

      if flag1 == DF_PORT or flag1 == DF_MOONGLADE then
         DEFAULT_CHAT_FRAME:AddMessage( DF_PORT_WARN_1 );
         CastSpellByName(DF_TELEPORTMOONGLADE)
         return
      end 

      DEFAULT_CHAT_FRAME:AddMessage( DF_DCMD_WARN_1, 0, 1.0, 0);
      DEFAULT_CHAT_FRAME:AddMessage( DF_DCMD_WARN_2, 0, 1.0, 0);
      
      if flag1 == "" then
         flag2 = "*"
      end

      if flag1 == DF_STATS then
         DEFAULT_CHAT_FRAME:AddMessage( DF_STATS_WARN_1..DFUNC_HealOffset);
         DFUNCMana5Offset = 0
         if Druid.checkBuffByName (DF_PLAYER, DF_MANAREGEN) then
            DFUNCMana5Offset = DFUNCMana5Offset + 12 
         end         
         DEFAULT_CHAT_FRAME:AddMessage( DF_STATS_WARN_2..DMana5+DFUNCMana5Offset);
         local base, stat, posBuff, negBuff = UnitStat(DF_PLAYER,5)         
         SpiritTick = floor(stat/5) + 13
         DEFAULT_CHAT_FRAME:AddMessage( DF_STATS_WARN_3..SpiritTick);
         Innervate = SpiritTick * 40
         DEFAULT_CHAT_FRAME:AddMessage( DF_STATS_WARN_4..Innervate..DF_STATS_WARN_5);
         return
      end

      if flag2 ~= "" then 
         DEFAULT_CHAT_FRAME:AddMessage( DF_DCMD_WARN_3 );         
         DEFAULT_CHAT_FRAME:AddMessage( DF_DCMD_WARN_4 );         
         DEFAULT_CHAT_FRAME:AddMessage( DF_DCMD_WARN_5 );               
      end
      
      if flag1 == DF_ICHATFLAG then
         if flag2 == "" then
            DEFAULT_CHAT_FRAME:AddMessage( DF_ICHAT_WARN_1 );
            DEFAULT_CHAT_FRAME:AddMessage( DF_ICHAT_WARN_2 );
            return
         end
         DFUNCIChat = allArgs;
         DEFAULT_CHAT_FRAME:AddMessage( DF_ICHAT_WARN_3..DFUNCIChat,1.0,0,0 );
      else
         if flag2 ~= "" then
            DEFAULT_CHAT_FRAME:AddMessage( DF_ICHAT_WARN_3..DFUNCIChat );
         end
      end

      if flag1 == DF_PLUSHEAL then
         if flag2 == "" then
            DEFAULT_CHAT_FRAME:AddMessage( DF_PLUSHEAL_WARN_1 );
            DEFAULT_CHAT_FRAME:AddMessage( DF_PLUSHEAL_WARN_2 );
            DEFAULT_CHAT_FRAME:AddMessage( DF_PLUSHEAL_WARN_3 );
            DEFAULT_CHAT_FRAME:AddMessage( DF_PLUSHEAL_WARN_4 );
            DEFAULT_CHAT_FRAME:AddMessage( DF_PLUSHEAL_WARN_5 );
            DEFAULT_CHAT_FRAME:AddMessage( DF_PLUSHEAL_WARN_6 );
            return
         end
         if flag2 == DF_OFF then
            flag2 = "0"
         end
         if flag2 == DF_AUTO then
            DFUNCPlusHeal = DF_AUTO
         else
            if tonumber(flag2) ~= nil then
               DFUNCPlusHeal = flag2
            end
         end
         DEFAULT_CHAT_FRAME:AddMessage( DF_PLUSHEAL_WARN_7..DFUNCPlusHeal,1.0,0,0);
      else
         if flag2 ~= "" then
            DEFAULT_CHAT_FRAME:AddMessage( DF_PLUSHEAL_WARN_7..DFUNCPlusHeal);
         end
      end
         

      if flag1 == DF_HARDSHIFT then
         if flag2 == "" then
            DEFAULT_CHAT_FRAME:AddMessage( DF_HARDSHIFT_WARN_1 );
            DEFAULT_CHAT_FRAME:AddMessage( DF_HARDSHIFT_WARN_2 );
            DEFAULT_CHAT_FRAME:AddMessage( DF_HARDSHIFT_WARN_3 );
            return
         end
         if flag2 == "on" then
            DFUNCHardShift = "on"
         end
         if flag2 == "off" then
            DFUNCHardShift = "off"
         end
         DEFAULT_CHAT_FRAME:AddMessage( DF_HARDSHIFT_WARN_4..DFUNCHardShift, 1.0,0,0);
      else
         if flag2 ~= "" then
            DEFAULT_CHAT_FRAME:AddMessage( DF_HARDSHIFT_WARN_4..DFUNCHardShift);
         end
      end   

      if flag1 == DF_SASSIST then
         if flag2 == "" then
            DEFAULT_CHAT_FRAME:AddMessage( DF_SASSIST_WARN_1 );
            DEFAULT_CHAT_FRAME:AddMessage( DF_SASSIST_WARN_2 );
            return
         end
         if flag2 == DF_OFF then
            DFUNC_assist=DF_OFF
         else
            if flag2 == DF_ON then
               if assistName ~= nil then            
                  DFUNC_assist = assistName
               else
                  DFUNC_assist = DF_OFF
               end
            else
               DFUNC_assist = flag2
               assistName = flag2
            end
        end
        DEFAULT_CHAT_FRAME:AddMessage( DF_SASSIST_WARN_3 .. DFUNC_assist,1.0,0,0);
      else
         if flag2 ~= "" then
           DEFAULT_CHAT_FRAME:AddMessage( DF_SASSIST_WARN_3 ..DFUNC_assist);
         end
      end


      if flag1 == DF_MANAC then
         if flag2 == "" then
            DEFAULT_CHAT_FRAME:AddMessage( DF_MANAC_WARN_1 );
            DEFAULT_CHAT_FRAME:AddMessage( DF_MANAC_WARN_2 );
            DEFAULT_CHAT_FRAME:AddMessage( DF_MANAC_WARN_3 );
            DEFAULT_CHAT_FRAME:AddMessage( DF_MANAC_WARN_4 );
            return
         end
         if (flag2 == DF_SILENT) then
            DFUNCSilent = true
         else
            if (flag2 == DF_ANNOUNCE) then
               DFUNCSilent = false
            else
               if (flag2 == DF_OFF) then
                  DFUNCManaC = DF_OFF;
               else
                  x = tonumber(flag2)
                  if x==nil then
                     x=0
                  end
                  if (x >= 10) and (x <=100) then
                     DFUNCManaC = x;
                  end
               end
            end
         end
         local isSilent = DF_MANAC_WARN_5
         if not DFUNCSilent then
            isSilent = DF_MANAC_WARN_6
         end
         DEFAULT_CHAT_FRAME:AddMessage( DF_MANAC_WARN_7..DFUNCManaC.." "..isSilent,1.0,0,0);
      else
         if flag2 ~= "" then         
            local isSilent = DF_MANAC_WARN_5
            if not DFUNCSilent then
               isSilent = DF_MANAC_WARN_6
            end
            DEFAULT_CHAT_FRAME:AddMessage( DF_MANAC_WARN_7..DFUNCManaC.." "..isSilent);
         end
      end

      if flag1 == "manaswap" then
         if flag2 == "" then
            DEFAULT_CHAT_FRAME:AddMessage( DF_MANASWAP_WARN_1 );
            DEFAULT_CHAT_FRAME:AddMessage( DF_MANASWAP_WARN_2 );
            DEFAULT_CHAT_FRAME:AddMessage( DF_MANASWAP_WARN_3 );
            DEFAULT_CHAT_FRAME:AddMessage( DF_MANASWAP_WARN_4 );
            return
         end
         x = tonumber(flag2)
         if x == nil then
            x = 0
         end
         if x >= 0 and x < 100 then
            DFUNCManaSwap = x
         end            
         DEFAULT_CHAT_FRAME:AddMessage( DF_MANASWAP_WARN_5..DFUNCManaSwap, 1.0, 0, 0);
      else
         if flag2 ~= "" then
            DEFAULT_CHAT_FRAME:AddMessage( DF_MANASWAP_WARN_5..DFUNCManaSwap );
         end
      end
      if flag1 == DF_MOONBAR then
         if flag2 == "" then
            DEFAULT_CHAT_FRAME:AddMessage( DF_MOONBAR_WARN_1 );
            DEFAULT_CHAT_FRAME:AddMessage( DF_MOONBAR_WARN_2 );
            DEFAULT_CHAT_FRAME:AddMessage( DF_MOONBAR_WARN_3 );
            return
         end
         x = tonumber(flag2)
         if x == nil then
            x = 0
         end
         if x >= 0 and x < 7 then
            DFUNCMoonbar = x
         end            
         DEFAULT_CHAT_FRAME:AddMessage( DF_MOONBAR_WARN_4..DFUNCMoonbar, 1.0, 0, 0);
      else
         if flag2 ~= "" then
            DEFAULT_CHAT_FRAME:AddMessage( DF_MOONBAR_WARN_4..DFUNCMoonbar);
         end
      end
      
      if flag1 == DF_SMARTCAST then
         if flag2 == "" then
            DEFAULT_CHAT_FRAME:AddMessage( DF_SMARTCAST_WARN_1 );
            DEFAULT_CHAT_FRAME:AddMessage( DF_SMARTCAST_WARN_2 );
            DEFAULT_CHAT_FRAME:AddMessage( DF_SMARTCAST_WARN_3 );
            DEFAULT_CHAT_FRAME:AddMessage( DF_SMARTCAST_WARN_4 );
            return
         end
         if flag2 == DF_ON then
            DFUNCSmartCast = true
         end
         if flag2 == DF_OFF then
            DFUNCSmartCast = false
         end
         if DFUNCSmartCast then
            DEFAULT_CHAT_FRAME:AddMessage( DF_SMARTCAST_WARN_5 , 1.0,0,0);
         else
            DEFAULT_CHAT_FRAME:AddMessage( DF_SMARTCAST_WARN_6, 1.0,0,0);
         end
      else
         if flag2 ~= "" then
            if DFUNCSmartCast then
               DEFAULT_CHAT_FRAME:AddMessage( DF_SMARTCAST_WARN_5 );
            else
               DEFAULT_CHAT_FRAME:AddMessage( DF_SMARTCAST_WARN_6 );
            end
         end
      end

      if flag1 == DF_STARGET then
         if flag2 == "" then
            DEFAULT_CHAT_FRAME:AddMessage( DF_STARGET_WARN_1 );
            DEFAULT_CHAT_FRAME:AddMessage( DF_STARGET_WARN_2 );
            DEFAULT_CHAT_FRAME:AddMessage( DF_STARGET_WARN_3 );
            return
         end
         if flag2 == DF_ON then
            DFUNCSwiftTarget = true
         end
         if flag2 == DF_OFF then
            DFUNCSwiftTarget = false
         end
         if DFUNCSwiftTarget then
            DEFAULT_CHAT_FRAME:AddMessage( DF_STARGET_WARN_4, 1.0,0,0);
         else
            DEFAULT_CHAT_FRAME:AddMessage( DF_STARGET_WARN_5, 1.0,0,0);
         end
      else
         if flag2 ~= "" then
            if DFUNCSwiftTarget then
               DEFAULT_CHAT_FRAME:AddMessage( DF_STARGET_WARN_4 );
            else
               DEFAULT_CHAT_FRAME:AddMessage( DF_STARGET_WARN_5 );
            end
         end
      end

      if flag1 == DF_TRINKETS then
         if flag2 == "" then
            DEFAULT_CHAT_FRAME:AddMessage( DF_TRINKETS_WARN_1 );
            DEFAULT_CHAT_FRAME:AddMessage( DF_TRINKETS_WARN_2 );
            DEFAULT_CHAT_FRAME:AddMessage( DF_TRINKETS_WARN_3 );
            DEFAULT_CHAT_FRAME:AddMessage( DF_TRINKETS_WARN_4 );
            return
         end
         if flag2 == DF_ON then
            DFUNCTrinkets = true
         end
         if flag2 == DF_OFF then
            DFUNCTrinkets = false
         end
         if DFUNCTrinkets then
            DEFAULT_CHAT_FRAME:AddMessage( DF_TRINKETS_WARN_5,1.0,0,0);
         else
            DEFAULT_CHAT_FRAME:AddMessage( DF_TRINKETS_WARN_6,1.0,0,0);
         end
      else
         if flag2 ~= "" then
            if DFUNCTrinkets then
               DEFAULT_CHAT_FRAME:AddMessage( DF_TRINKETS_WARN_5);
            else
               DEFAULT_CHAT_FRAME:AddMessage( DF_TRINKETS_WARN_6);
            end
        end
      end
      
      if flag1 == DF_SPRAYER then
         if flag2 == "" then
            DEFAULT_CHAT_FRAME:AddMessage( DF_SPRAYER_WARN_1 );
            DEFAULT_CHAT_FRAME:AddMessage( DF_SPRAYER_WARN_2 );
            DEFAULT_CHAT_FRAME:AddMessage( DF_SPRAYER_WARN_3 );
            return
         end
         x = tonumber(flag2)
         if x==nil then
            x=0
         end
         if (x >= 25) and (x <=100) then
            DFUNCPrayer = x;
         end
         DEFAULT_CHAT_FRAME:AddMessage( DF_SPRAYER_WARN_4..DFUNCPrayer, 1.0,0,0);
      else
         if flag2 ~= "" then
            DEFAULT_CHAT_FRAME:AddMessage( DF_SPRAYER_WARN_4..DFUNCPrayer);
         end
      end      

   end;
   
-- -------------------------------------------------------------------------------------
-- This section handles the wardrobe changes on shift
-- -------------------------------------------------------------------------------------

   ScanGump = function()
      -- -------------------------------------------------------------------------------------
      -- This function scans and records all the items the user is currently wearing
      -- and returns them in a table
      -- -------------------------------------------------------------------------------------
      DFunc_Tooltip:SetOwner(UIParent, DF_ANCHOR_NONE);                                    -- Initialize the tooltip
      ktr=0;
      tmpGump = {}
      for i, slotName in DFUNC_Slots do
         ktr = ktr + 1
         tmpGump[ktr] = "";
         slotid, _ = GetInventorySlotInfo(slotName.. DF_SLOT);
         DFunc_Tooltip:ClearLines()
         foundItem = DFunc_Tooltip:SetInventoryItem(DF_PLAYER, slotid);
         if ( foundItem ) then
            tmp = getglobal(DF_DFunc_TooltipTextLeft..1);
            tmpLine = tmp:GetText();
            tmpLine = string.lower(tmpLine);
            if tmpLine then
               tmpGump[ktr] = tmpLine;
            end            
         end         
      end
      DFunc_Tooltip:Hide()      
      return tmpGump;
   end;

   EquipItem = function(invItem, gumpSlot)
      -- -------------------------------------------------------------------------------------
      -- This equipes the named item in the given slot.
      -- -------------------------------------------------------------------------------------
      for i = 0, 4, 1 do
         invItem = string.lower(invItem);
         maxSlots = GetContainerNumSlots(i)
         for ktr = 0, maxSlots, 1 do
            local texture, itemCount, locked, quality, readable = GetContainerItemInfo(1,2);
   	        linktext = GetContainerItemLink(i, ktr);
            if linktext then
               local _,_,name = string.find(linktext, "^.*%[(.*)%].*$");
               name=string.lower(name);
               if name == invItem then 
                  PickupContainerItem( i, ktr);
                  EquipCursorItem( GetInventorySlotInfo(gumpSlot.."Slot") )       
                  return
               end
            end
        end
      end
   end;

   
   LoadWardrobe = function( incTable )
      -- -------------------------------------------------------------------------------------
      -- This function equips the items in the passed table
      -- -------------------------------------------------------------------------------------
      if incTable == nil then
         return
      end
      -- First turn off the function that checks for +heal and mana/5 (to speed things up)
      DFUNCNoScan = true

      if UnitAffectingCombat(DF_PLAYER) or DFUNCWeapon then
         -- Player is in combat so only equip weapons and ranged items
         Druid.Equip(incTable[16], incTable[17], incTable[18]);
      else
            -- Player is not in combat so equip everything
         for i, slotName in DFUNC_Slots do
            if (incTable[i] ~= nil) and (incTable[i] ~= "") then
               Druid.EquipItem(incTable[i], slotName)
            end
         end
      end
      
      -- We've loaded everything so turn the +heal and mana/5 checking back on and recheck everything
      DFUNCNoScan = false
   end;
      
   CheckWeapon = function ()
      -- This function merely returns the name of the weapon the player is wielding in his main hand
      local linktext = GetInventoryItemLink(DF_PLAYER,GetInventorySlotInfo(DF_MAINHANDSLOT))      
      local weaponInfo = " "
      if (linktext ~= nil) then
         local _,_,name = string.find(linktext, "^.*%[(.*)%].*$");
         weaponInfo = name;
      end      
      return weaponInfo
   end;

   Swap = function ( left1, right1, left2, right2 )
      -- Swaps weapons between two given sets
      if string.lower(Druid.CheckWeapon()) == string.lower(left1) then
         Druid.Equip(left2, right2);
      else
         Druid.Equip(left1, right1);
      end
   end;
   
   SwapI = function (left1, right1, idol1, left2, right2, idol2)
     -- Swaps weapons & idols between two given sets.
     -- This is the same as swap but includes idols.
      if string.lower(Druid.CheckWeapon()) == string.lower(left1) then
         Druid.Equip(left2, right2, idol2);
      else
         Druid.Equip(left1, right1, idol1);
      end
   end;     
   
   LowManaSwap = function ( Percent )
      -- This function checks the mana and combat conditions for low mana swaps. 
      if not(DFUNCSwap) or (DFUNCManaSet == nil) then
         return
      end
      if (DFUNCManaSet[16] == nil) then 
         return
      end
      if UnitAffectingCombat(DF_PLAYER) then
         if not Druid.checkBuffByName(DF_PLAYER, DF_INNERVATE ) then
            local pmana = floor(UnitMana( DF_PLAYER ) / UnitManaMax( DF_PLAYER ) * 100);
            if ( pmana <= Percent ) then               
               if string.lower(Druid.CheckWeapon()) ~= string.lower( DFUNCManaSet[16] ) then
                  Druid.LoadWardrobe( DFUNCManaSet )
               end
            end
         end   
      end      
   end;

   Equip = function ( LeftHand, RightHand, Idol )
      -- This function equips the sepcified weapons/ranged items.
      local found = false;
      local foundbag = 0;
      local foundslot = 0;
      local found2 = false;
      local foundbag2 = 0;
      local foundslot2 = 0;
      local found3 = false;
      local foundbag3 = 0;
      local foundslot3= 0;
      
      -- change strings to lower case
      if (LeftHand == nil) then
         -- Nothing was passed so do nothing
         return
      else
         LeftHand = string.lower(LeftHand)
      end;
      if (RightHand ~= nil) then
         RightHand = string.lower(RightHand)
      end
      if (Idol ~= nil) then
         Idol = string.lower(Idol)
      end
      
      -- Check all the imtes in all the bags.
      for i = 0, 4, 1 do
         maxSlots = GetContainerNumSlots(i)
         for ktr = 0, maxSlots, 1 do
            local texture, itemCount, locked, quality, readable = GetContainerItemInfo(1,2);
   	    linktext = GetContainerItemLink(i, ktr);
            if linktext then
               local _,_,name = string.find(linktext, "^.*%[(.*)%].*$");
               name=string.lower(name);
               if name == LeftHand then 
                  found = true;
                  foundbag = i;
                  foundslot = ktr;
               end
               if RightHand ~= nil then
                  if name == RightHand then
                     found2 = true;
                     foundbag2 = i;
                     foundslot2 = ktr;
                  end
               end
               if Idol ~= nil then
                  if name == Idol then
                     found3 = true;
                     foundbag3 = i;
                     foundslot3 = ktr;
                  end
               end
            end
        end
      end
      if found then
         PickupContainerItem(foundbag, foundslot);
         AutoEquipCursorItem();         
      end;
      if found2 then
         PickupContainerItem(foundbag2, foundslot2);
         EquipCursorItem( 16 );         
      end;
      if found3 then
         PickupContainerItem(foundbag3, foundslot3);
         EquipCursorItem( 17 );
      end
   end;

   Dress = function (msg)
      msg = string.lower(msg)
      orgcode=DFUNCWeapon                        -- Remember the current user defined /doutfit state (weapon/outfit)
      DFUNCWeapon=false                          -- Enable all wardrobe changes regardless of what user has specified
      if msg == DF_HUMANHUMAN then 
            Druid.LoadWardrobe(DFUNCHumanSet);
      end      
      if msg == DF_BEAR then 
            Druid.LoadWardrobe(DFUNCBearSet);
      end      
      if msg == DF_CAT then 
            Druid.LoadWardrobe(DFUNCCatSet);
      end      
      if msg == DF_TRAVEL then 
            Druid.LoadWardrobe(DFUNCTravelSet);
      end      
      if msg == DF_AQUA then 
            Druid.LoadWardrobe(DFUNCAquaSet);
      end      
      if msg == DF_MOON then 
            Druid.LoadWardrobe(DFUNCMoonSet);
      end      
      if msg == DF_FIRE then 
            Druid.LoadWardrobe(DFUNCFireSet);
      end      
      if msg == DF_NATURE then 
            Druid.LoadWardrobe(DFUNCNatureSet);
      end      
      if msg == DF_MOUNT then 
            Druid.LoadWardrobe(DFUNCMountSet);
      end      
      if msg == DF_I then 
            Druid.LoadWardrobe(DFUNCISet);
      end      
      if msg == DF_MANA then 
            Druid.LoadWardrobe(DFUNCManaSet);
      end      
      if msg == DF_PVP then 
            Druid.LoadWardrobe(DFUNCPvPSet);
      end      
      if msg == DF_WSG then 
            Druid.LoadWardrobe(DFUNCWSGSet);
      end      
      if msg == DF_FROST then 
            Druid.LoadWardrobe(DFUNCFrostSet);
      end      
      if msg == DF_ARCANE then 
            Druid.LoadWardrobe(DFUNCArcaneSet);
      end      
      if msg == DF_HEAL then 
            Druid.LoadWardrobe(DFUNCHealSet);
      end      
      if msg == DF_SHADOW then 
            Druid.LoadWardrobe(DFUNCShadowSet);
      end      
      if msg == DF_SPECIAL1 then 
            Druid.LoadWardrobe(DFUNCSpecial1);
      end      
      if msg == DF_SPECIAL2 then 
            Druid.LoadWardrobe(DFUNCSpecial2);
      end      
      if msg == DF_SPECIAL3 then 
            Druid.LoadWardrobe(DFUNCSpecial3);
      end      
      if msg == DF_TEMP then 
            Druid.LoadWardrobe(DFUNCTempSet);
      end      
      DFUNCWeapon=orgcode;                      -- Restore user defined /doutfit state (weapon/outfit)
   end;
         
   Outfit = function (msg)
      -- This is the / command handler for /doutfit 
      
      local findspace = string.find(string.lower(msg), " ");
      
      -- Parse the incomming message (The part after /doutfit)
      if findspace ~= nil then
         flag1 = string.sub(msg,1, findspace-1);
         temp = string.sub(msg, findspace+1).." ";
         findspace = string.find(temp," ");
         if findspace ~= nil then
            flag2 = string.sub(temp, 1, findspace-1);
            flag3 = string.sub(temp, findspace+1);
            flag3 = Druid.trim(flag3);
         else
            flag2 = temp;
            flag3 = "";
         end
      else
         flag1 = msg;
         flag2 = "";
         flag3 = "";
      end;
      flag1 = string.lower(flag1)
      flag2 = string.lower(flag2)
      flag3 = string.lower(flag3)
      if flag1 == "" then
         DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_1 );
         DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_2 );
         DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_3 );
         DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_4 );
         DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_5 );         
         DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_6 );         
         DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_7 )
         if DFUNCSwap then
            DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_8 )
         else
            DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_9 )
         end
         if DFUNCWeapon then
            DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_10 )
         else
            DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_11 )
         end
      end
      if flag1 == DF_OFF then
         DFUNCSwap = false
         DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_12 );
         return
      end
      if flag1 == DF_DO_WEAPON then
         DFUNCWeapon = true
         DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_13);
         return
      end
      if flag1 == DF_DO_OUTFIT then
         DFUNCWeapon = false
         DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_14 );
         return
      end
      if flag1 == DF_ON then
         DFUNCSwap = true
         DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_15 );
         return
      end         
      
      if flag1 == DF_CAT then
         if flag2 == DF_OFF then
            DFUNCCatSet = {}
            DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_16 );
         else
            if flag2 == DF_DO_SAVE then
               DFUNCCatSet = Druid.ScanGump()
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_17 );
            else
               DFUNCBaseSet = DFUNCCatSet;
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_18 );
               Druid.Dress(flag1)
            end
         end
      end

      if flag1 == DF_DO_MOON then
         if flag2 == DF_OFF then
            DFUNCMoonSet = {}
            DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_19 );
         else
            if flag2 == DF_DO_SAVE then
               DFUNCMoonSet = Druid.ScanGump()
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_20 );
            else
               DFUNCBaseSet = DFUNCMoonSet;
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_21 );
               Druid.Dress(flag1)
            end
         end
      end

      if flag1 == DF_TRAVEL then
         if flag2 == DF_OFF then
            DFUNCTravelSet = {}
            DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_22 );
         else
            if flag2 == DF_DO_SAVE then
               DFUNCTravelSet = Druid.ScanGump()
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_23 );
            else
               DFUNCBaseSet = DFUNCTravelSet;
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_24 );
               Druid.Dress(flag1)
            end
         end
      end

      if flag1 == DF_AQUA then
         if flag2 == DF_OFF then
            DFUNCAquaSet = {}
            DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_25 );
         else
            if flag2 == DF_DO_SAVE then
               DFUNCAquaSet = Druid.ScanGump()
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_26 );
            else
               DFUNCBaseSet = DFUNCAquaSet;
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_27 );
               Druid.Dress(flag1)
            end
         end
      end

      if flag1 == DF_BEAR then
         if flag2 == DF_OFF then
            DFUNCBearSet = {}
            DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_28 );
         else
            if flag2 == DF_DO_SAVE then
               DFUNCBearSet = Druid.ScanGump()
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_29 );
            else
               DFUNCBaseSet = DFUNCBearSet;
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_30 );
               Druid.Dress(flag1)
            end
         end
      end

      if flag1 == DF_HUMANHUMAN then
         if flag2 == DF_OFF then
            DFUNCHumanSet = {}
            DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_31 );
         else
            if flag2 == DF_DO_SAVE then
               DFUNCHumanSet = Druid.ScanGump()
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_32);
            else
               DFUNCBaseSet = DFUNCHumanSet;
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_33 );
               Druid.Dress(flag1)
            end
         end
      end

      if flag1 == DF_MANA then
         if flag2 == DF_OFF then
            DFUNCManaSet = {}
            DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_34 );
         else
            if flag2 == DF_DO_SAVE then
               DFUNCManaSet = Druid.ScanGump()
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_35 );
            else
               DFUNCBaseSet = DFUNCManaSet;
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_36 );
               Druid.Dress(flag1)
            end
         end
      end
      
      if flag1 == DF_I then
         if flag2 == DF_OFF then
            DFUNCISet = {}
            DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_37 );
         else
            if flag2 == DF_DO_SAVE then
               DFUNCISet = Druid.ScanGump()
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_38 );
            else
               DFUNCBaseSet = DFUNCISet;
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_39 );
               Druid.Dress(flag1)
            end
         end
      end

      if flag1 == DF_FIRE then
         if flag2 == DF_OFF then
            DFUNCFireSet = {}
            DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_40 );
         else
            if flag2 == DF_DO_SAVE then
               DFUNCFireSet = Druid.ScanGump()
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_41 );
            else
               DFUNCBaseSet = DFUNCFireSet;
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_42 );
               Druid.Dress(flag1)
            end
         end
      end

      if flag1 == DF_PVP then
         if flag2 == DF_OFF then
            DFUNCPvPSet = {}
            DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_43 );
         else
            if flag2 == DF_DO_SAVE then
               DFUNCPvPSet = Druid.ScanGump()
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_44 );
            else
               DFUNCBaseSet = DFUNCPvPSet;
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_45 );
               Druid.Dress(flag1)
            end
         end
      end

      if flag1 == DF_WSG then
         if flag2 == DF_OFF then
            DFUNCWSGSet = {}
            DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_46 );
         else
            if flag2 == DF_DO_SAVE then
               DFUNCWSGSet = Druid.ScanGump()
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_47 );
            else
               DFUNCBaseSet = DFUNCWSGSet;
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_48 );
               Druid.Dress(flag1)
            end
         end
      end

      if flag1 == DF_NATURE then
         if flag2 == DF_OFF then
            DFUNCNatureSet = {}
            DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_49 );
         else
            if flag2 == DF_DO_SAVE then
               DFUNCNatureSet = Druid.ScanGump()
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_50 );
            else
               DFUNCBaseSet = DFUNCNatureSet;
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_51 );
               Druid.Dress(flag1)
            end
         end
      end

      if flag1 == DF_MOUNT then
         if flag2 == DF_OFF then
            DFUNCMountSet = {}
            DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_52 );
         else
            if flag2 == DF_DO_SAVE then
               DFUNCMountSet = Druid.ScanGump()
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_53 );
            else
               DFUNCBaseSet = DFUNCMountSet;
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_54 );
               Druid.Dress(flag1)
            end
         end
      end

      if flag1 == DF_ARCANE then
         if flag2 == DF_OFF then
            DFUNCArcaneSet = {}
            DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_55 );
         else
            if flag2 == DF_DO_SAVE then
               DFUNCArcaneSet = Druid.ScanGump()
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_56 );
            else
               DFUNCBaseSet = DFUNCarcaneSet;
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_57 );
               Druid.Dress(flag1)
            end
         end
      end

      if flag1 == DF_SHADOW then
         if flag2 == DF_OFF then
            DFUNCShadowSet = {}
            DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_58 );
         else
            if flag2 == DF_DO_SAVE then
               DFUNCShadowSet = Druid.ScanGump()
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_59 );
            else
               DFUNCBaseSet = DFUNCShadowSet;
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_60 );
               Druid.Dress(flag1)
            end
         end
      end

      if flag1 == DF_FROST then
         if flag2 == DF_OFF then
            DFUNCFrostSet = {}
            DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_61 );
         else
            if flag2 == DF_DO_SAVE then
               DFUNCFrostSet = Druid.ScanGump()
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_62 );
            else
               DFUNCBaseSet = DFUNCFrostSet;
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_63 );
               Druid.Dress(flag1)
            end
         end
      end

      if flag1 == DF_HEAL then
         if flag2 == DF_OFF then
            DFUNCHealSet = {}
            DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_64 );
         else
            if flag2 == DF_DO_SAVE then
               DFUNCHealSet = Druid.ScanGump()
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_65 );
            else
               DFUNCBaseSet = DFUNCHealSet;
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_66 );
               Druid.Dress(flag1)
            end
         end
      end

      if flag1 == DF_TEMP then
         if flag2 == DF_OFF then
            DFUNCHealSet = {}
            DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_67 );
         else
            if flag2 == DF_DO_SAVE then
               DFUNCTempSet = Druid.ScanGump()
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_68 );
            else
               DFUNCBaseSet = DFUNCTempSet;
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_69 );
               Druid.Dress(flag1)
            end
         end
      end

      if flag1 == DF_SPECIAL1 then
         if flag2 == DF_OFF then
            DFUNCSpecial1 = {}
            DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_70 );
         else
            if flag2 == DF_DO_SAVE then
               DFUNCSpecial1 = Druid.ScanGump()
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_71 );
            else
               DFUNCBaseSet = DFUNCSpecial1;
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_72 );
               Druid.Dress(flag1)
            end
         end
      end

      if flag1 == DF_SPECIAL2 then
         if flag2 == DF_OFF then
            DFUNCSpecial2 = {}
            DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_73 );
         else
            if flag2 == DF_DO_SAVE then
               DFUNCSpecial2 = Druid.ScanGump()
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_74 );
            else
               DFUNCBaseSet = DFUNCSpecial2;
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_75 );
               Druid.Dress(flag1)
            end
         end
      end

      if flag1 == DF_SPECIAL3 then
         if flag2 == DF_OFF then
            DFUNCSpecial3 = {}
            DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_76 );
         else
            if flag2 == DF_DO_SAVE then
               DFUNCSpecial3 = Druid.ScanGump()
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_77 );
            else
               DFUNCBaseSet = DFUNCSpecial3;
               DEFAULT_CHAT_FRAME:AddMessage( DF_DO_WARN_78 );
               Druid.Dress(flag1)
            end
         end
      end

   end;      

-- -------------------------------------------------------------------------------------
-- Totem Smasher Section
-- -------------------------------------------------------------------------------------

   CheckRank = function(totem_name)
      -- This function takes a name and compares it to a list of totems.  
      -- It supports Druid.TotemStomper() and does not stand alone
      -- The first totem in the list is lowest priority
      -- The last totem in the list is the highest priority
      -- If the name is not "totemic" (winterspring firbolgs) and has the name totem or ward (preceeding space)
      --   then the item is assumed to be a totem and is given the lowest priority value
      --   if the passed name can not be found in the list.

      local TotemList = {DF_TOTEM_SENTRY,                                                 -- "sentry totem"
                         DF_TOTEM_WINDWALL,                                               -- "windwall totem"
                         DF_TOTEM_FIRE,                                                   -- "fire resistance totem"
                         DF_TOTEM_FROST,                                                  -- "frost resistance totem"
                         DF_TOTEM_HEAL,                                                   -- "healing totem"
                         DF_TOTEM_POISON,                                                 -- "poison clensing totem"
                         DF_TOTEM_DISEASE,                                                -- "disease clesning totem"
                         DF_TOTEM_STRENGTH,                                               -- "strength of earth totem"
                         DF_TOTEM_STONECLAW,                                              -- "stoneclaw totem"
                         DF_TOTEM_NATURE,                                                 -- "nature resistance totem"
                         DF_TOTEM_GRACE,                                                  -- "grace of air totem"
                         DF_TOTEM_STONESKIN,                                              -- "stoneskin totem"
                         DF_TOTEM_EARTHBIND,                                              -- "earthbind totem"
                         DF_TOTEM_MOONFLARE,                                              -- "moonflare totem"
                         DF_TOTEM_GROUNDING,                                              -- "grounding totem"
                         DF_TOTEM_SEARING,                                                -- "searing totem"
                         DF_TOTEM_MAGMA,                                                  -- "magma totem"
                         DF_TOTEM_FIRENOVA,                                               -- "fire nova totem"
                         DF_TOTEM_HEALSTREAM,                                             -- "healing stream totem"
                         DF_TOTEM_WINDFURY,                                               -- "windfury totem"
                         DF_TOTEM_MANASPRING,                                             -- "mana spring totem"
                         DF_TOTEM_MANATIDE,                                               -- "mana tide totem"
                         DF_TOTEM_TREMOR,                                                 -- "tremor totem"
                         DF_TOTEM_HEALWARD,                                               -- "healing ward"
                         DF_TOTEM_BRAINWASH,                                              -- "brain wash totem"
                         DF_TOTEM_POWERFUL,                                               -- "powerful healing ward"
                         DF_TOTEM_LIGHTNING,                                              -- "lightning totem"
                         ""}
      
      totem_name = string.lower(totem_name)
      if string.find(totem_name, DF_TOTEM_TOTEMIC) then
         -- We're dealing with a winterspring firbolg, it's not a totem.
         return -1
      end
      if string.find(totem_name, DF_TOTEM_TOTEM) or string.find(totem_name,DF_TOTEM_WARD) then
         -- Cycle through the list....
         for ktr = 1, 10000, 1 do
            if TotemList[ktr]==nil then
               return 1
               -- Reached end of list didn't find anything but has totem or ward in
               -- the name so return 1 (lowest priority)
            end
            if totem_name == TotemList[ktr] then
               -- Found a match so return the current index (higher # = > priority)
               return ktr
            end
         end
      else
         -- No "totem" or "ward" in the name so return -1 (nothing found)
         return -1
      end
   end;  						-- End CheckRank

   TotemStomper = function()
      -- This is the totem stomper function.  It scans up-to 10 nearby targets looking for totems
      -- It prioritizes the totems based on their threat
      -- Then it moonfires them with rank 2 moonfire (jindo's totems are always maxrank)
      
      local orgTarget=UnitName(DF_TARGET)		-- Get the original target name
      local bestTotem = nil				          -- Name of the best totem found
      local bestRank  = -1 				          -- Numeric ranking of the best totem
      
      
      for ktr = 1, 10, 1 do				          -- For each of 10 targets....
         TargetNearestEnemy()				        -- TargetNearestEnemy (wow api)
         if (UnitName(DF_TARGET)==nil) then	-- If nil then no more targets
            break;					                -- Break out of the for loop
         end
         
         curTarget=UnitName(DF_TARGET)			  -- Get the name of the current target
         
         rank = Druid.CheckRank(curTarget)	-- Call checkrank and see if it's a totem and get its rank
         
         if rank > bestRank then			      -- if rank is higher than all the other targets we've found so far...
            bestRank = rank;				        -- remember the rank of the current target
            bestTotem = curTarget;			    -- remember the name of the current target
         end
      end                                   -- End of for loop
      
      if bestRank > -1 then				          -- Rank is > -1 so we found a totem somewhere
         TargetByName(bestTotem)			      -- Target it
         
         if bestTotem == DF_TOTEM_BRAINWASH or bestTotem == DF_TOTEM_POWERFUL or bestTotem == DF_TOTEM_LIGHTNING then
            -- Jindo's totems are a bit tougher than normal totems so cast max-rank
            CastSpellByName(DF_MOONFIRE);
         else
            -- All other totems are pretty weak, rank 1 could kill most of them but lets use rank #2 just to be safe.
            CastSpellByName(DF_MOONFIRERANK2);
         end
      end                                  -- End moonfire the totem (best rank > -1)
      
      if (not(orgTarget == nil)) then			 -- If we were actually targeting something before the stomp
         TargetByName(orgTarget)			     -- retarget it (well try too... this wow api command is so the suck)
      else
         ClearTarget();					           -- Nothing was targeted so retarget nothing.
      end
      if bestRank > -1 then
         return true					             -- If we stomped something return true (in case you want to tie this into moonfire)
      else
         return false					             -- If we didn't stomp anything then return false
      end
   end;							                       -- End TotemStomper

-- -------------------------------------------------------------------------------------
-- Mark Rogues
--    This is similar to the totem stomper but it seeks out any nearby rogues
--    and if they do not have faerie fire on them it will cast it.
--    if all the available rogues already have faerie fire it will moonfire them
--    Die rogues, just die.
-- -------------------------------------------------------------------------------------

   markRogues = function()

      local ktr = 0                                                                       -- Counter variable.
      local lastRogue = ""                                                                -- Name of the last rogue we found
      local didFF = false                                                                 -- Set to true if we faerie fire a rogue

      for ktr = 1, 10, 1 do				                                                        -- For each of 10 targets....
         TargetNearestEnemy()				                                                      -- TargetNearestEnemy (wow api)
         local localizedClass, englishClass = UnitClass(DF_TARGET);                        -- Get the class of our target
         if englishClass == nil then
            break
         end
         if englishClass == "ROGUE" then                                                   -- Did we find a rogue? (not localized since we retrieved the english class)
            lastRogue = UnitName(DF_TARGET)                                                -- Yes we did.  mark its name
            if not(Druid.checkDebuffByName(DF_TARGET,DF_FAERIEFIRE)) then                  -- Does the target have faerie fire on him already?
               Druid.FaerieFire()                                                         -- No.  Well make it so #1
               didFF = true                                                               -- Remember that we did cast faerie fire on the target
               break                                                                      -- Did the deed, no need to loop further
            end
         end
      end
      if not(didFF) then                                                                  -- If we didn't cast faerie fire
         if lastRogue ~= "" then                                                          -- Did we at least see a rogue?
            TargetByName(lastRogue)                                                       -- Retarget the last rogue
            Druid.Moonfire()                                                              -- Moonfire!
         end                                                                              -- End last rogue check
      end                                                                                 -- End cast faerie fire check
   end;

-- -------------------------------------------------------------------------------------
-- Weakest Link
--    This function checks the 10 closest enemies and finds the one with lowest health
--    that enemy is then targeted.
-- -------------------------------------------------------------------------------------

   weakestLink = function( healerOnly )

      local ktr = 0                                                                       -- Counter variable.
      local bestTargetName = nil                                                          -- Best target
      local bestTargetHealth = 100                                                        -- Best target's health
      local bestHealerName = nil                                                          -- Name of the lowest healer
      local bestHealerHealth = 100                                                        -- health of the lowest healer
      local name = nil                                                                    -- Name of the current target
      local health = 100                                                                  -- Health (percent) of the current target

      for ktr = 1, 10, 1 do				                                                        -- For each of 10 targets....
         TargetNearestEnemy()				                                                      -- TargetNearestEnemy (wow api)
         name = UnitName( DF_TARGET)                                                       -- Name of the current target
         if name ~= nil then                                                              -- If we're actually targeting something
            health = UnitHealth(DF_TARGET)                                                 -- Get it's health (percent)
            local localizedClass, englishClass = UnitClass(DF_TARGET);                     -- Get the class of our target
            if health <= bestTargetHealth then                                            -- If it's lower than the one we have saved
               bestTargetHealth = health                                                  -- Save the curren't target's health
               bestTargetName = name                                                      -- and name
               if healerOnly then                                                         -- are we only looking for healers? 
                  local localizedClass, englishClass = UnitClass(DF_TARGET);               -- Get the class of our target
                  if (englishClass == "PRIEST") or (englishClass == "DRUID") or (englishClass == "PALADIN") or (englishClass == "SHAMAN") then
                     if health <= bestHealerHealth then
                        bestHealerHealth = health
                        bestHealerName = name
                     end
                  end
               end
            end                                                                           -- End is this the best target check
         else                                                                             -- If we didn't get a target
            break                                                                         -- Break out of the loop
         end                                                                              -- End do we have a name check
      end                                                                                 -- end for loop
       
      if bestTargetName ~= nil then                                                       -- Did we find a target?
         TargetByName(bestTargetName)                                                     -- Retarget it then
         if healerOnly then
            if bestHealerName ~= nil then
               TargetByName(bestHealerName)
            end
         end
      end                                                                                 -- End did we find a target check.

   end;

-- -------------------------------------------------------------------------------------
-- Shift/drink potion/shift function
--    By Salex
-- -------------------------------------------------------------------------------------

   dumpI = function()
      for i = 0, 4, 1 do
         maxSlots = GetContainerNumSlots(i)
         for ktr = 0, maxSlots, 1 do
            local texture, itemCount, locked, quality, readable = GetContainerItemInfo(1,2);
            linktext = GetContainerItemLink(i, ktr);
            if linktext then
               local _,_,name = string.find(linktext, "^.*%[(.*)%].*$");
               name=string.lower(name);
               DEFAULT_CHAT_FRAME:AddMessage( "item: "..name);
            end
        end
      end
      return -1
   end;

   FindItem = function(item)
      item = string.lower(item)
      for i = 0, 4, 1 do
         maxSlots = GetContainerNumSlots(i)
         for ktr = 0, maxSlots, 1 do
            local texture, itemCount, locked, quality, readable = GetContainerItemInfo(1,2);
            linktext = GetContainerItemLink(i, ktr);
            if linktext == nil then
               linktext = " "
            end
            linktext = string.lower(linktext)
            if linktext then
               local _,_,name = string.find(linktext, "^.*%[(.*)%].*$");
               if name == nil then
                  name = " "
               end
--               DEFAULT_CHAT_FRAME:AddMessage( "item: "..name);
               name=string.lower(name);
               if name == item then
--                  DEFAULT_CHAT_FRAME:AddMessage( "Found: "..ktr);
                  return i, ktr
               end
            end
         end
      end
      return -1, -1
   end;

   ActionReady = function(action)
      local invBag, invLocation = Druid.FindItem(action)
      --Check cooldowns
      if(invLocation ==-1) then -- not an item.. must be a spell..
         local rankName, maxRank, bookIndex, slotIndex = Druid.maxRank(action);
         if(bookIndex==-1) then
            DEFAULT_CHAT_FRAME:AddMessage( DF_ACTIONREADY_WARN_1..action);
            return false
         end

         --DEFAULT_CHAT_FRAME:AddMessage( "Spell not found: "..action.." Slot: "..bookIndex);
         local start, duration = GetSpellCooldown(bookIndex, BOOKTYPE_SPELL);
         if (duration - ( GetTime() - start) > 0.1) then -- If on cooldown return false
            return false;
         end
         return true
      else
         if(GetContainerItemCooldown(invBag,invLocation) ~=0) then
            return false
         end
         return true
      end
   end;

   oldQuickShiftForm = "Humanoid Form";

   QuickShift = function(item, buffName)
      -- Find out what form we are in
      local currentForm, currentName = Druid.GetCurrentForm()
      -- Do we have the buff?
      local haveBuff = Druid.isUnitBuffUp(DF_PLAYER, buffName)
      local invBag, invLocation = Druid.FindItem(item)

      if (haveBuff == true) and (DFUNCShiftPot==false) then
         DEFAULT_CHAT_FRAME:AddMessage( DF_QUICKSHIFT_WARN_1 );
         return
      end
      if (DFUNCShiftPot == false) and not(Druid.ActionReady(item)) then
         DEFAULT_CHAT_FRAME:AddMessage( DF_QUICKSHIFT_WARN_2 );
         return
      end
      
       -- DEFAULT_CHAT_FRAME:AddMessage( "Form: "..currentForm.." buff: "..tostring(haveBuff));
       -- if not:
       if(DFUNCShiftPot == false and Druid.ActionReady(item)) then
         -- If non-caster form, switch out to caster
         if(currentForm ~= 0) then -- not caster form
            oldQuickShiftForm = currentName
            Druid.ShiftHuman()
            currentForm = 0
            return -- Have to wait on server here to get back to us that the shift happened..
         end
         if(currentForm == 0) then
            -- If caster form, cast buff/spell/potion
           if(invLocation == -1) then -- if not an item, then must be a spell
              CastSpellByName(item);
              DFUNCShiftPot=true              
           else
              UseContainerItem(invBag, invLocation);
              DFUNCShiftPot=true
           end
         end
       else
          -- If we have the buff and are in caster form, go to form "form".
          DFUNCShiftPot = false
          if(currentForm == 0) then -- if human form
             -- switch to "form"
             Druid.ChangeShapeshiftForm(oldQuickShiftForm)
          end
       end
   end;

   BearBark = function()
      Druid.QuickShift(DF_BARKSKIN, DF_BEARBARK_POTNAME)
   end;

   PatchwerkTest = function()
      Druid.QuickShift(DF_PATCHWERKTEST_POTNAME, DF_PATCHWERKTEST_POTICON)
   end;

   Patchwerk = function()
      Druid.QuickShift(DF_PATCHWERK_POTNAME, DF_PATCHWERK_POTICON)
   end; 

};                                                                                        -- End DruidFunc


-- -------------------------------------------------------------------------------------
-- End DruidFunc
-- -------------------------------------------------------------------------------------
