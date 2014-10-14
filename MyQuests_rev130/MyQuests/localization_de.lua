--[[ ********************************************************************* --]]
--[[ DEUTSCH (GERMAN)                                                      --]]
--[[ LOKALISIERUNG: MOGUL                                                  --]]
--[[ Additions from Xanatandor                                             --]]
--[[  ä = \195\164                                                         --]]
--[[  Ä = \195\132                                                         --]]
--[[  ö = \195\182                                                         --]]
--[[  Ö = \195\150                                                         --]]
--[[  ü = \195\188                                                         --]]
--[[  Ü = \195\156                                                         --]]
--[[  ß = \195\159                                                         --]]

if ( GetLocale() == "deDE" ) then

--[[ ********************************************************************* --]]
--[[ NEW/EDIT QUEST WIZARD                                                 --]]
MQ_QUEST_WIZARD_FRAMETITLE = "MyQuests Quest-Assistent";

MQ_QUEST_WIZARD_FILTERHEADER = "Erlaube Filter";
MQ_QUEST_WIZARD_FILTERINFO = "Schr\195\164nkt Quest auf die folgenden Bedingungen ein.";

MQ_QUEST_WIZARD_OBJECTIVEINFO = "Erzeuge bis zu 5 Questziele.";
MQ_QUEST_WIZARD_REWARDINFO = "Erzeuge bis zu 5 Questbelohnungen.";

MQ_QUEST_WIZARD_CLASSFILTER = "Filter Klassen";
MQ_QUEST_WIZARD_GUILDFILTER = "Filter Gilden";
MQ_QUEST_WIZARD_LEVELFILTER = "Filter Stufen";
MQ_QUEST_WIZARD_PLAYERFILTER = "Filter Spieler";
MQ_QUEST_WIZARD_RACEFILTER = "Filter Rasse";

MQ_QUEST_WIZARD_SAVE = "Speichern";
MQ_QUEST_WIZARD_CANCEL = "Abbrechen";

MQ_QUEST_WIZARD_ITEM1_TIP = "Ziehen Sie einen Gegenstand hierher, um ein Quest-Ziel festzulegen";
MQ_QUEST_WIZARD_ITEM2_TIP = "Ziehen Sie einen Gegenstand hierher, um eine Quest-Belohnung festzulegen";
MQ_QUEST_WIZARD_ITEMNOTRADE_TIP = "Gegenstand wird nicht gehandelt.";

MQ_QUEST_WIZARD_OBJECTIVE_NAME = "Name:";
MQ_QUEST_WIZARD_OBJECTIVE_COUNT = "Anzahl:";
MQ_QUEST_WIZARD_LEVEL = "Stufe:";

MYQUESTS_WIZARD_OBJECTIVE_NONE = "Keins";
MYQUESTS_WIZARD_OBJECTIVE_EMOTE = "Emote";
MYQUESTS_WIZARD_OBJECTIVE_EXPLORE = "Erkunden";
MYQUESTS_WIZARD_OBJECTIVE_DUEL_ANY = "Duell";
MYQUESTS_WIZARD_OBJECTIVE_DUEL_CLASS = "Duell Klasse";
MYQUESTS_WIZARD_OBJECTIVE_DUEL_GUILD = "Duell Gilde";
MYQUESTS_WIZARD_OBJECTIVE_DUEL_PLAYER = "Duell Spieler";
MYQUESTS_WIZARD_OBJECTIVE_DUEL_RACE = "Duell Rasse";
MYQUESTS_WIZARD_OBJECTIVE_GATHER_ITEM = "Gegenstand einsammeln";
MYQUESTS_WIZARD_OBJECTIVE_KILL_MONSTER = "Monster t\195\182ten";
MYQUESTS_WIZARD_OBJECTIVE_MONEY = "Geld";
MYQUESTS_WIZARD_OBJECTIVE_PVP_ANY = "PvP";
MYQUESTS_WIZARD_OBJECTIVE_PVP_CLASS = "PvP Klasse";
MYQUESTS_WIZARD_OBJECTIVE_PVP_GUILD = "PvP Gilde";
MYQUESTS_WIZARD_OBJECTIVE_PVP_SPECIFIC = "PvP Spieler";
MYQUESTS_WIZARD_OBJECTIVE_PVP_RACE = "PvP Rasse";
MYQUESTS_WIZARD_OBJECTIVE_TAME = "Monster z\195\164hmen";

