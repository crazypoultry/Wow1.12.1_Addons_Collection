local L = AceLibrary("AceLocale-2.2"):new("SacredBuff")
local BS = AceLibrary("Babble-Spell-2.2")
local D = AceLibrary("Dewdrop-2.0")
local _G = getfenv(0)
local _, _, rev = string.find("$Rev: 16352 $", "(%d+)")
SacredBuff.fileRevisions["UI.lua"] = tonumber(rev)
rev = nil

SacredBuff.tooltip = CreateFrame("GameTooltip", "SacredBuffTooltip", UIParent, "GameTooltipTemplate")
SacredBuff.tooltip:SetScript("OnLoad",function() this:SetOwner(WorldFrame, "ANCHOR_NONE") end)
SacredBuff.tooltip:SetFrameStrata("LOW")
SacredBuff.tooltip:SetToplevel(true)
SacredBuff.tooltip:SetMovable(true)
SacredBuff.tooltip:SetClampedToScreen(true)

function SacredBuff:CreateMainFrame()
	local f = CreateFrame("Frame", "SacredBuffFrame", UIParent)
	f:Hide()
	f:EnableMouse(true)
	f:SetMovable(true)
	f:SetHeight(128)
	f:SetWidth(128)
	f:SetClampedToScreen(true)
	
	f.title = f:CreateFontString(nil, "ARTWORK")
	f.title:ClearAllPoints()
	f.title:SetPoint("BOTTOM", f, "TOP", 0, 0)
	f.title:SetFont("Fonts\\ARIALN.ttf", 11, "OUTLINE")
	f.title:SetText(L["SacredBuff"])
	f.title:SetTextColor(1.00, 1.00, 1.00, 1.00)
	
	f:SetBackdrop({ 
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", 
		edgeFile = "", tile = true, tileSize = 16, edgeSize = 16, 
		insets = { left = 0, right = 0, top = 0, bottom = 0 }
	})
	if ( self.db.profile.movable ) then
		f:SetBackdropColor(0.00, 0.00, 0.00, 0.60)
	else
		f:SetBackdropColor(0.00, 0.00, 0.00, 0.00)
		f.title:Hide()
	end
	
	self:RestorePosition()
	self:ScaleFrame()
	
	f:SetScript("OnMouseDown", function()
		if (( arg1 == "LeftButton" ) and ( self.db.profile.movable == true )) then
			f:StartMoving()
			f.isMoving = true
		end
	end)
	f:SetScript("OnMouseUp", function()
		if ( this.isMoving ) then
			f:StopMovingOrSizing()
			self:SavePosition()
			f.isMoving = false
		end
	end)
	f:SetScript("OnHide", function()
		if ( this.isMoving ) then
			f:StopMovingOrSizing()
			f.isMoving = false
		end
	end)
	
	f.main = CreateFrame("Button", nil, f)
	f.main:SetWidth(64)
	f.main:SetHeight(64)
	f.main:EnableMouse(true)
	f.main:SetToplevel(true)
	f.main:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	
	f.main:SetFont("Fonts\\ARIALN.ttf", 16, "OUTLINE")
	f.main:SetHighlightTextColor(1, 1, 0, 1)
	f.main:SetText(self.db.char.candleCount)
	f.main:SetTextColor(1.00, 1.00, 1.00, 1.00)
	f.main:ClearAllPoints()
	f.main:SetPoint("CENTER", f, "CENTER", 0, 0)
	
	f.main:SetNormalTexture("Interface\\Addons\\SacredBuff\\UI\\Symbol32")
	
	f.main:SetScript("OnClick", function()
		SacredBuff:OnClick()
	end)
	
	local t = f:CreateTexture(nil, "OVERLAY")
	t:SetWidth(64)
	t:SetHeight(64)
	t:SetTexture("Interface\\AddOns\\SacredBuff\\UI\\serenity0")
	t:SetPoint("CENTER", f.main, "CENTER", 0, 0)
	f.main.background = t
	
	self.frame = f
	
	self:UpdateCandleCount()
end

function SacredBuff:ScaleFrame()
	self:SavePosition()
	_G["SacredBuffFrame"]:SetScale(self.db.profile.scaleSize)
	self:RestorePosition()
end

function SacredBuff:SavePosition()
	local f = _G["SacredBuffFrame"]
	local x, y = f:GetLeft(), f:GetTop()
	local s = f:GetEffectiveScale()
	x, y = ( x * s ), ( y * s )
	self.db.profile.PosX = x
	self.db.profile.PosY = y
end

