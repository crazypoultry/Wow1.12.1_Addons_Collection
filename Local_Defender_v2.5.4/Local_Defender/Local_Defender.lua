--Copyright 2006 Ryan Hamshire
--This document may be redistributed as a whole, provided it is unaltered and this copyright notice is not removed.

--table of reports filed in the last five minutes
LD_tableStart = 1
LD_tableLength = 0
LD_names = {}
LD_timestamps = {}
LD_subzones = {}
LD_locx = {}
LD_locy = {}

--table of most recent reports
LD_recentNext = 1
LD_recentName = {}
LD_recentClass = {}
LD_recentLevel = {}
LD_recentCoordx = {}
LD_recentCoordy = {}

--guild echo toggle
LD_guildEcho = false

--used in lag-tolerance
LD_timeSinceLastUpdate = 0
LD_targetChanged = 0
LD_attempts = 0

--used in warning scan
LD_warningInterval = 0

--zones exempt from reporting
LD_exemptZones = {'Everlook', 'Gadgetzan', 'Cenarion Hold', 'Booty Bay', 'Moonglade', "Light's Hope Chapel", 'Thorium Point', "Marshall's Refuge"}

--name and faction of user
LD_playerFaction = nil
LD_playerName = nil

--names of all existing zones
LD_zoneNames = {{},{}}

--number for local defense channel
LD_defenseChannel = 0

--enabled/disabled (battlegrounds)
LD_disabled = false

function LD_loadHandler()

  --register for necessary events
  this:RegisterEvent("PLAYER_TARGET_CHANGED")
  this:RegisterEvent("CHAT_MSG_CHANNEL")
  this:RegisterEvent("WORLD_MAP_UPDATE")
  this:RegisterEvent("ZONE_CHANGED_NEW_AREA")
  this:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE")

  --register slash command
  SlashCmdList["LDGuildEcho"] = LD_guildEchoHandler
  SLASH_LDGuildEcho1 = "/ldguild"

  --create space for all reports table
  for i = 1, 100 do
    LD_names[i] = ''
    LD_timestamps[i] = 0
    LD_subzones[i] = ''
    LD_locx[i] = 0
    LD_locy[i] = 0
  end

  --create space for most recent reports table
  for i = 1, 5 do
    LD_recentName[i] = ''
    LD_recentClass[i] = ''
    LD_recentLevel[i] = 0
    LD_recentCoordx[i] = 0
    LD_recentCoordy[i] = 0
  end

  --load zone names
  for continent = 1, 2 do
    LD_zoneNames[continent] = {GetMapZones(continent)}
  end

  --detect local defense channel
  local channels = {GetChatWindowChannels(DEFAULT_CHAT_FRAME:GetID())}
  local i = 1
  while channels[i] and channels[i] ~= 'LocalDefense' do
    i = i + 1
  end

  if channels[i] then
    LD_defenseChannel = floor((i + 1) / 2)
  else
    LD_defenseChannel = 0
  end
  
  --make sure we're not active in the battlegrounds
  LD_NewArea_Event()

end

function LD_updateHandler()

  --check to see if user should be warned about pvp in the area

  LD_warningInterval = LD_warningInterval + arg1

  if LD_warningInterval > 5 then

    --set up according to name and faction of player
    if not LD_playerFaction or not LD_playerName then
      LD_playerFaction = UnitFactionGroup("PLAYER")
      LD_playerName = UnitName("PLAYER")
    end

    LD_warningInterval = 0
    pvpWarning = false

    xcoord, ycoord = GetPlayerMapPosition("PLAYER")

    if xcoord > 0 then
      local i = 1
      while i <= table.getn(LD_recentName) and not LD_pvpWarning do
        if LD_recentCoordx[i] > 0 and LD_dist(xcoord * 100, ycoord * 100, LD_recentCoordx[i], LD_recentCoordy[i]) < 2.5 then
          LD_pvpWarning = true
        end
        i = i + 1
      end

      if pvpWarning then
        pvpWarning = false
        LD_WarningFrame:AddMessage("PvP Warning : Enemy Players Reported in This Area", 1, .5, 0, 1, 5)
        LD_WarningFrame:Show()
      end

    end

  end

  --check to see if a report should be prepared

  LD_timeSinceLastUpdate = LD_timeSinceLastUpdate + arg1

  if LD_targetChanged ~= 0 and LD_timeSinceLastUpdate > 0.2 then 

      local faction = UnitFactionGroup("TARGET")
      local name = UnitName("TARGET")

      --if information is available, prepare a report
      if name and faction then
        LD_targetChanged = 0
        LD_makeReport()
        LD_attempts = 0

      --otherwise wait a while and try again, but give up after a few tries
      else
        LD_attempts = LD_attempts + 1
        if LD_attempts == 5 then
          LD_targetChanged = 0
          LD_attempts = 0
        end
      end

      LD_timeSinceLastUpdate = 0

  end

