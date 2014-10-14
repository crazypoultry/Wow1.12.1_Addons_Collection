_____________________________________________________________________________________

KC_AutoRepair

Author:   Kaelten (kaelten@gmail.com)
Version:  1.0
Release:  12/04/2005
Website:  http://kaelcycle.wowinterface.com
_____________________________________________________________________________________


KC_AutoRepair is a small utility to automate repair operations at a vendor.

_____________________________________________________________________________________

DEDICATION:  
_____________________________________________________________________________________

This mod goes out to all the people who have gotten to the AH and said ... 'Sunza b....'

_____________________________________________________________________________________

FEATURES
_____________________________________________________________________________________

- Offers both silent repair mode and prompt mode
- Will repair not only equipment but also your inventory items
- Allows you to set a range for automatic repair
- Offers a GUI to set options (requires AceGUI)

_____________________________________________________________________________________

NOTES
_____________________________________________________________________________________

Same options are available in this version as in the old.

Chat commands include "/ar", "/kcar", "AutoRepair", or "KC_AutoRepair" 

Chat options:
standby		prompt		mincost <number>
skipinv		verbose		threshold <number>
config

Standby		- Toggles the mod on/off.
Skipinv		- Should it check and repair your inventory?
Verbose		- Displaying advance feedback messages.
Prompt		- Prompt the user for a repair or do it manually.
Mincost		- Set the min amount KCAR will auto repair.
Threshold	- Set the most amount KCAR will auto repair.
config		- Show the graphical configuration box.

You must be running Ace 1.2.5 or later to run this addon.

Optionally, you may also wish to run AceGUI 0.090 as well.  You will not have access to
either the config screen or the prompt option without it.

Both of these addons can be found at either www.wowinterface.com or links can be found at www.wowace.com

_____________________________________________________________________________________

VERSION HISTORY
_____________________________________________________________________________________
[2006-01-19] 1.03
- Fixed a few mistake with Optional AceGUI support.

[2006-01-19] 1.02
- Fixed a few mistake with locals.

[2006-01-19] 1.01
- Fixed bug where the inventory would not be repaired properly.
- Changed Toc number
- Added German Translation

[2005-12-04] 1.00
- Name changed to KC_AutoRepair
- Complete rewrite
- Made Ace Dependent.
- Added optional dependency for AceGUI (required for the GUI and for the new Prompt)
- Removed the OnUpdate block
- Simplified Logic; let me know if I broke it.
- Standardized chat handlers
- Added a graphical configuration screen.
- Fixed Inventory Repair.
- Tested on 1.9 and it still works.  
- Redid the verbose messages.