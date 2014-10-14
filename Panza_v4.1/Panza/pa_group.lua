--[[

pa_group.lua
Panza functions to deal with groups (party/raid).
Revison 4.0

10-01-06 "for in pairs()" completed for BC
]]


--------------------------------------------------------------------------
-- 2.1 Loops through all players (and optionally their pets) in your group
--------------------------------------------------------------------------
function PA:GroupLoop(functionList, petFlag, check, spellType)
	local inRaid, UnitBase, NumberToCheck = PA:IsInRaid(), nil, 0;
	local inParty = false;
	local inBG = PA:IsInBG();
	local PlayerList = {};
	local PetList = {};
	local PlayerIndex = 1;
	local PetIndex = 1;
	local SelfFound = false;
	local Exists;
	local Count = 0;
	local IndexOffset = 0;
	local State = PA:DCB_GetStateText();
	local Me = nil;
	local Abort = false;
	PA.ExcludedCount = 0;

	if (PA:CheckMessageLevel("Core", 4)) then
		PA:Message4(" State="..State);
	end

	if (inRaid) then
		NumberToCheck = PANZA_MAX_RAID; -- Includes self
		UnitBase = "raid";
		IndexOffset = 0;
	else
		Exists, PlayerIndex, __, Abort = PA:GroupMemberCheck(functionList, "player", nil, true, 1, PlayerIndex, inRaid, true, State, PlayerList, PA.PlayerClass, spellType);
		if (Abort==true) then
			PA.AbortCurrentLoop = true;
			return 0, {}, {}, 0, nil;
		end
		Me = PlayerList[PlayerIndex-1];
		if (not PA:IsInParty()) then
			return 1, PlayerList, PetList, 0, Me;
		end
		NumberToCheck = PANZA_MAX_PARTY - 1; -- Excludes self
		UnitBase = "party";
		inParty = true;
		IndexOffset = 1;
		if (Exists) then
			Count = Count + 1;
			PA:Debug("  Count PartySelf=", Count);
		end
	end

	-- Players (+ pets)
	for Index = 1, NumberToCheck do
		if (PA.AbortCurrentLoop==true) then
			return 0, {}, {}, 0, Me;
		end
		local Unit = UnitBase..Index;
		if (UnitExists(Unit)) then
			if (not SelfFound and inRaid and UnitIsUnit(Unit, "player")) then
				Exists, PlayerIndex, __, Abort = PA:GroupMemberCheck(functionList, Unit, nil, true, Index + IndexOffset, PlayerIndex, inRaid, true, State, PlayerList, PA.PlayerClass, spellType);
				if (Abort==true) then
					PA.AbortCurrentLoop = true;
					return 0, {}, {}, 0, nil;
				end
				Me = PlayerList[PlayerIndex-1];
				SelfFound = true;
				if (Exists) then
					Count = Count + 1;
					PA:Debug("  Count self=", Count);
				end
			else
				inParty = UnitInParty(Unit);
				local __, Class = UnitClass(Unit);
				if (Class~=nil) then

					local ExcludedBy = PA:ExcludeCheck(Index, check, Class, spellType, inRaid, inBG, inParty);
					if (ExcludedBy~=nil) then
						if (PA:CheckMessageLevel(spellType, 4)) then
							PA:Message4("  Unit="..Unit.." excluded by "..ExcludedBy.." ("..Class..")");
						end
						PA:Debug("Unit="..Unit.." excluded by "..ExcludedBy.." ("..Class..")");
					else
						if (PA:CheckMessageLevel(spellType, 5)) then
							PA:Message4("  Unit="..Unit.." NOT excluded by PCS/RGS ("..Class..")");
						end
						--PA:Debug("Unit="..Unit.." NOT excluded by PCS/RGS ("..Class..")");
					end

					if (ExcludedBy==nil) then
						Exists, PlayerIndex, Name, Abort = PA:GroupMemberCheck(functionList, Unit, nil, false, Index + IndexOffset, PlayerIndex, inRaid, inParty, State, PlayerList, Class, spellType);
						if (Abort==true) then
							PA.AbortCurrentLoop = true;
							return 0, {}, {}, 0, nil;
						end
						if (Exists) then
							Count = Count + 1;
							PA:Debug("  Count player=", Count);
							if (petFlag and PA:CanHavePet(Class)) then
								--local __, PetClass = UnitClass(UnitBase.."pet"..Index);
								local PetClass = "WARRIOR"; -- Pets usually need aggro
								Exists, PetIndex, _, Abort = PA:GroupMemberCheck(functionList, UnitBase.."pet"..Index, Name, false, Index, PetIndex, inRaid, inParty, State, PetList, PetClass, spellType);
								if (Abort==true) then
									PA.AbortCurrentLoop = true;
									return 0, {}, {}, 0, nil;
								end
								if (Exists) then
									Count = Count + 1;
									PA:Debug("  Count pet=", Count);
								end
							end
						end
					else
						PA:IncDone(PA:UnitName(Unit));
						Count = Count + 1;
						PA:Debug("  Count excluded=", Count);
						PA.ExcludedCount = PA.ExcludedCount + 1;
					end
				end
			end
		end
	end
	return Count, PlayerList, PetList, PA.ExcludedCount, Me;
