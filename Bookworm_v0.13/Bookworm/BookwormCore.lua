------------------------------------------------------------------------------
-- BookwormCore.lua
--
-- Author: Daniel Stephens <daniel@vigilance-committee.org>
-- Author: Iriel <iriel@vigilance-committee.org>
--
-- Core bookworm functionality, including book list management
---------------------------------------------------------------------------

local CURRENT_DB_VERSION = 2;

local VERSION_KEY = "version";
local BOOK_LIST_KEY = "bookList";
local CATEGORY_KEY = "categories";

-- Key for flag indicating that content should be stored
local STORE_CONTENT_KEY = "storeContent";
-- Key for flag indicating storage restrictions
--   nil = all
--   "unread" = unread only
--   "new" = new books only
local STORE_MODE_KEY = "storeMode";
-- Key for flag indicating that automatic page flipping should occur
local AUTO_PAGE_KEY = "autoPage";
-- Key for flag indicating that plain font should be used
local PLAIN_FONT_KEY = "plainFont"

local LOC_PLAYER = 1;
local LOC_MAP = 2;
local LOC_MAP_X = 3;
local LOC_MAP_Y = 4;
local LOC_SUBZONE = 5;

-- Export handy constants
BookwormConstant = {};
BookwormConstant.LOC_PLAYER  = LOC_PLAYER;
BookwormConstant.LOC_MAP     = LOC_MAP;
BookwormConstant.LOC_MAP_X   = LOC_MAP_X;
BookwormConstant.LOC_MAP_Y   = LOC_MAP_Y;
BookwormConstant.LOC_SUBZONE = LOC_SUBZONE;

BookwormConstant.STORE_CONTENT_KEY = STORE_CONTENT_KEY;
BookwormConstant.STORE_MODE_KEY = STORE_MODE_KEY;
BookwormConstant.AUTO_PAGE_KEY = AUTO_PAGE_KEY;
BookwormConstant.PLAIN_FONT_KEY = PLAIN_FONT_KEY;

Bookworm = {};

-- Return message from message catalog
function Bookworm.GetMessage(msgKey, ...)
   local msg = BOOKWORM_MSG[msgKey];
   if (msg == nil) then
      if (msgKey == "MissingMessage") then
         return nil;
      end
      local missing = Bookworm.GetMessage("MissingMessage", msgKey);
      if (not missing) then
         return "[[MISSING BOOKWORM MESSAGE - " .. msgKey .. "]]";
      end
      return missing;
   elseif (arg.n > 0) then
      return string.format(msg, unpack(arg));
   end
   return msg;
end

-- Show notification message from message catalog
function Bookworm.Notify(msgKey, ...)
   local msg = "Bookworm: " .. Bookworm.GetMessage(msgKey,unpack(arg));
   if( DEFAULT_CHAT_FRAME ) then
      DEFAULT_CHAT_FRAME:AddMessage(msg);
   end
end

-- Show notification message from message catalog and alert popup
function Bookworm.Alert(msgKey, ...)
   local msg = Bookworm.GetMessage(msgKey, unpack(arg));
   local alert = Bookworm.GetMessage("Alert", msg);
   if( DEFAULT_CHAT_FRAME ) then
      DEFAULT_CHAT_FRAME:AddMessage("Bookworm: " .. msg);
   end
   message(alert);
end

-- Given a text string return the bookworm hash of it
-- Returns hash
--  hash - String hash
function Bookworm.HashText(text)
   local l = strlen(text);
   local h = 0;
   for i=1,l,1 do
      v = strbyte(text, i);
      h = mod((h*27 + v), 65536);
   end
   return "1-" .. l .. "-" .. h;
end

-- Perform any updates required due to version change
local function Bookworm_Core_Update()
   local newVersion = BookwormBooks[VERSION_KEY];
   local needRefresh = false;

   -- vers1 - Add the pageSize value, this can be done by issuing a refresh
   if (newVersion < 1) then
      needRefresh = true;
      newVersion = 1;
   end
   -- vers2 - Add categories for sorting/arrangement
   if (newVersion < 2) then
      BookwormBooks[CATEGORY_KEY] = {};
      newVersion = 2;
   end

   if (needRefresh) then
      Bookworm.Refresh()
   end

   Bookworm.Notify("DatabaseUpdate");
   BookwormBooks[VERSION_KEY] = newVersion;
end

