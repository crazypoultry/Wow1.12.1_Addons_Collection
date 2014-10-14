aUF = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceHook-2.0", "AceDB-2.0", "AceConsole-2.0")
aUF.Layouts = {}

local print = function(msg) if msg then DEFAULT_CHAT_FRAME:AddMessage(msg) end end

-- SYSTEM

function aUF:OnInitialize()
	self.EMULATE_BETA = false
	
	self:RegisterDB("aUFDB")
	self:RegisterDefaults('profile', aUF_DEFAULT_OPTIONS)
	
	self.dewdrop = AceLibrary("Dewdrop-2.0")
	self:SetupVariables()
	self:UpdateBlizzVisibility()
	self:InitMenu()
	self:RegisterEvents()
	self:LoadStringFormats()
	if UnitInRaid("player") == 1 then
		self:ScheduleEvent(self.RAID_ROSTER_UPDATE, 0.2, self)
	end
	aUF:ScheduleRepeatingEvent("agUF_auraPoolSchedule",self.AuraPool, 0.3, self)
end

function aUF:AuraPool()
	local n = 0
	for k,v in pairs(self.auraUpdatePool) do
		if v == true and self.auraUpdates + n < 5 then
			self.units[k]:UpdateAuras(true)
			n = n + 1
		else
			break
		end
	end
	aUF.auraUpdates = 0
end

function aUF:Reset()
	self:ResetDB("profile")
	self:LoadStringFormats()
	self:CallUnitMethods("Reset")
	self:CallUnitMethods("Reset",nil,nil,nil,"subgroups")
end

function aUF:OnProfileEnable()
	self:CallUnitMethods("Reset")
end

