MobInfo-2 is a World of Warcraft AddOn that provides you with useful additional information about Mobs (ie. opponents/monsters). It adds new information to the game's Tooltip whenever you hover with your mouse over a mob. It also adds a numeric display of the Mobs health and mana (current and max) to the Mob target frame. MobInfo-2 is the continuation of the now abandoned "MobInfo" by Dizzarian combined with the original "MobHealth2" by Wyv. 

[[ IMPORTANT NOTE FOR DEVELOPERS OF OTHER ADDONS:           ]]
[[ Please read the informatin in "ReadMe_MobInfo_API.txt" ! ]]


*****************************
***     MobInfo-2 Data    ***
*****************************
MobInfo collects data whenever you fight a Mob. It starts off with an empty database, which fills up automatically the more you fight and play. The data it collects is used for enhancing the game tooltip and the game target frame. It is also available to other AddOns (mostly the mob/target health values).

NEW FEATURE: The MobInfo database has become searchable. You can do a search for the 12 most profitable Mobs. You will find the "Search" button on the "Database" page of the options dialog.


******************************************
*** Extra Information For Game Tooltip ***
******************************************
The extra information available to show on the game tooltip is:

Class - class of mob
Health - current and total health of the mob
Mana - current and total mana of the mob
Damage - min/max damage range of Mob against you (stored per char)
DPS - your DPS (damage per second) against the Mob (stored per char)
Kills - number of times you have killed the mob (stored per char)
Total Looted - number of times you have looted the mob
Empty Loots - number of times you found empty loot on the mob
XP - actual LAST xp amount you gained from the mob
# to Level - number of kills of this mob neede to gain a level
Quality - the quality of items that are dropped by the mob
Cloth drops - the number of times cloth has dropped on the mob
Avg Coin Drop - average amount of money dropped by the mob
Avg Item Value - average vendor value of items dropped by mob
Total Mob Value - total sum of avg coin drop and avg item value

Note that MobInfo offers a "Combined Mode" where the data of Mobs with the same name that only differ in level gets combined (added up) into one tooltip. This mode can be enabled through the options dialog


***************************************
*** Target Frame Health/Mana Values ***
***************************************
MobInfo can display the numeric and percentage values for your current targets health and mana right on the target frame (formerly known as MobHealth functionality). This display is highly configurable through the MobInfo options dialog (position, font, size, etc).


******************************
*** MobInfo Options Dialog ***
******************************
Type "/mi2" or "/mobinfo2" on the chat prompt to open the MobInfo2 options dialog. This dialog gives you full interactive control over EVERYTHING that MobInfo can do. All options take immediate effect. Simply try them all out. Decent defaults get set when you start MobInfo for the first time. Note that the 3 main categories "Tooltip", "Mob Health/Mana", and "Database Maintenance" have separate dedicated options pages within the options dialog.

Note that everything in the options dialog has an associated help text that explains to you what the option does. The help texts are shown automatically as a tooltip.

**NEW FEATURES** : Have a look at the "Database" page of the options dialog. Several new features have been added here, like "Clear" buttons and a "Search" button for finding the most profitable Mobs.


**********************
*** How to Install ***
**********************
Within the ZIP file you find a folder called "MobInfo2". This folder has to be copied into the folder "World of Warcraft\Interface\AddOns\". Thus you should end up with a folder called:

World of Warcraft\Interface\AddOns\MobInfo2

Now log into your WoW account. On the char selection screen you should see in the bottom right corner a button called "AddOns". Clicking this button opens the AddOn management window of WoW. You can enable or disable AddOns in here. MobInfo should be in the list of AddOn and should have a "Tick" mark to say that it is enabled. Now exit the AddOn window and log into the game with one of your chars. At the chat prompt simply enter "/mi2" to get the MobInfo options window. This options window allows you to fine tune MobInfo to your personal preferences. Note that by default it is already enabled with a set of sensible defaults.

When starting the first time you might get a message that a separate MobHealth AddOn was detected. If so please remove it, or at least disable it. You will find that it is no longer needed, because MobInfo-2 is a full featured and fully compatible replacement. 

To actually see MobInfo do something you must now go and kill Mobs. While killing Mobs you will see their health appear in the target frame and after killing and looting the Mobs you will see Mob informaton appear in the tooltip for the Mob. 


*******************************************
*** How to Backup your MobInfo database ***
*******************************************
It is very IMPORTANT to make occasional (even better: regular) backups of your MobInfo database. I have received several reports of users where due to whatever likely or unlikely incident the original MobInfo database got lost or erased or erased or currupted. It is unlikely and happens only very rarely, but when it happens your only chance to recover is to have a backup of the MobInfo database.

The entire MobInfo database is contained within this onr file:
   World of Warcraft\WTF\Account\<your_account_name>\SavedVariables\MobInfo2.lua

