--[[---------------------------------------------------------------------------------
  PerfectRaid by Cladhaire <cladhaire@gmail.com>
  
  If you plan to add something to PerfectRaid, I ask that you contribute the code back
  to the author (cladhaire@gmail.com) so it may be introduced into main AddOn.
----------------------------------------------------------------------------------]]

--[[---------------------------------------------------------------------------------
  Class declaration
------------------------------------------------------------------------------------]]

local elapsed = 0
local visible,frames = {},{}
local registry= {}
local feign,unavail,lowmana,spirit = {},{},{},{}
local sort,keys = {},{}
local stattext,classes
local force = 0
local prox,roster,dewdrop,target

local L = AceLibrary("AceLocale-2.0"):new("PerfectRaid")
PerfectRaid= AceLibrary("AceAddon-2.0"):new(
    "AceHook-2.0", 
    "AceConsole-2.0", 
    "AceDB-2.0", 
    "AceEvent-2.0",
    "AceDebug-2.0"
)

PerfectRaid:RegisterDB("PerfectRaidDB")

function PerfectRaid:OnInitialize()
    self.poolsize = 0
    self.frames = frames
    self.visible = visible
    self.master = CreateFrame("Frame", "PerfectRaidFrame", UIParent)
    self.master:SetMovable(true)

	self.virtualfont = self.master:CreateFontString(nil, "ARTWORK")
	self.virtualfont:SetFontObject(GameFontHighlightSmall)

    self.tooltip = CreateFrame("GameTooltip")
    self.tooltip.name = self.tooltip:CreateFontString()
    self.tooltip.right = self.tooltip:CreateFontString()
    self.tooltip:AddFontStrings(self.tooltip.name, self.tooltip.right)
    self.tooltip:SetOwner(self.tooltip, "ANCHOR_NONE")
    
    -- Grab DewDrop
    dewdrop = AceLibrary("Dewdrop-2.0")
    self.dewdrop = dewdrop
    dewdrop:Register(self.master, "children", 
        function(level, value) dewdrop:FeedAceOptionsTable(self.options) end,
        "dontHook", true
    )
    
    -- Register with RosterLib
    self:RegisterEvent("CHAT_MSG_SYSTEM")
    self:RegisterEvent("RosterLib_RosterChanged", "UpdateRoster")
    roster = AceLibrary("RosterLib-2.0").roster
    prox = ProximityLib:GetInstance("1")

    local _,class = UnitClass("player")
    
    -- Register Chat Command
    self:RegisterChatCommand({"/praid"}, self.options)

        self:RegisterDefaults("profile", {
        AlignRight		= false,
        AlignBottom     = false,
        Columns         = 2,
	  hOffset		= 15,
	  ColumnShift     = 0,
	  ShowInParty     = false,
        Highlight       = true,
        DebuffTexture   = true,
        Truncate        = false,
        Scale           = 1.0,
        Separator       = 15,
        Inverse         = false,
        Deficit         = true,
        Texture         = "Interface\\AddOns\\PerfectRaid\\Textures\\halcyone",
        Locked          = false,
        Sort            = "name",
        LowMana         = 20,
        FilterDebuffs   = false,            -- Needs to be implemented
        ShowBuffHeals   = true,             -- Needs to be implemented
        RangeCheck      = true,
        ManaBars        = "mana",
        ShowGroups      = false,
	  Tooltips		= true,
        Buffs	= {
            Fortitude	= (class == "PRIEST"),
            Spirit		= (class == "PRIEST"),
            ShadowProtection = (class == "PRIEST"),
            Intellect	= (class == "MAGE"),
            MarkOfWild	= (class == "DRUID"),
            Renew       = (class == "PRIEST"),
            Regrowth    = (class == "DRUID"),
            Rejuvenation= (class == "DRUID"),
            BoMight     = (class == "PALADIN"),
            BoWisdom    = (class == "PALADIN"),
            BoSalvation = (class == "PALADIN"),
            BoLight     = (class == "PALADIN"),
            BoSanctuary = (class == "PALADIN"),
            BoKings     = (class == "PALADIN"),
        },
    })

    -- Local bindings
    self.opt = self.db.profile

    -- Set certain options
    self.master:SetScale(self.opt.Scale)
    self:RestorePosition()
    
    -- Grab player name
    self.player = UnitName("player")
    
    -- Finish some local bindings
    classes = self.CLASSES
    stattext = self.STATTEXT

    if self.opt.ShowInParty then HidePartyFrame() end
end


function PerfectRaid:ShouldIDisplay()
	if GetNumRaidMembers() > 0 then 
		return true 
	end
      
	if GetNumPartyMembers() > 0 and self.opt.ShowInParty then 
		return true 
	end

	return false
end

function PerfectRaid:GetNumUnits()
	if GetNumRaidMembers() > 0 then 
		return GetNumRaidMembers() 
	end
	
	if GetNumPartyMembers() > 0 and self.opt.ShowInParty then
		return GetNumPartyMembers() + 1
	end

	return 0
