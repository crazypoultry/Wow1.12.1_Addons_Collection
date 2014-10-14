--[[
Gibberish: Common communications structure for World of Warcraft add-ons.

This add-on is a combination of works done by others.
  - ChannelCast
  - Sky
  - Ephemeral

** This is not a released version of Gibberish.  You may use it in your add-on
if you wish, but testing and support for this setup is limited.  Use at your
own risk.

** If you do use this in your add-on, please report any bugs or update
suggestions here: http://www.myquests.org

--]]






Gibberish = {};

Gibberish.PROTOCOL_VERSION = "01";

Gibberish.ChannelName      = "Gibberish";   -- channel name to join  
Gibberish.ChannelNumber    = 0;             -- channel number

Gibberish.RegisteredEvents = {};            -- registered callbacks for global events
Gibberish.ScheduledCalls   = dict.create(); -- scheduled callbacks for update events
Gibberish.EventDelta       = 0;             -- current delta for global update events

Gibberish.Callbacks = {};

Gibberish.BufferedTransmissions = {};
Gibberish.ReceivedTransmissions = {};

Gibberish.MessageId             = 0;        -- outgoing message id number

Gibberish.lastChannelNotificationTime = 0;
Gibberish.InitDelay = 7;

Gibberish.UserList = {};


Gibberish.PROTOCOL_INTERVAL = 1;
Gibberish.PROTOCOL_THROTTLE = 30;
Gibberish.PROTOCOL_CHUNKLENGTH = 200;

Gibberish.MSGTYPE_TEXT = 1;
Gibberish.MSGTYPE_TABLE = 2;






Gibberish.lastPlayer = "";
Gibberish.lastMessage = "";







--[[ ********************************************************************* --]]
-- Called when the AddOn is loaded.
--[[ ********************************************************************* --]]
function Gibberish.OnGlobalLoad()
  -- Initialize the data first, because Gibberish_Print() references the
  -- debugFlag member.
  --ChannelCast_InitData()

  Gibberish.RegisterForEvent("CHAT_MSG_CHANNEL", Gibberish.Event_ChatMsgChannel);
  Gibberish.RegisterForEvent("CHAT_MSG_CHANNEL_NOTICE", Gibberish.Event_ChatMsgChannelNotice);
  
  Gibberish.ScheduleForCall(Gibberish.InitializeChannel, {}, Gibberish.InitDelay, 1);
end

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
function Gibberish.InitializeChannel()
  --Gibberish_Print("Attempting to initialize chat channel");
  
  -- determine if enough time has passed to create our own channel.
  local lastNotificationTime = 0;
  if (Gibberish.lastChannelNotificationTime > 0) then
    lastNotificationTime = time() - Gibberish.lastChannelNotificationTime;
    if (lastNotificationTime <= 5) then
      --Gibberish_Print("Pausing join attempt, will attempt again in 1 second");
      Gibberish.ScheduleForCall(Gibberish.InitializeChannel, {}, 1, 1);
      return;
    end

    --Gibberish_Print("Auto joining Gibberish channel");
    
    JoinChannelByName(Gibberish.ChannelName);
    Gibberish.ChannelNumber = GetChannelName(Gibberish.ChannelName);
  end

end

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
function Gibberish.Event_ChatMsgChannelNotice()
  Gibberish.lastChannelNotificationTime = time();
end

