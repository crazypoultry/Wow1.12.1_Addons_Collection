ChatHandler = {
   stack = {};

   maxCharsPerMessage = 250;
   
   nextSendTick = 0;
};


--[[

ChatHandler.sendMessage()

-- Puts a message into queue.

]]--
function ChatHandler.sendMessage(msg)
   table.insert(ChatHandler.stack, msg);
end


--[[

ChatHandler.getLongestMsg(table, limit)

-- returns index of longest message that fits into limit <limit>.

]]--
function ChatHandler.getLongestMsg(tab, limit)
   local longestMsg = -1;

   -- find the currently longest message.
   if table.getn(tab) > 0 then
      for i=1, table.getn(tab) do
	 if longestMsg == -1 then
	    if string.len(tab[i]) < limit then
	       longestMsg = i;
	    end
	 else
	    if string.len(tab[i]) > string.len(tab[longestMsg]) and string.len(tab[i]) < limit then
	       longestMsg = i;
	    end
	 end
      end

      -- bugfix code: DV MUST be sent before any description is being sent
      -- if there is a DV this will be returned as "longest" message.
      for i=1, table.getn(tab) do
	 if string.sub(tab[i], 1, 3) == "<DV" then
	    FlagRSP.printDebug("we found a drev!");

	    longestMsg = i;
	 end
      end
   end

   

   return longestMsg;
end


--[[

ChatHandler.cleanQueue()

-- Removes illegal messages (e.g. too long).

]]--
function ChatHandler.cleanQueue()
   local i = 1;

   while ChatHandler.stack[i] ~= nil do
      if string.len(ChatHandler.stack[i]) > ChatHandler.maxCharsPerMessage then
	 FlagRSP.printA(4);
	 table.remove(ChatHandler.stack, i);
      else
	 i = i + 1;
      end
   end
end


--[[

ChatHandler.compressQueue()

-- Makes chat queue more compact by combining messages together into one message.

]]--
function ChatHandler.compressQueue()
   local oldStack = ChatHandler.stack;
   local newStack = {};

   local l = 1;
   local charsInMsg = 0;
   local longestMsg = 1;

   while table.getn(oldStack) > 0 do
   --if table.getn(oldStack) > 0 then
      if newStack[l] == nil then
	 newStack[l] = "";
	 charsInMsg = 0;
      else
	 charsInMsg = string.len(newStack[l]);
      end

      --longestMsg = 1;
      
      longestMsg = ChatHandler.getLongestMsg(oldStack, ChatHandler.maxCharsPerMessage-charsInMsg);

      if longestMsg == -1 then
	 -- no more messages that fit.
	 --FlagRSP.printDebug("no longest message");
	 l = l + 1;
      else
	 --FlagRSP.printDebug("longest message that fits: " .. longestMsg);
	 -- there is a message that can be put together with current set.
	 
 	 newStack[l] = newStack[l] .. oldStack[longestMsg];
	 table.remove(oldStack, longestMsg);
      end
      
      --FlagRSP.printDebug("current message: " .. l .. " is: " .. newStack[l]);
   end

   ChatHandler.stack = newStack;
end


--[[

ChatHandler.executeQueue()

-- Sends messages.

]]--
function ChatHandler.executeQueue()
   if GetTime() > ChatHandler.nextSendTick then
      --ChatHandler.sendMessage("abcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcENDE");
      ChatHandler.cleanQueue();
      ChatHandler.compressQueue();

      if table.getn(ChatHandler.stack) >= 1 then
	 local message = ChatHandler.stack[1];
	 
	 FlagRSP_JoinChannel();
	 id = GetChannelName(xTP_ChannelName);

	 SendChatMessage(message, "CHANNEL", FlagRSP_Locale_CLanguage, id); 
	 
	 --FlagRSP.printDebug("Send message: " .. message);
	 
	 table.remove(ChatHandler.stack, 1);
	 ChatHandler.nextSendTick = GetTime() + 1;
      end
   end
end