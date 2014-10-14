Archaeologist

By: AnduinLothar    <KarlKFI@cosmosui.org>

Universal UnitFrame enhancement. Buffs, Health, Mana, Class, Player Status.
Archaeologist: Unearthing Health and Mana values at a unit frame near you. 
Plus a few more treasures. Gives you great flexibly in how to display health/mana information.

Available for download at www.curse-gaming.com

Features

    -Adds HP/MP Text Overlays to all unit frame status bars 
    -Adds Secondary Overlays Next to all unit frame status bars 
    -Adds Dead/Offline/Ghost text to all unit frames 
    -Changes health bar color as it decreases. 
    -Status bar prefix is optional. 
    -All status text can be shown as percent or real value (except target HP which is percent from server on non-party). 
    -Added visibility for 16 Buffs and 16 Debuffs for all party members and pet. 
    -Added visibility for 16 Buffs and 16 Debuffs for the target. 
    -Party/Pet/Target Positive Buff borders green for easier identifying. Debuffs are still red. 
    -Show anywhere between 0 and 16 Buffs or Debuffs; always or only on mousover 
    -Alternate party debuff locations (below buffs or to the right of the party frame) 
    -Optional target buff Right to Left display (so that extra buffs don't overlap the portrait) 
    -Alternate HP/MP text location (swaps primary and secondary displays) 
    -Status Text is resizable from 6-20. (Default is 14) 
    -Optional use of the MobHealth2 or MobInfo2 addon for Target Health if you are using it. 

Slash Commands:
	(For those of you not using the Khaos/Cosmos Options Menu)
	/arch - Archaeologist Help (Opens MCom slash command frame with details on all slash commands.)
	Slash Command Syntax:	"/arch option value" 
	("arch" must be lowercase but everything else is case insensitive thanks to MCom)

Slash Command Examples

    Ex1: "/arch playerhp mouseover" 
    Ex2: "/arch playerclassicon on" 
    Ex3: "/arch HpMpLargeSize 13" 
    Ex4: "/arch HPMPSMALLFONT GameFontNormal" 
    Ex5: "/arch COLORSMP 100 50 75 100" 
    Ex5: "/arch preset5" 

For more details about slash command options see http://www.wowwiki.com/Archaeologist
	
	
Change Log:

v2.92

   1. Circumvented a Blizzard TargetofTarget_Update bug that was causing targettarget debuffs to occasionally show up on your target.
   2. Pet No longer is marked as dead when you re-summon it after it dies.
   3. When you first level to the MAX_PLAYER_LEVEL the experience bar text will now hide itself, rather than overlap the reputation bar.
   4. Fixed Party Debuffs to correctly display bellow the party frame, rather than next to it, when alt debuff location is enabled and party buffs are dissabled

v2.91

   1. Fixed orig debuffs from showing up underneith buffs.

v2.9

   1. Fixed Pet, Party, Party Pet, Target and Target of Target buffs to work with the new RefreshBuffs function
   2. Target of Target debuffs now correctly show up (default blizz)
   3. Fixed buff border color for all buffs
   4. Updated TOC to 11200 

v2.81

   1. Changed TARGETHPALT to THPALT to fix empty checkbox in the Target section
   2. Updated Party debuffs to match default border color scheme
   3. Added debuff border coloring to the Pet and Party Pets
   4. Fixed logic for feigning and debuff status if set to display less than max debuffs.
   5. Fixed the long standing bug with party pet buff tooltips

v2.8

   1. Updated to use dynamic Localization
   2. Changed Target buffs to wrap similar to default around the TargetofTargetFrame if it is shown.
   3. TBUFFALT now forces no wrapping (instead of the smart wrapping used by default). Useful if you have frames vertically stacked.
   4. Added readme.txt
   5. Updated TOC to 11100 

v2.71

   1. SeaSting Error Fix 

v2.7

   1. (Stand Alone) Using Embedable SeaString to avoid code duplication
   2. (Stand Alone) Upgraded MCom to v1.54
   3. Fixed Disabled values with Khaos reverting to %'s
   4. Fixed tooltip scanning for 1.10
   5. Added Support for 1.10 reputation watch bar
   6. Added options for making either the value or the percent or both of each type inverted
   7. Fixed error with missing help string
   8. Made small text default to 12
   9. Updated TOC to 11000 

v2.65

   1. Fixed Option Sorting to be more readable. 

v2.64

   1. Fixed MobHealth Event hook to correctly update on target health updates. 

v2.63

   1. Fixed SeaHooks and MCom loading, back to standalone
   2. Added Telo's MobHealth Support (tho I would like to point out that it is less efficient than MH2 or MI2 due to dumb local functions in Telo's version) 

v2.62b

   1. Bugged Standalone 

