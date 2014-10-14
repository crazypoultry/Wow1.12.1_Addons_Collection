
-- initialize the empty locale for each class
WCLocale = {}
WCLocale.PRIEST = {}
WCLocale.MAGE = {}
WCLocale.DRUID = {}
WCLocale.PALADIN = {}
WCLocale.SHAMAN = {}
WCLocale.WARLOCK = {}

WCLocale.UI = {
    rank = "(Rank %d)",
    rankMatch = "^Rank (%d+)$",
    text = {
        whisperCast = "WhisperCast",
        whisperCastVersion = "WhisperCast v%s",
        sendWhisperPrefix = "WC: ",

        BINDING_HEADER = "WhisperCast",
        BINDING_NAME_CAST = "Cast",
        BINDING_NAME_SHOW = "Show/Hide Gui",

        queueSummary = "%s - %s",
        queueSummaryFail = " (fail %d)",
        queueBriefDisabled = "Disabled",
        queueBriefEmpty = "Empty",
        queueBriefQueued = "%d Queued",
        queueBriefUnavailable = "Unavailable",

        queueFeedbackQueued = "Queued %s on %s",
        queueFeedbackDuplicate = "Duplicate %s on %s",
        queueFeedbackCleared = "Queue cleared",

        feedbackWhisperDuplicate = "%s is already queued for you",
        feedbackWhisperQueued = "%s has been queued for you",
        feedbackWhisperCleared = "Your request for %s was cleared from the queue",
        feedbackWhisperDisabled = "Queueing is disabled, your request for %s wasn't queued",
        feedbackWhisperCastingUserFailure = "Failed to cast %s on you, %s",
	feedbackWhisperAnnounceCooldown = "%s currently has a cooldown of %s",

        raidGroupFeedback = "You are now in raid group %d",

        spellsNone = "No spells for %s",
        spellsUnknown = "Unknown spell %s",
        spellsNotLearned = "You have not learned spell %s",
        spellsLevelTooLow = "Target level too low",

        castingCantCast = "Can't cast %s on %s, %s",
        castingCantTarget = "Can't target %s for %s",
        castingOutOfRange = "%s is out of range of %s",
        castingCasting = "Casting %s on %s",

        chatActionIdError1 = "The following spells are not on any of your action bars.  WhisperCast will not be able to do smart range and cooldown checks.",
        chatActionIdError2 = "Please add them to an action bar.  The action bar doesn't have to be visable/enabled for this to work.  Use '/wc status' to check status after adding to an action bar.",

        whisperCmdAnnounce = "wc",
        whisperCmdAnnounceHeader = "WhisperCast available spells and trigger phrase",
        whisperCmdAnnounceSpell = "    %s = %s",
        whisperCmdAnnounceNoSpells = "No spells are currently available",

        chatCmdEnable = "enable",
        chatCmdDisable = "disable",
        chatCmdCast = "cast",
        chatCmdClear = "clear",
        chatCmdReset = "reset",
        chatCmdResetFeedback = "Your profile has been reset",
        chatCmdShow = "show",
        chatCmdHide = "hide",
        chatCmdMin = "min",
        chatCmdMax = "max",
        chatCmdAnnounce = "announce",
        chatCmdAnnounceMessage = "WhisperCast: To request a buff or cure send a whisper to me with the desired trigger phrase.  '/w %s wc' for a complete list of available spells and triggers.",
        chatCmdAnnounceNotInGroup = "You must be in a part or raid to announce",
        chatCmdMatch = "match",
        chatCmdMatchValues = {
            exact = "exact",
            start = "start",
            any = "any"
        },
        chatCmdMatchError = "Valid matching modes are exact, start, or any",
        chatCmdMatchFeedback = "Current trigger matching mode = %s",
        chatCmdStatus = "status",
        chatCmdStatusHeader = "WhisperCast spell status:",
        chatCmdStatusQueueDisabled = "Queueing disabled",
        chatCmdStatusNotLearned = "Not in spell book",
        chatCmdStatusLowLevel = "Too low level",
        chatCmdStatusDisabled = "User disabled",
        chatCmdStatusNoSmartCast = "Not on any action bar, SmartCast disabled",
        chatCmdStatusSmartCast = "SmartCast enabled",
        chatCmdStatusNoTriggers = " No triggers, spell disabled",
        chatCmdStatusTriggerPrefix = " triggers =",
        chatCmdDebug = "debug",
        chatCmdHelp = "help",
        chatCmdHelpLine1 =  "/wc <command> [option]",
        chatCmdHelpLine2 =  "Commands are:",
        chatCmdHelpLine3 =  "    announce - Advertise WhisperCast availability in raid/party chat",
        chatCmdHelpLine4 =  "    enable/disable - enable or disable spell queueing from whispers",
        chatCmdHelpLine5 =  "    status - display all your queueable spells and their triggers",
        chatCmdHelpLine6 =  "    cast - execute one cast out of your queue",
        chatCmdHelpLine7 =  "    clear - clear your queue",
        chatCmdHelpLine8 =  "    reset - reset all options and standalone gui position",
        chatCmdHelpLine9 =  "    match [exact|start|any] - set your trigger matching level: exact=whisper is the same as a trigger, start=whisper starts with a trigger, or any=whisper contains a whole word matching trigger",
        chatCmdHelpLine10 =  "    show/hide - Set standalone gui window visability",
        chatCmdHelpLine11 = "    min/max - minimize or maxamize the standalone gui",
        chatCmdHelpLine12 = "    help - this message",
        chatCmdDefault = "To use WhisperCast, create a macro with the text /wc cast, and put it on your bar. For someone to get a buff or a debuff, tell them to make a macro with the text '/whisper "..UnitName("player").." <buff/debuff trigger>'  Your triggers can be displayed with '/wc status'. A Debuff trigger is what type of debuff you have, if you are poisoned, would be poison. '/wc help' for complete slash command help",
        chatCmdUnknown = "Unknown command, use '/wc help' for usage",

        chatNoSpells = "Your character doesn't have any queueable spells, WhisperCast is disabled",

        dropdownEnable = "Enable queueing",
        dropdownGroupOnly = "Queue group/raid only",
        dropdownCombatOnly = "Cast buffs in combat",
        dropdownHideWhispers = "Hide WhisperCast whispers",
        dropdownFeedbackWhispers = "Send feedback whispers",
        dropdownSoundSub = "Play sound when",
        dropdownSoundFirstQueue = "First spell is queued",
        dropdownSoundQueueEmpty = "Queue is empty",
        dropdownMatchingSub = "Trigger matching",
        dropdownMatchingExact = "Exact whisper",
        dropdownMatchingStart = "Start of whisper",
        dropdownMatchingAny = "Any word in whisper",
        dropdownDisabledSub = "Disabled spells",
        dropdownFlashQueue = "Flash queue when not empty",
        dropdownMinimize = "Minimized",
        dropdownHide = "Hide",
        dropdownCast = "Cast",
        dropdownClear = "Clear queue",

        buttonTextCast = "Cast",
        buttonTextClear = "Clear",
        mouseoverMinimize = "Minimize",
        mouseoverHide = "Hide",
        mouseoverTitanHint = "Left-click to Cast\nShift left-click to Clear",
    },
}

