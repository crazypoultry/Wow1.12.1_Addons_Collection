-- -------------------------------------------------------------------------------------
-- Druidfunc localization file.
--    Special thanks to KenoKles for providing this template and a french translation 
--    Unfortuantely since so many changes have happened I can't use the french translation
--    he provided and a new one will need to be created :(
--
-- This file is loaded by DruidFunc.xml
-- it is loaded before DruidFunc.lua
-- All the variables here are GLOBAL constants so name carefully because other mods might use your name.
--
-- To create a translation, scroll down to find the area you are making a tranlsation for
-- Change the strings (stuff between the quotes) as you wish.
-- Spell names, totem names, sound names need special care that you get the translation right.
-- the WARN messages (just text sent to the screen) are more forgiving of mistakes.
--
-- Generall if something is all lower case, keep the translation all lower case as well
-- as druidfunc casts many strings all lower case when doing string comparisons.
--
-- Final warning: change the strings, don't touch the variable names.
-- -------------------------------------------------------------------------------------


-- US English (Default)

   -- -------------------------------------------------------------------------------------
   -- These variables extend WoW's keyboard definition panel (Esc, keybindings ingame)
   -- They work hand in hand with the bindings.xlm file in this directory.
   -- -------------------------------------------------------------------------------------

      BINDING_HEADER_DFUNC                           = "DruidFunc Library";
      BINDING_NAME_DFUNC_TotemStomper                = "Totem Stomper";
      BINDING_NAME_DFUNC_MarkRogues                  = "Mark Rogues"
      BINDING_NAME_DFUNC_weakestLink                 = "Target Weakest Link"
      BINDING_NAME_DFUNC_weakestHealer               = "Target Weakest Healer"
      BINDING_NAME_DFUNC_Swiftmend		               = "Swiftmend";
      BINDING_NAME_DFUNC_DesperatePrayer             = "Desperate Heal Self";
      BINDING_NAME_DFUNC_DesperateHeal               = "Desperate Heal Other";
      BINDING_NAME_DFUNC_FaerieFire                  = 'Faerie Fire';
      BINDING_NAME_DFUNC_Hibernate                   = 'Hibernate';
      BINDING_NAME_DFUNC_Moonfire                    = 'Moonfire';
      BINDING_NAME_DFUNC_Starfire                    = 'Starfire';
      BINDING_NAME_DFUNC_Hurricane                   = "Hurricane";
      BINDING_NAME_DFUNC_Wrath                       = 'Wrath';
      BINDING_NAME_DFUNC_MotW                        = 'Mark of the Wild';
      BINDING_NAME_DFUNC_Thorns                      = 'Thorns';
      BINDING_NAME_DFUNC_Roots                       = "Entangling Roots";
      BINDING_NAME_DFUNC_NaturesGrasp                = "Nature's Grasp";
      BINDING_NAME_DFUNC_AbolishPoison               = 'Abolish Poison';
      BINDING_NAME_DFUNC_Tranquility                 = "Tranquility";
      BINDING_NAME_DFUNC_Regrowth                    = 'Regrowth';
      BINDING_NAME_DFUNC_Rejuvenation                = 'Rejuvenation';
      BINDING_NAME_DFUNC_RemoveCurse                 = 'Remove Curse';
      BINDING_NAME_DFUNC_HealingTouch                = 'Healing Touch';
      BINDING_NAME_DFUNC_Barkskin                    = 'Barkskin';
      BINDING_NAME_DFUNC_Innervate                   = 'Innervate';
      BINDING_NAME_DFUNC_ManaMe                      = "Mana Me";
      BINDING_NAME_DFUNC_Human                       = 'Humanoid Form';
      BINDING_NAME_DFUNC_Bear                        = 'Bear Form';
      BINDING_NAME_DFUNC_Cat                         = 'Cat Form';
      BINDING_NAME_DFUNC_Travel                      = 'Travel Form';
      BINDING_NAME_DFUNC_Aqua                        = 'Aquatic Form';
      BINDING_NAME_DFUNC_Moon                        = 'Moonkin Form';
      BINDING_NAME_DFUNC_InsectSwarm                 = 'Insect Swarm';
      BINDING_NAME_DFUNC_Rebirth                     = 'Rebirth';
      BINDING_NAME_DFUNC_Ravage                      = "Ravage";
      BINDING_NAME_DFUNC_Shred                       = "Shred";
      BINDING_NAME_DFUNC_Claw                        = "Claw";
      BINDING_NAME_DFUNC_Rake                        = "Rake";
      BINDING_NAME_DFUNC_Rip                         = "Rip";
      BINDING_NAME_DFUNC_Pounce                      = "Pounce";
      BINDING_NAME_DFUNC_Prowl                       = "Prowl";
      BINDING_NAME_DFUNC_Cower                       = "Cower";
      BINDING_NAME_DFUNC_Dash                        = "Dash";
      BINDING_NAME_DFUNC_FerociousBite               = "Ferocious Bite";
      BINDING_NAME_DFUNC_TigersFury                  = "Tiger's Fury";
      BINDING_NAME_DFUNC_FeralCharge                 = "Feral Charge";
      BINDING_NAME_DFUNC_Maul                        = "Maul";
      BINDING_NAME_DFUNC_Bash                        = "Bash";
      BINDING_NAME_DFUNC_Growl                       = "Growl";
      BINDING_NAME_DFUNC_Swipe                       = "Swipe";
      BINDING_NAME_DFUNC_FrenziedRegen               = "Frenzied Regeneration";
      BINDING_NAME_DFUNC_DemRoar                     = "Demoralizing Roar";
      BINDING_NAME_DFUNC_ChalRoar                    = "Challenging Roar";
      BINDING_NAME_DFUNC_Enrage                      = "Enrage";
      BINDING_NAME_DFUNC_PowerTouch                  = "Power Touch";
      BINDING_NAME_DFUNC_BestCat                     = "Best Attack Cat";
      BINDING_NAME_DFUNC_EquipCat                    = "Equip Cat Form Outfit"
      BINDING_NAME_DFUNC_EquipBear                   = "Equip Bear Form Outfit"
      BINDING_NAME_DFUNC_EquipHuman                  = "Equip Human Form Outfit"
      BINDING_NAME_DFUNC_EquipPvP                    = "Equip PvP Outfit"
      BINDING_NAME_DFUNC_EquipWSG                    = "Equip WSG Outfit"
      BINDING_NAME_DFUNC_EquipMoon                   = "Equip Moonkin Form Outfit"
      BINDING_NAME_DFUNC_EquipTravel                 = "Equip Travel Form Outfit"
      BINDING_NAME_DFUNC_EquipMount                  = "Equip Mounted Outfit"
      BINDING_NAME_DFUNC_EquipAqua                   = "Equip Aquatic Form Outfit"
      BINDING_NAME_DFUNC_EquipFire                   = "Equip Fire Resist Outfit"
      BINDING_NAME_DFUNC_EquipArcane                 = "Equip Arcane Resist Outfit"
      BINDING_NAME_DFUNC_EquipFrost                  = "Equip Frost Resist Outfit"
      BINDING_NAME_DFUNC_EquipShadow                 = "Equip Shadow Resist Outfit"
      BINDING_NAME_DFUNC_EquipHeal                   = "Equip Healing Outfit"
      BINDING_NAME_DFUNC_EquipNature                 = "Equip Nature Resist Outfit"
      BINDING_NAME_DFUNC_EquipSpecial1               = "Equip Special1 Outfit"
      BINDING_NAME_DFUNC_EquipSpecial2               = "Equip Special2 Outfit"
      BINDING_NAME_DFUNC_EquipSpecial3               = "Equip Special3 Outfit"

   -- -------------------------------------------------------------------------------------
   -- Spells and druid capabilities
   -- -------------------------------------------------------------------------------------
      DF_SHADOWMELD                                     = "Shadowmeld(Racial)"
      DF_HEALINGTOUCH                                   = "Healing Touch"
      DF_REJUVENATION                                   = "Rejuvenation"
      DF_REGROWTH                                       = "Regrowth"
      DF_THORNS                                         = "Thorns"
      DF_MOTW                                           = "Mark of the Wild"
      DF_MOONFIRE                                       = "Moonfire"
      DF_STARFIRE                                       = "Starfire"
      DF_WRATH                                          = "Wrath"
      DF_INSECTSWARM                                    = "Insect Swarm"
      DF_FAERIEFIRE                                     = "Faerie Fire"
      DF_FAERIEFIREFERAL                                = "Faerie Fire (Feral)"
      DF_HIBERNATE                                      = "Hibernate"
      DF_REBIRTH                                        = "Rebirth"
      DF_NATURESGRASP                                   = "Nature's Grasp"
      DF_HURRICANE                                      = "Hurricane"
      DF_TRANQUILITY                                    = "Tranquility"
      DF_ROOTS                                          = "Entangling Roots"
      DF_RAVAGE                                         = "Ravage"
      DF_SHRED                                          = "Shred"
      DF_CLAW                                           = "Claw"
      DF_PROWL                                          = "Prowl"
      DF_RAKE                                           = "Rake"
      DF_POUNCE                                         = "Pounce"
      DF_COWER                                          = "Cower"
      DF_DASH                                           = "Dash"
      DF_RIP                                            = "Rip"
      DF_FEROCIOUSBITE                                  = "Ferocious Bite"
      DF_FERALCHARGE                                    = "Feral Charge"
      DF_TIGERSFURY                                     = "Tiger's Fury"
      DF_MAUL                                           = "Maul"
      DF_BASH                                           = "Bash"
      DF_SWIPE                                          = "Swipe"
      DF_FRENZIEDREGEN                                  = "Frenzied Regeneration"
      DF_DEMROAR                                        = "Demoralizing Roar"
      DF_OMEN                                           = "Omen"
      DF_SWIFTMEND                                      = "Swiftmend"
      DF_NATURESWIFTNESS                                = "Nature's Swiftness"
      DF_INNERVATE                                      = "Innervate"
      DF_AQUAFORM                                       = "Aquatic Form"
      DF_TRAVELFORM                                     = "Travel Form"
      DF_HUMANFORM                                      = "Humanoid Form";
      DF_BEARFORM                                       = "Bear Form";
      DF_CATFORM                                        = "Cat Form";
      DF_MOONFORM                                       = "Moonkin Form";
      DF_INNERVATE                                      = "Innervate"
      DF_BARKSKIN                                       = "Barkskin"
      DF_GROWL                                          = "Growl"
      DF_ENRAGE                                         = "Enrage"
      DF_CHALROAR                                       = "Challenging Roar"
      DF_DEMROAR                                        = "Demoralizing Roar"
      DF_TRACKHUMANOIDS                                 = "Track Humanoids"
      DF_ABOLISHPOISON                                  = "Abolish Poison"
      DF_REMOVECURSE                                    = "Remove Curse"
      DF_TELEPORTMOONGLADE                              = "Teleport: Moonglade"

      -- These are strings for castspell by name with a rank      

      DF_MOTWRANK     = "Mark of the Wild(Rank "                                    -- Cast string for motw
      DF_THORNSRANK   = "Thorns(Rank "
      DF_REJUVRANK    = "Rejuvenation(Rank "
      DF_HTRANK       = "Healing Touch(Rank "
      DF_MOONFIRERANK = "Moonfire(Rank "
      DF_MOONFIRERANK2= "Moonfire(Rank 2)"


      DF_ATTACK                                         = "Attack"
      DF_PLAYER                                         = "player"
      DF_TARGET                                         = "target"

      DFUNC_Slots    = {"Head","Neck","Shoulder","Shirt","Chest","Waist","Legs","Feet","Wrist","Hands","Finger0","Finger1","Trinket0","Trinket1","Back","MainHand","SecondaryHand","Ranged","Tabard"};
      DF_SLOT        = "Slot"                                                   -- This is appended to the string in slots (HeadSlot, Trinket0Slot, etc...)
      DF_TRINKET0SLOT= "Trinket0Slot"
      DF_TRINKET1SLOT= "Trinket1Slot"
      DF_MAINHANDSLOT= "MainHandSlot"

      DF_DFunc_TooltipTextLeft = "DFunc_TooltipTextLeft"                        -- Tooltip string
      
      
      DF_SAY = "say"                                                            -- Chat destination
      DF_RAID= "raid"                                                           -- Chat destination
      DF_PARTY="party"                                                          -- Chat destination
      DF_WHISPER="WHISPER"                                                      -- Chat destination
      
      -- -------------------------------------------------------------------------------------
      -- Player types/Monster types/set names
      -- -------------------------------------------------------------------------------------

      DF_MAGE                                           = "Mage"
      DF_PRIEST                                         = "Priest"
      DF_DRUID                                          = "Druid"
      DF_BEAST                                          = "Beast"
      DF_ROGUE                                          = "Rogue"
      DF_DRAGONKIN                                      = "Dragonkin"
      
      -- Various player forms and sets
      DF_CAT = "cat"
      DF_BEAR= "bear"
      DF_HUMAN="humanoid"
      DF_HUMANHUMAN="human"
      DF_MOON="moonkin"
      DF_TRAVEL="travel"
      DF_AQUA = "aqua"
      DF_FIRE = "fire"
      DF_NATURE="nature"
      DF_MOUNT = "mount"
      DF_I = "innervate"
      DF_MANA = "mana"
      DF_PVP = "pvp"
      DF_WSG = "wsg"
      DF_FROST = "frost"
      DF_ARCANE= "arcane"
      DF_HEAL = "heal"
      DF_SHADOW = "shadow"
      DF_SPECIAL1 = "special1"
      DF_SPECIAL2 = "special2"
      DF_SPECIAL3 = "special3"
      DF_TEMP     = "temp"
      

      -- -------------------------------------------------------------------------------------
      -- These are various trinkets and items which druidfunc monitors
      -- They tend to have long real names so I use short abreviations
      -- Generally if you don't understand what the name is, it's probably a trinket.
      -- -------------------------------------------------------------------------------------
      DF_IOR = "idol of rejuvenation"                                           -- String checks in the equipment read (for +heal)
      DF_HC  = "hibernation Crystal"                                            -- case is important, it must be lower case
      DF_ZHC = "zandalarian hero charm"
      DF_BMO = "brilliant mana oil"
      DF_DT  = "Defiler's Talisman"
      DF_MARLISEYE                                      = "Mar'li's Eye"
      DF_WUSHCHARMNATURE                                = "Wushoolay's Charm of Nature"
      DF_HC_BUFF = "nimble healing touch"                                       -- This is the buff name when the zandalar class trinket is used.
      DF_WSG_FLAG_A = "silverwing flag"
      DF_WSG_FLAG_H = "warsong flag"
      DF_RUNEMETAMORPH                                  = "Rune of Metamorphosis"
      DF_UNSTABLE_POWER                                 = "Unstable Power"      -- Zandalarian Hero charm buff name
      DF_HIBERNATION                                    = "Healing of the Ages" -- Hibernation crystal
      DF_ABILITY_MOUNT                                  = "Ability_Mount"       -- Icon name of player mount
      DF_JUNGLE_TIGER                                   = "JungleTiger"         -- Druid's Tiger's fury icon (which looks like a mount if we don't look for it)
      DF_DEFILERTALISMAN                                = "Defiler's Talisman"
      
      
      -- -------------------------------------------------------------------------------------
      -- This is the name of a blizzard sound clip that's played when rejuv fails
      -- Dunno if it needs to be changed for international versions but it's here just in case
      -- -------------------------------------------------------------------------------------
      DF_DEATHBIND_SOUND = "Deathbind Sound"

      -- -------------------------------------------------------------------------------------
      -- This section is for the scangump procedure which scans the character and extracts the set bonuses
      -- If you're going to have a translation bug it will most likely be here.
      -- -------------------------------------------------------------------------------------
      DF_MP5_1 = "mana per %d+ sec"                                             -- regular expression to find mana per 5
      DF_MP5_2 = "mana regen %d+ per %d+ sec"
      
      DF_HDB   = "healing done by"                                              -- Regular expresion to find healing done by (item)
      DF_UPTO  = "up to %d+"
      DF_HEAL_1= "healing spells %+"                                            -- Regular expression to find healing done by (item)                                             
      DF_SET   = ") set"
      DF_SET2  = "set:"
      DF_CREJUV= "rejuvenation"
      DF_HEAL_3= "healing spells %+%d+"
      DF_HEAL_2= "%+%d+ healing spells"
   
      -- -------------------------------------------------------------------------------------
      -- Wow GUI messages (should match messages return by the wow interface)
      -- -------------------------------------------------------------------------------------
      DF_CANTWHENSWIM                                   = "Cannot use while swimming"
      DF_ONLYWHENSWIM                                   = "Can only use while swimming"

      DF_UI_ERROR_MESSAGE                               = "UI_ERROR_MESSAGE"
      DF_LEARNED_SPELL_IN_TAB                           = "LEARNED_SPELL_IN_TAB"
      DF_SPELLCAST_START                                = "SPELLCAST_START"
      DF_SPELLCAST_STOP                                 = "SPELLCAST_STOP"
      DF_SPELLCAST_INTERRUPTED                          = "SPELLCAST_INTERRUPTED"
      DF_SPELLCAST_FAILED                               = "SPELLCAST_FAILED"
      DF_PLAYER_REGEN_ENABLED                           = "PLAYER_REGEN_ENABLED"
      DF_UNIT_INVENTORY_CHANGED                         = "UNIT_INVENTORY_CHANGED"
      DF_PLAYER_ENTERING_WORLD                          = "PLAYER_ENTERING_WORLD"
      DF_PLAYER_AURAS_CHANGED                           = "PLAYER_AURAS_CHANGED"
      DF_PLAYER_UNGHOST                                 = "PLAYER_UNGHOST"
      DF_PLAYER_ALIVE                                   = "PLAYER_ALIVE"
      DF_SPELLCAST_CHANNEL_STOP                         = "SPELLCAST_CHANNEL_STOP"

      DF_ANCHOR_NONE                                    = "ANCHOR_NONE"
      
   -- -------------------------------------------------------------------------------------
   -- Information messages send to the user
   -- -------------------------------------------------------------------------------------
      DF_WELCOME1                                       = "DruidFunc: DruidFunc Library Version "
      DF_WELCOME2                                       = " loaded." 

      DF_HEALRANGE                                      = "DruidFunc: Heal Range mod was found -- raid functionality altered!"

      DF_BASE_HUMAN                                     = "DruidFunc: Base armor set changed back to humanoid."
      DF_CASTING_REGROWTH_1                             = "DruidFunc: Casting Regrowth on "
      DF_CASTING_REGROWTH_2                             = ". (Regrowth rank "
      DF_CASTING_REGROWTH_3                             = "Regrowth(Rank "

      DF_FAILCAST                                       = "DruidFunc: Can not cast on this target right now (out of range, line of sight)"
      
      DF_REJUV_WARN_1                                   = "DruidFunc: Rejuvenation already on "
      DF_REJUV_WARN_2                                   = " press again to swiftmend!"
      DF_REJUV_WARN_3                                   = ", press again to refresh."
      DF_REJUV_WARN_4                                   = "DruidFunc: HoT on "
      DF_REJUV_WARN_5                                   = ". (Rejuvenation Rank "

      DF_SWIFTMEND_WARN_1                               = "DruidFunc: Target has no HoTs.   Casting Rejuvenation"
      DF_SWIFTMEND_WARN_2                               = "DruidFunc: Swiftmend is on cooldown!"
      DF_SWIFTMEND_WARN_3                               = "DruidFunc: You haven't learned swiftmend."

      DF_DERANK_WARN_1                                  = "Low Mana.  Need rank "
      DF_DERANK_WARN_2                                  = ".  Best cast rank "

      DF_HT_WARN_1                                      = "DruidFunc: Healing "
      DF_HT_WARN_2                                      = ". (Rank "
      DF_HT_WARN_3                                      = " heal/"
      DF_HT_WARN_4                                      = " needed. "
      DF_HT_WARN_4_1                                    = " max health."
      DF_HT_WARN_5                                      = "DruidFunc: Mana Conserve aborted the heal. Target @ "
      DF_HT_WARN_6                                      = "% abort set to "
      DF_HT_WARN_7                                      = "DruidFunc: Full Heal rank "
      DF_HT_WARN_8                                      = " (target health: "
      DF_HT_WARN_9                                      = ", health max: "
      DF_HT_WARN_10                                     = ", curr Health: "
      
      DF_I_WARN_1                                       = "DruidFunc: Innervate is on cooldown."
      DF_I_WARN_2                                       = "DruidFunc: Innervate already on "
      DF_I_WARN_3                                       = ".  Aborted"
      DF_I_WARN_4                                       = "DruidFunc: Innervate aborted.  "
      DF_I_WARN_5                                       = " has more than 50% mana"
      DF_I_WARN_6                                       = "DruidFunc: Casting Innervate on "

      DF_HIBERNATE_WARN_1                               = "DruidFunc: Casting hibernate (CC) on "
      DF_HIBERNATE_WARN_2                               = " <DO NOT ATTACK!>"
      DF_HIBERNATE_WARN_3                               = "DruidFunc: Invalid hibernation target."      
   
      DF_REBIRTH_WARN_1                                 = "DruidFunc: Resurrecting "
      DF_REBIRTH_WARN_2                                 = "DruidFunc: Invalid Rebirth target."
      
      DF_PRAYER_WARN_1                                  = "DruidFunc: Rejuvenation done, press again for swiftmend!"

      DF_PROWL_WARN_1                                   = "DruidFunc: Prowling not allowed while you have the WSG flag."
      
      DF_ASSIST_WARN_1                                  = "DruidFunc: Assist Failed... Not Visible or doesn't exist or not hostile"
      DF_ASSIST_WARN_2                                  = "DruidFunc: Assist Failed... Out of Range"
      DF_ASSIST_WARN_3                                  = "DruidFunc: Assist Failed... Assist is dead or bad target."
      DF_ASSIST_WARN_4                                  = "DruidFunc: Assist failed...  The person you are assisting is not in combat."
      
      DF_ACTIONREADY_WARN_1                             = "Spell or Item not found: "
      
      DF_QUICKSHIFT_WARN_1                              = "You already have that potion effect"
      DF_QUICKSHIFT_WARN_2                              = "That item is on cooldown and can not be used right now."
      
      DF_BEARBARK_POTNAME                               = "Spell_Nature_StoneClawTotem"
      
      DF_PATCHWERK_POTNAME                              = "greater stoneshield potion"
      DF_PATCHWERK_POTICON                              = "INV_Potion_69"
      
      DF_PATCHWERKTEST_POTNAME                          = "lesser stoneshield potion"
      DF_PATCHWERKTEST_POTICON                          = "INV_Potion_67"            

      DF_OFF                                            = "off"
      DF_ON                                             = "on"
      DF_AUTO                                           = "auto"
      
      DF_ICHAT                                          = "You've been innervated!   Cast normally for best results."

    -- -------------------------------------------------------------------------------------
    -- These hold the totem stomper stirings
    -- -------------------------------------------------------------------------------------

      DF_TOTEM_SENTRY     = "sentry totem"
      DF_TOTEM_WINDWALL   = "windwall totem"
      DF_TOTEM_FIRE       = "fire resistance totem"
      DF_TOTEM_FROST      = "frost resistance totem"
      DF_TOTEM_HEAL       = "healing totem"
      DF_TOTEM_POISON     = "poison clensing totem"
      DF_TOTEM_DISEASE    = "disease clesning totem"
      DF_TOTEM_STRENGTH   = "strength of earth totem"
      DF_TOTEM_STONECLAW  = "stoneclaw totem"
      DF_TOTEM_NATURE     = "nature resistance totem"
      DF_TOTEM_GRACE      = "grace of air totem"
      DF_TOTEM_STONESKIN  = "stoneskin totem"
      DF_TOTEM_EARTHBIND  = "earthbind totem"
      DF_TOTEM_MOONFLARE  = "moonflare totem"
      DF_TOTEM_GROUNDING  = "grounding totem"
      DF_TOTEM_SEARING    = "searing totem"
      DF_TOTEM_MAGMA      = "magma totem"
      DF_TOTEM_FIRENOVA   = "fire nova totem"
      DF_TOTEM_HEALSTREAM = "healing stream totem"
      DF_TOTEM_WINDFURY   = "windfury totem"
      DF_TOTEM_MANASPRING = "mana spring totem"
      DF_TOTEM_MANATIDE   = "mana tide totem"
      DF_TOTEM_TREMOR     = "tremor totem"
      DF_TOTEM_HEALWARD   = "healing ward"
      DF_TOTEM_BRAINWASH  = "brain wash totem"
      DF_TOTEM_POWERFUL   = "powerful healing ward"
      DF_TOTEM_LIGHTNING  = "lightning totem"

      DF_TOTEM_TOTEMIC    = "totemic"
      DF_TOTEM_TOTEM      = " totem"
      DF_TOTEM_WARD       = " ward"

    -- -------------------------------------------------------------------------------------
    -- These strings are the varions /druid and /df commands
    -- -------------------------------------------------------------------------------------

      DF_DRUID1   = "/DRUID"                                                    -- The /druid slash command
      DF_DRUID2   = "/DF"                                                       -- The /druid shortcut
      
      -- /druid home
      DF_HOME = "home"                                                          -- Command -- /df home = use hearthstone
      DF_HEARTHSTONE = "Hearthstone"                                            -- And the hearthstone itself
      DF_HOME_WARN_1 = "DruidFunc: Using Hearthstone."
      DF_HOME_WARN_2 = "DruidFunc: Hearthstone is on cooldown.  Failed."
      
      -- /druid port, /druid moonglade -- command -- cast teleport: moonglade
      DF_PORT = "port"                                                         
      DF_MOONGLADE = "moonglade"
      DF_PORT_WARN_1 = "DruidFunc: Teleport->Moonglade"
      
      -- /druid intro
      
      DF_DCMD_WARN_1 = "Use /druid (command) to get help for a specific command.   /druid moonbar, /druid smartcast, etc"
      DF_DCMD_WARN_2 = "Use /druid stats to get info about your character."
      
      DF_DCMD_WARN_3 = "/druid moonglade -- command, port to moonglade"
      DF_DCMD_WARN_4 = "/druid port -- command, port to moonglade"
      DF_DCMD_WARN_5 = "/druid home -- command, use hearthstone"
      
      -- /druid stats
      DF_STATS = "stats"
      DF_STATS_WARN_1 = "Your present +heal value from items: "
      DF_MANAREGEN = "mana regeneration"
      DF_STATS_WARN_2 = "Your present mana/5 value from items: "
      DF_STATS_WARN_3 = "Your present spirit regen (outside the 5 sec rule): "
      DF_STATS_WARN_4 = "Innervate will return around : "
      DF_STATS_WARN_5 = " mana (disregarding reflection and tier 2 set bonus)"
      
      -- /druid ichat
      DF_ICHATFLAG = "ichat"
      DF_ICHAT_WARN_1 = "Ichat saves the message you'd like to send your innervate targets."
      DF_ICHAT_WARN_2 = "usage: /druid ichat you've been innervated, keep casting normally for best results."
      DF_ICHAT_WARN_3 = "/druid ichat Innervate Whisper Message: "
      
      -- /druid plusheal
      DF_PLUSHEAL = "plusheal"
      DF_PLUSHEAL_WARN_1 = "/druid plusheal [off/auto/#]"
      DF_PLUSHEAL_WARN_2 = "This sets the healing touch offset.   Use off or zero to disable"
      DF_PLUSHEAL_WARN_3 = "Auto will calculate the value based on the +healing value of your gear"
      DF_PLUSHEAL_WARN_4 = "You can specify a number as well 200 or -200.  Positive numbers cause you to use"
      DF_PLUSHEAL_WARN_5 = "lower ranks of healing touch, positive numbers cause you to use higher ranks." 
      DF_PLUSHEAL_WARN_6 = "It's recommended this be off until you have more than 200 then use auto."
      DF_PLUSHEAL_WARN_7 = "/druid plusheal [auto/off/number] (Set healing touch offset) is: "
      
      -- /druid hardshift
      DF_HARDSHIFT = "hardshift"
      DF_HARDSHIFT_WARN_1 = "When on prevents the shift bear/cat keys/macros from shifting you out of form" 
      DF_HARDSHIFT_WARN_2 = "When off toggles you between requested form and humanoid."
      DF_HARDSHIFT_WARN_3 = "/druid hardshift [on/off]"
      DF_HARDSHIFT_WARN_4 = "/druid hardshift [on/off] (change shapeshift key functionality) is: "

      -- /druid assist                      (Note we use DF_SASSIST for slash assist here, because the assist function has it's own warn messages)
      DF_SASSIST = "assist"
      DF_SASSIST_WARN_1 = "Use /druid assist off to disable | Use /druid assist on to re-enable using last assist"
      DF_SASSIST_WARN_2 = "Use /druid assist <name> to set a spellcast assist (and enable assisting)"
      DF_SASSIST_WARN_3 = "/druid assist [on/off/name] (set spellcasting assist) is set to: "
      
      -- /druid manac
      DF_MANAC = "manac"
      DF_MANAC_WARN_1 = "ManaC [off/silent/announce/10-100]" 
      DF_MANAC_WARN_2 = "Sets the health threashold that will abort a healing touch spell.  For instance"
      DF_MANAC_WARN_3 = "/druid manac 90 will abort healing touch if the target's health is over 90%"
      DF_MANAC_WARN_4 = "silent will keep aborts from being announced in the chat box, announce turns abort messages on."
      DF_MANAC_WARN_5 = "silent (no announce in chat box)"
      DF_MANAC_WARN_6 = "announce (aborts appear in chat box)"
      DF_MANAC_WARN_7 = "/druid manac [off/silent/announce/10-100] is set to: "
      DF_SILENT = "silent"
      DF_ANNOUNCE = "announce"
      
      -- /druidmanaswap
      DF_MANASWAP = "manaswap"
      DF_MANASWAP_WARN_1 = "Manaswap sets the threshold low mana weapon swaps happen." 
      DF_MANASWAP_WARN_2 = "The default is 85 which means when your mana pool falls below 85%"
      DF_MANASWAP_WARN_3 = "The low mana weapon set will be equipped.   Valid values are 0-100."
      DF_MANASWAP_WARN_4 = "0 basically disables this functionality, 100 is just wierd."
      DF_MANASWAP_WARN_5 = "/druid manaswap [0-100] (Low mana swap threshold) is set to: "

      -- /druidmoonbar
      DF_MOONBAR = "moonbar"
      DF_MOONBAR_WARN_1 = "Moonbar sets the toolbar that will be switched to when you" 
      DF_MOONBAR_WARN_2 = "switch to the moonkin form.   The toolbars are 1-6."
      DF_MOONBAR_WARN_3 = "Setting moonbar to 0 will disable toolbar switching entierly."
      DF_MOONBAR_WARN_4 = "/druid moonbar [0-5] (Moonkin action bar) is set to: "

      -- /druid smartcast
      DF_SMARTCAST = "smartcast"
      DF_SMARTCAST_WARN_1 = "Smartcast will change the casting target automatically in certian situations." 
      DF_SMARTCAST_WARN_2 = "If you cast a heal on a hostile target, the heal will be redirected to the person your hostile target is targeting."
      DF_SMARTCAST_WARN_3 = "If you cast a damage spell on a friendly target, the spell will be redirected to the friendly target's target"
      DF_SMARTCAST_WARN_4 = "Smartcasting off disables this functionality."
      DF_SMARTCAST_WARN_5 = "/druid smartcast [on/off] (auto target assist) is set to : on"
      DF_SMARTCAST_WARN_6 = "/druid smartcast [on/off] (auto target assist) is set to : off"

      -- /druid target     (note we use DF_STARGET here because DF_TARGET is an actual command (player's target) that we use elsewhere )
      DF_STARGET = "target"
      DF_STARGET_WARN_1 = "When on will target yourself if you hit the humanoid key while already in human form." 
      DF_STARGET_WARN_2 = "When off will attempt to self-cast heals (similar to desperate prayer) without"
      DF_STARGET_WARN_3 = "losing your target.  If you play a cat often /druid target off is prefered." 
      DF_STARGET_WARN_4 = "/druid target [on/off] is set to : on (target self when humanoid key pressed)"
      DF_STARGET_WARN_5 = "/druid target [on/off] is set to : off (cast self-heal when humanoid key is pressed)" 

      -- /druid trinkets
      DF_TRINKETS = "trinkets"
      DF_TRINKETS_WARN_1 = "If you set trinkets to on then druidfunc will try to use some common"             
      DF_TRINKETS_WARN_2 = "trinkets durring common actions.  For instance it will always try to use"             
      DF_TRINKETS_WARN_3 = "the hibernation crystal when you cast a heal and rune of metamorphasis"             
      DF_TRINKETS_WARN_4 = "when you shapeshift.  The allowed values are on and off."             
      DF_TRINKETS_WARN_5 = "/druid trinkets [on/off] (auto trinket usage) is set to : on"            
      DF_TRINKETS_WARN_6 = "/druid trinkets [on/off] (auto trinket usage) is set to : off"             

      -- /druid prayer   (note we use SPRAYER to avoid conflicts elsehwere)
      DF_SPRAYER = "prayer"      
      DF_SPRAYER_WARN_1 = "Specifies the percentage of your (or your target's health) before" 
      DF_SPRAYER_WARN_2 = "desperate healing starts burning your cooldown.   /druid prayer 50 means"
      DF_SPRAYER_WARN_3 = "the target must be at 50% health or less before your cooldowns will be used."
      DF_SPRAYER_WARN_4 = "/druid prayer [25-100] (desperate heal, health threshold) is: "
      
      -- -------------------------------------------------------------------------------------
      -- DOUTFIT area
      -- -------------------------------------------------------------------------------------

      DF_DOUTFIT1 = "/DOutfit"                                                  -- The /doutfit slash command (yes you can change it)
      DF_DOUTFIT2 = "/DO"                                                       -- The /doutfit shortcut

      DF_DO_WEAPON = "weapon"
      DF_DO_OUTFIT = "outfit"
      DF_DO_SAVE   = "save"
      DF_DO_MOON   = "moon"

      DF_DO_WARN_1 = "Usage: /doutfit [on/off/outfit/weapon/{set name}] [off/save]"
      DF_DO_WARN_2 = "Example (save bear set): /doutfit bear save"       
      DF_DO_WARN_3 = "Example (Use fire resist set): /doutfit fire"      
      DF_DO_WARN_4 = "Example (Auto equip only weapons): /doutfit weapon"      
      DF_DO_WARN_5 = "Example (Auto Equip everything): /doutfit outfit"       
      DF_DO_WARN_6 = "Example (Disable automatic equips): /doutfit off"       
      DF_DO_WARN_7 = "Set names: human, bear, cat, aqua, travel, moon, mount, heal, pvp, fire, nature, arcane, frost, shadow, wsg, special1, special2, special3, and Temp"      
      DF_DO_WARN_8 = "DruidFunc: The outfitter is presently on"      
      DF_DO_WARN_9 = "DruidFunc: The outfitter is presently off"       
      DF_DO_WARN_10= "DruidFunc: The outfitter presently is swapping only weapons"       
      DF_DO_WARN_11= "DruidFunc: The outfitter presently is swapping everything, armor and weapons."       
      DF_DO_WARN_12= "DruidFunc: Automatic wardrobe changes have been disabled."
      DF_DO_WARN_13= "DruidFunc: Automatic wardrobe changes will only affect weapons/idols"       
      DF_DO_WARN_14= "DruidFunc: Automatic wardrobe changes will now affect all gear when not in combat"        
      DF_DO_WARN_15= "DruidFunc: Automatic wardrobe changes have been enabled."       
      DF_DO_WARN_16= "DruidFunc: Cat form wardobe is disabled"       
      DF_DO_WARN_17= "DruidFunc: Cat form wardrobe selection saved"        
      DF_DO_WARN_18= "DruidFunc: Base set is now presently Cat set"      
      DF_DO_WARN_19= "DruidFunc: Moonkin form wardobe is disabled"        
      DF_DO_WARN_20= "DruidFunc: Moonkin form wardrobe selection saved"      
      DF_DO_WARN_21= "DruidFunc: Base set is now presently Moonkin set"       
      DF_DO_WARN_22= "DruidFunc: Travel form wardobe is disabled"      
      DF_DO_WARN_23= "DruidFunc: Travel form wardrobe selection saved"       
      DF_DO_WARN_24= "DruidFunc: Base set is now presently Travel Form set"      
      DF_DO_WARN_25= "DruidFunc: Aquatic form wardobe is disabled"       
      DF_DO_WARN_26= "DruidFunc: Aquatic form wardrobe selection saved"       
      DF_DO_WARN_27= "DruidFunc: Base set is now presently Aquatic Form set"       
      DF_DO_WARN_28= "DruidFunc: Bear form wardobe is disabled"       
      DF_DO_WARN_29= "DruidFunc: Bear form wardrobe selection saved"       
      DF_DO_WARN_30= "DruidFunc: Base set is now presently Bear set"       
      DF_DO_WARN_31= "DruidFunc: Human form wardobe is disabled"       
      DF_DO_WARN_32= "DruidFunc: Human form wardrobe selection saved"       
      DF_DO_WARN_33= "DruidFunc: Base set is now presently Humanoid set"       
      DF_DO_WARN_34= "DruidFunc: Low Mana wardobe is disabled"       
      DF_DO_WARN_35= "DruidFunc: Low Mana wardrobe selection saved"     
      DF_DO_WARN_36= "DruidFunc: Base set is now presently the Low Mana set"       
      DF_DO_WARN_37= "DruidFunc: Innervate wardobe is disabled"       
      DF_DO_WARN_38= "DruidFunc: Innervate wardrobe selection saved"       
      DF_DO_WARN_39= "DruidFunc: Base set is now presently the Innervate set"       
      DF_DO_WARN_40= "DruidFunc: Fire resist wardobe is disabled"       
      DF_DO_WARN_41= "DruidFunc: Fire Resist wardrobe selection saved"      
      DF_DO_WARN_42= "DruidFunc: Base set is now presently the Fire Resist set"       
      DF_DO_WARN_43= "DruidFunc: PvP wardobe is disabled"       
      DF_DO_WARN_44= "DruidFunc: PvP wardrobe selection saved"       
      DF_DO_WARN_45= "DruidFunc: Base set is now presently the PvP set"       
      DF_DO_WARN_46= "DruidFunc: Warsong Gulch wardobe is disabled"       
      DF_DO_WARN_47= "DruidFunc: Warsong Gulch wardrobe selection saved"       
      DF_DO_WARN_48= "DruidFunc: Base set is now presently the Warsong Gulch set"       
      DF_DO_WARN_49= "DruidFunc: Nature Resist wardobe is disabled"       
      DF_DO_WARN_50= "DruidFunc: Nature Resist wardrobe selection saved"       
      DF_DO_WARN_51= "DruidFunc: Base set is now presently the Nature Resist set"       
      DF_DO_WARN_52= "DruidFunc: Mounted wardobe is disabled"       
      DF_DO_WARN_53= "DruidFunc: Mounted wardrobe selection saved"      
      DF_DO_WARN_54= "DruidFunc: Base set is now presently the Mounted set"       
      DF_DO_WARN_55= "DruidFunc: Arcane Resist Set is disabled"       
      DF_DO_WARN_56= "DruidFunc: Arcane Resist selection saved"       
      DF_DO_WARN_57= "DruidFunc: Base set is now presently the Arcane Resist Set"       
      DF_DO_WARN_58= "DruidFunc: Shadow Resist Set is disabled"       
      DF_DO_WARN_59= "DruidFunc: Shadow Resist selection saved"     
      DF_DO_WARN_60= "DruidFunc: Base set is now presently the Shadow Resist Set"       
      DF_DO_WARN_61= "DruidFunc: Frost Resist set  is disabled"        
      DF_DO_WARN_62= "DruidFunc: Frost Resist Set selection saved"       
      DF_DO_WARN_63= "DruidFunc: Base set is now presently the Frost Resistance Set"       
      DF_DO_WARN_64= "DruidFunc: Healing set is disabled"       
      DF_DO_WARN_65= "DruidFunc: Healing Set selection saved"       
      DF_DO_WARN_66= "DruidFunc: Base set is now presently the Healing Set"       
      DF_DO_WARN_67= "DruidFunc: Temporary set is disabled"       
      DF_DO_WARN_68= "DruidFunc: Temporary Set selection saved"       
      DF_DO_WARN_69= "DruidFunc: Base set is now presently your Temporary Set"       
      DF_DO_WARN_70= "DruidFunc: User Defined set 1  is disabled"        
      DF_DO_WARN_71= "DruidFunc: User defined set 1 selection saved"       
      DF_DO_WARN_72= "DruidFunc: Base set is now presently the user defined set 1"       
      DF_DO_WARN_73= "DruidFunc: User Defined set 2 is disabled"       
      DF_DO_WARN_74= "DruidFunc: User defined set 2 selection saved"       
      DF_DO_WARN_75= "DruidFunc: Base set is now presently the user defined set 2"       
      DF_DO_WARN_76= "DruidFunc: User Defined set 3 is disabled"       
      DF_DO_WARN_77= "DruidFunc: User defined set 3 selection saved"       
      DF_DO_WARN_78= "DruidFunc: Base set is now presently the user defined set 3"       


-- -------------------------------------------------------------------------------------
-- French translation
--     Loaded if the client is french
-- -------------------------------------------------------------------------------------

   if (GetLocale() == "frFR") then
      -- -------------------------------------------------------------------------------------
      -- These variables extend WoW's keyboard definition panel (Esc, keybindings ingame)
      -- They work hand in hand with the bindings.xlm file in this directory.
      -- -------------------------------------------------------------------------------------
   
         BINDING_HEADER_DFUNC                           = "DruidFunc Library";
         BINDING_NAME_DFUNC_TotemStomper                = "Totem Stomper";
         BINDING_NAME_DFUNC_MarkRogues                  = "Mark Rogues"
         BINDING_NAME_DFUNC_weakestLink                 = "Target Weakest Link"
         BINDING_NAME_DFUNC_weakestHealer               = "Target Weakest Healer"
         BINDING_NAME_DFUNC_Swiftmend		               = "Swiftmend";
         BINDING_NAME_DFUNC_DesperatePrayer             = "Desperate Heal Self";
         BINDING_NAME_DFUNC_DesperateHeal               = "Desperate Heal Other";
         BINDING_NAME_DFUNC_FaerieFire                  = 'Faerie Fire';
         BINDING_NAME_DFUNC_Hibernate                   = 'Hibernate';
         BINDING_NAME_DFUNC_Moonfire                    = 'Moonfire';
         BINDING_NAME_DFUNC_Starfire                    = 'Starfire';
         BINDING_NAME_DFUNC_Hurricane                   = "Hurricane";
         BINDING_NAME_DFUNC_Wrath                       = 'Wrath';
         BINDING_NAME_DFUNC_MotW                        = 'Mark of the Wild';
         BINDING_NAME_DFUNC_Thorns                      = 'Thorns';
         BINDING_NAME_DFUNC_Roots                       = "Entangling Roots";
         BINDING_NAME_DFUNC_NaturesGrasp                = "Nature's Grasp";
         BINDING_NAME_DFUNC_AbolishPoison               = 'Abolish Poison';
         BINDING_NAME_DFUNC_Tranquility                 = "Tranquility";
         BINDING_NAME_DFUNC_Regrowth                    = 'Regrowth';
         BINDING_NAME_DFUNC_Rejuvenation                = 'Rejuvenation';
         BINDING_NAME_DFUNC_RemoveCurse                 = 'Remove Curse';
         BINDING_NAME_DFUNC_HealingTouch                = 'Healing Touch';
         BINDING_NAME_DFUNC_Barkskin                    = 'Barkskin';
         BINDING_NAME_DFUNC_Innervate                   = 'Innervate';
         BINDING_NAME_DFUNC_ManaMe                      = "Mana Me";
         BINDING_NAME_DFUNC_Human                       = 'Humanoid Form';
         BINDING_NAME_DFUNC_Bear                        = 'Bear Form';
         BINDING_NAME_DFUNC_Cat                         = 'Cat Form';
         BINDING_NAME_DFUNC_Travel                      = 'Travel Form';
         BINDING_NAME_DFUNC_Aqua                        = 'Aquatic Form';
         BINDING_NAME_DFUNC_Moon                        = 'Moonkin Form';
         BINDING_NAME_DFUNC_InsectSwarm                 = 'Insect Swarm';
         BINDING_NAME_DFUNC_Rebirth                     = 'Rebirth';
         BINDING_NAME_DFUNC_Ravage                      = "Ravage";
         BINDING_NAME_DFUNC_Shred                       = "Shred";
         BINDING_NAME_DFUNC_Claw                        = "Claw";
         BINDING_NAME_DFUNC_Rake                        = "Rake";
         BINDING_NAME_DFUNC_Rip                         = "Rip";
         BINDING_NAME_DFUNC_Pounce                      = "Pounce";
         BINDING_NAME_DFUNC_Prowl                       = "Prowl";
         BINDING_NAME_DFUNC_Cower                       = "Cower";
         BINDING_NAME_DFUNC_Dash                        = "Dash";
         BINDING_NAME_DFUNC_FerociousBite               = "Ferocious Bite";
         BINDING_NAME_DFUNC_TigersFury                  = "Tiger's Fury";
         BINDING_NAME_DFUNC_FeralCharge                 = "Feral Charge";
         BINDING_NAME_DFUNC_Maul                        = "Maul";
         BINDING_NAME_DFUNC_Bash                        = "Bash";
         BINDING_NAME_DFUNC_Growl                       = "Growl";
         BINDING_NAME_DFUNC_Swipe                       = "Swipe";
         BINDING_NAME_DFUNC_FrenziedRegen               = "Frenzied Regeneration";
         BINDING_NAME_DFUNC_DemRoar                     = "Demoralizing Roar";
         BINDING_NAME_DFUNC_ChalRoar                    = "Challenging Roar";
         BINDING_NAME_DFUNC_Enrage                      = "Enrage";
         BINDING_NAME_DFUNC_PowerTouch                  = "Power Touch";
         BINDING_NAME_DFUNC_BestCat                     = "Best Attack Cat";
         BINDING_NAME_DFUNC_EquipCat                    = "Equip Cat Form Outfit"
         BINDING_NAME_DFUNC_EquipBear                   = "Equip Bear Form Outfit"
         BINDING_NAME_DFUNC_EquipHuman                  = "Equip Human Form Outfit"
         BINDING_NAME_DFUNC_EquipPvP                    = "Equip PvP Outfit"
         BINDING_NAME_DFUNC_EquipWSG                    = "Equip WSG Outfit"
         BINDING_NAME_DFUNC_EquipMoon                   = "Equip Moonkin Form Outfit"
         BINDING_NAME_DFUNC_EquipTravel                 = "Equip Travel Form Outfit"
         BINDING_NAME_DFUNC_EquipMount                  = "Equip Mounted Outfit"
         BINDING_NAME_DFUNC_EquipAqua                   = "Equip Aquatic Form Outfit"
         BINDING_NAME_DFUNC_EquipFire                   = "Equip Fire Resist Outfit"
         BINDING_NAME_DFUNC_EquipArcane                 = "Equip Arcane Resist Outfit"
         BINDING_NAME_DFUNC_EquipFrost                  = "Equip Frost Resist Outfit"
         BINDING_NAME_DFUNC_EquipShadow                 = "Equip Shadow Resist Outfit"
         BINDING_NAME_DFUNC_EquipHeal                   = "Equip Healing Outfit"
         BINDING_NAME_DFUNC_EquipNature                 = "Equip Nature Resist Outfit"
         BINDING_NAME_DFUNC_EquipSpecial1               = "Equip Special1 Outfit"
         BINDING_NAME_DFUNC_EquipSpecial2               = "Equip Special2 Outfit"
         BINDING_NAME_DFUNC_EquipSpecial3               = "Equip Special3 Outfit"
   
      -- -------------------------------------------------------------------------------------
      -- Spells and druid capabilities
      -- -------------------------------------------------------------------------------------
         DF_SHADOWMELD                                     = "Shadowmeld(Racial)"
         DF_HEALINGTOUCH                                   = "Healing Touch"
         DF_REJUVENATION                                   = "Rejuvenation"
         DF_REGROWTH                                       = "Regrowth"
         DF_THORNS                                         = "Thorns"
         DF_MOTW                                           = "Mark of the Wild"
         DF_MOONFIRE                                       = "Moonfire"
         DF_STARFIRE                                       = "Starfire"
         DF_WRATH                                          = "Wrath"
         DF_INSECTSWARM                                    = "Insect Swarm"
         DF_FAERIEFIRE                                     = "Faerie Fire"
         DF_FAERIEFIREFERAL                                = "Faerie Fire (Feral)"
         DF_HIBERNATE                                      = "Hibernate"
         DF_REBIRTH                                        = "Rebirth"
         DF_NATURESGRASP                                   = "Nature's Grasp"
         DF_HURRICANE                                      = "Hurricane"
         DF_TRANQUILITY                                    = "Tranquility"
         DF_ROOTS                                          = "Entangling Roots"
         DF_RAVAGE                                         = "Ravage"
         DF_SHRED                                          = "Shred"
         DF_CLAW                                           = "Claw"
         DF_PROWL                                          = "Prowl"
         DF_RAKE                                           = "Rake"
         DF_POUNCE                                         = "Pounce"
         DF_COWER                                          = "Cower"
         DF_DASH                                           = "Dash"
         DF_RIP                                            = "Rip"
         DF_FEROCIOUSBITE                                  = "Ferocious Bite"
         DF_FERALCHARGE                                    = "Feral Charge"
         DF_TIGERSFURY                                     = "Tiger's Fury"
         DF_MAUL                                           = "Maul"
         DF_BASH                                           = "Bash"
         DF_SWIPE                                          = "Swipe"
         DF_FRENZIEDREGEN                                  = "Frenzied Regeneration"
         DF_DEMROAR                                        = "Demoralizing Roar"
         DF_OMEN                                           = "Omen"
         DF_SWIFTMEND                                      = "Swiftmend"
         DF_NATURESWIFTNESS                                = "Nature's Swiftness"
         DF_INNERVATE                                      = "Innervate"
         DF_AQUAFORM                                       = "Aquatic Form"
         DF_TRAVELFORM                                     = "Travel Form"
         DF_HUMANFORM                                      = "Humanoid Form";
         DF_BEARFORM                                       = "Bear Form";
         DF_CATFORM                                        = "Cat Form";
         DF_MOONFORM                                       = "Moonkin Form";
         DF_INNERVATE                                      = "Innervate"
         DF_BARKSKIN                                       = "Barkskin"
         DF_GROWL                                          = "Growl"
         DF_ENRAGE                                         = "Enrage"
         DF_CHALROAR                                       = "Challenging Roar"
         DF_DEMROAR                                        = "Demoralizing Roar"
         DF_TRACKHUMANOIDS                                 = "Track Humanoids"
         DF_ABOLISHPOISON                                  = "Abolish Poison"
         DF_REMOVECURSE                                    = "Remove Curse"
         DF_TELEPORTMOONGLADE                              = "Teleport: Moonglade"
   
         -- These are strings for castspell by name with a rank      
   
         DF_MOTWRANK     = "Mark of the Wild(Rank "                                    -- Cast string for motw
         DF_THORNSRANK   = "Thorns(Rank "
         DF_REJUVRANK    = "Rejuvenation(Rank "
         DF_HTRANK       = "Healing Touch(Rank "
         DF_MOONFIRERANK = "Moonfire(Rank "
         DF_MOONFIRERANK2= "Moonfire(Rank 2)"
   
   
         DF_ATTACK                                         = "Attack"
         DF_PLAYER                                         = "player"
         DF_TARGET                                         = "target"
   
         DFUNC_Slots    = {"Head","Neck","Shoulder","Shirt","Chest","Waist","Legs","Feet","Wrist","Hands","Finger0","Finger1","Trinket0","Trinket1","Back","MainHand","SecondaryHand","Ranged","Tabard"};
         DF_SLOT        = "Slot"                                                   -- This is appended to the string in slots (HeadSlot, Trinket0Slot, etc...)
         DF_TRINKET0SLOT= "Trinket0Slot"
         DF_TRINKET1SLOT= "Trinket1Slot"
         DF_MAINHANDSLOT= "MainHandSlot"
   
         DF_DFunc_TooltipTextLeft = "DFunc_TooltipTextLeft"                        -- Tooltip string
         
         
         DF_SAY = "say"                                                            -- Chat destination
         DF_RAID= "raid"                                                           -- Chat destination
         DF_PARTY="party"                                                          -- Chat destination
         DF_WHISPER="WHISPER"                                                      -- Chat destination
         
         -- -------------------------------------------------------------------------------------
         -- Player types/Monster types/set names
         -- -------------------------------------------------------------------------------------
   
         DF_MAGE                                           = "Mage"
         DF_PRIEST                                         = "Priest"
         DF_DRUID                                          = "Druid"
         DF_BEAST                                          = "Beast"
         DF_ROGUE                                          = "Rogue"
         DF_DRAGONKIN                                      = "Dragonkin"
         
         -- Various player forms and sets
         DF_CAT = "cat"
         DF_BEAR= "bear"
         DF_HUMAN="humanoid"
         DF_HUMANHUMAN="human"
         DF_MOON="moonkin"
         DF_TRAVEL="travel"
         DF_AQUA = "aqua"
         DF_FIRE = "fire"
         DF_NATURE="nature"
         DF_MOUNT = "mount"
         DF_I = "innervate"
         DF_MANA = "mana"
         DF_PVP = "pvp"
         DF_WSG = "wsg"
         DF_FROST = "frost"
         DF_ARCANE= "arcane"
         DF_HEAL = "heal"
         DF_SHADOW = "shadow"
         DF_SPECIAL1 = "special1"
         DF_SPECIAL2 = "special2"
         DF_SPECIAL3 = "special3"
         DF_TEMP     = "temp"
         
   
         -- -------------------------------------------------------------------------------------
         -- These are various trinkets and items which druidfunc monitors
         -- They tend to have long real names so I use short abreviations
         -- Generally if you don't understand what the name is, it's probably a trinket.
         -- -------------------------------------------------------------------------------------
         DF_IOR = "idol of rejuvenation"                                           -- String checks in the equipment read (for +heal)
         DF_HC  = "hibernation Crystal"                                            -- case is important, it must be lower case
         DF_ZHC = "zandalarian hero charm"
         DF_BMO = "brilliant mana oil"
         DF_DT  = "Defiler's Talisman"
         DF_MARLISEYE                                      = "Mar'li's Eye"
         DF_WUSHCHARMNATURE                                = "Wushoolay's Charm of Nature"
         DF_HC_BUFF = "nimble healing touch"                                       -- This is the buff name when the zandalar class trinket is used.
         DF_WSG_FLAG_A = "silverwing flag"
         DF_WSG_FLAG_H = "warsong flag"
         DF_RUNEMETAMORPH                                  = "Rune of Metamorphosis"
         DF_UNSTABLE_POWER                                 = "Unstable Power"      -- Zandalarian Hero charm buff name
         DF_HIBERNATION                                    = "Healing of the Ages" -- Hibernation crystal
         DF_ABILITY_MOUNT                                  = "Ability_Mount"       -- Icon name of player mount
         DF_JUNGLE_TIGER                                   = "JungleTiger"         -- Druid's Tiger's fury icon (which looks like a mount if we don't look for it)
         DF_DEFILERTALISMAN                                = "Defiler's Talisman"
         
         
         -- -------------------------------------------------------------------------------------
         -- This is the name of a blizzard sound clip that's played when rejuv fails
         -- Dunno if it needs to be changed for international versions but it's here just in case
         -- -------------------------------------------------------------------------------------
         DF_DEATHBIND_SOUND = "Deathbind Sound"
   
         -- -------------------------------------------------------------------------------------
         -- This section is for the scangump procedure which scans the character and extracts the set bonuses
         -- If you're going to have a translation bug it will most likely be here.
         -- -------------------------------------------------------------------------------------
         DF_MP5_1 = "mana per %d+ sec"                                             -- regular expression to find mana per 5
         DF_MP5_2 = "mana regen %d+ per %d+ sec"
         
         DF_HDB   = "healing done by"                                              -- Regular expresion to find healing done by (item)
         DF_UPTO  = "up to %d+"
         DF_HEAL_1= "healing spells %+"                                            -- Regular expression to find healing done by (item)                                             
         DF_SET   = ") set"
         DF_SET2  = "set:"
         DF_CREJUV= "rejuvenation"
         DF_HEAL_3= "healing spells %+%d+"
         DF_HEAL_2= "%+%d+ healing spells"
      
         -- -------------------------------------------------------------------------------------
         -- Wow GUI messages (should match messages return by the wow interface)
         -- -------------------------------------------------------------------------------------
         DF_CANTWHENSWIM                                   = "Cannot use while swimming"
         DF_ONLYWHENSWIM                                   = "Can only use while swimming"
   
         DF_UI_ERROR_MESSAGE                               = "UI_ERROR_MESSAGE"
         DF_LEARNED_SPELL_IN_TAB                           = "LEARNED_SPELL_IN_TAB"
         DF_SPELLCAST_START                                = "SPELLCAST_START"
         DF_SPELLCAST_STOP                                 = "SPELLCAST_STOP"
         DF_SPELLCAST_INTERRUPTED                          = "SPELLCAST_INTERRUPTED"
         DF_SPELLCAST_FAILED                               = "SPELLCAST_FAILED"
         DF_PLAYER_REGEN_ENABLED                           = "PLAYER_REGEN_ENABLED"
         DF_UNIT_INVENTORY_CHANGED                         = "UNIT_INVENTORY_CHANGED"
         DF_PLAYER_ENTERING_WORLD                          = "PLAYER_ENTERING_WORLD"
         DF_PLAYER_AURAS_CHANGED                           = "PLAYER_AURAS_CHANGED"
         DF_PLAYER_UNGHOST                                 = "PLAYER_UNGHOST"
         DF_PLAYER_ALIVE                                   = "PLAYER_ALIVE"
         DF_SPELLCAST_CHANNEL_STOP                         = "SPELLCAST_CHANNEL_STOP"
   
         DF_ANCHOR_NONE                                    = "ANCHOR_NONE"
         
      -- -------------------------------------------------------------------------------------
      -- Information messages send to the user
      -- -------------------------------------------------------------------------------------
         DF_WELCOME1                                       = "DruidFunc: DruidFunc Library Version "
         DF_WELCOME2                                       = " loaded." 
   
         DF_HEALRANGE                                      = "DruidFunc: Heal Range mod was found -- raid functionality altered!"
   
         DF_BASE_HUMAN                                     = "DruidFunc: Base armor set changed back to humanoid."
         DF_CASTING_REGROWTH_1                             = "DruidFunc: Casting Regrowth on "
         DF_CASTING_REGROWTH_2                             = ". (Regrowth rank "
         DF_CASTING_REGROWTH_3                             = "Regrowth(Rank "
   
         DF_FAILCAST                                       = "DruidFunc: Can not cast on this target right now (out of range, line of sight)"
         
         DF_REJUV_WARN_1                                   = "DruidFunc: Rejuvenation already on "
         DF_REJUV_WARN_2                                   = " press again to swiftmend!"
         DF_REJUV_WARN_3                                   = ", press again to refresh."
         DF_REJUV_WARN_4                                   = "DruidFunc: HoT on "
         DF_REJUV_WARN_5                                   = ". (Rejuvenation Rank "
   
         DF_SWIFTMEND_WARN_1                               = "DruidFunc: Target has no HoTs.   Casting Rejuvenation"
         DF_SWIFTMEND_WARN_2                               = "DruidFunc: Swiftmend is on cooldown!"
         DF_SWIFTMEND_WARN_3                               = "DruidFunc: You haven't learned swiftmend."
   
         DF_DERANK_WARN_1                                  = "Low Mana.  Need rank "
         DF_DERANK_WARN_2                                  = ".  Best cast rank "
   
         DF_HT_WARN_1                                      = "DruidFunc: Healing "
         DF_HT_WARN_2                                      = ". (Rank "
         DF_HT_WARN_3                                      = " heal/"
         DF_HT_WARN_4                                      = " needed. "
         DF_HT_WARN_4_1                                    = " max health."
         DF_HT_WARN_5                                      = "DruidFunc: Mana Conserve aborted the heal. Target @ "
         DF_HT_WARN_6                                      = "% abort set to "
         DF_HT_WARN_7                                      = "DruidFunc: Full Heal rank "
         DF_HT_WARN_8                                      = " (target health: "
         DF_HT_WARN_9                                      = ", health max: "
         DF_HT_WARN_10                                     = ", curr Health: "
         
         DF_I_WARN_1                                       = "DruidFunc: Innervate is on cooldown."
         DF_I_WARN_2                                       = "DruidFunc: Innervate already on "
         DF_I_WARN_3                                       = ".  Aborted"
         DF_I_WARN_4                                       = "DruidFunc: Innervate aborted.  "
         DF_I_WARN_5                                       = " has more than 50% mana"
         DF_I_WARN_6                                       = "DruidFunc: Casting Innervate on "
   
         DF_HIBERNATE_WARN_1                               = "DruidFunc: Casting hibernate (CC) on "
         DF_HIBERNATE_WARN_2                               = " <DO NOT ATTACK!>"
         DF_HIBERNATE_WARN_3                               = "DruidFunc: Invalid hibernation target."      
      
         DF_REBIRTH_WARN_1                                 = "DruidFunc: Resurrecting "
         DF_REBIRTH_WARN_2                                 = "DruidFunc: Invalid Rebirth target."
         
         DF_PRAYER_WARN_1                                  = "DruidFunc: Rejuvenation done, press again for swiftmend!"
   
         DF_PROWL_WARN_1                                   = "DruidFunc: Prowling not allowed while you have the WSG flag."
         
         DF_ASSIST_WARN_1                                  = "DruidFunc: Assist Failed... Not Visible or doesn't exist or not hostile"
         DF_ASSIST_WARN_2                                  = "DruidFunc: Assist Failed... Out of Range"
         DF_ASSIST_WARN_3                                  = "DruidFunc: Assist Failed... Assist is dead or bad target."
         DF_ASSIST_WARN_4                                  = "DruidFunc: Assist failed...  The person you are assisting is not in combat."
         
         DF_ACTIONREADY_WARN_1                             = "Spell or Item not found: "
         
         DF_QUICKSHIFT_WARN_1                              = "You already have that potion effect"
         DF_QUICKSHIFT_WARN_2                              = "That item is on cooldown and can not be used right now."
         
         DF_BEARBARK_POTNAME                               = "Spell_Nature_StoneClawTotem"
         
         DF_PATCHWERK_POTNAME                              = "greater stoneshield potion"
         DF_PATCHWERK_POTICON                              = "INV_Potion_69"
         
         DF_PATCHWERKTEST_POTNAME                          = "lesser stoneshield potion"
         DF_PATCHWERKTEST_POTICON                          = "INV_Potion_67"            
   
         DF_OFF                                            = "off"
         DF_ON                                             = "on"
         DF_AUTO                                           = "auto"
         
         DF_ICHAT                                          = "You've been innervated!   Cast normally for best results."
   
       -- -------------------------------------------------------------------------------------
       -- These hold the totem stomper stirings
       -- -------------------------------------------------------------------------------------
   
         DF_TOTEM_SENTRY     = "sentry totem"
         DF_TOTEM_WINDWALL   = "windwall totem"
         DF_TOTEM_FIRE       = "fire resistance totem"
         DF_TOTEM_FROST      = "frost resistance totem"
         DF_TOTEM_HEAL       = "healing totem"
         DF_TOTEM_POISON     = "poison clensing totem"
         DF_TOTEM_DISEASE    = "disease clesning totem"
         DF_TOTEM_STRENGTH   = "strength of earth totem"
         DF_TOTEM_STONECLAW  = "stoneclaw totem"
         DF_TOTEM_NATURE     = "nature resistance totem"
         DF_TOTEM_GRACE      = "grace of air totem"
         DF_TOTEM_STONESKIN  = "stoneskin totem"
         DF_TOTEM_EARTHBIND  = "earthbind totem"
         DF_TOTEM_MOONFLARE  = "moonflare totem"
         DF_TOTEM_GROUNDING  = "grounding totem"
         DF_TOTEM_SEARING    = "searing totem"
         DF_TOTEM_MAGMA      = "magma totem"
         DF_TOTEM_FIRENOVA   = "fire nova totem"
         DF_TOTEM_HEALSTREAM = "healing stream totem"
         DF_TOTEM_WINDFURY   = "windfury totem"
         DF_TOTEM_MANASPRING = "mana spring totem"
         DF_TOTEM_MANATIDE   = "mana tide totem"
         DF_TOTEM_TREMOR     = "tremor totem"
         DF_TOTEM_HEALWARD   = "healing ward"
         DF_TOTEM_BRAINWASH  = "brain wash totem"
         DF_TOTEM_POWERFUL   = "powerful healing ward"
         DF_TOTEM_LIGHTNING  = "lightning totem"
   
         DF_TOTEM_TOTEMIC    = "totemic"
         DF_TOTEM_TOTEM      = " totem"
         DF_TOTEM_WARD       = " ward"
   
       -- -------------------------------------------------------------------------------------
       -- These strings are the varions /druid and /df commands
       -- -------------------------------------------------------------------------------------
   
         DF_DRUID1   = "/DRUID"                                                    -- The /druid slash command
         DF_DRUID2   = "/DF"                                                       -- The /druid shortcut
         
         -- /druid home
         DF_HOME = "home"                                                          -- Command -- /df home = use hearthstone
         DF_HEARTHSTONE = "Hearthstone"                                            -- And the hearthstone itself
         DF_HOME_WARN_1 = "DruidFunc: Using Hearthstone."
         DF_HOME_WARN_2 = "DruidFunc: Hearthstone is on cooldown.  Failed."
         
         -- /druid port, /druid moonglade -- command -- cast teleport: moonglade
         DF_PORT = "port"                                                         
         DF_MOONGLADE = "moonglade"
         DF_PORT_WARN_1 = "DruidFunc: Teleport->Moonglade"
         
         -- /druid intro
         
         DF_DCMD_WARN_1 = "Use /druid (command) to get help for a specific command.   /druid moonbar, /druid smartcast, etc"
         DF_DCMD_WARN_2 = "Use /druid stats to get info about your character."
         
         DF_DCMD_WARN_3 = "/druid moonglade -- command, port to moonglade"
         DF_DCMD_WARN_4 = "/druid port -- command, port to moonglade"
         DF_DCMD_WARN_5 = "/druid home -- command, use hearthstone"
         
         -- /druid stats
         DF_STATS = "stats"
         DF_STATS_WARN_1 = "Your present +heal value from items: "
         DF_MANAREGEN = "mana regeneration"
         DF_STATS_WARN_2 = "Your present mana/5 value from items: "
         DF_STATS_WARN_3 = "Your present spirit regen (outside the 5 sec rule): "
         DF_STATS_WARN_4 = "Innervate will return around : "
         DF_STATS_WARN_5 = " mana (disregarding reflection and tier 2 set bonus)"
         
         -- /druid ichat
         DF_ICHATFLAG = "ichat"
         DF_ICHAT_WARN_1 = "Ichat saves the message you'd like to send your innervate targets."
         DF_ICHAT_WARN_2 = "usage: /druid ichat you've been innervated, keep casting normally for best results."
         DF_ICHAT_WARN_3 = "/druid ichat Innervate Whisper Message: "
         
         -- /druid plusheal
         DF_PLUSHEAL = "plusheal"
         DF_PLUSHEAL_WARN_1 = "/druid plusheal [off/auto/#]"
         DF_PLUSHEAL_WARN_2 = "This sets the healing touch offset.   Use off or zero to disable"
         DF_PLUSHEAL_WARN_3 = "Auto will calculate the value based on the +healing value of your gear"
         DF_PLUSHEAL_WARN_4 = "You can specify a number as well 200 or -200.  Positive numbers cause you to use"
         DF_PLUSHEAL_WARN_5 = "lower ranks of healing touch, positive numbers cause you to use higher ranks." 
         DF_PLUSHEAL_WARN_6 = "It's recommended this be off until you have more than 200 then use auto."
         DF_PLUSHEAL_WARN_7 = "/druid plusheal [auto/off/number] (Set healing touch offset) is: "
         
         -- /druid hardshift
         DF_HARDSHIFT = "hardshift"
         DF_HARDSHIFT_WARN_1 = "When on prevents the shift bear/cat keys/macros from shifting you out of form" 
         DF_HARDSHIFT_WARN_2 = "When off toggles you between requested form and humanoid."
         DF_HARDSHIFT_WARN_3 = "/druid hardshift [on/off]"
         DF_HARDSHIFT_WARN_4 = "/druid hardshift [on/off] (change shapeshift key functionality) is: "
   
         -- /druid assist                      (Note we use DF_SASSIST for slash assist here, because the assist function has it's own warn messages)
         DF_SASSIST = "assist"
         DF_SASSIST_WARN_1 = "Use /druid assist off to disable | Use /druid assist on to re-enable using last assist"
         DF_SASSIST_WARN_2 = "Use /druid assist <name> to set a spellcast assist (and enable assisting)"
         DF_SASSIST_WARN_3 = "/druid assist [on/off/name] (set spellcasting assist) is set to: "
         
         -- /druid manac
         DF_MANAC = "manac"
         DF_MANAC_WARN_1 = "ManaC [off/silent/announce/10-100]" 
         DF_MANAC_WARN_2 = "Sets the health threashold that will abort a healing touch spell.  For instance"
         DF_MANAC_WARN_3 = "/druid manac 90 will abort healing touch if the target's health is over 90%"
         DF_MANAC_WARN_4 = "silent will keep aborts from being announced in the chat box, announce turns abort messages on."
         DF_MANAC_WARN_5 = "silent (no announce in chat box)"
         DF_MANAC_WARN_6 = "announce (aborts appear in chat box)"
         DF_MANAC_WARN_7 = "/druid manac [off/silent/announce/10-100] is set to: "
         DF_SILENT = "silent"
         DF_ANNOUNCE = "announce"
         
         -- /druidmanaswap
         DF_MANASWAP = "manaswap"
         DF_MANASWAP_WARN_1 = "Manaswap sets the threshold low mana weapon swaps happen." 
         DF_MANASWAP_WARN_2 = "The default is 85 which means when your mana pool falls below 85%"
         DF_MANASWAP_WARN_3 = "The low mana weapon set will be equipped.   Valid values are 0-100."
         DF_MANASWAP_WARN_4 = "0 basically disables this functionality, 100 is just wierd."
         DF_MANASWAP_WARN_5 = "/druid manaswap [0-100] (Low mana swap threshold) is set to: "
   
         -- /druidmoonbar
         DF_MOONBAR = "moonbar"
         DF_MOONBAR_WARN_1 = "Moonbar sets the toolbar that will be switched to when you" 
         DF_MOONBAR_WARN_2 = "switch to the moonkin form.   The toolbars are 1-6."
         DF_MOONBAR_WARN_3 = "Setting moonbar to 0 will disable toolbar switching entierly."
         DF_MOONBAR_WARN_4 = "/druid moonbar [0-5] (Moonkin action bar) is set to: "
   
         -- /druid smartcast
         DF_SMARTCAST = "smartcast"
         DF_SMARTCAST_WARN_1 = "Smartcast will change the casting target automatically in certian situations." 
         DF_SMARTCAST_WARN_2 = "If you cast a heal on a hostile target, the heal will be redirected to the person your hostile target is targeting."
         DF_SMARTCAST_WARN_3 = "If you cast a damage spell on a friendly target, the spell will be redirected to the friendly target's target"
         DF_SMARTCAST_WARN_4 = "Smartcasting off disables this functionality."
         DF_SMARTCAST_WARN_5 = "/druid smartcast [on/off] (auto target assist) is set to : on"
         DF_SMARTCAST_WARN_6 = "/druid smartcast [on/off] (auto target assist) is set to : off"
   
         -- /druid target     (note we use DF_STARGET here because DF_TARGET is an actual command (player's target) that we use elsewhere )
         DF_STARGET = "target"
         DF_STARGET_WARN_1 = "When on will target yourself if you hit the humanoid key while already in human form." 
         DF_STARGET_WARN_2 = "When off will attempt to self-cast heals (similar to desperate prayer) without"
         DF_STARGET_WARN_3 = "losing your target.  If you play a cat often /druid target off is prefered." 
         DF_STARGET_WARN_4 = "/druid target [on/off] is set to : on (target self when humanoid key pressed)"
         DF_STARGET_WARN_5 = "/druid target [on/off] is set to : off (cast self-heal when humanoid key is pressed)" 
   
         -- /druid trinkets
         DF_TRINKETS = "trinkets"
         DF_TRINKETS_WARN_1 = "If you set trinkets to on then druidfunc will try to use some common"             
         DF_TRINKETS_WARN_2 = "trinkets durring common actions.  For instance it will always try to use"             
         DF_TRINKETS_WARN_3 = "the hibernation crystal when you cast a heal and rune of metamorphasis"             
         DF_TRINKETS_WARN_4 = "when you shapeshift.  The allowed values are on and off."             
         DF_TRINKETS_WARN_5 = "/druid trinkets [on/off] (auto trinket usage) is set to : on"            
         DF_TRINKETS_WARN_6 = "/druid trinkets [on/off] (auto trinket usage) is set to : off"             
   
         -- /druid prayer   (note we use SPRAYER to avoid conflicts elsehwere)
         DF_SPRAYER = "prayer"      
         DF_SPRAYER_WARN_1 = "Specifies the percentage of your (or your target's health) before" 
         DF_SPRAYER_WARN_2 = "desperate healing starts burning your cooldown.   /druid prayer 50 means"
         DF_SPRAYER_WARN_3 = "the target must be at 50% health or less before your cooldowns will be used."
         DF_SPRAYER_WARN_4 = "/druid prayer [25-100] (desperate heal, health threshold) is: "
         
         -- -------------------------------------------------------------------------------------
         -- DOUTFIT area
         -- -------------------------------------------------------------------------------------
   
         DF_DOUTFIT1 = "/DOutfit"                                                  -- The /doutfit slash command (yes you can change it)
         DF_DOUTFIT2 = "/DO"                                                       -- The /doutfit shortcut
   
         DF_DO_WEAPON = "weapon"
         DF_DO_OUTFIT = "outfit"
         DF_DO_SAVE   = "save"
         DF_DO_MOON   = "moon"
   
         DF_DO_WARN_1 = "Usage: /doutfit [on/off/outfit/weapon/{set name}] [off/save]"
         DF_DO_WARN_2 = "Example (save bear set): /doutfit bear save"       
         DF_DO_WARN_3 = "Example (Use fire resist set): /doutfit fire"      
         DF_DO_WARN_4 = "Example (Auto equip only weapons): /doutfit weapon"      
         DF_DO_WARN_5 = "Example (Auto Equip everything): /doutfit outfit"       
         DF_DO_WARN_6 = "Example (Disable automatic equips): /doutfit off"       
         DF_DO_WARN_7 = "Set names: human, bear, cat, aqua, travel, moon, mount, heal, pvp, fire, nature, arcane, frost, shadow, wsg, special1, special2, special3, and Temp"      
         DF_DO_WARN_8 = "DruidFunc: The outfitter is presently on"      
         DF_DO_WARN_9 = "DruidFunc: The outfitter is presently off"       
         DF_DO_WARN_10= "DruidFunc: The outfitter presently is swapping only weapons"       
         DF_DO_WARN_11= "DruidFunc: The outfitter presently is swapping everything, armor and weapons."       
         DF_DO_WARN_12= "DruidFunc: Automatic wardrobe changes have been disabled."
         DF_DO_WARN_13= "DruidFunc: Automatic wardrobe changes will only affect weapons/idols"       
         DF_DO_WARN_14= "DruidFunc: Automatic wardrobe changes will now affect all gear when not in combat"        
         DF_DO_WARN_15= "DruidFunc: Automatic wardrobe changes have been enabled."       
         DF_DO_WARN_16= "DruidFunc: Cat form wardobe is disabled"       
         DF_DO_WARN_17= "DruidFunc: Cat form wardrobe selection saved"        
         DF_DO_WARN_18= "DruidFunc: Base set is now presently Cat set"      
         DF_DO_WARN_19= "DruidFunc: Moonkin form wardobe is disabled"        
         DF_DO_WARN_20= "DruidFunc: Moonkin form wardrobe selection saved"      
         DF_DO_WARN_21= "DruidFunc: Base set is now presently Moonkin set"       
         DF_DO_WARN_22= "DruidFunc: Travel form wardobe is disabled"      
         DF_DO_WARN_23= "DruidFunc: Travel form wardrobe selection saved"       
         DF_DO_WARN_24= "DruidFunc: Base set is now presently Travel Form set"      
         DF_DO_WARN_25= "DruidFunc: Aquatic form wardobe is disabled"       
         DF_DO_WARN_26= "DruidFunc: Aquatic form wardrobe selection saved"       
         DF_DO_WARN_27= "DruidFunc: Base set is now presently Aquatic Form set"       
         DF_DO_WARN_28= "DruidFunc: Bear form wardobe is disabled"       
         DF_DO_WARN_29= "DruidFunc: Bear form wardrobe selection saved"       
         DF_DO_WARN_30= "DruidFunc: Base set is now presently Bear set"       
         DF_DO_WARN_31= "DruidFunc: Human form wardobe is disabled"       
         DF_DO_WARN_32= "DruidFunc: Human form wardrobe selection saved"       
         DF_DO_WARN_33= "DruidFunc: Base set is now presently Humanoid set"       
         DF_DO_WARN_34= "DruidFunc: Low Mana wardobe is disabled"       
         DF_DO_WARN_35= "DruidFunc: Low Mana wardrobe selection saved"     
         DF_DO_WARN_36= "DruidFunc: Base set is now presently the Low Mana set"       
         DF_DO_WARN_37= "DruidFunc: Innervate wardobe is disabled"       
         DF_DO_WARN_38= "DruidFunc: Innervate wardrobe selection saved"       
         DF_DO_WARN_39= "DruidFunc: Base set is now presently the Innervate set"       
         DF_DO_WARN_40= "DruidFunc: Fire resist wardobe is disabled"       
         DF_DO_WARN_41= "DruidFunc: Fire Resist wardrobe selection saved"      
         DF_DO_WARN_42= "DruidFunc: Base set is now presently the Fire Resist set"       
         DF_DO_WARN_43= "DruidFunc: PvP wardobe is disabled"       
         DF_DO_WARN_44= "DruidFunc: PvP wardrobe selection saved"       
         DF_DO_WARN_45= "DruidFunc: Base set is now presently the PvP set"       
         DF_DO_WARN_46= "DruidFunc: Warsong Gulch wardobe is disabled"       
         DF_DO_WARN_47= "DruidFunc: Warsong Gulch wardrobe selection saved"       
         DF_DO_WARN_48= "DruidFunc: Base set is now presently the Warsong Gulch set"       
         DF_DO_WARN_49= "DruidFunc: Nature Resist wardobe is disabled"       
         DF_DO_WARN_50= "DruidFunc: Nature Resist wardrobe selection saved"       
         DF_DO_WARN_51= "DruidFunc: Base set is now presently the Nature Resist set"       
         DF_DO_WARN_52= "DruidFunc: Mounted wardobe is disabled"       
         DF_DO_WARN_53= "DruidFunc: Mounted wardrobe selection saved"      
         DF_DO_WARN_54= "DruidFunc: Base set is now presently the Mounted set"       
         DF_DO_WARN_55= "DruidFunc: Arcane Resist Set is disabled"       
         DF_DO_WARN_56= "DruidFunc: Arcane Resist selection saved"       
         DF_DO_WARN_57= "DruidFunc: Base set is now presently the Arcane Resist Set"       
         DF_DO_WARN_58= "DruidFunc: Shadow Resist Set is disabled"       
         DF_DO_WARN_59= "DruidFunc: Shadow Resist selection saved"     
         DF_DO_WARN_60= "DruidFunc: Base set is now presently the Shadow Resist Set"       
         DF_DO_WARN_61= "DruidFunc: Frost Resist set  is disabled"        
         DF_DO_WARN_62= "DruidFunc: Frost Resist Set selection saved"       
         DF_DO_WARN_63= "DruidFunc: Base set is now presently the Frost Resistance Set"       
         DF_DO_WARN_64= "DruidFunc: Healing set is disabled"       
         DF_DO_WARN_65= "DruidFunc: Healing Set selection saved"       
         DF_DO_WARN_66= "DruidFunc: Base set is now presently the Healing Set"       
         DF_DO_WARN_67= "DruidFunc: Temporary set is disabled"       
         DF_DO_WARN_68= "DruidFunc: Temporary Set selection saved"       
         DF_DO_WARN_69= "DruidFunc: Base set is now presently your Temporary Set"       
         DF_DO_WARN_70= "DruidFunc: User Defined set 1  is disabled"        
         DF_DO_WARN_71= "DruidFunc: User defined set 1 selection saved"       
         DF_DO_WARN_72= "DruidFunc: Base set is now presently the user defined set 1"       
         DF_DO_WARN_73= "DruidFunc: User Defined set 2 is disabled"       
         DF_DO_WARN_74= "DruidFunc: User defined set 2 selection saved"       
         DF_DO_WARN_75= "DruidFunc: Base set is now presently the user defined set 2"       
         DF_DO_WARN_76= "DruidFunc: User Defined set 3 is disabled"       
         DF_DO_WARN_77= "DruidFunc: User defined set 3 selection saved"       
         DF_DO_WARN_78= "DruidFunc: Base set is now presently the user defined set 3"       

      end;
   
-- -------------------------------------------------------------------------------------
-- German
-- -------------------------------------------------------------------------------------

   if (GetLocale() == "deDE") then
      -- -------------------------------------------------------------------------------------
      -- These variables extend WoW's keyboard definition panel (Esc, keybindings ingame)
      -- They work hand in hand with the bindings.xlm file in this directory.
      -- -------------------------------------------------------------------------------------
   
         BINDING_HEADER_DFUNC                           = "DruidFunc Library";
         BINDING_NAME_DFUNC_TotemStomper                = "Totem Stomper";
         BINDING_NAME_DFUNC_MarkRogues                  = "Mark Rogues"
         BINDING_NAME_DFUNC_weakestLink                 = "Target Weakest Link"
         BINDING_NAME_DFUNC_weakestHealer               = "Target Weakest Healer"
         BINDING_NAME_DFUNC_Swiftmend		               = "Swiftmend";
         BINDING_NAME_DFUNC_DesperatePrayer             = "Desperate Heal Self";
         BINDING_NAME_DFUNC_DesperateHeal               = "Desperate Heal Other";
         BINDING_NAME_DFUNC_FaerieFire                  = 'Faerie Fire';
         BINDING_NAME_DFUNC_Hibernate                   = 'Hibernate';
         BINDING_NAME_DFUNC_Moonfire                    = 'Moonfire';
         BINDING_NAME_DFUNC_Starfire                    = 'Starfire';
         BINDING_NAME_DFUNC_Hurricane                   = "Hurricane";
         BINDING_NAME_DFUNC_Wrath                       = 'Wrath';
         BINDING_NAME_DFUNC_MotW                        = 'Mark of the Wild';
         BINDING_NAME_DFUNC_Thorns                      = 'Thorns';
         BINDING_NAME_DFUNC_Roots                       = "Entangling Roots";
         BINDING_NAME_DFUNC_NaturesGrasp                = "Nature's Grasp";
         BINDING_NAME_DFUNC_AbolishPoison               = 'Abolish Poison';
         BINDING_NAME_DFUNC_Tranquility                 = "Tranquility";
         BINDING_NAME_DFUNC_Regrowth                    = 'Regrowth';
         BINDING_NAME_DFUNC_Rejuvenation                = 'Rejuvenation';
         BINDING_NAME_DFUNC_RemoveCurse                 = 'Remove Curse';
         BINDING_NAME_DFUNC_HealingTouch                = 'Healing Touch';
         BINDING_NAME_DFUNC_Barkskin                    = 'Barkskin';
         BINDING_NAME_DFUNC_Innervate                   = 'Innervate';
         BINDING_NAME_DFUNC_ManaMe                      = "Mana Me";
         BINDING_NAME_DFUNC_Human                       = 'Humanoid Form';
         BINDING_NAME_DFUNC_Bear                        = 'Bear Form';
         BINDING_NAME_DFUNC_Cat                         = 'Cat Form';
         BINDING_NAME_DFUNC_Travel                      = 'Travel Form';
         BINDING_NAME_DFUNC_Aqua                        = 'Aquatic Form';
         BINDING_NAME_DFUNC_Moon                        = 'Moonkin Form';
         BINDING_NAME_DFUNC_InsectSwarm                 = 'Insect Swarm';
         BINDING_NAME_DFUNC_Rebirth                     = 'Rebirth';
         BINDING_NAME_DFUNC_Ravage                      = "Ravage";
         BINDING_NAME_DFUNC_Shred                       = "Shred";
         BINDING_NAME_DFUNC_Claw                        = "Claw";
         BINDING_NAME_DFUNC_Rake                        = "Rake";
         BINDING_NAME_DFUNC_Rip                         = "Rip";
         BINDING_NAME_DFUNC_Pounce                      = "Pounce";
         BINDING_NAME_DFUNC_Prowl                       = "Prowl";
         BINDING_NAME_DFUNC_Cower                       = "Cower";
         BINDING_NAME_DFUNC_Dash                        = "Dash";
         BINDING_NAME_DFUNC_FerociousBite               = "Ferocious Bite";
         BINDING_NAME_DFUNC_TigersFury                  = "Tiger's Fury";
         BINDING_NAME_DFUNC_FeralCharge                 = "Feral Charge";
         BINDING_NAME_DFUNC_Maul                        = "Maul";
         BINDING_NAME_DFUNC_Bash                        = "Bash";
         BINDING_NAME_DFUNC_Growl                       = "Growl";
         BINDING_NAME_DFUNC_Swipe                       = "Swipe";
         BINDING_NAME_DFUNC_FrenziedRegen               = "Frenzied Regeneration";
         BINDING_NAME_DFUNC_DemRoar                     = "Demoralizing Roar";
         BINDING_NAME_DFUNC_ChalRoar                    = "Challenging Roar";
         BINDING_NAME_DFUNC_Enrage                      = "Enrage";
         BINDING_NAME_DFUNC_PowerTouch                  = "Power Touch";
         BINDING_NAME_DFUNC_BestCat                     = "Best Attack Cat";
         BINDING_NAME_DFUNC_EquipCat                    = "Equip Cat Form Outfit"
         BINDING_NAME_DFUNC_EquipBear                   = "Equip Bear Form Outfit"
         BINDING_NAME_DFUNC_EquipHuman                  = "Equip Human Form Outfit"
         BINDING_NAME_DFUNC_EquipPvP                    = "Equip PvP Outfit"
         BINDING_NAME_DFUNC_EquipWSG                    = "Equip WSG Outfit"
         BINDING_NAME_DFUNC_EquipMoon                   = "Equip Moonkin Form Outfit"
         BINDING_NAME_DFUNC_EquipTravel                 = "Equip Travel Form Outfit"
         BINDING_NAME_DFUNC_EquipMount                  = "Equip Mounted Outfit"
         BINDING_NAME_DFUNC_EquipAqua                   = "Equip Aquatic Form Outfit"
         BINDING_NAME_DFUNC_EquipFire                   = "Equip Fire Resist Outfit"
         BINDING_NAME_DFUNC_EquipArcane                 = "Equip Arcane Resist Outfit"
         BINDING_NAME_DFUNC_EquipFrost                  = "Equip Frost Resist Outfit"
         BINDING_NAME_DFUNC_EquipShadow                 = "Equip Shadow Resist Outfit"
         BINDING_NAME_DFUNC_EquipHeal                   = "Equip Healing Outfit"
         BINDING_NAME_DFUNC_EquipNature                 = "Equip Nature Resist Outfit"
         BINDING_NAME_DFUNC_EquipSpecial1               = "Equip Special1 Outfit"
         BINDING_NAME_DFUNC_EquipSpecial2               = "Equip Special2 Outfit"
         BINDING_NAME_DFUNC_EquipSpecial3               = "Equip Special3 Outfit"
   
      -- -------------------------------------------------------------------------------------
      -- Spells and druid capabilities
      -- -------------------------------------------------------------------------------------
         DF_SHADOWMELD                                     = "Shadowmeld(Racial)"
         DF_HEALINGTOUCH                                   = "Healing Touch"
         DF_REJUVENATION                                   = "Rejuvenation"
         DF_REGROWTH                                       = "Regrowth"
         DF_THORNS                                         = "Thorns"
         DF_MOTW                                           = "Mark of the Wild"
         DF_MOONFIRE                                       = "Moonfire"
         DF_STARFIRE                                       = "Starfire"
         DF_WRATH                                          = "Wrath"
         DF_INSECTSWARM                                    = "Insect Swarm"
         DF_FAERIEFIRE                                     = "Faerie Fire"
         DF_FAERIEFIREFERAL                                = "Faerie Fire (Feral)"
         DF_HIBERNATE                                      = "Hibernate"
         DF_REBIRTH                                        = "Rebirth"
         DF_NATURESGRASP                                   = "Nature's Grasp"
         DF_HURRICANE                                      = "Hurricane"
         DF_TRANQUILITY                                    = "Tranquility"
         DF_ROOTS                                          = "Entangling Roots"
         DF_RAVAGE                                         = "Ravage"
         DF_SHRED                                          = "Shred"
         DF_CLAW                                           = "Claw"
         DF_PROWL                                          = "Prowl"
         DF_RAKE                                           = "Rake"
         DF_POUNCE                                         = "Pounce"
         DF_COWER                                          = "Cower"
         DF_DASH                                           = "Dash"
         DF_RIP                                            = "Rip"
         DF_FEROCIOUSBITE                                  = "Ferocious Bite"
         DF_FERALCHARGE                                    = "Feral Charge"
         DF_TIGERSFURY                                     = "Tiger's Fury"
         DF_MAUL                                           = "Maul"
         DF_BASH                                           = "Bash"
         DF_SWIPE                                          = "Swipe"
         DF_FRENZIEDREGEN                                  = "Frenzied Regeneration"
         DF_DEMROAR                                        = "Demoralizing Roar"
         DF_OMEN                                           = "Omen"
         DF_SWIFTMEND                                      = "Swiftmend"
         DF_NATURESWIFTNESS                                = "Nature's Swiftness"
         DF_INNERVATE                                      = "Innervate"
         DF_AQUAFORM                                       = "Aquatic Form"
         DF_TRAVELFORM                                     = "Travel Form"
         DF_HUMANFORM                                      = "Humanoid Form";
         DF_BEARFORM                                       = "Bear Form";
         DF_CATFORM                                        = "Cat Form";
         DF_MOONFORM                                       = "Moonkin Form";
         DF_INNERVATE                                      = "Innervate"
         DF_BARKSKIN                                       = "Barkskin"
         DF_GROWL                                          = "Growl"
         DF_ENRAGE                                         = "Enrage"
         DF_CHALROAR                                       = "Challenging Roar"
         DF_DEMROAR                                        = "Demoralizing Roar"
         DF_TRACKHUMANOIDS                                 = "Track Humanoids"
         DF_ABOLISHPOISON                                  = "Abolish Poison"
         DF_REMOVECURSE                                    = "Remove Curse"
         DF_TELEPORTMOONGLADE                              = "Teleport: Moonglade"
   
         -- These are strings for castspell by name with a rank      
   
         DF_MOTWRANK     = "Mark of the Wild(Rank "                                    -- Cast string for motw
         DF_THORNSRANK   = "Thorns(Rank "
         DF_REJUVRANK    = "Rejuvenation(Rank "
         DF_HTRANK       = "Healing Touch(Rank "
         DF_MOONFIRERANK = "Moonfire(Rank "
         DF_MOONFIRERANK2= "Moonfire(Rank 2)"
   
   
         DF_ATTACK                                         = "Attack"
         DF_PLAYER                                         = "player"
         DF_TARGET                                         = "target"
   
         DFUNC_Slots    = {"Head","Neck","Shoulder","Shirt","Chest","Waist","Legs","Feet","Wrist","Hands","Finger0","Finger1","Trinket0","Trinket1","Back","MainHand","SecondaryHand","Ranged","Tabard"};
         DF_SLOT        = "Slot"                                                   -- This is appended to the string in slots (HeadSlot, Trinket0Slot, etc...)
         DF_TRINKET0SLOT= "Trinket0Slot"
         DF_TRINKET1SLOT= "Trinket1Slot"
         DF_MAINHANDSLOT= "MainHandSlot"
   
         DF_DFunc_TooltipTextLeft = "DFunc_TooltipTextLeft"                        -- Tooltip string
         
         
         DF_SAY = "say"                                                            -- Chat destination
         DF_RAID= "raid"                                                           -- Chat destination
         DF_PARTY="party"                                                          -- Chat destination
         DF_WHISPER="WHISPER"                                                      -- Chat destination
         
         -- -------------------------------------------------------------------------------------
         -- Player types/Monster types/set names
         -- -------------------------------------------------------------------------------------
   
         DF_MAGE                                           = "Mage"
         DF_PRIEST                                         = "Priest"
         DF_DRUID                                          = "Druid"
         DF_BEAST                                          = "Beast"
         DF_ROGUE                                          = "Rogue"
         DF_DRAGONKIN                                      = "Dragonkin"
         
         -- Various player forms and sets
         DF_CAT = "cat"
         DF_BEAR= "bear"
         DF_HUMAN="humanoid"
         DF_HUMANHUMAN="human"
         DF_MOON="moonkin"
         DF_TRAVEL="travel"
         DF_AQUA = "aqua"
         DF_FIRE = "fire"
         DF_NATURE="nature"
         DF_MOUNT = "mount"
         DF_I = "innervate"
         DF_MANA = "mana"
         DF_PVP = "pvp"
         DF_WSG = "wsg"
         DF_FROST = "frost"
         DF_ARCANE= "arcane"
         DF_HEAL = "heal"
         DF_SHADOW = "shadow"
         DF_SPECIAL1 = "special1"
         DF_SPECIAL2 = "special2"
         DF_SPECIAL3 = "special3"
         DF_TEMP     = "temp"
         
   
         -- -------------------------------------------------------------------------------------
         -- These are various trinkets and items which druidfunc monitors
         -- They tend to have long real names so I use short abreviations
         -- Generally if you don't understand what the name is, it's probably a trinket.
         -- -------------------------------------------------------------------------------------
         DF_IOR = "idol of rejuvenation"                                           -- String checks in the equipment read (for +heal)
         DF_HC  = "hibernation Crystal"                                            -- case is important, it must be lower case
         DF_ZHC = "zandalarian hero charm"
         DF_BMO = "brilliant mana oil"
         DF_DT  = "Defiler's Talisman"
         DF_MARLISEYE                                      = "Mar'li's Eye"
         DF_WUSHCHARMNATURE                                = "Wushoolay's Charm of Nature"
         DF_HC_BUFF = "nimble healing touch"                                       -- This is the buff name when the zandalar class trinket is used.
         DF_WSG_FLAG_A = "silverwing flag"
         DF_WSG_FLAG_H = "warsong flag"
         DF_RUNEMETAMORPH                                  = "Rune of Metamorphosis"
         DF_UNSTABLE_POWER                                 = "Unstable Power"      -- Zandalarian Hero charm buff name
         DF_HIBERNATION                                    = "Healing of the Ages" -- Hibernation crystal
         DF_ABILITY_MOUNT                                  = "Ability_Mount"       -- Icon name of player mount
         DF_JUNGLE_TIGER                                   = "JungleTiger"         -- Druid's Tiger's fury icon (which looks like a mount if we don't look for it)
         DF_DEFILERTALISMAN                                = "Defiler's Talisman"
         
         
         -- -------------------------------------------------------------------------------------
         -- This is the name of a blizzard sound clip that's played when rejuv fails
         -- Dunno if it needs to be changed for international versions but it's here just in case
         -- -------------------------------------------------------------------------------------
         DF_DEATHBIND_SOUND = "Deathbind Sound"
   
         -- -------------------------------------------------------------------------------------
         -- This section is for the scangump procedure which scans the character and extracts the set bonuses
         -- If you're going to have a translation bug it will most likely be here.
         -- -------------------------------------------------------------------------------------
         DF_MP5_1 = "mana per %d+ sec"                                             -- regular expression to find mana per 5
         DF_MP5_2 = "mana regen %d+ per %d+ sec"
         
         DF_HDB   = "healing done by"                                              -- Regular expresion to find healing done by (item)
         DF_UPTO  = "up to %d+"
         DF_HEAL_1= "healing spells %+"                                            -- Regular expression to find healing done by (item)                                             
         DF_SET   = ") set"
         DF_SET2  = "set:"
         DF_CREJUV= "rejuvenation"
         DF_HEAL_3= "healing spells %+%d+"
         DF_HEAL_2= "%+%d+ healing spells"
      
         -- -------------------------------------------------------------------------------------
         -- Wow GUI messages (should match messages return by the wow interface)
         -- -------------------------------------------------------------------------------------
         DF_CANTWHENSWIM                                   = "Cannot use while swimming"
         DF_ONLYWHENSWIM                                   = "Can only use while swimming"
   
         DF_UI_ERROR_MESSAGE                               = "UI_ERROR_MESSAGE"
         DF_LEARNED_SPELL_IN_TAB                           = "LEARNED_SPELL_IN_TAB"
         DF_SPELLCAST_START                                = "SPELLCAST_START"
         DF_SPELLCAST_STOP                                 = "SPELLCAST_STOP"
         DF_SPELLCAST_INTERRUPTED                          = "SPELLCAST_INTERRUPTED"
         DF_SPELLCAST_FAILED                               = "SPELLCAST_FAILED"
         DF_PLAYER_REGEN_ENABLED                           = "PLAYER_REGEN_ENABLED"
         DF_UNIT_INVENTORY_CHANGED                         = "UNIT_INVENTORY_CHANGED"
         DF_PLAYER_ENTERING_WORLD                          = "PLAYER_ENTERING_WORLD"
         DF_PLAYER_AURAS_CHANGED                           = "PLAYER_AURAS_CHANGED"
         DF_PLAYER_UNGHOST                                 = "PLAYER_UNGHOST"
         DF_PLAYER_ALIVE                                   = "PLAYER_ALIVE"
         DF_SPELLCAST_CHANNEL_STOP                         = "SPELLCAST_CHANNEL_STOP"
   
         DF_ANCHOR_NONE                                    = "ANCHOR_NONE"
         
      -- -------------------------------------------------------------------------------------
      -- Information messages send to the user
      -- -------------------------------------------------------------------------------------
         DF_WELCOME1                                       = "DruidFunc: DruidFunc Library Version "
         DF_WELCOME2                                       = " loaded." 
   
         DF_HEALRANGE                                      = "DruidFunc: Heal Range mod was found -- raid functionality altered!"
   
         DF_BASE_HUMAN                                     = "DruidFunc: Base armor set changed back to humanoid."
         DF_CASTING_REGROWTH_1                             = "DruidFunc: Casting Regrowth on "
         DF_CASTING_REGROWTH_2                             = ". (Regrowth rank "
         DF_CASTING_REGROWTH_3                             = "Regrowth(Rank "
   
         DF_FAILCAST                                       = "DruidFunc: Can not cast on this target right now (out of range, line of sight)"
         
         DF_REJUV_WARN_1                                   = "DruidFunc: Rejuvenation already on "
         DF_REJUV_WARN_2                                   = " press again to swiftmend!"
         DF_REJUV_WARN_3                                   = ", press again to refresh."
         DF_REJUV_WARN_4                                   = "DruidFunc: HoT on "
         DF_REJUV_WARN_5                                   = ". (Rejuvenation Rank "
   
         DF_SWIFTMEND_WARN_1                               = "DruidFunc: Target has no HoTs.   Casting Rejuvenation"
         DF_SWIFTMEND_WARN_2                               = "DruidFunc: Swiftmend is on cooldown!"
         DF_SWIFTMEND_WARN_3                               = "DruidFunc: You haven't learned swiftmend."
   
         DF_DERANK_WARN_1                                  = "Low Mana.  Need rank "
         DF_DERANK_WARN_2                                  = ".  Best cast rank "
   
         DF_HT_WARN_1                                      = "DruidFunc: Healing "
         DF_HT_WARN_2                                      = ". (Rank "
         DF_HT_WARN_3                                      = " heal/"
         DF_HT_WARN_4                                      = " needed. "
         DF_HT_WARN_4_1                                    = " max health."
         DF_HT_WARN_5                                      = "DruidFunc: Mana Conserve aborted the heal. Target @ "
         DF_HT_WARN_6                                      = "% abort set to "
         DF_HT_WARN_7                                      = "DruidFunc: Full Heal rank "
         DF_HT_WARN_8                                      = " (target health: "
         DF_HT_WARN_9                                      = ", health max: "
         DF_HT_WARN_10                                     = ", curr Health: "
         
         DF_I_WARN_1                                       = "DruidFunc: Innervate is on cooldown."
         DF_I_WARN_2                                       = "DruidFunc: Innervate already on "
         DF_I_WARN_3                                       = ".  Aborted"
         DF_I_WARN_4                                       = "DruidFunc: Innervate aborted.  "
         DF_I_WARN_5                                       = " has more than 50% mana"
         DF_I_WARN_6                                       = "DruidFunc: Casting Innervate on "
   
         DF_HIBERNATE_WARN_1                               = "DruidFunc: Casting hibernate (CC) on "
         DF_HIBERNATE_WARN_2                               = " <DO NOT ATTACK!>"
         DF_HIBERNATE_WARN_3                               = "DruidFunc: Invalid hibernation target."      
      
         DF_REBIRTH_WARN_1                                 = "DruidFunc: Resurrecting "
         DF_REBIRTH_WARN_2                                 = "DruidFunc: Invalid Rebirth target."
         
         DF_PRAYER_WARN_1                                  = "DruidFunc: Rejuvenation done, press again for swiftmend!"
   
         DF_PROWL_WARN_1                                   = "DruidFunc: Prowling not allowed while you have the WSG flag."
         
         DF_ASSIST_WARN_1                                  = "DruidFunc: Assist Failed... Not Visible or doesn't exist or not hostile"
         DF_ASSIST_WARN_2                                  = "DruidFunc: Assist Failed... Out of Range"
         DF_ASSIST_WARN_3                                  = "DruidFunc: Assist Failed... Assist is dead or bad target."
         DF_ASSIST_WARN_4                                  = "DruidFunc: Assist failed...  The person you are assisting is not in combat."
         
         DF_ACTIONREADY_WARN_1                             = "Spell or Item not found: "
         
         DF_QUICKSHIFT_WARN_1                              = "You already have that potion effect"
         DF_QUICKSHIFT_WARN_2                              = "That item is on cooldown and can not be used right now."
         
         DF_BEARBARK_POTNAME                               = "Spell_Nature_StoneClawTotem"
         
         DF_PATCHWERK_POTNAME                              = "greater stoneshield potion"
         DF_PATCHWERK_POTICON                              = "INV_Potion_69"
         
         DF_PATCHWERKTEST_POTNAME                          = "lesser stoneshield potion"
         DF_PATCHWERKTEST_POTICON                          = "INV_Potion_67"            
   
         DF_OFF                                            = "off"
         DF_ON                                             = "on"
         DF_AUTO                                           = "auto"
         
         DF_ICHAT                                          = "You've been innervated!   Cast normally for best results."
   
       -- -------------------------------------------------------------------------------------
       -- These hold the totem stomper stirings
       -- -------------------------------------------------------------------------------------
   
         DF_TOTEM_SENTRY     = "sentry totem"
         DF_TOTEM_WINDWALL   = "windwall totem"
         DF_TOTEM_FIRE       = "fire resistance totem"
         DF_TOTEM_FROST      = "frost resistance totem"
         DF_TOTEM_HEAL       = "healing totem"
         DF_TOTEM_POISON     = "poison clensing totem"
         DF_TOTEM_DISEASE    = "disease clesning totem"
         DF_TOTEM_STRENGTH   = "strength of earth totem"
         DF_TOTEM_STONECLAW  = "stoneclaw totem"
         DF_TOTEM_NATURE     = "nature resistance totem"
         DF_TOTEM_GRACE      = "grace of air totem"
         DF_TOTEM_STONESKIN  = "stoneskin totem"
         DF_TOTEM_EARTHBIND  = "earthbind totem"
         DF_TOTEM_MOONFLARE  = "moonflare totem"
         DF_TOTEM_GROUNDING  = "grounding totem"
         DF_TOTEM_SEARING    = "searing totem"
         DF_TOTEM_MAGMA      = "magma totem"
         DF_TOTEM_FIRENOVA   = "fire nova totem"
         DF_TOTEM_HEALSTREAM = "healing stream totem"
         DF_TOTEM_WINDFURY   = "windfury totem"
         DF_TOTEM_MANASPRING = "mana spring totem"
         DF_TOTEM_MANATIDE   = "mana tide totem"
         DF_TOTEM_TREMOR     = "tremor totem"
         DF_TOTEM_HEALWARD   = "healing ward"
         DF_TOTEM_BRAINWASH  = "brain wash totem"
         DF_TOTEM_POWERFUL   = "powerful healing ward"
         DF_TOTEM_LIGHTNING  = "lightning totem"
   
         DF_TOTEM_TOTEMIC    = "totemic"
         DF_TOTEM_TOTEM      = " totem"
         DF_TOTEM_WARD       = " ward"
   
       -- -------------------------------------------------------------------------------------
       -- These strings are the varions /druid and /df commands
       -- -------------------------------------------------------------------------------------
   
         DF_DRUID1   = "/DRUID"                                                    -- The /druid slash command
         DF_DRUID2   = "/DF"                                                       -- The /druid shortcut
         
         -- /druid home
         DF_HOME = "home"                                                          -- Command -- /df home = use hearthstone
         DF_HEARTHSTONE = "Hearthstone"                                            -- And the hearthstone itself
         DF_HOME_WARN_1 = "DruidFunc: Using Hearthstone."
         DF_HOME_WARN_2 = "DruidFunc: Hearthstone is on cooldown.  Failed."
         
         -- /druid port, /druid moonglade -- command -- cast teleport: moonglade
         DF_PORT = "port"                                                         
         DF_MOONGLADE = "moonglade"
         DF_PORT_WARN_1 = "DruidFunc: Teleport->Moonglade"
         
         -- /druid intro
         
         DF_DCMD_WARN_1 = "Use /druid (command) to get help for a specific command.   /druid moonbar, /druid smartcast, etc"
         DF_DCMD_WARN_2 = "Use /druid stats to get info about your character."
         
         DF_DCMD_WARN_3 = "/druid moonglade -- command, port to moonglade"
         DF_DCMD_WARN_4 = "/druid port -- command, port to moonglade"
         DF_DCMD_WARN_5 = "/druid home -- command, use hearthstone"
         
         -- /druid stats
         DF_STATS = "stats"
         DF_STATS_WARN_1 = "Your present +heal value from items: "
         DF_MANAREGEN = "mana regeneration"
         DF_STATS_WARN_2 = "Your present mana/5 value from items: "
         DF_STATS_WARN_3 = "Your present spirit regen (outside the 5 sec rule): "
         DF_STATS_WARN_4 = "Innervate will return around : "
         DF_STATS_WARN_5 = " mana (disregarding reflection and tier 2 set bonus)"
         
         -- /druid ichat
         DF_ICHATFLAG = "ichat"
         DF_ICHAT_WARN_1 = "Ichat saves the message you'd like to send your innervate targets."
         DF_ICHAT_WARN_2 = "usage: /druid ichat you've been innervated, keep casting normally for best results."
         DF_ICHAT_WARN_3 = "/druid ichat Innervate Whisper Message: "
         
         -- /druid plusheal
         DF_PLUSHEAL = "plusheal"
         DF_PLUSHEAL_WARN_1 = "/druid plusheal [off/auto/#]"
         DF_PLUSHEAL_WARN_2 = "This sets the healing touch offset.   Use off or zero to disable"
         DF_PLUSHEAL_WARN_3 = "Auto will calculate the value based on the +healing value of your gear"
         DF_PLUSHEAL_WARN_4 = "You can specify a number as well 200 or -200.  Positive numbers cause you to use"
         DF_PLUSHEAL_WARN_5 = "lower ranks of healing touch, positive numbers cause you to use higher ranks." 
         DF_PLUSHEAL_WARN_6 = "It's recommended this be off until you have more than 200 then use auto."
         DF_PLUSHEAL_WARN_7 = "/druid plusheal [auto/off/number] (Set healing touch offset) is: "
         
         -- /druid hardshift
         DF_HARDSHIFT = "hardshift"
         DF_HARDSHIFT_WARN_1 = "When on prevents the shift bear/cat keys/macros from shifting you out of form" 
         DF_HARDSHIFT_WARN_2 = "When off toggles you between requested form and humanoid."
         DF_HARDSHIFT_WARN_3 = "/druid hardshift [on/off]"
         DF_HARDSHIFT_WARN_4 = "/druid hardshift [on/off] (change shapeshift key functionality) is: "
   
         -- /druid assist                      (Note we use DF_SASSIST for slash assist here, because the assist function has it's own warn messages)
         DF_SASSIST = "assist"
         DF_SASSIST_WARN_1 = "Use /druid assist off to disable | Use /druid assist on to re-enable using last assist"
         DF_SASSIST_WARN_2 = "Use /druid assist <name> to set a spellcast assist (and enable assisting)"
         DF_SASSIST_WARN_3 = "/druid assist [on/off/name] (set spellcasting assist) is set to: "
         
         -- /druid manac
         DF_MANAC = "manac"
         DF_MANAC_WARN_1 = "ManaC [off/silent/announce/10-100]" 
         DF_MANAC_WARN_2 = "Sets the health threashold that will abort a healing touch spell.  For instance"
         DF_MANAC_WARN_3 = "/druid manac 90 will abort healing touch if the target's health is over 90%"
         DF_MANAC_WARN_4 = "silent will keep aborts from being announced in the chat box, announce turns abort messages on."
         DF_MANAC_WARN_5 = "silent (no announce in chat box)"
         DF_MANAC_WARN_6 = "announce (aborts appear in chat box)"
         DF_MANAC_WARN_7 = "/druid manac [off/silent/announce/10-100] is set to: "
         DF_SILENT = "silent"
         DF_ANNOUNCE = "announce"
         
         -- /druidmanaswap
         DF_MANASWAP = "manaswap"
         DF_MANASWAP_WARN_1 = "Manaswap sets the threshold low mana weapon swaps happen." 
         DF_MANASWAP_WARN_2 = "The default is 85 which means when your mana pool falls below 85%"
         DF_MANASWAP_WARN_3 = "The low mana weapon set will be equipped.   Valid values are 0-100."
         DF_MANASWAP_WARN_4 = "0 basically disables this functionality, 100 is just wierd."
         DF_MANASWAP_WARN_5 = "/druid manaswap [0-100] (Low mana swap threshold) is set to: "
   
         -- /druidmoonbar
         DF_MOONBAR = "moonbar"
         DF_MOONBAR_WARN_1 = "Moonbar sets the toolbar that will be switched to when you" 
         DF_MOONBAR_WARN_2 = "switch to the moonkin form.   The toolbars are 1-6."
         DF_MOONBAR_WARN_3 = "Setting moonbar to 0 will disable toolbar switching entierly."
         DF_MOONBAR_WARN_4 = "/druid moonbar [0-5] (Moonkin action bar) is set to: "
   
         -- /druid smartcast
         DF_SMARTCAST = "smartcast"
         DF_SMARTCAST_WARN_1 = "Smartcast will change the casting target automatically in certian situations." 
         DF_SMARTCAST_WARN_2 = "If you cast a heal on a hostile target, the heal will be redirected to the person your hostile target is targeting."
         DF_SMARTCAST_WARN_3 = "If you cast a damage spell on a friendly target, the spell will be redirected to the friendly target's target"
         DF_SMARTCAST_WARN_4 = "Smartcasting off disables this functionality."
         DF_SMARTCAST_WARN_5 = "/druid smartcast [on/off] (auto target assist) is set to : on"
         DF_SMARTCAST_WARN_6 = "/druid smartcast [on/off] (auto target assist) is set to : off"
   
         -- /druid target     (note we use DF_STARGET here because DF_TARGET is an actual command (player's target) that we use elsewhere )
         DF_STARGET = "target"
         DF_STARGET_WARN_1 = "When on will target yourself if you hit the humanoid key while already in human form." 
         DF_STARGET_WARN_2 = "When off will attempt to self-cast heals (similar to desperate prayer) without"
         DF_STARGET_WARN_3 = "losing your target.  If you play a cat often /druid target off is prefered." 
         DF_STARGET_WARN_4 = "/druid target [on/off] is set to : on (target self when humanoid key pressed)"
         DF_STARGET_WARN_5 = "/druid target [on/off] is set to : off (cast self-heal when humanoid key is pressed)" 
   
         -- /druid trinkets
         DF_TRINKETS = "trinkets"
         DF_TRINKETS_WARN_1 = "If you set trinkets to on then druidfunc will try to use some common"             
         DF_TRINKETS_WARN_2 = "trinkets durring common actions.  For instance it will always try to use"             
         DF_TRINKETS_WARN_3 = "the hibernation crystal when you cast a heal and rune of metamorphasis"             
         DF_TRINKETS_WARN_4 = "when you shapeshift.  The allowed values are on and off."             
         DF_TRINKETS_WARN_5 = "/druid trinkets [on/off] (auto trinket usage) is set to : on"            
         DF_TRINKETS_WARN_6 = "/druid trinkets [on/off] (auto trinket usage) is set to : off"             
   
         -- /druid prayer   (note we use SPRAYER to avoid conflicts elsehwere)
         DF_SPRAYER = "prayer"      
         DF_SPRAYER_WARN_1 = "Specifies the percentage of your (or your target's health) before" 
         DF_SPRAYER_WARN_2 = "desperate healing starts burning your cooldown.   /druid prayer 50 means"
         DF_SPRAYER_WARN_3 = "the target must be at 50% health or less before your cooldowns will be used."
         DF_SPRAYER_WARN_4 = "/druid prayer [25-100] (desperate heal, health threshold) is: "
         
         -- -------------------------------------------------------------------------------------
         -- DOUTFIT area
         -- -------------------------------------------------------------------------------------
   
         DF_DOUTFIT1 = "/DOutfit"                                                  -- The /doutfit slash command (yes you can change it)
         DF_DOUTFIT2 = "/DO"                                                       -- The /doutfit shortcut
   
         DF_DO_WEAPON = "weapon"
         DF_DO_OUTFIT = "outfit"
         DF_DO_SAVE   = "save"
         DF_DO_MOON   = "moon"
   
         DF_DO_WARN_1 = "Usage: /doutfit [on/off/outfit/weapon/{set name}] [off/save]"
         DF_DO_WARN_2 = "Example (save bear set): /doutfit bear save"       
         DF_DO_WARN_3 = "Example (Use fire resist set): /doutfit fire"      
         DF_DO_WARN_4 = "Example (Auto equip only weapons): /doutfit weapon"      
         DF_DO_WARN_5 = "Example (Auto Equip everything): /doutfit outfit"       
         DF_DO_WARN_6 = "Example (Disable automatic equips): /doutfit off"       
         DF_DO_WARN_7 = "Set names: human, bear, cat, aqua, travel, moon, mount, heal, pvp, fire, nature, arcane, frost, shadow, wsg, special1, special2, special3, and Temp"      
         DF_DO_WARN_8 = "DruidFunc: The outfitter is presently on"      
         DF_DO_WARN_9 = "DruidFunc: The outfitter is presently off"       
         DF_DO_WARN_10= "DruidFunc: The outfitter presently is swapping only weapons"       
         DF_DO_WARN_11= "DruidFunc: The outfitter presently is swapping everything, armor and weapons."       
         DF_DO_WARN_12= "DruidFunc: Automatic wardrobe changes have been disabled."
         DF_DO_WARN_13= "DruidFunc: Automatic wardrobe changes will only affect weapons/idols"       
         DF_DO_WARN_14= "DruidFunc: Automatic wardrobe changes will now affect all gear when not in combat"        
         DF_DO_WARN_15= "DruidFunc: Automatic wardrobe changes have been enabled."       
         DF_DO_WARN_16= "DruidFunc: Cat form wardobe is disabled"       
         DF_DO_WARN_17= "DruidFunc: Cat form wardrobe selection saved"        
         DF_DO_WARN_18= "DruidFunc: Base set is now presently Cat set"      
         DF_DO_WARN_19= "DruidFunc: Moonkin form wardobe is disabled"        
         DF_DO_WARN_20= "DruidFunc: Moonkin form wardrobe selection saved"      
         DF_DO_WARN_21= "DruidFunc: Base set is now presently Moonkin set"       
         DF_DO_WARN_22= "DruidFunc: Travel form wardobe is disabled"      
         DF_DO_WARN_23= "DruidFunc: Travel form wardrobe selection saved"       
         DF_DO_WARN_24= "DruidFunc: Base set is now presently Travel Form set"      
         DF_DO_WARN_25= "DruidFunc: Aquatic form wardobe is disabled"       
         DF_DO_WARN_26= "DruidFunc: Aquatic form wardrobe selection saved"       
         DF_DO_WARN_27= "DruidFunc: Base set is now presently Aquatic Form set"       
         DF_DO_WARN_28= "DruidFunc: Bear form wardobe is disabled"       
         DF_DO_WARN_29= "DruidFunc: Bear form wardrobe selection saved"       
         DF_DO_WARN_30= "DruidFunc: Base set is now presently Bear set"       
         DF_DO_WARN_31= "DruidFunc: Human form wardobe is disabled"       
         DF_DO_WARN_32= "DruidFunc: Human form wardrobe selection saved"       
         DF_DO_WARN_33= "DruidFunc: Base set is now presently Humanoid set"       
         DF_DO_WARN_34= "DruidFunc: Low Mana wardobe is disabled"       
         DF_DO_WARN_35= "DruidFunc: Low Mana wardrobe selection saved"     
         DF_DO_WARN_36= "DruidFunc: Base set is now presently the Low Mana set"       
         DF_DO_WARN_37= "DruidFunc: Innervate wardobe is disabled"       
         DF_DO_WARN_38= "DruidFunc: Innervate wardrobe selection saved"       
         DF_DO_WARN_39= "DruidFunc: Base set is now presently the Innervate set"       
         DF_DO_WARN_40= "DruidFunc: Fire resist wardobe is disabled"       
         DF_DO_WARN_41= "DruidFunc: Fire Resist wardrobe selection saved"      
         DF_DO_WARN_42= "DruidFunc: Base set is now presently the Fire Resist set"       
         DF_DO_WARN_43= "DruidFunc: PvP wardobe is disabled"       
         DF_DO_WARN_44= "DruidFunc: PvP wardrobe selection saved"       
         DF_DO_WARN_45= "DruidFunc: Base set is now presently the PvP set"       
         DF_DO_WARN_46= "DruidFunc: Warsong Gulch wardobe is disabled"       
         DF_DO_WARN_47= "DruidFunc: Warsong Gulch wardrobe selection saved"       
         DF_DO_WARN_48= "DruidFunc: Base set is now presently the Warsong Gulch set"       
         DF_DO_WARN_49= "DruidFunc: Nature Resist wardobe is disabled"       
         DF_DO_WARN_50= "DruidFunc: Nature Resist wardrobe selection saved"       
         DF_DO_WARN_51= "DruidFunc: Base set is now presently the Nature Resist set"       
         DF_DO_WARN_52= "DruidFunc: Mounted wardobe is disabled"       
         DF_DO_WARN_53= "DruidFunc: Mounted wardrobe selection saved"      
         DF_DO_WARN_54= "DruidFunc: Base set is now presently the Mounted set"       
         DF_DO_WARN_55= "DruidFunc: Arcane Resist Set is disabled"       
         DF_DO_WARN_56= "DruidFunc: Arcane Resist selection saved"       
         DF_DO_WARN_57= "DruidFunc: Base set is now presently the Arcane Resist Set"       
         DF_DO_WARN_58= "DruidFunc: Shadow Resist Set is disabled"       
         DF_DO_WARN_59= "DruidFunc: Shadow Resist selection saved"     
         DF_DO_WARN_60= "DruidFunc: Base set is now presently the Shadow Resist Set"       
         DF_DO_WARN_61= "DruidFunc: Frost Resist set  is disabled"        
         DF_DO_WARN_62= "DruidFunc: Frost Resist Set selection saved"       
         DF_DO_WARN_63= "DruidFunc: Base set is now presently the Frost Resistance Set"       
         DF_DO_WARN_64= "DruidFunc: Healing set is disabled"       
         DF_DO_WARN_65= "DruidFunc: Healing Set selection saved"       
         DF_DO_WARN_66= "DruidFunc: Base set is now presently the Healing Set"       
         DF_DO_WARN_67= "DruidFunc: Temporary set is disabled"       
         DF_DO_WARN_68= "DruidFunc: Temporary Set selection saved"       
         DF_DO_WARN_69= "DruidFunc: Base set is now presently your Temporary Set"       
         DF_DO_WARN_70= "DruidFunc: User Defined set 1  is disabled"        
         DF_DO_WARN_71= "DruidFunc: User defined set 1 selection saved"       
         DF_DO_WARN_72= "DruidFunc: Base set is now presently the user defined set 1"       
         DF_DO_WARN_73= "DruidFunc: User Defined set 2 is disabled"       
         DF_DO_WARN_74= "DruidFunc: User defined set 2 selection saved"       
         DF_DO_WARN_75= "DruidFunc: Base set is now presently the user defined set 2"       
         DF_DO_WARN_76= "DruidFunc: User Defined set 3 is disabled"       
         DF_DO_WARN_77= "DruidFunc: User defined set 3 selection saved"       
         DF_DO_WARN_78= "DruidFunc: Base set is now presently the user defined set 3"       

   end;
