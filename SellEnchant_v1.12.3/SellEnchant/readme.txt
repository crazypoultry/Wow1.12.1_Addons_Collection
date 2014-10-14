Name
====
SellEnchant v1.12



Overview
======
Assists in the selling of enchants, tracking of reagents, and learning skill levels.



Important
=========
Support for German and French has temporarly been disabled. It will return, I just need someone to help me with getting the localization.lua files interpreted. Anyone that feels like converting the localization.lua file into another language is more then welcome to and send it to me. I'll implement and release it and give you a nod in the program. =)

Before updating to version 1.12.0, I highly recommend you delete your SellEnchant.lua file the directory "..\World of Warcraft\WTF\Account\XXXXXX\SavedVariables\" (where XXXXXX is your account user name).

If you can't find the file to delete it, click the "Delete All Databases" button on the "Options" page before running using sell Enchant.  You can load the default regeant and enchant databases after you delete all databases if you want.

If you don't want to go though all the trouble of updating your reagent prices again, SellEnchant will continue to work with your old saved data, but will take up a little bit of extra hard disk space and memory when running WoW (like 5kb or so) and some of the newer features will not function.

This will be the last change to my data format, I promise (unless Blizzard does something that breaks it).



Support
=======
http://ui.worldofwar.net/ui.php?id=1478
madica@yahoo.com (good luck getting in through all the spam though)
server: Shadowsong name: Kwinic



Installation
============
Extract to the folder: ../World of Warcraft/Interface/Addons/



Description
===========
Gotta keep this brief, cause people don't tend to read this part. =)

This is a continuation of RedLeon's work "EnchantingSell". Many parts are inspired and taken from Shamino's "EnchantingSeller" continuation.

If you find a bug, and don't report it, it won't get fixed. Blanket statements like "This mod will not run" does not provide me with any useful information. I need information on the error to fix it. The more information provided, the faster I can fix it. With bug reports please try to include: what language you are using (English, French, German), names and versions of any other mods you are running, description of exactly what you were doing when the error happened, and (probably the most important) the exact error that you get.

This mod tracks the prices of reagents, calculates the prices of enchants, tracks what reagents you have and the enchants you can do with them, creates an advertisement for you to use, and learns.

With the price tracking feature you can either manually enter the price of the regeants or use one of the supported auction house programs (Auctioneer, KC_Items). For a quick scan of just reagent prices, only scan the "Trade Goods" catagory.

It can then take the prices of those reagents and calculate what you should charge for that enchant, factoring in a markup percentage (percent profit you wish to make) that you can set. You can tell it to round the prices up to the nearest gold, silver, or copper. And if your not satisfied with calculated price, you can override it with a price of your own.

SellEnchant also tracks what reagents you have. Not only does it keep track of what you have in your bags and in the bank, it also tracks what items you have on other characters. So you know at a glance exactly what enchants you can do.

The enchanting skill in WoW creates no physical item that you can sell in the auction house (except for wands, which nobody wants). SellEnchant was designed to aid you a little bit in the selling of these enchants. You can create a line of text with it with mouse shift-clicks. If you wish you can list just the enchants you want to sell. You can have it include the price. You can even have it create a list of the reagents needed for the enchant.

SellEnchant learns your enchants too. It doesn't rely on a pre-created database of enchants and enchant formulas. As you learn enchants, it learns them too. This basically means if Blizzard introduces a new enchant, or someone finds an enchant that no one else has ever found... it will add that enchant, it's formula, and the required reagents to its database. It'll also calculate the price for the new enchant (obviously).

Default prices for reagents are taken from a mature server. The prices were current at one time, but as supplies become more abundant, prices go down. Almost every server has different prices for different things. Default prices are for reference purposes and I highly recommend that you set your own prices according to the price of regeants on the server that you play on.

All feed back is welcomed, encouraged, and appreciated.



Command Line Interface
======================
/se or /sellenchant
  "?"                brings up function list
  "help"             brings up function list
  "button"           toggles minimap button
  "CreateDefaultDB"  makes a new default database... not really end user stuff
  <blank>            toggles SellEnchant
  <anything else>    tells you to use "/sellenchant help" for more information



