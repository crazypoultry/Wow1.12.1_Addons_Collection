--[[---------------------------------------------------------------------------------
 locals
------------------------------------------------------------------------------------]]

local Compost           = AceLibrary("Compost-2.0")
local L                 = AceLibrary("AceLocale-2.2"):new("Squishy")
local RL                = AceLibrary("RosterLib-2.0")
local BS                = AceLibrary("Babble-Spell-2.2")
local aura              = AceLibrary("SpecialEvents-Aura-2.0")
local proximity         = ProximityLib:GetInstance("1")

local titlebuttonheight       = 21
local footerheight            = 05
local footerspacer            = 03

local hots = {
	[BS["Renew"]] = true,
	[BS["Rejuvenation"]] = true
}

local shields = {
	[BS["Power Word: Shield"]] = true,
	[BS["Improved Power Word: Shield"]] = true
}

--[[---------------------------------------------------------------------------------
 stuff
------------------------------------------------------------------------------------]]

function Squishy:GetNameColor(class)
	-- If we're using class colors, and we found the class in wow's 
	-- class color table, return the color
	if self.db.profile.DisplayClassColor and RAID_CLASS_COLORS[class] then
		local color = RAID_CLASS_COLORS[class]
		return color.r, color.g, color.b
	-- return grey for pets
	elseif self.db.profile.DisplayClassColor and class == "PET" then
		return 0.5, 0.5, 0.5
	-- Otherwise, just return an off-white color
	else
		return 1, 1, 1
	end
end


function Squishy:GetHealthColor(pct)
	local pct = floor(pct) / 100
	if pct > .5 then
		return (1-pct)*2, 1, 0
	else
		return 1, pct*2, 0
	end
end


function Squishy:GetBarColor(unit, pct)
	local r,g,b
	-- Default style: bar colored by health, black background
	if self.db.profile.BarStyle == "Health" then
		r,g,b = self:GetHealthColor(pct)
		return r,g,b
	-- Class style: bars colored by units class with a slightly darker background
	elseif self.db.profile.BarStyle == "Class" then
		r,g,b = self:GetNameColor(unit.class)
		return r,g,b
	-- CTRaid style: red bar = player, blue = party member, green = everyone else
	else
		if UnitIsUnit(unit.unitid,"player") then r,g,b = 1,0,0
		elseif UnitInParty(unit.unitid) then r,g,b = 0,1,1
		else r,g,b = 0,1,0
		end
		return r,g,b
	end
end


function Squishy:ScreenAlert(percent, msg)
	local r,g,b = self:GetHealthColor(percent)
	self.frames.message:AddMessage(msg, r, g, b, 1)
	self.frames.header:Hide()
	self:CancelScheduledEvent("ResetHeader")
	self:ScheduleEvent("ResetHeader", self.ResetHeader, 3.5, self)
end


function Squishy:ResetHeader()
	self.frames.header:Show()
end


