ONEHITWONDER_MAGE_FIRE_WARD = 1;
ONEHITWONDER_MAGE_FROST_WARD = 2;

OneHitWonder_Mage_ShouldBuffNonCastersIntellect = 0;
OneHitWonder_Mage_ArcaneIntellectMana = 80;
OneHitWonder_Mage_UseCounterspell = 0;
OneHitWonder_Mage_ShouldReactiveCastManaShield = 0;

OneHitWonder_Mage_ShouldReactiveCastWards = 3;

OneHitWonder_Mage_ArmorChoice = 3;

OneHitWonder_Mage_MagicMagnitude = 3;

OneHitWonder_Mage_ReactiveManaShieldHealthPercentage = 30;
OneHitWonder_Mage_ReactiveManaShieldManaPercentage = 70;

OneHitWonder_Options_Mage = { 
	"OneHitWonder_Mage_ShouldBuffNonCastersIntellect", 
	"OneHitWonder_Mage_ArcaneIntellectMana", 
	"OneHitWonder_Mage_ShouldReactiveCastWards", 
	"OneHitWonder_Mage_UseCounterspell", 
	"OneHitWonder_Mage_ShouldReactiveCastManaShield", 
	"OneHitWonder_Mage_ArmorChoice",
	"OneHitWonder_Mage_MagicMagnitude", 
	"OneHitWonder_Mage_ReactiveManaShieldHealthPercentage", 
	"OneHitWonder_Mage_ReactiveManaShieldManaPercentage", 
};

function OneHitWonder_TryToInterruptSpell_Mage(unitName, spellName)
	local spellId = -1;
	local abilityName = "";
	if ( OneHitWonder_Mage_UseCounterspell == 1 ) then
		local n = ONEHITWONDER_SPELL_COUNTERSPELL_NAME;
		local i = OneHitWonder_GetSpellId(n);
		if ( i > -1 ) then
			spellId = i;
			abilityName = n;
		end
	end
	return spellId, abilityName;
end

function OneHitWonder_Mage_SetUseCounterspell(toggle)
	if ( OneHitWonder_Mage_UseCounterspell ~= toggle ) then
		OneHitWonder_Mage_UseCounterspell = toggle;
	end
end

function OneHitWonder_Mage_SetArmorChoice(toggle, value)
	if ( OneHitWonder_Mage_ArmorChoice ~= value ) then
		OneHitWonder_Mage_ArmorChoice = value;
		OneHitWonder_SetupStuffContinuously();
	end
end

function OneHitWonder_Mage_SetMagicMagnitude(toggle, value)
	if ( OneHitWonder_Mage_MagicMagnitude ~= value ) then
		OneHitWonder_Mage_MagicMagnitude = value;
		OneHitWonder_SetupStuffContinuously();
	end
end

function OneHitWonder_Mage_SetShouldBuffNonCastersIntellect(toggle)
	if ( OneHitWonder_Mage_ShouldBuffNonCastersIntellect ~= toggle ) then
		OneHitWonder_Mage_ShouldBuffNonCastersIntellect = toggle;
		OneHitWonder_SetupStuffContinuously();
	end
end

function OneHitWonder_Mage_SetArcaneIntellectMana(toggle, value)
	if ( OneHitWonder_Mage_ArcaneIntellectMana ~= value ) then
		OneHitWonder_Mage_ArcaneIntellectMana = value;
		OneHitWonder_SetupStuffContinuously();
	end
end

function OneHitWonder_Mage_SetShouldReactiveCastWards(toggle, value)
	OneHitWonder_Mage_ShouldReactiveCastWards = value;
end

function OneHitWonder_Mage_SetShouldReactiveCastManaShield(toggle)
	OneHitWonder_Mage_ShouldReactiveCastManaShield = toggle;
end

function OneHitWonder_Mage_SetReactiveManaShieldHealthPercentage(toggle, value)
	OneHitWonder_Mage_ReactiveManaShieldHealthPercentage = value;
end

function OneHitWonder_Mage_SetReactiveManaShieldManaPercentage(toggle, value)
	OneHitWonder_Mage_ReactiveManaShieldManaPercentage = value;
end

