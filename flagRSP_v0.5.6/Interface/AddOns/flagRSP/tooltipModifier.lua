
TooltipModifierUnknownPlayer = {};
TooltipModifierKnownPlayer = {};
TooltipModifierNPC = {};
TooltipModifierPet = {};
TooltipModifierSelf = {};
TooltipModifierIgnored = {};

TooltipModifierUnknownPlayer[1] = {};
TooltipModifierUnknownPlayer[1].conditionType = "lineNumber";
TooltipModifierUnknownPlayer[1].conditionValue = "l1";
TooltipModifierUnknownPlayer[1].conditionValue2 = "";
TooltipModifierUnknownPlayer[1].modifierType = {};
TooltipModifierUnknownPlayer[1].modifierValue = {};
TooltipModifierUnknownPlayer[1].modifierType[0] = "replace";
TooltipModifierUnknownPlayer[1].modifierValue[0] = "%flagRSPNameLine";
TooltipModifierUnknownPlayer[1].modifierType[1] = "appendLine";
TooltipModifierUnknownPlayer[1].modifierValue[1] = "%flagRSPGuildLine";

TooltipModifierUnknownPlayer[0] = {};
TooltipModifierUnknownPlayer[0].conditionType = "matchString";
TooltipModifierUnknownPlayer[0].conditionValue = "%UnitGuild";
TooltipModifierUnknownPlayer[0].conditionValue2 = "";
TooltipModifierUnknownPlayer[0].modifierType = {};
TooltipModifierUnknownPlayer[0].modifierValue = {};

TooltipModifierUnknownPlayer[0].modifierType[0] = "delete";
TooltipModifierUnknownPlayer[0].modifierValue[0] = "";

TooltipModifierUnknownPlayer[2] = {};
TooltipModifierUnknownPlayer[2].conditionType = "matchString";
TooltipModifierUnknownPlayer[2].conditionValue = FlagRSP_Locale_Level;
TooltipModifierUnknownPlayer[2].conditionValue2 = "";
TooltipModifierUnknownPlayer[2].modifierType = {};
TooltipModifierUnknownPlayer[2].modifierValue = {};
TooltipModifierUnknownPlayer[2].modifierType[0] = "replace";
TooltipModifierUnknownPlayer[2].modifierValue[0] = "%flagRSPLevelLine";
TooltipModifierUnknownPlayer[2].modifierType[1] = "appendLine";
TooltipModifierUnknownPlayer[2].modifierValue[1] = "%flagRSPRankLine";

TooltipModifierUnknownPlayer[5] = {};
TooltipModifierUnknownPlayer[5].conditionType = "matchString";
TooltipModifierUnknownPlayer[5].conditionValue = "^%UnitLevel%s+%UnitRace %UnitClass";
TooltipModifierUnknownPlayer[5].conditionValue2 = "";
TooltipModifierUnknownPlayer[5].modifierType = {};
TooltipModifierUnknownPlayer[5].modifierValue = {};
TooltipModifierUnknownPlayer[5].modifierType[0] = "replace";
TooltipModifierUnknownPlayer[5].modifierValue[0] = "%flagRSPLevelLine";
TooltipModifierUnknownPlayer[5].modifierType[1] = "appendLine";
TooltipModifierUnknownPlayer[5].modifierValue[1] = "%flagRSPRankLine";

TooltipModifierUnknownPlayer[3] = {};
TooltipModifierUnknownPlayer[3].conditionType = "lineNumber";
TooltipModifierUnknownPlayer[3].conditionValue = "l10";
TooltipModifierUnknownPlayer[3].conditionValue2 = "";
TooltipModifierUnknownPlayer[3].modifierType = {};
TooltipModifierUnknownPlayer[3].modifierValue = {};
TooltipModifierUnknownPlayer[3].modifierType[0] = "replace";
TooltipModifierUnknownPlayer[3].modifierValue[0] = "%flagRSPRPLine";
TooltipModifierUnknownPlayer[3].modifierType[2] = "appendLine";
TooltipModifierUnknownPlayer[3].modifierValue[2] = "%flagRSPCharStatusLine";
TooltipModifierUnknownPlayer[3].modifierType[1] = "appendLine";
TooltipModifierUnknownPlayer[3].modifierValue[1] = "%flagRSPGuildFriendlistText";

TooltipModifierUnknownPlayer[4] = {};
TooltipModifierUnknownPlayer[4].conditionType = "matchString";
TooltipModifierUnknownPlayer[4].conditionValue = FlagRSP_Locale_ResurrectableText;
TooltipModifierUnknownPlayer[4].conditionValue2 = "";
TooltipModifierUnknownPlayer[4].modifierType = {};
TooltipModifierUnknownPlayer[4].modifierValue = {};
TooltipModifierUnknownPlayer[4].modifierType[0] = "colorLine";
TooltipModifierUnknownPlayer[4].modifierValue[0] = "00FF00";


