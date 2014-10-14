----------------------------
==-- CombatSentryGizmo --===
=====----- V 0.74b ----=====
====---- by Chester ----====
----------------------------
---chester.dent@gmail.com---


==FEATURES==
VISUAL: CombatSentryGizmo keeps a visual, clickable list of current and potential attackers, buffers and healers.  

DETECTION: CombatSentryGizmo also displays current enemy players that it 'detects' even if they haven't attacked you (meaning: the enemy performs an action that shows up in your combat log), if you have that option turned on.

CLICKABLE: All enemy player frames are clickable which will select that enemy for you.  (creature frames are not clickable due to the way Blizzard handles unit names)

PARTY: Party members who are being attacked will show in your list as well.  You can then click on the attackers frame to assist them.

ATTACCKER INFO: In addition to showing their name, attacker frames will also show the attackers portrait, level, class (color coded), current damage they've done to you, and rank icon.

COLOR CODED: For quick reference, their frame background is also colored based on their level vs yours.

AUDIO CUES: A sound is played when an enemy is detected and when an enemy attacks you.  A different sound is played when an enemy healer or buffer is detected as well as showing you who they healed/buffed and what their name is.  (This is clickable as well)

CONTROL PANEL: CombatSentryGizmo also has an easy to access, draggable control panel for quick toggling of options that compacts when not used. (by default it attaches itself below your minimap)


==HOW TO READ THE FRAMES==
--Tranluscent frame: Enemy player is not attacking you, but has been detected
--Solid Frame: Enemy is attacking you!  (also displays the amount damage they are doing to you)
--Red Border: This is an enemy player
--Black border: This is an enemy NPC or creature (non-player)
--Blue border: A party member is being attacked!  (click the frame to aid them)
--Branched frame: This enemy is healing or buffing another enemy in your list
--Heal Icon: This displays next to an enemy healers who is healing an enemy in your list
--Magic Icon: This displays next to an enemy buffer who is buffing an enemy in your list


==CONTROL PANEL OPTIONS==
-CombatSentryGizmo Toggle
When disabled, CombatSentryGizmo is off and will not function.

-Enemy Detection
Toggles enemy detection.
WARNING: Having both Enemy Detection and Auto Targeting Info on can potentially mess with your targeting when your framerate or network connection is poor.  It is recommended that you turn this and Auto Targeting Info off in those situations.

-Creatures Toggle
Toggles whether creatures (non players) will show up in CombatSentryGizmo.

-Auto Targeting Info
Toggles CombatSentryGizmo's auto info gathering for attackers.
WARNING: When on, CombatSentryGizmo will gather info from your attacker by targeting it 'under-the-hood'.  When off, CombatSentryGizmo will never try to gather info from your attacker.  However, if you manually select them or mouse-over them, their info will fill in.



--- CHANGELIST
4/12/06 - v0.76b
-updated for 1.10 patch

1/7/06 - v0.75b
-updated toc
-fixed scaling issues
-improved filtering of enemies
-fixed mousing over a mob in combat (who is not in combat with you) getting added to the list

9/28/05 - v0.74b
-updated toc
-fixed frames not scaling to correct scale if the scale was modified and they were the first frame to show

7/24/05 - v0.73b
-fixed your cursor becoming stuck if you dragged the anchor and it dissapeared on you
-"Unknown Entity" is now localized
-fixed one more nil error
-AutoTargetingInfo and CreaturesToggle are now OFF by default for new users
-converted CSG icons to blp2 format (saves 65k, you must delete your old CSG folder before installing this new one to benefit from the memory gains)

7/21/05 - v0.72b
-fixed ltext error
-fixed one more nil error

7/20/05 - v0.71b
-fixed typo in localization which was causing a nil error

7/20/05 - v0.7b
-fixed error with not finding 'partypet'
-information gathering on mouseover and target select is more reliable now
-if you have auto-targeting turned on, CSG will no longer ever auto-target while you are in combat. 
---this means that rogues can use this feature without fear of losing combo points
-CSG nows checks spells cast to determine what class casted it (when you have auto-targeting turned off)
---English clients only for right now

