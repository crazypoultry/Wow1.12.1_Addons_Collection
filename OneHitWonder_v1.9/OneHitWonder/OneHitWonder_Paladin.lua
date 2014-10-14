-- Kinesia. Added selectable Auras, Seals and Judgements 18/06/2006
-- Blessings and Exorcism 11/07/2006
OneHitWonder_Paladin_UseExorcism = 1;
OneHitWonder_Paladin_UseLayOnHands = 1;
OneHitWonder_Paladin_UseConsecration = 1;
OneHitWonder_Paladin_UseConsecrationManaPercentage = 60;
OneHitWonder_Paladin_UseHammerOfWrath = 1;
OneHitWonder_Paladin_UseJudgementOfRighteousness = 1;
OneHitWonder_Paladin_UseHammerOfJustice = 1;
OneHitWonder_Paladin_UseHammerOfJusticeReactively = 1;
OneHitWonder_Paladin_UseHammerOfJusticeAgainstRunners = 1;
OneHitWonder_Paladin_UseBlessing = 1;
OneHitWonder_Paladin_UseBlessing_Actions = {
ONEHITWONDER_SPELL_BLESSING_OF_MIGHT_NAME,
ONEHITWONDER_SPELL_BLESSING_OF_KINGS_NAME,
ONEHITWONDER_SPELL_BLESSING_OF_WISDOM_NAME,
ONEHITWONDER_SPELL_BLESSING_OF_LIGHT_NAME,
ONEHITWONDER_SPELL_BLESSING_OF_SANCTUARY_NAME,
ONEHITWONDER_SPELL_BLESSING_OF_SALVATION_NAME
};
OneHitWonder_Paladin_UseSeal = 3;
OneHitWonder_Paladin_UseSeal_Actions = {
	ONEHITWONDER_SPELL_SEAL_OF_COMMAND_NAME,
	ONEHITWONDER_SPELL_SEAL_OF_JUSTICE_NAME,
	ONEHITWONDER_SPELL_SEAL_OF_RIGHTEOUSNESS_NAME,
	ONEHITWONDER_SPELL_SEAL_OF_THE_CRUSADER_NAME,
	ONEHITWONDER_SPELL_SEAL_OF_LIGHT_NAME,
	ONEHITWONDER_SPELL_SEAL_OF_WISDOM_NAME
};
OneHitWonder_Paladin_UseJudgement = 4;
OneHitWonder_Paladin_UseJudgement_Actions = {
	ONEHITWONDER_SPELL_SEAL_OF_COMMAND_JUDGEMENT_EFFECT,
	ONEHITWONDER_SPELL_SEAL_OF_JUSTICE_JUDGEMENT_EFFECT,
	ONEHITWONDER_SPELL_SEAL_OF_RIGHTEOUSNESS_JUDGEMENT_EFFECT,
	ONEHITWONDER_SPELL_SEAL_OF_THE_CRUSADER_JUDGEMENT_EFFECT,
	ONEHITWONDER_SPELL_SEAL_OF_LIGHT_JUDGEMENT_EFFECT,
	ONEHITWONDER_SPELL_SEAL_OF_WISDOM_JUDGEMENT_EFFECT
};
OneHitWonder_Paladin_UseAura = 1;
OneHitWonder_Paladin_UseAura_Actions = {
	ONEHITWONDER_SPELL_DEVOTION_AURA_NAME,
	ONEHITWONDER_SPELL_CONCENTRATION_AURA_NAME,
	ONEHITWONDER_SPELL_RETRIBUTION_AURA_NAME,
	ONEHITWONDER_SPELL_SANCTITY_AURA_NAME,
	ONEHITWONDER_SPELL_FROST_RESISTANCE_AURA_NAME,
	ONEHITWONDER_SPELL_FIRE_RESISTANCE_AURA_NAME,
	ONEHITWONDER_SPELL_SHADOW_RESISTANCE_AURA_NAME
};


function OneHitWonder_Paladin_SetUseHammerOfWrath(toggle)
	OneHitWonder_Paladin_UseHammerOfWrath = toggle;
end

function OneHitWonder_Paladin_SetUseHammerOfJustice(toggle)
	OneHitWonder_Paladin_UseHammerOfJustice = toggle;
end

function OneHitWonder_Paladin_SetUseHammerOfJusticeReactively(toggle)
	OneHitWonder_Paladin_UseHammerOfJusticeReactively = toggle;
end

function OneHitWonder_Paladin_SetUseExorcism(toggle)
	OneHitWonder_Paladin_UseExorcism = toggle;
end

function OneHitWonder_Paladin_SetUseLayOnHands(toggle)
	OneHitWonder_Paladin_UseLayOnHands = toggle;
end

function OneHitWonder_Paladin_SetUseConsecration(toggle)
	OneHitWonder_Paladin_UseConsecration = toggle;
end

function OneHitWonder_Paladin_SetConsecrationManaPercentage(toggle,value)
	OneHitWonder_Paladin_UseConsecrationManaPercentage = value;