-- Initialize the bookworm saved variable
function Bookworm_Core_Init()
   if (BookwormBooks == nil) then
      BookwormBooks = {}
      BookwormBooks[VERSION_KEY] = CURRENT_DB_VERSION;
      BookwormBooks[BOOK_LIST_KEY] = {};
      BookwormBooks[CATEGORY_KEY] = {};
   end

   if (BookwormBooks[VERSION_KEY] < CURRENT_DB_VERSION) then
      Bookworm_Core_Update();
   elseif (BookwormBooks[VERSION_KEY] > CURRENT_DB_VERSION) then
      Bookworm.Alert("DatabaseNewer");
   end
end

-- Return a book given its title and hash
-- Returns book
--  book - Book structure
function Bookworm.GetBookById(title, hash)
   local bookList = BookwormBooks[BOOK_LIST_KEY];
   if (bookList == nil) then
      return;
   end
   local titleSet = bookList[title];
   if (titleSet == nil) then
      return;
   end
   for k,v in pairs(titleSet) do
      if (v.hash == hash) then
         return v;
      end
   end
   return;
end

-- Return a book given its title and either the book or a hash
-- Returns book structure
function Bookworm.GetBook(title, bookOrHash)
   if (title == nil) then
      return nil;
   end
   if (type(bookOrHash) == 'table') then
      return bookOrHash;
   end
   return Bookworm.GetBookById(title,bookOrHash);
end

-- Find a book by its title and first page content
-- Returns book, ifCreated
--  book      - Book structure
--  ifCreated - true if the book was newly created, nil otherwise
function Bookworm.FindBook(title, firstPage, createFlag)
   local bookList = BookwormBooks[BOOK_LIST_KEY];
   if (bookList == nil) then
      bookList = {}
      BookwormBooks[BOOK_LIST_KEY] = bookList;
   end
   local titleSet = bookList[title];
   if ((titleSet == nil) and (not createFlag)) then
      return;
   end
   local pageHash = Bookworm.HashText(firstPage);
   if (titleSet == nil) then
      titleSet = {};
      bookList[title] = titleSet;
   end

   for k,v in pairs(titleSet) do
      if (v.hash == pageHash) then
         return v;
      end
   end

   if (createFlag) then
      local newBook = {};
      newBook.hash = pageHash;
      newBook.pages = 0;
      table.insert(titleSet, newBook);
      return newBook, true;
   end
end

-- Refresh the flags on a single book
function Bookworm.RefreshBook(title, book, noNotify)
   book.pageSize = nil;
   for k,v in book do
      if (string.find(k, "^page[0-9]+$")) then
         if (book.pageSize == nil) then
            book.pageSize = string.len(v);
         else
            book.pageSize = book.pageSize + string.len(v);
         end
      end
   end
   -- Create placeholder category if necessary
   if (book.cat ~= nil) then
      if (book.cat == '-') then
         book.cat = nil;
      elseif (BookwormBooks[CATEGORY_KEY][book.cat] == nil) then
         BookwormBooks[CATEGORY_KEY][book.cat] =
            Bookworm.GetMessage("UnnamedCategoryName", book.cat);
      end
   end
   if (not noNotify) then
      Bookworm.NotifyChange("book", title, book.hash);
   end
end

-- Scan all books and update status flags
function Bookworm.Refresh()
   for k,v in BookwormBooks[BOOK_LIST_KEY] do
      for bk,bv in v do
         Bookworm.RefreshBook(k, bv, true);
      end
   end
   Bookworm.NotifyChange("all");
end


-- Iterate over all books
--    func -- Callback function, returns 2 values change, stop
--             change -- if true then fire a NotifyChange when done
--             stop   -- if true then stop iterating
--
--            Called with book name, book structure, and arg (from Iterate)
function Bookworm.Iterate(func, ...)
   local anyChange = false;
   for k,v in BookwormBooks[BOOK_LIST_KEY] do
      for bk,bv in v do
         local change, stop = func(k, bv, arg);
         anyChange = anyChange or change;
         if (stop) then
            break;
         end
      end
   end

   if (anyChange) then
      Bookworm.NotifyChange("all");
   end
end


