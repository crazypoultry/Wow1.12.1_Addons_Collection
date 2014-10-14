--[[

pa_range.lua
Panza Range functions
Thanks to MapLibrary and BuffBot for some base
Revison 4.0

10-01-06 "for in pairs()" completed for BC
--]]

-- Macros + Spells to look for range checking
PA.ActionSearch = {};

----------------------------------------------------------------------------------
-- Function reports if MapLibrary Support is enabled, and if the library is ready,
-- and a status text string of both support and library status.
----------------------------------------------------------------------------------
function PA:MapLibrary(action)

	local mlsupport = {[false] = 'off',[true] = 'on'}
	local mlstatus  = {[0] = 'is not', [1] = 'is'}

	if (MapLibrary == nil) then
		MapLibrary = {};
		MapLibrary.Ready = 0;
	elseif (MapLibrary.Ready == nil) then
		MapLibrary.Ready = 0;
	end

	if (_MapLibrary == nil) then
		_MapLibrary = false;
	end

	if (not action) then action = 'STATUS' end

	if (action == 'TOGGLE') then
		_MapLibrary = not _MapLibrary;
		PASettings.Switches.EnableMLS = _MapLibrary;
	end
	local txt = format(PANZA_MSG_MAPLIBRARY,mlsupport[_MapLibrary],mlstatus[MapLibrary.Ready]);

	return(txt);
end


function PA:RangeToUnitInternal(unit)
	local range, zonenum, contnum, px, py, tx, ty, dx, dy 		= 0, 0, 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
	local yds_per_blk, blk_per_yds 					= 6.5,0.154;

	local ZoneRate = {
		[1] = {
			{id=1,  rate=0.00182}, 	-- Ashenvale
			{id=2,  rate=0.00207}, 	-- Azshara
			{id=3,  rate=0.00160}, 	-- Darkshore
			{id=4,  rate=0.00992},	-- Darnassus
			{id=5,  rate=0.00234}, 	-- Desolace
			{id=6,  rate=0.00199},	-- Durotar
			{id=7,  rate=0.00200}, 	-- dustwallow marsh
			{id=8,  rate=0.00183}, 	-- felwood
			{id=9,  rate=0.00151}, 	-- feralas
			{id=10, rate=0.00455}, 	-- Moonglade
			{id=11, rate=0.00204},	-- Mulgore
			{id=12, rate=0.00748}, 	-- Orgrimmar
			{id=13, rate=0.00151},	-- Silithus
			{id=14, rate=0.00215}, 	-- Stonetalon Mtns
			{id=15, rate=0.00152}, 	-- Tanaris
			{id=16, rate=0.00206}, 	-- Rut'theran village
			{id=17, rate=0.00104}, 	-- The Barrens
			{id=18, rate=0.00239}, 	-- Thousand Needles
			{id=19, rate=0.01006}, 	-- Thunderbluff
			{id=20, rate=0.00284}, 	-- Un'Goro Crater
			{id=21, rate=0.00148}, 	-- Winterspring
			{id=22, rate=0.0001},
			{id=23, rate=0.0001},
			{id=24, rate=0.0001},
			{id=25, rate=0.0001},
			},
		[2] 	= {
			{id=1,  rate=0.00210}, 	-- Alterac Mtns
			{id=2,  rate=0.00292}, 	-- Arathi Highlands
			{id=3,  rate=0.0042}, 	-- Bad Lands
			{id=4,  rate=0.00313}, 	-- Blasted Lands
			{id=5,  rate=0.00359}, 	-- Burning Steppes
			{id=6,  rate=0.00420}, 	-- Deadwind pass
			{id=7,  rate=0.00213}, 	-- Dun Morogh
			{id=8,  rate=0.00389}, 	-- Duskwood
			{id=9,  rate=0.00271}, 	-- Eastern Plaguelands
			{id=10, rate=0.00302}, 	-- Elwynn Forest
			{id=11, rate=0.00328},	-- Hillsbrad
			{id=12, rate=0.01327},	-- Iron Forge
			{id=13, rate=0.00381},	-- Loch Modan
			{id=14, rate=0.00484}, 	-- Redridge Mnts
			{id=15, rate=0.00471}, 	-- Searing Gorge
			{id=16, rate=0.00250},	-- Silverpine Forrest
			{id=17, rate=0.00781}, 	-- Stormwind
			{id=18, rate=0.00165}, 	-- Stranglethorn Vale
			{id=19, rate=0.00458}, 	-- Swamp of Sorrows
			{id=20, rate=0.00273}, 	-- The Hinterlands
			{id=21, rate=0.00232}, 	-- Tristfall Glades
			{id=22, rate=0.01094}, 	-- Undercity
			{id=23, rate=0.00244}, 	-- Western Plaguelands
			{id=24, rate=0.00300}, 	-- Westfall
			{id=25, rate=0.00254}	-- Wetlands
			}
		};


	px, py = GetPlayerMapPosition("player");
	tx, ty = GetPlayerMapPosition(unit);

	px = px * 100;
	py = py * 100;

	tx = tx * 100;
	ty = ty * 100;

	zonenum = GetCurrentMapZone();
	contnum = GetCurrentMapContinent();

	-- Instances return 0
	if (zonenum==nil or contnum==nil or zonenum==0) then
		return -1;
	end

	--only happens if you change the map!
	if (px == 0) and (py == 0) then
		if (PA:CheckMessageLevel("Core",5)) then
			PA:Message4("Range: Zone number was "..contnum..' '..zonenum);
		end
		return -2;
	end

	--player not in instance but target may be!
	if (tx == 0) and (ty == 0) then
		return -2;
	end

	if (PA:CheckMessageLevel("Core",5)) then
		PA:Message4("Range: Zone: "..contnum.." "..zonenum);
	end

	local baserate = ZoneRate[contnum][zonenum].rate * 100;

	if (baserate == nil) then
		if (PA:CheckMessageLevel("Core",5)) then
			PA:Message4("Range: No data for Zone! "..contnume.." "..zonenum);
		end
		return -2;
	end

	dx = px - tx;
	dy = py - ty;

	-- coords are not square. adjust x by 2.25
	local range = sqrt((dx * dx * 2.25) + (dy * dy)) / (baserate * yds_per_blk);
    return range;
