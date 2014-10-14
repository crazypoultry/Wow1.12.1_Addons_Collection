------------------------------------------------------------------------------
-- Bookworm.lua
--
-- Author: Daniel Stephens <daniel@vigilance-committee.org>
-- Author: Iriel <iriel@vigilance-committee.org>
--
-- Global constants and Localization
---------------------------------------------------------------------------

-- Globals for blizzard integration
-- Key bindings
BINDING_HEADER_BOOKWORM="Bookworm Functions";
BINDING_NAME_BOOKWORM_BROWSE="Browse All Books";
BINDING_NAME_BOOKWORM_UNREAD="Browse Unread Books";
BINDING_NAME_BOOKWORM_NEARBY="Browse Nearby Books";
-- Slash commands
SLASH_BOOKWORMCOMMAND1 = "/bookworm";
SLASH_BOOKWORMCOMMAND2 = "/bw";

-- Commands and subcommands/options
BOOKWORM_CMD={};
BOOKWORM_CMD.Store = "store";
BOOKWORM_CMD.Store_All = "all";
BOOKWORM_CMD.Store_Unread = "unread";
BOOKWORM_CMD.Store_New = "new";
BOOKWORM_CMD.NoStore = "nostore";
BOOKWORM_CMD.Font = "font";
BOOKWORM_CMD.Font_Normal = "normal";
BOOKWORM_CMD.Font_Plain = "plain";
BOOKWORM_CMD.Auto = "auto";
BOOKWORM_CMD.NoAuto = "noauto";
BOOKWORM_CMD.Count = "count";
BOOKWORM_CMD.Nearby = "nearby";
BOOKWORM_CMD.Browse = "browse";
BOOKWORM_CMD.Index = "index";
BOOKWORM_CMD.All = "all";
BOOKWORM_CMD.Forget = "forget";
BOOKWORM_CMD.Read = "read";
BOOKWORM_CMD.NotRead = "notread";
BOOKWORM_CMD.Note = "note";
BOOKWORM_CMD.Note_Delete = "delete";
BOOKWORM_CMD.AddCat = "addcat";
BOOKWORM_CMD.DelCat = "delcat";
BOOKWORM_CMD.RenameCat = "renamecat";
BOOKWORM_CMD.ListCat = "listcat";
BOOKWORM_CMD.HaveRead = "haveread";
BOOKWORM_CMD.WithContent = "withcontent";
BOOKWORM_CMD.WithNote = "withnote";
BOOKWORM_CMD.Unread = "unread"
BOOKWORM_CMD.Help = "help"
BOOKWORM_CMD.Refresh = "refresh";

-- Message catalog
BOOKWORM_MSG={};
BOOKWORM_MSG.MissingMessage = "[[MISSING BOOKWORM MESSAGE %s]]";
BOOKWORM_MSG.DatabaseUpdate = "Updated database for latest version.";
BOOKWORM_MSG.DatabaseNewer = "WARNING: Database is newer than addon code!";
BOOKWORM_MSG.NoView = "Not viewing anything.";
BOOKWORM_MSG.NoViewBook = "Not viewing a book.";
BOOKWORM_MSG.ForgetNoPages = "No pages to forget.";
BOOKWORM_MSG.ForgetPages = "Forgetting pages of book.";
BOOKWORM_MSG.StateNowRead = "Marked book as read.";
BOOKWORM_MSG.StateNowUnread = "Marked book as unread.";
BOOKWORM_MSG.NoNote = "Book has no note.";
BOOKWORM_MSG.NoteCleared = "Cleared book note.";
BOOKWORM_MSG.NoteSet = "Set note to: %s.";

BOOKWORM_MSG.AddCatUsage = "Usage: /bookworm addcat <catid> <cat name>";
BOOKWORM_MSG.RenameCatUsage = "Usage: /bookworm renamecat <catid> <new name>";
BOOKWORM_MSG.DelCatUsage = "Usage: /bookworm delcat <catid>";
BOOKWORM_MSG.CatAdded = "Created new category '%s' (%s)";
BOOKWORM_MSG.CatRenamed = "Renamed category '%s' (%s)";
BOOKWORM_MSG.CatDeleted = "Deleted category '%s' (%s)";

BOOKWORM_MSG.UnknownStoreOption = "Unknown store option '%s'";
BOOKWORM_MSG.StoreStatusUnread = "Will store unread page content.";
BOOKWORM_MSG.StoreStatusNew = "Will store new page content.";
BOOKWORM_MSG.StoreStatusAll = "Will store all page content.";
BOOKWORM_MSG.StoreStatusNone = "Will not store page content.";

BOOKWORM_MSG.UnknownFontOption = "Unknown font option '%s'";
BOOKWORM_MSG.FontStatusNormal = "Displaying content in normal book font.";
BOOKWORM_MSG.FontStatusPlain = "Displaying content in plain font.";

