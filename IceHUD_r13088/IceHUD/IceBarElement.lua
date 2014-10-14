local AceOO = AceLibrary("AceOO-2.0")

IceBarElement = AceOO.Class(IceElement)
IceBarElement.virtual = true

IceBarElement.BarTextureWidth = 128

IceBarElement.prototype.barFrame = nil
IceBarElement.prototype.backroundAlpha = nil

IceBarElement.prototype.combat = nil
IceBarElement.prototype.target = nil


-- Constructor --
function IceBarElement.prototype:init(name)
	IceBarElement.super.prototype.init(self, name)
end



-- 'Public' methods -----------------------------------------------------------

-- OVERRIDE
function IceBarElement.prototype:Enable()
	IceBarElement.super.prototype.Enable(self)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "InCombat")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "OutCombat")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "CheckCombat")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "TargetChanged")
end


-- OVERRIDE
function IceBarElement.prototype:GetDefaultSettings()
	local settings = IceBarElement.super.prototype.GetDefaultSettings(self)
	
	settings["side"] = IceCore.Side.Left
	settings["offset"] = 1
	settings["barFontSize"] = 12
	settings["barFontBold"] = true
	settings["lockTextAlpha"] = true
	settings["textVisible"] = {upper = true, lower = true}
	
	return settings
end


-- OVERRIDE
function IceBarElement.prototype:GetOptions()
	local opts = IceBarElement.super.prototype.GetOptions(self)
	
	opts["side"] = 
	{
		type = 'text',
		name =  '|c' .. self.configColor .. 'Side|r',
		desc = 'Side of the HUD where the bar appears',
		get = function()
			if (self.moduleSettings.side == IceCore.Side.Right) then
				return "Right"
			else
				return "Left"
			end
		end,
		set = function(value)
			if (value == "Right") then
				self.moduleSettings.side = IceCore.Side.Right
			else
				self.moduleSettings.side = IceCore.Side.Left
			end
			self:Redraw()
		end,
		validate = { "Left", "Right" },
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 30
	}
	
	opts["offset"] = 
	{
		type = 'range',
		name = '|c' .. self.configColor .. 'Offset|r',
		desc = 'Offset of the bar',
		min = -1,
		max = 10,
		step = 1,
		get = function()
			return self.moduleSettings.offset
		end,
		set = function(value)
			self.moduleSettings.offset = value
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 31
	}
	
	opts["textSettings"] =
	{
		type = 'group',
		name = '|c' .. self.configColor .. 'Text Settings|r',
		desc = 'Settings related to texts',
		order = 32,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		args = {
			fontsize = {
				type = 'range',
				name = 'Bar Font Size',
				desc = 'Bar Font Size',
				get = function()
					return self.moduleSettings.barFontSize
				end,
				set = function(v)
					self.moduleSettings.barFontSize = v
					self:Redraw()
				end,
				min = 8,
				max = 20,
				step = 1,
				order = 11
			},
			
			fontBold = {
				type = 'toggle',
				name = 'Bar Font Bold',
				desc = 'If you have game default font selected, this option has no effect',
				get = function()
					return self.moduleSettings.barFontBold
				end,
				set = function(v)
					self.moduleSettings.barFontBold = v
					self:Redraw()
				end,
				order = 12
			},
			
			lockFontAlpha = {
				type = "toggle",
				name = "Lock Bar Text Alpha",
				desc = "Locks upper text alpha to 100%",
				get = function()
					return self.moduleSettings.lockTextAlpha
				end,
				set = function(v)
					self.moduleSettings.lockTextAlpha = v
					self:Redraw()
				end,
				order = 13
			},
			
			upperTextVisible = {
				type = 'toggle',
				name = 'Upper text visible',
				desc = 'Toggle upper text visibility',
				get = function()
					return self.moduleSettings.textVisible['upper']
				end,
				set = function(v)
					self.moduleSettings.textVisible['upper'] = v
					self:Redraw()
				end,
				order = 14
			},
			
			lowerTextVisible = {
				type = 'toggle',
				name = 'Lower text visible',
				desc = 'Toggle lower text visibility',
				get = function()
					return self.moduleSettings.textVisible['lower']
				end,
				set = function(v)
					self.moduleSettings.textVisible['lower'] = v
					self:Redraw()
				end,
				order = 15
			},
		}
	}
	
	return opts
end



-- OVERRIDE
function IceBarElement.prototype:Redraw()
	IceBarElement.super.prototype.Redraw(self)

	if (not self.moduleSettings.enabled) then
		return
	end

	self.alpha = self.settings.alphaooc
	self:CreateFrame()
	self.frame:SetAlpha(self.alpha)
end



function IceBarElement.prototype:SetPosition(side, offset)
	IceBarElement.prototype.side = side
	IceBarElement.prototype.offset = offset