--[[ ********************************************************************* --]]
--    arg1 - chat message 
--    arg2 - author 
--    arg3 - language 
--    arg4 - channel name with number ex: "5. General - Stormwind City" 
--           * zone is always current zone even if not the same as the channel
--             name.
--    arg5 - target 
--           * second player name when two users are passed for a
--             CHANNEL_NOTICE_USER (E.G. x kicked y).
--    arg6 - AFK/DND/GM "CHAT_FLAG_"..arg6 flags 
--    arg7 - zone ID used for generic system channels (General, Trade,
--           LookingForGroup and LocalDefense) 
--           * not used for custom channels or if you joined an Out-Of-Zone
--             channel ex: "General - Stormwind City" 
--    arg8 - channel number 
--    arg9 - channel name without number 
--[[ ********************************************************************* --]]
function Gibberish.Event_ChatMsgChannel()
  local channelNumber = arg8;
  local chatMessage = arg1;
  local messageAuthor = arg2;
  local playerName = UnitName("player");
  
  -- is the channel number correct for this object?
  if (channelNumber ~= Gibberish.ChannelNumber) then
    return;
  end
  
  -- no player name?
  if (playerName == nil) then
    return;
  end

  -- is this a Gibberish message?
  local markIndex, _, versionNumber = string.find(chatMessage, "<G(%d-)>");
  if (markIndex == nil or markIndex ~= 1) then
    return;
  end

  -- is the message the right version?
  if (versionNumber ~= Gibberish.PROTOCOL_VERSION) then
    return;
  end
  
  -- author is the player?
  --if (playerName == messageAuthor) then
  --  return;
  --end
  
  -- add this user to the known user list
  Gibberish.AddUser(messageAuthor)

  -- process the message.
  Gibberish.Receive(messageAuthor, chatMessage)
end

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
GibberishOverride_ChatFrame_OnEvent = ChatFrame_OnEvent;
function ChatFrame_OnEvent(event)
  if (event == "CHAT_MSG_WHISPER" or event == "CHAT_MSG_WHISPER_INFORM") then
    if (strfind(arg1, "^<G" .. Gibberish.PROTOCOL_VERSION .. ">", 1)) then
      if (event == "CHAT_MSG_WHISPER_INFORM") then
        return;
      end

      Gibberish.Receive(arg2, arg1);
      
      return;
    end
  end

  -- pass comm traffic through to the default handler
  GibberishOverride_ChatFrame_OnEvent(event);
end

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
function Gibberish.RegisterCallback(callback)
  table.insert(Gibberish.Callbacks, callback);
end

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
function Gibberish.Receive(inMessageAuthor, inMessage)
  -- fix a problem where we receive the same message twice
  if (inMessage == Gibberish.lastMessage and inMessageAuthor == Gibberish.lastPlayer) then
    return;
  end
  
  local _, _, commVersion, dtype, datagramid, sequenceNumber, sequenceCount, data = string.find(inMessage,
    "<G(%d-)> %[(%d)%] (%d+) (%d+)%/(%d+) (.*)"
  );
  dtype = tonumber(dtype);
  datagramid = tonumber(datagramid);
  sequenceCount = tonumber(sequenceCount);
  sequenceNumber = tonumber(sequenceNumber);

  --Gibberish_Print("Received: " .. inMessage);

  if (sequenceCount == 1) then
    Gibberish.CompleteInteraction(inMessageAuthor, datagramid, dtype, data);
  elseif (sequenceNumber == 1) then
    if (not Gibberish.ReceivedTransmissions[inMessageAuthor]) then
      Gibberish.ReceivedTransmissions[inMessageAuthor] = {};
      Gibberish.ReceivedTransmissions[inMessageAuthor].inbox = {};
    end
    
    Gibberish.ReceivedTransmissions[inMessageAuthor].inbox[datagramid] = {
      player = inMessageAuthor,
      method = dtype,
      content = data,
      chunk = 1
    };
  elseif (sequenceNumber == sequenceCount) then
    local frozen = Gibberish.ReceivedTransmissions[inMessageAuthor].inbox[datagramid].content .. data;
    Gibberish.CompleteInteraction(inMessageAuthor, datagramid, dtype, frozen);
  else
    local nextChunk = Gibberish.ReceivedTransmissions[inMessageAuthor].inbox[datagramid].chunk + 1;
    
    Gibberish.ReceivedTransmissions[inMessageAuthor].inbox[datagramid].content = Gibberish.ReceivedTransmissions[inMessageAuthor].inbox[datagramid].content .. data;
    Gibberish.ReceivedTransmissions[inMessageAuthor].inbox[datagramid].chunk = nextChunk;
  end

  Gibberish.lastPlayer = inMessageAuthor;
  Gibberish.lastMessage = inMessage;
