-----------------------------------------------------------------------------
-- BookwormContent.lua
--
-- Author: Daniel Stephens <daniel@vigilance-committee.org>
-- Author: Iriel <iriel@vigilance-committee.org>
--
-- Content implementations
---------------------------------------------------------------------------

-----------------------------------------------------------------------------
-- CONTENT REFERENCES

Bookworm.CONTENT_REF_ALL = {
   getContent = 
      function(self) 
	 local titleList, hashList = Bookworm.GetAll();
	 return Bookworm.GetListContent(Bookworm.GetMessage("TitleAll"),
					titleList, hashList);
      end
}

Bookworm.CONTENT_REF_READ = {
   getContent = 
      function(self) 
	 local titleList, hashList = Bookworm.GetRead(true);
	 return Bookworm.GetListContent(Bookworm.GetMessage("TitleRead"),
					titleList, hashList);
      end
}

Bookworm.CONTENT_REF_UNREAD = {
   getContent = 
      function(self) 
	 local titleList, hashList = Bookworm.GetRead(false);
	 return Bookworm.GetListContent(Bookworm.GetMessage("TitleUnread"),
					titleList, hashList);
      end
}

Bookworm.CONTENT_REF_WITHCONTENT = {
   getContent = 
      function(self) 
	 local titleList, hashList = Bookworm.GetWithContent(true);
	 return Bookworm.GetListContent(Bookworm.GetMessage("TitleContent"),
					titleList, hashList);
      end
}

Bookworm.CONTENT_REF_NOCONTENT = {
   getContent = 
      function(self) 
	 local titleList, hashList = Bookworm.GetWithContent(false);
	 return Bookworm.GetListContent(Bookworm.GetMessage("TitleNoContent"),
					titleList, hashList);
      end
}

Bookworm.CONTENT_REF_WITHNOTE = {
   getContent = 
      function(self) 
	 local titleList, hashList = Bookworm.GetWithNote(true);
	 return Bookworm.GetListContent(Bookworm.GetMessage("TitleNote"),
					titleList, hashList);
      end
}

Bookworm.CONTENT_REF_NONOTE = {
   getContent = 
      function(self) 
	 local titleList, hashList = Bookworm.GetWithNote(false);
	 return Bookworm.GetListContent(Bookworm.GetMessage("TitleNoNote"),
					titleList, hashList);
      end
}

local function Bookworm_Content_GetNearbyContent(self)
   local titleList, hashList = 
      Bookworm.GetAllNearby(self.zone, self.map, self.x, self.y);
   return Bookworm.GetListContent(Bookworm.GetMessage("TitleNearby"),
				  titleList, hashList);
end

function Bookworm.GetNearbyContentRef(zone, map, x, y) 
   local ref = {
      getContent = Bookworm_Content_GetNearbyContent,
      ["zone"] = zone,
      ["map"] = map,
      ["x"] = x,
      ["y"] = y
   }
   return ref;
end

local function Bookworm_Content_GetCategoryContent(self)
   local title = Bookworm.GetCategoryName(self.catid);
   local titleList, hashList = Bookworm.GetCategory(self.catid);
      
   return Bookworm.GetListContent(title, titleList, hashList);
end

function Bookworm.GetCategoryContentRef(catid) 
   if ((catid == nil) or (strsub(catid,1,1) ~= '_')) then
      local ref = {
	 getContent = Bookworm_Content_GetCategoryContent,
	 catid = catid
      };
      return ref;
   end

   local refkey = "CONTENT_REF" .. string.upper(catid);
   local ref = Bookworm[refkey];
   if ((ref ~= nil) and (type(ref.getContent) == 'function')) then
      return ref;
   end
   return nil;
end

local function Bookworm_Content_GetBookById(self)
   local book = Bookworm.GetBookById(self.title, self.hash);
   if (book == nil) then
      return nil;
   else
      return Bookworm.GetBookContent(self.title, book);
   end
end

function Bookworm.GetBookRef(title, hash) 
   local ref = {
      getContent = Bookworm_Content_GetBookById,
      ["title"] = title,
      ["hash"] = hash
   }
   return ref;
