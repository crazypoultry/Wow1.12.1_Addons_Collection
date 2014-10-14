-- Translation :
--   DE: Iruwen
if (GetLocale() == "deDE") then

-- MYADDONS
MYINVENTORY_MYADDON_NAME = "MyInventory";
MYINVENTORY_MYADDON_DESCRIPTION = "Vereinfachtes, kompakteres Inventar.";
--KEYBINDINGS
BINDING_HEADER_MYINVENTORYHEADER= "MyInventory";
BINDING_NAME_MYINVENTORYICON= "MyInventory Toggle";
BINDING_NAME_MYINVENTORYCONFIG   = "MyInventory Konfigurationsfenster";
-- USAGE
MYINVENTORY_CHAT_COMMAND_USAGE= {
[1] = "Usage: /mi [Befehl]",
[2] = "Befehle:",
[3] = "show - MyInventory Fenster zeigen/verstecken",
[4] = "replace - Taschen ersetzen oder nicht",
[5] = "cols - Anzahl der Spalten (Taschenplaetze pro Zeile)",
[6] = "lock - Fenster Verschieben sperren/entsperren",
[7] = "back - Hintergrund aktivieren/deaktivieren",
[8] = "freeze - Fenster bei Haendlern geoeffnet lassen",
[9] = "count - Freie/belegte Taschenplaetze umschalten",
[10]= "title - Titel zeigen/verstecken",
[11]= "cash - Geld zeigen/verstecken",
[12]= "buttons - Buttons zeigen/verstecken",
[13]= "config - Konfigurationsfenster oeffnen"
--Didn't put these into slash commands yet
--[10] = "highlightitems - Items hervorheben wenn Maus ueber Tasche",
--[11] = "highlightbags - Tasche hervorheben wenn Maus ueber Item",
}
--MESSAGES
MYINVENTORY_MSG_LOADED = "Svartens/Rambles MyInventory AddOn geladen.";
MYINVENTORY_MSG_INIT_s   = "MyInventory: Profil fuer %s initialisiert.";
MYINVENTORY_MSG_CREATE_s = "MyInventory: Erstelle neues Profil fuer %s";
--OPTION TOGGLE MESSAGES
MYINVENTORY_CHAT_PREFIX            = "MyInventory: ";
MYINVENTORY_CHAT_REPLACEBAGSON     = "Ersetze Taschen.";
MYINVENTORY_CHAT_REPLACEBAGSOFF    = "Ersetze Taschen nicht.";
MYINVENTORY_CHAT_GRAPHICSON        = "Hintergrundgrafik aktiviert.";
MYINVENTORY_CHAT_GRAPHICSOFF       = "Hintergrundgrafik deaktiviert.";
MYINVENTORY_CHAT_BACKGROUNDON      = "Hintergrund undurchsichtig.";
MYINVENTORY_CHAT_BACKGROUNDOFF     = "Hintergrund durchsichtig.";
MYINVENTORY_CHAT_HIGHLIGHTBAGSON   = "Hebe Taschen hervor.";
MYINVENTORY_CHAT_HIGHLIGHTBAGSOFF  = "Hebe Taschen nicht hervor.";
MYINVENTORY_CHAT_HIGHLIGHTITEMSON  = "Hebe Items hervor.";
MYINVENTORY_CHAT_HIGHLIGHTITEMSOFF = "Hebe Items nicht hervor.";
MYINVENTORY_CHAT_FREEZEON          = "Inventar bleibt nach Haendlerbesuch offen.";
MYINVENTORY_CHAT_FREEZEOFF         = "Inventar wird nach Haendlerbesuch geschlossen.";
MYINVENTORY_CHAT_COUNTON           = "Zeige belegte Taschenplaetze."
MYINVENTORY_CHAT_COUNTOFF          = "Zeige freie Taschenplaetze."
MYINVENTORY_CHAT_SHOWTITLEON       = "Zeige Titel."
MYINVENTORY_CHAT_SHOWTITLEOFF      = "Verstecke Titel."
MYINVENTORY_CHAT_CASHON            = "Zeige Geld."
MYINVENTORY_CHAT_CASHOFF           = "Verstecke Geld."
MYINVENTORY_CHAT_BUTTONSON         = "Zeige Buttons."
MYINVENTORY_CHAT_BUTTONSOFF        = "Verstecke Buttons."
--MyInventory Title
MYINVENTORY_TITLE     = "Inventory";
MYINVENTORY_TITLE_S   = "%s's Inventory";
MYINVENTORY_TITLE_SS  = "%s of %s's Inventory";
MYINVENTORY_SLOTS_DD  = "%d/%d Slots";
--MyInventory Options frame
MYINVENTORY_CHECKTEXT_REPLACEBAGS    = "Ersetze Standard-Taschen";
MYINVENTORY_CHECKTEXT_GRAPHICS       = "Aktiviere Hintergrund";
MYINVENTORY_CHECKTEXT_BACKGROUND     = "Opaker Hintergrund";
MYINVENTORY_CHECKTEXT_HIGHLIGHTBAGS  = "Hebe Tasche hervor";
MYINVENTORY_CHECKTEXT_HIGHLIGHTITEMS = "Hebe Item hervor";
MYINVENTORY_CHECKTEXT_SHOWTITLE      = "Zeige Titel"
MYINVENTORY_CHECKTEXT_CASH           = "Zeige Geld"
MYINVENTORY_CHECKTEXT_BUTTONS        = "Zeige Buttons"
MYINVENTORY_CHECKTEXT_FREEZE         = "Fenster bleibt geoeffnet"
MYINVENTORY_CHECKTEXT_COUNTUSED      = "Belegte Plaetze"
MYINVENTORY_CHECKTEXT_COUNTFREE      = "Freie Plaetze"
MYINVENTORY_CHECKTEXT_COUNTOFF       = "Aus"

MYINVENTORY_CHECKTIP_REPLACEBAGS     = "MyInventory ersetzt die Standard-Taschen wenn aktiviert.";
MYINVENTORY_CHECKTIP_GRAPHICS        = "Aktiviert Hintergrundgrafik im Blizzard-Stil.";
MYINVENTORY_CHECKTIP_BACKGROUND      = "Laesst den Hintergund undurchsichtig erscheinen wenn aktiviert.";
MYINVENTORY_CHECKTIP_HIGHLIGHTBAGS   = "Hebt die Tasche hervor in der sich ein Item befindet wenn man mit der Maus darauf zeigt.";
MYINVENTORY_CHECKTIP_HIGHLIGHTITEMS  = "Hebt die Items hervor die sich in einer Tasche befinden wenn man mit der Maus darauf zeigt.";
MYINVENTORY_CHECKTIP_SHOWTITLE       = "Zeigt den Fenstertitel an wenn aktiviert."
MYINVENTORY_CHECKTIP_CASH            = "Zeigt das Bargeld an wenn aktiviert."
MYINVENTORY_CHECKTIP_BUTTONS         = "Zeigt die Buttons an wenn aktiviert."
MYINVENTORY_CHECKTIP_FREEZE          = "Fenster bleibt bei Verlassen des Haendlers, der Bank oder des Auktionshauses geoeffnet."
MYINVENTORY_CHECKTIP_COUNTUSED       = "Zeigt die Zahl der belegten Taschenplaetze an."
MYINVENTORY_CHECKTIP_COUNTFREE       = "Zeigt die Zahl der freien Taschenplaetze an."
MYINVENTORY_CHECKTIP_COUNTOFF        = "Versteckt die Zahl der freien/belegten Taschenplaetze."

end
