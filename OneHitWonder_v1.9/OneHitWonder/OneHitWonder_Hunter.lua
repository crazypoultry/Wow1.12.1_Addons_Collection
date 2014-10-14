OneHitWonder_Hunter_ShouldUseAimedShot = 1;
OneHitWonder_Hunter_ShouldUseMultiShot = 1;
OneHitWonder_Hunter_ShouldUseMultiShotInGroups = 1;
OneHitWonder_Hunter_ShouldConcussRunners = 1;
OneHitWonder_Hunter_MarkIsBusy = 0;
OneHitWonder_Hunter_ShouldUseMongooseBite = 1;
OneHitWonder_Hunter_ShouldUseCounterAttack = 1;
OneHitWonder_Hunter_ShouldAutoMarkRogues = 0;
OneHitWonder_Hunter_ShouldPetAttack = 0;
OneHitWonder_Hunter_PreferredAspect = ONEHITWONDER_SPELL_NO_ASPECT_NAME;

OneHitWonder_Hunter_MeleeAspect = 0;
OneHitWonder_Hunter_RangedAspect = 0;
OneHitWonder_Hunter_TravelAspect = 0;


OneHitWonder_Hunter_MarkHealthPercentage = 40;

function OneHitWonder_Hunter_SetShouldUseMongooseBite(toggle)
	OneHitWonder_Hunter_ShouldUseMongooseBite = toggle;
end

function OneHitWonder_Hunter_SetShouldUseCounterAttack(toggle)
	OneHitWonder_Hunter_ShouldUseCounterAttack = toggle;
end

function OneHitWonder_Hunter_SetShouldConcussRunners(toggle)
	OneHitWonder_Hunter_ShouldConcussRunners = toggle;
end

function OneHitWonder_Hunter_SetShouldUseAimedShot(toggle)
	OneHitWonder_Hunter_ShouldUseAimedShot = toggle;
end

function OneHitWonder_Hunter_SetShouldUseMultiShot(toggle)
	OneHitWonder_Hunter_ShouldUseMultiShot = toggle;
end

function OneHitWonder_Hunter_SetShouldUseMultiShotInGroups(toggle)
	OneHitWonder_Hunter_ShouldUseMultiShotInGroups = toggle;
end

function OneHitWonder_Hunter_SetMarkHealthPercentage(toggle, value)
	OneHitWonder_Hunter_MarkHealthPercentage = value;
end

function OneHitWonder_Hunter_SetMeleeAspect(toggle, value)
	OneHitWonder_Hunter_MeleeAspect = value;
end

function OneHitWonder_Hunter_SetRangedAspect(toggle, value)
	OneHitWonder_Hunter_RangedAspect = value;
end

function OneHitWonder_Hunter_SetTravelAspect(toggle, value)
	OneHitWonder_Hunter_TravelAspect = value;
end

function OneHitWonder_Init_Hunter()
	OneHitWonder_Options["OneHitWonder_Hunter_ShouldConcussRunners"] = OneHitWonder_Hunter_ShouldConcussRunners;
	OneHitWonder_Options["OneHitWonder_Hunter_ShouldUseAimedShot"] = OneHitWonder_Hunter_ShouldUseAimedShot;
	OneHitWonder_Options["OneHitWonder_Hunter_ShouldUseMultiShot"] = OneHitWonder_Hunter_ShouldUseMultiShot;
	OneHitWonder_Options["OneHitWonder_Hunter_ShouldUseMultiShotInGroups"] = OneHitWonder_Hunter_ShouldUseMultiShotInGroups;
	OneHitWonder_Options["OneHitWonder_Hunter_ShouldPetAttack"] = OneHitWonder_Hunter_ShouldPetAttack;
	OneHitWonder_Options["OneHitWonder_Hunter_PreferredAspect"] = OneHitWonder_Hunter_PreferredAspect;
	OneHitWonder_Options["OneHitWonder_Hunter_ShouldAutoMarkRogues"] = OneHitWonder_Hunter_ShouldAutoMarkRogues;
	OneHitWonder_Options["OneHitWonder_Hunter_MarkHealthPercentage"] = OneHitWonder_Hunter_MarkHealthPercentage;
	OneHitWonder_Options["OneHitWonder_Hunter_ShouldUseCounterAttack"] = OneHitWonder_Hunter_ShouldUseCounterAttack;
	OneHitWonder_Options["OneHitWonder_Hunter_ShouldUseMongooseBite"] = OneHitWonder_Hunter_ShouldUseMongooseBite;
	OneHitWonder_Options["OneHitWonder_Hunter_MeleeAspect"] = OneHitWonder_Hunter_MeleeAspect;
	OneHitWonder_Options["OneHitWonder_Hunter_RangedAspect"] = OneHitWonder_Hunter_RangedAspect;
	OneHitWonder_Options["OneHitWonder_Hunter_TravelAspect"] = OneHitWonder_Hunter_TravelAspect;
