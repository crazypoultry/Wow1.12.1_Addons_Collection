if (GetLocale() == "esES") then

-- Spanish Data for MetaMap by Fili

-- General
METAMAP_CATEGORY = "Interfaz";
METAMAP_SUBTITLE = "Mod MapaMundi";
METAMAP_DESC = "MetaMap es una modificaci\195\179n del MapaMundi Estandar.";
METAMAP_OPTIONS_BUTTON = "Opciones";
METAMAP_STRING_LOCATION = "Locazaci\195\179on";
METAMAP_STRING_LEVELRANGE = "Rango de Nivel";
METAMAP_STRING_PLAYERLIMIT = "Limite Jugador";
METAMAP_MAPLIST_INFO = "Click-Izq: Nota Ping\nClick-Dcho: Edita Nota\nCTRL+Click: Cuadro de Bot\195\173n";
METAMAP_BUTTON_TOOLTIP1 = "Click-Izq. Muestra Mapa";
METAMAP_BUTTON_TOOLTIP2 = "Click-Dcho. para Opciones";
METAMAP_OPTIONS_TITLE = "Opciones MetaMap";
METAMAP_KB_TEXT = "Base de Datos Conocimiento"
METAMAP_NBK_TEXT = "Note Book";
METAMAP_HINT = "Consejo: Click-Izq. Abre MetaMap.\nClick-Dcho para opciones";
METAMAP_NOTES_SHOWN = "Notas"
METAMAP_LINES_SHOWN = "L\195\173neas"
METAMAP_INFOLINE_HINT1 = "Click-Izq para cambiar L\195\173neaColoquial";
METAMAP_INFOLINE_HINT2 = "Click-Dcho para cambiar ListaLateral";
METAMAP_SEARCHTEXT = "Search";

BINDING_HEADER_METAMAP_TITLE = "MetaMap";
BINDING_NAME_METAMAP_MAPTOGGLE = "Cambia a WorldMap";
BINDING_NAME_METAMAP_MAPTOGGLE1 = "MapaMundi Modo 1";
BINDING_NAME_METAMAP_MAPTOGGLE2 = "MapaMundi Modo 2";
BINDING_NAME_METAMAP_FSTOGGLE = "Pantalla Completa";
BINDING_NAME_METAMAP_SAVESET = "Modo Mapa";
BINDING_NAME_METAMAP_KB = "Mostrar Base de Datos";
BINDING_NAME_METAMAP_KB_TARGET_UNIT = "Captura Detalles Objetivo";
BINDING_NAME_METAMAP_QST = "Toggle Quest Log"
BINDING_NAME_METAMAP_QUICKNOTE = "Nota Rapida";

-- Commands
METAMAPNOTES_ENABLE_COMMANDS = { "/mapnote" }
METAMAPNOTES_ONENOTE_COMMANDS = { "/onenote", "/allowonenote", "/aon" }
METAMAPNOTES_MININOTE_COMMANDS = { "/nextmininote", "/nmn" }
METAMAPNOTES_MININOTEONLY_COMMANDS = { "/nextmininoteonly", "/nmno" }
METAMAPNOTES_MININOTEOFF_COMMANDS = { "/mininoteoff", "/mno" }
METAMAPNOTES_QUICKNOTE_COMMANDS = { "/quicknote", "/qnote", "/qtloc" }

-- Interface Configuration
METAMAP_MENU_MODE = "Men\195\186 al Click";
METAMAP_OPTIONS_EXT = "Opciones Extendidas";
METAMAP_OPTIONS_COORDS = "Coordenadas Principales";
METAMAP_OPTIONS_MINICOORDS = "Coordenadas Minimapa";
METAMAP_OPTIONS_SHOWAUTHOR = "Notas autor"
METAMAP_OPTIONS_SHOWNOTES = "Filtro Notas"
METAMAP_OPTIONS_FILTERON = "Muestra Todo"
METAMAP_OPTIONS_FILTEROFF = "Oculta Todo"
METAMAP_OPTIONS_SHOWBUT = "Bot\195\179n Minimapa";
METAMAP_OPTIONS_AUTOSEL = "Autoajusta Texto Cuadro de Texto";
METAMAP_OPTIONS_BUTPOS = "Posici\195\179n Bot\195\179n";
METAMAP_OPTIONS_POI = "Establece POI en nueva zona (Puntos de interes)";
METAMAP_OPTIONS_LISTCOLORS = "Usa Lista Lateral coloreada";
METAMAP_OPTIONS_ZONEHEADER = "Muestra informaci\95\179n de zona en cabecero del MapaMundi";
METAMAP_OPTIONS_MOZZ = "Mostrar Inexplorado";
METAMAP_OPTIONS_TRANS = "Transparencia Mapa";
METAMAP_OPTIONS_SHADER = "Tonalidad Sombreado";
METAMAP_OPTIONS_SHADESET = "Tonalidad sombreado Instancia";
METAMAP_OPTIONS_FWM = "Areas Inexploradas";
METAMAP_OPTIONS_DONE = "Hecho";
METAMAP_FLIGHTMAP_OPTIONS = "Opciones FlightMap";
METAMAP_GATHERER_OPTIONS = "Opciones Gatherer";
METAMAP_BWP_OPTIONS = "Punto del Camino";
METAMAP_OPTIONS_SCALE = "Escala Mapa";
METAMAP_OPTIONS_TTSCALE = "Escala Cuadro Dialogo";
METAMAP_OPTIONS_SAVESET = "Modo Mostrar Mapa";
METAMAP_OPTIONS_USEMAPMOD = "Crear notas con MapMod";
METAMAP_ACTION_MODE = "Clicks a traves del mapa";
METAMAPLIST_SORTED = "Lista Clasificada";
METAMAPLIST_UNSORTED = "Lista No Clasificada";
METAMAP_CLOSE_BUTTON ="Cierra";

METAMAP_NOMODULE = "module is missing or not enabled!";
METAMAP_MODULETEXT = "Always load the following modules when starting a new session";
METAMAP_QST_TEXT = "Quest Log";
METAMAP_FWM_TEXT = "Show FWM Options";

