--[[ ********************************************************************* --]]
--[[ MyQuestsComm.lua                                                      --]]
--[[   All variables and functions involved in the communication between   --]]
--[[     players.                                                          --]]
--[[ ********************************************************************* --]]

MYQUESTS_VERSION_PROTOCOL = "03";

MYQUESTS_MSG_PREFIX = "MQ~";
MYQUESTS_MSG_PREFIX_VERSION = MYQUESTS_MSG_PREFIX .. MYQUESTS_VERSION_PROTOCOL .. "~";

MYQUESTS_MAILCHECK_INTERVAL = 1;

--[[ ********************************************************************* --]]
--[[ EVENT DEFINITIONS                                                     --]]
--[[ ********************************************************************* --]]


MYQUESTS_MSG_TURNIN_COMPLETE = 11;

MYQUESTS_MSG_MAPLOCATION = 12;    -- sent to player to locate turn-in player

MYQUESTS_MSG_GOSSIP_REQUEST = 13;     -- request for a complete gossip element

--[[ ********************************************************************* --]]
--[[   PLAYER (P) = User who is running the quests.                        --]]
--[[   TARGET (T) = Target the PLAYER is communicating with.               --]]
--[[ ********************************************************************* --]]
mq.COMM_PING_TARGET = 100;
mq.COMM_PING_REPLY = 101;

mq.COMM_QUERY_TITLES = 102;
mq.COMM_QUERY_TITLESREPLY = 103;

mq.COMM_QUERY_QUEST = 104;
mq.COMM_QUERY_QUESTREPLY = 105;

mq.COMM_TURNIN_P_REQUEST  = 106;
mq.COMM_TURNIN_P_VERIFY   = 107;
mq.COMM_TURNIN_P_DENY     = 108;
mq.COMM_TURNIN_P_COMPLETE = 109;

mq.COMM_TURNIN_T_TURNIN   = 110;
mq.COMM_TURNIN_T_TRADE    = 111;
mq.COMM_TURNIN_T_VERIFY   = 112;
mq.COMM_TURNIN_T_DENY     = 113;
mq.COMM_TURNIN_T_COMPLETE = 114;



mq.ChannelName = "Gibberish";
mq.ChannelCastObject = nil;


--[[ ********************************************************************* --]]
--[[ mq.InitializeCommChannels                                             --]]
--[[ ********************************************************************* --]]
function mq.InitializeCommChannel()
  Gibberish.RegisterCallback(mq.MessageCallback);

--[[
  -- determine if enough time has passed to create our own channel.
  local lastNotificationTime = 0;
  if (mq.lastChannelNotificationTime > 0) then
    lastNotificationTime = time() - mq.lastChannelNotificationTime;
    if (lastNotificationTime <= 5) then
      mq.IO.error("attempting to reconnect the channel");
      return nil;
    end
  end

  -- create the channel object
  if (mq.ChannelCastObject == nil) then
    mq.ChannelCastObject = NewGibberishCast(mq.ChannelName);
    if (mq.ChannelCastObject.IsValid()) then
      mq.ChannelCastObject.SetCallback(mq.MessageCallback);
    else
      mq.IO.error("Unable to join MyQuestsComm channel");
      mq.ChannelCastObject = nil;
      return nil;
    end
  end
  
  return true;
--]]
end

