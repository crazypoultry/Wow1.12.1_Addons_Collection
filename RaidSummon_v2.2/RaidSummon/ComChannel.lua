-- experimental communication code
-- had to be included in release version but should be inactive

-- constants
local RSM_CHANNEL_PREFIX= "RSM";
local RSM_FLOOD_INTERVAL= 0.5;
local RSM_COM_VERSION=    10000;

-- internal status
local lastReply=       0;
local knownClients=    { };   -- known raidsummon clients. fields: shards, summoned
local otherWarlocks=   { };   -- other warlocks in the raid. value: no of summoned players
local update=          0;     -- on update interval timer
local selectedPlayers= { };   -- players currently selected for summoning
local lastNumGroup=    0;     -- used to verify if raidmember count changed during roster update
local requestID=       0;     -- increased with every request
local requests=        { };   -- request cache
local playerName=      nil;   -- own name

-- lowlevel commands
-- REQ id target msg  -- request reply
-- REP id target msg  -- reply to request

-- test if can summon (multirecipient enabled)
-- request: CSP target
-- reply: OK, UU (unknown unit), AFK, QF (queue full), LOS (low on shards), DI (different instance)
 
-- summon
-- request: SMN target
-- reply: OK or NO

-- request identifcation(multirecipient enabled)
-- request: IRQ
-- reply: IDT version

-- sends a command to the addon channel
local function SendCom(command, byRequest)
  -- if this message is sent in reply to a request, check self for flooding
  if (byRequest) then
    if (GetTime() -lastReply < RSM_FLOOD_INTERVAL) then
      return;
    else
      lastReply= GetTime();
    end;
  end;
  SendAddonMessage(RSM_CHANNEL_PREFIX, command, "RAID");
end;

-- express boolean value as + for true and - for false
local function BtS(boolean)
  if (boolean) then
    return "+";
  else
    return "-";
  end;
end;

-- convert string back to boolean
local function StB(str)
  if (str and str == "+") then
    return true;
  else
    return false;
  end;
end;

-- request reply
-- target can be ALL_WARLOCKS, ALL_CLIENTS or a specific playername (obviously ALL_WARLOCKS can only be used to detect other clients)
local function SendComRequest(msg, timeout, target)
  requestID= requestID +1;

  -- store request
  local request= { };
  request.message=  msg;                -- original message
  request.replies=  { };                -- clients replies
  request.expected= { };                -- names of clients from which a reply is expected
  request.timeout=  GetTime() +timeout; -- time until request times out
  if (not target or target == "ALL_WARLOCKS") then
    target= "-";
    for name, _ in otherWarlocks do
      request.expected[name]= 1;
    end;    
  elseif (target == "ALL_CLIENTS") then
    target= "-";
    for name, _ in knownClients do
      request.expected[name]= 1;
    end;
  else
    request.expected[target]= 1;
  end;
  requests["r"..requestID]= request;
  
  -- send it
  SendCom("REQ "..requestID.." "..target.." "..msg);
end;

-- send reply
local function SendComReply(msg, target, id)
  if (not target) then
    target= "-";
  end;
  SendCom("REP "..id.." "..target.." "..msg, true);
end;

-- process incoming request message
local function ProcessRequest(msgTab, sender)
  local id= msgTab[2];
  if (id) then
    id= tonumber(id);
  end;
  local target= msgTab[3];
  if (target == "-") then
    target= nil;
  end;
  
  -- ident request, reply with version
  if (msgTab[4] == "IRQ") then
    SendComReply("IDT "..RSM_COM_VERSION, sender, id);
  
  -- queue for summoning
  elseif (msgTab[4] == "SMN" and target == playerName) then
    local nickname= msgTab[5];
    if (rsm.QueuePlayer(nickname, nil, false)) then
      SendComReply("OK", sender, id);
      local msg= string.gsub(RSM_REQUEST, "%%s", nickname);
      rsmUtil.DisplayMessage(msg, false);
      rsmUtil.PrintChatMessage(RSM_HEADER..msg);
      rsmUtil.UpdateInterfaces();
    else
      SendComReply("NO", sender, id);
    end;
    
  -- test if summoning possible at the moment
  elseif (msgTab[4] == "CSP" and (target == playerName or target == "-")) then
    local unitID= GetPID(msgTab[5]);
    local reply= "OK";
    if (not unitID) then
      reply= "UU";
    elseif (rsm.IsAFK()) then
      reply= "AFK";
    elseif (rsm.IsQueueFull()) then
      reply= "QF";
    elseif (rsm.IsLowOnShards()) then
      reply= "LOS";
    elseif ((not IsInInstance()) ~= (not rsmUtil.IsUnitInInstance(unitID))) then
      reply= "DI";
    end;
    SendComReply(reply, sender, id);
  end;
