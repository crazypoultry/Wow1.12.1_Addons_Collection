--[[
	WARNING! If you edit this file you need a good editor, not notepad.
	This file HAS to be saved in UTF-8 format (without signature) else we would have to escape
	all special chars
	e.g. http://www.jedit.org/ will work, when opening the file rightclick and select encoding UTF-8
	[Changed the translation to UTF-8]
	
	Traduction by "Lethaluciole" and "Luard"
]]--

if (GetLocale() == "frFR") then
SW_RootSlashes = {"/swstats", "/sws"};


SW_CONSOLE_NOCMD = "Cette commande n'existe pas: ";
SW_CONSOLE_HELP ="Aide: "
SW_CONSOLE_NIL_TRAILER = " n'est pas défini."; -- space at beginning
SW_CONSOLE_SORTED = "Trié";
SW_CONSOLE_NOREGEX = "Il n'y a pas de Regex pour cet évènement.";
SW_CONSOLE_FALLBACK = "Regex trouvé - ajouté à la carte";
SW_FALLBACK_BLOCK_INFO = "Cet évènement ne peut se mettre à jour par lui-même.";
SW_FALLBACK_IGRNORED = "Cet évènement a été ignoré.";
SW_EMPTY_EVENT = "Ecouter les évènements désuets?: ";
SW_INFO_PLAYER_NF = "Il n'y a pas d'information pour:";
SW_PRINT_INFO_FROMTO = "|cffffffffDe:|r%s, |cffffffffà:|r%s,";
SW_PRINT_ITEM = "|cffffffff%s:|r%s,";
SW_PRINT_ITEM_DMG = "Dâgats";
SW_PRINT_ITEM_HEAL = "Soigné";
SW_PRINT_ITEM_THROUGH = "A travers";
SW_PRINT_ITEM_TYPE = "Type";
SW_PRINT_ITEM_CRIT = "|cffff2020CRIT|r";
SW_PRINT_ITEM_WORLD = "Monde";
SW_PRINT_ITEM_NORMAL = "Normal";
SW_PRINT_ITEM_RECIEVED = "Reçu";
SW_PRINT_INFO_RECIEVED = "|cffff2020Dmg:%s|r, |cff20ff20Heal:%s|r";
SW_PRINT_ITEM_TOTAL_DONE = "Total";
SW_PRINT_ITEM_NON_SCHOOL = "Autres";
SW_PRINT_ITEM_IGNORED = "Ignoré";
SW_PRINT_ITEM_DEATHS = "Morts";


SW_SYNC_CHAN_JOIN = "|cff20ff20SWSync: Vous rejoignez:|r";
SW_SYNC_CHAN_FAIL= "|cffff2020SWSync: Vous ne pouvez pas rejoindre:|r";
SW_BARS_WIDTHERROR = "La barre est trop large!"
SW_SYNC_JOINCHECK_FROM = "Rejoindre Canal de Synchronisation %s de: %s?"
SW_SYNC_JOINCHECK_INFO = "Les anciennes données seront perdues!"
SW_SYNC_CURRENT = "Canal de Synchronisation actuel: %s";
SW_B_CONSOLE = "C";
SW_B_SETTINGS = "P";
SW_B_REPORT = "R";
SW_B_SYNC = "S";

SW_STR_MAX = "Max";
SW_STR_EVENTCOUNT = "#";
SW_STR_AVERAGE = "ø";
SW_STR_PET_PREFIX = "[Familiers] "; -- pet prefix for pet info displayed in the bars
SW_STR_VPP_PREFIX = "[Tous les familiers] "; -- pet prefix for virtual pet per player info displayed in the bars
SW_STR_VPR = "[Familiers du raid]"; -- pet string for virtual pet per raid info displayed in the bars

-- 1.5.beta.1 Reset vote
SW_STR_RV = "|cffff5d5dReset Vote!|r Issued by |cffff5d5d%s|r.  Voulez-vous mettre à zéro le canal de synchronisation?";
SW_STR_RV_PASSED =  "|cffffff00[SW Sync]|r |cff00ff00Remise à zéro des votes passé!|r";
SW_STR_RV_FAILED = "|cffffff00[SW Sync]|r |cffff5d5dRemise à zéro échouée!|r";
SW_STR_VOTE_WARN = "|cffffff00[SW Sync]|r |cffff5d5dNe spamez pas les votes...|r";

