--[[

-- MetaMap Localization Data (French)
-- Translation by Sparrows (Comics UI)
-- Last Update: 03/14/2006

--]]

-- à: C3 A0 - \195\160
-- â: C3 A2 - \195\162
-- ç: C3 A7 - \185\167
-- è: C3 A8 - \195\168
-- é: C3 A9 - \195\169
-- ê: C3 AA - \195\170
-- ë: C3 AB - \195\171
-- î: C3 AE - \195\174
-- ô: C3 B4 - \195\180
-- û: C3 BB - \195\187
-- œ: C5 93 - \197\147
-- ': E2 80 99 - \226\128\153

if (GetLocale() == "frFR") then

-- General
METAMAP_CATEGORY = "Interface";
METAMAP_SUBTITLE = "WorldMap Mod";
METAMAP_DESC = "MetaMap est une modification de la carte standard du monde.";
METAMAP_OPTIONS_BUTTON = "Options";
METAMAP_SLASH_OPTIONS = "Options";
METAMAP_STRING_LOCATION = "Lieux";
METAMAP_STRING_LEVELRANGE = "Plage de niveaux";
METAMAP_STRING_PLAYERLIMIT = "Limit\195\169 \195\160";
METAMAP_BUTTON_TOOLTIP1 = "Clic-Droit pour affiche la carte";
METAMAP_BUTTON_TOOLTIP2 = "Clic-Gauche pour les options";
METAMAP_OPTIONS_TITLE = "MetaMap Options";
METAMAP_KB_TEXT = "Base de donn\195\169es"
METAMAP_HINT = "Conseil : clic-droit pour ouvrir MetaMap.\nclic-gauche pour les options";
METAMAPNOTES_NAME = "map notes"
METAMAP_NOTES_SHOWN = "Notes"
METAMAP_LINES_SHOWN = "Lignes"
BINDING_HEADER_METAMAP_TITLE = "MetaMap";
BINDING_NAME_METAMAP_TOGGLE = "[ON/OFF] MetaMap";
BINDING_NAME_METAMAP_SAVESET = "Choisir le mode d\'affichage de la carte";
BINDING_NAME_METAMAP_KB = "Afficher la base de donn\195\169es"
BINDING_NAME_METAMAP_KB_TARGET_UNIT = "Enregistrer les infos de la cible";
BINDING_NAME_METAMAP_QUICKNOTE = "Creer une Note Rapide";

-- Commands
METAMAP_ZDEBUG_COMMANDS = { "/mmdebug" }
METAMAPNOTES_ENABLE_COMMANDS = { "/mapnote" }
METAMAPNOTES_ONENOTE_COMMANDS = { "/onenote", "/allowonenote", "/aon" }
METAMAPNOTES_MININOTE_COMMANDS = { "/nextmininote", "/nmn" }
METAMAPNOTES_MININOTEONLY_COMMANDS = { "/nextmininoteonly", "/nmno" }
METAMAPNOTES_MININOTEOFF_COMMANDS = { "/mininoteoff", "/mno" }
METAMAPNOTES_MNTLOC_COMMANDS = { "/mntloc" }
METAMAPNOTES_QUICKNOTE_COMMANDS = { "/quicknote", "/qnote" }
METAMAPNOTES_QUICKTLOC_COMMANDS = { "/quicktloc", "/qtloc" }

-- Interface Configuration
METAMAP_MENU_MODE = "Menu on Click";
METAMAP_OPTIONS_COORDS = "Voir Coords";
METAMAP_OPTIONS_MINICOORDS = "Voir MiniMap Coords";
METAMAP_OPTIONS_SHOWBUT = "Voir Bouton MetaMap";
METAMAP_OPTIONS_AUTOSEL = "Autosize Tooltip";
METAMAP_OPTIONS_BUTPOS = "Position du Bouton";
METAMAP_OPTIONS_POI = "Voir D\195\169faut POI";
METAMAP_OPTIONS_MOZZ = "Affiche l\'inexplor\195\169";
METAMAP_OPTIONS_TRANS = "Transparence";
METAMAP_OPTIONS_FWM = "Show Unexplored Areas";
METAMAP_OPTIONS_DONE = "OK";
METAMAP_FLIGHTMAP_OPTIONS = "FlightMap Options";
METAMAP_MASTERMOD_OPTIONS = "MasterMod Options";
METAMAP_GATHERER_OPTIONS = "Gatherer Options";
METAMAP_GATHERER_SEARCH = "Gatherer Search";
METAMAP_BWP_OPTIONS = "BetterWaypoints";
METAMAP_OPTIONS_SHOWCTBUT = "Voir MasterMod Bouton";
METAMAP_OPTIONS_SCALE = "Taille de la carte";
METAMAP_OPTIONS_TTSCALE = "Taille des Tooltip";
METAMAP_OPTIONS_SAVESET = "Mode d\'affichage de la carte";
METAMAP_OPTIONS_USEMAPMOD = "Create notes with MapMod";
METAMAP_LIST_TEXT = "Show Map List";
METAMAP_ACTION_MODE = "Map Action Mode";

