--[[
	ImmersionRP Alpha 4 flagRSP message handler.
	Purpose: Read and write the flagRSP and FlagRSP2 protocol.
	Author: Seagale.
	Last update: March 9th, 2007.
	
	NOTE: A large portion of the following code, notably
		  the code in ParseChatMessage(), has been adapted
		  from flagRSP itself. Hail flokru!
]]

ImmersionRPflagRSPHandler = {
	IRP_FLAGRSP_MININTERVAL = 120,
	IRP_FLAGRSP_MAXINTERVAL = 7200,
	IRP_FLAGRSP_MININTERVALHIGH = 30,
	IRP_FLAGRSP_MAXINTERVALHIGH = 1000,
	IRP_FLAGRSP_TARGETMPM = 60,
	
	MaxPostingCost = 147,
	MaxPostingCostHigh = 42,
	PostingTargetBps = 25,
	PostingTargetBpsHigh = 25,

	PostInterval = 2000,
	PostIntervalHigh = 400,
	
	IntervalList = {},
	IntervalListHigh = {},
	
	LastPostLow = 0,
	LastPostHigh = 0,
	
	CharactersPerDescPost = 240,
	DescPostInterval = 60,
	LastDescPost = 0,
	
	AnalysisInterval = 360,
	LastAnalysis = 0
};

function ImmersionRPflagRSPHandler.CharaterStatusToNumber(charstatus)
	if charstatus == "" then
	    return 0;
	 elseif charstatus == "ooc" then
	    return 1;
	 elseif charstatus == "ic" then
	    return 2;
	 elseif charstatus == "ffa-ic" then
	    return 3;
	 elseif charstatus == "st" then
	    return 4; 
	 end
end

