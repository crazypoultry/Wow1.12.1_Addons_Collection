local AFFLICTION_TAB=1;
local IMP_LIFETAP_ID=5;
local RANK_MULTIPLIER={0.38,0.68,0.8,0.8,0.8,0.8};
local BASE_DAMAGE={30,75,140,220,310,424};
local SLT_Config = {
    debug = false,
    overtapEnabled = true
}

function ScaledLifeTap_Debug(arg)
    if arg then
        if arg == 1 then
            SLT_Config.debug = true
        else
            SLT_Config.debug = false
        end
    else
        return SLT_Config.debug;
    end
end

local function ScaledLifeTap_GetLifeTapMultiplier()
    local name,iconPath,tier,column,rank = GetTalentInfo(AFFLICTION_TAB, IMP_LIFETAP_ID);
    local multiplier = 1;
    if (name == SCALEDLIFETAP_LIFETAPTALENT) then
        if rank == 1 then
            multiplier = 1.1;
        elseif rank == 2 then
            multiplier = 1.2;
        end
    else
        if ScaledLifeTap_Debug() then
            DEFAULT_CHAT_FRAME:AddMessage("Talent tree has changed.  Cannot determine Improved Life Tap Rank. Assuming 0 ranks.");
        end
    end
    
    return multiplier;
end

local function ScaledLifeTap_GetMaxLifeTapRank()
    local rank=0;
    local count=1;
    local foundSpell = false;
    
    while true do
        local spellName, spellRank = GetSpellName(count, BOOKTYPE_SPELL);
           
        if spellName == SCALEDLIFETAP_LIFETAPSPELL then
            startPos,endPos,rank = string.find(spellRank, SCALEDLIFETAP_RANKREGEXP);
            foundSpell = true;
        else
            if foundSpell then
                break;
            end
        end
        count = count + 1;
    end 
    
    if ScaledLifeTap_Debug() then
        DEFAULT_CHAT_FRAME:AddMessage("Highest rank of Life Tap is " .. rank);
    end
    
    return rank;
end

local function ScaledLifeTap_GetDamageBonus()
    local damageBonus = 0;
    if IsAddOnLoaded("BonusScanner") then
        damageBonus = BonusScanner:GetBonus("SHADOWDMG") + BonusScanner:GetBonus("DMG");
    end

    if ScaledLifeTap_Debug() then
        DEFAULT_CHAT_FRAME:AddMessage("Total shadow damage bonus is: " .. damageBonus);
    end

    return damageBonus;
end

-- compatible with original release
function ScaledLifetap_CastLifeTap()
    ScaledLifeTap_CastLifeTap();
end

function ScaledLifeTap_CastLifeTap()
    local damageModifier = ScaledLifeTap_GetDamageBonus();
    local lifetapMultiplier = ScaledLifeTap_GetLifeTapMultiplier();
    local maxRank = ScaledLifeTap_GetMaxLifeTapRank();
    local castSpell=false;
    
    for i=maxRank,1,-1 do 
        if ((i == 1 and SLT_Config.overtapEnabled and (UnitManaMax("player") ~= UnitMana("player")))) or ((UnitHealth("player")>=BASE_DAMAGE[i]+RANK_MULTIPLIER[i]*damageModifier and (UnitManaMax("player")-UnitMana("player")>=(BASE_DAMAGE[i]+RANK_MULTIPLIER[i]*damageModifier)*lifetapMultiplier))) then 
           CastSpellByName(SCALEDLIFETAP_LIFETAPSPELL .. "(" .. SCALEDLIFETAP_RANKTEXT .. " "..i..")");
           if ScaledLifeTap_Debug() then
              DEFAULT_CHAT_FRAME:AddMessage("Casting Life Tap(Rank " .. i .. ")");  
           end
           castSpell = true;
           break;
        end;
    end;
    
    if not castSpell then
        if ScaledLifeTap_Debug() then
           DEFAULT_CHAT_FRAME:AddMessage("Cancelling Lifetap");
        end
    end
end