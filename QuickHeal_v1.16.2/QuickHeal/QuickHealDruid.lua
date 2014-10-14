QuickHealDruid = {};

function QuickHealDruid:GetRatioHealthyExplanation()
    if QuickHealVariables.RatioHealthyDruid >= QuickHealVariables.RatioFull then
        return QUICKHEAL_SPELL_REGROWTH .. " will always be used in combat, and "  .. QUICKHEAL_SPELL_HEALING_TOUCH .. " will be used when out of combat. ";
    else
        if QuickHealVariables.RatioHealthyDruid > 0 then
            return QUICKHEAL_SPELL_REGROWTH .. " will be used in combat if the target has less than " .. QuickHealVariables.RatioHealthyDruid*100 .. "% life, and " .. QUICKHEAL_SPELL_HEALING_TOUCH .. " will be used otherwise. ";
        else
            return QUICKHEAL_SPELL_REGROWTH .. " will never be used. " .. QUICKHEAL_SPELL_HEALING_TOUCH .. " will always be used in and out of combat. ";
        end
    end
end

function QuickHealDruid:FindSpellToUse(Target)
    local Spell = nil;
    local HealSize = 0;

    -- Determine health and heal need of target
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

    local TargetIsHealthy = Health >= QuickHealVariables.RatioHealthyDruid;
    local ManaLeft = UnitMana('player');
    
    -- Detect Clearcasting (from Omen of Clarity, talent(1,9))
    if QuickHeal_DetectBuff('player',"Spell_Shadow_ManaBurn",1) then
        ManaLeft = UnitManaMax('player');  -- set to max mana so max spell rank can be cast
        healneed = 10^6; -- deliberate overheal (mana is free)
        QuickHeal_debug("BUFF: Clearcasting (Omen of Clarity)");
    end

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

    -- Get a list of ranks available for all spells
    local HT = self:GetSpellInfo(QUICKHEAL_SPELL_HEALING_TOUCH, Target);
    local RG = self:GetSpellInfo(QUICKHEAL_SPELL_REGROWTH, Target);
    QuickHeal_debug(string.format("Found HT up to rank %d, RG up to rank %d", table.getn(HT), table.getn(RG)));

    -- Compensation for health lost during combat
    local k=1.0;
    local K=1.0;
    if InCombat then
        k=0.9;
        K=0.8;
    end

    -- Find suitable SpellID based on the defined criteria
    if not InCombat or TargetIsHealthy or not RG[1] then
        -- Not in combat or target is healthy so use the closest available mana efficient healing
        Spell = HT[1]; -- Default to HT rank 1
        local i;
        for i = 2,table.getn(HT) do
            if healneed > HT[i].EffectiveHeal*K and ManaLeft >= HT[i].Mana then Spell = HT[i] end
        end
    else
        -- In combat and target is unhealthy and player has Regrowth
        Spell = RG[1] -- Default to RG rank 1
        local i;
        for i = 2,table.getn(RG) do
            if healneed > RG[i].EffectiveHeal*k and ManaLeft >= RG[i].Mana then Spell = RG[i] end
        end
    end
    
    return Spell.SpellID, Spell.EffectiveHeal;
end

function QuickHealDruid:GetSpellInfo(spellName, Target)
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
    if spellName == QUICKHEAL_SPELL_HEALING_TOUCH then
        local i;
        local PF = {0.2875, 0.55, 0.775};
        local HM = {(1.5/3.5)*Bonus, (2.0/3.5)*Bonus, (2.5/3.5)*Bonus, (3.0/3.5)*Bonus}
        for i = 1,table.getn(spellInfo) do
            spellInfo[i].EffectiveHeal = (spellInfo[i].Heal+(HM[i] or Bonus)*(PF[i] or 1.0))*HDB;
        end
    elseif spellName == QUICKHEAL_SPELL_REGROWTH then
        local i;
        local PF = {0.7, 0.925};
        local HM = {(2.0/3.5)*Bonus*0.48};

        for i = 1,table.getn(spellInfo) do
            spellInfo[i].EffectiveHeal = (spellInfo[i].Heal+(HM[i] or ((2.0/3.5)*Bonus*0.5))*(PF[i] or 1.0))*HDB;
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

function QuickHealDruid:GetRatioHealthy()
    return QuickHealVariables.RatioHealthyDruid;
end

function QuickHealDruid:CastCheckSpell()
    CastSpell(QuickHeal_GetSpellInfo(QUICKHEAL_SPELL_HEALING_TOUCH)[1].SpellID, BOOKTYPE_SPELL);
end