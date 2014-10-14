--
-- CorpseInfo testversion13
--
-- by Bastian Pflieger <wb@illogical.de>
--
-- Thanks to Frosty for his help in improving this thing!
--
-- Last update: August 23, 2006
--

local name;
local tipChecked = false;

local WorldFrameMouseDownOrg;
local ChatFrame_OnEvent_Org;
local queryTime = GetTime();

local whoCache;
local TIMEOUT = 60; --how long to save corpse info, in seconds.

local ignoreList;

local GameTooltipOnTooltipClear;
local FriendsFrame_OnEvent_Org;

function CorpseInfo_OnLoad()

  GameTooltipOnTooltipClear = GameTooltip:GetScript("OnTooltipCleared");
  GameTooltip:SetScript("OnTooltipCleared",CorpseInfo_ClearTip);

  this:RegisterEvent("VARIABLES_LOADED");
  this:RegisterEvent("CHAT_MSG_SYSTEM");
  this:RegisterEvent("IGNORELIST_UPDATE");

  CorpseInfo_IsAutoMode = true;
  CorpseInfo_IsSpamMode = false;

  CorpseInfo_UpdateIgnoreList();

  WorldFrameMouseDownOrg = WorldFrame:GetScript("OnMouseDown");
  WorldFrame:SetScript("OnMouseDown", CorpseInfo_OnMouseDown);

  ChatFrame_OnEvent_Org = ChatFrame_OnEvent;
  ChatFrame_OnEvent = CorpseInfo_ChatFrame_OnEvent;

  FriendsFrame_OnEvent_Org = FriendsFrame_OnEvent;
  FriendsFrame_OnEvent = CorpseInfo_FriendsFrame_OnEvent;

  SlashCmdList["CORPSEINFO"] = CorpseInfo_ChatCommand;
  SLASH_CORPSEINFO1 = "/corpseinfo";

  CorpseInfo_Message(CORPSEINFO_VERSION .. CORPSEINFO_LOADED);
end

-- suppress of poping up who dialog if to many results from /who command
function CorpseInfo_FriendsFrame_OnEvent()
  if not (event == "WHO_LIST_UPDATE" and (GetTime() - queryTime) < 3) then
    FriendsFrame_OnEvent_Org();
  end
end

-- suppress any /who chat responses, within three seconds after last /who query initiated by this addon.
function CorpseInfo_ChatFrame_OnEvent(event)
  if not ( event == "CHAT_MSG_SYSTEM"
           and not CorpseInfo_IsSpamMode
           and (GetTime() - queryTime) < 3
           and (string.find(arg1, CORPSEINFO_CHATPATTERN1) or string.find(arg1, CORPSEINFO_CHATPATTERN2)) ) then
    ChatFrame_OnEvent_Org(event);
  end
end

-- enables check on click
function CorpseInfo_OnMouseDown()
  if WorldFrameMouseDownOrg then
    WorldFrameMouseDownOrg();
  end
  if not CorpseInfo_IsAutoMode and arg1 == "LeftButton" and CorspeInfo_IsPossibleCadaverTooltip() then
    CorpseInfo_CheckCadaver(true);
  end
end

function CorpseInfo_ChatCommand(msg)
  msg = string.lower(msg);
  if msg == "mode" then
    CorpseInfo_Setup(not CorpseInfo_IsAutoMode);
  elseif msg == "chat" then
    CorpseInfo_IsSpamMode = not CorpseInfo_IsSpamMode;
  else
    CorpseInfo_Message(CORPSEINFO_CHATHELP1);
    CorpseInfo_Message(CORPSEINFO_CHATHELP2);
  end
  CorpseInfo_Message(CORPSEINFO_STATUS1[CorpseInfo_IsAutoMode]);
  CorpseInfo_Message(CORPSEINFO_STATUS2[CorpseInfo_IsSpamMode]);
end

function CorpseInfo_OnEvent(event)
  if event == "CHAT_MSG_SYSTEM" and name and string.find(arg1, CORPSEINFO_CHATPATTERN2) then
    CorpseInfo_Catch(arg1);
  elseif event == "IGNORELIST_UPDATE" then
    CorpseInfo_UpdateIgnoreList();
  elseif event == "VARIABLES_LOADED" then
    CorpseInfo_RegisterMyAddons();
    CorpseInfo_Setup(CorpseInfo_IsAutoMode);
  end
end

function CorpseInfo_ClearTip()
  tipChecked = false;
  GameTooltipOnTooltipClear();
end


function CorpseInfo_Catch(text)
  if name and CorpseInfo_IsCadaverOf(name) and GameTooltip:NumLines() == 1 then
    for i = 1, GetNumWhoResults() do
      local whoname, guild, level, race, class = GetWhoInfo(i);
      if whoname == name then
        whoCache[name] = { level = level, guild = guild, race = race, class = class, timestamp = GetTime() + TIMEOUT };
      end
    end
    if not whoCache[name] then
      whoCache[name] = { offline = true, timestamp = GetTime() + TIMEOUT };
    end
    CorpseInfo_UpdateTip();
    name = nil;
  end
