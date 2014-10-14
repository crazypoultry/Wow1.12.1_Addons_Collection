======================
Panza 4.122 2006-10-03
======================

Features Added
--------------
PMM
* oRA2 Frame support (included with oRA)
* Tooltips include website links for Frames

POM
* Option to judge SoC or SoJ at beginning of cycle, for maximum threat generation

Fixes
-----
* oRA frames fix.
* PerfectRaid Frames Fix.
* Non-Blizzard Frames will not cause nil errors on CycleNear.
* CycleNear will usually clear target on completion.
* all "for in" loops converted to "for in pairs()". Prep for Burning Crusade.

======================
Panza 4.121 2006-09-29
======================

Features Added

TitanPA
* Feather Count for Mages

Fixes
* Feather Count for Priests in Status Screens (Panza and TitanPA)
* Set Bars button in PHM Advanced fixed.

======================
Panza 4.12 2006-09-29
======================

Features Added
--------------
PMM
* AG Unit Frames Support
* oRA Unit Frames Support
* Squishy Emergency Monitor
* X-Perl Added to Perl Support. Tooltip Changed.

PCM
* Druid Cure Poison added

POM
* "/pa setseals seal1 seal2" command added to allow macros to change the seals
* "/pa setpvpseals seal1 seal2" command added to allow macros to change the seals
		Seals:
		sol		- Seal of Light
		sow		- Seal of Wisdom
		sor		- Seal of Righteousness
		soj		- Seal of Justice
		soc		- Seal of Command
		sotc	- Seal of the Crusader
* Disable Seal2 when Seal1 is soc or sor
* Reposition button added

PPM
* Switch added to allow panic to be checked with every AutoHeal

API
* PANIC check option added to PanzaWill
* Added function that action bar addons may call to set Panza Macro tooltip text. In PanzaAPI

GUI
* Context sensitive (i.e based on your class and spells) menu added for option selection

General
* RDX MainTank detection added
* oRA Maintank detection added
* Auto-Select Hammer of Wrath keybind and macro added, will attempt to target an ememy player in front of you and cast Hammer of Wrath if their health is less than 20%
* Improved ActionBar range updating when spells/macros added/removed
* Will endeavor to stop wanding to allow heals and PWS to cast
* Messages made more efficient and robust

Fixes
-----
Zone Healing Editor bug with apply/cancel buttons
No longer required to have real Rez spell on ActionBar, Panza Macro will do
Supress Moving error message when casting HoT
Fix for Casting Bar showing up if spells are cast before using the CheckBox in Main Dialog.
Tooltips updated for Zone Healing (Mana < and Mana >).
Mana Buffer Tooltip corrected.
Buff added to PMM for Shaman.
Realm added to name in BGs.
Group heal fix for losing friendly targets
/pa guildmsg command fixed.
CycleNear targeting improved.
Fixed nil error produced when using Individual Buffs.

======================
Panza 4.11 2006-09-13
======================

Features Added
--------------

PMM
* Satrina Frame support
* PerfectRaid Frame Support
* Sage Frame Support

PHM
* Regrowth flag added
* Cast DF/NS Out of Combat flag added
* Healing configuarions added for each "zone" on Healing Indicator Bar in PHM
* GroupHeal enabled for Shaman using Chain Heal
* Healing bonuses extracted for Libram of Divinity and Light
* cast HOT when moving flag added

PBM
* UI list added to control Individual Buffs (New button on PBM)

POM
* Will now auto attack as long as you have a valid target and Attack on your Action Bar

General
* New party/raid range checking for speed using SpellCanTargetUnit(unit)
* Panza will process healing messages from QuickHeal, in addition to Heart and Genesis.
* Priest Touch of Weakness buff added

Fixes
-----
Reverted PA:Message3() changes made post 4.0 release for speed.
Perl Frames Fix
Discord Unit Frames Fix
CTRA Frame Support Fix (tested w/CTRA 1.541)
Check values in PCM before displaying Slider controls.
Mage Party/Raid/BG buff fix
If a Pet is PVP it will be skipped if Skip PVP is enabled.
/pa listall will no longer cause a nil error if clearall has not been performed.
PanzaComm 3.01 Included.
French Localization fixes

=====================
Panza 4.1  2006-08-27
=====================

Features Added
--------------
New release incorporating all features added in the 4.1B train including:

* Perl Frame Support in PMM
* Sensible DCB default buffs for levels 1,2,3
* Cast HoTs when moving
* Priest Power Infusion added.
* Druid mid heal slider in PHM.
* Party Healing Limit slider disabled if no appropriate spell.
* Mage Armor added.
* SealMenu toggle key bind added.
* Settings for PFM rationalized.
* New slider on main opts page to allow you to change the minimap button graphic.
* Spell Start/Stop events added to unit tests, now possible to do a full bless cycle.
* Buff Cycle reset command (/pa resetcycle) and keybind added.
* Mage class: allows AI, Frost Armor, Dampen Magic, Amplify Magic, and curse removal.
* Shaman Lightning Shield, Weapon Buffs, and Water walking, Beathing Buffs added.
* Shaman damage spells added for PAM Custom use.
* Priest Inner Fire Added
* Paladin Righteous Fury Added
* CTRL+ALT will now force a buff macro to use the group version (e.g. BoM will cast Greater BoM)
* Support of all group buffs added. See manual for known Issues.
* Curing biases now use same settings as for Healing
* Support for Group heals.
* Out of Combat Healing schema
* HoT switch added to PHM
* Healing biases added for each class (via Bias button on PHM)
* Switch added to allow Healing Special (Divine Favor etc) to be cast on all heals
* Healing Indicator added to PHM to show slider effects graphically
* Custom Damage messages can now be configured for each individual spell
* SealMenu options for hiding/moving prediction text
* Healing Indicator combat switch added
* Healing bias for CT_RaidAssist maintanks and maintanks' target's target added


PanzaComm updated to v3.0 using 1.12 Addon Messaging API. No channels, fully automatic.
PanzaComm will automatically switch to Battleground Destination if using Raid or Party destinations, and
will switch back after leaving the battleground.
Panza will listen for messages from the Heart Addon in addition to Genesis for CoOp Healing.

Fixes
-----
Prevent defclasshealth from becomming corrupted causing nil.
Off-screen elements are now only repositioned if they are completely off-screen, not just one edge.
DoneWho nil protection
PMM Backdrop fixed.
Healing/Buffing NPCs in places like AQ20 (PVP flagged) fixed.
More heal abort checks and improved messages.
pa_group refactor to remove duplicated code.
Range checking improved, especially for Rez.
Improve messages for rezzing corpses that are out of range.
Buff counts recalculated.
Dump improved for missing tooltips and better range checking.
DCB UI fixes.
Prevent group buffs from switching to backups with the same ID.
Defer group buff counts for 1 second to allow buff to register.
Maintain target even if range checking multiple group members.
Remove group buffs if no individual buffs present.
Check new (1.12) Auto Self Cast function and set it to off.
Priest and druid HEALSPECIAL fixes.
Priest PWS fixed. When Priest is in a party and uses target's target on self.
Priest overheal issue reduced. Now checks healing gear bouns for reducing class of spells.
Druid GotW detection.

==========================
Panza 4.1B(03B) 2006-08-25
==========================

Fixes
-----
HotFix for pa_spell.lua:2095 Set nil

==========================
Panza 4.1B(03A) 2006-08-25
==========================

Fixes
-----
HotFix for pa_group.lua:330 nil

=========================
Panza 4.1B(03) 2006-08-25
=========================

Features Added
--------------
Perl Frame Support in PMM
Sensible DCB default buffs for levels 1,2,3
Cast HoTs when moving

Fixes
-----
DoneWho nil protection
PMM Backdrop fixed.
Healing/Buffing NPCs in places like AQ20 (PVP flagged) fixed.
Changes from Aloysius, more heal abort checks and improved message
pa_group refactor to remove duplicated code.
Range checking improved, especially for Rez
Improve messages for rezzing corpses that are out of range
Buff counts recalculated
Dump improved for missing tooltips and better range checking.
DCB UI fixes
Prevent group buffs from switching to backups with the same ID
Defer group buff counts for 1 second to allow buff to register
Maintain target even if range checking multiple group members
Remove group buffs if no individual buffs present
Check Auto Self Cast function and set it to off

=========================
Panza 4.1B(02) 2006-08-07
=========================