function aUF:SetupVariables()
	self.imagePath = "Interface\\AddOns\\ag_UnitFrames\\images\\"
	self.fontPath = "Interface\\AddOns\\ag_UnitFrames\\fonts\\"
	
	self.wowClasses = {"player","pet","party","partypet","target","targettarget","raid","raidpet"}
	
	-- Which auras can the player see?
	self.CanDispel = {
		["PRIEST"] = {
			["Magic"] = true,
			["Disease"] = true,
		},
		["SHAMAN"] = {
			["Poison"] = true,
			["Disease"] = true,
		},
		["PALADIN"] = {
			["Magic"] = true,
			["Poison"] = true,
			["Disease"] = true,
		},
		["MAGE"] = {
			["Curse"] = true,
		},
		["DRUID"] = {
			["Curse"] = true,
			["Poison"] = true,
		}
	}
	
	-- Various constants like colors, textures...
	
	self.DebuffColor = {
		["Magic"] = {
			r = 1,
			g = 0,
			b = 0,
		},
		["Disease"] = {
			r = 0.25,
			g = 1,
			b = 0,
		},
		["Poison"] = {
			r = 0,
			g = 0.25,
			b = 1,
		},
		["Curse"] = {
			r = 0.75,
			g = 0,
			b = 0.75,
		}
	}
	
	self.RepColor = {
		[1] = {r = 226/255, g = 45/255, b = 75/255},
		[2] = {r = 226/255, g = 45/255, b = 75/255},
		[3] = {r = 0.75, g = 0.27, b = 0},
		[4] = {r = 1, g = 1, b = 34/255},
		[5] = {r = 0.2, g = 0.8, b = 0.15},
		[6] = {r = 0.2, g = 0.8, b = 0.15},
		[7] = {r = 0.2, g = 0.8, b = 0.15},
		[8] = {r = 0.2, g = 0.8, b = 0.15},
	}
	
	self.HealthColor = {
		r = 0.11,
		g = 0.84,
		b = 0.3,
	}
	
	self.ManaColor = {
		[0] = { r = 48/255, g = 113/255, b = 191/255}, -- Mana
		[1] = { r = 226/255, g = 45/255, b = 75/255}, -- Rage
		[2] = { r = 255/255, g = 210/255, b = 0}, -- Focus
		[3] = { r = 255, g = 220/255, b = 25/255}, -- Energy
		[4] = { r = 0.00, g = 1.00, b = 1.00} -- Happiness
	}
	
	self.Borders = {
		["Classic"] 	= {["texture"] = "Interface\\Tooltips\\UI-Tooltip-Border",["size"] = 16,["insets"] = 5},
		["Nurfed"]	 	= {["texture"] = "Interface\\DialogFrame\\UI-DialogBox-Border",["size"] = 16,["insets"] = 5},
		["Hidden"] 		= {["texture"] = "",["size"] = 0,["insets"] = 3},
	}
	self.Bars	= {
		["Default"]		= self.imagePath.."AceBarFrames.tga",
		["Classic"]		= "Interface\\TargetingFrame\\UI-StatusBar",
		["Smooth"]		= self.imagePath.."smooth.tga",
		["Bumps"]		= self.imagePath.."Bumps.tga",
		["Perl"]		= self.imagePath.."Perl.tga",
		["Gloss"]		= self.imagePath.."Gloss.tga",
		["Wisps"]		= self.imagePath.."Wisps.tga",
		["Bars"]		= self.imagePath.."Bars.tga",
		["Smudge"]		= self.imagePath.."Smudge.tga",
		["Dabs"]		= self.imagePath.."Dabs.tga",
		["Rain"]		= self.imagePath.."Rain.tga",
		["Hatched"]		= self.imagePath.."Hatched.tga",
		["Grid"]		= self.imagePath.."Grid.tga",
		["Button"]		= self.imagePath.."Button.tga",
		["Skewed"]		= self.imagePath.."Skewed.tga",
		["Diagonal"]	= self.imagePath.."Diagonal.tga",
		["Cloud"]		= self.imagePath.."Cloud.tga",
		["Water"]		= self.imagePath.."Water.tga",
		["Charcoal"]	= self.imagePath.."Charcoal.tga",
		["BantoBar"]	= self.imagePath.."BantoBar.tga",
		["DarkBottom"]  = self.imagePath.."DarkBottom.tga",
		["Fourths"]		= self.imagePath.."Fourths.tga",
		["Fifths"]		= self.imagePath.."Fifths.tga",
	}

	self.RaidColors = {
		["DRUID"]	= "|cffff7c0a",
		["HUNTER"]	= "|cffaad372",
		["MAGE"]	= "|cff68ccef",
		["PALADIN"]	= "|cfff48cba",
		["PRIEST"]	= "|cffffffff",
		["ROGUE"]	= "|cfffff468",
		["SHAMAN"]	= "|cfff48cba",
		["WARLOCK"]	= "|cff9382C9",
		["WARRIOR"]	= "|cffc69b6d",
	}

	self.RaidRole = {
		["DRUID"]	= "healer",
		["HUNTER"]	= "dps",
		["MAGE"]	= "dps",
		["PALADIN"]	= "healer",
		["PRIEST"]	= "healer",
		["ROGUE"]	= "dps",
		["SHAMAN"]	= "healer",
		["WARLOCK"]	= "dps",
		["WARRIOR"]	= "tank",
	}

	self.formats = {
		["Health"] = {
			["Absolute"]	= "[aghp]",
			["Difference"]	= "[agmissinghp]",
			["Percent"]		= "[agpercenthp]",
			["Smart"]		= "[agsmarthp]",
			["Hide"]		= "",
		},
		["Mana"] = {
			["Absolute"]	= "[agmana]",
			["Difference"]	= "[agmissingmana]",
			["Percent"]		= "[agpercentmana]",
			["Smart"]		= "[agsmartmana]",
			["Hide"]		= "",
		},
		["Name"] = {
			["Default"]		= "[name]",
			["Hide"]		= "",
		},
		["Class"] = {
			["Default"]		= "[agtype][difficulty][level][white] [raidcolor][agclass][white] [agrace]",
			["Hide"]		= "",
		}
	}

	self.auraUpdates = 0
	self.auraUpdatePool = {}
	self.feedback = {}
	self.HelperFunctions = {}
	self.units = {}
	self.subgroups = {}
	self.changedSubgroups = {}
	self.changedUnits = {}
	self.events = {}