-- Get the current map location of the player
-- Returns locInfo
--  locInfo - Location info structure, or nil if unknown
function Bookworm.GetMapLocation()
   SetMapToCurrentZone();
   local mapName,mapX,mapY = GetMapInfo();
   -- Check for Azeroth, happens after reloadUI but before zone change.
   -- Should not be an issue once we get to 1.7 patch.
   if ((mapName == "Azeroth")
       or (mapName == "Kalimdor")
       or (mapName == "Eastern Kingdoms")) then
      return;
   end

   local playX,playY = GetPlayerMapPosition("player");

   local locInfo = {};
   table.insert(locInfo, (UnitName("player")));
   table.insert(locInfo, mapName);
   table.insert(locInfo, playX);
   table.insert(locInfo, playY);
   local subZone = GetSubZoneText();
   if (subZone == nil) then
      subZone = "";
   end
   table.insert(locInfo, subZone);

   return locInfo;
end

-- Sort method for sorting book hits by distance
local function Bookworm_SortByDist(a,b)
   if (a["dist"] < b["dist"]) then
      return true;
   elseif (a["dist"] > b["dist"]) then
      return false;
   elseif (a["title"] < b["title"]) then
      return true;
   elseif (a["title"] > b["title"]) then
      return false;
   else
      return false;
   end
end

-- Sort method for sorting book hits by title
local function Bookworm_SortByTitle(a,b)
   return (a["title"] < b["title"]);
end


-- Get a list of all of the books near the specified location
-- Returns titleList, hashList
--  titleList - List of book titles (in order of distance)
--  hashList  - Matching list of book hashes
function Bookworm.GetAllNearby(zone, map, x, y)
   local hitList = {}

   for k,v in BookwormBooks[BOOK_LIST_KEY] do
      for bk,bv in v do
         local bLoc = bv["loc " .. zone];
         if ((bLoc ~= nil) and (bLoc[LOC_MAP] == map)) then
            local dx = bLoc[LOC_MAP_X] - x;
            local dy = bLoc[LOC_MAP_Y] - y;
            local dist = math.sqrt(dx*dx + dy*dy);
            local hit = {};
            hit["dist"] = dist;
            hit["title"] = k;
            hit["hash"] = bv.hash;
            table.insert(hitList, hit);
         end
      end
   end

   table.sort(hitList, Bookworm_SortByDist);

   local titleList = {};
   local hashList = {};

   for k,v in hitList do
      table.insert(titleList, v.title);
      table.insert(hashList, v.hash);
   end
   return titleList, hashList
end

-- Get a list of all of the known books
-- Returns titleList, hashList
--  titleList - List of book titles (in title order)
--  hashList  - Matching list of book hashes
function Bookworm.GetAll()
   local hitList = {}

   for k,v in BookwormBooks[BOOK_LIST_KEY] do
      for bk,bv in v do
         local hit = {};
         hit["title"] = k;
         hit["hash"] = bv.hash;
         table.insert(hitList, hit);
      end
   end

   table.sort(hitList, Bookworm_SortByTitle);

   local titleList = {};
   local hashList = {};

   for k,v in hitList do
      table.insert(titleList, v.title);
      table.insert(hashList, v.hash);
   end

   return titleList, hashList
end

-- Get a list of all of the known books that have (or have not) been read
-- Returns titleList, hashList
--  titleList - List of book titles (in title order)
--  hashList  - Matching list of book hashes
function Bookworm.GetRead(readFlag)
   local hitList = {}

   for k,v in BookwormBooks[BOOK_LIST_KEY] do
      for bk,bv in v do
         if ((readFlag and bv.read) or
             (not (readFlag or bv.read))) then
            local hit = {};
            hit["title"] = k;
            hit["hash"] = bv.hash;
            table.insert(hitList, hit);
         end
      end
   end

   table.sort(hitList, Bookworm_SortByTitle);

   local titleList = {};
   local hashList = {};

   for k,v in hitList do
      table.insert(titleList, v.title);
      table.insert(hashList, v.hash);
   end

   return titleList, hashList
end

-- Get a list of all of the known books that have (or have not) any content
-- Returns titleList, hashList
--  titleList - List of book titles (in title order)
--  hashList  - Matching list of book hashes
function Bookworm.GetWithContent(contentFlag)
   local hitList = {}

   for k,v in BookwormBooks[BOOK_LIST_KEY] do
      for bk,bv in v do
         if ((contentFlag and (bv.pageSize ~= nil)) or
             (not (contentFlag or (bv.pageSize ~= nil)))) then
            local hit = {};
            hit["title"] = k;
            hit["hash"] = bv.hash;
            table.insert(hitList, hit);
         end
      end
   end

   table.sort(hitList, Bookworm_SortByTitle);

   local titleList = {};
   local hashList = {};

   for k,v in hitList do
      table.insert(titleList, v.title);
      table.insert(hashList, v.hash);
   end

   return titleList, hashList
