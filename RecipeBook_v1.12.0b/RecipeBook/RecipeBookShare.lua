--== RecipeBookShare.lua : Contains functions necessary for RB sharing ==--
--Necessary Variables
-- For parsing received data properly
local RB_LastParsedMessage = "";
local RB_LastParsedRecipe = {};
local RB_LastParsedMaterials = {};
-- For tracking received data
local RB_ReceivedData = {};
local RB_ReceivedMaterials = {};
local RB_ReceivedLinks = {};
-- For tracking RB sessions
local RB_SessionActive = false; --{session status, tradeskill, who, compatible?}
-- local RB_CharacterQueue = {}; -- for /rb send all-alts (work in progress)
local RB_SessionQueue = {}; --for /rb send all


--=================== Functions that deal with outgoing and incoming messages =====================--

--[ ChatFrame_OnEvent(event) : Catches whispers for RB communication. ]--
function RecipeBook_ChatFrame_OnEvent(event)
	if((event == "CHAT_MSG_WHISPER") or (event == "CHAT_MSG_WHISPER_INFORM")) then
		if(string.find(arg1, RECIPEBOOK_MESSAGE_TRIGGER, 1, true)) then 
			RecipeBookMessenger_ProcessMessage(arg2,arg1,event);
		else
			RecipeBook_Old_ChatFrame_OnEvent(event);
		end
	else
		RecipeBook_Old_ChatFrame_OnEvent(event);
	end
end

