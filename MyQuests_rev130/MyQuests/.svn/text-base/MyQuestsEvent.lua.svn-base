mq.Event = {};

mq.Event.BagUpdated = nil;

-- used for tracking kills
local prevCreep = nil;

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
function mq.Event.BagUpdate()
  if (arg1 >= 0 and arg1 <= 4) then
    mq.Event.BagUpdated = 1;
  end
end

--[[ ********************************************************************* --]]
--[[ mq.Event.ChatMsgChannelNotice                                         --]]
--[[   Called on chat channel notices (join, leave, changed).  Used to     --]]
--[[   determine when we create our own channel.                           --]]
--[[ ********************************************************************* --]]
mq.lastChannelNotificationTime = 0;
function mq.Event.ChatMsgChannelNotice()
  mq.lastChannelNotificationTime = time();
end

--[[ ********************************************************************* --]]
--[[ mq.Event.PlayerTargetChanged                                          --]]
--[[   Called when the user targets a new player or NPC.                   --]]
--[[ ********************************************************************* --]]
function mq.Event.PlayerTargetChanged()
  --MQTargetBadge1:Hide();
  --MQTargetBadge2:Hide();
  MyQuests_TargetBadge:Hide();

  -- bail out if the target is not in the same faction
  if (UnitFactionGroup("target") ~= UnitFactionGroup("player")) then
    return;
  end

  local targetName = UnitName("target");
  if(targetName == nil) then
    return;
  end
  if (targetName == "Unknown Entity") then
    mq.ScheduleForCall(mq.Event.PlayerTargetChanged, {}, 1, 1);
    return;
  end

  local dataOut = {
    ["action"]        = mq.COMM_PING_TARGET,
    ["targetUser"]    = UnitName("target"),
    ["playerClass"]   = UnitClass("player"),
    ["playerRace"]    = UnitRace("player"),
    ["playerLevel"]   = UnitLevel("player"),
    ["playerGuild"]   = GetGuildInfo("player"),
    ["playerHistory"] = myquests.QuestHistory
  };
  --mq.SendMessage(dataOut, targetName);
  mq.SendMessage(dataOut);

  -- fetch information about the new target  
  mq.TargetInfo.name = UnitName("target");
  mq.TargetInfo.class = UnitName("target");
  mq.TargetInfo.race = UnitName("target");
  mq.TargetInfo.level = UnitName("target");
  mq.TargetInfo.guild = GetGuildInfo("target");
end

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
function mq.Event.ZoneChanged()
  for i=1, table.getn(myquests.QuestLog), 1 do
    local tmpQuest = myquests.QuestLog[i];
    for j=1, table.getn(tmpQuest.objectives), 1 do
      local tmpGoal = tmpQuest.objectives[j];
      if (tmpGoal.type == "Explore") then
        mq.QuestObjectives["Explore"].OnUpdate(tmpGoal);
      end
    end
    mq.CheckQuestComplete(tmpQuest);
  end
end


--[[ ********************************************************************* --]]
--[[ mq.Event.TradeShow                                                    --]]
--[[   Called when the trade window is shown.                              --]]
--[[ ********************************************************************* --]]
function mq.Event.TradeShow()
  if (mq.TradeSession ~= nil) then
    local count = 1;

    local dataOut = {};
    dataOut.questId = mq.TradeSession["QuestId"];
    
    -- if Quester set, we are the finish player
    if (mq.TradeSession["Quester"]) then 
      if (mq.TradeSession["Quest"].rewardMoney) then
        mq.ScheduleForCall(mq.QuestRewards["Money"].OnTurnIn, {mq.TradeSession["Quest"].rewardMoney}, count, 1);
        count = count + 1;
      end

      for i=1, table.getn(mq.TradeSession["Quest"].rewards), 1 do
        if (mq.TradeSession["Quest"].rewards[i] ~= nil) then
          local tmpReward = mq.TradeSession["Quest"].rewards[i];
          if (tmpReward.type == "ItemReward") then
            mq.QuestRewards.ItemReward.OnTurnIn(tmpReward);
          end
        end
      end

      --local dataString = mq.COMM_TURNIN_T_VERIFY .. "~" .. questId .. "~" .. UnitName("player");
      --mq.ScheduleForCall(mq.SendAlert, {dataString, SKY_PLAYER, mq.TradeSession["Quester"]}, count, 1);

      --mq.ScheduleForCall(mq.SendMessage, {dataOut, SKY_PLAYER, mq.TradeSession["Quester"]}, count, 1);
    end

    -- if Finisher set, we are the quester
    if (mq.TradeSession["Finisher"]) then 
      if (mq.TradeSession["Quest"].objectiveMoney) then
        mq.ScheduleForCall(mq.QuestObjectives["Money"].OnTurnIn, {mq.TradeSession["Quest"].objectiveMoney}, count, 1);
        count = count + 1;
      end

      for i=1, table.getn(mq.TradeSession["Quest"].objectives), 1 do
        if (mq.TradeSession["Quest"].objectives[i] ~= nil) then
          local tmpObjective = mq.TradeSession["Quest"].objectives[i];
          if (tmpObjective.type == "GatherItem" and not tmpObjective.noTrade) then
            mq.QuestObjectives.GatherItem.OnTurnIn(tmpObjective);
          end
        end
      end

      --local dataString = mq.COMM_TURNIN_P_VERIFY .. "~" .. questId .. "~" .. UnitName("player");
      --mq.ScheduleForCall(mq.SendAlert, {dataString, SKY_PLAYER, mq.TradeSession["Quester"]}, count, 1);
      
      --mq.ScheduleForCall(mq.SendMessage, {dataOut, SKY_PLAYER, mq.TradeSession["Finisher"]}, count, 1);
     
    end
  end
