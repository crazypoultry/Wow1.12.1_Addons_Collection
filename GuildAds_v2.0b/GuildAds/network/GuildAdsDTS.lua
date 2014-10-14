----------------------------------------------------------------------------------
--
-- GuildAdsDTS.lua (DataType Synchronization)
--
-- Author: Zarkan, Fkaï of European Ner'zhul (Horde)
-- URL : http://guildads.sourceforge.net
-- Email : guildads@gmail.com
-- Licence: GPL version 2 (General Public License)
----------------------------------------------------------------------------------

GuildAdsDTS = {};

function GuildAdsDTS:new(dataType)
	if not dataType.metaInformations or  not dataType.metaInformations.name then
		return;
	end
	
	if dataType.schema.data then
		local dataCodec = GuildAdsCodecTable:new({ schema=dataType.schema.data }, dataType.metaInformations.name.."Data", 1);
	end
	
	if dataType.schema.keys then
		local keysCodec = GuildAdsCodecTable:new({ schema=dataType.schema.keys }, dataType.metaInformations.name.."Keys", 1);
	end
	
	local o = {
		dataType = dataType;
		search = {};
		deleteTable = {};
	};
	self.__index = self;
	setmetatable(o, self);
	return o;
end

function GuildAdsDTS:__tostring()
	return self.dataType.metaInformations.name;
end

function GuildAdsDTS:predicate(other)
	local a = self.dataType.metaInformations.priority;
	if a then
		local b = other.dataType.metaInformations.priority or a+1;
		return a<b;
	end
	return other.dataType.metaInformations.priority and true or false;
end

function GuildAdsDTS:__lt(other)
	return self:predicate(other);
end


--------------------------------------------------------------------------------
--
-- Return the weight on this player (higher = better to send transaction)
-- 
--------------------------------------------------------------------------------
function GuildAdsDTS:GetWeight()
	local fps = GetFramerate()
	local _, _, lag = GetNetStats();
	return math.floor(fps*(1000-lag));
end

--------------------------------------------------------------------------------
--
-- About search the higher/lower revision for a (self.datatype, playerName)
-- 
--------------------------------------------------------------------------------

function GuildAdsDTS:RestartAllSearches()
	for playerName in pairs(self.search) do
		self.search[playerName] = nil;
		GuildAdsComm:QueueSearch(self, playerName);
	end
end

function GuildAdsDTS:SendSearch(playerName)
	-- send search to everyone
	GuildAdsComm:SendSearch(self.dataType, playerName);
end

function GuildAdsDTS:ReceiveSearch(playerName)
	if not self.search[playerName] then
		self.search[playerName] = {
			bestPlayerName = GuildAds.playerName,
			bestRevision = self.dataType:getRevision(playerName),
			bestWeight = self:GetWeight(),
			worstRevision = self.dataType:getRevision(playerName),
			version = self.dataType.metaInformations.version
		};
	else
		GuildAds_ChatDebug(GA_DEBUG_PROTOCOL,"  - Search already in progress");
	end
	
	if not (GuildAdsComm.playerTree[GuildAds.playerName].c1 or GuildAdsComm.playerTree[GuildAds.playerName].c2) then
		-- I'm a leaf : don't wait, send my revision information to my parent
		self:SendRevision(playerName);
	end
end

function GuildAdsDTS:SendRevision(playerName)
	if self.search[playerName] then
		local result = self.search[playerName];
		if GuildAdsComm.playerTree[GuildAds.playerName].p then
			-- send result to parent in whisper
			GuildAdsComm:SendSearchResultToParent(GuildAdsComm.playerTree[GuildAds.playerName].p, self.dataType, playerName, result.bestPlayerName, result.bestRevision, result.bestWeight, result.worstRevision, result.version);
		else
			-- send search result to channel
			GuildAdsComm:SendSearchResult(self.dataType, playerName, result.bestPlayerName, result.bestRevision, result.worstRevision);
		end
	end
end

function GuildAdsDTS:ReceiveRevision(childPlayerName, playerName, who, revision, weight, worstRevision, version)
	if not self.search[playerName] then
		return;
	end
	
	version = version or 1;
	
	local result = self.search[playerName];
	-- TODO : handle the case, playerName has reset, so he has a lower revision but we must update to this one.
	if  	(revision>result.bestRevision) 
		or	(revision==result.bestRevision and weight>result.bestWeight)
		or	(version>result.version) then
		result.bestPlayerName = who;
		result.bestRevision = revision;
		result.bestWeight = weight;
		result.version = version;
	end
	
	if (worstRevision<result.worstRevision) then
		result.worstRevision = worstRevision;		
	end
	
	if childPlayerName == GuildAdsComm.playerTree[GuildAds.playerName].c1 then
		result.c1 = true;
	end
	
	if childPlayerName == GuildAdsComm.playerTree[GuildAds.playerName].c2 then
		result.c2 = true;
	end
	
	if (	GuildAdsComm.playerTree[GuildAds.playerName].c1
		and result.c1
		and GuildAdsComm.playerTree[GuildAds.playerName].c2 
		and result.c2)
	   or
	   (	GuildAdsComm.playerTree[GuildAds.playerName].c1
		and result.c1
		and not GuildAdsComm.playerTree[GuildAds.playerName].c2
		and not result.c2
	   )
	then
		self:SendRevision(playerName)
	end
end

