ONEHITWONDER_WARLOCK_CURSE_EFFECTS = {
	ONEHITWONDER_EFFECT_CURSE_AGONY,
	ONEHITWONDER_EFFECT_CURSE_TONGUES,
	ONEHITWONDER_EFFECT_CURSE_RECKLESSNESS,
	ONEHITWONDER_EFFECT_CURSE_WEAKNESS
};

-- updated with new patch values
ONEHITWONDER_WARLOCK_CURSE_TIMES = {
	[ONEHITWONDER_SPELL_CURSE_AGONY] = 30,
	[ONEHITWONDER_SPELL_CURSE_DOOM] = 1*60,
	[ONEHITWONDER_SPELL_CURSE_ELEMENTS] = 5*60,	
	[ONEHITWONDER_SPELL_CURSE_RECKLESSNESS] = 5*60,
	[ONEHITWONDER_SPELL_CURSE_TONGUES] = 30,
	[ONEHITWONDER_SPELL_CURSE_WEAKNESS] = 2*60
};

OneHitWonder_Warlock_UseNewMinimizeAggroPvE = 1;

OneHitWonder_Warlock_ShadowBurnPercentage = 2;
OneHitWonder_Warlock_SoulDrainPercentage = 20;
OneHitWonder_Warlock_ShardCount = 0;
OneHitWonder_Warlock_MinimumShards = 5;
OneHitWonder_Warlock_ImmolateIfTargetPercentage = 50;
OneHitWonder_Warlock_ImmolateIfSelfPercentage = 30;
OneHitWonder_Warlock_PreferFire = 0;
OneHitWonder_Warlock_UseSearingPain = 0;
OneHitWonder_Warlock_UseWand = 1;

OneHitWonder_Warlock_ShouldReactiveCastShadowWard = 1;

OneHitWonder_Warlock_SiphonLife = 1;

OneHitWonder_Warlock_ReactiveRecklessnessCursing = 1;
OneHitWonder_Warlock_SmartCursing = 0;

OneHitWonder_Warlock_ShouldDetectInvisible = 1;
OneHitWonder_Warlock_ShouldUnderwaterBreathing = 0;

OneHitWonder_Warlock_ShouldPetAttack = 0;

OneHitWonder_CursedTargetTime = 0;
OneHitWonder_CurrentCurseTime = 0;
OneHitWonder_LastCurse = nil;


OneHitWonder_Warlock_WandUses = 0;

function OneHitWonder_Init_Warlock()
	OneHitWonder_Options["OneHitWonder_Warlock_ImmolateIfTargetPercentage"] = OneHitWonder_Warlock_ImmolateIfTargetPercentage;
	OneHitWonder_Options["OneHitWonder_Warlock_ImmolateIfSelfPercentage"] = OneHitWonder_Warlock_ImmolateIfSelfPercentage;
	OneHitWonder_Options["OneHitWonder_Warlock_SoulDrainPercentage"] = OneHitWonder_Warlock_SoulDrainPercentage;
	OneHitWonder_Options["OneHitWonder_Warlock_MinimumShards"] = OneHitWonder_Warlock_MinimumShards;
	OneHitWonder_Options["OneHitWonder_Warlock_UseWand"] = OneHitWonder_Warlock_UseWand;
	OneHitWonder_Options["OneHitWonder_Warlock_SmartCursing"] = OneHitWonder_Warlock_SmartCursing00000000000000;
	OneHitWonder_Options["OneHitWonder_Warlock_ReactiveRecklessnessCursing"] = OneHitWonder_Warlock_ReactiveRecklessnessCursing;
	OneHitWonder_Options["OneHitWonder_Warlock_UseSearingPain"] = OneHitWonder_Warlock_UseSearingPain;
	OneHitWonder_Options["OneHitWonder_Warlock_PreferFire"] = OneHitWonder_Warlock_PreferFire;
	OneHitWonder_Options["OneHitWonder_Warlock_ShouldUnderwaterBreathing"] = OneHitWonder_Warlock_ShouldUnderwaterBreathing;
	OneHitWonder_Options["OneHitWonder_Warlock_ShouldDetectInvisible"] = OneHitWonder_Warlock_ShouldDetectInvisible;
	OneHitWonder_Options["OneHitWonder_Warlock_ShouldPetAttack"] = OneHitWonder_Warlock_ShouldPetAttack;
end

function OneHitWonder_WillUnitGiveSoulShard(unit)
	if ( UnitIsPlayer(unit) ) then
		return false;
	else
		return OneHitWonder_WillUnitLevelGiveSoulShard(unit);
	end
end

function OneHitWonder_WillUnitLevelGiveSoulShard(unit)
	local playerLevel = UnitLevel("player");
	local unitsLevel = UnitLevel(unit);
	local levelDiff = 5;
	
	if (UnitClass(unit) == "elite") then
		levelDiff = 7;
	end
	
	if ( unitsLevel >= (playerLevel-levelDiff) ) then
		return true;
	else
		return false;
	end
