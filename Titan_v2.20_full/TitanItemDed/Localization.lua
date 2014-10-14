---     English     ---
--- by Tekkub (duh) ---
TITAN_ITEMDED_MENU_TEXT = "Itemized Deductions"
TITAN_ITEMDED_TOOLTIP_TITLE = "Itemized Deductions"
TITAN_ITEMDED_TOOLTIP_BAGS = "\nOpen bags\tClick\n";
TITAN_ITEMDED_TOOLTIP_DESTROY = "Destroy item\tShift-click\n";
TITAN_ITEMDED_TOOLTIP_IGNORE = "Ignore item\tDoubleclick\nAlways ignore\tAlt-Doubleclick\n";
TITAN_ITEMDED_TOOLTIP_SELL = "Shift-left-click to sell item\n";
TITAN_ITEMDED_NOITEMDESTROY = "No item to destroy";
TITAN_ITEMDED_NOITEMIGNORE = "No item to ignore";

TITAN_ITEMDED_BUTTON_EMPTIES = "(%u)";
TITAN_ITEMDED_BUTTON_NOITEM = "No Item ";
TITAN_ITEMDED_BUTTON_ITEM = "%s%s%s%s "; -- autodrop, name, bound, stack
TITAN_ITEMDED_BUTTON_STACK = " x%u";

TITAN_ITEMDED_TOOLTIP_ITEM = "%s%s%s%s%s\t%s %s\n"; -- autodrop, debug, name, bound, stack, value, price type
TITAN_ITEMDED_TOOLTIP_PARTSTACK = " x%u/%u";
TITAN_ITEMDED_TOOLTIP_STACK = " (1 stack)";
TITAN_ITEMDED_TOOLTIP_STACKS = " (%u stacks worth %s)"; -- #stacks, value
TITAN_ITEMDED_TOOLTIP_BIND = " (%s)";
TITAN_ITEMDED_TOOLTIP_ISAUC = "|cff00FF00A";
TITAN_ITEMDED_TOOLTIP_ISVEN = "|cff0000ffV";
TITAN_ITEMDED_TOOLTIP_ISUSR = "|cffff0000U";
TITAN_ITEMDED_TOOLTIP_TOTALVALUE = " \t--------------\nTotal value:\t%s";

TITAN_ITEMDED_CHAT_CANNOTDROP = "<ItemDed> Cannot autodrop!";
TITAN_ITEMDED_CHAT_HEADER = "<ItemDed> %s";
TITAN_ITEMDED_CHAT_THRESHOLDSET = "Threshold set to %s";
TITAN_ITEMDED_CHAT_IGNORED = "%s is now ignored.";
TITAN_ITEMDED_CHAT_NOTHINGTOIGNORE = "Nothing to ignore!";
TITAN_ITEMDED_CHAT_ALWAYSIGNORED = "%s is now always ignored.";
TITAN_ITEMDED_CHAT_RESETIGNORED = "Current ignored items reset.";
TITAN_ITEMDED_CHAT_RESETALWAYSIGNORED = "Always ignored items reset.";
TITAN_ITEMDED_CHAT_RESETAUTODROP = "Autodrop items reset.";
TITAN_ITEMDED_CHAT_DELETE = "Deleting %s worth %s";
TITAN_ITEMDED_CHAT_NOTHINGTOIGNORE = "Nothing to ignore!";

TITAN_ITEMDED_ITEM_BOUND = "Soulbound";
TITAN_ITEMDED_ITEM_BOE = "BoE";
TITAN_ITEMDED_ITEM_FIND_BOUND = "Soulbound";
TITAN_ITEMDED_ITEM_FIND_BOE = "Binds when equipped";

TITAN_ITEMDED_MENU_SELLALLJUNK = "Sell All Junk";
TITAN_ITEMDED_MENU_DROPTHISITEM = "Drop this item";
TITAN_ITEMDED_MENU_IGNORETHISITEM = "Ignore this item";
TITAN_ITEMDED_MENU_ALWAYSIGNORETHISITEM = "Always ignore this item";
TITAN_ITEMDED_MENU_AUTODROPTHISITEM = "Autodrop this item";
TITAN_ITEMDED_MENU_USEAUCTHISITEM = "Use Auctioneer price for this item";
TITAN_ITEMDED_MENU_IGNOREITEM = "Ignore Item";
TITAN_ITEMDED_MENU_ALWAYSIGNOREITEM = "Always Ignore Item";
TITAN_ITEMDED_MENU_AUTODROPITEM = "Autodrop Item";
TITAN_ITEMDED_MENU_USEAUCPRICE = "Use Auctioneer Price";
TITAN_ITEMDED_MENU_IGNORESET = "Ignore Set";
TITAN_ITEMDED_MENU_AUTODROPSET = "Autodrop Set";
TITAN_ITEMDED_MENU_RESET = "Reset";
TITAN_ITEMDED_MENU_THRESHOLD = "Set Threshold";
TITAN_ITEMDED_MENU_OPTIONS = "Options";
TITAN_ITEMDED_MENU_DMFAIRESET = "Darkmoon Faire \"Junk\"";
TITAN_ITEMDED_MENU_IGNORED = "Ignored";
TITAN_ITEMDED_MENU_ALWAYSIGNORED = "Always Ignored";
TITAN_ITEMDED_MENU_AUTODROP = "Autodrop";
TITAN_ITEMDED_MENU_AUTODROPITEMS = "Autodrop items to maintain %u free slots";
TITAN_ITEMDED_MENU_CHATFEEDBACK = "Chat Feedback";
TITAN_ITEMDED_MENU_SHOWTTHELP = "Show tooltip help";
TITAN_ITEMDED_MENU_ROUND = "Round to stack if within %u";
TITAN_ITEMDED_MENU_ROUNDSTACK = "Round only if full stack in bag";

TITAN_ITEMDED_CLASSES = {
	"Equipment (Soulbound)", 
	"Equipment (BoE)", 
	"Equipment (Other)",
	"Container",
	"Drink",
	"Food",
	"Scroll",
};

-- when localizing this table only change the first value of each set, 
-- the second is needed as-is for ReagentData to work right
TITAN_ITEMDED_RDCLASSES = {
	{"Bandage","bandage"},
	{"Cloth","cloth"},
	{"Poison","poison"},
	{"Poison Ingredient","poisoningredient"},
	{"Potion","potion"},
	{"Reagent","reagent"},
};