end

--[[
function PerfectRaid:Simulate()
    if not self.simulate then
        self.simulate = true
        local f = function()
            for unit in pairs(visible) do
                self:UpdateUnit(unit)
                self:UpdateMana(unit)
            end
        end
        
        RaidSimulation:Start()
        self:UpdateRoster()
        self:ScheduleRepeatingEvent("PerfectRaidSimulate", f, 3.5)
    else
        self.simulate = nil
        RaidSimulation:Stop()
        self:UpdateRoster()
        self:CancelScheduledEvent("PerfectRaidSimulate")
    end
end
--]]

--[[---------------------------------------------------------------------------------
  Main Addon
------------------------------------------------------------------------------------]]	

function PerfectRaid:CHAT_MSG_SYSTEM()
    if string.find(arg1, ERR_RAID_YOU_LEFT) then
        self:UpdateRoster()
    end
end
    
function PerfectRaid:UpdateUnit(unit)
    if visible[unit] and UnitExists(unit) then
        local f = frames[unit]
        
        local hp = UnitIsConnected(unit) and UnitHealth(unit) or 0
        local hpmax = UnitHealthMax(unit)
        local hpp = (hpmax ~= 0) and floor((hp / hpmax) * 100) or 0
                
        if not feign[unit] then
            if self.opt.Inverse then
                hpp = 100 - hpp
            end
            
            local status
            
            if UnitIsDead(unit) then status = "|cffff0000"..L["Dead"].."|r"
            elseif UnitIsGhost(unit) then status = "|cff9d9d9d"..L["Ghost"].."|r"
            elseif not UnitIsConnected(unit) then status = "|cffff8000"..L["Offline"].."|r" end
            
            if status then
                f.Bar:SetValue(100)
                f.Bar:SetStatusBarColor(0.6, 0.6, 0.6, 0.4)
                f.HP:SetText(status)
                -- Clear status and highlight
                f.Status:SetText("")
                f.Highlight:SetVertexColor(1, 1, 1)
                f.Highlight:Hide()
                f.Highlight.shown = false
                unavail[unit] = true
            elseif spirit[unit] then
                f.Bar:SetValue(100)
                f.Bar:SetStatusBarColor(0.6, 0, 1)
                f.HP:SetText(L["ImpDying"])
            else
                f.Bar:SetValue(hpp)
                local r, g, b = self:GetHPSeverity(hp/hpmax,1)
                f.Bar:SetStatusBarColor(r, g, b, 1.0)
                unavail[unit] = false

                if hp == hpmax or not self.opt.Deficit then
                    f.HP:SetText("")
                else
                    f.HP:SetText(hp-hpmax)
                end
            end
        else
            -- Feign Death
            f.Bar:SetValue(100)
            f.Bar:SetStatusBarColor(0, 0.9, 0.78)
            f.HP:SetText(L["Feign"])
        end
    end
end

function PerfectRaid:UpdateMana(unit)
    if not visible[unit] then return end
    
    local f = frames[unit]
        
    local mana = UnitMana(unit) or 0
    local max = UnitManaMax(unit) or 1
    local mpp = floor((mana / max) * 100)
    
    f.MBar:SetValue(mpp)
        
    if not unavail[unit] and (UnitPowerType(unit) == 0) and 
        (max > 0 and mpp <= self.opt.LowMana) then
        if not lowmana[unit] then
            local text = f.Status:GetText() or ""
            f.Status:SetText(string.format("%s%s", stattext["LowMana"], text))
            lowmana[unit] = true
        end
    elseif lowmana[unit] then
        -- Clear it out.
        local len = string.len(stattext["LowMana"])
        local text = f.Status:GetText() or ""
        f.Status:SetText(string.sub(text, len + 1))
        lowmana[unit] = false
    end
end

