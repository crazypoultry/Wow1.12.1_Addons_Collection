----------------------------
--      Declaration       --
----------------------------

XRS = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0", "AceDebug-2.0")
local L = AceLibrary("AceLocale-2.2"):new("XRS")
local dewdrop = AceLibrary("Dewdrop-2.0")
local BS = AceLibrary("Babble-Spell-2.2")
local BC = AceLibrary("Babble-Class-2.2")
local crayon = AceLibrary("Crayon-2.0")
local compost = AceLibrary("Compost-2.0")
local roster = AceLibrary("RosterLib-2.0")

BINDING_HEADER_XRS="XRaidStatus"

----------------------------
--      Main Functions    --
----------------------------

function XRS:OnInitialize()
    -- Debugging state
    self:SetDebugging(false)
    
    -- Command structure
    self.options = {
        type="group",
        args = {
            scale = {
                name = L["Scale"], type = "range",
                desc = L["Scale_D"],
                get = function() return self.db.profile.Scale end,
                set = function(v)
                    self.db.profile.Scale = v
                    self:UpdateScale()
                end,
                min = 0.5,
                max = 1.5,
                step = 0.05,
                order = 2
            },
			width = {
				name = L["Width"], type = "range",
				desc = L["Width_D"],
				get = function() return self.db.profile.Width end,
				set = function(v)
					self.db.profile.Width = v
					self:SetWidth()
				end,
				min = 70,
				max = 200,
				step = 5,
				order = 3
			},
            texture = {
                name = L["Textures"], type = 'text',
                desc = L["Textures_D"],
                get = function()
                    return self.db.profile.Texture
                end,
                set = function(name)
                    self:SetBarTexture(name)
                end,
                validate = {},
                order = 4,
            },
            color = {
                name = L["Color_Group"], type = "group",
                desc = L["Color_Group_D"],
                args = {
                    background = {
                        name = L["BColor"], type = 'color',
                        desc = L["BColor_D"],
                        get = function()
                            local bc = self.db.profile.backgroundcolor
                            return bc.r, bc.g, bc.b, bc.a
                        end,
                        set = function(r, g, b, a)
                            self:UpdateBackgroundColor(r,g,b,a)
                        end,
                        hasAlpha = true,
                        order = 1,
                    },
                    title = {
                        name = L["TColor"], type = 'color',
                        desc = L["TColor_D"],
                        get = function()
                            local tc = self.db.profile.titlecolor
                            return tc.r, tc.g, tc.b, tc.a
                        end,
                        set = function(r, g, b, a)
                            self:UpdateTitleColor(r,g,b,a)
                        end,
                        hasAlpha = true,
                        order = 2,
                    },
                    border = {
                        name = L["BOColor"], type = 'color',
                        desc = L["BOColor_D"],
                        get = function()
                            local boc = self.db.profile.bordercolor
                            return boc.r, boc.g, boc.b, boc.a
                        end,
                        set = function(r, g, b, a)
                            self:UpdateBorderColor(r,g,b,a)
                        end,
                        hasAlpha = true,
                        order = 3,
                    },                    
                },
                order = 5
            },
            updaterate = {
                name = L["Update_Rate"], type = "range",
                desc = L["Update_Rate_D"],
                get = function() return self.db.profile.UpdateRate end,
                set = function(v)
                    self:ModifyUpdateRate(v)
                end,
                min = 0.1,
                max = 1.5,
                step = 0.1,
                order = 6
            },
            lock = {
                name = L["Lock"], type = "toggle",
                desc = L["Lock_D"],
                get =   function()
                            return self.db.profile.Locked
                        end,
                        set = function(v)
                            self.db.profile.Locked = v
                        end,
                order = 7
            },
            hint = {
                name = L["Hint"], type = "toggle",
                desc = L["Hint_D"],
                get =   function()
                            return self.db.profile.ShowHint
                        end,
                        set = function(v)
                            self.db.profile.ShowHint = v
                        end,
                order = 8
            },
            blankone = {
                type = "header",
                order = 9
            },
            save = {
                name = L["Save"], type = 'text',
                desc = L["Save_D"],
                usage = "<name>",
                get = false,
                set = function(name) self:SaveConfiguration(name) end,
                order = 11,
                args = {}
            },
            load = {
                name = L["Load"], type = 'group',
                desc = L["Load_D"],
                order = 12,
                args = {}
            },
            delete = {
                name = L["Delete"], type = 'group',
                desc = L["Delete_D"],
                order = 13,
                args = {}
            },
            blanktwo = {
                type = "header",
                order = 19
            },
            new = {
                name = L["New_Group"], type = "group",
                desc = L["New_Group_D"],
                args = {
                    bar = {
                        name = L["Create_Bar"], type = "execute",
                        desc = L["Create_Bar_D"],
                        func = function()
                                    self:CreateNewBar()
                                end,
                        order = 1
                    },
                    buff = {
                        name = L["Create_Button"], type = "execute",
                        desc = L["Create_Button_D"],
                        func = function()
                                    self:CreateNewBuffButton()
                                end,
                        order = 2
                    },
                },
                order = 20,
            },
            blankthree = {
                type = "header",
                order = 29
            },
            deletedb = {
                name = L["Delete_DB"], type = "execute",
                desc = L["Delete_DB_D"],
                func = function()
                            self:ResetDB("profile")
                        end,
                order = 30
            }
        }
    }

    -- Class table
    self.classTable = {
        "Druid",
        "Hunter",
        "Mage",
        "Paladin",
        "Priest",
        "Rogue",
        "Shaman",
        "Warlock",
        "Warrior",
    }
    
    -- Buff table
    self.buffTable = {
        sta = {
            BS["Power Word: Fortitude"],
            BS["Prayer of Fortitude"],
        },
        motw = {
            BS["Mark of the Wild"],
            BS["Gift of the Wild"],
        },
        ai = {
            BS["Arcane Intellect"],
            BS["Arcane Brilliance"],
        },
        spi = {
            BS["Divine Spirit"],
            BS["Prayer of Spirit"],
        },
        sp = {
            BS["Shadow Protection"],
            BS["Prayer of Shadow Protection"],
        }
    }
    
    -- initialize necessary table for storing bars etc.
    self.bars = {}
    self.updatebars = compost:Acquire()
    self.buffs = {}
    
    -- Initialize bar textures
    self.textures = {
        [L["Texture"] .. 1] = "Interface\\Addons\\XRS\\images\\statusbar.tga",
        [L["Texture"] .. 2] = "Interface\\Addons\\XRS\\images\\statusbar2.tga",
        [L["Texture"] .. 3] = "Interface\\Addons\\XRS\\images\\statusbar3.tga",
        [L["Texture"] .. 4] = "Interface\\Addons\\XRS\\images\\statusbar4.tga",
        [L["Texture"] .. 5] = "Interface\\Addons\\XRS\\images\\statusbar5.tga",
        [L["Texture"] .. 6] = "Interface\\Addons\\XRS\\images\\statusbar6.tga",
        ["Standard"] = "Interface\\TargetingFrame\\UI-StatusBar",
		["Diagonal"] = "Interface\\Addons\\XRS\\images\\Diagonal.tga",
		["BantoBar"] = "Interface\\Addons\\XRS\\images\\BantoBar.tga",
		["Skewed"] = "Interface\\Addons\\XRS\\images\\Skewed.tga",
    }
    for k,v in pairs(self.textures) do
        self.options.args.texture.validate[v] = k 
    end        
    
    -- Register everything
    self:RegisterDB("XRSDB")
    self:RegisterDefaults('profile', XRS_DEFAULTS )	
    self:RegisterChatCommand({ "/xraidstatus", "/xrs" }, self.options )
    
    if not self.version then self.version = GetAddOnMetadata("XRS", "Version") end
	local rev = string.gsub(GetAddOnMetadata("XRS", "X-Build"), "%$Revision: (%d+) %$", "%1")
	self.version = self.version .. " |cffff8888r"..rev.."|r"
