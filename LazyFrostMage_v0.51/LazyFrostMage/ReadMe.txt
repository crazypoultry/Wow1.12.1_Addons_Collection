DESCRIPTION:
============
This AddOn allows you to grind using only one button.
There are two modes added, farming mode and party mode;

//Farming mode:
	This is basically what this AddOn is made for, do the boring grinding with one button.
	Firstly, it will always focus on keeping your ice barrier up, if ice barrier is unavailable or on cool down it will cast mana shield instead.
	When you’re out of combat this AddOn will rebuff you if necessary with Arcane Intellect, Frost Armor and Dampen Magic. 
	It will also attempt to conjure all mana agates available and if necessary it will conjure more water.
	After all that it will start drinking if the mana is lower than 85%, and if the above processes fails because low mana it will try drink instead.
	When you’re all buffed up and full mana it will target the nearest enemy and pull with frost bolt.
	While you are still in combat it will continue to nuke frostbolts(you may move back if the target gets frost biten but it has to be performed manually)
	If you get out of mana it will use the best mana gem available.
	When your target has less than 15% hp it will cast fire blast to finish him off.(will still cast more frost bolts if it fails)
	When your target is dead, and if you’re still in combat (you might got some adds) it will target the nearest enemy and check if he/she is affected by combat
	If so it will cast frost nova first (incase you wants to step back before continuing or sheeping or even run if necessary)
	After that it will go as normal by nuking the target until its dead.

	I would recommend an AddOn for making a sound when your health&mana is low, incase you gets adds you can't handle and have to flee and you’re not paying much attention to your monitor.
	
	Also keep in mind that you must move around and Loot corpses yourself.

//Party Mode:
	This isn’t made very complicated, to avoid losing the fun with going with a party when much can happened.
	Basically this mode targets your 'Main Assist's target and nukes frost bolts. 
	This will make it easier for you to keep nuking the same target as your main tank for instance to avoid getting aggro
	When out of combat you will drink if mana is lower than 85% and even if your main tank continues to fight while you are drinking you will
	Wait until you’re done drinking before assisting, this will also give him some time to get aggro.
	As with the Farming mode, it will make more water if necessary as well.
	This mode will NOT cast frostbolts on 'Main Assist's target until it gets in combat, avoid pulling new mobs before all party member are fully rested
	
	To set your 'Main Assist', target whoever player you wants to assist (I would suggest the main tank in most situations).
	Then hold down the Alt-Key while clicking the button once (clicking twice will set your 'Main Assist's target as the new 'Main Assist'

//Disabled Mode:
	It’s disabled, any /LFM Action calls will only make it cast frostbolt on target.





INSTALLATION:
=============
simply add extract the LazyFrostMage.rar into your wow./interface/addons directory.



USAGE:
======
/LazyFrostMage & /LFM to view a list of available commands
/LFM Farm 	: will set the addon to do the "farming mode" upon Action
/LFM Party 	: will set the addon to do the "party mode" upon Action
/LFM Disable	: will set the addon to do the "disabled mode" upon Action (will only cast frostbolt at target)
/LFM Help	: Will show a detailed help MSG about each modes
/LFM Debug	: Toggles Debug mode. (Showing chat messages for many actions, used for debugging only)
/LFM Action	: Performs the set of actions from farming mode, party mode, or disabled mode.
		'It's a good idea create a macro for this command so you can repeately click it




TODO:
=====
//Currently the addon seems to have problems running correctly if the macro is executed by a keyboard shortcut, this could be some of the botting protections from Blizzard.
If you are experiencing the same problem you have to use the mouse to click the macro.
If anyone knows why this error is caused and know how to fix this please contact me (kirest@doravoc.com).

//Some UI Frames for the addon would be cool too, like options for choosing what spell to open with, to nuke with and to Finnish with.
But I don't know much about that coding so i can't do that for the moment, if you can; please contact me (kirest@doravoc.com).





CREDITS:
========
Programmed and Debugged by Nackle from Shadowmoon(kirest@doravoc.com)

Also a thanks to SuperMacro, used some of their functions as a "template" to make some of the functions designed for this addon




VERSION HISTORY:
================
22. Sep 2006 - v0.51
	Fixed the SuperMacro Dependency, the mod should no longer require supermacro to run.

21. Sep 2006 - v0.5
	Initial Release