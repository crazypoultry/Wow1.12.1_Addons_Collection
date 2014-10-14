----------------------------------------------------------------------------------------------------
-- Localizable Strings
-- FRENCH
-- Traduit par Juki <Unskilled>
----------------------------------------------------------------------------------------------------

if ( GetLocale() == "frFR" ) then

	-- For Binding.xml
	BINDING_HEADER_QUESTHISTORY = "Boutons QuestHistory";
	BINDING_NAME_QUESTHISTORYTOGGLE = "Afficher/Masquer QuestHistory";

	-- Displayed when QuestHistory is loaded
	QUESTHISTORY_LOAD_TEXT = "Jasters\226\128\153 QuestHistory v%0.2f AddOn Charg\195\169";

	-- QuestHistoryFrame text strings
	QUESTHISTORY_TITLE_FORMAT_SINGULAR = "%s - 1 qu\195\170te au total";
	QUESTHISTORY_TITLE_FORMAT_PLURAL = "%s - %d qu\195\170tes au total";
	QUESTHISTORY_SORT_DROPDOWN_TEXT = "Trier par";
	QUESTHISTORY_TITLESORT_TEXT = "Titre";
	QUESTHISTORY_LEVELSORT_TEXT = "Niveau";
	QUESTHISTORY_CATEGORYSORT_TEXT = "Cat\195\169gorie";
	QUESTHISTORY_COMPLETEDSORT_TEXT = "Termin\195\169e";
	QUESTHISTORY_CANCEL_TEXT = "Annuler";
	QUESTHISTORY_CLEAR_TEXT = "Effacer";
	QUESTHISTORY_SEARCH_TEXT = "Chercher";
	QUESTHISTORY_SUBMIT_TEXT = "Valider";

	-- For the Sort Dropdown list
	SORT_ACCEPTED = "Ordre Acceptation";
	SORT_TITLE = "Titre";
	SORT_LEVEL = "Niveau";
	SORT_CATEGORY = "Cat\195\169gorie";
	SORT_COMPLETED = "Ordre Termin\195\169";
	SORT_XP = "XP Gagn\195\169e";
	SORT_MONEY = "Argent Gagn\195\169";
	SORT_GIVER = "Donn\195\169e par PNJ";
	SORT_COMPLETER = "Termin\195\169e par PNJ";

	-- QuestHistoryDetailFrame text strings
	QUESTHISTORY_DETAIL_TITLE_FORMAT = "%s - Niveau %s%s";
	QUESTHISTORY_LEVEL_ACCEPTED_TITLE = "Accept\195\169e lvl :";
	QUESTHISTORY_LEVEL_LOGGED_TITLE = "Niveau not\195\169 :";
	QUESTHISTORY_LEVEL_COMPLETED_TITLE = "Termin\195\169e lvl :";
	QUESTHISTORY_XP_REWARDED_TITLE = "XP gagn\195\169e :";
	QUESTHISTORY_MONEY_REWARDED_TITLE = "Argent gagn\195\169 :";
	QUESTHISTORY_DETAIL_NOTES_TITLE = "Notes :";
	QUESTHISTORY_QUEST_GIVER_TITLE = "Donn\195\169e par :";
	QUESTHISTORY_QUEST_COMPLETER_TITLE = "Termin\195\169e par :";
	QUESTHISTORY_ACCEPTED_LOCATION_TITLE = "Accept\195\169e dans :";
	QUESTHISTORY_COMPLETED_LOCATION_TITLE = "Termin\195\169e dans :";
	QUESTHISTORY_TIME_ACCEPTED_TITLE = "Accept\195\169e \195\160 :";
	QUESTHISTORY_TIME_LOGGED_TITLE = "Temps not\195\169 :";
	QUESTHISTORY_TIME_COMPLETED_TITLE = "Termin\195\169e \195\160 :";
	QUESTHISTORY_TIMES_ABANDONED_TITLE = "Abandonn\195\169e :";
	QUESTHISTORY_TIMES_FAILED_TITLE = "Echou\195\169e :";
	QUESTHISTORY_EDIT_TEXT = "Editer";
	QUESTHISTORY_SAVE_TEXT = "Sauver";
	QUESTHISTORY_EXIT_TEXT = "Quitter";
	QUESTHISTORY_NEXT_TEXT = "Suivant";
	QUESTHISTORY_PREVIOUS_TEXT = "Pr\195\169c\195\169dent";

	-- QuestHistoryOptionsFrame text strings
	QUESTHISTORY_OPTIONS_MENU = "Options QuestHistory";
	QUESTHISTORY_OKAY_TEXT = "OK";
	QUESTHISTORY_SHOW = "Montrer";
	QUESTHISTORY_SHOW_ABANDONED = "Abandonn\195\169es";
	QUESTHISTORY_SHOW_CURRENT = "En cours";
	QUESTHISTORY_SHOW_COMPLETED = "Termin\195\169es";
	QUESTHISTORY_CHARACTER_DROPDOWN_TEXT = "Personnage :";
	QUESTHISTORY_LOG = "Noter";
	QUESTHISTORY_LOG_LEVEL = "Niveau Qu\195\170te";
	QUESTHISTORY_LOG_CATEGORY = "Cat\195\169gorie Qu\195\170te";
	QUESTHISTORY_LOG_TAG = "Tag Qu\195\170te";
	QUESTHISTORY_LOG_COMPLETED_ORDER = "Ordre Qu\195\170te Termin\195\169e";
	QUESTHISTORY_LOG_DESCRIPTION = "Description Qu\195\170te";
	QUESTHISTORY_LOG_OBJECTIVES = "Objectifs Qu\195\170te";
	QUESTHISTORY_LOG_OBJECTIVES_STATUS = "Statut Objectifs Qu\195\170te";
	QUESTHISTORY_LOG_REWARDS = "R\195\169compenses Qu\195\170te";
	QUESTHISTORY_LOG_CHOICES = "Choix Qu\195\170te";
	QUESTHISTORY_LOG_SPELLS = "Sorts Qu\195\170te";
	QUESTHISTORY_LOG_REWARD_MONEY = "Argent Qu\195\170te Gagn\195\169";
	QUESTHISTORY_LOG_BACKGROUND_MATERIAL = "Fond Mat\195\169riel";
	QUESTHISTORY_LOG_REQUIRED_MONEY = "Argent Qu\195\170te Requis";
	QUESTHISTORY_LOG_XP_REWARD = "XP Qu\195\170te Gagn\195\169e";
	QUESTHISTORY_LOG_QUEST_GIVER = "PNJ Donne Qu\195\170te";
	QUESTHISTORY_LOG_QUEST_COMPLETER = "PNJ Termine Qu\195\170te";
	QUESTHISTORY_LOG_ACCEPTED_LEVEL = "Niveau Perso Quand Accepter";
	QUESTHISTORY_LOG_COMPLETED_LEVEL = "Niveau Perso Quand Termin\195\169";
	QUESTHISTORY_LOG_ACCEPTED_TIME = "Temps De Jeu Quand Accepter";
	QUESTHISTORY_LOG_COMPLETED_TIME = "Temps De Jeu Quand Termin\195\169";
	QUESTHISTORY_LOG_ACCEPTED_LOCATION = "Zone O\195\185 Accepter";
	QUESTHISTORY_LOG_COMPLETED_LOCATION = "Zone O\195\185 Termin\195\169";
	QUESTHISTORY_ADD_TEXT = "Ajouter";
	QUESTHISTORY_PURGE_TEXT = "Purger";
	QUESTHISTORY_DELETE_TEXT = "Supprimer";
	QUESTHISTORY_REPAIR = "R\195\169parer";
	QUESTHISTORY_REMOVE_PORT_QUESTS = "Enlever qu\195\170tes \226\128\152Port\226\128\153";
	QUESTHISTORY_REMOVE_DUPLICATES = "Enlever les doubles";
	QUESTHISTORY_OTHER = "Autoriser";
	QUESTHISTORY_ALLOW_EDITING = "Edition";
	QUESTHISTORY_ALLOW_DELETING = "Suppression";
	QUESTHISTORY_LOG_PORT_QUESTS = "Tracer qu\195\170tes \226\128\152Port\226\128\153";
	QUESTHISTORY_OPTION_TOOLTIP_SHOW_ABANDONED = "Affiche les qu\195\170tes abandonn\195\169es dans la fen\195\170tre principale QuestHistory.";
	QUESTHISTORY_OPTION_TOOLTIP_SHOW_CURRENT = "Affiche les qu\195\170tes en cours dans la fen\195\170tre principale QuestHistory.";
	QUESTHISTORY_OPTION_TOOLTIP_SHOW_COMPLETED = "Affiche les qu\195\170tes termin\195\169es dans la fen\195\170tre principale QuestHistory.";
	QUESTHISTORY_OPTION_TOOLTIP_SELECT_CHARACTER = "Choisissez quel historique de personnage est affich\195\169.";
	QUESTHISTORY_OPTION_TOOLTIP_SELECT_COLOR = "Choisissez la couleur \195\160 afficher pour ce statut de qu\195\170te.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_LEVEL = "Note le niveau de difficult\195\169 des qu\195\170tes.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_CATEGORY = "Note la Cat\195\169gorie des qu\195\170tes.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_TAG = "Note le tag des qu\195\170tes (i.e. Elite).";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_COMPLETED_ORDER = "Noter l\226\128\153ordre dans lequel les qu\195\170tes ont \195\169t\195\169 termin\195\169es. Note : D\195\169sactiver ceci aura comme cons\195\169quence que les qu\195\170tes ne seront pas marqu\195\169es comme termin\195\169es.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_DESCRIPTION = "Note la description des qu\195\170tes.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_OBJECTIVES = "Note les objectifs qu\195\170tes.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_OBJECTIVES_STATUS = "Note le statut des objectifs des qu\195\170tes (i.e. 0/1 Termin\195\169).";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_REWARDS = "Noter les r\195\169compenses de la qu\195\170te. Ce sont des objets que vous gagnerez si vous terminez la qu\195\170te.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_CHOICES = "Noter les choix de r\195\169compenses de la qu\195\170te. Ce sont des objets parmis lesquels vous pourrez en choisir un si vous terminez la qu\195\170te.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_SPELLS = "Note les r\195\169compenses de sorts des qu\195\170tes.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_REWARD_MONEY = "Note l\226\128\153argent gagn\195\169 des qu\195\170tes.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_BACKGROUND_MATERIAL = "Note le fond mat\195\169riel des qu\195\170tes (Habituellement Blanc).";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_REQUIRED_MONEY = "Note l\226\128\153argent requis pour terminer la qu\195\170te.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_XP_REWARD = "Note l\226\128\153XP gagn\195\169e pour avoir termin\195\169 une qu\195\170te.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_QUEST_GIVER = "Note le PNJ qui donne la qu\195\170te.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_QUEST_COMPLETER = "Note le PNJ qui termine la qu\195\170te.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_ACCEPTED_LEVEL = "Note le niveau du personnage quand une qu\195\170te est accept\195\169e.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_COMPLETED_LEVEL = "Note le niveau du personnage quand une qu\195\170te est termin\195\169e.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_ACCEPTED_TIME = "Note le temps de jeu quand une qu\195\170te est accept\195\169e.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_COMPLETED_TIME = "Note le temps de jeu quand une qu\195\170te est termin\195\169e.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_ACCEPTED_LOCATION = "Note la zone ou le lieu du personnage quand une qu\195\170te est accept\195\169e.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_COMPLETED_LOCATION = "Note la zone ou le lieu du personnage quand une qu\195\170te est termin\195\169e.";
	QUESTHISTORY_OPTION_TOOLTIP_ADD_QUEST = "Ouvre une fen\195\170tre d\226\128\153\195\169dition, une nouvelle qu\195\170te peut \195\170tre ajouter manuellement."
	QUESTHISTORY_OPTION_TOOLTIP_PURGE = "Purge les donn\195\169es non contr\195\180l\195\169es du journal de qu\195\170te du personnage affich\195\169.";
	QUESTHISTORY_OPTION_TOOLTIP_DELETE_CHARACTER = "Efface compl\195\168tement l\226\128\153historique pour ce personnage. Ne peut \195\170tre utilis\195\169 pour supprimer les donn\195\169es pour le personnage qui est actuellement connect\195\169.";
	QUESTHISTORY_OPTION_TOOLTIP_REMOVE_PORT_QUESTS = "Si selectionn\195\169, la fonction r\195\169parer supprimera les qu\195\170tes \226\128\156Port Auberdine/Menethil\226\128\157.";
	QUESTHISTORY_OPTION_TOOLTIP_REMOVE_DUPLICATES = "Si selectionn\195\169, la fonction r\195\169parer supprimera les qu\195\170tes avec des titres et des descriptions en double.";
	QUESTHISTORY_OPTION_TOOLTIP_REPAIR = "R\195\169pare l\226\128\153historique pour tous les personnages.";
	QUESTHISTORY_OPTION_TOOLTIP_ALLOW_EDITING = "Permet l\226\128\153\195\169dition de qu\195\170tes. Faites un \226\128\152clic droit\226\128\153 sur les qu\195\170tes pour les \195\169diter.";
	QUESTHISTORY_OPTION_TOOLTIP_ALLOW_DELETING = "Permet la suppression de qu\195\170tes. Faites un \226\128\152shift + clic droit\226\128\153 sur les qu\195\170tes pour les supprimer.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_PORT_QUESTS = "Permet de tracer les qu\195\170tes \226\128\156Port Auberdine/Menethil\226\128\157.";

	-- QuestHistoryConfirmFrame text strings
	QUESTHISTORY_CONFIRM_TEXT = "Etes-vous s\195\187r ?";
	QUESTHISTORY_PURGE_CONFIRM_EXPLANATION = "Continuer avec cette proc\195\169dure effacera les donn\195\169es de qu\195\170tes sauvegard\195\169es pour ce personnage.\n\nToutes options de donn\195\169es qui n\226\128\153ont pas \195\169t\195\169 choisies sur l\226\128\153\195\169cran pr\195\169c\195\169dent seront effac\195\169es du fichier SavedVariables.lua.\n\nCes donn\195\169es ne seront pas r\195\169cup\195\169rables, c\226\128\153est pourquoi il est fortement recommand\195\169 de faire une copie de votre fichier SavedVariables.lua avant de continuer.";
	QUESTHISTORY_DELETE_CONFIRM_EXPLANATION = "Continuer avec cette proc\195\169dure effacera compl\195\168tement l\226\128\153historique pour ce personnage.\n\nCes donn\195\169es ne seront pas r\195\169cup\195\169rables, c\226\128\153est pourquoi il est fortement recommand\195\169 de faire une copie de votre fichier SavedVariables.lua avant de continuer.";
	QUESTHISTORY_REPAIR_CONFIRM_EXPLANATION = "Continuer avec cette proc\195\169dure tentera de r\195\169parer l\226\128\153historique de tous les personnages. Ceci peut parfois r\195\169soudre les erreurs \226\128\152nil\226\128\153.\n\nDe plus, cette fonction effacera toute qu\195\170te en double et les qu\195\170tes \226\128\156Port Auberdine/Menethil\226\128\157 si ces options ont \195\169t\195\169 choisies sur l\226\128\153\195\169cran pr\195\169c\195\169dent.\n\nEtant donn\195\169 que ce processus peut effacer des donn\195\169es, il est fortement recommand\195\169 de faire une copie de votre fichier SavedVariables.lua avant de continuer.";

	-- QuestHistoryEditFrame text strings
	QUESTHISTORY_EDIT_TITLE_TEXT = "Titre Qu\195\170te :";
	QUESTHISTORY_EDIT_OBJECTIVES_TEXT = "Objectifs :";
	QUESTHISTORY_ACCEPTED_TITLE = "Accept\195\169e :";
	QUESTHISTORY_LEVEL_TITLE = "Niveau :";
	QUESTHISTORY_COMPLETED_TITLE = "Termin\195\169e :";
	QUESTHISTORY_CATEGORY_TITLE = "Cat\195\169gorie :";
	QUESTHISTORY_TAG_TITLE = "Tag :";
	QUESTHISTORY_ZONE_TITLE = "Zone :";
	
end
