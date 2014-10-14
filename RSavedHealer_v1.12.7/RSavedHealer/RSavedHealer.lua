--[[
--   Rivotti's Saved Healer
--   An addon for World of Warcraft that helps healers with must of their
--   functions saving mana and time
--
--]]

RSH_ACTION     = "0"
RSH_CLASS      = "Priest"
RSH_EFFECT     = "0"
RSH_PLAYERNAME = ""
RSH_TARGETNAME = ""
RSH_UNITS      = { }
RSAVEDHEALER_VERSION = "1.12.7"
RSH_REAL_VERSION = 1122
RSH_CLASS_COLORS    = {
    Druid   = "|cFFFF9933",
    Hunter  = "|cFF00FF00",
    Mage    = "|cFF33CCFF",
    Paladyn = "|cFFFF00FF",
    Pet     = "|cFF000000",
    Priest  = "|cFFFFFFFF",
    Rogue   = "|cFFFFFF33",
    Shaman  = "|cFFFF00FF",
    Warlock = "|cFFCC00FF",
    Warrior = "|cFFFF0000",
}

-- Events to Process
RSavedHealerEvents = {
    "CHAT_MSG_ADDON",
    --"CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS",
    --"CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS",
    --"CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS",
    --"CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE",
    --"CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE",
    --"CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE",
    --"CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS",
	"SPELLS_CHANGED",
	--"SPELLCAST_START",
	"SPELLCAST_STOP",
    "SPELLCAST_INTERRUPTED",
    "SPELLCAST_FAILED",
}

-- Config
RSavedHealerConfig = {
    ["General"] = {},
}
SpellBook = { }
HealingUnits = { }

-- Attack
function RSavedHealer_Attack(SpellArray, Options)
	RSavedHealer_DebugPrint("|cFFFF0000_Attack Function Called!")
	local Unit = "player"

    local OptionsArray = { Atack = 1 }
    if ( Options ) then
        for Key in string.gfind(Options, "%a+") do OptionsArray[Key] = 1 end
    end

    -- Player Data
    local Player  = {
		Level = UnitLevel("player"),
		Mana  = UnitMana("player"),
	}

	-- Process Target
	RSavedHealer_DebugPrint(" Selecting correct target...")
	
	if ( UnitOnTaxi("player") ) then
		RSavedHealer_DebugPrint(" Unit in Taxi, no buffing for the moment!")
		return false
		
	elseif ( RSavedHealer_CheckUnitBuff("player", "Mount_") ) then
		RSavedHealer_DebugPrint(" Unit mounted, no buffing for the moment!")
		return false
	
	-- There is a target and it's hostile
	elseif (
		UnitExists("target") and UnitIsEnemy("player", "target") and
		not UnitIsDeadOrGhost("target")	and UnitIsVisible("target")
	) then
		RSavedHealer_DebugPrint("  Targeting an hostile unit!")
		Unit =  "target"
	end

    local Target = {
        Unit   = Unit,
        Name   = UnitName(Unit),
        Level  = UnitLevel(Unit),
        HP     = UnitHealth(Unit),
        MaxHP  = UnitHealthMax(Unit),
        Damage = UnitHealthMax(Unit) - UnitHealth(Unit),
    }
	
    RSH_UNITS = { Target["Name"] }
    
    if (
        RSavedHealer_ProcessSpellArray(SpellArray, Player, Target, OptionsArray)
    ) then
        return true
    end
end

-- Is Unit Shape Shifted
function RSavedHealer_IsShapeShifted()
    RSavedHealer_DebugPrint("|cFFFF0000_IsShapeShifted Function Called!")
    for i = 1, GetNumShapeshiftForms() do
        icon, name, active, castable = GetShapeshiftFormInfo(i)
        if ( active ) then return true end
    end
    return false
end

-- Buff Player
function RSavedHealer_Buff(Options)
	RSavedHealer_DebugPrint("|cFFFF0000_Buff Function Called!")
	RSH_ACTION = "0"

    local OptionsArray = { Buff = 1 }
    if ( Options ) then
        for Key in string.gfind(Options, "%a+") do OptionsArray[Key] = 1 end
    end

    -- Player Data
    local Player  = {
		Level = UnitLevel("player"),
		Mana  = UnitMana("player"),
		ManaPercent = UnitMana("player") * 100 / UnitManaMax("player"),
	}

	local RaidMembers  = GetNumRaidMembers()
	local PartyMembers = GetNumPartyMembers()
	local Units        = { }

	-- Process Target
	RSavedHealer_DebugPrint(" Selecting correct target...")

	if ( UnitOnTaxi("player") ) then
		RSavedHealer_DebugPrint(" Unit in Taxi, no buffing for the moment!")
		return false

	elseif ( RSavedHealer_IsShapeShifted() ) then
		RSavedHealer_DebugPrint(" Unit is Shapeshifted, no buffing for the moment!")
		return false
		
	elseif ( RSavedHealer_CheckUnitBuff("player", "Mount_") ) then
		RSavedHealer_DebugPrint(" Unit mounted, no buffing for the moment!")
		return false
	
	-- ALT key is down so we select player
	elseif ( IsAltKeyDown() and Player['ManaPercent'] >= RSavedHealerConfig.Buffing.MinMana ) then
		RSavedHealer_DebugPrint("  ALT Key pressed, targeting Player!")
		Units =  { "player" }
		
	-- There is a target and it's friendly
	elseif (
		UnitExists("target") and UnitIsFriend("player", "target") and
		UnitIsPlayer("target") and not UnitIsDeadOrGhost("target")
		and UnitIsVisible("target")
	) then
		RSavedHealer_DebugPrint("  Targeting friendly unit!")
		Units =  { "target" }

	-- There is no Target or it's Enemy
	elseif ( not UnitExists("target") or UnitIsEnemy("player", "target") ) then
		RSavedHealer_DebugPrint("  Targeting enemy or no target at all!")
	
		-- Let's check if player is in Raid
		if ( RaidMembers > 0 and not RSavedHealerConfig.Buffing.PartyOnly ) then
			RSavedHealer_DebugPrint("   Player is in Raid!")
			Units = RSavedHealer_GetGroupUnits("raid", RaidMembers)
			table.insert(Units, "player")
					
		-- Let's check if player is in Party	
		elseif ( PartyMembers > 0 ) then
			RSavedHealer_DebugPrint("   Player is in Party!")
			Units = RSavedHealer_GetGroupUnits("party", PartyMembers)
			table.insert(Units, "player")
			
		-- Player is alone
		else
			RSavedHealer_DebugPrint("   Player is alone!")
			Units    = { "player" }
			
		end
	end

	local i = 1
	while ( i <= getn(Units) ) do
		Unit = Units[i]
		RSavedHealer_DebugPrint("  Processing "..Unit.."...")
		if (
			UnitExists(Unit) and UnitIsVisible(Unit) and
			not UnitIsDeadOrGhost(Unit)
		) then
			local Target = {
                Unit  = Unit,
                Name  = UnitName(Unit),
				Class = UnitClass(Unit),
				Level = UnitLevel(Unit),
				Type  = RSavedHealer_GetUnitGroupType(Unit),
			}

			table.foreach(RSavedHealerConfig.Buffing.Spells, function(Spell)

				if (
					Spell == "Fortitude" and
					RSavedHealer_CheckUnitBuff(Unit,"Interface\\Icons\\Spell_Holy_PrayerOfFortitude")
				) then
					--RSavedHealer_DebugPrint("      A more powerfull spell is allready active!")
				
				elseif (
					string.find(Unit, "pet") and
					RSavedHealerConfig.Buffing.Spells[Spell]["Pets"]
				) then
					--RSavedHealer_DebugPrint("      Ignoring Pets!")

				elseif (
					not RSavedHealerConfig.Buffing.Spells[Spell][Target['Type']]
				) then
					--RSavedHealer_DebugPrint("      Not Buffing this target type!")
                    
				elseif (
					RSavedHealerConfig.Buffing.Spells[Spell][Target['Class']] and
					not UnitIsUnit("player", Unit)
				) then
                	--RSavedHealer_DebugPrint("      Not Buffing this class!")
                
                else
					--RSavedHealer_DebugPrint("   Found "..Spell.."!")
                    local SpellArray  = RSH_BUFF_SPELLS[Spell]
                    RSH_UNITS = { Target["Name"] }
                    
                    if (
                        RSavedHealer_ProcessSpellArray(
                            SpellArray, Player, Target, OptionsArray
                        )
                    ) then
                        return true
                    end				
                end
			end);		
		end	
		i = i + 1
	end
    return false