end

function OneHitWonder_Hunter_CastAspect(aspectNumber)
	if ( aspectNumber > 0 ) then
		local aspect = OneHitWonder_HunterAspects[aspectNumber];
		if ( aspect ) then
			if ( not OneHitWonder_HasPlayerEffect(nil, aspect) ) then
				local aspectId = OneHitWonder_GetSpellId(aspect);
				if ( aspectId > -1 ) then
					return OneHitWonder_CastSpell(aspectId);
				end
			end
		end
	end
	return false;
end

function OneHitWonder_Hunter_GetConcussiveShotEffects()
	if ( not OneHitWonder_Hunter_Concussive_Shot_Effects ) then
		OneHitWonder_Hunter_Concussive_Shot_Effects = {};
		for k, v in ONEHITWONDER_SLOW_EFFECTS do
			table.insert(OneHitWonder_Hunter_Concussive_Shot_Effects, v);
		end
		table.insert(OneHitWonder_Hunter_Concussive_Shot_Effects, ONEHITWONDER_SPELL_IMPROVED_CONCUSSIVE_SHOT_EFFECT);
	end
	return OneHitWonder_Hunter_Concussive_Shot_Effects;
end

function OneHitWonder_Hunter_ShouldMark(unit)
	if ( ( ( UnitHealth(unit) / UnitHealthMax(unit) ) * 100 ) 
		>= OneHitWonder_Hunter_MarkHealthPercentage ) then
		return true;
	else
		return false;
	end
end

function OneHitWonder_Hunter_AutoShot()
	local actionId = DynamicData.action.getMatchingActionId(ONEHITWONDER_ABILITY_AUTOSHOT_NAME);
	if ( actionId ) and ( IsAttackAction(actionId) ) then
		if ( IsCurrentAction(actionId) ) then
			return false;
		else
			local spellId = OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_AUTOSHOT_NAME);
			OneHitWonder_CastSpell(spellId);
		end
	end
end


function OneHitWonder_TargetIsRunningAway_Hunter()
	if ( not OneHitWonder_HasUnitEffect("target", nil, ONEHITWONDER_SLOW_EFFECTS) and OneHitWonder_Hunter_ShouldConcussRunners == 1 ) then
		local spellId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_CONCUSSIVE_SHOT_NAME);
		if ( spellId > -1 ) then
			if ( not OneHitWonder_CheckIfInRangeSpellId(spellId) ) then
				spellId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_WING_CLIP_NAME);
			end
		end
		if ( spellId > -1 ) then
			local parameters = { spellId, GetTime() + 3};
			OneHitWonder_AddActionToQueue(ONEHITWONDER_ACTIONID_SPELL_TIMEOUT, parameters);
		end
	end
end

