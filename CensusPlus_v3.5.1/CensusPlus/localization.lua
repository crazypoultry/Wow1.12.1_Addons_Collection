--[[
	CensusPlus for World of Warcraft(tm).
	
	Copyright 2005 - 2006 Cooper Sellers and WarcraftRealms.com

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GLP.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
]]


CENSUSPlus_BUTTON_TEXT      = "Census+";
CENSUSPlus_BUTTON_SUBTEXT   = "Realm Census";
CENSUSPlus_BUTTON_TIP       = "Click here to show or hide Census+.";
CENSUSPlus_HELP             = " Use /censusplus to open and close the Census+ UI.";

CENSUSPlus_MSG1             = " Loaded - type /censusplus or /census+ to open main window";
CENSUSPlus_MSG2             = "Use /censusdate to set today's date in the format of MM-DD-YYYY, ie. 12-25-2004";

CENSUSPlus_UPLOAD           = "Be sure to upload your CensusPlus data to www.WarcraftRealms.com!";
CENSUSPlus_SETTINGDATE      = "Setting date to => ";
CENSUSPlus_PAUSE            = "Pause";
CENSUSPlus_UNPAUSE          = "Un-Pause";
CENSUSPlus_STOP             = "Stop";
CENSUSPlus_PRUNE			= "Prune";

CENSUSPlus_TAKECENSUS       = "Take a census of players \ncurrently online on this server \nand in this faction";
CENSUSPlus_PURGEDATABASE    = "Purge the database for this server and faction";
CENSUSPlus_PAUSECENSUS      = "Pause the current census";
CENSUSPlus_UNPAUSECENSUS    = "Un-Pause the current census";
CENSUSPlus_STOPCENSUS       = "Stop the currently active CensusPlus";
CENSUSPlus_PRUNECENSUS		= "Prune the database by removing characters not seen in 30 days.";

CENSUSPlus_PURGEMSG         = "Purged character database.";
CENSUSPlus_ISINPROGRESS     = "A CensusPlus is in progress, try again later";
CENSUSPlus_TAKINGONLINE     = "Taking census of characters online...";
CENSUSPlus_PLZUPDATEDATE    = "Please use /censusdate to set today's date for more more accurate data.  Format /censusdate MM-DD-YYYY, example, /censusdate 12-25-2004";
CENSUSPlus_NOCENSUS         = "A Census is not currently in progress";
CENSUSPlus_FINISHED         = "Finished Taking data. Found %s new characters and saw %s. Took %s.";
CENSUSPlus_TOOMANY          = "WARNING: Too many characters matching: %s";
CENSUSPlus_WAITING          = "Waiting to send who request...";
CENSUSPlus_SENDING          = "Sending /who %s";
CENSUSPlus_PROCESSING       = "Processing %s characters.";

CENSUSPlus_REALMNAME        = "Realm: %s";
CENSUSPlus_REALMUNKNOWN     = "Realm: Unknown";
CENSUSPlus_FACTION          = "Faction: %s";
CENSUSPlus_FACTIONUNKNOWN   = "Faction: Unknown";
CENSUSPlus_LOCALE           = "Locale : %s";
CENSUSPlus_LOCALEUNKNOWN    = "Locale : Unknown";
CENSUSPlus_TOTALCHAR        = "Total Characters: %d";
CENSUSPlus_TOTALCHAR_0      = "Total Characters: 0";
CENSUSPlus_TOTALCHARXP      = "Total Character XP: %d";
CENSUSPlus_TOTALCHARXP_0    = "Total Character XP: 0";
CENSUSPlus_AUTOCLOSEWHO     = "Automatically Close Who";
CENSUSPlus_SHOWMINI         = "Show Mini On Start";
CENSUSPlus_UNGUILDED        = "(Unguilded)";
CENSUSPlus_TAKE             = "Take";
CENSUSPlus_TOPGUILD         = "Top Guilds By XP";
CENSUSPlus_RACE             = "Races";
CENSUSPlus_CLASS            = "Classes";
CENSUSPlus_LEVEL            = "Levels";
CENSUSPlus_PURGE            = "Purge";
CENSUSPlus_MAXXED			= "MAXXED!";