end

function OneHitWonder_Paladin_SetUseHammerOfJusticeAgainstRunners(toggle)
	OneHitWonder_Paladin_UseHammerOfJusticeAgainstRunners = toggle;
end

function OneHitWonder_Paladin_SetBlessing(toggle, value)
	OneHitWonder_Paladin_UseBlessing = value;
end

function OneHitWonder_Paladin_SetSeal(toggle, value)
	OneHitWonder_Paladin_UseSeal = value;
end

function OneHitWonder_Paladin_SetJudgement(toggle, value)
	OneHitWonder_Paladin_UseJudgement = value;
end

function OneHitWonder_Paladin_SetUseJudgementOfRighteousness(toggle)
	OneHitWonder_Paladin_UseJudgementOfRighteousness = toggle;
end

function OneHitWonder_Paladin_SetAura(toggle, value)
	OneHitWonder_Paladin_UseAura = value;
end

function OneHitWonder_Init_Paladin()
	OneHitWonder_Options["OneHitWonder_Paladin_UseJudgement"] = OneHitWonder_Paladin_UseJudgement;
	OneHitWonder_Options["OneHitWonder_Paladin_UseJudgementOfRighteousness"] = OneHitWonder_Paladin_UseJudgementOfRighteousness;
	OneHitWonder_Options["OneHitWonder_Paladin_UseExorcism"] = OneHitWonder_Paladin_UseExorcism;
	OneHitWonder_Options["OneHitWonder_Paladin_UseLayOnHands"] = OneHitWonder_Paladin_UseLayOnHands;
	OneHitWonder_Options["OneHitWonder_Paladin_UseConsecration"] = OneHitWonder_Paladin_UseConsecration;
	OneHitWonder_Options["OneHitWonder_Paladin_UseConsecrationManaPercentage"] = OneHitWonder_Paladin_UseConsecrationManaPercentage;
	OneHitWonder_Options["OneHitWonder_Paladin_UseSeal"] = OneHitWonder_Paladin_UseSeal;
	OneHitWonder_Options["OneHitWonder_Paladin_UseBlessing"] = OneHitWonder_Paladin_UseBlessing;
	OneHitWonder_Options["OneHitWonder_Paladin_UseHammerOfWrath"] = OneHitWonder_Paladin_UseHammerOfWrath;
	OneHitWonder_Options["OneHitWonder_Paladin_UseHammerOfJustice"] = OneHitWonder_Paladin_UseHammerOfJustice;
	OneHitWonder_Options["OneHitWonder_Paladin_UseHammerOfJusticeReactively"] = OneHitWonder_Paladin_UseHammerOfJusticeReactively;
	OneHitWonder_Options["OneHitWonder_Paladin_UseHammerOfJusticeAgainstRunners"] = OneHitWonder_Paladin_UseHammerOfJusticeAgainstRunners;
	OneHitWonder_Options["OneHitWonder_Paladin_UseAura"] = OneHitWonder_Paladin_UseAura;
end

function OneHitWonder_PaladinMoreThanOnePaladinInGroup()
	local nr = OneHitWonder_GetNumberOfClassInGroup(ONEHITWONDER_CLASS_PALADIN);
	if ( ( nr ) and ( nr > 1 ) ) then
		return true;
	else
		return false;
	end
end

function OneHitWonder_GetCurrentSeal()
	-- Kinesia. Corrected old function.
	local i = 1
	while UnitBuff("player", i) do
		OneHitWonderTooltip:SetOwner(UIParent,"ANCHOR_NONE");
		OneHitWonderTooltipTextLeft1:SetText('');
		OneHitWonderTooltip:SetUnitBuff("player", i);
		-- If the Tooltip has text on the Left1 it may be a buff player can cast
		buffName = OneHitWonderTooltipTextLeft1:GetText()
		if (buffName and strfind(buffName, "Seal") ) then
				return buffName
		end
		i = i + 1
	end
	return nil;
end

function OneHitWonder_TargetIsRunningAway_Paladin()
	if ( not OneHitWonder_HasUnitEffect("target", nil, ONEHITWONDER_STUN_EFFECTS) and OneHitWonder_Paladin_UseHammerOfJusticeAgainstRunners == 1 ) then
	    spellName = OneHitWonder_Paladin_GetHighestStunSpellName()
		local spellId = OneHitWonder_GetSpellId(spellName);
		if ( spellId > -1 ) then
			local parameters = { spellId, GetTime() + 3};
			OneHitWonder_AddActionToQueue(ONEHITWONDER_ACTIONID_SPELL_TIMEOUT, parameters);
		end
	end
end