function OneHitWonder_Mage_Cosmos()
	if ( Cosmos_RegisterConfiguration ) and ( Cosmos_UpdateValue ) then
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_MAGE_SEPARATOR",
			"SEPARATOR",
			TEXT(ONEHITWONDER_MAGE_SEPARATOR),
			TEXT(ONEHITWONDER_MAGE_SEPARATOR_INFO)
		);
		
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_MAGE_ARMOR_CHOICE",
			"SLIDER",
			TEXT(ONEHITWONDER_MAGE_ARMOR_CHOICE),
			TEXT(ONEHITWONDER_MAGE_ARMOR_CHOICE_INFO),
			OneHitWonder_Mage_SetArmorChoice,
			1,
			OneHitWonder_Mage_ArmorChoice,
			0,
			3,
			"",
			1,
			1,
			TEXT(ONEHITWONDER_MAGE_ARMOR_CHOICE_APPEND)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_MAGE_MAGNITUDE_CHOICE",
			"SLIDER",
			TEXT(ONEHITWONDER_MAGE_MAGNITUDE_CHOICE),
			TEXT(ONEHITWONDER_MAGE_MAGNITUDE_CHOICE_INFO),
			OneHitWonder_Mage_SetMagicMagnitude,
			1,
			OneHitWonder_Mage_MagicMagnitude,
			0,
			5,
			"",
			1,
			1,
			TEXT(ONEHITWONDER_MAGE_MAGNITUDE_CHOICE_APPEND)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_MAGE_BUFF_NON_CASTERS_INTELLECT",
			"CHECKBOX",
			TEXT(ONEHITWONDER_MAGE_BUFF_NON_CASTERS_INTELLECT),
			TEXT(ONEHITWONDER_MAGE_BUFF_NON_CASTERS_INTELLECT_INFO),
			OneHitWonder_Mage_SetShouldBuffNonCastersIntellect,
			OneHitWonder_Mage_ShouldBuffNonCastersIntellect
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_MAGE_ARCANE_INTELLECT_MANA",
			"SLIDER",
			TEXT(ONEHITWONDER_MAGE_ARCANE_INTELLECT_MANA),
			TEXT(ONEHITWONDER_MAGE_ARCANE_INTELLECT_MANA_INFO),
			OneHitWonder_Mage_SetArcaneIntellectMana,
			1,
			OneHitWonder_Mage_ArcaneIntellectMana,
			0,
			101,
			"",
			1,
			1,
			TEXT(ONEHITWONDER_MAGE_ARCANE_INTELLECT_MANA_APPEND)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_MAGE_REACTIVE_CAST_WARDS",
			"SLIDER",
			TEXT(ONEHITWONDER_MAGE_REACTIVE_CAST_WARDS),
			TEXT(ONEHITWONDER_MAGE_REACTIVE_CAST_WARDS_INFO),
			OneHitWonder_Mage_SetShouldReactiveCastWards,
			1,
			OneHitWonder_Mage_ShouldReactiveCastWards,
			0,
			3,
			"",
			1,
			1,
			TEXT(ONEHITWONDER_MAGE_REACTIVE_CAST_WARDS_APPEND)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_MAGE_USE_COUNTERSPELL",
			"CHECKBOX",
			TEXT(ONEHITWONDER_MAGE_USE_COUNTERSPELL),
			TEXT(ONEHITWONDER_MAGE_USE_COUNTERSPELL_INFO),
			OneHitWonder_Mage_SetUseCounterspell,
			OneHitWonder_Mage_UseCounterspell
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_MAGE_REACTIVE_CAST_MANA_SHIELD",
			"CHECKBOX",
			TEXT(ONEHITWONDER_MAGE_REACTIVE_CAST_MANA_SHIELD),
			TEXT(ONEHITWONDER_MAGE_REACTIVE_CAST_MANA_SHIELD_INFO),
			OneHitWonder_Mage_SetShouldReactiveCastManaShield,
			OneHitWonder_Mage_ShouldReactiveCastManaShield
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_MAGE_REACTIVE_MANA_SHIELD_HEALTH",
			"SLIDER",
			TEXT(ONEHITWONDER_MAGE_REACTIVE_MANA_SHIELD_HEALTH),
			TEXT(ONEHITWONDER_MAGE_REACTIVE_MANA_SHIELD_HEALTH_INFO),
			OneHitWonder_Mage_SetReactiveManaShieldHealthPercentage,
			1,
			OneHitWonder_Mage_ReactiveManaShieldHealthPercentage,
			0,
			100,
			"",
			1,
			1,
			TEXT(ONEHITWONDER_MAGE_REACTIVE_MANA_SHIELD_HEALTH_APPEND)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_MAGE_REACTIVE_MANA_SHIELD_MANA",
			"SLIDER",
			TEXT(ONEHITWONDER_MAGE_REACTIVE_MANA_SHIELD_MANA),
			TEXT(ONEHITWONDER_MAGE_REACTIVE_MANA_SHIELD_MANA_INFO),
			OneHitWonder_Mage_SetReactiveManaShieldManaPercentage,
			1,
			OneHitWonder_Mage_ReactiveManaShieldManaPercentage,
			1,
			100,
			"",
			1,
			1,
			TEXT(ONEHITWONDER_MAGE_REACTIVE_MANA_SHIELD_MANA_APPEND)
		);
	end
