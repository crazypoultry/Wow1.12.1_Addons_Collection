--[[

pa_di.lua
Panza Divine Intervention Functions
Revision 4.0

]]

PA["DIClassBias"] = {};
PA.DIClassBias["PALADIN"]	= 0; -- Lowest first
PA.DIClassBias["SHAMAN"]	= 1;
PA.DIClassBias["PRIEST"]	= 2;
PA.DIClassBias["DRUID"]		= 3;

function PA_CastDI(unitInfo)
	if (PA:GetSpellCooldown("di")) then
		if PA:CastSpell(PA.SpellBook.di.Name.."()", unitInfo.Unit) then
			local MessageTo = "PARTY";
			if (PA:IsInRaid() and UnitInRaid(unitInfo.Unit)) then
				MessageTo = "RAID";
			end
			PA:Notify2(MessageTo, "Casting "..PA.SpellBook.di.Name.." on "..unitInfo.Name.." ("..unitInfo.Class..")!");
			return true;
		end
	end
	return false;
end

function PA:DivineIntervention()

	if (PA:AbortHealCheck()) then
		return false;
	end
	
	if (not PA:SpellInSpellBook("di")) then
		if (PA:CheckMessageLevel("Core", 1)) then
			PA:Message4(PANZA_MSG_DI_MISSING);
		end
		return nil;
	end

	if (PA:CheckMessageLevel("Core", 4)) then
		PA:Message4("PA:DivineIntervention");
	end

	PA:Debug("DI Range=", PA:GetSpellProperty("di", "Range"));
	local Success, Unit = PA:AutoGroup({PreCheck=PA_DIPreCheck, Weighting=PA_DIWeighting, Cast=PA_CastDI}, PASettings.Switches.MsgLevel.Core, "Core", false, nil, "di");
	if (Success==true) then
		return true, Unit;
	end
 	-- If we get here no DIs have been attempted
 	if (PASettings.Switches.QuietOnNotRequired~=true) then
		if (PA:CheckMessageLevel("Bless", 1)) then
			PA:Message4(PANZA_MSG_DI_NO);
		end
	end
	return false;

end

-----------------------------
-- Check if DI should be cast
-----------------------------
function PA_DIPreCheck(info)
	if (info.Owner~=nil or info.IsSelf==true or PA.DIClassBias[info.Class]==nil) then
		return false;
	end
	info.Spell = "di";
	return true;
end

----------------------------------------
-- Get weighting for unit for casting DI
----------------------------------------
function PA_DIWeighting(info)
	info.Affected = PA.DIClassBias[info.Class];
	return true;
end