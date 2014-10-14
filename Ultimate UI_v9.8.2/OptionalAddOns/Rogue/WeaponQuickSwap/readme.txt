WeaponQuickSwap - v24

===========
Quick Start
===========
Unzip the contents of the zip archive into your WoW game directory. 
Make sure you "Use folder names" so the files end up in the right
place.  You should end up with:
  <wowdir>\Interface\AddOns\WeaponQuickSwap\readme.txt
  <wowdir>\Interface\AddOns\WeaponQuickSwap\WeaponQuickSwap.toc
  <wowdir>\Interface\AddOns\WeaponQuickSwap\WeaponQuickSwap.xml
  <wowdir>\Interface\AddOns\WeaponQuickSwap\WeaponQuickSwap.lua

Now log into your character and go to the Main Menu in-game.  Select
macros and add a New macro.  Give it a name and an icon and make the
macro text:
/script WeaponSwap("main1", "off1", "main2", "off2", ...);

Parameters are CASE-SENSITIVE:
main1 - What weapon you want in your main hand for set 1.
off1 - What weapon you want in your off hand for set 1.

The following 2 parameters are optional:
main2 - What weapon you want in your main hand for set 2.
off2 - What weapon you want in your off hand for set 2.
(more sets can be specified if desired)

Mages wishing to wield a 2h in their main and a wand in the ranged slot
should use MageWeaponSwap() instead of WeaponSwap().
  
===========
Description
===========
This Add-on adds two functions to the scripting namespace called:
  WeaponSwap(...);
  MageWeaponSwap(...);

The arguments are pairs of weapons to be held in the main hand and off
hand respectively.  For example, if you want to put a "Sword of the
Black Knight" in your main, and a "Johnsonville Brat" in the off-hand,
that is:
  /script WeaponSwap("Sword of the Black Knight",
  	"Johnsonville Brat");

But you're thinking.  "Bry, I could already do that pretty easily." 
The fun is that you can specify a second set of equipment to be swapped
in if the first is already in place.  This macro would switch between
just holding a "Sharpened Letter Opener" in the main hand (nothing
off-hand) and two "Mace of Ultimate Whompitude" in each hand.
	/script WeaponSwap("Sharpened Letter Opener", "",
  	"Mace of Ultimate Whompitude", "Mace of Ultimate Whompitude");

If you do not wish to change whatever is in that a slot, a wildcard 
character "*" can be used.
	/script WeaponSwap("Sword", "Dagger1", "Dagger2", "*");
Leaves Dagger1 in offhand when switching to set 2.  Note that you can
get yourself in trouble if you use too many wildcards:
	/script WeaponSwap("*", "Dagger1", "Sword", "*");
That probsbly won't do anything once the Sword is in the main and the
dagger is in the offhand.  Think your wildcard usage through.

Note:  As as design decision, the names are CASE SENSITIVE. 
"Misspelled Swoard" and "misspelled swoard" are not the same.  Type it
exactly as it appears in your inventory.  I did it this way to avoid
lowercasing a bunch of immutable strings every time you want to switch.

Interesting facts about this script:
-- Slot lock events are used to detect when it is safe to move a
weapon. Prevents hang ups found in other scripts and Add-ons.
-- Uses LinkText to detect item names rather that creating a
GameToolTip descendant.  More efficient?  Hells yeah.

If you get an error using this, make sure you report it with your macro
line *as well as* the position of where the items where before you ran
the macro.

More examples
---- --------
Just a 2h:
/script WeaponSwap("2h");

2h to 1h/shield:
/script WeaponSwap("2h", "", "1h", "shield");

To swap dual wield hands:
/script WeaponSwap("Hammer", "Dagger", "Dagger", "Hammer");

2h to DW:
/script WeaponSwap("2h", "", "Weap1", "Weap2");

DW to Backstab/Ambush
/script WeaponSwap("Weap1", "Weap2", "Dagger", "fish");

Switch between 3 sets of weapons (ss/dw/2h):
/script WeaponSwap("shortsword", "shield", "shortsword", "knife", "2h Hammer");

Staff and Wand to Staff and another Wand:
/script MageWeaponSwap("Smackem Staff", "Wand of the Fleeting",
	"Smackem Staff", "Tinkerbell's Fairy Wand");

Drunk to Billigerent:
/script WeaponSwap("Tankard of Ale", "Tankard of Ale",
	"Mace of Antioch", "Sword of Barroom Brawl"); 

===
FAQ
===
Q1. How do I make a macro to switch to a dagger in my main hand,
backstab, then put my weapons back?
A. Short Answer: you cannot.
   Long Answer: Switching weapons is not what we call a "synchronous"
   event.  When you say WeaponSwap() it *requests* that the weapons
   swap and returns to your macro.  The actual weapons get in your
   hands at some point P in the future.
   Can such a macro be written?  Quite easily.  Why don't I write it?
   (sarcasm) Let me get right on that, and while I'm at it, why don't I
	 make it find a mob and attack it for you, autoloot it, then head
	 back to town and cyber your girlfriend too?

** CapnBry <bmayland@capnbry.net> **

Version History:
24 - Interface version 1300.
23 - No longer will try to put something in any "Shot Pouch".  Thanks to Eric Vega  
     for bringing it to my attention.
22 - Interface version 4216.
21 - Interface version 4222.
20 - Interface version 4211.
19 - Added support for "*" which indicates to leave whatever is in that hand there
18 - Changes to support A,"" -> "",B where A is a 2h.
   - When switching A,B -> C,"" will always try to put B in the place it took 
   	 it out of.
17 - Changes to better support StanceSets addon.
16 - Fix for people with "bad argument #1 to 'find'(string expected got nil)."
15 - Can now pass just one item to WeaponSwap (assumed main hand).
     Can specify as many sets as you want
14 - Interface version 4150
13 - Should no longer try to stuff weapons in a quiver / ammo pouch
12 - Fix for A,B -> C,A where B is offhand only
11 - Now searches only hand inventory and starts from the back of bags
     working toward bag 0.  0.00001s speed increase.
10 - Added MageWeaponSwap(...)
9 - Renamed to WeaponSwap(...)
8 - Support for switching X,Y <-> Y,Z
7 - Now fills bags from the rear, for more predictable storage
    placement.
6 - Fix for people switching X,Y -> Y,Y
5 - Support for filling hands with 2 of the same named weapon
4 - Fix for people switching 2h -> Dual Wield
3 - Order of operations ambiguity on finding empty bag slot resolved.
2 - Weapons coming out of slots will now also go to bags, not just the
		backpack.
  - Prints a message if there isn't enough free bagspace to complete
    the swap.
  - Disabled unused event hooks.
  - Removed /rl slash command for reloading ui.
1 - Initial release
