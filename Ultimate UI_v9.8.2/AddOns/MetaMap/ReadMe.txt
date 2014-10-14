DESCRIPTION:
============
MetaMap adds features to the WoW world map, keeping all mapping type features in a single place.
Some features are:

Adjust the map window size.
Move the map anywhere on the screen.
Adjust the opacity of the window & maps.
Saved sets for toggling between 2 map modes.
Allows full player movement, messaging, etc. with map open.
Adds coords to the main map
Adds coords to the Minimap
Adds Instance maps which open to the correct instance you enter.
Default data included for all bosses & locations etc.
Misc information on Instances.
User editable notes for all maps, including instance maps.
NPC/Mob database collectable by mouseover or keypress.
Toggling on/off display of unexplored areas of the map.
Button on Minimap to open or close the World Map or display MetaMap options.
Key bindings for MetaMap and MapMode toggle.
Full support for Titan Bar.

TO DO:
======
Add an internal checklist to detect any zoneshifts/changes and to
automatically update when detected. 

INSTALLATION:
=============
Simply unzip the MetaMap folder to the Interface\AddOns\ location.

ISSUES/COMPATIBILITIES:
=======================
If your map jumps back to your current location when selecting another map, it will be due to another addon resetting it.
Known addons which cause this are:
Gatherer: Latest Gatherer version fixes this.
MapNotes(pre 1800): Do not run MapNotes alongside MetaMap.
MonkeySpeed: Still awaiting a fix from the author.

CREDITS:
========
Maps courtesy of WoW Cartographe and WoWGuru.com.
French localisation by Sparrows.
German localisation by oneofamillion.
MapNotes code integrated into MetaMap by kind permission of the author.
Original WoWKB code by ciphersimian.
Original FullWorldMap code by Mozz.

*****NOTE*****
MapNotes and WoWKB have been INTEGRATED into MetaMap. This means the original MapNotes & WoWKB addons are no longer required. Remove them to avoid conflicts!
They only need to be run the once with MetaMap to import any saved data, if you were previously using those addons.
As from v3.0 MozzFullWorldMap is also integrated into MetaMap. Remove MozzFullWorld from your system to avoid clashes.


	
*******************************************************************************
                                  MAIN MAP
*******************************************************************************
The additions to the main WoW WorldMap were intended to fit in as smoothly as
possible, keeping the overall format the same. It adds not only Instance maps,
but also extends user editable notes to the Instance maps.

Options Menu:
Menu on Click: Menu is displayed by clicking the button or on mouse-over.
Wrap ToolTip: Will wrap tooltip displays to WoW defined limit.
Show Main Coords: Toggles the display of the WorldMap coords.
Show MiniMap Coords: Toggles the display of coords on the MiniMap.
Show Notes: Toggles display of all notes.
Show Author: Toggles display of Author line in all notes.
Show Map List: Toggles display of list for all notes on the map.
							Clicking an item in the list will ping the location on the map.
Action Mode: Toggles map Action mode. Sets map to a passive mode to allow all
					mouse action through the map. Setting stored for each Saveset.
Map Mode: Switches between 2 saved map modes. Each set stores its own settings
					for Opacity, Scale and Action Mode.
Notes Options: Displays an additional options menu for user notes.
FlightMap Options: Displays FlightMap options (Requires FlightMap Addon).
MasterMod Options: Displays CT_Mod options (Requires CT_Mod Addon).
Gatherer Options: Displaye Gatherer options (Requires Gatherer Addon).
Gatherer Search: Displays Gatherer search dialogue (Requires Gatherer Addon).
Better Waypoints: Toggles the BWP options (Requires BWP Addon).
Create notes with MapMod: New note creation is done with CT_MapMod rather than
					MetaMap's internal note creation. Both live quite happily with each
					other so, you can toggle between them at any time.
Knowledge Base: Displays the KB database window.
Show Unexplored Areas: Toggles the display of unexplored areas on the map.

Keybindings set in the system keybindings section allow quick key toggles for
things like switching between the 2 Map modes.


*******************************************************************************
                                KNOWLEDGE BASE
