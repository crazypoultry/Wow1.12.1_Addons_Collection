
-- module setup
local me = { name = "event"}
local mod = thismod
mod[me.name] = me

--[[
Events.lua

This module ninjas events from other mods to stop them firing when we don't want them to.

]]

-- key = the frame, value = original onevent
me.knownframes = { }


me.enumframes = function()
	
	x = GetTime()
	
	while true do
	
		-- get next frame
		frame = EnumerateFrames(frame)
		if frame == nil then
			break
		end
		
		script = frame:GetScript("OnEvent")
	
	end
	
	local mytime = GetTime() - x
	
	mytime = math.floor(0.5 + 1000 * mytime)
	
	mod.print("took " .. mytime .. "ms")
	
end