end



function OneHitWonder_GetCurseForTarget()
	local spellName = ONEHITWONDER_SPELL_CURSE_AGONY;
	-- if caster
	if ( UnitPowerType("target") == 0 ) then
		spellName = ONEHITWONDER_SPELL_CURSE_TONGUES;
	end
	if ( OneHitWonder_GetSpellId(spellName) <= -1 ) or ( OneHitWonder_HasUnitEffect("target", nil, spellName) ) then
		spellName = ONEHITWONDER_SPELL_CURSE_WEAKNESS;
	end
	return spellName;
end

function OneHitWonder_Warlock_SpellEnded()
	TargetFrame.isBeingSoulDrained = false;
end

OneHitWonder_Warlock_CommonSpellsInActionBar = {
	ONEHITWONDER_SPELL_IMMOLATE_NAME,
	ONEHITWONDER_SPELL_CORRUPTION_NAME,
	ONEHITWONDER_SPELL_SHADOW_BOLT_NAME,
	ONEHITWONDER_SPELL_CURSE_WEAKNESS,
	ONEHITWONDER_SPELL_CURSE_AGONY,
	ONEHITWONDER_SPELL_CURSE_DOOM,
	ONEHITWONDER_SPELL_CURSE_ELEMENTS,
	ONEHITWONDER_SPELL_CURSE_RECKLESSNESS,
	ONEHITWONDER_SPELL_CURSE_TONGUES,
	ONEHITWONDER_SPELL_DRAIN_SOUL_NAME,
	ONEHITWONDER_SPELL_CONFLAGRATE_NAME
};

function OneHitWonder_Warlock_IsInSpellRange()
	local spellId, actionId;
	for k, v in OneHitWonder_Warlock_CommonSpellsInActionBar do
		spellId = OneHitWonder_GetSpellId(v);
		if ( spellId ) and ( spellId > -1 ) then
			actionId = OneHitWonder_GetActionIdFromSpellId(spellId);
			if ( actionId ) and ( actionId > -1 ) then
				return OneHitWonder_CheckIfInRangeActionId(actionId);
			end
		end
	end
	return true;
end


OneHitWonder_Warlock_LastSpell = nil;
OneHitWonder_LagTime = 0.8;

function OneHitWonder_GetTimeUntilBuffsAppear()
	return OneHitWonder_LagTime;
end

function OneHitWonder_Warlock_ShouldUseSiphonLifeOnUnit(unit)
	if ( OneHitWonder_CanSpellAffectUnit(ONEHITWONDER_SPELL_SIPHON_LIFE_NAME, unit) ) 
		and ( UnitClass(unit) ~= ONEHITWONDER_CLASS_ROGUE ) 
		and ( not OneHitWonder_HasUnitEffect(unit, nil, ONEHITWONDER_SPELL_SIPHON_LIFE_EFFECT) )
		then
		return true;
	else
		return false;
	end
end


OneHitWonder_Warlock_PvE_Curses = {
	ONEHITWONDER_SPELL_CURSE_AGONY,
	ONEHITWONDER_SPELL_CURSE_WEAKNESS
};

function OneHitWonder_Warlock_CastFirstAvailableSpellIfNotPresent(names, unit)
	if ( not names ) then
		return false;
	end
	if ( not unit ) then
		unit = "target";
	end
	if ( type(names) ~= "table" ) then
		names = { names };
	end
	local spellId = -1;
	local spell, effect = nil, nil;
	for k, v in names do
		if ( type(v) ~= tables ) then
			spell = v;
			effect = v;
		else
			spell = v[1];
			effect = v[2];
		end
		spellId = OneHitWonder_GetSpellId(spell);
		if ( spellId > -1 ) then
			if ( OneHitWonder_HasUnitEffect(unit, nil, effect) ) then
				return false;
			else
				return OneHitWonder_CastSpell(spellId);
			end
		end
	end
	return false;
end

function OneHitWonder_TargetIsRunningAway_Warlock()
	if ( OneHitWonder_Warlock_ReactiveRecklessnessCursing ~= 1 ) then
		return false;
	end
	local name = ONEHITWONDER_SPELL_CURSE_RECKLESSNESS;
	if ( not OneHitWonder_CanAbilityAffectUnit(name, "target") ) then
		return false;
	end
	if ( OneHitWonder_HasUnitEffect("target", nil, ONEHITWONDER_SLOW_EFFECTS) ) then
		return false;
	end
	local spellId = OneHitWonder_GetSpellId(name);
	if ( spellId > -1 ) and ( OneHitWonder_IsSpellAvailable(spellId) ) then
		local parameters = { spellId, GetTime() + 3};
		OneHitWonder_AddActionToQueue(ONEHITWONDER_ACTIONID_SPELL_TIMEOUT, parameters);
		return true;
	end
	return false;
