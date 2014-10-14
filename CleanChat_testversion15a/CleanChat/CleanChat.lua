--
-- CleanChat testversion14
--
-- by Bastian Pflieger <wb@illogical.de>
--
-- Last update: August 31 2006
--

local TIMEOUT_ONE_HOUR = 60 * 60; -- 60 minutes
local TIMEOUT_THREE_DAYS = 60 * 60 * 24 * 3; -- three days
local TIMEOUT = TIMEOUT_ONE_HOUR;

local PURGE_INTERVAL = 60 * 5; -- every 5 minutes remove names which are timed out.

local delayPartyUpdate = -1;
local delayRaidUpdate = -1;

local ChatFrame_OnEvent_Org;
local SetChatWindowShown_Org;
local FriendsFrame_OnEvent_Org;

local nextPurgeCheck = GetTime() + PURGE_INTERVAL;

local playerName;
local playerNameLow;

local GUILD_COLOR = 1;
local FRIEND_COLOR = 2;
local OTHER_COLOR = 3;
local PARTY_COLOR = 4;
local RAID_COLOR = 5;
local UNKNOWN_CLASS_COLOR = 6;
local MY_COLOR = 7;

local GUILD_UPDATE_INTERVAL = 60 * 10;
local guildUpdateTimer = 10;

local HIDECUSTOM_INDEX = { false, false, false, true, false, true };

local whoTimestamp = 0;

local EVENTS_EMOTES = {
  ["CHAT_MSG_BG_SYSTEM_ALLIANCE"] = true,
  ["CHAT_MSG_BG_SYSTEM_HORDE"] = true,
  ["CHAT_MSG_BG_SYSTEM_NEUTRAL"] = true,
  ["CHAT_MSG_EMOTE"] = true,
  ["CHAT_MSG_TEXT_EMOTE"] = true,
  ["CHAT_MSG_MONSTER_EMOTE"] = true,
  ["CHAT_MSG_MONSTER_SAY"] = true,
  ["CHAT_MSG_MONSTER_WHISPER"] = true,
  ["CHAT_MSG_MONSTER_YELL"] = true,
  ["CHAT_MSG_RAID_BOSS_EMOTE"] = true
};


local TEXT_RAID_COLORS = {
  "|cffaad372",  -- 1 = Hunter
  "|cff9382C9",  -- 2 = Warlock
  "|cffffffff",  -- 3 = Priest
  "|cfff48cba",  -- 4 = Paladin
  "|cff68ccef",  -- 5 = Mage
  "|cfffff468",  -- 6 = Rogue
  "|cffff7c0a",  -- 7 = Druid
  "|cfff48cba",  -- 8 = Shaman
  "|cffc69b6d"   -- 9 = Warrior
};

local CLASS_TO_INDEX = {
  ["HUNTER"]  = 1,
  ["WARLOCK"] = 2,
  ["PRIEST"]  = 3,
  ["PALADIN"] = 4,
  ["MAGE"]    = 5,
  ["ROGUE"]   = 6,
  ["DRUID"]   = 7,
  ["SHAMAN"]  = 8,
  ["WARRIOR"] = 9
};

function CleanChat_OnLoad()
  this:RegisterEvent("VARIABLES_LOADED");
  this:RegisterEvent("FRIENDLIST_UPDATE");
  this:RegisterEvent("RAID_ROSTER_UPDATE");
  this:RegisterEvent("GUILD_ROSTER_UPDATE");
  this:RegisterEvent("PARTY_MEMBERS_CHANGED");
  this:RegisterEvent("CHAT_MSG_SYSTEM");
  this:RegisterEvent("PLAYER_ENTERING_WORLD");

  ChatFrame_OnEvent_Org = ChatFrame_OnEvent;
  ChatFrame_OnEvent = CleanChat_ChatFrame_OnEvent;

  SetChatWindowShown_Org = SetChatWindowShown;
  SetChatWindowShown = CleanChat_SetChatWindowShown;

  FriendsFrame_OnEvent_Org = FriendsFrame_OnEvent;
  FriendsFrame_OnEvent = CleanChat_FriendsFrame_OnEvent;

  math.randomseed(time());

  CleanChat_HideChatButtons = false;
  CleanChat_UseCursorKeys = false;
  CleanChat_IsRandomColor = true;
  CleanChat_IsColorizeNicks = true;
  CleanChat_IsHidePrefix = true;
  CleanChat_IsClassColor = false;
  CleanChat_HideChannelnames = 1;
  CleanChat_Colors = {};
  CleanChat_ShowLevel = false;
  CleanChat_CollectData = false;
  CleanChat_EnableMouseWheel = false;
  CleanChat_IsPersistent = false;
  CleanChat_Popup = true;
  CleanChat_IgnoreEmotes = true;
  CleanChat_NameCache = {};
  CleanChat_UsedColors = {};

  CleanChat_InsertPartyMembers();
  CleanChat_InsertRaidMembers();

  SlashCmdList["CLEANCHAT"] = CleanChat_ChatCommand;
  SLASH_CLEANCHAT1 = "/cleanchat";

