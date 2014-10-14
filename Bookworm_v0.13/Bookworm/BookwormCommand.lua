------------------------------------------------------------------------------
-- BookwormCommand.lua
--
-- Author: Daniel Stephens <daniel@vigilance-committee.org>
-- Author: Iriel <iriel@vigilance-committee.org>
--
-- Command parsing for bookworm
---------------------------------------------------------------------------

local function Util_CurrentBook()
   local currentContent,currentPage = Bookworm.DEFAULT_VIEW:getContent();
   if (currentContent == nil) then
      Bookworm.Notify("NoView");
      return nil;
   end
   if (currentContent.book == nil) then
      Bookworm.Notify("NoViewBook");
      return nil;
   end
   return currentContent.book, currentContent.title, currentPage;
end

local function Util_Show(content,page,flush)
   if (flush == nil) then
      flush = true;
   end
   Bookworm.DEFAULT_VIEW:show(content, page, flush);
end

local function Util_Refresh()
   Bookworm.DEFAULT_VIEW:refresh();
end

local function Bookworm_Command_Forget()
   local book,title,currentPage = Util_CurrentBook();
   if (book == nil) then
      return;
   end

   local pageList = {}
   
   for k,v in pairs(book) do
      if (string.find(k, "^page[0-9]+$")) then
	 table.insert(pageList, k);
      end
   end

   if (table.getn(pageList) < 1) then
      Bookworm.Notify("ForgetNoPages");
      return;
   end

   Bookworm.Notify("ForgetPages");

   for k,v in pairs(pageList) do
      book[v] = nil;
   end
   Bookworm.RefreshBook(title,book);
end

local function Bookworm_Command_SetRead(readFlag)
   local book,title,currentPage = Util_CurrentBook();
   if (book == nil) then
      return;
   end

   if (readFlag) then
      book.read = true;
      Bookworm.Notify("StateNowRead");
   else
      book.read = nil;
      Bookworm.Notify("StateNowUnread");
   end

   Bookworm.ChangedBook(title,book);
end
   
local function Bookworm_Command_DoNote(noteString)
   local book,title,currentPage = Util_CurrentBook();
   if (book == nil) then
      return;
   end

   if (noteString == nil) then
      if (book.note == nil) then 
	 Bookworm.Notify("NoNote");
      else
	 Bookworm.Notify("HasNote", book.note);
      end
   elseif (noteString == "") then
      book.note = nil;
      Bookworm.Notify("NoteCleared");
   else
      book.note = noteString;
      Bookworm.Notify("NoteSet", book.note);
   end

   Bookworm.ChangedBook(title,book);
end

