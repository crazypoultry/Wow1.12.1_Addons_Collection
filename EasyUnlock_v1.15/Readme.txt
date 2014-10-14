-- EasyUnlock v1.15 by Athaeus (J. de Gram) - j.de.gram@gmail.com

-- Requirements --
World of Warcraft 1.10.0+ EN, DE (FR, KR and such are currently not supported unless someone can provide me with some translations)

-- How to install --
Copy the EasyUnlock directory to C:\Program Files\World of Warcraft\Interface\Addons\ (Assuming you installed WoW at the default location). If the .\Interface\Addons directory does not exist you should create it manually.

-- Description
This mod adds an 'Unlock' button to the trade window. Whenever you're trading someone and a lockbox or junkbox is put into the enchantment slot, the button will become clickable, which allows you to unlock the box using just a single click instead of having to browse through your whole spellbook to find the Pick Lock skill. If your lockpicking skill is too low to open the box in the enchantmentslot the mod will send a whisper to the person you're trading telling him/her that you cannot open the box, together with your current lockpicking level and the requirement for the box.
Additionally, it allows you to unlock lockboxes in your inventory by rightclicking them.
Version 1.10+ now also features the required lockpicking level added to the tooltip, so you can easily see whether you can unlock a box or not (this also works for itemlinks you click on in chatchannels). Required lockpicking levels will also be displayed for non-rogues.

The lockbox-unlock level requirements were taken from Worldofwar and the US World of Warcraft Rogue forums. If any of these values happen to be incorrect, or if you know of any other lockpickable boxes please let me know.

If you're playing a different class than a rogue, or if you do not have the Pick Lock skill yet no unlock button will be shown - the trade window will have the default appearance.

Suggestions, bugs or any comments are appreciated.

-- Changelog --
v1.15 // 31-03-2006
- Rightclicking a locked lockbox in your inventory will 'cast' lockpicking on it.
- Fixed a bug where a box with a requirement that exactly matches your lockpicking level would show up as not unlockable.
- Added Link Wrangler support (not a dependency). You will need v1.39 or newer.
- Interface version updated to 11000 (1.10.0).

v1.14b // 02-01-2006
- Fixed. For real.
- The line added to the tooltip is now orange in case of an unknown requirement.

v1.14 // 31-12-2005
- Fixed the tooltip, as a syntax error accidentally made it into the release of v1.13
- Added the German translation of the box I added in v1.13. Thanks again schr0nz.

v1.13 // 30-12-2005
- Reviewed lockpicking requirements.
- Added Battered Chest (German localization missing on this one).
- Lockboxes with an unknown level requirement now show a question mark on the tooltip instead of zero.

v1.12 // 16-12-2005
- Fixed bug where the unlock button would occasionally not enable due to events being fired too early - Something caused by Blizzard's code.
- Fixed bug which would cause the unlock button to disable if the skill failed due to being mounted.
- Updated one lockbox requirement level.

v1.11 // 02-11-2005
- Added German localization. Thanks schr0nz!
- Lowered the Battered Junkbox level to 75 (still not the exact level).
- Interface version updated.

v1.10 // 24-09-2005
- Added the required lockpicking level to open a box to the item tooltips.

v1.00 // 07-09-2005
- Initial release, supports english clients only.