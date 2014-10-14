----------------------------------------------------------------------------------
--
-- GuildAdsTradeNeedData.lua
--
-- Author: Zarkan, Fkaï of European Ner'zhul (Horde)
-- URL : http://guildads.sourceforge.net
-- Email : guildads@gmail.com
-- Licence: GPL version 2 (General Public License)
----------------------------------------------------------------------------------

GuildAdsTradeNeedDataType = GuildAdsDataType:new({
	metaInformations = {
		name = "TradeNeed",
		version = 1,
        guildadsCompatible = 200,
		parent = GuildAdsDataType.CHANNEL,
		priority = 400
	};
	schema = {
		id = "ItemRef",
		data = {
			[1] = { key="q",	codec="Integer" },
			[2] = { key="_t",	codec="BigInteger" },
			[3] = { key="c",	codec="String" },
		}
	}
});

function GuildAdsTradeNeedDataType:Initialize()
end

function GuildAdsTradeNeedDataType:InitializeChannel()
	if self.db.items == nil then
		self.db.items = {};
	end
end

function GuildAdsTradeNeedDataType:get(author, id)
	if not author then
		error("author is nil", 2);
	end
	if not id then
		error("id is nil", 2);
	end
	if self.db.items and self.db.items[id] and self.db.items[id].n then
		return self.db.items[id].n[author];
	end
end

function GuildAdsTradeNeedDataType:setRevision(author, revision)
	local itemsRevision = self.db.itemsRevision;
	if not itemsRevision[author] then
		itemsRevision[author] = {};
	end
	itemsRevision[author]._un = revision;
end

function GuildAdsTradeNeedDataType:getRevision(author)
	local itemsRevision = self.db.itemsRevision;
	if itemsRevision[author] then
		return itemsRevision[author]._un or 0;
	end
	return 0;
end

function GuildAdsTradeNeedDataType:setRaw(author, id, info, revision)
	local items = self.db.items;
	if info then
		if (self.db.items[id] == nil) then
			self.db.items[id] = {};
		end
		if (self.db.items[id].n == nil) then
			self.db.items[id].n = {};
		end
		self.db.items[id].n[author] = info;
		info._u = revision;
	else
		if self.db.items[id] and self.db.items[id].n then
			self.db.items[id].n[author] = nil;
		end
	end
end

function GuildAdsTradeNeedDataType:set(author, id, info)
	if info then
		if (self.db.items[id] == nil) then
			self.db.items[id] = {};
		end
		if (self.db.items[id].n == nil) then
			self.db.items[id].n = {};
		end
		local items = self.db.items[id].n;
		if items[author]==nil or info.q~=items[author].q or info.c~=items[author].c then
			local revision = self:getRevision(author)+1;
			self:setRevision(author, revision);
			info._u = revision;
			items[author] = info;
			self:triggerEvent(author, id);
			return info;
		end
	else
		if self.db.items[id] and self.db.items[id].n and self.db.items[id].n[author] then
			self.db.items[id].n[author] = nil;
			self:setRevision(author, self:getRevision(author)+1);
			self:triggerEvent(author, id);
		end
	end
end

function GuildAdsTradeNeedDataType:nextItem(item)
	item = next(self.db.items, item);
	while item and not (self.db.items[item].n and next(self.db.items[item].n))do
		item = next(self.db.items, item);
	end
	return item;
end

function GuildAdsTradeNeedDataType:iterator(author, id)
	if author and not id then
		-- iterateur sur les id d'un même joueur
		return self.iteratorId, { self, author} , nil;
	elseif not author and id then
		-- iterateur sur les joueurs, avec le même id
		return self.iteratorAuthor, { self, id }, nil;
	elseif not author and not id then
		-- iterateur sur toutes les skills de tous les joueurs
		return self.iteratorAll, self, {};
	end;
end

GuildAdsTradeNeedDataType.iteratorId = function(state, item)
	local t = state[1].db.items;
	local author = state[2];
	local data;
	item, data = next(t, item);
	while item and not(t[item].n and t[item].n[author]) do
		item, data = next(t, item);
	end
	if item then
		return item, author, data.n[author], data.n[author]._u
	end
end

GuildAdsTradeNeedDataType.iteratorAll = function(self, state)
	local item = state[1] or self:nextItem();
	
	if item then
		local author, data = next(self.db.items[item].n, state[2]);
		
		if not author then
			item = self:nextItem(item);
			if item then
				author, data = next(self.db.items[item].n);
			end
		end
		
		if item and author then
			state[1] = item;
			state[2] = author;
			return state, item, author, data, data._u;
		end
	end
end

GuildAdsTradeNeedDataType:register();
