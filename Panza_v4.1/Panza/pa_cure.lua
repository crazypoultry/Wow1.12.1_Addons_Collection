--[[

pa_cure.lua
Panza Cure Functions
Revision 4.0

10-01-06 "for in pairs()" completed for BC
--]]

--------------------------------------------------------------------------
-- Find out if unit has any abolish buffs and return a list of those found
--------------------------------------------------------------------------
function GetAbolishList(unit)
	local AbolishList = {};
	local index = 1;
	local Buff = UnitBuff(unit, index);
	while (Buff~=nil) do
		--PA:ShowText("Buff=", Buff);
		if (string.find(Buff, PA.buffKeys.adis.."$")) then
			AbolishList.Disease = index;
		elseif (string.find(Buff, PA.buffKeys.apoi.."$")) then
			AbolishList.Poison = index;
		elseif (string.find(Buff, PA.buffKeys.amag.."$")) then
			AbolishList.Magic = index;
		end
		index = index + 1;
		Buff = UnitBuff(unit, index);
	end
	return AbolishList;
end

------------------------------------------------------------------------------------------------------------------------
-- Return what debuffs unit has
-- Observations in 1.11 client show that non-stackable debuffs return 0 for count, and stackable buffs return 1 or more
-- This could be a bug, or intended. We set the debuff count to 1 if it is 0.
------------------------------------------------------------------------------------------------------------------------
function PA:GetUnitDebuff(unit, debuff)

	local Factor = 1.0;
	local Index = 1;

	if (PA:CheckMessageLevel("Core", 5)) then
		PA:Message4("PA:GetUnitDebuff("..unit..") called.");
	end
	PA:Debug("PA:GetUnitDebuff(", unit, ", ", debuff, ") called.");

	PA:ResetTooltip()
	local Texture, Count, Type = UnitDebuff(unit, Index);
	-- if the target has an abolish buff then do not cure this
	local Abolish = GetAbolishList(unit);

	while (Texture~=nil) do

		-- Detect good debuffs and do not dispell them
		local TextureShort = PA:ExtractTextureName(Texture);
		PA:Debug("(GetUnitDebuff) Texture=", Texture, " TextureShort=", TextureShort);
		if (PA.GoodDebuffs[TextureShort]~=nil) then
			PanzaTooltipTextLeft1:SetText(nil);
			PanzaTooltip:SetUnitDebuff(unit, Index);
			local Left1 = PanzaTooltipTextLeft1:GetText();
			PA:Debug("(GetUnitDebuff) Match=", PA.GoodDebuffs[TextureShort], " Left1=", Left1);
			if (Left1~=nil and string.find(string.lower(Left1), PA.GoodDebuffs[TextureShort])) then
				if (PA:CheckMessageLevel("Cure", 3)) then
					PA:Message4(format(PANZA_GOODDEBUFF, Left1));
				end
				return 1.0;
			end
		end
		PA:Debug("(GetUnitDebuff) DebuffType=", Type);
		if (Type~=nil and Abolish[Type]==nil) then
			PA:Debug("(GetUnitDebuff) DeBuff ", Index, "=", Type);
			if (PA:CheckMessageLevel("Cure", 5)) then
				PA:Message4("DeBuff "..Index.."="..Type);
			end
			PA:Debug("(GetUnitDebuff) CurePriority="..PASettings.CurePriority[Type], "  debuff[Type]=", debuff[Type]);

			if (PASettings.CurePriority[Type]~=nil and PASettings.CurePriority[Type]>0 and debuff[Type]==true) then
				PA:Debug("(GetUnitDebuff) Debuff Texture ", Debuff, " Texture count=", Count);
				if (PA:CheckMessageLevel("Core",5)) then
					PA:Message4("(Cure) Debuff Texture ", Debuff, " Texture count=", Count);
				end
				if (Count==nil or Count==0) then
					Count = 1;
				end
				Factor = Factor * PASettings.CurePriority[Type]^Count;
				PA:Debug("(GetUnitDebuff) Priority for ", Count, " ", Type, " = ", PASettings.CurePriority[Type], " : Factor = ", Factor);
				if (PA:CheckMessageLevel("Cure", 3)) then
					PA:Message4("Priority for "..Count.." "..Type.." = "..PASettings.CurePriority[Type].." : Factor = "..Factor);
				end
			else
				PA:Debug("(GetUnitDebuff) SpellTable Match for ", Type, " = False");
				if (PA:CheckMessageLevel("Cure", 4)) then
					PA:Message4("SpellTable Match for "..Type.." = False");
				end
			end
		end

		Index = Index + 1;
		Texture, Count, Type = UnitDebuff(unit, Index);
	end

	return Factor;
end