end

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
function mq.SearchBagForItem(itemLink)
  for bagIndex=0, 4, 1 do
    for itemIndex=0, 16, 1 do
      local tmpLink = GetContainerItemLink(bagIndex, itemIndex);
      if (tmpLink ~= nil) then
        tmpLink = string.gsub(tmpLink, "|cff(.*)|H(.*)|h(.*)|h|r.*", "%2");
        if (tmpLink == itemLink) then
          -- FOUND THE ITEM!
        end
      end
    end
  end
end

--[[ ********************************************************************* --]]
--[[ mq.Event.TradeClosed                                                  --]]
--[[   Called when the trade window is closed.                             --]]
--[[ ********************************************************************* --]]
function mq.Event.TradeClosed()
  -- mq.TradeSession["Quest"]

  if (mq.TradeSession) then
    if (mq.TradeSession["PlayerAccept"] == 1) then
      -- complete the quest now

      -- if Finisher set, we are the quester
      if (mq.TradeSession["Finisher"]) then 
        mq.IO.dprint("I am the quester - sending finish!");
        local dataOut = {
          ["action"] = mq.COMM_TURNIN_P_COMPLETE,
          ["mqId"] = mq.TradeSession["QuestId"],
        };
        mq.SendMessage(dataOut, mq.TradeSession["Finisher"]);
      end      
    end
  end
  
  mq.TradeSession = nil;
end

function mq.Event.TradeAcceptUpdate(arg1, arg2)
  if (mq.TradeSession) then
    mq.TradeSession["PlayerAccept"] = arg2[1];
    mq.TradeSession["TargetAccept"] = arg2[2];
  end
end

function mq.Event.TradeRequestCancel()
  -- if Target accepts and Player rejects the below does not pass, I do not think this matters.
  
  if (mq.TradeSession) then
    -- we should not fail the quest here, but not complete it
  end
  
  mq.TradeSession = nil;
end

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
function mq.Event.ChatMsgCombatHostileDeath()
  -- make sure we clear out the prevCreep
  prevCreep = nil;

  local s, e, creep = string.find(arg1, MQ_REGEX_HOSTILE_DEATH);
  if (creep) then
    prevCreep = creep;
  end

  local killby = nil;
  if (not creep) then
    s, e, creep, killby = string.find(arg1, MQ_REGEX_HOSTILE_SLAIN);
    if (killby) then
      prevCreep = creep;
    end
  end

  local bCreditKill = nil;

  if (UnitIsTapped("target")) then
    if (UnitIsTappedByPlayer("target")) then
      if((UnitHealth("target") <= 0) and (UnitName("target") == creep)) then
        prevCreep = creep;
        bCreditKill = 1;    
      end
    end
  elseif (killby) then
    if (UnitInRaid("player")) then
      for i=1, GetNumRaidMembers(), 1 do
        if (UnitName("raid"..i) == killby) then
          prevCreep = creep;
          bCreditKill = 1;    
        end
      end
    else 
      for i=1, GetNumPartyMembers(), 1 do
        if (UnitName("party"..i) == killby) then
          prevCreep = creep;
          bCreditKill = 1;    
        end
      end
    end
  end

  if (bCreditKill) then
    --[[ step through the quests and update kill counts --]]
    for i=1, table.getn(myquests.QuestLog), 1 do
      local tmpQuest = myquests.QuestLog[i];
      for j=1, table.getn(myquests.QuestLog[i].objectives), 1 do
        local tmpGoal = myquests.QuestLog[i].objectives[j];
        if (tmpGoal.type == "KillMonster") then
          if (string.lower(tmpGoal.name) == string.lower(creep)) then
            mq.QuestObjectives["KillMonster"].OnUpdate(tmpGoal);
          end
        end
      end
      mq.CheckQuestComplete(tmpQuest);
    end
  end
