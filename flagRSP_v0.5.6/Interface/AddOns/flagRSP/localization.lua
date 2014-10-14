-- This is how "Level" is called in tooltip, (MUST BE EXACT!)
-- flagRSP needs to detect which line contains the level.
-- Think it's niveau or similar in French.
FlagRSP_Locale_Level = "Level";
-- This determines how the common language is called. (MUST BE EXACT!)
-- This is the alliance language speakable by all four races.
FlagRSP_Locale_CLanguage = "Common";

-- This determines how pets are named in the tooltip. (MUST BE EXACT!)
-- It's needed to get their owners name.
-- Should be something like: "Minion of <player Name>"
-- (.+) stands for the player's name.
-- IMPORTANT: replace player's name  by (.+), the rest MUST be exact!
-- All occurrances must be included.
FlagRSP_Locale_MinionLine = {};
FlagRSP_Locale_MinionLine[0] = "(.+)'s Pet";
FlagRSP_Locale_MinionLine[1] = "(.+)'s Minion";

-- keywords which determine the owner line in the tooltip of a pet. (MUST BE EXACT!)
-- If flagRSP finds these words it knows that the line is a owner line.
-- All occurrances must be included.
FlagRSP_Locale_MinionText = {};
FlagRSP_Locale_MinionText[0] = "Pet";
FlagRSP_Locale_MinionText[1] = "Minion";

-- messages from client after getting AFK. (MUST BE EXACT!)
FlagRSP_Locale_AFK = "You are now AFK:";
FlagRSP_Locale_NOTAFK = "You are no longer AFK.";

-- This is how civilians are called in tooltip. (MUST BE EXACT!)
FlagRSP_Locale_CivilianText = "Civilian";
-- This is how "Skinnable" is called in tooltip. (MUST BE EXACT!)
FlagRSP_Locale_SkinnableText = "Skinnable";
-- This is how the resurrectable line is called in tooltip. (MUST BE EXACT!)
FlagRSP_Locale_ResurrectableText = "Resurrectable";
-- This is how your skinning skill is called. (MUST BE EXACT!)
FlagRSP_Locale_Skinning = "Skinning";

--------------------------------------------------------------------------------------------------
-- Having translated until here flagRSP should run on your client. It will be in English however.
--------------------------------------------------------------------------------------------------

-- This is how the civilian line should appear in tooltip. Should be the same as above.
FlagRSP_Locale_CivilianLine = "Civilian";
-- This is how the "Skinnable" line should appear in tooltip. Should be the same as above.
FlagRSP_Locale_SkinnableLine = "Skinnable";

-- This is how unknown players should be named.
FlagRSP_Locale_Unknown = "<Unknown>";
FlagRSP_Locale_UnknownPet = "<Unknown being>";
-- %flagRSPPetOwnerLine is a dynamical variable. flagRSP will care about such variables. 
-- These MUST NOT be translated.
--FlagRSP_Locale_UnknownPetKnownPlayer = "<%flagRSPPetOwnerLine>";

-- Tooltip texts for alternative level display. Do not change this
-- %-variables. You can use them as a substitution for the alternative 
-- level descriptions which follow later. flagRSP will decide which
-- description will be chosen.
FlagRSP_Locale_AltLevelLine = "Experience: ";
-- Tooltip texts for traditional level display. Should be the same as your client
-- uses to display level/class/race information in tooltip.
FlagRSP_Locale_TradLevelLine = "Level ";

-- Tooltip texts for name display of known players.
--FlagRSP_Locale_KnownNameLine = "%UnitName %flagRSPSurname";
---FlagRSP_Locale_KnownPetNameLine = "%UnitName";
-- Line for unknown pets which owner we know (comment out or leave empty for the standard line).
-- A "--" means comment. Unless you don't want to change default behaviour you can ignore this.
--FlagRSP_Locale_KnownPetOwnerLine = "%flagRSPPetOwner's companion";

-- Tooltip texts for PvP rank display.
FlagRSP_Locale_PVPRankLine = "Rank: ";

-- Tooltip texts for character status display.
FlagRSP_Locale_CharStatusLine = "Character status: ";

-- Tooltip texts for PvP rank display.
FlagRSP_Locale_TitleLine = "%UnitTitle";

-- Tooltip texts for guild display.
--FlagRSP_Locale_GuildLine = "<%UnitGuild>";

-- Prefix before alternative level display.
-- Commented out because not needed anymore.
--FlagRSP_Locale_AltLevelPrefix = "Experience: ";
-- Prefix before traditional level display.
--FlagRSP_Locale_TradLevelPrefix = "Level ";

-- Prefix for PvP rank display.
--FlagRSP_Locale_PVPRankPrefix = "Rank: ";

-- Descriptions for alternative level display.
-- Objects that are 7 or more levels weaker than you.
FlagRSP_Locale_Epuny = "extremely puny";
-- Objects 5 or 6 levels weaker than you.
FlagRSP_Locale_Puny = "puny";
-- Objects 2 to 4 levels weaker.
FlagRSP_Locale_Weak = "weak";
-- Objects 1 level weaker to 1 level stronger.
FlagRSP_Locale_Equal = "equal";
-- Objects 2 to 3 levels stronger.
FlagRSP_Locale_Strong = "strong";
-- Objects 4 to 6 levels stronger.
FlagRSP_Locale_Vstrong = "very strong";
-- Objects 7 to 9 levels stronger.
FlagRSP_Locale_Estrong = "extremely strong";
-- Objects 10 or more levels stronger.
FlagRSP_Locale_Impossible = "hopelessly superior";

