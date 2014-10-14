WL_RecipeBox ver 032806
Created by Hackle, copyright 2005
German(Deutsche) Localizaltion by Skulk

Version 032806 changed the format recipes are saved as, so if upgrading it will clear all old data you had saved locally.
When you start scanning recipes wait for message that says it is safe to close or change crafting window.
Due to changes in how recipebox scans recipes it may no longer be friendly with other crafting addons that hijack Blizzard tradeskill/crafting windows.

This addon will allow you to view recipes your other characters have, or a list "known" recipes which are displayed alphabetically.
This list is limited to ones my characters know atm, although as you add your recipes these new recipes will show up on your local installation of RB in the known section.

To view your recipebox, bind a key in the interface setup, or use /rb.  If you dont see RB close all your tradeskill/character windows, since this is RB starting position, and drag RB to wherever you want it to be.  To add your recipes to recipe box open blacksmithing for example and hit add to recipe box button below it.  You will need to repeat this for every skill on every character and everytime you learn a new recipe.  Once you click the Add Recipes button wait till you see the message that it is safe to close or change your current skill you have open.  If you close or change your open tradeskill while gathering it will clear all your recipes of that skill that are saved in your saved variables, this is to avoid getting imcomplete recipes.

Allows you to shift-right click items to send entire recipe to edit box, if someone is asking you to make something and wants to know what materials to collect this can save some typing.

Additional commands:

/rbox help 								Lists slash commands
/rbox deleteallyesyesyes	Deletes all lists of player recipes and locally stored recipes/reagents
/rbox realmlist				Lists all the realms you can access with realmname command
/rbrealm realmname		Changes the characters recipes your viewing to another realm if you have a horde and alliance server for example, must be correctly capitalized.
/rbcheck recipename or [recipename link] or [Recipe: recipename ]		Returns names of characters that have this recipe, must be correctly spaced.  Be aware there is at least one recipe ingame that is incorrectly spaced   Enchant Gloves -Greater Agility , it is shown same way on the formulae to learn it and tooltip if you have it in your enchanting menu
/rboffset <new offset>  to move the buttons to add recipes, for example /rboffset -70   will move the button 70 pixels down the screen.

Known Issue:  Items in the enchanting list like wands and rods are saving as the enchanting links not the items links, I consider this a small issue so am in no hurry to remedy.

version 032806B - Minor correction to text in list box being centered instead of left justified with patch.  Updated TOC number.  No change to data format.

version 032806A - Works with FilterTradeSkill again, author of that had changed name of his xml frame

version 032806 	- Updated TOC for patch 1.10

version 021806 	- Seem to have fixed issue of nil errors while gathering recipes
	 	- Fixed data gathering to gather textures again
							 - Started german localization, open localization.lua and finish translating the various messages if you want to finish it.

version 010806A - Added support of the rboffset command to the enchanting window, it will be the same offset as used on other tradeskills
                - Corrected color of white items so they have white text not grey

version 010806 	- fixed error I had accidentally introduced for enchanting data, this meant a reformat of data, so all data will have to be reaquired
               	- added /rboffset command

version 010506B - Add recipes button will appear if you are using FilterTradeSkill addon.

version 010506 	- Can now check for recipes by either /rbcheck [link], /rbcheck name, /rbcheck Name proper capitalization no longer required to be correct, and can alternatively use link to check
		- updated TOC number
		- changed data format, so all recipes you have will reset and you will need to log on all characters and reaquire recipes
		- due to data format, most of my prepackaged database of recipes was removed
		- updated for changes to enchanting links
		- fixed whatever was causing recipebox to require ImprovedErrorFrames to work, now works standalone again

version 072005 	- now really fixed the random quantities issue
		- added ability to /rbsearch using [recipename link] or [Recipe: recipename link] as arguement, and if you use just name it no longer has to be capitalized.
		- added WL_RecipeToChat to allow shift-rightclicking of recipes to chat windows.  The xml from this is taken almost directly from Omoda's ChatMats.  Be aware if you are using ChatMats and RB I dont know if you will get the recipe his addon sends or mine.  But will get a recipe anyway.

version 071505A - fixed linking the random recipe quantities, correct quantity will now be sent to editbox when sending entire recipe
		- now able to /rbcheck [recipe: whatever recipe here] and /rbcheck [whatever item made is] and also be able to use lower case if handtyping the check

version 071505 - fixed "random" recipe quanities, so now it will show makes 1-5 of item if it is such an item

version 101 - got version checking to work, also reformatted recipe data, since I had forgot to grab how many items a recipe might make.

version 100 - beta for testing