end

function CorpseInfo_UpdateTip()
  if GameTooltip:NumLines() == 1 then
    GameTooltipTextLeft1:SetTextColor(1.0, 1.0, 0.61); -- light yellow
    if whoCache[name].offline then
      GameTooltip:AddLine(CORPSEINFO_OFFLINE[UnitFactionGroup("player")]);
      GameTooltip:SetHeight(GameTooltip:GetHeight() + 14);
    else
      GameTooltip:AddLine(string.format(CORPSEINFO_RACECLASS, whoCache[name].race, whoCache[name].class));
      GameTooltip:AddLine(string.format(UNIT_LEVEL_TEMPLATE, whoCache[name].level), 1.0, 1.0, 1.0);
      if string.len(whoCache[name].guild) > 0 then
        GameTooltip:AddLine(string.format(CORPSEINFO_GUILD, whoCache[name].guild));
        GameTooltip:SetHeight(GameTooltip:GetHeight() + 14);
      end
      GameTooltip:AddLine(CORPSEINFO_ONLINE);
      GameTooltip:SetHeight(GameTooltip:GetHeight() + 14 * 3);
    end
    if ignoreList[name] then
      GameTooltip:AddLine(CORSEINFO_IGNORED);
      GameTooltip:SetHeight(GameTooltip:GetHeight() + 14);
    end
    CorpseInfo_UpdateKoSInfo();
    CorpseInfo_UpdateSKInfo();
    CorpseInfo_UpdateCTPlayerNotes(CT_PlayerNotes);
    CorpseInfo_UpdateCTPlayerNotes(CT_IgnoreNotes);
    CorpseInfo_UpdateCTPlayerNotes(CT_GuildNotes);
    CorpseInfo_UpdateHoloFriendNotes(HOLOFRIENDS_LIST);
    CorpseInfo_UpdateHoloFriendNotes(HOLOIGNORE_LIST);
    CorpseInfo_AdjustTipWidth();
  end
end

function CorpseInfo_AdjustTipWidth()
  for i = 1, GameTooltip:NumLines() do
    local textWidth = getglobal("GameTooltipTextLeft" .. i):GetStringWidth() + 20;
    if textWidth > GameTooltip:GetWidth() then
      GameTooltip:SetWidth(textWidth);
    end
  end
end

function CorpseInfo_OnUpdate()
  if CorspeInfo_IsPossibleCadaverTooltip() and not tipChecked then
    CorpseInfo_CheckCadaver(CorpseInfo_IsAutoMode);
    tipChecked = true;
  end
  if not CorpseInfo_IsAutoMode and (GetTime() - queryTime) > TIMEOUT then
    this:Hide();
  end
end

function CorspeInfo_IsPossibleCadaverTooltip()
  return GameTooltip:IsVisible() and GameTooltipTextLeft1:GetText();
end

function CorpseInfo_CheckCadaver(submitWho)
  _, _, name = string.find(GameTooltipTextLeft1:GetText(), CORPSEINFO_CORPSEPATTERN);

  CorpseInfo_CacheRemoveOlderEntries();

  if whoCache[name] then
    CorpseInfo_UpdateTip();
  elseif name and submitWho then
    SendWho("n-" .. name);
    queryTime = GetTime();
    CorpseInfoFrame:Show();
  end
end

function CorpseInfo_IsCadaverOf(name)
  -- Handles the french "d'<name>" or "de <name>" case.
  LocalizedText:SetText(string.format(CORPSE_TOOLTIP, name));
  return GameTooltipTextLeft1:GetText() and GameTooltipTextLeft1:GetText() == LocalizedText:GetText();
end

function CorpseInfo_CacheRemoveOlderEntries()
  for name, whoinfo in pairs(whoCache) do
    if GetTime() > whoinfo.timestamp then
      whoCache[name] = nil;
    end
  end
end

function CorpseInfo_Message(msg)
  ChatFrame1:AddMessage(string.format(CORPSEINFO_CHATMESSAGE, msg));
end

function CorpseInfo_Setup(IsAutoMode)
  CorpseInfo_IsAutoMode = IsAutoMode;
  if CorpseInfo_IsAutoMode then
    CorpseInfoFrame:Show();
  else
    CorpseInfoFrame:Hide();
  end
  whoCache = {};
end

function CorpseInfo_UpdateIgnoreList()
  ignoreList = {};
  for i = 1, GetNumIgnores() do
    ignoreList[GetIgnoreName(i)] = true;
  end
end



--
--
-- Helper functions, misc addons support.
--
--

