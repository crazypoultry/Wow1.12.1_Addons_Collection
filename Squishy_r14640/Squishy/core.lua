local vmajor,vminor = "1.0", tonumber(string.sub("$Revision: 14581 $", 12, -3))

--[[---------------------------------------------------------------------------------
 locals
------------------------------------------------------------------------------------]]

local dirty                   = {}
local priorityIndex           = {}  -- this table references name to index of the priority table
local frameNumByName          = {}
local frameNumByNameProcessed = {}
local frameByNum              = {}
local frameByNumProcessed     = {}
local queryData               = {}
local blacklist               = {}
local lastAggroAlert          = 0
local maxPct
local playerName
local playerClass
local isInBattleground
local AceTab            = AceLibrary("AceTab-2.0")
local Compost           = AceLibrary("Compost-2.0")
local L                 = AceLibrary("AceLocale-2.2"):new("Squishy")
local BS                = AceLibrary("Babble-Spell-2.2")
local RL                = AceLibrary("RosterLib-2.0")
local aura              = AceLibrary("SpecialEvents-Aura-2.0")
local proximity         = ProximityLib:GetInstance("1")
local roster            = RL.roster

local watchSpells = {
	[BS["Holy Light"]] = true,
	[BS["Flash of Light"]] = true,
	[BS["Flash Heal"]] = true,
	[BS["Greater Heal"]] = true,
	[BS["Heal"]] = true,
	[BS["Healing Touch"]] = true,
	[BS["Lesser Healing Wave"]] = true,
	[BS["Healing Wave"]] = true,
	[BS["Regrowth"]] = true,
	[BS["Prayer of Healing"]] = true,
}

local PoH              = BS["Prayer of Healing"]
local castMessage      = L["(.+) begins to cast (.+)."]
local tapMessage       = L["(.+) gains (.+) Mana from (.+)'s Life Tap."]

local buffs = {
	[BS["Renew"]] = true,
	[BS["Rejuvenation"]] = true,
	[BS["Power Word: Shield"]] = true,
	[BS["Improved Power Word: Shield"]] = true
}

local debuffs = {
	[L["Mortal Strike"]] = true,           -- -50% healing
	[L["Mortal Cleave"]] = true,           -- -50% healing
	[L["Gehennas\' Curse"]] = true,        -- -75% healing
	[L["Curse of the Deadwood"]] = true,   -- -50% healing
	[L["Blood Fury"]] = true,              -- -50% healing
	[L["Brood Affliction: Green"]] = true, -- -50% healing
	[L["Necrotic Poison"]] = true,         -- -90% healing
	[L["Conflagration"]] = true,           -- 3000 dmg over 10sec
}

local skip = {
	[BS["Prowl"]] = true,
	[BS["Shadowmeld"]] = true,
	[BS["Stealth"]] = true,
	[L["Petrification"]] = true            -- not in Babble-Spell!
}

BINDING_HEADER_SQUISHY              = "Squishy"
BINDING_NAME_TARGET_PRIORITY1       = L["Target unit with highest priority"]
BINDING_NAME_TARGET_PRIORITY2       = L["Target unit with 2nd highest priority"]
BINDING_NAME_TARGET_PRIORITY3       = L["Target unit with 3rd highest priority"]