function PA:GetBestDebuff(unit, isSelf, skipCheck)

	PA:Debug("(GetBestDebuff) unit=", unit, " isSelf=", isSelf);
	local MinFactor = 1.0;
	local BestSpell = nil;
	local BestRank = nil;
	local BestPriority = 0;
	local BestShortSpell;

	local CanCast = true;
	if (skipCheck~=true) then
		CanCast, Status = PA:SpellCastableCheck(unit, PA.Spells.Default.Cure, PASettings.Switches.UseActionRange.Cure);
	end
	if (CanCast) then
		for ShortSpell, Debuff in pairs(PA.SpellBook.DeDebuffs) do

			PA:Debug("(GetBestDebuff) Checking Spell: "..PA.SpellBook[ShortSpell].Name.. ". Spell Priority = "..Debuff.Priority);

			local Skip = false;
			-- Check if level too low
			if (PA:GetSpellProperty(ShortSpell, "LevelBased")==true and PA.Spells.Levels[ShortSpell]~=nil) then
				Skip = (UnitLevel(unit) < (PA:TableLast(PA.Spells.Levels[ShortSpell]) - 10));
				PA:Debug("(GetBestDebuff)   Skip=", Skip);
			end

			if (Skip==false) then
				local CurFactor = PA:GetUnitDebuff(unit, Debuff);
				PA:Debug("(GetBestDebuff)   CurFactor=", CurFactor);
				PA:Debug("(GetBestDebuff)   MinFactor=", MinFactor);
				PA:Debug("(GetBestDebuff)   Debuff.Priority=", Debuff.Priority);
				PA:Debug("(GetBestDebuff)   BestPriority=", BestPriority);
				if (CurFactor<MinFactor or (CurFactor<1.0 and CurFactor==MinFactor and Debuff.Priority>BestPriority)) then
					MinFactor = CurFactor;
					BestSpell = PA.SpellBook[ShortSpell].Name;
					BestRank = PA.SpellBook[ShortSpell].Rank;
					BestPriority = Debuff.Priority;
					BestShortSpell = ShortSpell;
					PA:Debug("(GetBestDebuff)   Set BestSpell=", BestSpell);
				end
			end
		end
	else
		PA:Debug("(GetBestDebuff) Not castable ", Status);
	end
	return BestShortSpell, BestSpell, BestRank, MinFactor;
end

----------------------------------------------------------------------------------------------------------
-- Cure target of Debuffs
-- This function is called from autocure
-- Call this function from a macro with "/paladin bestcure" to use the best cure spell to cure your target
-- 2.0 Use Spell Database instead of hard coded levels
----------------------------------------------------------------------------------------------------------
function PA:BestCure(unit, skipTargetCheck, forceSelf)

	--if (PA:CheckMessageLevel("Cure", 4)) then
		--PA:Message4("BestCure entered for "..tostring(unit));
	--end

	if (PA:AbortHealCheck()) then
		return false;
	end
	
	if (PA:TableEmpty(PA.SpellBook.DeDebuffs)) then
		if (PA:CheckMessageLevel("Cure", 1)) then
			PA:Message4(PANZA_MSG_CURE_MISSING);
		end
		return false;
	end

	----------------------------------------------------------------------------------
	-- 1.21 Addition. Use settings to determine if we monitor the alt+key for anything
	----------------------------------------------------------------------------------
	if (forceSelf==true) then
		 unit = "player";
		 IsSelf = true;
	end

	if (PA:CheckMessageLevel("Cure", 5)) then
		PA:Message4("BestCure entered for "..unit);
	end
	local Success = false;
	local SelfLevel = UnitLevel("player");

	--------------------------------------
	-- Make sure target can be cured by us
	--------------------------------------
	if (skipTargetCheck or PA:CheckTarget(unit, false, PA.Spells.Default.Cure, PASettings.Switches.UseActionRange.Cure)) then

		local ShortSpell, MaxSpell, MaxRank = PA:GetBestDebuff(unit, UnitIsUnit(unit, "player"));

		if (MaxSpell==nil) then
			return false;
		end
		if (PA:CheckMessageLevel("Cure", 2)) then
			PA:Message4("BestCure will use "..MaxSpell.." spell on "..PA:UnitName(unit));
		end

		if (PA:GetSpellCooldown(MaxSpell)) then
			PA.Cycles.Spell["Type"] = "Cure";
			PA.Cycles.Spell["Active"] = {spell=MaxSpell, rank=MaxRank, target=unit, defclass="blank"};
			Success = PA:CastSpell(PA:CombineSpell(MaxSpell, MaxRank), unit);
			if (PA:CheckMessageLevel("Cure", 5)) then
				PA:Message4("(CURE) "..MaxSpell.." cast attempt success="..tostring(Success));
			end
		else
			if (PA:CheckMessageLevel("Cure", 5)) then
				PA:Message4("(CURE) "..MaxSpell.." not ready");
			end
		end
	end
	return Success;
end