end

function CleanChat_OnMouseWheel()
  if IsShiftKeyDown() then
    if arg1 == 1 then
      this:ScrollToTop();
    else
      PlaySound("igChatBottom");
      this:ScrollToBottom();
    end
  else
    if arg1 == 1 then
      this:ScrollUp();
--      this:ScrollUp();
--      this:ScrollUp();
    else
      this:ScrollDown();
--      this:ScrollDown();
--      this:ScrollDown();
    end
  end
end

function CleanChat_SetupPrefix(isHidePrefix)
  CleanChat_IsHidePrefix = isHidePrefix;
  CHAT_RAID_GET = CLEANCHAT_PREFIX_RAID[isHidePrefix];
  CHAT_PARTY_GET = CLEANCHAT_PREFIX_PARTY[isHidePrefix];
  CHAT_OFFICER_GET = CLEANCHAT_PREFIX_OFFICER[isHidePrefix];
  CHAT_GUILD_GET = CLEANCHAT_PREFIX_GUILD[isHidePrefix];
  CHAT_RAID_LEADER_GET = CLEANCHAT_PREFIX_RAIDLEADER[isHidePrefix];
  CHAT_RAID_WARNING_GET = CLEANCHAT_PREFIX_RAIDWARNING[isHidePrefix];
  CHAT_BATTLEGROUND_GET = CLEANCHAT_PREFIX_BG[isHidePrefix]; 
  CHAT_BATTLEGROUND_LEADER_GET = CLEANCHAT_PREFIX_BGLEADER[isHidePrefix];
end

function CleanChat_SetupCursorMode(isCursorUsedDirectly)
  ChatFrameEditBox:SetAltArrowKeyMode(not isCursorUsedDirectly);
end

function CleanChat_SetupMouseWheel(isEnabled)
  for i = 1, NUM_CHAT_WINDOWS do
    getglobal("ChatFrame" .. i):SetScript("OnMouseWheel", CleanChat_OnMouseWheel);
    getglobal("ChatFrame" .. i):EnableMouseWheel(isEnabled);
  end
end

function CleanChat_SetupPersistent(isEnabled)
  if isEnabled then
    TIMEOUT = TIMEOUT_THREE_DAYS;
  else
    TIMEOUT = TIMEOUT_ONE_HOUR;
  end
end

function CleanChat_HideButtons(index)
  getglobal("ChatFrame" .. index .. "DownButton"):Hide();
  getglobal("ChatFrame" .. index .. "UpButton"):Hide();
  getglobal("ChatFrame" .. index .. "BottomButton"):Hide();
end

function CleanChat_ShowButtons(index)
  getglobal("ChatFrame" .. index .. "DownButton"):Show();
  getglobal("ChatFrame" .. index .. "UpButton"):Show();
  getglobal("ChatFrame" .. index .. "BottomButton"):Show();
end

function CleanChat_SetupButtons(isHideButtons)
  local func = CleanChat_ShowButtons;
  if isHideButtons then
    func = CleanChat_HideButtons;
    ChatFrameMenuButton:Hide();
  else
    ChatFrameMenuButton:Show();
  end
  for i = 1, NUM_CHAT_WINDOWS do
    func(i);
  end
end

function CleanChat_SetChatWindowShown(index, shown)
  SetChatWindowShown_Org(index, shown);
  if shown and CleanChat_HideChatButtons then
    CleanChat_HideButtons(index);
  end
