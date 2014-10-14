ONEHITWONDER_ABILITY_DEMORALIZING_SHOUT_DURATION_BASE = 30;
OneHitWonder_Ability_Demoralizing_Shout_Duration = ONEHITWONDER_ABILITY_DEMORALIZING_SHOUT_DURATION_BASE;
OneHitWonder_Ability_Hamstring_Duration = 15;
OneHitWonder_Ability_Thunder_Clap_Duration = 30;
ONEHITWONDER_WARRIOR_REND_OVERLAP = 0;
OneHitWonder_Warrior_ExecuteHollered = 0;


ONEHITWONDER_ABILITY_REND_TEXTURE = "Interface\\Icons\\Ability_Gouge";
ONEHITWONDER_ABILITY_BATTLESHOUT_TEXTURE = "Interface\\Icons\\Ability_Warrior_BattleShout";

-- needs to be modified by talents
ONEHITWONDER_ABILITY_RAGECOST = {
	[ONEHITWONDER_ABILITY_THUNDER_CLAP_NAME] = 20,
	[ONEHITWONDER_ABILITY_DEMORALIZING_SHOUT_NAME] = 10,
	[ONEHITWONDER_ABILITY_BATTLESHOUT_NAME] = 10,
	[ONEHITWONDER_ABILITY_HEROICSTRIKE_NAME] = 15,
	[ONEHITWONDER_ABILITY_PUMMEL_NAME] = 10,
	[ONEHITWONDER_ABILITY_REVENGE_NAME] = 5,
	[ONEHITWONDER_ABILITY_SHIELDBASH_NAME] = 10,
	[ONEHITWONDER_ABILITY_REND_NAME] = 10,
	[ONEHITWONDER_ABILITY_HAMSTRING_NAME] = 10,
	[ONEHITWONDER_ABILITY_MOCKINGBLOW_NAME] = 10,
	[ONEHITWONDER_ABILITY_OVERPOWER_NAME] = 5,
	[ONEHITWONDER_ABILITY_EXECUTE_NAME] = 15,
	[ONEHITWONDER_ABILITY_SUNDER_ARMOR_NAME] = 15,
	[ONEHITWONDER_ABILITY_SLAM_NAME] = 15,
	[ONEHITWONDER_ABILITY_MORTAL_STRIKE_NAME] = 30,
	[ONEHITWONDER_ABILITY_BLOODTHIRST_NAME] = 30,
	[ONEHITWONDER_ABILITY_WHIRL_STRIKE_NAME] = 25,
	[ONEHITWONDER_ABILITY_CHARGE_NAME] = 0,
	[ONEHITWONDER_ABILITY_BERSRAGE_NAME] = 0
};

function OneHitWonder_GetRageConsumption(abilityName)
	return ONEHITWONDER_ABILITY_RAGECOST[abilityName];
end

ONEHITWONDER_WARRIOR_TALENT_RAGE_REDUCERS = {
	{ 
		{ 1,1 },
		ONEHITWONDER_ABILITY_HEROICSTRIKE_NAME,
		{ 14, 13, 12 }
	},
	{ 
		{ 1,6 },
		ONEHITWONDER_ABILITY_THUNDER_CLAP_NAME,
		{ 19, 18, 16 }
	},
	{ 
		{ 2,10 },
		ONEHITWONDER_ABILITY_EXECUTE_NAME,
		{ 13, 10 }
	},
	{ 
		{ 3,10 },
		ONEHITWONDER_ABILITY_SUNDER_ARMOR_NAME,
		{ 14, 13, 12 }
	},
};

--[[
	{ 
		{ talent tab, talent },
		Ability index,
		{ rage cost at rank 1, rage cost at rank 2, ... }
	},
]]--

ONEHITWONDER_ABILITY_SUNDER_ARMOR = {
	90,
	180,
	270,
	360,
	450
};


ONEHITWONDER_MAXIMUM_NUMBER_OF_SUNDERS 		= 5;


OneHitWonder_Warrior_UseBattleShout = 1;
OneHitWonder_Warrior_UseBerserkerRage = 1;
OneHitWonder_Warrior_UseRunningAbility = 0;
OneHitWonder_Warrior_UseHamstring = 1;
OneHitWonder_Warrior_UseMortalStrike = 1;
OneHitWonder_Warrior_MortalStrikeRage = 30;
OneHitWonder_Warrior_UseBloodthirst = 1;
OneHitWonder_Warrior_BloodthirstRage = 30;
OneHitWonder_Warrior_UseWhirlStrike = 1;
OneHitWonder_Warrior_WhirlStrikeRage = 25;
OneHitWonder_Warrior_HamstringTargetHPPercentage = 8;
-- OneHitWonder_Warrior_MortalStrikeTargetHPPercentage = 19;
OneHitWonder_Warrior_UseRend = 1;
OneHitWonder_Warrior_RendTargetHPPercentage = 25;
OneHitWonder_Warrior_UseShieldBash = 1;
OneHitWonder_Warrior_UseHeroicStrike = 0;
OneHitWonder_Warrior_HeroicStrikeRage = 90;
OneHitWonder_Warrior_UseDemoralizingShout = 0;
OneHitWonder_Warrior_DemoralizingShoutRage = 0;
OneHitWonder_Warrior_UseThunderClap = 0;
OneHitWonder_Warrior_ThunderClapRage = 0;
OneHitWonder_Warrior_ShouldAutoExecute = 1;
OneHitWonder_Warrior_UseSunderArmor = 1;
OneHitWonder_Warrior_SunderArmorRage = 20;
OneHitWonder_Warrior_SunderArmorHPPercentage = 20;
OneHitWonder_Warrior_ShouldOverpower = 1;
OneHitWonder_Warrior_ShouldRevenge = 1;

OneHitWonder_Warrior_FleeingMobStrategy = 1;


OneHitWonder_Options_Warrior = {
	"OneHitWonder_Warrior_UseBattleShout",
	"OneHitWonder_Warrior_UseBerserkerRage",
	"OneHitWonder_Warrior_UseRunningAbility",
	"OneHitWonder_Warrior_UseHamstring",
	"OneHitWonder_Warrior_HamstringTargetHPPercentage",
	"OneHitWonder_Warrior_UseRend",
	"OneHitWonder_Warrior_RendTargetHPPercentage",
	"OneHitWonder_Warrior_UseShieldBash",
	"OneHitWonder_Warrior_UseHeroicStrike",
	"OneHitWonder_Warrior_HeroicStrikeRage",
	"OneHitWonder_Warrior_UseDemoralizingShout",
	"OneHitWonder_Warrior_DemoralizingShoutRage",
	"OneHitWonder_Warrior_UseThunderClap",
	"OneHitWonder_Warrior_ThunderClapRage",
	"OneHitWonder_Warrior_ShouldAutoExecute",
	"OneHitWonder_Warrior_UseSunderArmor",
	"OneHitWonder_Warrior_SunderArmorRage",
	"OneHitWonder_Warrior_ShouldOverpower",
	"OneHitWonder_Warrior_ShouldRevenge",
};

OneHitWonder_Warrior_SundersApplied = {};
OneHitWonder_Warrior_TargetSundersApplied = { numberOfTimesApplied = 0, timeApplied = 0 };

function OneHitWonder_Warrior_SetUseMortalStrike(toggle)
	OneHitWonder_Warrior_UseMortalStrike = toggle;
	OneHitWonder_SetOptions();
end

function OneHitWonder_Warrior_SetUseBloodthirst(toggle)
	OneHitWonder_Warrior_UseBloodthirst = toggle;
	OneHitWonder_SetOptions();
end

function OneHitWonder_Warrior_SetUseWhirlStrike(toggle)
	OneHitWonder_Warrior_UseWhirlStrike = toggle;
	OneHitWonder_SetOptions();
end

function OneHitWonder_Warrior_SetUseBattleShout(toggle)
	OneHitWonder_Warrior_UseBattleShout = toggle;
	OneHitWonder_SetOptions();
end

function OneHitWonder_Warrior_SetUseBarserkerRage(toggle)
	OneHitWonder_Warrior_UseBerserkerRage = toggle;
	OneHitWonder_SetOptions();
end

function OneHitWonder_Warrior_SetUseRunningAbility(toggle)
	OneHitWonder_Warrior_UseRunningAbility = toggle;
	OneHitWonder_SetOptions();
end

function OneHitWonder_Warrior_SetUseSunderArmor(toggle, value)
	OneHitWonder_Warrior_UseSunderArmor = toggle;
	OneHitWonder_Warrior_SunderArmorRage = value;
	OneHitWonder_SetOptions();
end