-- Targetframe texts for alternative level display.
-- Objects that are 7 or more levels weaker than you.
FlagRSP_Locale_TF_Epuny = "<<";
-- Objects 5 or 6 levels weaker than you.
FlagRSP_Locale_TF_Puny = "<<";
-- Objects 2 to 4 levels weaker.
FlagRSP_Locale_TF_Weak = "<";
-- Objects 1 level weaker to 1 level stronger.
FlagRSP_Locale_TF_Equal = "=";
-- Objects 2 to 3 levels stronger.
FlagRSP_Locale_TF_Strong = ">";
-- Objects 4 to 6 levels stronger.
FlagRSP_Locale_TF_Vstrong = ">>";
-- Objects 7 to 9 levels stronger.
FlagRSP_Locale_TF_Estrong = "!";
-- Objects 10 or more levels stronger.
FlagRSP_Locale_TF_Impossible = "!!";

-- Elite Objects.
-- will be added behind alternative description (therefore the ",").
FlagRSP_Locale_Elite = ", elite";
-- Boss Objects.
FlagRSP_Locale_Boss = ", boss";

-- This is how roleplayers should be called.
FlagRSP_Locale_RP = "<Roleplayer>";
FlagRSP_Locale_RP2 = "<Casual roleplayer>"; 
FlagRSP_Locale_RP3 = "<Fulltime roleplayer>";
FlagRSP_Locale_RP4 = "<Roleplaying beginner>"; 

-- This is how character status should be called.
FlagRSP_Locale_OOC = "<out of character>";
FlagRSP_Locale_IC = "<in character>"; 
FlagRSP_Locale_FFAIC = "<in character, looking for contact>";
FlagRSP_Locale_ST = "<Storyteller>";

-- Notification that player is on ignore list.
FlagRSP_Locale_Ignored = "Ignored!";

-- Command line options for "/rsp" command.
-- For example "/rsp names".
-- Option to (de)activate hiding of names.
FlagRSP_Locale_HideNames_Cmd = "names";
-- Option to (de)activate alternative level display.
FlagRSP_Locale_LevelDisp_Cmd = "level";
-- Option to (de)activate PvP rank display.
FlagRSP_Locale_RankDisp_Cmd = "ranks";
-- Option to (de)activate guild display.
FlagRSP_Locale_GuildDisp_Cmd = "guilds";
-- Option to set your surname.
FlagRSP_Locale_Surname_Cmd = "surname";
-- Option to set title.
FlagRSP_Locale_Title_Cmd = "title";
-- Option to set player afk.
FlagRSP_Locale_AFK_Cmd = "afk";
-- Option to plot status.
FlagRSP_Locale_Status_Cmd = "status";

-- Option to show own tooltip.
FlagRSP_Locale_OwnTooltip_Cmd = "owntooltip";

-- Option to set beginner-flag.
FlagRSP_Locale_Beginner_Cmd = "beginner";
-- Option for casual flag.
FlagRSP_Locale_Casual_Cmd = "casual";
-- Option for normal flag.
FlagRSP_Locale_Normal_Cmd = "normal";
-- Option for fulltime flag.
FlagRSP_Locale_Fulltime_Cmd = "fulltime";
-- Option to deactivate rp flag.
FlagRSP_Locale_NoRP_Cmd = "off";

-- Option to set ooc flag.
FlagRSP_Locale_OOC_Cmd = "ooc";
-- Option for ic flag.
FlagRSP_Locale_IC_Cmd = "ic";
-- Option for ic-ffa flag.
FlagRSP_Locale_ICFFA_Cmd = "ffa-ic";
-- Option to deactivate character status flag.
FlagRSP_Locale_NoCStatus_Cmd = "stopcharstat";
-- Option for st flag.
FlagRSP_Locale_ST_Cmd = "st";

-- OnLoad-Message (%flagRSPVersion for flagRSP version).
FlagRSP_Locale_OnLoad = {};
FlagRSP_Locale_OnLoad[0] = "flagRSP %flagRSPVersion initializing...";
FlagRSP_Locale_OnLoad[1] = "You can already start playing but flagRSP needs some moments to get ready.";
FlagRSP_Locale_OnLoad[2] = "/rsp ? for an overview of flagRSP's options."

-- Messages after several commands.
-- Message if Hiding of Names was activated.
FlagRSP_Locale_HideNames = "Hiding of unknown names activated.";
FlagRSP_Locale_UnhideNames = "Hiding of unknown names deactivated.";

-- Hiding of exact levels.
FlagRSP_Locale_HideLevels = "Alternative level display activated.";
FlagRSP_Locale_UnhideLevels = "Alternative level display deactivated.";

-- PvP rank display options.
FlagRSP_Locale_ShowRanks = "Displaying of PvP ranks enabled.";
FlagRSP_Locale_HideRanks = "Displaying of PvP ranks disabled.";

-- Guild display options.
FlagRSP_Locale_ShowAllGuild = "Displaying of all guild names enabled.";
FlagRSP_Locale_ShowKnownGuild = "Displaying of only known guild names enabled.";
FlagRSP_Locale_HideGuild = "Displaying of guild names disabled at all.";

