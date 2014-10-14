----------------------------
--      Declaration       --
----------------------------

local AceOO = AceLibrary("AceOO-2.0")
local dewdrop = AceLibrary("Dewdrop-2.0")
local BC = AceLibrary("Babble-Class-2.2")
local L = AceLibrary("AceLocale-2.2"):new("XRS")
local roster = AceLibrary("RosterLib-2.0")

XRS.bar = AceOO.Class("AceDebug-2.0")

----------------------------
--      Main Functions    --
----------------------------

function XRS.bar.prototype:init(pos, data, texture)
    -- Call Superclass
    XRS.bar.super.prototype.init(self)
    
    -- Debugging state
    self:SetDebugging(false)
    
    -- Store values
    self.pos = pos
    self.data = data
    self.texture = texture
    
    -- Color init
    if not self.data.barcolor then
        self.data.barcolor = {}
        self.data.barcolor.r = 1
        self.data.barcolor.g = 1
        self.data.barcolor.b = 1
        self.data.barcolor.a = 1
    end
    if not self.data.textcolor then
        self.data.textcolor = {}
        self.data.textcolor.r = 1
        self.data.textcolor.g = 1
        self.data.textcolor.b = 1
        self.data.textcolor.a = 1
    end
    
    -- group init
    if not self.data.group then
        self.data.group = {}
        for i=1,8 do
            self.data.group[i] = true
        end
    end
    
    -- Create the visual bar
    self:CreateBar()
    if self.data.w ~= "blank" then
        self:UpdateBar()
    end
end

function XRS.bar.prototype:CreateBar()
    -- StatusBar
    self.statusbar = CreateFrame("StatusBar", nil, XRS.frame, "TextStatusBar")
    self.statusbar:Hide()
    self.statusbar:SetWidth(self.width or 115)
    self.statusbar:SetHeight(15)
    local height = -((self.pos-1)*16)-20
    
    if self.data.w == "blank" then
        if not self.data.blankcolor then
            self.data.blankcolor = {}
            self.data.blankcolor.r = 1
            self.data.blankcolor.g = 1
            self.data.blankcolor.b = 1
            self.data.blankcolor.a = 1
        end
        self.line = CreateFrame("Frame", nil, self.statusbar)
        -- Thx @ cerement for providing me the image and the idea
        self.line:SetBackdrop{
            bgFile = "Interface\\AddOns\\XRS\\images\\WhiteLine.tga",
            edgeFile = nil,
            tile = true,  tileSize = 16, edgeSize = 0, 
            insets = {left=0, right=0, top=0, bottom=0}
        }
        
        local color = self.data.blankcolor
        self.line:SetBackdropColor(color.r, color.g, color.b, color.a)
        self.line:SetWidth(115)
        self.line:SetHeight(1)
        self.line:SetPoint("LEFT", 0, 0)
        self.line:Show()
        
        self.statusbar:SetPoint("TOP", XRS.frame, "TOP", 0, height)
    else
        self.statusbar:SetStatusBarTexture(self.texture)
        self.statusbar:SetScript("OnShow",function()
            this:SetMinMaxValues(0, 100)
    	    this:SetValue(100)
        end)
        self.statusbar:SetScript("OnMouseUp",function()
            if ( IsControlKeyDown() and arg1 == "LeftButton") then
                self.tooltip:Close()
                self.tooltip:Detach()
            end
        end)
        -- The tooltip for the bar
        local type = self.data.w .. "tooltip"
        self.tooltip = XRS[type]:new(self)
        
        if self.data.backgroundBar then
            self.statusbar2 = CreateFrame("StatusBar", nil, XRS.frame, "TextStatusBar")
            self.statusbar2:Hide()
            self.statusbar2:SetWidth(self.width or 115)
            self.statusbar2:SetHeight(15)
            self.statusbar2:SetStatusBarTexture(self.texture)
            self.statusbar2:SetScript("OnShow",function()
                this:SetMinMaxValues(0, 100)
                this:SetValue(100)
            end)
            self.statusbar2:SetPoint("TOP", XRS.frame, "TOP", 0, height)
            self.statusbar:SetPoint("TOP", self.statusbar2, "TOP", 0, 0)
        else
            self.statusbar:SetPoint("TOP", XRS.frame, "TOP", 0, height)
        end
        
        -- Text Left
        self.textleft = self.statusbar:CreateFontString("$parentTextLeft","ARTWORK","GameFontNormalSmall")
        local path = self.textleft:GetFont()
        self.textleft:SetFont(path, 11)
        if (strlen(self.data.name) > 14) then
    		local name = strsub(self.data.name, 1, 13).."..."
    		self.textleft:SetText(name)
    	else
    	   self.textleft:SetText(self.data.name)
    	end
        self.textleft:SetPoint("LEFT", 0, 0)
        self.textleft:SetTextColor(1,1,1)
        self.textleft:Show()
        
        -- Text Right
        self.textright = self.statusbar:CreateFontString("$parentTextRight","ARTWORK","GameFontNormalSmall")
        local path = self.textright:GetFont()
        self.textright:SetFont(path, 11)
        self.textright:SetText("%")
        self.textright:SetPoint("RIGHT", 0, 0)
        self.textright:SetTextColor(1,1,1)
        self.textright:Show()
    end
    
    -- Register dewdrop
    dewdrop:Register(self.statusbar, 'children', function(level, value) self:CreateDDMenu(level, value) end)
    
    -- Show the bar
    self.statusbar:Show()
    if self.statusbar2 then
        self.statusbar2:Show()
    end
    
    -- Debug message
    self:Debug(string.format("Statusbar created: %s, %s, %s", self.pos, self.data.name, self.data.w))
