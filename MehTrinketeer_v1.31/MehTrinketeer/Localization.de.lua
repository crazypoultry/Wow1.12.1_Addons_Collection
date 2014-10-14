
-- Module: MehTrinketeer
-- Author: Mehran Shahir
-- Description: German Localization file
-- Instructions:  Translate each phrase keeping them enclosed in the quotation marks (").  It will
--                be useful to do a "/console reloadui" in WOW to see if your translations fit
--                correctly.

if GetLocale() == "deDE" then

MT_TXT_PASSIVES            = "Passives"
MT_TXT_COOLDOWNS           = "Cooldowns"
MT_TXT_AUTOUSE             = "A-Use"
MT_TXT_PALETTE             = "Palette"
MT_TXT_SETUP               = "Setup"
MT_TXT_CURR_SETUP          = "Current Setup"
MT_TXT_AUTO_LOAD           = "Load This In Zone"
MT_TXT_ADD_SETUP           = "Add New Setup"
MT_TXT_DELETE              = "Delete"
MT_TXT_ADD                 = "Add"
MT_TXT_RESET               = "Reset"
MT_TXT_ADVANCED            = "Advanced"
MT_TXT_REFRESH_LIST        = "Refresh Lists"
MT_TXT_CHANGE_PRIORITIES   = "Change Priorities"
MT_TXT_CHANGE_TYPES        = "Change Types"
MT_TXT_PASSIVES_ONQ        = "Passives On?"
MT_TXT_COOLDOWNS_ONQ       = "Cooldowns On?"
MT_TXT_YES_AUTO_USE        = "Yes, Automatically Use Selected Trinket When"
MT_TXT_MY_HEALTH_BETWEEN   = "My Health is Between"
MT_TXT_TRG_HEALTH_BETWEEN  = "My Target's Health is Between"
MT_TXT_YES                 = "Yes"
MT_TXT_NO                  = "No"
MT_TXT_OKAY                = "Okay"
MT_TXT_MT_OPTIONS          = "MehTrinketeer Options"
MT_TXT_AUTO_EQUIP_CARROT   = "Auto-equip Carrot on a Stick"
MT_TXT_ASK_ARGENT_DAWN     = "Ask to equip Argent Dawn trinket"
MT_TXT_LOCK_MT_FRAME       = "Lock MehTrinketeer frame position"
MT_TXT_HIDE_ICON           = "Hide mini-map icon (use /mehopts instead)"
MT_TXT_LOCKED_Q            = "Locked?"
MT_TXT_AUTO_USE_ON_Q       = "Auto-Use On?"
MT_TXT_MINIMUM             = "Minimum"
MT_TXT_MAXIMUM             = "Maximum"
MT_TXT_LEFT_CLICK_OPTIONS  = "Left-click for options."
MT_TXT_RIGHT_CLICK_DRAG    = "Right-click and drag to move button."
MT_TXT_DEFAULT             = "Default"
MT_TXT_LOAD_IF_ELSE        = "Load If Nothing Else Loads"
MT_TXT_DUNGEONS            = "Dungeons"
MT_TXT_PVP                 = "PVP"
MT_TXT_CURRENT_ZONE        = "Current Zone"
MT_TXT_LOAD_MYSELF         = "I'll Load It Myself"
MT_TXT_LOAD_SUCCESS        = "MehTrinketeer loaded successfully."

-- these are the commands that the user will type into the chat interface
MT_TXT_COMMAND_HELP        = "/mehhelp"
MT_TXT_COMMAND_SHOW        = "/mehshow"
MT_TXT_COMMAND_LOAD        = "/mehload"
MT_TXT_COMMAND_USE         = "/mehuse"
MT_TXT_COMMAND_SHOW_OPTS   = "/mehopts"

-- make sure the slash commands you put in this next one match what you choose above
MT_TXT_USE_HELP            = "Use /mehshow to show/hide addon.  Use /mehhelp for quickstart."

MT_TXT_HELP_PREFIX         = "[MehHelp] "

-- leave this alone
MT_TXT_HELP_LIST = {}

tinsert(MT_TXT_HELP_LIST, "1) Open up Setup and organize your trinkets into either the")
tinsert(MT_TXT_HELP_LIST, "Passives list or the Cooldowns list.")
tinsert(MT_TXT_HELP_LIST, "2) Prioritize your cooldown trinkets (left to right, top to")
tinsert(MT_TXT_HELP_LIST, "bottom, top left spot has highest priority.)")
tinsert(MT_TXT_HELP_LIST, "3) Note that if you don't want something to be managed by")
tinsert(MT_TXT_HELP_LIST, "the mod you can put it in the Passives list at slot 3 or")
tinsert(MT_TXT_HELP_LIST, "above and it will never be equipped.")
tinsert(MT_TXT_HELP_LIST, "4) Use the Palette like this: left click on a trinket to")
tinsert(MT_TXT_HELP_LIST, "equip it into the 1st slot, right click to equip into the 2nd slot.")

MT_TXT_ARGENT_DAWN_Q       = "Would you like to equip your Argent Dawn trinket?"
MT_TXT_ARGENT_DAWN_SEAL    = "Seal of the Dawn"
MT_TXT_ARGENT_DAWN_RUNE    = "Rune of the Dawn"
MT_TXT_ARGENT_DAWN_COMM    = "Argent Dawn Commission"

-- leave this line alone
MT_TXT_PVPS_LIST = {}

-- Note: you may change the order of these lines to make it alphabetical in your target language
tinsert(MT_TXT_PVPS_LIST, "Alterac Valley")
tinsert(MT_TXT_PVPS_LIST, "Arathi Basin")
tinsert(MT_TXT_PVPS_LIST, "Warsong Gulch")

-- leave this line alone
MT_TXT_DUNGEONS_LIST = {}

-- Note: you may change the order of these lines to make it alphabetical in your target language
tinsert(MT_TXT_DUNGEONS_LIST, "Ahn'Qiraj")
tinsert(MT_TXT_DUNGEONS_LIST, "Blackfathom Deeps")
tinsert(MT_TXT_DUNGEONS_LIST, "Blackrock Depths")
tinsert(MT_TXT_DUNGEONS_LIST, "Blackrock Spire")
tinsert(MT_TXT_DUNGEONS_LIST, "Blackwing Lair")
tinsert(MT_TXT_DUNGEONS_LIST, "Dire Maul")
tinsert(MT_TXT_DUNGEONS_LIST, "Gnomeregan")
tinsert(MT_TXT_DUNGEONS_LIST, "Maraudon")
tinsert(MT_TXT_DUNGEONS_LIST, "Molten Core")
tinsert(MT_TXT_DUNGEONS_LIST, "Naxxramas")
tinsert(MT_TXT_DUNGEONS_LIST, "Onyxia's Lair")
tinsert(MT_TXT_DUNGEONS_LIST, "Ragefire Chasm")
tinsert(MT_TXT_DUNGEONS_LIST, "Razorfen Downs")
tinsert(MT_TXT_DUNGEONS_LIST, "Razorfen Kraul")
tinsert(MT_TXT_DUNGEONS_LIST, "Ruins of Ahn'Qiraj")
tinsert(MT_TXT_DUNGEONS_LIST, "Scarlet Monastary")
tinsert(MT_TXT_DUNGEONS_LIST, "Scholomance")
tinsert(MT_TXT_DUNGEONS_LIST, "Shadowfang Keep")
tinsert(MT_TXT_DUNGEONS_LIST, "Stratholme")       
tinsert(MT_TXT_DUNGEONS_LIST, "The Deadmines")
tinsert(MT_TXT_DUNGEONS_LIST, "The Stockade")
tinsert(MT_TXT_DUNGEONS_LIST, "The Temple of Atal'Hakkar")
tinsert(MT_TXT_DUNGEONS_LIST, "The Wailing Caverns")
tinsert(MT_TXT_DUNGEONS_LIST, "Uldaman")   
tinsert(MT_TXT_DUNGEONS_LIST, "Zul'Farrak")
tinsert(MT_TXT_DUNGEONS_LIST, "Zul'Gurub")


-- Here is how this list works:
-- Left Side: Trinket Name
-- Right Side: Buff Name that using the Trinket gives you
gSpecialCases = {

["Arcane Infused Gem"]                 = "Arcane Infused",
["Arena Grand Master"]                 = "Aura of Protection",
["Blazing Emblem"]                     = "Blazing Emblem",
["Blessed Prayer Beads"]               = "Prayer Beads Blessing",
["Burst of Knowledge"]                 = "Burst of Knowledge",
["Defiler's Talisman"]                 = "Damage Absorb",
["Devilsaur Eye"]                      = "Devilsaur Fury",
["Devilsaur Tooth"]                    = "Primal Instinct",
["Draconic Infused Emblem"]            = "Chromatic Infusion",
["Eye of Diminution"]                  = "The Eye of Diminution",
["Eye of Moam"]                        = "Obsidian Insight",
["Fetish of Chitinous Spikes"]         = "Chitinous Spikes",
["Fetish of the Sand Reaver"]          = "Arcane Shroud",
["Fire Ruby"]                          = "Chaos Fire",
["Glimmering Mithril Insignia"]        = "Fearless",
["Gri'lek's Charm of Valor"]           = "Brilliant Light",
["Hazza'rah's Charm of Destruction"]   = "Massive Destruction",
["Hazza'rah's Charm of Healing"]       = "Rapid Healing",
["Hazza'rah's Charm of Magic"]         = "Arcane Potency",
["Hibernation Crystal"]                = "Healing of the Ages",
["Lifegiving Gem"]                     = "Gift of Life",
["Mar'li's Eye"]                       = "Mar'li's Brain Boost",
["Mind Quickening Gem"]                = "Mind Quickening",
["Nat Pagle's Broken Reel"]            = "Pagle's Broken Reel",
["Natural Alignment Crystal"]          = "Nature Aligned",
["Petrified Scarab"]                   = "Mercurial Shield",
["Rune of Metamorphosis"]              = "Metamorphosis Rune",
["Scarab Brooch"]                      = "Persistent Shield",
["Scrolls of Blinding Light"]          = "Blinding Light",
["Talisman of Arathor"]                = "Damage Absorb",
["Talisman of Ascendance"]             = "Ascendance",
["Talisman of Ephemeral Power"]        = "Ephemeral Power",
["The Black Book"]                     = "Blessing of the Black Book",
["Wushoolay's Charm of Nature"]        = "Nimble Healing Touch",
["Wushoolay's Charm of Spirits"]       = "Energized Shield",
["Zandalarian Hero Badge"]             = "Brittle Armor",
["Zandalarian Hero Charm"]             = "Unstable Power",
["Zandalarian Hero Medallion"]         = "Restless Strength",

}

end