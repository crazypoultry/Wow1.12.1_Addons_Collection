Please send feedback to Ygrane.Dawnfire@gmail.com

Summary:

SqueakyWheel is a prioritized complementary party/raid frame.  It is 
not intended to replace the existing frame.  Where possible, existing
AddOns have been used to provide functionality and customization.

Description:

The SqueakyWheel displays the top targets for healing, sorted by health 
and rough proximity.  Left Click on the border in order to drag 
the window around.  SqueakyWheel will use CT_RA integration for 
click-casting functionality from functions such as CastParty, WatchDog, 
and RaidRave.  Otherwise, the unit will be targetted.  Targets not in 
range or visible will be a dark grey.  Targets definitely visible will 
range from red to green based on their health percentage.  Targets that 
may or may not be visible fade from red/green to medium grey based on 
the likelihood that they are visible.  Failed spellcasts will place the
unit on a blacklist, making them temporarily low priority.  CastParty
text customization will be utilized if available.

Notes:
Default settings are stored in SqueakyWheel_Config.lua
After modifying the config file, "/squeak reset" is needed to load the new defaults.
drag the border in order to drag the window around.
Buffs and Debuffs are not tracked.  (use Decursive)
Dead people are not a priority.  (BG rezzes)
/script TargetUnit(SqueakyWheel.GetSortOrder(1)) will target the first person on the SqueakyFrame.

Optional:
menu.xml, menu.lua - contains config GUI.  remove if not needed.
SqueakyWheel_CTRA_EM.lua - contains CTRA_EM integration.  remove if not needed.

Usage:
/squeak, /squeak config, or /squeak menu: Displays GUI
/squeak help: displays command line options

Rationale:

Update -- I am now a Warlock actively raiding in a guild that requires
CT_RA for every member, due to the many positive aspects of it for raid
coordination.  My focus has now been to work with CT_RA rather than become
a minimal replacement for it, and I have less time to work on it, since
my primary class does not contain a heal.  As a result, the new features 
shown are designed to work within the confines of CT_RA.  My goal is still
to change the healing paradigm of watching 40 bars.

The original impetus for the creation of SqueakyWheel was my first 
experience in Warsong Gulch.  I was in a disorganized pickup raid, 
and there were people constantly dying around me.  One or two 
of those people dying could really use a heal, but I kept getting 
distracted by the people dying halfway across the map.

Downloads:
http://www.curse-gaming.com/mod.php?addid=2205
http://www.wowinterface.com/downloads/fileinfo.php?id=4277

Version History:
2006.09.15: removed the need for Translator.lua
2006.08.28: bug fixes
2006.08.15: bug fixes
2006.08.09: bug fixes, honest
2006.08.02: group assignments, mana/rage, aggro, and GUI colorization
2006.08.01: bug fixes and some refactoring
2006.07.27: class color options
2006.07.26: bug fixes, tabbed GUI
2006.07.18: some refactoring for improved performance
2006.07.06: toggleable locking (no more shift-drag)
            showall setting:  Hides uninjured raid members when unset
            lock and showall command line options
2006.06.29: bug fix for player's priority.
            Additional optimizations when joining raid group.
            CT_RA Emergency Monitor style key bindings
2006.04.28: bug fix for clicking on empty bar
2006.04.20: quick fix for CastParty 3.9 (CastPartyConfig)
2006.04.18: event optimization on zoning to reduce blue bar.
2006.04.06: optimized update model, Config GUI (thanks Velora!),
            CT_RA Emergency Monitor integration, Pet and CT_RA Main Tank 	      priorities, min health threshold
2005.11.18: Slash commands, class prioritization, CT_RA_CustomOnClickFunction,
              Squeaky_CustomOnClickFunction, configurable colors
2005.10.24: Up to 15 targets supported, bar spacing and visibility option added, internals refactored
2005.10.14: Out of Range bug fix, default debug mode changed to false
2005.10.13: Party priority, configuration file, 1.8 toc
2005.09.27: Right/Middle/4th/5th button support, RaidRave support
2005.09.13: 1.7 toc
2005.09.02: Implemented blacklist mechanism similar to Decursive
2005.08.26: Switched to much simpler UNIT_COMBAT event.
2005.08.19: Initial release