Features Added
--------------
Priest Power Infusion added.
Druid mid heal slider.
Party Healing Limit slider disabled if no appropriate spell.
Mage Armor added.
SealMenu toggle key bind added.
Settings for PFM rationalized.
New slider on main opts page to allow you to change the minimap button graphic.
Spell Start/Stop events added to unit tests, now possible to do a full bless cycle.
Buff Cycle reset command (/pa resetcycle) and keybind added.

Fixes
-----
Priest and druid HEALSPECIAL fixes.
Priest PWS fixed. When Priest is in a party and uses target's target on self.
Priest overheal issue reduced. Now checks healing gear bouns for reducing class of spells.
Druid GotW detection.
Should no longer attempt to overwrite a group buff with a single buff (really).
Mage Frost/Ice Armor detection.
Buff lookup was always using the tooltip.
Blessing list fixed to show over 26 players buffs TitanPA again.
Ensured pet names are stored consistently.
Prevent group buffs casting on self if self class excluded by PCS
Buff counting more accurate when buffing group.
Should not dispell Dreamless Sleep potion debuff.
Healing fixed when pets in party.
Most instances of blessings messages replaced with buff text.

=========================
Panza 4.1B(01) 2006-07-23
=========================

Features Added
--------------
Mage class: allows AI, Frost Armor, Dampen Magic, Amplify Magic, and curse removal.
Shaman Lightning Shield, Weapon Buffs, and Water walking, Beathing Buffs added.
Shaman damage spells added for PAM Custom use.
Priest Inner Fire Added
Paladin Righteous Fury Added
CTRL+ALT will now force a buff macro to use the group version (e.g. BoM will cast Greater BoM)
Support of all group buffs added. See manual for known Issues.
Curing biases now use same settings as for Healing
Support for Group heals step #1

Fixes
-----
Off-screen elements are now only repositioned if they are completely off-screen, not just one edge.
Additional nil protection added to UnitName calls
Fixed nil error in pa_heal
Wrong expire time with multiple buffs on same target
Greater blessings in party fix
Code using target call reassignment now protected with pcall
Curing fixed for newly learned spells
Buffs now checked for levels in DCB
Pet healing fixed
Fix for asBless not blessing NPCs
Fix for blessing NPCs (will now bless NPCs even if Skip PVP Players is enabled)
Fixes to MT healing biases
Missing info added to dump
Should no longer attempt to overwrite a group buff with a single buff

=====================
Panza 4.07 2006-07-23
=====================

Features Added
--------------
None

Fixes
-----
Nil error protection in pa_heal
Greater Blessing Fix
Multiple Blessing timeout fix
Greater blessings in party fix
Code using target call reassignment now protected with pcall
Curing fixed for newly learned spells
Buffs now checked for levels in DCB
Pet healing fixed


=====================
Panza 4.1B 2006-07-07
=====================

Features Added
--------------
Out of Combat Healing schema
HoT switch added to PHM
Healing biases added for each class (via Bias button on PHM)
Switch added to allow Healing Special (Divine Favor etc) to be cast on all heals
Healing Indicator added to PHM to show slider effects graphically
Custom Damage messages can now be configured for each individual spell
SealMenu options for hiding/moving prediction text
Healing Indicator combat switch added
Healing bias for CT_RaidAssist maintanks and maintanks' target's target added

Fixes (including 4.06 fixes)
----------------------------
Healing logic re-structured and simplified
Out of group blessing fix.
Blessing time format fix
Force windows onscreen
Druid Regrowth fix
Healing +Bonus display fixed to include bonus buffs (cosmetic)
Prevent Vanity Pets being considered valid targets
Functions reformulated to use short spells where possible
Blessings were erroneously being recast if players were on the failed list
Failed list was not being cleared quickly enough
Issue with Druid combat Rez resolved, Extra Rez messages added
Use new 1.11 debuff functions to avoid locale issues
Frame backgrounds changed to allow them to go totally black
Rez was not remembering recently rezzed players
PAW nil error when the keyword paw was received, or annc was attempted fixed.
Seal fix for Holy Shock
Fix for Holy Shock checkboxes that don't change to enabled properly

=====================
Panza 4.06 2006-07-07
=====================

Features Added
--------------
None

Fixes
-----
Nil error protection in as_bless
Blessings were erroneously being recast if players were on the failed list
Failed list was not being cleared quickly enough
PAW nil error when the keyword paw was received, or annc was attempted has been fixed.
Issue with Druid combat rez resolved, Extra Rez messages added
Rez was not remembering recently rezzed players
Seal fix for Holy Shock

=====================
Panza 4.05 2006-06-26
=====================

Features Added
--------------
Overheal threshold in PHM automatically follows Minimum Threshold for Healing + 1.
OverHeal Threshold cannot be set lower than Minimum Threshold. Doing this causes strange issues.

Fixes
-----
Bottom bar in Current Heal status bars shows corrected amount.

======================
Panza 4.04 2006-06-24
======================

Features Added
--------------
None

Fixes
-----
Unprotected UnitName calls causing nil errors fixed.
Fixed nil error in pa_heal for nil addition.. again.
Out of group blessing and target friendly blessing fixes.
Rez range checking fixed.

======================
Panza 4.03 2006-06-23
======================

Features Added
--------------
None

Fixes
-----
Issues with RANK variable on French client resolved.

======================
Panza 4.02 2006-06-23
======================

Features Added
--------------
SealMenu Tooltips can be enabled/disabled.
Druid and Priest spell bindings added.

Fixes
-----
pa_heal:786 nil error fixed. Caused by a nil result used in addition.
pa_heal:123 nil error hopefully fixed (french localization issue).
Shaman spellbook fix for FUBAR message.
Abolish and Healing spells should now not cast on players who are too low level

======================
Panza 4.01 2006-06-20
======================

Features Added
--------------
None

Fixes
-----
Missing Localization for PanzaComm Channel Switching. /pa base and /pa auto.

====================
Panza 4.0 2006-06-20
====================
First Main Release of Panza. See Release Notes for version 3.1B forward for complete details.
Panza was developed from Paladin Assistant v3.0 Code with Patches going in alpha and beta code through Paladin Assistant 3.06.
Panza has been in development, alpha, and beta tests for 30 weeks prior to this release.

Features Added
--------------
POM option for casting Divine Favor with Holy Shock anytime DF is up.
AsRez Will monitor CTRA's Rez Monitor (if CTRA is installed), and skip those currently being raised by someone else.
Change PanzaComm Channel Panza will use. The Default and Recommended setting is "Auto".
/pa base - Switch to "Base" Channel
/pa auto - Switch to "Auto" Channel

Note:	PanzaComm will now use two channels if PanzaComm is set to Base, and Panza is using Auto. Set both to Auto to use one Channel.
	If you also use GuildMap (PanzaComm), you will want one Base channel for it to operate as intended. See the PanzaComm
	Documentation. PanzaComm has gone through a major overhaul.

Fixes
-----
Range detection fixed for offensive spells
Abolish spells are now level checked against targets.
If Disabled, PMM will not save and restore UnitFrames. These procedures will only be called if PMM is enabled.
By default, PMM will be disabled if settings are restored to default, or someone uses Panza for the first time.
Fixed problem with Exorcism on non-English clients
Shaman Healing Way buff detection is now working, and buff is added to spell minimum and maximum values as ranks are selected.
Fixed Issue where a Druid with Omen of Clarity Spell would continually cast it.


=========================
Panza 3.1B(02) 2006-06-10
=========================

Features Added
--------------
Seal Prediction Text on Seal menu displays what the next spell/seal action will be with cooldown.
Healing debuff detection added.
Common Debuffs found in BWL will alter the healing engine.

Fixes
-----
Seal code improved, should no longer cast HEALSPECIAL when hs is not ready
(de)buff texture matches fixed, now Holy_Heal will not match Holy_HealingAura
Unknown unit "Corpse" error when rezzing has been fixed.


=========================
Panza 3.1B(01) 2006-06-06
=========================

Features Added
--------------
New Cure Module (PCM) exposes cure settings to the UI. Debuff Priority, and Class Priority may be modified.

New GUI SealMenu (for Paladins) added and is controlled in POM.
The Seal Menu has two pieces. Two slots for your combo, and a Seal Selection menu containing all Seals you know.
To control the Combo, left click the Seal from the selection menu to set Seal 1, and right-cick the Seal to set Seal 2.
Use the combo seal action slots to control combat and the seal combo.

