
ArcanePartyBar_GUI = {};

function ArcanePartyBar_GUI.CreateArcaneBar(frameName)
	
	--local frameName = "ArcaneRaidBar"..i
	--local frameName = "ArcanePartyBar"..i
	local frame = CreateFrame("Frame", frameName, parent)
	frame:Hide()
	frame:SetMovable(1)
	frame:SetWidth(100)
	frame:SetHeight(12)
	frame:EnableMouse(0)
	--local previousFrame = getglobal("ArcaneRaidBar"..(i-1))
	--frame:SetPoint("TOPLEFT", previousFrame, "BOTTOMLEFT", 0, 14)
	--frame:SetPoint("BOTTOMLEFT", parent, "BOTTOMRIGHT", 7, 43)
	
	-- Status Bar
	local statusBar = CreateFrame("StatusBar", frameName.."StatusBar", frame, "TextStatusBar")
	frame.StatusBar = statusBar
	statusBar:Show()
	statusBar:SetWidth(105)
	statusBar:SetHeight(12)
	statusBar:SetPoint("TOP", frame, "TOP", 0, -2)
	statusBar:SetFrameLevel(statusBar:GetFrameLevel() - 1)
	statusBar:EnableMouse(0)
	
	statusBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
	
	-- Spark
	local spark = statusBar:CreateTexture(frameName.."StatusBarSpark", "OVERLAY")
	frame.Spark = spark
	spark:SetTexture("Interface\\AddOns\\ArcanePartyBars\\Skin\\ArcaneBarSpark")
	spark:SetWidth(26)
	spark:SetHeight(26)
	spark:SetPoint("CENTER", statusBar, "CENTER", 0, 0)
	spark:SetBlendMode("ADD")
	
	-- Texts
	local nameString = statusBar:CreateFontString(frameName.."StatusBarName", "ARTWORK", "GameFontHighlightSmall")
	frame.Name = nameString
	nameString:Show()
	nameString:SetWidth(94)
	nameString:SetHeight(10)
	nameString:SetPoint("CENTER", statusBar, "CENTER", 0, 1)
	
	local timeString = statusBar:CreateFontString(frameName.."StatusBarTime", "ARTWORK", "GameFontNormalSmall")
	frame.Time = timeString
	timeString:Show()
	timeString:SetPoint("LEFT", frame, "RIGHT", 7, 0)
	
	local targetString = statusBar:CreateFontString(frameName.."StatusBarTarget", "ARTWORK", "GameFontNormalSmall")
	frame.Target = targetString
	targetString:Show()
	targetString:SetPoint("LEFT", timeString, "RIGHT", 3, 0)
	
	-- Border
	--[[
	frame:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-StatusBar-Background", 
		edgeFile = "Interface\\Tooltips\\UI-StatusBar-Border", 
		tile = true, tileSize = 16, edgeSize = 16, 
		insets = { left = 5, right = 5, top = 5, bottom = 5 }
	})
	]]--
	local border = statusBar:CreateTexture(frameName.."StatusBarBorder", "OVERLAY")
	border:SetTexture("Interface\\Tooltips\\UI-StatusBar-Border")
	border:SetWidth(110)
	border:SetHeight(18)
	border:SetPoint("CENTER", statusBar, "CENTER", 0, 0)
	
	-- Transparent background
	local bgTexture = statusBar:CreateTexture(nil, "BACKGROUND")
	bgTexture:SetTexture(0,0,0,0.5)
	bgTexture:SetAllPoints(statusBar)
	
	-- Flash
	local flashTexture = statusBar:CreateTexture(frameName.."Flash", "OVERLAY")
	frame.Flash = flashTexture
	flashTexture:SetTexture("Interface\\AddOns\\ArcanePartyBars\\Skin\\ArcaneBarFlash")
	flashTexture:SetWidth(164)
	flashTexture:SetHeight(34)
	flashTexture:SetPoint("CENTER", statusBar, "CENTER", 0, 0)
	--flashTexture:SetFrameLevel(statusBar:GetFrameLevel() + 1);
	flashTexture:SetBlendMode("ADD")
	
	-- Spell Texture
	local spellTexture = statusBar:CreateTexture(frameName.."SpellTexture", "OVERLAY")
	frame.SpellTexture = spellTexture
	spellTexture:SetTexture("Interface\\Icons\\Spell_Holy_Renew")
	spellTexture:SetWidth(16)
	spellTexture:SetHeight(16)
	spellTexture:SetPoint("RIGHT", frame, "LEFT", -10, -2)
	
	-- Scripts
	ArcanePartyBars.OnLoad(frame)
	frame:SetScript("OnUpdate", ArcanePartyBars.OnUpdate)
	frame:SetScript("OnEnter", ArcanePartyBars.OnEnter)
	frame:SetScript("OnLeave", ArcanePartyBars.OnLeave)
	frame:SetScript("OnMouseUp", ArcanePartyBars.OnMouseUp)
	frame:SetScript("OnMouseDown", ArcanePartyBars.OnMouseDown)
	frame:SetScript("OnShow", ArcanePartyBars.OnShow)
	frame:SetScript("OnHide", ArcanePartyBars.OnHide)
	
	return frame
