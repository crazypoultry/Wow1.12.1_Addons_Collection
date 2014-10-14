if( GetLocale() == "deDE" ) then

OPIUM_TEXT_LASTSEEN = "Gesehen";
OPIUM_TEXT_NAME = "Name";
OPIUM_TEXT_LEVEL = "Level";
OPIUM_TEXT_CLASS = "Klasse";
OPIUM_TEXT_GUILD = "Gilde";
OPIUM_TEXT_FACTION = "Fraktion";
OPIUM_TEXT_KILLS = "Kills";
OPIUM_TEXT_DEATHS = "Tode";

OPIUM_TEXT_ALL = "Alle";
OPIUM_TEXT_PLAYERSEARCH = "Spieler Suche";
OPIUM_TEXT_PLAYERPURGE = "Spieler L\195\182schen";
OPIUM_TEXT_MATCHES = "Spieler";
OPIUM_TEXT_OF = "von";
OPIUM_TEXT_LEVEL = "Level";

OPIUM_TEXT_KOSPLAYER = "KoS Spieler";
OPIUM_TEXT_KOSGUILD = "KoS Gilde";
OPIUM_TEXT_KILLSDEATHS = "Kills/Tode";
OPIUM_TEXT_LASTSEEN = "Gesehen";
OPIUM_TEXT_AGO = "";
OPIUM_TEXT_SEEN = "";

OPIUM_TEXT_WELCOMEMSG = "geladen. '/pwho' f\195\188r Hauptfenster, '/op'  f\195\188r Konsole.";

-- Text in the main window
OPIUM_TEXT_RESET = "Reset";
OPIUM_TEXT_SEARCH = "Suche";
OPIUM_TEXT_PURGE = "L\195\182schen";
OPIUM_TEXT_KOSPLAYERS = "KoS Spieler";
OPIUM_TEXT_KOSGUILDS = "KoS Gilden";
OPIUM_TEXT_OPTIONS = "Optionen";
OPIUM_TEXT_PVPSTATS = "PvP Stats";

-- PvP stats strings
OPIUM_TEXT_STATS_TITLE = "PvP Stats";

OPIUM_TEXT_STATS_TODAY = "Heute";
OPIUM_TEXT_STATS_TOTAL = "Total";
OPIUM_TEXT_STATS_TOTALKILLS = "Total Kills";
OPIUM_TEXT_STATS_UNIQUEKILLS = "Einzigartige Kills";
OPIUM_TEXT_STATS_AVERAGELEVEL = "Durchschnittslevel";
OPIUM_TEXT_STATS_TOTALDEATHS = "Total Tode";
OPIUM_TEXT_STATS_UNIQUEKILLERS = "Einzigartig Get\195\182tet";
OPIUM_TEXT_STATS_TOP10KILLEDPLAYERS = "Top 10 get\195\182tete Spieler";
OPIUM_TEXT_STATS_TOP10KILLEDGUILDS = "Top 10 get\195\182tete Gilden";
OPIUM_TEXT_STATS_KILLEDBYPLAYERS = "Top 10 get\195\182tet von Spielern";
OPIUM_TEXT_STATS_KILLEDBYGUILDS = "Top 10 get\195\182tet von Gilden";
OPIUM_TEXT_STATS_TOPKILLEDBYCLASSES = "Top ge\195\182tet von Klassen";
OPIUM_TEXT_STATS_TOPKILLEDBYRACES = "Top get\195\182tet von Rassen";

OPIUM_TEXT_STATS_LOGGINGDEATH = "Logge Tode nach";
OPIUM_TEXT_STATS_LOGGINGKILL = "Logge Kills von";

