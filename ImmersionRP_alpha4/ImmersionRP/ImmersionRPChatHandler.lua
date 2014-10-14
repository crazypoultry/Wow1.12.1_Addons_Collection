--[[
	ImmersionRP Alpha 4 chat handler.
	Purpose: Handle queuing and sending of chat messages.
	Author: Seagale.
	Last update: March 9th, 2007.
]]


ImmersionRPChatHandler = {
	ChatQueue = {};

	MaxCharsPerMessage = 250;
   
	LastSend = 0;
	SendInterval = 1;
	
	ChannelAlertShown = 0;
};

function ImmersionRPChatHandler.SendMessage(message)
	local id = GetChannelName(ImmersionRPSettings["COMM_CHANNEL"]);
	if (id ~= 0) then
		table.insert(ImmersionRPChatHandler.ChatQueue, message);
	else
		if (ImmersionRPChatHandler.ChannelAlertShown == 0) then
			StaticPopup_Show("IRP_JOINCHANNEL");
			ImmersionRPChatHandler.ChannelAlertShown = 1;
		end
	end
end

function ImmersionRPChatHandler.GetLongestMessage(tab, limit)
	local longestmessage = -1;

   -- find the currently longest message.
	if table.getn(tab) > 0 then
		for i=1, table.getn(tab) do
			if longestmessage == -1 then
				if string.len(tab[i]) < limit then
				longestmessage = i;
				end
			else
				if string.len(tab[i]) > string.len(tab[longestmessage]) and string.len(tab[i]) < limit then
					longestmessage = i;
				end
			end
		end

      -- bugfix code by flokru: DV MUST be sent before any description is being sent
      -- if there is a DV this will be returned as "longest" message.
		if (ImmersionRPSettings["COMM_PROTOCOL"] == 2) then
			for i=1, table.getn(tab) do
				if string.sub(tab[i], 1, 3) == "<DV" then
					longestmessage = i;
				end
			end
		end
	end

   

   return longestmessage;
end



function ImmersionRPChatHandler.CleanQueue()
	local i = 1;

	while ImmersionRPChatHandler.ChatQueue[i] ~= nil do
		if string.len(ImmersionRPChatHandler.ChatQueue[i]) > ImmersionRPChatHandler.MaxCharsPerMessage then
			table.remove(ImmersionRPChatHandler.ChatQueue, i);
		else
			i = i + 1;
		end
	end
end



function ImmersionRPChatHandler.CompressQueue()
	local oldqueue = ImmersionRPChatHandler.ChatQueue;
	local newqueue = {};
	
	local l = 1;
	local charsinmessage = 0;
	local longestmessage = 1;

	while table.getn(oldqueue) > 0 do
		if newqueue[l] == nil then
			newqueue[l] = "";
			charsinmessage = 0;
		else
			charsinmessage = string.len(newqueue[l]);
		end
      
		longestmessage = ImmersionRPChatHandler.GetLongestMessage(oldqueue, ImmersionRPChatHandler.MaxCharsPerMessage-charsinmessage);

		if longestmessage == -1 then
			l = l + 1;
		else
			newqueue[l] = newqueue[l] .. oldqueue[longestmessage];
			table.remove(oldqueue, longestmessage);
		end
	end

	ImmersionRPChatHandler.ChatQueue = newqueue;
end

function ImmersionRPChatHandler.ExecuteQueue()
	if (GetTime() > ImmersionRPChatHandler.LastSend + ImmersionRPChatHandler.SendInterval) then
		ImmersionRPChatHandler.CleanQueue();
		ImmersionRPChatHandler.CompressQueue();

		if (table.getn(ImmersionRPChatHandler.ChatQueue) >= 1) then
			id = GetChannelName(ImmersionRPSettings["COMM_CHANNEL"]);
			if (id ~= 0) then
				SendChatMessage(ImmersionRPChatHandler.ChatQueue[1], "CHANNEL", nil, id); 
				table.remove(ImmersionRPChatHandler.ChatQueue, 1);
				ImmersionRPChatHandler.LastSend = GetTime();
			end
      end
   end
end