BOOKWORM_MSG.AutoStatusOn = "Will automatically turn pages.";
BOOKWORM_MSG.AutoStatusOff = "Will not automatically turn pages.";

BOOKWORM_MSG.Count = "Books: %d (Titles: %d, Page Data ~%dK)";
BOOKWORM_MSG.NoLocation = "Unable to determine current location.";
BOOKWORM_MSG.UnknownCommand = "Unknown subcommand '%s' (Try /bookworm help)";
BOOKWORM_MSG.Summary = "Use \"/bookworm help\" to browse help (v0.13)";
BOOKWORM_MSG.Alert = "Bookworm Alert\n%s";

BOOKWORM_MSG.TitleAll = "All Books";
BOOKWORM_MSG.TitleRead = "Read Books";
BOOKWORM_MSG.TitleUnread = "Unread Books";
BOOKWORM_MSG.TitleNote = "Books with a Note";
BOOKWORM_MSG.TitleNoNote = "Books with no Note";
BOOKWORM_MSG.TitleContent = "Books with Content";
BOOKWORM_MSG.TitleNoContent = "Books with no Content";
BOOKWORM_MSG.TitleNearby = "Nearby Books";
BOOKWORM_MSG.TitleDetails = "Details";

BOOKWORM_MSG.NoMatchFound = "No Matching Books Found.";
BOOKWORM_MSG.PageNotCaptured = "(Page Not Captured)";
BOOKWORM_MSG.InfoTitle = "Title: %s";
BOOKWORM_MSG.PageSizeByte="%d byte";
BOOKWORM_MSG.PageSizeBytes="%d bytes";
BOOKWORM_MSG.PageSizeNoData="No Data";
BOOKWORM_MSG.PagesUnknown="Pages: Unknown (%s)";
BOOKWORM_MSG.PagesMoreThan="Pages: More than %s (%s)";
BOOKWORM_MSG.PagesNumber="Pages: %s (%s)";
BOOKWORM_MSG.CategoryHeader="Category:";
BOOKWORM_MSG.SeenInHeader="Seen in:";
BOOKWORM_MSG.YouHaveRead="You have read this book.";
BOOKWORM_MSG.YouHaveNotRead="This book is unread.";
BOOKWORM_MSG.NoteHeader="Note:";
BOOKWORM_MSG.DetailsPageLabel="Details";

BOOKWORM_MSG.ActionReset="[Reset]";
BOOKWORM_MSG.ActionMarkRead="[Mark as Read]";
BOOKWORM_MSG.ActionGo="[Go]";
BOOKWORM_MSG.ActionSet="[Set]";
BOOKWORM_MSG.ActionChange="[Change]";
BOOKWORM_MSG.ActionCancel="[CANCEL]";

BOOKWORM_MSG.UnknownHyperlink = "Unknown hyperlink '%s'.";
BOOKWORM_MSG.BookNotFound = "Book %s (%s) not found.";
BOOKWORM_MSG.MustReplacePage = "Need to replace this page!";
BOOKWORM_MSG.BookKnownNewLoc = "Known Book, New location (Pages: %s)";
BOOKWORM_MSG.BookKnown = "Known Book (Pages: %s)";
BOOKWORM_MSG.BookNewComplete = "Completed new Book (Pages: %s)";
BOOKWORM_MSG.BookComplete = "Completed Book (Pages: %s)";
BOOKWORM_MSG.BookIncompleteNew = "Incomplete new book.";
BOOKWORM_MSG.BookIncompleteKnown = "Incomplete known book.";
BOOKWORM_MSG.TurnToNext = "Please turn to the next page...";
BOOKWORM_MSG.MissingPage = "Missing Page %s.";
BOOKWORM_MSG.UnnamedCategoryName = "Un-named Category '%s'";

BOOKWORM_MSG.InvalidCategoryId = "Invalid Category ID '%s'";
BOOKWORM_MSG.UnknownCategoryId = "Unknown Category ID '%s'";
BOOKWORM_MSG.CategoryExists = "Category '%s' already exists (%s)";
BOOKWORM_MSG.CategoryInUse = "Category '%s' (%s) is in use.";
BOOKWORM_MSG.Uncategorized = "Uncategorized";
BOOKWORM_MSG.CategoryIndexTitle = "Category Index";
BOOKWORM_MSG.IndexTitle = "Index";
BOOKWORM_MSG.CategoryIndexHeader = "Select a category to browse:";
BOOKWORM_MSG.CategoryIndexSubHeader = "Browse a type of book:";
BOOKWORM_MSG.CategorySetTitle = "Categorize %s";
BOOKWORM_MSG.CategorySetHeader = "Select a new category for this book (Currently: %s):\n ";

BOOKWORM_MSG.CategoryListEntry = "%s (%s)";
BOOKWORM_MSG.CategoryListEmpty = "No categories defined.";