-- Message if beginner flag set.
FlagRSP_Locale_BeginnerFlagSet = "Roleplaying beginner tag set. Have fun discovering a new passion!";
-- Casual roleplayer.
FlagRSP_Locale_CasualFlagSet = "Casual roleplayer tag set.";
-- Normal roleplayer.
FlagRSP_Locale_NormalRPFlagSet = "Normal roleplayer tag set.";
-- Fulltime roleplayer.
FlagRSP_Locale_FulltimeFlagSet = "Fulltime roleplayer tag set.";
-- No roleplayer.
FlagRSP_Locale_NoRPFlagSet = "Roleplayer tag deactivated!";

-- 
-- 
FlagRSP_Locale_UnicornOfficial = "<Unicorn>"; 
FlagRSP_Locale_UnicornNonOfficial = "<Unicorn, NOT OFFICIALLY CONFIRMED>"; 

-- Message if ooc flag set.
FlagRSP_Locale_OOCFlag = "Now playing out of character.";
-- Message if ic flag set.
FlagRSP_Locale_ICFlag = "Now playing in character. Live your role!";
-- Message if free for all ic flag set.
FlagRSP_Locale_FFAICFlag = "Now playing in character free-for-all. Others players are invited to contact you.";
-- Message if no character status flag set.
FlagRSP_Locale_NoCFlag = "No character status set.";
-- Message if st flag set.
FlagRSP_Locale_STFlag = "Now playing as a storyteller. Adventure begins!";

-- Message that no surname is set.
FlagRSP_Locale_NoSurname = "No surname set.";
-- Message with new surname (%s is new name).
FlagRSP_Locale_NewSurname = "Surname set to: %s.";

-- Message that no title is set.
FlagRSP_Locale_NoTitle = "No title set.";
-- Message with new title (%s is new title).
FlagRSP_Locale_NewTitle = "Title set to: %s.";

-- Message for updated description.
FlagRSP_Locale_DescUpdate = "Description updated."

-- Message for flagRSP-AFK activated.
FlagRSP_Locale_AFK_Activated = "AFK activated. Sending of flags deactivated.";
-- Message for flagRSP-AFK deactivated.
FlagRSP_Locale_AFK_Deactivated = "AFK deactivated. Sending of flags activated.";

-- Message for sending rp-help request.
FlagRSP_Locale_RPTicket = "Sending RP help request:";

-- The help lines.
FlagRSP_Locale_Help = {};
FlagRSP_Locale_Help[0] = "flagRSP: Help --------------------------------------------------------------";
FlagRSP_Locale_Help[1] = "/rsp toggle --> (De)Activates roleplayer flag.";
FlagRSP_Locale_Help[2] = "/rsp " .. FlagRSP_Locale_HideNames_Cmd .. " --> Toggle hiding of unknown names.";
FlagRSP_Locale_Help[3] = "/rsp " .. FlagRSP_Locale_LevelDisp_Cmd .. " --> Toggle alternative level display.";
FlagRSP_Locale_Help[4] = "/rsp " .. FlagRSP_Locale_RankDisp_Cmd .. " --> Toggle display of PvP ranks.";
FlagRSP_Locale_Help[5] = "/rsp " .. FlagRSP_Locale_GuildDisp_Cmd .. " --> Toggle display of guild names.";
FlagRSP_Locale_Help[6] = "/rsp " .. FlagRSP_Locale_Surname_Cmd .. " <TEXT> --> Set surname to <TEXT>.";
FlagRSP_Locale_Help[7] = "/rsp " .. FlagRSP_Locale_Title_Cmd .. " <TEXT> --> Set title to <TEXT>.";
FlagRSP_Locale_Help[8] = "/rsp [" .. FlagRSP_Locale_Beginner_Cmd .. "/" .. FlagRSP_Locale_Casual_Cmd .. "/" .. FlagRSP_Locale_Normal_Cmd .. "/" .. FlagRSP_Locale_Fulltime_Cmd .. "/" .. FlagRSP_Locale_NoRP_Cmd .. "] --> Set preferred roleplaying style :";
FlagRSP_Locale_Help[9] = "   " .. FlagRSP_Locale_Beginner_Cmd .. ": Roleplaying beginner, i.e. a willing rp newbie. Mistakes shoud be forgiven.";
FlagRSP_Locale_Help[10] = "   " .. FlagRSP_Locale_Casual_Cmd .. ": Casual roleplayer, i.e. someone who needs or at least accepts ooc-chat.";
FlagRSP_Locale_Help[11] = "   " .. FlagRSP_Locale_Normal_Cmd .. ": Normal roleplayer, i.e. someone who does not want ooc in general but accepts it if need be.";
FlagRSP_Locale_Help[12] = "   " .. FlagRSP_Locale_Fulltime_Cmd .. ": Fulltime roleplayer, i.e. someone who strictly rejects ooc and plays his role fulltime.";
FlagRSP_Locale_Help[13] = "   " .. FlagRSP_Locale_NoRP_Cmd .. ": Completely remove roleplaying flag.";
FlagRSP_Locale_Help[14] = "/rsp [" .. FlagRSP_Locale_OOC_Cmd .. "/" .. FlagRSP_Locale_IC_Cmd .. "/" .. FlagRSP_Locale_ICFFA_Cmd .. "/" .. FlagRSP_Locale_ST_Cmd .. "/" .. FlagRSP_Locale_NoCStatus_Cmd .. "] --> Sets character status:";
FlagRSP_Locale_Help[15] = "   " .. FlagRSP_Locale_OOC_Cmd .. ": Out of character, player does not play his/her role.";
FlagRSP_Locale_Help[16] = "   " .. FlagRSP_Locale_IC_Cmd .. ": In character, player plays his/her role!";
FlagRSP_Locale_Help[17] = "   " .. FlagRSP_Locale_ICFFA_Cmd .. ": In character free-for-all, like ".. FlagRSP_Locale_IC_Cmd .. " but player wishes contact to other players.";
FlagRSP_Locale_Help[18] = "   " .. FlagRSP_Locale_ST_Cmd .. ": Storyteller. Player who guides RP.";
FlagRSP_Locale_Help[19] = "   " .. FlagRSP_Locale_NoCStatus_Cmd .. ": Remove character status flag.";
FlagRSP_Locale_Help[20] = "/rsp " .. FlagRSP_Locale_AFK_Cmd .. " --> Sets you to afk-mode and stops sending of own flags.";
FlagRSP_Locale_Help[21] = "/rsp " .. FlagRSP_Locale_Status_Cmd .. " --> Show overview of options for current player.";
FlagRSP_Locale_Help[22] = "/rsp " ..FlagRSP_Locale_OwnTooltip_Cmd .. " --> Toggle display of tooltip for yourself.";
FlagRSP_Locale_Help[23] = "/rspon --> Activate normal roleplayer flag and alternative name and level display.";
FlagRSP_Locale_Help[24] = "/rspoff --> Deactivate roleplayer flag, alternative name and level display and deletes surname and title.";

