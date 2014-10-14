--[[
pa_seal.lua
Panza Paladin Seal functions
Revision 4.0

Based on an idea from Espen Munthe, Thanks Espen.

--]]

-------------------------------------
-- Cycle Seal->Judgement->Seal
-------------------------------------
PA.TargetHealth = 0;


-- used by keybind and SealMenu
function PA:AutoSeal()
	if (PA.CastingNow==true) then
		return false;
	end
	local Seal1, Seal2 = PA:GetSeals();
	local Result = PA:SealJudge(Seal1, Seal2, false);
	return Result;
end

-- Returns seals depending on PvP state
function PA:GetSeals()
	if (UnitIsPVP("player") and PASettings.SealMenu.IgnorePvP==false) then
		return PASettings.Switches.Offense.AutoPVP.Seal1, PASettings.Switches.Offense.AutoPVP.Seal2;
	else
		return PASettings.Switches.Offense.Auto.Seal1, PASettings.Switches.Offense.Auto.Seal2;
	end
end

--Attempts to predict the next Seal/Judge/Offense action
function PA:SealPredict()
	local Seal1, Seal2 = PA:GetSeals();
	local NextAction, NextActionTime = PA:SealJudge(Seal1, Seal2, true);
	--PA:Debug("==Seal NextAction check  NextAction:", NextAction, " in ", NextActionTime, "s");
	if (NextAction~=nil and NextActionTime~=nil) then
		local Spell = PA:GetSpellProperty(NextAction, "Name");
		if (Spell~=nil) then
			if (PA:CheckMessageLevel("Offen", 5)) then
				PA:Message4("Offense: NextAction:"..Spell.." in "..NextActionTime.."s");
			end
		else
			if (PA:CheckMessageLevel("Offen", 5)) then
				PA:Message4("Offense: NextAction:"..NextAction.." in "..NextActionTime.."s");
			end
		end
	end
end

-- Judge current seal if possible
function PA:Judge()
	if (PA:GetSpellCooldown("judge")) then
		if (PA.TargetClose==true) then
			if (PA:CheckMessageLevel("Offen", 2)) then
				PA:Message4("Offense: Casting Judgment");
			end
			CastSpellByName(PA:GetSpellProperty("judge", "Name"));
			return true;
		else
			if (PA:CheckMessageLevel("Offen", 3)) then
				PA:Message4("Offense: Target too far away to judge");
			end
		end
	else
		if (PA:CheckMessageLevel("Offen", 3)) then
			PA:Message4("Offense: Judgment on cooldown");
		end
	end
	return false;
end

-- Cast specified seal if possible
function PA:CastSeal(seal, checkCD)
	if (seal~=nil) then
		if (not checkCD or PA:GetSpellCooldown(seal)) then
			local Spell = PA:GetSpellProperty(seal, "Name");
			if (Spell==nil) then
				return false;
			end
			if (PA:CheckMessageLevel("Offen", 2)) then
				PA:Message4("Offense: Casting "..Spell);
			end
			CastSpellByName(Spell);
			return true;
		else
			--PA:Debug("Seal ", seal, " on cooldown");
		end
	end
	return false;
end

function PA:CastHolyShock(predict)
	if (not PA:SpellInSpellBook("hs")) then
		--PA:Debug("Holy shock not in spellbook");
		return false;
	end
	--PA:Debug("Casting hs, HEALSPECIAL only flag=", PASettings.Switches.Offense.HSOnlyOnDF, " HEALSPECIAL always flag=", PASettings.Switches.Offense.HSAlwaysOnDF, " HEALSPECIAL up=", PA:HasHealSpecialUp());
	if ((PASettings.Switches.Offense.HSOnlyOnDF~=true and PASettings.Switches.Offense.HSAlwaysOnDF~=true) or PA:HasHealSpecialUp()) then
		return PA:CastOffensive("hs", true, false, predict)
	else
		local Ready = PA:ActionInRange(PA:GetSpellProperty("hs", "Range"), "OffenseActionId");
		if (Ready==true and predict~=true) then
			Ready = PA:GetSpellCooldown("hs");
		end

		if (Ready==true) then

			--PA:Debug("try to cast HEALSPECIAL");

			if (predict==true) then
				if (PASettings.Switches.Offense.HSAlwaysOnDF==true) then
					PA:FigureAction("hs");
				else
					PA:FigureAction("HEALSPECIAL", "hs");
				end
				if (PA.Offense.NextActionTime<=0) then
					return true;
				end
			else
				if (PA:GetSpellCooldown("HEALSPECIAL")) then
					local Spell = PA:GetSpellProperty("HEALSPECIAL", "Name");
					if (Spell==nil) then
						return false;
					end
					if (PA:CheckMessageLevel("Offen", 2)) then
						PA:Message4("Offense: Casting "..Spell);
					end
					CastSpellByName(Spell);
					SpellStopCasting();
					SpellStopCasting();
					SpellStopCasting();
					return PA:CastOffensive("hs", false, false, false);
				else
					if (PASettings.Switches.Offense.HSAlwaysOnDF==true) then
						return PA:CastOffensive("hs", false, false, false);
					else
						--PA:Debug("HEALSPECIAL on cooldown");
						return false;
					end
				end
			end
		else
			--PA:Debug("hs on cooldown or out of range");
			return false;
		end
	end
	return false;