end

function OneHitWonder_Mage_GetArmorSpellNameCold(pArmorName)
	local armorName = pArmorName;
	if ( armorName ) and ( OneHitWonder_GetSpellId(armorName) <= 0 ) then
		armorName = nil;
	end
	if ( not armorName ) then
		armorName = ONEHITWONDER_SPELL_ICE_ARMOR_NAME;
		if ( OneHitWonder_GetSpellId(armorName) <= 0 ) then
			armorName = ONEHITWONDER_SPELL_FROST_ARMOR_NAME;
		end
	end
	return armorName;
end

function OneHitWonder_Mage_GetArmorSpellName()
	local armorName = nil;
	if ( OneHitWonder_Mage_ArmorChoice == 0 ) then
	elseif ( OneHitWonder_Mage_ArmorChoice == 1 ) then
		armorName = OneHitWonder_Mage_GetArmorSpellNameCold(armorName);
	elseif ( OneHitWonder_Mage_ArmorChoice == 2 ) then
		armorName = ONEHITWONDER_SPELL_MAGE_ARMOR_NAME;
		armorName = OneHitWonder_Mage_GetArmorSpellNameCold(armorName);
	elseif ( OneHitWonder_Mage_ArmorChoice == 3 ) then
		if ( OneHitWonder_IsInPartyOrRaid() ) then
			armorName = ONEHITWONDER_SPELL_MAGE_ARMOR_NAME;
		end
		armorName = OneHitWonder_Mage_GetArmorSpellNameCold(armorName);
	elseif ( OneHitWonder_Mage_ArmorChoice == 4 ) then
		if ( OneHitWonder_IsInPartyOrRaid() ) then
			armorName = ONEHITWONDER_SPELL_MAGE_ARMOR_NAME;
		end
	end
	if ( armorName ) and ( OneHitWonder_GetSpellId(armorName) <= 0 ) then
		armorName = nil;
	end
	return armorName;
end

function OneHitWonder_Mage_GetMagicMagnitudeSpellName()
	local shouldOverride = false;
	local mag = nil;
	local healers = OneHitWonder_GetNumberOfClassInParty(OneHitWonder_HealerClassesArray);
	if ( OneHitWonder_Mage_MagicMagnitude == 0 ) then
	elseif ( OneHitWonder_Mage_MagicMagnitude == 1 ) then
		if ( healers <= 0 ) then
			mag = ONEHITWONDER_SPELL_DAMPEN_MAGIC_NAME;
		end
	elseif ( OneHitWonder_Mage_MagicMagnitude == 2 ) then
		if ( healers > 0 ) then
			mag = ONEHITWONDER_SPELL_AMPLIFY_MAGIC_NAME;
		end
	elseif ( OneHitWonder_Mage_MagicMagnitude == 3 ) then
		if ( healers > 0 ) then
			mag = ONEHITWONDER_SPELL_AMPLIFY_MAGIC_NAME;
		else
			mag = ONEHITWONDER_SPELL_DAMPEN_MAGIC_NAME;
		end
	elseif ( OneHitWonder_Mage_MagicMagnitude == 4 ) then
		mag = ONEHITWONDER_SPELL_DAMPEN_MAGIC_NAME;
		shouldOverride = true;
	elseif ( OneHitWonder_Mage_MagicMagnitude == 5 ) then
		mag = ONEHITWONDER_SPELL_AMPLIFY_MAGIC_NAME;
		shouldOverride = true;
	end
	if ( mag ) and ( OneHitWonder_GetSpellId(mag) <= 0 ) then
		mag = nil;
	end
	return mag, shouldOverride;
