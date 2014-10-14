--French (frFR)Translation: kiki
--German (deDE) Translation: SirPennt
--Spanish (esES) Translation: Jsr1976

BSM_VERSION         = "1.5.18";
BSM_HELP 			= {};

--Untranslated variables
BSM_TEXT_BACK       = "Show background and meter";

if ( GetLocale() == "frFR" ) then
BINDING_HEADER_BSM  = "Indicateur dâ€™Etat des Sacs";
BINDING_NAME_BSM_OPTIONS = "Options de lâ€™IES";
BSM_HELP			= "Display the number of free bag slots for individual and all bags use /bsm for options";

BSM_MSG             = "|cffffff00Indicateur dâ€™Etat des Sacs|r: ";
BSM_AMMO			= { "Carquois", "Giberne", "Bandolier"};
BSM_WARLOCK			= { "Bourse d'\195\162me", "Sac en gangr\195\169toffe"};
BSM_PROFESSION		= { "enchant\195\169","c\195\169nari","C\195\169nari","Bourse"};
BSM_FREEBAGSLOTS 	= "Places libres:";
BSM_USEDBAGSLOTS 	= "Passible:";
BSM_BAG 			= "Le sac ";
BSM_BACKPACK        = "Le sac Ã  dos";
BSM_FULL            = " est plein!";
BSM_EMTY			= " is emty!";
BSM_LAST_STACK1 	= " seulement "; 
BSM_LAST_STACK2		= " shot or less";

BSM_OPTIONS         = "Options de IES";
BSM_OPTIONS_INDIVID = "Jauges Individuelles";
BSM_OPTIONS_OVERALL = "Jauge Globale";
BSM_OPTIONS_GLOBAL  = "Options Globales";
BSM_OPTIONS_DEFAULT = "DÃ©faut";
BSM_OPTIONS_CLOSE   = "Fermer";

BSM_TEXT_HIDE       = "Cache la jauge globale";
BSM_TEXT_SHOW       = "Affiche la jauge globale";
BSM_TEXT_INDIVIDUAL = "Active les jauges individuelles";
BSM_TEXT_OVERLAY    = "Active la sur-impression";
BSM_TEXT_BAR        = "Utilise une barre pour indiquer l\195\162€™Ã©tat des sacs";
BSM_TEXT_LABELSTAT  = "N\195\162€™utilise que du texte pour indiquer l\195\162€™Ã©tat";
BSM_TEXT_DROPDOWN   = "Utilise une boÃ®te dÃ©filante pour la jauge globale";
BSM_TEXT_BINDINGS   = "Affiche les raccourcis pour ouvrir les sacs";
BSM_TEXT_OVERALL    = "Active la jauge globale";
BSM_TEXT_OVERALLLOCK= "Verrouille la position de la jauge globale";
BSM_TEXT_OVERALLPOS = "Change la position de la jauge globale (x y):";
BSM_TEXT_SET        = "OK";
BSM_TEXT_LABELS     = "Affiche les chiffres";
BSM_TEXT_COLOR      = "Utilise des couleurs";
BSM_TEXT_TOTALS     = "Affiche la capacitÃ© des sacs";
BSM_TEXT_SLOTS      = "Affiche le nombre d'emplacements libre plutÃ´t qu'utilisÃ©s";
BSM_TEXT_TITLE      = "Affiche le titre au dessus de la jauge globale";
BSM_TEXT_NOTIFY     = "Active les notifications quand un sac est plein";
BSM_TEXT_OPTBUTTON  = "Affiche le bouton des options";
BSM_TEXT_BLIZZDISPLAY = "Cacher le compteur d'items de Blizzard";
BSM_TEXT_PROFESSION = "Inclure sacs de profession";
BSM_TEXT_WARLOCK 	= "Inclure bourse d'\195\162 me";
BSM_TEXT_AMMO 		= "Inclure sac de munitions";

elseif ( GetLocale() == "deDE" ) then
BINDING_HEADER_BSM 	= "Bag Status Meters";
BINDING_NAME_BSM_OPTIONS = "BSM Options Pane";
BSM_HELP[1]			= "Zeigt die Anzahl freier Taschenpl\195\164tze individuell und für alle Taschen an benutze /bsm für Optionen";


BSM_MSG             = "|cffffff00Bag Status Meters|r: ";

