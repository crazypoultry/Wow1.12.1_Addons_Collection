SqueakyLoc = {}
SqueakyLoc.Name = "SqueakyWheel"
-- Slash Commands
SqueakyLoc.Config = "config"
SqueakyLoc.Config2 = "menu"
SqueakyLoc.Reset = "reset"
SqueakyLoc.On = "on"
SqueakyLoc.Off = "off"
SqueakyLoc.Bars = "bars"
SqueakyLoc.DeltaMax = "max"
SqueakyLoc.DeltaWeight = "weight"
SqueakyLoc.Blacklist = "blacklist"
SqueakyLoc.Spacing = "spacing"
SqueakyLoc.Height = "height"
SqueakyLoc.Width = "width"
SqueakyLoc.CT_RA = "ctra"
SqueakyLoc.Debug = "debug"
SqueakyLoc.Lock = "lock"
SqueakyLoc.ShowAll = "showall"
SqueakyLoc.TextClassColor = "textclasscolor"

-- Messages
SqueakyLoc.ResetMsg = "SqueakyWheel has detected a new version."
SqueakyLoc.ResetMsg2 = "Reloading default configuration from SqueakyWheel_Config.lua."
SqueakyLoc.VersionMsg = "Warning!  Default Configuration is also out of date.  Please replace with an updated file."
SqueakyLoc.DisplayMode = "Display Mode"
SqueakyLoc.Load = " is now active."
SqueakyLoc.SetTo = " is now set to "
SqueakyLoc.SetToOn = "|cff00ff00On|r."
SqueakyLoc.SetToOff = "|cffff0000Off|r."
SqueakyLoc.Error = ":  Invalid setting."
SqueakyLoc.Target = "Target "..SqueakyLoc.Name.." Unit "

-- Help Message
SqueakyLoc.HelpText1 = "SqueakyWheel help:"
SqueakyLoc.HelpText2 = "/squeakywheel or /squeaky or /squeak to display config menu."
SqueakyLoc.HelpText3 = "|cff00ff00reset|r: Resets configuration to default"
SqueakyLoc.HelpText4 = "|cff00ff00off|r: Hides SqueakyWheel"
SqueakyLoc.HelpText5 = "|cff00ff00on|r: Displays SqueakyWheel"
SqueakyLoc.HelpText6 = "|cff00ff00bars|r: Number of health bars to display (2-15)"
SqueakyLoc.HelpText7 = "|cff00ff00max|r: Duration of recent activity to record (2-30) seconds"
SqueakyLoc.HelpText8 = "|cff00ff00weight|r: Amount of health 1 second of recent activity is worth (1-20)% health"
SqueakyLoc.HelpText9 = "|cff00ff00blacklist <n>|r: Duration of blacklist when target is out of range (1-15) seconds"
SqueakyLoc.HelpText10 = "|cff00ff00spacing <n>|r: Adjusts spacing in between health bars (0-10) pixels"
SqueakyLoc.HelpText11 = "|cff00ff00height <n>|r: Adjusts height of health bars (default 12) pixels"
SqueakyLoc.HelpText12 = "|cff00ff00width <n>|r: Adjusts width of health bars (default 100) pixels"
SqueakyLoc.HelpText13 = "|cff00ff00ctra|r: (toggle) Replaces CT_RA Emergency Monitor with SqueakyWheel unit sort"
SqueakyLoc.HelpText14 = "|cff00ff00debug|r: (toggle) Display debug messages"
SqueakyLoc.HelpText15 = "|cff00ff00lock|r: (toggle) lock window position"
SqueakyLoc.HelpText16 = "|cff00ff00showall|r: (toggle) Always show all health bars, or hide uninjured members"
SqueakyLoc.HelpText17 = "|cff00ff00textclasscolor|r: (toggle) Color text based on class"
SqueakyLoc.HelpText18 = "|cff00ff00barclasscolor|r: (toggle) Color bars based on class"
SqueakyLoc.HelpText = {
    SqueakyLoc.HelpText1,
    SqueakyLoc.HelpText2,
    SqueakyLoc.HelpText3,
    SqueakyLoc.HelpText4,
    SqueakyLoc.HelpText5,
    SqueakyLoc.HelpText6,
    SqueakyLoc.HelpText7,
    SqueakyLoc.HelpText8,
    SqueakyLoc.HelpText9,
    SqueakyLoc.HelpText10,
    SqueakyLoc.HelpText11,
    SqueakyLoc.HelpText12,
    SqueakyLoc.HelpText13,
    SqueakyLoc.HelpText14,
    SqueakyLoc.HelpText15,
    SqueakyLoc.HelpText16,
    SqueakyLoc.HelpText17,
    SqueakyLoc.HelpText18,
}

-- Bindings
BINDING_HEADER_SQUEAKYWHEEL = SqueakyLoc.Name
BINDING_NAME_SQUEAKY_TARGET1 = SqueakyLoc.Target.."1"
BINDING_NAME_SQUEAKY_TARGET2 = SqueakyLoc.Target.."2"
BINDING_NAME_SQUEAKY_TARGET3 = SqueakyLoc.Target.."3"
BINDING_NAME_SQUEAKY_TARGET4 = SqueakyLoc.Target.."4"
BINDING_NAME_SQUEAKY_TARGET5 = SqueakyLoc.Target.."5"

