--[[

pa_heal.lua
Panza Heal functions
Revision 4.0

10-01-06 "for in pairs()" completed for BC
--]]

PA.LowestPlayerHealth = 1.0;
PANZA_MATCH_BAR = "^(.+) ([%(%[])(%d+)[%)%]] %-%> (.+)";


----------------------------------------------------------------------------
-- +Healing bounus is reduced depending on base casting time and spell level
--
-- bonus% = (casttime/3.5)*(0.0375*spelllvl+0.25)
--
-- testing:
--
-- rank 3: (2.5/3.5)*(0.0375*14+0.25) = 55.4%
-- rank 2: (2.0/3.5)*(0.0375*8+0.25)  = 31.43%
-- rank 1: (1.5/3.5)*(0.0375*1+0.25)  = 12.32%
-----------------------------------------------------------------------------
function PA:HealingBonusCorrection(baseCastTime, spellLevel)
	if (baseCastTime==nil) then
		return 1;
	end
	if (spellLevel==nil or spellLevel>=20) then
		return baseCastTime / 3.5;
	end
	return (baseCastTime / 3.5) * (0.0375 * spellLevel + 0.25);
end

---------------------------------------------------------
-- If Divine Favor exists on "player" calculate crit
---------------------------------------------------------
function PA:DFCrit()
	local dfcrit = 1.0; -- no auto crit
	local SpecialUp = PA:HasHealSpecialUp();
	if (PA.PlayerClass=="PALADIN") then
		if (SpecialUp) then
			dfcrit = 1.5;
			if (PA:CheckMessageLevel("Core", 5)) then
				PA:Message4("(BestHeal) Divine Favor found");
			end
			if (PA:CheckMessageLevel("Heal", 4)) then
				PA:Message4("Divine Favor Bonus: "..format('%.0f', dfcrit * 100).."%.");
			end
		end
	end
	PA:Debug("DFCrit Factor=", dfcrit, " SpecialUp=", SpecialUp);
	return dfcrit, SpecialUp;
end

function PA:HasHealSpecialUp()
	PA:Debug("Checking for HEALSPECIAL ...");
	local SpellId = PA:GetSpellProperty("HEALSPECIAL", "Index");
	PA:Debug("SpellId=", SpellId);
	if (SpellId~=nil and SpellId>0) then
		local spstart, spdur, flag = GetSpellCooldown(SpellId, BOOKTYPE_SPELL);
		PA:Debug("spstart=", spstart, " spdur=", spdur, " flag=", flag);
		return (spdur==0.001);
	end
	return false;
end

------------------------------------------------------------------------------
-- Calculates min and max healing for a given spell, including bonus and crits
------------------------------------------------------------------------------
function PA:HealingMinMax(heal, rank, hBonus, oBonus, dfcrit, hwaybonus, HealingDebuffFactor)
	--PA:Debug("Entry HealingMinMax() heal=", heal, " rank=", rank, " hBonus=", hBonus, " oBonus=", oBonus, " dfcrit=", dfcrit, " DebuffFactor=", HealingDebuffFactor);
	local Spell = PA.SpellBook[heal][rank];
	local SpellLevel = nil;
	if (PA.Spells.Levels[heal]~=nil) then
		SpellLevel = PA.Spells.Levels[heal][rank];
	end
	local BaseCastTime = nil;
	if (PA.Spells.BaseCastTime[heal]~=nil) then
		BaseCastTime = PA.Spells.BaseCastTime[heal][rank];
		if (BaseCastTime==nil) then
			local LastRank = PA:TableSize(PA.Spells.BaseCastTime[heal]);
			BaseCastTime = PA.Spells.BaseCastTime[heal][LastRank];
		end
	end
	if (BaseCastTime==nil) then
		BaseCastTime = Spell.CastTime;
	end
	--PA:ShowText("BaseCastTime=", BaseCastTime, " spellLevel=", SpellLevel);
	--local CorrectedBonus = (oBonus + (hBonus/(HealingDebuffFactor or 1))) * PA:HealingBonusCorrection(BaseCastTime, SpellLevel);
	local CorrectedBonus = (oBonus + hBonus) * PA:HealingBonusCorrection(BaseCastTime, SpellLevel);

	--PA:ShowText("CorrectedBonus=", CorrectedBonus);
	local MinHeal = math.floor(((Spell.Min + CorrectedBonus) * dfcrit) / (HealingDebuffFactor or 1));
	local MaxHeal = math.ceil(((Spell.Max + CorrectedBonus) * dfcrit) / (HealingDebuffFactor or 1));

	-- Factor in hway (adds x% to healing wave)
	if (hwaybonus and hwaybonus>0) then
		MinHeal = floor(MinHeal + (MinHeal * hwaybonus));
		MaxHeal = floor(MaxHeal + (MaxHeal * hwaybonus));
	end

	local Average = (MinHeal + MaxHeal) / 2;
	local CritBonus =  Average * (dfcrit - 1) / dfcrit;
	--PA:Debug("Exit HealingMinMax() Min=", Spell.Min, " MinHeal=", MinHeal, "  Max=", Spell.Max, " MaxHeal=", MaxHeal, " CritBonus=", CritBonus, " Average=", Average);
	return MinHeal, MaxHeal, CorrectedBonus + CritBonus, Average;
end

