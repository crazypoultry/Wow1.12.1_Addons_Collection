--------------------------------------------------------------------------
-- SpellMats_Khaos.lua
--------------------------------------------------------------------------
--[[
SpellMats

author: <zespri@mail.ru>

-- Khaos registration support for SpellMats. Allows SpellMats to be dispalyed in Khaos menu.

--]]--

function SpellMats_Register_Khaos()
	local optionSet = {
		id="SpellMats";
		text=SPELLMATS_CONFIG_HEADER;
		helptext=SPELLMATS_CONFIG_HEADER_INFO;
		difficulty=1;
		default = true;
		callback=function(checked) SpellMats_Toggle(checked); end;
		feedback=function(state) return SPELLMATS_TOGGLE_INFO; end;
		options={
			{
				id="SpellMatsHeader";
				text=SPELLMATS_CONFIG_HEADER;
				helptext=SPELLMATS_CONFIG_HEADER_INFO;
				type=K_HEADER;
				difficulty=1;
				default = true;
			};
			{
				id="EnableFastUpdate";
				type=K_TEXT;
				text=SPELLMATS_FASTUPDATE;
				helptext=SPELLMATS_FASTUPDATE_INFO;
				callback=function(state) SpellMats_ToggleFastUpdate(state.checked); end;
				feedback=function(state) return SPELLMATS_FASTUPDATE_INFO; end;
				check=true;
				default={checked=false};
				disabled={checked=false};
				difficulty=3;
			};
		};
	};
	Khaos.registerOptionSet(
		"inventory",
		optionSet
	);
end