function OneHitWonder_Warrior_SetHamstring(toggle, value)
	OneHitWonder_Warrior_UseHamstring = toggle;
	OneHitWonder_Warrior_HamstringTargetHPPercentage = value;
	OneHitWonder_SetOptions();
end

function OneHitWonder_Warrior_SetRend(toggle, value)
	OneHitWonder_Warrior_UseRend = toggle;
	OneHitWonder_Warrior_RendTargetHPPercentage = value;
	OneHitWonder_SetOptions();
end

function OneHitWonder_Warrior_HasShield()
	if ( DynamicData ) and ( DynamicData.item ) and ( DynamicData.item.getEquippedSlotInfo ) then
		local itemInfoMainHand = DynamicData.item.getEquippedSlotInfo(17);
		if ( itemInfoMainHand.itemType == ONEHITWONDER_ITEM_TYPE_SHIELD ) then
			return true;
		else
			return false;
		end
	else
		return true;
	end
end

function OneHitWonder_Warrior_GetShieldBash(unitName, spellName)
	local interruptId = -1;
	local abilityName = ONEHITWONDER_ABILITY_SHIELDBASH_NAME;
	if ( OneHitWonder_Warrior_UseShieldBash ~= 1 ) then
		abilityName = "";
	end
	if ( ( abilityName ) and ( OneHitWonder_TargetAliveEnemy() ) and
		(strlen(abilityName) > 0) ) then
		interruptId = OneHitWonder_GetSpellId(abilityName);
		if ( not OneHitWonder_IsSpellAvailable(interruptId) ) then
			abilityName = "";
			interruptId = -1;
		end
	end
	return interruptId, abilityName;
end


function OneHitWonder_TryToInterruptSpell_Warrior(unitName, spellName)
	local interruptId = -1;
	local abilityName = "";
	local stance = OneHitWonder_Warrior_GetStance();
	if ( stance == ONEHITWONDER_WARRIOR_STANCE_BATTLE ) then
		interruptId, abilityName = OneHitWonder_Warrior_GetShieldBash(unitName, spellName);
	elseif ( stance == ONEHITWONDER_WARRIOR_STANCE_DEFENSIVE ) then
		interruptId, abilityName = OneHitWonder_Warrior_GetShieldBash(unitName, spellName);
	elseif ( stance == ONEHITWONDER_WARRIOR_STANCE_AGGRESSIVE ) then
		local temp = ONEHITWONDER_ABILITY_PUMMEL_NAME;
		local tempId = OneHitWonder_GetSpellId(temp);
		if ( tempId > -1 ) and ( OneHitWonder_CheckIfUsableSpellId(tempId) ) then
			abilityName = temp;
			interruptId = tempId;
		end
	end
	return interruptId, abilityName;
end

function OneHitWonder_Warrior_SetUseShieldBash(toggle)
	OneHitWonder_Warrior_UseShieldBash = toggle;
	OneHitWonder_SetOptions();
end

function OneHitWonder_Warrior_SetUseHeroicStrike(toggle, value)
	OneHitWonder_Warrior_UseHeroicStrike = toggle;
	OneHitWonder_Warrior_HeroicStrikeRage = value;
	OneHitWonder_SetOptions();
end

function OneHitWonder_Warrior_SetUseDemoralizingShout(toggle, value)
	OneHitWonder_Warrior_UseDemoralizingShout = toggle;
	OneHitWonder_Warrior_DemoralizingShoutRage = value;
	OneHitWonder_SetOptions();
end

function OneHitWonder_Warrior_SetUseThunderClap(toggle, value)
	OneHitWonder_Warrior_UseThunderClap = toggle;
	OneHitWonder_Warrior_ThunderClapRage = value;
	OneHitWonder_SetOptions();
end

function OneHitWonder_Warrior_SetShouldAutoExecute(toggle)
	OneHitWonder_Warrior_ShouldAutoExecute = toggle;
	OneHitWonder_SetOptions();
end

function OneHitWonder_Warrior_Toggle_Execute()
	if ( OneHitWonder_Warrior_ShouldAutoExecute ~= 1 ) then
		OneHitWonder_Warrior_ShouldAutoExecute = 1;
		OneHitWonder_Print(ONEHITWONDER_WARRIOR_CHAT_EXECUTE_ENABLED);
	else
		OneHitWonder_Warrior_ShouldAutoExecute = 0;
		OneHitWonder_Print(ONEHITWONDER_WARRIOR_CHAT_EXECUTE_DISABLED);
	end
	OneHitWonder_Generic_CosmosUpdateCheckOnOff("COS_ONEHITWONDER_WARRIOR_USE_EXECUTE", OneHitWonder_Warrior_ShouldAutoExecute);
	OneHitWonder_SetOptions();
end

function OneHitWonder_Warrior_Cosmos()
	if ( Cosmos_RegisterConfiguration ) and ( Cosmos_UpdateValue ) then
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_WARRIOR_SEPARATOR",
			"SEPARATOR",
			TEXT(ONEHITWONDER_WARRIOR_SEPARATOR),
			TEXT(ONEHITWONDER_WARRIOR_SEPARATOR_INFO)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_WARRIOR_USE_BATTLESHOUT",
			"CHECKBOX",
			TEXT(ONEHITWONDER_WARRIOR_USE_BATTLESHOUT),
			TEXT(ONEHITWONDER_WARRIOR_USE_BATTLESHOUT_INFO),
			OneHitWonder_Warrior_SetUseBattleShout,
			OneHitWonder_Warrior_UseBattleShout
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_WARRIOR_USE_BERSRAGE",
			"CHECKBOX",
			TEXT(ONEHITWONDER_WARRIOR_USE_BERSRAGE),
			TEXT(ONEHITWONDER_WARRIOR_USE_BERSRAGE_INFO),
			OneHitWonder_Warrior_SetUseBarserkerRage,
			OneHitWonder_Warrior_UseBerserkerRage
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_WARRIOR_USE_MSTRIKE",
			"CHECKBOX",
			TEXT(ONEHITWONDER_WARRIOR_USE_MSTRIKE),
			TEXT(ONEHITWONDER_WARRIOR_USE_MSTRIKE_INFO),
			OneHitWonder_Warrior_SetUseMortalStrike,
			OneHitWonder_Warrior_UseMortalStrike
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_WARRIOR_USE_BLOODTHIRST",
			"CHECKBOX",
			TEXT(ONEHITWONDER_WARRIOR_USE_BLOODTHIRST),
			TEXT(ONEHITWONDER_WARRIOR_USE_BLOODTHIRST_INFO),
			OneHitWonder_Warrior_SetUseBloodthirst,
			OneHitWonder_Warrior_UseBloodthirst
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_WARRIOR_USE_WHIRL_STRIKE",
			"CHECKBOX",
			TEXT(ONEHITWONDER_WARRIOR_USE_WHIRL_STRIKE),
			TEXT(ONEHITWONDER_WARRIOR_USE_WHIRL_STRIKE_INFO),
			OneHitWonder_Warrior_SetUseWhirlStrike,
			OneHitWonder_Warrior_UseWhirlStrike
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_WARRIOR_USE_EXECUTE",
			"CHECKBOX",
			TEXT(ONEHITWONDER_WARRIOR_USE_EXECUTE),
			TEXT(ONEHITWONDER_WARRIOR_USE_EXECUTE_INFO),
			OneHitWonder_Warrior_SetShouldAutoExecute,
			OneHitWonder_Warrior_ShouldAutoExecute
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_WARRIOR_USE_RUNNING_ABILITY",
			"CHECKBOX",
			TEXT(ONEHITWONDER_WARRIOR_USE_RUNNING_ABILITY),
			TEXT(ONEHITWONDER_WARRIOR_USE_RUNNING_ABILITY_INFO),
			OneHitWonder_Warrior_SetUseRunningAbility,
			OneHitWonder_Warrior_UseRunningAbility
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_WARRIOR_USE_SUNDER_ARMOR",
			"BOTH",
			TEXT(ONEHITWONDER_WARRIOR_USE_SUNDER_ARMOR),
			TEXT(ONEHITWONDER_WARRIOR_USE_SUNDER_ARMOR_INFO),
			OneHitWonder_Warrior_SetUseSunderArmor,
			OneHitWonder_Warrior_UseSunderArmor,
			OneHitWonder_Warrior_SunderArmorRage,
			0, 
			100,
			"",
			1,
			1,
			TEXT(ONEHITWONDER_WARRIOR_USE_SUNDER_ARMOR_APPEND)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_WARRIOR_USE_SHIELD_BASH",
			"CHECKBOX",
			TEXT(ONEHITWONDER_WARRIOR_USE_SHIELD_BASH),
			TEXT(ONEHITWONDER_WARRIOR_USE_SHIELD_BASH_INFO),
			OneHitWonder_Warrior_SetUseShieldBash,
			OneHitWonder_Warrior_UseShieldBash
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_WARRIOR_USE_HEROIC_STRIKE",
			"BOTH",
			TEXT(ONEHITWONDER_WARRIOR_USE_HEROIC_STRIKE),
			TEXT(ONEHITWONDER_WARRIOR_USE_HEROIC_STRIKE_INFO),
			OneHitWonder_Warrior_SetUseHeroicStrike,
			OneHitWonder_Warrior_UseHeroicStrike,
			OneHitWonder_Warrior_HeroicStrikeRage,
			0,
			100,
			"",
			1,
			1,
			TEXT(ONEHITWONDER_WARRIOR_USE_HEROIC_STRIKE_APPEND)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_WARRIOR_USE_DEMORALIZING_SHOUT",
			"BOTH",
			TEXT(ONEHITWONDER_WARRIOR_USE_DEMORALIZING_SHOUT),
			TEXT(ONEHITWONDER_WARRIOR_USE_DEMORALIZING_SHOUT_INFO),
			OneHitWonder_Warrior_SetUseDemoralizingShout,
			OneHitWonder_Warrior_UseDemoralizingShout,
			OneHitWonder_Warrior_DemoralizingShoutRage,
			0,
			100,
			"",
			1,
			1,
			TEXT(ONEHITWONDER_WARRIOR_USE_DEMORALIZING_SHOUT_APPEND)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_WARRIOR_USE_THUNDER_CLAP",
			"BOTH",
			TEXT(ONEHITWONDER_WARRIOR_USE_THUNDER_CLAP),
			TEXT(ONEHITWONDER_WARRIOR_USE_THUNDER_CLAP_INFO),
			OneHitWonder_Warrior_SetUseThunderClap,
			OneHitWonder_Warrior_UseThunderClap,
			OneHitWonder_Warrior_ThunderClapRage,
			0,
			100,
			"",
			1,
			1,
			TEXT(ONEHITWONDER_WARRIOR_USE_THUNDER_CLAP_APPEND)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_WARRIOR_USE_REND",
			"BOTH",
			TEXT(ONEHITWONDER_WARRIOR_USE_REND),
			TEXT(ONEHITWONDER_WARRIOR_USE_REND_INFO),
			OneHitWonder_Warrior_SetRend,
			OneHitWonder_Warrior_UseRend,
			OneHitWonder_Warrior_RendTargetHPPercentage,
			0,
			100,
			"",
			1,
			1,
			"%"
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_WARRIOR_USE_HAMSTRING",
			"BOTH",
			TEXT(ONEHITWONDER_WARRIOR_USE_HAMSTRING),
			TEXT(ONEHITWONDER_WARRIOR_USE_HAMSTRING_INFO),
			OneHitWonder_Warrior_SetHamstring,
			OneHitWonder_Warrior_UseHamstring,
			OneHitWonder_Warrior_HamstringTargetHPPercentage,
			0,
			100,
			"",
			1,
			1,
			"%"
		);
	end
