OneHitWonder_Druid_SpellDuration = {};
OneHitWonder_Druid_SpellDuration[ONEHITWONDER_SPELL_FAERIE_FIRE_NAME] = 40;
OneHitWonder_Druid_SpellDuration[ONEHITWONDER_SPELL_FAERIE_FIRE_BEAR_NAME] = 40;
OneHitWonder_Druid_SpellDuration[ONEHITWONDER_SPELL_FAERIE_FIRE_CAT_NAME] = 40;


OneHitWonder_Druid_KeepUpWeaponBuff = 0;
OneHitWonder_Druid_UseFaerieFire = 1;

OneHitWonder_Options_Druid = {
	"OneHitWonder_Druid_KeepUpWeaponBuff",
	"OneHitWonder_Druid_UseFaerieFire"
}


function OneHitWonder_SetupStuffContinuously_Druid()
	OneHitWonder_BuffTime[ONEHITWONDER_SPELL_MARK_OF_THE_WILD_NAME] = 25*60;
	OneHitWonder_BuffTime[ONEHITWONDER_SPELL_THORNS_NAME] = 9*60;

	OneHitWonder_AddStuffContinuously(ONEHITWONDER_SPELL_MARK_OF_THE_WILD_NAME, false, true, {notInCombat = true, effectName={ONEHITWONDER_SPELL_MARK_OF_THE_WILD_EFFECT, ONEHITWONDER_SPELL_GIFT_OF_THE_WILD_EFFECT}, useWhenHigherManaPercentage=90});
	OneHitWonder_AddStuffContinuously(ONEHITWONDER_SPELL_THORNS_NAME, false, true, {useWhenHigherManaPercentage=80});
end

function OneHitWonder_Druid_SetUseFaerieFire(toggle)
	OneHitWonder_Druid_UseFaerieFire = toggle;
end



function OneHitWonder_Druid_Cosmos()
	if ( Cosmos_RegisterConfiguration ) and ( Cosmos_UpdateValue ) then
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_DRUID_SEPARATOR",
			"SEPARATOR",
			TEXT(ONEHITWONDER_DRUID_SEPARATOR),
			TEXT(ONEHITWONDER_DRUID_SEPARATOR_INFO)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_DRUID_USE_FAERIE_FIRE",
			"CHECKBOX",
			TEXT(ONEHITWONDER_DRUID_USE_FAERIE_FIRE),
			TEXT(ONEHITWONDER_DRUID_USE_FAERIE_FIRE_INFO),
			OneHitWonder_Druid_SetUseFaerieFire,
			OneHitWonder_Druid_UseFaerieFire
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_DRUID_KEEP_UP_OMEN_OF_CLARITY",
			"CHECKBOX",
			TEXT(ONEHITWONDER_DRUID_KEEP_UP_OMEN_OF_CLARITY),
			TEXT(ONEHITWONDER_DRUID_KEEP_UP_OMEN_OF_CLARITY_INFO),
			OneHitWonder_Druid_SetKeepUpWeaponBuff,
			OneHitWonder_Druid_KeepUpWeaponBuff
		);
	end
end

function OneHitWonder_Druid_SetKeepUpWeaponBuff(toggle)
	OneHitWonder_Druid_KeepUpWeaponBuff = toggle;
end

ONEHITWONDER_DRUID_SHAPESHIFT_FORM_NORMAL		= "Normal";

function OneHitWonder_Druid_GetCurrentShapeshiftform()
	local numForms = GetNumShapeshiftForms();
	local texture, name, isActive, isCastable;
	for i=1, NUM_SHAPESHIFT_SLOTS do
		if ( i <= numForms ) then
			texture, name, isActive, isCastable = GetShapeshiftFormInfo(i);
			if ( isActive ) then
				return name;
			end
		end
	end
	return ONEHITWONDER_DRUID_SHAPESHIFT_FORM_NORMAL;
end

OneHitWonder_Druid_WeaponSpellName = {
	ONEHITWONDER_SPELL_OMEN_OF_CLARITY_NAME
};

OneHitWonder_Druid_WeaponEffectName = {
	ONEHITWONDER_SPELL_OMEN_OF_CLARITY_EFFECT
};

