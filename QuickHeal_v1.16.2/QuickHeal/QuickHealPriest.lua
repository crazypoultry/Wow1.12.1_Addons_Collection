QuickHealPriest = {};

function QuickHealPriest:GetRatioHealthyExplanation()
    if QuickHealVariables.RatioHealthyPriest >= QuickHealVariables.RatioFull then
        return QUICKHEAL_SPELL_FLASH_HEAL .. " will always be used in combat, and "  .. QUICKHEAL_SPELL_LESSER_HEAL .. ", " .. QUICKHEAL_SPELL_HEAL .. " or " .. QUICKHEAL_SPELL_GREATER_HEAL .. " will be used when out of combat. ";
    else
        if QuickHealVariables.RatioHealthyPriest > 0 then
            return QUICKHEAL_SPELL_FLASH_HEAL .. " will be used in combat if the target has less than " .. QuickHealVariables.RatioHealthyPriest*100 .. "% life, and " .. QUICKHEAL_SPELL_LESSER_HEAL .. ", " .. QUICKHEAL_SPELL_HEAL .. " or " .. QUICKHEAL_SPELL_GREATER_HEAL .. " will be used otherwise. ";
        else
            return QUICKHEAL_SPELL_FLASH_HEAL .. " will never be used. " .. QUICKHEAL_SPELL_LESSER_HEAL .. ", " .. QUICKHEAL_SPELL_HEAL .. " or " .. QUICKHEAL_SPELL_GREATER_HEAL .. " will always be used in and out of combat. ";
        end
    end
end

function QuickHealPriest:FindSpellToUse(Target)
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

    local TargetIsHealthy = Health >= QuickHealVariables.RatioHealthyPriest;
    local ManaLeft = UnitMana('player');

    -- Detect proc of 'Hand of Edward the Odd' mace (next spell is instant cast)
    if QuickHeal_DetectBuff('player',"Spell_Holy_SearingLight") then
        QuickHeal_debug("BUFF: Hand of Edward the Odd (out of combat healing forced)");
        InCombat = false;
    end

    -- Detect Inner Focus or Spirit of Redemption (hack ManaLeft and healneed)
    if QuickHeal_DetectBuff('player',"Spell_Frost_WindWalkOn",1) or QuickHeal_DetectBuff('player',"Spell_Holy_GreaterHeal") then
        QuickHeal_debug("Inner Focus or Spirit of Redemption active");
        ManaLeft = UnitManaMax('player'); -- Infinite mana
        healneed = 10^6; -- Deliberate overheal (mana is free)
    end

    -- Get a list of ranks available for all spells
    local LH = self:GetSpellInfo(QUICKHEAL_SPELL_LESSER_HEAL, Target);
    local H  = self:GetSpellInfo(QUICKHEAL_SPELL_HEAL, Target);
    local GH = self:GetSpellInfo(QUICKHEAL_SPELL_GREATER_HEAL, Target);
    local FH = self:GetSpellInfo(QUICKHEAL_SPELL_FLASH_HEAL, Target);

    QuickHeal_debug(string.format("Found LH up to rank %d, H up top rank %d, GH up to rank %d, and FH up to rank %d", table.getn(LH), table.getn(H), table.getn(GH), table.getn(FH)));

    -- Compensation for health lost during combat
    local k=1.0;
    local K=1.0;
    if InCombat then
        k=0.9;
        K=0.8;
    end

    -- Find suitable spell based on the defined criteria
    if not InCombat or TargetIsHealthy or not FH[1] then
        -- Not in combat or target is healthy so use the closest available mana efficient healing
        QuickHeal_debug(string.format("Not in combat or target healthy or no flash heal available, will use closest available LH, H or GH (not FH)"))
        Spell = LH[1]; -- Default to LH rank 1
        local i;
        for i = 2,table.getn(LH) do
            if healneed > LH[i].EffectiveHeal*k and ManaLeft >= LH[i].Mana then Spell = LH[i] end
        end
        for i = 1,table.getn(H) do
            if healneed > H[i].EffectiveHeal*k and ManaLeft >= H[i].Mana then Spell = H[i] end
        end
        for i = 1,table.getn(GH) do
            if healneed > GH[i].EffectiveHeal*k and ManaLeft >= GH[i].Mana then Spell = GH[i] end
        end
    else
        -- In combat and target is unhealthy and player has flash heal
        QuickHeal_debug(string.format("In combat and target unhealthy and player has flash heal, will only use FH"));
        Spell = FH[1]; -- Default to FH rank 1
        local i;
        for i = 1,table.getn(FH) do
            if healneed > FH[i].EffectiveHeal*k and ManaLeft >= FH[i].Mana then Spell = FH[i] end
        end
    end
    
    return Spell.SpellID, Spell.EffectiveHeal;
end

function QuickHealPriest:GetSpellInfo(spellName, Target)
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

    -- Process individual spells
    if spellName == QUICKHEAL_SPELL_LESSER_HEAL then
        if spellInfo[1] then spellInfo[1].EffectiveHeal = (spellInfo[1].Heal+((1.5/3.5)*Bonus)*(0.2875))*HDB end
        if spellInfo[2] then spellInfo[2].EffectiveHeal = (spellInfo[2].Heal+((2.0/3.5)*Bonus)*(0.4))*HDB end
        if spellInfo[3] then spellInfo[3].EffectiveHeal = (spellInfo[3].Heal+((2.5/3.5)*Bonus)*(0.625))*HDB end
    elseif spellName == QUICKHEAL_SPELL_HEAL then
        local i;
        local HM = (3.0/3.5)*Bonus;
        if spellInfo[1] then spellInfo[1].EffectiveHeal = (spellInfo[1].Heal+HM*(0.925))*HDB end
        for i = 1,table.getn(spellInfo) do
            spellInfo[i].EffectiveHeal = (spellInfo[i].Heal+HM)*HDB;
        end
    elseif spellName == QUICKHEAL_SPELL_GREATER_HEAL then
        local i;
        local HM = (3.0/3.5)*Bonus;
        for i = 1,table.getn(spellInfo) do
            spellInfo[i].EffectiveHeal = (spellInfo[i].Heal+HM)*HDB;
        end
    elseif spellName == QUICKHEAL_SPELL_FLASH_HEAL then
        local i;
        local HM = (1.5/3.5)*Bonus;
        for i = 1,table.getn(spellInfo) do
            spellInfo[i].EffectiveHeal = (spellInfo[i].Heal+HM)*HDB;
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

function QuickHealPriest:GetRatioHealthy()
    return QuickHealVariables.RatioHealthyPriest;
end

function QuickHealPriest:CastCheckSpell()
    CastSpell(QuickHeal_GetSpellInfo(QUICKHEAL_SPELL_LESSER_HEAL)[1].SpellID, BOOKTYPE_SPELL);
end