end


function PA:RangeToUnit(unit)

	if (_MapLibrary and MapLibrary ~= nil) then

		if (MapLibrary.UnitDistance) then
			local distance = MapLibrary.UnitDistance("player", unit, 1)

			if (distance ~= nil) then
				return distance;
			end

			if (UnitPlayerOrPetInRaid(unit) or UnitPlayerOrPetInParty(unit) or UnitIsUnit("player", unit)) then

				if (MapLibrary.InBattleground()) then
					return -1;
				end
				local pii = MapLibrary.InInstance();
				local tii = false;

				local x, y = GetPlayerMapPosition(unit);

				if (x == 0 and y == 0) then
					tii = true;
				end

				if (pii and tii) then
					return -1;
				end

				return -2;
			end
			return -1;
		end
	end
	return PA:RangeToUnitInternal(unit);
end

--------------------------
-- Action Bar Range checks
--------------------------

function PA:ShowActionBarRanges()
	for Range, SpellList in pairs(PA.ActionSearch) do
		PA:DisplayText(format(SPELL_RANGE, Range), ": ", SpellList);
	end
	for Range, SpellList in pairs(PA.OffenseActionSearch) do
		PA:DisplayText("O ", format(SPELL_RANGE, Range), ": ", SpellList);
	end
end
--------------------------------------------------------------------------------------------
-- Create match strings for determining if spell/macro on Action bar for each relevant range
--------------------------------------------------------------------------------------------
function PA:InitializeSpellSearch()
	PA.ActionSearch = {};
	local Sep = {};
	-- Spells
	for Range, SpellList in pairs(PA.SpellBook.Range) do
		PA:Debug("Spell Range=", Range);
		PA.ActionSearch[Range] = "";
		Sep[Range] = "";
		for Short, _ in pairs(SpellList) do
			PA:Debug("Short=", Short);
			PA.ActionSearch[Range] = PA.ActionSearch[Range]..PA:GetFullSpell(Short, Sep[Range]);
			Sep[Range] = "/";
		end
	end
	-- Macros
	for Range, SpellList in pairs(PA.MacroRanges) do
		PA:Debug("Macro Range=", Range);
		if (PA.ActionSearch[Range]==nil) then
			PA.ActionSearch[Range] = "";
			Sep[Range] = "";
		end
		for Macro, _ in pairs(SpellList) do
			PA:Debug("Macro=", Macro);
			PA.ActionSearch[Range] = PA.ActionSearch[Range]..Sep[Range]..Macro;
			Sep[Range] = "/";
		end
	end
	-- Offensive spell ranges
	PA.OffenseActionSearch = {};
	Sep = {};
	-- Spells
	for Range, SpellList in pairs(PA.SpellBook.ORange) do
		--PA:Debug("Offensive Spell Range=", Range);
		PA.OffenseActionSearch[Range] = "";
		Sep[Range] = "";
		for Short, _ in pairs(SpellList) do
			--PA:Debug("Short=", Short);
			PA.OffenseActionSearch[Range] = PA.OffenseActionSearch[Range]..PA:GetFullSpell(Short, Sep[Range]);
			Sep[Range] = "/";
		end
	end
	-- Macros
	for Range, SpellList in pairs(PA.MacroORanges) do
		PA:Debug("Macro Range=", Range);
		if (PA.OffenseActionSearch[Range]==nil) then
			PA.OffenseActionSearch[Range] = "";
			Sep[Range] = "";
		end
		for Macro, _ in pairs(SpellList) do
			PA:Debug("Macro=", Macro);
			PA.OffenseActionSearch[Range] = PA.OffenseActionSearch[Range]..Sep[Range]..Macro;
			Sep[Range] = "/";
		end
	end

	for Range, SpellList in pairs(PA.ActionSearch) do
		PA:Debug(format(SPELL_RANGE, Range), ": ", SpellList);
	end
	for Range, SpellList in pairs(PA.OffenseActionSearch) do
		PA:Debug("O ", format(SPELL_RANGE, Range), ": ", SpellList);
	end
