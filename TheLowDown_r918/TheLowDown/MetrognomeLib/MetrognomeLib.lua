
local vmajor, vminor = "1", tonumber(string.sub("$Revision: 782 $", 12, -3))
local stubvarname = "TekLibStub"
local libvarname = "Metrognome"


-- Check to see if an update is needed
-- if not then just return out now before we do anything
local libobj = getglobal(libvarname)
if libobj and not libobj:NeedsUpgraded(vmajor, vminor) then return end


---------------------------------------------------------------------------
-- Embedded Library Registration Stub
-- Written by Iriel <iriel@vigilance-committee.org>
-- Version 0.1 - 2006-03-05
-- Modified by Tekkub <tekkub@gmail.com>
---------------------------------------------------------------------------

local stubobj = getglobal(stubvarname)
if not stubobj then
	stubobj = {}
	setglobal(stubvarname, stubobj)


	-- Instance replacement method, replace contents of old with that of new
	function stubobj:ReplaceInstance(old, new)
		 for k,v in pairs(old) do old[k]=nil end
		 for k,v in pairs(new) do old[k]=v end
	end


	-- Get a new copy of the stub
	function stubobj:NewStub(name)
		local newStub = {}
		self:ReplaceInstance(newStub, self)
		newStub.libName = name
		newStub.lastVersion = ''
		newStub.versions = {}
		return newStub
	end


	-- Get instance version
	function stubobj:NeedsUpgraded(vmajor, vminor)
		local versionData = self.versions[vmajor]
		if not versionData or versionData.minor < vminor then return true end
	end


	-- Get instance version
	function stubobj:GetInstance(version)
		if not version then version = self.lastVersion end
		local versionData = self.versions[version]
		if not versionData then print(string.format("<%s> Cannot find library version: %s", self.libName, version or "")) return end
		return versionData.instance
	end


	-- Register new instance
	function stubobj:Register(newInstance)
		 local version,minor = newInstance:GetLibraryVersion()
		 self.lastVersion = version
		 local versionData = self.versions[version]
		 if not versionData then
				-- This one is new!
				versionData = {
					instance = newInstance,
					minor = minor,
					old = {},
				}
				self.versions[version] = versionData
				newInstance:LibActivate(self)
				return newInstance
		 end
		 -- This is an update
		 local oldInstance = versionData.instance
		 local oldList = versionData.old
		 versionData.instance = newInstance
		 versionData.minor = minor
		 local skipCopy = newInstance:LibActivate(self, oldInstance, oldList)
		 table.insert(oldList, oldInstance)
		 if not skipCopy then
				for i, old in ipairs(oldList) do self:ReplaceInstance(old, newInstance) end
		 end
		 return newInstance
	end
end


if not libobj then
	libobj = stubobj:NewStub(libvarname)
	setglobal(libvarname, libobj)
end

local lib = {}


-- Return the library's current version
function lib:GetLibraryVersion()
	return vmajor, vminor
end

local compost
-- Activate a new instance of this library
function lib:LibActivate(stub, oldLib, oldList)
	local maj, min = self:GetLibraryVersion()

	if oldLib then
		local omaj, omin = oldLib:GetLibraryVersion()
		self.var = oldLib.var
	else
		self.var = {  -- "Local" variables go here
			frame = CreateFrame("Frame"),
			handlers = {},
		}
		self.var.frame:Hide()
	end
	self.var.frame:SetScript("OnUpdate", self.OnUpdate)
	self.var.frame.owner = self
	compost = CompostLib and CompostLib:GetInstance("compost-1")
	-- nil return makes stub do object copy
end


-- Sets up a new OnUpdate handler
-- name - A unique name, if you only need one handler then your addon's name will suffice here
-- func - Function to be called
-- rate (optional but highly reccomended) - The rate (in seconds) at which your function should be called
-- arg (optional) - A single arg to be passed to func, this is a great place to pass self
-- Returns true if you've been registered
function lib:Register(name, func, rate, arg)
	if not name or not func or self.var.handlers[name] then return end
	local t = compost and compost:Acquire() or {}
	t.func, t.rate, t.arg = func, rate or 0, arg
	self.var.handlers[name] = t
	self.var.frame:Show()
	return true
end


-- Removes an OnUpdate handler
-- name - the hander you want to remove
-- Returns true if successful
function lib:Unregister(name)
	if not name or not self.var.handlers[name] then return end
	if compost then compost:Reclaim(self.var.handlers[name]) end
	self.var.handlers[name] = nil
	if not self:HasHandlers() then self.var.frame:Hide() end
	return true
end


-- Begins triggering updates
-- name - the hander you want to start
-- Returns true if successful
function lib:Start(name)
	if not name or not self.var.handlers[name] then return end
	self.var.handlers[name].running = true
	self.var.handlers[name].elapsed = 0
	return true
end


-- Stops triggering updates
-- name - the hander you want to stop
-- Returns true if successful
function lib:Stop(name)
	if not name or not self.var.handlers[name] then return end
	self.var.handlers[name].running = nil
	return true
end


-- Query a schedule's status
-- Args: name - the schedule you wish to look up
-- Returns: registered - true if a schedule exists with this name
--          rate - the registered rate, if defined
--          running - true if this schedule is currently running
function lib:Status(name)
	if not name or not self.var.handlers[name] then return end

	return true, self.var.handlers[name].rate, self.var.handlers[name].running
end


function lib:OnUpdate()
	for i,v in pairs(this.owner.var.handlers) do
		if v.running then
			v.elapsed = v.elapsed + arg1
			if v.elapsed >= v.rate then
				v.func(v.arg, v.elapsed)
				v.elapsed = 0
			end
		end
	end
end


function lib:HasHandlers()
	for i in pairs(self.var.handlers) do return true end
end


--------------------------------
--      Load this bitch!      --
--------------------------------
libobj:Register(lib)