--[[ ********************************************************************* --]]
--[[ mq.MessageCallback                                                    --]]
--[[ ********************************************************************* --]]
function mq.MessageCallback(author, message)
  -- bail out if this is not a MyQuests message
  if (type(message) ~= "table" or not message.isMyQuests) then
    return;
  end

  --[[ *************************************************************** --]]
  --[[ *************************************************************** --]]
  if (message["action"] == mq.COMM_PING_TARGET) then
    if (message["targetUser"] ~= UnitName("player")) then
      return;
    end
    
    mq.IO.dprint("Ping received for me");
    
    message["sender"] = author;
    
    local dataOut = {
      ["action"] = mq.COMM_PING_REPLY,
      ["questCount"] = table.getn(mq.GetValidQuests(message))
    };
    mq.SendMessage(dataOut, author);

  --[[ *************************************************************** --]]
  --[[ *************************************************************** --]]
  elseif (message["action"] == mq.COMM_PING_REPLY) then
    if (UnitName("target") == author) then
      MyQuests_TargetBadge:Show();
      
      if (tonumber(message["questCount"]) == 0) then
        --MQTargetBadge1:Hide();
        --MQTargetBadge2:Show();
        MyQuests_TargetBadgeTexture:SetTexture("Interface\\AddOns\\MyQuests\\Icons\\badge2.tga");
      else
        --MQTargetBadge1:Show();
        --MQTargetBadge2:Hide();
        MyQuests_TargetBadgeTexture:SetTexture("Interface\\AddOns\\MyQuests\\Icons\\badge1.tga");
      end
    end

  --[[ *************************************************************** --]]
  --[[ *************************************************************** --]]
  elseif (message["action"] == mq.COMM_QUERY_TITLES) then
    mq.IO.dprint("[MyQuests Comm] Request for quests received");

    local dataOut = {
      ["action"] = mq.COMM_QUERY_TITLESREPLY,
      ["greetingText"] = myquests.greetingText
    };

    --if (message["questId"]) then
    --  dataOut.availQuests = MQData_GetQuestById(message["questId"], myquests.Quests);
    --else
      --dataOut.availQuests = mq.GetValidQuests(message);
      message["sender"] = author;
      dataOut.availQuestTitles = mq.GetValidQuestTitles(message);
    --end

    mq.IO.dprint("[MyQuests Comm] Sending quest cache");
    mq.SendMessage(dataOut, author);

  --[[ *************************************************************** --]]
  --[[ *************************************************************** --]]
  elseif (message["action"] == mq.COMM_QUERY_TITLESREPLY) then
    mq.IO.dprint("[MyQuests Comm] Quest cache received");

    if (table.getn(message.availQuestTitles) > 0) then
      mq.QuestCache = {};

      --mq.QuestCache.quests = message.availQuests;
      mq.QuestCache.quests = message.availQuestTitles;
      mq.QuestCache.sender = author;
      mq.QuestCache.greetingText = message.greetingText;

      -- **        show the standard WoW quest greeting        ** --
      -- ** see MyQuestsBypass.lua for function bypass details ** --
      HideUIPanel(MyQuestsFrameGreetingPanel);
      ShowUIPanel(QuestFrameGreetingPanel);
    else
      getglobal("MyQuestsGreetingText"):SetText(MQ_QUESTFRAME_NOQUESTS);
    end

  --[[ *************************************************************** --]]
  --[[ *************************************************************** --]]
  elseif (message["action"] == mq.COMM_QUERY_QUEST) then
    local tmpQuest = MQData_GetQuestById(message["mqId"], myquests.Quests)

    mq.IO.dprint("Fetching " .. message["mqId"]);

    -- TODO: if tmpQuest == nil return an error
    
    local dataOut = {
      ["action"] = mq.COMM_QUERY_QUESTREPLY,
      ["questData"] = tmpQuest,
      --["mqId"] = message["mqId"]
    };

    mq.SendMessage(dataOut, author);

  --[[ *************************************************************** --]]
  --[[ *************************************************************** --]]
  elseif (message["action"] == mq.COMM_QUERY_QUESTREPLY) then
    if (mq.QuestCache) then
      -- update the quest information
      local tmpQuest, tmpId = MQData_GetQuestById(mq.QuestCache["QuestQuery"].mqId, mq.QuestCache.quests);
      mq.QuestCache.quests[tmpId] = message["questData"];

      -- hide the wait screen and show the quest data
      HideUIPanel(MyQuestsFrameGreetingPanel);
      --if (mq.QuestCache["QuestQuery"].isActive == 1) then
      --  SelectActiveQuest(mq.QuestCache["QuestQuery"].wowId);
      --else
        SelectAvailableQuest(mq.QuestCache["QuestQuery"].wowId);
      --end
      PlaySound("igQuestListSelect");

      -- clear out the temp quest storage      
      mq.QuestCache["QuestQuery"] = nil;
    end

  --[[ *************************************************************** --]]
  --[[ *************************************************************** --]]
  elseif (message["action"] == mq.COMM_TURNIN_P_REQUEST or
          message["action"] == mq.COMM_TURNIN_P_VERIFY  or
          message["action"] == mq.COMM_TURNIN_P_DENY    or
          message["action"] == mq.COMM_TURNIN_P_COMPLETE) then
  
    --mq.IO.print("I received a message from the QUESTER during the turn in.");
    mq.TurninPlayerActionReceived(message, author);

  --[[ *************************************************************** --]]
  --[[ *************************************************************** --]]
  elseif (message["action"] == mq.COMM_TURNIN_T_TURNIN or
          message["action"] == mq.COMM_TURNIN_T_TRADE  or
          message["action"] == mq.COMM_TURNIN_T_VERIFY or
          message["action"] == mq.COMM_TURNIN_T_COMPLETE) then

    --mq.IO.print("I received a message from the FINISH PLAYER during the turn in.");
    mq.TurninTargetActionReceived(message, author);
  end
