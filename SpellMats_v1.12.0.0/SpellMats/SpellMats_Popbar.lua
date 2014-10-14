--------------------------------------------------------------------------
-- SpellMats_Popbar.lua
--------------------------------------------------------------------------
--[[
Popbar support for SpellMats

author: <zespri@mail.ru>

--]]--

-- The hooks are there so that Popbar code that writes numbers in the bottom left corner of an action
-- button doesn't overwrite what we have written there.
function SpellMats_Popbar_HookUnhook(enable)
	if (PopBarButton_UpdateCount) then
		if (enable) then		
			Sea.util.hook("PopBarButton_UpdateCount", "SpellMats_PopBarButton_UpdateCount", "after");
		else
			Sea.util.unhook("PopBarButton_UpdateCount", "SpellMats_PopBarButton_UpdateCount", "after");
		end
	end
end

-- This hook makes sure that if CT_BarMod overwrites our counts we write them back
function SpellMats_PopBarButton_UpdateCount(button)
	if (not button) then
		button = this;
	end
	SpellMats_UpdateCountAfterHandler(getglobal(button:GetName().."Count"), PopBarButton_GetPagedID(button));
end

SpellMats_Popbar_Buttons =
{
  {name = "PopBarButton10"; start = 1; stop = 9;};
  {name = "PopBarButton11"; start = 0; stop = 2;};
  {name = "PopBarButton20"; start = 1; stop = 9;};
  {name = "PopBarButton21"; start = 0; stop = 2;};
  {name = "PopBarButton30"; start = 1; stop = 9;};
  {name = "PopBarButton31"; start = 0; stop = 2;};
  {name = "PopBarButton40"; start = 1; stop = 9;};
  {name = "PopBarButton41"; start = 0; stop = 2;};
  {name = "PopBarButton50"; start = 1; stop = 9;};
  {name = "PopBarButton51"; start = 0; stop = 2;};
  {name = "PopBarButton60"; start = 1; stop = 9;};
  {name = "PopBarButton61"; start = 0; stop = 2;};
  {name = "PopBarButton70"; start = 1; stop = 9;};
  {name = "PopBarButton71"; start = 0; stop = 2;};
  {name = "PopBarButton80"; start = 1; stop = 9;};
  {name = "PopBarButton81"; start = 0; stop = 2;};
  {name = "PopBarButton90"; start = 1; stop = 9;};
  {name = "PopBarButton91"; start = 0; stop = 2;};
  {name = "PopBarButton100"; start = 1; stop = 9;};
  {name = "PopBarButton101"; start = 0; stop = 2;};
  {name = "PopBarButton110"; start = 1; stop = 9;};
  {name = "PopBarButton111"; start = 0; stop = 2;};
  {name = "PopBarButton120"; start = 1; stop = 9;};
  {name = "PopBarButton121"; start = 0; stop = 2;};
}

-- Update Popbar Buttons
function SpellMats_Popbar_RefreshCountButtons()
	if (PopBarButton_UpdateCount) then
		SpellMats_IterateButtonTable(SpellMats_Popbar_Buttons, SpellMats_Popbar_GetUpdateCountButtonArguments);
	end
end

-- This function retrieve arguments for subsequent SpellMats_UpdateCountButton call
-- for Popbar
function SpellMats_Popbar_GetUpdateCountButtonArguments(buttonName)
	local text = getglobal(buttonName.."Count");
	local button = getglobal(buttonName);
	local pagedId = PopBarButton_GetPagedID(button);
	return text, pagedId;
end

SpellMats_RegisterBarSupport("Popbar", SpellMats_Popbar_HookUnhook, SpellMats_Popbar_RefreshCountButtons);