end

function XRS:OnEnable()
    -- Register event to update the raid
    self:RegisterEvent("RAID_ROSTER_UPDATE")
    
    -- One time event to check for a raid ...
    self:RegisterEvent("MEETINGSTONE_CHANGED", "MEETINGSTONE_CHANGED", true)
    self:MEETINGSTONE_CHANGED();
end

function XRS:OnDisable()
    -- no more events to handle
    self:UnregisterAllEvents()
    self:LeaveRaid()
end

--[[--------------------------------------------------------------------------------
  Frame Creation 
-----------------------------------------------------------------------------------]]

function XRS:SetupFrames()
    -- Create Tooltip
    if not self.tooltip then
        self.tooltip = CreateFrame("GameTooltip", "XRSTooltip", UIParent, "GameTooltipTemplate")
        self.tooltip:SetScript("OnLoad",function() this:SetOwner(WorldFrame, "ANCHOR_NONE") end)
    end

	-- Create XRS Frame
	self.frame = CreateFrame("Frame", "XRSFrame", UIParent)
	self.frame:EnableMouse(true)
	self.frame:SetFrameStrata("MEDIUM")
	self.frame:SetMovable(true)
	self.frame:SetWidth(130)
    self.frame:SetHeight(100)
    -- Create Font String
    self.xrsfs = self.frame:CreateFontString("$parentTitle","ARTWORK","GameFontNormal")
    self.xrsfs:SetText("XRaidStatus")
    self.xrsfs:SetPoint("TOP",0,-5)
    local tc = self.db.profile.titlecolor
    self.xrsfs:SetTextColor(tc.r,tc.g,tc.b,tc.a)
    self.xrsfs:Show()
    -- Backdrop options
    self.frame:SetBackdrop( { 
      bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", 
      edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, 
      insets = { left = 5, right = 5, top = 5, bottom = 5 }
    })
    local boc = self.db.profile.bordercolor
    self.frame:SetBackdropBorderColor(boc.r,boc.g,boc.b,boc.a)
    local bc = self.db.profile.backgroundcolor
	self.frame:SetBackdropColor(bc.r,bc.g,bc.b,bc.a)
	self.frame:ClearAllPoints()
	self.frame:SetPoint("CENTER", WorldFrame, "CENTER", 0, 0)
	self.frame:SetScript("OnMouseDown",function()
        if ( arg1 == "LeftButton" ) then
            if not self.db.profile.Locked then
                this:StartMoving()
            end
		end
    end)
    self.frame:SetScript("OnMouseUp",function()
        if ( arg1 == "LeftButton" ) then
			this:StopMovingOrSizing()
			self:SavePosition()
		end
    end)
    self.frame:SetScript("OnHide",function() this:StopMovingOrSizing() end)
    self.frame:SetScript("OnShow",function() 
                            for _,v in ipairs(self.bars) do
                                if v:GetType() ~= "blank" then
                                    v:UpdateBar()
                                end
                            end
                        end)
                        
    -- Frame cannot be dragged off the screen
    self.frame:SetClampedToScreen(true)
    
    -- Update dewdrop table
    self:UpdateDewdrop()
    
    -- Loads the position of the frame
    self:LoadPosition()
    
    -- The scale from the db
    self:UpdateScale()

    self:Debug("XRS Frame created!")
    
    -- Create a button for raid leader options
    if (IsRaidLeader() or IsRaidOfficer()) then
        self:CreateLeaderMenu()
    end
    
    -- Create all bars and buffs
    self:SetupBars()
    self:SetupBuffs()
	self:SetWidth()
