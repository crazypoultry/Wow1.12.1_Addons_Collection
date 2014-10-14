-- flagRSP
--
-- based on xTooltip by Author : Per 'Doxxan' Lönn Wege
--

local xTP_OldTick = 0;
xTP_ChannelName = "xtensionxtooltip2";
--xTP_RPList = {};
xTP_RP2List = {};
--local xTP_NumInList = 0;
--xTP_CTList = {};
--xTP_CTList2 = {};
flagRSP_CharStatusList = {};
flagRSP_IntervalList = {};
flagRSP_LastSeenList = {};
flagRSP_IntervalListHigh = {};
flagRSP_LastSeenListHigh = {};

--FlagRSPTest = {};

FlagRSP_CharDesc = {};

FlagRSP_CharDesc.availRev = {};
FlagRSP_CharDesc.savedRev = {};
FlagRSP_CharDesc.savedDesc = {};

xTP_RPTag = {}; -- Rollenspiel flag
xTP_CustomTag = {};  -- Nachname
xTP_CustomTag2 = {}; -- Titel
xTP_RPType = {}; -- Rollenspiel Typ
xTP_NameChange = {};
xTP_LevelChange = {};
flagRSP_ShowRanks = {};
flagRSP_ShowGuild = {};
flagRSP_CharStatus = {};

flagRSP_Debug = false;
flagRSP_AFK = false;
flagRSP_AFKPosx = 0;
flagRSP_AFKPosy = 0;

--[[

flagRSP constants

]]--
FLAGRSP_MININTERVAL = 120;
FLAGRSP_MAXINTERVAL = 7200;
FLAGRSP_MININTERVALHIGH = 30;
FLAGRSP_MAXINTERVALHIGH = 1000;
FLAGRSP_TARGETMPM = 60;

--[[

flagRSP library functions.

]]--
FlagRSP = {
   oldTick = 0;
   numMessagesInInterval = 0;

   bytesInInterval = 0;
   bytesPerSecondLastInterval = 0;
   bytesPerSecondIntervalMax = 0;
   bytesPerSession = 0;

   ownDescriptionSent = 0;
   ownDescriptionRequested = 0;
   maxUsersOnline = 0;

   oldestVersion = "";
   newestVersion = "";

   sessionStartTick = 0;
   isInitialized = false;

   maxPostingCost = 147;
   maxPostingCostHigh = 42;
   postingTargetBps = 25;
   postingTargetBpsHigh = 25;

   oldTickChatFrame = 0;

   postInterval = 2000;
   postIntervalHigh = 400;
   displayBoxInterval = 1;
   rescaleBoxInterval = 120000;
   rescaleBoxBtnInterval = 120000;

   newTickChatFrame = 0;
   newTickPost = 0;
   newTickPostHigh = 0;
   newTickDesc = 0;
   newTickDisplayBox = 0;
   newTickRescaleBox = {
      FlagRSPInfoBox = 0,
      FRIENDLISTFrameInfoBox = 0
   },
   newTickRescaleBoxBtn = 0;

   updateFriendsTick = 0;
   updateGuildListTick = 0;
   updateIgnoredListTick = 0;

   pName = "";
   rName = "";

   releaseVersion = 0;
   majorVersion = 5;
   minorVersion = 6;
   versionString = "0.5.6";

   isStableVersion = true;

   VERSION = "";

   notificationSeen = false;
   
   playerEnteredWorld = false;

   standby = false;
   collecting = false;

   displayOwnTooltip = false;
};

flagRSPDetails = {
   name = "flagRSP",
   version = FlagRSP.versionString,
   author = "Florian Kruse",
   email = "flokru-flagrsp@flokru.gnuu.de",
   website = "http://flokru.org/flagrsp/",
   category = MYADDONS_CATEGORY_OTHERS
};

flagRSPHelp = {};
flagRSPHelp[1] = "For help regarding flagRSP please look into the documentation files contained in <WoW>\\Interface\\AddOns\\flagRSP\\documentation or visit the flagRSP homepage at:\n\nhttp://flokru.org/flagrsp/";


--[[

FlagRSP.getHexString(num)

- Returns hex number as string with minimum string length len for positive integer num.

]]--
function FlagRSP.getHexString(num, len)
   local digits = "0123456789ABCDEF";
   local hexnum = "";
   local intdigit;

   while num>0 do
      intdigit = math.mod(num,16);
      num = math.floor(num/16);

      hexnum = string.sub(digits, (intdigit+1), (intdigit+1)) .. hexnum;
   end

   while string.len(hexnum)<len do
      hexnum = "0" .. hexnum;
   end
   
   return hexnum;
end


function FlagRSP.simplehash(s)
   a = 378551;
   b = 63689;
   h = 0;

   for i=1, string.len(s) do
      h = h * a + string.byte(s,i);
      a = a * b;
   end

   return h;
end


--[[

FlagRSP.getVersionNum(ver)

- Converts version string <ver> into numbers.

]]--
function FlagRSP.getVersionNum(ver)
   local release, major, minor;

   dotPos = string.find(ver, "%.");
   if dotPos ~= nil then 
      release = tonumber(string.sub(ver, 1, dotPos-1)); 
      ver = string.sub(ver, dotPos+1, string.len(ver));
   else 
      release = -1; 
   end
   
   dotPos = string.find(ver, "%.");
   if dotPos ~= nil then 
      major = tonumber(string.sub(ver, 1, dotPos-1));
      ver = string.sub(ver, dotPos+1, string.len(ver));
   else
      major = -1; 
   end

   minor = tonumber(string.sub(ver, 1, string.len(ver)));

   if minor == nil then
      minor = -1;
   end
   
   
   return release, major, minor;
end



--[[

FlagRSP.checkVersion(ver)

- Checks for a new version of flagRSP.

]]--
function FlagRSP.checkVersion(ver)
   --oldestVersion = "";
   --newestVersion = "";

   local release, major, minor = FlagRSP.getVersionNum(ver);
   
   local oR, oMj, oMn = FlagRSP.getVersionNum(FlagRSP.oldestVersion);
   local nR, nMj, nMn = FlagRSP.getVersionNum(FlagRSP.newestVersion);

   --FlagRSP.printDebug("version string is: " .. ver);
  
   local newVersion = false;

   if release ~= nil and major ~= nil and minor ~= nil and release >= 0 and major >= 0 and minor >= 0 then
      if release > FlagRSP.releaseVersion then
	 newVersion = true;
      elseif major > FlagRSP.majorVersion and release == FlagRSP.releaseVersion then
	 newVersion = true;
      elseif minor > FlagRSP.minorVersion and major == FlagRSP.majorVersion and release == FlagRSP.releaseVersion then
	 newVersion = true;
      end

      if release > nR then
	 FlagRSP.newestVersion = ver;
      elseif major > nMj and release == nR then
	 FlagRSP.newestVersion = ver;
      elseif minor > nMn and major == nMj and release == nR then
	 FlagRSP.newestVersion = ver;
      end

      if oR == -1 or oMj == -1 or oMn == -1 then
	 FlagRSP.oldestVersion = ver;
      end
      
      if release < oR then
	 FlagRSP.oldestVersion = ver;
      elseif major < oMj and release == oR then
	 FlagRSP.oldestVersion = ver;
      elseif minor < oMn and major == oMj and release == oR then
	 FlagRSP.oldestVersion = ver;
      end      
   end


   if newVersion then      
      FlagRSP.printDebug("New version available");
      FlagRSP.showVersionNotification(release, major, minor);
   end
end

function FlagRSP.getRPFlag()
   if FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].RPFlag == nil then
      FlagRSP.setRPFlag(0);
   end

   return FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].RPFlag;
end


function FlagRSP.setCharStatus(status)
   local mesg;
   local changed = false;

   if status ~= FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharStatus then
      if status == "ooc" then
	 mesg = FlagRSP_Locale_OOCFlag;
	 flagRSP_CharStatus[UnitName("player")] = "ooc";
	 FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharStatus = "ooc";
      elseif status == "ic" then
	 mesg = FlagRSP_Locale_ICFlag;
	 flagRSP_CharStatus[UnitName("player")] = "ic";
	 FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharStatus = "ic";
      elseif status == "ffa-ic" then
	 mesg = FlagRSP_Locale_FFAICFlag;
	 flagRSP_CharStatus[UnitName("player")] = "ffa-ic";
	 FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharStatus = "ffa-ic";
      elseif status == "none" then
	 mesg = FlagRSP_Locale_NoCFlag;
	 flagRSP_CharStatus[UnitName("player")] = "none";
	 FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharStatus = "none";
      elseif status == "st" then
	 mesg = FlagRSP_Locale_STFlag;
	 flagRSP_CharStatus[UnitName("player")] = "st";
         FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharStatus = "st";
      end
      
      FlagRSP.printM(mesg);
      changed = true;
   end

   return changed;
end 


function FlagRSP.getCharStatus()
   if FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharStatus == nil then
      FlagRSP.setCharStatus("none");
   end

   return FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharStatus;
end

function FlagRSP.getCharStatusNum()
   if FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharStatus == nil then
      FlagRSP.setCharStatus("none");
   end

   local num = 0; 
   local cStatus = FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharStatus;

   if cStatus == "none" then
      num = 0;
   elseif cStatus == "ooc" then
      num = 1;
   elseif cStatus == "ic" then
      num = 2;
   elseif cStatus == "ffa-ic" then
      num = 3;
   elseif cStatus == "st" then
      num = 4;
   end
      
   return num;
end

function FlagRSP.getOwnSurname()
   if FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].Surname == nil then
      FlagRSP.setSurname("");
   end

   return FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].Surname;
end


function FlagRSP.getOwnTitle()
   if FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].Title == nil then
      FlagRSP.setTitle("");
   end

   return FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].Title;
end

function FlagRSP.getOwnDesc()
   return FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharDesc;
end


function FlagRSP.setDesc(desc)
   changed = false;

   if desc ~= FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharDesc then
      FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharDescRev = FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharDescRev + 1;
      FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharDesc = desc;

      FlagRSP.printM(FlagRSP_Locale_DescUpdate);

      changed = true;
   end

   -- stop posting after change immediately.
   -- TODO: Stop posting only if current description has been changed.
   if changed then
      FlagRSPInfo.descPos = -1;
   end

   return changed;
end


function FlagRSP.setSurname(name)
   changed = false;

   if string.len(name) > 50 then
      name = string.sub(name,1,50);
   end

   if name ~= FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].Surname then
      xTP_CustomTag[UnitName("player")] = name;
      FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].Surname = name;
      
      if name == " " or name == "" then
	 FlagRSP.printM(FlagRSP_Locale_NoSurname);
      else
	 local msg = string.gsub(FlagRSP_Locale_NewSurname, "%%s", name);
	 FlagRSP.printM(msg);
      end

      changed = true;
   end

   return changed;
end


function FlagRSP.setTitle(title)
   changed = false;

   if string.len(title) > 50 then
      title = string.sub(title,1,50);
   end
   if title ~= FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].Title then
      xTP_CustomTag2[UnitName("player")] = title;
      FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].Title = title;

      if title == " " or title == "" then
	 FlagRSP.printM(FlagRSP_Locale_NoTitle);
      else
	 local msg = string.gsub(FlagRSP_Locale_NewTitle, "%%s", title);
	 FlagRSP.printM(msg);
      end
      
      changed = true;
   end

   return changed;
end   


   
function FlagRSP.enableRPTags()
   FlagRSP.setRPFlag(5);
   FlagRSP.setNameDisp(true);
   FlagRSP.setLevelDisp(true);
   
   -- flokru: Name and title notification, a bit quick and dirty.
   if FlagRSP.getOwnSurname() ~= NIL then
      FlagRSP.setSurname(FlagRSP.getOwnSurname());
   end
   if FlagRSP.getOwnTitle() ~= NIL then
      FlagRSP.setTitle(FlagRSP.getOwnTitle());
   end
   
   xTooltip_Post();
   
   --   if xTP_CustomTag[UnitName("player")] ~= NIL then
   --      if xTP_CustomTag[UnitName("player")] == " " or xTP_CustomTag[UnitName("player")] == "" then
   --	 DEFAULT_CHAT_FRAME:AddMessage(UnitName("player").. " besitzt keinen Nachnamen.");
   --      else
   --	 DEFAULT_CHAT_FRAME:AddMessage("Ihr seid bekannt als " ..UnitName("player").. " " ..xTP_CustomTag[UnitName("player")]);
   --     end
   --   end
   
   --   if xTP_CustomTag2[UnitName("player")] ~= NIL then
   --      if xTP_CustomTag2[UnitName("player")] == " " or xTP_CustomTag2[UnitName("player")] == "" then
   --	 DEFAULT_CHAT_FRAME:AddMessage("Ihr f\195\188hrt noch keinen Titel");
   --      else
   ---	 DEFAULT_CHAT_FRAME:AddMessage("Ihr f\195\188hrt den Titel " ..xTP_CustomTag2[UnitName("player")]);
   --      end
   --   end