end

function CleanChat_PopupOnUpdated(elapsed)
  CleanChat_PopupFrame.fadeOut = CleanChat_PopupFrame.fadeOut - elapsed;
  if CleanChat_PopupFrame.fadeOut < -1 then
    CleanChat_PopupFrame:Hide();
  elseif CleanChat_PopupFrame.fadeOut < 0 then
    CleanChat_PopupFrame:SetAlpha(1 + CleanChat_PopupFrame.fadeOut);
  end
end

function CleanChat_ChatCommand(msg)
  if msg == "" then
    if CleanChatOptionsFrame:IsVisible() then
      CleanChatOptionsFrame:Hide();
    else
      CleanChatOptionsFrame:Show();
    end
  else
    CleanChat_PrintStatus();
  end
end

function CleanChat_PrintStatus()
  CleanChat_Message(string.format(CLEANCHAT_STATUSMSG, 1, CLEANCHAT_STATUS3[CleanChat_HideChannelnames]));
  CleanChat_Message(string.format(CLEANCHAT_STATUSMSG, 2, CLEANCHAT_STATUS1[CleanChat_IsHidePrefix]));
  if CleanChat_UseCursorKeys then
    CleanChat_Message(string.format(CLEANCHAT_STATUSMSG, 3, CLEANCHAT_USE_CURSORKEYS));
  end
  if CleanChat_HideChatButtons then
    CleanChat_Message(string.format(CLEANCHAT_STATUSMSG, 4, CLEANCHAT_HIDE_CHATBUTTONS));
  end
  if CleanChat_CollectData then
    CleanChat_Message(string.format(CLEANCHAT_STATUSMSG, 5, CLEANCHAT_COLLECTDATA));
  end
  if CleanChat_IsPersistent then
    CleanChat_Message(string.format(CLEANCHAT_STATUSMSG, 6, CLEANCHAT_PERSISTENT));
  end
  if CleanChat_ShowLevel then
    CleanChat_Message(string.format(CLEANCHAT_STATUSMSG, 7, CLEANCHAT_SHOWLEVEL));
  end
  if CleanChat_EnableMouseWheel then
    CleanChat_Message(string.format(CLEANCHAT_STATUSMSG, 8, CLEANCHAT_MOUSEWHEEL));
  end
  if CleanChat_Popup then
    CleanChat_Message(string.format(CLEANCHAT_STATUSMSG, 9, CLEANCHAT_POPUP));
  end
  CleanChat_Message(string.format(CLEANCHAT_STATUSMSG, 10, CLEANCHAT_STATUS2A[CleanChat_IsColorizeNicks]));
  if CleanChat_IsColorizeNicks then
    CleanChat_Message(string.format(CLEANCHAT_STATUSMSG, 11, CLEANCHAT_STATUS2B[CleanChat_IsColorizeNicks][CleanChat_IsClassColor]));
  end
  if CleanChat_IsColorizeNicks then
    for index, color in pairs(CleanChat_Colors) do
      CleanChat_Message(string.format(CLEANCHAT_STATUS4, CLEANCHAT_STATUS5[index],
                                                         ":", color,
                                                         CLEANCHAT_STATUS5[index]));
    end
  end
end

function CleanChat_AddWhoResultsToDatabase()
  for i = 1, GetNumWhoResults() do
    local whoname, guild, level, race, class = GetWhoInfo(i);
    if CleanChat_NameCache[whoname] then
      --CleanChat_Message("Adding level " ..level .. " class " .. CLEANCHAT_TRANSLATE_CLASS[class] .. " for " .. whoname);
      CleanChat_AddFlag("class", CLEANCHAT_TRANSLATE_CLASS[class], whoname);
      CleanChat_AddFlag("level", level, whoname);
    end
  end
end

function CleanChat_FriendsFrame_OnEvent()
  -- suppress pop up of who window if to many results if we send the who request
  if not (event == "WHO_LIST_UPDATE" and (GetTime() - whoTimestamp) < 3) then
    FriendsFrame_OnEvent_Org();
  end
end

