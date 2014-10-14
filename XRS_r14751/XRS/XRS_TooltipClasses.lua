----------------------------
--      Declaration       --
----------------------------

local AceOO = AceLibrary("AceOO-2.0")
local L = AceLibrary("AceLocale-2.2"):new("XRS")
local BC = AceLibrary("Babble-Class-2.2")
local tablet = AceLibrary("Tablet-2.0")
local compost = AceLibrary("Compost-2.0")
local crayon = AceLibrary("Crayon-2.0")
local roster = AceLibrary("RosterLib-2.0")

XRS.abstracttooltip = AceOO.Class("AceDebug-2.0")
XRS.abstracttooltip.virtual = true

-------------------------------
-- Abstract Class Definition --
-------------------------------

function XRS.abstracttooltip.prototype:init(parent, clickable)
    -- Call Superclass
    XRS.abstracttooltip.super.prototype.init(self)
    
    -- Debugging state
    self:SetDebugging(false)
    
    -- Store parent for reference
    self.parent = parent
    
    self:InitTooltip(clickable)
    
    self:Debug("Tooltip registered: "..self.parent:GetType())
end

function XRS.abstracttooltip.prototype:InitTooltip(clickable)
    -- Register the tooltip
    tablet:Register(self.parent:GetObject(),
                    'point', function()
                        local curX, curY = self:GetScaledCursorPosition()
                        if curY < GetScreenHeight() / 2 then
                            point, relativePoint = "BOTTOM", "BOTTOM"
                        else
                            point, relativePoint = "TOP", "TOP"
                        end
                        if curX < GetScreenWidth() / 2 then
                            point, relativePoint = point .. "LEFT", relativePoint .. "RIGHT"
                        else
                            point, relativePoint = point .. "RIGHT", relativePoint .. "LEFT"
                        end
                        return point, relativePoint
                    end,
                    'children', function() self:TooltipData() end,
                    'detachedData', {},
                    'clickable', clickable,
                    'showTitleWhenDetached', true
                    )
end

-- Tooltip classes need to implement this method
function XRS.abstracttooltip.prototype:TooltipData()
    error("TooltipData not implemented", 2)
end

-- Copy from dewdrop ...
function XRS.abstracttooltip.prototype:GetScaledCursorPosition()
    local x, y = GetCursorPosition()
    local scale = UIParent:GetEffectiveScale()
    return x / scale, y / scale
end

function XRS.abstracttooltip.prototype:Refresh()
    tablet:Refresh(self.parent:GetObject())
end

function XRS.abstracttooltip.prototype:Remove()
    tablet:Unregister(self.parent:GetObject())
end

function XRS.abstracttooltip.prototype:Detach()
    tablet:Detach(self.parent:GetObject())
end

function XRS.abstracttooltip.prototype:Close()
    tablet:Close(self.parent:GetObject())
end

--------------------------
-- Main Tooltip Classes --
--------------------------

-- Tooltip for type 'life'
XRS.lifetooltip = AceOO.Class(XRS.abstracttooltip)

function XRS.lifetooltip.prototype:init(bar)
    XRS.lifetooltip.super.prototype.init(self, bar, false)
end

function XRS.lifetooltip.prototype:TooltipData()
    tablet:SetTitle(tostring(self.parent))
    if XRS:GetHintOption() then tablet:SetHint(L["Bar_Hint"]) end
    local cat = tablet:AddCategory(
                    'columns', 2
                )
    
    local t = compost:Acquire()
    for num=1,40 do
        local raidID = "raid"..num
        local _, class = UnitClass("raid"..num)
        local _, _, subgroup, _, _, _, _, online, isDead = GetRaidRosterInfo(num)
        if UnitExists(raidID) and online and self.parent:IsGroup(subgroup) and self.parent:IsClass(class) then
            if self.parent.data.includeDeaths or (not isDead and not UnitIsGhost(raidID)) then
                local health = UnitHealth(raidID)
                local healthMax = UnitHealthMax(raidID)
                
                cPerc = (health/healthMax)*100
                if cPerc<100 then
                    table.insert(t, {raidID, cPerc})
                end
            end
        end
    end
    
    table.sort(t, function(a,b) return a[2]>b[2] end)
    
    for _,v in ipairs(t) do
        local _, class = UnitClass(v[1])
        local r,g,b = BC:GetColor(class)
        cat:AddLine(
            'text', UnitName(v[1]),
            'textR', r,
            'textG', g,
            'textB', b,
            'text2', string.format("%.0f",v[2])
        )
    end
    
    compost:Reclaim(t)
    t = nil