end


function OneHitWonder_Warlock_PvE(removeDefense)
--[[

From Jayson

PVE Warlock, the main purpose of the pve warlock is to reduce agro.

So one hit wonder should do this

        Never immulate first even if the player has it selected.
        if (use wand)
                curse of agony
                curruption
                wand (repeat)
                after 5 wands uses and target > 90% hp then if (use immulate) cast immulate
                if target > 50% hp and pet is 1/2 hp (shadowbolt highest rank)
from
				then on
				if target hp < shadowburn damage highest rank of caster then
use
shadowburn

        if (!use wand)
                curse of agony
                corruption
                shadowbolt (1/2 highest rank)
                after 5 shadowbolt (1/2 rank) and target >90% hp then if (use
immulate) cast immulate
                if target > 50% hp and pet is 1/2 hp (shadowbolt highest rank)
from
then on
                if target hp < shadowburn damage highest rank of caster then
use
shadowburn



]]--
	return false;
end

function OneHitWonder_Warlock_PvP(removeDefense)
--[[
        send pet into attack
        if (felhunter summoned)  and (caster is casting)
                reactive spell lock on caster (highest rank)
        if (succubus summoned)
                seduction
        if (voidwalker summoned & <50% hp)
                sacrifice
        if (> 10 yards or seduction on)
                immulate
        if (caster is casting)
                reactive Curse of Tongues
        if ((>10 yards or suduction on) and have siphon life)
                siphon life
        if (curse of tongues not in use)
                curse of agony
        corruption
        if (timer runs out on curse of agony & curse of tongues not in use)
                curse of agony
        if (timer runs out on corruption)
                corruption
        if (<50% hp on self & immulate on target)
                combustion
        if (nightfall on self)
                shadowbolt
        if (!Will of the Forsaken not on target & >10 yards)
                use fear periodically and reactively if possible
        if (<75% hp on self) drain
        if (shardcount good and target >50% health and self <60% health & and
cooldown over on shadowburn)
                shadowburn
        repeat searing pain and if (>10 yards) repeat shadowbolt instead
        if (spell effect on self and felhunter summoned )
                reactive devour magic
   

]]--
	return false;
end

function OneHitWonder_Warlock_CastCorruption()
	if ( OneHitWonder_CanSpellAffectUnit(ONEHITWONDER_SPELL_CORRUPTION_NAME, "target") ) and 
			( OneHitWonder_CastIfTargetNotHasEffect(ONEHITWONDER_SPELL_CORRUPTION_NAME, ONEHITWONDER_EFFECT_CORRUPTION) ) and 
			( OneHitWonder_Warlock_LastSpell ~= ONEHITWONDER_SPELL_CORRUPTION_NAME ) then
			OneHitWonder_Warlock_LastSpell = ONEHITWONDER_SPELL_CORRUPTION_NAME;
		return true;
	end
	return false;
end

function OneHitWonder_Warlock_CastImmolate()
	local curTime = GetTime();
	local timeSinceSpellStopped = curTime - OneHitWonder_TimeSpellStopped;
	local unitHPPercent = OneHitWonder_GetTargetHPPercentage();

	if (unitHPPercent > OneHitWonder_Warlock_ImmolateIfTargetPercentage) then
		if (OneHitWonder_GetUnitHPPercentage("player") > OneHitWonder_Warlock_ImmolateIfSelfPercentage) then
			local immolateTimeLeft = 0;
			if ( OneHitWonder_HasUnitEffect("target", nil, ONEHITWONDER_EFFECT_IMMOLATE) ) then
				if ( OneHitWonder_Warlock_ImmolateEndTime ) then
					immolateTimeLeft = OneHitWonder_Warlock_ImmolateEndTime - curTime;
				else
					immolateTimeLeft = 15;
				end
			else
				if ( (OneHitWonder_Warlock_ImmolateEndTime) and 
				( ( OneHitWonder_Warlock_ImmolateEndTime - curTime ) <= 10 ) ) then
					immolateTimeLeft = OneHitWonder_Warlock_ImmolateEndTime - curTime;
				end
			end
			local conflagrateId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_CONFLAGRATE_NAME);
			if ( conflagrateId > -1 ) and ( OneHitWonder_CanSpellAffectUnit(ONEHITWONDER_SPELL_CONFLAGRATE_NAME, "target") ) then
				if ( ( immolateTimeLeft > 1.5 ) and ( immolateTimeLeft <= 3 ) and ( OneHitWonder_CastSpellSpecial(ONEHITWONDER_SPELL_CONFLAGRATE_NAME) )  )then
					OneHitWonder_Warlock_ImmolateEndTime = nil;
					return true;
				end
			else
				if ( immolateTimeLeft <= 4 ) then
					if ( OneHitWonder_CastSpellSpecial(ONEHITWONDER_SPELL_IMMOLATE_NAME) ) and ( OneHitWonder_Warlock_LastSpell ~= ONEHITWONDER_SPELL_IMMOLATE_NAME ) then
						OneHitWonder_Warlock_LastSpell = ONEHITWONDER_SPELL_IMMOLATE_NAME;
						OneHitWonder_Warlock_ImmolateEndTime = curTime+17;
						return true;
					end
				end
			end
		end
	end
	return false