end

function OneHitWonder_SetupStuffContinuously_Mage()
	OneHitWonder_BuffTime[ONEHITWONDER_SPELL_ARCANE_INTELLECT_NAME] = 29*60;
	OneHitWonder_BuffTime[ONEHITWONDER_SPELL_DAMPEN_MAGIC_NAME] = 4.5*60;
	if ( OneHitWonder_Mage_ShouldBuffNonCastersIntellect == 1 ) then
		OneHitWonder_AddStuffContinuously(ONEHITWONDER_SPELL_ARCANE_INTELLECT_NAME, false, true, { effectName={ONEHITWONDER_SPELL_ARCANE_INTELLECT_EFFECT, ONEHITWONDER_SPELL_ARCANE_BRILLIANCE_EFFECT},useWhenHigherManaPercentage=OneHitWonder_Mage_ArcaneIntellectMana });
	else
		OneHitWonder_AddStuffContinuously(ONEHITWONDER_SPELL_ARCANE_INTELLECT_NAME, false, true, {effectName={ONEHITWONDER_SPELL_ARCANE_INTELLECT_EFFECT, ONEHITWONDER_SPELL_ARCANE_BRILLIANCE_EFFECT}, useWhenHigherManaPercentage=OneHitWonder_Mage_ArcaneIntellectMana, powerType = { ONEHITWONDER_POWERTYPE_MANA } });
		--OneHitWonder_AddStuffContinuously(ONEHITWONDER_SPELL_ARCANE_INTELLECT_NAME, false, true, {effectName={ONEHITWONDER_SPELL_ARCANE_INTELLECT_EFFECT, ONEHITWONDER_SPELL_ARCANE_BRILLIANCE_EFFECT}, onlyBuffClass = {ONEHITWONDER_CLASS_DRUID}, powerType = { ONEHITWONDER_POWERTYPE_MANA } });
		OneHitWonder_AddStuffContinuously(ONEHITWONDER_SPELL_ARCANE_INTELLECT_NAME, false, true, {effectName={ONEHITWONDER_SPELL_ARCANE_INTELLECT_EFFECT, ONEHITWONDER_SPELL_ARCANE_BRILLIANCE_EFFECT}, useWhenHigherManaPercentage=OneHitWonder_Mage_ArcaneIntellectMana, onlyBuffClass = {ONEHITWONDER_CLASS_DRUID}});
	end
	if ( OneHitWonder_ShouldKeepBuffsUp == 1 ) then
		local armorName = OneHitWonder_Mage_GetArmorSpellName();
		if ( armorName ) then
			OneHitWonder_AddStuffContinuously(armorName, true, true, { effectName = {ONEHITWONDER_SPELL_ICE_ARMOR_EFFECT, ONEHITWONDER_SPELL_FROST_ARMOR_EFFECT, ONEHITWONDER_SPELL_MAGE_ARMOR_EFFECT}});
		end
		local magnitudeName, shouldOverride = OneHitWonder_Mage_GetMagicMagnitudeSpellName();
		if ( magnitudeName ) then
			local effects = {ONEHITWONDER_SPELL_AMPLIFY_MAGIC_EFFECT, ONEHITWONDER_SPELL_DAMPEN_MAGIC_EFFECT};
			if ( shouldOverride ) then
				effects = { magnitudeName };
			end
			OneHitWonder_AddStuffContinuously(magnitudeName, false, true, {invalidTarget={"target"},effectName = effects,useWhenHigherManaPercentage=50, validTarget={"player","party1","party2","party3","party4","pet"}});
		end
	end
end

