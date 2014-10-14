SmartPet V2.5.2b (EN,DE,FR) Written By Wowaddict Based on code by Gathirer.

A Hunter addon to help your pet out. Continuing the legacy of Dreyruugr's original addon. Now with limited Warlock support.

Features:
* Graphical User Interface to make the use of the add on easier

* The Button:  A one button binding to give a pet attack, pet recall commands depending on when pressed.  The following are the results of pushing “The Button”
   Action					Result
-Enemy Selected  	-->> 	Attack targeted enemy
-Ally Selected 		-->> 	Assist the selected ally and attack its target
-No target Selected 	-->>  	If pet is in combat, will recall pet
-No Chase Warning Given -->>  	Will recall pet

*<FIXED> Taunt Management: Enabling this will ensure that your pet always has enough focus to Cower or Growl. Each time you enter combat, your pet will make use of the abilities that were set to Autocast when combat started, while maintaining enough focus to growl or cower every 5 seconds. After combat ends, abilities that were disabled by the focus manager during combat will be re-enabled. (No longer Automatic - need KeyMinder addon as of Patch 1.10)

*<FIXED> Smart Focus Management: Enabling this will attempt to maximize your pets DPS output by automatically enabling and disabling burst and sustained damage abilities at the appropriate time. *See Note Below for Change (No longer Automatic - need KeyMinder addon as of Patch 1.10)

* Health Warning: Enabling this will send a message to a selected channel if your pets health drops below the specified amount. <Warlock Useable>

* Auto Cower: Enabling this will cause your pet to cower when its health drops below the specified amount. (No longer Automatic - need KeyMinder addon as of Patch 1.10)

* No Chase: Enabling this will attempt to prevent your pet from chasing fleeing targets. Only works if you and your pet are fighting the same target. (No longer Automatic - needs a keypress as of Patch 1.6) <Warlock Useable>

*<UPDATED> PVP Taunt Management:  When commanding your pet to attack a PVP enabled player, smart pet will automatically toggle off any taunt, detaunts, and autocower that are enabled. Upon the pet's exiting from combat these modes will reset themselves to pre PVP settings. Note: Will not trigger when attacking PVP enabled NPC's. (No longer Automatic - need KeyMinder addon as of Patch 1.10)

*<FIXED> Change pet’s orders (Follow/Stay) and mood (Passive/Defensive) on Scatter shot

* Break off a pet's attack and have it return to you by issuing a pet attack command with no target selected

* By targeting a friendly player and issuing a pet attack command, you and your pet will assist the target

*<UPDATED> Have the character say a phrase when sending you pet into battle on a chosen Channel (Say, Raid, Group) <Replaces the need for Rauen's Pet Attack due to incompatibilities between it and SmartPet>

* Chose a spell and have it cast when ordering pet to attack <Replaces the need for Rauen's Pet Attack due to incompatibilities between it and SmartPet>

*<FIXED> Breakable Debuff Check:  Checks to see if target has a breakable debuff on it and prevents the pet from being ordered to attack it.  <Note: This Feature does not have the pet stop attacking its target if a breakable debuff is placed on it.>

*<NEW> Smart Feed: Choose a pet food in your bags, and create a macro '/sp feed' or bind a key to the function. Feed your pet with a single click. It will automatically search the other slots in the bags for the same food. This is an experimental feature, and more capabilities can be added if there is a demand.

Installation:
Unzip into <WoW Install Dir>\Interface\AddOns

Usage:
Type /smartpet or /sp  to bring up the User Interface

From there you can enable the various features by checking the appropriate box

*SmartPet Enabled:	Turns on/off the SmartPet Addon (if off the majority of the options below will be hidden)
*Show Gui Icon:		Toggles the button for the Gui located next to the pet bar on/off
*Enable ToolTips:	Toggles the tooltips for the check boxes above the pet Bar on/off

*Give Alert on Attack:	Have your character make an announcement on the SAY channel before attacking <Like Rauens PetAttack>
*Delay:			The time between giving attack alerts
Say/Party/Guild/Raid/Channel:	The channel to have the Attack Alert broadcast to (These are only visible if Use AutoWarn is enabled)
*Use SmartFocus		Has SmartPet mannage the pets focus
*Use Dive/Dash on attack:  Has your pet cast dash/dive when entering into combat
*Enable NoChase:	Has your pet stop attacking if the target flees (See Notes Below)
*Show Recall Warning:	Displays an on screen warning to let you know to recall your pet
*Use AutoCower:		Has your pet switch to cower mode when its health falls below a certain %
*AutoCower%:		Percent of health left before switching to auto cower
*Cast Spell on attack:	Drag a spell from your spell list onto the box and that spell will be cast when you give the pet attack command. Left click to clear <Like Rauens PetAttack>
*Use Scatter Call Off:   Issues a PetFollow() command when you use scattershot (See Notes Below)
*Defend/Passive & Stay/Follow:  What pets setting will be set to with Scatter Shot Call Off (These are only visible if Use AutoWarn is enabled)
*Use AutoWarn:		Makes an announcement letting others know that your pet needs healing
*AutoWarn%:		Percent of health left before making warning
*Say/Party/Guild/Raid/Channel:	What channel AutoWarn will use (These are only visible if Use AutoWarn is enabled)


