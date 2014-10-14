Healbot continues by Strife.

HealBot is ready for BC with decursive options.
HealBot allows for 20 key+mouse combinations to cast any beneficial spells.
HealBots appearance can be configured and preferred appearances can be saved as skins.
HealBot can show party/tanks/checked targets/extras in a raid, extras can be filtered and sorted.
Multiple HealBots in a party/raid sync incoming heals. 
HealBot will accurately range check outside instances and has an option to 27yard range check in instances. 
HealBot will show an abort button when overhealing, the overhealing amount is configurable.

--------------------------------------------
NOTE: For HealBot to work correctly, the Selfcast feature in wow options needs to be disabled. 
--------------------------------------------

Reporting ERRORS:
================
Major error will popup a frame with error information.
Take a screenshot and post comments.

--------------------------------------------
Option changes from the original HealBot.
1. The option Integrate with default party frames has been removed. (v1.0)
2. The option Minimum healing used has been removed. (v1.0)
3. The option Exact 28yard range check in instances has been added. (v1.0)
4. The option Bigger heals << Preference >> Faster casts has been added. (v1.0)
5. The option Overheal Alert slider has been added (v1.12)
6. The option to select PvE or PvP profiles has been added. (v1.12)
7. Merged tabs Keys and Chat into Misc. (v1.121)
8. Created new tab Emerg, a number of new options for emergency buttons on this tab. (v1.121)
9. Tided up the buttons on some other tabs. (v1.121)
10. The option Bar Opacity has been added. (V1.123)
11. The option Incoming heal opacity has been added (v1.123)
12. Mouse buttons have been added for use with Combo Keys (v1.124)
13. Replaced Emerg with Cure, Cure has decursive options (v1.125)
14. Updated tabs Spell and Healing in preparation for BC (v1.125)
15. Removed tab Misc and moved chat options to General (v1.125)
16. Created tab Skin with options for apperance. (v1.125)
--------------------------------------------

Change log:
v1.126
=================
* Added new options to target and cast on disabled bars.
* Added res indicators
* Added more options to tooltips and information on the bars.
* Updated French localizations.
* Registered Healbot with TitanPanel under category Interface


v1.1256
=================
* More updated French localizations.
* Added a few beneficial spells to defaults.
* Change to tooltips to avoid interference.


v1.1255
=================
* Updated French localizations.


v1.1254
=================
* Updated text on bars to scale with bar size and font size.
* Added Alteric Valley skin to defaults.
* Added option to show headers above the bars.
* Fixed a few bugs
* Updated Korean localizations.


v1.1253
=================
* Fix for debuffs.
* Fix for skins with options fontsize, abortsize, abort colour and disabled bar opacity
* Updated opacity code for bars and text.
* Added German localizations
* Fixed startup errors for none healers.


v1.1252
=================
* Changed range checking for debuffs, bars will now change colour but no warnings issued. (if known to be out of range)
* Fix to catch charmed raid members.
* Fixed font scaling bug
* Cleaned up tooltips
* Fixed the window popup bug when player dies in combat


v1.1251
=================
* Fixed checked box issues
* Fixed out of combat when leaving a zone while in combat. 
* Added latest Korean localizations


v1.125
=================
* Added skin options to change and save the appearance of Healbot.
* Added decursive options compliant with BC.
* Added tooltip options and only refreshing when required.
* Fixed German localization issues. Big thank you to Corillian on cursed.
* Cleaned up error reporting, mainly for localizations.
* Updated Unit bars ready for BC.
* Significant performance increase


Change log:
v1.1242
=================
* Minor changes for performance.


Change log:
v1.1241
=================
* Updated Korean localizations


v1.124
=================
* Removed Hunter class from using HealBot.
* Added Middle and Right mouse buttons to combo keys.
NOTE: I recommend removing HealBot.lua and HealBot.lua.bak (if it exists) from your SavedVariables directory.
It can be found in: <World of Warcraft>\WTF\Account\<Account Name>\SavedVariables
This will remove some old config data no longer used but it will also reset the options to defaults.


v1.1232
=================
* Fixed spam issue with non healing classes.
-- Thanks to hitekredneck13 on cursed for reporting this bug.


v1.1231
=================
* Any spell can be used with combo keys
-- Thanks to Jerenn and solorider on cursed for reporting this bug.


v1.123
=================
* Communication between healers using healbot to show incoming heals
* Number of checked targets back to 5 without original bug
* Added to CT_MOD Control Panel and fixed integration with CTRA. 
* Split localizations into separate files.
* Delayed initialize spell data when talents.
-- Thanks to Abbevillian of PG (CUK) for reporting this bug.
* HBmsg is now the debug channel.
* Improved performance, removed talent lookups, redundant code and hardcoded spell data
* Fixed tooltips for old style buttons and fixed abort button bug with old style buttons.
-- Thanks to spenster on cursed for reporting this bugs.
* Loading spell data by scanning spellbook.
* Changed appearance of abort button to make it more visible.
* Added opacity setting for HealBot bars and opacity setting for incoming heal indicators
* Updated range checking function
* Cleaned up HealBot_config
--
NOTE: I recommend removing HealBot.lua and HealBot.lua.bak (if it exists) from your SavedVariables directory.
It can be found in: <World of Warcraft>\WTF\Account\<Account Name>\SavedVariables
This will remove a lot of old config data no longer used but it will also reset the options to defaults.