function CleanChat_OnEvent(event)
  if event == "GUILD_ROSTER_UPDATE" then
    CleanChat_InsertGuildMembers();
  elseif event == "FRIENDLIST_UPDATE" then
    CleanChat_InsertFriends();
  elseif event == "PARTY_MEMBERS_CHANGED" then
    local _, _, lag = GetNetStats();
    delayPartyUpdate = lag / 1000 + 1;
  elseif event == "RAID_ROSTER_UPDATE" then
    local _, _, lag = GetNetStats();
    delayRaidUpdate = lag / 1000 + 1;
  elseif event == "CHAT_MSG_SYSTEM" and string.find(arg1, CLEANCHAT_WHO_RESULTS_PATTERN) then
    CleanChat_AddWhoResultsToDatabase()
  elseif event == "PLAYER_ENTERING_WORLD" then
    local _, class = UnitClass("player");
    CleanChat_AddFlag("class", CLASS_TO_INDEX[class], UnitName("player"));
    CleanChat_AddFlag("level", UnitLevel("player"), UnitName("player"));
    this:UnregisterEvent("PLAYER_ENTERING_WORLD");
  elseif event == "VARIABLES_LOADED" then
    CleanChat_RegisterMyAddons();
    CleanChat_SetupPrefix(CleanChat_IsHidePrefix);
    CleanChat_SetupCursorMode(CleanChat_UseCursorKeys);
    CleanChat_SetupButtons(CleanChat_HideChatButtons);
    CleanChat_SetupMouseWheel(CleanChat_EnableMouseWheel);
    CleanChat_SetupPersistent(CleanChat_IsPersistent);
    if not CleanChat_IsPersistent then
      CleanChat_UsedColors = {};
      CleanChat_NameCache = {};
      CleanChat_Message(CLEANCHAT_VERSION .. CLEANCHAT_LOADED);
    else
      CleanChat_CacheRemoveOlderEntries();
      CleanChat_Message(string.format(CLEANCHAT_LOADED_CACHE, CleanChat_CountNames()));
    end
    --RequestRaidInfo();
    if IsInGuild() then
      GuildRoster();
    end
    if GetNumFriends() > 0 then
      ShowFriends();
    end
    playerName = UnitName("player");
    playerNameLow = string.lower(playerName);
  end
end

function CleanChat_CountNames()
  local count = 0;
  for _, data in pairs(CleanChat_NameCache) do
    count = count + 1;
  end
  table.setn(CleanChat_NameCache, count);
  return count;
end

function CleanChat_OnUpdate(elapsed)
  if IsInGuild() then
    guildUpdateTimer = guildUpdateTimer - elapsed;
    if guildUpdateTimer < 0 then
      GuildRoster();
      guildUpdateTimer = GUILD_UPDATE_INTERVAL;
    end
  end

  if delayPartyUpdate >= 0 then
    delayPartyUpdate = delayPartyUpdate - elapsed;
    if delayPartyUpdate <= 0 then
      delayPartyUpdate = -1;
      CleanChat_InsertPartyMembers();
    end
  end

  if delayRaidUpdate >= 0 then
    delayRaidUpdate = delayRaidUpdate - elapsed;
    if delayRaidUpdate <= 0 then
      delayRaidUpdate = -1;
      CleanChat_InsertRaidMembers();
    end
  end
end

function CleanChat_InsertRaidMembers()
  CleanChat_RemoveFlags("isRaid");
  --CleanChat_DeleteIfFlag("realm");
  for i = 1, GetNumRaidMembers() do
    name, _, _, level, _, class = GetRaidRosterInfo(i);
    --CleanChat_Message("RAID " .. name .. " " .. level .. " " .. class);
    CleanChat_AddFlag("isRaid", true, name);
    CleanChat_AddFlag("class", CLASS_TO_INDEX[class], name);
    if level ~= 0 then
      CleanChat_AddFlag("level", level, name);
    end
    --local _, realm = UnitName("raid" .. i);
    --if realm then
    --  CleanChat_AddFlag("realm", realm, name);
    --end
  end
end

function CleanChat_InsertPartyMembers()
  -- remove from all names the party status
  CleanChat_RemoveFlags("isParty");
  -- add all party member
  for i = 1, GetNumPartyMembers() do
    local unit = "party" .. i;
    local _, class = UnitClass(unit);
    --CleanChat_Message("PARTY " .. unit .. " " .. UnitName(unit) .. " " .. UnitLevel(unit) );
    CleanChat_AddFlag("isParty", true, UnitName(unit));
    CleanChat_AddFlag("class", CLASS_TO_INDEX[class], UnitName(unit));
    if UnitLevel(unit) ~= 0 then
      CleanChat_AddFlag("level", UnitLevel(unit), UnitName(unit));
    end
  end