CENSUSPlus_MAXIMIZE         = "Maximize the CensusPlus Window";
CENSUSPlus_MINIMIZE         = "Minimize the CensusPlus Window";
CENSUSPlus_BUTTON_MINIMIZE  = "Minimize";

CENSUSPlus_DRUID            = "Druid";
CENSUSPlus_HUNTER           = "Hunter";
CENSUSPlus_MAGE             = "Mage";
CENSUSPlus_PRIEST           = "Priest";
CENSUSPlus_ROGUE            = "Rogue";
CENSUSPlus_WARLOCK          = "Warlock";
CENSUSPlus_WARRIOR          = "Warrior";
CENSUSPlus_SHAMAN           = "Shaman";
CENSUSPlus_PALADIN          = "Paladin";

CENSUSPlus_DWARF            = "Dwarf";
CENSUSPlus_GNOME            = "Gnome";
CENSUSPlus_HUMAN            = "Human";
CENSUSPlus_NIGHTELF         = "Night Elf";
CENSUSPlus_ORC              = "Orc";
CENSUSPlus_TAUREN           = "Tauren";
CENSUSPlus_TROLL            = "Troll";
CENSUSPlus_UNDEAD           = "Undead";

CENSUSPlus_WarsongGulch     = "Warsong Gulch";  
CENSUSPlus_AlteracValley    = "Alterac Valley";
CENSUSPlus_ArathiBasin		= "Arathi Basin";


CENSUSPLUS_US_LOCALE		= "Select if you play on US Servers";
CENSUSPLUS_EU_LOCALE		= "Select if you play on EURO Servers";
CENSUSPLUS_LOCALE_SELECT	= "Select if you play on US or EURO servers";

CENSUSPlus_BUTTON_OPTIONS	= "Options";
CENSUSPlus_OPTIONS_HEADER	= "Census+ Options";
CENSUSPlus_ISINBG			= "You are currently in a Battleground so a Census cannot be taken";
CENSUS_OPTIONS_BUTPOS		= "Button Position";
CENSUS_OPTIONS_BUTSHOW      = "Show Minimap Button";
CENSUS_OPTIONS_AUTOCENSUS   = "Auto-Census";
CENSUS_OPTIONS_THISPROFILE  = "Collect Profile for this Char";
CENSUS_OPTIONS_AUTOSTART    = "Auto-Start";
CENSUS_OPTIONS_VERBOSE      = "Verbose";
CENSUS_OPTIONS_SOUND_ON_COMPLETE = "Play Sound When Done";

CENSUSPlus_AUTOSTART_TOOLTIP = "Enable Census+ to start automatically";
CENSUSPlus_VERBOSE_TOOLTIP  = "Deselect to stop the spam!";
CENSUSPlus_AUTOCENSUS_TOOLTIP = "Enable Census+ to run automatically while playing";
CENSUSPlus_THISPROFILE_TOOLTIP = "Collect profile data for this character to upload to WarcraftRealms.com";

CENSUSPlus_BUTTON_CHARACTERS = "Show Chars";
CENSUSPlus_Characters		= "Characters";

CENSUS_BUTTON_TOOLTIP		= "Open CensusPlus";

CENSUS_LEVEL_NO_GUILD = "(.+): Level (%d+) (.+) (.+) - (.+)";
CENSUS_LEVEL_W_GUILD  = "(.+): Level (%d+) (.+) (.+) <(.+)> - (.+)";
CENSUS_MULT_PLAYERS   = "(%d+) players total";
CENSUS_SING_PLAYER    = "(%d+) player total";

CENSUSPlus_CANCEL			= "Cancel";

CENSUSPlus_OVERRIDE			 = "Census in progress, submitting override";
CENSUSPlus_OVERRIDE_COMPLETE = "Override complete resuming census";
CENSUSPlus_OVERRIDE_COMPLETE_BUT_PAUSED = "Override complete, but census has been paused";

CENSUSPlus_PURGE_LOCAL_CONFIRM = "Are you sure you wish to PURGE your local database?";
CENSUSPlus_OVERRIDE_COMPLET_PAUSED = "Override complete but Census has been paused, Click to Continue";