TooltipModifierKnownPlayer[1] = {};
TooltipModifierKnownPlayer[1].conditionType = "lineNumber";
TooltipModifierKnownPlayer[1].conditionValue = "l1";
TooltipModifierKnownPlayer[1].conditionValue2 = "";
TooltipModifierKnownPlayer[1].modifierType = {};
TooltipModifierKnownPlayer[1].modifierValue = {};
TooltipModifierKnownPlayer[1].modifierType[0] = "replace";
TooltipModifierKnownPlayer[1].modifierValue[0] = "%flagRSPNameLine";
TooltipModifierKnownPlayer[1].modifierType[2] = "appendLine";
TooltipModifierKnownPlayer[1].modifierValue[2] = "%flagRSPTitleLine";
TooltipModifierKnownPlayer[1].modifierType[1] = "appendLine";
TooltipModifierKnownPlayer[1].modifierValue[1] = "%flagRSPGuildLine";

TooltipModifierKnownPlayer[0] = {};
TooltipModifierKnownPlayer[0].conditionType = "matchString";
TooltipModifierKnownPlayer[0].conditionValue = "%UnitGuild";
TooltipModifierKnownPlayer[0].conditionValue2 = "";
TooltipModifierKnownPlayer[0].modifierType = {};
TooltipModifierKnownPlayer[0].modifierValue = {};
TooltipModifierKnownPlayer[0].modifierType[0] = "delete";
TooltipModifierKnownPlayer[0].modifierValue[0] = "";

TooltipModifierKnownPlayer[2] = {};
TooltipModifierKnownPlayer[2].conditionType = "matchString";
TooltipModifierKnownPlayer[2].conditionValue = FlagRSP_Locale_Level;
TooltipModifierKnownPlayer[2].conditionValue2 = "";
TooltipModifierKnownPlayer[2].modifierType = {};
TooltipModifierKnownPlayer[2].modifierValue = {};
TooltipModifierKnownPlayer[2].modifierType[0] = "replace";
TooltipModifierKnownPlayer[2].modifierValue[0] = "%flagRSPLevelLine";
TooltipModifierKnownPlayer[2].modifierType[1] = "appendLine";
TooltipModifierKnownPlayer[2].modifierValue[1] = "%flagRSPRankLine";

TooltipModifierKnownPlayer[5] = {};
TooltipModifierKnownPlayer[5].conditionType = "matchString";
TooltipModifierKnownPlayer[5].conditionValue = "^%UnitLevel%s+%UnitRace %UnitClass";
TooltipModifierKnownPlayer[5].conditionValue2 = "";
TooltipModifierKnownPlayer[5].modifierType = {};
TooltipModifierKnownPlayer[5].modifierValue = {};
TooltipModifierKnownPlayer[5].modifierType[0] = "replace";
TooltipModifierKnownPlayer[5].modifierValue[0] = "%flagRSPLevelLine";
TooltipModifierKnownPlayer[5].modifierType[1] = "appendLine";
TooltipModifierKnownPlayer[5].modifierValue[1] = "%flagRSPRankLine";

TooltipModifierKnownPlayer[3] = {};
TooltipModifierKnownPlayer[3].conditionType = "lineNumber";
TooltipModifierKnownPlayer[3].conditionValue = "l10";
TooltipModifierKnownPlayer[3].conditionValue2 = "";
TooltipModifierKnownPlayer[3].modifierType = {};
TooltipModifierKnownPlayer[3].modifierValue = {};
TooltipModifierKnownPlayer[3].modifierType[0] = "replace";
TooltipModifierKnownPlayer[3].modifierValue[0] = "%flagRSPRPLine";
TooltipModifierKnownPlayer[3].modifierType[3] = "appendLine";
TooltipModifierKnownPlayer[3].modifierValue[3] = "%flagRSPCharStatusLine";
TooltipModifierKnownPlayer[3].modifierType[2] = "appendLine";
TooltipModifierKnownPlayer[3].modifierValue[2] = "%flagRSPFriendlistText";
TooltipModifierKnownPlayer[3].modifierType[1] = "appendLine";
TooltipModifierKnownPlayer[3].modifierValue[1] = "%flagRSPGuildFriendlistText";

TooltipModifierKnownPlayer[4] = {};
TooltipModifierKnownPlayer[4].conditionType = "matchString";
TooltipModifierKnownPlayer[4].conditionValue = FlagRSP_Locale_ResurrectableText;
TooltipModifierKnownPlayer[4].conditionValue2 = "";
TooltipModifierKnownPlayer[4].modifierType = {};
TooltipModifierKnownPlayer[4].modifierValue = {};
TooltipModifierKnownPlayer[4].modifierType[0] = "colorLine";
TooltipModifierKnownPlayer[4].modifierValue[0] = "00FF00";


