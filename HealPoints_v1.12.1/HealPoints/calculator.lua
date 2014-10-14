
HealPointsCalculator = {
  HP_LastPowerfulCurrent = nil;
  HP_LastPowerfulNew = nil;
  HP_LastEfficientCurrent = nil;
  HP_LastEfficientNew = nil;
  TH_TotalTimeCurrent = { };
  TH_TotalTimeNew = { };
  HPC_ExtraRegrowthCrit = 0;
  HPC_ExtraMana = 0;
  HPC_ExtraInt = 0;
  HPC_ExtraSpi = 0;
};

local Paladin_BoL =  {	{ HL = 210, FoL = 60},
						{ HL = 300, FoL = 85},
						{ HL = 400, FoL = 115}};

-- Helper functions
local function getHPCast(spell, healing, spellCrit)
	local healFactor = 1;
	if (spell['level'] < 20) then
		healFactor = 1 - ((20 - spell['level']) * 0.0375);
	end
	
	local out = spell['avg'];
	if (spell['type'] == 'regrowth') then
		-- Static part
		out = out + ((healFactor * healing / 2) / (3.5 / (math.min(spell['orgtime'], 3.5))));
		out = out + ((spellCrit + HealPointsCalculator.HPC_ExtraRegrowthCrit) / 200) * out;		-- Crit adds 50% for non-hot
		-- HOT part
		out = out + spell['hotavg'];
		out = out + ((healFactor * healing / 2) / (15 / (math.min(spell['hottime'], 15))));

  elseif (spell['type'] == 'chain') then
		out = out + (healFactor * healing / (3.5 / (math.min(spell['orgtime'], 3.5))));
		local impChainHeal = HealPointsBS:GetBonus('IMPCHAINHEAL');
		out = out * (1 + 0.5 * (1 + impChainHeal / 100) + 0.25 * (1 + impChainHeal / 100)); -- Assumes that the spell hits all 3 targets
		out = out * (1 + (spellCrit / 200));												-- Crit adds 50% for non-hot

  elseif (spell['type'] == 'hot') then
		if (spell['name'] == HPC_SPELL_REJUV and HealPointsBS:GetBonus('IMPREJUVENATION') > 0) then
			healing = healing + HealPointsBS:GetBonus('IMPREJUVENATION');
		end
		out = out + (healFactor * healing / (15 / (math.min(spell['orgtime'], 15))));

  elseif (spell['type'] == 'instant') then
		out = out + (healFactor * healing / 1.5);

  else
		if (getglobal("HealPoints_CalcFrameBoL"):GetChecked() == 1) then
			local bolRank = HealPointsSpells:getHighestSpellRank(HPC_SPELL_BOL);
			if (bolRank > 0) then
				local bol = Paladin_BoL[bolRank];
				out = out + spell['bolfactor'] * bol[spell['abbr']];
			end
		end
		if (spell['name'] == HPC_SPELL_LHW and HealPointsBS:GetBonus('IMPLESSERHEALINGWAVE') > 0) then
			healing = healing + HealPointsBS:GetBonus('IMPLESSERHEALINGWAVE');
		end
		if (spell['name'] == HPC_SPELL_FOL and HealPointsBS:GetBonus('IMPFLASHOFLIGHT') > 0) then
			healing = healing + HealPointsBS:GetBonus('IMPFLASHOFLIGHT');
		end
		out = out + (healFactor * healing / (3.5 / (math.min(spell['orgtime'], 3.5))));
		out = out * (1 + (spellCrit / 200));		-- Crit adds 50% for non-hot
		if (spell['name'] == HPC_SPELL_HW and HealPointsBS:GetBonus('JUMPHEALINGWAVE') > 0) then
			local factor = 1 - HealPointsBS:GetBonus('JUMPHEALINGWAVE') / 100;
			out = out * (1 + factor + factor * factor);
		end
		if (spell['name'] == HPC_SPELL_GH and HealPointsBS:GetBonus('GHEALRENEW') > 0) then
			local renew = HealPointsSpells:getSpell(HPC_SPELL_RENEW, HealPointsBS:GetBonus('GHEALRENEW'));
			out = out + renew['avg'] + healing; -- Assumes renew effect isn't overwritten
		end
	end
	return out;
end

local function getHPSec(spell, healing, spellCrit)
	local out = getHPCast(spell, healing, spellCrit);

	if (spell['type'] == 'regrowth') then
		return out/(spell['hottime'] + spell['time']);	
	elseif (spell['name'] == HPC_SPELL_GH and HealPointsBS:GetBonus('GHEALRENEW') > 0) then
		local renew = HealPointsSpells:getSpell(HPC_SPELL_RENEW, HealPointsBS:GetBonus('GHEALRENEW'));
		return (out - renew['avg'] - healing) / spell['time']; -- Remove renew-effect from HP/s.
	else
		return out/spell['time'];
	end
end

local function getHPMana(spell, healing, spellCrit)
	local hpcast = getHPCast(spell, healing, spellCrit);
	local manaCost = spell['mana'];
	manaCost = manaCost * (1 - (spellCrit / 100) * 0.20 * HealPointsUtil:getTalentRank(HPC_TALENT_ILLUMI));
	if (spell['name'] == HPC_SPELL_LHW or spell['name'] == HPC_SPELL_HW) then
		manaCost = manaCost * (1 - 0.25 * HealPointsBS:GetBonus('REFUNDHEALINGWAVE') / 100);
	end
	if (spell['name'] == HPC_SPELL_HT) then
		manaCost = manaCost * (1 - (spellCrit / 100) * 0.01 * HealPointsBS:GetBonus('REFUNDHTCRIT'));
	end
	return hpcast / manaCost;
end

