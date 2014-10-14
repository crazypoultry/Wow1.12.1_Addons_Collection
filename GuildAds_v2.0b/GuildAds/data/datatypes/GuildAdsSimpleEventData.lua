----------------------------------------------------------------------------------
--
-- GuildAdsSimpleEventData.lua
--
-- Author: Zarkan, Fkaï of European Ner'zhul (Horde)
-- URL : http://guildads.sourceforge.net
-- Email : guildads@gmail.com
-- Licence: GPL version 2 (General Public License)
----------------------------------------------------------------------------------

GuildAdsSimpleEventDataType = GuildAdsTableDataType:new({
	metaInformations = {
		name = "SimpleEvent",
		version = 1,
        guildadsCompatible = 200,
		parent = GuildAdsDataType.CHANNEL,
		priority = 1000
	};
	schema = {
		id = "String",
		data = {
		}
	}
});

function GuildAdsSimpleEventDataType:Initialize()
end

function GuildAdsSimpleEventDataType:getTableForPlayer(author)
	return self.db.simpleEvent;
end

function GuildAdsSimpleEventDataType:get(author, id)
	if not author then
		error("author is nil", 2);
	end
	return self.db.simpleEvent[author][id];
end

function GuildAdsSimpleEventDataType:getRevision(author)
	if self.db.simpleEvent[author] then
		return self.db.simpleEvent[author]._u;
	end
	return 0;
end

function GuildAdsSimpleEventDataType:setRevision(author, revision)
	self.db.simpleEvent[author]._u = revision;
end

function GuildAdsSimpleEventDataType:setRaw(author, id, info, revision)
	local events = self.db.simpleEvent[author];
	events[id] = info;
	if info then
		events[id]._u = revision;
	end
end

function GuildAdsSimpleEventDataType:set(author, id, info)
	if not id then
		return;
	end
	local events = self.db.simpleEvent[author];
	if info then
		if not events then
			events = {};
			self.db.simpleEvent[author] = events;
		end
		if events[id]==nil then
			events._u = 1 + (events._u or 0);
			info._u = events._u;
			events[id] = info;
			self:triggerEvent(author, id);
			return info;
		end
	else
		if events and events[id] then
			events[id] = nil;
			events._u = 1 + (events._u or 0);
			self:triggerEvent(author, id);
		end
	end
end

GuildAdsSimpleEventDataType:register();
