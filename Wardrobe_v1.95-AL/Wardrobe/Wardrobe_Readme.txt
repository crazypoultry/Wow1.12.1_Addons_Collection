Wardrobe - An Equipment Management AddOn for World of Warcraft
Version 1.95-AL - 10/20/2006
----------------------------------------------------


DESCRIPTION
-----------
Wardrobe allows you define up to 20 distinct equipment profiles 
(called "outfits") and lets you switch among them on the fly.  
For example, you can define a Normal Outfit that consists of 
your regular equipment, an Around Town Outfit that consists of 
what you'd like to wear when inside a city or roleplaying, a 
Stamina Outfit that consists of all your best +stam gear, etc.  
You can then switch amongst these outfits using a simple slash chat 
command (/wardrobe wear Around Town Outfit), or using a small 
interactive button docked beneath your radar.

CHAT COMMANDS
-------------
/wd - help
/wd list - List your outfits
/wd wear <name> - wear <name> outfit
/wd reset - erase all outfits
/wd lock/unlock - For moving Button/Menu.
/wd click/mouseover - For method of displaying menu.
/wd scale [0.5-1.0] - For scaling the DropDown Menu.
/wd auto 1/0 - Toggle auto-swapping

OPTIONAL REQUIREMENTS
---------------------
Titan - A Bar and Menu framework for WoW mods.
http://ui.worldofwar.net/ui.php?id=1442http://www.wowinterface.com/downloads/fileinfo.php?id=4559

FuBar 2 - A Bar and Menu framework for WoW mods.
http://www.wowinterface.com/downloads/fileinfo.php?id=4571

Khaos (For GUI options) - A configuration framework for WoW mods (new gui).
http://www.cosmosui.org/

ColorCycle - A UI element color control tool for WoW mods.
http://www.wowinterface.com/downloads/info4792-ColorCycle-lix.html

MobileMinimapButtons - Shift-drag buttons around the minimap at a constant radius.
http://www.wowinterface.com/downloads/fileinfo.php?s=&id=4269


INSTALLATION 
------------
1. Unzip Wardrobe.zip into your WoW addon folder. 
   (World of Warcraft\Interface\Addons)
2. Answer YES to the prompt about replacing any duplicate files. 


CREDITS
-------
Wardrobe 1.4-AL and greater are written by AnduinLothar
Wardrobe 1.21-lix -> 1.3.1-lix was written by Miravlix
Wardrobe 1.21 and lower was written by Cragganmore


AUTHOR INFORMATON
-----------------
AnduinLothar - karlkfi@yahoo.com


DOWNLOAD LINK 
-------------
http://www.wowinterface.com/downloads/download.php?id=4471
http://www.curse-gaming.com/en/wow/addons-3040-1-wardrobeal.html


UPDATES
-------
Version 1.95-AL
o Updated FuBar plugin and libs

Version 1.94-AL
o Updated WearMe to fix bank error

Version 1.93-AL
o Fixed order of outfit dropdown menu

Version 1.92-AL
o Updated WearMe to v1.1.
- Should fix a problem with duplicate items not equipping correctly
- No longer breaks when encountering special bag types

Version 1.91-AL
o Added FuBar 2.0 support with similar functionality to Titan Panel support
o Restructured Titan plugin files
o Neither bar plugin code will execute if their respective dependancy is not loaded