function OneHitWonder_Hunter(removeDefense)
	local targetName = UnitName("target");

	if ( not removeDefense ) then removeDefense = false; end
	
	if ( OneHitWonder_IsChannelSpellRunning() ) or ( OneHitWonder_IsRegularSpellRunning() ) then
		return false;
	end
	
	if ( OneHitWonder_HandleActionQueue() ) then
		return true;
	end
	
	if ( (not targetName) or ( strlen(targetName) <= 0 ) or ( ( not UnitCanAttack("target", "player") ) ) ) then
		if ( OneHitWonder_Hunter_CastAspect(OneHitWonder_Hunter_TravelAspect) ) then
			return true;
		end
		if ( OneHitWonder_ShouldOverrideBindings ~= 1 ) then
			return OneHitWonder_DoStuffContinuously();
		end
		--OneHitWonder_DoBuffs();
		--return;
	end
	
	if ( not UnitCanAttack("player", "target") ) then
		return OneHitWonder_DoStuffContinuously();
	end

	if (not OneHitWonder_StartCombat()) then
		return false
	end

	local markId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_HUNTERS_MARK_NAME);
	local inMarkRange = OneHitWonder_CheckIfInRangeSpellId(markId);
	
	if ( not inMarkRange ) then
		return false;
	end

	if (OneHitWonder_PetIsAttacking == false) then
		OneHitWonder_Hunter_SmartPetAttack();
	end
	
	local inAutoShotRange = OneHitWonder_CheckIfInRangeSpellId(OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_AUTOSHOT_NAME));
	local inMeleeRange = true;
	local spellId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_SCARE_BEAST_NAME);
	if ( spellId > -1 ) then
		if ( not OneHitWonder_CheckIfInRangeSpellId(spellId) ) then
			inMeleeRange = false;
		end
	end
	spellId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_WING_CLIP_NAME);
	if ( spellId > -1 ) then
		if ( not OneHitWonder_CheckIfInRangeSpellId(spellId) ) then
			inMeleeRange = false;
		end
	end

	if ( inAutoShotRange ) then
		if ( OneHitWonder_Hunter_DoMark() ) then return true; end
		if ( OneHitWonder_Hunter_CastAspect(OneHitWonder_Hunter_RangedAspect) ) then
			return true;
		end
		local spellId = nil;
		if ( OneHitWonder_Hunter_ShouldUseAimedShot == 1 ) then
			spellId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_AIMED_SHOT_NAME);
			if ( OneHitWonder_IsSpellAvailable(spellId ) ) 
			and ( OneHitWonder_CastSpellOnTarget(spellId) ) then
				return true;
			end
		end
		OneHitWonder_Hunter_AutoShot()
		-- Always concuss players and anything that has you targetted.  Kinesia
		if ((UnitIsUnit("targettarget","player") or ( UnitIsPlayer("target") and not OneHitWonder_HasUnitEffect("target", nil, OneHitWonder_Hunter_GetConcussiveShotEffects()) ))) then
			if ( OneHitWonder_CastSpellOnTarget(OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_CONCUSSIVE_SHOT_NAME)) ) then
				return true;
			end
		end
		if ( OneHitWonder_CastSpellOnTarget(OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_ARCANE_SHOT_NAME)) ) then
			return true;
		end
		if (( OneHitWonder_Hunter_ShouldUseMultiShot == 1  and not OneHitWonder_IsInPartyOrRaid()) or (OneHitWonder_Hunter_ShouldUseMultiShotInGroups == 1))   then
			spellId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_MULTI_SHOT_NAME);
			if ( OneHitWonder_IsSpellAvailable(spellId ) ) 
			and ( OneHitWonder_CastSpellOnTarget(spellId) ) then
				return true;
			end
		end
		if (( not OneHitWonder_HasUnitEffect("target", nil, ONEHITWONDER_SPELL_SERPENT_STING_EFFECT) ) and
		    ( not OneHitWonder_HasUnitEffect("target", nil, ONEHITWONDER_SPELL_VIPER_STING_EFFECT) ) and
		    ( not OneHitWonder_HasUnitEffect("target", nil, ONEHITWONDER_SPELL_SCORPID_STING_EFFECT) ) and
		    ( UnitCreatureType("target") ~= ONEHITWONDER_CREATURE_TYPE_ELEMENTAL)) then
			if ( OneHitWonder_CastSpellOnTarget(OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_SERPENT_STING_NAME)) ) then
				return true;
			end
		end
	elseif ( inMeleeRange ) then
		OneHitWonder_MeleeAttack();
		if ( OneHitWonder_Hunter_CastAspect(OneHitWonder_Hunter_MeleeAspect) ) then
			return true;
		end
		local spellId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_RAPTOR_STRIKE_NAME);
		if ( OneHitWonder_CheckIfUsableSpellId(spellId) ) then
			if ( OneHitWonder_CastSpellOnTarget(spellId) ) then
				return true;
			end
		end
		-- Always concuss players and units targetting you
		if ((UnitIsUnit("targettarget","player") or 
		 	( UnitIsPlayer("target") and not OneHitWonder_HasUnitEffect("target", nil, OneHitWonder_Hunter_GetConcussiveShotEffects()) ))) then
			if ( OneHitWonder_CastSpellOnTarget(OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_WING_CLIP_NAME)) ) then
				return true;
			end
		end
	elseif ( inMarkRange ) then
		if ( OneHitWonder_Hunter_DoMark() ) then return true; end
	end
	return false;