local function getHPTotalRegen(spell, healing, spellCrit, manaRegenCasting, mana)
	local manaCost = spell['mana'];
	manaCost = manaCost * (1 - (spellCrit / 100) * 0.20 * HealPointsUtil:getTalentRank(HPC_TALENT_ILLUMI));
	if (spell['name'] == HPC_SPELL_LHW or spell['name'] == HPC_SPELL_HW) then
		manaCost = manaCost * (1 - 0.25 * HealPointsBS:GetBonus('REFUNDHEALINGWAVE') / 100);
	end
	if (spell['name'] == HPC_SPELL_HT) then
		manaCost = manaCost * (1 - (spellCrit / 100) * 0.01 * HealPointsBS:GetBonus('REFUNDHTCRIT'));
	end
	local manaRegen = spell['time'] * (manaRegenCasting / 5);
	if (spell['type'] == 'regrowth') then
		manaRegen = (spell['time'] + spell['hottime']) * (manaRegenCasting / 5);
	end
	local manaUsageSpell = manaCost - manaRegen;
	
	local hpPerCast = getHPCast(spell, healing, spellCrit);
	local hpPerMana = hpPerCast / manaUsageSpell;
	local hpPerManaBar = hpPerMana * mana;
	
	local numberCasts = mana / manaUsageSpell;
	local totalTime = numberCasts * spell['time'];
	if (spell['type'] == 'regrowth') then
		totalTime = numberCasts * (spell['time'] + spell['hottime']);
	end
	
	return hpPerManaBar, totalTime;
end