end

function PA:ExcludeCheck(index, check, class, spellType, inRaid, inBG, inParty)
	local ExcludedBy = nil;
	if (check~=nil) then
		-- Do not consider players if excluded by PCS
		ExcludedBy = PA:PCSCheck(index, check, class, inRaid, inBG, inParty);

		-- Do not consider players if excluded by RGS
		if (inRaid==true and ExcludedBy==nil) then
			ExcludedBy = PA:RGSCheck(index, check, spellType);
		end
	else
		if (PA:CheckMessageLevel(spellType, 5)) then
			PA:Message4("  Exclude check is nil");
		end
	end
	return ExcludedBy;
end

function PA:PCSCheck(index, check, class, inRaid, inBG, inParty)
	if ((PASettings.Switches.ClassSelect.Raid and inRaid and not inBG and not inParty)
	or  (PASettings.Switches.ClassSelect.Party and inParty)
	or  (PASettings.Switches.ClassSelect.BG and inBG and not inParty)) then
		if (PASettings.Switches.ClassSelect[class][check]==false) then
			return "PCS";
		end
	end
	return nil;
end

function PA:RGSCheck(index, check, spellType)
	local ___, ___, subgroup = GetRaidRosterInfo(index);
	if (subgroup~=nil) then
		if (PA:CheckMessageLevel(spellType, 5)) then
			PA:Message4("  Subgroup="..subgroup);
		end
		if (not PA:RaidGroupStatus(subgroup, check)) then
			return "RGS";
		end
	end
	return nil;
end

-- This is used to temporarily replace the Blizzard TargetFrame_Update function and so speed-up
-- functions that require the target to change multiple times.
function PA_DummyTargetFrame_Update()
	PA.LastTargetFrame = this;
end

