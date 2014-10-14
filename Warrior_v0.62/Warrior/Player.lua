WARRIOR.Player = {};
WARRIOR.Player.Targeting = {};

WARRIOR.Player._idle = true;
WARRIOR.Player._dueling = false;
WARRIOR.Player._maxsunders = 5;

WARRIOR.Player.Rage = {
	_enabled = false,
	_limit = 30
};

WARRIOR.Player.Stances = {
	_auto = true
};

-- player events
WARRIOR.Player._events = {
	dodged = false,
	parried = false,
	blocked = false
};

-- enemy events
WARRIOR.Enemy = {
	_dodged = false,
	_fleeing = false,
	_casting = false
};


-- *****************************************************************************
-- Function: OnEvent
-- Purpose: handle player events
-- *****************************************************************************
function WARRIOR.Player:OnEvent(event,arg1)
	-- detect spell casting
	local spellcasting = {
		patterns = {
			W.Patterns.BeginCast1,
			W.Patterns.BeginCast2 
		},
		events = {
			"CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE",
			"CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF",
			"CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE",
			"CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF"
		}
	};
	
	-- detect enemy beginning to cast a spell
	if (WARRIOR.Utils.Table:Find(spellcasting.events,event)) then
		for _,pattern in spellcasting.patterns do
			local _,_, caster, spell = string.find(arg1,pattern);
			if (caster and caster == UnitName("target") and spell) then
				WARRIOR.Enemy._casting = {timestamp = GetTime(), spell = spell};
			end
		end

	-- player is leaving combat
	elseif (event == "PLAYER_REGEN_ENABLED" and not self._idle) then self:ToggleCombatMode();
		
	-- player is entering combat
	elseif (event == "PLAYER_REGEN_DISABLED" and self._idle) then self:ToggleCombatMode();
	
	-- target has changed reset battle
	elseif (event == "PLAYER_TARGET_CHANGED") then 	
		WARRIOR.Alerts:Reset();
		WARRIOR.Classes:Reset();
	
	-- player is beginning a duel
	elseif (event == "DUEL_INBOUNDS" and not self._dueling) then self._dueling = true;
	
	-- player is ending a duel
	elseif (event == "DUEL_FINISHED" and self._dueling) then self._dueling = false;
	
	-- detect an enemy dodge
	elseif (event == "CHAT_MSG_COMBAT_SELF_MISSES" and string.find(arg1,W.Patterns.Dodge1)) then
		WARRIOR.Enemy._dodged = {timestamp = GetTime();}
		
	-- detect an enemy dodge
	elseif (event == "CHAT_MSG_SPELL_SELF_DAMAGE" and string.find(arg1,W.Patterns.Dodge2)) then
		WARRIOR.Enemy._dodged = {timestamp = GetTime();}

	-- detect player dodges/parries/blocks
	elseif (event == "CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES") then
		if (string.find(arg1,W.Patterns.Dodge)) then 
			WARRIOR.Player._events.dodged = {timestamp = GetTime();}
			
		elseif (string.find(arg1,W.Patterns.Parry)) then 
			WARRIOR.Player._events.parried = {timestamp = GetTime();}
			
		elseif (string.find(arg1,W.Patterns.Block)) then 
			WARRIOR.Player._events.blocked = {timestamp = GetTime();}
		end

	-- detect fleeing monsters
	elseif (event == "CHAT_MSG_MONSTER_EMOTE" and string.find(arg1,W.Patterns.Fleeing)) then
		WARRIOR.Enemy._fleeing = {timestamp = GetTime();}
	end
end

-- *****************************************************************************
-- Function: OnUpdate
-- Purpose: handle player updates
-- *****************************************************************************
function WARRIOR.Player:OnUpdate()
	-- player is entering combat
	if (self._idle and UnitAffectingCombat("player")) then 
		self:ToggleCombatMode();
		WARRIOR.Alerts:Reset();
		WARRIOR.Classes:Reset();
	end
	
	-- target has changed reset the class fifo's
	if (self._idle and self._target ~= UnitName("target")) then WARRIOR.Classes:Reset(); end
	
	-- purge old enemy events that have occurred
	for key,value in WARRIOR.Enemy do
		if (value and GetTime() - value.timestamp > 5) then WARRIOR.Enemy[key] = false; end
	end
	
	-- purge old player events that have occurred
	for key,value in WARRIOR.Player._events do
		if (value and GetTime() - value.timestamp > 5) then WARRIOR.Enemy[key] = false; end
	end
end

-- *****************************************************************************
-- Function: ToggleCombatMode
-- Purpose: toggles the current combat state of the player reserve
-- *****************************************************************************
function WARRIOR.Player:ToggleCombatMode()
	self._idle = WARRIOR.Utils:FlopBool(self._idle);
	WARRIOR.Alerts:Reset();
	
	if (self._idle) then 
		WARRIOR.Utils:Debug(1,"ToggleCombatMode: leaving combat."); 
	else
		WARRIOR.Utils:Debug(1,"ToggleCombatMode: entering combat.");	
	end	
end

-- *****************************************************************************
-- Function: SetReserve
-- Purpose: sets the current rage reserve
-- *****************************************************************************
function WARRIOR.Player.Rage:SetReserve(value)
	if (not value or value < 1 or value > 100) then return false; end

	self._limit = value;
	WARRIOR.Settings:Save("WARRIOR.Player.Rage._limit");
	return true;
end