v2.62

   1. TOC to 10900
   2. Tooltip scan updated to use IsShown
   3. Requires external MCom and Sea 

v2.61

   1. Fixed Khaos default and disabled values
   2. Dead/Ghost values correctly update when you release to ghost from an instance.
   3. removed PLAYER_ENTERING_WORLD debug msg 

v2.6

   1. UseHPValue has been removed and replaced by TargetHpAlt which now works as follows...
          * When disabled (default) and exact values are unavailible, the value display (based on TargetHpSwap setting) will be shown as percent.
          * When enabled and exact values are unavailible, the value display will be blank when exact values are unavailible.
          * When exact values are availible, they will be used.
          * Exact values are only availible for: you (player), party/raid members, estimated values based on MobHealth2/MobInfo2.
          * Note: Estimated values are only availible with the MobHealth2 or MobInfo2 addons installed and enabled and the MobHealth Archaeologist option enabled (default), on hostile mobs that you have previously attacked. MobInfo2 can also store hostile player hp estimations if enabled in the MobInfo2 options (disabled by deafault due to innacuracy). 
   2. Added options to hide the max value on all value displays.
   3. Invert options now only apply to value displays (not percent).
   4. Changed defaults to be more intuitive (swaps on, noMaxs off, TargetHpAlt off)
   5. Updated presets to match account for new options.
   6. Config table now stored in the toc. Now if you remove Khaos or Cosmos or temporarily disable Arch your options should still be saved.
   7. Updated SeaHooks to v0.4
   8. Updated MCom to v1.49 

v2.51

   1. Fixed Buff Count Dependancies
   2. Updated SeaHooks to v0.3
   3. Updated TOC to 10900 

v2.5

   1. Fixed Primary HP being shown while a ghost.
   2. HP/MP no longer show if unit is "Offline"
   3. Embedded MCom 1.49 and SeaHooks 0.1: Archeaologist can now be used completely standalone. 

v2.41

   1. Fixed Presets again, should work for French too now. 