end

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
function Gibberish.CompleteInteraction(player, id, method, content)
  if (method == Gibberish.MSGTYPE_TEXT) then
    -- nothing required
  elseif (method == Gibberish.MSGTYPE_TABLE) then
    content = Gibberish.StringToTable(content);
  end

  -- TODO: check received chunks vs. total chunks
  
  -- TODO: add ability to return status

  -- call the callback function
  for i=1, table.getn(Gibberish.Callbacks), 1 do
    Gibberish.Callbacks[i](player, content);
  end

  -- clear out the ReceivedTransmissions entry
  if (Gibberish.ReceivedTransmissions[player] and Gibberish.ReceivedTransmissions[player].inbox[id]) then
    Gibberish.ReceivedTransmissions[player].inbox[id] = nil;
  end
end

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
function Gibberish.Interact(content, player, instant)
  Gibberish.MessageId = Gibberish.MessageId + 1;

  -- construct the new transmission
  local transmission = {};
  transmission.id = Gibberish.MessageId;
  transmission.player = player;
  transmission.position = 1;

  -- if a table has been sent, we need to convert it
  if (type(content) == "table") then
    transmission.method = "table";
    content = Gibberish.TableToString(content);
  else
    transmission.method = "text";
  end

  transmission.content = content;
  
  -- break the transmission into chunks
  local chunkIndex = 1;                 -- chunk number
  local position = 1;                   -- position within the content
  local length = string.len(content);   -- total length of the content
  local span = nil;                     -- content of the current chunk

  --local chunkCount = math.ceil(string.len(content) / Gibberish.PROTOCOL_CHUNKLENGTH);

  transmission.chunks = {}
  while (position <= length) do
    span = string.sub(content, position, position + Gibberish.PROTOCOL_CHUNKLENGTH);
    
    local chunkData = {};
    chunkData.content = span;
    chunkData.id = transmission.id;
    chunkData.sequenceNumber = chunkIndex;
    --chunkData.sequenceCount = chunkCount;
    chunkData.method = transmission.method;
    
    table.insert(transmission.chunks, chunkData);

    position = position + Gibberish.PROTOCOL_CHUNKLENGTH + 1;
    chunkIndex = chunkIndex + 1;
  end
 
  local chunkCount = table.getn(transmission.chunks);
  for i=1, chunkCount, 1 do
    transmission.chunks[i].sequenceCount = chunkCount;
  end
 
  table.insert(Gibberish.BufferedTransmissions, transmission);
  
  if (table.getn(Gibberish.BufferedTransmissions) == 1) then
    Gibberish.ScheduleForCall(Gibberish.SendBufferedTransmissions, {}, Gibberish.PROTOCOL_INTERVAL, 1, true);
  end
end

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
function Gibberish.PackageChunk(chunk)
  local outChunk = "";
  
  --[[
  Message Size:
    255 - 200 = 55 characters free
  
  Components:
    "<G??>" - 5
    space - 1
    "[" - 1
    msgType - 1
    "]" - 1
    id - 8
    space - 1
    sequenceNumber - 8
    "/" - 1
    sequenceCount - 8
    space - 1

    total: 36  
  --]]
  
  -- Bell conversion converts all outgoing linebreaks to Bells (\007) and then back again when recieved.
  --chunk.content =  string.gsub(chunk.content, "\n", "\007");

  outChunk = "<G" .. Gibberish.PROTOCOL_VERSION .. "> ";

  if (chunk.method == "text") then
    outChunk = outChunk .. "[" .. Gibberish.MSGTYPE_TEXT .. "]";
  elseif (chunk.method == "table") then
    outChunk = outChunk .. "[" .. Gibberish.MSGTYPE_TABLE .. "]";
  end
  
  outChunk = outChunk .. " " .. chunk.id;
  outChunk = outChunk .. " " .. chunk.sequenceNumber .. "/" .. chunk.sequenceCount;
  outChunk = outChunk .. " " .. chunk.content;
  
  return outChunk;
