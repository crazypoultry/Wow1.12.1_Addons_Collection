-- GridLayout.lua
-- insert boilerplate

--{{{ Libraries

local Compost = AceLibrary("Compost-2.0")
local AceOO = AceLibrary("AceOO-2.0")
local L = AceLibrary("AceLocale-2.2"):new("Grid")

--}}}

--{{{ Class for party header

local GridLayoutPartyClass = AceOO.Class()

function GridLayoutPartyClass.prototype:init()
	GridLayoutPartyClass.super.prototype.init(self)
	self:CreateFrames()
	self:SetOrientation()
end

function GridLayoutPartyClass.prototype:CreateFrames()
	self.frame = CreateFrame("Frame", "GridLayoutParty", GridLayoutFrame, nil)

	if Grid.isTBC then
		self.playerFrame = CreateFrame("Button", "GridLayoutPartyPlayer", GridLayoutParty, "GridFrameTemplateSecure")
		self.partyFrame = CreateFrame("Frame", "GridLayoutPartyHeader", GridLayoutParty, "SecurePartyHeaderTemplate")
		self.partyFrame:SetAttribute("template", "GridFrameTemplateSecure")
	else
		self.playerFrame = CreateFrame("Button", "GridLayoutPartyPlayer", GridLayoutParty, "GridFrameTemplate")
		self.partyFrame = CreateFrame("Frame", "GridLayoutPartyHeader", GridLayoutParty, "InsecurePartyHeaderTemplate")
		self.partyFrame:SetScript("OnAttributeChanged", InsecurePartyHeader_OnAttributeChanged)
		self.partyFrame:SetAttribute("template", "GridFrameTemplate")
	end
	self.playerFrame:SetAttribute("unit", "player")

	self.playerFrame:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 0, 0)
	self.partyFrame:SetPoint("TOPLEFT", self.playerFrame, "BOTTOMLEFT", 0, 0)
	self:UpdateSize()
	self.frame:Show()
	self.playerFrame:Show()
	self.partyFrame:Show()
end

function GridLayoutPartyClass.prototype:Reset()
	self.partyFrame:SetAttribute("sortMethod", "NAME")
end

function GridLayoutPartyClass.prototype:SetOrientation(horizontal)
	if horizontal then
		self.partyFrame:ClearAllPoints()
		self.partyFrame:SetPoint("TOPLEFT", self.playerFrame, "TOPRIGHT", GridLayout.db.profile.Padding, 0)
		self.partyFrame:SetAttribute("xOffset", GridLayout.db.profile.Padding)
		self.partyFrame:SetAttribute("yOffset", 0)
		self.partyFrame:SetAttribute("point", "LEFT")
	else
		self.partyFrame:ClearAllPoints()
		self.partyFrame:SetPoint("TOPLEFT", self.playerFrame, "BOTTOMLEFT", 0, 0-GridLayout.db.profile.Padding)
		self.partyFrame:SetAttribute("xOffset", 0)
		self.partyFrame:SetAttribute("yOffset", 0-GridLayout.db.profile.Padding)
		self.partyFrame:SetAttribute("point", "TOP")
	end
	-- self:UpdateSize() -- not needed because GridLayout:UpdateSize() will call it
end

function GridLayoutPartyClass.prototype:UpdateSize()
	self.frame:SetWidth(self.playerFrame:GetWidth() +
		(self.partyFrame:GetWidth() + GridLayout.db.profile.Padding) *
		( (GridLayout.db.profile.horizontal and GetNumPartyMembers() > 0) and 1 or 0))
	self.frame:SetHeight(self.playerFrame:GetHeight() +
		(self.partyFrame:GetHeight() + GridLayout.db.profile.Padding) *
		( (GridLayout.db.profile.horizontal or GetNumPartyMembers() <= 0) and 0 or 1))
end

function GridLayoutPartyClass.prototype:GetFrameWidth()
	return self.frame:GetWidth()
end

function GridLayoutPartyClass.prototype:GetFrameHeight()
	return self.frame:GetHeight()
end

function GridLayoutPartyClass.prototype:IsFrameVisible()
	return self.frame:IsVisible()
end

--}}}
--{{{ Class for group headers

local GridLayoutHeaderClass = AceOO.Class()
local NUM_HEADERS = 0

function GridLayoutHeaderClass.prototype:init()
	GridLayoutHeaderClass.super.prototype.init(self)
	self:CreateFrames()
	self:Reset()
	self:SetOrientation()
end

function GridLayoutHeaderClass.prototype:Reset()
	self.frame:SetAttribute("nameList", nil)
	self.frame:SetAttribute("groupFilter", nil)
	self.frame:SetAttribute("sortMethod", "NAME")
	self.frame:SetAttribute("sortDir", nil)
	self.frame:Hide()
end

function GridLayoutHeaderClass.prototype:CreateFrames()
	NUM_HEADERS = NUM_HEADERS + 1
	if Grid.isTBC then
		self.frame = CreateFrame("Frame", "GridLayoutHeader"..NUM_HEADERS, GridLayoutFrame, "SecureRaidGroupHeaderTemplate")
		self.frame:SetAttribute("template", "GridFrameTemplateSecure")
	else
		self.frame = CreateFrame("Frame", "GridLayoutHeader"..NUM_HEADERS, GridLayoutFrame, "InsecureRaidGroupHeaderTemplate")
		self.frame:SetScript("OnAttributeChanged", InsecureRaidGroupHeader_OnAttributeChanged)
		self.frame:SetAttribute("template", "GridFrameTemplate")
	end
end

function GridLayoutHeaderClass.prototype:GetFrameAttribute(name)
	return self.frame:GetAttribute(name)
end

function GridLayoutHeaderClass.prototype:SetFrameAttribute(name, value)
	return self.frame:SetAttribute(name, value)
end

function GridLayoutHeaderClass.prototype:GetFrameWidth()
	return self.frame:GetWidth()
end

function GridLayoutHeaderClass.prototype:GetFrameHeight()
	return self.frame:GetHeight()
end

function GridLayoutHeaderClass.prototype:IsFrameVisible()
	return self.frame:IsVisible()
end

-- nil or false for vertical
function GridLayoutHeaderClass.prototype:SetOrientation(horizontal)
	if horizontal then
		self.frame:SetAttribute("xOffset", GridLayout.db.profile.Padding)
		self.frame:SetAttribute("yOffset", 0)
		self.frame:SetAttribute("point", "LEFT")
	else
		self.frame:SetAttribute("xOffset", 0)
		self.frame:SetAttribute("yOffset", 0-GridLayout.db.profile.Padding)
		self.frame:SetAttribute("point", "TOP")
	end
end

-- return the number of visible units belonging to the GroupHeader
function GridLayoutHeaderClass.prototype:GetVisibleUnitCount()
	local count = 0
	while self.frame:GetAttribute("child"..count) do
		count = count + 1
	end
	return count
end

--}}}