--[ ProcessMessage : Parses a sent/received message. ]--
function RecipeBookMessenger_ProcessMessage(who,what,event)
	local Realm, Faction, OtherFaction, Player = RecipeBook_GetGlobals();
	if RB_LastParsedMessage == what then return end;
	local whatskill;
	local start,finish;
	if(event == "CHAT_MSG_WHISPER") then
		RB_LastParsedMessage = what;
		RecipeBook_Debug("Data catch: <"..what.."> from "..who);

		-- Receiving Initiate request: Someone wants to send you data.
		if (string.find(what, RECIPEBOOK_MESSAGE_INITIATE)) then 
			RecipeBook_Debug("Message: Initiate request for "..who);
			-- Conditionally accept the session based on your preferences.
			if not RB_SessionActive then
				local regex = '.+' .. RECIPEBOOK_MESSAGE_INITIATE .. '(%w+)';
				whatskill = string.gsub(what, regex, "%1");
				RecipeBook_Debug("Calling ConditionalAcceptance on "..whatskill.." for "..who);
				RecipeBookMessenger_ConditionalAcceptance(who, whatskill, RecipeBookOptions_GetOption("Receive"));
			else
				SendRBMessage(who, RECIPEBOOK_MESSAGE_BUSY);
			end
			
		-- Receiving Version string: Are you on compatible RecipeBook Versions?
		elseif string.find(what, RECIPEBOOK_VERSION_TEXT) then
			RecipeBook_Debug("Message: "..what);
			-- Currently any version that sends its version number is compatible.
			if RB_SessionActive then RB_SessionActive[4] = true end;
			RecipeBookMessenger_SendDelayFrame:Hide();
		
		-- Receiving Initiate accept: Someone has accepted your send request.
		elseif string.find(what, RECIPEBOOK_MESSAGE_ACCEPT) and RecipeBookMessenger_GetName() == who then
			RecipeBook_Debug("Message: Accept for "..who);
			StaticPopup_Hide("RECIPEBOOK_AWAITING_SEND");
			RecipeBookMessenger_SendDelayFrame:Show();
			
		-- Receiving Busy keystring: Someone cannot currently accept your send request.
		elseif string.find(what, RECIPEBOOK_MESSAGE_BUSY) then 
			RecipeBook_Debug("Message: Busy for "..who);
			RecipeBook_Print(format(RECIPEBOOK_ERROR_BUSY, who), 1);
			StaticPopup_Hide("RECIPEBOOK_AWAITING_SEND");
			RB_SessionActive = false; --No session now active.
			
		-- Receiving Terminate keystring: The data you are receiving has all been sent.
		elseif string.find(what, RECIPEBOOK_MESSAGE_TERMINATE) and RecipeBookMessenger_GetName() == who then			
			RecipeBook_Debug("Message: Terminate for "..who);
			-- Prepare to write data
			if(RecipeBookData[Realm][Faction]["Shared"][who] == nil) then RecipeBookData[Realm][Faction]["Shared"][who] = {} end;
			if RecipeBookMasterList["Tradeskills"][RecipeBookMessenger_GetTradeskill()] == nil then RecipeBookMasterList["Tradeskills"][RecipeBookMessenger_GetTradeskill()] = {} end;
			-- Write received tradeskill data.
			RecipeBookData[Realm][Faction]["Shared"][who][RecipeBookMessenger_GetTradeskill()] = RB_ReceivedData;
			-- Write received Materials data
			table.foreach(RB_ReceivedMaterials, function(a,b) RecipeBookMasterList["Tradeskills"][RecipeBookMessenger_GetTradeskill()][a] = b end );
			-- Write received Links data
			table.foreach(RB_ReceivedLinks, function(a,b) if RecipeBookMasterList["Links"][a] == nil then RecipeBookMasterList["Links"][a] = b end end);
			-- Acknowledge data has been received and reset received variables
			RecipeBook_Print(format(RECIPEBOOK_ERROR_RECEIVED, RecipeBookMessenger_GetTradeskill(), RecipeBookMessenger_GetName()), 0);
			SendRBMessage(who, RECIPEBOOK_MESSAGE_ACKNOWLEDGE);
			RB_ReceivedData, RB_ReceivedMaterials, RB_ReceivedLinks = {},{},{};
			RB_SessionActive = false; -- And close session
			
		--Receiving Autodecline keystring: You are on someone's auto-decline list.
		elseif string.find(what, RECIPEBOOK_ERROR_AUTODECLINE) and RecipeBookMessenger_GetName() == who then
			RecipeBook_Debug("Message: Autodecline for "..who);
			local regex = '.+' .. RECIPEBOOK_ERROR_AUTODECLINE .. '(%w+)';
			whatskill = string.gsub(what, regex, "%1");
			RecipeBook_Print(who..RECIPEBOOK_ERROR_AUTODECLINE..whatskill, 1);
			StaticPopup_Hide("RECIPEBOOK_AWAITING_SEND"); 
			RB_SessionActive = false;
			
		--Receiving Cancel keystring: The sender/recipient has cancelled the RecipeBook share.
		elseif string.find(what, RECIPEBOOK_MESSAGE_CANCEL) and RecipeBookMessenger_GetName() == who then
			RecipeBook_Debug("Message: Cancel for "..who);
			RecipeBook_Print(format(RECIPEBOOK_ERROR_CANCEL, who), 1);
			if (RB_SessionActive[1] == "Send"  or RB_SessionActive[1] == "Queue") then 
				StaticPopup_Hide("RECIPEBOOK_AWAITING_SEND"); 
			else 
				StaticPopup_Hide("RECIPEBOOK_REQUESTING_SEND");
			end
			RB_SessionActive = false;
			
		--Do nothing on an acknowledge receipt
		elseif string.find(what, RECIPEBOOK_MESSAGE_ACKNOWLEDGE) then 
			RecipeBook_Debug("Message: Acknowledge for "..who);

		-- Stored Data acknowledgment is important, however.
		elseif string.find(what, "*** Stored Data! ***") then
			-- RecipeBookMessenger_CountdownFrame:Hide();
			RecipeBook_Debug("Continuing Data.");
		
		--Anything else is potential data.
		elseif RecipeBookMessenger_GetSessionType() == "Receive" and RecipeBookMessenger_GetName() == who then
			-- RecipeBook_Debug("Message: Potential Data for "..who);
			RecipeBookMessenger_ProcessData(who, what);
		end
			
	-- Sending data
	elseif(event == "CHAT_MSG_WHISPER_INFORM") then
		RecipeBook_Debug("Data send: <"..what.."> to "..who);
		RB_LastParsedMessage = what;
	end