end

function PA:CastExorcism(predict)
	if (PA:UnitIsUndeadOrDemon("target")) then
		return PA:CastOffensive("exo", true, true, predict);
	end
	return false;
end

function PA:CastHoW(predict)
	if (PA.TargetHealth < 19.99) then
		return PA:CastOffensive("how", true, false, predict);
	end
	return false;
end

function PA:CastOffensive(short, doChecks, special, predict)
	--PA:Debug("Offensive:", short);
	if (PASettings.Switches.Offense[short]==true) then
		local Ready = false;
		local CoolTime = 0;
		if (predict==true or doChecks==true) then
			Ready, CurrentRemain = PA:GetSpellCooldown(short, predict);
			if (CurrentRemain==nil) then
				CurrentRemain = 0;
			end
		else
			Ready = true;
		end
		if (Ready==true or predict==true) then
			local MobInRange = true;
			if (doChecks and PASettings.Switches.UseActionRange.Offense==true) then
				if (special==true) then
					MobInRange = PA:ActionInRange(nil, short);
					--PA:Debug("MobInRange (", short, ") =", MobInRange);
				else
					MobInRange = PA:ActionInRange(PA:GetSpellProperty(short, "Range"), "OffenseActionId");
					--PA:Debug("MobInRange (", PA:GetSpellProperty(short, "Range"), ") =", MobInRange);
				end
			end
			if (MobInRange) then
				local Spell = PA:GetSpellProperty(short, "Name");
				if (Spell==nil) then
					return false;
				end
				if (predict==true) then
					--PA:Debug("CurrentRemain=", CurrentRemain, " NextActionTime=", PA.Offense.NextActionTime);
					if (CurrentRemain<PA.Offense.NextActionTime) then
						PA.Offense.NextAction = short;
						PA.Offense.NextActionTime = CurrentRemain;
					end
					return PA.Offense.NextActionTime<=0;
				else
					if (PA:CheckMessageLevel("Offen", 2)) then
						PA:Message4("Offense: Casting "..Spell);
					end
					CastSpellByName(Spell);
				end
				return true;
			else
				--PA:Debug(short, " out of range");
			end
		else
			--PA:Debug(short, " on cool-down");
		end
	end
	return false;
end

function PA:Offensive(predict)
	if (PA:CastExorcism(predict)) then
		return true;
	end
	if (PASettings.Switches.Offense.hs==true and PA:CastHolyShock(predict)) then
		return true;
	end
	if (PA:CastHoW(predict)) then
		return true;
	end
	return false;
end

-- depreciated
function PA:Seal(SealCombo)
	if (SealCombo==nil) then
		if (PA:CheckMessageLevel("Offen", 1)) then
			PA:Message4("Invalid seal combination.");
		end
		return false;
	end

	local _, _, Seal1, Seal2 = string.find(SealCombo, "(%a+)_J_(%a+)");
	if (Seal1==nil or Seal2==nil) then
		if (PA:CheckMessageLevel("Offen", 1)) then
			PA:Message4("Invalid seal combination: "..SealCombo);
		end
		return false;
	end

	return PA:SealJudge(Seal1, Seal2);
end

