----------------------------------------------------------------------------------
--
-- GuildAdsInventoryData.lua
--
-- Author: Zarkan, Fkaï of European Ner'zhul (Horde)
-- URL : http://guildads.sourceforge.net
-- Email : guildads@gmail.com
-- Licence: GPL version 2 (General Public License)
----------------------------------------------------------------------------------

local slot, link, item, count, data, playerInventory;

GuildAdsInventoryDataType = GuildAdsTableDataType:new({
	metaInformations = {
		name = "Inventory",
		version = 1,
        guildadsCompatible = 200,
		parent = GuildAdsDataType.PROFILE,
		priority = 300
	};
	schema = {
		id = "Integer";
		data = {
			[1] = { key="i", 	codec="ItemRef" },
			[2] = { key="q",	codec="Integer" }
		}
	}
});

function GuildAdsInventoryDataType:Initialize()
	playerInventory = self:getTableForPlayer(GuildAds.playerName);
	self:onUpdate();
	self:RegisterEvent("UNIT_INVENTORY_CHANGED");
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("PLAYER_LEAVING_WORLD");
end

function GuildAdsInventoryDataType:PLAYER_ENTERING_WORLD()
	self:RegisterEvent("UNIT_INVENTORY_CHANGED");
end

function GuildAdsInventoryDataType:PLAYER_LEAVING_WORLD()
	self:UnregisterEvent("UNIT_INVENTORY_CHANGED");
end

function GuildAdsInventoryDataType:UNIT_INVENTORY_CHANGED()
	if arg1 == "player" then
		self:onUpdate();
	end
end

function GuildAdsInventoryDataType:onUpdate()
	for slot = 1,19, 1 do
		link = GetInventoryItemLink("player", slot);
		if (link) then
			_, item = GuildAds_ExplodeItemRef(link);
			count = GetInventoryItemCount("player", slot);
			if not playerInventory[slot] or playerInventory[slot].i~=item or playerInventory[slot].q~=count then
				if count>1 then
					data = { i=item, q=count };
				else
					data = { i=item };
				end;
				self:set(GuildAds.playerName, slot, data);
			end
		else
			self:set(GuildAds.playerName, slot);
		end
	end
end

function GuildAdsInventoryDataType:getTableForPlayer(author)
	return self.profile:getRaw(author).inventory;
end

function GuildAdsInventoryDataType:get(author, id)
	if not author then
		error("author is nil", 2);
	end
	return self.profile:getRaw(author).inventory[id];
end

function GuildAdsInventoryDataType:getRevision(author)
	if not author then
		error("author is nil", 2);
	end
	return self.profile:getRaw(author).inventory._u or 0;
end

function GuildAdsInventoryDataType:setRevision(author, revision)
	self.profile:getRaw(author).inventory._u = revision;
end

function GuildAdsInventoryDataType:setRaw(author, id, info, revision)
	local inventory = self.profile:getRaw(author).inventory;
	inventory[id] = info;
	if info then
		inventory[id]._u = revision;
	end
end

function GuildAdsInventoryDataType:set(author, id, info)
	local inventory = self.profile:getRaw(author).inventory;
	if info then
		if info.q == 1 then
			info.q = nil;
		end
		if inventory[id]==nil or info.i ~= inventory[id].i or info.q ~= inventory[id].q then
			local trigger = inventory[id]==nil or info.i ~= inventory[id].i;
			inventory._u = 1 + (inventory._u or 0);
			info._u = inventory._u;
			inventory[id] = info;
			if trigger then
				self:triggerEvent(author, id);
			end
			return info;
		end
	else
		if inventory[id] then
			inventory[id] = nil;
			inventory._u = 1 + (inventory._u or 0);
			self:triggerEvent(author, id);
		end
	end
end

GuildAdsInventoryDataType:register();