-- Command handler
function Bookworm_Command(msg)
   -- Yes this line does do something - it resolves the global once rather
   -- than every time it's accessed (which is many)
   local BOOKWORM_CMD = BOOKWORM_CMD;

   local clist = {};
   for k in string.gfind(string.lower(msg), "[^%s]+") do
      table.insert(clist, k);
   end

   cmd = clist[1];
   subcmd = clist[2];

   if (cmd == BOOKWORM_CMD.Store) then
      if (subcmd == BOOKWORM_CMD.Store_All) then
	 BookwormBooks[BookwormConstant.STORE_MODE_KEY] = nil;
      elseif (subcmd == BOOKWORM_CMD.Store_Unread) then
	 BookwormBooks[BookwormConstant.STORE_MODE_KEY] = "unread";
      elseif (subcmd == BOOKWORM_CMD.Store_New) then
	 BookwormBooks[BookwormConstant.STORE_MODE_KEY] = "new";
      elseif (subcmd ~= nil) then
	 Bookworm.Notify("UnknownStoreOption", subcmd);
	 return;
      end

      BookwormBooks[BookwormConstant.STORE_CONTENT_KEY] = true;

      if (BookwormBooks[BookwormConstant.STORE_MODE_KEY] == "unread") then
	 Bookworm.Notify("StoreStatusUnread");
      elseif (BookwormBooks[BookwormConstant.STORE_MODE_KEY] == "new") then
	 Bookworm.Notify("StoreStatusNew");
      else
	 Bookworm.Notify("StoreStatusAll");
      end
      return;
   end

   if (cmd == BOOKWORM_CMD.NoStore) then
      BookwormBooks[BookwormConstant.STORE_CONTENT_KEY] = false;
      Bookworm.Notify("StoreStatusNone");
      return;
   end

   if (cmd == BOOKWORM_CMD.Font) then
      if (subcmd == BOOKWORM_CMD.Font_Normal) then
	 BookwormBooks[BookwormConstant.PLAIN_FONT_KEY] = nil;
	 Util_Refresh();
      elseif (subcmd == BOOKWORM_CMD.Font_Plain) then
	 BookwormBooks[BookwormConstant.PLAIN_FONT_KEY] = true;
	 Util_Refresh();
      elseif (subcmd ~= nil) then
	 Bookworm.Notify("UnknownFontOption", subcmd);
	 return;
      end

      if (BookwormBooks[BookwormConstant.PLAIN_FONT_KEY]) then
	 Bookworm.Notify("FontStatusPlain");
      else
	 Bookworm.Notify("FontStatusNormal");
      end
      return;
   end

   if (cmd == BOOKWORM_CMD.Auto) then
      BookwormBooks[BookwormConstant.AUTO_PAGE_KEY] = true;
      Bookworm.Notify("AutoStatusOn");
      return;
   end

   if (cmd == BOOKWORM_CMD.NoAuto) then
      BookwormBooks[BookwormConstant.AUTO_PAGE_KEY] = false;
      Bookworm.Notify("AutoStatusOff");
      return;
   end

   if (cmd ==  BOOKWORM_CMD.Count) then
      local bc, tc, ps = Bookworm.GetCount();
      Bookworm.Notify("Count", bc, tc, ceil(ps/1024));
      return;
   end

   if (cmd == BOOKWORM_CMD.Nearby) then
      local zone = GetZoneText();
      local loc = Bookworm.GetMapLocation();

      if (loc == nil) then
	 Bookworm.Alert("NoLocation");
	 return;
      end

      Util_Show(Bookworm.GetNearbyContentRef(zone,
					     loc[BookwormConstant.LOC_MAP], 
					     loc[BookwormConstant.LOC_MAP_X], 
					     loc[BookwormConstant.LOC_MAP_Y]));
      return;
   end

   if (cmd == BOOKWORM_CMD.Browse) then
      if (Bookworm.HasCategories()) then
	 Util_Show(Bookworm.CONTENT_REF_CATINDEX);
      else
	 Util_Show(Bookworm.CONTENT_REF_ALL);
      end
      return;
   end

   if (cmd == BOOKWORM_CMD.Index) then
      Util_Show(Bookworm.CONTENT_REF_CATINDEX);
      return;
   end

   if (cmd == BOOKWORM_CMD.All) then
      Util_Show(Bookworm.CONTENT_REF_ALL);
      return;
   end

   if (cmd == BOOKWORM_CMD.Forget) then
      Bookworm_Command_Forget();
      return;
   end

   if (cmd == BOOKWORM_CMD.Refresh) then
      Bookworm.Refresh();
      return;
   end

   if (cmd == BOOKWORM_CMD.Read) then
      Bookworm_Command_SetRead(true);
      return;
   end

   if (cmd == BOOKWORM_CMD.NotRead) then
      Bookworm_Command_SetRead(false);
      return;
   end

   if (cmd == BOOKWORM_CMD.Note) then
      if (subcmd == nil) then
	 Bookworm_Command_DoNote(nil);
	 return;
      elseif (subcmd == BOOKWORM_CMD.Note_Delete) then
	 Bookworm_Command_DoNote("");
	 return;
      end
      local b,e,noteString = 
	 string.find(msg, "^%s*[^%s]+%s+(.-)%s*$");
      Bookworm_Command_DoNote(noteString);
      return;
   end

   if (cmd == BOOKWORM_CMD.AddCat) then
      local b,e,catid,catname = 
	 string.find(msg, "^%s*[^%s]+%s+([^%s]+)%s+(.*[^%s])%s*$");
      if (not b) then
	 Bookworm.Notify("AddCatUsage");
      else
	 if (Bookworm.AddCategory(catid, catname)) then
	    Bookworm.Notify("CatAdded", catid, catname);
	 end
      end
      return;
   end

   if (cmd == BOOKWORM_CMD.DelCat) then
      local b,e,catid = string.find(msg, "^%s*[^%s]+%s+([^%s]+)%s*$");
      if (not b) then
	 Bookworm.Notify("DelCatUsage");
      else
	 if (Bookworm.RemoveCategory(catid)) then
	    Bookworm.Notify("CatDeleted", catid, catname);
	 end
      end
      return;
   end

   if (cmd == BOOKWORM_CMD.RenameCat) then
      local b,e,catid,catname = 
	 string.find(msg, "^%s*[^%s]+%s+([^%s]+)%s+(.*[^%s])%s*$");
      if (not b) then
	 Bookworm.Notify("RenameCatUsage");
      else
	 if (Bookworm.AddCategory(catid, catname)) then
	    Bookworm.Notify("CatRenamed", catid, catname);
	 end
      end
      return;
   end

   if (cmd == BOOKWORM_CMD.ListCat) then
      local anyCat = false;
      for k,v in Bookworm.GetCategories() do
	 anyCat = true;
	 Bookworm.Notify("CategoryListEntry", v, Bookworm.GetCategoryName(v));
      end
      if (not anyCat) then
	 Bookworm.Notify("CategoryListEmpty");
      end
      return;
   end

   if (cmd == BOOKWORM_CMD.HaveRead) then
      Util_Show(Bookworm.CONTENT_REF_READ);
      return;
   end

   if (cmd == BOOKWORM_CMD.WithContent) then
      Util_Show(Bookworm.CONTENT_REF_WITHCONTENT);
      return;
   end

   if (cmd == BOOKWORM_CMD.WithNote) then
      Util_Show(Bookworm.CONTENT_REF_WITHNOTE);
      return;
   end

   if (cmd == BOOKWORM_CMD.Unread) then
      Util_Show(Bookworm.CONTENT_REF_UNREAD);
      return;
   end

   if (cmd == BOOKWORM_CMD.Help) then
      Util_Show(Bookworm.CONTENT_REF_HELP,
		nil,
		(not BookwormViewFrame:IsVisible()));
      return;
   end

   if (cmd ~= nil) then
      Bookworm.Notify("UnknownCommand", msg);
      return;
   end
      
   Bookworm.Notify("Summary");

   if (BookwormBooks[BookwormConstant.STORE_CONTENT_KEY]) then
      if (BookwormBooks[BookwormConstant.STORE_MODE_KEY] == "unread") then
	 Bookworm.Notify("StoreStatusUnread");
      elseif (BookwormBooks[BookwormConstant.STORE_MODE_KEY] == "new") then
	 Bookworm.Notify("StoreStatusNew");
      else
	 Bookworm.Notify("StoreStatusAll");
      end
   else
      Bookworm.Notify("StoreStatusNone");
   end
   if (BookwormBooks[BookwormConstant.AUTO_PAGE_KEY]) then
      Bookworm.Notify("AutoStatusOn");
   else
      Bookworm.Notify("AutoStatusOff");
   end
   if (BookwormBooks[BookwormConstant.PLAIN_FONT_KEY]) then
      Bookworm.Notify("FontStatusPlain");
   else
      Bookworm.Notify("FontStatusNormal");
   end
end

-- Initialization for bookworm scanner
function Bookworm_Command_Init()
   SlashCmdList["BOOKWORMCOMMAND"] = Bookworm_Command;
end