local function computeTotalHealing(spell, hps, healing, seconds, startMana, spellCrit, manaRegenCasting, manaRegenNormal, manaRegainFactor)
	--DEFAULT_CHAT_FRAME:AddMessage("Computing total healing for "..spell['name'].."("..spell['rank']..")  secs="..seconds.."  mana="..startMana,1,1,1);

	if (spell['name'] == HPC_SPELL_LHW or spell['name'] == HPC_SPELL_HW) then
		manaRegainFactor = manaRegainFactor * (1 - 0.25 * HealPointsBS:GetBonus('REFUNDHEALINGWAVE') / 100);
	elseif (spell['name'] == HPC_SPELL_HT) then
		manaRegainFactor = manaRegainFactor * (1 - (spellCrit / 100) * 0.01 * HealPointsBS:GetBonus('REFUNDHTCRIT'));		
	end
	
  if (spell['name'] == HPC_SPELL_GH and HealPointsBS:GetBonus('GHEALRENEW') > 0) then
    local healFactor = 1;
    if (spell['level'] < 20) then
      healFactor = 1 - ((20 - spell['level']) * 0.0375);
    end
		local renew = HealPointsSpells:getSpell(HPC_SPELL_RENEW, HealPointsBS:GetBonus('GHEALRENEW'));

    -- Phase 1: Has mana to chain-cast
    local manaUsageSpell = spell['mana'] * manaRegainFactor;
    local manaUsageSecond = (manaUsageSpell / spell['time']) - (manaRegenCasting / 5);
    local secondsPhase1 = math.min(seconds, startMana / manaUsageSecond);
    local secsBetweenSameTarget = HealPoints.db.char.hot['numtargets'] * spell['time'];
    if (HealPoints.db.char.hot['numtargets'] == 0) then
      secsBetweenSameTarget = spell['time'];
    end
    local ticsPerCast = secsBetweenSameTarget / 3;
    ticsPerCast = math.min(ticsPerCast, renew['time'] / 3);
    local spellsCast = secondsPhase1 / spell['time'];

    local burstHealed = secondsPhase1 * hps;
    local hotHealed = spellsCast * ticsPerCast * (renew['avg'] + ((healFactor * healing) / (15 / (math.min(renew['time'], 15)))))* 3 / renew['time'];    
    local totalHealed = burstHealed + hotHealed;
    
    -- Phase 2: Has no mana left
    local secondsPhase2 = seconds - secondsPhase1;
    if (secondsPhase2 > 0) then
      local cycleTime;                      -- Seconds between each casting
      if (manaRegenCasting > manaUsageSpell) then 	-- chaincast inside 5s rule
        local secs = manaUsageSpell / (manaRegenCasting / 5);
        cycleTime = math.max(secs, spell['time']);
      else
        local manaToRegen = manaUsageSpell - manaRegenCasting;
        cycleTime = 5 + manaToRegen / (manaRegenNormal / 5);
      end
      secsBetweenSameTarget = HealPoints.db.char.hot['numtargets'] * cycleTime;
      if (HealPoints.db.char.hot['numtargets'] == 0) then
        secsBetweenSameTarget = cycleTime;
      end
      ticsPerCast = secsBetweenSameTarget / 3;
      ticsPerCast = math.min(ticsPerCast, renew['time'] / 3);
      spellsCast = secondsPhase2 / cycleTime;
      burstHealed = secondsPhase2 * hps * spell['time'] / cycleTime;
      hotHealed = spellsCast * ticsPerCast * (renew['avg'] + ((healFactor * healing) / (15 / (math.min(renew['time'], 15)))))* 3 / renew['time'];
      local healedPhase2 = burstHealed + hotHealed;
      totalHealed = totalHealed + healedPhase2;
    end
    return totalHealed;

  elseif (spell['name'] == HPC_SPELL_REGR) then
    local healFactor = 1;
    if (spell['level'] < 20) then
      healFactor = 1 - ((20 - spell['level']) * 0.0375);
    end

    -- Phase 1: Has mana to chain-cast
    local manaUsageSpell = spell['mana'] * manaRegainFactor;
    local manaUsageSecond = (manaUsageSpell / spell['time']) - (manaRegenCasting / 5);
    local secondsPhase1 = math.min(seconds, startMana / manaUsageSecond);
    local secsBetweenSameTarget = HealPoints.db.char.hot['numtargets'] * spell['time'];
    if (HealPoints.db.char.hot['numtargets'] == 0) then
      secsBetweenSameTarget = spell['time'];
    end
    local ticsPerCast = secsBetweenSameTarget / 3;
    ticsPerCast = math.min(ticsPerCast, spell['hottime'] / 3);
    local spellsCast = secondsPhase1 / spell['time'];

    local burstHealed = spellsCast * (spell['avg'] + ((healFactor * healing / 2) / (3.5 / (math.min(spell['orgtime'], 3.5)))));
    burstHealed = burstHealed + ((spellCrit + HealPointsCalculator.HPC_ExtraRegrowthCrit) / 200) * burstHealed;		-- Crit adds 50% for non-hot
    local hotHealed = spellsCast * ticsPerCast * (spell['hotavg'] + ((healFactor * healing / 2) / (15 / (math.min(spell['hottime'], 15)))))* 3 / spell['hottime'];
    
    local totalHealed = burstHealed + hotHealed;
    
    -- Phase 2: Has no mana left
    local secondsPhase2 = seconds - secondsPhase1;
    if (secondsPhase2 > 0) then
      local cycleTime;                      -- Seconds between each casting
      if (manaRegenCasting > manaUsageSpell) then 	-- chaincast inside 5s rule
        local secs = manaUsageSpell / (manaRegenCasting / 5);
        cycleTime = math.max(secs, spell['time']);
      else
        local manaToRegen = manaUsageSpell - manaRegenCasting;
        cycleTime = 5 + manaToRegen / (manaRegenNormal / 5);
      end
      secsBetweenSameTarget = HealPoints.db.char.hot['numtargets'] * cycleTime;
      if (HealPoints.db.char.hot['numtargets'] == 0) then
        secsBetweenSameTarget = cycleTime;
      end
      ticsPerCast = secsBetweenSameTarget / 3;
      ticsPerCast = math.min(ticsPerCast, spell['hottime'] / 3);
      spellsCast = secondsPhase2 / cycleTime;
      burstHealed = spellsCast * (spell['avg'] + ((healFactor * healing / 2) / (3.5 / (math.min(spell['orgtime'], 3.5)))));
      burstHealed = burstHealed + ((spellCrit + HealPointsCalculator.HPC_ExtraRegrowthCrit) / 200) * burstHealed;		-- Crit adds 50% for non-hot
      hotHealed = spellsCast * ticsPerCast * (spell['hotavg'] + ((healFactor * healing / 2) / (15 / (math.min(spell['hottime'], 15)))))* 3 / spell['hottime'];
      local healedPhase2 = burstHealed + hotHealed;
      totalHealed = totalHealed + healedPhase2;
      --DEFAULT_CHAT_FRAME:AddMessage("Cycletime phase2 "..cycleTime,1,1,1);
      --DEFAULT_CHAT_FRAME:AddMessage("Seconds phase2 "..secondsPhase2,1,1,1);
      --DEFAULT_CHAT_FRAME:AddMessage("Healed phase2 "..healedPhase2,1,1,1);		
      --DEFAULT_CHAT_FRAME:AddMessage("Secs between target "..secsBetweenSameTarget,1,1,1);		
      --DEFAULT_CHAT_FRAME:AddMessage("Tics per target "..ticsPerCast,1,1,1);		
    end
    return totalHealed;
      
  else
    -- Phase 1: Has mana to chain-cast
    local manaUsageSpell = spell['mana'] * manaRegainFactor;
    local manaUsageSecond = (manaUsageSpell / spell['time']) - (manaRegenCasting / 5);
    local secondsPhase1 = math.min(seconds, startMana / manaUsageSecond);
    local totalHealed = secondsPhase1 * hps;		
    --DEFAULT_CHAT_FRAME:AddMessage("Seconds phase1 "..secondsPhase1,1,1,1);
    --DEFAULT_CHAT_FRAME:AddMessage("Healed phase1 "..totalHealed,1,1,1);

    -- Phase 2: Has no mana left
    local secondsPhase2 = seconds - secondsPhase1;
    if (secondsPhase2 > 0) then
      local cycleTime;                      -- Seconds between each casting
      if (manaRegenCasting > manaUsageSpell) then 	-- chaincast inside 5s rule
        local secs = manaUsageSpell / (manaRegenCasting / 5);
        cycleTime = math.max(secs, spell['time']);
      else
        local manaToRegen = manaUsageSpell - manaRegenCasting;
        cycleTime = 5 + manaToRegen / (manaRegenNormal / 5);
      end
      local hpsPhase2 = hps * spell['time'] / cycleTime;
      local healedPhase2 = hpsPhase2 * secondsPhase2;
      totalHealed = totalHealed + healedPhase2;
      --DEFAULT_CHAT_FRAME:AddMessage("Cycletime phase2 "..cycleTime,1,1,1);
      --DEFAULT_CHAT_FRAME:AddMessage("Seconds phase2 "..secondsPhase2,1,1,1);
      --DEFAULT_CHAT_FRAME:AddMessage("Healed phase2 "..healedPhase2,1,1,1);		
    end
    return totalHealed;
  end
end