end

function OneHitWonder_Hunter_DoMark()
	--_print("OneHitWonder_Hunter_DoMark")
	if OneHitWonder_Hunter_ShouldMark("target") then
		if ( OneHitWonder_Hunter_MarkIsBusy ~= 1 ) then
			if ( not OneHitWonder_HasUnitEffect("target", nil, ONEHITWONDER_SPELL_HUNTERS_MARK_EFFECT) ) then
				local markId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_HUNTERS_MARK_NAME);
				if ( markId > -1 ) and ( OneHitWonder_CastSpell(markId) ) then
					return true;
				end
			end
		end
	end
	return false;
end

function OneHitWonder_Hunter_SetShouldPetAttack(toggle)
	OneHitWonder_Hunter_ShouldPetAttack = toggle;
end

function OneHitWonder_Hunter_SetAutoMarkRogues(toggle)
	OneHitWonder_Hunter_AutoMarkRogues = toggle;
end

function OneHitWonder_Hunter_Cosmos()
	if ( Cosmos_RegisterConfiguration ) and ( Cosmos_UpdateValue ) then
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_HUNTER_SEPARATOR",
			"SEPARATOR",
			TEXT(ONEHITWONDER_HUNTER_SEPARATOR),
			TEXT(ONEHITWONDER_HUNTER_SEPARATOR_INFO)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_HUNTER_USE_SMART_PET_ATTACK",
			"CHECKBOX",
			TEXT(ONEHITWONDER_HUNTER_USE_SMART_PET_ATTACK),
			TEXT(ONEHITWONDER_HUNTER_USE_SMART_PET_ATTACK_INFO),
			OneHitWonder_Hunter_SetShouldPetAttack,
			OneHitWonder_Hunter_ShouldPetAttack
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_HUNTER_AUTO_MARK_ROGUES",
			"CHECKBOX",
			TEXT(ONEHITWONDER_HUNTER_AUTO_MARK_ROGUES),
			TEXT(ONEHITWONDER_HUNTER_AUTO_MARK_ROGUES_INFO),
			OneHitWonder_Hunter_SetAutoMarkRogues,
			OneHitWonder_Hunter_ShouldAutoMarkRogues
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_HUNTER_USE_COUNTERATTACK",
			"CHECKBOX",
			TEXT(ONEHITWONDER_HUNTER_USE_COUNTERATTACK),
			TEXT(ONEHITWONDER_HUNTER_USE_COUNTERATTACK_INFO),
			OneHitWonder_Hunter_SetShouldUseCounterAttack,
			OneHitWonder_Hunter_ShouldUseCounterAttack
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_HUNTER_USE_MONGOOSE_BITE",
			"CHECKBOX",
			TEXT(ONEHITWONDER_HUNTER_USE_MONGOOSE_BITE),
			TEXT(ONEHITWONDER_HUNTER_USE_MONGOOSE_BITE_INFO),
			OneHitWonder_Hunter_SetShouldUseMongooseBite,
			OneHitWonder_Hunter_ShouldUseMongooseBite
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_HUNTER_USE_MULTI_SHOT",
			"CHECKBOX",
			TEXT(ONEHITWONDER_HUNTER_USE_MULTI_SHOT),
			TEXT(ONEHITWONDER_HUNTER_USE_MULTI_SHOT_INFO),
			OneHitWonder_Hunter_SetShouldUseMultiShot,
			OneHitWonder_Hunter_ShouldUseMultiShot
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_HUNTER_USE_MULTI_SHOT_GROUP",
			"CHECKBOX",
			TEXT(ONEHITWONDER_HUNTER_USE_MULTI_SHOT_GROUP),
			TEXT(ONEHITWONDER_HUNTER_USE_MULTI_SHOT_GROUP_INFO),
			OneHitWonder_Hunter_SetShouldUseMultiShotInGroups,
			OneHitWonder_Hunter_ShouldUseMultiShotInGroups
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_HUNTER_USE_CONCUSS",
			"CHECKBOX",
			TEXT(ONEHITWONDER_HUNTER_USE_CONCUSS),
			TEXT(ONEHITWONDER_HUNTER_USE_CONCUSS_INFO),
			OneHitWonder_Hunter_SetShouldConcussRunners,
			OneHitWonder_Hunter_ShouldConcussRunners
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_HUNTER_USE_AIMED_SHOT",
			"CHECKBOX",
			TEXT(ONEHITWONDER_HUNTER_USE_AIMED_SHOT),
			TEXT(ONEHITWONDER_HUNTER_USE_AIMED_SHOT_INFO),
			OneHitWonder_Hunter_SetShouldUseAimedShot,
			OneHitWonder_Hunter_ShouldUseAimedShot
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_HUNTER_MARK_HEALTH",
			"SLIDER",
			TEXT(ONEHITWONDER_HUNTER_MARK_HEALTH),
			TEXT(ONEHITWONDER_HUNTER_MARK_HEALTH_INFO),
			OneHitWonder_Hunter_SetMarkHealthPercentage,
			1, 
			OneHitWonder_Hunter_MarkHealthPercentage,
			0,
			100,
			"",
			1,
			1,
			TEXT(ONEHITWONDER_HUNTER_MARK_HEALTH_APPEND)
		);
		local aspectDescs = "";
		for k, v in OneHitWonder_HunterAspects do
			aspectDescs = aspectDescs..string.format(" %d = %s.", k, v); 
		end
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_HUNTER_MELEE_ASPECT",
			"SLIDER",
			TEXT(ONEHITWONDER_HUNTER_MELEE_ASPECT),
			TEXT(ONEHITWONDER_HUNTER_MELEE_ASPECT_INFO)..aspectDescs,
			OneHitWonder_Hunter_SetMeleeAspect,
			1, 
			OneHitWonder_Hunter_MeleeAspect,
			0,
			table.getn(OneHitWonder_HunterAspects),
			"",
			1,
			1,
			""
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_HUNTER_RANGED_ASPECT",
			"SLIDER",
			TEXT(ONEHITWONDER_HUNTER_RANGED_ASPECT),
			TEXT(ONEHITWONDER_HUNTER_RANGED_ASPECT_INFO)..aspectDescs,
			OneHitWonder_Hunter_SetRangedAspect,
			1, 
			OneHitWonder_Hunter_RangedAspect,
			0,
			table.getn(OneHitWonder_HunterAspects),
			"",
			1,
			1,
			""
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_HUNTER_TRAVEL_ASPECT",
			"SLIDER",
			TEXT(ONEHITWONDER_HUNTER_TRAVEL_ASPECT),
			TEXT(ONEHITWONDER_HUNTER_TRAVEL_ASPECT_INFO)..aspectDescs,
			OneHitWonder_Hunter_SetTravelAspect,
			1, 
			OneHitWonder_Hunter_TravelAspect,
			0,
			table.getn(OneHitWonder_HunterAspects),
			"",
			1,
			1,
			""
		);
		
	end
	
