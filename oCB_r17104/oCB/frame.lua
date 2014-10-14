function oCB:CreateFramework(b, n, s)
	self.frames[b] = CreateFrame("Frame", n, UIParent)
	self.frames[b]:Hide()
	self.frames[b].name = b
	
	if(s =="MirrorBar") then
		self.frames[b]:SetScript("OnUpdate", self.OnMirror)
	else
		self.frames[b]:SetScript("OnUpdate", self.OnCasting)
	end
	self.frames[b]:SetMovable(true)
	self.frames[b]:EnableMouse(true)
	self.frames[b]:RegisterForDrag("LeftButton")
	self.frames[b]:SetScript("OnDragStart", function() if not self.db.profile.lock then this:StartMoving() end end)
	self.frames[b]:SetScript("OnDragStop", function() this:StopMovingOrSizing() self:savePosition() end)
	
	self.frames[b].Bar = CreateFrame("StatusBar", nil, self.frames[b])
	self.frames[b].Spark = self.frames[b].Bar:CreateTexture(nil, "OVERLAY")
	self.frames[b].Time = self.frames[b].Bar:CreateFontString(nil, "OVERLAY")
	self.frames[b].Spell = self.frames[b].Bar:CreateFontString(nil, "OVERLAY")
	if(s ~="MirrorBar") then
		self.frames[b].Delay = self.frames[b].Bar:CreateFontString(nil, "OVERLAY")
	end
	
	self:Layout(b, s)
end

function oCB:Layout(b, s)
	local db = self.db.profile[s or b]
	local f, _ = GameFontHighlightSmall:GetFont()
	
	self.frames[b]:SetWidth(db.width+9)
	self.frames[b]:SetHeight(db.height+10)
	self.frames[b]:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16,
		edgeFile = self.Borders[db.edgeFile], edgeSize = 16,
		insets = {left = 4, right = 4, top = 4, bottom = 4},
	})
	self.frames[b]:SetBackdropBorderColor(0, 0, 0)
	self.frames[b]:SetBackdropColor(0, 0, 0)
	
	self.frames[b].Bar:ClearAllPoints()
	self.frames[b].Bar:SetPoint("CENTER", self.frames[b], "CENTER", 0, 0)
	self.frames[b].Bar:SetWidth(db.width)
	self.frames[b].Bar:SetHeight(db.height)
	self.frames[b].Bar:SetStatusBarTexture(self.surface:Fetch(db.texture))
	
	self.frames[b].Spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
	self.frames[b].Spark:SetWidth(16)
	self.frames[b].Spark:SetHeight(db.height*2.44)
	self.frames[b].Spark:SetBlendMode("ADD")
	
	self.frames[b].Time:SetJustifyH("RIGHT")
	self.frames[b].Time:SetFont(f,db.timeSize)
	self.frames[b].Time:SetText("X.Y")
	self.frames[b].Time:ClearAllPoints()
	self.frames[b].Time:SetPoint("RIGHT", self.frames[b].Bar, "RIGHT",-10,0)
	self.frames[b].Time:SetShadowOffset(.8, -.8)
	self.frames[b].Time:SetShadowColor(0, 0, 0, 1)
	
	self.frames[b].Spell:SetJustifyH("CENTER")
	self.frames[b].Spell:SetWidth(db.width-self.frames[b].Time:GetWidth())
	self.frames[b].Spell:SetFont(f,db.spellSize)
	self.frames[b].Spell:ClearAllPoints()
	self.frames[b].Spell:SetPoint("LEFT", self.frames[b], "LEFT",10,0)
	self.frames[b].Spell:SetShadowOffset(.8, -.8)
	self.frames[b].Spell:SetShadowColor(0, 0, 0, 1)
	
	if(s ~="MirrorBar") then
		self.frames[b].Delay:SetTextColor(1,0,0,1)
		self.frames[b].Delay:SetJustifyH("RIGHT")
		self.frames[b].Delay:SetFont(f,db.delaySize)
		self.frames[b].Delay:SetText("X.Y")
		self.frames[b].Delay:ClearAllPoints()
		self.frames[b].Delay:SetPoint("TOPRIGHT", self.frames[b], "TOPRIGHT",-10,20)
		self.frames[b].Delay:SetShadowOffset(.8, -.8)
		self.frames[b].Delay:SetShadowColor(0, 0, 0, 1)
	end
	
	self:updatePositions(b)
end

function oCB:ShowBlizzCB()
	CastingBarFrame["Show"] = self.BlizzShow
end

function oCB:HideBlizzCB()
	if(not self.BlizzShow) then self.BlizzShow = CastingBarFrame["Show"] end
	CastingBarFrame["Show"] = function() end
end