ONEHITWONDER_DAMAGE_TYPE_HOLY 				= "Holy";
ONEHITWONDER_DAMAGE_TYPE_SHADOW 			= "Shadow";
ONEHITWONDER_DAMAGE_TYPE_NATURE 			= "Nature";
ONEHITWONDER_DAMAGE_TYPE_FIRE 				= "Fire";
ONEHITWONDER_DAMAGE_TYPE_FROST 				= "Frost";

ONEHITWONDER_DEBUFF_EFFECT_TYPE_HEALTH 		= "Health";
ONEHITWONDER_DEBUFF_EFFECT_TYPE_MANA 		= "Mana";

ONEHITWONDER_DEBUFF_CURE_SPELLS = {
	[ONEHITWONDER_DEBUFF_TYPE_CURSE] = {
		ONEHITWONDER_SPELL_REMOVE_CURSE_NAME,
		ONEHITWONDER_SPELL_REMOVE_LESSER_CURSE_NAME,
	},
	[ONEHITWONDER_DEBUFF_TYPE_POISON] = {
		ONEHITWONDER_SPELL_ABOLISH_POISON_NAME,
		ONEHITWONDER_SPELL_CURE_POISON_NAME,
		ONEHITWONDER_SPELL_PURIFY_NAME,
		ONEHITWONDER_SPELL_CLEANSE_NAME,
	},
	[ONEHITWONDER_DEBUFF_TYPE_DISEASE] = {
		ONEHITWONDER_SPELL_CURE_DISEASE_NAME,
		ONEHITWONDER_SPELL_ABOLISH_DISEASE_NAME,
		ONEHITWONDER_SPELL_PURIFY_NAME,
		ONEHITWONDER_SPELL_CLEANSE_NAME,
	},
	[ONEHITWONDER_DEBUFF_TYPE_MAGIC] = {
		ONEHITWONDER_SPELL_DISPEL_MAGIC_NAME,
		ONEHITWONDER_SPELL_CLEANSE_NAME,
	},
};


ONEHITWONDER_DEBUFF_DATA = {
	[ONEHITWONDER_DEBUFF_DARK_PLAGUE_NAME] = {
		debuffType = ONEHITWONDER_DEBUFF_TYPE_DISEASE,
		cleaning = {
			[ONEHITWONDER_SPELL_CURE_DISEASE_NAME] = {
				totalCastsRequired = 3,
				timesRemoved = 1,
			},
		},
		tickSpeed = 2,
		effects = {
			{ 
				effectType = ONEHITWONDER_DEBUFF_EFFECT_TYPE_HEALTH,
				amount = 900,
				damageType = ONEHITWONDER_DAMAGE_TYPE_NATURE,
			},
		},
	},
};

OneHitWonder_PlayerDebuffData = {};

function OneHitWonder_Debuff_AddCleanData(debuffName, spellName, attempts)
	if ( not OneHitWonder_PlayerDebuffData ) then
		OneHitWonder_PlayerDebuffData = {};
	end
	if ( not OneHitWonder_PlayerDebuffData[debuffName] ) then
		OneHitWonder_PlayerDebuffData[debuffName] = {};
	end
	if ( not OneHitWonder_PlayerDebuffData[debuffName].cleaning ) then
		OneHitWonder_PlayerDebuffData[debuffName].cleaning = {};
	end
	if ( not OneHitWonder_PlayerDebuffData[debuffName].cleaning[spellName] ) then
		OneHitWonder_PlayerDebuffData[debuffName].cleaning[spellName] = {};
	end
	if ( not OneHitWonder_PlayerDebuffData[debuffName].cleaning[spellName].totalCastsRequired ) then
		OneHitWonder_PlayerDebuffData[debuffName].cleaning[spellName].totalCastsRequired = 0;
	end
	if ( not OneHitWonder_PlayerDebuffData[debuffName].cleaning[spellName].timesRemoved ) then
		OneHitWonder_PlayerDebuffData[debuffName].cleaning[spellName].timesRemoved = 0;
	end
	OneHitWonder_PlayerDebuffData[debuffName].cleaning[spellName].totalCastsRequired = OneHitWonder_PlayerDebuffData[debuffName].cleaning[spellName].totalCastsRequired + attempts;
	OneHitWonder_PlayerDebuffData[debuffName].cleaning[spellName].timesRemoved = OneHitWonder_PlayerDebuffData[debuffName].cleaning[spellName].timesRemoved + 1;
end