function PA:FigureAction(action, action2)
	--PA:Debug("FigureAction action=", action, " action2=",action2);
	local _, CurrentRemain = PA:GetSpellCooldown(action, true);
	--PA:Debug("CurrentRemain=", CurrentRemain, " PA.Offense.NextActionTime=",PA.Offense.NextActionTime);
	if (CurrentRemain==nil) then
		CurrentRemain = 0;
	end
	if (CurrentRemain<PA.Offense.NextActionTime) then
		if (action2==nil) then
			PA.Offense.NextAction = action;
		else
			PA.Offense.NextAction = action2;
		end
		PA.Offense.NextActionTime = CurrentRemain;
		--PA:Debug("New NextAction set to ", PA.Offense.NextAction, " (", PA.Offense.NextActionTime, "s)");
	end
end

---------------------------------------------------------------------------------
-- Function to set the seals
---------------------------------------------------------------------------------
function PA:SetSeals(seal1, seal2, pvpFlag)
	if (seal1~=nil) then
		seal1 = string.lower(seal1);
		if (PA.SpellBook.Seals[seal1]==nil)  then
			if (PA:CheckMessageLevel("Offen", 1)) then
				PA:Message4("Unknown seal "..seal1);
			end
			return false;
		end
	end
	if (seal2~=nil) then
		seal2 = string.lower(seal2);
		if (PA.SpellBook.Seals[seal2]==nil)  then
			if (PA:CheckMessageLevel("Offen", 1)) then
				PA:Message4("Unknown seal "..seal2);
			end
			return false;
		end
	end
	
	local Type = "Auto";
	if (pvpFlag==true) then
		Type = "AutoPVP";
	end
	if (seal1~=nil) then
		if (PA:CheckMessageLevel("Offen", 1)) then
			PA:Message4(Type.." Seal#1 set to "..PA:GetSpellProperty(seal1, "Name"));
		end
		PASettings.Switches.Offense[Type].Seal1 = seal1;
	end
	if (seal2~=nil) then
		if (PA:CheckMessageLevel("Offen", 1)) then
			PA:Message4(Type.." Seal#2 set to "..PA:GetSpellProperty(seal2, "Name"));
		end
		PASettings.Switches.Offense[Type].Seal2 = seal2;
	end
	return true;

end

