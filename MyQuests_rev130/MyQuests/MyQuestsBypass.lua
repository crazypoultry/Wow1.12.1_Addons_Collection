--[[ ********************************************************************* --]]
--[[ MyQuestsBypass.lua                                                    --]]
--[[   Holds all overrides of standard World of Warcraft API function      --]]
--[[     calls.                                                            --]]
--[[ ********************************************************************* --]]


--[[ !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! --]]
--[[ **                 MyQuests Communications Channel                 ** --]]
--[[ !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! --]]
local g_lastChatMessage = nil;
local g_lastChatFrom = nil;

local g_HunterTame = {};

--[[ ********************************************************************* --]]
--[[ ChatFrame_OnEvent                                                     --]]
--[[   ??                                                                  --]]
MQOverride_ChatFrame_OnEvent = ChatFrame_OnEvent;
function ChatFrame_OnEvent(event)
  if (event and arg1) then
    local s, e;
    
    -- handle the dueling objective checks
    local winner, loser;
    s, e, winner, loser = string.find(arg1, MQ_REGEX_DUEL);
    if (winner) then
      if (winner == UnitName("player")) then
        TargetByName(loser);
        for i=1, table.getn(myquests.QuestLog), 1 do
          local tmpQuest = myquests.QuestLog[i];
          for j=1, table.getn(tmpQuest.objectives), 1 do
            local tmpGoal = tmpQuest.objectives[j];
            if (tmpGoal.type == "DuelAny") then
              mq.QuestObjectives["DuelAny"].OnUpdate(tmpGoal);
            elseif (tmpGoal.type == "DuelClass") then
              mq.QuestObjectives["DuelClass"].OnUpdate(tmpGoal);
            elseif (tmpGoal.type == "DuelGuild") then
              mq.QuestObjectives["DuelGuild"].OnUpdate(tmpGoal);
            elseif (tmpGoal.type == "DuelPlayer") then
              mq.QuestObjectives["DuelPlayer"].OnUpdate(tmpGoal);
            elseif (tmpGoal.type == "DuelRace") then
              mq.QuestObjectives["DuelRace"].OnUpdate(tmpGoal);
            end
          end
          mq.CheckQuestComplete(tmpQuest);
        end        
      end
    end
    
    -- check if a tame has started
    local tamed;
    s, e, tamed = string.find(arg1, MQ_REGEX_TAME_STEP1);
    if (tamed) then
      g_HunterTame["step"] = 1;
      g_HunterTame["name"] = tamed;
    end
    
    s, e = string.find(arg1, MQ_REGEX_TAME_STEP2);
    if (s) then
      g_HunterTame["step"] = 2;
      mq.ScheduleForCall(clearTame, {}, 5, 1);
    end
    
    s, e = string.find(arg1, MQ_REGEX_TAME_STEP3);
    if (s and g_HunterTame["step"] == 2) then
      for i=1, table.getn(myquests.QuestLog), 1 do
        local tmpQuest = myquests.QuestLog[i];
        for j=1, table.getn(tmpQuest.objectives), 1 do
          local tmpGoal = tmpQuest.objectives[j];
          if (tmpGoal.type == "Tame") then
            if (tmpGoal.name == g_HunterTame["name"]) then
              mq.QuestObjectives.Tame.OnUpdate(tmpGoal);
            end
          end
        end
        mq.CheckQuestComplete(tmpQuest);
      end
    end
  end
  
  -- pass comm traffic through to the default handler
  MQOverride_ChatFrame_OnEvent(event);
end

function clearTame()
  g_HunterTame["step"] = nil;
end


--[[ !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! --]]
--[[ **                 MyQuests Quest Creation Wizard                  ** --]]
--[[ !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! --]]
MQBypass_CursorItem = nil;

--[[ ********************************************************************* --]]
--[[ PickupContainerItem                                                   --]]
--[[   Fired each time an item is picked up and dropped into a bag slot.   --]]
MQOverride_PickupContainerItem = PickupContainerItem;
function MQWizard_PickupContainerItem(bag, slot)
  --MyQuests_Tooltip:SetBagItem(bag, slot);  
  --local name = MyQuests_TooltipTextLeft1:GetText();

  MQOverride_PickupContainerItem(bag, slot);
  
  if (CursorHasItem()) then
    MQBypass_CursorItem = {};
    MQBypass_CursorItem.bag = bag;
    MQBypass_CursorItem.slot = slot;
    --MQBypass_CursorItem.name = name;
    MQBypass_CursorItem.link = GetContainerItemLink(bag, slot);
    MQBypass_CursorItem.texture = GetContainerItemInfo(bag, slot);
    
    -- TODO: figure out how to get usable state
    MQBypass_CursorItem.isUseable = 1;
  end
  
  --mq.IO.dprint("Picked up: " .. MQBypass_CursorItem.name);
end


--[[ !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! --]]
--[[ **                       MyQuests Quest View                       ** --]]
--[[ !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! --]]
MQBypass_Quest = nil;
local MQBypass_AbandonIndex = nil;


MQOverride_QuestTitleButton_OnClick = QuestTitleButton_OnClick;
function QuestTitleButton_OnClick()
  -- if active, use the local copy instead
  if (this.isActive == 1) then
    return MQOverride_QuestTitleButton_OnClick();
  end

  -- fetch the quest data if haven't already
  if(mq.QuestCache) then
    local tmpQuest = MQData_GetQuestById(this.mqId, mq.QuestCache.quests);
    if (tmpQuest["level"] == nil) then
      -- show the wait screen
      HideUIPanel(QuestFrameGreetingPanel);
      ShowUIPanel(MyQuestsFrameGreetingPanel);
      
      local dataOut = {
        ["action"]  = mq.COMM_QUERY_QUEST,
        ["mqId"] = this.mqId,
      };
      
      mq.QuestCache["QuestQuery"] = {
        ["isActive"] = this.isActive,
        ["mqId"] = this.mqId,
        ["wowId"] = this:GetID()
      };
      
      mq.SendMessage(dataOut, mq.QuestCache["sender"]);
      return;
    end
  end
  
  return MQOverride_QuestTitleButton_OnClick();
end

--[[ ********************************************************************* --]]
--[[ AbandonQuest                                                          --]]
MQOverride_AbandonQuest = AbandonQuest;
function AbandonQuest()
  if(MQBypass_AbandonIndex) then
    table.remove(myquests.QuestLog, MQBypass_AbandonIndex);

    RemoveQuestWatch(MQBypass_AbandonIndex);
    MQBypass_AbandonIndex = nil;

    MQBypass_LogSelection = 0;

    mq.OnGlobalEvent("QUEST_LOG_UPDATE");

    return;
  end

  return MQOverride_AbandonQuest();
end