local function computeTotalHealingHot(spell, hps, seconds, numtargets, startMana, manaRegenCasting, manaRegenNormal)
	-- Phase 1: Has enough mana/regen to keep the HoT up on numtargets constantly
  local cycleTime = math.max(spell['time'], numtargets * 1.5); -- time between casts on the same target
  local manaUsageCycle = numtargets * spell['mana'];
  local regenTimeCasting = math.min(cycleTime, 5 + (numtargets - 1) * 1.5);
  local regenTimeNormal = math.max(0, cycleTime - regenTimeCasting);
  local manaRegainCycle = regenTimeCasting * (manaRegenCasting / 5) + regenTimeNormal * (manaRegenNormal / 5);
  local healingPerCycle = numtargets * hps * spell['time'];
  local numCycles = seconds / cycleTime;
  if (manaRegainCycle < manaUsageCycle) then -- if you regen more than you use, you'll never go oom.
      numCycles = math.min(numCycles, startMana / (manaUsageCycle - manaRegainCycle));
  end
  local secondsPhase1 = numCycles * cycleTime;
  local totalHealed = numCycles * healingPerCycle;
	--DEFAULT_CHAT_FRAME:AddMessage("Seconds phase1 "..secondsPhase1,1,1,1);
	--DEFAULT_CHAT_FRAME:AddMessage("Healed phase1 "..totalHealed,1,1,1);
  --DEFAULT_CHAT_FRAME:AddMessage("NumCycles phase1 "..numCycles,1,1,1);

	-- Phase 2: Has no mana left
	local secondsPhase2 = seconds - secondsPhase1;
	if (secondsPhase2 > 0) then
    local manaToRegen = manaUsageCycle - regenTimeCasting * (manaRegenCasting / 5);
		cycleTime = regenTimeCasting + manaToRegen / (manaRegenNormal / 5);                      
    numCycles = secondsPhase2 / cycleTime;
    local healedPhase2 = numCycles * healingPerCycle;
		totalHealed = totalHealed + healedPhase2;
		--DEFAULT_CHAT_FRAME:AddMessage("Cycletime phase2 "..cycleTime,1,1,1);
		--DEFAULT_CHAT_FRAME:AddMessage("Seconds phase2 "..secondsPhase2,1,1,1);
		--DEFAULT_CHAT_FRAME:AddMessage("Healed phase2 "..healedPhase2,1,1,1);		
    --DEFAULT_CHAT_FRAME:AddMessage("NumCycles phase2 "..numCycles,1,1,1);
	end
	return totalHealed;
end

local function computePowerPoints(healing, spellCrit, maxMana, manaRegenCasting, manaRegenNormal, manaRegainFactor) 
  local mana = HealPoints.db.char.power['mana'] * maxMana / 100;
	if (HealPoints.db.char.power['auto'] == true) then
		local powerfulSpell;
		local maxPowerPoints = 0;

		for i = 1, 3 do 
			local spell = HealPointsSpells:getHighestKnownSpell(HealPointsSpells.SPELLTABLE[i]);
			if (spell ~= nil and (spell['type'] == 'normal' or spell['type'] == 'chain' or spell['type'] == 'hot' or spell['type'] == 'regrowth')) then
				spell = HealPointsSpells:updateSpellTalents(spell);
				local hps = getHPSec(spell, healing, spellCrit);
				local powerPoints;
				if (spell['type'] == 'hot') then
					powerPoints = computeTotalHealingHot(spell, hps, 60 * HealPoints.db.char.power['duration'], HealPoints.db.char.hot['numtargets'], mana, manaRegenCasting, manaRegenNormal);
				else
					powerPoints = computeTotalHealing(spell, hps, healing, 60 * HealPoints.db.char.power['duration'], mana, spellCrit, manaRegenCasting, manaRegenNormal, manaRegainFactor);
				end
				if (powerPoints > maxPowerPoints) then
					powerfulSpell = spell;
					maxPowerPoints = powerPoints;
				end
			end
		end
		return maxPowerPoints, powerfulSpell;

	else
		local powerfulSpell = HealPointsSpells:getSpell(HealPoints.db.char.power['spell'], HealPoints.db.char.power['rank']);
		powerfulSpell = HealPointsSpells:updateSpellTalents(powerfulSpell);
		local hps = getHPSec(powerfulSpell, healing, spellCrit);
		local powerPoints;
		if (powerfulSpell['type'] == 'hot') then
			powerPoints = computeTotalHealingHot(powerfulSpell, hps, 60 * HealPoints.db.char.power['duration'], HealPoints.db.char.hot['numtargets'], mana, manaRegenCasting, manaRegenNormal);
		else
			powerPoints = computeTotalHealing(powerfulSpell, hps, healing, 60 * HealPoints.db.char.power['duration'], mana, spellCrit, manaRegenCasting, manaRegenNormal, manaRegainFactor);
		end
		return powerPoints, powerfulSpell;
	end	
end

local function computeEndurancePoints(healing, spellCrit, maxMana, manaRegenCasting, manaRegenNormal, manaRegainFactor) 
  local mana = HealPoints.db.char.endurance['mana'] * maxMana / 100;
	if (HealPoints.db.char.endurance['auto'] == true) then
		local efficientSpell = nil;
		local maxEndurancePoints = 0;
		
		for i = 1, 3, 1 do
			for j = 1, table.getn(HealPointsSpells.SPELLTABLE[i]), 1 do
				local spell = HealPointsSpells.SPELLTABLE[i][j];
				if (spell ~= nil and (spell['type'] == 'normal' or spell['type'] == 'chain' or spell['type'] == 'hot' or spell['type'] == 'regrowth') and HealPointsSpells:getHighestSpellRank(spell['name']) >= spell['rank']) then
					spell = HealPointsSpells:updateSpellTalents(spell);
					local hps = getHPSec(spell, healing, spellCrit);
					local endurancePoints;
					if (spell['type'] == 'hot') then
						endurancePoints = computeTotalHealingHot(spell, hps, 60 * HealPoints.db.char.endurance['duration'], HealPoints.db.char.hot['numtargets'], mana, manaRegenCasting, manaRegenNormal);
					else
						endurancePoints = computeTotalHealing(spell, hps, healing, 60 * HealPoints.db.char.endurance['duration'], mana, spellCrit, manaRegenCasting, manaRegenNormal, manaRegainFactor);
					end
					if (endurancePoints > maxEndurancePoints) then
						efficientSpell = spell;
						maxEndurancePoints = endurancePoints;
					end			
				end
			end
		end
		return maxEndurancePoints, efficientSpell;

	else
		local efficientSpell = HealPointsSpells:getSpell(HealPoints.db.char.endurance['spell'], HealPoints.db.char.endurance['rank']);
		efficientSpell = HealPointsSpells:updateSpellTalents(efficientSpell);
		local hps = getHPSec(efficientSpell, healing, spellCrit);
		local endurancePoints;
		if (efficientSpell['type'] == 'hot') then
			endurancePoints = computeTotalHealingHot(efficientSpell, hps, 60 * HealPoints.db.char.endurance['duration'], HealPoints.db.char.hot['numtargets'], mana, manaRegenCasting, manaRegenNormal);
		else
			endurancePoints = computeTotalHealing(efficientSpell, hps, healing, 60 * HealPoints.db.char.endurance['duration'], mana, spellCrit, manaRegenCasting, manaRegenNormal, manaRegainFactor);
		end
		return endurancePoints, efficientSpell;
	end
