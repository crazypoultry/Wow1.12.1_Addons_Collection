local AceOO = AceLibrary("AceOO-2.0")

local TargetInfo = AceOO.Class(IceElement)

local target = "target"
local internal = "internal"

TargetInfo.prototype.buffSize = nil
TargetInfo.prototype.width = nil

TargetInfo.prototype.name = nil
TargetInfo.prototype.guild = nil
TargetInfo.prototype.realm = nil
TargetInfo.prototype.rank = nil
TargetInfo.prototype.classLocale = nil
TargetInfo.prototype.classEnglish = nil
TargetInfo.prototype.leader = nil

TargetInfo.prototype.combat = nil
TargetInfo.prototype.pvp = nil
TargetInfo.prototype.level = nil
TargetInfo.prototype.classification = nil
TargetInfo.prototype.reaction = nil
TargetInfo.prototype.tapped = nil
TargetInfo.prototype.pvpRank = nil

TargetInfo.prototype.isPlayer = nil


-- Constructor --
function TargetInfo.prototype:init()
	TargetInfo.super.prototype.init(self, "TargetInfo")
	
	self.scalingEnabled = true
end



-- 'Public' methods -----------------------------------------------------------

-- OVERRIDE
function TargetInfo.prototype:Enable(core)
	TargetInfo.super.prototype.Enable(self, core)
	
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "TargetChanged")
	self:RegisterEvent("UNIT_AURA", "AuraChanged")

	self:RegisterEvent("UNIT_FACTION", "TargetFaction")
	self:RegisterEvent("UNIT_LEVEL", "TargetLevel")

	self:RegisterEvent("UNIT_FLAGS", "TargetFlags")
	self:RegisterEvent("UNIT_DYNAMIC_FLAGS", "TargetFlags")

	self:RegisterEvent("RAID_TARGET_UPDATE", "UpdateRaidTargetIcon")
end


-- OVERRIDE
function TargetInfo.prototype:GetOptions()
	local opts = TargetInfo.super.prototype.GetOptions(self)

	opts["vpos"] = {
		type = "range",
		name = "Vertical Position",
		desc = "Vertical Position",
		get = function()
			return self.moduleSettings.vpos
		end,
		set = function(v)
			self.moduleSettings.vpos = v
			self:Redraw()
		end,
		min = -300,
		max = 300,
		step = 10,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 31
	}

	opts["fontSize"] = {
		type = 'range',
		name = 'Font Size',
		desc = 'Font Size',
		get = function()
			return self.moduleSettings.fontSize
		end,
		set = function(v)
			self.moduleSettings.fontSize = v
			self:Redraw()
		end,
		min = 8,
		max = 20,
		step = 1,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 32
	}
	
	opts["stackFontSize"] = {
		type = 'range',
		name = 'Stack Font Size',
		desc = 'Stack Font Size',
		get = function()
			return self.moduleSettings.stackFontSize
		end,
		set = function(v)
			self.moduleSettings.stackFontSize = v
			self:Redraw()
		end,
		min = 8,
		max = 20,
		step = 1,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 32
	}
	
	opts["zoom"] = {
		type = 'range',
		name = 'Buff zoom',
		desc = 'Buff/debuff icon zoom',
		get = function()
			return self.moduleSettings.zoom
		end,
		set = function(v)
			self.moduleSettings.zoom = v
			self:Redraw()
		end,
		min = 0,
		max = 0.2,
		step = 0.01,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		isPercent = true,
		order = 33
	}
	
	opts["buffSize"] = {
		type = 'range',
		name = 'Buff size',
		desc = 'Buff/debuff icon size',
		get = function()
			return self.moduleSettings.buffSize
		end,
		set = function(v)
			self.moduleSettings.buffSize = v
			self:Redraw()
		end,
		min = 8,
		max = 20,
		step = 1,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 34
	}
	
	opts["mouse"] = {
		type = 'toggle',
		name = 'Mouseover',
		desc = 'Toggle mouseover on/off',
		get = function()
			return self.moduleSettings.mouse
		end,
		set = function(v)
			self.moduleSettings.mouse = v
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 35
	}

	return opts
end


-- OVERRIDE
function TargetInfo.prototype:GetDefaultSettings()
	local defaults =  TargetInfo.super.prototype.GetDefaultSettings(self)
	defaults["fontSize"] = 13
	defaults["stackFontSize"] = 11
	defaults["vpos"] = -50
	defaults["zoom"] = 0.08
	defaults["buffSize"] = 14
	defaults["mouse"] = true
	return defaults
