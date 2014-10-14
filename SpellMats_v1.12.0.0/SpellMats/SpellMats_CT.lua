--------------------------------------------------------------------------
-- SpellMats_CT.lua
--------------------------------------------------------------------------
--[[
CT_BarMod support for SpellMats

author: <zespri@mail.ru>

--]]--

-- The hooks are there so that CT_BarMod code that writes numbers in the bottom left corner of an action
-- button doesn't overwrite what we have written there.
function SpellMats_CT_HookUnhook(enable)
	if (CT_ActionButton_UpdateCount) then
		if (enable) then		
			Sea.util.hook("CT_ActionButton_UpdateCount", "SpellMats_CT_ActionButton_UpdateCount", "after");
		else
			Sea.util.unhook("CT_ActionButton_UpdateCount", "SpellMats_CT_ActionButton_UpdateCount", "after");
		end
	end
end

-- This hook makes sure that if CT_BarMod overwrites our counts we write them back
function SpellMats_CT_ActionButton_UpdateCount()
	SpellMats_UpdateCountAfterHandler(getglobal(this:GetName().."Count"), CT_ActionButton_GetPagedID(this));
end

SpellMats_CT_Buttons =
{
  {name = "CT_ActionButton"; start = 1; stop = 12;};
  {name = "CT2_ActionButton"; start = 1; stop = 12;};
  {name = "CT3_ActionButton"; start = 1; stop = 12;};
  {name = "CT4_ActionButton"; start = 1; stop = 12;};
  {name = "CT5_ActionButton"; start = 1; stop = 12;};
}

-- Update CT_BarMod Bars
function SpellMats_CT_RefreshCountButtons()
	-- if CT is installed update CT buttons
	if (CT_ActionButton_UpdateCount) then
		SpellMats_IterateButtonTable(SpellMats_CT_Buttons, SpellMats_CT_GetUpdateCountButtonArguments);
	end
end

-- This function retrieve arguments for subsequent SpellMats_UpdateCountButton call
-- for CT_BarMod
function SpellMats_CT_GetUpdateCountButtonArguments(buttonName)
	local text = getglobal(buttonName.."Count");
	local button = getglobal(buttonName);
	local pagedId = CT_ActionButton_GetPagedID(button);
	return text, pagedId;
end

SpellMats_RegisterBarSupport("CT", SpellMats_CT_HookUnhook, SpellMats_CT_RefreshCountButtons);