end

-- Get a list of all of the known books that have (or have not) a note
-- Returns titleList, hashList
--  titleList - List of book titles (in title order)
--  hashList  - Matching list of book hashes
function Bookworm.GetWithNote(noteFlag)
   local hitList = {}

   for k,v in BookwormBooks[BOOK_LIST_KEY] do
      for bk,bv in v do
         if ((noteFlag and (bv.note ~= nil)) or
             (not (noteFlag or (bv.note ~= nil)))) then
            local hit = {};
            hit["title"] = k;
            hit["hash"] = bv.hash;
            table.insert(hitList, hit);
         end
      end
   end

   table.sort(hitList, Bookworm_SortByTitle);

   local titleList = {};
   local hashList = {};

   for k,v in hitList do
      table.insert(titleList, v.title);
      table.insert(hashList, v.hash);
   end

   return titleList, hashList
end

-- Count books in the database.
-- Returns bookCount, titleCount pageSizeTotal
--  bookCount - Number of distinct books
--  titleCount - Number of distinct titles
--  pageSizeTotal - Total combined page sizes
function Bookworm.GetCount()
   local tc, bc, ps = 0, 0, 0;
   for k,v in BookwormBooks[BOOK_LIST_KEY] do
      tc = tc + 1;
      for bk,bv in v do
         bc = bc + 1;
         if (bv.pageSize ~= nil) then
            ps = ps + bv.pageSize;
         end
      end
   end
   return bc, tc, ps;
end

function Bookworm.AddCategory(catid, catname)
   if (catid == nil) then
      Bookworm.Notify("InvalidCategoryId", "nil");
      return false;
   end
   if ((catid == '-')
       or (catid == "nil")
          or (not string.find(catid, "^[a-zA-Z0-9][a-zA-Z_0-9-]*$"))) then
      Bookworm.Notify("InvalidCategoryId", catid);
      return false;
   end
   if ((catname == nil) or (catname == '')) then
      catname = Bookworm.GetMessage("UnnamedCategoryName", catid);
   end
   local cats = BookwormBooks[CATEGORY_KEY];
   if (cats[catid] ~= nil) then
      Bookworm.Notify("CategoryExists", catid, cats[catid]);
      return false;
   end
   cats[catid] = catname;
   Bookworm.NotifyChange("cat", catid);
   return true;
end

function Bookworm.RenameCategory(catid, catname)
   if (catid == nil) then
      Bookworm.Notify("InvalidCategoryId", "nil");
      return false;
   end
   if ((catid == '-')
       or (catid == "nil")
          or (not string.find(catid, "^[a-zA-Z0-9][a-zA-Z_0-9-]*$"))) then
      Bookworm.Notify("InvalidCategoryId", catid);
      return false;
   end
   local cats = BookwormBooks[CATEGORY_KEY];
   if (cats[catid] == nil) then
      Bookworm.Notify("UnknownCategoryId", catid);
      return false;
   end
   cats[catid] = catname;
   Bookworm.NotifyChange("cat", catid);
   return true;
end

function Bookworm.RemoveCategory(catid, force)
   if (catid == nil) then
      Bookworm.Notify("InvalidCategoryId", "nil");
      return false;
   end
   if ((catid == '-')
       or (catid == "nil")
          or (not string.find(catid, "^[a-zA-Z0-9][a-zA-Z_0-9-]*$"))) then
      Bookworm.Notify("InvalidCategoryId", catid);
      return false;
   end

   local allUpdate = false;

   for k,v in BookwormBooks[BOOK_LIST_KEY] do
      for bk,bv in v do
         if (bv.cat == catid) then
            if (force) then
               allUpdate = true;
               bv.cat = nil;
            else
               Bookworm.Notify("CategoryInUse", catid,
                               Bookworm.GetCategoryName(catid));
               return false;
            end
         end
      end
   end

   BookwormBooks[CATEGORY_KEY][catid] = nil;

   if (allUpdate) then
      Bookworm.NotifyChange("all");
   else
      Bookworm.NotifyChange("cat", catid);
   end
   return true;
end

function Bookworm.HasCategories()
   for k,v in BookwormBooks[CATEGORY_KEY] do
      return true;
   end;
   return false;
end

