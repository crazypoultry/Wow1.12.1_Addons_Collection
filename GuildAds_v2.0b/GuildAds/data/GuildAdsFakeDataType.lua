----------------------------------------------------------------------------------
--
-- GuildAdsDataType.lua
--
-- Author: Zarkan, Fkaï of European Ner'zhul (Horde)
-- URL : http://guildads.sourceforge.net
-- Email : guildads@gmail.com
-- Licence: GPL version 2 (General Public License)
----------------------------------------------------------------------------------

local nilFunction = function() end;

GuildAdsFakeDataType = GuildAdsDataType:new();

function GuildAdsFakeDataType:new(dataTypeName)
	local o = {
		metaInformations = {
			name = dataTypeName,
			version = 0,
			guildadsCompatible = 200,
			parent = GuildAdsDataType.PROFILE
		};
		schema = {
		};
	}
	return GuildAdsDataType.new(self, o);
end

function GuildAdsFakeDataType:iterator(playerName, id)
	return nilFunction;
end

function GuildAdsFakeDataType:set(playerName, id, data)
end

function GuildAdsFakeDataType:clear()
end

function GuildAdsFakeDataType:getRevision(playerName)
	return 0;
end

function GuildAdsFakeDataType:setRevision(playerName, revisionNumber)
end

function GuildAdsFakeDataType:setRaw(playerName, id, data, revisionNumber)
end

function GuildAdsFakeDataType:delete(playerName, id)
	return 0;
end

--[[ about events ]]
-- nothing will happen
function GuildAdsDataType:triggerEvent(playerName, id)
end

function GuildAdsDataType:registerEvent(obj, method)
end

function GuildAdsDataType:unregisterEvent(obj)
end

--[[ about version ]]
-- herited from GuildAdsDataType

--[[ register the data type ]]
function GuildAdsFakeDataType:register()
end