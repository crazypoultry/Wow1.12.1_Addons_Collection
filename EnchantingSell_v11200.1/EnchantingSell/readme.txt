**********************************************************************
v11200.1
* Updated toc version for patch 1.12
* German localization updates. (Thanks to LordRod)
* added some chat display messages when the enchant fails to be performed.  I believe this is related to the addon SortEnchant, which hooks into the Crafting API's.
	--this message will appear when you select an enchant, and click the 'enchant it' button. For some reason the selected enchant changes.
	"There was a problem performing this enchant. Please reselect the enchant you would like to perform and try again."

	--This message will appear when you try to perform an enchant that you do not know.
	"You cannot perform this action while viewing another characters enchants."
	
	--this message appears when you try to perform an enchant, but you are not an enchanter.
	"You cannot perform this action.  This character is not an enchanter."


**********************************************************************
v11000.1
* just updated the interface number for patch 1.10

v11000.2
* updated player entering/leaving world events.  conform to posted topic about reducing loading times.

v11000.3
* updated to support the latest version of KC_Items.  which is now version .94.3

v11000.4
* updated the enchant details frame so it now scrolls.  It will display up to 8 reagents now.
* chinese translation now included (translation provided by LeiLo)

v11000.5
* RECOMMENDATION: delete EnchantingSell addon folder if you have one existing prior to installing this one.
* the frame can now be moved after being opened.  There are some limitations however since it still extends UIParent. (Thanks to EnchantingDB addon for figuring this out)
	It will not remember the position when it's re-opened.
	It still acts as a default UI frame, so other frames will position to the right and not left of screen.
	It still closes when you open too many default UI frames.
* changed scroll on the enchant detail.  the description no longer scrolls, only the reagents do now.
* fixed the "price before percentage" label, it will appear horizontal on bottom of frame now.
* code cleanup.  created new frame xml for manual price entry frames and code.
* create Util lua file to capture global or commonly shared functions.

v11000.6
* Fixed known issues with SortEnchant compatibility.  From what I can tell, this work properly now.  SortEnchant is currently experiencing a code re-work, and also has a bug displaying the drop down lists. That is not an ES problem
* The "Enchant It" button will now enable/disable when materials have changed in your bag. This means you do not have to reselect the enchant after a trade, after moving items from bank, or when converting certain essences from 3->1 or 1->3

**********************************************************************

v1.35
Bug Fix:
* Fixed a random problem with the armor/weapon dropdown, where color selection would appear.

v1.36
New Features:
* Incorporated auctioneer patch made by Kasander (great patch).  Modified slightly so that it first checks that auctioneer is loaded(optional dependency)
* Added option to use/not use auctioneer, even if it is loaded.  Since auctioneer has a slight delay in gathering viable information, you may not want to use it until median prices have been established.

v1.37
New Features:
* Now contains an option to turn debug on.  You will get alot of log messages in your chat window, you can ignore them.  This will help me troubleshoot problems.  Just open EnchantingSeller frame, click the options tab, and check/uncheck the debug box.

v1.38
New Features:
* KC_Items support (read Dependencies notes)
* support for beta auctioneer 3.1

v1.39
New Features:
* only launch ES for those toons who have the enchanting profession
* removed ES tooltips, there are better addon's for that info
* updated some of the localization
* minimap button can now be disabled in ES options
* you can launch ES by typing /es

Bug Fix:
* config options reseting to default values is now fixed.
* added lots of debug to the ESell_Enchante_UpdateData function.  This is in hopes to help solve the german client weapon category issue.

v1.40
Patch 1.8 compatible:
* updated interface to 1800
* make new blizzard addon's a dependcy

Bug Fix:
* myAddOn registration fix

v1.40.1
Bug Fix:
* the default configuration for first time users was fixed. It broke in version 1.40.  If 1.40 was the first version you used, you will need to delete your saved variables for ES prior to launching WoW.
located under '\World of Warcraft\WTF\Account\<account>\SavedVariables\EnchantingSell.lua'
* the same bug fix also corrects the '(a nil value)' errors.

v1.40.2
localization:
* german updates 

dependency updates:
* KC_Items updated to .93 Beta1a.  This is now the minimum required version.

v1.40.3
Bug Fix:
* hopefully fixed conflict with drop downs. 


v1.41
Patch 1.9 compatible:
* updated interface to 10900

Enchancement:
* Shift-clicking the enchancement in the list frame, will add a link in the chat window, that is now clickable
* Shift-clicking the icon in the enchancement detail frame, will add a link in the chat window, that is now clickable
* Shift-clicking the text in the enchancement detail frame, will add a link in the chat window, that is now clickable.  It will also append the description in the chat window, incase people don't realize to click the link.
* Now non-enchanting toons can use to see your chanters(feature added back)

v1.42
Updates:
* Added new Oil enchants
* Added new enchant categories for Wand, Rod and Oil so they can be filtered.

v1.43
updates:
* localization file split into seperate files for eenglish, french and german.
* added translation for french and german for new enchants formulas

enchancements:
* added support for WoWEcon mod.  However this has not been tested or confirmed.

Bug Fix:
* mouse over on icon in enchant detail frame no longer produces hyperlink error.  the game tool tip should be displayed properly.


v1.44
updates:
* no works with latest versions of auctioneer (not recommended to use anything other than release versions)

bug fixes:
* fixed localization problem

v1.45
enchancements:
* tooltips are back!  anytime you hover over an enchanting material(soul dust, maple seeds, vials etc..), the tooltip will shows you 4 things.
 1.  how many on you
 2.  how many in bank
 3.  how many on other toons
 4.  the price for 1 of those.
This feature can be disabled/enabled in ES options frame.

v1.45.1
enchancements:
* added new per character saved variable. EnchantingSell_PlayerConfig.  this allows for saving configuration on a per player basis.  
* per player configuration. (ie..minimap, use auction database, use tooltips, sorting)
* moved runtime variables out of saved variables. shluld reduce saved memory a tad.
* removed the enchanter check against the minimap icon.  the user has full control to show/hide the minimap icon in the options.

changes
* added param arg check for myaddon.  should prevent myaddon code from executing everytime an addon is loaded.
* when the use auction database option is disabled, the enchantment and components are now re-initialized. This should help with the prices being updated immediately.
* added some logic checks to prvent nil errors


v10901.1
enchancements:

changes
* updated version number style, to conform to new standard way.
* updated german translation (thanks to LordRod for providing)
* activated the pricing database reset upon clicking the "use auction database" option.


v11100.1
* Updated toc version for patch 1.11
* added +15 FR cloak 
* fixed gloves +agility

