Lookout v2.96


Description
===========

Lookout is a World of Warcraft AddOn. 
It watches for events that can be very important, and pops up an alert.
Optionally, there can be an action associated with each event.

Uses the BorisBlackBloxx font by Manfred Klein.
http://moorstation.org/typoasis/designers/klein/

Install
=======
Extract the files into your World of Warcraft Interfaces/AddOns directory.


Features
========


* Compatibility with World of Warcraft v1.12

* Currently watches for:
  - The boss Mandokir in Zul'Gurub
  - Baron Geddon in Molten Core
  - The Eye of Naxxramas in Stratholm
  - The Eye of Kilrogg in Dire Maul
  - Blackhand Summoner in Blackrock Spire
  - Majordomo Executus in Molten Core
  - Gnomeregon alarm bots
  - Onyxia's Breath
  - Poison clouds

Usage
=====
/lookout to bring up options.


Known Issues
============

* Need actual Help text.
* Molten Core functions have not been tested yet.

Versions
========
2.96 - Sep 17,2006
* Hopefully fixed error generated when targeting dead Blackhand Summoners
* Implemented the code to find a specific target in a crowd

2.95 - Sep 10,2006
* Changed response to Mandokir's gaze. He now will charge if he takes damage
  so we need to stop auto-shot and channeled spells. Now you target yourself
  when he looks at you.
* Added Onyxia's breath.
* Credit Manfred Klein for the BorisBlackBloxx font in the Readme.txt.
* Removed Gurubashi Bat riders - they no longer explode as of 1.12


2.94 - Aug 22, 2006
* Possible fix for Blackhand Summoner auto-targeting
* Updated TOC numbers for 1.12 patch

2.93 - Aug 21, 2006
* Fixed undocumented dependency

2.92 - Aug 13, 2006
* Fixed Eye of Kilrogg alerts in Dire Maul

2.91 - Aug 11, 2006
* moved checkbox on Boompage.

2.9 - Aug 11, 2006
* Made the SchnoggoAlert alert dependency optional, and got rid of the "package" scheme.
* Added new debugging model
* REALLY fixed the missing of the monster emotes!

2.8 - Aug 9, 2006
* Added generic poison cloud warnings
* Added research function to find which event produces which message
* Hopefully fixed monster emote issues

2.7.1 - Aug 6, 2006
* Fixed Majordomo Executus' name

2.7 - Aug 6, 2006
* Updated version number for patch 1.11

2.6 - Aug 4, 2006 (Testing release)
* Made the settings character specific
* Added healing target for Arlokk's hunter's mark
* First pass at class-specific preferences
* Consolidated debugging information. "/lookout debug" to toggle setting
* Added method to reset preferences. "/lookout reset"

2.5 - Aug 2, 2006 (Testing release)
* There were some weird problems with preferences on some previous builds. This 
  version implements a Version Check mechanism that can "fix" old saved variables.
* Added Majordomo Executus in Molten core shield warnings and actions. (untested)
* Added exploding bats in ZG (untested)
* This build has a bunch of debugging information turned on. 
  If one of the events goes off and a warning does not appear, please take a
  screen shot and send to schnoggo {at} gmail-dot-com.

2.4 - July 30, 2006 (Internal build)
* Removed the BattleCommand interface. If there is interest I will pull it into its own addon.

2.3 - July 29, 2006 (Internal build)
* Pulled the alert text frame out into its own AddOn called SchnoggoAlert.

2.2 - July 28, 2006 (Internal build)
* Fixed Baron Geddon problem. The detection was correct, however 
  the preferences pane had a cut-and-paste problem.

2.1 - May 20, 2006
* New large font for heads-up display
* Fixed possible bug with Blackhand summoner detection
* Cleaned up some graphical with the tabs on the preferences interface

2.0 - March 28, 2006
* Updated version for WoW 1.10
* First pass at "living bomb" in Molten Core
* Gnomeregon alarm bots
* Finally squashed the bug in the group management code caused by logging in while in a raid.
* New tabbed interface in preferences
* New "Battle Command" functionality
  - "Battle Command" keybindings allow you to quickly issue up to 10 messages
  - Display "Battle Commands" from raid/group leader in the HUD & perform actions
  - Optionally set your "Main Assist" if using SimpleAssist
  - "Battle Command" message editor (In /lookout)
  - "Battle Command" panel (/lookout show)
  - 

1.6 - Jan 16, 2006
* Yarg. Another attempt to fix the error with the Wandering Eye of Kilrogg in Dire Maul!
* Rearranged Preferences panel
* Separated Eyes into separate preferences
* Added Blackhand Summoner in Blackrock Spire


1.52 - Jan 12, 2006
* Fixed an error that popped up when encountering Eye of Kilrogg in Dire Maul
* Added Eye of Kilrogg info to preferences pane
* Fixed version numbers

1.51 - Jan 10, 2006
* Updated version for patch 1.91

1.5 - Dec 31, 2005
* Custom sound for alerts
* Saved variables are now working

1.4 - Dec 29, 2005
* Options panel works!
* Add checks on each function to actually test options 


1.3 - Dec 26, 2005
* First pass at an options panel


1.2 - Dec 20, 2005
* Added test build to confirm targeting behavior for "eyes"


1.1 - Dec 16, 2005
* After looking at some other AddOns it looks like I had the wrong string. Fixed in this version.


1.0 - Dec 15, 2005
* First version released

To-Do
======
   
* Make load-on-demand
* Add command line options to turn on/off
* Add Actual Help. :)
* Localizations


Contact
=======

Author: Schnoggo (schnoggo {at} gmail.com)
Website: http://ui.worldofwar.net/ui.php?id=1714

