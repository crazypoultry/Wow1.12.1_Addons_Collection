
OneHitWonder_Priest_UseMindBlastInGroups = 0;
OneHitWonder_Priest_UseMindBlastSolo = 1;
OneHitWonder_Priest_AggressiveWonder = 0;

OneHitWonder_Priest_UseTouchOfWeakness = 1;

OneHitWonder_Priest_AutoBuffPowerWordFortitudeGroup = 1;
OneHitWonder_Priest_AutoBuffPowerWordFortitudeSolo = 1;

OneHitWonder_Priest_AutoBuffShadowProtection = 0;
OneHitWonder_Priest_AutoBuffShadowProtectionSolo = 0;
OneHitWonder_Priest_KeepUpShadowguard = 1;
OneHitWonder_Priest_KeepUpShadowguardManaRequired = 60;

OneHitWonder_Priest_AutoBuffInnerFire = 1;
OneHitWonder_Priest_AutoBuffInnerFireInCombat = 1;
OneHitWonder_Priest_AutoBuffInnerFireInGroups = 1;
OneHitWonder_Priest_AutoBuffInnerFireAlways = 0;

OneHitWonder_Priest_AutoHoTInCombat = 0;

OneHitWonder_Priest_KeepUpSelfShieldInCombat = 0;

OneHitWonder_Priest_ShouldShieldCritical = 0;
OneHitWonder_Priest_ShieldCriticalBelowHP = 500;

OneHitWonder_Priest_UseFeedback = 1;

OneHitWonder_Options_Priest = {
	"OneHitWonder_Priest_UseMindBlastInGroups",
	"OneHitWonder_Priest_UseMindBlastSolo",
	"OneHitWonder_Priest_AggressiveWonder",
	"OneHitWonder_Priest_UseTouchOfWeakness",
	"OneHitWonder_Priest_KeepUpShadowguard",
	"OneHitWonder_Priest_KeepUpShadowguardManaRequired",
	"OneHitWonder_Priest_AutoBuffShadowProtection",
	"OneHitWonder_Priest_AutoBuffShadowProtectionSolo",
	"OneHitWonder_Priest_AutoBuffInnerFire",
	"OneHitWonder_Priest_AutoBuffInnerFireInCombat",
	"OneHitWonder_Priest_AutoBuffInnerFireInGroups",
	"OneHitWonder_Priest_AutoBuffInnerFireAlways", 
	"OneHitWonder_Priest_AutoHoTInCombat",
	"OneHitWonder_Priest_ShouldShieldCritical",
	"OneHitWonder_Priest_ShieldCriticalBelowHP",
	"OneHitWonder_Priest_UseFeedback",
};


function OneHitWonder_Priest_SetUseFeedback(toggle)
	local hasChanged = false;
	if ( OneHitWonder_Priest_UseFeedback ~= toggle ) then
		OneHitWonder_Priest_UseFeedback = toggle;
		hasChanged = true;
	end
	if ( hasChanged ) then
		OneHitWonder_SetupStuffContinuously();
	end
end

function OneHitWonder_Priest_SetAutoHoTInCombat(toggle)
	OneHitWonder_Priest_AutoHoTInCombat = toggle;
end

function OneHitWonder_Priest_SetShouldShieldCritical(toggle)
	OneHitWonder_Priest_ShouldShieldCritical = toggle;
end

function OneHitWonder_Priest_SetShouldShieldCriticalSlider(toggle,value)
	OneHitWonder_Priest_ShieldCriticalBelowHP = value*50;
end

function OneHitWonder_Priest_ShouldAutoBuffInnerFire()
	if ( ( OneHitWonder_Priest_AutoBuffInnerFire == 0 ) or (
		( OneHitWonder_IsInPartyOrRaid() ) and ( OneHitWonder_Priest_AutoBuffInnerFireInGroups == 0 ) )  
		) then
		return false;
	else
		return true;
	end
end

function OneHitWonder_Priest_SetAutoBuffInnerFireInCombat(toggle)
	if ( OneHitWonder_Priest_AutoBuffInnerFireInCombat ~= toggle ) then
		OneHitWonder_Priest_AutoBuffInnerFireInCombat = toggle;
		OneHitWonder_SetupStuffContinuously();
	end
end

function OneHitWonder_Priest_SetAutoBuffInnerFireAlways(toggle)
	if ( OneHitWonder_Priest_AutoBuffInnerFireAlways ~= toggle ) then
		OneHitWonder_Priest_AutoBuffInnerFireAlways = toggle;
		OneHitWonder_SetupStuffContinuously();
	end
end

function OneHitWonder_Priest_SetUseMindBlastSolo(toggle)
	if ( OneHitWonder_Priest_UseMindBlastSolo ~= toggle ) then
		OneHitWonder_Priest_UseMindBlastSolo = toggle;
	end
end

function OneHitWonder_Priest_SetUseMindBlastInGroups(toggle)
	if ( OneHitWonder_Priest_UseMindBlastInGroups ~= toggle ) then
		OneHitWonder_Priest_UseMindBlastInGroups = toggle;
	end
end