end


-- OVERRIDE
function TargetInfo.prototype:Redraw()
	TargetInfo.super.prototype.Redraw(self)

	if (self.moduleSettings.enabled) then
		self:CreateFrame(true)
		self:TargetChanged()
	end

end



-- 'Protected' methods --------------------------------------------------------

-- OVERRIDE
function TargetInfo.prototype:CreateFrame()
	TargetInfo.super.prototype.CreateFrame(self)

	self.width = self.settings.gap + 50

	self.frame:SetFrameStrata("BACKGROUND")
	self.frame:SetWidth(self.width)
	self.frame:SetHeight(42)
	self.frame:ClearAllPoints()
	self.frame:SetPoint("TOP", self.parent, "BOTTOM", 0, self.moduleSettings.vpos)
	self.frame:SetScale(self.moduleSettings.scale)

	self:CreateTextFrame()
	self:CreateInfoTextFrame()
	self:CreateGuildTextFrame()

	self:CreateBuffFrame()
	self:CreateDebuffFrame()

	self:CreateRaidIconFrame()
	
	self.frame:Hide()
end


function TargetInfo.prototype:CreateTextFrame()
	if (not self.frame.target) then
		self.frame.target = CreateFrame("Button", "IceHUD_TargetInfo_Name", self.frame)
	end

	self.frame.target.unit = target -- for blizz default tooltip handling
	
	if (self.moduleSettings.mouse) then
		self.frame.target:EnableMouse(true)
		self.frame.target:RegisterForClicks("LeftButtonUp", "RightButtonUp")
		self.frame.target:SetScript("OnClick", function() self:OnClick(arg1) end)
		self.frame.target:SetScript("OnEnter", function() self:OnEnter() end)
		self.frame.target:SetScript("OnLeave", function() self:OnLeave() end)
	else
		self.frame.target:EnableMouse(false)
		self.frame.target:RegisterForClicks()
		self.frame.target:SetScript("OnClick", nil)
		self.frame.target:SetScript("OnEnter", nil)
		self.frame.target:SetScript("OnLeave", nil)
	end


	self.frame.target:SetWidth(self.width)
	self.frame.target:SetHeight(14)
	self.frame.target:SetPoint("TOP", self.frame, "TOP", 0, -2)

	self.frame.targetName = self:FontFactory("Bold", self.moduleSettings.fontSize+1, nil, self.frame.targetName)
	self.frame.targetName:SetJustifyH("CENTER")
	self.frame.targetName:SetJustifyV("TOP")
	self.frame.targetName:SetAllPoints(self.frame.target)
	
	
	if (not self.frame.target.highLight) then
		self.frame.target.highLight = self.frame.target:CreateTexture(nil, "OVERLAY")
		self.frame.target.highLight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
		self.frame.target.highLight:SetBlendMode("ADD")
		self.frame.target.highLight:SetAllPoints(self.frame.target)
		self.frame.target.highLight:SetVertexColor(1, 1, 1, 0.25)
		self.frame.target.highLight:Hide()
	end


	self.frame.target:Hide()
end


function TargetInfo.prototype:CreateInfoTextFrame()
	self.frame.targetInfo = self:FontFactory(nil, self.moduleSettings.fontSize, nil, self.frame.targetInfo)

	self.frame.targetInfo:SetWidth(self.width)
	self.frame.targetInfo:SetHeight(14)
	self.frame.targetInfo:SetJustifyH("CENTER")
	self.frame.targetInfo:SetJustifyV("TOP")

	self.frame.targetInfo:SetPoint("TOP", self.frame, "TOP", 0, -16)
	self.frame.targetInfo:Show()
end


function TargetInfo.prototype:CreateGuildTextFrame()
	self.frame.targetGuild = self:FontFactory(nil, self.moduleSettings.fontSize, nil, self.frame.targetGuild)

	self.frame.targetInfo:SetWidth(self.width)
	self.frame.targetGuild:SetHeight(14)
	self.frame.targetGuild:SetJustifyH("CENTER")
	self.frame.targetGuild:SetJustifyV("TOP")

	self.frame.targetGuild:SetAlpha(0.6)

	self.frame.targetGuild:SetPoint("TOP", self.frame, "TOP", 0, -30)
	self.frame.targetGuild:Show()
end