function OneHitWonder_Paladin_GetDesiredJugdementSealSpellName()
	local judgementName = OneHitWonder_Paladin_UseJudgement_Actions[OneHitWonder_Paladin_UseJudgement]
	local judgeNumber = -1 -- Righteousness since it just damages and doesnt remove existing seal
	if (OneHitWonder_Paladin_UseJudgementOfRighteousness==1) then
		if (OneHitWonder_Paladin_UseSeal==1) then
	    	judgeNumber = 1 -- Command if we're already using command to save mana.
		else
	    	judgeNumber = 3 -- Righteousness since it just damages and doesnt remove existing seal
		end
	end
	if (not OneHitWonder_HasUnitEffect("target", nil,judgementName)) then
		judgeNumber = OneHitWonder_Paladin_UseJudgement
	end
	local spellName = nil
	if (judgeNumber > -1) then
	   spellName = OneHitWonder_Paladin_UseSeal_Actions[judgeNumber]
	end
	return spellName;
end

function OneHitWonder_Paladin_GetDesiredPoundingSealSpellName()
	local spellName = OneHitWonder_Paladin_UseSeal_Actions[OneHitWonder_Paladin_UseSeal]
--[[	local spellName = ONEHITWONDER_SPELL_SEAL_OF_THE_CRUSADER_NAME;
	if ( OneHitWonder_GetSpellId(spellName) <= -1 ) or ( OneHitWonder_HasUnitEffect("target", nil, ONEHITWONDER_SPELL_SEAL_OF_THE_CRUSADER_JUDGEMENT_EFFECT) ) then
		spellName = ONEHITWONDER_SPELL_SEAL_OF_RIGHTEOUSNESS_NAME;
	end]]--
	return spellName;
end

function OneHitWonder_Paladin(removeDefense)
	local targetName = UnitName("target");

	if ( OneHitWonder_IsChannelSpellRunning() ) or ( OneHitWonder_IsRegularSpellRunning() ) then
		return;
	end
	
	if ( OneHitWonder_UseCountermeasures() ) then
		return;
	end
	
	if ( (not targetName) or ( strlen(targetName) <= 0 ) or ( ( not UnitCanAttack("target", "player") ) ) ) then
		--if ( OneHitWonder_ShouldOverrideBindings ~= 1 ) then
			if ( not OneHitWonder_DoStuffContinuously() ) then
				OneHitWonder_DoBuffs();
			end
		--end
		return;
	end

	if (not OneHitWonder_StartCombat()) then
		 return OneHitWonder_DoStuffContinuously();
	end

	OneHitWonder_MeleeAttack();
	
	if ( OneHitWonder_Paladin_UseExorcism and (UnitCreatureType("target") == ONEHITWONDER_CREATURE_TYPE_UNDEAD or UnitCreatureType("target") == ONEHITWONDER_CREATURE_TYPE_DEMON)) then
		local spellId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_EXORCISM_NAME);
		if ( spellId > -1 ) then
			if (OneHitWonder_CastSpell(spellId)) then
				return;
			end
		end
	end
	local unitHPPercent = OneHitWonder_GetTargetHPPercentage();
	if ( OneHitWonder_Paladin_UseHammerOfWrath and unitHPPercent<=20) then
		local spellId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_HAMMER_OF_WRATH_NAME);
		if ( spellId > -1 ) then
			if (OneHitWonder_CastSpell(spellId)) then
				return;
			end
		end
	end
	local judgmentId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_JUDGEMENT_NAME);
	local spellBook = OneHitWonder_GetSpellBook(spellBook);
	local start, duration, enable = GetSpellCooldown(judgmentId, spellBook);
	local isJudgementAvailable = OneHitWonder_IsSpellAvailable(judgmentId);
	local currentSeal = OneHitWonder_GetCurrentSeal();
	local PoundingSeal = OneHitWonder_Paladin_GetDesiredPoundingSealSpellName()
	if ( (OneHitWonder_Paladin_UseHammerOfJustice == 1) and (isJudgementAvailable or start == 0) and (currentSeal == PoundingSeal))  then 
		local spellId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_HAMMER_OF_JUSTICE_NAME);
		if ( spellId > -1 ) then
			if (OneHitWonder_CastSpell(spellId)) then
				return;
			end
		end
	end
	if ( judgmentId <= -1 ) then
		local spellName = PoundingSeal;
		if (not currentSeal) then
			local spellId = OneHitWonder_GetSpellId(spellName);
			if ( spellId > -1 ) then
				OneHitWonder_CastSpell(spellId);
				return;
			end
		end
	else
		local spellName = PoundingSeal;
		local spellId = -1;
		if ( not currentSeal ) then
			if ( start == 0 ) then
				spellName = OneHitWonder_Paladin_GetDesiredJugdementSealSpellName();
			else
				spellName = PoundingSeal;
			end
		elseif ( isJudgementAvailable ) then
			spellName = OneHitWonder_Paladin_GetDesiredJugdementSealSpellName();
			if ( spellName == currentSeal ) then
				spellName = ONEHITWONDER_SPELL_JUDGEMENT_NAME;
			end
		else
			spellName = nil;
		end
				
		if ( spellName ) then
			spellId = OneHitWonder_GetSpellId(spellName);
		end
		if ( spellId > -1 ) then
			OneHitWonder_CastSpellOnTarget(spellId);
			return;
		end
	end
	
	local playerManaPercent = OneHitWonder_GetPlayerManaPercentage();
	local playerHealthPercent = OneHitWonder_GetPlayerHPPercentage();
	if ( (OneHitWonder_Paladin_UseConsecration == 1) and (playerManaPercent>OneHitWonder_Paladin_UseConsecrationManaPercentage) and OneHitWonder_CheckIfInRangeSpellId(judgmentId)) then
		local spellId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_CONSECRATION_NAME);
		if ( spellId > -1 ) then
			if (OneHitWonder_CastSpell(spellId)) then
				return;
			end
		end
	end
	if ( (playerManaPercent<=20) and (playerHealthPercent<=5) and UnitIsUnit("targettarget","player")) then
		local spellId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_LAY_ON_HANDS_NAME);
		if ( spellId > -1 ) then
			if (CastSpellByName(ONEHITWONDER_SPELL_LAY_ON_HANDS_NAME, true)) then
				return;
			end
		end
	end
	
	if ( not OneHitWonder_DoBuffs() and not OneHitWonder_DoStuffContinuously()) then
		OneHitWonder_CheckFriendlies();
		OneHitWonder_HandleActionQueue();
	end
	return;