function OneHitWonder_Priest_SetAggressiveWonder(toggle)
	if ( OneHitWonder_Priest_AggressiveWonder ~= toggle ) then
		OneHitWonder_Priest_AggressiveWonder = toggle;
	end
end

function OneHitWonder_Priest_SetUseTouchOfWeakness(toggle)
	if ( OneHitWonder_Priest_UseTouchOfWeakness ~= toggle ) then
		OneHitWonder_Priest_UseTouchOfWeakness = toggle;
	end
end

function OneHitWonder_Priest_SetAutoBuffShadowProtection(toggle)
	if ( OneHitWonder_Priest_AutoBuffShadowProtection ~= toggle ) then
		OneHitWonder_Priest_AutoBuffShadowProtection = toggle;
		OneHitWonder_SetupStuffContinuously();
	end
end

function OneHitWonder_Priest_SetAutoBuffShadowProtectionSolo(toggle)
	if ( OneHitWonder_Priest_AutoBuffShadowProtectionSolo ~= toggle ) then
		OneHitWonder_Priest_AutoBuffShadowProtectionSolo = toggle;
		OneHitWonder_SetupStuffContinuously();
	end
end

function OneHitWonder_Priest_SetAutoBuffInnerFire(toggle)
	if ( OneHitWonder_Priest_AutoBuffInnerFire ~= toggle ) then
		OneHitWonder_Priest_AutoBuffInnerFire = toggle;
		OneHitWonder_SetupStuffContinuously();
	end
end

function OneHitWonder_Priest_SetAutoBuffInnerFireInGroups(toggle)
	if ( OneHitWonder_Priest_AutoBuffInnerFireInGroups ~= toggle ) then
		OneHitWonder_Priest_AutoBuffInnerFireInGroups = toggle;
		if ( OneHitWonder_IsInPartyOrRaid() ) then
			OneHitWonder_SetupStuffContinuously();
		end
	end
end

function OneHitWonder_Priest_SetKeepUpShadowguard(toggle, value)
	local hasChanged = false;
	if ( OneHitWonder_Priest_KeepUpShadowguard ~= toggle ) then
		OneHitWonder_Priest_KeepUpShadowguard = toggle;
		hasChanged = true;
	end
	if ( value ~= OneHitWonder_Priest_KeepUpShadowguardManaRequired ) then
		OneHitWonder_Priest_KeepUpShadowguardManaRequired = value;
		if ( OneHitWonder_Priest_KeepUpShadowguard == 1 ) then
			hasChanged = true;
		end
	end
	if ( hasChanged ) then
		OneHitWonder_SetupStuffContinuously();
	end
end

function OneHitWonder_SetupStuffContinuously_Priest()
	OneHitWonder_BuffTime[ONEHITWONDER_SPELL_POWER_WORD_FORTITUDE_NAME] = 25*60;
	OneHitWonder_BuffTime[ONEHITWONDER_SPELL_DIVINE_SPIRIT_NAME] = 25*60;
	OneHitWonder_BuffTime[ONEHITWONDER_SPELL_PRAYER_OF_FORTITUDE_EFFECT] = 25*60;
	--OneHitWonder_BuffTime[ONEHITWONDER_SPELL_INNER_FIRE_NAME] = 5*60;
	local inGroup = OneHitWonder_IsInPartyOrRaid();
	OneHitWonder_AddStuffContinuously(ONEHITWONDER_SPELL_POWER_WORD_FORTITUDE_NAME, false, true, {effectName = {ONEHITWONDER_SPELL_POWER_WORD_FORTITUDE_EFFECT, ONEHITWONDER_SPELL_PRAYER_OF_FORTITUDE_EFFECT}, notInCombat = true, useWhenHigherManaPercentage=90});
	if ( ( inGroup ) and ( OneHitWonder_Priest_AutoBuffShadowProtection == 1 ) )
		or ( ( not inGroup ) and ( OneHitWonder_Priest_AutoBuffShadowProtectionSolo == 1 ) ) then
		OneHitWonder_AddStuffContinuously(ONEHITWONDER_SPELL_SHADOW_PROTECTION_NAME, false, true, {effectName = {ONEHITWONDER_SPELL_SHADOW_PROTECTION_NAME, ONEHITWONDER_SPELL_PRAYER_OF_SHADOW_PROTECTION_NAME, ONEHITWONDER_SPELL_SHADOW_RESISTANCE_AURA_NAME}, notInCombat = true, useWhenHigherManaPercentage=90});
	end
	OneHitWonder_AddStuffContinuously(ONEHITWONDER_SPELL_DIVINE_SPIRIT_NAME, false, true, {notInCombat = true, effectName = {ONEHITWONDER_SPELL_DIVINE_SPIRIT_NAME, ONEHITWONDER_SPELL_PRAYER_OF_SPIRIT_NAME}});

	OneHitWonder_AddStuffContinuously(ONEHITWONDER_SPELL_FEAR_WARD_NAME, false, true, {notInCombat = true});

	if ( OneHitWonder_ShouldKeepBuffsUp == 1 ) then
		if ( OneHitWonder_Priest_KeepUpShadowguard == 1 ) then
			OneHitWonder_AddStuffContinuously(ONEHITWONDER_SPELL_SHADOWGUARD_NAME, true, true, {useWhenHigherManaPercentage = OneHitWonder_Priest_KeepUpShadowguardManaRequired});
		end
	end

	if ( OneHitWonder_Priest_ShouldAutoBuffInnerFire() ) and ( OneHitWonder_ShouldKeepBuffsUp == 1 ) then
		if ( OneHitWonder_Priest_AutoBuffInnerFireAlways == 1 ) then
			OneHitWonder_AddStuffContinuously(ONEHITWONDER_SPELL_INNER_FIRE_NAME, true, true, {useWhenHigherManaPercentage = 5});
		else
			local useInCombat = true;
			if ( OneHitWonder_Priest_AutoBuffInnerFireInCombat ~= 1 ) then
				useInCombat = false;
			end
			if ( useInCombat ) then
				OneHitWonder_AddStuffContinuously(ONEHITWONDER_SPELL_INNER_FIRE_NAME, true, true, {requiresCombat = true, useWhenHigherManaPercentage = 25});
				OneHitWonder_AddStuffContinuously(ONEHITWONDER_SPELL_INNER_FIRE_NAME, true, true, {requiresCombat = true, onlyWhileHated = true, useWhenHigherManaPercentage = 50});
			end
			OneHitWonder_AddStuffContinuously(ONEHITWONDER_SPELL_INNER_FIRE_NAME, true, true, {notInCombat = true, useWhenHigherManaPercentage = 95});
		end
	end
