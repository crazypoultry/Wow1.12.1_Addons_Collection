
PartySpotter v3.10.11200 - Minor Release
-----------------------------------------

Small, standalone Modification that highlights which people on the WorldMap are in your Party, and which are in your Raid Group.

ALSO Allows you to target players by clicking on their Map Icons (or an individually Highlighted Player you can track via the Minimap)

Compatible with the WorldMap, AlphaMap(optional), BattlefieldMinimap, MetaMap(optional).

By default, players in different raid groups are displayed on maps with numbered Icons indicating their raid group, but 2 alternative modes are available :

1.) Each raid group can be displayed in a different colour.  Players can change the colours by Right-Clicking on that Group's button on the Map Key (Map Legend).  Group Headings in the Raid Frame, and Raid Pullout Frames are also coloured to match the on map dots.  There is also an option to change the colour of BattleGround and Raid messages from Raid members to match the PartySpotter colour for that Group. (/pspot -c)

2.) OR Simply have your local Party showing as one colour (default Blue), and all other Raid/Battleground members as another colour. Nice and simple to track your Party if you don't NEED to track all parties separately.

NOTE : To take full advantage of this AddOn's features, don't forget to use the provided Key bindings to cycle through the main modes :)

When in a Raid, then chat from other Raid members will be prefixed by their Group number. (Toggle with '/pspot -n')

You can Highlight particular Raid Groups on the map to make them easier to find/track by left-clicking on a group number on the Map Key. While highlighted, player tooltips on the map will only list players in the highlighted group, and player targetting by clicking on the Map dots will only work for members of the highlighted group.

EXTRA Features include the ability to highlight friends, ignores, guild members, the raid leader, or any individual player you specify, as long as they are in the same party/raid, or in the same BattleGround.
Added a "Highlight" option to the Right-click menus for Player/Party/Raid Popups. So, for example, you can now Right-Click on a Player's Portrait, or their name in the Raid window, and choose the "Highlight" option, and they will appear on the Map with a Red "X" so that you can locate/track them.
Highlighted Individuals are can also be tracked via a Red "X" icon on the Minimap.

USE   "/pspot"   FOR A STATUS REPORT AND A FULL LIST OF SLASH COMMANDS.

Please Note :
a.) You can't make the PartySpotter key visible unless you are in a Party/Raid/Battleground, so Toggling the PartySpotter Map Legend with the key-binding won't appear to do much at all if you are sitting on your own in Orgrimmar ;p
b.) Coloured Raid Headings and Chat are only available when you are viewing each Raid sub-group with differently coloured icons, and not when using the default Numbered Icons, or just showing other raid sub-groups in a single colour.

Developed mainly because in BattleGrounds, EVERYONE is represented with the same default Yellow Icon, and you can't tell who you are grouped with easily.

Localisation : German, French.
(Couple of Version 3 options not yet localised)



----------------------------------------
Full Feature List for Version 3.10.11200
----------------------------------------

Version 3 should work with ALL clients.

Note: where ever I say "Map Key", you can substitute "Map Legend" if you are more familiar with that terminology ;)

- Default shows each sub-group in a Raid as a numbered icon, showing exactly which sub-group it belongs to   (/pspot showgroups numbers)

- OR can now show each sub-group in a Raid as a different colour  (/pspot showgroups icons)  { See the "What Colour Group am I in?" section of the PartySpotter Readme.txt file }  You can change the colours of any groups by RIGHT-CLICKING on the Map Key for that group and changing via the standard WoW Colour Picker frame.

- OR turn off sub-group highlights and use simple version 1 functionality to highlight your Party in one colour, and all other Raid members in another colour (/pspot showgroups off)

- PartySpotter Icons now show on BattleField MiniMap

- PartySpotter Icons now show on AlphaMap         : For full compatibility, AlphaMap must be updated to "AlphaMap (Fan's Update)"
PartySpotter does have limited support for original Alphamap (but must be in a Party/Raid before you will see any unit icons within BattleGrounds.)

- A PartySpotter Map Key visible on the WorldMap or AlphaMap/BattlefieldMinimap when in a Party/Raid, showing which icons/colours represent which Raid Groups.

- Left Click on a particular Raid Group on the PartySpotter Map Key to highlight that Group on the WorldMap/AlphaMap/BattlefieldMinimap and make sure it becomes visible if it was previously obscured by other player icons. All other PartySpotter icons will be hidden and revert back to the small default yellow dots, while the highlighted group will be displayed with a Numbered Icon. Click on the same group again to stop highlighting a particular group.
While highlighted, player tooltips on the map will only list players in the highlighted group, and player targetting by clicking on the Map dots will only work for members of the highlighted group.

