local AceOO = AceLibrary("AceOO-2.0")

IceCore = AceOO.Class("AceEvent-2.0", "AceDB-2.0")

IceCore.Side = { Left = "LEFT", Right = "RIGHT" }

-- Events modules should register/trigger during load
IceCore.Loaded = "IceCore_Loaded"
IceCore.RegisterModule = "IceCore_RegisterModule"


-- Private variables --
IceCore.prototype.settings = nil
IceCore.prototype.IceHUDFrame = nil
IceCore.prototype.elements = {}
IceCore.prototype.enabled = nil
IceCore.prototype.presets = {}

-- Constructor --
function IceCore.prototype:init()
	IceCore.super.prototype.init(self)
	IceHUD:Debug("IceCore.prototype:init()")
	
	self:RegisterDB("IceCoreDB")
	
	self.IceHUDFrame = CreateFrame("Frame","IceHUDFrame", UIParent)
	
	
	-- We are ready to load modules
	self:RegisterEvent(IceCore.RegisterModule, "Register")
	self:TriggerEvent(IceCore.Loaded)
	

	-- DEFAULT SETTINGS
	local defaultPreset = "RoundBar"
	local defaults = {
		gap = 150,
		verticalPos = -50,
		scale = 0.9,
		
		alphaooc = 0.3,
		alphaic = 0.6,
		alphaTarget = 0.4,

		alphaoocbg = 0.2,
		alphaicbg = 0.3,
		alphaTargetbg = 0.25,
		
		backgroundToggle = false,
		backgroundColor = {r = 0.5, g = 0.5, b = 0.5},
		barTexture = "Bar",
		barPreset = defaultPreset,
		fontFamily = "IceHUD",
		debug = false
	}
	
	self:LoadPresets()
	for k, v in pairs(self.presets[defaultPreset]) do
		defaults[k] = v
	end
	
	-- get default settings from the modules
	defaults.modules = {}
	for i = 1, table.getn(self.elements) do
		local name = self.elements[i]:GetElementName()
		defaults.modules[name] = self.elements[i]:GetDefaultSettings()	
	end
	
	if (table.getn(self.elements) > 0) then
		defaults.colors = self.elements[1].defaultColors
	end
	
	
	self:RegisterDefaults('account', defaults)
end


function IceCore.prototype:Enable()
	self.settings = self.db.account

	self:DrawFrame()
	
	for i = 1, table.getn(self.elements) do
		self.elements[i]:SetDatabase(self.settings)
		self.elements[i]:Create(self.IceHUDFrame)
		if (self.elements[i]:IsEnabled()) then
			self.elements[i]:Enable(true)
		end
	end

	self.enabled = true
end


function IceCore.prototype:Disable()
	for i = 1, table.getn(self.elements) do
		if (self.elements[i]:IsEnabled()) then
			self.elements[i]:Disable(true)
		end
	end
	
	self.IceHUDFrame:Hide()
	self.enabled = false
end


function IceCore.prototype:IsEnabled()
	return self.enabled
end

function IceCore.prototype:DrawFrame()
	self.IceHUDFrame:SetFrameStrata("BACKGROUND")
	self.IceHUDFrame:SetWidth(self.settings.gap)
	self.IceHUDFrame:SetHeight(20)
	
	self:SetScale(self.settings.scale)
	
	self.IceHUDFrame:SetPoint("CENTER", 0, self.settings.verticalPos)
	self.IceHUDFrame:Show()
end


function IceCore.prototype:Redraw()
	for i = 1, table.getn(self.elements) do
		self.elements[i]:Redraw()
	end
end


function IceCore.prototype:GetModuleOptions()
	local options = {}
	
	for i = 1, table.getn(self.elements) do
		local modName = self.elements[i]:GetElementName()
		local opt = self.elements[i]:GetOptions()
		options[modName] =  {
			type = 'group',
			desc = 'Module options',
			name = modName,
			args = opt
		}
	end
	
	return options
end


function IceCore.prototype:GetColorOptions()
	assert(table.getn(IceHUD.IceCore.elements) > 0, "Unable to get color options, no elements found!")
	
	local options = {}
	
	for k, v in pairs(self.elements[1]:GetColors()) do
		local kk, vv = k, v
		options[k] =  {
			type = 'color',
			desc = k,
			name = k,
			get = function()
				return IceHUD.IceCore:GetColor(kk)
			end,
			set = function(r, g, b)
				local color = k
				IceHUD.IceCore:SetColor(kk, r, g, b)
			end
		}
	end
	
	return options
end


-- Method to handle module registration
function IceCore.prototype:Register(element)
	assert(element, "Trying to register a nil module")
	IceHUD:Debug("Registering: " .. element:ToString())
	table.insert(self.elements, element)
end



-------------------------------------------------------------------------------
-- Configuration methods                                                     --
-------------------------------------------------------------------------------

function IceCore.prototype:ResetSettings()
	self:ResetDB()
	ReloadUI()
end

function IceCore.prototype:GetVerticalPos()
	return self.settings.verticalPos
end
function IceCore.prototype:SetVerticalPos(value)
	self.settings.verticalPos = value
	self.IceHUDFrame:ClearAllPoints()
	self.IceHUDFrame:SetPoint("CENTER", 0, self.settings.verticalPos)