end

-- EVENT REGISTERING

function aUF:ObjectRegisterEvent(object,event,method)
	if not self.events[event] then
		self.events[event] = {}
	end
	self.events[event][object.name] = method
end

function aUF:ObjectUnregisterEvent(object,event,method)
	if self.events[event] then
		if self.events[event][object.name] then
			self.events[event][object.name] = false
		end
	end
end

function aUF:RegisterEvents()
	self:RegisterEvent("PLAYER_LOGIN")
	self:RegisterEvent("PARTY_MEMBERS_CHANGED")
	self:RegisterEvent("RAID_ROSTER_UPDATE")
	self:RegisterEvent("UNIT_PET","PARTY_MEMBERS_CHANGED")
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	
	--beta emulation
	if self.EMULATE_BETA == true then
		self:RegisterEvent("PLAYER_REGEN_ENABLED")
		self:RegisterEvent("PLAYER_REGEN_DISABLED","PLAYER_REGEN_ENABLED")
	end
end

-- EVENTS

function aUF:PLAYER_REGEN_ENABLED()
	if ((not UnitAffectingCombat("player")) and not self.BLOCK) and self.dirtyList == true then
		print("ooc update")
		aUF:RAID_ROSTER_UPDATE()
		self.dirtyList = false
	else
		self.dirtyList = false
	end
end

function aUF:PLAYER_LOGIN()
	aUF:CreateObject("player","player","XP")
	aUF:CreateObject("pet","pet","XP")
	aUF:CreateObject("target","target","Combo")
	aUF:CreateObject("targettarget","targettarget","Metro")
	
	self:PARTY_MEMBERS_CHANGED()
end

function aUF:PLAYER_TARGET_CHANGED()
	if self.units.target then
		self.units.target:UpdateAll()
	end
	if self.units.targettarget then
		if UnitExists("target") then
			self.units.targettarget:Start()
		else
			self.units.targettarget:Stop()
		end
	end
end

function aUF:PARTY_MEMBERS_CHANGED()
	for k,v in pairs(self.events.PARTY_MEMBERS_CHANGED) do
		if aUF.units[k] then
			aUF.units[k][v](aUF.units[k])
		end
	end
	
	if (((not UnitAffectingCombat("player")) and not self.BLOCK) and self.EMULATE_BETA == true) or self.EMULATE_BETA == false then
		for i = 1,4 do
			if not aUF.units["party"..i] then
				if aUF:CheckVisibility("party"..i) == true then
					aUF:CreateObject("party"..i)
				end
			end
			if not aUF.units["partypet"..i] then
				if aUF:CheckVisibility("partypet"..i) == true then
					aUF:CreateObject("partypet"..i)
				end
			end
		end
	
		aUF:agUF_UpdateGroups()
	else
		print("dirty!")
		self.dirtyList = true
	end
end

function aUF:RAID_ROSTER_UPDATE()
	for k,v in pairs(self.events.RAID_ROSTER_UPDATE) do
		if aUF.units[k] then
			aUF.units[k][v](aUF.units[k])
		end
	end
	
	if (((not UnitAffectingCombat("player")) and not self.BLOCK) and self.EMULATE_BETA == true) or self.EMULATE_BETA == false then
		for i = 1,40 do
			if not aUF.units["raid"..i] then
				if aUF:CheckVisibility("raid"..i) == true then
					aUF:CreateObject("raid"..i,"raid"..i,"Raid")
				end
			end
		end
	else
		self.dirtyList = true
	end
	
	self:PARTY_MEMBERS_CHANGED()
end

