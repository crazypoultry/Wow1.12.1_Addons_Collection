--[[
pa_pws.lua
Priest PowerWord:Shield Function
Version 4.0

PWS will shield target's target if target is unfriendly and target's target is in party or raid
Announcements should be configurable to party raid emote say tells and should be
seperate from blessing announcements as this is a very important short term combat spell.

--]]

function PA:PriestPWS(unit)

	if (PA:WandCheck()) then
		return false;
	end

	if (unit and (PA:IsInParty() or PA:IsInRaid()) and not PA:UnitIsMyFriend(unit) and PA:UnitIsMyFriend("targettarget") and (not IsAltKeyDown() and PASettings.Switches.EnableSelf == true)) then
		if (UnitIsUnit("targettarget", "player") or UnitIsUnit(unit, "player") or UnitInParty("targettarget") or UnitInRaid("targettarget")) then
			local UName = PA:UnitName("targettarget");
			if (UName~="target") then
				local TargetTargetUnit = PA:FindUnitFromTarget("targettarget");
				--PA:ShowText("TargetTargetUnit=", TargetTargetUnit);
				if (TargetTargetUnit~=nil and PA:CheckTarget(TargetTargetUnit, false, "pws", false)) then
					if (not PA:UnitHasDebuff(TargetTargetUnit, "WeakSoul")) then
				  		if (not PA:UnitHasBlessing(TargetTargetUnit, "pws")) then
				  			if (PA:CheckMessageLevel("Core",1)) then
					  			PA:Message4("(PWS) Shielding "..UName.." from damage done by "..PA:UnitName("target"));
					  		end
				  			return PA:BlessByLevel("pws", TargetTargetUnit, false, true);
				  		else
				  			if (PA:CheckMessageLevel("Core",1)) then
					  			PA:Message4("(PWS) "..UName.." is already shielded.");
					  		end
				  		end
				  	else
				  		if (PA:CheckMessageLevel("Core",1)) then
					  		PA:Message4("(PWS) Cannot shield "..UName.." when soul is weakened.");
					  	end
					end
				else
					if (PA:CheckMessageLevel("Core",1)) then
						PA:Message4("(PWS) Cannot shield. Target check failed for "..UName);
					end
				end
			else
				if (PA:CheckMessageLevel("Core",5)) then
					PA:Message4("(PWS) Intended shield target returned invalid unit name.");
				end
			end
		else
			if (PA:CheckMessageLevel("Bless",1)) then
				PA:Message4("(PWS) You may only use PWS on party/raid members.");
			end
		end

	else
		local owner, PetText = PA:GetUnitsOwner(unit);

		if (unit and not PA:UnitIsMyFriend(unit) or (IsAltKeyDown() and PASettings.Switches.EnableSelf == true)) then
			return PA:BlessByLevel("pws", "player", false, false);

		elseif (unit and PA:UnitIsMyFriend(unit) and (UnitInParty(unit) or UnitInRaid(unit) or UnitIsUnit("player", unit))) then
			if (PA:CheckTarget(unit, false, "pws", false)) then
				return PA:BlessByLevel("pws", unit, false, true);
			end

		-- See if a pet needs PWS (could be a tanking voidwalker)
		elseif (owner~=nil and PetText~=nil) then
			local checkowner = PA:FindUnitFromName(owner);
			if (checkowner ~= nil) then
				if (UnitInParty(checkowner) or UnitInRaid(checkowner) or UnitIsUnit("player", checkowner)) then
					if (PA:CheckTarget(unit, false, "pws", false)) then
						return PA:BlessByLevel("pws", unit, false, true);
					end
				end
			else
				if (PA:CheckMessageLevel("Bless",1)) then
					PA:Message4("(PWS) Pet must be owned by party/raid member to receive PWS.");
				end
			end
		else
			if (PA:CheckMessageLevel("Bless",1)) then
				PA:Message4("(PWS) You may only use PWS on party/raid members.");
			end
		end
	end
	return false;
end