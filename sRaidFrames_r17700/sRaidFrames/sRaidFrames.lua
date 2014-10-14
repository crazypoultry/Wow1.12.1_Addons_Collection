local L = AceLibrary("AceLocale-2.2"):new("sRaidFrames")
local BS = AceLibrary("Babble-Spell-2.2")
local proximity = ProximityLib:GetInstance("1")
local surface = AceLibrary("Surface-1.0") 
local roster = AceLibrary("RosterLib-2.0")

surface:Register("Otravi", "Interface\\AddOns\\sRaidFrames\\textures\\otravi")
surface:Register("Smooth", "Interface\\AddOns\\sRaidFrames\\textures\\smooth")
surface:Register("Striped", "Interface\\AddOns\\sRaidFrames\\textures\\striped")
surface:Register("BantoBar", "Interface\\AddOns\\sRaidFrames\\textures\\bantobar")

local math_mod = math.fmod or math.mod 

sRaidFrames = AceLibrary("AceAddon-2.0"):new(
	"AceDB-2.0",
	"AceEvent-2.0",
	"AceConsole-2.0",
	"FuBarPlugin-2.0"
)

-- Look I'm a fubar plugin!!
sRaidFrames.hasIcon = "Interface\\Icons\\INV_Helmet_06"
sRaidFrames.defaultMinimapPosition = 180
sRaidFrames.cannotDetachTooltip = true
sRaidFrames.hasNoColor = true
sRaidFrames.clickableTooltip = false
sRaidFrames.hideWithoutStandby = true
sRaidFrames.independentProfile = true

function sRaidFrames:OnInitialize()

	self:RegisterDB("sRaidFramesDB")
	self:Variables()

	self:RegisterDefaults("profile", {
		lock				= false,
		SortBy				= "class",
		healthDisplayType	= 'percent',
		Invert = false,
		Scale				= 1,
		Border				= true,
		Texture				= "Otravi",
		BuffType			= "debuffs",
		ShowOnlyDispellable	= 1,
		BackgroundColor		= {r = 0.47, g = 0.72, b = 1, a = 0.7},
		BorderColor			= {r = 1, g = 1, b = 1, a = 1},
		Growth				= "down",
		Spacing				= 0,
		ShowGroupTitles		= true,
		SubSort				= "name",
		UnitTooltipMethod		= "notincombat",
		BuffTooltipMethod = "always",
		DebuffTooltipMethod = "always",
		ClassFilter			= {["WARRIOR"] = true, ["PALADIN"] = true, ["SHAMAN"] = true, ["HUNTER"] = true, ["WARLOCK"] = true, ["MAGE"] = true, ["DRUID"] = true, ["ROGUE"] = true, ["PRIEST"] = true},
		GroupFilter			= {true, true, true, true, true, true, true, true},
		BuffFilter			= {},
		PowerFilter			= {[0] = true,[1] = true,[2] = true,[3] = true},
		aggro				= false,
		RangeCheck 			= false,
		RangeFrequency 		= 2,
		RangeAlpha 			= 0.5,
		HighlightTarget	= false,
	})

	self:RegisterChatCommand({"/srf", "/sraidframes"}, self.options)

	self.opt = self.db.profile

	self.OnMenuRequest = self.options

	self.master = CreateFrame("Frame", "sRaidFrame", UIParent)
	self.master:SetMovable(true)
	self.master:SetScale(self.opt.Scale)

	self.master:SetHeight(200);
	self.master:SetWidth(200);

	self.tooltip = CreateFrame("GameTooltip", "sRaidFramesTooltip", WorldFrame, "GameTooltipTemplate")
	self.tooltip:SetOwner(WorldFrame, "ANCHOR_NONE");

	self.master:Hide()

	for i = 1, MAX_RAID_MEMBERS do
		self:CreateUnitFrame(i)
	end

	for i = 1, 8 do
		self:CreateGroupFrame(i)
	end

	if WatchDog_OnClick then
		sRaidFramesCustomOnClickFunction = WatchDog_OnClick
	elseif JC_OnClick then
		sRaidFramesCustomOnClickFunction = JC_OnClick
	elseif CT_RA_CustomOnClickFunction then
		sRaidFramesCustomOnClickFunction = CT_RA_CustomOnClickFunction
	end
end

function sRaidFrames:OnProfileEnable()
	self.opt = self.db.profile
end

function sRaidFrames:OnEnable()
	self:SetPosition()
	
	self:chatUpdateBuffMenu()

	self:RegisterBucketEvent("RAID_ROSTER_UPDATE", 0.1, "UpdateRoster")

	self:UpdateRoster()
end

function sRaidFrames:OnDisable()
	self.master:Hide()
end

function sRaidFrames:JoinedRaid()
	--self:Print("Joined a raid, enabling raid frames")
	self.enabled = true

	self:RegisterBucketEvent("UNIT_HEALTH", 0.2, "UpdateUnit")
	self:RegisterBucketEvent("UNIT_AURA", 0.2, "UpdateBuffs")
	
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateTarget")

	self:RegisterEvent("Banzai_UnitGainedAggro")
	self:RegisterEvent("Banzai_UnitLostAggro")
	
	self:RegisterEvent("oRA_PlayerCanResurrect")
	self:RegisterEvent("oRA_PlayerResurrected")
	self:RegisterEvent("oRA_PlayerNotResurrected")

	-- TODO: only updateunit
	self:ScheduleRepeatingEvent("sRaidFramesUpdateAll", self.UpdateAll, 1.5, self)
	self:ScheduleRepeatingEvent("sRaidFramesRangeCheck", self.RangeCheck, self.opt.RangeFrequency, self)

	self:UpdateRoster()
	self:UpdateAll()

	self.master:Show()
