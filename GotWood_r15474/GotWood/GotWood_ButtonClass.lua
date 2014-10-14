----------------------------
--      Declaration       --
----------------------------

local AceOO = AceLibrary("AceOO-2.0")

GotWood.button = AceOO.Class("AceEvent-2.0", "AceDebug-2.0", "AceDB-2.0", "CandyBar-2.0")

----------------------------
--      Main Functions    --
----------------------------

function GotWood.button.prototype:init(pos, ele)
    -- Call Superclass
    GotWood.button.super.prototype.init(self)
    
    -- Debugging state
    self:SetDebugging(false)
    
    -- Save position
    self.pos = pos-1
    self.ele = ele
    self:RegisterDB("GotWoodDB")
    
    self:CreateButton()
end

function GotWood.button.prototype:CreateButton()
    self.button = CreateFrame("Button", nil, UIParent)
    self.button:Hide()
    self.button:SetWidth(30)
    self.button:SetHeight(30)
	self.button:EnableMouse(true)
	self.button:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up")
	self.button:SetScript("OnClick", function() self:Click() end )
    if self.db.profile["Texture"..self.pos] then
        self.button:SetNormalTexture(self.db.profile["Texture"..self.ele])
    end
    self.button:SetAlpha(0.5)
    
    self.time = self.button:CreateFontString("$parentTime","ARTWORK","GameFontNormalSmall")
    self.time:SetWidth(36)
    self.time:SetHeight(10)
    self.time:SetPoint("TOP", self.button, "BOTTOM", 0, -2)
    self.time:Show()
    
    local position = (self.pos*35)+10
    
    self.button:SetPoint("TOPLEFT", GotWood.frame, "TOPLEFT", position, -15)
    self.button:Show()
end

function GotWood.button.prototype:SetTexture(tex)
    self.button:SetNormalTexture(tex)
    self.db.profile["Texture"..self.pos] = tex
    self.button:Show()
end

function GotWood.button.prototype:SetTime(time)
    self.resttime = time-1
    self.button:SetAlpha(1)
    self.time:SetText(self:SecondsToTimeAbbrev(self.resttime))
end

-- Thanks to neronix for that function
function GotWood.button.prototype:SecondsToTimeAbbrev(time)
    local m, s
    if( time < 0 ) then
        text = ""
    elseif( time < 3600 ) then
        m = floor(time / 60)
        s = mod(time, 60)
        if (m==0) then 
            text = format("00:%02d", s)
        else
            text = format("%02d:%02d", m, s)
        end
    end
    return text
end

function GotWood.button.prototype:Start(name)
    if self.updatetimer then
        self:CancelScheduledEvent(self.updatetimer)
    end
    self.name = name
    self.updatetimer = self:ScheduleRepeatingEvent(self.UpdateTime, 1, self)
end

function GotWood.button.prototype:Stop()
    self:CancelScheduledEvent(self.updatetimer)
    self.button:SetAlpha(0.5)
    self.time:SetText("")
end

function GotWood.button.prototype:UpdateTime()
    if self.resttime >= 0 then
        self.resttime = self.resttime - 1
        self.time:SetText(self:SecondsToTimeAbbrev(self.resttime))
    else
        self:CancelScheduledEvent(self.updatetimer)
        self.button:SetAlpha(0.5)
        self.time:SetText("")
    end
end

function GotWood.button.prototype:Delete()
    if self.updatetimer then
        self:CancelScheduledEvent(self.updatetimer)
    end
    self.button:Hide()
    self.button = nil
    self.time = nil
end

function GotWood.button.prototype:GetRestTime()
    if self.resttime and self.resttime >= 0 then
        return self.resttime
    else
        return 0
    end
end

function GotWood.button.prototype:GetName()
    return self.name
end

function GotWood.button.prototype:StartFromSwitch(time, name)
    if time > 0 then
        self.button:SetAlpha(1)
        self.resttime = time
        self:Start(name)
    end
end

function GotWood.button.prototype:SetPosition(pos)
    self.pos = pos-1
    local position = (self.pos*35)+10
    self.button:SetPoint("TOPLEFT", GotWood.frame, "TOPLEFT", position, -15)
end

function GotWood.button.prototype:SetLife(life)
    self.life = life
end

function GotWood.button.prototype:SetTotemDamage(dmg)
    if not self.life then return end
    self.life = self.life-dmg
    if self.life<0 then
        self.life = nil
        self:Stop()
    end
end

function GotWood.button.prototype:SetScale(scale)
	self.button:SetScale(scale)
end

function GotWood.button.prototype:SetOnClick(spell)
	self.SpellOnClick = spell
end

function GotWood.button.prototype:Click()
	CastSpellByName(self.SpellOnClick)
end