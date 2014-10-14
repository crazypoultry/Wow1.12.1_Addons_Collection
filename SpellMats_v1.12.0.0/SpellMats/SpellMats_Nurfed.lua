--------------------------------------------------------------------------
-- SpellMats_Nurfed.lua
--------------------------------------------------------------------------
--[[
Nurfed support for SpellMats

author: <zespri@mail.ru>

--]]--

-- The hooks are there so that Nurfed_ActionBars code that writes numbers in the bottom left corner of an action
-- button doesn't overwrite what we have written there.
function SpellMats_Nurfed_HookUnhook(enable)
	if (Nurfed_ActionBars) then
		if (enable) then		
			Sea.util.hook("Nurfed_ActionBars.UpdateCount", "SpellMats_Nurfed_ActionButton_UpdateCount", "after");
		else
			Sea.util.unhook("Nurfed_ActionBars.UpdateCount", "SpellMats_Nurfed_ActionButton_UpdateCount", "after");
		end
	end
end

-- This hook makes sure that if Nurfed overwrites our counts we write them back
function SpellMats_Nurfed_ActionButton_UpdateCount(obj)
	SpellMats_UpdateCountAfterHandler(getglobal(this:GetName().."count"), this:GetID());
end

SpellMats_Nurfed_Buttons =
{
  {name = "Nurfed_ActionButton"; start = 1; stop = 120;};
}

-- Update Nurfed Bars
function SpellMats_Nurfed_RefreshCountButtons()
	-- if Nurfed is installed update Nurfed buttons
	if (Nurfed_ActionBars) then
		SpellMats_IterateButtonTable(SpellMats_Nurfed_Buttons, SpellMats_Nurfed_GetUpdateCountButtonArguments);
	end
end

-- This function retrieve arguments for subsequent SpellMats_UpdateCountButton call
-- for Nurfed
function SpellMats_Nurfed_GetUpdateCountButtonArguments(buttonName)
	local text = getglobal(buttonName.."count");
	local button = getglobal(buttonName);
	local pagedId;
	if (button) then
		pagedId = button:GetID();
	end
	return text, pagedId;
end

SpellMats_RegisterBarSupport("Nurfed", SpellMats_Nurfed_HookUnhook, SpellMats_Nurfed_RefreshCountButtons);