---------------------------------------------------------------------------------
-- Function to cast seals and judge them + other offensive spells
-- When predict==true the fuction makes it's best guess at what will happen next
--   You must make sure no spells are cast or messages output in this mode
---------------------------------------------------------------------------------
function PA:SealJudge(Seal1, Seal2, predict)

	if (Seal1==nil) then
		if (predict==true) then
			return "Invalid Seal", -1;
		else
			if (PA:CheckMessageLevel("Offen", 1)) then
				PA:Message4("Seal 1 undefined");
			end
			return false;
		end
	end
	Seal1 = string.lower(Seal1);
	if (not PA:SpellInSpellBook(Seal1))  then
		if (predict==true) then
			return "Invalid Seal", -1;
		else
			if (PA:CheckMessageLevel("Offen", 1)) then
				PA:Message4("Unknown seal "..Seal1);
			end
			return false;
		end
	end
	if (Seal2~=nil) then
		Seal2 = string.lower(Seal2);
		if (not PA:SpellInSpellBook(Seal2))  then
			if (predict==true) then
				return "Invalid Seal", -1;
			else
				if (PA:CheckMessageLevel("Offen", 1)) then
					PA:Message4("Unknown seal "..Seal2);
				end
				return false;
			end
		end
	end

	local HasSoC = PA:SpellInSpellBook("soc");
	local HaveAttackableTarget = (UnitCanAttack("player", "target")==1);
	local CheckMobStunned = (HasSoC and Seal2~="sow" and PASettings.Switches.Offense.soc==true and PASettings.Switches.Offense.stunned==true);

	local MobHasSeal1 = false;
	local MobStunned = false;
	if (HaveAttackableTarget) then
		--PA:ShowText("AttackTarget PA.AttackActionId=", PA.AttackActionId);
		if (predict~=true and PA.AttackActionId~=nil and not IsCurrentAction(PA.AttackActionId)) then
			AttackTarget();
		end
		PA.TargetHealth = UnitHealth("target");
		PA.TargetClose = PA:ActionInRange(PA:GetSpellProperty("judge", "Range"), "OffenseActionId");
		if (predict~=true) then
			if (PA:CheckMessageLevel("Offen", 3)) then
				PA:Message4("(SealMenu) "..tostring(PA:GetSpellProperty("judge", "Range")).."yrd range check "..tostring(PA.TargetClose));
				PA:Message4("(SealMenu) PA.TargetHealth="..PA.TargetHealth.." PA.TargetClose="..tostring(PA.TargetClose));
				PA:Message4("(SealMenu) Checking mob for "..PA.buffKeys[Seal1]);
			end
		end
		local index = 1;
		local Debuff = UnitDebuff("target", index);
		while (Debuff~=nil) do
			if (not MobHasSeal1 and string.find(Debuff, PA.buffKeys[Seal1])) then
				MobHasSeal1 = true;
			elseif (CheckMobStunned) then
				MobStunned = PA:CheckStunned("target", index, predict)
				CheckMobStunned = not MobStunned;
			end
			if (MobHasSeal1 and not CheckMobStunned) then
				break;
			end
			index = index + 1;
			Debuff = UnitDebuff("target", index);
		end
	end

	PA.Offense = {NextAction = nil, NextActionTime = 10000};

	if (predict~=true) then
		if (PA:CheckMessageLevel("Offen", 3)) then
			PA:Message4("(SealMenu) TargetOK="..tostring(HaveAttackableTarget).." Stunned="..tostring(MobStunned).." HasSoC="..tostring(HasSoC).." Flag SoC="..tostring(PASettings.Switches.Offense.soc).." Flag Stun="..tostring(PASettings.Switches.Offense.stunned));
		end
	end
	-- Cast Seal of Command and Judge if mob is stunned and Judge is ready
	-- Do this first as stuns are short
	if (MobStunned) then
		local JudgeReady, Remaining = PA:GetSpellCooldown("judge", predict);
		if (JudgeReady==true or (Remaining~=nil and Remaining<2) or predict==true) then
			if (predict~=true) then
				if (PA:CheckMessageLevel("Offen", 2)) then
					PA:Message4("Offense: Target stunned and Judgment ready");
				end
			end
			if (PA:UnitHasBlessing("player", "soc")==false) then
				if (predict==true) then
					PA:FigureAction("soc");
					if (PA.Offense.NextActionTime<=0) then
						return PA.Offense.NextAction, PA.Offense.NextActionTime;
					end
				else
					if (PA:CheckMessageLevel("Offen", 3)) then
						PA:Message4("(SealMenu) Casting SoC because target is stunned");
					end
					return PA:CastSeal("soc");
				end
			else
				if (predict==true) then
					PA:FigureAction("judge");
					if (PA.Offense.NextActionTime<=0) then
						return PA.Offense.NextAction, PA.Offense.NextActionTime;
					end
				else
					if (PA:CheckMessageLevel("Offen", 3)) then
						PA:Message4("(SealMenu) Judging SoC because target is stunned");
					end
					if (not PA:Judge()) then
						return false;
					end
					SpellStopCasting();
					SpellStopCasting();
					SpellStopCasting();
				end
				local Seal;
				if (not MobHasSeal1) then
					Seal = Seal1;
				else
					Seal = Seal2;
				end
				if (predict==true) then
					PA:FigureAction(Seal);
					if (PA.Offense.NextActionTime<=0) then
						return PA.Offense.NextAction, PA.Offense.NextActionTime;
					end
				else
					return PA:CastSeal(Seal, false);
				end
			end
		end
	end

	-- Use offensive range spells first if configured
	if (predict~=true) then
		if (PA:CheckMessageLevel("Offen", 3)) then
			PA:Message4("(SealMenu) HaveAttackableTarget="..tostring(HaveAttackableTarget).."  offense always flag="..tostring(PASettings.Switches.Offense.offall));
		end
	end
	if (HaveAttackableTarget and PASettings.Switches.Offense.offall==true) then
		--PA:Debug("Immediate Offense");
		if (PA:Offensive(predict)) then
			if (predict==true) then
				return PA.Offense.NextAction, PA.Offense.NextActionTime;
			else
				return true;
			end
		end
	end

	local WeHaveSeal1 = (PA:UnitHasBlessing("player", Seal1)~=false);
	local WeHaveSeal2 = false;
	if (Seal1==Seal2) then
		WeHaveSeal2 = WeHaveSeal1;
	else
		if (not WeHaveSeal1 and Seal2~=nil) then
			WeHaveSeal2 = (PA:UnitHasBlessing("player", Seal2)~=false);
		end
	end

	if (predict~=true) then
		if (PA:CheckMessageLevel("Offen", 3)) then
			PA:Message4("(SealMenu) Seal1="..tostring(Seal1).." MobHasSeal1="..tostring(MobHasSeal1).." Seal2="..tostring(Seal2).." WeHaveSeal1="..tostring(WeHaveSeal1).." WeHaveSeal2="..tostring(WeHaveSeal2));
		end
	end
	
	-- Process Seal Combo
	if (not WeHaveSeal1 and not MobHasSeal1) then
		-- Sometimes we want to judge seal2 if it is still up, instead of overwriting it with seal1
		if (WeHaveSeal2 and (Seal2=="soc" or Seal2~="sor") and PASettings.Switches.Offense.MaxThreat==true) then
			if (predict==true) then
				PA:FigureAction("judge");
				if (PA.Offense.NextActionTime<=0) then
					return PA.Offense.NextAction, PA.Offense.NextActionTime;
				end
			else
				if (PA:CheckMessageLevel("Offen", 3)) then
					PA:Message4("(SealMenu) Judging Seal2 ("..Seal2..")");
				end
				if (PA:Judge()) then
					SpellStopCasting();
					SpellStopCasting();
					SpellStopCasting();
					return PA:CastSeal(Seal1, false);
				end
			end
		end
		if (predict==true) then
			PA:FigureAction(Seal1);
			if (PA.Offense.NextActionTime<=0) then
				return PA.Offense.NextAction, PA.Offense.NextActionTime;
			end
		else
			if (PA:CheckMessageLevel("Offen", 3)) then
				PA:Message4("(SealMenu) Casting Seal1 ("..Seal1..")");
			end
			return PA:CastSeal(Seal1, true);
		end
	end

	-- Use offensive range spells if not in melee range
	if (HaveAttackableTarget and PA.TargetClose==false) then
		if (predict~=true) then
			if (PA:CheckMessageLevel("Offen", 3)) then
				PA:Message4("(SealMenu) Offense not in melee");
			end
		end
		if (PA:Offensive(predict)) then
			if (predict==true) then
				return PA.Offense.NextAction, PA.Offense.NextActionTime;
			else
				return true;
			end
		end
	end

	-- Seal2 is irrelevant if Seal1 is SoC or SoR as we will never get to it
	if (Seal1~="soc" and Seal1~="sor") then
		-- Judge Seal1 and cast Seal2
		if (not MobHasSeal1 and WeHaveSeal1 and HaveAttackableTarget) then
			if (predict==true) then
				if (PA.TargetClose==true) then
					PA:FigureAction("judge");
					if (PA.Offense.NextActionTime<=0) then
						return PA.Offense.NextAction, PA.Offense.NextActionTime;
					end
				end
			else
				if (PA:CheckMessageLevel("Offen", 3)) then
					PA:Message4("(SealMenu) Judging Seal1 ("..Seal1..")");
				end
				if (PA:Judge()) then
					SpellStopCasting();
					SpellStopCasting();
					SpellStopCasting();
					local Seal;
					if (Seal2==nil) then
						Seal = Seal1;
					else
						Seal = Seal2;
					end
					return PA:CastSeal(Seal, false);
				end
			end
		end

		if (Seal2=="soc" or Seal2=="sor") then
			-- Judge SoC/SoR and recast
			if (WeHaveSeal2 and HaveAttackableTarget
			and ((Seal2=="soc" and PASettings.Switches.Offense.soc==true and PASettings.Switches.Offense.stunned==false)
			or   (Seal2=="sor" and PASettings.Switches.Offense.sor==true))) then
				if (predict==true) then
					if (PA.TargetClose==true) then
						PA:FigureAction("judge");
						if (PA.Offense.NextActionTime<=0) then
							return PA.Offense.NextAction, PA.Offense.NextActionTime;
						end
					end
				else
					if (PA:CheckMessageLevel("Offen", 3)) then
						PA:Message4("(SealMenu) Judging "..Seal2);
					end
					if (PA:Judge()) then
						SpellStopCasting();
						SpellStopCasting();
						SpellStopCasting();
						if (PA:CastSeal(Seal2, false)) then
							return true;
						end
					end
				end
			end
		end

		-- Cast Seal2
		if (Seal2~=nil and MobHasSeal1 and not WeHaveSeal2) then
			if (predict==true) then
				PA:FigureAction(Seal2);
				if (PA.Offense.NextActionTime<=0) then
					return PA.Offense.NextAction, PA.Offense.NextActionTime;
				end
			else
				if (PA:CheckMessageLevel("Offen", 3)) then
					PA:Message4("(SealMenu) Casting Seal2 ("..Seal2..")");
				end
				if  (PA:CastSeal(Seal2, false)) then
					return true;
				end
			end
		end
	else
		-- SoC or SoR, check if we need to judge it
		if ((Seal1=="soc" and PASettings.Switches.Offense.soc==true and PASettings.Switches.Offense.stunned==false)
		or  (Seal1=="sor" and PASettings.Switches.Offense.sor==true)) then

			-- Judge SoC/SoR and recast
			if (WeHaveSeal1 and HaveAttackableTarget) then
				if (predict==true) then
					if (PA.TargetClose==true) then
						PA:FigureAction("judge");
						if (PA.Offense.NextActionTime<=0) then
							return PA.Offense.NextAction, PA.Offense.NextActionTime;
						end
					end
				else
					if (PA:CheckMessageLevel("Offen", 3)) then
						PA:Message4("(SealMenu) Judging");
					end
					if (PA:Judge()) then
						SpellStopCasting();
						SpellStopCasting();
						SpellStopCasting();
						if (PA:CastSeal(Seal1, false)) then
							return true;
						end
					end
				end
			end
		end
	end

	if (HaveAttackableTarget) then
		if (predict~=true) then
			if (PA:CheckMessageLevel("Offen", 3)) then
				PA:Message4("(SealMenu) Offense");
			end
		end
		if (PA:Offensive(predict)) then
			if (predict==true) then
				return PA.Offense.NextAction, PA.Offense.NextActionTime;
			else
				return true;
			end
		end
	end

	if (predict==true) then
		return PA.Offense.NextAction, PA.Offense.NextActionTime;
	else
		if (PA:CheckMessageLevel("Offen", 3)) then
			PA:Message4("(SealMenu) Done");
		end
		return false;
	end