-- Text for notes in info box.
FlagRSP_Locale_InfoBoxNotes = "Notes:";
-- Text for description in info box.
FlagRSP_Locale_InfoBoxDesc = "Description:";

-- Text for title in description tag warning.
FlagRSP_Locale_DescWarnTitle = "WARNING!";
-- Text for description tag warning.
-- This is important to show the user a warning box when entering a description.
-- Ugly readable, isn't it? 
-- Some explanations: "\n" means new line (same as if you hit enter).
--                    |CFFFF0000...|r means everything inbewtween will be colored red ("..." here).
--                    \" is a "-character.
FlagRSP_Locale_DescWarnText = "You have just called an option to enter a description for your character. |CFFFF0000PLEASE READ THE FOLLOWING INFORMATION CAREFULLY BEFORE ENTERING A DESCRIPTION!|r\n\nThe ONLY purpose of the description tag is to give a description of the outer characteristics of your character. Therefore this description should only contain features that other characters can recognize by sight. This does not include the background story or anything that another character can only know with further knowledge of your character's mind or past.\n\nFor example you can describe the look or mention recurrent movements.\n\nExamples of intended use:\n\n- \"Examplus is quite tall and has a very fat belly.\"\n- \"Examplus has a long scar on his neck that glows in darkness.\"\n- \"Examplus limps with every step he takes.\"\n\nExamples of |CFFFF0000NOT INTENDED|r use:\n\n- \"Examplus has been fat ever since he was a small child.\"\n- \"Examplus has his scar from a fight with a very evil demon.\"\n- \"Examplus has a broken leg.\"\n\nI hope this feature is useful and helps to improve the roleplay in WoW.";

-- Text for title in welcome box.
FlagRSP_Locale_WelcomeTitle = "Welcome!";
-- Text for welcome box.
FlagRSP_Locale_WelcomeHeader = "Welcome to |CFFFFFF7FflagRSP version %flagRSPVersion|r!\n\n";
FlagRSP_Locale_WelcomeText = "Obviously you are using flagRSP the first time (at least on this WoW installation). If you read this message you have apparently been successful in installing flagRSP. I hope you will be able to find all options and features you are looking for. You can access Friendlist and flagRSP options via the button located at your minimap (the one with the scroll). Further options are available via the slash commands /rsp and /fl.\n\n|CFFFF0000NOTICE:|r You should really read the readme file coming with flagRSP (if you haven't already). It is located in your flagRSP directory (<WoW>\\Interface\\AddOns\\flagRSP\\documentation\\flagRSP_readme_EN.txt). It contains some important information. Especially the part |CFFFFFF7FSAFETY|r is absolutely important if you don't want to lose your Friendlist entries or description after a crash for example.\n\n";
FlagRSP_Locale_WelcomeHomepage = "For most up to date information about flagRSP visit the flagRSP homepage located at:\n\nhttp://flokru.org/flagrsp/\n\nI hope you enjoy flagRSP! If you have any problems, wishes, suggestions or criticisms feel free to contact me.\n\n\n|CFFD4D4D4Most important changes in this version (see changelog for details):\n\n";
FlagRSP_Locale_WelcomeChanges = "- Fixed the problem that caused Auctioneer to be unable to load itself upon opening the auction frame.\n- Fixed a bug that caused flagRSP to display descriptions of players for hunters's pets with the same name.\n- Added \"/rsp purge\" to make flagRSP delete all saved flags.\n- Fixed minor bugs concerning the light tooltip mode.";


-- Text for title in new version notification.
FlagRSP_Locale_NewVersionTitle = "New Version!";
-- Text for new version notification.
-- |CFFFFFF7F%r.%m.%n|r is a color code again. %r.%m.%n will be the version number.
FlagRSP_Locale_NewVersionText = "There is a new version of flagRSP available. You might want to update.\n\nAvailable version of flagRSP (at least): |CFFFFFF7F%r.%m.%n|r";
-- Text for checkbutton.
FlagRSP_Locale_NewVersionCheckButton = "Do not show this message again.";

-- Message after enabling ui names.
FlagRSP_Locale_UINamesEnabled = "Name display in user interface enabled.";
-- Message after disabling ui names.
FlagRSP_Locale_UINamesDisabled = "Name display in user interface disabled.";