end

local function computeHealpoints(healing, spellCrit, maxMana, manaRegenCasting, manaRegenNormal)
	local manaRegainOnCrit = 0.20 * HealPointsUtil:getTalentRank(HPC_TALENT_ILLUMI);
	local manaRegainFactor = 1 - (spellCrit / 100) * manaRegainOnCrit;
	local powerPoints, powerfulSpell = computePowerPoints(healing, spellCrit, maxMana, manaRegenCasting, manaRegenNormal, manaRegainFactor);
	local endurancePoints, efficientSpell = computeEndurancePoints(healing, spellCrit, maxMana, manaRegenCasting, manaRegenNormal, manaRegainFactor);
	
	-- Healpoints
	local healPoints = powerPoints + endurancePoints;

	return healPoints, powerPoints, endurancePoints, powerfulSpell, efficientSpell;
end

-- Compute old and new values
local function getCurrentAndNewManaRegen(spirit, itemNormalRegen, itemCastingRegen)
	local function getRegenSpirit(spi)																												
		local _, className = UnitClass("player");	
		local regen = 0;
		if (className == "PRIEST") then
			regen = 13 + spi / 4;
		else
			regen = 15 + spi / 5; -- paladin, druid, shaman
		end
		return regen * 2.5; -- convert from /2s til /5s
	end

	local talentMeditation = HealPointsUtil:getTalentRank(HPC_TALENT_MEDITA);	-- 5% spi mana regen while casting per rank (priest)
	local talentReflection = HealPointsUtil:getTalentRank(HPC_TALENT_REFLEC); 	-- 5% spi mana regen while casting per rank (druid)
	local percentRegen = 0.05 * talentMeditation + 0.05 * talentReflection + HealPointsBS:GetBonus('CASTINGREG') / 100;

	local manaRegenSpirit = getRegenSpirit(spirit);
	local manaRegen5 = itemCastingRegen;

	if (HealPointsUtil:isPlayerBuffUp("INV_Potion_45")) then -- Mageblood potion
		manaRegen5 = manaRegen5 + 12;
	end
	if (HealPointsUtil:isPlayerBuffUp("Spell_Nature_ManaRegenTotem")) then -- Nightfin soup
		manaRegen5 = manaRegen5 + 8;
	end
	
	local manaRegenNormal = manaRegenSpirit + manaRegen5 + itemNormalRegen;
	local manaRegenCasting = manaRegen5 + percentRegen * (manaRegenSpirit + itemNormalRegen);

	local spiDelta = getglobal("HealPointsVariables2InputBox"):GetNumber() * (1 + HealPointsCalculator.HPC_ExtraSpi);
	local spiritNew = spirit + spiDelta;
	local percentRegenNew = percentRegen + getglobal("HealPointsVariables6InputBox"):GetNumber() / 100;
	local manaRegen5New = manaRegen5 + getglobal("HealPointsVariables4InputBox"):GetNumber();
	local manaRegenSpiritNew = getRegenSpirit(spiritNew);

	local manaRegenNormalNew = manaRegenSpiritNew + manaRegen5New + itemNormalRegen + getglobal("HealPointsVariables5InputBox"):GetNumber();
	local manaRegenCastingNew = manaRegen5New + percentRegenNew * (manaRegenSpiritNew + itemNormalRegen + getglobal("HealPointsVariables5InputBox"):GetNumber());
	return manaRegenNormal, manaRegenCasting, manaRegenNormalNew, manaRegenCastingNew, percentRegen;
end

local function getCurrentAndNewMaxMana(mana, itemIntDelta)
	local itemIntDelta = HealPointsUtil:round(itemIntDelta * (1 + HealPointsCalculator.HPC_ExtraInt));
	local currentMana = mana + (15 * itemIntDelta) * (1 + HealPointsCalculator.HPC_ExtraMana);
	
	local intDelta = getglobal("HealPointsVariables1InputBox"):GetNumber() * (1 + HealPointsCalculator.HPC_ExtraInt);
	local newMana = currentMana + (getglobal("HealPointsVariables3InputBox"):GetNumber() + 15 * intDelta) * (1 + HealPointsCalculator.HPC_ExtraMana);
	return currentMana, newMana;
end

local function getCurrentAndNewHealing(spirit, healing)
	local currentHealing = healing;
	local newHealing = currentHealing + getglobal("HealPointsVariables7InputBox"):GetNumber();

	local spiritualGuidance = HealPointsUtil:getTalentRank(HPC_TALENT_SPIGUI);
	local _, currentSpirit = UnitStat("player", 5);
	currentHealing = currentHealing + spiritualGuidance * 0.05 * currentSpirit;
	local newSpirit = currentSpirit + getglobal("HealPointsVariables2InputBox"):GetNumber() * (1 + HealPointsCalculator.HPC_ExtraSpi);
	newHealing = newHealing + spiritualGuidance * 0.05 * newSpirit;

	return currentHealing, newHealing;
end

local function getCurrentAndNewSpellCrit(intellect, itemCrit)
	local baseCrit = 0;
	local intPerCrit = 0;

	local _, className = UnitClass("player");
	if (className == "PALADIN") then
		intPerCrit = 30; 
	elseif (className == "PRIEST") then
		baseCrit = 0.8;
		intPerCrit = 59.5;
	elseif (className == "DRUID") then
		baseCrit = 1.8;
		intPerCrit = 60;
	elseif (className == "SHAMAN") then
		baseCrit = 2.3;
		intPerCrit = 59.2;
	end

	local talentCrit = HealPointsUtil:getTalentRank(HPC_TALENT_HOLSPE) + HealPointsUtil:getTalentRank(HPC_TALENT_TIDMAS) + HealPointsUtil:getTalentRank(HPC_TALENT_HOLPOW);
	local buffCrit = 0;
	if (HealPointsUtil:isPlayerBuffUp("Spell_Nature_MoonGlow")) then -- Moonkin aura
		buffCrit = buffCrit + 3;
	end
