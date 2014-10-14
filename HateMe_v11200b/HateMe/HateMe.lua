-------------------------------------------------------------------------------
-- HateMe ... an aggro mod by Quu taken over by Somna
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- this is to track the entering and leaving of mellee combat
-------------------------------------------------------------------------------
function HateMe_EnterCombat()
	HateMe_debug( "Entering mellee combat");
	HateMe_MelleeMode = true;
end

function HateMe_LeaveCombat()
	HateMe_debug( "Leaving mellee combat");
	HateMe_MelleeMode = false;
end
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- this is called when ever the main bar changes due to a shapeshift/stance
-------------------------------------------------------------------------------
function HateMe_ShapeShift()
	HateMe_debug( "Shifting or checking forms/stances");
	local i;
	local max = GetNumShapeshiftForms();
	for i = 1 , max do
		local _, name, isActive = GetShapeshiftFormInfo(i);
		if isActive then
			HateMe_CurrentForm = name;
			return;
		end
	end
	HateMe_CurrentForm = "Default";
end
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- the stance/form logics
-- these are rather obvious... and should eb easy to read
-------------------------------------------------------------------------------

function HateMe_GainAggro( bank, spellArray)
	local func, id, spellName, currTarget;
	for id, spellName in spellArray do
		if (HateMe_SpellBook[spellName]) then
			currTarget = UnitName("target");
			if (HateMe_checkForImmunity(currTarget, spellName)) then
				HateMe_debug(currTarget.." is immune to "..spellName);
			else
				func = HateMe_FunctionLinks[spellName];
				if (func) then
					if (func(bank)) then
						return true;
					end
				end
			end
		end
	end
	return false
end

--------------------------
-- warrior beserker stance
--------------------------

function HateMe_BerserkerGainAggro()
	HateMe_debug( "entering HateMe berserker stance logic");

	-- no bank for this one...
	local bank = 0;

	-- spells in order that we will try them in
	local spellArray = {
		HateMe_SPELL_BERSERKER_RAGE,
		HateMe_SPELL_EXECUTE,
		HateMe_SPELL_BLOODRAGE,
		HateMe_SPELL_HAMSTRING,
		HateMe_SPELL_BATTLE_SHOUT,
		HateMe_SPELL_SHIELD_SLAM,
		HateMe_SPELL_SUNDER_ARMOR,
		HateMe_SPELL_HEROIC_STRIKE
	}

	HateMe_GainAggro( bank, spellArray);
end

function HateMe_BerserkerDPS()
	HateMe_debug( "entering HateYou berserker stance logic");

	-- no bank for this one...
	local bank = 0;

	-- spells in order that we will try them in
	local spellArray = {
		HateMe_SPELL_BERSERKER_RAGE,
		HateMe_SPELL_EXECUTE,
		HateMe_SPELL_BLOODRAGE,
		HateMe_SPELL_HAMSTRING,
		HateMe_SPELL_BATTLE_SHOUT,
		HateMe_SPELL_MORTAL_STRIKE,
		HateMe_SPELL_BLOODTHIRST,
		HateMe_SPELL_HEROIC_STRIKE
	}

	HateMe_GainAggro( bank, spellArray);
end

------------------------
-- warrior battle stance
------------------------

function HateMe_BattleGainAggro()
	HateMe_debug( "entering HateMe battle stance logic");

	-- we want to keep enuf rage to overpower in the bank at all times
	local bank = HateMe_GetBankAmount( HateMe_SPELL_OVERPOWER);

	-- spells in order that we will try them in
	local spellArray = {
		HateMe_SPELL_MOCKING_BLOW,
		HateMe_SPELL_OVERPOWER,
		HateMe_SPELL_EXECUTE,
		HateMe_SPELL_BLOODRAGE,
		HateMe_SPELL_HAMSTRING,
		HateMe_SPELL_BATTLE_SHOUT,
		HateMe_SPELL_SHIELD_SLAM,
		HateMe_SPELL_SUNDER_ARMOR,
		HateMe_SPELL_HEROIC_STRIKE
	}

	HateMe_GainAggro( bank, spellArray);
end

function HateMe_BattleDPS()
	HateMe_debug( "entering HateYou battle stance logic");

	-- we want to keep enuf rage to overpower in the bank at all times
	local bank = HateMe_GetBankAmount( HateMe_SPELL_OVERPOWER);

	-- spells in order that we will try them in
	local spellArray = {
		HateMe_SPELL_OVERPOWER,
		HateMe_SPELL_EXECUTE,
		HateMe_SPELL_BLOODRAGE,
		HateMe_SPELL_HAMSTRING,
		HateMe_SPELL_REND,
		HateMe_SPELL_BATTLE_SHOUT,
		HateMe_SPELL_MORTAL_STRIKE,
		HateMe_SPELL_BLOODTHIRST,
		HateMe_SPELL_HEROIC_STRIKE
	}

	HateMe_GainAggro( bank, spellArray);
end

---------------------------	
-- warrior defensive stance
---------------------------