Version 1.9-AL
o Now uses the WearMe Lib for item swaps (abstracted lib for equipment swapping)
o Upped Max Outfits to 30 (abstracted the button creation code, but limited now by WoW's max dropdown menu size)
o Fixed bug with menu not scrolling the first time you open it
o Fixed bug with Titan tooltip, text and dropdown not working
o Rewrote swap automation code:
- Undead zone swap now occurs when you dismount, zone in unmounted or swap outfit when in the plaguelands
- Wont swap immediately when mounted
- Swaps back to gear you had on before you mounted before swapping into undead outfit when dismounting after zoning
o Added slash command, binding and khaos option to temporarily toggle/dissable/enable auto-swapping (only stored across sessions if you have Khaos)
o Added an "Update" button and drop down menu to the character window for updating or creating outfits __without swapping to that outfit first__.
o Removed required Localization Lib usage
o Embedded WearMe, IsMounted and Chronos. If you have multiple copies the newest one will be in effect.
o Sky enhanced slash commands updated to use the Satellite lib instead

Version 1.87-AL
o Fixed bug that was causing Titan Button text to not show up. (Silly Titan doesn't take direct functions, only global function names)

Version 1.86-AL
o Titan text typo fix

Version 1.85-AL
o Fixed some frame errors due to the recent xml changes
o Updated embedded Localization to v0.07

Version 1.84-AL
o Added Naxx to the plaguezones
o Updated Outfit Swapping to correctly identify 1-way swaps between items in a similar inventory slot
o Enabled soft matching to find items in bags with a different enchant if an exact match is not found
	(these outfits will still show grey until you update them with the correctly enchanted items, 
	but it will swap the newly enchanted items regardless)
o Removed experimental tabularization of XML frames, fixes a bug with some tooltip hooking addons
o Made DragLock save accross sessions. (MustClickUIButton already saves)

Version 1.83-AL
o Fixed nil 'color' error
o Readded '<no outfit>'

Version 1.82-AL
o Fixed nil error
o Duplicate virtual outfits now delete themselves
o Virtual outfits no longer show up on the list

Version 1.81-AL
o Fixed Sea error

Version 1.8-AL
o Implemented Localization to allow for locale switching and assist future translation.
o Warlock summonable/equipable items are no longer remembered specific to id suffix.
o Removed outdated Cosmos support
o Added options to the Khaos config
o Rewrote the DropDown code to use the built-in DropDowns, reduced a lot of code.
o Updated Titan config to be more colorful
o Fixed Titan minimap button hiding
o Added option to rescale the global dropdown menu (0.5-1.0) ('/wardrobe scale #')
o Removed Titan small menu option (incompatible with DropDown format)
o DropDown no longer uses ColorCycle
o Made the help text easily localizable
o Added MyRolePlay support for outfit swap events


Version 1.71-AL
o Added option to move swapped offhand to the rear bag if swapping to a 2h, requires Chronos.

Version 1.7-AL
o Saved Variables now auto-clean extra unused item tables and old temp outfits
o Now correctly handles swapping of a 2h weapon on top of 2 1h items regardless 
  of offhand check
o Fixed OnLoad error when titan isn't installed
o Fixed a few unintentionally global variables
o Moved swap status variables into the saved vars so that mount swaps now 
  correctly occur on log in after logging off mounted.

Version 1.61-AL
o All files converted to unix standard LF line breaks for uniformity
  Also fixes a localization.de.lua loading error.

Version 1.6-AL
o Added German Localization: Thanks Gillion!
o Fixed duel slot swapping (offhand, 2nd trinket, 2nd ring) for all possible
  swaps that I could think of.

Version 1.5-AL
o Equipment saving now uses ItemID's (perm enchants, but not 
  temp enchants)
  Old outfits will still use names until editted.
o Fixed offhand swapping out with two-handers
o Fixed forced empty slots and outfit detection
o Fixed item swapping for two inventory items (rings, trinkets, 
  weapons)
 -Note: When equipping a bag item to an inventory slot currently 
  occupied by another item used in the same outfit,
  the item currently equipped will be bagged instead. 
 -The only solution I can think of is to scan the rings, trinkets, 
  and weapons again after a delay.
 -Of course, equipping the outfit a second time will equip any 
  skipped items, but is a little excessive.
o Added click/mouseover to the help print out
o Added optional Khaos enable/disable
o Added optional Sky slash command help
o Added optional Chronos dep to eliminate redundant aura and 
  equipment scans. More efficient, but optional.
o Mount/Plague/Chow special status is no longer removed when updating an outfit.
o Fixed Button Graphics

Version 1.43-AL
o Added click/mouseover to help printout.

Version 1.42-AL
o Added click/mouseover option for the menu. Default menu shows on
  mouseover of minimap button or titan button. Use "/wd click" to
  require click for menu.
	
Version 1.41-AL
o Equiping now uses AutoEquipCursorItem except for rings, trinkets
  and weapons which now use EquipCursorItem
o Minimap hiding option now correctly remembers if you are using
  Titan without the TitanWardrobe option and is stored per player
  in the Wardrobe_Config.

Version 1.4-AL
o Removed Sea dep
o Removed Chronos dep
o Added IsMounted dep for efficiency:
 -Fixes Aspect of the Cheetah and Aspect of the Pack incorrect
  mount detection,
 -Required for mount auto swap (Wardrobe will still work w/o it,
  you can still assign mount sets, but it wont swap)
o Removed tooltip scanning
o Added Delay to DropDownMenu hiding
o Minimap button uses MobileMinimapButton when availible
o Included Titan Support, thanks to Nemes for TitanWardrobe
o Converted code to more object oriented style. Most everything
  is within the Wardrobe table, even the XML frames

Version 1.3-lix
o Stopped using playerName as a global variable name.

Version 1.3-lix
o Fixed the bug that prevented equiping two identical items.

Version 1.21-lix
o Updated configuration to save based on realm and char name, so you can
  have chars with the same name on multiple realms.
o Removed some unessesary chat messages.
o Fixed Tigers Fury being detected as a mount.

Version 1.2:

o Increased the maximum number of outfits per character from 10
  to 20.
o Rewrote much of the outfit manipulation code to make it more
  efficient and to remove the slow-down that the previous
  version was causing.
o Added entirely new UI system for managing your outfits: allows
  you to easily reorder, rename, edit, delete, update, or change 
  the color of the outfit name.
o Outfits may now consist of intentionally blank item slots.
o Outfits can now consist of only certain item slots, ignoring
  those slots that you don't want to mess with.  For example,
  you could have an outfit that consists of only your "Carrot
  on a Stick" trinket.  Equipping this outfit wouldn't interfere
  with anything worn in any other item slot except that one
  trinket slot.
o You may now specify outfits to auto-equip and un-equip on certain
  conditions: whenever you mount (useful for automatically wearing
  the "Carrot on a Stick" and Mithril Spurs), whenever you enter 
  the Plaguelands (so you don't forget to equip the Argent Dawn
  Commission), and whenever you're eating/drinking (useful if you
  have certain items that affect regeneration or spirit).
o Added keybindings for all 20 outfits.

TO DO LIST
----------
o More Automatic equiping triggers, entering a zone, being PvP 
  flagged, not being PvP flagged and stance/form triggers.
o Supporting StanceSet/WeaponSwitch or building the feature into
  Wardrobe.
o Add support for weapons with two forms.