---------------------------------------------------------------
-- 3.0 Call the bestFunction for the most relevant group member
---------------------------------------------------------------
function PA:AutoGroup(functionList, messageLevel, spellType, petFlag, check, checkSpell)

	if (PA.Spells.Default[spellType]~=nil) then
		checkSpell = PA.Spells.Default[spellType];
	end
	
	-- Abort if spells on cool-down or we are casting
	if (not PA:GetSpellCooldown(checkSpell, true) or PA.CastingNow==true) then
		return nil, nil, 0, 0;
	end

	PA.AbortCurrentLoop = false;

	-- Temporarily turn off target update code, for speed
	local PA_TargetFrame_Update = TargetFrame_Update;
	TargetFrame_Update = PA_DummyTargetFrame_Update;
    PA:CastingBarToggle("off");

	local Status, Success, Unit, Count, ExcludedCount, PlayerList, PetList = pcall(PA_AutoGroup_Safe, functionList, messageLevel, spellType, petFlag, check);

	-- Restore target update code
	TargetFrame_Update = PA_TargetFrame_Update;
	PA_TargetFrame_Update = nil;
    PA:CastingBarToggle("on");

	if (not Status) then
		PA:DisplayText(PA_RED.."Error in target protected call: ", Success); -- on failure Success is the error message
		if (PA.UnitTesting==true and luaUnit.Verbose~=true) then
			luaUnit:print("Error in target protected call: "..Success);
		end
		Success, Unit, Count, ExcludedCount = false, nil, 0, 0;
	end

	PA:CleanupSpells();

	if (PA.AbortCurrentLoop==true) then
		return nil, nil, 0, 0;
	end

	return Success, Unit, Count, ExcludedCount, PlayerList, PetList;
end

function PA_AutoGroup_Safe(functionList, messageLevel, spellType, petFlag, check)
	if unexpected_condition then error() end

	PA:GetMainTankTargetTargets();

	local Count, PlayerList, PetList, ExcludedCount, Me = PA:GroupLoop(functionList, petFlag, check, spellType);
	local Success = false;
	local Unit = nil;

	--PA:Debug("PA_AutoGroup_Safe Abort=", PA.AbortCurrentLoop);

	if (PA.AbortCurrentLoop~=true) then
		if (spellType=="Heal") then
			-- Combine lists
			local Offset = getn(PlayerList);
			for PetIndex, value in pairs(PetList) do
				PA:Debug("  Adding Pet ", key);
				PlayerList[Offset + PetIndex] = value;
			end
			Success, Unit = PA:GroupBest("Player/Pet", PlayerList, messageLevel, spellType, functionList.Cast, Me);
		else
			-- Players
			Success, Unit = PA:GroupBest("player", PlayerList, messageLevel, spellType, functionList.Cast, Me);
			if (not Success and petFlag) then
				-- Pets
				Success, Unit = PA:GroupBest("pet", PetList, messageLevel, spellType, functionList.Cast, Me);
			end
		end
	end
	--PA:Debug("Success=", Success, " Count=", Count, " ExcludedCount=", ExcludedCount);
	return Success, Unit, Count, ExcludedCount, PlayerList, PetList;
end

