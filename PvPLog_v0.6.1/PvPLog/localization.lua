--[[
  PvPLog 
  Author:           Andrzej Gorski 
  Maintainer:       Matthew Musgrove
  Based on Work by: Josh Estelle, Daniel S. Reichenbach
  Version:          0.6.1
  Last Modified:    2006-10-23
]]

-- version information
VER_VENDOR = "wowroster.net";
VER_NUM = "0.6.1";

--Everything From here on would need to be translated and put
--into if statements for each specific language.

--***********
--ENGLISH (DEFAULT)
--***********

	--startup messages
	PVPLOG_STARTUP = "PvP Logger "..VER_NUM.." by "..VER_VENDOR.." AddOn loaded. Type /pl for options.";

	DESCRIPTION = "Keeps track of your PvP kills and the people who kill you.";
	
	--needed phrases
	TO = " to ";
	ON = "on";
	OFF = "off";
	NONE = "none";
	RESET = "reset";
	CONFIRM = "confirm";
	ENABLE = "enable";
	DISABLE = "disable";
	UNKNOWN = "Unknown";
	VER = "version";
	VEN = "vendor";
	USAGE = "Usage";
	DISPLAY = "display";
	DING = "ding";
	MOUSEOVER = "mouseover";
	NOSPAM = "nospam";
	
	DMG = "damage";
	ST = "stats";
	STATS = "Statistics";
	COMP = "completely";
	
	PARTY = "Party";
	GUILD = "Guild";
	RAID = "Raid";
	RACE = "race";
	CLASS = "class";
	ENEMY = "enemy";
	REALM = "Realm";
	BG = "Battleground";
		
	-- The following are not being used currently
--	AB = "Arathi Basin";
--	AV = "Alterac Valley";
--	WSG = "Warsong Gulch";
	
	WIN = "win";
	LOSS = "loss";
	WINS = "wins";
	LOSSES = "losses";
	
	DUEL = "Duel";
	TOTAL = "Total";
	STATS = "Statistics";
	ALD = "Avg Level Diff";
	
	NOTIFYKILLS = "notifykills";
	NOTIFYDEATH = "notifydeath";
	
	DLKB = "Death logged, killed by: ";
	KL = "Kill logged: ";
	DWLA = "Duel win logged against: ";
	DLLA = "Duel loss logged against: ";
	
	--gank levels
	GL0 = "Fair Fighter";
	GL_25 = "I Have No Mercy";
	GL_20 = "Newb Masher";
	GL_15 = "No Seriously, Get a Life";
	GL_12 = "Get a Life";
	GL_9 = "Gankity Gank Gank";
	GL_6 = "Major Ganker";
	GL_3 = "Minor Ganker";
	GL8 = "I Gank GankMasters";
	GL5 = "PvP God";
	GL4 = "PvP Legend";
	GL3 = "Ungankable";
	GL2 = "Just try to gank me";
	GL1 = "Difficult to Gank";
	
	--default display text for notify
	DEFAULT_KILL_TEXT = "I killed %n (Level %l %r %c) at [%x,%y] in %z (%w).";
	DEFAULT_DEATH_TEXT = "%n (Level %l %r %c) killed me at [%x,%y] in %z (%w).";
	
	UI_OPEN = "Open";
	UI_CLOSE = "Close";
	UI_CONFIG = "config";
	UI_NOTIFY_KILLS = "Notify kills to:";
	UI_NOTIFY_DEATHS = "Notify deaths to:";
	UI_CUSTOM = "Custom";
	UI_ENABLE = "Enable PvPLog";
	UI_MOUSEOVER = "Mouseover effects";
	UI_DING = "Audio Ding";
	UI_DISPLAY = "Floating text messages";
	UI_NOTIFY_NONE = "None";
	UI_DING_TIP = "When you mouse-over a player you\nhave fought before a sound will play.";
	UI_PVP = "PvP";
	UI_NAME = "Name";
	UI_WINS = "Wins";
	UI_LOSSES = "Losses";
	UI_TOGGLE = "Toggles " .. UI_CONFIG;
	UI_RIGHT_CLICK = "Right click: ";
	UI_LEFT_CLICK = "Left click: ";
	UI_MINIMAP_BUTTON = "Minimap Button";

