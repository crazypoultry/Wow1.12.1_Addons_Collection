-- 
--   BookStore 2.0
--   BookStore.lua
--
--   Author      : Ed Farrow (aka. Stormina Teacup)
--   URL         : http://wow-kaboom.com/bookstore/
--   Description : 
--                 BookStore is intended to help roleplayers by allowing
--                 them to save copies of in-game books for reading at a
--                 later date. This means that players can essentially
--                 'carry' books with them. Although they do not take up
--                 any real space and currently cannot be transfered.
--
--                 Heavily influenced by Ephemeral, but not copied. The
--                 mod was a great idea, sadly it seems totally out of
--                 date and buggy beyond any possible usage! :-(
--
--                 Huge thanks go to Maldivia, Dragonmaw, EN-EU, for a
--                 massive help in bug fixing via the WoW forums.
--
--                 Merci à Laranor, Moonglade, EN-EU, pour la traduction
--                 française. ;-)
--

local current_book = 0;
local current_page = 0;
local current_shelf = 1;
-- 4x3 Bag Texture.
local BOOKS_PER_SHELF = 12;
-- Change this to enlarge or reduce your BookStore shelves. NOTE: Reducing your BookStore shelves doesn't delete your books.
local MAXIMUM_SHELVES = 20;
local MAXIMUM_BOOKS = BOOKS_PER_SHELF * MAXIMUM_SHELVES;
local BOOKSTORE_DEFAULT_BOOK_ICON = "Interface\\Icons\\INV_Misc_Book_09";

TITAN_BOOKSTORE_ID = "BookStore";
TITAN_BOOKSTORE_FREQUENCY = 1;
TITAN_BOOKSTORE_ICON = "Interface\\AddOns\\BookStore\\TitanIcon";