--1.5.3
--Raid DPS Strings
SW_RDPS_STRS = {
	["CURR"] = "RDPS Combat courrant",
	["ALL"] = "RDPS",
	["LAST"] = "RDPS Dernier Combat",
	["MAX"] = "RDPS Max",
	["TOTAL"] = "RDPS La terrible vérité", -- a timer that keeps running, no matter if in or out of fight
}

--[[
   you can ONLY localize the values! NOT the keys
   don't change aynthing like this ["someString"]
--]]
SW_Spellnames = {
	[1] = "Délivrance de la malédiction mineure",
	[2] = "Délivrance de la malédiction",
	[3] = "Dissipation de la magie",
	[4] = "Guérison des maladies",
	[5] = "Abolir maladie",
	[6] = "Purification",
	[7] = "Epuration",
	[8] = "Guérison du poison",
	[9] = "Abolir le poison",
	[10] = "Expiation",
}


SW_LocalizedGUI ={
	["SW_FrameConsole_Title"] = "SW v"..SW_VERSION,
	["SW_FrameConsole_Tab1"] = "Géneral",
	["SW_FrameConsole_Tab2"] = "Eventinfo",
	--["SW_FrameConsole_Tab3"] = "Paramètres",
	["SW_BarSettingsFrameV2_Tab1"] = "Données",
	["SW_BarSettingsFrameV2_Tab2"] = "Visuel",
	["SW_BarSettingsFrameV2_Tab3"] = "Pets",
	["SW_Chk_ShowEventText"] = "Event->Voir Regex",
	["SW_Chk_ShowOrigStrText"] = "Voir le log",
	["SW_Chk_ShowRegExText"] = "Voir Regex",
	["SW_Chk_ShowMatchText"] = "Voir correspondances",
	["SW_Chk_ShowSyncInfoText"] = "Voir messages synchronisées",
	--["SW_Chk_ShowOnlyFriendsText"] = "Ne voir que les amis'.",
	["SW_Chk_ShowSyncBText"] = "Voir le bouton de synchronisation",
	["SW_Chk_ShowConsoleBText"] = "Voir le bouton de console",
	["SW_Chk_ShowDPSText"] = "DPS";
	["SW_Chk_MergePetsText"] = "Confondre Pet et maître",
	["SW_RepTo_SayText"] = "Dire",
	["SW_RepTo_GroupText"] = "Groupe",
	["SW_RepTo_RaidText"] = "Raid",
	["SW_RepTo_GuildText"] = "Guilde",
	["SW_RepTo_ChannelText"] = "Canal",
	["SW_RepTo_WhisperText"] = "Chuchoter",
	["SW_RepTo_ClipboardText"] = "Textbox",
	["SW_RepTo_OfficerText"] = "Officier",
	["SW_BarReportFrame_Title_Text"] = "Rapporter à..",
	["SW_Chk_RepMultiText"] = "Multiligne",
	["SW_Filter_PCText"] = "PJ",
	["SW_Filter_NPCText"] = "PNJ",
	["SW_Filter_GroupText"] = "Groupe/Raid actuel",
	["SW_Filter_EverGroupText"] = "Groupe/Raid tous",
	["SW_Filter_NoneText"] = "Rien",
	["SW_GeneralSettings_Title_Text"] = "Paramètres généraux",

	["SW_BarSyncFrame_Title_Text"] = "Paramètres de Synchronisation",
	["SW_BarSettingsFrameV2_Title_Text"] = "Paramètres",
	["SW_BarSyncFrame_SyncLeave"] = "Quitter",
	["SW_BarSyncFrame_OptGroupText"] = "Groupe",
	["SW_BarSyncFrame_OptRaidText"] = "Raid",
	["SW_BarSyncFrame_OptGuildText"] = "Guilde",
	["SW_BarSyncFrame_SyncSend"] = "Envoyer à",
	["SW_CS_Damage"] = "Couleur: Dégâts",
	["SW_CS_Heal"] = "Couleur: Soins",
	["SW_CS_BarC"] = "Couleur: Barre",
	["SW_CS_FontC"] = "Couleur: Font",
	["SW_CS_OptC"] = "Couleur: Bouton",
	["SW_TextureSlider"] = "Texture:",
	["SW_FontSizeSlider"] = "Taille de la police:",
	["SW_BarHeightSlider"] = "H:",
	--["SW_BarWidthSlider"] = "Largeur de la barre:", old 1.4.2 no longer in use
	["SW_ColCountSlider"] = "Change la largeur de la barre pourcette vue",
	["SW_OptChk_NumText"] = "Somme",
	["SW_OptChk_RankText"] = "Rang",
	["SW_OptChk_PercentText"] = "%",
	["SW_VarInfoLbl"] = "Cette info demande une cible.  Cliquez sur Changer pour introduire un nom ou cliquez Cible pour utiliser la cible actuelle.",
	["SW_SetInfoVarFromTarget"] = "Cible",
	["SW_ColorsOptUseClassText"] = "Couleur classe",
	["SW_TextWindow_Title_Text"] = "Utilisez Ctrl+c pour copier.",
	["SW_BarSyncFrame_SyncARPY"] = "Permettre",
	["SW_BarSyncFrame_SyncARPN"] = "Interdire",

	-- 1.5 new pet filter labels 
	["SW_PF_InactiveText"] = "Inactif",
	["SW_PF_ActiveText"] = "Actif",
	["SW_PF_MMText"] = "Confondre fait",
	["SW_PF_MRText"] = "Confondre reçu",
	["SW_PF_MBText"] = "Confondre tous",
	["SW_PF_CurrentText"] = "Actuel",
	["SW_PF_VPPText"] = "Familier du joueur virtuel",
	["SW_PF_VPRText"] = "Familier du raid virtuel",
	["SW_PF_IgnoreText"] = "Ignorer toutes les infos de familier",
	
	-- 1.5.3 new colors
	["SW_CS_TitleBar"] =  "Couleur: barre de titre",
	["SW_CS_TitleFont"] =  "Couleur: police de la barre de titre",
	["SW_CS_Backdrops"] =  "Couleur: fenêtre",
	["SW_CS_MainWinBack"] =  "Retour Fençtre principale",
	["SW_CS_ClassCAlpha"] = "Transparence de la classe",

}