end


-- 'Protected' methods --------------------------------------------------------

-- OVERRIDE
function IceBarElement.prototype:CreateFrame()
	-- don't call overridden method
	self.alpha = self.settings.alphaooc

	self:CreateBackground()
	self:CreateBar()
	self:CreateTexts()
	
	self.frame:SetScale(self.moduleSettings.scale)
end


-- Creates background for the bar
function IceBarElement.prototype:CreateBackground()
	if not (self.frame) then
		self.frame = CreateFrame("StatusBar", "IceHUD_"..self.elementName, self.parent)
	end
	
	self.frame:SetFrameStrata("BACKGROUND")
	self.frame:SetWidth(self.settings.barWidth)
	self.frame:SetHeight(self.settings.barHeight)
	
	if not (self.frame.bg) then
		self.frame.bg = self.frame:CreateTexture(nil, "BACKGROUND")
	end
	
	self.frame.bg:SetTexture(IceElement.TexturePath .. self.settings.barTexture.."BG")
	self.frame.bg:ClearAllPoints()
	self.frame.bg:SetAllPoints(self.frame)
	
	if (self.moduleSettings.side == IceCore.Side.Left) then
		self.frame.bg:SetTexCoord(1, 0, 0, 1)
	else
		self.frame.bg:SetTexCoord(0, 1, 0, 1)
	end
	
	self.frame:SetStatusBarTexture(self.frame.bg)
	self.frame:SetStatusBarColor(self:GetColor("undef", self.settings.alphabg))
	
	local ownPoint = "LEFT"
	if (self.moduleSettings.side == ownPoint) then
		ownPoint = "RIGHT"
	end
	
	-- ofxx = (bar width) + (extra space in between the bars)
	local offx = (self.settings.barProportion * self.settings.barWidth * self.moduleSettings.offset)
		+ (self.moduleSettings.offset * self.settings.barSpace)
	if (self.moduleSettings.side == IceCore.Side.Left) then
		offx = offx * -1
	end	
	
	self.frame:ClearAllPoints()
	self.frame:SetPoint("BOTTOM"..ownPoint, self.parent, "BOTTOM"..self.moduleSettings.side, offx, 0)
end


-- Creates the actual bar
function IceBarElement.prototype:CreateBar()
	if not (self.barFrame) then
		self.barFrame = CreateFrame("StatusBar", nil, self.frame)
	end
	
	self.barFrame:SetFrameStrata("LOW")
	self.barFrame:SetWidth(self.settings.barWidth)
	self.barFrame:SetHeight(self.settings.barHeight)
	
	
	if not (self.barFrame.bar) then
		self.barFrame.bar = self.frame:CreateTexture(nil, "BACKGROUND")
	end
	
	self.barFrame.bar:SetTexture(IceElement.TexturePath .. self.settings.barTexture)
	self.barFrame.bar:SetAllPoints(self.frame)
	
	self.barFrame:SetStatusBarTexture(self.barFrame.bar)
	
	self:UpdateBar(1, "undef")
	
	local point = "LEFT"
	if (self.moduleSettings.side == point) then
		point = "RIGHT"
	end
	
	self.barFrame:ClearAllPoints()
	self.barFrame:SetPoint("BOTTOM"..point, self.frame, "BOTTOM"..self.moduleSettings.side, 0, 0)
end


function IceBarElement.prototype:CreateTexts()
	self.frame.bottomUpperText = self:FontFactory(self.moduleSettings.barFontBold, self.moduleSettings.barFontSize, nil, self.frame.bottomUpperText)
	self.frame.bottomLowerText = self:FontFactory(self.moduleSettings.barFontBold, self.moduleSettings.barFontSize, nil, self.frame.bottomLowerText)

	self.frame.bottomUpperText:SetWidth(80)
	self.frame.bottomLowerText:SetWidth(120)
	
	self.frame.bottomUpperText:SetHeight(14)
	self.frame.bottomLowerText:SetHeight(14)

	local justify = "RIGHT"
	if ((self.moduleSettings.side == "LEFT" and self.moduleSettings.offset <= 1) or
		(self.moduleSettings.side == "RIGHT" and self.moduleSettings.offset > 1)) 
	then
		justify = "LEFT"
	end


	self.frame.bottomUpperText:SetJustifyH(justify)
	self.frame.bottomLowerText:SetJustifyH(justify)


	local ownPoint = self.moduleSettings.side
	if (self.moduleSettings.offset > 1) then
		ownPoint = self:Flip(ownPoint)
	end
	
	local parentPoint = self:Flip(self.moduleSettings.side)
	
	
	local offx = 0
	-- adjust offset for bars where text is aligned to the outer side
	if (self.moduleSettings.offset <= 1) then
		offx = self.settings.barProportion * self.settings.barWidth - offx
	end


	if (self.moduleSettings.side == IceCore.Side.Left) then
		offx = offx * -1
	end

	self.frame.bottomUpperText:ClearAllPoints()
	self.frame.bottomLowerText:ClearAllPoints()

	self.frame.bottomUpperText:SetPoint("TOP"..ownPoint , self.frame, "BOTTOM"..parentPoint, offx, -1)
	self.frame.bottomLowerText:SetPoint("TOP"..ownPoint , self.frame, "BOTTOM"..parentPoint, offx, -15)
	
	if (self.moduleSettings.textVisible["upper"]) then
		self.frame.bottomUpperText:Show()
	else
		self.frame.bottomUpperText:Hide()
	end
	
	if (self.moduleSettings.textVisible["lower"]) then
		self.frame.bottomLowerText:Show()
	else
		self.frame.bottomLowerText:Hide()
	end
