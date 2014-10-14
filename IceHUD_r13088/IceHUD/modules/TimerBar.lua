local AceOO = AceLibrary("AceOO-2.0")

local TimerBar = AceOO.Class(IceBarElement, "AceHook-2.0")
local abacus = nil


-- Constructor --
function TimerBar.prototype:init()
	TimerBar.super.prototype.init(self, "TimerBar")
	
	self:SetDefaultColor("TimerFlight", 0.2, 0.7, 0.7)
end


-- 'Public' methods -----------------------------------------------------------

function TimerBar.prototype:GetDefaultSettings()
	local settings = TimerBar.super.prototype.GetDefaultSettings(self)
	settings["side"] = IceCore.Side.Right
	settings["offset"] = 3
	return settings
end


function TimerBar.prototype:Enable(core)
	TimerBar.super.prototype.Enable(self, core)

	self.frame.bottomUpperText:SetWidth(180)
	self.frame:Hide()

	self:Hook(ToFu, "OnTextUpdate")
end


function TimerBar.prototype:Disable(core)
	TimerBar.super.prototype.Disable(self, core)
	
	self:Unhook(ToFu, "OnTextUpdate")
end



-- 'Protected' methods --------------------------------------------------------

function TimerBar.prototype:OnTextUpdate(object)
	self.hooks[object].OnTextUpdate.orig(object)
	
	if (ToFu.inFlight) then
		if (ToFu.timeAvg ~= 0) then
			local timeRemaining = ToFu.timeAvg - ToFu.timeFlown
			
			self.frame:Show()
			self:UpdateBar(timeRemaining / ToFu.timeAvg, "TimerFlight")
			self:Update()

			local text = abacus:FormatDurationCondensed(timeRemaining, true)
			self:SetBottomText1(text)
			
			return
		end
	end
	self.frame:Hide()
end




-- Load us up
if (IsAddOnLoaded("FuBar_ToFu")) then
	abacus = AceLibrary("Abacus-2.0")
	TimerBar:new()
end
