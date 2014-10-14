DESCRIPTION:
============
MetaGuild is an all-in-one Guild management utility. It has the standard Guild utilities, as well as modules for Raid auto-invite, DKP and Raid roller. Note that the DKP section is specifically dependant on having the ScenRaid addon installed. Although an excellent addon, ScenRaid lacks the means to random roll a DKP value. The DKP section in this addon fulfills that need.

To install it, simply drop the MetaGuild folder into your Interface/AddOns folder. After logging in, you will see a new icon on the Minimap for MetaGuild. LeftClick opens the main window, whilst the default MouseOver will display the options menu.

OPTIONS:
========
Button Menu:
	Menu On Click: Displays the menu via MouseOver or button click
	Use MG-RaidRoller: Toggles the monitoring between internal or system rolls.
	Loot Capture Level: Sets the level to handle loot for rolling and distribution.
	Loot Anounce Level: Sets the level to announce found loot to the raid.
	
Raid section:
You will need to enter a name or description on the initial templates screen. Once done, click on the entry to bring up the options screen. From here you can set the various options, such as level requirement, class limits, invite keyword etc. Once all settings have been entered, select Start to start broadcasting the invite to the Guild channel. The 'Silent Broadcast' option can be set to start the invite, but without actually broadcasting it to the Guild channel. It will automatically advise raid applicants when a class limt has been reached, or when the raid is full.
	
DKP Section:
This is linked to the ScenRaid addon so, unless you have that installed, you will only see a blank screen here. Otherwise, it will list all the Guil;d members with their current DKP values. Toggling the 'Show Raid' option will display either ALL Guild members, or just the members that are in your current raid.

RaidRoll Section:
Note that this section will only work if you have Master Loot set, and you are the Master Looter!
When you loot a corpse, the dropdown will fill with all the loot found on the corpse, according to the loot level set on the Button menu. 'Start Roll' will announce the loot to the raid and ask them to roll. The type of roll will depend on the options you have selected. 

There are 3 types of roll: With MG-Roll selected on the button menu, the raid member simply types 'MGRoll' to register a roll. If you have the 'Use DKP' option set, it will random roll their DKP value. Otherwise, it will roll a standard 1-100 roll for them. If the MG-Roll on the button menu is not selected, then members simply roll a standard system roll (/roll) which will be processed by this section.
	
Ending the roll will announce the roll winner to the raid and the 'Assign' button will be enabled. Clicking on assign will pop up a confirmation dialogue for the loot assignment. Confirming will pass the loot to the winner, and announce the member and loot gained to the Guild channel.

Note: If you use CTRA addon, it will also announce via the /rs when new loot is found. You will need to ensure you are promoted if you want to use this feature.

General:
The small arrow buttons will select previous screens, toggle a column, select another screen, or even minimise the modules. Try them!

CREDITS:
========
MetaGuild is based on parts of RaidOrganiser, which in turn was based on GuildOrganiser. Full credit goes to both authors for original design elements.
German translation by: nonnex

VERSION HISTORY:
================
26 Feb 2006 - v1.0
	Initial Release

28 Feb 2006 - v1.01
	Roller keyword corrected. Incorrectly advising to roll with 'GMroll' instead of 'MGroll'.

14 August 2006 - v11100-1
Changed version numbering to include current TOC.
Updated Menu saved instance display to the new Blizzard checking call.
Updated the localisation file to include German and French translations.
...(Anyone fancy sending me the translations?)
Updated the class localisations for German client.
Included class fix for class color returns. With thanks to nonnex for that.
...(How incredibly silly of Blizz to return only English class names for that :p)
Expanded the class fix to include French clients.
Localised the class names in various routines to show class names in correct language.
...(Should also make the class counts work correctly for German/French clients).
Added support for FuBar. Will look at expanding on that soon.

15 August 2006 - v11100-2
	Included the correct localisation and Readme files this time.
	...(For some reason the old ones found their way into the last archive).
	German localisation completed. With thanks to nonnex.
	