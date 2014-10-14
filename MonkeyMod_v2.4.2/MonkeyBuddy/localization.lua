--[[

	MonkeyBuddy:
	Helps you configure your MonkeyMods.
	
	Website:	http://www.toctastic.net/
	Author:		Trentin (monkeymods@gmail.com)
	
	
	Contributors:
	Pkp
		- Some initial xml work.

	Juki
		- French translation

	Sasmira
		- Additional French translation
		
	Jim Bim
		- German translation

--]]


-- English
MONKEYBUDDY_TITLE					= "MonkeyBuddy";
MONKEYBUDDY_VERSION					= "2.4.2";
MONKEYBUDDY_FRAME_TITLE				= MONKEYBUDDY_TITLE .. " v" .. MONKEYBUDDY_VERSION;
MONKEYBUDDY_DESCRIPTION				= "Helps you configure your MonkeyMods.";
MONKEYBUDDY_INFO_COLOUR				= "|cffffff00";
MONKEYBUDDY_LOADED_MSG				= MONKEYBUDDY_INFO_COLOUR .. MONKEYBUDDY_TITLE .. " v" .. MONKEYBUDDY_VERSION .. " loaded";

MONKEYBUDDY_TOOLTIP_CLOSE			= "Close";
MONKEYBUDDY_RESET_ALL				= "Reset All";
MONKEYBUDDY_RESET					= "Reset";

-- defs for MonkeyQuest
MONKEYBUDDY_QUEST_TITLE						= "MonkeyQuest";
MONKEYBUDDY_QUEST_OPEN						= "Open MonkeyQuest";
MONKEYBUDDY_QUEST_SHOWHIDDEN				= "Show hidden items";
MONKEYBUDDY_QUEST_USEOVERVIEWS				= "Use overviews when there's no objectives";
MONKEYBUDDY_QUEST_HIDEHEADERS				= "Hide zone headers if not showing hidden items";
MONKEYBUDDY_QUEST_ALWAYSHEADERS				= "Always show zone headers, always";
MONKEYBUDDY_QUEST_HIDEBORDER				= "Hide the border";
MONKEYBUDDY_QUEST_GROWUP					= "Expand upwards";
MONKEYBUDDY_QUEST_SHOWNUMQUESTS				= "Show the number of quests";
MONKEYBUDDY_QUEST_LOCK						= "Lock the MonkeyQuest frame";
MONKEYBUDDY_QUEST_COLOURTITLEON				= "Colour the quest titles by difficulty";
MONKEYBUDDY_QUEST_HIDECOMPLETEDQUESTS		= "Hide completed quests";
MONKEYBUDDY_QUEST_HIDECOMPLETEDOBJECTIVES	= "Hide completed objectives";
MONKEYBUDDY_QUEST_SHOWTOOLTIPOBJECTIVES		= "Show objective completeness in tooltips";
MONKEYBUDDY_QUEST_ALLOWRIGHTCLICK			= "Allow right click to open MonkeyBuddy";
MONKEYBUDDY_QUEST_HIDETITLEBUTTONS			= "Hide the title buttons";
MONKEYBUDDY_QUEST_HIDETITLE					= "Hide the title (" .. MONKEYBUDDY_QUEST_TITLE .. ") text";
MONKEYBUDDY_QUEST_CRASHFONT					= "Use the skinny font";
MONKEYBUDDY_QUEST_CRASHBORDER				= "Use the golden border colour";
MONKEYBUDDY_QUEST_SHOWNOOBTIPS				= "Show helpful tooltips for Noobs";
MONKEYBUDDY_QUEST_SHOWZONEHIGHLIGHT			= "Show quest zone highlighting";
MONKEYBUDDY_QUEST_SHOWQUESTLEVEL			= "Show the quest levels";


MONKEYBUDDY_QUEST_QUESTTITLECOLOUR			= "Quest Titles";
MONKEYBUDDY_QUEST_HEADEROPENCOLOUR			= "Open Zone Headers";
MONKEYBUDDY_QUEST_HEADERCLOSEDCOLOUR		= "Closed Zone Headers";
MONKEYBUDDY_QUEST_OVERVIEWCOLOUR			= "Quest Overviews";
MONKEYBUDDY_QUEST_SPECIALOBJECTIVECOLOUR	= "Special Objectives";
MONKEYBUDDY_QUEST_INITIALOBJECTIVECOLOUR	= "Objectives at 0%";
MONKEYBUDDY_QUEST_MIDOBJECTIVECOLOUR		= "Objectives at 50%";
MONKEYBUDDY_QUEST_COMPLETEOBJECTIVECOLOUR	= "Objectives at 100%";
MONKEYBUDDY_QUEST_ZONEHIGHLIGHTCOLOUR		= "Current Zone Highlight";