METAMAPNOTES_WORLDMAP_HELP_1 = "-Clic Droit sur la carte pourfaire un zoom arriere"
METAMAPNOTES_WORLDMAP_HELP_2 = "-<Commande>+Clic Gauche pour Cr\195\169er une Note"
METAMAPNOTES_CLICK_ON_SECOND_NOTE = "|cFFFF0000MetaMapNotes:|r Choisissez une Note pour tracer/effacer une ligne"

METAMAPNOTES_NEW_MENU = "Notes De Carte"
METAMAPNOTES_NEW_NOTE = "Cr\195\169er une Note"
METAMAPNOTES_MININOTE_OFF = "D\195\169sactiver MiniNotes"
METAMAPNOTES_OPTIONS_TEXT = "Notes Options"
METAMAPNOTES_CANCEL = "Annuler"
METAMAPNOTES_SHOW_AUTHOR = "Afficher les notes cr\195\169ateur"

METAMAPNOTES_POI_MENU = "Notes De Carte"
METAMAPNOTES_EDIT_NOTE = "Modifier Note"
METAMAPNOTES_MININOTE_ON = "Utiliser MiniNote"
METAMAPNOTES_SPECIAL_ACTIONS = "Actions sp\195\169ciales"
METAMAPNOTES_SEND_NOTE = "Envoyer Note"

METAMAPNOTES_SPECIALACTION_MENU = "Actions sp\195\169ciales"
METAMAPNOTES_TOGGLELINE = "Cr\195\169er/Supprimer la ligne"
METAMAPNOTES_DELETE_NOTE = "Supprimer la Note"

METAMAPNOTES_EDIT_MENU = "Modifier une Note"
METAMAPNOTES_SAVE_NOTE = "Sauvegarder"
METAMAPNOTES_EDIT_TITLE = "Titre (requis):"
METAMAPNOTES_EDIT_INFO1 = "Ligne D\226\128\153Information 1 (optionel):"
METAMAPNOTES_EDIT_INFO2 = "Ligne D\226\128\153Information 2 (optionel):"
METAMAPNOTES_EDIT_CREATOR = "Cr\195\169ateur (optionel - Laisser vide pour cacher):"

METAMAPNOTES_SEND_MENU = "Envoyer Note"
METAMAPNOTES_SLASHCOMMAND = "Changer de Mode"
METAMAPNOTES_SEND_TITLE = "Envoyer Note:"
METAMAPNOTES_SEND_TIP = "Les Notes peuvent \195\170tre re\185\167ues par tous les utilisateurs de Notes de Carte (MetaMap (\226\128\153Envoyer au groupe\226\128\153 ne marche qu\226\128\153avec Sky)"
METAMAPNOTES_SEND_PLAYER = "Nom du joueur :"
METAMAPNOTES_SENDTOPLAYER = "Envoyer au joueur"
METAMAPNOTES_SENDTOPARTY = "Envoyer au groupe"
METAMAPNOTES_SHOWSEND = "Changer de Mode"
METAMAPNOTES_SEND_SLASHTITLE = "Obtenir la /commande :"
METAMAPNOTES_SEND_SLASHTIP = "Selectionnez ceci et utilisez CTRL+C pour la copier dans le presse-papier. (Vous pouvez ensuite l\226\128\153envoyer sur un forum par exemple)"
METAMAPNOTES_SEND_SLASHCOMMAND = "/Commande :"