end


--=================== Functions that deal with INCOMING messages =====================--

--[ ProcessData : When RecipeBook data is received, parses out Rank/Specialty information and then stores recipes. ]--
function RecipeBookMessenger_ProcessData(who, what)
	local regex = '%[' ..RECIPEBOOK_MESSAGE_TRIGGER_WORD .. '%] ' .. '(.+)';
	what = string.gsub(what, regex, "%1");
	RecipeBook_Debug(what);
	-- Rank
	if(string.sub(what, 1, 4) == "Rank") then
		RB_ReceivedData.Rank = tonumber(string.sub(what, 7));
	-- Specialty data
	elseif(string.sub(what, 1, 9) == "Specialty") then
		RB_ReceivedData.Specialty = string.sub(what, 12);
	-- Subspecialty data (armorsmith, etc)
	elseif(string.sub(what, 1, 12) == "subSpecialty") then
		RB_ReceivedData.subSpecialty = string.sub(what, 15);
	-- This is the complex part where you parse out all the materials and links for full sharing.
	else
		-- Begin recipe data for item A ("Start Data: item"; LastParsedRecipe = {item, ""}_
		if string.find(what, "Start Data: ") then
			RB_LastParsedRecipe = {string.sub(what, 13), ""};
		-- Recipe difficulty for item A ("Difficulty: trivial|easy|etc"; LastParsedRecipe = {item, difficulty})
		elseif string.find(what, "Difficulty: ") then
			RB_LastParsedRecipe[2] = string.sub(what, 13);
		-- Begin materials data for item A ("*** Start Materials ***"; LastParsedMaterials = {item, "", {})
		elseif what == "*** Start Materials ***" then
			if RB_LastParsedRecipe == {} then return end;
			RB_LastParsedMaterials = {RB_LastParsedRecipe[1], "", {}}; -- Name, ID, Materials list
		-- Item ID for item A ("ID: id"; LastParsedMaterials = {item, iid, {})
		elseif string.find(what, "ItemID: ") then
			RB_LastParsedMaterials[2] = string.sub(what, 9);
		-- ID link for Item A ("ItemLink: ilink"; ReceivedLinks[iid] = ilink)
		elseif string.find(what, "ItemLink: ") then
			RecipeBook_Debug(string.sub(what, 11));
			RB_ReceivedLinks[RB_LastParsedMaterials[2]] = string.sub(what, 11);
		-- Materials data for Item A ("Material (n) mid"; LastParsedMaterials = {item, iid, {[mid] = n, [mid] = n})
		elseif string.find(what, "MatID: ") then
			local _,b,matnum = string.find(what, "MatID%: %(([%d]+)%) ");
			RB_LastParsedMaterials[3][string.sub(what, b+1)] = tonumber(matnum);
		-- ID link for materials ("Matlink: mid = mlink"; ReceivedLinks[mid] = mlink)
		elseif string.find(what, "MatLink: ") then
			local _,b,matid = string.find(what, "MatLink: ([%w%d%:]+) = ");
			RB_ReceivedLinks[matid] = string.sub(what, b+1);
		-- End materials data for item A; write materials data and reset variable
		elseif what == "*** End Materials ***" then
			if RB_LastParsedMaterials == {} then return end;
			RB_ReceivedMaterials[RB_LastParsedMaterials[1]] = {["ID"] = RB_LastParsedMaterials[2], ["Materials"] = RB_LastParsedMaterials[3]};
			RB_LastParsedMaterials = {};
		-- End recipe data for item A; write recipe data and reset variable
		elseif what == "*** End Data ***" then
			RB_ReceivedData[RB_LastParsedRecipe[1]] = RB_LastParsedRecipe[2];
			RB_LastParsedRecipe = {};
			SendRBMessage(who, "*** Stored Data! ***");
		-- Acknowledgment and ready to send the next batch.
		else --Backwards compatibility.
			RB_ReceivedData[string.sub(what, 3)] = "shared";
		end		
	end
end


--=================== Functions that deal with SESSION INITIATION AND TERMINATION messages =====================--
--[ KillSession() : Kills the RecipeBook Session. ]--
function RecipeBookMessenger_KillSession()
	RB_SessionActive = false; 
	RecipeBook_Print("Session Killed.", 0);
end

--[ InitiateSession (sendto, tradeskill to send) : Initiates RecipeBook sharing.  Aww, how nice. ]--
function RecipeBookMessenger_InitiateSession(who,what, alt)
	local Realm, Faction, OtherFaction, Player = RecipeBook_GetGlobals();
	if alt == nil then alt = Player end;
	if who == Player then return RecipeBook_Print(RecipeBookSearch_MATCHEDSELF, 1) end;
-- 	if what == "All-alts" then 
-- 		RB_CharacterQueue = {};
-- 		-- Recursively add in each alt to send
-- 		table.foreach(RecipeBookData[Realm][Faction]["Personal"], function(a,b) table.insert(RB_CharacterQueue, a) end);
-- 		-- If queue exists, begin recursive queueing
-- 		if table.getn(RB_CharacterQueue) > 0 then
-- 			RecipeBookMessenger_InitiateSession(who, "CQueue");
-- 			StaticPopup_Show("RECIPEBOOK_AWAITING_SEND");
-- 		end
	if what == "All" then
		RB_SessionQueue = {};
		-- Recursively add in each tradeskill to send
		table.foreach(RecipeBookData[Realm][Faction]["Personal"][alt], function(a,b) table.insert(RB_SessionQueue, a) end);
		-- If queue exists, begin recursive sending
		if table.getn(RB_SessionQueue) > 0 then 
			RecipeBookMessenger_InitiateSession(who, "Queue", alt);
			StaticPopup_Show("RECIPEBOOK_AWAITING_SEND");
		end
	elseif what == "Queue" then
		-- Pick the first skill and queue it for sending, then remove it from the queue.
		what = RB_SessionQueue[1];
		table.remove(RB_SessionQueue, 1);
		-- Continue queued sessions until no more are queued.
		if table.getn(RB_SessionQueue) < 1 then
			RB_SessionActive = {"Send", what, who, false}
		else
			RB_SessionActive = {"Queue", what, who, false};
		end
		SendRBMessage(who, RECIPEBOOK_MESSAGE_INITIATE..what);
		RecipeBook_Print(format(RECIPEBOOK_ERROR_INITIATE, what, who), 0);
-- 	elseif what == "CQueue" then
-- 		alt = RB_CharacterQueue[1];
-- 		RB_SessionQueue = {};
-- 		table.foreach(RecipeBookData[Realm][Faction]["Personal"][alt], function(a,b) table.insert(RB_SessionQueue, a) end);
-- 		if table.getn(RB_SessionQueue) > 0 then 
-- 		-- Pick the first skill and queue it for sending, then remove it from the queue.
-- 			what = RB_SessionQueue[1];
-- 			table.remove(RB_SessionQueue, 1);
-- 			if table.getn(RB_CharacterQueue) < 1 then 
-- 				RB_SessionActive = {"Queue", what, who, false};
-- 			end
--		end
--	StaticPopup_Show("RECIPEBOOK_AWAITING_SEND");
	elseif(RecipeBookData[Realm][Faction]["Personal"][alt][what] ~= nil) then 
		SendRBMessage(who, RECIPEBOOK_MESSAGE_INITIATE..what);
		RecipeBook_Print(format(RECIPEBOOK_ERROR_INITIATE, what, who), 0);
		RB_SessionActive = {"Send", what, who, false};
		StaticPopup_Show("RECIPEBOOK_AWAITING_SEND");
	else
		return RecipeBook_Print(RECIPEBOOK_NOTRADESKILLMATCH..what, 1);
	end
end

--[ ConditionalAcceptance(sendfrom, tradeskill, accept options) : Accepts, declines, or prompts for acceptance depending on who's sending the data ]--
function RecipeBookMessenger_ConditionalAcceptance(who, what, option)
	RecipeBook_Debug("Conditional on option: "..option);
	local function RB_AcceptByOption(o)
		if o == "A" then 
			RecipeBook_Print(string.format(RECIPEBOOK_ERROR_ACCEPTEDSESSION, who, what), 0);
			RecipeBookMessenger_AcceptSession(who, what);
		elseif o == "D" then 
			RecipeBookMessenger_CancelSession(who, what, "decline");
		else
			RB_SessionActive = {"Pending", what, who, false};
			StaticPopup_Show("RECIPEBOOK_REQUESTING_SEND");
		end
	end
	
	if option == "fPgPoP" then
		RB_AcceptByOption("P");
	elseif option == "fAgAoA" then
		RecipeBook_Print(format(RECIPEBOOK_ERROR_ACCEPTEDSESSION, who, what), 0);
		RecipeBookMessenger_AcceptSession(who, what);
	elseif option == "fDgDoD" then
		RecipeBookMessenger_CancelSession(who, what, "decline");
	else
		--friends first:
		local n;
		local friend = false;
		for n = 1, GetNumFriends() do
			if GetFriendInfo(n) == who then 
				friend = true;
				break;
			end
		end
		if friend then  --friend?
			RB_AcceptByOption(string.sub(option, 2,2));
		elseif (IsInGuild()) then--Guild member?
			GuildRoster();
			friend = false;
			for n = 1, GetNumGuildMembers() do
				if GetGuildRosterInfo(n) == who then
					friend = true;
					break;
				end
			end
			if friend then
				RB_AcceptByOption(string.sub(option, 4,4));
			else --not a guildmate
				RB_AcceptByOption(string.sub(option, 6,6));
			end
		else --Not guilded; no roster to scan.
			RB_AcceptByOption(string.sub(option, 6,6));
		end
	end
end

--[ AcceptSession (sendfrom, tradeskill) : Accepts the offered RB share ]--
function RecipeBookMessenger_AcceptSession(who, what)
	SendRBMessage(who, RECIPEBOOK_MESSAGE_ACCEPT..what);
	SendRBMessage(who, RECIPEBOOK_VERSION);
	RB_ReceivedData = {};
	RB_SessionActive = {"Receive", what, who, false};
end

--[ CancelSession : Sends a terminate request that does NOT write data ]--
function RecipeBookMessenger_CancelSession(who, whatskill, what)
	if(what == "decline") then
		SendRBMessage(who, UnitName("player")..RECIPEBOOK_ERROR_AUTODECLINE..whatskill);
		RecipeBook_Print(RECIPEBOOK_ERROR_DECLINEDSESSION..who, 0)
	else
		SendRBMessage(who, RECIPEBOOK_MESSAGE_CANCEL..whatskill);
		RecipeBook_Print(RECIPEBOOK_ERROR_CANCEL, 1);
	end
	RB_SessionActive = false;
end

--[ TerminateSession : Sends a terminate request that initiates a data write ]--
function RecipeBookMessenger_TerminateSession(who, what)
	SendRBMessage(who, RECIPEBOOK_MESSAGE_TERMINATE..what);
	if RB_SessionActive[1] == "Queue" then
		RecipeBookMessenger_InterSkillFrame:Show();
		RecipeBookMessenger_CountdownFrame.listinuse = {{}, "nobody", "noskill"};
		RecipeBook_Print(RECIPEBOOK_ERROR_QUEUETERMINATE, 0);
	else
		RB_SessionActive = false;
		RecipeBookMessenger_CountdownFrame.listinuse = {{}, "nobody", "noskill"};
		RecipeBook_Print(RECIPEBOOK_ERROR_TERMINATE, 0);
	end
end


--=================== Functions that deal with OUTGOING messages =====================--

--[ SendRBMessage : Sends a RecipeBook-marked chat message. ]--
function SendRBMessage(who, text)
	SendChatMessage(RECIPEBOOK_MESSAGE_TRIGGER.." "..text, "WHISPER", this.language, who);
end

--[ SendData : Sends tradeskill data for a given tradeskill ]--
function RecipeBookMessenger_SendData(who, what)
	local recipelist, rank, skillspecs = RecipeBookMessenger_TradeskillList(what);
	-- recipelist = { {item, difficulty, item ID , item Link, {{mid, n, mlink}, {mid, n, mlink}, ... }, ... }
	SendRBMessage(who, "Rank: "..rank);
	if skillspecs[1] ~= nil then
		SendRBMessage(who, "Specialty: "..skillspecs[1]);
		if skillspecs[2] ~= nil then
			SendRBMessage(who, "subSpecialty: "..skillspecs[2]);
		end
	end
	RecipeBook_Debug("Beginning batch data send, length: "..table.getn(recipelist));
	RecipeBookMessenger_SendDataBatch(recipelist, who, what, 0);
end

--[ SendDataBatch : Batches data so that spam protection doesn't kick in. ]--
-- Format for recipelist:
-- { {item, difficulty, item ID , item Link, {{mid, n, mlink}, {mid, n, mlink}, ... }, ... }
function RecipeBookMessenger_SendDataBatch(recipelist, who, what, offset)
	local length = table.getn(recipelist) - offset;
	if length < 0 then 
		RecipeBookMessenger_TerminateSession(who, what);
	elseif length < (RECIPEBOOK_BATCHLENGTH +1) then
		RecipeBook_Debug("Beginning final data batch share");
		for index=1+offset,length+offset, 1 do
			if(recipelist[index] ~= nil) then 
				if RB_SessionActive[4] then -- Receiving end is compatible.
					RecipeBookMessenger_SendSingleItem(who, recipelist[index]);
				else -- old version.
					SendRBMessage(who, ": "..recipelist[index][1]);
				end
			end
		end
		RecipeBookMessenger_SendDataBatch({}, who, what, 1);
	else
		RecipeBook_Debug("Sending "..RECIPEBOOK_BATCHLENGTH.." data items.");
		for i = 1+offset, RECIPEBOOK_BATCHLENGTH+offset, 1 do
			if RB_SessionActive[4] then -- Receiving end is compatible.
				RecipeBookMessenger_SendSingleItem(who, recipelist[i]);
			else -- old version.
				SendRBMessage(who, " : "..recipelist[i][1]) 
			end
		end
		offset = offset + RECIPEBOOK_BATCHLENGTH;
		RecipeBook_Debug("Pausing.");
		RecipeBookMessenger_CountdownFrame:Show();
		RecipeBookMessenger_CountdownFrame.listinuse = {recipelist, who, what, offset};
	end
end

-- SendSingleItem(item): Parses data and sends it appropriately.
function RecipeBookMessenger_SendSingleItem(who, item)
	local what, difficulty, id, link, matlist = unpack(item);
	SendRBMessage(who, "Start Data: "..what);
	SendRBMessage(who, "Difficulty: "..difficulty);
	SendRBMessage(who, "*** Start Materials ***");
	SendRBMessage(who, "ItemID: "..id);
	SendRBMessage(who, "ItemLink: "..link);
	local function parsemats(temp,mats)
		SendRBMessage(who, "MatID: ("..mats[2]..") "..mats[1]); --n, mid
		SendRBMessage(who, "MatLink: "..mats[1].." = "..mats[3]); --mid = mlink
	end
	table.foreach(matlist, parsemats);
	SendRBMessage(who, "*** End Materials ***");
	SendRBMessage(who, "*** End Data ***");
end

-- CountdownUpdate(elapsed) : Keeps track of the countdown timer for spam protection.
function RecipeBookMessenger_CountdownUpdate(elapsed, delay)
	if this.timeSinceLastUpdate == nil then this.timeSinceLastUpdate = 0 end;
	this.timeSinceLastUpdate = this.timeSinceLastUpdate + elapsed; 	
	if (this.timeSinceLastUpdate > delay) then    
		this.timeSinceLastUpdate = 0;
		this:Hide();
	end
end

-- -- SendDelayUpdate(elapsed) : Keeps track of the countdown timer so initiation is accurate.
-- function RecipeBookMessenger_SendDelayUpdate(elapsed)
-- 	if this.timeSinceLastUpdate == nil then this.timeSinceLastUpdate = 0 end;
-- 	this.timeSinceLastUpdate = this.timeSinceLastUpdate + elapsed; 	
-- 	if (this.timeSinceLastUpdate > RECIPEBOOK_INITIAL_PAUSE) then    
-- 		this.timeSinceLastUpdate = 0;
-- 		this:Hide();
-- 	end
-- end


--=================== Functions that return data only =====================--

--[ GetName : Returns the name of the player on the other end of the session ]--
function RecipeBookMessenger_GetName()
	if(RB_SessionActive) then return RB_SessionActive[3] else return "No Player" end;
end

--[ GetTradeskill : Returns the name of the tradeskill currently being shared ]--
function RecipeBookMessenger_GetTradeskill()
	if(RB_SessionActive) then return RB_SessionActive[2] else return "No Tradeskill" end;
end

--[ GetSessionType : Returns the type of session currently active. ]--
function RecipeBookMessenger_GetSessionType()
	if(RB_SessionActive) then return RB_SessionActive[1] else return "No Active Session" end;
end

--[ TradeskillList : Collects the recipe list, specialties, materials and ranks for the player and returns in a format RecipeBook can send.  No longer redundant. ]--
-- Format for recipelist:
-- { {item, difficulty, item ID , item Link, {{mid, n, mlink}, {mid, n, mlink}, ... }, ... }
function RecipeBookMessenger_TradeskillList(what)
	local Realm, Faction, OtherFaction, Player = RecipeBook_GetGlobals();
	if (what == "") then return RecipeBook_Print(RECIPEBOOK_NOTRADESKILLGIVEN, 1) end
	if (RecipeBookData[Realm][Faction]["Personal"][Player][what] == nil) then return RecipeBook_Print(RECIPEBOOK_NOTRADESKILLMATCH..what, 1) end;

	local recipelist, rank, skillspecs = {}, 0, {};
	rank = tonumber(RecipeBookData[Realm][Faction]["Personal"][Player][what]["Rank"]);
	if RecipeBookData[Realm][Faction]["Personal"][Player][what]["Specialty"] then
		skillspecs = {RecipeBookData[Realm][Faction]["Personal"][Player][what]["Specialty"], (RecipeBookData[Realm][Faction]["Personal"][Player][what]["SubSpecialty"] and RecipeBookData[Realm][Faction]["Personal"][Player][what]["SubSpecialty"] or nil)};
	end
	
	local function recipemats(item, difficulty)
		--item, difficulty passed
		local n,mid,mlink;
		if string.find("Rank Specialty SubSpecialty", item) then return nil end;
		if RecipeBookMasterList["Tradeskills"][what][item] == nil then 
			table.insert(recipelist, {item, difficulty, "", "", {}}) 
		else
			local materials = {};
			table.foreach(RecipeBookMasterList["Tradeskills"][what][item]["Materials"], function(a,b) table.insert(materials, {a, b, RecipeBookMasterList["Links"][a]}) end );
			table.insert(recipelist, {item, difficulty, RecipeBookMasterList["Tradeskills"][what][item]["ID"], RecipeBookMasterList["Links"][RecipeBookMasterList["Tradeskills"][what][item]["ID"]], materials});
		end
	end

	table.foreach(RecipeBookData[Realm][Faction]["Personal"][Player][what], recipemats)
	if (recipelist ~= nil)  then return recipelist, rank, skillspecs else return {} end;
end