end

-- Cast Spell
function RSavedHealer_CastSpell(spellName, Target)
    RSavedHealer_DebugPrint("|cFFFF0000_CastSpell Function Called!")
	local targetName, targetEnemy, returnValue

	if (UnitExists("target")) then
		if (UnitIsFriend("target", "player")) then
			targetName = UnitName("target")
		else
			targetEnemy = true
		end
	end

	if ( Target["Unit"] ~= "target" ) then
		ClearTarget()
		CastSpellByName(spellName)

		if ( SpellCanTargetUnit(Target["Unit"]) or Target["Unit"] == "player" ) then
			RSavedHealer_ChatPrint("Casting "..spellName.." on "..Target["Name"].."!")
            RSavedHealer_DebugPrint(" Segundo IF")
            for i = 1, table.getn(RSH_UNITS) do
                SendAddonMessage(
                    "RSAVEDPRIEST",
                    "<"..RSH_ACTION..":"..RSH_UNITS[i]..":"..RSH_EFFECT..":-1>",
                    "RAID"
                )
            end
			SpellTargetUnit(Target["Unit"])
			returnValue = true
		else
			SpellStopTargeting() 
			returnValue = false
		end	
	else
		CastSpellByName(spellName)
		RSavedHealer_ChatPrint("Casting "..spellName.." on "..Target["Name"].."!")
        for i = 1, table.getn(RSH_UNITS) do
            SendAddonMessage(
                "RSAVEDPRIEST",
                "<"..RSH_ACTION..":"..RSH_UNITS[i]..":"..RSH_EFFECT..":-1>",
                "RAID"
            )
        end
		SpellTargetUnit(Target["Unit"])
		returnValue = true
	end

	if (targetEnemy) then
		if (not UnitIsEnemy("target", "player")) then
			TargetLastEnemy()
		end
	elseif (targetName) then
		if ( targetName ~= UnitName("target") ) then
			TargetByName(targetName)
		end
	else
		if (UnitExists("target")) then
			ClearTarget()
		end
	end
	
	return returnValue
end

-- Chat Print
function RSavedHealer_ChatPrint(str, red, green, blue)
    if ( DEFAULT_CHAT_FRAME ) then 
		DEFAULT_CHAT_FRAME:AddMessage(str, red, green, blue)
    end
end

-- Check Unit Buff
function RSavedHealer_CheckUnitBuff(Unit, Texture)
	RSavedHealer_DebugPrint("|cFFFF0000_CheckUnitBuff function called!")
	local i = 1
	while ( UnitBuff(Unit, i) ) do
		--RSavedHealer_DebugPrint(" Found "..UnitBuff(Unit, i))
		if (string.find(UnitBuff(Unit, i), Texture)) then
			return true
		end
		i = i + 1
	end
end

-- Debug Print
function RSavedHealer_DebugPrint(str)
	if ( RSavedHealerConfig.General.Debug ) then
		RSavedHealer_ChatPrint("[Debug] "..str, 0.5, 0.5, 0.5)
	end
end

-- Get Best Unit To Heal Id
function RSavedHealer_GetBestUnitToHealId(Units)
	RSavedHealer_DebugPrint("|cFFFF0000_GetBestUnitToHealId function called!")
	local maxDamage = 0
	local minPercentHP = 100
	local returnUnitId
	for i = 1, table.getn(Units) do
		Unit = Units[i]
		if (
			UnitExists(Unit) and UnitIsVisible(Unit) and
			not UnitIsDeadOrGhost(Unit)
		) then
			local HP   = UnitHealth(Unit)
			local unitName = UnitName(Units[i]) 

			if ( HealingUnits[unitName] ~= nill ) then
				local Heal = tonumber(HealingUnits[unitName])
				HP = HP + Heal
				RSavedHealer_DebugPrint("  Being Healed for "..Heal.." points!")
			end

			local MaxHP     = UnitHealthMax(Unit)
			local Damage    = MaxHP - HP
			local PercentHP = HP * 100 / MaxHP

			if (
                RSavedHealerConfig.Healing.ByPercent and PercentHP < minPercentHP and
                PercentHP < RSavedHealerConfig.Healing.BelowHPPercent
            ) then
				minPercentHP = PercentHP
				returnUnitId = i
			elseif (
                RSavedHealerConfig.Healing.ByPercent == nil and Damage > maxDamage and
                PercentHP < RSavedHealerConfig.Healing.BelowHPPercent
            ) then
				maxDamage = Damage
				returnUnitId = i
			end
            
            RSavedHealer_DebugPrint(
                " Unit: "..Units[i].." ("..unitName..")".." "..MaxHP.." - "..
                HP.." = "..Damage
            )
		end
	end
	if ( returnUnitId ~= nil ) then
		RSavedHealer_DebugPrint(" Best unit to heal is "..Units[returnUnitId].."!")
		if ( RSavedHealerConfig.Healing.ByPercent ) then
			RSavedHealer_DebugPrint("  Healing By HP Percentage!")
		else
			RSavedHealer_DebugPrint("  Healing By HP Damage!")
		end	
	end
	return returnUnitId
end

-- Get Group Units
function RSavedHealer_GetGroupUnits(GroupType, Count, IgnorePets)
    RSavedHealer_DebugPrint("|cFFFF0000_GetGroupUnits function called!")
	local Units = { }
	for i = 1, Count do
		local Unit    = GroupType..i
		local UnitPet = GroupType.."pet"..i
		table.insert(Units, Unit)
		if ( UnitExists(UnitPet) and not IgnorePets ) then table.insert(Units, UnitPet) end
	end
	return Units
end

-- Get Heal Bonus
function RSavedHealer_GetHealBonus()
	RSavedHealer_DebugPrint("|cFFFF0000_GetHealBonus function called!")
	local HealBonus = 0
    local SetBonus  = { }

	for slot = 0, 18 do
		local itemLink = GetInventoryItemLink("player", slot)
    
		if ( itemLink ) then
			local _,_,itemLink,itemName = string.find(itemLink,"|H(item:%d+:%d+:%d+:%d+)|h%[([^]]+)%]|h|r$")

			RSavedHealerTooltip:ClearLines()
			RSavedHealerTooltip:SetHyperlink(itemLink)

			for i=2, RSavedHealerTooltip:NumLines(), 1 do
				tmpText = getglobal("RSavedHealerTooltipTextLeft"..i)
				tmpStr = tmpText:GetText()
                
				if ( tmpStr ) then
                    --RSavedHealer_DebugPrint(" "..tmpStr)
					local _,_,healing = string.find(tmpStr ,".*[hH]ealing.+ %+?([0-9]+)")
					if ( not string.find(tmpStr, "Set:") and not string.find(tmpStr, "Use:") ) then
                        if ( healing ) then
                        	--RSavedHealer_DebugPrint("  "..itemName..": "..healing)
                        	HealBonus = HealBonus + healing
                        end
                    end

                    -- Getting Set Bonus
                    if (
                        string.find(tmpStr, "^Set:") and not SetBonus[tmpStr]
                        and healing
                    ) then
                        --RSavedHealer_DebugPrint("  Set Bonus: "..healing)
                        HealBonus = HealBonus + healing
                        SetBonus[tmpStr] = 1
                    end
				end
			end
		end
	end

    local _,Spirit = UnitStat("player",5);
    RSavedHealer_DebugPrint(" Player spirit is: "..Spirit)

    if ( RSH_CLASS == "Priest" ) then
        local _,_,_,_,spiritualGuidance = GetTalentInfo( 2 , 14 );
        if ( spiritualGuidance ) then
            local spiritualGuidancePercent = spiritualGuidance * 5
            local spiritBonus = spiritualGuidancePercent * Spirit / 100
            RSavedHealer_DebugPrint(" Heal bonus with spirit:"..spiritBonus)
            HealBonus = HealBonus + spiritBonus
        end
    end
    
	RSavedHealer_DebugPrint(" Total heal bonus is: "..HealBonus)
	return HealBonus