end

-- Tooltip for type 'mana'
XRS.manatooltip = AceOO.Class(XRS.abstracttooltip)

function XRS.manatooltip.prototype:init(bar)
    XRS.manatooltip.super.prototype.init(self, bar, false)
end

function XRS.manatooltip.prototype:TooltipData()
    tablet:SetTitle(tostring(self.parent))
    if XRS:GetHintOption() then tablet:SetHint(L["Bar_Hint"]) end
    local cat = tablet:AddCategory(
                    'columns', 2
                )
    
    local t = compost:Acquire()
    for num=1,40 do
        local raidID = "raid"..num
        local _, class = UnitClass("raid"..num)
        local _, _, subgroup, _, _, _, _, online, isDead = GetRaidRosterInfo(num)
        if UnitExists(raidID) and online and self.parent:IsGroup(subgroup) and self.parent:IsClass(class) and (UnitPowerType(raidID) == 0) then
            if self.parent.data.includeDeaths or (not isDead and not UnitIsGhost(raidID)) then
                local mana = UnitMana(raidID)
                local manaMax = UnitManaMax(raidID)
                cPerc = (mana/manaMax)*100
                if cPerc<100 then
                    table.insert(t, {raidID, cPerc})
                end
            end
        end
    end
    
    table.sort(t, function(a,b) return a[2]>b[2] end)
    
    for _,v in ipairs(t) do
        local _, class = UnitClass(v[1])
        local r,g,b = BC:GetColor(class)
        cat:AddLine(
            'text', UnitName(v[1]),
            'textR', r,
            'textG', g,
            'textB', b,
            'text2', string.format("%.0f",v[2])
        )
    end
    
    compost:Reclaim(t)
    t = nil
end

-- Tooltip for type 'alive'
XRS.alivetooltip = AceOO.Class(XRS.abstracttooltip)

function XRS.alivetooltip.prototype:init(bar)
    XRS.alivetooltip.super.prototype.init(self, bar, false)
end

function XRS.alivetooltip.prototype:TooltipData()
    tablet:SetTitle(tostring(self.parent))
    if XRS:GetHintOption() then tablet:SetHint(L["Bar_Hint"]) end
    local cat = tablet:AddCategory(
                    'columns', 2
                )
    
    for num=1,40 do
        local raidID = "raid"..num
        local _, class = UnitClass(raidID)
        local _, _, subgroup, _, _, _, _, online, isDead = GetRaidRosterInfo(num)
        if UnitExists(raidID) and online and self.parent:IsGroup(subgroup) and self.parent:IsClass(class) then
            if self.parent.data.includeDeaths or (not isDead and not UnitIsGhost(raidID)) then
                local r,g,b = BC:GetColor(class)
                cat:AddLine(
                    'text', UnitName(raidID),
                    'textR', r,
                    'textG', g,
                    'textB', b,
                    'text2', L["Alive"],
                    'text2R', 0,
                    'text2G', 1.0,
                    'text2B', 0
                )
            end 
        end
    end
end

-- Tooltip for type 'dead'
XRS.deadtooltip = AceOO.Class(XRS.abstracttooltip)

function XRS.deadtooltip.prototype:init(bar)
    XRS.deadtooltip.super.prototype.init(self, bar, false)
end

function XRS.deadtooltip.prototype:TooltipData()
    tablet:SetTitle(tostring(self.parent))
    if XRS:GetHintOption() then tablet:SetHint(L["Bar_Hint"]) end
    local cat = tablet:AddCategory(
                    'columns', 2
                )
    
    for num=1,40 do
        local raidID = "raid"..num
        local _, class = UnitClass(raidID)
        local _, _, subgroup, _, _, _, _, online, isDead = GetRaidRosterInfo(num)
        if UnitExists(raidID) and online and self.parent:IsGroup(subgroup) and self.parent:IsClass(class) then
            if isDead or UnitIsGhost(raidID) then
                local r,g,b = BC:GetColor(class)
                cat:AddLine(
                    'text', UnitName(raidID),
                    'textR', r,
                    'textG', g,
                    'textB', b,
                    'text2', L["Dead"],
                    'text2R', 1.0,
                    'text2G', 0,
                    'text2B', 0
                )
            end 
        end
    end