CENSUSPlus_YES			= "Yes";
CENSUSPlus_NO			= "No";
CENSUSPlus_CONTINUE		= "Continue";

if ( GetLocale() == "frFR" ) then
    -- Traduit par Juki <Unskilled>
    
    CENSUSPlus_BUTTON_TEXT      = "Census+";
    CENSUSPlus_BUTTON_SUBTEXT   = "Stats serveur";
    CENSUSPlus_BUTTON_TIP       = "Cliquez ici pour montrer ou masquer Census+.";
    CENSUSPlus_HELP             = " Utilisez /censusplus pour ouvrir et fermer Census+.";
    
    CENSUSPlus_MSG1             = " Chargée - Tapez /censusplus ou /census+ pour ouvrir la fenêtre principale";
    CENSUSPlus_MSG2             = "Utilisez /censusdate pour configurer la date du jour dans le format MM-DD-YYYY, ie.12-25-2004";

    CENSUSPlus_UPLOAD           = "";
    CENSUSPlus_UPLOAD2          = "";
    CENSUSPlus_SETTINGDATE      = "Mise à jour de la date => ";
    CENSUSPlus_PAUSE            = "Pause";
    CENSUSPlus_UNPAUSE          = "Reprendre";
    CENSUSPlus_STOP             = "Stop";
    
    CENSUSPlus_TAKECENSUS       = "Faire un recensement des joueurs \nactuellement en ligne sur ce serveur \net dans cette faction";
    CENSUSPlus_PURGEDATABASE    = "Supprime la base de donnée concernant \nle serveur et la faction en cours.";
    CENSUSPlus_PAUSECENSUS      = "Mettre en pause le recensement en cours";
    CENSUSPlus_STOPCENSUS       = "Arrêter le recensement en cours"
    
    CENSUSPlus_PURGEMSG         = "Base de donnée supprimée.";
    CENSUSPlus_ISINPROGRESS     = "Un recensement est en cours, veuillez patienter";
    CENSUSPlus_TAKINGONLINE     = "Recensement des joueurs en cours ...";
    CENSUSPlus_PLZUPDATEDATE    = "SVP utilisez /censusdate pour configurer la date du jour pour des données plus précises. Format /censusdate MM-DD-YYYY, exemple, /censusdate 12-25-2004";
    CENSUSPlus_NOCENSUS         = "Aucun recensement en cours";
    CENSUSPlus_FINISHED         = "Recensement terminé. %s nouveaux personnages et %s mis à jour.";
    CENSUSPlus_TOOMANY          = "ERREUR: Trop de joueurs correspondants à : %s";
    CENSUSPlus_WAITING          = "En attente de lancement de requête /who ...";
    CENSUSPlus_SENDING          = "Envoi de requête /who %s";
    CENSUSPlus_PROCESSING       = "Analyse de %s personnages.";
    
    CENSUSPlus_REALMNAME        = "Serveur : %s";
    CENSUSPlus_REALMUNKNOWN     = "Serveur : Inconnu";
    CENSUSPlus_FACTION          = "Faction : %s";
    CENSUSPlus_FACTIONUNKNOWN   = "Faction : Inconnu";
    CENSUSPlus_TOTALCHAR        = "Nombre de personnages : %d";
    CENSUSPlus_TOTALCHAR_0      = "Nombre de personnages : 0";
    CENSUSPlus_TOTALCHARXP      = "Nombre d'xp total : %d";
    CENSUSPlus_TOTALCHARXP_0    = "Nombre d'xp total : 0";
    CENSUSPlus_AUTOCLOSEWHO     = "Fermeture auto du /Who";
    CENSUSPlus_SHOWMINI         = "Montrer Mini au démarrage";
    CENSUSPlus_UNGUILDED        = "(Sans Guilde)";
    CENSUSPlus_TAKE             = "Recenser";
    CENSUSPlus_TOPGUILD         = "Meilleures guildes par XP";
    CENSUSPlus_RACE             = "Races";
    CENSUSPlus_CLASS            = "Classes";
    CENSUSPlus_LEVEL            = "Niveaux";
    CENSUSPlus_PURGE            = "Mettre à Zero"; 
    
    CENSUSPlus_MAXIMIZE         = "Agrandir la fenêtre CensusPlus";
    CENSUSPlus_MINIMIZE         = "Réduire la fenêtre CensusPlus";
    CENSUSPlus_BUTTON_MINIMIZE  = "Réduire";
        
    CENSUSPlus_HORDE            = "Horde";
    CENSUSPlus_ALLIANCE         = "Alliance";

    CENSUSPlus_DRUID            = "Druide";
    CENSUSPlus_HUNTER           = "Chasseur";
    CENSUSPlus_MAGE             = "Mage";
    CENSUSPlus_PRIEST           = "Prêtre";
    CENSUSPlus_ROGUE            = "Voleur";
    CENSUSPlus_WARLOCK          = "Démoniste";
    CENSUSPlus_WARRIOR          = "Guerrier";
    CENSUSPlus_SHAMAN           = "Chaman";
    CENSUSPlus_PALADIN          = "Paladin";
 
    CENSUSPlus_DWARF            = "Nain";
    CENSUSPlus_GNOME            = "Gnome";
    CENSUSPlus_HUMAN            = "Humain";
    CENSUSPlus_NIGHTELF         = "Elfe de la nuit";
    CENSUSPlus_ORC              = "Orc";
    CENSUSPlus_TAUREN           = "Tauren";
    CENSUSPlus_TROLL            = "Troll";
    CENSUSPlus_UNDEAD           = "Mort-vivant";
    
	CENSUSPlus_WarsongGulch     = "Goulet des Warsong";  
	CENSUSPlus_AlteracValley    = "Vallée d'Alterac";
	CENSUSPlus_ArathiBasin		= "Bassin d'Arathi";
    
	CENSUSPLUS_US_LOCALE		= "Choisissez si vous jouez sur un serveur US";
	CENSUSPLUS_EU_LOCALE		= "Choisissez si vous jouez sur un serveur EURO";
    CENSUSPLUS_LOCALE_SELECT    = "Choisissez la localité de votre serveur";
    
    