CLI CreateDefaultDB information
===============================
This command creates a new default database file (but doesn't erase your custom data). You should only really send your file to me if I've asked for it. If you feel you've got a more complete database then the current default one for your language, please send me this file.

Now the file it saves is called SellEnchant.lua but so is the primary file of SellEnchant. I do NOT want a copy of the program SellEnchant.lua... I've already got one. What I want is the SellEnchant.lua file that is located in the the directory "..\World of Warcraft\WTF\Account\XXXXXX\SavedVariables\" (where XXXXXX is your account user name). There is nothing in this file that gives me any information about your account. It will, however, reveal what enchants you know, what regeants you have, what your enchanters characters names are, and what server you play on. I will not use any of that information to bother you... I just want the enchant data. Once I get that, I will delete the file you sent me. You can browse through the file in any program that can read a text file first if you'd like, before you send it to me.

Please mail the file to madica@yahoo.com



Supported Optional Addons
=========================
MyAddons 2.5
Auctioneer 3.2.0.0690



Unsupported Optional Addons
===========================
KC_Items 0.93 Beta 1a
AuctionMatrix 6.0
WoWEcon 1.24



Features to be added
====================
  * Create option to make from lockable
  * Better link for Oils and Wands
  * Create a "Load one time" AH prices button
  * Make load on-demand pretty, conflicts with Auctioneer
  * Allow user to choose AH scanner
  * Fix reagent list on other characters scroll box
  * Add the other catagories to SortEnchant style listing
  * List enchants that will do skill ups - drop down menu
  * Check box of items to advertise
  * One click advertise button
  * New layout frame to format advertisements
  * Customizable listing style to include grouping
  * Advertising text save window
  * Sort unknown enchant list - drop down menu
  * Customize publish format +, (, [, go, g, G, etc.
  * Make Tip windows optional
  * Deal with Wizard Oil description better



Bugs to be Squashed
===================
  * Updating reagent prices is buggy
  * Double clicking on reagent no longer takes you to regeant
  * Can not close SellEnchant when bank window is open
  * Moving bag with rod in it does not register update correctly
  * Alternate reagents not calculated into enchants
  * Available number of enchants is not correct (bank & alt reagents not factored)
  * Have to toggle SellEnchant off/on to update enchant price (that's why it closes)
  * Enchant button does not come up when items are given to you while on Enchant frame
  * Enchant button does not refresh if proper reagents are moved to bags from bank.
  * Does not properly update reagents while on reagents page (reopen works).
  * Enchant frame double click of reagent forces a reagent sort
        Artifact of a work around to fix double click not taking to correct reagent
  * SellEnchant windows closes on enchant and opening windows due to shared artwork
  * .. is shown for prices with no value



Limitations
===========
  * Unable to show prices above 999g 99s 99c
  * Blizzard only allows 3 or 4 links in one line
  * Blizzard_CraftUI dependencies
  * Blizzard artwork dependencies
  * Does not remember posistion SellEnchant window is moved to
  * Opening SellEnchant still closes some windows (like all Blizzard craft frames)



Revision History
================
  v 1.12.3
  --------
  Fixed the regeant links from the enchant frame
  Movable frame can be toggled on and off

  v 1.12.2
  --------
  Turned off some debug messages I left on

  v 1.12.1
  --------
  Updated Auctioneer support (Shamino's fix)

  v 1.12.0
  --------
  Changed the way some data is stored (Read the section labeled "Important")
  Polished SortEnchant like ability
  SellEnchant no longer updates itself while your fighting
  Updates are only done on trades, at the bank, and after looting
  The Enchant button now updates when SE is open (see note in bugs about rods in bags)
  SellEnchant Window is now moveable (see notes in limitations)
  Revision number now reflects Blizzards UI version
  Updated player entering/leaving world events (Shamino's fix)
  Updated KC_Items support (Shamino's fix)
  Cleaned up some Tip Windows

  v 0.11
  ------
  Added limited SortEnchant like ability

  v 0.10
  ------
  Double clicking on reagent in Enchant frame now works
  Round off to nearest silver works now
  Updated wand stats
  Fixed localizations


  v 0.9
  -----
  Added WoWEcon support
  Added Auctioner 3.2.0.0671 - 3.2.0.0690 support
  Elimated some logic from trying to use nil values
  Cleared up what the load buttons do a little bit
  Reworked how AH prices were loaded. Should be more efficient
  Optimized Reagent pricing code. Should try to update prices 25% less
  Fixed error where AH prices would not erase if reagent selected
  Major variable renaming
  Turned "Show Available Enchants First" on by default
  Turning on Auction House price now closes SellEnchant to force a reload
  Fixed an error that happened when switching characters on different servers
  Fixed sort on enchant frame
  Reformatted Deutsch and Français locatalization (hopefully fixed a few bugs)
  Updated Deutsch enchant and reagent default databases
  Updated English enchant and reagent default databases


  v 0.8
  -----
  Added support for ModWatcher
  Minimap button enable/disable state is now saved for individual characters.
  Minimap button should no longer give an error on new characters.
  Fixed scroll frame graphics on reagent page
  Fixed a couple of coding errors
  Fixed nil errors in debug code
  Fixed error on mouse over of icon
  Fixed CraftFrame:OnThis nil error (had to add Blizzard_CraftUI dependency)
  

  v 0.7
  -----
  Added minimap button higlight
  Moved default minimap button location, again (290 is bg queue)
  Added Debug toggle
  Updated WoW interface version to 1900.
  Removed temporary fix for greater agility enchant for gloves (Blizzard fixed their typo).
  Changed "needed reagents" color so it doesn't match "have reagents" color.
  Enchanting sorts by "Other" now works correctly.

  v 0.6
  -----
  Can now list 6 reagent items on main page.
  Enchant list only shows 9 now instead of 10 (to make room for reagents).
  Some Deutsch localization fixes.

  v 0.5
  -----
  Disable MiniMap option added.
  Checks for AuctionHouse price scanner when you enable "use auction house prices".
    (No real event handlers added yet, though)
  More cosmetic code conversion.
  Added CLI
    "?" or "help" - brings up function list
    "button" - toggles minimap button
    "CreateDefaultDB" - makes a new default database... not really end user stuff
    <blank> - toggles SellEnchant on/off
    <anything else> - tells you to use "/sellenchant help" for more information

  v 0.4
  -----
  Reageant and markup percentage text edit box now work properly..
  Some cosmetic code conversion.
  Added some better labels.
  Support added for KC_Items and AuctionMatrix.

  v 0.3
  -----
  Settings should now be saved.
  Should no longer get the 'scrollChildFrame' & 'scrollBar' (a nil value) error.

  v 0.2
  -----
  Further translation.
  Fixed nil variable errors for clean installs.

  v 0.1 
  -----
  Better English translation.
  Updated WoW interface version to 1800.
  Fixed silver pricing bug where silver wouldn't be labeled.
  Fixed 100+ gold display bug.
  Removed Type column.
  Added Auctioneer reagent pricing.


Special Thanks to (alpha sorted)
================================
  The sites the host my Mod:

  Curse Gaming
  ------------
  Kasander - For his original work on getting Auctioneer prices
  RedLeon - For the original work on EnchantingSell
  Shimano - For his work on EnchantingSeller and his updates

  World of War.net
  ----------------
  Athanasius - The indredible amount of bug reporting and the debugging:
               EnchantingSell_ListEnchante -> SellEnchant_ListEnchant
               EnchantingSell_ListComponant -> SellEnchant_ListComponent
               EnchantingSell_Config -> SellEnchant_Config
  ElvenWitch - Encouraging me to take this mod over
  Shoto - Helping me find them pesky bugs
  Ugurtan - The information on misnamed enchants and the Enchant button error.
  Wilz - Trying to help me debug the software
  Halandriel - Deutsch translation

  WoW Guru
  --------
  Konk - Reporting bugs that I haven't fixed yet
  Halandriel - Working on the German translation

  WoW Interface
  -------------
  Dustoff - The extensive bug reporting
  Janin - The very informative bug information