local classModifiers = {
	["PRIEST"]   = { ["WARRIOR"] = 05, ["MAGE"] = 00, ["PRIEST"] = 10, ["DRUID"] = 15, ["SHAMAN"] = 20, ["PALADIN"] = 20, ["WARLOCK"] = 25, ["HUNTER"] = 15, ["ROGUE"] = 15, ["PET"] = 60 },
	["SHAMAN"]   = { ["WARRIOR"] = 05, ["MAGE"] = 00, ["PRIEST"] = 10, ["DRUID"] = 05, ["SHAMAN"] = 15, ["PALADIN"] = 15, ["WARLOCK"] = 15, ["HUNTER"] = 10, ["ROGUE"] = 10, ["PET"] = 60 },
	["PALADIN"]  = { ["WARRIOR"] = 05, ["MAGE"] = 00, ["PRIEST"] = 10, ["DRUID"] = 05, ["SHAMAN"] = 15, ["PALADIN"] = 15, ["WARLOCK"] = 15, ["HUNTER"] = 10, ["ROGUE"] = 10, ["PET"] = 60 },
	["DRUID"]    = { ["WARRIOR"] = 10, ["MAGE"] = 10, ["PRIEST"] = 15, ["DRUID"] = 10, ["SHAMAN"] = 05, ["PALADIN"] = 05, ["WARLOCK"] = 00, ["HUNTER"] = 15, ["ROGUE"] = 05, ["PET"] = 60 },
	-- non-healers don't set specific priorities:
	["WARRIOR"]  = { ["WARRIOR"] = 00, ["MAGE"] = 00, ["PRIEST"] = 00, ["DRUID"] = 00, ["SHAMAN"] = 00, ["PALADIN"] = 00, ["WARLOCK"] = 00, ["HUNTER"] = 00, ["ROGUE"] = 00, ["PET"] = 60 },
	["MAGE"]     = { ["WARRIOR"] = 00, ["MAGE"] = 00, ["PRIEST"] = 00, ["DRUID"] = 00, ["SHAMAN"] = 00, ["PALADIN"] = 00, ["WARLOCK"] = 00, ["HUNTER"] = 00, ["ROGUE"] = 00, ["PET"] = 60 },
	["WARLOCK"]  = { ["WARRIOR"] = 00, ["MAGE"] = 00, ["PRIEST"] = 00, ["DRUID"] = 00, ["SHAMAN"] = 00, ["PALADIN"] = 00, ["WARLOCK"] = 00, ["HUNTER"] = 00, ["ROGUE"] = 00, ["PET"] = 60 },
	["HUNTER"]   = { ["WARRIOR"] = 00, ["MAGE"] = 00, ["PRIEST"] = 00, ["DRUID"] = 00, ["SHAMAN"] = 00, ["PALADIN"] = 00, ["WARLOCK"] = 00, ["HUNTER"] = 00, ["ROGUE"] = 00, ["PET"] = 60 },
	["ROGUE"]    = { ["WARRIOR"] = 00, ["MAGE"] = 00, ["PRIEST"] = 00, ["DRUID"] = 00, ["SHAMAN"] = 00, ["PALADIN"] = 00, ["WARLOCK"] = 00, ["HUNTER"] = 00, ["ROGUE"] = 00, ["PET"] = 60 }
}


--[[---------------------------------------------------------------------------------
 defaults and AceOptions table
------------------------------------------------------------------------------------]]

local defaults = {
	MaxPct = 85,
	AudioAggro = true,
	ScaleSize = 1,
	FrameLock = false,
	PetSupport = true,
	HealthDeficit = true,
	NumUnits = 10,
	Alpha = 1,
	FrameDisplay = L["always"],
	BarTexture = L["Default"],
	FrameTitleOn = true,
	FrameBorderOn = true,
	BarWidth = 60,
	BarHeight = 12,
	BarSpacing = 2,
	BarStyle = "Health",
	NamePositionInside = false,
	DisplayClassColor = true,
	-- no GUI options yet:	
}