end

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
function mq.Event.ChatMsgCombatXpGain()
  --local s, e, creep = string.find(arg1, "(.+) dies");
  local s, e, creep, xp = string.find(arg1, "(.+) dies, you gain (.+) experience");

  if (prevCreep ~= nil and prevCreep == creep) then
    --mq.IO.dprint("Skipping exp kill for: " .. creep);
  elseif (creep ~= nil and prevCreep ~= creep) then
    --[[ step through the quests and update kill counts --]]
    for i=1, table.getn(myquests.QuestLog), 1 do
      local tmpQuest = myquests.QuestLog[i];
      for j=1, table.getn(myquests.QuestLog[i].objectives), 1 do
        local tmpGoal = myquests.QuestLog[i].objectives[j];
        if (tmpGoal.type == "KillMonster") then
          if (string.lower(tmpGoal.name) == string.lower(creep)) then
            mq.QuestObjectives["KillMonster"].OnUpdate(tmpGoal);
          end
        end
      end
    end
  end

  -- clear out the prevCreep variable for a new round    
  prevCreep = nil;
end

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
function mq.Event.ChatMsgCombatHonorGain()
  local s, e, creep = string.find(arg1, MQ_REGEX_HONOR_GAIN);

  -- unit target test done here to avoid unit target change during loop
  if (creep == UnitName("target")) then
    -- this is already done, I think, in the target change.
  end

  for i=1, table.getn(myquests.QuestLog), 1 do
    local tmpQuest = myquests.QuestLog[i];

    for j=1, table.getn(tmpQuest.objectives), 1 do
      local tmpGoal = tmpQuest.objectives[j];
      if (tmpGoal.type == "PvpAny") then
        mq.IO.print("Caught a PvpAny");
        mq.QuestObjectives["PvpAny"].OnUpdate(tmpGoal);
      elseif (tmpGoal.type == "PvpClass") then
        mq.QuestObjectives["PvpClass"].OnUpdate(tmpGoal);
      elseif (tmpGoal.type == "PvpGuild") then
        mq.QuestObjectives["PvpGuild"].OnUpdate(tmpGoal);
      elseif (tmpGoal.type == "PvpPlayer") then
        mq.QuestObjectives["PvpPlayer"].OnUpdate(tmpGoal);
      elseif (tmpGoal.type == "PvpRace") then
        mq.QuestObjectives["PvpRace"].OnUpdate(tmpGoal);
      end
    end
    mq.CheckQuestComplete(tmpQuest);
  end
end

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
function mq.Event.ChatMsgEmote()
  for i=1, table.getn(myquests.QuestLog), 1 do
    local tmpQuest = myquests.QuestLog[i];

    for j=1, table.getn(tmpQuest.objectives), 1 do
      local tmpGoal = tmpQuest.objectives[j];
      if (tmpGoal.type == "Emote") then
        if (tmpGoal.action == "EmotePerform") then
          -- parse the no target action
          -- parse the target action, checking the target
        end

        if (tmpGoal.action == "EmoteReceive") then
          -- parse the receive action
        end
      end
      mq.CheckQuestComplete(tmpQuest)
    end    
  end
end

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
function mq.Event.PlayerDead()
  if (myquests) then
    for i=1, table.getn(myquests.QuestLog), 1 do
      if (myquests.QuestLog[i].failOnDeath) then
        myquests.QuestLog[i].isFailed = 1;
      end
    end    
  end
end

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
function mq.Event.PlayerMoney()
  local checkComplete = false;
  
  for i=1, table.getn(myquests.QuestLog), 1 do
    local tmpQuest = myquests.QuestLog[i];
    for j=1, table.getn(tmpQuest.objectives), 1 do
      local tmpGoal = tmpQuest.objectives[j];
      if (tmpGoal.type == "Money") then
        mq.QuestObjectives["Money"].OnUpdate(tmpGoal);
      end
    end
    mq.CheckQuestComplete(tmpQuest);
  end
end