--------------------------------------
-- AutoSelect Cure
--------------------------------------
function PA:AsCure(unit, messageOnNone, forceSelf)

	if (PA:AbortHealCheck()) then
		return false;
	end
	
	if (not PA:SpellInSpellBook(PA.Spells.Default.Cure)) then
		return false;
	end
	
	if (PA:CheckMessageLevel("Cure", 4)) then
		PA:Message4("PA:AsCure");
		--PA:Message4("PA:AsCure unit="..tostring(unit).." messageOnNone="..tostring(messageOnNone).." forceSelf="..tostring(forceSelf));
	end

	------------------------------------------------------------
	-- if we have a friendly targeted. Check, and cure if needed
	------------------------------------------------------------
	if (forceSelf~=true and unit~=nil and PA:UnitIsMyFriend(unit)) then
		if (PA:CheckMessageLevel("Cure", 4)) then
			--PA:Message4("Target, BestDebuff="..tostring(BestDebuff));
		end
		if (PA:GetBestDebuff(unit, false)~=nil) then
			if (PA:BestCure(unit, false, forceSelf)) then
				return true;
			end;
		end
	end

	--------------------------------------------------------------------------------------------
	-- We didn't cure the friendly above, or we didn't have a friendly targeted, are we grouped?
	--------------------------------------------------------------------------------------------
	if (forceSelf~=true and (PA:IsInParty() or PA:IsInRaid())) then
		return PA:AutoCure(messageOnNone);

	---------------------------------------------------------------------------------------------------
	-- Finally check self and cure only if needed.We may have already checked ourself above. Redundant.
	---------------------------------------------------------------------------------------------------
	else
		local BestDebuff = PA:GetBestDebuff("player", true);
		--if (PA:CheckMessageLevel("Cure", 4)) then
			--PA:Message4("Self, BestDebuff="..tostring(BestDebuff));
		--end
		if (BestDebuff~=nil) then
			return PA:BestCure("player", false, true);
		else
			return false;
		end
	end
end


-----------------------------
-- Cure group members in turn
-----------------------------
function PA:AutoCure(messageOnNone)

	--PA:ShowText("AutoCure");

	if (PA:TableEmpty(PA.SpellBook.DeDebuffs)) then
		--PA:Debug("No debuffs!!");
		if (PA:CheckMessageLevel("Cure", 1)) then
			PA:Message4(PANZA_MSG_CURE_MISSING);
		end
		return false;
	end

	local Success, Unit = PA:AutoGroup({Weighting=PA_CureCheck, Cast=PA_CastCure}, PASettings.Switches.MsgLevel["Cure"], "Cure", true, "Cure");
	if (Success==true) then
		return true, Unit;
	end

	if (messageOnNone==true and PASettings.Switches.QuietOnNotRequired~=true) then
		-- If we get here no cures have been attempted
		if (PA:CheckMessageLevel("Cure", 1)) then
			PA:Message4(PANZA_MSG_CURE_NO);
		end
	end
	return false;

end

function PA_CastCure(unitInfo)
	--PA:ShowText("CastCure on ", unitInfo.Unit);
	if (PA:GetSpellCooldown(unitInfo.Spell)) then
		PA.Cycles.Spell["Type"] = "Cure";
		PA.Cycles.Spell["Active"] = {spell=unitInfo.Spell, rank=unitInfo.Rank, target=unitInfo.Unit, defclass="blank"};
		return (PA:CastSpell(PA:CombineSpell(unitInfo.Spell, unitInfo.Rank), unitInfo.Unit));
	--else
		--PA:ShowText(unitInfo.Spell, " On cooldown");
	end
	return false;
end

---------------------------------------------------------------
-- Determine if group member is cureable and assign a weighting
---------------------------------------------------------------
function PA_CureCheck(info)

	local ShortSpell, Spell, Rank, DebuffFactor = PA:GetBestDebuff(info.Unit, info.IsSelf, true);
	--if (PA:CheckMessageLevel("Cure", 3)) then
		--PA:Message4("(PA_CureCheck) ShortSpell="..tostring(ShortSpell));
		--PA:Message4("(PA_CureCheck) Spell="..tostring(Spell));
		--PA:Message4("(PA_CureCheck) Rank="..tostring(Rank));
		--PA:Message4("(PA_CureCheck) DebuffFactor="..tostring(DebuffFactor));
	--end

	if (Spell==nil) then
		return false;
	end

	info.Affected = DebuffFactor * UnitHealth(info.Unit) / UnitHealthMax(info.Unit);
	--if (PA:CheckMessageLevel("Cure", 3)) then
		--PA:Message4("Affected="..info.Affected.." DebuffFactor="..DebuffFactor.." Health ratio="..UnitHealth(info.Unit) / UnitHealthMax(info.Unit));
	--end

	info.ShortSpell = ShortSpell;
	info.Spell = Spell;
	info.Rank = Rank;
	info.Factor = DebuffFactor;

	return true;
end