*******************************************************************************
This database stores the name, description and location of all the NPCs/mobs you
mouse over.  The location is stored as a range to allow for movement or various
spawn points.  The range is updated every time you find the NPC in a different
location.  The database is global - all your characters on the same
computer and account can access it.

The Auto tracking on mouse-over will only add information from NPC/MOB targets.
Would get pretty cluttered otherwise. However, there is also a 'manual' mode
via a Keybinding set in the system keybinding section. This method will also
allow a targeted Player unit to be added to the database.

You can create Notes when you need them (i.e. hunting a particular mob
or looking for a particular NPC) and then when things start to get cluttered
you can remove the notes for a particular NPC/mob by right-clicking
it in the results window or remove all the KB notes by clicking the
Clear Notes button.

In the main KB window:
Left-click - Add a note on the WorldMap and a MiniMap note for the selected entry
Right-click - Remove any notes on the WorldMap for the selected entry
<Shift>+<Ctrl>+Right-click - Remove selected entry from the database
<Shift>+Left-click - Send selected entry details to any open message box
Clear Notes button - clears all the notes on the WorldMap created by KB


*******************************************************************************
                              MAP NOTES
*******************************************************************************
Adds a note system to the WorldMap helping you keep track of interesting
locations.  This offers two main functions:

1. Marking notes on the WorldMap.
2. Showing one of these notes on the MiniMap as a MiniNote.

Map functions:
<Control>+Left-Click: On the WorldMap opens the note creator menu.
Left-Click: On a note opens the note editor menu.
Mouse-over: On a Note to see the tooltip with the information you entered.

[Edit Menu]
With this menu you can create new notes and edit existing notes.

	1. Select the icon style you want to use for your note.
	2. Title: Enter it in the editbox and select a color in which it will be
			displayed in the tooltip.
			NOTE: The title field is mandatory, you cannot create a note without
			a title - to prevent this the "Save" button is disabled when
			the title field is empty.
	3. Infoline 1 and 2: Here you can insert additional information for your
			note and color it in one of the colors below the editbox.
	4. Creator: Enter the name of the player or AddOn that created the note

[The MiniNote]
A MiniNote is a note placed on the MiniMap.  Moving the mouse over the
MiniNote shows the title of the note.
To show one of your notes on the MiniMap go to the Worldmap, left click on
a note and choose "Set As MiniNote".
To hide the note on the MiniMap, you can go to the WorldMap, left click and
choose "Turn MiniNote Off" or use the slash command /mininoteoff (/mno).

The MiniNote is turned off if the MapNote corresponding to it is deleted.
If you want a MiniNote without a MapNote use the /nextmininoteonly (/nmno)
slash command before creating the note.

[Send Notes To Other Players]
After clicking "Send Note" in the notes Menu the Send Menu will show up.

	1. Enter the name of the player you want to send a note to
			NOTE: Targeting the player before opening the WorldMap will auto
			insert the name.

	2. Send To Player
			Choose this option to send the note to the player entered above.
			NOTE: These notes can also be received by Carto+ users.

	3. Send To Party (requires Sky)
			This will send the note to the entire party. (No player name needs to
			be filled in.)

	4. Change Mode
			This toggles between Send To Player/Send To Party and Get Slash Command

	5. Get Slash Command
			Inserts a slash command in the editbox which can be highlighted and then
			copied to the clipboard.  After this you can post it on a forum or in chat
			and other MetaMap or MapNotes users can insert this note by copying the
			slash command to the chatline.

[Slash Commands]
/mapnote
    Only used to insert a note by a slash command (which you can create in
    the Send Menu), for example, to put a note at the Entrance of Stormwind
    City on the map Elwynn Forest:

    /mapnote c<2> z<10> x<0.320701> y<0.491480> t<Stormwind City> i1<Entrance> i2<> cr<Metahawk> i<0> tf<0> i1f<0> i2f<0>

    NOTE: The above would all be on one line

    Description of the identifiers:

        c<#> - continent number, based on the GetMapContinents() array on the
               English client
        z<#> - zone number, based on the GetMapZones() array on the English
               client
        x<#> - X coordinate, based on the GetPlayerMapPosition() function
        y<#> - Y coordinate, based on the GetPlayerMapPosition() function
        t<text> - Title for the note
        i1<text> - first line of text displayed under the Title in the
                   note (Info 1)
        i2<text> - second line of text displayed under the Title in the
                   note (Info 2)
        cr<text> - Creator of the note
        i<#> - icon to use for the note, AddOns/MetaMap/Icons/Icon#.tga
        tf<#> - color of the Title, AddOns/MetaMap/Icons/Color#.tga
        i1f<#> - color of the Info 1 line (colors as above)
        i1f<#> - color of the Info 2 line (colors as above)

