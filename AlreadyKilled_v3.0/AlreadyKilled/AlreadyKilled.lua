--[[ Already Killed
     Version: 3.0
     Author: Kiki of European Cho'gall

  Change Log: 
    Version 3.0 :
      August, 27th 2006 :
        - Changed honor reduction according to 1.12 patch (now 10% reduction per kill, instead of 25%)
    Version 2.9 :
      July, 19th 2006 :
        - Fixed bug in EHP auto-reset during maintenance
    Version 2.8.2 :
      June, 27th 2006 :
        - Minor localization fix (deDE)
    Version 2.8 :
      June, 26th 2006 :
        - Added a new exported function : AK_Kills(FactionId) (Thanks Sirsad for this one). It prints current kills in a BG depending on FactionId (1 or 0)
        - Now saving config per character, instead of global one. You'll have to reconfigure AK
    Version 2.7 :
      June, 21th 2006 :
        - Updated TOC
        - Fixed lua error from 1.11
        - Auto reset EHP after a weekly maintenance
    Version 2.6 :
      January, 17th 2006 :
        - Fixed Warning message (and correct BG bonus) when jumping from a BG to another
        - Fixed BG honor bonus earned
    Version 2.5 :
      January, 4th 2006 :
        - Updated TOC
        - Fixed GetBattlefieldStatus() usage
        - Removed global shared variables, but added AK_GetCurrentBGIndexAndName() exported function
        - Parsing new honor gain message in CHAT_MSG_COMBAT_HONOR_GAIN event (points earned in BG for objectives accomplished)
    Version 2.4 :
      December, 17th 2005 :
        - Displaying BG points earned in sct too
        - Not sending "0 points" to sct
    Version 2.3 :
      December, 16th 2005 :
        - Added honor bonus detection when you return BG marks to the NPC (not for deDE client, I don't have the line)
        - Added Sct optional support (thanks to maido) (/ak sct)
        - Added Show/Hide of the TargetFrame counter (/ak frame)
    Version 2.2 :
      October, 3rd 2005 :
        - Fixed tooltip issue with AFTooltip
    Version 2.1 :
      September, 14th 2005 :
        - Removed RegisterForSave call. Variables are now correctly saved in the new SavedVariables folder
        - Updated toc (#1700)
        - Fixed vars init when disconnect/reconnect and /reloadui (thanks blizz for the undocumented new behaviour changes)
    Version 2.0 :
      July, 30th 2005 :
        - Changed the warning message line (shown when you look at the other faction BG score)
        - Added a "/ak tell" parameter, to display or not the AK line when you gain honor
    Version 1.9 :
      July, 15th 2005 :
        - Added AK_GetEHP() and AK_ResetEHP() to exported functions (for Titan support)
        - Changed AK_GetRealHP return values
        - Removed debug chat line :p
    Version 1.8 :
      July, 12th 2005 :
        - Toc 1600
        - Added an auto kills reset, after a week maintenance
    Version 1.72 :
      July, 12th 2005 :
        - Fixed runtime errors
    Version 1.7 :
      July, 11th 2005 :
        - Doubled the fade out time of UIError messages
        - Added message for '0 kill' target.
        - Added global function prototypes.
        - Changed honor gain message (now display name of the target, and ratio)
    Version 1.6 :
      June, 30th 2005 :
        - Correct german map translations.
        - Re-added a / command for kills reset (should not be used though) : /ak resetkills
      June, 29th 2005 :
        - Added Battleground bonus honor to the counter.
    Version 1.5 :
      June, 28th 2005 :
        - Added a new global function : AK_GetKilledCount(name) Returns the killed count of this person.
      June, 27th 2005 :
        - Added display of AK count in TargetFrame.
        - Added global function (for other mods) : AK_GetRealHP(name,estimated) Returns real estimated HP, from the one given by blizz in chat lines. Must only be called during CHAT_MSG_COMBAT_HONOR_GAIN event.
    Version 1.4 :
      June, 22th 2005 :
        - Added estimated honor counter.
      June, 21th 2005 :
        - Now resetting kills individually (24h after the first time each ennemy is killed). GM said it works this way... hope it's true :)
        - Added a localization file.
      June, 17th 2005 :
        - Changed message colors (now 4 colors, instead of 3, you still gain honor on the 4th kill). Now displays in gray, target with no honor
    Version 1.3 :
      June, 3rd 2005 :
        - Added a manual reset command (/ak reset).
      May, 20th 2005 :
        - Fixed an error, if logging during the reset hour.
    Version 1.2 :
      May, 19th 2005 :
        - Fixed width/height issue (Thanks Oystein).
        - Added automatic kills reset (at midnight).
        - Added per toon kills.
    Version 1.1 :
      May, 13th 2005 :
        - Added /ak command for minimal configuration.
        - Printed line color now depends on the kill count (from green to red). Printed lines are more compact.
    Version 1.0 :
	  May, 11th 2005 :
        - First release.
]]


--------------- Saved variables ---------------
--AK_Config = { LastLogTime = 0, Targeted = "ef", MouseOver = "tt" };
AK_Config = {};

--------------- Shared variables ---------------
AK_CurrentBGIndex = 0;
AK_PreviousBGIndex = 0;

--------------- Local variables ---------------
local AK_VERSION = "3.0";
local AK_ResetCheck_LastTime = -1;
local AK_ResetCheck_LastTimeMin = -1;
local AK_NeedInitToonSpecific = true;
local AK_PlayerName = nil;
local AK_ResetDelay = 24*60*60; -- 24 hours
local AK_CurrentBGScore = 0;
local AK_HaveHooked = false;

--------------- Internal functions ---------------
function AK_ChatDebug(str)
  if(DEFAULT_CHAT_FRAME)
  then
    DEFAULT_CHAT_FRAME:AddMessage("AlreadyKilled Debug : "..str, 1.0, 0, 0);
  end
end

local function AK_ChatPrint(str)
  if(DEFAULT_CHAT_FRAME)
  then
    DEFAULT_CHAT_FRAME:AddMessage("AlreadyKilled : "..str, 1.0, 0.7, 0.15);
  end
end

local function AK_GetCurrentBGScore()
  RequestBattlefieldScoreData();
  for i=1,GetNumBattlefieldScores()
  do
    local name,_,_,_,honorgained = GetBattlefieldScore(i);
    if(name == AK_PlayerName)
    then
      return honorgained;
    end
  end
  return 0;
end

local function AK_ShowHPCount()
  AK_HPCountText:SetText(AK_EHP.." : "..AK_Config.hp);
end

local function AK_SetNewLock()
  if(AK_Config.Lock == "yes")
  then
    AlreadyKilledHPFrame:EnableMouse("false");
  else
    AlreadyKilledHPFrame:EnableMouse("true");
  end
end

local function AK_SetNewShow()
  if(AK_Config.Show == "yes")
  then
    AlreadyKilledHPFrame:Show();
    AK_ShowHPCount();
  else
    AlreadyKilledHPFrame:Hide();
  end
end

local function AK_GetLocalKilledCount(name)
  if(name == nil)
  then
    return 1;
  end
  return AK_Config.kills[name].count;
end

local function AK_ResetHPCount()
  AK_Config.hp = 0;
  AK_ShowHPCount();
end

local function AK_GetRatioByCount(count) -- Count, From 1 (first kill) to infini
  if(count == 1) then return 1.0;end
  if(count == 2) then return 0.90;end
  if(count == 3) then return 0.80;end
  if(count == 4) then return 0.70;end

  return 0; -- No honor
end

local function AK_GetRatio(name)
  local count = AK_GetLocalKilledCount(name); -- Called after the count increase, so 1 = first time

  return AK_GetRatioByCount(count);
end

local function AK_IncreaseHPCount(name,hp)
  if(AK_Config.hp == nil)
  then
    AK_ResetHPCount();
  end
  AK_Config.hp = floor(AK_Config.hp + AK_GetRatio(name)*hp);
  local ratio = AK_GetRatio(name);
  local realvalue = floor(ratio*hp);
  if(name ~= nil and (AK_Config.Tell == "yes"))
  then
    AK_ChatPrint(name.." : "..realvalue.." pts ("..floor(ratio*100).."% * "..hp..")");
  end
  if(realvalue ~= 0 and SCT_CmdDisplay and AK_Config.Sct == "yes")
  then
    SCT_CmdDisplay("'+"..realvalue..AK_CHAT_SCT_HONOR.."' 2 7 9")
  end    
  AK_ShowHPCount();
end

local function AK_ResetAllKills()
  AK_ChatPrint(AK_CHAT_RESET_KILLS);
  AK_Config.kills = {};
end

local function AK_CheckForReset(name)
  local cur_time = time(); -- Get local machine time (since 1970)
  -- debug
  if(name == nil) then AK_ChatDebug("error #1");return false;end;
  if(AK_Config.kills[name] == nil) then AK_ChatDebug("error #2");return false;end;
  if(AK_Config.kills[name].start_date == nil) then AK_ChatDebug("error #3");return false;end;
  -- end debug
  local start_date = AK_Config.kills[name].start_date;

  if(((start_date+AK_ResetDelay) < cur_time) or (start_date > cur_time)) -- Timer exceed
  then
    AK_Config.kills[name] = nil;
    return false;
  end
  return true;
end

local function IsKA(name)
  if(AK_Config.kills[name] == nil)
  then
    return false;
  end
  return AK_CheckForReset(name);
end

local function AK_IncreaseKillCount(name)
  local tim = time();
  if(AK_Config.kills[name] == nil)
  then
    AK_Config.kills[name] = {};
    AK_Config.kills[name].count = 0;
    AK_Config.kills[name].start_date = tim; -- Move after next 'end', if each kill resets the timer
  end
  AK_Config.kills[name].last_date = tim;
  AK_Config.kills[name].count = AK_Config.kills[name].count + 1;
end

local function AK_CheckDefaults()
  if (not AK_Config.users)
  then -- Global config does not exist
    -- Init defaults values
    AK_Config.users = {};
    AK_Config.Targeted = "ef";
    AK_Config.MouseOver = "tt";
  end
  if(not AK_Config.FirstTimeInit)
  then -- Never init
    -- Init defaults values
    AK_ResetAllKills();
    AK_ResetHPCount();
    AK_Config.Lock = "no";
    AK_Config.Show = "yes";
    AK_Config.Tell = "yes";
    AK_Config.Frame = "yes";
    AK_Config.Sct = "yes";
    AK_Config.lastWeek = 0;
    AK_Config.FirstTimeInit = true;
  end
end

function AK_CheckForResetKills()
  local _,_,contrib = GetPVPLastWeekStats();
  if(AK_Config.lastWeek ~= contrib)
  then
    AK_ChatPrint(AK_CHAT_MAINTENANCE);
    AK_Config.lastWeek = contrib;
    AK_ResetAllKills();
    AK_ResetHPCount();
  end
end

local function AK_Commands(command)
  local i,j, cmd, param = string.find(command, "^([^ ]+) (.+)$");
  if(not cmd) then cmd = command; end
  if(not cmd) then cmd = ""; end
  if(not param) then param = ""; end

  if((cmd == "") or (cmd == "help"))
  then
    AK_ChatPrint("Usage:");
    AK_ChatPrint("  |cffffffff/ak target (none|ef|tt|both)|r |cff2040ff["..AK_Config['Targeted'].."]|r - "..AK_CHAT_HELP_TARGETED);
    AK_ChatPrint("  |cffffffff/ak mouseover (none|ef|tt|both)|r |cff2040ff["..AK_Config['MouseOver'].."]|r - "..AK_CHAT_HELP_MOUSEOVER);
    AK_ChatPrint("  |cffffffff/ak show (yes|no)|r |cff2040ff["..AK_Config.Show.."]|r - "..AK_CHAT_HELP_SHOW);
    AK_ChatPrint("  |cffffffff/ak lock (yes|no)|r |cff2040ff["..AK_Config.Lock.."]|r - "..AK_CHAT_HELP_LOCK);
    AK_ChatPrint("  |cffffffff/ak tell (yes|no)|r |cff2040ff["..AK_Config.Tell.."]|r - "..AK_CHAT_HELP_TELL);
    AK_ChatPrint("  |cffffffff/ak frame (yes|no)|r |cff2040ff["..AK_Config.Frame.."]|r - "..AK_CHAT_HELP_FRAME);
    AK_ChatPrint("  |cffffffff/ak sct (yes|no)|r |cff2040ff["..AK_Config.Sct.."]|r - "..AK_CHAT_HELP_SCT);
    AK_ChatPrint("  |cffffffff/ak reset |r - "..AK_CHAT_HELP_RESET);
    AK_ChatPrint("  |cffffffff/ak addhp <value> |r - "..AK_CHAT_HELP_ADDHP);
    AK_ChatPrint("  |cffffffff/ak resetkills |r - "..AK_CHAT_HELP_RESETKILLS);
  elseif(cmd == "target")
  then
    if(param == "none")
    then
      AK_Config['Targeted'] = "none";
    elseif(param == "ef")
    then
      AK_Config['Targeted'] = "ef";
    elseif(param == "tt")
    then
      AK_Config['Targeted'] = "tt";
    elseif(param == "both")
    then
      AK_Config['Targeted'] = "both";
    else
      AK_ChatPrint(AK_CHAT_CMD_PARAM_ERROR.."target");
      return;
    end
  elseif(cmd == "mouseover")
  then
    if(param == "none")
    then
      AK_Config['MouseOver'] = "none";
    elseif(param == "ef")
    then
      AK_Config['MouseOver'] = "ef";
    elseif(param == "tt")
    then
      AK_Config['MouseOver'] = "tt";
    elseif(param == "both")
    then
      AK_Config['MouseOver'] = "both";
    else
      AK_ChatPrint(AK_CHAT_CMD_PARAM_ERROR.."mouseover");
      return;
    end
  elseif(cmd == "show")
  then
    if(param == "yes")
    then
      AK_Config.Show = "yes";
    elseif(param == "no")
    then
      AK_Config.Show = "no";
    else
      AK_ChatPrint(AK_CHAT_CMD_PARAM_ERROR.."show");
      return;
    end
    AK_SetNewShow();
  elseif(cmd == "lock")
  then
    if(param == "yes")
    then
      AK_Config.Lock = "yes";
    elseif(param == "no")
    then
      AK_Config.Lock = "no";
    else
      AK_ChatPrint(AK_CHAT_CMD_PARAM_ERROR.."lock");
      return;
    end
    AK_SetNewLock();
  elseif(cmd == "tell")
  then
    if(param == "yes")
    then
      AK_Config.Tell = "yes";
    elseif(param == "no")
    then
      AK_Config.Tell = "no";
    else
      AK_ChatPrint(AK_CHAT_CMD_PARAM_ERROR.."tell");
      return;
    end
  elseif(cmd == "frame")
  then
    if(param == "yes")
    then
      AK_Config.Frame = "yes";
    elseif(param == "no")
    then
      AK_Config.Frame = "no";
    else
      AK_ChatPrint(AK_CHAT_CMD_PARAM_ERROR.."frame");
      return;
    end
  elseif(cmd == "sct")
  then
    if(param == "yes")
    then
      AK_Config.Sct = "yes";
    elseif(param == "no")
    then
      AK_Config.Sct = "no";
    else
      AK_ChatPrint(AK_CHAT_CMD_PARAM_ERROR.."sct");
      return;
    end
  elseif(cmd == "reset")
  then
    AK_ResetHPCount();
  elseif(cmd == "resetkills")
  then
    AK_ResetAllKills()
  elseif(cmd == "addhp")
  then
    local i,j,val = string.find(param, "^(%d+)$");
    if(val == nil)
    then
      AK_ChatPrint(AK_CHAT_CMD_PARAM_ERROR.."addhp");
      return;
    end;
    local value = val + 0.0;
    AK_IncreaseHPCount(nil,value);
    AK_ChatPrint(AK_CHAT_ADDHP_ADDED..value);
  else
    AK_ChatPrint(AK_CHAT_CMD_UNKNOWN);
  end
end

local function AK_GetColors(count)
  if(count == 0) then return 0.1,1.0,0.0;end
  if(count == 1) then return 0.2,0.8,0.0;end
  if(count == 2) then return 0.6,0.6,0.0;end
  if(count == 3) then return 1.0,0.2,0.0;end
  if(count >= 4) then return 0.4,0.4,0.4;end -- Gray, no honor
  -- Should never happen
  return 1.0,0.0,0.0;
end

local function AK_ShowAK(name,varname)
  local ak_count = AK_GetLocalKilledCount(name);
  local r,g,b = AK_GetColors(ak_count);

  if((AK_Config[varname] == "ef") or (AK_Config[varname] == "both"))
  then
    UIErrorsFrame:AddMessage(name.." : "..ak_count.." kill(s)", r,g,b, 1.0, 5);
  end
  if((AK_Config[varname] == "tt") or (AK_Config[varname] == "both"))
  then
    GameTooltip:AddLine("Killed "..ak_count.." time(s)",r,g,b);
    GameTooltip:Show(); -- Adjust width and height
  end
  if((varname == "Targeted") and TargetFrame:IsVisible() and AK_Config.Frame == "yes") -- Have a new target
  then
    AlreadyKilledTargetText:SetTextColor(r,g,b);
    AlreadyKilledTargetText:SetText(ak_count);
    AlreadyKilledTargetFrame:Show();
  end
end

local function AK_ShowNoAK(name,varname)
  local r,g,b = AK_GetColors(0);

  if((AK_Config[varname] == "ef") or (AK_Config[varname] == "both"))
  then
    UIErrorsFrame:AddMessage(name.." : Never killed !", r,g,b, 1.0, 5);
  end
  if((AK_Config[varname] == "tt") or (AK_Config[varname] == "both"))
  then
    GameTooltip:AddLine("Never killed !",r,g,b);
    GameTooltip:Show(); -- Adjust width and height
  end
  if((varname == "Targeted") and TargetFrame:IsVisible() and AK_Config.Frame == "yes") -- Have a new target
  then
    AlreadyKilledTargetText:SetTextColor(r,g,b);
    AlreadyKilledTargetText:SetText(0);
    AlreadyKilledTargetFrame:Show();
  end
end

local function AK_StartupInitVars()
  local playerName = UnitName("player");
  if((playerName) and (playerName ~= UNKNOWNOBJECT) and (playerName ~= UKNOWNBEING))
  then
    -- Initialize Toon specific stuff
    AK_PlayerName = playerName;
    AK_CheckDefaults();
    AK_NeedInitToonSpecific = false;
    -- Honor counter
    AK_SetNewLock();
    AK_SetNewShow();
    AK_ShowHPCount();
  end
end

--------------- Hooked functions ---------------

-- *** AFTooltip *** --
local aftt_format_orig = nil;
local function aftt_format_hook(unit)
  if(aftt_updateFlag["Previous"] ~= UnitName(unit))
  then
    aftt_format_orig(unit)
    if(aftt_updateFlag["Previous"] == UnitName(unit)) -- Time to update
    then
      if(UnitIsPlayer("mouseover") and not UnitIsFriend("player","mouseover"))
      then
        local name = UnitName("mouseover");
        
        if(IsKA(name))
        then
          AK_ShowAK(name,"MouseOver");
        else
          AK_ShowNoAK(name,"MouseOver");
        end
      end
    end
  else
    aftt_format_orig(unit)
  end
end

if(aftt_format ~= nil)
then
  aftt_format_orig = aftt_format;
  aftt_format = aftt_format_hook;
  AK_HaveHooked = true;
end


--------------- From XML functions ---------------

function AK_OnEvent()
  if(event == "VARIABLES_LOADED")
  then
    if(AK_NeedInitToonSpecific)
    then
      AK_StartupInitVars();
    end
    return;
  elseif(event == "UNIT_NAME_UPDATE")
  then
    if(arg1 and arg1 == "player")
    then
      AK_CheckForResetKills();
    end
  end

  if(event == "PLAYER_TARGET_CHANGED" )
  then
    if(UnitExists("target") and UnitIsPlayer("target") and not UnitIsFriend("player","target"))
    then
      local targetName = UnitName("target");
      if(IsKA(targetName))
      then
        AK_ShowAK(targetName,"Targeted");
      else
        AK_ShowNoAK(targetName,"Targeted");
      end
    else
      AlreadyKilledTargetFrame:Hide(); -- Not pvp pj target, always hide AK_TargetFrame
    end

  elseif(event == "UPDATE_MOUSEOVER_UNIT")
  then
    if(not AK_HaveHooked and UnitIsPlayer("mouseover") and not UnitIsFriend("player","mouseover"))
    then
      local name = UnitName("mouseover");
      
      if(IsKA(name))
      then
        AK_ShowAK(name,"MouseOver");
      else
        AK_ShowNoAK(name,"MouseOver");
      end
    end

  elseif(event ==  "CHAT_MSG_COMBAT_HONOR_GAIN")
  then
    local _,_, name, garbage, hp = string.find(arg1, "^([^ ]+) ([^:]+:[^:]+): (%d+)");
    if(name)
    then
      AK_IncreaseKillCount(name);
      AK_IncreaseHPCount(name,hp);
    else
      local _,_, hp = string.find(arg1, AK_HONOR_GAIN_MESSAGE);
      if(hp)
      then
        if(AK_CurrentBGIndex ~= 0) -- In a BG, don't add now
        then
          AK_CurrentBGScore = AK_CurrentBGScore + hp;
        else
          AK_IncreaseHPCount(nil,hp);
        end
      end
    end

  elseif(event == "PLAYER_ENTERING_WORLD")
  then
    local idx,mapName = AK_GetCurrentBGIndexAndName();
    AK_PreviousBGIndex = AK_CurrentBGIndex;
    AK_CurrentBGIndex = idx;

    if(AK_PreviousBGIndex ~= 0) -- I was in a BG
    then
      if(AK_CurrentBGScore ~= 0) -- Just left a BG with points
      then
        AK_ChatPrint(AK_CurrentBGScore..AK_CHAT_BG_BONUS);
        AK_IncreaseHPCount(nil,AK_CurrentBGScore);
      end
      AK_CurrentBGScore = 0;
    end
--[[  
  elseif(event == "UPDATE_BATTLEFIELD_SCORE")
  then
    if(AK_CurrentBGIndex ~= 0)
    then
      local new_score = AK_GetCurrentBGScore();
      if(new_score > AK_CurrentBGScore)
      then
        AK_CurrentBGScore = new_score;
      end

      if(new_score < AK_CurrentBGScore)
      then
        AK_ChatDebug("WARNING : Cannot get your current score. Don't forget to close the BG summary window with your score visible");
      end
    end
]]
  end
end

function AK_OnLoad()
  -- Print init message
  AK_ChatPrint("Version "..AK_VERSION.." "..AK_CHAT_MISC_LOADED);

  -- Register events
  this:RegisterEvent("PLAYER_TARGET_CHANGED");
  this:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
  this:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN");
  this:RegisterEvent("VARIABLES_LOADED");
  this:RegisterEvent("UNIT_NAME_UPDATE");
  this:RegisterEvent("PLAYER_ENTERING_WORLD");
  --this:RegisterEvent("UPDATE_BATTLEFIELD_SCORE");

  -- Hook functions

  -- Initialize Slash commands
  SLASH_AK1 = "/ak";
  SlashCmdList["AK"] = function(msg)
    AK_Commands(msg);
  end
end

--------------- Exported functions ---------------
--[[
  Exported variables :
   AK_CurrentBGIndex : Integer : Index of current active BG (0 if not in a BG)
]]

--[[
  function AK_GetCurrentBGIndexAndName()
  Returns the index of the active battleground queue if any. 0 otherwise
  --
   Returns :
    - Index of active BG (or 0 if not in a BG)
    - Name of the active BG map (or "None" if not in a BG)
]]
function AK_GetCurrentBGIndexAndName()
  local status,mapName;
  for i=1,MAX_BATTLEFIELD_QUEUES
  do
    status,mapName = GetBattlefieldStatus(i);
    if(status == "active")
    then
      return i,mapName;
    end
  end
  return 0,"None";
end

--[[
  function AK_GetRealHP(name,estimated)
   name      : String   -- Name of the target that just died
   estimated : Integer  -- Estimated HP from blizzard chat line
  --
   Returns (Integer) the real Honor points earned
  
  Note : This function must only be called during the CHAT_MSG_COMBAT_HONOR_GAIN event
]]
function AK_GetRealHP(name,estimated)
  local kc = 1;
  if(AK_Config.kills[name] ~= nil)
  then
    kc = 0;
    if((time() - AK_Config.kills[name].last_date) > 2) -- More than 2 sec, kill has not been recorded by AK yet
    then
      kc = kc + 1;
    end
    kc = kc + AK_GetLocalKilledCount(name);
  end
  
  return AK_GetRatioByCount(kc)*estimated;
end

--[[
  function AK_GetRealHP(name,estimated)
   name      : String -- Name of the player you want KilledCount
  --
   Returns :
    - (Integer) the number of times you killed this player
    - r,g,b (Integers) the colors
]]
function AK_GetKilledCount(name)
  local count = 0;
  if(name ~= nil)
  then
    if(AK_Config.kills[name] ~= nil)
    then
      count = AK_Config.kills[name].count;
    end
  end
  return count,AK_GetColors(count);
end

--[[
  function AK_GetEHP()
  --
   Returns (Integer) the current estimated honor points counter
]]
function AK_GetEHP()
  return AK_Config.hp;
end

--[[
  function AK_ResetEHP()
   Resets EHP
  --
]]
function AK_ResetEHP()
  AK_Config.hp = 0;
end


--[[
  function AK_Kills()
  --
]]
function AK_Kills(FactionId)
  local players = GetNumBattlefieldScores();
  if(players > 0)
  then
    local i;
    
    for i = 1, players, 1
    do
      name, _, _, _, _, faction, _, _, class = GetBattlefieldScore(i);
      if(faction == FactionId)
      then
        if(DEFAULT_CHAT_FRAME)
        then
          killCount = AK_GetKilledCount(name);
          DEFAULT_CHAT_FRAME:AddMessage(string.format("%s - %i",name,killCount), 1.0, 0, 0);
        end
      end
    end
  end
end

