OneHitWonder_Rogue_RuptureClassesLevel = {
	[ONEHITWONDER_CLASS_HUNTER] = 40,
	[ONEHITWONDER_CLASS_PALADIN] = 1,
	[ONEHITWONDER_CLASS_SHAMAN] = 40,
	[ONEHITWONDER_CLASS_WARRIOR] = 1
};

OneHitWonder_UseMobHealth = 1;

OneHitWonder_Rogue_WeaponSwitching = 0;

ONEHITWONDER_ABILITY_EXPOSEARMOR_TEXTURE = "Interface\\Icons\\Ability_Warrior_Riposte";
ONEHITWONDER_ABILITY_SLICEDICE_TEXTURE = "Interface\\Icons\\Ability_Rogue_SliceDice";
ONEHITWONDER_ABILITY_STEALTH_TEXTURE = "Interface\\Icons\\Ability_Stealth";

ONEHITWONDER_ABILITY_STEALTH_OPENERS_REQUIRING_DAGGERS = {
	ONEHITWONDER_ABILITY_AMBUSH_NAME,
	ONEHITWONDER_ABILITY_BACKSTAB_NAME,
};

ONEHITWONDER_ABILITY_STEALTH_OPENERS = {
	ONEHITWONDER_ABILITY_GARROTE_NAME, 
	ONEHITWONDER_ABILITY_AMBUSH_NAME,
	ONEHITWONDER_ABILITY_BACKSTAB_NAME,
	ONEHITWONDER_ABILITY_CHEAPSHOT_NAME
};

ONEHITWONDER_ABILITY_FINISHING_MOVES = {
	ONEHITWONDER_ABILITY_EXPOSEARMOR_NAME,
	ONEHITWONDER_ABILITY_EVISCERATE_NAME, 
	ONEHITWONDER_ABILITY_SLICEDICE_NAME, 
	ONEHITWONDER_ABILITY_RUPTURE_NAME,
	ONEHITWONDER_ABILITY_KIDNEYSHOT_NAME
};

ONEHITWONDER_ABILITY_ENERGYCOST = {
	[ONEHITWONDER_ABILITY_AMBUSH_NAME] = 60,
	[ONEHITWONDER_ABILITY_BACKSTAB_NAME] = 60,
	[ONEHITWONDER_ABILITY_EVISCERATE_NAME] = 35,
	[ONEHITWONDER_ABILITY_SLICEDICE_NAME] = 25,
	[ONEHITWONDER_ABILITY_SINISTERSTRIKE_NAME] = 45,
	[ONEHITWONDER_ABILITY_EXPOSEARMOR_NAME] = 25,
	[ONEHITWONDER_ABILITY_GOUGE_NAME] = 45,
	[ONEHITWONDER_ABILITY_KICK_NAME] = 25,
	[ONEHITWONDER_ABILITY_FEINT_NAME] = 20,
	[ONEHITWONDER_ABILITY_RUPTURE_NAME] = 25,
	[ONEHITWONDER_ABILITY_DISTRACT_NAME] = 30,
	[ONEHITWONDER_ABILITY_GARROTE_NAME] = 50,
	[ONEHITWONDER_ABILITY_CHEAPSHOT_NAME] = 60,
	[ONEHITWONDER_ABILITY_KIDNEYSHOT_NAME] = 25,
	[ONEHITWONDER_TALENT_RIPOSTE_NAME] = 10,
	[ONEHITWONDER_ABILITY_PICKPOCKET_NAME] = 0
};

ONEHITWONDER_QUEUE_KICK_CHAT_TYPES_OLD = {
	"SPELL_HOSTILEPLAYER_DAMAGE",
	"SPELL_HOSTILEPLAYER_BUFF",
	"SPELL_CREATURE_VS_SELF_DAMAGE",
	"SPELL_CREATURE_VS_SELF_BUFF",
	"SPELL_CREATURE_VS_CREATURE_BUFF",
};

-- verify this
ONEHITWONDER_QUEUE_RIPOSTE_CHAT_TYPES = {
	"COMBAT_MISC_INFO"
};

function OneHitWonder_GetEnergyConsumption(abilityName)
	return ONEHITWONDER_ABILITY_ENERGYCOST[abilityName];
end


ONEHITWONDER_ROGUE_TALENT_ENERGY_REDUCERS = {
	{ 
		{ 2,2 },
		ONEHITWONDER_ABILITY_SINISTERSTRIKE_NAME,
		{ 42, 40 }
	},
};

function OneHitWonder_TargetIsPickpocketable()
	return OneHitWonder_CanAbilityAffectUnit(ONEHITWONDER_ABILITY_PICKPOCKET_NAME, "target");
end


OneHitWonder_Rogue_ShouldPickPocket = 1;
OneHitWonder_Rogue_ShouldRiposte = 1;
OneHitWonder_Rogue_ShouldIgnoreRiposteCheck = 1; -- for future patch


OneHitWonder_Rogue_Sap_Fail_Action = 0;
OneHitWonder_Rogue_Successful_Sap_ChatLine = "";

OneHitWonder_Rogue_Sap_Fail_Actions = {
	ONEHITWONDER_ABILITY_VANISH_NAME,
	ONEHITWONDER_ABILITY_EVASION_NAME,
	ONEHITWONDER_ABILITY_SPRINT_NAME
};

OneHitWonder_Rogue_StealthOpeningAbilityNumber = 0;
OneHitWonder_Rogue_StealthOpeningBackupAbilityNumber = 0;

OneHitWonder_Rogue_ShouldGarrote = 1;
OneHitWonder_Rogue_ShouldCheapShot = 1;
OneHitWonder_Rogue_ShouldAmbush = 1;
OneHitWonder_Rogue_ShouldBackstab = 1;

OneHitWonder_Rogue_AllowedBackstabAttempts = 3;

OneHitWonder_Rogue_ExposeArmorPercentage = 20;
OneHitWonder_Rogue_ExposeArmorComboPointsMin = 1;
OneHitWonder_Rogue_ExposeArmorComboPointsMax = 2;

OneHitWonder_Rogue_SliceDicePercentageDirection = 1;
OneHitWonder_Rogue_SliceDicePercentage = 60;
OneHitWonder_Rogue_SliceDiceComboPointsMin = 1;
OneHitWonder_Rogue_SliceDiceComboPointsMax = 2;

OneHitWonder_Rogue_UseNewEviscerateCode = 0;

OneHitWonder_Rogue_EviscerateNowPercentage = 1;
OneHitWonder_Rogue_EviscerateExtraComboPointPercentage = 60;
OneHitWonder_Rogue_EviscerateTwiceExtraComboPointPercentage = 80;
OneHitWonder_Rogue_EviscerateBaseComboPoints = 2;

OneHitWonder_Rogue_UseSmartRupture = 0;
OneHitWonder_Rogue_UseSmartRuptureComboPoints = 1;

OneHitWonder_Rogue_UseSmartExposeArmor = 0;

OneHitWonder_Rogue_UseSmartSliceDice = 1;

OneHitWonder_Rogue_ReactiveCastKick = 1;
OneHitWonder_Rogue_ReactiveCastGouge = 0;
OneHitWonder_Rogue_ReactiveCastKidneyShot = 0;
OneHitWonder_Rogue_ReactiveCastKidneyShotMaximumCP = 5;

OneHitWonder_Rogue_UseColdBlood = 0;
OneHitWonder_Rogue_ColdBloodComboPointsMin = 5;
OneHitWonder_Rogue_ColdBloodOnlyInPvP = 0;

OneHitWonder_Rogue_UseGhostlyStrike = 1;
OneHitWonder_Rogue_GhostlyStrikeHealth = 0;
OneHitWonder_Rogue_GhostlyStrikeHealthPercentage = 80;
OneHitWonder_Rogue_UseHemorrhage = 1;

OneHitWonder_Rogue_PreventRunning = 1;

OneHitWonder_Rogue_PlayerClassesToExpose = {
	ONEHITWONDER_CLASS_DRUID,
	ONEHITWONDER_CLASS_HUNTER,
	ONEHITWONDER_CLASS_PALADIN,
	ONEHITWONDER_CLASS_SHAMAN
};

OneHitWonder_Options_Rogue = {
	"OneHitWonder_Rogue_ShouldPickPocket",
	"OneHitWonder_Rogue_ShouldRiposte",
	"OneHitWonder_Rogue_Sap_Fail_Action",
	"OneHitWonder_Rogue_Successful_Sap_ChatLine",
	"OneHitWonder_Rogue_StealthOpeningAbilityNumber",
	"OneHitWonder_Rogue_StealthOpeningBackupAbilityNumber",
	"OneHitWonder_Rogue_ShouldGarrote",
	"OneHitWonder_Rogue_ShouldCheapShot",
	"OneHitWonder_Rogue_ShouldAmbush",
	"OneHitWonder_Rogue_ShouldBackstab",
	"OneHitWonder_Rogue_AllowedBackstabAttempts",
	"OneHitWonder_Rogue_ExposeArmorPercentage",
	"OneHitWonder_Rogue_ExposeArmorComboPointsMin",
	"OneHitWonder_Rogue_ExposeArmorComboPointsMax",
	"OneHitWonder_Rogue_SliceDicePercentageDirection",
	"OneHitWonder_Rogue_SliceDicePercentage",
	"OneHitWonder_Rogue_SliceDiceComboPointsMin",
	"OneHitWonder_Rogue_SliceDiceComboPointsMax",
	"OneHitWonder_Rogue_UseNewEviscerateCode",
	"OneHitWonder_Rogue_EviscerateNowPercentage",
	"OneHitWonder_Rogue_EviscerateExtraComboPointPercentage",
	"OneHitWonder_Rogue_EviscerateTwiceExtraComboPointPercentage",
	"OneHitWonder_Rogue_EviscerateBaseComboPoints",
	"OneHitWonder_Rogue_UseSmartRupture",
	"OneHitWonder_Rogue_UseSmartRuptureComboPoints",
	"OneHitWonder_Rogue_UseSmartExposeArmor",
	"OneHitWonder_Rogue_UseSmartSliceDice",
	"OneHitWonder_Rogue_ReactiveCastKick",
	"OneHitWonder_Rogue_ReactiveCastGouge",
	"OneHitWonder_Rogue_ReactiveCastKidneyShot",
	"OneHitWonder_Rogue_ReactiveCastKidneyShotMaximumCP",
	"OneHitWonder_Rogue_UseColdBlood",
	"OneHitWonder_Rogue_ColdBloodComboPointsMin",
	"OneHitWonder_Rogue_ColdBloodOnlyInPvP",
	"OneHitWonder_Rogue_UseGhostlyStrike",
	"OneHitWonder_Rogue_GhostlyStrikeHealth",
	"OneHitWonder_Rogue_GhostlyStrikeHealthPercentage",
	"OneHitWonder_Rogue_UseHemorrhage",
	"OneHitWonder_UseMobHealth",
	"OneHitWonder_Rogue_PreventRunning",
};


function OneHitWonder_Rogue_SetUseHemorrhage(toggle)
	OneHitWonder_Rogue_UseHemorrhage = toggle;
end

function OneHitWonder_Rogue_ShouldExposeArmor(removeDefense)
	if ( not removeDefense ) then
		if ( OneHitWonder_Rogue_UseSmartExposeArmor == 1 ) then
			local isPlayer = UnitIsPlayer("target");
			if ( not isPlayer ) then
				local classification = UnitClassification("target");
				if ( classification ) and ( classification == "worldboss" or
					  classification == "rareelite" or
					  classification == "elite") then
					return true;
				end
			end

			if ( UnitPowerType("target") == ONEHITWONDER_POWERTYPE_MANA ) then
				local class = UnitClass("target");
				for k, v in OneHitWonder_Rogue_PlayerClassesToExpose do
					if ( v == class ) then
						return true;
					end
				end
				return false;
			else
				return true;
			end
		else
			return false;
		end
	else
		return true;
	end
end