-- Messages for toggling the always show InfoBox option.
FlagRSP_Locale_AlwaysShowInfoBox = "InfoBox will be automatically reopened after target changing."; 
FlagRSP_Locale_InfoBoxTradBehaviour = "InfoBox will only be reopened if new contents are available or if you activate it manually."; 

-- Message that flagRSP had to (re)join channel.
FlagRSP_Locale_ReJoinedChannel = "Joining data channel (needed for flagRSP's communication).";

-- Message that flagRSP is fully initialized.
FlagRSP_Locale_Initialized = "flagRSP is initialized. Have fun!";

-- Message that tooltip manipulation is (de)activated.
FlagRSP_Locale_ModifyTooltip = "Modifying tooltips.";
FlagRSP_Locale_LightModifyTooltip = "Using light mode to modify tooltips.";
FlagRSP_Locale_NoModifyTooltip = "No longer modifying tooltips.";

-- Message that flagRSP has been (un)set from/to standby.
FlagRSP_Locale_StandBy = "Standby activated. flagRSP has left data channel.";
FlagRSP_Locale_StandBy2 = "|CFFFF0000WARNING:|r Sending and receiving flags will |CFFFF0000NOT|r work!";
FlagRSP_Locale_NoStandBy = "Standby deactivated.";

-- Message for purged entries.
FlagRSP_Locale_EntriesPurged = "Purged |CFFFFFF7F%s|r old cached flags.";

-- Message for changed purge interval.
FlagRSP_Locale_PurgeInterval = "New purge interval for cached flags set to |CFFFFFF7F%s|r days.";

-- Buttons for DYK window.
FlagRSP_Locale_NextTipButton = "Next tip";
FlagRSP_Locale_CloseButton = "Close"; 
FlagRSP_Locale_DYKTitle = "Did you know?";
FlagRSP_Locale_DYKCheckText = "Do not show these tips again.";

FlagRSP_Locale_TipText = {};
FlagRSP_Locale_TipText[1] = "Did you know?\n\nflagRSP is (on non-PVP realms) able to show flags and descriptions of users from the other faction as well. To give flagRSP the possibility to receive these flags you just have to login with a character of the other faction. The longer you are logged in with this character the more flags flagRSP will be able to collect.\nUse \"/rsp collect\" to stop flagRSP from detecting AFK mode. With this option flagRSP will still pull descriptions if you are being AFK (what will however interrupt AFK). Use this command to make flagRSP collect flags and descriptions of the other faction without having to interrupt AFK manually again and again.";
FlagRSP_Locale_TipText[2] = "Did you know?\n\nflagRSP saves flags and descriptions persistently. This even includes flags from the other faction. You can tell flagRSP how long these should be saved using the command \"/rsp purgeinterval x\" with \"x\" as days after which entries should be deleted.";
FlagRSP_Locale_TipText[3] = "Did you know?\n\nTo prevent loss of your description and Friendlist entries you should REGULARY backup flagRSP's settings. Look into flagRSP's readme to find out how to backup this data.";
FlagRSP_Locale_TipText[4] = "Did you know?\n\nflagRSP's minimap button can be moved by using the command \"/fl buttonpos x\" with \"x\" as angle between 0 and 360.";
FlagRSP_Locale_TipText[5] = "Did you know?\n\nYou can move both the InfoBox (the box on the left side of the screen displaying descriptions and other information) and the InfoBox toggle button at the TargetFrame (the frame showing portrait and health/mana bar of you target). Just right click them to move them.";
FlagRSP_Locale_TipText[6] = "Did you know?\n\nYou can simply edit Friendlist entires by double clicking them.";
FlagRSP_Locale_TipText[7] = "Did you know?\n\nflagRSP opens the WoW friends frame for a few seconds after entering the game. This is no bug.\nThe functions returning information about entries of WoW's friends frame only work properly if this list has been opened before. Therefore, flagRSP just opens it for a few moments. If I find a better solution for this problem I'll remove the lines that open it.";
FlagRSP_Locale_TipText[8] = "Did you know?\n\nIf you select another character you can open a context menu by right clicking his/her portrait at the target frame. This menu also contains an option to add the character to your Friendlist respectively to edit his/her entry. With this option you can add/edit entries without opening the Friendlist.";
FlagRSP_Locale_TipText[9] = "Did you know?\n\nYou can import the entries of your WoW friends list to Friendlist and vice versa. Use the commands \"/fl import\" respectively \"fl export\" to do so.";
FlagRSP_Locale_TipText[10] = "Did you know?\n\nflagRSP supports load on demand functionality. Therefore, it contains a small helper addon called flagRSPLoader that automatically loads flagRSP after entering the game. You can configure flagRSPLoader to (de)activate auto loading of flagRSP in general, for current realm and for current character. To access flagRSPLoader's options enter \"/rspload ?\".";
FlagRSP_Locale_TipText[11] = "Did you know?\n\nflagRSP has three different ways to handle tooltips.\n- One does not change them in any way. This mode is useful for players who use other tooltip modifying addons that are not compatible to flagRSP at all (or vice versa).\n- The second mode (light mode) only adds the flags (surname, title, RP flag, character status) to the tooltip but does no further changes like colouring lines or hiding information. This mode should be compatible to all other tooltip modifying addons. Also this mode is significant faster than the third.\nIf you experience problems with other tooltip addons or if you want highest performance (for PvP/raids etc.) try enabling this mode.\n- The third mode is flagRSP's standard mode. It uses a handling routine to modify a bunch of things in the tooltips. It supports all flagRSP tooltip features (flags, coloured lines, hidden names and levels, fancy skinning line, etc.). However, this mode can be problematic if using other tooltip addons. It is not as fast as light mode but tooltip generation time will not be noticable for most users (in numbers: tooltip generation needs about 1-10 ms).\n\nYou can toggle flagRSP's tooltip modes by entering \"/rsp toggletooltip\".";