OneHitWonder_Druid_KeepUpWeaponBuff_LastTime = nil;

function OneHitWonder_Druid_DoKeepUpWeaponBuff(canCast)
	if ( not OneHitWonder_Druid_KeepUpWeaponBuff ) or ( OneHitWonder_Druid_KeepUpWeaponBuff <= 0 ) then
		return false;
	end
	if ( not OneHitWonder_ShouldTryToCastABuff() ) then
		return false;
	end
	local curTime = GetTime();
	if ( OneHitWonder_Druid_KeepUpWeaponBuff_LastTime ) then
		if ( curTime - OneHitWonder_Druid_KeepUpWeaponBuff_LastTime < 5 ) then
			return false;
		end
	end
	OneHitWonder_Druid_KeepUpWeaponBuff_LastTime = curTime;
	local spellName = OneHitWonder_Druid_WeaponSpellName[OneHitWonder_Druid_KeepUpWeaponBuff];
	local spellId = -1;
	if ( spellName ) then 
		spellId = OneHitWonder_GetSpellId(spellName);
	end
	if ( spellId <= -1 ) then
		return false;
	end
	--if ( not OneHitWonder_HasItemEffect(OneHitWonder_Druid_WeaponEffectName, 16) ) then
	--[[
	local isBuffGone = true;
	if ( TempEnchant1:IsVisible() ) then
		local duration = tonumber(TempEnchant1Duration:GetText());
		if ( not duration ) or ( duration > 10 ) then
			isBuffGone = true;
		end
	end
	if ( isBuffGone ) then
	]]--
	if ( not OneHitWonder_HasPlayerEffect(nil, OneHitWonder_Druid_WeaponEffectName) ) then
		if ( canCast ) then
			return OneHitWonder_CastSpell(spellId);
		else
			OneHitWonder_AddActionToQueue(ONEHITWONDER_ACTIONID_SPELL, spellId);
			return true;
		end
	end
	return false;
end


function OneHitWonder_DoStuffContinuously_Druid()
	if ( OneHitWonder_Druid_DoKeepUpWeaponBuff(true) ) then
		return true;
	end
	if ( OneHitWonder_CleanSelf() ) then
		return true;
	end
	return false;
end

function OneHitWonder_Druid(removeDefense)
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
		return false;
	end
	
	if ( not UnitCanAttack("player", "target") ) then
		if ( not OneHitWonder_UseCountermeasures() ) then
			if ( not OneHitWonder_DoBuffs() ) then
				if ( OneHitWonder_DoStuffContinuously() ) then
					return true;
				end
			end
		end
		return false;
	end
	
	OneHitWonder_CheckFriendlies();
	
	if ( OneHitWonder_HandleActionQueue() ) then
		return;
	end

	if (not OneHitWonder_StartCombat()) then 
		return false
	end

	if ( OneHitWonder_Druid_UseFaerieFire == 1 ) and 
	( not OneHitWonder_HasUnitEffect("target", nil, 
	{ ONEHITWONDER_SPELL_FAERIE_FIRE_NAME, ONEHITWONDER_SPELL_FAERIE_FIRE_BEAR_NAME, 
	ONEHITWONDER_SPELL_FAERIE_FIRE_CAT_NAME } ) ) then
		local spellId = -1;
		local spellName = "";
		local currentForm = OneHitWonder_Druid_GetCurrentShapeshiftform();
		if ( currentForm == ONEHITWONDER_DRUID_SHAPESHIFT_FORM_BEAR ) or ( currentForm == ONEHITWONDER_DRUID_SHAPESHIFT_FORM_DIRE_BEAR ) then
			spellName = ONEHITWONDER_SPELL_FAERIE_FIRE_BEAR_NAME;
		elseif ( currentForm == ONEHITWONDER_DRUID_SHAPESHIFT_FORM_CAT ) then
			spellName = ONEHITWONDER_SPELL_FAERIE_FIRE_CAT_NAME;
		elseif ( currentForm == ONEHITWONDER_DRUID_SHAPESHIFT_FORM_NORMAL ) or ( currentForm == ONEHITWONDER_DRUID_SHAPESHIFT_FORM_MOONKIN)  then
			spellName = ONEHITWONDER_SPELL_FAERIE_FIRE_NAME;
		else
			if ( not currentForm ) then
				currentForm = "<NIL>";
			end
			OneHitWonder_Print(string.format("ALERT: Unknown form assumed - %s.\nTell sarf of this, please.", currentForm));
		end
		if ( strlen(spellName) > 0 ) then
			spellId = OneHitWonder_GetSpellId(spellName);
		end
		if ( ( spellId > -1 ) and ( OneHitWonder_IsSpellAvailable(spellId ) ) ) then
			if ( OneHitWonder_CastSpellOnTarget(spellId) ) then
				OneHitWonder_ApplyMyAbilityToTarget(spellName, OneHitWonder_Druid_SpellDuration[spellName]);
				return;
			end
		end
	end
	
	OneHitWonder_MeleeAttack();

	if ( not OneHitWonder_DoBuffs() ) then
		if ( OneHitWonder_CastIfTargetNotHasEffect(ONEHITWONDER_ABILITY_SHOOT, ONEHITWONDER_ABILITY_SHOOT) ) then
			return;
		end
	end
