StanceSets3 - v1.6.3

===========
Quick Start
===========
This add-on includes the WeaponQuickSwap addon in it.
http://capnbry.net/wow/

Unzip the contents of the zip archive into your WoW game directory. 
Make sure you "Use folder names" so the files end up in the right
place.  You should end up with:
  <wowdir>\Interface\AddOns\StanceSets3\Bindings.xml
  <wowdir>\Interface\AddOns\StanceSets3\localization.lua
  <wowdir>\Interface\AddOns\StanceSets3\readme.txt
  <wowdir>\Interface\AddOns\StanceSets3\StanceSets3.lua
  <wowdir>\Interface\AddOns\StanceSets3\StanceSets3.toc
  <wowdir>\Interface\AddOns\StanceSets3\StanceSets3.xml

Typing /stancesets will open the stance set configuration dialog.  Drag and drop
the weapons you want equipped for each set into the containers, starting from 
the left.  If you want to make sure the first set is in your hands when you
assume that stance / form, check the "Equip first on activate".  If you do not
have this checked, and the weapons in your hand match one of the sets from your
new stance, no swap will occur.  To remove a weapon, drag it off the slot.

Up to 3 sets of weapons can be available for each stance.  To cycle through
them, use "/stancesets next".  The addon will loop around to the beginning of 
the list when it sees the first empty mainhand slot, so:
weapon1,weapon2    blank,weapon3    weapon4, weapon5
will not cycle at all if your hands are already holding weapon1 and weapon2.
If you don't have any matching set in your hand when you call "next", the first
set will be put in your hands.
Additionally use "/stancesets set1" to select directly set1. also set2, set3.

The panel toggle and set cycle can be bound to a key combination.

** CapnBry **
 Modified by Smuggles
 Modified by Tageshi


-8 configurable sets available
-window now movable
-myAddons support
-window graphics changed
-window resizes now
-simply implemented weapon quick swap into this
-will now save different settings for each server / realm ( will erase your data v11 and below )
-new slash commands to change between sets of present stance (set1,set2,set3)

Thanks to Hackle (on Icecrown) for validating my stance list code and tracking 
	down the (A, )->(B,C) bug.
Thanks to Richard Hess for fixing the missing sound problem.

Version History:
13
-adjusted to ver 1.6.0
12
-will now save different settings for each server / realm ( will erase your data v11 and below )
-new slash commands to change between sets of present stance (set1,set2,set3)
11 - adapted to patch 1.5.0
10 - Fix for "Duplicate header" error in FrameXML.log.  Thanks to James Stuart
		 for pointing this out.
9 - Interface version 1300.
8 - Interface version 4216.
7 - Interface version 4222.
6 - Interface version 4211.
5 - Fixed drag n drop support to stance item buttons.
	  Fixed missing sound when opening and closing stance set frame.
	  Fixed problems with (A, )->(B,C) swaps, where (A, ) would always stay equipped.
4 - Added sounds to dialog open and close.
3 - Fix for not being able to add weapons to a new set
2 - Fix for "Attempt to index StanceSets, a nil value"
1 - First release (2004-12-30)