end

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
function mq.Sky_AcceptAlert(e)
  if (not myquests.IsEnabled) then
    return;
  end
  
  local alertData = string.split(e, "~");
  
  if (alertData[1] == "MQ") then
    if (alertData[2] ~= MYQUESTS_VERSION_PROTOCOL) then
      -- version check failed
      mq.IO.error("MyQuests Communications Version Error.  Can not continue.");
    else
      local action = tonumber(alertData[3]);
      
      --[[ *************************************************************** --]]
      --[[ MYQUESTS_MSG_GOSSIP_REQUEST                                     --]]
      --[[   Sent by the requesting player to the host of the gossip data  --]]
      --[[   for the data of the specified gossip entry.                   --]]
      --[[                                                                 --]]
      --[[   Returns a list of "icebreakers" if no gossip index is sent    --]]
      --[[   with the request.  If a valid index is sent the data for that --]]
      --[[   gossip is returned.                                           --]]
      --[[ *************************************************************** --]]
      if (action == MYQUESTS_MSG_GOSSIP_REQUEST) then
        mq.IO.dprint("[MyQuests Comm] Gossip Request Received");
        
        local gossipIndex = tonumber(alertData[4]);

        mq.IO.dprint("received gossip request for index " .. gossipIndex);

        local dataOut = {};

        if (gossipIndex) then
          if (myquests.MyGossips[gossipIndex]) then
            dataOut.action = MYQUESTS_MSG_GOSSIP_CACHE;
            dataOut.gossipCache = myquests.MyGossips[gossipIndex];
          else
            -- send an error, no gossip at that index
          end
        else
          dataOut.action = MYQUESTS_MSG_GOSSIP_LIST;
        end

        mq.SendMessage(dataOut, SKY_PLAYER, alertData[5]);
      
      end
      --return true;
    end
  end
  return false;