end

function PA:AutoHow()
	if (PA.CastingNow==true or not PA:GetSpellCooldown("how")) then
		if (PA:CheckMessageLevel("Offen", 3)) then
			PA:Message4("(AutoHow) Not ready");
		end
		return; -- This stops spamming the key from locking-up WoW
	end

	-- Temporarily turn off target update code, for speed
	local PA_TargetFrame_Update = TargetFrame_Update;
	TargetFrame_Update = PA_DummyTargetFrame_Update;

	local Status, Success = pcall(PA_AutoHow_Safe);

	-- Restore target update code
	TargetFrame_Update = PA_TargetFrame_Update;
	PA_TargetFrame_Update = nil;
		
	-- Update the target
	if (PA.LastTargetFrame~=nil) then
		local OldThis = this;
		this = PA.LastTargetFrame;
		TargetFrame_OnEvent("PLAYER_TARGET_CHANGED");
		this = OldThis;
	end

	if (not Status) then
		PA:ShowText(PA_RED.."Error in target protected HoW call: ", Success);
		return false;
	end
	
 	if (Success==false and PASettings.Switches.QuietOnNotRequired~=true) then
		if (PA:CheckMessageLevel("Offen", 1)) then
			PA:Message4("(AutoHow) No suitable nearby enemy players found to hammer.");
		end
	end
	return Success;