-- Message for collecting flags.
FlagRSP_Locale_Collecting = "AFK detection deactivated to be able to collect flags and descriptions.";
FlagRSP_Locale_NoCollecting = "AFK detection activated.";

-- Texts for UnitPopupMenu.
FlagRSP_Locale_AddEntry = "Add %UnitName to Friendlist";
FlagRSP_Locale_EditEntry = "Edit %UnitName's entry in Friendlist";
FlagRSP_Locale_ToggleBox = "Toggle InfoBox";

-- Button to add friend/foe.
FRIENDLIST_LOCALE_ADDFRIENDBUTTON = "Add friend";
-- Button to add Guild to Friendlist.
FRIENDLIST_LOCALE_ADDGUILDBUTTON = "Add guild";
-- Button to edit entry in Friendlist.
FRIENDLIST_LOCALE_EDITENTRYBUTTON = "Edit entry";
-- Button to remove friend/foe.
FRIENDLIST_LOCALE_REMOVEFRIENDBUTTON = "Remove friend";
-- Button to edit own title and surname.
FRIENDLIST_LOCALE_EDITTITLEBUTTON = "Title";

-- Button for filtering options in Friendlist.
FRIENDLIST_LOCALE_FilterButton = "Filter";

-- Button for undo in Friendlist's char page.
FRIENDLIST_LOCALE_CharResetButton = "Undo";
-- Button for turning over Friendlist frames.
FRIENDLIST_LOCALE_TurnPageButton = "Turn over";

-- General ok button.
FRIENDLIST_LOCALE_OK_BUTTON = "OK";
-- General abort button.
FRIENDLIST_LOCALE_ABORT_BUTTON = "Abort";
-- General add button.
FRIENDLIST_LOCALE_ADD_BUTTON = "Add";

-- Title of add friend frame.
FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_TITLE = "Add friend";
-- Text before name field in add friend frame.
FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_NAME_FIELD = "Name";
-- Text before surname field in add friend frame.
FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_SURNAME_FIELD = "Surname";
-- Text before title field in add friend frame.
FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_TITLE_FIELD = "Title:";
-- Text before friendstate field in add friend frame.
FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_FRIENDSTATE_FIELD = "Friendstate:";
-- Text before notes field in add friend frame.
FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_NOTES_FIELD = "Notes";
-- Checkbutton for foe option in add friend frame.
FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_FOE_BUTTON = "Foe";
-- Button to add friend/foe in add friend frame.
FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_ADD_BUTTON = FRIENDLIST_LOCALE_ADD_BUTTON;
-- Button to abort in add friend frame.
FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_ABORT_BUTTON = FRIENDLIST_LOCALE_ABORT_BUTTON;

-- Title of add guild frame.
FRIENDLIST_LOCALE_ADD_GUILD_FRAME_TITLE = "Add Guild";
-- Text before name field in add guild frame.
FRIENDLIST_LOCALE_ADD_GUILD_FRAME_NAME_FIELD = FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_NAME_FIELD;
-- Checkbutton for foe option in add guild frame.
FRIENDLIST_LOCALE_ADD_GUILD_FRAME_FOE_BUTTON = FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_FOE_BUTTON;

-- Title of edit entry frame.
FRIENDLIST_LOCALE_EDITENTRY_FRAME_TITLE = "Edit entry";
-- Text before name field in edit entry frame.
FRIENDLIST_LOCALE_EDITENTRY_FRAME_NAME_FIELD = FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_NAME_FIELD;
-- Text before surname field in edit entry frame.
FRIENDLIST_LOCALE_EDITENTRY_FRAME_SURNAME_FIELD = FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_SURNAME_FIELD;
-- Text before notes field in edit entry frame.
FRIENDLIST_LOCALE_EDITENTRY_FRAME_NOTES_FIELD = FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_NOTES_FIELD;
-- Checkbutton for foe option in edit entry frame.
FRIENDLIST_LOCALE_EDITENTRY_FRAME_FOE_BUTTON = FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_FOE_BUTTON;
-- Button to accept friend/foe in edit entry frame.
FRIENDLIST_LOCALE_EDITENTRY_FRAME_OK_BUTTON = FRIENDLIST_LOCALE_OK_BUTTON;
-- Button to abort in edit entry frame.
FRIENDLIST_LOCALE_EDITENTRY_FRAME_ABORT_BUTTON = FRIENDLIST_LOCALE_ABORT_BUTTON;