end

--[[--------------------------------------------------------------------------------
  Switch Database
-----------------------------------------------------------------------------------]]

function XRS:OnProfileEnable()
    -- this is called every time your profile changes (after the change)
    for _,v in self.bars do
        v:RemoveBar()
    end
    for _,v in self.buffs do
        v:RemoveBuff()
    end
    
    self.bars = {}
    self.buffs = {}
    
    self:SetupBars()
    self:SetupBuffs()
end

--[[--------------------------------------------------------------------------------
  Event Handling
-----------------------------------------------------------------------------------]]
    
function XRS:RegisterRaidEvents()
    -- Register the WoW events
    self:RegisterBucketEvent("UNIT_HEALTH", self.db.profile.UpdateRate)
    self:RegisterBucketEvent("UNIT_MAXHEALTH", self.db.profile.UpdateRate, "UNIT_HEALTH")
    self:RegisterBucketEvent("UNIT_MANA", self.db.profile.UpdateRate)
    self:RegisterBucketEvent("UNIT_MAXMANA", self.db.profile.UpdateRate, "UNIT_MANA")
    self:RegisterEvent("oRA_AfkDndUpdated", "UpdateAfkBars")
    self:RegisterEvent("RosterLib_RosterChanged", "UpdateAfkBars")
	
	self:Debug("Raid events registered")
end

function XRS:MEETINGSTONE_CHANGED()
    if( GetNumRaidMembers() > 0 ) then
        self:RAID_ROSTER_UPDATE()
    end
end
    
--[[--------------------------------------------------------------------------------
  Main processing
-----------------------------------------------------------------------------------]]

function XRS:RAID_ROSTER_UPDATE()
    if( GetNumRaidMembers() > 0 ) then
        if( not self.inRaid ) then
            self.inRaid = true
            self:RegisterRaidEvents()
            if not self.frame then self:SetupFrames() end
        end
        
        self.frame:Show()
        
        if (IsRaidLeader() or IsRaidOfficer()) then
            self:CreateLeaderMenu()
        else
            self:RemoveLeaderMenu()
        end
        
        for _,v in ipairs(self.bars) do
            if v:GetType() ~= "blank" then
                v:UpdateBar()
            end
        end
    elseif( self.inRaid ) then
        self:LeaveRaid()
    end
