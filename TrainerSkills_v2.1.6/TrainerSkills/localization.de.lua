if ( GetLocale() == "deDE" ) then
--German translation by Wallenium

--Keybinding
BINDING_HEADER_TRAINERSKILLS = "TrainerSkills Belegungen";
BINDING_NAME_TOGGLETRAINERSKILLS = "TrainerSkills Fenster ein/Ausblenden";

--UI strings
TRAINERSKILLS_FRAME_TITLE = "TrainerSkills Version "..TRAINERSKILLS_VERSIONNUMBER;
TRAINERSKILLS_MYADDONS_DESCRIPTION = "Zeigt das Trainerfenster egal wo du bist";
TRAINERSKILLS_CHOOSE_TRAINER = "W\195\164hle einen Lehrer";
TRAINERSKILLS_TRAINER_DROPDOWN = "Lehrer";
TRAINERSKILLS_CHARACTER_DROPDOWN = "Charakter ausw\195\164hlen";
TRAINERSKILLS_CHARACTER_DROPDOWN_FIRST_ENTRY = "W\195\164hle einen Charakter";
TRAINERSKILLS_CHARACTER_DROPDOWN_ON = "auf"; --e.g. Huntelly <on> Aszune
TRAINERSKILLS_FILTER_DROPDOWN = "Zeige nur:";
TRAINERSKILLS_DELETE_BUTTON_CONFIRM = "Wirklich l\195\182schen?"; --Selected trainer is added after this string

--Chat output
TRAINERSKILLS_NOTIFICATION_ON = "TrainerSkills: Benachrichtigungen angeschalten";
TRAINERSKILLS_NOTIFICATION_OFF = "TrainerSkills: Benachrichtigungen ausgeschalten";

TRAINERSKILLS_CHAT_HELP_LINE1 = "Schreibe /ts oder /TrainerSkills oder lege eine Tastaturbelegung fest um das TrainerSkills Fenster zu \195\182ffnen";
TRAINERSKILLS_CHAT_HELP_LINE2 = TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."/ts reset"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE.." - alle Daten die TrainerSkills zusammengetragen hat werden gel\195\182scht.";
TRAINERSKILLS_CHAT_HELP_LINE3 = TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."/ts delete trainerType <trainer>"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE.." - z.B.: /ts delete trainerType expert leatherworker - l\195\182scht diesen Lehrer von diesem Charakter";
TRAINERSKILLS_CHAT_HELP_LINE4 = TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."/ts delete <character> "..TRAINERSKILLS_CHARACTER_DROPDOWN_ON.." <realm>"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE.." - z.B.: /ts delete Buller "..TRAINERSKILLS_CHARACTER_DROPDOWN_ON.." Aszune - l\195\182scht diesen Charakter aus TrainerSkills";
TRAINERSKILLS_CHAT_HELP_LINE5 = TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."/ts delete selected"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE.." - l\195\182scht den Lehrer der im Lehrer-DropDown Men\195\188 ausgew\195\164hlt ist";
TRAINERSKILLS_CHAT_HELP_LINE6 = TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."/ts notify"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE.." - schaltet die Benachrichtigung von TS (wenn neue F\195\164higkeiten erlernbar sind) an und aus";
TRAINERSKILLS_CHAT_HELP_LINE7 = TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."/ts cleanUp"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE.." - l\195\182scht nicht mehr ben\195\182tigte Daten von fr\195\188heren Versionen als der Trainserskills Version 1.9.1";