end
   
function FlagRSP.disableRPTags()
   FlagRSP.setRPFlag(0);
   FlagRSP.setNameDisp(false);
   FlagRSP.setLevelDisp(false);

   -- flokru: However, we should give a notification here as well, so that
   --         players notice that there are still tags set.
   -- flokru: Name and title notification, a bit quick and dirty.
   if FlagRSP.getOwnSurname() ~= NIL then
      FlagRSP.setSurname(FlagRSP.getOwnSurname());
   end
   if FlagRSP.getOwnTitle() ~= NIL then
      FlagRSP.setTitle(FlagRSP.getOwnTitle());
   end
   
   xTooltip_Post();
end


--[[

FlagRSP.toggleAFK(msg)

- Toggles AFK for player and stops channel posting.

]]--
function FlagRSP.toggleAFK(msg, sentAfkMessage)
   --[[
   if msg ~= nil then
      FlagRSP.printDebug("AFK-Message: " .. msg);
   else
      FlagRSP.printDebug("AFK-Message: ");
      msg = "";
   end
   if flagRSP_AFK then
      flagRSP_AFK = false;
      FlagRSP.print(FlagRSP_Locale_AFK_Deactivated);
   else
      flagRSP_AFK = true;
      FlagRSP.print(FlagRSP_Locale_AFK_Activated);

      flagRSP_AFKPosx, flagRSP_AFKPosy = GetPlayerMapPosition("player");
      FlagRSP.printDebug("flagRSP: DEBUG: AFK: x_position: " .. flagRSP_AFKPosx .. " y_position: " .. flagRSP_AFKPosy);
   end
]]--

   --if sentAfkMessage then
   --   SendChatMessage(msg, "AFK");
   --end
end


--[[

FlagRSP.checkAFK(chatAuthor)

- Checks if player is still afk. If player is moving or entering chat 
  messages afk will be disabled.  
- Argument chatAuthor will be checked against player name.

]]--
function FlagRSP.checkAFK(chatAuthor)
   local posx, posy = GetPlayerMapPosition("player");

   if flagRSP_AFK then
      --FlagRSP.printDebug("Chat-Author: " .. chatAuthor);
      if chatAuthor ~= nil and chatAuthor ~= "" then
	 FlagRSP.printDebug("flagRSP: DEBUG: Chat author: " .. chatAuthor);
      end
      
      if chatAuthor == UnitName("player") then
	 FlagRSP.printDebug("flagRSP: DEBUG: Player sent chat message, AFK will be disabled.");
	 FlagRSP.toggleAFK("", false);
      end
      
      if posx ~= flagRSP_AFKPosx or posy~= flagRSP_AFKPosy then
	 FlagRSP.printDebug("flagRSP: DEBUG: Player moved, AFK will be disabled.");
	 FlagRSP.toggleAFK("", false);
      end
   end
end


--[[

FlagRSP.caughtChatMessage(arg1,arg2)

- Makes statistics on how much chat messages are in xtensionxtooltip2.

]]--
function FlagRSP.caughtChatMessage()
   FlagRSP.numMessagesInInterval = FlagRSP.numMessagesInInterval + 1;
   FlagRSP.bytesInInterval = FlagRSP.bytesInInterval + string.len(arg1) + string.len(arg2) + string.len(xTP_ChannelName);
   FlagRSP.bytesPerSession = FlagRSP.bytesPerSession + string.len(arg1) + string.len(arg2) + string.len(xTP_ChannelName);

   if FlagRSP.oldTick == 0 then FlagRSP.oldTick = GetTime(); end

   if GetTime() - FlagRSP.oldTick > 360 then
      FlagRSP.bytesPerSecondLastInterval = FlagRSP.bytesInInterval/(GetTime() - FlagRSP.oldTick);

      if FlagRSP.bytesPerSecondIntervalMax < FlagRSP.bytesPerSecondLastInterval then
	 FlagRSP.bytesPerSecondIntervalMax = FlagRSP.bytesPerSecondLastInterval;
      end

      --FlagRSP.bytesPerSession = FlagRSP.bytesPerSession + FlagRSP.bytesInInterval;
      FlagRSP.bytesInInterval = 0;

      t,o,oMax = FlagRSP.getStats();

      --FlagRSP.printDebug("online are: " .. o);

      local altinterval = FlagRSP.maxPostingCost * o / FlagRSP.postingTargetBps;
      local altintervalHigh = FlagRSP.maxPostingCostHigh * o / FlagRSP.postingTargetBpsHigh;

      --FlagRSP.printDebug("alt. interval would be: " .. altinterval);

      local messagesPerMinute = FlagRSP.numMessagesInInterval/(GetTime() - FlagRSP.oldTick)*60;
      local messageQuota = messagesPerMinute/FLAGRSP_TARGETMPM;

      --FlagRSP.postInterval = messageQuota * FlagRSP.postInterval;
      FlagRSP.postInterval = altinterval;
      FlagRSP.postIntervalHigh = altintervalHigh;
      
      if FlagRSP.postInterval<FLAGRSP_MININTERVAL then FlagRSP.postInterval = FLAGRSP_MININTERVAL; end
      if FlagRSP.postInterval>FLAGRSP_MAXINTERVAL then FlagRSP.postInterval = FLAGRSP_MAXINTERVAL; end

      if FlagRSP.postIntervalHigh<FLAGRSP_MININTERVALHIGH then FlagRSP.postIntervalHigh = FLAGRSP_MININTERVALHIGH; end
      if FlagRSP.postIntervalHigh>FLAGRSP_MAXINTERVALHIGH then FlagRSP.postIntervalHigh = FLAGRSP_MAXINTERVALHIGH; end

      -- Debug message for the developer.
      FlagRSP.printDebug("Chat channel usage statistics. Messages: " .. FlagRSP.numMessagesInInterval .. "  Number of messages per minute (last 6 minutes): " .. messagesPerMinute .. " Quota is: " .. messageQuota .. " new postinterval: " .. FlagRSP.postInterval);
      FlagRSP.printDebug("Bytes per second in the last interval: " .. FlagRSP.bytesPerSecondLastInterval);
      FlagRSP.printDebug("Bytes per second (whole session): " .. FlagRSP.bytesPerSession/(GetTime() - FlagRSP.sessionStartTick));

      FlagRSP.numMessagesInInterval = 0;
      FlagRSP.oldTick = GetTime();
   end
end


--[[

FlagRSP.playerIsIgnored(name)

- Checks, if player name is ignored.
- Returns true if ignored, false if not.

]]--
function FlagRSP.playerIsIgnored(name)
   local isIgnored = false;

   for t = 1, GetNumIgnores() do
      local iName = GetIgnoreName(t);
      if iName == name then 
	 isIgnored = true; 	
	 break; 
      end
   end

   return isIgnored;
end


--[[

FlagRSP.muteDataChannel()

- Mutes the communication channel for flagRSP.

]]--
function FlagRSP.muteDataChannel()
   if not flagRSP_Debug then
      ChatFrame_RemoveChannel(ChatFrame1, xTP_ChannelName);
   --else
   --   DEFAULT_CHAT_FRAME:AddMessage("debug?",1,1,0);
   end
end


--[[

FlagRSP.toggleRankDisp()

- Toggles displaying of PvP ranks.

]]--
function FlagRSP.toggleRankDisp()
   if not FlagRSP.getRankDisp() then
      FlagRSP.setRankDisp(true);
   else
      FlagRSP.setRankDisp(false);
   end
end


--[[

FlagRSP.toggleGuildDisp()

- Toggles displaying of guild names in tooltip.

]]--
function FlagRSP.toggleGuildDisp()
   if FlagRSP.getGuildDisp() == 0 then
      FlagRSP.setGuildDisp(1);
   elseif FlagRSP.getGuildDisp() == 1 then
      FlagRSP.setGuildDisp(-1);
   elseif FlagRSP.getGuildDisp() == -1 then
      FlagRSP.setGuildDisp(0);
   end
end


--[[

FlagRSP.setRankDisp()

- Sets rank display.

]]--
function FlagRSP.setRankDisp(value)
   local mesg;

   if value == 0 then value = false; end
   if value == 1 then value = true; end
   
   if value ~= true and value ~= false then return; end

   if value then
      mesg = FlagRSP_Locale_ShowRanks;
      flagRSP_ShowRanks[UnitName("player")] = 1;
      FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].showRanks = true;
   else
      mesg = FlagRSP_Locale_HideRanks;
      flagRSP_ShowRanks[UnitName("player")] = 0;
      FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].showRanks = false;
   end

   FlagRSP.printM(mesg);
end


--[[

FlagRSP.getRankDisp()

- Gets rank display option.

]]--
function FlagRSP.getRankDisp()
   return FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].showRanks;
end


--[[

FlagRSP.setGuildDisp()

- Sets guild display.

]]--
function FlagRSP.setGuildDisp(value)
   local mesg;

   if value == false then value = -1; end
   if value == true then value = 1; end

   if value ~= 1 and value ~= -1 and value ~= 0 then return; end

   if value == 1 then
      mesg = FlagRSP_Locale_ShowAllGuild;
      flagRSP_ShowGuild[UnitName("player")] = 1;
      FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].showGuilds = 1;
   elseif value == -1 then
      mesg = FlagRSP_Locale_HideGuild;
      flagRSP_ShowGuild[UnitName("player")] = 0;
      FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].showGuilds = -1;
   elseif value == 0 then
      mesg = FlagRSP_Locale_ShowKnownGuild;
      flagRSP_ShowGuild[UnitName("player")] = 0;
      FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].showGuilds = 0;
   end

   FlagRSP.printM(mesg);
end


--[[

FlagRSP.getGuildDisp()

- Gets guild display option.

]]--
function FlagRSP.getGuildDisp(value)
   return FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].showGuilds;
end


--[[

FlagRSP.plotStatus()

- Gives an overview over all settings.

]]--
function FlagRSP.plotStatus()
   FlagRSP.setRPFlag(FlagRSP.getRPFlag());
   FlagRSP.setCharStatus(FlagRSP.getCharStatus());
   FlagRSP.setNameDisp(FlagRSP.getNameDisp());
   FlagRSP.setLevelDisp(FlagRSP.getLevelDisp());
   FlagRSP.setRankDisp(FlagRSP.getRankDisp());
   FlagRSP.setGuildDisp(FlagRSP.getGuildDisp());
   FlagRSP.setSurname(FlagRSP.getOwnSurname());
   FlagRSP.setTitle(FlagRSP.getOwnTitle());
end


--[[

FlagRSP.showOwnTooltip()

- Shows the tooltip for the player.

]]--
function FlagRSP.showOwnTooltip()
   --tt = getglobal("FlagRSPTooltip");
   local tt = getglobal("GameTooltip");

   local ttline = getglobal("GameTooltipTextLeft1"):GetText();
   
   if not tt:IsVisible() or string.find(ttline, FlagRSP.pName) == nil then
      tt:SetOwner(UIParent, "ANCHOR_NONE");
      tt:SetPoint("TOP", "UIParent", "TOP", 0, -32);
      
      tooltipLinesLeft = {};
      tooltipLinesLeft[1] = "";
      tooltipLinesRight = {};
      
      tt:SetBackdropColor(TooltipHandler.getTooltipBGColor("player"));
      TooltipHandler.compileTooltip(tooltipLinesLeft, tooltipLinesRight, TooltipModifierSelf, tt:GetName(), "player");
      tt:Show();
   else
      --tt:Hide();
   end
end


--[[

FlagRSP.printDebug(msg)

- Gives a debug message msg.

]]--
function FlagRSP.printDebug(msg)
   if flagRSP_Debug and msg ~= nil then
      ChatFrame3:AddMessage("|CFF" .. FlagRSP.getHexString(1*255,2) .. FlagRSP.getHexString(1*255,2) .. FlagRSP.getHexString(0.5*255,2) .. "<flagRSP> DEBUG:|r " .. msg,1,1,1);
   end
end


--[[

FlagRSP.print(msg)

- Prints message msg.

]]--
function FlagRSP.print(msg, frame)
   if frame == nil then
      frame = DEFAULT_CHAT_FRAME;
   end

   frame:AddMessage(msg,1,1,0);
end