end;

-- process individual incoming replies
local function ProcessReply(msgTab, sender)
  if (msgTab[2]) then
    id= tonumber(msgTab[2]);
    if (id and requests["r"..id]) then
      local target= msgTab[3];
      if (target == playerName) then
        local reply= { };
        for i= 4, table.getn(msgTab) do
          reply[i -3]= msgTab[i];
        end;
        requests["r"..id].replies[sender]= reply;
      end;
    end;
  end;
end;

-- 

-- update list of known RSM clients and warlocks without RSM
local function UpdateSummoner()
  local snapshot= rsmUtil.GetRaidSnapshot();

  -- remove clients that are no longer in the raid
  for name, _ in knownClients do
    if (not snapshot[name]) then
      knownClients[name]= nil;
    end;
  end;
  for name, _ in otherWarlocks do
    if (not snapshot[name]) then
      otherWarlocks[name]= nil;
    end;
  end;

  -- add warlocks to list of non-raidsummon clients
  for name, unit in snapshot do
    if (unit.class == "WARLOCK" and not (knownClients[name] or otherWarlocks[name])) then
      otherWarlocks[name]= 0;
    end;
  end;
end;

-- add client to list or update if already known
local function AddClient(name, shards, hasSlots, isPresent)
  if (not knownClients[name]) then
    knownClients[name]= { summoned= 0 };
  end;
  knownClients[name].shards=        shards;
  knownClients[name].hasSlots=      hasSlots;
  knownClients[name].isPresent=     isPresent;
end;

