local AceLocale = AceLibrary("AceLocale-2.1")
AceLocale:RegisterTranslation("GroupFu", "frFR", function()
    return {
        ["Name"]          = "GroupFu",
        ["Description"]   = "Combinaison de LootType et Roll.",
        ["DefaultIcon"]   = "Interface\\Buttons\\UI-GroupLoot-Dice-Up",

        ["TextSolo"]      = "Solo",
        ["TextGroup"]     = "Groupe",
        ["TextFFA"]       = "Acces libre",
        ["TextMaster"]    = "Responsable du Butin",
        ["TextMasterSrt"] = "ML",
        ["TextNBG"]       = "Le Besoin avant Cupidite",
        ["TextRR"]        = "Chacun son tour",
        ["TextNoRolls"]   = "Aucun Tirage",
        
        ["ItemPoor"]      = "Poor",
        ["ItemCommon"]    = "Common",
        ["ItemUncommon"]  = "Uncommon",
        ["ItemRare"]      = "Rare",
        ["ItemEpic"]      = "Epic",
        ["ItemLegendary"] = "Legendary",
        ["ItemArtifact"]  = "Artifact",
        
        ["RollEnding10"]  = "Le tirage finit dans 10",
        ["RollEnding5"]   = "Le tirage finit dans 5",
        ["RollEnding4"]   = "Le tirage finit dans 4",
        ["RollEnding3"]   = "Le tirage finit dans 3",
        ["RollEnding2"]   = "Le tirage finit dans 2",
        ["RollEnding1"]   = "Le tirage finit dans 1",
        ["RollOver"]      = "Le tirage est fini, annonce du gagnant.",

        ["FormatAnnounceWin"]           = "Gagnant: %s [%d] sur %d tirages.",
        ["FormatTextRollCount"]         = "%s (%d/%d)",
        ["FormatTooltipRollCount"]      = "%d tirages enregistres sur %d attendus",
    
        ["MenuMode"]                    = "Mode Texte",
        ["MenuModeGroupFu"]             = "GroupFu: Mode de butin, sauf si un tirage est actif, alors le gagnant du tirage",
        ["MenuModeRollsFu"]             = "RollsFu: Aucun tirage, sauf si un tirage est actif alors le gagnant du tirage",
        ["MenuModeLootTyFu"]            = "LootTyFu: Toujours Mode de butin",

        ["MenuLootDispOpts"]            = "Loot Display Options",
        ["MenuLootDispOptsShowMLName"]  = "Montrer le nom du Responsable du Butin",

        ["MenuRollOpts"]                = "Roll Options",
        ["MenuRollOptsPerformRoll"]     = "Effectuer un tirage quand clic",
        ["MenuRollOptsShowRollCount"]   = "Afficher un decompte des tirages enregistres ie <# tirages>/<# joueurs dans le raid/groupe>",
        ["MenuRollOptsUseRollCntdwn"]   = "Annoncer le compte a rebours et afficher le gagnant quand le temps d'expiration est atteint",
        ["MenuRollOptsStdRollsOnly"]    = "N'accepter que les tirages standards (1-100)",
        ["MenuRollOptsIgnoreDupes"]     = "Ignorer les tirages en double",
        ["MenuRollOptsAutoDelRolls"]    = "Auto-suppression des tirages apres affichage",
        ["MenuRollOptsShowClassNLevel"] = "Montrer classe et niveau dans la bulle",
    
        ["MenuRollOptsOutput"]          = "Lieu d'affichage",
        ["MenuRollOptsOutputAuto"]      = "Afficher les resultats selon qu'on est en Raid, Groupe ou Solo",
        ["MenuRollOptsOutputLocal"]     = "Affichage sur l'ecran",
        ["MenuRollOptsOutputSay"]       = "Affichage sur /dire",
        ["MenuRollOptsOutputParty"]     = "Affichage sur /gr",
        ["MenuRollOptsOutputRaid"]      = "Affichage sur /raid",
        ["MenuRollOptsOutputGuild"]     = "Affichage sur /g",
    
        ["MenuRollOptsClear"]           = "Nettoyage automatique des tirages",
        ["MenuRollOptsClearNever"]      = "Jamais",
        ["MenuRollOptsClear15Sec"]      = "15 secondes",
        ["MenuRollOptsClear30Sec"]      = "30 secondes",
        ["MenuRollOptsClear45Sec"]      = "45 secondes",
        ["MenuRollOptsClear60Sec"]      = "60 secondes",
    
        ["MenuRollOptsDetail"]          = "Niveau de Detail",
        ["MenuRollOptsDetailShort"]     = "Afficher le gagnant seulement",
        ["MenuRollOptsDetailLong"]      = "Afficher tous les tirages",
        ["MenuRollOptsDetailFull"]      = "Afficher tous les tirags, ainsi que l'info des tirages non standards",
        
        ["MenuGroup"]                   = "Fonctions de groupe",
        ["MenuGroupLeave"]              = "Quitter le groupe",
        ["MenuGroupConvRaid"]           = "Convertir Groupe en Raid",
        ["MenuGroupLootMethod"]         = "Changer le mode de butin",
        ["MenuGroupLootThreshold"]      = "Changer le Seuil de butin",
        ["MenuGroupResetInstance"]      = "Resetter les instances",
        
        ["TooltipCatLooting"]           = "Butin",
        ["TooltipCatRolls"]             = "Tirages",
        ["TooltipMethod"]               = "Mode de Butin",
        ["TooltipHint"]                 = "Clic pour tirage, Ctrl-Clic pour afficher le gagnant, Shift-Clic pour effacer la liste",
        ["TooltipHintNoRolls"]          = "Ctrl-Clic pour afficher le gagnant, Shift-Clic pour effacer la liste",
    }
end)