function ImmersionRPflagRSPHandler.ParseChatMessage(message, player)
	if (string.find(message,"<") == nil) then 
		return;
	end
	
	if (string.find(string.sub(message,2,string.len(message)),"<") ~= nil) then 
    	-- Multi-option line
      
	    local firstBrack = string.find(string.sub(message,2,string.len(message)),"<");

    	local firstComm = string.sub(message,1,firstBrack);
	    local rest = string.sub(message,firstBrack+1, string.len(message));
	    
		ImmersionRPflagRSPHandler.ParseChatMessage(firstComm, player)
	    ImmersionRPflagRSPHandler.ParseChatMessage(rest, player);
	elseif (string.find(string.sub(message,2,string.len(message)),"<") == nil) then 
		-- Single-option line
		-- Substitute encoded brackets.
		local message = string.gsub(message, "\\%(", "<");
		message = string.gsub(message, "\\%)", ">");
		
		if (string.sub(message,1,3) == "<RP" and string.sub(message,4,4) ~= "T") then -- FLAG: Roleplaying style (number before closing bracket)
			if (string.sub(message,4,4) ~= ">") then
				ImmersionRPDatabaseHandler.SetFlag(player, "RPSTYLE", tonumber(string.sub(message,4,4)));
				local playerinterval = tonumber(string.sub(message,6,string.len(message)));
				if (playerinterval ~= nil and playerinterval ~= 0) then
					ImmersionRPflagRSPHandler.IntervalList[player] = playerinterval;
				end
			else
				ImmersionRPDatabaseHandler.SetFlag(player, "RPSTYLE", 1);
				local playerinterval = tonumber(string.sub(message,5,string.len(message)));
				if (playerinterval ~= nil and playerinterval ~= 0) then
					ImmersionRPflagRSPHandler.IntervalList[player] = playerinterval;
				end
			end
		-- NOTE: The RPT flag has something to do with a mysterious TofBof entity, which seems to be related to some RP-ticket system.
		elseif (string.sub(message, 1, 7) == "<TITEL>") then -- FLAG: Title (old version, German for "title")
			ImmersionRPDatabaseHandler.SetFlag(player, "TITLE",string.sub(message, 8, string.len(message)));
		elseif (string.sub(message, 1, 3) == "<T>") then -- FLAG: Title (new, shorter version)
			ImmersionRPDatabaseHandler.SetFlag(player, "TITLE",string.sub(message, 4, string.len(message)));
		-- NORE: BFT and BF0 are beyond me, I can't find any reason to their existence.
		elseif (string.sub(message, 1, 6) == "<NAME>") then -- FLAG: Character surname (long version). Extra-legacy from xtooltip2.
			ImmersionRPDatabaseHandler.SetFlag(player, "LASTNAME", string.sub(message, 7, string.len(message)));
		elseif (string.sub(message, 1, 3) == "<N>") then -- FLAG: Character surname (short version). Legacy from flagRSP, R.I.P.
			ImmersionRPDatabaseHandler.SetFlag(player, "LASTNAME", string.sub(message, 4, string.len(message)));
		elseif (string.sub(message, 1, 9) == "<CSTATUS>") then -- FLAG: Character status (long version)
			ImmersionRPDatabaseHandler.SetFlag(player, "RPSTATUS", ImmersionRPflagRSPHandler.CharaterStatusToNumber(string.sub(message, 10, string.len(message))));
		elseif (string.sub(message, 1, 3) == "<CS") then -- FLAG: Character status (short version, number before closing cracket)
			ImmersionRPDatabaseHandler.SetFlag(player, "RPSTATUS", tonumber(string.sub(message,4,4)));
			local playerintervalhigh = tonumber(string.sub(message,6,string.len(message)));
			if (playerintervalhigh ~= nil and playerintervalhigh ~= 0) then
				ImmersionRPflagRSPHandler.IntervalListHigh[player] = playerintervalhigh;
			end
		elseif (string.sub(message, 1, 6) == "<DREV>") then -- FLAG: Desciption revision (long version)
			local n = tonumber(string.sub(message, 7, string.len(message)));
			if (n == nil) then
				n = -1;
			end
			if (n ~= ImmersionRPDatabaseHandler.GetFlag(player, "DESCMETA") and n ~= -1) then
				ImmersionRPDatabaseHandler.DeleteFlag(player, "DESCRIPTION");
				ImmersionRPDatabaseHandler.SetFlag(player, "DESCMETA", nil);
				if (math.random(0,600) == 0) then ImmersionRPChatHandler.SendMessage("<DP>" .. player); end
			elseif (n == -1) then
				ImmersionRPDatabaseHandler.DeleteFlag(player, "DESCRIPTION");
				ImmersionRPDatabaseHandler.SetFlag(player, "DESCMETA", nil);
			end
			ImmersionRPDatabaseHandler.SetFlag(player, "DESCMETA", n);
		elseif (string.sub(message, 1, 4) == "<DV>") then -- FLAG: Desciption revision (short version)
			local n = tonumber(string.sub(message, 5, string.len(message)));
			if (n == nil) then
				n = -1;
			end
			if (n ~= ImmersionRPDatabaseHandler.GetFlag(player, "DESCMETA") and n ~= -1) then
				ImmersionRPDatabaseHandler.DeleteFlag(player, "DESCRIPTION");
				ImmersionRPDatabaseHandler.SetFlag(player, "DESCMETA", nil);
				if (math.random(0,600) == 0) then ImmersionRPChatHandler.SendMessage("<DP>" .. player); end
			elseif (n == -1) then
				ImmersionRPDatabaseHandler.DeleteFlag(player, "DESCRIPTION");
				ImmersionRPDatabaseHandler.SetFlag(player, "DESCMETA", nil);
			end
			ImmersionRPDatabaseHandler.SetFlag(player, "DESCMETA", n);
		elseif (string.sub(message, 1, 4) == "<DP>" and string.sub(message, 5, string.len(message)) == ImmersionRP.PlayerName) then
			ImmersionRPflagRSPHandler.PostDescription();
		elseif (string.sub(message, 1, 7) == "<DPULL>" and string.sub(message, 8, string.len(message)) == ImmersionRP.PlayerName) then
			ImmersionRPflagRSPHandler.PostDescription();
		elseif ((string.sub(message, 1, 2) == "<D" or string.sub(message, 1, 2) == "<P") and tonumber(string.sub(message,3,4)) ~= nil) then --FLAG: Description part (difference between <D and <P is unclear)
			local descriptionpart = string.sub(message,6,string.len(message));
			local descriptionpart = string.gsub(descriptionpart,"\\l","\n");
			local descriptionpart = string.gsub(descriptionpart,"\\eod","");
			if (tonumber(string.sub(message,3,4)) == 1) then
				ImmersionRPDatabaseHandler.SetFlag(player, "DESCRIPTION", descriptionpart);
			else
				if (ImmersionRPDatabaseHandler.GetFlag(player, "DESCRIPTION") ~= "" and ImmersionRPDatabaseHandler.GetFlag(player, "DESCRIPTION") ~= nil) then
					ImmersionRPDatabaseHandler.AppendFlag(player, "DESCRIPTION", descriptionpart);
				end
			end
		elseif ((string.sub(message, 1, 3) == "<AN") and string.sub(message, 3, 4) ~= nil) then -- FlagRSP2's new naming scheme. <AN1> = first name, <AN2> = middle name, unused, <AN3> = last name.
			if (string.sub(message, 4, 4) == "1") then
				ImmersionRPDatabaseHandler.SetFlag(player, "FIRSTNAME", string.sub(message, 6, string.len(message)));
			elseif (string.sub(message, 4, 4) == "2") then
				ImmersionRPDatabaseHandler.SetFlag(player, "MIDDLENAME", string.sub(message, 6, string.len(message)));
			elseif (string.sub(message, 4, 4) == "3") then
				ImmersionRPDatabaseHandler.SetFlag(player, "LASTNAME", string.sub(message, 6, string.len(message)));
			end
		--elseif (string.sub(message,1,4) == "<I1>") then -- ImmersionRP's own legacy tag. They grow so fast... *sniff*
		--	ImmersionRPDatabaseHandler.SetFlag(player, "NAMETYPE",1);
		--elseif (string.sub(message,1,4) == "<I0>") then -- ImmersionRP's own legacy tag. They grow so fast... *sniff*
		--	ImmersionRPDatabaseHandler.SetFlag(player, "NAMETYPE",0);
		end
	end
	ImmersionRPflagRSPHandler.AnalyseTraffic();
