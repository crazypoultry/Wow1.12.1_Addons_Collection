WARRIOR.Spells = {};
WARRIOR.Spells.Restrictions = {};

WARRIOR.Spells._mutex = false;
WARRIOR.Spells._loaded = false;


-- *****************************************************************************
-- Function: OnEvent
-- Purpose: updates the spellbook based on certian events
-- *****************************************************************************
function WARRIOR.Spells:OnEvent(event)
	-- reload the spell book
	if (event == "SPELLS_CHANGED" or event == "LEARNED_SPELL_IN_TAB") then
		self._loaded = false;
		self:Load();
	end
	
	-- reload the action slots
	if (event == "ACTIONBAR_SLOT_CHANGED") then
		for _,spell in self._spellbook do spell.slot = false; end
	
		local j = 0;
		for j = 1, 120 do
			if (HasAction(j) and not GetActionText(j)) then
				WARRIORTooltip:ClearLines();
				WARRIORTooltip:SetAction(j);
				local actionname = WARRIORTooltipTextLeft1:GetText();
				if (self._spellbook[actionname]) then self._spellbook[actionname].slot = j; end
			end
		end
	end
end

-- *****************************************************************************
-- Function: Load
-- Purpose: loads all of the spells from the spellbook
-- *****************************************************************************
function WARRIOR.Spells:Load()
	if (self._loaded) then return; end
	
	-- create a blank spell book
	self._spellbook = {};
	
	local i = 1
	while true do
		local name, rank = GetSpellName(i,BOOKTYPE_SPELL);
		if (not name) then do break end	end
		
		-- save the basic spell information
		self._spellbook[name] = {
			id = i,
			type = "spell",
			name = name,
			rank = rank,
			spell = name .. "(" .. rank .. ")",
			texture = GetSpellTexture(i,BOOKTYPE_SPELL),
			slot = false;
		};
		
		-- get the slot number that the spell may be in
		local j = 0;
		for j = 1, 120 do
			if (HasAction(j) and not GetActionText(j) and self._spellbook[name].texture == GetActionTexture(j)) then
				WARRIORTooltip:ClearLines();
				WARRIORTooltip:SetAction(j);
				local actionname = WARRIORTooltipTextLeft1:GetText();
				if (name == actionname) then
					self._spellbook[name].slot = j;
					do break end
				end
			end
		end
		
		-- read the spells tooltip
		WARRIORTooltip:ClearLines();
		WARRIORTooltip:SetSpell(i,BOOKTYPE_SPELL);
		
		local buffer = "";
		for i=1,WARRIORTooltip:NumLines() do
		   local line = getglobal("WARRIORTooltipTextLeft" .. i)
		   buffer = buffer .. (line:GetText() or "");
		end
		
		-- extract rage information from tooptip
		local _, _, value = string.find(buffer,W.Patterns.Rage);
		if (value) then self._spellbook[name].rage = tonumber(value); end
		
		-- extract stance information from tooltip
		local _, _, s1, s2 = string.find(buffer,W.Patterns.Stance2);
		if (s1 and s2) then self._spellbook[name].stance = { primary = s1, secondary = s2 };
		else
			local _, _, s = string.find(buffer,W.Patterns.Stance1);
			if (s) then self._spellbook[name].stance = { primary = s }; end
		end
		
		i = i + 1
	end
	
	-- define special spell types: buff, debuff, form
	local types = {
		buff = {W.Spells.BattleShout},
		debuff = {W.Spells.DemoralizingShout, W.Spells.ThunderClap, W.Spells.Rend, W.Spells.Hamstring},
		stance = {W.Spells.BattleStance, W.Spells.DefensiveStance, W.Spells.BerserkerStance}
	};
	
	-- apply the special spell type to the spellbook
	for type,spells in types do for _,name in spells do 
		if (self._spellbook[name]) then self._spellbook[name].type = type; end
	end end
	
	-- spell data has been loaded
	self._loaded = 1;
end