end

-- Tooltip for type 'range'
XRS.rangetooltip = AceOO.Class(XRS.abstracttooltip)

function XRS.rangetooltip.prototype:init(bar)
    XRS.rangetooltip.super.prototype.init(self, bar, false)
end

function XRS.rangetooltip.prototype:TooltipData()
    tablet:SetTitle(tostring(self.parent))
    if XRS:GetHintOption() then tablet:SetHint(L["Bar_Hint"]) end
    local cat = tablet:AddCategory(
                    'columns', 2
                )

    local myzone=GetRealZoneText()
    for num=1,40 do
        raidID = "raid"..num
        local _, class = UnitClass(raidID)
        local _, _, subgroup, _, _, _, zone, online, isDead = GetRaidRosterInfo(num)
        if UnitExists(raidID) and online and not UnitIsUnit(raidID, "player") and self.parent:IsGroup(subgroup) and self.parent:IsClass(class) then
            if self.parent.data.range == "30" then
                if not CheckInteractDistance(raidID,4) then
                    local r,g,b = BC:GetColor(class)
                    cat:AddLine(
                        'text', UnitName(raidID),
                        'textR', r,
                        'textG', g,
                        'textB', b,
                        'text2', L["Yards_1"],
                        'text2R', 1.0,
                        'text2G', 0,
                        'text2B', 0
                    )
                end
            elseif self.parent.data.range == "100" then
                if not UnitIsVisible(raidID) then
                    local r,g,b = BC:GetColor(class)
                    cat:AddLine(
                        'text', UnitName(raidID),
                        'textR', r,
                        'textG', g,
                        'textB', b,
                        'text2', L["Yards_2"],
                        'text2R', 1.0,
                        'text2G', 0,
                        'text2B', 0
                    )
                end
            elseif self.parent.data.range == "zone" then
                if not zone == myzone then
                    local r,g,b = BC:GetColor(class)
                    cat:AddLine(
                        'text', UnitName(raidID),
                        'textR', r,
                        'textG', g,
                        'textB', b,
                        'text2', L["Yards_3"],
                        'text2R', 1.0,
                        'text2G', 0,
                        'text2B', 0
                    )
                end
            end
        end
    end
end

-- Tooltip for type 'offline'
XRS.offlinetooltip = AceOO.Class(XRS.abstracttooltip)

function XRS.offlinetooltip.prototype:init(bar)
    XRS.offlinetooltip.super.prototype.init(self, bar, false)
end

function XRS.offlinetooltip.prototype:TooltipData()
    tablet:SetTitle(tostring(self.parent))
    if XRS:GetHintOption() then tablet:SetHint(L["Bar_Hint"]) end
    local cat = tablet:AddCategory(
                    'columns', 2
                )

    for num=1,40 do
        raidID = "raid"..num
        local _, class = UnitClass(raidID)
        local _, _, subgroup, _, _, _, _, online = GetRaidRosterInfo(num)
        if UnitExists(raidID) and self.parent:IsGroup(subgroup) and self.parent:IsClass(class) then
            if not online then
                local r,g,b = BC:GetColor(class)
                cat:AddLine(
                    'text', UnitName(raidID),
                    'textR', r,
                    'textG', g,
                    'textB', b,
                    'text2', L["Offline"],
                    'text2R', 1.0,
                    'text2G', 0,
                    'text2B', 0
                )
            end
        end
    end
end

-- Tooltip for type 'afk'
XRS.afktooltip = AceOO.Class(XRS.abstracttooltip)

function XRS.afktooltip.prototype:init(bar)
    XRS.afktooltip.super.prototype.init(self, bar, false)
end