end

function OneHitWonder_Paladin_GetCasterBuffName(unit)
	local buffList = { ONEHITWONDER_SPELL_BLESSING_OF_WISDOM_NAME, ONEHITWONDER_SPELL_BLESSING_OF_KINGS_NAME, ONEHITWONDER_SPELL_BLESSING_OF_MIGHT_NAME };
	if ( UnitLevel(unit) > UnitLevel("player") ) then
		if ( OneHitWonder_IsUnitTeamMember(unit) ) then
			buffList = { ONEHITWONDER_SPELL_BLESSING_OF_SALVATION_NAME, ONEHITWONDER_SPELL_BLESSING_OF_WISDOM_NAME, ONEHITWONDER_SPELL_BLESSING_OF_KINGS_NAME, ONEHITWONDER_SPELL_BLESSING_OF_MIGHT_NAME };
		end
	end
	return buffList;
end

ONEHITWONDER_PALADIN_SEQUENCE_BLESSING = "BLESSING";

function OneHitWonder_SetupSequenceContinuously_Paladin()
	OneHitWonder_AddContinuousSequence(ONEHITWONDER_PALADIN_SEQUENCE_BLESSING);
end

function OneHitWonder_GetBuffName_Paladin(sequenceId, unit)
	if ( sequenceId == ONEHITWONDER_PALADIN_SEQUENCE_BLESSING ) then
		local ohwClass = OneHitWonder_GetUnitClass(unit);
		if ( OneHitWonder_Paladin_PreferredBlessingList ) then
			local index = ohwClass;
			if ( not OneHitWonder_Paladin_PreferredBlessingList[index] ) then
				index = UnitClass(unit);
			end
			if ( OneHitWonder_Paladin_PreferredBlessingList[index] ) then
				return OneHitWonder_Paladin_PreferredBlessingList[index];
			end
		end
		if ( ohwClass == ONEHITWONDER_CLASS_DRUID ) then
			local pt = UnitPowerType(unit);
			local buffList = { ONEHITWONDER_SPELL_BLESSING_OF_KINGS_NAME, ONEHITWONDER_SPELL_BLESSING_OF_MIGHT_NAME, ONEHITWONDER_SPELL_BLESSING_OF_KINGS_NAME };
			if ( UnitLevel(unit) > UnitLevel("player") ) then
				if ( OneHitWonder_IsUnitTeamMember(unit) ) then
					buffList = { ONEHITWONDER_SPELL_BLESSING_OF_KINGS_NAME, ONEHITWONDER_SPELL_BLESSING_OF_SALVATION_NAME, ONEHITWONDER_SPELL_BLESSING_OF_MIGHT_NAME };
				end
			end
			if (pt == ONEHITWONDER_POWERTYPE_MANA ) then
				buffList = OneHitWonder_Paladin_GetCasterBuffName(unit);
			end
			return buffList;
		end
		if ( unit == "player" ) or ( ohwClass == ONEHITWONDER_CLASS_PALADIN ) then
			return { OneHitWonder_Paladin_UseBlessing_Actions[OneHitWonder_Paladin_UseBlessing], ONEHITWONDER_SPELL_BLESSING_OF_KINGS_NAME, ONEHITWONDER_SPELL_BLESSING_OF_WISDOM_NAME, ONEHITWONDER_SPELL_BLESSING_OF_MIGHT_NAME };
		end
		if ( OneHitWonder_IsStringInList(ohwClass, OneHitWonder_CasterClassesArray) ) then
			return OneHitWonder_Paladin_GetCasterBuffName(unit);
		end
		if ( ohwClass == ONEHITWONDER_CLASS_ROGUE ) then
			return { ONEHITWONDER_SPELL_BLESSING_OF_KINGS_NAME, ONEHITWONDER_SPELL_BLESSING_OF_MIGHT_NAME };
		end
	    if ( ohwClass == ONEHITWONDER_CLASS_WARRIOR ) then
			return { ONEHITWONDER_SPELL_BLESSING_OF_SANCTUARY_NAME, ONEHITWONDER_SPELL_BLESSING_OF_KINGS_NAME, ONEHITWONDER_SPELL_BLESSING_OF_MIGHT_NAME };
		end
	end
	return nil;
