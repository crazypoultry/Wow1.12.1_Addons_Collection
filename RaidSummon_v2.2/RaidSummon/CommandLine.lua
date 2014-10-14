-- list players in queue
local function ListQueuedPlayers()
  local i;
  local count= rsm.GetNumPlayerQueued();
  rsmUtil.PrintChatMessage(RSM_HEADER..RSM_QUEUED_PLAYERS.."<h>"..count.."</h>");
  for i= 1, count do
    rsmUtil.PrintChatMessage(i..": "..summonQueue[i]);
  end;
  rsmUtil.PrintChatMessage(RSM_HEADER..RSM_END_OF_LIST);
end;
 
-- print current settings
local function PrintStatus()
  if (rsmSaved.enabled) then
    rsmUtil.PrintChatMessage(RSM_HEADER..RSM_ADDON_ENABLED);
  else
    rsmUtil.PrintChatMessage(RSM_HEADER..RSM_ADDON_DISABLED);
  end;
  if (rsmSaved.flashAction) then
    rsmUtil.PrintChatMessage(RSM_HEADER..RSM_BLINKING_ENABLED);
  else
    rsmUtil.PrintChatMessage(RSM_HEADER..RSM_BLINKING_DISABLED);
  end;
  if (rsmSaved.listen) then
    rsmUtil.PrintChatMessage(RSM_HEADER..RSM_LISTEN_ENABLED);
  else
    rsmUtil.PrintChatMessage(RSM_HEADER..RSM_LISTEN_DISABLED);
  end;
  if (rsmSaved.announce) then
    rsmUtil.PrintChatMessage(RSM_HEADER..RSM_ANNOUNCE_ENABLED);
  else
    rsmUtil.PrintChatMessage(RSM_HEADER..RSM_ANNOUNCE_DISABLED);
  end;
  if (rsmSaved.whisper) then
    rsmUtil.PrintChatMessage(RSM_HEADER..RSM_WHISPER_ENABLED);
  else
    rsmUtil.PrintChatMessage(RSM_HEADER..RSM_WHISPER_DISABLED);
  end;
  if (rsmSaved.hideRequests) then
    rsmUtil.PrintChatMessage(RSM_HEADER..RSM_REQUESTS_HIDDEN);
  else
    rsmUtil.PrintChatMessage(RSM_HEADER..RSM_REQUESTS_SHOWN);
  end;
  if (rsmSaved.hideReplies) then
    rsmUtil.PrintChatMessage(RSM_HEADER..RSM_REPLIES_HIDDEN);
  else
    rsmUtil.PrintChatMessage(RSM_HEADER..RSM_REPLIES_SHOWN);
  end;
  rsmUtil.PrintChatMessage(RSM_HEADER..RSM_WHISPERLANG..rsmUtil.GetLocalized("LANGUAGE").." ("..rsmSaved.interactLang..")");
  
  local msg= string.gsub(RSM_HEADER..RSM_MINIMUM_SHARDS, "%%n", rsmSaved.minShards);
  rsmUtil.PrintChatMessage(msg);
  
  local msg= string.gsub(RSM_HEADER..RSM_MINIMUM_DISTANCE, "%%n", rsmSaved.minDistance);
  rsmUtil.PrintChatMessage(msg);

  for lang, _ in RSM_LANG do
    local msg= string.gsub(RSM_HEADER..RSM_KEYWORDS, "%%l", lang);
    msg= string.gsub(msg, "%%k", table.concat(rsmSaved.keywords[lang], ", "));
    rsmUtil.PrintChatMessage(msg);
  end;
end;

-- post summoning stats for current raidmembers (FIXME: *still* pretty cheap implementation)
local function PostRaidStats(maxCount)
  if ((GetNumRaidMembers() == 0) and (GetNumPartyMembers() == 0)) then
    rsmUtil.PrintChatMessage(RSM_HEADER..RSM_GROUP_REQUIRED);
    return
  end;

  rsmUtil.PartyOrRaidMessage(rsmUtil.GetLocalized("TOTALS_RAID"));

  local maxSummons= 0;
  for player, summons in rsmSaved.summonsList do
    if (summons >= maxSummons) then
      maxSummons= summons;
    end;
  end;

  local count= 0;
  local pleaseBreak= false;
  local members= rsmUtil.GetRaidSnapshot();
  for i= maxSummons, 0, -1 do
    for player, summons in rsmSaved.summonsList do
      if (summons == i and members[player]) then
        rsmUtil.PartyOrRaidMessage("  "..player..": "..summons);
        count= count +1;
        if (count >= maxCount) then
          pleaseBreak= true;
          break;
        end;
      end;
    end;
    if (pleaseBreak == true) then
      break;
    end;
  end;

  rsmUtil.PartyOrRaidMessage(rsmUtil.GetLocalized("END_OF_LIST"));