/onenote [on|off], /allowonenote [on|off], /aon [on|off]
    Allows you to receive the next note, even if you have disabled receiving in
    the options.  If invoked with no parameters, it will toggle the current
    state.

/nextmininote [on|off], /nmn [on|off]
    Shows the next note created (using any method) as a MiniNote and also puts
    it on the WorldMap.  If invoked with no parameters, it will toggle the
    current state.

/nextmininoteonly [on|off], /nmno [on|off]
    Like the previous command, but doesn't put the note on the WorldMap.

/mininoteoff, /mno
    Turns the MiniNote off.

/mntloc tbX,tbY
    Sets a "Thottbot location" on the map. Use it with no arguments to toggle
    it off.

    X and Y are in "Thottbot coordinates" which can be represented as follows:

        local x,y = GetPlayerMapPosition()
        local tbX = math.floor(x*100)
        local tbY = math.floor(y*100)

    This note is not bound to the map you are currently on.  Left click on it
    and save the note to turn it into a standard note on the map you
    are viewing.

/quicknote [icon] [name], /qnote [icon] [name]
    Adds a note at your current location, icon and name are optional (icon any
    number from 0 to 9, AddOns/MetaMap/Icons/Icon#.tga)

/quicktloc xx,yy [icon] [name], /qtloc xx,yy [icon] [name]
    Addes a note on the map you are currently on at the given thottbot
    location, icon and name are optional (icon any number from 0 to 9,
    AddOns/MetaMap/Icons/Icon#.tga)


*******************************************************************************
                             DATA IMPORTS
*******************************************************************************
MetaMap will import data automatically for MapNotes, WoWKB, as well as importing
default Instance data from a provided file (MetaMapData.lua).

To import MapNotes data, simply run MapNotes once alongside MetaMap. Data will be
automatically imported, after which MapNotes can be removed.

To import WoWKB data, run WoWKB the once with MetaMap. Data will be
automatically imported, after which WoWKB can be removed.

Default data for MetaMap instance maps is also automatically imported on first
run. Once in, the MetaMapData.lua file in the MetaMap folder can be removed.

If for any reason you need to import data again, it can be done manually by
typing the following in the WoW message box:
For MapNotes: /script Import_MapNotes()
For WoWKB: /script Import_WowKB()
For Instance Data: /script Import_MetaMapData()

***IMPORTANT!*** After importing any WoWKB data, you MUST update the database to the
new format. Command for this is: /script MetaKB_UpdateDB()

NOTE that for MapNotes and WoWKB the respective addons must be loaded when running
the command. Instance data import requires the MetaMapData.lua to be in the MetaMap
folder.

There is an additional import routine for those wishing to import data for the
Knowledge Base from other users. There are certain requirements to
enable successful import:

1. The file to import must be named 'Import.lua' and must be placed in the
	 Interface\AddOns\MetaMap folder.
	 
2. The data header must be named 'MyKB_Data'. That would just be a simple matter
	 of changing the 'MetaKB_Data' in the normal SavedVariables file to that.
	 
To import, type this into the message box after login: '/script MetaKB_ImportFile()'

Note, that it will NOT import any entries which already exist


*******************************************************************************
                         ZONESHIFT CONVERSIONS
*******************************************************************************
Non-English clients have a different zone numbering than the English clients,
and thus need to map their zone numbers to the English ones.
In some cases you might need to convert from an incorrect ZoneShift to a correct
one. MetaMap provides a function for this.

IMPORTANT: Backup SavedVariables/MetaMap.lua BEFORE you call the function.

To convert from an invalid ZoneShift to the correct one:

Log in to WoW, then type: /script MetaMapNotes_ConvertFromOldZoneShift()


===============================================================================
                           VERSION HISTORY
===============================================================================
26 Nov 2005 - v1.0
	Initial Release

27 Nov 2005 - v1.1
	Added checks for existance of Titan Bar
	Added ReadMe to MetaMap folder
	Moved a few variables to the localisation
	Version number is now shown on the Options header
	
28 Nov 2005 - v1.2
	MozzFullWorldMap now fully supported
	French localisation added ( with thanks to Halrik for the translation)
	
29 Nov 2005 - v1.3
	Fixed error return in CT_MapMod when in Auto Gather mode by adjusting event handling.
	Tidied up a few other bits of code
	
30 Nov 2005 - v1.4
	MetaMap keybinding will now correctly toggle map on/off
	Fixed lockout of CT_MasterMod button when running MetaMapOptions from CT control panel
	Player location arrow no longer shows in instance maps
	Fixed incorrect filename in xml for French localisation
	German localisation added (with thanks to oneofamillion)
	Changed scaling routine to hopefully fix an issue on fullscreen for some - need feedback on this one
	
01 Dec 2005 - v1.5
	NEW: 	Map is now completely resizeable
	Removed full screen feature as this is now redundant
	NEW: Option sets now allow you to select between 2 saved mode settings
	Saved modes for Map opacity & Map size (set from options panel)
	Replaced the map 'Zoom' button with Option set toggle
	New keybinding for toggling between option set modes
	Escape key added for closing map. Even though the key binding works fine now.
	Added new menu options to TitanBar menu
	
07 Dec 2005 - v1.6
	Changed routines so features work correctly regardless how map is opened.
	Will now work fully with original map binding or icon.
	NEW: Map can now be moved around the screen with position saved between sessions.
	Each SaveSet will also store the respective position of the map.
	NEW: All keybindings are now useable, as well as messaging while map is open.
	This includes ability to open other windows while map is open.
	Added option to show/hide Gatherer Minimap icon.
	
08 Dec 2005 - v1.7
	Due to popular demand, a quick fix to keep the map on top of everything.
	Not a bad thing, as it does actually solve a few layering problems. :)

16 Dec 2005 - v1.8
	Completely recoded the options section.
	Options are now available from context pop-up menus.
	Optimised all other sections of code.
	I shall now be looking at starting version 2, adding user notes to all maps.

18 Dec 2005 - v1.81
	Oops. Removed the Gatherer button option but missed removing the actual routine.
	This meant that the Gatherer button would hide if you previously had it set off.
	Just a quick little fix for this. Was removed as the option for that is in Gatherer anyway.

26 Dec 2005 - v2.0
	NEW: MapNotes now integrated into MetaMap.
	...(All MapNotes features also extended to Instance maps).
	Fixed problem where a MiniNote set would cause main map to jump back to player location.
	Fixed Mininote not showing when entering a zone where it was set.
	Fixed occasional error in WorldMapFrame when updating the map for notes changes.
	Reworked notes menus for faster and easier access.
	CTRL + Left click on the map now opens the new note dialogue directly.
	Left click on a note now opens the edit note dialogue directly.
	...(More logical - doesn't change maps if slightly off target or forget to press alt).
	Options for notes are now enabled/disabled in the correct context.
	Added option to hide the author field in notes.
	Auto select option removed from MetaMap options.
	...(Will now always auto display correct instance map if you are in an instance) 
	Added option to set auto sizing of Tooltips.
	MozzFull re-instated to original location due to freeing up more space.
	Default POI option changed to 'Show Notes' option. Will show/hide all notes.
	Added display to show total notes and lines used per zone.
	Automatic conversion of default Instance POIs to user editable notes.
	...(MetaMapData.lua can be removed after first run)
	Automatic conversion of saved MapNotes data to MetaMap data.
	...(Requires MapNotes to be run once only alongside MetaMap)
	
26 Dec 2005 - v2.01
	Small correction for German and French users only. No need for others to download.
	...(Missed applying a data format change to the German and French localisations).

27 Dec 2005 - v2.1
	Additional compatibility checks added for CT_MapMod.
	New menu option to toggle between MapMod and MetaMap for note creation.
	...(Note creation for instances is still handled by MetaMap).
	Adjusted Minimap routines to handle left and right clicks correctly.
	Fixed the ThottBott/mntloc note conversions.
	
29 Dec 2005 - v2.2b1
	NEW: Integrated WoWKB code into MetaMap.
	Removed redundant code as well as adding option to turn off auto tracking.
	Automatice conversion of saved WoWKB data into MetaMap.
	...(Requires WoWKB to be run once alongside MetaMap to import).
	Added missing init routine to map mode keybinding toggle.
	
30 Dec 2005 - v2.2b2
	Added keybinding to manually target units for KB creation.
	...(This method also allows Player targeting. Active with AutoTrack on or off).
	Added highlighter to KB display for easier selection.
	Added solid background to KB options menu.
	Removed the Gatherer icon function which crept back in. :p
	Updated the Readme file to include description of all features and options.
	
03 Jan 2006 - v2.2b3
	Notes send menu now displayed on top.
	Fixed longstanding & infrequent Minimap error (old MapNotes bug).
	Changed format of KB from string parsing to a more solid and reliable format.
	...(Will auto update to new format on first run).
	Format of KB display is now in columns with better colour coding.
	KB notes are now created with a more logical colour coding.
	NEW option 'Add to Database' toggles on/off the database capture.
	NEW option 'Add new target note' toggles on/off auto adding of map notes.
	...(Can be over-ridden by <CTRL>+<Keybinding> combination).
	Tightened code and removed excess functions.
	Updated TOC to 1900 interface.
	
04 Jan 2006 - v2.2b4
	Emergency release to fix the scaling problems created by the patch changes.
	New notes are now created in the correct location.
	There is still a slight problem when switching between map modes but, that will
	take a little longer to sort out. More important to get this out quick to fix
	the notes placements.
	
07 Jan 2006 - v2.3
	NEW option to show a list on the side of all notes on the map.
	Clicking on an item in the list will ping its location on the map.
	Added additional entry to ping your own location on the map.
	Changed level display of high level mobs from '-1' to '??'.
	Cleaned up a few unwanted bits from the rushed out Beta 4.
	Corrected the TOC interface entry from 1900 to the correct 10900.
	
08 Jan 2006 - v2.4
	Added Zoneshift data for German clients. Read Zoneshift info below for usage.
	Tracked down occasional startup errors to missing init routine.
	...(Was introduced in init reformat back in v1.7)
	Removed map position saved variables & routines.
	...(Sorry, but the last patch totally changed the scaling behaviours and the
			saving of scaled positions is no longer possible. The Savesets will however
			still switch between different Alpha and Scaled modes.

11 Jan 2006 - v2.5
	NEW menu option 'Map Action Mode' places the map in a passive mode.
	...(All mouse actions pass directly through map for movement etc.).
	Added Action mode to Savesets so setting will be saved for each Saveset).
	Changed coords display routine to return accurate results.
	Changed map ping routine to place it more accurately on the icon.
	Notes editor now displays full alpha, regardless of alpha settings.
	...(Was a bit hard to see the options when transparent).
	Main coords display on the map now also display full alpha.
	Parts of the KB sorting are in place but not active as yet.
	...(Will be in next version. Thought it best to get these fixes out first).

17 Jan 2006 - v2.6
	NEW - Sorting of columns in KB database now implemented.
	...(Clicking the headers will change the sort order for the selected column).
	KB Search will now include all other columns when searching.
	Adjusted alpha of notes icons to always be slightly higher than map alpha.
	...(Makes them easier to see when alpha is way down).
	Added target distance checking to maintain location accuracy.
	...(Only adds targets within a 5yd distance. Suggested by Lindia).
	NEW - Keybinding pops up menu for setting a Quicknote or Virtual note(mntloc).
	NEW - Manual import facility added for MapNotes, WoWKB, and MetaMap data.
	...(This can then over-ride the auto import facilty if required for any reason).
	...(See reference notes for usage).
	MetaMap now correctly resets to the current zone when map is closed.
	...(Will set Minimap coords to the correct location instead of 0,0 for one).
	Fixed bug that would sometimes not load an instance map when auto selected.
	...(Only happened when the map was already set from a previous selection).
	Added sort routine to Instance dropdown to cover future additions or changes.
	NEW - Map of Temple of Ahn'Qiraj added. (Courtesy of WoWGuru.com).
	
28 Jan 2006 - v2.7
	Fixed error when capturing NPC/Mob with no tooltip information.
	No longer shows cursor coordinates when cursor is off the map.
	NEW - Target range now user definable in the KB options.
	NEW - Notes created on the Instance maps can now be sent to other players.
	...(Means you can now show other players your position in the instance).
	Added check for empty note fields in the KB database.
	..(Will add any missing info when you capture that target again).
	Reworked range calculations to give more accurate range colour code display.
	...(Will display green in the KB display if within 3 map units, otherwise yellow).
	Changed map coords display colours to be more user friendly.
	
28 Jan 2006 - v2.71
	Fixed Zoneshift error in the Notes List for German clients.
	
30 Jan 2006 - v2.72
	Fixed error with coloured text when sending notes to other players.
	...(Seems the WoW message system is a bit flaky when sending coloured text).
	Reworked the status print routines to minimalise output to the Chatframe.
	...(Turning off 'Show Updates' in the KB options results in virtually no output).
	
31 Jan 2006 - v2.73
	Hopefully fixes the BG issues some were having. Need feedback on this. :)
	NEW - Option to set the scale of Tooltips.
	...(Different Tooltip scales can be saved for each Saveset).
	
03 Feb 2006 - v2.74
	Battlegrounds well and truly fixed. Map notes and listings for there working.
	...(Was hard work - damn Horde kept creeping up on me and killing me).
	KB database now remembers sort order for the session.
	Added a debug mode. Toggle via  slash command ( /mmdebug ).
	...(Should be useful for checking zone names etc.).
	
26 Feb 2006 - v2.8
	NEW Option on Quicknote menu to include a MiniNote.
	NEW Option on QuickNote menu to set as MiniNote only.
	NEW Keybinding added for true fullscreen toggle mode.
	NEW A sample Tooltip is now displayed when adjusting Tooltip scale.
	NEW Search edit box is now dynamic. Display updates as you type.
	
27 Feb 2006 - v2.81
	NEW Map 'Ruins of Ahn'Qiraj' added.
	Side notelist now shows related Tooltips on MouseOver.
	RightClick on side notelist will now toggle the edit box for that entry.
	...(LeftClick will still ping the location for that entry).
	Mininote Tooltip now shows full note information.
	...(Just the start. I shall be optimising and enhancing Mininote stuff next).
	
28 Feb 2006 - v2.82
	Corrected the names for Ahn'Qiraj maps. Both will now display correctly.
	...(Managed to get into both tonight and discovered names were not quite right).
	
02 Mar 2006 - v2.83
	Fixed problem with instance map not selecting from dropdown.
	...(was setting incorrect value on newly added variable).
	Removed the double entry of real zone in debug display.
	NEW LeftClick on Minimap Mininote will now open edit options dialogue.
	...(Had already started to add some MiniNote changes so this bit not fully tested).
	
29 Mar 2006 - v3.0
	Corrected display of 'BlackOutWorld' added by Blizzard in latest patch.
	Toggling Fullscreen mode now retains currently viewed map.
	MetaMap menu no longer affected by alpha settings in Fullscreen mode.
	NEW KB data import facility.
	...(Imports data from a modified SavedVariables file).
	...(READ the import notes in the Readme for usage!).
	NEW MozzFullWorld has now been integrated into MetaMap as a Load on Demand.
	...(This means it will take up no memory unless called by selecting the option).
	...(Now referred to as MetaMapFWM - REMOVE MozzFullWorld to avoid clashes!!).
	Fixed overlay errors in FWM and added code to reflect changes in WoW's map routines.
	Removed FWM tickbox from map and added the option to MetaMap pop-up menu.
	Renamed 'round' function to something more unique to prevent future 'hi-jacking'.
	Updated French localisation. With thanks to 'Sparrows' for the translation.

29 Mar 2006 - v3.01
	Quick update to fix FWM not displaying explored areas under certain conditions.