end


function OneHitWonder_SetupStuffContinuously_Paladin()
	local fiveMin = math.floor(4.5*60);
	OneHitWonder_BuffTime[ONEHITWONDER_SPELL_BLESSING_OF_MIGHT_NAME] = fiveMin;
	OneHitWonder_BuffTime[ONEHITWONDER_SPELL_BLESSING_OF_PROTECTION_NAME] = 7;
	OneHitWonder_BuffTime[ONEHITWONDER_SPELL_BLESSING_OF_FREEDOM_NAME] = 11;
	OneHitWonder_BuffTime[ONEHITWONDER_SPELL_BLESSING_OF_SALVATION_NAME] = fiveMin;
	OneHitWonder_BuffTime[ONEHITWONDER_SPELL_BLESSING_OF_SANCTUARY_NAME] = fiveMin;
	OneHitWonder_BuffTime[ONEHITWONDER_SPELL_BLESSING_OF_LIGHT_NAME] = fiveMin;
	OneHitWonder_BuffTime[ONEHITWONDER_SPELL_BLESSING_OF_SACRIFICE_NAME] = 30;
	OneHitWonder_BuffTime[ONEHITWONDER_SPELL_BLESSING_OF_KINGS_NAME] = fiveMin;
	
	local bestMeleeBlessing = { ONEHITWONDER_SPELL_BLESSING_OF_KINGS_NAME, ONEHITWONDER_SPELL_BLESSING_OF_MIGHT_NAME };
	local bestCasterBlessing = ONEHITWONDER_SPELL_BLESSING_OF_WISDOM_NAME;
	local bestCasterBlessingTarget = ONEHITWONDER_SPELL_BLESSING_OF_WISDOM_NAME;
	local bestDruidCasterBlessing = ONEHITWONDER_SPELL_BLESSING_OF_WISDOM_NAME;
	local bestDruidTankBlessing = { ONEHITWONDER_SPELL_BLESSING_OF_KINGS_NAME, ONEHITWONDER_SPELL_BLESSING_OF_MIGHT_NAME };
	local bestDruidDPSBlessing = { ONEHITWONDER_SPELL_BLESSING_OF_KINGS_NAME, ONEHITWONDER_SPELL_BLESSING_OF_MIGHT_NAME };
	
	if ( OneHitWonder_IsUnitTeamMember(unit) ) then
		bestCasterBlessing = { ONEHITWONDER_SPELL_BLESSING_OF_WISDOM_NAME, ONEHITWONDER_SPELL_BLESSING_OF_SALVATION_NAME, ONEHITWONDER_SPELL_BLESSING_OF_KINGS_NAME, ONEHITWONDER_SPELL_BLESSING_OF_MIGHT_NAME };
		bestDruidCasterBlessing = { ONEHITWONDER_SPELL_BLESSING_OF_WISDOM_NAME, ONEHITWONDER_SPELL_BLESSING_OF_SALVATION_NAME, ONEHITWONDER_SPELL_BLESSING_OF_KINGS_NAME, ONEHITWONDER_SPELL_BLESSING_OF_MIGHT_NAME };
	else
		bestCasterBlessing = { ONEHITWONDER_SPELL_BLESSING_OF_WISDOM_NAME, ONEHITWONDER_SPELL_BLESSING_OF_KINGS_NAME, ONEHITWONDER_SPELL_BLESSING_OF_MIGHT_NAME };
		bestDruidCasterBlessing = { ONEHITWONDER_SPELL_BLESSING_OF_WISDOM_NAME, ONEHITWONDER_SPELL_BLESSING_OF_KINGS_NAME, ONEHITWONDER_SPELL_BLESSING_OF_MIGHT_NAME };
	end
	
	--[[
	
	OneHitWonder_AddStuffContinuously(bestMeleeBlessing, false, true, {onlyBuffClass = { ONEHITWONDER_CLASS_WARRIOR }, canOverrideEffect=true});
	OneHitWonder_AddStuffContinuously(bestMeleeBlessing, false, true, {onlyBuffClass = {ONEHITWONDER_CLASS_ROGUE}, canOverrideEffect=true});
	OneHitWonder_AddStuffContinuously({ ONEHITWONDER_SPELL_BLESSING_OF_MIGHT_NAME, ONEHITWONDER_SPELL_BLESSING_OF_WISDOM_NAME, ONEHITWONDER_SPELL_BLESSING_OF_KINGS_NAME }, false, true, {onlyBuffClass = {ONEHITWONDER_CLASS_PALADIN}, canOverrideEffect=true});
	OneHitWonder_AddStuffContinuously(bestDruidCasterBlessing, false, true, {onlyBuffClass = {ONEHITWONDER_CLASS_DRUID}, powerType = { ONEHITWONDER_POWERTYPE_MANA }, canOverrideEffect=true });
	OneHitWonder_AddStuffContinuously(bestDruidDPSBlessing, false, true, {onlyBuffClass = {ONEHITWONDER_CLASS_DRUID}, powerType = { ONEHITWONDER_POWERTYPE_ENERGY}, canOverrideEffect=true });
	OneHitWonder_AddStuffContinuously(bestDruidTankBlessing, false, true, {onlyBuffClass = {ONEHITWONDER_CLASS_DRUID}, powerType = { ONEHITWONDER_POWERTYPE_RAGE}, canOverrideEffect=true });
	OneHitWonder_AddStuffContinuously(bestCasterBlessing, false, true, {onlyBuffClass = OneHitWonder_CasterClassesArray, invalidUnit = {"target"}, canOverrideEffect=true });
	OneHitWonder_AddStuffContinuously(bestCasterBlessingTarget, false, true, {onlyBuffClass = OneHitWonder_CasterClassesArray, validUnit = {"target"}, canOverrideEffect=true});
	]]--