end;

-- print only stats for current raidmembers
local function RaidStats(maxCount)
  if ((GetNumRaidMembers() == 0) and (GetNumPartyMembers() == 0)) then
    rsmUtil.PrintChatMessage(RSM_HEADER..RSM_GROUP_REQUIRED);
    return
  end;

  rsmUtil.PrintChatMessage(RSM_HEADER..RSM_TOTALS_RAID);

  local maxSummons= 0;
  for player, summons in rsmSaved.summonsList do
    if (summons >= maxSummons) then
      maxSummons= summons;
    end;
  end;

  local count= 0;
  local pleaseBreak= false;
  local members= rsmUtil.GetRaidSnapshot();
  for i= maxSummons, 0, -1 do
    for player, summons in rsmSaved.summonsList do
      if (summons == i and members[player]) then
        rsmUtil.PrintChatMessage("  "..player..": "..NORMAL_FONT_COLOR_CODE..summons..FONT_COLOR_CODE_CLOSE);
        count= count +1;
        if (count >= maxCount) then
          pleaseBreak= true;
          break;
        end;
      end;
    end;
    if (pleaseBreak == true) then
      break;
    end;
  end;

  rsmUtil.PrintChatMessage(RSM_HEADER..RSM_END_OF_LIST);
end;

-- print all stats
local function Stats(maxCount)
  local total= 0;
  local maxSummons= 0;
  for _, summons in rsmSaved.summonsList do
    total= total +summons;
    if (summons >= maxSummons) then
      maxSummons= summons;
    end;
  end;

  rsmUtil.PrintChatMessage(RSM_HEADER..RSM_TOTALS..NORMAL_FONT_COLOR_CODE..total..FONT_COLOR_CODE_CLOSE);
 
  local count= 0;
  local pleaseBreak= false;

  for i= maxSummons, 0, -1 do
    for player, summons in rsmSaved.summonsList do
      if (summons == i) then
        rsmUtil.PrintChatMessage("  "..player..": "..NORMAL_FONT_COLOR_CODE..summons..FONT_COLOR_CODE_CLOSE);
        count= count +1;
        if (count >= maxCount) then
          pleaseBreak= true;
          break;
        end;
      end;
    end;
    if (pleaseBreak == true) then
      break;
    end;
  end;

  rsmUtil.PrintChatMessage(RSM_HEADER..RSM_END_OF_LIST);  
end;