--[[

FlagRSP.printM(msg)

-- Prints message msg in flagRSP style.

]]--
function FlagRSP.printM(msg)
   DEFAULT_CHAT_FRAME:AddMessage("|CFF" .. FlagRSP.getHexString(1*255,2) .. FlagRSP.getHexString(1*255,2) .. FlagRSP.getHexString(0.5*255,2) .. "<flagRSP>|r " .. msg,1,1,1);
end


--[[

FlagRSP.printE(msg)

-- Prints error message msg in flagRSP style.

]]--
function FlagRSP.printE(msg)
   DEFAULT_CHAT_FRAME:AddMessage("|CFF" .. FlagRSP.getHexString(1*255,2) .. FlagRSP.getHexString(1*255,2) .. FlagRSP.getHexString(0.5*255,2) .. "<flagRSP>|r|CFF" .. FlagRSP.getHexString(1*255,2) .. FlagRSP.getHexString(0*255,2) .. FlagRSP.getHexString(0*255,2) .. "<ERROR>|r" .. msg,1,1,1);
end


--[[

FlagRSP.printA(msg)

-- Prints assertion message msg in flagRSP style.

]]--
function FlagRSP.printA(number)
   FlagRSP.printM("|Cffff0000ASSERTION #" .. number .. " FAILED!|r Please contact flagRSP developer!");
end


function FlagRSPNewVersionNotificationCheckButton_OnClick()
   checkState = FlagRSPNewVersionNotificationCheckButton:GetChecked();
   if checkState == nil then
      FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].ShowVersionNotification = true;
   elseif checkState == 1 then
      FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].ShowVersionNotification = false;
   end
end

function FlagRSPDYKBoxCheckButton_OnClick()
   checkState = FlagRSPDYKBoxCheckButton:GetChecked();
   if checkState == nil then
      FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].ShowTips = true;
   elseif checkState == 1 then
      FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].ShowTips = false;
   end
end

function FlagRSP.showVersionNotification(r, m, n)
   if not UnitAffectingCombat("player") and FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].ShowVersionNotification and not FlagRSP.notificationSeen then
      FlagRSPNewVersionNotification:SetWidth(450);
      FlagRSPNewVersionNotification:SetHeight(100);
      FlagRSPNewVersionNotification:Show();
      --FlagRSPNewVersionNotification:SetAlpha(1);
      FlagRSPNewVersionNotification:SetBackdropColor(0,0,0,0.9);

      local text = FlagRSP_Locale_NewVersionText;
      
      text = string.gsub(text, "%%r", r)
      text = string.gsub(text, "%%m", m)
      text = string.gsub(text, "%%n", n)

      FlagRSPNewVersionNotificationTitleText:SetText(FlagRSP_Locale_NewVersionTitle);
      FlagRSPNewVersionNotificationText:SetText(text);
      FlagRSPNewVersionNotificationCheckButtonText:SetText(FlagRSP_Locale_NewVersionCheckButton);
      FlagRSPNewVersionNotificationText:SetWidth(410);
      
      FlagRSPNewVersionNotificationText:SetTextHeight(14);
      FlagRSPNewVersionNotification:SetScale(2);
      FlagRSPNewVersionNotification:SetScale(1);
      
      --FlagRSPNewVersionNotificationTitle:SetWidth(FlagRSPNewVersionNotificationTitleText:GetWidth()+40);
      
      --FlagRSP.printDebug("flagRSP: a buttons height is: " .. FlagRSPNewVersionNotificationAccept:GetHeight());
      
      FlagRSPNewVersionNotificationCheckButton:SetPoint("BOTTOMLEFT", FlagRSPNewVersionNotification:GetName(), "BOTTOMLEFT", 20, FlagRSPNewVersionNotificationAccept:GetHeight()+20);
      
      FlagRSPNewVersionNotification:SetPoint("TOP", "UIParent", "TOP", 0, -150);
      FlagRSPNewVersionNotification:SetPoint("BOTTOM", "UIParent", "TOP", 0, -220-FlagRSPNewVersionNotificationText:GetHeight()-FlagRSPNewVersionNotificationAccept:GetHeight()-FlagRSPNewVersionNotificationCheckButton:GetHeight());
      
      --FlagRSPDescEditor:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 10, -600);

      FlagRSP.notificationSeen = true;
   end
end


function FlagRSPDescWarnBoxAccept_OnClick()
   --PlaySound("gsTitleOptionOK");
   --FRIENDLISTStaticPopUpEdit_EditBoxOnEnterPressed();
   FlagRSPDescWarnBox:Hide();
   --FlagRSPDescEditor:Show();
   --FlagRSPDescEditorEditBox:Show();
   --FlagRSPDescEditor:SetBackdropColor(0,0,0,0.3);
   --FlagRSPDescEditorEditBox:SetText(FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharDesc);
   
   --FlagRSPDescEditor:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 10, -150);
   
   Friendlist.descBoxWarningSeen = true;
end

function FlagRSP.showEditBox()
   FlagRSPDescWarnBox:SetWidth(550);
   FlagRSPDescWarnBox:SetHeight(100);
   FlagRSPDescWarnBox:Show();
   --FlagRSPDescWarnBox:SetAlpha(1);
   FlagRSPDescWarnBox:SetBackdropColor(0,0,0,0.9);
   
   FlagRSPDescWarnBoxTitleText:SetText(FlagRSP_Locale_DescWarnTitle);
   FlagRSPDescWarnBoxText:SetText(FlagRSP_Locale_DescWarnText);
   FlagRSPDescWarnBoxText:SetWidth(510);

   FlagRSPDescWarnBoxText:SetTextHeight(12);
   FlagRSPDescWarnBox:SetScale(2);
   FlagRSPDescWarnBox:SetScale(1);

   --FlagRSP.printDebug("flagRSP: a buttons height is: " .. FlagRSPDescWarnBoxAccept:GetHeight());

   FlagRSPDescWarnBox:SetPoint("TOP", "UIParent", "TOP", 0, -150);
   FlagRSPDescWarnBox:SetPoint("BOTTOM", "UIParent", "TOP", 0, -220-FlagRSPDescWarnBoxText:GetHeight()-FlagRSPDescWarnBoxAccept:GetHeight());

   --FlagRSPDescEditor:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 10, -600);
end


function FlagRSP.showDYKBox(nextTip)
   if nextTip == nil then
      nextTip = false;
   end

   --FlagRSP.printM("test");

   FlagRSPDYKBox:SetWidth(550);
   FlagRSPDYKBox:SetHeight(100);
   FlagRSPDYKBox:Show();
   --FlagRSPDYKBox:SetAlpha(1);
   FlagRSPDYKBox:SetBackdropColor(0,0,0,0.9);
   
   if FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].ShowTips then
      FlagRSPDYKBoxCheckButton:SetChecked(0);
   else
      FlagRSPDYKBoxCheckButton:SetChecked(1);
   end
   
   local text = FlagRSP_Locale_TipText[math.random(1,table.getn(FlagRSP_Locale_TipText))];

   --FlagRSP.printM(text);

   FlagRSPDYKBoxCheckButtonText:SetText(FlagRSP_Locale_DYKCheckText);
   
   FlagRSPDYKBoxTitleText:SetText(FlagRSP_Locale_DYKTitle);
   --TooltipHandler.compileString(
   FlagRSPDYKBoxText:SetText(text);
   FlagRSPDYKBoxText:SetWidth(510);
   
   FlagRSPDYKBoxAccept:Hide();  
   
   FlagRSPDYKBoxText:SetTextHeight(12);
   FlagRSPDYKBox:SetScale(2);
   FlagRSPDYKBox:SetScale(1);
   
   --FlagRSP.printDebug("flagRSP: a buttons height is: " .. FlagRSPDYKBoxAccept:GetHeight());
   
   FlagRSPDYKBoxCheckButton:SetPoint("BOTTOMLEFT", "FlagRSPDYKBox", "BOTTOMLEFT", 20, FlagRSPDYKBoxClose:GetHeight()+20); 
   
   FlagRSPDYKBox:SetPoint("TOP", "UIParent", "TOP", 0, -150);
   FlagRSPDYKBox:SetPoint("BOTTOM", "UIParent", "TOP", 0, -220-FlagRSPDYKBoxText:GetHeight()-FlagRSPDYKBoxAccept:GetHeight()- FlagRSPDYKBoxCheckButton:GetHeight());
   
end



function FlagRSP.showWelcomeBox(full)
   FlagRSPWelcomeBox:SetWidth(550);
   FlagRSPWelcomeBox:SetHeight(100);
   FlagRSPWelcomeBox:Show();
   --FlagRSPWelcomeBox:SetAlpha(1);
   FlagRSPWelcomeBox:SetBackdropColor(0,0,0,0.9);
   
   local text
   if full then
      text = TooltipHandler.compileString(FlagRSP_Locale_WelcomeHeader .. FlagRSP_Locale_WelcomeText .. FlagRSP_Locale_WelcomeHomepage ..  FlagRSP_Locale_WelcomeChanges);
   else
      text = TooltipHandler.compileString(FlagRSP_Locale_WelcomeHeader .. FlagRSP_Locale_WelcomeHomepage .. FlagRSP_Locale_WelcomeChanges);
   end

   FlagRSPWelcomeBoxTitleText:SetText(FlagRSP_Locale_WelcomeTitle);
   --TooltipHandler.compileString(
   FlagRSPWelcomeBoxText:SetText(text);
   FlagRSPWelcomeBoxText:SetWidth(510);

   FlagRSPWelcomeBoxText:SetTextHeight(12);
   FlagRSPWelcomeBox:SetScale(2);
   FlagRSPWelcomeBox:SetScale(1);

   --FlagRSP.printDebug("flagRSP: a buttons height is: " .. FlagRSPWelcomeBoxAccept:GetHeight());

   FlagRSPWelcomeBox:SetPoint("TOP", "UIParent", "TOP", 0, -150);
   FlagRSPWelcomeBox:SetPoint("BOTTOM", "UIParent", "TOP", 0, -220-FlagRSPWelcomeBoxText:GetHeight()-FlagRSPWelcomeBoxAccept:GetHeight());

   --FlagRSPDescEditor:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 10, -600);
end


function FlagRSPWelcomeBoxAccept_OnClick()
   FlagRSPWelcomeBox:Hide();

   if FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].ShowTips then
      FlagRSP.showDYKBox();
   end
end


--[[

flagRSP local functions.

]]--
function xTooltip_OnLoad()
   
   this:RegisterEvent("PLAYER_ENTERING_WORLD");
   this:RegisterEvent("ADDON_LOADED");
   this:RegisterEvent("ZONE_CHANGED_NEW_AREA");

   --this:RegisterEvent("CHAT_MSG_SAY");
   this:RegisterEvent("CHAT_MSG_SYSTEM");
   --this:RegisterEvent("CHAT_MSG_PARTY");
   --this:RegisterEvent("CHAT_MSG_RAID");
   --this:RegisterEvent("CHAT_MSG_EMOTE");
   --this:RegisterEvent("CHAT_MSG_GUILD");
   --this:RegisterEvent("CHAT_MSG_OFFICER");
   --this:RegisterEvent("CHAT_MSG_YELL");
   --this:RegisterEvent("CHAT_MSG_WHISPER_INFORM");
   this:RegisterEvent("CHAT_MSG_CHANNEL");

   this:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
   this:RegisterEvent("PLAYER_TARGET_CHANGED");
   
   --SlashCmdList["RSPAFK"] = FlagRSP.toggleAFK();
   --SLASH_RSPAFK1 = "/afk";

   SlashCmdList["RSP"] = xTooltip_Msg;
   SLASH_RSP1 = "/rsp";
   SlashCmdList["RSPAN"] = FlagRSP.enableRPTags;
   SLASH_RSPAN1 = "/rspan";
   SLASH_RSPAN2 = "/rspon";
   SlashCmdList["RSPAUS"] = FlagRSP.disableRPTags;
   SLASH_RSPAUS1 = "/rspaus";
   SLASH_RSPAUS2 = "/rspoff";

   SlashCmdList["RPHELP"] = FlagRSP.sendRPTicket;
   SLASH_RPHELP1 = "/rpticket";
   SLASH_RPHELP2 = "/rphelp";

   SlashCmdList["RELOADUI"] = ReloadUI;
   SLASH_RELOADUI1 = "/rui";
   SLASH_RELOADUI2 = "/reloadui";

   FlagRSP_Version = FlagRSP.versionString;
   FlagRSP.VERSION = FlagRSP_Version;
end


function flagRSP_toggleHideNames()
   if not FlagRSP.getNameDisp() then
      FlagRSP.setNameDisp(true);
   else
      FlagRSP.setNameDisp(false); 
  end
end

function flagRSP_toggleLevelDisp()
   if not FlagRSP.getLevelDisp() then
      FlagRSP.setLevelDisp(true);
   else
      FlagRSP.setLevelDisp(false);
   end