end

-- Get Raid group
function RSavedHealer_GetRaidGroup(Unit)
    RSavedHealer_DebugPrint("|cFFFF0000_GetRaidGroup function called!")
    if ( not string.find(Unit, "^raid") ) then return end
    local _, _, UnitId = string.find(Unit, "([0-9]+)$")
    local _, _, Group  = GetRaidRosterInfo(UnitId)
    return Group
end

-- Get Spell Book
function RSavedHealer_GetSpellBook()
	RSavedHealer_DebugPrint("|cFFFF0000_GetSpellBook function called!")

	for i = 1, GetNumSpellTabs(), 1 do
		local name, texture, offset, numSpells = GetSpellTabInfo(i)
		--RSavedHealer_DebugPrint(" "..name)

		for y = 1, numSpells, 1 do
			local uber = GetCVar("UberTooltips")
			SetCVar("UberTooltips", "1")
			RSavedHealerTooltip:SetSpell(offset+y, BOOKTYPE_SPELL) 
			SetCVar("UberTooltips", uber)

            local cast = 0
            
            local name, rank  = GetSpellName(offset+y, BOOKTYPE_SPELL)
            
            -- Mana
			local ManaLabel = getglobal("RSavedHealerTooltipTextLeft2"):GetText()
			if ( ManaLabel == nil ) then ManaLabel = "" end
			local _, _, mana  = string.find(ManaLabel, "^([0-9]+)")
			if ( mana == nil ) then mana = 0 end
			mana = tonumber(mana)

            -- Healing/Damage Amount
			local HealLabel = getglobal("RSavedHealerTooltipTextLeft4"):GetText()
			if ( HealLabel == nil ) then HealLabel = "" end
            local _,_, yards, min,max
			--local _, _, min, max = string.find(HealLabel, "([0-9]+)[^0-9]+([0-9]+)")
            --local _, _, min, max = string.find(HealLabel, "([0-9]+) to ([0-9]+)")
            if ( string.find(name, RSH_LNG['PrayerHealing']) ) then
                _, _, yards, min, max = string.find(HealLabel, "([0-9]+)[^0-9]+([0-9]+)[^0-9]+([0-9]+)")
            else
                _, _, min, max = string.find(HealLabel, "([0-9]+)[^0-9]+([0-9]+)")
            end
			if ( min == nil ) then min = 0 end
			if ( max == nil ) then max = 0 end
			min = tonumber(min)
			max = tonumber(max)
			if ( max < min ) then max = min end 

            -- Range
			local RangeLabel = getglobal("RSavedHealerTooltipTextRight2"):GetText()
			if ( RangeLabel == nil ) then RangeLabel = 999 end
			local _, _, range = string.find(RangeLabel, "([0-9]+)")
			if ( range == nil ) then range = 999 end
			range = tonumber(range)

            -- Cast Time
			local CastLabel = getglobal("RSavedHealerTooltipTextLeft3"):GetText()
            local BonusRate = 0
			if ( CastLabel ~= nil ) then
                if (
                    string.find(CastLabel, "Instant") or
                    string.find(CastLabel, "Channeled")
                ) then
                    cast = 3.5
                else
                    if ( string.find(CastLabel, "([0-9.]+)") ) then
                        _, _, cast = string.find(CastLabel, "([0-9.]+)")
                        cast = tonumber(cast)
                    end
                end
                if ( cast ~= nil ) then
                    BonusRate = cast / 3.5
                    if ( BonusRate > 1 ) then BonusRate = 1 end
                end
            end

            -- Name, Texture and Cooldown
			local texture     = GetSpellTexture(offset+y, BOOKTYPE_SPELL)
			local _, cooldown = GetSpellCooldown(offset+y, BOOKTYPE_SPELL)
			if ( cooldown == nil ) then cooldown = 0 end

            local spell = name
			if ( rank ~= "" ) then
                name = name.."("..rank..")"
            else
                rank = 0
            end
            local _, _, rank = string.find(rank, "([0-9]+)")

			SpellBook[name] = {
				Id        = offset+y,
                BonusRate = BonusRate,
                CastTime  = cast,
				CoolDown  = cooldown,
				Mana      = mana,
				MaxDmg    = max,
				MinDmg    = min,
				Range     = range,
				Texture   = texture,
                Spell     = spell,
                Rank      = rank,
			}

			--RSavedHealer_DebugPrint("  "..name)
		end		
	end
end

-- Get Unit Group Type
function RSavedHealer_GetUnitGroupType(Unit)
	RSavedHealer_DebugPrint("|cFFFF0000_GetUnitGroupType function called!")
	local GroupType
	
	if (string.find(Unit, "target")) then GroupType = "Target"
	elseif ( string.find(Unit, "raid") or string.find(Unit, "party") ) then
		GroupType = "Party"
	else GroupType = "Self" end
	RSavedHealer_DebugPrint(" Unit Group Type is: "..GroupType)
	
	return GroupType
end

-- Get Unit
function RSavedHealer_GetUnitByName(unitName)
    RSavedHealer_DebugPrint("|cFFFF0000_GetUnitByName function called!")
    local GroupType    = "party"
    local Count        = GetNumPartyMembers()
	local RaidMembers  = GetNumRaidMembers()
    
	-- Let's check if player is in Raid
	if ( RaidMembers > 0 ) then
        GroupType = "raid"
        Count     = RaidMembers
    end

	for i = 1, Count do
		local Unit    = GroupType..i
		local UnitPet = GroupType.."pet"..i
        
        if ( unitName == UnitName(Unit) ) then
            return Unit
            
		elseif ( UnitExists(UnitPet) and unitName == UnitName(UnitPet) ) then
            return UnitPet
        end
	end
    return "player"
end

