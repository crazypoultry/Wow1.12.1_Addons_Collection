------------------------------------------------------------------------------------------------------
-- HolyHope 2.4

-- An addon for Paladins
-- Benedictions and Seals management, Shows how many symbols are left and mounts as well ^^

-- Many Thanks to the creators of Necrosis and KingsCounter
-- Special thanks to Erosenin, Designer of HolyHope

-- If you wish to report a bug or would like to suggest any ideas, please mail to: THEFREEMAN55@free.fr
------------------------------------------------------------------------------------------------------

Installation:
 WARNING!!! : If you have HolyHope already installed, please remove the old folder in order to install the newest one.
 Extract HolyHope_X.X.zip to the following directory : \World Of Warcraft\Interface\AddOns\

Particularities:
BLESSINGS:
 - Manage rank of blessing based on level of target.
 - The main dial shows the number of symbols you have in your inventory, this will be displayed via a dial and a gauge.
 - If you have reckoning charges it's show them.
 - LEFT click on the dial and it’ll switch between Individual/Class blessings cast modes.
 - RIGHT click on the same dial will start casting your recall stone.
 - The dial changes colour when you enter combat mode.
 - One LEFT click on a blessing “charges up” the cast, RIGHT click on it and it’ll self-cast.
 
SEALS:
 - The main dial shows the cool down of  the judgement ; the icon changes if you’re able to cast the judgement (a seal is active)
 - LEFT click on the dial to ‘judge’ the target.
 - Click on a seal to cast it.
 
MOUNTS:
 - One click on the mount will summon the mount of the highest level (level 40 or 60), if you’re in Ahn’Quiraj and that you have a Quiraji mount, it will then be summoned instead.
 - If you HAVEN’T GOT the Paladin epic mount, but that you’ve got another fast mount, then it’ll be summoned instead as well.

MISC :
 - Manage Reckoning's charges.
 - Manage Redemption.
 - Manage Hammer of Wrath.
 - Displays cool downs.
 - Different types of help panels: Partial (only shows the amount of mana the cast costs), Total (Game tooltip), and also the possibility of deactivating it.
 - Only displays the blessings and seals you have.
 - Key bindings for every blessing, seal and mount summoning.
 - You can move HolyHope wherever you want on your UI.
 - Type /holyhope ou /hh in order to open the option panel of HolyHope.
 
-----------------------------------------------------------------------------------------------------
CHANGE:

Version 2.4:
- Add: Reckoning's Charges Counter... (thanks to Notta/Hamok CdO).
- Add: KeyBindings for Normal Mount (tiger, horse etc....).
- Change: Right Clic on Mount button for Normal mount.
- Change: HolyHope Menu have been improve and recode for best use. Tabs have been include.
- Fix Bug: Redemption's Popup is now show when target have release his spirit (is a gost).
- Fix Bug: Blessing By Level when paladin have no target (thanks to Notta/Hamok CdO).

Version 2.3:
- Add: Traditional Chinese Localisation.
- Fix Bug: Bug when player have not target.

Version 2.2a:
- Change: some localization on DE version.
- Fix Bug: Level show on right clic on might blessing.
- Fix Bug: Rank of AQ blessing is working now.


Version 2.2:
- Add: Redemption Pop-Up
- Add: Manage rank of blessing based on target level
- fix bug: Show blessing on new spell learn
- change: improved code for On_Update


Version 2.1:
- Add: Show Hammer of Wrath when Paladin can cast it.
- Add: Default config on fisrt load.
- Add: Message on HolyHope toogle.
- Change: Improve HolyHope code for best Load and update.


Version 2.0a:
- Add: German compatibility and translation for this version
- Fix bug: Judgement's tooltip on partials tooltips.
- Fix bug: Seal of the crusader on EN version


Version 2.0:
- Add: Manage of all Seal and Judgement
- Change: Slash command change in menu: /holyhope or /hh to open it
- Change: Mount button is now a independant button, you can move it where you want
- Fix bug: all bug of 1.2a (I hope^^)


Version 1.2a:
- Add German compatibility and translation 
(Big Thanks to Faryn^^)


Version 1.2:
- Fixe bug: Kings blessing on toogle activity
- Fixe bug: On English version for MOUTN_ITEM
- Fixe bug: attempt to concatenate field '?' ( nil value)
- Add Key bindings for all blessings (same bindings for Class/Individual blessing)
- Add All Steed manage: if you HAVE NOT Paladin's epique mount but an other one, this one is use.
- Change command: /hh toogle, for toogle activity instide show/hide


Version 1.1a:
- Fixe bug: attempt to call global `TextParse` (a nil value)


Version 1.1:
- Fixe bug with blessing of Kings and Sanctuary
- Add Global Cooldown
- Add Blessing of Freedom Cooldown
- Add 2 type of GameTooltip for all blessing: Partial and Total
- Add command: /hh
  - show/hide: show/hide HolyHope
  - tooltip0/tooltip1/tooltip2: For Tooltip Mod: disable/partial/total
  - lock/unlock


-----------------------------------------------------------------------------------------------------
-- Author:
-- Freeman

-- Avatar:
-- Freeman, Exodius Guild, EU-Ner'Zhul
-----------------------------------------------------------------------------------------------------