function OneHitWonder_TryToInterruptSpell_Mage(unitName, spellName)
	local interruptId = -1;
	local abilityName = "";
	if ( ( OneHitWonder_IsSpellFireBased(spellName) ) and ( ( OneHitWonder_Mage_ShouldReactiveCastWards and ONEHITWONDER_MAGE_FIRE_WARD ) > 0 ) ) then
		abilityName = ONEHITWONDER_SPELL_FIRE_WARD_NAME;
	elseif ( ( OneHitWonder_IsSpellFrostBased(spellName) ) and ( ( OneHitWonder_Mage_ShouldReactiveCastWards and ONEHITWONDER_MAGE_FROST_WARD ) > 0 ) ) then
		abilityName = ONEHITWONDER_SPELL_FROST_WARD_NAME;
	end
	if ( ( abilityName ) and 
		(strlen(abilityName) > 0) and ( not OneHitWonder_HasPlayerEffect(nil, abilityName) ) ) then
		interruptId = OneHitWonder_GetSpellId(abilityName);
		if ( OneHitWonder_CheckIfSpellIsCoolingdownById(interruptId) ) then
			abilityName = "";
			interruptId = -1;
		end
	end
	return interruptId, abilityName;
end

function OneHitWonder_Mage_AddManaShield()
	local spellId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_MANA_SHIELD_NAME);
	if ( spellId > -1 ) then
		local parameters = { spellId, ( GetTime() + 2 ) };
		OneHitWonder_AddActionToQueue(ONEHITWONDER_ACTIONID_SPELL_TIMEOUT, parameters);
	end
end

function OneHitWonder_Mage_CastManaShield()
	local spellId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_MANA_SHIELD_NAME);
	return OneHitWonder_CastSpell(spellId);
end


function OneHitWonder_Mage_ManaShieldCheck()
	if ( OneHitWonder_Mage_ShouldReactiveCastManaShield == 1 ) then
		local playerHPPercent = OneHitWonder_GetPlayerHPPercentage();
		local playerManaPercent = OneHitWonder_GetPlayerManaPercentage();
		--OneHitWonder_Print(format("OK, loaded up values. Current HP : %d   Current Mana : %d", playerHPPercent, playerManaPercent));
		if ( ( ( OneHitWonder_Mage_ReactiveManaShieldHealthPercentage >= 100 ) or ( playerHPPercent <= OneHitWonder_Mage_ReactiveManaShieldHealthPercentage ) )
			and ( ( OneHitWonder_Mage_ReactiveManaShieldManaPercentage <= 1 ) or ( playerManaPercent >= OneHitWonder_Mage_ReactiveManaShieldManaPercentage ) ) ) then
			local spellId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_MANA_SHIELD_NAME);
			--OneHitWonder_Print(format("OK, we were authorized to GO. SpellId = %d", spellId));
			if ( 
			( spellId > -1 ) and 
			( OneHitWonder_IsSpellAvailable(spellId) ) and 
			( not OneHitWonder_HasPlayerEffect(nil, ONEHITWONDER_SPELL_MANA_SHIELD_EFFECT ) ) ) then
				--OneHitWonder_Print(format("OK, adding to queue..."));
				--local parameters = { spellId, ( GetTime() + 2 ) };
				--OneHitWonder_AddActionToQueue(ONEHITWONDER_ACTIONID_SPELL_TIMEOUT, parameters);
				return true;
			else
				--[[
				local available = OneHitWonder_IsSpellAvailable(spellId);
				if ( not available ) then available = "false"; else available = "true"; end
				local present = OneHitWonder_HasPlayerEffect(nil, ONEHITWONDER_SPELL_MANA_SHIELD_EFFECT );
				if ( not present ) then present = "false"; else present = "true"; end
				OneHitWonder_Print(format("We were not authorized to go. Available = %s    Present = %s", available, present));
				]]--
			end
		end
	end
	return false;
end

function OneHitWonder_UnitHealthCheck_Mage(unit)
	if ( unit == "player" ) and ( OneHitWonder_Mage_ManaShieldCheck() ) then
		OneHitWonder_Mage_AddManaShield();
	end
end