- Right Click on a particular Raid Group in the Key to change the Colour that will represent that group on the Map

- The PartySpotter Map Key is draggable, and will remember where you last positioned it. (The WorldMap and AlphaMap/BattlefieldMinimap map keys are independant of each other. Note that there is one key for use with both the AlphaMap & Battlefield minimap. Once moved, then it becomes independant from these frames, but it will only show when you have one or the other open.)

- You can use a Key Binding to toggle Show/Hide of the Map Keys for when you don't need to see them

- Messages from Raid/Battleground members will now be Prefixed with the number of the Raid Group they belong to e.g. "[4] "
Toggle this with the  "/pspot -n"   command

- When viewing Coloured Map Icons, the Group Labels in the Raid Frame, and the headings of Raid Pullout frames will also be changed the same colour as the that group's on map icons.

- When viewing Coloured Map Icons, there is an additional option to change the colour of BattleGround/Raid messages to the colour you have specified for that Group's on map icons. Coloured Battleground/Raid messages are marked with an "*", so the example message prefix above would become "[4]*" and the message would be the same colour as that group's icons. (Whispers, Yells, Says, etc.  will not have their colours changed but will still be prefixed by a Group number)

- Highlights of Friends/Ignores/Guild should take priority over other icons, so if you can't find a particular unit/group, make sure you disable Friend/Ignore/Guild highlighting

- Can now highlight the Raid Leader when you are in a Raid   "/pspot -L" toggles this function

- Can now highlight an individual player, so that you no longer have to mouse over lots of units to find a single unit    "/pspot -t <name>"

- Highlighted Individuals can be tracked by a Red "X" icon on the Minimap.

- In addition to a slash command, players can now highlight individual players via an additional "Highlight" option in the Right Click menus for Players/Party/Raid members
(Highlight the same player again to stop highlighting them)
For example this means you can target a player, and Right-Click his Portrait, and select "Highligh", to show his on map Icon as a Red Cross display a tracking Icon on the Minimap.

Should be compatible with ALL Clients.
Please e-mail me if you find this AddOn is or is not compatible with a certain client.

Welcome any and all help with localisation of the few English words used :)

( This AddOn only needs to be installed on your machine to work and display other party members/raid members correctly.  i.e. it does NOT need to be installed on other member's machines for you to see them with a different coloured icon. Obviously, they can install it as well, and they will then see you displayed with a different colour ;)




IMPORTANT KEY BINDINGS INTENDED AS THE MAIN / EASIEST WAY TO CHANGE PARTYSPOTTER BEHAVIOUR
------------------------------------------------------------------------------------------

- Added key binding to cycle through the main PartySpotter modes
1.) Show Differently Coloured Raid sub-groups
2.) Show Numbered Raid sub-groups
3.) Show All Other Raid sub-groups in the same colour

- Added key binding to cycle through the PartySpotter highlighting functions
1.) Friends
2.) Ignores
3.) Guild mates
4.) No Highlighting

- Added key binding to Show/Hide the Map Keys




Slash Commands
--------------

/pspot        : Displays the status of PartySpotter, and this list of Commands

/pspot 0      : Disable PartySpotter  (i.e. /pspot followed by a zero)

/pspot <1 - 9>  : Enable PartySpotter and set the delay between WorldMap Updates in seconds. (It is possible to use a decimal point and set this vaue to 0.5, or 3.6 for example)  Default value at install is 1.

/pspot showgroups icons : If in a Raid, then people in different sub-groups will be represented by different coloured icons

/pspot showgroups numbers : If in a Raid, then people in different sub-groups will be represented by icons clearly marked with their group number

/pspot showgroups off : If in a Raid, then people in different sub-groups will be represented by the same Orange icon. Your local Party/group members are still highlighted differently as Blue

/pspot showfriends	: to TOGGLE the highlighting of Friends

/pspot showignores	: to TOGGLE the highlighting of Ignores

/pspot showguild	: to TOGGLE the highlighting of Guild mates

/pspot -l		: to TOGGLE the highlighting of your Raid leader (Marked by a Red "1")

/pspot -t <name>	: will highlight the specified individual, so that you don't have to mouse over lots of icons to find one single person (Marked by a Red "X")

/pspot -t		: leaving the name blank, will cancel the highlighting of any individual player

/pspot -c		: to TOGGLE coloured BattleGround/Raid messages when showing different coloured map icons

/pspot -n		: to TOGGLE Raid Group Numbered Chat Messages

