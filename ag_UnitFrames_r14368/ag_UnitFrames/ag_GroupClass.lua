local AceOO = AceLibrary("AceOO-2.0")
local L = AceLibrary("AceLocale-2.2"):new("ag_UnitFrames")
local print = function(msg) if msg then DEFAULT_CHAT_FRAME:AddMessage(msg) end end

-- Group class

aUF.classes.aUFgroup = AceOO.Class("AceEvent-2.0","AceHook-2.0")

function aUF.classes.aUFgroup.prototype:init(objectName)
	aUF.classes.aUFgroup.super.prototype.init(self)
	
	self.name = objectName
	self.variableName = self.name.."_aUFgroup"
	self.index = {}
	self.group = {}
	self.raid = true
	
	if not aUF.db.profile[self.name] then
		local settings = {
			Grow = "down",
			ShowAnchor = true,
		}
		aUF.db.profile[self.name] = settings
	end
	self.database = aUF.db.profile[self.name]
	
	self:CreateFrame()
	self:BorderBackground()
	self:UpdateTitle()
end

function aUF.classes.aUFgroup.prototype:CreateFrame()
	local frameName = "aUFgroup"..self.name
	self.anchor = CreateFrame("Button",frameName,UIParent,"AGraidAnchorTemplate")
	self.anchor:SetScript("OnDragStart",function() self:OnDragStart(arg1) end)
	self.anchor:SetScript("OnDragStop",function() self:OnDragStop(arg1) end)
	self.anchor:SetScript("OnClick",function() self:OnClick(arg1) end)
	self.anchor:SetMovable(true)
	self.anchor:EnableMouse(true)
	self.anchor:RegisterForDrag("LeftButton")
	self.anchor:RegisterForClicks("LeftButtonUp","RightButtonUp","MiddleButtonUp","Button4Up","Button5Up")
	
	self.title = getglobal("aUFgroup"..self.name.."Title")
end

function aUF.classes.aUFgroup.prototype:Reset()
	self:UpdateTitle()
	self:LoadPosition()
end

function aUF.classes.aUFgroup.prototype:UpdateTitle(player)
	if self.raid and player == true then
		self.title:SetText(string.format(L["Group %s *"], self.name))
	else
		self.title:SetText(string.format(L["Group %s"], self.name))
	end
end

function aUF.classes.aUFgroup.prototype.partySortClosure()
	local unitIdIndex = {
		["player"]    = 1,
		["playerpet"] = 2,
		["party1"]    = 3,
		["party1pet"] = 4,
		["party2"]    = 5,
		["party2pet"] = 6,
		["party3"]    = 7,
		["party3pet"] = 8,
		["party4"]    = 9,
		["party4pet"] = 10,
	}

	return function (a, b)
		return (unitIdIndex[a.unit] or 99) < (unitIdIndex[b.unit] or 99)
	end
end

function aUF.classes.aUFgroup.prototype.raidSortClosure()
	local classIndex = {
		["WARRIOR"] = 1,
		["PRIEST"]  = 2,
		["DRUID"]   = 3,
		["PALADIN"] = 4,
		["SHAMAN"]  = 5,
		["MAGE"]    = 6,
		["WARLOCK"] = 7,
		["HUNTER"]  = 8,
		["ROGUE"]   = 9,
	}

	return function (a, b)
		local _,classA = UnitClass(a.unit)
		local _,classB = UnitClass(b.unit)
		return ((classIndex[classA] or 99)..UnitName(a.unit) <
			(classIndex[classB] or 99)..UnitName(b.unit))
	end
end

function aUF.classes.aUFgroup.prototype:EachMember(group)
	local i = 0
	local sortedGroup = {}

	for _,member in pairs(group) do
		table.insert(sortedGroup, member)
	end

	if not self.groupSort then
		if self.group.raid then
			self.groupSort = self.raidSortClosure()
		else
			self.groupSort = self.partySortClosure()
		end
	end

	if self.groupSort then
		table.sort(sortedGroup, self.groupSort)
	end

	return function ()
		i = i + 1
		return sortedGroup[i]
	end
end

function aUF.classes.aUFgroup.prototype:Update()
--	print(self.name)
	if self.lastFrame then
		self.lastFrame:StopMovingOrSizing()
	end
	self.lastFrame = nil
		
	local grow = self.database.Grow
	local relation1, relation2, x, y
	local space = 5
	local player = false
	
	if grow == "up" or not grow then
		relation1 = "BOTTOMLEFT"
		relation2 = "TOPLEFT"
		x = 0
		y = -(space)
	elseif grow == "down" then
		relation1 = "TOPLEFT"
		relation2 = "BOTTOMLEFT"
		x = 0
		y = space
	elseif grow == "left" then
		relation1 = "TOPRIGHT"
		relation2 = "TOPLEFT"
		x = space
		y = 0
	elseif grow == "right" then
		relation1 = "TOPLEFT"
		relation2 = "TOPRIGHT"
		x = -(space)
		y = 0
	end
	
	self.index = {}
	
	if self.group.player and self.group.player.player then
		table.insert(self.index, self.group.player.player)
	end
	if self.group.pet and self.group.pet.pet then
		table.insert(self.index, self.group.pet.pet)
	end
	
	if self.group.party then
		for unitObject in self:EachMember(self.group.party) do
			table.insert(self.index, unitObject)
			if self.group.partypet then
				for _, unitPetObject in self.group.partypet do
					if unitPetObject.parent and unitPetObject.parent == unitObject.unit then
						table.insert(self.index, unitPetObject)
					end
				end
			end
		end
	end
	if self.group.raid then
		for unitObject in self:EachMember(self.group.raid) do
			table.insert(self.index, unitObject)
			if UnitName(unitObject.unit) == UnitName("player") then
				player = true
			end
			if self.group.raidpet then
				for _, unitPetObject in self.group.raidpet do
					if unitPetObject.parent and unitPetObject.parent == unitObject.unit then
						table.insert(self.index, unitPetObject)
					end
				end
			end
		end
	end
	