end

function OneHitWonder_Warlock_CastCurse()
	local curTime = GetTime();
	local timeSinceSpellStopped = curTime - OneHitWonder_TimeSpellStopped;
	local unitHPPercent = OneHitWonder_GetTargetHPPercentage();
	if ( OneHitWonder_Warlock_SmartCursing == 1 ) then
			--OneHitWonder_Print("Smart Cursing.");
			local effectName = ONEHITWONDER_WARLOCK_CURSE_EFFECTS;
			local spellName = nil;
			if ( OneHitWonder_IsInPartyOrRaid() ) then
				--OneHitWonder_Print("Group based Cursing.");
				local warlocks = OneHitWonder_GetNumberOfClassInGroup(ONEHITWONDER_CLASS_WARLOCK);
				local priests = OneHitWonder_GetNumberOfClassInGroup(ONEHITWONDER_CLASS_PRIEST);
				local mages = OneHitWonder_GetNumberOfClassInGroup(ONEHITWONDER_CLASS_MAGE);
				-- prevent running
				if ( unitHPPercent <= 5 ) then
					effectName = nil;
					spellName = ONEHITWONDER_SPELL_CURSE_RECKLESSNESS;
				elseif ( ( ( priests + warlocks ) > 1 ) and ( ( priests + warlocks ) >= mages ) ) then
					spellName = ONEHITWONDER_SPELL_CURSE_SHADOW;
				elseif ( mages > (priests+warlocks ) ) then
					spellName = ONEHITWONDER_SPELL_CURSE_ELEMENTS;
				end
			end
			if ( spellName == nil ) then
				spellName = ONEHITWONDER_SPELL_CURSE_AGONY;
				--OneHitWonder_Print("Defaulting to ."..spellName);
			elseif (not OneHitWonder_IsSpellAvailable(OneHitWonder_GetSpellId(spellName))) then
				spellName = ONEHITWONDER_SPELL_CURSE_AGONY;			
				--OneHitWonder_Print("Defaulting to ."..spellName);
			end
			if ( not OneHitWonder_CanSpellAffectUnit(spellName, "target") ) then
				spellName = "";
			end
			if ( OneHitWonder_GetSpellId(spellName) <= -1 ) then
				--OneHitWonder_Print(spellName.." not found, using CoW");
				spellName = ONEHITWONDER_SPELL_CURSE_WEAKNESS;
				effectName = spellName;
			end
			OneHitWonder_CurrentCurseTime = ONEHITWONDER_WARLOCK_CURSE_TIMES[spellName];
			if ( not OneHitWonder_HasUnitEffect("target", nil, spellName ) ) then
				--OneHitWonder_Print("Did not have the spell");
				OneHitWonder_CurrentCurseTime = 0;
			end
			if ( GetTime()-OneHitWonder_CursedTargetTime >= OneHitWonder_CurrentCurseTime ) then
				--spellName = OneHitWonder_GetCurseForTarget();
				if ( OneHitWonder_CastSpellSpecial(spellName) ) then
					OneHitWonder_Warlock_LastSpell = spellName;
					return true;
				end
			end
			if ( OneHitWonder_CastIfTargetNotHasEffect(spellName,effectName) ) then
				OneHitWonder_Warlock_LastSpell = spellName;
				return true;
			end
		else
			local spellName = ONEHITWONDER_SPELL_CURSE_AGONY;
			if ( OneHitWonder_GetSpellId(spellName) <= -1 ) or ( not OneHitWonder_CanSpellAffectUnit(spellName, "target") ) then
				spellName = ONEHITWONDER_SPELL_CURSE_WEAKNESS;
			end
			
			if ( OneHitWonder_CanSpellAffectUnit(spellName, "target") ) and ( OneHitWonder_CastIfTargetNotHasEffect(spellName, ONEHITWONDER_WARLOCK_CURSE_EFFECTS) ) then
				OneHitWonder_Warlock_LastSpell = spellName;
				return true;
			end
		end
	return false
end

