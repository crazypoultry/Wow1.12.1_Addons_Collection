--------------------------------------------------------------------------
-- SpellMats_DAB.lua
--------------------------------------------------------------------------
--[[
Discord Action Bars support for SpellMats

author: <zespri@mail.ru>

--]]--

-- The hooks are there so that DAB code that writes numbers in the bottom left corner of an action
-- button doesn't overwrite what we have written there.
function SpellMats_DAB_HookUnhook(enable)
	if DAB_ActionButton_UpdateCount then
		if (enable) then
			Sea.util.hook("DAB_ActionButton_UpdateCount", "SpellMats_DAB_ActionButton_UpdateCount", "after");
		else
			Sea.util.unhook("DAB_ActionButton_UpdateCount", "SpellMats_DAB_ActionButton_UpdateCount", "after");
		end
	end
end

-- This hook makes sure that if DAB overwrites our counts we write them back
function SpellMats_DAB_ActionButton_UpdateCount()
	SpellMats_UpdateCountAfterHandler(getglobal(this:GetName().."_Count"), this:GetActionID());
end

SpellMats_DAB_Buttons =
{
  {name = "DAB_ActionButton_"; start = 1; stop = 120;};
}

-- Update Discord Action Bars
function SpellMats_DAB_RefreshCountButtons()
	-- If DAB installed update DAB button
	if (DAB_ActionButton_UpdateCount) then
		SpellMats_IterateButtonTable(SpellMats_DAB_Buttons, SpellMats_DAB_GetUpdateCountButtonArguments);
	end
end

-- This function retrieve arguments for subsequent SpellMats_UpdateCountButton call
-- for Discord Action Bars
function SpellMats_DAB_GetUpdateCountButtonArguments(buttonName)
	local text = getglobal(buttonName.."_Count");
	local button = getglobal(buttonName);
	local status, pagedId = pcall(button.GetActionID, button);
	if not status then
		return;
	end
	return text, pagedId;
end

SpellMats_RegisterBarSupport("DAB", SpellMats_DAB_HookUnhook, SpellMats_DAB_RefreshCountButtons);

if (DiscordLib_Initialize) then
	Sea.util.hook("DiscordLib_Initialize", "SpellMats_RefreshCountButtons", "after");
end
