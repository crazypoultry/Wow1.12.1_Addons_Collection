local WINTERREP_VERSION = "0.8";
local WINTERREP_EXHALTED = 42000;

function WinterRep_OnLoad()
	this:RegisterEvent("QUEST_LOG_UPDATE");
	-- Register our slash command
	SLASH_WINTERREP1 = "/wr";
	SlashCmdList["WINTERREP"] = WinterRep_Slash

	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage("WinterRep v"..WINTERREP_VERSION.." loaded.");
	end
end

function WinterRep_Slash(arg1)
  if (arg1 ~= "") then
    WinterRep_Spam(arg1);
  else
    WinterRep_ToggleUI();
  end
end

function WinterRep_OnEvent(event)
  if (event == "QUEST_LOG_UPDATE") then
    --WinterRep_debug("QUEST_LOG_UPDATE called");
    WinterRep_UpdateRep();
    WinterRep_UpdateQuest();
    WinterRep_UpdateStats();
  end
end

function WinterRep_ToggleUI()
  if (WinterRepFrame:IsShown()) then
    WinterRepFrame:Hide();
  else
    WinterRepFrame:Show();
  end
end

function WinterRep_UpdateQuest(arg1)
  local found = false;
  local output = "";
  for i = 0, GetNumQuestLogEntries() do
    local questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete = GetQuestLogTitle(i);
    if (isCollapsed and questLogTitleText == "Winterspring") then
      ExpandQuestHeader(i);
    end
    if (questLogTitleText and string.find(questLogTitleText, "Winterfall Intrusion")) then
      found = true;
      SelectQuestLogEntry(i);
      -- get Shaman
      local text, typ, finished = GetQuestLogLeaderBoard(1);
      for item, now, max in string.gfind(text,"([^:]+): (%d+)/(%d+)$") do
        if (item and now and max) then
          local color = "bbbbbb";
          if (now == "0") then
            color = "dd0000"; -- red
          elseif (now == "1") then
            color = "ffcc33"; -- orange
          elseif (now == "2") then
            color = "ffff00"; -- yellow
          elseif (now == "3") then
            color = "66ff33"; -- green/yellow
          elseif (now == "4") then
            color = "00ff00"; -- green
          end
          if (arg1 == "status") then
            output = now.."/"..max.." Shaman, ";
          else
            WinterRepFrameQuest1:SetText("|c00"..color..now.."/"..max.." Shaman");
          end
        end
      end
      -- get Ursa
      local text, typ, finished = GetQuestLogLeaderBoard(2);
      for item, now, max in string.gfind(text,"([^:]+): (%d+)/(%d+)$") do
        if (item and now and max) then
          local color = "bbbbbb";
          if (now == "0") then
            color = "dd0000"; -- red
          elseif (now == "1") then
            color = "ffcc33"; -- orange
          elseif (now == "2") then
            color = "ffff00"; -- yellow
          elseif (now == "3") then
            color = "66ff33"; -- green/yellow
          elseif (now == "4") then
            color = "00ff00"; -- green
          end
          if (arg1 == "status") then
            output = output..now.."/"..max.." Ursa.";
          else
            WinterRepFrameQuest2:SetText("|c00"..color..now.."/"..max.." Ursa");
          end
        end
      end
    end
    -- Frostsaber Provisions
    if (questLogTitleText and string.find(questLogTitleText, "Frostsaber Provisions")) then
          found = true;
          SelectQuestLogEntry(i);
          -- get Shardtooth Meat
          local text, typ, finished = GetQuestLogLeaderBoard(1);
          for item, now, max in string.gfind(text,"([^:]+): (%d+)/(%d+)$") do
            if (item and now and max) then
              local color = "bbbbbb";
              if (now == "0") then
                color = "dd0000"; -- red
              elseif (now == "1") then
                color = "ffcc33"; -- orange
              elseif (now == "2") then
                color = "ffff00"; -- yellow
              elseif (now == "3") then
                color = "66ff33"; -- green/yellow
              elseif (now == "4") then
                color = "00ff00"; -- green
              end
              if (arg1 == "status") then
                output = now.."/"..max.." Shardtooth Meat, ";
              else
                WinterRepFrameQuest1:SetText("|c00"..color..now.."/"..max.." Shardtooth Meat");
              end
            end
          end
          -- get Chillwind Meat
          local text, typ, finished = GetQuestLogLeaderBoard(2);
          for item, now, max in string.gfind(text,"([^:]+): (%d+)/(%d+)$") do
            if (item and now and max) then
              local color = "bbbbbb";
              if (now == "0") then
                color = "dd0000"; -- red
              elseif (now == "1") then
                color = "ffcc33"; -- orange
              elseif (now == "2") then
                color = "ffff00"; -- yellow
              elseif (now == "3") then
                color = "66ff33"; -- green/yellow
              elseif (now == "4") then
                color = "00ff00"; -- green
              end
              if (arg1 == "status") then
                output = output..now.."/"..max.." Chillwind Meat.";
              else
                WinterRepFrameQuest2:SetText("|c00"..color..now.."/"..max.." Chillwind Meat");
              end
            end
         end
      end
      

    -- Rampaging Giants
    if (questLogTitleText and string.find(questLogTitleText, "Rampaging Giants")) then
          found = true;
          SelectQuestLogEntry(i);
          -- get Rampaging Giants
          local text, typ, finished = GetQuestLogLeaderBoard(1);
          for item, now, max in string.gfind(text,"([^:]+): (%d+)/(%d+)$") do
            if (item and now and max) then
              local color = "bbbbbb";
              if (now == "0") then
                color = "dd0000"; -- red
              elseif (now == "1") then
                color = "ffcc33"; -- orange
              elseif (now == "2") then
                color = "ffff00"; -- yellow
              elseif (now == "3") then
                color = "00ff00"; -- green
              end
              if (arg1 == "status") then
                output = now.."/"..max.." Rampaging Giants, ";
              else
                WinterRepFrameQuest1:SetText("|c00"..color..now.."/"..max.." Rampaging Giants");
              end
            end
          end
          -- get Frostmaul Preserver
          local text, typ, finished = GetQuestLogLeaderBoard(2);
          for item, now, max in string.gfind(text,"([^:]+): (%d+)/(%d+)$") do
            if (item and now and max) then
              local color = "bbbbbb";
              if (now == "0") then
                color = "dd0000"; -- red
              elseif (now == "1") then
                color = "ffcc33"; -- orange
              elseif (now == "2") then
                color = "ffff00"; -- yellow
              elseif (now == "3") then
                color = "00ff00"; -- green
              end
              if (arg1 == "status") then
                output = output..now.."/"..max.." Frostmaul Preserver.";
              else
                WinterRepFrameQuest2:SetText("|c00"..color..now.."/"..max.." Frostmaul Preserver");
              end
            end
         end
      end
      

  end
  if (arg1 ~= nil and found) then
    WinterRep_output("<WinterRep> "..output);
  elseif (arg1 ~= nil and not found) then
    WinterRep_output("<WinterRep> I'M A NOOB WHO FORGOT TO GET THE QUEST!");
  end
  if (not found) then
    WinterRepFrameQuest1:SetText("|c00ff33ffYOU DON'T HAVE THE");
    WinterRepFrameQuest2:SetText("|c00ff33ffQUEST!!!");
    
  end