function GuildAdsDTS:ReceiveSearchResult(playerName, who, fromRevision, toRevision)
	if self.search[playerName] then
		
		if (GuildAds.playerName==who) and (fromRevision<toRevision) then
			GuildAdsComm:QueueTransaction(self, playerName, fromRevision, self.dataType:getRevision(playerName) or 0);
		end
		
		self.search[playerName] = nil;
	end
end

--------------------------------------------------------------------------------
--
-- send a transaction
-- 
--------------------------------------------------------------------------------

function GuildAdsDTS:SendTransaction(playerName, fromRevision)
	-- send open transaction
	GuildAdsComm:SendOpenTransaction(self.dataType, playerName, fromRevision, self.dataType:getRevision(playerName) or 0);
	
	if self.dataType.schema.data then
		GuildAds_ChatDebug(GA_DEBUG_PROTOCOL,"data");
		self:SendTransactionData(playerName, fromRevision);
	elseif self.dataType.schema.keys then
		GuildAds_ChatDebug(GA_DEBUG_PROTOCOL,"keys");
		self:SendTransactionKeys(playerName, fromRevision);
	end

	-- send close transaction with the current revision number
	GuildAdsComm:SendCloseTransaction(self.dataType, playerName);
end

function GuildAdsDTS:SendTransactionData(playerName, fromRevision)
	local currentRevision = self.dataType:getRevision(playerName);
	GuildAds_ChatDebug(GA_DEBUG_PROTOCOL,"currentRevision="..currentRevision);
	local t = {};
	local newEntries = 0;
	-- send new entries >r1
	for id, _, data, revision in self.dataType:iterator(playerName) do
		-- revision<=currentRevision : if an transaction wasn't closed, player can have higher revisions than currentRevision
		if (revision<=currentRevision) then
			-- revision>fromRevision : new revision fromRevision
			if (revision>fromRevision)  then
				newEntries = newEntries + 1;
				-- send this revision
				GuildAdsComm:SendRevision(self.dataType, playerName, revision, id, data);
			else
				table.insert(t, revision);
			end
		end
	end

	if currentRevision-fromRevision~=newEntries then
		-- idealement : 1-10, 12-15, 17-30 au lieu de la liste complete
		GuildAdsComm:SendOldRevision(self.dataType, playerName, t)
	end
end

function GuildAdsDTS:SendTransactionKeys(playerName, fromRevision)
	keys = {};
	for id, _, data in self.dataType:iterator(playerName) do
		keys[id] = data;
	end
	GuildAdsComm:SendKeys(self.dataType, playerName, keys)
end

--------------------------------------------------------------------------------
--
-- receive a transaction
-- 
--------------------------------------------------------------------------------

function GuildAdsDTS:ReceiveOpenTransaction(transaction, playerName, fromRevision, toRevision, version)
	if self.dataType.metaInformations.version~=version then
		if self.dataType:getMostRecentVersion()<version then
			self.dataType:setMostRecentVersion(version);
			GuildAds.cmd:msg(GUILDADS_NEWDATATYPEVERSION, self.dataType.metaInformations.name, playerName, tostring(version));
		end
		return
	end
	
	-- TODO : don't accept transaction about myself(me and reroll) from other player
	-- TODO : handle the case fromRevision is lower than toRevision
	local currentRevision = self.dataType:getRevision(playerName);
	if currentRevision<toRevision and currentRevision>=fromRevision then
		transaction._valid = true;
	end
end

function GuildAdsDTS:ReceiveCloseTransaction(transaction)
	if transaction._valid then
		if transaction._IntegrityProblem then
			self.dataType:setRevision(transaction.playerName, 0);
			self:SendSearch(transaction.playerName);
		else
			self.dataType:setRevision(transaction.playerName, transaction.toRevision);
		end
	end
end

function GuildAdsDTS:ReceiveNewRevision(transaction, revision, id, data)
	if transaction._valid then
		if id then
			self.dataType:setRaw(transaction.playerName, id, data, revision);
			if revision>transaction.toRevision then
				GuildAds_ChatDebug(GA_DEBUG_PROTOCOL, "|cffff1e00Invalid new revision|r "..tostring(revision).." >"..tostring(transaction.toRevision));
			end
		else
			GuildAds_ChatDebug(GA_DEBUG_PROTOCOL, "|cffff1e00Invalid new revision|r id is nil");
			transaction._IntegrityProblem = true;
		end
	end
end

function GuildAdsDTS:ReceiveOldRevisions(transaction, revisions)
	if transaction._valid then
		table.setn(self.deleteTable, 0);
		
		-- find which id to delete
		for id, _, data, revision in self.dataType:iterator(transaction.playerName) do
			if revision<=transaction.fromRevision and not revisions[revision] then
				tinsert(self.deleteTable, id);
			end
			-- to check integrity after
			revisions[revision] = nil;
		end
		
		-- check integrity
		if next(revisions) then
			GuildAds_ChatDebug(GA_DEBUG_PROTOCOL, string.format("|cffff1e00Integrity problem|r with (%s, %s)", self.dataType.metaInformations.name, transaction.playerName, tostring(version)));
			transaction._IntegrityProblem = true;
		end
		
		-- delete them
		for _, id in self.deleteTable do
			self.dataType:setRaw(transaction.playerName, id, nil, nil)
		end
		
		table.setn(self.deleteTable, 0);
	end
end

function GuildAdsDTS:ReceiveKeys(transaction, keys)
	if transaction._valid then
		for key, data in pairs(keys) do
			GuildAds_ChatDebug(GA_DEBUG_PROTOCOL,"  - ["..tostring(key).."]="..tostring(data));
			self.dataType:setRaw(transaction.playerName, key, data);
		end
	end
end