METAMAPNOTES_OPTIONS_MENU = "Options"
METAMAPNOTES_SAVE_OPTIONS = "Sauvegarder"
METAMAPNOTES_OWNNOTES = "Afficher les notes cr\195\169\195\169es par votre personnage."
METAMAPNOTES_OTHERNOTES = "Afficher les Notes re\185\167ues des autres joueurs."
METAMAPNOTES_HIGHLIGHT_LASTCREATED = "Mettre en \195\169vidence (en |cFFFF0000rouge|r) la derni\195\168re Note cr\195\169\195\169e."
METAMAPNOTES_HIGHLIGHT_MININOTE = "Mettre en \195\169vidence (en |cFF6666FFbleu|r) la Note selectionn\195\169e."
METAMAPNOTES_ACCEPTINCOMING = "Accepter les Notes des autres utilisateurs."
METAMAPNOTES_INCOMING_CAP = "Refuser une Note si vous avez moins de 5 Notes disponibles."
METAMAPNOTES_AUTOPARTYASMININOTE = "Membres du groupe en MiniNote."

METAMAPNOTES_CREATEDBY = "Cr\195\169\195\169 par"
METAMAPNOTES_CHAT_COMMAND_ENABLE_INFO = "Cette commande vous permet d\226\128\153ajouter une Note trouv\195\169e sur une page web par exemple."
METAMAPNOTES_CHAT_COMMAND_ONENOTE_INFO = "Autorise la r\195\169ception de la prochaine Note."
METAMAPNOTES_CHAT_COMMAND_MININOTE_INFO = "Mettre la prochaine Note re\185\167ue en tant que MiniNote (avec une copie sur la carte)."
METAMAPNOTES_CHAT_COMMAND_MININOTEONLY_INFO = "Mettre la prochaine Note re\185\167ue en tant que MiniNote (seulement sur la minicarte)."
METAMAPNOTES_CHAT_COMMAND_MININOTEOFF_INFO = "D\195\169sactiver MiniNote."
METAMAPNOTES_CHAT_COMMAND_MNTLOC_INFO = "Ajoute une position sur la carte."
METAMAPNOTES_CHAT_COMMAND_QUICKNOTE = "Cr\195\169er une Note \195\160 votre position actuelle."
METAMAPNOTES_CHAT_COMMAND_QUICKTLOC = "Cr\195\169er une Note \195\160 la position donn\195\169e."
METAMAPNOTES_MAPNOTEHELP = "Cette commande ne peut \195\170tre utilis\195\169e que pour ajouter une Note."
METAMAPNOTES_ONENOTE_OFF = "Autoriser une Note : D\195\169sactiv\195\169"
METAMAPNOTES_ONENOTE_ON = "Autoriser une Note : Activ\195\169"
METAMAPNOTES_MININOTE_SHOW_0 = "Prochaine Note en MiniNote: D\195\169sactiv\195\169"
METAMAPNOTES_MININOTE_SHOW_1 = "Prochaine Note en MiniNote: Activ\195\169"
METAMAPNOTES_MININOTE_SHOW_2 = "Prochaine Note en MiniNote: Seulement"
METAMAPNOTES_DECLINE_SLASH = "Ajout impossible, trop de Notes dans la zone |cFFFFD100%s|r."
METAMAPNOTES_DECLINE_SLASH_NEAR = "Ajout impossible, Note trop proche de |cFFFFD100%q|r dans |cFFFFD100%s|r."
METAMAPNOTES_DECLINE_GET = "R\195\169ception impossible, trop de Notes dans la zone |cFFFFD100%s|r, ou la r\195\169ception de Notes est d\195\169sactiv\195\169e."
METAMAPNOTES_ACCEPT_SLASH = "Note ajout\195\169 dans |cFFFFD100%s|r."
METAMAPNOTES_ACCEPT_GET = "Vous avez re\185\167u la Note \226\128\153%s dans %s"
METAMAPNOTES_PARTY_GET = "|cFFFFD100%s|r utilis\195\169 comme Note de g\226\128\153roupe dans |cFFFFD100%s|r."
METAMAPNOTES_DECLINE_NOTETONEAR = "|cFFFFD100%s|r a essay\195\169 de vous envoyer la Note |cFFFFD100%s|r, mais elle est trop proche de |cFFFFD100%q|r."
METAMAPNOTES_QUICKNOTE_NOTETONEAR = "Cr\195\169ation impossible. Vous \195\170tes trop proche de |cFFFFD100%s|r."
METAMAPNOTES_QUICKNOTE_NOPOSITION = "Cr\195\169ation impossible. Impossible de r\195\169cup\195\169rer votre position actuelle."
METAMAPNOTES_QUICKNOTE_DEFAULTNAME = "Note Rapide"
METAMAPNOTES_MININOTE_DEFAULTNAME = "MiniNote"
METAMAPNOTES_QUICKNOTE_OK = "Cr\195\169\195\169 dans |cFFFFD100%s|r."
METAMAPNOTES_QUICKNOTE_TOOMANY = "Il y a d\195\169ja trop de Notes dans |cFFFFD100%s|r."
METAMAPNOTES_DELETED_BY_NAME = "A supprim\195\169 tout le Notes de carte avec le cr\195\169ateur |cFFFFD100%s|r et le nom |cFFFFD100%s|r."
METAMAPNOTES_DELETED_BY_CREATOR = "A supprim\195\169 tout le Notes de carte avec le cr\195\169ateur |cFFFFD100%s|r."
METAMAPNOTES_QUICKTLOC_NOTETONEAR = "Cr\195\169ation impossible. Trop proche de |cFFFFD100%s|r."
METAMAPNOTES_QUICKTLOC_NOZONE = "Cr\195\169ation impossible. Impossible de r\195\169cup\195\169rer la zone actuelle."
METAMAPNOTES_QUICKTLOC_NOARGUMENT = "Utilisation: \226\128\153/quicktloc xx,yy [icone] [titre]\226\128\153."
METAMAPNOTES_SETMININOTE = "Utiliser comme MiniNote"
METAMAPNOTES_THOTTBOTLOC = "Thottbot Position"
METAMAPNOTES_PARTYNOTE = "Note de groupe"
METAMAPNOTES_SETCOORDS = "Coords (xx,yy):"
METAMAPNOTES_MNTLOC = "Virtuel"
METAMAPNOTES_MNTLOC_INFO = "Cr\195\169er une note virtuel. Save on map of choice to bind."
METAMAPNOTES_MNTLOC_SET = "Note virtuel cr\195\169e sur la carte du monde."