---------------------------------------------------
-- Find best unit based on weighting and cast spell
---------------------------------------------------
function PA:GroupBest(targetType, groupList, messageLevel, spellType, castFunction, me)
	--PA:ShowText("GroupBest");
	local Success = false;
	local Unit = nil;
	local Count = getn(groupList);

	if (Count==1) then
		local Info = groupList[1];
		if (Info.IsSelf) then
			return castFunction(Info), "player";
		end
	end

	if (PA:CheckMessageLevel(spellType, 4)) then
		PA:Message4("Checking "..targetType..", count="..Count);
	end
	if (Count>0) then
		table.sort(groupList, function(a, b) return (a.Affected < b.Affected) end);

		--PA:Debug("messageLevel=", messageLevel);
		PA:Debug("(GroupBest) spellType=", spellType);
		
		if (PA:CheckMessageLevel(spellType, 4)) then
			for key, value in pairs(groupList) do
				PA:Message4(PA_GREN..key..PA_WHITE.." - "..PA_BLUE..""..value.Name.." "..string.upper(value.Class).." ("..value.Unit..") "..format("%.3f", value.Affected).." "..tostring(value.InRange));
			end
			PA:Message4("Top "..targetType.." for "..spellType.." "..groupList[1].Name.." ("..groupList[1].Unit..")".." with weighting="..format("%.3f", groupList[1].Affected));
		end

		local InCombat = PA.InCombat;
		if (PA:CheckMessageLevel(spellType, 5)) then
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

		PA:Debug("(GroupBest) Group Count=", (PA:TableSize(groupList)));
		-- Loop though all viable players, starting with the most significat weighting
		for key, value in pairs(groupList) do
			if (PA.AbortCurrentLoop==true) then
				PA.Cycles.UseGreaterBlessings = false;
				return false;
			end
			PA:Debug("(GroupBest) Index=", key, " Name=", value.Name, " spellType=", spellType, " Owner=", value.Owner, " Health=", value.Health, " LowestPlayerHealth=", PA.LowestPlayerHealth, " PetTH=", PASettings.Heal.PetTH);
			if (spellType~="Heal" or value.Owner==nil or value.Health==nil or PA.LowestPlayerHealth>=PASettings.Heal.PetTH) then
				local Class = value.Class;
				-- Always bless own class group blessings on self
				if (me~=nil and PA.Cycles.UseGreaterBlessings and value.Owner==nil and (Class=="SELF" or Class==PA.PlayerClass)) then
					if (castFunction(me)) then
						Unit = "player";
						Success = true;
						break;
					end
				end

				-- Spell in-range/ line of sight check
				local ShortSpell = value.ShortSpell;
				if (ShortSpell==nil or (PA.UnitTesting==true and PAState.SpellCanTarget~=nil and PAState.SpellCanTarget[ShortSpell]==nil)) then
					ShortSpell = PA.Spells.Default[spellType];
					PA:Debug("(GroupBest) Using default ",  spellType, " spell for Castable Check Spell: ", ShortSpell);						
				end
				PA:Debug("(GroupBest) ShortSpell=", ShortSpell, " Range=", PA:GetSpellProperty(ShortSpell, "Range"));						
				if (PA:GetSpellProperty(ShortSpell, "Range")==nil) then
					PA:Debug("(GroupBest) Self Only");						
					-- Self only spell
					if (castFunction(value)) then
						Unit = "player";
						Success = true;
						break;
					end
				end
				-- Cast check spell if not already one casting
				PA:Debug("(GroupBest) Spell=", ShortSpell, " Rank=", PA.SpellBook[ShortSpell].MinRank);
				local SpellTargeting = SpellIsTargeting();
				if (not SpellTargeting) then
					local SpellToCast = PA:CombineSpell(PA.SpellBook[ShortSpell].Name, PA.SpellBook[ShortSpell].MinRank);
					PA:Debug("(GroupBest) SpellToCast=", SpellToCast);
					CastSpellByName(SpellToCast);
					SpellTargeting = SpellIsTargeting();
				end
				-- Spell cast for targeting, now check if it will cast
				if (SpellTargeting) then
					if SpellCanTargetUnit(value.Unit) then
						PA:Debug("  SpellCanTargetUnit: CAN");
						-- Clear test spell
						SpellStopTargeting();
						value.InRange = true;
						if (castFunction(value)) then
							Unit = value.Unit;
							Success = true;
							break;
						end
					else
						value.InRange = false;
						PA:Debug("  SpellCanTargetUnit: Can NOT");
						if (PA:CheckMessageLevel(spellType, 5)) then
							PA:Message4("Can Target Check out-of-range");
						end
						PA:AddEntry(PA.Cycles.Group.OutOfRange, value.Unit, value.Name);
					end
				end
			else
				if (PA:CheckMessageLevel(spellType, 5)) then
					PA:Message4(value.Name.." don't heal pets before players");
				end
			end
		end -- for

		-- Clear test spell
		if (SpellIsTargeting()) then
			SpellStopTargeting();
		end
		-- Retarget original target
		if (Retarget) then
			TargetLastTarget();
			PA.ForceCombat = (InCombat and UnitCanAttack("player", "target"));
		end

	end
	PA.Cycles.UseGreaterBlessings = false;
	PA:Debug("  Success=", Success, " Unit=", Unit);
	return Success, Unit;
end


