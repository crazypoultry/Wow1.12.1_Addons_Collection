--[[

pa_bosaf.lua
Panza Blessing of Sacrifice Functions
Revision 4.0

]]

function PA_CastBoSaf(unitInfo)
	local Spell = PA:GetSpellProperty("bosaf", "Name");
	local Rank = PA:GetSpellProperty("bosaf", "MinRank");

	if (Spell~=nil and Rank~=nil) then
		PA.Cycles.Spell.Active.msgtype	= "AutoBoSaf";
		PA.Cycles.Spell.Active.owner	= unitInfo.Owner;
		PA.Cycles.Spell.Active.defclass = "(Auto)";
		PA.Cycles.Spell.Type			= "Bless";
		PA.Cycles.Spell.Active.spell	= Spell;
		PA.Cycles.Spell.Active.rank		= Rank;
		PA.Cycles.Spell.Active.target	= unitInfo.Unit;
		PA.Cycles.Spell.Active.Class	= unitInfo.Class;
		if (PA.Cycles.Spell.Active.owner==nil) then
			local PetText = nil;
			PA.Cycles.Spell.Active.owner, PetText = PA:GetUnitsOwner(unit);
			if (PA.Cycles.Spell.Active.owner~=nil and PetText~=nil) then
				if (PA:CheckMessageLevel("Bless", 4)) then
					PA:Message4("Blessing "..PetText);
				end
			end
		end

		if (PA:CastSpell(PA:CombineSpell(Spell, Rank), unitInfo.Unit)) then
			PA.Cycles.Spell.Active.success 	= true;
			return true;
		end
	end
end

function PA:BoSaf()
	if (PA:CheckMessageLevel("Bless", 4)) then
		PA:Message4("PA:BoSaf");
	end
	return PA:AutoGroup({PreCheck=PA_BoSafPreCheck, Weighting=PA_BoSafWeighting, Cast=PA_CastBoSaf}, PASettings.Switches.MsgLevel.Bless, "Bless", false, "Bless");
end

------------------------------
-- BoSaf group members in turn
------------------------------
function PA:AutoBoSaf(messageOnNone)

	if (not PA:SpellInSpellBook("bosaf") or not PA:GetSpellCooldown("bosaf")) then
		return false;
	end

	--PA:ShowText("======================================");
	--PA:ShowText("AutoBoSaf");
	--PA:ListCycle();

	PASettings.BoSafClass = {};
	PASettings.BoSafClass["WARRIOR"] 		= 1;
	PASettings.BoSafClass["ROGUE"] 			= 2;
	PASettings.BoSafClass["DRUID"]			= 3;
	PASettings.BoSafClass[PA.HybridClass] 	= 4;
	PASettings.BoSafClass["HUNTER"]			= 5;
	PASettings.BoSafClass["WARLOCK"] 		= 6;
	PASettings.BoSafClass["PRIEST"] 		= 7;
	PASettings.BoSafClass["MAGE"]			= 8;

	local Success, Unit = PA:BoSaf();
	if (Success==true) then
		return true, Unit;
	end
 	-- If we get here no blessings have been attempted
 	if (Success==false and messageOnNone and PASettings.Switches.QuietOnNotRequired~=true) then
		if (PA:CheckMessageLevel("Bless", 1)) then
			PA:Message4(PANZA_MSG_SAF_NO);
		end
	end
	return false;
end

------------------------------------------------
-- Check if blessing of Sacrifice should be cast
------------------------------------------------
function PA_BoSafPreCheck(info)
	if (PASettings.BoSafClass[info.Class]==0 or info.IsSelf) then
		return false
	end

	-- If already a player with BoSaf then exit
	local SpellState, LastSpell, Expires, BuffId, CanBless = PA:GetSpellState(info.Unit, info.Name, "bosaf");
	--PA:ShowText("SpellState=", SpellState, " LastSpell=", LastSpell);
	if (SpellState==PA_SPELL_SET) then
		local TimeLeft = PA.SpellBook.bosaf.Duration - GetTime() + LastSpell.Time;
		if (TimeLeft > 10) then
			info.Message = "BOSAF already up "..TimeLeft.." s remaining";
			if (PA:CheckMessageLevel("Bless", 4)) then
				PA:Message4(info.Message);
			end
			return nil;
		end
	end

	return true;
end

-----------------------------------------------------------
-- Get weighting for unit for casting blessing of Sacrifice
-----------------------------------------------------------
function PA_BoSafWeighting(info)
	info.Affected = PASettings.BoSafClass[info.Class];
	return true;
end