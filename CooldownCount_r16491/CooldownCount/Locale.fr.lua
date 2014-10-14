--[[ $Id: Locale.lua 14439 2006-10-19 22:52:04Z hshh $ ]]--

local L = AceLibrary("AceLocale-2.2"):new("CooldownCount")

L:RegisterTranslations("frFR", function()
	return {
		["Reset all settings."] = "Réinitialiser tous les paramètres.",
		["Reset to default settings."] = "Revenir aux paramètres par défaut.",
		["Toggle icon shine display after finish cooldown."] = "Activer ou désactiver la surbrillance de l'icône après la fin du cooldown.",
		["Adjust icon shine scale."] = "Ajuste l'échelle de la surbrillance de l'icône.",
		["Set cooldown value display font."] = "Définir la police de l'affichage de la valeur.",

		["Setup cooldown value display font size."] = "Définir la taille de la police de l'affichage de la valeur.",
		["Small font size for cooldown is longer than 10 minutes."] = "Petite taille pour des valeurs supérieures à 10 minutes.",
		["Medium font size for cooldown is longer than 1 minute and less than 10 minutes."] = "Taille moyenne pour des valeurs supérieures à 1 minute et inférieur à 10.",
		["Large font size for cooldown is longer than 10 seconds and less than 1 minutes."] = "Grande Taille pour des valeurs supérieures à 10 secondes et inférieures à 1 minute.",
		["Warning font size for cooldown is less than 10 seconds."] = "Taille d'alerte pour des valeurs inférieures à 10 secondes.",

		["Setup the common color for value display."] = "Définir la couleur commune de l'affichage de la valeur.",
		["Setup the warning color for value display."] = "Définir la couleur d'alerte de l'affichage de la valeur.",

		["d"] = "j",
		["h"] = "h",
		["m"] = "m",

		["Minimum duration for display cooldown count."] = "Durée minimum pour afficher le compteur",
		["Hide Bliz origin cooldown animation."] = "Masquer l'animation de cooldown de l'interface d'origine"
	}
end)
