-- Version : English - Ramble 
-- Translation : 
--   DE: Iruwen
MYINVENTORY_MYADDON_VERSION = "1.1.4 (1300)";
-- MYADDONS
MYINVENTORY_MYADDON_NAME = "MyInventory";
MYINVENTORY_MYADDON_DESCRIPTION = "A simple, compact all in one inventory window.";
--KEYBINDINGS
BINDING_HEADER_MYINVENTORYHEADER	= "My Inventory";
BINDING_NAME_MYINVENTORYICON		= "My Inventory Toggle";
BINDING_NAME_MYINVENTORYCONFIG   = "My Inventory Config Window";
-- USAGE
MYINVENTORY_CHAT_COMMAND_USAGE		= {
	[1] = "Usage: /mi [show/|replace/|cols/|lock/|graphics/|back/|config]",
	[2] = "Commands:",
	[3] = "show    - toggles the MyInventory window",
	[4] = "replace - if it should replace the bags or not",
	[5] = "cols   - how many columns there should be in each row.",
	[6] = "lock - lock/unlock the window for dragging and auto closing.",
	[7] = "graphics - Toggle Blizzard style art",
	[8] = "back - Toggle background visibility",
	[9] = "freeze - keep window open at vendors",
	[10]= "count - display count of free slots or used slots",
	[11]= "title - hide/show the title",
	[12]= "cash - hide/show the money display",
	[13]= "buttons - hide/show the buttons",
	[14]= "resetpos - reset position to lower right corner of the screen",
	[15]= "aioi - toggles AIOI style bag layout",
	[16]= "config - Open control panel"
	--Didn't put these into slash commands yet
--	[10] = "highlightitems - Highlight items when you mouse over a bag icon",
--	[11] = "highlightbags - Highlight bag when you mouse over an item", 
}
--MESSAGES
MYINVENTORY_MSG_LOADED = "Svarten and Ramble's MyInventory AddOn loaded.";
MYINVENTORY_MSG_INIT_s   = "MyInventory: Profile for %s initialized.";
MYINVENTORY_MSG_CREATE_s = "MyInventory: Creating new Profile for %s";
--OPTION TOGGLE MESSAGES
MYINVENTORY_CHAT_PREFIX            = "My Inventory: ";
MYINVENTORY_CHAT_REPLACEBAGSON     = "Replacing bags.";
MYINVENTORY_CHAT_REPLACEBAGSOFF    = "Not replacing bags.";
MYINVENTORY_CHAT_GRAPHICSON        = "Background art enabled.";
MYINVENTORY_CHAT_GRAPHICSOFF       = "Background art disabled.";
MYINVENTORY_CHAT_BACKGROUNDON      = "Background is now opaque.";
MYINVENTORY_CHAT_BACKGROUNDOFF     = "Background is now transparent.";
MYINVENTORY_CHAT_HIGHLIGHTBAGSON   = "Highlighting bags.";
MYINVENTORY_CHAT_HIGHLIGHTBAGSOFF  = "Not highlighting bags.";
MYINVENTORY_CHAT_HIGHLIGHTITEMSON  = "Highlighting items.";
MYINVENTORY_CHAT_HIGHLIGHTITEMSOFF = "Not highlighting items.";
MYINVENTORY_CHAT_FREEZEON          = "Staying open when leaving vendor";
MYINVENTORY_CHAT_FREEZEOFF         = "Closing when leaving vendor";
MYINVENTORY_CHAT_COUNTON           = "Counting taken slots."
MYINVENTORY_CHAT_COUNTOFF          = "Counting free slots."
MYINVENTORY_CHAT_SHOWTITLEON       = "Title shown"
MYINVENTORY_CHAT_SHOWTITLEOFF      = "Title hidden"
MYINVENTORY_CHAT_CASHON            = "Cash Shown"
MYINVENTORY_CHAT_CASHOFF           = "Cash Hidden"
MYINVENTORY_CHAT_BUTTONSON         = "Buttons Shown"
MYINVENTORY_CHAT_BUTTONSOFF        = "Buttons Hidden"
--MyInventory Title
MYINVENTORY_TITLE     = "Inventory";
MYINVENTORY_TITLE_S   = "%s's Inventory";
MYINVENTORY_TITLE_SS  = "%s of %s's Inventory";
MYINVENTORY_SLOTS_DD  = "%d/%d Slots";
--MyInventory Options frame
MYINVENTORY_CHECKTEXT_REPLACEBAGS    = "Replace default bags";
MYINVENTORY_CHECKTEXT_GRAPHICS       = "Blizzard style artwork";
MYINVENTORY_CHECKTEXT_BACKGROUND     = "Opaque Background";
MYINVENTORY_CHECKTEXT_HIGHLIGHTBAGS  = "Highlight item's bag";
MYINVENTORY_CHECKTEXT_HIGHLIGHTITEMS = "Highlight bag's item";
MYINVENTORY_CHECKTEXT_SHOWTITLE      = "Show Title"
MYINVENTORY_CHECKTEXT_CASH           = "Show Cash"
MYINVENTORY_CHECKTEXT_BUTTONS        = "Show Buttons"
MYINVENTORY_CHECKTEXT_FREEZE         = "Keep Window Open"
MYINVENTORY_CHECKTEXT_COUNTUSED      = "Used Slots"
MYINVENTORY_CHECKTEXT_COUNTFREE      = "Free Slots"
MYINVENTORY_CHECKTEXT_COUNTOFF       = "Off"

MYINVENTORY_CHECKTIP_REPLACEBAGS     = "When checked, MyInventory takes over as the default bag";
MYINVENTORY_CHECKTIP_GRAPHICS        = "Enables Blizzard style background artwork";
MYINVENTORY_CHECKTIP_BACKGROUND      = "Turn the background on or off";
MYINVENTORY_CHECKTIP_HIGHLIGHTBAGS   = "When you mouse over an item in MyInventory it will highlight the bag that that item is in.";
MYINVENTORY_CHECKTIP_HIGHLIGHTITEMS  = "When you mouse over a bag in MyInventory it will highlight all the items that are in that bag";
MYINVENTORY_CHECKTIP_SHOWTITLE       = "Show/Hide the title and player name"
MYINVENTORY_CHECKTIP_CASH            = "Show/Hide Money display"
MYINVENTORY_CHECKTIP_BUTTONS         = "Show/Hide Close, Lock and Hide Bags Buttons"
MYINVENTORY_CHECKTIP_FREEZE          = "When leaving a vendor, Bank, or AH, keep the MI window open"
MYINVENTORY_CHECKTIP_COUNTUSED       = "Show Used slots"
MYINVENTORY_CHECKTIP_COUNTFREE       = "Show Free Slots"
MYINVENTORY_CHECKTIP_COUNTOFF        = "Hides the Slots"



-- UNTRANSLATED:
MYINVENTORY_CHAT_AIOISTYLEON    = "All-In-One-Inventory style item ordering.";
MYINVENTORY_CHAT_AIOISTYLEOFF   = "My Inventory style item ordering.";