MONKEYBUDDY_QUEST_FRAMEALPHASLIDER			= "Global Alpha";
MONKEYBUDDY_QUEST_ALPHASLIDER				= "Background Alpha";
MONKEYBUDDY_QUEST_WIDTHSLIDER				= "Frame Width";
MONKEYBUDDY_QUEST_FONTSLIDER				= "Font Size";
MONKEYBUDDY_QUEST_PADDINGSLIDER				= "Quest Padding";

-- defs for MonkeySpeed
MONKEYBUDDY_SPEED_TITLE				= "MonkeySpeed";
MONKEYBUDDY_SPEED_OPEN				= "Open MonkeySpeed";
MONKEYBUDDY_SPEED_PERCENT			= "Show speed as a percent";
MONKEYBUDDY_SPEED_BAR				= "Show speed as a background colour";
MONKEYBUDDY_SPEED_LOCK				= "Lock the MonkeySpeed frame";
MONKEYBUDDY_SPEED_ALLOWRIGHTCLICK	= "Allow right click to open MonkeyBuddy";

MONKEYBUDDY_SPEED_WIDTHSLIDER		= "Frame Width";

-- defs for MonkeyClock
MONKEYBUDDY_CLOCK_TITLE				= "MonkeyClock";
MONKEYBUDDY_CLOCK_OPEN				= "Open MonkeyClock";
MONKEYBUDDY_CLOCK_HIDEBORDER		= "Hide the border";
MONKEYBUDDY_CLOCK_USEMILITARYTIME	= "Use 24 hour clock";
MONKEYBUDDY_CLOCK_LOCK				= "Lock the MonkeyClock frame";
MONKEYBUDDY_CLOCK_CHATALARM			= "Use the alarm message in the chat window";
MONKEYBUDDY_CLOCK_DIALOGALARM		= "Use the alarm dialog box with snooze button";
MONKEYBUDDY_CLOCK_ALLOWRIGHTCLICK	= "Allow right click to open MonkeyBuddy";

MONKEYBUDDY_CLOCK_HOURSLIDER		= "Hour Offset";
MONKEYBUDDY_CLOCK_MINUTESLIDER		= "Minute Offset";

MONKEYBUDDY_CLOCK_ALARMHOURSLIDER	= "Alarm Hour";
MONKEYBUDDY_CLOCK_ALARMMINUTESLIDER	= "Alarm Minute";

-- bindings
BINDING_HEADER_MONKEYBUDDY 			= MONKEYBUDDY_TITLE;
BINDING_NAME_MONKEYBUDDY_OPEN 		= "Open/Close the config frame";


