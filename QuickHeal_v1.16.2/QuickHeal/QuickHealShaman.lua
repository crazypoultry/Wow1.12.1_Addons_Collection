QuickHealShaman = {};

function QuickHealShaman:GetRatioHealthyExplanation()
    if QuickHealVariables.RatioHealthyShaman >= QuickHealVariables.RatioFull then
        return QUICKHEAL_SPELL_HEALING_WAVE .. " will never be used in combat. ";
    else
        if QuickHealVariables.RatioHealthyShaman > 0 then
            return QUICKHEAL_SPELL_HEALING_WAVE .. " will only be used in combat if the target has more than " .. QuickHealVariables.RatioHealthyShaman*100 .. "% life, and only if the healing done is greater than the greatest " .. QUICKHEAL_SPELL_LESSER_HEALING_WAVE .. " available. ";          
        else
            return QUICKHEAL_SPELL_HEALING_WAVE .. " will only be used in combat if the healing done is greater than the greatest " .. QUICKHEAL_SPELL_LESSER_HEALING_WAVE .. " available. ";         
        end
    end
end

function QuickHealShaman:FindSpellToUse(Target)
    local Spell = nil;
    local HealSize = 0;

    -- Determine health and healneed of target
    local healneed;
    local Health;
    if QuickHeal_UnitHasHealthInfo(Target) then
        -- Full info available
        healneed = UnitHealthMax(Target) - UnitHealth(Target);
        Health = UnitHealth(Target) / UnitHealthMax(Target);
    else
        -- Estimate target health
        healneed = QuickHeal_EstimateUnitHealNeed(Target,true);
        Health = UnitHealth(Target)/100;
    end

    local InCombat = UnitAffectingCombat('player') or UnitAffectingCombat(Target);

    local TargetIsHealthy = Health >= QuickHealVariables.RatioHealthyShaman;
    local ManaLeft = UnitMana('player');

    -- Detect Nature's Swiftness (next nature spell is instant cast)
    if QuickHeal_DetectBuff('player',"Spell_Nature_RavenForm") then
        QuickHeal_debug("BUFF: Nature's Swiftness (out of combat healing forced)");
        InCombat = false;
    end

    -- Detect proc of 'Hand of Edward the Odd' mace (next spell is instant cast)
    if QuickHeal_DetectBuff('player',"Spell_Holy_SearingLight") then
        QuickHeal_debug("BUFF: Hand of Edward the Odd (out of combat healing forced)");
        InCombat = false;
    end
    
    -- Get a list of ranks available of 'Lesser Healing Wave' and 'Healing Wave'
    local HW = self:GetSpellInfo(QUICKHEAL_SPELL_HEALING_WAVE,Target);
    local LHW = self:GetSpellInfo(QUICKHEAL_SPELL_LESSER_HEALING_WAVE,Target);
    QuickHeal_debug(string.format("Found HW up to rank %d and LHW up to rank %d", table.getn(HW), table.getn(LHW)));

    local k = 1.0;
    local K = 1.0;
    if InCombat then
        k = 0.9; -- In combat means that target is losing life while casting, so compensate           
        K = 0.8; -- k for fast spells (LHW and HW Rank 1 and 2) and K for slow spells (HW)
    end

    if LHW[1] and InCombat then Spell = LHW[1] else Spell = HW[1] end -- Default to LHW or HW
        if HW[2]  and healneed > HW[2].EffectiveHeal*k  and ManaLeft >= HW[2].Mana  and (not LHW[1] or not InCombat) then Spell = HW[2] end
        if HW[3]  and healneed > HW[3].EffectiveHeal*K  and ManaLeft >= HW[3].Mana  and (not LHW[1] or not InCombat) then Spell = HW[3] end
    if LHW[1] and healneed > LHW[1].EffectiveHeal*k and ManaLeft >= LHW[1].Mana then Spell = LHW[1] end
    if LHW[2] and healneed > LHW[2].EffectiveHeal*k and ManaLeft >= LHW[2].Mana then Spell = LHW[2] end
        if HW[4]  and healneed > HW[4].EffectiveHeal*K  and ManaLeft >= HW[4].Mana  and (TargetIsHealthy and not LHW[3] or not LHW[1] or not InCombat) then Spell = HW[4] end
    if LHW[3] and healneed > LHW[3].EffectiveHeal*k and ManaLeft >= LHW[3].Mana then Spell = LHW[3] end
        if HW[5]  and healneed > HW[5].EffectiveHeal*K  and ManaLeft >= HW[5].Mana  and (TargetIsHealthy and not LHW[4] or not LHW[1] or not InCombat)  then Spell = HW[5] end
    if LHW[4] and healneed > LHW[4].EffectiveHeal*k and ManaLeft >= LHW[4].Mana then Spell = LHW[4] end
        if HW[6]  and healneed > HW[6].EffectiveHeal*K  and ManaLeft >= HW[6].Mana  and (TargetIsHealthy and not LHW[5] or not LHW[1] or not InCombat) then Spell = HW[6] end
    if LHW[5] and healneed > LHW[5].EffectiveHeal*k and ManaLeft >= LHW[5].Mana then Spell = LHW[5] end
        if HW[7]  and healneed > HW[7].EffectiveHeal*K  and ManaLeft >= HW[7].Mana  and (TargetIsHealthy and not LHW[6] or not LHW[1] or not InCombat) then Spell = HW[7] end
    if LHW[6] and healneed > LHW[6].EffectiveHeal*k and ManaLeft >= LHW[6].Mana then Spell = LHW[6] end
        if HW[8]  and healneed > HW[8].EffectiveHeal*K  and ManaLeft >= HW[8].Mana  and (TargetIsHealthy or not LHW[1] or not InCombat) then Spell = HW[8] end
        if HW[9]  and healneed > HW[9].EffectiveHeal*K  and ManaLeft >= HW[9].Mana  and (TargetIsHealthy or not LHW[1] or not InCombat) then Spell = HW[9] end
        if HW[10] and healneed > HW[10].EffectiveHeal*K and ManaLeft >= HW[10].Mana and (TargetIsHealthy or not LHW[1] or not InCombat) then Spell = HW[10] end
    
    return Spell.SpellID, Spell.EffectiveHeal;
