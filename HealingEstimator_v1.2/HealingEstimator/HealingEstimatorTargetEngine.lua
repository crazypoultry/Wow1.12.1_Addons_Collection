-- Separate file to resolve spell target and spell rank

-- Values
local DebugMsg=false;			-- If debug needs to be printed
local AquiredTarget=nil;		-- Found spell target

-- Hooked functions
local HealingEstimator_OldSpellTargetUnit;
local HealingEstimator_OldTargetUnit;
local HealingEstimator_OldCastSpell;
local HealingEstimator_OldCastSpellByName;
local HealingEstimator_OldUseAction;

--------------------------------------------------------------------
-- Initialization
--------------------------------------------------------------------

--------------------------------------------------------------------
-- Init
--
function HealingEstimator_InitTargetEngine()
	-- Hook functions
	
	-- For spell target
	-- SpellTargetUnit
	HealingEstimator_OldSpellTargetUnit = SpellTargetUnit;
	SpellTargetUnit = HealingEstimator_SpellTargetUnit;
	-- TargetUnit
	HealingEstimator_OldTargetUnit = TargetUnit;
	TargetUnit = HealingEstimator_TargetUnit;
	-- OnMouseDown / World frame
	local OldFunc = WorldFrame:GetScript("OnMouseDown");
	if (OldFunc) then
		-- Hook the old function if one already exists
		WorldFrame:SetScript("OnMouseDown", function() OldFunc(); HealingEstimator_WorldFrameOnMouseDown(); end );
	else
		WorldFrame:SetScript("OnMouseDown", HealingEstimator_WorldFrameOnMouseDown);
	end	
	
	-- For spell rank
	-- CastSpell
	HealingEstimator_OldCastSpell=CastSpell;
	CastSpell=HealingEstimator_CastSpell;
	-- CastSpellByName
	HealingEstimator_OldCastSpellByName=CastSpellByName;
	CastSpellByName=HealingEstimator_CastSpellByName;
	-- Use Action
	HealingEstimator_OldUseAction=UseAction;
	UseAction=HealingEstimator_UseAction;
end

--------------------------------------------------------------------
-- Hooked functions for aquiring the spell target
--------------------------------------------------------------------

--------------------------------------------------------------------
-- SpellTargetUnit function
-- Called when spell is selected first and unit as a second
--
function HealingEstimator_SpellTargetUnit(unit)
	-- Call the original function
	HealingEstimator_OldSpellTargetUnit(unit);
	HealingEstimator_Print(DebugMsg,"Hooked SpellTargetUnit: "..unit);
	AquiredTarget=unit;
end

--------------------------------------------------------------------
-- TargetUnit function
-- Called when unit is targeted
--
function HealingEstimator_TargetUnit(unit)
	-- Call the original function
	HealingEstimator_OldTargetUnit(unit);
	HealingEstimator_Print(DebugMsg,"Hooked TargetUnit: "..unit);
	AquiredTarget=unit;
end

--------------------------------------------------------------------
-- OnMouseDown / World frame
-- Called when mouse is clicked on 3d-screen
--
function HealingEstimator_WorldFrameOnMouseDown()
	if arg1 == "LeftButton" then
		if (UnitExists("mouseover")) then
			AquiredTarget="mouseover";	-- Default target name
			
			if (UnitIsFriend("player",AquiredTarget)) then
				AquiredTarget=HealingEstimator_GetGroupName(AquiredTarget);	-- Store it, it might change
				if (AquiredTarget==nil) then
					-- No groupname found, use "mouseover"
					AquiredTarget="mouseover"
				end
			end
			
			HealingEstimator_Print(DebugMsg,"Hooked OnMouseDown: "..AquiredTarget);
		end
	end
end

--------------------------------------------------------------------
-- Hooked functions for aquiring the spell rank
--------------------------------------------------------------------

--------------------------------------------------------------------
-- CastSpell
-- Called when spell is clicked from spellbook
--
function HealingEstimator_CastSpell(SpellId, SpellbookTab)
	HealingEstimator_OldCastSpell(SpellId, SpellbookTab);
	HealingEstimator_Print(DebugMsg,"Hooked CastSpell");

	-- Set tooltip and get data
	local Rank;
	_,Rank=GetSpellName(SpellId,SpellbookTab);	-- Get rank
	HealingEstimatorTooltip:ClearLines();
	HealingEstimatorTooltip:SetOwner(HealingEstimator,"ANCHOR_NONE");
	HealingEstimatorTooltip:SetSpell(SpellId,SpellbookTab);
	HealingEstimatorTooltipTextRight1:SetText(Rank);
	HealingEstimator_StoreSpellTarget(0);
end