end

function XRS.bar.prototype:RemoveBar()
    -- Remove everything
    local registered = dewdrop:IsRegistered(self.statusbar)
    if registered then dewdrop:Unregister(self.statusbar) end
    self.statusbar:Hide()
    if self.statusbar2 then
        self.statusbar2:Hide()
        self.statusbar2 = nil
    end
    
    if self.tooltip then
        self.tooltip:Remove()
        self.tooltip = nil
    end
    
    if self.line then
        self.line:Hide()
        self.line = nil
    end
    
    if self.textleft then
        self.textleft:Hide()
        self.textright:Hide()
        self.textleft = nil
        self.textright = nil
    end
    
    self.statusbar = nil
end

local percent, aliveCount, raidCount, deadCount, rangeCount, offlineCount, afkCount, pvpCount
function XRS.bar.prototype:UpdateBar()
    -- Get the values for the bar
    if self.data.w == "life" then 
        percent = self:GetLife()
    elseif self.data.w == "alive" then
        percent, aliveCount, raidCount = self:GetAlive()
    elseif self.data.w == "dead" then
        percent, aliveCount, raidCount = self:GetAlive()
        deadCount = raidCount - aliveCount
        if raidCount ~= 0 then
            percent = 100 - percent
        else
            percent = 0
        end
    elseif self.data.w == "mana" then
        percent = self:GetMana()
    elseif self.data.w == "range" then
        percent, rangeCount, raidCount = self:GetInRange()
    elseif self.data.w == "offline" then
        percent, offlineCount, raidCount = self:GetOffline()
    elseif self.data.w == "afk" then
        percent, afkCount, raidCount = self:GetAfk()
	elseif self.data.w == "pvp" then
        percent, pvpCount, raidCount = self:GetPvP()
    end
    
    -- Update color of the bar
    if self.data.useBarColor then
        local r = self.data.barcolor.r
        local g = self.data.barcolor.g
        local b = self.data.barcolor.b
        local a = self.data.barcolor.a
        self.statusbar:SetStatusBarColor(r, g, b, a)
        if self.statusbar2 then
            self.statusbar2:SetStatusBarColor(r, g, b, 0.2)
        end
    elseif self.data.w == "life" then
        self:SetSmoothBarColor(percent)
    elseif self.data.w == "mana" then
        self.statusbar:SetStatusBarColor(48/255, 113/255, 191/255, 1)
        if self.statusbar2 then
            self.statusbar2:SetStatusBarColor(48/255, 113/255, 191/255, 0.3)
        end
    elseif self.data.w == "dead" then
        self.statusbar:SetStatusBarColor(1, 0, 0, 1)
        if self.statusbar2 then
            self.statusbar2:SetStatusBarColor(1, 0, 0, 0.3)
        end
    elseif self.data.w == "alive" then
        self:SetSmoothBarColor(percent)
    elseif self.data.w == "range" then
        self:SetSmoothBarColor(percent)
    elseif self.data.w == "offline" then
        self.statusbar:SetStatusBarColor(1, 0, 0, 1)
        if self.statusbar2 then
            self.statusbar2:SetStatusBarColor(1, 0, 0, 0.3)
        end
    elseif self.data.w == "afk" then
        self.statusbar:SetStatusBarColor(1, 0, 0, 1)
        if self.statusbar2 then
            self.statusbar2:SetStatusBarColor(1, 0, 0, 0.3)
        end
	elseif self.data.w == "pvp" then
		self.statusbar:SetStatusBarColor(1, 0, 0, 1)
		if self.statusbar2 then
			self.statusbar2:SetStatusBarColor(1, 0, 0, 0.3)
		end
    end
    
    -- Update color of the text
    if self.data.useTextColor then
        local r = self.data.textcolor.r
        local g = self.data.textcolor.g
        local b = self.data.textcolor.b
        local a = self.data.textcolor.a
        self.textleft:SetTextColor(r,g,b,a)
    else
        self.textleft:SetTextColor(1,1,1,1)
    end
    
    -- Red text if percent<10
    if percent<10 and not self.data.w == "dead" then
        self.textright:SetTextColor(1,0,0)
    else
        self.textright:SetTextColor(1,1,1)
    end
    
    -- Bar update
    self.statusbar:SetValue(percent)
    if self.data.w == "alive" then
        self.textright:SetText(aliveCount .. "/" .. raidCount)
    elseif self.data.w == "dead" then
        self.textright:SetText(deadCount .. "/" .. raidCount)
    elseif self.data.w == "range" then
        self.textright:SetText(rangeCount .. "/" .. raidCount)
    elseif self.data.w == "offline" then
        self.textright:SetText(offlineCount .. "/" .. raidCount)
    elseif self.data.w == "afk" then
        self.textright:SetText(afkCount .. "/" .. raidCount)
	elseif self.data.w == "pvp" then
        self.textright:SetText(pvpCount .. "/" .. raidCount)
    else
        self.textright:SetText(percent.."%")
    end
    
    -- Update tooltip
    self.tooltip:Refresh()
