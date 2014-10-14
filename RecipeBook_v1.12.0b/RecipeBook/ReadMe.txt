RecipeBook ReadMe file
Version 1.12.0a
Last updated 25 Sep 2006 by Ayradyss
Installation: Unzip into the World of Warcraft/Interface/AddOns directory.

RecipeBook is a mod that allows you to browse tradeskill recipes with one alt and see whether your other alts know it.   

For example:
I have character BetsyRoss, who is a tailor by nature.  She knows Pattern: American Flag, but for some reason, I can never remember this when UncleScrooge goes to the auction house to buy patterns.  
	* Previously, I would have to keep a written or mental list of BetsyRoss's known patterns so that UncleScrooge didn't buy her a second copy of Pattern: American Flag on accident.  
	* Now, with RecipeBook, UncleScrooge can mouse over Pattern: American Flag and see "Already known by: BetsyRoss" right there on the tooltip - or, if he chooses, in a special chat tab just for RecipeBook information.
	
It's fun! It's helpful! It's easy to use!  It's also still in development, so there are a few known issues and some miscellaneous housework to be done.

RecipeBook loads defaulted to on, tooltip output, not parsing the current alt, same faction, showing known/learn/future recipes.  Banked data loads defaulted to off.
Usage: /recipebook or /rb <options>
	General:
	/rb help : Displays a help message
	/rb on|off : Turns RecipeBook's data display on or off.  It will continue to update alts' tradeskills when the tradeskill frames are opened, so you have the best list possible.
	/rb self on|off : Enables/disables parsing of the current character.  May be a little redundant in tooltips, helpful in chatframe output.  Defaults to OFF.
	/rb config : Opens the graphical config window.
	/rb output tooltip|chatframe on|off : Turns on and off the tooltip and chatframe display. "Tooltip" adds a line to the game tooltip if and only if one of your alts knows this pattern.  "Chatframe" outputs to the "Recipe Book" chat tab whether or not an alt knows a pattern.
	/rb skill <alt> <tradeskill> : Use /rb skill to open a window with a list of every recipe your alt knows in a given tradeskill.  So, just in case UncleScrooge were curious, he could type "/rb skill betsyross tailoring" and find out every tailoring recipe BetsyRoss knew as of the most recent update.
	/rb reset <tradeskill|all> : Resets a given tradeskill the current character knows.  Optionally, resets all tradeskills the current character knows. Useful for unlearning tradeskills.
	/rb clear <character>: Clears all RecipeBook data for a particular character.
	/rb specials : Scans for tradeskill specializations known.
	
	Sharing: 	
	/rb send <player> <tradeskill> : Sends your RecipeBook data for a given tradeskill to another player.  Use 'all' as your tradeskill to send all tradeskills you know.
	/rb receive <friend|guild|others> <accept|decline|prompt> : For each subset of people (friends, guildmates who are not on your flist, everyone else), determine whether you will automatically accept RecipeBook shares, automatically decline, or ask to be prompted.
	
	Friend: use /recipebook friend or /rb friend with the following options (i.e. /rb friend on)
	/rb friend on|off : Turns RecipeBook friends' data display on and off
		
	Display: use /rb <option> for your alts' data; use /rb friend <option> for your friends' data (i.e. /rb known off turns off display of your alts' known recipes; /rb friend known off turns off display of your friends' known recipes)
	known on|off : Show/Hide characters who already know a given recipe
	learn on|off : Show/Hide characters who can currently learn a given recipe
	future on|off : Show/Hide characters who need only skillups to learn a given recipe (if the recipe requires a specialization, the character must have the specialization).
	faction same|opposite|both : Show data for charactes of a particular faction, or both factions
	
	Banking: 
	/rb banked on|off : Show/Hide banked item information in a tooltip (DEFAULTS TO OFF)
	/rb bank <recipe link or [recipe name]> : Use /rb bank + shift-clicking a recipe (as if you were linking to the chat window) to mark that recipe as banked.  
	/rb unbank <recipe link or [recipe name]> : Removes a recipe from the banked list.  You may also type the recipe's *exact* name in, enclosed in square brackets, to add/remove it (i.e. /rb bank [Formula: Enchant Gloves - Greater Agility]).
	/rb banklist : Displays your banked items.
	/rb autobank on|off : Automatically tracks recipes in your bank.  Updates when bank window is opened or closed. (DEFAULTS TO OFF)
	/rb autobag on|off : Automatically tracks recipes in your bags.  Updates with autobank (if autobank is on) and on logout. (DEFAULTS TO OFF)
	
	In Progress:
	/rb skill all <tradeskill> : Show all of your characters (not shared) with a given tradeskill.  This outputs to the RecipeBook chat tab only, not to a window.
	/rb skill <character> all : Show all known tradeskills for a certain character.  This outputs to the RecipeBook chat tab only, not to a window.
	/rb search <item> : Searches for items containing the given string.
	/rb searchmats <item> : Searches for items using materials which match the given string.
	
	Auction House Options (only available via /rb config)
		Color Recipes based on status: This will shade the icons for recipes you see in the Auction House based on whether other alts can learn them.
			Current color scheme is as follows (in order of precedence): 
			- Normal : Current alt can learn the recipe
			- Green : Another alt can currently learn the recipe
			- Orange : Current alt is the only character who will be able to learn the recipe (requires /rb self on)
			- Cyan : Some alt or alts will be able to learn the recipe (may include current character)
			- Red : No alt/alts will be able to learn the recipe, based on current data
			- Dark Red : All available alts already know the recipe
		Blackout Banked Recipes: This will shade the icons for recipes that you have banked black in the Auction House so that you can tell you already have a copy.