--[[ ********************************************************************* --]]
--[[ SetAbandonQuest                                                       --]]
MQOverride_SetAbandonQuest = SetAbandonQuest;
function SetAbandonQuest()
  MQBypass_AbandonIndex = nil;
  
  if(MQBypass_LogSelection > 0) then
    MQBypass_AbandonIndex = MQBypass_LogSelection;
    return;
  end;
  
  MQOverride_SetAbandonQuest();
end

--[[ ********************************************************************* --]]
--[[ GetAbandonQuestName                                                   --]]
MQOverride_GetAbandonQuestName = GetAbandonQuestName;
function GetAbandonQuestName()
  if(MQBypass_AbandonIndex ~= nil) then
    return myquests.QuestLog[MQBypass_AbandonIndex].title;
  end
  
  return MQOverride_GetAbandonQuestName();
end


--[[ ********************************************************************* --]]
--[[ GetNumAvailableQuests                                                 --]]
--[[   Overloaded function called by WoW when the QuestFrameGreetingPanel  --]]
--[[     is shown.                                                         --]]
MQOverride_GetNumAvailableQuests = GetNumAvailableQuests;
function GetNumAvailableQuests()
  mq.IO.dprint("[GetNumAvailableQuests]");

  if(myquests.IsEnabled) then
    if(mq.QuestCache) then
      local i;
      local count = 0;
      for i=1, table.getn(mq.QuestCache.quests), 1 do
        if (not MQ_CheckDoing(i, mq.QuestCache.sender)) then
          count = count + 1;
        end
      end
      
      return count;
    end
  end

  -- call the regular function
  return MQOverride_GetNumAvailableQuests();
end

--[[ ********************************************************************* --]]
--[[ MQ_CheckDoing                                                         --]]
--[[   Steps through the available quests and checks if the player is      --]]
--[[     currently running any.                                            --]]
function MQ_CheckDoing(questIndex, checkPlayer)
  local i;
  for i=1, table.getn(myquests.QuestLog), 1 do
    if(myquests.QuestLog[i].finishPlayers[1] == checkPlayer) then
      if(myquests.QuestLog[i].title == mq.QuestCache.quests[questIndex].title) then
        return 1;
      end
    end
  end
  
  return nil;
end

--[[ ********************************************************************* --]]
--[[ GetNumActiveQuests                                                    --]]
--[[   Overloaded function called by WoW when the QuestFrameGreetingPanel  --]]
--[[     is shown.                                                         --]]
MQOverride_GetNumActiveQuests = GetNumActiveQuests;
function GetNumActiveQuests()
  if(myquests.IsEnabled) then
    if(mq.QuestCache) then
      local count = 0;
      
      for i=1, table.getn(myquests.QuestLog), 1 do
        if (myquests.QuestLog[i].finishPlayers[1] == mq.QuestCache.sender) then
          count = count + 1;
        end
      end
      
      return count;
    end
  end

  return MQOverride_GetNumActiveQuests();
end

--[[ ********************************************************************* --]]
--[[ GetAvailableTitle                                                     --]]
--[[   ??                                                                  --]]
MQOverride_GetAvailableTitle = GetAvailableTitle;
function GetAvailableTitle(id)
  mq.IO.dprint("[GetAvailableTitle]");

  if (myquests.IsEnabled) then
    if (mq.QuestCache) then
      local newId = MQBypass_GetAvailableID(id);
      getglobal("QuestTitleButton" .. newId).mqId = mq.QuestCache.quests[newId].id;
      return mq.QuestCache.quests[newId].title;
    end
  end

  return MQOverride_GetAvailableTitle(id);
end

--[[ MQBypass_GetAvailableID                                               --]]
--[[   ??                                                                  --]]
function MQBypass_GetAvailableID(id)
  local count = 0;

  for i=1, table.getn(mq.QuestCache.quests), 1 do
    if (not MQ_CheckDoing(i, mq.QuestCache.sender)) then
      count = count + 1;
      if (count == id) then
        return i;
      end
    end
  end
  
  return nil;
end

--[[ ********************************************************************* --]]
--[[ GetActiveTitle                                                        --]]
--[[   ??                                                                  --]]
MQOverride_GetActiveTitle = GetActiveTitle;
function GetActiveTitle(id)
  mq.IO.dprint("[GetActiveTitle]");

  if(myquests.IsEnabled) then
    if(mq.QuestCache) then
      local count = 0;
      
      -- check if this player is the finishing player for any quests
      for i=1, table.getn(myquests.QuestLog), 1 do
        if(myquests.QuestLog[i].finishPlayers[1] == mq.QuestCache.sender) then
          count = count + 1;
          if (count == id) then
            getglobal("QuestTitleButton" .. id).mqId = myquests.QuestLog[i].id;
            return myquests.QuestLog[i].title;
          end
        end
      end
      
      return nil;
    end
  end

  return MQOverride_GetActiveTitle(id);
end

--[[ ********************************************************************* --]]
--[[ GetGreetingText                                                       --]]
--[[   Returns the greeting tet of the current target.                     --]]
MQOverride_GetGreetingText = GetGreetingText;
function GetGreetingText()
  mq.IO.dprint("[GetGreetingText]");

  if(myquests.IsEnabled) then
    if(mq.QuestCache) then
      return mq.QuestCache.greetingText;
    end
  end

  return MQOverride_GetGreetingText();  
end

--[[ ********************************************************************* --]]
--[[ GetQuestMoneyToGet                                                    --]]
--[[   Returns the remaining amount of Copper required to complete the     --]]
--[[     quest.                                                            --]]
MQOverride_GetQuestMoneyToGet = GetQuestMoneyToGet;
function GetQuestMoneyToGet()
  local totalMoney = 0;
  
  if (MQBypass_Quest) then
    --for i=1, table.getn(MQBypass_Quest.objectives), 1 do
    --  if (MQBypass_Quest.objectives[i].type == "Money") then
    --    totalMoney = totalMoney + MQBypass_Quest.objectives[i].copper;
    --  end
    --end
    --return totalMoney;
    return MQBypass_Quest.objectiveMoney;
  end
  
  return MQOverride_GetQuestMoneyToGet();
end

--[[ ********************************************************************* --]]
--[[ GetQuestItemInfo                                                      --]]
--[[   Returns information on the indexed quest item.                      --]]
MQOverride_GetQuestItemInfo = GetQuestItemInfo;
function GetQuestItemInfo(itype, id)
  if (MQBypass_Quest) then
    if(itype == "required") then
      return MQBypass_Quest.objectives[id].name,
        MQBypass_Quest.objectives[id].texture,
        MQBypass_Quest.objectives[id].numItems,
        MQBypass_Quest.objectives[id].quality,
        MQBypass_Quest.objectives[id].isUseable;
    elseif(itype == "choice") then  
      return MQBypass_Quest.rewardChoices[id].name,
        MQBypass_Quest.rewardChoices[id].texture,
        MQBypass_Quest.rewardChoices[id].numItems,
        MQBypass_Quest.rewardChoices[id].quality,
        MQBypass_Quest.rewardChoices[id].isUseable;
    elseif(itype == "reward") then  
      local type = MQBypass_Quest.rewards[id].type;
      
      if (type == "GuildPromotion") then
        return MQ_QUEST_WIZARD_REWARD_PROMOTION,
               "Interface\\Icons\\INV_Misc_Note_02",
               0,
               1,
               1;
      elseif (type == "GuildInvite") then
        return MQ_QUEST_WIZARD_REWARD_INVITATION,
               "Interface\\Icons\\INV_Misc_Note_02",
               0,
               1,
               1;
      else
        return MQBypass_Quest.rewards[id].name,
          MQBypass_Quest.rewards[id].item.texture,
          MQBypass_Quest.rewards[id].total,
          MQBypass_Quest.rewards[id].item.quality,
          MQBypass_Quest.rewards[id].item.isUseable;
      end
    end
  end
  
  return MQOverride_GetQuestItemInfo(itype, id);
