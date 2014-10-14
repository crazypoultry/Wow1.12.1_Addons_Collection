-- $Id: ChatAssist.lua 106 2006-09-17 19:46:50Z ayu $
-- $URL: svn://freesia.commun.jp/chatassist/trunk/ChatAssist/ChatAssist.lua $

ChatAssist_KeywordColor = "e8a038";
ChatAssist_KeywordSound = "Sound\\interface\\AuctionWindowOpen.wav";
ChatAssist_ChatFont = "Interface\\AddOns\\ChatAssist\\font01.ttf";
ChatAssist_URLColor = "0000ff";
ChatAssist_ClassColor = {
 "ff7c0a", -- Druid
 "aad372", -- Hunter
 "68cbef", -- Mage
 "f48cba", -- Paladin
 "ffffff", -- Priest
 "fff468", -- Rouge
 "f48cba", -- Shaman
 "9382c9", -- Warlock
 "c69b6d", -- Warrior
};
-- Please do not change below this line.
ChatAssist_Version = "0.28";
ChatAssist_AddMessage1_Original = nil;
ChatAssist_AddMessage2_Original = nil;
ChatAssist_AddMessage3_Original = nil;
ChatAssist_AddMessage4_Original = nil;
ChatAssist_AddMessage5_Original = nil;
ChatAssist_AddMessage6_Original = nil;
ChatAssist_AddMessage7_Original = nil;
ChatAssist_SetItemRef_Original = nil;
ChatAssist_SendChatMessage_Original = nil;

ChatAssist_KeywordLog = {};
ChatAssist_AuctionLog = {};
ChatAssist_ClassCache = {};
ChatAssist_SkipParse = 0;
ChatAssist_KeywordInterval = 2;
ChatAssist_LastKeyword = nil;
ChatAssist_LastKeywordTime = 0;
ChatAssist_Config = {};
ChatAssist_ConfigDefault = {
  Version = 0;
  Keywords = {"Keyword"},
  ChannelSticky = 0,
  OfficerSticky = 0,
  WhisperSticky = 0,
  Timestamp = 1,
  TimestampFormat = "%H:%M",
  Logging = 0,
  Window = {1, 0, 1, 1, 1, 1, 1},
  Locale = "enUS",
  ColorName = 1,
  ShortTag = 0,
  HideTag = 0,
  HideChannel = 0,
  UnicodeBlock = { enable = 1, guild = 0, party = 0, raid = 0, raidwarning = 0, officer = 0 },
  DefaultChat = "say",
  OnScreenFontSize = 24,
  Event = {
    KEYWORD = { OnScreen = 0, OnScreenColor = { r = 0.85, g = 0.37, b = 0.00 }},
    AUCTION = { OnScreen = 0, OnScreenColor = { r = 0.76, g = 0.00, b = 0.40 }},
    RAIDLEADER = { OnScreen = 0, OnScreenColor = { r = 0.99, g = 0.98, b = 0.00 }},
    BGLEADER = { OnScreen = 0, OnScreenColor = { r = 0.99, g = 0.98, b = 0.00 }},
    OFFICER = { OnScreen = 0, OnScreenColor = { r = 0.35, g = 0.67, b = 0.42 }},
    WHISPER = { OnScreen = 0, OnScreenColor = { r = 0.87, g = 0.41, b = 0.58 }},
  },
};


-- OnLoad
function ChatAssist_OnLoad()
  this:RegisterEvent("PLAYER_ENTERING_WORLD");
  this:RegisterEvent("PLAYER_LEAVING_WORLD");
  this:RegisterEvent("ADDON_LOADED");
  this:RegisterEvent("VARIABLES_LOADED");
  this:RegisterEvent("PARTY_MEMBERS_CHANGED");
  this:RegisterEvent("RAID_ROSTER_UPDATE");
  this:RegisterEvent("GUILD_ROSTER_UPDATE");
  this:RegisterEvent("FRIENDLIST_UPDATE");
  this:RegisterEvent("CHAT_MSG_RAID_LEADER");
  this:RegisterEvent("CHAT_MSG_BATTLEGROUND_LEADER");
  this:RegisterEvent("CHAT_MSG_OFFICER");
  this:RegisterEvent("CHAT_MSG_WHISPER");

  SLASH_CHATASSIST1 = "/chatassist";
  SLASH_CHATASSIST2 = "/ca";
  SlashCmdList["CHATASSIST"] = function(msg)
    ChatAssist_SlashCommandHandler(msg);
  end
  SLASH_CHATASSIST_TT1 = "/tt";
  SlashCmdList["CHATASSIST_TT"] = function(msg)
    ChatAssist_SlashTellTarget(msg);
  end
end

