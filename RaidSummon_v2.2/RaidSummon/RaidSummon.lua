-- constants
local ICON_SPELL=            "Interface\\Icons\\Spell_Shadow_Twilight";
local MAX_REQUEST_LEN=       20;     -- max. length of request message
local MAX_QUEUE_LENGTH=      15;     -- max. no. of players in queue

-- private internal state
local cacheSpellID=         nil;     -- spellid for ritual of summoning
local realChatFrameOnEvent= nil;     -- stores original ChatFrameOnEvent function
local ghostNotify=          nil;     -- remember if target has already been notified that summoning ghosts isn't possible
local alreadySummoned=      { };     -- targets already summoned by mass summon
local summoningProgress=    0;       -- 1: spellcast has started, 2: channeling has started, 3: casting has ended, 4: channeling is done
local summoningPlayer=      nil;     -- name of player currently being summoned
local summoningShards=      0;       -- shardcount before summoning: used to verfiy successful summon
local lastKnownX=           0;       -- last known player coords before zoning into an instance
local lastKnownY=           0;       --  ...
local update=               0;       -- onupdate interval timer
local isAFK=                false;   -- true as long as this player is afk
local isMassSummoning=      false;   -- set while mass summoning a raid
local isAddonLoaded=        false;   -- set after VARIABLES_LOADED
local summonQueue=          { };     -- table of queued players  

-- migrate pre version 2.2 stats
local function MigratePre2x2Stats()
  if (rsm_SummonsList) then
    for name, count in rsm_SummonsList do
      rsmSaved.summonsList[name]= count;
    end;
    rsm_SummonsList= nil;
    rsmUtil.PrintChatMessage(RSM_HEADER..RSM_PRE2x2MIGRATION);
  end;
end;

-- initialize RaidSummon (called once variables are loaded)
local function Initialize()
  -- make sure language setting is correct
  rsmUtil.GetLocalized("LANGUAGE");
  
  -- build keyword lists
  for lang, keywords in RSM_DEFAULT_KEYWORDS do
    if (not rsmSaved.keywords[lang]) then
      rsmSaved.keywords[lang]= { };
    end;
    if (table.getn(rsmSaved.keywords[lang]) == 0) then
      for i, keyword in keywords do
        rsmSaved.keywords[lang][i]= keyword;
      end;
    end;
  end;
  
  -- verify settings
  if (not rsmSaved.minShards or rsmSaved.minShards < 1) then
    rsm.minShards= 7;
  end;
  if (not rsmSaved.minDistance or rsmSaved.minDistance < 150) then
    rsm.minDistance= 1500;
  end;
  MigratePre2x2Stats();
  
  rsmUtil.UpdateInterfaces();
  rsmUtil.PrintChatMessage(RSM_LOADED);
  isAddonLoaded= true;
end;

-- update info about players AFK status
local function UpdatePlayerAFK(msg)
  if (msg) then
    local afkstring= string.format(MARKED_AFK_MESSAGE, "");
    if (string.find(msg, afkstring)) then
      isAFK= true;
      rsmUtil.UpdateInterfaces();
    elseif (msg == CLEARED_AFK) then
      isAFK= false;
      rsmUtil.UpdateInterfaces();
    end;
  end;
end;

-- increase summoning-counter for "nickname"
local function UpdateSummonStats(nickname)
  if (not rsmSaved.summonsList[nickname]) then
    rsmSaved.summonsList[nickname]= 1;
  else
    rsmSaved.summonsList[nickname]= rsmSaved.summonsList[nickname] +1;
  end;
end;

-- check if specified warlock has raidsummon installed and if so, if he's not afk, has shards and free slots in the queue
local function IsViableWarlock(unitID, unitName)
  local isRaidSummonUser= rsmComChannel.IsRaidSummonUser(unitName);
  return not isRaidSummonUser or (isRaidSummonUser and rsmComChannel.HasShards(unitName) and rsmComChannel.HasSlots(unitName) and rsmComChannel.IsPresent(unitName));
end;