elseif ( GetLocale() == "deDE" ) then
    --  Thanks to MadMax-X for this German translation 
	CENSUSPlus_BUTTON_TEXT      = "Census+"; 
	CENSUSPlus_BUTTON_SUBTEXT   = "Realm Census"; 
	CENSUSPlus_BUTTON_TIP       = "Hier klicken um Census+ anzuzeigen oder zu verstecken."; 
	CENSUSPlus_HELP             = " Benutze /censusplus um die Census+ Oberfläche zu öffnen."; 

	CENSUSPlus_MSG1             = " Geladen - mit /censusplus or /census+ wird das Hauptfenster geöffnet"; 
	CENSUSPlus_MSG2             = "Mit /censusdate kann das aktuelle Datum im Format MM-DD-YYYY gesetzt werden, z.B. 12-25-2004"; 

	CENSUSPlus_UPLOAD           = "Lade deine CensusPlus Daten bei www.WarcraftRealms.com hoch!"; 
	CENSUSPlus_SETTINGDATE      = "Datum wird gesetzt => "; 
	CENSUSPlus_PAUSE            = "Pause"; 
	CENSUSPlus_UNPAUSE          = "Weiter"; 
	CENSUSPlus_STOP             = "Stop"; 

	CENSUSPlus_TAKECENSUS       = "Zähle alle aktiven \nSpieler deiner Fraktion \nauf diesem Server."; 
	CENSUSPlus_PURGEDATABASE    = "Lösche die Datenbank \nfür diesen Server \nund diese Fraktion."; 
	CENSUSPlus_PAUSECENSUS      = "Pausiere die laufende Zählung"; 
	CENSUSPlus_STOPCENSUS       = "Stoppe die laufende Zählung"; 

	CENSUSPlus_PURGEMSG         = "Charakterdatenbank für Server %s und Fraktion %s gelöscht."; 
	CENSUSPlus_ISINPROGRESS     = "Es läuft schon eine Zählung, versuch es später nochmal"; 
	CENSUSPlus_TAKINGONLINE     = "Zählung der gerade aktiven Charaktere..."; 
	CENSUSPlus_PLZUPDATEDATE    = "Bitte benutze /censusdate um das aktuelle Datum zu setzen, damit die Auswertung genauer wird. (Format: /censusdate MM-DD-YYYY, z.B. /censusdate 12-25-2004"; 
	CENSUSPlus_NOCENSUS         = "Es läuft gerade keine Zählung"; 
	CENSUSPlus_FINISHED         = "Zählung beendet. %s neue Charactere gefunden und %s aktualisiert."; 
	CENSUSPlus_TOOMANY          = "FEHLER: Zu viele passende Charaktere: %s"; 
	CENSUSPlus_WAITING          = "Warte, um /who zu senden..."; 
	CENSUSPlus_SENDING          = "Sende /who %s"; 
	CENSUSPlus_PROCESSING       = "Verarbeite %s Charaktere."; 

	CENSUSPlus_REALMNAME        = "Server: %s"; 
	CENSUSPlus_REALMUNKNOWN     = "Server: Unbekannt"; 
	CENSUSPlus_FACTION          = "Fraktion: %s"; 
	CENSUSPlus_FACTIONUNKNOWN   = "Fraktion: Unbekannt"; 
	CENSUSPlus_TOTALCHAR        = "Gesamte Charaktere: %d"; 
	CENSUSPlus_TOTALCHAR_0      = "Gesamte Charaktere: 0"; 
	CENSUSPlus_TOTALCHARXP      = "Gesamte Charakter-XP: %d"; 
	CENSUSPlus_TOTALCHARXP_0    = "Gesamte Charakter-XP: 0"; 
	CENSUSPlus_AUTOCLOSEWHO     = "Schließe Who automatisch"; 
	CENSUSPlus_SHOWMINI         = "Mini-Button beim Start anzeigen"; 
	CENSUSPlus_UNGUILDED        = "(Gildenlos)"; 
	CENSUSPlus_TAKE             = "Zählen"; 
	CENSUSPlus_TOPGUILD         = "Top Gilden nach XP"; 
	CENSUSPlus_RACE             = "Rassen"; 
	CENSUSPlus_CLASS            = "Klassen"; 
	CENSUSPlus_LEVEL            = "Level"; 
	CENSUSPlus_PURGE            = "Löschen"; 

	CENSUSPlus_MAXIMIZE         = "Maximiere das CensusPlus Fenster"; 
	CENSUSPlus_MINIMIZE         = "Minimiere das CensusPlus Fenster"; 
	CENSUSPlus_BUTTON_MINIMIZE  = "Minimieren"; 

	CENSUSPlus_HORDE            = "Horde"; 
	CENSUSPlus_ALLIANCE         = "Alliance"; 

	CENSUSPlus_DRUID            = "Druide"; 
	CENSUSPlus_HUNTER           = "Jäger"; 
	CENSUSPlus_MAGE             = "Magier"; 
	CENSUSPlus_PRIEST           = "Priester"; 
	CENSUSPlus_ROGUE            = "Schurke"; 
	CENSUSPlus_WARLOCK          = "Hexenmeister"; 
	CENSUSPlus_WARRIOR          = "Krieger"; 
	CENSUSPlus_SHAMAN           = "Schamane"; 
	CENSUSPlus_PALADIN          = "Paladin"; 

	CENSUSPlus_DWARF            = "Zwerg"; 
	CENSUSPlus_GNOME            = "Gnom"; 
	CENSUSPlus_HUMAN            = "Mensch"; 
	CENSUSPlus_NIGHTELF         = "Nachtelf"; 
	CENSUSPlus_ORC              = "Orc"; 
	CENSUSPlus_TAUREN           = "Tauren"; 
	CENSUSPlus_TROLL            = "Troll"; 
	CENSUSPlus_UNDEAD           = "Untoter";   
	
	CENSUSPlus_WarsongGulch     = "Warsongschlucht";  
	CENSUSPlus_AlteracValley    = "Alteractal";
	CENSUSPlus_ArathiBasin		= "Arathibecken";

	CENSUSPLUS_US_LOCALE= "Auswählen, wenn du auf US-Servern spielst"; 
	CENSUSPLUS_EU_LOCALE= "Auswählen, wenn du auf EURO-Servern spielst"; 
	CENSUSPLUS_LOCALE_SELECT= "Wähle, ob du auf US oder EURO-Servern spielst";
	
	CENSUSPlus_BUTTON_OPTIONS   = "Optionen";
	CENSUSPlus_OPTIONS_HEADER   = "Census+ Optionen";
	CENSUSPlus_ISINBG	    = "Du befindest dich momentan auf einem Schlachtfeld und daher kann Census+ keine Abfrage duchführen.";
	CENSUS_OPTIONS_BUTPOS	    = "Button Position";
	CENSUS_OPTIONS_BUTSHOW	    = "Minimap-Button";
	CENSUS_OPTIONS_AUTOSTART    = "Autom. Starten";
	CENSUS_OPTIONS_VERBOSE      = "Verbose";
	CENSUS_OPTIONS_AUTOCENSUS   = "Autom. Zählen";
	CENSUS_OPTIONS_THISPROFILE  = "Profil nur diesen Charakter";
	CENSUS_OPTIONS_EXIT	    = "Schließen";

	CENSUS_BUTTON_TOOLTIP	    = "CensusPlus öffnen";

	CENSUS_LEVEL_NO_GUILD = "(.+): Stufe (%d+) (.+) (.+) - (.+)";
	CENSUS_LEVEL_W_GUILD  = "(.+): Stufe (%d+) (.+) (.+) <(.+)> - (.+)";
	CENSUS_MULT_PLAYERS   = "(%d+) Spieler gesamt";
	CENSUS_SING_PLAYER    = "(%d+) Spieler gesamt";
	