OPIUM_RANKTITLE[1][1] = "";
OPIUM_RANKTITLE[1][2] = "";
OPIUM_RANKTITLE[1][3] = "";
OPIUM_RANKTITLE[1][4] = "";
OPIUM_RANKTITLE[1][5] = "Gefreiter";
OPIUM_RANKTITLE[1][6] = "Fu\195\159knecht";
OPIUM_RANKTITLE[1][7] = "Landsknecht";
OPIUM_RANKTITLE[1][8] = "Feldwebel";
OPIUM_RANKTITLE[1][9] = "F\195\164hnrich";
OPIUM_RANKTITLE[1][10] = "Leutnant";
OPIUM_RANKTITLE[1][11] = "Hauptmann";
OPIUM_RANKTITLE[1][12] = "K\195\188rassier";
OPIUM_RANKTITLE[1][13] = "Ritter der Allianz";
OPIUM_RANKTITLE[1][14] = "Feldkommandant";
OPIUM_RANKTITLE[1][15] = "Rittmeister";
OPIUM_RANKTITLE[1][16] = "Marschall";
OPIUM_RANKTITLE[1][17] = "Feldmarschall";
OPIUM_RANKTITLE[1][18] = "Gro\195\159marschall";
OPIUM_RANKTITLE[1][19] = "";
OPIUM_RANKTITLE[1][20] = "";