function OneHitWonder_Rogue_ShouldSliceDice()
	if ( OneHitWonder_Rogue_UseSmartSliceDice == 1 ) then
		return true;
	else
		if ( OneHitWonder_InBossMode() ) 
			and ( OneHitWonder_HasUnitEffect("target", nil, OneHitWonder_ExposeArmorEffects ) ) then
			return true;
		end
		return false;
	end
end

function OneHitWonder_Rogue_ShouldGiveupBackstab()
	if ( ( OneHitWonder_Rogue_AllowedBackstabAttempts == 0 ) or 
		( OneHitWonder_Rogue_AllowedBackstabAttempts >= TargetFrame.attemptsToBackstab ) ) then
		return false;
	else
		return true;
	end
end



function OneHitWonder_Rogue_GetStealthOpeningAbilityIdFromSlider(index)
	if ( index > 0 ) then
		local name = OneHitWonder_Rogue_StealthOpeningAbilities[index];
		if ( name ) then
			return OneHitWonder_GetSpellId(name);
		else
			return -1;
		end
	else
		return -1;
	end
end

function OneHitWonder_Rogue_GetGarroteFixedId(spellId)
	if ( spellId == OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_GARROTE_NAME) ) then
		if ( OneHitWonder_HasTargetMyAbility(ONEHITWONDER_ABILITY_GARROTE_NAME, 
			ONEHITWONDER_ABILITY_GARROTE_EFFECT ) ) 
			or ( not OneHitWonder_CanAbilityAffectUnit(ONEHITWONDER_ABILITY_GARROTE_NAME, "target") ) then
			spellId = -1;
		end
	end
	return spellId;
end

function OneHitWonder_Rogue_GetStealthOpeningAbilityId(ignoreTarget)
	local spellId = OneHitWonder_Rogue_GetStealthOpeningAbilityIdFromSlider(OneHitWonder_Rogue_StealthOpeningAbilityNumber);
	if ( not ignoreTarget ) then
		if ( OneHitWonder_UnitIsBossOrBetter("target") ) then
			if ( not OneHitWonder_HasTargetMyAbility(ONEHITWONDER_ABILITY_GARROTE_NAME, 
				ONEHITWONDER_ABILITY_GARROTE_EFFECT ) ) then
				if ( spellId == OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_CHEAP_SHOT_NAME) ) then
					spellId = OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_GARROTE_NAME);
				end
			end
		end
		spellId = OneHitWonder_Rogue_GetGarroteFixedId(spellId);
	end
	if ( spellId > -1 ) and ( not OneHitWonder_Rogue_HasDagger() ) then
		for k, v in ONEHITWONDER_ABILITY_STEALTH_OPENERS_REQUIRING_DAGGERS do
			if ( OneHitWonder_GetSpellId(v) == spellId ) then
				spellId = -1;
				break;
			end
		end
	end
	if ( spellId <= -1 ) or ( not OneHitWonder_CheckIfUsableSpellId(spellId) ) then
		spellId = OneHitWonder_Rogue_GetStealthOpeningAbilityIdFromSlider(OneHitWonder_Rogue_StealthOpeningBackupAbilityNumber);
		if ( not ignoreTarget ) then
			spellId = OneHitWonder_Rogue_GetGarroteFixedId(spellId);
		end
	end
	if ( ( spellId <= -1 ) and ( OneHitWonder_Rogue_ShouldGarrote == 1 ) ) then
		spellId = OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_GARROTE_NAME);
		if ( not ignoreTarget ) then
			spellId = OneHitWonder_Rogue_GetGarroteFixedId(spellId);
		end
	end
	if ( ( spellId <= -1 ) and ( OneHitWonder_Rogue_ShouldCheapShot == 1 ) ) then
		spellId = OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_CHEAPSHOT_NAME);
	end
	if ( spellId <= -1 ) and ( OneHitWonder_Rogue_ShouldAmbush == 1 ) and ( OneHitWonder_Rogue_HasDagger() ) then
		spellId = OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_AMBUSH_NAME);
	end
	if ( spellId <= -1 ) and ( OneHitWonder_Rogue_ShouldBackstab == 1 ) and ( OneHitWonder_Rogue_HasDagger() ) then
		spellId = OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_BACKSTAB_NAME);
	end
	if ( spellId > -1 ) and ( not OneHitWonder_Rogue_HasDagger() ) then
		for k, v in ONEHITWONDER_ABILITY_STEALTH_OPENERS_REQUIRING_DAGGERS do
			if ( OneHitWonder_GetSpellId(v) == spellId ) then
				spellId = -1;
				break;
			end
		end
	end
	if ( spellId <= -1 ) or ( not OneHitWonder_CheckIfUsableSpellId(spellId) ) then
		local index = table.getn(OneHitWonder_Rogue_StealthOpeningAbilities);
		local abilityName = nil;
		for index = table.getn(OneHitWonder_Rogue_StealthOpeningAbilities), 1, -1 do
			abilityName = OneHitWonder_Rogue_StealthOpeningAbilities[index];
			if ( not OneHitWonder_IsStringInList(abilityName, ONEHITWONDER_ABILITY_STEALTH_OPENERS_REQUIRING_DAGGERS) ) 
				or ( OneHitWonder_Rogue_HasDagger() ) then
				spellId = OneHitWonder_GetSpellId(abilityName);
				if ( not ignoreTarget ) then
					spellId = OneHitWonder_Rogue_GetGarroteFixedId(spellId);
				end
				if ( spellId > -1 ) and 
					( OneHitWonder_CheckIfUsableSpellId(spellId) ) 
					and ( OneHitWonder_CanAbilityAffectUnit(abilityName, "target") ) then
					break;
				end
			end
		end
	end
	
	if ( OneHitWonder_Rogue_WeaponSwitching == 1 ) then
		for k, v in OneHitWonder_Rogue_DaggerRequiringSkills do
			if ( OneHitWonder_GetSpellId(v) == spellId ) then
				OneHitWonder_Rogue_EquipDagger();
				break;
			end
		end
	end
	
	
	return spellId;
end

function OneHitWonder_Rogue_ShouldPickPocketTarget()
	if ( OneHitWonder_TargetIsPickpocketable() ) and 
		( OneHitWonder_Rogue_ShouldPickPocket == 1 ) and 
		( not TargetFrame.hasBeenPickPocketed ) and 
		( PlayerFrame.inCombat ~= 1 ) then
		return true;
	else
		return false;
	end
end


function OneHitWonder_Rogue_GetExposeArmorComboPoints()
	local cpMin = OneHitWonder_Rogue_ExposeArmorComboPointsMin;
	local cpMax = OneHitWonder_Rogue_ExposeArmorComboPointsMax;
	if ( OneHitWonder_InBossMode() ) then
		cpMin = MAX_COMBO_POINTS;
		cpMax = MAX_COMBO_POINTS;
	end
	return cpMin, cpMax;
end
		
function OneHitWonder_Rogue_GetRuptureComboPoints()
	local cpMin = 1;
	local cpMax = MAX_COMBO_POINTS;
	if ( OneHitWonder_InBossMode() ) then
		cpMin = MAX_COMBO_POINTS;
		cpMax = MAX_COMBO_POINTS;
	else
		cpMin = OneHitWonder_Rogue_GetComboPointsNeededToRupture();
	end
	return cpMin, cpMax;
end
		
function OneHitWonder_Rogue_GetEviscerateComboPoints()
	local cpMin = 1;
	local cpMax = MAX_COMBO_POINTS;
	if ( OneHitWonder_InBossMode() ) then
		cpMin = MAX_COMBO_POINTS;
		cpMax = MAX_COMBO_POINTS;
	else
		cpMin = OneHitWonder_GetComboPointsNeededToEviscerate();
	end
	return cpMin, cpMax;
end
		
function OneHitWonder_Rogue_GetColdBloodComboPoints()
	local cpMin = -1;
	local cpMax = MAX_COMBO_POINTS;
	if ( OneHitWonder_Rogue_UseColdBlood == 1 ) then
		if ( OneHitWonder_Rogue_ColdBloodOnlyInPvP == 0 ) or ( ( OneHitWonder_Rogue_ColdBloodOnlyInPvP == 1 ) and ( UnitIsPVP("player") ) ) then
			cpMin = OneHitWonder_Rogue_ColdBloodComboPointsMin;
		end
		if ( OneHitWonder_InBossMode() ) then
			cpMin = MAX_COMBO_POINTS;
		end
	end
	return cpMin, cpMax;
end

function OneHitWonder_Rogue_GetSliceAndDiceComboPoints()
	local cpMin = -1;
	local cpMax = MAX_COMBO_POINTS;
	local unitHPPercent = OneHitWonder_GetTargetHPPercentage();
	if ( OneHitWonder_InBossMode() ) and ( unitHPPercent > 2 ) then
		cpMin = MAX_COMBO_POINTS;
	else
		if ( ( ( OneHitWonder_Rogue_SliceDicePercentageDirection == 1 ) and 
			( unitHPPercent >= OneHitWonder_Rogue_SliceDicePercentage ) ) or
			( 
			( OneHitWonder_Rogue_SliceDicePercentageDirection == 0 ) and 
			( unitHPPercent <= OneHitWonder_Rogue_SliceDicePercentage ) ) ) then
			cpMin = OneHitWonder_Rogue_SliceDiceComboPointsMin;
			cpMax = OneHitWonder_Rogue_SliceDiceComboPointsMax;
		end
	end
	return cpMin, cpMax;
end

function OneHitWonder_Rogue_DoRiposte()
	if ( not OneHitWonder_TargetAliveEnemy() ) then
		return false;
	end
	local n = ONEHITWONDER_TALENT_RIPOSTE_NAME;
	if ( OneHitWonder_Rogue_ShouldRiposte == 1 ) then
		if ( OneHitWonder_Rogue_ShouldIgnoreRiposteCheck == 1 ) 
			or ( ( OneHitWonder_CanAbilityAffectUnit(n, "target") ) 
				and ( not OneHitWonder_HasUnitEffect("target", nil, ONEHITWONDER_TALENT_RIPOSTE_EFFECT) ) 
				) then
			local id = OneHitWonder_GetSpellId(n);
			if ( OneHitWonder_IsSpellAvailable(id) ) then
				return OneHitWonder_CastSpell(id);
			end
		end
	end
	return false;
end

function OneHitWonder_TargetIsRunningAway_Rogue()
	if ( not OneHitWonder_HasUnitEffect("target", nil, ONEHITWONDER_SLOW_EFFECTS) ) then
		if ( OneHitWonder_Rogue_PreventRunning == 1 ) then
			local spellId = OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_KIDNEYSHOT_NAME);
			if ( spellId > -1 ) then
				local parameters = { spellId, GetTime() + 3};
				OneHitWonder_AddActionToQueue(ONEHITWONDER_ACTIONID_SPELL_TIMEOUT, parameters);
			end
		end
	end
end