end

function OneHitWonder_Paladin_GetHighestStunSpellName()
	return ONEHITWONDER_SPELL_HAMMER_OF_JUSTICE_NAME;
end

function OneHitWonder_TryToInterruptSpell_Paladin(unitName, spellName)
	local interruptId = -1;
	local abilityName = "";
	abilityName = OneHitWonder_Paladin_GetHighestStunSpellName();
	if ( OneHitWonder_Paladin_UseHammerOfJusticeReactively ~= 1 ) then
		abilityName = "";
	end
	if ( ( abilityName ) and 
		(strlen(abilityName) > 0) ) then
		interruptId = OneHitWonder_GetSpellId(abilityName, "highest");
		if ( not OneHitWonder_IsSpellAvailable(interruptId) ) then
			abilityName = "";
			interruptId = -1;
		end
	end
	return interruptId, abilityName;
end


function OneHitWonder_Paladin_Cosmos()
	if ( Cosmos_RegisterConfiguration ) and ( Cosmos_UpdateValue ) then
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_PALADIN_SEPARATOR",
			"SEPARATOR",
			TEXT(ONEHITWONDER_PALADIN_SEPARATOR),
			TEXT(ONEHITWONDER_PALADIN_SEPARATOR_INFO)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_PALADIN_USE_EXORCISM",
			"CHECKBOX",
			TEXT(ONEHITWONDER_PALADIN_USE_EXORCISM),
			TEXT(ONEHITWONDER_PALADIN_USE_EXORCISM_INFO),
			OneHitWonder_Paladin_SetUseExorcism,
			OneHitWonder_Paladin_UseExorcism
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_PALADIN_USE_LAY_ON_HANDS",
			"CHECKBOX",
			TEXT(ONEHITWONDER_PALADIN_USE_LAY_ON_HANDS),
			TEXT(ONEHITWONDER_PALADIN_USE_LAY_ON_HANDS_INFO),
			OneHitWonder_Paladin_SetUseLayOnHands,
			OneHitWonder_Paladin_UseLayOnHands
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_PALADIN_USE_CONSECRATION",
			"CHECKBOX",
			TEXT(ONEHITWONDER_PALADIN_USE_CONSECRATION),
			TEXT(ONEHITWONDER_PALADIN_USE_CONSECRATION_INFO),
			OneHitWonder_Paladin_SetUseConsecration,
			OneHitWonder_Paladin_UseConsecration
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_PALADIN_USE_CONSECRATION_MANA",
			"SLIDER",
			TEXT(ONEHITWONDER_PALADIN_USE_CONSECRATION_MANA),
			TEXT(ONEHITWONDER_PALADIN_USE_CONSECRATION_MANA_INFO),
			OneHitWonder_Paladin_SetConsecrationManaPercentage,
			1,
			OneHitWonder_Paladin_UseConsecrationManaPercentage,
			1,
			100,
			"",
			1,
			1,
			TEXT(ONEHITWONDER_PALADIN_USE_CONSECRATION_MANA_APPEND)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_PALADIN_USE_JUDGEMENT_OF_RIGHTEOUSNESS",
			"CHECKBOX",
			TEXT(ONEHITWONDER_PALADIN_USE_JUDGEMENT_OF_RIGHTEOUSNESS),
			TEXT(ONEHITWONDER_PALADIN_USE_JUDGEMENT_OF_RIGHTEOUSNESS_INFO),
			OneHitWonder_Paladin_SetUseJudgementOfRighteousness,
			OneHitWonder_Paladin_UseJudgementOfRighteousness
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_PALADIN_USE_HAMMER_OF_WRATH",
			"CHECKBOX",
			TEXT(ONEHITWONDER_PALADIN_USE_HAMMER_OF_WRATH),
			TEXT(ONEHITWONDER_PALADIN_USE_HAMMER_OF_WRATH_INFO),
			OneHitWonder_Paladin_SetUseHammerOfWrath,
			OneHitWonder_Paladin_UseHammerOfWrath
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_PALADIN_USE_HAMMER_OF_JUSTICE",
			"CHECKBOX",
			TEXT(ONEHITWONDER_PALADIN_USE_HAMMER_OF_JUSTICE),
			TEXT(ONEHITWONDER_PALADIN_USE_HAMMER_OF_JUSTICE_INFO),
			OneHitWonder_Paladin_SetUseHammerOfJustice,
			OneHitWonder_Paladin_UseHammerOfJustice
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_PALADIN_USE_HAMMER_OF_JUSTICE_REACTIVELY",
			"CHECKBOX",
			TEXT(ONEHITWONDER_PALADIN_USE_HAMMER_OF_JUSTICE_REACTIVELY),
			TEXT(ONEHITWONDER_PALADIN_USE_HAMMER_OF_JUSTICE_REACTIVELY_INFO),
			OneHitWonder_Paladin_SetUseHammerOfJusticeReactively,
			OneHitWonder_Paladin_UseHammerOfJusticeReactively
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_PALADIN_USE_HAMMER_OF_JUSTICE_AGAINST_RUNNERS",
			"CHECKBOX",
			TEXT(ONEHITWONDER_PALADIN_USE_HAMMER_OF_JUSTICE_AGAINST_RUNNERS),
			TEXT(ONEHITWONDER_PALADIN_USE_HAMMER_OF_JUSTICE_AGAINST_RUNNERS_INFO),
			OneHitWonder_Paladin_SetUseHammerOfJusticeAgainstRunners,
			OneHitWonder_Paladin_UseHammerOfJusticeAgainstRunners
		);
		local blessingDescs = "";
		for k, v in OneHitWonder_Paladin_UseBlessing_Actions do
			blessingDescs = blessingDescs..string.format(" %d = %s.", k, v); 
		end
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_PALADIN_USE_BLESSING",
			"SLIDER",
			TEXT(ONEHITWONDER_PALADIN_USE_BLESSING),
			TEXT(ONEHITWONDER_PALADIN_USE_BLESSING_INFO)..blessingDescs,
			OneHitWonder_Paladin_SetBlessing,
			1, 
			OneHitWonder_Paladin_UseBlessing,
			0,
			table.getn(OneHitWonder_Paladin_UseBlessing_Actions),
			"",
			1,
			1,
			""
		);
		local sealDescs = "";
		for k, v in OneHitWonder_Paladin_UseSeal_Actions do
			sealDescs = sealDescs..string.format(" %d = %s.", k, v); 
		end
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_PALADIN_USE_SEAL",
			"SLIDER",
			TEXT(ONEHITWONDER_PALADIN_USE_SEAL),
			TEXT(ONEHITWONDER_PALADIN_USE_SEAL_INFO)..sealDescs,
			OneHitWonder_Paladin_SetSeal,
			1, 
			OneHitWonder_Paladin_UseSeal,
			0,
			table.getn(OneHitWonder_Paladin_UseSeal_Actions),
			"",
			1,
			1,
			""
		);
		local judgementDescs = "";
		for k, v in OneHitWonder_Paladin_UseJudgement_Actions do
			judgementDescs = judgementDescs..string.format(" %d = %s.", k, v); 
		end
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_PALADIN_USE_JUDGEMENT",
			"SLIDER",
			TEXT(ONEHITWONDER_PALADIN_USE_JUDGEMENT),
			TEXT(ONEHITWONDER_PALADIN_USE_JUDGEMENT_INFO)..judgementDescs,
			OneHitWonder_Paladin_SetJudgement,
			1, 
			OneHitWonder_Paladin_UseJudgement,
			0,
			table.getn(OneHitWonder_Paladin_UseJudgement_Actions),
			"",
			1,
			1,
			""
		);
		local auraDescs = "";
		for k, v in OneHitWonder_Paladin_UseAura_Actions do
			auraDescs = auraDescs..string.format(" %d = %s.", k, v); 
		end
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_PALADIN_USE_AURA",
			"SLIDER",
			TEXT(ONEHITWONDER_PALADIN_USE_AURA),
			TEXT(ONEHITWONDER_PALADIN_USE_AURA_INFO)..auraDescs,
			OneHitWonder_Paladin_SetAura,
			1, 
			OneHitWonder_Paladin_UseAura,
			0,
			table.getn(OneHitWonder_Paladin_UseAura_Actions),
			"",
			1,
			1,
			""
		);
	end