elseif ( GetLocale() == "esES" ) then
	--  Thanks to NeKRoMaNT  EU-Zul'jin   < contacto@nekromant.com> for the Spanish Translation
	CENSUSPlus_BUTTON_TEXT      = "Census+";
	CENSUSPlus_BUTTON_SUBTEXT   = "Estadísticas Servidor";
	CENSUSPlus_BUTTON_TIP       = "Pulsa aquí para mostrar u ocultar Census+.";
	CENSUSPlus_HELP             = " Usa /censusplus para abrir y cerrar la interfaz Census+.";

	CENSUSPlus_MSG1             = " operativo - Escribe /censusplus o /census+ para abrir la ventana principal";

	CENSUSPlus_UPLOAD           = "¡Asegúrate de enviar tus datos a www.WarcraftRealms.com!";
	CENSUSPlus_PAUSE            = "Pausa";
	CENSUSPlus_UNPAUSE          = "Continuar";
	CENSUSPlus_STOP             = "Detener";
	CENSUSPlus_PRUNE            = "Resetear";

	CENSUSPlus_TAKECENSUS       = "Realizar un censo de jugadores \nconectados en este servidor \ny en esta facción";
	CENSUSPlus_PURGEDATABASE    = "Purgar la base de datos para este servidor y facción";
	CENSUSPlus_PAUSECENSUS      = "Pausar el censo actual";
	CENSUSPlus_UNPAUSECENSUS    = "Continuar el censo actual";
	CENSUSPlus_STOPCENSUS       = "Detener el censo actual";
	CENSUSPlus_PRUNECENSUS      = "Optimiza la base de datos borrando personajes sin censar en los últimos 30 días";

	CENSUSPlus_PURGEMSG         = "Base de datos de personajes purgada.";
	CENSUSPlus_ISINPROGRESS     = "Censo en progreso, vuelve a intentarlo mas tarde";
	CENSUSPlus_TAKINGONLINE     = "Realizando censo de personajes conectados...";
	CENSUSPlus_NOCENSUS         = "No hay ningún censo activo";
	CENSUSPlus_FINISHED         = "Se ha terminado de recoger datos. Encontrados %s nuevos personajes y %s actualizados. Duración %s.";
	CENSUSPlus_TOOMANY          = "AVISO: Demasiadas coincidencias: %s";
	CENSUSPlus_WAITING          = "Esperando a enviar petición /quien...";
	CENSUSPlus_SENDING          = "Enviando /quien %s";
	CENSUSPlus_PROCESSING       = "Procesando %s personajes.";

	CENSUSPlus_REALMNAME        = "Servidor: %s";
	CENSUSPlus_REALMUNKNOWN     = "ServidorReino: Desconocido";
	CENSUSPlus_FACTION          = "Facción: %s";
	CENSUSPlus_FACTIONUNKNOWN   = "Facción: Desconocida";
	CENSUSPlus_LOCALE           = "Región : %s";
	CENSUSPlus_LOCALEUNKNOWN    = "Región : Desconocida";
	CENSUSPlus_TOTALCHAR        = "Personajes Totales: %d";
	CENSUSPlus_TOTALCHAR_0      = "Personajes Totales: 0";
	CENSUSPlus_TOTALCHARXP      = "Total EXP Personajes: %d";
	CENSUSPlus_TOTALCHARXP_0    = "Total EXP Personajes: 0";
	CENSUSPlus_AUTOCLOSEWHO     = "Cerrar Quien Automático";
	CENSUSPlus_SHOWMINI         = "Minimizado al inicio";
	CENSUSPlus_UNGUILDED        = "(Sin Hermandad)";
	CENSUSPlus_TAKE             = "Comenzar";
	CENSUSPlus_TOPGUILD         = "Clanes por Experiencia";
	CENSUSPlus_RACE             = "Razas";
	CENSUSPlus_CLASS            = "Clases";
	CENSUSPlus_LEVEL            = "Niveles";
	CENSUSPlus_PURGE            = "Purgar";
	CENSUSPlus_MAXXED           = "MAXXED!";

	CENSUSPlus_MAXIMIZE         = "Maximizar la ventana de CensusPlus";
	CENSUSPlus_MINIMIZE         = "Minimizar la ventana de CensusPlus";
	CENSUSPlus_BUTTON_MINIMIZE  = "Minimizar";

	CENSUSPlus_HORDE            = "Horde";
	CENSUSPlus_ALLIANCE         = "Alliance";

	CENSUSPlus_DRUID            = "Druida";
	CENSUSPlus_HUNTER           = "Cazador";
	CENSUSPlus_MAGE             = "Mago";
	CENSUSPlus_PRIEST           = "Sacerdote";
	CENSUSPlus_ROGUE            = "Pícaro";
	CENSUSPlus_WARLOCK          = "Brujo";
	CENSUSPlus_WARRIOR          = "Guerrero";
	CENSUSPlus_SHAMAN           = "Chamán";
	CENSUSPlus_PALADIN          = "Paladín";

	CENSUSPlus_DWARF            = "Enano";
	CENSUSPlus_GNOME            = "Gnomo";
	CENSUSPlus_HUMAN            = "Humano";
	CENSUSPlus_NIGHTELF         = "Elfo de la noche";
	CENSUSPlus_ORC              = "Orco";
	CENSUSPlus_TAUREN           = "Tauren";
	CENSUSPlus_TROLL            = "Trol";
	CENSUSPlus_UNDEAD           = "No-muerto";

	CENSUSPlus_WarsongGulch     = "Garganta Grito de Guerra"; 
	CENSUSPlus_AlteracValley    = "Valle de Alterac";
	CENSUSPlus_ArathiBasin      = "Cuenca de Arathi";

	CENSUSPlus_BUTTON_OPTIONS   = "Opciones";
	CENSUSPlus_OPTIONS_HEADER   = "Opciones Census+";
	CENSUS_OPTIONS_BUTPOS      = "Posición de botón";
	CENSUS_OPTIONS_BUTSHOW      = "Mostrar botón";

	CENSUSPlus_BUTTON_CHARACTERS = "Mostrar personajes";
	CENSUSPlus_Characters      = "Personajes";

	CENSUS_BUTTON_TOOLTIP      = "Abrir CensusPlus";

	CENSUS_LEVEL_NO_GUILD = "(.+): Nivel (%d+) (.+) (.+) - (.+)";
	CENSUS_LEVEL_W_GUILD  = "(.+): Nivel (%d+) (.+) (.+) <(.+)> - (.+)";
	CENSUS_MULT_PLAYERS   = "(%d+) jugadores en total";
	CENSUS_SING_PLAYER    = "(%d+) jugador en total";

	CENSUSPlus_CANCEL         = "Cancelar"; 
end

