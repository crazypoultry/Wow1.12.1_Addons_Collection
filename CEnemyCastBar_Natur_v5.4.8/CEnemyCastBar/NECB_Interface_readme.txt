Natur EnemyCastBar

Description for optional Bossmods support.
------------------------------------------

Since version 3.0.0 CECB parses Party-/Raid- and Custom-Channels for CECB commands. With version 3.5.2 the automatic broadcasting feature was presented.
Since version 5.0.0 NECB uses the new communication system introduced with patch 1.12!

Any Bossmod may post commands to the channel by using 'SendAddonMessage("NECBCTRA", msg, "RAID");'
--------------------------------------------------------
--> SendAddonMessage("NECBCTRA", ".countmin 2 Time until Spawn", "RAID");
--------------------------------------------------------

I strongly suggest that only promoted players or the raid leader is allowed to print messages to the AddOn channel by software to reduce traffic which might cause lag!

NECB internally uses the prefix "NECB", but "NECBCTRA" will even parse the broadcasted message if it was received by the sender!
So with the prefix "NECBCTRA" the broadcaster of the event will trigger a CastBar for himself. Only use this prefix! :D

The currently supported commands (msgs) are:
.countsec sss label
.countmin mmm label
.repeat sss label
.stopcount label
.cecbspell MobName, SpellName, Type, ClientLang, Latency

-> .countsec triggers a grey bar with a 'sss' seconds timer and the spellname 'label' (which is the first part of the label)
-> .countmin triggers a grey bar with a 'mmm' minutes timer and the spellname 'label' (which is the first part of the label)
-> .repeat triggers a grey bar with a 'sss' seconds timer and the spellname 'label' (which is the first part of the label),
but this one starts from the beginning after the total time has passed
-> .stopcount is able to delete bars which full label inherits a part of 'label'.
So a bar with the label "Firemaw - (30 Seconds)" will be deleted by '.stopcount maw' or '.stopcount 30'.
The command '.stopcount all' deletes all grey bars at once.

-> .cecbspell triggers a bar from the CECB spell database.
Example: ".cecbspell Ragnaros, Sons of Flame, pve, enUS, 100" (currently triggered by the CECB engine ;-) )
This should only be used for spells the CECB engine won't detect itself. Ideal for remotely triggered castbars!


Some hints:
-----------
* The CECB channel .commands are put through a unique check, so that only one bar with the same SPELL (first part of the label) is shown at once. If one grey bar with the same name is active it will be updated/restartet!
So many users who post an automated message (e.g. '.countsec 35 Until Start') will only trigger ONE CastBar for all channel users!
* If NECB was loaded by the client the variable 'necbactive' will be 'true' (boolean). "If (necbactive) then..."

But please try to avoid channel spamming! Keep the traffic as low as possible please ;-)



--------------- ==AUTOMATIC BC== ----------------
-------------------------------------------------
Some words to the automatic broadcasting feature:
-------------------------------------------------
# Only Raidspells and -Debuffs plus Debuffs like "Polymorph" and their fade plus the mobs death (if needed) will be broadcasted.
# I suggest that only a handful people broadcast the spells to keep channel traffic as low as possible: The MT, a healer and the raidleader. So hopefully a big radius of combatlog messages is catched.
# Users with a latency more than 500ms won't broadcast to not delay the timer too much.
# You have to turn these specific spell categories on to broadcast the above spell categories.
# To reduce broadcast traffic the same broadcast won't be directly repeated within a short peroid of time (< 5 seconds)! (Same with received packets.)
# If sender and receiver have a client of different language then broadcasts won't be accepted
Although I tried my best to add a feature like this, expect no wonders and don't fear strange castbar behaviors! Otherwise don't use it ;-)