end

function OneHitWonder_Paladin_RetrieveCleansingSpellId(unit)
	if ( OneHitWonder_IsUnitValidToClean(unit) ) then
		if ( OneHitWonder_ShouldAutoCure == 1 ) then
			local purifyId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_PURIFY_NAME);
			local cleanseId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_CLEANSE_NAME);
			if ( cleanseId > -1 ) or ( purifyId > -1 ) then
				local debuffsByType = OneHitWonder_GetDebuffsByType(unit);
				local hasDisease = (( debuffsByType[ONEHITWONDER_DEBUFF_TYPE_DISEASE] ) and ( table.getn(debuffsByType[ONEHITWONDER_DEBUFF_TYPE_DISEASE]) > 0 ));
				local hasPoison = (( debuffsByType[ONEHITWONDER_DEBUFF_TYPE_POISON] ) and ( table.getn(debuffsByType[ONEHITWONDER_DEBUFF_TYPE_POISON]) > 0 ));
				local hasMagic = (( debuffsByType[ONEHITWONDER_DEBUFF_TYPE_MAGIC] ) and ( table.getn(debuffsByType[ONEHITWONDER_DEBUFF_TYPE_MAGIC]) > 0 ));
				local spellId = -1;
				if ( not hasMagic ) then
					if ( hasDisease ) or ( hasPoison ) then
						spellId = purifyId;
					end
				else
					spellId = cleanseId;
					if ( spellId <= -1 ) then
						if ( hasDisease ) or ( hasPoison ) then
							spellId = purifyId;
						end
					end
				end
				if ( spellId > -1 ) then
					return spellId;
				end
			end
		end
	end
	return -1;