end

function OneHitWonder_Priest_Cosmos()
	if ( Cosmos_RegisterConfiguration ) and ( Cosmos_UpdateValue ) then
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_PRIEST_SEPARATOR",
			"SEPARATOR",
			TEXT(ONEHITWONDER_PRIEST_SEPARATOR),
			TEXT(ONEHITWONDER_PRIEST_SEPARATOR_INFO)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_PRIEST_AGGRESSIVE",
			"CHECKBOX",
			TEXT(ONEHITWONDER_PRIEST_AGGRESSIVE),
			TEXT(ONEHITWONDER_PRIEST_AGGRESSIVE_INFO),
			OneHitWonder_Priest_SetAggressiveWonder,
			OneHitWonder_Priest_AggressiveWonder
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_PRIEST_AUTO_HOT_IN_COMBAT",
			"CHECKBOX",
			TEXT(ONEHITWONDER_PRIEST_AUTO_HOT_IN_COMBAT),
			TEXT(ONEHITWONDER_PRIEST_AUTO_HOT_IN_COMBAT_INFO),
			OneHitWonder_Priest_SetAutoHoTInCombat,
			OneHitWonder_Priest_AutoHoTInCombat
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_PRIEST_SHIELD_CRITICAL",
			"CHECKBOX",
			TEXT(ONEHITWONDER_PRIEST_SHIELD_CRITICAL),
			TEXT(ONEHITWONDER_PRIEST_SHIELD_CRITICAL_INFO),
			OneHitWonder_Priest_SetShouldShieldCritical,
			OneHitWonder_Priest_ShouldShieldCritical
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_PRIEST_SHIELD_CRITICAL_SLIDER",
			"SLIDER",
			TEXT(ONEHITWONDER_PRIEST_SHIELD_CRITICAL_SLIDER),
			TEXT(ONEHITWONDER_PRIEST_SHIELD_CRITICAL_SLIDER),
			OneHitWonder_Priest_SetShouldShieldCriticalSlider,
			0,
			OneHitWonder_Priest_ShieldCriticalBelowHP,  
			1, -- min value
			80, -- max value
			ONEHITWONDER_PRIEST_SHIELD_CRITICAL_SLIDER, -- slider text
			1, 
			1, 
			ONEHITWONDER_PRIEST_SHIELD_CRITICAL_APPEND, -- slider text append
			50 -- slider multiplier
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_PRIEST_USE_MIND_BLAST_IN_GROUPS",
			"CHECKBOX",
			TEXT(ONEHITWONDER_PRIEST_USE_MIND_BLAST_IN_GROUPS),
			TEXT(ONEHITWONDER_PRIEST_USE_MIND_BLAST_IN_GROUPS_INFO),
			OneHitWonder_Priest_SetUseMindBlastInGroups,
			OneHitWonder_Priest_UseMindBlastInGroups
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_PRIEST_USE_MIND_BLAST_SOLO",
			"CHECKBOX",
			TEXT(ONEHITWONDER_PRIEST_USE_MIND_BLAST_SOLO),
			TEXT(ONEHITWONDER_PRIEST_USE_MIND_BLAST_SOLO_INFO),
			OneHitWonder_Priest_SetUseMindBlastSolo,
			OneHitWonder_Priest_UseMindBlastSolo
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_PRIEST_USE_TOUCH_OF_WEAKNESS",
			"CHECKBOX",
			TEXT(ONEHITWONDER_PRIEST_USE_TOUCH_OF_WEAKNESS),
			TEXT(ONEHITWONDER_PRIEST_USE_TOUCH_OF_WEAKNESS_INFO),
			OneHitWonder_Priest_SetUseTouchOfWeakness,
			OneHitWonder_Priest_UseTouchOfWeakness
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_PRIEST_BUFF_INNER_FIRE",
			"CHECKBOX",
			TEXT(ONEHITWONDER_PRIEST_BUFF_INNER_FIRE),
			TEXT(ONEHITWONDER_PRIEST_BUFF_INNER_FIRE_INFO),
			OneHitWonder_Priest_SetAutoBuffInnerFire,
			OneHitWonder_Priest_AutoBuffInnerFire
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_PRIEST_BUFF_INNER_FIRE_ALWAYS",
			"CHECKBOX",
			TEXT(ONEHITWONDER_PRIEST_BUFF_INNER_FIRE_ALWAYS),
			TEXT(ONEHITWONDER_PRIEST_BUFF_INNER_FIRE_ALWAYS_INFO),
			OneHitWonder_Priest_SetAutoBuffInnerFireAlways,
			OneHitWonder_Priest_AutoBuffInnerFireAlways
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_PRIEST_BUFF_INNER_FIRE_IN_COMBAT",
			"CHECKBOX",
			TEXT(ONEHITWONDER_PRIEST_BUFF_INNER_FIRE_IN_COMBAT),
			TEXT(ONEHITWONDER_PRIEST_BUFF_INNER_FIRE_IN_COMBAT_INFO),
			OneHitWonder_Priest_SetAutoBuffInnerFireInCombat,
			OneHitWonder_Priest_AutoBuffInnerFireInCombat
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_PRIEST_BUFF_INNER_FIRE_IN_GROUPS",
			"CHECKBOX",
			TEXT(ONEHITWONDER_PRIEST_BUFF_INNER_FIRE_IN_GROUPS),
			TEXT(ONEHITWONDER_PRIEST_BUFF_INNER_FIRE_IN_GROUPS_INFO),
			OneHitWonder_Priest_SetAutoBuffInnerFireInGroups,
			OneHitWonder_Priest_AutoBuffInnerFireInGroups
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_PRIEST_BUFF_SHADOW_PROTECTION",
			"CHECKBOX",
			TEXT(ONEHITWONDER_PRIEST_BUFF_SHADOW_PROTECTION),
			TEXT(ONEHITWONDER_PRIEST_BUFF_SHADOW_PROTECTION_INFO),
			OneHitWonder_Priest_SetAutoBuffShadowProtection,
			OneHitWonder_Priest_AutoBuffShadowProtection
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_PRIEST_BUFF_SHADOW_PROTECTION_SOLO",
			"CHECKBOX",
			TEXT(ONEHITWONDER_PRIEST_BUFF_SHADOW_PROTECTION_SOLO),
			TEXT(ONEHITWONDER_PRIEST_BUFF_SHADOW_PROTECTION_SOLO_INFO),
			OneHitWonder_Priest_SetAutoBuffShadowProtectionSolo,
			OneHitWonder_Priest_AutoBuffShadowProtectionSolo
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_PRIEST_USE_FEEDBACK",
			"CHECKBOX",
			TEXT(ONEHITWONDER_PRIEST_USE_FEEDBACK),
			TEXT(ONEHITWONDER_PRIEST_USE_FEEDBACK_INFO),
			OneHitWonder_Priest_SetUseFeedback,
			OneHitWonder_Priest_UseFeedback
		);

		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_PRIEST_SHADOWGUARD",
			"BOTH",
			TEXT(ONEHITWONDER_PRIEST_SHADOWGUARD),
			TEXT(ONEHITWONDER_PRIEST_SHADOWGUARD_INFO),
			OneHitWonder_Priest_SetKeepUpShadowguard,
			OneHitWonder_Priest_KeepUpShadowguard,  -- checked
			OneHitWonder_Priest_KeepUpShadowguardManaRequired, -- default value
			0, -- min value
			100, -- max value
			ONEHITWONDER_PRIEST_SHADOWGUARD_SLIDER, -- slider text
			1, 
			1, 
			ONEHITWONDER_PRIEST_SHADOWGUARD_APPEND, -- slider text append
			1 -- slider multiplier
		);
	end