-- console callback
function Command(msg)
  -- only continue if already loaded
  if (rsm.IsAddonLoaded() == false) then
    return;
  end;

  -- process console commands
  if (msg == "") then
    rsmUtil.PrintChatMessage(RSM_HELP_MSG0);
    rsmUtil.PrintChatMessage("  "..RSM_HELP_MSG1);
  
  elseif (msg == "basic") then
    rsmUtil.PrintChatMessage(RSM_HELP_MSG0);
    rsmUtil.PrintChatMessage("  "..RSM_HELP_MSG7);
    rsmUtil.PrintChatMessage("  "..RSM_HELP_MSG9);    
    rsmUtil.PrintChatMessage("  "..RSM_HELP_MSG8);
    rsmUtil.PrintChatMessage("  "..RSM_HELP_MSG15);

  elseif (msg == "logging") then
    rsmUtil.PrintChatMessage(RSM_HELP_MSG0);
    rsmUtil.PrintChatMessage("  "..RSM_HELP_MSG11);
    rsmUtil.PrintChatMessage("  "..RSM_HELP_MSG12);
    rsmUtil.PrintChatMessage("  "..RSM_HELP_MSG13);
    rsmUtil.PrintChatMessage("  "..RSM_HELP_MSG14);

  elseif (msg == "settings") then
    rsmUtil.PrintChatMessage(RSM_HELP_MSG0);
    rsmUtil.PrintChatMessage("  "..RSM_HELP_MSG6);
    rsmUtil.PrintChatMessage("  "..RSM_HELP_MSG16);
    rsmUtil.PrintChatMessage("  "..RSM_HELP_MSG10);
    rsmUtil.PrintChatMessage("  "..RSM_HELP_MSG22);
    rsmUtil.PrintChatMessage("  "..RSM_HELP_MSG17);
    rsmUtil.PrintChatMessage("  "..RSM_HELP_MSG18);
    rsmUtil.PrintChatMessage("  "..RSM_HELP_MSG3);
    rsmUtil.PrintChatMessage("  "..RSM_HELP_MSG2);
    rsmUtil.PrintChatMessage("  "..RSM_HELP_MSG4);
    rsmUtil.PrintChatMessage("  "..RSM_HELP_MSG5);
    rsmUtil.PrintChatMessage("  "..RSM_HELP_MSG19);
    rsmUtil.PrintChatMessage("  "..RSM_HELP_MSG20);
    rsmUtil.PrintChatMessage("  "..RSM_HELP_MSG21);

  elseif (msg == "debug") then
    rsm.Debug();

  elseif (msg == "status") then
    PrintStatus();

  elseif (msg == "resetstats") then
    rsmSaved.summonsList= { };
    rsmUtil.PrintChatMessage(RSM_HEADER..RSM_STATS_RESET);

  elseif (string.find(msg, "postraidstats") == 1) then
    local count= string.sub(msg, 15);
    if (count) then
      count= tonumber(count);
    end;
    if (count == nil or count == 0) then
      count= 10;
    end;
    PostRaidStats(count);

  elseif (string.find(msg, "raidstats") == 1) then
    local count= string.sub(msg, 11);
    if (count) then
      count= tonumber(count);
    end;
    if (count == nil or count == 0) then
      count= 10;
    end;
    RaidStats(count);

  elseif (string.find(msg, "stats") == 1) then
    local count= string.sub(msg, 7);
    if (count) then
      count= tonumber(count);
    end;
    if (count == nil or count == 0) then
      count= 10;
    end;
    Stats(count);

  elseif (msg == "clear") then
    rsm.ResetQueue(true);
    rsmUtil.PrintChatMessage(RSM_HEADER..RSM_RESET_QUEUE);

  elseif (msg == "list") then
    ListQueuedPlayers();

  elseif (msg == "announce") then
    rsm.Announce();

  elseif (msg == "toggleenable" or msg == "te") then
    rsmSettings.ToggleEnable(true);

  elseif (msg == "togglelisten" or msg == "tl") then
    rsmSettings.ToggleListen(true);

  elseif (msg == "toggleannounce" or msg == "ta") then
    rsmSettings.ToggleAnnounce(true);

  elseif (msg == "togglewhisper" or msg == "tw") then
    rsmSettings.ToggleWhisper(true);

  elseif (msg == "togglehiderequests" or msg == "thq") then
    rsmSettings.ToggleHideRequests(true);

  elseif (msg == "togglehidereplies" or msg == "thp") then
    rsmSettings.ToggleHideReplies(true);

  elseif (msg == "toggleflash" or msg == "tf") then
    rsmSettings.ToggleFlashing(true);

  elseif (msg == "skip") then
    local skipped= rsm.SkipQueue();
    if (skipped) then
      local msg= string.gsub(RSM_HEADER..RSM_DEQUEUE_PLAYER, "%%s", nickname);
      rsmUtil.PrintChatMessage(msg);
    else
      rsmUtil.PrintChatMessage(RSM_HEADER..RSM_NOTHING_TO_DO);
    end;

  elseif (msg == "resetkeywords") then
    rsmSettings.KeywordReset(rsmSaved.interactLang);
    rsmUtil.PrintChatMessage(RSM_HEADER..RSM_KEYWORDRESET);

  elseif (string.find(msg, "addkeyword ") == 1) then
    local keyword= string.sub(msg, 12);
    if (keyword ~= "") then
      rsmSettings.KeywordAdd(rsmSaved.interactLang, keyword);
    end;
    local msg= string.gsub(RSM_HEADER..RSM_KEYWORDS, "%%l", rsmSaved.interactLang);
    msg= string.gsub(msg, "%%k", table.concat(rsmSaved.keywords[rsmSaved.interactLang], ", "));
    rsmUtil.PrintChatMessage(msg);
  
  elseif (string.find(msg, "shards ") == 1) then
    local minimum= string.sub(msg, 8);
    rsmSettings.SetShardMinimum(minimum, true);

  elseif (string.find(msg, "distance ") == 1) then
    local minimum= string.sub(msg, 10);
    rsmSettings.SetDistanceMinimum(minimum, true);
      
  elseif (string.find(msg, "lang ") == 1) then
    local langAbr= string.sub(msg, 6);
    if (langAbr ~= "") then
      rsmSettings.SetNotificationLanguage(langAbr, true);
    end;
    
  else
    rsmUtil.PrintChatMessage(RSM_HEADER..RSM_UNKNOWN_PARAMETER);

  end;
end;


-- public interface
rsmCommandLine= {

  -- register command line features
  OnLoad= function()
    SlashCmdList["RAIDSUMMON"]= Command;
    SLASH_RAIDSUMMON1= "/raidsummon";
    SLASH_RAIDSUMMON2= "/rsm";
  end;

}