end

function ImmersionRPflagRSPHandler.PostLow()
	if (ImmersionRP.PlayerAFK == 0) then
	
		if (ImmersionRPCharacterInfo["RPSTYLE"] ~= nil and ImmersionRPCharacterInfo["RPSTYLE"] ~= 0) then
			if (ImmersionRPCharacterInfo["RPSTYLE"] == 1) then
				ImmersionRPChatHandler.SendMessage("<RP>" .. ImmersionRPflagRSPHandler.PostInterval);
			else
				ImmersionRPChatHandler.SendMessage("<RP" .. ImmersionRPCharacterInfo["RPSTYLE"] .. ">" .. ImmersionRPflagRSPHandler.PostInterval);
			end
		else
			ImmersionRPChatHandler.SendMessage("<RP0>" .. ImmersionRPflagRSPHandler.PostInterval);
		end
		
		if (ImmersionRPCharacterInfo["FIRSTNAME"] ~= nil) then
			ImmersionRPChatHandler.SendMessage("<AN1>" .. string.gsub(ImmersionRPCharacterInfo["FIRSTNAME"], "<", "\\("));
		else
			ImmersionRPChatHandler.SendMessage("<AN1>");
		end
		
		if (ImmersionRPCharacterInfo["LASTNAME"] ~= nil) then
			ImmersionRPChatHandler.SendMessage("<AN3>" .. string.gsub(ImmersionRPCharacterInfo["LASTNAME"], "<", "\\("));
		else
			ImmersionRPChatHandler.SendMessage("<AN3>");
		end
		
		if (ImmersionRPCharacterInfo["TITLE"] ~= nil and ImmersionRPCharacterInfo["TITLE"] ~= "") then
			ImmersionRPChatHandler.SendMessage("<T>" .. string.gsub(ImmersionRPCharacterInfo["TITLE"], "<", "\\("));
		else
			ImmersionRPChatHandler.SendMessage("<T>");
		end
	end
end

function ImmersionRPflagRSPHandler.PostHigh(onlydv)
	if (ImmersionRP.PlayerAFK == 0) then
		if (not onlydv) then ImmersionRPChatHandler.SendMessage("<CS" .. ImmersionRPCharacterInfo["RPSTATUS"] .. ">" .. math.ceil(ImmersionRPflagRSPHandler.PostIntervalHigh)); end
		if (ImmersionRPCharacterInfo["DESCMETA"] > 0 and ImmersionRPCharacterInfo["DESCRIPTION"] ~= nil and ImmersionRPCharacterInfo["DESCRIPTION"] ~= "") then
			ImmersionRPChatHandler.SendMessage("<DV>" .. ImmersionRPCharacterInfo["DESCMETA"]);
		else
			ImmersionRPChatHandler.SendMessage("<DV>-1");
		end
		
	end
end