end

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
function mq.TurninPlayerActionReceived(dataIn, quester)
  -- fetch the quest data
  local completedQuest = MQData_GetQuestById(dataIn["mqId"], myquests.Quests);
  if (completedQuest == nil) then
    -- TODO: send a DENY, "unable to locate quest"
    mq.IO.error("Unable to locate quest.");
  end

  --[[ ******************************************************************* --]]
  --[[ mq.COMM_TURNIN_P_REQUEST                                            --]]
  --[[   Request sent by Player to Target to turn in a quest.              --]]
  --[[ ******************************************************************* --]]
  if (dataIn["action"] == mq.COMM_TURNIN_P_REQUEST) then
    mq.IO.dprint("Received request to turnin quest");
    
    if (not myquests.IsEnabled) then
      --dataOut.action = MYQUESTS_MSG_TURNIN_DENY;
      --dataOut.msgText = "User is not allowing turnins at this time.";
      --mq.SendMessage(dataOut, SKY_PLAYER, envelope.sender);
      --return;
    end

    -- check if this quest turnin is to be stored locally
    if (completedQuest.localStore) then
      if (myquests.PlayerLog[quester]) then
        for i=1, table.getn(myquests.PlayerLog[quester]), 1 do
          -- check if the indexed quest id is equal to the turnin request
          if (myquests.PlayerLog[quester][i] == dataIn["mqId"]) then
            -- TODO: send deny message
            --dataOut.action = MYQUESTS_MSG_TURNIN_DENY;
            --dataOut.msgText = "you already did this";
            --  mq.SendMessage(dataOut, SKY_PLAYER, envelope.sender);
           return;
          end
        end
      end
    end

    if (mq.IsTurninTradeNeeded(completedQuest)) then
      mq.TradeSession = {};
      mq.TradeSession.QuestId = dataIn["mqId"];
      mq.TradeSession.Quest = completedQuest;
      mq.TradeSession.Quester = quester;
    end

    local dataOut = {
      ["action"] = mq.COMM_TURNIN_T_TRADE,
      ["mqId"] = dataIn["mqId"],
    };
    mq.SendMessage(dataOut, quester);

  --[[ ******************************************************************* --]]
  --[[ ******************************************************************* --]]
  elseif (dataIn["action"] == mq.COMM_TURNIN_P_VERIFY) then
    local bAcceptTrade = true;
    
    if (GetTargetTradeMoney() ~= mq.TradeSession.Quest.objectiveMoney) then
      bAcceptTrade = nil;
    end
    
    if (bAcceptTrade) then
      AcceptTrade();
    else
      -- error: verify failed
      mq.IO.error("MONEY DOES NOT MATCH!");
    end
  
  --[[ ******************************************************************* --]]
  --[[ mq.COMM_TURNIN_P_COMPLETE                                           --]]
  --[[ ******************************************************************* --]]
  elseif (dataIn["action"] == mq.COMM_TURNIN_P_COMPLETE) then
    mq.IO.dprint("Received request to finalize quest");
    
    if (completedQuest.rewards ~= nil) then
      for i=1, table.getn(completedQuest.rewards), 1 do
        local rewardType = completedQuest.rewards[i].type;
        if (rewardType == "GuildPromotion") then
          mq.IO.dprint("Promoting " .. quester);
          GuildPromoteByName(quester);
        elseif (rewardType == "GuildInvite") then
          mq.IO.dprint("Inviting " .. quester);
          GuildInviteByName(quester);
        end
      end
    end

    if (completedQuest.localStore) then
      local bAddQuest = true;
      if (myquests.PlayerLog[quester]) then
        for i=1, table.getn(myquests.PlayerLog[quester]), 1 do
          if (myquests.PlayerLog[quester][i] == dataIn["mqId"]) then
            bAddQuest = nil;
          end
        end
      end
      if (bAddQuest) then
        table.insert(myquests.PlayerLog[quester], dataIn["mqId"]);
      end
    end

    mq.IO.print(quester .. " has completed " .. completedQuest.title);

    local dataOut = {
      ["action"] = mq.COMM_TURNIN_T_COMPLETE,
      ["mqId"] = dataIn["mqId"]
    };
    mq.SendMessage(dataOut, quester);
  end