end

function OneHitWonder_Warrior_IsUnitRendable(unit)
	return OneHitWonder_CanAbilityAffectUnit(ONEHITWONDER_ABILITY_REND_NAME, unit);
end

local OneHitWonder_Warrior_Powerup_LastTime = 0;

function OneHitWonder_Warrior_Powerup(ability)
	local curTime = GetTime();
	if ( curTime - OneHitWonder_Warrior_Powerup_LastTime > 0.5 ) then
		OneHitWonder_ShowInfoMessage(string.format(ONEHITWONDER_WARRIOR_INFO_POWERING_UP_FORMAT, ability));
		OneHitWonder_Warrior_Powerup_LastTime = curTime;
	end
end

function OneHitWonder_Target_Changed_Warrior()
	TargetFrame.rendEnds = nil;
end

OneHitWonder_Warrior_RendDurationByRank = {
	[1] = 9,
	[2] = 12,
	[3] = 15,
	[4] = 18,
	[5] = 21,
	[6] = 21,
	[7] = 21,
};

function OneHitWonder_Warrior_RetrieveRendDuration()
	local spellId = DynamicData.spell.getHighestSpellId(ONEHITWONDER_ABILITY_REND_NAME);
	local spellInfo = DynamicData.spell.getSpellInfo(spellId);
	if ( spellInfo.name == ONEHITWONDER_ABILITY_REND_NAME ) and ( spellInfo.realRank ) then
		local dur = OneHitWonder_Warrior_RendDurationByRank[spellInfo.realRank];
		if ( dur ) then
			return dur;
		else
			return -1;
		end
	else
		return -1;
	end
end

OneHitWonder_Warrior_RendDuration = nil;

function OneHitWonder_Warrior_GetRendDuration()
	if ( not OneHitWonder_Warrior_RendDuration ) then
		OneHitWonder_Warrior_RendDuration = OneHitWonder_Warrior_RetrieveRendDuration();
	end
	return OneHitWonder_Warrior_RendDuration;
end

function OneHitWonder_Warrior_ShouldRendUnit(unit)
	if ( not OneHitWonder_CanAbilityAffectUnit(ONEHITWONDER_ABILITY_REND_NAME, unit) ) then
		return false;
	end
	if ( not OneHitWonder_HasTargetMyAbility(ONEHITWONDER_ABILITY_REND_NAME, ONEHITWONDER_ABILITY_REND_EFFECT) ) then
		return true;
	else
		return false;
	end
end

function OneHitWonder_Warrior_ShouldRendTarget()
	return OneHitWonder_Warrior_ShouldRendUnit("target");
end

OneHitWonder_Warrior_LastAbility = nil;

function OneHitWonder_Warrior_WasLastAbility(ability)
	if ( not OneHitWonder_Warrior_LastAbility ) or ( OneHitWonder_Warrior_LastAbility ~= ability ) then
		return false;
	else
		return true;
	end
end

OneHitWonder_Warrior_BattleShoutRageReservation = 0;
OneHitWonder_Warrior_BattleShoutStartRageReservation = 20;

function OneHitWonder_Warrior_BattleShoutRefresh()
	if ( OneHitWonder_Warrior_UseBattleShout ~= 1 ) then
		OneHitWonder_Warrior_BattleShoutRageReservation = 0;
		return false;
	end
	local spellId = 0;
	spellId = OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_BATTLESHOUT_NAME);
	if ( spellId <= -1 ) then
		OneHitWonder_Warrior_BattleShoutRageReservation = 0;
		return false;
	end
	local timeLeft = OneHitWonder_GetTimeLeft(ONEHITWONDER_ABILITY_BATTLESHOUT_TEXTURE);
	OneHitWonder_RageReservation = OneHitWonder_RageReservation - OneHitWonder_Warrior_BattleShoutRageReservation;
	OneHitWonder_Warrior_BattleShoutRageReservation = 0;
	if ( timeLeft < OneHitWonder_Warrior_BattleShoutStartRageReservation ) then
		if ( OneHitWonder_HasEnoughRage(ONEHITWONDER_ABILITY_BATTLESHOUT_NAME, true) ) then
			OneHitWonder_DebugPrint(format("Battleshout id = %d", spellId));
			if ( OneHitWonder_CastSpell(spellId, ONEHITWONDER_BOOK_TYPE_SPELL) ) then
				return true;
			end
		else
			OneHitWonder_DebugPrint("Not enough rage for BattleShout");
			OneHitWonder_DebugPrint("Allocating rage for BattleShout");
			OneHitWonder_Warrior_BattleShoutRageReservation = OneHitWonder_Warrior_BattleShoutStartRageReservation - timeLeft;
			local maxRageReserved = OneHitWonder_GetRageConsumption(ONEHITWONDER_ABILITY_BATTLESHOUT_NAME);
			if ( OneHitWonder_Warrior_BattleShoutRageReservation > maxRageReserved) then
				OneHitWonder_Warrior_BattleShoutRageReservation = maxRageReserved;
			end
			OneHitWonder_RageReservation = OneHitWonder_RageReservation + OneHitWonder_Warrior_BattleShoutRageReservation;
		end
	end
	return false;
end

function OneHitWonder_Warrior_ShouldHamstringTarget(ignoreHP)
	if ( not OneHitWonder_CanAbilityAffectUnit(ONEHITWONDER_ABILITY_HAMSTRING_NAME, "target") ) then
		return false;
	end
	if ( OneHitWonder_HasUnitEffect("target", nil, ONEHITWONDER_SLOW_EFFECTS) ) then
		return false;
	end
	local unitHPPercent = OneHitWonder_GetTargetHPPercentage();
	if ( OneHitWonder_WillUnitRunAway("target") ) 
		and ( ( ignoreHP ) or ( unitHPPercent <= OneHitWonder_Warrior_HamstringTargetHPPercentage ) ) then
		return true;
	else
		return false;
	end