end


Bookworm.CONTENT_REF_CATINDEX = {
   getContent = 
      function(self) 
	 return Bookworm.GetCategoryIndexContent();
      end
}

---------------------------------------------------------------------------
-- CONTENT METHODS THEMSELVES

-- LIST CONTENT

local function Bookworm_ListContent_GetPageLabel(self, page)
   if (self.lsize == 0) then
      return ""
   end
   local minNum = (page - 1) * self.perpage + 1;
   local maxNum = page * self.perpage;
   if (maxNum > self.lsize) then
      maxNum = self.lsize;
   end
   if (minNum == maxNum) then
      return minNum .. "/" .. self.lsize;
   else
      return minNum .. "-" .. maxNum .. "/" .. self.lsize;
   end
end

local function Bookworm_ListContent_GetPageContent(self, page)
   if (self.lsize == 0) then
      return Bookworm.GetMessage("NoMatchFound");
   end
   local minNum = (page - 1) * self.perpage + 1;
   local maxNum = page * self.perpage;
   if (maxNum > self.lsize) then
      maxNum = self.lsize;
   end
   local res = "";
   for i=minNum,maxNum,1 do
      if (i > minNum) then
	 res = res .. "\n";
      end
      res = res .. "|cff004400|Hbw:listentry:" .. i .. "|h[" .. i .. "]|h|r " .. self.titles[i];
      --	    res = res .. "|Hbw:listentry:" .. i .. "|h" .. self.titles[i] .. "|h|r";
   end
   res = res .. "\n ";
   return res;
end

local function Bookworm_ListContent_GetPageMaterial(self, page)
   return nil;
end

local function Bookworm_ListContent_ResolveHref(self, href, view, page)
   local s,e,num = string.find(href, "^bw:listentry:([0-9]+)$");
   if (not s) then
      return false;
   end
   num = tonumber(num);
   local title = self.titles[num];
   local hash = self.hashes[num];
   if (title and hash) then
      view:show(Bookworm.GetBookRef(title, hash));
   end
   return true;
end

function Bookworm.GetListContent(title, titlelist, hashlist)
   local perpage = 17;
   local lsize = table.getn(titlelist);

   local pages = math.ceil(lsize / perpage);
   if (pages == 0) then
      pages = 1;
   end

   local content = {
      perpage = perpage,
      lsize   = lsize,
      title   = title,
      minPage = 1,
      maxPage = pages,
      titles  = titlelist,
      hashes  = hashlist,
      getPageLabel    = Bookworm_ListContent_GetPageLabel,
      getPageContent  = Bookworm_ListContent_GetPageContent,
      getPageMaterial = Bookworm_ListContent_GetPageMaterial,
      resolveHref     = Bookworm_ListContent_ResolveHref
   }
   return content;
end

-- BOOK CONTENT