end

--[[ ********************************************************************* --]]
--[[ SelectAvailableQuest                                                  --]]
--[[   Called when the user clicks on a listing for an available quest.    --]]
MQOverride_SelectAvailableQuest = SelectAvailableQuest;
function SelectAvailableQuest(id)
  if(mq.QuestCache) then
    MQBypass_Quest = mq.QuestCache.quests[MQBypass_GetAvailableID(id)];

    -- show the window...
    HideUIPanel(QuestFrameGreetingPanel);
    ShowUIPanel(QuestFrameDetailPanel);
    return;
  end;
  
  return MQOverride_SelectAvailableQuest(id);
end

--[[ ********************************************************************* --]]
--[[ SelectActiveQuest                                                     --]]
--[[   Called when the user clicks on a listing for an active quest.       --]]
MQOverride_SelectActiveQuest = SelectActiveQuest;
function SelectActiveQuest(id)
  if(mq.QuestCache) then
    local count = 0;

    for i=1, table.getn(myquests.QuestLog), 1 do
      if(myquests.QuestLog[i].finishPlayers[1] == mq.QuestCache.sender) then
        count = count + 1;
        
        if (count == id) then
          MQBypass_Quest = myquests.QuestLog[i];
          
          -- show the window...
          HideUIPanel(QuestFrameGreetingPanel);
          if(myquests.QuestLog[i].isComplete) then
            ShowUIPanel(QuestFrameRewardPanel);
          else
            ShowUIPanel(QuestFrameProgressPanel);
          end

          return;
        end
        
        MQBypass_Quest = mq.QuestCache.quests[id];
      end
    end
  end
  
  return MQOverride_SelectActiveQuest(id);
end

