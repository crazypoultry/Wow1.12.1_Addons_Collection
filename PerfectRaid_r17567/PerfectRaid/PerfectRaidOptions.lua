local L = AceLibrary("AceLocale-2.0"):new("PerfectRaid")

PerfectRaid.options = {
    type = "group",
    args = {
--[[
        simulate = {
            name = L["Raid Simulation"],
            type = "execute",
            desc = L["Raid Simulation"],
            func = function() PerfectRaid:Simulate() end,
        },
--]]
        config = {
            name = L["Config Options"],
            type = "execute",
            desc = L["Open Configuration UI"],
            func = function() PerfectRaid.dewdrop:Open(PerfectRaid.master) end,
        },
        columns = {
               name = L["Columns"],
               type = "range",
               desc = L["Set number of columns"],
               min = 1,
               max = 8,
		   step = 1,
               get = "OptionColumns",
               set = "OptionColumns",
         },
	   columnshift = {
		name = L["Shift Players"],
		type = "range",
		desc = L["Shift players between columns"],
		min = -2,
		max = 2,
		step = 1,
		get = "OptionColumnShift",
		set = "OptionColumnShift",
	   },
	   hoffset = {
		name = L["Horizontal Frame Alignment"],
		type = "range",
		desc = L["Change the horizontal offset between the columns"],
		get = "Optionhoffset",
		set = "Optionhoffset",
		min = -160,
		max = 160,
	   },
	   showinparty = {
		name = L["Show frames in party"],
		type = "toggle",
		desc = L["Toggle whether the frames are show while in a party"],
		get = "OptionShowInParty",
		set = "OptionShowInParty",
	   },
         filter = {
            name = L["Filter Debuffs"],
            type = "toggle",
            desc = L["Only show debuffs that you can cure"],
            get = "ToggleFilterDebuffs",
            set = "ToggleFilterDebuffs",
        },
         group = {
            name = L["Show Group Numbers"],
            type = "toggle",
            desc = L["Show Group Numbers"],
            get = "ToggleShowGroups",
            set = "ToggleShowGroups",
        },
         align = {
            name = L["Frame Alignment"],
            type = "toggle",
            desc = L["Horizontal aligmment of frames"],
            get = "ToggleAlignRight",
            set = "ToggleAlignRight",
            map = {[false] = L["Left"], [true] = L["Right"]},
            guiNameIsMap = true,
        },        
        valign = {
            name = L["Vertical Alignment"],
            type = "toggle",
            desc = L["Vertical Alignment of frames"],
            get = "ToggleAlignBottom",
            set = "ToggleAlignBottom",
            map = {[false] = L["Top"], [true] = L["Bottom"]},
            guiNameIsMap = true,
        },
        highlight = {
            name = L["Mouseover Highlighting"],
            type = "toggle",
            desc = L["Show/Hide the mouseover texture"],
            get = "ToggleHighlight",
            set = "ToggleHighlight",
        },
        tooltips = {
            name = L["Show tooltips"],
            type = "toggle",
            desc = L["Show/Hide mouseover tooltips"],
            get = "ToggleTooltips",
            set = "ToggleTooltips",
        },
        debuff = {
            name = L["Debuff Indicator"],
            type = "toggle",
            desc = L["Show/Hide the debuff texture"],
            get = "ToggleDebuffTexture",
            set = "ToggleDebuffTexture",
        },
        range = {
            name = L["Proximity detection"],
            type = "toggle",
            desc = L["Dim frames that are out of your range"],
            get = "ToggleRange",
            set = "ToggleRange",
        },
        truncate = {
            name = L["Name Truncation"],
            type = "toggle",
            desc = L["Truncate player names"],
            get = "ToggleTruncate",
            set = "ToggleTruncate",
        },
        scale = {
            name = L["Scale"],
            type = "range",
            desc = L["Set PerfectRaid's Scale"],
            min = 0.1,
            max = 3.0,
            step = 0.05,
            get = "OptionScale",
            set = "OptionScale",
        },
        separator = {
            name = L["Group Separator"],
            type = "range",
            desc = L["Set the height of the separator"],
            min = 0,
            max = 30,
            get = "OptionSeparator",
            set = "OptionSeparator",
        },
        lowmana = {
            name = L["Low Mana Threshold"],
            type = "range",
            desc = L["Sets the level which we show Low Mana"],
            min = 0,
            max = 100,
            get = "OptionLowMana",
            set = "OptionLowMana",
        },
        inverse = {
            name = L["Inverse Bars"],
            type = "toggle",
            desc = L["Show depletion bars"],
            get = "ToggleInverse",
            set = "ToggleInverse",
        },
        deficit = {
            name = L["Show Health Deficit"],
            type = "toggle",
            desc = L["Show health deficit"],
            get = "ToggleDeficit",
            set = "ToggleDeficit",
        },
        texture = {
            name = L["Bar Texture"],
            type = "text",
            desc = L["Change the status bar texture"],
            get = "OptionTexture",
            set = "OptionTexture",
            validate = {"default", "banto", "halcyone", "otravi", "perl", "smooth", "striped", "charcoal"},
        },
        lock = {
            name = L["Lock"],
            type = "toggle",
            desc = L["Lock/Unlock PerfectRaid"],
            get = "ToggleLocked",
            set = "ToggleLocked",
            map = {[false] = L["Unlocked"], [true] = L["Locked"]},
            guiNameIsMap = true,
        },
        sort = {
            name = L["Sort"],
            type = "text",
            desc = L["Sort the PerfectRaid frames"],
            set = "OptionSort",
            get = "OptionSort",
            usage = "{custom || name || class || group}",
        },
        manabars = {
            name = L["ManaBars"],
            type = "text",
            desc = L["Toggle mana bar overlays"],
            get = "ToggleManaBars",
            set = "ToggleManaBars",
            validate = {["off"] = L["off"], ["mana"] = L["mana"], ["all"] = L["all"]},
        },
        buff = {
            name = L["Buff"],
            type = "group",
            desc = L["Show/Hide some buffs"],
            args = {
                fort = {
                    name = L["Fortitude"],
                    type = "toggle",
                    desc = L["Show units who need Power Word:Fortitude"],
                    set = "ToggleFortitude",
                    get = "ToggleFortitude",
                },
                shadow = {
                    name = L["ShadowProtection"],
                    type = "toggle",
                    desc = L["Show units who need Shadow Protection"],
                    set = "ToggleShadowProtection",
                    get = "ToggleShadowProtection",
                },
                renew = {
                    name = L["Renew"],
                    type = "toggle",
                    desc = L["Show units who have Renew"],
                    set = "ToggleRenew",
                    get = "ToggleRenew",
                },
                rejuvenation = {
                    name = L["Rejuvenation"],
                    type = "toggle",
                    desc = L["Show units who have Rejuvenation"],
                    set = "ToggleRejuvenation",
                    get = "ToggleRejuvenation",
                },
                regrowth = {
                    name = L["Regrowth"],
                    type = "toggle",
                    desc = L["Show units who have Regrowth"],
                    set = "ToggleRegrowth",
                    get = "ToggleRegrowth",
                },
                spirit = {
                    name = L["Spirit"],
                    type = "toggle",
                    desc = L["Show units who need Divine Spirit"],
                    set = "ToggleSpirit",
                    get = "ToggleSpirit",
                },
                int = {
                    name = L["Intellect"],
                    type = "toggle",
                    desc = L["Show units who need Arcane Intellect"],
                    set = "ToggleIntellect",
                    get = "ToggleIntellect",
                },
                mark = {
                    name = L["Mark of the Wild"],
                    type = "toggle",
                    desc = L["Show units who need Mark of the Wild"],
                    set = "ToggleMarkOfWild",
                    get = "ToggleMarkOfWild",
                },
                might = {
                    name = L["Blessing of Might"],
                    type = "toggle",
                    desc = L["Show units who need Blessing of Might"],
                    set = "ToggleMight",
                    get = "ToggleMight",
                },
                wisdom = {
                    name = L["Blessing of Wisdom"],
                    type = "toggle",
                    desc = L["Show units who need Blessing of Wisdom"],
                    set = "ToggleWisdom",
                    get = "ToggleWisdom",
                },
                salv = {
                    name = L["Blessing of Salvation"],
                    type = "toggle",
                    desc = L["Show units who need Blessing of Salvation"],
                    set = "ToggleSalvation",
                    get = "ToggleSalvation",
                },
                light = {
                    name = L["Blessing of Light"],
                    type = "toggle",
                    desc = L["Show units who need Blessing of Light"],
                    set = "ToggleLight",
                    get = "ToggleLight",
                },
                sanc = {
                    name = L["Blessing of Sanctuary"],
                    type = "toggle",
                    desc = L["Show units who need Blessing of Sanctuary"],
                    set = "ToggleSanctuary",
                    get = "ToggleSanctuary",
                },
                kings = {
                    name = L["Blessing of Kings"],
                    type = "toggle",
                    desc = L["Show units who need Blessing of Kings"],
                    set = "ToggleKings",
                    get = "ToggleKings",
                },
            }
        }
    }
}

