------------------------------------------------------------------------------
-- BookwormHelp.lua
--
-- Author: Iriel <iriel@vigilance-committee.org>
--
-- Help text - deDE localization
---------------------------------------------------------------------------

-- EXAMPLE ONLY AT THIS POINT NO ACTUAL TRANSLATION

if ( GetLocale() == "deDE" ) then
   local HELP_PAGES = {};
   local HELP_TITLE = "Bookworm Hilfe";

HELP_PAGES[1] = [[
|cff440000Willkommen bei Bookworm (v0.13)|r

Bookworm erlaubt es Euch ]]..'B\195\188cher'..[[, Plaketten, Briefe, usw., auf die Ihr in der Welt trefft im Auge zu behalten.

Die grundlegenden Bookworm-Befehle sind:

|cff000000/bookworm|r
Zeigt Verwendungshinweise und aktuelle Einstellungen an.

|cff000000/bookworm count|r
Zeigt Anzahl der bekannten Titel und ]]..'B\195\188cher'..[[ an.

|cff000000/bookworm browse|r
Bookworm Inhalte ]]..'durchbl\195\164ttern'..[[.

]];

HELP_PAGES[2] = [[
|cff440000Bookworm Einstellungen|r

|cff000000/bookworm auto|r
|cff000000/bookworm noauto|r
De-/aktiviert automatisches ]]..'Weiterbl\195\164ttern zur Ermittlung der Buchgr\195\182sse und Seiteninhalte'..[[.

|cff000000/bookworm store|r
|cff000000/bookworm nostore|r
De-/aktiviert Speicherung der Seiteninhalte.

|cff000000/bookworm store all|r
Aktiviert Speicherung der Seiteninhalte ]]..'f\195\188r ALLE B\195\188cher'..[[.

|cff000000/bookworm store unread|r
Aktiviert Speicherung der Seiteninhalte ]]..'f\195\188r ALLE ungelesenen B\195\188cher'..[[.

|cff000000/bookworm store new|r
Aktiviert Speicherung der Seiteninhalte ]]..'f\195\188r ALLE neuen B\195\188cher'..[[.

|cff000000/bookworm font normal|r
Zeige Inhalte in zum Gegenstand (Buch, Steinplatte...) ]]..'zugeh\195\182riger Schriftart'..[[.

|cff000000/bookworm font plain|r
Zeige Inhalte in einfacher Systemschriftart.

]];

HELP_PAGES[3] = [[
|cff440000Bookworm Suchbefehle|r

|cff000000/bookworm nearby|r
]]..'B\195\188cher in der N\195\164he der aktuellen Position durchbl\195\164ttern'..[[.

|cff000000/bookworm unread|r
]]..'Ungelesene B\195\188cher durchbl\195\164ttern'..[[.

|cff000000/bookworm haveread|r
]]..'Gelesene B\195\188cher durchbl\195\164ttern'..[[.

|cff000000/bookworm withcontent|r
]]..'B\195\188cher mit mindestens einer gespeicherten Seite durchbl\195\164ttern'..[[.

|cff000000/bookworm withnote|r
]]..'B\195\188cher mit Notiz durchbl\195\164ttern'..[[.

]];

HELP_PAGES[4] = [[
|cff440000Bookworm ]]..'Bl\195\164ttern'..[[|r

]]..'  In der B\195\188cherliste reicht ein Klick auf die Zahl vor dem Buchtitel, um zur Detailseite zu wechseln. Die Seitenkn\195\182pfe dienen zum bl\195\164ttern durch die Liste. Auf der Detailseite eines Titels dienen die Seitenkn\195\182pfe zum Bl\195\164ttern durch die Inhalte, sofern diese gespeichert wurden'..[[.

]]..'  W\195\164hrend des Lesens bringt dich ein Klick auf das Buchsymbol oben links zur\195\188ck zur B\195\188cherliste \195\188ber die das Buch ausgew\195\164hlt wurde. Die Aktualisierungsbefehle der n\195\164chsten Seite k\195\182nnen auch w\195\164hrend des Lesens ausgef\195\188hrt werden'..[[.

]];

HELP_PAGES[5] = [[
|cff440000Bookworm Kategorien|r

]]..'Du kannst deine B\195\188cher zur besseren \195\156bersicht in Kategorien einordnen. Nach dem Erstellen einer Kategorie kann jedes Buch auf dessen Detailseite zugeordnet werden. Das Bl\195\164ttern wird ausserdem im Kategorie-Index beginnen'..[[.

|cff000000/bookworm addcat <catid> <catname>|r
Erstelle eine neue Kategorie mit der ID <catid> und dem Namen <catname>. Die ID muss aus Buchstaben und Zahlen bestehen und mit einem Buchstaben anfangen.

|cff000000/bookworm listcat|r
Alle aktuell definierten Kategorien auflisten.

]]..'(Fortsetzung n\195\164chste Seite...)'..[[

]];

HELP_PAGES[6] = [[
|cff440000Bookworm Kategorien Forts.|r

|cff000000/bookworm renamecat <catid> <catname>|r
Vorhandene Kategorie umbenennen.

|cff000000/bookworm delcat <catid>|r
]]..'Vorhandene Kategorie l\195\182schen - Der Kategorie d\195\188rfen keine B\195\188cher zugeordnet sein'..[[.

|cff000000/bookworm index|r
]]..'Bl\195\164ttern im Kategorie-Index erzwingen'..[[.

|cff000000/bookworm all|r
]]..'Bl\195\164ttern in der Liste aller Titel erzwingen'..[[.

]];

HELP_PAGES[7] = [[
|cff440000Bookworm Aktualisierungsbefehle|r

|cff000000/bookworm read|r
|cff000000/bookworm notread|r
]]..'Beim Lesen eines Buches verwenden, um das Buch als un-/gelesen zu markieren. (\195\156berfl\195\188ssig'..[[)

|cff000000/bookworm forget|r
]]..'Beim Lesen eines Buches verwenden, um dessen gespeicherte Inhalte zu l\195\182schen'..[[.

|cff000000/bookworm note|r
|cff000000/bookworm note <Notiz>|r
|cff000000/bookworm note delete|r
Verwendung, um Notizen zu einem Buch anzusehen, zu erstellen oder zu entfernen.

]];

HELP_PAGES[8] = [[
|cff440000Bookworm Fortgeschrittene Benutzung|r

]]..'Du kannst auch eine Taste belegen, um die B\195\188cherliste zu \195\182ffnen. \195\150ffne dazu das Men\195\188 \"Tastaturbelegung\" und suche nach dem Abschnitt "|cff000000Bookworm Funktionen|r"'..[[.

|cff000000/bookworm refresh|r
]]..'Wenn du, aus welchem Grund auch immer den internen Speicher f\195\188r die Seitenanzahl aktualisieren lassen willst verwende diesen Befehl. Die Datenbank wird neu gescannt und fehlerhafte Eintr\195\164ge werden repariert'..[[.


]];

HELP_PAGES[9] = [[
|cff440000Bookworm Credits|r

  Bookworm wurde programmiert von The Vigilance Committee.

  Dank an das WoWWiki und die Mitglieder des UI Customization Forums.

]]..'  Und nat\195\188rlich vielen Dank an Blizzard f\195\188r dieses Spiel und die M\195\182glichkeit, Add-Ons zu erstellen'..[[!

]];

   -- Replace default localization with this one.
   Bookworm_HelpData = {};
   Bookworm_HelpData.title = HELP_TITLE;
   Bookworm_HelpData.pages = HELP_PAGES;
end