end

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
function Gibberish.SendBufferedTransmissions()
  local transmission = Gibberish.BufferedTransmissions[1];
  local step = 1;

  if (not transmission) then
    return;
  end

  local count = table.getn(transmission.chunks);
  while (transmission.position <= count) do
    local chunk = transmission.chunks[transmission.position];

    local outString = Gibberish.PackageChunk(chunk);
    Gibberish.Broadcast(outString, transmission.player);
    
    transmission.position = transmission.position + 1;
    step = step + 1;
    chunk.sent = true;
  end
  
  -- remove the transmission from the buffer if it has been sent in full
  if (transmission.position >= count) then
    local last = transmission.chunks[count];
    if (not last.sent) then
      -- TODO: send it here... sender = reference to the SendToChannel or SendToWhisper function
      -- sender(transmission.target, transmission.id, transmission.context, chunk.mark, chunk.content);
      Gibberish.Broadcast(last, transmission.player);
    end
    table.remove(Gibberish.BufferedTransmissions, 1);
  end

  if (table.getn(Gibberish.BufferedTransmissions) > 0) then
    Gibberish.ScheduleForCall(Gibberish.SendBufferedTransmissions, {}, Gibberish.PROTOCOL_INTERVAL, 1);
  end
end

--[[ ********************************************************************* --]]
-- Broadcast a message on the channel.  The message is a string, there is
-- no predefined format so send what your code needs to broadcast and be
-- prepared to parse it when you receive a message-received callback.
--[[ ********************************************************************* --]]
function Gibberish.Broadcast(inMessage, inPlayer)
  -- attempt to rejoin the channel
  if (Gibberish.ChannelNumber == 0) then
    JoinChannelByName(Gibberish.ChannelName);
    Gibberish.ChannelNumber = GetChannelName(Gibberish.ChannelName);
  end
 
  if (Gibberish.ChannelNumber ~= 0) then
    -- Sending a chat message will clear the AFK flag.  If the player has
    -- gone AFK we don't want to unflag them by sending a message.
    local clearAFK = GetCVar("autoClearAFK")
    SetCVar("autoClearAFK", 0)
    
    --Gibberish_Print("Broadcasting: " .. inMessage);
    if (inPlayer) then
      SendChatMessage(inMessage, "WHISPER", nil, inPlayer)
    else
      SendChatMessage(inMessage, "CHANNEL", nil, Gibberish.ChannelNumber)
    end
    
    SetCVar("autoClearAFK", clearAFK)
  --else
  --  Gibberish_Print("Broadcast: lost channel, initating retry")
    -- The channel was lost, initiate a retry in the OnUpdate() method.
  --  self.ConnectRetryTime = 0
  end
end


--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
function Gibberish.IsUser(username)
  if (Gibberish.UserList[string.lower(username)]) then
    return true;
  end
  
  return nil;
end

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]
function Gibberish.AddUser(username)
  Gibberish.UserList[string.lower(username)] = true;
end

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]

--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]











--[[ ********************************************************************* --]]
-- Convert a table to a string.  The table elements are accessed by index
-- from 1..n and appended to a string separated by whitespace, so the
-- table {2, "a", "9", "hij" } will result in the string "2 a 9 hij".
-- Spaces within a table value are escaped to <20>.
--[[ ********************************************************************* --]]
function Gibberish.TableToString(value, name)
  local output = "";

  if ( name == nil ) then name = ""; 
  else
    -- Serialize the name
    name = Gibberish.TableToString(name);
    -- Remove the <>
    name = string.gsub(name, "<(.*)>", "%1");
  end

  if (type(value) == "nil" ) then 
    output = name.."<".."nil:nil"..">";
  elseif ( type(value) == "string" ) then
    value = string.gsub(value, "<", "&lt;");
    value = string.gsub(value, ">", "&gt;");
    output = name.."<".."s:"..value..">";
  elseif ( type(value) == "number" ) then
    output = name.."<".."n:"..value..">";
  elseif ( type(value) == "boolean" ) then
    if ( value ) then 
      output = name.."<".."b:".."true"..">";
    else
      output = name.."<".."b:".."false"..">";
    end
  elseif ( type(value) == "function" ) then
    output = name.."<".."func:".."*invalid*"..">";
  elseif ( type(value) == "table" ) then
    output = name.."<".."t:";
    for k,v in value do 
      output = output.." "..Gibberish.TableToString(v,k);
    end
    output = output .. ">";
  end

  return output;
end