function PA:GroupMemberCheck(functionList, unit, owningUnitName, isSelf, index, groupIndex, inRaid, inParty, state, groupList, class, spellType)

	local Name = nil;
	--PA:ShowText("GroupMemberCheck unit=", unit);
	if (unit~=nil and unit~="Corpse") then
		Name = PA:UnitName(unit);
	end

	if (Name~="target") then
		if (owningUnitName~=nil) then
			Name = owningUnitName .. "_" .. Name;
		end

		PA:Debug("===> Looking for unit=", unit, " ", Name, " ", class);
		if (PA:CheckMessageLevel(spellType, 4)) then
			PA:Message4("Checking "..Name.." ("..unit..")");
		end

		local Info = {Unit=unit, Name=Name, Class=class, Owner=owningUnitName, IsSelf=isSelf, InParty=inParty, InRaid=inRaid, State=state};

		if (functionList.PreCheck~=nil) then
			local PreCheck = functionList.PreCheck(Info);
			if (PreCheck==nil) then
				PA:Debug("  Precheck abort ", Info.Message);
				return true, groupIndex, Name, true;
			end
			if (PreCheck==false) then
				PA:Debug("  Rejected by precheck ", Info.Message);
				return true, groupIndex, Name, false;
			end
		end

		local FailBias = 0;
		local FailCheck = PA.Cycles.Group.Fail[Name];
		if (FailCheck~=nil) then
			local Weight = PA:FailWeight(FailCheck)
			if (Weight>0) then
				if (PA:CheckMessageLevel(spellType, 4)) then
					PA:Message4("On failed list");
				end
				return true, groupIndex, Name, false;
			end
			FailBias = 100.0 + Weight / 10;
			if (FailBias<0) then
				FailBias = 0;
				PA:RemoveFromFailed(nil, Name);
			end
		end

		local TargetOK, Exists, Status = PA:CheckTarget(unit, (spellType=="Rez"), nil, false);
		--PA:ShowText("  TargetOK=", TargetOK);
		if (TargetOK) then

			Info.FailBias = FailBias;
			local Required = functionList.Weighting(Info);

			if (Required~=true) then
				if (PA:CheckMessageLevel(spellType, 4)) then
					PA:Message4("Not required");
				end
				return Exists, groupIndex, Name, false;
			end

			Info.Affected = Info.Affected + Info.FailBias;

			--Flag carrier in WSG always needs to be first
			if (PA:IsInWSG()) then
				if (PA.WSG[PA.EnemyFaction]~=nil) then
					if (Name==PA.WSG[PA.EnemyFaction]) then
						Info.Affected = -100; -- Ignore failBias, this could be critical
					end
				end
			end

			if (spellType=="Heal" or spellType=="Cure") then
				local Bias = PA:GetHealCureBias(inParty, owningUnitName, isSelf, Name, class);
				PA:Debug("  Bias=", Bias);
				Info.Affected = Info.Affected - Bias;
			end

			groupList[groupIndex] = Info;
			groupIndex = groupIndex + 1;
			return true, groupIndex, Name, false;

		else
			PA:Debug("  CheckTarget failed ", Status);
			if (PA:CheckMessageLevel(spellType, 4)) then
				PA:Message4("PA:CheckTarget failed: "..Status);
			end

			if (Exists==true and Status~=nil) then
				local AddCount = true;
				if (Info.SpellState==PA_SPELL_SET and Info.LastSpell~=nil) then
					if (PA:CheckMessageLevel("Bless", 4)) then
						PA:Message4("Found previous blessing "..Info.LastSpell.Spell.."("..Info.LastSpell.Short..") "..format("%.1f", GetTime() - Info.LastSpell.Time).."s ago");
					end
					if (Info.Expires>=PASettings.Switches["Rebless"]) then
						PA:IncDone(Name);
						AddCount = false;
					end
				end
				if (AddCount and PA.Cycles.Group[Status]~=nil) then
					PA:AddEntry(PA.Cycles.Group[Status], unit, Name);
				end
			end

			return Exists, groupIndex, Name, false;

		end
	end
	return false, groupIndex, nil, false;
end
