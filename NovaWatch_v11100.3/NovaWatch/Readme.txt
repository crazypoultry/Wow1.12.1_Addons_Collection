Displays a progress bar for Mage's Frostnova Spell.
	
A modification of the "StunWatch" from "Vector" primarily for mages and ripped and off Veithflo's SheepWatch Version 1.5.
	
This addon listens to the combatlog and its events to show a moveable progressbar which gives you an impression on how long your target will remain frosted.
	
Tested with WoW Client version 1.11 (deDE and enGB).
		

INSTALLATION:

Extract the .zip to the directory of your World of Warcraft installation. To remove NovaWatch, delete it.
	
To get help, type "/novawatch", "/nova" or "/nw"

UPCOMING FEATURES:
(Sneak preview to the next version)
- Configuration via GUI.
- Other suggestions? Mail me.

KNOWN ISSUES:

- Registrates events only at a specific distance (40 yards), because the combat chat isn't showing it above this distance. I see no way to fix this, because WoW doesn't log the event in the combat chat.  


CHANGES: 
Version 11100.2:
* French localization updated. Thanks to Thiou.

Version 11100.1:
* Bumped .toc version to 11100

Version 11000.1:
* Bumped .toc version to 11000
* Introduced a config gui for all command-line settings.
* Removed all depreciated command-line settings which are now handled via gui.
* Removed the dedicated counter frame and placed it into the main bar with a right alignment.
* Added the ability to change the bar color.
* Added the ability to change the bar transparency.
* Added the ability to change the bar scaling.
* Changed config storing to a character-dependent SavedVariables file (as all mod developers should do!).

Version 10900.1:
* Bumped .toc version to 10900
* Changed versioning scheme to something more appropriate.
* Added a command 'decimals' to show/hide the digits to the right of the counter's decimal point.
* Added a command 'status' to display the current config. This command was already there but not documented yet.
* Fixed a bug that didn't hide the counter frame after moving the whole bar.
* Fixed a typo in the german localization.
* Changed the counter font to the one used in the status bar.
* Made the counter frame movable as requested by several people.
* Newly introduced commands:
	/novawatch decimals		(toggle - enabled by default)
	/novawatch status

Version 1.0:
* Initial release.