function Squishy:UpdateFrameData(num, u)
	local f = self.frames.units[num]
	f.unit = u.unitid
	
	local pct       = UnitHealth(u.unitid)/UnitHealthMax(u.unitid)*100
	local range,time= proximity:GetUnitRange(u.unitid)
	local lastseen  = GetTime() - (time or 100)
	local alpha     = ( range == 45 and lastseen > 2 and 1 - (lastseen-2)/5 ) or 1
	
	f:SetAlpha(alpha)

	f.Name:SetText(u.name)
	f.Name:SetTextColor(self:GetNameColor(u.class))

	f.Bar:SetValue(pct)
	local r,g,b
	-- set bar color
	r,g,b = self:GetBarColor(u,pct)
	f.Bar:SetStatusBarColor(r,g,b,alpha)
	-- now background
	f.BarBG:SetStatusBarColor(r/5,g/5,b/5,alpha)
	
	local dmg = UnitHealthMax(u.unitid) - UnitHealth(u.unitid)
	if dmg > 0 and self.OptionHealthDeficit then
		f.Deficit:SetText(0-dmg)
		f.Deficit:Show()
	else
		f.Deficit:Hide()
	end
	-- suffix for priority, party, player
	if self.priority[1].name == u.name then
		f.Status:SetAlpha(1)
		f.Status:SetTextColor(1,0,0)
	elseif u.name == UnitName("player") then
		f.Status:SetAlpha(1)
		f.Status:SetTextColor(1,1,1)
	elseif GetNumRaidMembers() > 0 and UnitInParty(u.unitid) then
		f.Status:SetAlpha(1)
		f.Status:SetTextColor(0.5,0.5,1)
	else
		f.Status:SetAlpha(0)
	end
	-- prefix for aggro, healing, renew/rejuv:
	local prefix = ""
	if u.banzai then 
		prefix = prefix .. "|cFFFF0000A|r"
	end
	if u.healstart and GetTime() - u.healstart < 2 then
		prefix = prefix .. "|cFF00FF00H|r"
	end
	for hot in pairs(hots) do
		if aura:UnitHasBuff(u.unitid, hot) then 
			prefix = prefix .. "|cFF0000FFR|r"
			break
		end
	end
	local isShielded = false
	for shield in pairs(shields) do
		if aura:UnitHasBuff(u.unitid, shield) then 
			prefix = prefix .. "|cFFFFFF00S|r"
			isShielded = true
			break
		end
	end
	if not isShielded and aura:UnitHasDebuff(u.unitid, "Weakened Soul") then
			prefix = prefix .. "|cFF666666S|r"
	end
	f.Prefix:SetText(prefix)

--[[	
not working:
	local t = getglobal("SquishyFrameTexture"..num)
	if t then
		if UnitName("target") == u.name then
			t:SetVertexColor(1,1,1,1)
			f:SetNormalTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
			--f:SetButtonState("PUSHED")
		else
			t:SetVertexColor(1,1,1,0)
			--f:SetButtonState("NORMAL")
			f:SetNormalTexture(nil)
		end
	end
]]
	f:Show()
end


function Squishy:UpdateFrameSize(num)
	-- auto-scale emergency frame by number of shown units
	if num == 0 then
		self.frames.main:SetHeight( titlebuttonheight + footerheight )
	else
		self.frames.main:SetHeight( titlebuttonheight + footerheight + footerspacer + ( self.db.profile.BarHeight * num ) + ( self.db.profile.BarSpacing * (num-1) ) )
	end
	self.frames.bg:SetHeight(self.frames.main:GetHeight())
	self.frames.main:Show()
end


function Squishy:CheckVisibility()
	self.showFrame = ( RL.roster[UnitName("player")] and Squishy.db.profile.FrameDisplay == L["always"] or (Squishy.db.profile.FrameDisplay == L["grouped"] and ( GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0 ) ) ) and true or false	
	if self.showFrame then  -- find a way to get rid of this
		self:ShowGUI()
	else
		self:HideGUI()
	end
end


function Squishy:ShowGUI()
	self.frames.main:Show()
	self:ScheduleRepeatingEvent("UpdateEmergencyFrame", self.UpdateEmergencyFrame, 0.2, self)
	self:ScheduleRepeatingEvent("UpdateAllUnits", self.UpdateAllUnits, 5, self)
end


function Squishy:HideGUI()
	self.frames.main:Hide()
   	self:CancelScheduledEvent("UpdateEmergencyFrame")
	self:CancelScheduledEvent("UpdateAllUnits")
end


