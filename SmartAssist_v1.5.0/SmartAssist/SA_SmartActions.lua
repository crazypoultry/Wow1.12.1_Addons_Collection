-------------------------------------------------------------------------------
-- SMART ACTIONS
-------------------------------------------------------------------------------

local old_UseAction = UseAction;
function UseAction(m1, m2, m3)

	local name = SA_GetSlotName(m1);
	local assistAction = false;
	if (SA_TableIndex(SA_OPTIONS.AssistSpells, name) ~= -1) then
		assistAction = true;
	end

	-- no target selected and attack action
	-- treat targetting player as no target
	if (SA_OPTIONS.TriggerAssist and (UnitName("target")==nil or UnitIsUnit("target","player")) and assistAction) then
		SA_Debug("no target, initiating assist by action!", 1);
		FindTarget(nil, false, false, SA_OPTIONS.TriggerAssistPreventOOC);
		-- target is not player selected so don't attack unless target already in combat
		if (not UnitAffectingCombat("target")) then
			SA_Debug("not in combat, aborting action", 1);
			SA_ShowWarning();
			return; 
		end
	end
	
	-- if trying to attack friendly unit, initiate smart action
	
	-- UnitIsFriend bugs when dueling people in your party
	-- Added UnitPlayerControlled because on pve server as non flagged attacking the opposite faction initiated assist!
	if (assistAction and not UnitCanAttack("target", "player") and not (UnitPlayerControlled("target") and UnitFactionGroup("player")~=UnitFactionGroup("target"))) then
		SA_Debug("friendly target, assistAction = "..tostring(assistAction), 1);
		if (UnitCanAttack("player", "targettarget")) then
			SA_Debug("friendly target, assisting", 1);
			AssistUnit("target");
		else
			-- supresses annoyance when attacking and ally has no target
			if (assistAction) then 
				SA_Debug("aborting action, supressing annoyance", 1);
				return; 
			end
		end
	end
	
	return old_UseAction(m1, m2, m3);
end