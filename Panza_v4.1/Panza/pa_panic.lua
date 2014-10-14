--[[

pa_panic.lua
Panza Emergancy Heals
Revision 4.0

]]

PA.PanicNow = {Unit=nil, Stage=0, CastCooldown1=0, CastCooldown2=0, BoP=false, Ramp=0, Last=0};

-------------------------------------------------------------------------
-- Select an appropriate player with low health and try and save his butt
-------------------------------------------------------------------------
function PA:Panic(messageOnNone)

--[[
Find Player with low health (adjusted for class and perhaps rate of health loss)

IF BoP NOT up AND BoP Ready
    CAST BoP
END

IF LOH Ready AND BoP not up
    CAST LOH
END

IF DF Ready
    CAST DF
END

BestHeal
]]

	if (PA:CheckMessageLevel("Heal", 3)) then
		PA:Message4("Panic");
	end
	local Count = 0;
	local MessageLevel = PASettings.Switches.MsgLevel.Core;
	local Now = GetTime();
	if ((Now-PA.PanicNow.Last)<PANZA_PANIC_RAMP_DELAY) then
		PA.PanicNow.Ramp = PA.PanicNow.Ramp + PANZA_PANIC_RAMP_INC;
	elseif ((Now-PA.PanicNow.Last)>PANZA_PANIC_RAMP_RESET) then
		PA.PanicNow.Ramp = 0;
	end
	PA.PanicNow.Last = Now;

	if (PA:AbortHealCheck()) then
		return false;
	end

	local Success, Unit = PA:AutoGroup({Weighting=PA_PanicCheck, Cast=PA_CastPanic}, PASettings.Switches.MsgLevel["Heal"], "Panic", false, "Heal");
	if (Success==true) then
		return true, Unit;
	end

 	-- If we get here no panics have been attempted
 	if (messageOnNone~=false and PASettings.Switches.QuietOnNotRequired~=true) then
		local NoMessage = PANZA_MSG_PANIC_NO;
		local MessageLevel = 1;
		if (PA.PanicNow.Ramp>0) then
			NoMessage = NoMessage.." (Ramp="..PA.PanicNow.Ramp.."%)";
			MessageLevel = 3;
		end
		if (PA:CheckMessageLevel("Heal", MessageLevel)) then
			PA:Message4(NoMessage);
		end
	end
	PA.PanicNow.Unit = nil;
	return false;
end

function PA_CastPanic(unitInfo)
	--PA:ShowText("Panic about ", unitInfo.Unit);
	return (PA:PanicStage(unitInfo.Unit));
end

