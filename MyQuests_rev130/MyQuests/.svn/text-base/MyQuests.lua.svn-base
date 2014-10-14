
mq                      = {};             -- global MyQuests application namespace
myquests                = {};             -- MyQuests data namespace
BINDING_HEADER_MYQUESTS = "MyQuests";     -- key binding header for MyQuests bindings

mq.VERSION_TEXT         = "0.5.1 Beta (2006-08-18)";

mq.ChatInfo             = {}              -- color information for ephemeral messages
mq.EventDelta           = 0               -- current delta for global update events
mq.PlayerName           = nil             -- active player name
mq.RegisteredEvents     = {};             -- registered callbacks for global events
mq.ScheduledCalls       = dict.create();  -- scheduled callbacks for update events
mq.RegisteredUpdates    = {};

mq.UserList             = {};             -- dynamic list of MyQuests users

mq.TargetInfo           = {};             -- information about the current target

myquests.Quests         = {};             -- player created quests
myquests.QuestLog       = {};             -- accepted MyQuests quests
myquests.QuestHistory   = {};             -- completed quest history

myquests.PlayerLog      = {};             -- quest history for given quests

mq.QuestCache           = nil;            -- table of quests received from another player
-- TODO: need to replace temp quest in Bypass with the below variable
--mq.QuestSession         = nil;            -- current quest being looked at
mq.GossipSession        = nil;            -- current gossip session being handled

mq.TradeSession   = {};

myquests.TargetBadgeLoc = 45;            -- location information for the target and map badges
myquests.MapBadgeLoc    = 45;

myquests.greetingText   = "Welcome to MyQuests.";

myquests.IsEnabled      = 1;             -- master enable flag
myquests.AcceptEnabled  = 1;             -- allow players to accept new quests
myquests.TurninEnabled  = 1;             -- allow players to turnin quests

myquests.MAX_QUESTLOG_QUESTS  = 10;

mq.PROTOCOL_NL = "~/";

function mq.UpdateEditBoxScroller(editbox)
    local scrollbar = getglobal(editbox:GetParent():GetName().."ScrollBar")
    editbox:GetParent():UpdateScrollChildRect()
    local min, max = scrollbar:GetMinMaxValues()
    if max > 0 and editbox.max ~= max then
      editbox.max = max
      scrollbar:SetValue(max)
    end
end

--[[ ********************************************************************* --]]
--[[ MyQuests_Init                                                         --]]
--[[                                                                       --]]
--[[ Called on the VARIABLES_LOADED event.  All initialization requiring   --]]
--[[ the rest of the WoW UI to be initialized should be performed here.    --]]
--[[ ********************************************************************* --]]
function MyQuests_Init()
  -- create the MyQuests Quest Log quest count string
  QuestLogFrame:CreateFontString("MyQuestsLogQuestCount", "OVERLAY");
  MyQuestsLogQuestCount:SetPoint("TOPRIGHT", QuestLogQuestCount, "BOTTOMRIGHT", 0, -2);
  MyQuestsLogQuestCount:SetFontObject("GameFontNormalSmall");

  -- restructure the quest count window to hold the MyQuests counter
  QuestLogCountRight:SetPoint("TOPRIGHT", QuestLogFrame, "TOPRIGHT", -47, -35);
  QuestLogCountRight:SetHeight(35);
  QuestLogCountMiddle:SetHeight(QuestLogCountRight:GetHeight());
  QuestLogCountLeft:SetHeight(QuestLogCountRight:GetHeight());
  QuestLogQuestCount:SetPoint("RIGHT", QuestLogCountRight, "RIGHT", -6, 6);

  -- NEW VARIABLES FOR THIS VERSION
  myquests.MAX_QUESTLOG_QUESTS = 10;

  -- update the target badge location
  --mq.UpdateTargetBadge();

  --mq.Start();
  mq.InitializeCommChannel();
end

function mq.Start()
--[[
  -- attempt to join the communications channel
  if (mq.InitializeCommChannel() == nil) then
    mq.IO.print("... attempting to reconnect in 1 second");
    -- wait a second and attempt to start again
    mq.ScheduleForCall(mq.Start, {}, 1, 1);
  else
    mq.IO.print("MyQuests " .. mq.VERSION_TEXT .. " Loaded.");
    myquests.CONFIG_LOADED = 1;
  end
--]]
end


--[[ ********************************************************************* --]]
--[[ Utility function to convert 'nil' to a printable string               --]]
function NoNil(param)
  if (param == nil) then
    return "<nil>";
  else
    return param
  end
end

--[[ ********************************************************************* --]]
--[[ mq.UpdateTargetBadge                                                  --]]
--[[                                                                       --]]
--[[ Specific routine used in the movement of the (MQ) badge.              --]]
--[[                                                                       --]]
--[[ This is the code that actually changes the position of the badge.     --]]
--[[                                                                       --]]
--[[ The 41, and -28 below are used to alter the center of movement of the --]]
--[[ badge. the sin() and cos() are used to keep the movement in a circle. --]]
--[[                                                                       --]]
--[[ ********************************************************************* --]]

--[[
function mq.UpdateTargetBadge()
  MQTargetBadge1:SetPoint(
    "TOP",
    "TargetFrame",
    "TOP",
    41-(40*cos(myquests.TargetBadgeLoc)),
    (40*sin(myquests.TargetBadgeLoc))-28)

  MQTargetBadge2:SetPoint(
    "TOP",
    "TargetFrame",
    "TOP",
    41-(40*cos(myquests.TargetBadgeLoc)),
    (40*sin(myquests.TargetBadgeLoc))-28)
end
--]]


function mq.UpdateTargetBadgePosition()

end







-- [ global event infrastructure ] --

-- register global events of interest
function mq.OnGlobalLoad()
  -- catch the unit name update event to identify the player's name
  local callback = function(event, arguments)
    if arguments[1] == "player" then
      mq.PlayerName = UnitName("player");
    end
  end

  -- register the name callback and identify the name of the active character
  mq.RegisterForEvent("UNIT_NAME_UPDATE", callback);
  mq.PlayerName = UnitName("player");

  -- register all identified events for later response
  for event, callbacks in pairs(mq.RegisteredEvents) do
    this:RegisterEvent(event);
  end

  -- update the location of the primary icon and display the ephemeral banner and status message
  --mq.RegisterForEvent("VARIABLES_LOADED", mq.UpdatePrimaryIconLocation);
  --mq.IO.print(string.format(mq.MSG_VERSION_BANNER, mq.VERSION_TEXT, mq.VERSION_EDITION), "NOTICE");
  
  mq.RegisterForEvent("VARIABLES_LOADED", MyQuests_Init);

  mq.RegisterForEvent("BAG_UPDATE", mq.Event.BagUpdate);

  mq.RegisterForEvent("PLAYER_TARGET_CHANGED", mq.Event.PlayerTargetChanged);

  mq.RegisterForEvent("MINIMAP_ZONE_CHANGED", mq.Event.ZoneChanged);
  mq.RegisterForEvent("ZONE_CHANGED_NEW_AREA", mq.Event.ZoneChanged);

  mq.RegisterForEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", mq.Event.ChatMsgCombatHostileDeath);
  mq.RegisterForEvent("CHAT_MSG_COMBAT_XP_GAIN", mq.Event.ChatMsgCombatXpGain);
  mq.RegisterForEvent("CHAT_MSG_COMBAT_HONOR_GAIN", mq.Event.ChatMsgCombatHonorGain);
  --mq.RegisterForEvent("CHAT_MSG_EMOTE", mq.Event.ChatMsgEmote);
  mq.RegisterForEvent("CHAT_MSG_TEXT_EMOTE", mq.Event.ChatMsgEmote);
  mq.RegisterForEvent("CHAT_MSG_CHANNEL_NOTICE", mq.Event.ChatMsgChannelNotice);
  
  mq.RegisterForEvent("PLAYER_DEAD", mq.Event.PlayerDead);
  
  mq.RegisterForEvent("PLAYER_MONEY", mq.Event.PlayerMoney);

  mq.RegisterForEvent("QUEST_LOG_UPDATE", QuestLog_OnEvent);

  -- register third party quest log mods  
  if (MonkeyQuest_OnEvent) then
    mq.RegisterForEvent("QUEST_LOG_UPDATE", MonkeyQuest_OnEvent);
  end
  if (QuestToolTip_OnEvent) then
    mq.RegisterForEvent("QUEST_LOG_UPDATE", QuestToolTip_OnEvent);
  end
  if (QuestHistory_OnEvent) then
    mq.RegisterForEvent("QUEST_LOG_UPDATE", QuestHistory_OnEvent);
  end

  mq.RegisterForEvent("TRADE_SHOW", mq.Event.TradeShow);
  mq.RegisterForEvent("TRADE_CLOSED", mq.Event.TradeClosed);
  mq.RegisterForEvent("TRADE_REQUEST_CANCEL", mq.Event.TradeRequestCancel);
  mq.RegisterForEvent("TRADE_ACCEPT_UPDATE", mq.Event.TradeAcceptUpdate);
  