METAMAPNOTES_CONVERSION_COMPLETE = "Changez complet. Veuillez v\195\169rifier vos notes. Ne courez pas cette fonction encore!"

-- Drop Down Menu
METAMAPNOTES_SHOWNOTES = "Montrez Les Notes"
METAMAPNOTES_DROPDOWNTITLE = "Notes de carte"
METAMAPNOTES_DROPDOWNMENUTEXT = "Options"

-- Buttons, Headers, Various Text
METAKB_AUTHOR = "Comics UI"
METAKB_MAIN_HEADER = "Base de donn\195\169es de World of WarCraft"
METAKB_OPTIONS_HEADER = "MetaKB Options"
METAKB_ADDON_DESCRIPTION = "A moused-over NPC/mob database."
METAKB_DOWNLOAD_SITES = "Voir le fichier README"
METAKB_MOB_LEVEL = "Level"
METAKB_MAPNOTES_NW_BOUND = "Limite NO"
METAKB_MAPNOTES_NE_BOUND = "Limite NE"
METAKB_MAPNOTES_SE_BOUND = "Limite SE"
METAKB_MAPNOTES_SW_BOUND = "Limite SO"
METAKB_MAPNOTES_CENTER = "Centre"
METAKB_SHOW_ONLY_LOCAL_NPCS = "PNJ Locaux"
METAKB_SHOW_UPDATES = "Afficher la mises \195\160 jour"
METAKB_BOUNDING_BOX = "Notes de carte centr\195\169e"
METAKB_SEARCH_BOX = "Recherche"
METAKB_CLOSE_BUTTON = "Fin"
METAKB_OPTIONS_BUTTON = "Options"
METAKB_REFRESH_BUTTON = "Actualiser"
METAKB_CLEAR_NOTES_BUTTON = "Effacer les notes"
METAKB_AUTO_TRACK = "Auto Tracking";
METAKB_USE_KB = "Ajouter dans la Base";
METAKB_TARGET_NOTE = "Ajouter sur la carte";
METAKB_OPTIONS_RANGETEXT = "Distance de ciblage:";

METAKB_HEADER_NAME = "Nom";
METAKB_HEADER_DESC = "Description";
METAKB_HEADER_LEVEL = "Level";
METAKB_HEADER_LOCATION = "Localisation";

-- Tooltips
METAKB_QUICK_HELP = "Aide"
METAKB_QUICK_HELP_1 = "1. Click Gauche pour ajouter une note"
METAKB_QUICK_HELP_2 = "2. Click Droit pour effacer une note"
METAKB_QUICK_HELP_3 = "3. <Ctrl>+<Shift>+Click Droit pour effacer de la base"
METAKB_QUICK_HELP_4 = "4. <Shift>+Click Gauche pour ajouter des infos"
METAKB_QUICK_HELP_5 = "5. Leaving the search box blank returns all records"
METAKB_SHOW_ONLY_LOCAL_NPCS_HELP = "Seul les mobs/NPCs de votre zone actuelle s\'affiche."
METAKB_SHOW_UPDATES_HELP = "Les modifications de la base seront annonc\195\169es dans le chat."
METAKB_BOUNDING_BOX_HELP = "Un Click Gauche ajoute une notes sous forme d'un point centr\195\169 "..
    "au milieu de 4 autes points reli\195\169s. Sinon seul le point du centre s\'affiche "..
    "."