--	if (HealPointsUtil:isPlayerBuffUp("Spell_Holy_MindVision")) then -- Songflower serenade, disabled due to confict with sanctity aura
--		buffCrit = buffCrit + 5;
--	end
	if (HealPointsUtil:isPlayerBuffUp("INV_Misc_Head_Dragon_01")) then -- Rallying cry of the dragonslayer
		buffCrit = buffCrit + 10;
	end
	if (HealPointsUtil:isPlayerBuffUp("Spell_Holy_LesserHeal02")) then -- Slip'kik's Savvy
		buffCrit = buffCrit + 3;
	end	
	
	local currentSpellCrit = baseCrit + (intellect/intPerCrit) + itemCrit + talentCrit + buffCrit;

	local intDelta = getglobal("HealPointsVariables1InputBox"):GetNumber();
	intDelta = intDelta + HealPointsCalculator.HPC_ExtraInt * intDelta;
	local newSpellCrit = currentSpellCrit + getglobal("HealPointsVariables8InputBox"):GetNumber() + intDelta / intPerCrit;
	return currentSpellCrit, newSpellCrit;
end

-- Update functions
function HealPointsCalculator:updateStats() 		-- Update stats (int, spi, regen, ...)																				
	-- Intellect
	local _, currentIntellect, _, _ = UnitStat("player", 4);
	local intDelta = getglobal("HealPointsVariables1InputBox"):GetNumber();
	local extraInt = HealPointsCalculator.HPC_ExtraInt * intDelta;
	HealPointsCalculatorUI:setStatInfo(1, "Intellect:", currentIntellect, extraInt, "%5.0f");
	intDelta = intDelta + extraInt;
	
	-- Spirit
	local _, currentSpirit, _, _ = UnitStat("player", 5);
	local extraSpi = HealPointsCalculator.HPC_ExtraSpi * getglobal("HealPointsVariables2InputBox"):GetNumber();
	HealPointsCalculatorUI:setStatInfo(2, "Spirit:", currentSpirit, extraSpi, "%5.0f");

	-- Max mana															
	local currentMana = UnitManaMax("player");
	local extraMana = HealPointsCalculator.HPC_ExtraMana * (getglobal("HealPointsVariables3InputBox"):GetNumber() + 15 * intDelta);
	HealPointsCalculatorUI:setStatInfo(3, "Max mana:", currentMana, 15 * intDelta + extraMana, "%5.0f");
	
	-- Mana regen (casting, normal, %casting)
	local manaRegenNormal, manaRegenCasting, manaRegenNormalNew, manaRegenCastingNew, percentRegen = 
		getCurrentAndNewManaRegen(currentSpirit, HealPointsBS:GetBonus('MANAREGNORMAL'), HealPointsBS:GetBonus('MANAREG'));
	local manaRegenCastingDelta = manaRegenCastingNew - manaRegenCasting - getglobal("HealPointsVariables4InputBox"):GetNumber();
	local manaRegenNormalDelta = manaRegenNormalNew - manaRegenNormal - getglobal("HealPointsVariables5InputBox"):GetNumber();
	
	HealPointsCalculatorUI:setStatInfo(4, "Casting regen/5s:", manaRegenCasting, manaRegenCastingDelta, "%5.0f");
	HealPointsCalculatorUI:setStatInfo(5, "Normal regen/5s:", manaRegenNormal, manaRegenNormalDelta, "%5.0f");
	HealPointsCalculatorUI:setStatInfo(6, "% regen while casting:", 100 * percentRegen, 0, "%5.0f");
	
	-- +Healing
	local currentHealing, newHealing = getCurrentAndNewHealing(currentSpirit, HealPointsBS:GetBonus('HEAL'));
	HealPointsCalculatorUI:setStatInfo(7, "+Healing:", currentHealing, newHealing - currentHealing - getglobal("HealPointsVariables7InputBox"):GetNumber());
	
	-- Spell crit														
	local currentSpellCrit, newSpellCrit = getCurrentAndNewSpellCrit(currentIntellect, HealPointsBS:GetBonus('SPELLCRIT') + HealPointsBS:GetBonus('HOLYCRIT') + HealPointsBS:GetBonus('NATURECRIT'));
	HealPointsCalculatorUI:setStatInfo(8, "Healing spell crit(%):", currentSpellCrit, newSpellCrit - currentSpellCrit - getglobal("HealPointsVariables8InputBox"):GetNumber(), "%1.2f");
end

