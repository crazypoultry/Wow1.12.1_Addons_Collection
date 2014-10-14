RECIPEBOOK_VERSION_NUMBER = "1.12.0b";
RECIPEBOOK_VERSION_TEXT = "RecipeBook v. "
RECIPEBOOK_VERSION = RECIPEBOOK_VERSION_TEXT..RECIPEBOOK_VERSION_NUMBER;
RECIPEBOOK_SEND_TIMEOUT = 30; --Seconds until the Recipebook window times out.
RECIPEBOOK_AUTOSEND_TIMEOUT = 5; --Seconds between sending RecipeBook information.
RECIPEBOOK_SEND_PAUSE = 2; --Seconds to pause between batches of information.
RECIPEBOOK_INITIAL_PAUSE = 3; --Seconds to pause before assuming an incompatible version.
RECIPEBOOK_BATCHLENGTH = 1; --How many recipes to send at a time.

RECIPEBOOK_RED = "|cffff0000";
RECIPEBOOK_ORANGE = "|cffff9900";
RECIPEBOOK_YELLOW = "|cffffff00";
RECIPEBOOK_GREEN = "|cff00ff00";
RECIPEBOOK_CYAN = "|cff33ccff";
RECIPEBOOK_GREY = "|ccccccc00";
RECIPEBOOK_END = "|r";

RECIPEBOOK_COLOR = {
	[""] 		= { r = 1.00, g = 1.00, b = 1.00 };
	["optimal"]	= { r = 1.00, g = 0.50, b = 0.25 };
	["medium"]	= { r = 1.00, g = 1.00, b = 0.00 };
	["easy"]	= { r = 0.25, g = 0.75, b = 0.25 };
	["trivial"]	= { r = 0.50, g = 0.50, b = 0.50 };
	["shared"] 	= { r = 1.00, g = 1.00, b = 1.00 };
};


RECIPEBOOK_LOADED = string.format(RECIPEBOOK_VERSION.." loaded! Enter "..RECIPEBOOK_YELLOW.."/recipebook help"..RECIPEBOOK_END.." or "..RECIPEBOOK_YELLOW.."/rb help"..RECIPEBOOK_END.." for options; "..RECIPEBOOK_YELLOW.."/rb config"..RECIPEBOOK_END.." for a graphical configuration.");