MQ_QUEST_WIZARD_REWARD_NONE = "Keine";
MQ_QUEST_WIZARD_REWARD_PROMOTION = "Gildenbef\195\182rderung";
MQ_QUEST_WIZARD_REWARD_INVITATION = "Gildeneinladung";
MQ_QUEST_WIZARD_REWARD_ITEM = "Gegenstand";
MQ_QUEST_WIZARD_REWARD_MONEY = "Geld";

MQ_QUEST_WIZARD_ITEMNOTRADE = "Nicht handeln";
MQ_QUEST_WIZARD_ITEMNODISPLAY = "Nicht anzeigen";

MQ_QUEST_WIZARD_FACTION_ALLIANCE = "Allianz";
MQ_QUEST_WIZARD_FACTION_HORDE = "Horde";


--[[ ********************************************************************* --]]
--[[ REGULAR EXPRESSIONS                                                   --]]
MQ_REGEX_DUEL = "(.+) hat (.+) in einem Duell besiegt";
MQ_REGEX_EXPERIENCE_GAIN = "(.+) stirbt, Ihr bekommt (.+) Erfahrung";
MQ_REGEX_HONOR_GAIN = "(.+) stirbt, ehrenhafter Sieg";
MQ_REGEX_HOSTILE_DEATH = "(.+) stirbt";
MQ_REGEX_HOSTILE_SLAIN = "(.+) wurde von (.+) get\195\182tet!";
MQ_REGEX_TAME_STEP1 = "Ihr wirkt Wildtier z\195\164hmen auf (.+).";
MQ_REGEX_TAME_STEP2 = "Wildtier z\195\164hmen schwindet von Euch.";
MQ_REGEX_TAME_STEP3 = "Die Treue eures Begleiters hat zugenommen.";


--[[ ********************************************************************* --]]
--[[ LEADER BOARD                                                          --]]
--[[   %n is replaced by the string in the "Name" field.                   --]]
--[[     Example: "Travel to %n" --> "Travel to Ironforge"                 --]]
--[[   %f is replaced by the opposite faction name.                        --]]
MQ_LEADERBOARD_AREA = "Reise nach %n";
MQ_LEADERBOARD_DUEL_ANY = "Besiege jemanden in einem Duell: %i/%c";
MQ_LEADERBOARD_DUEL_SPECIFIC = "Besiege %n in einem Duell: %i/%c";
MQ_LEADERBOARD_DUEL_CLASS = "Besiege einen %n in einem Duell: %i/%c";
MQ_LEADERBOARD_DUEL_GUILD = "Besiege ein Mitglied von %n in einem Duell: %i/%c";
MQ_LEADERBOARD_DUEL_RACE = "Besiege einen %n in einem Duell: %i/%c";
MQ_LEADERBOARD_MONSTER = "%n get\195\182tet: %i/%c";
MQ_LEADERBOARD_PVP_ANY = "Errungene Siege gegen die %f: %i/%c";
MQ_LEADERBOARD_PVP_SPECIFIC = "T\195\182te %n: %i/%c";
MQ_LEADERBOARD_PVP_GUILD = "T\195\182te ein Mitglied von %n: %i/%c";
MQ_LEADERBOARD_PVP_CLASS = "T\195\182te einen %n: %i/%c";
MQ_LEADERBOARD_PVP_RACE = "T\195\182te einen %n: %i/%c";
MQ_LEADERBOARD_GATHER_ITEM = "%n: %i/%c";
MQ_LEADERBOARD_TAME = "Tier z\195\164hmen: %n";