function ImmersionRPflagRSPHandler.PostDescription()
	if (ImmersionRPCharacterInfo["DESCMETA"] > 0 and ImmersionRPCharacterInfo["DESCRIPTION"] ~= nil and ImmersionRPCharacterInfo["DESCRIPTION"] ~= "" and GetTime() >= ImmersionRPflagRSPHandler.LastDescPost + ImmersionRPflagRSPHandler.DescPostInterval) then
		local currpos = 1; local currpart = 1; local sendpart = ""; local messagetosend = ""; local partsneeded = math.ceil(string.len(ImmersionRPCharacterInfo["DESCRIPTION"]) / ImmersionRPflagRSPHandler.CharactersPerDescPost);
		while (currpart <= partsneeded) do
			sendpart = string.sub(ImmersionRPCharacterInfo["DESCRIPTION"],(currpart-1)*ImmersionRPflagRSPHandler.CharactersPerDescPost+1, currpart*ImmersionRPflagRSPHandler.CharactersPerDescPost);
			if (currpart == partsneeded) then sendpart = sendpart .. "\\eod"; end
			if (currpart < 10) then
				messagetosend = "<D0" .. currpart .. ">";
			else
				messagetosend = "<D" .. currpart .. ">";
			end
			messagetosend = messagetosend .. sendpart;
			currpart = currpart + 1;
			ImmersionRPChatHandler.SendMessage(messagetosend);
		end
		ImmersionRPflagRSPHandler.LastDescPost = GetTime();
	end
end

function ImmersionRPflagRSPHandler.AnalyseTraffic()	
	if (GetTime() > ImmersionRPflagRSPHandler.LastAnalysis + ImmersionRPflagRSPHandler.AnalysisInterval) then
		local usersonline = ImmersionRPflagRSPHandler.GetNumberUsersOnline();
		--DEFAULT_CHAT_FRAME:AddMessage("Users online: " .. usersonline,0,0,1);
		
		local newpostinginterval = ImmersionRPflagRSPHandler.MaxPostingCost * usersonline / ImmersionRPflagRSPHandler.PostingTargetBps;
		local newpostingintervalhigh = ImmersionRPflagRSPHandler.MaxPostingCostHigh * usersonline / ImmersionRPflagRSPHandler.PostingTargetBpsHigh;
		
		if (newpostinginterval < ImmersionRPflagRSPHandler.IRP_FLAGRSP_MININTERVAL) then newpostinginterval = ImmersionRPflagRSPHandler.IRP_FLAGRSP_MININTERVAL; end
		if (newpostinginterval > ImmersionRPflagRSPHandler.IRP_FLAGRSP_MAXINTERVAL) then newpostinginterval = ImmersionRPflagRSPHandler.IRP_FLAGRSP_MAXINTERVAL; end
	
		if (newpostingintervalhigh < ImmersionRPflagRSPHandler.IRP_FLAGRSP_MININTERVALHIGH) then newpostingintervalhigh = ImmersionRPflagRSPHandler.IRP_FLAGRSP_MININTERVALHIGH; end
		if (newpostingintervalhigh > ImmersionRPflagRSPHandler.IRP_FLAGRSP_MAXINTERVALHIGH) then newpostingintervalhigh = ImmersionRPflagRSPHandler.IRP_FLAGRSP_MAXINTERVALHIGH; end
		
		ImmersionRPflagRSPHandler.PostInterval = newpostinginterval;
		ImmersionRPflagRSPHandler.PostIntervalHigh = newpostingintervalhigh;
		
		ImmersionRPflagRSPHandler.LastAnalysis = GetTime();
		--DEFAULT_CHAT_FRAME:AddMessage("Analysed traffic, new low interval is " .. newpostinginterval .. ", new high interval is " .. newpostingintervalhigh .. ".",0,1,0);
	end
end

function ImmersionRPflagRSPHandler.GetNumberUsersOnline()
	local usersonline = 0;
	for name, interval in pairs(ImmersionRPflagRSPHandler.IntervalList) do
		if (ImmersionRPDatabaseHandler.GetFlag(name,"LASTSEEN") ~= nil) then
			if (ImmersionRPflagRSPHandler.IntervalListHigh[name] == nil) then
				if (time() <= interval*2+ImmersionRPDatabaseHandler.GetFlag(name,"LASTSEEN")) then
					usersonline = usersonline + 1;
				end
			else
				if (time() <= ImmersionRPflagRSPHandler.IntervalListHigh[name]*2+ImmersionRPDatabaseHandler.GetFlag(name,"LASTSEEN")) then
					usersonline = usersonline + 1;
				end
			end
		end
	end
	return usersonline;
end