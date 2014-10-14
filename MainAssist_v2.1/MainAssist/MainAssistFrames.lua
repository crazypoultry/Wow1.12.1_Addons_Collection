local AceOO = AceLibrary("AceOO-2.0")

---------------------------------------
--       MA_UnitFrame Class          --
---------------------------------------
MA_UnitFrame = AceOO.Class()
local L = AceLibrary("AceLocale-2.2"):new("MainAssist")
local dewdrop = AceLibrary("Dewdrop-2.0")

function MA_UnitFrame.prototype:init(parent,width,height,clickable)
    MA_UnitFrame.super.prototype.init(self)
	
	self.FRAME_WIDTH = width
	self.FRAME_HEIGHT = height
	self.Movable = movable
	self.TargetOnClick = clickable;
	self.Movable = false;
	--Main Frame
	self.frame = CreateFrame("Frame",nil,parent)
	self.frame:SetFrameStrata("BACKGROUND")
	self.frame:SetWidth(self.FRAME_WIDTH)
	self.frame:SetHeight(26)
	self.frame:EnableMouse(true)
	self.frame:SetScript("OnMouseUp",function() 
										if arg1 == "LeftButton" and self.TargetOnClick and self.UnitID and UnitExists(self.UnitID) then 
											TargetUnit(self.UnitID) 
										end 
									end
								);

	--Background Texture
	self.Background = self.frame:CreateTexture(nil,"BACKGROUND")
	self.Background:SetTexture("Interface\\Addons\\MainAssist\\images\\gradient.tga")
	self.Background:SetVertexColor(0.3,0.3,0.3,1)
	self.Background:SetAllPoints(self.frame)
	
	--HealthBar Texture
	self.HealthBar = self.frame:CreateTexture(nil,"OVERLAY")
	self.HealthBar:SetTexture("Interface\\Addons\\MainAssist\\images\\gradient.tga")
	self.HealthBar:SetVertexColor(0,0.6,0.35,1)
	self.HealthBar:SetPoint("TOPLEFT",self.frame,"TOPLEFT",0,0)
	self.HealthBar:SetPoint("BOTTOMLEFT",self.frame,"BOTTOMLEFT",0,0)
	self.HealthBar:SetWidth(self.FRAME_WIDTH)
	
	--Top line of text showing name
	self.NameText = self.frame:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
	self.NameText:SetText("")
	self.NameText:SetPoint("TOPLEFT",self.frame,"TOPLEFT",0,0)
	self.NameText:SetPoint("TOPRIGHT",self.frame,"TOPRIGHT",0,0)
	self.NameText:SetHeight(self.FRAME_HEIGHT/2)
	self.NameText:SetVertexColor(1, 1, 1)
	
	--Bottom line of text for status
	self.StatusText = self.frame:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
	self.StatusText:SetText("")
	self.StatusText:SetPoint("BOTTOMLEFT",self.frame,"BOTTOMLEFT",0,2)
	self.StatusText:SetPoint("BOTTOMRIGHT",self.frame,"BOTTOMRIGHT",0,2)
	self.StatusText:SetHeight(self.FRAME_HEIGHT/2)
	self.StatusText:SetVertexColor(1, 1, 1)
	
end

--updates the unitframe from a unitid ("player","target","raid5target" etc) 
function MA_UnitFrame.prototype:UpdateFromUnit(unit)
	if unit and UnitExists(unit) then
		self.NameText:SetText(UnitName(unit))
		local hp = UnitHealth(unit)/UnitHealthMax(unit)
		self:UpdateHealthBar(hp)
		if hp > 0 then
			self.StatusText:SetText(math.floor(hp*100).."%")
		else
			self.StatusText:SetText(L["STATUS_DEAD"])
		end
	else
		self.NameText:SetText(L["STATUS_NONE"])
		self.StatusText:SetText("")
		self:UpdateHealthBar(0)
	end
	self.UnitID = unit
end

--updates the values shown manaully, hp is 0.0 - 1.0 and only changes the healthbar
function MA_UnitFrame.prototype:Update(name,status,hp,UnitID)
	self.NameText:SetText(name)
	self.StatusText:SetText(status)
	self:UpdateHealthBar(hp)
	self.UnitID = UnitID
end

