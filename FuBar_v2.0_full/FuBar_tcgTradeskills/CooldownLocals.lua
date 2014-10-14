-- vim: noet
local L = AceLibrary("AceLocale-2.2"):new("FuBar_tcgTradeskillsCooldowns")

L:RegisterTranslations("enUS", function() return {
	["Alert Delay"]	= true,
	["Set Cooldown Alert Delay"] = true,
	["Play Cooldown Sound"]	= true,
	["Play sound when cooldown expires"] = true,
	["Cooldown Time Format"] = true,
	["Set the display format for cooldown expirations."] = true,
	["Cooldowns"] = true,
	["Purge Cooldowns"] = true,
	["Purge Cooldowns for %s"] = true,
	["%s of %s:"] = true,
	["  %s cooldown is %s %s (%s)"]	= true,
	["in"] = true,
	["at"] = true,
	["  %s cooldown has expired (%s)"] = true,
	["%s of %s: Cooldown expired for %s"] = true,
	["%s is on the same cooldown timer as %s, removing"] = true,

	["No tradeskill window open for scanning."] = true,
	["Scanning recipes: %d-%d"] = true,
	["Rescan Cooldowns"] = true,
	["Rescan open tradeskill window for cooldowns"] = true,
} end)

L:RegisterTranslations("frFR", function() return {
	["Alert Delay"]	= "D\195\169lai d'alerte",
	["Set Cooldown Alert Delay"] = "R\195\168gler le d\195\169lai entre deux alertes",
	["Play Cooldown Sound"]	= "Jouer un son",
	["Play sound when cooldown expires"] = "Joue un son quand un cooldown a expir\195\169",
	["Cooldown Time Format"] = "Type d'affichage",
	["Set the display format for cooldown expirations."] = "Permet de choisir le format d'affichage des cooldowns",
	["Cooldowns"] = "Cooldowns",
	["Purge Cooldowns"] = "Purger les cooldowns",
	["Purge Cooldowns for %s"] = "Purger les cooldowns pour %s",
	["%s of %s:"] = "%s de %s:",
	["  %s cooldown is %s %s (%s)"]	= " %s cooldown est %s %s (%s)",
	["in"] = "dans",
	["at"] = "\195\160",
	["  %s cooldown has expired (%s)"] = " %s cooldown a expir\195\169 (%s)",
	["%s of %s: Cooldown expired for %s"] = "%s de %s: Cooldown expir\195\169 pour %s",
	["%s is on the same cooldown timer as %s, removing"] = "%s est sur le m\195\170me cooldown que %s, effac\195\169",

	["No tradeskill window open for scanning."] = "Ouvrez une fenetre d'artisanat",
	["Scanning recipes: %d-%d"] = "Balayage des recettes %d-%d",
	["Rescan Cooldowns"] = "Actualiser les CoolDowns",
	["Rescan open tradeskill window for cooldowns"] = "Balayage de la fenetre d'artisanat active pour la recherche de CoolDowns",
} end)