local function update_status()  
    for unit in pairs(PerfectRaid.visible) do
        PerfectRaid:UpdateStatus(unit)
    end
end

function PerfectRaid:ToggleAlignRight(value)
    if type(value) == "nil" then return self.opt.AlignRight end
    self.opt.AlignRight = value
    self:UpdateLayout()
end

function PerfectRaid:ToggleAlignBottom(value)
    if type(value) == "nil" then return self.opt.AlignBottom end
    self.opt.AlignBottom= value
    self:UpdateLayout()
end

function PerfectRaid:Optionhoffset(value)
    if not value then return self.opt.hOffset end
    self.opt.hOffset = value

    self:UpdateLayout()
end

function PerfectRaid:OptionColumnShift(value)
    if not value then return self.opt.ColumnShift end
    self.opt.ColumnShift = value
    PerfectRaid:UpdateLayout()
end

function PerfectRaid:ToggleHighlight(value)
    if type(value) == "nil" then return self.opt.Highlight end
    self.opt.Highlight = value
end

function PerfectRaid:ToggleTooltips(value)
    if type(value) == "nil" then return self.opt.Tooltips end
    self.opt.Tooltips = value
end

function PerfectRaid:ToggleDebuffTexture(value)
    if type(value) == "nil" then return self.opt.DebuffTexture end
    self.opt.DebuffTexture = value
    update_status()