end

function OneHitWonder_Warrior_TrySunderArmor()
	if ( OneHitWonder_Warrior_UseSunderArmor == 1 ) and ( OneHitWonder_Warrior_ShouldApplySunderArmor() ) then
		local currentRange = OneHitWonder_Warrior_GetCurrentRange();
		if (currentRange ~= ONEHITWONDER_WARRIOR_RANGE_MELEE ) then
			return false;
		end
		local ability = ONEHITWONDER_ABILITY_SUNDER_ARMOR_NAME;
		local targetHPPerc = OneHitWonder_GetTargetHPPercentage();
		if ( OneHitWonder_HasEnoughRage(ability, OneHitWonder_Warrior_SunderArmorRage) ) and
			( ( targetHPPerc > OneHitWonder_Warrior_SunderArmorHPPercentage ) or ( OneHitWonder_InBossMode() ) or ( OneHitWonder_UnitIsBossOrBetter("target") ) ) then
			if ( OneHitWonder_HasEnoughRage(ability) ) then
				if ( OneHitWonder_Warrior_ApplySunderArmor() ) then
					OneHitWonder_Warrior_LastAbility = ability;
					return true;
				end
			end
		end
	end
	return false;
end

function OneHitWonder_Warrior_TryRunning()
	local stance = OneHitWonder_Warrior_GetStance();
	if ( stance == ONEHITWONDER_WARRIOR_STANCE_BATTLE ) and ( OneHitWonder_Warrior_UseRunningAbility == 1 ) then
		local chargeId = OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_CHARGE_NAME);
		
		local chargeActionId = -1;
		if ( chargeId > -1 ) then
			chargeActionId = OneHitWonder_GetActionIdFromSpellId(chargeId, ONEHITWONDER_BOOK_TYPE_SPELL);
		end
		
		if ( chargeActionId > -1 ) and ( OneHitWonder_CanSpellAffectUnit(ONEHITWONDER_ABILITY_CHARGE_NAME, "target") ) then
			if ( OneHitWonder_CheckIfInRangeActionId(chargeActionId) ) then
				--Print("In range for Charge.");
				if ( OneHitWonder_CheckIfUsable(chargeActionId, chargeId, ONEHITWONDER_BOOK_TYPE_SPELL) ) then
					--Print("Charge!");
					if ( OneHitWonder_CastSpell(chargeId, ONEHITWONDER_BOOK_TYPE_SPELL) ) then
						OneHitWonder_Warrior_LastAbility = ONEHITWONDER_ABILITY_CHARGE_NAME;
						return true;
					end
				else
					--Print("Charge not available.");
					return false;
				end
			else
				--Print("Not in range for Charge.");
				local currentRange = OneHitWonder_Warrior_GetCurrentRange();
				if ( ( PlayerFrame.inCombat ~= 1 ) and (currentRange ~= ONEHITWONDER_WARRIOR_RANGE_MELEE) ) then
					--Print("Not in combat and not close enough - postponing attempt.");
					--Print("Range is "..currentRange);
					return false;
				end
			end
		else
			if ( OneHitWonder_CastSpell(chargeId, ONEHITWONDER_BOOK_TYPE_SPELL ) ) then
				OneHitWonder_Warrior_LastAbility = ONEHITWONDER_ABILITY_CHARGE_NAME;
				return true;
			end
		end
	end

	if ( stance == ONEHITWONDER_WARRIOR_STANCE_AGGRESSIVE ) and ( OneHitWonder_Warrior_UseRunningAbility == 1 ) then
		local interceptId = OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_INTERCEPT_NAME);
		
		local interceptActionId = -1;
		if ( interceptId > -1 ) then
			interceptActionId = OneHitWonder_GetActionIdFromSpellId(interceptId, ONEHITWONDER_BOOK_TYPE_SPELL);
		end
		
		if ( OneHitWonder_CanSpellAffectUnit(ONEHITWONDER_ABILITY_INTERCEPT_NAME, "target") ) then
			if ( interceptActionId > -1 ) then
				if ( OneHitWonder_CheckIfInRangeActionId(interceptActionId) ) then
					--Print("In range for Intercept.");
					if ( OneHitWonder_CheckIfUsable(interceptActionId, interceptId, ONEHITWONDER_BOOK_TYPE_SPELL) ) then
						--Print("Intercept!");
						if ( OneHitWonder_CastSpell(interceptId, ONEHITWONDER_BOOK_TYPE_SPELL) ) then
							OneHitWonder_Warrior_LastAbility = ONEHITWONDER_ABILITY_INTERCEPT_NAME;
							return true;
						end
					else
						--Print("Intercept not available.");
						return false;
					end
				else
					--Print("Not in range for Intercept.");
					local currentRange = OneHitWonder_Warrior_GetCurrentRange();
					if ( ( PlayerFrame.inCombat ~= 1 ) and (currentRange ~= ONEHITWONDER_WARRIOR_RANGE_MELEE) ) then
						--Print("Not in combat and not close enough - postponing attempt.");
						--Print("Range is "..currentRange);
						return false;
					end
				end
			else
				if ( OneHitWonder_CastSpell(interceptId, ONEHITWONDER_BOOK_TYPE_SPELL ) ) then
					OneHitWonder_Warrior_LastAbility = ONEHITWONDER_ABILITY_INTERCEPT_NAME;
					return true;
				end
			end
		end
	end
	return false;
end
	
function OneHitWonder_Warrior_TryHamstring()
	local stance = OneHitWonder_Warrior_GetStance();
	local unitHPPercent = OneHitWonder_GetTargetHPPercentage();
	if ( OneHitWonder_Warrior_UseHamstring == 1 ) 
		and ( stance ~= ONEHITWONDER_WARRIOR_STANCE_DEFENSIVE ) 
		and ( OneHitWonder_Warrior_ShouldHamstringTarget() ) then
		local currentRange = OneHitWonder_Warrior_GetCurrentRange();
		if (currentRange ~= ONEHITWONDER_WARRIOR_RANGE_MELEE ) then
			return false;
		end
		local spellId = OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_HAMSTRING_NAME);
		if ( spellId > -1 ) and ( not OneHitWonder_Warrior_WasLastAbility(ONEHITWONDER_ABILITY_HAMSTRING_NAME) ) then
			if ( OneHitWonder_HasEnoughRage(ONEHITWONDER_ABILITY_HAMSTRING_NAME, true) ) then
				if ( OneHitWonder_CastSpell(spellId, ONEHITWONDER_BOOK_TYPE_SPELL) ) then
					OneHitWonder_Warrior_LastAbility = ONEHITWONDER_ABILITY_HAMSTRING_NAME;
					OneHitWonder_ApplyMyAbilityToTarget(ONEHITWONDER_ABILITY_HAMSTRING_NAME, OneHitWonder_Warrior_GetDuration(ONEHITWONDER_ABILITY_HAMSTRING_NAME));
					return true;
				end
			else
				OneHitWonder_Warrior_Powerup(ONEHITWONDER_ABILITY_HAMSTRING_NAME);
				return false;
			end
		end
	end
end

function OneHitWonder_Warrior_TryRend()
	local unitHPPercent = OneHitWonder_GetTargetHPPercentage();
	if ( OneHitWonder_Warrior_UseRend == 1 ) and ( unitHPPercent >= OneHitWonder_Warrior_RendTargetHPPercentage ) then
		local stance = OneHitWonder_Warrior_GetStance();
		local currentRange = OneHitWonder_Warrior_GetCurrentRange();
		if (currentRange ~= ONEHITWONDER_WARRIOR_RANGE_MELEE ) then
			return false;
		end
		if ( stance ~= ONEHITWONDER_WARRIOR_STANCE_AGGRESSIVE ) then
			local ability = ONEHITWONDER_ABILITY_REND_NAME;
			local spellId = OneHitWonder_GetSpellId(ability);
			if ( spellId > -1 ) and ( OneHitWonder_Warrior_ShouldRendTarget() ) 
				and ( not OneHitWonder_Warrior_WasLastAbility(ability) ) then
				if ( OneHitWonder_HasEnoughRage(ability) ) then
					if ( OneHitWonder_CastSpell(spellId, ONEHITWONDER_BOOK_TYPE_SPELL) ) then
						OneHitWonder_Warrior_LastAbility = ability;
						OneHitWonder_ApplyMyAbilityToTarget(ability, OneHitWonder_Warrior_GetDuration(ability));
						return true;
					end
				else
					OneHitWonder_Warrior_Powerup(ability);
				end
			end
		end
	end	