-- Default engligh spell names and triggers
WCLocale.PRIEST.Power_Word_Fortitude = "Power Word: Fortitude"
WCLocale.PRIEST.Power_Word_Fortitude_trigger = { "fort", "single fort", "fortitude", "stam", "sta", "stamina" }
WCLocale.PRIEST.Prayer_of_Fortitude = "Prayer of Fortitude"
WCLocale.PRIEST.Prayer_of_Fortitude_trigger = { "group fort", "group fortitude", "group stam", "group stamina" }
WCLocale.PRIEST.Prayer_of_Spirit = "Prayer of Spirit"
WCLocale.PRIEST.Prayer_of_Spirit_trigger = { "group spirit" }
WCLocale.PRIEST.Prayer_of_Shadow_Protection = "Prayer of Shadow Protection"
WCLocale.PRIEST.Prayer_of_Shadow_Protection_trigger = { "group shadow" }
WCLocale.PRIEST.Shadow_Protection = "Shadow Protection"
WCLocale.PRIEST.Shadow_Protection_trigger = { "shadow" }
WCLocale.PRIEST.Divine_Spirit = "Divine Spirit"
WCLocale.PRIEST.Divine_Spirit_trigger = { "spirit", "wis" }
WCLocale.PRIEST.Power_Infusion = "Power Infusion"
WCLocale.PRIEST.Power_Infusion_trigger = { "infusion", "pinf" }
WCLocale.PRIEST.Power_Word_Shield = "Power Word: Shield"
WCLocale.PRIEST.Power_Word_Shield_trigger = { "shield" }
WCLocale.PRIEST.Dispel_Magic = "Dispel Magic"
WCLocale.PRIEST.Dispel_Magic_trigger = { "dispel" }
WCLocale.PRIEST.Abolish_Disease = "Abolish Disease"
WCLocale.PRIEST.Abolish_Disease_trigger = { "disease" }
WCLocale.PRIEST.Cure_Disease = "Cure Disease"
WCLocale.PRIEST.Cure_Disease_trigger = { "cure disease" }
WCLocale.PRIEST.Fear_Ward = "Fear Ward"
WCLocale.PRIEST.Fear_Ward_trigger = { "fear", "ward" }
WCLocale.PRIEST.Fear_Ward_rank = nil

