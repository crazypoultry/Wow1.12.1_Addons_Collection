-- listed in this file are RaidSummon's public functions
-- if you are an addon author, please don't use any of RaidSummon's internal variables
-- and functions as they are likely to change.

-- call during dropdown menu intialization to add default RaidSummon menu entries
RSM_BuildBaseMenu= rsmDropdownMenu.BuildBaseMenu;

-- register a callback function. all registered functions will be called when
-- the queue or the players status changes (afk)
-- p1: function func
RSM_RegisterForUpdate= rsmUtil.RegisterForUpdate;

-- semi intelligent summoning mode, will summon target, from queue or everybody
RSM_SummonAuto= rsm.SummonAuto;

-- summon first player in queue (also hiding targetchange from player)
RSM_SummonQueued= rsm.SummonQueued;

-- summon everybody not currently in this zone
RSM_SummonAll= rsm.SummonAll;

-- queue and summon unit
-- p1: string unitID
RSM_SummonUnit= rsm.SummonUnit;

-- queue and summon target
RSM_SummonTarget= rsm.SummonTarget;

-- announce raidsummon
RSM_Announce= rsm.Announce;

-- removes all players from the queue
-- p1: boolean verbose
RSM_ResetQueue= rsm.ResetQueue;

-- skip player currently queued first
-- p1: boolean verbose
RSM_SkipQueue= rsm.SkipQueue;

-- add keyword to list of words that trigger a summoning request
-- p1: string language
-- p2: string keyword
RSM_KeywordAdd= rsmSettings.KeywordAdd;

-- remove keyword from list
-- p1: string language
-- p2: string keyword
RSM_KeywordRemove= rsmSettings.KeywordRemove;

-- reset list of keywords for specified language
-- p1: string language
RSM_KeywordReset= rsmSettings.KeywordReset;

-- return keywords for a specific language
-- p1: string language
RSM_GetKeywords= rsm.GetKeywords;

-- check if local player afk
RSM_IsPlayerAFK= rsm.IsPlayerAFK;

-- true while client is in mass summoning mode and autoselecting summoning targets
RSM_IsMassSummoning= rsm.IsMassSummoning;

-- true after initialization
RSM_IsAddonLoaded= rsm.IsAddonLoaded;

-- return number of players currently queued for summoning
RSM_GetSummonQueueCount= rsm.GetNumPlayerQueued;

-- return name of player queued at position index
-- p1: numeric index
RSM_GetSummonQueue= rsm.GetPlayerQueued;

-- select announcement/whisper language
-- p1: string newLang
-- p2: boolean verbose
RSM_SetNotificationLanguage= rsmSettings.SetNotificationLanguage;

-- set minimum number of shards required to process requests
-- p1: numeric min
-- p2 boolean verbose
RSM_SetShardMinimum= rsmSettings.SetShardMinimum;

-- enable/disable settings functions
-- p1: boolean verbose
RSM_ToggleEnable= rsmSettings.ToggleEnable;
RSM_ToggleListen= rsmSettings.ToggleListen;
RSM_ToggleAnnounce= rsmSettings.ToggleAnnounce;
RSM_ToggleWhisper= rsmSettings.ToggleWhisper;
RSM_ToggleFlashing= rsmSettings.ToggleFlashing;
RSM_ToggleHideRequests= rsmSettings.ToggleHideRequests;
RSM_ToggleHideReplies= rsmSettings.ToggleHideReplies;

-- settings query functions
function RSM_GetHideRequests()
  return rsmSaved.hideRequests;
end;
function RSM_GetHideReplies()
  return rsmSaved.hideReplies;
end;
function RSM_GetFlashing()
  return rsmSaved.flashAction;
end;
function RSM_GetEnabled()
  return rsmSaved.enabled;
end;
function RSM_GetListening()
  return rsmSaved.listen;
end;
function RSM_GetAnnouncing()
  return rsmSaved.announce;
end;
function RSM_GetWhispering()
  return rsmSaved.whisper;
end;
function RSM_GetNotificationLanguage()
  return rsmSaved.interactLang;
end;
function RSM_GetShardMinimum()
  return rsmSaved.minShards;
end;