/pspot reset : reset all defaults, and anchor the map keys to the default map positions




What Colour Group Am I In ?
---------------------------

Whether you are in a Party, or Raid, your local Party/Group Members are ALWAYS displayed with a Blue Icon.

If you are moved to a different sub-group within the Raid, then that group becomes represented by the Blue Icon, and the colour of the other sub-groups is shifted to accommodate this.  The PartySpotter Map Key will always show which Raid sub-group your local blue icons belong to, and which of the other sub-groups are represented by which other icons.

If you change the default Blue colour for your Party, for example to White, then your Party will ALWAYS be White.  Your Party is also easily identified because it is the only one to the right of the numbers on the Map Key.


Performance
-----------

I could find no drop in frames per second (fps) caused by PartySpotter, and the memory footprint is less than 0.25Mb

Call it blatant self promotion, but during my performance testing, I also found that using  "AlphaMap (Fan's Update)"  resulted in a smaller drop in fps, than using Blizzard's BattlefieldMinimap.
( And significantly less of a performance hit than the WorldMap (MetaMap). )





Change History
--------------

Changes in v3.10.11200 from v3.00.11200
---------------------------------------

- numbered Raid Group chat messages are now optional. Toggle with the  "/pspot -n"  command.




Changes in v3.00.11200 from v2.52.11200
---------------------------------------

PLAYER TARGETTING
-----------------
Can now click on a Player Dot on the Map to Target that Player. (Perfect for targetting your Warsong Flag Carrier).
If there are multiple players in the same location, then repeated Clicks will cycle through the names displayed in the tooltip, targetting each in turn. So, for example, if you move your mouse over a PartySpotter Icon, and the tooltip shows that there are 5 people in the same location and you wanted to target the fourth one, then click 4 times and you should be targetting the player you wanted. This functionality comes with 2 small warnings :

Firstly, people can be moving around and move out from under your mouse, in which case you won't target them ;p

Secondly, there are sometimes MANY people in the same location, and I'm aware its not practical to click 18 times to find one person in a mob of 22 players, but that's what the Raid Frame is for ;)

