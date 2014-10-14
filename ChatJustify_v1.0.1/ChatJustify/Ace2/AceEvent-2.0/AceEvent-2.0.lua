--[[
Name: AceEvent-2.0
Revision: $Rev: 6429 $
Author(s): ckknight (ckknight@gmail.com)
	facboy (<email here>)
Inspired By: AceEvent 1.x by Turan (<email here>)
Website: http://www.wowace.com/
Documentation: http://wiki.wowace.com/index.php/AceEvent-2.0
SVN: http://svn.wowace.com/root/trunk/Ace2/AceEvent-2.0
Description: Mixin to allow for event handling, scheduling, and inter-addon
             communication.
Dependencies: AceLibrary, AceOO-2.0, Compost-2.0 (optional)
]]

local MAJOR_VERSION = "AceEvent-2.0"
local MINOR_VERSION = "$Revision: 6429 $"

if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary") end
if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

if not AceLibrary:HasInstance("AceOO-2.0") then error(MAJOR_VERSION .. " requires AceOO-2.0") end

local AceOO = AceLibrary:GetInstance("AceOO-2.0")
local Mixin = AceOO.Mixin
local AceEvent = Mixin {
						"RegisterEvent",
						"UnregisterEvent",
						"UnregisterAllEvents",
						"TriggerEvent",
						"ScheduleEvent",
						"ScheduleRepeatingEvent",
						"CancelScheduledEvent",
						"CancelAllScheduledEvents",
						"IsEventRegistered",
						"IsEventScheduled",
					   }

local Compost = AceLibrary:HasInstance("Compost-2.0") and AceLibrary("Compost-2.0")

local registeringFromAceEvent
function AceEvent:RegisterEvent(event, method, once)
	AceEvent:argCheck(event, 2, "string")
	if self == AceEvent and not registeringFromAceEvent then
		AceEvent:argCheck(method, 3, "function")
		self = method
	else
		AceEvent:argCheck(method, 3, "string", "function", "nil")
	end
	AceEvent:argCheck(once, 4, "boolean", "nil")
	if not method then
		method = event
	end
	if type(method) == "string" and type(self[method]) ~= "function" then
		AceEvent:error("Cannot register event %q to method %q, it does not exist", event, method)
	end

	local AceEvent_registry = AceEvent.registry
	if not AceEvent_registry[event] then
		AceEvent_registry[event] = Compost and Compost:Acquire() or {}
		AceEvent.frame:RegisterEvent(event)
	end
	
	local remember = true
	if AceEvent_registry[event][self] then
		remember = false
	end
	AceEvent_registry[event][self] = method
	
	if once then
		local AceEvent_onceRegistry = AceEvent.onceRegistry
		if not AceEvent_onceRegistry then
			AceEvent.onceRegistry = Compost and Compost:Acquire() or {}
			AceEvent_onceRegistry = AceEvent.onceRegistry
		end
		if not AceEvent_onceRegistry[event] then
			AceEvent_onceRegistry[event] = Compost and Compost:Acquire() or {}
		end
		AceEvent_onceRegistry[event][self] = true
	else
		if AceEvent_onceRegistry and AceEvent_onceRegistry[event] then
			AceEvent_onceRegistry[event][self] = nil
			if Compost and not next(AceEvent_onceRegistry[event]) then
				Compost:Reclaim(AceEvent_onceRegistry[event])
				AceEvent_onceRegistry[event] = nil
			end
		end
	end
	
	if remember then
		AceEvent:TriggerEvent("AceEvent_EventRegistered", self)
	end
end