local options = {
	type = 'group',
	args = {
		frame = {
			type = 'group',
			name = L["Frame options"],
			desc = L["Frame options"],
			order = 100,
			args = {
				display = {
					type = 'text',
					name = L["Show Frame"],
					desc = L["Sets when the Squishy frame is visible: Choose 'always' or 'grouped'."],
					get = function() return Squishy.db.profile.FrameDisplay end,
					set = function(v)
						Squishy.db.profile.FrameDisplay = v
						Squishy:CheckVisibility()
					end,
					validate = {L["always"], L["grouped"]},
					order = 110
				},
				scale = {
					type = 'range',
					name = L["Scale"],
					desc = L["Scales the Emergency Monitor."],
					get = function() return Squishy.db.profile.ScaleSize end,
					set = function(v) 
						Squishy.db.profile.ScaleSize = v
						Squishy:Scale()
					end,
					min = 0.4,
					max = 1.5,
					step = 0.05,
					isPercent = true,
					order = 120
				},
				alpha = {
					type = 'range',
					name = L["Alpha"],
					desc = L["Changes background+border visibility"],
					get = function() return Squishy.db.profile.Alpha end,
					set = function(v) 
						Squishy.db.profile.Alpha = v
						Squishy.frames.bg:SetAlpha(v)
						Squishy.frames.header:SetAlpha(v)
					end,
					min = 0,
					max = 1,
					step = 0.05,
					isPercent = true,
					order = 130
				},
				border = {
					type = 'toggle',
					name = L["Show Border"],
					desc = L["Shows/hides the frame border."],
					get = function() return Squishy.db.profile.FrameBorderOn end,
					set = function()
						Squishy.db.profile.FrameBorderOn = not Squishy.db.profile.FrameBorderOn
						Squishy:UpdateFrame()
					end,
					order = 140
				},
				header = {
					type = 'toggle',
					name = L["Show Header"],
					desc = L["Shows/hides the frame header."],
					get = function() return Squishy.db.profile.FrameTitleOn end,
					set = function()
						Squishy.db.profile.FrameTitleOn = not Squishy.db.profile.FrameTitleOn
						Squishy:UpdateFrame()
					end,
					order = 150
				},
				lock = {
					type = 'toggle',
					name = L["Frame lock"],
					desc = L["Locks/unlocks the emergency monitor."],
					get = function() return Squishy.db.profile.FrameLock end,
					set = function()
						Squishy.db.profile.FrameLock = not Squishy.db.profile.FrameLock
						Squishy:ApplySettings()
					end,
					order = 160
				},
			}
		},
		unit = {
			type = 'group',
			name = L["Unit options"],
			desc = L["Unit options"],
			order = 200,
			args = {
				max = {
					type = 'range',
					name = L["Number of units"],
					desc = L["Number of max visible units."],
					get = function() return Squishy.db.profile.NumUnits end,
					set = function(v) 
						Squishy.db.profile.NumUnits = v
						Squishy.NumUnits = v
						Squishy:UpdateFrameSize(v)
						Squishy:UpdateBars()
--						Squishy:ApplySettings()
					end,
					min = 1,
					max = 20,
					step = 1,
					isPercent = false,
					order = 210
				},
				style = {
					type = 'text',
					name = L["Style"],
					desc = L["Color bar either by health, class or use the CTRA style."],
					get = function() return Squishy.db.profile.BarStyle end,
					set = function(v)
						Squishy.db.profile.BarStyle = v
						Squishy:UpdateBars()
					end,
					validate = {L["Health"], L["Class"], L["CTRA"]},
					order = 220
				},
				texture = {
					type = 'text',
					name = L["Texture"],
					desc = L["Sets the bar texture. Choose 'Default', 'BantoBar', 'Button', 'Charcoal', 'Otravi', 'Perl', 'Smooth' or 'Smudge'."],
					get = function() return Squishy.db.profile.BarTexture end,
					set = function(v)
						Squishy:SetBarTexture(v)
						Squishy:UpdateBars()
					end,
					validate = { L["Default"],L["Charcoal"],L["Button"],L["BantoBar"],
								L["Perl"], L["Otravi"],L["Smooth"],L["Smudge"] },
					order = 230
				},
				deficit = {
					type = 'toggle',
					name = L["Health deficit"],
					desc = L["Toggles the display of health deficit in the emergency frame."],
					get = function() return Squishy.db.profile.HealthDeficit end,
					set = function() 
						Squishy.db.profile.HealthDeficit = not Squishy.db.profile.HealthDeficit
						Squishy:ApplySettings()
					end,
					order = 240
				},
				height = {
					type = 'range',
					name = L["Unit bar height"],
					desc = L["Unit bar height"],
					get = function() return Squishy.db.profile.BarHeight end,
					set = function(v) 
						Squishy.db.profile.BarHeight = v
						Squishy:UpdateBars()
						Squishy:UpdateFrame()
					end,
					min = 10,
					max = 20,
					step = 1,
					isPercent = false,
					order = 250
				},
				width = {
					type = 'range',
					name = L["Unit bar width"],
					desc = L["Unit bar width"],
					get = function() return Squishy.db.profile.BarWidth end,
					set = function(v) 
						Squishy.db.profile.BarWidth = v
						Squishy:UpdateBars()
						Squishy:UpdateFrame()
					end,
					min = 50,
					max = 150,
					step = 5,
					isPercent = false,
					order = 260
				},
				spacing = {
					type = 'range',
					name = L["Bar Spacing"],
					desc = L["Change the spacing between bars"],
					get  = function(v) return Squishy.db.profile.BarSpacing end,
					set  = function(v) 
						Squishy.db.profile.BarSpacing = v 
						Squishy:UpdateFrame() 
						Squishy:UpdateBars() 
					end,
					min  = 0,
					max  = 12,
					step = 1,
					isPercent = false,
					order= 265,
				},
				namePosition = {
					type = 'toggle',
					name = L["Name position inside bar"],
					desc = L["Show name position inside bar"],
					get = function() return Squishy.db.profile.NamePositionInside end,
					set = function() 
						Squishy.db.profile.NamePositionInside = not Squishy.db.profile.NamePositionInside
						Squishy:UpdateFrame()
						Squishy:UpdateBars()
					end,
					order = 270
				},
				classColorNames = {
					type = 'toggle',
					name = L["Class colored name"],
					desc = L["Color names by class"],
					get  = function(v) return Squishy.db.profile.DisplayClassColor end,
					set  = function(v) Squishy.db.profile.DisplayClassColor = not Squishy.db.profile.DisplayClassColor end,
					order= 280,
				},
			},
		},
		class = {
			type = 'group',
			name = L["Class options"],
			desc = L["Class options"],
			order = 300,
			args = {
				pets = {
					type = 'toggle',
					name = L["Pet support"],
					desc = L["Toggles the display of pets in the emergency frame."],
					get = function() return Squishy.db.profile.PetSupport end,
					set = function() 
						Squishy.db.profile.PetSupport = not Squishy.db.profile.PetSupport
						Squishy:ApplySettings()
					end,
					order = 301
				},
			}
		},
		various = {
			type = 'group',
			name = L["Various options"],
			desc = L["Various options"],
			order = 400,
			args = {
				aggro = {
					type = 'toggle',
					name = L["Audio alert on aggro"],
					desc = L["Toggle on/off audio alert on aggro."],
					get = function() return Squishy.db.profile.AudioAggro end,
					set = function()
						Squishy.db.profile.AudioAggro = not Squishy.db.profile.AudioAggro
						Squishy:ApplySettings()
					end,
					order = 401
				},
				logrange = {
					type = 'range',
					name = L["Log range"],
					desc = L["Changes combat log range. Set it to your max healing range"],
					get = function() return GetCVar("CombatLogRangeFriendlyPlayers") end,
					set = function(v) 
						SetCVar("CombatLogRangeParty", v)
						SetCVar("CombatLogRangePartyPet", v)
						SetCVar("CombatLogRangeFriendlyPlayers", v)
						SetCVar("CombatLogRangeFriendlyPlayersPets", v)
						SetCVar("CombatLogRangeCreature", v)
					end,
					min = 30,
					max = 50,
					step = 2,
					isPercent = false,
					order = 402
				},
				version = {
					type = 'execute',
					name = L["Version Query"],
					desc = L["Checks the group for Squishy users and prints their version data."],
					func = function()
						Squishy:VersionQuery()
					end,
					order = 403,
				},
			}
		}
	}
}