function OneHitWonder_Rogue(removeDefense)
	local targetName = UnitName("target");

	if ( not removeDefense ) then removeDefense = false; end
	
	if ( OneHitWonder_IsChannelSpellRunning() ) or ( OneHitWonder_IsRegularSpellRunning() ) then
		return;
	end
	
	if ( OneHitWonder_HandleActionQueue() ) then
		return;
	end
	
	if ( ( (not targetName) or ( strlen(targetName) <= 0 ) ) or ( not UnitCanAttack("player", "target") ) ) or ( UnitIsDead("target") ) then
		if ( not OneHitWonder_DoBuffs() ) then
			if ( OneHitWonder_ShouldOverrideBindings ~= 1 ) then
				OneHitWonder_DoStuffContinuously();
			end
		end
		return;
	end
	
	if (not OneHitWonder_StartCombat()) then
		return false
	end

	if ( OneHitWonder_HasPlayerEffect(nil, ONEHITWONDER_ABILITY_STEALTH_EFFECTS) )  then
		local spellId = 0;
		local pickPockId = OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_PICKPOCKET_NAME);

		actionId = 0;
		if ( pickPockId > -1 ) and (OneHitWonder_Rogue_ShouldPickPocketTarget() ) then
			spellId = pickPockId;
			actionId = OneHitWonder_GetActionIdFromSpellId(spellId);
			
			if ( OneHitWonder_CheckIfInRangeAndUsableInActionBarByActionId(actionId) ) then
				if ( OneHitWonder_CastSpellOnTarget(spellId, ONEHITWONDER_BOOK_TYPE_SPELL ) ) then
					OneHitWonder_Rogue_LastCreatureAttemptedPickpocket = UnitName("target");
							-- should be replaced for check for "No pockets to pick" and "You loot XYZ Copper" at a latter stage
					OneHitWonder_NextGiveMeWonder = GetTime() + 0.5;
					TargetFrame.hasBeenPickPocketed = true;
				end
			end
			return;
		else
			spellId = OneHitWonder_Rogue_GetStealthOpeningAbilityId();
			actionId = OneHitWonder_GetActionIdFromSpellId(spellId);
			if ( actionId ) and ( actionId > -1 ) then
				if ( OneHitWonder_CheckIfInRangeActionId(actionId) ) then
					TargetFrame.attemptsToBackstab = TargetFrame.attemptsToBackstab + 1;
				end
			else
				TargetFrame.attemptsToBackstab = TargetFrame.attemptsToBackstab + 1;
			end
		end
		if ( OneHitWonder_Rogue_ShouldGiveupBackstab() ) then
			OneHitWonder_Rogue_IncreaseComboPoints();
			return;
		end
		if ( spellId > 0 ) then
			if ( actionId > -1 ) and ( not OneHitWonder_CheckIfUsableActionId(actionId) ) then
				if ( not OneHitWonder_CheckIfSpellIsCoolingdownById(spellId) ) then
					-- we don't have a Dagger in our hand
					OneHitWonder_Rogue_IncreaseComboPoints();
					return;
				end
			end
		else
			OneHitWonder_Rogue_IncreaseComboPoints();
			return;
		end
		if ( OneHitWonder_CastSpell(spellId, ONEHITWONDER_BOOK_TYPE_SPELL) ) then
			local garroteId = OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_GARROTE_NAME);
			if ( garroteId == spellId ) then
				OneHitWonder_ApplyMyAbilityToTarget(ONEHITWONDER_ABILITY_GARROTE_NAME, OneHitWonder_Rogue_GetGarroteDuration());
			end
		end
		return;
	else
		TargetFrame.attemptsToBackstab = 0;
		-- OneHitWonder_MeleeAttack();   -- ETG
	end

	if ( OneHitWonder_Rogue_DoRiposte() ) then
		return true;
	end

	local comboPoints = GetComboPoints();
	
	local unitHPPercent = OneHitWonder_GetTargetHPPercentage();

	local comboPointsNeeded = OneHitWonder_GetComboPointsNeededToEviscerate();
	
	if ( OneHitWonder_Rogue_ShouldSliceDice() ) then
		local cpMin, cpMax = OneHitWonder_Rogue_GetSliceAndDiceComboPoints();
		if ( cpMin > -1 ) and ( comboPoints >= cpMin ) and ( comboPoints <= cpMax ) then
			local effectInfo = OneHitWonder_GetUnitEffect("player", nil, ONEHITWONDER_ABILITY_SLICEDICE_EFFECT);
			local shouldApplyEffect = true;
			if ( effectInfo ) and ( effectInfo.name ) and ( effectInfo.name == ONEHITWONDER_ABILITY_SLICEDICE_EFFECT ) then
				shouldApplyEffect = false;
				if ( effectInfo.expires ) and ( effectInfo.expires > DYNAMICDATA_EFFECT_EXPIRES_NEVER ) then
					if ( effectInfo.expires <= 2 ) then
						shouldApplyEffect = false;
					end
				end
			end
			if ( shouldApplyEffect ) then
				if ( OneHitWonder_CastSpell(OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_SLICEDICE_NAME), ONEHITWONDER_BOOK_TYPE_SPELL) ) then
					return;
				end
			end
		end
	end
	
	local shouldExpose = false;
	if ( unitHPPercent >= OneHitWonder_Rogue_ExposeArmorPercentage ) 
		or ( OneHitWonder_InBossMode() ) then
		local exposeEnabled = removeDefense;
		if ( not exposeEnabled ) and ( OneHitWonder_InBossMode() ) then
			exposeEnabled = true;
		end
		if ( OneHitWonder_Rogue_ShouldExposeArmor(exposeEnabled) )
			and ( not OneHitWonder_HasUnitEffect("target", nil, OneHitWonder_ExposeArmorEffects) ) then
			shouldExpose = true;
		end
	end
   	-- ETG Check if warriors in party
    if ( OneHitWonder_IsInPartyOrRaid() ) then 
 --       local warriors = OneHitWonder_GetNumberOfClassInGroup(ONEHITWONDER_CLASS_WARRIOR); 
--	    if ( warriors > 0 ) 
	    shouldExpose = false;
--		end
	end

	if ( shouldExpose ) then
		local tmp = ONEHITWONDER_ABILITY_EXPOSEARMOR_NAME;
		local tmpId = OneHitWonder_GetSpellId(tmp);
		
		local cpMin, cpMax = OneHitWonder_Rogue_GetExposeArmorComboPoints();
		--local cpMin = OneHitWonder_Rogue_ExposeArmorComboPointsMin;
		--local cpMax = OneHitWonder_Rogue_ExposeArmorComboPointsMax;

		if ( tmpId > -1 ) then
			--comboPointsNeeded = OneHitWonder_GetComboPointsNeededToExposeArmor();
			--if ( comboPoints >= comboPointsNeeded ) then
			if ( ( comboPoints >= cpMin ) and ( comboPoints <= cpMax ) ) then
				if ( OneHitWonder_CastSpellOnTarget(tmpId, ONEHITWONDER_BOOK_TYPE_SPELL) ) then
					return;
				end
			end
			OneHitWonder_Rogue_IncreaseComboPoints();
			return;
		end
	end
	
	local abilityName = ONEHITWONDER_ABILITY_EVISCERATE_NAME;
	local isColdBloodable = true;
	
	if ( ( OneHitWonder_Rogue_UseSmartRupture == 1 ) or ( getglobal("ONEHITWONDER_DOT") ) or ( OneHitWonder_InBossMode() ) )
		and ( OneHitWonder_Rogue_ShouldUseRuptureOnUnit("target") ) 
		and ( ( comboPointsNeeded >= MAX_COMBO_POINTS) or ( comboPointsNeeded > comboPoints + 1) ) then
		local rupturePoints = OneHitWonder_Rogue_GetRuptureComboPoints();
		if ( rupturePoints > -1 ) and ( comboPoints < comboPointsNeeded ) then
			comboPointsNeeded = rupturePoints;
			isColdBloodable = false;
			abilityName = ONEHITWONDER_ABILITY_RUPTURE_NAME;
		end
	end
	local abilityId = OneHitWonder_GetSpellId(abilityName);
	local coldBloodActive = OneHitWonder_HasPlayerEffect(nil, ONEHITWONDER_TALENT_COLD_BLOOD_EFFECT);
	
	if ( comboPoints >= comboPointsNeeded ) and ( comboPoints > 0 ) then
		local cbCPMin = OneHitWonder_Rogue_GetColdBloodComboPoints();
		if ( not coldBloodActive ) and ( isColdBloodable ) and ( cbCPMin > -1 ) and ( comboPoints >= cbCPMin ) then
			local spellId = OneHitWonder_GetSpellId(ONEHITWONDER_TALENT_COLD_BLOOD_NAME, ONEHITWONDER_BOOK_TYPE_SPELL);
			if ( spellId > -1 ) then
				if ( OneHitWonder_CastSpell(spellId, ONEHITWONDER_BOOK_TYPE_SPELL) ) then
					return;
				end
			end
		end
		if ( OneHitWonder_CastSpellOnTarget(abilityId, ONEHITWONDER_BOOK_TYPE_SPELL) ) then
			if ( abilityName == ONEHITWONDER_ABILITY_RUPTURE_NAME ) then
				OneHitWonder_ApplyMyAbilityToTarget(ONEHITWONDER_ABILITY_RUPTURE_NAME, OneHitWonder_Rogue_GetRuptureDuration(comboPoints));
			end
			return;
		end
	elseif ( coldBloodActive ) and ( comboPoints > 0 ) then
		local ok = OneHitWonder_CastSpellOnTarget(abilityId, ONEHITWONDER_BOOK_TYPE_SPELL);
		if ( ok ) then
			if ( abilityName == ONEHITWONDER_ABILITY_RUPTURE_NAME ) then
				OneHitWonder_ApplyMyAbilityToTarget(ONEHITWONDER_ABILITY_RUPTURE_NAME, OneHitWonder_Rogue_GetRuptureDuration(comboPoints));
			end
		end
		return ok;
	end
	OneHitWonder_Rogue_IncreaseComboPoints();
end

function OneHitWonder_Rogue_IncreaseComboPoints()
	local increaseOK = OneHitWonder_Rogue_DoIncreaseComboPoints();
	if ( increaseOK ) then
		OneHitWonder_Attacking = true;
	end
	return increaseOK;
end

function OneHitWonder_Rogue_DoIncreaseComboPointsBackstab()
	local backStabId = OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_BACKSTAB_NAME);
	if ( backStabId > -1 ) then
		if ( OneHitWonder_Rogue_WeaponSwitching == 1 ) then
			OneHitWonder_Rogue_EquipDagger();
		end
		if ( OneHitWonder_IsSpellAvailable(backStabId, ONEHITWONDER_BOOK_TYPE_SPELL) ) then
			return OneHitWonder_CastSpellOnTarget(backStabId, ONEHITWONDER_BOOK_TYPE_SPELL);
		end
	end
	return false;
end

function OneHitWonder_Rogue_DoHemorrhage()
	-- TODO: make it detect 5 times applied Hemorrhage and return false.
	local hemorrhageId = OneHitWonder_GetSpellId(ONEHITWONDER_TALENT_HEMORRHAGE_NAME);
	if ( hemorrhageId > -1 ) then
		if ( OneHitWonder_IsSpellAvailable(hemorrhageId, ONEHITWONDER_BOOK_TYPE_SPELL) ) then
			return OneHitWonder_CastSpellOnTarget(hemorrhageId, ONEHITWONDER_BOOK_TYPE_SPELL);
		end
	end
	return false;
end

function OneHitWonder_Rogue_DoIncreaseComboPoints()
	local currentEnergy = UnitMana("player");
	local shouldGhostly = false;
	if ( OneHitWonder_Rogue_UseHemorrhage == 1 ) then
		if ( OneHitWonder_Rogue_DoHemorrhage() ) then
			return true;
		end
	end
	if ( OneHitWonder_Rogue_UseGhostlyStrike == 1 ) then
		local playerHP = OneHitWonder_GetPlayerHPPercentage();
		if ( OneHitWonder_Rogue_GhostlyStrikeHealth == 1 ) then
			if ( playerHP >= OneHitWonder_Rogue_GhostlyStrikeHealthPercentage ) then
				shouldGhostly = true;
			end
		else
			if ( playerHP <= OneHitWonder_Rogue_GhostlyStrikeHealthPercentage ) then
				shouldGhostly = true;
			end
		end
		local effectInfo = OneHitWonder_GetUnitEffect("player", nil, ONEHITWONDER_TALENT_GHOSTLY_STRIKE_EFFECT);
		if ( effectInfo ) and ( effectInfo.expires > DYNAMICDATA_EFFECT_EXPIRES_NEVER ) then
			if ( effectInfo.expires - GetTime() > 2 ) then
				shouldGhostly = false;
			end
		end
	end
	if ( shouldGhostly ) then
		local ghostlyStrikeId = OneHitWonder_GetSpellId(ONEHITWONDER_TALENT_GHOSTLY_STRIKE_NAME);
		if ( ghostlyStrikeId > -1 ) then
			local cooldown = OneHitWonder_GetSpellCooldown(ghostlyStrikeId);
			if ( cooldown > 0 ) then
				if ( cooldown <= 4 ) then
					return false;
				else
					if ( currentEnergy <= 10+OneHitWonder_GetEnergyConsumption(ONEHITWONDER_ABILITY_SINISTERSTRIKE_NAME) ) then
						return false;
					end
				end
			else
				if ( currentEnergy >= 50 ) and ( OneHitWonder_IsSpellAvailable(ghostlyStrikeId) ) then
					return OneHitWonder_CastSpellOnTarget(ghostlyStrikeId);
				else
					return false;
				end
			end
		end
	end
	local sinisterStrikeId = OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_SINISTERSTRIKE_NAME);
	if ( OneHitWonder_IsSpellAvailable(sinisterStrikeId, ONEHITWONDER_BOOK_TYPE_SPELL) ) then
		if ( OneHitWonder_Rogue_WeaponSwitching == 1 ) then
			OneHitWonder_Rogue_EquipNonDagger();
		end
		return OneHitWonder_CastSpell(sinisterStrikeId, ONEHITWONDER_BOOK_TYPE_SPELL);
	else
		return false;
	end
