oRogueHelper = AceLibrary("AceAddon-2.0"):new("AceDB-2.0", "AceEvent-2.0")

function oRogueHelper:OnInitialize()
	self:RegisterDB("oRHDB")
	self:RegisterDefaults('profile', {})
end

function oRogueHelper:OnEnable()
	self:Frame()
	self:updatePositions()
	
	self:RegisterEvent("MEETINGSTONE_CHANGED", function()
		self:updateCP()
		self:updateEnergy("player")
	end)
	self:RegisterEvent("PLAYER_COMBO_POINTS", "updateCP")
	self:RegisterEvent("UNIT_ENERGY", "updateEnergy")
end

function oRogueHelper:Frame()
	local f, _ = GameFontHighlightSmall:GetFont()
	
	self.frame = CreateFrame("Frame", "oRHFrame", UIParent)
	self.frame:SetWidth(86)
	self.frame:SetHeight(32)
	self.frame:SetPoint("CENTER", UIParent, "CENTER")
	self.frame:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16,
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16,
		insets = {left = 4, right = 4, top = 4, bottom = 4},
	})
	self.frame:SetBackdropBorderColor(0, 0, 0)
	self.frame:SetBackdropColor(0, 0, 0)
	self.frame:SetMovable(true)
	self.frame:EnableMouse(true)
	self.frame:RegisterForDrag("LeftButton")
	self.frame:SetScript("OnDragStart", function() if(IsAltKeyDown()) then this:StartMoving() end end)
	self.frame:SetScript("OnDragStop", function() this:StopMovingOrSizing() self:savePosition() end)
	
	self.frame.CP = self.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	self.frame.CP:SetPoint("CENTER", self.frame, "CENTER", 0, -6)
	self.frame.CP:SetShadowOffset(.8, -.8)
	self.frame.CP:SetShadowColor(0, 0, 0, 1)
	
	self.frame.Energy = self.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	self.frame.Energy:SetPoint("CENTER", self.frame, "CENTER", 0, 6)
	self.frame.Energy:SetShadowOffset(.8, -.8)
	self.frame.Energy:SetShadowColor(0, 0, 0, 1)
end

function oRogueHelper:updateCP()
	local cp = GetComboPoints()
	if(cp == 5) then
		self.frame.CP:SetTextColor(1, 0, 0)
	else
		self.frame.CP:SetTextColor(1, 1, 0)
	end
	if (GetLocale() == "koKR") then
		self.frame.CP:SetText(string.format("%d의 %d", MAX_COMBO_POINTS, cp))
	else
		self.frame.CP:SetText(string.format("%d of %d", cp, MAX_COMBO_POINTS))
	end
end

function oRogueHelper:updateEnergy(a1)
	if(a1 == "player") then
		local mc, mx = UnitMana("player"), UnitManaMax("player")
		if(mc == mx) then
			self.frame.Energy:SetTextColor(0, 1, 0)
		else
			self.frame.Energy:SetTextColor(1, 1, 0)
		end
		if (GetLocale() == "koKR") then
			self.frame.Energy:SetText(string.format("%d의 %d", mx, mc))
		else
			self.frame.Energy:SetText(string.format("%d of %d", mc, mx))
		end
	end
end

function oRogueHelper:updatePositions()
	if(self.db.profile.Pos) then
		local z = self:Split(self.db.profile.Pos, " ")
		local s = self.frame:GetEffectiveScale()
		
		self.frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", z[1]/s, z[2]/s)
	elseif(self.frame) then
		self.frame:ClearAllPoints()
		self.frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	end
end

function oRogueHelper:savePosition()
	local f = self.frame
	local x,y = f:GetLeft(), f:GetTop()
	local s = f:GetEffectiveScale()
	
	x,y = x*s,y*s
	
	self.db.profile.Pos = x.." "..y
end

function oRogueHelper:Split(msg, char)
	local arr = { };
	while (string.find(msg, char) ) do
		local iStart, iEnd = string.find(msg, char);
		tinsert(arr, strsub(msg, 1, iStart-1));
		msg = strsub(msg, iEnd+1, strlen(msg));
	end
	if ( strlen(msg) > 0 ) then
		tinsert(arr, msg);
	end
	return arr;
end