-- *****************************************************************************
-- Function: IsReady
-- Purpose: checks to make sure a spell is ready to be cast
-- *****************************************************************************
function WARRIOR.Spells:IsReady(name,class)
	if (not name or not self._spellbook[name]) then return "spell is not known"; end

	-- check for spell not allow during combat
	local duringcombat = {W.Spells.Charge};	
	if (not WARRIOR.Player._idle and WARRIOR.Utils.Table:Find(duringcombat,name)) then return "spell not allow during combat"; end

	-- check for pre-combat spells
	local precombat = {W.Spells.BattleStance, W.Spells.DefensiveStance, W.Spells.BerserkerStance, W.Spells.Attack, W.Spells.Charge, W.Spells.Intercept};	
	if (WARRIOR.Player._idle and not WARRIOR.Utils.Table:Find(precombat,name)) then return "spell not allow pre-combat"; end
	
	-- spells that can be cast while idle
	local idle = {W.Spells.Charge};

	-- check if the rage limit has been met
	if (not WARRIOR.Player.Rage:Available(name)) then return "rage reserve has not been filled"; end

	-- check for an immunity to the spell
	if (WARRIOR.Immunities:IsImmune(name,class)) then return "creature is immune"; end

	-- spell-based restrictions function table
	local restrictions = {
		[W.Spells.Execute] = WARRIOR.Spells.Restrictions.Execute,
		[W.Spells.Overpower] = WARRIOR.Spells.Restrictions.Overpower,
		[W.Spells.Taunt] = WARRIOR.Spells.Restrictions.LostAggro,
		[W.Spells.MockingBlow] = WARRIOR.Spells.Restrictions.LostAggro,
		[W.Spells.DemoralizingShout] = WARRIOR.Spells.Restrictions.ShortRange,
		[W.Spells.ThunderClap] = WARRIOR.Spells.Restrictions.ShortRange,
		[W.Spells.Whirlwind] = WARRIOR.Spells.Restrictions.ShortRange,
		[W.Spells.SunderArmor] = WARRIOR.Spells.Restrictions.Sunder,
		[W.Spells.Hamstring] = WARRIOR.Spells.Restrictions.Hamstring,
		[W.Spells.Revenge] = WARRIOR.Spells.Restrictions.Revenge
	};
	
	-- check spell-based restrictions
	if (restrictions[name] and not restrictions[name](class)) then return "failed ability test"; end
	
	-- check if player has the buff already
	if (self._spellbook[name].type == "buff" and self:HasBuff(name)) then return "has buff"; end
	
	-- check if target has the debuff already
	if (self._spellbook[name].type == "debuff" and self:HasDebuff(name)) then return "has debuff"; end

	-- check if the spell is on cooldown
	if (GetSpellCooldown(self._spellbook[name].id,BOOKTYPE_SPELL) > 0) then return "on cooldown"; end
	
	-- check if there is enough rage
	if (self._spellbook[name].rage and self._spellbook[name].rage > UnitMana("player")) then return "need rage"; end

	-- if the spell is in an action slot we can do more tests
	if (self._spellbook[name].slot) then
		-- check if we are the current action
		if (IsCurrentAction(self._spellbook[name].slot)) then return "active already"; end

		-- check if we are in range for the action
		local range = IsActionInRange(self._spellbook[name].slot);
		if (range == 0) then return "out of range"; end
		
		-- check if we have engough rage
		local usable, needrage = IsUsableAction(self._spellbook[name].slot);
		if (needrage) then return "need rage"; end
		
		local wrongstance = WARRIOR.Player.Stances:Verify(name);
		
		-- check if action is not usable, all actions in other stances will appear to be not be usable
		if (not usable and not wrongstance) then return "not usable"; end
	end

	return nil;
end

-- *****************************************************************************
-- Function: HasBuff
-- Purpose: determines if the target has the buff we want to cast
-- *****************************************************************************
function WARRIOR.Spells:HasBuff(name)
	if (not name or not self._spellbook[name]) then return false; end
	
	local i = 1
	while true do
		local texture = UnitBuff("player",i);
		if (not texture) then do break; end end
		
		if (string.find(texture,self._spellbook[name].texture)) then return true; end
		i = i + 1
	end

	return false;
end

-- *****************************************************************************
-- Function: HasDebuff
-- Purpose: determines if the target has the debuff we want to cast
-- *****************************************************************************
function WARRIOR.Spells:HasDebuff(name,limit)
	if (not name or not self._spellbook[name]) then return false; end
	
	local i = 1
	while true do
		local texture, applications, type = UnitDebuff("target",i);
		if (not texture) then do break; end end
		
		if (string.find(texture,self._spellbook[name].texture)) then
			if (not limit or applications >= limit) then return true; end
		end
		i = i + 1
	end
	
	return false;
end