end

function XRS.bar.prototype:GetLife()
    local healthPerc = 0
    local count = 0
  
    for num=1,40 do
        local raidID = "raid"..num
        local _, class = UnitClass(raidID)
        local _, _, subgroup, _, _, _, _, online, isDead = GetRaidRosterInfo(num)
        if UnitExists(raidID) and online and self:IsGroup(subgroup) and self:IsClass(class) then
            if self.data.includeDeaths or (not isDead and not UnitIsGhost(raidID)) then 
               local health = UnitHealth(raidID)
               local healthMax = UnitHealthMax(raidID)
               cPerc = (health/healthMax)*100
               if cPerc>100 then cPerc=100 end

               healthPerc = healthPerc + cPerc
               count = count + 1
            end
        end
    end

    if count == 0 then return 0 end

    return(floor(healthPerc/count))
end

function XRS.bar.prototype:GetMana()
    local manaPerc = 0
    local count = 0
    
    for num=1,40 do
        local raidID = "raid"..num
        local _, class = UnitClass(raidID)
        local _, _, subgroup, _, _, _, _, online, isDead = GetRaidRosterInfo(num)
        if UnitExists(raidID) and online and self:IsGroup(subgroup) and self:IsClass(class) and (UnitPowerType(raidID) == 0) then
            if self.data.includeDeaths or (not isDead and not UnitIsGhost(raidID)) then 
               local mana = UnitMana(raidID)
               local manaMax = UnitManaMax(raidID)
               cPerc = (mana/manaMax)*100
               if cPerc>100 then cPerc=100 end
               manaPerc = manaPerc + cPerc
               count = count + 1
            end
        end
    end
    
    if count == 0 then return 0 end
    
    return(floor(manaPerc/count)) 
