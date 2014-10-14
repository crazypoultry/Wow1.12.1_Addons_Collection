local AceOO = AceLibrary("AceOO-2.0")
local SpellStatus = AceLibrary("SpellStatus-1.0")
local SpellCache = AceLibrary("SpellCache-1.0")

local CastBar = AceOO.Class(IceBarElement)


CastBar.Actions = { None = 0, Cast = 1, Channel = 2, Instant = 3, Success = 4, Failure = 5 }

CastBar.prototype.action = nil
CastBar.prototype.actionStartTime = nil
CastBar.prototype.actionMessage = nil



-- Constructor --
function CastBar.prototype:init()
	CastBar.super.prototype.init(self, "CastBar")

	self:SetDefaultColor("CastCasting", 242, 242, 10)
	self:SetDefaultColor("CastChanneling", 117, 113, 161)
	self:SetDefaultColor("CastSuccess", 242, 242, 70)
	self:SetDefaultColor("CastFail", 1, 0, 0)

	self.delay = 0
	self.action = CastBar.Actions.None
end



-- 'Public' methods -----------------------------------------------------------

-- OVERRIDE
function CastBar.prototype:GetDefaultSettings()
	local settings = CastBar.super.prototype.GetDefaultSettings(self)
	settings["side"] = IceCore.Side.Left
	settings["offset"] = 0
	settings["flashInstants"] = "Caster"
	settings["flashFailures"] = "Caster"
	return settings
end


-- OVERRIDE
function CastBar.prototype:GetOptions()
	local opts = CastBar.super.prototype.GetOptions(self)

	opts["flashInstants"] =
	{
		type = 'text',
		name =  "Flash Instant Spells",
		desc = "Defines when cast bar should flash on instant spells",
		get = function()
			return self.moduleSettings.flashInstants
		end,
		set = function(value)
			self.moduleSettings.flashInstants = value
		end,
		validate = { "Always", "Caster", "Never" },
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 40
	}

	opts["flashFailures"] =
	{
		type = "text",
		name = "Flash on Spell Failures",
		desc = "Defines when cast bar should flash on failed spells",
		get = function()
			return self.moduleSettings.flashFailures
		end,
		set = function(value)
			self.moduleSettings.flashFailures = value
		end,
		validate = { "Always", "Caster", "Never" },
		order = 41
	}

	return opts
end


function CastBar.prototype:Enable(core)
	CastBar.super.prototype.Enable(self, core)

	self:RegisterEvent("SpellStatus_SpellCastInstant")
	self:RegisterEvent("SpellStatus_SpellCastCastingStart")
	self:RegisterEvent("SpellStatus_SpellCastCastingChange")
	self:RegisterEvent("SpellStatus_SpellCastCastingFinish")
	self:RegisterEvent("SpellStatus_SpellCastFailure")

	self:RegisterEvent("SpellStatus_SpellCastChannelingStart")
	self:RegisterEvent("SpellStatus_SpellCastChannelingChange")
	self:RegisterEvent("SpellStatus_SpellCastChannelingFinish")

	self.frame:Hide()
	
	-- remove blizz cast bar
	CastingBarFrame:UnregisterAllEvents()
end


function CastBar.prototype:Disable(core)
	CastBar.super.prototype.Disable(self, core)
	
	-- restore blizz cast bar
	CastingBarFrame:RegisterEvent("SPELLCAST_START");
	CastingBarFrame:RegisterEvent("SPELLCAST_STOP");
	CastingBarFrame:RegisterEvent("SPELLCAST_FAILED");
	CastingBarFrame:RegisterEvent("SPELLCAST_INTERRUPTED");
	CastingBarFrame:RegisterEvent("SPELLCAST_DELAYED");
	CastingBarFrame:RegisterEvent("SPELLCAST_CHANNEL_START");
	CastingBarFrame:RegisterEvent("SPELLCAST_CHANNEL_UPDATE");
	CastingBarFrame:RegisterEvent("SPELLCAST_CHANNEL_STOP");
end



-- 'Protected' methods --------------------------------------------------------

-- OVERRIDE
function CastBar.prototype:CreateFrame()
	CastBar.super.prototype.CreateFrame(self)
	
	self.frame.bottomUpperText:SetWidth(self.settings.gap + 30)