function PerfectRaid:UpdateStatus(unit)
    local fd,redem,curse,poison,magic,disease
    local innervate,soulstone,poweri,wsoul,markwild
    local shield,fort,sor,int,spi,shawprot
    local bok,bol,bom,bosal,bosan,bow
    local renew,regrowth,rejuv
    
    local _,class = UnitClass(unit)
    local _, pclass = UnitClass("player")

    if visible[unit] and UnitExists(unit) then            
        -- Some special code here for Feign Death and Spirit of Redemption
        
        if class == "PRIEST" then
            for i=1,32 do
                local texture = UnitBuff(unit, i)
                if texture == "Interface\\Icons\\Spell_Holy_GreaterHeal" then
                    redem = true
                    local f = frames[unit]
                    f.Bar:SetStatusBarColor(0.6, 0, 1)
                    f.HP:SetText(L["ImpDying"])
                    break
                end
            end
        end

        if class == "HUNTER" and UnitIsDead(unit) then 
            for i=1,32 do
                local texture = UnitBuff(unit, i)
                if texture == "Interface\\Icons\\Ability_Rogue_FeignDeath" then
                    --self:Print("Found feign death on %s", unit)
                    fd = true
                    local f = frames[unit]
                    f.Bar:SetStatusBarColor(0, 0.9, 0.78)
                    f.HP:SetText(L["Feign"])
                    break
                end 
            end
        end
        
        spirit[unit] = redem
        feign[unit] = fd
        
        if not unavail[unit] then                
            local filter = self.opt.FilterDebuffs
            
            -- Check for Curse, Poison, Disease, Magic, Weakened Soul
            for i=1,16 do
                local texture,stack,type = UnitDebuff(unit, i)

                if not texture then break end

                -- Check this either way, if we're a priest
                if pclass == "PRIEST" and texture == "Interface\\Icons\\Spell_Holy_AshesToAshes" then
                    wsoul = true
                end
                
                if type and filter then
                    texture,stack,type = UnitDebuff(unit, i, 1)
                end
                
                if type == "Curse" then
                    curse = true
                elseif type == "Magic" then
                    magic = true
                elseif type == "Poison" then
                    poison = true
                elseif type == "Disease" then
                    disease = true
                end
            end
                            
            filter = self.opt.ShowBuffHeals
            
            for i=1,32 do
                local texture = UnitBuff(unit, i)
                if not texture then break end
                
                -- These are general buffs that anyone could want to see
                -- These need options
                if texture == "Interface\\Icons\\Spell_Shadow_SoulGem" then
                    soulstone = true
                elseif texture == "Interface\\Icons\\Spell_Nature_Lightning" then
                    innervate = true
                elseif texture == "Interface\\Icons\\Spell_Holy_PowerInfusion" then
                    poweri = true
                elseif texture == "Interface\\Icons\\Spell_Holy_WordFortitude" or
                    texture == "Interface\\Icons\\Spell_Holy_PrayerOfFortitude" then
                    fort = true
                elseif texture == "Interface\\Icons\\Spell_Shadow_AntiShadow" or
                    texture == "Interface\\Icons\\Spell_Holy_PrayerofShadowProtection" then
                    shawprot = true
                elseif texture == "Interface\\Icons\\Spell_Holy_PowerWordShield" then
                    shield = true
                elseif texture == "Interface\\Icons\\Spell_Holy_DivineSpirit" or
                    texture == "Interface\\Icons\\Spell_Holy_PrayerofSpirit" then
                    spi = true
                elseif texture == "Interface\\Icons\\Spell_Nature_Regeneration" then
                    markwild = true
                elseif texture == "Interface\\Icons\\Spell_Holy_MagicalSentry" or
                    texture == "Interface\\Icons\\Spell_Holy_ArcaneIntellect" then
                    int = true
                elseif texture == "Interface\\Icons\\Spell_Holy_FistOfJustice" or
                    texture == "Interface\\Icons\\Spell_Holy_GreaterBlessingofKings" then
                    bom = true
                elseif texture == "Interface\\Icons\\Spell_Holy_SealOfWisdom" or
                    texture == "Interface\\Icons\\Spell_Holy_GreaterBlessingofWisdom" then
                    bow = true
                elseif texture == "Interface\\Icons\\Spell_Holy_SealOfSalvation" or
                    texture == "Interface\\Icons\\Spell_Holy_GreaterBlessingofSalvation" then
                    bosal = true
                elseif texture == "Interface\\Icons\\Spell_Holy_PrayerOfHealing02" or
                    texture == "Interface\\Icons\\Spell_Holy_GreaterBlessingofLight" then
                    bol = true
                elseif texture == "Interface\\Icons\\Spell_Nature_LightningShield" or
                    texture == "Interface\\Icons\\Spell_Holy_GreaterBlessingofSanctuary" then
                    bosan = true
                elseif texture == "Interface\\Icons\\Spell_Magic_MageArmor" or
                    texture == "Interface\\Icons\\Spell_Magic_GreaterBlessingofKings" then
                    bok = true
                elseif texture == "Interface\\Icons\\Spell_Holy_Renew" then
                    renew = true
                elseif texture == "Interface\\Icons\\Spell_Nature_Rejuvenation" then
                    rejuv = true
                elseif texture == "Interface\\Icons\\Spell_Nature_ResistNature" then
                    regrowth = true
                end
            end
            
            -- Lets make sure we dont' show caster buffs for melee
            if class == "ROGUE" or class == "WARRIOR" then
                spi = true
                int = true
            end
            
            local output = string.format("%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s",
                                        (lowmana[unit] and stattext["LowMana"]) or "",
                                        (soulstone and stattext["Soulstone"]) or "",
                                        (innervate and stattext["Innervate"]) or "",
                                        (poweri and stattext["PowerInfusion"]) or "",
                                        (fs and stattext["FeignDeath"]) or "",
                                        (curse and stattext["Curse"]) or "",
                                        (disease and stattext["Disease"]) or "",
                                        (magic and stattext["Magic"]) or "",
                                        (poison and stattext["Poison"]) or "",
                                        (shield and not wsoul and stattext["Shield"]) or "",
                                        (wsoul and stattext["WeakenedSoul"]) or "",
                                        (self.opt.Buffs.Fortitude and not fort) and stattext["Fortitude"] or "",
                                        (self.opt.Buffs.ShadowProtection and not shawprot) and stattext["ShadowProtection"] or "",
                                        (self.opt.Buffs.Spirit and not spi) and stattext["Spirit"] or "",
                                        (self.opt.Buffs.MarkOfWild and not markwild) and stattext["MarkOfWild"] or "",
                                        (self.opt.Buffs.Intellect and not int) and stattext["Intellect"] or "",
                                        (self.opt.Buffs.BoMight and not bom) and stattext["BoMight"] or "",
                                        (self.opt.Buffs.BoWisdom and not bow) and stattext["BoWisdom"] or "",
                                        (self.opt.Buffs.BoSalvation and not bosal) and stattext["BoSalvation"] or "",
                                        (self.opt.Buffs.BoLight and not bol) and stattext["BoLight"] or "",
                                        (self.opt.Buffs.BoSanctuary and not bosan) and stattext["BoSanctuary"] or "",
                                        (self.opt.Buffs.BoKings and not bok) and stattext["BoKings"] or "",
                                        (self.opt.Buffs.Renew and renew) and stattext["Renew"] or "",
                                        (self.opt.Buffs.Rejuvenation and rejuv) and stattext["Rejuvenation"] or "",
                                        (self.opt.Buffs.Regrowth and regrowth) and stattext["Regrowth"] or ""
                                    )
            
            self.frames[unit].Status:SetText(output)
            
            local showdebuff = self.opt.DebuffTexture
            
            if showdebuff and poison then
                local c = DebuffTypeColor["Poison"]
                local f = self.frames[unit].Highlight
                f:SetVertexColor(c.r, c.g, c.b)
                f.shown = true
                f:Show()
            elseif showdebuff and magic then
                local c = DebuffTypeColor["Magic"]
                local f = self.frames[unit].Highlight
                f:SetVertexColor(c.r, c.g, c.b)
                f.shown = true
                f:Show()
            elseif showdebuff and disease then
                local c = DebuffTypeColor["Disease"]
                local f = self.frames[unit].Highlight
                f:SetVertexColor(c.r, c.g, c.b)
                f.shown = true
                f:Show()
            elseif showdebuff and curse then
                local c = DebuffTypeColor["Curse"]
                local f = self.frames[unit].Highlight
                f:SetVertexColor(c.r, c.g, c.b)
                f.shown = true
                f:Show()
            else
                local f = self.frames[unit].Highlight
                f:SetVertexColor(1, 1, 1)
                f.shown = false
                if not f.mouseover then
                    f:Hide()
                end
            end
        end
    end