New Panza Mouse Module (PMM). Allows the use of Heal, Buff, Cure, and Rez using key modifers (shift, alt, and control) with Mouse button clicks.
PMM will be updated with special spells for classes as time permits. Currently PowerWord:Shield (Priest), and Lay on Hands (Paladin) are included.
PMM is not Localized at this time. Issues came up during development, and localization was removed for the time being.
PMM supports standard Blizzard frames (player, target, pet), CTRA frames, and Discord Unit Frames. Other Frames will be added as time permits.
PMM is not compatible with addons that also hook these same Mouse Key functions. If strange issues occur, or PMM does not seem to function, disable addons you suspect may be causing issues, and try again, or disable PMM. Let us know of any issues you discover.

Priests, Druids, and Shaman all have a configurable healing trigger spell. This spell is used in regular
healing, and panic, and is also configurable to use with Trinket use. PHM is re-configured for your specific class.
Paladins use Divine Favor as before.
Priests use Inner Focus.
Druids and Shaman use Nature's Swiftness.

Rez now always goes into manual mode when CTRL pressed
Shaman cure and rez spells added.
Shaman detect the Healing Way Buff, and calculates added Healing Power for each application.
Priest Fear Ward added.
Healing status bars lock into position after the Set Bars button is pressed.
Set Bars will only show bars for what you have selected. Bars will unlock when the Set Bars button is pressed,
and lock when the simulation is complete. This setting is saved.
Enable/Disable for CoOp Healing in PHM.
Modified Panic to include PWS for Priests instead of BoP.
TitanPA updated to access PCS and PMM. Menu selections slightly re-arranged.

Fixes
-----
Priest Divine Spirit buff fixed.
Priest PWS macro will no longer remove you from Combat.
BestHeal healing Target's Target code refined.
Minimum Crit Rank Slider in PHM for "Special" Spell is now observed correctly.
PazaComm has been updated to join a Channel when available, and will print those
join messages so you know it is having this issue. It will also inform you when leaving, and joining channels.
PanzaComm had an issue with the German system AFK message, and this has been fixed.
SpellBook FUBAR! message for Shaman class fixed.
Debuff detection for Curing is improved.
TitanPA has been fixed for Paladins without Divine Intervention.
DCB levels in the dialog match spell messages, and tooltips updated.
HoT ("Other Healing") bars was updated to try and prevent overwrites.


=====================
Panza 3.1b 2006-05-25
=====================

Features added
--------------
*************************************************************************
** Note the Addon name has changed from Paladin to Panza.              **
** All saved variables will be default, so please check your settings! **
**                                                                     **
** Remove the \Interface\AddOns\Paladin directory completly!           **
*************************************************************************

Paladin, Druid, Priest and Shaman are now supported.
Hybrid class added for Paladin/Shaman switching based on player faction.
Cooperative healing supported by using the included PanzaComm library addon.
	The coorperative healing stores targets and healers healing
	those targets. This data is used to determine target selection
	and rank selection. Note this feature will only work in groups
	or raids, and is only supported for targets in those groups or
	raids.

	The command line interface for PanzaComm is /pcom or /panzacomm.
	/pcom status	displays current status and message counters.
	/pcom toggle	toggle message transmission on and off
	/pcom reset	reset message counters and user data.
	/pcom debug	toggle debug messages on and off.

Fixed spells for macro cooldowns.
Heal over Time spells that are active are used in spell and rank selection for
additional healing needed.
Curing should work for all supported classes.
Buffing now dynamic (DCB only shows buffs you know).
Healing now more generic (categories for classes defined)
Removed redundant spell look-ups.
Lots of addition checks added to ensure spells exists.
Hard-coded spell names removed.
ActionBar Range look-up now dynamic and depend on your spell-book.
Manual Rez now extracts target's name for messages.
Failed Spell list available in TitanPA for use as the main tooltip.

Seal Judge Combos for paladins may be used by calling /script PA:SealJudge(Seal1, Seal2).
Panza will cast Seal1 and Judge it as soon as possible, then cast Seal2. Seal2 is not judged.
If the Seal1 judgment expires then Seal1 will be recast
	The seal abbreviations are: (locale and case independant)
		SOTC - Seal of the Crusader
		SOC - Seal of Command
		SOL - Seal of Light
		SOW - Seal of Wisdom
		SOR - Seal of Rightousness
		SOJ - Seal of Justice
To call Seal of the Crusader +  Seal of Command create a macro with the command /script PA:SealJudge("SOTC", "SOC");
Press the action button for this macro to step through the Seal, Judgement, Seal process.
If seal2 is not SOW and SOC is in your spellbook then SOC will be cast and judged automatically if the target is stunned
PowerWord:Shield (pws) macro available for Priests will cast PWS on your unfriendly target's target if
that target is in your party, or raid.
If the Panza Chat Frame is available, Panza will use it for all messages.
Some messages are timestamped for anti-spam. No healing/curing is necessary are examples.
DCB now has set all feature for each column.
DCB now has save/load feature for buff save sets.
DCB now has levels, if PA can't bless because there is already a blessing it will use the next level.
DCB Non-Paladin Classes use the other 3 levels as multi-buff, instead of Backup.
Event registration now optimized to improve loading speed
Added option in PHM (default on) to always auto cast Divine Favor on Holy Light spells
Trinket activation added to healing engine, configured in PHM
Blessing of Sacrifice improvements: When PVP flag is set Panza will attempt to cast BoSaf on a nearby group member
pacomb: Blessing of Sacrifice stage added
Offensive Spells added to Seal Judge combos, new POM module added to Options screen to control them
Offensive Spell Message Level slider added to PAM and used in pa_seal
SealJudge keybind added (no UI for setting yet, defaults to SoW_SoC or SoC_SoC (PVP))
BestHeal will heal your target's target if your target is unfriendly. Your target's target must be in your party or raid for the heal to cast.
Warsong Gulch Features:
1. PA now tracks who has the flag (both sides)
2. New keybinds added to target either flag carrier
3. asFree will attempt to keep Blessing of Freedom up on the flag carrier
4. Heal and Cure are now heavily biased towards the flag carrier

Fixes
-----
PAW responses have been updated, and detects when WhisperCast is enabled and queueing when help is requested.
AsCure will attempt to cure your party and raid if you have a friendly person targeted, and that person does
not need to be cured.
OnUpdate() processing reduced to improve performance.


=================================
Paladin Assistant 3.06 2006-05-13
=================================

Features Added
--------------
None - Bug Fixes only

Fixes
-----
Wrong blessing given on ALT-CycleBless (first blessing in cycle to self)
TitanPA blessing counter fix
More nil checks for Spell Duration.
Fix for PAW saving blessings to list when PAW is disabled.


================================
Paladn Assistant 3.05 2006-05-09
================================

Features Added
--------------
None - Bug Fixes only

Fixes
-----
Corrected Spell.Active typo in pa_spell.
Corrected CheckBEWS nil error on Seals.
Updated UnitTests to see 3.05 Version.
Check for MapLibrary.UnitDistance function (pa_range).
Corrected German Translations for PAW


=================================
Paladin Assistant 3.04 2006-05-04
=================================

Features Added
--------------
None - Bug Fixes only

Fixes
-----
Macro nil error fix
Upgrade fix for ClassSelect
PA dependency added to TitanPA


=================================
Paladin Assistant 3.03 2006-04-01
=================================

Features Added
--------------
New healing spell abort code. After overheal message appears, use asheal,
or bestheal again to cancel current heal.
The abort message includes your Min Threshold setting so you can better judge to abort.
When PAW is disabled, but Feedback is enabled, and WhisperCast is installed and queueing, PAW will
no longer NAK requests, and this request will pass-through to WC. This feature is passive and has no effect if
WhisperCast is not installed.

Fixes
-----
Divine Favor and Blessing of Light detection fixes.
Macro Creation fix.


=================================
Paladin Assistant 3.02 2006-03-30
=================================

Features Added
--------------
None, Bug-Fix only release

Fixes
-----
Ensured all ghost tooltips remain hidden
MyAddons Registration fixed that caused MyAddons to error.
Updated PAW exclusions. Paw will ignore even more common phrases.

=================================
Paladin Assistant 3.01 2006-03-28
=================================

Features Added
--------------
Updated PAW exclusions. Paw will ignore more of the common phrases.

Fixes
-----
Fix for invalid settings not resetting properly
Ensured all tooltips have parent set (required in 1.10)
Update Message fix.
Updated French Localization.
Updated toc for 1.10 Client


================================
Paladin Assistant 3.0 2006-03-23
================================

Features added
--------------
Rez will now go into manual select mode if
  1) All dead targets in group have released
  2) CTRL pressed and there is no obvious valid target (use this if friendly non-grouped target has released)