end

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
function mq.TurninTargetActionReceived(dataIn, finishPlayer)
  --local isMQ, version, action, questId, sender = unpack(alertData);
  --mq.IO.dprint(isMQ .. " " .. version .. " " .. action .. " " .. questId .. " " .. sender);


  local completedQuest = MQData_GetQuestById(dataIn["mqId"], myquests.QuestLog);
  if (completedQuest == nil) then
    -- TODO: send an error back to turnin player to abort turnin
    mq.IO.error("Unable to locate quest in Quest Log");
  end

  --[[ ******************************************************************* --]]
  --[[ ******************************************************************* --]]
  if (dataIn["action"] == mq.COMM_TURNIN_T_TRADE) then
    mq.IO.dprint("Received permission to begin quest turnin");
    
    -- check if we need to open the trade
    -- if yes, save variables and start process
    
    if (mq.IsTurninTradeNeeded(completedQuest)) then
      mq.IO.dprint("starting a trade session");
      
      -- TODO: verify we got this from the person we sent it to

      mq.TradeSession = {};
      mq.TradeSession.QuestId = dataIn["mqId"];
      mq.TradeSession.Quest = completedQuest;
      mq.TradeSession.Finisher = finishPlayer;

      TargetByName(finishPlayer);
      InitiateTrade("target");
    else
      local dataOut = {
        ["action"] = mq.COMM_TURNIN_P_COMPLETE,
        ["mqId"] = dataIn["mqId"]
      };
      mq.SendMessage(dataOut, finishPlayer);
    end
    
  --[[ ******************************************************************* --]]
  --[[ ******************************************************************* --]]
  elseif (dataIn["action"] == mq.COMM_TURNIN_T_VERIFY) then
    local bAcceptTrade = true;
    
    if (GetTargetTradeMoney() ~= mq.TradeSession.Quest.rewardMoney) then
      bAcceptTrade = nil;
    end
    
    if (bAcceptTrade) then
      AcceptTrade();

      local dataOut = {
        ["action"] = mq.COMM_TURNIN_P_COMPLETE,
        ["mqId"] = dataIn["mqId"]
      };
      mq.SendMessage(dataOut, finishPlayer);
    else
      -- error: verify failed
      mq.IO.error("MONEY DOES NOT MATCH!");
    end
  
  --[[ ******************************************************************* --]]
  --[[ ******************************************************************* --]]
  elseif (dataIn["action"] == mq.COMM_TURNIN_T_COMPLETE) then
    -- inform the PLAYER we've completed the quest
    mq.IO.print("Quest completed: " .. completedQuest.title);

    -- remove the quest from the log
    for i=1, table.getn(myquests.QuestLog), 1 do
      if (completedQuest.finishPlayers[1] == myquests.QuestLog[i].finishPlayers[1]) then
        if (completedQuest.title == myquests.QuestLog[i].title) then
          table.remove(myquests.QuestLog, i);
          break;
        end
      end
    end

    -- add the quest id to the quest history
    local bAddQuest = true;
    for i=1, table.getn(myquests.QuestHistory), 1 do
      if (myquests.QuestHistory[i] == dataIn["mqId"]) then
        bAddQuest = nil;
      end
    end
    if (bAddQuest) then
      table.insert(myquests.QuestHistory, dataIn["mqId"]);
    end

    -- remove the quest watch status and update the quest log
    RemoveQuestWatch(dataIn["mqId"]);

    -- hide the window
    QuestFrame:Hide();

    -- hide the map note
    -- TODO: figure out which note to hide
    MyQuests_MapNote1:Hide();
  end
end

--[[ ********************************************************************* --]]
--[[ mq.IsTurninTradeNeeded                                                --]]
--[[   Performs some simple checks to test if a trade session is needed    --]]
--[[   for turning in the current quest.                                   --]]
--[[                                                                       --]]
--[[   Returns 1 if trade is needed, nil otherwise.                        --]]
--[[ ********************************************************************* --]]
function mq.IsTurninTradeNeeded(quest)
  -- count up the number of trade objectives
  local goalCount = 0;
  for i=1, table.getn(quest.objectives), 1 do
    if (quest.objectives[i].type == "GatherItem" and not quest.objectives[i].noTrade) then
      goalCount = goalCount + 1;
    end
  end

  -- count up the number of trade rewards
  local rewardCount = 0;
  for i=1, table.getn(quest.rewards), 1 do
    if (quest.rewards[i].type ~= "GuildPromotion" and quest.rewards[i].type ~= "GuildInvite") then
      rewardCount = rewardCount + 1;
    end
  end

  if (rewardCount > 0 or goalCount > 0 or quest.objectiveMoney > 0 or quest.rewardMoney > 0) then
    return 1;
  end
  
  return nil;