end

function XRS.bar.prototype:GetAlive()
    raidCount = 0
    deadCount = 0
    percent = 0
    
    for num=1,40 do
        local raidID = "raid"..num
        local _, class = UnitClass(raidID)
        local _, _, subgroup, _, _, _, _, online, isDead = GetRaidRosterInfo(num)
        if UnitExists(raidID) and online and self:IsGroup(subgroup) and self:IsClass(class) then
            raidCount = raidCount +1
            if isDead or UnitIsGhost(raidID) then
                deadCount = deadCount + 1 
            end
        end
    end
    
    if raidCount ~= 0 then
        percent = floor((1-deadCount/raidCount)*100)
    end
    return percent, raidCount-deadCount, raidCount
end

function XRS.bar.prototype:CheckFD(unit)
    local _, class = UnitClass(unit)
	if class ~= "HUNTER" then return end
	
	local num = 1;
	buff = UnitBuff(unit, num)
	while ( buff ) do
		if ( buff == "Interface\\Icons\\Ability_Rogue_FeignDeath" ) then
			return true
		end
		num = num + 1;
		buff = UnitBuff(unit, num)
	end
	return false
end

function XRS.bar.prototype:GetInRange()
    percent = 0
    raidCount = 0
    rangeCount = 0
    local myzone=GetRealZoneText()
    for num=1,40 do
        local raidID = "raid"..num
        local _, class = UnitClass(raidID)
        local _, _, subgroup, _, _, _, zone, online = GetRaidRosterInfo(num)
        if UnitExists(raidID) and online and self:IsGroup(subgroup) and self:IsClass(class) and not UnitIsUnit(raidID, "player") then
            raidCount = raidCount + 1
            if self.data.range == "30" then
                if CheckInteractDistance(raidID,4) then
                    rangeCount = rangeCount + 1
                end
            elseif self.data.range == "100" then
                if UnitIsVisible(raidID) then
                    rangeCount = rangeCount + 1
                end
            elseif self.data.range == "zone" then
                if zone == myzone then
                    rangeCount = rangeCount + 1
                end
			elseif self.data.range == "10" then
				if CheckInteractDistance(raidID,3) then
                    rangeCount = rangeCount + 1
                end
            end
        end
    end
    
    if raidCount ~= 0 then
        percent = floor((rangeCount/raidCount)*100)
    end
    return percent, rangeCount, raidCount
end

function XRS.bar.prototype:GetOffline()
    percent = 0
    raidCount = 0
    offlineCount = 0
    for num=1,40 do
        local raidID = "raid"..num
        local _, class = UnitClass(raidID)
        local _, _, subgroup, _, _, _, zone, online = GetRaidRosterInfo(num)
        if UnitExists(raidID) and self:IsGroup(subgroup) and self:IsClass(class) then
            raidCount = raidCount + 1
            if not online then
                offlineCount = offlineCount + 1
            end
        end
    end
    
    if raidCount ~= 0 then
        percent = floor((offlineCount/raidCount)*100)
    end
    return percent, offlineCount, raidCount
end

function XRS.bar.prototype:GetAfk()
    raidCount = 0
    afkCount = 0
    percent = 0

    local ctra_enabled = IsAddOnLoaded("CT_RaidAssist")
    local ora2_enabled = IsAddOnLoaded("oRA2")

    for n, u in pairs(roster.roster) do
        if UnitIsConnected(u.unitid) and u and u.name and u.class ~= "PET" then
            raidCount = raidCount + 1
            if ora2_enabled and u.ora_afk or ctra_enabled and CT_RA_Stats[u.name] and CT_RA_Stats[u.name]["AFK"] then
                afkCount = afkCount + 1
            end
        end
    end

    if raidCount ~= 0 then
        percent = floor((afkCount/raidCount)*100)
    end
    return percent, afkCount, raidCount
end