end



-- OnUpdate handler
function CastBar.prototype:OnUpdate()
	-- safety catch
	if (self.action == CastBar.Actions.None) then
		IceHUD:Debug("Stopping action ", self.action)
		self:StopBar()
		return
	end

	local spellId, spellName, spellRank, spellFullName, spellCastStartTime, spellCastStopTime, spellCastDuration, spellAction = SpellStatus:GetActiveSpellData()
	local time = GetTime()

	self:Update()

	local spellRankShort = ""
	if (spellRank) then
		spellRankShort = " (" .. SpellCache:GetRankNumber(spellRank or '') .. ")"
	end

	-- handle casting and channeling
	if (SpellStatus:IsCastingOrChanneling()) then
		local remainingTime = spellCastStopTime - time
		local scale = 1 - (remainingTime / (spellCastDuration/1000))

		if (SpellStatus:IsChanneling()) then
			scale = remainingTime / spellCastDuration
		end

		if (remainingTime < 0 and remainingTime > -1.5) then -- lag compensation
			remainingTime = 0
		end
		
		-- sanity check to make sure the bar doesn't over/underfill
		scale = scale > 1 and 1 or scale
		scale = scale < 0 and 0 or scale

		self:UpdateBar(scale, "CastCasting")
		self:SetBottomText1(string.format("%.1fs %s%s", remainingTime , spellName, spellRankShort))

		return
	end


	-- stop bar if casting or channeling is done (in theory this should not be needed)
	if (self.action == CastBar.Actions.Cast or self.action == CastBar.Actions.Channel) then
		self:StopBar()
		return
	end


	-- handle instant casts
	if (self.action == CastBar.Actions.Instant) then
		local instanting = time - self.actionStartTime

		if (instanting > 1) then
			self:StopBar()
			return
		end

		self:FlashBar("CastSuccess", 1-instanting, (spellName or '') .. spellRankShort)
		return
	end


	-- show failure bar
	if (self.action == CastBar.Actions.Fail) then
		local failing = time - self.actionStartTime

		if (failing > 1) then
			self:StopBar()
			return
		end

		self:FlashBar("CastFail", 1-failing, self.actionMessage, "CastFail")
		return
	end


	-- flash bar on succesful casts
	if (self.action == CastBar.Actions.Success) then
		local succeeding = time - self.actionStartTime

		if (succeeding > 1) then
			self:StopBar()
			return
		end
		if (succeeding < 0.15) then -- lag compensation
			return
		end

		self:FlashBar("CastSuccess", 1-succeeding)
		return
	end
	
	IceHUD:Debug("OnUpdate error ", self.action, " -- ", spellId, spellName, spellRank, spellFullName, spellCastStartTime, spellCastStopTime, spellCastDuration, spellAction)
end


function CastBar.prototype:FlashBar(color, alpha, text, textColor)
	self.frame:SetAlpha(alpha)

	local r, g, b = self.settings.backgroundColor.r, self.settings.backgroundColor.g, self.settings.backgroundColor.b
	if (self.settings.backgroundToggle) then
		r, g, b = self:GetColor(color)
	end


	self.frame:SetStatusBarColor(r, g, b, 0.3)
	self.barFrame:SetStatusBarColor(self:GetColor(color, 0.8))

	self:SetScale(self.barFrame.bar, 1)
	self:SetBottomText1(text, textColor or "Text")
end


function CastBar.prototype:StartBar(action, message)
	self.action = action
	self.actionStartTime = GetTime()
	self.actionMessage = message

	self.frame:Show()
	self.frame:SetScript("OnUpdate", function() self:OnUpdate() end)
end


function CastBar.prototype:StopBar()
	self.action = CastBar.Actions.None
	self.actionStartTime = nil

	self.frame:Hide()
	self.frame:SetScript("OnUpdate", nil)
end




-------------------------------------------------------------------------------
-- INSTANT SPELLS                                                            --
-------------------------------------------------------------------------------

