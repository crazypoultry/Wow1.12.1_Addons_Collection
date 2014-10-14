local BubbleSpells = {
    ["Arcane Bubble"] = true,           -- Staff Vendor Doan in SM
    ["Anti-Magic Shield"] = true,       -- Zul'Gurub Priests / Wailing Banshees in Strat
    ["Divine Protection"] = true,       -- Alliance Annoyances
    ["Divine Shield"] = true,           -- Alliance Annoyances
    ["Blessing of Protection"] = true,  -- Alliance Annoyances
    ["Avatar of Flame"] = true,         -- Emperor Dagran Thaurissan in BRD
}

tcgMR = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceHook-2.0", "AceDB-2.0")
tcgMR:RegisterDB("tcgMobResistsDB")

local compost = AceLibrary("Compost-2.0")
local crayon = AceLibrary("Crayon-2.0")
local roster = AceLibrary("RosterLib-2.0")
local parser = ParserLib:GetInstance("1.1")

if (AceLibrary:HasInstance("AceDebug-2.0")) then AceLibrary("AceDebug-2.0"):embed(tcgMR) end

local spellelements = {
    ["Shadow Bolt"]     = "Shadow",
    ["Searing Pain"]    = "Fire",
    ["Fire Blast"]      = "Fire",
    ["Moonfire"]        = "Arcane",
    ["Wrath"]           = "Nature",
    ["Scorch"]          = "Fire",
    ["Fireball"]        = "Fire",
    ["Frostbolt"]       = "Frost",
    ["Arcane Missiles"] = "Arcane",
    ["Frost Nova"]      = "Frost",
    ["Blizzard"]        = "Frost",
    ["Rain of Fire"]    = "Fire",
}

local colors = {
	["Nature"]			= "|cff00FF00  Nature|r",
	["Fire"]			= "|cffFF0000  Fire|r",
	["Arcane"]			= "|cff0000FF  Arcane|r",
	["Frost"]			= "|cffB0B0FF  Frost|r",
	["Shadow"]			= "|cffAAAAAA  Shadow|r",
}

local options = {
    type = "group",
    args = {
        ctrl_key = {
            type = "toggle",
            get  = function() return tcgMR.db.profile.needCtrlKeyDown end,
            set  = function(v) tcgMR.db.profile.needCtrlKeyDown = v end,
            name = "CtrlKey",
            desc = "Require Ctrl-Key for tooltip display",
        },
        alt_key = {
            type = "toggle",
            get  = function() return tcgMR.db.profile.needAltKeyDown end,
            set  = function(v) tcgMR.db.profile.needAltKeyDown = v end,
            name = "AltKey",
            desc = "Require Alt-Key for tooltip display",
        },
    },
}

local spellamounts = {}
function tcgMR_DumpAmounts() DevTools_Dump(spellamounts) end

local dispatch = {
    ["buff"] = "BuffEvent",
    ["hit"] = "HitEvent",
    ["miss"] = "MissEvent",
    ["cast"] = "CastEvent",
}

if (not tcgMR.Debug) then
    function tcgMR:Debug(...)
        if (self.debug) then
            self:Print(unpack(arg))
        end
    end
end