--SW_GS_Tooltips["SW_Chk_ShowOnlyFriends"] = "Cette option est seulement utilisée pour filtrer les rapports envoyés à la console via /sws.";
SW_GS_Tooltips["SW_Chk_ShowSyncB"] = "Option permettant d'afficher un bouton supplémentaire pour les paramè de Synchronisation sur la fenêtre principale.";
SW_GS_Tooltips["SW_Chk_ShowConsoleB"] = "Option permettant d'afficher un bouton supplémentaire pour la console sur la fenêtre principale.";
SW_GS_Tooltips["SW_CS_Damage"] = "La couleur de la barre de dégâts. Utilisé lorsque vous regardez les détails";
SW_GS_Tooltips["SW_CS_Heal"] = "La couleur de la barre de soins";
SW_GS_Tooltips["SW_CS_BarC"] = "La couleur de la barre utilisée pour cette vue";
SW_GS_Tooltips["SW_CS_FontC"] = "La couleur de la police utilisée pour cette vue.";
SW_GS_Tooltips["SW_CS_OptC"] = "La couleur des boutons en dessous de la fenêtre principale";
SW_GS_Tooltips["SW_TextureSlider"] = "Texture de la barre pour cette vue.";
SW_GS_Tooltips["SW_FontSizeSlider"] = "Taille de la police de la barre pour cette vue.";
SW_GS_Tooltips["SW_BarHeightSlider"] = "Changer la hauteur de la barre pour cette vue.";
--SW_GS_Tooltips["SW_BarWidthSlider"] = "Changer la largeur de la barre pour cette vue"; removed 1.4.2
SW_GS_Tooltips["SW_ColCountSlider"] = "Changer la quantité de colonnes pour cette vue.";
SW_GS_Tooltips["SW_SetOptTxtFrame"] = "Changer le texte affiché sur les boutons du bas de la fenêtre principale.";
SW_GS_Tooltips["SW_SetFrameTxtFrame"] = "Changer le texte afficheé en titre sur la fenê principale.";
SW_GS_Tooltips["SW_OptChk_Num"] = "Afficher en chiffre (Ex: Dégâts, Soins etc.).";
SW_GS_Tooltips["SW_OptChk_Rank"] = "Afficher le rang.";
SW_GS_Tooltips["SW_OptChk_Percent"] = "Afficher le pourcentage de dégâts / soins.";
SW_GS_Tooltips["SW_Filter_None"] = "Aucun filtre PJ/PNJ/Groupe/raid selectionné. (Toutes les données entrantes seront traitées!)";
SW_GS_Tooltips["SW_Filter_PC"] = "Filtre joueur activé. Fonctionne uniquement s'il a fait partie du groupe ou si vous l'avez ciblé";
SW_GS_Tooltips["SW_Filter_NPC"] = "Filtre PNJ activé. Fonctionne uniquement si vous avez ciblé le PNJ.";
SW_GS_Tooltips["SW_Filter_Group"] = "Filtre Groupe/Raid.";
SW_GS_Tooltips["SW_ClassFilterSlider"] = "Filtre par classe. Ici vous pouvez définir une classe spécifique à afficher";
SW_GS_Tooltips["SW_InfoTypeSlider"] = "Le principal sélecteur de données. Sélectionnez les données que vous voulez voir sur ce tableau. ";
SW_GS_Tooltips["SW_ColorsOptUseClass"] = "Utiliser les couleurs de classes. Les barres prendront la couleur de la classe du joueur.";
SW_GS_Tooltips["SW_Filter_EverGroup"] = "Seulement les personnes qui ont été dans votre groupe ou raid sont montrés.";
SW_GS_Tooltips["SW_OptChk_Running"] = "Décocher pour interrompre l'enregistrement de données. Cocher pour reprendre l'enregistrement. Vous ne pouvez pas interrompre l'enregistrement dans un canal Synchronisation.";
SW_GS_Tooltips["SW_Chk_ShowDPS"] = "Afficher votre DPS dans le titre de la fenêtre principale?";
SW_GS_Tooltips["SW_OptCountSlider"] = "Changer le nombre de boutons sous la fenêtre principale.";
SW_GS_Tooltips["SW_AllowARP"] = "Permettre de poster des rapports dans le raid.";
SW_GS_Tooltips["SW_DisAllowARP"] = "Interdire de poster des rapports dans le raid.";

