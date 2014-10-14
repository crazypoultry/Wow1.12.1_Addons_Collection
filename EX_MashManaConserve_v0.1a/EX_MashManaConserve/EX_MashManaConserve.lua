-- AUTHOR: Witherwill <Exigence>
--         Dragonblight
--
-- USAGE:  Make a macro for each spell you to use with mana conserve.  The macro looks like:
--      /script EX_MMC_CastSpellByName('Greater Heal', 2000)
--      The first string is the name of the spell you are casting. If you want to cast a different 
--      rank of the spell, use 'Greater Heal(Rank 1)' for example.  The second number is the amount
--      of damage your target must have for the spell to be allowed to complete.
--
--      Once you create the macro, add it to your spell bar and mash the button!  During the first
--      part of the spell, mashing will do nothing.  Near the end of the spell, the button may 
--      abort your spell if the target is already healed.
--
-- DISCLAIMER: Much code blatantly stolen from CT_RaidAssist. Thanks for CT_RASpellDetect and CT_RAMenu.
--
-- This code is provided to demonstrate how mana conserve can work. Hopefully CT or another
-- mod author will create a fancy configuration UI for this, because I just dont wanna.

---------------
-- CONSTANTS --
---------------
-- The amount of time, in seconds, before the end of the spell during which the spell
-- can be aborted by mashing the button. Change this to a larger value if you are too laggy.
EX_MMC_SpellCastDelay = 1.0; 

---------------
-- VARIABLES --
---------------
EX_MMC_MinHealthDeficit = 0;
EX_MMC_AbortCheck = false;
EX_MMC_SpellName = nil;

EX_SpellSpell = nil;
EX_SpellCast = nil;
EX_CurrCast = nil;

---------------
-- FUNCTIONS --
---------------
function EX_MMC_CastSpellByName(spell, minDeficit)
    if (not minDeficit) then
	CastSpellByName(spell);
    end

    if (spell) then
	    if (not EX_CurrCast) then
		if (not EXDetectSpellFrame.update) then
			local _, _, spellName = string.find(spell, "^([^%(]+)");
			if ( spellName ) then
				EX_MMC_SpellName = spellName;
			        EX_MMC_MinHealthDeficit = minDeficit;
			end

			if (not UnitExists("target") or UnitIsEnemy("player", "target")) then
				-- SelfCast
				CastSpellByName(spell, 1);
			else
			        CastSpellByName(spell);
			end
		end

	    elseif (EX_MMC_AbortCheck) then
	        EX_MMC_CheckTargetHealth();
	    end
    end
end


function EX_ProcessSpellCast(spellName, targetName)
	if ( spellName and targetName ) then
		EX_SpellCast = { spellName, targetName };
	end
end


function EX_MMC_CheckTargetHealth()
	if (not EX_CurrCast or IsControlKeyDown()) then 
		return; 
	end

	if ( UnitExists(EX_CurrCast[2]) and 
	     UnitHealthMax(EX_CurrCast[2]) > 100 ) then

		if (UnitHealthMax(EX_CurrCast[2]) - UnitHealth(EX_CurrCast[2]) < EX_MMC_MinHealthDeficit ) then

			EX_Print("|c00777777<EX_MMC> Aborted spell '|c00FFFFFF" .. EX_CurrCast[1] .. "|c00777777'.");
			SpellStopCasting();
			EXDetectSpellFrame.update = 0.75;
			return;
		end
	end
end

function EX_MMC_Clear()
	EX_MMC_MinHealthDeficit = 0;
	EX_MMC_AbortCheck = false;
	EX_MMC_SpellName = nil;
	EX_SpellCast =  nil;
	EX_SpellSpell =  nil;
	EX_CurrCast = nil;
end

function EX_Print(msg)
    if (msg) then
        DEFAULT_CHAT_FRAME:AddMessage(msg);
    end
end

--------------------
-- EVENT HANDLERS --
--------------------
function EX_MMC_OnUpdate(elapsed)
    if (this.update) then
        this.update = this.update - elapsed;
        if (this.update <= 0) then
		if (EX_CurrCast) then
			EX_MMC_AbortCheck = true;
		end
		this.update = nil;
        end
    end
end


function EXDetectSpells_OnLoad()
	this:RegisterEvent("SPELLCAST_START");
	this:RegisterEvent("SPELLCAST_STOP");
	--this:RegisterEvent("SPELLCAST_FAILED");
	this:RegisterEvent("SPELLCAST_INTERRUPTED");
	this:RegisterEvent("SPELLCAST_DELAYED");
end

