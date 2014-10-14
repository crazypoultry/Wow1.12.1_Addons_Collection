--- deDE Translation by Gamefaq
local AceLocale = AceLibrary("AceLocale-2.1")
AceLocale:RegisterTranslation("GroupFu", "deDE", function()
    return {
        ["Name"]          = "GroupFu",
        ["Description"]   = "Kombination aus Titan Loot Type und Roll.",
        ["DefaultIcon"]   = "Interface\\Buttons\\UI-GroupLoot-Dice-Up",

        ["TextSolo"]      = "Solo",
        ["TextGroup"]     = "Gruppe",
        ["TextFFA"]       = "Jeder gegen Jeden",
        ["TextMaster"]    = "Plündermeister",
        ["TextMasterSrt"] = "PL",
        ["TextNBG"]       = "Bedarf vor Gier",
        ["TextRR"]        = "Reihum",
        ["TextNoRolls"]   = "Keine Würfe",
        
        ["ItemPoor"]      = "Schlecht",
        ["ItemCommon"]    = "Verbreitet",
        ["ItemUncommon"]  = "Selten",
        ["ItemRare"]      = "Rar",
        ["ItemEpic"]      = "Episch",
        ["ItemLegendary"] = "Legendär",
        ["ItemArtifact"]  = "Artefakt",

        ["RollEnding10"]  = "Würfeln endet in 10 Sekunden",
        ["RollEnding5"]   = "Würfeln endet in 5",
        ["RollEnding4"]   = "Würfeln endet in 4",
        ["RollEnding3"]   = "Würfeln endet in 3",
        ["RollEnding2"]   = "Würfeln endet in 2",
        ["RollEnding1"]   = "Würfeln endet in 1",
        ["RollOver"]      = "Würfeln beendet, Gewinner wird angesagt.",

        ["FormatAnnounceWin"]           = "Gewinner: %s mit einer [%d] aus %d Spielern.",
        ["FormatTextRollCount"]         = "%s (%d/%d)",
        ["FormatTooltipRollCount"]      = "%d aus erwarteten %d würfen registriert",
    
        ["MenuMode"]                    = "Text Modus",
        ["MenuModeGroupFu"]             = "GroupFu: Plündern Typ, außer es wurde schon gewürfelt, dann den Gewinner",
        ["MenuModeRollsFu"]             = "RollsFu: Nicht würfeln, außer es wurde schon gewürfelt, dann den Gewinner",
        ["MenuModeLootTyFu"]            = "LootTyFu: Plündern Typ Immer",

        ["MenuLootDispOpts"]            = "Loot Anzeige Optionen",
        ["MenuLootDispOptsShowMLName"]  = "Plündermeister Namen anzeigen",

        ["MenuRollOpts"]                = "Würfel Optionen",
        ["MenuRollOptsPerformRoll"]     = "Durch Anklicken würfeln",
        ["MenuRollOptsShowRollCount"]   = "Zeige Menge der Würfe kontra Spielern aus Raid/Gruppe",
        ["MenuRollOptsUseRollCntdwn"]   = "Kündige Count Down an und zeige dannach Gewinner",
        ["MenuRollOptsStdRollsOnly"]    = "Nur Standard (1-100) Würfe akzeptieren",
        ["MenuRollOptsIgnoreDupes"]     = "Doppelte Würfe ignorieren",
        ["MenuRollOptsAutoDelRolls"]    = "Würfe nach Ausgabe automatisch löschen",
        ["MenuRollOptsShowClassNLevel"] = "Klasse und Level im Tooltip anzeigen",
    
        ["MenuRollOptsOutput"]          = "Anzeigeort der Ergebnisses",
        ["MenuRollOptsOutputAuto"]      = "Gewinner automatsich ausgeben = Raid, Gruppe, oder Solo",
        ["MenuRollOptsOutputLocal"]     = "Im lokalen Fenster ausgeben",
        ["MenuRollOptsOutputSay"]       = "Im Sagen Kanal ausgeben",
        ["MenuRollOptsOutputParty"]     = "Im Gruppen Kanal ausgeben",
        ["MenuRollOptsOutputRaid"]      = "Im Raid Kanal ausgeben",
        ["MenuRollOptsOutputGuild"]     = "Im Gilden Kanal ausgeben",
    
        ["MenuRollOptsClear"]           = "Automatisches verwerfen der Würfe",
        ["MenuRollOptsClearNever"]      = "Nie",
        ["MenuRollOptsClear15Sec"]      = "15 Sekunden",
        ["MenuRollOptsClear30Sec"]      = "30 Sekunden",
        ["MenuRollOptsClear45Sec"]      = "45 Sekunden",
        ["MenuRollOptsClear60Sec"]      = "60 Sekunden",
    
        ["MenuRollOptsDetail"]          = "Ausgabe Details",
        ["MenuRollOptsDetailShort"]     = "Nur Gewinner anzeigen",
        ["MenuRollOptsDetailLong"]      = "Alle Würfe anzeigen",
        ["MenuRollOptsDetailFull"]      = "Alle Würfe und nicht Standard Würfe anzeigen",
        
        ["MenuGroup"]                   = "Gruppen Funktionen",
        ["MenuGroupLeave"]              = "Gruppe verlassen",
        ["MenuGroupConvRaid"]           = "In Schlachtzug Gruppe umwandeln",
        ["MenuGroupLootMethod"]         = "Plündern Methode ändern",
        ["MenuGroupLootThreshold"]      = "Plündern Schwelle ändern",
        ["MenuGroupResetInstance"]      = "Instanz Resetten",
        
        ["TooltipCatLooting"]           = "Plündern",
        ["TooltipCatRolls"]             = "Würfe",
        ["TooltipMethod"]               = "Plündern Methode",
        ["TooltipHint"]                 = "Anklicken zum würfeln, Ctrl-Klick um den Gewinner auszugeben, Shift-Klick um die Liste zu löschen",
        ["TooltipHintNoRolls"]          = "Ctrl-Klick um den Gewinner anzuzeigen, Shift-Klick um die Liste zu löschen",
    }
end)