end

function PerfectRaid:UpdateRoster()
    local num = self:GetNumUnits()
    
    if num > 0 then
        -- Register our events
        self:RegisterEvent("UNIT_HEALTH", "UpdateUnit")
        self:RegisterEvent("UNIT_AURA", "UpdateStatus")
        self:RegisterEvent("UNIT_MANA", "UpdateMana")
        self:ScheduleRepeatingEvent("PerfectRaidRangeCheck", self.RangeCheck, 2.0, self)
    else
        -- Unregister events
        if self:IsEventRegistered("UNIT_HEALTH") then
            self:UnregisterEvent("UNIT_HEALTH")
            self:UnregisterEvent("UNIT_AURA")
            self:UnregisterEvent("UNIT_MANA")
            self:CancelScheduledEvent("PerfectRaidRangeCheck")
        end
    end
    
    if num >= self.poolsize then self:CreateFrame(num) end
    
    self.name_width = 0

    
    if num > 0 then
        for k,unit in roster do
            if unit.class ~= "PET" then
                local id = unit.unitid
                local name = unit.name
                local class = unit.class
                local group = unit.subgroup

		--self:Print("UnitId: %s", id)

		local f = frames[id]

                if not f then
		    	  --self:Print("UnitId: %s doesn't exist <sad face>", id)
                    break
                end
                
                f:Show()
                f.group = group
                visible[id] = true
                
                -- Use virtualfont here to figure out the longest name
                self.virtualfont:SetText(name)
                    
                local len = self.virtualfont:GetStringWidth() 
                len = len + 5 -- This is a hack
                
                if len > self.name_width then
                    self.name_width = len
                end
                
                if self.player == name then
                    self.mygroup = group
                end

                -- Set the unit name
                if self.opt.ShowGroups then
                    f.Name:SetText(self.CLASSES[class]..name.."|r")
                else
                    f.Name:SetText(string.format("%s-%s%s|r", tostring(group), self.CLASSES[class], name))                
                end

                local barcolor = ManaBarColor[UnitPowerType(id)]
                if (self.opt.ManaBars == "mana" or self.opt.ManaBars == "all") and
                    UnitPowerType(id) == 0 then
                    f.MBar:SetStatusBarColor(barcolor.r, barcolor.g, barcolor.b)
                    f.MBar:Show()
                    f.HP:SetParent(f.MBar)
                elseif self.opt.ManaBars == "all" then
                    f.MBar:SetStatusBarColor(barcolor.r, barcolor.g, barcolor.b)
                    f.MBar:Show()
                    f.HP:SetParent(f.MBar)
                else
                    f.HP:SetParent(f.Bar)
                    f.MBar:Hide()
                end

                -- Force an update
                self:UpdateUnit(id)
                self:UpdateStatus(id)
                self:UpdateMana(id)
            end
        end
    end
    
    -- Hide any unused frames
    for i=(num+1),self.poolsize do
        visible["raid"..i] = nil
        if not frames[i] then break end
        frames[i]:Hide()
    end
        
    self:UpdateLayout()