end

function XRS:SetupBars()    
    local bt = self.db.profile.barTable
      
    for k,v in bt do
        -- get the data
        local d = bt[k]
        -- create the bar
        local bar = self.bar:new(k, d, self.db.profile.Texture)
        -- add the bar to the bartable
        table.insert(self.bars, bar)
    end
    
    self:RebuildClassBarTable()
end

function XRS:SetupBuffs()
    local bt = self.db.profile.buffTable
      
    for k,v in bt do
        -- create the buff
        local buff = self.buff:new(k-1, v)
        -- add the buff to the bufftable
        table.insert(self.buffs, buff)
    end
    
    self:RebuildClassBarTable()
end

function XRS:RebuildClassBarTable()
    self.life = {}
    self.mana = {}
    self.alive = {}
    self.dead = {}
    self.range = {}
    self.offline = {}
    self.afk = {}
	self.pvp = {}
    
    for k,v in ipairs(self.bars) do
        local classes = v:GetClasses()
        local w = v:GetType()
        
        -- Those types need a constant update, no event and no class specific
        if w == "range" or w == "afk" or w == "pvp" then
            table.insert(self[w], v)
        elseif w ~= "blank" then
            -- add the bar to the class bar table (life, mana, ...) for later access
            for _,i in ipairs(classes) do
                i = string.lower(i)
                if not self[w][i] then self[w][i] = {} end
                table.insert(self[w][i], v)
            end
        end
        
        self:Debug("Bar added: "..w)
    end
    
    if table.getn(self.range) == 0 then
        -- cancel the timer
        self:CancelScheduledEvent("rangeID")
    end
    
	self:SetWidth()
end
    
function XRS:LeaveRaid()
    -- cancel the event to update the bars
    self:CancelScheduledEvent("barsID")
    -- hide the frame
    if self.frame then
        self.frame:Hide()
    end
    -- remove the leader menu (if there is one)
    self:RemoveLeaderMenu()
    
    -- disable all buff icons (own events)
    for k,v in ipairs(self.buffs) do
        v:Disable()
    end
    
    -- nil out everything
    self.bars = {}
    self.buffs = {}
    self.frame = nil
    self.xrsfs = nil
    self.inRaid = nil
end

function XRS:COMBAT_START()
    self.inCombat = TRUE
    self:SetVisual()
end

function XRS:COMBAT_STOP()
    self.inCombat = FALSE
    self:RaidCheck()
    self:SetVisual()
end

function XRS:UNIT_HEALTH(units)
    for unit in pairs(units) do
        _, class = UnitClass(unit)
        if not class then return end
        class = string.lower(class)
        if self.life[class] then
            for _,v in self.life[class] do
                -- Update every bar which is affected by that event and class
                self:AddToQueue(v)
            end
        end
        
        if self.alive[class] then
            for _,v in self.alive[class] do
                self:AddToQueue(v)
            end
        end
        
        if self.dead[class] then
            for _,v in self.dead[class] do
                self:AddToQueue(v)
            end
        end
        
        if self.offline[class] then
            for _,v in self.offline[class] do
                self:AddToQueue(v)
            end
        end
    end
	
	self:UpdateAllBars()
end

function XRS:UNIT_MANA(units)
    for unit in pairs(units) do
        _, class = UnitClass(unit)
        if not class then return end
        class = string.lower(class)
        if self.mana[class] then
            for _,v in self.mana[class] do
                self:AddToQueue(v)
            end
        end
    end
	
	self:UpdateAllBars()
end

function XRS:SavePosition()    
    local scale = self.frame:GetEffectiveScale()
	local worldscale = UIParent:GetEffectiveScale()
	
	local x,y = self.frame:GetLeft()*scale,self.frame:GetTop()*scale - (UIParent:GetTop())*worldscale

	if not self.db.profile.Position then 
		self.db.profile.Position = {}
	end
	
	self.db.profile.Position.x = x
	self.db.profile.Position.y = y
end

function XRS:LoadPosition()
	if(self.db.profile.Position) then
		local x = self.db.profile.Position.x
		local y = self.db.profile.Position.y
		local scale = self.frame:GetEffectiveScale()
		
		self.frame:SetPoint("TOPLEFT", UIParent,"TOPLEFT", x/scale, y/scale)
	else
		self.frame:SetPoint("CENTER", UIParent, "CENTER")
	end
end

function XRS:UpdateScale()
    if self.frame then
        self.frame:SetScale(self.db.profile.Scale)
        self:LoadPosition()
    end
end