-- Help.
FRIENDLIST_LOCALE_HELP = {};
FRIENDLIST_LOCALE_HELP[0] = "Friendlist: Help --------------------------------------------------------------";
FRIENDLIST_LOCALE_HELP[1] = "/fl --> Show this help.";
FRIENDLIST_LOCALE_HELP[2] = "/fl help --> Show this help.";
FRIENDLIST_LOCALE_HELP[3] = "/fl show --> Show Friendlist frame.";
FRIENDLIST_LOCALE_HELP[4] = "/fl hide --> Hide Friendlist frame.";
FRIENDLIST_LOCALE_HELP[5] = "/fl mm <an/aus> --> Displays the button at the minimap (an) or not (aus).";
FRIENDLIST_LOCALE_HELP[6] = "/fl buttonpos <ANGLE> --> Sets position of minimap buttons to <ANGLE> with 0<= <ANGLE> <=360.";
FRIENDLIST_LOCALE_HELP[7] = "/fl add <NAME> <SURNAME> --> Add player/object <NAME> with surname <SURNAME> to Friendlist.";
FRIENDLIST_LOCALE_HELP[8] = "/fl addguild <NAME> --> Add guild <NAME> to Friendlist.";
FRIENDLIST_LOCALE_HELP[9] = "/fl del <NAME> --> Delete player/object/guild <NAME> from Friendlist.";
FRIENDLIST_LOCALE_HELP[10] = "/fl reset --> Delete complete Friendlist WITHOUT ANY FURTHER WARNING.";
FRIENDLIST_LOCALE_HELP[11] = "/fl import --> Import WoW's friend list to your Friendlist.";
FRIENDLIST_LOCALE_HELP[12] = "/fl export --> Export your Friendlist to WoW's friend list.";
FRIENDLIST_LOCALE_HELP[13] = "/add <NAME> <SURNAME> <NOTE> --> Adds player <NAME> with <SURNAME> and <NOTE> to Friendlist.";

FRIENDLIST_LOCALE_FRIENDSTATE_TEXT = {};
-- Text for friendstate -10.
FRIENDLIST_LOCALE_FRIENDSTATE_TEXT[-10] = "Foe";
-- Text for friendstate +10.
FRIENDLIST_LOCALE_FRIENDSTATE_TEXT[10] = "Friend";
-- Text for friendstate 0.
FRIENDLIST_LOCALE_FRIENDSTATE_TEXT[0] = "Known";

FRIENDLIST_LOCALE_GUILDFRIENDSTATE_TEXT = {};
-- Text for friendstate -10.
FRIENDLIST_LOCALE_GUILDFRIENDSTATE_TEXT[-10] = "Enemy guild";
-- Text for friendstate +10.
FRIENDLIST_LOCALE_GUILDFRIENDSTATE_TEXT[10] = "Friendly guild";
-- Text for friendstate 0.
FRIENDLIST_LOCALE_GUILDFRIENDSTATE_TEXT[0] = "Known guild";

-- Bindings.
-- Texts for the bindings menu in WoW.
BINDING_HEADER_FRIENDLIST_LOCALE_HEADER = "flagRSP & Friendlist";
BINDING_NAME_FRIENDLIST_LOCALE_NAME = "Open Friendlist frame";
BINDING_NAME_FRIENDLIST_LOCALE_ADDFRIEND = "Add friend";
BINDING_NAME_FRIENDLIST_LOCALE_ADDGUILD = "Add guild";
BINDING_NAME_FRIENDLIST_LOCALE_TOGGLEBOX = "Toggle InfoBox";

-- Strings for the new GUI.
-- Online status for Friendlist.
-- does not need to be translated.
--FRIENDLIST_LOCALE_OnlineStatusLoc = "[%FriendlistOnline, %FriendlistLocation]";
--FRIENDLIST_LOCALE_OnlineStatusNoLoc = "[%FriendlistOnline]";

-- Title for char page.
-- %UnitName is the player's name.
FRIENDLIST_LOCALE_CharFrameTitle = "%UnitName's character page";
-- Title of certificate.
FRIENDLIST_LOCALE_CertTitle = "Proof of Identity";
-- Line 1 of certificate.
FRIENDLIST_LOCALE_CertText1 = "This is to certify that the %UnitRace %UnitClass";
-- Line 2 of certificate.
FRIENDLIST_LOCALE_CertText2 = "%UnitName";
-- Line 3 of certificate.
FRIENDLIST_LOCALE_CertText3 = "is carrying the title";
-- Line 4 of certificate.
FRIENDLIST_LOCALE_CertText4 = "Outward appearance:";
-- Line 5 of certificate.
FRIENDLIST_LOCALE_CertText5 = "Azeroth Bureau of Identification";

-- Line before rp type dropdown box.
FRIENDLIST_LOCALE_RpTypeText = "Preferred roleplaying style:";
-- Line before explanation of rp type.
FRIENDLIST_LOCALE_RpExplanation = "Explanation:";
-- Line before character status dropdown box.
FRIENDLIST_LOCALE_CSText = "Current character status:";

-- Different rp type texts for drop down box.
FRIENDLIST_LOCALE_DropDownRP0 = "No roleplaying flag"; 
FRIENDLIST_LOCALE_DropDownRP1 = "Normal roleplaying style"; 
FRIENDLIST_LOCALE_DropDownRP2 = "Casual roleplaying, partial OOC"; 
FRIENDLIST_LOCALE_DropDownRP3 = "Fulltime roleplaying, no OOC at all"; 
FRIENDLIST_LOCALE_DropDownRP4 = "Roleplaying beginner"; 

-- Different character status texts for drop down box.
FRIENDLIST_LOCALE_DropDownCSNone = "No character status";
FRIENDLIST_LOCALE_DropDownCSOOC = "Playing out of character";
FRIENDLIST_LOCALE_DropDownCSIC = "Playing in character";
FRIENDLIST_LOCALE_DropDownCSFFAIC = "Playing in character, looking for contact";
FRIENDLIST_LOCALE_DropDownCSST = "Playing as a storyteller";