function aUF:agUF_UpdateGroups()
	for name in pairs(self.changedSubgroups) do
		if string.find(name,"party") then
			self.subgroups[name].raid = false
		end
		self.subgroups[name]:Update()
	end
	for name in pairs(self.changedUnits) do
		self.units[name]:LoadPosition()		
	end	
	self.changedUnits = {}
end

function aUF:FeedbackUpdate()
	local maxalpha = 0.6
	local found
	for objectName,v in pairs(self.feedback) do
		found = true
		local unitOjbect = aUF.units[objectName]
		local elapsedTime = GetTime() - unitOjbect.feedbackStartTime
		if ( elapsedTime < COMBATFEEDBACK_FADEINTIME ) then
			local alpha = maxalpha*(elapsedTime / COMBATFEEDBACK_FADEINTIME)
			unitOjbect.HitIndicator:SetAlpha(alpha)
		elseif ( elapsedTime < (COMBATFEEDBACK_FADEINTIME + COMBATFEEDBACK_HOLDTIME) ) then
			unitOjbect.HitIndicator:SetAlpha(maxalpha)
		elseif ( elapsedTime < (COMBATFEEDBACK_FADEINTIME + COMBATFEEDBACK_HOLDTIME + COMBATFEEDBACK_FADEOUTTIME) ) then
			local alpha = maxalpha - maxalpha*((elapsedTime - COMBATFEEDBACK_HOLDTIME - COMBATFEEDBACK_FADEINTIME) / COMBATFEEDBACK_FADEOUTTIME)
			unitOjbect.HitIndicator:SetAlpha(alpha)
		else
			unitOjbect.HitIndicator:Hide()
			aUF.feedback[objectName] = nil
		end
	end
	if not found then 
		self:CancelScheduledEvent("agUF_CombatSchedule")
	end
end

function aUF:CheckVisibility(unit)
	local _,_,type = string.find(unit, "(%a+)")
	
--	if self.db.profile[type].AlwaysShow == true then
--		return true
--	end
	-- Special cases
	-- Hide targettarget if player is targetting self
	if unit == "targettarget" then
		if UnitName("player") == UnitName("target") then
			return false
		end
		-- Hide partyframes in raid
	elseif type == "party" then
		if self.db.profile.RaidHideParty == true and UnitInRaid("player") == 1 then
			return false
		end
	elseif type == "partypet" then
		if self.db.profile.RaidHideParty == true and UnitInRaid("player") == 1 then
			return false
		end
		local parent = string.gsub(unit,"pet","")
		if aUF:CheckVisibility(parent) == false then
			return false
		end
	elseif type == "raidpet" then
		local parent = string.gsub(unit,"pet","")
		if not aUF:CheckVisibility(parent) then
			return false
		end
	end
		
	if (UnitExists(unit) and not self.db.profile[type].HideFrame == true) then
		return true
	end
end

function aUF:CreateObject(name,unit,type,db)
	if not self.units[name] then
		if not unit then
			unit = name
		end
		if not type then
			self.units[name] = self.classes.aUFunit:new(name,unit,db)
		else
			self.units[name] = self.classes["aUFunit"..type]:new(name,unit,db)
		end
	end
end

function aUF:FindObjects(sortBy,object)
	local table = {}
	if not object then object = "units" end
	if self[object] then
		for _,v in pairs(self[object]) do
			if v[sortBy] then
				if not table[v[sortBy]] then
					table[v[sortBy]] = {}
				end
				tinsert(table[v[sortBy]],v)
			end
		end
	end
	return table
end

function aUF:CallUnitMethods(func,arg,find,type,object)
	if not func then return end
	if find and type then
		if aUF:FindObjects(type)[find] then
			for _,unitObject in pairs(aUF:FindObjects(type,object)[find]) do
				if unitObject[func] then
					unitObject[func](unitObject,arg)
				end
			end
		end
	else
		if not object then object = "units" end
		if self[object] then
			for _,unitObject in pairs(self[object]) do
				unitObject[func](unitObject,arg)
			end
		end
	end
end
