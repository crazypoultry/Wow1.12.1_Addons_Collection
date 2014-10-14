--[[
	The SW Sync Channel
	V 2.0 
]]--

-- seperates totally different sync messages that could be packed into one send
SW_SYNC_MSG_SEP = string.char(29);
-- seperates different parts of one sync msg
SW_SYNC_SEP = string.char(30); 
-- seperates SW_SYNC_SESSION from the rest of the message
SW_SYNC_ID_SEP = string.char(31); 

SW_SplitSendRegEx = "[^"..SW_SYNC_MSG_SEP.."]+";
SW_SplitMsgRegEx = "[^"..SW_SYNC_SEP.."]+";
SW_SyncSessRegEx = "(%d+)"..SW_SYNC_ID_SEP.."(.+)";

-- there is no real point to sync npc data from enUS client to deDE client
-- SW_CHAN_LOCALE = "SWS"..GetLocale().."f";
-- useing peerinfo locale instead
SW_RPOST = false;

-- this is set to false if the parser couldn't init correctly
-- or if FixLogStrings wasn't loaded (enUS and enGB may turn off FixLogStrings and still sync)
SW_SYNC_DO = true;

-- updated in SW_C_DataCollection:checkGroup();
SW_SYNC_TO_USE = nil;
--SW_SYNC_TO_USE = "GUILD"; -- for testing

-- time to wait until handshaking to be done in seconds
SW_WAIT_HS_SEC = 10;

-- this maps object "id's" used in sync  and done recieved to the functions to get the data
-- right now this is only the basic unit data
SW_UD_Map = {
	BUDD = SW_C_UnitData.getBasicDataDone,
	BUDR = SW_C_UnitData.getBasicDataRecieved
}
-- the sync msgs to be used in string.format 
-- name, serialized table
SW_BU_STR_Done= "BUDD"..SW_SYNC_SEP.."%s"..SW_SYNC_SEP.."%s";
SW_BU_STR_Recieved = "BUDR"..SW_SYNC_SEP.."%s"..SW_SYNC_SEP.."%s";

SW_HS_STR_Start = "S";
-- client language, SW_version, ms in channel (rounded ), thinksSM (0 or 1)
SW_HS_STR_Self = "SI"..SW_SYNC_SEP.."%s"..SW_SYNC_SEP.."%s"..SW_SYNC_SEP.."%g"..SW_SYNC_SEP.."%d";

local SW_SyncMsgBuffer = {};
SW_SyncOneBUDelta = SW_C_BasicUnitData:new();

-- used to filter out "old" messages
SW_SYNC_SESSION = 1;
SW_SESSFORMAT = "%d"..SW_SYNC_ID_SEP.."%s";

-- called when a new segment is to be created, 
-- and the sync segements are to be reset(the reset has to be already verified)
function SW_SyncReset(newSessID, newName)
	if not newName then
		newName = SW_DS_RESET;
	end
	SW_SyncQueue:Clear();
	SW_DataCollection:initForSync(newName);
	SW_SYNC_SESSION = newSessID;
	SW_DPS_Dmg = 0;
	SW_CombatTime = 0;
end

-- sending this is ignored by all in sync if sender isn't A or L
function SW_SendSyncReset(newName)
	if not newName then
		newName = SW_DS_RESET;
	end
	SW_SyncReset(SW_SYNC_SESSION + 1, newName);
	SW_SyncSendHS("RE"..SW_SYNC_SEP..newName);
end
-- this is ignored by all in sync if sender isn't A or L
function SW_SyncSendARP(allow)
	if allow then
		SW_SyncSendHS("SARP"..SW_SYNC_SEP..1);
	else
		SW_SyncSendHS("SARP"..SW_SYNC_SEP..0);
	end
end

function SW_SyncSendHS(msg)
	
	if not SW_SYNC_DO then return; end
	local val = string.format(SW_SESSFORMAT,SW_SYNC_SESSION,msg);
	if val then
		--SW_printStr("SW_SyncSendHS:"..val);
		SendAddonMessage(SW_CHAN_HS, val, SW_SYNC_TO_USE);
	end
end