end

function OneHitWonder_Warrior_TryThunderClap()
	local stance = OneHitWonder_Warrior_GetStance();
	if ( stance == ONEHITWONDER_WARRIOR_STANCE_BATTLE ) and ( OneHitWonder_Warrior_UseThunderClap == 1 ) and
		( ( OneHitWonder_InCombatWithMoreThanOneOpponent() ) or ( OneHitWonder_TargetAliveEnemy() ) ) then
		local currentRange = OneHitWonder_Warrior_GetCurrentRange();
		if (currentRange ~= ONEHITWONDER_WARRIOR_RANGE_MELEE ) and ( not OneHitWonder_InCombatWithMoreThanOneOpponent() ) then
			return false;
		end
		if ( not OneHitWonder_InCombatWithMoreThanOneOpponent() ) then
			if ( OneHitWonder_GetTargetHPPercentage() < 15 ) then
				return false;
			end
		end

		local ability = ONEHITWONDER_ABILITY_THUNDER_CLAP_NAME;
		local spellId = OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_THUNDER_CLAP_NAME);
		if ( spellId > -1 ) 
			and ( not OneHitWonder_HasUnitEffect("target", nil, ONEHITWONDER_ABILITY_THUNDER_CLAP_EFFECT) ) then
			if ( OneHitWonder_HasEnoughRage(ability, OneHitWonder_Warrior_ThunderClapRage) ) then
				if ( OneHitWonder_CastSpell(spellId, ONEHITWONDER_BOOK_TYPE_SPELL) ) then
					OneHitWonder_ApplyMyAbilityToTarget(ability, OneHitWonder_Warrior_GetDuration(ability));
					OneHitWonder_Warrior_LastAbility = ability;
					return true;
				end
			else
				OneHitWonder_Warrior_Powerup(ability);
			end
		end
	end
end

function OneHitWonder_Warrior_TryBerserkerRage()
	if ( not OneHitWonder_TargetAliveEnemy() ) then
		return false;
	end
	
	-- YZ: TODO: do we have to check for range here ? wasting rage distantly sometimes...
	-- local currentRange = OneHitWonder_Warrior_GetCurrentRange();
	-- if (currentRange ~= ONEHITWONDER_WARRIOR_RANGE_MELEE ) then
	-- 	return false;
	-- end
	
	local n = ONEHITWONDER_ABILITY_BERSRAGE_NAME;
	if ( OneHitWonder_Warrior_UseBerserkerRage == 1 ) then
		local id = OneHitWonder_GetSpellId(n);
		if ( OneHitWonder_IsSpellAvailable(id) ) then
			local ok = OneHitWonder_CastSpell(id);
			if ( ok ) then
				OneHitWonder_Warrior_LastAbility = n;
			end
			return ok;
		end
	end
	return false;
end

function OneHitWonder_Warrior_DoOverpower()
	if ( not OneHitWonder_TargetAliveEnemy() ) then
		return false;
	end
	local n = ONEHITWONDER_ABILITY_OVERPOWER_NAME;
	if ( OneHitWonder_Warrior_ShouldOverpower == 1 ) then
		local id = OneHitWonder_GetSpellId(n);
		if ( OneHitWonder_IsSpellAvailable(id) ) then
			local ok = OneHitWonder_CastSpell(id);
			if ( ok ) then
				OneHitWonder_Warrior_LastAbility = n;
			end
			return ok;
		end
	end
	return false;
end

function OneHitWonder_Warrior_DoRevenge()
	if ( not OneHitWonder_TargetAliveEnemy() ) then
		return false;
	end
	local n = ONEHITWONDER_ABILITY_REVENGE_NAME;
	if ( OneHitWonder_Warrior_ShouldRevenge == 1 ) then
		local id = OneHitWonder_GetSpellId(n);
		if ( OneHitWonder_IsSpellAvailable(id) ) then
			local ok = OneHitWonder_CastSpell(id);
			if ( ok ) then
				OneHitWonder_Warrior_LastAbility = n;
			end
			return ok;
		end
	end
	return false;
end


function OneHitWonder_Warrior_TryDemoralizingShout()
	if ( OneHitWonder_Warrior_UseDemoralizingShout == 1 ) and 
		( ( OneHitWonder_InCombatWithMoreThanOneOpponent() ) or ( OneHitWonder_TargetAliveEnemy() ) ) then
		local ability = ONEHITWONDER_ABILITY_DEMORALIZING_SHOUT_NAME;
		local spellId = OneHitWonder_GetSpellId(ability);
		local currentRange = OneHitWonder_Warrior_GetCurrentRange();
		if (currentRange ~= ONEHITWONDER_WARRIOR_RANGE_MELEE ) and ( not OneHitWonder_InCombatWithMoreThanOneOpponent() ) then
			return false;
		end
		if ( spellId > -1 ) 
		and ( not OneHitWonder_HasUnitEffect("target", nil, ONEHITWONDER_ABILITY_DEMORALIZING_SHOUT_EFFECT) )
		then
			if ( OneHitWonder_HasEnoughRage(ability, OneHitWonder_Warrior_DemoralizingShoutRage) ) then
				if ( OneHitWonder_CastSpell(spellId, ONEHITWONDER_BOOK_TYPE_SPELL) ) then
					OneHitWonder_ApplyMyAbilityToTarget(ability, OneHitWonder_Warrior_GetDuration(ability));
					OneHitWonder_Warrior_LastAbility = ability;
					return true;
				end
			else
				OneHitWonder_Warrior_Powerup(ability);
			end
		end
	end
end

function OneHitWonder_Warrior_TryMortalStrike()
	if ( OneHitWonder_Warrior_UseMortalStrike == 1 ) then
		local currentRange = OneHitWonder_Warrior_GetCurrentRange();
		if (currentRange ~= ONEHITWONDER_WARRIOR_RANGE_MELEE ) then
			return false;
		end
		local ability = ONEHITWONDER_ABILITY_MORTAL_STRIKE_NAME;
		local spellId = OneHitWonder_GetSpellId(ability);
		if ( spellId > -1 ) then
			if ( OneHitWonder_HasEnoughRage(ability, OneHitWonder_Warrior_MortalStrikeRage) ) then
				if ( OneHitWonder_CastSpell(spellId, ONEHITWONDER_BOOK_TYPE_SPELL) ) then
					OneHitWonder_Warrior_LastAbility = ability;
					return true;
				end
			else
				OneHitWonder_Warrior_Powerup(ability);
			end
		end
	end
end

function OneHitWonder_Warrior_TryBloodthirst()
	if ( OneHitWonder_Warrior_UseBloodthirst == 1 ) then
		local currentRange = OneHitWonder_Warrior_GetCurrentRange();
		if (currentRange ~= ONEHITWONDER_WARRIOR_RANGE_MELEE ) then
			return false;
		end
		local ability = ONEHITWONDER_ABILITY_BLOODTHIRST_NAME;
		local spellId = OneHitWonder_GetSpellId(ability);
		if ( spellId > -1 ) then
			if ( OneHitWonder_HasEnoughRage(ability, OneHitWonder_Warrior_BloodthirstRage) ) then
				if ( OneHitWonder_CastSpell(spellId, ONEHITWONDER_BOOK_TYPE_SPELL) ) then
					OneHitWonder_Warrior_LastAbility = ability;
					return true;
				end
			else
				OneHitWonder_Warrior_Powerup(ability);
			end
		end
	end
end

function OneHitWonder_Warrior_TryWhirlStrike()
	if ( OneHitWonder_Warrior_UseWhirlStrike == 1 ) then
		local currentRange = OneHitWonder_Warrior_GetCurrentRange();
		if (currentRange ~= ONEHITWONDER_WARRIOR_RANGE_MELEE ) then
			return false;
		end
		local ability = ONEHITWONDER_ABILITY_WHIRL_STRIKE_NAME;
		local spellId = OneHitWonder_GetSpellId(ability);
		if ( spellId > -1 ) then
			if ( OneHitWonder_HasEnoughRage(ability, OneHitWonder_Warrior_MortalStrikeRage) ) then
				if ( OneHitWonder_CastSpell(spellId, ONEHITWONDER_BOOK_TYPE_SPELL) ) then
					OneHitWonder_Warrior_LastAbility = ability;
					return true;
				end
			else
				OneHitWonder_Warrior_Powerup(ability);
			end
		end
	end
end

