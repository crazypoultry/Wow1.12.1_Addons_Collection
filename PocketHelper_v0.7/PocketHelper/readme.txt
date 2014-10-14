PocketHelper - Helping decent rogues make a better living
---------------------------------------------------------------------------

PocketHelper is designed to ease the life of a rogue attempting to pick
pockets. When in stealth with an active target, it places a Pick Pocket
action button in the middle of the screen. If a target's pocket is picked
successfully, it then replaces the button with the next item from the
loot window.

Thus you can click the same place repeatedly to pick pocket and loot, this
makes the process much faster than having to move the mouse over the loot
window etc.

To work, you must have the Pick Pocket skill somewhere (anywhere, it
will find it) on your action bars.

You can use the following commands to configure the addon:

/pockethelper                 Get command usage and current version/config
/pockethelper enable          Turn on pockethelper
/pockethelper disable         Turn off pockethelper
/pockethelper scale <num>     Set button scaling (default 1.25)
/pockethelper alpha <num>     Set action alpha (default 0.5)
/pockethelper xoffset <num>   Set X offset (default 0, can be negative)
/pockethelper yoffset <num>   Set Y offset (default 0, can be negative)
/pockethelper inrange <flag>  Set whether to hide if out of range (0/1)
/pockethelper checkcombat <flag>  Set whether to hide if target in
				  combat (0/1)
/pockethelper reset           Reset all settings

There's also a keybinding you can set to toggle whether pockethelper is
active or hidden.

If you can provide missing localizations, please email me with the
appropriate locale specific strings, at the very least with then name
the Pick Pocket spell in your locale, and what the locale is
(Email: iriel@vigilance-committee.org) and I'll update the addon
accordingly.

v0.7 - 2006-03-27
  * Fixed tooltip scanning for 1.10

v0.6 - 2006-01-03
  * Fixed detection of skill usability

v0.5 - 2005-07-21
  * Fixed frFR localization.
  * Keeps loot button visible longer if target moves away but loot is
    still open.
  * Added checkcombat option.

v0.4 - 2005-07-19
  * Added frFR localization for spell name.
  * Added options (do /pockethelper to view).
  * Added hide/unhide toggle key binding.
  * Added optional range check mode.

v0.3 - 2005-07-18
  * Added deDE localization for spell name.
  * Moved many of the global symbols into a table for cleanliness.
  * PocketHelper button is set to 50% alpha to be less obtrusive.

v0.2 - 2005-07-18
  * Fixed shift-drag problem.

v0.1 - 2005-07-17
  * Initial version.