TRAINERSKILLS_CHAT_DELETE_DROPPED_TRAINER = TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."TrainerSkills: Bitte l\195\182sche die Lehrer, die dir nichts mehr beibringen k\195\182nnen, manuell aus TrainerSkills."..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE;
TRAINERSKILLS_CHAT_LOADED = TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."Razzer's TrainerSkills Version "..TRAINERSKILLS_VERSIONNUMBER.." geladen. /ts help oder /trainerSkills help um mehr zu erfahren."..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE;
TRAINERSKILLS_CHAT_CORUPT_DATA = "Die Daten von diesem Lehrer sind besch\195\164digt und wurden gel\195\182scht. Bitte besuche den Lehrer erneut um die Daten neu abzuspeichern..";
TRAINERSKILLS_CHAT_CHAR_DELETED = "Die Datenbank wurde aufger\195\164umt f\195\188r:"; --User input is added after this string.
TRAINERSKILLS_CHAT_CHAR_NOT_FOUND = "wurde nicht in den TrainerSkills gefunden"; --User input added in front of string.
TRAINERSKILLS_CAHT_TRAINER_DELETED = "wurde von diesem Charakter gel\195\182scht"; --User input added in front of string.
TRAINERSKILLS_CHAT_TRAINER_NOT_FOUND = "wurde bei diesem Charakter nicht gefunden"; --User input in front of string
TRAINERSKILLS_CHAT_CLEANUP = "Eintr\195\164ge gel\195\182scht"; --Number is added in front of string
TRAINERSKILLS_CHAT_CHAR_CLEARED = "Die Datenbank wurde f\195\188r diesen Charakter aufger\195\164umt";
TRAINERSKILLS_CHAT_NEW_LEARNABLE_SKILL = "DU kannst nun neu lernen:"; --Skill name is added after this sting
TRAINERSKILLS_CHAT_NEW_LERANABLE_SKILL_FROM = "von"; --Trainertype added after this string

--Tooltips
TRAINERSKILLS_TRAINER_NAMES = "Lehrernamen und Ort";
TRAINERSKILLS_CHARACTER_LEVEL = "Characterstufe:";
TRAINERSKILLS_CHARACTER_INFO = "Characterinfo:";
TRAINERSKILLS_IN = "in"; --Used in the trainer names and location tooltip (Bubber <in> Stormwind)
TRAINERSKILLS_DELETE_BUTTON = "L\195\182sche den ausgew\195\164hlten Lehrer";

--Start added in version 1.9.5
	--Chat outputs
TRAINERSKILLS_CHAT_TOTAL_TRAIN_COST = "Kosten gesammt:"; --Total cost forlearning new avaiable skills
TRAINERSKILLS_CHAT_TOTAL_TRAIN_COST_EXPLANATION = "Die Kosten knnen wegen des Rufs variieren"; --Added to the total cost line
	--Tooltips
TRAINERSKILLS_TT_TOTAL_TRAIN_COST = "Gesammtkosten fr "..TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."erlernbare"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE.." Fertigkeiten:";
TRAINERSKILLS_TT_UNAVAILABLE_TOTAL_COST = "Gesammtkosten fr "..RED_FONT_COLOR_CODE.."nicht erlernbare"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE.." Fertigkeiten:";
TRAINERSKILLS_TT_COST_STUFF = "Kosten";
--End added in version 1.9.5

--Start added in version 1.9.7
    --Tooltips
TRAINERSKILLS_MINIMAP_BUTTON = "\195\150ffnet das TrainerSkills Fenster";
    --Chat outputs
TRAINERSKILLS_MINIMAP_BUTTON_OFF = "TrainerSkills: Minimap-Button ausgeschaltet";
TRAINERSKILLS_MINIMAP_BUTTON_ON = "TrainerSkills: Minimap-Button eingeschaltet";
TRAINERSKILLS_CHAT_HELP_LINE8 = TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."/ts mmb"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE.." - schaltet den Minimap-Button ein/aus"; 
--end added in version 1.9.7

--Start added in version 2.0.1
	--Chat outputs
TRAINERSKILLS_MINIMAP_BUTTON_MOVEABLE_ON = "TrainerSkills: Minimap-Button ist nun verschiebbar";
TRAINERSKILLS_MINIMAP_BUTTON_MOVEABLE_OFF = "TrainerSkills: Minimap-Button ist nicht l\195\164nger verschiebbar";
TRAINERSKILLS_CHAT_HELP_LINE9 = TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."/ts mmbMov"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE.." - schaltet die Verschiebbarkeit des Minimap-Buttons an und aus";
	--Config panel