--[[  
    this:RegisterEvent("TRADE_ACCEPT_UPDATE");
--]]
end

--[[ ********************************************************************* --]]
--[[ mq.MapUnitUpdate                                                      --]]
--[[   Updates the location of map notes for quest completion players.     --]]
--[[ ********************************************************************* --]]
function mq.MapUnitUpdate()
  -- get current continent
  -- if < 0 or > 2 then hide all icons
  -- return;
  
  for i=1, 5, 1 do
    -- see if icon 'i' has data
    -- update it if so
  end
  
end
--mq.ScheduleForCall(mq.MapUnitUpdate, {}, 5);

--[[ ********************************************************************* --]]
--[[ mq.OnGlobalEvent                                                      --]]
--[[   Passes global event calls through to MyQuests and other registered  --]]
--[[   addons.                                                             --]]
--[[ ********************************************************************* --]]
function mq.OnGlobalEvent(event, arguments)
  for i, callback in ipairs(mq.RegisteredEvents[event]) do
    callback(event, arguments);
  end
end

--[[ ********************************************************************* --]]
--[[ mq.OnGlobalUpdate                                                     --]]
--[[   Global timer update function.  Parses scheduled tasks to be handled --]]
--[[   every second.                                                       --]]
--[[ ********************************************************************* --]]
function mq.OnGlobalUpdate(delta)
  mq.EventDelta = mq.EventDelta + delta;

  if mq.EventDelta >= 1 then
    mq.TimedQuestCall(mq.EventDelta);

    mq.EventDelta = 0;
    
    local timestamp, callback, arguments, timeout, interval = GetTime(), nil, nil, nil, nil;
    
    for call in dict.process(mq.ScheduledCalls, timestamp) do
      callback, arguments, timeout, interval = unpack(call);
      arguments = callback(unpack(arguments)) or arguments;
      
      if timeout and (not interval or interval > 1) then
        if interval then
          interval = interval - 1;
        end
        dict.insert(mq.ScheduledCalls, timestamp + timeout, {callback, arguments, timeout, interval});
      end
    end
  end
end

--[[ ********************************************************************* --]]
--[[ mq.ScheduleForCall                                                    --]]
--[[   Registers the specified call.                                       --]]
--[[                                                                       --]]
--[[   callback - function to call                                         --]]
--[[   arguments - args for callback                                       --]]
--[[   timeout - timeout till first call                                   --]]
--[[   interval - number of times to call                                  --]]
--[[   immediate - call right away                                         --]]
--[[ ********************************************************************* --]]
function mq.ScheduleForCall(callback, arguments, timeout, interval, immediate)
  local call = {callback, arguments, timeout};

  if interval then
    call = {callback, arguments, timeout, interval};
  end

  if immediate then
    arguments = callback(unpack(arguments)) or arguments;
    call[2] = arguments;
  end

  dict.insert(mq.ScheduledCalls, GetTime() + timeout, call);
end

--[[ ********************************************************************* --]]
--[[ mq.RegisterForEvent                                                   --]]
--[[   Registers the specified callback for the specified global event.    --]]
--[[ ********************************************************************* --]]
function mq.RegisterForEvent(event, callback)
  if mq.RegisteredEvents[event] then
    table.insert(mq.RegisteredEvents[event], callback);
  else
    mq.RegisteredEvents[event] = {callback};
  end

  if MyQuests_ControlFrame then
    MyQuests_ControlFrame:RegisterEvent(event);
  end
end

-- slash commands
SLASH_MYQUESTS1 = "/mq";
SlashCmdList["MYQUESTS"] = function(args)
  local slashArgs = string.split(args, " ");

  if (table.getn(slashArgs) == 0) then
    mq.IO.error(usageString);
    
  elseif (string.lower(slashArgs[1]) == "create") then
    --ShowUIPanel(MyQuestsWizard_Parent);
    mq.DisplayQuestEditor(nil);
    
  elseif (string.lower(slashArgs[1]) == "edit") then
    if (slashArgs[2]) then
      if (tonumber(slashArgs[2]) <= table.getn(myquests.Quests)) then
        mq.DisplayQuestEditor(myquests.Quests[tonumber(slashArgs[2])]);
      else
        mq.IO.error("[MyQuests Edit Quest] Quest Index Out of Bounds.");
      end
    else
      mq.IO.error("usage: /mq edit [quest#]");
    end

  elseif (string.lower(slashArgs[1]) == "admin") then
    ShowUIPanel(MyQuestsOptionsFrame);

  elseif (string.lower(slashArgs[1]) == "talk") then
    mq.RequestAvailableQuests()

  --elseif (string.lower(slashArgs[1]) == "reset") then
  --  if (myquests) then
  --    myquests = nil;
  --    
  --    myquests = {};
  --    myquests.Quests = {};
  --    myquests.QuestLog = {};
  --    myquests.QuestHistory = {};
  --  end

  elseif (string.lower(slashArgs[1]) == "list") then
    mq.IO.print("[MyQuests List] " .. table.getn(myquests.Quests) .. " found.");
    for i=1, table.getn(myquests.Quests), 1 do
      mq.IO.print("[" .. i .. "] " .. myquests.Quests[i].title);
    end

  elseif (string.lower(slashArgs[1]) == "delete") then
    if (slashArgs[2]) then
      if (tonumber(slashArgs[2]) <= table.getn(myquests.Quests)) then
        questTitle = myquests.Quests[tonumber(slashArgs[2])].title;
        table.remove(myquests.Quests, tonumber(slashArgs[2]));
        mq.IO.print("[MyQuests Delete] Quest ".. questTitle .." deleted.");
      else
        mq.IO.error("[MyQuests Delete Quest] Quest Index Out of Bounds.");
      end
    else
      mq.IO.error("usage: /mq delete [quest#]");
    end

  elseif (string.lower(slashArgs[1]) == "debug") then
    if (slashArgs[2]) then
      if (slashArgs[2] == "off") then
        mq.IO.DebugTarget = nil;
      else
        mq.IO.DebugTarget = slashArgs[2];
      end
    else
      mq.IO.error("usage: /mq debug [target]");
    end
  
  elseif (string.lower(slashArgs[1]) == "who") then
    -- find out who is using MyQuests.

  elseif (string.lower(slashArgs[1]) == "admintest") then
    ShowUIPanel(MyQuestsAdminFrame);

  elseif (string.lower(slashArgs[1]) == "maptest") then
    mq.MapLocations["test"].continent, mq.MapLocations["test"].zone = mq.GetCurrentZone();
    mq.MapLocations["test"].x, mq.MapLocations["test"].y = GetPlayerMapPosition("player");
    mq.MapLocations["test"].show = true;
    
    
    --local dataOut = {}
    --dataOut.action = MYQUESTS_MSG_MAPLOCATION;
    --dataOut.zone = GetZoneText();
    --dataOut.subZone = GetSubZoneText();
    --dataOut.posX, dataOut.posY = GetPlayerMapPosition("player");
    
    --mq.SendMessage(dataOut, SKY_PLAYER, UnitName("player"));

    --MyQuests_MapNote1Icon:SetTexture("Interface\\Minimaps\\ObjectIcons");
    --MyQuests_MapNote1:SetPoint("CENTER", "MinimapCluster", "TOPLEFT", 107, -97);
    --MyQuests_MapNote1:Show();

  elseif (string.lower(slashArgs[1]) == "bagtest") then
    --local objItemLink = myquests.QuestLog[1].objectives[1].item.link;
    --local objItemLink = "item:2592:0:0:0";
    local objItemLink = "item:117:0:0:0";
    local tradeCount = 2;

    g_bagIndex, g_slotIndex = mq.CompileItemStack(objItemLink, tradeCount);
    mq.IO.print("found in bag: " .. g_bagIndex .. ", slot: " .. g_slotIndex);

  elseif (string.lower(slashArgs[1]) == "bagtest2") then
    local _, itemCount = GetContainerItemInfo(g_bagIndex, g_slotIndex);
    PickupContainerItem(g_bagIndex, g_slotIndex);

  elseif (string.lower(slashArgs[1]) == "bagtest3") then

    local slotId = 1;
    ClickTradeButton(slotId);

  -- print command line usage statement
  else
    mq.IO.error("[MyQuests] unknown command: "..slashArgs[1]);
    mq.IO.print("usage: /mq [admin | create | delete | list | reset]");
  end

