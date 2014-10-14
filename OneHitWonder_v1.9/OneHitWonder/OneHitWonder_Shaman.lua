OneHitWonder_Shaman_ShouldKeepUpWeaponBuff = 1;
OneHitWonder_Shaman_KeepUpWeaponBuff = 1;

OneHitWonder_Shaman_KeepUpLightningShield = 1;

OneHitWonder_Shaman_LightningShieldManaRequired = 0;

OneHitWonder_Shaman_UseEarthShock = 1;
OneHitWonder_Shaman_UseCheapEarthShock = 1;

OneHitWonder_Shaman_UseGroundingTotemEarthShockBackup = 1;

function OneHitWonder_SetupStuffContinuously_Shaman()
	--OneHitWonder_BuffTime[ONEHITWONDER_SPELL_LIGHTNING_SHIELD_NAME] = 9*60;
	if ( OneHitWonder_ShouldKeepBuffsUp == 1 ) then
		if ( OneHitWonder_Shaman_KeepUpLightningShield == 1 ) then
			OneHitWonder_AddStuffContinuously(ONEHITWONDER_SPELL_LIGHTNING_SHIELD_NAME, true, true, {useWhenHigherManaPercentage = OneHitWonder_Shaman_LightningShieldManaRequired});
		end
	end
end

OneHitWonder_Shaman_WeaponSpellName = {
	ONEHITWONDER_SPELL_WINDFURY_WEAPON_NAME,
	ONEHITWONDER_SPELL_ROCKBITER_WEAPON_NAME,
	ONEHITWONDER_SPELL_FLAMETONGUE_WEAPON_NAME,
	ONEHITWONDER_SPELL_FROSTBRAND_WEAPON_NAME
};

OneHitWonder_Shaman_WeaponEffectName = {
	ONEHITWONDER_SPELL_WINDFURY_WEAPON_EFFECT,
	ONEHITWONDER_SPELL_ROCKBITER_WEAPON_EFFECT,
	ONEHITWONDER_SPELL_FLAMETONGUE_WEAPON_EFFECT,
	ONEHITWONDER_SPELL_FROSTBRAND_WEAPON_EFFECT
};

function OneHitWonder_Shaman_SetLightningShieldUpdate(checked, value)
	local hasChanged = false;
	if ( OneHitWonder_Shaman_KeepUpLightningShield ~= checked ) then
		OneHitWonder_Shaman_KeepUpLightningShield = checked;
		hasChanged = true;
	end
	if ( OneHitWonder_Shaman_LightningShieldManaRequired ~= value ) then
		OneHitWonder_Shaman_LightningShieldManaRequired = value;
		if ( OneHitWonder_Shaman_KeepUpLightningShield == 1 ) then
			hasChanged = true;
		end
	end
	if ( hasChanged ) then
		OneHitWonder_SetupStuffContinuously();
	end
end

function OneHitWonder_Shaman_SetKeepUpWeaponBuff(checked, value)
	local shouldDo = false;
	if ( OneHitWonder_Shaman_ShouldKeepUpWeaponBuff ~= checked ) then
		OneHitWonder_Shaman_ShouldKeepUpWeaponBuff = checked;
		shouldDo = true;
	end
	if ( OneHitWonder_Shaman_KeepUpWeaponBuff ~= value ) then
		shouldDo = true;
		OneHitWonder_Shaman_KeepUpWeaponBuff = value;
	end
	if ( shouldDo ) then
		OneHitWonder_Shaman_WeaponScannedAtTime = nil;
		Cosmos_UpdateValue("COS_ONEHITWONDER_SHAMAN_KEEP_UP_WEAPON_BUFF", CSM_CHECKONOFF, checked);
		Cosmos_UpdateValue("COS_ONEHITWONDER_SHAMAN_KEEP_UP_WEAPON_BUFF", CSM_SLIDERVALUE, value);
		Cosmos_UpdateValue("COS_ONEHITWONDER_SHAMAN_KEEP_UP_WEAPON_BUFF_X", CSM_SLIDERVALUE, value);
		OneHitWonder_Shaman_DoKeepUpWeaponBuff();
	end