RECIPEBOOK_USAGE = {
	RECIPEBOOK_GREEN.."Usage:"..RECIPEBOOK_END.." Use "..RECIPEBOOK_YELLOW.."/recipebook"..RECIPEBOOK_END.." or "..RECIPEBOOK_YELLOW.."/rb"..RECIPEBOOK_END.." with the following options:",
	"   (no options) : Show all current RecipeBook options",
	"   "..RECIPEBOOK_YELLOW.."help"..RECIPEBOOK_END.." : Display this help message.",
	"   "..RECIPEBOOK_YELLOW.."on|off"..RECIPEBOOK_END.." : Turns RecipeBook data display on and off.",
	"   "..RECIPEBOOK_YELLOW.."config"..RECIPEBOOK_END.." : Opens a graphical configuration window.",
	"   "..RECIPEBOOK_YELLOW.."tooltip on|off"..RECIPEBOOK_END.." : Turns tooltip display on and off.",
	"   "..RECIPEBOOK_YELLOW.."chatframe on|off"..RECIPEBOOK_END.." : Turns chatframe display on and off.",
	"   "..RECIPEBOOK_YELLOW.."friend on|off"..RECIPEBOOK_END.." : Turns RecipeBook friends' data display on and off",
	"   ",
	"   "..RECIPEBOOK_YELLOW.."specials"..RECIPEBOOK_END.." : Scans for tradeskill specializations you know.",
	"   "..RECIPEBOOK_YELLOW.."skill <character|all> <tradeskill|all>"..RECIPEBOOK_END.." : Displays the currently-known recipes for the given character and tradeskill.  BETA: Use 'all' to show all known tradeskills for a certain character or all of your characters (not shared) with a given tradeskill.  These output to the RecipeBook chat tab only, not to a window.",
	"   ",
	
	RECIPEBOOK_GREEN.."Banking Options:"..RECIPEBOOK_END.." use "..RECIPEBOOK_YELLOW.."/rb <option>"..RECIPEBOOK_END.." for your alts' data; use "..RECIPEBOOK_YELLOW.."/rb friend <option>"..RECIPEBOOK_END.." for your friends' data (i.e. /rb known off turns off display of your alts' known recipes; /rb friend known off turns off display of your friends' known recipes)",
	"   "..RECIPEBOOK_YELLOW.."bank <recipe link | [recipe name]>"..RECIPEBOOK_END.." : Puts a particular recipe in your banked list.  To easily bank a recipe open your chat frame, type '/rb bank' and then shift+click on the recipe to link it to RecipeBook.  If you'd rather type it out, then be sure to enclose it in square brackets: [Recipe Name].",
	"   "..RECIPEBOOK_YELLOW.."unbank <recipe link | [recipe name]>"..RECIPEBOOK_END.." : Removes a particular recipe from your banked list. Use just like /rb bank.",
	"   "..RECIPEBOOK_YELLOW.."autobank on|off"..RECIPEBOOK_END.." (BETA) : Toggle whether recipes in a character's bank are automatically tracked (defaults to OFF).",
	"   "..RECIPEBOOK_YELLOW.."autobag on|off"..RECIPEBOOK_END.." (BETA) : Toggle whether recipes in a character's bags are automatically banked at logout and bank access (defaults to OFF).",
	"   "..RECIPEBOOK_YELLOW.."banklist"..RECIPEBOOK_END.." : s the items currently stored in your bank (in RecipeBook chat tab).",
	"   ",
	"   "..RECIPEBOOK_YELLOW.."reset <tradeskill|all>"..RECIPEBOOK_END.." : Resets a given tradeskill the current character knows.  Optionally, resets all tradeskills the current character knows.",
	"   "..RECIPEBOOK_YELLOW.."clear <character>"..RECIPEBOOK_END.." : Clears all received tradeskill data for a particular character.  Cannot be used for the current character. (see /rb reset for that.)",
	"   "..RECIPEBOOK_YELLOW.."send <player> <tradeskill>"..RECIPEBOOK_END.." : Sends your RecipeBook data for a given tradeskill to another player.  Use 'all' as your tradeskill to send all tradeskills you know.",
	"   "..RECIPEBOOK_YELLOW.."receive <friend|guild|others> <accept|decline|prompt>"..RECIPEBOOK_END.." : For each subset of people (friends, guildmates who are not on your flist, everyone else), determine whether you will automatically accept RecipeBook shares, automatically decline, or ask to be prompted.",
	"   ",
	RECIPEBOOK_GREEN.."Display Options:"..RECIPEBOOK_END.." use "..RECIPEBOOK_YELLOW.."/rb <option>"..RECIPEBOOK_END.." for your alts' data; use "..RECIPEBOOK_YELLOW.."/rb friend <option>"..RECIPEBOOK_END.." for your friends' data (i.e. /rb known off turns off display of your alts' known recipes; /rb friend known off turns off display of your friends' known recipes)",
	"   "..RECIPEBOOK_YELLOW.."known on|off"..RECIPEBOOK_END.." : Show/Hide characters who already know a given recipe",
	"   "..RECIPEBOOK_YELLOW.."learn on|off"..RECIPEBOOK_END.." : Show/Hide characters who can currently learn a given recipe",
	"   "..RECIPEBOOK_YELLOW.."future on|off"..RECIPEBOOK_END.." : Show/Hide characters who need only skillups to learn a given recipe (if the recipe requires a specialization, the character must have the specialization).",
	"   "..RECIPEBOOK_YELLOW.."banked on|off"..RECIPEBOOK_END.." : Show/Hide whether a given recipe has been banked (defaults to OFF).",
	"   "..RECIPEBOOK_YELLOW.."faction same|opposite|both"..RECIPEBOOK_END.." : Show data for characters of a particular faction, or both factions",
	"   "..RECIPEBOOK_YELLOW.."auction <altslearn|altsfuture|youfuture|noalts|allknown> <r,g,b>"..RECIPEBOOK_END.." Sets the color for auction and merchant recipe icons.  Please note: r,g,b must be between 0 and 1 and represent the percentage of that color you want.",

	"   ",

	};

