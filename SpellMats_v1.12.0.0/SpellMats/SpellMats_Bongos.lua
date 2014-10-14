--------------------------------------------------------------------------
-- SpellMats_Bongos.lua
--------------------------------------------------------------------------
--[[
Bongos support for SpellMats

author: <zespri@mail.ru>

--]]--

-- The hooks are there so that Bongos code that writes numbers in the bottom left corner of an action
-- button doesn't overwrite what we have written there.
function SpellMats_Bongos_HookUnhook(enable)
	if BActionButton1 then
		if (enable) then
			Sea.util.hook("BActionButton.Update", "SpellMats_Bongos_ActionButton_UpdateCount", "after");
		else
			Sea.util.unhook("BActionButton.Update", "SpellMats_Bongos_ActionButton_UpdateCount", "after");
		end
	end
end

-- This hook makes sure that if Bongos overwrites our counts we write them back
function SpellMats_Bongos_ActionButton_UpdateCount(button)
	SpellMats_UpdateCountAfterHandler(getglobal(button:GetName().."Count"), BActionButton.GetPagedID(button:GetID()));
end

SpellMats_Bongos_Buttons =
{
  {name = "BActionButton"; start = 1; stop = 120;};
}

-- Update Bongos Bars
function SpellMats_Bongos_RefreshCountButtons()
	if (BActionButton1) then
		SpellMats_IterateButtonTable(SpellMats_Bongos_Buttons, SpellMats_Bongos_GetUpdateCountButtonArguments);
	end
end


-- This function retrieve arguments for subsequent SpellMats_UpdateCountButton call
-- for Bongos
function SpellMats_Bongos_GetUpdateCountButtonArguments(buttonName)
	local text = getglobal(buttonName.."Count");
	local button = getglobal(buttonName);
	local pagedId;
	if ( button ) then
		pagedId = BActionButton.GetPagedID(button:GetID());
	end
	return text, pagedId;
end

SpellMats_RegisterBarSupport("Bongos", SpellMats_Bongos_HookUnhook, SpellMats_Bongos_RefreshCountButtons);