end

function PA:SearchActionBar()
	if (PA:CheckMessageLevel("Core", 5)) then
		PA:Message4("PA:SearchActionBar called");
	end
	if (_Paladin_is_Ready==true) then
		-- Look for Attack action
		PA.AttackActionId = nil;
		PA.ShootActionId = nil;
		local CanUseWands = (PA.PlayerClass=="MAGE" or PA.PlayerClass=="PRIEST" or PA.PlayerClass=="WARLOCK");
		PA:ResetTooltip();
		for Id = 1, 120 do
			if (HasAction(Id)) then
				--PA:ShowText(Id, " ", GetActionText(Id), " ", ATTACK);
				if (GetActionText(Id)==nil) then
					PanzaTooltip:SetAction(Id);
					local SlotName = PanzaTooltipTextLeft1:GetText();
					if (SlotName==ATTACK) then
						if (PA:CheckMessageLevel("Core", 5)) then
							PA:Message4("Found Attack Id="..Id);
						end
						PA.AttackActionId = Id;
					end
					if (SlotName==PANZA_SHOOT) then
						if (PA:CheckMessageLevel("Core", 5)) then
							PA:Message4("Found Shoot Id="..Id);
						end
						PA.ShootActionId = Id;
					end
					if (PA.AttackActionId~=nil and (PA.ShootActionId~=nil or not CanUseWands)) then
						break;
					end
				end
			end
		end
		if (PA:CheckMessageLevel("Core", 5)) then
			PA:Message4("Normal Range Search");
		end
		for Range, _ in pairs(PA.SpellBook.Range) do
			if (PA.ActionSearch[Range]~=nil) then
				PA.ActionId[Range] = PA:FindActionSlot(Range, "ActionSearch");
			end
		end
		if (PA:CheckMessageLevel("Core", 5)) then
			PA:Message4("Offense Range Search");
		end
		for Range, _ in pairs(PA.SpellBook.ORange) do
			if (PA.OffenseActionSearch[Range]~=nil) then
				PA.OffenseActionId[Range] = PA:FindActionSlot(Range, "OffenseActionSearch");
			end
		end
		if (PA:CheckMessageLevel("Core", 5)) then
			PA:Message4("Special Range Search");
		end
		for Short, _ in pairs(PA.SpellBook.SRange) do
			PA.SpecialActionId[Short] = PA:FindActionSlot(nil, Short);
			--PA:ShowText("Adding special range for ", Short, " id=", PA.SpecialActionId[Short]);
		end
		PA:InformActionRangeStatus();
	else
		if (PA:CheckMessageLevel("Core", 3)) then
			PA:Message4("Can't do Action Bar scan yet, not ready.");
		end
	end
end