end

function OneHitWonder_GetComboPointsNeededToExposeArmor()
	local combo = OneHitWonder_GetComboPointsNeededToEviscerate();
	if ( combo < 5 ) then
		combo = combo + 1;
	end
	return combo;
end

-- returns -1 if no Rupture should be used
function OneHitWonder_Rogue_GetComboPointsNeededToRupture(avoidHealth)
	local currentHealth = UnitHealth("target") / UnitHealthMax("target");
	local minHealth = 0.15;
	--[[
	if ( not avoidHealth ) and ( OneHitWonder_UseMobHealth == 1 )  then
		if ( currentHealth > minHealth ) then
			local needed = OneHitWonder_GetComboPointsNeededToEviscerateMobHealth();
			if ( needed > -1 ) then
				return needed;
			end
		end
	end
	]]--
	if ( minHealth > currentHealth ) then
		return -1;
	end
	local comboPoints = MAX_COMBO_POINTS-(currentHealth*MAX_COMBO_POINTS) + 1;
	if ( comboPoints > MAX_COMBO_POINTS ) then
		comboPoints = MAX_COMBO_POINTS;
	end
	if ( comboPoints > OneHitWonder_Rogue_UseSmartRuptureComboPoints ) then
		comboPoints = OneHitWonder_Rogue_UseSmartRuptureComboPoints;
	end
	return comboPoints;
end

function OneHitWonder_GetComboPointsNeededToEviscerate(avoidHealth)
	local needed = OneHitWonder_DoGetComboPointsNeededToEviscerate(avoidHealth);
	if ( needed > MAX_COMBO_POINTS ) then
		needed = MAX_COMBO_POINTS;
	end
	if ( needed == 1 ) then
		needed = 2;
	end
	return needed;
end

function OneHitWonder_DoGetComboPointsNeededToEviscerate(avoidHealth)
	if ( not avoidHealth ) and ( OneHitWonder_UseMobHealth == 1 )  then
		--if ( UnitHealth("target") / UnitHealthMax("target") > 0.15 ) then
			local needed = OneHitWonder_GetComboPointsNeededToEviscerateMobHealth();
			if ( needed > -1 ) then
				return needed;
			end
		--end
	end
	if ( OneHitWonder_Rogue_UseNewEviscerateCode ~= 1 ) then
		return OneHitWonder_GetComboPointsNeededToEviscerateOld();
	end
	local unitHPPercent = OneHitWonder_GetTargetHPPercentage();
	local comboPoints = 0;
	if ( unitHPPercent <= OneHitWonder_Rogue_EviscerateNowPercentage ) then
		comboPoints = 1;
	elseif ( unitHPPercent >= OneHitWonder_Rogue_EviscerateExtraComboPointPercentage ) then
		comboPoints = OneHitWonder_Rogue_EviscerateBaseComboPoints+1;
	elseif ( unitHPPercent >= OneHitWonder_Rogue_EviscerateTwiceExtraComboPointPercentage ) then
		comboPoints = OneHitWonder_Rogue_EviscerateBaseComboPoints+1;
	end
	return comboPoints;
end

function OneHitWonder_GetUnitHealth(unit)
	if ( not UnitIsPlayer(unit) ) and ( unit ~= "pet" ) then 
		if ( MobHealthDB ) then
			local name = UnitName(unit);
			local level = UnitLevel(unit);
			local index = name..":"..level;
			local data = MobHealthDB[index];
			if ( data ) then
				local health = UnitHealth(unit);
				if ( type(data) == "table" ) then
					if ( data.damPts) and ( data.damPct ) then
						local coeff = data.damPts/data.damPct;
						return (coeff*health), coeff*100;
					end
				else
					local s, e, pts, pct = string.find(data, "^(%d+)/(%d+)$");
					if( pts and pct ) then
						pts = pts + 0;
						pct = pct + 0;
						if( pct ~= 0 ) then
							local coeff = pts/pct;
							return ( coeff * health), coeff*100;
						end
					end
				end
			end
			return -1;
		else
			return -1;
		end
	else
		if ( unit == "player") or ( strfind(unit, "party") ) or ( unit == "pet" ) then
			return UnitHealth(unit), UnitHealthMax(unit);
		else
			return -1, -1;
		end
	end
end

ONEHITWONDER_ROGUE_EVISCERATE_POINT			= "%d point";
ONEHITWONDER_ROGUE_EVISCERATE_POINT_SEP		= ": ";
ONEHITWONDER_ROGUE_EVISCERATE_LINE_END		= " damage";
ONEHITWONDER_ROGUE_EVISCERATE_DAMAGE_SEP	= "-";

function OneHitWonder_GetEviscerateDataFromTooltip(strings)
	local list = {};
	if ( strings[5] ) and ( strings[5].left ) then
		local index = 1;
		local strIndex = 0;
		local strOldIndex = 0;
		local str = strings[5].left;
		local tmpStr = nil;
		local ok = false;
		while ( index <= 5 ) do
			ok = false;
			tmpStr = format(ONEHITWONDER_ROGUE_EVISCERATE_POINT, index);
			strIndex = strfind(str, tmpStr);
			if ( strIndex ) then
				strIndex = strIndex+strlen(tmpStr);
				strOldIndex = strIndex;
				strIndex = strfind(str, ONEHITWONDER_ROGUE_EVISCERATE_LINE_END, strOldIndex);
				if ( strIndex ) then
					tmpStr = strsub(str, strOldIndex, strIndex);
					strIndex = strfind(tmpStr, ONEHITWONDER_ROGUE_EVISCERATE_POINT_SEP);
					if ( strIndex ) then
						tmpStr = strsub(tmpStr, strIndex+strlen(ONEHITWONDER_ROGUE_EVISCERATE_POINT_SEP));
					end
					strIndex = strfind(tmpStr, ONEHITWONDER_ROGUE_EVISCERATE_DAMAGE_SEP);
					if ( strIndex ) then
						local minDamage = tonumber(strsub(tmpStr, 1, strIndex-1));
						local maxDamage = tonumber(strsub(tmpStr, strIndex+1));
						if ( minDamage ) and ( maxDamage ) then
							local element = {};
							element.minDamage = minDamage;
							element.maxDamage = maxDamage;
							list[index] = element;
							ok = true;
						end
					end
				end
			end
			if ( not ok ) then
				break;
			end
			index = index + 1;
		end
	end
	return list;
end

function OneHitWonder_GetMaximumEviscerateDamage(eviscerateDamageData)
	local data = eviscerateDamageData[5];
	if ( data ) then
		return data.maxDamage;
	else
		return -1;
	end
end

function OneHitWonder_GetPlayerDPS()
	local speed, offhandSpeed = UnitAttackSpeed("player");
	local minDamage;
	local maxDamage; 
	local minOffHandDamage;
	local maxOffHandDamage; 
	local physicalBonusPos;
	local physicalBonusNeg;
	local percent;
	minDamage, maxDamage, minOffHandDamage, maxOffHandDamage, physicalBonusPos, physicalBonusNeg, percent = UnitDamage("player");
	local baseDamage = (minDamage + maxDamage) * 0.5;
	local fullDamage = (baseDamage + physicalBonusPos + physicalBonusNeg) * percent;
	local damagePerSecond = (max(fullDamage,1) / speed);
	if ( offhandSpeed ) then
		minOffHandDamage = minOffHandDamage;
		maxOffHandDamage = maxOffHandDamage;
		local offhandBaseDamage = (minOffHandDamage + maxOffHandDamage) * 0.5;
		local offhandFullDamage = (offhandBaseDamage + physicalBonusPos + physicalBonusNeg) * percent;
		local offhandDamagePerSecond = (max(offhandFullDamage,1) / offhandSpeed);
		damagePerSecond = ( damagePerSecond + offhandDamagePerSecond ) * 0.75;
	end
	return damagePerSecond;
end

function OneHitWonder_GetComboPointsNeededToEviscerateMobHealth()
	local healthLeft, healthMax = OneHitWonder_GetUnitHealth("target");
	local secondsUntilEviscerate = 0;
	local energyNeeded = OneHitWonder_GetEnergyConsumption(ONEHITWONDER_ABILITY_EVISCERATE_NAME);
	local curEnergy = UnitMana("player");
	if ( curEnergy >= energyNeeded ) then
		secondsUntilEviscerate = 2;
	else
		if ( curEnergy < 15 ) then
			secondsUntilEviscerate = 6;
		else
			secondsUntilEviscerate = 4;
		end
	end
	local healthDamage = OneHitWonder_GetPlayerDPS() * secondsUntilEviscerate;
	local partyMembers = GetNumPartyMembers();
	if ( partyMembers > 0 ) then
		healthDamage = healthDamage + ( healthDamage * partyMembers * 0.75);
	end
	healthLeft = healthLeft - healthDamage;
	if ( healthLeft <= -1 ) then
		return -1;
	end
	local eviscerateId = DynamicData.spell.getMatchingSpellId(ONEHITWONDER_ABILITY_EVISCERATE_NAME);
	if ( eviscerateId ) and ( eviscerateId > -1 ) then
		local eviscerateData = DynamicData.spell.getSpellInfo(eviscerateId);
		local eviscerateDamageData = OneHitWonder_GetEviscerateDataFromTooltip(eviscerateData.strings);
		local data = nil;
		for comboPoints, data in eviscerateDamageData do
			if ( healthLeft >= data.minDamage ) and ( healthLeft <= data.maxDamage ) then
				return comboPoints;
			end
		end
		data = eviscerateDamageData[1];
		if ( data ) then
			if ( healthLeft < data.minDamage ) then
				return 1;
			else
				local maxDamage = OneHitWonder_GetMaximumEviscerateDamage(eviscerateDamageData);
				local exceeded = healthLeft / maxDamage;
				if ( exceeded > 2 ) then
					return OneHitWonder_GetComboPointsNeededToEviscerate(true);
				else
					return MAX_COMBO_POINTS;
				end
			end
		else
			return 1;
		end
	else
		return -1;
	end
end

function OneHitWonder_GetComboPointsNeededToEviscerateOld()
	local unitHPPercent = OneHitWonder_GetTargetHPPercentage();

	local playerLevel = UnitLevel("player");
	local targetLevel = UnitLevel("target");
	if ( targetLevel - playerLevel > 5 ) then
		-- does not matter, you're not going to do something good with it anyhow
		return 1;
	end
	if ( playerLevel - targetLevel >= 10 ) then
		-- will prolly kill it quick
		return 1;
	end
	if ( playerLevel - targetLevel >= 5 ) then
		if ( unitHPPercent <= 15 ) then
			return 1;
		elseif ( unitHPPercent <= 50 ) then
			return 2;
		else
			return 4;
		end
	end
	if ( playerLevel - targetLevel >= 3 ) then
		if ( unitHPPercent <= 20 ) then
			return 1;
		elseif ( unitHPPercent <= 50 ) then
			return 2;
		else
			return 4;
		end
	end
	if ( playerLevel - targetLevel >= -1 ) then
		if ( unitHPPercent <= 25 ) then
			return 1;
		elseif ( unitHPPercent <= 40 ) then
			return 3;
		elseif ( unitHPPercent <= 50 ) then
			return 4;
		else
			return 5;
		end
	else
		if ( unitHPPercent <= 10 ) then
			return 2;
		elseif ( unitHPPercent <= 25 ) then
			return 3;
		elseif ( unitHPPercent <= 50 ) then
			return 4;
		else
			return 5;
		end
	end
