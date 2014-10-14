Group Heal v1.5 with RaidHeal v1.5 (11000)

This AddOn is designed to add a healing button beside the portrait of each party member that the player can simply click on to cast a healing spell on that party member. The intention is for the mod to automatically scale the rank of healing used based on the current health of the member being targeted. Upto 3 spells per target are supported, with Priest's Lesser Heal, Heal and Greater Heal being scaled as one spell. The mod also adds an option to bind keys to each of the 15 buttons.  Healing spells that are level restricted, such as Renew and Regrowth are scaled based on the target's level instead of their current health.  The affects of +Healing Gear are taken into affect when choosing spell ranks, but buffs that add to healing affects such as Blessing of Light are not accounted for.  

Mana Conservation System
By default mana conservation system will cancel the current heal being cast if 50% or more of the spells minimum direct heal will be wasted (ie. the target has been healed by some other means).  The Mana Conservation system now only performs its check when you click a heal button or press an assigned key-binding.  A Keybinding for a conditional cancelation button should make it into the next version.  
The sensitivity of the auto-cancel can be adjusted on a per-spell basis. 
If in a Raid, the AddOn only begins checking for this condition during the last 0.5 seconds of casting.  If in a regular group or solo, the AddOn will actively check and can cancel a heal spell at any point during the casting of the spell.  Please note that this feature only works if you have used GroupHeal or RaidHeal to cast the spell.  

Range Checking
GroupHeal now supports a limited form of range checking.  Target's whose buttons are definately out of range are fully shaded in red as before, while units who are visible, but outside approx. 28 yards will be partially shaded because they may be in range.  Targets who are definately in range (ie. within about 28 yards of the player) will not be shaded red at all.  Furthermore, exact range checking will be performed for your current target if that player is in your group.  
In short:
-Fully Red Shaded means they are definately not in range.
-Partially Red Shaded means they might be in range.
-No Red Shading means the target is definately in range.

This AddOn does not use any ActionBar slots.

The RaidHeal extension included with this AddOn extends the capabilities of GroupHeal to the Raid environment.  RaidHeal currently supports CT_RaidAssist, Nymbia's Perl Unitframes and the default Blizzard Raid UI.

Configuration

Type /groupheal to open GroupHeal's settings window
Type /raidheal to open RaidHeal's settings window

Supported UI AddOns (including supported Custom Unit Frame AddOns)
-CT_RaidAssist
-DruidBar
-Nymbia's Perl Unitframes (Not Target Buttons)
-Nurfed_UnitFrames
-Classic Perl Unit Frames (Perl_Player, Perl_Target & Perl_Party)
-Gypsy_UnitBars


VERSION HISTORY
v1.5.2
-updated for WoW 1.12
-fixed a bug where target buttons would continue to show if you selected a non party/raid member after having a party/raid member as your target without clearing your target first
-update to the French localisation
-fix for the Auto Self-Cast option (added in WoW 1.12) being enabled
-fixed the erroneous over-heal warning that could be shown if the player was casting a healing spell when they died

v1.5.1
-updated for WoW 1.11
-added a key binding to conditonally cancel spell casts (without attempting to start another one)
-added an overheal warning display
-added all sorts of options to the GroupHeal config for the Mana Conservation system

v1.5.0
-updated for WoW 1.10
-Mana Conservation now only functions when you click one of the healing buttons or assigned keybindings
-a spell will no longer start casting if Mana Conservation would have immediately cancelled it in the past
-the Weakened Soul indication for Power Word: Shield now takes the form of a 15 second, target specific, "cooldown" indicator
-added French and German translations of the spell data which will allow GroupHeal to work with French and German clients (the UI has not been translated yet)
-various performance upgrades
Known Issues:
-Target buttons disappear sometimes when they should not

v1.4.5
-removed another peice of debugging code (Sorry!)

v1.4.4
-removed some debug code that wasn't meant to be in the release version
-added a new check so that the code that deals with +healing gear doesn't rescan equipment more often than is needed

