--[[
	DynamicData

	By sarf

	This mod allows you to access dynamic data in WoW without being forced to rely on strange Blizzard functions

	Thanks goes to the Cosmos team, the nice (but strange) people at #cosmostesters and Blizzard.
	
	CosmosUI URL:
	http://www.cosmosui.org/forums/viewtopic.php?t=NOT_YET_ANNOUNCED
	
   ]]

function DynamicDataActionScriptFrame_OnLoad()
	-- action events
	this:RegisterEvent("ACTIONBAR_SLOT_CHANGED");
	
	DynamicData.action.OnLoad();
end

function DynamicDataActionScriptFrame_OnEvent(event)
	-- action events
	if ( event == "ACTIONBAR_SLOT_CHANGED" ) then
		if ( arg1 == -1 ) then
			DynamicData.action.updateActions();
		else
			DynamicData.action.updateActions(arg1);
		end
	end
end

