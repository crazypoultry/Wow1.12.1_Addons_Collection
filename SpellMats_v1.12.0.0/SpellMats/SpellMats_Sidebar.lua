--------------------------------------------------------------------------
-- SpellMats_Sidebar.lua
--------------------------------------------------------------------------
--[[
Telo's Sidebar support for SpellMats

author: <zespri@mail.ru>

--]]--

-- The hooks are there so that Telo's Sidebar code that writes numbers in the bottom left corner of an action
-- button doesn't overwrite what we have written there.
function SpellMats_Sidebar_HookUnhook(enable)
	if (SideBarButton_UpdateCount) then
		if (enable) then		
			Sea.util.hook("SideBarButton_UpdateCount", "SpellMats_SideBarButton_UpdateCount", "after");
		else
			Sea.util.unhook("SideBarButton_UpdateCount", "SpellMats_SideBarButton_UpdateCount", "after");
		end
	end
end

-- This hook makes sure that if Telo's Sidebar overwrites our counts we write them back
function SpellMats_SideBarButton_UpdateCount()
	SpellMats_UpdateCountAfterHandler(getglobal(this:GetName().."Count"), SideBarButton_GetID(this));
end

SpellMats_Sidebar_Buttons =
{
  {name = "SideBarButton"; start = 1; stop = 24;};
}

-- Update Telo's Sidebar Buttons
function SpellMats_Sidebar_RefreshCountButtons()
	if (SideBarButton_UpdateCount) then
		SpellMats_IterateButtonTable(SpellMats_Sidebar_Buttons, SpellMats_Sidebar_GetUpdateCountButtonArguments);
	end
end

-- This function retrieve arguments for subsequent SpellMats_UpdateCountButton call
-- for Telo's Sidebar
function SpellMats_Sidebar_GetUpdateCountButtonArguments(buttonName)
	local text = getglobal(buttonName.."Count");
	local button = getglobal(buttonName);
	local pagedId = SideBarButton_GetID(button);
	return text, pagedId;
end

SpellMats_RegisterBarSupport("Sidebar", SpellMats_Sidebar_HookUnhook, SpellMats_Sidebar_RefreshCountButtons);
