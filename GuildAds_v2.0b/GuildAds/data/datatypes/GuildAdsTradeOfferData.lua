----------------------------------------------------------------------------------
--
-- GuildAdsTradeOfferData.lua
--
-- Author: Zarkan, Fkaï of European Ner'zhul (Horde)
-- URL : http://guildads.sourceforge.net
-- Email : guildads@gmail.com
-- Licence: GPL version 2 (General Public License)
----------------------------------------------------------------------------------

-- TODO: make a parent class

GuildAdsTradeOfferDataType = GuildAdsDataType:new({
	metaInformations = {
		name = "TradeOffer",
		version = 1,
        guildadsCompatible = 200,
		parent = GuildAdsDataType.CHANNEL,
		priority = 500
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

function GuildAdsTradeOfferDataType:Initialize()
end

function GuildAdsTradeOfferDataType:InitializeChannel()
	if self.db.items == nil then
		self.db.items = {};
	end;
end

function GuildAdsTradeOfferDataType:get(author, id)
	if not author then
		error("author is nil", 2);
	end
	if not id then
		error("id is nil", 2);
	end
	if self.db.items and self.db.items[id] and self.db.items[id].o then
		return self.db.items[id].o[author];
	end
end

function GuildAdsTradeOfferDataType:setRevision(author, revision)
	local itemsRevision = self.db.itemsRevision;
	if not itemsRevision[author] then
		itemsRevision[author] = {};
	end
	itemsRevision[author]._uo = revision;
end

function GuildAdsTradeOfferDataType:getRevision(author)
	local itemsRevision = self.db.itemsRevision;
	if itemsRevision[author] then
		return itemsRevision[author]._uo or 0;
	end
	return 0;
end

function GuildAdsTradeOfferDataType:setRaw(author, id, info, revision)
	local items = self.db.items;
	if info then
		if (self.db.items[id] == nil) then
			self.db.items[id] = {};
		end
		if (self.db.items[id].o == nil) then
			self.db.items[id].o = {};
		end
		self.db.items[id].o[author] = info;
		info._u = revision;
		return true;
	else
		if self.db.items[id] and self.db.items[id].o then
			self.db.items[id].o[author] = nil;
		end
	end
end

function GuildAdsTradeOfferDataType:set(author, id, info)
	if info then
		if (self.db.items[id] == nil) then
			self.db.items[id] = {};
		end
		if (self.db.items[id].o == nil) then
			self.db.items[id].o = {};
		end
		local items = self.db.items[id].o;
		if items[author]==nil or info.q~=items[author].q or info.c~=items[author].c then
			local revision = self:getRevision(author)+1;
			self:setRevision(author, revision);
			info._u = revision;
			items[author] = info;
			self:triggerEvent(author, id);
			return info;
		end
	else
		if self.db.items[id] and self.db.items[id].o and self.db.items[id].o[author] then
			self.db.items[id].o[author] = nil;
			-- TODO : if next(self.db.items[id].o) == nil then self.db.items[id].o = nil end
			self:setRevision(author, self:getRevision(author)+1);
			self:triggerEvent(author, id);
		end
	end
end

function GuildAdsTradeOfferDataType:nextItem(item)
	item = next(self.db.items, item);
	while item and not (self.db.items[item].o and next(self.db.items[item].o))do
		item = next(self.db.items, item);
	end
	return item;
end

function GuildAdsTradeOfferDataType:iterator(author, id)
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

GuildAdsTradeOfferDataType.iteratorId = function(state, item)
	local t = state[1].db.items;
	local author = state[2];
	local data;
	item, data = next(t, item);
	while item and not(t[item].o and t[item].o[author]) do
		item, data = next(t, item);
	end
	if item then
		return item, author, data.o[author], data.o[author]._u
	end
end

GuildAdsTradeOfferDataType.iteratorAll = function(self, state)
	local item = state[1] or self:nextItem();
	
	if item then
		local author, data = next(self.db.items[item].o, state[2]);
		
		if not author then
			item = self:nextItem(item);
			if item then
				author, data = next(self.db.items[item].o);
			end
		end
		
		if item and author then
			state[1] = item;
			state[2] = author;
			return state, item, author, data, data._u;
		end
	end
end

GuildAdsTradeOfferDataType:register();