--== Built-in data strings ==--
RECIPEBOOK_RECIPEPREFIXES = "Formula Pattern Plans Recipe Schematic";
RECIPEBOOK_RECIPEWORD = "Recipe";
RECIPEBOOK_ALCHEMY = "Alchemy";
RECIPEBOOK_BLACKSMITHING = "Blacksmithing";
RECIPEBOOK_WEAPONSMITH = "Weaponsmith"
RECIPEBOOK_MASTER = "Master";
RECIPEBOOK_BLACKSMITHING_SPECIALS = "|Armorsmith |Weaponsmith |Master Swordsmith |Master Axesmith |Master Hammersmith |";
RECIPEBOOK_ENCHANTING = "Enchanting";
RECIPEBOOK_ENGINEERING = "Engineering";
RECIPEBOOK_ENGINEERING_SPECIALS = "|Goblin Engineer |Gnomish Engineer |";
RECIPEBOOK_LEATHERWORKING = "Leatherworking";
RECIPEBOOK_LEATHERWORKING_SPECIALS = "|Tribal Leatherworking |Elemental Leatherworking |Dragonscale Leatherworking |";
RECIPEBOOK_TAILORING = "Tailoring";
RECIPEBOOK_COOKING = "Cooking";
RECIPEBOOK_FIRSTAID = "First Aid";

RECIPEBOOK_RECIPENAMES = table.concat({RECIPEBOOK_ALCHEMY,RECIPEBOOK_BLACKSMITHING,RECIPEBOOK_ENCHANTING,RECIPEBOOK_ENGINEERING,RECIPEBOOK_LEATHERWORKING,RECIPEBOOK_TAILORING,RECIPEBOOK_COOKING,RECIPEBOOK_FIRSTAID}, " ");

--== Necessary for the parser ==--
RECIPEBOOK_CHAT_SKILLUP = gsub(gsub(ERR_SKILL_UP_SI, "%%s", "(%%w*)"), "%%d.", "(%%d+)%%.");
RECIPEBOOK_CHAT_LEARN_RECIPE = string.sub(ERR_LEARN_RECIPE_S, 1, -4);
RECIPEBOOK_CHAT_LEARN_SPELL = string.sub(ERR_LEARN_SPELL_S, 1, -4);

RECIPEBOOK_REGEX_REQUIRES = string.gsub(string.gsub(ITEM_MIN_SKILL, "%%s", "%(%[%%w%%s%]+%)" ), "%(%%d%)", "%%%(%(%%d+%)%%%)");
RECIPEBOOK_REGEX_SPECIALTY = string.gsub(ITEM_REQ_SKILL, "%%s", "%(%%w+%)%(%.%*%)" );
RECIPEBOOK_REGEX_LEVEL = string.gsub(ITEM_MIN_LEVEL, "%%d", "%(%%d+%)");
RECIPEBOOK_REGEX_NOTONLINE = string.gsub(ERR_CHAT_PLAYER_NOT_FOUND_S, "%%s", "%(%%w+%)");
RECIPEBOOK_REGEX_UNLEARNSKILL = string.gsub(ERR_SPELL_UNLEARNED_S, "%%s", "(%%w+)");

--== Chatframe Output ==--
RECIPEBOOK_CHATFRAME_KNOWNBY = " is already known by: ";
RECIPEBOOK_CHATFRAME_NONEKNOWN = " is known by no alts";
RECIPEBOOK_CHATFRAME_CANLEARN = " can be learned by: ";
RECIPEBOOK_CHATFRAME_NONELEARN = " cannot be learned by any alts";
RECIPEBOOK_CHATFRAME_WILLLEARN = " will eventually be learnable by (current skill): ";
RECIPEBOOK_CHATFRAME_NONEWILLLEARN = " has no alts who need only skillups to learn it.";
RECIPEBOOK_CHATFRAME_BANKED = " has been banked by: ";
RECIPEBOOK_CHATFRAME_NOTBANKED = " has not been banked.";
RECIPEBOOK_CHATFRAME_BANKLISTPERSONALHEADER = "Banked Items (for character %s only):";
RECIPEBOOK_CHATFRAME_BANKLISTBLANK = "  No banked recipes found for "; 
RECIPEBOOK_CHATFRAME_BANKLISTHEADER = "Banked Items (for this faction only):"