WCLocale.MAGE.Arcane_Intellect = "Arcane Intellect"
WCLocale.MAGE.Arcane_Intellect_trigger = { "ai", "int" }
WCLocale.MAGE.Arcane_Brilliance = "Arcane Brilliance"
WCLocale.MAGE.Arcane_Brilliance_trigger = { "ab", "group ai", "group int", "brilliance" }
WCLocale.MAGE.Dampen_Magic = "Dampen Magic"
WCLocale.MAGE.Dampen_Magic_trigger = { "dampen" }
WCLocale.MAGE.Amplify_Magic = "Amplify Magic"
WCLocale.MAGE.Amplify_Magic_trigger = { "amplify" }
WCLocale.MAGE.Remove_Lesser_Curse = "Remove Lesser Curse"
WCLocale.MAGE.Remove_Lesser_Curse_trigger = { "curse" }

WCLocale.DRUID.Mark_of_the_Wild = "Mark of the Wild"
WCLocale.DRUID.Mark_of_the_Wild_trigger = { "motw", "mark" }
WCLocale.DRUID.Gift_of_the_Wild = "Gift of the Wild"
WCLocale.DRUID.Gift_of_the_Wild_trigger = { "gotw", "gift", "group mark" }
WCLocale.DRUID.Thorns = "Thorns"
WCLocale.DRUID.Thorns_trigger = { "thorns" }
WCLocale.DRUID.Innervate = "Innervate"
WCLocale.DRUID.Innervate_trigger = { "innervate" }
WCLocale.DRUID.Remove_Curse = "Remove Curse"
WCLocale.DRUID.Remove_Curse_trigger = { "curse" }
WCLocale.DRUID.Abolish_Poison = "Abolish Poison"
WCLocale.DRUID.Abolish_Poison_trigger = { "poison" }
WCLocale.DRUID.Cure_Poison = "Cure Poison"
WCLocale.DRUID.Cure_Poison_trigger = { "poison" }