METAMAP_LOADIMPORTS_BUTTON = "Carga M\195\179dulo Importaci\195\179n";
METAMAP_LOADEXPORTS_BUTTON = "Exporta Fichero de usuario";
METAMAP_IMPORTS_HEADER = "Importa/Exporta M\195\179dulo";
METAMAP_RELOADUI_BUTTON = "Recarga UI";
METAMAP_IMPORT_BUTTON = "Importa";
METAMAP_IMPORT_INSTANCE = "Notas Instancia";
METAMAP_IMPORT_INSTANCE_INFO = "Esto importar\195\161 cualquier nota creada en los mapas de instancia. El fichero 'MetaMapData.lua' debe existir en el directorio MetaMapCVT, y contener datos en el formato correcto. Este fichero esta incluido como estandar con MetaMap";
METAMAP_IMPORT_NOTES = "Map notes";
METAMAP_IMPORT_NOTES_INFO = "Esto importar\195\161 notas creadas con MapNotes/MapMod a MetaMap. El fichero 'MapNotes.lua'/'CT_MapMod.lua' debe existir en el directorio MetaMapCVT,y contener datos en el formato correcto. Esta fichero original se puede encontrar en la carpeta 'SavedVariables' si has usado anteriormente el addons MapNotes/MapMod.";
METAMAP_IMPORT_KB = "Fichero de Usario";
METAMAP_IMPORT_KB_INFO = "Esto importar\195\161 fichero de notas de usuario KB a MetaMap. El fichero 'MetaMapEXP.lua' debe existir en el directorio MetaMapCVT , y debe contener datos en el formato correcto. Esto es un fichero preparado especialmente por datos existentes de usuario. Lee Readme para crear un formato correcto.";
METAMAP_IMPORT_BLT = "Datos BLT";
METAMAP_IMPORT_BLT_INFO = "Esto importar\195\161 las listas de Botin de Jefes. El fichero 'MetaMapBLTdata.lua' debe existir en el directorio MetaMapCVT, y contener datos en el formato correcto. Adicionalmente importara datos de AtlasLoot, so los ficheros de localizaci\195\179n de AtlasLoot se encuentran en el directorio de MetaMapCVT.";
METAMAP_IMPORTS_INFO = "Recarga el Interfaz de Usuario despues de importer, para asegurar que todos los datos son borrados de la memoria.";

METAMAPEXP_KB_EXPORTED = "Exportadas |cffffffff%s|r \195\186nicas KB entradas a SavedVariables\\MetaMapEXP.lua";
METAMAPEXP_NOTES_EXPORTED = "Exportadas |cffffffff%s|r \195\186nicas entradas de Notas a SavedVariables\\MetaMapEXP.lua";
METAMAPEXP_QST_EXPORTED = "Exported |cffffffff%s|r unique QST entries to SavedVariables\\MetaMapEXP.lua";

METAMAPFWM_RETAIN = "FWM siempre encendido";
METAMAPFWM_USECOLOR = "Colorea \195\161reas inexploradas";
METAMAPFWM_SETCOLOR = "Establece color";

METAKB_LOAD_MODULE = "Carga M\195\179dulo";
METAMAP_NOKBDATA = "M\195\179dulo MetaMapWKB no cargado – datos KB no procesados";

METAMAPBLT_CONFIRM_IMPORT = "Por favor selecciona los datos deseados para importar";
METAMAPBLT_CONFIRM_EXPORT = "Por favor selecciona los datos deseados para exportar";
METAMAPBLT_IMPORT_DONE = "MetaMapBLT import\195\179 datos satisfactoriamente";
METAMAPBLT_IMPORT_FAIL = "Datos seleccionados no disponibles - No se importaron datos";
METAMAPBLT_UPDATE_DONE = "MetaMapBLT actualizaddo con la \195\186ltima informaci\195\179n";
METAMAPBLT_IMPORT_TIMEOUT = "Fuera de Tiempo – No se importaron datos";
METAMAPBLT_HINT = "Shift+Click: Vincula Objeto - CTRL+Click: Vestidor";
METAMAPBLT_NO_INFO = "No hay informaci\195\179n disponible para este objeto";
METAMAPBLT_NO_DATA = "Datos no disponibles aun o no imporados";
METAMAPBLT_CLASS_SELECT = "Selecciona abajo la clase requerida";

METAMAPZSM_NEW_VERSION = "Nueva versi\195\179n de zona detectada. Por favor selecciona conversi\195\179n correcta abajo";
METAMAPZSM_NO_SHIFT = "Cambio de zona al dia. No requerida conversi\195\179n";
METAMAPZSM_NO_DETECT = "No detectada informaci\195\179n actualizada de cambios de zona";
METAMAPZSM_UPDATE_DONE = "MetaMapZSM Cambio de Zona actualizado a versi\195\179n |cFFFFD100%s|r";
METAMAPZSM_SKIP_SHIFT = "Saltar al siguiente cambio de zona ya esta cambiado";
METAMAPZSM_UPDATE_VERSION = "Actualiza versi\195\179n";
METAMAPZSM_UPDATE_INFO = "Usa la opci\195\179n 'Actualiza Versi\195\179n' si ningun cambio de zona anterior necesita ser aplicado";

METAMAPBKP_BACKUP = "Copia de Seguridad";
METAMAPBKP_RESTORE = "Datos de Restauraci\195\179n";
METAMAPBKP_INFO = "Copia de Seguridad guardar\195\161 todos los datos de Mapnotes, Lineas Mapnote, y datos MetaKB a un archivo separado. Escoge restauraci\195\179n para reemplazar los datos actuales con los ultimos guardados.";
METAMAPBKP_BACKUP_DONE = "Copia de Seguridad Satisfactoria";
METAMAPBKP_RESTORE_DONE = "Restauraci\195\179n satisfactoria";
METAMAPBKP_RESTORE_FAIL = "No data found to restore";

METAMAPNOTES_WORLDMAP_HELP_1 = "Click-Dcho En Mapa Para Zoom Out"
METAMAPNOTES_WORLDMAP_HELP_2 = "<Control>+Click-Izq. para crear nota"
METAMAPNOTES_CLICK_ON_SECOND_NOTE = "Escoge Segunda Nota Para Mover/Limpiar una Linea"
METAMAPNOTES_CLICK_ON_LOCATION = "Click-Izq. En el mapa para nueva nota de localizaci\195\179n"

