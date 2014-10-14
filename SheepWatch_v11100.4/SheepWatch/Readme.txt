Displays a progress bar for Mage's Polymorph Spell.
	
This addon listens to the combatlog and its events to show a moveable progressbar 
which gives you an impression on how long your target will remain polymorphed.
Tested with WoW Client version 1.11 (enGB).
	
To get help, type "/sheepwatch" or "/sheep"


INSTALLATION:

Extract the .zip to the "Interface\AddOns" subdirectory of your World of Warcraft installation. To remove SheepWatch, delete it.


CHANGES:
Version 11100.4:
* Fixed a bug which lead to the highest spell rank not being recognized in non-english versions.
* Fixed korean localization.

Version 11100.3:
* Fixed a bug which could let the bar not fade out when mob is damaged.
 
Version 11100.2:
* Fixed french localization. Thanks to Thiou.

Version 11100.1:
* Bumped .toc version to 11100
* Added support for Polymorph: Pig

Version 11000.1:
* Bumped .toc version to 11000
* Several other minor fixes.

Version 10900.4:
* Fixed a bug with the saving of a custom announce pattern.
* Several other minor fixes.

Version 10900.3:
* Enabled SheepWatch by default.
* Introduced a config gui for all command-line settings.
* Removed all depreciated command-line settings which are now handled via gui.
* Introduced several keybindings. Check out the keybinding configuration in the main menu.
		* Introduced a keybinding for casting your highest Polymorph rank on your current target.
		* Introduced a keybinding for re-targetting your sheep. 
* Removed the dedicated counter frame and placed it into the main bar with a right alignment.
* Added the ability to announce your Polymorph before casting.
* Added the ability to change the annouce via pattern on the fly.
* Introduced a new announce target 'auto' which automatically sends the announce to either raid or party when you joined one of them. 
* Added the ability to change the bar color.
* Added the ability to change the bar transparency.
* Added the ability to change the bar scaling.
* Changed config storing to a character-dependent SavedVariables file (as all mod developers should do!).
* Added korean localization (thanks to gygabyte).
* Fixed a bug for PvP users: The bar should not fade out anymore in a PvP fight when you go out-of-combat and your target is still polymorphed.
* Alot of other minor improvements and bug fixes.

Version 10900.2:
* Fixed a minor bug which didn't show the new 'decimal' command in the help.

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
	/sheepwatch decimals		(toggle - enabled by default)
	/sheepwatch status

Version 1.6.3:
* Bumped .toc version to 1800

Version 1.6.2:
* Bumped .toc version to 1700

Version 1.6.1:
* Fixed a bug which could have caused an error msg when several players and mobs are fighting near you (esp. in instances).
* Introduced a max-duration of 15 seconds when polymorphing another player (PvP).
* Handling of diminishing returns in PvP improved.
* Re-targeting drastically improved. It nearly always succeeds when your sheep is infront of you. Try clicking on the progress bar again, when it failed.
* Progress bar fades now properly out when you leave combat or die.
* French localization fixed so re-sheeping is now properly recognized with this client language (Credits go to my wifes large diskdrive and my DSL line which both allowed me to leech WoWs french ELP package and patches within 2 hours). Much script output isn't properly localized to french yet. Who want to volunteer?

Version 1.6:
* Updated .toc for the WoW 1.6.0 patch.
* All dependencies and unnused code segments of StunWatch got removed.
* Frostnova bar got removed.
* SheepWatch now automatically recognizes your Polymorph spell rank.
* Re-Sheeping is now recognized and properly handled.
* Added the ability to inform the players near to you that you have polymorphed your target. Output is possible to your party, guild,	raidgroup or environment. It automatically recognizes if you are in a	party, guild or raidgroup and suppresses output if not.
* Added a counter to the progress bar which gives the appox. sheeptime in seconds.
* Added the ability to re-target your sheep by clicking on the progressbar.
* Added a framework to automatically clear the cached profile to circumvent compatibility issues when the author has changed the profile syntax. This doesn't effect version 1.6 - as SavedVariable was renamed here - but may be needed for further versions.
* Removed several minor bugs.
* Updated all localizations and splitted them into files.
* Newly introduced commands:
	/sheepwatch verbose		(toggle - disabled by default)
	/sheepwatch counter		(toggle - disabled by default)
	/sheepwatch announce	(toggle - disabled by default)
	/sheepwatch target [say|party|guild|raid]	(default to "say")
* Removed commands:
	/sheepwatch rank [1|2|3|4]
	/sheepwatch clear


KNOWN ISSUES:
* The script engine of WoW contains a bug which seldomly let fade out the progress bar. Explanation: When you Polymorph a target, the CombatLog gets an event showing the mob being afflicted by Polymorph. The same goes for timeouting or breaking of the Polymorph. A message is displayed in CombatLog for all three possibilities. Sometimes the fadeout event is triggered by the client directly after the target got sheeped even though the target remains polymorphed and no message is displayed in the CombatLog. This bug afflicts SheepWatch as it listens to this events and shows or hides the bar based on them.
* Polymorphing players leads to a drastically decreased spell duration. Sheeptimes beyond 15 seconds are very rarely. SheepWatch encounters this with a max-duration of 15 seconds in PvP (minus possible diminishing returns). It may - even though seldomly - be that the target remain polymorhed beyond that time but the progressbar times out.
* The ability to re-target your sheep with clicking the progressbar doesn't always lead to the right target when more than one mob of the same type as your sheep is near to you. Try clicking the progress bar again, then.
* Registrates events only at a specific distance (40 yards), because the combat chat isn't showing it above this distance. I see no way to fix this, because WoW doesn't log the event in the combat chat.  


UPCOMING FEATURES:
(Sneak preview to the next version)
* OnDemand version