BSM_AMMO		    = { "K\195\182cher", "k\195\182cher", "Munition", "munition", "Bandolier", "Schulterg\195\188rtel" };
BSM_WARLOCK			= { "Seelenbeutel", "Teufelsstofftasche"};
BSM_PROFESSION		= { "Verzauber","verzauber", "Kr\195\164uter",};
BSM_FREEBAGSLOTS 	= "Inventar frei:";
BSM_USEDBAGSLOTS 	= "Inventar belegt:";
BSM_BAG 			= "Beutel ";
BSM_BACKPACK        = "Rucksack";
BSM_FULL            = " ist voll!";
BSM_EMTY			= " ist leer!";
BSM_LAST_STACK1		= " hat nur noch ";
BSM_LAST_STACK2		= " Schuss übrig";

BSM_OPTIONS         = "BSM Optionen";
BSM_OPTIONS_INDIVID = "Individuelles";
BSM_OPTIONS_OVERALL = "Gesamtanzeige";
BSM_OPTIONS_GLOBAL  = "Globales";
BSM_OPTIONS_DEFAULT = "Reset";
BSM_OPTIONS_CLOSE   = "Schliessen";

BSM_TEXT_HIDE       = "Gesamtanzeige verstecken";
BSM_TEXT_SHOW       = "Gesamtanzeige anzeigen";
BSM_TEXT_INDIVIDUAL = "Individuelle Beutelanzeige verwenden";
BSM_TEXT_OVERLAY    = "Status der Beutel anzeigen";
BSM_TEXT_BAR        = "Balken zum anzeigen des Status verwenden";
BSM_TEXT_LABELSTAT  = "Nur Zahlen zum anzeigen des Status verwenden";
BSM_TEXT_DROPDOWN   = "Ein Dropdownmen\195\188 zum anzeigen des Beutelstandes anzeigen";
BSM_TEXT_BINDINGS   = "Zeige Tastenkombination neben dem Dropdownmen\195\188";
BSM_TEXT_OVERALL    = "Gesamtstatusanzeige verwenden";
BSM_TEXT_OVERALLLOCK= "Gesamtstatusanzeige festsetzen (lock)";
BSM_TEXT_OVERALLPOS = "Position der Gesamtanzeige setzen (x y):";
BSM_TEXT_SET        = "Los";
BSM_TEXT_LABELS     = "Zahlen anzeigen";
BSM_TEXT_COLOR      = "Farben verwenden";
BSM_TEXT_TOTALS     = "Totalen Beutelstatus anzeigen";
BSM_TEXT_SLOTS      = "Freie Slots anzeigen, statt verwendete Slots anzeigen";
BSM_TEXT_TITLE      = "Titel über der Gesamtanzeige zeigen";
BSM_TEXT_NOTIFY     = "Text einblenden und Sound abspielen wenn ein Beutel voll ist";
BSM_TEXT_OPTBUTTON  = "Optionsbutton neben Gesamtanzeige zeigen";
BSM_TEXT_BLIZZDISPLAY = "Verstecke regul\195\164re Bag counter";
BSM_TEXT_PROFESSION = "Berufs Taschen mit einbeziehen";
BSM_TEXT_WARLOCK	= "Seelen Taschen mit einbeziehen";
BSM_TEXT_AMMO		= "Munitionsbeutel mit einbeziehen";	

elseif ( GetLocale() == "esES" ) then
BINDING_HEADER_BSM = "Bag Status Meters";
BINDING_NAME_BSM_OPTIONS = "BSM Panel de Opciones";
BSM_HELP[1]			= "Display the number of free bag slots for individual and all bags use /bsm for options";

BSM_MSG             = "|cffffff00Bag Status Meters|r: ";

BSM_AMMO 		    = { "Quiver", "Ammo", "Bandolier", "Lamina"};
BSM_WARLOCK			= { "Soul Pouch", "Felcloth Bag"};
BSM_PROFESSION		= { "Enchant","Cenarion Herb","Satchel of Cenarius"};
BSM_FREEBAGSLOTS	= "Huecos Libres en Bolsas:";
BSM_USEDBAGSLOTS 	= "Huecos Usados de Bolsas:";
BSM_BAG             = "Bolsa ";
BSM_BACKPACK        = "Mochila";
BSM_FULL            = " esta ahora llena!";
BSM_EMTY			= " is emty!";
BSM_LAST_STACK1		= " only ";
BSM_LAST_STACK2		= " shot or less";

BSM_OPTIONS         = "BSM Opciones";
BSM_OPTIONS_INDIVID = "Medidores individuales";
BSM_OPTIONS_OVERALL = "Medidor principal";
BSM_OPTIONS_GLOBAL  = "Global";
BSM_OPTIONS_DEFAULT = "Por Defecto";
BSM_OPTIONS_CLOSE   = "Cierra";