end

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
function mq.ParseMailbox()
  local mail = Sky.getAllMessages("MyQuests");
  local dataOut = {}
  
  mq.IO.print("Parsing Inbox!  " .. table.getn(mail) .. " messages.");
  
  for k, envelope in mail do
    local msgTable = envelope.msg;

      mq.IO.dprint("[MyQuests Comm] Permission for turnin denied");
      -- not accepting turn ins

    --[[ ******************************************************************* --]]
    --[[ MYQUESTS_MSG_MAPLOCATION                                            --]]
    --[[   Sent to quester for locating the finishPlayer.                    --]]
    --[[ ******************************************************************* --]]
    if (msgTable.action == MYQUESTS_MSG_MAPLOCATION) then
      mq.IO.dprint("starting location calculations");
      
      -- check location
      if (GetZoneText() == msgTable.zone or GetSubZoneText() == msgTable.subZone) then
          -- do calculations
          local myX, myY = GetPlayerMapPosition("player");
          myX = myX / 10000;
          myY = myY / 10000;
    
          local targetX, targetY = msgTable.posX / 10000, msgTable.posY / 10000;

          -- calculate the scale
          --local scaleX = mq.MapConstants[continent][Minimap:GetZoom()].xscale;
          --local scaleY = mq.MapConstants[continent][Minimap:GetZoom()].yscale;

          -- check if we are in a city?

          local deltaX = targetX - myX;
          local deltaY = targetY - myY;
          
          local distanceFromCenter = sqrt((deltaX * deltaX) + (deltaY * deltaY));

          -- check distance
        if (distanceFromCenter < 56.5) then
            -- place the map note (TODO: update the location values)      
            MyQuests_MapNote1:SetPoint("CENTER", "MinimapCluster", "TOPLEFT", 107+deltaX, -97+deltaY);
            -- show the map note
            MyQuests_MapNote1:Show();
        end
      end
    --[[ ***************************************************************** --]]
    --[[ MYQUESTS_MSG_GOSSIP_LIST                                          --]]
    --[[   Listing of gossips with an "icebreaker".  These gossips do not  --]]
    --[[   require a quest as an entry point.                              --]]
    --[[ ***************************************************************** --]]
    elseif (msgTable.action == MYQUESTS_MSG_GOSSIP_LIST) then
      mq.GossipSession = envelope.msg.gossipCache;
      ShowUIPanel(GossipFrame);
      GossipFrameUpdate();

    --[[ ***************************************************************** --]]
    --[[ MYQUESTS_MSG_GOSSIP_CACHE                                         --]]
    --[[   A single gossip entry sent to the requester, holding all the    --]]
    --[[   gossip data.                                                    --]]
    --[[ ***************************************************************** --]]
    elseif (msgTable.action == MYQUESTS_MSG_GOSSIP_CACHE) then
      mq.GossipSession = envelope.msg.gossipCache;
      ShowUIPanel(GossipFrame);
      GossipFrameUpdate();

    --[[ ***************************************************************** --]]
    --[[ ***************************************************************** --]]
    else
      -- unknown message type
      mq.IO.dprint("[MyQuests_OnMessage] Unknown Message: cmd=" .. NoNil(msgTable.action));
    end


  end
end

function mq.SendMessage(dataOut, player)
  dataOut.isMyQuests  = true;
  dataOut.commVersion = MYQUESTS_VERSION_PROTOCOL;

  --mq.ChannelCastObject.Interact(player, dataOut);
  Gibberish.Interact(dataOut, player);
end