--== Tooltip Output ==--
RECIPEBOOK_KNOWNBY = "Already known by: ";
RECIPEBOOK_CANLEARN = "Can be learned by: ";
RECIPEBOOK_WILLLEARN = "Will be learnable by: ";
RECIPEBOOK_ISBANKED = "Recipe has been banked by: ";

--== /rb Command output ==--
RECIPEBOOK_FRIEND_PREFIX = "  For friends: "

RECIPEBOOK_ON = RECIPEBOOK_GREEN.."On"..RECIPEBOOK_END;
RECIPEBOOK_OFF = RECIPEBOOK_RED.."Off"..RECIPEBOOK_END;

RECIPEBOOK_SHOW = RECIPEBOOK_GREEN.."Showing"..RECIPEBOOK_END;
RECIPEBOOK_HIDE = RECIPEBOOK_RED.."Hiding"..RECIPEBOOK_END;

RECIPEBOOK_TXT_SUPPLIES = "Supplies required for ";

--Toggle On|Off options
RECIPEBOOK_STATUS_ONOFF = "RecipeBook data output: %s (data collection is always on)"
RECIPEBOOK_FRIENDSHOW_ONOFF = "Friends data display: %s";
RECIPEBOOK_AUTOBANK_ONOFF = "Auto scanning of bank for recipes on open/close is %s";
RECIPEBOOK_AUTOBAGS_ONOFF = "Auto scanning of bags for recipes on logout and bank access is %s";

--Toggle Show|Hide options
RECIPEBOOK_SHOWSELF_SHOWHIDE = "%s data for the current character.";
RECIPEBOOK_KNOWN_SHOWHIDE = "%s data for characters who already know recipes.";
RECIPEBOOK_CANLEARN_SHOWHIDE = "%s data for characters who can learn recipes.";
RECIPEBOOK_WILLLEARN_SHOWHIDE = "%s data for characters who need only skillups to be able to learn recipes.";
RECIPEBOOK_BANKED_SHOWHIDE = "%s whether you have banked particular recipes.";

--Toggle Specific Options
RECIPEBOOK_OUTPUT_TOOLTIP= "Data output to tooltip: ";
RECIPEBOOK_OUTPUT_CHATFRAME = "Data output to Recipe Book Chatframe: ";
--
RECIPEBOOK_DISPLAY_FACTION = "Displaying match data for %s characters only.";
RECIPEBOOK_DISPLAY_BOTHFACTIONS = "Displaying match data for both Alliance and Horde characters.";
RECIPEBOOK_DISPLAY_NOFACTIONS = "Displaying no match data (no factions selected).";
--
RECIPEBOOK_ACCEPT_ALL = "Auto-accepting all RecipeBook data shares.";
RECIPEBOOK_DECLINE_ALL= "Auto-declining all RecipeBook data shares.";
RECIPEBOOK_PROMPT_ALL = "Prompting for all RecipeBook data shares.";
RECIPEBOOK_RFRIENDS = "Friends: ";
RECIPEBOOK_RGUILD = "; Guildmates: ";
RECIPEBOOK_ROTHERS = "; Others: ";
RECIPEBOOK_AUTOACCEPT = RECIPEBOOK_GREEN.."Auto-accept"..RECIPEBOOK_END.." shares";
RECIPEBOOK_AUTODECLINE = RECIPEBOOK_RED.."Auto-decline"..RECIPEBOOK_END.." shares";
RECIPEBOOK_PROMPT = "Prompt for shares";
--
RECIPEBOOK_ADDED_SPECIALS = "Found and added the following tradeskill specializations: ";

--Error Messages
RECIPEBOOK_INVALID_OUTPUT = "Invalid option.  Use /rb output [tooltip|chatframe|both] [on|off]";
RECIPEBOOK_INVALID_DISPLAY = "Invalid option.  Valid options are: same, opposite, both";
RECIPEBOOK_INVALID_ONOFF = "Invalid option.  Valid options are: on, off";