WCLocale.PALADIN.Blessing_of_Might = "Blessing of Might"
WCLocale.PALADIN.Blessing_of_Might_trigger = { "might" }
WCLocale.PALADIN.Blessing_of_Wisdom = "Blessing of Wisdom"
WCLocale.PALADIN.Blessing_of_Wisdom_trigger = { "wisdom", "wis" }
WCLocale.PALADIN.Blessing_of_Freedom = "Blessing of Freedom"
WCLocale.PALADIN.Blessing_of_Freedom_trigger = { "freedom" }
WCLocale.PALADIN.Blessing_of_Freedom_rank = nil
WCLocale.PALADIN.Blessing_of_Light = "Blessing of Light"
WCLocale.PALADIN.Blessing_of_Light_trigger = { "light" }
WCLocale.PALADIN.Blessing_of_Sacrifice = "Blessing of Sacrifice"
WCLocale.PALADIN.Blessing_of_Sacrifice_trigger = { "sacrifice" }
WCLocale.PALADIN.Blessing_of_Kings = "Blessing of Kings"
WCLocale.PALADIN.Blessing_of_Kings_trigger = { "kings", "king" }
WCLocale.PALADIN.Blessing_of_Salvation = "Blessing of Salvation"
WCLocale.PALADIN.Blessing_of_Salvation_trigger = { "salvation" }
WCLocale.PALADIN.Blessing_of_Sanctuary = "Blessing of Sanctuary"
WCLocale.PALADIN.Blessing_of_Sanctuary_trigger = { "sanctuary" }
WCLocale.PALADIN.Blessing_of_Protection = "Blessing of Protection"
WCLocale.PALADIN.Blessing_of_Protection_trigger = { "protection" }
WCLocale.PALADIN.Cleanse = "Cleanse"
WCLocale.PALADIN.Cleanse_trigger = { "cleanse", "dispel", "cure" }
WCLocale.PALADIN.Purify = "Purify"
WCLocale.PALADIN.Purify_trigger = { "purify", "poison", "disease" }
WCLocale.PALADIN.Greater_Blessing_of_Might = "Greater Blessing of Might"
WCLocale.PALADIN.Greater_Blessing_of_Might_trigger = { "greater might", "gmight", "gbom" }
WCLocale.PALADIN.Greater_Blessing_of_Wisdom = "Greater Blessing of Wisdom"
WCLocale.PALADIN.Greater_Blessing_of_Wisdom_trigger = { "greater wisdom", "gwisdom", "gbow" }
WCLocale.PALADIN.Greater_Blessing_of_Light = "Greater Blessing of Light"
WCLocale.PALADIN.Greater_Blessing_of_Light_trigger = { "greater light", "glight", "gbol" }
WCLocale.PALADIN.Greater_Blessing_of_Kings = "Greater Blessing of Kings"
WCLocale.PALADIN.Greater_Blessing_of_Kings_trigger = { "greater kings", "gkings", "gbok" }
WCLocale.PALADIN.Greater_Blessing_of_Salvation = "Greater Blessing of Salvation"
WCLocale.PALADIN.Greater_Blessing_of_Salvation_trigger = { "greater salvation", "gsalvation", "gbos" }
WCLocale.PALADIN.Greater_Blessing_of_Sanctuary = "Greater Blessing of Sanctuary"
WCLocale.PALADIN.Greater_Blessing_of_Sanctuary_trigger = { "greater sanctuary", "gsanctuary", "gbosa" }

WCLocale.SHAMAN.Cure_Poison = "Cure Poison"
WCLocale.SHAMAN.Cure_Poison_trigger = { "poison" }
WCLocale.SHAMAN.Cure_Disease = "Cure Disease"
WCLocale.SHAMAN.Cure_Disease_trigger = { "disease" }
WCLocale.SHAMAN.Water_Breathing = "Water Breathing"
WCLocale.SHAMAN.Water_Breathing_trigger = { "water" }

WCLocale.WARLOCK.Unending_Breath = "Unending Breath"
WCLocale.WARLOCK.Unending_Breath_trigger = { "water" }
WCLocale.WARLOCK.Detect_Greater_Invisibility = "Detect Greater Invisibility"
WCLocale.WARLOCK.Detect_Greater_Invisibility_trigger = { "invis", "invisible" }
WCLocale.WARLOCK.Ritual_of_Summoning = "Ritual of Summoning"
WCLocale.WARLOCK.Ritual_of_Summoning_trigger = { "summon" }