end



function OneHitWonder_Hunter_SmartPetAttack()
	return OneHitWonder_SmartPetAttack(OneHitWonder_Hunter_ShouldPetAttack);
end

function OneHitWonder_SetupStuffContinuously_Hunter()
	--OneHitWonder_BuffTime[ONEHITWONDER_ABILITY_] = 5*60;
end


function OneHitWonder_GetParryCounter_Hunter()
	local counterId = -1;
	local abilityName = "";
	if ( OneHitWonder_Hunter_ShouldUseCounterAttack == 1 ) then
		abilityName = ONEHITWONDER_ABILITY_COUNTERATTACK_NAME;
		counterId = OneHitWonder_GetSpellId(abilityName);
	end
	return counterId, abilityName;
end

function OneHitWonder_GetDodgeCounter_Hunter()
	local counterId = -1;
	local abilityName = "";
	if ( OneHitWonder_Hunter_ShouldUseMongooseBite == 1 ) then
		abilityName = ONEHITWONDER_ABILITY_MONGOOSE_BITE_NAME;
		counterId = OneHitWonder_GetSpellId(abilityName);
	end
	return counterId, abilityName;
end


function OneHitWonder_DoStuffContinuously_Hunter()
	if ( not OneHitWonder_IsEnabled() ) then return false; end
	if ( OneHitWonder_ShouldKeepBuffsUp ~= 1 ) then
		return false;
	end
	local hasAnyAspect = false;
	hasAnyAspect = OneHitWonder_HasPlayerEffect(nil, OneHitWonder_HunterAspects);
	local buffIndex, untilCancelled;
	if ( not hasAnyAspect ) and ( OneHitWonder_ShouldTryToCastABuff() ) then
		local aspectId = nil;
		local tryToCastAspect = true;
		if ( OneHitWonder_Hunter_PreferredAspect ) then
			if ( OneHitWonder_Hunter_PreferredAspect == ONEHITWONDER_SPELL_NO_ASPECT_NAME ) then
				tryToCastAspect = false;
			else
				aspectId = OneHitWonder_GetSpellId(OneHitWonder_Hunter_PreferredAspect);
				if ( aspectId > -1 ) and ( OneHitWonder_IsSpellAvailable(aspectId) ) and 
					( not OneHitWonder_HasPlayerEffect(nil, OneHitWonder_Hunter_PreferredAspect) ) then
					if ( OneHitWonder_CastSpell(aspectId) ) then
						return true;
					end
				end
				tryToCastAspect = false;
			end
		end
		if ( tryToCastAspect ) then
			for k, v in OneHitWonder_HunterAspects do
				aspectId = OneHitWonder_GetSpellId(v);
				if ( ( OneHitWonder_IsSpellAvailable(aspectId) ) and ( not OneHitWonder_HasPlayerEffect(nil, v) ) ) then
					OneHitWonder_CastSpell(aspectId);
					return true;
				end
			end
		end
	end
	return false;