end



function OneHitWonder_Rogue_SetUseGhostlyStrike(toggle)
	OneHitWonder_Rogue_UseGhostlyStrike = toggle;
end

function OneHitWonder_Rogue_SetGhostlyStrikeHealth(toggle, value)
	OneHitWonder_Rogue_GhostlyStrikeHealth = toggle;
	OneHitWonder_Rogue_GhostlyStrikeHealthPercentage = value;
end

function OneHitWonder_Rogue_SetUseSmartRupture(toggle, value)
	OneHitWonder_Rogue_UseSmartRupture = toggle;
	OneHitWonder_Rogue_UseSmartRuptureComboPoints = value;
end

function OneHitWonder_Rogue_SetShouldPickPocket(toggle)
	OneHitWonder_Rogue_ShouldPickPocket = toggle;
end

function OneHitWonder_Rogue_SetShouldRiposte(toggle)
	OneHitWonder_Rogue_ShouldRiposte = toggle;
end


function OneHitWonder_Rogue_SetStealthOpeningAbilityNumber(toggle, value)
	if ( value ~= OneHitWonder_Rogue_StealthOpeningAbilityNumber ) then
		OneHitWonder_Rogue_StealthOpeningAbilityNumber = value;
	end
end

function OneHitWonder_Rogue_SetStealthOpeningBackupAbilityNumber(toggle, value)
	if ( value ~= OneHitWonder_Rogue_StealthOpeningBackupAbilityNumber ) then
		OneHitWonder_Rogue_StealthOpeningBackupAbilityNumber = value;
	end
end

function OneHitWonder_Rogue_SetShouldGarrote(toggle)
	OneHitWonder_Rogue_ShouldGarrote = toggle;
end

function OneHitWonder_Rogue_SetShouldCheapShot(toggle)
	OneHitWonder_Rogue_ShouldCheapShot = toggle;
end

function OneHitWonder_Rogue_SetShouldAmbush(toggle)
	OneHitWonder_Rogue_ShouldAmbush = toggle;
end

function OneHitWonder_Rogue_SetShouldBackstab(toggle)
	OneHitWonder_Rogue_ShouldBackstab = toggle;
end

function OneHitWonder_Rogue_SetUseSmartExposeArmor(toggle)
	OneHitWonder_Rogue_UseSmartExposeArmor = toggle;
end

function OneHitWonder_Rogue_SetUseSmartSliceDice(toggle)
	OneHitWonder_Rogue_UseSmartSliceDice = toggle;
end

function OneHitWonder_Rogue_SetSliceDicePercentage(toggle, value)
	OneHitWonder_Rogue_SliceDicePercentageDirection = toggle;
	OneHitWonder_Rogue_SliceDicePercentage = value;
end

function OneHitWonder_Rogue_SetSliceDiceComboPointsMin(toggle, value)
	OneHitWonder_Rogue_SliceDiceComboPointsMin = value;
end

function OneHitWonder_Rogue_SetSliceDiceComboPointsMax(toggle, value)
	OneHitWonder_Rogue_SliceDiceComboPointsMax = value;
end

function OneHitWonder_Rogue_SetExposeArmorPercentage(toggle, value)
	OneHitWonder_Rogue_ExposeArmorPercentage = value;
end

function OneHitWonder_Rogue_SetExposeArmorComboPointsMin(toggle, value)
	OneHitWonder_Rogue_ExposeArmorComboPointsMin = value;
end

function OneHitWonder_Rogue_SetExposeArmorComboPointsMax(toggle, value)
	OneHitWonder_Rogue_ExposeArmorComboPointsMax = value;
end

function OneHitWonder_Rogue_SetUseNewEviscerateCode(toggle)
	OneHitWonder_Rogue_UseNewEviscerateCode = toggle;
end

function OneHitWonder_Rogue_SetEviscerateNowPercentage(toggle, value)
	OneHitWonder_Rogue_EviscerateNowPercentage = value;
end

function OneHitWonder_Rogue_SetEviscerateExtraComboPointPercentage(toggle, value)
	OneHitWonder_Rogue_EviscerateExtraComboPointPercentage = value;
end

function OneHitWonder_Rogue_SetEviscerateTwiceExtraComboPointPercentage(toggle, value)
	OneHitWonder_Rogue_EviscerateTwiceExtraComboPointPercentage = value;
end

function OneHitWonder_Rogue_SetEviscerateBaseComboPoints(toggle, value)
	OneHitWonder_Rogue_EviscerateBaseComboPoints = value;
end

function OneHitWonder_Rogue_SetReactiveCastKick(toggle)
	OneHitWonder_Rogue_ReactiveCastKick = toggle;
end

function OneHitWonder_Rogue_SetReactiveCastGouge(toggle)
	OneHitWonder_Rogue_ReactiveCastGouge = toggle;
end

function OneHitWonder_Rogue_SetReactiveCastKidneyShot(toggle, value)
	OneHitWonder_Rogue_ReactiveCastKidneyShot = toggle;
	OneHitWonder_Rogue_ReactiveCastKidneyShotMaximumCP = value;
end

function OneHitWonder_Rogue_SetAllowedBackstabAttempts(toggle, value)
	OneHitWonder_Rogue_AllowedBackstabAttempts = value;
end

function OneHitWonder_Rogue_SetUseColdBlood(toggle)
	OneHitWonder_Rogue_UseColdBlood = toggle;
end

function OneHitWonder_Rogue_SetColdBloodOnlyInPvP(toggle)
	OneHitWonder_Rogue_ColdBloodOnlyInPvP = toggle;
end

function OneHitWonder_Rogue_SetColdBloodComboPointsMin(toggle, value)
	OneHitWonder_Rogue_ColdBloodComboPointsMin = value;
end


function OneHitWonder_Rogue_SetSap_Fail_Action(toggle, value)
	if ( OneHitWonder_Rogue_SetSap_Fail_Action ~= value ) then
		OneHitWonder_Rogue_SetSap_Fail_Action = value;
	end
end

function OneHitWonder_Rogue_Cosmos()