--[[ ********************************************************************* --]]
-- Convert a string to a table.  The string text is divided by whitespace,
-- so the string "2 a 9 hij" will result in the table {2, "a", "9", "hij" }.
--
-- If a substring can be represented completely as a number, it is converted
-- to a number before it is placed into a table.
--[[ ********************************************************************* --]]
function Gibberish.StringToTable(str)
  -- check for the format "keytype:keyvalue<valuetype:value>"
  -- take the stuff in <>
  typevalue = string.gsub(str, "%s*(%w*:?%w*)%s*(<.*>)","%2");

  local value = nil;
  local typeString = string.gsub(typevalue, "<%s*(%w*):(.*)>","%1");
  local valueString = string.gsub(typevalue, "<%s*(%w*):(.*)>","%2");


  --print("str: ", str, " typevalue: ", typevalue);
  --print("valueString: (", valueString, ") typeString: (", typeString,")");

  -- Error!
  if ( typeString == typevalue ) then 
    mq.IO.error ( "Unparsable string passed to StringToTable: ", str );
    return nil;
  end

  -- Maybe no error!
  if ( typeString == "nil" ) then 
    value = nil;

  elseif ( typeString == "n" ) then 
    value = tonumber(valueString);

  elseif ( typeString == "b" ) then 
    if ( valueString == "true" ) then
      value = true;
    else
      value = false;
    end

  elseif ( typeString == "s" ) then 
    value = valueString;
    -- Parse the <> back in
    value = string.gsub(value, "&lt;", "<");
    value = string.gsub(value, "&gt;", ">");

  elseif ( typeString == "f" ) then
    -- Functions are not supported, but if they were..

    -- ...this is how it should work
    -- value = getglobal(typeString);
    value = mq.IO.error;

  elseif ( typeString == "t" ) then 
    -- Here's the hard part
    -- I have to extract each set of <>
    -- which might have nested tables!
    -- 
    -- So I start off by tracking < until I get 0
    --
    value = {};

    local left = 1;
    local right = 1;

    local count = 0;

    while ( valueString and valueString ~= "" ) do
      local object = nil;
      local key = nil;

      -- Extract the key and convert it
      key = string.gsub(valueString, "%s*(%w*:?.-)<.*>", "%1" );
      key = Gibberish.StringToTable("<"..key..">");


      left = string.find(valueString, "<", 1 );
      right = string.find(valueString, ">", 1 );

      if ( left < right ) then 
        nextleft = string.find(valueString, "<", left+1 );
        while ( nextleft and nextleft < right ) do
          nextleft = string.find(valueString, "<", nextleft+1 );
          right = string.find(valueString, ">", right+1 );
        end
      else
        --error ( "we all die." );
      end

      objectString = string.sub(valueString, left, right);

      -- Create the object
      object = Gibberish.StringToTable(objectString);

      -- Add it to the table
      value[key] = object;

      -- See if there's another entry
      valueString = string.sub(valueString, right+1);
    end
  end

  return value;
end


















function Gibberish_Print(inMessage)
  if (DEFAULT_CHAT_FRAME) then
    local printMessage = "<lightBlue>Gibberish: <brightGreen>" .. inMessage
    printMessage = ChannelCast_ParsePrintColors(printMessage)
    DEFAULT_CHAT_FRAME:AddMessage(printMessage);
  end
end








--[[ ********************************************************************* --]]
--[[ Gibberish.RegisterForEvent                                            --]]
--[[   Registers the specified callback for the specified global event.    --]]
--[[ ********************************************************************* --]]
function Gibberish.RegisterForEvent(event, callback)
  if (Gibberish.RegisteredEvents[event]) then
    table.insert(Gibberish.RegisteredEvents[event], callback);
  else
    Gibberish.RegisteredEvents[event] = {callback};
  end

  if (Gibberish_ControlFrame) then
    Gibberish_ControlFrame:RegisterEvent(event);
  end
end