function XRS.bar.prototype:GetPvP()
	raidCount = 0
	pvpCount = 0
	percent = 0

	for num=1,40 do
		local raidID = "raid"..num
		local _, class = UnitClass(raidID)
		local _, _, subgroup, _, _, _, _, online, isDead = GetRaidRosterInfo(num)
		if UnitExists(raidID) and online and self:IsGroup(subgroup) and self:IsClass(class) then
			raidCount = raidCount + 1
			if UnitIsPVP(raidID) then
				pvpCount = pvpCount + 1 
			end
		end
	end

	if raidCount ~= 0 then
		percent = floor((pvpCount/raidCount)*100)
	end
	return percent, pvpCount, raidCount
end

function XRS.bar.prototype:SetSmoothBarColor(percentage)
    if (percentage>1) then 
        percentage = percentage/100
    end
       		
	local red, green

	if (percentage < 0.5) then
		red = 1
		green = 2*percentage
	else
		green = 1
		red = 2*(1 - percentage)
	end
	if ((red>=0) and (green>=0) and (red<=1) and (green<=1)) then
		self.statusbar:SetStatusBarColor(red, green, 0, 1)
		if self.data.backgroundBar then
		  self.statusbar2:SetStatusBarColor(red, green, 0, 0.3)
		end
	end
end

