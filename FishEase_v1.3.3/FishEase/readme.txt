FishEase
by Aalny
version 1.3.3

Download Location:
http://wow.dvolve.net/dropbox/wow/FishEase_1.3.3.zip
Mirrors:
http://www.wowinterface.com/list.php?skinnerid=14585
http://www.wowguru.com/db/users/aalnydara/
http://www.curse-gaming.com/mod.php?authorid=1215

---------------------------------------------------------------------------
Description

This Addon helps people use the Fishing tradeskill more efficiently by
making it easy to cast and easy to switch between fishing gear and normal
gear.  When a fishing pole is equipped, right clicking will cause the
player to cast their line. Type "/fishease help" in game for instructions 
on additional features.


---------------------------------------------------------------------------
Features

* EasyCast allows right-click casting while a fishing pole is equipped.
* ShiftCast requires that Shift is held down in order to right-click cast.
* Switch command allows swapping between normal and fishing gear sets.
* Reset command clears all saved gear sets.
* Key bindings are available to "Start Fishing" and swap your gear.
  The "Start Fishing" binding will equip your fishing pole if it's not 
  already equipped.  Otherwise, it will cast or re-cast your line.
  

---------------------------------------------------------------------------
Known Issues

* None yet. ;)


---------------------------------------------------------------------------
History

1.3.3
* Toc updated for WoW 1.11 patch
* Removed what was left of the FastCast feature since it's likely not coming
  back.

1.3.2
* Right-clicking problems in the game world since 1.10.1 have been fixed.
  The patch made it so that mouse clicks that are being hijacked no longer
  get passed through to the game world.  So I've had to move and add some 
  logic that does a better job determining if the click gets hijacked or not.
* The 1.10.1 WoW patch has also effectively broken FastCast for good I think.
  This is for the same reason regarding hijacked clicks no longer getting
  passed through to the game world.
* Changed some logic in the ADDON_LOADED event handler to do case-insensitive
  matching in case the file/folder capitalization gets changed in the zip 
  extraction process.  /nod Peter

1.3.1
* Whoops.  Fixed a nil reference bug for characters who don't have the 
  fishing skill. Thanks Granon.

1.3.0
* Right-click casting is back thanks to a loophole the TackleBox devs found
  in the new mouse hooking restrictions in 1.10.  We'll see how long it
  lasts.
* Added some more color to the help text to make it slightly more readable.
* Started work on a new way to right-click fish that will be "legal" in
  the post-1.10 world. Some of that code is in this version, but it's not
  near finished so don't use any undocumented commands unless you can fix
  what you break.

1.2.9
* Updated for the dreaded 1.10 patch. Unfortunately this means no more
  right-click casting.  While I understand Blizz's intentions in regards to
  disabling mods that are against the spirit of the mod environment, it's
  a pity that it also affects the benign mods that made use of movement and 
  mouse hooking functions.

1.2.8
* Updated german translation to be more complete.  Thanks Xinari.

1.2.7
* Updated toc for 1.8.0 patch.

1.2.6
* Added support for boots in the fishing gear set due to the new boots,
  Nat Pagle's Extreme Anglin' Boots, from the fishing competition.
* Added key binding to cast your line.  If your fishing pole is not equipped
  when you press the key, it will swap your gear for you instead.

1.2.5
* Updated toc for 1.7.0 patch.

1.2.4
* Added a direct key binding to swap between fishing gear and normal gear.
  so you don't have to waste a macro slot anymore for the slash command.
  Suggested by Gohei27.
* Removed load spam.

1.2.3
* Updated toc for 1.6.0 patch.

1.2.2
* Fixed a bug for people using Click-to-Move.  It is now disabled while
  you're holding a fishing pole if EasyCast is enabled.  Thanks to Novbre 
  and nranking for the heads up.

1.2.1
* Fixed a bug where only 1 of 2 identical dual-weilded weapons would be
  re-equipped using the switch command.  Thanks to Richard for the heads up.
* Fixed a bug that would popup a nil error when fighting/looting while
  unarmed.  Thanks to Moonshadow for the heads up.

1.2.0
* Renamed Addon from TackleBoxSA to FishEase to avoid confusion with
  TackleBox in Cosmos and to try and make sure there are no namespace
  conflicts. (yes, it's a silly name, but my girlfriend thought it was cute)
* Code performance tweaks here and there.
* Fishing skill location is updated on spell update event rather than
  checking for every cast.
* Fishing skill location is searched for by icon texture rather than
  name which gets rid of another localization challenge.
* Fishing pole is now recognized by Texture rather than itemID. Not only
  does this automatically add support for the new pole, 
  "Nat Pagle's Extreme Angler FC-5000", but it also theoretically supports
  any other new poles that find their way into the game.
* Re-added hats to the saved gear sets per the request of some roleplaying
  type people who like a different look when they're fishing.
* Added a new "Shift Cast" toggle that when turned on requires the Shift
  key to be held down when casting with a right-click.  This is turned off
  by default.  To change the setting, use the /fe shiftcast command.

1.1.0
* Updated toc for 1.5.0 patch
* Gear sets and casting options are now saved per character. Sorry about 
  the delay on this one.  The 1.5 patch fixed the Lua environment in such 
  a way that doing this is much easier now than it would've been before.

1.0.3
* Thanks to Sylvaninox for providing more of the French translation.
* Minor internal code changes and some prep for per-character data saving.

1.0.2
* Thanks to Maischter for providing a more complete German translation.
* Fixes some string formatting so the translations would work better.

1.0.1
* Fixed an annoying bug that would reset your gear sets on every login.
  (forgot to remove some old code)
* Fixed a minor bug that would cause the saved gear sets to get confused
  if your saved main hand weapon was 2h and then you switched to 1h+shield
  combo.  Only the shield would end up getting equipped.

1.0.0
* Initial fork from TackleBox version 4150 on Curse-Gaming:
  http://www.curse-gaming.com/mod.php?addid=97
* Removed all remaining Cosmos related code
* Easycast and Fastcast are now on by default
* Since apparently the Lucky Fishing Hat doesn't exist in game anymore,
  hat saving has been replaced with glove saving because you can get
  gloves enchanted with fishing skill.
* Changed the core method used to find, examine, and equip items.  It now
  uses the item ID from the item link rather than the item tooltip.  This
  was primarily because searching for fishing poles based on tooltip was 
  problematic in different locales.  The change also has the pleasant 
  side effect that MUCH less data needs to be saved in SavedVariables.lua.
* Simplified the slash command processing code a bit.
* No more automatic macro creation because it was buggy and unneccesary.
  You can create your own macro with "/fe switch"
* The command help text was tweaked a bit for clarity and formatting.
* Renamed most of the internal variables so that theoretically nothing
  will conflict if the user has the Cosmos version installed as well.
  However, there will still most likely be issues because the slash
  commands are the same and who knows what'll happen if two addons
  try to do the same thing at the same time.