end

function OneHitWonder_Priest_SWP()
	local spellId = -1;
	if ( OneHitWonder_Priest_AggressiveWonder == 1 ) then
		if ( OneHitWonder_IsInPartyOrRaid() ) then
			spellId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_VAMPIRIC_EMBRACE_NAME);
			if ( spellId > -1 ) and ( OneHitWonder_IsSpellAvailable(spellId) ) then
				if ( OneHitWonder_CastIfTargetNotHasEffect(ONEHITWONDER_SPELL_VAMPIRIC_EMBRACE_NAME, ONEHITWONDER_SPELL_VAMPIRIC_EMBRACE_EFFECT) ) then
					return true;
				end
			end
		end

		local targetHP = OneHitWonder_GetTargetHPPercentage();

		-- TODO: estimate if the damage done is likely using Estimated Time to Death
		--      USE local healthLeft, healthMax = OneHitWonder_GetUnitHealth("target");
		-- (parse SW:P)
		if ( OneHitWonder_InBossMode() ) or ( targetHP >= 20 ) then
			if ( OneHitWonder_CastIfTargetNotHasEffect(ONEHITWONDER_SPELL_SHADOW_WORD_PAIN_NAME, ONEHITWONDER_SPELL_SHADOW_WORD_PAIN_EFFECT) ) then
				return true;
			end
		end
	end
	return false;