RECIPEBOOK_NOALTGIVEN = "I don't know who to list recipes for.  Use "..RECIPEBOOK_YELLOW.."/recipebook skill <alt> <tradeskill>"..RECIPEBOOK_END.." to list tradeskills for an alt.";
RECIPEBOOK_NOALTMATCH = "No match found for character ";
RECIPEBOOK_NOTRADESKILLGIVEN = "I don't know what tradeskill to list recipes for.  Use "..RECIPEBOOK_YELLOW.."/recipebook skill <alt> <tradeskill>"..RECIPEBOOK_END.." to list tradeskills for an alt.";
RECIPEBOOK_NOTRADESKILLMATCH = "No tradeskill match found for ";

RECIPEBOOK_RECEIVE_USAGE = "Usage: "..RECIPEBOOK_YELLOW.."/rb receive <friend|guild|others> <accept|decline|prompt>"..RECIPEBOOK_END..", where accept will auto-accept for that group, decline will auto-decline, and prompt will always prompt."
RECIPEBOOK_NOTINGUILD = "You're not in a guild!";

RECIPEBOOK_INVALID_RESET = "I don't know what to reset data for.  Use "..RECIPEBOOK_YELLOW.."/rb reset <tradeskill>"..RECIPEBOOK_END.." to reset a tradeskill for this character.  /rb reset all will reset all tradeskills.";
RECIPEBOOK_RESET_SUCCEED = "Successfully reset data for tradeskill ";
RECIPEBOOK_RESET_FAIL = "Could not reset data, no match for tradeskill ";
RECIPEBOOK_RESET_ALL = "Successfully reset all tradeskill data for ";
RECIPEBOOK_RESET_MASTERLIST = "Successfully reset master list of tradeskill information.";
RECIPEBOOK_ERROR_RESETSELF = "Cannot use /rb clear on yourself.  Use /rb reset all to reset your tradeskills.";

RECIPEBOOK_BANK_SUCCEED =  "Successfully banked %s!";
RECIPEBOOK_BANK_FAIL =  "Need an item link or recipe title (in [Recipe Name] format) to bank.";
RECIPEBOOK_BANK_ALREADYBANKED = "Recipe already banked by this character.  If you really want to manually bank it, use /rb unbank [Link] first.";
RECIPEBOOK_UNBANK_SUCCEED=  "Successfully removed %s from banked list for %s.";
RECIPEBOOK_UNBANK_ALLSUCCEED = "Item %s is no longer banked by any characters.";
RECIPEBOOK_UNBANK_FAIL=  "No banked item match or this player has not banked this recipe; I need an item link or recipe title (in [Recipe Name] format) to unbank.  Use "..RECIPEBOOK_YELLOW.."/rb unbank <item> all"..RECIPEBOOK_END.." to completely remove a banked item.";

RECIPEBOOK_AUTOBANK = "Recipes have been moved into your bank: ";
RECIPEBOOK_AUTOUNBANK = "Recipes have been removed from your bank: ";
RECIPEBOOK_AUTOBAG = "Recipes have been moved into %s bags: ";

RECIPEBOOK_ERROR_INVALIDCOLOR = "Could not set color.  Use "..RECIPEBOOK_YELLOW.."/rb auction <altslearn|altsfuture|youfuture|noalts|allknown> <r,g,b>"..RECIPEBOOK_END.." to set an auction house color code.  Note that r,g, and b should be between 0 and 1.";
RECIPEBOOK_AUCCOLOR_ALTSCANLEARN = "Color for recipes that can be learned by alts (not including this character).";
RECIPEBOOK_AUCCOLOR_ALTSWILLLEARN = "Color for recipes that will eventually be learnable by alts (may include this character).";
RECIPEBOOK_AUCCOLOR_YOUWILLLEARN = "Color for recipes that will eventually be learnable by this character only.";
RECIPEBOOK_AUCCOLOR_NOALTSCANLEARN = "Color for recipes that no alts will be able to learn.";
RECIPEBOOK_AUCCOLOR_ALLALTSKNOW = "Color for recipes that are known by all tracked alts.";

--== Informational Messages ==--
RECIPEBOOK_INFO_CANLEARNONSKILLUP = "You may now be able to learn %s, banked by %s.";