First of all please logout of WoW. This automagically saves all current AddOn data to disk. Then make a copy of the database file (the one specified above) to a save location. To restore the backed up data simply copy the backup file back to the original location.

Side note: this is also the file that you must pass on if you want to give your MobInfo database to someone else. Which of course means it is also the file you receive when someone else gives you their MobInfo database.


**********************************************
*** IMPORT of an External MobInfo Database ***
**********************************************
MobInfo can import externally supplied MobInfo databases. This can be a database from a friend of yours or a database that you have downloaded somewhere. WARNING : the database that you import MUST be from someone who uses exactly the same WoW localization as you do (ie. the same WoW client language). Importing a MobInfo database rom someone using a different WoW language will NOT work and might destroy your own database.

First of all before importing data you should make a backup of your own database. This is explained above in the chapter "How to Backup your MobInfo database". It never hurts to be able to restore your original data in case you are unhappy with the import result. 

Here are the detailed import instructions:

1) Close your WoW client

2) Backup your MobInfo database as explained above

3) Rename the database file that you want to import from "MobInfo2.lua" to "MI2_Import.lua"

4) Copy the file "MI2_Import.lua" into this folder:
\World of Warcraft\Interface\AddOns\MobInfo2\
(that is the folder where the AddOn has been installed)

5) Start WoW and login with one of your chars

6) Open the MobInfo options (enter "/mi2" at the chat prompt) and go to the "Database" options page. Near the bottom of the page you should now see whether the AddOn has found valid data to be imported. If you did everything correctly the "Import" button should be clickable.

7) Choose whether you want to import only unknown Mobs, otherwise all Mobs will get imported. If a Mob already exists in your database and you choose to import it the data of the new Mob will get added to the data of the existing Mob. Now click the Import button to star the database import operation. In your normal chat window you will see a summary of the import results.

8) Logout to cause WoW to save your now extended MobInfo database file. You should now delete the file "MI2_Import.lua". It is no longer needed and it will waste memory as long as it exists.

TIP : use the "import only unknown Mobs" if you know that there is a large amount of overlap between your current database and the imported database. For instance if you import data from the same source again (because he released a newer version).

TIP2 : You can also use this Import feature to import databases of the "MobHealth" AddOn. Use the instructions exactly as listed above, but in step 2 rename "MobHealth.lua" (the MobHealth database file from "savedvariables" folder) to "MI2_Import.lua".


*****************************************
***  Conversion of DropRate Database  ***
*****************************************
The integrated DropRate converter can convert the contents of a DropRate database into MobInfo database entries. Yet in order for the converter to work an additional item database must be installed. THIS IS ABSOLUTELY MANDATORY !

Right now the DropRate conversion supports the following item database tools: ItemSync (from Derkyle), LootLink and LootLink Enhanced (from Telo and Brodrick) and KS_Items (from Kaelten). You MUST have one of these AddOns installed and you MUST have a sufficiently large database. Why is this so important ? Because DropRate recorded only the item names, which is highly inefficient. All modern tools use instead mainly the item ID code. Yet name to code conversion is tricky, because the WoW client does not support this. Instead an item database is required that knows item names and that can convert a given item name into an item ID code. The AddOns that MobInfo currently supports all offer this feature.

Using LootLink is recommended for the conversion because AddOns sites like "http://ui.worldofwar.net" host huge downloadable LootLink item databases that ensure a high conversion success rate. After successful conversion LootLink (or any other item database tool) can be uninstalled, if you dont want to keep it.

Note that whenever the item database AddOn does not know an item from the DropRate database this item can NOT be converted into the MobInfo database. Therefore Mobs with unknown items can only be partially converted. The unknown items will be missing from the Mobs when looking at their MobInfo data.

Here is how to make the conversion:

1) You must have the following AddOns installed and active: MobInfo, DropRate, and either ItemSync, LootLink or KC_Items. I'd like to mention that I made all my tests with ItemSync and it worked very well.

2) Backup your MobInfo database as explained in the "How to Backup your MobInfo database" chapter. Similarely backup your DropRate database. The conversion will modify both databases ! Therefore it is very important to have backups of the originals so that you can go back to the state before the conversion, in case you encounter a problem, or in case you are not happy with the result

3) To start the conversion enter "/mi2 convertDropRate" at the chat prompt. The conversion result will appear in the standard chat log window.

4) Logout from WoW to make WoW save your modified database files.

5) Now have a look at the file "savedvariables/DropRate.lua" (this is the DropRate database in the "savedvariables" folder). This database has been modified by the converter. All data that was converted successfully has been removed from the database called "drdb". All entries that still exist in "drdb" represent data (Mobs or other stuff) that the converter has not converted. Non Mob data will always remain because MobInfo does not support this (chests, mining, etc). If Mobs remain it means that the Mob references unknown and thus unconvertable items.

6) If the conversion result is OK you can simply leave things as they are. If very many items were not converted then you should try to obtain a larger items database and start the conversion again from step 3. You can repeat the conversion as often as you like because the converted removes all successfully converted data from the DropRate database.