function PA:InformActionRangeStatus()
	if (_Paladin_is_Ready==true) then
	
		for Range, Id in pairs(PA.ActionId) do
			if (PA:CheckMessageLevel("Core", 5)) then
				PA:Message4("Range "..Range.." Id="..Id);
			end
		end
		for Range, Id in pairs(PA.OffenseActionId) do
			if (PA:CheckMessageLevel("Core", 5)) then
				PA:Message4("ORange "..Range.." Id="..Id);
			end
		end
		for Short, Id in pairs(PA.SpecialActionId) do
			if (PA:CheckMessageLevel("Core", 5)) then
				PA:Message4("Special "..Short.." Id="..Id);
			end
		end
		
		if (PASettings.Switches.UseActionRange.Heal==true
		 or PASettings.Switches.UseActionRange.Bless==true
		 or PASettings.Switches.UseActionRange.Cure==true
		 or PASettings.Switches.UseActionRange.Free==true) then
			for Range, _ in pairs(PA.SpellBook.Range) do
				if (PA.ActionId[Range]==nil) then
					if (PA:CheckMessageLevel("Core", 1)) then
						PA:Message4(format(SPELL_RANGE, Range).." ("..ACTIONBAR_LABEL..") "..ADDON_MISSING..". Add spell/macro "..PA.ActionSearch[Range].." to any action bar.");
					end
				end
			end
		end
		-- Rez is a special case as only corpses give proper range check
		if (PASettings.Switches.UseActionRange.Rez==true and PA:SpellInSpellBook("rez")) then
			if (PA.SpecialActionId["rez"]==nil) then
				if (PA:CheckMessageLevel("Core", 1)) then
					PA:Message4("Resurrect ("..ACTIONBAR_LABEL..") "..ADDON_MISSING..". Add spell/macro "..PA:GetSpellProperty("rez", "Name").."/Rez to any action bar.");
				end
			end
		end
		if (PASettings.Switches.UseActionRange.Offense==true) then
			-- Check offensive spell ranges, and warn if missing
			for Range, _ in pairs(PA.SpellBook.ORange) do
				if (PA.OffenseActionId[Range]==nil) then
					if (PA:CheckMessageLevel("Core", 1)) then
						PA:Message4("Offense "..format(SPELL_RANGE, Range).." ("..ACTIONBAR_LABEL..") "..ADDON_MISSING..". Add spell/macro "..PA.OffenseActionSearch[Range].." to any action bar.");
					end
				end
			end
			-- Exorcism is a special case as only undead/demon targets give proper range check
			if (PA:SpellInSpellBook("exo")) then
				if (PA.SpecialActionId["exo"]==nil) then
					if (PA:CheckMessageLevel("Core", 1)) then
						PA:Message4("Offense Exo ("..ACTIONBAR_LABEL..") "..ADDON_MISSING..". Add spell "..PA:GetSpellProperty("exo", "Name").." to any action bar.");
					end
				end
			end

		end
	end
end

function PA:CheckActionSlot(id, range, set)
	local infoText, spellList, macroList;
	local Match;
	if (PA:CheckMessageLevel("Core", 4)) then
		--PA:Message4("(CheckActionSlot) id="..id.." range="..tostring(range).." set="..tostring(set));
	end
	if (range==nil) then
		PA:Debug(id, " CheckActionSlot Special, spell=", set);
		infoText = set;
		spellList = PA:GetSpellProperty(set, "Name");
		macroList = PA.MacroSpecials[set];
	else
		infoText = format(SPELL_RANGE, range);
		if (set~=nil and range~=nil) then
			spellList = PA[set][range];
		end
	end
	if (id~=nil and HasAction(id) and spellList~=nil) then
		local ActionText = GetActionText(id);
		if (ActionText==nil) then
			PA:ResetTooltip();
			PanzaTooltip:SetAction(id);
			local SlotName = PanzaTooltipTextLeft1:GetText();
			if (id<6) then
				if (PA:CheckMessageLevel("Core", 5)) then
					PA:Message4("(CheckActionSlot) "..id.." SlotName="..tostring(SlotName));
				end
			end
			if (SlotName~=nil) then
				local Start = string.find(spellList, SlotName);
				if (id<6) then
					if (PA:CheckMessageLevel("Core", 5)) then
						PA:Message4("(CheckActionSlot) spellList="..spellList);
						PA:Message4("(CheckActionSlot) SlotName="..SlotName);
						PA:Message4("(CheckActionSlot) Find="..tostring(Start));
					end
				end
				if (Start~=nil) then
					if (PA:CheckMessageLevel("Core", 5)) then
						PA:Message4("(CheckActionSlot) Found spell in action Slot="..id.." for "..infoText.." ("..SlotName..")", "");
					end
					return true;
				end
			end
		else
			PA:Debug(id.." spellList=", spellList, "  ActionText=", ActionText);
			-- Macro
			local _, _, Body = GetMacroInfo(GetMacroIndexByName(ActionText));
			if (Body~=nil) then
				local _, _, PaId = string.find(Body, "PA_ID=>(%w+)<");
				if (PaId~=nil) then
					if (PA:CheckMessageLevel("Core", 5)) then
						--PA:Message4("(CheckActionSlot) Found Panza macro PA_ID="..PaId);
					end
					if (macroList~=nil) then
						for Id, _ in pairs(macroList) do
							PA:Debug("Looking for Id=", Id);
							if (PaId==Id) then
								if (PA:CheckMessageLevel("Core", 5)) then
									PA:Message4("(CheckActionSlot) Found macro in action Slot="..id.." for "..infoText.." ("..ActionText..")");
								end
								return true;
							end
						end
					end
					local Start = string.find(spellList, PaId);
					PA:Debug("  PaId=", PaId, "  Find=", Start);
					if (Start~=nil) then
						if (PA:CheckMessageLevel("Core", 5)) then
							PA:Message4("(CheckActionSlot) Found macro in action Slot="..id.." for "..infoText.." ("..ActionText..")");
						end
						return true;
					end
				end
			end
		end
	end
	return false;