end  

function LD_eventHandler()

  --respond to chat events in localDefense
  if event == "CHAT_MSG_CHANNEL" and arg8 == LD_defenseChannel then LD_Chat_Event() end

  --respond to changes in player target
  if event == "PLAYER_TARGET_CHANGED" then LD_Target_Event() end

  if event == "WORLD_MAP_UPDATE" then LD_WorldMap_Event() end

  if event == "ZONE_CHANGED_NEW_AREA" then LD_NewArea_Event() end

  if event == "CHAT_MSG_CHANNEL_NOTICE" then LD_ChatChannel_Event() end

end

function LD_ChatChannel_Event()

  local start, stop, match

  start, stop, match = string.find(arg9, '(LocalDefense)')

  if start then 

    if arg1 == 'YOU_JOINED' then

      LD_defenseChannel = arg8

    elseif arg1 == 'YOU_CHANGED' then
 
      LD_defenseChannel = arg8

    elseif arg1 == 'YOU_LEFT' then

      LD_defenseChannel = 0

    end

  end

end

function LD_Chat_Event()

  --grab name from report
  start, stop, name = string.find(arg1, '%((%a*)%)')
  if start == nil then return end

  --grab level from report
  start, stop, level = string.find(arg1, '(%d%d*%+*) ')
  if start == nil then return end

  --grab class from report
  start, stop, class = string.find(arg1, '%d%d*[%+ ]+(%a*)[, ]')
  if start == nil then return end

  --grab subzone from report
  start, stop, subzone = string.find(arg1, ', ([%a ]*[%a])')
  if start == nil then subzone = '' end

  --grab location from report
  start, stop, locx = string.find(arg1, '%[(%d%d*), %d%d*%]')
  start, stop, locy = string.find(arg1, '%[%d%d*, (%d%d*)%]')
  if start == nil then
    locx = 0
    locy = 0
  end

  --ignore and erase expired report entries
  while GetTime() - LD_timestamps[LD_tableStart] > 300 and LD_tableLength > 0 do

    LD_tableStart = LD_tableStart + 1
    if LD_tableStart > table.getn(LD_names) then LD_tableStart = LD_tableStart - table.getn(LD_names) end
    LD_tableLength = LD_tableLength - 1

  end

  --search remaining (fresh) entries for the name of the target
  local i = LD_tableStart
  local boundary = LD_tableStart + LD_tableLength
  if boundary > table.getn(LD_names) then boundary = boundary - table.getn(LD_names) end
  while i ~= boundary and LD_names[i] ~= name do
    i = i + 1
    if i > table.getn(LD_names) then i = 1 end
  end

  targetIndex = i

  if targetIndex > table.getn(LD_names) then targetIndex = targetIndex - table.getn(LD_names) end
  LD_names[targetIndex] = name

  --timestamp the report entry	
  LD_timestamps[targetIndex] = GetTime()

  --record subzone of report
  LD_subzones[targetIndex] = subzone

  --record location of report
  LD_locx[targetIndex] = locx
  LD_locy[targetIndex] = locy

  --note that total entry count has increased if necessary
  if i == boundary then LD_tableLength = LD_tableLength + 1 end
  if LD_tableLength > table.getn(LD_names) then boundary = table.getn(LD_names) end

  --if report was generated by the user, stop here
  if LD_playerName == arg2 then return end

  --search for name in most recent reports
  i = 1
  while i <= table.getn(LD_recentName) and LD_recentName[i] ~= name do 
    i = i + 1
  end

  --if not found, record as new.  otherwise, update
  if i > table.getn(LD_recentName) then
    i = LD_recentNext
    LD_recentNext = LD_recentNext + 1
    if LD_recentNext > table.getn(LD_recentName) then
      LD_recentNext = 1
    end
  end

  LD_recentName[i] = name
  LD_recentClass[i] = class
  LD_recentLevel[i] = level
  LD_recentCoordx[i] = tonumber(locx)
  LD_recentCoordy[i] = tonumber(locy)

  posx =  (LD_recentCoordx[i] / 100.0) * WorldMapDetailFrame:GetWidth()
  posy = -(LD_recentCoordy[i] / 100.0) * WorldMapDetailFrame:GetHeight()

  local currButton = getglobal("LD_MapButton" .. i)
  currButton:SetPoint("CENTER", "WorldMapDetailFrame", "TOPLEFT", posx, posy)
  currButton.playerName = name
  currButton.level = level
  currButton.class = class

end

function LD_Target_Event()

  LD_targetChanged = 1
  LD_attempts = 0

end