function TargetInfo.prototype:CreateRaidIconFrame()
	if (not self.frame.raidIcon) then
		self.frame.raidIcon = CreateFrame("Frame", nil, self.frame)
	end
	
	if (not self.frame.raidIcon.icon) then
		self.frame.raidIcon.icon = self.frame.raidIcon:CreateTexture(nil, "BACKGROUND")
		self.frame.raidIcon.icon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
	end

	self.frame.raidIcon:SetPoint("BOTTOM", self.frame, "TOP", 0, 1)
	self.frame.raidIcon:SetWidth(16)
	self.frame.raidIcon:SetHeight(16)
	
	self.frame.raidIcon.icon:SetAllPoints(self.frame.raidIcon)
	SetRaidTargetIconTexture(self.frame.raidIcon.icon, 0)
	self.frame.raidIcon:Hide()
end


function TargetInfo.prototype:CreateBuffFrame()
	if (not self.frame.buffFrame) then
		self.frame.buffFrame = CreateFrame("Frame", nil, self.frame)
	end

	self.frame.buffFrame:SetFrameStrata("BACKGROUND")
	self.frame.buffFrame:SetWidth(1)
	self.frame.buffFrame:SetHeight(1)

	self.frame.buffFrame:ClearAllPoints()
	self.frame.buffFrame:SetPoint("TOPRIGHT", self.frame, "TOPLEFT", -5, 0)
	self.frame.buffFrame:Show()

	if (not self.frame.buffFrame.buffs) then
		self.frame.buffFrame.buffs = {}
	end
	self.frame.buffFrame.buffs = self:CreateIconFrames(self.frame.buffFrame, -1, self.frame.buffFrame.buffs, "buff")
end


function TargetInfo.prototype:CreateDebuffFrame()
	if (not self.frame.debuffFrame) then
		self.frame.debuffFrame = CreateFrame("Frame", nil, self.frame)
	end

	self.frame.debuffFrame:SetFrameStrata("BACKGROUND")
	self.frame.debuffFrame:SetWidth(1)
	self.frame.debuffFrame:SetHeight(1)

	self.frame.debuffFrame:ClearAllPoints()
	self.frame.debuffFrame:SetPoint("TOPLEFT", self.frame, "TOPRIGHT", 5, 0)
	self.frame.debuffFrame:Show()

	if (not self.frame.debuffFrame.buffs) then
		self.frame.debuffFrame.buffs = {}
	end
	self.frame.debuffFrame.buffs = self:CreateIconFrames(self.frame.debuffFrame, 1, self.frame.debuffFrame.buffs, "debuff")
end


function TargetInfo.prototype:CreateIconFrames(parent, direction, buffs, type)
	for i = 1, 16 do
		if (not buffs[i]) then
			buffs[i] = CreateFrame("Frame", nil, parent)
			buffs[i].icon = CreateFrame("Frame", nil, buffs[i])
		end

		buffs[i]:SetFrameStrata("BACKGROUND")
		buffs[i]:SetWidth(self.moduleSettings.buffSize)
		buffs[i]:SetHeight(self.moduleSettings.buffSize)
		
		buffs[i].icon:SetFrameStrata("BACKGROUND")
		buffs[i].icon:SetWidth(self.moduleSettings.buffSize-2)
		buffs[i].icon:SetHeight(self.moduleSettings.buffSize-2)

		local pos = (i > 8) and i-8 or i
		local x = (((pos-1) * self.moduleSettings.buffSize) + (pos-0)) * direction
		local y = (i > 8) and -self.moduleSettings.buffSize-1 or 0

		buffs[i]:ClearAllPoints()
		buffs[i]:SetPoint("TOP", x, y)
		
		buffs[i].icon:ClearAllPoints()
		buffs[i].icon:SetPoint("CENTER", 0, 0)

		buffs[i]:Show()
		buffs[i].icon:Show()

		if (not buffs[i].texture) then
			buffs[i].texture = buffs[i]:CreateTexture()
			buffs[i].texture:ClearAllPoints()
			buffs[i].texture:SetAllPoints(buffs[i])

			buffs[i].icon.texture = buffs[i].icon:CreateTexture()
			buffs[i].icon.texture:SetTexture(nil)

			buffs[i].icon.texture:ClearAllPoints()
			buffs[i].icon.texture:SetAllPoints(buffs[i].icon)
		end
		
		buffs[i].icon.stack = self:FontFactory("Bold", self.moduleSettings.stackFontSize, buffs[i].icon)

		buffs[i].icon.stack:ClearAllPoints()
		buffs[i].icon.stack:SetPoint("BOTTOMRIGHT" , buffs[i].icon, "BOTTOMRIGHT", 1, -1)
		
		
		buffs[i].id = i
		if (self.moduleSettings.mouse) then
			buffs[i]:EnableMouse(true)
			buffs[i]:SetScript("OnEnter", function() self:BuffOnEnter(type) end)
			buffs[i]:SetScript("OnLeave", function() GameTooltip:Hide() end)
		else
			buffs[i]:EnableMouse(false)
			buffs[i]:SetScript("OnEnter", nil)
			buffs[i]:SetScript("OnLeave", nil)
		end
	end

	return buffs
