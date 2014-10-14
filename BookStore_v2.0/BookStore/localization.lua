BOOKSTORE = {
    ["Name"] = "BookStore",
    ["Version"] = "2.0",
}

if (GetLocale() == "frFR") then 
    BOOKSTORE_INIT = BOOKSTORE.Name .. " v" .. BOOKSTORE.Version .. " s'est correctement initialis\195\169. Bonne Lecture!";
    BOOKSTORE_EXISTS = " already exists in " .. BOOKSTORE.Name .. ".";
    BOOKSTORE_ADDED = " a \195\169t\195\169 ajout\195\169 \195\160 l'archive " .. BOOKSTORE.Name .. " avec succ\195\168s";
    BOOKSTORE_FULL = "Votre " .. BOOKSTORE.Name .. " est actuellement plein, vous devez d\195\169truire un livre avant de pouvoir en ajouter un nouveau.";
    BOOKSTORE_OPENSHELF = "Opening " .. BOOKSTORE.Name .. " Shelf ";
    BOOKSTORE_SHELF = BOOKSTORE.Name .. " Shelf ";
    BOOKSTORE_BUTTON_DELETE = "Supprimer ce Livre";
    BOOKSTORE_BUTTON_COPY = "Faire une Copie";
    BOOKSTORE_PAGES = " Pages";
    BOOKSTORE_MINIMAP_TOOLTIP = "Manifester " .. BOOKSTORE.Name;
    BOOKSTORE_HELP = "/bookstore toggles " .. BOOKSTORE.Name .. " open and close\nSyntax: /bookstore\n/bookstore mm toggles MiniMap icon on and off\nSyntax: /answer mm\n/bookstore help print this message\nSyntax: /bookstore help\n";

    BOOKSTORE_HAVE = "You have ";
    BOOKSTORE_EMPTY = BOOKSTORE_HAVE .. " no books.";
    BOOKSTORE_HAVE = "You have ";
    BOOKSTORE_BOOKS = " book(s).";
    BOOKSTORE_MENU = "BookStore";
    BOOKSTORE_MENU_DISPLAY = "Show " .. BOOKSTORE.Name;
    BOOKSTORE_MENU_DISPLAY_MM = "Show Minimap Icon";

else
    BOOKSTORE_INIT = BOOKSTORE.Name .. " v" .. BOOKSTORE.Version .. " successfully initialised, happy reading!";
    BOOKSTORE_EXISTS = " already exists in " .. BOOKSTORE.Name .. ".";
    BOOKSTORE_ADDED = " successfully added to " .. BOOKSTORE.Name .. " collection.";
    BOOKSTORE_FULL = "Your " .. BOOKSTORE.Name .. " is currently full. You must delete a book before you can add a new one.";
    BOOKSTORE_OPENSHELF = "Opening " .. BOOKSTORE.Name .. " Shelf ";
    BOOKSTORE_SHELF = BOOKSTORE.Name .. " Shelf ";
    BOOKSTORE_BUTTON_DELETE = "Delete this Book";
    BOOKSTORE_BUTTON_COPY = "Make A Copy";
    BOOKSTORE_PAGES = " Pages";
    BOOKSTORE_MINIMAP_TOOLTIP = "Show/Hide " .. BOOKSTORE.Name;
    BOOKSTORE_HELP = "/bookstore toggles " .. BOOKSTORE.Name .. " open and close\nSyntax: /bookstore\n/bookstore mm toggles MiniMap icon on and off\nSyntax: /answer mm\n/bookstore help print this message\nSyntax: /bookstore help\n";

    BOOKSTORE_HAVE = "You have ";
    BOOKSTORE_EMPTY = BOOKSTORE_HAVE .. " no books.";
    BOOKSTORE_HAVE = "You have ";
    BOOKSTORE_BOOKS = " book(s).";
    BOOKSTORE_MENU = "BookStore";
    BOOKSTORE_MENU_DISPLAY = "Show " .. BOOKSTORE.Name;
    BOOKSTORE_MENU_DISPLAY_MM = "Show Minimap Icon";

end