end;


--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
function mq.GetFirstOpenSlot()
  for bagIndex=0, 4, 1 do
    for itemIndex=0, 16, 1 do
      local tmpLink = GetContainerItemLink(bagIndex, itemIndex);
      if (tmpLink == nil) then
        return bagIndex, itemIndex;
      end
    end
  end

  return nil, nil;
end


--[[ ********************************************************************* --]]
--[[ mq.BagUpdateCall                                                      --]]
--[[   Checks the contents of the player's bags every 5 seconds if the     --]]
--[[   contents have been changed since the last check.                    --]]
--[[ ********************************************************************* --]]
function mq.BagUpdateCall()
  local showUpdate;
  
  if (mq.Event.BagUpdated) then
    mq.IO.dprint("[MQ DEBUG] Checking bags.");
    
    for i=1, table.getn(myquests.QuestLog), 1 do
      local tmpQuest = myquests.QuestLog[i];
      for j=1, table.getn(tmpQuest.objectives), 1 do
        local tmpGoal = tmpQuest.objectives[j];
        if (tmpGoal.type == "GatherItem") then
          --local tmpLink = Sea.util.makeHyperlink(tmpGoal["link"].link, tmpGoal.name, tmpGoal["link"].color, true);
          --local tmpLink = "|H" .. tmpGoal["item"].link .. "|h" .. tmpGoal["item"].name .. "|h";
          local count = 0;

          showUpdate = true;

          -- loop through the contents on bags
          for bagIndex=0, 4, 1 do
            for itemIndex=0, 16, 1 do
              local tmpLink = GetContainerItemLink(bagIndex, itemIndex);
              if (tmpLink ~= nil) then
                local linkText = string.gsub(tmpLink, "|cff(.*)|H(.*)|h(.*)|h|r.*", "%2");
                if (linkText == tmpGoal["item"].link) then
                  local texture, itemCount, locked, quality, readable = GetContainerItemInfo(bagIndex, itemIndex);
                  count = count + itemCount;
                end
              end
            end
          end

          -- set the count to the required number if we have more
          if (count > tmpGoal.total) then
            count = tmpGoal.total;
          end

          -- if the item count has updated, we want to show the update msg
          if (tmpGoal.count ~= count) then
            mq.QuestObjectives.GetLeaderBoard(tmpGoal, MQ_MSG_QUESTUPDATE_GATHER_ITEM);
          end

          tmpGoal.count = count;

          -- update the item count in the quest
          if (count >= tmpGoal.total) then
            tmpGoal.isComplete = 1;
          else
            tmpGoal.isComplete = nil;
          end
        end
      end
      mq.CheckQuestComplete(tmpQuest);
    end
   
    mq.Event.BagUpdated = nil;
  end
end
mq.ScheduleForCall(mq.BagUpdateCall, {}, 5);

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
function mq.TimedQuestCall(delta)
  for i=1, table.getn(myquests.QuestLog), 1 do
    local tmpQuest = myquests.QuestLog[i];

    --[[ update the timeLeft of any timed quests --]]
    if (tmpQuest.timeLeft ~= nil and not tmpQuest.isComplete) then
      tmpQuest.timeLeft = tmpQuest.timeLeft - delta;
      if (tmpQuest.timeLeft <= 0) then
        tmpQuest.isFailed = 1;
        --mq.CheckQuestComplete(tmpQuest);
      end
    end
  end
end
--mq.ScheduleForCall(mq.TimedQuestCall, {}, 5);


--[[ ********************************************************************* --]]
function mq.DisplayQuestEditor(quest)
  local count;

  ShowUIPanel(MyQuestsWizard_Parent);

  if (quest) then
    MyQuestsWizard_Parent.quest = quest;
    
    MQWizard_CreateTitleEntry:SetText(quest.title);
    MQWizard_CreateLevelEntry:SetText(quest.level);

    MQWizard_FailureDeathToggle:SetChecked(quest.failOnDeath);
    if (quest.timeLeft) then
      MQWizard_FailureTimeToggle:SetChecked(1);
      MQWizard_FailureTimeEntry:SetText(quest.timeLeft/60);
    else
      MQWizard_FailureTimeToggle:SetChecked(0);
      MQWizard_FailureTimeEntry:SetText(0);      
    end

    MQWizard_CompleteRepeatableToggle:SetChecked(quest.isRepeatable);
    MQWizard_CompleteLocalStoreToggle:SetChecked(quest.localStore);

    if (quest.filterClass) then
      MQWizard_ClassFilterCheck:SetChecked(1);
      MQWizard_ClassFilterEntry:SetText(quest.filterClass);
    end
    if (quest.filterGuild) then
      MQWizard_GuildFilterCheck:SetChecked(1);
      MQWizard_GuildFilterEntry:SetText(quest.filterGuild);
    end
    if (quest.filterLevelMin or quest.filterLevelMax) then
      MQWizard_LevelFilterCheck:SetChecked(1);
      MQWizard_MinLevelFilterEntry:SetText(quest.filterLevelMin);
      MQWizard_MaxLevelFilterEntry:SetText(quest.filterLevelMax);
    end
    if (quest.filterPlayer) then
      MQWizard_PlayerFilterCheck:SetChecked(1);
      MQWizard_PlayerFilterEntry:SetText(quest.filterPlayer);
    end
    if (quest.filterRace) then
      MQWizard_RaceFilterCheck:SetChecked(1);
      MQWizard_RaceFilterEntry:SetText(quest.filterRace);
    end
    
    MQWizard_DescEntry:SetText(mq.TranslateCarriageReturn(quest.descText, true));
    MQWizard_SummaryEntry:SetText(mq.TranslateCarriageReturn(quest.summaryText, true));
    MQWizard_ProgressEntry:SetText(mq.TranslateCarriageReturn(quest.progressText, true));
    MQWizard_CompleteEntry:SetText(mq.TranslateCarriageReturn(quest.completeText, true));

    -- populate the objective information
    count = 1;

    if (quest.objectiveMoney > 0) then
      UIDropDownMenu_SetSelectedValue(getglobal("MQWizard_Objective" .. count .. "DropDown"), "Money");
      MQWizard_CommonObjectiveDropDown_OnClick("MQWizard_Objective" .. count, "Money");

      mq.QuestObjectives["Money"].SetEditor(quest.objectiveMoney, "MQWizard_Objective" .. count);
      
      count = count + 1;
    end

    for i=1, 6-count, 1 do
      if (quest.objectives[i] ~= nil) then
        UIDropDownMenu_SetSelectedValue(getglobal("MQWizard_Objective" .. count .. "DropDown"), quest.objectives[i].type);
        MQWizard_CommonObjectiveDropDown_OnClick("MQWizard_Objective" .. count, quest.objectives[i].type);

        local tmpType = quest.objectives[i].type;
        mq.QuestObjectives[tmpType].SetEditor(quest.objectives[i], "MQWizard_Objective" .. count)
      else
        UIDropDownMenu_SetSelectedValue(getglobal("MQWizard_Objective" .. count .. "DropDown"), "None");
        MQWizard_CommonObjectiveDropDown_OnClick("MQWizard_Objective" .. count, "None");
      end
      count = count + 1;
    end

    count = 1;
    
    if (quest.rewardMoney > 0) then
      UIDropDownMenu_SetSelectedValue(getglobal("MQWizard_Reward" .. count .. "DropDown"), "Money");
      MQWizard_CommonRewardDropDown_OnClick("MQWizard_Reward" .. count, "Money");

      mq.QuestRewards["Money"].SetEditor(quest.rewardMoney, "MQWizard_Reward" .. count);
      
      count = count + 1;
    end

    for i=1, 6-count, 1 do
      if (quest.rewards[i] ~= nil) then
        UIDropDownMenu_SetSelectedValue(getglobal("MQWizard_Reward" .. count .. "DropDown"), quest.rewards[i].type);
        MQWizard_CommonRewardDropDown_OnClick("MQWizard_Reward" .. count, quest.rewards[i].type);

        local tmpType = quest.rewards[i].type;
        mq.QuestRewards[tmpType].SetEditor(quest.rewards[i], "MQWizard_Reward" .. count)
      else
        UIDropDownMenu_SetSelectedValue(getglobal("MQWizard_Reward" .. count .. "DropDown"), "None");
        MQWizard_CommonRewardDropDown_OnClick("MQWizard_Reward" .. count, "None");
      end
      count = count + 1;
    end
  else
    MyQuestsWizard_Parent.quest = nil;
    
    MQWizard_CreateTitleEntry:SetText("");
    MQWizard_CreateLevelEntry:SetText("");

    UIDropDownMenu_SetSelectedValue(getglobal("MQWizard_ChainDropDown"), "none");

    MQWizard_FailureDeathToggle:SetChecked(0);
    MQWizard_FailureTimeToggle:SetChecked(0);
    MQWizard_FailureTimeEntry:SetText(0);

    MQWizard_CompleteRepeatableToggle:SetChecked(0);
    MQWizard_CompleteLocalStoreToggle:SetChecked(0);

    MQWizard_ClassFilterCheck:SetChecked(0);
    MQWizard_ClassFilterEntry:SetText("");

    MQWizard_GuildFilterCheck:SetChecked(0);
    MQWizard_GuildFilterEntry:SetText("");

    MQWizard_LevelFilterCheck:SetChecked(0);
    MQWizard_MinLevelFilter:SetText("");
    MQWizard_MaxLevelFilter:SetText("");

    MQWizard_PlayerFilterCheck:SetChecked(0);
    MQWizard_PlayerFilterEntry:SetText("");

    MQWizard_RaceFilterCheck:SetChecked(0);
    MQWizard_RaceFilterEntry:SetText("");
    
    MQWizard_DescEntry:SetText("");
    MQWizard_SummaryEntry:SetText("");
    MQWizard_ProgressEntry:SetText("");
    MQWizard_CompleteEntry:SetText("");

    -- populate the objectives and rewards
    for i=1, 5, 1 do
      UIDropDownMenu_SetSelectedValue(getglobal("MQWizard_Objective" .. i .. "DropDown"), "None");
      MQWizard_CommonObjectiveDropDown_OnClick("MQWizard_Objective" .. i, "None");

      UIDropDownMenu_SetSelectedValue(getglobal("MQWizard_Reward" .. i .. "DropDown"), "None");
      MQWizard_CommonRewardDropDown_OnClick("MQWizard_Reward" .. i, "None");
    end
  end
end

--[[ ********************************************************************* --]]
function mq.CreateOrUpdateQuest()
  local count = 1;
  
  local quest, updating = {}, false;
  if (MyQuestsWizard_Parent.quest) then
    quest, updating = MyQuestsWizard_Parent.quest, true;
  end
  
  -- copy info from wizard here
  
  -- unique quest id
  if (not updating) then
    quest.id = UnitName("player") .. time();
  end
  
  quest.title = MQWizard_CreateTitleEntry:GetText();
  quest.level = tonumber(MQWizard_CreateLevelEntry:GetText());
  if (quest.level == nil) then
    quest.level = 0;
  end

  if (MQWizard_FailureTimeToggle:GetChecked()) then
    quest.timeLeft = tonumber(MQWizard_FailureTimeEntry:GetText()) * 60;
  else
    quest.timeLeft = nil;
  end
  quest.failOnDeath = MQWizard_FailureDeathToggle:GetChecked();

  quest.isRepeatable = MQWizard_CompleteRepeatableToggle:GetChecked();
  quest.localStore = MQWizard_CompleteLocalStoreToggle:GetChecked();

  quest.parent = UIDropDownMenu_GetSelectedValue(MQWizard_ChainDropDown);

  if (MQWizard_ClassFilterCheck:GetChecked() == 1) then
    quest.filterClass = MQWizard_ClassFilterEntry:GetText();
  else
    quest.filterClass = nil;
  end
  if (MQWizard_GuildFilterCheck:GetChecked() == 1) then
    quest.filterGuild = MQWizard_GuildFilterEntry:GetText();
  else
    quest.filterGuild = nil;
  end
  if (MQWizard_LevelFilterCheck:GetChecked() == 1) then
    quest.filterLevelMin = tonumber(MQWizard_MinLevelFilter:GetText());
    quest.filterLevelMax = tonumber(MQWizard_MaxLevelFilter:GetText());
  else
    quest.filterLevelMin = nil;
    quest.filterLevelMax = nil;
  end
  if (MQWizard_PlayerFilterCheck:GetChecked() == 1) then
    quest.filterPlayer = MQWizard_PlayerFilterEntry:GetText();
  else
    quest.filterPlayer = nil;
  end
  if (MQWizard_RaceFilterCheck:GetChecked() == 1) then
    quest.filterRace = MQWizard_RaceFilterEntry:GetText();
  else
    quest.filterRace = nil;
  end

  quest.descText = mq.TranslateCarriageReturn(MQWizard_DescEntry:GetText());
  quest.summaryText = mq.TranslateCarriageReturn(MQWizard_SummaryEntry:GetText());
  quest.progressText = mq.TranslateCarriageReturn(MQWizard_ProgressEntry:GetText());
  quest.completeText = mq.TranslateCarriageReturn(MQWizard_CompleteEntry:GetText());

  quest.finishPlayers = {};
  quest.finishPlayers[1] = UnitName("player");

  quest.objectiveMoney = 0;
  quest.rewardMoney = 0;

  -- create the objective set for this quest
  quest.objectives = {};
  count = 1;
  for i=1, 5, 1 do
    local refString = "MQWizard_Objective" .. i;
    local ddref = getglobal(refString .. "DropDown");
    local type = UIDropDownMenu_GetSelectedValue(ddref);

    local passed = 1;

    if (type ~= "None") then
      if (type == "Money") then
        --mq.QuestObjectives[type].OnCreateOrEdit(quest.objectiveMoney, refString);
        quest.objectiveMoney = MoneyInputFrame_GetCopper(getglobal(refString .. "RequiredMoney"));
      else
        if (quest.objectives[count] == nil) then
          quest.objectives[count] = {};
        end
        passed = mq.QuestObjectives[type].OnCreateOrEdit(quest.objectives[count], refString);
        
        if (passed) then
          count = count + 1;
        end
      end
    else
      quest.objectives[count] = nil;
    end
    
    -- clear out any "hidden" variables
    getglobal(refString).item = nil;
    
    -- reset the objective entry in the wizard
    MQWizard_ObjectiveDropDown_Reset(refString);
  end
  for i=count, 5, 1 do
    quest.objectives[i] = nil;
  end

  -- create the rewards for this quest
  quest.rewards = {};
  count = 1;
  for i=1, 5, 1 do
    local refString = "MQWizard_Reward" .. i;
    local ddref = getglobal(refString .. "DropDown");
    local type = UIDropDownMenu_GetSelectedValue(ddref);
    
    if (type ~= "None") then
      if (type == "Money") then
        --mq.QuestRewards[type].OnCreateOrEdit(quest.rewardMoney, refString);
        quest.rewardMoney = MoneyInputFrame_GetCopper(getglobal(refString .. "RewardMoney"));
      else
        if (quest.rewards[count] == nil) then
          quest.rewards[count] = {};
        end
        mq.QuestRewards[type].OnCreateOrEdit(quest.rewards[count], refString);
        count = count + 1;
      end
    else
      quest.rewards[count] = nil;
    end
  end
  for i=count, 5, 1 do
    quest.rewards[i] = nil;
  end
  
  quest.rewardChoices = {};
  
  -- add the quest to the data block
  if (updating == false) then
    table.insert(myquests.Quests, quest);
  end
  
  -- close the UI panel
  HideUIPanel(MyQuestsWizard_Parent);
  -- clear out the previous data
  MyQuestsWizard_OnCancel();
end



--[[ ********************************************************************* --]]
function mq.CheckQuestComplete(quest)
  if (not quest.isComplete and not quest.isFailed) then
    quest.isComplete = 1;

    mq.IO.dprint("Checking for complete quest, of " .. table.getn(quest.objectives) .. " objectives.");
    for i=1, table.getn(quest.objectives), 1 do
      local tmpGoal = quest.objectives[i];
      
      if (tmpGoal.isComplete) then
        mq.IO.dprint(tmpGoal.type .. " goal = ");
      end
      
      if (not tmpGoal.isComplete) then
        --mq.IO.dprint(tmpGoal.type .. " not complete!  Failing quest.");
        quest.isComplete = nil;
        break;
      end
    end
    
    --if (quest.timeLeft and quest.timeLeft > 0) then
    --  quest.isComplete = nil;
    --end
    
    mq.OnGlobalEvent("QUEST_LOG_UPDATE");
  end
end

--[[ ********************************************************************* --]]
mq.QuestObjectives = {};

mq.QuestObjectives.GetLeaderBoard = function(objective, strIn)
  local strOut = strIn;
  
  -- replace %n with the "Name" value
  if (objective.name) then
    strOut = string.gsub(strOut, "%%n", objective.name);
  end

  -- replace %f with the proper faction string
  local faction = "Alliance";
  if (UnitFactionGroup("player") == faction) then
    faction = "Horde";
  end
  strOut = string.gsub(strOut, "%%f", faction);  

  -- add the count tracking to the end, if needed
  if (objective.total) then
    strOut = string.gsub(strOut, "%%i", objective.count);
    strOut = string.gsub(strOut, "%%c", objective.total);
  end  
  
  return strOut;
end

--[[ ********************************************************************* --]]
mq.QuestObjectives.Explore = {};
mq.QuestObjectives.Explore.OnCreateOrEdit = function(objective, refString)
  local name = string.trim(getglobal(refString .. "NameBox"):GetText());
  if (name ~= nil and name ~= "") then
    objective.type = "Explore";
    objective.name = name;
    objective.leaderBoard = 1;
    return 1;
  end
  
  return nil;
end
mq.QuestObjectives.Explore.OnUpdate = function(objective)
  if (not objective.isComplete) then
    if (GetZoneText() == objective.name or GetSubZoneText() == objective.name) then
      objective.isComplete = 1;
      mq.IO.banner(mq.QuestObjectives.GetLeaderBoard(objective, MQ_MSG_QUESTUPDATE_AREA));
    end
  end
end
mq.QuestObjectives.Explore.GetLeaderBoard = function(objective)
  return mq.QuestObjectives.GetLeaderBoard(objective, MQ_LEADERBOARD_AREA);
end
mq.QuestObjectives.Explore.SetEditor = function(objective, refString)
  getglobal(refString .. "NameBox"):SetText(objective.name);
end

--[[ ********************************************************************* --]]
mq.QuestObjectives.Money = {};
mq.QuestObjectives.Money.OnCreateOrEdit = function(objective, refString)
  objective = MoneyInputFrame_GetCopper(getglobal(refString .. "RequiredMoney"));
end
mq.QuestObjectives.Money.OnUpdate = function(objective)
  if (not objective.isComplete) then
    if (GetMoney() >= objective.copper) then
      objective.isComplete = 1;
    end 
  end
end
mq.QuestObjectives.Money.OnTurnIn = function(objective)
  -- TODO: make sure a trade window is open
  SetTradeMoney(objective);
end
mq.QuestObjectives.Money.SetEditor = function(objective, refString)
  MoneyInputFrame_SetCopper(getglobal(refString .. "RequiredMoney"), objective);
end

--[[ ********************************************************************* --]]
mq.QuestObjectives.KillMonster = {};
mq.QuestObjectives.KillMonster.OnCreateOrEdit = function(objective, refString)
  local name = string.trim(getglobal(refString .. "NameBox"):GetText());
  if (name ~= nil and name ~= "") then
    objective.type = "KillMonster";
    objective.name = name;  

    objective.total = tonumber(getglobal(refString .. "CountBox"):GetText());
    if (not objective.total or objective.total == 0) then
      objective.total = 1;
    end
    objective.count = 0;

    objective.leaderBoard = 1;
    
    return 1;
  end
  
  return nil;
end
mq.QuestObjectives.KillMonster.OnUpdate = function(objective)
  if (objective.count < objective.total) then
    objective.count = objective.count + 1;
    if (objective.count >= objective.total) then
      objective.isComplete = 1;
    end
    mq.IO.banner(mq.QuestObjectives.GetLeaderBoard(objective, MQ_MSG_QUESTUPDATE_MONSTER));
  end
end
mq.QuestObjectives.KillMonster.GetLeaderBoard = function(objective)
  return mq.QuestObjectives.GetLeaderBoard(objective, MQ_LEADERBOARD_MONSTER);
end
mq.QuestObjectives.KillMonster.SetEditor = function(objective, refString)
  getglobal(refString .. "NameBox"):SetText(objective.name);
  getglobal(refString .. "CountBox"):SetText(objective.total);
end

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
mq.QuestObjectives.Duel = {};
mq.QuestObjectives.Duel.OnCreateOrEdit = function(objective, refString)
  objective.minLevel = tonumber(getglobal(refString .. "MinLevel"));
  objective.maxLevel = tonumber(getglobal(refString .. "MaxLevel"));

  objective.total = tonumber(getglobal(refString .. "CountBox"):GetText());
  if (not objective.total or objective.total == 0) then
    objective.total = 1;
  end
  objective.count = 0;

  objective.location = nil; -- future use: duel to be carried out in specific place
  objective.leaderBoard = 1;
end
mq.QuestObjectives.Duel.SetEditor = function(objective, refString)
  getglobal(refString .. "MinLevel"):SetText(objective.minLevel);
  getglobal(refString .. "MaxLevel"):SetText(objective.maxLevel);
  getglobal(refString .. "CountBox"):SetText(objective.total);
end

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
mq.QuestObjectives.DuelAny = {};
mq.QuestObjectives.DuelAny.OnCreateOrEdit = function(objective, refString)
  objective.type = "DuelAny";

  mq.QuestObjectives.Duel.OnCreateOrEdit(objective, refString);
end
mq.QuestObjectives.DuelAny.OnUpdate = function(objective)
  if (objective.count < objective.total) then
    -- check the level of the dueled player
    if ((objective.minLevel and mq.TargetInfo.level < objective.minLevel) or
        (objective.maxLevel and mq.TargetInfo.level > objective.maxLevel)) then
      return;
    end
    
    objective.count = objective.count + 1;
    if (objective.count >= objective.total) then
      objective.isComplete = 1;
      mq.IO.print("objective complete");
    end
  end
end
mq.QuestObjectives.DuelAny.GetLeaderBoard = function(objective)
  return mq.QuestObjectives.GetLeaderBoard(objective, MQ_LEADERBOARD_DUEL_ANY);
end
mq.QuestObjectives.DuelAny.SetEditor = function(objective, refString)
  mq.QuestObjectives.Duel.SetEditor(objective, refString);
end

--[[ ********************************************************************* --]]
mq.QuestObjectives.DuelClass = {};
mq.QuestObjectives.DuelClass.OnCreateOrEdit = function(objective, refString)
  local name = string.trim(getglobal(refString .. "NameBox"):GetText());
  if (name ~= nil and name ~= "") then
    objective.type = "DuelClass";
    mq.QuestObjectives.Duel.OnCreateOrEdit(objective, refString);
    objective.name = name;  

    return 1;
  end
  
  return nil;
end
mq.QuestObjectives.DuelClass.OnUpdate = function(objective)
  if (mq.TargetInfo.class == objective.name) then
    mq.QuestObjectives.DuelAny.OnUpdate(objective);
  end
end
mq.QuestObjectives.DuelClass.GetLeaderBoard = function(objective)
  return mq.QuestObjectives.GetLeaderBoard(objective, MQ_LEADERBOARD_DUEL_CLASS);
end
mq.QuestObjectives.DuelClass.SetEditor = function(objective, refString)
  getglobal(refString .. "NameBox"):SetText(objective.name);
  mq.QuestObjectives.Duel.SetEditor(objective, refString);
end

--[[ ********************************************************************* --]]
mq.QuestObjectives.DuelGuild = {};
mq.QuestObjectives.DuelGuild.OnCreateOrEdit = function(objective, refString)
  local name = string.trim(getglobal(refString .. "NameBox"):GetText());
  if (name ~= nil and name ~= "") then
    objective.type = "DuelGuild";
    mq.QuestObjectives.Duel.OnCreateOrEdit(objective, refString);
    objective.name = nil;  

    return 1;
  end

  return nil;
end
mq.QuestObjectives.DuelGuild.OnUpdate = function(objective)
  if (mq.TargetInfo.guild == objective.name) then
    mq.QuestObjectives.DuelAny.OnUpdate(objective);
  end
end
mq.QuestObjectives.DuelGuild.GetLeaderBoard = function(objective)
  return mq.QuestObjectives.GetLeaderBoard(objective, MQ_LEADERBOARD_DUEL_GUILD);
end

mq.QuestObjectives.DuelGuild.SetEditor = function(objective, refString)
  getglobal(refString .. "NameBox"):SetText(objective.name);
  mq.QuestObjectives.Duel.SetEditor(objective, refString);
end

--[[ ********************************************************************* --]]
mq.QuestObjectives.DuelPlayer = {};
mq.QuestObjectives.DuelPlayer.OnCreateOrEdit = function(objective, refString)
  local name = string.trim(getglobal(refString .. "NameBox"):GetText());
  if (name ~= nil and name ~= "") then
    objective.type = "DuelPlayer";
    mq.QuestObjectives.Duel.OnCreateOrEdit(objective, refString);
    objective.name = name;  
    
    return 1;
  end
  
  return nil;
end
mq.QuestObjectives.DuelPlayer.OnUpdate = function(objective)
  if (mq.TargetInfo.name == objective.name) then
    mq.QuestObjectives.DuelAny.OnUpdate(objective);
  end
end
mq.QuestObjectives.DuelPlayer.GetLeaderBoard = function(objective)
  return mq.QuestObjectives.GetLeaderBoard(objective, MQ_LEADERBOARD_DUEL_SPECIFIC);
end
mq.QuestObjectives.DuelPlayer.SetEditor = function(objective, refString)
  getglobal(refString .. "NameBox"):SetText(objective.name);
  mq.QuestObjectives.Duel.SetEditor(objective, refString);
end

--[[ ********************************************************************* --]]
mq.QuestObjectives.DuelRace = {};
mq.QuestObjectives.DuelRace.OnCreateOrEdit = function(objective, refString)
  local name = string.trim(getglobal(refString .. "NameBox"):GetText());
  if (name ~= nil and name ~= "") then
    objective.type = "DuelRace";
    mq.QuestObjectives.Duel.OnCreateOrEdit(objective, refString);
    objective.name = getglobal(refString .. "NameBox"):GetText();  

    return 1;
  end

  return nil;
end
mq.QuestObjectives.DuelRace.OnUpdate = function(objective)
  if (mq.TargetInfo.race == objective.name) then
    mq.QuestObjectives.DuelAny.OnUpdate(objective);
  end
end
mq.QuestObjectives.DuelRace.GetLeaderBoard = function(objective)
  return mq.QuestObjectives.GetLeaderBoard(objective, MQ_LEADERBOARD_DUEL_RACE);
end
mq.QuestObjectives.DuelRace.SetEditor = function(objective, refString)
  getglobal(refString .. "NameBox"):SetText(objective.name);
  mq.QuestObjectives.Duel.SetEditor(objective, refString);
end

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
mq.QuestObjectives.Pvp = {};
mq.QuestObjectives.Pvp.OnCreateOrEdit = function(objective, refString)
  objective.total = tonumber(getglobal(refString .. "CountBox"):GetText());
  if (not objective.total or objective.total == 0) then
    objective.total = 1;
  end
  objective.count = 0;

  objective.location = nil; -- future use: duel to be carried out in specific place
  objective.leaderBoard = 1;
  
  return 1;
end
mq.QuestObjectives.Pvp.SetEditor = function(objective, refString)
  getglobal(refString .. "CountBox"):SetText(objective.total);
end

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
mq.QuestObjectives.PvpAny = {};
mq.QuestObjectives.PvpAny.OnCreateOrEdit = function(objective, refString)
  objective.type = "PvpAny";
  mq.QuestObjectives.Pvp.OnCreateOrEdit(objective, refString);
  
  return 1;
end
mq.QuestObjectives.PvpAny.OnUpdate = mq.QuestObjectives.DuelAny.OnUpdate;
mq.QuestObjectives.PvpAny.GetLeaderBoard = function(objective)
  return mq.QuestObjectives.GetLeaderBoard(objective, MQ_LEADERBOARD_PVP_ANY);
end
mq.QuestObjectives.PvpAny.SetEditor = function(objective, refString)
  mq.QuestObjectives.Pvp.SetEditor(objective, refString);
end

--[[ ********************************************************************* --]]
mq.QuestObjectives.PvpClass = {};
mq.QuestObjectives.PvpClass.OnCreateOrEdit = function(objective, refString)
  local name = string.trim(getglobal(refString .. "NameBox"):GetText());
  if (name ~= nil and name ~= "") then
    objective.type = "PvpClass";
    mq.QuestObjectives.Pvp.OnCreateOrEdit(objective, refString);
    objective.name = name;

    return 1;
  end
  
  return nil;
end
mq.QuestObjectives.PvpClass.OnUpdate = mq.QuestObjectives.DuelClass.OnUpdate;
mq.QuestObjectives.PvpClass.GetLeaderBoard = function(objective)
  return mq.QuestObjectives.GetLeaderBoard(objective, MQ_LEADERBOARD_PVP_CLASS);
end
mq.QuestObjectives.PvpClass.SetEditor = function(objective, refString)
  getglobal(refString .. "NameBox"):SetText(objective.name);
  mq.QuestObjectives.Pvp.SetEditor(objective, refString);
end

--[[ ********************************************************************* --]]
mq.QuestObjectives.PvpGuild = {};
mq.QuestObjectives.PvpGuild.OnCreateOrEdit = function(objective, refString)
  local name = string.trim(getglobal(refString .. "NameBox"):GetText());
  if (name ~= nil and name ~= "") then
    objective.type = "PvpGuild";
    mq.QuestObjectives.Pvp.OnCreateOrEdit(objective, refString);
    objective.name = getglobal(refString .. "NameBox"):GetText();

    return 1;
  end
  
  return nil;
end
mq.QuestObjectives.PvpGuild.OnUpdate = mq.QuestObjectives.DuelGuild.OnUpdate;
mq.QuestObjectives.PvpGuild.GetLeaderBoard = function(objective)
  return mq.QuestObjectives.GetLeaderBoard(objective, MQ_LEADERBOARD_PVP_GUILD);
end
mq.QuestObjectives.PvpGuild.SetEditor = function(objective, refString)
  getglobal(refString .. "NameBox"):SetText(objective.name);
  mq.QuestObjectives.Pvp.SetEditor(objective, refString);
end

--[[ ********************************************************************* --]]
mq.QuestObjectives.PvpPlayer = {};
mq.QuestObjectives.PvpPlayer.OnCreateOrEdit = function(objective, refString)
  local name = string.trim(getglobal(refString .. "NameBox"):GetText());
  if (name ~= nil and name ~= "") then
    objective.type = "PvpPlayer";
    mq.QuestObjectives.Pvp.OnCreateOrEdit(objective, refString);
    objective.name = name;

    return 1;
  end
  
  return nil;
end
mq.QuestObjectives.PvpPlayer.OnUpdate = function(objective)
  -- arg2 == creep?
  if (arg2 == objective.name) then
    mq.QuestObjectives.PvpAny.OnUpdate(objective);
  end
end
mq.QuestObjectives.PvpPlayer.GetLeaderBoard = function(objective)
  return mq.QuestObjectives.GetLeaderBoard(objective, MQ_LEADERBOARD_PVP_SPECIFIC);
end
mq.QuestObjectives.PvpPlayer.SetEditor = function(objective, refString)
  getglobal(refString .. "NameBox"):SetText(objective.name);
  mq.QuestObjectives.Pvp.SetEditor(objective, refString);
end

--[[ ********************************************************************* --]]
mq.QuestObjectives.PvpRace = {};
mq.QuestObjectives.PvpRace.OnCreateOrEdit = function(objective, refString)
  local name = string.trim(getglobal(refString .. "NameBox"):GetText());
  if (name ~= nil and name ~= "") then
    objective.type = "PvpRace";
    mq.QuestObjectives.Pvp.OnCreateOrEdit(objective, refString);
    objective.name = name;

    return 1;
  end
  
  return nil;
end
mq.QuestObjectives.PvpRace.OnUpdate = mq.QuestObjectives.DuelRace.OnUpdate;
mq.QuestObjectives.PvpRace.GetLeaderBoard = function(objective)
  return mq.QuestObjectives.GetLeaderBoard(objective, MQ_LEADERBOARD_PVP_RACE);
end
mq.QuestObjectives.PvpRace.SetEditor = function(objective, refString)
  getglobal(refString .. "NameBox"):SetText(objective.name);
  mq.QuestObjectives.Pvp.SetEditor(objective, refString);
end

--[[ ********************************************************************* --]]
mq.QuestObjectives.GatherItem = {};
mq.QuestObjectives.GatherItem.OnCreateOrEdit = function(objective, refString)
  local objRef = getglobal(refString);

  if (objRef.item ~= nil) then
    objective.type = "GatherItem";

    objective.total = tonumber(getglobal(refString .. "CountBox"):GetText());
    if (not objective.total or objective.total == 0) then
      objective.total = 1;
    end
    objective.count = 0;

    objective.name    = objRef.item.name;
    --objective.texture = objRef.item.texture;

    objective.item = {};
    objective.item.color = string.gsub(objRef.item.link, "|cff(.*)|H(.*)|h(.*)|h|r.*", "%1");
    objective.item.link = string.gsub(objRef.item.link, "|cff(.*)|H(.*)|h(.*)|h|r.*", "%2");
    objective.item.texture = objRef.item.texture;

    if (getglobal(refString .. "ItemNoTrade"):GetChecked()) then
      objective.noTrade = 1;
    else
      objective.noTrade = nil;
    end

    if (getglobal(refString .. "ItemNoDisplay"):GetChecked()) then
    else
      objective.leaderBoard = 1;
    end

    return 1;
  end
  
  return nil;
end
mq.QuestObjectives.GatherItem.OnUpdate = function(objective)
  -- code is handled in the BagUpdate function
end
mq.QuestObjectives.GatherItem.GetLeaderBoard = function(objective)
  return mq.QuestObjectives.GetLeaderBoard(objective, MQ_LEADERBOARD_GATHER_ITEM);
end
mq.QuestObjectives.GatherItem.OnTurnIn = function(objective)
  -- break if we are not to trade items
  if (objective.noTrade) then
    mq.IO.print("no trade!");
    return;
  end
  
  local bagIndex, slotIndex = mq.CompileItemStack(objective.item.link, objective.total);

  mq.IO.print(bagIndex .. " - " .. slotIndex);

  mq.ScheduleForCall(mq.tradestep2, {bagIndex, slotIndex}, 1, 1);
  --local _, itemCount = GetContainerItemInfo(bagIndex, slotIndex);
  --PickupContainerItem(bagIndex, slotIndex);

  -- TODO: FIRE AN ERROR IF NEEDED

  mq.ScheduleForCall(mq.tradestep3, {}, 1, 1);
  --for i=1, 5, 1 do
  --  if (GetTradePlayerItemLink(i) == nil) then
  --    ClickTradeButton(i);
  --    break;
  --  end
  --end
end

function mq.tradestep2(bagIndex, slotIndex)
  local _, itemCount = GetContainerItemInfo(bagIndex, slotIndex);
  mq.IO.print("picking up " .. bagIndex .. " - " .. slotIndex);
  PickupContainerItem(bagIndex, slotIndex);
end

function mq.tradestep3()
  mq.IO.print("placing item");
  for i=1, 5, 1 do
    if (GetTradePlayerItemLink(i) == nil) then
      ClickTradeButton(i);
      break;
    end
  end
end

mq.QuestObjectives.GatherItem.SetEditor = function(objective, refString)
  getglobal(refString .. "CountBox"):SetText(objective.total);
  getglobal(refString .. "ItemBoxIcon"):SetTexture(objective.item.texture);

  local objRef = getglobal(refString);

  objRef.item = {}
  objRef.item.name = objective.name;
  objRef.item.link = objective.item.link;
  objRef.item.texture = objective.item.texture;
  objRef.item.isUseable = objective.item.isUseable;
end

--[[ ********************************************************************* --]]
mq.QuestObjectives.Tame = {};
mq.QuestObjectives.Tame.OnCreateOrEdit = function(objective, refString)
  local name = string.trim(getglobal(refString .. "NameBox"):GetText());
  if (name ~= nil and name ~= "") then
    objective.type = "Tame";
    objective.name = name;  

    --[[
    objective.total = tonumber(getglobal(refString .. "CountBox"):GetText());
    if (not objective.total or objective.total == 0) then
      objective.total = 1;
    end
    objective.count = 0;
    --]]
    
    objective.leaderBoard = 1;
    
    return 1;
  end
  
  return nil;
end
mq.QuestObjectives.Tame.OnUpdate = function(objective)
  objective.isComplete = 1;
end
mq.QuestObjectives.Tame.GetLeaderBoard = function(objective)
  return mq.QuestObjectives.GetLeaderBoard(objective, MQ_LEADERBOARD_TAME);
end
mq.QuestObjectives.Tame.SetEditor = function(objective, refString)
  getglobal(refString .. "NameBox"):SetText(objective.name);
end

--[[ ********************************************************************* --]]
mq.QuestRewards = {};

--[[ ********************************************************************* --]]
mq.QuestRewards.GuildPromotion = {};
mq.QuestRewards.GuildPromotion.OnCreateOrEdit = function(reward, refString)
  reward.type = "GuildPromotion";
end
mq.QuestRewards.GuildPromotion.OnTurnIn = function(reward, player)
  GuildPromoteByName(player);
end

mq.QuestRewards.GuildInvite = {};
mq.QuestRewards.GuildInvite.OnCreateOrEdit = function(reward, refString)
  reward.type = "GuildInvite";
end
mq.QuestRewards.GuildInvite.OnTurnIn = function(reward, player)
  GuildInviteByName(player);
end

mq.QuestRewards.ItemReward = {};
mq.QuestRewards.ItemReward.OnCreateOrEdit = function(reward, refString)
  local objRef = getglobal(refString);

  if (objRef.item ~= nil) then
    reward.type = "ItemReward";

    reward.total = tonumber(getglobal(refString .. "CountBox"):GetText());
    if (not reward.total or reward.total == 0) then
      reward.total = 1;
    end
    reward.count = 0;

    reward.name    = objRef.item.name;

    reward.item = {};
    reward.item.color = string.gsub(objRef.item.link, "|cff(.*)|H(.*)|h(.*)|h|r.*", "%1");
    reward.item.link = string.gsub(objRef.item.link, "|cff(.*)|H(.*)|h(.*)|h|r.*", "%2");
    reward.item.texture = objRef.item.texture;
    reward.item.isUseable = objRef.item.isUseable;
    
    mq.IO.dprint(reward.item.link);

    return 1;
  else
    mq.IO.error("Item slot has nil value");
  end
  
  return nil;
end
mq.QuestRewards.ItemReward.OnTurnIn = function(reward)
  local bagIndex, slotIndex = mq.CompileItemStack(reward.item.link, reward.total);

  mq.ScheduleForCall(mq.tradestep2, {bagIndex, slotIndex}, 1, 1);

  -- TODO: FIRE AN ERROR IF NEEDED

  mq.ScheduleForCall(mq.tradestep3, {}, 1, 1);
end
mq.QuestRewards.ItemReward.SetEditor = function(reward, refString)
  getglobal(refString .. "CountBox"):SetText(reward.total);
  getglobal(refString .. "ItemBoxIcon"):SetTexture(reward.item.texture);

  local objRef = getglobal(refString);

  objRef.item = {}
  objRef.item.name = reward.name;
  objRef.item.link = reward.item.link;
  objRef.item.texture = reward.item.texture;
  objRef.item.isUseable = reward.item.isUseable;
end

mq.QuestRewards.Money = {};
mq.QuestRewards.Money.OnCreateOrEdit = function(reward, refString)
  reward = MoneyInputFrame_GetCopper(getglobal(refString .. "RewardMoney"));
end
mq.QuestRewards.Money.OnTurnIn = function(reward)
  -- TODO: make sure a trade window is open
  SetTradeMoney(reward);
end
mq.QuestRewards.Money.SetEditor = function(reward, refString)
  MoneyInputFrame_SetCopper(getglobal(refString .. "RewardMoney"), reward);
end

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
mq.IO = {};
mq.IO = {
  DEFAULT_ERROR_COLOR = RED_FONT_COLOR;
  DEFAULT_PRINT_COLOR = NORMAL_FONT_COLOR;

  DebugTarget = nil;
  
  --[[ ******************************************************************* --]]
  --[[ mq.IO.dprint                                                        --]]
  --[[   Central debugging call.                                           --]]
  --[[ ******************************************************************* --]]
  dprint = function(message)
    if mq.IO.DebugTarget then
      if mq.IO.DebugTarget == mq.PlayerName then
        mq.IO.print(message, mq.IO.DEFAULT_PRINT_COLOR);
      else
        SendChatMessage(message, "WHISPER", nil, mq.IO.DebugTarget);
      end
    end
  end;

  --[[ ******************************************************************* --]]
  --[[ mq.IO.error                                                         --]]
  --[[ ******************************************************************* --]]
  error = function(message)
    mq.IO.print(message, mq.IO.DEFAULT_ERROR_COLOR);
  end;

  --[[ ******************************************************************* --]]
  --[[ mq.IO.print                                                         --]]
  --[[ ******************************************************************* --]]
  print = function(message, color)
    --if (color == nil) then
      color = mq.IO.DEFAULT_PRINT_COLOR;
    --end
    if (message == nil) then
      message = "<nil>";
    end
    DEFAULT_CHAT_FRAME:AddMessage(message, color.r, color.g, color.b);
  end;

  --[[ ******************************************************************* --]]
  --[[ mq.IO.banner                                                        --]]
  --[[ ******************************************************************* --]]
  banner = function(message, color)
    if (color == nil) then
      color = mq.IO.DEFAULT_PRINT_COLOR;
    end
    UIErrorsFrame:AddMessage(message, color.r, color.g, color.b, 1.0, UIERRORS_HOLD_TIME);
  end;
};