function Squishy:BuildDisplay()
	-- use Compost to create tables to hold our GUI elements
	self.frames = Compost:Acquire()
	self.frames.units = Compost:Acquire()
	-- create main frame to hold all our gui elements
	self.frames.main = CreateFrame("Frame", "SquishyFrame", UIParent)
	self.frames.main:EnableMouse(false)
	self.frames.main:SetMovable(true)
	self.frames.main:SetClampedToScreen(true)
	self.frames.main:SetPoint("CENTER", UIParent, "CENTER")
	-- create background
	self.frames.bg = CreateFrame("Frame", "SquishyBackground", self.frames.main)
	self.frames.bg:SetFrameStrata("BACKGROUND")
	self.frames.bg:SetFrameLevel(0)
	self.frames.bg:SetPoint("CENTER", self.frames.main, "CENTER")
	-- create bg texture
	self.frames.bg.texture = self.frames.bg:CreateTexture(nil, "BORDER")
	self.frames.bg.texture:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	self.frames.bg.texture:SetPoint("TOPLEFT", self.frames.bg, "TOPLEFT", 4, -4)
	self.frames.bg.texture:SetPoint("BOTTOMRIGHT", self.frames.bg, "BOTTOMRIGHT", -4, 4)
	self.frames.bg.texture:SetBlendMode("ADD")
	self.frames.bg.texture:SetGradientAlpha("VERTICAL", .1, .1, .1, 0, .25, .25, .25, 1)
	-- create header
	self.frames.header = CreateFrame("Button", "SquishyHeader", self.frames.main)
	self.frames.header:EnableMouse(true)
	self.frames.header:SetPoint("TOP", self.frames.main, "TOP", 0, 0)
	self.frames.header:SetScript("OnMouseUp", self.StopMoveFrame)
	self.frames.header:SetScript("OnHide", self.StopMoveFrame)
	self.frames.header:SetScript("OnMouseDown",self.StartMoveFrame)
	-- create font string
	self.frames.headertext = self.frames.header:CreateFontString(nil, "ARTWORK")
	self.frames.headertext:SetFontObject(GameFontHighlightSmall)
	self.frames.headertext:SetJustifyH("CENTER")
	self.frames.headertext:SetJustifyV("BOTTOM")
	self.frames.headertext:SetPoint("TOP", self.frames.header, "TOP", 0, -6)
	-- create message frame
	self.frames.message = CreateFrame("ScrollingMessageFrame", nil, self.frames.main)
	self.frames.message:SetPoint("TOP", self.frames.header, "TOP", 0, -6)
	self.frames.message:SetParent(self.frames.main)
	self.frames.message:SetFadeDuration(1)
	self.frames.message:SetTimeVisible(1.5)
	self.frames.message:SetMaxLines(1)
	self.frames.message:SetFontObject(GameFontHighlightSmall)
	-- update these frames with our settings
	self:UpdateFrame()
	-- create unit frames
	self:UpdateBars()
	-- position and scale frame
	self:RestorePosition()
	self:Scale()
end


function Squishy:UpdateFrame()
	-- main frame
	local totalWidth = 5 + 33 + (self.db.profile.NamePositionInside and 0 or 60) + self.db.profile.BarWidth + 17 + 5
	self.frames.main:SetWidth(totalWidth)
	self.frames.main:SetHeight(titlebuttonheight + footerheight)
	-- background
	self.frames.bg:SetWidth(self.frames.main:GetWidth())
	self.frames.bg:SetHeight(self.frames.main:GetHeight())
	self.frames.bg:SetBackdrop({
		bgFile = "Interface\\ChatFrame\\ChatFrameBackground", tile = true, tileSize = 16,
		edgeFile = self:GetBorder(), edgeSize = 16,
		insets = {left = 4, right = 4, top = 4, bottom = 4},
	})
	self.frames.bg:SetBackdropBorderColor(.5, .5, .5, 1)
	self.frames.bg:SetBackdropColor(0,0,0,0.75)
	self.frames.bg:SetAlpha(self.db.profile.Alpha)
	-- header
	self.frames.header:SetWidth(self.frames.main:GetWidth()-10)
	self.frames.header:SetHeight(titlebuttonheight)
	-- header font string
	self.frames.headertext:SetWidth(self.frames.main:GetWidth()-10)
	self.frames.headertext:SetHeight(12)
	self.frames.headertext:SetText(self.db.profile.FrameTitleOn and L["Squishy Emergency"] or "")
	-- message frame
	self.frames.message:SetWidth(self.frames.main:GetWidth()-10)
	self.frames.message:SetHeight(12)