-- try to find an alternative warlock to serve the summoning request
local function GetAlternativeWarlock(targetInInstance)
  local warlockID, warlockName;
  if (IsInInstance() and targetInInstance) then
    warlockID, warlockName= rsmUtil.FindInteractWarlock(IsViableWarlock);
  elseif (IsInInstance() and not targetInInstance) then
    warlockID, warlockName= rsmUtil.FindNearbyWarlock(rsmSaved.minDistance / 2, nil, lastKnownX, lastKnownY, IsViableWarlock);
  else
    warlockID, warlockName= rsmUtil.FindNearbyWarlock(rsmSaved.minDistance / 2, "player", 0, 0, IsViableWarlock);
  end;
  if (warlockID) then
    return warlockID, warlockName, rsmComChannel.IsRaidSummonUser(warlockName);
  else
    return nil, nil, nil;
  end;
end;

-- redirect request to another warlock if possible, and notify player
local function RedirectRequest(targetInInstance, nickname, tell1, tell2, tell3)
  local warlockID, warlockName, hasRSM= GetAlternativeWarlock(targetInInstance);
  if (not warlockID) then
    rsmUtil.SendTell(tell1, nickname);
  else
    if (hasRSM) then
      rsmComChannel.RequestSummon(warlockName, nickname);
      rsmUtil.SendTell(tell2, nickname, warlockID); --fixme: request needs to be answered first
    else
      rsmUtil.SendTell(tell3, nickname, warlockID);
    end;
  end;
end;

-- add a requesting player to summoning list
local function QueueRequester(nickname)
  -- this should never return nil, but just in case
  local unitID= rsmUtil.GetPID(nickname);
  if (not unitID) then
    return;
  end;
  local count= table.getn(summonQueue);  
  local targetInInstance= rsmUtil.UnitInInstance(unitID);

  -- basic checks before accepting request
  if (rsm.IsPlayerQueued(nickname)) then
    return;
  elseif (isAFK == true) then
    RedirectRequest(targetInInstance, nickname, "AFK_NONE", "AFK_AUTO", "AFK_MANUAL");
    return;
  elseif (rsm.IsLowOnShards()) then
    RedirectRequest(targetInInstance, nickname, "SHARDS_NONE", "SHARDS_AUTO", "SHARDS_MANUAL");
    return;
  elseif (rsm.IsQueueFull()) then
    RedirectRequest(targetInInstance, nickname, "FULL_NONE", "FULL_AUTO", "FULL_MANUAL");
    return;
  elseif (IsInInstance() and not rsmUtil.UnitInInstance(unitID)) then
    local warlockID, warlockName, hasRSM= rsmUtil.FindNearbyWarlock(rsmSaved.minDistance / 2, nil, lastKnownX, lastKnownY, IsViableWarlock);
    if (not warlockID) then
      rsmUtil.SendTell("INSTANCE_NONE", nickname); -- do not abort in this case
    else
      if (hasRSM) then
        rsmComChannel.RequestSummon(warlockName, nickname);
        rsmUtil.SendTell("INSTANCE_AUTO", nickname, warlockID); --fixme: request needs to be answered first
      else
        rsmUtil.SendTell("INSTANCE_MANUAL", nickname, warlockID);
      end;
      return;
    end;
  elseif ((UnitIsDeadOrGhost("player")) or (UnitAffectingCombat("player") == 1)) then
    rsmUtil.SendTell("BUSY", nickname);
  elseif (count > 0) then
    rsmUtil.SendTell("WAIT", nickname);
  else
    rsmUtil.SendTell("INCOMING", nickname);
  end;

  -- notify warlock on first summon request
  if (count == 0) then
    rsmUtil.PlaySoundRequest();
  end;

  -- otherwise add player to queue, visually notify warlock
  rsm.QueuePlayer(nickname, nil, true);
  local msg= string.gsub(RSM_REQUEST, "%%s", nickname);
  rsmUtil.DisplayMessage(msg, false);
  rsmUtil.PrintChatMessage(RSM_HEADER..msg);
  rsmUtil.UpdateInterfaces();
end;

-- return true if player can be used in autosummoning
local function CanAutoSelectPlayer(nickname)
  if (not alreadySummoned[nickname] and not rsmComChannel.IsLockedPlayer(nickname)) then
    return true;
  else
    return false;
  end;
end;