--***********
-- GERMAN
--***********
if (GetLocale() == "deDE") then
	-- translated by yamyam

	--startup messages
	PVPLOG_STARTUP = "PvP Logger "..VER_NUM.." by "..VER_VENDOR.." AddOn loaded. Type /pl for options.";
	
	DESCRIPTION = "Zeichnet PvP Siege und Verluste auf, sowie Duelle.";

	--startup messages
	PVPLOG_STARTUP = "PvP Logger "..VER_NUM.." von "..VER_VENDOR.." AddOn geladen. Tippe /pl für Optionen.";
	
	--needed phrases
	TO = " to ";
	ON = "an";
	OFF = "aus";
	NONE = "keine";        
	RESET = "zurücksetzen";
	CONFIRM = "bestätigen";  
	ENABLE = "einschalten";    
	DISABLE = "ausschalten";  
	UNKNOWN = "unbekannt";  
	VER = "version";      -- version? versionsnummer?
	VEN = "vendor";       -- verkufer?
	USAGE = "Usage";      -- verwenden?
	DISPLAY = "Anzeige";  
	DING = "ding";
	MOUSEOVER = "mouseover";
	NOSPAM = "nospam";
	
	DMG = "Schaden";
	ST = "stats";
	STATS = "Statistik";
	COMP = "komplett";
	
	PARTY = "Gruppe";
	GUILD = "Gilde";
	RAID = "Schlachtzug";
	RACE = "Rasse";
	CLASS = "Klasse";
	ENEMY = "Feind";
	BG = "Schlachtfeld";
	
--	AB = "Arathibecken";
--	AV = "Alteractal";
--	WSG = "Warsongschlucht";

	
	WIN = "sieg";
	LOSS = "verlor";
	WINS = "siege";
	LOSSES = "verloren";
	
	DUEL = "Duell";
	TOTAL = "Summe";
	STATS = "Statistik";
	ALD = "Durchschnittlicher Levelunterschied";
	
	NOTIFYKILLS = "Killanzeige";
	NOTIFYDEATH = "Todesanzeige";
	
	DLKB = "Tod geloggt, getötet von: ";
	KL = "Tod geloggt: ";
	DWLA = "Duell gewonnen gegen: ";
	DLLA = "Duell verloren gegen: ";

	--gank levels
	GL0 = "Fair Fighter";
	GL_25 = "I Have No Mercy";
	GL_20 = "Newb Masher";
	GL_15 = "No Seriously, Get a Life";
	GL_12 = "Get a Life";
	GL_9 = "Gankity Gank Gank";
	GL_6 = "Major Ganker";
	GL_3 = "Minor Ganker";
	GL8 = "I Gank GankMasters";
	GL5 = "PvP God";
	GL4 = "PvP Legend";
	GL3 = "Ungankable";
	GL2 = "Just try to gank me";
	GL1 = "Difficult to Gank";

	--default display text for notify
	DEFAULT_KILL_TEXT = "Ich habe %n (Level %l %r %c) bei [%x,%y] in %z (%w) getötet.";
	DEFAULT_DEATH_TEXT = "%n (Level %l %r %c) hat mich bei [%x,%y] in %z (%w) getötet.";
	
	UI_OPEN = "Öffnen";
	UI_CLOSE = "Schließen";
	UI_CONFIG = "Konfiguration";
	UI_NOTIFY_KILLS = "Kills anzeigen in:";
	UI_NOTIFY_DEATHS = "Tode anzeigen in:";
	UI_CUSTOM = "Custom";
	UI_ENABLE = "PvPLog einschalten";
	UI_MOUSEOVER = "Mouseover Effekte";
	UI_DING = "Audio Ding-Sound";
	UI_DISPLAY = "Floating text messages";
	UI_NOTIFY_NONE = "Keine";
	UI_DING_TIP = "When you mouse-over a player you\nhave fought before a sound will play.";
	UI_PVP = "PvP";
	UI_NAME = "Name";
	UI_WINS = "Siege";
	UI_LOSSES = "Verloren";
	UI_TOGGLE = UI_CONFIG .. " anzeigen/verbergen";
	UI_RIGHT_CLICK = "Rechtsklick: ";
	UI_LEFT_CLICK = "Linksklick: ";
	UI_MINIMAP_BUTTON = "Minimap Button";