--== RecipeBook_Print() ==--
RECIPEBOOK_ERROR_PREFIX = "|cffffff00<|cffff0000RecipeBook Error|cffffff00>|r ";
RECIPEBOOK_PREFIX = "|cffffff00<RecipeBook>|r ";

--== Config ==--
RECIPEBOOK_CONFIG_TITLEBAR = "Recipe Book Configuration";

RECIPEBOOK_CBX_DISPLAYTOGGLE_TEXT = "Display Recipe Book Output";
RECIPEBOOK_CBX_FRIENDSDISPLAYTOGGLE_TEXT = "Display Shared (Friends) Data";
RECIPEBOOK_CBX_SELFDISPLAYTOGGLE_TEXT = "Include Current Character";
RECIPEBOOK_CBX_BANKDISPLAYTOGGLE_TEXT = "Show Banked Status";
RECIPEBOOK_CBX_AUCTIONDISPLAYTOGGLE_TEXT = "Color-code auctions and merchants";
RECIPEBOOK_CBX_AUCTIONBLACKBANKEDTOGGLE_TEXT = "Blackout banked recipes";
RECIPEBOOK_CBX_TRACKSELF_TEXT = "Collect RecipeBook data for this character";
RECIPEBOOK_CBX_KNOW_TEXT = "Are already known";
RECIPEBOOK_CBX_LEARN_TEXT = "Can be learned";
RECIPEBOOK_CBX_WILLLEARN_TEXT = "Will be learnable";
RECIPEBOOK_CBX_OUTPUTTOOLTIP_TEXT = "Tooltip";
RECIPEBOOK_CBX_OUTPUTCHATFRAME_TEXT = "RecipeBook chat tab";
RECIPEBOOK_CBX_SAMEFACTION_TEXT = "Same Faction";
RECIPEBOOK_CBX_OPPOSITEFACTION_TEXT = "Opposite Faction";
RECIPEBOOK_CBX_AUTOBANK_TEXT = "Your bank slots";
RECIPEBOOK_CBX_AUTOBAGS_TEXT = "Your bags";

RECIPEBOOK_DD_FRIENDSHARE = "Friends";
RECIPEBOOK_DD_GUILDSHARE = "Guildmates";
RECIPEBOOK_DD_OTHERSHARE = "Everyone Else";

RECIPEBOOK_CONFIG_HEADER_GENERAL = "RecipeBook Options: General";
RECIPEBOOK_CONFIG_HEADER_COLLECTION = "RecipeBook Options: Data Collection";
RECIPEBOOK_CONFIG_HEADER_SHARE = "RecipeBook Options: Sharing";
RECIPEBOOK_CONFIG_HEADER_AUCTION = "RecipeBook Options: Auction House";

RECIPEBOOK_CONFIG_TAB_GENERAL = "General";
RECIPEBOOK_CONFIG_TAB_SHARING = "Sharing";
RECIPEBOOK_CONFIG_TAB_AUCTION = "Auction";
RECIPEBOOK_CONFIG_TAB_BANKING = "Collection";

RECIPEBOOK_CONFIG_TEXT_SHOWCATEGORIES = "Show recipes that:";
RECIPEBOOK_CONFIG_TEXT_OUTPUT = "Output recipe information to:";
RECIPEBOOK_CONFIG_TEXT_FACTION = "Show recipe data for:";
RECIPEBOOK_CONFIG_TEXT_SHARE = "What to do when you receive a RecipeBook share request from:";
RECIPEBOOK_CONFIG_DD_SHARE = {
	{name = "A", text = "Accept"},
	{name = "D", text = "Decline"},
	{name = "P", text = "Prompt"}
	};
	
RECIPEBOOK_CONFIG_TEXT_AUTOTRACK = "Automatically track banked recipes for:";