function OneHitWonder_Warlock(removeDefense)
	--_print("OneHitWonder_Warlock")
	local targetName = UnitName("target");

	if ( not removeDefense ) then removeDefense = false; end
	
	--if ( OneHitWonder_IsChannelSpellRunning() ) or ( OneHitWonder_IsRegularSpellRunning() ) then
	if ( OneHitWonder_IsChannelSpellRunning() ) then
		return;
	end
	
	if ( (not targetName) or ( strlen(targetName) <= 0 ) ) then
		if ( not OneHitWonder_UseCountermeasures() ) then
			if ( not OneHitWonder_DoBuffs() ) then
				if ( OneHitWonder_ShouldOverrideBindings ~= 1 ) then
					OneHitWonder_DoStuffContinuously();
				end
			end
		end
		return;
	end
	
	if ( not UnitCanAttack("player", "target") ) then
		if ( not OneHitWonder_UseCountermeasures() ) then
			OneHitWonder_DoBuffs();
		end
		return;
	end
	
	if (not OneHitWonder_StartCombat()) then
		return false
	end
	
	if ( OneHitWonder_HasPlayerEffect(nil, ONEHITWONDER_SPELL_NIGHTFALL_EFFECT) ) then
		return OneHitWonder_CastSpellSpecial(ONEHITWONDER_SPELL_SHADOW_BOLT_NAME, false);
	end
	
	if ( UnitIsPlayer("target") ) then
		if ( OneHitWonder_Warlock_PvP(removeDefense) ) then
			return true;
		end
	else
		if ( GetNumPartyMembers() > 0 ) or ( OneHitWonder_Warlock_UseNewMinimizeAggroPvE == 1 ) then
			if ( OneHitWonder_Warlock_PvE(removeDefense) ) then
				return true;
			end
		end
	end
	
	OneHitWonder_CheckFriendlies();
	
	if ( OneHitWonder_HandleActionQueue() ) then
		return;
	end
	
	if (OneHitWonder_PetIsAttacking == false) and ( OneHitWonder_Warlock_IsInSpellRange() ) then
		OneHitWonder_Warlock_SmartPetAttack();
	end

	if ( OneHitWonder_Warlock_ShouldUseSiphonLifeOnUnit("target") ) then
		if ( OneHitWonder_CastSpellSpecial(ONEHITWONDER_SPELL_SIPHON_LIFE_NAME, false) ) then
			return true;
		end
	end
	
	local curTime = GetTime();
		
	local timeSinceSpellStopped = curTime - OneHitWonder_TimeSpellStopped;
	local unitHPPercent = OneHitWonder_GetTargetHPPercentage();

	if ( OneHitWonder_CanSpellAffectUnit(ONEHITWONDER_SPELL_DRAIN_SOUL_NAME, "target") ) 
		and ( unitHPPercent <= OneHitWonder_Warlock_SoulDrainPercentage ) 
		and ( OneHitWonder_WillUnitGiveSoulShard("target") )  then
		if (OneHitWonder_Warlock_ShardCount < OneHitWonder_Warlock_MinimumShards) then
			OneHitWonder_CastSpellSpecial(ONEHITWONDER_SPELL_DRAIN_SOUL_NAME, true);
			TargetFrame.isBeingSoulDrained = true;
			return;
		end
	end		

	local shadowBurnId = OneHitWonder_GetSpellId(ONEHITWONDER_SPELL_SHADOWBURN);
	if ( shadowBurnId > -1 ) and ( OneHitWonder_CanSpellAffectUnit(ONEHITWONDER_SPELL_SHADOWBURN, "target") ) 
		and ( not TargetFrame.isBeingSoulDrained ) 
		and ( unitHPPercent <= OneHitWonder_Warlock_ShadowBurnPercentage ) 
		and ( OneHitWonder_WillUnitGiveSoulShard("target") ) then 
		if ( OneHitWonder_CastSpellOnTarget(shadowBurnId) ) then
			return;
		end
	end
	
	-- should be optional
	if ( OneHitWonder_ShouldMeleeAttack == 1 ) and ( OneHitWonder_Warlock_IsInSpellRange() ) then
		OneHitWonder_MeleeAttack();
	end

	if (timeSinceSpellStopped >= OneHitWonder_GetTimeUntilBuffsAppear()) then
		if not OneHitWonder_IsInCombat() then
			-- not in combat, have time to cast long spell first.
			if OneHitWonder_Warlock_PreferFire then
				if OneHitWonder_Warlock_CastImmolate() then
			    	return
				end
				if OneHitWonder_Warlock_CastCorruption() then
			    	return
				end
			else
				if OneHitWonder_Warlock_CastCorruption() then
			    	return
				end
				if OneHitWonder_Warlock_CastImmolate() then
			    	return
				end
			end
			if OneHitWonder_Warlock_CastCurse() then
			    return
			end
		else
			-- in comabt. do instant cursing first.
			if OneHitWonder_Warlock_CastCurse() then
			    return
			end
			if OneHitWonder_Warlock_PreferFire then
				if OneHitWonder_Warlock_CastImmolate() then
			    	return
				end
				if OneHitWonder_Warlock_CastCorruption() then
			    	return
				end
			else
				if OneHitWonder_Warlock_CastCorruption() then
			    	return
				end
				if OneHitWonder_Warlock_CastImmolate() then
			    	return
				end
			end
		end
			
		if ( OneHitWonder_Warlock_UseWand ~= 1 ) then
			if (OneHitWonder_Warlock_PreferFire == 1 and OneHitWonder_Warlock_UseSearingPain==1 and not OneHitWonder_IsInPartyOrRaid())  then
				if ( OneHitWonder_CanSpellAffectUnit(ONEHITWONDER_SPELL_SEARING_PAIN_NAME, "target") ) and 
				( OneHitWonder_CastSpellSpecial(ONEHITWONDER_SPELL_SEARING_PAIN_NAME) ) then
					OneHitWonder_Warlock_LastSpell = ONEHITWONDER_SPELL_SEARING_PAIN_NAME;
					return;
				end
			else
				if ( OneHitWonder_CanSpellAffectUnit(ONEHITWONDER_SPELL_SHADOW_BOLT_NAME, "target") ) and 
				( OneHitWonder_CastSpellSpecial(ONEHITWONDER_SPELL_SHADOW_BOLT_NAME) ) then
					OneHitWonder_Warlock_LastSpell = ONEHITWONDER_SPELL_SHADOW_BOLT_NAME;
					return;
				end
			end
		end
	end
	

	if ( not OneHitWonder_DoBuffs() ) then
		if (OneHitWonder_Warlock_UseWand == 1 ) and ( strlen(OneHitWonder_GetItemName(-1, 18)) > 0 ) and (OneHitWonder_CastIfTargetNotHasEffect(ONEHITWONDER_ABILITY_SHOOT_NAME, ONEHITWONDER_ABILITY_SHOOT_EFFECT) ) then
			return;
		end
	end
	