local function Bookworm_BookContent_GetPageContent(self, page)
   -- This line does do something, it resolves the 'Bookworm' symbol 
   -- once since it's referenced a lot.
   local Bookworm = Bookworm;
   local BMsg = Bookworm.GetMessage;

   local book = self.book;
   
   if (page ~= 0) then
      if ((page < 1) or (page > self.maxPage)) then
	 return "";
      end
      local res = book["page" .. page];
      if (res == nil) then
	 return BMsg("PageNotCaptured");
      end
      return "\n" .. res .. "\n";
   end

   res = BMsg("InfoTitle", self.title) .. "\n";
   local psizeText = "";
   if (book.pageSize ~= nil) then
      if (book.pageSize == 1) then 
	 psizeText = BMsg("PageSizeByte", book.pageSize);
      else
	 psizeText = BMsg("PageSizeBytes", book.pageSize);
      end
   else 
      psizeText = BMsg("PageSizeNoData");
   end
   if (book.pages == 0) then
      res = res .. BMsg("PagesUnknown", psizeText) .. "\n";
   elseif (book.pages < 0) then
      res = res .. BMsg("PagesMoreThan", (-book.pages),
				       psizeText) .. "\n";
   else 
      res = res .. BMsg("PagesNumber", book.pages,
				       psizeText) .. "\n";
   end
   local catname = Bookworm.GetCategoryName(book.cat);
   if (book.cat == nil) then
      if (Bookworm.HasCategories()) then
	 res = res .. catname .. " |cff004400|Hbw:action:cat|h"
	    .. BMsg("ActionSet")
	    .. "|h|r\n";
      end
   else
      res = res 
	 .. BMsg("CategoryHeader")
	 .. " |cff000000" .. catname .. "|r |cff003333|Hbw:action:cat|h"
	 .. BMsg("ActionChange")
	 .. "|h|r\n";
   end

   local anyFound = false;

   for k,v in pairs(book) do
      local pos, epos, zone = string.find(k, "^loc (.*)$");
      if (pos ~= nil) then
	 if (not anyFound) then
	    res = res .. " \n"
	       .. BMsg("SeenInHeader")
	       .. "\n";
	    anyFound = true;
	 end
	 res = res .. "  " .. zone;
	 if ((v[LOC_SUBZONE] ~= nil) and (v[LOC_SUBZONE] ~= "")) then
	    res = res .. " (" .. v[LOC_SUBZONE] .. ")";
	 end
	 res = res .. "\n";
      end
   end
   
   if (book.read) then
      res = res .. " \n|cff000000"
	 .. BMsg("YouHaveRead")
	 .. "|r  |cff440000|Hbw:action:unread|h"
	 .. BMsg("ActionReset")
	 .. "|h|r\n";
   else
      res = res .. " \n"
	 .. BMsg("YouHaveNotRead")
	 .. "  |cff004400|Hbw:action:read|h"
	 .. BMsg("ActionMarkRead")
	 .. "|h|r\n";
   end

   if (book.note) then
      res = res .. " \n"
	 .. BMsg("NoteHeader")
	 .. book.note .. "\n";
   end

   res = res .. " \n \n";

   return res;
end

local function Bookworm_BookContent_GetPageLabel(self, page)
   local pagestr;
   if (self.book.pages < 0) then
      pagestr = self.maxPage .. "+";
   elseif (self.book.pages == 0) then
      pagestr = "?"
   else
      pagestr = self.book.pages
   end
   if (page == 0) then
      return Bookworm.GetMessage("DetailsPageLabel");
   else
      return page .. "/" .. pagestr;
   end
end

local function Bookworm_BookContent_GetPageMaterial(self, page)
   if (page == 0) then
      return nil
   end
   if (self.book.material == "") then
      return nil
   else 
      return self.book.material;
   end
end

local function Bookworm_BookContent_ResolveHref(self, href, view, page)
   local s,e,action = string.find(href, "^bw:action:([a-z]+)$");
   if (not s) then
      return false;
   end
   local book = self.book;

   if (action == "unread") then
      book.read = nil;
      Bookworm.ChangedBook(self.title, book);
      return true;
   elseif (action == "read") then
      book.read = true;
      Bookworm.ChangedBook(self.title, book);
      return true;
   elseif (action == "cat") then
      view:show(Bookworm.GetCategorySetContent(self.title, book));
      return true;
   end
end

function Bookworm.GetBookContent(title, book)
   local pages;
   if (book.pages < 0) then
      pages = -book.pages;
   else
      pages = book.pages;
   end
   
   local content = {
      book = book,
      title = title,
      minPage = 0,
      maxPage = pages,
      getPageLabel = Bookworm_BookContent_GetPageLabel,
      getPageContent = Bookworm_BookContent_GetPageContent,
      getPageMaterial = Bookworm_BookContent_GetPageMaterial,
      resolveHref = Bookworm_BookContent_ResolveHref
   }


   return content;
end

local function Util_CategoryLink(catid,title,action) 
   if (catid == nil) then
      catid = '';
   end
   if (action == nil) then
      action = Bookworm.GetMessage("ActionGo");
   end
   return "|cff004400|Hbw:cat:"..catid.."|h" .. action  .. "|h|r " .. title;
end
   
local function Bookworm_IndexContent_GetPageLabel(self,page)
   return Bookworm.GetMessage("IndexTitle");
end