end

function PerfectRaid:ToggleRange(value)
    if type(value) == "nil" then return self.opt.RangeCheck end
    self.opt.RangeCheck = value
    
    for unit in pairs(self.visible) do
        self.frames[unit]:SetAlpha(1.0)
    end
end

function PerfectRaid:ToggleTruncate(value)
    if type(value) == "nil" then return self.opt.Truncate end
    self.opt.Truncate = value
    self:UpdateLayout()
end

function PerfectRaid:ToggleShowGroups(value)
    if type(value) == "nil" then return self.opt.ShowGroups end
    self.opt.ShowGroups = value
    self:UpdateRoster()
end

function PerfectRaid:OptionScale(value)
    if not value then return self.opt.Scale end
    self.opt.Scale = value
    PerfectRaidFrame:SetScale(value)
    self:SavePosition()
end

function PerfectRaid:OptionSeparator(value)
    if not value then return self.opt.Separator end
    self.opt.Separator = value
    PerfectRaid:UpdateLayout()
end

function PerfectRaid:OptionLowMana(value)
    if not value then return self.opt.LowMana end
    self.opt.LowMana = value
    update_status()
end

function PerfectRaid:ToggleInverse(value)
    if type(value) == "nil" then return self.opt.Inverse end
    self.opt.Inverse = value
end

function PerfectRaid:ToggleDeficit(value)
    if type(value) == "nil" then return self.opt.Deficit end
    self.opt.Deficit = value
end

