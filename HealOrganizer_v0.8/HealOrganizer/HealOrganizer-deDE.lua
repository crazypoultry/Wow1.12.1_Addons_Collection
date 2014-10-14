local AceLocale = AceLibrary("AceLocale-2.1")

AceLocale:RegisterTranslation("HealOrganizer", "deDE", function()
    return {
        ["CLOSE"] = "Schlie\195\159en",
        ["RESET"] = "Zur\195\188cksetzen",
        ["RAID"] = "Schlachtzug",
        ["CHANNEL"] = "Channel",
        ["DISPEL"] = "Dispellen",
        ["MT"] = "MT",
        ["HEAL"] = "heilen",
        ["DECURSE"] = "decursen",
        ["REMAINS"] = "Rest",
        ["ARRANGEMENT"] = "Einteilung",
        ["BROADCAST"] = "Broadcast",
        ["OPTIONS"] = "Optionen",
        ["STATS"] = "Statistik",
        ["PALADINS"] = "Paladine",
        ["DRUIDS"] = "Druiden",
        ["PRIESTS"] = "Priester",
        ["SHAMANS"] = "Schamanen",
        ["HEALARRANGEMENT"] = "Heilereinteilung",
        ["FFA"] = "ffa", -- was der rest machen darf
        ["NO_CHANNEL"] = "Sie m\195\188ssen den Channel %q beitreten, bevor sie die Heilereinteilung bekannt geben k\195\182nnen",
        ["NOT_IN_RAID"] = "Sie sind in keinem Schlachtzug",
        ["FREE"] = "frei",
        ["EDIT_LABEL"] = "Neue Bezeichnung f\195\188r die Gruppe %u",
        ["SHOW_DIALOG"] = "Zeige das Dialog",
        ["LABELS"] = "Beschriftungen",
        ["SAVEAS"] = "Speichern als",
        ["SET_SAVEAS"] = "Geben sie ein Namen f\195\188r den Set ein",
        ["SET_DEFAULT"] = "Standard",
        ["SET_CANNOT_DELETE_DEFAULT"] = "Sie k\195\182nnen den Standard-Set nicht l\195\182schen",
        ["SET_CANNOT_SAVE_DEFAULT"] = "Sie k\195\182nnen den Standard-Set nicht \195\188berschreiben",
        ["SET_ALREADY_EXISTS"] = "Der Set %q existiert bereits",
        ["SET_TO_MANY_SETS"] = "Sie k\195\182nnen nicht mehr als 32 Sets haben",
        ["AUTOSORT_DESC"] = "Automatische Sortierung f\195\188r die Gruppen",
    }
end)