-- *****************************************************************************
-- Function: Available
-- Purpose: checks to see if there is enough rage in the reserve
-- *****************************************************************************
function WARRIOR.Player.Rage:Available(spell)
	if (not spell or not WARRIOR.Spells._spellbook[spell]) then return false; end
	
	-- rage limit is disabled or spell doesn't require rage
	if (not self._enabled or not WARRIOR.Spells._spellbook[spell].rage) then return true; end

	-- spell is exempt from the rage limit
	if (WARRIOR.Utils.Table:Find(WARRIOR.Classes._database["RAGE"].spells,spell)) then return true; end

	-- spell is over the limit and can be cast
	if (WARRIOR.Spells._spellbook[spell].rage + self._limit <= UnitMana("player")) then return true; end
	
	return false;
end

-- *****************************************************************************
-- Function: InRange
-- Purpose: determines if a target is within a certian range (yards)
-- *****************************************************************************
function WARRIOR.Player.Targeting:InRange(range)
	-- target is outside a 10 yard radius
	if (range > 10) then
		if (CheckInteractDistance("target",4)) then return true; end
		return false;
	end
	
	-- target is within a 10 yard radius
	if (range > 5) then
		if (CheckInteractDistance("target",3)) then return true; end
		return false;
	end
	
	-- target is within a 5 yard radius
	if (CheckInteractDistance("target",1)) then return true; end
	return false;
end

-- *****************************************************************************
-- Function: AssistMostWounded
-- Purpose: assist the most wounded member of your party, if every one is at full the nearest enemy
-- *****************************************************************************
function WARRIOR.Player.Targeting:AssistMostWounded()
	local previous = {person = "player", health = 1};

	-- find the weakest party member and assit them
	local players = GetNumPartyMembers();
	for a = 1, players do
		-- check to see if the party member is in need of help
		local current = {person = "party" .. a, health = UnitHealth("party" .. a) / UnitHealthMax("party" .. a)};
		if (current["health"] < previous["health"]) then previous = current; end

		-- check to see if the party member's pet is in need of help
		current = {person = "partypet" .. a, health = UnitHealth("partypet" .. a) / UnitHealthMax("partypet" .. a)};
		if (current["health"] < previous["health"]) then previous = current; end
	end
	
	-- if no one needs assistance target the nearest enemy
	if (previous["person"] == "player" or not AssistUnit(previous["person"])) then
		TargetNearestEnemy();
		if (UnitExists("target") and UnitIsEnemy("player","target")) then
			AttackTarget();
		end;
	end
end

-- *****************************************************************************
-- Function: InStance
-- Purpose: used to verifiy that the player is in the specified stance
-- *****************************************************************************
function WARRIOR.Player.Stances:InStance(stance)
	for a = 1, GetNumShapeshiftForms() do
		local _, name, active = GetShapeshiftFormInfo(a);
		if (active and name == stance) then return true; end
	end
	
	return false;
end

-- *****************************************************************************
-- Function: Verify
-- Purpose: used to verifiy that the player is in the right stance
-- *****************************************************************************
function WARRIOR.Player.Stances:Verify(spell)
	if (not spell or not WARRIOR.Spells._spellbook[spell].stance) then return false; end
	
	local stances = WARRIOR.Spells._spellbook[spell].stance;
	for a = 1, GetNumShapeshiftForms() do
		local _, name, active = GetShapeshiftFormInfo(a);
		if (active and name ~= stances.primary and name ~= stances.secondary) then return name;	end
	end

	return false;
end

-- *****************************************************************************
-- Function: Toggle
-- Purpose: toggle between the two stances
-- *****************************************************************************
function WARRIOR.Player.Stances:Toggle(stance1, stance2)
	if (not stance1 or not stance2) then return false; end
	
	for a = 1, GetNumShapeshiftForms() do
		local _, name, active, castable = GetShapeshiftFormInfo(a);
		if (active and name == stance1 and castable) then
			WARRIOR.Spells:Cast(stance2);
			return;
		end	
		if (active and name == stance2 and castable) then
			WARRIOR.Spells:Cast(stance1);
			return;
		end
	end
	
	WARRIOR.Spells:Cast(stance1);
end

-- *****************************************************************************
-- Function: IsReady
-- Purpose: is the player ready to switch stances
-- *****************************************************************************
function WARRIOR.Player.Stances:IsReady(stance)
	if (not stance) then return "stance is nil"; end
	
	-- check if we are ready to change stances
	for a = 1, GetNumShapeshiftForms() do
		local _, name, active, castable = GetShapeshiftFormInfo(a);
		if ((active and name == stance) or (not active and not castable and name == stance)) then return "stance not ready"; end
	end
	
	local error = WARRIOR.Spells:IsReady(stance);
	if (error) then return error; end

	return false;
end

-- *****************************************************************************
-- Function: Cycle
-- Purpose: cycles between all three stances
-- *****************************************************************************
function WARRIOR.Player.Stances:Cycle(direction)
	local stances = {
		[W.Spells.BattleStance] = {forward = W.Spells.DefensiveStance, backward = W.Spells.BerserkerStance},
		[W.Spells.DefensiveStance] = {forward = W.Spells.BerserkerStance, backward = W.Spells.BattleStance},
		[W.Spells.BerserkerStance] = {forward = W.Spells.BattleStance, backward = W.Spells.DefensiveStance}
	};
	
	for a = 1, GetNumShapeshiftForms() do
		local _, name, active, castable = GetShapeshiftFormInfo(a);
		if (active and castable) then
			WARRIOR.Spells:Cast(stances[name][direction]);
			return;
		end
	end
end