-- 1.5 new pet filter Tooltips
SW_GS_Tooltips["SW_PF_Inactive"] = "Le nouveau filtre de familier est inactif, familiers seront affichés comme tous les autres.";
SW_GS_Tooltips["SW_PF_Active"] = "Familiers sont marqués avec "..SW_STR_PET_PREFIX.." et les contrôles mentals affichés. Seulement les stats PENDANT la posséssion sont pris en compte. (Joueurs amis contrôlés par un mob hostile ne sont pas affichés, seulement mobs contrôlés par des joueurs dans votre groupe/raid.)";
SW_GS_Tooltips["SW_PF_MM"] = "Familiers sont cachés et leurs dégâts/soins faits sont confondus avec le propriétaire.";
SW_GS_Tooltips["SW_PF_MR"] = "Familiers sont cachés et leurs dégâts/soins réçus sont confondus avec le propriétaire..";
SW_GS_Tooltips["SW_PF_MB"] = "Familiers sont cachés et leurs dégâts/soins faits ET réçus sont confondus avec le propriétaire..";
SW_GS_Tooltips["SW_PF_Current"] = "Similaire à Actif, mais seulement les familiers actuellement présents sont montrés.";
SW_GS_Tooltips["SW_PF_VPP"] = "Tous les familiers qu'un joueur a possédé sont confondus en un seul familier.";
SW_GS_Tooltips["SW_PF_VPR"] = "Tous les familiers de tout le groupe/raid sont confondus en un familier.";
SW_GS_Tooltips["SW_PF_Ignore"] = "Toutes les infos des familiers sont ingnorées..";
	
	-- 1.5.3 new colors