function tcgMR:OnInitialize()
    local f = function(e, d)
		if (d.element and not colors[d.element]) then return end
		if (dispatch[d.type]) then
			return self[ dispatch[d.type] ](self, e, d)
		end
	end

    parser:RegisterEvent("tcgMR", "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE", f);
    parser:RegisterEvent("tcgMR", "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE", f)
    parser:RegisterEvent("tcgMR", "CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE", f)
    parser:RegisterEvent("tcgMR", "CHAT_MSG_SPELL_PARTY_DAMAGE", f)
    parser:RegisterEvent("tcgMR", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", f)
    parser:RegisterEvent("tcgMR", "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE", f)
    parser:RegisterEvent("tcgMR", "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE", f)
    parser:RegisterEvent("tcgMR", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", f)
    parser:RegisterEvent("tcgMR", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", f)
    parser:RegisterEvent("tcgMR", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", f);
    parser:RegisterEvent("tcgMR", "CHAT_MSG_SPELL_PET_DAMAGE", f)
    parser:RegisterEvent("tcgMR", "CHAT_MSG_SPELL_SELF_DAMAGE", f);

	self.name = "tcgMobResists"
    self.data = self.db.account

    self:Hook(GameTooltip, "SetUnit")
	self:HookScript(GameTooltip, "OnShow")

    self:RegisterChatCommand({"/tcgmr"}, options)

    self:ValidateData()

    self:Print("Initialized.")
end

function tcgMR:OnShow(this, a2, a3, a4, a5, a6, a7, a9, a10)
	self:Debug("GameTooltip[OnShow]()")
	self.hooks[this]["OnShow"](this, a2, a3, a4, a5, a6, a7, a8, a9, a10)
	if (UnitExists("mouseover")) then self:UpdateTooltip("mouseover") end
end

function tcgMR:SetUnit(this, unit, a3, a4, a5, a6, a7, a8, a9, a10)
	self:Debug("GameTooltip_SetUnit(%s)", unit)
    self.hooks[this]["SetUnit"](this, unit, a3, a4, a5, a6, a7, a8, a9, a10)
    self:UpdateTooltip(unit)
end

function tcgMR:CastEvent(event, data)
    if (not data.isBegin) then return end
    if (roster:GetUnitIDFromName(data.source)) then return end
    
    --[[
    cast

    note that this includes "cast" and"perform".

    * Doggy casts Growl on Mirefin Oracle.

    * source : "Doggy"
    * skill : "Growl"
    * @victim : "Mirefin Oracle"
    * isBegin : nil <- only one will exist between isBegin and victim.
    * isPerform : nil

    * Rophy performs Opening on Onyxia's Gate.

    * source : "Rophy"
    * skill : "Opening"
    * @victim : "Onyxia's Gate"
    * isBegin : nil
    * isPerform : true

    * Stormpike Mountaineer begins to perform Shoot.

    * source : "Stormpike Mountaineer"
    * skill : "Shoot"
    * @victim : nil
    * isBegin : true
    * isPerform : true

    ]]--
    self:CheckIfBubble(data.source, data.skill)
end

function tcgMR:BuffEvent(event, data)
    --[[
    * Rophy gains Power Word: Shield.

    * victim : "Rophy"
    * skill : "Power Word: Shield"
    * @amountRank : nil

    ]]--
    self:CheckIfBubble(data.source, data.skill)
end

function tcgMR:CheckIfBubble(source, spell)
    if (not spell or not source) then return end
    if (roster:GetUnitIDFromName(source)) then return end
    if (BubbleSpells[spell]) then
        self.delayed = time() + 45
        self:Print("%s has gained %s (invulnerable to effects), suspending IMMUNE recording for 45 seconds.", source, spell)
        -- Should we check for fade instead of using a fixed timer?
    end
end

function tcgMR:MissEvent(event, data)
    --[[
    Including miss, dodge, block, deflect, immune, evade, parry, resist, reflect,absorb.

    * Warrior's Overpower was parried by Flamewaker.

    * source : "Warrior"
    * victim : "Flamewaker"
    * skill : "Overpower"
    * missType : "parry" (This is a fixed string, not parsed)

    ]]--
    if (spellelements[data.skill]) then
        if (self.delayed and self.delayed >= time()) then return end    -- victim has bubble spell up, dont record
        if (data.missType == "immune") then
            self:UpdateData(data.source, data.victim, spellelements[data.skill], false)
        elseif (data.missType == "resist" and spellamounts[data.source] and spellamounts[data.source][data.skill]) then
            self:Debug("Full resist of %s on %s (0/%d)", data.skill, data.victim, spellamounts[data.source][data.skill])
            self:UpdateData(data.source, data.victim, spellelements[data.skill], 0, spellamounts[data.source][data.skill])
        end
    end
end

function tcgMR:HitEvent(event, data)
    --[[
    * Your Shadow Bolt crits Pig for 50 shadow damage. (30 resisted)

    * source : ParserLib_SELF
    * victim : "Pig"
    * skill : "Shadow Bolt"
    * amount : 50
    * @element : "shadow"
    * isCrit : true
    * isDOT : false
    * isCrushing : false
    * isGlancing : false
    * @amountAbsorb : nil
    * @amountBlock : nil
    * @amountResist : 30
    * @amountVulnerable : nil
    ]]--

    if (data.element and not spellelements[data.skill]) then
        self:Debug("[%s] school is [%s]", data.skill, data.element)
        spellelements[data.skill] = data.element
    end

	if (spellelements[data.skill]) then
		if (not data.ammountResist) then
			if (not spellamounts[data.source]) then spellamounts[data.source] = {} end
			if (not spellamounts[data.source][data.skill]) then spellamounts[data.source][data.skill] = 0 end

			spellamounts[data.source][data.skill] = (spellamounts[data.source][data.skill] + data.amount + (data.amountResist or 0)) / 2
		end
		self:UpdateData(data.source, data.victim, spellelements[data.skill], data.amount, data.amountResist)
	end
end

function tcgMR:UpdateData(source, victim, element, amount, resisted)
	if (tonumber(source) == ParserLib_SELF) then source = UnitName("player") end
	if (tonumber(victim) == ParserLib_SELF) then victim = UnitName("player") end

	if (roster:GetUnitIDFromName(victim)) then return end

	local zone = GetZoneText()
	if (not self.data[zone]) then self.data[zone] = {} end
	if (self.data[zone][victim]) then
		if (type(self.data[zone][victim]) ~= "table") then self:ExpandData(zone, victim) end
	else
		self.data[zone][victim] = {}
	end
	if (not self.data[zone][victim][element]) then self.data[zone][victim][element] = { r = 0, t = 0 } end

	local t = self.data[zone][victim][element]
	if (amount == false) then
		t.t = -1
		t.r = -1
	else
		if (t.t == -1) then
			self:Print("%s was marked as immune to %s, but is now taking %s damage. Removing immunity.", victim, element, element)
			t.t = amount
			t.r = resisted or 0
		else
			t.r = (t.r or 0) + (resisted or 0)
			t.t = (t.t or 0) + amount
		end
	end
end

function tcgMR:ValidateData()
	self:Print("Validating saved data.")
	for zone, zdata in pairs(self.data) do
		for mob, mdata in pairs(zdata) do
			local t = {
				["Fire"] = true, ["Frost"] = true, ["Arcane"] = true, ["Shadow"] = true, ["Nature"] = true,
			}
			if (type(mdata) == "table") then
				for s, sdata in pairs(mdata) do
					if (sdata.i) then
						self:Print(string.format("Switched %s in %s to IMMUNE format for %s", mob, zone, s))
						sdata.t = -1
						sdata.r = -1
						sdata.i = nil
					end
					t[s] = nil
				end
				for s, _ in pairs(t) do
					self:Print(string.format("Added missing data to %s in %s for %s", mob, zone, s))
					mdata[s] = { t = 0, r = 0 }
				end
			end
			if (string.sub(mob, -6) == " Totem") then
				self:Print("Removing: %s", mob)
				zdata[mob] = nil
			end
		end
		self:CompressData(zone)
	end
end

function tcgMR:ExpandData(zone, name)
	if (not self.data[zone] or not self.data[zone][name]) then return end
	if (type(self.data[zone][name]) == "table") then return end

	-- Expand the data
	local t = compost:Acquire()
	local _, _, st, sr, ft, fr, nt, nr, it, ir, at, ar = string.find(self.data[zone][name], "(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%d+)")
	t["Shadow"] = compost:AcquireHash("t", st, "r", sr)
	t["Fire"]   = compost:AcquireHash("t", ft, "r", fr)
	t["Frost"]  = compost:AcquireHash("t", it, "r", ir)
	t["Arcane"] = compost:AcquireHash("t", at, "r", ar)
	t["Nature"] = compost:AcquireHash("t", nt, "r", nr)

	for k, v in pairs(t) do
		for t, d in pairs(v) do
			if (t ~= "i") then v[t] = tonumber(d) or 0 end
		end
	end

	self.data[zone][name] = t
end

function tcgMR:CompressData(zone)
	if (not self.data[zone]) then return end

	for mob, data in pairs(self.data[zone]) do
		if (type(data) == "table") then
			local t = self.data[zone][name]
			local compressed = string.format("%d:%d:%d:%d:%d:%d:%d:%d:%d:%d", data["Shadow"] and data["Shadow"].t or 0, data["Shadow"] and data["Shadow"].r or 0, data["Fire"] and data["Fire"].t or 0, data["Fire"] and data["Fire"].r or 0, data["Nature"] and data["Nature"].t or 0, data["Nature"] and data["Nature"].r or 0, data["Frost"] and data["Frost"].t or 0, data["Frost"] and data["Frost"].r or 0, data["Arcane"] and data["Arcane"].t or 0, data["Arcane"] and data["Arcane"].r or 0)

			compost:Reclaim(data, 3)
			self.data[zone][mob] = compressed
		end
	end
end

local last_name
local last_time
function tcgMR:UpdateTooltip(unit, unitName)
	if (self.db.profile.needAltKeyDown and not IsAltKeyDown()) then return end
	if (self.db.profile.needCtrlKeyDown and not IsControlKeyDown()) then return end

	local zone = GetZoneText()
	local name = unit and UnitName(unit) or unitName

    if (last_name and (last_name == name and last_time >= time())) then
        self:Debug("UpdateTooltip() called more than once for %s in a 5 second span...", name)
        return
    end

	if (not self.data[zone] or not self.data[zone][name]) then return end

	if (type(self.data[zone][name]) ~= "table") then self:ExpandData(zone, name) end

	local didHeader
	-- self:Debug("Updating Tooltip")
	for element, data in pairs(self.data[zone][name]) do
		if (data.t == -1) then
			GameTooltip:AddDoubleLine(colors[element], crayon:Red("IMMUNE"))
			-- self:Debug("%s: IMMUNE", element)
		elseif (data.t > 0 or data.r > 0) then
			local total = data.t + data.r
			local pct	= 100 - ((data.r / total) * 100)
			if (not didHeader) then
				GameTooltip:AddLine(crayon:Green("\n<Mob Resists>"))
				didHeader = true
			end
			-- self:Debug("%s: %d/%d (%d%%)", element, data.t, total, pct)
			GameTooltip:AddDoubleLine(colors[element], string.format("%d/%d (|cff%s%.2f%%|r)", data.t, total, crayon:GetThresholdHexColor(pct, 50, 75, 90, 95, 97.5), pct))
		end
	end

	GameTooltip:Show()

    last_name = name
    last_time = time() + 5
end

if (WOWB_VER) then
	tcgMR.debug = true
	if (tcgMR.SetDebugging) then tcgMR:SetDebugging(true) end
	IsControlKeyDown = function() return true end
end