function ChatAssist_OnEvent(event)
  -- PLAYER_ENTERING_WORLD
  if(event == "PLAYER_ENTERING_WORLD") then
    this:RegisterEvent("PARTY_MEMBERS_CHANGED");
    this:RegisterEvent("RAID_ROSTER_UPDATE");
    this:RegisterEvent("GUILD_ROSTER_UPDATE");
    this:RegisterEvent("FRIENDLIST_UPDATE");
    this:RegisterEvent("CHAT_MSG_RAID_LEADER");
    this:RegisterEvent("CHAT_MSG_BATTLEGROUND_LEADER");
    this:RegisterEvent("CHAT_MSG_OFFICER");
    this:RegisterEvent("CHAT_MSG_WHISPER");

    if(GetNumRaidMembers() > 0) then
      ChatAssist_UpdateClassCache("RAID");
    end

    if(ChatAssist_Config.ColorName == 1) then
      -- getPlayerName and getPlayerClass
      ChatAssist_UpdateClassCache("PLAYER");

      if(IsInGuild()) then
        GuildRoster();
      end
    end
  -- PLAYER_LEAVING_WORLD
  elseif(event == "PLAYER_LEAVING_WORLD") then
    this:UnregisterEvent("PARTY_MEMBERS_CHANGED");
    this:UnregisterEvent("RAID_ROSTER_UPDATE");
    this:UnregisterEvent("GUILD_ROSTER_UPDATE");
    this:UnregisterEvent("FRIENDLIST_UPDATE");
    this:UnregisterEvent("CHAT_MSG_RAID_LEADER");
    this:UnregisterEvent("CHAT_MSG_BATTLEGROUND_LEADER");
    this:UnregisterEvent("CHAT_MSG_OFFICER");
    this:UnregisterEvent("CHAT_MSG_WHISPER");
  -- VARIABLES_LOADED
  elseif(event == "VARIABLES_LOADED") then
    -- Variables check
    for a, b in ChatAssist_ConfigDefault do
      if(ChatAssist_Config[a] == nil) then
        ChatAssist_Config[a] = ChatAssist_ConfigDefault[a];
      elseif(ChatAssist_Config[a] == true) then
        ChatAssist_Config[a] = 1;
      elseif(type(ChatAssist_ConfigDefault[a]) == "table") then
        for c, d in ChatAssist_ConfigDefault[a] do
          if(ChatAssist_Config[a][c] == nil) then
            ChatAssist_Config[a][c] = ChatAssist_ConfigDefault[a][c];
          elseif(ChatAssist_Config[a][c] == true) then
            ChatAssist_Config[a][c] = 1;
          end
        end
      end
    end

    -- Locale
    if(ChatAssist_Config.Locale == "jaJP") then
      ChatAssist_Localize_jaJP();
     end

    -- Logging
    if(ChatAssist_Config.Logging == 1) then
      LoggingChat(1);
    end

    -- Channel Sticky
    if(ChatAssist_Config.ChannelSticky == 1) then
      ChatTypeInfo["CHANNEL"].sticky = 1;
    end

    -- Officer Sticky
    if(ChatAssist_Config.OfficerSticky == 1) then
      ChatTypeInfo["OFFICER"].sticky = 1;
    end

    -- Whisper Sticky
    if(ChatAssist_Config.WhisperSticky == 1) then
      ChatTypeInfo["WHISPER"].sticky = 1;
    end

    -- ChatType
    if(ChatAssist_Config.DefaultChat) then
      DEFAULT_CHAT_FRAME.editBox.chatType = string.upper(ChatAssist_Config.DefaultChat);
      DEFAULT_CHAT_FRAME.editBox.stickyType = string.upper(ChatAssist_Config.DefaultChat);
    end

    -- Variable Load Complete
    DEFAULT_CHAT_FRAME:AddMessage(string.format(CA_LOADED, ChatAssist_Version));

    -- Hook ChatFrame
    ChatAssist_HookChatFrame();

    -- MessageFont
    if(ChatAssist_MessageFont:SetFont(ChatAssist_ChatFont, ChatAssist_Config.OnScreenFontSize) == nil) then
      ChatAssist_MessageFont:SetFont("Fonts\\FRIZQT__.TTF", ChatAssist_Config.OnScreenFontSize);
    end

    -- register for myAddOns
    if(myAddOnsFrame_Register ~= nil) then
      local info = {
        name = CA_CHATASSIST;
        version = ChatAssist_Version;
        author = "ayu";
        website = "http://fed.commun.jp/";
        category = MYADDONS_CATEGORY_CHAT;
        optionsframe = "ChatAssistOptionsFrame";
      };
      myAddOnsFrame_Register(info);
    end
  -- ADDON_LOADED
  elseif(event == "ADDON_LOADED" and ChatAssist_ChatFont ~= nil) then
    -- Replace Font
    ChatFontNormal:SetFont(ChatAssist_ChatFont, 14);
    -- RaidWarning
    RaidWarningFrame:SetFont(ChatAssist_ChatFont, 18);
    -- Replace Mail Font
    --SendMailSubjectEditBox:SetFont(ChatAssist_ChatFont, 14);
    SendMailBodyEditBox:SetFont(ChatAssist_ChatFont, 14);
    for i=1, INBOXITEMS_TO_DISPLAY do
      getglobal("MailItem"..i.."Subject"):SetFont(ChatAssist_ChatFont, 14);
    end
    OpenMailSubject:SetFont(ChatAssist_ChatFont, 14);
    OpenMailBodyText:SetFont(ChatAssist_ChatFont, 14);
    -- Replace CT_RaidAssist (CT_RAMessageFrame) Font
    if(CT_RAMessageFrame ~= nil) then
      CT_RAMessageFrame:SetFont(ChatAssist_ChatFont, 18);
    end
  elseif(event == "PARTY_MEMBERS_CHANGED") then
    ChatAssist_UpdateClassCache("PARTY");
  elseif(event == "RAID_ROSTER_UPDATE") then
    ChatAssist_UpdateClassCache("RAID");
  elseif(event == "GUILD_ROSTER_UPDATE") then
    ChatAssist_UpdateClassCache("GUILD");
  elseif(event == "FRIENDLIST_UPDATE") then
    ChatAssist_UpdateClassCache("FRIEND");
  elseif(event == "CHAT_MSG_RAID_LEADER") then
    if(ChatAssist_Config.Event.RAIDLEADER.OnScreen == 1) then
      ChatAssist_MessageFrame:AddMessage("[" .. arg2 .. "]: " .. arg1, ChatAssist_Config.Event.RAIDLEADER.OnScreenColor.r, ChatAssist_Config.Event.RAIDLEADER.OnScreenColor.g, ChatAssist_Config.Event.RAIDLEADER.OnScreenColor.b, 1.0, UIERRORS_HOLD_TIME);
    end
  elseif(event == "CHAT_MSG_BATTLEGROUND_LEADER") then
    if(ChatAssist_Config.Event.BGLEADER.OnScreen == 1) then
      ChatAssist_MessageFrame:AddMessage("[" .. arg2 .. "]: " .. arg1, ChatAssist_Config.Event.BGLEADER.OnScreenColor.r, ChatAssist_Config.Event.BGLEADER.OnScreenColor.g, ChatAssist_Config.Event.BGLEADER.OnScreenColor.b, 1.0, UIERRORS_HOLD_TIME);
    end
  elseif(event == "CHAT_MSG_OFFICER") then
    if(ChatAssist_Config.Event.OFFICER.OnScreen == 1) then
      ChatAssist_MessageFrame:AddMessage("[" .. arg2 .. "]: " .. arg1, ChatAssist_Config.Event.OFFICER.OnScreenColor.r, ChatAssist_Config.Event.OFFICER.OnScreenColor.g, ChatAssist_Config.Event.OFFICER.OnScreenColor.b, 1.0, UIERRORS_HOLD_TIME);
    end
  elseif(event == "CHAT_MSG_WHISPER") then
    if(ChatAssist_Config.Event.WHISPER.OnScreen == 1) then
      ChatAssist_MessageFrame:AddMessage("[" .. arg2 .. "]whispers: " .. arg1, ChatAssist_Config.Event.WHISPER.OnScreenColor.r, ChatAssist_Config.Event.WHISPER.OnScreenColor.g, ChatAssist_Config.Event.WHISPER.OnScreenColor.b, 1.0, UIERRORS_HOLD_TIME);
    end
  end
