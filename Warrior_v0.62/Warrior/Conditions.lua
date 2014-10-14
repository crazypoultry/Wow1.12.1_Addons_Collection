WARRIOR.Conditions = {};
WARRIOR.Conditions.Handlers = {};
WARRIOR.Conditions._database = {};


-- *****************************************************************************
-- Function: Add
-- Purpose: adds a condition to a spell in a class
-- *****************************************************************************
function WARRIOR.Conditions:Add(class,spell,condition)
	if (not class or not spell or not condition) then return nil; end

	-- create entries in the table
	if (not self._database[class]) then self._database[class] = {}; end	
	if (not self._database[class][spell]) then self._database[class][spell] = {}; end
	
	table.insert(self._database[class][spell],condition);
	WARRIOR.Settings:Save("WARRIOR.Conditions._database");
	return true;
end

-- *****************************************************************************
-- Function: Remove
-- Purpose: removes a condition placed on a spell in a class
-- *****************************************************************************
function WARRIOR.Conditions:Remove(class,spell,id)
	if (not class or not spell or not id or not self._database[class] or not self._database[class][spell]) then return nil; end

	if (table.remove(self._database[class][spell],id)) then 
		WARRIOR.Settings:Save("WARRIOR.Conditions._database");
		return true;
	end
	
	return false;
end

-- *****************************************************************************
-- Function: RemoveSpell
-- Purpose: removes all conditions placed on a spell in a class
-- *****************************************************************************
function WARRIOR.Conditions:RemoveSpell(class,spell)
	if (not class or not spell or not self._database[class] or not self._database[class][spell]) then return nil; end

	self._database[class][spell] = nil;
	table.sort(self._database[class]);
	WARRIOR.Settings:Save("WARRIOR.Conditions._database");
	return true;
end

-- *****************************************************************************
-- Function: RemoveClass
-- Purpose: removes all conditions placed on a class
-- *****************************************************************************
function WARRIOR.Conditions:RemoveClass(class)
	if (not class or not self._database[class]) then return nil; end

	self._database[class] = nil;
	table.sort(self._database);
	WARRIOR.Settings:Save("WARRIOR.Conditions._database");
	return true;
end

-- *****************************************************************************
-- Function: Validate
-- Purpose: validates all the conditions on a spell
-- *****************************************************************************
function WARRIOR.Conditions:Validate(class,spell)
	if (not class or not self._database[class] or not self._database[class][spell]) then return true; end

	for _,value in self._database[class][spell] do
		if (not self.Handlers[value.index](self,value.parameters)) then return false; end
	end
	
	return true;
end

-- *****************************************************************************
-- Function: Buff
-- Purpose: buff condition limiting spells based current buffs
-- *****************************************************************************
function WARRIOR.Conditions.Handlers:Buff(parameters)
	local current = {};

	local i = 0
	while true do
		local index = GetPlayerBuff(i,"HELPFUL");  -- get the buff index
		if (not index or index < 0) then do break end end
		
		-- set the buff tooltip
		WARRIORTooltip:ClearLines();
		WARRIORTooltip:SetPlayerBuff(index);
		
		current[WARRIORTooltipTextLeft1:GetText()] = true;
		i = i + 1
	end
	
	-- check to see if the buffs are all there
	local buffs = WARRIOR.Utils.List:ToTable(parameters.buffs);
	for _,buff in buffs do if (not current[buff]) then return false; end end
	
	return true;
end

-- *****************************************************************************
-- Function: Class
-- Purpose: class condition limiting spells based on the class of the target
-- *****************************************************************************
function WARRIOR.Conditions.Handlers:Class(parameters)
	local target = string.lower(UnitClass(parameters.target));
	local result = WARRIOR.Utils.List:HasValue(string.lower(parameters.classes),target);

	-- flop the result
	if (result == nil) then return nil; end
	if (parameters.flop) then return WARRIOR.Utils:FlopBool(result); end
	
	return result;
end