NOTE: During normal game play you should NEVER (!) have both DropRate and MobInfo running. Doing so will result in incorrect data when you start the converter. Both AddOns will record the same data and starting the converter will copy the DropRate data into the MobInfo database, which will incorrectly double some of the data for the Mob. You should ONLY have both AddOns active at the same time for the purpose of doing a conversion.

7) If the conversion encounters an error, or in case you are unhappy with the result of the conversion, please use the backups you made in step 2 to go back to your previous databases. To restore your databases you MUST first exit WoW. Then simply copy the backups of "MobInfo2.lua" and "DropRate.lua" into your "savedvariables" folder. Start WoW again and you should have your old data back. Please observe the NOTE above and NEVER play with MobInfo and DropRate active at the same time.




***-----------------------------------------------***
***-----------------------------------------------***
      F. A. Q. - Frequently Asked Questions
***-----------------------------------------------***
***-----------------------------------------------***


******************************************************
** Where do the Mob health values come from ?
******************************************************
WoW itself does not allow AddOns to see the numeric health value of a Mob or other players. Instead WoW reports only a percentage value. To obtain a real maximum health value this value must be calculated, or more correctly approximated. That iss what MobInfo does. In order to do this you must fight the creature. During the fight the damage you do is reported as actual damage points. The current health of the Mob is reported as percentage values. From these values MobInfo calculates how much damage you are causing per percent change in health. The damage done per percent times 100 is the Mobs maximum health.

The method described above for approximating a Mobs health was first developed by "Telo" for his AddOn "MobHealth". It was then refined by "Wyv" for his own AddOn "MobHealth2". The MobInfo implementation stil is based on the same basic principle but uses a drastically improved mathematical approach.

******************************************************************
** How do I change tooltip position or tooltip popup behaviour ?
******************************************************************
MobInfo only adds information to the tooltip, but it does not modify where or how the tooltip appears. To change this there are a large number of real good tooltip controll AddOns available. I can't list them all here, but some of the better and more popular ones are: TipBuddy (http://ui.worldofwar.net/ui.php?id=607), AF Tooltip Extreme (http://ui.worldofwar.net/ui.php?id=2416), or TooltipsKhaos (part of Cosmos compilation: http://www.cosmosui.org/).


******************************************************************
** Why is there a vendor sell value table in MobInfo ?
** What does MobInfo do with its vendor sell value table for items ?
******************************************************************
MobInfo has always had an excellent and very extensive built-in vendor sell value table. This table was used for calculating mob loot value. Otherwise MobInfo would be unable to know the value of the loot items found on a Mob.

As of MobInfo 3.20 I have added the option that you can also use the vendor sell value table for showing the vendor sell value of items in the item tooltip. You can enable this on the MobInfo tooltip options page. Since this simply (re)uses the table thats already there for a second good purposes it was an easy and neat little feature to add.

When compared to special price or item data collecting AddOns there is one disadvantage to the MobInfo solution. MobInfo does not update its table in game. Personally I do not consider this important or necessary because vendor prices in game are rather static and the table is very extensive (some 11.000 prices). In fact the table within MobInfo is a combination of the tables found in: Auctioneer, PriceMaster, and WoW-Econ.

About once every half year I update the MobInfo table with the most up-to-date prices and add vendor prices for new items that have been found.



***-----------------------------------------------***
***-----------------------------------------------***
             MobInfo-2 Version History
***-----------------------------------------------***
***-----------------------------------------------***

3.24
  - updated the Spanish translation (thanks to AlbertQ and espiru)
  - runaway Mobs feature should finally work with Spanish WoW (thanks to AlbertQ)
  - improved the database import for health values
  - fixed crazy health values sometimes being shown in PvP
	(thanks to Blazeflack for helping me find this bug)
  - bugfix: show item sell values independant of "Dropped By" info
  - added lots of new item sell values

3.23
  - updated MobInfo vendor sell values table
  - fixed nil bug: "MI2_Health.lua:358"

3.22
  - fixed nil bug : "MI2_Health.lua:521"
  - fixed nil bug : "MI2_Health.lua line 352"
  - ensure that health shows always on first fight
  - always show health as a rounded number
  - added support for item sell values from AddOn "ItemDataCache"

3.21
  - modified health calculation to improve quality when hunting in a group
  - fixed NIL bug on line 306

3.20
  - drastically improved health calculation algorithm
  - beast lore indicator: two slashes for beast lore max health
  - localization improvements here and there
  - added support for more skinning items
  - added support for skinning items gained through mining or herbalism
  - new feature: show vendor sell values of items in tooltip (optional)
    option to enable/disable is on MobInfo Tooltip options page


(for previous version info or any questions regarding MobInfo-2 please visit http://www.dizzarian.com/forums/viewforum.php?f=16)