end

-- MouseWheel Enabled
function ChatAssist_OnMouseWheel(frame, value)
  if(IsShiftKeyDown()) then
    if(value > 0) then
      frame:ScrollToTop();
    else
      frame:ScrollToBottom();
    end
  elseif(IsControlKeyDown()) then
    if(value > 0) then
      frame:PageUp();
    else
      frame:PageDown();
    end
  else
    if(value > 0) then
      frame:ScrollUp();
    else
      frame:ScrollDown();
    end
  end
end

function ChatAssist_HookChatFrame()
  if(DEFAULT_CHAT_FRAME.AddMessage ~= ChatAssist_AddMessage1) then
    ChatAssist_AddMessage1_Original = DEFAULT_CHAT_FRAME.AddMessage
    DEFAULT_CHAT_FRAME.AddMessage = ChatAssist_AddMessage1
  end

  if(ChatFrame2 and ChatFrame2.AddMessage ~= ChatAssist_AddMessage2) then
    ChatAssist_AddMessage2_Original = ChatFrame2.AddMessage
    ChatFrame2.AddMessage = ChatAssist_AddMessage2
  end

  if(ChatFrame3 and ChatFrame3.AddMessage ~= ChatAssist_AddMessage3) then
    ChatAssist_AddMessage3_Original = ChatFrame3.AddMessage
    ChatFrame3.AddMessage = ChatAssist_AddMessage3
  end

  if(ChatFrame4 and ChatFrame4.AddMessage ~= ChatAssist_AddMessage4) then
    ChatAssist_AddMessage4_Original = ChatFrame4.AddMessage
    ChatFrame4.AddMessage = ChatAssist_AddMessage4
  end

  if(ChatFrame5 and ChatFrame5.AddMessage ~= ChatAssist_AddMessage5) then
    ChatAssist_AddMessage5_Original = ChatFrame5.AddMessage
    ChatFrame5.AddMessage = ChatAssist_AddMessage5
  end

  if(ChatFrame6 and ChatFrame6.AddMessage ~= ChatAssist_AddMessage6) then
    ChatAssist_AddMessage6_Original = ChatFrame6.AddMessage
    ChatFrame6.AddMessage = ChatAssist_AddMessage6
  end

  if(ChatFrame7 and ChatFrame7.AddMessage ~= ChatAssist_AddMessage7) then
    ChatAssist_AddMessage7_Original = ChatFrame7.AddMessage
    ChatFrame7.AddMessage = ChatAssist_AddMessage7
  end

  if(SetItemRef ~= ChatAssist_SetItemRef) then
    ChatAssist_SetItemRef_Original = SetItemRef;
    SetItemRef = ChatAssist_SetItemRef;
  end

  if(SendChatMessage ~= ChatAssist_SendChatMessage) then
    ChatAssist_SendChatMessage_Original = SendChatMessage;
    SendChatMessage = ChatAssist_SendChatMessage;
  end
end