SW_GS_Tooltips["SW_CS_TitleBar"] =  "Ceci change la couleur de toutes les barres de titre et ses boutons. Ceci PEUT (selon les préférences)modifier la couleur des boutons sous la fenêtre principale.";
SW_GS_Tooltips["SW_CS_TitleFont"] =  "Ceci change la coulour de toutes les polices de la barre de titre et ses boutons.";
SW_GS_Tooltips["SW_CS_Backdrops"] =  "Ceci change la couleur du cadre autour de la plupart des fenêtres. La couleur des onglets seront aussi changées, mais le canal alpha sera ignoré pour onglets.";
SW_GS_Tooltips["SW_CS_MainWinBack"] = "Ceci change l'arrère-plan de la fenêtre principale.";
SW_GS_Tooltips["SW_CS_ClassCAlpha"] = "Le canal alpha marqué ici seulement sera utilisé pour colorer les classes.";


-- edit boxes
SW_GS_EditBoxes["SW_SetOptTxtFrame"] = {"Changer","Texte du bouton: ", "Texte du nouveau bouton:" };
SW_GS_EditBoxes["SW_SetFrameTxtFrame"] = {"Changer","Texte de la vue: ", "Texte de la nouvelle vue:" };
SW_GS_EditBoxes["SW_SetInfoVarTxtFrame"] = {"Changer","Info pour: ", "Nouveau nom de joueur ou familier:" };
SW_GS_EditBoxes["SW_SetSyncChanTxtFrame"] = {"Changer","Canal de Synchronisation: ", "Nouveau Canal de Synchronisation:" };

--popups
StaticPopupDialogs["SW_Reset"]["text"] = "êtes-vous certain de vouloir relancer les données??"
StaticPopupDialogs["SW_ResetFailInfo"]["text"] = "Vous vous trouvez sur un Canal de Synchronisation vous ne pouvez pas relancer les donnés!  Seulement les leaders du raid peuvent relancer les données du Canal de Synchronisation. Avec '"..SW_RootSlashes[1].." rv' vous pouvez relancer un vote.";
StaticPopupDialogs["SW_ResetSync"]["text"] = "Vous vous trouvez sur un canal de Synchronisation relancer les donnés affectera aussi les autres joueurs du raid!";
StaticPopupDialogs["SW_PostFail"]["text"] = "Vous ne pouvez pas publier des rapports ici. Les leaders du raid doivent permettre la publication des stats pour ça.";
StaticPopupDialogs["SW_InvalidChan"]["text"] = "Ce nom de canal est invalide.";

--icon menu
SW_MiniIconMenu[2]["textShow"] = "Fenêtre Principale";
SW_MiniIconMenu[2]["textHide"] = "Cacher la Fenêtre Principale";
SW_MiniIconMenu[3]["textShow"] = "Console";
SW_MiniIconMenu[3]["textHide"] = "Cacher la Console";
SW_MiniIconMenu[4]["textShow"] = "Préférences Générales";
SW_MiniIconMenu[4]["textHide"] = "Cacher préférences générales";
SW_MiniIconMenu[5]["textShow"] = "Préférences de Synchronisation";
SW_MiniIconMenu[5]["textHide"] = "Cacher préférences de Synchronisation";
--[[ needs translation
SW_MiniIconMenu[6]["textShow"] = "Zeitlinie anzeigen";
SW_MiniIconMenu[6]["textHide"] = "Zeitlinie verstecken";
--]]
SW_MiniIconMenu[8]["text"] = "Ràz des données";


