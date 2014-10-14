--[[
	DynamicData

	By sarf

	This mod allows you to access dynamic data in WoW without being forced to rely on strange Blizzard functions

	Thanks goes to the Cosmos team, the nice (but strange) people at #cosmostesters and Blizzard.
	
	CosmosUI URL:
	http://www.cosmosui.org/forums/viewtopic.php?t=NOT_YET_ANNOUNCED
	
   ]]

function DynamicDataScriptFrame_OnLoad()

	-- variable events
	this:RegisterEvent("VARIABLES_LOADED");

	DynamicData.util.OnLoad();
end

function DynamicDataScriptFrame_OnEvent(event)
	-- variable events
	if ( event == "VARIABLES_LOADED" ) then
		DynamicData.util.variablesLoaded();
	end
end



function DynamicDataScriptFrame_OnUpdate(elapsed)
	DynamicData.util.notifyWhateverHandlers(DynamicData.util.onUpdateHandlers, elapsed);
end