v1.122
=================
* Changed the Buttons to Bars. NOTE: to switch between buttons and bars, run switch.bat in the Healbot directory.
* Added zone change event to reset scale for range checking.
* Cache data and reduced amount of code for tooltip, to much code was being scanned for this.
* Updated talent and equipment bonus lookups to only lookup when needed.
* Removed dependency on BonusScanner and added a cut version to only scan for heal bonus when needed.
* Fixed tooltip bug for spells not checked on use tab but included in combo keys
* Fixed Priest Spirit bonus mod which was ~+1 out
* Fixed ComboKey spell usage to use highest spell unless rank is included
-- Thanks to Astranius on cursed for reporting this bug.
* Added Priest's Improved Power Word Shield to talent modifiers
* Removed all moving checks, it is not accurate and causes bugs


v1.121
=================
* Removed MT's from MT buttons when MT is in players party and players group buttons shown.
* Removed emergency buttons when the target is in the players party and players group buttons shown.
* Merged Option tabs Chat and Keys into Misc
* Added new Options tab Emerg
* Added filter to emergency buttons to only display for a type of Class(es) as setup in emergency options.
* Added option range check to hide emergency buttons for targets out of range.
* Overlapping Options and Abort button bug fixed.
-- Thanks to Thoril on cursed for reporting this bug
* Bug fix for Shaman not being able to cast a new rank10 spell and for any new future healing spells. 
-- Thanks to Kaplar on curse for reporting this bug


v1.12 (Note: this version resets the options to defaults)
=================
* Added PvP and PvE profiles and allow for different settings in each profile.
* Added an abort button which will display if your current spell is going to heal the target for more than the Overheal percentage * 4 as set in the options using the Overheal Alert slider.
* Changes to the options for overheals and added an Overheal Alert slider.
* Updated background not to change colour when player stops casting.
* Removed some redundant code
* Spell preference values raised, the preferences are weighted against the targets DPS and time to live, if the target is about to die and the preference is for faster casts then healbot will perform 
a faster cast. If your target has 0 DPS and more than ~20 secs to live then the preferences are only slightly considered.
* Reduced score of HoT's when the target is about to die.
* Updated the code for healthstones and healthpots. 


v1.11
=================
* Fix a bug introduced in V1.1 where range checks cause a nul error to spam in BG's.


v1.1
=================
* Update spell selection to only choose instant cast spell when the player is moving.
* Improved range checks to check the range for each spell, some channel spells only have a 20yards range.


v1.01
=================
* Fix more bugs with talent modifiers applied to mana cost and cast time. Healbot is now performing as expected.


v1.0
=================
* Fixed all data for spells with current patch 1.12 data.


v1.0 rc2
=================
* 40yard range check does not work in instances. Outside in normal zones the 40yards check still works. Inside instances there is a choice of 28yards or 100 yards, to set at 28yards check the option Exact 28yard range check, for 100yards uncheck it.
* Brought back cast time modifier with reduced penalty to scale depending on users preference as set in the options.
* Moved most register events to fire after addon loads, this is for faster loading and zone in.


v1.0rc1
=================
* Added Ranged checking function and tied into existing can cast checks, currently set to 40yards for all.


v0.998
=================
* Fixed bug where if you have 5 extra people checked and then select a 6th, it errors with a null value to index local check.
Note: you can now only check 4 people.
* From this release I will start to maintain a change log. Can still remember major changes in .996 and .997 but the 10 version before .996 are now a blur, it was mostly testing and tuning heals with some other bug fixes.


v0.997
=================
* Healbot is now performing better, put back the item bonus and talent modifiers, these were reduced due to the lesser heals bugs.
* Reduced price of HealthStones, healbot should use these when you mana is starting to drop and health low, needs more tuning and feedback welcome.


v0.996
=================
* Removed cast time from calculating best spell, with the introduction of item bonuses and talents, the +heals made spells with higher cast times score badly which resulted in them not being used.
* Removed a number of function calls when not needed, significantly reduced the amount of code being consistently parsed, this means healbot is now far more efficient.
* Removed the flashing red background, although this is a good way to indicate that the heal will overheal and it is best to abort, it annoys me and I can't be bothered to abort half the time anyway.


v0.95 - v0.995
=================
* Generally debugging and tuning with the introduction of item bonuses and talents being applied to amount healed.
* Updated duration and amount healed for priests greater heal spells, this change in patch 1.10 was not updated in healbot.
* Increased price of HealthPots and HealthStones, to reduce usage of these items.


v0.94
=================
* Picked up healbot with some changes from the original, which fixes a serious bug where the game freezes after a DC but added bugs where small spells are being selected.
* Making some changes to the code and testing.



-------------------------------------

This is Holgaards Healbot which I am continuing development of. 
This was without consent from Hogaard or anyone else.
Not much is left of the original automatic spell selecting Healbot but
without the original Healbot this version would not be here today.


Installation :

Unpack the zipped file and place the HealBot folder under Interface/AddOns
in your World of Warcraft directory.  Path with default installation:
C:\Program Files\World of Warcraft\Interface\AddOns\HealBot


Chat commands :

/hb          -  toggles the main HealBot panel on and off
/hb options  -  toggles the HealBot options panel on and off
/hb reset    -  resets the contents of the main HealBot panel