function ChatAssist_ParseMessage(text)
  if text == nil then
    return text;
  end

  -- ShortTag
  if(ChatAssist_Config.ShortTag == 1 and string.find(text, ":%s") and (string.find(text, "|Hplayer:") or string.find(text, "%s:%s"))) then
    text = string.gsub(text, "%[%d+%.%s" .. CA_CHANNEL_GENERAL .. "%]", "[" .. CA_SCHANNEL_GENERAL .. "]");
    text = string.gsub(text, "%[%d+%.%s" .. CA_CHANNEL_TRADE .. "%]", "[" .. CA_SCHANNEL_TRADE .. "]");
    text = string.gsub(text, "%[%d+%.%s" .. CA_CHANNEL_LFG .. "%]", "[" .. CA_SCHANNEL_LFG .. "]");
    text = string.gsub(text, "%[%d+%.%s" .. CA_CHANNEL_WORLDDEFENSE .. "%]", "[" .. CA_SCHANNEL_WORLDDEFENSE .. "]");
    text = string.gsub(text, "%[%d+%.%s" .. CA_CHANNEL_LOCALDEFENSE .. "%]", "[" .. CA_SCHANNEL_LOCALDEFENSE .. "]");
    text = string.gsub(text, "%[%d+%.%s" .. CA_CHANNEL_GR .. "%]", "[" .. CA_SCHANNEL_GR .. "]");
    text = string.gsub(text, "%[" .. CA_CHANNEL_PARTY .. "%]", "[".. CA_SCHANNEL_PARTY .. "]");
    text = string.gsub(text, "%[" .. CA_CHANNEL_RAID .. "%]", "[".. CA_SCHANNEL_RAID .. "]");
    text = string.gsub(text, "%[" .. CA_CHANNEL_RAIDLEADER .. "%]", "[".. CA_SCHANNEL_RAIDLEADER .. "]");
    text = string.gsub(text, "%[" .. CA_CHANNEL_RAIDWARNING .. "%]", "[".. CA_SCHANNEL_RAIDWARNING .. "]");
    text = string.gsub(text, "%[" .. CA_CHANNEL_BATTLEGROUND .. "%]", "[".. CA_SCHANNEL_BATTLEGROUND .. "]");
    text = string.gsub(text, "%[" .. CA_CHANNEL_BATTLEGROUNDLEADER .. "%]", "[".. CA_SCHANNEL_BATTLEGROUNDLEADER .. "]");
    text = string.gsub(text, "%[" .. CA_CHANNEL_GUILD .. "%]", "[".. CA_SCHANNEL_GUILD .. "]");
    text = string.gsub(text, "%[" .. CA_CHANNEL_OFFICER .. "%]", "[".. CA_SCHANNEL_OFFICER .. "]");
    text = string.gsub(text, "%[" .. "(%d+)%.%s%w+" .. "%]", "[%1]");
  -- HideTag
  elseif(ChatAssist_Config.HideTag == 1 and string.find(text, ":%s") and (string.find(text, "|Hplayer:") or string.find(text, "%s:%s"))) then
    text = string.gsub(text, "%[" .. CA_CHANNEL_PARTY .. "%]%s", "");
    text = string.gsub(text, "%[" .. CA_CHANNEL_RAID .. "%]%s", "");
    text = string.gsub(text, "%[" .. CA_CHANNEL_RAIDLEADER .. "%]%s", "");
    text = string.gsub(text, "%[" .. CA_CHANNEL_RAIDWARNING .. "%]%s", "");
    text = string.gsub(text, "%[" .. CA_CHANNEL_BATTLEGROUND .. "%]%s", "");
    text = string.gsub(text, "%[" .. CA_CHANNEL_BATTLEGROUNDLEADER .. "%]%s", "");
    text = string.gsub(text, "%[" .. CA_CHANNEL_GUILD .. "%]%s", "");
    text = string.gsub(text, "%[" .. CA_CHANNEL_OFFICER .. "%]%s", "");
    if(ChatAssist_Config.HideChannel == 1) then
      text = string.gsub(text, "%[" .. "(%d+)%.%s%w+" .. "%]%s", "");
      if(string.sub(text, 1, 2) == ": ") then
        text = string.sub(text, 3);
      end
    else
      text = string.gsub(text, "%[" .. "(%d+)%.%s%w+" .. "%]", "[%1]");
    end
  end

  -- ColorName
  if(ChatAssist_Config.ColorName == 1 and string.find(text, "|Hplayer:")) then
    local name = string.gsub(text, ".*|Hplayer:([%w%-]-)|h%[([%w%-]-)%]|h.*", "%1");
    local mist = string.find(name, "-", 1, true);
    local name1, class = 0;
    if(mist ~= nil) then
      name1 = string.sub(name, 1, mist - 1);
      class = ChatAssist_GetClassCache(name1);
    else
      class = ChatAssist_GetClassCache(name);
    end

    if(class ~= nil and class ~= 0) then
      name = string.gsub(name, "%-", "%%-");
      text = string.gsub(text, "|Hplayer:".. name .. "|h%[".. name .. "%]|h", "[|cff" .. ChatAssist_ClassColor[class] .. "|Hplayer:" .. name .. "|h" .. name .. "|h|r]");
    end
  end

  -- URL
  local urlreplace = 0;
  text, urlreplace = string.gsub(text, "(https?://[$-_%.!~%*'%(%)a-zA-Z0-9;/%?:@&=%+%$,%%#]+)", "|cff" .. ChatAssist_URLColor .. "|Hurl:%1|h[%1]|h|r");
  if(urlreplace == 0) then
    text = string.gsub(text, "(www%.[$-_%.!~%*'%(%)a-zA-Z0-9;/%?:@&=%+%$,%%#]+)", "|cff" .. ChatAssist_URLColor .. "|Hurl:%1|h[%1]|h|r");
  end

  -- ItemLink
  text = string.gsub(text, "{CLINK:(%x+):([0-9]+):([0-9]+):([0-9]+):([0-9]+):([^}]+)}", "|c%1|Hitem:%2:%3:%4:%5|h[%6]|h|r");

  -- Timestamp
  if(ChatAssist_Config.Timestamp == 1) then
    local ts = ChatAssist_Config.TimestampFormat;
    local date_H = date("%H");
    local date_M = date("%M");
    local date_S = date("%S");
    local date_I = date("%I");
    local date_P = "";
    local date_p = "";

    if(tonumber(date_H) < 12) then
      date_P = "AM";
      date_p = "am";
    else
      date_P = "PM";
      date_p = "pm";
    end

    ts = string.gsub(ts, "%%H", date_H);
    ts = string.gsub(ts, "%%M", date_M);
    ts = string.gsub(ts, "%%S", date_S);
    ts = string.gsub(ts, "%%I", date_I);
    ts = string.gsub(ts, "%%P", date_P);
    ts = string.gsub(ts, "%%p", date_p);
    text = "[" .. ts .. "] " .. text;
  end

  -- AuctionLog

  for key,value in pairs(CA_AUCTIONMSG) do
    if(string.find(text, value)) then
      -- AuctionLog
      table.insert(ChatAssist_AuctionLog, text);
      if(table.getn(ChatAssist_AuctionLog) > 30) then
        table.remove(ChatAssist_AuctionLog, 1);
      end
      ChatAssist_HistoryFrameChange("AUCTION");

      if(ChatAssist_Config.Event.AUCTION.OnScreen == 1) then
        ChatAssist_MessageFrame:AddMessage(text, ChatAssist_Config.Event.AUCTION.OnScreenColor.r, ChatAssist_Config.Event.AUCTION.OnScreenColor.g, ChatAssist_Config.Event.AUCTION.OnScreenColor.b, 1.0, UIERRORS_HOLD_TIME);
      end
      break;
    end
  end

  -- Keyword
  local st, ed = string.find(text, ": ");
  if(ed ~= nil and string.find(text, "|Hplayer"))then
    local tag = string.sub(text, 1, st -1);
    local chat = string.sub(text, ed + 1, -1);
    local match = 0;
    for key,value in pairs(ChatAssist_Config.Keywords) do
      if(string.find(chat, value) ~= nil) then
        chat = string.gsub(chat, value, "|cff" .. ChatAssist_KeywordColor .. value .. "|r");
        match = 1;
      end
    end
    if(match == 1) then
      text = tag .. ": " .. chat;
      if(ChatAssist_LastKeyword ~= text or ChatAssist_LastKeywordTime < time() - ChatAssist_KeywordInterval) then
        ChatAssist_LastKeyword = text;
        ChatAssist_LastKeywordTime = time();
        -- KeywordLog
        table.insert(ChatAssist_KeywordLog, text);
        if(table.getn(ChatAssist_KeywordLog) > 30) then
          table.remove(ChatAssist_KeywordLog, 1);
        end
        ChatAssist_HistoryFrameChange("KEYWORD");

        -- PlaySound
        if(ChatAssist_KeywordSound ~= nil) then
          PlaySoundFile(ChatAssist_KeywordSound);
        end

        if(ChatAssist_Config.Event.KEYWORD.OnScreen == 1) then
          ChatAssist_MessageFrame:AddMessage(text, ChatAssist_Config.Event.KEYWORD.OnScreenColor.r, ChatAssist_Config.Event.KEYWORD.OnScreenColor.g, ChatAssist_Config.Event.KEYWORD.OnScreenColor.b, 1.0, UIERRORS_HOLD_TIME);
        end
      end
    end
  end

  return text;