-- Heal
function RSavedHealer_Heal(SpellArray, CombatSpellArray, Options)
	RSavedHealer_DebugPrint("|cFFFF0000_Heal Function Called!")
    RSH_ACTION = "1"

    local OptionsArray = { Heal = 1 }
    if ( Options ) then
        for Key in string.gfind(Options, "%a+") do
            OptionsArray[Key] = 1
        end
    end

    -- Player Data
    local Player  = {
		Level     = UnitLevel("player"),
		Mana      = UnitMana("player"),
        HealBonus = RSavedHealer_GetHealBonus(),
	}

	local RaidMembers  = GetNumRaidMembers()
	local PartyMembers = GetNumPartyMembers()
	local Units        = { }

	-- Process Target
	RSavedHealer_DebugPrint(" Selecting correct target...")
	
	if ( UnitOnTaxi("player") ) then
		RSavedHealer_DebugPrint(" Unit in Taxi, no healing for the moment!")
		return false
		
	-- ALT key is down so we select player
	elseif ( IsAltKeyDown() ) then
		RSavedHealer_DebugPrint(" ALT Key pressed, targeting Player!")
		Units =  { "player" }
		
	-- There is a target and it's friendly
	elseif (
		UnitExists("target") and UnitIsFriend("player", "target") and
		not UnitIsDeadOrGhost("target")	and UnitIsVisible("target") and
        (
            RSavedHealer_Percent(
                UnitHealthMax("target"), UnitHealth("target")
            ) < RSavedHealerConfig.Healing.BelowHPPercent or
            RSavedHealerConfig.Healing.DontSkipTarget
        )
	) then
		RSavedHealer_DebugPrint(" Targeting friendly unit!")
		Units =  { "target" }

	-- There is no Target or it's Enemy
	else  -- if ( not UnitExists("target") or UnitIsEnemy("player", "target") ) then
		RSavedHealer_DebugPrint(" Targeting enemy or no target at all!")

		-- Let's check if player is in Raid
		if ( RaidMembers > 0 and not RSavedHealerConfig.Healing.PartyOnly ) then
			RSavedHealer_DebugPrint("  Player is in Raid!")
			Units = RSavedHealer_GetGroupUnits("raid", RaidMembers, RSavedHealerConfig.Healing.Classes.Pets )

		-- Let's check if player is in Party	
		elseif ( PartyMembers > 0 ) then
			RSavedHealer_DebugPrint("  Player is in Party!")
			Units = RSavedHealer_GetGroupUnits("party", PartyMembers, RSavedHealerConfig.Healing.Classes.Pets)
			table.insert(Units, "player")
			
		-- Player is alone
		else
			RSavedHealer_DebugPrint("  Player is alone!")
			Units    = { "player" }
			
		end
	end

	while ( getn(Units) > 0 ) do

		local UnitId = RSavedHealer_GetBestUnitToHealId(Units)
		local Unit = Units[UnitId]

		if ( Unit == nil ) then return false end
        
        local Group = RSavedHealer_GetRaidGroup(Unit)

		if (
			RSavedHealerConfig.Healing.Classes[UnitClass(Unit)] and
			not UnitIsUnit("player", Unit) and Unit ~= "target"
		) then
			RSavedHealer_DebugPrint("   Not healing this class!")
		
        elseif (
			Group and RSavedHealerConfig.Healing.Groups[""..Group..""] and
            not UnitIsUnit("player", Unit)
		) then
			RSavedHealer_DebugPrint("   Not healing this group!")
		
        else 
            local Target = {
                Unit   = Unit,
                Name   = UnitName(Unit),
                Level  = UnitLevel(Unit),
                HP     = UnitHealth(Unit),
                MaxHP  = UnitHealthMax(Unit),
                Damage = UnitHealthMax(Unit) - UnitHealth(Unit),
                DamagePercent = RSavedHealer_Percent(
                    UnitHealthMax(Unit), UnitHealthMax(Unit) - UnitHealth(Unit)
                )
            }
    
            if (
                UnitAffectingCombat(Unit) and CombatSpellArray ~= nil
            ) then
                RSavedHealer_DebugPrint("   Target is in Combat!")
                RSavedHealer_DebugPrint(
                    "   "..RSavedHealerConfig.Healing.QuickOnPercent..
                    " <= "..Target['DamagePercent']
                )

    
                if (
                    RSavedHealerConfig.Healing.MaxAllways == nil or (
                        RSavedHealerConfig.Healing.MaxAllways and
                        tonumber(RSavedHealerConfig.Healing.QuickOnPercent) <=
                        tonumber(Target['DamagePercent']) 
                    )
                ) then
                    RSavedHealer_DebugPrint("    Using Quick Heal Array!")
                    SpellArray = CombatSpellArray
                end
                
            elseif ( UnitAffectingCombat(Unit) and OptionsArray["Higher"] ) then

            else
                RSavedHealer_DebugPrint("   Target is not in Combat!")
                OptionsArray["Higher"] = nil
            end
    
            unitName = UnitName(Unit)
   
            if ( Target['MaxHP'] == 100 ) then
                OptionsArray["Higher"] = 1
   
            elseif ( HealingUnits[unitName] ~= nill ) then
                local Damage = tonumber(HealingUnits[unitName])
                Target['Damage'] = Target['Damage'] - Damage
            end

            if ( RSavedHealer_CheckUnitBuff("player", "Interface\\Icons\\Spell_Frost_WindWalkOn") ) then
                OptionsArray["Higher"] = 1
            end
    
            RSH_UNITS = { Target["Name"] }
    
            if (
                RSavedHealer_ProcessSpellArray(SpellArray, Player, Target, OptionsArray)
            ) then
                return true
            end
        end
		table.remove(Units, UnitId)
	end
    return false
end

function RSavedHealer_PartyHeal(SpellArray)
	RSavedHealer_DebugPrint("|cFFFF0000_PartyHeal Function Called!")
    RSH_ACTION = "1"
    
    local OptionsArray = { Heal = 1 }
    local minDamage    = 0 
    local Units        = RSavedHealer_GetGroupUnits("party", GetNumPartyMembers())
    table.insert(Units, "player")

    -- Player Data
    local Player  = {
		Level     = UnitLevel("player"),
		Mana      = UnitMana("player"),
        HealBonus = RSavedHealer_GetHealBonus(),
	}
    
    if ( RSavedHealer_CheckUnitBuff("player", "Interface\\Icons\\Spell_Frost_WindWalkOn") ) then
        OptionsArray["Higher"] = 1
    else
        RSavedHealer_DebugPrint(" Group Units: "..table.getn(Units))
        -- No point in getting foward if the party have less than 3 members
        if ( table.getn(Units) < RSavedHealerConfig.Healing.PartyMinMembers ) then return false end;

        local damageArray = { }
        for i = 1, table.getn(Units) do
            Unit = Units[i]
            Damage = UnitHealthMax(Unit) - UnitHealth(Unit)
            DamagePercent = RSavedHealer_Percent(
                UnitHealthMax(Unit), UnitHealthMax(Unit) - UnitHealth(Unit)
            )
            RSavedHealer_DebugPrint(" "..UnitName(Unit).." "..Damage)
            --RSavedHealer_ChatPrint(" "..UnitName(Unit).." "..Damage)
            
            -- If, at least, one of the members have more than 50% damage, we cancel
            --  this spell
            if ( DamagePercent > RSavedHealerConfig.Healing.PartySkipOnDamagePercent ) then return false end
            if (
                Damage > 0 and not UnitIsDeadOrGhost(Unit)
                and UnitIsVisible(Unit)
            ) then table.insert(damageArray, Damage) end
        end

        table.sort(damageArray, function(a,b) return a > b end)
        RSavedHealer_DebugPrint(" Players Damaged: "..table.getn(damageArray))
    
        -- No point in getting foward if the party have less than 3 members damaged
        if ( table.getn(damageArray) < RSavedHealerConfig.Healing.PartyMinMembers ) then return false end;
    
        minDamage = damageArray[RSavedHealerConfig.Healing.PartyMinMembers]
    end
    
    RSavedHealer_DebugPrint(" Min Damage: "..minDamage)

    local Target = {
        Unit   = "player",
        Name   = UnitName("player"),
        Level  = UnitLevel("player"),
        Damage = minDamage,
    }

        for i = 1, table.getn(Units) do
            Unit = Units[i]
            table.insert( RSH_UNITS, 1, UnitName(Unit) )
        end

    if (
        RSavedHealer_ProcessSpellArray(SpellArray, Player, Target, OptionsArray)
    ) then
        return true
    end    
end