function PA:PanicStage(unit)
	if (PA.PanicNow.Unit~=unit or (GetTime()-PA.PanicNow.CastCooldown2)>PANZA_PANIC_RESET) then
		PA.PanicNow.Unit = unit;
		PA.PanicNow.Stage = 1;
		PA.PanicNow.BoP = false;
	end

	local HasShield = false;
	if (PA.ShieldSpell~=nil) then
		HasShield = PA:UnitHasBlessing(unit, PA.ShieldSpell);
		if (HasShield) then
			if (PA:CheckMessageLevel("Heal", 3)) then
				PA:Message4(" "..PA.ShieldSpell.." is up");
			end
			PA.PanicNow.BoP = true;
		else
			if (PA:CheckMessageLevel("Heal", 3)) then
				PA:Message4(" "..PA.ShieldSpell.." not up");
			end
		end
	end

	local LoHReady = (PASettings.Switches.PanicStages[3]
					and PA:SpellInSpellBook("loh")
					and PA:GetSpellCooldown("loh"));
	local LowMana = (UnitMana("player")<275);

	-- Shield Stage
	if (PA.PanicNow.Stage==1) then
		if (PA:CheckMessageLevel("Heal", 3)) then
			PA:Message4(" Stage="..PA.PanicNow.Stage);
		end
		if (LoHReady and LowMana) then
			if (PA:CheckMessageLevel("Heal", 3)) then
				PA:Message4("  Skipping to LoH because mana is low");
			end
			PA.PanicNow.Stage = 3;
		else
			if (PASettings.Switches.PanicStages[PA.PanicNow.Stage]
				and PA:SpellInSpellBook(PA.ShieldSpell)
				and not HasShield
				and PA:GetSpellCooldown(PA.ShieldSpell)
				and not PA:UnitHasDebuff(unit, PA.ShieldBlock)) then
				if (PA:CheckMessageLevel("Heal", 3)) then
					PA:Message4(" "..PA.ShieldSpell.." is ready");
				end
				PA.Cycles.Spell.Type = "Panic";
				PA.Cycles.Spell.Active.target 	= unit;
				PA.Cycles.Spell.Active.spell	= PA.SpellBook[PA.ShieldSpell].Name;
				PA.Cycles.Spell.Active.rank	= PA.SpellBook[PA.ShieldSpell].MaxRank;
				if (PA:CastSpell(PA:CombineSpell(PA.SpellBook[PA.ShieldSpell].Name, PA.SpellBook[PA.ShieldSpell].MaxRank), unit)) then
					PA.PanicNow.Stage = PA.PanicNow.Stage + 1;
					PA.PanicNow.CastCooldown1 = GetTime() + 0.5;
					PA.PanicNow.CastCooldown2 = GetTime() + 1.5;
					PA.PanicNow.BoP = true;
					return true;
				end
			end
			if (PA:CheckMessageLevel("Heal", 3)) then
				PA:Message4("  Stage Skipped");
			end
			PA.PanicNow.Stage = PA.PanicNow.Stage + 1;
		end
	end

	local LastCast = GetTime() - PA.PanicNow.CastCooldown1;
	if (LastCast<0) then
		if (PA:CheckMessageLevel("Heal", 3)) then
			PA:Message4(" LastCast1="..LastCast);
		end
		return true;
	end

	-- Holy Shock Stage
	if (PA.PanicNow.Stage==2) then
		if (PA:CheckMessageLevel("Heal", 3)) then
			PA:Message4(" Stage="..PA.PanicNow.Stage);
		end
		if (PASettings.Switches.PanicStages[PA.PanicNow.Stage]
			and PA:SpellInSpellBook("hs")
			and not HasShield
			and PA:GetSpellCooldown("hs")) then
			if (PA:CheckMessageLevel("Heal", 3)) then
				PA:Message4(" Holy Shock is ready");
			end
			PA.Cycles.Spell.Type = "Panic";
			PA.Cycles.Spell.Active.target 	= unit;
			PA.Cycles.Spell.Active.spell	= PA.SpellBook.hs.Name;
			PA.Cycles.Spell.Active.rank		= PA.SpellBook.hs.MaxRank;
			if (PA:CastSpell(PA:CombineSpell(PA.SpellBook.hs.Name, PA.SpellBook.hs.MaxRank), unit)) then
				return true;
			end
		end
		if (PA:CheckMessageLevel("Heal", 3)) then
			PA:Message4("  Stage Skipped");
		end
		PA.PanicNow.Stage = PA.PanicNow.Stage + 1;
	end

	-- LOH Stage
	if (PA.PanicNow.Stage==3) then
		if (PA:CheckMessageLevel("Heal", 3)) then
			PA:Message4(" Stage="..PA.PanicNow.Stage);
		end
		if (LoHReady and (not HasShield or LowMana)) then
			if (PA:CheckMessageLevel("Heal", 3)) then
				PA:Message4(" LOH is ready");
			end
			PA.Cycles.Spell.Type = "Panic";
			PA.Cycles.Spell.Active.target 	= unit;
			PA.Cycles.Spell.Active.spell	= PA.SpellBook.loh.Name;
			PA.Cycles.Spell.Active.rank		= PA.SpellBook.loh.MaxRank;
			if (PA:CastSpell(PA:CombineSpell(PA.SpellBook.loh.Name, PA.SpellBook.loh.MaxRank), unit)) then
				PA.PanicNow = {Unit=nil, Stage=0, CastCooldown1=0, CastCooldown2=0, BoP=false, Ramp=0, Last=0};
				return true;
			end
		end
		if (PA:CheckMessageLevel("Heal", 3)) then
			PA:Message4("  Stage Skipped");
		end
		PA.PanicNow.Stage = PA.PanicNow.Stage + 1;
	end

	-- Cure Stage
	if (PA.PanicNow.Stage==4) then
		if (PA:CheckMessageLevel("Heal", 3)) then
			PA:Message4(" Stage="..PA.PanicNow.Stage);
		end
		if (PASettings.Switches.PanicStages[PA.PanicNow.Stage]) then
			if (PA:CheckMessageLevel("Heal", 3)) then
				PA:Message4(" Attempt Cure");
			end
			if (PA:BestCure(unit)) then
				PA.Cycles.Spell.Type = "Panic";
				PA.PanicNow.Stage = PA.PanicNow.Stage + 1;
				local NextCooldown = GetTime() + 0.5;
				if (PA.PanicNow.CastCooldown2<NextCooldown) then
					PA.PanicNow.CastCooldown2 = NextCooldown;
				end
				return true;
			end
		end
		if (PA:CheckMessageLevel("Heal", 3)) then
			PA:Message4("  Stage Skipped");
		end
		PA.PanicNow.Stage = PA.PanicNow.Stage + 1;
	end

	-- DF Stage
	if (PA.PanicNow.Stage==5) then
		if (PA:CheckMessageLevel("Heal", 3)) then
			PA:Message4(" Stage="..PA.PanicNow.Stage);
		end
		if (PASettings.Switches.PanicStages[PA.PanicNow.Stage]
			and PA:SpellInSpellBook("HEALSPECIAL")
			and PA:GetSpellCooldown("HEALSPECIAL")) then
			if (PA:CheckMessageLevel("Heal", 3)) then
				PA:Message4(" "..PA.SpellBook.HEALSPECIAL.Name.." is ready");
			end
			PA.Cycles.Spell.Type = "Panic";
			PA.Cycles.Spell.Active.target 	= unit;
			PA.Cycles.Spell.Active.spell	= PA.SpellBook.HEALSPECIAL.Name;
			PA.Cycles.Spell.Active.rank		= PA.SpellBook.HEALSPECIAL.MaxRank;
			if (PA:CastSpell(PA:CombineSpell(PA.SpellBook.HEALSPECIAL.Name, PA.SpellBook.HEALSPECIAL.MaxRank), unit)) then
				SpellStopCasting();
			end
		else
			if (PA:CheckMessageLevel("Heal", 3)) then
				PA:Message4("  Stage Skipped");
			end
		end
		PA.PanicNow.Stage = PA.PanicNow.Stage + 1;
	end

	local LastCast = GetTime() - PA.PanicNow.CastCooldown2;
	if (LastCast<0) then
		if (PA:CheckMessageLevel("Heal", 3)) then
			PA:Message4(" LastCast2="..LastCast);
		end
		return true;
	end

	-- Heal Stage
	if (PA.PanicNow.Stage==6) then
		if (PA:CheckMessageLevel("Heal", 3)) then
			PA:Message4(" Stage="..PA.PanicNow.Stage);
		end
		if (PASettings.Switches.PanicStages[PA.PanicNow.Stage]) then
			PA.Cycles.Spell.Type = "Panic";
			--PA.Cycles.Spell.Active.target 	= unit;
			--PA.Cycles.Spell.Active.spell	= PA.SpellBook.HEAL.Name;
			--PA.Cycles.Spell.Active.rank	= PA.SpellBook.HEAL.MaxRank;
			--if (PA:CastSpell(PA:CombineSpell(PA.SpellBook.HEAL.Name, PA.SpellBook.HEAL.MaxRank), unit)) then
			-- 	PA.PanicNow = {Unit=nil, Stage=0, CastCooldown1=0, CastCooldown2=0};
			--	return true;
			--end
			PA.Cycles.Heal.ForceFlash = (not PA.PanicNow.BoP); -- Force flash heal as target might be dead otherwise
			if (PA:BestHeal(unit)) then
				PA.PanicNow = {Unit=nil, Stage=0, CastCooldown1=0, CastCooldown2=0, BoP=false, Ramp=0, Last=0};
				return true;
			end
		end
		if (PA:CheckMessageLevel("Heal", 3)) then
			PA:Message4("  Stage Skipped");
		end
	end

	return false;
end

----------------------------------------------------------------------------
-- Determine if we need to panic about a group member and assign a weighting
----------------------------------------------------------------------------
function PA_PanicCheck(info)

	local HealthPercent = 100.0 * UnitHealth(info.Unit) / UnitHealthMax(info.Unit);
	local MinHealth = PASettings.PanicMinHealth[info.Class] + PA.PanicNow.Ramp;

	if (HealthPercent>MinHealth) then
		return false;
	end

	info.Affected = PASettings.PanicClass[info.Class];
	PA:Debug("Affected=", info.Affected, " HealthPercent=", HealthPercent, " MinHealth=", MinHealth);

	return true;
end