function XRS.bar.prototype:CreateDDMenu(level, value)
    -- Create drewdrop menu
    if level == 1 then
        dewdrop:AddLine( 'text', self.data.name, 'isTitle', true )
        dewdrop:AddLine(
            'text', L["Name"],
            'hasArrow', true,
            'hasEditBox', true,
            'editBoxText', self.data.name,
            'editBoxFunc', function(text)
                self.data.name = text
                if (strlen(self.data.name) > 14) then
            		local name = strsub(self.data.name, 1, 13).."..."
            		self.textleft:SetText(name)
            	else
            	    self.textleft:SetText(self.data.name)
            	end
            end,
            'tooltipTitle', L["Name"],
            'tooltipText', L["Name_TTText"]
        )
        dewdrop:AddLine( 'text', L["Type"],
            			 'hasArrow', true,
            			 'value', "type",
            			 'tooltipTitle', L["Type_TTTitle"],
            			 'tooltipText', L["Type_TTText"]
            		  )
        if self.data.w == "blank" then
            dewdrop:AddLine(
                'text', L["Color"],
                'hasColorSwatch', true,
                'hasOpacity', true,
                'colorFunc', function(r, g, b, a)
                    self:SetBlankColor(r, g, b, a)
                end,
                'r', self.data.blankcolor.r,
                'g', self.data.blankcolor.g,
                'b', self.data.blankcolor.b,
                'hasOpacity', true,
                'opacity', self.data.blankcolor.a
            )
        else
			if self.data.w ~= "afk" then
				dewdrop:AddLine( 'text', L["Classes"],
								 'hasArrow', true,
								 'value', "classes",
								 'tooltipTitle', L["Classes_TTTitle"],
								 'tooltipText', L["Classes_TTText"]
								)
				dewdrop:AddLine( 'text', L["Groups"],
								 'hasArrow', true,
								 'value', "groups",
								 'tooltipTitle', L["Groups_TTTitle"],
								 'tooltipText', L["Groups_TTText"]
								)
			end
			dewdrop:AddLine( 'text', L["Color"],
							 'hasArrow', true,
							 'value', "color",
							 'tooltipTitle', L["Color_TTTitle"],
							 'tooltipText', L["Color_TTText"]
							)
            if self.data.w == "range"then
                dewdrop:AddLine( 'text', L["Range_Text"],
                			 'hasArrow', true,
                			 'value', "range",
                			 'tooltipTitle', L["Range_TTTitle"],
                			 'tooltipText', L["Range_TTText"]
                		  )
            end
            dewdrop:AddLine()
            if self.data.w == "life" or self.data.w == "mana" then
                dewdrop:AddLine( 'text', L["Deaths"],
        						 'checked', self.data.includeDeaths,
        						 'func', function() 
                                    self.data.includeDeaths = not self.data.includeDeaths
                                    self:UpdateBar() 
                                 end,
        						 'tooltipTitle', L["Deaths"],
                    			 'tooltipText', L["Deaths_TTText"]
                              )
            end
            dewdrop:AddLine( 'text', L["Backgroundbar"],
    						 'checked', self.data.backgroundBar,
    						 'func', function() 
                                self.data.backgroundBar = not self.data.backgroundBar
                                self:RemoveBar()
                                self:CreateBar()
                                self:UpdateBar()
                             end,
    						 'tooltipTitle', L["Backgroundbar_TTTitle"],
                			 'tooltipText', L["Backgroundbar_TTText"]
                          )
        end
        dewdrop:AddLine()
        dewdrop:AddLine( 'text', L["Bar_Up"],
                         'func', function()
                            XRS:BarUp(self)
                         end,
                         'tooltipTitle', L["Bar_Up"],
            			 'tooltipText', L["Bar_Up_TTText"]
                      )
        dewdrop:AddLine( 'text', L["Bar_Down"],
                         'func', function()
                            XRS:BarDown(self)
                         end,
                         'tooltipTitle', L["Bar_Down"],
            			 'tooltipText', L["Bar_Down_TTText"]
                      )
        dewdrop:AddLine()
        dewdrop:AddLine( 'text', L["Delete_Bar"],
                         'func', function()
                            self:DeleteBar()
                            dewdrop:Close()
                         end,
                         'tooltipTitle', L["Delete_Bar"],
            			 'tooltipText', L["Delete_Bar_TTText"]
                      )
        dewdrop:AddLine( 'text', L["Create_Bar"],
                         'func', function()
                            XRS:CreateNewBar()
                         end,
                         'tooltipTitle', L["Create_Bar_TTTitle"],
            			 'tooltipText', L["Create_Bar_TTText"]
                      )
	elseif level == 2 then
	   if value == "type" then
            dewdrop:AddLine('text', L["Life"],
            				'isRadio', true,
            				'checked', self.data.w == "life",
            				'func', function() self.data.w = "life" dewdrop:Refresh(1) self:RecreateBar() end)
            dewdrop:AddLine('text', L["Mana"],
            				'isRadio', true,
            				'checked', self.data.w == "mana",
            				'func', function() self.data.w = "mana" dewdrop:Refresh(1) self:RecreateBar() end)
            dewdrop:AddLine('text', L["Alive"],
            				'isRadio', true,
            				'checked', self.data.w == "alive",
            				'func', function() self.data.w = "alive" dewdrop:Refresh(1) self:RecreateBar() end)
            dewdrop:AddLine('text', L["Dead"],
            				'isRadio', true,
            				'checked', self.data.w == "dead",
            				'func', function() self.data.w = "dead" dewdrop:Refresh(1) self:RecreateBar() end)
            dewdrop:AddLine('text', L["Range"],
            				'isRadio', true,
            				'checked', self.data.w == "range",
            				'func', function() self.data.w = "range" dewdrop:Refresh(1) self.data.range = "30" self:RecreateBar() end)
            dewdrop:AddLine('text', L["Offline"],
            				'isRadio', true,
            				'checked', self.data.w == "offline",
            				'func', function() self.data.w = "offline" dewdrop:Refresh(1) self:RecreateBar() end)
            dewdrop:AddLine('text', L["Blank"],
            				'isRadio', true,
            				'checked', self.data.w == "blank",
            				'func', function() self.data.w = "blank" self:RecreateBar() dewdrop:Refresh(1) end)
            if IsAddOnLoaded("oRA2") or IsAddOnLoaded("CT_RaidAssist") then
                dewdrop:AddLine('text', L["Afk"],
                                'isRadio', true,
                                'checked', self.data.w == "afk",
                                'func', function() self.data.w = "afk" self:RecreateBar() dewdrop:Refresh(1) end)
            end
			dewdrop:AddLine('text', L["PvP"],
							'isRadio', true,
							'checked', self.data.w == "pvp",
							'func', function() self.data.w = "pvp" self:RecreateBar() dewdrop:Refresh(1) end)
       elseif value == "classes" then
            local isChecked
            isChecked = self:IsClass("druid")
            dewdrop:AddLine( 'text', BC["Druid"],
							 'checked', isChecked,
							 'func', function() self:AddRemoveClass("druid") end)
		    isChecked = self:IsClass("hunter")
            dewdrop:AddLine( 'text', BC["Hunter"],
							 'checked', isChecked,
							 'func', function() self:AddRemoveClass("hunter") end)
			isChecked = self:IsClass("mage")
            dewdrop:AddLine( 'text', BC["Mage"],
							 'checked', isChecked,
							 'func', function() self:AddRemoveClass("mage") end)
			if UnitFactionGroup("player") == "Alliance" then
    			isChecked = self:IsClass("paladin")
                dewdrop:AddLine( 'text', BC["Paladin"],
    							 'checked', isChecked,
    							 'func', function() self:AddRemoveClass("paladin") end)
			end
			isChecked = self:IsClass("priest")
            dewdrop:AddLine( 'text', BC["Priest"],
							 'checked', isChecked,
							 'func', function() self:AddRemoveClass("priest") end)
			isChecked = self:IsClass("rogue")
            dewdrop:AddLine( 'text', BC["Rogue"],
							 'checked', isChecked,
							 'func', function() self:AddRemoveClass("rogue") end)
			if UnitFactionGroup("player") == "Horde" then
    			isChecked = self:IsClass("Shaman")
                dewdrop:AddLine( 'text', BC["Shaman"],
    							 'checked', isChecked,
    							 'func', function() self:AddRemoveClass("shaman") end)
			end
			isChecked = self:IsClass("warlock")
            dewdrop:AddLine( 'text', BC["Warlock"],
							 'checked', isChecked,
							 'func', function() self:AddRemoveClass("warlock") end)
			isChecked = self:IsClass("warrior")
            dewdrop:AddLine( 'text', BC["Warrior"],
							 'checked', isChecked,
							 'func', function() self:AddRemoveClass("warrior") end)
        elseif value == "groups" then
            for i=1,8 do
                local isChecked
                local number = i
                isChecked = self:IsGroup(number)
                dewdrop:AddLine( 'text', L["Group"].." "..number,
                                 'checked', isChecked,
                                 'func', function() self:AddRemoveGroup(number) end)
            end
	   elseif value == "color" then
	       dewdrop:AddLine( 'text', L["Use_Bar_Color"],
							 'checked', self.data.useBarColor,
							 'func', function() 
                                self.data.useBarColor = not self.data.useBarColor
                                dewdrop:Refresh(2)
                                self:UpdateBar()
                              end)
            if self.data.useBarColor then 
                dewdrop:AddLine(
                    'text', L["Bar_Color"],
                    'hasColorSwatch', true,
                    'hasOpacity', true,
                    'colorFunc', function(r, g, b, a)
                        self:SetBarColor(r, g, b, a)
                    end,
                    'r', self.data.barcolor.r,
                    'g', self.data.barcolor.g,
                    'b', self.data.barcolor.b,
                    'hasOpacity', true,
                    'opacity', self.data.barcolor.a
                )
            end
            dewdrop:AddLine( 'text', L["Use_Text_Color"],
							 'checked', self.data.useTextColor,
							 'func', function() 
                                self.data.useTextColor = not self.data.useTextColor
                                dewdrop:Refresh(2)
                                self:UpdateBar()
                              end)
            if self.data.useTextColor then
                dewdrop:AddLine(
                    'text', L["Text_Color"],
                    'hasColorSwatch', true,
                    'hasOpacity', true,
                    'colorFunc', function(r, g, b, a)
                        self:SetTextColor(r, g, b, a)
                    end,
                    'r', self.data.textcolor.r,
                    'g', self.data.textcolor.g,
                    'b', self.data.textcolor.b,
                    'hasOpacity', true,
                    'opacity', self.data.textcolor.a
                )
            end
       elseif value == "range" then
			dewdrop:AddLine('text', L["Yards_0"],
							'isRadio', true,
							'checked', self.data.range == "10",
							'func', function() self.data.range = "10" self:RecreateBar() end)
            dewdrop:AddLine('text', L["Yards_1"],
            				'isRadio', true,
            				'checked', self.data.range == "30",
            				'func', function() self.data.range = "30" self:RecreateBar() end)
            dewdrop:AddLine('text', L["Yards_2"],
            				'isRadio', true,
            				'checked', self.data.range == "100",
            				'func', function() self.data.range = "100" self:RecreateBar() end)
            dewdrop:AddLine('text', L["Yards_3"],
            				'isRadio', true,
            				'checked', self.data.range == "zone",
            				'func', function() self.data.range = "zone" self:RecreateBar() end)
	   end
    end