end

function WinterRep_UpdateStats()
  local WinterRep = WinterRep_getRep();
  local rep_per = 50;
  if (UnitRace("player") == "Human") then
    rep_per = 55;
  end
  questsDone = math.floor(WinterRep/rep_per);
  questsTotal = math.ceil(WINTERREP_EXHALTED/rep_per);
  questsTodo = math.ceil((WINTERREP_EXHALTED-WinterRep)/rep_per);
  WinterRepFrameStats1:SetText(questsDone.."/"..questsTotal.." ("..questsTodo.." to go)");
  local percent = math.ceil((WinterRep/WINTERREP_EXHALTED)*100*100)/100;
  WinterRepFrameStatsPercent:SetText(percent.."%");
end

function WinterRep_UpdateRep()
  local current = 0;
  -- find num quests done
  local WinterRep = WinterRep_getRep();
  local rep_per = 50;
  if (UnitRace("player") == "Human") then
    rep_per = 55;
  end
  questsDone = math.floor(WinterRep/rep_per);
  questsTotal = math.ceil(WINTERREP_EXHALTED/rep_per);
  
  for i = 1, 17 do
    local repUiString = getglobal("WinterRepFrameRep"..i);
    -- generate string for this line
    local repString = "";
    -- start with whole line color
    if (current >= questsDone) then
      repString = "|c00ff0000"; -- red
    else
      repString = "|c0000ff00"; -- green
    end
    local maxloop = 0;
    if ((current+50) < questsTotal) then
      maxloop = current+50;
    else 
      maxloop = questsTotal;
    end
    for j = current, maxloop do
      if (j == questsDone) then
        repString = repString.."|c00ff0000";
      end
      repString = repString..".";
    end
    current = current + 50;
    repUiString:SetText(repString);
  end