-- *****************************************************************************
-- Function: Cooldown
-- Purpose: cooldown condition allow spells to only be cast while others are cooling
-- *****************************************************************************
function WARRIOR.Conditions.Handlers:Cooldown(parameters)
	local spells = WARRIOR.Utils.List:ToTable(parameters.spells)

	local count = 0;
	for _,spell in spells do
		if (WARRIOR.Spells._spellbook[spell] and GetSpellCooldown(WARRIOR.Spells._spellbook[spell].id,BOOKTYPE_SPELL) ~= 0) then 
			count = count + 1;
		end
	end

	return ((not parameters.flop and count == table.getn(spells)) or (parameters.flop and count == 0));
end

-- *****************************************************************************
-- Function: Runner
-- Purpose: runner condition limiting the casting based on the courage of the target
-- *****************************************************************************
function WARRIOR.Conditions.Handlers:Runner(parameters)
	if (parameters.flop) then return WARRIOR.Utils:FlopBool(WARRIOR.Enemy._fleeing); end
	return WARRIOR.Enemy._fleeing;
end

-- *****************************************************************************
-- Function: Timer
-- Purpose: timer condition limiting the frequence a spell is cast
-- *****************************************************************************
function WARRIOR.Conditions.Handlers:Timer(parameters)
	if (not WARRIOR.Spells._spellbook[parameters.spell]._timestamp) then return true; end
	if (GetTime() - WARRIOR.Spells._spellbook[parameters.spell]._timestamp > parameters.seconds) then return true; end
	
	return false;
end

-- *****************************************************************************
-- Function: Sunder
-- Purpose: sunder condition limiting the number of sunders
-- *****************************************************************************
function WARRIOR.Conditions.Handlers:Sunder(parameters)
	if (parameters.times == "*") then 
		WARRIOR.Player._maxsunders = 6;
		return true;
	end
	
	WARRIOR.Player._maxsunders = tonumber(parameters.times);
	return true;
end

-- *****************************************************************************
-- Function: Stance
-- Purpose: stance condition based on the stance you are in
-- *****************************************************************************
function WARRIOR.Conditions.Handlers:Stance(parameters)
	local result = WARRIOR.Player.Stances:InStance(parameters.stance);

	-- flop the result
	if (parameters.flop) then return WARRIOR.Utils:FlopBool(result); end
	return result;
end

-- *****************************************************************************
-- Function: Casting
-- Purpose: spell condition to only cast when the enemy is cast certian spells
-- *****************************************************************************
function WARRIOR.Conditions.Handlers:Casting(parameters)
	if (not WARRIOR.Enemy._casting) then return false; end

	-- handle the predefined WarriorAttack spell classes
	if (parameters.spells == "warriorattack") then
		if (WARRIOR.Utils.Table:Find(W.WarriorAttack.short,WARRIOR.Enemy._casting.spell)) then return true; end
		if (WARRIOR.Utils.Table:Find(W.WarriorAttack.long,WARRIOR.Enemy._casting.spell)) then 
			if (WARRIOR.Player.Stances:Verify(parameters.spell)) then return false; end
			return true; 
		end
	end
	
	-- handle user defined spell classes
	if (WARRIOR.Utils.Table:Find(WARRIOR.Utils.List:ToTable(parameters.spells),WARRIOR.Enemy._casting.spell)) then return true; end
	return false;
end

-- *****************************************************************************
-- Function: Pool
-- Purpose: pool condition for health, mana, energy, and rage
-- *****************************************************************************
function WARRIOR.Conditions.Handlers:Pool(parameters)
	local values = function (e,t) 
		if (e == "health") then return UnitHealth(t), UnitHealthMax(t); end 
		return UnitMana(t), UnitManaMax(t);
	end

	local scale = 10.0;
	local value,max = values(parameters.pool,parameters.target);
	
	-- change the returned value to a percentage
	if (parameters.percentage) then 
		if (max < 0) then return nil; end
		value = value / max * 100.0;

	-- apply a scale that is 10% of the value
	else scale = value * scale / 100.0; end

	local func = {
		over = function (a,b) return (a > b); end,
		under = function (a,b) return (a < b); end,
		around = function (a,b,c) return (a + c > b and a - c < b); end,
	}

	local result = func[parameters.operation](value,parameters.value,scale);

	-- flop the result
	if (parameters.flop) then return WARRIOR.Utils:FlopBool(result); end
	return result;
end