end

function PerfectRaid:UpdateLayout()
    -- Do nothing whatsoever if we're not in a raid
    if not self:ShouldIDisplay() then return end
    
    -- Make sure we're all sorted up
    if GetNumRaidMembers() > 0 then
        self:Sort()
    else
	sort[1] = "player"
	sort[2] = "party1"
	sort[3] = "party2"
	sort[4] = "party3"
	sort[5] = "party5"
    end
	
    
    local vert,horiz = "TOP", "LEFT"
    local point,rel = "TOPLEFT", "BOTTOMLEFT"
    local voffset = -self.opt.Separator
    
    -- Which corner do we need to anchor to?
    if self.opt.AlignRight then
        horiz = "RIGHT"
    end
    if self.opt.AlignBottom then
        vert = "BOTTOM"
        point = "BOTTOM"..horiz
        rel = "TOP"..horiz
        voffset = -voffset
    end
    
    -- Anchor the FIRST frame to the corner
    local f = frames[sort[1]]
    local anchor = vert..horiz
    local prev = f
    
    f:ClearAllPoints()
    f:SetPoint(anchor, self.master, anchor, 0, 0)
    
    -- Additions by Velyse of Malygos (Jordan F.)
    local numInRaid = self:GetNumUnits()   
    local groups = math.ceil(numInRaid / 5)    --Get the number of groups (maximum filled groups)
    local numInColumn

    --if we're sorting by groups the number in columns is different
    if self.opt.Sort == "GROUP" then
        numInColumn = math.ceil(groups / self.opt.Columns) * 5 + self.opt.ColumnShift
    else
        numInColumn = math.ceil(numInRaid / self.opt.Columns) + self.opt.ColumnShift
    end    

    local ColumnNumber = 0

    -- Anchor all subsequent frames to the top frame
    for i=2,numInRaid do
        local f = frames[sort[i]]

        if f then
          f:ClearAllPoints()
      	  if keys[f.unit] ~= keys[prev.unit] then
           		f:SetPoint(point, prev, rel, 0, voffset)
        	  else
          		f:SetPoint(point, prev, rel, 0, 0)
        	  end
              
		  --This is the last frame of the column, anchor the next one to the top (or bottom) of this column
	  	  if math.mod(i, numInColumn) == 0 then
			i = i + 1
			f = frames[sort[i]]

 			anchorFrame = numInColumn * ColumnNumber + 1
			ColumnNumber = ColumnNumber + 1

			if f then
		  		f:ClearAllPoints()
           			f:SetPoint("TOPLEFT", frames[sort[anchorFrame]], "TOPRIGHT", self.opt.hOffset, 0)
				prev = f
			end
	   	  else
            	prev = f
	   	  end
	  end
    end
    
    -- TODO: Update the actual layout/anchoring of the frames
    local justify,point,relative,offset
    
    if not self.opt.AlignRight then
        justify = "RIGHT"
        point = "LEFT"
        relative = "RIGHT"
        offset = 5
    else
        justify = "LEFT"
        point = "RIGHT"
        relative = "LEFT"
        offset = -5
    end

    local width = 55
    if not self.opt.Truncate then
        width = self.name_width + 10
    end

    for unit in pairs(visible) do
        local frame = frames[unit]

        frame.Name:SetJustifyH(justify)
        frame.Name:ClearAllPoints()
        frame.Name:SetWidth(width)
        frame.Name:SetPoint(point, frame, point, offset, 1)
        
        frame.Bar:SetStatusBarTexture(self.opt.Texture)
        frame.Bar:ClearAllPoints()
        frame.Bar:SetPoint(point, frame.Name, relative, offset, -1)
        
        frame.MBar:SetStatusBarTexture(self.opt.Texture)
        
        frame.HP:SetJustifyH(justify)
        frame.HP:ClearAllPoints()
        frame.HP:SetPoint("RIGHT", frame.Bar, "RIGHT", -2, 1)
        
        frame.Status:SetJustifyH(justify)
        frame.Status:ClearAllPoints()
        frame.Status:SetPoint(point, frame.Bar, relative, offset, 0)
        
        frame.Highlight:ClearAllPoints()
        frame.Highlight:SetPoint(point, frame, point, offset * -2, 0)
        frame.Highlight:SetPoint(relative, frame.Status, relative, offset, 0)
    end