OPIUM_RANKTITLE[2] = { };
OPIUM_RANKTITLE[2][0] = "";
OPIUM_RANKTITLE[2][1] = "";
OPIUM_RANKTITLE[2][2] = "";
OPIUM_RANKTITLE[2][3] = "";
OPIUM_RANKTITLE[2][4] = "";
OPIUM_RANKTITLE[2][5] = "Sp\195\164her";
OPIUM_RANKTITLE[2][6] = "Grunzer";
OPIUM_RANKTITLE[2][7] = "Waffentr\195\164ger";
OPIUM_RANKTITLE[2][8] = "Schlachtrufer";
OPIUM_RANKTITLE[2][9] = "Rottenmeister";
OPIUM_RANKTITLE[2][10] = "Steingardist";
OPIUM_RANKTITLE[2][11] = "Blutgardist";
OPIUM_RANKTITLE[2][12] = "Zornbringer";
OPIUM_RANKTITLE[2][13] = "Klinge der Horde";
OPIUM_RANKTITLE[2][14] = "Feldherr";
OPIUM_RANKTITLE[2][15] = "Sturmreiter";
OPIUM_RANKTITLE[2][16] = "Kriegsherr";
OPIUM_RANKTITLE[2][17] = "Kriegsf\195\188rst";
OPIUM_RANKTITLE[2][18] = "Oberster Kriegsf\195\188rst";
OPIUM_RANKTITLE[2][18] = "";
OPIUM_RANKTITLE[2][19] = ""; 


   opiumDeathString = " stirbt.";
   opiumDuelString = "(.+) hat (.+) in einem Duell besiegt.";

   -- Damage strings borrowed from PvPLog (German version)
   opiumYourDamageMatch = {
	-- Your damage or healing
	{ pattern = "(.+) von Euch trifft (.+) fuer (%d+) Schaden.", spell = 0, mob = 1, pts = 2 },
	{ pattern = "Eu. (.+) trifft (.+) kritisch. Schaden: (%d+).", spell = 0, mob = 1, pts = 2 },
	{ pattern = "You drain (%d+) (.+) from (.+)", mob = 2, pts = 0, stat = 1 },
	{ pattern = "Your (.+) causes (.+) (%d+) damage", spell = 0, mob = 1, pts = 2 },
	{ pattern = "Ihr reflektiert (%d+) (.+) auf (.+)", mob = 2, pts = 0, type = 1 },
	{ pattern = "(.+) erleidet (%d+) (.+)schaden %(durch (.*)%).", spell = 3, mob = 0,
                                                                 pts = 1, type = 2 },
	{ pattern = "Ihr trefft (.+). Schaden: (%d+).", mob = 0, pts = 1 },
	{ pattern = "Ihr trefft (.+) kritisch fr (%d+) Schaden.", mob = 0, pts = 1 }
   };

   opiumDamageToYouMatch = {
	{ pattern = "(.+) trifft Euch %(mit (.+)%). Schaden: (%d+).", spell = 1, pts = 2, cause = 0 },
	{ pattern = "(.+) trifft Euch kritisch %(mit (.+)%). Schaden: (%d+).", spell = 1, pts = 2, cause = 0 },
	{ pattern = "(.+) drains (%d+) (.+) from you", pts = 1, stat = 2, cause = 0 },
	{ pattern = "(.+)'s (.+) causes you (%d+) damage", spell = 1, pts = 2, cause = 0 },
	{ pattern = "(.+) reflektiert (%d+) (.+) auf euch.", pts = 1, type = 2, cause = 0 },
	{ pattern = "You suffer (%d+) (.+) damage from (.+)'s (.+)", spell = 3, pts = 0,
                                                                 type = 1, cause = 2 },
	{ pattern = "(.+) trifft Euch fr (%d+) Schaden.", pts = 1, cause = 0 },
	{ pattern = "(.+) trifft Euch kritisch. Schaden: (%d+).", pts = 1, cause = 0 }
   };


   OPIUM_RACEINDEX = { };
   OPIUM_CLASSINDEX = { };
   OPIUM_FACTIONINDEX = { };

   OPIUM_RACEINDEX["Zwerg"]     = 1;
   OPIUM_RACEINDEX["Gnom"]     = 2;
   OPIUM_RACEINDEX["Mensch"]     = 3;
   OPIUM_RACEINDEX["Nachtelf"] = 4;
   OPIUM_RACEINDEX["Orc"]       = 5;
   OPIUM_RACEINDEX["Tauren"]    = 6;
   OPIUM_RACEINDEX["Troll"]     = 7;
   OPIUM_RACEINDEX["Untoter"]    = 8;

   OPIUM_RACEINDEX[1] = "Zwerg";
   OPIUM_RACEINDEX[2] = "Gnom";
   OPIUM_RACEINDEX[3] = "Mensch";
   OPIUM_RACEINDEX[4] = "Nachtelf";
   OPIUM_RACEINDEX[5] = "Orc";
   OPIUM_RACEINDEX[6] = "Tauren";
   OPIUM_RACEINDEX[7] = "Troll";
   OPIUM_RACEINDEX[8] = "Untoter";

   OPIUM_CLASSINDEX["Druide"]   = 1;
   OPIUM_CLASSINDEX["J\195\164ger"]  = 2;
   OPIUM_CLASSINDEX["Magier"]    = 3;
   OPIUM_CLASSINDEX["Paladin"] = 4;
   OPIUM_CLASSINDEX["Priester"]  = 5;
   OPIUM_CLASSINDEX["Schurke"]   = 6;
   OPIUM_CLASSINDEX["Schamane"]  = 7;
   OPIUM_CLASSINDEX["Hexenmeister"] = 8;
   OPIUM_CLASSINDEX["Krieger"] = 9;

   OPIUM_CLASSINDEX[1] = "Druide";
   OPIUM_CLASSINDEX[2] = "J\195\164ger";
   OPIUM_CLASSINDEX[3] = "Magier";
   OPIUM_CLASSINDEX[4] = "Paladin";
   OPIUM_CLASSINDEX[5] = "Priester";
   OPIUM_CLASSINDEX[6] = "Schurke";
   OPIUM_CLASSINDEX[7] = "Schamane";
   OPIUM_CLASSINDEX[8] = "Hexenmeister";
   OPIUM_CLASSINDEX[9] = "Krieger";

  -- Not needed after all.
  -- OPIUM_FACTIONINDEX["Allianz"] = 1;
  -- OPIUM_FACTIONINDEX["Horde"] = 2;

  -- OPIUM_FACTIONINDEX[1] = "Allianz";
  -- OPIUM_FACTIONINDEX[2] = "Horde";


end