METAMAPNOTES_NEW_NOTE = "Crear Nota"
METAMAPNOTES_MININOTE_OFF = "Apaga MiniNota"
METAMAPNOTES_OPTIONS_TEXT = "Opciones Notas"
METAMAPNOTES_CANCEL = "Cancelar"
METAMAPNOTES_EDIT_NOTE = "Edita Nota"
METAMAPNOTES_MININOTE_ON = "MiniNota"
METAMAPNOTES_SEND_NOTE = "Envia Nota"
METAMAPNOTES_TOGGLELINE = "Cambia Linea"
METAMAPNOTES_MOVE_NOTE = "Mueve Nota";
METAMAPNOTES_DELETE_NOTE = "Borra Nota"
METAMAPNOTES_SAVE_NOTE = "Guarda"
METAMAP_NEWNOTE = "New";
METAMAPNOTES_EDIT_TITLE = "Titulo (requerido):"
METAMAPNOTES_EDIT_INFO1 = "Linea Info 1 (opcional):"
METAMAPNOTES_EDIT_INFO2 = "Linea Info 2 (opcional):"
METAMAPNOTES_EDIT_CREATOR = "Creador (opcional – en blanco esconde):"

METAMAPNOTES_SEND_MENU = "Env\195\173a Nota"
METAMAPNOTES_SLASHCOMMAND = "Cambia Modo"
METAMAPNOTES_SEND_TIP = "Estas notas pueden ser recibidas por todos los usuarios de MEtaMap"
METAMAPNOTES_SEND_PLAYER = "Escribe Nombre Jugador:"
METAMAPNOTES_SENDTOPLAYER = "Env\195\173a a Jugador"
METAMAPNOTES_SENDTOPARTY = "Env\195\173a a Banda"
METAMAPNOTES_SHOWSEND = "Cambia Modo"
METAMAPNOTES_SEND_SLASHTITLE = "Consigue Comando slash:"
METAMAPNOTES_SEND_SLASHTIP = "Resalta esto y usa CTRL+C para copiar al portapapeles\n(asi podras escribirlo en un foro por ejemplo)"
METAMAPNOTES_SEND_SLASHCOMMAND = "/Command:"
METAMAPNOTES_PARTYSENT = "Nota de Grupo enviada a todos los miembros de la Grupo.";
METAMAPNOTES_RAIDSENT = "Nota de Banda enviada a todos los miembros de la Banda.";
METAMAPNOTES_NOPARTY = "No est\195\161 actualmente en Grupo o Banda.";

METAMAPNOTES_OWNNOTES = "Muestra Notas creadas por tu personaje"
METAMAPNOTES_OTHERNOTES = "Muestra Notas recibidas de otros personajes"
METAMAPNOTES_HIGHLIGHT_LASTCREATED = "Resalta \195\186ltima nota creada en |cFFFF0000red|r"
METAMAPNOTES_HIGHLIGHT_MININOTE = "Resalta nota seleccionada como MiniNote en |cFF6666FFblue|r"
METAMAPNOTES_ACCEPTINCOMING = "Acepta notas entrantes de otros jugadores"
METAMAPNOTES_AUTOPARTYASMININOTE = "Autom\195\161ticamente establece como Mininota las notas de Banda."
METAMAPNOTES_ZONESEARCH_TEXT = "Borra Notas para |cffffffff%s|r del creador:"
METAMAPNOTES_ZONESEARCH_TEXTHINT = "Consejo: Abre Mapamundi y selecciona la parte que quieres borrar";
METAMAPNOTES_BATCHDELETE = "Esto borrar\195\161 todas las notas para |cFFFFD100%s|r con creador de |cFFFFD100%s|r.";
METAMAPNOTES_DELETED_BY_NAME = "Borradas notas seleccionadas del creador |cFFFFD100%s|r y nombre |cFFFFD100%s|r."
METAMAPNOTES_DELETED_BY_CREATOR = "Borradas todas las notas del creador |cFFFFD100%s|r."
METAMAPNOTES_DELETED_BY_ZONE = "Borradas todas las notas para |cFFFFD100%s|r del creador |cFFFFD100%s|r."


METAMAPNOTES_CREATEDBY = "Creado por"
METAMAPNOTES_CHAT_COMMAND_ENABLE_INFO = "Este commando te permite insertar notas de una pagina web por ejemplo."
METAMAPNOTES_CHAT_COMMAND_ONENOTE_INFO = "Sobreescribes los ajustes de opciones, asi que la siguiente nota sea aceptada."
METAMAPNOTES_CHAT_COMMAND_MININOTE_INFO = "Muestra la siguiente nota recibida como MiniNote (e insertala en el mapa):"
METAMAPNOTES_CHAT_COMMAND_MININOTEONLY_INFO = "Muestra la siguiente nota recibida como Mininota solamente (no insertar en mapa)."
METAMAPNOTES_CHAT_COMMAND_MININOTEOFF_INFO = "Apaga las Mininotas."
METAMAPNOTES_CHAT_COMMAND_QUICKNOTE = "Crea una nota en la Posic.\195\179n especifica del mapa."
METAMAPNOTES_MAPNOTEHELP = "Este comando solo se usa para insertar una nota"
METAMAPNOTES_ONENOTE_OFF = "Permite una Nota: OFF"
METAMAPNOTES_ONENOTE_ON = "Permite una Nota: ON"
METAMAPNOTES_MININOTE_SHOW_0 = "Pr\195\179ximo como MiniNote: OFF"
METAMAPNOTES_MININOTE_SHOW_1 = "Pr\|95\179ximo como MiniNote: ON"
METAMAPNOTES_MININOTE_SHOW_2 = "Pr\195\179ximo como MiniNote: SOLO"
METAMAPNOTES_ACCEPT_NOTE = "Nota a\195\177adida al mapa de |cFFFFD100%s|r."
METAMAPNOTES_DECLINE_NOTE = "No pude a\195\177adir, esta nota est\195\161 demasiado cerca de |cFFFFD100%q|r en |cFFFFD100%s|r."
METAMAPNOTES_ACCEPT_MININOTE = "MiniNota establecida para el mapa de |cFFFFD100%s|r.";
METAMAPNOTES_DECLINE_GET = "|cFFFFD100%s|r intento enviarte una nota en |cFFFFD100%s|r, pero estaba demasiado cerca de |cFFFFD100%q|r."
METAMAPNOTES_DISABLED_GET = "No pudo recibir nota de |cFFFFD100%s|r: recepci\195\179n desactivada en las opciones."
METAMAPNOTES_ACCEPT_GET = "Recibiste una nota de mapa de |cFFFFD100%s|r para |cFFFFD100%s|r."
METAMAPNOTES_PARTY_GET = "|cFFFFD100%s|r establecida nueva nota de grupo en |cFFFFD100%s|r."
METAMAPNOTES_NOTE_SENT = "Nota enviada a |cFFFFD100%s|r."
METAMAPNOTES_QUICKNOTE_DEFAULTNAME = "Nota Rapida"
METAMAPNOTES_MININOTE_DEFAULTNAME = "MiniNota"
METAMAPNOTES_VNOTE_DEFAULTNAME = "Nota Virtual"
METAMAPNOTES_SETMININOTE = "Estable nota como nueva MiniNota"
METAMAPNOTES_PARTYNOTE = "Nota Banda"
METAMAPNOTES_SETCOORDS = "Coords (xx,yy):"
METAMAPNOTES_VNOTE = "Virtual"
METAMAPNOTES_VNOTE_INFO = "Crea una nota virtual. Guarda en el mapa tu eleccion de vinculo."
METAMAPNOTES_VNOTE_SET = "Nota Virtual creada en el MapaMundi."
METAMAPNOTES_MININOTE_INFO = "Crea una nota en el Minimapa solo."
METAMAPNOTES_INVALIDZONE = "No pudo crear – no hay disponibles coordenadas de jugador en la zona.";

