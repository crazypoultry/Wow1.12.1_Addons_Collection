----------------------------------------------------------------------------------------------------
-- Localizable Strings
-- GERMAN
-- translated by: tenvan
----------------------------------------------------------------------------------------------------

if ( GetLocale() == "deDE" ) then

	-- For Binding.xml
	BINDING_NAME_QUESTHISTORYTOGGLE = "QuestHistory Umschalter";

	-- Displayed when QuestHistory is loaded
	QUESTHISTORY_LOAD_TEXT = "Jasters\228\126\153 QuestHistory v%0.2f AddOn geladen";

	-- QuestHistoryFrame text strings
	QUESTHISTORY_TITLE_FORMAT_SINGULAR = "%s - 1 Quest insgesamt";
	QUESTHISTORY_TITLE_FORMAT_PLURAL = "%s - %d Quests insgesamt";
	QUESTHISTORY_SORT_DROPDOWN_TEXT = "Sort.:";
	QUESTHISTORY_TITLESORT_TEXT = "Titel";
	QUESTHISTORY_CATEGORYSORT_TEXT = "Kategorie";
	QUESTHISTORY_TAGSORT_TEXT = "Marke";
	QUESTHISTORY_COMPLETEDSORT_TEXT = "Erledigt";
	QUESTHISTORY_CANCEL_TEXT = "Abbruch";
	QUESTHISTORY_OPTIONS_TEXT = "Optionen";
	QUESTHISTORY_CLEAR_TEXT = "Leeren";
	QUESTHISTORY_SEARCH_TEXT = "Suchen";
	QUESTHISTORY_SUBMIT_TEXT = "\195\156bernehmen";

	-- For the Sort Dropdown list
	SORT_ACCEPTED = "Reihenfolge nach Annahme";
	SORT_TITLE = "Titel";
	SORT_CATEGORY = "Kategorie";
	SORT_COMPLETED = "Reihenfolge nach Erledigtstatus";
	SORT_TAG = "Marke";
	SORT_XP = "XP Belohnung";
	SORT_MONEY = "Geld Belohnung";
	SORT_GIVER = "Quest Geber";
	SORT_COMPLETER = "Quest Abnehmer";

	-- QuestHistoryDetailFrame text strings
	QUESTHISTORY_LEVEL_ACCEPTED_TITLE = "Level erhalten:";
	QUESTHISTORY_LEVEL_LOGGED_TITLE = "Level aufgezeichnet:";
	QUESTHISTORY_LEVEL_COMPLETED_TITLE = "Level erledigt:";
	QUESTHISTORY_XP_REWARDED_TITLE = "XP Belohnuung:";
	QUESTHISTORY_MONEY_REWARDED_TITLE = "Geld Belohnung:";
	QUESTHISTORY_DETAIL_NOTES_TITLE = "Notizen:";
	QUESTHISTORY_QUEST_GIVER_TITLE = "Quest Geber:";
	QUESTHISTORY_QUEST_COMPLETER_TITLE = "Quest Abnehmer:";
	QUESTHISTORY_ACCEPTED_LOCATION_TITLE = "Angenommene in:";
	QUESTHISTORY_COMPLETED_LOCATION_TITLE = "Erledigt in:";
	QUESTHISTORY_TIME_ACCEPTED_TITLE = "Zeit angenommen:";
	QUESTHISTORY_TIME_LOGGED_TITLE = "Zeit aufgezeichnet:";
	QUESTHISTORY_TIME_COMPLETED_TITLE = "Zeit erledigt:";
	QUESTHISTORY_TIMES_ABANDONED_TITLE = "Zeit abgebrochen:";
	QUESTHISTORY_TIMES_FAILED_TITLE = "Zeit fehlgeschlagen:";
	QUESTHISTORY_SAVE_TEXT = "Speichern";
	QUESTHISTORY_EXIT_TEXT = "Beenden";
	QUESTHISTORY_NEXT_TEXT = "N\195\164chste";
	QUESTHISTORY_PREVIOUS_TEXT = "Vorherige";

	-- QuestHistoryOptionsFrame text strings
	QUESTHISTORY_OPTIONS_MENU = "QuestHistory Optionen";
	QUESTHISTORY_OKAY_TEXT = "Ok";
	QUESTHISTORY_SHOW = "Zeigen";
	QUESTHISTORY_SHOW_ABANDONED = "Abgebrochene";
	QUESTHISTORY_SHOW_CURRENT = "Aktuelle";
	QUESTHISTORY_SHOW_COMPLETED = "Erledigt";
	QUESTHISTORY_CHARACTER_DROPDOWN_TEXT = "Charakter:";
	QUESTHISTORY_LOG = "Protokolliere";
	QUESTHISTORY_LOG_CATEGORY = "Quest Kategorie";
	QUESTHISTORY_LOG_TAG = "Quest Marke";
	QUESTHISTORY_LOG_COMPLETED_ORDER = "Quest erledigt Sort.";
	QUESTHISTORY_LOG_DESCRIPTION = "Quest Beschreibung";
	QUESTHISTORY_LOG_OBJECTIVES = "Quest Aufgabe";
	QUESTHISTORY_LOG_OBJECTIVES_STATUS = "Quest Aufgabenstatus";
	QUESTHISTORY_LOG_REWARDS = "Quest Belohnungen";
	QUESTHISTORY_LOG_CHOICES = "Quest Auswahlen";
	QUESTHISTORY_LOG_SPELLS = "Quest Zauberspr\195\188che";
	QUESTHISTORY_LOG_REWARD_MONEY = "Belohnungs Geld";
	QUESTHISTORY_LOG_BACKGROUND_MATERIAL = "Hintergrundgeschichte";
	QUESTHISTORY_LOG_REQUIRED_MONEY = "Ben\195\182tigtes Geld";
	QUESTHISTORY_LOG_XP_REWARD = "XP Belohnung";
	QUESTHISTORY_LOG_QUEST_GIVER = "Quest Geber";
	QUESTHISTORY_LOG_QUEST_COMPLETER = "Quest Abnehmer";
	QUESTHISTORY_LOG_ACCEPTED_LEVEL = "Level bei Annahme";
	QUESTHISTORY_LOG_COMPLETED_LEVEL = "Level bei Erledigung";
	QUESTHISTORY_LOG_ACCEPTED_TIME = "Zeit bei Annahme";
	QUESTHISTORY_LOG_COMPLETED_TIME = "Zeit bei Erledigung";
	QUESTHISTORY_LOG_ACCEPTED_LOCATION = "Angenommen in";
	QUESTHISTORY_LOG_COMPLETED_LOCATION = "Erledigt in";
	QUESTHISTORY_ADD_TEXT = "Erg\195\164nzen";
	QUESTHISTORY_PURGE_TEXT = "Reinigen";
	QUESTHISTORY_DELETE_TEXT = "L\195\182schen";
	QUESTHISTORY_REPAIR = "Reparieren";
	QUESTHISTORY_REMOVE_PORT_QUESTS = "Port Quests l\195\182schen";
	QUESTHISTORY_REMOVE_DUPLICATES = "Dop. Quests l\195\182schen";
	QUESTHISTORY_OTHER = "Andere";
	QUESTHISTORY_ALLOW_EDITING = "Editieren erlauben";
	QUESTHISTORY_ALLOW_DELETING = "L\195\182schen erlauben";
	QUESTHISTORY_LOG_PORT_QUESTS = "Port Quests loggen";
	QUESTHISTORY_OPTION_TOOLTIP_SHOW_ABANDONED = "Zeigt abgebrochene Quests im QuestHistory Fenster an.";
	QUESTHISTORY_OPTION_TOOLTIP_SHOW_CURRENT = "Zeigt die aktuellen Quests im QuestHistory Fenster an.";
	QUESTHISTORY_OPTION_TOOLTIP_SHOW_COMPLETED = "Zeigt die erledigten Quests im QuestHistory Fenster an.";
	QUESTHISTORY_OPTION_TOOLTIP_SELECT_CHARACTER = "Aussuchen des darzustellenden Charakters.";
	QUESTHISTORY_OPTION_TOOLTIP_SELECT_COLOR = "Aussuchen der Farbgebung f\195\188r diesen Queststatus..";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_LEVEL = "Protokolliert den Schwierigkeitsgrad der Quests.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_CATEGORY = "Protokolliert die Kategorie der Quests.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_TAG = "Protokolliert die Art der Quest (z.b. Elite).";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_COMPLETED_ORDER = "Protokolliert die Reihenfolge, in der die Quests erledigt wurden.\nBitte beachten: Wenn dies abgeschaltet wird, werden Quests auch nicht mehr als erledigt gekennzeichnet.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_DESCRIPTION = "Protokolliert die Quest Beschreibung.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_OBJECTIVES = "Protokolliert die Quest Aufgabe.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_OBJECTIVES_STATUS = "Protokolliert den Aufgabenstatus (z.b. 0/1 erledigt)";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_REWARDS = "Protokolliert die Gegenstandsbelohnungen. Hiermit sind die garantierten Gegenst\195\164nde gemeint.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_CHOICES = "Protokolliert die Gegenst\195\164nde, aus denen man bei Abschluss der Quest ausw\195\164hlen kann.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_SPELLS = "Protokolliert die Zauberspruch Belohnungen (z.b. Imp).";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_REWARD_MONEY = "Protokolliert die Geldbelohnung f\195\188r die Quest.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_BACKGROUND_MATERIAL = "Protokolliert die Hintergrundgeschichte der Quest (normalerweise leer).";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_REQUIRED_MONEY = "Protokolliert das ben\195\182tigte Geld, um die Quest abschliessen zu k\195\182nnen.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_XP_REWARD = "Protokolliert die XP Belohnung f\195\188r die Quest.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_QUEST_GIVER = "Protokolliert den Quest Geber.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_QUEST_COMPLETER = "Protokolliert den NPC, der die Quest abschliessend abnimmt.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_ACCEPTED_LEVEL = "Protokolliert den Characterlevel bei Annahme der Quest.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_COMPLETED_LEVEL = "Protokolliert den Characterlevel bei Abschluss der Quest.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_ACCEPTED_TIME = "Protokolliert die gespielte Zeit bei Annahme der Quest.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_COMPLETED_TIME = "Protokolliert die gespielte Zeit bei Abschluss der Quest.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_ACCEPTED_LOCATION = "Protokolliert die Position bei Annahme der Quest.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_COMPLETED_LOCATION = "Protokolliert die Position bei Abschluss der Quest.";
	QUESTHISTORY_OPTION_TOOLTIP_ADD_QUEST = "\195\150ffnet ein Fenster, in welchem ein neues Quest manuell hinzugef\195\188gt werden kann.";
	QUESTHISTORY_OPTION_TOOLTIP_PURGE = "L\195\182scht die nicht gew\195\164hlten Daten aus der Questdatenbank !";
	QUESTHISTORY_OPTION_TOOLTIP_DELETE_CHARACTER = "L\195\182scht den derzeitig dargestellten Charakter, kann nicht dazu verwendet werden den derzeitigt eingeloggten Charakter zu l\195\182schen.";
	QUESTHISTORY_OPTION_TOOLTIP_REMOVE_PORT_QUESTS = "Aktiviert, wird die reperatur Funktion \226\128\156Port zu Auberdine/Menethil\226\128\157 Quests beseitigen.";
	QUESTHISTORY_OPTION_TOOLTIP_REMOVE_DUPLICATES = "Aktiviert, wird die reperatur Funktion Quests mit doppelten Titeln und Beschreibungen beseitigen.";
	QUESTHISTORY_OPTION_TOOLTIP_REPAIR = "Repariert die Questlogs von allen Charakteren.";
	QUESTHISTORY_OPTION_TOOLTIP_ALLOW_EDITING = "Erlaubt das Editieren von Quests. Rechtsklick auf ein Quests zum editieren.";
	QUESTHISTORY_OPTION_TOOLTIP_ALLOW_DELETING = "Erlaubt das L\195\182schen von Quests. Shift-Rechtsklick auf ein Quests zum l\195\182schen.";
	QUESTHISTORY_OPTION_TOOLTIP_LOG_PORT_QUESTS = "Erlaubt das Loggen von \226\128\156Port zu Auberdine/Menethil\226\128\157 Quests.";

	-- QuestHistoryConfirmFrame text strings
	QUESTHISTORY_CONFIRM_TEXT = "Bist du sicher ?";
	QUESTHISTORY_PURGE_CONFIRM_EXPLANATION = "Mit Fortsetzung dieser Aktion werden die Quest-Daten f\195\188r deinen aktuell eingeloggten Chararcter aufger\195\164umt.\n\nAlle Daten, die im vorherigen Dialog nicht angew\195\164hlt wurden, werden aus der Datensammlung entfernt.\n\nDies ist nicht wieder r\195\188ckg\195\164ngig zu machen.\n\nAlso im Zweifelsfalle vorher die entsprechende SavedVariables.lua Datei sichern.";
	QUESTHISTORY_DELETE_CONFIRM_EXPLANATION = "Mit Fortsetzung dieser Aktion werden die Quest-Daten f\195\188r deinen aktuell eingeloggten Chararcter gel\195\182scht.\n\nDies ist nicht wieder r\195\188ckg\195\164ngig zu machen.\n\nAlso im Zweifelsfalle vorher die entsprechende SavedVariables.lua Datei sichern.";
	QUESTHISTORY_REPAIR_CONFIRM_EXPLANATION = "Mit Fortsetzung dieser Aktion wird versucht, die Quest-Daten all deiner Charaktere aufzur\195\164umen. Dies kann zu \226\128\152nil\226\128\153 Fehlern f\195\188hren.\n\nZudem werden alle doppelten und \226\128\156Port zu Auberdine/Menethil\226\128\157 Quests aus der Datensammlung entfernt, sofern dies im vorherigen Dialog aktiviert wurde.\n\nDies ist nicht wieder r\195\188ckg\195\164ngig zu machen.\n\nAlso im Zweifelsfalle vorher die entsprechende SavedVariables.lua Datei sichern.";

	-- QuestHistoryEditFrame text strings
	QUESTHISTORY_EDIT_TITLE_TEXT = "Quest Titel:";
	QUESTHISTORY_EDIT_OBJECTIVES_TEXT = "Ziele:";
	QUESTHISTORY_ACCEPTED_TITLE = "Angenommen:";
	QUESTHISTORY_COMPLETED_TITLE = "Erledigt:";
	QUESTHISTORY_CATEGORY_TITLE = "Kategorie:";
	QUESTHISTORY_TAG_TITLE = "Marke:";

end