end


function OneHitWonder_Hunter_IsTargetAutoMarkMaterial()
	return ( UnitClass("target") == ONEHITWONDER_CLASS_ROGUE );
	--return true;
end

function OneHitWonder_SetupStuffContinuously_Hunter()
	OneHitWonder_AddStuffContinuously(ONEHITWONDER_SPELL_TRUESHOT_AURA_NAME, false, true, {notInCombat = true, useWhenHigherManaPercentage=95});
end

function OneHitWonder_Target_Changed_Hunter()
	if ( OneHitWonder_HasTarget() ) and ( not UnitIsDead("target") ) and ( OneHitWonder_Hunter_IsTargetAutoMarkMaterial() ) and ( UnitCanAttack("target", "player") and ( OneHitWonder_Hunter_MarkIsBusy ~= 1 ) ) then
		if ( OneHitWonder_Hunter_ShouldAutoMarkRogues == 1 ) then
			if ( not OneHitWonder_HasUnitEffect("target", nil, ONEHITWONDER_SPELL_HUNTERS_MARK_EFFECT) ) then
				local spellId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_HUNTERS_MARK_NAME);
				if ( spellId > -1 ) then
					local parameters = { spellId, "target", GetTime() + 3};
					OneHitWonder_AddActionToQueue(ONEHITWONDER_ACTIONID_SPELL_TARGET, parameters);
				end
			end
		end
	end
end