function RSavedHealer_ProcessSpellArray(SpellArray, Player, Target, OptionsArray)
	RSavedHealer_DebugPrint("|cFFFF0000_ProcessSpellArray Function Called!")
    
    if ( not Player["HealBonus"] ) then Player["HealBonus"] = 0 end
    
    for i = 1, table.getn(SpellArray) do
        local Name = SpellArray[i][1]

        if ( SpellBook[Name] ~= nil ) then
            RSavedHealer_DebugPrint(" "..Name.." available!")
            local Level     = SpellArray[i][2]
            local TgMinLvl  = SpellArray[i][3]
            local TgMaxLvl  = SpellArray[i][4]
            local Item      = SpellArray[i][5]
            local Id        = SpellBook[Name]['Id']
            local Mana      = SpellBook[Name]['Mana']
            local Texture   = SpellBook[Name]['Texture']
            local HealBonus = Player['HealBonus']
            local BonusRate = SpellBook[Name]['BonusRate']
            local Spell     = SpellBook[Name]['Spell']
            local Rank      = SpellBook[Name]['Rank']
            local _, CoolDown = GetSpellCooldown(Id, BOOKTYPE_SPELL)

            -- Heal Bonus calc
            if ( Player["HealBonus"] > 0 ) then
                RSavedHealer_DebugPrint("  Current Heal Bonus: "..HealBonus)
                RSavedHealer_DebugPrint("  Spell Heal Bonus Rate: "..BonusRate)
                HealBonus = HealBonus * BonusRate
                
                if ( Level <= 20 ) then
                    RSavedHealer_DebugPrint("   Spell Level lower than 20, fixing the heal bonus!")
                    HealBonus  = (1 - ( (20- Level ) * 0.0375) ) * HealBonus 
                end
                
                _, _, HealBonus = string.find(HealBonus, "^([0-9]+)")
                RSavedHealer_DebugPrint("  Calculated Heal Bonus: "..HealBonus)
            end

            spellEffect = SpellBook[Name]['MinDmg'] + HealBonus
            
            if ( RSavedHealerConfig.Healing.CalcType == 1 ) then
                RSavedHealer_DebugPrint(" Using Spell Min Effect!")
                
            elseif ( RSavedHealerConfig.Healing.CalcType == 2 and SpellBook[Name]['MaxDmg'] ) then
                RSavedHealer_DebugPrint(" Using Spell Average Effect!")
                local average = ( SpellBook[Name]['MaxDmg'] - SpellBook[Name]['MinDmg'] ) / 2
                spellEffect = SpellBook[Name]['MinDmg'] + average + HealBonus
                
            elseif ( RSavedHealerConfig.Healing.CalcType == 3 and SpellBook[Name]['MaxDmg'] ) then
                RSavedHealer_DebugPrint(" Using Spell Max Effect!")
                spellEffect = SpellBook[Name]['MaxDmg'] + HealBonus
                
            end
            
            if ( RSavedHealerConfig.Healing.AddCriticalEffect ) then
                RSavedHealer_DebugPrint(" Adding Critical Effect!")
                RSavedHealer_DebugPrint("  Spell Efect Before: "..spellEffect)
                spellEffect = spellEffect * 1.5
                RSavedHealer_DebugPrint("  Spell Efect After: "..spellEffect)
            end

            
            local haveItem = true
            if ( Item ~= nil ) then
                RSavedHealer_DebugPrint(" Item needed: "..Item)
                haveItem = RSavedHealer_IsItemInInventory(Item)
            end

            if (
                string.find(Name, "^"..RSH_LNG['FlashHeal'] ) or
                (
                    string.find(Name, "^"..RSH_LNG['Regrowth']) and
                    RSavedHealerConfig.Healing.IgnoreRegrowth              
                )
            ) then
                RSavedHealer_DebugPrint("  Ignoring Buff Check in this spell ("..Name..")")
                
            elseif ( RSavedHealer_CheckUnitBuff(Target["Unit"],Texture) ) then
                return false
                
            end

            local RankLimit = 0
            if ( RSavedHealerConfig.Healing.Ranks[Spell] ~= nil ) then
                if (
                    RSavedHealerConfig.Healing.Ranks[Spell] > 0 and
                    tonumber(Rank) > RSavedHealerConfig.Healing.Ranks[Spell]
                ) then
                    RSavedHealer_DebugPrint(
                        "   "..Rank.." is higher or equal to "..
                        RSavedHealerConfig.Healing.Ranks[Spell]
                    )
                    RankLimit = 1
                end
            end

            if (
                CoolDown ~= 0
            ) then
                RSavedHealer_DebugPrint("  With colldown!")
                return false

            elseif (
                RankLimit ~= 0
            ) then
                RSavedHealer_DebugPrint("  Skiping this rank!")
                
            elseif (
                Player['Level'] >= Level and
                (
                    Player['Mana'] >= Mana or
                    RSavedHealer_CheckUnitBuff(
                        "player", "Interface\\Icons\\Spell_Frost_WindWalkOn"
                    )
                ) and
                Target['Level'] >= TgMinLvl and Target['Level'] <= TgMaxLvl and
                (
                    OptionsArray["Charm"] or OptionsArray["Buff"] or
                    ( Target['Damage'] >= spellEffect or OptionsArray["Higher"] == 1 )
                )
            ) then
                RSH_EFFECT = spellEffect
                if ( RSavedHealer_CastSpell(Name, Target) ) then
                    RSavedHealer_DebugPrint("  Found "..Name.." "..spellEffect)
                    return true
                else
                    RSavedHealer_DebugPrint("  For some reason I can't use this spell in this bastard, let's try another!")
                    return false
                end
            end
        end
    end
    return false
end

-- Is Item In Inventory
function RSavedHealer_IsUnitInParty(UnitNames)
    RSavedHealer_DebugPrint("|cFFFF0000_IsUnitInParty function called!")
	local RaidMembers  = GetNumRaidMembers()
	local PartyMembers = GetNumPartyMembers()
    local Units = { }
    
    if ( RaidMembers > 0 ) then
		Units = RSavedHealer_GetGroupUnits("raid", RaidMembers )
	elseif ( PartyMembers > 0 ) then
		Units = RSavedHealer_GetGroupUnits("party", PartyMembers )
    end

    for i = 1, table.getn(Units) do
        Unit = Units[i]
        if ( UnitNames == UnitName(Unit) ) then return true end
    end
    
    return false
end

-- Is Item In Inventory
function RSavedHealer_IsItemInInventory(Item)
	RSavedHealer_DebugPrint("|cFFFF0000_IsItemInInventory Function Called!")
	
	-- Searching Bags
	for bag = 0, 4 do
		local bagSlots = GetContainerNumSlots(bag)
		
		if ( bagSlots ) then
			--RSavedHealer_DebugPrint("  Bag #"..bag.." have "..bagSlots.." Slots!")
			for bagSlot = 1, bagSlots, 1 do
				local itemLink = GetContainerItemLink(bag, bagSlot)
				if ( itemLink ) then
					local _,_,_,itemName = string.find(itemLink,"|H(item:%d+:%d+:%d+:%d+)|h%[([^]]+)%]|h|r$")
					--RSavedHealer_DebugPrint("   Found Item: "..itemName)
					if ( itemName == Item ) then return true end
				end
			end
		end
	end
	
	-- Searching Inventory
	for slot = 0, 18 do
		local itemLink = GetInventoryItemLink("player", slot)
		if ( itemLink ) then
			local _,_,_,itemName = string.find(itemLink,"|H(item:%d+:%d+:%d+:%d+)|h%[([^]]+)%]|h|r$")
			--RSavedHealer_DebugPrint("   Found Item: "..itemName)
			if ( itemName == Item ) then return true end
		end
	end
	
	return false
end

