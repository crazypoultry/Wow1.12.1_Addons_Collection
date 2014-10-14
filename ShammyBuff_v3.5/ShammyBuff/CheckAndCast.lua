function SB_Check()
	if (SB_ShammyCheck() and not UnitOnTaxi("player") and not UnitIsDeadOrGhost("player")) then
		local enoughmana,enoughhealth,castWepFirst,castLSFirst = false,false,false,false,false

		-- ###### Mount Check
		for i=1,40 do
			buff = UnitBuff("player",i)
			if buff and string.find(buff,"Mount_") then return end
		end
        if SBuff_IsBuffActive("".. SB_GhostWolf) then return end
        if SB_FishingCheck() then return end
        
		-- ###### Misc Checks
		if SpellIsTargeting() then SB_ChatMsg("".. SB_Waiting) return end
		if (SB_ManaCheck() >= tonumber(SBVAR["minmana"]) ) then enoughmana = true end
		if (SB_HealthCheck() >= tonumber(SBVAR["minhealth"]) ) then enoughhealth = true end

		-- ###### BUFF ORDER CHECK
		if SBVAR["ListOrder"]==1 then 
			if (SBVAR["WeaponBuffTog"]==1 and not GetWeaponEnchantInfo(hasMainHandEnchant)) then
                castWepFirst = true
            else
                castLSFirst = true
            end
		else
			if (SBVAR["AutoLSCast"] == 1 and not SBuff_IsBuffActive("".. SB_LS)) then
                castLSFirst = true
            else
                castWepFirst = true
            end
		end
	
		-- ###### AUTO NS HEAL
        if not SB_NSTime then SB_NSTime = GetTime() end  -- NS Timer Check
        if SBuff_IsBuffActive("".. SB_NS) then TargetUnit("player"); CastSpellByName("".. SB_HW, 1); SB_TimerSet(NS) return end  -- If NS found, then cast
        
		if ((SBVAR["NSHeal"] == 1) and (GetTime() > SB_NSTime) and (SB_HealthCheck() < tonumber(SBVAR["NSHealValue"])) and (SB_HealthCheck() >= 1)) then
            CastSpellByName("".. SB_NS); SpellStopCasting(); TargetUnit("player"); CastSpellByName("".. SB_HW, 1)
            if SpellIsTargeting() then SpellTargetUnit("player") return end
            SB_TimerSet(NS)
        end

        -- ###### Decursive
        if (SBVAR["DebuffToggle"] == 1 and UnitDebuff("player", 1, 1)) then
            if (Dcr_Saved) then
                Dcr_Clean()
                return
            else
                SB_ChatMsg("".. SB_DecError)
                SBVAR["DebuffToggle"] = 0
                SBVAR["DebuffMsg"] = 0
            end
        end

		-- ###### LIGHTNING SHIELD CAST
		if SBVAR["AutoLSCast"] == 1 and not SBuff_IsBuffActive("".. SB_LS) and enoughhealth and enoughmana and castLSFirst then
			CastSpellByName("".. SB_LS) return
		end
		
		-- ###### WEAPON BUFF CAST
		if SBVAR["WeaponBuffTog"] == 1 and not GetWeaponEnchantInfo(hasMainHandEnchant) and GetInventoryItemQuality("player", 16) and
            enoughmana and enoughhealth and castWepFirst then
		        if SBVAR["WeaponBuff"]==1 then SBVAR["WeaponSpellName"] = SB_WindWep; end
		        if SBVAR["WeaponBuff"]==2 then SBVAR["WeaponSpellName"] = SB_RockWep; end
		        if SBVAR["WeaponBuff"]==3 then SBVAR["WeaponSpellName"] = SB_FlameWep; end
		        if SBVAR["WeaponBuff"]==4 then SBVAR["WeaponSpellName"] = SB_FrostWep; end
		        CastSpellByName("".. SBVAR["WeaponSpellName"])
                return
		end

		-- ###### Troll Bezerking
        if not SB_BesTime then SB_BesTime = GetTime() end
        if ((SBVAR["TrollBezerk"] == 1) and SB_RaceCheck()) then
            if ((SB_HealthCheck() < tonumber(SBVAR["BezerkHealValue"]) and SB_HealthCheck() >= 1) and (GetTime() > SB_BesTime)) then
                CastSpellByName("".. SB_Bezerk)
                SB_TimerSet(BES)
		    end
        end
        
        -- ###### Lazy fuck
        if SBVAR["LazyAssNamsar"] == 1 then
            CastSpellByName("".. SB_LHW)
            SpellTargetUnit("player")
        end
	end
