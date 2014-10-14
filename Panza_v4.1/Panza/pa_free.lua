--[[

pa_free.lua
Panza Free Functions
Revision 4.0

]]

function PA_CastFree(unitInfo)
	PA.Cycles.Spell.Active.msgtype = "AutoFree";
	PA.Cycles.Spell.Active.owner = unitInfo.Owner;
	PA.Cycles.Spell.Active.defclass = "(Auto)";
	return PA:BlessByLevel("bof", unitInfo.Unit, false, true);
end

function PA:Free()
	if (not PA:SpellInSpellBook("bof")) then
		return false;
	end
	if (PA:CheckMessageLevel("Bless", 4)) then
		PA:Message4("PA:Free");
	end
	return PA:AutoGroup({PreCheck=PA_FreePreCheck, Weighting=PA_FreeWeighting, Cast=PA_CastFree}, PASettings.Switches.MsgLevel.Bless, "Bless", PASettings.Switches.Pets.Free, "Free");
end

------------------------------
-- Free group members in turn
------------------------------
function PA:AutoFree()

	local Success, Unit = PA:Free();
	if (Success==true) then
		return true, Unit;
	end
 	-- If we get here no freeings have been attempted
 	if (PASettings.Switches.QuietOnNotRequired~=true) then
		if (PA:CheckMessageLevel("Bless", 1)) then
			PA:Message4(PANZA_MSG_FREE_NO);
		end
	end
	return false;
end

----------------------------------------------
-- Check if blessing of Freedom should be cast
----------------------------------------------
function PA_FreePreCheck(info)
	if (PASettings.PFMWeight[info.Class]==0) then
		return false
	end
	return true;
end

-------------------------------------
-- Get weighting for unit for freeing
-------------------------------------
function PA_FreeWeighting(info)
	if (not PA:UnitIsStuck(info.Unit)) then
		if (PA:CheckMessageLevel("Bless", 4)) then
			PA:Message4("Name="..info.Name.." not stuck");
		end
		return false;
	end
	info.Affected = 10 - PASettings.PFMWeight[info.Class];
	return true;
end

-------------------
-- Auto Select Free
-------------------
function PA:AsFree(unit)
	local friend = false;

	if (not unit) then
		unit = "target";
	end


	if (IsAltKeyDown() and PASettings.Switches.EnableSelf == true and PA:UnitIsStuck("player")) then
		PA.Cycles.Spell.Active.defclass = "(Auto)";
		PA.Cycles.Spell.Active.msgtype = "AutoFree";
		PA.Cycles.Spell.Active.owner = nil;
		return PA:BlessByLevel("bof", "player", false, false);
	end

	friend = PA:UnitIsMyFriend(unit);

	if (friend and PA:UnitIsStuck(unit) and PA:CheckTarget(unit, false, "bof", PASettings.Switches.UseActionRange.Free)) then
		PA.Cycles.Spell.Active.defclass = "(Auto)";
		PA.Cycles.Spell.Active.msgtype = "AutoFree";
		PA.Cycles.Spell.Active.owner = nil;
		return PA:BlessByLevel("bof", unit, false, false);
	end

	if (PA:IsInParty() or PA:IsInRaid()) then
		return PA:Free(unit);
	else
		if (PA:UnitIsStuck("player")) then
			PA.Cycles.Spell.Active.defclass = "(Auto)";
			PA.Cycles.Spell.Active.msgtype = "AutoFree";
			PA.Cycles.Spell.Active.owner = nil;
			return PA:BlessByLevel("bof", "player", false, false);
		end
	end

	return false;
end

-----------------------------------------------
-- Determine if there is an immobilizing debuff
-----------------------------------------------
function PA:UnitIsStuck(unit)

	if (PA:CheckMessageLevel("Core", 5)) then
		PA:Message4("PA:UnitIsStuck("..unit..") called.");
	end

	--Flag carrier in WSG always needs BoF
	if (PA:IsInWSG()) then
		if (PA.WSG[PA.EnemyFaction]~=nil) then
			if (PA:UnitName(unit)==PA.WSG[PA.EnemyFaction]) then
				return true, true;
			end
		end
	end

	local i = 1;

	PA:ResetTooltip();
	while true do

		local Debuff = UnitDebuff(unit, i);
		if (not Debuff) then
			break;
		end

		if (PA:CheckMessageLevel("Core", 5)) then
			PA:Message4("DeBuff "..i.."="..Debuff);
		end
		Debuff = string.lower(Debuff);

		for Index, SeachText in ipairs(PANZA_STUCK) do
			if (PA:CheckMessageLevel("Core", 5)) then
				PA:Message4("Looking for "..SeachText);
			end
			local start = string.find(Debuff, SeachText);
			if (start~=nil) then
				if (PA:CheckMessageLevel("Core", 5)) then
					PA:Message4("  Positive match");
				end
				return true, false;
			end
		end

		PanzaTooltip:SetUnitDebuff(unit, i);

		local debuffType = PanzaTooltipTextLeft2:GetText();

		if (debuffType~=nil) then
			if (PA:CheckMessageLevel("Core", 5)) then
				PA:Message4("DeBuff "..i.." TooltipText="..debuffType);
			end
			debuffType = string.lower(debuffType);
			for Index, SeachText in ipairs(PANZA_IMMOBILIZED) do
				if (PA:CheckMessageLevel("Core", 5)) then
					PA:Message4("Looking for "..SeachText);
				end
				local start = string.find(debuffType, SeachText);
				if (start~=nil) then
					if (PA:CheckMessageLevel("Core", 5)) then
						PA:Message4("  Positive match");
					end
					return true, false;
				end
			end
		end
		i = i + 1;
	end
	return false, false;
end