Panic - will now cast LoH if mana is low even if BoP up (below 275)
Rez will not now try to rez a player that was recently resurrected.
/pa dump command added. This will save your state to disk (used for debugging/testing)
All spell info now scanned directly from the Spellbook (except Level obtained)
/pa buffs and /pa debuffs added to give info on target (de)buffs
Settings now properly saved per character via Blizzard method not internal table method.

Fixes
-----
Improved G.Blessing counts
Should now get messages again when Rezzing friendly targets
Fix for nil error in panic module
asRez now checks if you are in combat
Spellbook scan should work properly for non-English clients
PHM Healing Sensitivity range increased to +- 4.
Fixed bug in DI message to Raid
Yet another pet healing fix

These features and fixes are merged into the main release notes file, readme.html.


=====================================
Paladin Assistant 3.0B(05) 2006-02-21
=====================================

Features Added
--------------
Added self name to Rez insert options.
Added cleckboxes to HoW messages, you can now just signal crits if you wish

Fixes
-----
Fix to Rez and HoW tooltip error trapping.
Rez and HoW help buttons tooltip had wrong insert codes displayed.
Targeting made faster thanks to idea from Zdrumpi
Blessing should no longer reset to defaults if you don't have Blessing of Salvation in your spellbook.
TiTanPA conflict with AutoBar's configuration dialog resolved.
Corrected PCS ClassSelect detection for configuration checking.
Rez messages will now only appear for valid units via the Rez macro
asComb improved to cast Cure before BoF (so it uses Cleanse for FrostNova)
PAM tootips brought on-screen
Pet Healing in parties should now work as before via the Min Pet Health slider.


=====================================
Paladin Assistant 3.0B(04) 2006-02-14
=====================================

Features added
--------------
BelowThreshold count added to greater blessings
Improved reposnses with PAW. Now returns durations for active blessings.
Panic improvements - Slower ramp decay + less spam when ramping
PAW Announcement. /pa annc function will use say, party, or raid chat to announce PAW help.
Bindings Added for PAW toggles, and Annc function.
Added Hammer of Wrath success detection with custom messages.
Custom Message Dialog in PAM is the new format for Dialogs going forward.

Fixes
-----
Fix to free, was broken in groups
All lists passed to pa_group functions now need Class and InRange
Renamed a few functions in DCB to be OO
Label added to PBM for Greater Blessings
G.blessings were being cast too often because spells were being expired after 600s, increased time-out to 1000s
Fix to bug that stopped you blessing yourself when not in an instance
CycleBless with G.Blessings made quicker
The ActionBar range check flag on the options pages now split into 4 (Heal/Cure/Bless/Free) for better control
Fix to PCS, classes were mixed-up
Rez was broken, now fixed
DI was broken, now fixed
Rez message now checked for correct format
Fix to asComb calling bless after a successful cure
Fix to spell failure detection
Updated German Localazation
Improved RGS Localization
Fix to Unknown unit 'blank' in pa_spell
PAW no longer returns "Spell is unavilable" if responses are on, PAW is disabled, and you do have the spell.
PAW has improved responses, and will instead return the spell is disabled for automatic setup.
PAW will NAK requests for blessings when you have blessed them with a Greater Blessing.
Panic HolyShock now casts HolyShock instead of LayOnHands (doh!)


=====================================
Paladin Assistant 3.0B(03) 2006-01-31
=====================================

Features Added
--------------
New Module (PCS)
PCS - Paladin Class Selection.
      Allows you to select Heal/Cure/Bless/Free/Panic by class.
(RGS) Updated to support Free and Panic Selection. When upgrading to this version, RGS settings will be reset to default.
(PHM) Party Bias control adds weight to heal party before others in raid. range is 0-100%. 0 will heal entire raid equally.
(PHM) Self Bias control to weight yourself for healing. Range is -100% to +100% centered on 0.
Failed list extended to include all PA spells
TitanPA included within PA folder. Please un-install TitanPalast in the interface\addons directory.
TitanPA is classified as a Combat Addon, so enable it there.
Detailed instructions for TitanPA are included in the manual.
CycleBless now will bless Classes with GreaterBlessings, There is a new slider threhold on PBM the sets how many of a class need to be in range before a Greater blessing is cast
New Holy Shock stage added to panic

Note: In this version "Actionbar range checking" will cause a slight delay when using Greater Blessings in Cycles. If speed
is a concern, turn this option off in the Main Dialog. We will work on increasing the speed in future releases. If you disable
the action bar range checking your count will be off and range will we reduced by 12 yards (to 28) for healing, and 2 yards for blessings.
IMO giving up a little speed is well worth the extra range, and better reporting. Send your thanks to Blizzard for making it so
hard to range check.


Fixes
-----
Healing should behave better, especialy with respect to failures.
Rez should now list released players correctly
Fixed bug in AsFree when in Party/Raid, would give error when trying to free self
Fixed a couple of duplicate messages with AsFree and AsCure
DI messaging changed.
Upgrades should no longer fail when selecting a character that was using a prior version.
Updated Healing+ status function for updated Titan.
Updated French Localazation
Updated German Localazation
Class Selection: Raid flag now only applies to the rest of the raid, not your party


=====================================
Paladin Assiatsnt 3.0B(02) 2006-01-17
=====================================

Features added
--------------
Low Threshold to Force Flash of Light. New Slider in PHM. Target Health at
or below this threshold will receive flash of Light helaing spells.

Fixes
-----
Asfree fixed to use PFM Class Order.
Asfree sliders changed to generic weight, but are still not used in free selection. The order however is used.
PAW will no longer listen to whispers when the rest of PA is unloaded.
Updated German Localazation.


=====================================
Paladin Assistant 3.0B(01) 2006-01-16
=====================================

Features added
--------------
New Modules (PFM) and (PAW).
PFM - Paladin Free Module controls the asfree macro.
      PFM priority only will be used in this release. The sliders for weighting have no effect at this time.
      PFM weighting, if and when it is implemented could be anything. The health sliders mean nothing atm.
PAW - Paladin Whisper allows other players to set their saved blessing by sending tells to you with keywords of blessings.
      PAW will only setup saved blessings with blessings you have.
      PAW will send a list of blessings you support if someone sends you a tell with the word paw in it.
      PAW is not a replacement for Whispercast, as it has no queue, nor will it respond to cure/stuck messages.
      You may toggle PAW with /pa paw.
      PAW can be silent if you wish by disabling responses. this can be toggled with /pa pawresp.
Symbol of Kings count is maintained and checked before using Greater Blessings.
Symbol of Divinity count is also maintained. These two items are counted at the same time and are returned from the same function.
BonusScanner is now the only Item Bonus support provided. You must use the latest version.

Fixes
-----
Upgrades from any version will not cause frame errors, or various other nil errors.
Kings Symbol count will be valid at startup.
AsBless should no longer try to bless selected NPC's.
Pets in battlegrounds should no longer appear as UnknownEntity
CycleNear will now rebless when the blessings have expired (including self)
CycleBless improved blessing within battlegrounds
Fixed some error messages for Action range check when Paladin is low level.
PA will not interact with any PVP flagged Player or Pet if Skip PVP is checked.
Di will no longer spam messages.
Greater Blessing of Light detected in healing.
Recoded PAM, Blessing, Curing, and Healing code that had older non-prefix variables to reduce namespace conflicts.
Cure re-write to use common group loop functions.
BEWS will display warning messages if enabled unless in quiet mode. Other PAM Blessing settings have no effect.
Updated German localazation.
Updated French localization.
Updated BonusScanner detection for the newest version of this addon.
Updated /pa cli help. All commands that must be enabled via keypress, or hotkey have been removed from help.
The /pa show command will correctly reflect the Skip PVP feature as being disabled or enabled.
We have attempted to localize Greater Blessing support, and pet/guardian/creation identification. We could use help.


=====================================
Paladin Assistant 2.1B(10) 2006-01-06
=====================================

Features added
--------------
Greater Blessings can be setup in PBM for SELF, Party, Raid, and Battlegrounds.
Symbol of Kings inventory tracked in the Status screen.

Fixes
-----
Macros now split between General and Character macros so as not to go over the, now enforced, limit of 18 in each area.
Note: you may need to delete the Blizzard addons (Blizzard*) in the AddOns directory in order to see the new macro tabs.
The 1.9 WoW Client will add the Blizzard addons back automatically.
Fix to out of range errors when healing in battlegrounds.
Moonkin Druids will now be blessed according to MAGE Class settings.
Warning levels for low-level blessing spells have had their value increased to reduce messages seen.
Blessing Name is included on the status screen, and now sets correctly when the spell is cast.
Format error corrected for PVP detection reporting. Paladin.lua:687
Paladin.toc changed to 10900 to support the new WoW 1.9 client.