--[[ ********************************************************************* --]]
--[[ GetTitleText                                                          --]]
--[[   Returns the quest's title.                                          --]]
MQOverride_GetTitleText = GetTitleText;
function GetTitleText()
  if(MQBypass_Quest) then
    return MQBypass_Quest.title;
  end;
  
  return MQOverride_GetTitleText();
end;

--[[ ********************************************************************* --]]
--[[ GetQuestText                                                          --]]
--[[   Returns the quest's description text.                               --]]
MQOverride_GetQuestText = GetQuestText;
function GetQuestText()
  if(MQBypass_Quest) then
    return mq.TranslateCarriageReturn(MQBypass_Quest.descText, true);
  end;
  
  return MQOverride_GetQuestText();
end;

--[[ ********************************************************************* --]]
--[[ GetObjectiveText                                                      --]]
--[[   Returns the short objective summary of the current quest.           --]]
MQOverride_GetObjectiveText = GetObjectiveText;
function GetObjectiveText()
  if(MQBypass_Quest) then
    mq.IO.dprint(MQBypass_Quest.summaryText);
    return MQBypass_Quest.summaryText;
  end;
  
  return MQOverride_GetObjectiveText();
end;

--[[ ********************************************************************* --]]
--[[ GetProgressText                                                       --]]
--[[   Returns the progress text string, shown when speaking to the turn   --]]
--[[     in player but before the quest is complete.                       --]]
MQOverride_GetProgressText = GetProgressText;
function GetProgressText()
  if(MQBypass_Quest) then
    return MQBypass_Quest.progressText;
  end;
  
  return MQOverride_GetProgressText();
end;

--[[ ********************************************************************* --]]
--[[ GetRewardText                                                         --]]
--[[   ??                                                                  --]]
MQOverride_GetRewardText = GetRewardText;
function GetRewardText()
  if(MQBypass_Quest) then
    return MQBypass_Quest.completeText;
  end;
  
  return MQOverride_GetRewardText();
end;

--[[ ********************************************************************* --]]
--[[ GetNumQuestRewards                                                    --]]
--[[   ??                                                                  --]]
MQOverride_GetNumQuestRewards = GetNumQuestRewards;
function GetNumQuestRewards()
  local totalRewards = 0;
  
  if(MQBypass_Quest) then
    --for i=1, table.getn(MQBypass_Quest.rewards),1 do
    --  if (MQBypass_Quest.rewards[i] ~= "Money") then
    --    totalRewards = totalRewards + 1;
    --  end
    --end
    --return totalRewards;
    return table.getn(MQBypass_Quest.rewards);
  end

  return MQOverride_GetNumQuestRewards();
end;

--[[ ********************************************************************* --]]
--[[ IsQuestCompletable                                                    --]]
--[[   Returns flag indicating the completed state of the quest.           --]]
MQOverride_IsQuestCompletable = IsQuestCompletable;
function IsQuestCompletable()
  if(MQBypass_Quest) then
    return MQBypass_Quest.isComplete;
  end;
  
  return MQOverride_IsQuestCompletable();
end

--[[ ********************************************************************* --]]
--[[ CloseQuest                                                            --]]
--[[   ??                                                                  --]]
MQOverride_CloseQuest = CloseQuest;
function CloseQuest()
  if(MQBypass_Quest) then
    -- Send the Message to the other player.
    --PQ_Send(PQ_DataCache.player, "MSG_DECLINE_PENDING", PQ_Intermediate.title);

    -- clear the pending quest
    MQBypass_Quest = nil;
    return;
  end
  
  mq.QuestCache = nil;

  MQOverride_CloseQuest();
end;

--[[ ********************************************************************* --]]
--[[ CompleteQuest                                                         --]]
--[[   ??                                                                  --]]
MQOverride_CompleteQuest = CompleteQuest;
function CompleteQuest()
  mq.IO.dprint("[CompleteQuest]");

  if(MQBypass_Quest) then
    HideUIPanel(QuestFrameProgressPanel);
    HideUIPanel(QuestFrameRewardPanel);

    return;
  end

  return MQOverride_CompleteQuest();
end;

--[[ ********************************************************************* --]]
--[[ GetQuestReward                                                        --]]
--[[   Fired after the user selects a quest reward and presses "Complete   --]]
--[[   Quest".  This is currently used as the final quest trigger for any  --]]
--[[   MyQuests quest.                                                     --]]
MQOverride_GetQuestReward = GetQuestReward;
function GetQuestReward(id)
  mq.IO.dprint("[GetQuestReward]");

  if(MQBypass_Quest) then
    -- inform the finishPlayer that you've completed the quest

    local dataOut = {
      ["action"] = mq.COMM_TURNIN_P_REQUEST,
      ["mqId"] = MQBypass_Quest.id
    };
    mq.SendMessage(dataOut, MQBypass_Quest.finishPlayers[1]);
  end

  return MQOverride_GetQuestReward(id);
end;

--[[ ********************************************************************* --]]
--[[ GetRewardMoney                                                        --]]
--[[   ??                                                                  --]]
MQOverride_GetRewardMoney = GetRewardMoney;
function GetRewardMoney()
  local totalMoney = 0;
  
  if (MQBypass_Quest) then
    --for i=1, table.getn(MQBypass_Quest.rewards), 1 do
    --  if (MQBypass_Quest.rewards[i].type == "Money") then
    --    totalMoney = totalMoney + MQBypass_Quest.rewards[i].copper;
    --  end
    --end
    --return totalMoney;
    return MQBypass_Quest.rewardMoney;
  end
  
  return MQOverride_GetRewardMoney();
end

--[[ ********************************************************************* --]]
--[[ GetNumQuestItems                                                      --]]
--[[   Used only in the progress frame, telling player of pregress on      --]]
--[[   quest.                                                              --]]
MQOverride_GetNumQuestItems = GetNumQuestItems;
function GetNumQuestItems()
  if(MQBypass_Quest) then
    return 0;
  end;

  return MQOverride_GetNumQuestItems();
end;

--[[ ********************************************************************* --]]
--[[ AcceptQuest                                                           --]]
--[[   ??                                                                  --]]
MQOverride_AcceptQuest = AcceptQuest;
function AcceptQuest()
  local entries, quests = GetNumQuestLogEntries();

  if(MQBypass_Quest) then
    mq.IO.dprint(table.getn(myquests.QuestLog));
    mq.IO.dprint(myquests.MAX_QUESTLOG_QUESTS);
    if (table.getn(myquests.QuestLog) >= myquests.MAX_QUESTLOG_QUESTS) then
      mq.IO.error("Your MyQuests Quest Log is full.");
      DeclineQuest();
      return;
    end

    -- insert the accepted quest into the acceptedQuests table
    table.insert(myquests.QuestLog, MQBypass_Quest);

    -- check that they already haven't completed this quest
    --PQ_CheckCompletedQuest(PQ_Data[PQ_PlayerName].nQuests);

    -- ** DOES THE QUEST GIVER REALLY CARE?
    -- Send the Message to the other player.
    --PQ_Send(PQ_DataCache.player, "MSG_ACCEPT", PQ_Intermediate.title);

    mq.IO.print("Quest accepted: " .. MQBypass_Quest.title);

    -- flag the bags to be checked
    mq.Event.BagUpdated = 1;
    
    -- clear the pending quest
    MQBypass_Quest = nil;
    HideUIPanel(QuestFrame);

    mq.OnGlobalEvent("QUEST_LOG_UPDATE");
    
    return;
  end

  MQOverride_AcceptQuest();
end

--[[ ********************************************************************* --]]
--[[ DeclineQuest                                                          --]]
--[[   ??                                                                  --]]
MQOverride_DeclineQuest = DeclineQuest;
function DeclineQuest()
  if(MQBypass_Quest) then
    MQBypass_Quest = nil;

    -- show the quest listing
    ShowUIPanel(QuestFrameGreetingPanel);

    return;
  end

  MQOverride_DeclineQuest();
end

--[[ ********************************************************************* --]]
--[[ GetRewardSpell                                                        --]]
--[[   ??                                                                  --]]
MQOverride_GetRewardSpell = GetRewardSpell;
function GetRewardSpell()
  if(MQBypass_Quest) then
    return nil;
  end
  
  return MQOverride_GetRewardSpell();
end;

--[[ !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! --]]
--[[ **                       MyQuests Quest Log                        ** --]]
--[[ !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! --]]

MQBypass_LogSelection = 0;

mq.QuestLog = {};
mq.QuestLog.isCollapsed = nil;

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
function mq.QuestLogIndexOffset()
  local offset = 0;
  
  if (myquests.IsEnabled and table.getn(myquests.QuestLog) > 0) then
    offset = 1;
    if (not mq.QuestLog.isCollapsed) then
      offset = offset + table.getn(myquests.QuestLog);
    end
  end
  
  return offset;
end

--[[ ********************************************************************* --]]
--[[ QuestLog_Update                                                       --]]
--[[   Called on a quest log update.                                       --]]
MQOverride_QuestLog_Update = QuestLog_Update;
function QuestLog_Update(elapsed)
  MQOverride_QuestLog_Update(elapsed);

  -- write out the MyQuests quest count
  MyQuestsLogQuestCount:SetText("MyQuests: |c00FFFFFF" .. table.getn(myquests.QuestLog) .. "/" .. myquests.MAX_QUESTLOG_QUESTS);
  QuestLogCountMiddle:SetWidth(MyQuestsLogQuestCount:GetWidth());
  
  -- update the WoW quest count
  local numEntries, numQuests = MQOverride_GetNumQuestLogEntries();
  QuestLogQuestCount:SetText(format(QUEST_LOG_COUNT_TEMPLATE, numQuests, MAX_QUESTLOG_QUESTS));
end

--[[ ********************************************************************* --]]
--[[ GetQuestLogSelection                                                  --]]
--[[   Returns the selected quest.                                         --]]
MQOverride_GetQuestLogSelection = GetQuestLogSelection;
function GetQuestLogSelection()
  if(MQBypass_LogSelection > 0) then
    return MQBypass_LogSelection + 1;
  end

  return MQOverride_GetQuestLogSelection() + mq.QuestLogIndexOffset();
end

--[[ ********************************************************************* --]]
--[[ ExpandQuestHeader                                                     --]]
--[[   ??                                                                  --]]
MQOverride_ExpandQuestHeader = ExpandQuestHeader;
function ExpandQuestHeader(questIndex)
  if (myquests.IsEnabled and table.getn(myquests.QuestLog) > 0) then
    if (questIndex == 1) then
      mq.QuestLog.isCollapsed = nil;
      QuestLog_Update();
      return;
    --elseif (table.getn(myquests.QuestLog) > 0) then
    --  return;
    end
  end

  return MQOverride_ExpandQuestHeader(questIndex - mq.QuestLogIndexOffset());
end

--[[ ********************************************************************* --]]
--[[ CollapseQuestHeader                                                   --]]
--[[   ??                                                                  --]]
MQOverride_CollapseQuestHeader = CollapseQuestHeader;
function CollapseQuestHeader(questIndex)
  if (myquests.IsEnabled and table.getn(myquests.QuestLog) > 0) then
    if (questIndex == 1) then
      mq.QuestLog.isCollapsed = 1;
      QuestLog_Update();
      return;
    --elseif (table.getn(myquests.QuestLog) > 0) then
    --  return;
    end
  end

  return MQOverride_CollapseQuestHeader(questIndex - mq.QuestLogIndexOffset());
end

--[[ ********************************************************************* --]]
--[[ GetQuestLogPushable                                                   --]]
--[[   ??                                                                  --]]
MQOverride_GetQuestLogPushable = GetQuestLogPushable;
function GetQuestLogPushable()
  if (myquests.IsEnabled) then
    if (myquests.QuestLog ~= nil and table.getn(myquests.QuestLog) > 0) then
      if (MQBypass_LogSelection > 0) then
        return myquests.QuestLog[MQBypass_LogSelection].isPushable;
      end
    end
  end

  return MQOverride_GetQuestLogPushable();
end

--[[ ********************************************************************* --]]
--[[ GetNumQuestLogEntries                                                 --]]
--[[   ??                                                                  --]]
MQOverride_GetNumQuestLogEntries = GetNumQuestLogEntries;
function GetNumQuestLogEntries()
  if (myquests.IsEnabled and table.getn(myquests.QuestLog) > 0) then
    local entries, quests = MQOverride_GetNumQuestLogEntries();

    --if (mq.QuestLog.isCollapsed) then
    --  return entries + 1, quests;
    --else
      return entries + 1 + table.getn(myquests.QuestLog), quests + table.getn(myquests.QuestLog);
    --end
  end

  return MQOverride_GetNumQuestLogEntries();
end

--[[ ********************************************************************* --]]
--[[ GetQuestLogTitle                                                      --]]
--[[   ??                                                                  --]]
MQOverride_GetQuestLogTitle = GetQuestLogTitle;
function GetQuestLogTitle(questIndex)
  local level, questTag;
  local offset = mq.QuestLogIndexOffset();
  
  if (questIndex == nil) then
    questIndex = 1;
  end
  
  if (myquests.IsEnabled and table.getn(myquests.QuestLog) > 0) then
    if (questIndex == 1) then
      return "Player Created", 0, nil, 1, mq.QuestLog.isCollapsed, nil;
    
    --elseif (mq.QuestLog.isCollapsed) then
    --  return MQOverride_GetQuestLogTitle(questIndex - 1);
    --end
    
    elseif (questIndex > offset) then
      return MQOverride_GetQuestLogTitle(questIndex - offset);
    else
      level = myquests.QuestLog[questIndex-1].level
      questTag = myquests.QuestLog[questIndex-1].questTag;

      if (myquests.QuestLog[questIndex-1].isFailed) then
        questTag = "Failed";
        level = 0;
      end

      return myquests.QuestLog[questIndex-1].title,         -- quest title
             level,                                         -- quest level
             questTag,                                      -- quest tag (e.g.: "Failed")
             nil,                                           -- is header
             mq.QuestLog.isCollapsed,                       -- is collapsed
             myquests.QuestLog[questIndex-1].isComplete;    -- is complete
    end
  end
  
  return MQOverride_GetQuestLogTitle(questIndex);
end

--[[ ********************************************************************* --]]
--[[ SelectQuestLogEntry                                                   --]]
--[[   ??                                                                  --]]
MQOverride_SelectQuestLogEntry = SelectQuestLogEntry;
function SelectQuestLogEntry(questIndex)
  local offset = mq.QuestLogIndexOffset();
  
  MQBypass_LogSelection = 0;

  if (myquests.IsEnabled and table.getn(myquests.QuestLog) > 0) then
    --if (mq.QuestLog.isCollapsed and questIndex > 1) then
    --  return MQOverride_SelectQuestLogEntry(questIndex - 1);
    --elseif (not mq.QuestLog.isCollapsed and questIndex > offset) then
    if (questIndex > offset) then
      return MQOverride_SelectQuestLogEntry(questIndex - offset);
    else
      MQBypass_LogSelection = questIndex - 1;
      return;
    end
  end
  
  return MQOverride_SelectQuestLogEntry(questIndex);
end

--[[ ********************************************************************* --]]
--[[ GetQuestLogQuestText                                                  --]]
--[[   Returns the quest description and objective text.                   --]]
MQOverride_GetQuestLogQuestText = GetQuestLogQuestText;
function GetQuestLogQuestText()
  --if (myquests.IsEnabled and table.getn(myquests.QuestLog) > 0) then
    if (MQBypass_LogSelection > 0) then
      return mq.TranslateCarriageReturn(myquests.QuestLog[MQBypass_LogSelection].descText, true),
             mq.TranslateCarriageReturn(myquests.QuestLog[MQBypass_LogSelection].summaryText, true);
    end
  --end

  return MQOverride_GetQuestLogQuestText();
end

--[[ ********************************************************************* --]]
--[[ GetQuestLogItemLink                                                   --]]
--[[   ??                                                                  --]]
MQOverride_GetQuestLogItemLink = GetQuestLogItemLink;
function GetQuestLogItemLink(type, id)
  --if (myquests.IsEnabled and table.getn(myquests.QuestLog) > 0) then
    if (MQBypass_LogSelection > 0) then
      return myquests.QuestLog[MQBypass_LogSelection].rewards[id].link;
    end
  --end

  return MQOverride_GetQuestLogItemLink(type, id);
end

--[[ ********************************************************************* --]]
--[[ GetQuestLogRewardMoney                                                --]]
--[[   ??                                                                  --]]
MQOverride_GetQuestLogRewardMoney = GetQuestLogRewardMoney;
function GetQuestLogRewardMoney()
  --local totalMoney = 0;
  
  --if (myquests.IsEnabled and table.getn(myquests.QuestLog) > 0) then
    if (MQBypass_LogSelection > 0) then
      --for i=1, table.getn(myquests.QuestLog[MQBypass_LogSelection].rewards), 1 do
      --  if (myquests.QuestLog[MQBypass_LogSelection].rewards[i].type == "Money") then
      --    totalMoney = totalMoney + myquests.QuestLog[MQBypass_LogSelection].rewards[i].copper;
      --  end
      --end
      --return totalMoney;
      return myquests.QuestLog[MQBypass_LogSelection].rewardMoney;
    end
  --end
  
  return MQOverride_GetQuestLogRewardMoney();
end;

--[[ ********************************************************************* --]]
--[[ GetNumQuestLogRewards                                                 --]]
--[[   ??                                                                  --]]
MQOverride_GetNumQuestLogRewards = GetNumQuestLogRewards;
function GetNumQuestLogRewards()
  --if (myquests.IsEnabled and table.getn(myquests.QuestLog) > 0) then
    if (MQBypass_LogSelection > 0) then
      return table.getn(myquests.QuestLog[MQBypass_LogSelection].rewards);
    end
  --end
  
  return MQOverride_GetNumQuestLogRewards();
end;

--[[ ********************************************************************* --]]
--[[ GetNumQuestLogChoices                                                 --]]
--[[   ??                                                                  --]]
MQOverride_GetNumQuestLogChoices = GetNumQuestLogChoices;
function GetNumQuestLogChoices()
  --if (myquests.IsEnabled and table.getn(myquests.QuestLog) > 0) then
    if (MQBypass_LogSelection > 0) then
      return table.getn(myquests.QuestLog[MQBypass_LogSelection].rewardChoices);
    end
  --end
  
  return MQOverride_GetNumQuestLogChoices();
end

--[[ ********************************************************************* --]]
--[[ GetQuestLogChoiceInfo                                                 --]]
--[[   ??                                                                  --]]
MQOverride_GetQuestLogChoiceInfo = GetQuestLogChoiceInfo;
function GetQuestLogChoiceInfo(id)
  --if (myquests.IsEnabled and table.getn(myquests.QuestLog) > 0) then
    if (MQBypass_LogSelection > 0) then
      return myquests.QuestLog[MQBypass_LogSelection].rewardChoices[id].name,
             myquests.QuestLog[MQBypass_LogSelection].rewardChoices[id].texture,
             myquests.QuestLog[MQBypass_LogSelection].rewardChoices[id].numItems,
             myquests.QuestLog[MQBypass_LogSelection].rewardChoices[id].quality,
             myquests.QuestLog[MQBypass_LogSelection].rewardChoices[id].isUseable;
    end
  --end

  return MQOverride_GetQuestLogChoiceInfo(id);
end

--[[ ********************************************************************* --]]
--[[ GetQuestLogRewardInfo                                                 --]]
--[[   ??                                                                  --]]
MQOverride_GetQuestLogRewardInfo = GetQuestLogRewardInfo;
function GetQuestLogRewardInfo(id)
  --if (myquests.IsEnabled and table.getn(myquests.QuestLog) > 0) then
    if (MQBypass_LogSelection > 0) then
      local type = myquests.QuestLog[MQBypass_LogSelection].rewards[id].type;
      
      if (type == "GuildPromotion") then
        return MQ_QUEST_WIZARD_REWARD_PROMOTION,
               "Interface\\Icons\\INV_Misc_Note_02",
               0,
               1,
               1;
      elseif(type == "GuildInvite") then
        return MQ_QUEST_WIZARD_REWARD_INVITATION,
               "Interface\\Icons\\INV_Misc_Note_02",
               0,
               1,
               1;
      else
        return myquests.QuestLog[MQBypass_LogSelection].rewards[id].name,
               myquests.QuestLog[MQBypass_LogSelection].rewards[id].item.texture,
               myquests.QuestLog[MQBypass_LogSelection].rewards[id].total,
               myquests.QuestLog[MQBypass_LogSelection].rewards[id].item.quality,
               myquests.QuestLog[MQBypass_LogSelection].rewards[id].item.isUseable;
      end
    end
  --end

  return MQOverride_GetQuestLogRewardInfo(id);
end

--[[ ********************************************************************* --]]
--[[ GetQuestLogRewardSpell                                                --]]
--[[   ??                                                                  --]]
MQOverride_GetQuestLogRewardSpell = GetQuestLogRewardSpell;
function GetQuestLogRewardSpell()
  if (MQBypass_LogSelection > 0) then
    return nil;
  end

  return MQOverride_GetQuestLogRewardSpell();
end

--[[ ********************************************************************* --]]
--[[ GetNumQuestLeaderBoards                                               --]]
--[[   ??                                                                  --]]
MQOverride_GetNumQuestLeaderBoards = GetNumQuestLeaderBoards;
function GetNumQuestLeaderBoards(questIndex)
  local count, quest;
  local offset = mq.QuestLogIndexOffset();
  
  if(MQBypass_LogSelection > 0) then
    quest = myquests.QuestLog[MQBypass_LogSelection];
    count = 0;

    for i=1, table.getn(quest.objectives), 1 do
      if (quest.objectives[i].leaderBoard ~= nil) then
        count = count + 1;
      end
    end

    return count;
  elseif (questIndex) then
    if (myquests.IsEnabled and table.getn(myquests.QuestLog) > 0) then
      if (questIndex > offset) then
        return MQOverride_GetNumQuestLeaderBoards(questIndex - offset);
      else
        quest = myquests.QuestLog[questIndex-1];
        count = 0;

        for i=1, table.getn(quest.objectives), 1 do
          if (quest.objectives[i].leaderBoard ~= nil) then
            count = count + 1;
          end
        end

        return count;
      end
    end
  end

  return MQOverride_GetNumQuestLeaderBoards(questIndex);
end

--[[ ********************************************************************* --]]
--[[ GetQuestLogLeaderBoard                                                --]]
--[[   Gets information about the objectives for a quest.                  --]]
MQOverride_GetQuestLogLeaderBoard = GetQuestLogLeaderBoard;
function GetQuestLogLeaderBoard(i, questIndex)
  local tmpGoal;
  local offset = mq.QuestLogIndexOffset();
  
  if (MQBypass_LogSelection > 0) then
    tmpGoal = myquests.QuestLog[MQBypass_LogSelection].objectives[i];

    return mq.QuestObjectives[tmpGoal.type].GetLeaderBoard(tmpGoal),
           tmpGoal.type,
           tmpGoal.isComplete;
  elseif (questIndex) then
    if (myquests.IsEnabled and table.getn(myquests.QuestLog) > 0) then
      mq.IO.dprint("I'm here at questIndex " .. questIndex);
      if (questIndex > offset) then
        return MQOverride_GetQuestLogLeaderBoard(i, questIndex - offset);
      else

        local count=0;
        local i=0;
        for i=1, table.getn(myquests.QuestLog[questIndex-1].objectives), 1 do
          if myquests.QuestLog[questIndex-1].objectives[i].leaderBoard~=nil then
            count=count+1;
          end
          if count==i then
            tmpGoal = myquests.QuestLog[questIndex-1].objectives[i];
            return mq.QuestObjectives[tmpGoal.type].GetLeaderBoard(tmpGoal),
                 tmpGoal.type,
                tmpGoal.isComplete;
          end
        end
        return nil;
      end
    end
  end

  return MQOverride_GetQuestLogLeaderBoard(i, questIndex);
end

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
MQOverride_GetQuestTimers = GetQuestTimers;
function GetQuestTimers()
  --mq.IO.dprint("-- " .. table.getn(myquests.QuestLog));
  
  if (myquests.IsEnabled and table.getn(myquests.QuestLog) > 0) then
    mq.IO.dprint("Check 1");
    for i=1, table.getn(myquests.QuestLog), 1 do
      mq.IO.dprint("Check 2");
      if (myquests.QuestLog[i].timeLeft and myquests.QuestLog[i].timeLeft > 0) then
        mq.IO.dprint(myquests.QuestLog[i].timeLeft);
        return myquests.QuestLog[i].timeLeft;
      end
    end
  end

  return MQOverride_GetQuestTimers();
end

--[[ ********************************************************************* --]]
--[[ GetQuestLogTimeLeft                                                   --]]
--[[   ??                                                                  --]]
MQOverride_GetQuestLogTimeLeft = GetQuestLogTimeLeft;
function GetQuestLogTimeLeft()
  if (myquests.IsEnabled and table.getn(myquests.QuestLog) > 0) then
    if(MQBypass_LogSelection > 0) then
      if (myquests.QuestLog[MQBypass_LogSelection].timeLeft) then
        --local delta, start, now = Chronos.getTimer(timerID);
        --return myquests.QuestLog[MQBypass_LogSelection].timeLimit - delta;
        return myquests.QuestLog[MQBypass_LogSelection].timeLeft;
      end
    end
  end

  return MQOverride_GetQuestLogTimeLeft();
end

--[[ ********************************************************************* --]]
--[[ GetQuestLogRequiredMoney                                              --]]
--[[   ??                                                                  --]]
MQOverride_GetQuestLogRequiredMoney = GetQuestLogRequiredMoney;
function GetQuestLogRequiredMoney()
  local totalMoney = 0;

  if (myquests.IsEnabled and table.getn(myquests.QuestLog) > 0) then
    if(MQBypass_LogSelection > 0) then
      --for i=1, table.getn(myquests.QuestLog[MQBypass_LogSelection].objectives), 1 do
      --  if (myquests.QuestLog[MQBypass_LogSelection].objectives[i].type == "Money") then
      --    totalMoney = totalMoney + myquests.QuestLog[MQBypass_LogSelection].objectives[i].copper;
      --  end
      --end
      --return totalMoney;
      return myquests.QuestLog[MQBypass_LogSelection].objectiveMoney;
    end
  end
  
  return MQOverride_GetQuestLogRequiredMoney();
end

--[[ ********************************************************************* --]]
--[[ GetQuestLogIndexByName                                                --]]
--[[   ??                                                                  --]]
MQOverride_GetQuestLogIndexByName = GetQuestLogIndexByName;
function GetQuestLogIndexByName(name)
  return MQOverride_GetQuestLogIndexByName(name)
end

--[[ !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! --]]
--[[ **                       MyQuests Quest Watch                      ** --]]
--[[ !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! --]]

--[[ ********************************************************************* --]]
--[[ RemoveQuestWatch                                                      --]]
--[[   ??                                                                  --]]
MQOverride_RemoveQuestWatch = RemoveQuestWatch;
function RemoveQuestWatch(questIndex)
  if (myquests.IsEnabled and table.getn(myquests.QuestLog) > 0) then
    if(questIndex < 1 + table.getn(myquests.QuestLog)) then
      if(myquests.QuestLog[questIndex-1]) then
        myquests.QuestLog[questIndex-1].isTracked = nil;
      else
        return nil;
      end
    end
  end

  return MQOverride_RemoveQuestWatch(questIndex);
end

--[[ ********************************************************************* --]]
--[[ AddQuestWatch                                                         --]]
--[[   ??                                                                  --]]
MQOverride_AddQuestWatch = AddQuestWatch;
function AddQuestWatch(questIndex)
  if (myquests.IsEnabled and table.getn(myquests.QuestLog) > 0) then
    if(questIndex < 1 + table.getn(myquests.QuestLog)) then
      if(myquests.QuestLog[questIndex-1]) then
         myquests.QuestLog[questIndex-1].isTracked = 1;
      else
        return nil;
      end
    end
  end

  return MQOverride_AddQuestWatch(questIndex);
end

--[[ ********************************************************************* --]]
--[[ IsQuestWatched                                                        --]]
--[[   ??                                                                  --]]
MQOverride_IsQuestWatched = IsQuestWatched;
function IsQuestWatched(questIndex)
  if (myquests.IsEnabled and table.getn(myquests.QuestLog) > 0) then
    if(questIndex < 1 + table.getn(myquests.QuestLog)) then
      if(myquests.QuestLog[questIndex-1]) then
        return myquests.QuestLog[questIndex-1].isTracked;
      else
        return nil;
      end
    end
  end
  
  return MQOverride_IsQuestWatched(questIndex);
end

--[[ ********************************************************************* --]]
--[[ GetNumQuestWatches                                                    --]]
--[[   ??                                                                  --]]
MQOverride_GetNumQuestWatches = GetNumQuestWatches;
function GetNumQuestWatches()
  local mqWatches = 0;
  
  if (myquests.IsEnabled) then
    for i=1, table.getn(myquests.QuestLog), 1 do
      if (myquests.QuestLog[i].isTracked) then
        mqWatches = mqWatches + 1;
      end
    end
  end
  
  return mqWatches + MQOverride_GetNumQuestWatches();
end

MQOverride_QuestWatch_Update = QuestWatch_Update;
function QuestWatch_Update()
  --mq.IO.print("GetNumQuestWatches(): " .. GetNumQuestWatches());
  
  local offset = mq.QuestLogIndexOffset();
  
  for i=1, GetNumQuestWatches() do
    mq.IO.dprint("GetQuestIndexForWatch(" .. i .. ") " .. GetQuestIndexForWatch(i));
    mq.IO.dprint("GetNumQuestLeaderBoards(" .. GetQuestIndexForWatch(i) .. ") " .. GetNumQuestLeaderBoards(GetQuestIndexForWatch(i)));

    local title, level, tag, isHeader, isCollapsed, isComplete = GetQuestLogTitle(GetQuestIndexForWatch(i));
    mq.IO.dprint("GetQuestLogTitle(i) " .. title .. " - " .. level .. " - " .. NoNil(tag) .. " - " .. NoNil(isHeader) .. " - " .. NoNil(isCollapsed) .. " - " .. NoNil(isComplete));
  end
  
  
  return MQOverride_QuestWatch_Update();
end

MQOverride_GetQuestLogIndexByName = GetQuestLogIndexByName;
function GetQuestLogIndexByName(name)
  mq.IO.dprint(name);
  MQOverride_GetQuestLogIndexByName(name);
end

--[[ !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! --]]
--[[ **                          MyQuests Misc                          ** --]]
--[[ !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! --]]


--[[ ********************************************************************* --]]
--[[ GameTooltip.SetQuestItem                                              --]]
--[[   Called when the user mouses over a quest reward.  The default       --]]
--[[     function will throw an error with MyQuests quests, so we just     --]]
--[[     consume the event at the moment.                                  --]]
--[[   Work on a custom tooltip will be done for build 0.2.                --]]
GameTooltip.MQOverride_SetQuestItem = GameTooltip.SetQuestItem;
function GameTooltip.SetQuestItem(this, qtype, slot)
  if (MQBypass_Quest) then
    mq.IO.dprint("[GameTooltip.SetQuestItem] Bypassing Tooltip, slot " .. slot);

    if (MQBypass_Quest.rewards[slot].type == "GuildPromotion") then
      -- custom tootip needed
      return;
    elseif (MQBypass_Quest.rewards[slot].type == "GuildInvite") then
      -- custom tooltip needed
      return;
    elseif (MQBypass_Quest.rewards[slot].type == "ItemReward") then
      mq.IO.dprint(MQBypass_Quest.rewards[slot].item.link);
      --local tmpLink = string.gsub(MQBypass_Quest.rewards[slot].link, "|H(.*)|h", "|H" ..  MQBypass_Quest.rewards[slot].link  .. "|h");
      --this:SetHyperlink(MQUtil_GetActualLink(MQBypass_Quest.rewards[slot].item.link));
      this:SetHyperlink(MQBypass_Quest.rewards[slot].item.link);
      return;
    end
  end

  this:MQOverride_SetQuestItem(qtype, slot)
end

--[[ ********************************************************************* --]]
--[[ GameTooltip.SetQuestItem                                              --]]
--[[   ??                                                                  --]]
GameTooltip.MQOverride_SetQuestLogItem = GameTooltip.SetQuestLogItem;
function GameTooltip.SetQuestLogItem(this, qtype, slot)
  if (MQBypass_Quest or MQBypass_LogSelection > 0) then
    mq.IO.dprint("[GameTooltip.SetQuestLogItem] Bypassing Tooltip");
    return;
  end

  this:MQOverride_SetQuestLogItem(qtype, slot)
end

--[[ ********************************************************************* --]]
--[[ These functions confuse me -- need to figure out how they work.       --]]
function PLQ_P_SET_REAL_LINK(lnk)
  MQBypass_itemLink = lnk;
  return "|H"..lnk.."|h";
end

function MQUtil_GetActualLink(link)
  string.gsub(link, "|H(.*)|h", PLQ_P_SET_REAL_LINK);
  
  --PlayerQuest.OutputMessage(link.." : "..PlayerQuest.items.itemLink);
  
  return MQBypass_itemLink;
end


MQOverride_GetGossipOptions = GetGossipOptions;
function GetGossipOptions()
  if (mq.GossipSession) then
    local output = {};
    local tmpPage = mq.GossipSession[mq.GossipPage];
    
    local index = 1;
    for i=1, table.getn(tmpPage.gossips), 1 do
      if (tmpPage.gossips[i].type ~= "ActiveQuest" and tmpPage.gossips[i].type ~= "AvailableQuest") then
        output[index] = tmpPage.gossips[i].text;
        output[index+1] = tmpPage.gossips[i].type;

        index = index + 2;
      end
    end
    
    return unpack(output);
  end
  
  return MQOverride_GetGossipOptions();
end

MQOverride_GetGossipAvailableQuests = GetGossipAvailableQuests;
function GetGossipAvailableQuests()
  if (mq.GossipSession) then
    local output = {};
    local tmpPage = mq.GossipSession[mq.GossipPage];
    
    local index = 1;
    for i=1, table.getn(tmpPage.gossips), 1 do
      if (tmpPage.gossips[i].type == "AvailableQuest") then
        output[index] = tmpPage.gossips[i].text;
        output[index+1] = tmpPage.gossips[i].type;

        index = index + 2;
      end
    end
    
    return unpack(output);
  end
  
  return MQOverride_GetGossipAvailableQuests();
end

MQOverride_GetGossipActiveQuests = GetGossipActiveQuests;
function GetGossipActiveQuests()
  if (mq.GossipSession) then
    local output = {};
    local tmpPage = mq.GossipSession[mq.GossipPage];
    
    local index = 1;
    for i=1, table.getn(tmpPage.gossips), 1 do
      if (tmpPage.gossips[i].type == "ActiveQuest") then
        output[index] = tmpPage.gossips[i].text;
        output[index+1] = tmpPage.gossips[i].type;

        index = index + 2;
      end
    end
    
    return unpack(output);
  end

  return MQOverride_GetGossipActiveQuests();
end

MQOverride_SelectGossipOption = SelectGossipOption;
function SelectGossipOption(id)
  if (mq.GossipSession) then
    local runIndex = 1;
    
    local tmpPage = mq.GossipSession[mq.GossipPage];
    for i=1, table.getn(tmpPage.gossips), 1 do
      local tmpGossip = tmpPage.gossips[i];

      if (tmpGossip.type ~= "ActiveQuest" and tmpGossip.type ~= "AvailableQuest") then
        if (runIndex == id) then
          --mq.IO.print("I'm going to look up the info on id: " .. id);
          --mq.IO.print("The gossip is of type " .. tmpGossip.type);
          mq.Gossip[tmpGossip.type].OnClick(tmpGossip);
          break;
        else
          runIndex = runIndex + 1;
        end
      end
    end    
  end

  return MQOverride_SelectGossipOption(id);
end

MQOverride_SelectGossipAvailableQuest = SelectGossipAvailableQuest;
function SelectGossipAvailableQuest(id)
  if (mq.GossipSession) then
    local runIndex = 1;
    
    local tmpPage = mq.GossipSession[mq.GossipPage];
    for i=1, table.getn(tmpPage.gossips), 1 do
      local tmpGossip = tmpPage.gossips[i];

      if (tmpGossip.type == "AvailableQuest") then
        if (runIndex == id) then
          --mq.IO.print("I'm going to look up the info on id: " .. id);
          --mq.IO.print("The gossip is of type " .. tmpGossip.type);
          mq.Gossip[tmpGossip.type].OnClick(tmpGossip);
          break;
        else
          runIndex = runIndex + 1;
        end
      end
    end    
  end

  return MQOverride_SelectGossipAvailableQuest(id);
end

MQOverride_SelectGossipActiveQuest = SelectGossipActiveQuest;
function SelectGossipActiveQuest(id)
  if (mq.GossipSession) then
    local runIndex = 1;
    
    local tmpPage = mq.GossipSession[mq.GossipPage];
    for i=1, table.getn(tmpPage.gossips), 1 do
      local tmpGossip = tmpPage.gossips[i];

      if (tmpGossip.type == "ActiveQuest") then
        if (runIndex == id) then
          --mq.IO.print("I'm going to look up the info on id: " .. id);
          --mq.IO.print("The gossip is of type " .. tmpGossip.type);
          mq.Gossip[tmpGossip.type].OnClick(tmpGossip);
          break;
        else
          runIndex = runIndex + 1;
        end
      end
    end    
  end

  return MQOverride_SelectGossipActiveQuest(id);
end

MQOverride_GetGossipText = GetGossipText;
function GetGossipText()
  if (mq.GossipSession) then
    local tmpPage = mq.GossipSession[mq.GossipPage];  -- first index = gossip, second index = page #

   -- if ActiveQuest or AvailableQuest use GetGossipText function, else...
    return tmpPage.text;
  end
  
  return MQOverride_GetGossipText();
end

MQOverride_CloseGossip = CloseGossip;
function CloseGossip()
  mq.GossipSession = nil;
  MQOverride_CloseGossip();
end