Known issues:
	* RecipeBook only updates its recipe list when your tradeskill window is open.  So, if BetsyRoss just learned Pattern: Giant American Flag, she'll have to open her Tailoring window before RecipeBook (or UncleScrooge) knows about it. 
	* Depending on what other mods you're running (I've noticed this with Auctioneer and Lootlink), the tooltip line may come in a variety of interesting places.  Most commonly, either at the very end of the tooltip or right underneath the default Blizzard info.  Wherever it decides to go, it's usually consistent within a particular frame - i.e. Auction tooltips will be in one place most of the time.  I wish I could fix this for you, but I'm still working on it.
	* Old versions of Averice's WIM will capture RecipeBook share data and parse it as a whisper.  Still works, just spammy. :)
	* Possibly broken: Many recipes in the German client that include umlauts or other "special characters" are not tracking correctly.  I need more data to fix the bug.
	
Housekeeping: 
	* Definitely up next: GUI output for /rb banklist. 
	* Hopes for next phase: Updating your recipe list when you learn items (in progress).  Colour-coding customization.
	
Compatibilities:
	The easiest way to add RecipeBook compatibility to *your* mod is to call the following in your tooltip output:
		RecipeBook_DoHookedFunction(tooltip, link);
		Where tooltip is the tooltip (or tooltip name) you're using and link is the item link itself.  That will add RecipeBook's data lines.
	RecipeBook is currently running without complaint on my machine with:
	* Auctioneer
	* CharactersViewer
	* LinkWrangler
	RecipeBook has been modified to add compatibility with the following bank/item mods:
	* AllInOneInventory
	* AuctionFilterPlus
	* BankItems (tested with Galmok's 1.10 modification at: http://www.ege.cc/files/BankItems-v11001.zip)
	* BankStatement
	* EngInventory/EngBank (tested with 20060320 version available at http://ui.worldofwar.net/ui.php?id=1425)
	* LinkWrangler (tested with instructions per author)
	* MyBags (tested with 0.4.0 beta 3)
	* MyInventory (tested with MI 1.9.1)
	* SortEnchant (tested with 2.11 or Silvanas' 2.0x, either.)
	
	
	
Special thanks to:
	Curse Gaming's Pentarion and Ghandi, for some hard work helping me debug the German client version.  Particularly to Pentarion for ongoing translation work.
	
	
Most Recent Changes (see Changelog.txt for old versions): 
	1.12.0 : TOC update for patch 1.12
		FIXED! Now compatible with ForgottenChat!
		FIXED! Now compatible with AuctionFilterPlus!
		FIXED! Gnomish Alarm-O-Bot; Festive Red Dress/Festival Dress; Festive Red Pant Suit/Festival Suit should all be parsing correctly.
		IMPROVED! Auction House and Merchant color coding.  
		FIXED! Auction House will now always color code correctly rather than simply stopping mid-frame (stupid for loops).
		FIXED! Excluding current character no longer overrides the standard Blizzard color for merchant/AH recipes the current character can learn.
		NEW! /rb send now sends your materials and current recipe difficulties, making your friends' data just as searchable and pretty as your alts'.
		BETA! RecipeBook *should* track your skillups and inform you when banked recipes become available.
		IMPROVED! Search now matches all words in a search phrase by default instead of the exact phrase (i.e. searching for "red shirt" will now find Red Linen Shirt, Red Swashbuckler's Shirt, etc).  If you liked it the other way, there's a checkbox on the search frame to change it.
	1.12.0a : FIXED! AuctionFilterPlus compatibility - should be not throwing errors now, I hope.
		FIXED! Line 859 error in merchants.
		IMPROVED! Now will show you an error instead of dying if a recipe is improperly parsed.  Please report these, if consistent.
		CHANGED! Auction House color-coding now uses the same schema regardless of whether or not "Show current character" is checked (i.e. recipes you can/cannot learn/already know are always colored as such).
		FIXED? Now should be avoiding disconnects at the price of much slower data transmission.  I'm working on it, folks.
	1.12.0b : FIXED?  Really, this time AF+ and Auctioneer/KCI should work with RecipeBook.  I hope.
		FIXED! If RestedBonus is installed, will definitely now leave /rb alone for RestedBonus, replacing it with /rbk.
		
		PLEASE NOTE: If you learn a new recipe, you will have to open your appropriate tradeskill window to update RecipeBook's database. Hopefully this will change soon.
		