=====================================
Paladin Assistant 2.1B(09) 2005-12-31
=====================================

Features added
--------------
Improved CycleNear. Now it will always bless pets no matter what the "Bless NPC" setting is unless the "Bless Pets" flag is unset (on DCB)
New showspells command to show details on spells PA knows about. Useful for tracking down problems with localization.

Fixes
-----
CycleBless efficiency much improved.
CycleNear will no longer try and bless non-combat pets (unless "Bless NPC" is set).
Fix to French spells
Fix to German spells
Fix to Divine Intervention
Fix to CTRL-Bless not being used correctly
Fix to healing range check
Updated Chinese localization.
Fix to blessing Druids when shapeshifted


=====================================
Paladin Assistant 2.1B(08) 2005-12-20
=====================================

Features added
--------------
Will now use PA macros for range checking if present. If you are upgrading you will need to refresh your
macro definitions by hitting the [Macros] button on the Paladin Assistant console.
Improved output for pets

Fixes
-----
Fix to losing combat when casting spells.
Fix to CURE macro to allow range check to work. If you are upgrading you will need to refresh your macro definitions by hitting the [Macros] button on the Paladin Assistant console.
ActionBar scanning now much more efficient.
Issue with failed list and BoF resolved
Fixes bug in asfree that was incorrectly removing players from the failed list


=====================================
Paladin Assistant 2.1B(07) 2005-12-19
=====================================

Features added
--------------
Added Mind Vision Detection, to prevent it being dispelled.

Fixes
-----
Fix to cycle bless giving wrong blessing to self at beginning of cycle.
Fix to DCB when updating Me via Control-Bless.
Fix to range check for DI
Fix to Mind Control Detection
Quiet mode now even quieter


=====================================
Paladin Assistant 2.1B(06) 2005-12-17
=====================================

Features added
--------------
Range checking extended to use action bars. Requires 3 spells LOH + Cleanse/Purge/Blessing + HL/FoL to be on action bar (doesn't matter where and don't need to be visible). Just one any rank will do. Need one for each range 20/30/40 yards. So minimum is three spells say LoH/Cleanse/FoL
There is a new option on the main option window to turn this feature off
Staus of range checks added to Status window
Range checking on healing spells in instances can be ignored by using CTRL-asHeal
Added editable Rez message (on PAM) [Border textures are not correct yet, but hey!]
Now when you spam Panic and if nobody is below the health threshold it will ramp-up the thresholds by 5% for every key press within 0.5 seconds. The idea is if you can see a bad situation developing you can intervene early.
Cure stage added to Panic.

Fixes
-----
Missing asComb keybind added.
Prevent CycleBless overwriting BoF and BoP
Tweaked asBless to use CycleBless on yourself when solo
Fixes to cure code
Priests' Mind Control should no longer be cured, nor should the MC'd mob get healed or blessed (needs testing)
asBless logic improved, now will do cyclebless if target is in raid/group
Replaced spell names in french localization to match the ones in build 04.


=====================================
Paladin Assistant 2.1B(05) 2005-12-12
=====================================

Features added
--------------
Print names of last n players without a blessing now configurable (on PBM)
Rez message level and notification added to PAM and rez code
New asComb command performs asFree then asCure then asBless.

Fixes
-----
Fixed issue with CycleBless failure list getting confused.
Fixed issue with CycleBless counts.
Panic feature reworked to behave better when spammed very fast.
Updated French localization.
Updated Chineese localization.


=====================================
Paladin Assistant 2.1B(04) 2005-11-28
=====================================

Features added
--------------
None, bug fix only


Fixes
-----
Fixed tooltip issue when using the SuperMacro addon.


Features added in 2.1B(03) 2005-11-28
-------------------------------------
Print name of last player having a failed blessing. This is a developing feature that will be enhanced in the next release.

Fixes in 2.1B(03) 2005-11-28
----------------------------
SuperMacro compatibility issue resolved.

Features added in 2.1B(02) 2005-11-24
-------------------------------------
Show Ranks flag added to output ranks with spell messages (on PAM)
New asRez command - will try and cast Redemption on dead group members (only if not released).
New REZ macro added to call asRez.
New panic command - will try and cast BoP/LoH/DF and BestHeal on a group member with low health.
New Panic Dialog on the healing Module.
New PANIC macro added to call panic. You need to spam this in an emergancy.
Macros now show tool-tips. If you are upgrading you will need to refresh your macro definitions by hitting the [Macros] button on the Paladin Assistant console.
Blessing durations now scanned from spellbook (instead of being hard coded).
New option to override blessings with Wisdom if target's mana is low (currently 10%) (on PBM)
New option to use BG blessings if PVP flag set (on PBM)
New option to show blessing progress after each blessing (instead of just at the end) (on PBM)
Bindings added for asrez, asfree and panic
Pet names now saved as OwnerName_PetName, to prevent clashes.
MiniMap button is now draggable.

Fixes for 2.1B(02) 2005-11-24
-----------------------------
Fix to CycleBless/asfree not always moving to the next group member when a bless fails to start.
ALT-asBless now resets CycleBless
asFree will debuff more effects (see trappers.txt in the docs directory)
Purify message now clearer when trying to dispell magic
Party blessings now should override raid blessings (unless flag set)
Allow macros not to have a cooldown

Features added in 2.1B(01) 11/8/05
----------------------------------
Ignore group settings in raid flag added (on DCB) (i.e. if set and in a raid default blessings will be take from the raid column only)
New asfree command - will try and cast Blessing of Freedom on group members afflicted with an immobilization debuff (this is not finished yet).
New FREE macro added to call asfree.
Rebless time setting for CycleBless added, slider is on PBM
Macros now show cool-downs like normal action buttons. If you are upgrading you will need to refresh your macro definitions by hitting the [Macros] button on the Paladin Assistant console.

Fixes for 2.1B(01) 11/8/05
---------------------------
Chinese localization updated.
Fix to strange (Pet) message when blessing self in a raid.
Bless pets flag now taken into account in CycleBless.
Issues with RGS setings being incorrectly applied by CycleBless resolved.

Features added in 2.1B 11/3/05
-----------------------------
Chinese localization thanks to Lei Wu

Fixes for 2.1B 11/3/05
----------------------
CycleBless complete rewrite. CycleBless should not get confused or stuck. This is a big change to how you need to think
about CycleBless. Try not to think in terms of cycles more of a continuous blessing process. CycleBless will
now only bless players/pets who's blessing has (or is just about to < 90s) expired. Just keep spamming
CycleBless until you get a "No more blessings required for Xs" message. You will also be informed how
many blessings succeeded and why the others failed, and you can relax for X seconds...
Infamous 858 bug squished.
PLAYER_DEAD event should now fire correctly.

Fixes in 2.02 10/23/05
----------------------
Removed non-healer selection from DI function.

Fixes for 2.01	10/18/05
------------------------
Corrected issue with DI macro

Fixes for 2.0	10/15/05
------------------------
Updated Item Bonus support to include BonusScanner (non-Titan requirement)
Updated SpellCast Fail event code to prevent nil errors on player name.

Fixes for 2.0B(03) 10/15/05
---------------------------
paladin.lua:1165 nil error with name

Fixes for 2.0B(02) 10/14/05
---------------------------
pa_bless.lua:1441 nil error with name
BoSAN will no longer say it expires 60 secs after you cast it (BEWS).

Fixes for 2.0B(01) 10/12/05
---------------------------
Paladin.lua:303 nil error with msg.
Default CycleBless Restart parameter is now 1 sec.
Re-enabled "/pa bestheal" macro creation for the macro button.
MapZoom Addon Removed.

Fixes for 2.0B
-------------------
Corrected curing code "as" logic. Catser only being cured in party only (no raid).
BEWS will expire and indicate a final notice if the blessing is overwritten or canceled.

Features added in 2.0B
---------------------------
This is a feature lockdown for the v2 release.

Fixes for 1.308.14B
-------------------
Hotfix 2 10/10/05 Corrected curing code pa_cure:127 nil error
Hotfix 1 10/10/05 Corrected healing code. Caster only being healed.

Corrected a logic error in the healing engine for rank selection. This issue was causing PA to usually underheal.
Corrected issues in all "as" modes that would occur when paladin was solo in a raid (group of 1). PA would only act on caster.
Corrected a nil error that occured when using ClearTarget (Blessing List) on Player.
Corrected major issues when using RGS to skip raid members while blessing; Creating nil error reports in paladin.lua and pa_blesss.lua, and success count errors.
Corrected major issues when using RGS to skip raid members while healing and curing (non-functional).
Corrected a minor issue where the CycleNear list would be cleared after it was already cleared.
Automatically disable PVP flag checking when "player" is PVP flagged.
Target Health estimation for solo players is slightly more accurate.