function SacredBuff:RestorePosition()
	local x = SacredBuff.db.profile.PosX or 0
	local y = SacredBuff.db.profile.PosY or 0
	local f = _G["SacredBuffFrame"]
	local s = f:GetEffectiveScale()
	x, y = ( x / s ), ( y / s )
	f:ClearAllPoints()
	f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, y)
end

local frameNum = 1
local function newbutton(x, y, tex, noScript)
	local self = SacredBuff
	local f = CreateFrame("Button", "SacredButton"..frameNum, self.frame.main)
	f:SetWidth(35)
	f:SetHeight(35)
	f:ClearAllPoints()
	f:SetPoint("CENTER", self.frame.main, "CENTER", x, y)
	f:SetNormalTexture("Interface\\AddOns\\SacredBuff\\UI\\serenity0")
	f:SetHighlightTexture("Interface\\AddOns\\SacredBuff\\UI\\serenity0")
	f:SetPushedTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
	f:EnableMouse(true)
	f:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	
	f:SetScript("OnLeave", function()
		GameTooltip:Hide()
		GameTooltip:ClearLines()
	end)
	
	local t = f:CreateTexture(nil, "BACKGROUND")
	if ( tex ) then
		t:SetTexture(BS:GetSpellIcon(tex))
		if ( not noScript ) then
			f:SetScript("OnClick", function()
				local onSelf
				if ( arg1 == "RightButton" ) then
					onSelf = true
				end
				CastSpellByName(tex, onSelf)
			end)
		end
	end
	t:SetWidth(26)
	t:SetHeight(26)
	t:ClearAllPoints()
	t:SetPoint("CENTER", f, "CENTER", 0, 0)
	f.icon = t
	
	t = CreateFrame("Model", f:GetName().."Cooldown", f, "CooldownFrameTemplate")
	t:SetWidth(35)
	t:SetHeight(35)
	t:ClearAllPoints()
	t:SetPoint("CENTER", f, "CENTER", 0, 0)
	f.cooldown = t
	
	
	t = f:CreateTexture(nil, "OVERLAY")
	t:SetWidth(40)
	t:SetHeight(40)
	t:SetTexture("Interface\\AddOns\\SacredBuff\\UI\\serenity0")
	t:SetPoint("CENTER", f.icon, "CENTER", 0, 0)
	f.icon.overlay = t
	
	t = f:GetNormalTexture()
	t:SetWidth(40)
	t:SetHeight(40)
	t:ClearAllPoints()
	t:SetPoint("CENTER", f.icon, "CENTER", 0, 0)
	f:SetNormalTexture(t)
	f.normal = t
	
	t = f:GetHighlightTexture()
	t:SetVertexColor( 75/255, 216/255, 241/255 )
	t:SetWidth(40)
	t:SetHeight(40)
	t:ClearAllPoints()
	t:SetBlendMode("BLEND")
	t:SetPoint("CENTER", f, "CENTER", 0, 0)
	f:SetHighlightTexture(t)
	f.highlight = t
	
	t = f:GetPushedTexture()
	t:SetWidth(35)
	t:SetHeight(35)
	t:ClearAllPoints()
	t:SetPoint("CENTER", f, "CENTER", 0, 0)
	t:SetDrawLayer("HIGHLIGHT")
	t:SetBlendMode("ADD")
	f:SetPushedTexture(t)
	f.pushed = t
	
	if ( not SacredBuff:IsActive() ) then
		f:Hide()
	end
	
	frameNum = frameNum + 1
	return f
end

