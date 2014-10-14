----------------------------
--      Declaration       --
----------------------------

GotWood = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0", "AceDebug-2.0")
local BS = AceLibrary("Babble-Spell-2.0")
local dewdrop = AceLibrary("Dewdrop-2.0")
local deformat = AceLibrary("Deformat-2.0")

----------------------------
--      Main Functions    --
----------------------------

function GotWood:OnInitialize()
    -- Debugging state
    self:SetDebugging(false)
    
    -- Command structure
    self.options = {
        type="group",
        args = {
            lock = {
                name = "Lock", type = "toggle",
                desc = "Lock the frame",
                get = function() return self.db.profile.Locked end,
                set = function(v)
                    self:SetLocked(v)
                end,
                order = 1
            },
            scale = {
                name = "Scale", type = "range",
                desc = "Scale the frame",
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
            view = {
                name = "Select view", type = 'text',
                desc = "Select a bar or button view",
                get = function()
                    return self.db.profile.View
                end,
                set = function(name)
                    self:SetView(name)
                end,
                validate = {["candy"] = "Candy Bar", ["buttons"] = "Standard Buttons"},
                order = 3,
            },
            order = {
                name = "Order", type = "group",
                desc = "The order of the totems",
                args = {
                },
                order = 4,
            },
			removeondeath = {
				name = "Remove Timer on Death", type = "toggle",
				desc = "Remove all timers if the player dies",
				get = function() return self.db.profile.RemoveOnDeath end,
				set = function(v)
					self.db.profile.RemoveOnDeath = v
				end,
				order = 5
			},
        }
    }
    
    self.defaults = {
        Locked = false,
        View = "candy",
        Scale = 1.0,
		RemoveOnDeath = true,
        
        totemorder = {"air","water","earth","fire"}
    }
    
    self.formatStrings = {
        SPELLLOGCRITOTHEROTHER,
        SPELLLOGCRITSCHOOLOTHEROTHER,
        SPELLLOGOTHEROTHER,
        SPELLLOGSCHOOLOTHEROTHER,
        COMBATHITCRITOTHEROTHER,
        COMBATHITOTHEROTHER,
    }
    
    -- Register everything
    self:RegisterDB("GotWoodDB")
    self:RegisterDefaults('profile', self.defaults )
    self:FillOrder()
    self:RegisterChatCommand({"/gotwood","/gw"}, self.options )
end

function GotWood:OnEnable()
    self:InitFrame()
    if self.db.profile.View == "buttons" then
        self:InitButtons()
    elseif self.db.profile.View == "candy" then
        self:InitCandyBars()
    end
    self:UpdateScale()
    
    dewdrop:Register(self.frame,
                    'children', function()
                        dewdrop:FeedAceOptionsTable(self.options)
                    end
                    )
    
    self:RegisterEvent("SpellStatus_SpellCastInstant")
    -- Watch for damage done to our totems
    self:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE", "TotemDamage")
    self:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS", "TotemDamage")
    self:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE", "TotemDamage")
    self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS", "TotemDamage")
	
	-- Event when the player dies
	self:RegisterEvent("PLAYER_DEAD")
end

function GotWood:OnDisable()    
    for _,v in ipairs(self.db.profile.totemorder) do
        self[v]:Delete()
    end
    
    self.frame:Hide()
    self.gwfs = nil
    self.frame = nil
end

function GotWood:InitFrame()
    self.frame = CreateFrame("Frame", "GotWoodFrame", UIParent)
    self.frame:Hide()
    self.frame:EnableMouse(true)
    self.frame:SetFrameStrata("MEDIUM")
    self.frame:SetMovable(true)
    
    local view = self.db.profile.View
    if view == "buttons" then
        self.frame:SetWidth(155)
        self.frame:SetHeight(65)
    elseif view == "candy" then
        self.frame:SetWidth(236)
        self.frame:SetHeight(95)
    end
    -- Create Font String
    self.gwfs = self.frame:CreateFontString("$parentTitle","ARTWORK","GameFontNormal")
    self.gwfs:SetText("GotWood?")
	self.gwfs:SetFont("Fonts\\skurri.ttf", 20, "THICKOUTLINE")
	self.gwfs:ClearAllPoints()
	self.gwfs:SetTextColor(0.6,0.2,0.1,1)
	self.gwfs:SetWidth(200)
	self.gwfs:SetHeight(25)
	self.gwfs:SetJustifyH("CENTER")
	self.gwfs:SetJustifyV("MIDDLE")
	self.gwfs:SetPoint("TOP",0,10)
	self.gwfs:Show()
    -- Backdrop options
	self.texture = self.frame:CreateTexture("$parentWood","BACKGROUND")
	self.texture:SetAllPoints(self.frame)
	self.texture:SetTexture("Interface\\Addons\\GotWood\\images\\wood.tga")
	self.texture:Show()
	
    self.frame:ClearAllPoints()
    self.frame:SetPoint("CENTER", WorldFrame, "CENTER", 0, 0)
    self.frame:SetScript("OnMouseDown",function()
        if ( arg1 == "LeftButton" ) then
            this:StartMoving()
        end
    end)
    self.frame:SetScript("OnMouseUp",function()
        if ( arg1 == "LeftButton" ) then
            this:StopMovingOrSizing()
            self:SavePosition()
        end
    end)
    self.frame:SetScript("OnHide",function() this:StopMovingOrSizing() end)
    
    -- Frame cannot be dragged off the screen
    self.frame:SetClampedToScreen(true)
    
    -- Loads the position of the frame
    self:LoadPosition()
    
    if not self.db.profile.Locked then
        self.frame:Show()
    end
end

function GotWood:InitButtons()
    for k,v in ipairs(self.db.profile.totemorder) do
        self[v] = self.button:new(k, v)
    end
    self:Debug("Buttons initialized")
end

function GotWood:InitCandyBars()
    for k,v in ipairs(self.db.profile.totemorder) do
        self[v] = self.bar:new(k, v)
    end
    self:Debug("CandyBars initialized")
end

function GotWood:SpellStatus_SpellCastInstant(sId, sName, sRank, sFullName, sCastTime)
    if GotWoodData[sName] then
        local rank
        if sRank and sRank ~= "" then
            rank = tonumber(string.sub(sRank, string.find(sRank, "%d")))
        end
        local ele = GotWoodData[sName].ele
        if BS:GetSpellIcon(sName) then
            self[ele]:SetTexture(BS:GetSpellIcon(sName))
        elseif GotWoodData[sName].icon then
            self[ele]:SetTexture(GotWoodData[sName].icon)
        end
        
        if rank and GotWoodData[sName][rank] then
            self[ele]:SetTime(GotWoodData[sName][rank].duration)
        else
            self[ele]:SetTime(GotWoodData[sName].duration)
        end
        self[ele]:SetLife(GotWoodData[sName].life)
		self[ele]:SetOnClick(sFullName)
        self[ele]:Start(sName, rank)
    end
end

function GotWood:PLAYER_DEAD()
	if not self.db.profile.RemoveOnDeath then return end
	
	for _,v in ipairs(self.db.profile.totemorder) do
		self[v]:Stop()
	end
end

function GotWood:SavePosition()
    local scale = self.frame:GetEffectiveScale()
    local worldscale = UIParent:GetEffectiveScale()
    
    local x,y = self.frame:GetLeft()*scale,self.frame:GetTop()*scale - (UIParent:GetTop())*worldscale

    if not self.db.profile.Position then 
        self.db.profile.Position = {}
    end
    
    self.db.profile.Position.x = x
    self.db.profile.Position.y = y
end

function GotWood:LoadPosition()
    if(self.db.profile.Position) then
        local x = self.db.profile.Position.x
        local y = self.db.profile.Position.y
        local scale = self.frame:GetEffectiveScale()

        self.frame:SetPoint("TOPLEFT", UIParent,"TOPLEFT", x/scale, y/scale)
    else
        self.frame:SetPoint("CENTER", UIParent, "CENTER")
    end
end

function GotWood:SetLocked(lock)
    self.db.profile.Locked = lock
    if lock then
        self.frame:Hide()
    else
        self.frame:Show()
    end
end

function GotWood:SetView(view)
    self:Debug(view)
    self.db.profile.View = view
    
    local temp = {}
    
    for k,v in ipairs(self.db.profile.totemorder) do
        table.insert(temp, {self[v]:GetRestTime(), self[v]:GetName()})
        self[v]:Delete()
    end
    
    if view == "buttons" then
        self.frame:SetWidth(155)
        self.frame:SetHeight(65)
        
        self:InitButtons()
    elseif view == "candy" then
        self.frame:SetWidth(236)
        self.frame:SetHeight(95)
        
        self:InitCandyBars()
    end
    
    for k,v in ipairs(self.db.profile.totemorder) do
        self[v]:StartFromSwitch(temp[k][1], temp[k][2])
    end
end

function GotWood:FillOrder()
    local order = self.options.args.order.args
    for k,v in ipairs(self.db.profile.totemorder) do
        local num = k
        local string_num = tostring(k)
        local name = v
        
        order[string_num] = {}
        order[string_num].name = name
        order[string_num].type = 'text'
        order[string_num].desc = "Change order of type " .. name .. "."
        order[string_num].get = function() return string_num end
        order[string_num].set = function(num_new) self:ChangeOrder(num, num_new)end
        order[string_num].validate = {"1","2","3","4"}
        order[string_num].order = num
    end
end

function GotWood:ChangeOrder(old, new)
    local ele = self.db.profile.totemorder[old]
    
    table.remove(self.db.profile.totemorder, old)
    table.insert(self.db.profile.totemorder, new, ele)
    
    self:FillOrder()
    self:UpdateTotemPosition()
    dewdrop:Close(3)
    dewdrop:Refresh(2)
end

function GotWood:UpdateTotemPosition()
    for k,v in ipairs(self.db.profile.totemorder) do
        self[v]:SetPosition(k)
    end
end

function GotWood:TotemDamage(msg)
    if not string.find(string.lower(msg), "totem") then return end
    local totem, dmg
    for _,v in ipairs(self.formatStrings) do
        local arg1, arg2, arg3, arg4 = deformat(msg, v)
        if arg4 and type(arg4)=='number' then
            totem, dmg = arg3, arg4
            break
        elseif arg2 and type(arg3)=='number' then
            totem, dmg = arg2, arg3
            break
        end
    end
    
    if totem and dmg then
        for _,v in ipairs(self.db.profile.totemorder) do
            if self[v]:GetName() and string.find(string.lower(totem), string.lower(self[v]:GetName())) then
                self[v]:SetTotemDamage(dmg)
                break
            end
        end
    end
end

function GotWood:UpdateScale()
    if self.frame then
        self.frame:SetScale(self.db.profile.Scale)
		for _,v in ipairs(self.db.profile.totemorder) do
			self[v]:SetScale(self.db.profile.Scale)
		end
        self:LoadPosition()
    end
end

function GotWood:GetPreviousBar(position)
	local ele = self.db.profile.totemorder[position]
	return self[ele]:GetFrame()
end