-- key bindig strings
BINDING_HEADER_SW_BINDINGS = "SW Stats";
BINDING_NAME_SW_BIND_TOGGLEBARS = "Afficher/Cacher la fenêtre principale.";
BINDING_NAME_SW_BIND_CONSOLE = "Afficher/Cacher la console.";
BINDING_NAME_SW_BIND_PAGE1 = "Afficher l'onglet 1";
BINDING_NAME_SW_BIND_PAGE2 = "Afficher l'onglet 2";
BINDING_NAME_SW_BIND_PAGE3 = "Afficher l'onglet 3";
BINDING_NAME_SW_BIND_PAGE4 = "Afficher l'onglet 4";
BINDING_NAME_SW_BIND_PAGE5 = "Afficher l'onglet 5";
BINDING_NAME_SW_BIND_PAGE6 = "Afficher l'onglet 6";
BINDING_NAME_SW_BIND_PAGE7 = "Afficher l'onglet 7";
BINDING_NAME_SW_BIND_PAGE8 = "Afficher l'onglet 8";
BINDING_NAME_SW_BIND_PAGE9 = "Afficher l'onglet 9";
BINDING_NAME_SW_BIND_PAGE10 = "Afficher l'onglet 10";
--[[ needs translation
	BINDING_NAME_SW_BIND_PAGENEXT ="Next info tab";
	BINDING_NAME_SW_BIND_PAGEPREV ="Previous info tab";
--]]

