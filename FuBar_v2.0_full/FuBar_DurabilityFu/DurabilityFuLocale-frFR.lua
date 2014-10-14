local L = AceLibrary("AceLocale-2.2"):new("FuBar_DurabilityFu")

L:RegisterTranslations("frFR", function() return {
	["Total"] = "Total",
	["Percent"] = "Pourcentage",
	["Repair cost"] = "Co\195\187t des r\195\169parations",
	["Repair"] = "Reparer",
	["Equipment"] = "Equipement",
	["Inventory"] = "Inventaire",
	["Show repair popup at vendor"] = "Afficher la fen\195\170tre de r\195\169paration",
	["Toggle whether to show the popup at the merchant window"] = "Permet d'afficher ou non la fen\195\170tre s\195\169pciale chez les vendeurs",
	["Show the armored man"] = "Afficher le petit bonhomme",
	["Toggle whether to show Blizzard's armored man"] = "Si ya du rouge, c'est mauvais signe",
	["Show average value"] = "Afficher la durabilit\195\169 moyenne",
	["Toggle whether to show your average or minimum durability"] = "Permet de choisir entre les affichages de durabilit\195\169 moyenne ou minimum",
	["Show healthy items"] = "Afficher les objets sains",
	["Toggle whether to show items that are healthy (100% repaired)"] = "Voulez vous n'afficher que les objets endomag\195\169s?",
	["Auto repair"] = "R\195\169paration automatique",
	
	["AceConsole-Commands"] = {"/durfu", "/durabilityfu"}
} end)