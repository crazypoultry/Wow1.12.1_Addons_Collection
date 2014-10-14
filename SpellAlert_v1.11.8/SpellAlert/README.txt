SpellAlert (modified again)
Author:______Sent
Thanks:______Awen_(Original_Author)
_____________Mithryn_(versions_up_to_1.65)
_____________MarsMod_(MarsMessageParser.lua)
_____________Archiv_(German_localization)
_____________Feu_(French_localization)

Link to the original SpellAlert:
http://ui.worldofwar.net/ui.php?id=457
http://ui.worldofwar.net/ui.php?id=1485

This Addon is a modification of the original Spell Alert by Awen and SpellAlert (modified) by Mithryn.
SpellAlert warns the user of what enemies around him are casting.

>>> See USEFUL INFORMATIONS.txt for options <<<

Feedback is VERY much appreciated. Feel free to post any bug or suggestion.

Known bugs:
 - Alert type 4 (totem) not available.
 - Slash commands out-dated.

Changes:
1.11.8
 -Font outline available again
 -Line spacing now customizable
 -Event handling function rewritten using MarsMessageParser
 -New bulletproof saved variables integrity checking system (auto-update, no more need to reset)
 -Added more tooltips then needed
 -Some changes in preparation to 1.10.9

1.10.7
 -Options window (rewritten from scratch) available again.
 -Minor changes in preparation to 1.10.8

1.10.6
 -Alertframes should be restored properly.
 -You can change the number of lines per alertframe (do you remember the old good SA with 3 lines?)
 -Fixed problems with alert 6 and 2.
 -Fading function fixed and improved, now you can set number of seconds before fade starts and fading duration
 -WARNING! ft = 0 means DON'T FADE! This is not a bug, if you want a very very fast fading set it to 0.1

1.10.5
 -Now you can auto disable SA while resting (ex. inside main cities) typing '/spellalert offonrest'
 -Added two more alert frames, alerts can be redirected typing '/spellalert {AlertNum:0-8} goto {num:1-3}'
 -Some more /commands added

1.10.4
 -AlertText draggable again
 -Short Display available again
 -Fixed a typo in periodic alert (type 6)
 -/commands handler fixed once for all(?)

1.10.3
 -TargetOnly now works properly
 -Istant alert (type 7) available again

1.10.2
 -Healing alert (type 1) available again
 -Fixed event filtering

1.10.1
 -Some Slash Commands added
 -Alert Functions rewritten (more alert types YEAH!)
 -Code cleanup

1.10.0
 -Versioning changed
 -Retarget (after feign death) function moved to a stand-alone addon (SARetarget)

1.68
 -Spells Tables updated (too lazy to list)
 -Minor adjustaments
 -Code cleanup (retarget no more needed after 1.10)

1.67
 -Short alert display option added.
 -Removed living bomb alert (please use CT_BossMods)

1.65
 -Improved dragging of the alert.

1.6
 -Fixed hunter retargetting! Woot!
 -Re-added Living Bomb warning. (Stupid MC lockout >_<! Let
  me know if it doesn't actually work =P)
 -Added option to change the delay time before fading out.

1.51
 -Fixed silly typos that caused some options to not work.
 -Renamed "alert emotes" to "alert npc emotes"
 -There are some spells that are not listed in the
  localization thus making some
  options to turn off specific alerts to "seem" like they are
  not working.
 -TODO: Fix Hunter retargetting.
        Perhaps re-add Living Bomb warnings etc.
        Add other spells to the localizations.
 -REMEMBER: Feedback is VERY much appreciated.  So feel free
  to post any bugs orsuggestions.  If you encounter any spells
  that I need to add to the spell list, please tell me.  If I 
  said that I fixed a bug but it turns out I didn't really
  fix it... please tell me! =D

1.5
 -Updated TOC to 10900.
 -Options frame is now draggable... yay!
 -Changed the layout of the options panel.. because it's THAT important. =D
 -Fixed some typos, clarified some stuff with tooltips.
 -Added the option to change the border thickness of the alerts.
 -A reset button.. for people who like defaults!
 -As requested, the alert may now be dragged for the hardcore customizers' needs.
 -TODO: Fix known bugs.

1.4
 -Fixed A LOT of stupid typos and mistakes >_<
 -Added ability to set whether you want the whole message,
  just the spell name, or everything but the spell name colored.
 -Colors no longer "reset" when opening the options window.
 -Changed font to something less beefy, pixelation should no longer occur on
  size changing.  I plan on adding an option to set whether the text is bold
  like before, or streamline like it is now.

1.3
 -Color-coded alerts
 -Added retarget after Death Coil

1.2
 -Readded Auto-retarget
 -Settings now saved per character
 -Fixed random typos

1.1:
 -Removed some redundant code
 -Removed Onyxia and Living Bomb warnings (CTRA does these great)
 -Removed Auto-retarget (Not very reliable)
 -Recoded the way the Alert was displayed.  Nothing visible to the user
  has changed
 -Added ability to change font size

1.0:
 -Increased font size
 -Added ability to move the Alert