function MA_UnitFrame.prototype:UpdateHealthBar(hp) 
	if not hp then hp = 0 end
	if hp > 0 then
		self.HealthBar:Show()
		self.HealthBar:SetWidth( hp * self.FRAME_WIDTH )
	else
		self.HealthBar:Hide()
	end
end

function MA_UnitFrame.prototype:SetColor(Color)
	if Color then self.Background:SetVertexColor(Color.r,Color.g,Color.b) end
end	

---------------------------------------
--       MA_AssistFrame Class        --
---------------------------------------

MA_AssistFrame = AceOO.Class()
function MA_AssistFrame.prototype:init(parent)
    MA_AssistFrame.super.prototype.init(self)

	self.frame = CreateFrame("Frame",nil,parent);
	self.frame:SetFrameStrata("BACKGROUND");
	self.frame:SetWidth(150);
	self.frame:SetHeight(26);
	
	self.list = ""
	
	self.AssistFrame = MA_UnitFrame:new(self.frame,80,26,true)
	self.TargetFrame = MA_UnitFrame:new(self.frame,80,26,true)
	self.TargetTargetFrame = MA_UnitFrame:new(self.frame,80,26,true)
	
	self.AssistFrame.frame:SetPoint("TOPLEFT",self.frame,"TOPLEFT",0,0)
	self.TargetFrame.frame:SetPoint("TOPLEFT",self.AssistFrame.frame,"TOPRIGHT",0,0)
	self.TargetTargetFrame.frame:SetPoint("TOPLEFT",self.TargetFrame.frame,"TOPRIGHT",0,0)
	
	self.RaidIcon = self.frame:CreateTexture(nil,"OVERLAY")
	self.RaidIcon:SetWidth(20);
	self.RaidIcon:SetHeight(20);
	self.RaidIcon:Hide();
	self.RaidIcon:SetPoint("RIGHT",self.frame,"LEFT",0,0);
	self.RaidIcon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")

	self.frame:SetMovable(true)
	self.frame:EnableMouse(true)
	self.frame:SetPoint("TOPLEFT",UIParent,"CENTER",0,0);
	self.frame:Hide()
	
	dewdrop:Register(self.AssistFrame.frame,'children', function(level, value) self:CreateDDMenu(level, value) end )
	--default to hidden ToT frame
	self:ShowToT(false)
end

function MA_AssistFrame.prototype:CreateDDMenu(level, value)
    -- Create drewdrop menu
    if level == 1 then
    	dewdrop:AddLine('text', self.assistname, 'isTitle', true )
    	
    	if self.list == "Custom" then
    		dewdrop:AddLine('text', L["MOVE_UP"],
    						'func', function(name) MainAssist:MoveCustomTank(name) end,
    						'closeWhenClicked', true,
    						'arg1', self.assistname )
    		dewdrop:AddLine('text', L["MOVE_DOWN"],
    						'func', function(name) MainAssist:MoveCustomTank(name,true) end,
    						'closeWhenClicked', true,
    						'arg1', self.assistname )	
    		dewdrop:AddLine('text', "", 'isTitle', true )
    		dewdrop:AddLine('text', L["REMOVE"],
    						'func', function(name) MainAssist:RemoveCustomTank(name) end,
    						'closeWhenClicked', true,
    						'arg1', self.assistname )
    		dewdrop:AddLine('text', "", 'isTitle', true )
    	end
    	
		if MainAssist:GetCustomAssist() == self.assistname then
			dewdrop:AddLine('text', L["CLEAR_CUSTOM_ASSIST"],
							'func', function(name) MainAssist:SetCustomAssist(nil) end,
							'closeWhenClicked', true,
							'arg1', self.assistname )
		else
			dewdrop:AddLine('text', L["SET_CUSTOM_ASSIST"],
							'func', function(name) MainAssist:SetCustomAssist(name) end,
							'closeWhenClicked', true,
							'arg1', self.assistname )
		end
    end
end

function MA_AssistFrame.prototype:SetList(list)
	self.list = list
end

function MA_AssistFrame.prototype:UpdateFromUnit(Unit,numtargeting)
	local status = ""
	if UnitIsDead(Unit) then
		status = L["STATUS_DEAD"]
	end
	self.assistname = UnitName(Unit)
	if numtargeting then
		status = status.."("..numtargeting..")"
	end
	
	self.AssistFrame:Update(UnitName(Unit),status,0,Unit)
	
	if UnitExists(Unit.."target") then
		self:UpdateRaidIcon(GetRaidTargetIndex(Unit.."target"))
	else
		self:UpdateRaidIcon()
	end
	
	self.TargetFrame:UpdateFromUnit(Unit.."target")
	if self.ShowTargetTarget then
		self.TargetTargetFrame:UpdateFromUnit(Unit.."targettarget")
	end