function LD_WorldMap_Event()

  local mapZone = nil

  if LD_zoneNames[GetCurrentMapContinent()] then 
    mapZone = LD_zoneNames[GetCurrentMapContinent()][GetCurrentMapZone()]
  end

  if mapZone and GetRealZoneText() == mapZone then
    for i = 1, 5 do
      if LD_recentCoordx[i] ~= 0 then
        local currButton = getglobal("LD_MapButton" .. i)
        currButton:Show()
      end
    end          
  else
    for i = 1, 5 do
      local currButton = getglobal("LD_MapButton" .. i)
      currButton:Hide()
    end
  end

end

function LD_NewArea_Event()

  --disable for battlegrounds
  local zoneName = GetRealZoneText()

  if zoneName and (zoneName == 'Warsong Gulch' or zoneName == 'Arathi Basin' or zoneName == 'Alterac Valley') then
    LD_disabled = true
    DEFAULT_CHAT_FRAME:AddMessage('Local Defender disabled for battlegrounds play.', 1, .5, 0)
  else
    if LD_disabled then 
      DEFAULT_CHAT_FRAME:AddMessage('Local Defender re-enabled.', 1, .5, 0)
    end
    LD_disabled = false
  end

  for i = 1, 5 do
    LD_recentCoordx[i] = 0
    local currButton = getglobal("LD_MapButton" .. i)
    currButton:Hide()
  end

end

function LD_makeReport()

  if LD_disabled then return end

  --avoid reporting in certain sub zones
  local subzone = GetSubZoneText()

  for i = 1, table.getn(LD_exemptZones) do
    if subzone == LD_exemptZones[i] then return end
  end

  --collect information about target
  local name = UnitName("target")
  local class = UnitClass("target")
  local isPlayer = UnitIsPlayer("target")
  local level = UnitLevel("target")
  local faction = UnitFactionGroup("TARGET")
  local canAttack = UnitCanAttack("PLAYER", "TARGET")
  xcoord, ycoord = GetPlayerMapPosition("PLAYER")

  --avoid reporting certain targets
  if not isPlayer or faction == LD_playerFaction or not canAttack or (xcoord == 0 and subzone == '') then return end

  --ignore and erase expired report entries
  while GetTime() - LD_timestamps[LD_tableStart] > 600 and LD_tableLength > 0 do

    LD_tableStart = LD_tableStart + 1
    if LD_tableStart > table.getn(LD_names) then LD_tableStart = LD_tableStart - table.getn(LD_names) end
    LD_tableLength = LD_tableLength - 1

  end

  --search remaining (fresh) entries for the name of the target
  local i = LD_tableStart
  local boundary = LD_tableStart + LD_tableLength
  if boundary > table.getn(LD_names) then boundary = boundary - table.getn(LD_names) end
  while i ~= boundary and LD_names[i] ~= name do
    i = i + 1
    if i > table.getn(LD_names) then i = 1 end
  end

  --compute distance from last sighting location
  local distance = -1
  if xcoord > 0 and i ~= boundary then 
    distance = LD_dist(100 * xcoord, 100 * ycoord, LD_locx[i], LD_locy[i])
  end

  --if no match was found or target has moved, report the target
  if i == boundary or (xcoord == 0 and subzone ~= LD_subzones[i]) or distance > 3.5 then

    --adjust for unknown level
    if level == -1 then
      level = UnitLevel("player") + 10 .. '+'
    end

    --adjust for unknown coordinates
    local location
    if xcoord ~= 0 then
      xcoord = floor(xcoord * 100)
      ycoord = floor(ycoord * 100)
      location = ' [' .. xcoord .. ', ' .. ycoord .. ']'
    else
      location = ''
    end

    --adjust for unknown subzone
    if subzone and subzone ~= '' then 
      subzone = ', ' .. subzone
    else
      subzone = ' at'
    end

    --send report message
    local report = level .. ' ' .. class .. subzone .. location .. '.  (' .. name .. ')'
    SendChatMessage(report, "CHANNEL", nil, LD_defenseChannel)
    if LD_guildEcho then
      SendChatMessage(GetRealZoneText() .. ' : ' .. report, "GUILD", nil)
    end
    
  end

end

function LD_showMapTooltip()

  text = this.level .. ' ' .. this.class .. ' (' .. this.playerName .. ')'

  WorldMapTooltip:SetOwner(this, "ANCHOR_LEFT")
  WorldMapTooltip:SetText(text, 1.0, 0.82, 0.0, 1,1);
  WorldMapTooltip:Show();  

end

function LD_guildEchoHandler()

  if LD_guildEcho then
    LD_guildEcho = false
    DEFAULT_CHAT_FRAME:AddMessage("Local Defender guild echo disabled.", 1, .5, 0)
  else
    LD_guildEcho = true
    DEFAULT_CHAT_FRAME:AddMessage("Local Defender guild echo enabled.", 1, .5, 0)
  end

end

function LD_dist(x1, y1, x2, y2)

  return math.sqrt(math.abs(x1 - x2) + math.abs(y1 - y2))

end

function say(text)

  DEFAULT_CHAT_FRAME:AddMessage(text)

end