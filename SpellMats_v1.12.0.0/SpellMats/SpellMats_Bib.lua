--------------------------------------------------------------------------
-- SpellMats_Bib.lua
--------------------------------------------------------------------------
--[[
BibToolbars support for SpellMats

author: <zespri@mail.ru>

--]]--

SpellMats_Bib_Buttons =
{
  {name = "BibActionButton"; start = 1; stop = 120;};
}

-- Update BibToolbars Bars
function SpellMats_Bib_RefreshCountButtons()
	if (BibActionButton1) then
		SpellMats_IterateButtonTable(SpellMats_Bib_Buttons, SpellMats_GetUpdateCountButtonArguments);
	end
end

SpellMats_RegisterBarSupport("Bib", nil, SpellMats_Bib_RefreshCountButtons);