local _G = getfenv(0)
local triggerFromWoW
function AceEvent:TriggerEvent(event, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
	AceEvent:argCheck(event, 2, "string")
	local AceEvent_registry = AceEvent.registry
	if not AceEvent_registry[event] or not next(AceEvent_registry[event]) then
		return
	end
	local _G_event = _G.event
	local _G_arg1, _G_arg2, _G_arg3, _G_arg4, _G_arg5, _G_arg6, _G_arg7, _G_arg8, _G_arg9 = _G.arg1, _G.arg2, _G.arg3, _G.arg4, _G.arg5, _G.arg6, _G.arg7, _G.arg8, _G.arg9
	local _G_eventDispatcher = _G.eventDispatcher
	if triggerFromWoW then
		triggerFromWoW = nil
		_G.eventDispatcher = "WoW"
	else
		_G.eventDispatcher = self
	end
	_G.event = event
	_G.arg1, _G.arg2, _G.arg3, _G.arg4, _G.arg5, _G.arg6, _G.arg7, _G.arg8, _G.arg9 = a1, a2, a3, a4, a5, a6, a7, a8, a9

	local AceEvent_onceRegistry = AceEvent.onceRegistry
	local AceEvent_debugTable = AceEvent.debugTable
	if AceEvent_onceRegistry and AceEvent_onceRegistry[event] then
		for obj in pairs(AceEvent_onceRegistry[event]) do
			local mem, time
			if AceEvent_debugTable then
				if not AceEvent_debugTable[event] then
					AceEvent_debugTable[event] = Compost and Compost:Acquire() or {}
				end
				if not AceEvent_debugTable[event][obj] then
					AceEvent_debugTable[event][obj] = Compost and Compost:AcquireHash(
						'mem', 0,
						'time', 0
					) or {
						mem = 0,
						time = 0
					}
				end
				mem, time = gcinfo(), GetTime()
			end
			if not AceEvent_registry[event] or not AceEvent_registry[event][obj] then
				break
			end
			local method = AceEvent_registry[event][obj]
			AceEvent.UnregisterEvent(obj, event)
			local done = not AceEvent_onceRegistry[event] or not next(AceEvent_onceRegistry[event])
			if type(method) == "string" then
				local obj_method = obj[method]
				if obj_method then
					obj_method(obj, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
				end
			elseif method then -- function
				method(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
			end
			if AceEvent_debugTable then
				mem, time = mem - gcinfo(), time - GetTime()
				AceEvent_debugTable[event][obj].mem = AceEvent_debugTable[event][obj].mem + mem
				AceEvent_debugTable[event][obj].time = AceEvent_debugTable[event][obj].time + time
			end
			obj = nil
			if done then
				break
			end
		end
	end
	if AceEvent_registry[event] then
		for obj, method in pairs(AceEvent_registry[event]) do
			local mem, time
			if AceEvent_debugTable then
				if not AceEvent_debugTable[event] then
					AceEvent_debugTable[event] = Compost and Compost:Acquire() or {}
				end
				if not AceEvent_debugTable[event][obj] then
					AceEvent_debugTable[event][obj] = Compost and Compost:AcquireHash(
						'mem', 0,
						'time', 0
					) or {
						mem = 0,
						time = 0
					}
				end
				mem, time = gcinfo(), GetTime()
			end
			if type(method) == "string" then
				local obj_method = obj[method]
				if obj_method then
					obj_method(obj, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
				end
			elseif method then -- function
				method(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
			end
			if AceEvent_debugTable then
				mem, time = mem - gcinfo(), time - GetTime()
				AceEvent_debugTable[event][obj].mem = AceEvent_debugTable[event][obj].mem + mem
				AceEvent_debugTable[event][obj].time = AceEvent_debugTable[event][obj].time + time
			end
		end
	end
	_G.event = _G_event
	_G.arg1, _G.arg2, _G.arg3, _G.arg4, _G.arg5, _G.arg6, _G.arg7, _G.arg8, _G.arg9 = _G_arg1, _G_arg2, _G_arg3, _G_arg4, _G_arg5, _G_arg6, _G_arg7, _G_arg8, _G_arg9
	_G.eventDispatcher = _G_eventDispatcher
end

--------------------
-- schedule heap management
--------------------

-- local accessors
local getn = table.getn
local setn = table.setn
local tinsert = table.insert
local tremove = table.remove
local floor = math.floor

--------------------
-- sifting functions
local function hSiftUp(heap, pos, schedule)
	schedule = schedule or heap[pos]
	local scheduleTime = schedule.time
	
	local curr, i = pos, floor(pos/2)
	local parent = heap[i]
	while i > 0 and scheduleTime < parent.time do
		heap[curr], parent.i = parent, curr
		curr, i = i, floor(i/2)
		parent = heap[i]
	end
	heap[curr], schedule.i = schedule, curr
	return pos ~= curr
end

local function hSiftDown(heap, pos, schedule, size)
	schedule, size = schedule or heap[pos], size or getn(heap)
	local scheduleTime = schedule.time
	
	local curr = pos
	repeat
		local child, childTime, c
		-- determine the child to compare with
		local j = 2 * curr
		if j > size then
			break
		end
		local k = j + 1
		if k > size then
			child = heap[j]
			childTime, c = child.time, j
		else
			local childj, childk = heap[j], heap[k]
			local jTime, kTime = childj.time, childk.time
			if jTime < kTime then
				child, childTime, c = childj, jTime, j
			else
				child, childTime, c = childk, kTime, k
			end
		end
		-- do the comparison
		if scheduleTime <= childTime then
			break
		end
		heap[curr], child.i = child, curr
		curr = c
	until false
	heap[curr], schedule.i = schedule, curr
	return pos ~= curr
end

--------------------
-- heap functions
local function hMaintain(heap, pos, schedule, size)
	schedule, size = schedule or heap[pos], size or getn(heap)
	if not hSiftUp(heap, pos, schedule) then
		hSiftDown(heap, pos, schedule, size)
	end
end

local function hPush(heap, schedule)
	tinsert(heap, schedule)
	hSiftUp(heap, getn(heap), schedule)
end

local function hPop(heap)
	local head, tail = heap[1], tremove(heap)
	local size = getn(heap)
	
	if size == 1 then
		heap[1], tail.i = tail, 1
	elseif size > 1 then
		hSiftDown(heap, 1, tail, size)
	end
	return head
end

local function hDelete(heap, pos)
	local size = getn(heap)
	local tail = tremove(heap)
	if pos < size then
		size = size - 1
		if size == 1 then
			heap[1], tail.i = tail, 1
		elseif size > 1 then
			heap[pos] = tail
			hMaintain(heap, pos, tail, size)
		end
	end
end

local GetTime = GetTime
local delayRegistry
local delayHeap
local function OnUpdate()
	local t = GetTime()
	-- peek at top of heap
	local v = delayHeap[1]
	local v_time = v and v.time
	while v and v_time <= t do
		local v_repeatDelay = v.repeatDelay
		if v_repeatDelay then
			-- use the event time, not the current time, else timing inaccuracies add up over time
			v.time = v_time + v_repeatDelay
			-- re-arrange the heap
			hSiftDown(delayHeap, 1, v)
		else
			-- pop the event off the heap, and delete it from the registry
			hPop(delayHeap)
			delayRegistry[v.id] = nil
		end
		local event = v.event
		if type(event) == "function" then
			event(unpack(v))
		else
			AceEvent:TriggerEvent(event, unpack(v))
		end
		if not v_repeatDelay and Compost then
			Compost:Reclaim(v)
		end
		v = delayHeap[1]
		v_time = v and v.time
	end
	if not v then
		AceEvent.frame:Hide()
	end
end

local function ScheduleEvent(self, repeating, event, delay, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
	local id
	if type(event) == "string" or type(event) == "table" then
		if type(event) == "table" then
			if not delayRegistry or not delayRegistry[event] then
				AceEvent:error("Bad argument #2 to `ScheduleEvent'. Improper id table fed in.")
			end
		end
		if type(delay) ~= "number" then
			id, event, delay, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20 = event, delay, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20
			AceEvent:argCheck(event, 3, "string", "function", --[[ so message is right ]] "number")
			AceEvent:argCheck(delay, 4, "number")
			self:CancelScheduledEvent(id)
		end
	else
		AceEvent:argCheck(event, 2, "string", "function")
		AceEvent:argCheck(delay, 3, "number")
	end

	if not delayRegistry then
		AceEvent.delayRegistry = Compost and Compost:Acquire() or {}
		AceEvent.delayHeap = Compost and Compost:Acquire() or {}
		AceEvent.delayHeap.n = 0
		delayRegistry = AceEvent.delayRegistry
		delayHeap = AceEvent.delayHeap
		AceEvent.frame:SetScript("OnUpdate", OnUpdate)
	end
	local t
	if type(id) == "table" then
		for k in pairs(id) do
			id[k] = nil
		end
		table.setn(id, 0)
		t = id
	else
		t = Compost and Compost:Acquire() or {}
	end
	t.n = 0
	tinsert(t, a1)
	tinsert(t, a2)
	tinsert(t, a3)
	tinsert(t, a4)
	tinsert(t, a5)
	tinsert(t, a6)
	tinsert(t, a7)
	tinsert(t, a8)
	tinsert(t, a9)
	tinsert(t, a10)
	tinsert(t, a11)
	tinsert(t, a12)
	tinsert(t, a13)
	tinsert(t, a14)
	tinsert(t, a15)
	tinsert(t, a16)
	tinsert(t, a17)
	tinsert(t, a18)
	tinsert(t, a19)
	tinsert(t, a20)
	t.event = event
	t.time = GetTime() + delay
	t.self = self
	t.id = id or t
	t.repeatDelay = repeating and delay
	delayRegistry[t.id] = t
	-- insert into heap
	hPush(delayHeap, t)
	AceEvent.frame:Show()
	return t.id
end

function AceEvent:ScheduleEvent(event, delay, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
	return ScheduleEvent(self, false, event, delay, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
end

function AceEvent:ScheduleRepeatingEvent(event, delay, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
	return ScheduleEvent(self, true, event, delay, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
end

function AceEvent:CancelScheduledEvent(t)
	AceEvent:argCheck(t, 2, "string", "table")
	if delayRegistry then
		local v = delayRegistry[t]
		if v then
			hDelete(delayHeap, v.i)
			delayRegistry[t] = nil
			if Compost then
				Compost:Reclaim(v)
			end
			if not next(delayRegistry) then
				AceEvent.frame:Hide()
			end
			return true
		end
	end
	return false
end

function AceEvent:IsEventScheduled(t)
	AceEvent:argCheck(t, 2, "string", "table")
	if delayRegistry then
		local v = delayRegistry[t]
		if v then
			return true, v.time - GetTime()
		end
	end
	return false, nil
end

function AceEvent:UnregisterEvent(event)
	AceEvent:argCheck(event, 2, "string")
	local AceEvent_registry = AceEvent.registry
	if AceEvent_registry[event] and AceEvent_registry[event][self] then
		AceEvent_registry[event][self] = nil
		local AceEvent_onceRegistry = AceEvent.onceRegistry
		if AceEvent_onceRegistry[event] and AceEvent_onceRegistry[event][self] then
			AceEvent_onceRegistry[event][self] = nil
			if Compost and not next(AceEvent_registry[event]) then
				Compost:Reclaim(AceEvent_onceRegistry[event])
				AceEvent_onceRegistry[event] = nil
			end
		end
		if Compost and not next(AceEvent_registry[event]) then
			Compost:Reclaim(AceEvent_registry[event])
			AceEvent_registry[event] = nil
			AceEvent.frame:UnregisterEvent(event)
		end
	else
		if self == AceEvent then
			error(string.format("Cannot unregister event %q. Improperly unregistering from AceEvent-2.0.", event), 2)
		else
			AceEvent:error("Cannot unregister event %q. %q is not registered with it.", event, self)
		end
	end
	AceEvent:TriggerEvent("AceEvent_EventUnregistered", self)
end

function AceEvent:UnregisterAllEvents()
	for event, data in pairs(AceEvent.registry) do
		data[self] = nil
		AceEvent:TriggerEvent("AceEvent_EventUnregistered", self)
	end
	if AceEvent.onceRegistry then
		for event, data in pairs(AceEvent.onceRegistry) do
			data[self] = nil
		end
	end
end

function AceEvent:CancelAllScheduledEvents()
	if delayRegistry then
		for k,v in pairs(delayRegistry) do
			if v.self == self then
				hDelete(delayHeap, v.i)
				if Compost then
					Compost:Reclaim(v)
				end
				delayRegistry[k] = nil
			end
		end
		if not next(delayRegistry) then
			AceEvent.frame:Hide()
		end
	end
end

function AceEvent:IsEventRegistered(event)
	AceEvent:argCheck(event, 2, "string")
	local AceEvent_registry = AceEvent.registry
	if self == AceEvent then
		return AceEvent_registry[event] and next(AceEvent_registry[event]) and true or false
	end
	if AceEvent_registry[event] and AceEvent_registry[event][self] then
		return true, AceEvent_registry[event][self]
	end
	return false, nil
end

function AceEvent:OnEmbedDisable(target)
	self.UnregisterAllEvents(target)

	self.CancelAllScheduledEvents(target)
end

function AceEvent:EnableDebugging()
	if not self.debugTable then
		self.debugTable = Compost and Compost:Acquire() or {}
	end
end

function AceEvent:IsFullyInitialized()
	return self.postInit or false
end

function AceEvent:IsPostPlayerLogin()
	return self.playerLogin or false
end

function AceEvent:activate(oldLib, oldDeactivate)
	AceEvent = self

	if oldLib then
		self.onceRegistry = oldLib.onceRegistry
		self.delayRegistry = oldLib.delayRegistry
		self.delayHeap = oldLib.delayHeap
		self.registry = oldLib.registry
		self.frame = oldLib.frame
		self.debugTable = oldLib.debugTable
		self.playerLogin = oldLib.pew or DEFAULT_CHAT_FRAME and DEFAULT_CHAT_FRAME.defaultLanguage and true
		self.postInit = oldLib.postInit or self.playerLogin and ChatTypeInfo and ChatTypeInfo.WHISPER and ChatTypeInfo.WHISPER.r and true
	end
	if not self.registry then
		self.registry = Compost and Compost:Acquire() or {}
	end
	if not self.frame then
		self.frame = CreateFrame("Frame")
	end
	self.frame:SetScript("OnEvent", function()
		if event then
			triggerFromWoW = true
			self:TriggerEvent(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
		end
	end)
	if self.delayRegistry then
		delayRegistry = self.delayRegistry
		delayHeap = self.delayHeap
		self.frame:SetScript("OnUpdate", OnUpdate)
	end

	self:UnregisterAllEvents()
	self:CancelAllScheduledEvents()

	if not self.playerLogin then
		registeringFromAceEvent = true
		self:RegisterEvent("PLAYER_LOGIN", function()
			self.playerLogin = true
		end, true)
		registeringFromAceEvent = nil
	end

	if not self.postInit then
		local isReload = true
		local function func()
			self.postInit = true
			self:TriggerEvent("AceEvent_FullyInitialized")
			if self.registry["CHAT_MSG_CHANNEL_NOTICE"] and self.registry["CHAT_MSG_CHANNEL_NOTICE"][self] then
				self:UnregisterEvent("CHAT_MSG_CHANNEL_NOTICE")
			end
			if self.registry["SPELLS_CHANGED"] and self.registry["SPELLS_CHANGED"][self] then
				self:UnregisterEvent("SPELLS_CHANGED")
			end
		end
		registeringFromAceEvent = true
		self:RegisterEvent("MEETINGSTONE_CHANGED", function()
			self.playerLogin = true
			self:ScheduleEvent("AceEvent_FullyInitialized", func, isReload and 1 or 4)
		end, true)
		self:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE", function()
			self:ScheduleEvent("AceEvent_FullyInitialized", func, 0.05)
		end)
		self:RegisterEvent("SPELLS_CHANGED", function()
			isReload = false
		end)
		registeringFromAceEvent = nil
	end

	self.super.activate(self, oldLib, oldDeactivate)
	if oldLib then
		oldDeactivate(oldLib)
	end
end

local function external(self, major, instance)
	if major == "Compost-2.0" then
		Compost = instance
	end
end

AceLibrary:Register(AceEvent, MAJOR_VERSION, MINOR_VERSION, AceEvent.activate, nil, external)
AceEvent = AceLibrary(MAJOR_VERSION)
