local AceOO = AceLibrary("AceOO-2.0")

IceElement = AceOO.Class("AceEvent-2.0")
IceElement.virtual = true

IceElement.TexturePath = IceHUD.Location .. "\\textures\\"

-- Protected variables --
IceElement.prototype.elementName = nil
IceElement.prototype.parent = nil
IceElement.prototype.frame = nil

IceElement.prototype.defaultColors = {} -- Shared table for all child classes to save some memory
IceElement.prototype.alpha = nil

IceElement.settings = nil
IceElement.moduleSettings = nil

IceElement.prototype.configColor = "ff8888ff"
IceElement.prototype.scalingEnabled = nil

-- Constructor --
-- IceElements are to be instantiated before IceCore is loaded.
-- Therefore we can wait for IceCore to load and then register our
-- module to the core with another event.
function IceElement.prototype:init(name)
	IceElement.super.prototype.init(self)
	assert(name, "IceElement must have a name")

	self.elementName = name
	self.alpha = 1
	self.scalingEnabled = false

	-- Some common colors
	self:SetDefaultColor("Text", 1, 1, 1)
	self:SetDefaultColor("undef", 0.7, 0.7, 0.7)
	
	self:RegisterEvent(IceCore.Loaded, "OnCoreLoad")
end


-- 'Public' methods -----------------------------------------------------------

function IceElement.prototype:ToString()
	return "IceElement('" .. self.elementName .. "')"
end


function IceElement.prototype:GetElementName()
	return self.elementName
end


function IceElement.prototype:Create(parent)
	assert(parent, "IceElement 'parent' can't be nil")
	
	self.parent = parent
	self:CreateFrame()
	self.frame:Hide()
end


function IceElement.prototype:SetDatabase(db)
	self.settings = db
	self.moduleSettings = db.modules[self.elementName]
end


function IceElement.prototype:IsEnabled()
	return self.moduleSettings.enabled
end


function IceElement.prototype:Enable(core)
	if (not core) then
		self.moduleSettings.enabled = true
	end
	self.frame:Show()
end


function IceElement.prototype:Disable(core)
	if (not core) then
		self.moduleSettings.enabled = false
	end
	self.frame:Hide()
	self:UnregisterAllEvents()
end



-- inherting classes should override this and provide
-- make sure they refresh any changes made to them
function IceElement.prototype:Redraw()
	
end


-- inheriting classes should override this and provide
-- AceOptions table for configuration
function IceElement.prototype:GetOptions()
	local opts = {}

	opts["enabled"] = {
		type = "toggle",
		name = "|c" .. self.configColor .. "Enabled|r",
		desc = "Enable/disable module",
		get = function()
			return self.moduleSettings.enabled
		end,
		set = function(value)
			self.moduleSettings.enabled = value
			if (value) then
				self:Enable(true)
			else
				self:Disable()
			end
		end,
		order = 20
	}

	opts["scale"] =
	{
		type = 'range',
		name = "|c" .. self.configColor .. "Scale|r",
		desc = 'Scale of the element',
		min = 0.2,
		max = 2,
		step = 0.1,
		isPercent = true,
		hidden = not self.scalingEnabled,
		get = function()
			return self.moduleSettings.scale
		end,
		set = function(value)
			self.moduleSettings.scale = value
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 21
	}

	return opts
end



-- inheriting classes should override this and provide
-- default settings to populate db
function IceElement.prototype:GetDefaultSettings()
	local defaults = {}
	defaults["enabled"] = true
	defaults["scale"] = 1
	return defaults
end



-- 'Protected' methods --------------------------------------------------------

-- This should be overwritten by inheriting classes
function IceElement.prototype:CreateFrame()
	if not (self.frame) then
		self.frame = CreateFrame("Frame", "IceHUD_"..self.elementName, self.parent)
	end

	self.frame:SetScale(self.moduleSettings.scale)
end


function IceElement.prototype:GetColors()
	return self.settings.colors
end


function IceElement.prototype:GetColor(color, alpha)
	if not (color) then
		return 1, 1, 1, 1
	end

	if not (alpha) then
		alpha = self.alpha
	end
	
	if not (self.settings.colors[color]) then
		local r, g, b = self:GetClassColor(color)
		return r, g, b, alpha
	end

	return self.settings.colors[color].r, self.settings.colors[color].g, self.settings.colors[color].b, alpha
end


function IceElement.prototype:GetHexColor(color, alpha)
	local r, g, b, a = self:GetColor(color)
	return string.format("%02x%02x%02x%02x", a * 255, r * 255, g * 255, b * 255)
end


function IceElement.prototype:SetColor(color, red, green, blue)
	if (red > 1) then
		red = red / 255
	end
	if (green > 1) then
		green = green / 255
	end
	if (blue > 1) then
		blue = blue / 255
	end
	self.settings.colors[color] = {r = red, g = green, b = blue}
end


function IceElement.prototype:SetDefaultColor(color, red, green, blue)
	if (red > 1) then
		red = red / 255
	end
	if (green > 1) then
		green = green / 255
	end
	if (blue > 1) then
		blue = blue / 255
	end
	
	self.defaultColors[color] = {r = red, g = green, b = blue}
end


function IceElement.prototype:GetClassColor(class)
	class = string.upper(class)
	return RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b
end


function IceElement.prototype:ConvertToHex(color)
	return string.format("ff%02x%02x%02x", color.r*255, color.g*255, color.b*255)
end


function IceElement.prototype:FontFactory(weight, size, frame, font)
	local weightString = ""
	if (weight) then
		weightString = "Bold"
	end
	
	local fontFile = IceHUD.Location .. "\\fonts\\Calibri" .. weightString ..".ttf"
	if (self.settings.fontFamily == "Default") then
		fontFile = STANDARD_TEXT_FONT
	end
	
	if not (frame) then
		frame = self.frame
	end
	
	local fontString = nil
	if not (font) then
		fontString = frame:CreateFontString()
	else
		fontString = font
	end
	fontString:SetFont(fontFile, size)
	fontString:SetShadowColor(0, 0, 0, 1)
	fontString:SetShadowOffset(1, -1)
	
	return fontString
end



-- Event Handlers -------------------------------------------------------------

-- Register ourself to the core
function IceElement.prototype:OnCoreLoad()
	self:TriggerEvent(IceCore.RegisterModule, self)
end




-- Inherited classes should just instantiate themselves and let
-- superclass to handle registration to the core
-- IceInheritedClass:new()
