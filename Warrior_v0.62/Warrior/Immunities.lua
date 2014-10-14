WARRIOR.Immunities = {};
WARRIOR.Immunities.Effects = {};

WARRIOR.Immunities._enabled = true;
WARRIOR.Immunities._database = {};


-- *****************************************************************************
-- Function: OnEvent
-- Purpose: parse event data looking for immunities
-- *****************************************************************************
function WARRIOR.Immunities:OnEvent(event,message)
	-- creature has a permanent immunity to the spell
	if (event == "CHAT_MSG_SPELL_SELF_DAMAGE") then
		local _, _, spell, creature = string.find(message,W.Patterns.Failed);
		self:Add(creature,spell);
	
	-- creature is immune to disarm
	elseif (event == "CHAT_MSG_SPELL_FAILED_LOCALPLAYER") then
		if (string.find(message,W.Patterns.Disarm)) then self:Add(UnitName("target"),W.Spells.Disarm); end
	
	-- a temporary immunity effect has been detected
	elseif (event == "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS" or event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS") then
		local _, _, creature, effect = string.find(message,W.Patterns.Gains); 
		self.Effects:Add(creature,effect);

	-- a temporary immunity effect which has worn off has been detected
	elseif (event == "CHAT_MSG_SPELL_AURA_GONE_OTHER") then
		local _, _, effect, creature = string.find(message,W.Patterns.Fades);
		self.Effects:Remove(creature,effect);
	
	elseif (event == "CHAT_MSG_SPELL_BREAK_AURA") then
		local _, _, creature, effect = string.find(message,W.Patterns.Removed);
		self.Effects:Remove(creature,effect);
	end
end

-- *****************************************************************************
-- Function: IsImmune
-- Purpose: checks if the target is immune to the spell
-- *****************************************************************************
function WARRIOR.Immunities:IsImmune(spell,class)
	if (not self._enabled or not spell) then return false; end

	local creature = UnitName("target");
	if (not creature or not self._database[creature]) then return false; end
	
	-- find any immunities for the creature
	if (WARRIOR.Utils.Table:Find(self._database[creature],spell)) then return true; end
	
	-- if immunity check is for a class and the create has full immunity
	if (class and self._database[creature]._all) then return true; end
	
	return false;
end

-- *****************************************************************************
-- Function: Add
-- Purpose: adds a spell to immunity database
-- *****************************************************************************
function WARRIOR.Immunities:Add(creature,spell)
	if (not self._enabled or not creature or not spell) then return false; end
	
	-- create an entry for the creature is it has no immunities
	if (not self._database[creature]) then 
		self._database[creature] = {}; 
	end

	if (not WARRIOR.Utils.Table:Find(self._database[creature],spell)) then
		table.insert(self._database[creature],spell);
		WARRIOR.Utils:Debug(3,"Add: %s immunitiy added to %s.",spell,creature);
	end	
end

-- *****************************************************************************
-- Function: Remove
-- Purpose: remove a spell from immunity database
-- *****************************************************************************
function WARRIOR.Immunities:Remove(creature,spell)
	if (not self._enabled or not creature or not spell) then return false; end
	
	local key = WARRIOR.Utils.Table:Find(self._database[creature],spell)
	if (key) then 
		table.remove(self._database[creature],key);
		
		-- clean up the database if there is no data related to the creature
		if (not self._database[creature]._all and table.getn(self._database[creature]) < 1) then
			self._database[creature] = nil;
			table.sort(self._database);
			WARRIOR.Utils:Debug(3,"Remove: %s immunitiy removed from %s.",spell,creature);
		end
	end
end

-- *****************************************************************************
-- Function: Find
-- Purpose: checks effects to see if it is an effect
-- *****************************************************************************
function WARRIOR.Immunities.Effects:Find(effect)
	if (not effect) then return nil; end
	return WARRIOR.Utils.Table:Find(W.ImmunityEffects,effect);
end

-- *****************************************************************************
-- Function: Add
-- Purpose: add a temporary immunity effect spell to the database
-- *****************************************************************************
function WARRIOR.Immunities.Effects:Add(creature,effect)
	if (not creature or not self:Find(effect)) then return false; end

	-- create an entry for the creature is it has no immunities
	if (not WARRIOR.Immunities._database[creature]) then WARRIOR.Immunities._database[creature] = {}; end
	
	WARRIOR.Immunities._database[creature]._all = true;
	WARRIOR.Utils:Debug(3,"Add: %s caused temporary immunitiy for %s.",effect,creature);
end

-- *****************************************************************************
-- Function: Remove
-- Purpose: remove a temporary immunity effect spell from the database
-- *****************************************************************************
function WARRIOR.Immunities.Effects:Remove(creature,effect)
	if (not creature or not self:Find(effect) or not WARRIOR.Immunities._database[creature]) then return; end
	WARRIOR.Immunities._database[creature]._all = nil;
	WARRIOR.Utils:Debug(3,"Remove: %s temporary immunitiy effect for %s has faded.",effect,creature);
end

-- *****************************************************************************
-- Function: Wipe
-- Purpose: remove all temporary immunity effect spells from the database
-- *****************************************************************************
function WARRIOR.Immunities.Effects:Wipe()
	for creature,_ in WARRIOR.Immunities._database do
		for effect,_ in W.ImmunityEffects do self:Remove(creature,effect); end
	end
end
