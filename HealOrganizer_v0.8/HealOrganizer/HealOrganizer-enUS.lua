-- By Zisu (http://www.curse-gaming.com/en/profile-122056.html)
local AceLocale = AceLibrary("AceLocale-2.1")

AceLocale:RegisterTranslation("HealOrganizer", "enUS", function()
    return {
        ["CLOSE"] = "Close",
        ["RESET"] = "Reset",
        ["RAID"] = "Raid",
        ["CHANNEL"] = "Channel",
        ["DISPEL"] = "Dispel",
        ["MT"] = "MT",
        ["HEAL"] = "Heal",
        ["DECURSE"] = "Decurse",
        ["REMAINS"] = "Remain",
        ["ARRANGEMENT"] = "Arrangement",
        ["BROADCAST"] = "Broadcast",
        ["OPTIONS"] = "Options",
        ["STATS"] = "Statistics",
        ["PALADINS"] = "Paladin",
        ["DRUIDS"] = "Druids",
        ["PRIESTS"] = "Priests",
        ["SHAMANS"] = "Shamans",
        ["HEALARRANGEMENT"] = "Healing arrangement",
        ["FFA"] = "ffa", -- was der rest machen darf
        ["NO_CHANNEL"] = "You must join the channel %q before making healing arrangement to it",
        ["NOT_IN_RAID"] = "You are not in raid",
        ["FREE"] = "free",
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