-- MyAddons 2.0 support
function CorpseInfo_RegisterMyAddons()
  if myAddOnsFrame_Register then
    myAddOnsFrame_Register( {
      name = CORPSEINFO_NAME,
      description = CORPSEINFO_MYADDONS_DESCRIPTION,
      version = CORPSEINFO_VERSION,
      releaseDate = CORPSEINFO_MYADDONS_RELEASEDATE,
      author = "wbb",
      email = "<wb@illogical.de>",
      website = "http://www.illogical.de",
      category = MYADDONS_CATEGORY_OTHERS,
      frame = "CorpseInfoFrame"
    }, {
      CORPSEINFO_CHATHELP1 .. "\n" ..
      CORPSEINFO_CHATHELP2
    } );
  end
end

-- Get notes from "HoloFriends"
function CorpseInfo_UpdateHoloFriendNotes(playerList)
  if playerList and playerList[GetRealmName()] and playerList[GetRealmName()][UnitName("player")] then
    for _, playerData in ipairs(playerList[GetRealmName()][UnitName("player")]) do
      if playerData.name == name and playerData.comment then
        CorpseInfo_AddNote(playerData.comment);
      end
    end
  end
end

-- Get notes from "ct_PlayerNotes"
function CorpseInfo_UpdateCTPlayerNotes(playerNotes)
  if playerNotes and playerNotes[name] then
    CorpseInfo_AddNote(playerNotes[name]);
  end
end

-- Get class info from "SKMap"
function CorpseInfo_UpdateSKInfo()
  if SKM_Data and _SKM then
    local playerData = SKM_Data[GetRealmName()][UnitName("player")].EnemyHistory[name];
    if playerData and whoCache[name].offline then
      local faction;
      if playerData[_SKM._race] >= 5 then -- not nice ;)
        faction = "Horde";
      else
        faction = "Alliance";
      end
      CorpseInfo_AddPlayerData(SkM_GetRaceText(playerData[_SKM._race]),
                               SkM_GetClassText(playerData[_SKM._class]),
                               playerData[_SKM._level],
                               playerData[_SKM._guild],
                               faction,
                               HIGHLIGHT_FONT_COLOR_CODE .. SKMAP_COLUMN_LASTSEEN .. " " .. playerData[_SKM._lastView]);
      CorpseInfo_AddNote(playerData[_SKM._playerNote]);
    end
  end
end

-- Get class info from "Opium"
function CorpseInfo_UpdateKoSInfo()
  -- no guild support atm
  if Opium_TimeToString and OpiumData then
    -- Add KoS Player data to the tooltip
    local playerData = OpiumData["playerLinks"][GetRealmName()][string.lower(name)];
    local playerNote = OpiumData["kosPlayer"][GetRealmName()][string.lower(name)];
    if playerData and whoCache[name].offline then
      CorpseInfo_AddPlayerData(OPIUM_RACEINDEX[playerData[OPIUM_INDEX_RACE]],
                               OPIUM_CLASSINDEX[playerData[OPIUM_INDEX_CLASS]],
                               playerData[OPIUM_INDEX_LEVEL],
                               playerData[OPIUM_INDEX_GUILD],
                               OPIUM_FACTIONINDEX[playerData[OPIUM_INDEX_FACTION]],
                               string.format(CORPSEINFO_KOS_LASTSEEN, Opium_TimeToString(time() - OPIUM_TIMEOFFSET - playerData[OPIUM_INDEX_LASTSEEN])));
    end
    if playerNote then
      CorpseInfo_AddNote(playerNote[OPIUM_INDEX_REASON]);
    end
  end
end

function CorpseInfo_AddPlayerData(race, class, level, guild, faction, lastseen)
  GameTooltip:AddLine(string.format(CORPSEINFO_RACECLASS, race, class));
  if level == -1 then
    GameTooltip:AddLine(string.format(TOOLTIP_UNIT_LEVEL, "??"), 1.0, 1.0, 1.0);
  else
    GameTooltip:AddLine(string.format(TOOLTIP_UNIT_LEVEL, level), 1.0, 1.0, 1.0);
  end
  if UnitFactionGroup("player") == faction then
    GameTooltipTextLeft2:SetText(CORPSEINFO_OFFLINE2);
  else
    GameTooltipTextLeft2:SetText(CORPSEINFO_FACTION[UnitFactionGroup("player")]);
  end
  GameTooltip:AddLine(lastseen);
  if guild and string.len(guild) > 0 then
    GameTooltip:AddLine(string.format(CORPSEINFO_GUILD, guild));
    GameTooltip:SetHeight(GameTooltip:GetHeight() + 14);
  end
  GameTooltip:SetHeight(GameTooltip:GetHeight() + 14 * 3);
end

function CorpseInfo_AddNote(note)
  if note then
    GameTooltip:AddLine(string.format(CORPSEINFO_KOS_NOTE, note));
    GameTooltip:SetHeight(GameTooltip:GetHeight() + 14);
  end
end