function OneHitWonder_Warrior_TryHeroicStrike()
	if ( OneHitWonder_Warrior_UseHeroicStrike == 1 ) then
		local currentRange = OneHitWonder_Warrior_GetCurrentRange();
		if (currentRange ~= ONEHITWONDER_WARRIOR_RANGE_MELEE ) then
			return false;
		end
		local ability = ONEHITWONDER_ABILITY_HEROICSTRIKE_NAME;
		local spellId = OneHitWonder_GetSpellId(ability);
		if ( spellId > -1 ) then
			if ( OneHitWonder_HasEnoughRage(ability, OneHitWonder_Warrior_HeroicStrikeRage) ) then
				if ( OneHitWonder_CastSpell(spellId, ONEHITWONDER_BOOK_TYPE_SPELL) ) then
					OneHitWonder_Warrior_LastAbility = ability;
					return true;
				end
			else
				OneHitWonder_Warrior_Powerup(ability);
			end
		end
	end
end

function OneHitWonder_Warrior_TryBattleShout() 
	if ( OneHitWonder_Warrior_BattleShoutRefresh() ) then
		OneHitWonder_Warrior_LastAbility = ONEHITWONDER_ABILITY_BATTLESHOUT_NAME;
		OneHitWonder_Warrior_Powerup(ONEHITWONDER_ABILITY_BATTLESHOUT_NAME);
		return true;
	end
end

function OneHitWonder_Warrior_TryMeleeAttack()
	OneHitWonder_MeleeAttack();
	return false;
end

OneHitWonder_Warrior_FuncRageList = {
	{ func = OneHitWonder_Warrior_TryRunning, rageIndex = ONEHITWONDER_ABILITY_CHARGE_NAME, prio = 100 },
	{ func = OneHitWonder_Warrior_TryMeleeAttack, rage = 0, prio = 99 },
	{ func = OneHitWonder_Warrior_TryMortalStrike, rageIndex = ONEHITWONDER_ABILITY_MORTAL_STRIKE_NAME, prio = 98 },
	{ func = OneHitWonder_Warrior_TryBloodthirst, rageIndex = ONEHITWONDER_ABILITY_BLOODTHIRST_NAME, prio = 98 },
	{ func = OneHitWonder_Warrior_TryHamstring, rageIndex = ONEHITWONDER_ABILITY_HAMSTRING_NAME, prio = 97 },
	{ func = OneHitWonder_Warrior_TryBerserkerRage, rageIndex = ONEHITWONDER_ABILITY_BERSRAGE_NAME, prio = 99 },
	{ func = OneHitWonder_Warrior_TryBattleShout, rageIndex = ONEHITWONDER_ABILITY_BATTLESHOUT_NAME, prio = 96 },
	{ func = OneHitWonder_Warrior_TryRend, rageIndex = ONEHITWONDER_ABILITY_REND_NAME, prio = 95 },
	{ func = OneHitWonder_Warrior_TryWhirlStrike, rageIndex = ONEHITWONDER_ABILITY_WHIRL_STRIKE_NAME, prio = 98 },
	{ func = OneHitWonder_Warrior_TryDemoralizingShout, rage = OneHitWonder_Warrior_DemoralizingShoutRage },
	{ func = OneHitWonder_Warrior_TryThunderClap, rage = OneHitWonder_Warrior_ThunderClapRage },
	{ func = OneHitWonder_Warrior_TrySunderArmor, rage = OneHitWonder_Warrior_SunderArmorRage },
	{ func = OneHitWonder_Warrior_TryHeroicStrike, rage = OneHitWonder_Warrior_HeroicStrikeRage },
};

function OneHitWonder_Warrior_Setup_Sort(item1, item2)
	if ( item1 ) and ( item2 ) then
		if ( item1.prio ) and ( item2.prio ) then
			if ( item1.prio > item2.prio ) then
				return true;
			elseif( item1.prio < item2.prio ) then
				return false;
			else
				return true;
			end
		elseif( item1.prio ) then
			return true;
		elseif( item2.prio ) then
			return false;
		end
		local item1rage, item2rage = nil, nil;
		if ( item1.rage ) then item1rage = item1.rage; end
		if ( item2.rage ) then item2rage = item2.rage; end
		if ( item1.rageIndex ) then item1rage = OneHitWonder_GetRageConsumption(item1.rageIndex); end
		if ( item2.rageIndex ) then item2rage = OneHitWonder_GetRageConsumption(item2.rageIndex); end
		if ( item1rage > item2rage ) then
			return true;
		elseif( item1rage < item2rage ) then
			return false;
		else
			return true;
		end
	elseif ( item1 ) then
		return true;
	elseif ( item2 ) then
		return false;
	else
		return true;
	end
end

function OneHitWonder_Warrior_Setup()
	table.sort(OneHitWonder_Warrior_FuncRageList, OneHitWonder_Warrior_Setup_Sort);
end

function OneHitWonder_DoStuffContinuously_Warrior()
	if ( OneHitWonder_InitiateCombat == 0 ) and ( not OneHitWonder_IsInCombat() ) then
		return false;
	end
	if ( OneHitWonder_Warrior_DoOverpower() ) then
		return true;
	end
	if ( OneHitWonder_Warrior_DoRevenge() ) then
		return true;
	end
end

function OneHitWonder_Warrior_EquipMostDamagingWeapon()
	-- TODO: finish this
	if ( CursorHasItem() ) then
		return false;
	end
	local itemInfoMainHand = DynamicData.item.getEquippedSlotInfo(16);
	local itemInfoOffHand = DynamicData.item.getEquippedSlotInfo(17);
	-- basically, find most damaging weapon
	local weapons = {};
	local list = nil;
	for k, v in ONEHITWONDER_ITEM_TYPE_WEAPONS_LIST do
		list = DynamicData.item.getItemInfoByType(v);
		for key, value in list do 
			table.insert(weapons, value);
		end
	end
	if ( getn(weapons) > 0 ) then
		local itemInfo = OneHitWonder_FindMostDamagingWeapon(weapons);
		-- already got the most damaging weapon in our hand?
		if ( itemInfo.name == itemInfoMainHand.name ) then
			return false;
		elseif ( itemInfo.name == itemInfoOffHand.name ) then
			-- TODO: fix it so that it gets put in mainhand and switch back
			return false;
		end
		-- TODO: equip most damaging weapon
		return false;
	end
	-- TODO: make sure weapons will be switched back
	return false;
end



function OneHitWonder_Warrior(removeDefense)
	local targetName = UnitName("target");

	if ( OneHitWonder_IsChannelSpellRunning() ) or ( OneHitWonder_IsRegularSpellRunning() ) then
		return false;
	end
	
	if ( OneHitWonder_HandleActionQueue() ) then
		return true;
	end

	if ( (not targetName) or ( strlen(targetName) <= 0 ) ) then
		if ( not OneHitWonder_Warrior_BattleShoutRefresh() ) then
			if ( OneHitWonder_ShouldOverrideBindings == 0 ) then
				return OneHitWonder_DoStuffContinuously();
			end
		else
			return true;
		end
		return false;
	end
	
	if ( not removeDefense ) then removeDefense = false; end
	
	if (not OneHitWonder_StartCombat()) then 
		return false
	end
	
	if ( OneHitWonder_Warrior_DoOverpower() ) then
		return true;
	end

	if ( OneHitWonder_Warrior_DoRevenge() ) then
		return true;
	end

	local stance = OneHitWonder_Warrior_GetStance();

	OneHitWonder_DebugPrint(format("Current stance = %d", stance));
	
	local entry = nil;
	for i = 1, table.getn(OneHitWonder_Warrior_FuncRageList) do
		entry = OneHitWonder_Warrior_FuncRageList[i];
		if ( entry.func ) and ( entry.func() ) then
			return true;
		end
	end
	
	return false;
end


function OneHitWonder_Warrior_GetStance()
	local numForms = GetNumShapeshiftForms();
	local texture, name, isActive, isCastable;
	local button, icon, cooldown;
	local start, duration, enable;
	for i=1, NUM_SHAPESHIFT_SLOTS do
		if ( i <= numForms ) then
			texture, name, isActive, isCastable = GetShapeshiftFormInfo(i);
			if ( isActive ) then
				if ( name == ONEHITWONDER_WARRIOR_STANCE_BATTLE_NAME ) then
					return ONEHITWONDER_WARRIOR_STANCE_BATTLE;
				elseif ( name == ONEHITWONDER_WARRIOR_STANCE_DEFENSIVE_NAME ) then
					return ONEHITWONDER_WARRIOR_STANCE_DEFENSIVE;
				elseif ( name == ONEHITWONDER_WARRIOR_STANCE_AGGRESSIVE_NAME ) then
					return ONEHITWONDER_WARRIOR_STANCE_AGGRESSIVE;
				else
					return -1;
				end
			end
		end
	end
	return -1;