function OneHitWonder_Mage(removeDefense)
	local targetName = UnitName("target");

	if ( not removeDefense ) then removeDefense = false; end
	
	if ( OneHitWonder_IsChannelSpellRunning() ) or ( OneHitWonder_IsRegularSpellRunning() ) then
		return;
	end
	
	if ( (not targetName) or ( strlen(targetName) <= 0 ) ) then
		if ( not OneHitWonder_UseCountermeasures() ) then
			if ( not OneHitWonder_DoBuffs() ) then
				if ( OneHitWonder_ShouldOverrideBindings ~= 1 ) then
					return OneHitWonder_DoStuffContinuously();
				end
			end
		end
		return;
	end
	
	if ( not UnitCanAttack("target", "player") ) then
		if ( not OneHitWonder_UseCountermeasures() ) then
			OneHitWonder_DoBuffs();
		end
		return;
	end
	
	OneHitWonder_CheckFriendlies();
	
	if ( OneHitWonder_HandleActionQueue() ) then
		return;
	end

	if (not OneHitWonder_StartCombat()) then
		return false
	end
	
	if ( OneHitWonder_Mage_ManaShieldCheck() ) then
		if ( OneHitWonder_Mage_CastManaShield() ) then
			return true;
		end
	end

	-- check fire ball range, use that, default to frost bolt if necessary, AM

	if ( not OneHitWonder_DoBuffs() ) then
		local attackSpellId = OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_ATTACK);
		local attackActionId = OneHitWonder_GetActionIdFromSpellId(attackSpellId);
		if ( attackActionId == -1 ) or ( not OneHitWonder_CheckIfInRangeAndUsableInActionBarByActionId(attackActionId) ) then
			local shootSpellId = OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_SHOOT);
			local shootActionId = OneHitWonder_GetActionIdFromSpellId(shootSpellId);
			if ( OneHitWonder_CheckIfInRangeAndUsableInActionBarByActionId(shootActionId) ) then
				if ( OneHitWonder_CastSpell(shootSpellId) ) then	
					return;
				end
			end
		else
			OneHitWonder_MeleeAttack();
		end
	end
end

function OneHitWonder_Mage_IsEffectLesserCurse(effect)
	if ( strfind(effect.name, ONEHITWONDER_DEBUFF_TYPE_CURSE_LESSER ) ) then
		return true;
	end
	for k, v in ONEHITWONDER_LESSER_CURSE_NAMES do
		if ( v == effect.name ) then
			return true;
		end
	end
	return false;
end

function OneHitWonder_Mage_RetrieveCleansingSpellId(unit)
	if ( ( strfind(unit, "party" ) ) or ( unit == "player" ) ) then
		if ( OneHitWonder_ShouldAutoCure == 1 ) then
			local removeCurseId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_REMOVE_LESSER_CURSE_NAME);
			if ( removeCurseId > -1 ) then
				local debuffsByType = OneHitWonder_GetDebuffsByType(unit);
				local hasCurse = ( debuffsByType[ONEHITWONDER_DEBUFF_TYPE_CURSE] ) and ( table.getn(debuffsByType[ONEHITWONDER_DEBUFF_TYPE_CURSE]) > 0 );
				local hasLesserCurse = false;
				if ( hasCurse ) then
					for k, v in debuffsByType[ONEHITWONDER_DEBUFF_TYPE_CURSE] do
						if ( OneHitWonder_Mage_IsEffectLesserCurse(v) ) then
							hasLesserCurse = true;
							break;
						end
					end
				end
				if ( hasLesserCurse ) then
					return removeCurseId;
				end
			end
		end
	end
	return -1;
end

function OneHitWonder_CheckEffect_Mage(unit)
	if ( UnitCanAttack("player", unit) ) then
		return false;
	end
	local doneStuff = false;
	local spellId = OneHitWonder_Mage_RetrieveCleansingSpellId(unit);
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


function OneHitWonder_DoStuffContinuously_Mage()
	if ( not OneHitWonder_IsEnabled() ) then return false; end
	if ( OneHitWonder_Mage_ManaShieldCheck() ) then
		return OneHitWonder_Mage_CastManaShield();
	end
	if ( OneHitWonder_CleanSelf() ) then
		return true;
	end
	return false;
end