end

function XRS.bar.prototype:IsClass(class)
    if not class then return false end
    for _,v in self.data.c do
        if string.lower(v) == string.lower(class) then return true end
    end
    return false
end

function XRS.bar.prototype:IsGroup(group)
    return self.data.group[group]
end

function XRS.bar.prototype:AddRemoveClass(class)
    self:Debug("Class: "..class)
    if self:IsClass(class) then
        self:Debug("Remove: "..class)
        self:RemoveClass(class)
    else
        self:Debug("Add: "..class)
        self:AddClass(class)
    end
    self:RecreateBar()
end

function XRS.bar.prototype:AddRemoveGroup(group)
    self.data.group[group] = not self.data.group[group]
    self:RecreateBar()
end

function XRS.bar.prototype:RemoveClass(class)
    for k,v in self.data.c do
        if string.lower(v) == string.lower(class) then
            table.remove(self.data.c, k)
        end
    end
end

function XRS.bar.prototype:AddClass(class)
    table.insert(self.data.c, class)
end

function XRS.bar.prototype:RecreateBar()
    -- Update everything
    self:RemoveBar()
    self:CreateBar()
    if self.data.w ~= "blank" then
        self:UpdateBar()
    end
    
    -- Rebuild table in xrs to filter events/class
    XRS:RebuildClassBarTable()