end

function PA:FindActionSlot(range, set)
	if (PA:CheckMessageLevel("Core", 5)) then
		PA:Message4("(FindActionSlot) Searching for "..tostring(range).." yard action bar set="..tostring(set));
	end
	for Id = 1, 120 do
		if (PA:CheckActionSlot(Id, range, set)) then
			return Id;
		end
	end
	return nil;
end

function PA:UpdateActionForSlot(id)

	if (PASettings.Switches.UseActionRange.Heal==false
	 and PASettings.Switches.UseActionRange.Bless==false
	 and PASettings.Switches.UseActionRange.Cure==false
	 and PASettings.Switches.UseActionRange.Free==false) then
		if (PA:CheckMessageLevel("Core", 5)) then
			PA:Message4("No check required, feature off");
		end
		return; -- no need to check action slots
	end

	local Relevant = false;
	for Range, _ in pairs(PA.SpellBook.Range) do
		if (PA.ActionId[Range]==nil or PA.ActionId[Range]==id) then
			Relevant = true;
			break;
		end
	end
	if (not Relevant) then
		for Range, _ in pairs(PA.SpellBook.ORange) do
			if (PA.OffenseActionId[Range]==nil or PA.OffenseActionId[Range]==id) then
				Relevant = true;
				break;
			end
		end
		if (not Relevant) then
			for Short, _ in pairs(PA.SpellBook.SRange) do
				if (PA.SpecialActionId[Short]==nil or PA.SpecialActionId[Short]==id) then
					Relevant = true;
					break;
				end
			end
		end
	end

	if (not Relevant) then
		if (PA:CheckMessageLevel("Core", 5)) then
			PA:Message4("No check required, all ok");
		end
		return; -- no need to check action slots
	end

	local ActionDrop = (HasAction(id)~=nil);
	if (PA:CheckMessageLevel("Core", 5)) then
		PA:Message4("ActionDrop="..tostring(ActionDrop));
	end

	if (ActionDrop) then
		Relevant = false;
		if (PA:CheckMessageLevel("Core", 5)) then
			PA:Message4("Relevancy check Normal");
		end
		for Range, _ in pairs(PA.SpellBook.Range) do
			if (PA:CheckMessageLevel("Core", 5)) then
				PA:Message4("Call CheckActionSlot id="..id.." Range="..tostring(Range));
			end
			if (PA:CheckActionSlot(id, Range, "ActionSearch")) then
				Relevant = true;
				break;
			end
		end
		if (not Relevant) then
			if (PA:CheckMessageLevel("Core", 5)) then
				PA:Message4("Relevancy check Offense");
			end
			for Range, _ in pairs(PA.SpellBook.ORange) do
				if (PA:CheckMessageLevel("Core", 5)) then
					PA:Message4("Call CheckActionSlot id="..id.." Range="..tostring(Range));
				end
				if (PA:CheckActionSlot(id, Range, "OffenseActionSearch")) then
					Relevant = true;
					break;
				end
			end
			if (not Relevant) then
				if (PA:CheckMessageLevel("Core", 5)) then
					PA:Message4("Relevancy check Specials");
				end
				for Short, _ in pairs(PA.SpellBook.SRange) do
					if (PA:CheckMessageLevel("Core", 5)) then
						PA:Message4("Call CheckActionSlot id="..id.." spell="..tostring(Short));
					end
					if (PA:CheckActionSlot(id, nil, Short)) then
						Relevant = true;
						break;
					end
				end
			end
		end
	end

	if (not Relevant) then
		if (PA:CheckMessageLevel("Core", 5)) then
			PA:Message4("No check required, not relevant");
		end
		return; -- no need to check action slots
	end

	if (PA:CheckMessageLevel("Core", 5)) then
		PA:Message4("Signal action bar rescan");
	end
	UpdateSpells();
	PA.UpdateActionBar = {Timer=0, Changed=true};