PLEASE NOTE : If you Highlight a Raid Group (by Left Clicking on a Group number on the Map Key, then you will only see Tooltips for members belonging to the Highlighted Group, and Left-Click Targetting of the on-map Icons will only select from members of the Highlighted Group. So, for example, if you are trying to click on one guy in a mass of 22, then if you know their Raid group, you can highlight it via the Map Key, and when you mouse over the player icons you will see a maximum of 5 player names in the Tooltip that you can target. i.e. the five members of that highlighted Raid group.

(You can also target individual players highlighted with a Red "X" by clicking on their new Minimap tracking Icon - see the section below on CHANGES TO SINGLE PLAYER HIGHLIGHTING)


COLOURED RAID GROUPS
--------------------
Raid group numbered icons are now the default mode for new users, however, if using the coloured icon mode, then you can now change the colours used to mark the different Raid Groups, including the colour for your own Party. You can access the standard WoW Colour Picker frame to change a dots colour by Right-Clicking on that group's button on the Map Key.
Your Party will always be marked with the same colour (default of blue), even if you change the default - please see the "What Colour Group Am I In ?" section of the readme.txt file for details.

(When in Basic viewing mode, where all the other raid groups apart from your party are represented by the same colour, the colour used is the same as the one used for Group 1 when viewing each group with different colours; So changing the colour used to represent all other groups in Basic viewing mode, will also change the colour used to represent Group 1 when showing groups with different colours.)

When using different coloured dots to represent the Raid Groups, the colours of the group headings in the Raid Frame, and group Raid Pullout Frames, will also be coloured as per the PartySpotter group colours.


CHANGES TO CHAT
---------------
PartySpotter will now prefix messages from members of your Raid/Battleground with the number of the group they are in e.g. "[4] "
When using different colours to represent the Raid Groups, you also have the option to change the colour of BattleGround/Raid messages to match the PartySpotter colour for that group. Messages coloured by PartySpotter are flagged by an extra "*". So the above example prefix above would become "[4]*".
PartySpotter will not change the colour of Whispers/Yells/Says/etc.  only Raid/Battleground messages
"/pspot -c"  toggles this option
Basic compatibility testing carried out with ChatMod and no problems found so far - let me know if you find any issues.


CHANGES TO GROUP HIGHLIGHTING
-----------------------------
When you Left-Click on a Group on the PartySpotter key, then that group will be represented by Numbered Icons on the map, and all other players will revert to the standard small yellow dots. Obviously, I still ensure that the dots for players in that group are shown above other dots that may have been hiding them. This should make it much easier to highlight the members of a particular group.

As mentioned above in "PLAYER TARGETTING", when you highlight a particular Raid Group, then you will only see Tooltips for members of that Group when you mouse over player icons on the maps, and you will only be able to Target players in the Highlighted group.


CHANGES TO SINGLE PLAYER HIGHLIGHTING
-------------------------------------
Added a new "Highlight" option to the Right-Click Popup Player/Party/Raid menus.  i.e. the menus that appear when you Right-click on player portraits, or individual Raid buttons on the Raid frame.  Using this Highlighting option is the same as using the "/pspot -t <player name>" slash command and will show that player on the map with a Red "X".  Highlighting the player again, will cancel the highlighting.

Highlighted Players can be tracked via a Red "X" icon guide on the Minimap, which can be clicked on to Target that player.
(Note this should work on ALL Clients within Battlegrounds;  But may require localisation work to accurately plot player positions outside of Battlegrounds : Only French and German included so far.  Functionality shamelessly 'borrowed' from Gatherer, which shamelessly 'borrowed' from MapNotes, except for some Battleground tweaks I added)


CHANGES TO MAP KEY BEHAVIOUR
----------------------------
New Key Binding that will Show/Hide the Map Keys, so you don't have to look at them if you don't use them often.

Slightly reduced the size of the PartySpotter map keys.

The Map Key displayed on the World Map can be dragged around (click-drag the "PartySpotter Key" text), and will now reattach itself to the World Map when you drop it - i.e. probably only impact people who use AlphaMap or MetaMap to change the scale of the World Map, and who want to re-position the key, and still have it move with the Map when they move the Map itself.

The Map Key originally provided for AlphaMap (which is separate to the WorldMap Key), is now designed for use with the Battlefield Minimap or AlphaMap, and will display when either one is open. In other words, people who use the Battlefield Minimap will not need to open the World Map (or AlphaMap) to access a PartySpotter key.


PERFORMANCE IMPROVEMENTS
------------------------
PartySpotter is now more event driven, and for this reason, I have changed the default length of time between automatic background updates to 10 seconds. If for some reason, you believe there is a long delay (e.g. 10 seconds) before you notice changes to groups or highlighting on the map, then you can use the "/pspot 1" command to make PartySpotter update its icons once every second - as per the old functionality. If no one has any problems with long delays before changes affect the icons, then I plan to phase out automatic updates altogether.
"/pspot 0" will still disable PartySpotter, and "/pspot #" where # is a number between 1 and 10 will turn PartySpotter back on with that number of seconds between automatic background updates.


MISCALLANEOUS
-------------
- made the WorldMap and AlphaMap icons slightly larger, and the BattlefieldMinimap icons slightly smaller.

- made sure the PartySpotter Keys are hidden when you leave a Raid/Party

- prevented the "You are not in a guild" message that appears at log in for players who..........are not in a guild ;)

- fixed a bug that would occur when using different coloured Raid group icons, and highlighting your own group



Changes in v2.52.11200 from v2.52.11100
---------------------------------------

- Simply a .toc update


Changes in v2.52.11100 from v2.52.11000
---------------------------------------

- simply a toc update


Changes in v2.52.11000 from v2.51.11000
---------------------------------------

- "/pspot reset" now stops the highlighting of Raid Leaders and any individually highlighted player


Changes in v2.51.11000 from v2.50.11000
---------------------------------------

- Completed French Localisation


Changes in v2.50.11000 from v2.10.1900
--------------------------------------

- added a new "/pspot -l" command allowing the Raid leader to be highlighted
- added a new "/pspot -t <Player Name>" command allowing an individual player to be highlighted
- updated for the WoW 1.10 patch
- fixed a bug that prevented group/party icons displaying when players are in different map zones


Changes in v2.10.1900 from v2.03.1900
-------------------------------------

- added a "/pspot reset" command to restore defaults and anchor map legends to default map locations
- fixed a memory leak issue which should improve performance


Changes in v2.03.1800
---------------------

- Version 2.01.1800 with French Localisation added.


Changes in v2.02.1800
---------------------

- Version 2.01.1800 with German Localisation added.


Changes in v2.01.1800
---------------------

- Fixed a problem when re-logging while already in a Raid group
- Prevented the display of the AlphaMap map-key when AlphaMap AddOn is not present


Changes in v2.00.1800
---------------------

- See Advanced Features section above for all changes made for Version 2


Changes in v1.01.1800 from v1.00.1800
-------------------------------------

- German Localisation of version 1.00




Contact
-------

telic@hotmail.co.uk