function HealPointsCalculator:updateSpellStats() 	-- Update derived stats about selected spellranks 
  local _, currentIntellect, _, _ = UnitStat("player", 4);
	local _, currentSpirit, _, _ = UnitStat("player", 5);
	local _, manaRegenCasting, _, manaRegenCastingNew = getCurrentAndNewManaRegen(currentSpirit, HealPointsBS:GetBonus('MANAREGNORMAL'), HealPointsBS:GetBonus('MANAREG'));
	local currentMana, newMana = getCurrentAndNewMaxMana(UnitManaMax("player"), 0);
	local currentHealing, newHealing = getCurrentAndNewHealing(currentSpirit, HealPointsBS:GetBonus('HEAL'));
	local currentSpellCrit, newSpellCrit = getCurrentAndNewSpellCrit(currentIntellect, HealPointsBS:GetBonus('SPELLCRIT') + HealPointsBS:GetBonus('HOLYCRIT') + HealPointsBS:GetBonus('NATURECRIT'));	

	local spellString = { "Short", "Long", "HOT" }; -- GUI-related
	
	for i = 1, 3 do
		if (HealPointsCalculatorUI.SELECTED[i] ~= nil) then
      -- HP/s
			local oldHPSec = getHPSec(HealPointsCalculatorUI.SELECTED[i], currentHealing, currentSpellCrit);
			local newHPSec = getHPSec(HealPointsCalculatorUI.SELECTED[i], newHealing, newSpellCrit);
			HealPointsCalculatorUI:setSpellInfo(1, spellString[i], oldHPSec, newHPSec, "%d");

      -- HP/mana
			local oldHPMana = getHPMana(HealPointsCalculatorUI.SELECTED[i], currentHealing, currentSpellCrit);
			local newHPMana = getHPMana(HealPointsCalculatorUI.SELECTED[i], newHealing, newSpellCrit);
			HealPointsCalculatorUI:setSpellInfo(2, spellString[i], oldHPMana, newHPMana, "%1.1f");

      -- HP/cast
			local oldHPCast = getHPCast(HealPointsCalculatorUI.SELECTED[i], currentHealing, currentSpellCrit);
			local newHPCast = getHPCast(HealPointsCalculatorUI.SELECTED[i], newHealing, newSpellCrit);
			HealPointsCalculatorUI:setSpellInfo(3, spellString[i], oldHPCast, newHPCast, "%d");

      -- Max heal (no regen)
			local oldHPTotal = oldHPMana * currentMana;
			local newHPTotal = newHPMana * newMana;
			HealPointsCalculatorUI:setSpellInfo(4, spellString[i], oldHPTotal, newHPTotal, "%d");
	
      -- Max heal (regen)
			local oldHPTotalRegen, t1 = getHPTotalRegen(HealPointsCalculatorUI.SELECTED[i], currentHealing, currentSpellCrit, manaRegenCasting, currentMana);
			local newHPTotalRegen, t2 = getHPTotalRegen(HealPointsCalculatorUI.SELECTED[i], newHealing, newSpellCrit, manaRegenCastingNew, newMana);
			HealPointsCalculatorUI:setSpellInfo(5, spellString[i], oldHPTotalRegen, newHPTotalRegen, "%d");
			self.TH_TotalTimeCurrent[i] = t1;
			self.TH_TotalTimeNew[i] = t2;
		end	
	end
end

function HealPointsCalculator:updateHealPoints() -- Update the healpoints statistic
	local _, currentIntellect, _, _ = UnitStat("player", 4);
	local _, currentSpirit, _, _ = UnitStat("player", 5);
	local manaRegenNormal, manaRegenCasting, manaRegenNormalNew, manaRegenCastingNew = getCurrentAndNewManaRegen(currentSpirit, HealPointsBS:GetBonus('MANAREGNORMAL'), HealPointsBS:GetBonus('MANAREG'));
	local currentMana, newMana = getCurrentAndNewMaxMana(UnitManaMax("player"), 0);
	local currentHealing, newHealing = getCurrentAndNewHealing(currentSpirit, HealPointsBS:GetBonus('HEAL'));
	local currentSpellCrit, newSpellCrit = getCurrentAndNewSpellCrit(currentIntellect, HealPointsBS:GetBonus('SPELLCRIT') + HealPointsBS:GetBonus('HOLYCRIT') + HealPointsBS:GetBonus('NATURECRIT'));	
	
	local healPointsCurrent, healedPowerful, healedEfficient, powerfulCurrent, efficientCurrent =
		computeHealpoints(currentHealing, currentSpellCrit, currentMana, manaRegenCasting, manaRegenNormal);
	
	local healPointsNew, healedPowerfulNew, healedEfficientNew, powerfulNew, efficientNew =
		computeHealpoints(newHealing, newSpellCrit, newMana, manaRegenCastingNew, manaRegenNormalNew);
	
	self.HP_LastPowerfulCurrent = powerfulCurrent;
	self.HP_LastPowerfulNew = powerfulNew;
	self.HP_LastEfficientCurrent = efficientCurrent;
	self.HP_LastEfficientNew = efficientNew;
	
  if (HealPoints_CalcFrame:IsVisible()) then
    HealPointsCalculatorUI:setHealPoints(healedPowerful, healedPowerfulNew, healedEfficient, healedEfficientNew);
  end
  if (CharacterFrame:IsVisible()) then
    HealPointsCharUI:setStats(healPointsCurrent, manaRegenCasting, manaRegenNormal, currentHealing, currentSpellCrit);
  end
end