end

function OneHitWonder_Priest_DoKeepUpWeaponBuff(canCast)
	if ( OneHitWonder_Priest_UseFeedback ~= 1 ) then
		return false;
	end
	if ( not OneHitWonder_ShouldTryToCastABuff() ) then
		return false;
	end
	local buffname = ONEHITWONDER_SPELL_FEEDBACK_NAME;
	local ok = OneHitWonder_KeepUpWeaponSpell(buffname, ONEHITWONDER_SPELL_FEEDBACK_NAME, 16, canCast);
	return ok;
end

function OneHitWonder_Priest(removeDefense)
	local targetName = UnitName("target");
	--OneHitWonder_Print(targetName)

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
	
	if ( not UnitCanAttack("player", "target") ) then
		if ( not OneHitWonder_UseCountermeasures() ) then
			if ( not OneHitWonder_DoBuffs() ) then
			end
		end
		return;
	end
	
	if ( OneHitWonder_HandleActionQueue() ) then
		return;
	end
	
	if ( OneHitWonder_Priest_DoKeepUpWeaponBuff(true) ) then
		return true;
	end

	if (not OneHitWonder_StartCombat()) then 
		return false
	end

	local targetHP = OneHitWonder_GetTargetHPPercentage();
	
	if ( OneHitWonder_Priest_AggressiveWonder == 1 ) then
		if ( OneHitWonder_Priest_UseTouchOfWeakness == 1 ) then
			local touchOfWeaknessId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_TOUCH_OF_WEAKNESS_NAME);
			if ( touchOfWeaknessId > -1 ) and ( not OneHitWonder_HasPlayerEffect(nil, ONEHITWONDER_SPELL_TOUCH_OF_WEAKNESS_NAME ) ) then
				if ( not OneHitWonder_HasUnitEffect("target", nil, ONEHITWONDER_SPELL_TOUCH_OF_WEAKNESS_NAME ) ) then
					if ( OneHitWonder_CastSpell(touchOfWeaknessId) ) then
						return;
					end
				end
			end
		end
		OneHitWonder_MeleeAttack();
		local inCombat = OneHitWonder_IsInCombat()
		if (inCombat or OneHitWonder_IsInPartyOrRaid()) and OneHitWonder_Priest_SWP() then
			return true;
		end
	end

	if ( not OneHitWonder_DoBuffs() ) then
		if ( OneHitWonder_Priest_AggressiveWonder == 1 ) then
			OneHitWonder_MeleeAttack();
			local spellId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_HOLY_FIRE_NAME);
			if ( spellId > -1 ) and ( OneHitWonder_IsSpellAvailable(spellId) ) then
				if ( OneHitWonder_CastIfTargetNotHasEffect(ONEHITWONDER_SPELL_HOLY_FIRE_NAME, ONEHITWONDER_SPELL_HOLY_FIRE_EFFECT) ) then
					return;
				end
			end
			if ( OneHitWonder_Priest_UseMindBlastInGroups == 1 ) or ( not OneHitWonder_IsInPartyOrRaid() and OneHitWonder_Priest_UseMindBlastSolo == 1 ) then
				spellId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_MIND_BLAST_NAME);
				if ( spellId > -1 ) and ( OneHitWonder_IsSpellAvailable(spellId) ) then
					if ( OneHitWonder_CastSpellOnTarget(spellId) ) then
						return;
					end
				end
			end
			spellId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_MIND_FLAY_NAME);
			if ( spellId > -1 ) and ( OneHitWonder_IsSpellAvailable(spellId) ) then
				if ( OneHitWonder_CastSpellOnTarget(spellId) ) then
					return;
				end
			end
			spellId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_SMITE_NAME);
			if ( spellId > -1 ) and ( OneHitWonder_IsSpellAvailable(spellId) ) then
				if ( OneHitWonder_CastSpellOnTarget(spellId) ) then
					return;
				end
			end
			spellId = OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_SHOOT);
			if ( spellId > -1 ) and ( OneHitWonder_IsSpellAvailable(spellId) ) then
				if ( OneHitWonder_CastSpell(spellId) ) then
					return;
				end
			end
		end
	end
	return OneHitWonder_DoStuffContinuously();
end