end

function CleanChat_InsertGuildMembers()
  -- remove from all names the guild status
  CleanChat_RemoveFlags("isGuild");
  -- add current online guild members
  for i = 1, GetNumGuildMembers() do
    local name, _, _, level, class = GetGuildRosterInfo(i);
    --CleanChat_Message("GUILD " .. name .. " " .. level .. " " .. class);
    CleanChat_AddFlag("isGuild", true, name);
    CleanChat_AddFlag("class", CLEANCHAT_TRANSLATE_CLASS[class], name);
    CleanChat_AddFlag("level", level, name);
  end
end

function CleanChat_InsertFriends()
  -- remove from all names the friend status
  CleanChat_RemoveFlags("isFriend");
  -- add current online friends
  for i = 1, GetNumFriends() do
    local name, level, class = GetFriendInfo(i);
    CleanChat_AddFlag("isFriend", true, name);
    if level ~= 0 then
      CleanChat_AddFlag("class", CLEANCHAT_TRANSLATE_CLASS[class], name);
      CleanChat_AddFlag("level", level, name);
    end
  end
end

function CleanChat_RemoveFlags(flag)
  for name, data in pairs(CleanChat_NameCache) do
    if data[flag] then
      CleanChat_NameCache[name][flag] = nil;
    end
  end
end

function CleanChat_DeleteIfFlag(flag)
  for name, data in pairs(CleanChat_NameCache) do
    if data[flag] then
      CleanChat_NameCache[name] = nil;
    end
  end
end

function CleanChat_AddFlag(flag, value, name)
  if name and value then
    if not CleanChat_NameCache[name] then
      CleanChat_NameCache[name] = { [flag] = value, timestamp = GetTime() + TIMEOUT };
    else
      CleanChat_NameCache[name][flag] = value;
    end
  end
end

function CleanChat_ChatFrame_OnEvent(event)
  -- Hook AddMessage
  if not this.CleanChat_AddMessage_Org then
    this.CleanChat_AddMessage_Org = this.AddMessage;
    this.AddMessage = CleanChat_AddMessage;
  end

  -- Save event data
  this.CleanChat_Name = arg2;
  this.event = event;
  -- Strip channel name
  if arg9 and event ~= "CHAT_MSG_CHANNEL_NOTICE" then
    local _, _, strippedChannelName = string.find(arg9, "([%aé]*)");
    if CLEANCHAT_CHANNELS[CleanChat_HideChannelnames][strippedChannelName] then
      this.CleanChat_Channelname = strippedChannelName;
      this.CleanChat_IsCustomChannel = false;
    elseif HIDECUSTOM_INDEX[CleanChat_HideChannelnames] and arg9 and arg9 ~= "" then
      this.CleanChat_Channelname = arg9;
      this.CleanChat_IsCustomChannel = true;
    end
  end

  -- Call original handler, if not a who response to our latest sendwho request
  if not ( event == "CHAT_MSG_SYSTEM"
           and (GetTime() - whoTimestamp) < 3
           and (string.find(arg1, CLEANCHAT_CHATPATTERN1) or string.find(arg1, CLEANCHAT_WHO_RESULTS_PATTERN)) ) then
    ChatFrame_OnEvent_Org(event);
  end
end