end


function FlagRSP.setNameDisp(value)
   local mesg;

   if value == 0 then value = false; end
   if value == 1 then value = true; end

   if value ~= true and value ~= false then return; end

   if value then
      mesg = FlagRSP_Locale_HideNames;
      xTP_NameChange[UnitName("player")] = 1;
      FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].nameChange = true;
   else
      mesg = FlagRSP_Locale_UnhideNames;
      xTP_NameChange[UnitName("player")] = 0;
      FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].nameChange = false;
   end

   FlagRSP.printM(mesg);
end


function FlagRSP.getNameDisp()
   return FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].nameChange;
end


function FlagRSP.setLevelDisp(value)
   local mesg;

   if value == 0 then value = false; end
   if value == 1 then value = true; end

   if value ~= true and value ~= false then return; end

   if value then
      mesg = FlagRSP_Locale_HideLevels;
      xTP_LevelChange[UnitName("player")] = 1;
      FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].levelChange = true;
   else
      mesg = FlagRSP_Locale_UnhideLevels;
      xTP_LevelChange[UnitName("player")] = 0;
      FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].levelChange = false;
   end

   FlagRSP.printM(mesg);
end


function FlagRSP.getLevelDisp()
   if not FlagRSPConfigure.isInitialized() then
      return false;
   end
   if FlagRSPConfigure.loaded == false then
      return false;
   end

   --FlagRSP.printM("realm: " .. FlagRSP.rName);
   --FlagRSP.printM("player: " .. FlagRSP.pName);

   return FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].levelChange;
end


function FlagRSP.setRPFlag(RPType)
   local mesg;
   local changed = false;

   if RPType < 0 or RPType > 5 then return; end

   if RPType ~= FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].RPFlag then
      if RPType == 0 then
	 -- flokru: Now we save roleplaying behaviour before unsetting rp-flag.
	 if FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].RPFlag ~= 0 then
	    
	    FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].OldRPFlag = FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].RPFlag;
	    xTP_RPTag[FlagRSP.pName .. "1"] = FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].RPFlag;
	 end
	 
	 mesg = FlagRSP_Locale_NoRPFlagSet;
      elseif RPType == 1 then
	 mesg = FlagRSP_Locale_NormalRPFlagSet;
      elseif RPType == 2 then
	 mesg = FlagRSP_Locale_CasualFlagSet;
      elseif RPType == 3 then
	 mesg = FlagRSP_Locale_FulltimeFlagSet;
      elseif RPType == 4 then
	 mesg = FlagRSP_Locale_BeginnerFlagSet;
      elseif RPType == 5 then
	 -- flokru: I love recursion :)
	 if FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].OldRPFlag ~= nil then
	    FlagRSP.setRPFlag(FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].OldRPFlag);
	 else
	    FlagRSP.setRPFlag(1);
	 end
	 return;
      end
      
      FlagRSP.printM(mesg);
      FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].RPFlag = RPType;
      xTP_RPTag[FlagRSP.pName] = RPType;

      changed = true;
   end

   return changed;
end


function xTooltip_Msg(msg)

   if string.lower(string.sub(msg, 1, string.len(FlagRSP_Locale_HideNames_Cmd))) == FlagRSP_Locale_HideNames_Cmd then
      flagRSP_toggleHideNames();
      
   elseif string.lower(string.sub(msg, 1, 4)) == "stat" then      
      FlagRSP.plotStats();

   elseif string.lower(string.sub(msg, 1, 7)) == "collect" then      
      if FlagRSP.collecting then
	 FlagRSP.printM(FlagRSP_Locale_NoCollecting);
	 FlagRSP.collecting = false;
      else
	 FlagRSP.printM(FlagRSP_Locale_Collecting);
	 FlagRSP.collecting = true;
      end

   elseif string.lower(string.sub(msg, 1, 7)) == "welcome" then      
      FlagRSP.showWelcomeBox();

   elseif string.lower(string.sub(msg, 1, 4)) == "tips" then      
      FlagRSP.showDYKBox();

   elseif string.lower(msg) == "standby" then
      if FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].standby then
	 FlagRSP.printM(FlagRSP_Locale_NoStandBy);
	 FlagRSP_JoinChannel();
	 FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].standby = false;
	 FlagRSP.standby = false;
      else
	 FlagRSP.printM(FlagRSP_Locale_StandBy);
	 FlagRSP.printM(FlagRSP_Locale_StandBy2);
	 FlagRSP_LeaveChannel();
	 FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].standby = true;
	 FlagRSP.standby = true;
      end
            
   elseif string.lower(string.sub(msg, 1, string.len(FlagRSP_Locale_LevelDisp_Cmd))) == FlagRSP_Locale_LevelDisp_Cmd then
      flagRSP_toggleLevelDisp();

   elseif string.lower(string.sub(msg, 1, string.len(FlagRSP_Locale_RankDisp_Cmd))) == FlagRSP_Locale_RankDisp_Cmd then
      FlagRSP.toggleRankDisp();

   elseif string.lower(string.sub(msg, 1, string.len(FlagRSP_Locale_GuildDisp_Cmd))) == FlagRSP_Locale_GuildDisp_Cmd then
      FlagRSP.toggleGuildDisp();

   elseif string.lower(string.sub(msg, 1, string.len(FlagRSP_Locale_Beginner_Cmd))) == FlagRSP_Locale_Beginner_Cmd then
      FlagRSP.setRPFlag(4);
      
   elseif string.lower(string.sub(msg, 1, string.len(FlagRSP_Locale_Casual_Cmd))) == FlagRSP_Locale_Casual_Cmd then
      FlagRSP.setRPFlag(2);
      
   elseif string.lower(string.sub(msg, 1, string.len(FlagRSP_Locale_Normal_Cmd))) == FlagRSP_Locale_Normal_Cmd then
      FlagRSP.setRPFlag(1);
            
   elseif string.lower(string.sub(msg, 1, string.len(FlagRSP_Locale_Fulltime_Cmd))) == FlagRSP_Locale_Fulltime_Cmd then
      FlagRSP.setRPFlag(3);
      
   elseif string.lower(string.sub(msg, 1, string.len(FlagRSP_Locale_NoRP_Cmd))) == FlagRSP_Locale_NoRP_Cmd then
      FlagRSP.setRPFlag(0);

   elseif string.lower(string.sub(msg, 1, string.len(FlagRSP_Locale_OOC_Cmd))) == FlagRSP_Locale_OOC_Cmd then
      FlagRSP.setCharStatus("ooc");

   elseif string.lower(string.sub(msg, 1, string.len(FlagRSP_Locale_IC_Cmd))) == FlagRSP_Locale_IC_Cmd then
      FlagRSP.setCharStatus("ic");

   elseif string.lower(string.sub(msg, 1, string.len(FlagRSP_Locale_ICFFA_Cmd))) == FlagRSP_Locale_ICFFA_Cmd then
      FlagRSP.setCharStatus("ffa-ic");

   elseif string.lower(string.sub(msg, 1, string.len(FlagRSP_Locale_ST_Cmd))) == FlagRSP_Locale_ST_Cmd then
      FlagRSP.setCharStatus("st");

   elseif string.lower(string.sub(msg, 1, string.len(FlagRSP_Locale_NoCStatus_Cmd))) == FlagRSP_Locale_NoCStatus_Cmd then
      FlagRSP.setCharStatus("none");

   elseif string.lower(string.sub(msg, 1, string.len(FlagRSP_Locale_Status_Cmd))) == FlagRSP_Locale_Status_Cmd then
      FlagRSP.plotStatus();

   elseif string.lower(string.sub(msg, 1, 7)) == "postlow" then      
      xTooltip_Post("low");

   elseif string.lower(string.sub(msg, 1, 8)) == "posthigh" then      
      xTooltip_Post("high");
      
   elseif string.lower(string.sub(msg, 1, 4)) == "post" then      
      xTooltip_Post();

   elseif string.lower(msg) == "toggletooltip" then      
      if FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].modifyTooltip == 1 then
	 FlagRSP.printM(FlagRSP_Locale_LightModifyTooltip);
	 FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].modifyTooltip = 0;
      elseif FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].modifyTooltip == 0 then
	 FlagRSP.printM(FlagRSP_Locale_NoModifyTooltip);
	 FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].modifyTooltip = -1;
      elseif FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].modifyTooltip == -1 then
	 FlagRSP.printM(FlagRSP_Locale_ModifyTooltip);
	 FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].modifyTooltip = 1;
      end

   elseif string.lower(string.sub(msg, 1, string.len("purgeinterval"))) == "purgeinterval" then
      FlagRSP.printDebug("new purge interval: " .. string.sub(msg, string.len("purgeinterval")+2, string.len(msg)));
      if string.len(msg) > string.len("purgeinterval")+1 then
	 local n = tonumber(string.sub(msg, string.len("purgeinterval")+2, string.len(msg)));
	 
	 if n ~= nil then
	    FlagRSPSettings.FlagPurgeInterval = n*86400;
	    FlagRSP.printDebug("new purge interval (set): " .. FlagRSPSettings.FlagPurgeInterval);
	    local msg = string.gsub(FlagRSP_Locale_PurgeInterval, "%%s", n);
	    FlagRSP.printM(msg);
	 end
      else
	 local msg = string.gsub(FlagRSP_Locale_PurgeInterval, "%%s", math.floor(FlagRSPSettings.FlagPurgeInterval/86400*10)/10);
	 FlagRSP.printM(msg);
      end	 

   elseif string.lower(msg) == "purge" then
      FlagHandler.purgeAllFlags();

   elseif string.lower(string.sub(msg, 1, 6)) == "toggle" then
      if FlagRSP.getRPFlag() == 0 then
	 FlagRSP.setRPFlag(5);
      else
	 FlagRSP.setRPFlag(0);
      end
      xTooltip_Post();
      
   elseif string.lower(string.sub(msg, 1, string.len(FlagRSP_Locale_Surname_Cmd))) == FlagRSP_Locale_Surname_Cmd then
      FlagRSP.setSurname(string.sub(msg, string.len(FlagRSP_Locale_Surname_Cmd)+2, string.len(msg)));

   elseif string.lower(string.sub(msg, 1, string.len(FlagRSP_Locale_Title_Cmd))) == FlagRSP_Locale_Title_Cmd then
      FlagRSP.setTitle(string.sub(msg, string.len(FlagRSP_Locale_Title_Cmd)+2, string.len(msg)));

   elseif string.lower(string.sub(msg, 1, string.len(FlagRSP_Locale_AFK_Cmd))) == FlagRSP_Locale_AFK_Cmd then
      SendChatMessage(string.sub(msg, string.len(FlagRSP_Locale_AFK_Cmd)+2, string.len(msg)), "AFK");
      --FlagRSP.toggleAFK(string.sub(msg, string.len(FlagRSP_Locale_AFK_Cmd)+2, string.len(msg)), true);
      
   elseif string.lower(string.sub(msg, 1, string.len("edit"))) == "edit" then
      FRIENDLIST_ToggleGUI();
      Friendlist_TabHandler(2);

   elseif string.lower(string.sub(msg, 1, string.len("tmulti"))) == "tmulti" then
      FlagRSP.chatMessageHandler("<RP>53.2332<CS3><DV>A2<W>Ooops<V>0.5.0", "Gorrmar")

   elseif string.lower(string.sub(msg, 1, string.len("uinames"))) == "uinames" then
      FlagRSP.printDebug(GetCVar("UnitNamePlayer"));
      if GetCVar("UnitNamePlayer") == "1" then
	 FlagRSP.printM(FlagRSP_Locale_UINamesDisabled);
	 SetCVar("UnitNamePlayer","0");
      elseif GetCVar("UnitNamePlayer") == "0" then
	 FlagRSP.printM(FlagRSP_Locale_UINamesEnabled);
	 SetCVar("UnitNamePlayer","1");
      end

   elseif string.lower(string.sub(msg, 1, string.len("alwaysinfobox"))) == "alwaysinfobox" then
      if FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].alwaysShowInfoBox then
	 FlagRSP.printM(FlagRSP_Locale_InfoBoxTradBehaviour);
	 FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].alwaysShowInfoBox = false;
      else 
	 FlagRSP.printM(FlagRSP_Locale_AlwaysShowInfoBox);
	 FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].alwaysShowInfoBox = true;
      end
      
   elseif string.lower(string.sub(msg, 1, string.len("resetbutton"))) == "resetbutton" then
      FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].InfoBoxButtonX = -1;
      FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].InfoBoxButtonY = -1;
      --FlagRSPInfoBoxButton:SetPoint("CENTER", "TargetFrame", "CENTER", 65, 30);
      
            
   elseif string.lower(string.sub(msg, 1, 4)) == "plot" then
      if flagRSP_Debug then
	 FlagRSP_plotList();
      end
   elseif string.lower(string.sub(msg, 1, string.len(FlagRSP_Locale_OwnTooltip_Cmd))) == FlagRSP_Locale_OwnTooltip_Cmd then
      if not FlagRSP.displayOwnTooltip then
	 FlagRSP.displayOwnTooltip = true;
	 FlagRSP.showOwnTooltip();
      else
	 FlagRSP.displayOwnTooltip = false;	 
      end
      
   elseif string.lower(string.sub(msg, 1, 5)) == "debug" then
      if flagRSP_Debug then
	 FlagRSP.printM("Left debug mode.",1.0, 1.0, 0.0);
	 flagRSP_Debug = false;
      else
	 FlagRSP.printM("Entered debug mode.",1.0, 1.0, 0.0);
	 flagRSP_Debug = true;
      end

   else
      --DEFAULT_CHAT_FRAME:AddMessage("--Rollenspiel Flag Hilfe--",1.0, 1.0, 0.0);
      --DEFAULT_CHAT_FRAME:AddMessage("/rsp -> (de)aktiviert Rollenspieler flag");
      --DEFAULT_CHAT_FRAME:AddMessage("/rsp namen  -> (de)aktiviert die Namensanzeige unbekannter Personen");
      --DEFAULT_CHAT_FRAME:AddMessage("/rsp level      -> (de)aktiviert die alternativen Level Anzeigen");
      --DEFAULT_CHAT_FRAME:AddMessage("/rsp nachname <text> -> weist ihrem Charakter einen Nachnamen zu");
      --DEFAULT_CHAT_FRAME:AddMessage("/rsp titel <text> -> weist ihrem Charakter einen Titel zu");
      --DEFAULT_CHAT_FRAME:AddMessage("/add <name> <nachname> <notiz> -> setzt einen Spieler auf die Freundesliste", 1.0, 1.0, 0.0);
      --DEFAULT_CHAT_FRAME:AddMessage("/rsp beginner/leicht/normal/dauer/aus  -> setzt ihre Rollenspielart");
      --DEFAULT_CHAT_FRAME:AddMessage("beginner weist sie als neugierigen Rollenspiel Anf\195\164nger aus.",0.0, 1.0, 0.0);
      --DEFAULT_CHAT_FRAME:AddMessage("leicht entspricht 'leichtem' Rollenspiel (teilweises ooc erlaubt)",0.0, 1.0, 1.0);
      --DEFAULT_CHAT_FRAME:AddMessage("normal setzt das Standard Rollenspiel flag",1.0, 1.0, 0.0);
      --DEFAULT_CHAT_FRAME:AddMessage("dauer entspricht Dauer-Rollenspiel ('out of character' Sprache unerw\195\188nscht)",1.0, 0.0, 1.0);
      --DEFAULT_CHAT_FRAME:AddMessage("aus bedeutet: kein Rollenspielflag gesetzt.",1.0, 0.0, 0.0);
      --DEFAULT_CHAT_FRAME:AddMessage("/rspan  -> aktiviert alles und setzt das Standard Rollenspielflag");
      --DEFAULT_CHAT_FRAME:AddMessage("/rspaus -> deaktiviert alles");

      t = 0;
      while FlagRSP_Locale_Help[t] ~= nil do
	 DEFAULT_CHAT_FRAME:AddMessage(FlagRSP_Locale_Help[t],1.0, 1.0, 1.0);
	 t = t + 1;
      end
   end