------------------------------------------------------------------------------------
-- Find best heal to heal amount, factors in healing bonus, debuffs, and DF critical
------------------------------------------------------------------------------------
function PA:ProcessHeal(heal, amount, healingGearBonus, obonus, dfcrit, manaExtra, minrank, hwaybonus, HealingDebuffFactor)

	--PA:Debug("Entry ProcessHeal() heal=", heal, " amount=", amount, " healingGearBonus=", healingGearBonus, " oBonus=", obonus, " dfcrit=", dfcrit, " DebuffFactor=", HealingDebuffFactor);

	-- getn(PA.SpellBook[heal] will return nil if we attempt to cast a spell we havn't indexed
	if (not PA:SpellInSpellBook(heal)) then
		if (PA:CheckMessageLevel("Heal", 4)) then
			PA:Message4("Tried to use "..heal.." Spells, but not in spellbook");
		end
		PA.AbortCurrentLoop = true;
		return;
	end

	local spellmin, spellmax, rank, Bonus, Average;
	local total = getn(PA.SpellBook[heal]);
	if (PA:CheckMessageLevel("Heal", 5)) then
		PA:Message4("Using "..PA.SpellBook[heal].Name.." Spells");
	end

	if (minrank==nil or minrank==0) then minrank=1; end

	---------------------
	-- Initial Mana check
	---------------------
	local Mana = UnitMana("player") - (manaExtra or 0);
	if (Mana < PA.SpellBook[heal][1].Mana) then
		if (manaExtra==nil or manaExtra==0) then
			if (PA:CheckMessageLevel("Heal", 1)) then
				PA:Message4("You do not have enough Mana to use the "..PA.SpellBook[heal].Name.."(Rank 1) spell!");
			end
			PA.AbortCurrentLoop = true;
		end
		return;
	end

	--------------------------------
	-- Initial Rank Selection Logic
	--------------------------------
	rank = 1; -- Patch for max > amount checking causes nil exception.

	if (minrank==total) then
		rank = total;
	else
		for i = minrank, total do

			spellmin, spellmax = PA:HealingMinMax(heal, i, healingGearBonus, obonus, dfcrit, hwaybonus, HealingDebuffFactor);

			if (PA:CheckMessageLevel("Heal",5)) then
				PA:Message4(PA.SpellBook[heal].Name.."(Rank "..i..") Adj Min="..spellmin..". Adj Max="..spellmax..".");
			end

			if (spellmin <= amount) then
				rank = i;
			elseif (spellmin >= amount)  then
				if (rank > 1) then
					rank = i - 1;
				else
					rank = 1;
				end
				break;

			------------------------------------------------------------------------
			-- Previous Rank was not quite good enough but this one is too much
			------------------------------------------------------------------------
			elseif (spellmax >= amount) then
				if (rank > 1) then
					rank = i - 1;
				else
					rank = 1;
				end
				break;
			end
		end
	end

	---------------------------------
	-- Healing Sensitivity (-5 to +5)
	---------------------------------
	rank = rank + PASettings.Heal.Sense;

	-------------------------------------------------
	-- Sensitivity adjusted too low, bring it back up
	-------------------------------------------------
	if (rank < minrank) then rank = minrank; end

	-----------------------------------------------------------------
	-- Sensitivity adjusted beyond what we have, so tone it back down
	-----------------------------------------------------------------
	if (rank>PA.SpellBook[heal].MaxRank) then
		rank = PA.SpellBook[heal].MaxRank;
	end

	---------------------
	-- Report what we did
	---------------------
	if (PASettings.Heal.Sense ~= 0) then
		if (PA:CheckMessageLevel("Heal", 3)) then
			PA:Message4("Healing Sensitivity adjusted rank to " ..rank.." using "..PASettings.Heal.Sense);
		end
	end

	------------------------------------
	-- Final Rank Reduction Logic (Mana)
	------------------------------------
	if (Mana < PA.SpellBook[heal][rank].Mana) then
		if (PA:CheckMessageLevel("Heal", 2)) then
			PA:Message4("Not enough Mana for "..PA.SpellBook[heal].Name.." (Rank "..rank.."). Reducing rank.");
		end
		while (Mana < PA.SpellBook[heal][rank].Mana) do
			rank = rank - 1;
			if (rank == 0) then
				rank = 1;
				break;
			end
		end
		if (PA:CheckMessageLevel("Heal", 2)) then
			PA:Message4("Reduced rank to "..rank.." for Mana.");
		end
	end

	---------------
	-- Final Report
	---------------
	spellmin, spellmax, Bonus, Average = PA:HealingMinMax(heal, rank, healingGearBonus, obonus, dfcrit, hwaybonus, HealingDebuffFactor);

	if (PA:CheckMessageLevel("Heal", 3)) then
		PA:Message4(PA.SpellBook[heal].Name.." (Rank "..rank..") Selected. Adj Min: "..spellmin..", Adj Max: "..spellmax..".");
	end

	return rank, Bonus, Average;
end

------------------------------------------------------
-- Get Maximum Rank of HOT spell based on target level
------------------------------------------------------
function PA:ProcessRankedHeal(shortSpell, levels, self, tlevel)
	local i=0;

	for i = PA:TableSize(levels), 1, -1 do
		--PA:ShowText("i=", i);
		--PA:ShowText("self=", self);
		--PA:ShowText("tlevel=", tlevel);
		--PA:ShowText("levels[i]=", levels[i]);
		--PA:ShowText("SpellInSpellBook=", PA:SpellInSpellBook(spell, i));
		if (self >= levels[i] and tlevel >= (levels[i]-10) and PA:SpellInSpellBook(shortSpell, i)) then
			--PA:ShowText("Maximum Rank: "..i);
			return i;
		end
	end
	return nil;
end

-------------------------------------------------------------
-- Get Healing bonus(es) from specified buff (+ greater buff)
-------------------------------------------------------------
function PA:GetBuffBonus(unit, bonus, bonus2)

	local index = PA:UnitHasBlessing(unit, bonus);
	if  (index==false and bonus2~=nil) then
		index = PA:UnitHasBlessing(unit, bonus2);
	end

	local Return1, Return2;
	if (index~=nil and index~=false and PA.HealBuffTip[bonus]~=nil and PA.HealBuffTip[bonus].Tip~=nil) then

		if (PA:CheckMessageLevel("Core", 5)) then
			PA:Message4("(GetBuffBonus) "..bonus.." Buff Index : "..index);
		end
		PA:ResetTooltip();
		PanzaTooltip:SetUnitBuff(unit, index);
		local BonusText = getglobal("PanzaTooltipText"..PA.HealBuffTip[bonus].Tip):GetText();
		if (BonusText~=nil) then
			if (PA:CheckMessageLevel("Heal", 5)) then
				PA:Message4("(GetBuffBonus) Bonus Text : "..BonusText);
			end
			Return1, Return2 = PA:ExtractNumbers(BonusText, PA.HealBuffTip[bonus].Count, true);
		end
	end

	return Return1 or 0, Return2 or 0;
end

-----------------------
-- Get Relic bonus(es)
-- Note you can get the ItemId from the allakahazam DB
-- e.g. http://wow.allakhazam.com/db/item.html?witem=23201
--	the witem is what you need to use
-----------------------
function PA:GetRelicBonus()

	local BonusHeal = 0;
	local BonusFlash = 0;
	local RelicInfo =  GetInventoryItemLink("player", GetInventorySlotInfo("RangedSlot"));
	if (RelicInfo~=nil) then
		local _,_,ItemId = string.find(RelicInfo, ".*Hitem:(%d+):.*");
		PA:Debug("(GetRelicBonus) Relic check id=", ItemId, " info=", RelicInfo);
		if (ItemId=="23201") then
			PA:Debug("(GetRelicBonus) Libram of Divinity found");
			-- Libram of Divinity
			BonusHeal = 0;
			BonusFlash = 53;
		elseif (ItemId=="23006") then
			PA:Debug("(GetRelicBonus) Libram of Light found");
			-- Libram of Divinity
			BonusHeal = 0;
			BonusFlash = 83;
		end
	end

	return BonusHeal or 0, BonusFlash or 0;
end

--------------------------------------------------------------------
-- Factor by which healing must be increased to overcome any debuffs
--------------------------------------------------------------------
function  PA:HealingPenaltyFactor(unit)
	local HealingDebuffFactor = 1;

	-- Deadwood Curse (50% reduction)
	if (PA:UnitHasDebuff(unit, "DeadwoodCurse")) then
		if (PA:CheckMessageLevel("Heal",4)) then
			PA:Message4("(PHM) Adjusting for Deadwood Curse, 50% reduction");
		end
		HealingDebuffFactor = HealingDebuffFactor * 2;
	end
	-- Mortal Strike (50% reduction)
	if (PA:UnitHasDebuff(unit, "MortalStrike")) then
		if (PA:CheckMessageLevel("Heal",4)) then
			PA:Message4("(PHM) Adjusting for Mortal Strike, 50% reduction");
		end
		HealingDebuffFactor = HealingDebuffFactor * 2;
	end
	-- Blood Fury (50% reduction)
	if (PA:UnitHasDebuff(unit, "BloodFury")) then
		if (PA:CheckMessageLevel("Heal",4)) then
			PA:Message4("(PHM) Adjusting for Blood Fury, 50% reduction");
		end
		HealingDebuffFactor = HealingDebuffFactor * 2;
	end
	-- Brood Affliction: Green (50% reduction)
	if (PA:UnitHasDebuff(unit, "BroodAffliction")) then
		if (PA:CheckMessageLevel("Heal",4)) then
			PA:Message4("(PHM) Adjusting for Brood Affliction: Green, 50% reduction");
		end
		HealingDebuffFactor = HealingDebuffFactor * 2;
	end
	-- Hex of Weakness (20% reduction)
	if (PA:UnitHasDebuff(unit, "HexWeakness")) then
		if (PA:CheckMessageLevel("Heal",4)) then
			PA:Message4("(PHM) Adjusting for Hex of Weakness, 20% reduction");
		end
		HealingDebuffFactor = HealingDebuffFactor / 0.8;
	end
	return HealingDebuffFactor;
end

---------------------------------------------------------------------------------------------
-- This will check if the target's target is friendly and heal that target.
---------------------------------------------------------------------------------------------
function PA:CheckHealTargetTarget(unit)
	local TargetTargetUnit = unit;
	if (not PA:UnitIsMyFriend(unit)) then
		if (PA:UnitIsMyFriend("targettarget")) then
			local UName = PA:UnitName("targettarget");
			PA:Debug("UName=", UName);
			if (UName~="target") then
				TargetTargetUnit = PA:FindUnitFromTarget("targettarget");
				PA:Debug("TargetTargetUnit=", TargetTargetUnit);
				if (TargetTargetUnit==nil) then
					TargetTargetUnit = "targettarget";
				end
				if (PA:CheckTarget(TargetTargetUnit, false, PA.Spells.Default.Heal, PASettings.Switches.UseActionRange.Heal)) then
					if (PA:CheckMessageLevel("Heal", 3)) then
						PA:Message4("(BestHeal) Healing "..PA:UnitName("target").."\'s target "..UName);					
					end
				else
					if (PA:CheckMessageLevel("Heal", 5)) then
						PA:Message4("(BestHeal) Target check failed for "..UName);
					end
					TargetTargetUnit = "player";
				end
			else
				if (PA:CheckMessageLevel("Core", 5)) then
					PA:Message4("(BestHeal) Intended heal target of target returned invalid unit name.");
				end
				TargetTargetUnit = "player";
			end
		else
			TargetTargetUnit = "player";
		end
	end
	return TargetTargetUnit;
end

----------------------------
-- Use trinket if configured
----------------------------
function PA:CheckHealingTrinket(spellType, dfcrit)
	if (PASettings.Heal.Trinket~=nil and PASettings.Heal.Trinket.Name~=nil) then
		if ((dfcrit>1 and PASettings.Heal.Trinket.OnDF==true)
		  or (spellType=="FLASH" and PASettings.Heal.Trinket.OnFlash==true)
		  or (spellType=="HEAL"  and PASettings.Heal.Trinket.OnHeal==true)) then
			return true;
		end
	end
	return false;
end


--------------------------------------------------------------------
-- Extrapolate HP for friendly given level 1 and 60 HP
-- Boss level mobs could be up to level 500, but 100 is better than -1
-- Elite mobs have more HPs
--------------------------------------------------------------------
function PA:GetExternalHealth(class, targetLevel, targetType, current, pmessage)

	-----------------------------------------------------------------
	-- 2.0 Updated values based on observations.
	-----------------------------------------------------------------
	local PAdefclasshealth = {
		["WARRIOR"]	= { L1=30,	L60=4100 },
		["PALADIN"]	= { L1=30,	L60=4100 },
		["ROGUE"]	= { L1=30,	L60=3100 },
		["HUNTER"]	= { L1=30,	L60=3100 },
		["DRUID"]	= { L1=30,	L60=3100 },
		["SHAMAN"]	= { L1=30,	L60=3100 },
		["WARLOCK"]	= { L1=30,	L60=2300 },
		["MAGE"]	= { L1=30,	L60=2200 },
		["PRIEST"]	= { L1=30,	L60=2100 }
		};

	-- get class
	if (class==nil or 
		(class~="WARRIOR" and class~="PALADIN" and 
		 class~="ROGUE" and class~="HUNTER" and 
		 class~="HUNTER" and class~="DRUID" and 
		 class~="SHAMAN" and class~="WARLOCK" and
		 class~="MAGE" and class~="PRIEST")) then 
		 class="WARRIOR"; 
	end;
	
	if (targetLevel==nil) then targetLevel=60; end;
	
	if (targetLevel==-1) then
		targetLevel = 100;
		if (PA:CheckMessageLevel("Heal", 3)) then
			if (pmessage) then PA:Message4("Target is a Boss (?? Level) "..class..".");end
		end
	else
		if (PA:CheckMessageLevel("Heal", 3)) then
			if (pmessage) then PA:Message4("Estimating HP of a level "..targetLevel.." "..class..".");end
		end
	end
	
	local MaxHealth = math.floor((PAdefclasshealth[class].L60 - PAdefclasshealth[class].L1) * (targetLevel - 1) / 59 + PAdefclasshealth[class].L1);

	-- Elite mobs have lots more HPs ... x 3 ?
	if (targetType=="elite" or targetType=="rareelite") then
		if (PA:CheckMessageLevel("Heal", 3)) then
			PA:Message4("Target is elite");
		end
		MaxHealth = MaxHealth * 3;
	end

	if (current==100) then
		current = MaxHealth;
	else
		current = math.floor(current * MaxHealth / 100);
	end
	return current, MaxHealth;
end

--------------------------------------------------------------------
-- Estimate HP for healing out of the group.
--------------------------------------------------------------------
function PA:GetOutOfGroupHealth(unit, current, maxHealth, pmessage)
	if (maxHealth==100) then
		if (unit==nil) then
			unit="target";
		end
		local _, Class		= UnitClass(unit);
		local TargetLevel	= UnitLevel(unit);
		local Type 			= UnitClassification(unit);
		return PA:GetExternalHealth(Class, TargetLevel, Type, current, pmessage);
	end
	return current, maxHealth;
end


function PA:HealAllowed(spell)
	local Allowed = true;
	if (spell=="FLASH" and PA.PlayerClass=="DRUID") then
		Allowed = (PASettings.Heal.UseRegrowth~=false);
	elseif (spell=="HOT") then
		Allowed = (PASettings.Heal.UseHoTs~=false);
	end
	PA:Debug("HealAllowed for ", spell, " ", Allowed);
	return Allowed;
end


---------------------------------------------------------------
-- Check our family to see if we will overheal using rank 1
-- Lower family if this is the case but don't change HOT.
-- Check the family considered to change to, and make sure the
-- max rank will heal enough before changing the family.
---------------------------------------------------------------
function PA:ReduceForOverheal(spell, amount, otherHealing, ForceMaxHeal, HealingDebuffFactor)

	local spellmin, spellmax, bonus, average, HealingGearBonus, reducingheal = 0, 0, 0, 0, 0, true;

	if (spell=="HOT" or spell=="LESSERHEAL" or ForceMaxHeal==true) then
		return spell;
	end

	if (otherHealing~=nil and otherHealing~=false) then
		amount = amount - otherHealing;
	end

	if (PA:CheckMessageLevel("Heal", 5)) then
		PA:Message4("ReduceForOverheal("..tostring(spell)..","..string.format('%.0f',amount)..","..tostring(ForceMaxHeal)..")");
	end

	HealingGearBonus = PA:HealingBonus();
	
	-- Reduce +Healing according to Debuff (Edit removed for Testing)
	--[[
	if (HealingDebuffFactor~=nill and HealingDebuffFactor>0) then
		HealingGearBonus = HealingGearBonus / (HealingDebuffFactor or 1);
	end	
	--]]
	
	-- Save Spell
	local LastSpell = spell;

	PA:Debug("ReduceForOverHeal() Spell=", spell, " amount needed=", math.floor(amount));

	while (PA:SpellInSpellBook(spell) and reducingheal) do

		-- Get data for rank 1 of current family
		spellmin, spellmax, bonus, average = PA:HealingMinMax(spell, 1, HealingGearBonus, 0, 1, 0, HealingDebuffFactor);

		PA:Debug("ReduceForOverHeal() ", spell, " Min=", math.floor((spellmin + bonus)));
	
		if (amount <= math.floor(spellmin + bonus)) then
			if (PA.NextHeal[spell]==nil) then
				PA:Debug(" NextHeal was nil. Spell was ",spell);
				spell = LastSpell;
				break;
			end	
		end

		--[[	
		-- Get data for max rank of current family
		spellmin, spellmax, bonus, average = PA:HealingMinMax(spell, PA.SpellBook[spell].MaxRank, HealingGearBonus, 0, 1, 0, HealingDebuffFactor);	
		PA:Debug("ReduceForOverHeal() ", spell, " Max=", math.floor((spellmax + bonus)));
		--]]
		
		-- Reduce
		if (PA.NextHeal[spell]~=nil) then
			-- Don't reduce if next heal is turned-off
			if (not PA:HealAllowed(PA.NextHeal[spell])) then
				spell = LastSpell;
				break;
			end
			spell = PA.NextHeal[spell];
		else
			break;
		end

		if (not PA:SpellInSpellBook(spell)) then
			PA:Debug(" NextSpell n ",spell);
			spell = LastSpell;
			break;
		end

		spellmin, spellmax, bonus, average = PA:HealingMinMax(spell, PA.SpellBook[spell].MaxRank, HealingGearBonus, 0, 1, 0, HealingDebuffFactor);

		-- Check if this is too far
		PA:Debug(spell, " Max=", (spellmax + bonus));

		if (amount > (spellmax + bonus)) then
			PA:Debug(spell, " max heal too low, reverting to ", LastSpell);
			spell = LastSpell;
			break;
		end

		LastSpell = spell;
		PA:Debug(" Spell change : ", spell);
	end

	if (PA:CheckMessageLevel("Heal", 5)) then
		PA:Message4("ReduceForOverHeal Returning "..tostring(spell));
	end
	return spell;
end

----------------------------------------------------------------------------------
-- Check the Mana buffer for what major class of spell we selected
-- This function will lower the family of spells used to Lesser Healing if needed.
-- A buffer of:
-- 0 will check that at least one spell will cast
-- 1 that current + 1 extra of the same will cast
-- 2 that current + 2 extra of the same will cast
-- etc
----------------------------------------------------------------------------------
function PA:ReduceForManaBuffer(spell, healthFraction, mana)
	--PA:Debug("spell=", spell, " healthFraction=", healthFraction, " mana=", mana);
	if (spell=="HOT" or spell=="LESSERHEAL" or healthFraction < PASettings.Heal.LowFlash) then
		--PA:Debug("No reduction required");
		return spell;
	end

	if (healthFraction==nil or healthFraction==false) then
		if (PA:CheckMessageLevel("Heal",5)) then
			PA:Message4("(ReduceForManaBuffer) HealthFraction arg non-numeric");
		end
		return spell;
	end

	local LastSpell = spell;
	--PA:Debug("inSpellBook=", PA:SpellInSpellBook(spell), " rank 1 mana=", PA.SpellBook[spell][1].Mana, " ManaBuffer=",  PASettings.Heal.ManaBuffer);
	while (not PA:SpellInSpellBook(spell) or (mana - PA.SpellBook[spell][1].Mana) <= (PA.SpellBook[spell][1].Mana * PASettings.Heal.ManaBuffer)) do
		if (PA.NextHeal[spell]==nil) then
			spell = LastSpell;
			break;
		end
		spell = PA.NextHeal[spell]
		if (PA:SpellInSpellBook(spell)) then
			LastSpell = spell;
			--PA:Debug(" Spell dropping to: ", spell);
		end
	end
	if (not PA:SpellInSpellBook(spell)) then
		spell = LastSpell;
	end
	return spell;
end

----------------------------------------------------------------------------
-- Healing functions to return spell and type based on family Heal/Flash/HoT
----------------------------------------------------------------------------
function PA:GetHeal()
	--PA:Debug("GetHeal");
	if (PA:SpellInSpellBook("GREATERHEAL")) then
		return "GREATERHEAL";
	end
	if (PA:SpellInSpellBook("HEAL")) then
		return "HEAL";
	end
	return PA.Spells.Default.Heal;
end

-- Druid Flash is a Flash + HoT
function PA:GetFlash(unit)
	--PA:Debug("GetFlash");
	if (PA:SpellInSpellBook("FLASH")) then
		if (PA.PlayerClass=="DRUID") then
			--PA:Debug("PA.HoTBuff2=", PA.HoTBuff2, " has=", PA:UnitHasBlessing(unit, PA.HoTBuff2));
			if (PASettings.Heal.UseHoTs~=false and PASettings.Heal.UseRegrowth~=false and not PA:UnitHasBlessing(unit, PA.HoTBuff2)) then
				return "FLASH";
			end
		else
			return "FLASH";
		end
	end
	return PA:GetHeal();
end

function PA:GetHoT(unit, fast)
	--PA:Debug("GetHoT unit=", unit, " fast=", fast);
	if (PASettings.Heal.UseHoTs~=false and PA:SpellInSpellBook("HOT") and not PA:UnitHasBlessing(unit, PA.HoTBuff)) then
		return "HOT";
	end
	if (fast==true) then
		return PA:GetFlash(unit);
	else
		return PA:GetHeal();
	end
end

------------------------------------------------------------------------------------
-- Determine the healing family to use depending on the target's health and our mana
------------------------------------------------------------------------------------
function PA:GetHealingSpellType(unit, mana, maxMana, healthFraction, ForceMaxHeal, ignoreMana)

	--PA:Debug("unit=", unit, " mana=", mana, " maxMana=", maxMana, " healthFraction=", healthFraction);
	--PA:Debug("ForceMaxHeal=", ForceMaxHeal, " ignoreMana=", ignoreMana, " ForceFlash=", PA.Cycles.Heal.ForceFlash, " ForceHeal=", PA.Cycles.Heal.ForceHeal);
	--PA:Debug("FolTH=", PASettings.Heal.FolTH, " Flash=", PASettings.Heal.Flash, " LowFlash=", PASettings.Heal.LowFlash, " MidHealth=", PASettings.Heal.MidHealth);
	--PALADIN
		-- Check if we need to, or even can use Flash Spells
		-- 1.11	Mana % < Flash Threshold (PASettings.Heal.Folth) use FoL spells
		-- 1.2	Level Self-Check to see if we can even use Flash Spells and have one to start with.
		--
		-- 3.0 	Any 1 of these 4 Conditions will use Flash of Light
		--		1. Not Forcing HL because FOL is not available, and we have the spell, and we need to heal.
		--		2. Mana is less than threshold, and we have the spell, and we need to heal.
		-- 		3. Forcing FOL because health is at or lower than Low Health Threshold. (v3.0)
		--		4. We are forcing the Use of Flash of Light because...
	--DRUID
		-- If healthFraction < FolMin Cast Rejuv(instant/hot), Then regrowth(2.0 heal w/hot), then heal(3.5)
		-- If healthFraction > Fol Cast Rejuv (instant/hot) to cap off
		-- Prefer healing touch for most heals (3.5 cast most mana efficient)
		-- TODO: Druid Bonus Calculations

	--PRIEST
		-- Deciding which class of spell to use is more complex than paladins or druids
		-- Ex: Level 35 Lesser Heal Rank 3 ; 	2.5 sec ;  75 mana ; 143-165 hp
		-- 		Flash  Heal Rank 3 ; 	1.5 sec ; 185 mana ; 337-403 hp
		--              Heal Rank 4 ; 		3.0 sec ; 305 mana ; 721-813 hp
		--
		-- If HOT NOT on target, cast HOT, Else typical logic
		--
		-- TODO? or PANIC MODE: If healthFraction < FolLow & Target has aggro, pws to save target
		-- When 3 or more party members needed at least 300hp healed, cast prayer of healing
					--
		-- Logic will switch from Greater to Heal to Lessor based on Mana and hitpoints needed
		--
		-- Rank1 Spells are learned at
		-- Level  1: LesserHeal,Renew
		-- Level 16: Heal
		-- Level 20: Flash Heal
		-- Level 30: Prayer of Healing (GROUPHEAL)
		-- Level 40: Greater Heal (no more Heal, Basically Level 40+ Greater Heal extends Heal


	if (PASettings.Heal.OOCHealing~=true or UnitAffectingCombat("player") or UnitAffectingCombat(unit)) then
		-- In combat
		PA:Debug("InCombat Healing");

		-- Low Mana check
		if (not ForceMaxHeal and not ignoreMana	and mana/maxMana < PASettings.Heal.FolTH) then
			--PA:Debug("Switching to low mana heal ", mana, " ", maxMana, " ", PASettings.Heal.FolTH);
			if (PA.LowManaType=="HOT") then
				return PA:GetHoT(unit, true);
			else
				return PA:GetFlash(unit);
			end
		end

		-- Max Heal check
		if (ForceMaxHeal==true or PA.Cycles.Heal.ForceHeal==true) then
			return PA:GetHeal();
		end

		-- Flash check
		if (PA.Cycles.Heal.ForceFlash==true) then
			return PA:GetFlash(unit);
		end
		
		return PA:GetHealingSpellTypeForZone(unit, PA:GetZoneFromHealth(healthFraction))

	else
		-- Out of combat
		PA:Debug("Out of Combat Healing");

		-- High Health (use flash if we don't have HoT
		if (healthFraction >= PASettings.Heal.Flash and not PA:SpellInSpellBook("HOT")) then
			return PA:GetFlash();
		end

	end

	return PA:GetHeal();

end

function PA:CheckSpellAvailable(unit, spell)
	if (not PA:GetSpellCooldown(spell, true)) then
		return false;
	end
	if (spell=="FLASH" and PA.PlayerClass=="DRUID") then
		return (PASettings.Heal.UseRegrowth~=false and not PA:UnitHasBlessing(unit, PA.HoTBuff2));
	elseif (spell=="HOT") then
		return (PASettings.Heal.UseHoTs~=false and not PA:UnitHasBlessing(unit, PA.HoTBuff));
	end
	return true;
end

function PA:HealingSpellFromCondition(unit, step)
	PA:Debug("(HealingSpellFromCondition) unit=", unit, " Condition=", step.Condition);
	local Condition = getglobal("PA_HealCondition_"..step.Condition);
	if (Condition~=nil) then
		PA:Debug("(HealingSpellFromCondition) Modifier=", step.Modifier);
		if (PA:SpellInSpellBook(step.Spell) and Condition(unit, step.Modifier) and PA:CheckSpellAvailable(unit, step.Spell)) then
			return step.Spell;
		end
	else
		PA:DisplayText("Unknown Zone Condition:", step.Condition);
	end
	return nil;
end

--------------------------------
-- Zone Step Condition functions
--------------------------------

PA.HealConditions = {
					Always  	={Text="Always",			Modifier="NONE"},
					ManaLow 	={Text="Mana <",			Modifier="%", ModifierTooltip="Enter Low Mana Limit"},
					ManaHigh	={Text="Mana >",			Modifier="%", ModifierTooltip="Enter High Mana Limit"}, 
					InCombat	={Text="In Combat",			Modifier="NONE"},
					OutCombat	={Text="Out of Combat",		Modifier="NONE"},
					IsMT		={Text="Is Main-Tank",      Modifier="NONE"},
					};

function PA_HealCondition_Always(unit, modifier)
	return true;
end

function PA_HealCondition_ManaLow(unit, modifier)
	PA:Debug("PA_HealCondition_ManaLow mana=", UnitMana("player")/UnitManaMax("player"), " mod=", modifier);
	return (UnitMana("player")/UnitManaMax("player") < tonumber(modifier)/100);
end

function PA_HealCondition_ManaHigh(unit, modifier)
	PA:Debug("PA_HealCondition_ManaHigh mana=", UnitMana("player")/UnitManaMax("player"), " mod=", modifier);
	return (UnitMana("player")/UnitManaMax("player") > tonumber(modifier)/100);
end

function PA_HealCondition_InCombat(unit, modifier)
	return (UnitAffectingCombat("player") or UnitAffectingCombat(unit));
end

function PA_HealCondition_OutCombat(unit, modifier)
	return (not PA_HealCondition_InCombat(unit, modifier));
end

function PA_HealCondition_IsMT(unit, modifier)
	if (PA:MainTanksAvailable()) then
		local UName = PA:UnitName(unit);
		if (UName~="target") then
			for _, MTName in pairs(PA:GetMainTanks()) do
				if (UName==MTName) then
					return true
				end
			end
		end
	end
	return false;
end
---------------------------


function PA:GetHealingSpellTypeForZone(unit, zone)
	PA:Debug("GetHealingSpellTypeForZone zone=", zone);

	local Spell;	
	for Index, Step in pairs(PASettings.Heal.ZoneSteps[zone]) do
		PA:Debug(Index, " Spell=", Step.Spell, " Condition=", Step.Condition, " Modifier=", Step.Modifier);
		Spell = PA:HealingSpellFromCondition(unit, Step);
		if (Spell~=nil) then
			break;
		end
	end

	PA:Debug("Spell Chosen=", Spell);
	return Spell;
end

function PA:GetZoneFromHealth(healthFraction)
	PA:Debug("GetZoneFromHealth healthFraction=", healthFraction);
	PA:Debug("MinTH    =", PASettings.Heal.MinTH);
	PA:Debug("Flash    =", PASettings.Heal.Flash);
	PA:Debug("MidHealth=", PASettings.Heal.MidHealth);
	PA:Debug("LowFlash =", PASettings.Heal.LowFlash);
	if (healthFraction >= PASettings.Heal.MinTH) then
		return 5;
	end
	if (healthFraction >= PASettings.Heal.Flash) then
		return 4;
	end
	if (healthFraction >= PASettings.Heal.MidHealth) then
		return 3;
	end
	if (healthFraction >= PASettings.Heal.LowFlash) then
		return 2;
	end
	return 1;
end

---------------------------------------------------------------------------------------------------
-- Call this function from a macro with /paladin bestheal to use the best spell to heal your target
-- Based on amount of health that's missing in ratio of (current health / total health).
-- You can use alt+<macro> to heal yourself
-- This is the core healing function called from autoheal.
---------------------------------------------------------------------------------------------------
function PA:BestHeal(unit, forceSelf, ignoreDistance, forceGroup, moving, skipCheck)

	PA:Debug("BestHeal unit=", unit, " skipCheck=", skipCheck);
	-------------------------------------------------------------------
	-- Set all extra bonus healing to 0 until bonus spells are detected
	-------------------------------------------------------------------
	local spell					= nil;
	local rank					= nil;
	local dfcrit				= 1.0;
	local amount				= 0;
	local FlashBonus			= 0;
	local HealBonus				= 0;
	local hwaybonus				= 0;
	local BuffBonus				= 0;
	local HealingGearBonus		= 0;
	local HealingGearRed 		= 0;
	local HealingDebuffFactor	= 1;
	local RealBonus 			= 0;
	local ForceMaxHeal			= false;
	local IgnoreMana			= false;
	local MinRank				= 1;
	local HealthFraction		= 1;
	local Average				= 0;
	
	if (forceGroup==true and PA:SpellInSpellBook("GROUPHEAL")) then
		PA:Debug("BestHeal Group Heal");
		unit		= "player";
		spell		= "GROUPHEAL";
		forceSelf	= true;
		ignoreDistance	= true;
		rank = PA.SpellBook.GROUPHEAL.MaxRank;
	else

		-------------------------------------------------
		-- Check for, and announce argument in debug mode
		-------------------------------------------------
		if (unit==nil) then
			if (PA:CheckMessageLevel('Core',5)) then
				PA:Message4('PA:BestHeal(unit) was called with unit=nil');
			end
			unit = "player";
		else
			if (PA:CheckMessageLevel('Core',5)) then
				PA:Message4('PA:BestHeal('..unit..') was called');
			end
		end

		---------------
		-- Abort method
		---------------
		if (PA:AbortHealCheck()) then
			return false;
		end

		--------------------
		-- Distance checking
		--------------------
		local MaxRange = 40;
		if (ignoreDistance==true or PASettings.Heal.IgnoreRange==true) then
			MaxRange = nil;
		end

		--------------------------------------
		-- Switch target for heal, if required
		--------------------------------------
		if (forceSelf==true) then
			unit = "player";
		else
			unit = PA:CheckHealTargetTarget(unit);
		end
		PA:Debug("Switched unit=", unit);
		

		---------------------------------------------
		-- Make sure the target could be healed by us
		---------------------------------------------
		if (skipCheck~=true) then
			local TargetOK, _, Status = PA:CheckTarget(unit, false, PA.Spells.Default.Heal, PASettings.Switches.UseActionRange.Heal);
			PA:Debug("PA:CheckTarget=", TargetOK, " Status=", Status);
			if (not TargetOK) then
				return false;
			end
		end

		local current 			= UnitHealth(unit);
		local MaxHealth 		= UnitHealthMax(unit);
		local otherhealing		= PA:OtherHealing(unit);
		PA:Debug(unit,"'s health current=", current, " max=", MaxHealth);

		-----------------------------
		-- Healing bonuses from buffs
		-----------------------------

		if (PA.PlayerClass=="PALADIN") then
			-- Blessing of Light (+greater) on target
			HealBonus, FlashBonus = PA:GetBuffBonus(unit, "bol", "gbol");
			if (HealBonus>0) then
				if (PA:CheckMessageLevel("Heal", 4)) then
					PA:Message4("BOL Bonus HL:"..HealBonus.." FL:"..FlashBonus);
				end
			end
		end

		if (PA.PlayerClass=="SHAMAN") then
			-- Healing way on self (Shaman only)
			hwaybonus = PA:GetBuffBonus("player", "hway") / 100;
			if (hwaybonus>0) then
				if (PA:CheckMessageLevel("Heal", 4)) then
					PA:Message4("(PHM) Healing Way Bonus: "..(hwaybonus * 100).."%");
				end
			end
		end

		-- Amplify Magic on target
		BuffBonus = BuffBonus + PA:GetBuffBonus(unit, "amp");

		-- Healing bonuses from gear
		HealingGearBonus = PA:HealingBonus();

		-- Unstable Power Bonus on self (from activating a trinket)
		HealingGearBonus = HealingGearBonus + PA:GetBuffBonus("player", "usp");

		-- Get penalty due to any debuffs on self/target
		HealingDebuffFactor = PA:HealingPenaltyFactor(unit);

		-- Burning Adrenaline
		if (PA:UnitHasDebuff("player", "Burning")) then
			if (PA:CheckMessageLevel("Heal", 4)) then
				PA:Message4("(PHM) Adjusting for Burning Adrenaline");
			end
			ForceMaxHeal = true;
			IgnoreMana = true;
		end

		-- Reduce +healing if debuffed
		if (HealingDebuffFactor~=1 and HealingDebuffFactor~=0) then
			PA:Debug("Healing DebuffFactor=",HealingDebuffFactor);
			HealingGearRed = HealingGearBonus;
			HealingGearBonus = HealingGearBonus / HealingDebuffFactor;
		end
		
		-- Get health as fraction of maximum
		HealthFraction = current / MaxHealth;

		-- Estimate health if out of group
		current, MaxHealth = PA:GetOutOfGroupHealth(unit, current, MaxHealth, true);

		-- Calculate Base Amount we need to heal, adjusting for other healing
		amount = (MaxHealth - current) - otherhealing;
		
		if (PA:CheckMessageLevel("Heal", 4)) then
			PA:Message4("Target max health : "..( string.format('%.0f', MaxHealth) ));
			PA:Message4("Target current health : "..( string.format('%.0f', current) ));
			PA:Message4("Target health percent : "..( string.format('%.0f', (HealthFraction * 100) ) ).."% ["..PASettings.Heal.Flash.."]");
			PA:Message4("Target CoOp Healing : "..(string.format('%.0f', otherhealing)));
			PA:Message4("Healing amount needed : "..( string.format('%.0f', amount) ));
			PA:Message4("Mana check : "..( string.format('%.0f', 100*(UnitMana("player")/UnitManaMax("player"))) ).."% ["..PASettings.Heal.FolTH.."]");
			if (HealingGearRed == 0) then
				PA:Message4("Gear +Healing : +"..format('%.0f',HealingGearBonus));
			else
				PA:Message4("Gear +Healing : +"..format('%.0f',HealingGearBonus)..", reduced from "..format('%.0f',HealingGearRed));
			end
		end

		-- Check for known overheal condition
		if (amount<=0) then
			if (PASettings.Switches.QuietOnNotRequired~=true) then
				if (PA:CheckMessageLevel("Heal", 1)) then
					PA:Message4(format(PANZA_MSG_HEAL_FULL, PA:UnitName(unit)));
				end
			end
			return false;

		-- Check Minimum Threshold for healing, and don't overheal unless we are healing self.
		elseif ( ((current + otherhealing)/MaxHealth) >= PASettings.Heal.OverHeal and not UnitIsUnit(unit, "player")) then
			if (PASettings.Switches.QuietOnNotRequired~=true) then
				if (PA:CheckMessageLevel("Heal", 1)) then
					PA:Message4(format(PANZA_MSG_HEAL_MTH,PA:UnitName(unit)));
				end
			end
			return false;
		end

		-- otherhealing could be false or nil, if healing someone not in our party/raid (causes exception)
		if (otherHealing==nil or otherHealing==false) then
			if (PA:CheckMessageLevel("Heal", 5)) then
				PA:Message4("(GetHealingSpellType) otherhealing arg is non-numeric setting to 0");
			end
			otherHealing = 0;
		end

		-- Get healing spell
		spell = PA:GetHealingSpellType(unit, UnitMana("player"), UnitManaMax("player"), HealthFraction, ForceMaxHeal, IgnoreMana);
		if (spell==nil) then
			return false;
		end
		--PA:Debug("GetHealingSpellType Spell=", spell);
		-- ManaBuffer
		spell = PA:ReduceForManaBuffer(spell, HealthFraction, UnitMana("player"));
		--PA:Debug("ReduceForManaBuffer Spell=", spell);
		-- OverHeal
		spell = PA:ReduceForOverheal(spell, amount, otherHealing, ForceMaxHeal, HealingDebuffFactor);
		--PA:Debug("ReduceForOverheal Spell=", spell);

		-- Relic bonuses
		local RelicHealBonus, RelicFlashBonus = PA:GetRelicBonus();

		local OldHealingGearBonus = HealingGearBonus;
		-- Factor in any bonuses that depend on spell type (e.g. Paladin BoL)
		if (PA.Spells.HealType[spell]=="FLASH") then
			BuffBonus = BuffBonus + FlashBonus;
			HealingGearBonus = HealingGearBonus + RelicFlashBonus;
		elseif (PA.Spells.HealType[spell]=="HEAL") then
			BuffBonus = BuffBonus + HealBonus;
			HealingGearBonus = HealingGearBonus + RelicHealBonus;
		end
		
		if (PA:CheckMessageLevel("Heal", 4)) then
			if (HealingGearBonus~=OldHealingGearBonus) then
				PA:Message4("Gear +Healing (with relic): +"..format('%.0f',HealingGearBonus));
			end

			if (hwaybonus>0) then
				-- Display HealingWay bonus (shaman hway adds x% to healing wave)
				if (BuffBonus>0) then
					PA:Message4("Buff +Healing : +"..format('%.0f', BuffBonus).." with +"..string.format(hwaybonus*100).."%");
				else
					PA:Message4("Buff +Healing : +"..string.format(hwaybonus*100).."%");
				end
			else
				PA:Message4("Buff +Healing : +"..format('%.0f', BuffBonus));
			end

			if (HealingDebuffFactor~=1) then
				PA:Message4("Healing increase to counter debuffs : "..format('%.0f', (HealingDebuffFactor-1)*100).."%");
			end
		end

		--- Set Minimum Rank to Maximum Rank if ForceMaxHeal
		if (ForceMaxHeal==true) then
			MinRank = PA.SpellBook[spell].MaxRank;
		end

	end
	
	local SpecialUp = false;
	dfcrit, SpecialUp = PA:DFCrit();

	-----------------------------------------------------------------------------------------------------------------------------
	-- Check if we can use our special and cast it
	-- Paladin = Divine Favor, Priests = Inner Focus, Druids = Nature's Swiftness or Omen of Clarity, Shaman = Nature's Swiftness
	-----------------------------------------------------------------------------------------------------------------------------
	PA:Debug("SpecialUp=", SpecialUp, " spell=", spell, " SpellType=", PA.Spells.HealType[spell], " UseDFAll=", PASettings.Heal.UseDFAll, " UseDF=", PASettings.Heal.UseDF, " dfcrit=", dfcrit);
	if (not SpecialUp
		and PASettings.Heal.UseDFAll==true and (PASettings.Heal.UseDFOOC==true or UnitAffectingCombat("player"))
		and (PA.Spells.HealType[spell]=="HEAL" or PA.Spells.HealType[spell]=="GROUPHEAL" or PASettings.Heal.UseDF~=true)) then
		local NotOnCooldown = PA:GetSpellCooldown("HEALSPECIAL");
		PA:Debug("Heal Special Cooldown=", NotOnCooldown);
		if (NotOnCooldown==true) then
			local CastSpecial;
			PA:Debug("forceGroup=", forceGroup, " MinCritRank=", PASettings.Heal.MinCritRank);
			if (forceGroup~=true and PASettings.Heal.MinCritRank>0) then
				local ExtraMana = 0;
				-- Only Paladin class has ranks for Special - Divine Favor, all other specials do not have ranks
				if (PA.PlayerClass=="PALADIN") then
					ExtraMana = PA.SpellBook.HEALSPECIAL[PA.SpellBook.HEALSPECIAL.MaxRank].Mana;
				else
					ExtraMana = PA.SpellBook.HEALSPECIAL.Mana;
				end
				local rank = PA:ProcessHeal(spell, amount, HealingGearBonus, BuffBonus, 1.0, ExtraMana, MinRank, hwaybonus, HealingDebuffFactor);
				PA:Debug("Rank=", rank, " MinCritRank=", PASettings.Heal.MinCritRank);
				CastSpecial = (rank>=PASettings.Heal.MinCritRank);
			else
				CastSpecial = true;
			end

			PA:Debug("CastSpecial=", CastSpecial);
			if (CastSpecial) then
				if (PA.PlayerClass=="DRUID" and string.find(PA.SpellBook.HEALSPECIAL.Name,"Omen")) then
					-- Need to only Check For ClearCasting, not cast Omen!
				elseif (PA.PlayerClass=="PRIEST" and PA:SpellInSpellBook("GREATERHEAL") and not (spell=="GREATERHEAL" or spell=="GROUPHEAL" or PASettings.Heal.UseDF~=true)) then
					-- Dont use Inner Focus on Heal, Only Greater Heal if we have it
				else
					PA:Debug("Casting Heal Special ", PA.SpellBook.HEALSPECIAL.Name, " rank=", PA.SpellBook.HEALSPECIAL.MaxRank);
					if (PA:CastSpell(PA:CombineSpell(PA.SpellBook.HEALSPECIAL.Name, PA.SpellBook.HEALSPECIAL.MaxRank), unit)) then
						SpellStopCasting();
						SpellStopCasting();
						SpellStopCasting();
						if (PA.PlayerClass=="PALADIN") then
							dfcrit = 1.5; -- Gauranteed crit
						elseif (PA.PlayerClass == "PRIEST") then
							dfcrit = 1.0;  -- there is a 25% increased chance to crit. need to get crit chance and calc better
						else
							dfcrit = 1.0;
						end
					end
				end
			end
		end
	end

	return PA:HealGivenSpell(unit, spell, amount, HealingGearBonus, BuffBonus, dfcrit, MinRank, hwaybonus, rank, RealBonus, Average, HealingDebuffFactor)
end

-- We know the type of spell, now get the rank
function PA:HealGivenSpell(unit, spell, amount, healingGearBonus, buffBonus, dfcrit, minRank, hwaybonus, rank, realBonus, average, HealingDebuffFactor)

	PA:Debug("HealGivenSpell spell=", spell, " rank=", rank, " dfcrit=", dfcrit);

	if (rank==nil) then
		rank, realBonus, average = PA:ProcessHeal(spell, amount, healingGearBonus, buffBonus, dfcrit, 0, minRank, hwaybonus, HealingDebuffFactor);
	end

	--------------------------------------------------------
	-- Some healing spells (HOTs) are level based like buffs
	--------------------------------------------------------
	if (rank~=nil and PA:GetSpellProperty(spell, "LevelBased")==true) then
		if (PA:CheckMessageLevel("Heal", 4)) then
			PA:Message4("Calculating Max Rank for "..PA.SpellBook[spell].Name.." spells on a level "..UnitLevel(unit).." "..UnitClass(unit)..".");
		end
		local MaxRank = PA:ProcessRankedHeal(spell, PA.Spells.Levels[spell], UnitLevel("player"), UnitLevel(unit));
		if (MaxRank~=nil) then
			if (PA:CheckMessageLevel("Heal", 4)) then
				PA:Message4("Maximum Rank that can be used: "..MaxRank);
			end
			if (rank>MaxRank) then
				rank = MaxRank;
			end
		end
	end

	-- Reset flags
	PA.Cycles.Heal.ForceFlash = false;
	PA.Cycles.Heal.ForceHeal = false;

	-----------------------------------------------
	-- Cast Heal if it is valid and not on cooldown
	-----------------------------------------------
	if (spell~=nil and rank~=nil) then
		if (PA:GetSpellCooldown(spell)) then
			if (PA:CheckHealingTrinket(PA.Spells.HealType[spell], dfcrit)) then
				if (PA:ActivateTrinket(PASettings.Heal.Trinket.Name)) then
					-- Recalculate rank due to trinket bonus
					local TrinketBonus = PANZA_TRINKET_BONUS[PASettings.Heal.Trinket.Name];
					--PA:Debug("PANZA_TRINKET_BONUS[", PASettings.Heal.Trinket.Name, "]=", PANZA_TRINKET_BONUS[PASettings.Heal.Trinket.Name]);
					if (TrinketBonus~=nil) then
						--PA:Debug("TrinketBonus: Rank=", rank, " Gear=", TrinketBonus.Gear, " Buff=", TrinketBonus.Buff);
						healingGearBonus = healingGearBonus + TrinketBonus.Gear;
						buffBonus = buffBonus + TrinketBonus.Buff;
						rank, realBonus, average = PA:ProcessHeal(spell, amount, healingGearBonus, buffBonus, dfcrit, 0, minRank, hwaybonus, HealingDebuffFactor);
						--PA:Debug("TrinketBonus: Rank=", rank);
					end
				end
			end
			PA.Cycles.Heal.Bonus				= realBonus;	-- Set Total Healing Bonus
			PA.Cycles.Heal.Average				= average;		-- Set average healing
			PA.Cycles.Heal.HealingGearBonus		= healingGearBonus;
			PA.Cycles.Heal.BuffBonus			= buffBonus;
			PA.Cycles.Heal.HwayBonus			= hwaybonus;
			PA.Cycles.Heal.Amount				= amount;
			PA.Cycles.Spell["Type"] 			= "Heal";
			PA.Cycles.Spell["Active"]			= {spell=PA.SpellBook[spell].Name, rank=rank, target=unit, defclass="blank"};
			return PA:CastSpell(PA:CombineSpell(PA.SpellBook[spell].Name, rank), unit);
		end
	end
	return false;
end

-- Get list of current Main Tanks and MainTanks' Target's Targets
-- Exclude self from Main Tanks
-- Exclude MainTanks from Target's Targets
function PA:GetMainTankTargetTargets()
	PA.MT = {};
	PA.MTTT = {};
	-- Get Main Tanks and Main Tanks' Target's Targets
	local MainTanks = PA:GetMainTanks();
	--PA:Debug("GetMainTankTargetTargets ", getn(MainTanks));
	if (getn(MainTanks)>0) then

		local NumberToCheck = 0;
		local Unitbase;
		if (PA:IsInRaid()) then
			NumberToCheck = PANZA_MAX_RAID; -- Includes self
			UnitBase = "raid";
		elseif (PA:IsInParty()) then
			NumberToCheck = PANZA_MAX_PARTY - 1; -- Excludes self
			UnitBase = "party";
		end

		for Index = 1, NumberToCheck do
			local Unit = UnitBase..Index;
			local UName = PA:UnitName(Unit);
			if (UName~="target") then
				for Index, MTName in pairs(MainTanks) do
					if (UName==MTName) then
						local TUnit = Unit.."target";
						local TName = PA:UnitName(TUnit);
						PA.MT[MTName] = {Unit=Unit, Target=TName, TUnit=TUnit};
						--PA:Debug(" PA.MT[", MTName, "]=", Unit, " ", TName, " ", TUnit);
						if (TName~="target") then
							local TTUnit = TUnit.."target";
							local TTName = PA:UnitName(TTUnit);
							if (TTName~="target") then
								PA.MTTT[TName] = {Unit=TTUnit, Name=TTName, Target=TUnit};
								--PA:Debug(" PA.MTTT[", TName, "]=", TTUnit, " ", TTName, " ", TUnit);
							end
						end
					end
				end
			end
		end

		-- Remove Main Tanks from target target list
		for MTName, MTUnit in pairs(PA.MT) do
			for MobName, TTInfo in pairs(PA.MTTT) do
				if (TTInfo.Name==MTName) then
					PA.MTTT[MobName] = nil;
				end
			end
		end

	end

	-- Add Our Target's Target
	local TUnit = "playertarget";
	local TName = PA:UnitName(TUnit);
	if (TName~="target") then
		local TTUnit = TUnit.."target";
		local TTName = PA:UnitName(TTUnit);
		if (TTName~="target") then
			PA.MTTT[TName] = {Unit=TTUnit, Name=TTName, Target=TUnit};
			--PA:Debug(" PA.MTTT[", TName, "]=", TTUnit, " ", TTName, " ", TUnit);
		end
	end

end

function PA:PartyHealCheck(checkActionRange)
	PA:Debug("PartyHealCheck GroupLimit=", PASettings.Heal.GroupLimit, " has spell=",PA:SpellInSpellBook("GROUPHEAL"), " inparty=", PA:IsInParty());
	if (PASettings.Heal.GroupLimit==0 or not PA:SpellInSpellBook("GROUPHEAL") or not PA:IsInParty()) then
		return false;
	end
	-- Temporarily turn off target update code, for speed
	local PA_TargetFrame_Update = TargetFrame_Update;
	TargetFrame_Update = PA_DummyTargetFrame_Update;

	local Status, Return = pcall(PA_PartyHealCheck_Safe, checkActionRange);

	-- Restore target update code
	TargetFrame_Update = PA_TargetFrame_Update;
	PA_TargetFrame_Update = nil;

	if (not Status) then
		PA:ShowText(PA_RED.."Error in target protected call: ", Return);
		return false;
	end
	
	return Return;
end

function PA_PartyHealCheck_Safe(checkActionRange)
	if unexpected_condition then error() end
	local InBG = PA:IsInBG();
	local Count = 0;
	if (UnitHealth("player") / UnitHealthMax("player")<PASettings.Heal.Flash) then
		Count = Count + 1; -- Self
	end
	local InCombat = PA.InCombat;
	if (PA:CheckMessageLevel("Heal", 5)) then
		PA:Message4("Combat ="..tostring(InCombat));
	end

	-- In-Range/Line of Sight check must not have a friendly target
	local Retarget = false;
	if (PA:UnitIsMyFriend("target")) then
		Retarget = true;
		ClearTarget();
	end
	if (SpellIsTargeting()) then
		SpellStopTargeting();
	end

	for Index = 1, PANZA_MAX_PARTY - 1 do
		local Unit = "party"..Index;
		if (UnitExists(Unit)) then
			if (UnitHealth(Unit) / UnitHealthMax(Unit)<PASettings.Heal.Flash) then
				local ShortSpell = "GROUPHEAL";
				-- Cast check spell if not already one casting
				--PA:ShowText("  Spell=", ShortSpell, " Rank=", PA.SpellBook[ShortSpell].MinRank);
				local SpellTargeting = SpellIsTargeting();
				if (not SpellTargeting) then
					local SpellToCast = PA:CombineSpell(PA.SpellBook[ShortSpell].Name, PA.SpellBook[ShortSpell].MinRank);
					--PA:ShowText("  SpellToCast=", SpellToCast);
					CastSpellByName(SpellToCast);
					SpellTargeting = SpellIsTargeting();
				end
				-- Spell cast for targeting, now check if it will cast
				if (SpellTargeting) then
					if (SpellCanTargetUnit(value.Unit)) then
						--PA:ShowText("  SpellCanTargetUnit: Can!");
						Count =  Count + 1;
					else
						value.InRange = false;
						--PA:ShowText("  SpellCanTargetUnit: Can't");
					end
				end
			end
		end
	end
	if (Retarget==true) then
		TargetLastTarget();
	end

	if (PA:CheckMessageLevel("Heal", 2)) then
		PA:Message4("Party Heal: "..Count.." Party Members of "..PASettings.Heal.GroupLimit.." required");
	end
	return (Count>=PASettings.Heal.GroupLimit);
end

function PA:AbortHealCheck()

	if (PA:WandCheck()) then
		return false;
	end

	if (PA.Cycles.Spell.Abort==true) then
		if (PA:CheckMessageLevel('Heal', 1)) then
			PA:Message4('Aborting heal on '..PA:UnitName(PA.Cycles.Spell.Active.target));
		end
		PanzaFrame_HealCurrent:Hide();
		PA.Cycles.Spell.Type = "blank";
		PA.Cycles.Spell.Active.target = "blank";
		PA.Cycles.Spell.Abort = false;
		SpellStopCasting();
		return true;
	end
	return false;
end

-----------------------------
-- Heal group members in turn
-----------------------------
function PA:AutoHeal(messageOnNone, ignoreRange, forceGroup, forceClear)

	if (PA:AbortHealCheck()) then
		return false;
	end
	
	if (PASettings.Switches.PanicOnHeal==true and PA:Panic(false)) then
		return true;
	end

	if (forceGroup==true and PA:SpellInSpellBook("GROUPHEAL")) then
		return PA:BestHeal("player", true, true, true);
	end

	local CheckDistance = (not ignoreRange==true and PASettings.Heal.IgnoreRange==false);

	-- Party HealCheck
	if (PA:PartyHealCheck(CheckDistance))	then
		return PA:BestHeal("player", true, true, true);
	end

	PA.LowestPlayerHealth = 1.0;

	if (forceClear==true) then
		if (PA:CheckMessageLevel("Heal", 3)) then
			PA:Message4("Clearing Failed List.");
		end
		PA.Cycles.Group.Fail = {};
		PA:CleanupSpells();
	end

	local Success, Unit = PA:AutoGroup({Weighting=PA_HealWeighting, Cast=PA_CastHeal}, PASettings.Switches.MsgLevel["Heal"], "Heal", true, "Heal");
	if (Success==true) then
		return true, Unit;
	end

	-- If we get here no heals have been attempted
	if (messageOnNone==true and PASettings.Switches.QuietOnNotRequired~=true) then
		if (PA:CheckMessageLevel('Heal', 1)) then
			PA:Message4(PANZA_MSG_HEAL_NO);
		end
	end
	return false;

end

function PA_CastHeal(unitInfo)
	--PA:ShowText("CastHeal on ", unitInfo.Unit);
	return (PA:BestHeal(unitInfo.Unit, false, true, false, false, true));
end

function PA:GetHealCureBias(inParty, owningUnitName, isSelf, Name, class)
	local Bias = 0;
	if (inParty) then
		PA:Debug("Party Bias=", PASettings.Heal.PartyBias);
		Bias = Bias + PASettings.Heal.PartyBias;
	end
	if (owningUnitName==nil) then
		if (isSelf==true) then
			PA:Debug("Self Bias=", PASettings.Heal.SelfBias);
			Bias = Bias + PASettings.Heal.SelfBias;
		else
			PA:Debug(class, " Bias=", PASettings.PHMBiasWeight[class]);
			Bias = Bias + PASettings.PHMBiasWeight[class];
		end
		PA:Debug(" PA.MT[", Name, "]=", PA.MT[Name]);
		if (PA.MT[Name]~=nil) then
			-- Unit is a Main Tank
			PA:Debug("MT Bias=", PASettings.Heal.MainTankBias);
			Bias = Bias + PASettings.Heal.MainTankBias;
			if (PA:CheckMessageLevel("Heal", 4)) then
				PA:Message4("Main Tank Bias of "..PASettings.Heal.MainTankBias.." applied");
			end
		else
			PA:Debug(" Checking if this unit is being munched");
			for MobName, TTInfo in pairs(PA.MTTT) do
				PA:Debug(" Mob=", MobName, " Name=", TTInfo.Name);
				if (Name==TTInfo.Name) then
					-- Main Tank's target has this unit targetted
					PA:Debug(MobName, " MTTT Bias=", PASettings.Heal.MTTTBias);
					Bias = Bias + PASettings.Heal.MTTTBias; -- These should accumulate
					if (PA:CheckMessageLevel("Heal", 4)) then
						PA:Message4("Main Tank Target's Target Bias of "..PASettings.Heal.MTTTBias.." applied");
					end
				end
			end
		end
	end
	return Bias;
end

-----------------------------------------------------------------
-- Determine if group member needs healing and assign a weighting
-----------------------------------------------------------------
function PA_HealWeighting(info)

	local OtherHealing = PA:OtherHealing(info.Unit); -- Get Coop healing from Others
	local NormalizedHealth = (UnitHealth(info.Unit) + OtherHealing) / UnitHealthMax(info.Unit);
	PA:Debug(" NormalizedHealth=", NormalizedHealth);
	if (NormalizedHealth>=PASettings.Heal.MinTH) then
		return false;
	end

	if (info.Owner==nil and NormalizedHealth<PA.LowestPlayerHealth) then
		PA.LowestPlayerHealth = NormalizedHealth;
	end
	info.Health = NormalizedHealth;
	info.Affected = NormalizedHealth;
	return true;
end

-----------------------------------------------------------------------------
-- Return amount of healing outstanding for unit
-- Note during casting of Heal Spells, this function may be called frequently
-----------------------------------------------------------------------------
function PA:OtherHealing(unit)
	local healing, thishealer = 0, 0;
	local healer, healerdata, healtype, healtypedata = nil,nil,nil,nil;

	--if (PA:CheckMessageLevel("Core",5)) then
		--PA:Message4("PA:OtherHealing(uint) unit="..unit);
	--end

	if (PASettings.Heal.Coop.enabled~=true) then return healing; end

	local who = PA:UnitName(unit);
	if (who~="target") then

		--if (PA:CheckMessageLevel("Core",5)) then
			--PA:Message4("PA:OtherHealing() Looking for PA.Healing["..who.."]");
		--end

		if (PA.Healing[who]) then
			for healer, healerdata in pairs(PA.Healing[who]) do
				thishealer=0;
				for healtype, healtypedata in pairs(PA.Healing[who][healer]) do
					if (healer~=PA.PlayerName and PA.Healing[who][healer][healtype]["Status"] == "Active"
						and PA.Healing[who][healer][healtype]["TimeLeft"] > 0) then
						healing = healing + PA.Healing[who][healer][healtype]["Heal"];
						healing = healing + PA.Healing[who][healer][healtype]["HoT"];
						thishealer = PA.Healing[who][healer][healtype]["Heal"];
						thishealer = thishealer + PA.Healing[who][healer][healtype]["HoT"];

					-- Consider our own HOT spells.
					elseif (healer==PA.PlayerName and PA.Healing[who][healer][healtype]["Status"] == "Active"
						and PA.Healing[who][healer][healtype]["TimeLeft"] > 0) then
						healing = healing + PA.Healing[who][healer][healtype]["HoT"] ;
						thishealer = PA.Healing[who][healer][healtype]["HoT"];
					end
					if (thishealer > 0) then
						if (PA:CheckMessageLevel("Coop",5)) then
							PA:Message4("(CoOp) Considering "..string.format('%0.f',thishealer).." healing from "..healer);
						end
					end
				end
			end
		end
		if (healing > 0) then
			if (PA:CheckMessageLevel("Coop",5)) then
				PA:Message4("(CoOp) Considering "..string.format('%0.f',healing).." other healing on "..who);
			end
		end
	end
	return healing;
end

-----------------------------------------------
-- Update the current Healing Spell Status Bars
-----------------------------------------------
function PA:UpdateCurrentHealBar(who, remove)

	if (PanzaFrame_HealCurrent==nil) then
		return;
	end
	local me = PA.PlayerName;
	local otherheals, current, MaxHealth, aftertotal, target, targetheal = 0, 0, 0, 0, 1, 0;

	if (PASettings.Heal.Bars.OwnBars==false) then return;end

	if (not remove) then remove=false; end

	if (remove == false) then
		if (PA.Healing[who]~=nil and PA.Healing[who][me]~=nil  and PA.Healing[who][me]["HEAL"]~=nil and PA.Healing[who][me]["HEAL"].TimeLeft > 0) then

			otherheals	= PA:OtherHealing(PA.Cycles.Spell.Active.target);
			current		= UnitHealth(PA.Cycles.Spell.Active.target);
			MaxHealth	= UnitHealthMax(PA.Cycles.Spell.Active.target);
			target		= UnitLevel(PA.Cycles.Spell.Active.target);

			-- Estimate health if out of group
			current, MaxHealth = PA:GetOutOfGroupHealth(unit, current, MaxHealth, false);

			-- Include our current heal (otherhealing does not include this, only Hot)
			targetheal = PA.Healing[who][me]["HEAL"].Heal;

			-- calculate (best guess) targets health after this hits.
			aftertotal = math.floor(current + otherheals + targetheal);

			PanzaFrame_HealCurrentSpellText:SetText(PA.Healing[who][me]["HEAL"].Spell .. " " .. PA.Cycles.Spell.Active.rank .. " - " .. string.format('%.0f',PA.Healing[who][me]["HEAL"].Heal));
			PanzaFrame_HealCurrentSpell:SetMinMaxValues(0, PA.Healing[who][me]["HEAL"].CastTime);
			PanzaFrame_HealCurrentSpell:SetValue(PA.Healing[who][me]["HEAL"].TimeLeft);

			PanzaFrame_HealCurrentTargetText:SetText(PA:UnitName(PA.Cycles.Spell.Active.target) .. " (" .. current .."/"..MaxHealth.." " ..math.floor(((current/MaxHealth) * 100)).."% ) ");
			PanzaFrame_HealCurrentTarget:SetMinMaxValues(0, MaxHealth);
			PanzaFrame_HealCurrentTarget:SetValue(current);

			PanzaFrame_HealCurrentAfter:SetMinMaxValues(0, aftertotal * 1.50);
			PanzaFrame_HealCurrentAfterText:SetText(aftertotal .. " (" .. math.floor(((aftertotal/MaxHealth)*100)) .."%)");
			PanzaFrame_HealCurrentAfter:SetValue(aftertotal);

			PanzaFrame_HealCurrent:SetAlpha(1.0);
			PanzaFrame_HealCurrent:Show();
		else
			PanzaFrame_HealCurrent:Hide();
		end

	elseif (remove == true) then
		PanzaFrame_HealCurrent:Hide();
	end
end

-- Periodically called to administer Co-op healing
------------------------------------------------------------------
-- Cooperative Healing Support
-- Update all healing spells elapsed time and update remaining HOT
------------------------------------------------------------------
function PA:CoopHealing()
	local who, whodata, author, authordata, me, timeleft, healtype, typedata, bar = nil, nil, nil, nil, PA.PlayerName, 0, nil, nil, nil;

	for who, whodata in pairs(PA.Healing) do
		for author, authordata in pairs(PA.Healing[who]) do
			for healtype, typedata in pairs(PA.Healing[who][author]) do
				if (PA.Healing[who][author][healtype].Status=="Active") then
					-- Get the status bar if it exists
					if (PA.Healing[who][author][healtype]["Bar"]) then
						bar = getglobal("PanzaFrame_HealBars" .. PA.Healing[who][author][healtype]["Bar"]);
					end

					-- Update the time left on the spell
					timeleft = PA.Healing[who][author][healtype].TimeLeft - PA.Cycles.Spell.CoopTimer;

					-- Update the spell entry if it's still active and will be on next update.
					if (timeleft > 0.25) then
						PA.Healing[who][author][healtype].TimeLeft = timeleft;

						-- Update remaining Hot (Update once per Tick (~3 seconds))
						-- This will give a good estimate to track how much more healing
						-- on top of HOT is required.
						if (healtype=="HOT" and PA.Healing[who][author]["HOT"].HoT > 1 and (PA.Cycles.Spell.HoTimer >= 3)) then
							local remaininghot = ((PA.Healing[who][author][healtype].Heal * (timeleft/3)) -  PA.Healing[who][author][healtype].Heal);
							if (remaininghot >0) then
								PA.Healing[who][author][healtype].HoT = remaininghot;
								if (PA:CheckMessageLevel("Coop",4)) then
									PA:Message4("(CoOp) HoT ("..PA.Healing[who][author][healtype].Spell..") on "..who.." by "..author..": "..(string.format('%.0f', remaininghot)));
								end
							end
							PA.Cycles.Spell.HoTimer = 0;
						end

						-- Get first unused bar. Only create windows for other players heal spells, hot spells, and own hot spells.
						if (not bar and PASettings.Heal.Bars.OtherBars==true and ((healtype=="HOT" or (healtype=="HEAL" and author~=PA.PlayerName)))) then
							for i = 1, 20 do
								bar = getglobal("PanzaFrame_HealBars" .. i);
								local bartext = getglobal(bar:GetName() .. "Text"):GetText();
								local _, _, barauthor, bartype, _, barwho = string.find(bartext, PANZA_MATCH_BAR);
								if (bartype=="(") then
									bartype = "HEAL";
								else
									bartype = "HOT";
								end

								local Overwrite = (barauthor==author and bartype==healtype and barwho==who);
								--PA:ShowText("Overwrite=", Overwrite, " bar author=", barauthor, " target=", barwho, " type=", bartype);

								if (bar:GetMinMaxValues() == 666 or Overwrite) then
									PA.Healing[who][author][healtype]["Bar"] = i;

									if (healtype=="HEAL") then
										bar:SetMinMaxValues(0, PA.Healing[who][author][healtype]["CastTime"]);
										bar:SetValue(timeleft);
										getglobal(bar:GetName() .. "Text"):SetText(author .. " (" .. string.format('%.0f',PA.Healing[who][author][healtype]["Heal"]) .. ") -> " .. who);

									elseif (healtype=="HOT") then
										bar:SetMinMaxValues(0, PA.Healing[who][author][healtype]["TimeLeft"]);
										bar:SetValue(timeleft);
										getglobal(bar:GetName() .. "Text"):SetText(author .. " [" .. string.format('%.0f', PA.Healing[who][author][healtype]["HoT"]) .. "] -> " .. who);
									end

									getglobal(bar:GetName() .. "BarTexture"):SetVertexColor(1.0, 0.7, 0.0, 0.5);
									bar:SetAlpha(1.0);
									bar:Show();
									i = 20;
									PA.Cycles.Spell.BarsCheckTimer = 0;
								end
							end

						-- Update Existing Bar
						elseif (bar and ((healtype=="HOT" or (healtype=="HEAL" and author~=PA.PlayerName)))) then
							bar:SetValue(PA.Healing[who][author][healtype]["TimeLeft"]);
							if (healtype=="HOT") then
								local TextFrame = getglobal(bar:GetName() .. "Text");
								if (TextFrame~=nil) then
									TextFrame:SetText(author .. " (" .. string.format('%.0f', PA.Healing[who][author][healtype]["HoT"]) .. ") -> " .. who);
								end
							end
						end

					-- Remove completed/failed/interrupted spells and bars.
					else
						if (PA:CheckMessageLevel("Coop",3)) then
							PA:Message4("(CoOp) Removed "..healtype.." Spell for "..who.." by "..author);
						end
						if (PA.Healing[who][author][healtype]["Bar"]) then
							bar = getglobal("PanzaFrame_HealBars" .. PA.Healing[who][author][healtype]["Bar"]);
							if (bar) then
								bar:SetMinMaxValues(666, 1337);
								bar:Hide();
							end
						end
						PA.Cycles.Spell.HoTimer = 0;
						PA.Healing[who][author][healtype] = nil;
					end
				-- Remove spells not marked Active
				else
					if (PA:CheckMessageLevel("Coop",3)) then
						PA:Message4("(CoOp) Removed "..healtype.." Spell for "..who.." by "..author);
					end
					if (PA.Healing[who][author][healtype]["Bar"]~=nil) then
						bar = getglobal("PanzaFrame_HealBars" .. PA.Healing[who][author][healtype]["Bar"]);
						if (bar~=nil) then
							bar:SetMinMaxValues(666, 1337);
							bar:Hide();
						end
					end
					PA.Cycles.Spell.HoTimer = 0;
					PA.Healing[who][author][healtype] = nil;
				end
			end
		end
	end

	-- Update Current Heal Indicator Bars
	if (PA.Cycles.Spell.Type == "Heal" and PA.Cycles.Spell.Active.target) then
		PA:UpdateCurrentHealBar(PA:UnitName(PA.Cycles.Spell.Active.target), false);
	end

end

---------------------------------------------------------------------
-- Check for stuck bars and remove them.
-- Extract the author and target from the bar and check PA.Healing
---------------------------------------------------------------------
function PA:ResetHealingBars()
	--PA:ShowText("ResetHealingBars");
	local i;
	for i=1, 20 do
		local bar = getglobal("PanzaFrame_HealBars" .. i);
		if (bar~=nil and bar:GetMinMaxValues() ~= 666) then
			local bartext = getglobal(bar:GetName() .. "Text"):GetText();
			--PA:ShowText(i, " ", bartext);
			if (bartext~=nil) then
				local _, _, barauthor, _, _, barwho = string.find(bartext, PANZA_MATCH_BAR);
				--PA:ShowText(" bar author=", barauthor, " target=", barwho);
				if (barauthor~=nil and barwho~=nil) then
					--PA:ShowText(" who=", PA.Healing[barwho], " author=", PA.Healing[barwho][barauthor], " HEAL=", PA.Healing[barwho][barauthor]["HEAL"], " HOT=", PA.Healing[barwho][barauthor]["HOT"]);
					if (PA.Healing[barwho]==nil) then
						if (PA:CheckMessageLevel("Coop",5)) then
							PA:Message4("(CoOp) Removing bar for "..barwho);
						end
						bar:SetMinMaxValues(666, 1337);
						bar:Hide();
					elseif (PA.Healing[barwho][barauthor]==nil or (PA.Healing[barwho][barauthor].HEAL==nil and PA.Healing[barwho][barauthor].HOT==nil)) then
						if (PA:CheckMessageLevel("Coop",5)) then
							PA:Message4("(CoOp) Removing bar for "..barwho.." by "..barauthor..".");
						end
						bar:SetMinMaxValues(666, 1337);
						bar:Hide();
					elseif (PA.Healing[barwho][barauthor]["HEAL"]~=nil) then
						if (PA.Healing[barwho][barauthor]["HEAL"].Status~="Active" or (PA.Healing[barwho][barauthor]["HEAL"].Spell==nil or PA.Healing[barwho][barauthor]["HEAL"].TimeLeft <= 0.29)) then
							if (PA:CheckMessageLevel("Coop",5)) then
								PA:Message4("(CoOp) Removing bar for "..barwho.." by "..barauthor..".");
							end
							bar:SetMinMaxValues(666, 1337);
							bar:Hide();
						end
					elseif (PA.Healing[barwho][barauthor]["HOT"]~=nil) then
						if (PA.Healing[barwho][barauthor]["HOT"].Status~="Active" or (PA.Healing[barwho][barauthor]["HOT"].Spell==nil or PA.Healing[barwho][barauthor]["HOT"].TimeLeft <= 0.29)) then
							if (PA:CheckMessageLevel("Coop",5)) then
								PA:Message4("(CoOp) Removing bar for "..barwho.." by "..barauthor..".");
							end
							bar:SetMinMaxValues(666, 1337);
							bar:Hide();
						end
					end
				end
			end
		end
	end
end

