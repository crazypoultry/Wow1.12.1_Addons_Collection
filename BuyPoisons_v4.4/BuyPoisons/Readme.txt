Description :

This AddOn lets rogues buy poison components with one command or using the BuyPoison UI. 
This will also allow you to automaticly restock a chosen amount of Flashpowder into your inventory.

==================================================================
/bp wpX Y 	Buy Components for Y Level X Wound Poison
/bp cpX Y 	Buy Components for Y Level X Crippling Poison
/bp dpX Y 	Buy Components for Y Level X Deadly Poison
/bp mpX Y 	Buy Components for Y Level X Mind-numbing Poison
/bp ipX Y 	Buy Components for Y Level X Instant Poison
/bp fp Y Buy Y Flash Powder
e.g. "/bp wp3 10" will buy all components needed for 10 lots of 
	level 3 Wound Poison.
Warning: Using anything but multiples of 5 will not handle Vial 
Numbers properly as they can only be bought in multiples of 5 from stores.

Automaticly Purchase Flashpowder every time you are at a vendor: 
/bp rfp 0    -Turns off FlashPowder Auto Restock
/bp rfp Y    -Turns on FlashPowder Auto Restock for Y FlashPowder
==================================================================


Changes :
4.4
- Fixed Crippling poison 2 buying the stuff for Crippling Poison 1 as well
- Added /bp force    option to force the opening of the gui
- Fixed slash commands on non-English versions
- el_matl fixed the gui on non-English versions
- el_matl updated the translations
(Thanks a lot for your help!)

4.3
- Fixed loading bug for servers with no rogue characters or servers with multiple rogues.
- Finished German Localisation (Sorry, have no german version to test it with, so let me know if trouble.)

4.2
- *** Updated slash commands! Check help/readme ***
- Started German Localisation thanks to benjy. Currently Incomplete.
- Allowed any amount of Flashpowder to be Auto restocked.
- Allowed any amount of Components to be bought on command line commands
- Increased amounts bought to stacks of 20 instead of 10
- Made Poison Window movable
- Updated to toc 11200

4.1
- Removed non-working config window which was corrupting default tradeskill windows. Some users with non-standard tradeskill windows would not have seen this error.

4.0
- Upkeep taken over by Kinesia
- Updated to work with patch 1.10
- Added Deadly Poison V (from Ahn Qiraj)


3.10
- Toggle UI on or Off with /bp ui
- Toggle FlashPowder Restock on and off for 10,20 or 30 Flashpowder.
3.05b
- Added Flash Powder to the UI in stacks of 5.
- Added the FR LUA file to the XML file.
- Fixed a bug that would open the UI at all vendors AFTER visiting the Poison vendor.
- The BPUI will now only show up for Rogues.
- You no longer have to Put your rogue's name as a variable. This will allow you to have multiple rogues per account use the restock.
- French might be supported now? Feedback required

3.03b
- Fixed A problem with attempting to buy to big of stacks.
- Removed round() function call as it was an inadvertant dependancy.
- Relaxed the Vial Conservation Calculation. This was causing the addon to buy to few Vials if you already had some on hand.
3.00b - Beta: Added in a UI for buying Poisons. The UI will show up when you browse a vendor that sells Flash Powder(most poison vendors). Currently you can only buy poisons in stacks of 5 from this window.

1.11 - Updated ToC to 1500
1.10 - Added autopurchase of Flash Powder
1.01 - fixed a typo with /bp deathweed