end

function OneHitWonder_Shaman_ScanWeapon(canCast)
	OneHitWonder_Shaman_WeaponScannedAtTime = nil;
	OneHitWonder_Shaman_DoKeepUpWeaponBuff(canCast);
end

function OneHitWonder_Cycle_WeaponBuff_Shaman(canCast)
	local n = table.getn(OneHitWonder_Shaman_WeaponSpellName);
	local newValue = OneHitWonder_Shaman_KeepUpWeaponBuff;
	if ( not newValue ) or ( newValue <= 0 ) then
		newValue = 0;
	end
	newValue = newValue + 1;
	if ( newValue > n ) then
		newValue = 1;
	end
	OneHitWonder_Shaman_SetKeepUpWeaponBuff(OneHitWonder_Shaman_ShouldKeepUpWeaponBuff, newValue);
	OneHitWonder_Print(string.format(TEXT(ONEHITWONDER_SHAMAN_WEAPON_BUFF_CYCLED), OneHitWonder_Shaman_WeaponSpellName[newValue]));
	if ( not canCast ) then
		OneHitWonder_ScheduleByName("OHW_SHAMAN_WB", 1, OneHitWonder_Shaman_ScanWeapon);
	else
		OneHitWonder_Shaman_ScanWeapon(canCast);
	end
end

OneHitWonder_Shaman_LastSuccessfulWeaponBuff = {};

function OneHitWonder_Shaman_DoKeepUpWeaponBuff(canCast)
	-- bsDebug2(1,"dkpwb("..tostring(canCast)..")" );

	-- bsDebug2(1,"kpwb="..tostring(OneHitWonder_Shaman_KeepUpWeaponBuff) );
	if ( OneHitWonder_Shaman_KeepUpWeaponBuff <= 0 ) then
		return false;
	end
	-- bsDebug2(1,"skpwb="..tostring(OneHitWonder_Shaman_ShouldKeepUpWeaponBuff) );
	if ( OneHitWonder_Shaman_ShouldKeepUpWeaponBuff ~= 1 ) then
		return false;
	end
	if ( not OneHitWonder_ShouldTryToCastABuff() ) then
		-- bsDebug(1,"Should-A-Buff=false" );
		return false;
	end
	local buffname = OneHitWonder_Shaman_WeaponSpellName[OneHitWonder_Shaman_KeepUpWeaponBuff];
	local curtime = GetTime(); local bufftime = OneHitWonder_Shaman_LastSuccessfulWeaponBuff[buffname];
	-- bsDebug2(1,"curtime="..tostring(curtime)..",bufftime="..tostring(bufftime));

	if ( bufftime ) and ( (curtime - bufftime) <= 5 ) then
		return false;
	end
	local ok = OneHitWonder_KeepUpWeaponSpell(buffname, OneHitWonder_Shaman_WeaponEffectName, 16, canCast);
	-- bsDebug2(1,"ok="..tostring(ok));
	if ( ok ) then
		OneHitWonder_Shaman_LastSuccessfulWeaponBuff[buffname] = curtime;
	end
	return ok;
end

function OneHitWonder_DoStuffContinuously_Shaman()
	if ( OneHitWonder_Shaman_DoKeepUpWeaponBuff(true) ) then
		return true;
	end
	if ( OneHitWonder_CleanSelf() ) then
		return true;
	end
	return false;
end

function OneHitWonder_ShouldTryToCastABuff_Shaman()
	if ( OneHitWonder_HasPlayerEffect(nil, ONEHITWONDER_SPELL_GHOST_WOLF_EFFECT) ) then
		return false;
	else
		return true;
	end
end