-- Different explanations for rp types.
-- again color codes and others.
FRIENDLIST_LOCALE_DropDownRP0Expl = "Select this if you don't want to send any roleplaying flag at all. Since the meaning of this flag is to show other players what type of roleplaying you prefer you should think carefully before deciding to deactivate it.\nPlease note that the RP flag is not meant to show the quality of anybody's roleplaying. Its only intention is to show other roleplayers how you want to play your role."; 
FRIENDLIST_LOCALE_DropDownRP1Expl = "A |cffE0E0E0normal or average roleplayer|r is someone who mainly plays his role (i.e is in character). However he is sometimes using ooc communication (e.g. for coordination in /p) or at least able to accept some sporadic ooc communication.\nPlease note that this is only your preferred style. You should always be able to adapt yourself when playing with other players with different likings."; 
FRIENDLIST_LOCALE_DropDownRP2Expl = "A |cffE0E0E0casual roleplayer|r wants to play his role, but he needs ooc communication for his gameplay (e.g. for coordination).\nPlease note that this is only your preferred style. You should always be able to adapt yourself when playing with other players with different likings. As ooc communication is a very critical issue for some roleplayers you should be very considerate when using it."; 
FRIENDLIST_LOCALE_DropDownRP3Expl = "A |cffE0E0E0fulltime roleplayer|r wants to play his role all time and never wants to use or hear ooc communication.\nPlease note that this is only your preferred style. You should always be able to adapt yourself when playing with other players with different likings. Also you should keep in mind that some players need ooc communication. Be considerate and calm when someone is using it."; 
FRIENDLIST_LOCALE_DropDownRP4Expl = "Select |cffE0E0E0Roleplaying beginner|r if you are new to roleplaying and afraid of not knowing how to react in certain situations or afraid of making mistakes. Other players can see that you are a \"greenhorn\". They should support you and give you aid. Do not be afraid of asking for help! Normally roleplayers are very kind when they notice someone is being interested."; 

-- Different explanations for character status.
FRIENDLIST_LOCALE_DropDownCSNoneExpl = "Select this if you don't want to send any information regarding your current character status. No other player can determine if you are playing ic or ooc or if you are looking for contacts.";
FRIENDLIST_LOCALE_DropDownCSOOCExpl = "Select |cffE0E0E0out of character|r if you are currently NOT playing your role and don't want any in character contacts at all (e.g. when just farming for quest items or leveling up). This information can be helpful for you and other players as well.";
FRIENDLIST_LOCALE_DropDownCSICExpl = "Select |cffE0E0E0in character|r if you are currently playing your role. Keep in mind that your actions and your speech should be suitable for your character. Other players might contact your character.";
FRIENDLIST_LOCALE_DropDownCSFFAICExpl = "Select |cffE0E0E0in character, looking for contact|r if you are currently playing your role (see |cffE0E0E0in character|r) and looking for other players who want to play together with you. This special \"invite\" mode shows others that you are available and willing to roleplay.";
FRIENDLIST_LOCALE_DropDownCSSTExpl = "A |cffE0E0E0storyteller|r is an advanced player who writes plotlines for other players, either in the game environment, the chat channels, or both. Use this flag if you are currently running a plot or if you are seeking players (PC or NPC) for one.";

-- Drop down elements for Friendlist sorting.
FRIENDLIST_LOCALE_SortDropDown_AlphOnline = "Sort alphabetical (christian name), online first";
FRIENDLIST_LOCALE_SortDropDown_AlphOnlineSurname = "Sort alphabetical (surname), online first";
FRIENDLIST_LOCALE_SortDropDown_FStateOnline = "Sort by friend status, online first";
FRIENDLIST_LOCALE_SortDropDown_TypeOnline = "Sort by type, online first";
FRIENDLIST_LOCALE_SortDropDown_EDateOnline = "Sort by entry date, online first";
FRIENDLIST_LOCALE_SortDropDown_Alph = "Sort alphabetical (christian name)";
FRIENDLIST_LOCALE_SortDropDown_AlphSurname = "Sort alphabetical (surname)";
FRIENDLIST_LOCALE_SortDropDown_FState = "Sort by friend status";
FRIENDLIST_LOCALE_SortDropDown_Type = "Sort by type";
FRIENDLIST_LOCALE_SortDropDown_EDate = "Sort by entry date";

-- Friendlist text for trad. Level display.
FRIENDLIST_LOCALE_LevelLine = "Level ";
-- Friendlist text for online players.
FRIENDLIST_LOCALE_OnlineLine = "online";
-- Friendlist text for offline players.
FRIENDLIST_LOCALE_OfflineLine = "offline";
-- Friendlist text for guilds.
FRIENDLIST_LOCALE_GuildLine = "Guild";

-- old and former unlocalized strings.
-- Entry added to Friendlist.
-- %n is the name of the entry.
FRIENDLIST_LOCALE_AddFriendMsg = "%n added to Friendlist.";
-- Entry deleted from Friendlist.
FRIENDLIST_LOCALE_DelFriendMsg = "%n removed from Friendlist.";
-- Edit entry and select new name that already exists error / Add existing name error.
FRIENDLIST_LOCALE_NameExistsMsg = "Entry %n already exists.";

-- Tab for normal view and group view.
FRIENDLIST_LOCALE_NormalView = "Normal view";
FRIENDLIST_LOCALE_GroupView = "Group view";

-- Tooltip for the minimap button.
FRIENDLIST_LOCALE_MMBUTTON_TOOLTIP = "Open Friendlist and flagRSP interface";