--[[ ********************************************************************* --]]
--[[ QUEST UPDATE MESSAGES                                                 --]]
--[[   %n is replaced by the string in the "Name" field.                   --]]
--[[     Example: "Travel to %n" --> "Travel to Ironforge"                 --]]
--[[   %f is replaced by the opposite faction name.                        --]]
--[[   %t is replaced by the quest title.                                  --]]
--[[   %i is replaced by the objective runcount.                           --]]
--[[   %c is replaced by the objective count.                              --]]
MQ_MSG_QUESTUPDATE_COMPLETED = "Der Quest %t wurde abgeschlossen";
MQ_MSG_QUESTUPDATE_AREA = "%n wurde gefunden";
MQ_MSG_QUESTUPDATE_DUEL_ANY = "Besiegter Gegner: %i/%c";
MQ_MSG_QUESTUPDATE_DUEL_SPECIFIC = "%n besiegt: %i/%c";
MQ_MSG_QUESTUPDATE_DUEL_CLASS = "%n besiegt: %i/%c";
MQ_MSG_QUESTUPDATE_DUEL_GUILD = "%n besiegt: %i/%c";
MQ_MSG_QUESTUPDATE_MONSTER = "%n get\195\182tet: %i/%c";
MQ_MSG_QUESTUPDATE_PVP_ANY = "%f get\195\182tet: %i/%c";
MQ_MSG_QUESTUPDATE_PVP_SPECIFIC = "%n(%f) get\195\182tet: %i/%c";
MQ_MSG_QUESTUPDATE_PVP_GUILD = "%n(%f) get\195\182tet: %i/%c";
MQ_MSG_QUESTUPDATE_PVP_CLASS = "%n(%f) get\195\182tet: %i/%c";
MQ_MSG_QUESTUPDATE_GATHER_ITEM = "%n (%i/%c)";

MQ_QUESTFRAME_TRANSCRIBING = "Quest Information \195\188bermitteln.";
MQ_QUESTFRAME_NOQUESTS = "Dieser Spieler hat keine Quests f\195\188r dich verf\195\188gbar.";

--[[ ********************************************************************* --]]
--[[ ADDITIONS BY Xanatandor: Adminstrings                                 --]]

MQ_ADMIN_TITLE = "MyQuests Admin";

MQ_ADMIN_TARGETBUTTON = "Kennzeichen Platzierung";
MQ_ADMIN_TARGETBUTTON_TIP = "Zielkennzeichen Platzierung";

MQ_ADMIN_INTERACTION = "Interaktion";
MQ_ADMIN_WELCOMETEXT = "Quest Log Willkommen";
MQ_ADMIN_MOD_ENABLE = "Aktiviere MyQuests";
MQ_ADMIN_ACCEPT_ENABLE = "Erlaube Quest Annahme";
MQ_ADMIN_TURNIN_ENABLE = "Erlaube Quest Abgabe";

MQ_ZONE_WARSONGGULCH = "Warsongschlucht";
MQ_ZONE_ALTERACVALLEY = "Alteractal";


MYQUESTS_WIZARD_LABEL_QUESTTITLE = "Quest Titel";
MYQUESTS_WIZARD_LABEL_QUESTLEVEL = "Quest Level";
MYQUESTS_WIZARD_LABEL_PLAYERDEATH = "Tod des Spielers";
MYQUESTS_WIZARD_LABEL_TIMELIMIT = "Zeitlimit:"
MYQUESTS_WIZARD_LABEL_MINUTES = "Minuten";
MYQUESTS_WIZARD_LABEL_REPEATABLE = "Quest ist wiederholbar";
MYQUESTS_WIZARD_LABEL_LOCALSTORE = "Speichere lokale Historie";

MYQUESTS_WIZARD_HEADER_SUMMARY = "Zusammenfassung";
MYQUESTS_WIZARD_HEADER_PROGRESS = "Fortschritt";

MYQUESTS_WIZARD_HEADER_SUMMARYINFO = "Kurze Zusammenfassung der Questziele, wird beim akzeptieren der Quest im Questlog angezeigt";
MYQUESTS_WIZARD_HEADER_PROGRESSINFO = "Wird beim Ansprechen der Spielers angezeigt, bevor alle Questziele erf\195\188llt sind";
MYQUESTS_WIZARD_HEADER_COMPLETEINFO = "Gl\195\188ckwunschtextseite, die angezeigt wird, wenn Quest erf\195\188llt ist und abgegeben wird.";
MYQUESTS_WIZARD_HEADER_DESCINFO = "Geschichte hinter einer fortlaufenden Questserie, angezeigt beim akzeptieren und im Questlog.";

end;