function EXDetectSpells_OnEvent(event)
	if ( event == "SPELLCAST_START" ) then
		if ( EX_SpellCast and EX_SpellCast[1] == arg1 ) then

			if (EX_MMC_MinHealthDeficit and EX_MMC_MinHealthDeficit > 0) then
				if ( EX_MMC_SpellName == arg1 ) then
					local nr, np, hasFound = GetNumRaidMembers(), GetNumPartyMembers(), false;
					if ( UnitName("player") == EX_SpellCast[2] ) then
						EX_SpellCast[2] = "player";
						hasFound = true;
					elseif ( nr == 0 and np > 0 ) then
						for i = 1, np, 1 do
							if ( UnitName("party"..i) == EX_SpellCast[2] ) then
								EX_SpellCast[2] = "party"..i;
								hasFound = true;
								break;
							end
						end
					elseif ( nr > 0 ) then
						for i = 1, nr, 1 do
							if ( UnitName("raid"..i) == EX_SpellCast[2] ) then
								EX_SpellCast[2] = "raid"..i;
								hasFound = true;
								break;
							end
						end
					end

					if ( hasFound ) then
						EX_CurrCast = { arg1, EX_SpellCast[2], k };
						local t = (arg2/1000) - EX_MMC_SpellCastDelay;
						if ( t < 0 ) then
							t = 0;
						end
						this.update = t;
					end
					return;
				end
			end
		end
		EX_SpellCast =  nil;
		EX_SpellSpell =  nil;

	elseif (event == "SPELLCAST_INTERRUPTED" or event == "SPELLCAST_STOP" or event == "SPELLCAST_FAILED" ) then
		EX_MMC_Clear();

	elseif ( event == "SPELLCAST_DELAYED" and this.update ) then
		this.update = this.update + ( arg1 / 1000 );
	end
end

------------------------
-- FUNCTION OVERLOADS --
------------------------
EX_oldCastSpell = CastSpell;
function EX_newCastSpell(spellId, spellbookTabNum)
   -- Call the original function so there's no delay while we process
   EX_oldCastSpell(spellId, spellbookTabNum);
       
   -- Load the tooltip with the spell information
   EXDST:SetSpell(spellId, spellbookTabNum);
   
   local spellName = EXDSTTextLeft1:GetText();
       
   if ( SpellIsTargeting() ) then 
       -- Spell is waiting for a target
       EX_SpellSpell = spellName;
   elseif ( UnitExists("target") ) then
       -- Spell is being cast on the current target.  
       -- If ClearTarget() had been called, we'd be waiting target
	   EX_ProcessSpellCast(spellName, UnitName("target"));
   end
end
CastSpell = EX_newCastSpell;

EX_oldCastSpellByName = CastSpellByName;
function EX_newCastSpellByName(spellName, selfCast)
	-- Call the original function
	EX_oldCastSpellByName(spellName, selfCast)
	local _, _, spellName = string.find(spellName, "^([^%(]+)");
	if ( spellName ) then
		if ( SpellIsTargeting() ) then
			EX_SpellSpell = spellName;
		elseif (selfCast) then
			EX_ProcessSpellCast(spellName, UnitName("player"));
		else
			EX_ProcessSpellCast(spellName, UnitName("target"));
		end
	end
end
CastSpellByName = EX_newCastSpellByName;

EX_oldUseAction = UseAction;
function EX_newUseAction(a1, a2, a3)
	
	EXDST:SetAction(a1);
	local spellName = EXDSTTextLeft1:GetText();
	EX_SpellSpell = spellName;
	
	-- Call the original function
	EX_oldUseAction(a1, a2, a3);
	
	-- Test to see if this is a macro
	if ( GetActionText(a1) or not EX_SpellSpell ) then
		return;
	end
	
	if ( SpellIsTargeting() ) then
		-- Spell is waiting for a target
		return;
	elseif ( a3 ) then
		-- Spell is being cast on the player
		EX_ProcessSpellCast(spellName, UnitName("player"));
	elseif ( UnitExists("target") ) then
		-- Spell is being cast on the current target
		EX_ProcessSpellCast(spellName, UnitName("target"));
	end
end
UseAction = EX_newUseAction;

EX_oldSpellTargetUnit = SpellTargetUnit;
function EX_newSpellTargetUnit(unit)
	-- Call the original function
	local shallTargetUnit;
	if ( SpellIsTargeting() ) then
		shallTargetUnit = true;
	end
	EX_oldSpellTargetUnit(unit);
	if ( shallTargetUnit and EX_SpellSpell and not SpellIsTargeting() ) then
		EX_ProcessSpellCast(EX_SpellSpell, UnitName(unit));
		EX_SpellSpell = nil;
	end
end
SpellTargetUnit = EX_newSpellTargetUnit;

EX_oldSpellStopTargeting = SpellStopTargeting;
function EX_newSpellStopTargeting()
	EX_oldSpellStopTargeting();
	EX_SpellSpell = nil;
end
SpellStopTargeting = EX_newSpellStopTargeting;

EX_oldTargetUnit = TargetUnit;
function EX_newTargetUnit(unit)
	-- Call the original function
	EX_oldTargetUnit(unit);
	
	-- Look to see if we're currently waiting for a target internally
	-- If we are, then well glean the target info here.
	
	if ( EX_SpellSpell and UnitExists(unit) ) then
		EX_ProcessSpellCast(EX_SpellSpell, UnitName(unit));
	end
end
TargetUnit = EX_newTargetUnit;