-- Names and functions for available analysis
--[[ 2.0 outdated
SW_InfoTypes[1]["t"] = "Dégâts infligés (S)";
SW_InfoTypes[1]["d"] = "Affiche une liste des dégâts infligés. (Qui fait le plus de dégâts?)";
SW_InfoTypes[2]["t"] = "Soins bruts (S)";
SW_InfoTypes[2]["d"] = "Affiche une liste des soins. (Qui a soigné le plus?) Note: Soins gaspillés sont aussi pris en compte ici.";
SW_InfoTypes[3]["t"] = "Dégâts subis (S)";
SW_InfoTypes[3]["d"] = "Affiche une liste des dégâts subis. (Qui prend le plus de dommages?)";
SW_InfoTypes[4]["t"] = "Soins réçus (S)";
SW_InfoTypes[4]["d"] = "Affiche une liste des cibles soignées. (Qui se fait soigner le plus?)";
SW_InfoTypes[5]["t"] = "Info Soins faits (S)";
SW_InfoTypes[5]["d"] = "Affiche info détaillée des soins de la cible. (Qui cette personne a soigné?)";
SW_InfoTypes[6]["t"] = "Info Soins réçus (S)";
SW_InfoTypes[6]["d"] = "Affiche info détaillée des soins sur cette cible. (Par qui cette personne a été soignée?)";
SW_InfoTypes[7]["t"] = "Détails des compétences";
SW_InfoTypes[7]["d"] = "Affiche infos détaillées des compétences. (Quelle compétence cette personne utilise?) Le nombre en () proche du nom indique le dégât/soin maximum avec cette technique";
SW_InfoTypes[8]["t"] = "Détails des compétences moyen (NotS)";
SW_InfoTypes[8]["d"] = "Affiche infos détaillées des compétences en moyenne. (Quel est le dégât moyen de cette personne avec cette technique?) Le nombre proche du nom indique le nombre d'utilisations. Note: Peut avoir des nombres bizarres pour techniques faisant beaucoup de dégât instantanément suivi d'une faible dot.";
SW_InfoTypes[9]["t"] = "Type de Dégât (NotS)";
SW_InfoTypes[8]["d"] = "Affiche infos de l'école utilisée. (Quelle est la source principale des dégâts de cette personne? Par exemple feu, givre etc.)";
SW_InfoTypes[10]["t"] = "Type de dégât subi (NotS)";
SW_InfoTypes[10]["d"] = "Affiche infos de l'école subie. (Quelle est la source principale de dégâts réçus de cette personne? Par exemple feu, givre etc.)";
SW_InfoTypes[11]["t"] = "Résumé des dégâts infligés (NotS)";
SW_InfoTypes[11]["d"] = "Affiche info de l'école utilisée. (Quelle est la source principale des dégâts faits par le raid? Par exemple feu, givre etc.) Note: Utilisez des filtres.";
SW_InfoTypes[12]["t"] = "Résumé des dégâts subis (NotS)";
SW_InfoTypes[12]["d"] = "Affiche info de l'école subie. (Quelle est la source principale des dégâts subis par le raid? Par exemple feu, givre etc.) Note: Utilisez des filtres.";
SW_InfoTypes[13]["t"] = "Soins gaspillés (S)";
SW_InfoTypes[13]["d"] = "Affiche info des soins gaspillés. Le pourcentage proche du nom est son SG%. Si vous utilisez l'option %, le pourcent affiché sera la fraction totale de soins gaspillés par rapport a raid.";
SW_InfoTypes[14]["t"] = "Soins effectifs (S)";
SW_InfoTypes[14]["d"] = "Affiche liste des soins effectifs. Soins gaspillés sont soustraits donantune liste des 'vrais' soins.";
SW_InfoTypes[15]["t"] = "Efficience de la Mana";
SW_InfoTypes[15]["d"] = "Affiche la quantité de dégât/soin par point de mana. Un nombre élevé indique une haute efficience de la mana. (Ceci ne fonctionne que pour vous-même!)";
SW_InfoTypes[16]["t"] = "Efficience effectif de la mana en soins (S)";
SW_InfoTypes[16]["d"] = "Affiche la quantité de soin effectif par point de mana. Pour comparer avec des personnes qui ne sont pas dans le canal de synchronisation utilisez d'autres infos. Un rapport de 2 représente 2 PV soigné pour 1 point de mana.";
SW_InfoTypes[17]["t"] = "Compteur des morts (S)";
SW_InfoTypes[17]["d"] = "Combien de fois chacun est mort? Ceci compte les morts, pas seulement ceux que vous avez tué!";
SW_InfoTypes[18]["t"] = "Efficience de la mana en dégâts (S)";
SW_InfoTypes[18]["d"] = "Affiche la quantité de dégât infligé par point de mana. Pour comparer avec des personnes qui ne sont pas dans le Canal de Synchronisation utilisez d'autres infos. Un rapport de 2 représente 2 PV retirés pour 1 point de mana.";
SW_InfoTypes[19]["t"] = "Compteur de Decurse (S v1.5.1+)";
SW_InfoTypes[19]["d"] = "Combien de fois cette personne a decurse? :"..SW_GetSpellList();
SW_InfoTypes[20]["t"] = "Power gain (NotS)";
SW_InfoTypes[20]["d"] = "Ceci est EXPERIMENTAL, ceci compte le nombre gain de puissance et techniques sans dégât ou soin (pas certain que les techniques sans dégât ou soin seront pris en compte.)";
SW_InfoTypes[21]["t"] = "Raid Info per Second (S)";
SW_InfoTypes[21]["d"] = "Affiche diverses valeurs de DPS pour le groupe ou raid. Si vous êtes seul ces valeurs sont légèrement différentes du DPS que vous affichez à la barre de titre. (Dans le combat le temps est calculé différament)";
SW_InfoTypes[22]["t"] = "Liste des plus gros dégâts (NotS)";
SW_InfoTypes[22]["d"] = "Affiche le plus gros dégât fait par un seul coup par personne. (Plus gros critique)";
SW_InfoTypes[23]["t"] = "Liste des plus gros soins (NotS)";
SW_InfoTypes[23]["d"] = "Affiche le plus gros soin fait par un seul sort par personne. (Ceci n'inclu pas les soins gaspillés - C'est une liste du plus gros critique effectif)";
SW_InfoTypes[24]["t"] = "Intervalle Top Dégâts (S)";
SW_InfoTypes[24]["d"] = "Ceci fonctionne uniquement pour les personnes dans le Canal de Synchronisation. Affiche le plus gros dégâts infligés cumulés dans un intervalle de 5 secondes.";
SW_InfoTypes[25]["t"] = "Intervale Top soins (S)";
SW_InfoTypes[25]["d"] = "Ceci fonctionne uniquement pour les personnes dans le Canal de Synchronisation. Affiche les plus gros soins effectués cumulés dans un intervalle de 5 secondes.";
--]]


SW_mergeLocalization();
end