SW_SyncState ={
	currentSM = nil,
	HSDone = nil,
	HSStarted = nil,
	peerInfo = {},
	peerLookup = {},
	syncStart = GetTime(),
	isSelfMaster = nil,
	
	-- name sent a message
	peerTick = function(self, name)
		local pInfo = self.peerLookup[name];
		if not pInfo then
			pInfo = self:addPeerInfo(name);
		end
		pInfo.lastTick = GetTime();
	end,
	--a peer sent his meta info time in channel client language version etc
	setPeerInfo = function (self, name, msg)
		local pInfo = self.peerLookup[name];
		if not pInfo then
			pInfo = self:addPeerInfo(name);
		end
		pInfo:setData(msg, name);
	end,
	getPeerInfo = function (self, name)
		local pInfo = self.peerLookup[name];
		if not pInfo then
			pInfo = self:addPeerInfo(name);
			if name == SW_SELF_STRING then
				pInfo.locale = GetLocale();
				pInfo.version = SW_VERSION;
				pInfo.thinksSM = 0;
			end
		end
		return pInfo;
	end,
	addPeerInfo = function (self, name)
		local po = SW_C_PeerInfo:new();
		table.insert(self.peerInfo, po);
		
		self.peerLookup[name] = po;
		return po;
	end,
	--[[
	updateSM = function (self)
		self.currentSM = nil;
		local SMName;
		
		for k,v in pairs(self.peerLookup) do
			if not self.currentSM or self.currentSM.joinedAt < v.joinedAt then
				self.currentSM = v;
				SMName = k;
			end
		end
		if SMName == SW_SELF_STRING then
			self.currentSM.thinksSM = 1;
			self.isSelfMaster = true;
		else
			self:getPeerInfo(SW_SELF_STRING).thinksSM = 0;
			self.isSelfMaster = nil;
		end
		
	end,
	--]]
	setInSync = function (self)
		local sID = 0;
		local meta;
		if not SW_SYNC_TO_USE then
			self:reset();
			return;
		end	
		--SW_printStr("setInSync");
		for i=1, table.getn(self.peerInfo) do
			table.remove(self.peerInfo);
		end
		for k,v in pairs(self.peerLookup) do
			meta = SW_DataCollection.meta.currentGroup[k];
			if meta and UnitIsConnected(meta.uID) then
				table.insert(self.peerInfo, v);
			else
				self.peerLookup[k] = nil;
			end
		end
		if SW_BarSyncFrame:IsVisible() then
			SW_SyncList_ScrollUpdate();
		end
		--[[
		for k,v in pairs(self.peerLookup) do
			meta = SW_DataCollection.meta.currentGroup[k];
			if not meta or not UnitIsConnected(meta.uID) then
				for i=1, table.getn(self.peerInfo) do
					if self.peerInfo[i] == v then
						table.remove(self.peerInfo[i]);
						self.peerLookup[k] = nil;
						break;
					end
				end
			end 
		end
		--]]
	end,
	reset = function (self)
		self.peerInfo.n = 0;
		for k,v in pairs(self.peerLookup) do
			self.peerLookup[k] = nil;
		end
		self.syncStart = GetTime();
		self.currentSM = nil;
		self.HSDone = nil;
		self.HSStarted = nil;
		self.isSelfMaster = nil;
		self.lastTick = nil;
	
	end,
};
SW_C_PeerInfo = {

	new = function (self, o)
		if not  o then
			o = {};
		end
		
		setmetatable(o, self);
		self.__index = self;
		
		return o;
	end,
	
	getMsg = function(self, pattern)
		local secs = math.floor((GetTime() - SW_SyncState.syncStart) * 100 + 0.5) / 100;
		if secs < 0 then secs = 0; end
		if not self.locale then
			self.locale = GetLocale();
		end
		if not self.version then
			self.version = SW_VERSION;
		end
		if not self.thinksSM then
			self.thinksSM = 0;
		end
		return string.format(pattern, self.locale, self.version, secs, self.thinksSM)
	end,
	setData = function (self, msg, name)
		self.locale = msg[2];
		self.version = msg[3];
		self.joinedAt = GetTime() - msg[4];
		self.name = name;
		if msg[5] == 1 then
			self.thinksSM = 1;
		else
			self.thinksSM = 0;
		end
	end,
	reset = function (self)
		self.locale = "";
		self.version = "";
		self.thinksSM = 0;
		self.lastTick = nil;
		self.joindAt = nil;
		self.name = "";
	end,
}
function SW_SyncDo()
	
	if not (SW_SYNC_DO and SW_SYNC_TO_USE) then
		return;
	end
	if not SW_SyncState.HSDone then
		if SW_SyncState.HSStarted then
			if GetTime() - SW_SyncState.HSStarted > SW_WAIT_HS_SEC then		
				--SW_SyncState:updateSM();
				SW_SyncState.HSDone = true;
			end
		else
			-- if we need a handshake something happened make sure the Data collection is ready
			SW_DataCollection:initForSync();
			--SW_BarFrame1_Title_SyncIcon:Show();
			SW_SyncSendHS(SW_HS_STR_Start);
			SW_SyncState.HSStarted = GetTime();
		end
		return;
	end
	
	local pc = table.getn(SW_SyncState.peerInfo);
	
	if pc < 2 then 
		if SW_BarFrame1_Title_SyncIcon:IsVisible() then
			SW_BarFrame1_Title_SyncIcon:Hide();
			SW_ToggleRunning(SW_Settings.IsRunning);
		end
		return; -- don't sync while alone in Sync
	else
		-- we have peers
		if not SW_BarFrame1_Title_SyncIcon:IsVisible() then
			SW_BarFrame1_Title_SyncIcon:Show();
			SW_ToggleRunning(true);
		end
	end
	
	
	local syncP = 0;
	--auto% when to sync 
	if pc > 5 then
		syncP = math.ceil( (100 / pc) / 2 );
	else 
		syncP = 10;
	end
	
	-- do self
	SW_SyncDoOneUnit(SW_StrTable:getID(SW_SELF_STRING), SW_SELF_STRING);
	
	local syncedDS, compSyncDS = SW_DataCollection:getSyncDS();
	local tmpName;
	for k,v in pairs(compSyncDS) do
		rnd = math.random(100);
		if rnd <= syncP and type(k) =="number" then
			tmpName = SW_StrTable:getStr(k);
			if not SW_SyncState.peerLookup[tmpName] then
				SW_SyncDoOneUnit(k, tmpName);
			end
		end
	end
