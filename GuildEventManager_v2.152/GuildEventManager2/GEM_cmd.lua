--[[
  Guild Event Manager by Kiki (European Cho'gall) (Alliance)
    CMD module
]]

--------------- Saved variables ---------------

--------------- Shared variables ---------------

--------------- Local variables ---------------
GEM_Saved_ScheduledTaskInterval = GEM_COM_ScheduledTaskInterval;

--------------- Hooked functions ---------------

--------------- Internal functions ---------------

local function _GEM_CMD_ListIgnoredEvents()
  GEM_ChatPrint("List of ignored events :");
  for id,val in GEM_Events.realms[GEM_Realm].ignore
  do
    local event = GEM_Events.realms[GEM_Realm].events[id];
    if(event ~= nil)
    then
      GEM_ChatPrint(" - EventId '"..id.."' by '"..event.leader.."' at '"..event.ev_place.."' with comment '"..event.ev_comment.."'");
    end
  end
  GEM_ChatPrint("End of List");
end

local function _GEM_CMD_UnignoreEvent(eventId)
  GEM_Events.realms[GEM_Realm].ignore[eventId] = nil;
  GEM_ChatPrint("EventID '"..eventId.."' unignored");
  GEM_NotifyGUI(GEM_NOTIFY_EVENT_UPDATE,eventId);
end

local function _GEM_CMD_ListIgnoredPlayers()
  local banned = GEM_Defaults_Banned[GEM_Realm];
  GEM_ChatPrint("List of banned players :");
  for name in GEM_Events.realms[GEM_Realm].ignore_players
  do
    if(banned and banned[name])
    then
      GEM_ChatPrint(" - "..name.." (default ban)");
    else
      GEM_ChatPrint(" - "..name);
    end
  end
  GEM_ChatPrint("End of List");
end

local function _GEM_CMD_UnignorePlayer(pl_name)
  local banned = GEM_Defaults_Banned[GEM_Realm];
  if(banned and banned[pl_name])
  then
    GEM_ChatPrint("Player '"..pl_name.."' is 'forced banned' from the GEM_defaults.lua file. You must remove the name from the file before using the '/gem unban' command !");
  else
    GEM_Events.realms[GEM_Realm].ignore_players[pl_name] = nil;
    GEM_ChatPrint("Player '"..pl_name.."' unbanned");
  end
end

--------------- Exported functions ---------------

function GEM_CMD_Help()
  GEM_ChatPrint("/gem toggle : Shows or hides the GUI (you can also assign a key in your shortcuts)");
  GEM_ChatPrint("/gem join : Rejoin GEM channels, if auto-join failed");
  GEM_ChatPrint("/gem channels : Lists current GEM channels");
  GEM_ChatPrint("/gem addchan <Name> [<Password>] : Adds a new GEM channel with password (optional)");
  GEM_ChatPrint("/gem delchan <Name> : Removes a current GEM channel");
  GEM_ChatPrint("/gem setdefchan <Name> : Changes the default channel for 'New events'");
  GEM_ChatPrint("/gem setalias <ChannelName> <Alias> <SlashCmd> : Sets alias/slashcmd for this channel");
  GEM_ChatPrint("/gem delalias <ChannelName> : Removes alias and slashcmd for this channel");
  GEM_ChatPrint("/gem delchar <CharName> : Removes one of your Characters from the dropdown list in subscribe and new event tabs");
  GEM_ChatPrint("--- ADVANCED COMMANDS ---");
  GEM_ChatPrint("/gem offset <hours> : Forces an offset from the server (in hours, can be negative)");
  GEM_ChatPrint("/gem ignored : List all ignored events");
  GEM_ChatPrint("/gem unignore : Un ignore an event");
  GEM_ChatPrint("/gem banned : List all ignored players");
  GEM_ChatPrint("/gem unban : Un ban a player");
  GEM_ChatPrint("/gem scale <scale value> : Sets the GEM windows scale value");
  GEM_ChatPrint("/gem events : Displays all incoming events");
  GEM_ChatPrint("/gem archive <EventID> : Archives an expired Event");
  GEM_ChatPrint("--- Debug commands ---");
  GEM_ChatPrint("/gem debug <1/2/0> : Sets or not debug mode (2=debug+log)");
  GEM_ChatPrint("/gem pause <on/off> : Quick dirty hack to *pause* GEM");
end

function GEM_CMD_Command(cmd,param)
  if(cmd == "toggle")
  then
    GEM_Toggle();
    return true;

  elseif(cmd == "pause")
  then
    if(param == "on")
    then
      GEM_Paused = true;
      GEM_ChatPrint("GEM is paused");
      -- Temp leave channels
      for name,chantab in GEM_COM_Channels
      do
        GEM_COM_LeaveChannel(name);
        GEM_COM_PurgeQueueMessageForChannel(name);
      end
      GEMMinimapButtonText:SetText("P");
      GEM_Saved_ScheduledTaskInterval = GEM_COM_ScheduledTaskInterval;
      GEM_COM_ScheduledTaskInterval = 60;
    elseif(param == "off")
    then
      GEM_COM_ScheduledTaskInterval = GEM_Saved_ScheduledTaskInterval;
      GEM_Paused = false;
      GEM_ChatPrint("GEM is no longer paused");
      GEMMinimapButtonText:SetText("");
      GEM_InitChannels(false);
    else
      GEM_ChatPrint("Unknown param to pause command: '"..param.."'");
    end
    return true;

  elseif(cmd == "ignored")
  then
    _GEM_CMD_ListIgnoredEvents();
    return true;
  elseif(cmd == "unignore")
  then
    if(param == "")
    then
      GEM_ChatPrint("Missing parameter for 'unignore' option");
      return true;
    end
    if(GEM_Events.realms[GEM_Realm].events[param] == nil)
    then
      GEM_ChatPrint("Unknown EventID '"..param.."'");
      return true;
    end
    if(GEM_Events.realms[GEM_Realm].ignore[param] == nil)
    then
      GEM_ChatPrint("EventID '"..param.."' not currently ignored");
      return true;
    end
    _GEM_CMD_UnignoreEvent(param);
    return true;

  elseif(cmd == "banned")
  then
    _GEM_CMD_ListIgnoredPlayers();
    return true;
  elseif(cmd == "unban")
  then
    if(param == "")
    then
      GEM_ChatPrint("Missing parameter for 'unban' option");
      return true;
    end
    if(GEM_Events.realms[GEM_Realm].ignore_players[param] == nil)
    then
      GEM_ChatPrint("Player '"..param.."' not currently banned");
      return true;
    end
    _GEM_CMD_UnignorePlayer(param);
    return true;

  elseif(cmd == "debug")
  then
    if(param == "1")
    then
      GEM_DBG_SetDebugMode(1,true);
      GEM_ChatPrint("Debug mode ON");
    elseif(param == "2")
    then
      GEM_DBG_SetDebugMode(2,true);
      GEM_ChatPrint("Debug mode ON WITH LOG");
    else
      GEM_DBG_SetDebugMode(0,true);
      GEM_ChatPrint("Debug mode OFF");
    end
    return true;

  elseif(cmd == "join")
  then
    GEM_InitChannels(false);
    return true;
  elseif(cmd == "channels")
  then
    GEM_ChatPrint("GEM channels list : <Name> : <Password> : <Alias> : <SlashCmd>");
    for channame, tab in GEM_COM_Channels
    do
      local def = "";
      if(channame == GEM_DefaultSendChannel)
      then
        def = "(Default channel for 'New events')";
      end
      local pwd = tab.password;
      if(pwd == nil or pwd == "")
      then
        pwd = "(no password)";
      end
      local alias = tab.alias;
      if(alias == nil or alias == "")
      then
        alias = "(no alias)";
      end
      local slash = tab.slash;
      if(slash == nil or slash == "")
      then
        slash = "(no slash)";
      end
      GEM_ChatPrint(" - "..channame.." "..def.." : "..pwd.." : "..alias.." : "..slash);
    end
    GEM_ChatPrint("End of listing");
    return true;

  elseif(cmd == "addchan")
  then
    if(not param or param == "")
    then
      GEM_ChatPrint("Need to specify a channel name");
      return true;
    end
    local _,_,chan,pwd = string.find(param,"([^%s]+)%s*(.*)");
    if(not chan)
    then
      GEM_ChatPrint("Need to specify a channel name");
      return true;
    end
    GEMOptions_AddChannel(chan,pwd,"","");
    GEM_ChatPrint("Channel "..chan.." added !");
    return true;

  elseif(cmd == "delchan")
  then
    if(not param or param == "")
    then
      GEM_ChatPrint("Need to specify a channel name");
      return true;
    end
    if(not GEM_COM_Channels[param])
    then
      GEM_ChatPrint("Unknown GEM channel "..param);
      return true;
    end
    GEMOptions_RemoveChannel(param);
    GEM_ChatPrint("Channel "..param.." removed !");
    return true;

  elseif(cmd == "setdefchan")
  then
    if(not param or param == "")
    then
      GEM_ChatPrint("Need to specify a channel name");
      return true;
    end
    if(not GEM_COM_Channels[param])
    then
      GEM_ChatPrint("Unknown GEM channel "..param);
      return true;
    end
    GEM_DefaultSendChannel = param;
    GEM_ChatPrint("Channel "..param.." set as default one for New events !");
    return true;

  elseif(cmd == "setalias")
  then
    if(not param or param == "")
    then
      GEM_ChatPrint("Need to specify a channel");
      return true;
    end
    local _,_,chan,alias,slash = string.find(param,"([^%s]+)%s+([^%s]+)%s+([^%s]+)");
    if(chan == nil or alias == nil or slash == nil or chan == "" or alias == "" or slash == "")
    then
      GEM_ChatPrint("Need to specify a channel, an alias and a slashcmd");
      return true;
    end
    if(not GEM_COM_Channels[chan])
    then
      GEM_ChatPrint("Unknown GEM channel "..chan);
      return true;
    end
    for i,chantab in GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].channels
    do
      if(chantab.name == chan)
      then
        chantab.alias = alias;
        chantab.slash = slash;
        break;
      end
    end
    GEM_COM_Channels[chan].alias = alias;
    GEM_COM_Channels[chan].slash = slash;
    GEM_COM_AliasChannel(chan,GEM_COM_Channels[chan].alias,GEM_COM_Channels[chan].slash);
    GEM_ChatPrint("Alias and SlashCmd for channel "..chan.." set to : "..alias.." : "..slash);
    return true;

  elseif(cmd == "delalias")
  then
    if(not param or param == "")
    then
      GEM_ChatPrint("Need to specify a channel");
      return true;
    end
    if(not GEM_COM_Channels[param])
    then
      GEM_ChatPrint("Unknown GEM channel "..param);
      return true;
    end
    for i,chantab in GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].channels
    do
      if(chantab.name == param)
      then
        chantab.alias = "";
        chantab.slash = "";
        break;
      end
    end
    GEM_COM_UnAliasChannel(param,GEM_COM_Channels[param].alias,GEM_COM_Channels[param].slash);
    GEM_COM_Channels[param].alias = "";
    GEM_COM_Channels[param].slash = "";
    GEM_ChatPrint("Removed Alias and SlashCmd for channel "..param);
    return true;

  elseif(cmd == "offset")
  then
    local hours = tonumber(param);
    if(hours == nil)
    then
      GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].ForceHourOffset = nil;
      GEM_ChatPrint("Removing Forced hours offset !");
    else
      if(hours > 24 or hours < -24)
      then
        GEM_ChatPrint("Hour offset value must be <24 and >-24");
      end
      GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].ForceHourOffset = hours;
      GEM_ChatPrint("Forced hour offset to "..hours.." hours !");
    end
    GEM_ServerOffset = 666;
    GEM_ComputeServerOffset();
    GEMNew_Reset();
    return true;

  elseif(cmd == "scale")
  then
    local value = tonumber(param);
    if(value == nil)
    then
      GEM_ChatPrint("Incorrect scale value (must be a number) : "..tostring(param));
    else
      GEM_Events.scale = value;
      GEM_ChatPrint("Scale value set to "..value);
    end
    return true;

  elseif(cmd == "events")
  then
    GEM_ChatPrint("List of incoming events :");
    for id,event in GEM_Events.realms[GEM_Realm].events
    do
      GEM_ChatPrint(" - EventId '"..id.."' (channel '"..event.channel.."') by '"..event.leader.."' at '"..event.ev_place.."' "..GEM_ConvertDateFormat(date(GEM_Events.DateFormat,event.ev_date + GEM_ComputeHourOffset())));
    end
    GEM_ChatPrint("End of List");
    return true;

  elseif(cmd == "archive")
  then
    local event = GEM_Events.realms[GEM_Realm].events[param];
    if(event == nil)
    then
      GEM_ChatPrint("Unknown EventID : "..tostring(param));
      return true;
    end
    local tim = time();
    if(event.ev_date == nil)
    then
      return true;
    end
    --if(event.ev_date < (tim-GEM_GetOffsetTime(param)))
    --then
      GEM_Events.realms[GEM_Realm].archived[param] = GEM_Events.realms[GEM_Realm].events[param];
      GEM_ChatPrint("EventID "..param.." archived !");
    --else
      --GEM_ChatPrint("Cannot archive an incoming event");
    --end
    return true;

  elseif(cmd == "delchar")
  then
    if(GEM_Events.realms[GEM_Realm].my_names[param] == nil)
    then
      GEM_ChatPrint("Unknown character : "..tostring(param));
      return true;
    end
    if(param == GEM_PlayerName)
    then
      GEM_ChatPrint("Cannot remove current character !");
      return true;
    end
    GEM_Events.realms[GEM_Realm].my_names[param] = nil;
    GEM_ChatPrint("Character '"..param.."' removed !");
    return true;
  end
  return false;
end
