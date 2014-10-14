------------------------------------------------------
Fizzwidget Gemologist
by Gazmik Fizzwidget
http://www.fizzwidget.com/gemologist
gazmik@fizzwidget.com
------------------------------------------------------

A certain blacksmith friend of mine recently pointed out that she had a hard time remembering which types of mineral deposits she needed to hit when looking for particular gems for her smithing plans. It struck me that a gadget to provide such info would be quite similar in design to my existing Disenchant Predictor, and a few minutes later, I had this little doodad. I call it Gemologist -- it instantly analyzes any gem (or reference to one) you see and tells you where it can be found in nature.

------------------------------------------------------

INSTALLATION: Put the GFW_Gemologist folder into your World Of Warcraft/Interface/AddOns folder and launch WoW.

FEATURES: Simple enough for even an ogre to use: Whenever you see a gem (in your tradeskill window, on the Auction House, or wherever), the tooltip will provide a list of what types of common minerals a miner can find that type of gem with.

CHAT COMMANDS:
	/gemologist (or /gems) <command>
where <command> can be any of the following:
	help - Print this list.
	status - Check current settings.
	tooltip on|off - enable/disable display of mining availability in gem tooltips.
	info <item link> - Get an item's mining info in the chat window.

CAVEATS, KNOWN BUGS, ETC.: 
	- In cases where there's more than one variation of a type of mineral deposit (e.g. regular vs ooze-covered, small vs rich), the simplest is listed.

------------------------------------------------------
VERSION HISTORY

v. 11200.1 - 2006/08/22
- Updated TOC to reflect compatibility with WoW patch 1.12. (No actual changes.)

v. 11100.1 - 2006/06/20
- Updated TOC to reflect compatibility with WoW patch 1.11. (No actual changes were needed.)
- Added Korean localization by "Halfcreep".

v. 11000.2 - 2006/04/17
- Fixed some issues with the tooltip code shared across Fizzwidget addons; Gemologist's addition to item tooltips should now be able to show up in just about every place you can get an item tooltip.
- Minor improvements to utility code shared across Fizzwidget addons.

v. 11000.1 - 2006/03/28
- Updated TOC to reflect compatibility with WoW patch 1.10. (No actual changes were needed.)
- Minor improvements to utility code shared across Fizzwidget addons.
- KNOWN BUG: The tooltip additions aren't showing up in all cases where they should. Another update to address this issue should be coming along soon.

v. 10900.2 - 2006/01/27
- Includes an update to tooltip-related code shared with other Fizzwidget addons, which should resolve an issue where having two or more addons with conflicting versions of said code could cause a "stack overflow" error.

v. 10900.1 - 2006/01/03
- Updated for WoW patch 1.9.
- Knows its own version number -- it's present in startup messages and if you type `/gems help` or `/gems version`. Please include this version number when sending bug reports or help requests!

v. 1800.2 - 2005/11/18
- I missed [Azerothian Diamond] when compiling the tables for the first version... it's included now.
- Includes refinements to code shared with other GFW mods.

v. 1800.1 - 2005/10/11
- Initial release. (Locale-independent and localizable, too! Translators are welcome to edit localization.lua and send me their canges fur inclusion in future releases.) 