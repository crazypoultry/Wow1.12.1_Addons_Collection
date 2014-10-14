How to use
----------

Click on the tracked blip(s) in radar to display a selectable popup menu
containing indepth details of the blip(s).

Move mouse cursor away from radar or the popup to close the menu.

You may select from the popup menu to acquire the blip as target if it is
still within range. Then, a ping will be generated on the last known location
of the target, and your party will receive a message with information on your
target.

Move mouse cursor away from radar or the popup to close the menu.

Shift-Click on radar to generate a normal ping.


Version History
---------------

Version 1.2 (10 Feb 2005)
- Added ReadMe.txt
- Added health percentage to player targets in dialog display.
- Removed "PLAYER: -" from player targets in dialog display. ICU is made for
  PvP, too much information is not good.
- Tweaked somewhat, and added more comments. It seems declaring local global
  table causes memory leaks in LUA.
- Added ##OptionalDeps: MapNotes to the toc file. It should work with Cosmo
  MapNotes. Thanks to Diungo on curse-gaming.com

Version 1.1 (28 Jan 2005)
- Fixed bug with crashing when targetting indoor units.

Version 1.0 (26 Jan 2005)
- Initial release.


Known Issues
------------
This Addon works great as a targetting mechanism in PvP but very poorly
in PvE. A word of warning, refrain from clicking on a bunch of mob blips
on the radar while in combat. One to three mob blips should be fine.
Otherwise, you may just end up shooting something else and draw aggro.

TargetByName() works by taking a provided name string, and searches for
the a target nearest to the player. However, NPC names (mobs included) are
NOT unique. So you will see many odd behaviour when you attempt to target
NPCs. This cannot be help unless Blizzard provides some better targetting
mechanism.

As it is, this Addon provides sufficient advantages to the Hunter Class
in PvP for the Battlegrounds. That was my goal.
