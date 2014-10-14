
function kic_Locals_deDE()
ace:RegisterGlobals({
version = 1.01,
translation = "deDE",
ACEG_MAP_ONOFF = {[0]="|cffff5050Off|r",[1]="|cff00ff00On|r"},
})
-- Info for Ace
KIC.NAME = "KeepItCool"
KIC.DESCRIPTION = "Erinnert an ausgelaufene Berufs-Cooldowns."

-- Tradeskill categories. Shown in the reminders, with KIC.REMIND.
KIC.CAT = {
"Transmutierungen",
"Salzstreuer",
"Mondstoff",
"Schneemeister 9000",
"Laterne"
}
-- Profession names. Used to check whether a particular profession is unlearned, by scanning the message that appears when you unlearn a skill, for example "You have unlearned Alchemy."
KIC.PROF = {
["Alchimie"] = 1,
["Lederverarbeitung"] = 2,
["Schneiderei"] = 3,
["Ingenieurskunst"] = 4
}

-- The following entries are displayed by KIC. Anywhere where it says %s will be replaced with the text in the commment on the same line, in the order they are listed. If you want to change the order, change the %s to %x$s, where x is the order number you want there. For example: "%1$s%3$s%2$s" -- a, b, c would turn out as "acb"
-- The message displayed when a cooldown is detected.
KIC.ADD = "%s Cooldown erkannt, Benachrichtigung erfolgt in %s!" -- One of the items in KIC.CAT, cooldown length.
-- The message displayed when a cooldown is done
KIC.REMIND = "Der %s Cooldown ist abgelaufen!" -- One of the items in KIC.CAT.
KIC.REMOTEREMIND = "Der %s Cooldown f\195\188r %s ist abgelaufen!" -- One of the items in KIC.CAT, the character that the CD has finished for.
-- The message displayed when there is nothing to report from db
KIC.EMPTYDB = "Es werden keine Cooldowns \195\188berwacht."
-- Reset messages
KIC.RESETASK = "Soll wirklich zur\195\188ckgesetzt werden ? Bitte daf\195\188r '/kic reset confirm' eingeben."
KIC.RESET = "DB zur\195\188ckgesetzt."
-- Options
KIC.REPORT = { -- These will be displayed in the settings report (/kic report).
screen = "Screen:",
chat = "Chat:",
sound = "Sound:",
across = "Alle Chars:",
startup = "Beim Laden:"
}

-- Values used in /kic set 
KIC.ON = "on" 
KIC.OFF = "off" 
KIC.TOG = "tog"

-- Report. Used for /kic reportdata.
KIC.DATAREPORT = "Data Report"
KIC.REMAINING = " \195\188brig."
KIC.READY = "Bereit!"

-- Errors
KIC.ERR_INPUT = "|cff00ff00Error:|r Falsche Eingabe. Syntax: '/kic %s'. Siehe readme.txt file f\195\188r Details."

-- Chat handler locals
KIC.COMMANDS = {"/kic"}
KIC.CMD_OPTIONS = {
	{
		option = "reportdata",
		desc = "Zeigt alle momentanen Cooldowns die \195\188berwacht werden.",
		method = "ReportData" -- Leave this line alone
	},
	{
		option = "reset",
		desc = "Setzt die Cooldown DB zur\195\188ck.",
		method = "Reset", -- Leave this line alone
		args = {
			{
			option = "confirm",
			desc = "Setzt die Cooldown DB wirklich zur\195\188ck.",
			method = "ReallyReset" -- Leave this line alone
			}
		}
	},
{
	option = "set",
	desc = "Setzt oder zeigt die verschiedenen Optionen. Syntax: '/kic "..KIC.SETSYN.."'. Siehe readme.txt file f\195\188r Details.",
	method = "SetOpt", -- Leave this line alone
	input = TRUE
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