function Bookworm.GetCategoryName(catid)
   if ((catid == '-') or (catid == 'nil') or (catid == nil)) then
      return Bookworm.GetMessage("Uncategorized");
   end
   local name = BookwormBooks[CATEGORY_KEY][catid];
   if (name == nil) then
      name = Bookworm.GetMessage("UnnamedCategoryName", catid);
   end
   return name;
end

-- Sort method for sorting category ID's by category name
local function Bookworm_SortByCategoryName(a,b)
   return Bookworm.GetCategoryName(a) < Bookworm.GetCategoryName(b);
end

function Bookworm.GetCategories()
   local ret = {};
   for k,v in BookwormBooks[CATEGORY_KEY] do
      table.insert(ret, k);
   end
   table.sort(ret);
   return ret;
end

function Bookworm.SetBookCategory(title, bookOrHash, catid)
   if ((catid == '-') or (catid == 'nil')) then
      catid = nil;
   end

   local book = Bookworm.GetBook(title, bookOrHash);
   if (not book) then
      Bookworm.Alert("BookNotFound", title, bookOrHash);
   end
   if ((catid == nil) or
       BookwormBooks[CATEGORY_KEY][catid]) then
      if (book.cat ~= catid) then
         book.cat = catid;
         Bookworm.NotifyChange("book", title, book.hash);
      end
      return;
   end
   Bookworm.Alert("UnknownCategoryId", catid);
end

-- Get a list of all of the known books in the given category
-- Returns titleList, hashList
--  titleList - List of book titles (in title order)
--  hashList  - Matching list of book hashes
function Bookworm.GetCategory(catid)
   -- Quick escape for invalid category
   if ((catid ~= nil) and (not BookwormBooks[CATEGORY_KEY][catid])) then
      return {}, {};
   end

   local hitList = {}

   for k,v in BookwormBooks[BOOK_LIST_KEY] do
      for bk,bv in v do
         if (bv.cat == catid) then
            local hit = {};
            hit["title"] = k;
            hit["hash"] = bv.hash;
            table.insert(hitList, hit);
         end
      end
   end

   table.sort(hitList, Bookworm_SortByTitle);

   local titleList = {};
   local hashList = {};

   for k,v in hitList do
      table.insert(titleList, v.title);
      table.insert(hashList, v.hash);
   end

   return titleList, hashList
end

function Bookworm.ChangedBook(title, bookOrHash)
   if (type(bookOrHash) == 'table') then
      bookOrHash = bookOrHash.hash;
   end
   Bookworm.NotifyChange("book", title, bookOrHash);
end

-- Queue of events to notify
local NotifyQueue = {};
-- All interested listeners
local AllListeners = {};

-- Event currently being notified
local NotifyEvent = nil;

function Bookworm.NotifyChange(type, arg1, arg2)
   -- Forget about the event if nobody cares
   if (table.getn(AllListeners) == 0) then
      return;
   end

   local event = {
      type = type,
      arg1 = arg1,
      arg2 = arg2
   }

   table.insert(NotifyQueue, event);

   if (NotifyEvent == nil) then
      BookwormNotifyFrame:Show();
      Bookworm_Notify_OnUpdate(BookwormNotifyFrame);
   end
end

function Bookworm.AddListener(listener)
   if (listener == nil) then
      return;
   end
   for k,v in AllListeners do
      if (v == listener) then
         return;
      end
   end
   table.insert(AllListeners, listener);
end

function Bookworm.RemoveListener(listener)
   for k,v in AllListeners do
      if (v == listener) then
         table.remove(AllListeners, k);
         return;
      end
   end
end

-- Listeners left to be notified of this event
local NotifyListeners = nil;

local function Bookworm_Notify_NotifyAll()
   local n = table.getn(NotifyListeners);
   for i=1,n do
      local listener = table.remove(NotifyListeners);
      listener:notify(NotifyEvent.type,
                      NotifyEvent.arg1,
                      NotifyEvent.arg2);
   end
   NotifyEvent = nil;
   NotifyListeners = nil;
end

function Bookworm_Notify_OnUpdate(this)
   while true do
      if (NotifyEvent ~= nil) then
         Bookworm_Notify_NotifyAll();
      end

      if (NotifyEvent == nil) then
         NotifyEvent = table.remove(NotifyQueue);
         if (NotifyEvent == nil) then
            -- Done!
            this:Hide();
            return;
         end
         NotifyListeners = {};
         for k,v in AllListeners do
            table.insert(NotifyListeners, v);
         end
         Bookworm_Notify_NotifyAll();
      end
   end
end