-- find player for mass summoning and add to list
local function QueueAutoSelected()
  local nickname=    nil;
  local justStarted= not isMassSummoning;

  -- locate distant member, enqueue first and prevent others from summoning this player for 15s
  nickname= rsmUtil.FindDistantMember(rsmSaved.minDistance, CanAutoSelectPlayer);
  if (nickname ~= nil) then
    alreadySummoned[nickname]= true;
    isMassSummoning= true;
    rsmComChannel.LockPlayer(nickname, 15);  

    -- if target is already queued, remove. in any case add as first in queue
    rsm.DequeuePlayer(nickname);
    rsm.QueuePlayer(nickname, 1, true);

    -- only print mass summoning notice once to chatlog
    if (justStarted) then
      rsmUtil.PrintChatMessage(RSM_HEADER..RSM_MASSSUMMON);
    end;

  -- no more members out of range
  else
    isMassSummoning= false;
    alreadySummoned= { };

    -- if just started and nothing to do notify user that everybody is in range
    if (justStarted) then
      rsmUtil.PlaySoundFailed();
      rsmUtil.DisplayMessage(RSM_ALL_IN_RANGE, true);
      rsmUtil.PrintChatMessage(RSM_HEADER..RSM_ALL_IN_RANGE);

    -- otherwise check if there are more normal summon requests queued (warning about those will happen in the eventhandler)
    else
      if (table.getn(summonQueue) == 0) then
        rsmUtil.DisplayMessage(RSM_NOTHING_TO_DO, false);
        rsmUtil.PrintChatMessage(RSM_HEADER..RSM_NOTHING_TO_DO);
      --else
        --local msg= string.gsub(RSM_MORE, "%%s", summonQueue[1]);
        --rsmUtil.DisplayMessage(msg, false);
        --rsmUtil.PrintChatMessage(RSM_HEADER..msg);        
      end;
    end;

  end;
end;

-- unlike other functions, the summon function is by default verbose since it is usally called by user input
-- this support function returns the provided errormessage and also prints it to screen, unless told otherwise
local function SummonError(msg, silent)
  if (not silent) then
    rsmUtil.DisplayMessage(msg, true);
    rsmUtil.PrintChatMessage(RSM_HEADER..msg);
  end;
  return msg;
end;

-- cast ritual of summoning (localization independent)
local function CastRitualOfSummoning()
  -- if spellid cached and valid, use it
  if (cacheSpellID) then
    local texture= GetSpellTexture(cacheSpellID, BOOKTYPE_SPELL);
    if (texture == ICON_SPELL) then
      CastSpell(cacheSpellID, BOOKTYPE_SPELL);
      return true;
    end;
  end;
  
  -- otherwise scan for the ritual
  local i= 1;
  local texture;
  repeat
    texture= GetSpellTexture(i, BOOKTYPE_SPELL);
    if (texture == ICON_SPELL) then
      CastSpell(i, BOOKTYPE_SPELL);
      cacheSpellID= i;
      return true;
    end;
    i= i +1;
  until (texture == nil);
  
  return false;
end;