local function Bookworm_IndexContent_GetPageContent(self, page)
   local ret = "";
   if (Bookworm.HasCategories()) then
      ret = Bookworm.GetMessage("CategoryIndexHeader") .. "\n";

      for k,v in Bookworm.GetCategories() do
	 ret = ret .. Util_CategoryLink(v, 
					Bookworm.GetCategoryName(v)) .. "\n";
      end
      ret = ret .. Util_CategoryLink(nil, Bookworm.GetCategoryName(nil)) 
	 .. "\n \n";
   end

   ret = ret .. Bookworm.GetMessage("CategoryIndexSubHeader") .. "\n";
   ret = ret .. Util_CategoryLink("_read", 
				  Bookworm.GetMessage("TitleRead")) .. "\n";
   ret = ret .. Util_CategoryLink("_unread", 
				  Bookworm.GetMessage("TitleUnread")) .. "\n";
   ret = ret .. Util_CategoryLink("_all", 
				  Bookworm.GetMessage("TitleAll")) .. "\n";

   ret = ret .. " \n";
   return ret;
end

local function Bookworm_IndexContent_GetPageMaterial(self,page)
   return nil;
end

local function Bookworm_IndexContent_ResolveHref(self, href, view, page)
   local s,e,catid = string.find(href, "^bw:cat:(.*)$");
   if (not s) then
      return false;
   end
   if (catid == '') then
      catid = nil;
   end
   view:show(Bookworm.GetCategoryContentRef(catid));
   return true;
end

function Bookworm.GetCategoryIndexContent()
   local content = {
      title = Bookworm.GetMessage("CategoryIndexTitle"),
      minPage = 1,
      maxPage = 1,
      getPageLabel = Bookworm_IndexContent_GetPageLabel,
      getPageContent = Bookworm_IndexContent_GetPageContent,
      getPageMaterial = Bookworm_IndexContent_GetPageMaterial,
      resolveHref = Bookworm_IndexContent_ResolveHref,
   }

   return content;
end

local function Bookworm_SetCatContent_GetPageLabel(self,page)
   return "";
end

local function Bookworm_SetCatContent_GetPageContent(self, page)
   local book = self.book;

   local curCat = Bookworm.GetCategoryName(book.cat);
   local ret = Bookworm.GetMessage("CategorySetHeader",  curCat) .. "\n";

   local set = Bookworm.GetMessage("ActionSet");
   

   for k,v in Bookworm.GetCategories() do
      if (v ~= book.cat) then
	 ret = ret .. Util_CategoryLink(v, Bookworm.GetCategoryName(v), 
					set) .. "\n";
      end
   end
   if (book.cat ~= nil) then
      ret = ret .. Util_CategoryLink(nil, Bookworm.GetCategoryName(nil),
				     set) .. "\n";
   end
   ret = ret .. " \n"
   ret = ret .. "|cff660000|Hbw:action:cancel|h"
      .. Bookworm.GetMessage("ActionCancel")
      .. "|h|r\n"
   ret = ret .. " \n"
   return ret;
end

local function Bookworm_SetCatContent_GetPageMaterial(self,page)
   return nil;
end

local function Bookworm_SetCatContent_ResolveHref(self, href, view, page)
   if (href == "bw:action:cancel") then
      view:back();
      return true;
   end
   local s,e,catid = string.find(href, "^bw:cat:(.*)$");
   if (not s) then
      return false;
   end
   if (catid == '') then
      catid = nil;
   end
   Bookworm.SetBookCategory(self.title, self.book, catid);
   view:back();
   return true;
end

function Bookworm.GetCategorySetContent(bookTitle,book)
   local content = {
      bookTitle = bookTitle,
      book = book,
      title = Bookworm.GetMessage("CategorySetTitle", bookTitle),
      minPage = 1,
      maxPage = 1,
      getPageLabel = Bookworm_SetCatContent_GetPageLabel,
      getPageContent = Bookworm_SetCatContent_GetPageContent,
      getPageMaterial = Bookworm_SetCatContent_GetPageMaterial,
      resolveHref = Bookworm_SetCatContent_ResolveHref,
   }

   return content;
end