function OneHitWonder_Shaman_RetrieveCleansingSpellId(unit)
	if ( OneHitWonder_IsUnitValidToClean(unit) ) then
		if ( OneHitWonder_ShouldAutoCure == 1 ) then
			local curePoisonId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_CURE_POISON_NAME);
			local cureDiseaseId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_CURE_DISEASE_NAME);
			if ( curePoisonId > -1 ) or ( cureDiseaseId > -1 ) then
				local debuffOptions = {
					minimumDuration = {
						[ONEHITWONDER_DEBUFF_TYPE_DISEASE] = 5,
					}
				};
				local debuffsByType = OneHitWonder_GetDebuffsByType(unit, debuffOptions);
				local hasDisease = ( debuffsByType[ONEHITWONDER_DEBUFF_TYPE_DISEASE] ) and ( table.getn(debuffsByType[ONEHITWONDER_DEBUFF_TYPE_DISEASE]) > 0 );
				local hasPoison = ( debuffsByType[ONEHITWONDER_DEBUFF_TYPE_POISON] ) and ( table.getn(debuffsByType[ONEHITWONDER_DEBUFF_TYPE_POISON]) > 0 );
				if ( hasPoison ) then
					return curePoisonId;
				end
				if ( hasDisease ) then
					return cureDiseaseId;
				end
			end
		end
	end
	return -1;
end

function OneHitWonder_CheckEffect_Shaman(unit)
	if ( UnitCanAttack("player", unit) ) then
		return false;
	end
	local doneStuff = false;
	local spellId = OneHitWonder_Shaman_RetrieveCleansingSpellId(unit);
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

function OneHitWonder_CheckEffect_ShamanOld(unit)
	local doneStuff = false;
	if ( not OneHitWonder_ShouldTryToCastABuff() ) then
		return false;
	end
	--[[
	if ( unit == "player" ) then
		if ( OneHitWonder_Shaman_DoKeepUpWeaponBuff() ) then
			doneStuff = true;
		end
	end
	]]--
	if ( unit ~= "target" ) then
		if ( OneHitWonder_ShouldAutoCure == 1 ) then
			local curePoisonId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_CURE_POISON_NAME);
			local cureDiseaseId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_CURE_DISEASE_NAME);
			if ( curePoisonId > -1 ) or ( cureDiseaseId > -1 ) then
				local debuffOptions = {
					minimumDuration = {
						[ONEHITWONDER_DEBUFF_TYPE_DISEASE] = 5,
					}
				};
				local debuffsByType = OneHitWonder_GetDebuffsByType(unit, debuffOptions);
				local hasDisease = ( debuffsByType[ONEHITWONDER_DEBUFF_TYPE_DISEASE] ) and ( table.getn(debuffsByType[ONEHITWONDER_DEBUFF_TYPE_DISEASE]) > 0 );
				local hasPoison = ( debuffsByType[ONEHITWONDER_DEBUFF_TYPE_POISON] ) and ( table.getn(debuffsByType[ONEHITWONDER_DEBUFF_TYPE_POISON]) > 0 );
				if ( hasDisease ) then
					local spellId = cureDiseaseId;
					if ( ( spellId > -1 ) and ( OneHitWonder_IsUnitInRange(unit) ) ) then
						local parameters = { spellId, unit, UnitName(unit), 3 };
						OneHitWonder_AddActionToQueue(ONEHITWONDER_ACTIONID_SPELL_TARGET, parameters);
						doneStuff = true;
					end
				end
				if ( hasPoison ) then
					local spellId = curePoisonId;
					if ( ( spellId > -1 ) and ( OneHitWonder_IsUnitInRange(unit) ) ) then
						local parameters = { spellId, unit, UnitName(unit), 3 };
						OneHitWonder_AddActionToQueue(ONEHITWONDER_ACTIONID_SPELL_TARGET, parameters);
						doneStuff = true;
					end
				end
			end
		end
	end
	return doneStuff;
end