function XRS:CreateNewBar()
    local classes = {"Druid"}
    local pos = table.getn(self.db.profile.barTable)+1
    local name = "New bar <"..pos..">"
    local w = "life"
    
    -- Create temp table
    local tempTable = {}
    tempTable.name = name
    tempTable.c = classes
    tempTable.w = w
    
    -- Create the bar
    local bar = self.bar:new(pos, tempTable, self.db.profile.Texture)
    
    -- Add the temp table to the table in the db for saving
    table.insert(self.db.profile.barTable, pos, tempTable)
    table.insert(self.bars, bar)
    
    -- Update class bar table
    self:RebuildClassBarTable()
end

-- Delete the specified bar
function XRS:DeleteBar(bar)
    for k,v in self.bars do
        if v == bar then
            table.remove(self.bars, k)
            table.remove(self.db.profile.barTable, k)
        end
    end
    
    -- Update class bar table
    self:RebuildClassBarTable()
    
    -- Update visual position
    for k,v in self.bars do
        v:SetPosition(k)
    end
end

-- Save the configuration
function XRS:SaveConfiguration(name)
    -- Save configuration into the db
    if not self.db.profile.configs then self.db.profile.configs = {} end
    self.db.profile.configs[name] = {}
    self:TableCopy(self.db.profile.barTable, self.db.profile.configs[name])
    
    -- Update dewdrop
    XRS:UpdateDewdrop()
end

-- Load the configuration
function XRS:LoadConfiguration(name)
    for k,v in self.bars do
        v:RemoveBar()
    end
    
    self.bars = {}
    self.db.profile.barTable = {}
    
    self:TableCopy(self.db.profile.configs[name], self.db.profile.barTable)

    self:SetupBars()
end

-- A helper function to copy tables
function XRS:TableCopy(from, to)
    for k,v in from do
        if type(v)=="table" then
            to[k] = {}
            self:TableCopy(from[k], to[k])
        else
            to[k] = v
        end
    end
end

-- Delete the configuration
function XRS:DeleteConfiguration(name)
    self.db.profile.configs[name] = nil
    
    -- Update dewdrop
    XRS:UpdateDewdrop()
end

-- Update dewdrop table
function XRS:UpdateDewdrop()
    -- Init the load configuration category
	local count = 1
	if self.db.profile.configs then
	    self.options.args.load.args = {}
	    self.options.args.delete.args = {}
    	for k,_ in self.db.profile.configs do
    	    local string_count = tostring(count)
    	    local val = k
    	    self.options.args.load.args[string_count] = {}
    	    self.options.args.load.args[string_count].name = k
    	    self.options.args.load.args[string_count].type = "execute"
    	    self.options.args.load.args[string_count].desc = "Load "..k
    	    self.options.args.load.args[string_count].func = function() self:LoadConfiguration(val) end
    	    
    	    self.options.args.delete.args[string_count] = {}
    	    self.options.args.delete.args[string_count].name = k
    	    self.options.args.delete.args[string_count].type = "execute"
    	    self.options.args.delete.args[string_count].desc = "Load "..k
    	    self.options.args.delete.args[string_count].func = function() self:DeleteConfiguration(val) end
    	    count = count + 1
        end
    end

    dewdrop:Register(self.frame, 'children', self.options)
end

-- Move the bar up
function XRS:BarUp(bar)
    local pos = bar:GetPosition()
    local bt = self.db.profile.barTable
    
    if bar:GetPosition() == 1 then return end
    
    self.bars[pos], self.bars[pos-1] = self.bars[pos-1], self.bars[pos]
    bt[pos], bt[pos-1] = bt[pos-1], bt[pos]
    
    self.bars[pos]:SetPosition(pos)
    self.bars[pos-1]:SetPosition(pos-1)
end

-- Move the bar down
function XRS:BarDown(bar)
    local pos = bar:GetPosition()
    local bt = self.db.profile.barTable
    
    if bar:GetPosition() == table.getn(self.bars) then return end
    
    self.bars[pos], self.bars[pos+1] = self.bars[pos+1], self.bars[pos]
    bt[pos], bt[pos+1] = bt[pos+1], bt[pos]
    
    self.bars[pos]:SetPosition(pos)
    self.bars[pos+1]:SetPosition(pos+1)
end

-- Create a button for raid leader options
function XRS:CreateLeaderMenu()
    if not self.leaderbutton then
        self.leaderbutton = CreateFrame("Button", nil, self.frame)
        self.leaderbutton:SetWidth(16)
        self.leaderbutton:SetHeight(16)
        self.leaderbutton:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up")
        self.leaderbutton:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down") 
        self.leaderbutton:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
        self.leaderbutton:SetScript("OnClick",function() dewdrop:Open(self.leaderbutton) end)
        self.leaderbutton:ClearAllPoints()
        self.leaderbutton:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 5, -5)
        
        -- Register dewdrop
        dewdrop:Register(self.leaderbutton, 'dontHook', true, 'children', function(level, value) self:CreateDDLeaderMenu(level, value) end)
        
        self.leaderbutton:Show()
        
        self:Debug("Leader Button created!")
    end