--{{{ GridLayout
--{{{  Initialization

GridLayout = Grid:NewModule("GridLayout")

--{{{  AceDB defaults

GridLayout.defaultDB = {
	Padding = 1,
	Spacing = 10,
	ScaleSize = 1.0,
	BorderR = .5,
	BorderG = .5,
	BorderB = .5,
	BorderA = 1,
	BackgroundR = .1,
	BackgroundG = .1,
	BackgroundB = .1,
	BackgroundA = .65,
	FrameLock = false,
	FrameDisplay = "always",
	layout = "By Group 40",
	horizonal = false,
	showParty = true,
	debug = false,
}

--}}}
--{{{  AceOptions table

GridLayout.options = {
	type = "group",
	name = L["Layout"],
	desc = L["Options for GridLayout."],
	args = {
		["padding"] = {
			type = "range",
			name = L["Padding"],
			desc = L["Adjust frame padding."],
			max = 20,
			min = 0,
			step = 1,
			get = function ()
				      return GridLayout.db.profile.Padding
			      end,
			set = function (v)
				      GridLayout.db.profile.Padding = v
				      GridLayout:LoadLayout(GridLayout.db.profile.layout)
			      end,
		},
		["spacing"] = {
			type = "range",
			name = L["Spacing"],
			desc = L["Adjust frame spacing."],
			max = 100,
			min = 0,
			step = 1,
			get = function ()
				      return GridLayout.db.profile.Spacing
			      end,
			set = function (v)
				      GridLayout.db.profile.Spacing = v
				      GridLayout:LoadLayout(GridLayout.db.profile.layout)
			      end,
		},
		["scale"] = {
			type = "range",
			name = L["Scale"],
			desc = L["Adjust Grid scale."],
			min = 0.5,
			max = 2.0,
			step = 0.05,
			isPercent = true,
			get = function ()
				      return GridLayout.db.profile.ScaleSize
			      end,
			set = function (v)
				      GridLayout.db.profile.ScaleSize = v
				      GridLayout:Scale()
			      end,
		},
		["border"] = {
			type = "color",
			name = L["Border"],
			desc = L["Adjust border color and alpha."],
			get = function ()
				      return GridLayout.db.profile.BorderR, GridLayout.db.profile.BorderG, GridLayout.db.profile.BorderB, GridLayout.db.profile.BorderA
			      end,
			set = function (r, g, b, a)
				      GridLayout.db.profile.BorderR, GridLayout.db.profile.BorderG, GridLayout.db.profile.BorderB, GridLayout.db.profile.BorderA = r, g, b, a
				      GridLayout:UpdateColor()
			      end,
			hasAlpha = true
		},
		["background"] = {
			type = "color",
			name = L["Background"],
			desc = L["Adjust background color and alpha."],
			get = function ()
				      return GridLayout.db.profile.BackgroundR, GridLayout.db.profile.BackgroundG, GridLayout.db.profile.BackgroundB, GridLayout.db.profile.BackgroundA
			      end,
			set = function (r, g, b, a)
				      GridLayout.db.profile.BackgroundR, GridLayout.db.profile.BackgroundG, GridLayout.db.profile.BackgroundB, GridLayout.db.profile.BackgroundA = r, g, b, a
				      GridLayout:UpdateColor()
			      end,
			hasAlpha = true
		},
		["lock"] = {
			type = "toggle",
			name = L["Frame lock"],
			desc = L["Locks/unlocks the grid for movement."],
			get = function() return GridLayout.db.profile.FrameLock end,
			set = function()
				GridLayout.db.profile.FrameLock = not GridLayout.db.profile.FrameLock
			end,
		},
		["horizontal"] = {
			type = "toggle",
			name = L["Horizontal groups"],
			desc = L["Switch between horzontal/vertical groups."],
			get = function ()
				      return GridLayout.db.profile.horizontal
			      end,
			set = function (v)
				      GridLayout.db.profile.horizontal = v
				      GridLayout:LoadLayout(GridLayout.db.profile.layout)
			      end,
		},
		["display"] = {
			type = "text",
			name = L["Show Frame"],
			desc = L["Sets when the Grid is visible: Choose 'always' or 'grouped'."],
			get = function() return GridLayout.db.profile.FrameDisplay end,
			set = function(v)
				GridLayout.db.profile.FrameDisplay = v
				GridLayout:CheckVisibility()
			end,
			validate = {L["always"], L["grouped"]},
		},
		["party"] = {
			type = "toggle",
			name = L["Show Party in Raid"],
			desc = L["Show party/self as an extra group."],
			get = function ()
				return GridLayout.db.profile.showParty
			end,
			set = function (v)
				GridLayout.db.profile.showParty = v
				GridLayout:LoadLayout(GridLayout.db.profile.layout)
			end,
		},
		["layout"] = {
			type = "text",
			name = L["Raid Layout"],
			desc = L["Select which raid layout to use."],
			get = function ()
				      return GridLayout.db.profile.layout
			      end,
			set = function (v)
				      GridLayout.db.profile.layout = v
				      GridLayout:LoadLayout(v)
			      end,
			validate = {},
		},
	},
}

--}}}
--}}}

GridLayout.layoutSettings = {}
GridLayout.layoutPartyClass = GridLayoutPartyClass
GridLayout.layoutHeaderClass = GridLayoutHeaderClass

function GridLayout:OnInitialize()
	self.super.OnInitialize(self)
	self.layoutGroups = Compost:Acquire()
end

function GridLayout:OnEnable()
	if not self.frame then
		self:CreateFrames()
	end
	self:LoadLayout(self.db.profile.layout)
	-- position and scale frame
	self:RestorePosition()
	self:Scale()

	self:RegisterEvent("Grid_UnitJoined", "DelayedUpdateSize")
	self:RegisterEvent("Grid_UnitLeft", "DelayedUpdateSize")
	self:RegisterEvent("Grid_UnitChanged", "DelayedUpdateSize")
	self:RegisterEvent("Grid_UpdateSort")

	self.super.OnEnable(self)
end

function GridLayout:OnDisable()
	self.frame:Hide()
	self.super.OnDisable(self)
end

function GridLayout:Reset()
	self.super.Reset(self)

	self:LoadLayout(self.db.profile.layout)
	-- position and scale frame
	self:RestorePosition()
	self:Scale()
end

function GridLayout:StartMoveFrame()
	if not GridLayout.db.profile.FrameLock and arg1 == "LeftButton" then
		self.frame:StartMoving()
		self.frame.isMoving = true
	end
end

function GridLayout:StopMoveFrame()
	if self.frame.isMoving then
		self.frame:StopMovingOrSizing()
		self:SavePosition()
		self.frame.isMoving = false
	end
end

function GridLayout:CreateFrames()
	-- create main frame to hold all our gui elements
	local f = CreateFrame("Frame", "GridLayoutFrame", UIParent)
	f:EnableMouse(true)
	f:SetMovable(true)
	f:SetClampedToScreen(true)
	f:SetPoint("CENTER", UIParent, "CENTER")
	f:SetScript("OnMouseUp", function () self:StopMoveFrame() end)
	f:SetScript("OnHide", function () self:StopMoveFrame() end)
	f:SetScript("OnMouseDown", function () self:StartMoveFrame() end)
	f:SetFrameStrata("MEDIUM")
	-- create background
	f:SetFrameLevel(0)
	f:SetBackdrop({
				 bgFile = "Interface\\ChatFrame\\ChatFrameBackground", tile = true, tileSize = 16,
				 edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16,
				 insets = {left = 4, right = 4, top = 4, bottom = 4},
			 })
	-- create bg texture
	f.texture = f:CreateTexture(nil, "BORDER")
	f.texture:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	f.texture:SetPoint("TOPLEFT", f, "TOPLEFT", 4, -4)
	f.texture:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -4, 4)
	f.texture:SetBlendMode("ADD")
	f.texture:SetGradientAlpha("VERTICAL", .1, .1, .1, 0, .2, .2, .2, 0.5)

	self.frame = f

	self.partyGroup = self.layoutPartyClass:new()
end

function GridLayout:PlaceGroup(layoutGroup, groupNumber)
	local frame = layoutGroup.frame
	local x, y

	if self.db.profile.horizontal then
		y = (frame:GetHeight() + self.db.profile.Padding) * (groupNumber - 1) + self.db.profile.Spacing
		x = self.db.profile.Spacing
	else
		-- vertical
		x = (frame:GetWidth() + self.db.profile.Padding) * (groupNumber - 1) + self.db.profile.Spacing
		y = self.db.profile.Spacing
	end

	frame:ClearAllPoints()
	frame:SetParent(self.frame)
	frame:SetPoint("TOPLEFT", self.frame, "TOPLEFT", x, -y)

	self:Debug("Placing group", groupNumber, x, -y)
end

function GridLayout:AddLayout(layoutName, layout)
	self.layoutSettings[layoutName] = layout
	table.insert(self.options.args.layout.validate, layoutName)
end

function GridLayout:LoadLayout(layoutName)
	local i, attr, value
	local groupsNeeded, groupsAvailable
	local layout = self.layoutSettings[layoutName]

	self:Debug("LoadLayout", layoutName)

	groupsNeeded = (GetNumRaidMembers() > 0) and layout and table.getn(layout) or 0
	groupsAvailable = table.getn(self.layoutGroups)

	-- create groups as needed
	while groupsNeeded > groupsAvailable do
		table.insert(self.layoutGroups, self.layoutHeaderClass:new())
		groupsAvailable = groupsAvailable + 1
	end

	-- hide unused groups
	for i = groupsNeeded + 1, groupsAvailable, 1 do
		self.layoutGroups[i]:Reset()
	end

	-- show party
	if GetNumRaidMembers() < 1 or self.db.profile.showParty then
		self.partyGroup:SetOrientation(self.db.profile.horizontal)
		self.partyGroup.frame:Show()
		self:PlaceGroup(self.partyGroup, 1)
	else
		self.partyGroup.frame:Hide()
	end

	-- configure groups
	for i = 1, groupsNeeded do
		local layoutGroup = self.layoutGroups[i]

		-- apply defaults
		if layout.defaults then
			for attr,value in pairs(layout.defaults) do
				layoutGroup:SetFrameAttribute(attr, value)
			end
		end

		-- apply settings
		for attr,value in pairs(layout[i]) do
			layoutGroup:SetFrameAttribute(attr, value)
		end

		-- place groups
		layoutGroup:SetOrientation(self.db.profile.horizontal)
		layoutGroup.frame:Show()
		if self.db.profile.showParty then
			self:PlaceGroup(layoutGroup, i + 1)
		else
			self:PlaceGroup(layoutGroup, i)
		end
	end

	self:UpdateDisplay()
end

function GridLayout:UpdateDisplay()
	-- there should be some logic in here to detect if we're in a party or
	-- raid when the SecurePartyHeader is added

	self:UpdateColor()
	self:CheckVisibility()
	self:UpdateSize()
end

function GridLayout:DelayedUpdateSize()
	self:ScheduleEvent("GridLayoutUpdateSize", function ()
			GridLayout:Debug("Grid_UpdateSize")
			GridLayout:UpdateSize()
		end, 0.1)
end

function GridLayout:Grid_UpdateSort()
	self:ScheduleEvent("GridLayoutUpdateSize", function ()
			GridLayout:Debug("Grid_UpdateSort")
			GridLayout:LoadLayout(self.db.profile.layout)
		end, 0.1)
end

-- since we may want to resize the grid while in combat, this function doesn't
-- move/hide/show any of the layout groups
function GridLayout:UpdateSize()
	local layoutGroup
	local groupCount = 0
	local maxHeight = 0
	local maxWidth = 0
	local x, y

	if GetNumRaidMembers() < 1 or self.db.profile.showParty then
		groupCount = groupCount + 1
		self.partyGroup:UpdateSize()
		maxHeight = self.partyGroup:GetFrameHeight()
		maxWidth = self.partyGroup:GetFrameWidth()
	end

	for _,layoutGroup in ipairs(self.layoutGroups) do
		if layoutGroup:IsFrameVisible() then
			groupCount = groupCount + 1
			if layoutGroup:GetFrameHeight() > maxHeight then
				maxHeight = layoutGroup:GetFrameHeight()
			end
			if layoutGroup:GetFrameWidth() > maxWidth then
				maxWidth = layoutGroup:GetFrameWidth()
			end
		end
	end

	if self.db.profile.horizontal then
		x = maxWidth + self.db.profile.Spacing * 2
		y = groupCount * (maxHeight + self.db.profile.Padding) - self.db.profile.Padding + self.db.profile.Spacing * 2
	else
		x = groupCount * (maxWidth + self.db.profile.Padding) - self.db.profile.Padding + self.db.profile.Spacing * 2
		y = maxHeight + self.db.profile.Spacing * 2
	end

	self.frame:SetWidth(x)
	self.frame:SetHeight(y)
end

function GridLayout:UpdateColor()
	self.frame:SetBackdropBorderColor(GridLayout.db.profile.BorderR, GridLayout.db.profile.BorderG, GridLayout.db.profile.BorderB, GridLayout.db.profile.BorderA)
	self.frame:SetBackdropColor(GridLayout.db.profile.BackgroundR, GridLayout.db.profile.BackgroundG, GridLayout.db.profile.BackgroundB, GridLayout.db.profile.BackgroundA)
	self.frame.texture:SetGradientAlpha("VERTICAL", .1, .1, .1, 0, .2, .2, .2, GridLayout.db.profile.BackgroundA/2 )
end

function GridLayout:CheckVisibility()
	if self.db.profile.FrameDisplay == L["always"] or GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0 then
		self.frame:Show()
	else
		-- we should probably shutdown modules here?
		self.frame:Hide()
	end
end

function GridLayout:SavePosition()
	local f = self.frame
	local x, y = f:GetLeft(), f:GetTop()
	local s = f:GetEffectiveScale()

	if x and y and s then
		x, y = x*s, y*s
		self.db.profile.PosX = x
		self.db.profile.PosY = y
	end
end

function GridLayout:RestorePosition()
	local f = self.frame
	local x = self.db.profile.PosX or 500
	local y = self.db.profile.PosY or 400
	local s = f:GetEffectiveScale()
	x, y = x/s, y/s
	f:ClearAllPoints()
	f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, y)
end

function GridLayout:Scale()
	self:SavePosition()
	self.frame:SetScale(self.db.profile.ScaleSize)
	self:RestorePosition()
end
--}}}