end

function SW_SyncDoOneUnit(sID, uName, isHS)
	if not sID then return; end
	local syncedDS, compSyncDS = SW_DataCollection:getSyncDS();
	local syUnit = syncedDS[sID];
	local compUnit = compSyncDS[sID];
	if not compUnit then return; end
	local compBasicUnit = compUnit:getBasicDataDone();
	local serializedStr;
	
	if not syUnit then
		syUnit = SW_C_UnitData:new();
		syncedDS[sID] = syUnit;
		syUnit:assureSource();
		syUnit:assureRecieved();
	end
	
	local syBasicUnit = syUnit:getBasicDataDone();
	
	if compBasicUnit then
		if isHS then
			serializedStr = compBasicUnit:serialize();
			if serializedStr then
				SW_SyncSendHS(string.format(SW_BU_STR_Done, uName, serializedStr));
			else
				SW_printStr(uName.." Couldn't HS sync Done because of encoder fail");
			end
		else
			if not syBasicUnit then
				syUnit:assureSource();
				syBasicUnit = syUnit:getBasicDataDone();
			end
			if syBasicUnit < compBasicUnit then
				serializedStr = compBasicUnit:serialize();
				if serializedStr then
					SW_SyncQueue:PushVal(string.format(SW_BU_STR_Done, uName, serializedStr));
				else
					SW_printStr(uName.." Couldn't sync Done because of encoder fail");
				end
				
			end
		end
	end
	
	compBasicUnit = compUnit:getBasicDataRecieved();
	if compBasicUnit then
		if isHS then
			serializedStr = compBasicUnit:serialize();
			if serializedStr then
				SW_SyncSendHS(string.format(SW_BU_STR_Recieved, uName, serializedStr));
			else
				SW_printStr(uName.." Couldn't HS sync Recieved because of encoder fail");
			end
			-- noticed this while working on the large number sync bug.. what utter bs, slaps forehead
			--SendAddonMessage(SW_CHAN_HS, SW_SyncQueue:PushVal(string.format(SW_BU_STR_Recieved, uName, compBasicUnit:serialize())), SW_SYNC_TO_USE);
		else
			syBasicUnit = syUnit:getBasicDataRecieved();
			if not syBasicUnit then
				syUnit:assureRecieved();
				syBasicUnit = syUnit:getBasicDataRecieved();
			end
			if syBasicUnit < compBasicUnit then
				serializedStr = compBasicUnit:serialize();
				if serializedStr then
					SW_SyncQueue:PushVal(string.format(SW_BU_STR_Recieved, uName, serializedStr));
				else
					SW_printStr(uName.." Couldn't sync Recieved because of encoder fail");
				end
			end
		end
	end
	