end




function TargetInfo.prototype:UpdateBuffs()
	local zoom = self.moduleSettings.zoom

	for i = 1, 16 do
		local buffTexture, buffApplications = UnitBuff("target", i)

		--buffTexture = buffTexture or "Interface\\Icons\\Spell_Nature_Regeneration"

		self.frame.buffFrame.buffs[i].icon.texture:SetTexture(buffTexture)
		self.frame.buffFrame.buffs[i].icon.texture:SetTexCoord(zoom, 1-zoom, zoom, 1-zoom)
		
		local alpha = buffTexture and 0.5 or 0
		self.frame.buffFrame.buffs[i].texture:SetTexture(0, 0, 0, alpha)


		--buffApplications = 2

		if (buffApplications and (buffApplications > 1)) then
			self.frame.buffFrame.buffs[i].icon.stack:SetText(buffApplications)
		else
			self.frame.buffFrame.buffs[i].icon.stack:SetText(nil)
		end
		
		if (buffTexture) then
			self.frame.buffFrame.buffs[i]:Show()
		else
			self.frame.buffFrame.buffs[i]:Hide()
		end

	end

	for i = 1, 16 do
		local buffTexture, buffApplications, debuffDispelType = UnitDebuff("target", i)

		--buffTexture = buffTexture or "Interface\\Icons\\Ability_Creature_Disease_04"

		local color = debuffDispelType and DebuffTypeColor[debuffDispelType] or DebuffTypeColor["none"]
		local alpha = buffTexture and 1 or 0
		self.frame.debuffFrame.buffs[i].texture:SetTexture(1, 1, 1, alpha)

		self.frame.debuffFrame.buffs[i].texture:SetVertexColor(color.r, color.g, color.b)


		self.frame.debuffFrame.buffs[i].icon.texture:SetTexture(buffTexture)
		self.frame.debuffFrame.buffs[i].icon.texture:SetTexCoord(zoom, 1-zoom, zoom, 1-zoom)

		if (buffApplications and (buffApplications > 1)) then
			self.frame.debuffFrame.buffs[i].icon.stack:SetText(buffApplications)
		else
			self.frame.debuffFrame.buffs[i].icon.stack:SetText(nil)
		end


		if (buffTexture) then
			self.frame.debuffFrame.buffs[i]:Show()
		else
			self.frame.debuffFrame.buffs[i]:Hide()
		end
	end
end



function TargetInfo.prototype:AuraChanged(unit)
	if (unit == target) then
		self:UpdateBuffs()
	end
end


function TargetInfo.prototype:UpdateRaidTargetIcon()
	if not (UnitExists(target)) then
		self.frame.raidIcon:Hide()
		return
	end

	local index = GetRaidTargetIndex(target);

	if (index and (index > 0)) then
		SetRaidTargetIconTexture(self.frame.raidIcon.icon, index)
		self.frame.raidIcon:Show()
	else
		self.frame.raidIcon:Hide()
	end
end


function TargetInfo.prototype:TargetChanged()
	if (not UnitExists(target)) then
		self.frame:Hide()
		self.frame.target:Hide()
		
		self.frame.targetName:SetText()
		self.frame.targetInfo:SetText()
		self.frame.targetGuild:SetText()
		
		self:UpdateBuffs()
		self:UpdateRaidTargetIcon()
		return
	end
	
	self.frame:Show()
	self.frame.target:Show()

	self.name, self.realm = UnitName(target)
	self.classLocale, self.classEnglish = UnitClass(target)
	self.isPlayer = UnitIsPlayer(target)
	
	local rank = UnitPVPRank(target)
	self.pvpRank = (rank >= 5) and rank-4 or nil

	local classification = UnitClassification(target)
	if (string.find(classification, "boss")) then
		self.classification = " |cffcc1111Boss|r"
	elseif(string.find(classification, "rare")) then
		self.classification = " |cffcc11ccRare|r"
	else
		self.classification = ""
	end


	local guildName, guildRankName, guildRankIndex = GetGuildInfo(target);
	self.guild = guildName and "<" .. guildName .. ">" or ""


	if (self.classLocale and self.isPlayer) then
		self.classLocale = "|c" .. self:GetHexColor(self.classEnglish) ..  self.classLocale .. "|r"
	else
		self.classLocale = UnitCreatureType(target)
	end


	self.leader = UnitIsPartyLeader(target) and " |cffcccc11Leader|r" or ""


	-- pass "internal" as a paramater so event handler code doesn't execute
	-- self:Update() unnecassarily
	self:TargetLevel(internal)
	self:TargetReaction(internal)
	self:TargetFaction(internal)
	self:TargetFlags(internal)

	self:UpdateBuffs()
	self:UpdateRaidTargetIcon()

	self:Update(target)