--[[---------------------------------------------------------------------------------
 Initialization
------------------------------------------------------------------------------------]]


Squishy = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0", "AceHook-2.1", "AceDebug-2.0", "FuBarPlugin-2.0", "AceComm-2.0")

Squishy.name                   = "Squishy"
Squishy.hasIcon                = true
Squishy.defaultMinimapPosition = 180
Squishy.cannotDetachTooltip    = true
Squishy.independentProfile     = true
Squishy.defaultPosition        = "LEFT"
Squishy.hideWithoutStandby     = true


function Squishy:OnInitialize()
	self:RegisterDB("SquishyDB")
	self:RegisterDefaults('profile', defaults )
	self:RegisterChatCommand({'/squishy','/sq'}, options )
	self.priority = Compost:Acquire()  -- this table will hold subtables containing name and health for each unit in our roster
	self:SetCommPrefix("Squishy")
	self.OnMenuRequest = options
	if not FuBar then
		self.OnMenuRequest.args.hide.guiName = L["Hide minimap icon"]
		self.OnMenuRequest.args.hide.desc = L["Hide minimap icon"]
	end
end


function Squishy:OnEnable()
	_, playerClass = UnitClass("player")
	playerName = UnitName("player")
	if not self.tooltip then
        self.tooltip = CreateFrame("GameTooltip", "Squishy_Tooltip", UIParent, "GameTooltipTemplate")
        self.tooltip:SetScript("OnLoad",function() this:SetOwner(WorldFrame, "ANCHOR_NONE") end)
    end