function PerfectRaid:OptionTexture(value)
    if not value then return self.opt.Texture end
    self.opt.Texture = self.textures[value]
    -- PerfectRaid:UpdateLayout()
    
    for k,v in pairs(self.frames) do
        v.Bar:SetStatusBarTexture(self.opt.Texture)
        v.MBar:SetStatusBarTexture(self.opt.Texture)
        self:UpdateUnit(k)
        self:UpdateMana(k)
    end
end

function PerfectRaid:ToggleLocked(value)
    if type(value) == "nil" then return self.opt.Locked end
    self.opt.Locked = value
end

function PerfectRaid:ToggleManaBars(value)
    if type(value) == "nil" then return self.opt.ManaBars end
    self.opt.ManaBars = value
    PerfectRaid:UpdateRoster()
end

function PerfectRaid:ToggleFilterDebuffs(value)
    if type(value) == "nil" then return self.opt.FilterDebuffs end
    self.opt.FilterDebuffs = value
    update_status()
end

-- Sort functions
local funcs = {
    ["WARRIOR"] = function(unit) local _,class = UnitClass(unit) return class == "WARRIOR" end,
    ["PRIEST"] = function(unit) local _,class = UnitClass(unit) return class == "PRIEST" end,
    ["SHAMAN"] = function(unit) local _,class = UnitClass(unit) return class == "SHAMAN" end,
    ["MAGE"] = function(unit) local _,class = UnitClass(unit) return class == "MAGE" end,
    ["HUNTER"] = function(unit) local _,class = UnitClass(unit) return class == "HUNTER" end,
    ["PALADIN"] = function(unit) local _,class = UnitClass(unit) return class == "PALADIN" end,
    ["ROGUE"] = function(unit) local _,class = UnitClass(unit) return class == "ROGUE" end,
    ["WARLOCK"] = function(unit) local _,class = UnitClass(unit) return class == "WARLOCK" end,
    ["DRUID"] = function(unit) local _,class = UnitClass(unit) return class == "DRUID" end,
    ["HEALER"] = function(unit) local _,class = UnitClass(unit) return class == "DRUID" or class == "PRIEST" or class == "PALADIN" or class == "SHAMAN" end,
    ["MELEE"] = function(unit) local _,class = UnitClass(unit) return class == "ROGUE" or class == "WARRIOR" end,
    ["RANGEDDPS"] = function(unit) local _,class = UnitClass(unit) return class == "MAGE" or class == "WARLOCK" or class == "HUNTER" end,
    ["MYGROUP"] = function(unit) return PerfectRaid.frames[unit].group == PerfectRaid.mygroup end,
    ["1"] = function(unit) return PerfectRaid.frames[unit].group == 1 end,
    ["2"] = function(unit) return PerfectRaid.frames[unit].group == 2 end,
    ["3"] = function(unit) return PerfectRaid.frames[unit].group == 3 end,
    ["4"] = function(unit) return PerfectRaid.frames[unit].group == 4 end,
    ["5"] = function(unit) return PerfectRaid.frames[unit].group == 5 end,
    ["6"] = function(unit) return PerfectRaid.frames[unit].group == 6 end,
    ["7"] = function(unit) return PerfectRaid.frames[unit].group == 7 end,
    ["8"] = function(unit) return PerfectRaid.frames[unit].group == 8 end,
    ["ODD"] = function(unit) return math.mod(PerfectRaid.frames[unit].group, 2) == 1 end,
    ["EVEN"] = function(unit) return math.mod(PerfectRaid.frames[unit].group, 2) == 0 end,
    ["MYSIDE"] = function(unit) return math.mod(PerfectRaid.frames[unit].group, 2) == math.mod(PerfectRaid.mygroup, 2) end,
    ["ALL"] = function(unit) return true end,
	["MAINTANK"] = function(unit) 
		local tank = MRCTRA
        local name = UnitName(unit)
		if oRA then 
			tank = oRA.maintanktable
		end
        for k,v in pairs(tank) do
            if v == name then return true end
        end
	end,
}

