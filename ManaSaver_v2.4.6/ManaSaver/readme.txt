Baden's ManaSaver Mod, version 2.4.6
- Baden - Dragonmarch - Silvermoon Server
- Arax - Dragonmarch - Silvermoon Server


1.0 - INTRODUCTION

I made this mod to address a problem with my own druid play style.  I, like most people that I know, use the most powerful healing abilities that they own, all the time.  However, if you look at the healing abilities, like "Healing Touch," you will see that each level of the ability heals a different amount of health and costs a different amount of mana.  So, I was finding that in an instance, I was healing a mage at half health using Healing Touch and always filling her health back up to full.  I realized that this was "over-kill," as I was healing more health than needed to get her to full health, and the extra health was wasted.  But, how to figure out the most efficient level Healing Touch to cast?  That is where this mod came into existence.

The mod, ManaSaver, basically calculates how much health a target needs to be brought up to full health (called health delta).  Then, ManaSaver progressively looks at each level of a healing spell, starting at level 1, and determines the lowest level spell that can reasonably heal the target to full health.  It then casts that level of the spell, rather than your maximum level.  In the case where the target is so hurt you cannot heal to full health, it casts the maximum level of the spell.  If the target is not in your party or raid, hence we cannot access actual hit points, the mod casts the maximum spell you have enough mana to cast.  If the target is an enemy, the mod casts the healing spell on you, without changing the target.  The mod takes talent and items healing bonuses (thanks to BonusScanner) into account, and will only cast a spell rank you have enough mana to cast.

It is important to note that ManaSaver has an optional dependency with BonusScanner, which it uses to collect item healing bonuses.  For your convenience, ManaSaver is bundled with BonusScanner.  Should you turn BonusScanner off, or uninstall it, ManaSaver will continue to function, but not include any healing bonuses from your equipment.

Enjoy.

1.1 - OVERHEALING

I have also added a function for Overhealing.  This basically means that you can force the program to cast healing spells at a higher or lower level that the mod calculates.  Some feedback received indicated that because most spells have a casting time, and your target may be getting damaged while you cast the spell, some players may want to force the mod to cast at a level or two higher than calculated to make sure the target is fully healed.  Seeing how the logic was the same, the mod allows for a negative overhealing value, so you would heal less than the level the mod calculated, though I cannot imagine why you would want to do this.  Overheal is an optional value.


2.0 - INSTALLATION INSTRUCTIONS

1) Unzip the zip file and place in World of Warcraft Addons directory (default is C:\Program Files\World of Warcraft\Interface\Addons\).  The zip file preserves the folder names for add ons, but if you need to do this manually, the total path should be (C:\Program Files\World of Warcraft\Interface\Addons\ManaSaver\ and \BonusScanner\).

2) Start World of Warcraft and make sure that ManaSaver and BonusScanner are enabled in the Addon page on the character logon screen.  You may have to enable out of date addons to allow this to happen.  Please also note that every time Blizzard releases a patch, you will have to reenable your addons.  This is a pain, but its Blizzard we are talking about here.

3) Login to your healing character.

4a) Click on the minimap button (Low Mana with a red slash through it) or type /msaveroptions to bring up the options page.  Select the second tab at the bottom ("Macro") and click on a macro button to create a ManaSaver macro.  See below for more information on the options page and macro creation tool.

4b) Alternatively, you can do it manually.  Hit Escape and go to the macro tool.  Add a new macro, making its name what ever you like and picking an appropriate icon.  The text of the macro should be as follows:

/script MSaver("NAME OF SPELL", YOUR MAX SPELL LEVEL, OVERHEAL AMOUNT WHICH IS OPTIONAL, TARGET WHICH IS OPTIONAL AND USED FOR OTHER MODS);

For example,

/script MSaver("Healing Touch", 7, 2);      This would cast Healing Touch, up to level 7, with an overheal value of two levels
or
/script MSaver("Flash of Light", 3);      This would cast Flash of Light up to level 3, with no overheal set
or
/script MSaver("Greater Heal", 3, -1);     This would cast Greater Heal, up to level 3, with a negative overheal of one level

5) Create additional buttons for all of the spells you have covered by ManaSaver (for list of spells, see below).

6) Use the buttons as you would normally use the spell buttons.

7) Enjoy the mod and report any problems on Curse Gaming.

2.1 - PRIEST HEAL SPELL ANALYSIS OPTION (ALL HEAL)

Tekkub on the Curse Gaming forums brought to our attention that the three priest Heal spells (Lesser Heal, Heal, Greater Heal) provide overlapping functionality that could easily be combined into one ManaSaver call.  It would be beneficial to modify ManaSaver to analyze which one of these spells should be used to best heal the target, rather than have a separate button for each one and have to guess which is most appropriate. Tekkub also provided some very helpful code to accomplish this.  To use this option, you use the same script call as above, but the name of the spell is "All Heal."  The only difference comes in your spell rank, which you combine all spells together, stacked on top of each other.  So, if your character has all the levels of lesser heal and heal and only the first level of greater heal, your rank would be 8 (3 + 4 + 1 = 8).  PLEASE NOTE THAT "ALL HEAL" IS THE SPELL NAME FOR ALL LANGUAGES.