end

function ChatAssist_AddMessage1(t, s, ...)
  if(ChatAssist_Config.Window[1] == 1) then
    s = ChatAssist_ParseMessage(s);
  end
  ChatAssist_AddMessage1_Original(t, s, unpack(arg));
end

function ChatAssist_AddMessage2(t, s, ...)
  if(ChatAssist_Config.Window[2] == 1) then
    s = ChatAssist_ParseMessage(s);
  end
  ChatAssist_AddMessage2_Original(t, s, unpack(arg));
end

function ChatAssist_AddMessage3(t, s, ...)
  if(ChatAssist_Config.Window[3] == 1) then
    s = ChatAssist_ParseMessage(s);
  end
  ChatAssist_AddMessage3_Original(t, s, unpack(arg));
end

function ChatAssist_AddMessage4(t, s, ...)
  if(ChatAssist_Config.Window[4] == 1) then
    s = ChatAssist_ParseMessage(s);
  end
  ChatAssist_AddMessage4_Original(t, s, unpack(arg));
end

function ChatAssist_AddMessage5(t, s, ...)
  if(ChatAssist_Config.Window[5] == 1) then
    s = ChatAssist_ParseMessage(s);
  end
  ChatAssist_AddMessage5_Original(t, s, unpack(arg));
end

function ChatAssist_AddMessage6(t, s, ...)
  if(ChatAssist_Config.Window[6] == 1) then
    s = ChatAssist_ParseMessage(s);
  end
  ChatAssist_AddMessage6_Original(t, s, unpack(arg));
end

function ChatAssist_AddMessage7(t, s, ...)
  if(ChatAssist_Config.Window[7] == 1) then
    s = ChatAssist_ParseMessage(s);
  end
  ChatAssist_AddMessage7_Original(t, s, unpack(arg));
end

function ChatAssist_SetItemRef(link, text, button)
  local type = strsub(link, 1, 3);
  if(type == "url") then
    ChatAssist_URLFrame:Show();
    ChatAssist_URLFrameURLEditBox:SetText(strsub(link, 5));
  else
    ChatAssist_SetItemRef_Original(link, text, button);
  end
end

function ChatAssist_SendChatMessage(msg, ...)
  local channel_name;
  local system, language, channel_id = unpack(arg);

  if((msg == nil or msg == "") and system ~= "AFK" and system ~= "DND") then
    return;
  end

  -- Channel
  if(system == "CHANNEL") then
    channel_id, channel_name = GetChannelName(channel_id);
    if(channel_id == 0 or channel_name == nil) then
      return;
    end
    if(not string.find(channel_name, "^".. CA_CHANNEL_GENERAL .." -") and not string.find(channel_name, "^".. CA_CHANNEL_TRADE .." -") and not string.find(channel_name, "^".. CA_CHANNEL_LOCALDEFENSE .. " -") and not string.find(channel_name, "^".. CA_CHANNEL_WORLDDEFENSE .." -") and not string.find(channel_name, "^".. CA_CHANNEL_LFG .." -") and not string.find(channel_name, "^".. CA_CHANNEL_GR)) then
      msg = string.gsub(msg, "|c(%x+)|Hitem:([0-9]+):([0-9]+):([0-9]+):([0-9]+)|h%[([^%]]+)%]|h|r", "{CLINK:%1:%2:%3:%4:%5:%6}");
    end
  end

  if(ChatAssist_isMultiByte(msg) and ChatAssist_Config.UnicodeBlock["enable"] == 1) then
    -- Say Emote Shout check
    if(system == "SAY" or system == "EMOTE" or system == "YELL" or system == "BATTLEGROUND") then
      ChatAssist_SendMessage(CA_UB_NOTALLOWED);
      return;
    elseif(system == "CHANNEL") then
      if(string.find(channel_name, "^".. CA_CHANNEL_GENERAL .." -") or string.find(channel_name, "^".. CA_CHANNEL_TRADE .." -") or string.find(channel_name, "^".. CA_CHANNEL_LOCALDEFENSE .. " -") or string.find(channel_name, "^".. CA_CHANNEL_WORLDDEFENSE .." -") or string.find(channel_name, "^".. CA_CHANNEL_LFG .." -") or string.find(channel_name, "^".. CA_CHANNEL_GR)) then
        ChatAssist_SendMessage(CA_UB_NOTALLOWED);
        return;
      end
    elseif(system == "PARTY" and ChatAssist_Config.UnicodeBlock["party"] == 1) then
      ChatAssist_SendMessage(CA_UB_NOTALLOWED);
      return;
    elseif(system == "RAID" and ChatAssist_Config.UnicodeBlock["raid"] == 1) then
      ChatAssist_SendMessage(CA_UB_NOTALLOWED);
      return;
    elseif(system == "RAID_WARNING" and ChatAssist_Config.UnicodeBlock["raidwarning"] == 1) then
      ChatAssist_SendMessage(CA_UB_NOTALLOWED);
      return;
    elseif(system == "GUILD" and ChatAssist_Config.UnicodeBlock["guild"] == 1) then
      ChatAssist_SendMessage(CA_UB_NOTALLOWED);
      return;
    elseif(system == "OFFICER" and ChatAssist_Config.UnicodeBlock["officer"] == 1) then
      ChatAssist_SendMessage(CA_UB_NOTALLOWED);
      return;
    end
    ChatAssist_SendChatMessage_Original(msg, unpack(arg));
  else
    ChatAssist_SendChatMessage_Original(msg, unpack(arg));
  end
end

function ChatAssist_SendMessage(text)
  if text == nil then
    return;
  end
  ChatAssist_AddMessage1_Original(ChatFrame1, "[ChatAssist] " .. text);
--  ChatAssist_SkipParse = 1;
--  DEFAULT_CHAT_FRAME:AddMessage("[ChatAssist] " .. text);
--  ChatAssist_SkipParse = 0;
end