TooltipModifierSelf[0] = {};
TooltipModifierSelf[0].conditionType = "lineNumber";
TooltipModifierSelf[0].conditionValue = "l1";
TooltipModifierSelf[0].conditionValue2 = "";
TooltipModifierSelf[0].modifierType = {};
TooltipModifierSelf[0].modifierValue = {};
TooltipModifierSelf[0].modifierType[0] = "replace";
TooltipModifierSelf[0].modifierValue[0] = "%flagRSPNameLine";
TooltipModifierSelf[0].modifierType[8] = "appendLine";
TooltipModifierSelf[0].modifierValue[8] = "%flagRSPTitleLine";
TooltipModifierSelf[0].modifierType[7] = "appendLine";
TooltipModifierSelf[0].modifierValue[7] = "%flagRSPLevelLine";
TooltipModifierSelf[0].modifierType[6] = "appendLine";
TooltipModifierSelf[0].modifierValue[6] = "%flagRSPRankLine";
TooltipModifierSelf[0].modifierType[5] = "appendLine";
TooltipModifierSelf[0].modifierValue[5] = "%flagRSPGuildLine";
TooltipModifierSelf[0].modifierType[4] = "appendLine";
TooltipModifierSelf[0].modifierValue[4] = "%flagRSPRPLine";
TooltipModifierSelf[0].modifierType[3] = "appendLine";
TooltipModifierSelf[0].modifierValue[3] = "%flagRSPCharStatusLine";
TooltipModifierSelf[0].modifierType[2] = "appendLine";
TooltipModifierSelf[0].modifierValue[2] = "%flagRSPFriendlistText";
TooltipModifierSelf[0].modifierType[1] = "appendLine";
TooltipModifierSelf[0].modifierValue[1] = "%flagRSPGuildFriendlistText";


TooltipModifierNPC[0] = {};
TooltipModifierNPC[0].conditionType = "matchString";
TooltipModifierNPC[0].conditionValue =  FlagRSP_Locale_Level;
TooltipModifierNPC[0].conditionValue2 = "";
TooltipModifierNPC[0].modifierType = {};
TooltipModifierNPC[0].modifierValue = {};
TooltipModifierNPC[0].modifierType[0] = "replace";
TooltipModifierNPC[0].modifierValue[0] = "%flagRSPLevelLine";

TooltipModifierNPC[6] = {};
TooltipModifierNPC[6].conditionType = "matchString";
TooltipModifierNPC[6].conditionValue =  "%UnitLevel%s+%UnitClass";
TooltipModifierNPC[6].conditionValue2 = "";
TooltipModifierNPC[6].modifierType = {};
TooltipModifierNPC[6].modifierValue = {};
TooltipModifierNPC[6].modifierType[0] = "replace";
TooltipModifierNPC[6].modifierValue[0] = "%flagRSPLevelLine";

TooltipModifierNPC[1] = {};
TooltipModifierNPC[1].conditionType = "lineNumber";
TooltipModifierNPC[1].conditionValue =  "l10";
TooltipModifierNPC[1].conditionValue2 = "";
TooltipModifierNPC[1].modifierType = {};
TooltipModifierNPC[1].modifierValue = {};
TooltipModifierNPC[1].modifierType[0] = "replace";
TooltipModifierNPC[1].modifierValue[0] = "%flagRSPFriendlistText";

--TooltipModifierNPC[2] = {};
--TooltipModifierNPC[2].conditionType = "matchString";
--TooltipModifierNPC[2].conditionValue =  "temporarydisabledpvp";
--TooltipModifierNPC[2].conditionValue2 = "";
--TooltipModifierNPC[2].modifierType = {};
--TooltipModifierNPC[2].modifierValue = {};
--TooltipModifierNPC[2].modifierType[0] = "delete";
--TooltipModifierNPC[2].modifierValue[0] = "";

TooltipModifierNPC[2] = {};
TooltipModifierNPC[2].conditionType = "lineNumber";
TooltipModifierNPC[2].conditionValue = "l1";
TooltipModifierNPC[2].conditionValue2 = "";
TooltipModifierNPC[2].modifierType = {};
TooltipModifierNPC[2].modifierValue = {};
TooltipModifierNPC[2].modifierType[0] = "replace";
TooltipModifierNPC[2].modifierValue[0] = "%flagRSPNameLine";