end


function IceBarElement.prototype:Flip(side)
	if (side == IceCore.Side.Left) then
		return IceCore.Side.Right
	else
		return IceCore.Side.Left
	end
end


function IceBarElement.prototype:SetScale(texture, scale)
	if (self.moduleSettings.side == IceCore.Side.Left) then
		texture:SetTexCoord(1, 0, 1-scale, 1)
	else
		texture:SetTexCoord(0, 1, 1-scale, 1)
	end
end


function IceBarElement.prototype:UpdateBar(scale, color, alpha)
	alpha = alpha or 1
	self.frame:SetAlpha(alpha)
	
	local r, g, b = self.settings.backgroundColor.r, self.settings.backgroundColor.g, self.settings.backgroundColor.b
	if (self.settings.backgroundToggle) then
		r, g, b = self:GetColor(color)
	end
	
	if (self.combat) then
		self.alpha = self.settings.alphaic
		self.backgroundAlpha = self.settings.alphaicbg
	elseif (self.target or self:UseTargetAlpha(scale)) then
		self.alpha = self.settings.alphaTarget
		self.backgroundAlpha = self.settings.alphaTargetbg
	else
		self.alpha = self.settings.alphaooc
		self.backgroundAlpha = self.settings.alphaoocbg
	end

	self.frame:SetStatusBarColor(r, g, b, self.backgroundAlpha)
	self.barFrame:SetStatusBarColor(self:GetColor(color))
	
	self:SetScale(self.barFrame.bar, scale)
end


function IceBarElement.prototype:UseTargetAlpha(scale)
	return (scale and (scale < 1))
end


-- Bottom line 1
function IceBarElement.prototype:SetBottomText1(text, color)
	if not (self.moduleSettings.textVisible["upper"]) then
		return
	end

	if not (color) then
		color = "Text"
	end

	local alpha = self.alpha
	
	if (self.alpha > 0) then
		-- boost text alpha a bit to make it easier to see
		alpha = self.alpha + 0.1
			
		if (alpha > 1) then
			alpha = 1
		end
	end
	
	if (self.moduleSettings.lockTextAlpha and (self.alpha > 0)) then
		alpha = 1
	end
	
	self.frame.bottomUpperText:SetTextColor(self:GetColor(color, alpha))
	self.frame.bottomUpperText:SetText(text)
end


-- Bottom line 2
function IceBarElement.prototype:SetBottomText2(text, color, alpha)
	if not (self.moduleSettings.textVisible["lower"]) then
		return
	end
	
	if not (color) then
		color = "Text"
	end
	if not (alpha) then
		-- boost text alpha a bit to make it easier to see
		if (self.alpha > 0) then
			alpha = self.alpha + 0.1
			
			if (alpha > 1) then
				alpha = 1
			end
		end
	end

	self.frame.bottomLowerText:SetTextColor(self:GetColor(color, alpha))
	self.frame.bottomLowerText:SetText(text)
end


function IceBarElement.prototype:GetFormattedText(value1, value2)
	local color = "ffcccccc"
	if not (value2) then
		return string.format("|c%s[|r%s|c%s]|r", color, value1, color)
	end
	return string.format("|c%s[|r%s|c%s/|r%s|c%s]|r", color, value1, color, value2, color)
end


-- To be overridden
function IceBarElement.prototype:Update()
end




-- Combat event handlers ------------------------------------------------------

function IceBarElement.prototype:InCombat()
	self.combat = true
	self:Update(self.unit)
end


function IceBarElement.prototype:OutCombat()
	self.combat = false
	self:Update(self.unit)
end


function IceBarElement.prototype:CheckCombat()
	self.combat = UnitAffectingCombat("player")
	self.target = UnitExists("target")
	self:Update(self.unit)
end


function IceBarElement.prototype:TargetChanged()
	self.target = UnitExists("target")
	self:Update(self.unit)
end