function ChatAssist_SlashCommandHandler(command)
  local args = {};
  for arg in string.gfind(command, '([^%s]+)') do
    table.insert(args, arg);
  end

  if(args[1] == "add") then
    -- check args
    if(args[2] == nil) then
      ChatAssist_SendMessage(CA_KEYWORD_USAGE);
      return;
    end

    -- Already exists?
    local exists = 0;
    for key,value in pairs(ChatAssist_Config.Keywords) do
      if(args[2] == value) then
        exists = 1;
      end
    end
    if(exists == 0) then
      table.insert(ChatAssist_Config.Keywords, args[2]);
      ChatAssist_SendMessage(format(CA_KEYWORD_ADD, args[2]));
    else
      ChatAssist_SendMessage(format(CA_KEYWORD_ADD_EXISTS, args[2]));
    end
    return;
  elseif(args[1] == "list") then
    ChatAssist_SendMessage(format(CA_KEYWORD_LIST, ChatAssist_strjoin(",", ChatAssist_Config.Keywords)));
    return;
  elseif(args[1] == "del") then
    -- check args
    if(args[2] == nil) then
      ChatAssist_SendMessage(CA_KEYWORD_DEL_USAGE);
      return;
    end
    local exists = 0;
    for key,value in pairs(ChatAssist_Config.Keywords) do
      if(args[2] == value) then
        table.remove(ChatAssist_Config.Keywords, key);
        exists = 1;
      end
    end
    if(exists ~= 1) then
      ChatAssist_SendMessage(format(CA_KEYWORD_DEL_ERROR, args[2]));
    else
      ChatAssist_SendMessage(format(CA_KEYWORD_DEL, args[2]));
    end
    return;
  elseif(args[1] == "channelsticky") then
    if(ChatAssist_Config.ChannelSticky == 1) then
      ChatAssist_SendMessage(CA_CHANNELSTICKY_DISABLE);
      ChatAssist_Config.ChannelSticky = 0;
      ChatTypeInfo["CHANNEL"].sticky = 0;
    else
      ChatAssist_SendMessage(CA_CHANNELSTICKY_ENABLE);
      ChatAssist_Config.ChannelSticky = 1;
      ChatTypeInfo["CHANNEL"].sticky = 1;
    end
    return;
  elseif(args[1] == "officersticky") then
    if(ChatAssist_Config.OfficerSticky == 1) then
      ChatAssist_SendMessage(CA_OFFICERSTICKY_DISABLE);
      ChatAssist_Config.OfficerSticky = 0;
      ChatTypeInfo["OFFICER"].sticky = 0;
    else
      ChatAssist_SendMessage(CA_OFFICERSTICKY_ENABLE);
      ChatAssist_Config.OfficerSticky = 1;
      ChatTypeInfo["OFFICER"].sticky = 1;
    end
    return;
  elseif(args[1] == "whispersticky") then
    if(ChatAssist_Config.WhisperSticky == 1) then
      ChatAssist_SendMessage(CA_WHISPERSTICKY_DISABLE);
      ChatAssist_Config.WhisperSticky = 0;
      ChatTypeInfo["WHISPER"].sticky = 0;
    else
      ChatAssist_SendMessage(CA_WHISPERSTICKY_ENABLE);
      ChatAssist_Config.WhisperSticky = 1;
      ChatTypeInfo["WHISPER"].sticky = 1;
    end
    return;
  elseif(args[1] == "ts") then
    if(ChatAssist_Config.Timestamp == 1) then
      ChatAssist_SendMessage(CA_TIMESTAMP_DISABLE);
      ChatAssist_Config.Timestamp = 0;
    else
      ChatAssist_SendMessage(CA_TIMESTAMP_ENABLE);
      ChatAssist_Config.Timestamp = 1;
    end
    return;
  -- /ca tsformat
  elseif(args[1] == "tsformat") then
    if(args[2] ~= nil) then
      local ts = {};
      for key,value in pairs(args) do
        if(key ~= 1) then
          table.insert(ts, value);
        end
      end
      ChatAssist_Config.TimestampFormat = ChatAssist_strjoin(" ", ts);
      ChatAssist_SendMessage(CA_TIMESTAMP_MODIFIED);
    else
      ChatAssist_SendMessage(format(CA_TIMESTAMP_CURRENT, ChatAssist_Config.TimestampFormat));
    end
    return;
  elseif(args[1] == "window") then
    local winid = tonumber(args[2]);
    if(winid ~= nil and winid > 0 and winid < 8) then
      if(ChatAssist_Config.Window[winid] == 1) then
        ChatAssist_SendMessage(format(CA_WINDOW_DISABLE, winid));
        ChatAssist_Config.Window[winid] = 0;
      else
        ChatAssist_SendMessage(format(CA_WINDOW_ENABLE, winid));
        ChatAssist_Config.Window[winid] = 1;
      end
    else
      ChatAssist_SendMessage(CA_WINDOW_USAGE);
    end
    return;
  elseif(args[1] == "log") then
    if(ChatAssist_Config.Logging == 1) then
      ChatAssist_SendMessage(CA_LOG_DISABLE);
      ChatAssist_Config.Logging = 0;
      LoggingChat(0);
    else
      ChatAssist_SendMessage(CA_LOG_ENABLE);
      ChatAssist_Config.Logging = 1;
      LoggingChat(1);
    end
    return;
  elseif(args[1] == "history") then
    if(not ChatAssist_HistoryFrame:IsVisible()) then
      ChatAssist_HistoryFrame:Show();
    end
    ChatAssist_HistoryFrameChange("KEYWORD");
    return;
  elseif(args[1] == "locale") then
    if(args[2] ~= nil) then
      ChatAssist_Config.Locale = args[2];
      ChatAssist_SendMessage(CA_LOCALE_MODIFIED);
    else
      ChatAssist_SendMessage(format(CA_LOCALE_CURRENT, ChatAssist_Config.Locale));
    end
    return;
  elseif(args[1] == "colorname") then
    if(ChatAssist_Config.ColorName == 1) then
      ChatAssist_SendMessage(CA_COLORNAME_DISABLE);
      ChatAssist_Config.ColorName = 0;
    else
      ChatAssist_SendMessage(CA_COLORNAME_ENABLE);
      ChatAssist_Config.ColorName = 1;
      ChatAssist_RebuildClassCache();
    end
    return;
  elseif(args[1] == "shorttag") then
    if(ChatAssist_Config.ShortTag == 1) then
      ChatAssist_SendMessage(CA_SHORTTAG_DISABLE);
      ChatAssist_Config.ShortTag = 0;
    else
      ChatAssist_SendMessage(CA_SHORTTAG_ENABLE);
      ChatAssist_Config.ShortTag = 1;
      ChatAssist_Config.HideTag = 0;
    end
    return;
  elseif(args[1] == "hidetag") then
    if(ChatAssist_Config.HideTag == 1) then
      ChatAssist_SendMessage(CA_HIDETAG_DISABLE);
      ChatAssist_Config.HideTag = 0;
    else
      ChatAssist_SendMessage(CA_HIDETAG_ENABLE);
      ChatAssist_Config.HideTag = 1;
      ChatAssist_Config.ShortTag = 0;
    end
    return;
  elseif(args[1] == "hidechannel") then
    if(ChatAssist_Config.HideChannel == 1) then
      ChatAssist_SendMessage(CA_HIDECHANNEL_DISABLE);
      ChatAssist_Config.HideChannel = 0;
    else
      ChatAssist_SendMessage(CA_HIDECHANNEL_ENABLE);
      ChatAssist_Config.HideChannel = 1;
    end
    return;
  elseif(args[1] == "ub") then
    if(args[2] == "party" or args[2] == "raid" or args[2] == "raidwarning" or args[2] == "guild" or args[2] == "officer") then
      if(ChatAssist_Config.UnicodeBlock[args[2]] == 1) then
        ChatAssist_Config.UnicodeBlock[args[2]] = 0;
        ChatAssist_SendMessage(string.format(CA_UB_DISABLE, args[2]));
      else
        ChatAssist_Config.UnicodeBlock[args[2]] = 1;
        ChatAssist_SendMessage(string.format(CA_UB_ENABLE, args[2]));
      end
    elseif(args[2] == nil) then
      if(ChatAssist_Config.UnicodeBlock["enable"] == 1) then
        ChatAssist_Config.UnicodeBlock["enable"] = 0;
        ChatAssist_SendMessage(CA_UB_DISABLE2);
      else
        ChatAssist_Config.UnicodeBlock["enable"] = 1;
        ChatAssist_SendMessage(CA_UB_ENABLE2);
      end
    else
      ChatAssist_SendMessage(CA_UB_USAGE);
    end
  -- /ca defaultchat
  elseif(args[1] == "defaultchat") then
    if(args[2] == "say" or args[2] == "party" or args[2] == "raid" or args[2] == "guild" or args[2] == "officer") then
      ChatAssist_Config.DefaultChat = args[2];
      ChatAssist_SendMessage(string.format(CA_DEFAULTCHAT_MODIFIED, args[2]));
    else
      ChatAssist_SendMessage(CA_DEFAULTCHAT_USAGE);
    end
  -- /ca onscreen
  elseif(args[1] == "onscreen") then
    if(args[2] == "keyword" or args[2] == "auction" or args[2] == "raidleader" or args[2] == "bgleader" or args[2] == "officer" or args[2] == "whisper") then
      local event = string.upper(args[2]);
      if(ChatAssist_Config.Event[event].OnScreen == 1) then
        ChatAssist_SendMessage(string.format(CA_ONSCREEN_DISABLE, args[2]));
        ChatAssist_Config.Event[event].OnScreen = 0;
      else
        ChatAssist_SendMessage(string.format(CA_ONSCREEN_ENABLE, args[2]));
        ChatAssist_Config.Event[event].OnScreen = 1;
      end
    else
      ChatAssist_SendMessage(CA_ONSCREEN_USAGE);
    end
  -- /ca ccrebuild
  elseif(args[1] == "ccrebuild") then
    if(ChatAssist_Config.ColorName == 1) then
      ChatAssist_ClearClassCache();
      ChatAssist_RebuildClassCache();
    else
      ChatAssist_SendMessage("Error: ColorName is disabled.");
    end
    return;
  -- /ca frame (debug)
  elseif(args[1] == "frame") then
    local frame = EnumerateFrames();
    while frame do
      if frame:IsVisible() and MouseIsOver(frame) then
          ChatAssist_SendMessage(frame:GetName());
      end
      frame = EnumerateFrames(frame);
    end
  -- usage or show options
  else
    local loaded = LoadAddOn("ChatAssistOptions");
    if(loaded == 1) then
      ShowUIPanel(ChatAssistOptionsFrame);
    else
      ChatAssist_SendMessage(string.format(CA_USAGE, ChatAssist_Version));
    end
    return;
  end