TRAINERSKILLS_CONFIG_HEADER = "TrainerSkills Einstellungen";
TRAINERSKILLS_OPEN_CONFIG = "Optionen";
TRAINERSKILLSCONFIG_CB_NOTIFY_LABEL = "Benachrichtigungen anschalten";
TRAINERSKILLSCONFIG_CB_NOTIFY_TOOLTIP = "Schreibt neue F\195\164higkeiten in den Chat\nWenn du sie lernen kannst.";
TRAINERSKILLSCONFIG_CB_MINIMAPBUTTON_LABEL = "Zeige Button bei der Minimap";
TRAINERSKILLSCONFIG_CB_MINIMAPBUTTON_TOOLTIP = "Macht TrainerSkills durch den Minimap\nButton leichter erreichbar";
TRAINERSKILLSCONFIG_CB_MINIMAPBUTTONMOVEABLE_LABEL = "Minimap-Button verschiebbar";
TRAINERSKILLSCONFIG_CB_MINIMAPBUTTONMOVEABLE_TOOLTIP = "Man kann den Minimap-Button nun\nan eine andere Stelle ziehen";
TRAINERSKILLSCONFIG_CB_GRAPTOOLTIPS_LABEL = "Speichere Tooltip-Infos";
TRAINERSKILLSCONFIG_CB_GRAPTOOLTIPS_TOOLTIP = "Speichert die Werte die als Tooltip\nim TS Fenster bei Icons\nangezeigt werden. ";
TRAINERSKILLSCONFIG_CB_GRAPDESCRIPTION_LABEL = "Speichere F\195\164higkeiten-Beschreibungen";
TRAINERSKILLSCONFIG_CB_GRAPDESCRIPTION_TOOLTIP = "";
TRAINERSKILLSCONFIG_CB_GRABNPCNAMESANDLOCATIONS_LABEL = "Speichere NPC Namen und Orte";
TRAINERSKILLSCONFIG_CB_GRABNPCNAMESANDLOCATIONS_TOOLTIP = "Tooltip, der den Namen und Ort\n eines NPC-Lehrers anzeigt.";
TRAINERSKILLSCONFIG_CB_SAVEPLAYERSKILLS_LABEL = "Speichere erweiterte F\195\164higkeiten";
TRAINERSKILLSCONFIG_CB_SAVEPLAYERSKILLS_TOOLTIP = "Tooltip, der Spielerwerte anzeigt,\nwenn man sich bei TS in der\nCharakterauswahl befindet.";
TRAINERSKILLSCONFIG_CB_KEEPGREYS_LABEL = "Speichere benutzte/graue F\195\164higkeiten";
TRAINERSKILLSCONFIG_CB_KEEPGREYS_TOOLTIP = "Graue/bereits benutzte\nF\195\164higkeiten trotzdem speichern";
TRAINERSKILLS_CONFIG_PURGE_BUTTON = "Bereinigen";
TRAINERSKILLS_CONFIG_PURGE_TOOLTIP = "L\195\182sche alle nicht ausgw\195\164hlte Daten";
--End added in version 2.0.1

--Start 2.0.3
TRAINERSKILLS_CHAT_ALL_GREY_DEL = "Alle F\195\164higkeiten dieses Lehrers sind grau und du hast dich entschlossen keine grauen F\195\164higkeiten zu speichern. Bitte l\195\182sche diesen Lehrer manuell.";
--end 2.0.3

--Start added in V 2.0.4
TRAINERSKILLS_CHAT_HELP_LINE10 = TRAINERSKILLS_GREEN_FONT_COLOR_CODE.."/ts completeReset"..TRAINERSKILLS_FONT_COLOR_CODE_CLOSE.." - l\195\182scht alle TS Daten! (WARNUNG: Kann nicht R\195\188ckg\195\164ngig gemacht werden!)";
TRAINERSKILLS_CHAT_COMPLEATERESET = "Alle Daten wurden gel\195\182scht.. TS wird wieder geladen...";
--End 2.0.4

TRAINERSKILLSCONFIG_CB_TRAINERFILTER_LABEL = "Speichere die Einstellungen deiner\nFilter beim Trainer";
TRAINERSKILLSCONFIG_CB_TRAINERFILTER_TOOLTIP = "Speichere deine Filtereinstellungen um erlernbare\n/unerlernbare/schon bekannte F\195\164higkeiten zu\nzeigen und die selben Filtereinstellungen wie\ndas letzte mal zu benutzen.";
TRAINERSKILLS_TITAN_MENU = "TrainerSkills (Recht)";

--Start added in version 2.1.3
TRAINERSKILLS_DELETE_CHARACTER_BUTTON = "L\195\182sche den ausgew\195\164hlten Charakter";
--end 
end