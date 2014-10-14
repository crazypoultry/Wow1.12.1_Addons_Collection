local AceOO = AceLibrary("AceOO-2.0")

local ComboPoints = AceOO.Class(IceElement)

ComboPoints.prototype.comboSize = 20

-- Constructor --
function ComboPoints.prototype:init()
	ComboPoints.super.prototype.init(self, "ComboPoints")
	
	self:SetDefaultColor("ComboPoints", 1, 1, 0)
	self.scalingEnabled = true
end



-- 'Public' methods -----------------------------------------------------------


-- OVERRIDE
function ComboPoints.prototype:GetOptions()
	local opts = ComboPoints.super.prototype.GetOptions(self)

	opts["vpos"] = {
		type = "range",
		name = "Vertical Position",
		desc = "Vertical Position",
		get = function()
			return self.moduleSettings.vpos
		end,
		set = function(v)
			self.moduleSettings.vpos = v
			self:Redraw()
		end,
		min = -300,
		max = 200,
		step = 10,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 31
	}

	opts["comboFontSize"] = {
		type = "range",
		name = "Combo Points Font Size",
		desc = "Combo Points Font Size",
		get = function()
			return self.moduleSettings.comboFontSize
		end,
		set = function(v)
			self.moduleSettings.comboFontSize = v
			self:Redraw()
		end,
		min = 10,
		max = 40,
		step = 1,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 32
	}

	opts["comboMode"] = {
		type = "text",
		name = "Display Mode",
		desc = "Show graphical or numeric combo points",
		get = function()
			return self.moduleSettings.comboMode
		end,
		set = function(v)
			self.moduleSettings.comboMode = v
			self:Redraw()
		end,
		validate = { "Numeric", "Graphical" },
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 33
	}

	opts["gradient"] = {
		type = "toggle",
		name = "Change color",
		desc = "1 compo point: yellow, 5 combo points: red",
		get = function()
			return self.moduleSettings.gradient
		end,
		set = function(v)
			self.moduleSettings.gradient = v
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 34
	}

	return opts
end


-- OVERRIDE
function ComboPoints.prototype:GetDefaultSettings()
	local defaults =  ComboPoints.super.prototype.GetDefaultSettings(self)
	defaults["vpos"] = 0
	defaults["comboFontSize"] = 20
	defaults["comboMode"] = "Numeric"
	defaults["gradient"] = false
	return defaults
end


-- OVERRIDE
function ComboPoints.prototype:Redraw()
	ComboPoints.super.prototype.Redraw(self)
	
	self:CreateFrame()
	self:UpdateComboPoints()
end


-- OVERRIDE
function ComboPoints.prototype:Enable(core)
	ComboPoints.super.prototype.Enable(self, core)
	
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateComboPoints")
	self:RegisterEvent("PLAYER_COMBO_POINTS", "UpdateComboPoints")
end



-- 'Protected' methods --------------------------------------------------------

-- OVERRIDE
function ComboPoints.prototype:CreateFrame()
	ComboPoints.super.prototype.CreateFrame(self)

	self.frame:SetFrameStrata("BACKGROUND")
	self.frame:SetWidth(self.comboSize*5)
	self.frame:SetHeight(1)
	self.frame:ClearAllPoints()
	self.frame:SetPoint("TOP", self.parent, "BOTTOM", 0, self.moduleSettings.vpos)
	
	self.frame:Show()

	self:CreateComboFrame()
end



function ComboPoints.prototype:CreateComboFrame()

	-- create numeric combo points
	self.frame.numeric = self:FontFactory("Bold", self.moduleSettings.comboFontSize, nil, self.frame.numeric)

	self.frame.numeric:SetWidth(50)
	self.frame.numeric:SetJustifyH("CENTER")

	self.frame.numeric:SetPoint("TOP", self.frame, "TOP", 0, 0)
	self.frame.numeric:Show()

	if (not self.frame.graphicalBG) then
		self.frame.graphicalBG = {}
		self.frame.graphical = {}
	end

	-- create backgrounds
	for i = 1, 5 do
		if (not self.frame.graphicalBG[i]) then
			self.frame.graphicalBG[i] = CreateFrame("StatusBar", nil, self.frame)
			self.frame.graphicalBG[i]:SetStatusBarTexture(IceElement.TexturePath .. "ComboBG")
		end
		self.frame.graphicalBG[i]:SetFrameStrata("BACKGROUND")
		self.frame.graphicalBG[i]:SetWidth(self.comboSize)
		self.frame.graphicalBG[i]:SetHeight(self.comboSize)
		self.frame.graphicalBG[i]:SetPoint("TOPLEFT", (i-1) * (self.comboSize-5) + (i-1), 0)
		self.frame.graphicalBG[i]:SetAlpha(0.15)
		self.frame.graphicalBG[i]:SetStatusBarColor(self:GetColor("ComboPoints"))

		self.frame.graphicalBG[i]:Hide()
	end

	-- create combo points
	for i = 1, 5 do
		if (not self.frame.graphical[i]) then
			self.frame.graphical[i] = CreateFrame("StatusBar", nil, self.frame.graphicalBG[i])
			self.frame.graphical[i]:SetStatusBarTexture(IceElement.TexturePath .. "Combo")
		end
		self.frame.graphical[i]:SetFrameStrata("BACKGROUND")
		self.frame.graphical[i]:SetAllPoints(self.frame.graphicalBG[i])

		local r, g, b = self:GetColor("ComboPoints")
		if (self.moduleSettings.gradient) then
			g = g - (0.15*i)
		end
		self.frame.graphical[i]:SetStatusBarColor(r, g, b)

		self.frame.graphical[i]:Hide()
	end
end



function ComboPoints.prototype:UpdateComboPoints()
	local points = GetComboPoints("target")

	if (points == 0) then
		points = nil
	end

	if (self.moduleSettings.comboMode == "Numeric") then
		local r, g, b = self:GetColor("ComboPoints")
		if (self.moduleSettings.gradient and points) then
			g = g - (0.15*points)
		end
		self.frame.numeric:SetTextColor(r, g, b, 0.7)

		self.frame.numeric:SetText(points)
	else
		self.frame.numeric:SetText()

		for i = 1, table.getn(self.frame.graphical) do
			if (points ~= nil) then
				self.frame.graphicalBG[i]:Show()
			else
				self.frame.graphicalBG[i]:Hide()
			end
			
			if (points ~= nil and i <= points) then
				self.frame.graphical[i]:Show()
			else
				self.frame.graphical[i]:Hide()
			end
		end
	end
end





-- Load us up
ComboPoints:new()
