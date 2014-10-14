Name: Quanjure
Version: 2.5
Author: Quantuvis


Decscription:
=============
Utility addon created for my mage Quantuvis.
Simplifies some of the tasks I find myself doing constantly.
- Adds a configurable function for swapping to spirit weapons while channeling Evocation, being innervated, drinking, and more.
- Adds a bind that conjures Gems, Food and Water at the push of a button.
- Intelligently conjures food and/or water for a targeted friendly player.
- Adds a bind that lets you eat, drink and trade water at the push of a button.
- Autobuys Arcane Powder, Rune of Portals, Rune of Teleportation from reagent vendors.
- Minimap button with drop-down for teleporting, portaling, trinket traveling, hearthstoning and evocation setup.


Setup:
======
For the setup dialog click the mini map button and click Setup or type:
/quansetup

For the different functionalities, bind keys under Key Bindings, or use any of the following slash commands:
/quanjure
/quansume
/quanevoc

To see how much of a water bot you really are, type:
/quantotals
To broadcast to raid or party (or say, if not in party):
/quantotals spam
To reset the counter:
/quantotals reset

Usage Notes:
============
Most of Quanjure's features are rather self-explanitory, but the conjuring and consuming functionalities have several uses, as described below.


Pressing the Quanjure bind when no friendly player is targeted will do the following (drinking when necessary):
1: Conjure a bit of water (might come in handy while conjuring)
2: Conjure specified number of mana gems
3: Conjure up to one stack of food
4: Conjure water
5: Conjure water
6: Conju... well you get the point.

Pressing the Quansume bind when no friendly player is targeted will eat or drink your conjured items if your health or mana is below 100%.


Pressing the Quanjure bind when a friendly player is targeted will conjure food and water appropriate for that player's level and class.
Pressing the Quanjure bind when trading a player will conjure food and water appropriate for that player's level and class.
Healing classes will only trigger water conjuring, melee classes will trigger food conjuring, and ranged classes will trigger both water and food conjuring. 
When a ranged class is targetted or trading, Quanjure will conjure what the user currently has least of: water or food. (With this mechanic in mind, targetting yourself can be used to conjure food beyond the first stack.)

Pressing the Quansume bind when a friendly player is targeted or trading will trade the appropriate conjured items to the player. First keypress initiates the trade, subsequent keypresses trade the items.



Known issues:
=============
- There is currently no way for authors to disable FuBar's "Attach to minimap" feature, but I advise users not to use it.
- If you are having problems with the drop down menu showing off screen, you can try /quandropdownfix
- If you spam the button, you can accidentally conjure an extra stack of food, or do a failed attempt at conjuring a mana gem. This is due to latency, since it may take a while from you're done conjuring, until the item appears in your inventory. 

 
Upcoming additions or changes:
==============================
Urgent:
- Update the German localization with translations of the newest features.

Horizon:
- Possible code re-write. At the very least a clean up.
- Smart conjuring when suffering from inventory lag (e.g. never try conjuring two Mana Rubies in a row).

- Feel free to PM me suggestions at quantuvis@represent.dk



Version History:
================
2.5 (June 22nd, 2006)
 Updated to patch 1.11
 Added support for Conjured Cinnamon Rolls. 
 Fixed a bug with portaling in QuanjureFu, that caused error messages if a portal cooldown ended while logged out or zoning.

2.41 (May 25th, 2006)
 Added Quansume for non-mages. Searches your inventory for conjured mage items and eats/drinks the highest ranks.
 Changed minimap button click responses: Left-click to Quanjure, Right-click for menu, shift-Right-click to drag.
 Fixed a bug where Quanjure would attempt trading with yourself.
 Fixed a bug where the Fubar Plugin would show the global cooldown as portal timer.
 
2.4 (May 19th, 2006)
 Added FuBar support. I hope.
 Other very minor tweaks.

2.33 (April 25th, 2006)
 Added "/quantotals spam".
 Re-Added automatically standing up when Quanjuring, by hooking into /stand!
 Fixed Portals in the french localization. There is an inconsistency in the naming of Portal spells in the french client. 
 Very slight clean up of some of the code.
   
2.32 (April 14th, 2006)
 Added /quantotals which displays the all-time amount of conjured water and food. Suggested by Serelith.
 Removed some debugging spam that was left in by mistake.
 