end


function IceCore.prototype:GetGap()
	return self.settings.gap
end
function IceCore.prototype:SetGap(value)
	self.settings.gap = value
	self.IceHUDFrame:SetWidth(self.settings.gap)
	self:Redraw()
end


function IceCore.prototype:GetScale()
	return self.settings.scale
end
function IceCore.prototype:SetScale(value)
	self.settings.scale = value
	
	self.IceHUDFrame:SetScale(value)
end


function IceCore.prototype:GetAlpha(mode)
	if (mode == "IC") then
		return self.settings.alphaic
	elseif (mode == "Target") then
		return self.settings.alphaTarget
	else
		return self.settings.alphaooc
	end
end
function IceCore.prototype:SetAlpha(mode, value)
	if (mode == "IC") then
		self.settings.alphaic = value
	elseif (mode == "Target") then
		self.settings.alphaTarget = value
	else
		self.settings.alphaooc = value
	end
	self:Redraw()
end


function IceCore.prototype:GetAlphaBG(mode)
	if (mode == "IC") then
		return self.settings.alphaicbg
	elseif (mode == "Target") then
		return self.settings.alphaTargetbg
	else
		return self.settings.alphaoocbg
	end
end
function IceCore.prototype:SetAlphaBG(mode, value)
	if (mode == "IC") then
		self.settings.alphaicbg = value
	elseif (mode == "Target") then
		self.settings.alphaTargetbg = value
	else
		self.settings.alphaoocbg = value
	end
	self:Redraw()
end


function IceCore.prototype:GetBackgroundToggle()
	return self.settings.backgroundToggle
end
function IceCore.prototype:SetBackgroundToggle(value)
	self.settings.backgroundToggle = value
	self:Redraw()
end


function IceCore.prototype:GetBackgroundColor()
	local c = self.settings.backgroundColor
	return c.r, c.g, c.b
end
function IceCore.prototype:SetBackgroundColor(r, g, b)
	self.settings.backgroundColor.r = r
	self.settings.backgroundColor.g = g
	self.settings.backgroundColor.b = b
	self:Redraw()
end


function IceCore.prototype:GetBarTexture()
	return self.settings.barTexture
end
function IceCore.prototype:SetBarTexture(value)
	self.settings.barTexture = value
	self:Redraw()
end


function IceCore.prototype:GetBarWidth()
	return self.settings.barWidth
end
function IceCore.prototype:SetBarWidth(value)
	self.settings.barWidth = value
	self:Redraw()
end


function IceCore.prototype:GetBarHeight()
	return self.settings.barHeight
end
function IceCore.prototype:SetBarHeight(value)
	self.settings.barHeight = value
	self:Redraw()
end


function IceCore.prototype:GetBarProportion()
	return self.settings.barProportion
end
function IceCore.prototype:SetBarProportion(value)
	self.settings.barProportion = value
	self:Redraw()
end


function IceCore.prototype:GetBarSpace()
	return self.settings.barSpace
end
function IceCore.prototype:SetBarSpace(value)
	self.settings.barSpace = value
	self:Redraw()
end


function IceCore.prototype:GetBarPreset()
	return self.settings.barPreset
end
function IceCore.prototype:SetBarPreset(value)
	self.settings.barPreset = value
	self:ChangePreset(value)
	self:Redraw()
end
function IceCore.prototype:ChangePreset(value)
	self:SetBarTexture(self.presets[value].barTexture)
	self:SetBarHeight(self.presets[value].barHeight)
	self:SetBarWidth(self.presets[value].barWidth)
	self:SetBarSpace(self.presets[value].barSpace)
	self:SetBarProportion(self.presets[value].barProportion)
end


function IceCore.prototype:GetFontFamily()
	return self.settings.fontFamily 
end
function IceCore.prototype:SetFontFamily(value)
	self.settings.fontFamily  = value
	self:Redraw()
end


function IceCore.prototype:GetDebug()
	return self.settings.debug
end
function IceCore.prototype:SetDebug(value)
	self.settings.debug = value
	IceHUD:SetDebugging(value)
end


function IceCore.prototype:GetColor(color)
	return self.settings.colors[color].r,
		   self.settings.colors[color].g,
		   self.settings.colors[color].b
end
function IceCore.prototype:SetColor(color, r, g, b)
	self.settings.colors[color].r = r
	self.settings.colors[color].g = g
	self.settings.colors[color].b = b
	
	self:Redraw()
end



-------------------------------------------------------------------------------
-- Presets                                                                   --
-------------------------------------------------------------------------------

function IceCore.prototype:LoadPresets()
	self.presets["Bar"] = {
		barTexture = "Bar",
		barWidth = 63,
		barHeight = 150,
		barProportion = 0.34,
		barSpace = 4,
	}
	
	self.presets["HiBar"] = {
		barTexture = "HiBar",
		barWidth = 63,
		barHeight = 150,
		barProportion = 0.34,
		barSpace = 4,
	}
	
	self.presets["RoundBar"] = {
		barTexture = "RoundBar",
		barWidth = 155,
		barHeight = 220,
		barProportion = 0.14,
		barSpace = 1,
	}
end