METAKB_AUTO_TRACK_HELP = "Ajout automatique des PNJ/Mob au passage de la souris";
METAKB_USE_KB_HELP = "Ajout de nouvelles cibles dans la base";
METAKB_TARGET_NOTE_HELP = "Ajout de nouvelles cibles sur la carte. Peut \195\170tre edit\195\169 "..
													"en utilisant la combinaison: <CTRL>+<Keybinding>.";

-- Informational
METAKB_NO_NPC_MOB_FOUND = "Aucun NPCs/mobs  trouv\195\169 pour: \"%s\""
METAKB_REMOVED_FROM_DATABASE = "Enlev\195\169 \"%s\" dans \"%s\" de la base de donn\195\169es"
METAKB_DISCOVERED_UNIT = "D\195\169couvert %s!"
METAKB_ADDED_UNIT_IN_ZONE = "Suppl\195\169mentaire %s in %s"
METAKB_UPDATED_MINMAX_XY = "Mis \195\160 jour Min/Max X/Y pour %s dans %s"
METAKB_UPDATED_INFO = "Information mise \195\160 jour pour %s dans %s"
METAKB_IMPORT_SUCCESSFUL = "MetaKB_ImportData fusionn\195\169 avec succ\195\168s, suppl\195\169mentaire %u entr\195\169es et mis \195\160 jour %u"
METAKB_STATS_LINE = "%u NPCs dans %u Zones/Instances"
METAKB_NOTARGET = "Vous devez avoir une cible pour l\'enregistrer."

--- French 1.4.2 ZoneShift
--[[
MetaMapNotes_ZoneShiftOld = {
    [0] = { [0] = 0 },
    [1] = { 1, 2, 20, 3, 4, 5, 6, 8, 9, 17, 7, 18, 14, 10, 11, 12, 13, 15, 16, 19, 21 },
    [2] = { 2, 3, 4, 17, 6, 11, 7, 8, 10, 16, 15, 12, 20, 13, 19, 1, 14, 9, 23, 21, 5, 22, 18, 24, 25, 26 },
}
]]

-- French 1.5.0 Invalid ZoneShift
--[[
MetaMapNotes_ZoneShiftOld = {
    [0] = { [0] = 0 },
    [1] = { 1, 2, 17, 4, 6, 5, 11, 8, 7, 15, 13, 14, 16, 9, 18, 19, 10, 12, 20, 3, 21 },
    [2] = { 19, 9, 23, 22, 21, 3, 5, 1, 15, 6, 4, 10, 14, 11, 8, 7, 2, 25, 17, 12, 20, 24, 16, 18, 13, 26 },
}
]]

-- French 1.5.0 ZoneShift
MetaMapNotes_ZoneShift = {
    [0] = { [0] = 0 },
    [1] = { 1, 2, 20, 4, 6, 5, 9, 8, 14, 17, 7, 18, 11, 12, 10, 13, 3, 15, 16, 19, 21 },
    [2] = { 8, 17, 6, 11, 7, 10, 16, 15, 2, 12, 14, 20, 25, 13, 9, 23, 19, 24, 1, 21, 5, 4, 3, 22, 18, 26 },
}

MetaMapNotes_ZoneShift[1][0] = 0
MetaMapNotes_ZoneShift[2][0] = 0

METAMAPNOTES_WARSONGGULCH = "Goulet des Warsong"
METAMAPNOTES_ALTERACVALLEY = "Vall\195\169e d\226\128\153Alterac"
METAMAPNOTES_ARATHIBASIN = "Bassin d\226\128\153Arathi"