-- *****************************************************************************
-- Function: Cast
-- Purpose: casts the specified spell
-- *****************************************************************************
function WARRIOR.Spells:Cast(name)
	if (not name or not self._spellbook[name]) then
		WARRIOR.Utils:Debug(1,"Cast: wrong arguments or %s not in spellbook.",name);
		return false;
	end

	-- set a mutex on the spell to prevent multiple cast attempts
	if (self._mutex) then return false; end
	self._mutex = true;

	-- in case of failure release the mutex and print message
	local CastFailed = function (self,name,error)
		self._mutex = false;
		WARRIOR.Utils:Debug(1,"Cast: [%s] %s.",name,error);
		return false;
	end

	-- do verifications for stances
	if (self._spellbook[name].type == "stance") then
		local error = WARRIOR.Player.Stances:IsReady(name);
		if (error) then return CastFailed(self,name,error); end

	else
		local error = self:IsReady(name);
		if (error) then return CastFailed(self,name,error); end
		
		-- release the mutex and switch us to the right stance
		local wrongstance = WARRIOR.Player.Stances:Verify(name);
		if (wrongstance) then
			self._mutex = false;
			if (WARRIOR.Player.Stances._auto) then
				WARRIOR.Utils:Debug(2,"Cast: switching to %s from %s for %s.",self._spellbook[name].stance.primary,wrongstance,name);
				return self:Cast(self._spellbook[name].stance.primary);
			end

			-- abort cast
			WARRIOR.Utils:Debug(2,"Cast: cast failed. %s requires %s.",name,self._spellbook[name].stance.primary);
			return false;
		end
	end
	
	-- timestamp the casting of the spell
	self._spellbook[name]._timestamp = GetTime();
	
	-- attempt to cast the spell
	CastSpellByName(self._spellbook[name].spell);
	WARRIOR.Utils:Debug(1,"Cast: casting %s.",name);	
	
	-- if the KLHT mod is installed inform it about possible sunders
	if (name == W.Spells.SunderArmor and KLHTM_Sunder) then KLHTM_Sunder(); end
	
	-- release the mutex
	self._mutex = false;
	return true;
end

-- *****************************************************************************
-- Function: Execute
-- Purpose: Execute spell restrictions, the target has >20%
-- *****************************************************************************
function WARRIOR.Spells.Restrictions.Execute()
	if (0.2 > UnitHealth("target") / UnitHealthMax("target")) then return true; end
	return false;
end

-- *****************************************************************************
-- Function: Overpower
-- Purpose: Overpower spell restrictions, the target has dodged
-- *****************************************************************************
function WARRIOR.Spells.Restrictions.Overpower()
	if (WARRIOR.Enemy._dodged) then return true; end
	return false;
end

-- *****************************************************************************
-- Function: Revenge
-- Purpose: Revenge spell restrictions, the player has dodged/parried/blocked
-- *****************************************************************************
function WARRIOR.Spells.Restrictions.Revenge()
	if (WARRIOR.Player._events.dodged or WARRIOR.Player._events.parried or WARRIOR.Player._events.blocked) then return true; end
	return false;
end


-- *****************************************************************************
-- Function: LostAggro
-- Purpose: lost aggro restrictions, the target changes targets away from you to non warrior
-- *****************************************************************************
function WARRIOR.Spells.Restrictions.LostAggro()	
	if (not UnitIsUnit("player","targettarget") and UnitIsFriend("player","targettarget") and not UnitIsPlayer("target")) then 
		return true;
	end

	return false;
end

-- *****************************************************************************
-- Function: ShortRange
-- Purpose: short range spell restrictions, when the target is in range
-- *****************************************************************************
function WARRIOR.Spells.Restrictions.ShortRange()
	if (WARRIOR.Player.Targeting:InRange(10)) then return true; end
	return false; 
end

-- *****************************************************************************
-- Function: Sunder
-- Purpose: sunder spell restrictions
-- *****************************************************************************
function WARRIOR.Spells.Restrictions.Sunder(class)
	local result = true;

	local i = 1
	while true do
		local texture, applications = UnitDebuff("target",i);
		if (not texture) then do break; end end
		
		if (string.find(texture,WARRIOR.Spells._spellbook[W.Spells.SunderArmor].texture)) then
			if (applications == WARRIOR.Player._maxsunders) then result = false; end
			do break; end
		end
		i = i + 1
	end
	
	if (not class) then WARRIOR.Player._maxsunders = 5; end
	return result;
end

-- *****************************************************************************
-- Function: Hamstring
-- Purpose: hamstring spell restrictions
-- *****************************************************************************
function WARRIOR.Spells.Restrictions.Hamstring(class)
	local spells = {
		"Ability_PoisonSting",   -- Crippling Poison
		"Ability_Rogue_Trip"     -- Wing Clip
	}

	local i = 1
	while (UnitDebuff("target",i)) do
		for _,texture in spells do
			if (string.find(UnitDebuff("target",i),texture)) then return; end
		end
	
		if (string.find(UnitDebuff("target",i),WARRIOR.Spells._spellbook[W.Spells.Hamstring].texture)) then return; end
		i = i + 1		
	end
	
	return 1;
end