end

function PA:HowNow(checked)
	local HealthRatio = UnitHealth("target") / UnitHealthMax("target");
	local UName = PA:UnitName("target");
	if (UName~="target") then
		if (checked[UName]~=true) then
			PA:ShowText("targeting enemy:", UName, " health=", HealthRatio);
			if (HealthRatio < 0.1999) then
				if (PA:CastOffensive("how", true, false, false)) then
					return true;
				end
			end
			checked[UName] = true;
		end
	end
	return false;
end

function PA_AutoHow_Safe()
	if unexpected_condition then error() end
	local Checked = {};
	if (PA:CheckMessageLevel("Offen", 3)) then
		PA:Message4("(AutoHow) Checking current target");
	end
	if (UnitCanAttack("player", "target")==1) then
		if (PA:HowNow(Checked)) then
			return true;
		end
	end
	if (PA:CheckMessageLevel("Offen", 3)) then
		PA:Message4("(AutoHow) Checking nearby enemies");
	end
	TargetNearestEnemy();
	local TargetChanged = false;
	if (UnitCanAttack("player", "target")==1) then
		TargetChanged = true;
		for i = 1, 50 do
			if (PA:HowNow(Checked)) then
				return true;
			end
			TargetNearestEnemy();
			if (not UnitCanAttack("player", "target")==1) then
				break;
			end
		end
	end
	
	return false;
end

