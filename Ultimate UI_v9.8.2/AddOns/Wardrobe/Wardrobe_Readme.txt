Wardrobe - An Equipment Management AddOn for World of Warcraft
--------------------------------------------------------------

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

Optional:
     Cosmos     - A framework for WoW mods.
                    (http://www.cosmosui.org/cosmos)
     ColorCycle - A UI element color control tool for WoW mods.

INSTALLATION 
------------
1. Unzip Wardrobe.zip into your WoW addon folder. 
   (World of Warcraft\Interface\Addons)
2. Answer YES to the prompt about replacing any duplicate files. 

CREDITS
-------
Wardrobe 1.21-lix -> 1.3.1-lix was written by Miravlix
Wardrobe 1.21 and lower was written by Cragganmore

AUTHOR INFORMATON
-----------------
Nemes Of Uldum

UPDATES
-------
Version 1.40-10900
o Remove Sea and Chronos
o Remove plaguelands / mounted / chowing outfits
o Some code cleanup following above
o Remove money tooltip protection... doesn't appear to be needed any more
o 1.9 fixes: change <tooltip>TextLeft<i>:IsVisible() with <tooltip>TextLeft<i>:IsShown()
o TODO: further cleanups, as this version was very rushed

Version 1.3.1-lix
o Stopped using playerName as a public variable name.
o Made sea a required dependency, since it is.

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