-- public interface
rsmComChannel= {
  -- called by rsm.Private.OnLoad()
  OnLoad= function()
    playerName, _= UnitName("player");
  end;
  
  -- fixme: comchannel functionality disabled until finished
  OnUpdate= function(elapsed)
  end;
  OnChatMessageAddon= function(prefix, msg, chan, sender)
  end;
  OnRaidRosterUpdate= function()
  end;
  LockPlayer= function(nickname, locktime)
  end;
  SummonedPlayer= function(nickname)
  end;  
  
--[[
  -- send own status every few seconds
 OnUpdate= function(elapsed)
    update= update +elapsed;
    if (update > 10) then
      update= -60;     -- should this take longer for whatever reason, don't spam it

      --
      
      -- purge timed out but selected players
      local now= GetTime();
      for name, data in selectedPlayers do
        if (data.timeOut and data.timeOut > now) then
          selectedPlayers[name]= nil;
        end;
      end;
      
      update= 0;
    end;
  end;
 
  -- process addon messages
  OnChatMessageAddon= function(prefix, msg, chan, sender)
    if (prefix ~= RSM_CHANNEL_PREFIX) then
      return;
    end;

    ChatFrame3:AddMessage("RSM: "..msg);

    -- split message into substrings
    local msgTab= rsmUtil.SplitString(msg, " ");

    -- ident received, add client if not known
    if (msgTab[1] == "IDT") then
      if (msgTab[2]) then
        local count= tonumber(msgTab[2]);
        local hasSlots= StB(msgTab[3]);
        local isPresent= StB(msgTab[4]);
        if (count ~= nil) then
          AddClient(sender, count, hasSlots, isPresent);
        end;
      end;
      UpdateSummoner();
    
    -- standard multipurpose request
    elseif(msgTab[1] == "REQ") then
      ProcessRequest(msgTab, sender);    

    -- a player is about to be summoned, if queued with us, move to end, also mark as selected to prevent mass summoning from locking onto that player
    elseif (msgTab[1] == "SEL" and (sender ~= playerName)) then
      local nickname= msgTab[2];
      local locktime= msgTab[3];
      if (locktime) then
        locktime= tonumber(locktime);
      end;
      if (nickname and locktime) then
        selectedPlayers[nickname]= { owner= sender, timeout= GetTime() +locktime };
        if (rsm.IsPlayerQueued(nickname)) then
          DequeuePlayer(nickname);
          QueuePlayer(nickname);
          rsmUtil.UpdateInterfaces();
          local msg= string.gsub(RSM_ALMOST_SUMMONED, "%%s", nickname);
          --rsmUtil.DisplayMessage(msg, true);
          rsmUtil.PrintChatMessage(RSM_HEADER..msg);
        end;
      end;

    -- player summoned: remove from queue; give him a fresh timeout since he has 2 minutes to accept summon
    elseif (msgTab[1] == "SUM" and (sender ~= playerName)) then
      local nickname= msgTab[2];
      if (nickname) then
        selectedPlayers[nickname]= { owner= sender, timeout= GetTime() +125 };
        if (rsm.IsPlayerQueued(nickname)) then
          DequeuePlayer(nickname);
          rsmUtil.UpdateInterfaces();          
          local msg= string.gsub(RSM_ALREADY_SUMMONED, "%%s", nickname);
          rsmUtil.DisplayMessage(msg, true);
          rsmUtil.PrintChatMessage(RSM_HEADER..msg);
        end;
      end;
    
    -- summon a player by request of another warlock
    elseif (msgTab[1] == "RQS" and (sender ~= playerName) and (msgTab[2] == playerName)) then

      
    end;

  end;
 
  -- called when raidmembers change, scan for new warlocks
  OnRaidRosterUpdate= function()
    local numRaid= GetNumRaidMembers();
    local numParty= GetNumPartyMembers()
    if (numRaid > 0 and lastNumGroup == numRaid) then
      lastNumGroup= numRaid;
      return;
    elseif (numParty > 0 and lastNumGroup == numParty) then
      lastNumGroup= numParty;
      return;
    end;
    SendComIdent();
    UpdateSummoner();
  end;

  -- state that this client is about to summon player nickname
  LockPlayer= function(nickname, locktime)
    if (not selectedPlayers[nickname]) then
      selectedPlayers[nickname]= { owner= playerName, timeout= GetTime() +locktime };    
      SendCom("SELECTING "..nickname.." "..locktime, false);
      return true;
    else
      return false;
    end;
  end;

  -- declare that you have summoned player nickname
  SummonedPlayer= function(nickname)
    selectedPlayers[nickname]= { owner= playerName, timeout= GetTime() +125 };     
    SendCom("SUMMONED "..nickname, false);
  end;
]]--
  -- return whether or not a player is currently selected and shouldn't be summoned
  IsLockedPlayer= function(nickname)
    return (selectedPlayers[nickname] ~= nil);
  end;

  -- query status of another raidsummon using warlock  
  IsRaidSummonUser= function(warlock)
    return (knownClients[warlock] ~= nil);
  end;
  HasAssistants= function(warlock)
    return (knownClients[warlock] and knownClients[warlock].hasAssistants);
  end;
  HasShards= function(warlock)
    return (knownClients[warlock] and (knownClients[warlock].shards > 0));
  end;
  HasSlots= function(warlock)
    return (knownClients[warlock] and knownClients[warlock].hasSlots);
  end;
  IsPresent= function(warlock)
    return (knownClients[warlock] and knownClients[warlock].isPresent);
  end;
    
  -- request summon of another player
  RequestSummon= function(warlock, nickname)
    SendCom("REQUEST "..warlock.." "..nickname);
  end;
}