end

function XRS.bar.prototype:DeleteBar()
    self:RemoveBar()
    XRS:DeleteBar(self)
end

function XRS.bar.prototype:GetClasses()
    return self.data.c
end

function XRS.bar.prototype:GetType()
    return self.data.w
end

function XRS.bar.prototype:GetObject()
    return self.statusbar
end

function XRS.bar.prototype:SetPosition(pos)
    self.pos = pos
    local height = -((self.pos-1)*16)-20
    
    if self.statusbar2 then
        self.statusbar2:SetPoint("TOP", XRS.frame, "TOP", 0, height)
        self.statusbar:SetPoint("TOP", self.statusbar2, "TOP", 0, 0)
    else
        self.statusbar:SetPoint("TOP", XRS.frame, "TOP", 0, height)
    end
end

function XRS.bar.prototype:GetPosition()
    return self.pos
end

function XRS.bar.prototype:SetBarColor(r, g, b, a)
    self.data.barcolor.r = r
    self.data.barcolor.g = g
    self.data.barcolor.b = b
    self.data.barcolor.a = a
    
    if self.data.useBarColor then
        self:UpdateBar()
    end
end

function XRS.bar.prototype:SetTextColor(r, g, b, a)
    self.data.textcolor.r = r
    self.data.textcolor.g = g
    self.data.textcolor.b = b
    self.data.textcolor.a = a
    
    if self.data.useTextColor then
        self:UpdateBar()
    end
end

function XRS.bar.prototype:SetBarTexture(value)
	if self.data.w ~= "blank" then
		self.statusbar:SetStatusBarTexture(value)
		if self.statusbar2 then
			self.statusbar2:SetStatusBarTexture(value)
		end
	end
end

function XRS.bar.prototype:ToString()
    return self.data.name
end

function XRS.bar.prototype:SetBlankColor(r, g, b, a)
    self.data.blankcolor.r = r
    self.data.blankcolor.g = g
    self.data.blankcolor.b = b
    self.data.blankcolor.a = a
    
    local color = self.data.blankcolor
    self.line:SetBackdropColor(color.r, color.g, color.b, color.a)
end

function XRS.bar.prototype:SetWidth(width)
	self.width = width
	self.statusbar:SetWidth(width)
	if self.statusbar2 then
		self.statusbar2:SetWidth(width)
	end
	if self.data.w == "blank" then
		self.line:SetWidth(width)
	end
end