Changes Due to WOW Patch 1.6
KeyMinder - If you are using KeyMinder with an automatic key masher running in the background then everything should work as in previous versions and you can disable the Show Recall Warning. **Note I am not advocating the use of an automatic key masher. Use of one could possibly be in violation of Blizzard's TOS and could result in account banning/cancellation.**

NoChase:  The pet will no longer automatically be recalled when its target flees.  To have the pet break off attack when its target flees now requires a key press. When the  message appear on screen telling you to recall your pet then press the key that you have “The Button” bound to or press KeyMinder's "Wack that key" binding and your pet will recall.

Scatter Shot Call off:  To use the scatter shot call off, bind a key to "Scatter Shot Call Off” in the key binding menu or make a macro with the line “/script SmartPetScatterShot()” .  Using this macro or the key binding will cast ScatterShot then set your pet’s actions to what you have chosen in the SmartPet Option menu.  Using the standard ScatterShot button will not activate the Call Off

Known Issues:
-Not compatible with Rauen's PetAttack
-Occasionally the checkboxes above the PetBar will not appear after switching pets. To fix this enter the options menu and disable then enable SmartPet
-Occasionally you might get a "Spell not ready" error, this is from the casting of dash/dive which trigger the global 1 second delay
-When Learning New Spells the Spell Selected for Cast Spell on Attack will change

SmartPet FAQ
Q- Why is SmartPet NoChase no longer working
A- In Blizzard's 1.6 patch the changed the code so that pet action commands needed to be triggered by a key press and could not be triggered automatically in code as in previous versions

Q- Why is Skill X auto casting when it is not on the pet action bar?
A- This is a bug with WOW introduced with Patch 1.4 and has nothing to do with smartpet. This appears to be getting fixed in Patch 1.7 with the introduction of being able to set autocast via the pet’s spellbook tab

Q- My pet is not holding agro anymore.
A- Is smartpet enabled, growl on the action bar, and the check box over it checked.  If yes, check the combat log to verify that growl is being cast. If it is being cast then there are 2 possible causes. 
1) Cower is removed from the pet action bar, and is auto casting due to the WOW bug
2) Your pet might need to learn the next rank of growl. As the pet’s level increases growl’s effectiveness starts to diminish until the next rank of growl is learned.

Q- I have the NoChase feature selected and I am fighting mob A and my pet is fighting mob B.  Mob A runs away and my pet stops attacking mob B.  Why is this?
A- This scenario should only happen if mob A & B have the same name.  This is due to WOW does not give any way to differentiate between any group of mobs with the same name. I am working on changing it so this will no longer happen.

Q- The check boxes are not showing above the pet skills.
A- This happens every so often, but I still have not found the cause.  Disabling then re-enabling smartpet should fix the problem.

Q- What Changed in the 2.5 version for the Smart Focus Management?
A- MaddBommer tweaked the code for me so now this mod will make your pet Bite, then calculate the number of times it can claw while Bite's cooldown is going on and claw that many times.
Its set so it should always have enough focus to bite within 1 second of a focus regen

Q- I've noticed that the tick boxes above claw and bite do not display unless I also have growl or cower checked. Why is this?
A- What has happened is SmartFocus has been turned off. If SmartFocus is enabled and you have the ticks over growl/cower, bite, claw on; when you attack SmartPet disables Bite and will have your pet use claw for the first 12 seconds of combat then switch to using bite. If it is disabled then your pet will go into combat using both Bite & Claw and SmartPet will not disable claw & bite except to reserve focus to cast growl/cower.

Q - How do I change the Attack Alert annoucements
A - Open the file SmartPetAttackMessages.lua in a text editor.  There are 3 differnt message types: Assist Player, Assist Target, Attack.  To add messages to any section, put a comma after the last line and then write you message in quotation marks on the next line.  If you want the message to automaticly include the player's, target's, or pet's name then use the filler: player, pet, target precieded and/or followed by two periods depending on where you want to info to be inserted.
Example: pet = Killer   target = Elder Boar
pet.."! Attack the "..target.."!", would print out  "Killer! Attack the Elder Boar"

Thanks to the following:
- Dreyruugr for coding the original SmartPet that this is based on
- Ghanid for the code needed for localization & German client translations
- Everyone who has left feedback & support for this project
- MaddBommer for the Smart Focus Management code tweak 

Future goals for SmartPet 
(NOTE:  This list is not in any order, nor is there a timeframe for implementing them & not
everything might make it into the addon)
- Integrate the defunct PetDefend mod
- Implementing management new pet skills 
- Better focus management with more user customization
- Pet Action Bar upgrades
- Checks to stop attack if target is charmed/stunned/sheeped/ect.
- Integration with Titan Panel
- Implementing pet feeding ability
