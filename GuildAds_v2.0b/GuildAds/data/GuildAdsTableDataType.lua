----------------------------------------------------------------------------------
--
-- GuildAdsTableDataType.lua
--
-- Author: Zarkan, Fkaï of European Ner'zhul (Horde)
-- URL : http://guildads.sourceforge.net
-- Email : guildads@gmail.com
-- Licence: GPL version 2 (General Public License)
----------------------------------------------------------------------------------

GuildAdsTableDataType = GuildAdsDataType:new();

--[[
	convention :
	index : current id (may be a table in other plugin)
	author : 
	id :
	data : (value, max, spe, subspe)
	_u : revision
]]
GuildAdsTableDataType.iteratorId = function(state, id)
	local id, data = next(state[1], id);
	if id=="_u" then
		id, data = next(state[1], id);
	end
	if id then
		if type(data)=="table" then
			return id, state[2], data, data._u;
		else
			return id, state[2], data;
		end
	end
end

function GuildAdsTableDataType:nextId(playerName, id)
	local id, data = next(self:getTableForPlayer(playerName), id)
	if id~="_u" then
		return id, data;
	end
	return next(self:getTableForPlayer(playerName), id);
end

function GuildAdsTableDataType:nextPlayerName(players, playerName)
	playerName = next(players, playerName);
	while playerName and next(self:getTableForPlayer(playerName))==nil do
		playerName = next(players, playerName);
	end
	return playerName;
end
	
GuildAdsTableDataType.iteratorAll = function(self, current)
	local players;
	if self.channel then
		players = self.channel:getPlayers();
	else
		players = GuildAdsDB.channel[GuildAds.channelName]:getPlayers();
	end

	-- current[1] = playerName, current[2] = id
	local data;

	-- first call : no playerName
	if not current[1] then
		current[1] = self:nextPlayerName(players);
	end

	-- next id
	if current[1] then
		current[2], data = self:nextId(current[1], current[2])

		if not current[2] then
			-- end of table for this player current[1], so try the next player
			current[1] = self:nextPlayerName(players, current[1]);
			if current[1] then
				-- there is one : get this first id
				current[2], data = self:nextId(current[1], current[2]);
			end
		end
	end

	-- if there is a playerName and an Id
	if current[2] and current[1] then
		return current, current[2], current[1], data, data._u;
	end
end

function GuildAdsTableDataType:getTableForPlayer(author)
	error("GuildAdsTableDataType:getTableForPlayer not impletemented", 2);
end

function GuildAdsTableDataType:iterator(author, id)
	if author and not id then
		-- iterateur sur les id d'un même joueur
		return self.iteratorId, { self:getTableForPlayer(author), author} , nil;
	elseif not author and id then
		-- iterateur sur les joueurs, avec le même id
		return self.iteratorAuthor, { self, id }, nil;
	elseif not author and not id then
		-- iterateur sur toutes les skills de tous les joueurs
		return self.iteratorAll, self, {};
	end;
end