end

ONEHITWONDER_WARRIOR_RANGE_UNKNOWN = 0;
ONEHITWONDER_WARRIOR_RANGE_MELEE = 1;
ONEHITWONDER_WARRIOR_RANGE_CHARGE = 2;
ONEHITWONDER_WARRIOR_RANGE_RANGED = 3;
ONEHITWONDER_WARRIOR_RANGE_BEYOND = 4;

function OneHitWonder_Warrior_GetCurrentRange()
	-- YZ: stance check removed, since we are not fighting in Battle stance only :)
	-- local stance = OneHitWonder_Warrior_GetStance();
	-- if ( stance == ONEHITWONDER_WARRIOR_STANCE_BATTLE ) then
	if ( 1 ) then
		local chargeId = OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_CHARGE_NAME);
		local rangedId = -1; --OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_SHOOT_NAME);
		local meleeRangeId = OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_REND_NAME);
		if ( meleeRangeId <= -1 ) then OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_HAMSTRING_NAME); end

		if ( not OneHitWonder_CheckIfInRangeSpellId(chargeId) ) then
			if (not OneHitWonder_CheckIfInRangeSpellId(meleeRangeId)) then
				if ( rangedId > -1 ) then
					if (not OneHitWonder_CheckIfInRangeSpellId(rangedId)) then
						return ONEHITWONDER_WARRIOR_RANGE_BEYOND;
					else
						return ONEHITWONDER_WARRIOR_RANGE_RANGED;
					end
				else
					return ONEHITWONDER_WARRIOR_RANGE_BEYOND;
				end
			else
				return ONEHITWONDER_WARRIOR_RANGE_MELEE;
			end
		else
			return ONEHITWONDER_WARRIOR_RANGE_CHARGE;
		end
	end
	return ONEHITWONDER_WARRIOR_RANGE_UNKNOWN;
end



function OneHitWonder_GetBlockCounter_Warrior()
	return OneHitWonder_GetWarriorBlockDodgeParryCounter();
end

function OneHitWonder_GetDodgeCounter_Warrior()
	return OneHitWonder_GetWarriorBlockDodgeParryCounter();
end

function OneHitWonder_GetParryCounter_Warrior()
	return OneHitWonder_GetWarriorBlockDodgeParryCounter();
end

function OneHitWonder_GetTargetDodgeCounter_Warrior()
	local counterId = -1;
	local abilityName = "";
	local stance = OneHitWonder_Warrior_GetStance();
	if ( stance == ONEHITWONDER_WARRIOR_STANCE_BATTLE ) then
		local temp = ONEHITWONDER_ABILITY_OVERPOWER_NAME;
		local tempId = OneHitWonder_GetSpellId(temp);
		if ( tempId > -1 ) and ( OneHitWonder_CheckIfUsableSpellId(tempId) ) then
			abilityName = temp;
			counterId = tempId;
		end
	elseif ( stance == ONEHITWONDER_WARRIOR_STANCE_DEFENSIVE ) then
	elseif ( stance == ONEHITWONDER_WARRIOR_STANCE_AGGRESSIVE ) then
	end
	return counterId, abilityName;
end



function OneHitWonder_GetWarriorBlockDodgeParryCounter()
	local counterId = -1;
	local abilityName = "";
	local stance = OneHitWonder_Warrior_GetStance();
	if ( stance == ONEHITWONDER_WARRIOR_STANCE_BATTLE ) then
	elseif ( stance == ONEHITWONDER_WARRIOR_STANCE_DEFENSIVE ) then
		local temp = ONEHITWONDER_ABILITY_REVENGE_NAME;
		local tempId = OneHitWonder_GetSpellId(temp);
		if ( tempId > -1 ) and ( OneHitWonder_CheckIfUsableSpellId(tempId) ) then
			abilityName = temp;
			counterId = tempId;
		end
	elseif ( stance == ONEHITWONDER_WARRIOR_STANCE_AGGRESSIVE ) then
	end
	return counterId, abilityName;
end


-- Retrieves the current number of armor sundered from a tooltip strings.
function OneHitWonder_Warrior_RetrieveCurrentSunderedArmor(strings)
	local index = nil;
	local tmpStr = nil;
	local armor = nil;
	for k, v in strings do 
		if (v.left) then
			index = strfind(v.left, ONEHITWONDER_ABILITY_SUNDER_ARMOR_TOOLTIP);
			if ( index ) then
				index = index + strlen(ONEHITWONDER_ABILITY_SUNDER_ARMOR_TOOLTIP);
				tmpStr = strsub(v.left, index);
				armor = findpattern(tmpStr, ONEHITWONDER_ABILITY_SUNDER_ARMOR_NUMBER_STRING);
				if ( armor ) then
					return armor;
				else
					tmpStr = strings[k+1];
					if ( tmpStr ) then
						armor = findpattern(tmpStr.left, ONEHITWONDER_ABILITY_SUNDER_ARMOR_NUMBER_STRING); 
						if ( armor ) then
							return armor;
						end
					end
				end
			end
		end
	end
	return 0;
end

-- what this does is check the mouseover and see if our current sunder can be the one that 
-- caused the sundered effect on the poor unit (if any). It does this by checking how much armor 
-- we can sunder and how much armor is currently sundered (I don't know if that tooltip is visible)
-- and dividing the two values. If we end up with a value that is "not allowed", 
-- then we check for another effect (since 2 warriors generate two sunder armor effects AFAIK).
function OneHitWonder_Warrior_RetrieveCurrentSunderNumber(unit, index)
	local effectInfos = DynamicData.effect.getEffectInfos(unit);
	local tmpEffectInfo = nil;
	local effectInfo = nil;
	if ( not index ) then index = 1; end
	local j = 1;
	local i = index;
	while ( i > 1 ) do
		tmpEffectInfo = effectInfos.buffs[j];
		if ( tmpEffectInfo ) then
			if ( tmpEffectInfo.name == ONEHITWONDER_ABILITY_SUNDER_ARMOR_EFFECT ) then
				effectInfo = tmpEffectInfo;
				i = i - 1;
			end
		end
		j = j + 1;
	end
	if ( effectInfo ) and ( effectInfo.name == ONEHITWONDER_ABILITY_SUNDER_ARMOR_EFFECT ) then
		local appliedValue = 1;
		
		local sunderValue = OneHitWonder_Warrior_RetrieveCurrentSunderedArmor(effectInfo.strings);
		if ( sunderValue > 0 ) then
			local spellId = OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_SUNDER_ARMOR_NAME, ONEHITWONDER_BOOK_TYPE_SPELL);
			local spellInfo = DynamicData.spell.getSpellInfo(spellId, ONEHITWONDER_BOOK_TYPE_SPELL);
			if ( spellInfo ) then
				local armorPerSunder = ONEHITWONDER_ABILITY_SUNDER_ARMOR[spellInfo.realRank];
				local numberOfTimesApplied = ( sunderValue / armorPerSunder );
				if ( numberOfTimesApplied > ONEHITWONDER_MAXIMUM_NUMBER_OF_SUNDERS ) then
					if ( i <= 0 ) then
						return OneHitWonder_Warrior_RetrieveCurrentSunderNumber(unit, index + 1);
					end
				elseif ( numberOfTimesApplied < 0 ) then
					if ( i <= 0 ) then
						return OneHitWonder_Warrior_RetrieveCurrentSunderNumber(unit, index + 1);
					end
				elseif ( math.floor(numberOfTimesApplied) ~= numberOfTimesApplied  ) then
					if ( i <= 0 ) then
						return OneHitWonder_Warrior_RetrieveCurrentSunderNumber(unit, index + 1);
					end
				end
				appliedValue = numberOfTimesApplied;
			end
		end
		
		return appliedValue;
	else
		return 0;
	end
end