end

function MA_AssistFrame.prototype:Update(Name, Status, hp, prefix)
	self.assistname = Name
	if prefix then
		self.AssistFrame:Update(prefix..Name,Status,hp)
	else
		self.AssistFrame:Update(Name,Status,hp)
	end
	self:UpdateRaidIcon()
	self.TargetFrame:UpdateFromUnit()
	if self.ShowTargetTarget then
		self.TargetTargetFrame:UpdateFromUnit()
	end
end

function MA_AssistFrame.prototype:SetColor(Color)
	if Color then self.AssistFrame:SetColor(Color) end
end

function MA_AssistFrame.prototype:UpdateWidth()
	local width = 160
	if self.ShowTargetTarget then
		width = width + 80
	end
	self.frame:SetWidth(width)
end

function MA_AssistFrame.prototype:UpdateRaidIcon(iconindex)
	if iconindex then
		local iconinfo = UnitPopupButtons["RAID_TARGET_"..iconindex];
		if iconinfo then
			self.RaidIcon:SetTexCoord(iconinfo.tCoordLeft,iconinfo.tCoordRight,iconinfo.tCoordTop,iconinfo.tCoordBottom);
			self.RaidIcon:Show();
		else
			self.RaidIcon:Hide();
		end
	else
		self.RaidIcon:Hide();
	end
end

function MA_AssistFrame.prototype:ShowToT(visible)
	self.ShowTargetTarget = visible
	
	if self.ShowTargetTarget then
		self.TargetTargetFrame.frame:Show()
	else
		self.TargetTargetFrame.frame:Hide()
	end
	self:UpdateWidth()
end

function MA_AssistFrame.prototype:SetNameColor(color)
	if color.r and color.g and color.b then
		self.AssistFrame.NameText:SetVertexColor(color.r, color.g, color.b)
	end
end

--pass through some common frame functions to the main frame
function MA_AssistFrame.prototype:Show()
    self.frame:Show()
end

function MA_AssistFrame.prototype:Hide()
    self.frame:Hide()
end

function MA_AssistFrame.prototype:ClearAllPoints()
    self.frame:ClearAllPoints()
end

function MA_AssistFrame.prototype:SetPoint(point,relativeTo,relativePoint,xOffset,yOffset)
	self.frame:SetPoint(point,relativeTo,relativePoint,xOffset,yOffset)
end

function MA_AssistFrame.prototype:SetScript(handler,script)
    self.frame:SetScript(handler,script)
end

function MA_AssistFrame.prototype:tostring()
    return "MainAssistFrame"
end


---------------------------------------
--       MA_HeaderFrame Class        --
---------------------------------------

MA_HeaderFrame = AceOO.Class()
function MA_HeaderFrame.prototype:init(parent)
    MA_HeaderFrame.super.prototype.init(self)
	
	self.frame = CreateFrame("Frame",nil,parent);
	self.frame:SetFrameStrata("BACKGROUND");
	self.frame:SetWidth(150);
	self.frame:SetHeight(13);
	
	self.Text = self.frame:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
	self.Text:SetText("")
	self.Text:SetAllPoints(self.frame)
	
	self.frame:SetPoint("TOPLEFT",UIParent,"CENTER",0,0);
	self.frame:Hide()
end

function MA_HeaderFrame.prototype:SetText(text)
	self.Text:SetText(text)
end

function MA_HeaderFrame.prototype:Show()
    self.frame:Show()
end

function MA_HeaderFrame.prototype:ClearAllPoints()
    self.frame:ClearAllPoints()
end

function MA_HeaderFrame.prototype:SetPoint(anchorPoint,relativeTo,relativePoint,xOffset,yOffset)
	self.frame:SetPoint(anchorPoint,relativeTo,relativePoint,xOffset,yOffset)
end

function MA_HeaderFrame.prototype:SetScript(handler,script)
    self.frame:SetScript(handler,script)
end

function MA_HeaderFrame.prototype:Hide()
    self.frame:Hide()
end