end

function PA:ActionInRangeNonTarget(unit, set)
	-- Action bars only work on current target
	-- Remember the old target and combat state to switch back when finished range check
	-- Combat switch is done via the PLAYER_LEAVE_COMBAT event
	-- TargetFrame so removing sound and target updating in the UI, although
	-- player has a new target for action checking (Zdrumpi)
	if (set==nil) then
		set = "ActionId";
	end
	local InRange = {};
	if (PA:CheckMessageLevel("Core", 5)) then
		PA:Message4("Targeting "..unit.." for Action check");
	end
	local InCombat = PA.InCombat;
	if (PA:CheckMessageLevel("Core", 5)) then
		PA:Message4("Combat ="..tostring(InCombat));
	end
	local OldTarget = PA:UnitName("target");

	-- Temporarily turn off target update code, for speed
	local PA_TargetFrame_Update = TargetFrame_Update;
	TargetFrame_Update = PA_DummyTargetFrame_Update;

	local Status, Err = pcall(PA_ActionInRangeNonTarget_Safe, InRange, unit, set, OldTarget, InCombat);

	-- Restore target update code
	TargetFrame_Update = PA_TargetFrame_Update;
	PA_TargetFrame_Update = nil;

	if (not Status) then
		PA:ShowText(PA_RED.."Error in target protected call: ", Err);
	end

	return InRange;
end

function PA_ActionInRangeNonTarget_Safe(inRange, unit, set, oldTarget, inCombat)
	if unexpected_condition then error() end
	TargetUnit(unit);
	if (set=="SpecialActionId") then
		for Short, _ in pairs(PA[set]) do
			inRange[Short] = PA:ActionInRange(nil, Short);
		end
	else
		for Range, _ in pairs(PA[set]) do
			inRange[Range] = PA:ActionInRange(Range, set);
		end
	end
	if (oldTarget==nil) then
		ClearTarget();
	elseif (oldTarget~="target" and oldTarget~=PA:UnitName("target")) then
		TargetLastTarget();
		PA.ForceCombat = (inCombat and UnitCanAttack("player", "target"));
	end
end
----------------------------------------
-- Check for in range via action buttons
----------------------------------------
function PA:ActionInRange(maxRange, set, valid)
	PA:Debug("==ActionInRange==");
	local ActionId;
	local ActionText;
	if (maxRange==nil) then
		PA:Debug("Set=SpecialActionId");
		ActionId = PA.SpecialActionId[set];
		ActionText = set;
	else
		PA:Debug("Set=", set);
		if (set==nil) then
			set = "ActionId";
		end
		ActionId = PA[set][maxRange];
		ActionText = maxRange.." yards"
	end
	PA:Debug("Checking range ", maxRange,  " ID=", ActionId);
	if (ActionId==nil) then
		return nil;
	end
	local InRange = IsActionInRange(ActionId);
	PA:Debug("InRange=", InRange);
	if (InRange==1 or (valid==true and maxRange==nil and InRange==nil)) then
		if (PA:CheckMessageLevel("Core", 5)) then
			PA:Message4("Action check "..ActionText..", in-range");
		end
		PA:Debug("Action check "..ActionText..", in-range");
		return true;
	end
	if (PA:CheckMessageLevel("Core", 5)) then
		PA:Message4("Action check "..ActionText..", out-of-range");
	end
	PA:Debug("Action check "..ActionText..", out-of-range");
	return false;
end