elseif (GetLocale() == "frFR") then
	--startup messages
	PVPLOG_STARTUP = "PvP Logger "..VER_NUM.." by "..VER_VENDOR.." AddOn loaded. Type /pl for options.";
	
	DESCRIPTION = "Keeps track of your PvP kills and the people who kill you.";

	--needed phrases
	TO = " to ";          -- ?
	ON = "on";            -- sur?
	OFF = "off";          -- 
	NONE = "none";        -- aucun?
	RESET = "reset";      -- 
	CONFIRM = "confirm";  -- confirmer?
	ENABLE = "enable";    -- permettre?
	DISABLE = "disable";  -- 
	UNKNOWN = "Unknown";  -- inconnu?
	VER = "version";      -- version?
	VEN = "vendor";       -- fournisseur?
	USAGE = "Usage";      -- utilisation?
	DISPLAY = "display";  -- montrer?
	DING = "ding";
	MOUSEOVER = "mouseover";
	NOSPAM = "nospam";
	
	DMG = "damage";
	ST = "stats";
	STATS = "Statistics";
	COMP = "completely";
	
	PARTY = "Party";
	GUILD = "Guild";
	RAID = "Raid";
	RACE = "race";
	CLASS = "class";
	ENEMY = "enemy";
	BG = "Battleground";

--	AB = "Arathi Basin";
--	AV = "Alterac Valley";
--	WSG = "Warsong Gulch";
	
	WIN = "win";
	LOSS = "loss";
	WINS = "wins";
	LOSSES = "losses";
	
	DUEL = "Duel";
	TOTAL = "Total";
	STATS = "Statistics";
	ALD = "avg.level.diff";
	
	NOTIFYKILLS = "notifykills";
	NOTIFYDEATH = "notifydeath";
	
	DLKB = "Death logged, killed by: ";
	KL = "Kill logged: ";
	DWLA = "Duel win logged against: ";
	DLLA = "Duel loss logged against: ";
	
	--gank levels
	GL0 = "Fair Fighter";
	GL_25 = "I Have No Mercy";
	GL_20 = "Newb Masher";
	GL_15 = "No Seriously, Get a Life";
	GL_12 = "Get a Life";
	GL_9 = "Gankity Gank Gank";
	GL_6 = "Major Ganker";
	GL_3 = "Minor Ganker";
	GL8 = "I Gank GankMasters";
	GL5 = "PvP God";
	GL4 = "PvP Legend";
	GL3 = "Ungankable";
	GL2 = "Just try to gank me";
	GL1 = "Difficult to Gank";
	
	--default display text for notify
	DEFAULT_KILL_TEXT = "I killed %n (Level %l %r %c) at [%x,%y] in %z (%w).";
	DEFAULT_DEATH_TEXT = "%n (Level %l %r %c) killed me at [%x,%y] in %z (%w).";

	UI_OPEN = "Ouvrir";
	UI_CLOSE = "Fermer";
	UI_CONFIG = "config";
	UI_NOTIFY_KILLS = "Notify kills to:";
	UI_NOTIFY_DEATHS = "Notify deaths to:";
	UI_CUSTOM = "Custom";
	UI_ENABLE = "Enable PvPLog";
	UI_MOUSEOVER = "Mouseover effects";
	UI_DING = "Audio Ding";
	UI_DISPLAY = "Floating text messages";
	UI_NOTIFY_NONE = "None";
	UI_DING_TIP = "When you mouse-over a player you\nhave fought before a sound will play.";
	UI_PVP = "PvP";
	UI_NAME = "Name";
	UI_WINS = "Wins";
	UI_LOSSES = "Losses";   
	UI_TOGGLE = "Toggles " .. UI_CONFIG;
	UI_RIGHT_CLICK = "Right click: ";
	UI_LEFT_CLICK = "Left click: ";
	UI_MINIMAP_BUTTON = "Minimap Button";
	
