--[[
	DynamicData

	By sarf

	This mod allows you to access dynamic data in WoW without being forced to rely on strange Blizzard functions

	Thanks goes to the Cosmos team, the nice (but strange) people at #cosmostesters and Blizzard.
	
	CosmosUI URL:
	http://www.cosmosui.org/forums/viewtopic.php?t=NOT_YET_ANNOUNCED
	
   ]]

function DynamicDataSpellScriptFrame_OnLoad()
	-- spell events
	this:RegisterEvent("SPELLS_CHANGED");
	this:RegisterEvent("LEARNED_SPELL_IN_TAB");

	DynamicData.spell.OnLoad();
end

function DynamicDataSpellScriptFrame_OnEvent(event)
	-- spell events
	if ( (event == "SPELLS_CHANGED") or ( event == "LEARNED_SPELL_IN_TAB") ) then
		DynamicData.spell.updateSpells();
		return;
	end
end