function CleanChat_AddMessage(this, msg, r, g, b, id)
  if msg then -- looks like some addons send nil messages
    -- Remove channel name
    if this.CleanChat_Channelname and this.CleanChat_IsCustomChannel ~= nil then
      if this.CleanChat_IsCustomChannel then
        msg = string.gsub(msg, "\. " .. this.CleanChat_Channelname, "", 1);
      else
        msg = string.gsub(msg,
                          CLEANCHAT_CHANNELS[CleanChat_HideChannelnames]["__PREFIX"] .. this.CleanChat_Channelname,
                          CLEANCHAT_CHANNELS[CleanChat_HideChannelnames][this.CleanChat_Channelname],
                          1);
      end
    end
    -- Colorize name
    if CleanChat_IsColorizeNicks
       and this.CleanChat_Name and string.len(this.CleanChat_Name) > 1
       and not (CleanChat_IgnoreEmotes and EVENTS_EMOTES[this.event])
    then
      local level = "";
      local strippedName = CleanChat_StripRealm(this.CleanChat_Name);

      if CleanChat_ShowLevel and not EVENTS_EMOTES[this.event] then
        if CleanChat_NameCache[strippedName] and CleanChat_NameCache[strippedName].level then
          level = ":" .. CleanChat_NameCache[strippedName].level;
        elseif CleanChat_CollectData then
          level = ":?"
        end
      end

      msg = string.gsub(msg, "(.-)" .. CleanChat_EscapeRealm(this.CleanChat_Name) .. "([%]%s].*)", "%1" .. CleanChat_GetColorFor(strippedName) .. this.CleanChat_Name .. level .. "|r%2", 1);
      -- Highligh player name in chat messages
      msg = string.gsub(msg, "(.*%s)" .. playerName .. "(.-)", "%1" .. CleanChat_GetColorFor(playerName) .. playerName .. "|r%2");
      msg = string.gsub(msg, "(.*%s)" .. playerNameLow .. "(.-)", "%1" .. CleanChat_GetColorFor(playerName) .. playerNameLow .. "|r%2");
    end

    -- popup if message contains player name and is not an emote and message not send by player
    if CleanChat_Popup
       and this.CleanChat_Name and string.len(this.CleanChat_Name) > 1
       and this.CleanChat_Name ~= playerName
       and not EVENTS_EMOTES[this.event]
       and (string.find(msg, playerName) or string.find(msg, playerNameLow)) --not perfect atm
    then
      CleanChat_PopupFrame.fadeOut = 10;
      CleanChat_PopupFrame:SetAlpha(1);
      CleanChat_PopupFrameText:SetText(msg);
      CleanChat_PopupFrame:Show();
      PlaySound("gsTitleOptionExit");
    end

    -- Highlight custom text
    for text, color in pairs(CleanChat_HighlightText) do
      msg = string.gsub(msg, "(.*)" .. text .. "(.-)", "%1" .. color .. text .. "|r%2");
    end
  end
  this.CleanChat_Name = nil;
  this.CleanChat_Channelname = nil;
  this.CleanChat_IsCustomChannel = nil;

  -- Every 5 minutes remove old entries
  if not CleanChat_IsPersistent and GetTime() > nextPurgeCheck then
    CleanChat_CacheRemoveOlderEntries();
    nextPurgeCheck = GetTime() + PURGE_INTERVAL;
  end
  -- Print it
  this:CleanChat_AddMessage_Org(msg, r, g, b, id);
end

-- Color management
function CleanChat_GetColorFor(name)
  if not CleanChat_NameCache[name] then
    CleanChat_NameCache[name] = {};
  end

  if CleanChat_CollectData and CleanChat_NameCache[name].level == nil then
    whoTimestamp = GetTime();
    SendWho("n-" .. name);
  end

  -- Assign a color even if maybe colors for guild/friend/others set.
  -- If guild/friend/others color gets deleted, the name has a color which stays the same.
  if not CleanChat_NameCache[name].color then
    CleanChat_NameCache[name].color = CleanChat_NewColor(name);
  end

  CleanChat_NameCache[name].timestamp = GetTime() + TIMEOUT;

  if CleanChat_Colors[MY_COLOR] and name == playerName then
    return CleanChat_Colors[MY_COLOR];
  elseif CleanChat_IsClassColor and CleanChat_NameCache[name].class and TEXT_RAID_COLORS[CleanChat_NameCache[name].class] then
    return TEXT_RAID_COLORS[CleanChat_NameCache[name].class];
  elseif CleanChat_NameCache[name].isGuild and CleanChat_Colors[GUILD_COLOR] then
    return CleanChat_Colors[GUILD_COLOR];
  elseif CleanChat_NameCache[name].isFriend and CleanChat_Colors[FRIEND_COLOR] then
    return CleanChat_Colors[FRIEND_COLOR];
  elseif CleanChat_NameCache[name].isParty and CleanChat_Colors[PARTY_COLOR] then
    return CleanChat_Colors[PARTY_COLOR];
  elseif CleanChat_NameCache[name].isRaid and CleanChat_Colors[RAID_COLOR] then
    return CleanChat_Colors[RAID_COLOR];
  elseif CleanChat_IsClassColor then
    if CleanChat_Colors[UNKNOWN_CLASS_COLOR] then
      return CleanChat_Colors[UNKNOWN_CLASS_COLOR];
    else
      return "|cffd0d0d0"; -- gray
    end
  elseif CleanChat_Colors[OTHER_COLOR] then
    return CleanChat_Colors[OTHER_COLOR];
  elseif not CleanChat_IsRandomColor then
    return "";
  else
    return CleanChat_NameCache[name].color;
  end
