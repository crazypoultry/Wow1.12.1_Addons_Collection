--[[
Localization for Shammy Buff
English Client
Instructions: Change the below text in QUOTES to reflect what the 
english words mean in your language. Pretty simple!

-- |cffffd200 and |cffffff00 are color codes, ignore those. Change the words only.
]]

SB_Version = "3.5" -- Do not touch

-- Misc Stuff
BINDING_HEADER_SBUFF = "Shammy Buff Actions"
BINDING_NAME_SBUFF_CAST = "Shammy Buff Cast Key"
SB_UC = "Undercity"
SB_Org = "Orgrimmar"
SB_Thu = "Thunder Bluff"
SB_Fish = "Fishing Pole"

--All lower case for the Coms
SB_HelpCom = "help"
SB_ResetCom = "reset"
SB_DebugCom = "debug"
SB_CastCom = "cast"

SB_Help1 = "Shammy Buff v|cffffd200".. SB_Version .."|cffffff00 HELP!"
SB_Help2 = "/sbuff |cffffd200- launch config"
SB_Help3 = "/sbuff cast |cffffd200- Used in a macro to cast instead of a keybinding"
SB_Help4 = "/sbuff wep buffname|cffffd200 - the name of the weapon buff you wish to cast" 
SB_Help5 = "/sbuff reset |cffffd200- break something? use this to reset all values" 
SB_Help6 = "/sbuff debug |cffffd200- spams your main window with all the current flags"
SB_Help7 = "/sbuff help |cffffd200- this help menu"

-- Spell Names
SB_WindWep = "Windfury Weapon"
SB_FlameWep = "Flametongue Weapon"
SB_FrostWep = "Frostbrand Weapon"
SB_RockWep = "Rockbiter Weapon"
SB_Windfury = "Windfury"
SB_Flametongue = "Flametongue"
SB_Frostbrand = "Frostbrand" 
SB_Rockbiter = "Rockbiter" 
SB_Weapon = "Weapon"
SB_Bezerk = "Berserking"
SB_NS = "Nature's Swiftness"
SB_LHW = "Lesser Healing Wave" 
SB_HW = "Healing Wave"
SB_LS = "Lightning Shield"
SB_GhostWolf = "Ghost Wolf"

-- Messages
SB_Welcome = "|cffffd200 Shammy Buff v|cffffff00" .. SB_Version .. "|cffffd200 by kneeki loaded - usage: |cffffff00 /sbuff"
SB_NotWelcome = "|cffffd200 Shammy Buff v|cffffff00" .. SB_Version .. "|cffffd200 by kneeki NOT loaded, You arn't a Shaman!"
SB_NSNOW = "Nature's Swiftness Heal NOW!"
SB_ResetCom2 = "All variables reset to default on first run state"
SB_Invalid = "Invalid Command! |cffffff00"
SB_BezNOW = "Berserk NOW!"
SB_DebuffMsg = "Cureable Debuff detected!"
SB_AutoBuff = "Autobuffing with: |cffffff00"
SB_RecastLS = "Recast Lightning Shield"
SB_RecastWep = "Recast Weapon Buff!"
SB_DecError = "You do not have Decursive. Disabling this feature!"
SB_Waiting = "A spell is currently awaiting target"
SB_VarError = "Variables missing! Reloading all global vars!"

-- CT integration
SBCT_Name = "Shammy Buff Options"
SBCT_Icon = "Interface\\Icons\\Spell_Nature_LightningShield"
SBCT_Description = "Click to edit your Shammy Buff options!"