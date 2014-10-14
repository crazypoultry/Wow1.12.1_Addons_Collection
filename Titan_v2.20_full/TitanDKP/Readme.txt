Titan DKP - version .91
Written By Patrick Wall
Website: http://www.curse-gaming.com/en/wow/addons-5493-1-titan-panel-dkp.html

Description:
Titan DKP is a utility for Titan Panel (which you can see details of here: http://ui.worldofwar.net/ui.php?id=1442).  It allows the storing of DKP points and access to other character's totals, which can be added to your own.  It also allows automatic tracking of DKP during raids.  Included is a plugin for eqdkp websites which allows automatic upload and download of addon data.

Installation:
Copy "TitanDKP" directory into the directory <World of Warcraft>/Interface/Addons.

There are further instructions in the EQDKP Plugin directory to make the addon work with a eqdkp based website.

Usage:
Show Titan DKP by right clicking your Titan Panel and selecting DKP from information.  This will provide a display of your current points and your total points, which includes the points of your alts.  Left clicking on this allows you to enter a mathematical expression to add to your current points.  This is useful if you're in a zero sum system, as you simply enter <points spent>/<number of players in raid> for each item recieved.  Right clicking the button will present you with a menu.

The menu DKP System allows you to select the current system, delete the current system, add a new system, enable tracking of points during a raid, and change system settings.

Changing system settings will open a window with fields to enter a value for killing a boss, or entering an instance, based on instance name.  There is also a setting for the quality of item to record, whether to stop giving points for coming after a boss is killed, and whether to add negative points on alts to your own.

The menu Alts will be available if you have enabled this plugin on multiple accounts of your machine, or have selected alts for one of your accounts in the saved menu.  In this menu is a list of alts available to you, for easy access.

The menu Unassigned Items will be available to you if you are in a raid and items have been looted, but not assigned a point value.  By selecting an item on this list, it prompts you to enter a value to add to the receiver of the loot.

The option view raid points opens a window with the points of players in your current raid.  On this window is a filter to filter the list by, as well as a button to add a value to the whole raid.  If autocollection of points is enabled, anyone you enter a raid with will be saved into the addon, if not they will not be displayed.

The option view saved points opens a window with all the saved players, and options to edit, delete, or set the alts of them.  There is a filter for the list, as well as a button to add a player manually.

An option to Import Web Data will be available if you have the saved file from the eqdkp plugin included in the eqdkp plugin directory of this addon.

The final option on this menu disables the titan dkp addon for the character you're on.

Slash Commands:/titandkp help - Display help message/titandkp [add/remove] system [name] - adds/remove a system/titandkp [add/change/remove] player [name] <class> <value> - adds/remove a player or change player data
/titandkp change raid [value] - Add points to all raid members
/titandkp search <raid> [searchstring] ... - search for names/classes in raid or all/titandkp [value] - Any other value will be evaluated and added to the DKP

Changelog:
v .91 - Added check that dkp system is enabled before adding members to it.

v .9 - Numerous bug fixes, eqdkp website plugin added

v .8 - Major Update, added support for multiple DKP systems, option to save other player's points, support to import DKP Info Data, improved compatibility, changed UI, etc.  You will have to reinput all data as they are saved in a different format now

v .7 - Initial Public release