BSM_TEXT_HIDE       = "Oculta el medidor de huecos principal";
BSM_TEXT_SHOW       = "Muestra el medidor de huecos principal";
BSM_TEXT_INDIVIDUAL = "Activa estado de bolsa individual";
BSM_TEXT_OVERLAY    = "Enable bag overlay meters";
BSM_TEXT_BAR        = "Usa una barra para mostrar el estado de las bolsas";
BSM_TEXT_LABELSTAT  = "Usa solo texto para mostrar el estado de las bolsas";
BSM_TEXT_DROPDOWN   = "Usa un lista desplegable del medidor principal para mostrar\n el estado de las bolsas";
BSM_TEXT_BINDINGS   = "Muestra botones de vinculos de las bolsas";
BSM_TEXT_OVERALL    = "Activa el medidor principal";
BSM_TEXT_OVERALLLOCK= "Bloquea la posicion del medidor principal";
BSM_TEXT_OVERALLPOS = "Establece la posicion del medidor principal (x y):";
BSM_TEXT_SET        = "Establece";
BSM_TEXT_LABELS     = "Mostrar Etiquetas";
BSM_TEXT_COLOR      = "Usa color";
BSM_TEXT_TOTALS     = "Muestra huecos de bolsas totales";
BSM_TEXT_SLOTS      = "Usa huecos libres en vez de usados para mostrar";
BSM_TEXT_TITLE      = "Muestra el titulo en el medidor principal";
BSM_TEXT_NOTIFY     = "Activa notificaciones si las bolsas estan llenas";
BSM_TEXT_OPTBUTTON  = "Activa el boton de opciones";
BSM_TEXT_BLIZZDISPLAY = "Hide Blizzard bag item count";
BSM_TEXT_PROFESSION = "Include profession bags";
BSM_TEXT_WARLOCK	= "Include soul bags";
BSM_TEXT_AMMO		= "Include ammo bags";	

else
BINDING_HEADER_BSM 	= "Bag Status Meters";
BINDING_NAME_BSM_OPTIONS = "BSM Options Pane";
BSM_HELP[1]			= "Display the number of free bag slots for individual and all bags use /bsm for options";

BSM_MSG             = "|cffffff00Bag Status Meters|r: ";

BSM_AMMO 		    = { "Quiver", "Ammo", "Bandolier", "Lamina"};
BSM_WARLOCK			= { "Soul", "Felcloth"};
BSM_PROFESSION		= { "Enchant","Cenarion","Cenarius","Herb"};
BSM_FREEBAGSLOTS 	= "Free Bag Slots:";
BSM_USEDBAGSLOTS 	= "Used Bag Slots:";
BSM_BAG 			= "Bag ";
BSM_BACKPACK        = "Backpack";
BSM_FULL            = " is now full!";
BSM_EMTY			= " is emty!";
BSM_LAST_STACK1		= " only ";
BSM_LAST_STACK2		= " shot or less";

BSM_OPTIONS         = "BSM Options";
BSM_OPTIONS_INDIVID = "Individual Meters";
BSM_OPTIONS_OVERALL = "Overall Meter";
BSM_OPTIONS_GLOBAL  = "Global";
BSM_OPTIONS_DEFAULT = "Default";
BSM_OPTIONS_CLOSE   = "Close";

BSM_TEXT_HIDE       = "Hide the overall slot meter";
BSM_TEXT_SHOW       = "Show the overall slot meter";
BSM_TEXT_INDIVIDUAL = "Enable individual bag status";
BSM_TEXT_OVERLAY    = "Enable bag overlay meters";
BSM_TEXT_BAR        = "Use a bar to display bag status";
BSM_TEXT_LABELSTAT  = "Use only text to display bag status";
BSM_TEXT_DROPDOWN   = "Use a dropdown from the overall slot meter to display bag status";
BSM_TEXT_BINDINGS   = "Show key binding buttons to bags";
BSM_TEXT_OVERALL    = "Enable the overall meter";
BSM_TEXT_OVERALLLOCK= "Lock the position of the overall meter";
BSM_TEXT_OVERALLPOS = "Set the position of the overall meter (x y):";
BSM_TEXT_SET        = "Set";
BSM_TEXT_LABELS     = "Show labels";
BSM_TEXT_COLOR      = "Use color";
BSM_TEXT_TOTALS     = "Display total bag slots";
BSM_TEXT_SLOTS      = "Use free slots as opposed to used slots for display";
BSM_TEXT_TITLE      = "Display the title on the overall meter";
BSM_TEXT_NOTIFY     = "Enable notifications when bags are full";
BSM_TEXT_OPTBUTTON  = "Enable the options button";
BSM_TEXT_BLIZZDISPLAY = "Hide Blizzard bag item count";
BSM_TEXT_PROFESSION = "Include profession bags";
BSM_TEXT_WARLOCK	= "Include soul bags";
BSM_TEXT_AMMO		= "Include ammo bags";	
end