function OneHitWonder_Priest_RetrieveCleansingSpellId(unit)
	if ( OneHitWonder_IsUnitValidToClean(unit) ) then
		if ( OneHitWonder_ShouldAutoCure == 1 ) then
			local dispelMagicId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_DISPEL_MAGIC_NAME);
			local abolishDiseaseId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_ABOLISH_DISEASE_NAME);
			local cureDiseaseId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_CURE_DISEASE_NAME);
			if ( dispelMagicId > -1 ) or ( abolishDiseaseId > -1 ) or ( cureDiseaseId > -1 ) then
				local debuffOptions = {
					minimumDuration = {
						[ONEHITWONDER_DEBUFF_TYPE_DISEASE] = 5,
					}
				};
				local debuffsByType = OneHitWonder_GetDebuffsByType(unit, debuffOptions);
				local hasDisease = ( debuffsByType[ONEHITWONDER_DEBUFF_TYPE_DISEASE] ) and ( table.getn(debuffsByType[ONEHITWONDER_DEBUFF_TYPE_DISEASE]) > 0 );
				local hasMagic = ( debuffsByType[ONEHITWONDER_DEBUFF_TYPE_MAGIC] ) and ( table.getn(debuffsByType[ONEHITWONDER_DEBUFF_TYPE_MAGIC]) > 0 );
				if ( hasMagic ) then
					--OneHitWonder_Print("Found magic debuff.");
					local spellId = dispelMagicId;
					-- use rank 1 of the dispel magic spell if only one magic debuff
					if ( table.getn(debuffsByType[ONEHITWONDER_DEBUFF_TYPE_MAGIC]) == 1 ) then
						local spellInfo = DynamicData.spell.getSpellInfo(spellId);
						if ( spellInfo.realRank > 1 ) then
							spellId = DynamicData.spell.getMatchingSpellId(ONEHITWONDER_SPELL_DISPEL_MAGIC_NAME, 1);
						end
					end
					if ( ( spellId ) and ( spellId > -1 ) and ( OneHitWonder_IsUnitInRange(unit) ) ) then
						local actionId = OneHitWonder_GetActionIdFromSpellId(spellId);
						if ( ( not actionId ) or ( actionId <= -1 ) ) and ( dispelMagicId > -1 ) and ( dispelMagicId ~= spellId ) then
							spellId = dispelMagicId;
							actionId = OneHitWonder_GetActionIdFromSpellId(spellId);
						end
						return spellId;
					end
				end
				if ( hasDisease ) then
					--OneHitWonder_Print("Disease found.");
					if ( not OneHitWonder_HasUnitEffect(unit, nil, ONEHITWONDER_SPELL_ABOLISH_DISEASE_EFFECT ) ) then
						local spellId = -1;
						--if ( table.getn(debuffsByType[ONEHITWONDER_DEBUFF_TYPE_DISEASE]) > 1 ) then
						if ( abolishDiseaseId > -1 ) then
							spellId = abolishDiseaseId;
						end
						if ( spellId <= -1 ) then
							spellId = cureDiseaseId;
						end
						if ( ( spellId > -1 ) and ( OneHitWonder_IsUnitInRange(unit) ) ) then
							local actionId = OneHitWonder_GetActionIdFromSpellId(spellId);
							if ( ( not actionId ) or ( actionId <= -1 ) ) and ( abolishDiseaseId ) and ( abolishDiseaseId > -1 ) and ( abolishDiseaseId ~= spellId ) then
								spellId = abolishDiseaseId;
								actionId = OneHitWonder_GetActionIdFromSpellId(spellId);
							end
							return spellId;
						end
					else
						--OneHitWonder_Print("Abolish Disease already underway.");
					end
				end
			end
		end
	end
	return -1;
end

function OneHitWonder_CheckEffect_Priest(unit)
	if ( UnitCanAttack("player", unit) ) then
		return false;
	end
	local doneStuff = false;
	local spellId = -1;
	local inCombat = OneHitWonder_IsInCombat()
	if inCombat then
		spellId = OneHitWonder_Priest_RetrieveCleansingSpellId(unit);
	end
	if ( spellId ) and ( spellId > -1 ) then
		local actionId = OneHitWonder_GetActionIdFromSpellId(spellId);
		if ( unit == "player" ) and ( actionId ) and ( actionId > -1 ) then
			local parameters = { actionId, spellId };
			OneHitWonder_AddActionToQueue(ONEHITWONDER_ACTIONID_ACTION_SELF, parameters);
			doneStuff = true;
		elseif ( not OneHitWonder_HasTarget() ) or ( UnitName("target") == UnitName(unit) ) then
			local parameters = { spellId, unit };
			OneHitWonder_AddActionToQueue(ONEHITWONDER_ACTIONID_SPELL_TARGET, parameters);
			doneStuff = true;
		end
	end
	return doneStuff;
end