--------------------------------------------------------------------
-- CastSpellByName
-- Called from scipts
--
function HealingEstimator_CastSpellByName(Name,OnSelf)
	HealingEstimator_OldCastSpellByName(Name,OnSelf);
	HealingEstimator_Print(DebugMsg,"Hooked CastSpellByName");

	-- Name is either "Flash Heal(Rank 1)" or "Flash Heal"
	-- Find the spell from spellbook
	local r,FoundRank=nil;
	for r in string.gfind(Name,HealingEstimatorLoc.RankTxt) do
		FoundRank=r;
		-- Remove the rank text
		Name=string.gsub(Name,HealingEstimatorLoc.RankTxt,"");
		break;
	end

	-- Search the biggest rank
	local SpellId=1;
	local FoundSpell=nil;
	while true do
		-- Get spell name and rank
		local TempName,TempRank = GetSpellName(SpellId,BOOKTYPE_SPELL);
		if (not TempName) then 
			-- All spells tested, exit
			break;
		end
		
		-- Check spell name
		if (Name==TempName) then
			if (FoundRank==nil or FoundRank==TempRank) then
				FoundSpell=SpellId;
			end
		end
		SpellId=SpellId+1;
	end
	
	-- If spell was found, get it's data
	HealingEstimatorTooltip:ClearLines();
	HealingEstimatorTooltip:SetOwner(HealingEstimator,"ANCHOR_NONE");
	if (FoundSpell) then
		_,TempRank=GetSpellName(FoundSpell,BOOKTYPE_SPELL);	-- Get rank
		HealingEstimatorTooltip:SetSpell(FoundSpell,BOOKTYPE_SPELL);
		HealingEstimatorTooltipTextRight1:SetText(TempRank);
		HealingEstimator_StoreSpellTarget(OnSelf);
	end
end

--------------------------------------------------------------------
-- UseAction
-- Called when some action is clicked
--
function HealingEstimator_UseAction(Slot,CheckCursor,OnSelf)
	HealingEstimator_OldUseAction(Slot,CheckCursor,OnSelf);
	HealingEstimator_Print(DebugMsg,"Hooked UseAction");

	-- Test to see if this is a macro
	if GetActionText(Slot) then 
		-- It is, bail out
		return;
	end

	-- Set tooltip and get data
	HealingEstimatorTooltip:ClearLines();
	HealingEstimatorTooltip:SetOwner(HealingEstimator,"ANCHOR_NONE");
	HealingEstimatorTooltip:SetAction(Slot);
	HealingEstimator_StoreSpellTarget(OnSelf);
end

--------------------------------------------------------------------
-- Misc functions
--------------------------------------------------------------------

--------------------------------------------------------------------
-- Stores the current spell target
--
function HealingEstimator_StoreSpellTarget(OnSelf)
	-- Check spell target
	if (OnSelf) then
		-- Spell is run with OnSelf, player will be targetted
		HealingEstimator_Print(DebugMsg,"OnSelf");
		AquiredTarget="player";

	elseif (SpellIsTargeting()) then
		-- Spell is targetting, so we are waiting for target
		HealingEstimator_Print(DebugMsg,"SpellIsTargeting");
		AquiredTarget=nil;

	else
		-- Spell is not targetting, so current target will be target
		HealingEstimator_Print(DebugMsg,"SpellHasTarget");
		AquiredTarget=HealingEstimator_GetGroupName("target");	-- Store it, it might change
		if (AquiredTarget==nil) then
			-- Target was not groupmember, use "target"
			AquiredTarget="target";
		end
	end
end

--------------------------------------------------------------------
-- Gets the spell information from tooltip
-- Returns the spell name, rank, healing average and target
--
function HealingEstimator_GetSpellInfo()
	local SpellName=nil;
	local SpellRank=0;
	local SpellHealAverage=1;

	-- Get name
	local Text=HealingEstimatorTooltipTextLeft1:GetText();
	if (Text) then
		--HealingEstimator_Print(DebugMsg,"SpellName: "..Text);
		SpellName=Text;
	end
	
	-- Get spell rank
	Text=HealingEstimatorTooltipTextRight1:GetText();
	if (Text) then
		for t1 in string.gfind(Text, HealingEstimatorLoc.RankTooltip) do
			--HealingEstimator_Print(DebugMsg,"Rank: "..t1);
			SpellRank=t1;
		end
	end
	
	-- Get spell healing average
	SpellHealAverage=1;
	Text=HealingEstimatorTooltipTextLeft4:GetText();
	if (Text) then
		for t1,t2 in string.gfind(Text, HealingEstimatorLoc.HealValue) do
			--HealingEstimator_Print(DebugMsg,"Heal: "..t1.." - "..t2);
			SpellHealAverage=(t1+t2)/2;
			break;
		end
	end

	-- Check if target was get
	local Target=AquiredTarget;

	-- Support for CastOptions
	if (CastOptions and CastOptions.SpellTarget) then
		Target = CastOptions.GetUnitType(CastOptions.SpellTarget);
		if (Target == nil) then
			Target = AquiredTarget;
		end
	end
	
	-- Clear old target
	AquiredTarget=nil;	
	HealingEstimator_Print(DebugMsg,"use: "..Target);



	-- Return data
	return SpellName,SpellRank,SpellHealAverage,Target;
end