OneHitWonder_Rogue_ShouldGarrote = 1;
OneHitWonder_Rogue_ShouldCheapShot = 1;
OneHitWonder_Rogue_ShouldAmbush = 1;
OneHitWonder_Rogue_ShouldBackstab = 1;

	if ( Cosmos_RegisterConfiguration ) and ( Cosmos_UpdateValue ) then
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_SEPARATOR",
			"SEPARATOR",
			TEXT(ONEHITWONDER_ROGUE_SEPARATOR),
			TEXT(ONEHITWONDER_ROGUE_SEPARATOR_INFO)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_USE_PICK_POCKET",
			"CHECKBOX",
			TEXT(ONEHITWONDER_ROGUE_USE_PICK_POCKET),
			TEXT(ONEHITWONDER_ROGUE_USE_PICK_POCKET_INFO),
			OneHitWonder_Rogue_SetShouldPickPocket,
			OneHitWonder_Rogue_ShouldPickPocket
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_USE_RIPOSTE",
			"CHECKBOX",
			TEXT(ONEHITWONDER_ROGUE_USE_RIPOSTE),
			TEXT(ONEHITWONDER_ROGUE_USE_RIPOSTE_INFO),
			OneHitWonder_Rogue_SetShouldRiposte,
			OneHitWonder_Rogue_ShouldRiposte
		);
		local info = TEXT(ONEHITWONDER_ROGUE_SAP_FAIL_ACTION_INFO);
		for k, v in OneHitWonder_Rogue_Sap_Fail_Actions do
			info = info..string.format(" %d = %s.", k, v);
		end
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_SAP_FAIL_ACTION",
			"SLIDER",
			TEXT(ONEHITWONDER_ROGUE_SAP_FAIL_ACTION),
			info,
			OneHitWonder_Rogue_SetSap_Fail_Action,
			1,
			OneHitWonder_Rogue_Sap_Fail_Action, -- default
			0, -- min
			table.getn(OneHitWonder_Rogue_Sap_Fail_Actions), -- max
			"",
			1,
			1,
			TEXT(ONEHITWONDER_ROGUE_SAP_FAIL_ACTION_APPEND)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_USE_SMART_RUPTURE",
			"BOTH",
			TEXT(ONEHITWONDER_ROGUE_USE_SMART_RUPTURE),
			TEXT(ONEHITWONDER_ROGUE_USE_SMART_RUPTURE_INFO),
			OneHitWonder_Rogue_SetUseSmartRupture,
			OneHitWonder_Rogue_UseSmartRupture,
			OneHitWonder_Rogue_UseSmartRuptureComboPoints,
			1,
			MAX_COMBO_POINTS,
			"",
			1,
			1,
			TEXT(ONEHITWONDER_ROGUE_USE_SMART_RUPTURE_APPEND)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_REACTIVE_CAST_KICK",
			"CHECKBOX",
			TEXT(ONEHITWONDER_ROGUE_REACTIVE_CAST_KICK),
			TEXT(ONEHITWONDER_ROGUE_REACTIVE_CAST_KICK_INFO),
			OneHitWonder_Rogue_SetReactiveCastKick,
			OneHitWonder_Rogue_ReactiveCastKick
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_REACTIVE_CAST_GOUGE",
			"CHECKBOX",
			TEXT(ONEHITWONDER_ROGUE_REACTIVE_CAST_GOUGE),
			TEXT(ONEHITWONDER_ROGUE_REACTIVE_CAST_GOUGE_INFO),
			OneHitWonder_Rogue_SetReactiveCastGouge,
			OneHitWonder_Rogue_ReactiveCastGouge
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_REACTIVE_CAST_KIDNEY_SHOT",
			"BOTH",
			TEXT(ONEHITWONDER_ROGUE_REACTIVE_CAST_KIDNEY_SHOT),
			TEXT(ONEHITWONDER_ROGUE_REACTIVE_CAST_KIDNEY_SHOT_INFO),
			OneHitWonder_Rogue_SetReactiveCastKidneyShot,
			OneHitWonder_Rogue_ReactiveCastKidneyShot,
			OneHitWonder_Rogue_ReactiveCastKidneyShotMaximumCP,
			1,
			MAX_COMBO_POINTS,
			"",
			1,
			1,
			TEXT(ONEHITWONDER_ROGUE_REACTIVE_CAST_KIDNEY_SHOT_APPEND)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_USE_HEMORRHAGE",
			"CHECKBOX",
			TEXT(ONEHITWONDER_ROGUE_USE_HEMORRHAGE),
			TEXT(ONEHITWONDER_ROGUE_USE_HEMORRHAGE_INFO),
			OneHitWonder_Rogue_SetUseHemorrhage,
			OneHitWonder_Rogue_UseHemorrhage
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_USE_GHOSTLY_STRIKE",
			"CHECKBOX",
			TEXT(ONEHITWONDER_ROGUE_USE_GHOSTLY_STRIKE),
			TEXT(ONEHITWONDER_ROGUE_USE_GHOSTLY_STRIKE_INFO),
			OneHitWonder_Rogue_SetUseGhostlyStrike,
			OneHitWonder_Rogue_UseGhostlyStrike
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_GHOSTLY_STRIKE_HEALTH",
			"BOTH",
			TEXT(ONEHITWONDER_ROGUE_GHOSTLY_STRIKE_HEALTH),
			TEXT(ONEHITWONDER_ROGUE_GHOSTLY_STRIKE_HEALTH_INFO),
			OneHitWonder_Rogue_SetGhostlyStrikeHealth,
			OneHitWonder_Rogue_GhostlyStrikeHealth,				-- default checked
			OneHitWonder_Rogue_GhostlyStrikeHealthPercentage, 	-- default value
			0, -- min
			100, -- max
			"",
			1,
			1,
			TEXT(ONEHITWONDER_ROGUE_GHOSTLY_STRIKE_HEALTH_APPEND)
		);
		
		--[[
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_STEALTH_ATTACK_SEPARATOR",
			"SEPARATOR",
			TEXT(ONEHITWONDER_ROGUE_STEALTH_ATTACK_SEPARATOR),
			TEXT(ONEHITWONDER_ROGUE_STEALTH_ATTACK_SEPARATOR_INFO)
		);
		]]--
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_ALLOWED_STEALTH_ATTACK_ATTEMPTS",
			"SLIDER",
			TEXT(ONEHITWONDER_ROGUE_ALLOWED_STEALTH_ATTACK_ATTEMPTS),
			TEXT(ONEHITWONDER_ROGUE_ALLOWED_STEALTH_ATTACK_ATTEMPTS_INFO),
			OneHitWonder_Rogue_SetAllowedBackstabAttempts,
			1,
			OneHitWonder_Rogue_AllowedBackstabAttempts, -- default
			0, -- min
			10, -- max
			"",
			1,
			1,
			TEXT(ONEHITWONDER_ROGUE_ALLOWED_STEALTH_ATTACK_ATTEMPTS_APPEND)
		);
		local stealthOpenerInfo = ONEHITWONDER_ROGUE_STEALTH_OPENER_CHOICE_INFO.."\n";
		for k, v in OneHitWonder_Rogue_StealthOpeningAbilities do
			stealthOpenerInfo = stealthOpenerInfo..string.format(" %d = %s.", k, v);
		end
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_STEALTH_OPENER_CHOICE",
			"SLIDER",
			TEXT(ONEHITWONDER_ROGUE_STEALTH_OPENER_CHOICE),
			stealthOpenerInfo,
			OneHitWonder_Rogue_SetStealthOpeningAbilityNumber,
			1,
			OneHitWonder_Rogue_StealthOpeningAbilityNumber, -- default
			0, -- min
			table.getn(OneHitWonder_Rogue_StealthOpeningAbilities), -- max
			"",
			1,
			1,
			TEXT(ONEHITWONDER_ROGUE_STEALTH_OPENER_CHOICE_APPEND)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_STEALTH_OPENER_BACKUP_CHOICE",
			"SLIDER",
			TEXT(ONEHITWONDER_ROGUE_STEALTH_OPENER_BACKUP_CHOICE),
			stealthOpenerInfo,
			OneHitWonder_Rogue_SetStealthOpeningBackupAbilityNumber,
			1,
			OneHitWonder_Rogue_StealthOpeningBackupAbilityNumber, -- default
			0, -- min
			table.getn(OneHitWonder_Rogue_StealthOpeningAbilities), -- max
			"",
			1,
			1,
			TEXT(ONEHITWONDER_ROGUE_STEALTH_OPENER_CHOICE_APPEND)
		);
		--[[
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_USE_GARROTE",
			"CHECKBOX",
			TEXT(ONEHITWONDER_ROGUE_USE_GARROTE),
			TEXT(ONEHITWONDER_ROGUE_USE_GARROTE_INFO),
			OneHitWonder_Rogue_SetShouldGarrote,
			OneHitWonder_Rogue_ShouldGarrote
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_USE_CHEAP_SHOT",
			"CHECKBOX",
			TEXT(ONEHITWONDER_ROGUE_USE_CHEAP_SHOT),
			TEXT(ONEHITWONDER_ROGUE_USE_CHEAP_SHOT_INFO),
			OneHitWonder_Rogue_SetShouldCheapShot,
			OneHitWonder_Rogue_ShouldCheapShot
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_USE_AMBUSH",
			"CHECKBOX",
			TEXT(ONEHITWONDER_ROGUE_USE_AMBUSH),
			TEXT(ONEHITWONDER_ROGUE_USE_AMBUSH_INFO),
			OneHitWonder_Rogue_SetShouldAmbush,
			OneHitWonder_Rogue_ShouldAmbush
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_USE_BACKSTAB",
			"CHECKBOX",
			TEXT(ONEHITWONDER_ROGUE_USE_BACKSTAB),
			TEXT(ONEHITWONDER_ROGUE_USE_BACKSTAB_INFO),
			OneHitWonder_Rogue_SetShouldBackstab,
			OneHitWonder_Rogue_ShouldBackstab
		);
		]]--
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_EXPOSE_ARMOR_SEPARATOR",
			"SEPARATOR",
			TEXT(ONEHITWONDER_ROGUE_EXPOSE_ARMOR_SEPARATOR),
			TEXT(ONEHITWONDER_ROGUE_EXPOSE_ARMOR_SEPARATOR_INFO)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_USE_SMART_EXPOSE_ARMOR",
			"CHECKBOX",
			TEXT(ONEHITWONDER_ROGUE_USE_SMART_EXPOSE_ARMOR),
			TEXT(ONEHITWONDER_ROGUE_USE_SMART_EXPOSE_ARMOR_INFO),
			OneHitWonder_Rogue_SetUseSmartExposeArmor,
			OneHitWonder_Rogue_UseSmartExposeArmor
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_EXPOSE_ARMOR",
			"SLIDER",
			TEXT(ONEHITWONDER_ROGUE_EXPOSE_ARMOR),
			TEXT(ONEHITWONDER_ROGUE_EXPOSE_ARMOR_INFO),
			OneHitWonder_Rogue_SetExposeArmorPercentage,
			1,
			OneHitWonder_Rogue_ExposeArmorPercentage, -- default
			0, -- min
			100, -- max
			"",
			1,
			1,
			TEXT(ONEHITWONDER_ROGUE_EXPOSE_ARMOR_APPEND)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_EXPOSE_ARMOR_COMBO_POINTS_MIN",
			"SLIDER",
			TEXT(ONEHITWONDER_ROGUE_EXPOSE_ARMOR_COMBO_POINTS_MIN),
			TEXT(ONEHITWONDER_ROGUE_EXPOSE_ARMOR_COMBO_POINTS_MIN_INFO),
			OneHitWonder_Rogue_SetExposeArmorComboPointsMin,
			1,
			OneHitWonder_Rogue_ExposeArmorComboPointsMin, -- default
			1, -- min
			5, -- max
			"",
			1,
			1,
			TEXT(ONEHITWONDER_ROGUE_EXPOSE_ARMOR_COMBO_POINTS_MIN_APPEND)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_EXPOSE_ARMOR_COMBO_POINTS_MAX",
			"SLIDER",
			TEXT(ONEHITWONDER_ROGUE_EXPOSE_ARMOR_COMBO_POINTS_MAX),
			TEXT(ONEHITWONDER_ROGUE_EXPOSE_ARMOR_COMBO_POINTS_MAX_INFO),
			OneHitWonder_Rogue_SetExposeArmorComboPointsMax,
			1,
			OneHitWonder_Rogue_ExposeArmorComboPointsMax, -- default
			1, -- min
			5, -- max
			"",
			1,
			1,
			TEXT(ONEHITWONDER_ROGUE_EXPOSE_ARMOR_COMBO_POINTS_MAX_APPEND)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_SLICE_DICE_SEPARATOR",
			"SEPARATOR",
			TEXT(ONEHITWONDER_ROGUE_SLICE_DICE_SEPARATOR),
			TEXT(ONEHITWONDER_ROGUE_SLICE_DICE_SEPARATOR_INFO)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_USE_SMART_SLICE_DICE",
			"CHECKBOX",
			TEXT(ONEHITWONDER_ROGUE_USE_SMART_SLICE_DICE),
			TEXT(ONEHITWONDER_ROGUE_USE_SMART_SLICE_DICE_INFO),
			OneHitWonder_Rogue_SetUseSmartSliceDice,
			OneHitWonder_Rogue_UseSmartSliceDice
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_SLICE_DICE",
			"BOTH",
			TEXT(ONEHITWONDER_ROGUE_SLICE_DICE),
			TEXT(ONEHITWONDER_ROGUE_SLICE_DICE_INFO),
			OneHitWonder_Rogue_SetSliceDicePercentage,
			OneHitWonder_Rogue_SliceDicePercentageDirection,
			OneHitWonder_Rogue_SliceDicePercentage, -- default
			0, -- min
			100, -- max
			"",
			1,
			1,
			TEXT(ONEHITWONDER_ROGUE_SLICE_DICE_APPEND)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_SLICE_DICE_COMBO_POINTS_MIN",
			"SLIDER",
			TEXT(ONEHITWONDER_ROGUE_SLICE_DICE_COMBO_POINTS_MIN),
			TEXT(ONEHITWONDER_ROGUE_SLICE_DICE_COMBO_POINTS_MIN_INFO),
			OneHitWonder_Rogue_SetSliceDiceComboPointsMin,
			1,
			OneHitWonder_Rogue_SliceDiceComboPointsMin, -- default
			1, -- min
			5, -- max
			"",
			1,
			1,
			TEXT(ONEHITWONDER_ROGUE_SLICE_DICE_COMBO_POINTS_MIN_APPEND)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_SLICE_DICE_COMBO_POINTS_MAX",
			"SLIDER",
			TEXT(ONEHITWONDER_ROGUE_SLICE_DICE_COMBO_POINTS_MAX),
			TEXT(ONEHITWONDER_ROGUE_SLICE_DICE_COMBO_POINTS_MAX_INFO),
			OneHitWonder_Rogue_SetSliceDiceComboPointsMax,
			1,
			OneHitWonder_Rogue_SliceDiceComboPointsMax, -- default
			1, -- min
			5, -- max
			"",
			1,
			1,
			TEXT(ONEHITWONDER_ROGUE_SLICE_DICE_COMBO_POINTS_MAX_APPEND)
		);
		--[[
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_EVISCERATE_SEPARATOR",
			"SEPARATOR",
			TEXT(ONEHITWONDER_ROGUE_EVISCERATE_SEPARATOR),
			TEXT(ONEHITWONDER_ROGUE_EVISCERATE_SEPARATOR_INFO)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_EVISCERATE_USE_NEW",
			"CHECKBOX",
			TEXT(ONEHITWONDER_ROGUE_EVISCERATE_USE_NEW),
			TEXT(ONEHITWONDER_ROGUE_EVISCERATE_USE_NEW_INFO),
			OneHitWonder_Rogue_SetUseNewEviscerateCode,
			OneHitWonder_Rogue_UseNewEviscerateCode
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_EVISCERATE_NOW",
			"SLIDER",
			TEXT(ONEHITWONDER_ROGUE_EVISCERATE_NOW),
			TEXT(ONEHITWONDER_ROGUE_EVISCERATE_NOW_INFO),
			OneHitWonder_Rogue_SetEviscerateNowPercentage,
			1,
			OneHitWonder_Rogue_EviscerateNowPercentage, -- default
			0, -- min
			100, -- max
			"",
			1,
			1,
			TEXT(ONEHITWONDER_ROGUE_EVISCERATE_NOW_APPEND)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_EVISCERATE_BASE_COMBO_POINTS",
			"SLIDER",
			TEXT(ONEHITWONDER_ROGUE_EVISCERATE_BASE_COMBO_POINTS),
			TEXT(ONEHITWONDER_ROGUE_EVISCERATE_BASE_COMBO_POINTS_INFO),
			OneHitWonder_Rogue_SetEviscerateBaseComboPoints,
			1,
			OneHitWonder_Rogue_EviscerateBaseComboPoints, -- default
			1, -- min
			5, -- max
			"",
			1,
			1,
			TEXT(ONEHITWONDER_ROGUE_EVISCERATE_BASE_COMBO_POINTS_APPEND)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_EVISCERATE_EXTRA_COMBO_POINT",
			"SLIDER",
			TEXT(ONEHITWONDER_ROGUE_EVISCERATE_EXTRA_COMBO_POINT),
			TEXT(ONEHITWONDER_ROGUE_EVISCERATE_EXTRA_COMBO_POINT_INFO),
			OneHitWonder_Rogue_SetEviscerateExtraComboPointPercentage,
			1,
			OneHitWonder_Rogue_EviscerateExtraComboPointPercentage, -- default
			1, -- min
			100, -- max
			"",
			1,
			1,
			TEXT(ONEHITWONDER_ROGUE_EVISCERATE_EXTRA_COMBO_POINT_APPEND)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_EVISCERATE_EXTRA_COMBO_POINTS",
			"SLIDER",
			TEXT(ONEHITWONDER_ROGUE_EVISCERATE_EXTRA_COMBO_POINTS),
			TEXT(ONEHITWONDER_ROGUE_EVISCERATE_EXTRA_COMBO_POINTS_INFO),
			OneHitWonder_Rogue_SetEviscerateTwiceExtraComboPointPercentage,
			1,
			OneHitWonder_Rogue_EviscerateTwiceExtraComboPointPercentage, -- default
			1, -- min
			100, -- max
			"",
			1,
			1,
			TEXT(ONEHITWONDER_ROGUE_EVISCERATE_EXTRA_COMBO_POINTS_APPEND)
		);
		]]--
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_COLD_BLOOD_SEPARATOR",
			"SEPARATOR",
			TEXT(ONEHITWONDER_ROGUE_COLD_BLOOD_SEPARATOR),
			TEXT(ONEHITWONDER_ROGUE_COLD_BLOOD_SEPARATOR_INFO)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_USE_COLD_BLOOD",
			"CHECKBOX",
			TEXT(ONEHITWONDER_ROGUE_USE_COLD_BLOOD),
			TEXT(ONEHITWONDER_ROGUE_USE_COLD_BLOOD_INFO),
			OneHitWonder_Rogue_SetUseColdBlood,
			OneHitWonder_Rogue_UseColdBlood
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_COLD_BLOOD_ONLY_IN_PVP",
			"CHECKBOX",
			TEXT(ONEHITWONDER_ROGUE_COLD_BLOOD_ONLY_IN_PVP),
			TEXT(ONEHITWONDER_ROGUE_COLD_BLOOD_ONLY_IN_PVP_INFO),
			OneHitWonder_Rogue_SetColdBloodOnlyInPvP,
			OneHitWonder_Rogue_ColdBloodOnlyInPvP
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ROGUE_COLD_BLOOD_COMBO_POINTS_MIN",
			"SLIDER",
			TEXT(ONEHITWONDER_ROGUE_COLD_BLOOD_COMBO_POINTS_MIN),
			TEXT(ONEHITWONDER_ROGUE_COLD_BLOOD_COMBO_POINTS_MIN_INFO),
			OneHitWonder_Rogue_SetColdBloodComboPointsMin,
			1,
			OneHitWonder_Rogue_ColdBloodComboPointsMin, -- default
			1, -- min
			5, -- max
			"",
			1,
			1,
			TEXT(ONEHITWONDER_ROGUE_COLD_BLOOD_COMBO_POINTS_MIN_APPEND)
		);
	end
	