--[[ ********************************************************************* --]]
--[[ Gibberish.ScheduleForCall                                             --]]
--[[   Registers the specified call.                                       --]]
--[[                                                                       --]]
--[[   callback - function to call                                         --]]
--[[   arguments - args for callback                                       --]]
--[[   timeout - timeout till first call                                   --]]
--[[   interval - number of times to call                                  --]]
--[[   immediate - call right away                                         --]]
--[[ ********************************************************************* --]]
function Gibberish.ScheduleForCall(callback, arguments, timeout, interval, immediate)
  local call = {callback, arguments, timeout};

  if (interval) then
    call = {callback, arguments, timeout, interval};
  end

  if (immediate) then
    arguments = callback(unpack(arguments)) or arguments;
    call[2] = arguments;
  end

  dict.insert(Gibberish.ScheduledCalls, GetTime() + timeout, call);
end

--[[ ********************************************************************* --]]
--[[ Gibberish.OnGlobalUpdate                                              --]]
--[[   Global timer update function.  Parses scheduled tasks to be handled --]]
--[[   every second.                                                       --]]
--[[ ********************************************************************* --]]
function Gibberish.OnGlobalUpdate(delta)
  Gibberish.EventDelta = Gibberish.EventDelta + delta;

  if (Gibberish.EventDelta >= 1) then
    Gibberish.EventDelta = 0;
    
    local timestamp, callback, arguments, timeout, interval = GetTime(), nil, nil, nil, nil;
    
    for call in dict.process(Gibberish.ScheduledCalls, timestamp) do
      callback, arguments, timeout, interval = unpack(call);
      arguments = callback(unpack(arguments)) or arguments;
      
      if timeout and (not interval or interval > 1) then
        if interval then
          interval = interval - 1;
        end
        dict.insert(Gibberish.ScheduledCalls, timestamp + timeout, {callback, arguments, timeout, interval});
      end
    end
  end
end

--[[ ********************************************************************* --]]
--[[ Gibberish.OnGlobalEvent                                               --]]
--[[   Passes global event calls through to MyQuests and other registered  --]]
--[[   addons.                                                             --]]
--[[ ********************************************************************* --]]
function Gibberish.OnGlobalEvent(event, arguments)
  for i, callback in ipairs(Gibberish.RegisteredEvents[event]) do
    callback(event, arguments);
  end
end









-- *****************************************************************************
-- This routine was taken from the Necrosis warlock management AddOn.
-- *****************************************************************************
function ChannelCast_ParsePrintColors(msg)
  msg = string.gsub(msg, "<white>", "|CFFFFFFFF");
  msg = string.gsub(msg, "<lightBlue>", "|CFF99CCFF");
  msg = string.gsub(msg, "<brightGreen>", "|CFF00FF00");
  msg = string.gsub(msg, "<lightGreen2>", "|CFF66FF66");
  msg = string.gsub(msg, "<lightGreen1>", "|CFF99FF66");
  msg = string.gsub(msg, "<yellowGreen>", "|CFFCCFF66");
  msg = string.gsub(msg, "<lightYellow>", "|CFFFFFF66");
  msg = string.gsub(msg, "<yellow>", "|CFFFFFF00");
  msg = string.gsub(msg, "<darkYellow>", "|CFFFFCC00");
  msg = string.gsub(msg, "<lightOrange>", "|CFFFFCC66");
  msg = string.gsub(msg, "<dirtyOrange>", "|CFFFF9933");
  msg = string.gsub(msg, "<darkOrange>", "|CFFFF6600");
  msg = string.gsub(msg, "<redOrange>", "|CFFFF3300");
  msg = string.gsub(msg, "<red>", "|CFFFF0000");
  msg = string.gsub(msg, "<lightRed>", "|CFFFF5555");
  msg = string.gsub(msg, "<lightPurple1>", "|CFFFFC4FF");
  msg = string.gsub(msg, "<lightPurple2>", "|CFFFF99FF");
  msg = string.gsub(msg, "<purple>", "|CFFFF50FF");
  msg = string.gsub(msg, "<darkPurple1>", "|CFFFF00FF");
  msg = string.gsub(msg, "<darkPurple2>", "|CFFB700B7");
  msg = string.gsub(msg, "<pink>", "|CFFFF3399");
  msg = string.gsub(msg, "<close>", "|r");
  return msg;
end








--[[ ********************************************************************* --]]
--[[ ********************************************************************* --]]

