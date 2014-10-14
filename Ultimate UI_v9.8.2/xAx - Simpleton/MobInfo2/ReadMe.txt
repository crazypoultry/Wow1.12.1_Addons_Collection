
MobInfo-2 is a World of Warcraft AddOn that provides you with useful additional information about Mobs (ie. opponents/monsters).
It adds new information to the game's Tooltip when you hover with your mouse over a mob. It also adds a numeric display of the Mobs health (current and max) to the Mob target frame. MobInfo-2 is the continuation of the original "MobInfo" by Dizzarian combined with the original "MobHealth2" by Wyv. Both Dizzarian and Wyv sadly no longer play WoW and stopped maintaing their AddOns. I have "inhereted" MobInfo from Dizzarian and MobHealth-2 from Wyv and now continue to update and improve the united result. 

[[ IMPORTANT NOTE FOR DEVELOPERS OF OTHER ADDONS:               ]]
[[ Please read the informatin in "ReadMe_External_AddOns.txt" ! ]]

*** MobInfo-2 Features ***

MobInfo adds a wealth of useful information to the game tooltip for all Mobs. It also adds what is known as "MobHealth" info the the Mob target frame. This is the numeric display of the targets current and maximum health. Since this is not available from the game engine as a number it has to be calculated and estimated based on damage figures reported during a fight. It takes about 2 to 3 fights to get an accurate display of health figrues for a specific Mob (please refer to "ReadMeMobHealth.txt" for detailed info on the inner workings of health calculation).

The extra information available to show on the ToolTip is:

Class - class of current selected mob
Health - current health and total health of the mob
Damage - min/max damage range of Mob against you (stored per char)
Kills - number of times you have killed the mob.
Total Looted - number of times you have looted the mob.
Empty Loots - number of times you found empty loot on the mob.
XP - actual LAST xp amount you gained from the mob
# to Level - number of kills of this mob neede to gain a level
Custom Items - add custom items to track drops frequency from mobs
Quality - the quality of items that are dropped by the mob
Cloth drops - the number of times cloth has dropped on the mob
Avg Coin Drop - average amount of money dropped by the mob
Avg Item Value - average vendor value of items dropped by mob
Total Mob Value - total sum of avg coin drop and avg item value

Mob data is collected and stored (in a database) separately per Mob and per Mob level. This is also what normally gets shown in the tooltip. There is, however, a special so called "Combined Mode" which displays the combined data for all levels of one Mob name in a combined tooltip. Note that the data still gets stored separately as usual. It only gets added up for display int he tooltip.

MobInfo-2 features an independant mechanism for obtaining item sell prices, based on the famous Auctioneer. MobInfo now supports and uses Auctioneer for getting item sell prices. For those cases, where MobInfo is used on a client without Auctioneer, the Auctioneer item prices table has been integrated into MobInfo. Many thanks to the great Norganna for suplying this fantastic table !


*** How to Install ***

Unpack the ZIP file and copy the folder "MobInfo2" into your "World of Warcraft\Interface\AddOns" folder. Now check if you have a separate "MobHealth" AddOn installed. If so please remove it, or at least disable it. You will find that it is no longer needed, because MobInfo-2 is a full featured and fully compatible replacement. MobInfo-2 will automatically load the next time you login with one of your chars.


*** MobInfo Configuration ***

"/mobinfo2" (or /mi2 for short) will open the configuration dialog window. In here all ToolTip items explained above can be turned on or off individually. Note that if there is no data available in the database for an item it will not be shown, even if enabled. The configuration dialog has separate sections for the Tooltip and the Health display option. All options are interactive and take effect immediately. Hovering over an option with the mouse will display help information for the option in the game tooltip window.

In the configuration dialog you can choose what data to store permantly: only the data for the items you have enabled, or all data including that for disabled items (I recommend storing all data). Another option is "clear data on exit" which will not store anything permanently: MobInfo data gets discarded entirely when you log out with your char.

"/mi2 help" will show all slash commands that mobinfo supports. There is one slash command for each option in the options dialog. There is an extra slash command "/mobinfo clear" which will instantly purge (clear) the entire MobInfo database. This has not been placed in the options dialog to prevent accidental loss of all MobInfo data.


*** Compatibility Notes ***

The newest version 2.1 and above of MobInfo-2 strives to replace the existing "MobHealth" AddOn with built-in functionality. I have taken great pains and invested alot of effort to make the built-in MobHealth functionality 100% compatible to the separate AddOns, namely "Wyvs MobHealth2" and "Telos MobHealth". The same data is used and stored. The same functionality is available to other AddOns. No data gets lots. All existing data gets preserved and used. MobInfo is a full replacement with (hopefully) full compatibility.

Update:
Recently one incompatibility has been detected. The built-in MobHealth support of the MobInfo AddOn is incompatible with the Archaeologist AddOn. Sadly I have no chance to fix this. I have asked the author of Archaeologist to add MobInfo support.


*** Soon to Come ***

New features that I plan for the next releases:
 - fix all bugs that get reported (as always)
 - database search by Mob value
 - track spell immunities and show them in tooltip
 - support for KC_Items, maybe also ItemsMatrix
 - option to change font size for health display
 - check and fix compatibility issues with some more AddOns
 - (LATER!) option to unite the now separate MobInfo and MobHealth databases to save space and performance

MobInfo-2 Version History: 

2.23
  - fixed kill counting for Mobs without XP (wasnt working)
  - fixed show tooltip on Alt (wasnt working)
  
2.22
  - fixed a nil bug related to running an external MobHealth
  - disabled a debug message that managed to sneak in

2.21
  - fixed nil error some got for optValue in MI2_Slash
  - fixed the buttons for All On, Default, etc 

2.2
  - new feature: display mana values in target frame
  - new feature: option to display health/mana percent
  - new feature: more health/mana position options
  - updated French translation (thanks Sasmira!)
  - fixed: occasional Health without value in tooltip
  - restructured slash command handling, chat feedback now translated
  - full integration of MobHealth slash commands (had to rename them)
  - changed names of some slash cmnd options

2.12
  - show separate MobHealth found warning only once
  - event handling code restructured
  - slight compatibility improvement with DUF
  - added documentation: ReadMe_External_AddOns.txt

2.11
  - separate MobHealth existance check fixed

2.1
  - integrated MobHealth-2 into MobInfo
  - added option to disable built-in MobHealth
  - slash commands changed to /mobinfo2 and /mi2
  - added help texts to all options in options dialog
  - redesigned options dialog and integrated MobHealth options

2.0
  - beta testing release of new 2nd generation MobInfo

(for previous version info or any questions regarding MobInfo-2 please visit http://www.dizzarian.com/forums/viewforum.php?f=16)