--== Search Panels ==--
RECIPEBOOK_SEARCH_TITLEBAR = "RecipeBook Search";
RECIPEBOOK_CBX_SEARCHMATS_TEXT = "Search in materials";
RECIPEBOOK_CBX_SEARCHITEMS_TEXT = "Search in known recipes";
RECIPEBOOK_CBX_SEARCHEXACT_TEXT = "Search exact phrase only";
RECIPEBOOK_ERR_NOSEARCHRESULT = "No matches for that search";
RECIPEBOOK_SEARCHTEXT_MATSPREFIX = "  Uses: ";
RECIPEBOOK_SEARCHTEXT_ITEMSTEMPLATE = " Known by: %d alts (%d additional have %s)";

--== Send Data ==--
RECIPEBOOK_SEND_USAGE = "Usage: "..RECIPEBOOK_YELLOW.."/rb send <person> <tradeskill>"..RECIPEBOOK_END;
RECIPEBOOK_MATCHEDSELF = "No reason to send yourself data.  Besides, it won't work. :)";
RECIPEBOOK_MESSAGE_TRIGGER_WORD = "Recipe\195\159ook";
RECIPEBOOK_MESSAGE_TRIGGER = "["..RECIPEBOOK_MESSAGE_TRIGGER_WORD.."]";
RECIPEBOOK_MESSAGE_INITIATE = " Hello, this is RecipeBook.  I'd like to initiate a share for ";
RECIPEBOOK_MESSAGE_TERMINATE = " Completed RecipeBook share for ";
RECIPEBOOK_MESSAGE_CANCEL = " Cancel RecipeBook share for ";
RECIPEBOOK_MESSAGE_ACCEPT = " Accept RecipeBook share for ";
RECIPEBOOK_MESSAGE_BUSY = " Receiver busy, try again later";
RECIPEBOOK_MESSAGE_ACKNOWLEDGE = " Acknowledging receipt of RecipeBook share data [spam protection].";

RECIPEBOOK_ERROR_AUTODECLINE = " does not currently wish to accept RecipeBook data for ";
RECIPEBOOK_ERROR_DECLINEDSESSION = "Auto-declining RecipeBook share from ";
RECIPEBOOK_ERROR_ACCEPTEDSESSION = "Auto-accepting RecipeBook share from %s for %s.";

RECIPEBOOK_ERROR_BUSY = "%s is currently busy.  Try again in a few minutes.";
RECIPEBOOK_ERROR_CANCEL = "RecipeBook session cancelled.";
RECIPEBOOK_ERROR_INITIATE = "RecipeBook is attempting to send tradeskill data for %s to %s (this may take some time)...";
RECIPEBOOK_ERROR_QUEUETERMINATE = "RecipeBook data successfully sent!  There will be a short pause now.";
RECIPEBOOK_ERROR_TERMINATE = "Successfully completed sending RecipeBook data!";
RECIPEBOOK_ERROR_RECEIVED = "RecipeBook data for %s successfully received from %s!";

RECIPEBOOK_POPUP_SEND = "Attempting to send your RecipeBook data for %s to %s.  This transfer will be cancelled in %d %s.";
RECIPEBOOK_POPUP_RECEIVE = "%s would like to send you RecipeBook data for %s.  This transfer will be cancelled in %d %s.";
RECIPEBOOK_POPUP_PAUSE = "RecipeBook is pausing to prevent spam prevention from logging you off.  Next tradeskill in %d %s.";

--== Correct Enchantments ==--
RECIPEBOOK_ENCHANTING_FILLER = ""; --German version has multiple broken enchanting recipes.

--== Key Bindings ==--
BINDING_HEADER_RECIPEBOOK = "RecipeBook Keys";
--BINDING_NAME_RECIPEBOOK_SKILL = "(coming soon) Skill Panel";
BINDING_NAME_RECIPEBOOK_CONFIG = "Config Panel";
BINDING_NAME_RECIPEBOOK_SEARCH = "Search Window";

--== Exceptions ==--  ["Item as it appears in tradeskill frame"] = "Item as it appears in recipe"
RECIPEBOOK_EXCEPTIONS = {
	["Mechanical Squirrel Box"] = "Mechanical Squirrel",
	["Heavy Scorpid Gauntlet"] = "Heavy Scorpid Gauntlets",
	["Alarm-O-Bot"] = "Gnomish Alarm-O-Bot",
	["Festive Red Dress"] = "Festival Dress",
	["Festive Red Pant Suit"] = "Festival Suit",
}