end

-- Removes the button if the player is not a raid leader
function XRS:RemoveLeaderMenu()
    if self.leaderbutton then
        self.leaderbutton:Hide()
        dewdrop:Unregister(self.leaderbutton)
        self.leaderbutton = nil
    end
end

function XRS:CreateDDLeaderMenu(level, value)
    -- Create drewdrop menu
    if level == 1 then
        dewdrop:AddLine( 'text', L["Raid_Leader_Options"], 'isTitle', true )
        dewdrop:AddLine( 'text', L["Buff_Check"],
            			 'hasArrow', true,
            			 'value', "bc",
            			 'tooltipTitle', L["Buff_Check"],
            			 'tooltipText', L["Buff_Check_TTText"]
            		  )
        dewdrop:AddLine( 'text', L["Ready_Check"],
                         'func', function()
                            DoReadyCheck()
                         end,
                         'tooltipTitle', L["Ready_Check"],
            			 'tooltipText', L["Ready_Check_TTText"]
                      )
    elseif level == 2 then
        if value == "bc" then
            dewdrop:AddLine( 'text', L["Select_Buffs"],
            			 'hasArrow', true,
            			 'value', "buffs",
            			 'tooltipTitle', L["Select_Buffs"],
            			 'tooltipText', L["Select_Buffs_TTText"]
            		  )
            dewdrop:AddLine( 'text', L["Start_Check"],
                         'func', function()
                            XRS:BuffCheck()
                         end,
                         'tooltipTitle', L["Start_Check"],
            			 'tooltipText', L["Start_Check_TTText"]
                      )
        end
    elseif level == 3 then    
        if value == "buffs" then
            dewdrop:AddLine( 'text', BS["Arcane Intellect"],
							 'checked', self.db.profile.buffcheck.ai,
							 'func', function() self.db.profile.buffcheck.ai = not self.db.profile.buffcheck.ai end)
			dewdrop:AddLine( 'text', BS["Mark of the Wild"],
							 'checked', self.db.profile.buffcheck.motw,
							 'func', function() self.db.profile.buffcheck.motw = not self.db.profile.buffcheck.motw end)
			dewdrop:AddLine( 'text', BS["Power Word: Fortitude"],
							 'checked', self.db.profile.buffcheck.sta,
							 'func', function() self.db.profile.buffcheck.sta = not self.db.profile.buffcheck.sta end)
			dewdrop:AddLine( 'text', BS["Divine Spirit"],
							 'checked', self.db.profile.buffcheck.spi,
							 'func', function() self.db.profile.buffcheck.spi = not self.db.profile.buffcheck.spi end)
			dewdrop:AddLine( 'text', BS["Shadow Protection"],
							 'checked', self.db.profile.buffcheck.sp,
							 'func', function() self.db.profile.buffcheck.sp = not self.db.profile.buffcheck.sp end)
        end
    end
end

-- Starts the buff check
function XRS:BuffCheck()
    if not IsRaidLeader() and not IsRaidOfficer() then return end
    local missingTable = compost:Acquire()
    
    local bt = self.buffTable
	
	for num=1,40 do
	   if (UnitExists("raid"..num) and UnitIsConnected("raid"..num)) then
            local raidname = UnitName("raid"..num)
	        if self.db.profile.buffcheck.sta then
    	        if not missingTable.sta then missingTable.sta = {} end
                local b1, b2 = self:AuraScan("raid"..num, bt.sta)
                if (not (b1 or b2)) then table.insert(missingTable.sta, raidname) end
            end
            
            if self.db.profile.buffcheck.motw then
                if not missingTable.motw then missingTable.motw = { } end
                b1, b2 = self:AuraScan("raid"..num, bt.motw)
                if (not (b1 or b2)) then table.insert(missingTable.motw, raidname) end
            end
            
            if self.db.profile.buffcheck.sp then
                if not missingTable.sp then missingTable.sp = { } end
                b1, b2 = self:AuraScan("raid"..num, bt.sp)
                if (not (b1 or b2)) then table.insert(missingTable.sp, raidname) end
            end
            
            local _, class = UnitClass("raid"..num) 
            if (class ~= "WARRIOR" and class ~= "ROGUE") then
                if self.db.profile.buffcheck.spi then
                    if not missingTable.spi then missingTable.spi = { } end
                    b1, b2 = self:AuraScan("raid"..num, bt.spi)
                    if (not (b1 or b2)) then table.insert(missingTable.spi, raidname) end
                end
                
                if self.db.profile.buffcheck.ai then
                    if not missingTable.ai then missingTable.ai = { } end
                    b1, b2 = self:AuraScan("raid"..num, bt.ai)
                    if (not (b1 or b2)) then table.insert(missingTable.ai, raidname) end
                end
            end
       end 
    end
    
    self:OutputBuffCheck(missingTable)
    compost:Reclaim(missingTable)
    missingTable = nil