function PA:ActionInRangeTarget(unit, maxRange, set)
	PA:Debug("PA:ActionInRangeTarget unit=", unit, " Range=", maxRange)
	if (UnitIsUnit("target", unit)) then
		return PA:ActionInRange(maxRange, set);
	end
	return nil;
end

function PA:DistanceCheck(checkActionRange, unit, maxRange, inBG)

	PA:Debug("  DistanceCheck checkActionRange=", checkActionRange, " unit=", unit, " maxRange=", maxRange, " inBG=", inBG);
	if (maxRange~=nil) then
		maxRange = math.floor(maxRange / 10) * 10;
	end
	---------------------------------------------------------------------------------------
	-- Distance Checking
	---------------------------------------------------------------------------------------

	-- If the unit we are interested in is the current target then we can use the Action bars directly
	if (checkActionRange==true) then
		local InRange = PA:ActionInRangeTarget(unit, maxRange);
		if (InRange~=nil) then
			if (InRange) then
				return true, nil;
			else
				return false, "OutOfRange";
			end
		end
	end

	------------------------------------------------------------------------------------------------------
	-- CheckInteractDistance will check you on about 28 yards with index=4 and about 10 yards with index=2
	-- 20 Yards is for LoH, HS and DI.
	-- 30 Yards is the max range any of our buff spells have.
	-- 40 Yards for heals
	-- So if it fails CheckInteractDistance, use range (or action bars) to get the extra yards back.
	------------------------------------------------------------------------------------------------------
	local CertainInRange = false;
	if (maxRange and maxRange<30) then
		if (CheckInteractDistance(unit, 4)==1) then
			CertainInRange = (CheckInteractDistance(unit, 2)==1); -- Less than 10 yards
		else
			if (PA:CheckMessageLevel("Core", 2)) then
				PA:Message4(format(PANZA_NAME_TOO_FAR_AWAY, unit));
			end
			return false, "OutOfRange"; -- More than 28 yards
		end
	else
		CertainInRange = (CheckInteractDistance(unit, 4)==1); -- Less than 28 yards
	end
	PA:Debug("    CertainInRange=", CertainInRange);

	local HasCoords = false; --(GetPlayerMapPosition("player")~=0 and not inBG);
	PA:Debug("    HasCoords=", HasCoords);

	if (not CertainInRange) then
		if (HasCoords and (UnitPlayerOrPetInRaid(unit) or UnitPlayerOrPetInParty(unit) or UnitIsUnit("player", unit))) then
			local range = PA:RangeToUnit(unit);
			PA:Debug("    range=", range);
			if (range~=nil and MaxRange~=nil) then
				if (range>maxRange) then
					if (PA:CheckMessageLevel("Core", 2)) then
						PA:Message4(format(PANZA_NAME_TOO_FAR_AWAY, unit));
					end
					return false, "OutOfRange";
				elseif (range>0) then
					return true, nil;
				end
			end
		end
		if (checkActionRange) then
			--PA:Debug("DistanceCheck InRangeAll");
			local InRangeAll = PA:ActionInRangeNonTarget(unit);
			--PA:Debug("InRangeAll[", maxRange, "]=", InRangeAll[maxRange]);
			if (InRangeAll[maxRange]==false) then
				if (PA:CheckMessageLevel("Core", 2)) then
					PA:Message4(format(PANZA_NAME_TOO_FAR_AWAY, unit));
				end
				return false, "OutOfRange";
			end
			return InRangeAll[maxRange], nil;
		end
		return nil, nil;
	end
	return true, nil;
end

-- Try to determine if a given spell is castable on a unit
function PA:SpellCastableCheck(unit, spell, checkActionRange)

	PA:Debug("SpellCastableCheck unit=", unit, " spell=", spell, " checkActionRange=", checkActionRange);
	
	if (spell==nil or unit==nil or not UnitExists(unit)) then
		return false;
	end

	if (UnitIsUnit(unit, "player")) then
		return true;
	end
	
	if (UnitPlayerOrPetInRaid(unit) or UnitPlayerOrPetInParty(unit)) then
		return PA:SpellCastableCheckPartyRaid(unit, spell);
	end
	
	PA:Debug("  not in party/raid reverting to ActionBar check");
	
	local MaxRange = PA:GetSpellProperty(spell, "Range");
	return PA:DistanceCheck(checkActionRange, unit, MaxRange, PA:IsInBG());
end