-- summon the player currently queued first
local function Summon(silent)
  -- basic checks
  local shards= rsmUtil.GetNumShards();
  if (shards == 0) then
    rsmUtil.PlaySoundFailed();
    return SummonError(RSM_NOSHARDSUMMONING, silent);
  elseif (table.getn(summonQueue) == 0) then
    return SummonError(RSM_NOTHING_TO_DO, silent);
  end;

  -- select player, return if not in raid
  local nickname= summonQueue[1];
  local unitID= rsmUtil.GetPID(nickname);
  if (not unitID) then
    rsm.DequeuePlayer(nickname);
    rsmUtil.UpdateInterfaces();
    return SummonError(RSM_NOT_IN_RAID, silent);
  end;
    
  -- check if player is alive and online, then summon him/her and update stats
  if (UnitIsDeadOrGhost(unitID) or not UnitIsConnected(unitID)) then
    
    -- if mass summoning, unqueue player, queue new target and queue dead player last
    if (isMassSummoning) then
      rsm.DequeuePlayer(nickname);
      QueueAutoSelected();
      rsm.QueuePlayer(nickname);
      rsmUtil.UpdateInterfaces();      
      rsmUtil.PlaySoundFailed();      
      local msg= string.gsub(RSM_GHOSTSKIPPED, "%%s", nickname);
      return SummonError(msg, silent);
      
    -- if more players queued, skip dead guy for now and re-enqueue at end of list      
    elseif (table.getn(summonQueue) > 1) then
      table.remove(summonQueue, 1);
      table.insert(summonQueue, nickname);
      rsmUtil.UpdateInterfaces();      
      rsmUtil.PlaySoundFailed();
      local msg= string.gsub(RSM_GHOSTSKIPPED, "%%s", nickname);
      return SummonError(msg, silent);

      -- notify player one time that he cannot be summoned
    else
      if ((ghostNotify ~= nickname) and UnitIsConnected(unitID)) then
        rsmUtil.SendTell("YOU_ARE_DEAD", nickname);
        ghostNotify= nickname;
      end;
      rsmUtil.UpdateInterfaces();
      rsmUtil.PlaySoundFailed();
      local msg= string.gsub(RSM_GHOSTSUMMONING, "%%s", nickname);
      return SummonError(msg, silent);
    end;       

  else
    -- store name of current target, select summoning target, summon player and restore target, if neccessary
    local prevTargetName, prevTargetServer= UnitName("target");
    TargetUnit(unitID);

    -- remember that we're currently summoning and how much shards we had
    if (CastRitualOfSummoning()) then
      summoningPlayer= nickname;  
      summoningShards= shards;    
    end;

    -- restore previous target if neccessary
    local curTargetName, curTargetServer= UnitName("target");
    if ((prevTargetName ~= curTargetName) or (prevTargetServer ~= curTargetServer)) then
      TargetLastTarget();
    end;
  end;

  rsmUtil.UpdateInterfaces();
end;

-- handle events during summoning procedure
local function ProcessSummoningEvents(event)
  -- verify that summoning actually started (might not have worked if sitting, oom, oos...)
  if ((event == "SPELLCAST_START") and (summoningProgress == 0)) then
    summoningProgress= 1;
    rsmComChannel.LockPlayer(summoningPlayer, 5 +1);
    local msg= string.gsub(RSM_SUMMONING, "%%s", summoningPlayer);
    rsmUtil.PrintChatMessage(RSM_HEADER..msg);
    rsmUtil.DisplayMessage(msg, false);
    if (rsmSaved.announce) then
      rsmUtil.PartyOrRaidMessage(string.format(rsmUtil.GetLocalized("ANNOUNCE_PORT"), summoningPlayer));
    end;

  -- channeling has started, notify players to assist and notify target
  elseif ((event == "SPELLCAST_CHANNEL_START") and (summoningProgress == 1)) then
    summoningProgress= 2;
    rsmComChannel.LockPlayer(summoningPlayer, 6*60+1);    
    rsmUtil.SendTell("NOW", summoningPlayer);
    if (rsmSaved.announce) then
      rsmUtil.PartyOrRaidMessage(rsmUtil.GetLocalized("PORT_SUPPORT"));
    end;

  -- casting has ended
  elseif ((event == "SPELLCAST_STOP") and (summoningProgress == 2)) then  
    summoningProgress= 3;

  -- channeling has ended, check if shard was used
  elseif ((event == "SPELLCAST_CHANNEL_STOP") and (summoningProgress == 3)) then
    if (rsmUtil.GetNumShards() < summoningShards) then
      -- unlock target and remove from request queue    
      rsmComChannel.SummonedPlayer(summoningPlayer);
      table.remove(summonQueue, 1);      
      UpdateSummonStats(summoningPlayer);

      -- if currently mass summoning, aquire next target
      if (isMassSummoning == true) then
        alreadySummoned[summoningPlayer]= true;
        QueueAutoSelected();
      end;
      rsmUtil.UpdateInterfaces();

      -- alert player that more summoning requests are queued
      if (table.getn(summonQueue) > 0) then
        local msg= string.gsub(RSM_MORE, "%%s", summonQueue[1]);
        rsmUtil.DisplayMessage(msg, false);
      end;
    else
      -- ritual failed, keep player locked for a few seconds since we're likely going to retry
      rsmComChannel.LockPlayer(summoningPlayer, 15);      
      rsmUtil.PlaySoundFailed();
      rsmUtil.DisplayMessage(RSM_FAILED, true);
      rsmUtil.PrintChatMessage(RSM_HEADER..RSM_FAILED);
      if (rsmSaved.announce) then
        rsmUtil.PartyOrRaidMessage(rsmUtil.GetLocalized("PORT_FAILED"));
      end;
    end;
    summoningProgress= 0;
    summoningPlayer= nil;

  -- aborted during cast
  elseif ((event == "SPELLCAST_FAILED") or (event == "SPELLCAST_INTERRUPTED")) then
    -- ritual aborted by caster, unlock player immediately since we're likely going to remove player from queue for whichever reason
    rsmComChannel.LockPlayer(summoningPlayer, 0);        
    summoningProgress= 0;
    summoningPlayer= nil;
    rsmUtil.PlaySoundFailed();
    if (summoningProgress > 2) then -- default wow will display already display "interrupted"  while still casting
      rsmUtil.DisplayMessage(RSM_FAILED, true);
    end;  
    rsmUtil.PrintChatMessage(RSM_HEADER..RSM_FAILED);
  end;