end

function SB_TimerSet(spellName)
    if (spellName == NS) then
        SB_NSTime = GetTime() + 180
    end
    if (spellName == BES) then
        SB_BesTime = GetTime() + 180
    end
end

function SB_CastSpell(spellName)
	local i,done,name,id = 1,false
	while not done do
		name = GetSpellName(i,BOOKTYPE_SPELL)
		if not name then
			done = true
		elseif name == spellName then id = i end
		i = i + 1
	end
	if id then
        local start, duration = GetSpellCooldown(id, BOOKTYPE_SPELL)
        if ( start > 0 and duration > 0) then
            SB_CastSpell("".. SB_LHW)
            SpellTargetUnit("player")
        else
            CastSpell(id,BOOKTYPE_SPELL)
        end
    end
end

function SB_Debug()
	local enoughmana,enoughhealth,castWepFirst,castLSFirst,mounted = false,false,false,false,false,false

	-- ###### BUFFS CHECK
	for i=1,40 do
		buff = UnitBuff("player",i)
		if buff and string.find(buff,"Mount_") then mounted = true end
	end
	
	-- ###### Misc Checks
	if SpellIsTargeting() then SB_ChatMsg("".. SB_Waiting) return end
	if (SB_ManaCheck() >= tonumber(SBVAR["minmana"]) ) then enoughmana = true end
	if (SB_HealthCheck() >= tonumber(SBVAR["minhealth"]) ) then enoughhealth = true end
    if SBuff_IsBuffActive("".. SB_GhostWolf) then return end

    -- ###### BUFF ORDER CHECK
    if SBVAR["ListOrder"]==1 then 
        if (SBVAR["WeaponBuffTog"]==1 and not GetWeaponEnchantInfo(hasMainHandEnchant)) then
            castWepFirst = true
        else
            castLSFirst = true
        end
    else
        if (SBVAR["AutoLSCast"] == 1 and not SBuff_IsBuffActive("".. SB_LS)) then
            castLSFirst = true
        else
            castWepFirst = true
        end
    end

	-- ##### SPAM
    if SB_ShammyCheck() then SB_ChatMsg("Player is a Shaman") else SB_ChatMsg("Player NOT a Shaman!") end
    if UnitOnTaxi("player") then SB_ChatMsg("Unit on Taxi") else SB_ChatMsg("Unit NOT on a taxi") end
    if UnitIsDeadOrGhost("player") then SB_ChatMsg("Unit is dead") else SB_ChatMsg("Unit is NOT dead") end
	if SBVAR["AutoLSCast"]==1 then SB_ChatMsg("Cast LS is ON") else SB_ChatMsg("Cast LS is OFF"); end
	if SBVAR["WeaponBuffTog"]==1 then SB_ChatMsg("Cast Weapon Buff ON") else SB_ChatMsg("Cast Weapon Buff OFF"); end
	SB_ChatMsg("--------------------------");
	if not SpellIsTargeting() then SB_ChatMsg("No spells awaiting target") else SB_ChatMsg("A spell is currently awaiting target"); end
	if not SBuff_IsBuffActive("".. SB_LS) then SB_ChatMsg("LS not found") else SB_ChatMsg("LS found"); end
	if enoughhealth then SB_ChatMsg("Enough Health") else SB_ChatMsg("Not enough health"); end
	if enoughmana then SB_ChatMsg("Enough mana") else SB_ChatMsg("Not enough mana"); end
	if not mounted then SB_ChatMsg("Not Mounted") else SB_ChatMsg("Is mounted"); end
	if not SBuff_IsBuffActive("".. SB_GhostWolf) then SB_ChatMsg("Not shapeshifted") else SB_ChatMsg("Is shapeshifted"); end
	if not SB_FishingCheck() then SB_ChatMsg("Not fishing") else SB_ChatMsg("Is fishing"); end
end