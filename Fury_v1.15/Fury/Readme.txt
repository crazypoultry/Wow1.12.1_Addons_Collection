Fury

This addon is an attempt at simplifying the DPS aspect of Warrior combat.

To use Fury, simply set up a key in the keybindings menu or make a macro containing /fury, and press this repeatedly when in combat. Each keypres will attempt to activate a warrior ability, running though a list with different requirements for each ability.

----------

Fury covers the following Warrior abilities:

Battle Shout
Berserker Rage
Bloodrage
Bloodthirst
Cleave
Disarm
Demoralizing Shout
Execute
Hamstring
Heroic Strike
Mortal Strike
Overpower
Pummel
Rend
Shield Bash
Whirlwind

Furthermore it also covers the talent Tactical Mastery, the PvP Plate Gauntlets (Hamstring improvement) and the Troll racial Berserking.

----------

The current logic being used is outlined below:

Dismount (Mounted only)
Berserker Rage (Feared only)
Execute
Overpower
Pummel / Shield Bash
Hamstring
Rend (PvP only)
Berserker Rage (PvE only)
Bloodrage
Berserking (Troll racial)
Disarm (PvP only)
Demoralizing Shout (PvE only)
Battle Shout
Mortal Strike / Bloodthirst
Whirlwind
Heroic Strike / Cleave

----------

Slash commands:

/fury - uses Fury
/fury help - prints help text
/fury toggle - toggles Fury
/fury debug - toggles debug mode
/fury attack - toggles the use of autoattack. Experimental.
/fury threat - enables Cleave or Heroic Strike based on current settings

/fury ability <name> - toggles the use of abilities. Must use correct names with capitalization, ie. Heroic Strike, Rend etc.
/fury dance <number> - sets rage allowed to be wasted when switching stance ("dancing")
/fury attackrage <number> - sets minimum rage required when using Heroic Strike or Cleave
/fury rage <number> - sets maximum rage allowed when using abilities to gain rage
/fury bloodrage <number> - sets minimum percent of health required when using Bloodrage
/fury hamstring <number> - sets maximum percent of health allowed when using Hamstring on NPCs
/fury berserk <number> - sets minimum percent of health required when using Berserk
/fury stance <name> - sets stance to return to after switching stance. If default is selected it will return to your last used stance. If no stance is selected it will disable stance switching. Must use correct names with capitalization.

----------

I'd like to give a special thanks to sarf and Trimble Epic, my two mentors who put me on the road of addon-making. Also thanks to Shears of Emerald Dream for extensive testing.

----------

1.15
- Updated TOC for 1.12
- Fixed Berserk (Troll racial)
- Fixed small error with spell interrupts
- Embeded IsMounted
- Added support for Shield Slam
- Disabled the use of Demoralizing Shout in PvP
- Added an option to define how much rage is needed before using Heroic Strike / Cleave. Default is 40. /fury attackrage <number>
- Fixed the Hamstring on runners issue introduced by 1.12

To-do:

Add Default Settings

Will of the Forsaken - active. Activate to become immune to Fear, Sleep, and Charm effects. Can also be used while already afflicted by Fear or Sleep - lasts 5 sec - 2 min cooldown
No Hamstring when enemy uses Blessing of Freedom
Stoneform - active. While active, grants immunity to Bleed, Poison, and Disease effects. In addition, Armor increases by 10%. Lasts 8 sec. - 3 min cooldown