end

function WinterRep_Spam(arg1)
  local outputType = "auto";
  local outputWhisper = "";
  if (arg1 ~= "") then
    local i, y = string.find(arg1, "w");
    if (i == 1 and string.len(arg1) > 2) then
      outputType = "whisper";
      outputWhisper = string.sub(arg1, (y+2));
		end
		local i, y = string.find(arg1, "general");
    if (i == 1 and string.len(arg1) == 7) then
      outputType = "general";
		end
		local i, y = string.find(arg1, "lfg");
    if (i == 1 and string.len(arg1) == 7) then
      outputType = "lfg";
		end
		local i, y = string.find(arg1, "p");
		if (i == 1 and string.len(arg1) == 1) then
      outputType = "party";
		end
		local i, y = string.find(arg1, "g");
		if (i == 1 and string.len(arg1) == 1) then
      outputType = "guild";
		end
		local i, y = string.find(arg1, "r");
		if (i == 1 and string.len(arg1) == 1) then
      outputType = "raid";
		end
		local i, y = string.find(arg1, "l");
		if (i == 1 and string.len(arg1) == 1) then
      outputType = "local";
		end
  end
  local WinterRep = WinterRep_getRep();
  local quests;
  local rep_per = 50;
  if (UnitRace("player") == "Human") then
    rep_per = 55;
  end
  quests = math.ceil((WINTERREP_EXHALTED-WinterRep)/rep_per);
  local progress_bar = "[";
  local percent = math.ceil((WinterRep/WINTERREP_EXHALTED)*100*100)/100;
  local chars = 0;
  for i = 0, math.floor(percent/5) do
    progress_bar = progress_bar .. "=";
    chars = chars + 1;
  end
  if (math.floor(percent/5) < percent/5) then
    progress_bar = progress_bar .. ">";
    chars = chars + 1;
  end
  for i = chars, 20 do
    progress_bar = progress_bar .. "_";
  end
  progress_bar = progress_bar .. "]";
  WinterRep_output("Wintersaber Rep: "..progress_bar .." "..percent.."%, "..quests.." more ("..WinterRep.."/"..WINTERREP_EXHALTED..")", outputType, outputWhisper);
end

function WinterRep_getRep()
  local i = 0;
  local WinterRep = 0;
  for i = 0, GetNumFactions() do 
    local name, description, standingId, bottomValue, topValue, earnedValue, atWarWith, canToggleAtWar, isHeader, isCollapsed = GetFactionInfo(i);
    if (name == "Wintersaber Trainers") then
      WinterRep = earnedValue;
    end
  end
  return WinterRep;
end

function WinterRep_debug(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg);
end;

function WinterRep_output(msg, outType, target)
  if (outType == "whisper" and target ~= "") then
    SendChatMessage(msg, "WHISPER", this.language, target);
  elseif (outType == "general") then
    SendChatMessage(msg,"CHANNEL", this.language,GetChannelName("General - "..GetRealZoneText()));
  elseif (outType == "lfg") then
    SendChatMessage(msg,"CHANNEL", this.language,GetChannelName("LookingForGroup"));
  elseif (outType == "guild") then
    SendChatMessage(msg, "GUILD");
  elseif (outType == "party") then
    SendChatMessage(msg, "PARTY");
  elseif (outType == "raid") then
    SendChatMessage(msg, "RAID");
  elseif (outType == "local") then
    DEFAULT_CHAT_FRAME:AddMessage(msg);
  elseif (GetNumPartyMembers() > 0) then
    SendChatMessage(msg, "PARTY");
  else
    DEFAULT_CHAT_FRAME:AddMessage(msg);
  end
end