end

-- telltarget
function ChatAssist_SlashTellTarget(msg)
  if(UnitExists("target")) then
    if(UnitIsPlayer("target") and UnitIsFriend("player", "target")) then
      SendChatMessage(msg, "WHISPER", nil, UnitName("target"));
    end
  end
end

function ChatAssist_HistoryFrameToggle(tab)
  if(ChatAssist_HistoryFrame:IsVisible()) then
    ChatAssist_HistoryFrame:Hide();
  else
    ChatAssist_HistoryFrame:Show();
    if(tab == "KEYWORD") then
      ChatAssist_HistoryFrameChange("KEYWORD");
    else
      ChatAssist_HistoryFrameChange("AUCTION");
    end
  end
end

function ChatAssist_HistoryFrameChange(tab)
  if(ChatAssist_HistoryFrame:IsVisible()) then
    if(tab == "KEYWORD") then
      ChatAssist_HistoryFrameScrollFrameString:SetText(ChatAssist_strjoin("\n", ChatAssist_KeywordLog));
      ChatAssist_HistoryFrameScrollFrame:SetHeight(ChatAssist_HistoryFrameScrollFrameString:GetHeight()+10);
      ChatAssist_HistoryFrameScroll:UpdateScrollChildRect();
      ChatAssist_HistoryFrameKeywordButton:Disable();
      ChatAssist_HistoryFrameAuctionButton:Enable();
    elseif(tab == "AUCTION") then
      ChatAssist_HistoryFrameScrollFrameString:SetText(ChatAssist_strjoin("\n", ChatAssist_AuctionLog));
      ChatAssist_HistoryFrameScrollFrame:SetHeight(ChatAssist_HistoryFrameScrollFrameString:GetHeight()+10);
      ChatAssist_HistoryFrameScroll:UpdateScrollChildRect();
      ChatAssist_HistoryFrameKeywordButton:Enable();
      ChatAssist_HistoryFrameAuctionButton:Disable();
    end
  end
