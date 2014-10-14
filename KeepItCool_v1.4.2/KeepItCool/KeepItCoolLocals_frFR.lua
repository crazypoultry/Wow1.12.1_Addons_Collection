
-- How to translate: Make a copy of this file and replace xxXX in the filename and anywhere in this file with the locale you're translating for. Then add the new filename to the .toc file, just between ## SavedVariables: kicDB and KeepItCoolLocals.lua. Also, you can translate the title and description by adding ## Title-xxXX and ## Notes-xxXX lines. Lastly, translate anything in this file that's in quotes =)
-- "frFR": french, "deDE": german, "koKR": korean, not sure about chinese
-- Some special characters need to be replaced with character codes, read about it on http://www.wowwiki.com/Localisation#Accents

function kic_Locals_frFR()
ace:RegisterGlobals({
    version 	= 1.01,
    translation = "frFR",
    ACEG_MAP_ONOFF = {[0]="|cffff5050Off|r",[1]="|cff00ff00On|r"},
})
-- Info for Ace
KIC.NAME        = "KeepItCool"
KIC.DESCRIPTION	= "Vous rappelle quand votre cooldown d'artisanat expire."

-- Tradeskill categories. Shown in the reminders, with KIC.REMIND.
KIC.CAT = {
	"Transmutation",  
	"Tamis \195\160 sel", 	
	"Etoffe lunaire",     
	"Ma\195\174treNeige 9000",
	"Lanterne"
}
-- Profession names. Used to check whether a particular profession is unlearned, by scanning the message that appears when you unlearn a skill, for example "You have unlearned Alchemy."
KIC.PROF = {
	["Alchimiste"]        = 1,
	["Travail du Cuir"]   = 2,
	["Tailleur"]          = 3,
	["Ing\195\198nieur"]  = 4
}

-- Time unit conversion table:
-- 1d = 24h =  86400s
-- 2d = 48h = 172800s
-- 3d = 72h = 259200s
-- 4d = 96h = 345600s

-- The following entries are displayed by KIC. Anywhere where it says %s will be replaced with the text in the commment on the same line, in the order they are listed. If you want to change the order, change the %s to %x$s, where x is the order number you want there. For example: "%1$s%3$s%2$s" -- a, b, c would turn out as "acb"
-- The message displayed when a cooldown is detected.
KIC.ADD           = "%s cooldown detect\195\169, rappel planifi\195\169 dans %s!" -- One of the items in KIC.CAT, cooldown length.
-- The message displayed when a cooldown is done
KIC.REMIND        = "Votre cooldown pour %s a expir\195\169!" -- One of the items in KIC.CAT.
KIC.REMOTEREMIND  = "Le cooldown pour %s de %s a expir\195\169!" -- One of the items in KIC.CAT, the character that the CD has finished for.
-- The message displayed when there is nothing to report from db
KIC.EMPTYDB       = "Aucun cooldown en cours de surveillance."
-- Reset messages
KIC.RESETASK      = "Etes-vous sur de faire un reset? Tapez '/kic reset confirm' pour faire cela."
KIC.RESET         = "Db reset."
-- Options
KIC.REPORT  = { -- These will be displayed in the settings report (/kic report) as well as when the player uses /kic set.
	screen  = "Ecran:",
	chat    = "Discussion:",
	sound   = "Son:",
	across  = "Entre Personnages:",
	startup = "Au D\195\169marrage:"
}

-- Values used in /kic set
KIC.ON = "on"
KIC.OFF = "off"
KIC.TOG = "tog"

-- Report. Used for /kic reportdata.
KIC.DATAREPORT = "Rapport" 
KIC.REMAINING  = " restant." -- Mind the leading space!
KIC.READY      = "Pr\195\170t!"

-- Errors
KIC.ERR_INPUT 	  = "|cffff3333Error:|r Mauvaise saisie. Syntaxe: '/kic %s'. Voir readme.txt pour plus de details."

-- Chat handler locals
KIC.COMMANDS    = {"/kic"}
KIC.CMD_OPTIONS	= {
	{
		option = "reportdata",
		desc   = "Montre tous les cooldowns suivis en cours.",
		method = "ReportData" -- Leave this line alone
	},
	{
		option = "reset",
		desc   = "Resette la base de donn\195\169es de cooldowns.",
		method = "Reset", -- Leave this line alone
		args   = {
			{
				option = "confirm",
				desc   = "Confirme le reset de la base de donn\195\169es de cooldown.",
				method = "ReallyReset" -- Leave this line alone
			}
		}
	},
	{
		option = "set",
		desc   = "Positionne ou affiche diverses options. Syntaxe: '/kic "..KIC.SETSYN.."'. Voir readme.txt pour plus de details.",
		method = "SetOpt", -- Leave this line alone
		input  = TRUE
	},
--  All below here new in 1.3.0 
	{
		option = "time",
		desc   = "Positionne ou affiche comment afficher le temps. Syntaxe: '/kic "..KIC.TIMESYN.."'. Voir readme.txt pour plus de details.",
		method = "SetTime", -- Leave this line alone
	},
}

KIC.REAGENT = "Hikari dit: |cffffe000N'oubliez pas les composants!|r" -- Message shown with every reminder
KIC.MENUSET = "R\195\169glages des rappels" -- FuBar menu item
KIC.MENU    = { -- This is the submenu for KIC.MENUSET, and corresponds to the options in /kic set x.
	screen  = "Affiche les rappels \195\160 l'\195\169cran",
	chat    = "Affiche les rappels dans la discussion",
	sound   = "Joue un son de rappel",
	across  = "Affiche les rappels entre personnages",
	startup = "Affiche les rappels au d\195\169marrage"
}
KIC.MENUTIME = "Format horaire" -- FuBar menu item
KIC.TIMEOPTS  = { -- These will be displayed with KIC.TIMEREPORT in the settings report (/kic report) as well as when the player uses /kic time.
	remaining = "En temps restant de CD",
	game      = "Quand le CD expire en temps de jeu",
	["local"] = "Quand le CD expire en heure locale" -- 'local' is a reserved word, that's why it's quoted. You shouldn't translate that part though, only what's to the right of the = mark. =)
}
KIC.TIMEREPORT = "Les compteurs de cooldown seront affich\195\169s " -- Goes with KIC.TIMEOPTS.

end