MetaMap_Data = {
[1] = {
["ZoneName"] = "Profondeurs de Brassenoire",
["Location"] = "Ashenvale",
["LevelRange"] = "20-27",
["PlayerLimit"] = "10"
},
[2] = {
["ZoneName"] = "Profondeurs de Blackrock",
["Location"] = "Montagne de Blackrock",
["LevelRange"] = "48-56",
["PlayerLimit"] = "10"
},
[3] = {
["ZoneName"] = "Pic Blackrock (inf\195\169rieur)",
["Location"] = "Montagne de Blackrock",
["LevelRange"] = "53-60",
["PlayerLimit"] = "15"
},
[4] = {
["ZoneName"] = "Pic Blackrock (sup\195\169rieur)",
["Location"] = "Montagne de Blackrock",
["LevelRange"] = "53-60",
["PlayerLimit"] = "15"
},
[5] = {
["ZoneName"] = "Repaire de l\'Aile noire",
["Location"] = "Montagne de Blackrock",
["LevelRange"] = "60+",
["PlayerLimit"] = "40"
},
[6] = {
["ZoneName"] = "Hache-Tripes",
["Location"] = "Feralas",
["LevelRange"] = "56-60",
["PlayerLimit"] = "5"
},
[7] = {
["ZoneName"] = "Hache-Tripes (Est)",
["Location"] = "Feralas",
["LevelRange"] = "56-60",
["PlayerLimit"] = "5"
},
[8] = {
["ZoneName"] = "Hache-Tripes (Nord)",
["Location"] = "Feralas",
["LevelRange"] = "56-60",
["PlayerLimit"] = "5"
},
[9] = {
["ZoneName"] = "Hache-Tripes (Ouest)",
["Location"] = "Feralas",
["LevelRange"] = "56-60",
["PlayerLimit"] = "5"
},
[10] = {
["ZoneName"] = "Gnomeregan",
["Location"] = "Dun Morogh",
["LevelRange"] = "24-33",
["PlayerLimit"] = "10"
},
[11] = {
["ZoneName"] = "Maraudon",
["Location"] = "Desolace",
["LevelRange"] = "40-49",
["PlayerLimit"] = "10"
},
[12] = {
["ZoneName"] = "C\197\147ur du Magma",
["Location"] = "Profondeurs de Blackrock",
["LevelRange"] = "60+",
["PlayerLimit"] = "40"
},
[13] = {
["ZoneName"] = "Repaire d\'Onyxia",
["Location"] = "Mar\195\169cage d\'Aprefange",
["LevelRange"] = "60+",
["PlayerLimit"] = "40"
},
[14] = {
["ZoneName"] = "Gouffre de Ragefeu",
["Location"] = "Orgrimmar",
["LevelRange"] = "13-15",
["PlayerLimit"] = "10"
},
[15] = {
["ZoneName"] = "Souilles de Tranchebauge",
["Location"] = "Les Tarides",
["LevelRange"] = "35-40",
["PlayerLimit"] = "10"
},
[16] = {
["ZoneName"] = "Kraal de Tranchebauge",
["Location"] = "Les Tarides",
["LevelRange"] = "25-35",
["PlayerLimit"] = "10"
},
[17] = {
["ZoneName"] = "Monast\195\168re \195\169carlate",
["Location"] = "Clairi\195\168re de Tirisfal",
["LevelRange"] = "30-40",
["PlayerLimit"] = "10"
},
[18] = {
["ZoneName"] = "Scholomance",
["Location"] = "Maleterres de l\'Ouest",
["LevelRange"] = "56-60",
["PlayerLimit"] = "10"
},
[19] = {
["ZoneName"] = "Donjon d\'Ombrecroc",
["Location"] = "For\195\170t des Pins Argent\195\169s",
["LevelRange"] = "18-25",
["PlayerLimit"] = "10"
},
[20] = {
["ZoneName"] = "Stratholme",
["Location"] = "Maleterres de l\'Est",
["LevelRange"] = "55-60",
["PlayerLimit"] = "10"
},
[21] = {
["ZoneName"] = "Les Mortemines",
["Location"] = "Marche de l\'Ouest",
["LevelRange"] = "15-20",
["PlayerLimit"] = "10"
},
[22] = {
["ZoneName"] = "La Prison",
["Location"] = "Stormwind",
["LevelRange"] = "23-26",
["PlayerLimit"] = "10"
},
[23] = {
["ZoneName"] = "Le temple d\'Atal\'Hakkar",
["Location"] = "Marais des chagrins",
["LevelRange"] = "44-50",
["PlayerLimit"] = "10"
},
[24] = {
["ZoneName"] = "Uldaman",
["Location"] = "Terres ingrates",
["LevelRange"] = "35-45",
["PlayerLimit"] = "10"
},
[25] = {
["ZoneName"] = "Cavernes des lamentations",
["Location"] = "Les Tarides",
["LevelRange"] = "15-21",
["PlayerLimit"] = "10"
},
[26] = {
["ZoneName"] = "Zul'Farrak",
["Location"] = "D\195\169sert de Tanaris",
["LevelRange"] = "43-47",
["PlayerLimit"] = "10"
},
[27] = {
["ZoneName"] = "Zul'Gurub",
["Location"] = "Vall\195\169e de Strangleronce",
["LevelRange"] = "60+",
["PlayerLimit"] = "20"
},
[28] = {
["ZoneName"] = "Ahn'Qiraj",
["Location"] = "Silithus",
["LevelRange"] = "60+",
["PlayerLimit"] = "40"
},
[29] = {
["ZoneName"] = "Ruins Of Ahn'Qiraj",
["Location"] = "Silithus",
["LevelRange"] = "60+",
["PlayerLimit"] = "20"
}
};