-- [ FUNCTION: BookStore_PrintMsg(msg)
-- [  PURPOSE: Print a message to the default chat frame.
function BookStore_PrintMsg(msg)
   DEFAULT_CHAT_FRAME:AddMessage(msg,1,1,0);
end
-- END ]

-- [ FUNCTION: BookStore_ToolTip(slot,owner)
-- [  PURPOSE: Show a tooltip for anything else.
function BookStore_ToolTip(slot, owner)
   GameTooltip:SetOwner(owner, "ANCHOR_TOPRIGHT");
   GameTooltip:AddLine(slot, 1,1,1);
   GameTooltip:Show();
end
-- END ]

-- [ FUNCTION: BookStore_ViewTip(slot)
-- [  PURPOSE: Show a tooltip for a book.
function BookStore_ViewTip(slot)
   local actual_book = slot + ((current_shelf - 1) * BOOKS_PER_SHELF);
   local book_title = bsContainer[actual_book]["title"];
   local book_location = bsContainer[actual_book]["location"] .. " (" .. bsContainer[actual_book]["subzone"] .. ")";
   local num_of_pages_tip = table.getn(bsContainer[actual_book].pages);
   GameTooltip:SetOwner(BookStoreBag, "ANCHOR_TOPRIGHT");
   GameTooltip:AddLine(book_title, 1,1,1);
   GameTooltip:AddLine(book_location, 1,1,0);
   GameTooltip:AddLine(num_of_pages_tip .. BOOKSTORE_PAGES, 1,1,0);
   GameTooltip:Show();
   return true;
end
-- END ]

-- [ FUNCTION: BookStore_OpenBook(slot)
-- [  PURPOSE: Open a book for viewing! Woo-hoo!
function BookStore_OpenBook(slot)
   current_book = slot + ((current_shelf - 1) * BOOKS_PER_SHELF);
   BookStoreBookTitle:SetText(bsContainer[current_book].title);
   BookStoreBook:Show();
   BookStoreTextWrap:SetText(bsContainer[current_book].pages[1].content);
   current_page = 1;
   BookStoreBookPrevPage:Hide();
   local total_pages = table.getn(bsContainer[current_book].pages)
   if( total_pages > 1 ) then
      BookStoreBookPageNumber:SetText(current_page);
      BookStoreBookNextPage:Show();
   else
      BookStoreBookPageNumber:SetText("");
      BookStoreBookNextPage:Hide();
   end
end
-- END ]

-- [ FUNCTION: BookStore_CloseBook()
-- [  PURPOSE: Close a book that is currently open.
function BookStore_CloseBook()
   BookStoreBook:Hide();
   BookStoreBookTitle:SetText(BOOKSTORE.Name);
   BookStoreTextWrap:SetText(BOOKSTORE.Name .. " Placeholder");
   BookStoreBookPageNumber:SetText("1");
   BookStoreBookNextPage:Hide();
   BookStoreBookPrevPage:Hide();
   current_book = 0;
   current_page = 0;
end
-- END ]

-- [ FUNCTION: BookStore_PrevPage()
-- [  PURPOSE: Display thep revious page of the book.
function BookStore_PrevPage()
   num_of_pages = table.getn(bsContainer[current_book].pages);
   if(num_of_pages>1) then
      if(current_page>1) then
         current_page = current_page - 1;
         BookStoreBookPageNumber:SetText(current_page);
         BookStoreTextWrap:SetText(bsContainer[current_book].pages[current_page].content);
      end
      if(current_page<num_of_pages) then
         BookStoreBookNextPage:Show();
      end
   end
   if (current_page==1) then
      BookStoreBookPrevPage:Hide();
   end
end
-- END ]

-- [ FUNCTION: BookStore_NextPage()
-- [  PURPOSE: Display the next page of the book.
function BookStore_NextPage()
   num_of_pages = table.getn(bsContainer[current_book].pages);
   if (num_of_pages>1) then
      if (current_page<num_of_pages) then
         current_page = current_page + 1;
         BookStoreBookPageNumber:SetText(current_page);
         BookStoreTextWrap:SetText(bsContainer[current_book].pages[current_page].content);
         BookStoreBookPrevPage:Show();
      end
   end
   if (current_page==num_of_pages) then
      BookStoreBookNextPage:Hide();
   end
end
-- END ]

-- [ FUNCTION: BookStore_DeleteBook()
-- [  PURPOSE: Delete a book entirely. Are you sure you want to do that?
function BookStore_DeleteBook(what)
   table.remove(bsContainer,current_book);
   BookStore_CloseBook();
   BookStore_Refresh();
end
-- END ]

-- [ FUNCTION: BookStore_CreateBook()
-- [  PURPOSE: Create an empty book in an empty slot, ready to be populated with data.
function BookStore_CreateBook()
   local book = { title    = "",
                  author   = "",
                  creator  = UnitName("player"),
                  kind     = 0,
                  inbag    = false,
                  icon     = "",
                  texture  = "",
                  location = "",
                  subzone  = "",
                  stamp    = date(),
                  pages    = {}
                }

   local total_books = table.getn( bsContainer );
   local our_pos = total_books + 1;
   bsContainer[our_pos] = book;
   return our_pos;
end
-- END ]

function BookStore_GetBookTexture(title)
  local bag, slot;
  for bag = 0, 4 do
    if GetContainerNumSlots(bag) > 0 then
      for slot = 0, GetContainerNumSlots(bag) do
        local bookicon, _, _, _, readable = GetContainerItemInfo(bag, slot);
        if (readable) then
          if (string.find(GetContainerItemLink(bag, slot), title)) then
            return bookicon;
          end
        end
      end
    end
  end
  return "";
end

-- [ FUNCTION: BookStore_CopyBook()
-- [  PURPOSE: Duplicate an in-game book and save it to the books table.
function BookStore_CopyBook()

   local copy_title = ItemTextTitleText:GetText();
   -- TODO: add customizable title if "Plain Letter".
   if (BookStore_BookExist(copy_title)) then
        BookStore_Err(copy_title .. BOOKSTORE_EXISTS);
        return false;
   end
   while ItemTextGetPage() > 1 do
      ItemTextPrevPage();
   end
   local total_books = table.getn( bsContainer );
   if (total_books < MAXIMUM_BOOKS) then
      local book = BookStore_CreateBook();
      local bookicon = BookStore_GetBookTexture(copy_title);
      bsContainer[book].title    = copy_title or "Untitled";
      bsContainer[book].author   = ItemTextGetCreator() or "Unknown";
      bsContainer[book].inbag    = true;
      bsContainer[book].icon     = bookicon;
      bsContainer[book].texture  = ItemTextGetMaterial() or "Parchment";
      bsContainer[book].location = GetRealZoneText() or "Unknown Location";
      bsContainer[book].subzone  = GetMinimapZoneText() or "Unknown Location";
      while ItemTextHasNextPage() do
          table.insert( bsContainer[book].pages, { content = ItemTextGetText() } );
          ItemTextNextPage();
      end
      table.insert( bsContainer[book].pages, { content = ItemTextGetText() } );
      local book_in_shelf = BookStore_CalcBookIndex(book);
      if (BookStore_CalcBookShelf(book) == current_shelf) then
          BookStoreBagEnableItem(book_in_shelf, bookicon)
      end
      total_books = total_books + 1;
      table.setn(bsContainer,total_books);
      BookStore_PrintMsg(bsContainer[book].title .. BOOKSTORE_ADDED); 
   else
      BookStore_Err(BOOKSTORE_FULL);
   end
   CloseItemText();
end
-- END ]

function BookStoreBagEnableItem(which, bookicon)
    local slot = getglobal("BookStoreBagItem" .. which);
    if (bookicon == "") then
        bookicon = BOOKSTORE_DEFAULT_BOOK_ICON;
    end
    slot:SetNormalTexture(bookicon);
    slot:SetPushedTexture(bookicon);
    slot:Enable();
end

-- [ FUNCTION: BookStore_CheckIsInUse(which)
-- [  PURPOSE: If the slot is in use, return true. Else, return false.
function BookStore_CheckIsInUse(which)
   if (which < (table.getn(bsContainer) + 1)) then 
      return true;
   else 
      return false;
   end
end
-- END ]

-- [ FUNCTION: BookStore_Refresh()
-- [  PURPOSE: Refresh the BookStore by disabling all buttons then re-enabling them.
function BookStore_Refresh()
   num_of_books = table.getn(bsContainer);
   for i = 1, BOOKS_PER_SHELF do
      getglobal("BookStoreBagItem" .. i):Disable();
   end
   BookStore_EnableButtons();
end
-- END ]

-- [ FUNCTION: BookStore_EnableButtons()
-- [  PURPOSE: Enable each book button that is in use.
function BookStore_EnableButtons()
   local book_offset = (current_shelf - 1) * BOOKS_PER_SHELF;
   for i = 1, BOOKS_PER_SHELF do
      local book = book_offset + i;
      if(BookStore_CheckIsInUse(book) == true) then 
         local slot = getglobal("BookStoreBagItem" .. i);
         local bookicon = "";
         if (bsContainer[book].icon and bsContainer[book].icon ~= "") then
            bookicon = bsContainer[book].icon;
         else
            bookicon = BOOKSTORE_DEFAULT_BOOK_ICON;
         end
         slot:SetNormalTexture(bookicon);
         slot:SetPushedTexture(bookicon);
         slot:Enable();
      end
   end
end
-- END ]

-- [ FUNCTION: BookStore_LoadMore()
-- [  PURPOSE: Initialise and load the BookStore AddOn.
function BookStore_LoadMore()
   num_of_books = table.getn(bsContainer);
   BookStore_EnableButtons();
   BookStore_PrintMsg(BOOKSTORE_INIT);
   BookStoreBagNextShelf:Show();
   if (bsOptions.visible  == false) then
      -- allow 'esc' to close
      BookStore_ToggleDisplay();
   end
   if (bsOptions.icon == false) then
      BookStore_ToggleMMIcon();
   else
      BookStore_MM_Move();
   end
end

-- [ FUNCTION: BookStore_Load()
-- [  PURPOSE: Initialise and load the BookStore AddOn.
function BookStore_Load()
   bsContainer = {};
   bsOptions = {};
   this:RegisterEvent("VARIABLES_LOADED");
   this:RegisterForDrag("LeftButton");
   this:EnableMouseWheel(1);
   SLASH_BOOKSTORE1 = "/bookstore";
   SlashCmdList["BOOKSTORE"] = BookStore_HandleSlash;
end
-- END ]

-- [ FUNCTION: BookStore_ToggleDisplay()
-- [  PURPOSE: Show/Hide the BookStore 'Bag'.
function BookStore_ToggleDisplay()
   local frame = getglobal("BookStoreBag");
   if (frame) then
      if( frame:IsVisible() ) then
         frame:Hide();
         bsOptions.visible = false;
      else
         frame:Show();
         PlaySound("igCharacterInfoTab");
         bsOptions.visible = true;
      end
   end
end
-- END ]

-- [ FUNCTION: BookStore_ToggleMMIcon()
-- [  PURPOSE: Show/Hide the BookStore Mini-map Icon.
function BookStore_ToggleMMIcon()
   local mmbutton = getglobal("BookStoreMiniIcon");
   if ( mmbutton ) then
      if( mmbutton:IsVisible() ) then
         mmbutton:Hide();
         bsOptions.icon = false
      else
         mmbutton:Show();
         bsOptions.icon = true;
         BookStore_MM_Move();
      end
   end
end

-- [ FUNCTION: BookStore_HandleSlash(command)
-- [  PURPOSE: Handle the /bookstore command and deal with it appropriately.
function BookStore_HandleSlash(command)
   if (command == "help") then
      BookStore_PrintMsg(BOOKSTORE_HELP);
   elseif( command == "mm" ) then
      -- Show or Hide the Mini-map Icon
      BookStore_ToggleMMIcon();
   else
      -- No command or invalid command issued, so toggle display.
      BookStore_ToggleDisplay();
   end
end
-- END ]




-- [  PURPOSE: Interface function.
function BookStore_NextShelf()
     if current_shelf == MAXIMUM_SHELVES then
          return;
     end
     BookStore_LoadShelf(current_shelf + 1);
end

-- [  PURPOSE: Interface function.
function BookStore_PrevShelf()
     if current_shelf == 1 then
          return;
     end
     BookStore_LoadShelf(current_shelf - 1);
end

-- [  PURPOSE: Support function. Loads the specified shelf.
function BookStore_LoadShelf(shelf)
    current_shelf = shelf;
    if (current_shelf == 1) then
        BookStoreBagPrevShelf:Hide();
    else
        BookStoreBagPrevShelf:Show();
    end
    if (current_shelf < MAXIMUM_SHELVES) then
        BookStoreBagNextShelf:Show();
    else
        BookStoreBagNextShelf:Hide();
    end
    BookStoreBagTitle:SetText(BOOKSTORE_SHELF .. shelf);
    -- BookStore_Err(BOOKSTORE_OPENSHELF .. shelf);
    BookStore_Refresh();
end

-- [  PURPOSE: Interface function. Support selection of book shelf using mouse wheel.
function BookStore_OnMouseWheel(arg1)
    if (arg1 == -1) then
        BookStore_NextShelf();
    else
        BookStore_PrevShelf();
    end
end

-- [  PURPOSE: Support function. Returns if book title is matched exactly.
function BookStore_BookExist(title)
    for i, j in bsContainer do
        if (j.title == title) then 
            return true;
        end
    end
    return false;
end

-- [  PURPOSE: Support function. Returns index of first matching book.
function BookStore_BookSearch(title)
    for i, j in bsContainer do
        if (string.find(string.lower(j.title), string.lower(title))) then
            return i;
        end
    end
    return false;
end

-- [  PURPOSE: Support function. Returns position of book in shelf.
function BookStore_CalcBookIndex(book)
    return mod((book - 1), BOOKS_PER_SHELF) + 1;
end

-- [  PURPOSE: Support function. Returns shelf placed in.
function BookStore_CalcBookShelf(book)
    return floor((book - 1)/BOOKS_PER_SHELF) + 1;
end

-- [  PURPOSE: Support function. Returns true if shelf is empty.
function BookStore_IsEmptyShelf(shelf)
     if (BookStore_CalcBookShelf(table.getn(bsContainer)) >= shelf) then
          return true;
     end
     return false;
end




-- [ MINIMAP Functions

function BookStore_MM_OnLoad()
    this:RegisterForClicks("LeftButtonUp", "RightButtonUp");
    this:RegisterForDrag("LeftButton");
    BookStore_MM_Move();
end

function BookStore_MM_OnEnter()
    BookStore_ToolTip(BOOKSTORE_MM_TOOLTIP, Minimap);
end

function BookStore_MM_OnLeave()
    GameTooltip:Hide();
end

function BookStore_MM_Move()
    local mmbutton = getglobal("BookStoreMiniIcon");
    if (mmbutton) then
        local xpos,ypos;
        if bsOptions.SquareMinimap then
            xpos = 110 * cos(bsOptions.IconPos or 0);
            ypos = 110 * sin(bsOptions.IconPos or 0);
            xpos = math.max(-82,math.min(xpos,84));
            ypos = math.max(-86,math.min(ypos,82));
        else
            xpos = 80*cos(bsOptions.IconPos or 0);
            ypos = 80*sin(bsOptions.IconPos or 0);
        end
        mmbutton:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", 52-xpos, ypos-52);
    end
end

function BookStore_MM_Drag()
    if (this.isMoving) then
        local xpos,ypos = GetCursorPosition();
        local xmin,ymin = Minimap:GetLeft() or 400, Minimap:GetBottom() or 400;
        xpos = xmin-xpos/Minimap:GetEffectiveScale()+70;
        ypos = ypos/Minimap:GetEffectiveScale()-ymin-70;
        bsOptions.IconPos = math.deg(math.atan2(ypos,xpos));
        BookStore_MM_Move();
    end
end

function BookStore_MM_Moving(arg1)
    if (arg1) then
        this:StartMoving();
        this.isMoving = true;
    else
        this:StopMovingOrSizing();
        this.isMoving = false;
    end
end




-- [ BOOK FUNCTIONS

function BookStore_CopyBook_OnLoad()
    getglobal(this:GetName().."Text"):SetText(BOOKSTORE_BUTTON_COPY);
end

function BookStore_DeleteBook_OnEnter()
    BookStore_ToolTip(BOOKSTORE_BUTTON_DELETE, BookStoreBookDelete);
end

function BookStore_DeleteBook_OnLeave()
    GameTooltip:Hide();
end




-- [ BOOKSTORE BOOK FUNCTIONS

function BookStore_Book_OnLoad()
    this:RegisterForDrag("LeftButton");
    this:EnableMouseWheel(1);
end

-- [  PURPOSE: Interface function. Support flipping of book using mouse wheel.
function BookStore_Book_OnMouseWheel(arg1)
    if (arg1 == -1) then
        BookStore_NextPage();
    else
        BookStore_PrevPage();
    end
end


-- [ FUNCTION: BookStore_Err(msg)
-- [  PURPOSE: Print a message to the default error frame.
function BookStore_Err(msg)
   UIErrorsFrame:AddMessage(msg, 1.0, 1.0, 0.0, 1.0, 3);
end




-- [ Titan Panel Support

function TitanPanelBookStoreButton_OnLoad()

    if not TitanPanelButton_UpdateButton then
        return;
    end
    
    this.registry = {
        id = TITAN_BOOKSTORE_ID,
        menuText = BOOKSTORE_MENU,
        buttonTextFunction = "TitanPanelBookStoreButton_GetButtonText",
        tooltipTitle = BOOKSTORE_MENU,
        tooltipTextFunction = "TitanPanelBookStoreButton_GetTooltipText",
        frequency = TITAN_BOOKSTORE_FREQUENCY, 
        icon = TITAN_BOOKSTORE_ICON,
        iconWidth = 16,
        savedVariables = {
            ShowIcon = 1,
            ShowLabelText = 1,
            ShowColoredText = TITAN_NIL
        }
    };
end

function TitanPanelBookStoreButton_OnEvent()
end

function TitanPanelBookStoreButton_OnClick(arg1)
    if (arg1 == "LeftButton") then
        BookStore_ToggleDisplay();
    end
end

function TitanPanelBookStoreButton_GetTooltipText()
    local no_of_books = table.getn(bsContainer);
    if (no_of_books) then
        return BOOKSTORE_HAVE .. no_of_books .. BOOKSTORE_BOOKS;
    else
        return BOOKSTORE_EMPTY;
    end
end

function TitanPanelBookStoreButton_GetButtonText(id)
    if (TitanGetVar(TITAN_BOOKSTORE_ID, "ShowLabelText")) then
        return BOOKSTORE_MENU;
    end
end

function TitanPanelRightClickMenu_PrepareBookStoreMenu()

    TitanPanelRightClickMenu_AddTitle(BOOKSTORE_MENU);

    TitanPanelRightClickMenu_AddSpacer();

    info = {};
    info.text = BOOKSTORE_MENU_DISPLAY_MM;
    info.func = BookStore_ToggleMMIcon;
    info.value = BOOKSTORE_MENU_DISPLAY_MM;
    info.checked = bsOptions.icon;
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

    TitanPanelRightClickMenu_AddToggleLabelText(TITAN_BOOKSTORE_ID);

    TitanPanelRightClickMenu_AddSpacer();

    TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_BOOKSTORE_ID, TITAN_PANEL_MENU_FUNC_HIDE);

end