Features added in 1.308.14B
---------------------------
Color for the messages is introduced now. This will be deveoped more. At this time, colors indicate message levels in most instances.
PA will detect if you have MegaMacro installed, and will raise it, instead of the stock one when creating Macros.
Druids in Bear Form receive Warrior blessings, and while in Cat form receive Rouge Blessings as dictated by DCB.
Blessing of Might is now a transparent backup spell for when Blessing of Kings cannot be cast on a target.

Fixes for 1.308.13.1B
---------------------
Hotfix for nil error occuring when party/raid changes occur.

Fixes for 1.308.13B
-------------------
CycleBless nil error on Failed list was resolved.
Cyclebless hang when BEWS is disabled was resolved.
Corrected a nil error occuring in DCB when short duration blessings where intended to be saved as default blessings.
DCB table was also corrupted as a result of the Short Duration save attempt.
Corrected cosmetic error using clearname("name") function.
Corrected a CycleBless timer isssue that would be present when you first login and try CycleBless.
Corrected a issue that caused InitCycles to be called continuously until a cycle was initiated.
BEWS activation checkbox was moved to the PBM dialog

Features added in 1.308.13B
---------------------------
DCB has a -Nothing- Blessing selection, allowing you to skip any class during a Blessing Cycle (Near or CycleBless).

Fixes for 1.308.12B
-------------------
Blessing Announcement is now disabled. Configurable soon.
Corrected a nil error in paladin.lua (missing ready flag),

Features added in 1.308.12B
---------------------------
+Healing data used in heal functions. This data is read from Titan Item Bonuses (if installed).
The Status Screen now shows the status of Titan Item Bonuses, and what the +Healing is.

Fixes for 1.308.11B (Released as 10B Fix)
-----------------------------------------
Fixed logic error in CycleBless causing nil error.

Features added in 1.308.11B
---------------------------
A mistake allowed a blessing announcement always being shown. This will be a configurable option soon.

Fixes for 1.308.10B
-------------------
Corrected logic errors in party/raid healing, and curing code.
RGS enabled for curing code, and tooltip updated.

Features added in 1.308.10B
---------------------------
Divine favor detected and minimum crit calculated used to select a lesser heal spell to heal to ~ 100% with crit.

Fixes for 1.308.9b
------------------
Pets are now healed and cured correctly when using "as" commands.
PAM Blessing, and Curing Messages are filtered for Errors Only.
The Abort Healing setting no longer causes a nil exception.
DCB dialog is updated if it is shown while DCB updates are performed via the command line.
A few nil errors were corrected for command line commands like /pa show.
Corrected an issue in the range code if MapLibrary is not installed.
Updated the MyAddons registration data to be compatible with v2.3.

Features added in 1.308.9b
--------------------------
PVP Skip Switch. This switch when enabled will cause PA to skip Players that are flagged for PVP. Setting has
no effect on player at anytime, or when in Battlefields.

Fixes for 1.308.8b
------------------
CycleNear Complete Overhaul.
A few Nil errors identified and fixed in blessing and healing code.

Features added in 1.308.8b
--------------------------
Healing Abort function. This setting (enabled by default), will abort in-progress healing spells if
the target's health rises above the Minimum Threshold for Healing setting. Setting is in PHM and enabled by default.
DCB "Me" Row is updated with control+blessing on Self. GUI will not auto-update if it is open in this release.
Macro Creation function. This function will create the 18 common PA macro functions for you.

Fixes for 1.308.71b
-------------------
DI Macro localization for classes.

Fixes for 1.308.7b
------------------
Toc updated for 1.7 client
RGS group bypass modified to use the group setting in blessing and healing.
Nil error after a failed cyclebless fixed.
RGS will disable healing blessing and curing settings in the RGS dialog when the Group is disabled.
Default buttons are fixed in PHM and PBM dialogs.
Range code updated to support DI function in instances.
Battlefield status detection updated.
Bindings updated for PBM and PHM dialogs.

Features added in 1.308.7b
--------------------------
RGS Checking enabled for healing. Curing is not RGS checked in this release.
Healing Sensivitity is now +-2.
Dialogs now close with escape button press.

Fixes for 1.308.6b
------------------
Corrected Message error in curing code.

Features added in 1.308.6b
--------------------------
Going forward most major features of PA will be called Modules.
The BLP Dialog is now the PBM (Paladin Blessing Module).
The DCB dialog button was moved to the PBM dialog.  However it may still be accessed via a dedicated hot-key.
PHM Dialog Introduced.  This dialog may be titled Preist Healing Module, or Paladin Healing Module. All healing parameters are here.
Healing sensitivity setting in PHM Dialog.

Fixes for 1.308.5b
------------------
Correctly identifies Phase-Shifted Targets and will not attempt to bless one.
Corrected DCB for German clients.
Fixed numerious nil error exceptions for common CycleBless normal occurances that should not create nil exceptions.
Implemented a Fix for BEWS on Player Death.
Implemented better upgrade code.
Corrected Cyclebless issues with Blessing of Salvation and Blessing of Kings spell failures.
Corrected broken clearall command.

Features added in 1.308.5b
--------------------------
New Dialog (BLP) for setting parameters for Blessing (AutoSelect Bless, CycleNear, and CycleBless) Settings.
Player now receives all self blessings from the DCB table. Player has 4 settings identical to the class specific settings.
Healing accuracy increased with a sensitivity setting. Will be adjustable in 1.308.6b.
RGS may now be used for CycleBless. Healing, and Curing to be updated soon. By default, all groups and all support are enabled.
Note: RGS toggle in main panel is used to enable/disable RGS. RGS is off by default. Report Problems w/screen shots.
Pets may be set to ignored for blessings in the DCB dialog. This affects Party, Raid, and Battlegrounds blessings.

Fixes for 1.308.4b
------------------
Patched pa_heal caused by new rank selection code from 1.308.3b
Patched PAM announcement code to fix exception error received during tradeskills.

Features added in 1.308.4b
--------------------------
CycleNear may be reset with alt+CycleNear. It also has a counter.

Fixes for 1.308.3b
------------------
Fixed logic error in pa_heal that missed a condition that sometimes caused heal to be too high.
Fixed hook data issues with PAM causing Addon to seem "Dead" at certian times.
Corrected variable settings caussing many nil errors throuhout the Addon.
Corrected German Client DCB table issues.
Corrected nil range function issues within di, and fixed an error that would cause caster to be selected.
Control key will only save blessings when used with the /pa bo* commands.
Checkbox for BEWS moved to PAM.

Features added in 1.308.3b
--------------------------
Added Switch to Bless NPCs with CycleNear. This is disabled by default.
Added Switch to automatically invoke CycleBless with asbless.  This is enabled by default.
Added Switch to allow outside the party/raid blessing/curing/healing. Default is disabled.

Fixes for 1.308.2b
------------------
Fixed many issues in CycleBless including Range, and other failure detection.
Range code updated, and modified to use MapLibrary.
Fixed numerious nil value issues.
Fixed non-paladin loading issues.

Features added in 1.308.2b
--------------------------
MapLibrary Support. Maplibrary will be used for all range calculations if enabled. Checkbox is on main panel.
Multi character settings based on Realm. So you can the same character name on two realms bot will have seperate settings.
You will loose all previous settings when using this version.
Nofify on Spell failure enable/disable

Fixes for 1.308.1
-----------------
Bindings for Options Panel Corrected.
Modified Cyclebless to not bless Caster twice, and moved Cyclebless messaging/core control to PAM. Reduced messages by a large amount.
Modified CycleBless to not retry failed units. This was done to keep CycleBless from becomming stuck in any mode. Research will begin on a safe way to combat failures.
CycleBless uses common message with hooks into PAM and will only announce spells to the checked options.
Added a function that is called when the cycle ends completly that lists names of units that did not receive blessings.
Fixed CombineSpell calls in Messaging subsystem for blessings and cure spells that didn't have Paladin_ prefix.
Reset of DCB Table Corrected.
Modifed asbless command to NOT invoke CycleBless

Features Added in 1.308.1
-------------------------
Added a Setting to allow friendly target buffing/healing/Curing when inside a party/raid. This Setting is not in the GUI at this time. 1.308.2 Maybe.
Added a Transparency setting.
Added PA version Number to Minimap tooltip.