end

function OneHitWonder_Warlock_SetShouldDetectInvisible(toggle)
	if ( toggle ~= OneHitWonder_Warlock_ShouldDetectInvisible ) then
		OneHitWonder_Warlock_ShouldDetectInvisible = toggle;
		OneHitWonder_SetupStuffContinuously();
	end
end

function OneHitWonder_Warlock_SetShouldUnderwaterBreathing(toggle)
	if ( toggle ~= OneHitWonder_Warlock_ShouldUnderwaterBreathing ) then
		OneHitWonder_Warlock_ShouldUnderwaterBreathing = toggle;
		OneHitWonder_SetupStuffContinuously();
	end
end

function OneHitWonder_SetMinimumShards(toggle, value)
	OneHitWonder_Warlock_MinimumShards = value;
end

function OneHitWonder_SetSoulDrainPercentage(toggle, value)
	OneHitWonder_Warlock_SoulDrainPercentage = value;
end

function OneHitWonder_SetImmolateIfTargetPercentage(toggle, value)
	OneHitWonder_Warlock_ImmolateIfTargetPercentage = value;
end

function OneHitWonder_SetImmolateIfSelfPercentage(toggle, value)
	OneHitWonder_Warlock_ImmolateIfSelfPercentage = value;
end

function OneHitWonder_Warlock_SetShouldPetAttack(toggle)
	OneHitWonder_Warlock_ShouldPetAttack = toggle;
end

function OneHitWonder_Warlock_SetSmartCursing(toggle)
	OneHitWonder_Warlock_SmartCursing = toggle;
end

function OneHitWonder_Warlock_SetPreferFire(toggle)
	OneHitWonder_Warlock_PreferFire = toggle;
end

function OneHitWonder_Warlock_SetUseSearingPain(toggle)
	OneHitWonder_Warlock_UseSearingPain = toggle;
end

function OneHitWonder_Warlock_SetReactiveRecklessnessCursing(toggle)
	OneHitWonder_Warlock_ReactiveRecklessnessCursing = toggle;
end

function OneHitWonder_Warlock_SetUseWand(toggle)
	OneHitWonder_Warlock_UseWand = toggle;
end


