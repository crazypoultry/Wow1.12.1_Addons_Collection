----------------------------
--      Declaration       --
----------------------------

local AceOO = AceLibrary("AceOO-2.0")

GotWood.bar = AceOO.Class("AceEvent-2.0", "AceDebug-2.0", "AceDB-2.0", "CandyBar-2.0")

----------------------------
--      Main Functions    --
----------------------------

function GotWood.bar.prototype:init(pos, ele)
    -- Call Superclass
    GotWood.bar.super.prototype.init(self)
    
    -- Debugging state
    self:SetDebugging(false)
    
    -- Save position
    self.pos = pos-1
    self.ele = ele
    self:RegisterDB("GotWoodDB")
    
    self:CreateCandyBar()
end

function GotWood.bar.prototype:CreateCandyBar()
    self:RegisterCandyBar("gotwood"..self.ele, 1, "N/A", nil, "Green", "Yellow", "Orange", "Red")
    self:SetCandyBarFade("gotwood"..self.ele, 2)
	self:SetCandyBarTexture("gotwood"..self.ele, "Interface\\Addons\\GotWood\\images\\BantoBar")
    local position = (self.pos*17)+15
    --self:SetCandyBarPoint("gotwood"..self.ele, "TOPLEFT", GotWood.frame, "TOPLEFT", 10, -position)
	if self.pos ~= 0 then
		self:SetCandyBarPoint("gotwood"..self.ele, "TOPLEFT", GotWood:GetPreviousBar(self.pos), "BOTTOMLEFT", 0, -2)
	else
		self:SetCandyBarPoint("gotwood"..self.ele, "TOPLEFT", GotWood.frame, "TOPLEFT", 10, -15)
	end
end

function GotWood.bar.prototype:SetTexture(tex)
    self:SetCandyBarIcon("gotwood"..self.ele, tex)
    self.db.profile["Texture"..self.ele] = tex
end

function GotWood.bar.prototype:SetTime(time)
    self:SetCandyBarTime("gotwood"..self.ele, time)
end

function GotWood.bar.prototype:Start(name, rank)
    self.name = name
    if rank then
        self.rank = rank
        self:SetCandyBarText("gotwood"..self.ele, name.." ("..rank..")")
    else
        self:SetCandyBarText("gotwood"..self.ele, name)
    end
    self:StartCandyBar("gotwood"..self.ele)
    self:Debug("Start called")
end

function GotWood.bar.prototype:Stop()
    self:StopCandyBar("gotwood"..self.ele)
    self:Debug("Stop called")
end

function GotWood.bar.prototype:Delete()
    self:UnregisterCandyBar("gotwood"..self.ele)
end

function GotWood.bar.prototype:GetRestTime()
    local _, time, elapsed, _ = self:CandyBarStatus("gotwood"..self.ele)
    if time and elapsed then
        return time-elapsed
    end
    return 0
end

function GotWood.bar.prototype:GetName()
    return self.name
end

function GotWood.bar.prototype:StartFromSwitch(time, name)
    if time > 0 then
        self:SetTime(time)
        self:SetCandyBarIcon("gotwood"..self.ele, self.db.profile["Texture"..self.ele])
        self:Start(name)
    end
end

function GotWood.bar.prototype:SetPosition(pos)
    self.pos = pos-1
    local position = (self.pos*17)+15
    self:SetCandyBarPoint("gotwood"..self.ele, "TOPLEFT", GotWood.frame, "TOPLEFT", 10, -position)
end

function GotWood.bar.prototype:SetLife(life)
    self.life = life
end

function GotWood.bar.prototype:SetTotemDamage(dmg)
    if not self.life then return end
    self.life = self.life-dmg
    if self.life<0 then
        self.life = nil
        self:Stop()
    end
end

function GotWood.bar.prototype:GetFrame()
	return AceLibrary("CandyBar-2.0").var.handlers["gotwood"..self.ele].frame
end

function GotWood.bar.prototype:SetScale(scale)
	self:SetCandyBarScale("gotwood"..self.ele, scale)
end

function GotWood.bar.prototype:SetOnClick(spell)
	self:SetCandyBarOnClick("gotwood"..self.ele, self.Click, spell)
end

function GotWood.bar.prototype:Click(name, spell)
	CastSpellByName(spell)
end