Fixes for 1.308
---------------
PAM checkboxes Fixed.
Many issues with MsgLevel (debug in general) were fixed.
PAM for Spellcasting (Healing, Blessing, BEWS, and Curing. Cycle will be PAM Compliant by 1.309b
Status Panel Mostly Dynamic. Will finish by 1.309

Features Added in 1.308
-----------------------
DCB Editor replaces defclassBuff[] array (defclassBuff is no longer used and will be removed by 1.309)
Added AutoSelect commands for Healing, Curing, and Blessings (asheal, asbless, and ascure). These commands will only work on friendly targets when in Solo mode. A new switch will be added in 1.309 to work on friendlys when in a Party/Raid.
New Bindings added to make up difference. All major commands have bindings.
Say and Emote selections added in PAM. EMOTE will override all other notification options if enabled.
Dynamic Tooltips in PAM for Healing Message Levels.

Fixes for 1.307
---------------
Many changes to messaging, blessing, and healing code to fix issues reported.
Bindings fixed and many commands added
New localization strings.

NOTE: The mouseover for the PAM checkboxes do not align.  Dont have a clue as of right this min.
PAM defaults to level 1 messages for healing meaning the party will no longer see Flash of Light spells. To see them the healing message level must be increased to low-detail (level 2).
PAM has not been implemented in any area except Healing spell Casting. So dont report blessing message issues etc until all components have been upgraded to PAM.

Fixes for 1.306
---------------
autoheal variable errors fixed for raid.
autocure should now work for solo/party/raid/pets with one macro function call (/pa autocure)
BOL tooltip fix for German Client
BOF fixed for German Client (Rang 1)
New German Localization strings added.
Logic errors fixed in BEWS
Messages for blessings now show the origin of the blessing (Saved, Solo, Party, Raid. and BG)

Features added in 1.306
-----------------------
Specific blessing for Battlegrounds in DefClassBuff Bg=Buff.

Fixes for 1.305
---------------
autoheal overhaul
New GUI slidebar for Min Health%
Implemented a fix for lag caused by FOL to HL spell switching in healing code.
Fixed issue with titan chat history.
BEWS may now be enabled/disabled from GUI.
many new local strings and localization files split for ease of editing. Lots more work to do on that front also.
Bol may now work for German client. needs testing
Fixed settings upgrade procedure.
Fixed "blank" blessing expiring message.
Updated healing messages to be shorter.

Fixes for 1.304
----------------
Autoheal will now heal solo, party, party pets, raid, and raid pets. There
is no need for a separate macro to heal raid members or pets. The only healing function needed is '/pa autoheal and possibly /pa bestheal;. The other heal commands will be phased out over time, and will no longer show in the help but will continue to work for some time. Autoheal
will always heal solo/party/raid first. The use of bestheal will continue to provide direct target based rank selection healing as always. Autoheal will be updated again soon to support friendly targets if in solo mode.
The GUI incompatibility problem with some other GUIs has been solved. It was an incorrect API call for the type of interface we have.
MyAddon Support was updated to version 2, and all of MyAddon options were programmed.
Cyclebless has been completly overhauled and updated to be more consistant. Huge Change, lighter, and simpler.
Settings will be upgraded whenever possible beyond version 1.30.
Healing announcements received an overhaul, and provide more information
with fewer messages.
Any PA command may now be prefixed with /pa instead of /paladin.

New Features in 1.304
----------------------
Raid Group Selection (RGS). RGS will allow the selection of specific
groups in a Raid to receive Blessings. Members of other groups will not receive blessings. This feature will conserve power and enable raid leaders to distribute the work among several players. In the future this selection will used in healing and curing also, or there will be a choice of to include the groups in blessing, healing, curing or all three. In this release the group selection only applies to blessings. By default all groups are selected. Still in development awaiting a GUI update.
Blessing Expiring Warning System (BEWS). BEWS, when enabled (always enabled in 1.304), will
warn you when blessings are about to expire. In this release the warnings start 60 seconds prior to your blessing expiring, then for the next 30 seconds, at 10 second intervals you receive additional warnings, and finally 30 seconds beyond the 30 second warning you receive a notice that the blessing has expired. This may become more configurable in the future. Also note this feature is only enabled on 5 minute blessings, and this feature does not track blessings on other people, only the caster. When enabled (default) BEWS will activate and reset every time you bless yourself. This may help remind you when to start your next CycleBless.
New Threshold (will be put in GUI asap)called Minimum Health. This threshold will be the threshold for healing. Any health ratio below this setting will get healed, and any above it will be healed only when no other entity needs
healing more. Default is 95%. Still in development.
New Filters for messages is being put into the Addon for filter in Debug Mode.
The healing function will try and switch between Flash of Light and Holy Light if one has cooldown, and cannot be used.

1.303b
------
New announcement logic for healing using new framework for spell fail detection. Still in progress.
Upgrades to new versions now use upgrade code that retain as many settings as possible.
expanded localazation messages.
Many improvements to blessing code and failure detection in CycleBless.
Sorry but the Buff Timer didnt make it in this one.

1.302b
------
The paladin.lua file has been split into sepearte module files just to make this project eaiser for us to work on.
Progress is being made on raid group selection.
 A new framework is being developed to track failed spellcasts. currently you can only see the output from this framework in debug mode. This feature will allow us to detect problems in blessing cycles, and failed healing and curing spells.  Problems like Line of Site.  This framework may also provide a better utility for checking cooldown.

1.301b
------
Added bindings for autoheal, bestheal, autocure, bestcure, bom, bow, and bol, and bof.
New command line /paladin bless# on/off where # is party # to to bless or not in a raid with cyclebless.
The raid selection logic is new, and needs to be tested. Report all breakage, anomolies, and general weirdness please!
The healing code will send delay messages to the party, or raid or personal messages to the target about delays in healing now. It depends on what options are checked.
'/paladin quiet' will shut paladin assistant up. no party no raid, and no personal messages.

========================
1.3 Released in 07/16/05
========================

Features introduced in 1.3
--------------------------
CycleBless will now bless Party, Party Pets, Raid Members, and Raid pets,
and the Caster of course, with just one button.&nbsp; You will have to press it
a few...dozen times or so, but its still just one button.

Automatic Pet Healing in AutoHeal() if all party health is above the new
configurable "Pet Healing" threshold.

Spell Cooldown checks are made before any Blessing, Healing, or Curing spell
is cast.

Heal Spell Switching, or (HSS) monitors a small threshold of cooldowns from the
two healing spells. If the cooldown period is greator, it switches from Holy
Light to Flash of Light, or vise versa, then back again once the spell is
available.
Implemented spell cooldown checking on all PA spellcasts

Key Bindings with the ability to toggle the use of the ALT and CTRL keys.
These functions enable or disable the Blessing Save, and Self Blessing features.
Bindings are also included for all of the blessing list options, and one to
display the GUI.

New display option toggle for Healing Spell progress reporting. This option
will report estimated arrival time, delays as they occur. These messages will be
sent to the players the spells are being cast on, or the local chat window.
Extensive French and German Translation work by AmorGrid and Seriosha.

Blessing of Freedom, and Blessing of Protection may be macro cast
(/paladin bo(whatever)), bringing the blessing count to 9.
Assistant will use the Notify() function for all Healing failures.
Messages will be set to party, or raid. Notify() has always sent messages to the
local chat window, if no other options were enabled.

Updated the GUI with tooltips (localized)
Support for MyAddOns added.

Fixes included in 1.3
---------------------

CycleBless will no longer break and reset the cycle when CheckTarget()
fails.
Autocure correctly cures Magic, and will also cure when health is 100%

Cyclenear list will no longer timeout after just 10 seconds.
Blessing of Light Tooltip fix for WoW 1.6 Client upgrade.
(English and French Versions. German patch in 1.31 Asap!)

Discontinued use of the Join() function in messages. This will prevent error
dialog boxes from appearing when non-string data is being concatenated.

Low level Paladins can now correctly cast from default class setup. Wisdom
Rank 1 level changed to the correct level 14, and Might Rank 1 changed to the
correct level 4.
Upgraded several functions to use the new API features available
in WoW's 1.6 Client

========================
1.2 Released on 07/08/05
========================

Features added
--------------
Blessings can be saved per player by using control+macro button when using a /paladin <buff>
command. That saved blessing will be used hereafter when that player is
AutoBlessed.  "/paladin show" will now report how many entries are on this list.
There are also a few new commands used to manage this list.

  /paladin listparty   List blessings for the players in your current party.
  /paladin listraid   List blessings for the players in your current raid group.
  /paladin listall    List every player that has a saved blessing.
  /paladin cleartarget  Clear the blessing for the player currently targeted.
  /paladin clearall   Clear the entire list, and re-create it with "players" blessing.</pre>

Command line function Paladin_Clearname("name") is used to clear a single name from the BuffList.
Syntax is: /script Paladin_ClearName("name") where name is the entry you want to clear.
There will always be a "player" record, and you may not delete this one.</p>
In the next few releases, several more command will be included for the Blessing list including ways to
automatically update the list as members leave the party/raid, and commands to remove all blessings belonging to
party/raid members.
This function will be updated to become multi-player aware so this Addon's
feature may be shared between
Paladins on the same account. Each Paladin having a unique list.

Blessing of Light is detected on healing targets.  The tooltip is read and the amount
of extra healing is used in calculating the healing spell rank selection.
There is a new command line option "/paladin bolverb" that will show this extra healing information
for each spell as it is cast. The default setting for this extra display is off, but the extra healing
information will always be used if it is detected.
Note this will only work on EN clients.  The tooltip text needs to be translated.

Mana costs updated for healing spells during Initialization, or when spells/points change.
This information is also used in spell rank selection.

The cure code uses inverse of health to scale status by who is affected by the most debuffs, and has
lowest health. This inverse is the inverse of the health ratio. i.e. if your health is 70% you get 30 for
your inverse.  If your health is 20%, you have 80.  Higher numbers take priority.
The next evolution of this code will use class in the priority as well.

Created a Paladin_Reset function that may be used via /script to reset the Paladin variable to stock settings.
use "/script Paladin_Reset()" to reset Paladin Assistant.</li>

A new how-to manual is included in the readme

Fixes
-----
A GUI that can be accessed from the MiniMap or command line.
Corrected a mistake in the / processor for cleartarget
The field names in defclassbuff have changed to solo, party, and raid to
make their function more clearly defined. Their function is documented in the
manual.
Modified the help screen to show required &quot;/script &quot; commands
Cleanse will only be used if you need to cure Magic, otherwise Purify will be used.
Initial Spell check for Flash of Light selection in BestHeal()
Corrected some error reporting code in BuffBylevel()
Blessing of Sacrifice was added to the / processor and the tables for it completed.
Blessing of Sancturary was added to the / processor and tables for it completed.
Corrected a cure issue that would cause nil exception when not a curable debuff.
AutoBless will now select the party buff over the raid buff.
The new order is saved, party, raid.then solo.
The party blessing will be used if the target is in your party, even when in a raid
group. The raid blessing will only be used on raid group members that are not
members of your own party.
Corrected the code in group debuff function that was not using correct
index.
The forcenotify function will now send its messages over the Raid channel
instead of the Party channel if you are in a Raid group.
Corrected two French Translation Errors.
Corrected a severe Initialization error.  In all previous versions, the Paladin_Initialize() function was first
called   on the VARIABLES_LOADED event.  When WoW first loads, this event does not provide any spellbook,
or character data.  This prevented the Addon from correctly reading the spellbook.
Removed all instances of UnitInRaid() because that function is currently broken.
Changed the default raid buff from bosal to bow.  Salvation does not seem to want to work on raid group members.
These last two items are supposed to be covered in the 1.6 client release, so I will revisit this then.

===============================
Paladin Assistant 1.11 07/05/05
===============================

Features added
--------------
Cure Code finished and implemented. "/paladin autocure" and "/paladin bestcure" will use purify or cleanse.
New setting: Paladin.Settings.Heal.FolTH sets Mana threshold to exclusive use of Flash of Light spells.


Fixes
-----
Initilization code now calculates correct min and max values from spellbook.
Improved error reporting in Blessing code.
When the player level is below the level required for the default class blessing: "Blessing of Salvation", the
blessings are reconfigured to use "Blessing of Wisdom" for "Inside Group" (ig), and "Raid Group" (rg).


==============================
Paladin Assistant 1.1 07/02/05
==============================

Features added
--------------
"/paladin autocure"; and "/paladin bestcure" were added. Autocure will cure party or raid group.
Note in this release, the functions only find who is infected. I ran out of time fixing some nasty issues
this week. 1.11 will be a patch to finish the cure functions.
autobless has three buffs to pick from depending on if you are grouped or not.
the defclassbuff array has a "ig" (inside group) buff, "og" for outside group buff,
and "rg" for raid group buff.
The logic in the autobless function has been simplified to use this variable now.
The default group settings are everyone gets Salvation but Warriors.
I used my healadin setting of paladins in your group get Wisdom, but outside it get Might.
You can change the buffs for any class in defclassbuff.
New setting "/paladin inform" that will inform the player via whisper that they will receive the heal/buff.
In verbose mode this will be set to false by default (while you are in a group).
In quiet mode it will be set to true by default.
You can also change it manually with "/paladin inform".
I saw another Addon doing something like this and I was instantly hooked.
Better estimation of HP for targets outside the group using class scales.
Blessing of Kings was added to the command list.
Localization for German and French Clients

Fixes
-----
The CheckTraget(unit) function's range checking code had a slight issue. It would return true from the entire
CheckTarget() function if:
	CheckInteractDistance returned false and
	The Range returned by GetRangeToUnit() was >0 and <= 30.
This would bypass all other checks in CheckTarget()  Im not aware of any specific issues because of this,
but it's been corrected anyway.
Blessing of Salvation and other spells without ranks could not be cast.
A small flaw in some conditional (for n=1, total do) loops was corrected that would sometimes cause every
other "n" to skip. This was probably present from v1.0 of the Helper App.
Added a UnitExists() check to the beginning of CheckTarget() to avoid rare runtime errors.
Fixed the Initialize function where updated healing amounts from spells were not being saved.
The GetRank() function was not returning valid values, and was updated. It is only used for display
purposes at this time.


========================
1.01 Released on 6/30/05
========================

Features introduced in 1.01
---------------------------
None.


Fixes included in 1.01
----------------------
The friendly target bug is gone. Notice if you have one targeted, and try to heal lowest in party,
or buff/heal yourself, your target will be cleared.
No clearing will take place if you have the enemy targeted, and/or are in battle.
This is much better than casting a heal on something that may not need any healing at all.


===========================================
1.0 Paladin Assistant = Paladin Helper v1.6
===========================================

Version 1.0 of Paladin Assistant was based on Paladin Helper v1.0 and 1.5 with the following features
and fixes. Paladin Helper's author Avalon is leaving WoW, and you can view the transition of Paladin Helper
to Paladin Assistant here: http://www.curse-gaming.com/en/wow/addons-1334-1-paladin-helper.html.
Paladin Assistant 1.0 is basically 1.6 Paladin Helper. I sent Avalon my changes, and that is what was posted.


Features Introduced in 1.0
--------------------------
Mana checks in the Healing code. 1st check is to verify enough is available for rank 1 spells.
2nd check is after spell selection. Rank will be reduced until enough is available.
BestHeal uses "Flash of Light" Spells when target health is at or above 70%.
Note that no previous versions used Flash of Light spells automatically.
Estimated HP of Friendly Targets in BestHeal (Heal outside of group with BestHeal)
New "/paladin raidheal" will heal raid member with lowest health.
If not in a raid, this command will function just like the autoheal in "party/solo" mode.
Divine Intervention "/paladin di" will cast divine intervention on closest alive paladin, preist, or druid in
that order. A message will be sent to the group, or raid, letting everyone know what you are doing.
Verbose mode has no effect on this message.
Added Level Based Blessing of Light. This "will" also be used in Bestheal (when I am 40 and can test it),
it will be detected on each target.
Range is calculated between player and target. Range is set and used on all spells. Notice if you are in a instance, the ranges will always be -1. Make sure you are within 20-30 yards.
New Paladin variable for settings which will be used in the upcomming v2.0 w/Gui release.
More safety checks for buffs and heals.
Command line help added.

Fixes included in 1.0
---------------------
Initialization sets correct min and max for HL and FL spells. HL spells use floating point, which caused
min and max values for HL spells to only include the decimal.
The effect varied but some spells would have higher mins, than maxes, or 0 for both min and max.
This affected the logic in BestHeal. Note this effect would only show up if you used training points to
improve holy spells.
Autobuff, and all level based buffing sets correct level buff for all level players. (Buff Level - 10)
BestHeal was calling Paladin_CombineSpell. That function was renamed CombinSpell.
"/paladin bow" now works as intended.
The Paladin class itself will receive "Blessing of Might" blessing by default.