function OneHitWonder_Warlock_Cosmos()
	if ( Cosmos_RegisterConfiguration ) and ( Cosmos_UpdateValue ) then
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_WARLOCK_SEPARATOR",
			"SEPARATOR",
			TEXT(ONEHITWONDER_WARLOCK_SEPARATOR),
			TEXT(ONEHITWONDER_WARLOCK_SEPARATOR_INFO)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_WARLOCK_SHOULD_DETECT_INVISIBILITY",
			"CHECKBOX",
			TEXT(ONEHITWONDER_WARLOCK_SHOULD_DETECT_INVISIBILITY),
			TEXT(ONEHITWONDER_WARLOCK_SHOULD_DETECT_INVISIBILITY_INFO),
			OneHitWonder_Warlock_SetShouldDetectInvisible,
			OneHitWonder_Warlock_ShouldDetectInvisible
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_WARLOCK_SHOULD_UNDERWATER_BREATHING",
			"CHECKBOX",
			TEXT(ONEHITWONDER_WARLOCK_SHOULD_UNDERWATER_BREATHING),
			TEXT(ONEHITWONDER_WARLOCK_SHOULD_UNDERWATER_BREATHING_INFO),
			OneHitWonder_Warlock_SetShouldUnderwaterBreathing,
			OneHitWonder_Warlock_ShouldUnderwaterBreathing
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_WARLOCK_USE_SMART_PET_ATTACK",
			"CHECKBOX",
			TEXT(ONEHITWONDER_WARLOCK_USE_SMART_PET_ATTACK),
			TEXT(ONEHITWONDER_WARLOCK_USE_SMART_PET_ATTACK_INFO),
			OneHitWonder_Warlock_SetShouldPetAttack,
			OneHitWonder_Warlock_ShouldPetAttack
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_WARLOCK_PREFER_FIRE",
			"CHECKBOX",
			TEXT(ONEHITWONDER_WARLOCK_PREFER_FIRE),
			TEXT(ONEHITWONDER_WARLOCK_PREFER_FIRE_INFO),
			OneHitWonder_Warlock_SetPreferFire,
			OneHitWonder_Warlock_PreferFire
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_WARLOCK_USE_SEARING_PAIN",
			"CHECKBOX",
			TEXT(ONEHITWONDER_WARLOCK_USE_SEARING_PAIN),
			TEXT(ONEHITWONDER_WARLOCK_USE_SEARING_PAIN_INFO),
			OneHitWonder_Warlock_SetUseSearingPain,
			OneHitWonder_Warlock_UseSearingPain
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_WARLOCK_USE_SMART_CURSING",
			"CHECKBOX",
			TEXT(ONEHITWONDER_WARLOCK_USE_SMART_CURSING),
			TEXT(ONEHITWONDER_WARLOCK_USE_SMART_CURSING_INFO),
			OneHitWonder_Warlock_SetSmartCursing,
			OneHitWonder_Warlock_SmartCursing
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_WARLOCK_REACTIVE_RECKLESSNESS_CURSING",
			"CHECKBOX",
			TEXT(ONEHITWONDER_WARLOCK_REACTIVE_RECKLESSNESS_CURSING),
			TEXT(ONEHITWONDER_WARLOCK_REACTIVE_RECKLESSNESS_CURSING_INFO),
			OneHitWonder_Warlock_SetReactiveRecklessnessCursing,
			OneHitWonder_Warlock_ReactiveRecklessnessCursing
		);
		
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_WARLOCK_USE_WAND",
			"CHECKBOX",
			TEXT(ONEHITWONDER_WARLOCK_USE_WAND),
			TEXT(ONEHITWONDER_WARLOCK_USE_WAND_INFO),
			OneHitWonder_Warlock_SetUseWand,
			OneHitWonder_Warlock_UseWand
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_WARLOCK_MINIMUM_SHARDS",
			"SLIDER",
			TEXT(ONEHITWONDER_WARLOCK_MINIMUM_SHARDS),
			TEXT(ONEHITWONDER_WARLOCK_MINIMUM_SHARDS_INFO),
			OneHitWonder_SetMinimumShards,
			1,
			OneHitWonder_Warlock_MinimumShards, -- default
			0, -- min
			40, -- max
			"",
			1,
			1,
			TEXT(ONEHITWONDER_WARLOCK_MINIMUM_SHARDS_APPEND)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_WARLOCK_SOUL_DRAIN",
			"SLIDER",
			TEXT(ONEHITWONDER_WARLOCK_SOUL_DRAIN),
			TEXT(ONEHITWONDER_WARLOCK_SOUL_DRAIN_INFO),
			OneHitWonder_SetSoulDrainPercentage,
			1,
			OneHitWonder_Warlock_SoulDrainPercentage, -- default
			0, -- min
			100, -- max
			"",
			1,
			1,
			TEXT(ONEHITWONDER_WARLOCK_SOUL_DRAIN_APPEND)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_WARLOCK_IMMOLATE_IFTARGET",
			"SLIDER",
			TEXT(ONEHITWONDER_WARLOCK_IMMOLATE_IFTARGET),
			TEXT(ONEHITWONDER_WARLOCK_IMMOLATE_IFTARGET_INFO),
			OneHitWonder_SetImmolateIfTargetPercentage,
			1,
			OneHitWonder_Warlock_ImmolateIfTargetPercentage, -- default
			0, -- min
			101, -- max
			"",
			1,
			1,
			TEXT(ONEHITWONDER_WARLOCK_IMMOLATE_IFTARGET_APPEND)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_WARLOCK_IMMOLATE_IFSELF",
			"SLIDER",
			TEXT(ONEHITWONDER_WARLOCK_IMMOLATE_IFSELF),
			TEXT(ONEHITWONDER_WARLOCK_IMMOLATE_IFSELF_INFO),
			OneHitWonder_SetImmolateIfSelfPercentage,
			1,
			OneHitWonder_Warlock_ImmolateIfSelfPercentage, -- default
			0, -- min
			100, -- max
			"",
			1,
			1,
			TEXT(ONEHITWONDER_WARLOCK_IMMOLATE_IFSELF_APPEND)
		);
		
	end
	