end

function SW_SyncSend()
	local toSend = SW_SyncQueue:PopBlock();
	if toSend and SW_SYNC_DO then
		--SW_printStr(toSend);
		SendAddonMessage(SW_CHAN_MAIN, toSend, SW_SYNC_TO_USE);
	end
end

function SW_CheckSender(from)
	local meta = SW_DataCollection.meta.currentGroup[from];
	local name, rank, index;
	if meta then
		meta = SW_DataCollection.meta[meta.sID];
		if not meta or meta.rank < 1 then return; end
	else
		--2.0 beta.6 added an extra check just in case
		if GetNumRaidMembers() > 0 then
			for i=1,40 do
				name, rank = GetRaidRosterInfo(i);
				if name and rank and name == from and rank > 0 then
					return true;
				end
			end
		elseif GetNumPartyMembers() > 0 then
			index = GetPartyLeaderIndex();
			if index and index > 0 then
				if from == (UnitName("party"..index)) then
					return true;
				end
			else
				return IsPartyLeader();
			end
		end
		return;
	end
	return true;
end
function SW_CheckIncReset(msg, from)
	local i = 0;
	for tmp in SW_gmatch(msg, SW_SplitMsgRegEx) do
		i = i + 1;
		SW_SyncMsgBuffer[i] = tmp;	
	end
	SW_SyncMsgBuffer.n = i;
	if SW_SyncMsgBuffer[1] ~= "RE" then return;	end
	
	return SW_CheckSender(from);
	
end

function SW_DoIncSync(chan, msg, from)
	local _,_, session, data = string.find(msg, SW_SyncSessRegEx);
	session = tonumber(session);
	if not session or not data or (chan ~= SW_CHAN_HS and session < SW_SYNC_SESSION) then
		return;
	end
	
	if session > SW_SYNC_SESSION then
		if not SW_SyncState.HSDone then
			-- while in handshake accept any higher sessions and continue processing
			SW_SYNC_SESSION = session;
		else
			-- check if this is a reset command
			if chan == SW_CHAN_HS then
				if SW_CheckIncReset(data, from) then
					-- do reset
					SW_SyncReset(session, SW_SyncMsgBuffer[2]);
				end
			end
			-- dont't accept higher session ids
			return;
		end 
	end
	
	local i = 1;
	if SW_Settings.EI_ShowSync then
		SW_Event_Channel:AddMessage(date("%c").." MSG from "..from.." ---- Session: "..session);
	end
	for oneMsg in SW_gmatch(data, SW_SplitSendRegEx) do
		i = 0;
		for tmp in SW_gmatch(oneMsg, SW_SplitMsgRegEx) do
			i = i + 1;
			SW_SyncMsgBuffer[i] = tmp;	
		end
		
		SW_SyncMsgBuffer.n = i;
		if chan == SW_CHAN_MAIN and SW_SyncState.HSDone then
			SW_SyncState:peerTick(from);
			SW_HandleOneMsg(from);
		elseif chan == SW_CHAN_HS then
			SW_HandleHandshake(from);
		end
	end
	
end