end

function OneHitWonder_Rogue_EnergyRegenerated(time)
	local energyPerSecond = 10;
	if ( OneHitWonder_HasPlayerEffect(nil, ONEHITWONDER_ABILITY_ADRENALINE_RUSH_EFFECT) ) then
		energyPerSecond = 20;
	end
	return time * energyPerSecond;
end

function OneHitWonder_TryToInterruptSpell_Rogue(unitName, spellName)
	local interruptId = -1;
	local spellId = -1;
	local abilityName = "";
	local spellShouldBeKickInterrupted = true;
	if ( OneHitWonder_Rogue_ReactiveCastKick == 1 ) and ( OneHitWonder_CanAbilityAffectUnit(ONEHITWONDER_ABILITY_KICK_NAME, "target") ) then
		if ( spellName ) and ( strlen(spellName) > 0 ) then
			if ( OneHitWonder_IsStringInListLoose(spellName, OneHitWonder_SpellsThatCanNotBeKickInterrupted, true) ) then
				spellShouldBeKickInterrupted = false;
			end
		end
		local n = ONEHITWONDER_ABILITY_KICK_NAME;
		if ( spellShouldBeKickInterrupted ) then
			spellId = OneHitWonder_GetSpellId(n);
			if ( spellId > -1 ) then
				abilityName = n;
			end
		end
	end
	local comboPoints = GetComboPoints();
	if ( OneHitWonder_Rogue_ReactiveCastGouge == 1 ) then
		local gougeId = OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_GOUGE_NAME);
		if ( gougeId > -1 ) and ( OneHitWonder_CanAbilityAffectUnit(ONEHITWONDER_ABILITY_GOUGE_NAME, "target") ) then
			local doGouge = false;
			local gougeCooldown = OneHitWonder_GetSpellCooldown(gougeId);
			if ( strlen(abilityName) > 0 ) then
				spellId = OneHitWonder_GetSpellId(abilityName);
				local spellCooldown = OneHitWonder_GetSpellCooldown(spellId);
				if ( spellId <= -1 ) or
					( ( gougeCooldown < spellCooldown ) and ( gougeCooldown <= ONEHITWONDER_INTERRUPT_SPELL_LEEWAY ) ) then
					local energyWhenCooldownComplete = UnitMana("player") + OneHitWonder_Rogue_EnergyRegenerated(gougeCooldown);
					if ( energyWhenCooldownComplete >= ONEHITWONDER_ABILITY_ENERGYCOST[ONEHITWONDER_ABILITY_GOUGE_NAME] ) then
						doGouge = true;
				 	end
				end
			else
				doGouge = true;
			end
			if ( doGouge ) then
				abilityName = ONEHITWONDER_ABILITY_GOUGE_NAME;
			end
		end
	end
	if ( OneHitWonder_Rogue_ReactiveCastKidneyShot == 1 ) and ( comboPoints > 0 ) and ( comboPoints <= OneHitWonder_Rogue_ReactiveCastKidneyShotMaximumCP ) then
		local ksId = OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_KIDNEYSHOT_NAME);
		if ( ksId > -1 ) and ( OneHitWonder_CanAbilityAffectUnit(ONEHITWONDER_ABILITY_KIDNEYSHOT_NAME, "target") ) then
			local doKS = false;
			if ( strlen(abilityName) > 0 ) then
				spellId = OneHitWonder_GetSpellId(abilityName);
				local gougeId = OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_GOUGE_NAME);
				local spellCooldown = OneHitWonder_GetSpellCooldown(spellId);
				local ksCooldown = OneHitWonder_GetSpellCooldown(ksId);
				if ( spellId <= -1 ) then
					doKS = true;
				elseif ( spellId == gougeId ) then
					if ( ( ksCooldown - spellCooldown ) <= 1 ) then
						doKS = true;
					end
				elseif ( ksCooldown < spellCooldown ) then
					doKS = true;
				end
			else
				doKS = true;
			end
			if ( doKS ) then
				abilityName = ONEHITWONDER_ABILITY_KIDNEYSHOT_NAME;
			end
		end
	end
	if ( OneHitWonder_HasPlayerEffect(nil, ONEHITWONDER_ABILITY_STEALTH_EFFECTS) ) then
		abilityName = "";
	end
	if ( OneHitWonder_HasUnitEffect("target", nil, ONEHITWONDER_STUN_EFFECTS) ) then
		abilityName = "";
	end
	if ( OneHitWonder_HasUnitEffect("target", nil, ONEHITWONDER_SLEEP_EFFECTS) ) then
		abilityName = "";
	end
	if ( OneHitWonder_HasUnitEffect("target", nil, ONEHITWONDER_SILENCE_EFFECTS) ) then
		abilityName = "";
	end
	if ( ( abilityName ) and 
		(strlen(abilityName) > 0) ) then
		interruptId = OneHitWonder_GetSpellId(abilityName);
		if ( not interruptId ) or ( interruptId <= -1 ) then
			abilityName = "";
		end
		--[[
		if ( OneHitWonder_GetSpellCooldown(interruptId) <= 3 ) then
			abilityName = "";
			interruptId = -1;
		end
		]]--
	end
	return interruptId, abilityName;
end



function OneHitWonder_ShouldHandleActionQueue_Rogue()
	if ( OneHitWonder_HasPlayerEffect(nil, ONEHITWONDER_ABILITY_STEALTH_EFFECTS) ) then
		return false;
	else
		if ( OneHitWonder_HasUnitEffect("target", nil, ONEHITWONDER_STUN_EFFECTS) ) then
			return false;
		end
		if ( OneHitWonder_HasUnitEffect("target", nil, ONEHITWONDER_SLEEP_EFFECTS) ) then
			return false;
		end
		if ( GetComboPoints() >= MAX_COMBO_POINTS ) then
			return false;
		end
		return true;
	end
end


function OneHitWonder_GetParryCounter_Rogue()
	local abilityName = "";
	local counterId = -1;
	if ( OneHitWonder_Rogue_ShouldRiposte == 1 ) 
		--and ( not OneHitWonder_HasUnitEffect("target", nil, ONEHITWONDER_TALENT_RIPOSTE_EFFECT) ) 
		and ( OneHitWonder_Rogue_ShouldIgnoreRiposteCheck == 1 ) or ( not OneHitWonder_IsUnitImmuneToAbility("target", ONEHITWONDER_TALENT_RIPOSTE_NAME) ) then
		local spellId = OneHitWonder_GetSpellId(ONEHITWONDER_TALENT_RIPOSTE_NAME);
		if ( spellId > -1 ) then
			local targetName = UnitName("target");
			local creatureType = UnitCreatureType("target");
			local found = false;
			if ( OneHitWonder_IsUnitOfType("target", OneHitWonder_NonDisarmableMobTypes, true) ) then
				found = true;
			end
			if ( OneHitWonder_IsUnitNameInList("target", OneHitWonder_NonDisarmableMobs, true) ) then
				found = true;
			end
			if ( not found ) then
				--abilityName = ONEHITWONDER_TALENT_RIPOSTE_NAME;
				--counterId = spellId;
			end
		end
	end
	return counterId, abilityName;
end


function OneHitWonder_DoStuffContinuously_Rogue()
	if ( OneHitWonder_Rogue_DoRiposte() ) then
		return true;
	end
	return false;
end

function OneHitWonder_Rogue_EquipItem(itemName, slot)
	if ( not itemName ) or ( not slot ) then
		return true;
	end
	local itemInfo = DynamicData.item.getItemByName(itemName);
	if ( ( itemInfo.position ) and ( getn(itemInfo.position) > 0 ) ) then
		for k, pos in itemInfo.position do
			if ( ( pos.bag == -1 ) and ( pos.slot == slot ) ) then
				return true;
			end
		end
		local pos = itemInfo.position[1];
		PickupContainerItem(pos.bag, pos.slot);
		PickupInventoryItem(slot);
	end
	return false;
end


function OneHitWonder_Rogue_EquipWeapons(mainHand, offHand)
	if ( Equip ) then
		Equip(mainHand);
	else
		OneHitWonder_Rogue_EquipItem(offHand, 16);
	end
	if ( EquipOffhand ) then
		EquipOffhand(offHand);
	else
		OneHitWonder_Rogue_EquipItem(offHand, 17);
	end
end

function OneHitWonder_Rogue_SwitchBackWeapons()
	PickupInventoryItem(17);
	PickupInventoryItem(16);
end

OneHitWonder_Rogue_Equipping = {};