end

function OneHitWonder_Warlock_CountShards()
	OneHitWonder_Warlock_ShardCount = 0;
	if ( ( DynamicData ) and ( DynamicData.item ) and ( DynamicData.item.getItemInfoByName ) ) then
		
		local itemInfo = DynamicData.item.getItemInfoByName(ONEHITWONDER_WARLOCK_ITEM_SOUL_SHARD);
		if ( itemInfo ) then
			OneHitWonder_Warlock_ShardCount = itemInfo.count;
		end
		--OneHitWonder_Print("Counting shards"..format(OneHitWonder_Warlock_ShardCount));
	end
end

function OneHitWonder_Warlock_SmartPetAttack()
	return OneHitWonder_SmartPetAttack(OneHitWonder_Warlock_ShouldPetAttack);
end


function OneHitWonder_SetupStuffContinuously_Warlock()
	--OneHitWonder_BuffTime[highestDemonBuffName] = 25*60;
	--OneHitWonder_BuffTime[highestDetectInvisibilityBuffName] = 9*60;

	if ( OneHitWonder_ShouldKeepBuffsUp == 1 ) then
		local highestDemonBuffName = OneHitWonder_GetHighestBuffName(OneHitWonder_WarlockDemonBuffNames);
		if ( highestDemonBuffName ) then
			OneHitWonder_AddStuffContinuously(highestDemonBuffName, true, true, {useWhenHigherManaPercentage=90});
		end
		if ( OneHitWonder_Warlock_ShouldDetectInvisible == 1 ) then
			local highestDetectInvisibilityBuffName = OneHitWonder_GetHighestBuffName(OneHitWonder_WarlockDetectInvisibilityBuffNames);
			if ( highestDetectInvisibilityBuffName ) then
				OneHitWonder_AddStuffContinuously(highestDetectInvisibilityBuffName, false, true, {useWhenHigherManaPercentage=90});
			end
		end
		if ( OneHitWonder_Warlock_ShouldUnderwaterBreathing == 1 ) then
			OneHitWonder_AddStuffContinuously(ONEHITWONDER_SPELL_UNENDING_BREATH_NAME, false, true, {useWhenHigherManaPercentage=85});
		end
	end
end


function OneHitWonder_TryToInterruptSpell_Warlock(unitName, spellName)
	local interruptId = -1;
	local abilityName = "";
	if ( OneHitWonder_Warlock_ShouldReactiveCastShadowWard == 1 ) and 
		( OneHitWonder_IsSpellShadowBased(spellName) ) then
		abilityName = ONEHITWONDER_SPELL_SHADOW_WARD_NAME;
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


function OneHitWonder_HandleSpellCast_Warlock(spellName)
	if ( ( spellName ) and ( strfind(spellName, "Curse") ) ) then
		OneHitWonder_CurrentCurseTime = ONEHITWONDER_WARLOCK_CURSE_TIMES[spellName];
		if ( not OneHitWonder_CurrentCurseTime ) then
			-- change this?
			OneHitWonder_CurrentCurseTime = 0;
		end
		OneHitWonder_LastCurse = spellName;
		OneHitWonder_CursedTargetTime = GetTime();
	end
end

function OneHitWonder_CheckEffect_Warlock(unit)
	local curTime = GetTime();
	if ( unit == "target" ) then
		if ( UnitCanAttack(unit, "player" ) ) then
			if ( OneHitWonder_HasUnitEffect(unit, nil, ONEHITWONDER_EFFECT_IMMOLATE) ) then
				if ( not OneHitWonder_Warlock_ImmolateEndTime ) then
					OneHitWonder_Warlock_ImmolateEndTime = curTime + 15;
				end
			end
		end
	end
end

function OneHitWonder_Target_Changed_Warlock()
	TargetFrame.isBeingSoulDrained = false;
	OneHitWonder_CursedTargetTime = 0;
	OneHitWonder_CurrentCurseTime = 0;
	OneHitWonder_LastCurse = nil;
	OneHitWonder_Warlock_ImmolateEndTime = nil;
	OneHitWonder_Warlock_LastSpell = nil;
	OneHitWonder_Warlock_WandUses = 0;
end
