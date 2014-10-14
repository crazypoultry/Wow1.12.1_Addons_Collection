
-- Title: CastingBar Time v0.1
-- Notes: Displays remaining casting / channeling time
-- Author: lua@lumpn.de

local function CastingBarTime_toString(end_time)
	local diff_time = end_time - GetTime();
	
	if (diff_time < 0.0) then
		diff_time = 0.0;
	end
	
	return string.format(" (%.1fs)", diff_time);
end

function CastingBarTime_OnLoad()
	this:RegisterEvent("SPELLCAST_START");
	this:RegisterEvent("SPELLCAST_CHANNEL_START");
	this.SpellName = "";
end


function CastingBarTime_OnEvent()
	if ( event == "SPELLCAST_START" ) then
		this.SpellName = arg1;
	elseif ( event == "SPELLCAST_CHANNEL_START" ) then
		this.SpellName = arg2;
	end
end


function CastingBarTime_OnUpdate()

	if ( CastingBarFrame.casting ) then
		CastingBarText:SetText(this.SpellName..CastingBarTime_toString(CastingBarFrame.maxValue));
	elseif ( CastingBarFrame.channeling ) then
		CastingBarText:SetText(this.SpellName..CastingBarTime_toString(CastingBarFrame.endTime));
	end
	
end