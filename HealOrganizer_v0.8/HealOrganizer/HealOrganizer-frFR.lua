-- By mymycracra (http://www.curse-gaming.com/en/profile-14788.html)
local AceLocale = AceLibrary("AceLocale-2.1")

AceLocale:RegisterTranslation("HealOrganizer", "frFR", function()
    return {
        ["CLOSE"] = "Ferme",
        ["RESET"] = "Reset",
        ["RAID"] = "Raid",
        ["CHANNEL"] = "Canal",
        ["DISPEL"] = "Dispel",
        ["MT"] = "MT",
        ["HEAL"] = "Soin",
        ["DECURSE"] = "Decurse",
        ["REMAINS"] = "Restant",
        ["ARRANGEMENT"] = "Arrangement",
        ["BROADCAST"] = "Broadcast",
        ["OPTIONS"] = "Options",
        ["STATS"] = "Statistiques",
        ["PALADINS"] = "Paladin",
        ["DRUIDS"] = "Druides",
        ["PRIESTS"] = "Pr\195\170tres",
        ["SHAMANS"] = "Chamans",
        ["HEALARRANGEMENT"] = "Organisation des soins",
        ["FFA"] = "ffa", -- was der rest machen darf
        ["NO_CHANNEL"] = "Vous devez vous connecter sur le canal %q avant d'organiser les soins",
        ["NOT_IN_RAID"] = "Vous n'etes pas en raid",
        ["FREE"] = "libre",
        ["EDIT_LABEL"] = "New label for group %u",
        ["SHOW_DIALOG"] = "Show the dialog",
        ["LABELS"] = "Labels",
        ["SAVEAS"] = "Save as",
        ["SET_SAVEAS"] = "Enter a name for the new set",
        ["SET_DEFAULT"] = "Default",
        ["SET_CANNOT_DELETE_DEFAULT"] = "You cannot delete the default set",
        ["SET_CANNOT_SAVE_DEFAULT"] = "You cannot overwrite the default set",
        ["SET_ALREADY_EXISTS"] = "The Set %q already exists",
        ["SET_TO_MANY_SETS"] = "You cannot have more than 32 sets",
        ["AUTOSORT_DESC"] = "Autosort for groups",
    }
end)
