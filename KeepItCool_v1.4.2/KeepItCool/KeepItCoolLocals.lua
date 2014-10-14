KIC = {
SEARCHFILTER1 = gsub(LOOT_ITEM_CREATED_SELF, "%%.-s", ".-Hitem:(.-):.-"),
SEARCHFILTER2 = gsub(LOOT_ITEM_PUSHED_SELF, "%%.-s", ".-Hitem:(.-):.-"),
UNLEARNFILTER = gsub(ERR_SPELL_UNLEARNED_S, "%%.-s", "(.*)"),
SETSYN  = "set screen|chat|sound|across|startup [on|off|tog]",
TIMESYN = "time [remaining|game|local]",
ITEMS = {
	["7076"]  = {t = 86400,  i = 1}, -- Essence of Earth
	["7078"]  = {t = 86400,  i = 1}, -- Essence of Fire
	["7082"]  = {t = 86400,  i = 1}, -- Essence of Air
	["7080"]  = {t = 86400,  i = 1}, -- Essence of Water
	["12803"] = {t = 86400,  i = 1}, -- Living Essence
	["12808"] = {t = 86400,  i = 1}, -- Essence of Undeath
	["12360"] = {t = 172800, i = 1}, -- Arcanite Bar
	["15409"] = {t = 259200, i = 2}, -- Refined Deeprock Salt
	["14342"] = {t = 345600, i = 3}, -- Mooncloth
	["17202"] = {t = 86400,  i = 4}, -- Snowball
	["7068"]  = {t = 600,    i = 1}, -- Elemental Fire
	["21536"] = {t = 86400,  i = 5}, -- Elune Stone
	["11024"] = {t = 600,    i = 6}, -- 늘푸른 약초 주머니
	}
}

if( not ace:LoadTranslation("kic") ) then

ace:RegisterGlobals({
	version = 1.01,
	ACEG_MAP_ONOFF = {[0]="|cffff5050Off|r",[1]="|cff00ff00On|r"}
})

-- Info for Ace
KIC.NAME        = "KeepItCool"
KIC.DESCRIPTION	= "Reminds you when your tradeskill cooldowns are up."

-- Tradeskill categories. Shown in the reminders, with KIC.REMIND.
KIC.CAT = {
	"Transmutation",  
	"Salt Shaker", 	
	"Mooncloth",     
	"Snowmaster 9000",
	"Lantern",
	"Green Pouch",
}
-- Profession names. Used to check whether a particular profession is unlearned, by scanning the message that appears when you unlearn a skill, for example "You have unlearned Alchemy."
KIC.PROF = {
	["Alchemy"]        = 1,
	["Leatherworking"] = 2,
	["Tailoring"]      = 3,
	["Engineering"]    = 4
}

-- The following entries are displayed by KIC. Anywhere where it says %s will be replaced with the text in the commment on the same line, in the order they are listed. If you want to change the order, change the %s to %x$s, where x is the order number you want there. For example: "%1$s%3$s%2$s" -- a, b, c would turn out as "acb"
-- The message displayed when a cooldown is detected.
KIC.ADD           = "%s cooldown detected, reminder scheduled in %s!" -- One of the items in KIC.CAT, cooldown length.
-- The message displayed when a cooldown is done
KIC.REMIND        = "Your %s cooldown has expired!" -- One of the items in KIC.CAT.
KIC.REMOTEREMIND  = "The %s cooldown for %s has expired!" -- One of the items in KIC.CAT, the character that the CD has finished for.
-- The message displayed when there is nothing to report from db
KIC.EMPTYDB       = "There are no cooldowns being tracked."
-- Reset messages
KIC.RESETASK      = "Are you sure you want to reset? Type '/kic reset confirm' to do this."
KIC.RESET         = "Db reset."
-- Options
KIC.REPORT  = { -- These will be displayed in the settings report (/kic report) as well as when the player uses /kic set.
	screen  = "Screen:",
	chat    = "Chat:",
	sound   = "Sound:",
	across  = "Across Chars:",
	startup = "On Startup:"
}

-- Values used in /kic set
KIC.ON = "on"
KIC.OFF = "off"
KIC.TOG = "tog"

-- Report. Used for /kic reportdata.
KIC.DATAREPORT = "Data Report" 
KIC.REMAINING  = " remaining." -- Mind the leading space!
KIC.READY      = "Ready!"

-- Errors
KIC.ERR_INPUT 	  = "|cffff3333Error:|r Bad input. Syntax: '/kic %s'. See the readme.txt file for details."

-- Chat handler locals
KIC.COMMANDS    = {"/kic"}
KIC.CMD_OPTIONS	= {
	{
		option = "reportdata",
		desc   = "Shows all current cooldowns that are being tracked.",
		method = "ReportData" -- Leave this line alone
	},
	{
		option = "reset",
		desc   = "Reset the cooldown db.",
		method = "Reset", -- Leave this line alone
		args   = {
			{
				option = "confirm",
				desc   = "Really reset the cooldown db.",
				method = "ReallyReset" -- Leave this line alone
			}
		}
	},
	{
		option = "set",
		desc   = "Set or view different options. Syntax: '/kic "..KIC.SETSYN.."'. See the readme.txt file for details.",
		method = "SetOpt", -- Leave this line alone
		input  = TRUE
	},
--  All below here new in 1.3.0 
	{
		option = "time",
		desc   = "Set or views how to show time. Syntax: '/kic "..KIC.TIMESYN.."'. See the readme.txt file for details.",
		method = "SetTime", -- Leave this line alone
	}
}

KIC.REAGENT  = "Hikari says: |cffffe000Don't forget the reagents!|r" -- Message shown with every reminder
KIC.MENUSET  = "Reminder settings" -- FuBar menu item
KIC.MENU = { -- This is the submenu for KIC.MENUSET, and corresponds to the options in /kic set x.
	screen   = "Display reminders on screen",
	chat     = "Display reminders in chat",
	sound    = "Play sound on reminder",
	across   = "Display reminders across chars",
	startup  = "Display reminders on startup"
}
KIC.MENUTIME  = "Time format" -- FuBar menu item
KIC.TIMEOPTS  = { -- These will be displayed with KIC.TIMEREPORT in the settings report (/kic report) as well as when the player uses /kic time or the FuBar menu.
	remaining = "Remaining time of CD",
	game      = "When CD finishes in game time",
	["local"] = "When CD finishes in local time" -- 'local' is a reserved word, that's why it's quoted. You shouldn't translate that part though, only what's to the right of the = mark. =)
}
KIC.TIMEREPORT = "Cooldown timers will be shown as " -- Goes with KIC.TIMEOPTS.

end