**What the last two changes mean:
1) You can potentially play with CSG's Auto-Targeting turned off all the time and you will still get your enemies class 75% of the time
2) You can safely play with Auto-Targeting turned on without fear of CSG changing your target on you during the heat of the battle


7/17/05 - v0.62b
-fixed NOT being able to click player frames

7/16/05 - v0.61b
-fixed error with not finding 'ltext' with frames that didn't exist
-fixed error on clicking player frames

7/13/05 - v0.6b
-updated version number
-fixed quite a few nil bugs
-CSG is now localized for French! (thanks to Sasmira ( Cosmos Team ) & Gaysha!)
-fixed a lot of bugs related to having auto-targeting turned off
--fixed attackers you had targeted not filling in their info
--fixed npc's info not filling in when moused over
--if CSG can't detect a class, it will report Unknown with an icon to match
--Unknown icons and portraits are greyed out to match the frame
--fixed portrait and class not updating properly if you had a target and a new name showed on your list
--Enemy players detected (with auto-targeting turned off) should now be clickable
-reduced code due to new TargetLastTarget() function
-fixed frame state getting bad if you had reached your max number of visible frames

-added an options menu with a bunch of new options
--the Anchor Bar can now be always hidden as an option
--added ability to turn off all sounds that CSG plays
--added the following sliders:
= Scale
= Max Total Frames
= Max Non-Attackers
= Max Attackers
= Non-Attacker Timeout
= Attacker Timeout
= Healer/Buffer Timeout


7/3/05 - v0.5b
-fixed an error that German users were getting in relation to the class icon table (it wasn't localized)

6/24/05 - v0.4b
-class text repositioned and is now color coded
-added a class icon next to the portrait
-added tooltip when mousing over frame which displays the class name (also color coded)
-added health bar that fills the background of frame (get info when target is 'sampled', fades away when data is 'stale')
--bar will automatically refresh and show when you mouseover an attacker or target them
-fixed mousing over or targeting an enemy player not adding him to the list
-also fixed same for not updating an attackers info properly
-friendly players should no longer show up in your attcker list
-fleshed out the data gathering for attackers attacking party members (should be a bit more reliable now)
-frames which show attackers attacking party members are now clickable which lets you 'assist' your party member
-fixed error relating to Book of the Dead data (removed the functionality of tapping into that data because it recently became unreliable)
-fixed another error relating to being attacked by enemy players
-fixed error when clicking the X on the CSG Control Panel
-optimized code a bit
-added a 'scale' command (/csg scale n)
---valid numbers range from 0.5 to 2 for now (I'll make this a slider sometime soon)
--CAREFUL: Don't change scale when you have attackers on your list because the scales will get funky
---healthbar is now behind the text filling up the whole frame
---frames which hold non-attackers are now smaller as well as translucent
---party members names show better now (although I have plans to overhaul this whole thing and I think it will be pretty cool)
-party members being attacked should show up more reliably now (although pets still aren't being caught yet)
-added an 'addtarget' command for debugging (type /csg addtarget [damage]) to add a target
--CAREFUL: this is just for debugging so if you do this and don't have a target, you'll get an error.  If people find a real use for this, I can flesh it out.

6/10/05 - v0.3b
-updated toc to 1500
-fixed error that would pop up when a hostile player missed you (CSG_MISS_ABSORB string typo)
-party members being attacked by both creatues and players will now produce an attacker frame with a blue border as well as the partymember's name in red above the frame
-fixed the remaining (I hope) German text issues due to those crazy umlats and whatnot (thanks to help from epij) -- again, I cannot test this myself so German testers, please try this!

6/7/05 - v0.2b
-friendlies and party members will no longer show in the list
-toggling CSG off will now shut it off
-toggling creatures (npcs) off now works consistantly
-CSG now has a more reliable way of information gathering
-large gaps between frames that don't update should be extremely rare now
-fixed a bug where the anchor would stick around even if it had no units
-fixed a bug where when the anchor stuck around, no new units would show
-CSG is now localized for German users thanks to help from rednose!! (although this hasn't really been tested, Germans please test!)

NextVersion:
-lots of bugs to be fixed yet
-enemy units that are attacking your party members will show with a different color border


5/27/05 - v0.1b
-Released