function OneHitWonder_Rogue_DoEquipping()
	if ( not OneHitWonder_Rogue_Equipping ) then
		OneHitWonder_Rogue_Equipping = {};
	else
		if ( table.getn( OneHitWonder_Rogue_Equipping ) > 0 ) then
			local equipInfo = OneHitWonder_Rogue_Equipping[1];
			table.remove(OneHitWonder_Rogue_Equipping, 1);
			local hasEquippedAHand = false;
			for k, v in equipInfo do
				if ( ( v.slot ~= 16 ) and ( v.slot ~= 17 ) ) or ( not hasEquippedAHand ) then
					OneHitWonder_Rogue_EquipItem(v.name, v.slot);
					if ( v.slot == 16 ) or ( v.slot == 17 ) then
						hasEquippedAHand = true;
					end
				end
			end
		end
	end
	if ( DynamicData ) and ( DynamicData.item ) and ( DynamicData.item.removeOnInventoryUpdate ) then
		DynamicData.item.removeOnInventoryUpdate(OneHitWonder_Rogue_DoEquipping);
	end
end

function OneHitWonder_Rogue_FindBestDagger(daggers)
	local highestDPS = 0;
	local highestDPSIndex = 1;
	local dps = nil;
	for k, v in daggers do
		if ( v.strings ) then
			if ( DynamicData.util.isItemNotBindOnAnything(v.strings) ) then
				dps = DynamicData.util.getDPS(v.strings);
				if ( dps ) and ( dps > highestDPS ) then
					highestDPS = dps;
					highestDPSIndex = k;
				end
			end
		end
	end
	return daggers[highestDPSIndex];
end

function OneHitWonder_Rogue_HasDagger()
	local itemInfoMainHand = DynamicData.item.getEquippedSlotInfo(16);
	if ( itemInfoMainHand.itemType == ONEHITWONDER_ITEM_TYPE_DAGGER ) then
		return true;
	else
		return false;
	end
end


function OneHitWonder_Rogue_EquipDagger()
	local itemInfoMainHand = DynamicData.item.getEquippedSlotInfo(16);
	if ( itemInfoMainHand.itemType == ONEHITWONDER_ITEM_TYPE_DAGGER ) then
		return true;
	end
	if ( CursorHasItem() ) then
		return false;
	end
	local itemInfoOffHand = DynamicData.item.getEquippedSlotInfo(17);
	if ( itemInfoOffHand.itemType == ONEHITWONDER_ITEM_TYPE_DAGGER ) then
		PickupInventoryItem(17);
		PickupInventoryItem(16);
		local data = {};
		data[1] = { itemInfoMainHand.name, 16 };
		data[2] = { itemInfoOffHand.name, 17 };
		table.insert(OneHitWonder_Rogue_Equipping, data);
	else
		local daggers = DynamicData.item.getItemInfoByType(ONEHITWONDER_ITEM_TYPE_DAGGER);
		if ( getn(daggers) > 0 ) then
			local itemInfo = OneHitWonder_Rogue_FindBestDagger(daggers);
			local data = {};
			data[1] = { itemInfoMainHand.name, 16 };
			table.insert(OneHitWonder_Rogue_Equipping, data);
		end
	end
	if ( DynamicData ) and ( DynamicData.item ) and ( DynamicData.item.addOnInventoryUpdate ) then
		DynamicData.item.addOnInventoryUpdate(OneHitWonder_Rogue_DoEquipping);
	end
end

function OneHitWonder_Rogue_EquipNonDagger()
	local itemInfoMainHand = DynamicData.item.getEquippedSlotInfo(16);
	if ( itemInfoMainHand.itemType ~= ONEHITWONDER_ITEM_TYPE_DAGGER ) then
		return true;
	end
	if ( CursorHasItem() ) then
		return false;
	end
	local itemInfoOffHand = DynamicData.item.getEquippedSlotInfo(17);
	if ( itemInfoOffHand.itemType ~= ONEHITWONDER_ITEM_TYPE_DAGGER ) then
		PickupInventoryItem(17);
		PickupInventoryItem(16);
		local data = {};
		data[1] = { itemInfoMainHand.name, 16 };
		data[2] = { itemInfoOffHand.name, 17 };
		table.insert(OneHitWonder_Rogue_Equipping, data);
	else
		local weapons = {};
		local list = nil;
		for k, v in ONEHITWONDER_ITEM_TYPE_WEAPONS_LIST do
			if ( v ~= ONEHITWONDER_ITEM_TYPE_AXES ) and ( v ~= ONEHITWONDER_ITEM_TYPE_DAGGER ) and ( v ~= ONEHITWONDER_ITEM_TYPE_STAFF ) and ( v ~= ONEHITWONDER_ITEM_TYPE_POLEARM ) then
				list = DynamicData.item.getItemInfoByType(v);
				for key, value in list do 
					table.insert(weapons, value);
				end
			end
		end
		if ( getn(weapons) > 0 ) then
			local itemInfo = OneHitWonder_FindMostDamagingWeapon(weapons);
			local data = {};
			data[1] = { itemInfoMainHand.name, 16 };
			table.insert(OneHitWonder_Rogue_Equipping, data);
		end
	end
	if ( DynamicData ) and ( DynamicData.item ) and ( DynamicData.item.addOnInventoryUpdate ) then
		DynamicData.item.addOnInventoryUpdate(OneHitWonder_Rogue_DoEquipping);
	end
end


function OneHitWonder_Target_Changed_Rogue()
	TargetFrame.attemptsToBackstab = 0;
	TargetFrame.hasBeenPickPocketed = false;
end

OneHitWonder_OldInfo = {};

function OneHitWonder_GatherInfo(unit)
	local info = {};
	info.name = UnitName(unit);
	info.class = UnitClass(unit);
	info.level = UnitLevel(unit);
end

function OneHitWonder_IsSameUnit(oldinfo, newinfo)
	for k,v in oldinfo do
		if (v ~= newinfo[k]) then
			return false;
		end
	end
	for k,v in newinfo do
		if (v ~= oldinfo[k]) then
			return false;
		end
	end
	return true;
end


function OneHitWonder_Rogue_ShouldUseRuptureOnUnit(unit)
	if ( not OneHitWonder_CanAbilityAffectUnit(ONEHITWONDER_ABILITY_RUPTURE_NAME, unit) ) then
		return false;
	end

	if ( OneHitWonder_HasTargetMyAbility(ONEHITWONDER_ABILITY_RUPTURE_NAME, ONEHITWONDER_ABILITY_RUPTURE_EFFECT) ) then
		return false;
	end

	if ( UnitPowerType(unit) == ONEHITWONDER_POWERTYPE_MANA ) 
		and ( not UnitIsPlayer(unit) ) 
		and ( UnitLevel(unit) <= UnitLevel("player") ) 
		and ( not OneHitWonder_UnitIsEliteOrBetter(unit) ) then
		return false;
	else
		if ( UnitClass(unit) == ONEHITWONDER_CLASS_DRUID ) then
			if ( UnitPowerType(unit) == ONEHITWONDER_POWERTYPE_RAGE ) then
				return true;
			end
		end
		local class = UnitClass(unit);
		local desiredLevel = OneHitWonder_Rogue_RuptureClassesLevel[class];
		if ( not desiredLevel ) or ( UnitLevel(unit) < desiredLevel ) then
			return false;
		end
	end
	return true;
end

function OneHitWonder_Rogue_DoSap()
	local sap = ONEHITWONDER_ABILITY_SAP_NAME;
	if ( not UnitExists("target") ) then
		OneHitWonder_ShowBigMessage(ONEHITWONDER_ROGUE_SAP_ABORTED_NO_TARGET);
	elseif ( OneHitWonder_IsUnitImmuneToAbility("target", sap) ) then
		OneHitWonder_ShowBigMessage(ONEHITWONDER_ROGUE_SAP_ABORTED_TARGET_IMMUNE);
	else
		OneHitWonder_CastSpell(OneHitWonder_GetSpellId(sap));
	end
end

OneHitWonder_Rogue_HasRegged = 0;

function OneHitWonder_Rogue_Register()
--	RegisterForSave("OneHitWonder_Rogue_Successful_Sap_ChatLine");
end

function OneHitWonder_OnEvent_Rogue(event)
	if ( OneHitWonder_Rogue_HasRegged ~= 1 ) then
		OneHitWonder_Rogue_Register();
		OneHitWonder_Rogue_HasRegged = 1;
	end
	if ( event == "UI_ERROR_MESSAGE" ) then
		if ( arg1 == TEXT(SPELL_FAILED_TARGET_NO_POCKETS) ) then
			if ( OneHitWonder_Rogue_HandlePickpocketEvent ) then
				OneHitWonder_Rogue_HandlePickpocketEvent();
			end
		end
		if ( arg1 == TEXT(SPELL_FAILED_TARGET_NO_WEAPONS) ) then
			if ( OneHitWonder_Rogue_HandleRiposteEvent ) then
				OneHitWonder_Rogue_HandleRiposteEvent();
			end
		end
		return;
	end
	if ( arg1 ) and ( type(arg1) == "string" ) then
		local spell, target;
		for spell, target in string.gfind(arg1, SPELLMISSSELFOTHER) do
			if ( spell == ONEHITWONDER_ABILITY_SAP_NAME ) then
				local msg = ONEHITWONDER_ROGUE_SAP_FAILED;
				if ( OneHitWonder_Rogue_Sap_Fail_Action > 0 ) then
					local ability = OneHitWonder_Rogue_Sap_Fail_Actions[OneHitWonder_Rogue_Sap_Fail_Action];
					local id = OneHitWonder_GetSpellId(ability);
					if ( id > -1 ) and ( OneHitWonder_IsSpellAvailable(id) ) then 
						local parameters = { id, GetTime() + 3};
						OneHitWonder_AddActionToQueue(ONEHITWONDER_ACTIONID_SPELL_TIMEOUT, parameters);
						msg = msg..string.format(ONEHITWONDER_ROGUE_SAP_FAILED_MESSAGE, ability);
					end
				end
				OneHitWonder_ShowBigMessage(msg);
			end
		end
		for spell, target in string.gfind(arg1, SPELLCASTGOSELFTARGETTED) do
			if ( spell == ONEHITWONDER_ABILITY_SAP_NAME ) then
				local msg = ONEHITWONDER_ROGUE_SAP_SUCCESSFUL;
				if ( OneHitWonder_Rogue_Successful_Sap_ChatLine ) 
					and ( strlen(OneHitWonder_Rogue_Successful_Sap_ChatLine) > 0 ) then
					ChatFrame_OnEvent(ChatFrame1, "EXECUTE_CHAT_LINE", OneHitWonder_Rogue_Successful_Sap_ChatLine);
					--[[
						ChatFrame1.editBox:SetText(OneHitWonder_Rogue_Successful_Sap_ChatLine);
						ChatEdit_SendText(ChatFrame1.editBox);
						ChatEdit_OnEscapePressed(ChatFrame1.editBox);
					]]--
				end
				OneHitWonder_ShowZoneMessage(msg, { 0.2, 0.2, 1.0 });
			end
		end
	end
end

function OneHitWonder_Rogue_HandlePickpocketEvent()
	if ( OneHitWonder_Rogue_LastCreatureAttemptedPickpocket ) then
		OneHitWonder_HandleImmuneAbility("target", ONEHITWONDER_ABILITY_PICKPOCKET_NAME);
		OneHitWonder_Rogue_LastCreatureAttemptedPickpocket = nil;
	end
end

function OneHitWonder_Rogue_HandleRiposteEvent()
	if ( OneHitWonder_Rogue_ShouldIgnoreRiposteCheck ~= 1 ) then
		OneHitWonder_HandleImmuneAbility("target", ONEHITWONDER_TALENT_RIPOSTE_NAME);
	end
end

function OneHitWonder_Rogue_GetGarroteDuration()
	return 18;
end

function OneHitWonder_Rogue_GetRuptureDuration(comboPoints)
	if ( comboPoints ) and ( comboPoints > 0 ) then
		return comboPoints * 4 + 2;
	else
		return 0;
	end
end

function OneHitWonder_TalentPointsUpdated_Rogue()
	OneHitWonder_UpdateRageConsumptionWithTalents("ONEHITWONDER_ABILITY_RAGECOST", ONEHITWONDER_WARRIOR_TALENT_RAGE_REDUCERS);
end
	