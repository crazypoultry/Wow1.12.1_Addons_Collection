CharactersViewer Patch Note:
	2.69 - Added rpgoCharacterProfiler 1.6.2
	2.68 - Added the possibility to make the BankFrame and the MainFrame Movable
	2.67 - Added Basic Khaos support
	2.66 - Reverted change made for EquipCompare as Legorol (EQC author) will handle the stuff himself.
	2.65 - Greatly improved EQC behavior when looking alt in the CV frame
	2.64 - Fixed EQC Tooltip Behavior (messed in 2.60), thank to Xylan Trueheart from curse-gaming community for reporting.
	2.63 - Fixed the sex of the portrait (again...), thank to Xylan Trueheart from curse-gaming community for reporting.
	2.62 - Made the BankFrame Movable
	2.62 - Added The first GUI Option, about Optimim Scaling or not.
	2.61 - Fixed the reportframe (rested xp)
	2.60 - Fixed tooptip display of EquipCompare.  It'll display 'live' tooltip instead of saved one for current character, soo no 'over-scanning' is needed (unlike in the old CV)
	2.59 - Fixed always-Female state of profile viewing, thank to Lombra from curse-gaming community,
	2.58 - Fixed the money frame (again)
	2.57 - Fixed some german localization, thank to Maischter from curse-gaming community
	2.56 - Added Honor Report
	2.55 - Improved the Money Report
	2.54 - Added the Money report
	2.53 - Added placeholder tab for Honor and money
	2.52 - Added and completed Location+XP report tab
	2.51 - Hidded unused tab
	2.50 - CV now handle rpgoGuildProfiler correctly
	2.49 - Worked with Calvin on CP1.6.1 for better startup of both addon.
	2.48 - Added the tab Navigation in CV Frame (placeholder for GUI work)
	2.47 - Improved handling of the dropdown menu
	2.46 - Improved code performance on loading
	2.45 - Fixed and improved the look of the scanned status in the bankframe
	2.44 - Fixed an error with the dropdown initialization (thank wilz of curse-gaming community for reporting)
	2.43 - Fixed DropDown text initialization when BankFrame is opened standalone.
	2.42 - Added a message on unscanned bank
	2.41 - Fixed the BankFrame Switch redrawing behavior.  Thank's wilz from curse-gaming community.
	2.40 - Added BankFrame Server Money Total for horde/alliance/server
	2.39 - Re-Implemented rpgoCharacterProfiler 1.6.0 Original in CV, removed the privacy option, will be handled in CP directly
	2.38 - Improved rpgoCP1.6.0 with CV feature
	2.37 - Moved the private flag to rpgoCP variable, will have to be overlooked by Calvin, the rpgoCP author
	2.36 - renamed local function print() to global function cvprint (internal design)
	2.35 - Added capability to make a profile private, meaning it's saved outside the CharacterProfile.lua file (privacy concern for profile uploader), require (rpgoCharacterProfiler 1.5.4a-f2, included in the bundle)
	2.34 - Fixed the cv switch when trying to reach a character starting with a non-us character. (thank's to deyve of curse-gaming community)
	2.33 - Changed .toc file for Wow 1.12 patch, no new error found
	2.32 - Reimplemented the previous/next toggle (thank bburt of curse-gaming community for mentioning it)
	2.31 - Cleaned the /cv submenu command.
	2.30 - Removed all call to non-used CharactersViewerProfile variable
	2.29 - Fixed more initial loading issue, all way of launching CV should work now, thank to Qrt and thegrayspirit or ui.worldofwar.net community
	2.28 - Fixed the tooltip MouseOver on unitialized CV, thank to Maischter from curse-gaming community for the report
	2.27 - Fixed the handling of unitialized bank
	2.26 - Fixed the initialization sequence when loading a non-existant profile 
	2.25 - Fixed the BankFrame Portrait when opened before the mainframe
	2.24 - Fixed Bank Scaling when standalone
	2.23 - Fixed Bank Toggle Behavior
	2.22 - Removed debugging sentence
	
Important Notice: Stable version is 1.03, and is standalone.
The new Beta version rely on rpgoCharacterProfile to gather data, and it's bundled with CV.

Instructions: 
	- "/cv" to bring up the pannel
	- "/cv help" to bring up the help
	- You can use the dropdown in the Character Paperdoll to open CharactersViewer 

Version 2.0 Beta Release Notes! 
General Note:
	Important Note: 
		1.	The addons require rpgoCharacterProfiler, included in the download.  The version included is the official rpgoCharacterProfile 1.6.1.
			Note that Calvin (rpgoCP author), is in contact almost daily with me for our project.
	
		2.	This version of CV isn't integrated in Cosmos, and will only be once it's out of Beta state.  
		
		3.	Please download this version only if you want to help CV improvement.  Expect some behavior to be different than before.
				
	Sidenote to other addons coder interacting with CV.  I tryed to minimize the "damage" caused by the major code ravamp.  Please contact me soo I can provide the required API function.
	I tryted to maintain the most legacy function, but if you where tapping to CV data, I can manage to create a function returning the correct data for you, or simply tap directly in rpgoCharacterProfiler.
	EquipCompare will be fixed for 1.12 release, as stated by Legorol. 

	If you want someting 100% stable, don't download the newer version, and wait for other people to suggest improvement / report bug.

Release Note:		
Addons current functionality:
	- Can show any of your caracters on the current server
	- Display the Paperdoll Equipment, Stats and more
	- Display the Bag and Bank content
	
Planned very short-term: (1-2 weeks, aka Priority stuff, Sorted)
	- fix tooltip of ammo.
	- fix the CV frame resigtration, add a "reset" loc commandline aand khaos pannel option.
	- OptionFrame: Switch to enable / disable multiple server support

Planned long term, non-sorted: (2 weeks / 2 months)
	- OptionFrame
		- Reset to default setting
		- Scalable Frame / Bag
		- External addons integration:
		- Bagnon (Forever), for bag and bank
		- Titan plugin to see current CV character
		- MailTo	- MailBox Frame (improved) (sidenote: rpgoCP need an upgrade on mailbox scanning, will look into this with Calvin)
	- SkillFrame (listing the skill)
	- ReceipeFrame allowing to see receipe)
	- Mail Button in CVPaperDoll, showing the number of mail in the mailbox
	- Reputation Frame

Wishlist: 
	- Integrate configuration communication for profile, skill, talent, item seek with guildmate