end

function PerfectRaid:OnClick()
    local unit = this.unit
    if UnitIsUnit(unit, "player") then unit = "player" end
    
    local button = arg1

    -- To enable click-casting on this frame, all anyone has to do is
    -- set PerfectRaidCustomClick
    
    if PerfectRaidCustomClick and PerfectRaidCustomClick(arg1, unit) then
        return
    else
        if button == "LeftButton" then
            if not UnitExists(unit) then return end

            if SpellIsTargeting() then
                if button == "LeftButton" then SpellTargetUnit(unit)
                elseif button == "RightButton" then	SpellStopTargeting() end
                return
            end
        
            if CursorHasItem() then
                if button == "LeftButton" then
                    if unit=="player" then AutoEquipCursorItem()
                    else DropItemOnUnit(unit) end
                else PutItemInBackpack() end
                return
            end
            
            TargetUnit(unit)
        end
    end
end

function PerfectRaid:RangeCheck()
    if not self.opt.RangeCheck then return end
    
    --self:Print("PerfectRaid:RangeCheck()")
    local now = GetTime()
    
    for unit in pairs(visible) do
        local _,time = prox:GetUnitRange(unit)
        --self:Print("Unit: %s Time: %s", unit, tostring(time))
        if time and (now - time) < 6 then frames[unit]:SetAlpha(1.0)
        else frames[unit]:SetAlpha(0.6) end
    end
end

--[[---------------------------------------------------------------------------------
  Utility functions
------------------------------------------------------------------------------------]]

local function SortName(a,b)
    if not a or not b or not UnitName(a) or not UnitName(b) then return false end

    --PerfectRaid:Print("A: %s, B: %s, UnitName(A): %s, UnitName(B): %s", a, b, UnitName(a), UnitName(b))
    if keys[a] == keys[b] then 
        return UnitName(a) < UnitName(b)
    else
        return keys[a] < keys[b]
    end
end

local function SortClassName(a,b)
    if not a or not b or not UnitClass(a) or not UnitClass(b) then return false end

    --PerfectRaid:Print("A: %s, B: %s, UnitClass(A): %s, UnitClass(B): %s", a, b, UnitName(a), UnitName(b))
    if keys[a] == keys[b] then
        if UnitClass(a) == UnitClass(b) then
            return UnitName(a) < UnitName(b)
        else
            return UnitClass(a) < UnitClass(b)
        end
    else
        return keys[a] < keys[b]
    end
end

local function SortGroupName(a,b)
    local _,ac = UnitClass(a)
    local _,bc = UnitClass(b)

    if not a or not b or not ac or not bc then return false end

    --PerfectRaid:Print("A: %s, B: %s, UnitClass(A): _, %s, UnitClass(B): _, %s", a, b, ac, bc)
    if keys[a] == keys[b] then
        local _,ac = UnitClass(a)
        local _,bc = UnitClass(b)
        if ac == bc then 
            return UnitName(a) < UnitName(b)
        else
            return ac < bc
        end
    else
        return keys[a] < keys[b]
    end
end

function PerfectRaid:Sort()
    if not self.sortfunctions then
        self:OptionSort(self.opt.Sort)
    end
    
    -- Lets clear tables so we can sort
    sort = self:ClearTable(sort)
    keys = self:ClearTable(keys)
        
    -- Lets step through the sort order
    for i,func in ipairs(self.sortfunctions) do
        for unit in pairs(visible) do
            if func(unit) and not keys[unit] and not string.find(unit, "p") then 
                table.insert(sort, unit)
                keys[unit] = i
            end
        end
    end
    
    if self.opt.Sort == "NAME" then
        table.sort(sort, SortName)
    else
        table.sort(sort, SortClassName)
    end
end

--[[---------------------------------------------------------------------------------
  Frame Creation
------------------------------------------------------------------------------------]]

local function OnDragStart()
    if not PerfectRaid.opt.Locked then
        PerfectRaid.master:StartMoving()
    end
end

local function OnDragStop()
    PerfectRaid.master:StopMovingOrSizing()
    PerfectRaid:SavePosition()
end

local function OnEnter()
	if PerfectRaid.opt.Tooltips then
		UnitFrame_OnEnter()
	end
    if PerfectRaid.opt.Highlight then 
        this.Highlight:Show()
        this.Highlight.mouseover = true

        local h = this.Highlight
        h.r,h.g,h.b = this.Highlight:GetVertexColor()
        this.Highlight:SetVertexColor(1,1,1)
    end
end