end

function QuickHealShaman:GetSpellInfo(spellName, Target)
    -- Get static spell info (cached by main module)
    local spellInfo = QuickHeal_GetSpellInfo(spellName);

    -- if BonusScanner is running, get +Healing bonus
    local Bonus = 0;
    if (BonusScanner) then
        Bonus = tonumber(BonusScanner:GetBonus("HEAL"));
    end

    -- Get total healing modifier (factor) caused by healing target debuffs
    local HDB = QuickHeal_GetHealModifier(Target);
    QuickHeal_debug("Target debuff healing modifier",HDB);

    -- Process individual spells TODO: add special handler for Chain Heal
    if spellName == QUICKHEAL_SPELL_LESSER_HEALING_WAVE then
        local i;
        for i = 1,table.getn(spellInfo) do
            spellInfo[i].EffectiveHeal = (spellInfo[i].Heal+(1.5/3.5)*Bonus)*HDB;
        end
    elseif spellName == QUICKHEAL_SPELL_HEALING_WAVE then
        local i;
        local PF = {0.2875, 0.475, 0.7, 0.925};
        local HM = {(1.5/3.5)*Bonus, (2.0/3.5)*Bonus, (2.5/3.5)*Bonus};

        -- Detect healing way on target
        local hwMod = QuickHeal_DetectBuff(Target,"Spell_Nature_HealingWay");
        if hwMod then hwMod = 1+0.06*hwMod else hwMod = 1 end;
        QuickHeal_debug("Healing Way healing modifier",hwMod);

        for i = 1,table.getn(spellInfo) do
            spellInfo[i].EffectiveHeal = (spellInfo[i].Heal*hwMod+(HM[i] or ((3.0/3.5)*Bonus))*(PF[i] or 1.0))*HDB;
        end
    elseif spellInfo[0] then
        -- Spell is rank-less
        spellInfo[0].EffectiveHeal = spellInfo[0].Heal;
    else
        -- Unknown spell (use scanned cast time for bonus calculation)
        local i;
        for i = 1,table.getn(spellInfo) do
            spellInfo[i].EffectiveHeal = (spellInfo[i].Heal+(spellInfo[i].Time/3.5)*Bonus)*HDB;
        end
    end

    return spellInfo;
end

function QuickHealShaman:GetRatioHealthy()
    return QuickHealVariables.RatioHealthyShaman;
end

function QuickHealShaman:CastCheckSpell()
    CastSpell(QuickHeal_GetSpellInfo(QUICKHEAL_SPELL_HEALING_WAVE)[1].SpellID, BOOKTYPE_SPELL);
end