end


function FlagRSP_JoinChannel()
   id = GetChannelName(xTP_ChannelName);

   --DEFAULT_CHAT_FRAME:AddMessage("DEBUG: JoinChannel, id is:" .. id);

   if not (id >= 1) then 
      FlagRSP.printM(FlagRSP_Locale_ReJoinedChannel);
      xTP_ChannelName = "xtensionxtooltip2";
      JoinChannelByName(xTP_ChannelName, "", DEFAULT_CHAT_FRAME:GetID());
      id = GetChannelName(xTP_ChannelName);
   end
end


function FlagRSP_LeaveChannel()
   xTP_ChannelName = "xtensionxtooltip2";
   LeaveChannelByName(xTP_ChannelName);
end


function xTooltip_OnEvent(event)
   
   if event == "PLAYER_ENTERING_WORLD" or event == "ADDON_LOADED" then
      
      if not FlagRSP.playerEnteredWorld then

	 FlagRSPConfigure.isInitialized();

	 if xTP_NameChange[UnitName("player")] == nil then xTP_NameChange[UnitName("player")] = 0; end
	 if xTP_LevelChange[UnitName("player")] == nil then xTP_LevelChange[UnitName("player")] = 0; end
	 if xTP_RPTag[UnitName("player")] == nil then xTP_RPTag[UnitName("player")] = 0; end
	 if xTP_CustomTag[UnitName("player")] == nil then xTP_CustomTag[UnitName("player")] = ""; end
	 if xTP_CustomTag2[UnitName("player")] == nil then xTP_CustomTag2[UnitName("player")] = ""; end
	 
	 --xTP_RPList = {};
	 --xTP_NumInList = 0;
	 --xTP_CTList = {};
	 --xTP_CTList2 = {};
	 
	 FlagRSP.newTickPost = GetTime() + 60;
	 FlagRSP.newTickPostHigh = GetTime() + 50;
	 
	 t = 0;
	 while FlagRSP_Locale_OnLoad[t] ~= nil do
	    FlagRSP.printM(TooltipHandler.compileString(FlagRSP_Locale_OnLoad[t]),1.0, 1.0, 0.0);
	    t = t + 1;
	 end

	 FlagRSP.sessionStartTick = GetTime();
	 
	 table.insert(UnitPopupMenus["PLAYER"], table.getn(UnitPopupMenus["PLAYER"]), "FLAGRSP_ADDEDIT");
	 table.insert(UnitPopupMenus["PLAYER"], table.getn(UnitPopupMenus["PLAYER"]), "FLAGRSP_TOGGLEINFOBOX");

	 --UnitPopupButtons["FLAGRSP_ADDEDIT"] = { text = "Add/Edit flagRSP entry", dist = 0 };

	 --FlagHandler.setn();

	 FlagRSP.pName=UnitName("player");
	 FlagRSP.rName=GetCVar("realmName");

	 if FlagRSPSettings[FlagRSP.rName] ~= nil and FlagRSPSettings[FlagRSP.rName][FlagRSP.pName] ~= nil and FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].standby then
	    FlagRSP.printM(FlagRSP_Locale_StandBy);
	    FlagRSP.printM(FlagRSP_Locale_StandBy2);
	    FlagRSP_LeaveChannel();
	    FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].standby = true;
	    FlagRSP.standby = true;
	 end

	 FlagRSP.playerEnteredWorld = true;
      end

      if myAddOnsFrame_Register then
	 myAddOnsFrame_Register(flagRSPDetails, flagRSPHelp);
      end
      
   elseif event == "CHAT_MSG_SYSTEM" then
      if ( FlagRSP.isAFKEvent() ) then
	 if not FlagRSP.collecting then
	    flagRSP_AFK = true;
	    FlagRSP.printM(FlagRSP_Locale_AFK_Activated);
	 else
	 end
	 
	 flagRSP_AFKPosx, flagRSP_AFKPosy = GetPlayerMapPosition("player");
	 FlagRSP.printDebug("flagRSP: DEBUG: AFK: x_position: " .. flagRSP_AFKPosx .. " y_position: " .. flagRSP_AFKPosy);
      end
      if ( FlagRSP.isnotAFKEvent() ) then
	 flagRSP_AFK = false;
	 FlagRSP.printM(FlagRSP_Locale_AFK_Deactivated);
      end
      --FlagRSP.checkAFK(arg2);

   elseif event == "CHAT_MSG_CHANNEL" then

      --FlagRSP.print(arg9);

      --FlagRSP.checkAFK(arg2);

      if string.lower(arg9) == string.lower(xTP_ChannelName) then
	 
	 --FlagRSP.printDebug(arg9);
	 --FlagRSP.printDebug(arg4);

	 FlagRSP.caughtChatMessage(arg1, arg2);
	 
	 FlagRSP.chatMessageHandler(arg1, arg2);	 
	 
      end
      
   elseif event == "UPDATE_MOUSEOVER_UNIT" then
      xTooltip_Update();
   end
   
   
   if (event == "PLAYER_TARGET_CHANGED" ) then

      local targetName = UnitName("target");

      if Friendlist.isFriend(targetName) then
	 UnitPopupButtons["FLAGRSP_ADDEDIT"] = { text = TooltipHandler.compileString(FlagRSP_Locale_EditEntry, "target"), dist = 0 };
      else
	 UnitPopupButtons["FLAGRSP_ADDEDIT"] = { text = TooltipHandler.compileString(FlagRSP_Locale_AddEntry, "target"), dist = 0 };
      end

      UnitPopupButtons["FLAGRSP_TOGGLEINFOBOX"] = { text = TooltipHandler.compileString(FlagRSP_Locale_ToggleBox, "target"), dist = 0 };

      --FlagRSP.printDebug("Target changed!");
      FlagRSPInfo.targetChanged = true;
      
      --FlagRSPInfoBoxButton:SetPoint("CENTER", "TargetFrame", "CENTER", 65, 30);
      --FlagRSPInfoBoxButtonNormalTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Elite");

      -- flokru: I linked hiding of levels in Targetframe to level changing in tooltips.
      if FlagRSPConfigure.isInitialized() and FlagRSP.getLevelDisp() then
	 local targetLevel = UnitLevel("target");
	 local targetLevelText = "";
	 if targetLevel > 0 then
	    Diff = targetLevel - UnitLevel("player");
	    
	    if UnitClassification("target") == "elite" then
	       Diff = Diff + 7;
	    end

	    if Diff <= -7 then targetLevelText = FlagRSP_Locale_TF_Epuny; end
	    if Diff <= -5 and Diff > -7 then targetLevelText = FlagRSP_Locale_TF_Puny; end
	    if Diff < -1 and Diff > -5 then targetLevelText = FlagRSP_Locale_TF_Weak; end
	    if Diff >= -1 and Diff <= 1 then targetLevelText = FlagRSP_Locale_TF_Equal; end
	    if Diff > 1 and Diff < 4 then targetLevelText = FlagRSP_Locale_TF_Strong; end
	    if Diff >= 4 and Diff < 7 then targetLevelText = FlagRSP_Locale_TF_Vstrong; end
	    if Diff >= 7 and Diff < 10 then targetLevelText = FlagRSP_Locale_TF_Estrong; end
	    if Diff >= 10 then targetLevelText = FlagRSP_Locale_TF_Impossible; end
	    if targetLevel == -1 then targetLevelText = FlagRSP_Locale_TF_Impossible; end
	    
	    --local targetLevelText = TargetLevelText:GetText();
	    --if (targetLevelText) then targetLevelText = ("");
	    TargetLevelText:SetText(targetLevelText);
	    TargetLevelText:Show();
	    --end
	 end
      end

      --FlagRSP.print(Friendlist.getNotes(UnitName("target")));
      FlagRSPInfo.displayBox("target");

   end
end

-----------------------------------------------------------------------------------------------