end

function ChatAssist_OpenChat(type)
  if(type == "SAY") then
    ChatFrame_OpenChat("/s ");
  elseif(type == "PARTY") then
    ChatFrame_OpenChat("/p ");
  elseif(type == "RAID") then
    ChatFrame_OpenChat("/ra ");
  elseif(type == "RAIDWARNING") then
    ChatFrame_OpenChat("/rw ");
  elseif(type == "BATTLEGROUND") then
    ChatFrame_OpenChat("/bg ");
  elseif(type == "GUILD") then
    ChatFrame_OpenChat("/g ");
  elseif(type == "OFFICIER") then
    ChatFrame_OpenChat("/o ");
  elseif(type == "WHISPER") then
    ChatFrame_OpenChat("/tell ");
  elseif(type == "TT") then
    ChatFrame_OpenChat("/tt ");
  elseif(type == "CHANNEL1") then
    ChatFrame_OpenChat("/1 ");
  elseif(type == "CHANNEL2") then
    ChatFrame_OpenChat("/2 ");
  elseif(type == "CHANNEL3") then
    ChatFrame_OpenChat("/3 ");
  elseif(type == "CHANNEL4") then
    ChatFrame_OpenChat("/4 ");
  elseif(type == "CHANNEL5") then
    ChatFrame_OpenChat("/5 ");
  elseif(type == "CHANNEL6") then
    ChatFrame_OpenChat("/6 ");
  elseif(type == "CHANNEL7") then
    ChatFrame_OpenChat("/7 ");
  elseif(type == "CHANNEL8") then
    ChatFrame_OpenChat("/8 ");
  elseif(type == "CHANNEL9") then
    ChatFrame_OpenChat("/9 ");
  elseif(type == "CHANNEL10") then
    ChatFrame_OpenChat("/10 ");
  end
end

function ChatAssist_TakeScreenshot(hideui)
  if(hideui == true and UIParent:IsVisible()) then
    CloseAllWindows();
    UIParent:Hide();
  end
  TakeScreenshot();
  if(hideui == true) then
    UIParent:Show();
  end
end

function ChatAssist_GetClassCache(name)
  if(ChatAssist_ClassCache[name] ~= nil) then
    return ChatAssist_ClassCache[name];
  end
  return 0;
end

function ChatAssist_SetClassCache(name, class)
  if(name == nil or class == nil or class == 0) then
    return;
  end
  ChatAssist_ClassCache[name] = class;
end

function ChatAssist_UpdateClassCache(type)
  if(type == "PLAYER") then
    local class, eng_class = UnitClass("player");
    local classid = ChatAssist_ClassToNumber(eng_class);
    if(classid ~= 0) then
      ChatAssist_SetClassCache(UnitName("player"), classid);
    end
  elseif(type == "PARTY") then
    for i = 1, GetNumPartyMembers() do
      local class, eng_class = UnitClass("party" .. i);
      local classid = ChatAssist_ClassToNumber(eng_class);
      if(classid ~= 0) then
        ChatAssist_SetClassCache(UnitName("party" .. i), classid);
      end
    end
  elseif(type == "RAID") then
    for i = 1, GetNumRaidMembers() do
      local name, rank, subgroup, level, class, filename, zone, online = GetRaidRosterInfo(i);
      local classid = ChatAssist_ClassToNumber(filename);
      if(classid ~= 0) then
        ChatAssist_SetClassCache(name, classid);
      end
    end
  elseif(type == "GUILD") then
    for i = 1, GetNumGuildMembers(true) do
      local name, rank, rankIndex, level, class, zone, note, officernote, online, status = GetGuildRosterInfo(i);
      local classid = ChatAssist_ClassToNumber(class);
      if(classid ~= 0) then
        ChatAssist_SetClassCache(name, classid);
      end
    end
  elseif(type == "FRIEND") then
    for i = 1, GetNumFriends() do
      local name, level, class, area, connected, status = GetFriendInfo(i);
      local classid = ChatAssist_ClassToNumber(class);
      if(classid ~= 0) then
        ChatAssist_SetClassCache(name, classid);
      end
    end
  end
end

function ChatAssist_RebuildClassCache()
  ChatAssist_ClearClassCache();
  ChatAssist_UpdateClassCache("PLAYER");
  ChatAssist_UpdateClassCache("PARTY");
  ChatAssist_UpdateClassCache("RAID");
  ChatAssist_UpdateClassCache("FRIEND");
  if(IsInGuild()) then
    GuildRoster();
  end
end

function ChatAssist_ClearClassCache()
  ChatAssist_ClassCache = {};
end

function ChatAssist_GCClassCache(type)
end

function ChatAssist_ClassToNumber(class)
  if(class == nil) then
    return 0;
  end
  class = string.upper(class);
  if(class == "DRUID") then
    return 1;
  elseif(class == "HUNTER") then
    return 2;
  elseif(class == "MAGE") then
    return 3;
  elseif(class == "PALADIN") then
    return 4;
  elseif(class == "PRIEST") then
    return 5;
  elseif(class == "ROGUE") then
    return 6;
  elseif(class == "SHAMAN") then
    return 7;
  elseif(class == "WARLOCK") then
    return 8;
  elseif(class == "WARRIOR") then
    return 9;
  else
    return 0;
  end
end

function ChatAssist_BoolToString(bool)
  if(bool) then
    return "on";
  else
    return "off";
  end
end

function ChatAssist_strjoin(delimiter, list)
  local len = table.getn(list);
  if len == 0 then
    return "";
  end
  local string = list[1];
  for i = 2, len do 
    string = string .. delimiter .. list[i];
  end
  return string;
end

function ChatAssist_strsplit(delimiter, text)
  local list = {};
  local pos = 1;
  if(string.find("", delimiter, 1)) then
    table.insert(list, text);
    return list;
  end
  while 1 do
    local first, last = string.find(text, delimiter, pos);
    if first then
      table.insert(list, string.sub(text, pos, first-1));
      pos = last+1;
    else
      table.insert(list, string.sub(text, pos));
      break
    end
  end
  return list
end

function ChatAssist_isMultiByte(msg)
  local char = 0;

  for i=1, string.len(msg) do
    char = string.byte(string.sub(msg, i, i));
    if(char == nil or char > 128) then
      return true;
    end
  end
  return false;
end