For example,

/script MSaver ("All Heal", 6, 0);
  - This would cast all 3 ranks of lesser heal and up three ranks of heal, with no overheal
or
/script MSaver ("All Heal", 10, 1);
  - This would cast all 3 ranks of lesser heal, all four ranks of heal, and up to three ranks of greater heal, with an overheal of 1


3.0 - BASIC MOD INFORMATION

3.1 - OPTIONS MENU AND MACRO CREATION TOOL

A graphical options menu and macro creation tool has been added in version 2.4.0.  The options menu is self-explanatory, with the following sets of options:  1) The first set of check boxes controls how ManaSaver posts spell data in the chat window; 2) The second set of check boxes involves whether to include talent and healing items in the ManaSaver calculations (we recommend both); and 3) The last set of options involves whether to use ManaSaver specific error messages and if you want the minimap icon visible and where you want it to appear.

The macro creation tool, on the second tab, has been created to help people write proper ManaSaver macros.  The page starts by loading your ManaSaver-appropriate known spells and your max level in each.  You can alter the max level and over heal values for each spell by using the + and - buttons.  When you want to create a macro for a spell, just hit the Macro button on the same line.  This creates a macro in your character-specific macro list, where you can then modify its icon and move to your tool bar.  Please do not change the macro name, as ManaSaver will look for that name and over-write it in the future, should you make another macro using the same spell.  This should prevent ManaSaver from filling-up your macro list.  You can hit the reset button to change the max level and overheal values for all spells back to their defaults.

3.1 - BONUSSCANNER

It is important to note that ManaSaver has an optional dependency with BonusScanner, a mod developed by Crowley.  ManaSaver uses BonusScanner to collect item healing bonuses for inclusion in our calculations.  For your convenience, ManaSaver is bundled with BonusScanner.  You should use this version of BonusScanner, because I have made minor modifications to it to ensure it works with ManaSaver.  Note that should you turn BonusScanner off, or uninstall it, ManaSaver will continue to function, but not include any healing bonuses from your equipment.

3.2 - SLASH COMMANDS

The following slash commands have been added to control the announcements:

/msaveroptions		(This will bring up the ManaSaver options window, which can also be accessed by the minimap button.)
/msaverq off		(This turns on quiet mode.  No messages will be sent to party or raid chat.)
/msaverq on		(This turns on the smart aleck comments.)
/msaverq default	(This mode is on by default and will display the generic messages in party or raid chat.)
/msaverq self		(This mode sends the ManaSaver default messages only to player's chat window)
/msaverq menu		(This displays a menu of the manasaver slash commands)

3.3 - TARGETING

Again, thanks to Tekkub on Curse Gaming, we now have dramatically increased targeting functionality.

- If no target passed, use "target"
- If target is hostile, use "player"
- If target does not need healing don't cast
- If target is in party/raid use best spell by HP missing, modified by talents and items
  - If not enough mana, cycle through spells ranks below ideal rank, until the player can cast one
- If not in group use best rank available
  - If not enough mana, cycle through spell ranks below best rank available, until the player can cast one

Tekkub has also added functionality to pass a target in the MSaver function call.  This maybe helpful for those of you who use ManaSaver with other targeting or one-click mods.


4.0 - LANGUAGES AND LOCALIZATION FILE

ManaSaver uses a localization file called "MSLocalization.lua".  Listed below are the languages supported and the translators from Curse Gaming who assisted in creating the localization file:
- English (DUH!!!)
- French - Complete Localization (Thanks to Cinedelle, Zangmaar, and Mordame for the translations!!!)
- German - Complete Localization, see spell list (Thanks to Dieck and Tolarion who translated almost everything and provided play testing!!!  Thanks to Voodoomaker and Bryll for the early translations.)


5.0 - COVERED SPELLS AND TECHNICAL INFORMATION - Updated 3-31-2006

Below are the spells covered by the mod and the cut off thresholds I used for them.  By cut off thresholds, I mean that these are the health comparison levels I used to determine what level the spell is cast.  The healing level values are from http://www.thottbot.com/.  The list is organized alphabetically, grouped by spell class (healing, healing spells over time, and heal self).  If I missed any spells, please post them on the Curse forums and I will try to add them in future versions.

5.1 - HEALING SPELL AVERAGE HEAL VALUES

I used the average healing value for each level for each of these spells.  The F and G after the spell name means it is supported in French or German.

- Greater Heal (Priest)(G,F)         {956,1219,1523,1902,2080}
- Flash Heal (Priest)(G,F)           {215,286,360,439,567,704,885}
- Flash of Light (Pally)(G,F)        {67,103,154,209,233,363}
- Heal (Priest)(G,F)                 {318,460,604,758}
- Healing Touch (Druid)(G,F)         {50,100,219,404,633,818,1028,1313,1656,2060,2475}
- Holy Light (Pally)(G,F)            {50,83,173,333,522,744,999,1317,1680}
- Lesser Heal (Priest)(G,F)          {50,78,146}
- Healing Wave (Shaman)(G,F)         {40,71,142,292,408,579,797,1092,1464,1735}
- Lesser Healing Wave (Shaman)(G,F)  {174,264,359,486,668,880}
- Chain Heal (Shaman)(G,F)           {345,435,589}
- All Heal (Priest Special)          {50,78,146,318,460,604,758,956,1219,1523,1902,2080}
- Regrowth (Druid)(G,F)              {91,176,257,339,431,543,685,857,1061}
- Rejuvenation (Druid)(G,F)          {32,56,116,180,244,304,388,488,608,756,888}
- Renew (Priest)(G,F) 		     {5,100,175,245,315,400,510,650,810,970}

5.2 - HEALING SPELL MANA COSTS AND LEVELS AND TALENT INFORMATION

To see healing spell mana costs, healing spell required levels, and talent information, please open the ManaSaver.lua file with any text editor.  Near the top there is a heading called "Spell Libraries" and you will find the information you seek there.


6.0 - VERSION HISTORY

The following is the version history of ManaSaver:

Version 0.1      09/01/05     
- This is the beta version first released for Dragonmarch Officers for play testing
Version 1.0      09/08/05     
- Removed damage modules, as not practical, put overheal in, and added self healing spell.  Available to all of Dragonmarch.
Version 2.0      10/17/05     
- Added Arax's changes.  Added Rejuvenation.  Removed Desperate Prayer.  Fixed bugs.  Available to wider WoW community.  
Version 2.1.5    10/24/05     
- Fixed/added error handlers.  Added German spell names.  Added Shaman spells.  Added menu slash command.  Fixed bugs.
Version 2.1.6    10/29/05     
- Added missed ranks in Rejuvenation.  Added Renew as a supported spell.
Version 2.2.1    11/01/05     
- Added PriestHeal function.  Added more random sayings.  Split code into more functions for simplicity.
Version 2.2.2    12/16/05     
- Added All Heal ability.  Added French localization.  Completely reorganized things with help from Tekkub.  Changed target handling.  Added saved variable for msaverq.  Added ability to cast highest level spell on target not in party.  Pass target in MSaver function call.
Version 2.3.0    03/06/06
- Added functionality to gather talent data.  Created optional dependency with BonusScanner.  Added error checking to ensure a player knows the spell called.  Created function to cast lower level spell if not enough mana.  Added MSaverq SELF mode and four new joke comments.  Fixed bugs in the All Heal functionality.  ManaSaver now properly handles pets, in party and out.  Added full localization for the French and German client.  Included localization information in separate file.
Version 2.3.1	 04/01/06
- WoW Patch 1.10 compliant.  Reviewed and updated all spell information from Thottbot.  Added new AQ high level healing book information.  Updated priest talents.
Version 2.4.0    05/08/06
- Added graphical options menu and macro creation tool.  Addressed out-of-party All Heal function problems.  Added Renew to level-dependant library.  Fixed several minor bugs.  Updated Renew and Rejuvenation heal values.
Version 2.4.1    05/22/06
- Updated German translations.  Added alt key for self-heal without changing target.  Moved options menu because of overlap with Titan Panel.  Added priest Spiritual Heal talent.
Version 2.4.2    07/20/06
- Fixed problem introduced with Patch 1.11.2, where all heals on self were at max level.  Included new BonusScanner version.
Version 2.4.3    08/07/06
- Fixed another problem where all heals on self were at max level.
Version 2.4.4    09/08/06
- Updated the French translations with the help of Cinedelle.
Version 2.4.5    10/02/06
- Arax tracked down the problem with ManaSaver crashing WoW, it was our .blp graphic files.  Arax put together some new graphics for the mod, thanks man!
Version 2.4.6    10/03/06
- I updated to Version 1.2 of BonusScanner.  I also fixed a bug with the zip file used in 2.4.5.  I also added the targeting language posted by Inevo.


7.0 CREDITS

A HUGE, HUGE, HUGE thank you to Tekkeb on the Curse Forms.  Anything from Version 2.2.2 and later has a SIGNIFICANT amount of code that he supplied to us.  He reorganized the code in a much cleaner fashion and added a bunch of very helpful and logical functionality.  Continued thanks to Arax, for working so hard to make this mod better.  This mod has grown into a join effort from both of us.  I would like to thank my guildies at Dragonmarch, particularly the following playtesters: Icemaiden, Cairis, Husband, Kathii, Shamoon, and Nasperi.  A special thank you to my wife, Icemaiden, who has put up with endless cursing and ranting about stupid bugs and kindly reminds me that I play this game because I love it.