function SacredBuff:UpdateButtons()
	local f = self.frame
	
	if ( self.db.char.spells[ BS["Inner Fire"] ] ) then
		if ( not f.innerFire ) then
			f.innerFire = newbutton(32, -32, BS["Inner Fire"])
		end
		f.innerFire:SetScript("OnEnter", function()
			if ( self.db.profile.tooltip == 0 ) then
				return
			end
			GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT")
			if ( self.db.profile.tooltip == 2 ) then
				GameTooltip:SetSpell(self.db.char.spells[ BS["Inner Fire"] ][1], BOOKTYPE_SPELL)
			elseif ( self.db.profile.tooltip == 1 ) then
				GameTooltip:AddLine(self.db.char.spells[ BS["Inner Fire"] ][3])
				GameTooltip:Show()
			end
		end)
		f.innerFire:Show()
	elseif ( f.innerFire ) then
		f.innerFire:Hide()
	end
	
	if ( self.db.char.spells[ BS["Resurrection"] ] ) then
		if ( not f.resurrection ) then
			f.resurrection = newbutton(0, -45, BS["Resurrection"], true)
		end
		f.resurrection:SetScript("OnEnter", function()
			if ( self.db.profile.tooltip == 0 ) then
				return
			end
			GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT")
			if ( self.db.profile.tooltip == 2 ) then
				GameTooltip:SetSpell(self.db.char.spells[ BS["Resurrection"] ][1], BOOKTYPE_SPELL)
			elseif ( self.db.profile.tooltip == 1 ) then
				GameTooltip:AddLine(self.db.char.spells[ BS["Resurrection"] ][3])
				GameTooltip:Show()
			end
		end)
		f.resurrection:SetScript("OnClick", function()
			SacredBuff:Rezz()
		end)
		f.resurrection:Show()
	elseif ( f.resurrection ) then
		f.resurrection:Hide()
	end
	
	if ( self.racial ) then
		if ( not f.racial) then
			f.racial = newbutton(45, 0, self.racial[4])
			f.racial:SetScript("OnEnter", function()
				if ( self.db.profile.tooltip == 0 ) then
					return
				end
				GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT")
				if ( self.db.profile.tooltip == 2 ) then
					GameTooltip:SetSpell(self.racial[1], BOOKTYPE_SPELL)
				elseif ( self.db.profile.tooltip == 1 ) then
					GameTooltip:AddLine(self.racial[3])
					GameTooltip:Show()
				end
			end)
		else
			f.racial.icon:SetTexture(BS:GetSpellIcon(self.racial[4]))
		end
	elseif ( f.racial ) then
		f.racial:Hide()
	end
	
	if ( self.talent ) then
		if ( not f.talent ) then
			f.talent = newbutton(-45, 0, self.talent[4])
			f.talent:SetScript("OnEnter", function()
				if ( self.db.profile.tooltip == 0 ) then
					return
				end
				GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT")
				if ( self.db.profile.tooltip == 2 ) then
					GameTooltip:SetSpell(self.talent[1], BOOKTYPE_SPELL)
				elseif ( self.db.profile.tooltip == 1 ) then
					GameTooltip:AddLine(self.talent[3])
					GameTooltip:Show()
				end
			end)
		end
		f.talent.icon:SetTexture(BS:GetSpellIcon(self.talent[4]))
	elseif ( f.talent ) then
		f.talent:Hide()
	end
	
	if ( not self.initialized ) then
		if (( self.db.char.spells[ BS["Divine Spirit"] ] ) and ( not f.spirit )) then
			f.spirit = newbutton(-32, 32)
			f.spirit.info = { BS["Prayer of Spirit"], BS:GetSpellIcon("Prayer of Spirit"), BS["Divine Spirit"], BS:GetSpellIcon("Divine Spirit") }
		end
		
		if (( self.db.char.spells[ BS["Power Word: Fortitude"] ] ) and ( not f.fort )) then
			f.fort = newbutton(0, 45)
			f.fort.info = { BS["Prayer of Fortitude"], BS:GetSpellIcon("Prayer of Fortitude"), BS["Power Word: Fortitude"], BS:GetSpellIcon("Power Word: Fortitude") }
		end
		
		if (( self.db.char.spells[ BS["Shadow Protection"] ] ) and ( not f.shadow )) then
			f.shadow = newbutton(32, 32)
			f.shadow.info = { BS["Prayer of Shadow Protection"], BS:GetSpellIcon("Prayer of Shadow Protection"), BS["Shadow Protection"], BS:GetSpellIcon("Shadow Protection") }
		end
		self.initialized = true
	end
	
	if ( UnitLevel("player") > 39 ) then
		if ( not f.mount) then
			f.mount = newbutton(-32, -32)
			D:Register(SacredBuff.frame.mount,
				"dontHook", true,
				"children", function()
					D:FeedAceOptionsTable(SacredBuff.mountMenu)
				end
			)
			local aq = "preferredMount"
			if ( GetRealZoneText() == L["Ahn'Qiraj"] ) then
				aq = "preferredAQMount"
			end
			if ( SacredBuff.db.char[aq] ) then
				local tbl = SacredBuff.db.char[aq]
				local texture = GetContainerItemInfo(tbl[1], tbl[2])
				f.mount.icon:SetTexture(texture)
			else
				f.mount.icon:SetTexture("Interface\\Icons\\Ability_Mount_Charger")
			end
			f.mount:SetScript("OnClick", function()
				if ( D:IsOpen(SacredBuff.frame.mount) ) then
					D:Close(1)
				end
				if ( arg1 == "RightButton" ) then
					if ( IsControlKeyDown() ) then
						SacredBuff:UpdateMountMenu()
						D:Open(SacredBuff.frame.mount)
						return
					end
				end
				SacredBuff:UseMount()
			end)
		end
		f.mount:Show()
	end
	
	self:UpdateSpellIcons()
end