end

-- Helper function to check for missing buffs
function XRS:AuraScan(u, db)
   t = "XRSTooltip" local tdb = {}
   getglobal(t):SetOwner(WorldFrame, "ANCHOR_NONE");
   if type(u) ~= "string" then
      db = u u = "player"
   end
   for k, v in db do local n, b = 1
      local fnd = function(f, txt, n)
         getglobal(t):ClearLines()
         getglobal(t)[f](getglobal(t), u, n)
         b = getglobal(t..txt):GetText()
         if strfind(b or "", v) then
            tinsert(tdb, k, n)
         end
      end
      while UnitBuff(u, n) do
         if fnd("SetUnitBuff",
            "TextLeft1", n) then break
         end
         n = n + 1
      end
      n = 1
   end
   return unpack(tdb)
end

-- Output the table to the raid chat
function XRS:OutputBuffCheck(tbl)
    local count = 0
    for k,v in tbl do
        count = count + table.getn(tbl[k])
    end
    
    if (count==0) then self:RaidOutput("XRS :: "..L["No Buffs Needed!"]) return end
    if (count>0) then self:RaidOutput("XRS :: "..count..L[" missing buffs."]) end
    
    for k,v in tbl do
        if table.getn(tbl[k]) > 0 then
            local msg = "<"..self.buffTable[k][1].."> : "
            msg = msg..table.concat(tbl[k], ", ")
            self:RaidOutput(msg)
        end
    end
end

-- Message output to the raid frame
function XRS:RaidOutput(msg)
    SendChatMessage(msg, "RAID")
end

-- Sets the bar textures of every bar
function XRS:SetBarTexture(name)
    self.db.profile.Texture = name
    for _,v in ipairs(self.bars)do
        v:SetBarTexture(name)        
    end
end

-- Updates the Background Color of the main frame
function XRS:UpdateBackgroundColor(r,g,b,a)
    local bc = self.db.profile.backgroundcolor
    bc.r, bc.g, bc.b, bc.a = r, g, b, a
	self.frame:SetBackdropColor(r,g,b,a)
end

-- Updates the Title Color
function XRS:UpdateTitleColor(r,g,b,a)
    local tc = self.db.profile.titlecolor
    tc.r, tc.g, tc.b, tc.a = r, g, b, a
    self.xrsfs:SetTextColor(r,g,b,a)
end

-- Updates the Border Color
function XRS:UpdateBorderColor(r,g,b,a)
    local boc = self.db.profile.bordercolor
    boc.r, boc.g, boc.b, boc.a = r, g, b, a
    self.frame:SetBackdropBorderColor(r,g,b,a)
end

function XRS:ModifyUpdateRate(rate)
    self.db.profile.UpdateRate = rate

    local registered = self:IsBucketEventRegistered("UNIT_HEALTH")
    if registered then
        self:RegisterBucketEvent("UNIT_HEALTH", rate)
        self:RegisterBucketEvent("UNIT_MAXHEALTH", rate, "UNIT_HEALTH")
        self:RegisterBucketEvent("UNIT_MANA", rate)
        self:RegisterBucketEvent("UNIT_MAXMANA", rate, "UNIT_MANA")
    end
end

-- Add the bar to the queue to update it later
function XRS:AddToQueue(bar)
    if not self:AlreadyQueued(bar) then self.updatebars[bar] = bar end
end

-- Checks if the bar is already queued for an update
function XRS:AlreadyQueued(bar)
    if self.updatebars[bar] then return true end
    return false
end

-- Update all bars where an event occured
--local inittime, initmem, endtime, endmem
function XRS:UpdateAllBars()
	--inittime, initmem = GetTime(), gcinfo()
    for _,v in pairs(self.updatebars) do
        v:UpdateBar()
    end
    for _,v in ipairs(self.range) do
        v:UpdateBar()
    end
	for _,v in ipairs(self.pvp) do
        v:UpdateBar()
    end
    self.updatebars = compost:Erase(self.updatebars)
	--endtime, endmem = GetTime(), gcinfo()
	--self:Debug(string.format("%s - %s (%s / %s)", endmem-initmem, endtime-inittime, initmem, endmem)) 