v1.4.3
-fixed a bug with the Power Word: Shield Button where it would not grey out for insufficient mana
-moved the Buttons back to their v1.3 position for Perl_Classic Party Frames when using Compact Mode

v1.4.2
-fixed a bug where the Power Word: Shield Button would only show Rank 1
-fixed a bug where the Power Word: Shield Buttons for Group Members were too big
-fixed a bug with RaidHeal where Power Word: Shield Buttons would give Error Messages when you tried to show them
-fixed a bug preventing the Power Word: Shield Buttons from showing for Custom Unit Frames
-Added Key Bindings for Power Word: Shield

v1.4.1
-added support for Rejuvination (Rank 11) and Renew (Rank 10)

v1.4
-added buttons for the Priest spell, Power Word: Shield
-added code to account for +Healing gear (Buffs like Blessing of Light are not checked)
-updated support for Gypsy UnitFrames to support the latest version
-added an option to not show Tooltips for the Healing buttons
-added Target button support to most of the Non-default supported UnitFrames

v1.3
-added heal buttons and keybindings for healing your current target (if they are in your party)
-added a limited form of range checking
-added support for Classic Perl Unit Frames (Perl_Player & Perl_Party)
-added support for Gypsy_UnitBars 
Know Issues: 
-Target Buttons only work with the default Target Frame

v1.2.1
-config windows are now openable when dead
-if you click a button whose target is dead, you should no longer sometimes heal another target

v1.2
-added support for Nymbia's Perl UnitFrames, (both GroupHeal and RaidHeal)
-GroupHeal: added support for Nurfed UnitFrames
-RaidHeal: added support for Blizzard's default Raid UI
-RaidHeal: added button for Priest's Renew and Druid's Rejuvination spell
-RaidHeal: added settings to allow user to choose where each button is placed in relation to its target's info frame.
-RaidHeal: added sliders to allow the user to customize the exact placement of the buttons:
	Horizontal Offset: the lower the value, the closer the button moves to it's target's frame
	Verfical Offset: lower values move the buttons lower on the screen
	Button Spacing: increase this setting to increase the vertical space between buttons on the same side of their target's frame 
-GroupHeal: added sliders to allows the user to adjust the sensitivity of the auto-cancel system
-fixed a bug with the spell cancellation messages that was causing them to not always fire where when the player was interrupted by an external action
-fixed a bug with the buttons that was causing them to not dim when the player didn't have enough mana to cast their spell
-fixed a bug with the tooltips that was causing the active tooltip to not update as often as it should
-cleaned up code and increased efficiency of the functions that update the button's texture's etc.
Known Bugs
-RaidHeal's Key Bindings will not be saved properly by the game, this problem will be fixed by the WoW 1.9 patch

v1.1.1
-Updated UI version number
-Changed settings to be Per Character Name (characters on different realms with the same name will share settings)

v1.1
-Extended spell support to include upto 3 spells per class
-auto-cancel system has been improved when being used in a Raid group
-Heal reporting system added that will notify Group members when a heal is incoming and when an incoming heal has been canceled
-added GUI for customizing settings

v1.0
-Tested and released for the WoW 1.7 patch

v0.7
-added visual indication for targets that are way out of range
-added visual indication of which target is currently being healed
-added basic support for Shamans, Priests and Paladins

v0.6
Added a compaion AddOn called Raid Heal which integrates with CTRaid and adds a heal button next to each member of the raid.

v0.5
-added auto spell cancel system: This system will auto cancel the current spell if 50% or more of the Heal's affect will be wasted
NOTE: you DO NOT need to maintain your target for the auto-cancel system to function correctly

v0.4
-added support for the DruidBar addon (if present)
-fixed a spell targeting bug
-added visual indication of whether player has enough mana to cast the spell

v0.3
-spell info now properly loads during log on
-buttons are showing again

v0.2
-Only key binding functions work in this version

v0.1
-Buttons and spell info only load when the player manually reloads the ui.