2.31 (April 14th, 2006)
 Added options for turning off target and trade dependant conjuring.
 Fixed French Téléportation spells not being detected - thanks obockstal!
 Fixed a glitch where tooltips could potentially show off-screen.
 Fixed a bug where double right-clicking a reagent vendor would buy reagents twice.

2.3 (April 10th, 2006)
 Added option for Spirit weapons while Darkmoon Card: Blue Dragon is procced.
 Added option for Spirit weapons while drinking. Configurable for independent zones.
 Changed the Setup dialog, making it a little cleaner.
 Fixed some more issues with the French localization - thanks obockstal!
 Fixed a typo in the TitanPanel plugin that may have rendered the Left-side button useless. I promise. Honest.

2.21 (April 8th, 2006)
 Change: Made the Target dependant conjuring conjure for the trade target when a trade window is open.

2.2 (April 8th, 2006)
 Added Target dependant conjuring - Quanjure will now conjure food and/or water appropriate for the targeted friendly player.
 Added Target dependant trading - Quanjure will now trade appropriate food and/or water to the targeted friendly player when using the Quansume bind.
 Changed the Setup dialog to allow a setting of 0 for Gems, Powders and Runes.
 Fixed a typo in the TitanPanel plugin that rendered the Right-side Icon useless.
 Fixed some cosmetic issues caused by the length of the German strings - thanks Gixx!
 Fixed some issues with the French localization - thanks obockstal!
 NOTE: You will probably have to rebind your Quansume bind.

2.1 (April 1st, 2006)
 Added a fix for people with the drop down menu showing off screen - /quandropdownfix
 Fixed a few escape strings in the German version.
 TitanPanel plugin included.

2.0 (April 1st, 2006)
 Stand-alone version. Didn't really feel it was fair to force people to use Titan anymore. I will release plugins For the Titan and BossPanel fans as soon as possible.
 The portal timers will be added to the respective BossPanel and TitanPanel plugins.

1.32 (March 30th, 2006)
 Fixed oversight of new event. (SPELLCAST_CHANNEL_STOP)

1.31 (March 30th, 2006)
 Updated to patch 1.10.
 Due to the banning of movement initiation by Addons, Quanjure will no longer be able to automatically stand up when conjuring.
 Added most of the French Localization - thanks to Asthar for translating. I am still in need of feedback on the french version.

1.3 (February 22nd, 2006)
 Added configuration for number of mana gems to conjure. 
 Added configuration for number of stacks of reagents to purchase automatically.
 Added option to use spirit weapons while being innervated.
 Added automatic dismounting when trying to cast a portal while mounted.
 Changed/Added new function to quansume - if a trade window is open it will place stacks of water in it, instead of consuming.
 Changed default evocation style to One-click.
 Fixed a bug that prevented mages, that had not yet learnt to conjure mana gems, from conjuring more than one stack of water.
 Fixed a localization bug with portals.
 Fixed a few issues with the french localization, but I expect more.

1.2 (February 19th, 2006)
 Added Localization - I'm looking for a french translator!
 Added Engineering/PvP trinkets, Astral Recall and Teleport: Moonglade to the available transports.
 Added option for displaying as an icon on the right side of Titan Panel.
 Added portal timer - when you have "Show label text" enabled, Quanjure will display the time remaining before your portals disappear. (Suggested by Serelith)
 Added output of gold spent by AutoReagents.
 Changed quansume bind - no longer uses gems in combat (too many accidental rubies consumed when in a hurry to drink).
 
1.0 (February 7th, 2006)
 First released version.
 Added support for mages of all levels.

0.6 (January 29th, 2006)
 Added experimental one-click evocation.
 Changed Quanjure to conjure some water before ruby and food.
 Fixed "Item is not ready yet." spam (still shows up at certain occasions - the cost of minimizing the turning around bug).

0.51 (January 26th, 2006)
 Added a warning if you cast Teleport while in a party, or Portal while alone.
 Fixed a bug with evocation where it would keep your spirit gear equipped.
 
0.5 (January 21st, 2006)
 Added Evocation (includes graphical configuration)

0.4 (January 17th, 2006)
 Added dependency: Titan Panel
 Titan Panel plugin for portals, teleporting, hearthstoning and conjuring.

0.3 (January 9th, 2006)
 Updated to patch 1.9
 Added auto buying reagents

0.2 (December 9th, 2005)
 Added consume bind

0.1 (December 8th, 2005)
 Initial release