-- On Event
function RSavedHealer_OnEvent(event)
    --RSavedHealer_DebugPrint("|cFFFF0000_OnEvent Function Called!")
    --RSavedHealer_DebugPrint(" event: "..event )

	if ( event == "PLAYER_ENTERING_WORLD" ) then
		RSavedHealer_RegisterEvents();
		return;
	elseif ( event == "PLAYER_LEAVING_WORLD" ) then
		RSavedHealer_UnregisterEvents();
		return;
	end

    if (
        event == "CHAT_MSG_ADDON" and arg1 == "RSAVEDPRIEST" and
        ( arg3 == "RAID" or arg3 == "PARTY" ) and RSH_PLAYERNAME ~= arg4
    ) then
        local parsed,_,action,target,effect,status = string.find(arg2, "^<([^:]+):([^:]+):([^:]+):([^>]+)>$")
		--RSavedHealer_ChatPrint( arg1.." "..arg2.." "..arg3.." "..arg4 )
        
        local PartyMembers = GetNumPartyMembers()

		if ( parsed and PartyMembers > 0 ) then
			if ( action == "1" ) then
				if ( status == "-1" ) then
                    if (
                        RSavedHealerConfig["Healing"]["GroupMessages"]
                    ) then
                        local arg4Unit = RSavedHealer_GetUnitByName(arg4)
                        local targetUnit = RSavedHealer_GetUnitByName(target)
                        RSavedHealer_ChatPrint(
                        	" "..RSH_CLASS_COLORS[UnitClass(arg4Unit)]..arg4..
                            "|r is healing "..RSH_CLASS_COLORS[UnitClass(targetUnit)]..
                            target.."|r for "..effect.."!",
                        	0.7, 0.7, 0.7
                        )
                    end
                    HealingUnits[target] = effect
                
				elseif ( status == "1" ) then
                    HealingUnits[target] = nil
                end
			end
		end

    elseif (
        event == "CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS"
        or event == "CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS"
        or event == "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE"
        or event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE"
        or event == "CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS"
    ) then
        local paterns = {
            "hits ([^ ]+) for ([0-9]+)",
            "crits ([^ ]+) for ([0-9]+)",
        }
        local seconds = GetTime();

        for i in paterns do
            local _,_,target,damage = string.find(arg1, paterns[i])
            if ( target == "you" ) then target = RSH_PLAYERNAME end
            if ( target ~= nil and damage ~= nil ) then
                RSavedHealer_ChatPrint( " "..seconds.." "..target.." "..damage )
            end
        end
        
	elseif (
        event == "SPELLCAST_STOP" or event == "SPELLCAST_INTERRUPTED" or
        event == "SPELLCAST_FAILED"
    ) then
        for i = 1, table.getn(RSH_UNITS) do
            SendAddonMessage("RSAVEDPRIEST", "<"..RSH_ACTION..":"..RSH_UNITS[i]..":0:1>", "RAID")
            HealingUnits[RSH_UNITS[i]] = nil
        end
        RSH_UNITS = { }
        --HealingUnits = { }

	elseif ( event == "SPELLS_CHANGED" ) then
		RSavedHealer_DebugPrint("Spells Changed!")
		RSavedHealer_GetSpellBook()

	elseif ( event == "VARIABLES_LOADED" ) then
		RSavedHealer_ChatPrint(
			"Rivotti's Saved Healer v"..RSAVEDHEALER_VERSION..
            " loaded (type \/rsh for options)", 0.8, 0.8, 0.2
		)
		RSavedHealer_GetSpellBook()
		RSH_CLASS = UnitClass("player")
		RSH_PLAYERNAME = UnitName("player")

        -- Config
        if (
            RSavedHealerConfig.General.Version == nil or
            RSavedHealerConfig.General.Version < RSH_REAL_VERSION
        ) then
            RSavedHealer_ChatPrint(
            	" New version installed, updating config...", 0.8, 0.8, 0.2
            )
            RSavedHealerConfig = {
                ["Buffing"] = {
                    ["Spells"] = {
                    },
                },
                ["General"] = {
                    ["Version"] = RSH_REAL_VERSION,
                },
                ["Healing"] = {
                    ["BelowHPPercent"] = 90,
                    ["ByPercent"] = 1,
                    ["CalcType"] = 1,
                    ["Classes"] = {
                    },
                    ["Groups"] = {
                    },
                    ["PartyMinMembers"] = 3,
                    ["PartySkipOnDamagePercent"] = 50,
                    ["QuickOnPercent"] = 50,
                    ["Ranks"] = {
                    },
                },
            }
        end
	end
end

-- On Load
function RSavedHealer_OnLoad()
	RSavedHealer_DebugPrint("|cFFFF0000_OnLoad Function Called!")
	
	if (
        UnitClass("player") ~= "Priest" and UnitClass("player") ~= "Druid" and
        UnitClass("player") ~= "Shaman"
    ) then
		return
	end

	--Register Events
	this:RegisterEvent("VARIABLES_LOADED")
	--this:RegisterEvent("PLAYER_ENTERING_WORLD")
	--this:RegisterEvent("PLAYER_LEAVING_WORLD")
    this:RegisterEvent("CHAT_MSG_ADDON")
	this:RegisterEvent("SPELLS_CHANGED")
	this:RegisterEvent("SPELLCAST_STOP")
    this:RegisterEvent("SPELLCAST_INTERRUPTED")
    this:RegisterEvent("SPELLCAST_FAILED")
    
	
    SLASH_RSH1 = "/RSavedHealer"
    SLASH_RSH2 = "/rsh"
    SlashCmdList["RSH"] = function(str)
		if (RSavedHealerConfigFrame:IsVisible()) then
			HideUIPanel(RSavedHealerConfigFrame)
		else
			ShowUIPanel(RSavedHealerConfigFrame)
		end
    end

    -- Debug
	SLASH_RSHD1 = "/rshdebug"
    SLASH_RSHD2 = "/rshd"
    SlashCmdList["RSHD"] = function()
		if ( RSavedHealerConfig.General.Debug == nil ) then
            RSavedHealerConfig.General.Debug = 1
        else
            RSavedHealerConfig.General.Debug = nil
        end
    end

    -- Buff
	SLASH_RSHB1 = "/rshbuff"
    SLASH_RSHB2 = "/rshb"
    SlashCmdList["RSHB"] = function()
		RSavedHealer_Buff()
    end

    -- Crowd Control
	SLASH_RSHCC1 = "/rshcrowdcontrol"
    SLASH_RSHCC2 = "/rshcc"
    SlashCmdList["RSHCC"] = function()
        if (
        	UnitExists("target") and UnitIsEnemy("player", "target") and
        	not UnitIsDeadOrGhost("target")	and UnitIsVisible("target")
        ) then
            local targetType = UnitCreatureType("target")
            RSavedHealer_DebugPrint("Target type is "..targetType.."!")

            if ( RSH_CC_SPELLS[RSH_CLASS][targetType] ~= nil ) then
                RSavedHealer_Attack(RSH_CC_SPELLS[RSH_CLASS][targetType], "Charm")
            elseif ( RSH_CLASS == "Druid" ) then
                RSavedHealer_Attack(RSH_CC_SPELLS[RSH_CLASS]["Entangling_Roots"], "Charm")
            end
    	end
    end

    -- Heal
	SLASH_RSHH1 = "/rshheal"
    SLASH_RSHH2 = "/rshh"
    SlashCmdList["RSHH"] = function()
		RSavedHealer_Heal(
            RSH_HEAL_SPELLS[RSH_CLASS]['Max_Heal'],
            RSH_HEAL_SPELLS[RSH_CLASS]['Quick_Heal']
        )
    end

    -- Party Heal
	SLASH_RSHPH1 = "/rshpartyheal"
    SLASH_RSHPH2 = "/rshph"
    SlashCmdList["RSHPH"] = function()
        if ( not RSavedHealer_PartyHeal(RSH_HEAL_SPELLS[RSH_CLASS]['Party_Heal']) ) then
            RSavedHealer_Heal(
                RSH_HEAL_SPELLS[RSH_CLASS]['Max_Heal'],
                RSH_HEAL_SPELLS[RSH_CLASS]['Quick_Heal']
            )
        end
    end

    -- Renew
	SLASH_RSHR1 = "/rshrenew"
    SLASH_RSHR2 = "/rshr"
    SlashCmdList["RSHR"] = function()
		RSavedHealer_Heal(RSH_HEAL_SPELLS[RSH_CLASS]['Renew'], nil, "Higher" )
	end

    -- Version
	SLASH_RSHV1 = "/rshversion"
    SLASH_RSHV2 = "/rshver"
    SlashCmdList["RSHV"] = function()
		RSavedHealer_ChatPrint(
			"Rivotti's Saved Healer v"..RSAVEDHEALER_VERSION , 0.8, 0.8, 0.2
		)
	end

    -- Test
    SLASH_RSHT1 = "/rshtest"
    SlashCmdList["RSHT"] = function()
        table.foreach(HealingUnits, function(Unit, Heal)
        	RSavedHealer_ChatPrint(" "..Unit.." "..Heal )
        end)
        --HealingUnits = { }
    end