function OneHitWonder_Debuff_GetCleanTimes(debuffName, spellName)
	if ( not OneHitWonder_PlayerDebuffData ) then
		return -1;
	end
	if ( not OneHitWonder_PlayerDebuffData[debuffName] ) then
		return -1;
	end
	if ( not OneHitWonder_PlayerDebuffData[debuffName].cleaning ) then
		return -1;
	end
	if ( not OneHitWonder_PlayerDebuffData[debuffName].cleaning[spellName] ) then
		return -1;
	end
	if ( not OneHitWonder_PlayerDebuffData[debuffName].cleaning[spellName].totalCastsRequired ) then
		return -1;
	end
	if ( not OneHitWonder_PlayerDebuffData[debuffName].cleaning[spellName].timesRemoved ) then
		return -1;
	end
	if ( OneHitWonder_PlayerDebuffData[debuffName].cleaning[spellName].totalCastsRequired <= 0 ) then
		return -1;
	end
	if ( OneHitWonder_PlayerDebuffData[debuffName].cleaning[spellName].timesRemoved <= 0 ) then
		return -1;
	end
	return math.floor( OneHitWonder_PlayerDebuffData[debuffName].cleaning[spellName].totalCastsRequired / OneHitWonder_PlayerDebuffData[debuffName].cleaning[spellName].timesRemoved );
end

function OneHitWonder_Debuff_GetAmountOfDamage(timeSpan, debuffInfo)
	local damageDone = 0;
	if ( debuffInfo ) then
		for k, v in debuffInfo.effects do
			if ( v.effectType == ONEHITWONDER_DEBUFF_TYPE_HEALTH ) then
				damageDone = damageDone + math.floor(timeSpan/debuffInfo.tickSpeed)*v.amount;
			end
		end
	end
	return damageDone;
end

function OneHitWonder_Debuff_GetCureSpell(debuffType, cleanSpellNames)
	for k, v in ONEHITWONDER_DEBUFF_CURE_SPELLS[debuffType] do
		if ( OneHitWonder_IsStringInList(v, cleanSpellNames ) ) then
			return v;
		end
	end
	return nil;
end

function OneHitWonder_Debuff_CanCure(debuffEffectInfo, cleanSpellNames)
	local canCure = false;
	if ( debuffEffectInfo ) and ( debuffEffectInfo.strings ) and ( debuffEffectInfo.strings[1] ) and ( debuffEffectInfo.strings[1].right ) then
		for k, v in cleanSpellNames do
			if ( OneHitWonder_IsStringInList(ONEHITWONDER_DEBUFF_CURE_SPELLS[debuffEffectInfo.strings[1].right], v ) ) then
				canCure = true;
			end
		end
	end
	return canCure;
end

function OneHitWonder_Debuff_WhomShouldIClean(unitList, cleanSpellNames, timeSpan)
	if ( not timeSpan ) then
		timeSpan = 5;
	end
	local worstAfflictedUnit = nil;
	local worstAfflictedUnitMeasure = nil;
	local effectInfo = nil;
	local effects = {};
	for k, v in unitList do
		if ( UnitExists(unit) ) and ( not UnitIsDead(unit) ) then
			effectInfo = DynamicData.effect.getEffectInfos(v);
			effects[v] = effectInfo;
		end
	end
	local currentMeasure = 0;
	for k, v in effects do
		currentMeasure = 0;
		for key, value in v.debuffs do
			if ( OneHitWonder_Debuff_CanCure(value, cleanSpellNames) ) then
				currentMeasure = currentMeasure + OneHitWonder_Debuff_GetAmountOfDamage(timeSpan, ONEHITWONDER_DEBUFF_DATA[value.name]);
			end
		end
		if ( currentMeasure > UnitHealth(unit) ) or ( not worstAfflictedUnitMeasure ) or ( currentMeasure > worstAfflictedUnitMeasure ) then
			worstAfflictedUnitMeasure = currentMeasure;
		end
	end
	local worstAfflictedUnitCureSpell = nil;
	if ( worstAfflictedUnit ) then
		local damageDealtByType = {};
		local currentDamage;
		for k, v in effects[worstAfflictedUnit].debuffs do
			currentDamage = OneHitWonder_Debuff_GetAmountOfDamage(timeSpan, ONEHITWONDER_DEBUFF_DATA[v.name]);
			if ( currentDamage > 0 ) then
				if ( v.strings ) and ( v.strings[1] ) then
					local debuffType = v.strings[1].right;
					if ( debuffType ) then
						if( not damageDealtByType[debuffType] ) then
							damageDealtByType[debuffType] = 0;
						end
						damageDealtByType[debuffType] = damageDealtByType[debuffType] + currentDamage;
					end
				end
			end
		end
		local worstType = nil;
		local worstDamage = nil;
		for k, v in damageDealtByType do
			if ( not worstDamage ) or ( v > worstDamage ) then
				worstType = k;
				worseDamage = v;
			end
		end
		worstAfflictedUnitCureSpell = OneHitWonder_Debuff_GetAmountOfDamage(worstType, cleanSpellNames);
	end
	return worstAfflictedUnit, worstAfflictedUnitCureSpell;
end