end


function Squishy:GetBorder()
   if self.db.profile.FrameBorderOn then
      return "Interface\\Tooltips\\UI-Tooltip-Border"
   else
      return nil
   end
end


function Squishy:UpdateBars()
	local totalWidth = 33 + (self.db.profile.NamePositionInside and 0 or 60) + self.db.profile.BarWidth + 17
	for i in self.frames.units do
		self.frames.units[i]:Hide()
	end
	for i = 1, self.db.profile.NumUnits do
		-- create the unit frame if it doesnt exist yet
		if not self.frames.units[i] then
			self:CreateUnitFrame(i)
		end
		-- update layout
		self.frames.units[i]:SetWidth(totalWidth)
		self.frames.units[i]:SetHeight(self.db.profile.BarHeight)
		-- prefix
		self.frames.units[i].Prefix:SetWidth(33)
		self.frames.units[i].Prefix:SetHeight(self.db.profile.BarHeight)
		-- name
		self.frames.units[i].Name:SetWidth(60)
		self.frames.units[i].Name:SetHeight(self.db.profile.BarHeight)
		-- bar background
		self.frames.units[i].BarBG:SetStatusBarTexture( "Interface\\AddOns\\Squishy\\textures\\" .. self.db.profile.BarTexture .. ".tga")
		self.frames.units[i].BarBG:SetWidth(self.db.profile.BarWidth)
		self.frames.units[i].BarBG:SetHeight(self.db.profile.BarHeight)
		self.frames.units[i].BarBG:SetStatusBarColor(0,0,0)
		-- bar
		self.frames.units[i].Bar:SetStatusBarTexture( "Interface\\AddOns\\Squishy\\textures\\" .. self.db.profile.BarTexture .. ".tga")
		self.frames.units[i].Bar:SetWidth(self.db.profile.BarWidth)
		self.frames.units[i].Bar:SetHeight(self.db.profile.BarHeight)
		-- health deficit
		self.frames.units[i].Deficit:SetWidth(45)
		self.frames.units[i].Deficit:SetHeight(self.db.profile.BarHeight)
		-- suffix
		self.frames.units[i].Status:SetWidth(17)
		self.frames.units[i].Status:SetHeight(self.db.profile.BarHeight)
		-- name positioning
		if self.db.profile.NamePositionInside then
			self.frames.units[i].BarBG:SetPoint("LEFT", self.frames.units[i].Prefix, "RIGHT", -5, 0)
		else
			self.frames.units[i].BarBG:SetPoint("LEFT", self.frames.units[i].Name, "RIGHT", 0, 0)
		end
	end
	-- position all frames
	self.frames.units[1]:SetPoint("TOPLEFT", self.frames.header, "BOTTOMLEFT", 0, 0)
	for i = 2, self.db.profile.NumUnits do
		self.frames.units[i]:SetPoint("TOPLEFT", self.frames.units[i-1], "BOTTOMLEFT", 0, -(self.db.profile.BarSpacing))
	end
end