--	print("---"..self.name)
	local empty = true
	for k,v in ipairs(self.index) do
	
--		print(UnitName(v.unit))
		v.frame:ClearAllPoints()
		if self.index[k-1] then
			v.frame:SetPoint(relation1, self.index[k-1].frame,relation2,x,y)
		else
			empty = false
			self.lastFrame = v.frame					
			if self.raid then
				self.anchor:ClearAllPoints()
				self.anchor:SetPoint(relation2, self.lastFrame,relation1,-x,-y)
				self.anchor:Show()
			end
		end
	end
	if self.lastFrame then
		self.anchor:SetHeight(16)
		self:UpdateWidth()
		self:UpdateScale()
		self:UpdateTitle(player)
	end
	if empty == true or not self.lastFrame or not self.database.ShowAnchor then
		self.anchor:Hide()
	end
	self:LoadPosition()	
end

function aUF.classes.aUFgroup.prototype:UpdateWidth()
	local width = 0
	local scale = 0
	if self.index then
		for _,unitObject in ipairs(self.index) do
			local lwidth = unitObject.frame:GetWidth()
			local swidth = unitObject.frame:GetWidth()*unitObject.frame:GetWidth()
			if lwidth > width then
				width = lwidth
				scale = unitObject.frame:GetScale()
			end
		end
	end
	self.anchor:SetWidth(width)
	if scale > 0 then
		self.anchor:SetScale(scale)
	end
end

function aUF.classes.aUFgroup.prototype:UpdateScale()
	self:UpdateWidth()
end

function aUF.classes.aUFgroup.prototype:BorderBackground()
	local colortable = aUF.db.profile.PartyFrameColors
    local bordercolor = aUF.db.profile.FrameBorderColors
	local borderstyle = aUF.db.profile.BorderStyle
	self.anchor:SetBackdrop({
				bgFile = "Interface\\ChatFrame\\ChatFrameBackground", tile = true, tileSize = 16,
				edgeFile = aUF.Borders[borderstyle].texture, edgeSize = aUF.Borders[borderstyle].size,
				insets = {left = aUF.Borders[borderstyle].insets, right = aUF.Borders[borderstyle].insets, top = aUF.Borders[borderstyle].insets, bottom = aUF.Borders[borderstyle].insets},
		})
	self.anchor:SetBackdropColor(colortable.r,colortable.g,colortable.b,colortable.a)
	self.anchor:SetBackdropBorderColor(bordercolor.r,bordercolor.g,bordercolor.b,bordercolor.a)
end

function aUF.classes.aUFgroup.prototype:OnClick(button)
--	for k,v in self.index do
--		print(v.name)
--	end
	if (IsAltKeyDown() or IsControlKeyDown()) and (button == "LeftButton" or button == "RightButton") then
		aUF.dewdrop:Open(self.anchor, 'children', aUF:GroupCreateMenu(self),'cursorX', true, 'cursorY', true)
		return
	end	
end

local _G = getfenv(0)

function aUF.classes.aUFgroup.prototype:OnDragStart(button)
	if button == "LeftButton" and (aUF.db.profile.Locked == false or IsAltKeyDown()) then
		self.lastFrame:StartMoving()
	end
end

function aUF.classes.aUFgroup.prototype:OnDragStop(button)
	if self.lastFrame then
		self.lastFrame:StopMovingOrSizing()
		self.lastFrame:SetUserPlaced(false)
		self:SavePosition()
	end
end

function aUF.classes.aUFgroup.prototype:LoadPosition()
	if self.lastFrame then
		if (aUF.db.profile.Positions[self.variableName]) then
			local x = aUF.db.profile.Positions[self.variableName].x
			local y = aUF.db.profile.Positions[self.variableName].y
			local scale = self.lastFrame:GetScale()*UIParent:GetEffectiveScale()
			
			self.lastFrame:SetPoint("TOPLEFT", UIParent,"TOPLEFT", x/scale, y/scale)
			
		else
			self.lastFrame:SetPoint("CENTER", UIParent, "CENTER")
		end
	end
	
end

function aUF.classes.aUFgroup.prototype:SavePosition()
	local scale = self.lastFrame:GetEffectiveScale()
--	local scale = 1
	local worldscale = UIParent:GetEffectiveScale()
	
	local x,y = self.lastFrame:GetLeft()*scale , self.lastFrame:GetTop()*scale - (UIParent:GetTop())*worldscale

	if not aUF.db.profile.Positions[self.variableName] then 
		aUF.db.profile.Positions[self.variableName] = {}
	end
	
	aUF.db.profile.Positions[self.variableName].x = x
	aUF.db.profile.Positions[self.variableName].y = y
end
