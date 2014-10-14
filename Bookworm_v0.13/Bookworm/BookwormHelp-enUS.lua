------------------------------------------------------------------------------
-- BookwormHelp-enUS.lua
--
-- Author: Daniel Stephens <daniel@vigilance-committee.org>
-- Author: Iriel <iriel@vigilance-committee.org>
--
-- Help text - enUS localization (DEFAULT localization)
---------------------------------------------------------------------------

local HELP_PAGES = {};
local HELP_TITLE = "Bookworm Help";

HELP_PAGES[1] = [[
|cff440000Welcome to Bookworm (v0.13)|r

  Bookworm allows you to keep track of the books, plaques, letters, etc. that you encounter during your time in the world.

The most basic bookworm commands are:

|cff000000/bookworm|r
Display brief usage summary, and current settings.

|cff000000/bookworm count|r
Display a count of the number of known titles and books.

|cff000000/bookworm browse|r
Browse the contents of Bookworm.

]];

HELP_PAGES[2] = [[
|cff440000Bookworm Settings|r

|cff000000/bookworm auto|r
|cff000000/bookworm noauto|r
Turn on or off auto-page-turning for capture of book lengths and pages.

|cff000000/bookworm store|r
|cff000000/bookworm nostore|r
Turn on or off the storage of page content.

|cff000000/bookworm store all|r
Turn on storage for the content of ALL books encountered.

|cff000000/bookworm store unread|r
Turn on storage for the content of ALL unread books encountered.

|cff000000/bookworm store new|r
Turn on storage for the content of ALL new books encountered.

|cff000000/bookworm font normal|r
Display book content using normal item text font.

|cff000000/bookworm font plain|r
Display book content using plain system font.

]];

HELP_PAGES[3] = [[
|cff440000Bookworm Query Commands|r

|cff000000/bookworm nearby|r
Browse any books which have been seen near your location.

|cff000000/bookworm unread|r
Browse any books which you have not marked as read.

|cff000000/bookworm haveread|r
Browse any books which you have marked as read.

|cff000000/bookworm withcontent|r
Browse any books which have at least one captured page.

|cff000000/bookworm withnote|r
Browse any books which have a note.

]];

HELP_PAGES[4] = [[
|cff440000Bookworm Browsing|r

  When looking at a browse list, you can click on the number in front of a book title to switch to that book, or use the page buttons to browse through the list. When you select a book you're taken to that book's detail page, and from there you can flip through the pages of the book (if stored).

  While reading a book you can click on the book icon in the top left hand corner of the window to return to the list from which you arrived at the book. The update commands on the next page can also be issued while reading a book.

]];

HELP_PAGES[5] = [[
|cff440000Bookworm Categories|r

You can divide your books into categories for easier navigation. Once you have created a category, you can change the category of a book on its details page, and browse will start with a category index.

|cff000000/bookworm addcat <catid> <catname>|r
Create a new category with the id <catid> and name <catname>. The ID must consist of letters and numbers, and begin with a letter.

|cff000000/bookworm listcat|r
List all of the currently defined categories.

(continued...)

]];

HELP_PAGES[6] = [[
|cff440000Bookworm Categories Contd.|r

|cff000000/bookworm renamecat <catid> <catname>|r
Rename an existing category.

|cff000000/bookworm delcat <catid>|r
Delete an existing category - it must not contain any books.

|cff000000/bookworm index|r
Force browsing from the category index.

|cff000000/bookworm all|r
Force browsing from the list of all books.

]];

HELP_PAGES[7] = [[
|cff440000Bookworm Update Commands|r

|cff000000/bookworm read|r
|cff000000/bookworm notread|r
Use when reading a book to mark that book as read/unread. (Deprecated)

|cff000000/bookworm forget|r
Use when reading a book to forget the contents of that book.

|cff000000/bookworm note|r
|cff000000/bookworm note <note text>|r
|cff000000/bookworm note delete|r
Use to view, set, or remove the note on a book.

]];

HELP_PAGES[8] = [[
|cff440000Bookworm Advanced|r

  If you wish you can bind a key to open up the bookworm browser, go to the Key Bindings menu and look for the "|cff000000Bookworm Functions|r" section.

|cff000000/bookworm refresh|r
If for any reason you wish to refresh the internal page size cache
and other flags, this will re-scan the database and repair any broken
records.


]];

HELP_PAGES[9] = [[
|cff440000Bookworm Credits|r

  Bookworm has been brought to you by The Vigilance Committee.

  Thanks to the WoWWiki and members of the UI Customization Forum.

  And of course, many thanks to Blizzard for the game, and allowing Addons!

]];

Bookworm_HelpData = {};
Bookworm_HelpData.title = HELP_TITLE;
Bookworm_HelpData.pages = HELP_PAGES;