end

ArcanePartyBar_GUI.NUM_RAID_BARS = 10;

function ArcanePartyBar_GUI.CreateArcaneRaidBars()
	local parent = CreateFrame("Frame", "ArcaneRaidBarFrame", UIParent)
	parent:Show()
	parent:SetMovable(1)
	parent:SetWidth(375)
	parent:SetHeight(234)
	parent:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	
	parent:SetScript("OnMouseUp", ArcanePartyBars.OnMouseUp)
	parent:SetScript("OnMouseDown", ArcanePartyBars.OnMouseDown)
	parent:SetScript("OnHide", ArcanePartyBars.OnHide)
	
	--[[
	-- Transparent background
	local bgTexture = parent:CreateTexture("ArcaneRaidBarFrameBackground", "BACKGROUND")
	bgTexture:SetTexture(0,0,0,0.5)
	bgTexture:SetAllPoints(parent)
	bgTexture:Hide()
	]]--
	
	-- Backdrop
	local backdrop = CreateFrame("Frame", "ArcaneRaidBarFrameBackdrop", parent)
	backdrop:SetAllPoints(parent)
	backdrop:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", 
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", 
		tile = true, tileSize = 16, edgeSize = 16, 
		insets = { left = 5, right = 5, top = 5, bottom = 5 }
	})
	backdrop:SetBackdropColor(0.1, 0.2, 0.6, 0.5)
	backdrop:SetBackdropBorderColor(0.1, 0.2, 0.6)
	backdrop:SetFrameLevel(parent:GetFrameLevel() - 1)
	backdrop:Hide()
	
	-- Arcane Raid Bars
	local anchor = parent;
	local frame = ArcanePartyBar_GUI.CreateArcaneBar("ArcaneRaidBar1")
	frame.isRaidFrame = 1
	frame:SetID(1)
	frame:SetParent(parent)
	frame:SetPoint("TOPLEFT", anchor, "TOPLEFT", 35, -10)
	
	for id=2, ArcanePartyBar_GUI.NUM_RAID_BARS do
		anchor = frame
		frame = ArcanePartyBar_GUI.CreateArcaneBar("ArcaneRaidBar"..id)
		frame.isRaidFrame = 1
		frame:SetID(id)
		frame:SetParent(parent)
		frame:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -10)
	end
end

function ArcanePartyBar_GUI.AddNewArcaneRaidBar()
	local id = ArcanePartyBar_GUI.NUM_RAID_BARS + 1
	local frame = ArcanePartyBar_GUI.CreateArcaneBar("ArcaneRaidBar"..id)
	frame.isRaidFrame = 1
	frame:SetID(id)
	frame:SetParent(ArcaneRaidBarFrame)
	frame:SetPoint("TOPLEFT", "ArcanePartyBar"..(id-1), "BOTTOMLEFT", 0, -10)
	ArcanePartyBar_GUI.NUM_RAID_BARS = id
	return frame
end

function ArcanePartyBar_GUI.CreateArcanePartyBars()
	local parent, frame
	for id=1, MAX_PARTY_MEMBERS do
		parent = getglobal("PartyMemberFrame"..id)
		frame = ArcanePartyBar_GUI.CreateArcaneBar("ArcanePartyBar"..id)
		frame:SetID(id)
		frame:SetParent(parent)
		frame:SetPoint("BOTTOMLEFT", parent, "BOTTOMRIGHT", 7, 43)
	end
end

ArcanePartyBar_GUI.CreateArcanePartyBars()
ArcanePartyBar_GUI.CreateArcaneRaidBars()