end

function CleanChat_CacheRemoveOlderEntries()
  for name, data in pairs(CleanChat_NameCache) do
    -- We have to keep all friend and guild names in memory so we can apply guild/friend colors if required.
    if (not data.timestamp) or (not data.isFriend and not data.isGuild and not data.isParty and not data.isRaid and GetTime() > data.timestamp) then
      if data.color then
        CleanChat_UsedColors[data.color] = nil;
      end
      CleanChat_NameCache[name] = nil;
    end
  end
end

function CleanChat_NewColor(name)
  local rgb = CleanChat_GetReadableColor(name);

  local color = string.format("|cff%s%s%s", CleanChat_ToHex(rgb[1]), CleanChat_ToHex(rgb[2]), CleanChat_ToHex(rgb[3]));

  i = 1;
  -- if current color is already in use, try next one
  while (CleanChat_UsedColors[color] or (color == CleanChat_Colors[FRIEND_COLOR]
                               or color == CleanChat_Colors[GUILD_COLOR]
                               or color == CleanChat_Colors[OTHER_COLOR]
                               or color == CleanChat_Colors[PARTY_COLOR]
                               or color == CleanChat_Colors[RAID_COLOR]))
        and i < 3
  do
    color = string.format("|cff%s%s%s", CleanChat_ToHex(rgb[1] + 1), CleanChat_ToHex(rgb[2] + 1), CleanChat_ToHex(rgb[3] + 1));
    i = i + 1;
  end
  CleanChat_UsedColors[color] = true;
  return color;
end

function CleanChat_GetReadableColor(name)
  local hash = CleanChat_HashString(name);
  local fg_r = math.floor(math.mod(hash / 97, 255));
  local fg_g = math.floor(math.mod(hash / 17, 255));
  local fg_b = math.floor(math.mod(hash / 227, 255));

  -- if contrast below XX then invert rgb values.
  -- max value value to check against is 127.
  -- if 127 used, color is always brightest possible for that name
  -- (255 / 2 = 127.5, thus if below 127 and inverting rgb the result is > 127).
  if ((fg_r * 299 + fg_g * 587 + fg_b * 114) / 1000) < 105 then
    fg_r = math.abs(fg_r - 255);
    fg_g = math.abs(fg_g - 255);
    fg_b = math.abs(fg_b - 255);
  end
  return {fg_r, fg_g, fg_b};
end

-- works only for numbers between 0-255;
local CLEANCHAT_HEX = { [0] = "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f" };
function CleanChat_ToHex(number)
  return CLEANCHAT_HEX[math.floor(number / 16)] .. CLEANCHAT_HEX[math.mod(number, 16)];
end

function CleanChat_Message(msg)
  ChatFrame1:AddMessage(string.format(CLEANCHAT_CHATMESSAGE, msg));
end

function CleanChat_HashString(name)
  local hash = 17;
  for i = 1, string.len(name) do
    hash = hash * 37 * string.byte(name, i);
  end
  return hash;
end