function SW_HandleHandshake(from)
	local disp = true;
	-- 2.0 beta.5 people not in sync would answer to this aswell (clients that turned off sw fixlogstrings and are non us versions)
	-- resulting in "large numbers" due to them not accepting sync resets if somebody else drops
	-- wow finding this was a pain in the...
	if not SW_SYNC_DO then return; end
	
	if SW_SyncMsgBuffer[1] == "S" then
		-- this will create quite some spam during startup of a raid but will settle quickly
		-- but it's needed to bring newcomers up to date (they dropped or came late)
		SW_SyncSendHS(SW_SyncState:getPeerInfo(SW_SELF_STRING):getMsg(SW_HS_STR_Self));
		SW_SyncDoOneUnit(SW_StrTable:getID(from), from, true);
		SW_SyncDoOneUnit(SW_StrTable:getID(SW_SELF_STRING), SW_SELF_STRING, true);
	elseif SW_SyncMsgBuffer[1] == "SI" then
		SW_SyncState:getPeerInfo(from):setData(SW_SyncMsgBuffer, from);
	elseif SW_SyncMsgBuffer[1] == "VO" then
		SW_SyncHandleVoting(SW_SyncMsgBuffer, from);
	elseif SW_SyncMsgBuffer[1] == "SARP" then
		if SW_CheckSender(from) then
			if tonumber(SW_SyncMsgBuffer[2]) == 1 then
				SW_RPOST = true;
				--SW_printStr("SW_HandleHandshake SW_RPOST true");
			else
				SW_RPOST = false;
				--SW_printStr("SW_HandleHandshake SW_RPOST false");
			end
		else
			SW_printStr("SW_HandleHandshake SARP SW_CheckSender FALSE");
		end
	else 
		disp = false;
		SW_HandleOneMsg(from, true);
	end
	if disp and SW_Settings.EI_ShowSync then
		SW_Event_Channel:AddMessage(" Handshake: "..SW_SyncMsgBuffer[1]);
		for i=2, table.getn(SW_SyncMsgBuffer) do
			SW_Event_Channel:AddMessage(SW_SyncMsgBuffer[i]);
		end
	end
end

-- 2.0 beta.6 tmp turned of the ascii encoding stuff
SW_DecodeBuffer = {};
function SW_HandleOneMsg(from, isHS)
	-- no need to handle all handshaking messages here
	-- if our own handshaking is done
	-- 2.0 beta.5 added the or not SW_SYNC_DO ...ignore handshakes if you aren't aktivly syncing
	if isHS and (SW_SyncState.HSDone or not SW_SYNC_DO) then return; end
	
	local func = SW_UD_Map[ SW_SyncMsgBuffer[1] ];
	if not func then return end;
	
	
	local size = table.getn(SW_SyncMsgBuffer);
	if size < 3 then return; end
	
	local sID = SW_StrTable:getID(SW_SyncMsgBuffer[2]);
	local meta = SW_DataCollection.meta[sID];
	if not (meta and (meta.isPetData or meta.type == "PC")) then
		meta = SW_SyncState.peerLookup[from];
		if not (meta and meta.locale == GetLocale()) then 
			if SW_Settings.EI_ShowSync then
				SW_Event_Channel:AddMessage(" SyncMsg:"..SW_SyncMsgBuffer[1].." for "..SW_SyncMsgBuffer[2].." from "..from);
				SW_Event_Channel:AddMessage("	--> ignored due to locale");
			end
			-- there is no point to add "junk" data through npc data
			-- e.g in english it would be "Bore" in german "Schwein"
			-- why have the data for both 'identical' units
			return;
		end
	end
	
	local syncedDS, compSyncDS = SW_DataCollection:getSyncDS();
	local unitSync = syncedDS[sID];
	local unitIParsed = compSyncDS[sID];
	if not unitSync then
		syncedDS[sID] = SW_C_UnitData:new();
		unitSync = syncedDS[sID];
	end
	if not unitIParsed then
		compSyncDS[sID] = SW_C_UnitData:new();
		unitIParsed = compSyncDS[sID];
	end
	if not SW_DataCollection.activeSegment[sID] then
		SW_DataCollection.activeSegment[sID] = SW_C_UnitData:new();
	end
	local syncedObj = func(unitSync, true);
	local parsedObj = func(unitIParsed, true);
	local activeObj = func(SW_DataCollection.activeSegment[sID], true);
	--local data, datan = SW_IntTblAscii85:decode(SW_SyncMsgBuffer[3]);
	local datan = 0;
	--2.0 beta.6 removed the intbl stuff to isolate if the large numbers come form here
	--SW_printStr(SW_SyncMsgBuffer[3]);
	for tmp in SW_gmatch(SW_SyncMsgBuffer[3], "%d+") do
		datan = datan + 1;
		--SW_printStr(datan..":"..tmp);
		SW_DecodeBuffer[datan] = tonumber(tmp);	
	end
	local data = SW_DecodeBuffer;
	--SW_printStr(datan);
	--SW_DumpTable(data);
	
	syncedObj:setMax(data);
	SW_SyncOneBUDelta:nullify();
	SW_SyncOneBUDelta:setToDelta(parsedObj, data);
	
	-- a self info with a dmg part 2.0 beta.2 fergot this one
	-- 2.0 beta.6 changed this a little, if already in fight allow dmg recieved to keep in fight
	if from == SW_SyncMsgBuffer[2] and not isHS then
		if SW_SyncMsgBuffer[1] == "BUDD" or (SW_RPS.isRunning and SW_SyncMsgBuffer[1] == "BUDR") then
			if SW_SyncOneBUDelta:getDamage() > 0 then
				SW_RPS:validEvent();
			end
		end
		-- the person might be to far away to be added otherwise
		if SW_RPS.isRunning then
			SW_C_DataCollection.involvedInFight[sID] = true;
		end
	end
	if SW_SyncOneBUDelta.hasDeltaVals then
		parsedObj:add(SW_SyncOneBUDelta);
		--if not isHS then -- 2.0.beta.2 have to add the data now the active segment tries to get up to date
		activeObj:add(SW_SyncOneBUDelta);
		--end
	end
	if SW_Settings.EI_ShowSync then
		SW_Event_Channel:AddMessage(" SyncMsg:"..SW_SyncMsgBuffer[1].." for "..SW_SyncMsgBuffer[2]);
		--data = SW_C_BasicUnitData:new(data);
		--data:dump();
		for i=1,datan do
			if data[i] > 0 then
				SW_Event_Channel:AddMessage("   ["..i.."] = "..data[i]);
			end
		end
	end