end;

-- check if message is a summoning request
local function IsSummonRequest(nickname, msg)
  if ((string.len(msg) < MAX_REQUEST_LEN) and (rsmUtil.GetPID(nickname))) then
    local lowMsg= string.lower(msg);
    for index, keyword in rsmSaved.keywords[rsmSaved.interactLang] do
      if (string.find(lowMsg, string.lower(keyword))) then
        return true;
      end;
    end;
  end;
  return false;
end;

-- hook chatframe-events: prevent port request from spamming the chat
local function HookedChatFrameOnEvent(event, ...)
  -- arg1: message
  -- arg2: name

  if (rsmSaved.enabled and RSM_PREFIX) then
    if (rsmSaved.hideReplies and event == "CHAT_MSG_WHISPER_INFORM" and (string.find(arg1, RSM_PREFIX, 1, true) == 1)) then
      return;
    elseif (rsmSaved.hideRequests and event == "CHAT_MSG_WHISPER" and IsSummonRequest(arg2, arg1)) then
      return;
    end;
  end;

  return realChatFrameOnEvent(event, unpack(arg));
end;


-- public support functions
rsm= {
  Private= {

    -- handle game-events
    OnEvent= function(event)
      -- check initialization state, init if neccessary
      if (event == "VARIABLES_LOADED") then
        Initialize();

      -- break here if not yet initialized
      elseif (not isAddonLoaded) then
        return;

      -- handle summon request
      elseif (event == "CHAT_MSG_WHISPER") then
        if (rsmSaved.enabled and rsmSaved.listen and IsSummonRequest(arg2, arg1)) then  -- arg1: message, arg2: nickname
          QueueRequester(arg2);
        end;

      -- detect AFK
      elseif (event == "CHAT_MSG_SYSTEM") then
        UpdatePlayerAFK(arg1);  -- arg1: message

      -- handle addon communication
      elseif (event == "CHAT_MSG_ADDON") then
        rsmComChannel.OnChatMessageAddon(arg1, arg2, arg3, arg4);
        
      -- raid changed, check for new locks
      elseif (event == "RAID_ROSTER_UPDATE" or event == "PARTY_MEMBERS_CHANGED") then
        rsmComChannel.OnRaidRosterUpdate();
      
      -- monitor summoning progress
      elseif (summoningPlayer) then
        ProcessSummoningEvents(event);

      end;
    end;

    -- stuff that needs to be done on update
    OnUpdate= function(elapsed)
      rsmActionButton.OnUpdate(elapsed);
      rsmDropdownMenu.OnUpdate(elapsed);
      rsmComChannel.OnUpdate(elapsed);
      update= update +elapsed;
      if ((update >= 10) and not IsInInstance()) then
        lastKnownX, lastKnownY= rsmUtil.UnitCoords("player");
        update= 0;
      end;
    end;

    -- register events/command on addon load
    OnLoad= function()
      local _, unitClass= UnitClass("player");
      if (unitClass ~= "WARLOCK") then
        return;
      end;
      
      -- need to catch whispers, afk events and spellcast events
      this:RegisterEvent("VARIABLES_LOADED");
      this:RegisterEvent("CHAT_MSG_WHISPER");
      this:RegisterEvent("CHAT_MSG_SYSTEM");
      this:RegisterEvent("CHAT_MSG_ADDON");
      this:RegisterEvent("SPELLCAST_START");
      this:RegisterEvent("SPELLCAST_STOP");
      this:RegisterEvent("SPELLCAST_CHANNEL_START");
      this:RegisterEvent("SPELLCAST_CHANNEL_STOP");
      this:RegisterEvent("SPELLCAST_FAILED");
      this:RegisterEvent("SPELLCAST_INTERRUPTED");
      this:RegisterEvent("RAID_ROSTER_UPDATE");
      this:RegisterEvent("PARTY_MEMBERS_CHANGED");

      -- catch requests/replies before they reach the chatframe
      realChatFrameOnEvent=  ChatFrame_OnEvent;
      ChatFrame_OnEvent=     HookedChatFrameOnEvent;

      -- register mass summoning confirmation dialog
      StaticPopupDialogs["SUMMON_ALL"] = {
        text=      RSM_CONFIRMMASSSUMMON,
        button1=   TEXT(ACCEPT),
        button2=   TEXT(CANCEL),
        OnAccept=  rsm.SummonAll,
        showAlert= 2,
        timeout=   0
      };

      -- call other files OnLoad handler from here
      rsmComChannel.OnLoad();
      rsmCommandLine.OnLoad();
      rsmDropdownMenu.OnLoad();
      rsmActionButton.OnLoad();
      rsmTargetFrame.OnLoad();
    end;  
  };
  
  -- remove player nickname from queue,  returns true if player was removed or false if not found
  DequeuePlayer= function(nickname)
    local i;
    for i=1, table.getn(summonQueue) do
      if (summonQueue[i] == nickname) then
        table.remove(summonQueue, i);
        return true;
      end;
    end;
    return false;
  end;

  -- queue nickname, returns true on success, false if queue full
  QueuePlayer= function(nickname, pos, override)
    if (not override and (table.getn(summonQueue) > MAX_QUEUE_LENGTH)) then
      return false;
    else
      if (pos) then
        table.insert(summonQueue, pos, nickname);
      else
        table.insert(summonQueue, nickname);
      end;
      return true;
    end;
  end;  

  -- check if player already queued
  IsPlayerQueued= function(playerName)
    local i;
    for i= 1, table.getn(summonQueue) do
      if (summonQueue[i] == playerName) then 
        return true;
      end;
    end;
    return false;
  end;

  -- return if in mass summoning mode and autoselecting targets
  IsMassSummoning= function()
    return isMassSummoning;
  end;
  
  -- afk?
  IsPlayerAFK= function()
    return isAFK;
  end;
  
  -- return wether or not there are still available slots on the summoning queue
  IsQueueFull= function()
    return (table.getn(summonQueue) >= MAX_QUEUE_LENGTH);
  end;
  
  -- return wether or not there are still enough shards
  IsLowOnShards= function()
    return (rsmUtil.GetNumShards() -table.getn(summonQueue) < rsmSaved.minShards);
  end;
  
  --  return whether the addon has completed intitialization
  IsAddonLoaded= function()
    return isAddonLoaded;
  end;

  -- return number of players currently queued for summoning
  GetNumPlayerQueued= function()
    return table.getn(summonQueue);
  end;

  -- return name of player queued at position index
  -- p1: numeric index
  GetPlayerQueued= function(index)
    return summonQueue[index];
  end;
  
  -- return current languages keywords
  GetKeywords= function(lang)
    return rsmSaved.keywords[lang];
  end;
  
  -- reset summoning queue or abort mass summoning
  ResetQueue= function()
    if (isMassSummoning) then
      isMassSummoning= false;
      alreadySummoned= { };
      if (table.getn(summonQueue) > 0) then
        table.remove(summonQueue, 1);
      end;
    else
      summonQueue= { };
    end;
    rsmUtil.UpdateInterfaces();
  end; 

  -- remove first queued player from list and notify player
  SkipQueue= function()
    if (table.getn(summonQueue) > 0) then
      local nickname= summonQueue[1];
      table.remove(summonQueue, 1);
      if (isMassSummoning) then
        alreadySummoned[nickname]= true;
        QueueAutoSelected();
      else
        local unitID= rsmUtil.GetPID(nickname);
        if (unitID and UnitIsConnected(unitID)) then
          rsmUtil.SendTell("SKIP", nickname);
        end;
      end;
      rsmUtil.UpdateInterfaces();
      return nickname;
    end;
    return nil;
  end; 
  
  -- semi-intelligent summoning mode autoselection
  -- returns errormessage or nil
  SummonAuto= function(silent)
    local isGrouped= (GetNumRaidMembers() > 0) or (GetNumPartyMembers() > 0);
    local hasTarget= (UnitName("target") ~= nil);

    -- control key down, skip player currently queued first
    if (IsControlKeyDown()) then
      if (not rsm.SkipQueue()) then
        return SummonError(RSM_NOTHING_TO_DO, silent);
      end;
      
    -- not in a group or raidgroup
    elseif (not isGrouped) then
      return SummonError(RSM_GROUP_REQUIRED, silent);

    -- player's target is in raid, summon it
    elseif (hasTarget and (UnitInParty("target") or UnitInRaid("target") or UnitIsUnit("target", "player"))) then
      return rsm.SummonTarget(silent);

    -- players are queued, summon them
    elseif (table.getn(summonQueue) > 0) then
      return rsm.SummonQueued(silent);

    -- no target and nobody queued, try mass summoning
    elseif (not hasTarget) then
      if (IsInInstance()) then
        return SummonError(RSM_NOT_IN_INSTANCE, silent);
      else
        if (StaticPopupDialogs["SUMMON_ALL"]) then
          StaticPopup_Show("SUMMON_ALL");
        else
          rsmUtil.PrintChatMessage("RaidSummon: Internal error: Mass summoning popup not registered.");
        end;
      end;

    -- target not in group
    else
      return SummonError(RSM_NOT_IN_RAID, silent);

    end;
  end;

  -- Summon first player in queue (also hiding targetchange from player)
  SummonQueued= function(silent)
    if (summoningProgress == 0) then
      return Summon(silent);
    end;
  end;
  
  -- Summon everybody not currently in this zone
  SummonAll= function(silent)
    if (summoningProgress == 0) then
      if (IsInInstance()) then
        return SummonError(RSM_NOT_IN_INSTANCE, silent);
      end;

      QueueAutoSelected();
      if (isMassSummoning) then
        return Summon(silent);
      end;
    end;
  end;

  -- queue and summon unit (used by party/raid/player menu)
  SummonUnit= function(unitID, silent)
    if (summoningProgress == 0) then
      if (not (UnitInParty(unitID) or UnitInRaid(unitID) or UnitIsUnit(unitID, "player"))) then
        return SummonError(RSM_NOT_IN_RAID, silent);
      end;
      local nickname, _= UnitName(unitID);
      rsm.DequeuePlayer(nickname);
      rsm.QueuePlayer(nickname, 1, true);      
      return Summon(silent);
    end;
  end;

  -- queue and summon target
  SummonTarget= function(silent)
    rsm.SummonUnit("target", silent);
  end;
  
  -- announce raidsummon
  Announce= function()
    local localKeywords= rsmSaved.keywords[rsmSaved.interactLang];
    if (not localKeywords or (table.getn(localKeywords) < 1)) then
      rsmUtil.PrintChatMessage(RSM_HEADER..RSM_NO_KEYWORDS);
    elseif ((GetNumRaidMembers() == 0) and (GetNumPartyMembers() == 0)) then
      rsmUtil.PrintChatMessage(RSM_HEADER..RSM_GROUP_REQUIRED);
    else   
      local msg1= rsmUtil.GetLocalized("ANNOUNCE1");
      local msg2= rsmUtil.GetLocalized("ANNOUNCE2");
      msg1= string.gsub(msg1, "%%k", rsmSaved.keywords[rsmSaved.interactLang][1]);
      msg2= string.gsub(msg2, "%%k", rsmSaved.keywords[rsmSaved.interactLang][1]);
      rsmUtil.PartyOrRaidMessage(msg1);
      rsmUtil.PartyOrRaidMessage(msg2);
    end;
  end;
  
  -- ++
  Debug= function()
    table.insert(summonQueue, "Lidee");
    table.insert(summonQueue, "Linea");
    table.insert(summonQueue, "Lisbeth");
    table.insert(summonQueue, "Lisanne");
    table.insert(summonQueue, "Lileila");
    rsmUtil.UpdateInterfaces();
  end;  
}