end

function OneHitWonder_CheckEffect_Paladin(unit)
	if ( UnitCanAttack("player", unit) ) then
		return false;
	end
	local doneStuff = false;
	local spellId = OneHitWonder_Paladin_RetrieveCleansingSpellId(unit);
	if ( spellId ) and ( spellId > -1 ) then
		local actionId = OneHitWonder_GetActionIdFromSpellId(spellId);
		if ( unit == "player" ) and ( actionId ) and ( actionId > -1 ) then
			local parameters = { actionId, spellId };
			OneHitWonder_AddActionToQueue(ONEHITWONDER_ACTIONID_ACTION_SELF, parameters);
			doneStuff = true;
		elseif ( not OneHitWonder_HasTarget() ) or ( UnitName("target") == UnitName(unit) ) or ( UnitCanAttack("target", "player") ) then
			local parameters = { spellId, unit };
			OneHitWonder_AddActionToQueue(ONEHITWONDER_ACTIONID_SPELL_TARGET, parameters);
			doneStuff = true;
		end
	end
	return doneStuff;
end


function OneHitWonder_DoStuffContinuously_Paladin()
	if ( not OneHitWonder_IsEnabled() ) then return false; end

	if ( OneHitWonder_ShouldKeepBuffsUp == 0 ) then
		return false;
	end

	local hasAnyAura = false;
	local anyAuras = {};
	local hasAnyBlessing = false;
	local anyBlessings = {};
	local buffIndex, untilCancelled;
	local i = 1
	while UnitBuff("player", i) do
		OneHitWonderTooltip:SetOwner(UIParent,"ANCHOR_NONE");
		OneHitWonderTooltipTextLeft1:SetText('');
		OneHitWonderTooltip:SetUnitBuff("player", i);
		-- If the Tooltip has text on the Left1 it may be a buff player can cast
		buffName = OneHitWonderTooltipTextLeft1:GetText()
		if (buffName) then
			if ( strfind(buffName, ONEHITWONDER_SPELL_AURA_SUBSTRING) ) then
				hasAnyAura = true;
				table.insert(anyAuras, buffName);
			end
			if ( strfind(buffName, ONEHITWONDER_SPELL_BLESSING_SUBSTRING) ) then
				hasAnyBlessing = true;
				table.insert(anyBlessings, buffName);
			end
		end
		i = i + 1
	end
	local hasActiveAura = OneHitWonder_HasAnActiveWhatever(ONEHITWONDER_SPELL_AURA_SUBSTRING, false);
	local auraToTryAndCast = OneHitWonder_Paladin_UseAura_Actions[OneHitWonder_Paladin_UseAura]; 

	if ( OneHitWonder_ShouldTryToCastABuff() ) then
		if ( not hasActiveAura ) then
			local auraId = OneHitWonder_GetSpellId(auraToTryAndCast);
			if ( OneHitWonder_IsSpellAvailable(auraId) ) then
				if ( OneHitWonder_CastSpell(auraId) ) then
					return true;
				end
				--[[
				local castBuff, shouldQuit = OneHitWonder_CastBuff(auraToTryAndCast, nil, "player");
				if ( castBuff or shouldQuit ) then
					return true;
				end
				]]--
			end
		end
		-- Kinesia. Corrected it to use the buff list for Pallies instead of just Might.
		if ( not hasAnyBlessing ) then
			local bufflist = OneHitWonder_GetBuffName_Paladin(ONEHITWONDER_PALADIN_SEQUENCE_BLESSING, "player");
			local done = nil
			for k,v in bufflist do
				if (not done) then
					done = OneHitWonder_CastBuff(v, nil, "player");
				end;
			end
			
		end
	end
	
	if ( OneHitWonder_CleanSelf() ) then
		return true;
	end
	
	return false;
end