end

-- Create a new buff button
function XRS:CreateNewBuffButton()
    local classes = {"Druid"}
    local buffs = {BS["Power Word: Fortitude"], BS["Prayer of Fortitude"]}
    
    -- Create temp table
    local tempTable = {}
    tempTable.c = classes
    tempTable.buffs = buffs
    
    local position = table.getn(self.buffs)
    
    table.insert(self.db.profile.buffTable, tempTable)
    table.insert(self.buffs, self.buff:new(position, tempTable))
    
    -- Update class bar table
    self:RebuildClassBarTable()
end

-- Delete the specified bar
function XRS:DeleteBuff(buff)
    for k,v in self.buffs do
        if v == buff then
            table.remove(self.buffs, k)
            table.remove(self.db.profile.buffTable, k)
            break
        end
    end
    
    -- Update class bar table
    self:RebuildClassBarTable()
    
    -- Update visual position
    for k,v in self.buffs do
        v:SetPosition(k)
    end
end

-- Press a button to buff the raid
function XRS:BuffButtonPress()
    if not self.inRaid then return end
    _, class = UnitClass("player")
    if (class=="DRUID") then self:BuffRaid(BS["Mark of the Wild"])
    elseif (class=="PRIEST") then self:BuffRaid(BS["Power Word: Fortitude"])
    elseif (class=="MAGE") then self:BuffRaid(BS["Arcane Intellect"])
    end
end

local buffRaidPosition = 1
function XRS:BuffRaid(spell, buffClass)
	local selfCast = GetCVar("autoSelfCast")
	SetCVar("autoSelfCast", "0")
    if not buffClass then
        for _,v in self.buffs do
            local buffs = v:GetBuffs()
            for _, i in buffs do
                if i == spell then
                    buffClass = v
                    break
                end
            end
        end
    end

    if buffClass then
        local bt = buffClass:GetBuffTable()
        
        if buffRaidPosition >= 40 then buffRaidPosition = 1 end
        local initialTarget = UnitName("target")
        local isEnemy = UnitIsEnemy("player","target")
        ClearTarget()
        CastSpellByName(spell)
        
        for i=buffRaidPosition, 40 do
            local raidID = "raid"..i
            buffRaidPosition = i
            if bt[raidID] == false and UnitIsVisible(raidID) and SpellCanTargetUnit(raidID) then
                local _, class = UnitClass(raidID)
                local _, _, subgroup, _, _, _, _, online, isDead = GetRaidRosterInfo(i)
                if buffClass:IsGroup(subgroup) and buffClass:IsClass(class) then
                    self:Print(string.format("%s: %s", crayon:Silver(UnitName(raidID)), crayon:Orange(spell)))
                    SpellTargetUnit(raidID)
                    buffRaidPosition = i + 1
                    break
                end
            end
        end
        
        if SpellIsTargeting() then SpellStopCasting() end
        self:ReTarget(initialTarget, isEnemy)
    end
	SetCVar("autoSelfCast", selfCast)
end

function XRS:ReTarget(initialTarget, isEnemy)
    -- all that follows simply attempts to return back to original target
    if isEnemy then
        -- if a friendly wasn't targetted, we can return to them reliably
        TargetLastEnemy()
    elseif not initialTarget then
        -- if no initial target, clear target
        ClearTarget()
    else
        TargetByName(initialTarget)
        -- attempt to target initial target
        if UnitName("target")~=initialTarget then
            -- if attempt failed, scan through raid to target by raid unit
            for i=1,40 do
                if UnitName("raid"..i)==initialTarget then
                    TargetUnit("raid"..i)
                end
            end
            if UnitName("target")~=initialTarget then
                -- if we still failed, clear target. possible if a pet was out of range
                ClearTarget()
            end
        end
    end
end

function XRS:GetHintOption()
    return self.db.profile.ShowHint
end

function XRS:UpdateAfkBars()
    for _,v in ipairs(self.afk) do
        v:UpdateBar()
    end
end

function XRS:SetWidth()
	local width = self.db.profile.Width
	
	local barcount = table.getn(self.bars)
	local buffscount = math.ceil(table.getn(self.buffs) / math.floor(width/22))
	self.frame:SetHeight(30 + (barcount * 16) + ((buffscount)*22))
	
	for _,v in ipairs(self.bars) do
		v:SetWidth(width)
	end
	for _,v in ipairs(self.buffs) do
		v:SetWidth(width)
	end
	self.frame:SetWidth(width + 15)
end