function CastBar.prototype:SpellStatus_SpellCastInstant(sId, sName, sRank, sFullName, sCastTime)
	IceHUD:Debug("SpellStatus_SpellCastInstant", sId, sName, sRank, sFullName, sCastTime)

	-- determine if we want to show instant casts
	if (self.moduleSettings.flashInstants == "Never") then
		return
	elseif (self.moduleSettings.flashInstants == "Caster") then
		if (UnitPowerType("player") ~= 0) then -- 0 == mana user
			return
		end
	end

	self:StartBar(CastBar.Actions.Instant)
end



-------------------------------------------------------------------------------
-- NORMAL SPELLS                                                             --
-------------------------------------------------------------------------------

function CastBar.prototype:SpellStatus_SpellCastCastingStart(sId, sName, sRank, sFullName, sCastStartTime, sCastStopTime, sCastDuration)
	IceHUD:Debug("SpellStatus_SpellCastCastingStart", sId, sName, sRank, sFullName, sCastStartTime, sCastStopTime, sCastDuration)
	self:StartBar(CastBar.Actions.Cast)
end

function CastBar.prototype:SpellStatus_SpellCastCastingFinish (sId, sName, sRank, sFullName, sCastStartTime, sCastStopTime, sCastDuration, sCastDelayTotal)
	IceHUD:Debug("SpellStatus_SpellCastCastingFinish ", sId, sName, sRank, sFullName, sCastStartTime, sCastStopTime, sCastDuration, sCastDelayTotal)
	self:StartBar(CastBar.Actions.Success)
end

function CastBar.prototype:SpellStatus_SpellCastFailure(sId, sName, sRank, sFullName, isActiveSpell, UIEM_Message, CMSFLP_SpellName, CMSFLP_Message)
	IceHUD:Debug("SpellStatus_SpellCastFailure", sId, sName, sRank, sFullName, isActiveSpell, UIEM_Message, CMSFLP_SpellName, CMSFLP_Message)
	
	-- do nothing if we are casting a spell but the error doesn't consern that spell
	if (SpellStatus:IsCastingOrChanneling() and not SpellStatus:IsActiveSpell(sId, sName)) then
		return
	end


	-- determine if we want to show failed casts
	if (self.moduleSettings.flashFailures == "Never") then
		return
	elseif (self.moduleSettings.flashFailures == "Caster") then
		if (UnitPowerType("player") ~= 0) then -- 0 == mana user
			return
		end
	end
	

	self:StartBar(CastBar.Actions.Fail, UIEM_Message)
end

function CastBar.prototype:SpellStatus_SpellCastCastingChange(sId, sName, sRank, sFullName, sCastStartTime, sCastStopTime, sCastDuration, sCastDelay, sCastDelayTotal)
	IceHUD:Debug("SpellStatus_SpellCastCastingChange", sId, sName, sRank, sFullName, sCastStartTime, sCastStopTime, sCastDuration, sCastDelay, sCastDelayTotal)
end



-------------------------------------------------------------------------------
-- CHANNELING SPELLS                                                         --
-------------------------------------------------------------------------------

function CastBar.prototype:SpellStatus_SpellCastChannelingStart(sId, sName, sRank, sFullName, sCastStartTime, sCastStopTime, sCastDuration, sAction)
	IceHUD:Debug("SpellStatus_SpellCastChannelingStart", sId, sName, sRank, sFullName, sCastStartTime, sCastStopTime, sCastDuration, sAction)
	self:StartBar(CastBar.Actions.Channel)
end

function CastBar.prototype:SpellStatus_SpellCastChannelingFinish(sId, sName, sRank, sFullName, sCastStartTime, sCastStopTime, sCastDuration, sAction, sCastDisruptionTotal)
	IceHUD:Debug("SpellStatus_SpellCastChannelingFinish", sId, sName, sRank, sFullName, sCastStartTime, sCastStopTime, sCastDuration, sAction, sCastDisruptionTotal)
	self:StopBar()
end

function CastBar.prototype:SpellStatus_SpellCastChannelingChange(sId, sName, sRank, sFullName, sCastStartTime, sCastStopTime, sCastDuration, sAction, sCastDisruption, sCastDisruptionTotal)
	IceHUD:Debug("SpellStatus_SpellCastChannelingChange", sId, sName, sRank, sFullName, sCastStartTime, sCastStopTime, sCastDuration, sAction, sCastDisruption, sCastDisruptionTotal)
end




-------------------------------------------------------------------------------


-- Load us up
CastBar:new()