function OneHitWonder_CheckEffect_Priest_Old(unit)
	local doneStuff = false;
	local spellId = -1;
	if ( unit ~= "target" ) and ( unit ~= "pet" )  then
		if ( OneHitWonder_ShouldAutoCure == 1 ) then
			local dispelMagicId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_DISPEL_MAGIC_NAME);
			local abolishDiseaseId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_ABOLISH_DISEASE_NAME);
			local cureDiseaseId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_CURE_DISEASE_NAME);
			if ( dispelMagicId > -1 ) or ( abolishDiseaseId > -1 ) or ( cureDiseaseId > -1 ) then
				local debuffOptions = {
					minimumDuration = {
						[ONEHITWONDER_DEBUFF_TYPE_DISEASE] = 5,
					}
				};
				local debuffsByType = OneHitWonder_GetDebuffsByType(unit, debuffOptions);
				local hasDisease = ( debuffsByType[ONEHITWONDER_DEBUFF_TYPE_DISEASE] ) and ( table.getn(debuffsByType[ONEHITWONDER_DEBUFF_TYPE_DISEASE]) > 0 );
				local hasMagic = ( debuffsByType[ONEHITWONDER_DEBUFF_TYPE_MAGIC] ) and ( table.getn(debuffsByType[ONEHITWONDER_DEBUFF_TYPE_MAGIC]) > 0 );
				if ( hasDisease ) then
					--OneHitWonder_Print("Disease found.");
					if ( not OneHitWonder_HasUnitEffect(unit, nil, ONEHITWONDER_SPELL_ABOLISH_DISEASE_EFFECT ) ) then
						local spellId = -1;
						--if ( table.getn(debuffsByType[ONEHITWONDER_DEBUFF_TYPE_DISEASE]) > 1 ) then
						if ( abolishDiseaseId > -1 ) then
							spellId = abolishDiseaseId;
						end
						if ( spellId <= -1 ) then
							spellId = cureDiseaseId;
						end
						if ( ( spellId > -1 ) and ( OneHitWonder_IsUnitInRange(unit) ) ) then
							local actionId = OneHitWonder_GetActionIdFromSpellId(spellId);
							if ( ( not actionId ) or ( actionId <= -1 ) ) and ( abolishDiseaseId ) and ( abolishDiseaseId > -1 ) and ( abolishDiseaseId ~= spellId ) then
								spellId = abolishDiseaseId;
								actionId = OneHitWonder_GetActionIdFromSpellId(spellId);
							end
							if ( unit == "player" ) and ( actionId ) and ( actionId > -1 ) then
								local parameters = { actionId, spellId };
								OneHitWonder_AddActionToQueue(ONEHITWONDER_ACTIONID_ACTION_SELF, parameters);
								--OneHitWonder_Print("Queueing Disease Removal - Action!");
								doneStuff = true;
							else
								local parameters = { spellId, unit };
								OneHitWonder_AddActionToQueue(ONEHITWONDER_ACTIONID_SPELL_TARGET, parameters);
								doneStuff = true;
								--OneHitWonder_Print("Queueing Disease Removal.");
							end
						end
					else
						--OneHitWonder_Print("Abolish Disease already underway.");
					end
				end
				if ( hasMagic ) then
					--OneHitWonder_Print("Found magic debuff.");
					local spellId = dispelMagicId;
					-- use rank 1 of the dispel magic spell if only one magic debuff
					if ( table.getn(debuffsByType[ONEHITWONDER_DEBUFF_TYPE_MAGIC]) == 1 ) then
						local spellInfo = DynamicData.spell.getSpellInfo(spellId);
						if ( spellInfo.realRank > 1 ) then
							spellId = DynamicData.spell.getMatchingSpellId(ONEHITWONDER_SPELL_DISPEL_MAGIC_NAME, 1);
						end
					end
					if ( ( spellId ) and ( spellId > -1 ) and ( OneHitWonder_IsUnitInRange(unit) ) ) then
						local actionId = OneHitWonder_GetActionIdFromSpellId(spellId);
						if ( ( not actionId ) or ( actionId <= -1 ) ) and ( dispelMagicId > -1 ) and ( dispelMagicId ~= spellId ) then
							spellId = dispelMagicId;
							actionId = OneHitWonder_GetActionIdFromSpellId(spellId);
						end
						if ( unit == "player" ) and ( actionId ) and ( actionId > -1 ) then
							local parameters = { actionId, spellId };
							OneHitWonder_AddActionToQueue(ONEHITWONDER_ACTIONID_ACTION_SELF, parameters);
							--OneHitWonder_Print("Queueing Magic Debuff Removal - Action!");
							doneStuff = true;
						elseif ( not OneHitWonder_HasTarget() ) or ( UnitName("target") == UnitName(unit) ) or ( UnitCanAttack("player", "target") ) then
							local parameters = { spellId, unit };
							OneHitWonder_AddActionToQueue(ONEHITWONDER_ACTIONID_SPELL_TARGET, parameters);
							--OneHitWonder_Print("Queueing Magic Debuff Removal.");
							doneStuff = true;
						else
							--OneHitWonder_Print("Queueing Magic Debuff - nope, action.");
						end
					end
				end
			end
		end
	end
	return doneStuff;
end

function OneHitWonder_UnitHasGainedSpell_Priest(unitName, spellName)
	if ( not spellName ) then
		return;
	end
	local spellId = -1;
	spellId = DynamicData.spell.getMatchingSpellId(ONEHITWONDER_SPELL_DISPEL_MAGIC_NAME, 1);
	if ( not spellId ) or ( spellId <= -1 ) then
		return;
	end
	local inCombat = OneHitWonder_IsInCombat()
	if not inCombat then
		return;
	end
	
	if ( OneHitWonder_IsStringInListLoose(spellName, OneHitWonder_DispelSpells, true) ) then
		local parameters = { spellId, "target" };
		OneHitWonder_AddActionToQueue(ONEHITWONDER_ACTIONID_SPELL_TARGET, parameters);
		return;
	end