-- Global functions
function HealPointsCalculator:computeHealpointsDiff(frame, itemLink)
	local function lookup(table, index)
		if (table[index] == nil) then
			return 0;
		end
		return table[index];
	end

	local function computeHP(itemBonuses, slotBonuses)
		local _, currentIntellect = UnitStat("player", 4);
		local _, currentSpirit = UnitStat("player", 5);
		local itemIntellect = HealPointsUtil:round(currentIntellect - (lookup(slotBonuses, "INT") - lookup(itemBonuses, "INT")) * (1 + HealPointsCalculator.HPC_ExtraInt));
		local itemSpirit = HealPointsUtil:round(currentSpirit - (lookup(slotBonuses, "SPI") - lookup(itemBonuses, "SPI")) * (1 + HealPointsCalculator.HPC_ExtraSpi));
		local itemHealing = HealPointsBS:GetBonus('HEAL') - lookup(slotBonuses, "HEAL") + lookup(itemBonuses, "HEAL");
		local itemSpellCrit = HealPointsBS:GetBonus('SPELLCRIT') + HealPointsBS:GetBonus('HOLYCRIT') + HealPointsBS:GetBonus('NATURECRIT') - 
			lookup(slotBonuses, "SPELLCRIT") - lookup(slotBonuses, "HOLYCRIT") - lookup(slotBonuses, "NATURECRIT") + 
			lookup(itemBonuses, "SPELLCRIT") + lookup(itemBonuses, "HOLYCRIT") + lookup(itemBonuses, "NATURECRIT");
		local itemMana = HealPointsUtil:round(UnitManaMax("player") - (lookup(slotBonuses, "MANA") - lookup(itemBonuses, "MANA")) * (1 + HealPointsCalculator.HPC_ExtraMana));
		local itemManaNormal = HealPointsBS:GetBonus('MANAREGNORMAL') - lookup(slotBonuses, "MANAREGNORMAL") + lookup(itemBonuses, "MANAREGNORMAL");
		local itemMana5 = HealPointsBS:GetBonus('MANAREG') - lookup(slotBonuses, "MANAREG") + lookup(itemBonuses, "MANAREG");
	
		local iHealing, iHealingNew = getCurrentAndNewHealing(itemSpirit, itemHealing);
		local iSpellCrit, iSpellCritNew = getCurrentAndNewSpellCrit(itemIntellect, itemSpellCrit);
		local iMana, iManaNew = getCurrentAndNewMaxMana(itemMana, lookup(itemBonuses, "INT") - lookup(slotBonuses, "INT"));
		local iManaRegenNormal, iManaRegenCasting, iManaRegenNormalNew, iManaRegenCastingNew = getCurrentAndNewManaRegen(itemSpirit, itemManaNormal, itemMana5);
	
		--DEFAULT_CHAT_FRAME:AddMessage("Int, spi, +healing, mana/5, +crit: "..itemIntellect.." "..itemSpirit.." "..itemHealing.." "..itemMana5.." "..itemSpellCrit,0.5,0.3,1);
		local iHealPoints = computeHealpoints(iHealing, iSpellCrit, iMana, iManaRegenCasting, iManaRegenNormal);
		local iHealPointsNew = computeHealpoints(iHealingNew, iSpellCritNew, iManaNew, iManaRegenCastingNew, iManaRegenNormalNew);
		return iHealPoints, iHealPointsNew
	end
	
  local itemBonuses, slotBonuses, slotBonuses2 = HealPointsBS:getItemSlotBonuses(frame, itemLink);
  if (slotBonuses == nil) then
    return 0, 0;
  end

--	DEFAULT_CHAT_FRAME:AddMessage("New item:",1,1,1);
--	table.foreach(itemBonuses, HealPoints.Print);
--	DEFAULT_CHAT_FRAME:AddMessage("Old item:",1,1,1);
--	table.foreach(slotBonuses, HealPoints.Print);

	-- Current healpoints
	local _, currentIntellect = UnitStat("player", 4);
	local _, currentSpirit = UnitStat("player", 5);

	local healing, healingNew = getCurrentAndNewHealing(currentSpirit, HealPointsBS:GetBonus('HEAL'));
	local spellCrit, spellCritNew = getCurrentAndNewSpellCrit(currentIntellect, HealPointsBS:GetBonus('SPELLCRIT') + HealPointsBS:GetBonus('HOLYCRIT') + HealPointsBS:GetBonus('NATURECRIT'));
	local mana, manaNew = getCurrentAndNewMaxMana(UnitManaMax("player"), 0)
	local manaRegenNormal, manaRegenCasting, manaRegenNormalNew, manaRegenCastingNew = 
		getCurrentAndNewManaRegen(currentSpirit, HealPointsBS:GetBonus('MANAREGNORMAL'), HealPointsBS:GetBonus('MANAREG'));

	local healPoints = computeHealpoints(healing, spellCrit, mana, manaRegenCasting, manaRegenNormal);
	local healPointsNew = computeHealpoints(healingNew, spellCritNew, manaNew, manaRegenCastingNew, manaRegenNormalNew);

	-- Difference
	local iHealPoints, iHealPointsNew = computeHP(itemBonuses, slotBonuses);
	if (slotBonuses2) then
		local iHealPoints2, iHealPointsNew2 = computeHP(itemBonuses, slotBonuses2);
		return iHealPoints - healPoints, iHealPointsNew - healPointsNew, iHealPoints2 - healPoints, iHealPointsNew2 - healPointsNew;
	else
		return iHealPoints - healPoints, iHealPointsNew - healPointsNew;
	end
end

function HealPointsCalculator:init()
	local _, raceName = UnitRace("player");
	if (raceName == "Human") then
		HealPointsCalculator.HPC_ExtraSpi = 0.05;
	end
  self:talentsChanged(); -- Inital values
end

function HealPointsCalculator:talentsChanged()
	HealPointsCalculator.HPC_ExtraRegrowthCrit = 0;
	HealPointsCalculator.HPC_ExtraMana = 0;
	HealPointsCalculator.HPC_ExtraInt = 0;

	local _, className = UnitClass("player");	
	if (className == "PALADIN") then
		local divineIntellect = HealPointsUtil:getTalentRank(HPC_TALENT_DIVINT);  -- Increases intellect by 2% per rank
		HealPointsCalculator.HPC_ExtraInt = 0.02 * divineIntellect;
		
	elseif (className == "PRIEST") then
		local mentalStrength = HealPointsUtil:getTalentRank(HPC_TALENT_MENSTR); -- Increases maximum mana by 2% per rank
		HealPointsCalculator.HPC_ExtraMana = 0.02 * mentalStrength;

  elseif (className == "DRUID") then
		local improvedRegrowth = HealPointsUtil:getTalentRank(HPC_TALENT_IMPREG); -- Increases crit for Regrowth by 10% per rank
		HealPointsCalculator.HPC_ExtraRegrowthCrit = 10 * improvedRegrowth;
		
		local heartOfTheWild = HealPointsUtil:getTalentRank(HPC_TALENT_HEOFWI); -- Increases int by 4% per rank
		HealPointsCalculator.HPC_ExtraInt = 0.04 * heartOfTheWild;

  elseif (className == "SHAMAN") then
		local ancestralKnowledge = HealPointsUtil:getTalentRank(HPC_TALENT_ANCKNO); -- Increases maximum mana by 1% per rank
		HealPointsCalculator.HPC_ExtraMana = 0.01 * ancestralKnowledge;
	end
end