end


function TargetInfo.prototype:TargetLevel(unit)
	if (unit == target or unit == internal) then
		self.level = UnitLevel(target)
		
		local color = GetDifficultyColor((self.level > 0) and self.level or 100)

		if (self.level > 0) then
			if (UnitIsPlusMob(target)) then
				self.level = self.level .. "+"
			end
		else
			self.level = "??"
		end

		self.level = "|c" .. self:ConvertToHex(color) .. self.level .. "|r"

		self:Update(unit)
	end
end


function TargetInfo.prototype:TargetReaction(unit)
	if (unit == target or unit == internal) then
		self.reaction = UnitReaction(target, "player")
		
		-- if we don't get reaction, unit is out of range - has to be friendly
		-- to be targettable (party/raid)
		if (not self.reaction) then
			self.reaction = 5
		end
		self:Update(unit)
	end
end


-- PVP status
function TargetInfo.prototype:TargetFaction(unit)
	if (unit == target or unit == internal) then
		if (self.isPlayer) then
			if (UnitIsPVP(target)) then
				local color = "ff10ff10" -- friendly
				if (UnitFactionGroup(target) ~= UnitFactionGroup("player")) then
					color = "ffff1010" -- hostile
				end
				self.pvp = " |c" .. color .. "PvP"
			else
				self.pvp = " |cff1010ffPvE"
			end
			
			-- add rank
			self.pvp = self.pvpRank and (self.pvp .. "/" .. self.pvpRank .. "|r") or (self.pvp .. "|r")
			
		else
			self.pvp = ""
		end

		self:Update(unit)
	end
end


function TargetInfo.prototype:TargetFlags(unit)
	if (unit == target or unit == internal) then
		self.tapped = UnitIsTapped(target) and (not UnitIsTappedByPlayer(target))
		self.combat = UnitAffectingCombat(target) and " |cffee4030Combat|r" or ""
		self:Update(unit)
	end
end


function TargetInfo.prototype:Update(unit)
	if (unit ~= target) then
		return
	end

	local reactionColor = self:ConvertToHex(UnitReactionColor[self.reaction])
	if (self.tapped) then
		reactionColor = self:GetHexColor("Tapped")
	end

	local line1 = string.format("|c%s%s|r", reactionColor, self.name or '')
	self.frame.targetName:SetText(line1)

	local line2 = string.format("%s %s%s%s%s%s",
		self.level or '', self.classLocale or '', self.pvp or '', self.leader or '', self.classification or '', self.combat or '')
	self.frame.targetInfo:SetText(line2)

	local realm = self.realm and " " .. self.realm or ""
	local line3 = string.format("%s%s", self.guild or '', realm)
	self.frame.targetGuild:SetText(line3)
end



function TargetInfo.prototype:OnClick(button)
	-- copy&paste from blizz code, it better work ;)
	if (SpellIsTargeting() and button == "RightButton") then
		SpellStopTargeting()
		return
	end

	if (button == "LeftButton") then
		if (SpellIsTargeting()) then
			SpellTargetUnit(target)
		elseif (CursorHasItem()) then
			DropItemOnUnit(target)
		end
	else
		ToggleDropDownMenu(1, nil, TargetFrameDropDown, "cursor")
	end
end


function TargetInfo.prototype:OnEnter()
	UnitFrame_OnEnter()
	self.frame.target.highLight:Show()
end


function TargetInfo.prototype:OnLeave()
	UnitFrame_OnLeave()
	self.frame.target.highLight:Hide()
end


function TargetInfo.prototype:BuffOnEnter(type)
	if (not this:IsVisible()) then
		return
	end

	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT")
	if (type == "buff") then
		GameTooltip:SetUnitBuff(target, this.id)
	else
		GameTooltip:SetUnitDebuff(target, this.id)
	end
end


-- Load us up
IceHUD_Module_TargetInfo = TargetInfo:new()
