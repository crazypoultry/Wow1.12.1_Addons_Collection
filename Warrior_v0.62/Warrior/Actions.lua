WARRIOR.Actions = {}
WARRIOR.Actions._enabled = true;

-- *****************************************************************************
-- Function: Activate
-- Purpose: activate the hooks for the action bars
-- *****************************************************************************
function WARRIOR.Actions:Activate()
	if (WARRIOR_oldUseAction or not self._enabled) then return; end
	
	WARRIOR.Utils:Hook("UseAction",function(slot,checkcursor,onself)
		-- it is a spell that was pressed and not an item or a macro
		if (HasAction(slot) and not GetActionText(slot)) then

			-- find the name for the spell in that slot
			local spell = nil;
			for _,value in WARRIOR.Spells._spellbook do
				if (value.slot == slot) then 
					spell = value;
					do break end;
				end
			end

			-- check to see if we are in the right stance
			if (spell and WARRIOR.Player.Stances:Verify(spell.name)) then
				WARRIOR.Utils:Debug(3,"UseAction: changing to %s for %s.",spell.stance.primary,spell.name);
				return WARRIOR.Spells:Cast(spell.stance.primary);
			end
		end

		-- cast the original item/macro/spell
		WARRIOR_oldUseAction(slot,checkcursor,onself);
	end);
end

-- *****************************************************************************
-- Function: Deactivate
-- Purpose: deactivate the hooks for the action bars
-- *****************************************************************************
function WARRIOR.Actions:Deactivate()
	if (WARRIOR_oldUseAction) then WARRIOR.Utils:UnHook("UseAction"); end
end