function Squishy:CreateUnitFrame(i)
	-- create frame
	self.frames.units[i] = CreateFrame("Button", nil, self.frames.main)
	self.frames.units[i]:Hide()
	self.frames.units[i]:EnableMouse(true)			
	self.frames.units[i]:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up")
	self.frames.units[i]:SetScript("OnClick", self.OnClick)
	-- create prefix
	self.frames.units[i].Prefix = self.frames.units[i]:CreateFontString(nil, "ARTWORK")
	self.frames.units[i].Prefix:SetFontObject(GameFontHighlightSmall)
	self.frames.units[i].Prefix:SetJustifyH("CENTER")
	self.frames.units[i].Prefix:SetPoint("LEFT", self.frames.units[i], "LEFT", 0, 0)
	-- create name tag
	self.frames.units[i].Name = self.frames.units[i]:CreateFontString(nil, "ARTWORK")
	self.frames.units[i].Name:SetFontObject(GameFontHighlightSmall)
	self.frames.units[i].Name:SetJustifyH("LEFT")
	self.frames.units[i].Name:SetPoint("LEFT", self.frames.units[i].Prefix, "RIGHT", 0, 0)
	-- create bar background	
	self.frames.units[i].BarBG = CreateFrame("StatusBar", nil, self.frames.units[i])
	self.frames.units[i].BarBG:SetMinMaxValues(0,100)
	self.frames.units[i].BarBG:SetPoint("LEFT", self.frames.units[i].Name, "RIGHT", 0, 0)
	self.frames.units[i].BarBG:SetFrameLevel(1)
	-- create bar
	self.frames.units[i].Bar = CreateFrame("StatusBar", nil, self.frames.units[i])
	self.frames.units[i].Bar:SetMinMaxValues(0,100)
	self.frames.units[i].Bar:SetPoint("LEFT", self.frames.units[i].BarBG, "LEFT", 0, 0)
	self.frames.units[i].Bar:SetFrameLevel(2)
	-- create health deficit
	self.frames.units[i].Deficit = self.frames.units[i].Bar:CreateFontString(nil, "ARTWORK")
	self.frames.units[i].Deficit:SetFontObject(GameFontHighlightSmall)
	self.frames.units[i].Deficit:SetJustifyH("RIGHT")
	self.frames.units[i].Deficit:SetPoint("RIGHT", self.frames.units[i].Bar, "RIGHT", -1, 0)
	-- create suffix
	self.frames.units[i].Status = self.frames.units[i]:CreateFontString(nil, "ARTWORK")
	self.frames.units[i].Status:SetFontObject(GameFontHighlightSmall)
	self.frames.units[i].Status:SetJustifyH("CENTER")
	self.frames.units[i].Status:SetPoint("LEFT", self.frames.units[i].Bar, "RIGHT", 0, 0)
	self.frames.units[i].Status:SetText("<")
	-- set texture
	self.frames.units[i]:SetNormalTexture(1,1,1,0)
	self.frames.units[i]:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
-- NOT WORKING:
--	self.frames.units[i]:SetPushedTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
--	local t = frame:CreateTexture("SquishyFrameTexture"..i)
--	t:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
--	frame:SetNormalTexture(t)
end


function Squishy:SetBarTexture(locTextureName)
	local texture
	-- Try to get the variable name for this localized text, which we can use to
	-- do a loopup in our texture table
	if L:HasReverseTranslation(locTextureName) then
		texture = L:GetReverseTranslation(locTextureName)
	-- If we couldn't do that (for whatever reason), we'll just set it to Default
	-- which we know exists.  Should never happen, and would mess up localized text
	-- for non-english.
	else
		texture = "Default"
	end
	self.db.profile.BarTexture = texture
end


function Squishy:StartMoveFrame()
	if not Squishy.db.profile.FrameLock and arg1 == "LeftButton" then
		Squishy.frames.main:StartMoving()
		Squishy.frames.main.isMoving = true
	end
end


function Squishy:StopMoveFrame()
	if Squishy.frames.main.isMoving then
		Squishy.frames.main:StopMovingOrSizing()
		Squishy:SavePosition()
		Squishy.frames.main.isMoving = false
	end
end


function Squishy:Scale()
	self:SavePosition()
	self.frames.main:SetScale(self.db.profile.ScaleSize)
	self:RestorePosition()
end


function Squishy:SavePosition()
	local f = self.frames.main
	local x,y = f:GetLeft(), f:GetTop()
	local s = f:GetEffectiveScale()
	x,y = x*s,y*s
	Squishy.db.profile.PosX = x
	Squishy.db.profile.PosY = y
end


function Squishy:RestorePosition()
	local x = Squishy.db.profile.PosX or 0
	local y = Squishy.db.profile.PosY or 0
	local f = self.frames.main
	local s = f:GetEffectiveScale()
	x,y = x/s,y/s
	f:ClearAllPoints()
	f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, y)
end