if ( GetLocale() == "frFR" ) then
    -- Traduit par Juki <Unskilled>
	-- Updated 01/04/06 ( Sasmira )
    
    MONKEYBUDDY_DESCRIPTION				= "Vous aide à configurer vos MonkeyMods.";
    MONKEYBUDDY_LOADED_MSG				= MONKEYBUDDY_INFO_COLOUR .. MONKEYBUDDY_TITLE .. " v" .. MONKEYBUDDY_VERSION .. " chargé";

    MONKEYBUDDY_TOOLTIP_CLOSE			= "Fermer";
    MONKEYBUDDY_RESET_ALL            = "R.\195\160.Z. Totale";
    MONKEYBUDDY_RESET               = "R.\195\160.Z.";
   
    -- defs for MonkeyQuest
    MONKEYBUDDY_QUEST_TITLE            = "MonkeyQuest";
    MONKEYBUDDY_QUEST_OPEN            = "Ouvrir MonkeyQuest";
    MONKEYBUDDY_QUEST_SHOWHIDDEN      = "Montrer toutes les qu\195\170tes";
    MONKEYBUDDY_QUEST_USEOVERVIEWS      = "Utiliser la description lorsqu\'il n\'y a pas d\'objectifs";
    MONKEYBUDDY_QUEST_HIDEHEADERS      = "Cacher les noms de zone";
    MONKEYBUDDY_QUEST_HIDEBORDER      = "Cacher les bords";
    MONKEYBUDDY_QUEST_GROWUP         = "Augmenter la fen\195\170tre vers le haut";
    MONKEYBUDDY_QUEST_SHOWNUMQUESTS      = "Montrer le nombre de qu\195\170tes";
    MONKEYBUDDY_QUEST_LOCK            = "Bloquer la fen\195\170tre MonkeyQuest";
    MONKEYBUDDY_QUEST_COLOURTITLEON      = "Colorer les titres de qu\195\170tes selon la difficult\195\169";
    MONKEYBUDDY_QUEST_HIDECOMPLETEDQUESTS   = "Cacher les qu\195\170tes termin\195\169es";
    MONKEYBUDDY_QUEST_HIDECOMPLETEDOBJECTIVES   = "Cacher les objectifs termin\195\169s";
    MONKEYBUDDY_QUEST_SHOWTOOLTIPOBJECTIVES      = "Afficher les objectifs dans la bulle d\'aide";
    MONKEYBUDDY_QUEST_ALLOWRIGHTCLICK         = "Clic droit pour ouvrir MonkeyBuddy";
    MONKEYBUDDY_QUEST_HIDETITLEBUTTONS         = "Cacher les boutons de titre";
    MONKEYBUDDY_QUEST_HIDETITLE               = "Cacher le texte (" .. MONKEYBUDDY_QUEST_TITLE .. ") dans le titre";
    MONKEYBUDDY_QUEST_CRASHFONT               = "Utiliser la police de Crash";
    MONKEYBUDDY_QUEST_CRASHBORDER            = "Utiliser la couleur de bordure de Crash";
    MONKEYBUDDY_QUEST_SHOWNOOBTIPS            = "Afficher les bulles d\'aide pour les Noobs";

    MONKEYBUDDY_QUEST_QUESTTITLECOLOUR         = "Titre des Qu\195\170tes";
    MONKEYBUDDY_QUEST_HEADEROPENCOLOUR         = "Ouvrir le nom des zones";
    MONKEYBUDDY_QUEST_HEADERCLOSEDCOLOUR      = "Fermer le nom des zones";
    MONKEYBUDDY_QUEST_OVERVIEWCOLOUR         = "Vues d\'ensemble des Qu\195\170tes";
    MONKEYBUDDY_QUEST_SPECIALOBJECTIVECOLOUR   = "Objectifs Sp�ciaux";
    MONKEYBUDDY_QUEST_INITIALOBJECTIVECOLOUR   = "Objectifs \195\160 0%";
    MONKEYBUDDY_QUEST_MIDOBJECTIVECOLOUR      = "Objectifs \195\160 50%";
    MONKEYBUDDY_QUEST_COMPLETEOBJECTIVECOLOUR   = "Objectifs \195\160 100%";
    MONKEYBUDDY_QUEST_ZONEHIGHLIGHTCOLOUR      = "Surligner la Zone courrante";

    MONKEYBUDDY_QUEST_FRAMEALPHASLIDER         = "Transparence globale";
    MONKEYBUDDY_QUEST_ALPHASLIDER            = "Transparence du fond";
    MONKEYBUDDY_QUEST_WIDTHSLIDER            = "Largeur de la fen\195\170tre";
    MONKEYBUDDY_QUEST_FONTSLIDER            = "Taille de la Police";
    MONKEYBUDDY_QUEST_PADDINGSLIDER            = "Quest Padding";
    
    -- defs for MonkeySpeed
    MONKEYBUDDY_SPEED_TITLE				= "MonkeySpeed";
    MONKEYBUDDY_SPEED_OPEN				= "Ouvrir MonkeySpeed";
    MONKEYBUDDY_SPEED_PERCENT			= "Montrer la vitesse comme un pourcentage";
    MONKEYBUDDY_SPEED_BAR				= "Montrer la vitesse comme une couleur de fond";
    MONKEYBUDDY_SPEED_ALLOWRIGHTCLICK         = "Clic droit pour ouvrir MonkeyBuddy";
    
    -- defs for MonkeyClock
    MONKEYBUDDY_CLOCK_TITLE				= "MonkeyClock";
    MONKEYBUDDY_CLOCK_OPEN				= "Ouvrir MonkeyClock";
    MONKEYBUDDY_CLOCK_HIDEBORDER		= "Cacher les bords";
    MONKEYBUDDY_CLOCK_USEMILITARYTIME	= "Utiliser le format 24 heures";

    MONKEYBUDDY_CLOCK_MINUTESLIDER		= "Réglage Minute";
    MONKEYBUDDY_CLOCK_HOURSLIDER		= "Réglage Heure";
    MONKEYBUDDY_CLOCK_ALLOWRIGHTCLICK   = "Clic droit pour ouvrir MonkeyBuddy";
    
    -- bindings
    BINDING_HEADER_MONKEYBUDDY 			= MONKEYBUDDY_TITLE;
    BINDING_NAME_MONKEYBUDDY_OPEN 		= "Ouvrir/Fermer la fenêtre de configuration";
    
