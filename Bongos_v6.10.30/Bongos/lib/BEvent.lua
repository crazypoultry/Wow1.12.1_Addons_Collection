--[[
	BEvent
		An small event handler.
		Based a bit on AceEvent

	TODO
		Add in varList stuff
--]]

assert(TLib, "TLib not loaded")

--local msg = function(msg) ChatFrame1:AddMessage('BEvent: ' .. (msg or 'nil'), 1, 0.9, 0) end

--[[ Version Checking ]]--
local VERSION = "6.10.27"
if TLib.OlderIsBetter(BEvent, VERSION) then return end

--[[ Library Instantiation ]]--

if not BEvent then
	BEvent = CreateFrame("Frame")
end
if not BEvent.events then
	BEvent.events = {}
end
BEvent.version = VERSION

--[[ Local Globals ]]--

--events which occur once
local oneTimers = {"PLAYER_LOGIN", "VARIABLES_LOADED"}

--[[ Local Functions ]]--

local function RemoveEvent(event)
	if BEvent.events[event] then
		BEvent.events[event] = nil
		BEvent:UnregisterEvent(event)
	end
end

BEvent:SetScript("OnEvent", function()
	local actions = this.events[event]
	if actions then
		for _, action in pairs(actions) do
			action(action)
		end
	end
	if oneTimers[event] then
		RemoveEvent(event)
	end
end)

--[[ Public Functions ]]--

--adds an action to the given event
function BEvent:AddAction(e, action, runNow)
	if action then
		local events = self.events
		if not events[e] then
			self:RegisterEvent(e)
			events[e] = {action}
		else
			table.insert(events[e], action)
		end
		if runNow then
			event = e
			action(action)
		end
	end
end

--removes the given action from the given event
function BEvent:RemoveAction(e, action)
	if action then
		local events = self.events
		local actions = events[e]
		if events and actions then
			for i, act in pairs(actions) do
				if act == action then
					actions[i] = nil
				end
			end
			if not next(actions) then
				events[e] = nil
				self:UnregisterEvent(e)
			end
		end
	end
end

--Calls an event with the given arguments
function BEvent:CallEvent(e, a1, a2, a3, a4, a5, a6, a7, a8, a9)
	local actions = self.events[e]
	if actions then
		--preserve any old event args
		local oE = event
		local oA1 = arg1; local oA2 = arg2
		local oA3 = arg3; local oA4 = arg4
		local oA5 = arg5; local oA6 = arg6
		local oA7 = arg7; local oA8 = arg8
		local oA9 = arg9

		event = e; arg1 = a1; arg2 = a2; arg3 = a3; arg4 = a4; arg5 = a5; arg6 = a6; arg7 = a7; arg8 = a8; arg9 = a9
		for _, action in pairs(actions) do
			action(action)
		end
		event = oE; arg1 = oA1; arg2 = oA2; arg3 = oA3; arg4 = oA4; arg5 = oA5; arg6 = oA6; arg7 = oA7; arg8 = oA8; arg9 = oA9
	end
end