-- Try to determine if a given spell is castable on a Party/Raid member
function PA:SpellCastableCheckPartyRaid(unit, spell)

	PA:Debug("SpellCastableCheckPartyRaid");
	
	unit = string.lower(unit);
	if (unit~="player" and string.sub(unit, 1, 4)~="raid" and string.sub(unit, 1, 5)~="party") then
		local StandardUnit = PA:FindUnitFromTarget(unit);
		if (StandardUnit==nil) then
			return false, "Unit not found"; -- Should have been found
		end
		unit = StandardUnit;
		PA:Debug("Standard Unit=", unit);
	end
	
	local Retarget = false;
	if (PA:UnitIsMyFriend("target")) then
		Retarget = true;
		ClearTarget();
	end
	if (SpellIsTargeting()) then
		SpellStopTargeting();
	end

    -- Cast the check spell
	if (PA:SpellInSpellBook(spell)) then
		local SpellToCast = PA:CombineSpell(PA.SpellBook[spell].Name, PA.SpellBook[spell].MinRank);
		PA:Debug("  SpellToCast=", SpellToCast);
		PA:CastingBarToggle("off");
		CastSpellByName(SpellToCast);
	else
		if (PA:CheckMessageLevel("Core",2)) then
			PA:Message4("Spell not in SpellBook.");
		end
		return false;
	end	
	
	local CanTarget = false;
	if (SpellIsTargeting()) then
		if (SpellCanTargetUnit(unit)) then
			CanTarget = true;
			PA:Debug("  SpellCanTargetUnit: CAN");
		else
			PA:Debug("  SpellCanTargetUnit: Can NOT");
		end

		-- Clear test spell
		if (SpellIsTargeting()) then
			SpellStopTargeting();
		end
	else
		PA:Debug("  Not targetting");
	end
	-- Retarget original target
	if (Retarget) then
		TargetLastTarget();
		PA.ForceCombat = (InCombat and UnitCanAttack("player", "target"));
	end

    local State = nil;
    if (not CanTarget) then
    	State = "Out of range or Line of Sight";
    end
    
    PA:CastingBarToggle("on");
    return CanTarget, State;
end

--------------------------------------------------
-- When Dialog checkbox is used, disable or enable
--------------------------------------------------
function PA:UpdateStockCastingBar()
	if (PASettings.Switches.CastBar.enabled==false) then
		PASettings.Switches.CastBar.enabled=true;
		PA:CastingBar(CastingBarFrame, "off", true);
		PASettings.Switches.CastBar.enabled=false;
	else
		PA:CastingBar(CastingBarFrame, "on", true);
	end	
end		

-----------------------------------
-- Wrapper Function for CastingBars
-----------------------------------
function PA:CastingBarToggle(action)
	if (not action or (action~="on" and action~="off")) then
		return;
		
	-- check for eCastingBar	
	elseif (eCastingBar~=nil and PASettings.Switches.CastBar.enabled==false) then
		PA:CastingBar(eCastingBar, action, false);
		
	-- Otherwise toggle the stock bar	
	elseif (CastingBarFrame~=nil and PASettings.Switches.CastBar.enabled==true) then
		PA:CastingBar(CastingBarFrame, action, true);
	end
end	
	
------------------------------------------------------------------	
-- Function to enable/disable Casting bar passed during SpellCheck 
------------------------------------------------------------------
function PA:CastingBar(frame, action, stockbar)
	if (not action or (action~="on" and action~="off")) then
		return;
	elseif (action=="off" and frame~=nil and PASettings.Switches.CastBar.enabled==stockbar) then
		PA:Debug("Disabling Casting Bar.");
		frame:UnregisterEvent("SPELLCAST_START");
		frame:UnregisterEvent("SPELLCAST_STOP");
		frame:UnregisterEvent("SPELLCAST_DELAYED");
		frame:UnregisterEvent("SPELLCAST_FAILED");
		frame:UnregisterEvent("SPELLCAST_INTERRUPTED");		
		if (stockbar==true) then frame:Hide(); end	
		
	elseif (action=="on" and frame~=nil and PASettings.Switches.CastBar.enabled==stockbar) then
		PA:Debug("Enabling Casting Bar");
    	frame:RegisterEvent("SPELLCAST_START");
    	frame:RegisterEvent("SPELLCAST_DELAYED");
    	frame:RegisterEvent("SPELLCAST_FAILED");
    	frame:RegisterEvent("SPELLCAST_INTERRUPTED");
    	frame:RegisterEvent("SPELLCAST_STOP");
    end		
end