end    

if (GetLocale() == "deDE") then

	MONKEYBUDDY_DESCRIPTION				= "Hilft Euch beim Einstellen Euer MonkeyMods.";
	MONKEYBUDDY_LOADED_MSG				= MONKEYBUDDY_INFO_COLOUR .. MONKEYBUDDY_TITLE .. " v" .. MONKEYBUDDY_VERSION .. " geladen";
	
	MONKEYBUDDY_TOOLTIP_CLOSE			= "Schlie\195\159en";
	MONKEYBUDDY_RESET_ALL				= "Alles Zur\195\188cksetzen";
	MONKEYBUDDY_RESET					= "Zur\195\188cksetzen";
	
	-- defs for MonkeyQuest
	MONKEYBUDDY_QUEST_OPEN				= "\195\150ffne MonkeyQuest";
	MONKEYBUDDY_QUEST_SHOWHIDDEN			= "Zeige ausgeblendete Elemente";
	MONKEYBUDDY_QUEST_USEOVERVIEWS		= "Benutze Questanweisungen, wenn keine Ziele vorhanden sind";
	MONKEYBUDDY_QUEST_HIDEHEADERS			= "Verberge Questzonen, wenn ausgeblendete Elemente versteckt werden";
	MONKEYBUDDY_QUEST_ALWAYSHEADERS		= "Zeige die Questzonen immer";
	MONKEYBUDDY_QUEST_HIDEBORDER			= "Verberge den Rahmen";
	MONKEYBUDDY_QUEST_GROWUP			= "Erweitere MonkeyQuest nach oben hin";
	MONKEYBUDDY_QUEST_SHOWNUMQUESTS		= "Zeige die Anzahl der Quests";
	MONKEYBUDDY_QUEST_LOCK				= "Fixiere das MonkeyQuest Fenster";
	MONKEYBUDDY_QUEST_COLOURTITLEON		= "F\195\164rbe die Quests der Schwierigkeit ensprechend ein";
	MONKEYBUDDY_QUEST_HIDECOMPLETEDQUESTS	= "Verberge erf\195\188llte Quests";
	MONKEYBUDDY_QUEST_HIDECOMPLETEDOBJECTIVES	= "Verberge erf\195\188llte Ziele";
	MONKEYBUDDY_QUEST_SHOWTOOLTIPOBJECTIVES	= "Zeige Zielfortschritte in Tooltips";
	MONKEYBUDDY_QUEST_ALLOWRIGHTCLICK		= "\195\150ffnen von MonkeyBuddy durch Rechtsklick erm\195\182glichen";
	MONKEYBUDDY_QUEST_HIDETITLEBUTTONS		= "Verberge die Titel-Buttons";
	MONKEYBUDDY_QUEST_HIDETITLE			= "Verberge den Text (" .. MONKEYBUDDY_QUEST_TITLE .. ") im Titel";
	MONKEYBUDDY_QUEST_CRASHFONT			= "Verwende eine d\195\188nne Schriftart";
	MONKEYBUDDY_QUEST_CRASHBORDER			= "Benutze die goldene Rahmen-Farbe";
	MONKEYBUDDY_QUEST_SHOWNOOBTIPS		= "Zeige hilfreiche Kurzinfos f\195\188r Anf\195\164nger";
	MONKEYBUDDY_QUEST_SHOWZONEHIGHLIGHT		= "Hebe die aktuelle Questzone hervor";
	MONKEYBUDDY_QUEST_SHOWQUESTLEVEL		= "Zeige das Questlevel";
	
	
	MONKEYBUDDY_QUEST_QUESTTITLECOLOUR		= "Quest-Titel";
	MONKEYBUDDY_QUEST_HEADEROPENCOLOUR		= "Offene Zonen";
	MONKEYBUDDY_QUEST_HEADERCLOSEDCOLOUR	= "Geschlossene Zonen";
	MONKEYBUDDY_QUEST_OVERVIEWCOLOUR		= "Questanweisungen";
	MONKEYBUDDY_QUEST_SPECIALOBJECTIVECOLOUR	= "Spezielle Ziele";
	MONKEYBUDDY_QUEST_INITIALOBJECTIVECOLOUR	= "Ziele zu 0% erf\195\188llt";
	MONKEYBUDDY_QUEST_MIDOBJECTIVECOLOUR	= "Ziele zu 50% erf\195\188llt";
	MONKEYBUDDY_QUEST_COMPLETEOBJECTIVECOLOUR	= "Ziele zu 100% erf\195\188llt";
	MONKEYBUDDY_QUEST_ZONEHIGHLIGHTCOLOUR	= "Questzonen-Hervorhebung";
	
	MONKEYBUDDY_QUEST_FRAMEALPHASLIDER		= "Global Alpha";
	MONKEYBUDDY_QUEST_ALPHASLIDER			= "Hintergrund Alpha";
	MONKEYBUDDY_QUEST_WIDTHSLIDER			= "Fensterbreite";
	MONKEYBUDDY_QUEST_FONTSLIDER			= "Schriftgr\195\182\195\159e";
	MONKEYBUDDY_QUEST_PADDINGSLIDER		= "Zeilenabstand";
	
	-- defs for MonkeySpeed
	MONKEYBUDDY_SPEED_OPEN				= "\195\150ffne MonkeySpeed";
	MONKEYBUDDY_SPEED_PERCENT			= "Zeige Geschwindigkeit in Prozent";
	MONKEYBUDDY_SPEED_BAR				= "Zeige Geschwindigkeit als farbigen Hintergrund";
	MONKEYBUDDY_SPEED_LOCK				= "Fixiere das MonkeySpeed Fenster";
	
	MONKEYBUDDY_SPEED_WIDTHSLIDER			= "Fensterbreite";
	MONKEYBUDDY_SPEED_ALLOWRIGHTCLICK		= "\195\150ffnen von MonkeyBuddy durch Rechtsklick erm\195\182glichen";
	
	-- defs for MonkeyClock
	MONKEYBUDDY_CLOCK_OPEN				= "\195\150ffne MonkeyClock";
	MONKEYBUDDY_CLOCK_HIDEBORDER			= "Verberge den Rahmen";
	MONKEYBUDDY_CLOCK_USEMILITARYTIME		= "Benutze den 24-Stundentakt";
	MONKEYBUDDY_CLOCK_LOCK				= "Fixiere das MonkeyClock Fenster";
	MONKEYBUDDY_CLOCK_CHATALARM			= "Aktviere die Alarm-Mitteilung im Nachrichtenfenster";
	MONKEYBUDDY_CLOCK_DIALOGALARM			= "Aktiviere die Alarm-Mitteilung als PopUp mit Verl\195\164ngerungsoption";

	MONKEYBUDDY_CLOCK_HOURSLIDER			= "Stundenausgleich";
	MONKEYBUDDY_CLOCK_MINUTESLIDER		= "Minutenausgleich";
	
	MONKEYBUDDY_CLOCK_ALARMHOURSLIDER		= "Alarmstunde";
	MONKEYBUDDY_CLOCK_ALARMMINUTESLIDER		= "Alarmminute";
	MONKEYBUDDY_CLOCK_ALLOWRIGHTCLICK		= "\195\150ffnen von MonkeyBuddy durch Rechtsklick erm\195\182glichen";
	
	-- bindings
	BINDING_NAME_MONKEYBUDDY_OPEN 		= "\195\150ffne/Schlie\195\159e das Optionsfenster";

end