--	self.showFrame = false
	-- enable click-casting for various mods
	if IsAddOnLoaded("CastPartyCore") then
		SquishyCustomClick = CastParty_OnClickByUnit
	elseif IsAddOnLoaded("JustClick") then
		SquishyCustomClick = JC_OnClick
	end
	-- find healing spells being cast to send to others
	self:Hook("CastSpell")
	self:Hook("CastSpellByName")
	self:Hook("UseAction")
	self:Hook("SpellTargetUnit")
	self:Hook("SpellStopTargeting")
	self:Hook("TargetUnit")
	self:HookScript(WorldFrame,"OnMouseDown","SquishyOnMouseDown")
	-- register events we need
	self:RegisterEvent("RosterLib_RosterChanged")
	self:RegisterEvent("SPELLCAST_START")
	self:RegisterEvent("SPELLCAST_STOP")
	self:RegisterEvent("CHAT_MSG_COMBAT_FRIENDLY_DEATH")
	self:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF","SomeoneIsHealing")
	self:RegisterEvent("CHAT_MSG_SPELL_PARTY_BUFF","SomeoneIsHealing")
	self:RegisterEvent("UI_ERROR_MESSAGE")
	self:RegisterEvent("Banzai_PlayerGainedAggro")
	self:RegisterBucketEvent("UNIT_HEALTH", 0.2)
	self:ScheduleRepeatingEvent("UpdateBlacklist", self.UpdateBlacklist, 1, self)
	-- we need to save debugging state over sessions :(
	self.debugging = self:IsDebugging()
	-- AceComm
	self:RegisterComm(self.commPrefix, "GROUP", "OnCommReceive")
	-- we're nearly done
	self:ApplySettings()
--	if not self:IsActive() then return end
	if not self.frames then
		self:BuildDisplay()
	end
	self:CheckVisibility()
end


function Squishy:OnDisable()
	self:HideGUI()
	self:CancelScheduledEvent("UpdateBlacklist")
end


function Squishy:IsDebugging() 
	return self.db.profile.debugging
end


function Squishy:SetDebugging(debugging)
	self.db.profile.debugging = debugging
	self.debugging = debugging
end

--[[---------------------------------------------------------------------------------
 Options
------------------------------------------------------------------------------------]]

function Squishy:ApplySettings()
	maxPct                       = Squishy.db.profile.MaxPct
	self.OptionHealthDeficit     = Squishy.db.profile.HealthDeficit
end


--[[---------------------------------------------------------------------------------
 Events
------------------------------------------------------------------------------------]]

function Squishy:UpdateBlacklist()
	for unit in pairs(blacklist) do
		blacklist[unit] = blacklist[unit] - 1
		if blacklist[unit] <= 0 then
			blacklist[unit] = nil
		end
	end
end


function Squishy:RosterLib_RosterChanged(tbl)
	-- remove units that have left the group
	for name in pairs(tbl) do
		local u = tbl[name]
		if not u.name then
			for i = table.getn(self.priority), 1, -1 do
				if not roster[self.priority[i].name] then
					priorityIndex[self.priority[i].name] = nil
					Compost:Reclaim(self.priority[i])
					self.priority[i] = nil
					table.remove(self.priority, i)
				end
			end
		elseif not u.priority then
			self:UpdateUnit(name)
		end
	end
	-- hide or show the frame
	self:CheckVisibility()
end


function Squishy:SPELLCAST_START()
	-- problem: with high latency the message is sent at latency*2+scheduler as we're waiting for the server ack
	if self.spell == arg1 and watchSpells[arg1] and self.target then
		if self.spell == PoH then
			self:GroupHeal(playerName)
			self:SendCommMessage("GROUP", "HG")
		else
			if roster[self.target] then
				dirty[self.target] = true
				roster[self.target].healstart = GetTime()
				self:SendCommMessage("GROUP", "HN", self.target)
			end
		end
	end
end


function Squishy:SPELLCAST_STOP()
	self.target = nil
end


function Squishy:UNIT_HEALTH(units)
	for unit in pairs(units) do
		local name = UnitName(unit)
		if roster[name] then
			dirty[name] = true
		end
	end
end

function Squishy:UI_ERROR_MESSAGE(arg1)
	if arg1 == SPELL_FAILED_LINE_OF_SIGHT then
		if self.target and self.target ~= playerName then
			blacklist[self.target] = 5
		end
	end
end


function Squishy:CHAT_MSG_COMBAT_FRIENDLY_DEATH(msg)
	if msg ~= UNITDIESSELF then
		local regex = string.gsub(UNITDIESOTHER, "%%s","(.+)")
		local _, _, name = string.find(msg, regex)
		if name and self.target and name == self.target then
			self:ScreenAlert(0,name..L[" died."]) 
		end
	end
end


function Squishy:OnCommReceive(prefix, sender, distribution, message, message2)
    if not roster[sender] or sender == playerName then return end
	roster[sender].squishyuser = true
	if message == "HN" then
		local name = message2
		if not roster[name] then return end
		roster[name].healstart = GetTime()
		dirty[name] = true
		if name == playerName then 
			self:ScreenAlert(100,sender..L[" is healing you."]) 
		end
	elseif message == "HG" then
		self:GroupHeal(sender)
	elseif message == "VQ" then 
		self:SendCommMessage("GROUP", "VR", vmajor.."."..vminor)
	elseif message == "VR" then
		queryData[sender] = message2
	end
end


function Squishy:SomeoneIsHealing(msg)
	-- SPELLCASTOTHERSTART = "%s begins to cast %s.";
	for helper, spell in string.gfind(msg, castMessage) do
		if not watchSpells[spell] then return end
		if not helper or not spell or not roster[helper] then return end   -- do we need the "or not spell" here?
		if roster[helper].squishyuser then return end
		if spell == PoH then
			self:GroupHeal(helper)
		else
			local unit = roster[helper].unitid.."target"
			local name = UnitName(unit)
			if not roster[name] then return end
			if UnitHealth(unit)/UnitHealthMax(unit) < 0.9 or roster[name].banzai then
				roster[name].healstart = GetTime()
				dirty[name] = true
				if name == playerName then
					self:ScreenAlert(100,helper..L[" is healing you."])
				end
			end
		end
	end
	-- 	POWERGAINOTHEROTHER = "%s gains %d %s from %s's %s."; -- Bob gains 5 mana from Fred's spell.
	for unit in string.gfind(msg, tapMessage) do
		blacklist[unit] = 5
	end
end


function Squishy:GroupHeal(healer)
	if not roster[healer] then return end
	local subgroup = roster[healer].subgroup
	if not subgroup then return end
	local now = GetTime()
	for u in RL:IterateRoster(Squishy.db.profile.PetSupport) do
		if u.subgroup == subgroup then
			u.healstart = now
			dirty[u.name] = true
		end
	end
	if playerName ~= healer and roster[playerName].subgroup == subgroup then
		self:ScreenAlert(100, healer..L[" healing your group."])
	end
end


function Squishy:Banzai_PlayerGainedAggro(banzaiTarget)
--	if self.showFrame and ( GetTime() - lastAggroAlert > 3 ) then
	if GetTime() - lastAggroAlert > 3 then
		self:ScreenAlert(0, "AGGRO: " .. UnitName(banzaiTarget[1]))
		if Squishy.db.profile.AudioAggro and ( GetTime() - lastAggroAlert > 5 ) then
			PlaySoundFile("Interface\\AddOns\\Squishy\\audio\\aggro.wav")
		end
		lastAggroAlert = GetTime()
	end
end


--[[---------------------------------------------------------------------------------
 Schedules
------------------------------------------------------------------------------------]]

function Squishy:UpdateEmergencyFrame()
	if not roster[playerName] then self:Debug("no roster[playerName]") return end
	isInBattleground = self:IsInBattlegrounds()
	self:UpdateDirtyUnits()
	self:UpdatePriority()
	if self.showFrame then 
	 	self:UpdatePriorityFrames()
	end
end


function Squishy:UpdateDirtyUnits()
	for name in pairs(dirty) do
		self:UpdateUnit(name)
	end
	dirty = Compost:Erase(dirty)
end


function Squishy:UpdateAllUnits()
	for name in pairs(roster) do
		self:UpdateUnit(name)
	end
	dirty = Compost:Erase(dirty)
end


--[[---------------------------------------------------------------------------------
 Background Calculations
------------------------------------------------------------------------------------]]

function Squishy:UpdateUnit(name)
	if not roster[name] then return end
	local id = roster[name].unitid
	local _,time = proximity:GetUnitRange(id)
	if time and GetTime() - time < 6 then
		roster[name].priority = self:GetModifier(name) + floor(UnitHealth(id)/UnitHealthMax(id)*100)
	else
		roster[name].priority = 0
	end
end


function Squishy:IsInBattlegrounds()
	return (MiniMapBattlefieldFrame.status == "active")
end

-- high usage, try to optimize:
function Squishy:GetModifier(name)
	local m = 0
	local u = roster[name]
	if not u or not type(u) == "table" then return m end
	if not u.classmodifier then u.classmodifier = classModifiers[playerClass][u.class] end
	if not u.healstart then u.healstart = 0 end
	if not isInBattleground or u.class == "PET" then m = m + u.classmodifier end
	if UnitPowerType(u.unitid) == 0 and UnitMana(u.unitid)/UnitManaMax(u.unitid) < 0.1 then
		if isInBattleground then m = m + 50             -- let oom people die in PvP
		else m = m + 10
		end
	end
	if u.banzai then
		if GetTime() - u.healstart < 2 then m = m - 5 else m = m - 15 end
	else
		if GetTime() - u.healstart < 2 then m = m + 20 end
	end
	if not isInBattleground and UnitInParty(u.unitid) then m = m - math.max(20, GetNumRaidMembers()) end
	if name == playerName and isInBattleground then m = m - 10 end
	if UnitName("target") == name then m = m - 20 end
	if not UnitAffectingCombat(u.unitid) then m = m + 15 end
	if u.rank > 0 then m = m - 5 end
	for buff in pairs(buffs) do
		if aura:UnitHasBuff(u.unitid, buff) then m = m + 8 end
	end
	for debuff in pairs(debuffs) do
		if aura:UnitHasDebuff(u.unitid, debuff) then m = m - 20 end
	end
	for buff in pairs(skip) do
		if aura:UnitHasBuff(u.unitid, buff) then m = m + 50 end
	end
	if blacklist[name] then
		m = m + ( blacklist[name] * 10 )
	end
	return m
end


function Squishy:VersionQuery()
	self:Print(L["Checking group for Squishy users, please wait."])
	self:SendCommMessage("GROUP", "VQ")
	self:ScheduleEvent(self.PrintVersionQuery, 5, self)
end


function Squishy:PrintVersionQuery()
	queryData[playerName] = vmajor.."."..vminor
	for name, version in pairs(queryData) do
		local _,_, minor = string.find(version, ".+%..+%.(%d+)")
		roster[name].squishyuser = true
		if minor then
			local c = "FFFFFF"
			if tonumber(minor) < vminor then 
				c = "FF0000"
			elseif tonumber(minor) > vminor then 
				c = "00FF00"
			end
			self:Print(name, L["using"], "|cff"..c..version.."|r")
		else
			self:Print(name, "using UNKNOWN Squishy version", version)
		end
	end
	queryData = Compost:Erase(queryData)
end


local function sortPri(a,b) 
	return a.pri < b.pri 
end


function Squishy:UpdatePriority()
	-- XXX this function needs some optimization, and/or check if it's proximitys fault.
	local currentTime = GetTime()
	local pets = Squishy.db.profile.PetSupport
	-- loop through all units
	local datasubtable, index
	for name, u in pairs(roster) do
		-- see if that unit is in our priorityIndex table
		index = priorityIndex[name]
		-- either use the existing subtable or create a new one
		datasubtable = index and self.priority[index] or Compost:Acquire()
		-- update health if in range and aggro or health < maxPct, otherwise set it to 1000
		datasubtable.pri = 1000
		local id = u.unitid
		if (pets or u.class ~= "PET") and not UnitIsDeadOrGhost(id) and UnitIsConnected(id) and UnitIsVisible(id) then
			if u.banzai or UnitHealth(id)/UnitHealthMax(id)*100 < maxPct then
				local _,time = proximity:GetUnitRange(id)
				if time and currentTime - time < 6 then
					datasubtable.pri = u.priority
				end
			end
		end
		if (not index) then
			-- our subtable still needs a name
			datasubtable.name = name
			-- add that subtable to the priority table
			table.insert(self.priority, datasubtable)
			priorityIndex[name] = table.getn(self.priority)  -- maybe not needed, but for safety reasons it can't hurt.
		end
	end
	-- this should NEVER be necessary. And if, you should only see it once.
	local cnt = 0
	for k,v in pairs(self.priority) do cnt = cnt + 1 end
	for k,v in pairs(self.priority) do
		if not v.pri then 
			self:Debug("no .pri for", roster[v.name].class, v.name, "--", k, cnt)
			v.pri = 1000
		end
	end
	-- now re-sort the priority table
	table.sort(self.priority, sortPri)
	-- save the current index for all names
	for index, value in ipairs(self.priority) do
		priorityIndex[value.name] = index
	end
end


-- maybe we can now use priorityIndex to optimize this code.
function Squishy:UpdatePriorityFrames()
	local lastUsedFrame = 0
	for n, u in pairs(RL.roster) do u.processed = nil end
	frameNumByNameProcessed = Compost:Erase(frameNumByNameProcessed)
	frameByNumProcessed = Compost:Erase(frameByNumProcessed)
	-- update existing frames
	for index, value in ipairs(self.priority) do
		if index > self.db.profile.NumUnits then break end
		if value.pri == 1000 then break end
		local num = frameNumByName[value.name]
		if num then
			frameByNum[num] = true
			frameByNumProcessed[num] = true
			frameNumByNameProcessed[value.name] = true
			RL.roster[value.name].processed = true
			self:UpdateFrameData(num, RL.roster[value.name])
		end
	end
	-- fill not used frames with new units
	for num = 1, self.db.profile.NumUnits do
		if not frameByNum[num] or not frameByNumProcessed[num] then
			-- ouch, nested loops!
			for index, value in ipairs(self.priority) do
				if index > self.db.profile.NumUnits then break end
				if value.pri == 1000 then break end
				if not RL.roster[value.name].processed then
					frameByNum[num] = true
					frameNumByName[value.name] = num
					frameByNumProcessed[num] = true
					frameNumByNameProcessed[value.name] = true
					RL.roster[value.name].processed = true
					self:UpdateFrameData(num, RL.roster[value.name])
					break
				end
			end
		end
	end
	-- hide frames we don't need
	for num = 1, self.db.profile.NumUnits do
		if self.frames.units[num] then
			if not frameByNum[num] or not frameByNumProcessed[num] then
				self.frames.units[num]:Hide()
				frameByNum[num] = nil
				frameByNumProcessed[num] = nil
			end
		end
	end
	-- clear frameNumByName
	for name in pairs(frameNumByName) do
		if not frameNumByNameProcessed[name] then
			frameNumByName[name] = nil
		end
	end
	-- find last used frame
	for i = 1, self.db.profile.NumUnits do
		if frameByNum[i] then
			lastUsedFrame = i
		end
	end
	self:UpdateFrameSize(lastUsedFrame)
end


function Squishy:TargetSquishyUnitByPosition(position, idreturn)
	local f = self.frames.units[position]
	if f then
		if idreturn == 1 then return f.unit
		else TargetUnit(f.unit) end
	end
end


function Squishy:TargetSquishyUnitByPriority(i, idreturn)
	local u = self.priority[i]
	if not u then return end
	if u.pri == 1000 then return end
	if idreturn == 1 then 
		return roster[u.name].unitid
	else 
		TargetUnit(roster[u.name].unitid)
	end
end


function Squishy:OnClick()
	local unit = this.unit
	if not unit then return end
	if UnitIsUnit(unit, "player") then unit = "player" end
	local button = arg1
	if SquishyCustomClick and SquishyCustomClick(arg1, unit) then 
		return
	elseif button == "LeftButton" then
		if not UnitExists(unit) then return end
		if SpellIsTargeting() then
			if button == "LeftButton" then SpellTargetUnit(unit)
			elseif button == "RightButton" then SpellStopTargeting() end
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