end

function sRaidFrames:LeftRaid()
	--self:Print("Left raid, disabling raid frames")
	self.visible = {}
	self.enabled = false

	self:UnregisterBucketEvent("UNIT_HEALTH")
	self:UnregisterBucketEvent("UNIT_AURA")

	self:UnregisterEvent("Banzai_UnitGainedAggro")
	self:UnregisterEvent("Banzai_UnitLostAggro")
	
	self:UnregisterEvent("oRA_PlayerCanResurrect")
	self:UnregisterEvent("oRA_PlayerResurrected")
	self:UnregisterEvent("oRA_PlayerNotResurrected")

	self:CancelScheduledEvent("sRaidFramesUpdateAll")
	self:CancelScheduledEvent("sRaidFramesRangeCheck")

	for id = 1, MAX_RAID_MEMBERS do
		self.frames["raid" ..id]:Hide()
	end

	self.master:Hide()
end

function sRaidFrames:UpdateAll()
	self:UpdateUnit(self.visible)
	self:UpdateBuffs(self.visible)
end

function sRaidFrames:Variables()
	self.enabled = false
	self.frames, self.visible, self.groupframes = {}, {}, {}
	self.unavail, self.res = {}, {}, {}

	self.debuffColors = {}
	self.debuffColors["Curse"]    = { ["r"] = 1, ["g"] = 0, ["b"] = 0.75, ["a"] = 0.5, ["priority"] = 4 }
	self.debuffColors["Magic"]    = { ["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 0.5, ["priority"] = 3 }
	self.debuffColors["Disease"]  = { ["r"] = 1, ["g"] = 1, ["b"] = 0, ["a"] = 0.5, ["priority"] = 2 }
	self.debuffColors["Poison"]   = { ["r"] = 0, ["g"] = 0.5, ["b"] = 0, ["a"] = 0.5, ["priority"] = 1 }
	
	self.cooldownSpells = {}
	self.cooldownSpells["WARLOCK"] = BS["Soulstone Resurrection"]
	self.cooldownSpells["DRUID"] = BS["Rebirth"]
	self.cooldownSpells["SHAMAN"] = BS["Reincarnation"]

	self.ManaBarColor = ManaBarColor

	-- Nurfed mana color, where is the love :(
	--self.ManaBarColor[0] = { r = 0.00, g = 1.00, b = 1.00, prefix = TEXT(MANA) };
	
	self.statusmaps = {}
	self.statusmaps["Aggro"] = {["priority"] = 90}
	self.statusmaps["Target"] = {["priority"] = 50}
	self.statusmaps["Heal"] = {["priority"] = 70}
	
	self.statusstate = {}
end

function sRaidFrames:UpdateRoster()
	local num = GetNumRaidMembers()

	if num == 0 then
		if self.enabled then
			self:LeftRaid()
		end
		return
	end

	if not self.enabled then
			self:JoinedRaid()
	end

	self:UpdateVisibility()
end

function sRaidFrames:QueryVisibility(id)
	local unitid = "raid" .. id
	if not UnitName(unitid) then
		return false
	end

	local _, eClass = UnitClass(unitid)
	if not self.opt.ClassFilter[eClass] then
		return false
	end

	local _, _, subgroup = GetRaidRosterInfo(id)
	if not self.opt.GroupFilter[subgroup] then
		return false
	end

	return true
end

function sRaidFrames:UpdateVisibility()
	for id = 1, MAX_RAID_MEMBERS do
		if self:QueryVisibility(id) then
			if not self.visible["raid" .. id] then
				self.frames["raid" .. id]:Show()
				self.visible["raid" .. id] = true;
			end
		else
			if self.visible["raid" .. id] then
				self.frames["raid" .. id]:Hide()
				self.visible["raid" .. id] = nil;
			end
		end
	end

	self:Sort();
end

function sRaidFrames:UpdateTarget()
	if not self.opt.HighlightTarget then return end
	
	for unit in pairs(self.visible) do
		if UnitIsUnit(unit, "target") then
			self:SetStatusBorder("Target", self.frames[unit], {r = 1, g = 0.75, b = 0})
		else
			self:UnsetStatusBorder("Target", self.frames[unit])
		end
	end
end

function sRaidFrames:Banzai_UnitGainedAggro(unit, unitTable)
	if not unit or not self.visible[unit] or not self.opt.aggro then return end

	self:SetStatusBorder("Aggro", self.frames[unit], {r = 1, g = 0, b = 0})
end

function sRaidFrames:Banzai_UnitLostAggro(unit)
	if not unit or not self.visible[unit] or not self.opt.aggro then return end

	self:UnsetStatusBorder("Aggro", self.frames[unit])
end

function sRaidFrames:oRA_PlayerCanResurrect(msg, player)
	local unit = roster:GetUnitIDFromName(player)
	if unit then self.res[unit] = 1 end
end

function sRaidFrames:oRA_PlayerResurrected(msg, player)
	local unit = roster:GetUnitIDFromName(player)
	if unit then self.res[unit] = 2 end
end

function sRaidFrames:oRA_PlayerNotResurrected(msg, player)
	local unit = roster:GetUnitIDFromName(player)
	if unit then self.res[unit] = nil end
end

function sRaidFrames:RangeCheck()
	if not self.opt.RangeCheck then return end

    local now = GetTime()

    for unit in pairs(self.visible) do
		local _, time = proximity:GetUnitRange(unit)
		local seen = now - (time or 100)

		if time and seen < 3 then
			self.frames[unit]:SetAlpha(1)
		else
			self.frames[unit]:SetAlpha(self.opt.RangeAlpha)
		end
	end
end

function sRaidFrames:UpdateRangeFrequency()
		self:CancelScheduledEvent("sRaidFramesRangeCheck")
		self:ScheduleRepeatingEvent("sRaidFramesRangeCheck", self.RangeCheck, self.opt.RangeFrequency, self)
end

function sRaidFrames:UpdateUnit(units)
	for unit in pairs(units) do
		if self.visible[unit] and UnitExists(unit) then
			local f = self.frames[unit]

			local _, class = UnitClass(unit)
			if class then
				f.title:SetText(UnitName(unit))
				
				local color = RAID_CLASS_COLORS[class]
				f.title:SetTextColor(color.r, color.g, color.b, 1)
			else
				f.title:SetText(UnitName(unit) or L["Unknown"])
			end

			local feign = nil

			-- Silly hunters, why do you have to be so annoying
			if class == "HUNTER" then
				for i=1,32 do
					local texture = UnitBuff(unit, i)
					if not texture then break end
					if texture == "Interface\\Icons\\Ability_Rogue_FeignDeath" then
						feign = true
						break
					end
				end
			end

			if feign then
				f.hpbar.text:SetText("|cff00ff00"..L["Feign Death"].."|r")
				f.hpbar:SetValue(100)
				f.hpbar:SetStatusBarColor(0, 0.9, 0.5)
				f.mpbar:SetValue(0)
			else
				local status, dead, ghost = nil, UnitIsDead(unit), UnitIsGhost(unit)
				
				if not UnitIsConnected(unit) then status = "|cffff0000"..L["Offline"].."|r"
				elseif self.res[unit] == 1 and dead then status = "|cffff8c00"..L["Can Recover"].."|r"
				elseif self.res[unit] == 2 and (dead or ghost) then status = "|cffff8c00"..L["Resurrected"].."|r"
				elseif ghost then status = "|cffff0000"..L["Released"].."|r"
				elseif dead then status = "|cffff0000"..L["Dead"].."|r"
				end

				if status then
					self.unavail[unit] = true
					f.hpbar.text:SetText(status)
					f.hpbar:SetValue(0)
					f.mpbar.text:SetText()
					f.mpbar:SetValue(0)
					f:SetBackdropColor(0.3, 0.3, 0.3, 1)
				else
					self.unavail[unit] = false
					self.res[unit] = nil
					local hp = UnitHealth(unit) or 0
					local hpmax = UnitHealthMax(unit)
					local hpp = (hpmax ~= 0) and ceil((hp / hpmax) * 100) or 0
					local hptext, hpvalue = nil, nil

					if self.opt.healthDisplayType == "percent" then
						hptext = hpp .."%"
					elseif self.opt.healthDisplayType == "deficit" then
						hptext = (hp-hpmax) ~=  0 and (hp-hpmax) or nil
					elseif self.opt.healthDisplayType == "current" then
						hptext = hp
					elseif self.opt.healthDisplayType == "curmax" then
						hptext = hp .."/".. hpmax
					end
					
					if self.opt.Invert then
						hpvalue = 100 - hpp
					else
						hpvalue = hpp
					end

					f.hpbar.text:SetText(hptext)
					f.hpbar:SetValue(hpvalue)
					f.hpbar:SetStatusBarColor(self:GetHPSeverity(hpp/100))

					local mp = UnitMana(unit) or 0
					local mpmax = UnitManaMax(unit)
					local mpp = (mpmax ~= 0) and ceil((mp / mpmax) * 100) or 0

					local powerType = UnitPowerType(unit)
					if self.opt.PowerFilter[powerType] == false then
						f.mpbar:SetValue(0)
					else
						local color = self.ManaBarColor[powerType]
						f.mpbar:SetStatusBarColor(color.r, color.g, color.b)
						f.mpbar:SetValue(mpp)
					end
				end
			end
		end
	end
end

function sRaidFrames:UpdateBuffs(units)
	for unit in pairs(units) do
		if self.visible[unit] and UnitExists(unit) then
			local cAura = nil
			local f = self.frames[unit]

			for i = 1, 2 do
				f["aura".. i]:Hide()
			end

			for i = 1, 4 do
				f["buff".. i]:Hide()
			end

			local debuffSlots = 0
			for i=1,16 do
				local debuffTexture, debuffApplications, debuffType = UnitDebuff(unit, i, self.opt.ShowOnlyDispellable)
				if not debuffTexture then break end

				if debuffType ~= nil and self.debuffColors[debuffType] and ((cAura and cAura.priority < self.debuffColors[debuffType].priority) or not cAura) then
					cAura = self.debuffColors[debuffType]
				end

				if (self.opt.BuffType == "debuffs" or self.opt.BuffType == "buffsifnotdebuffed") and debuffSlots < 2 then
					debuffSlots = debuffSlots + 1
					local debuffFrame = f["aura".. debuffSlots]
					debuffFrame.unitid = unit
					debuffFrame.debuffid = i
					debuffFrame.showDispellable = self.opt.ShowOnlyDispellable
					debuffFrame.count:SetText(debuffApplications > 1 and debuffApplications or nil);
					debuffFrame.texture:SetTexture(debuffTexture)
					debuffFrame:Show()
				end
			end

			if cAura then
				f:SetBackdropColor(cAura.r, cAura.g, cAura.b, cAura.a);
			elseif not self.unavail[unit] then
				f:SetBackdropColor(self.opt.BackgroundColor.r, self.opt.BackgroundColor.g, self.opt.BackgroundColor.b, self.opt.BackgroundColor.a)
			end

			f.mpbar.text:SetText()

			for i=1,32 do
				local texture = UnitBuff(unit, i)
				if not texture then break end

				-- First we match the texture, then we pull the name of the debuff from a tooltip, and compare it to BabbleSpell
				-- The idea is that we do a simple string match, and only if that string match triggers something, then we do the extra check
				-- This should prevent unnessesary calls to functions and lookups
				if texture == "Interface\\Icons\\Spell_Nature_TimeStop" and self:GetBuffName(unit, i) == BS["Divine Intervention"] then
					f.hpbar.text:SetText("|cffff0000"..L["Intervened"].."|r")
				elseif texture == "Interface\\Icons\\Spell_Nature_Lightning" and self:GetBuffName(unit, i) == BS["Innervate"] then
					f.mpbar.text:SetText("|cff00ff00"..L["Innervating"].."|r")
				elseif texture == "Interface\\Icons\\Spell_Holy_GreaterHeal" and self:GetBuffName(unit, i) == BS["Spirit of Redemption"] then
					f.hpbar.text:SetText("|cffff0000"..L["Spirit"].."|r")
				elseif texture == "Interface\\Icons\\Ability_Warrior_ShieldWall" and self:GetBuffName(unit, i) == BS["Shield Wall"] then
					f.mpbar.text:SetText("|cffffffff"..BS["Shield Wall"].."|r")
				elseif texture == "Interface\\Icons\\Spell_Holy_AshesToAshes" and self:GetBuffName(unit, i) == BS["Last Stand"] then
					f.mpbar.text:SetText("|cffffffff"..BS["Last Stand"].."|r")
				elseif texture == "Interface\\Icons\\INV_Misc_Gem_Pearl_05" then
					f.mpbar.text:SetText("|cffffffff"..L["Gift of Life"].."|r")
				elseif texture == "Interface\\Icons\\Spell_Frost_Frost" and self:GetBuffName(unit, i) == BS["Ice Block"] then
					f.mpbar.text:SetText("|cffbfefff"..BS["Ice Block"].."|r")
				elseif texture == "Interface\\Icons\\Spell_Holy_SealOfProtection" and self:GetBuffName(unit, i) == BS["Blessing of Protection"] then
					f.mpbar.text:SetText("|cffffffff"..L["Protection"].."|r")
				elseif texture == "Interface\\Icons\\Spell_Holy_DivineIntervention" and self:GetBuffName(unit, i) == BS["Divine Shield"] then
					f.mpbar.text:SetText("|cffffffff"..BS["Divine Shield"].."|r")
				elseif texture == "Interface\\Icons\\Ability_Vanish" and self:GetBuffName(unit, i) == BS["Vanish"] then
					f.mpbar.text:SetText("|cffffffff"..L["Vanished"].."|r")
				elseif texture == "Interface\\Icons\\Ability_Stealth" and self:GetBuffName(unit, i) == BS["Stealth"] then
					f.mpbar.text:SetText("|cffffffff"..L["Stealthed"].."|r")
				elseif texture == "Interface\\Icons\\Spell_Holy_PowerInfusion" and self:GetBuffName(unit, i) == BS["Power Infusion"] then
					f.mpbar.text:SetText("|cffffffff"..L["Infused"].."|r")
				elseif texture == "Interface\\Icons\\Spell_Holy_Excorcism" and self:GetBuffName(unit, i) == BS["Fear Ward"] then
					f.mpbar.text:SetText("|cffffff00"..BS["Fear Ward"].."|r")
				elseif texture == "Interface\\Icons\\Spell_Holy_Renew" and self:GetBuffName(unit, i) == BS["Renew"] then
					f.mpbar.text:SetText("|cff00ff00"..BS["Renew"].."|r")
				elseif texture == "Interface\\Icons\\Spell_Shadow_Shadowform" and self:GetBuffName(unit, i) == BS["Shadowform"] then
					f.mpbar.text:SetText("|cff800080"..BS["Shadowform"].."|r")
				end
			end


			if self.opt.BuffType == "buffs" or (self.opt.BuffType == "buffsifnotdebuffed" and debuffSlots == 0) then
				local buffSlots = 0
				local showOnlyCastable = 1
				if next(self.opt.BuffFilter) then
					showOnlyCastable = 0
				end
				for i=1,32 do
					local buffTexture, buffApplications = UnitBuff(unit, i, showOnlyCastable)
					if not buffTexture then break end

					if showOnlyCastable == 1 or self.opt.BuffFilter[self:GetBuffName(unit, i)] then
						buffSlots = buffSlots + 1
						local buffFrame = f["buff".. buffSlots]
						buffFrame.buffid = i
						buffFrame.unitid = unit
						buffFrame.showCastable = showOnlyCastable
						buffFrame.count:SetText(buffApplications > 1 and buffApplications or nil)
						buffFrame.texture:SetTexture(buffTexture)
						buffFrame:Show()
					end

					if buffSlots == 4 then break end
				end
			end
		end
	end
end

function sRaidFrames:GetBuffName(unit, i)
	sRaidFramesTooltip:SetUnitBuff(unit, i)
  return sRaidFramesTooltipTextLeft1:GetText() or ""
end

function sRaidFrames:SetUnitBuffDuration(unit, buff)
	if not oRAOBuff or not oRAOBuff.UnitBuffsTables then return end
	local unitBuffs = oRAOBuff.UnitBuffsTables[UnitName(unit)]

	local endtime = unitBuffs[self:GetBuffName(unit, buff)]
	if endtime then
		local time = endtime - GetTime()
		if time > 0 then
			GameTooltip:AddLine("Time remaining: ".. SecondsToTimeAbbrev(time), 0.7, 0.7, 1)
			GameTooltip:Show()
		end
	end
end

function sRaidFrames:SetStatusText(type, frame, text, color)
	frame:SetText(text, color.r, color.g, color.b, color.a)
end

function sRaidFrames:SetStatusBorder(type, frame, color)
	if self.statusmaps[type] and self.statusstate[frame] and self.statusmaps[type].priority < self.statusstate[frame].priority then return end
	if not color.a then color.a = self.opt.BorderColor.a end
	
	frame:SetBackdropBorderColor(color.r, color.g, color.b, color.a)
	self.statusstate[frame] = self.statusmaps[type]
end

function sRaidFrames:UnsetStatusBorder(type, frame)
	if self.statusmaps[type] and self.statusstate[frame] and self.statusmaps[type].priority < self.statusstate[frame].priority then return end
	
	frame:SetBackdropBorderColor(self.opt.BorderColor.r, self.opt.BorderColor.g, self.opt.BorderColor.b, self.opt.BorderColor.a)
	self.statusstate[frame] = nil
end

function sRaidFrames:GetHPSeverity(percent)

	if (percent >= 0.5) then
		return (1.0-percent)*2, 1.0, 0.0
	else
		return 1.0, percent*2, 0.0
	end
end

function sRaidFrames:StartMovingAll()
	this.multidrag = 1
	local id = this:GetID()
	local fg = self.groupframes[id]
	local x, y = fg:GetLeft(), fg:GetTop()
	if ( not x or not y ) then
		return
	end
	for k, f in pairs(self.groupframes) do
		if k ~= id then
			local oX, oY = f:GetLeft(), f:GetTop()
			if ( oX and oY ) then
				f:ClearAllPoints()
				f:SetPoint("TOPLEFT", fg, "TOPLEFT", oX-x, oY-y)
			end
		end
	end
end

function sRaidFrames:StopMovingOrSizingAll()
	this.multidrag = nil
	local id = this:GetID()
	local fg = self.groupframes[id]
	for k, f in pairs(self.groupframes) do
		if k ~= id then
			local oX, oY = f:GetLeft(), f:GetTop()
			if ( oX and oY ) then
				f:ClearAllPoints()
				f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", oX, oY)
			end
		end
	end
end

function sRaidFrames:QueryTooltipDisplay(value)
	if value == "never" then
		return false
	elseif value == "notincombat" and UnitAffectingCombat("player") then
		return false
	else
		return true
	end
end

function sRaidFrames:UnitTooltip(frame)
	local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(frame.id);
	GameTooltip:SetOwner(frame)
	GameTooltip:AddDoubleLine(name, level, RAID_CLASS_COLORS[fileName].r, RAID_CLASS_COLORS[fileName].g, RAID_CLASS_COLORS[fileName].b, 1, 1, 1)
	GameTooltip:AddLine(UnitRace(frame.unit) .. " " .. class, 1, 1, 1);
	GameTooltip:AddDoubleLine(zone, "Group ".. subgroup, 1, 1, 1, 1, 1, 1);

	if oRAOCoolDown and oRAOCoolDown.db.profile.cooldowns and oRAOCoolDown.db.profile.cooldowns[name] and self.cooldownSpells[fileName] then
		GameTooltip:AddLine(" ")
		local expire = oRAOCoolDown.db.profile.cooldowns[name]-time()
		if expire > 0 then
  		GameTooltip:AddDoubleLine(self.cooldownSpells[fileName], SecondsToTime(expire), nil, nil, nil, 1, 0, 0)
  	else
  		GameTooltip:AddDoubleLine(self.cooldownSpells[fileName], "Ready!", nil, nil, nil, 0, 1, 0)
  	end
	end

	GameTooltip:Show()
end

function sRaidFrames:CreateUnitFrame(id)
	local f = CreateFrame("Button", "sRaidFrames_" .. id, self.master)
	f:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up")
	f:SetScript("OnClick", self.OnUnitClick)
	f:SetScript("OnEnter", function() if self:QueryTooltipDisplay(self.opt.UnitTooltipMethod) then self:UnitTooltip(this) end end)
	f:SetScript("OnLeave", function() GameTooltip:Hide() end)

	f.title = f:CreateFontString(nil, "ARTWORK")
	f.title:SetFontObject(GameFontNormalSmall)
	f.title:SetJustifyH("LEFT")

	f.aura1 = CreateFrame("Button", nil, f)
	f.aura1:SetScript("OnEnter", function() if self:QueryTooltipDisplay(self.opt.DebuffTooltipMethod) then GameTooltip:SetOwner(this) GameTooltip:SetUnitDebuff(this.unitid, this.debuffid, this.showDispellable) end end);
	f.aura1:SetScript("OnLeave", function() GameTooltip:Hide() end)
	f.aura1.texture = f.aura1:CreateTexture(nil, "ARTWORK")
	f.aura1.texture:SetAllPoints(f.aura1);
	f.aura1.count = f.aura1:CreateFontString(nil, "OVERLAY")
	f.aura1.count:SetFontObject(GameFontHighlightSmallOutline)
	f.aura1.count:SetJustifyH("CENTER")
	f.aura1.count:SetPoint("CENTER", f.aura1, "CENTER", 0, 0);
	f.aura1:Hide()

	f.aura2 = CreateFrame("Button", nil, f)
	f.aura2:SetScript("OnEnter", function() if self:QueryTooltipDisplay(self.opt.DebuffTooltipMethod) then GameTooltip:SetOwner(this) GameTooltip:SetUnitDebuff(this.unitid, this.debuffid, this.showDispellable) end end);
	f.aura2:SetScript("OnLeave", function() GameTooltip:Hide() end)
	f.aura2.texture = f.aura2:CreateTexture(nil, "ARTWORK")
	f.aura2.texture:SetAllPoints(f.aura2)
	f.aura2.count = f.aura2:CreateFontString(nil, "OVERLAY")
	f.aura2.count:SetFontObject(GameFontHighlightSmallOutline)
	f.aura2.count:SetJustifyH("CENTER")
	f.aura2.count:SetPoint("CENTER", f.aura2, "CENTER", 0, 0);
	f.aura2:Hide()

	f.buff1 = CreateFrame("Button", nil, f)
	f.buff1:SetScript("OnEnter", function() if self:QueryTooltipDisplay(self.opt.BuffTooltipMethod) then GameTooltip:SetOwner(this) GameTooltip:SetUnitBuff(this.unitid, this.buffid, this.showCastable) end end)
	f.buff1:SetScript("OnLeave", function() GameTooltip:Hide() end)
	f.buff1.texture = f.buff1:CreateTexture(nil, "ARTWORK")
	f.buff1.texture:SetAllPoints(f.buff1)
	f.buff1.count = f.buff1:CreateFontString(nil, "OVERLAY")
	f.buff1.count:SetFontObject(GameFontHighlightSmallOutline)
	f.buff1.count:SetJustifyH("CENTER")
	f.buff1.count:SetPoint("CENTER", f.buff1, "CENTER", 0, 0);
	f.buff1:Hide()

	f.buff2 = CreateFrame("Button", nil, f)
	f.buff2:SetScript("OnEnter", function() if self:QueryTooltipDisplay(self.opt.BuffTooltipMethod) then GameTooltip:SetOwner(this) GameTooltip:SetUnitBuff(this.unitid, this.buffid, this.showCastable) end end)
	f.buff2:SetScript("OnLeave", function() GameTooltip:Hide() end)
	f.buff2.texture = f.buff2:CreateTexture(nil, "ARTWORK")
	f.buff2.texture:SetAllPoints(f.buff2)
	f.buff2.count = f.buff2:CreateFontString(nil, "OVERLAY")
	f.buff2.count:SetFontObject(GameFontHighlightSmallOutline)
	f.buff2.count:SetJustifyH("CENTER")
	f.buff2.count:SetPoint("CENTER", f.buff2, "CENTER", 0, 0);
	f.buff2:Hide()

	f.buff3 = CreateFrame("Button", nil, f)
	f.buff3:SetScript("OnEnter", function() if self:QueryTooltipDisplay(self.opt.BuffTooltipMethod) then GameTooltip:SetOwner(this) GameTooltip:SetUnitBuff(this.unitid, this.buffid, this.showCastable) end end)
	f.buff3:SetScript("OnLeave", function() GameTooltip:Hide() end)
	f.buff3.texture = f.buff3:CreateTexture(nil, "ARTWORK")
	f.buff3.texture:SetAllPoints(f.buff3)
	f.buff3.count = f.buff3:CreateFontString(nil, "OVERLAY")
	f.buff3.count:SetFontObject(GameFontHighlightSmallOutline)
	f.buff3.count:SetJustifyH("CENTER")
	f.buff3.count:SetPoint("CENTER", f.buff3, "CENTER", 0, 0);
	f.buff3:Hide()

	f.buff4 = CreateFrame("Button", nil, f)
	f.buff4:SetScript("OnEnter", function() if self:QueryTooltipDisplay(self.opt.BuffTooltipMethod) then GameTooltip:SetOwner(this) GameTooltip:SetUnitBuff(this.unitid, this.buffid, this.showCastable) end end)
	f.buff4:SetScript("OnLeave", function() GameTooltip:Hide() end)
	f.buff4.texture = f.buff4:CreateTexture(nil, "ARTWORK")
	f.buff4.texture:SetAllPoints(f.buff4)
	f.buff4.count = f.buff4:CreateFontString(nil, "OVERLAY")
	f.buff4.count:SetFontObject(GameFontHighlightSmallOutline)
	f.buff4.count:SetJustifyH("CENTER")
	f.buff4.count:SetPoint("CENTER", f.buff4, "CENTER", 0, 0);
	f.buff4:Hide()

	f.hpbar = CreateFrame("StatusBar", nil, f)
	f.hpbar:SetStatusBarTexture(surface:Fetch(self.opt.Texture))
	f.hpbar:SetMinMaxValues(0,100)

	f.hpbar.texture = f.hpbar:CreateTexture(nil, "BORDER")
	f.hpbar.texture:SetTexture(surface:Fetch(self.opt.Texture))
	f.hpbar.texture:SetVertexColor(1, 0, 0, 0)

	f.hpbar.text = f.hpbar:CreateFontString(nil, "ARTWORK")
	f.hpbar.text:SetFontObject(GameFontHighlightSmall)
	f.hpbar.text:SetJustifyH("CENTER")

	f.mpbar = CreateFrame("StatusBar", nil, f)
	f.mpbar:SetStatusBarTexture(surface:Fetch(self.opt.Texture))
	f.mpbar:SetMinMaxValues(0,100)

	f.mpbar.texture = f.mpbar:CreateTexture(nil, "BORDER")
	f.mpbar.texture:SetTexture(surface:Fetch(self.opt.Texture))
	f.mpbar.texture:SetVertexColor(1, 0, 0, 0)

	f.mpbar.text = f.mpbar:CreateFontString(nil, "ARTWORK")
	f.mpbar.text:SetFontObject(GameFontHighlightSmall)
	f.mpbar.text:SetJustifyH("CENTER")

	f:SetID(id)
	f.id = id
	f.unit = "raid" .. id

	self:SetStyle(f)

	f:Hide();

	self.frames["raid"..id] = f
end


function sRaidFrames:CreateGroupFrame(id)
	local f = CreateFrame("Frame", "sRaidGroupFrames_" .. id, self.master)
	f:SetHeight(15)
	f:SetWidth(90)
	f:SetMovable(true)
	f:EnableMouse(true)
	f:SetScript("OnDragStart", function() if self.opt.lock then return end if IsAltKeyDown() then self:StartMovingAll() end f:StartMoving() end)
	f:SetScript("OnDragStop", function() if f.multidrag == 1 then self:StopMovingOrSizingAll() end f:StopMovingOrSizing() self:SavePosition() end)
	f:RegisterForDrag("LeftButton")
	f:SetParent(self.master)

	f.title = f:CreateFontString(nil, "ARTWORK")
	f.title:SetFontObject(GameFontNormalSmall)
	f.title:SetJustifyH("CENTER")
	f.title:SetText("Group ".. id);
	if not self.opt.ShowGroupTitles then
		f.title:Hide()
	end

	self:SetWHP(f.title, 80, f:GetHeight(), "TOPLEFT", f, "TOPLEFT",  0, 0)

	f:ClearAllPoints();
	f:SetPoint("LEFT", self.master, "LEFT")

	f:SetID(id)
	f.id = id
	f:Hide();

	self.groupframes[id] = f
end

function sRaidFrames:SetBackdrop(f)
	if self.opt.Border then
		f:SetBackdrop({ bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
										tile = true,
										tileSize = 16,
										edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
										edgeSize = 16,
										insets = { left = 5, right = 5, top = 5, bottom = 5 }
									})
	else
		f:SetBackdrop({ bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
										tile = true, tileSize = 16,
										insets = { left = 0, right = 0, top = 0, bottom = 0 }
									})
	end

	f:SetBackdropColor(self.opt.BackgroundColor.r, self.opt.BackgroundColor.g, self.opt.BackgroundColor.b, self.opt.BackgroundColor.a)
	f:SetBackdropBorderColor(self.opt.BorderColor.r, self.opt.BorderColor.g, self.opt.BorderColor.b, self.opt.BorderColor.a)
end

function sRaidFrames:SetStyle(f)
	self:SetWHP(f, 90, 40)
	self:SetWHP(f.title, 80, 16, "TOPLEFT", f, "TOPLEFT",  5, -4)
	self:SetWHP(f.aura1, 16, 16, "TOPRIGHT", f, "TOPRIGHT", -4, -4)
	self:SetWHP(f.aura2, 16, 16, "RIGHT", f.aura1, "LEFT", 0, 0)
	self:SetWHP(f.buff1, 12, 12, "TOPRIGHT", f, "TOPRIGHT", -4, -4)
	self:SetWHP(f.buff2, 12, 12, "RIGHT", f.buff1, "LEFT", 0, 0)
	self:SetWHP(f.buff3, 12, 12, "RIGHT", f.buff2, "LEFT", 0, 0)
	self:SetWHP(f.buff4, 12, 12, "RIGHT", f.buff3, "LEFT", 0, 0)
	self:SetWHP(f.hpbar, 80, 12, "TOPLEFT", f.title, "BOTTOMLEFT", 0, 0)
	self:SetWHP(f.mpbar, 80, 4, "TOPLEFT", f.hpbar, "BOTTOMLEFT", 0, 0)

	self:SetWHP(f.hpbar.text, f.hpbar:GetWidth(), f.hpbar:GetHeight(), "CENTER", f.hpbar, "CENTER", 0, 0)
	self:SetWHP(f.mpbar.text, f.mpbar:GetWidth(), f.mpbar:GetHeight(), "CENTER", f.mpbar, "CENTER", 0, 0)

	self:SetBackdrop(f)
end

function sRaidFrames:SetWHP(frame, width, height, p1, relative, p2, x, y)
	frame:SetWidth(width)
	frame:SetHeight(height)

	if (p1) then
		frame:ClearAllPoints()
		frame:SetPoint(p1, relative, p2, x, y)
	end
end

function sRaidFrames:Sort()
	local self = sRaidFrames
	local frameAssignments = {}
	local sort = {}
	local counter={0,0,0,0,0,0,0,0}

	for id = 1, MAX_RAID_MEMBERS do
		if self.visible["raid" .. id] then
			table.insert(sort, id)
		end
	end

	if self.opt.SubSort == "name" then
		table.sort(sort, function(a,b) return UnitName("raid" .. a) < UnitName("raid" ..b) end)
	elseif self.opt.SubSort == "class" then
		table.sort(sort, function(a,b) return UnitClass("raid" .. a) < UnitClass("raid" ..b) end)
	end

	if self.opt.SortBy == "class" then
		frameAssignments["WARRIOR"] = 1;
		frameAssignments["MAGE"] = 2;
		frameAssignments["PALADIN"] = 3;
		frameAssignments["SHAMAN"] = 3;
		frameAssignments["DRUID"] = 4;
		frameAssignments["HUNTER"] = 5;
		frameAssignments["ROGUE"] = 6;
		frameAssignments["WARLOCK"] = 7;
		frameAssignments["PRIEST"] = 8;

		self.groupframes[1].title:SetText(L["Warrior"]);
		self.groupframes[2].title:SetText(L["Mage"]);
		self.groupframes[3].title:SetText((UnitFactionGroup("player") == "Alliance") and L["Paladin"] or L["Shaman"]);
		self.groupframes[4].title:SetText(L["Druid"]);
		self.groupframes[5].title:SetText(L["Hunter"]);
		self.groupframes[6].title:SetText(L["Rogue"]);
		self.groupframes[7].title:SetText(L["Warlock"]);
		self.groupframes[8].title:SetText(L["Priest"]);
	elseif self.opt.SortBy == "group" then
		frameAssignments[1] = 1;
		frameAssignments[2] = 2;
		frameAssignments[3] = 3;
		frameAssignments[4] = 4;
		frameAssignments[5] = 5;
		frameAssignments[6] = 6;
		frameAssignments[7] = 7;
		frameAssignments[8] = 8;

		self.groupframes[1].title:SetText(L["Group 1"]);
		self.groupframes[2].title:SetText(L["Group 2"]);
		self.groupframes[3].title:SetText(L["Group 3"]);
		self.groupframes[4].title:SetText(L["Group 4"]);
		self.groupframes[5].title:SetText(L["Group 5"]);
		self.groupframes[6].title:SetText(L["Group 6"]);
		self.groupframes[7].title:SetText(L["Group 7"]);
		self.groupframes[8].title:SetText(L["Group 8"]);
	end

	-- -- -- Do the sorting -- -- --

	for _,id in pairs(sort) do
		local frameAssignee = nil
		if self.opt.SortBy == "class" then
			local _, eClass = UnitClass("raid"..id)
			if eClass then
				frameAssignee = frameAssignments[eClass]
			end
		elseif self.opt.SortBy == "group" then
			local name, _, subgroup = GetRaidRosterInfo(id)
			if name and subgroup then
				frameAssignee = frameAssignments[subgroup]
			end
		end

		if frameAssignee then
			local f = self.frames["raid" .. id]
			local groupframe = self.groupframes[frameAssignee]

			if self.opt.Growth == "up" then
				a1, a2, yMod, xMod = "BOTTOM", "TOP", (counter[frameAssignee]*(f:GetHeight()+self.opt.Spacing)), 0
			elseif self.opt.Growth == "right" then
				a1, a2, yMod, xMod = "TOP", "BOTTOM", 0, (counter[frameAssignee]*(f:GetWidth()+self.opt.Spacing))
			elseif self.opt.Growth == "left" then
				a1, a2, yMod, xMod = "TOP", "BOTTOM", 0, -1*(counter[frameAssignee]*(f:GetWidth()+self.opt.Spacing))
			else
				a1, a2, yMod, xMod = "TOP", "BOTTOM", -1*(counter[frameAssignee]*(f:GetHeight()+self.opt.Spacing)), 0
			end

			f:ClearAllPoints()
			f:SetPoint(a1, groupframe, a2, xMod, yMod)

			counter[frameAssignee] = counter[frameAssignee] + 1
			groupframe:Show()

			if self.opt.ShowGroupTitles then
				groupframe.title:Show()
			else
				groupframe.title:Hide()
			end
		end
	end

	-- Hide group frames which contain no children
	for k,v in pairs(counter) do
		if v == 0 then
			self.groupframes[k]:Hide()
		end
	end

	self:UpdateAll()
end

function sRaidFrames:OnUnitClick()
	local unitid, button = this.unit, arg1;

	if sRaidFramesCustomOnClickFunction and sRaidFramesCustomOnClickFunction(button, unitid) then
		return
	end

	if ( SpellIsTargeting() ) then
		SpellTargetUnit(unitid)
	else
		TargetUnit(unitid)
	end
end

function sRaidFrames:SetPosition()
	if not self.opt.Positions then
		self:ResetPosition()
	else
		self:RestorePosition()
	end
end

function sRaidFrames:SavePosition()
	local aryPos = {}
	local s = self.master:GetEffectiveScale()

	for k,f in pairs(self.groupframes) do
		aryPos[k] = {x = f:GetLeft()*s, y = f:GetTop()*s}
	end

	self:S("Positions", aryPos)
end

function sRaidFrames:RestorePosition()
	local aryPos = self.opt.Positions
	local s = self.master:GetEffectiveScale()

	for k, pos in pairs(aryPos) do
		local f = self.groupframes[k]
		f:ClearAllPoints()
		f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", pos["x"]/s, pos["y"]/s)
	end
end

function sRaidFrames:ResetPosition()
	self:PositionLayout("ctra", 200, -200)
end

function sRaidFrames:PositionLayout(layout, xBuffer, yBuffer)
	local xMod, yMod, i = 0, 0, -1
	local frameHeight = self.frames["raid1"]:GetHeight()+3

	for k,v in pairs(self.groupframes) do
		i = i + 1
		if layout == "horizontal" then
			yMod = (i) * v:GetWidth()
			xMod = 0
		elseif layout == "vertical" then
			if i ~= 0 and math_mod(i, 2) == 0 then
				xMod = xMod + (-1*MEMBERS_PER_RAID_GROUP*frameHeight)
				yMod = 0
				i = 0
			else
				yMod = i * v:GetWidth()
			end
		elseif layout == "ctra" then
			if i ~= 0 and math_mod(i, 2) == 0 then
				yMod = yMod + v:GetWidth()
				xMod = 0
				i = 0
			else
				xMod = i * (-1*MEMBERS_PER_RAID_GROUP*frameHeight)
			end
		end

		v:ClearAllPoints()
		v:SetPoint("TOPLEFT", UIParent, "TOPLEFT", xBuffer+yMod, yBuffer+xMod)
	end

	self:SavePosition()
end

local Tablet = AceLibrary("Tablet-2.0")
function sRaidFrames:OnTooltipUpdate()
	Tablet:SetHint(L["Right-click for options."])
end

function sRaidFrames:S(var, val)
	self.db.profile[var] = val
end
