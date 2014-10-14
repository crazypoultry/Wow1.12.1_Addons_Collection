----------------------------------------------------------------------------------
--
-- GuildAdsSkillData.lua
--
-- Author: Zarkan, Fkaï of European Ner'zhul (Horde)
-- URL : http://guildads.sourceforge.net
-- Email : guildads@gmail.com
-- Licence: GPL version 2 (General Public License)
----------------------------------------------------------------------------------

GuildAdsSkillDataType = GuildAdsTableDataType:new({
	metaInformations = {
		name = "Skill",
		version = 1,
        guildadsCompatible = 200,
		parent = GuildAdsDataType.PROFILE,
		priority = 300
	};
	schema = {
		id = "Integer",
		data = {
			[1] = { key="v",	codec="Integer" },
			[2] = { key="m",	codec="Integer" }
		}
	}
});

function GuildAdsSkillDataType:Initialize()
	GuildAdsTask:AddNamedSchedule("GuildAdsSkillDataTypeInit", 8, nil, nil, self.onUpdate, self)
	self:RegisterEvent("CHARACTER_POINTS_CHANGED", "onUpdate");
	self:RegisterEvent("CHAT_MSG_SKILL", "onUpdate");
	self:RegisterEvent("PLAYER_LEVEL_UP", "onUpdate");   -- to update the max skill rank
end

function GuildAdsSkillDataType:onUpdate()
	local playerName = UnitName("player");
	for i = 1, GetNumSkillLines(), 1 do	
		local skillName, header, isExpanded, skillRank, numTempPoints, skillModifier, skillMaxRank, isAbandonable, stepCost, rankCost, minLevel, skillCostType = GetSkillLineInfo(i);
		if (header ~= 1) then
			local id = self:getIdFromName(skillName);
			if (id > 0) then
				self:set(playerName, id, { v=skillRank; m=skillMaxRank });
			end
		end
	end
end

function GuildAdsSkillDataType:getIdFromName(SkillName)
	for id, name in GUILDADS_SKILLS do
		if (name == SkillName) then
			return id;
		end
	end
	return -1;	
end

function GuildAdsSkillDataType:getNameFromId(SkillId)
	return GUILDADS_SKILLS[SkillId] or "";
end

function GuildAdsSkillDataType:getTableForPlayer(author)
	return self.profile:getRaw(author).skills;
end

function GuildAdsSkillDataType:get(author, id)
	if not author then
		error("author is nil", 2);
	end
	return self.profile:getRaw(author).skills[id];
end

function GuildAdsSkillDataType:getRevision(author)
	return self.profile:getRaw(author).skills._u or 0;
end

function GuildAdsSkillDataType:setRevision(author, revision)
	self.profile:getRaw(author).skills._u = revision;
end

function GuildAdsSkillDataType:setRaw(author, id, info, revision)
	local skills = self.profile:getRaw(author).skills;
	skills[id] = info;
	if info then
		skills[id]._u = revision;
	end
end

function GuildAdsSkillDataType:set(author, id, info)
	local skills = self.profile:getRaw(author).skills;
	if info then
		if skills[id]==nil or info.v ~= skills[id].v or info.m ~= skills[id].m then
			skills._u = 1 + (skills._u or 0);
			info._u = skills._u;
			skills[id] = info;
			self:triggerEvent(author, id);
			return info;
		end
	else
		if skills[id] then
			skills[id] = nil;
			skills._u = 1 + (skills._u or 0);
			self:triggerEvent(author, id);
		end
	end
end

GuildAdsSkillDataType:register();