function xTooltip_Update()
   if xTP_NameChange[UnitName("player")] == nil then xTP_NameChange[UnitName("player")] = 0; end
   if xTP_LevelChange[UnitName("player")] == nil then xTP_LevelChange[UnitName("player")] = 0; end
   if flagRSP_ShowRanks[UnitName("player")] == nil then flagRSP_ShowRanks[UnitName("player")] = 1; end
   if flagRSP_ShowGuild[UnitName("player")] == nil then flagRSP_ShowGuild[UnitName("player")] = 1; end
   
   --local startTick, endTick;

   if FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].modifyTooltip == 1 then
      local tooltipBase = "GameTooltip";	
      local ttextL;
      local ttextR;
      
      local tooltipLine;
      
      local tooltipLinesLeft = {};
      local tooltipLinesRight = {};
      local tlineL;
      local tlineR;
      local i = 1;
      for t=1, 15 do
	 ttextL = getglobal(tooltipBase .. "TextLeft" .. t);
	 ttextR = getglobal(tooltipBase .. "TextRight" .. t);
	 tlineL = ttextL:GetText();
	 tlineR = ttextR:GetText();

	 if tlineL == nil or not ttextL:IsVisible() then tlineL = ""; end
	 if tlineR == nil or not ttextR:IsVisible() then tlineR = ""; end

	 if tlineL ~= "" or tlineR ~= "" then
	    tooltipLinesLeft[i] = tlineL;
	    tooltipLinesRight[i] = tlineR;
	    i = i + 1;
	 end
      end   
      
      GameTooltip:SetBackdropColor(TooltipHandler.getTooltipBGColor("mouseover"));
   
      if UnitIsPlayer("mouseover") then
	 
	 -- Here we get if mouseover target is a human player.
	 
	 if not FlagRSP.getNameDisp() or TooltipHandler.playerIsKnown(UnitName("mouseover")) then
	    
	    if FlagRSP.playerIsIgnored(UnitName("mouseover")) then
	       GameTooltip:SetBackdropColor(1,0,0);
	       
	       TooltipHandler.compileTooltip(tooltipLinesLeft, tooltipLinesRight, TooltipModifierIgnored, "GameTooltip", "mouseover", 15);
	    else
	       TooltipHandler.compileTooltip(tooltipLinesLeft, tooltipLinesRight, TooltipModifierKnownPlayer, "GameTooltip", "mouseover", 15);
	    end
	 else
	    -- Here we get if the mouseover target is an unknown human player.

	    if FlagRSP.playerIsIgnored(UnitName("mouseover")) then
	       GameTooltip:SetBackdropColor(1,0,0);
	       
	       TooltipHandler.compileTooltip(tooltipLinesLeft, tooltipLinesRight, TooltipModifierIgnored, "GameTooltip", "mouseover", 15);
	    else
	       TooltipHandler.compileTooltip(tooltipLinesLeft, tooltipLinesRight, TooltipModifierUnknownPlayer, "GameTooltip", "mouseover", 15);
	    end
	 end
      else
	 if TooltipHandler.isPet("mouseover") then
	    --FlagRSP.printDebug("Here is a pet");
	    TooltipHandler.compileTooltip(tooltipLinesLeft, tooltipLinesRight, TooltipModifierPet, "GameTooltip", "mouseover", 15);
	 else
	    -- Here we get if mouseover target is a NPC.
	    TooltipHandler.compileTooltip(tooltipLinesLeft, tooltipLinesRight, TooltipModifierNPC, "GameTooltip", "mouseover", 15);
	 end
      end

   elseif FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].modifyTooltip == 0 then
      --startTick = GetTime();

      if UnitIsPlayer("mouseover") or UnitPlayerControlled("mouseover") then
	 FlagRSP.printDebug("light modify");
	 
	 local name;
	 if UnitPVPRank("mouseover") ~= nil and GetPVPRankInfo(UnitPVPRank("mouseover"), "mouseover") ~= nil then
	    name = GetPVPRankInfo(UnitPVPRank("mouseover"), "mouseover") .. " " .. UnitName("mouseover");
	 else
	    name = UnitName("mouseover");
	 end
	 local surname = TooltipHandler.getSurname(name);
	 local title = TooltipHandler.getTitle(name);
	 local rpflag = TooltipHandler.getRPTooltipText(name, "mouseover");
	 local cstatus = TooltipHandler.getCharStatusTooltipText(name, "mouseover");
	 local friendstate = Friendlist.getFriendstateText(name);
         
         local guildText = "";
         if FlagRSP.getGuildDisp() == 1 then
            local guild, a, b = GetGuildInfo("mouseover");
            if guild ~= nil and guild ~= "" then
               guildText = "<" .. guild .. ">"
            end
         end
		
	 
         GameTooltipTextLeft1:SetText(name .. " " .. surname);
         GameTooltip:AddLine(title,1,1,1);
         if guildText ~= "" then
            GameTooltip:AddLine(guildText,1,1,1);
         end
         GameTooltip:AddLine(rpflag,1,1,1);
         GameTooltip:AddLine(cstatus,1,1,1);
         GameTooltip:AddLine(friendstate,1,1,1);	 

	 GameTooltip:Show();
      end
      
      --endTick = GetTime();

      --FlagRSP.printDebug("tooltip compile time: " .. endTick-startTick);

   end
end
   
   
function xTooltip_Post(intervalType, rpChanged, nameChanged, titleChanged, descChanged, csChanged)
   --SlashCmdList["RSPAFK"] = FlagRSP.toggleAFK();
   --SLASH_RSPAFK1 = "/afk";
   
   if intervalType == nil then
      intervalType = "all";
   end
   if rpChanged == nil then 
      rpChanged = true;
   end
   if nameChanged == nil then 
      nameChanged = true;
   end
   if titleChanged == nil then 
      titleChanged = true;
   end
   if descChanged == nil then 
      descChanged = true;
   end
   if csChanged == nil then 
      csChanged = true;
   end

   --FlagRSP.printM("Interval type: " .. intervalType);

   if not FlagRSP.standby then
      FlagRSP_JoinChannel();
      id = GetChannelName(xTP_ChannelName);
      
      if not flagRSP_AFK then
	 
	 if intervalType == "low" or intervalType == "all" then 
	    
	    if rpChanged then
	       if FlagRSP.getRPFlag() ~= NIL then 
		  if FlagRSP.getRPFlag() ~= 1 then
		     ChatHandler.sendMessage("<RP" .. FlagRSP.getRPFlag() .. ">" .. math.ceil(FlagRSP.postInterval));
		  elseif FlagRSP.getRPFlag() == 1 then 
		     ChatHandler.sendMessage("<RP>" .. FlagRSP.postInterval);
		  else
		     ChatHandler.sendMessage("<RP0>" .. FlagRSP.postInterval);
		  end
	       else 
		  ChatHandler.sendMessage("<RP0>" .. FlagRSP.postInterval);
	       end
	    end
	    
	    --if flagRSP_TofBof then
	       --BotFot.post(id, true);
	    --end
	    --if flagRSP_NoTofBof then
	       --BotFot.post(id, false);
	    --end
	    
	    if nameChanged then
	       if FlagRSP.getOwnSurname() ~= NIL then 
		  -- Empty names and titles should be send either.
		  
		  local name = FlagRSP.getOwnSurname();
		  name = string.gsub(name, "<", "\\(");
		  name = string.gsub(name, ">", "\\)");
		  
		  ChatHandler.sendMessage("<N>" .. name);
		  --end
	       else 
		  ChatHandler.sendMessage("<N>");
	       end
	    end
	    
	    if titleChanged then
	       if FlagRSP.getOwnTitle() ~= NIL then 
		  -- Empty names and titles should be send either.
		  
		  local title = FlagRSP.getOwnTitle();
		  title = string.gsub(title, "<", "\\(");
		  title = string.gsub(title, ">", "\\)");
		  
		  ChatHandler.sendMessage("<T>" .. title);
		  --end
	       else
		  ChatHandler.sendMessage("<T>");
	       end
	    end
	    
	    --   isStableVersion = false;
	    if FlagRSP.isStableVersion then
	       local num = math.random(1,20);
	       --FlagRSP.printDebug("Random num for version posting is:" .. num);
	       if num == 1 then
		  local release = FlagRSP.releaseVersion;
		  local major = FlagRSP.majorVersion;
		  local minor = FlagRSP.minorVersion;
		  
		  FlagRSP.printDebug("Posting version number.");
		  ChatHandler.sendMessage("<V>" .. release .. "." .. major .. "." .. minor);
	       end
	    else
	       --FlagRSP.printDebug("Not posting version number, unstable release.");
	    end
	    
	    FlagRSPInfo.pushDescription(true);
	    
	    if not FlagRSP.isInitialized then
	       FlagRSP.printM(FlagRSP_Locale_Initialized);
	       FlagRSP.isInitialized = true;
	    end
	 end
	 if intervalType == "high" or intervalType == "all" then 
	    
	    if descChanged then
	       if FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharDescRev >= 0 and FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharDesc ~= nil and FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharDesc ~= "" then
		  ChatHandler.sendMessage("<DV>" .. FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharDescRev);
	       elseif FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharDescRev >= 0 and FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharDesc ~= nil and FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharDesc == "" then
		  ChatHandler.sendMessage("<DV>-1");
	       end
	    end
	    
	    if csChanged then
	       ChatHandler.sendMessage("<CS" .. FlagRSP.getCharStatusNum() .. ">" .. math.ceil(FlagRSP.postIntervalHigh));
	    end
	    
	    if not FlagRSP.isInitialized then
	       FlagRSP.printM(FlagRSP_Locale_Initialized);
	       FlagRSP.isInitialized = true;
	    end
	 end	 
      end
   end
end


function FlagRSP_plotList()
   -- removed.
   if 1 == 0 then
      local t = 0;
      for name,style in xTP_RPList do
	 DEFAULT_CHAT_FRAME:AddMessage("flagRSP: DEBUG: " .. name .. " is a roleplayer with style: " .. TooltipHandler.getRPTooltipText(name) .. " and title tag: " .. TooltipHandler.getTitle(name) .. " and surname: " .. TooltipHandler.getSurname(name) .. ". Current character status: " .. TooltipHandler.getCharStatusText(name));
	 t = t + 1;
      end
      --FlagRSP.printDebug(TooltipHandler.compileString("%flagRSPCharStatusLine"));
      FlagRSP.printDebug("flagRSP: DEBUG: Total " .. t .. " players using flagRSP.");
   end
end


function FlagRSP.getStats()
   local t = 0;
   local o = 0;
   local oMax = 0;

   --local flags = {};

   --for i = 0, 4 do
      --flags[i] = 0;
   --end

   local style;
   local lastSeen;
   local interval;
   for name,interv in flagRSP_IntervalList do
      t = t + 1;
      
      --FlagRSP.printDebug(name .. " is online?. Interval is: " .. interv);
      
      
      --local interval;
      --if flagRSP_IntervalList[name] ~= nil and flagRSP_LastSeenList[name] ~= nil then
      if flagRSP_LastSeenList[name] ~= nil then
	 lastSeen = flagRSP_LastSeenList[name];
	 interval = interv;

	 --FlagRSP.printDebug(name .. " is using old interval.");

	 --if GetTime() <= interval*2+lastSeen then 
	    --FlagRSP.printDebug(name .. " is online.");
	 --end
      end
      --FlagRSP.printDebug("test " .. name .. " for new interval.");
      if flagRSP_IntervalListHigh[name] ~= nil and flagRSP_LastSeenListHigh[name] ~= nil then
	 lastSeen = flagRSP_LastSeenListHigh[name];
	 interval = flagRSP_IntervalListHigh[name];

	 --FlagRSP.printDebug(name .. " is using new interval.");

	 --if GetTime() <= interval*2+lastSeen then 
	    --FlagRSP.printDebug(name .. "is online.");
	 --end
      end
      
      if lastSeen ~= nil and interval ~= nil then
	 if GetTime() <= interval*2+lastSeen then
	    o = o + 1;
	    oMax = oMax + 1;
	 end
      else
	 oMax = oMax + 1;
      end

      --style = FlagHandler.getFlag("RPFlag", name);

      --flags[style] = flags[style] + 1;

      --FlagRSP.printDebug(style);
   end

   if o > FlagRSP.maxUsersOnline then
      FlagRSP.maxUsersOnline = o;
   end

   FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].numOnlineList[FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].numOnlineList.position] = oMax;
   
   return t, o, oMax;
end


