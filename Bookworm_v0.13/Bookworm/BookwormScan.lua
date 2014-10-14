------------------------------------------------------------------------------
-- BookwormScan.lua
--
-- Author: Daniel Stephens <daniel@vigilance-committee.org>
-- Author: Iriel <iriel@vigilance-committee.org>
--
-- Scanning engine for bookworm - monitors content events
---------------------------------------------------------------------------

local currentBook = nil;
local currentBookData = nil;
local currentBookIsNew = nil;
local currentBookComplete = false;

local needNextTime = nil;
local needNextFrameSkip = 0;

-- Event handler for scanner.
function Bookworm_Scan_OnEvent(event)
   -- (Re) initialize once the variables have been loaded
   if (event == "ADDON_LOADED") then
      if (arg1 == "Bookworm") then
	 Bookworm_Core_Init();
      end
      return;
   end

   -- Called when a book starts up, just remember the title for now.
   if (event == "ITEM_TEXT_BEGIN") then
      currentBook = ItemTextGetItem();
      currentBookData = nil;
      currentBookComplete = false;
      currentBookIsNew = nil;
      return;
   end

   -- Called when translation occurs I think, I've not been able to test
   -- this so I'm going to be paranoid.
   if (event == "ITEM_TEXT_TRANSLATION") then
      -- I dont want to deal with translation now, so forget this book if it
      -- needs it.
      currentBook = nil;
      currentBookData = nil;
      currentBookComplete = false;
      return;
   end

   -- Called when each page is ready to be displayed, this is where the
   -- guts of the capture logic occurs.
   if (event == "ITEM_TEXT_READY") then
      needNextTime = nil;
      if (currentBookComplete) then
	 return;
      end

      local creator = ItemTextGetCreator();
      local page    = ItemTextGetPage();
      local hasNext = ItemTextHasNextPage();

      if ((creator ~= nil) or (currentBook == nil)) then
	 currentBook = nil;
	 return;
      end

      local justFound = false;
      local justCreated = false;
      local justChanged = false;
      local justUpdatedLoc = false;
      if ((currentBookData == nil) and (currentBook ~= nil)) then
	 if (page == 1) then
	    currentBookData, justCreated = 
	       Bookworm.FindBook(currentBook, ItemTextGetText(), true);
	    
	    currentBookComplete = false;
	    justFound = true;
	    if (justCreated) then
	       currentBookIsNew = true;
	    end

	    if (currentBookData == nil) then
	       -- This should never happen at present, but it will
	       -- if I add in a 'dont remember anything' flag.
	       return
	    end
	 end
      end

      -- Store material
      local material = ItemTextGetMaterial();
      if (material == nil) then
	 material = "";
      end
      if (currentBookData["material"] ~= material) then
	 currentBookData["material"] = material;
      end

      -- Store location in this zone if it's not been seen here before
      local zone = GetZoneText();
      if (currentBookData["loc " .. zone] == nil) then
	 local newLoc = Bookworm.GetMapLocation();
	 if (newLoc == nil) then
	    message("Bookworm: Unable to determine location");
	 else
	    currentBookData["loc " .. zone] = newLoc;
	    justUpdatedLoc = true;
	 end
      end

      -- Update length of the book if necessary
      local bookPages = currentBookData["pages"];
      if (bookPages <= 0) then
	 if (not hasNext) then
	    bookPages = page;
	    currentBookData["pages"] = bookPages;
	    justChanged = true;
	 else
	    local newPages = -page;
	    if (newPages < bookPages) then
	       bookPages = newPages;
	       currentBookData["pages"] = bookPages;
	       justChanged = true;
	    end
	 end
      end

      local thisPage = currentBookData["page" .. page];
      local storeContent = BookwormBooks[BookwormConstant.STORE_CONTENT_KEY];

      if (BookwormBooks[BookwormConstant.STORE_MODE_KEY] == "unread") then
	 if (currentBookData.read) then
	    storeContent = nil;
	 end
      elseif (BookwormBooks[BookwormConstant.STORE_MODE_KEY] == "new") then
	 if (not currentBookIsNew) then
	    storeContent = nil;
	 end
      end

      local pageText = ItemTextGetText();
      if (storeContent and (thisPage == nil)) then
	 currentBookData["page" .. page] = pageText;
	 justChanged = true;
      elseif ((thisPage ~= nil) and (thisPage ~= pageText)) then
	 Bookworm.Notify("MustReplacePage");
	 currentBookData["page" .. page] = pageText;
	 justChanged = true;
      end

      -- If there have been any changes we need to update the flags on
      -- this book.
      if (justChanged) then
	 Bookworm.RefreshBook(currentBook, currentBookData);
      end

      local needPage = 0;
      if (not currentBookComplete) then
	 if (bookPages > 0) then
	    if (storeContent) then
	       for i=1,bookPages,1 do
		  if (currentBookData["page" .. i] == nil) then
		     needPage = i;
		     break;
		  end
	       end
	    end
	    if (needPage == 0) then
	       if (justFound and (not justChanged)) then
		  if (justUpdatedLoc) then
		     Bookworm.Notify("BookKnownNewLoc", bookPages);
		  else
		     Bookworm.Notify("BookKnown", bookPages);
		  end
	       else
		  if (justCreated) then
		     Bookworm.Notify("BookNewComplete", bookPages);
		  else
		     Bookworm.Notify("BookComplete", bookPages);
		  end
	       end
	       
	       currentBookComplete = true;
	       return;
	    end
	 end
      end

      if (justFound) then
	 if (justCreated) then
	    Bookworm.Notify("BookIncompleteNew");
	 else
	    Bookworm.Notify("BookIncompleteKnown");
	 end
      end

      local autoPage = BookwormBooks[BookwormConstant.AUTO_PAGE_KEY];

      if ((bookPages <= 0) or (needPage > page)) then
	 if (hasNext) then
	    if (autoPage) then
	       needNextTime = GetTime() + 0.2;
	       -- Ensure there's at least 2 frames of wait time.
	       needNextFrameSkip = 2;
	       BookwormScanFrame:Show();
	    else
	       Bookworm.Notify("TurnToNext");
	    end
	 end
      else
	 Bookworm.Notify("MissingPage", needPage);
      end
      return;
   end

   if (event == "ITEM_TEXT_CLOSE") then
      currentBook = nil;
      currentBookData = nil;
      return;
   end
end

-- Called on update to do page turning
function Bookworm_Scan_OnUpdate()
   if (needNextFrameSkip > 0) then
      needNextFrameSkip = needNextFrameSkip - 1;
      return;
   end
   if (needNextTime ~= nil) then
      if (GetTime() >= needNextTime) then
	 needNextTime = nil;
	 if (currentBook ~= nil) then
	    ItemTextNextPage();
	 end
      end
   else
      this:Hide();
   end
end

function Bookworm_Scan_OnLoad()
   this:RegisterEvent("ADDON_LOADED");
   this:RegisterEvent("ITEM_TEXT_READY");
   this:RegisterEvent("ITEM_TEXT_TRANSLATION");
   this:RegisterEvent("ITEM_TEXT_BEGIN");
   this:RegisterEvent("ITEM_TEXT_CLOSED");
end
