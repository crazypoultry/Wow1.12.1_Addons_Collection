TitanDKP EQDKP Plugins - version .91

Description:
When installed, this plugin allows you to download points from an eqdkp site (http://www.eqdkp.com) to your local titan dkp addon as well as upload data into the site from your addon.

I used the ideas and some of the code of two other plugins in the making of this: dkpinfo2 (http://www.curse-gaming.com/en/wow/addons-3245-dkpinfo2.htm) and CTRaidTracker Import Plugin (http://black-fraternity.de).  The download file from dkpinfo2 will also work with this addon if you only have that installed.

Installation:
Copy the titandkp folder to your eqdkp installation/plugins directory.  Then go to manage plugins and install it.  This will add an option to the admin menu to upload titandkp data, as well as an option to the main menu to save everyone's points to a file.

Usage:
You provide the downloaded lua file to the addon by putting it in the TitanDKP addon directory, under <World of Warcraft>/Interface/AddOns/TitanDKP/.  When you load warcraft after adding this file, it will provide you with an option to import web data, which will add the information from this file to the addon.

To upload data, click on the Import TitanDKP Data in the Administration menu.  Select your lua file from <World of Warcraft>/WTF/Account/<Account>/SavedVariables/TitanDKP.lua.  Click upload file and select the raid instance and date you want to enter.  Raids are saved for a week in your saved variables.  Click process raid, and review the points being added to players, unchecking them removes them from being added to the raid's points.  Click confirm, and you will see a log of the upload, the raid will then be input.

Changelog:

v .9 - Altered download info to include alts, packaged it and uploader into an eqdkp plugin

v 3 - Taken from DKP Info 2 addon