TooltipModifierNPC[3] = {};
TooltipModifierNPC[3].conditionType = "matchExactString";
TooltipModifierNPC[3].conditionValue =  FlagRSP_Locale_CivilianText;
TooltipModifierNPC[3].conditionValue2 = "";
TooltipModifierNPC[3].modifierType = {};
TooltipModifierNPC[3].modifierValue = {};
TooltipModifierNPC[3].modifierType[0] = "replace";
TooltipModifierNPC[3].modifierValue[0] = "%flagRSPCivilianLine";

TooltipModifierNPC[4] = {};
TooltipModifierNPC[4].conditionType = "matchExactString";
TooltipModifierNPC[4].conditionValue =  FlagRSP_Locale_SkinnableText;
TooltipModifierNPC[4].conditionValue2 = "";
TooltipModifierNPC[4].modifierType = {};
TooltipModifierNPC[4].modifierValue = {};
TooltipModifierNPC[4].modifierType[0] = "replace";
TooltipModifierNPC[4].modifierValue[0] = "%flagRSPSkinnableLine";


TooltipModifierPet[0] = {};
TooltipModifierPet[0].conditionType = "matchString";
TooltipModifierPet[0].conditionValue = FlagRSP_Locale_MinionText[0];
TooltipModifierPet[0].conditionValue2 = "";
TooltipModifierPet[0].modifierType = {};
TooltipModifierPet[0].modifierValue = {};
TooltipModifierPet[0].modifierType[0] = "delete";
TooltipModifierPet[0].modifierValue[0] = "";

TooltipModifierPet[1] = {};
TooltipModifierPet[1].conditionType = "matchString";
TooltipModifierPet[1].conditionValue = FlagRSP_Locale_MinionText[1];
TooltipModifierPet[1].conditionValue2 = "";
TooltipModifierPet[1].modifierType = {};
TooltipModifierPet[1].modifierValue = {};
TooltipModifierPet[1].modifierType[0] = "delete";
TooltipModifierPet[1].modifierValue[0] = "";

TooltipModifierPet[2] = {};
TooltipModifierPet[2].conditionType = "lineNumber";
TooltipModifierPet[2].conditionValue = "l1";
TooltipModifierPet[2].conditionValue2 = "";
TooltipModifierPet[2].modifierType = {};
TooltipModifierPet[2].modifierValue = {};
TooltipModifierPet[2].modifierType[0] = "replace";
TooltipModifierPet[2].modifierValue[0] = "%flagRSPNameLine";
TooltipModifierPet[2].modifierType[1] = "appendLine";
TooltipModifierPet[2].modifierValue[1] = "%flagRSPPetOwnerSubLine";

TooltipModifierPet[3] = {};
TooltipModifierPet[3].conditionType = "matchString";
TooltipModifierPet[3].conditionValue =  FlagRSP_Locale_Level;
TooltipModifierPet[3].conditionValue2 = "";
TooltipModifierPet[3].modifierType = {};
TooltipModifierPet[3].modifierValue = {};
TooltipModifierPet[3].modifierType[0] = "replace";
TooltipModifierPet[3].modifierValue[0] = "%flagRSPLevelLine";

TooltipModifierPet[4] = {};
TooltipModifierPet[4].conditionType = "matchString";
TooltipModifierPet[4].conditionValue =  "%UnitLevel%s+%UnitClass";
TooltipModifierPet[4].conditionValue2 = "";
TooltipModifierPet[4].modifierType = {};
TooltipModifierPet[4].modifierValue = {};
TooltipModifierPet[4].modifierType[0] = "replace";
TooltipModifierPet[4].modifierValue[0] = "%flagRSPLevelLine";


TooltipModifierIgnored[0] = {};
TooltipModifierIgnored[0].conditionType = "true";
TooltipModifierIgnored[0].conditionValue = "";
TooltipModifierIgnored[0].conditionValue2 = "";
TooltipModifierIgnored[0].modifierType = {};
TooltipModifierIgnored[0].modifierValue = {};
TooltipModifierIgnored[0].modifierType[0] = "delete";
TooltipModifierIgnored[0].modifierValue[0] = "";

TooltipModifierIgnored[1] = {};
TooltipModifierIgnored[1].conditionType = "lineNumber";
TooltipModifierIgnored[1].conditionValue = "l1";
TooltipModifierIgnored[1].conditionValue2 = "";
TooltipModifierIgnored[1].modifierType = {};
TooltipModifierIgnored[1].modifierValue = {};
TooltipModifierIgnored[1].modifierType[0] = "replace";
TooltipModifierIgnored[1].modifierValue[0] = "%UnitName";
TooltipModifierIgnored[1].modifierType[1] = "appendLine";
TooltipModifierIgnored[1].modifierValue[1] = FlagRSP_Locale_Ignored;

