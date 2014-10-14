--------------------------------------------------------------------------
-- SpellMats_Flexbar.lua
--------------------------------------------------------------------------
--[[
Flexbar support for SpellMats

author: <zespri@mail.ru>

--]]--

-- The hooks are there so that Flexbar code that writes numbers in the bottom left corner of an action
-- button doesn't overwrite what we have written there.
function SpellMats_Flexbar_HookUnhook(enable)
	if (FlexBarButton_UpdateCount) then
		if (enable) then		
			Sea.util.hook("FlexBarButton_UpdateCount", "SpellMats_FlexBarButton_UpdateCount", "after");
		else
			Sea.util.unhook("FlexBarButton_UpdateCount", "SpellMats_FlexBarButton_UpdateCount", "after");
		end
	end
end

-- This hook makes sure that if Flexbar overwrites our counts we write them back
function SpellMats_FlexBarButton_UpdateCount(button)
	SpellMats_UpdateCountAfterHandler(getglobal(button:GetName().."Count"), FlexBarButton_GetID(button));
end

SpellMats_Flexbar_Buttons =
{
  {name = "FlexBarButton"; start = 1; stop = 120;};
}

-- Update Flexbar Buttons
function SpellMats_Flexbar_RefreshCountButtons()
	if (FlexBarButton_UpdateCount) then
		SpellMats_IterateButtonTable(SpellMats_Flexbar_Buttons, SpellMats_Flexbar_GetUpdateCountButtonArguments);
	end
end

-- This function retrieve arguments for subsequent SpellMats_UpdateCountButton call
-- for Flexbar
function SpellMats_Flexbar_GetUpdateCountButtonArguments(buttonName)
	local text = getglobal(buttonName.."Count");
	local button = getglobal(buttonName);
	local pagedId = FlexBarButton_GetID(button);
	return text, pagedId;
end

SpellMats_RegisterBarSupport("Flexbar", SpellMats_Flexbar_HookUnhook, SpellMats_Flexbar_RefreshCountButtons);