local function OnLeave()
	UnitFrame_OnLeave()
    if this.Highlight.shown then
        --PerfectRaid:Print("Shown by a debuff")
        local h = this.Highlight
        this.Highlight:SetVertexColor(h.r, h.g, h.b)
    else
        --PerfectRaid:Print("Not being shown, hiding")
        this.Highlight:Hide()
    end
    this.Highlight.mouseover = false
end

function PerfectRaid:CreateFrame(num)
    -- We need to allocate up to num frames
    
    if self.poolsize >= num then return end

    --self:Print("We need to allocate %s frames", num)

--[[
    local mem,thr = gcinfo()
    self:Msg("Memory Usage Before: %s [%s].", mem, thr)
--]]
    
    local justify,point,relative,offset
    
    if not self.opt.AlignRight then
        justify = "RIGHT"
        point = "LEFT"
        relative = "RIGHT"
        offset = 5
    else
        justify = "LEFT"
        point = "RIGHT"
        relative = "LEFT"
        offset = -5
    end
    
    for i=(self.poolsize + 1),num do
    
        -- Create the frame itself
        local frame = CreateFrame("Button", nil, PerfectRaidFrame)
        frame:EnableMouse(true)
        frame:SetClampedToScreen(true)
        frame.unit = "raid"..i
        frame.id = i
        frame:SetWidth(200)
        for k,v in pairs(visible) do
            local f = frames[k]
            frame:SetWidth(f:GetWidth())
            break
        end
        frame:SetHeight(13)
        frame:SetMovable(true)
        frame:RegisterForDrag("LeftButton")

        frame:RegisterForDrag("LeftButton")
        frame:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up")
        frame:SetParent(self.master)
		frame:SetScript("OnUpdate", UnitFrame_OnUpdate)
               
        local font = frame:CreateFontString(nil, "ARTWORK")
        font:SetFontObject(GameFontHighlightSmall)
        font:SetText()
        font:SetJustifyH(justify)
        font:SetWidth(55)
        font:SetHeight(12)
        font:Show()
        -- Add this font string to the frame
        frame.Name = font
        
        local bar = CreateFrame("StatusBar", nil, frame)
        bar:SetStatusBarTexture(self.opt.Texture)
        bar:SetMinMaxValues(0,100)
        bar:SetWidth(80)
        bar:SetHeight(9)
        
        bar:Show()
        -- Add this status bar to the frame
        frame.Bar = bar
                
        local bar = CreateFrame("StatusBar", nil, frame)
        bar:SetStatusBarTexture(self.opt.Texture)
        bar:ClearAllPoints()
        bar:SetPoint("BOTTOMLEFT", frame.Bar, "BOTTOMLEFT", 0, 0)
        bar:SetMinMaxValues(0,100)
        bar:SetWidth(80)
        bar:SetHeight(2)
        bar:SetFrameLevel(frame.Bar:GetFrameLevel()+1)
        bar:Show()
        -- Add this status bar to the frame
        frame.MBar = bar

        font = bar:CreateFontString(nil, "OVERLAY")
        font:SetFontObject(GameFontHighlightSmall)
        font:SetText("")
        --font:SetTextColor(0,0,0,1)
        font:SetJustifyH(justify)
        font:SetWidth(65)
        font:SetHeight(10)
        font:SetTextHeight(10)
        font:Show()
        -- Add this font string to the frame
        frame.HP = font
        
        -- Create another StatusBar to be the border.
        do
            local border = CreateFrame("StatusBar",nil,frame)
            border:SetMinMaxValues(0,100)
            border:SetStatusBarTexture("Interface/Tooltips/UI-Tooltip-Background")
            border:SetStatusBarColor(0,0,0,1)
            border:ClearAllPoints()
            
            --[[ Paranoid Version:]]
            -- Border distance is hard coded
            local distance = 1/self.opt.Scale
            border:SetPoint("LEFT", frame.Bar, "LEFT", -distance, 0)
            border:SetPoint("RIGHT", frame.Bar, "RIGHT", distance, 0)
            border:SetPoint("TOP", frame.Bar, "TOP", 0, distance)
            border:SetPoint("BOTTOM", frame.Bar, "BOTTOM", 0, -distance)
            
            --[[
            bar:SetWidth(62)
            bar:SetHeight(9)
            bar:SetPoint("TOPLEFT",frame.Bar,"TOPLEFT",-1,1)
            ]]
            border:SetFrameLevel(frame.Bar:GetFrameLevel()-1)
            border:Show()
            frame.Bar.border = border
        
            local setvalue = frame.Bar.SetValue
            frame.Bar.SetValue = function(this,val)
                setvalue(this,val)
                --if(self.opt.BarBorders) then
                    --[[ Paranoid Version:
                    local w = this:GetWidth()*(val/100) 
                    this.border:SetValue((w+2)/this.border:GetWidth()*100)
                    ]]
                    local w = 60*(val/100)
                    if(w == 0) then
                        setvalue(this.border,0)
                    else
                        setvalue(this.border,(w+2)/0.62)
                    end
                --end
            end
        end
        
        font = frame:CreateFontString(nil, "ARTWORK")
        font:SetFontObject(GameFontHighlightSmall)
        font:SetText("")
        font:SetJustifyH(justify)
        font:SetWidth(font:GetStringWidth())
        font:SetHeight(12)
        font:Show()
        font:ClearAllPoints()
        font:SetPoint(point, frame.Bar, relative, offset, 0)
        -- Add this font string to the frame
        frame.Status = font

        local t = frame:CreateTexture(nil, "BACKGROUND")
        --t:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
        t:SetTexture("Interface\\AddOns\\PerfectRaid\\Textures\\PR-Pattern-Highlight")
        --t:SetBlendMode("ADD")
        --t:SetVertexColor(math.random(100)/100, math.random(100)/100, math.random(100)/100)
        t:ClearAllPoints()
        t:SetHeight(16)
        t:Hide()
        frame.Highlight = t

        frame:SetScript("OnDragStart", OnDragStart)
        frame:SetScript("OnDragStop", OnDragStop)
        frame:SetScript("OnClick", self.OnClick)
        frame:SetScript("OnEnter", OnEnter)
        frame:SetScript("OnLeave", OnLeave)
        
        -- Lets set the frame in the indexed array
        frames[i] = frame
        frames["raid"..i] = frame

	  if(i <= 5 and self.opt.ShowInParty and GetNumPartyMembers() > 0) then
	    if(i == 1) then
	       frames["player"] = frame
	       --self:Print("Created player frame")
	    else
	       local tmp = i - 1
	       frames["party"..tmp] = frame
	       --self:Print("Created party"..tmp.." frame")
	    end
	  end
	
        self.poolsize = i
    end
    
    mem2,thr2 = gcinfo()