function HateMe_DefensiveGainAggro()
	HateMe_debug( "entering the defensieve stance logic");

	-- we want to keep enuf rage to revenge in the bank at all times
	local bank = HateMe_GetBankAmount( HateMe_SPELL_REVENGE);

	-- spells in order that we will try them in
	local spellArray = {
		HateMe_SPELL_TAUNT,
		HateMe_SPELL_REVENGE,
		HateMe_SPELL_BLOODRAGE,
		HateMe_SPELL_SHIELD_BLOCK,
		HateMe_SPELL_BATTLE_SHOUT,
		HateMe_SPELL_SHIELD_SLAM,
		HateMe_SPELL_SUNDER_ARMOR,
		HateMe_SPELL_HEROIC_STRIKE
	}

	HateMe_GainAggro( bank, spellArray);
end

function HateMe_DefensiveDPS()
	HateMe_debug( "entering the defensieve stance logic");

	-- we want to keep enuf rage to revenge in the bank at all times
	local bank = HateMe_GetBankAmount( HateMe_SPELL_REVENGE);

	-- spells in order that we will try them in
	local spellArray = {
		HateMe_SPELL_REVENGE,
		HateMe_SPELL_BLOODRAGE,
		HateMe_SPELL_REND,
		HateMe_SPELL_BATTLE_SHOUT,
		HateMe_SPELL_MORTAL_STRIKE,
		HateMe_SPELL_BLOODTHIRST,
		HateMe_SPELL_HEROIC_STRIKE
	}

	HateMe_GainAggro( bank, spellArray);
end

------------------
-- druid
------------------

function HateMe_DruidGainAggro()
	HateMe_debug( "entering bear stance logic");

	-- no bank for bears
	local bank = 0;

	-- spells in order that we will try them in
	local spellArray = {
	    HateMe_BEAR2,
	    HateMe_BEAR1,
		HateMe_SPELL_GROWL,
		HateMe_SPELL_ENRAGE,
		HateMe_SPELL_FAERIE_FIRE_BEAR,
		HateMe_SPELL_BASH,
		HateMe_SPELL_SWIPE,
		HateMe_SPELL_MAUL
	}

	HateMe_GainAggro( bank, spellArray);
end

function HateMe_DruidDPS()
	HateMe_debug( "entering cat stance logic");

	-- no bank for cats
	local bank = 0;

	-- spells in order that we will try them in
	local spellArray = {
		HateMe_CAT,
		HateMe_SPELL_TIGER_FURY,
		HateMe_SPELL_RIP,
		HateMe_SPELL_RAKE,
		HateMe_SPELL_CLAW
	}

	HateMe_GainAggro( bank, spellArray);
end
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- this it the main aggro logic
-------------------------------------------------------------------------------
function HateMe_FeelTheHate(type)
	HateMe_debug("Feeling the hate!");
	if (not HateMe_SpellBook) then
		HateMe_println( HateMe_NO_HATE_SPELLS);
		return;
	end

	if (not UnitExists("target")) then
		HateMe_debug("No target selected!");
		return;
	end

	if (not HateMe_MelleeMode) then
		AttackTarget();
		-- we return here due to a timing "issue"...
		-- if we cast a spell to soon the attack does
		-- not always "stick"
		HateMe_debug( " entering mellee combat");
		return;
	end

	local canCastSpell = false;
	for spellName, spellID in HateMe_SpellBook do
		local last_cast, cooldown = GetSpellCooldown(spellID, BOOKTYPE_SPELL)
		if (cooldown ~= 0) then
	   		HateMe_debug(  "Spell not ready... "..spellName);
	   	else
	   		canCastSpell = true;
		end
	end
	if (not canCastSpell) then
		HateMe_debug( " all spells on cooldown...");
		return;
	end

	if (not HateMe_CurrentForm) then
		-- just in case we logged in and have not shifted forms yet
		HateMe_ShapeShift();
	end

	HateMe_Type = type;

	if (HateMe_Type == "HateMe") then
		if (UnitClass("player") == HateMe_Druid) then
			HateMe_DruidGainAggro();
		elseif (HateMe_CurrentForm == HateMe_DEFENSIVE) then
			HateMe_DefensiveGainAggro();
		elseif (HateMe_CurrentForm == HateMe_BATTLE) then
			HateMe_BattleGainAggro();
		elseif (HateMe_CurrentForm == HateMe_BERSERKER) then
			HateMe_BerserkerGainAggro();
		end
	elseif (HateMe_Type == "HateYou") then
		if (UnitClass("player") == HateMe_Druid) then
			HateMe_DruidDPS();
		elseif (HateMe_CurrentForm == HateMe_DEFENSIVE) then
			HateMe_DefensiveDPS();
		elseif (HateMe_CurrentForm == HateMe_BATTLE) then
			HateMe_BattleDPS();
		elseif (HateMe_CurrentForm == HateMe_BERSERKER) then
			HateMe_BerserkerDPS();
		end
	else
		HateMe_println ("HateMe ERROR: Nothing works!")
	end
end
-------------------------------------------------------------------------------

