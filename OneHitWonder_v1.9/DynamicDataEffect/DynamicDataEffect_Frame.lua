--[[
	DynamicData

	By sarf

	This mod allows you to access dynamic data in WoW without being forced to rely on strange Blizzard functions

	Thanks goes to the Cosmos team, the nice (but strange) people at #cosmostesters and Blizzard.
	
	CosmosUI URL:
	http://www.cosmosui.org/forums/viewtopic.php?t=NOT_YET_ANNOUNCED
	
   ]]

DynamicData_effect_target_changed = 0;

function DynamicDataEffectScriptFrame_OnLoad()
	-- effect events
	this:RegisterEvent("UNIT_AURA");
	this:RegisterEvent("PLAYER_AURAS_CHANGED");
	this:RegisterEvent("UNIT_AURASTATE");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("PARTY_MEMBER_ENABLE");
	this:RegisterEvent("PARTY_MEMBER_DISABLE");
	this:RegisterEvent("PLAYER_PET_CHANGED");
	
	DynamicData.effect.OnLoad();
end

DynamicDataEffectScriptFrame_fixedUnits = {
	[1] = "party1",
	[2] = "party2",
	[3] = "party3",
	[4] = "party4",
};

function DynamicDataEffectScriptFrame_OnEvent(event)
	-- effect events
	if ( event == "UNIT_AURA" ) then
		DynamicData.effect.initiateUpdateEffects(arg1);
		return;
	end
	if ( event == "PLAYER_AURAS_CHANGED" ) then
		DynamicData.effect.initiateUpdateEffects("player");
		return;
	end
	if ( event == "UNIT_AURASTATE" ) then
		DynamicData.effect.initiateUpdateEffects(arg1);
		return;
	end
	if ( event == "PARTY_MEMBER_ENABLE" or event == "PARTY_MEMBER_DISABLE" ) then
		local unit = tonumber(arg1);
		if ( not unit ) then
			unit = arg1;
		else
			unit = DynamicDataEffectScriptFrame_fixedUnits[unit];
		end
		DynamicData.effect.initiateUpdateEffects(unit);
	end
	if ( event == "PARTY_MEMBERS_CHANGED" ) then
		local unit = "party";
		for i = 1, 4 do
			unit = DynamicDataEffectScriptFrame_fixedUnits[i];
			DynamicData.effect.initiateUpdateEffects(unit);
		end
		return;
	end
	if ( event == "PLAYER_PET_CHANGED" ) then
		DynamicData.effect.initiateUpdateEffects("pet");
	end	
	-- target changed event
	if ( event == "PLAYER_TARGET_CHANGED" ) then
		-- PATCH: handles target spam loose/obtain
		if ( DynamicData_effect_target_changed == 1 ) then
			Cosmos_ScheduleByName("DD_EFFECT_TARGET_CHANGED", 10, DynamicData.util.doNothing);
			DynamicData.effect.initiateUpdateEffects("target");
			DynamicData_effect_target_changed = 0;
		else
			DynamicData_effect_target_changed = 1;
			Cosmos_ScheduleByName("DD_EFFECT_TARGET_CHANGED", 0.2, DynamicData.effect.initiateUpdateEffects, "target");
		end
	end
end