MetaKB_ZoneIdentifiers = {
    [1] = {
        ["z"] = "Montagnes d\226\128\153Alterac",
        ["i"] = 1,
    },
    [2] = {
        ["z"] = "Hautes-terres d\226\128\153Arathi",
        ["i"] = 2,
    },
    [3] = {
        ["z"] = "Ashenvale",
        ["i"] = 3,
    },
    [4] = {
        ["z"] = "Azshara",
        ["i"] = 4,
    },
    [5] = {
        ["z"] = "Badlands",
        ["i"] = 5,
    },
    [6] = {
        ["z"] = "Blasted Lands",
        ["i"] = 6,
    },
    [7] = {
        ["z"] = "Steppes ardentes",
        ["i"] = 7,
    },
    [8] = {
        ["z"] = "Sombrivage",
        ["i"] = 8,
    },
    [9] = {
        ["z"] = "Darnassus",
        ["i"] = 9,
    },
    [10] = {
        ["z"] = "Col de Deadwind",
        ["i"] = 10,
    },
    [11] = {
        ["z"] = "Desolace",
        ["i"] = 11,
    },
    [12] = {
        ["z"] = "Dun Morogh",
        ["i"] = 12,
    },
    [13] = {
        ["z"] = "Durotar",
        ["i"] = 13,
    },
    [14] = {
        ["z"] = "Bois de la p\195\169nombre",
        ["i"] = 14,
    },
    [15] = {
        ["z"] = "Marais de Dustwallow",
        ["i"] = 15,
    },
    [16] = {
        ["z"] = "Plaguelands de l\226\128\153est",
        ["i"] = 16,
    },
    [17] = {
        ["z"] = "For\195\170t d\226\128\153Elwynn",
        ["i"] = 17,
    },
    [18] = {
        ["z"] = "Gangrebois",
        ["i"] = 18,
    },
    [19] = {
        ["z"] = "Feralas",
        ["i"] = 19,
    },
    [20] = {
        ["z"] = "Contreforts d\226\128\153Hillsbrad",
        ["i"] = 20,
    },
    [21] = {
        ["z"] = "Ironforge",
        ["i"] = 21,
    },
    [22] = {
        ["z"] = "Loch Modan",
        ["i"] = 22,
    },
    [23] = {
        ["z"] = "Reflet-de-Lune",
        ["i"] = 23,
    },
    [24] = {
        ["z"] = "Mulgore",
        ["i"] = 24,
    },
    [25] = {
        ["z"] = "Orgrimmar",
        ["i"] = 25,
    },
    [26] = {
        ["z"] = "Les Carmines",
        ["i"] = 26,
    },
    [27] = {
        ["z"] = "Gorge des Vents br\195\187lants",
        ["i"] = 27,
    },
    [28] = {
        ["z"] = "Silithus",
        ["i"] = 28,
    },
    [29] = {
        ["z"] = "For\195\170t des Pins argent\195\169s",
        ["i"] = 29,
    },
    [30] = {
        ["z"] = "Les Serres-Rocheuses",
        ["i"] = 30,
    },
    [31] = {
        ["z"] = "Cit\195\169 de Stormwind",
        ["i"] = 31,
    },
    [32] = {
        ["z"] = "Vall\195\169e de Stranglethorn",
        ["i"] = 32,
    },
    [33] = {
        ["z"] = "Marais des lamentations",
        ["i"] = 33,
    },
    [34] = {
        ["z"] = "Tanaris",
        ["i"] = 34,
    },
    [35] = {
        ["z"] = "Teldrassil",
        ["i"] = 35,
    },
    [36] = {
        ["z"] = "Les Tarides",
        ["i"] = 36,
    },
    [37] = {
        ["z"] = "Les Hinterlands",
        ["i"] = 37,
    },
    [38] = {
        ["z"] = "Mille pointes",
        ["i"] = 38,
    },
    [39] = {
        ["z"] = "Thunder Bluff",
        ["i"] = 39,
    },
    [40] = {
        ["z"] = "Prairies de Tirisfal",
        ["i"] = 40,
    },
    [41] = {
        ["z"] = "Undercity",
        ["i"] = 41,
    },
    [42] = {
        ["z"] = "Crat\195\168re d\226\128\153Un\226\128\153Goro",
        ["i"] = 42,
    },
    [43] = {
        ["z"] = "Plaguelands de l\226\128\153ouest",
        ["i"] = 43,
    },
    [44] = {
        ["z"] = "Marche de l\226\128\153Ouest",
        ["i"] = 44,
    },
    [45] = {
        ["z"] = "Les Paluns",
        ["i"] = 45,
    },
    [46] = {
        ["z"] = "Winterspring",
        ["i"] = 46,
    },

-- Instances and other special zones
    [300] = {
        ["z"] = "Tram des profondeurs",
        ["i"] = 47,
    },
    [301] = {
        ["z"] = "Les mortemines",
        ["i"] = 48,
    },
    [302] = {
        ["z"] = "Profondeurs de Brassenoire",
        ["i"] = 49,
    },
    [303] = {
        ["z"] = "Gouffre de Ragefeu",
        ["i"] = 50,
    },
    [304] = {
        ["z"] = "Souilles de Tranchebauge",
        ["i"] = 51,
    },
    [305] = {
        ["z"] = "Kraal de Tranchebauge",
        ["i"] = 52,
    },
    [306] = {
        ["z"] = "Monast\195\168re Ecarlate",
        ["i"] = 53,
    },
    [307] = {
        ["z"] = "Donjon d\226\128\153Ombrecroc",
        ["i"] = 54,
    },
    [308] = {
        ["z"] = "Cavernes des lamentations",
        ["i"] = 55,
    },
    [309] = {
        ["z"] = "La Prison",
        ["i"] = 56,
    },
    [310] = {
        ["z"] = "Maraudon",
        ["i"] = 310,
    },
    [311] = {
        ["z"] = "Uldaman",
        ["i"] = 311,
    },
    [312] = {
        ["z"] = "Gnomeregan",
        ["i"] = 312,
    },
    [313] = {
        ["z"] = "Zul\226\128\153Gurub",
        ["i"] = 313,
    },
    [314] = {
        ["z"] = "Stratholme",
        ["i"] = 314,
    },
    [315] = {
        ["z"] = "Scholomance",
        ["i"] = 315,
    },
    [316] = {
        ["z"] = "Zul\226\128\153Farrak",
        ["i"] = 316,
    },
    [317] = {
        ["z"] = "C\197\147ur du Magma",
        ["i"] = 317,
    },
    [318] = {
        ["z"] = "Montagnes Blackrock",
        ["i"] = 318,
    },
    [319] = {
        ["z"] = "Repaire d\226\128\153Onyxia",
        ["i"] = 319,
    },
    [320] = {
        ["z"] = "Repaire de l\226\128\153Aile noire",
        ["i"] = 320,
    },
    [321] = {
        ["z"] = "Profondeurs de Blackrock",
        ["i"] = 321,
    },
    [322] = {
        ["z"] = "Hache-Tripes",
        ["i"] = 322,
    },
    [323] = {
        ["z"] = "Le Temple d\226\128\153Atal\226\128\153Hakkar",
        ["i"] = 323,
    },
    [324] = {
        ["z"] = "Hall des Blackhand",
        ["i"] = 324,
    },
    [325] = {
        ["z"] = "Bassin d\226\128\153Arathi",
        ["i"] = 325,
    },
    [326] = {
        ["z"] = "Vall\195\169e d\226\128\153Alterac",
        ["i"] = 326,
    },
    [327] = {
        ["z"] = "Goulet des Warsong",
        ["i"] = 327,
    },
    [328] = {
        ["z"] = "The Temple Of Ahn'Qiraj",
        ["i"] = 328,
    },

-- GetZoneText conversions/Renamed zones these must come at the end of the list so when we lookup a
-- name from the identifier we find the preferred GetRealZoneText name first.  These indices are
-- treated as invalid so they don't need to be the same in each localization file.

};

end
