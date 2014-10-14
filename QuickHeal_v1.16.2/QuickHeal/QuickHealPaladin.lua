QuickHealPaladin = {};

function QuickHealPaladin:GetRatioHealthyExplanation()
    if QuickHealVariables.RatioHealthyPaladin >= QuickHealVariables.RatioFull then
        return QUICKHEAL_SPELL_HOLY_LIGHT .. " will never be used in combat. ";
    else
        if QuickHealVariables.RatioHealthyPaladin > 0 then
            return QUICKHEAL_SPELL_HOLY_LIGHT .. " will only be used in combat if the target has more than " .. QuickHealVariables.RatioHealthyPaladin*100 .. "% life, and only if the healing done is greater than the greatest " .. QUICKHEAL_SPELL_FLASH_OF_LIGHT .. " available. ";          
        else
            return QUICKHEAL_SPELL_HOLY_LIGHT .. " will only be used in combat if the healing done is greater than the greatest " .. QUICKHEAL_SPELL_FLASH_OF_LIGHT .. " available. ";         
        end
    end
end

function QuickHealPaladin:FindSpellToUse(Target)
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

    local TargetIsHealthy = Health >= QuickHealVariables.RatioHealthyPaladin;
    local ManaLeft = UnitMana('player');

    -- Detect proc of 'Hand of Edward the Odd' mace (next spell is instant cast)
    if QuickHeal_DetectBuff('player',"Spell_Holy_SearingLight") then
        QuickHeal_debug("BUFF: Hand of Edward the Odd (out of combat healing forced)");
        InCombat = false;
    end

    -- Get a list of ranks available of 'Lesser Healing Wave' and 'Healing Wave'
    local HL = self:GetSpellInfo(QUICKHEAL_SPELL_HOLY_LIGHT, Target);
    local FL = self:GetSpellInfo(QUICKHEAL_SPELL_FLASH_OF_LIGHT, Target);
    QuickHeal_debug(string.format("Found HL up to rank %d, and found FL up to rank %d", table.getn(HL), table.getn(FL)))

    local k = 1.0;
    local K = 1.0;
    if InCombat then
        k = 0.9; -- In combat means that target is loosing life while casting, so compensate           
        K = 0.8; -- k for fast spells (LHW and HW Rank 1 and 2) and K for slow spells (HW)
    end

    Spell = FL[1] or HL[1]; -- Default to rank 1 of FL or HL
    if HL[2] and healneed > HL[2].EffectiveHeal*K and ManaLeft >= HL[2].Mana and not FL[2] and (TargetIsHealthy or not FL[1] or not InCombat) then Spell = HL[2] end
        if FL[2] and healneed > FL[2].EffectiveHeal*k and ManaLeft >= FL[2].Mana then Spell = FL[2] end
        if FL[3] and healneed > FL[3].EffectiveHeal*k and ManaLeft >= FL[3].Mana then Spell = FL[3] end
    if HL[3] and healneed > HL[3].EffectiveHeal*K and ManaLeft >= HL[3].Mana and not FL[4] and (TargetIsHealthy or not FL[1] or not InCombat) then Spell = HL[3] end
        if FL[4] and healneed > FL[4].EffectiveHeal*k and ManaLeft >= FL[4].Mana then Spell = FL[4] end
        if FL[5] and healneed > FL[5].EffectiveHeal*k and ManaLeft >= FL[5].Mana then Spell = FL[5] end
    if HL[4] and healneed > HL[4].EffectiveHeal*K and ManaLeft >= HL[4].Mana and not FL[6] and (TargetIsHealthy or not FL[1] or not InCombat) then Spell = HL[4] end
        if FL[6] and healneed > FL[6].EffectiveHeal*k and ManaLeft >= FL[6].Mana then Spell = FL[6] end
    if HL[5] and healneed > HL[5].EffectiveHeal*K and ManaLeft >= HL[5].Mana and (TargetIsHealthy or not FL[1] or not InCombat) then Spell = HL[5] end
    if HL[6] and healneed > HL[6].EffectiveHeal*K and ManaLeft >= HL[6].Mana and (TargetIsHealthy or not FL[1] or not InCombat) then Spell = HL[6] end
    if HL[7] and healneed > HL[7].EffectiveHeal*K and ManaLeft >= HL[7].Mana and (TargetIsHealthy or not FL[1] or not InCombat) then Spell = HL[7] end
    if HL[8] and healneed > HL[8].EffectiveHeal*K and ManaLeft >= HL[8].Mana and (TargetIsHealthy or not FL[1] or not InCombat) then Spell = HL[8] end
    if HL[9] and healneed > HL[9].EffectiveHeal*K and ManaLeft >= HL[9].Mana and (TargetIsHealthy or not FL[1] or not InCombat) then Spell = HL[9] end

    return Spell.SpellID, Spell.EffectiveHeal;
end

function QuickHealPaladin:GetSpellInfo(spellName, Target)
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
    if spellName == QUICKHEAL_SPELL_FLASH_OF_LIGHT then
        local i;
        local HM = (1.5/3.5)*Bonus;
        for i = 1,table.getn(spellInfo) do
            spellInfo[i].EffectiveHeal = (spellInfo[i].Heal+HM)*HDB;
        end
    elseif spellName == QUICKHEAL_SPELL_HOLY_LIGHT then
        local i;
        local PF = {0.2875, 0.475, 0.775};
        local HM = (2.5/3.5)*Bonus;
        for i = 1,table.getn(spellInfo) do
            spellInfo[i].EffectiveHeal = (spellInfo[i].Heal+HM*(PF[i] or 1.0))*HDB;
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

function QuickHealPaladin:GetRatioHealthy()
    return QuickHealVariables.RatioHealthyPaladin;
end

function QuickHealPaladin:CastCheckSpell()
    CastSpell(QuickHeal_GetSpellInfo(QUICKHEAL_SPELL_HOLY_LIGHT)[1].SpellID, BOOKTYPE_SPELL);
end