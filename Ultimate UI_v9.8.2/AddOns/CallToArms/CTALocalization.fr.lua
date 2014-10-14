if( GetLocale() == "frFR" ) then

	--[[
	-- CTA Localization
	-- 
	-- French By : Sasmira ( Cosmos Team )
	-- 
	-- $Id$
	-- $Rev$ R5
	-- $LastChangedBy$ Sasmira
	-- $Date$ 07/07/2005
	--
	--]]
	
	-- Chat --
	
	CTA_ORCISH = "ORC";
	CTA_COMMON = "COMMUN";
	CTA_ILLEGAL_CHANNEL_WORDS = "Locale D\195\69fense Commerce G\195\169n\195\169ral";
	
	-- Classes --
	
	CTA_PRIEST = "Pr\195\170tre";
	CTA_MAGE = "Mage";
	CTA_WARLOCK = "D\195\169moniste";
	CTA_DRUID = "Druide";
	CTA_HUNTER = "Chasseur";
	CTA_ROGUE = "Voleur";
	CTA_WARRIOR = "Guerrier";
	CTA_PALADIN = "Paladin";
	CTA_SHAMAN = "Chaman";
	CTA_ANY_CLASS = "Toutes Classes";
	
	-- User interface --
	
	CTA_CALL_TO_ARMS = "Call To Arms";
	
	CTA_GROUP = "Groupe(s)";
	CTA_PARTY = "Groupe(s)";
	CTA_CURRENT_SIZE = "Taille Courante";
	CTA_CONVERT_TO_RAID = "Convertir en Raid";
	CTA_PLAYER_IS_RAID_MEMBER_NOT_LEADER = "Vous \195\170tes un membre d\'un groupe, mais pas son chef. Vous devez \195\170tre Chef de groupe ou sans groupe pour commencer \195\160 en accueillir un.";
	CTA_LIST_RAIDS = "Trouver des Groupes";
	CTA_MY_RAID = "Groupe d\'Accueil";
	CTA_SEARCH_OPTIONS = "Options de Recherche";
	CTA_SHOW_ALL_CLASSES = "Afficher toutes les Classes";
	CTA_SHOW_PVE_RAIDS = "Afficher Groupes JcE";
	CTA_SHOW_PVP_RAIDS = "Afficher Groupes JcJ";
	CTA_SEARCH_RAID_DESCRIPTIONS = "Description Recherch\195\169e:";
	CTA_SHOW_FULL_RAIDS = "Afficher Groupes Compl\195\170ts";
	CTA_SHOW_EMPTY_RAIDS = "Afficher Groupes Vides";
	CTA_SHOW_PASSWORD_PROTECTED_RAIDS = "Afficher les Groupes Prot\195\169g\195\169s par Mot de Passe";
	CTA_SHOW_RAIDS_ABOVE_MY_LEVEL = "Afficher les Groupes Sup\195\169rieurs \195\160 mon Niveau";
	CTA_RESULTS = "R\195\169sultat:";
	CTA_UPDATE_LIST = "M.\195\160.J. liste";
	CTA_JOIN_RAID = "Joindre Groupe";
	CTA_RAID_DESCRIPTION = "Description du Groupe:";
	CTA_RAID_DESCRIPTION_HELP = "Inclure les informations telle que l\'endroit, le but et autres commentaires";
	CTA_RAID_TYPE = "Type de Groupe:";
	CTA_PLAYER_VS_PLAYER = "Joueur Vs Joueur";
	CTA_PLAYER_VS_ENVIRONMENT = "Joueur Vs Environnement";
	CTA_MAXIMUM_PLAYERS = "Joueurs Max:";
	CTA_MAXIMUM_PLAYERS_HELP = "5 - 40";
	CTA_MAXIMUM_PLAYERS_HELP2 = "Pour plus de 5 membres, vous devez convertir un Groupe en Raid";
	CTA_MINIMUM_LEVEL = "Niveau Minimum:";
	CTA_MINIMUM_LEVEL_HELP = "1 - 60";
	CTA_PASSWORD = "Mot de Passe:";
	CTA_PASSWORD_HELP = "Pas d\'espace dans le mot de passe, laisser vide pour aucun";
	CTA_CLASS_DISTRIBUTION = "Distribution des Classes:";
	CTA_START_A_RAID = "Commencer un Groupe";
	CTA_SEND_REQUEST = "Envoyer la Requ\195\170te";
	CTA_CANCEL = "Annuler";
	CTA_GO_ONLINE = "Etre Online";
	CTA_GO_OFFLINE = "Etre Offline";
	CTA_RAID_OFFLINE_MESSAGE = "CE GROUPE EST OFFLINE. Tous les joueurs utilisant Call To Arms ne peuvent voir votre Groupe.";
	CTA_RAID_ONLINE_MESSAGE = "CE GROUPE EST ONLINE. Tous les joueurs utilisant Call To Arms ne peuvent voir votre Groupe.";
	CTA_IS_OFFLINE = "Call to Arms est Offline";
	CTA_IS_ONLINE = "Call to Arms est Online";
	CTA_SEARCH_FOR_RAIDS = "Recherche de Groupes";
	CTA_HOST_A_RAID = "Accueillir un Groupe";
	CTA_HEADER_RAID_DESCRIPTION = "Description du Groupe";
	CTA_HEADER_TYPE = "Type";
	CTA_HEADER_SIZE = "Taille";
	CTA_HEADER_MIN_LEVEL = "Niveau Min";
	CTA_RESULTS_FOUND = "R\195\169sultats Trouv\195\169s:";
	CTA_RAID = "raid";
	CTA_RAIDS = "raids";
	CTA_MIN_LEVEL_TO_JOIN_RAID = "Niveau Minimum pour rejoindre le Groupe";
	CTA_RAID_REQUIRES_PASSWORD = "Un Mot de Passe est requis pour joindre ce Groupe."
	CTA_RAID_CREATED = "Groupe cr\195\169e";
	CTA_NO_DESCRIPTION = "Aucune description donn\195\169e";
	CTA_PVP = "JcJ";
	CTA_PVE = "JcE";
	CTA_YES = "Oui";
	CTA_NO = "Non";
	CTA_RAID_LEADER = "Chef de Groupe";
	CTA_DESCRIPTION = "Description";
	CTA_PAGE = "PAGE";
	CTA_GROUPS = "Groupes";
	
	-- Slash commands --
	
	CTA_COMMANDS = "Commands";
	CTA_HELP = "help";
	CTA_TOGGLE = "toggle";
	CTA_DEFAULT_CHANNEL = "default channel";
	CTA_SET_CHANNEL = "set channel";
	CTA_CHANNEL_NAME = "channelName";
	CTA_CLEAR_BLACKLIST = "clear blacklist";
	CTA_DISSOLVE_RAID = "dissolve group";
	CTA_CONVERT_RAID = "convert raid";
	
	CTA_TOGGLE_HELP = "Afficher/Cacher la Fen\195\170tre CTA";
	CTA_DEFAULT_CHANNEL_HELP = "Mettre le canal CTA comme canal par d\195\169faut";
	CTA_SET_CHANNEL_HELP = "Mettre le canal CTA "..CTA_CHANNEL_NAME.." (non recommand\195\169)";
	CTA_CLEAR_BLACKLIST_HELP = "Nettoyer la liste de Joueurs que CTA ignore en raison du Spam"
	CTA_DISSOLVE_RAID_HELP = "(Chef de Groupe seulement) Dissoudre totalement le groupe en enlevant tous les joueurs"
	CTA_CONVERT_RAID_HELP = "(Chef de Groupe seulement) Convertir un Raid en groupe";
	
	-- Generated messages --
	
	CTA_CALL_TO_ARMS_LOADED = "Call To Arms lanc\195\169. Utiliser /cta pour plus de commandes."
	
	CTA_QUERY_CHANNEL_IS = "Le canal de question est";
	CTA_BLACKLIST_CLEARED = "Liste Noire Nettoy\195\169e";
	CTA_ILLEGAL_CHANNEL_NAME = "Nom de canal Ill\195\69gal";
	CTA_WAS_BLACKLISTED = "a \195\169t\195\169 mis en Liste Noire pour Spam";
	CTA_GROUP_MEMBERS = "Membre du Groupe: ";
	CTA_INVITATION_SENT_TO = "Invitation envoy\195\169e \195\160";
	
	CTA_DISSOLVING_RAID = "Groupe Supprim\195\169...";
	CTA_MUST_BE_LEADER_TO_DISSOLVE_RAID = "Vous devez \195\170tre le Chef de Groupe pour dissolve a group." ;
	CTA_RAID_DISSOLVED = "Group dissout";
	
	CTA_CONVERTING_TO_PARTY = "Convertir en Groupe...";
	CTA_CANNOT_CONVERT_TO_PARTY = "Ne peut pas convertir en Groupe \195\160 moins que le Raid ait 5 membres ou moins";
	CTA_CONVERTING_TO_PARTY_DONE = "Groupe converti";
	CTA_MUST_BE_LEADER_TO_CONVERT_RAID = "Vous devez \195\170tre le Chef de Groupe pour convertir un groupe." ;
	
	-- Automated chat messages --
	
	CTA_WRONG_LEVEL_OR_CLASS = "D\195\169sol\195\169, mais votre niveau et/ou classe ne r\195\169ponde pas aux exigences requises pour rejoindre ce groupe.";
	CTA_DISSOLVING_THE_RAID_CHAT_MESSAGE = "Le Groupe est maintenant dissout, merci de votre participation.";
	CTA_CONVERTING_TO_PARTY_MESSAGE = "Converti en Groupe, acceptez l\'invitation de rejoindre.";
	CTA_INVITATION_SENT_MESSAGE = "Bonjour, une invitation pour rejoindre mon groupe vous a \195\169t\195\169 envoy\195\169e.";
	CTA_INCORRECT_PASSWORD_MESSAGE = "Vous avez envoy\195\69 un mot de passe incorrect pour ce groupe.";
	CTA_NO_SPACE_MESSAGE = "Ce groupe a deja le nombre maximum de joueurs.";
	CTA_PASSWORD_REQURED_TO_JOIN_MESSAGE = "Un mot de passe est requis pour rejoindre ce groupe.";
	
	-- Tooltips --
	
	CTA_MAXIMUM_PLAYERS_ALLOWED = "Maximum de joueurs autoris\195\169s";
	CTA_PLAYERS_IN_RAID = "Joueurs actuellement en groupe";
	CTA_NUMBER_OF_PLAYERS_NEEDED = "Nombre de Joueurs demand\195\169s";
	CTA_ANY_CLASS_TOOLTIP = "Le nombre maximum de joueurs de toutes Classes autoris\195\169s \195\160 rejoindre le groupe.";
	CTA_MINIMUM_PLAYERS_WANTED = "Minimum de Joueurs recherch\195\169s";
	CTA_LFM_ANY_CLASS = "Besoin de plus de joueurs de toutes Classes.";
	CTA_LFM_CLASSLIST = "Besoin de plus de joueurs de ces Classes: ";
	CTA_CLASS_TOOLTIP = "Le nombre minimum de joueurs de toutes Classes autoris\195\169s \195\160 rejoindre le groupe. Si ce minimum est d\195\169pass\195\69 les joueurs suppl\195\169mentaires sont compt\195\169s en tant que Joueurs \'de toutes classes \'.";
	
	CTA_GenTooltips = {
	
	CTA_SearchFrameShowClassCheckButton = {
	tooltip1 = "Afficher toutes les classes",
	tooltip2 = "Quand v\195\169rifi\195\169s, les r\195\169sultats incluront les groupes qui recherchent plus de joueurs des classes diff\195\169rentes de la votre."
	},
	
	CTA_SearchFrameShowPVPCheckButton = {
	tooltip1 = "Afficher les Groupes JcJ",
	tooltip2 = "Quand v\195\169rifi\195\169s, les r\195\169sultats incluront les groupes de Joueurs Contre Joueurs."
	},
	
	CTA_SearchFrameShowPVECheckButton = {
	tooltip1 = "Afficher les Groupes JcE",
	tooltip2 = "Quand v\195\169rifi\195\169s, les r\195\169sultats incluront les groupes de Joueurs Contre Environnement et Qu\195\170tes de Groupes."
	},
	
	CTA_SearchFrameShowFullCheckButton = {
	tooltip1 = "Afficher les Groupes Compl\195\170ts",
	tooltip2 = "Quand v\195\169rifi\195\169s, les r\195\169sultats incluront les groupes Compl\195\170ts n\'ayant pas besoin de Joueurs suppl\195\169mentaires."
	},
	
	CTA_SearchFrameShowEmptyCheckButton = {
	tooltip1 = "Afficher les Groupes Vides",
	tooltip2 = "Quand v\195\169rifi\195\169s, les r\195\169sultats incluront les groupes \'Vides\' ou ayant au moins un Joueur."
	},
	
	CTA_SearchFrameShowPasswordCheckButton = {
	tooltip1 = "Afficher les Groupes avec Mot de Passe",
	tooltip2 = "Quand v\195\169rifi\195\169s, les r\195\169sultats incluront les groupes avec Mot de Passe."
	},
	
	CTA_SearchFrameShowLevelCheckButton = {
	tooltip1 = "Afficher les Groupes sup\195\169rieurs \195\160 mon Niveau",
	tooltip2 = "Quand v\195\169rifi\195\169s, les r\195\169sultats incluront les groupes demandant des joueurs de niveau plus haut que le votre."
	},
	
	CTA_SearchFrameDescriptionEditBox = {
	tooltip1 = "Recherche par Descriptions",
	tooltip2 = "Beaucoups de chefs de groupes font une description sommaire pour leurs groupes. Si des mots-cl\195\169s sont \195\169crits dans cette boite, seulement des groupes avec ces mots-cl\195\169s dans la description seront inclus dans les r\195\169sultats."
	},
	
	};
	
	
	-- New for R3 features
	
	CTA_CURRENT = "Courant";
	CTA_PENDING = "En suspens";
	CTA_SIZE = "Taille";
	
	CTA_LOG = "Log";
	CTA_HELP = "Aide";
	
	CTA_SETTINGS = "Options";
	CTA_MINIMAP_ICON_SETTINGS = "Options de l\'ic\195\180ne de la Minimap";
	CTA_COMM_SETTINGS = "Options de Communication";
	CTA_LOG_AND_MONITOR = "Log Syst\195\168me et Surveillance du Chat (Beta)"
	
	CTA_START_PARTY = "Commencer un Groupe";
	CTA_START_RAID = "Commencer un raid";
	CTA_PLAYER_CAN_START_A_GROUP = "Commencer l\'Accueil d\'un nouveau Groupe";
	CTA_CONVERT_TO_PARTY = "Convertir en Groupe";
	CTA_STOP_HOSTING = "Stop l\'Accueil";
	CTA_SEARCH_MATCH = "Rechercher score";
	CTA_NO_MORE_PLAYERS_NEEDED = "Plus besoin de joueurs ";
	
	CTA_PLAYER_LIST = "Joueurs en Liste Noire";
	CTA_EDIT_PLAYER = "Editer les informations d\'un joueur";
	CTA_DELETE = "Supprimer";
	CTA_SAVE = "Sauvegarder";
	CTA_ADD_PLAYER = "Ajout Joueur";
	
	CTA_PLAYER_NOTE = "Note";
	CTA_PLAYER_STATUS = "Status";
	CTA_DEFAULT_PLAYER_NOTE = "Nouveau joueur ajout\195\169. Cliquer ici pour \195\169diter cette note."
	CTA_DEFAULT_STATUS = ""
	CTA_DEFAULT_IMPORTED_IGNORED_PLAYER_NOTE = "Importer des joueurs ignor\195\169s. Cliquer ici pour \195\169diter cette note.";
	CTA_DEFAULT_RATING = "";
	CTA_BLACKLISTED_NOTE = "Temporairement en Liste Noire de CTA. Editer la note pour mettre en permanent.";
	CTA_PROMO = "\'Call To Arms\' (CTA) est un nouvel add-on permettant \195\160 des joueurs d\'accueillir, de trouver et de rejoindre des groupes rapidement et plus facilement. Allez sur le site de http://www.curse-gaming.com, http://ui.worldofwar.net, http://www.wowguru.com ou http://www.wowinterface.com pour plus de d\195\169tails.";
	CTA_OK = "Ok";
	CTA_ADD_PLAYER = "Ajout de Joueur";
	CTA_ENTER_PLAYER_NAME = "Entrer le nom du joueur \195\160 mettre en Liste Noire:";
	
	CTA_ICON = "Ic\195\180ne de la Minimap";
	CTA_ICON_TEXT = "texte Ic\195\180ne";
	CTA_ADJUST_ANGLE = "Ajuster l\'Angle";
	CTA_ADJUST_RADIUS = "Ajuster le Rayon";
	
	-- New for R5

	CTA_MAXIMUM_PLAYERS_ALLOWED 				= "Espace groupe permis";
	CTA_PLAYERS_IN_RAID 						= "Joueurs actuellement dans le groupe";
	CTA_NUMBER_OF_PLAYERS_NEEDED 				= "Nombre de joueurs requis";
	CTA_ANY_CLASS_TOOLTIP 						= "Nombre d\'espaces libres dans le groupe. Permet \195\160 des joueurs de toutes classes de remplir ces emplacements.";
	CTA_MINIMUM_PLAYERS_WANTED 					= "Espace groupe r\195\169serv\195\169";
	CTA_LFM_ANY_CLASS 							= "besoin de plus de joueurs de toutes classes.";
	CTA_LFM_CLASSLIST 							= "besoin de plus de joueurs de ces classes: ";
	CTA_CLASS_TOOLTIP							= "Nombre d\'espaces r\195\169serv\195\169s aux joueurs de cette classe \195\160 placer dans le groupe. If this space is exceeded the extra players are counted as \'Any Class\' players.";
	CTA_ANNOUNCE_GROUP							= "Annonce";
	CTA_ANNOUNCE_GROUP_HELP						= "Envoyer un message public (LFM). Utiliser: \'cta annonce <Nombre de canaux>\'";
	CTA_WAIT_TO_ANNOUNCE						= "Veuillez attendre un moment avant d\'annoncer votre groupe."
	CTA_TOGGLE_CHAT_MONITORING					= "Surveiller les messages du chat";
	CTA_LOG_AND_MONITOR							= "Entr\195\169es de Log";
	CTA_LAST_UPDATE								= "Derni\195\168re M.\195\160.J";
	CTA_PROMO									= "Bienvenue dans le groupe ! L\'invitation que vous avez accept\195\169e a \195\169t\195\169 automatiquement envoy\195\169e par  \'Call To Arms\', disponible sur http://curse-gaming.com, http://worldofwar.net, http://wowguru.com and wowinterface.com";
	CTA_FILTER_RESULTS							= "Filtres Optionnels";
	
	-- R6
	
	CTA_EDIT_ACID_CLASSES						= "Edit the classes for this rule:"; -- Please change this for next update
	CTA_NAME									= "Nom";
	
	
	-- Sacha: Thanks to Guillaume for these translations:
	
	-- P7B1
	CTA_NON_CTA_GROUP_MESSAGE					= "Groupe Non-CTA";
	CTA_NON_CTA_PLAYER_MESSAGE					= "Joueur Non-CTA";
	CTA_NEW_LFX									= "Nouveau LFx trouv\195\169";
	CTA_PRE_R7_USER								= "Version R6 ou plus ancienne";
	CTA_VERSION									= "Version";
	CTA_CURRENT_GROUP_CLASSES					= "Classes dans le groupe";
	CTA_TOGGLE_MINIMAP							= "minimap";
	CTA_LFG_FRAME								= "Rech. groupe";
	CTA_ANNOUNCE_LFG							= "Diffuser ce message LFG sur le canal CTAChannel.";
	CTA_ANNOUNCE_INFO_TEXT						= "Ce message LFG sera diffus\195\169 sur le canal CTAChannel uniquement si vous n\'h\195\169bergez pas de groupe avec CTA.\n\nUtilisez \'/cta announce <channel>\' pour envoyer votre message LFG/M sur un canal local toutes les 100 secondes et \'/cta announce off\' pour arr\195\170ter.";
	CTA_AUTO_ANNOUNCE_OFF						= "announce off";
	
	--P7B3
	CTA_FIND_PLAYERS_AND_GROUPS					= "Rech. joueurs et groupes";
	CTA_LFG_FRAME								= "Me marquer comme LFG";
	CTA_CANNOT_LFG								= "Vous je pouvez pas vous marquer comme LFG si vous \195\170tes d\195\169j\195\160 dans un groupe."
	CTA_MANAGE_GROUP							= "G\195\169rer mon groupe";
	CTA_SEARCH									= "Chercher";
	CTA_CLOSE									= "Fermer";
	CTA_LFG										= "LFG"; -- LFG = 'Looking For Group'
	CTA_CHANNEL_MONITORING						= "Surveillance de canal";
	CTA_CHANNEL_MONITORING_NOTE					= "Les mots-cl\195\169s doivent avoir au moins 3 caract\195\168res. Cette fonctionnalit\195\169 est en beta. Attendez quelques minutes et activez cette fonction si les messages locaux ne sont pas d\195\169j\195\160 dans les r\195\169sultats.";
	
	CTA_LFG_TRIGGER								= "Mots-cl\195\169s pour les messages \'Looking for group\'";
	CTA_LFM_TRIGGER								= "Mots-cl\195\169s pour les messages \'Looking For More\'";
	CTA_FILTER_GROUP_RESULTS					= "Filtres des groupes";
	CTA_FILTER_PLAYER_RESULTS					= "Filtres des joueurs";
	
	CTA_SEARCH_RESULTS							= "R\195\169sultats de recherche";
	CTA_SEARCH_OPTIONS							= "Options de recherche";
	
	CTA_SHOW_PLAYERS_AND_GROUPS					= "Afficher les joueurs et les groupes";
	CTA_SHOW_PLAYERS_ONLY						= "Afficher uniquement les joueurs";
	CTA_SHOW_GROUPS_ONLY						= "Afficher uniquement les groupes";
	CTA_CTA_PLAYER								= "Joueur CTA";
	CTA_CTA_GROUP								= "Groupe CTA";
	CTA_FORWARD_LFX								= "Surveiller les canaux locaux et envoyer tous les messages LFG/M vers le canal CTAChannel.";
	
	CTA_MORE_FEATURES							= "Plus";
	
	
	CTA_ANNOUNCE_SUMMARY_PROMPT					= " > Pour plus d\'info, tapez \'/w "..(UnitName( "player" )).." details\'";
	CTA_ANNOUNCE_DETAILS_PROMPT					= " > Pour rejoindre, tapez \'/w "..(UnitName( "player" )).." inviteme\'";
	CTA_ANNOUNCE_JOIN_PROMPT					= " > For plus d\'info, tapez \'/w "..(UnitName( "player" )).." cta?\'";
	CTA_PROMO									= "Bienvenue dans le groupe! Ce groupe et g\195\169r\195\169 par l\'addon CallToArms.";
	CTA_ABOUT_CTA_MESSAGE						= "L\'addon \'CallToArms\' de recherche de groupe rend tr\195\168s simple la formation de groupes dans WoW et est disponible sur www.curse-gaming.com, ui.worldofwar.net, www.wowguru.com et www.wowinterface.com."
	
end