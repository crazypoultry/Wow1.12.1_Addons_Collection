RaidSummon.lua public interface
-------------------------------

The following is a list of RaidSummon's visible functions. If you are an addon
author and would like to use RaidSummon features in your addon, these functions
should provide you with everything you need (hopefuly). For a more up to date
list have a look at SimpleInterface.lua

RSM_RegisterForUpdate(fnc)
  Registers a function that is called when RaidSummon's status changes, i.e.
  new player in queue, player goes AFK...

RSM_SummonQueued()
  Summonst next queued player.

RSM_SummonAll()
  Initiates mass summoning and summons the first player. Use RSM_SummonQueued()
  to summon the others (note that in this state, the queue is generated on the
  fly and will always contain only one player).

RSM_SummonTarget()
  Adds current target as first in queue (and makes sure the player is only
  queued once) and begins a Ritual of Summoning. If ritual fails, the player
  will stay queued, making a retry with RSM_SummonQueued() possible. Note that
  in this case, depending on the reason of the failure, RaidSummon might move
  the player to the end of the queue.

RSM_SummonUnit()
  Summons a specific unit (usually "target", "raidx" or "partyx")

RSM_ResetQueue()
  Resets the queue or if currently in mass summoning mode, disable it and
  unqueue automatically queued players but don't clear the rest of the list.

RSM_SkipQueue()
  Skips first player in queue.

RSM_ToggleListen(verbose)
  Enable or disable request processing.

RSM_ToggleEnable(verbose)
  Enable or disable RaidSummon functionality as described in Readme.txt.

RSM_ToggleAnnounce(verbose)
  Enable or disable summoning announcements to the raid.

RSM_ToggleWhisper(verbose)
  Enable or disable summoning notifications by whisper.

RSM_ToggleHideReplies(verbose)
  Toggle whether RaidSummon's replies should be hidden from the chatframe.

RSM_ToggleHideRequests(verbose)
  Toggle whether accepted summoning requests should be hidden from the
  chatframe.

RSM_ToggleFlashing(verbose)
  Enable or disable action button flashing while players are queued.

RSM_SetShardMinimum(num, verbose)
  Sets minimum number of shards required before autoaccepting requests.

RSM_SetNotificationLanguage(newLang, verbose)
  Sets language for notifications to other players, ie. "de", "en", "fr".

RSM_GetSummonQueueCount()
  Number of players currently in the summoning queue.

RSM_GetSummonQueue(index)
  Retrieve name of player currently queued at position <index>.

RSM_GetAFK()
  Returns true if RaidSummon is in AFK-mode or false if not.

RSM_GetListening()
  Returns true if RaidSummon is listening to summoning requests, otherwise
  false.

RSM_GetEnabled()
  Returns true if RaidSummon functionality is currently enabled, otherwise
  false.

RSM_GetAnnouncing()
  Returns true if RaidSummon announces summoned players to the raid.

RSM_GetWhispering()
  Returns true if summoning notification by whisper is enabled.

RSM_GetSummonAll()
  Returns true while RaidSummon is in mass summoning mode, otherwise false.

RSM_GetHideRequests()
  Returns true if RaidSummoning is currently preventing accepted requests from
  appearing in the ChatFrame.

RSM_GetHideReplies()
  Returns true if RaidSummoning is currently preventing its own replied from
  appearing in the ChatFrame.

RSM_GetFlashing()
  Returns true if actionbutton flashing is enabled.

RSM_GetShardMinimum()
  Returns minimum number of shards required before autoaccepting summonging
  requests.

RSM_GetNotificationLanguage()
  Returns selected language for notifications, ie. "de", "en", "fr".

RSM_Announce()
  Announce RaidSummon functionality to raid/group.