end

--[[ The sync Queue
	So we dont have to think about timing record length etc
	only thing to consider is that one single message may not be larger then 255 chars
	but we use short strings here anyways
]]--


SW_SyncQueue =
{
	first = 1,
	last =	0,
	maxBlockLen = 245,
	sep = SW_SYNC_MSG_SEP,
	sepLen = 1,
	queue = {},
	clearing = false,
	
	PushVal = function (self, val)
		if string.len(val) > self.maxBlockLen or self.clearing then return false; end
		local last = self.last + 1;
		self.last = last;
		self.queue[last] = val;
		return true;
	end,
	PopStack = function (self)
		if self.clearing then return nil; end
		
		local last = self.last;
		if self.first > last then return nil; end
		local val = self.queue[last];
		self.queue[last] = nil;
		self.last = last - 1;
		return val;
	end,
	Pop = function (self)
		if self.clearing then return nil; end
		local first = self.first;
		if first > self.last then return nil; end
		local val = self.queue[first];
		self.queue[first] = nil;
		self.first = first + 1;
		return val;
	end,
	HasData = function (self)
		if self.clearing then return false; end
		return not (self.first > self.last);
	end,
	Clear = function (self)
		self.clearing = true;
		for i=self.first, self.last do 
			self.queue[i] = nil;
			self.first = i + 1;
		end
		self.clearing = false;
	end,
	PopBlock = function (self)
		if self.clearing then return nil; end
		local first = self.first;
		if first > self.last then return nil; end
		local sepsLen = self.sepLen;
		local pos = first;
		local len = string.len(SW_SYNC_SESSION) + string.len(self.queue[first]) + 1;
		while self.queue[pos + 1] and len + string.len(self.queue[pos + 1]) + sepsLen < self.maxBlockLen do
			pos = pos + 1;
			sepsLen = sepsLen + self.sepLen;
			len = len + string.len(self.queue[pos]);
		end
		local val = string.format(SW_SESSFORMAT,SW_SYNC_SESSION,table.concat(self.queue, self.sep, first, pos));
		for i=first, pos do 
			self.queue[i] = nil;
			self.first = i + 1;
		end
		return val;
	end,
	
};