end

function OneHitWonder_Druid_RetrieveCleansingSpellId(unit)
	if ( OneHitWonder_IsUnitValidToClean(unit) ) then
		if ( OneHitWonder_ShouldAutoCure == 1 ) then
			local removeCurseId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_REMOVE_CURSE_NAME);
			local abolishPoisonId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_ABOLISH_POISON_NAME);
			if ( removeCurseId > -1 ) or ( abolishPoisonId > -1 ) then
				local debuffOptions = {
					minimumDuration = {
						[ONEHITWONDER_DEBUFF_TYPE_DISEASE] = 5,
					}
				};
				local debuffsByType = OneHitWonder_GetDebuffsByType(unit, debuffOptions);
				local hasCurse = ( debuffsByType[ONEHITWONDER_DEBUFF_TYPE_CURSE] ) and ( table.getn(debuffsByType[ONEHITWONDER_DEBUFF_TYPE_CURSE]) > 0 );
				local hasPoison = ( debuffsByType[ONEHITWONDER_DEBUFF_TYPE_POISON] ) and ( table.getn(debuffsByType[ONEHITWONDER_DEBUFF_TYPE_POISON]) > 0 );
				if ( hasCurse ) then
					return removeCurseId;
				end
				if ( hasPoison ) and ( not OneHitWonder_HasUnitEffect(unit, nil, ONEHITWONDER_SPELL_ABOLISH_POISON_EFFECT) ) then
					return abolishPoisonId;
				end
			end
		end
	end
	return -1;
end

function OneHitWonder_CheckEffect_Druid(unit)
	if ( UnitCanAttack("player", unit) ) then
		return false;
	end
	local doneStuff = false;
	local spellId = OneHitWonder_Druid_RetrieveCleansingSpellId(unit);
	if ( spellId ) and ( spellId > -1 ) then
		local actionId = OneHitWonder_GetActionIdFromSpellId(spellId);
		if ( unit == "player" ) and ( actionId ) and ( actionId > -1 ) then
			local parameters = { actionId, spellId };
			OneHitWonder_AddActionToQueue(ONEHITWONDER_ACTIONID_ACTION_SELF, parameters);
			doneStuff = true;
		elseif ( not OneHitWonder_HasTarget() ) or ( UnitName("target") == UnitName(unit) ) or ( UnitCanAttack("player", "target") ) then
			local parameters = { spellId, unit };
			OneHitWonder_AddActionToQueue(ONEHITWONDER_ACTIONID_SPELL_TARGET, parameters);
			doneStuff = true;
		end
	end
	return doneStuff;
end

function OneHitWonder_ShouldTryToCastABuff_Druid(ignoreCloakEffects)
	local currentForm = OneHitWonder_Druid_GetCurrentShapeshiftform();
	if ( currentForm == ONEHITWONDER_DRUID_SHAPESHIFT_FORM_NORMAL ) or (currentForm == ONEHITWONDER_DRUID_SHAPESHIFT_FORM_MOONKIN) then
		return true;
	elseif ( currentForm == ONEHITWONDER_DRUID_SHAPESHIFT_FORM_CAT ) and ( ignoreCloakEffects ) then
		return true;
	else
		return false;
	end
end