-- Buttons, Headers, Various Text

METAMAPNOTES_WARSONGGULCH = "Garganta Grito de Guerra"
METAMAPNOTES_ALTERACVALLEY = "Valle de Alterac"
METAMAPNOTES_ARATHIBASIN = "Cuenca de Arathi"

MetaMap_Data = {
	[1] = {
		["ZoneName"] = "Cavernas de Brazanegra",
		["Location"] = "Vallefresno",
		["LevelRange"] = "24-32",
		["PlayerLimit"] = "10",
		["texture"] = "Blackfathom Deeps",
		["infoline"] = "Situada a lo laro de la Playa de Zoram en Vallefresno, Cavernas de Brazanegra fue un templo glorioso dedicado a Elune la diosa de la luna de los elfos oscuros. However, the great Sundering shattered the temple - sinking it beneath the waves of the Veiled Sea. There it remained untouched - until, drawn by its ancient power - the naga and satyr emerged to plumb its secrets. Legends hold that the ancient beast, Aku'mai, has taken up residence within the temple's ruins. Aku'mai, a favored pet of the primordial Old Gods, has preyed upon the area ever since. Drawn to Aku'mai's presence, the cult known as the Twilight's Hammer has also come to bask in the Old Gods' evil presence.",
	},
	[2] = {
		["ZoneName"] = "Blackrock Depths",
		["Location"] = "Blackrock Mountain",
		["LevelRange"] = "52+",
		["PlayerLimit"] = "5",
		["texture"] = "BlackrockDepths",
		["infoline"] = "Once the capital city of the Dark Iron dwarves, this volcanic labyrinth now serves as the seat of power for Ragnaros the Firelord. Ragnaros has uncovered the secret to creating life from stone and plans to build an army of unstoppable golems to aid him in conquering the whole of Blackrock Mountain. Obsessed with defeating Nefarian and his draconic minions, Ragnaros will go to any extreme to achieve final victory.",
	},
	[3] = {
		["ZoneName"] = "Blackrock Spire (Lower)",
		["Location"] = "Blackrock Mountain",
		["LevelRange"] = "55+",
		["PlayerLimit"] = "10",
		["texture"] = "BlackrockSpireLower",
		["infoline"] = "The mighty fortress carved within the fiery bowels of Blackrock Mountain was designed by the master dwarf-mason, Franclorn Forgewright. Intended to be the symbol of Dark Iron power, the fortress was held by the sinister dwarves for centuries. However, Nefarian - the cunning son of the dragon, Deathwing - had other plans for the great keep. He and his draconic minions took control of the upper Spire and made war on the dwarves' holdings in the mountain's volcanic depths. Realizing that the dwarves were led by the mighty fire elemental, Ragnaros - Nefarian vowed to crush his enemies and claim the whole of Blackrock mountain for himself.",
	},
	[4] = {
		["ZoneName"] = "Blackrock Spire (Upper)",
		["Location"] = "Blackrock Mountain",
		["LevelRange"] = "58+",
		["PlayerLimit"] = "10",
		["texture"] = "BlackrockSpireUpper",
		["infoline"] = "The mighty fortress carved within the fiery bowels of Blackrock Mountain was designed by the master dwarf-mason, Franclorn Forgewright. Intended to be the symbol of Dark Iron power, the fortress was held by the sinister dwarves for centuries. However, Nefarian - the cunning son of the dragon, Deathwing - had other plans for the great keep. He and his draconic minions took control of the upper Spire and made war on the dwarves' holdings in the mountain's volcanic depths. Realizing that the dwarves were led by the mighty fire elemental, Ragnaros - Nefarian vowed to crush his enemies and claim the whole of Blackrock mountain for himself.",
	},
	[5] = {
		["ZoneName"] = "Blackwing Lair",
		["Location"] = "Blackrock Spire",
		["LevelRange"] = "60+",
		["PlayerLimit"] = "40",
		["texture"] = "BlackwingLair",
		["infoline"] = "Blackwing Lair can be found at the very height of Blackrock Spire. It is there in the dark recesses of the mountain's peak that Nefarian has begun to unfold the final stages of his plan to destroy Ragnaros once and for all and lead his army to undisputed supremacy over all the races of Azeroth. Nefarian has vowed to crush Ragnaros. To this end, he has recently begun efforts to bolster his forces, much as his father Deathwing had attempted to do in ages past. However, where Deathwing failed, it now seems the scheming Nefarian may be succeeding. Nefarian's mad bid for dominance has even attracted the ire of the Red Dragon Flight, which has always been the Black Flight's greatest foe. Though Nefarian's intentions are known, the methods he is using to achieve them remain a mystery. It is believed, however that Nefarian has been experimenting with the blood of all of the various Dragon Flights to produce unstoppable warriors.",
	},
	[6] = {
		["ZoneName"] = "La Masacre",
		["Location"] = "Feralas",
		["LevelRange"] = "56-60",
		["PlayerLimit"] = "5",
		["texture"] = "DireMaul",
		["infoline"] = "Construida hace doce mil a\195\177os por una secta encuabierta de elfos oscuros magos, la ciudad ancestral de Eldre'Thalas fue usada para protejer los valiosos secretros arcanos de la Reina de Azshara. Though it was ravaged by the Great Sundering of the world, la mayoria de la maravillosa ciudad todavia se mantiene en pie como La Masacre. Los tre distritos de las ruinas han sido infectados por todo tipo de criaturas - especialmente por los highborne espectrales, foul satyr y ogros brutos. Only the most daring party of adventurers can enter this broken city and face the ancient evils locked within its ancient vaults.",
	},
	[7] = {
		["ZoneName"] = "La Masacre (Este)",
		["Location"] = "Feralas",
		["LevelRange"] = "56-60",
		["PlayerLimit"] = "5",
		["texture"] = "DireMaulEast",
		["infoline"] = "Built twelve thousand years ago by a covert sect of night elf sorcerers, the ancient city of Eldre'Thalas was used to protect Queen Azshara's most prized arcane secrets. Though it was ravaged by the Great Sundering of the world, much of the wondrous city still stands as the imposing Dire Maul. The ruins' three distinct districts have been overrun by all manner of creatures - especially the spectral highborne, foul satyr and brutish ogres. Only the most daring party of adventurers can enter this broken city and face the ancient evils locked within its ancient vaults.",
	},
	[8] = {
		["ZoneName"] = "La Masacre (Norte)",
		["Location"] = "Feralas",
		["LevelRange"] = "56-60",
		["PlayerLimit"] = "5",
		["texture"] = "DireMaulNorth",
		["infoline"] = "Built twelve thousand years ago by a covert sect of night elf sorcerers, the ancient city of Eldre'Thalas was used to protect Queen Azshara's most prized arcane secrets. Though it was ravaged by the Great Sundering of the world, much of the wondrous city still stands as the imposing Dire Maul. The ruins' three distinct districts have been overrun by all manner of creatures - especially the spectral highborne, foul satyr and brutish ogres. Only the most daring party of adventurers can enter this broken city and face the ancient evils locked within its ancient vaults.",
	},
	[9] = {
		["ZoneName"] = "La Masacre (Oeste)",
		["Location"] = "Feralas",
		["LevelRange"] = "56-60",
		["PlayerLimit"] = "5",
		["texture"] = "DireMaulWest",
		["infoline"] = "Built twelve thousand years ago by a covert sect of night elf sorcerers, the ancient city of Eldre'Thalas was used to protect Queen Azshara's most prized arcane secrets. Though it was ravaged by the Great Sundering of the world, much of the wondrous city still stands as the imposing Dire Maul. The ruins' three distinct districts have been overrun by all manner of creatures - especially the spectral highborne, foul satyr and brutish ogres. Only the most daring party of adventurers can enter this broken city and face the ancient evils locked within its ancient vaults.",
	},
	[10] = {
		["ZoneName"] = "Gnomeregan",
		["Location"] = "Dun Mor ogh",
		["LevelRange"] = "29-38",
		["PlayerLimit"] = "10",
		["texture"] = "Gnomeregan",
		["infoline"] = "Located in Dun Morogh, the technological wonder known as Gnomeregan has been the gnomes' capital city for generations. Recently, a hostile race of mutant troggs infested several regions of Dun Morogh - including the great gnome city. In a desperate attempt to destroy the invading troggs, High Tinker Mekkatorque ordered the emergency venting of the city's radioactive waste tanks. Several gnomes sought shelter from the airborne pollutants as they waited for the troggs to die or flee. Unfortunately, though the troggs became irradiated from the toxic assault - their siege continued, unabated. Those gnomes who were not killed by noxious seepage were forced to flee, seeking refuge in the nearby dwarven city of Ironforge. There, High Tinker Mekkatorque set out to enlist brave souls to help his people reclaim their beloved city. It is rumored that Mekkatorque's once-trusted advisor, Mekgineer Thermaplug, betrayed his people by allowing the invasion to happen. Now, his sanity shattered, Thermaplug remains in Gnomeregan - furthering his dark schemes and acting as the city's new techno-overlord.",
	},
	[11] = {
		["ZoneName"] = "Maraudon",
		["Location"] = "Desolace",
		["LevelRange"] = "46-55",
		["PlayerLimit"] = "10",
		["texture"] = "Maraudon",
		["infoline"] = "Protected by the fierce Maraudine centaur, Maraudon is one of the most sacred sites within Desolace. The great temple/cavern is the burial place of Zaetar, one of two immortal sons born to the demigod, Cenarius. Legend holds that Zaetar and the earth elemental princess, Theradras, sired the misbegotten centaur race. It is said that upon their emergence, the barbaric centaur turned on their father and killed him. Some believe that Theradras, in her grief, trapped Zaetar's spirit within the winding cavern - used its energies for some malign purpose. The subterranean tunnels are populated by the vicious, long-dead ghosts of the Centaur Khans, as well as Theradras' own raging, elemental minions.",
	},
	[12] = {
		["ZoneName"] = "N\195\186cleo Fundido",
		["Location"] = "Blackrock Depths",
		["LevelRange"] = "60+",
		["PlayerLimit"] = "40",
		["texture"] = "MoltenCore",
		["infoline"] = "The Molten Core lies at the very bottom of Blackrock Depths. It is the heart of Blackrock Mountain and the exact spot where, long ago in a desperate bid to turn the tide of the dwarven civil war, Emperor Thaurissan summoned the elemental Firelord, Ragnaros, into the world. Though the fire lord is incapable of straying far from the blazing Core, it is believed that his elemental minions command the Dark Iron dwarves, who are in the midst of creating armies out of living stone. The burning lake where Ragnaros lies sleeping acts as a rift connecting to the plane of fire, allowing the malicious elementals to pass through. Chief among Ragnaros' agents is Majordomo Executus - for this cunning elemental is the only one capable of calling the Firelord from his slumber.",
	},
	[13] = {
		["ZoneName"] = "Onyxia's Lair",
		["Location"] = "Dustwallow Marsh",
		["LevelRange"] = "60+",
		["PlayerLimit"] = "40",
		["texture"] = "OnyxiasLair",
		["infoline"] = "Onyxia is the daughter of the mighty dragon Deathwing, and sister of the scheming Nefarion Lord of Blackrock Spire. It is said that Onyxia delights in corrupting the mortal races by meddling in their political affairs. To this end it is believed that she takes on various humanoid forms and uses her charm and power to influence delicate matters between the different races. Some believe that Onyxia has even assumed an alias once used by her father - the title of the royal House Prestor. When not meddling in mortal concerns, Onyxia resides in a fiery cave below the Dragonmurk, a dismal swamp located within Dustwallow Marsh. There she is guarded by her kin, the remaining members of the insidious Black Dragon Flight.",
	},
	[14] = {
		["ZoneName"] = "Sima Ignea",
		["Location"] = "Orgrimmar",
		["LevelRange"] = "13-15",
		["PlayerLimit"] = "10",
		["texture"] = "RagefireChasm",
		["infoline"] = "Sima Ignea consiste en un red de cavernas volc\195\161s que se encuentra bajo la c\195\161pital de los Orcos, Orgrimmar. Recientemente, se rumoreas que una legi\195\179n leal al los Concileos de la sombra demoniacos residen en las profundidades de la Sima. Este culto, conocido como la L\195\161 Ardiente, amenza la misma soberania de Durotar. Muchos creen que el Jefe de Guerra Orco, Thrall, est\195\161 enterado de la existencia de la l\195\161mina y ha elegido no destruirla con la esperanza de que sus miembros pudieran conducirlo derecho al consejo de la sombra. De cualquier manera todas las fuerzas oscuras que manaban de la Sima Ignea podian deshacer todo lo que los Orcos han temido que pasar\195\161.",
	},
	[15] = {
		["ZoneName"] = "Zah\195\186rda Rajacieno",
		["Location"] = "Los Baldios",
		["LevelRange"] = "33-40",
		["PlayerLimit"] = "10",
		["texture"] = "RazorfenDowns",
		["infoline"] = "Crafted from the same mighty vines as Razorfen Kraul, Razorfen Downs is the traditional capital city of the quillboar race. The sprawling, thorn-ridden labyrinth houses a veritable army of loyal quillboar as well as their high priests - the Death's Head tribe. Recently, however, a looming shadow has fallen over the crude den. Agents of the undead Scourge - led by the lich, Amnennar the Coldbringer - have taken control over the quillboar race and turned the maze of thorns into a bastion of undead might. Now the quillboar fight a desperate battle to reclaim their beloved city before Amnennar spreads his control across the Barrens.",
	},
	[16] = {
		["ZoneName"] = "Horado Rajacieno",
		["Location"] = "Los Baldios",
		["LevelRange"] = "25-30",
		["PlayerLimit"] = "10",
		["texture"] = "RazorfenKraul",
		["infoline"] = "Ten thousand years ago, during the War of the Ancients, the mighty demigod, Agamaggan, came forth to battle the Burning Legion. Though the colossal boar fell in combat, his actions helped save Azeroth from ruin. Yet over time, in the areas where his blood fell, massive thorn-ridden vines sprouted from the earth. The quillboar - believed to be the mortal offspring of the mighty god, came to occupy these regions and hold them sacred. The heart of these thorn-colonies was known as the Razorfen. The great mass of Razorfen Kraul was conquered by the old crone, Charlga Razorflank. Under her rule, the shamanistic quillboar stage attacks on rival tribes as well as Horde villages. Some speculate that Charlga has even been negotiating with agents of the Scourge - aligning her unsuspecting tribe with the ranks of the Undead for some insidious purpose.",
	},
	[17] = {
		["ZoneName"] = "Monasterio Escarlata",
		["Location"] = "Claros de Trisfal",
		["LevelRange"] = "34-45",
		["PlayerLimit"] = "10",
		["texture"] = "ScarletMonastery",
		["infoline"] = "The Monastery was once a proud bastion of Lordaeron's priesthood - a center for learning and enlightenment. With the rise of the undead Scourge during the Third War, the peaceful Monastery was converted into a stronghold of the fanatical Scarlet Crusade. The Crusaders are intolerant of all non-human races, regardless of alliance or affiliation. They believe that any and all outsiders are potential carriers of the undead plague - and must be destroyed. Reports indicate that adventurers who enter the monastery are forced to contend with Scarlet Commander Mograine - who commands a large garrison of fanatically devoted warriors. However, the monastery's true master is High Inquisitor Whitemane - a fearsome priestess who possesses the ability to resurrect fallen warriors to do battle in her name.",
	},
	[18] = {
		["ZoneName"] = "Scholomance",
		["Location"] = "Western Plaguelands",
		["LevelRange"] = "56-60",
		["PlayerLimit"] = "5",
		["texture"] = "Scholomance",
		["infoline"] = "The Scholomance is housed within a series of crypts that lie beneath the ruined keep of Caer Darrow. Once owned by the noble Barov family, Caer Darrow fell to ruin following the Second War. As the wizard Kel'thuzad enlisted followers for his Cult of the Damned he would often promise immortality in exchange for serving his Lich King. The Barov family fell to Kel'thuzad's charismatic influence and donated the keep and its crypts to the Scourge. The cultists then killed the Barovs and turned the ancient crypts into a school for necromancy known as the Scholomance. Though Kel'thuzad no longer resides in the crypts, devoted cultists and instructors still remain. The powerful lich, Ras Frostwhisper, rules over the site and guards it in the Scourge's name - while the mortal necromancer, Darkmaster Gandling, serves as the school's insidious headmaster.",
	},
	[19] = {
		["ZoneName"] = "Castillo de Colmillo Oscuro",
		["Location"] = "Bosque de Argénteos",
		["LevelRange"] = "22-30",
		["PlayerLimit"] = "10",
		["texture"] = "ShadowfangKeep",
		["infoline"] = "During the Third War, the wizards of the Kirin Tor battled against the undead armies of the Scourge. When the wizards of Dalaran died in battle, they would rise soon after - adding their former might to the growing Scourge. Frustrated by their lack of progress (and against the advice of his peers), the Archmage Arugal elected to summon extra-dimensional entities to bolster Dalaran's diminishing ranks. Arugal's summoning brought the ravenous worgen into the world of Azeroth. The feral wolf-men slaughtered not only the Scourge, but quickly turned on the wizards themselves. The worgen sieged the keep of the noble, Baron Silverlaine. Situated above the tiny hamlet of Pyrewood, the keep quickly fell into shadow and ruin. Driven mad with guilt, Arugal adopted the worgen as his children and retreated to the newly dubbed 'Shadowfang Keep'. It's said he still resides there, protected by his massive pet, Fenrus - and haunted by the vengeful ghost of Baron Silverlaine.",
	},
	[20] = {
		["ZoneName"] = "Stratholme",
		["Location"] = "Tierras de la Peste del Este",
		["LevelRange"] = "55-60",
		["PlayerLimit"] = "5",
		["texture"] = "Stratholme",
		["infoline"] = "Once the jewel of northern Lordaeron, the city of Stratholme is where Prince Arthas turned against his mentor, Uther Lightbringer, and slaughtered hundreds of his own subjects who were believed to have contracted the dreaded plague of undeath. Arthas' downward spiral and ultimate surrender to the Lich King soon followed. The broken city is now inhabited by the undead Scourge - led by the powerful lich, Kel'thuzad. A contingent of Scarlet Crusaders, led by Grand Crusader Dathrohan, also holds a portion of the ravaged city. The two sides are locked in constant, violent combat. Those adventurers brave (or foolish) enough to enter Stratholme will be forced to contend with both factions before long. It is said that the city is guarded by three massive watchtowers, as well as powerful necromancers, banshees and abominations. There have also been reports of a malefic Death Knight riding atop an unholy steed - dispensing indiscriminate wrath on all those who venture within the realm of the Scourge.",
	},
	[21] = {
		["ZoneName"] = "Las Minas de la Muerte",
		["Location"] = "P\195\161ramos de Poniente",
		["LevelRange"] = "17-26",
		["PlayerLimit"] = "10",
		["texture"] = "TheDeadmines",
		["infoline"] = "Once the greatest gold production center in the human lands, the Dead Mines were abandoned when the Horde razed Stormwind city during the First War. Now the Defias Brotherhood has taken up residence and turned the dark tunnels into their private sanctum. It is rumored that the thieves have conscripted the clever goblins to help them build something terrible at the bottom of the mines - but what that may be is still uncertain. Rumor has it that the way into the Deadmines lies through the quiet, unassuming village of Moonbrook.",
	},
	[22] = {
		["ZoneName"] = "Mazmorras de Ventormenta",
		["Location"] = "Ventormenta",
		["LevelRange"] = "23-26",
		["PlayerLimit"] = "10",
		["texture"] = "TheStockades",
		["infoline"] = "The Stockades are a high-security prison complex, hidden beneath the canal district of Stormwind city. Presided over by Warden Thelwater, the Stockades are home to petty crooks, political insurgents, murderers and a score of the most dangerous criminals in the land. Recently, a prisoner-led revolt has resulted in a state of pandemonium within the Stockades - where the guards have been driven out and the convicts roam free. Warden Thelwater has managed to escape the holding area and is currently enlisting brave thrill-seekers to venture into the prison and kill the uprising's mastermind - the cunning felon, Bazil Thredd.",
	},
	[23] = {
		["ZoneName"] = "El Templo Hundido",
		["Location"] = "Pantano de las Penas",
		["LevelRange"] = "45-55",
		["PlayerLimit"] = "10",
		["texture"] = "TheSunkenTemple",
		["infoline"] = "Over a thousand years ago, the powerful Gurubashi Empire was torn apart by a massive civil war. An influential group of troll priests, known as the Atal'ai, attempted to bring back an ancient blood god named Hakkar the Soulflayer. Though the priests were defeated and ultimately exiled, the great troll empire buckled in upon itself. The exiled priests fled far to the north, into the Swamp of Sorrows. There they erected a great temple to Hakkar - where they could prepare for his arrival into the physical world. The great dragon Aspect, Ysera, learned of the Atal'ai's plans and smashed the temple beneath the marshes. To this day, the temple's drowned ruins are guarded by the green dragons who prevent anyone from getting in or out. However, it is believed that some of the fanatical Atal'ai may have survived Ysera's wrath - and recommitted themselves to the dark service of Hakkar.",
	},
	[24] = {
		["ZoneName"] = "Uldaman",
		["Location"] = "Tierras Inh\195\179sitas",
		["LevelRange"] = "35-47",
		["PlayerLimit"] = "10",
		["texture"] = "Uldaman",
		["infoline"] = "Uldaman is an ancient Titan vault that has laid buried deep within the earth since the world's creation. Dwarven excavations have recently penetrated this forgotten city, releasing the Titans' first failed creations: the troggs. Legends say that the Titans created troggs from stone. When they deemed the experiment a failure, the Titans locked the troggs away and tried again - resulting in the creation of the dwarven race. The secrets of the dwarves' creation are recorded on the fabled Discs of Norgannon - massive Titan artifacts that lie at the very bottom of the ancient city. Recently, the Dark Iron dwarves have launched a series of incursions into Uldaman, hoping to claim the discs for their fiery master, Ragnaros. However, protecting the buried city are several guardians - giant constructs of living stone that crush any hapless intruders they find. The Discs themselves are guarded by a massive, sentient Stonekeeper called Archaedas. Some rumors even suggest that the dwarves' stone-skinned ancestors, the earthen, still dwell deep within the city's hidden recesses.",
	},
	[25] = {
		["ZoneName"] = "Cuevas de los Lamentos",
		["Location"] = "Los Baldios",
		["LevelRange"] = "17-24",
		["PlayerLimit"] = "10",
		["texture"] = "WailingCaverns",
		["infoline"] = "Recently, a night elf druid named Naralex discovered a network of underground caverns within the heart of the Barrens. Dubbed the 'Wailing Caverns', these natural caves were filled with steam fissures which produced long, mournful wails as they vented. Naralex believed he could use the caverns' underground springs to restore lushness and fertility to the Barrens - but to do so would require siphoning the energies of the fabled Emerald Dream. Once connected to the Dream however, the druid's vision somehow became a nightmare. Soon the Wailing Caverns began to change - the waters turned foul and the once-docile creatures inside metamorphosed into vicious, deadly predators. It is said that Naralex himself still resides somewhere inside the heart of the labyrinth, trapped beyond the edges of the Emerald Dream. Even his former acolytes have been corrupted by their master's waking nightmare - transformed into the wicked Druids of the Fang.",
	},
	[26] = {
		["ZoneName"] = "Zul'Farrak",
		["Location"] = "Desierto de Tanaris",
		["LevelRange"] = "43-47",
		["PlayerLimit"] = "10",
		["texture"] = "ZulFarrak",
		["infoline"] = "This sun-blasted city is home to the Sandfury trolls, known for their particular ruthlessness and dark mysticism. Troll legends tell of a powerful sword called Sul'thraze the Lasher, a weapon capable of instilling fear and weakness in even the most formidable of foes. Long ago, the weapon was split in half. However, rumors have circulated that the two halves may be found somewhere within Zul'Farrak's walls. Reports have also suggested that a band of mercenaries fleeing Gadgetzan wandered into the city and became trapped. Their fate remains unknown. But perhaps most disturbing of all are the hushed whispers of an ancient creature sleeping within a sacred pool at the city's heart - a mighty demigod who will wreak untold destruction upon any adventurer foolish enough to awaken him.",
	},
	[27] = {
		["ZoneName"] = "Zul'Gurub",
		["Location"] = "Vega de Tuercespina",
		["LevelRange"] = "60+",
		["PlayerLimit"] = "20",
		["texture"] = "ZulGurub",
		["infoline"] = "Over a thousand years ago the powerful Gurubashi Empire was torn apart by a massive civil war. An influential group of troll priests, known as the Atal'ai, called forth the avatar of an ancient and terrible blood god named Hakkar the Soulflayer. Though the priests were defeated and ultimately exiled, the great troll empire collapsed upon itself. The exiled priests fled far to the north, into the Swamp of Sorrows, where they erected a great temple to Hakkar in order to prepare for his arrival into the physical world.",
	},
	[28] = {
		["ZoneName"] = "Ahn'Qiraj",
		["Location"] = "Silithus",
		["LevelRange"] = "60+",
		["PlayerLimit"] = "40",
		["texture"] = "TempleofAhnQiraj",
		["infoline"] = "At the heart of Ahn'Qiraj lies an ancient temple complex. Built in the time before recorded history, it is both a monument to unspeakable gods and a massive breeding ground for the qiraji army. Since the War of the Shifting Sands ended a thousand years ago, the Twin Emperors of the qiraji empire have been trapped inside their temple, barely contained behind the magical barrier erected by the bronze dragon Anachronos and the night elves. Now that the Scepter of the Shifting Sands has been reassembled and the seal has been broken, the way into the inner sanctum of Ahn'Qiraj is open. Beyond the crawling madness of the hives, beneath the Temple of Ahn'Qiraj, legions of qiraji prepare for invasion. They must be stopped at all costs before they can unleash their voracious insectoid armies on Kalimdor once again, and a second War of the Shifting Sands breaks loose!",
	},
	[29] = {
		["ZoneName"] = "Ruinas de Ahn'Qiraj",
		["Location"] = "Silithus",
		["LevelRange"] = "60+",
		["PlayerLimit"] = "20",
		["texture"] = "RuinsofAhnQiraj",
		["infoline"] = "During the final hours of the War of the Shifting Sands, the combined forces of the night elves and the four dragonflights drove the battle to the very heart of the qiraji empire, to the fortress city of Ahn'Qiraj. Yet at the city gates, the armies of Kalimdor encountered a concentration of silithid war drones more massive than any they had encountered before. Ultimately the silithid and their qiraji masters were not defeated, but merely imprisoned inside a magical barrier, and the war left the cursed city in ruins. A thousand years have passed since that day, but the qiraji forces have not been idle. A new and terrible army has been spawned from the hives, and the ruins of Ahn'Qiraj are teeming once again with swarming masses of silithid and qiraji. This threat must be eliminated, or else all of Azeroth may fall before the terrifying might of the new qiraji army.",
	},
	[30] = {
		["ZoneName"] = "Naxxramas",
		["Location"] = "Tierras de la Peste del Este",
		["LevelRange"] = "60+",
		["PlayerLimit"] = "40",
		["texture"] = "Naxxramas",
		["infoline"] = "Floating above the Plaguelands, the necropolis known as Naxxramas serves as the seat of one of the Lich King's most powerful officers, the dreaded lich Kel'Thuzad. Horrors of the past and new terrors yet to be unleashed are gathering inside the necropolis as the Lich King's servants prepare their assault. Soon the Scourge will march again...",
	},
	[31] = {
		["ZoneName"] = "The Blood Furnaces",
		["Location"] = "Hellfire Peninsula",
		["LevelRange"] = "60-65",
		["PlayerLimit"] = "5",
		["texture"] = "HCBloodFurnaces",
		["infoline"] = "Though much of Draenor was shattered by the reckless Ner'zhul, the Hellfire Citadel remains intact – inhabited now by marauding bands of red, furious fel orcs. Though the presence of this new, savage breed presents something of a mystery, what's far more disconcerting is that the numbers of these fel orcs seem to be growing. \n\nDespite Thrall and Grom Hellscream's successful bid to end the Horde's corruption by slaying Mannoroth, reports indicate that the barbaric orcs of Hellfire Citadel have somehow managed to find a new source of corruption to fuel their primitive bloodlust. \n\nWhatever authority these orcs answer to is unknown, although it is a strongly held belief that they are not working for the Burning Legion. \n\nPerhaps the most unsettling news to come from Outland are the accounts of thunderous, savage cries issuing from somewhere deep beneath the citadel. Many have begun to wonder if these unearthly outbursts are somehow connected to the corrupted fel orcs and their growing numbers. Unfortunately those questions will have to remain unanswered. \n\nAt least for now.",
	},
	[32] = {
		["ZoneName"] = "The Shattered Halls",
		["Location"] = "Hellfire Peninsula",
		["LevelRange"] = "70",
		["PlayerLimit"] = "5",
		["texture"] = "HCShatteredHalls",
		["infoline"] = "Though much of Draenor was shattered by the reckless Ner'zhul, the Hellfire Citadel remains intact – inhabited now by marauding bands of red, furious fel orcs. Though the presence of this new, savage breed presents something of a mystery, what's far more disconcerting is that the numbers of these fel orcs seem to be growing. \n\nDespite Thrall and Grom Hellscream's successful bid to end the Horde's corruption by slaying Mannoroth, reports indicate that the barbaric orcs of Hellfire Citadel have somehow managed to find a new source of corruption to fuel their primitive bloodlust. \n\nWhatever authority these orcs answer to is unknown, although it is a strongly held belief that they are not working for the Burning Legion. \n\nPerhaps the most unsettling news to come from Outland are the accounts of thunderous, savage cries issuing from somewhere deep beneath the citadel. Many have begun to wonder if these unearthly outbursts are somehow connected to the corrupted fel orcs and their growing numbers. Unfortunately those questions will have to remain unanswered. \n\nAt least for now.",
	},
};

end