end

function RSavedHealer_RegisterEvents()
    RSavedHealer_DebugPrint("|cFFFF0000_RegisterEvents function called!")
	for index, event in RSavedHealerEvents do
		this:RegisterEvent(event);
	end
end

function RSavedHealer_UnregisterEvents()
    RSavedHealer_DebugPrint("|cFFFF0000_UnregisterEvents function called!")
	for index, event in RSavedHealerEvents do
		this:UnregisterEvent(event);
	end
end

function RSavedHealer_Percent(MaxValue,Value)
    RSavedHealer_DebugPrint("|cFFFF0000_Percent function called!")
	return tonumber(Value) * 100 / tonumber(MaxValue)
end

--[[
--   Buffs Frame
--
--]]

function RSavedHealerBuffsFrame_DropDown_Initialize()
	RSavedHealer_DebugPrint("|cFFFF0000_DropDown_Initialize Function Called!")
	
	local selectedValue = UIDropDownMenu_GetSelectedValue(Buffing_Spells_DropDown)
	
	local priestSpells = {
		"DivineSpirit", "FearWard", "Fortitude", "InnerFire", "PrayerFortitude",
		"ShadowProtection", "TouchWeakness"
	}
	local druidSpells  = {
        "GiftWild", "MarkWild", "NaturesGrasp", "OmenClarity", "Thorns"
    }
    local shamanSpells = { }
	local Spells = priestSpells
	
	if ( UnitClass("player") == "Druid" ) then Spells = druidSpells end
    if ( UnitClass("player") == "Shaman" ) then Spells = shamanSpells end

	for i = 1, table.getn(Spells) do
		local info = {}
		info.text = RSH_LNG[Spells[i]]
		info.func = RSavedHealerBuffsFrame_DropDown_OnClick
		info.value = Spells[i]
		if ( info.value == selectedValue ) then
			info.checked = 1
		end
		UIDropDownMenu_AddButton(info)
	end
end

function RSavedHealerBuffsFrame_DropDown_OnClick()
	RSavedHealer_DebugPrint("|cFFFF0000_DropDown_OnClick Function Called!")
	
	UIDropDownMenu_SetSelectedValue(Buffing_Spells_DropDown, this.value)
	
	Buffing_Spells_DivineSpirit:Hide()
	Buffing_Spells_FearWard:Hide()
	Buffing_Spells_Fortitude:Hide()
	Buffing_Spells_InnerFire:Hide()
	Buffing_Spells_PrayerFortitude:Hide()
	Buffing_Spells_ShadowProtection:Hide()
	Buffing_Spells_TouchWeakness:Hide()
	Buffing_Spells_GiftWild:Hide()
	Buffing_Spells_MarkWild:Hide()
    Buffing_Spells_NaturesGrasp:Hide()
	Buffing_Spells_OmenClarity:Hide()
	Buffing_Spells_Thorns:Hide()
	
	getglobal("Buffing_Spells_"..this.value):Show()
end

function RSavedHealerBuffsFrame_DropDown_OnShow()
	RSavedHealer_DebugPrint("|cFFFF0000_DropDown_OnLoad Function Called!")
	
	UIDropDownMenu_Initialize(Buffing_Spells_DropDown, RSavedHealerBuffsFrame_DropDown_Initialize)
	UIDropDownMenu_SetWidth(130, Buffing_Spells_DropDown)
	UIDropDownMenu_SetSelectedID(Buffing_Spells_DropDown, 1)

	Buffing_Spells_DivineSpirit:Hide()
	Buffing_Spells_FearWard:Hide()
	Buffing_Spells_Fortitude:Hide()
	Buffing_Spells_InnerFire:Hide()
	Buffing_Spells_PrayerFortitude:Hide()
	Buffing_Spells_ShadowProtection:Hide()
	Buffing_Spells_TouchWeakness:Hide()
	Buffing_Spells_GiftWild:Hide()
	Buffing_Spells_MarkWild:Hide()
    Buffing_Spells_NaturesGrasp:Hide()
	Buffing_Spells_OmenClarity:Hide()
	Buffing_Spells_Thorns:Hide()

    if ( UnitClass("player") == "Druid"  ) then Buffing_Spells_GiftWild:Show() end
    if ( UnitClass("player") == "Priest" ) then Buffing_Spells_DivineSpirit:Show() end
end

function RSavedHealerBuffsFrame_OnShow()
	RSavedHealer_DebugPrint("|cFFFF0000_OnShow Function Called!")
    	
	RSavedHealer_DebugPrint(" Buffing")
	table.foreach(RSavedHealerConfig.Buffing, function(Key, Value)
		if ( Key == "MinMana" ) then
			getglobal("Buffing_"..Key):SetValue( Value )
		elseif ( Key ~= "Spells" ) then
			getglobal("Buffing_"..Key):SetChecked( Value )
		end
	end)
end



--[[
--   Config Frame
--
--]]

function RSavedHealerConfigFrame_CheckButton_OnClick()
	RSavedHealer_DebugPrint("|cFFFF0000_CheckButton_OnClick Function Called!")
	
	local widget = this:GetName()
	RSavedHealer_DebugPrint(" "..widget)
	
	if ( string.find(widget, "^Buffing") ) then
		local _, _, Key = string.find(widget, "^Buffing_([-A-Za-z0-9]+)")
		
		if ( Key == "Spells" ) then
			local _, _, Spell, Key = string.find(
				widget, "^Buffing_Spells_([-A-Za-z0-9]+)_([-A-Za-z0-9]+)$"
			)
			if ( RSavedHealerConfig.Buffing.Spells[Spell] == nil) then
				RSavedHealerConfig.Buffing.Spells[Spell] = { }
			end
			RSavedHealerConfig.Buffing.Spells[Spell][Key] = this:GetChecked()
		else
			RSavedHealerConfig.Buffing[Key] = this:GetChecked()
		end
	end

	if ( string.find(widget, "^Healing") ) then
		local _, _, Key = string.find(widget, "^Healing_([-A-Za-z0-9]+)")
		
		if ( Key == "Classes" ) then
			local _, _, Class = string.find(
				widget, "^Healing_Classes_([-A-Za-z0-9]+)$"
			)
			if ( RSavedHealerConfig.Healing.Classes == nil) then
				RSavedHealerConfig.Healing.Classes = { }
			end
			RSavedHealerConfig.Healing.Classes[Class] = this:GetChecked()

		elseif ( Key == "Groups" ) then
			local _, _, Group = string.find(
				widget, "^Healing_Groups_([1-8])$"
			)
			if ( RSavedHealerConfig.Healing.Groups == nil) then
				RSavedHealerConfig.Healing.Groups = { }
			end
			RSavedHealerConfig.Healing.Groups[Group] = this:GetChecked()

		else
			RSavedHealerConfig.Healing[Key] = this:GetChecked()
		end
	end
end