end


function OneHitWonder_ShouldTryToCastABuff_Priest(ignoreCloakEffects)
	if ( OneHitWonder_HasPlayerEffect(nil, ONEHITWONDER_SPELL_INNER_FOCUS_EFFECT) ) then
		return false;
	else
		return true;
	end
end

function OneHitWonder_UnitIsAfflictedBy_Priest(unit, spellName)
	local spellId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_DISPEL_MAGIC_NAME);
	if ( spellId > -1 ) then
		if ( OneHitWonder_IsStringInListLoose(spellName, OneHitWonder_FearSpells, false) ) then
			local parameters = { spellId, unit };
			OneHitWonder_AddActionToQueue(ONEHITWONDER_ACTIONID_SPELL_TARGET, parameters);
			return true;
		end
	end
	return false;
end

OneHitWonder_Priest_ShieldList = {
	"player",
	"party1",
	"party2",
	"party3",
	"party4",
};

function OneHitWonder_Priest_ShieldCritical()
	local damageList = {};
	for k, v in OneHitWonder_Priest_ShieldList do
		if (v=="player" or UnitPlayerOrPetInParty(v)) then
			--OneHitWonder_Print(v.."health "..UnitHealth(v).." shield threshold "..OneHitWonder_Priest_ShieldCriticalBelowHP)
			if ( not OneHitWonder_HasUnitEffect(v, nil, { ONEHITWONDER_SPELL_POWER_WORD_SHIELD_NAME, ONEHITWONDER_SPELL_POWER_WORD_SHIELD_EFFECT } ) ) then
				if ( UnitHealth(v) < OneHitWonder_Priest_ShieldCriticalBelowHP ) then
					local spellId = OneHitWonder_GetAppropriateSpell(UnitLevel(v), ONEHITWONDER_SPELL_POWER_WORD_SHIELD_NAME);
					OneHitWonder_CastSpellTarget(spellId,v);
					return true;
				end
				--local list = { p = UnitHealth(v)/UnitHealthMax(v), h = UnitHealth(v), hm = UnitHealthMax(v) };
				--damageList[v] = list;
			end
		end
	end
	return false;
end

function OneHitWonder_Priest_HoTTime()
	local damageList = {};
	for k, v in OneHitWonder_Priest_ShieldList do
		if (v=="player" or UnitPlayerOrPetInParty(v)) then
			--OneHitWonder_Print(v.."health "..OneHitWonder_GetUnitHPPercentage(v).." hot threshold 90")
			if ( not OneHitWonder_HasUnitEffect(v, nil, { ONEHITWONDER_SPELL_RENEW_NAME, ONEHITWONDER_SPELL_RENEW_NAME } ) ) then
				if ( OneHitWonder_GetUnitHPPercentage(v) < 90 ) then
					--OneHitWonder_Print("hot time")
					local spellId = OneHitWonder_GetAppropriateSpell(UnitLevel(v), ONEHITWONDER_SPELL_RENEW_NAME);
					OneHitWonder_CastSpellTarget(spellId,v);
					return true;
				end
				--local list = { p = UnitHealth(v)/UnitHealthMax(v), h = UnitHealth(v), hm = UnitHealthMax(v) };
				--damageList[v] = list;
			end
		end
	end
	return false;
end

function OneHitWonder_Priest_ShieldCriticalInCombat()
	local inCombat = OneHitWonder_IsInCombat()
	if ( inCombat and OneHitWonder_Priest_ShieldCritical() ) then
		return true;
	else
		return false;
	end
end

function OneHitWonder_Priest_HoTInCombat()
	local inCombat = OneHitWonder_IsInCombat()
	if ( inCombat and OneHitWonder_Priest_HoTTime() ) then
		return true;
	else
		return false;
	end
end

function OneHitWonder_DoStuffContinuously_Priest()
	if ( OneHitWonder_Priest_KeepUpSelfShieldInCombat == 1 ) and ( OneHitWonder_IsInCombat() ) then
		local spellId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_POWER_WORD_SHIELD_NAME);
		if ( spellId > -1 ) then
			local shieldEffectList = { ONEHITWONDER_SPELL_POWER_WORD_SHIELD_NAME, ONEHITWONDER_SPELL_POWER_WORD_SHIELD_EFFECT };
			if ( not OneHitWonder_HasPlayerEffect(nil, shieldEffectList) ) then
				OneHitWonder_CastSpellTarget(spellId,"player");
			end
		end
	end
	if ( OneHitWonder_Priest_ShouldShieldCritical == 1 ) then
		if ( OneHitWonder_Priest_ShieldCriticalInCombat() ) then
			return true;
		end
	end
	if ( OneHitWonder_Priest_AutoHoTInCombat == 1 ) then
		if ( OneHitWonder_Priest_HoTInCombat() ) then
			return true;
		end
	end
	if ( OneHitWonder_CleanSelf() ) then
		return true;
	end
	if ( OneHitWonder_Priest_DoKeepUpWeaponBuff(true) ) then
		return true;
	end
	return false;
end
