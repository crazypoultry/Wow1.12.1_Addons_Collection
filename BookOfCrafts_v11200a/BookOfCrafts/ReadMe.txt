
*** PURPOSE ***

BookOfCrafts (BoC) is a simple add-on which provide you with information
regarding your other characters crafts. With it activated, whenever you display
a recipe tooltips, it will list which character know this recipe already, which
character may learn it now and which character will be able to learn it later.

In case no character is concerned by this recipe, a simple message is displayed.


Some special notes :

- By default, currently played character is not displayed in lists, because top
  of recipe text should inform you about "known" state. However an option is
  available to force current character listing

- When a recipe requires a craft specialisation, character should know this
  specialisation to be listed. Knwing the base craft is not enough. For
  instance, if your character knows "Dragon scale leather crafting", it won't
  be listed for a "tribal leather working" recipe even though it is a leather
  craft.

- Works with regular chat message hyperlinks, merchant, bank, bags tooltips.

  However, if you work with add-ons which do not handle tooltips correctly, 
  through hook functions, BoC may be unable to display any information. So be
  sure to check which add-on you have in use before blaming BoC ^_^



*** INSTALLATION ***

Install the Add-on in your Interface/Add-on directory, then open for each
character their Tradeskills/Craftskills list. By doing this, BookOfCrafts learns
which craft skills they know.



*** OPTIONS ***

You may access to options through 4 ways:

   - with '/boc' command (or '/BookOfCrafts')
   - A myAddOn button (my favorite way... if myAddon is installed)
   - A binding key, through normal binding menu


Available options are :

   - Same Faction: Search of characters is limited to same faction as currently
     played one

   - Show Skill Rank: If option is active, listed characters will show their
     current craft skill level (for instance 'Lini (78)'. Otherwise, only the
     name will be displayed)

   - Show Chat Msg: More feedback is displayed in chat frame

   - Tooltip colors: choose your own color for BoC tooltip text and background

   - Display miscellaneous informative chat messages (used for debug generally)

   - Show also current character in lists.

   - Use Side Tooltip: BoC Information is displayed in a detached tooltip


*** COMPATIBILITIES ***

Information will be shown an any plan/manual/recipe in ...

   - Auction House
   - Merchants
   - Inventories


This is compatible with 

   - AllInOneInventory
   - Auctioneer new auction windows.
   - BankItems
   - CharacterViewer
   - MyAddons
   - MyBags
   - MyInventory



*** FUTURE FEATURES THAT MAY COME, ONE DAY ***

  - Configuration panel : list characters data
  - More recipes information



*** KNOWN PROBLEMS ***

  - If you delete a character date, It is not removed from list in option
    interface. You have to close and open back UI.

  - If using embedded information, list of name may overlap tooltip border.



*** DEPENDENCIES ***

There is no mandatory dependency. This is a standalone add-on



*** NOTES ***

This add-on has been thoroughly tested in French only. It is provided with
Deutsch and English localization which I cannot test, so the quality of BoC
behavior in those 2 languages highly depends heavily on users feedback.

Also, if someone wants to provide Korean or German translation, he/she's
welcome :)



*** CREDITS ***

My big thanks to Ayradyss, maker of "RecipeBook" addon. I've been a first user
of this add-on, but found myself in need of something different and I have 
developped "BookOfCrafts" (also at this time, RecipeBook development was
stopped). This is thanks to "RecipeBook" that I started to get involved in
Add-on development.

However, there is no competition with "Recipe book" and Ayradyss. Perhaps you
should check also this add-on as it is a great add-on that you might prefer for
its different features.

Special thanks to Bburt for his overall help
Special thanks to Ghandi, Ayradyss and Balinwordoka for German translation
... and my thanks for all of you for your feedback
