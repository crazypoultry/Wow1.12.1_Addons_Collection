local AceLocale = AceLibrary("AceLocale-2.1")
AceLocale:RegisterTranslation("GroupFu", "enUS", function()
    return {
        ["Name"]          = "GroupFu",
        ["Description"]   = "Combination of Titan LootType and Roll.",
        ["DefaultIcon"]   = "Interface\\Buttons\\UI-GroupLoot-Dice-Up",

        ["TextSolo"]      = "Solo",
        ["TextGroup"]     = "Group",
        ["TextFFA"]       = "Free for All",
        ["TextMaster"]    = "Master Looter",
        ["TextMasterSrt"] = "ML",
        ["TextNBG"]       = "Need Before Greed",
        ["TextRR"]        = "Round Robin",
        ["TextNoRolls"]   = "No Rolls",

        ["ItemPoor"]      = "Poor",
        ["ItemCommon"]    = "Common",
        ["ItemUncommon"]  = "Uncommon",
        ["ItemRare"]      = "Rare",
        ["ItemEpic"]      = "Epic",
        ["ItemLegendary"] = "Legendary",
        ["ItemArtifact"]  = "Artifact",
        
        ["RollEnding10"] = "Roll ending in 10. Recorded %d of %d rolls.",
        ["RollEnding5"]  = "Roll ending in 5. Recorded %d of %d rolls.",
        ["RollEnding4"]  = "Roll ending in 4.",
        ["RollEnding3"]  = "Roll ending in 3.",
        ["RollEnding2"]  = "Roll ending in 2.",
        ["RollEnding1"]  = "Roll ending in 1.",
        ["RollOver"]     = "Rolling over announcing winner. Total of %d rolls recorded of an expected %d.",

        ["FormatAnnounceWin"]           = "Winner: %s [%d] out of %d rolls.",
        ["FormatTextRollCount"]         = "%s (%d/%d)",
        ["FormatTooltipRollCount"]      = "%d of expected %d rolls recorded",
    
        ["MenuMode"]                    = "Text Mode",
        ["MenuModeGroupFu"]             = "GroupFu: Loot type, unless a roll is active then the winner of the roll",
        ["MenuModeRollsFu"]             = "RollsFu: No Rolls, unless a roll is active then the winner of the roll",
        ["MenuModeLootTyFu"]            = "LootTyFu: Loot type always",

        ["MenuLootDispOpts"]            = "Loot Display Options",
        ["MenuLootDispOptsShowMLName"]  = "Show Master Looter Name",

        ["MenuRollOpts"]                = "Roll Options",
        ["MenuRollOptsPerformRoll"]     = "Perform roll when clicked",
        ["MenuRollOptsShowRollCount"]   = "Show count of rolls recorded ie <# rolls>/<# player in raid/party>",
        ["MenuRollOptsUseRollCntdwn"]   = "Announce count down and display winner when roll clearing timer reached",
        ["MenuRollOptsStdRollsOnly"]    = "Accept standard (1-100) rolls only",
        ["MenuRollOptsIgnoreDupes"]     = "Ignore duplicate rolls",
        ["MenuRollOptsAutoDelRolls"]    = "Auto-delete rolls after output",
        ["MenuRollOptsShowClassNLevel"] = "Show Class and Level in tooltip",
    
        ["MenuRollOptsOutput"]          = "Output Location",
        ["MenuRollOptsOutputAuto"]      = "Output results based on being in Raid, Group, or Solo",
        ["MenuRollOptsOutputLocal"]     = "Output results to Local Screen",
        ["MenuRollOptsOutputSay"]       = "Output results to the Say channel",
        ["MenuRollOptsOutputParty"]     = "Output results to the Party channel",
        ["MenuRollOptsOutputRaid"]      = "Output results to the Raid channel",
        ["MenuRollOptsOutputGuild"]     = "Output results to the Guild channel",
    
        ["MenuRollOptsClear"]           = "Automatic Roll Clearing",
        ["MenuRollOptsClearNever"]      = "Never",
        ["MenuRollOptsClear15Sec"]      = "15 seconds",
        ["MenuRollOptsClear30Sec"]      = "30 seconds",
        ["MenuRollOptsClear45Sec"]      = "45 seconds",
        ["MenuRollOptsClear60Sec"]      = "60 seconds",
    
        ["MenuRollOptsDetail"]          = "Output Detail",
        ["MenuRollOptsDetailShort"]     = "Display winner only",
        ["MenuRollOptsDetailLong"]      = "Display all rolls",
        ["MenuRollOptsDetailFull"]      = "Display all rolls, along with non-standard roll info",
        
        ["MenuGroup"]                   = "Group Functions",
        ["MenuGroupLeave"]              = "Leave Group",
        ["MenuGroupConvRaid"]           = "Convert Group to Raid",
        ["MenuGroupLootMethod"]         = "Change Looting Method",
        ["MenuGroupLootThreshold"]      = "Change Loot Threshold",
        ["MenuGroupResetInstance"]      = "Reset Instance",
        
        ["TooltipCatLooting"]           = "Looting",
        ["TooltipCatRolls"]             = "Rolls",
        ["TooltipMethod"]               = "Looting Method",
        ["TooltipHint"]                 = "Click to roll, Ctrl-Click to output winner, Shift-Click to clear the list",
        ["TooltipHintNoRolls"]          = "Ctrl-Click to output winner, Shift-Click to clear the list",
    }
end)