function RSavedHealerConfigFrame_Calc_DropDown_Initialize(options)
	RSavedHealer_DebugPrint("|cFFFF0000_Calc_DropDown_Initialize Function Called!")
	
	local selectedValue = UIDropDownMenu_GetSelectedValue(this)
	--local options = { "Use Spell Min", "Use Spell Average", "Use Spell Max", }

	for i = 1, table.getn(options) do
        RSavedHealer_DebugPrint("  "..i.." "..options[i])
		local info = {}
		info.text = options[i]
		info.func = RSavedHealerConfigFrame_Calc_DropDown_OnClick
		info.value = i
		if ( info.value == selectedValue ) then
			info.checked = 1
		end
		UIDropDownMenu_AddButton(info)
	end
end

function RSavedHealerConfigFrame_Calc_DropDown_OnClick()
	RSavedHealer_DebugPrint("|cFFFF0000_Calc_DropDown_OnClick Function Called!")
	UIDropDownMenu_SetSelectedValue(Healing_Calc_DropDown, this.value)
    RSavedHealerConfig.Healing.CalcType = this.value
end

function RSavedHealerConfigFrame_Calc_DropDown_OnShow()
	RSavedHealer_DebugPrint("|cFFFF0000_Calc_DropDown_onShow Function Called!")
	local options = { "Use Spell Min", "Use Spell Average", "Use Spell Max", }
    
	UIDropDownMenu_Initialize(this, function()
        RSavedHealerConfigFrame_Calc_DropDown_Initialize(options)
    end )
	UIDropDownMenu_SetWidth(160, this)
    UIDropDownMenu_SetSelectedValue(this, RSavedHealerConfig.Healing.CalcType)
end


function RSavedHealerConfigFrame_Ranks_DropDown_Initialize(comboName, spellName)
	RSavedHealer_DebugPrint("|cFFFF0000_Ranks_DropDown_Initialize Function Called!")
	
	local selectedValue = UIDropDownMenu_GetSelectedValue(this)

    local info = {}
    info.text = "No Limit"
    info.func = function()
        RSavedHealerConfigFrame_Ranks_DropDown_OnClick(comboName, RSH_LNG[spellName])
    end
    info.value = 0
    if ( info.value == selectedValue ) then
		info.checked = 1
	end

    UIDropDownMenu_AddButton(info)

	for i = 1, table.getn(RSH_SPELLS[spellName]) do
        RSavedHealer_DebugPrint("  Rank "..i)
		local info = {}
		info.text = "Rank "..i
		info.func = function()
            RSavedHealerConfigFrame_Ranks_DropDown_OnClick(comboName, RSH_LNG[spellName])
        end
		info.value = i
		if ( info.value == selectedValue ) then
            RSavedHealer_DebugPrint("   Selected")
			info.checked = 1
		end
		UIDropDownMenu_AddButton(info)
	end
end

function RSavedHealerConfigFrame_Ranks_DropDown_OnClick(comboName, spellName)
	RSavedHealer_DebugPrint("|cFFFF0000_Ranks_DropDown_OnClick Function Called!")
    RSavedHealer_DebugPrint(" "..comboName.." "..spellName.." "..this.value)
    UIDropDownMenu_SetSelectedValue(getglobal(comboName), this.value)
    RSavedHealerConfig.Healing.Ranks[spellName] = this.value
end

function RSavedHealerConfigFrame_Ranks_DropDown_OnShow()
	RSavedHealer_DebugPrint("|cFFFF0000_Ranks_DropDown_onShow Function Called!")

    local spells = {
        Druid = {
            ["Healing_Ranks_DropDown_1"] = 'HealingTouch',
            ["Healing_Ranks_DropDown_2"] = 'Regrowth',
            ["Healing_Ranks_DropDown_3"] = 'Rejuvenation',
            --["Healing_Ranks_DropDown_4"] = '',
        },
        Priest = {
            ["Healing_Ranks_DropDown_1"] = 'FlashHeal',
            ["Healing_Ranks_DropDown_2"] = 'GreaterHeal',
            ["Healing_Ranks_DropDown_3"] = 'PrayerHealing',
            ["Healing_Ranks_DropDown_4"] = 'Renew',
        },
        Shaman = {
            ["Healing_Ranks_DropDown_1"] = 'HealingWave',
            ["Healing_Ranks_DropDown_2"] = 'LesserHealingWave',
            --["Healing_Ranks_DropDown_3"] = '',
            --["Healing_Ranks_DropDown_4"] = '',
        }
    }
    
    local comboName   = this:GetName()
    local spellName   = spells[RSH_CLASS][comboName]
    local spellValue = 0
    if ( RSavedHealerConfig.Healing.Ranks[RSH_LNG[spellName]] ) then
        spellValue = RSavedHealerConfig.Healing.Ranks[RSH_LNG[spellName]]
    end
        
    if ( spellName ) then
        local comboLabel = RSH_LNG[spellName];
        RSavedHealer_DebugPrint(" "..spellName)
        UIDropDownMenu_Initialize(this, function()
            RSavedHealerConfigFrame_Ranks_DropDown_Initialize(comboName, spellName)
        end )
        getglobal(comboName.."Label"):SetText(comboLabel)
        UIDropDownMenu_SetWidth(160, this)
        if ( spellValue ) then
            UIDropDownMenu_SetSelectedValue(this, spellValue)
        end
    else
        getglobal(this:GetName()):Hide()
    end
end



function RSavedHealerConfigFrame_OnShow()
	RSavedHealer_DebugPrint("|cFFFF0000_OnShow Function Called!")

	RSavedHealer_DebugPrint("  Spells")
	table.foreach(RSavedHealerConfig.Buffing.Spells, function(Spell)
		RSavedHealer_DebugPrint("   "..Spell )

		table.foreach(RSavedHealerConfig.Buffing.Spells[Spell], function(Key, Value)
			RSavedHealer_DebugPrint("    "..Key.." "..Value )
			getglobal("Buffing_Spells_"..Spell.."_"..Key):SetChecked( Value )
		end)
	end)

	RSavedHealer_DebugPrint(" Healing")
	table.foreach(RSavedHealerConfig.Healing, function(Key, Value)
		if (
            Key == "QuickOnPercent" or Key == "BelowHPPercent" or
            Key == "PartyMinMembers" or Key == "PartySkipOnDamagePercent"
        ) then
			getglobal("Healing_"..Key):SetValue( Value )
		elseif ( Key ~= "Classes" and Key ~= "Groups" and Key ~="CalcType" and Key ~= "Ranks" ) then
			getglobal("Healing_"..Key):SetChecked( Value )
		end
	end)
	
	RSavedHealer_DebugPrint("  Classes")
	table.foreach(RSavedHealerConfig.Healing.Classes, function(Class, Value)
		RSavedHealer_DebugPrint("   "..Class.." "..Value )
		getglobal("Healing_Classes_"..Class):SetChecked( Value )
	end)

	RSavedHealer_DebugPrint("  Groups")
	table.foreach(RSavedHealerConfig.Healing.Groups, function(Group, Value)
		RSavedHealer_DebugPrint("   "..Group.." "..Value )
		getglobal("Healing_Groups_"..Group):SetChecked( Value )
	end)

end

function RSavedHealerConfigFrame_Slider_OnChange()
	RSavedHealer_DebugPrint("|cFFFF0000_Slider_OnChange Function Called!")
	
	local widget = this:GetName()
	RSavedHealer_DebugPrint(" "..widget)
	
	local _, _, Section, Var = string.find(
		widget, "^([-A-Za-z0-9]+)_([-A-Za-z0-9]+)$"
	)
	
	if ( Section ) then
		RSavedHealerConfig[Section][Var] = this:GetValue()
	end
end

function RSavedHealerConfigFrame_Slider_OnShow()
    RSavedHealer_DebugPrint("|cFFFF0000_Slider_OnShow Function Called!")
	getglobal(this:GetName().."High"):SetText("100%")
	getglobal(this:GetName().."Low"):SetText("0%")
	this:SetMinMaxValues(0, 100)
	this:SetValueStep(5)
	this.tooltipText = ""
end