v2.4

   1. Added Feign Death detection for party members.
   2. Added Feign Death detection for player and target.
   3. Updated German Localization, thanks StarDust
   4. Updated French Localization, thanks WLMitch
   5. Fixed Presets not working on German Clients
          * (Note: MCom isn't French localized yet so slash commands will need the English On/Off while German clients use Ein/Aus) 

v2.3

   1. Added 6 value/percentage display presets (Preset1-6)
   2. Added 3 display prefix presets (PrefixOn, PrefixOff, PrefixDefault) 

v2.21

   1. Fixed font size save bug. 

v2.2

   1. Changed 'alt text locations' to 'swap value and percent' (slash command changed as well. Ex: '/arch playerhpswap on')
   2. Pet happiness location now only moves when debuffs are enabled to the right or secondary text is on.
   3. Entirely rewrote the Target, Party and PartyPet frame offset relocation scheme based on options involving secondary display visibility, alternate buff positioning and buff/debuff hiding
   4. Now if party/partypet buffs are hidden the debuffs move up to close the space when applicable
   5. Party pet buffs disabled by default (normal space offset)
   6. Added Pet XP Text Display Options: On, Off, Mouseover, Prefix, Percent, Value, Invert
   7. Enabled Automatic MCom Option Feedback
   8. TBuffAlt option now wraps target buffs and debuffs in rows on eight. 

v2.13

   1. TargetFrame Height now adjusts to the same height as the PlayerFrame (fix for TitanBar)
   2. Fixed for nil error on load involving undefaulted nil options 

v2.12

   1. Fixed Font Change bug causing nil error for SetTextHeight
   2. Prefix now stays on the Primary Display 

v2.11

   1. Fixed CharacterFrame 'Archaeologist_TurnOnPlayerXP' bug
   2. Fixed a bug where defaults where being set after MCom was registered
   3. Fixed a bug where duplicate settings where accidentally being saved with Khaos
   4. Fixed a bug that broke font resizing 

v2.1

   1. Archaeologist now requires MCom for simplified Khaos/Cosmos/slash command registration
   2. All Slash commands are now availible via "/arch" which will bring up a dialog with availible commands.
   3. Removed Buggy Party Pet Buffs/Debuffs mouseover only option
   4. Added On/Off/Mouseover options for all statusbar displays via Khaos dropdown menus
   5. Added AltTextLocation for each status bar
   6. Added Option to use health values instead of percent on the target when possible 

v2.0

   1. Updated TOC to 1700
   2. Increased Target Buff and Debuff max to 16
   3. Added 16 PartyPet Buffs and Debuffs
   4. Added Party Pet Buffs/Debuffs mouseover only option
   5. Updated all Buffs and Debuffs to 16 max
   6. Added Primary and Secondary Text Displays for every StatusBar
   7. AltTextLocation now swaps Primary and Secondary Display Text and is sepperated by Unit Type
   8. Added Text Inversion for all StatusBars (Show how much is missing in % or value)
   9. Now works with the MobHealth inbedded in MobInfo2
  10. Added dynamic font changing (dropdown in khaos)
          * [Note if you change the font the font shadow will dissapear. To get it back change the font to default and ReloadUI.] 
  11. Added font coloring (color wheel in khaos)
  12. If in default positions PartyPets, PartyMembers and Target Frames are slightly relocated to make room for Text and Buffs
  13. Only Move Target Frame if Secondary Display is enabled on Target or Player
  14. Added Options to either show percent, value, both or neither on the XP bar
  15. Increased the Frame Level of Target Debuffs to be above the Target Frame
  16. Added Target debuff aplication overlays 

v1.9

   1. Added optional replacement of unit portraits with large class icons
   2. Raised Target Buffs slightly to be above the Target portait
   3. Fixed a nil bug when using class icons on party members. 

v1.8

   1. Added optional class icons to the Player, Party and Target Frames 

v1.7

   1. Added Khaos configuration options
   2. Updated to work with cosmos MobHealth addon
   3. No longer displays 0/0 if the health is unknown
   4. Fixed manabar nil bug. 

v1.6

   1. Added Optional use of the MobHealth2 addon if you are usign it. http://www.curse-gaming.com/mod.php?addid=1087

v1.5

   1. Made Target Buffs on top if targeting an ally and Debuffs on top if targeting an enemy.
   2. Added an alternate option for target buffs to display from right to left. Default is left to right.
   3. Fixed/Avoided MouseOver hook so that Arch plays nicely with mouse over offsets. 

v1.43

   1. Fixed a bigger bug with values not saving with slash commands and cosmos. 

v1.42

   1. Fixed a bug with loading default values from the new text sliders w/o cosmos. 

v1.41

   1. Implimented Smooth Text Resizing Work-around 

v1.4

   1. Fixed the bug that hid status text while moused over.
   2. Fixed the bug that hid status text while the character frame was open. 

v1.3

   1. Added 8 Buffs and 8 Debuffs for target frame.
   2. Target Buffs slightly rearanged. They now extend from right to left so that the 3 extra buffs don't get covered by the portrait and elite graphics.
   3. Increased Pet and Party Max buffs/debuffs to 14 

v1.2

   1. Added French Localization
   2. Fixed ArchaeologistVars = nil error
   3. Text is now resizable from 6-20.
          * Note: due to a blizzard text resizing bug the text will not propperly smooth/rescale once changed.
          * To correct it go to windowed mode and back to fullscreen. I have notified Blizzard of the bug. 
   4. Made Party/Pet Buff borders green. Debuffs are still red. 

v1.1

   1. Added German Localization
   2. Sorting of cosmos options.
   3. Auto Pet Happiness Alt Location Management 

v1.0

   1. Live in Cosmos!
   2. Spelling Errors Corrected 

v0.7a

   1. Added Alternate Debuff Location.
   2. Added buff tooltips
   3. Changed Slash Command syntax
   4. Added Alternate HPMP text location that aligns to the outside of the bar frame. 

v0.6a

   1. Added 12 Buffs and 12 Debuffs for all party members and pet.
   2. Moved Pet Happiness to accomidate pet debuffs
   3. Options to Show or Hide buffs or debuffs (reverts to normal onmouseover behavior when off)
   4. Show anywhere between 0 and 12 Buffs or Debuffs
   5. Cleaned up slash command printouts
   6. Syncronized Cosmos with Slash Commands. Use both if you're thus inspired. 

v0.5a

   1. TargetFrame healthbars now always display as percent unless max hp is difforent thant 100 (party, player, pet) 

v0.4a

   1. Fixed a hp prefix reshowing bug
   2. Added Pet Dead Text
   3. Fixed Pet MP/HP show issue 

v0.3a

   1. Optimized Slash and Cosmos Reg Code.
   2. Fixed non-Cosmos saved variables not being saved (also nil pointer bug)
   3. Fixed text relocation so that the HP and MP text are now slightly sepperated
   4. Removed partial frame replacement and replaced it with onLoad status bar initializing===v0.2a===
   5. Fixed Slash commands not working for text.
   6. Sepperated Player HP/MP/XP text
   7. Made target percent an option so you can see true values when you target self or party member 

v0.1a

   1. Adds Text to Unit Frame Status Bars
   2. Adds Dead/Offline/Ghost text to all unit frames
   3. Changes health bar color as it decreases
   4. Status bar prefix is optional
   5. All status text can be shown as percent or real value (except target HP which is percent from server) 

Known Bugs: Party Pet Buff/Debuff tooltips don't show. 		