--[[
    self:Msg("Memory Usage After: %s [%s].", mem2, thr2)
    self:Msg("Frame creation change: %s [%s].", mem2 - mem, thr2 - thr)
--]]
end

function PerfectRaid:GetHPSeverity(percent,smooth)
    if (percent<=0 or percent>1.0) then return 0.09,0.49,0.03 end

    if smooth then	
        if (percent >= 0.5) then
            return (1.0-percent)*2, 1.0, 0.0
        else
            return 1.0, percent*2, 0.0
        end
    else
        return 0,1,0
    end
end

function PerfectRaid:SavePosition()	
    local f = self.master
    local x,y = f:GetLeft(), f:GetTop()
    local s = f:GetEffectiveScale()
    
    x,y = x*s,y*s
    
    self.opt.PosX = x
    self.opt.PosY = y
end

function PerfectRaid:RestorePosition()
    local x = self.opt.PosX
    local y = self.opt.PosY

    local f = PerfectRaidFrame
    local s = f:GetEffectiveScale()
    
    -- Change these later?
    f:SetHeight(100)
    f:SetWidth(100)
    
    if not x or not y then
        f:ClearAllPoints()
        f:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
        return 
    end

    x,y = x/s,y/s

    f:ClearAllPoints()
    f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, y)
end
	
--[[---------------------------------------------------------------------------------
  Range Check Hooks
------------------------------------------------------------------------------------]]
		
function PerfectRaid:CastSpell(a1,a2,a3) 
    rangecheck = true
    self.Hooks.CastSpell.orig(a1,a2,a3)
    
    if SpellIsTargeting() then
        for k,v in visible do
            if SpellCanTargetUnit(k) then
                frames[k]:SetAlpha(1.0)
            else
                frames[k]:SetAlpha(0.5)
            end
        end
    end
end

function PerfectRaid:CastSpellByName(a1,a2,a3) 
    rangecheck = true
    self.Hooks.CastSpellByName.orig(a1,a2,a3)
    
    if SpellIsTargeting() then
        for k,v in visible do
            if SpellCanTargetUnit(k) then
                frames[k]:SetAlpha(1.0)
            else
                frames[k]:SetAlpha(0.5)
            end
        end
    end
end
	
function PerfectRaid:UseAction(a1,a2,a3) 
    rangecheck = true
    self.Hooks.UseAction.orig(a1,a2,a3)
    
    if SpellIsTargeting() then
        for k,v in visible do
            if SpellCanTargetUnit(k) then
                frames[k]:SetAlpha(1.0)
            else
                frames[k]:SetAlpha(0.5)
            end
        end
    end
end

function PerfectRaid:ClearTable(tbl)
    if not tbl then tbl = {} end
    for k in pairs(tbl) do tbl[k] = nil end
    table.setn(tbl, 0)
    return tbl
end

function PerfectRaid:IsBuffActive(spell, unit)
	-- Check buffs
	for i=1,32 do
		if not UnitBuff(unit, i) then return nil end

		self.tooltip:ClearLines()		
		self.tooltip:SetUnitBuff(unit, i)
        local text = self.tooltip.name:GetText()
        if not text then return end

		if string.find(self.tooltip.name:GetText(), spell) then
			return i
		end
	end
	return false
end	