function OneHitWonder_Warrior_ApplySunderArmor()
	local curTime = GetTime();
	if ( not OneHitWonder_Warrior_TargetSundersApplied.timeApplied ) or ( OneHitWonder_Warrior_TargetSundersApplied.timeApplied < curTime ) then
		OneHitWonder_Warrior_TargetSundersApplied.numberOfTimesApplied = OneHitWonder_Warrior_RetrieveCurrentSunderNumber("target");
	end
	if ( OneHitWonder_HasEnoughRage(ONEHITWONDER_ABILITY_SUNDER_ARMOR_NAME) ) then
		local spellId = 0;
		spellId = OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_SUNDER_ARMOR_NAME, ONEHITWONDER_BOOK_TYPE_SPELL);
		if ( OneHitWonder_IsSpellAvailable(spellId, ONEHITWONDER_BOOK_TYPE_SPELL) ) and ( OneHitWonder_CastSpell(spellId, ONEHITWONDER_BOOK_TYPE_SPELL) ) then
		else
			return false;
		end
		OneHitWonder_Warrior_LastAbility = ONEHITWONDER_ABILITY_SUNDER_ARMOR_NAME;
	else
		return false;
	end
	if ( not OneHitWonder_Warrior_TargetSundersApplied.numberOfTimesApplied ) then
		OneHitWonder_Warrior_TargetSundersApplied.numberOfTimesApplied = 1;
	else
		OneHitWonder_Warrior_TargetSundersApplied.numberOfTimesApplied = OneHitWonder_Warrior_TargetSundersApplied.numberOfTimesApplied + 1;
	end
	if ( OneHitWonder_Warrior_TargetSundersApplied.numberOfTimesApplied > ONEHITWONDER_MAXIMUM_NUMBER_OF_SUNDERS ) then
		OneHitWonder_Warrior_TargetSundersApplied.numberOfTimesApplied = ONEHITWONDER_MAXIMUM_NUMBER_OF_SUNDERS;
	end
	OneHitWonder_Warrior_TargetSundersApplied.timeApplied = curTime;
	return true;
end

-- place any nice logic here
function OneHitWonder_Warrior_GetNumberOfSundersToApply(unit)
	return ONEHITWONDER_MAXIMUM_NUMBER_OF_SUNDERS;
end

function OneHitWonder_Warrior_ShouldApplySunderArmor()
	if ( not OneHitWonder_CanAbilityAffectUnit(ONEHITWONDER_ABILITY_SUNDER_ARMOR_NAME, "target") ) then
		return false;
	end
	local data = OneHitWonder_Warrior_TargetSundersApplied;
	if ( data.numberOfTimesApplied < OneHitWonder_Warrior_GetNumberOfSundersToApply() ) then
		return true;
	end
	local curTime = GetTime();
	-- if the effect expires within 5 seconds, suggest that we reapply it
	if ( data.timeApplied < ( curTime + 5 ) ) then
		return true;
	else
		return false;
	end
end

-- is it this advanced?
function OneHitWonder_Warrior_CleanSunderArmors()
	local unitName = UnitName("target");
	if ( not OneHitWonder_Warrior_SundersApplied[unitName] ) then
		OneHitWonder_Warrior_SundersApplied[unitName] = {};
		return;
	end
	local i = 1;
	local data = nil;
	local curTime = GetTime();
	while ( i < table.getn(OneHitWonder_Warrior_SundersApplied[unitName] ) ) do
		data = OneHitWonder_Warrior_SundersApplied[unitName][i];
		if ( data ) then
			if ( data.time < curTime ) then
				table.remove(OneHitWonder_Warrior_SundersApplied[unitName], i);
			else
				i = i + 1;
			end
		else
			break;
		end
	end
end

function OneHitWonder_UnitHealthCheck_Warrior(unit)

	-- Do the execute check.
	if ( PlayerFrame.inCombat == 1 ) and (( OneHitWonder_HasTarget() ) and ( UnitCanAttack("target", "player") ) and ( unit == "target" ) ) then
		local unitHPPercent = OneHitWonder_GetTargetHPPercentage();
		local stance = OneHitWonder_Warrior_GetStance();

		--Do the Execute Holler. 
		if ( unitHPPercent <= 20 ) then	
			if ( stance ~= ONEHITWONDER_WARRIOR_STANCE_DEFENSIVE ) then
				if ( OneHitWonder_HasEnoughRage(ONEHITWONDER_ABILITY_EXECUTE_NAME, true) ) then
					local spellId = OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_EXECUTE_NAME);
					if ( spellId > -1 ) and ( OneHitWonder_IsSpellAvailable(spellId) ) then
						if ( OneHitWonder_Warrior_ExecuteHollered == 0 ) then
							OneHitWonder_ShowImperativeMessage(ONEHITWONDER_ABILITY_EXECUTE_NAME);
							OneHitWonder_Warrior_ExecuteHollered = 1;
						end
						if ( OneHitWonder_Warrior_ShouldAutoExecute == 1 ) then
							local parameters = { spellId, "target", ( GetTime() + 2 ) };
							OneHitWonder_AddActionToQueue(ONEHITWONDER_ACTIONID_SPELL_TARGET, parameters);
						end
						return;
						--local spellId = 0;
						--spellId = OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_EXECUTE_NAME);
						--if ( OneHitWonder_CastSpell(spellId, ONEHITWONDER_BOOK_TYPE_SPELL) ) then
						--	return;
						--end
					end
				end
			end
		else
			OneHitWonder_Warrior_ExecuteHollered = 0;
		end
	end
end

function OneHitWonder_Target_Changed_Warrior()
	local unitName = UnitName("target");

	local curTime = GetTime();
	OneHitWonder_Warrior_TargetSundersApplied.numberOfTimesApplied = OneHitWonder_Warrior_RetrieveCurrentSunderNumber("target");
	OneHitWonder_Warrior_TargetSundersApplied.timeApplied = curTime;
	OneHitWonder_Warrior_ExecuteHollered = 0;
	--OneHitWonder_Warrior_SundersApplied[unitName] = {};

end

function OneHitWonder_Warrior_GetDuration(ability)
	if ( ability == ONEHITWONDER_ABILITY_DEMORALIZING_SHOUT_NAME ) then
		return OneHitWonder_Ability_Demoralizing_Shout_Duration;
	elseif ( ability == ONEHITWONDER_ABILITY_HAMSTRING_NAME ) then
		return OneHitWonder_Ability_Hamstring_Duration;
	elseif ( ability == ONEHITWONDER_ABILITY_REND_NAME ) then
		return OneHitWonder_Warrior_GetRendDuration();
	elseif ( ability == ONEHITWONDER_ABILITY_SUNDER_ARMOR_NAME ) then
		return 30;
	elseif ( ability == ONEHITWONDER_ABILITY_THUNDER_CLAP_NAME ) then
		return OneHitWonder_Ability_Thunder_Clap_Duration;
	else
		return -1;
	end
end

OneHitWonder_Warrior_Talent_ShoutDurationIncreaseTab = 2;
OneHitWonder_Warrior_Talent_ShoutDurationIncreaseTalent = 1;

function OneHitWonder_OnEvent_Warrior(event)
	if ( event == "VARIABLES_LOADED" ) then
		OneHitWonder_TalentPointsUpdated_Warrior();
	end
end

function OneHitWonder_TalentPointsUpdated_Warrior()
	OneHitWonder_UpdateRageConsumptionWithTalents("ONEHITWONDER_ABILITY_RAGECOST", ONEHITWONDER_WARRIOR_TALENT_RAGE_REDUCERS);
	local name, _, tier, column, rank, maxRank = GetTalentInfo(OneHitWonder_Warrior_Talent_ShoutDurationIncreaseTab, OneHitWonder_Warrior_Talent_ShoutDurationIncreaseTalent);
	local modifier = 1;
	if ( rank > 0 ) then
		modifier = 1+(rank/10);
	end
	OneHitWonder_Ability_Demoralizing_Shout_Duration = ONEHITWONDER_ABILITY_DEMORALIZING_SHOUT_DURATION_BASE*modifier;
	OneHitWonder_Warrior_Setup();
end


function OneHitWonder_TargetIsRunningAway_Warrior()
	if ( OneHitWonder_Warrior_FleeingMobStrategy == 1 ) then
		if ( OneHitWonder_Warrior_UseHamstring == 1 ) 
			and ( stance ~= ONEHITWONDER_WARRIOR_STANCE_DEFENSIVE ) 
			and ( OneHitWonder_Warrior_ShouldHamstringTarget() )
			and ( not OneHitWonder_HasUnitEffect("target", nil, ONEHITWONDER_SLOW_EFFECTS) )
			then
			local spellId = OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_HAMSTRING_NAME);
			if ( spellId > -1 ) then
				if ( OneHitWonder_HasEnoughRage(ONEHITWONDER_ABILITY_HAMSTRING_NAME, true) ) then
					local parameters = { spellId, GetTime() + 3};
					OneHitWonder_AddActionToQueue(ONEHITWONDER_ACTIONID_SPELL_TIMEOUT, parameters);
					OneHitWonder_ApplyMyAbilityToTarget(ONEHITWONDER_ABILITY_HAMSTRING_NAME, OneHitWonder_Warrior_GetDuration(ONEHITWONDER_ABILITY_HAMSTRING_NAME));
					return true;
				end
			end
		end
	elseif ( OneHitWonder_Warrior_FleeingMobStrategy == 2 ) then
		-- go into zerker mode
		-- charge
	end
	return false;
end