local validSort = {CUSTOM = true, GROUP = true, NAME = true, CLASS = true}

function PerfectRaid:OptionSort(value)
    if not value then return self.opt.Sort end

    value = string.upper(value)   
    local s,e,type = string.find(value, "^([^%s]+)")
    local sort = {}
    
    if not validSort[type] then
        local usage = "|cffffff7fUsage|r: /praid sort {custom | group | name | class}"
        self:Print(usage)
        return
    end
    
    if type == "CUSTOM" then
        for token in string.gfind(string.sub(value, e + 1), "[^%s]+") do
            if funcs[token] then
                table.insert(sort, funcs[token])
            end
        end
        
        if not next(sort) then
            -- We didn't get any valid options here)
            
            local s = {}
            for k,v in pairs(funcs) do table.insert(s, k) end
            table.sort(s)
            
            local output = ""
            for k,v in ipairs(s) do
                output = string.format("%s%s | ", output, v)
            end
            
            output = string.lower(string.sub(output, 1, -3))
            self:Print("Valid sort options for CUSTOM are:")
            self:Print(output)
            return
        end        
        -- Make everyone else show up afterwards
        
        -- Export this back to PR core
        self.sortfunctions = sort
    elseif type == "NAME" then
        self.sortfunctions = {function() return true end}
    elseif type == "GROUP" then
        for i=1,8 do
            table.insert(sort, funcs[tostring(i)])
        end
        self.sortfunctions = sort
    elseif type == "CLASS" then
        self.sortfunctions = {funcs.WARRIOR, funcs.PRIEST, funcs.DRUID, funcs.PALADIN, funcs.ROGUE, funcs.SHAMAN, funcs.WARLOCK, funcs.MAGE, funcs.HUNTER}
    end

    self.opt.Sort = value
    table.insert(sort, funcs.ALL)
    
    self:Sort()
    self:UpdateLayout()
end

function PerfectRaid:OptionShowInParty(value)
    if type(value) == "nil" then return self.opt.ShowInParty end

    --self:Print("ShowInParty: %s", value)

    self.opt.ShowInParty = value

    if(self.opt.ShowInParty) then HidePartyFrame() else ShowPartyFrame() end

    self:UpdateRoster()
end

function PerfectRaid:ToggleBuff(buff, value)
    if type(value) == "nil" then return self.opt.Buffs[buff] end
    self.opt.Buffs[buff] = value
    update_status()
end

function PerfectRaid:OptionColumns(value)
    if not value then return self.opt.Columns end
    self.opt.Columns = value
    self:UpdateLayout()
end

function PerfectRaid:ToggleFortitude(v) return self:ToggleBuff("Fortitude", v) end
function PerfectRaid:ToggleShadowProtection(v) return self:ToggleBuff("ShadowProtection", v) end
function PerfectRaid:ToggleRenew(v) return self:ToggleBuff("Renew", v) end
function PerfectRaid:ToggleRejuvenation(v) return self:ToggleBuff("Rejuvenation", v) end
function PerfectRaid:ToggleRegrowth(v) return self:ToggleBuff("Regrowth", v) end
function PerfectRaid:ToggleSpirit(v) return self:ToggleBuff("Spirit", v) end
function PerfectRaid:ToggleIntellect(v) return self:ToggleBuff("Intellect", v) end
function PerfectRaid:ToggleMarkOfWild(v) return self:ToggleBuff("MarkOfWild", v) end
function PerfectRaid:ToggleMight(v) return self:ToggleBuff("BoMight", v) end
function PerfectRaid:ToggleWisdom(v) return self:ToggleBuff("BoWisdom", v) end
function PerfectRaid:ToggleSalvation(v) return self:ToggleBuff("BoSalvation", v) end
function PerfectRaid:ToggleLight(v) return self:ToggleBuff("BoLight", v) end
function PerfectRaid:ToggleSanctuary(v) return self:ToggleBuff("BoSanctuary", v) end
function PerfectRaid:ToggleKings(v) return self:ToggleBuff("BoKings", v) end