elseif (GetLocale() == "esES") then
-- translated by NeKRoMaNT
-- traducido por NeKRoMaNT

	-- startup messages
	PVPLOG_STARTUP = "PvP Logger "..VER_NUM.." por "..VER_VENDOR.." AddOn cargado. Mecanografiar /pl para las opciones.";
	
	DESCRIPTION = "Hace un seguimiento de tus asesinatos JcJ y de la gente que te ha asesinado.";

	-- needed phrases
	TO = " a ";
	ON = "Encendido";
	OFF = "Apagado";
	NONE = "Ninguno";
	RESET = "Resetear";
	CONFIRM = "Confirmar";
	ENABLE = "Activar";
	DISABLE = "Desactivar";
	UNKNOWN = "Desconocido";
	VER = "Versión";
	VEN = "Vendedor";
	USAGE = "Uso";
	DISPLAY = "Mostrar";
	DING = "ding";
	MOUSEOVER = "mouseover";
	NOSPAM = "Sin Spam";
	
	DMG = "daño";
	ST = "estadísticas";
	STATS = "Estadísticas";
	COMP = "Completamente";
	
	PARTY = "Grupo";
	GUILD = "Hermandad";
	RAID = "Banda";
	RACE = "raza";
	CLASS = "clase";
	ENEMY = "enemigo";
	BG = "Campo de Batalla";
	
--	AB = "Cuenca de Arathi";
--	AV = "Valle de Alterac";
--	WSG = "Garganta Grito de Guerra";
	
	WIN = "gana";
	LOSS = "pierde";
	WINS = "Victorias";
	LOSSES = "Derrotas";
	
	DUEL = "Duelo";
	TOTAL = "Total";
	STATS = "Estadísticas";
	ALD = "Diferencia de Nivel";
	
	NOTIFYKILLS = "Aviso de Asesinatos";
	NOTIFYDEATH = "Aviso de Muertes";
	
	DLKB = "Muerte grabada, asesinado por: ";
	KL = "Asesinato grabado: ";
	DWLA = "Victoria en duelo grabada contra: ";
	DLLA = "Derrota en duelo grabada contra: ";
	
	-- gank levels
	GL0 = "Fair Fighter";
	GL_25 = "I Have No Mercy";
	GL_20 = "Newb Masher";
	GL_15 = "No Seriously, Get a Life";
	GL_12 = "Get a Life";
	GL_9 = "Gankity Gank Gank";
	GL_6 = "Major Ganker";
	GL_3 = "Minor Ganker";
	GL8 = "I Gank GankMasters";
	GL5 = "PvP God";
	GL4 = "PvP Legend";
	GL3 = "Ungankable";
	GL2 = "Just try to gank me";
	GL1 = "Difficult to Gank";
	
	-- default display text for notify
	DEFAULT_KILL_TEXT = "He asesinado a %n (Nivel %l %r %c) en [%x,%y] en %z (%w).";
	DEFAULT_DEATH_TEXT = "%n (Nivel %l %r %c) me ha asesinado en [%x,%y] en %z (%w).";
	   
	UI_OPEN = "Abrir";
	UI_CLOSE = "Cerrar";
	UI_CONFIG = "configuración";
	UI_NOTIFY_KILLS = "Notificar asesinatos a:";
	UI_NOTIFY_DEATHS = "Notificar muertes a:";
	UI_CUSTOM = "Personalizar";
	UI_ENABLE = "Activar PvPLog";
	UI_MOUSEOVER = "Efectos Mouseover";
	UI_DING = "Utilizar Audio";
	UI_DISPLAY = "Mensajes Emergentes";
	UI_NOTIFY_NONE = "Nadie";
	UI_DING_TIP = "Cuando pases el ratón sobre un jugador contra \nquien hayas luchado sonará una señal.";
	UI_PVP = "JcJ";
	UI_NAME = "Nombre";
	UI_WINS = "Victorias";
	UI_LOSSES = "Derrotas";
	UI_RIGHT_CLICK = "Clic derecha: ";
	UI_LEFT_CLICK = "Clic izquierdo: ";
	UI_TOGGLE = "Muestra/oculta " .. UI_CONFIG;
	UI_MINIMAP_BUTTON = "Botón De Minimap";

end