function OneHitWonder_TryToInterruptSpell_Shaman(unitName, spellName)
	local interruptId = -1;
	local abilityName = "";
	abilityName = ONEHITWONDER_SPELL_EARTHSHOCK_NAME;
	if ( OneHitWonder_Shaman_UseEarthShock ~= 1 ) then
		abilityName = "";
	end
	if ( ( abilityName ) and 
		(strlen(abilityName) > 0) ) then
		if ( 
			( abilityName == ONEHITWONDER_SPELL_EARTHSHOCK_NAME ) 
			and ( OneHitWonder_Shaman_UseCheapEarthShock == 1 ) 
			and ( not OneHitWonder_HasPlayerEffect(nil, ONEHITWONDER_SPELL_SHAMAN_CLEARCAST_EFFECT) ) ) then
			local rankName = 1;
			interruptId = DynamicData.spell.getMatchingSpellId(abilityName, rankName);
		else
			interruptId = OneHitWonder_GetSpellId(abilityName);
		end
		
		if ( ( not interruptId ) or ( interruptId <= -1) or ( not OneHitWonder_IsSpellAvailable(interruptId) ) ) then
			if ( OneHitWonder_Shaman_UseGroundingTotemEarthShockBackup == 1 ) then
				local name = ONEHITWONDER_SPELL_GROUNDING_TOTEM_NAME;
				interruptId = OneHitWonder_GetSpellId(name);
				if ( interruptId > -1 ) then
					if ( not OneHitWonder_IsSpellAvailable(interruptId ) ) then
						interruptId = -1;
					else
						abilityName = name;
					end
				end
			end
		end
		if ( interruptId <= -1 ) then
			abilityName = "";
			interruptId = -1;
		end
	end
	return interruptId, abilityName;
end

function OneHitWonder_Shaman_SetUseEarthShock(toggle)
	OneHitWonder_Shaman_UseEarthShock = toggle;
end

function OneHitWonder_Shaman_SetUseCheapEarthShock(toggle)
	OneHitWonder_Shaman_UseCheapEarthShock = toggle;
end

function OneHitWonder_Shaman_SetUseGroundingTotemEarthShockBackup(toggle)
	OneHitWonder_Shaman_UseGroundingTotemEarthShockBackup = toggle;
end

