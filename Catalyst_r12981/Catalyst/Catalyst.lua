if AceAddon then 
	Catalyst = AceAddon:new{
		name 			= "Catalyst",
		description 	= "A quick hack to improve zoning time",
		version			= "1.2.0",
		author			= "tard",
		email			= "tardmrr@gmail.com",
		releaseDate		= "04/12/06",
		aceCompatible	= "103",
		category		= "others",
		
		cmd 			= AceChatCmd:new({"/catalyst"},{}),
		db 				= AceDatabase:new("CatalystDB"),
	}
	
	Catalyst:RegisterForLoad()
else
	-- This is some quick compatability code to let Catalyst load 
	-- when Ace isn't present in the system as well.  This code
	-- won't be run if Ace is on the system
	
	Catalyst = {}
	local frame = CreateFrame("Frame")
	
	Catalyst.RegisterEvent = function(self, event)
		frame:RegisterEvent(event)
	end
	
	Catalyst.OnEvent = function()
		if Catalyst[event] then Catalyst[event](Catalyst) end
	end

	Catalyst.cmd = {}
	Catalyst.cmd.msg = function(self, msg)
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff78Catalyst:|r " .. msg)
	end
	
	frame:SetScript("OnEvent", Catalyst.OnEvent)
	frame:RegisterEvent("PLAYER_LEAVING_WORLD")	
end

local blacklist = {
	UNIT_INVENTORY_CHANGED = true,
	BAG_UPDATE = true,
	ITEM_LOCK_CHANGED = true,
	ACTIONBAR_SLOT_CHANGED = true,
}	

local inactiveHooks = {}

function Catalyst:Enable()
	self:RegisterEvent("PLAYER_LEAVING_WORLD")
end

function Catalyst:Disable() end

function Catalyst:PLAYER_LEAVING_WORLD()
	self.time = GetTime()
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:BlockEvents()
--	self.cmd:msg("Hook Time %.3f sec", GetTime() - self.time)
end

function Catalyst:PLAYER_ENTERING_WORLD()
--	local t = self.time ~= nil and GetTime()
	self:UnhookAllScripts()
--	self.cmd:msg("Unhook time %.3f sec", GetTime() - t)
	if self.time then self.cmd:msg(string.format("Zone time %.3f sec", GetTime() - self.time)) end
end

function Catalyst:BlockEvents()
	self.Hooks = {}
	local enum = EnumerateFrames
	local f = enum()
	while f do
		if(not WarmupFrame or f ~= WarmupFrame) then
			self:HookScript(f)--,"OnEvent","HookedEventHandler")
		end
		f = enum(f)
	end
end

function Catalyst:HookedEventHandler()
	if(inactiveHooks[this] or not blacklist[event])then
		self.Hooks[this]()	
	end	
end

local wrapper = function() Catalyst:HookedEventHandler() end
local getscript = UIParent.GetScript
local setscript = UIParent.SetScript

function Catalyst:HookScript(frame)
	local s = getscript(frame,"OnEvent")
	if(s) then 
		self.Hooks[frame] = s
		setscript(frame,"OnEvent",wrapper)
	end
end

function Catalyst:UnhookAllScripts()
	if not self.Hooks then return end
	
	for f,s in self.Hooks do 
		if(getscript(f,"OnEvent") ~= wrapper)then
			-- Deactivate this hook
			inactiveHooks[f] = true
		else
			setscript(f,"OnEvent",s)
			self.Hooks[f] = nil
		end
	end
end