function XRS.afktooltip.prototype:TooltipData()
    tablet:SetTitle(tostring(self.parent))
    if XRS:GetHintOption() then tablet:SetHint(L["Bar_Hint"]) end
    local cat = tablet:AddCategory(
                    'columns', 2
                )
    
    local ctra_enabled = IsAddOnLoaded("CT_RaidAssist")
    local ora2_enabled = IsAddOnLoaded("oRA2")
    
    if ctra_enabled or ora2_enabled and oRA:IsActive() then
        for n, u in pairs(roster.roster) do
            if UnitIsConnected(u.unitid) and u and u.name and u.class ~= "PET" and (ora2_enabled and u.ora_afk or ctra_enabled and CT_RA_Stats[u.name] and CT_RA_Stats[u.name]["AFK"]) then
                local r,g,b = BC:GetColor(u.class)
                cat:AddLine(
                    'text', u.name,
                    'textR', r,
                    'textG', g,
                    'textB', b,
                    'text2', L["Afk"],
                    'text2R', 1.0,
                    'text2G', 0,
                    'text2B', 0
                )
            end
        end
    elseif not ctra_enabled and ora2_enabled and not oRA:IsActive() then
        cat:AddLine(
            'text', "oRA2 is in standby mode!",
            'textR', 1.0,
            'textG', 0,
            'textB', 0,
            'noInherit', true
        )
    else
        cat:AddLine(
            'text', "oRA2 or CT_RaidAssist not enabled!",
            'textR', 1.0,
            'textG', 0,
            'textB', 0,
            'noInherit', true
        )
    end
end

-- Tooltip for type 'pvp'
XRS.pvptooltip = AceOO.Class(XRS.abstracttooltip)

function XRS.pvptooltip.prototype:init(bar)
    XRS.pvptooltip.super.prototype.init(self, bar, false)
end

function XRS.pvptooltip.prototype:TooltipData()
	tablet:SetTitle(tostring(self.parent))
	if XRS:GetHintOption() then tablet:SetHint(L["Bar_Hint"]) end
	local cat = tablet:AddCategory(
					'columns', 2
				)

	for num=1,40 do
		local raidID = "raid"..num
		local _, class = UnitClass(raidID)
		local _, _, subgroup, _, _, _, _, online, isDead = GetRaidRosterInfo(num)
		if UnitExists(raidID) and online and self.parent:IsGroup(subgroup) and self.parent:IsClass(class) then
			if UnitIsPVP(raidID) then
				local r,g,b = BC:GetColor(class)
				cat:AddLine(
					'text', UnitName(raidID),
					'textR', r,
					'textG', g,
					'textB', b,
					'text2', L["PvP"],
					'text2R', 1.0,
					'text2G', 0,
					'text2B', 0
				)
			end 
		end
	end
end

-- Tooltip for all buff icons
XRS.bufftooltip = AceOO.Class(XRS.abstracttooltip)

function XRS.bufftooltip.prototype:init(button)
    XRS.bufftooltip.super.prototype.init(self, button, true)
end

function XRS.bufftooltip.prototype:TooltipData()
    if self.parent.data.invertBuff then
        tablet:SetTitle(crayon:Green(tostring(self.parent)))
    else
        tablet:SetTitle(crayon:Red(tostring(self.parent)))
    end
    
    if XRS:GetHintOption() then tablet:SetHint(L["Buff_Hint"]) end
    local buffTable = self.parent:GetBuffTable()
    local tempTable = compost:Acquire()
    
    local cat = tablet:AddCategory(
                    'columns', 2
                )
    
    if buffTable then
        for i=1,8 do
            tempTable[i] = {}
        end
        for k,v in buffTable do
            if (not v and not self.parent.data.invertBuff) or (v and self.parent.data.invertBuff) then
                local _, _, id = string.find(k, "^raid(%d+)$")
                local _, class = UnitClass(k)
                local _, _, subgroup, _, _, _, _, online, isDead = GetRaidRosterInfo(id)
                if (self.parent.data.unitIsVisible and UnitIsVisible(k)) or (not self.parent.data.unitIsVisible) then 
                    if UnitExists(k) and online and not isDead and self.parent:IsGroup(subgroup) and self.parent:IsClass(class) then
                        local name, rank, subgroup, level, _, fileName, zone, online = GetRaidRosterInfo(id)
                        table.insert(tempTable[subgroup], {name, class, k})
                    end
                end
            end
        end
        
        for k,v in ipairs(tempTable) do
            for _,j in v do
                local r,g,b = BC:GetColor(j[2])
                cat:AddLine(
                    'text', j[1],
                    'textR', r,
                    'textG', g,
                    'textB', b,
                    'text2', k,
                    'text2R', (1/12)*k,
                    'text2G', 0.4,
                    'text2B', 0.3,
                    'func', not self.parent.data.invertBuff and function(id, spells)
                                self.parent:BuffPerson(id, spells)
                            end or false,
                    'arg1', j[3],
                    'arg2', self.parent:GetBuffs()
                )
            end
            if table.getn(v)>0 then cat:AddLine() end
        end
    end
    
    compost:Reclaim(tempTable)
    tempTable = nil
end