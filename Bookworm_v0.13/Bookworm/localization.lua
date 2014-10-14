------------------------------------------------------------------------------
-- localization.lua
--
-- Author: Iriel <iriel@vigilance-committee.org>
--
-- Localization for global constants
-- See Bookworm.lua for master (enUS) versions and keys
-- See locale specific help files for help text
---------------------------------------------------------------------------

-- deDE Localization (Once done)
if (GetLocale() == "deDE") then
-- Key bindings
   BINDING_HEADER_BOOKWORM="Bookworm Funktionen";
   BINDING_NAME_BOOKWORM_BROWSE="Alle B\195\188cher anzeigen";
   BINDING_NAME_BOOKWORM_UNREAD="Ungelesene B\195\188cher anzeigen";
   BINDING_NAME_BOOKWORM_NEARBY="B\195\188cher in der N\195\164he anzeigen";
   
   -- Slash commands
   SLASH_BOOKWORMCOMMAND1 = "/bookworm";
   SLASH_BOOKWORMCOMMAND2 = "/bw";

   -- Message catalog
   -- Start with a fresh catalog to make finding omissions easier
   BOOKWORM_MSG={};
   BOOKWORM_MSG.MissingMessage = "[[FEHLENDE BOOKWORM NACHRICHT %s]]";
   BOOKWORM_MSG.DatabaseUpdate = "Datenbank f\195\188r die neueste Version aktualisiert.";
   BOOKWORM_MSG.DatabaseNewer = "WARNUNG: Datanbank neuer als das Addon!";
   BOOKWORM_MSG.NoView = "Du schaust dir gerade nichts an.";
   BOOKWORM_MSG.NoViewBook = "Du schaust dir gerade kein Buch an.";
   BOOKWORM_MSG.ForgetNoPages = "Keine Seiten, die vergessen werden k\195\182nnen.";
   BOOKWORM_MSG.ForgetPages = "Vergesse Seiten des Buches.";
   BOOKWORM_MSG.StateNowRead = "Buch als gelesen markiert.";
   BOOKWORM_MSG.StateNowUnread = "Buch als ungelesen markiert.";
   BOOKWORM_MSG.NoNote = "Keine Notiz f\195\188r Buch vorhanden.";
   BOOKWORM_MSG.NoteCleared = "Notiz f\195\188r Buch gel\195\182scht.";
   BOOKWORM_MSG.NoteSet = "Notiz eingeben f\195\188r: %s.";

   BOOKWORM_MSG.AddCatUsage = "Verwendung: /bookworm addcat <catid> <cat Name>";
   BOOKWORM_MSG.RenameCatUsage = "Verwendung: /bookworm renamecat <catid> <neuer Name>";
   BOOKWORM_MSG.DelCatUsage = "Verwendung: /bookworm delcat <catid>";
   BOOKWORM_MSG.CatAdded = "Neue Kategorie erstellt '%s' (%s)";
   BOOKWORM_MSG.CatRenamed = "Kategorie umbenannt '%s' (%s)";
   BOOKWORM_MSG.CatDeleted = "Kategorie gel\195\182scht '%s' (%s)";

   BOOKWORM_MSG.UnknownStoreOption = "Unbekannte Speicheroption '%s'";
   BOOKWORM_MSG.StoreStatusUnread = "Will store unread page content.";
   BOOKWORM_MSG.StoreStatusNew = "Neuer Seiteninhalt wird gespeichert.";
   BOOKWORM_MSG.StoreStatusAll = "Alle Seiteninhalte werden gespeichert.";
   BOOKWORM_MSG.StoreStatusNone = "Seiteninhalte werden nicht gespeichert.";

   BOOKWORM_MSG.UnknownFontOption = "Unbekannte Schriftart-Option '%s'";
   BOOKWORM_MSG.FontStatusNormal = "Inhalt wird mit normaler Buch-Schriftart angezeigt.";
   BOOKWORM_MSG.FontStatusPlain = "Inhalt wird mit einfacher Schriftart angezeigt.";

   BOOKWORM_MSG.AutoStatusOn = "Seiten werden automatisch weiter gebl\195\164ttert.";
   BOOKWORM_MSG.AutoStatusOff = "Seiten werden NICHT automatisch weiter gebl\195\164ttert.";

   BOOKWORM_MSG.Count = "B\195\188cher: %d (Titel: %d, Seitendaten ~%dK)";
   BOOKWORM_MSG.NoLocation = "Aktuelle Position konnte nicht ermittelt werden.";
   BOOKWORM_MSG.UnknownCommand = "Unbekanntes Unterkommanda '%s' (Siehe \"/bookworm help\")";
   BOOKWORM_MSG.Summary = "Verwende \"/bookworm help\", um die Hilfe anzeigen zu lassen (v0.7)";
   BOOKWORM_MSG.Alert = "Bookworm Meldung\n%s";

   BOOKWORM_MSG.TitleAll = "Alle B\195\188cher";
   BOOKWORM_MSG.TitleRead = "Gelesene B\195\188cher";
   BOOKWORM_MSG.TitleUnread = "Ungelesene B\195\188cher";
   BOOKWORM_MSG.TitleNote = "B\195\188cher mit einer Notiz";
   BOOKWORM_MSG.TitleNoNote = "B\195\188cher ohne Notiz";
   BOOKWORM_MSG.TitleContent = "B\195\188cher mit Inhalt";
   BOOKWORM_MSG.TitleNoContent = "B\195\188cher ohne Inhalt";
   BOOKWORM_MSG.TitleNearby = "B\195\188cher in der N\195\164he";
   BOOKWORM_MSG.TitleDetails = "Details";

   BOOKWORM_MSG.NoMatchFound = "Keine B\195\188cher entsprechen den Kriterien.";
   BOOKWORM_MSG.PageNotCaptured = "(Seite nicht gespeichert)";
   BOOKWORM_MSG.InfoTitle = "Titel: %s";
   BOOKWORM_MSG.PageSizeByte="%d Byte";
   BOOKWORM_MSG.PageSizeBytes="%d Bytes";
   BOOKWORM_MSG.PageSizeNoData="Keine Daten";
   BOOKWORM_MSG.PagesUnknown="Seitenanzahl: Unbekannt (%s)";
   BOOKWORM_MSG.PagesMoreThan="Seitenanzahl: Mehr als %s (%s)";
   BOOKWORM_MSG.PagesNumber="Seitenanzahl: %s (%s)";
   BOOKWORM_MSG.CategoryHeader="Kategorie:";
   BOOKWORM_MSG.SeenInHeader="Gesehen in:";
   BOOKWORM_MSG.YouHaveRead="Du hast dieses Buch gelesen.";
   BOOKWORM_MSG.YouHaveNotRead="Dieses Buch ist ungelesen.";
   BOOKWORM_MSG.NoteHeader="Notiz:";
   BOOKWORM_MSG.DetailsPageLabel="Details";

   BOOKWORM_MSG.ActionReset="[Zur\195\188cksetzen]";
   BOOKWORM_MSG.ActionMarkRead="[Als gelesen markieren]";
   BOOKWORM_MSG.ActionGo="[Weiter]";
   BOOKWORM_MSG.ActionSet="[W\195\164hlen]";
   BOOKWORM_MSG.ActionChange="[\195\132ndern]";
   BOOKWORM_MSG.ActionCancel="[ABBRUCH]";

   BOOKWORM_MSG.UnknownHyperlink = "Unbekannter Hyperlink '%s'.";
   BOOKWORM_MSG.BookNotFound = "Buch %s (%s) nicht gefunden.";
   BOOKWORM_MSG.MustReplacePage = "Diese Seite muss ersetzt werden!";
   BOOKWORM_MSG.BookKnownNewLoc = "Bekanntes Buch, Neuer Ort (Seiten: %s)";
   BOOKWORM_MSG.BookKnown = "Bekanntes Buch (Seiten: %s)";
   BOOKWORM_MSG.BookNewComplete = "Vollst\195\164ndiges neues Buch (Seiten: %s)";
   BOOKWORM_MSG.BookComplete = "Vollst\195\164ndiges Buch (Seiten: %s)";
   BOOKWORM_MSG.BookIncompleteNew = "Unvollst\195\164ndiges neues Buch.";
   BOOKWORM_MSG.BookIncompleteKnown = "Unvollst\195\164ndiges bekanntes Buch.";
   BOOKWORM_MSG.TurnToNext = "Bitte zur n\195\164chsten Seite bl\195\164ttern...";
   BOOKWORM_MSG.MissingPage = "Fehlende Seite %s.";
   BOOKWORM_MSG.UnnamedCategoryName = "Unbenannte Kategorie '%s'";

   BOOKWORM_MSG.InvalidCategoryId = "Ung\195\188ltige Kategorie ID '%s'";
   BOOKWORM_MSG.UnknownCategoryId = "Unbekannte Kategorie ID '%s'";
   BOOKWORM_MSG.CategoryExists = "Kategorie '%s' existiert bereits (%s)";
   BOOKWORM_MSG.CategoryInUse = "Kategorie '%s' (%s) wird bereits verwendet.";
   BOOKWORM_MSG.Uncategorized = "Nicht eingeordnet";
   BOOKWORM_MSG.CategoryIndexTitle = "Kategorie-Index";
   BOOKWORM_MSG.IndexTitle = "Index";
   BOOKWORM_MSG.CategoryIndexHeader = "W\195\164hle eine Kategorie zum Surchbl\195\164ttern:";
   BOOKWORM_MSG.CategoryIndexSubHeader = "B\195\188cher eines Typs durchbl\195\164ttern:";
   BOOKWORM_MSG.CategorySetTitle = "%s einordnen";
   BOOKWORM_MSG.CategorySetHeader = "Neue Kategorie f\195\188r dieses Buch w\195\164hlen (Momentan: %s):\n ";

   BOOKWORM_MSG.CategoryListEntry = "%s (%s)";
   BOOKWORM_MSG.CategoryListEmpty = "Keine Kategorien definiert.";
end