--[[ ********************************************************************* --]]
--[[ RequestAvailableQuests                                                --]]
--[[   Sends a request to the player for a list of current quests.         --]]
function mq.RequestAvailableQuests()
  if(UnitName("target") ~= nil) then
    local dataOut = {};
    dataOut.action        = mq.COMM_QUERY_TITLES;
    dataOut.playerClass   = UnitClass("player");
    dataOut.playerRace    = UnitRace("player");
    dataOut.playerLevel   = UnitLevel("player");
    dataOut.playerGuild   = GetGuildInfo("player");
    dataOut.playerHistory = myquests.QuestHistory;
    
    mq.SendMessage(dataOut, UnitName("target"));

    getglobal("MyQuestsGreetingText"):SetText(MQ_QUESTFRAME_TRANSCRIBING);
    
    HideUIPanel(QuestFrameGreetingPanel);
    ShowUIPanel(QuestFrame);
    --TargetByName(envelope.sender);
    SetPortraitTexture(QuestFramePortrait, "target");
    getglobal("QuestFrameNpcNameText"):SetText(UnitName("target"));
    ShowUIPanel(MyQuestsFrameGreetingPanel);
  end
end

--[[ ********************************************************************* --]]
--[[ GetValidQuests                                                        --]]
--[[   Returns a list of quests the requesting player is able to accept.   --]]
--[[ ********************************************************************* --]]
function mq.GetValidQuests(userInfo)
  local validQuests = {};
  
  for i=1, table.getn(myquests.Quests), 1 do
    local tmpQuest = myquests.Quests[i];
    local validQuest = 1;

    -- check if this quest is part of a chain, and if the parent quest has
    --   been completed.
    if (tmpQuest.parent ~= "none") then
      validQuest = nil;
      for j=1, table.getn(userInfo.playerHistory), 1 do
        if (tmpQuest.parent == userInfo.playerHistory[j]) then
          validQuest = 1;
          break;
        end
      end
    end

    -- check if this quest is repeatable and if it has been done already
    if (not tmpQuest.isRepeatable) then
      for j=1, table.getn(userInfo.playerHistory), 1 do
        if (tmpQuest.id == userInfo.playerHistory[j]) then
          validQuest = nil;
          break;
        end
      end

      --for j=1, table.getn(myquests.PlayerLog[userInfo.name]), 1 do
      --  if (tmpQuest.id == myquests.PlayerLog[userInfo.name][j]) then
      --    validQuest = nil;
      --    break;
      --  end
      --end
    end

    -- check quest filters for class, race, level, guild and player
    if (tmpQuest.filterClass and tmpQuest.filterClass ~= userInfo.playerClass) then
      validQuest = nil;
    end
    if (tmpQuest.filterRace and tmpQuest.filterRace ~= userInfo.playerRace) then
      validQuest = nil;
    end
    if (tmpQuest.filterLevelMin and tmpQuest.filterLevelMin > userInfo.playerLevel) then
      validQuest = nil;
    end
    if (tmpQuest.filterLevelMax and tmpQuest.filterLevelMax < userInfo.playerLevel) then
      validQuest = nil;
    end
    if (tmpQuest.filterGuild and tmpQuest.filterGuild ~= userInfo.playerGuild) then
      validQuest = nil;
    end
    if (tmpQuest.filterPlayer and tmpQuest.filterPlayer ~= userInfo.sender) then
      validQuest = nil;
    end

    -- add the quest if it is valid
    if (validQuest) then
      table.insert(validQuests, myquests.Quests[i]);
    end
  end

  return validQuests;
end

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
function mq.GetValidQuestTitles(userInfo)
  local validQuests = mq.GetValidQuests(userInfo);
  local validQuestTitles = {};
  
  for i=1, table.getn(validQuests), 1 do
    validQuestTitles[i] = {};
    validQuestTitles[i].id = validQuests[i].id;
    validQuestTitles[i].title = validQuests[i].title;
    mq.IO.dprint(validQuestTitles[i].title);
  end
  
  return validQuestTitles;
end

function mq.TranslateCarriageReturn(content, tonl)
  if (content ~= nil) then
    if tonl then
      content = string.gsub(content, mq.PROTOCOL_NL, '\n')
    else
      content = string.gsub(content, '\n', mq.PROTOCOL_NL)
    end
  end
  
  return content;
end