function FlagRSP.plotStats()
   local t,o,oMax;

   FlagRSP.printM("|CFFFFFF7FFLAGRSP STATISTICS:|r");
   FlagRSP.printM("|CFFFFFF7FUsage statistics:|r");

   local flags = {};

   if GetTime() - FlagRSP.sessionStartTick >= FLAGRSP_MAXINTERVALHIGH then
      t,o,oMax = FlagRSP.getStats();
      
      FlagRSP.printM("Currently |CFFFFFF7F" .. t .. "|r flagRSP users listed who were online during this session (these are all users who have sent flags during this session).");
      --FlagRSP.printM("A maximum of |CFFFFFF7F" .. oMax .. "|r flagRSP users is currently online (Note: all pre-0.5.0 users are counted as online even if offline. Therefore this value is unreliable).");
      FlagRSP.printM("Number of flagRSP users currently online: |CFFFFFF7F" .. o .. "|r (Note: only users of version 0.5.0 or above counted, reliable only if all users use post-0.5.0 versions).");
      FlagRSP.printM("Maximum number of online users: |CFFFFFF7F" .. FlagRSP.maxUsersOnline .. "|r (Note: only users of version 0.5.0 or above counted, reliable if all users use post-0.5.0 versions. This value shows how many users were active at the same time).");

      --FlagRSP.printDebug("flagRSP: DEBUG: Total " .. t .. " players using flagRSP.");
   else
      FlagRSP.printM("No usage statistics available yet. Please wait " .. math.ceil((FLAGRSP_MAXINTERVALHIGH - (GetTime() - FlagRSP.sessionStartTick))/6)/10 .. " more minutes.");
   end

   FlagRSP.printM("|CFFFFFF7FTraffic statistics:|r");
   FlagRSP.printM("Current flag sending interval (low flags): |CFFFFFF7F" .. math.ceil(FlagRSP.postInterval/6)/10 .. "|r minutes (" .. math.ceil(FlagRSP.postInterval*10)/10 .. " seconds).");
   FlagRSP.printM("Current flag sending interval (high flags): |CFFFFFF7F" .. math.ceil(FlagRSP.postIntervalHigh/6)/10 .. "|r minutes (" .. math.ceil(FlagRSP.postIntervalHigh*10)/10 .. " seconds).");
   if FlagRSP.bytesPerSecondLastInterval ~= 0 then
      FlagRSP.printM("Bytes per second in the last six minute interval: |CFFFFFF7F" .. math.ceil(FlagRSP.bytesPerSecondLastInterval*10)/10 .. "|r");
      FlagRSP.printM("Maximum bytes per second in one six minute interval: |CFFFFFF7F" .. math.ceil(FlagRSP.bytesPerSecondIntervalMax*10)/10 .. "|r");
   end
   FlagRSP.printM("Bytes per second (whole session): |CFFFFFF7F" .. math.ceil(FlagRSP.bytesPerSession/(GetTime() - FlagRSP.sessionStartTick)*10)/10 .. "|r");
   FlagRSP.printM("Own description has been sent |CFFFFFF7F" .. FlagRSP.ownDescriptionSent .. "|r times.");
   FlagRSP.printM("Own description has been requested |CFFFFFF7F" .. FlagRSP.ownDescriptionRequested .. "|r times.");

   FlagRSP.printM("|CFFFFFF7FMemory statistics:|r");
   local memory, gcTreshold = gcinfo();

   FlagRSP.printM("Memory used by complete interface (including addons): |CFFFFFF7F" .. math.ceil(memory*10)/10 .. "|r kB.");
   local numEntries, flags = FlagHandler.getStats();

   FlagRSP.printM("Number of currently saved entries (i.e. characters) on all realms: |CFFFFFF7F" .. numEntries.. "|r.");

   FlagRSP.printM("|CFFFFFF7FRP flags used:|r");
   FlagRSP.printM("Number of flagRSP users without flag: |CFFFFFF7F" .. flags[0] .. "|r.");
   FlagRSP.printM("Number of flagRSP users with standard flag: |CFFFFFF7F" .. flags[1] .. "|r.");
   FlagRSP.printM("Number of flagRSP users with casual flag: |CFFFFFF7F" .. flags[2] .. "|r.");
   FlagRSP.printM("Number of flagRSP users with fulltime flag: |CFFFFFF7F" .. flags[3] .. "|r.");
   FlagRSP.printM("Number of flagRSP users with beginner flag: |CFFFFFF7F" .. flags[4] .. "|r.");


   if FlagRSP.oldestVersion ~= "" or FlagRSP.newestVersion ~= "" then
      FlagRSP.printM("|CFFFFFF7FVersion usage:|r");
      
      if FlagRSP.oldestVersion ~= "" then
	 FlagRSP.printM("Oldest detected version: |CFFFFFF7F" .. FlagRSP.oldestVersion .. "|r");
      end
      if FlagRSP.newestVersion ~= "" then
	 FlagRSP.printM("Newest detected version: |CFFFFFF7F" .. FlagRSP.newestVersion .. "|r");
      end
   end
end

function xTooltip_OnUpdate()

   FlagRSP.checkAFK("");
   FlagRSPConfigure.initializeSettings();

   if GetTime() > FlagRSP.newTickDisplayBox then
      FlagRSPInfo.displayBox("target");
      FlagRSP.newTickDisplayBox = GetTime() + FlagRSP.displayBoxInterval;
   end
   
   if FlagRSP.displayOwnTooltip then
      FlagRSP.showOwnTooltip();
   end

   --FlagRSPInfo.postDescription();

   --if GetTime() - xTP_OldTick > FlagRSP.postInterval then
   if GetTime() > FlagRSP.newTickPost then
      --FlagRSP.printM("posting low flags!");
      xTooltip_Post("low");
      --xTP_OldTick = GetTime();
      FlagRSP.newTickPost = GetTime() + FlagRSP.postInterval;
   end

   if GetTime() > FlagRSP.newTickPostHigh then
      --FlagRSP.printM("posting high flags!");
      xTooltip_Post("high");
      --xTP_OldTick = GetTime();
      FlagRSP.newTickPostHigh = GetTime() + FlagRSP.postIntervalHigh;
   end

   --if GetTime() - FlagRSP.oldTickChatFrame > 60 then
   if GetTime() > FlagRSP.newTickChatFrame then
      FlagRSP.muteDataChannel();
      --FlagRSP.oldTickChatFrame = GetTime();
      FlagRSP.newTickChatFrame = GetTime() + 60;
   end

   if GetTime() > FlagRSP.newTickDesc then
      FlagRSPInfo.postDescription();
      FlagRSP.newTickDesc = GetTime() + 0;
   end

   ChatHandler.executeQueue();

   if GetTime() > FlagRSP.updateFriendsTick then
      TooltipHandler.updateFriendEntries();
      FlagRSP.updateFriendsTick = GetTime() + 30;
   end

   if GetTime() > FlagRSP.updateGuildListTick then
      TooltipHandler.updateGuildMembers();
      FlagRSP.updateGuildListTick = GetTime() + 300;
   end

   if GetTime() > FlagRSP.updateIgnoredListTick then
      TooltipHandler.updateIgnoredList();
      FlagRSP.updateIgnoredListTick = GetTime() + 30;
   end

   -- flokru: Targetframe updates on several events. I don't know which.
   --         So, we change level in targetframe here. Not an optimal solution.
   if FlagRSPConfigure.isInitialized() and FlagRSP.getLevelDisp() then
      if UnitName("target") ~= nil then
	 local targetLevel = UnitLevel("target");
	 local targetLevelText = "";
	 if targetLevel > 0 then
	    Diff = targetLevel - UnitLevel("player");
	    
	    if UnitClassification("target") == "elite" then
	       Diff = Diff + 7;
	    end
	    
	    if Diff <= -7 then targetLevelText = FlagRSP_Locale_TF_Epuny; end
	    if Diff <= -5 and Diff > -7 then targetLevelText = FlagRSP_Locale_TF_Puny; end
	    if Diff < -1 and Diff > -5 then targetLevelText = FlagRSP_Locale_TF_Weak; end
	    if Diff >= -1 and Diff <= 1 then targetLevelText = FlagRSP_Locale_TF_Equal; end
	    if Diff > 1 and Diff < 4 then targetLevelText = FlagRSP_Locale_TF_Strong; end
	    if Diff >= 4 and Diff < 7 then targetLevelText = FlagRSP_Locale_TF_Vstrong; end
	    if Diff >= 7 and Diff < 10 then targetLevelText = FlagRSP_Locale_TF_Estrong; end
	    if Diff >= 10 then targetLevelText = FlagRSP_Locale_TF_Impossible; end
	    if targetLevel == -1 then targetLevelText = FlagRSP_Locale_TF_Impossible; end
	    
	    --local targetLevelText = TargetLevelText:GetText();
	    --if (targetLevelText) then targetLevelText = ("");
	    TargetLevelText:SetText(targetLevelText);
	    TargetLevelText:Show();
	    --end
	 end
      end
   end
end


function FlagRSP.sendRPTicket(msg)
   FlagRSP_JoinChannel();
   id = GetChannelName(xTP_ChannelName);

   if msg ~= nil and msg ~= "" then
      SendChatMessage("<RPT>" .. "[" .. GetRealZoneText() .. "]" .. msg, "CHANNEL", FlagRSP_Locale_CLanguage, id); 
      --ChatHandler.sendMessage("<RPT>" .. "[" .. GetRealZoneText() .. "]" .. msg, "CHANNEL");
      FlagRSP.printM("|cffff0000" .. FlagRSP_Locale_RPTicket .. "|r " .. msg);
   end
end

function flagRSP_SendChatMessage(arg1, arg2, arg3, arg4)
   --[[
   if string.lower(arg2) == "afk" then
      if flagRSP_AFK then
	 flagRSP_AFK = false;
	 FlagRSP.print(FlagRSP_Locale_AFK_Deactivated);
      else
	 flagRSP_AFK = true;
	 FlagRSP.print(FlagRSP_Locale_AFK_Activated);
	 
	 flagRSP_AFKPosx, flagRSP_AFKPosy = GetPlayerMapPosition("player");
	 FlagRSP.printDebug("flagRSP: DEBUG: AFK: x_position: " .. flagRSP_AFKPosx .. " y_position: " .. flagRSP_AFKPosy);
      end      
   end
   ]]--

   if arg4 ~= nil then
      --FlagRSP.printDebug("arg4: " .. arg4);
      if string.sub(arg4,1,string.len(FlagRSP_Locale_UnicornOfficial)) == FlagRSP_Locale_UnicornOfficial then
	 arg4 = string.sub(arg4,string.len(FlagRSP_Locale_UnicornOfficial)+1,string.len(arg4));
      end
      if string.sub(arg4,1,string.len(FlagRSP_Locale_UnicornNonOfficial)) == FlagRSP_Locale_UnicornNonOfficial then
	 arg4 = string.sub(arg4,string.len(FlagRSP_Locale_UnicornNonOfficial)+1,string.len(arg4));
      end
   end

   --if arg4 ~= nil then
   --   FlagRSP.printDebug("arg4: " .. arg4);
   --end

   flagRSP_SendChatMessageOrig(arg1, arg2, arg3, arg4);
end

--flagRSP_SendChatMessageOrig = SendChatMessage;
--SendChatMessage = flagRSP_SendChatMessage;

function flagRSP_ChatHandler(event)
   if event == "CHAT_MSG_WHISPER" then
      --if arg2 ~= nil then
	 --FlagRSP.printDebug("arg2: " .. arg2);
      --end
      --if arg1 ~= nil then
	 --FlagRSP.printDebug("arg1: " .. arg1);
      --end
      

      if xTP_RP2List[arg2] ~= nil and xTP_RP2List[arg2] then
	 if UList_Installed and UList[FlagRSP.rName] ~= nil and UList[FlagRSP.rName][arg2] then
	    arg2 = FlagRSP_Locale_UnicornOfficial .. arg2;
	 else
	    arg2 = FlagRSP_Locale_UnicornNonOfficial .. arg2;
	 end
      end
      
   end

   flagRSP_ChatHandlerOrig(event);
   --flagRSP_ChatHandlerOrig(event);
end

function flagRSP_UnitPopup_OnClick()
   local index = this.value;
   local button = UnitPopupMenus[this.owner][index];
   local targetName = UnitName("target");

   if button == "FLAGRSP_ADDEDIT" then
      if Friendlist.isFriend(targetName) then
	 --FlagRSP.printM("Edit not yet supported.");
	 
	 local index = Friendlist.getIndex(targetName);
	 if index ~= nil then
	    FRIENDLISTFrame.selectedMember = index;
	    FRIENDLISTStaticPopUpEdit:Show();
	 end
      else
	 FRIENDLISTStaticPopUpAdd:Show();
      end
   elseif button == "FLAGRSP_TOGGLEINFOBOX" then
      FlagRSPInfo.toggleBox();
   end
   
   flagRSP_UnitPopup_OnClickOrig();
end

--function flagRSP_AuctionNew()
--   DEFAULT_CHAT_FRAME:AddMessage("load auction frame",1,1,1);
--   flagRSP_AuctionOrig();
--end

--flagRSP_AuctionOrig = AuctionFrame_LoadUI;
--AuctionFrame_LoadUI = flagRSP_AuctionNew;

flagRSP_ChatHandlerOrig = ChatFrame_OnEvent;
ChatFrame_OnEvent = flagRSP_ChatHandler;

flagRSP_SendChatMessageOrig = SendChatMessage;
SendChatMessage = flagRSP_SendChatMessage;

flagRSP_UnitPopup_OnClickOrig = UnitPopup_OnClick;
UnitPopup_OnClick = flagRSP_UnitPopup_OnClick;

function FlagRSP.isAFKEvent()
   local msg = arg1;
   if ( string.find(msg,FlagRSP_Locale_AFK) )
   then
      return true;
   end
   return false;
end

function FlagRSP.isnotAFKEvent()
   local msg = arg1;
   if (string.find(msg,FlagRSP_Locale_NOTAFK)) 
   then
      return true;
   end
   return false;
end


