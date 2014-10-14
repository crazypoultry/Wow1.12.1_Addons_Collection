--[[

pa_resurrect.lua
Panza Resurrect Functions
Revision 4.0

10-01-06 "for in pairs() completed for BC
--]]

function PA:SetupRez()
	-- Priority for Resurrections (lowest first)
	PA.Resurrect = {};
	PA.Resurrect["PRIEST"] 		= 1;
	PA.Resurrect[PA.HybridClass]	= 2;
	PA.Resurrect["DRUID"] 		= 3;
	PA.Resurrect["WARLOCK"]		= 4;
	PA.Resurrect["MAGE"] 		= 5;
	PA.Resurrect["HUNTER"] 		= 6;
	PA.Resurrect["WARRIOR"]		= 7;
	PA.Resurrect["ROGUE"] 		= 8;

end

PA.ReleasedList = {};
PA.ReleasedCount = 0;
PA.Rez = {}; -- list of recently rezzed players
----------------------------------
-- Resurrect group members in turn
----------------------------------
function PA:AutoResurrect()

	--PA:Debug("PA:AutoResurrect()");
	if (not PA:SpellInSpellBook("rez")) then
		if (PA:CheckMessageLevel("Rez", 1)) then
			PA:Message4(PANZA_MSG_RESURRECT_MISSING);
		end
		return nil;
	end

	PA.ReleasedList = {};
	PA.ReleasedCount = 0;

	local Success, Unit, Count, ExcludedCount, PlayerList, PetList = PA:AutoGroup({PreCheck=PA_ResurrectPreCheck, Weighting=PA_ResurrectWeighting, Cast=PA_CastResurrect}, PASettings.Switches.MsgLevel["Rez"], "Rez", false, nil);

	if (Success==true) then
		return true, Unit;
	end

 	-- If we get here no resurrections have been attempted

	local TotalEligible = PA:TableSize(PlayerList);
	PA:Debug("TotalEligible=", TotalEligible);
	if (TotalEligible>0) then
		local TotalOOR = 0;
		for i, v in pairs(PlayerList) do
			if (v.InRange~=true) then
				TotalOOR = TotalOOR + 1;
			end
		end
		if (TotalOOR>0) then
			if (PA:CheckMessageLevel("Rez", 1)) then
				PA:Message4(PANZA_MSG_RESURRECT_OUTOFRANGE);
			end
			for i, v in pairs(PlayerList) do
				if (v.InRange~=true) then
					if (PA:CheckMessageLevel("Rez", 1)) then
						PA:Message4("  "..v.Name);
					end
				end
			end
			return true;
		end
	end

	if (TotalEligible==0 and PA.ReleasedCount>0) then
		PA.Cycles.Spell.Type = "Rez";
		PA.Cycles.Spell.Active.msgtype = "ManualRez";
		PA.Cycles.Spell.Active.target = "Corpse";
		PA.Cycles.Spell.Active.spell = PA.SpellBook.rez.Name;
		PA.Cycles.Spell.Active.rank = PA.SpellBook.rez.MaxRank;
		CastSpellByName(PA:CombineSpell(PA.SpellBook.rez.Name, PA.SpellBook.rez.MaxRank));
		if (PA:CheckMessageLevel("Rez", 1)) then
			PA:Message4(PANZA_MSG_RESURRECT_RELEASED);
		end
		for i = 1, PA.ReleasedCount do
			if (PA:CheckMessageLevel("Rez", 1)) then
				PA:Message4("  "..PA:UnitName(PA.ReleasedList[i]));
			end
		end
		if (PA:CheckMessageLevel("Rez", 1)) then
			PA:Message4("Select corpse to resurrect manually");
		end
		return true;
	end
	return false;
end

function PA_CastResurrect(unitInfo)
	if (PA:GetSpellCooldown("rez")) then
		PA.Cycles.Spell.Type = "Rez";
		PA.Cycles.Spell.Active.msgtype = "AutoRez";
		PA.Cycles.Spell.Active.target = unitInfo.Unit;
		PA.Cycles.Spell.Active.spell = PA.SpellBook.rez.Name;
		PA.Cycles.Spell.Active.rank = PA.SpellBook.rez.MaxRank;
		return (PA:CastSpell(PA:CombineSpell(PA.SpellBook.rez.Name, PA.SpellBook.rez.MaxRank), unitInfo.Unit));
	end
	return false;
end

-----------------------------------------------------------------
-- Check if Rez should be cast
-- Will check CTRA's Rez Monitor and skip lucky ones being raised
-----------------------------------------------------------------
function PA_ResurrectPreCheck(info)
	if (info.IsSelf) then
		info.Message = "Self";
		return false;
	end

	if (CT_RA_Ressers~=nil) then
		for otherezzor, luckydeadguy in pairs(CT_RA_Ressers) do
			if (luckydeadguy==info.Name) then
				if (PA:CheckMessageLevel("Rez", 2)) then
					PA:Message4("(Rez) "..info.Name.." is being raised by "..otherezzor..", skipping.");
				end
				info.Message = "Being rezed by "..otherezzor;
				return false;
			end
		end
	end

	if (PA.Rez[info.Name]~=nil and (GetTime() - PA.Rez[info.Name])<=120) then
		if (PA:CheckMessageLevel("Rez", 4)) then
			PA:Message4("(Rez) "..info.Name.." Recently rezzed");
		end
		info.Message = "Recently rezzed";
		return false;
	end

	return true;
end

---------------------
-- Assign a weighting
---------------------
function PA_ResurrectWeighting(info)
	info.Affected = PA.Resurrect[info.Class];
	info.Spell = "rez";
	return true;
end