-- debug
function CleanChat_DumpCache()
  for name, data in pairs(CleanChat_NameCache) do
    if CleanChat_NameCache[name].level then
      CleanChat_Message(name .. " Level: " .. CleanChat_NameCache[name].level);
    end
    if CleanChat_IsClassColor then
      if data.class then
        CleanChat_Message(string.format("%s%s Timeout in %ds (color class based)", TEXT_RAID_COLORS[CleanChat_NameCache[name].class], name, data.timestamp - GetTime()));
      elseif CleanChat_Colors[UNKNOWN_CLASS_COLOR] then
        CleanChat_Message(string.format("%s%s Timeout in %ds (No Class info, custom color)", CleanChat_Colors[UNKNOWN_CLASS_COLOR], name, data.timestamp - GetTime()));
      else
        CleanChat_Message(string.format("%s%s Timeout in %ds (No Class info, default color)", "|cffC8C8C8", name, data.timestamp - GetTime()));
      end
    end

    if data.isFriend then
      if CleanChat_Colors[FRIEND_COLOR] then
        CleanChat_Message(string.format("%s%s Timeout in %ds [Friend]", CleanChat_Colors[FRIEND_COLOR], name, data.timestamp - GetTime()));
      elseif data.color then
        CleanChat_Message(string.format("%s%s Timeout in %ds [Friend]", data.color, name, data.timestamp - GetTime()));
      else
        CleanChat_Message(string.format("%s%s Timeout in %ds [Friend]", "|cffffffff", name, data.timestamp - GetTime()));
      end
    elseif data.isGuild then
      if CleanChat_Colors[GUILD_COLOR] then
        CleanChat_Message(string.format("%s%s Timeout in %ds [Guild]", CleanChat_Colors[GUILD_COLOR], name, data.timestamp - GetTime()));
      elseif data.color then
        CleanChat_Message(string.format("%s%s Timeout in %ds [Guild]", data.color, name, data.timestamp - GetTime()));
      else
        CleanChat_Message(string.format("%s%s Timeout in %ds [Guild]", "|cffffffff", name, data.timestamp - GetTime()));
      end
    elseif data.isParty then
      if CleanChat_Colors[PARTY_COLOR] then
        CleanChat_Message(string.format("%s%s Timeout in %ds [Party] %s", CleanChat_Colors[PARTY_COLOR], name, data.timestamp - GetTime(), CleanChat_NameCache[name].class));
      elseif data.color then
        CleanChat_Message(string.format("%s%s Timeout in %ds [Party] %s", data.color, name, data.timestamp - GetTime(),CleanChat_NameCache[name].class));
      else
        CleanChat_Message(string.format("%s%s Timeout in %ds [Party] %s", "|cffffffff", name, data.timestamp - GetTime(),CleanChat_NameCache[name].class));
      end
    elseif data.isRaid then
      if CleanChat_Colors[RAID_COLOR] then
        CleanChat_Message(string.format("%s%s Timeout in %ds [Raid]", CleanChat_Colors[RAID_COLOR], name, data.timestamp - GetTime()));
      elseif data.color then
        CleanChat_Message(string.format("%s%s Timeout in %ds [Raid]", data.color, name, data.timestamp - GetTime()));
      else
        CleanChat_Message(string.format("%s%s Timeout in %ds [Raid]", "|cffffffff", name, data.timestamp - GetTime()));
      end
    else
      if CleanChat_Colors[OTHER_COLOR] then
        CleanChat_Message(string.format("%s%s Timeout in %ds", CleanChat_Colors[OTHER_COLOR], name, data.timestamp - GetTime()));
      elseif data.color then
        CleanChat_Message(string.format("%s%s Timeout in %ds", data.color, name, data.timestamp - GetTime()));
      else
        CleanChat_Message(string.format("%s%s Timeout in %ds",  "|cffffffff", name, data.timestamp - GetTime()));
      end
    end
  end
  CleanChat_Message(string.format("Purge check in %.1fs", nextPurgeCheck - GetTime()));
end
--

-- MyAddons 2.0 support
function CleanChat_RegisterMyAddons()
  if myAddOnsFrame_Register then
    myAddOnsFrame_Register( {
      name = CLEANCHAT_NAME,
      description = CLEANCHAT_MYADDONS_DESCRIPTION,
      version = CLEANCHAT_VERSION,
      releaseDate = CLEANCHAT_MYADDONS_RELEASEDATE,
      author = "wbb",
      email = "<wb@illogical.de>",
      website = "http://www.illogical.de",
      category = MYADDONS_CATEGORY_CHAT,
      frame = "CleanChatFrame",
      optionsframe = "CleanChatOptionsFrame"
    }, {
      CLEANCHAT_HELP[1] .. "\n" ..
      CLEANCHAT_HELP[2]
    } );
  end
end