--[[

FlagRSP.chatMessageHandler(arg1, arg2)

-- new handler for incoming chat messages from data channel.

]]--
function FlagRSP.chatMessageHandler(arg1, arg2)

   if string.find(arg1,"<") == nil then 
      return;
   end

   if string.find(string.sub(arg1,2,string.len(arg1)),"<") ~= nil then 
      -- more than one option in line.
      
      --FlagRSP.printDebug("Multioption line: " .. arg1);
      
      firstBrack = string.find(string.sub(arg1,2,string.len(arg1)),"<");

      firstComm = string.sub(arg1,1,firstBrack);
      rest = string.sub(arg1,firstBrack+1, string.len(arg1));

      --FlagRSP.printDebug("found first command: " .. firstComm .. ", passing rest");
      
      FlagRSP.chatMessageHandler(firstComm, arg2);
      FlagRSP.chatMessageHandler(rest, arg2);
   
   elseif string.find(string.sub(arg1,2,string.len(arg1)),"<") == nil then 
      -- just one command. treat it as usual.

      --FlagRSP.printDebug("Single line: " .. arg1);

      --FlagRSP.printDebug("before: " .. arg1);

      -- substitute encoded brackets.
      arg1 = string.gsub(arg1, "\\%(", "<");
      arg1 = string.gsub(arg1, "\\%)", ">");

      --FlagRSP.printDebug("after: " .. arg1);

      --if xTP_RPList[arg2] == nil then
	 --xTP_RPList[arg2] = 0;
      --end
      
      --if xTP_CTList[arg2] == nil then xTP_CTList[arg2] = "";end
      --if xTP_CTList2[arg2] == nil then xTP_CTList2[arg2] = "";end

      if string.sub(arg1,1,3) == "<RP" and string.sub(arg1,4,4) ~= "T"  then
	 --local Found = 0;
	 local RPStyle = string.sub(arg1,4,4);
	 
	 --for t = 0, xTP_NumInList do
	 --   if arg2 == xTP_RPList[t] then
	 --     Found = 1;
	 --     break;
	 --   end
	 --end
	 
	 --if Found == 0 then
	 --   Found = xTP_NumInList;
	 --   xTP_RPList[Found] = arg2;
	 --   xTP_NumInList = xTP_NumInList + 1;
	 --end

	 if RPStyle == "4" then
	    --xTP_RPList[arg2] = 4;
	    FlagHandler.addFlag("RPFlag", 4, arg2);
	 elseif RPStyle == "3" then
	    --xTP_RPList[arg2] = 3;
	    FlagHandler.addFlag("RPFlag", 3, arg2);
	 elseif RPStyle == "2" then
	    --xTP_RPList[arg2] = 2;
	    FlagHandler.addFlag("RPFlag", 2, arg2);
	 elseif RPStyle == "0" then
	    --xTP_RPList[arg2] = 0;
	    FlagHandler.addFlag("RPFlag", 0, arg2);
	 else
	    --xTP_RPList[arg2] = 1;
	    FlagHandler.addFlag("RPFlag", 1, arg2);
	 end
	 
	 --FlagRSP.printDebug(arg1);
	 --FlagRSP.printDebug(arg2);
	 --FlagRSP.printDebug(xTP_RPList[arg2]);

	 local int;
	 if (string.len(arg1) >= 6 and RPStyle ~= ">") then
	    int = tonumber(string.sub(arg1,6,string.len(arg1)));
	 elseif (string.len(arg1) >= 5 and RPStyle == ">") then
	    int = tonumber(string.sub(arg1,5,string.len(arg1)));
	 end
	 
	 if int ~= nil and int > 0 then
	    flagRSP_IntervalList[arg2] = int;
	    flagRSP_LastSeenList[arg2] = GetTime();
	    
	    
	    --FlagRSP.printDebug("we see that " .. arg2 .. " is using interval: " .. flagRSP_IntervalList[arg2] .. " and now it is: " .. flagRSP_LastSeenList[arg2]);
	 end
	 
      elseif string.sub(arg1, 1, 7) == "<TITEL>" then
	 --xTP_CTList2[arg2] = string.sub(arg1, 8, string.len(arg1)); 
	 FlagHandler.addFlag("Title", string.sub(arg1, 8, string.len(arg1)), arg2);
	 
      elseif string.sub(arg1, 1, 3) == "<T>" then
	 --xTP_CTList2[arg2] = string.sub(arg1, 4, string.len(arg1)); 
	 FlagHandler.addFlag("Title", string.sub(arg1, 4, string.len(arg1)), arg2);
	 	 
      elseif string.sub(arg1,1,5) == "<RPT>" then
	 if flagRSP_TofBof then
	    TofBof.gotRPT(arg1, arg2);
	 end
	 
      elseif string.sub(arg1,1,5) == "<BTF>" then
	 xTP_RP2List[arg2] = true;
	 
      elseif string.sub(arg1,1,5) == "<BT0>" then
	 xTP_RP2List[arg2] = false;
	 
      elseif string.sub(arg1, 1, 6) == "<NAME>" then
	 --xTP_CTList[arg2] = string.sub(arg1, 7, string.len(arg1)); 
	 FlagHandler.addFlag("Surname", string.sub(arg1, 7, string.len(arg1)), arg2);

      elseif string.sub(arg1, 1, 3) == "<N>" then
	 --xTP_CTList[arg2] = string.sub(arg1, 4, string.len(arg1)); 
	 FlagHandler.addFlag("Surname", string.sub(arg1, 4, string.len(arg1)), arg2);
	 
      elseif string.sub(arg1, 1, 9) == "<CSTATUS>" then
	 flagRSP_CharStatusList[arg2] = string.sub(arg1, 10, string.len(arg1));
	 --FlagHandler.addFlag("CStatus", string.sub(arg1, 10, string.len(arg1)), arg2);

      elseif string.sub(arg1, 1, 3) == "<CS" then

	 local cStatus = string.sub(arg1,4,4);
	 local csString = "";

	 if cStatus == "0" then
	    csString = "";
	 elseif cStatus == "1" then
	    csString = "ooc";
	 elseif cStatus == "2" then
	    csString = "ic";
	 elseif cStatus == "3" then
	    csString = "ffa-ic";
	 elseif cStatus == "4" then
	    csString = "st"; 
	 end
	 
	 flagRSP_CharStatusList[arg2] = csString;
	 --FlagHandler.addFlag("CStatus", csString, arg2);

	 local int;
	 if string.len(arg1) >= 6 then
	    int = tonumber(string.sub(arg1,6,string.len(arg1)));
	 end
	 
	 if int ~= nil and int > 0 then
	    flagRSP_IntervalListHigh[arg2] = int;
	    flagRSP_IntervalList[arg2] = int;
	    flagRSP_LastSeenListHigh[arg2] = GetTime();
	    flagRSP_LastSeenList[arg2] = GetTime();
	    
	    FlagRSP.printDebug("we see that " .. arg2 .. " is using interval: " .. flagRSP_IntervalListHigh[arg2] .. " and now it is: " .. flagRSP_LastSeenListHigh[arg2]);
	 end
	 
      elseif string.sub(arg1, 1, 6) == "<DREV>" then
	 local n = tonumber(string.sub(arg1, 7, string.len(arg1)));
	 
	 if n == nil then n=-1; end
	 
	 if n == -1 then
	    FlagRSP_CharDesc.savedRev[arg2] = -1;
	 end
	 
	 FlagRSP_CharDesc.availRev[arg2] = n;
	 FlagRSP_CharDesc.savedRev[arg2] = FlagHandler.getDescRev("A", arg2);

	 if FlagRSP_CharDesc.savedRev[arg2] ~= FlagRSP_CharDesc.availRev[arg2] then
	    if FlagRSP_CharDesc[arg2] ~= nil then
	       for i=1, table.getn(FlagRSP_CharDesc[arg2]) do
		  FlagRSP_CharDesc[arg2][i] = nil;
	       end
	    end
	    FlagRSP_CharDesc.savedRev[arg2] = -1;

	    FlagHandler.delDesc("A", arg2);
	 end
	 
	 if FlagRSP_CharDesc.savedRev[arg2] ~= FlagRSP_CharDesc.availRev[arg2] and FlagRSP_CharDesc.availRev[arg2] ~= -1 then
	    local num = FlagRSP.getTrafficDependendRandom(9, 0.025);
	    --math.random(1,20);
	    --FlagRSP.printDebug("Random num for version posting is:" .. num);
	    if num == 0 then
	       FlagRSP.printDebug("pulling desc for: " .. arg2);
	       FlagRSPInfo.pullDescription(arg2);
	    end
	 end

	 --FlagRSP.printDebug("flagRSP: DEBUG: Player " .. arg2 .. " has a description with revision: " .. FlagRSP_CharDesc.availRev[arg2]);

      elseif string.sub(arg1, 1, 4) == "<DV>" then
	 local n = tonumber(string.sub(arg1, 5, string.len(arg1)));
	 
	 if n == nil then n=-1; end
	 
	 if n == -1 then
	    FlagRSP_CharDesc.savedRev[arg2] = -1;
	 end
	 
	 FlagRSP_CharDesc.availRev[arg2] = n;
	 FlagRSP_CharDesc.savedRev[arg2] = FlagHandler.getDescRev("A", arg2);

	 if FlagRSP_CharDesc.savedRev[arg2] ~= FlagRSP_CharDesc.availRev[arg2] then
	    if FlagRSP_CharDesc[arg2] ~= nil then
	       for i=1, table.getn(FlagRSP_CharDesc[arg2]) do
		  FlagRSP_CharDesc[arg2][i] = nil;
	       end
	    end
	    FlagRSP_CharDesc.savedRev[arg2] = -1;
	    
	    FlagHandler.delDesc("A", arg2);
	 end
	 
	 if FlagRSP_CharDesc.savedRev[arg2] ~= FlagRSP_CharDesc.availRev[arg2] and FlagRSP_CharDesc.availRev[arg2] ~= -1 then
	    local num = FlagRSP.getTrafficDependendRandom(9, 0.025);
	    --math.random(1,20);
	    --FlagRSP.printDebug("Random num for version posting is:" .. num);
	    if num == 0 then
	       FlagRSP.printDebug("pulling desc for: " .. arg2);
	       FlagRSPInfo.pullDescription(arg2);
	    end
	 end

	 --FlagRSP.printDebug("flagRSP: DEBUG: Player " .. arg2 .. " has a description with revision: " .. FlagRSP_CharDesc.availRev[arg2]);
	 
      elseif arg1 == ("<DPULL>" .. FlagRSP.pName) then
	 FlagRSPInfo.pushDescription();

      elseif arg1 == ("<DP>" .. FlagRSP.pName) then
	 FlagRSPInfo.pushDescription();
	 
      elseif string.sub(arg1, 1, 6) == "<DVER>" then
	 FlagRSP.checkVersion(string.sub(arg1, 7, string.len(arg1)));

      elseif string.sub(arg1, 1, 3) == "<V>" then
	 FlagRSP.checkVersion(string.sub(arg1, 4, string.len(arg1)));
	 
      elseif string.sub(arg1, 1, 2) == "<D" and tonumber(string.sub(arg1,3,4)) ~= nil then
	 FlagRSPInfo.saveDescription(string.sub(arg1,3,4), string.sub(arg1,6,string.len(arg1)), arg2);
	 
      elseif string.sub(arg1, 1, 2) == "<P" and tonumber(string.sub(arg1,3,4)) ~= nil then
	 FlagRSPInfo.saveDescription(string.sub(arg1,3,4), string.sub(arg1,6,string.len(arg1)), arg2, true);

      end
      
      Friendlist.updateEntry(arg2, "flagRSP");
   end
end


--[[

FlagRSP.getTrafficDependendRandom(q, k)

-- Returns a number between 0 and x with x = q*exp[(traffic-targetTraffic)*k].

]]--
function FlagRSP.getTrafficDependendRandom(q, k)
   local traFlagRSP_Locale_NextTipButtonffic, targetTraffic;

   if FlagRSP.bytesPerSecondLastInterval ~= 0 then
      traffic = FlagRSP.bytesPerSecondLastInterval;
   else
      traffic = FlagRSP.bytesPerSession/(GetTime() - FlagRSP.sessionStartTick);
   end

   targetTraffic = FlagRSP.postingTargetBps + FlagRSP.postingTargetBpsHigh;

   local upperLimit = math.ceil(q*math.exp(k*(traffic-targetTraffic)));

   FlagRSP.printDebug("traffic-targetTraffic is: " .. traffic-targetTraffic);
   FlagRSP.printDebug("upperLimit is: " .. upperLimit);

   if upperLimit > 1000 then
      upperLimit = 1000;
   end

   if upperLimit == 0 then
      return 0;
   else
      return math.random(0, upperLimit);
   end
end