function OneHitWonder_Shaman_Cosmos()
	if ( Cosmos_RegisterConfiguration ) and ( Cosmos_UpdateValue ) then
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_SHAMAN_SEPARATOR",
			"SEPARATOR",
			TEXT(ONEHITWONDER_SHAMAN_SEPARATOR),
			TEXT(ONEHITWONDER_SHAMAN_SEPARATOR_INFO)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_SHAMAN_USE_EARTH_SHOCK",
			"CHECKBOX",
			TEXT(ONEHITWONDER_SHAMAN_USE_EARTH_SHOCK),
			TEXT(ONEHITWONDER_SHAMAN_USE_EARTH_SHOCK_INFO),
			OneHitWonder_Shaman_SetUseEarthShock,
			OneHitWonder_Shaman_UseEarthShock
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_SHAMAN_USE_CHEAP_EARTH_SHOCK",
			"CHECKBOX",
			TEXT(ONEHITWONDER_SHAMAN_USE_CHEAP_EARTH_SHOCK),
			TEXT(ONEHITWONDER_SHAMAN_USE_CHEAP_EARTH_SHOCK_INFO),
			OneHitWonder_Shaman_SetUseCheapEarthShock,
			OneHitWonder_Shaman_UseCheapEarthShock
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_SHAMAN_USE_GROUNDING_TOTEM_ES_BACKUP",
			"CHECKBOX",
			TEXT(ONEHITWONDER_SHAMAN_USE_GROUNDING_TOTEM_ES_BACKUP),
			TEXT(ONEHITWONDER_SHAMAN_USE_GROUNDING_TOTEM_ES_BACKUP_INFO),
			OneHitWonder_Shaman_SetUseGroundingTotemEarthShockBackup,
			OneHitWonder_Shaman_UseGroundingTotemEarthShockBackup
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_SHAMAN_KEEP_UP_WEAPON_BUFF",
			"BOTH",
			TEXT(ONEHITWONDER_SHAMAN_KEEP_UP_WEAPON_BUFF),
			TEXT(ONEHITWONDER_SHAMAN_KEEP_UP_WEAPON_BUFF_INFO),
			OneHitWonder_Shaman_SetKeepUpWeaponBuff,
			OneHitWonder_Shaman_ShouldKeepUpWeaponBuff,  -- checked
			OneHitWonder_Shaman_KeepUpWeaponBuff, -- default value
			0, -- min value
			4, -- max value
			ONEHITWONDER_SHAMAN_KEEP_UP_WEAPON_BUFF_SLIDER, -- slider text
			1, 
			1, 
			"", -- slider text append
			1 -- slider multiplier
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_SHAMAN_LIGHTNING_SHIELD",
			"BOTH",
			TEXT(ONEHITWONDER_SHAMAN_LIGHTNING_SHIELD),
			TEXT(ONEHITWONDER_SHAMAN_LIGHTNING_SHIELD_INFO),
			OneHitWonder_Shaman_SetLightningShieldUpdate,
			OneHitWonder_Shaman_KeepUpLightningShield,  -- checked
			OneHitWonder_Shaman_LightningShieldManaRequired, -- default value
			0, -- min value
			100, -- max value
			ONEHITWONDER_SHAMAN_LIGHTNING_SHIELD_SLIDER, -- slider text
			1, 
			1, 
			ONEHITWONDER_SHAMAN_LIGHTNING_SHIELD_APPEND, -- slider text append
			1 -- slider multiplier
		);
	end
end

function OneHitWonder_Shaman(removeDefense)
	local targetName = UnitName("target");

	if ( not removeDefense ) then removeDefense = false; end
	
	if ( OneHitWonder_IsChannelSpellRunning() ) or ( OneHitWonder_IsRegularSpellRunning() ) then
		return;
	end
	
	if ( (not targetName) or ( strlen(targetName) <= 0 ) ) then
		if ( not OneHitWonder_UseCountermeasures() ) then
			if ( not OneHitWonder_Shaman_DoKeepUpWeaponBuff(true) ) then
				if ( not OneHitWonder_DoBuffs() ) then
					if ( OneHitWonder_ShouldOverrideBindings ~= 1 ) then
						OneHitWonder_DoStuffContinuously();
					end
				end
			end
		end
		return;
	end
	
	if ( not UnitCanAttack("player", "target") ) then
		if ( not OneHitWonder_UseCountermeasures() ) then
			if ( not OneHitWonder_Shaman_DoKeepUpWeaponBuff(true) ) then
				OneHitWonder_DoBuffs();
			end
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

	OneHitWonder_MeleeAttack();

	if ( not OneHitWonder_DoBuffs() ) then
		if ( OneHitWonder_CastIfTargetNotHasEffect(ONEHITWONDER_ABILITY_SHOOT, ONEHITWONDER_ABILITY_SHOOT) ) then
			return;
		end
	end
end


function OneHitWonder_UnitHasGainedSpell_Shaman(unitName, spellName)
	if ( not spellName ) then
		return;
	end
	local spellId = -1;
	spellId = DynamicData.spell.getMatchingSpellId(ONEHITWONDER_SPELL_PURGE_NAME, 1);
	if ( not spellId ) or ( spellId <= -1 ) then
		return;
	end
	if ( PlayerFrame.inCombat ~= 1 ) then
		return;
	end
	
	if ( OneHitWonder_IsStringInListLoose(spellName, OneHitWonder_DispelSpells, true) ) then
		local parameters = { spellId, "target" };
		OneHitWonder_AddActionToQueue(ONEHITWONDER_ACTIONID_SPELL_TARGET, parameters);
		return;
	end
end
