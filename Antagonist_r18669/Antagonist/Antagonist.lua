--<< ====================================================================== >>--
-- Class Setup                                                                --
--<< ====================================================================== >>--
Antagonist = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0", "AceDebug-2.0", "CandyBar-2.0")
-- embedded libs
local BS = AceLibrary("Babble-Spell-2.2")
local L = AceLibrary("AceLocale-2.2"):new("Antagonist")
local deformat = AceLibrary("Deformat-2.0")

Antagonist.spells = {}

function Antagonist:OnInitialize()

	self.parser = ParserLib:GetInstance("1.1")

	local defaults = {
		fadeonkill = true,
		fadeonfade = true,
		fadeondeath = true,
		cdlimit = 60, 
		selfrelevant = false,
		positions = {},
		
		-- title
		titletext = {[1] = L["Casts"], [2] = L["Buffs"], [3] = L["Cooldowns"]},
		titlecolors = {[1] = {0.71,0.1,0}, [2] = {0,0.6,0}, [3] = {0.46,0.53,1}}, 
		titlesize = 18,
		-- group
		targetonly = {casts = true, buffs = true, cooldowns = true},
		enabled = {casts = true, buffs = true, cooldowns = true},
		showunder = {casts = 1, buffs = 2, cooldowns = 3},
		pattern = {casts = "$n : $s ($t)", buffs = "$n : $s", cooldowns = "$n : $s"},
		-- bar
		barscale = 1,
		barcolor = "group",
		barheight = 15,
		barwidth = 200,
		textsize = 10,
		texture = 1,
		reverse = {casts = false, buffs = false, cooldowns = false},
		growup = {[1] = false, [2] = false, [3] = false},
	}

	self:RegisterDB("AntagonistDB")
	self:RegisterDefaults('profile', defaults)
	self:RegisterOpts()

	-- init formating tables
	self.textures = {
		[1] = "Interface\\Addons\\Antagonist\\Textures\\banto", 
		[2] = "Interface\\Addons\\Antagonist\\Textures\\smooth",
		[3] = "Interface\\Addons\\Antagonist\\Textures\\perl",
		[4] = "Interface\\Addons\\Antagonist\\Textures\\glaze",
		[5] = "Interface\\Addons\\Antagonist\\Textures\\cilo",
		[6] = "Interface\\Addons\\Antagonist\\Textures\\Charcoal",
	}
	
	self.colors = {
		["casts"] = "red",
		["cooldowns"] = "blue",
		["buffs"] = "green",
	}

	-- create anchors
	self.anchors = {}
	self.titles = {}
	local yoff = 0
	for i=1, 3 do
		local titlecolors = self.db.profile.titlecolors[i]
		yoff = yoff - 50
		self.anchors[i] = self:CreateAnchor(i, titlecolors[1], titlecolors[2] , titlecolors[3], yoff)
		self.titles[i] = self:CreateTitle(self.db.profile.titletext[i], self.anchors[i], titlecolors[1], titlecolors[2] , titlecolors[3])

		self:RegisterCandyBarGroup("Antagonist-"..i)
		self:SetCandyBarGroupPoint("Antagonist-"..i, "TOP", self.anchors[i], "BOTTOM", 0, 0)
		self:SetCandyBarGroupGrowth("Antagonist-"..i, self.db.profile.growup[i]) 
	end
end

function Antagonist:OnEnable()
	-- init temp tables
	self.bars = {}
	self.temp = {}

	-- On-Death handling (should disable this when we turn off fadeondeath)
	self:RegisterEvent("PLAYER_DEAD")

	-- On-Kill handling (should disable these when we turn off fadeonkill)
	self.parser:RegisterEvent("Antagonist", "CHAT_MSG_COMBAT_FRIENDLY_DEATH", function (event, info) self:COMBAT_DEATH(event, info) end)
	self.parser:RegisterEvent("Antagonist", "CHAT_MSG_COMBAT_HOSTILE_DEATH",  function (event, info) self:COMBAT_DEATH(event, info) end)
	self.parser:RegisterEvent("Antagonist", "CHAT_MSG_COMBAT_XP_GAIN",        function (event, info) self:COMBAT_DEATH(event, info) end)	
		
	-- Casts/cooldowns handling
	self.parser:RegisterEvent("Antagonist", "CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF",	      function (event, info) self:PARSE_CASTS_HITS(event, info) end)
	self.parser:RegisterEvent("Antagonist", "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE",	      function (event, info) self:PARSE_CASTS_HITS(event, info) end)
	self.parser:RegisterEvent("Antagonist", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", function (event, info) self:PARSE_CASTS_HITS(event, info) end)
	self.parser:RegisterEvent("Antagonist", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF",   function (event, info) self:PARSE_CASTS_HITS(event, info) end)

	-- Buffs handling
	self.parser:RegisterEvent("Antagonist", "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS",function (event, info) self:PARSE_BUFFS(event, info) end)
	self.parser:RegisterEvent("Antagonist", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS",     function (event, info) self:PARSE_BUFFS(event, info) end)
	
	-- Interrupt handling
	self.parser:RegisterEvent("Antagonist", "CHAT_MSG_SPELL_SELF_DAMAGE",     function (event, info) self:SPELL_INTERRUPT(event, info) end)
	
	-- Dispel handling 
	self.parser:RegisterEvent("Antagonist", "CHAT_MSG_SPELL_BREAK_AURA",      function (event, info) self:SPELL_DISPEL(event, info) end)
	
	-- Spell fade handling (should be disabled when we turn off fadeonfade)
	self.parser:RegisterEvent("Antagonist", "CHAT_MSG_SPELL_AURA_GONE_OTHER", function (event, info) self:SPELL_FADE(event, info) end)

	-- Duel request
	self:RegisterEvent("DUEL_REQUESTED")
	-- Duel start
	self:RegisterEvent("CHAT_MSG_SYSTEM")
	-- Duel finish
	self:RegisterEvent("DUEL_FINISHED")
end

function Antagonist:OnDisable()
	self.parser:UnregisterAllEvents("Antagonist")
	self:KillAllBars()
	self.bars, self.temp, self.colors, self.textures = nil	
end
-- Runs test bars
function Antagonist:RunTest()
	for k in self.db.profile.enabled do
		local id = "Antagonist-Test"..k
		local time = math.random() * 8.0 + 2.0
		local icon = "Interface\\Icons\\Spell_Nature_Drowsy"
		local barcolor = self.colors[k]
		
		local anchor = self.db.profile.showunder[k]
		if self.db.profile.titletext[anchor] then self.titles[anchor]:Show() end
		
		self:RegisterCandyBar(id, time, L["TestBarText"], icon, barcolor, barcolor, barcolor, "red")
		self:SetCandyBarTexture(id, self.textures[self.db.profile.texture])
		self:SetCandyBarReversed(id, self.db.profile.reverse[k])
		self:SetCandyBarHeight(id, self.db.profile.barheight)
		self:SetCandyBarWidth(id, self.db.profile.barwidth)
		self:SetCandyBarFontSize(id, self.db.profile.textsize)
		self:SetCandyBarScale(id, self.db.profile.barscale)
		self:SetCandyBarCompletion(id, function(anchor) Antagonist:UpdateTitle(anchor) end, anchor)
		self:RegisterCandyBarWithGroup(id, "Antagonist-"..anchor)
		-- start this bitch!
		self:StartCandyBar(id, true)
	end
end
--<< ====================================================================== >>--
-- Event Parsing                                                              --
--<< ====================================================================== >>--

-- On-Death processing
function Antagonist:PLAYER_DEAD()
	if self.db.profile.fadeondeath then self:KillAllBars() end
end
-- On-Kill processing
function Antagonist:COMBAT_DEATH(event, info)
	if not self.db.profile.fadeonkill then return end
	if info.type == "experience" then
		if info.source then
			self:KillBars(info.source)
		end
	elseif info.victim ~= ParserLib_SELF then
		self:KillBars(info.victim)
	end
end
-- Casts/cooldowns processing
function Antagonist:PARSE_CASTS_HITS(event, info)
	if info.type == "cast" then
		if info.isBegin then
			self:ValidateInfo(info.source, info.skill, "casts")
		else
			self:ValidateInfo(info.source, info.skill, "cooldowns")
		end
	end
	if info.type == "hit" then
		self:ValidateInfo(info.source, info.skill, "cooldowns")
	end
end
-- Buff handling
function Antagonist:PARSE_BUFFS(event, info)
	if info.type == "buff" then
		self:ValidateInfo(info.victim, info.skill, "buffs")
	end
end
-- On-Fade processing
function Antagonist:SPELL_FADE(event, info)
	if not self.db.profile.fadeonfade then return end
	if info.type == "fade" then
		self:KillBar(info.victim, info.skill, "buffs")
	end
end
-- Interrupt handling
function Antagonist:SPELL_INTERRUPT(event, info)
	if info.type == "interrupt" then
		self:KillBar(info.victim, info.skill, "casts")
	end
end
-- Dispel handling
function Antagonist:SPELL_DISPEL(event, info)
	if info.type == "dispel" and not info.isFailed then
		self:KillBar(info.victim, info.skill, "buffs")
	end
end
-- Duel request
function Antagonist:DUEL_REQUESTED()
	self.temp.dueltarget = arg1
end
-- Duel started
function Antagonist:CHAT_MSG_SYSTEM()
	if string.find(arg1, DUEL_COUNTDOWN) then
		local count = deformat(arg1, DUEL_COUNTDOWN)
		if count == 1 then self.temp.isdueling = true end
	end
end
-- Duel finished
function Antagonist:DUEL_FINISHED()
	self.temp.isdueling, self.temp.dueltarget = nil
end
--<< ====================================================================== >>--
-- Parse Validation                                                           --
--<< ====================================================================== >>--
function Antagonist:ValidateInfo(unit, spell, group)
	if not self.db.profile.enabled[group] then return end
	
	if not self.spells[group][spell] then return end

	if self:IsFriendly(unit) then
		if not self.temp.isduelling then return end  -- stop when unit is friendly but youre not in a duel
		if self.temp.isduelling and unit ~= self.temp.dueltarget then return end -- stop when youre dueling but unit isnt the one youre dueling
	end

	if self.db.profile.targetonly[group] then
		if not UnitExists("target") then return
		elseif UnitName("target") ~= unit then return
		elseif UnitIsCorpse("target") then return end
	end
	
	if group == "casts" and self.db.profile.selfrelevant and self:GetTargetOfTarget() ~= UnitName("player") then return end

	if group ~= "cooldowns" and self.spells.cooldowns[spell] and self.db.profile.enabled.cooldowns then
		self:StartBar(unit, spell, "cooldowns")
	end
	if group ~= "buffs" and self.spells.buffs[spell] and self.db.profile.enabled.buffs then
		self:StartBar(unit, spell, "buffs")
	end
	-- checks time is over 0, no point starting a bar which is only meant to trigger a cooldown/buff
	if self.spells[group][spell][1] ~= 0 then
		self:StartBar(unit, spell, group)
	end
end

-- Blatantly stolen from WitchHunt, added a few things of mine own to it also  credit: Ammo 
function Antagonist:IsFriendly(name)
	local i,n,unit
	if name == UnitName("player") then
		return true
	end
	if name == UnitName("target") and UnitIsFriend("target", "player") then
		return true
	end
	if name == UnitName("pet") and UnitIsFriend("player", "pet") then
		return true
	end
	for i = 1, 4 do 
		unit = "party"..i
		if name == UnitName(unit) and UnitIsFriend("player", unit) then
			return true
		end
		unit = "partypet"..i
		if name == UnitName(unit) and UnitIsFriend("player", unit) then
			return true
		end			
	end
	n = GetNumRaidMembers()
	if n > 0 then
		for i = 1, n do
			unit = "raid"..i
			if name == UnitName(unit) and UnitIsFriend("player", unit) then
				return true
			end
			unit = "raidpet"..i
                        if name == UnitName(unit) and UnitIsFriend("player", unit) then
                                return true
			end
		end
	end
end
--<< ====================================================================== >>--
-- Timer Processing                                                           --
--<< ====================================================================== >>--
function Antagonist:StartBar(unit, spell, group)
	local id = "Antagonist-"..unit.."-"..spell.."-"..group
	local icon = self:GetSpellIcon(spell, group)
	
	local time = self.spells[group][spell][1]
	if group == "cooldowns" and time > self.db.profile.cdlimit then return end

	local barcolor 
	if self.db.profile.barcolor == "class"  then
		if self.spells[group][spell][2] == "general" then barcolor = "white" else barcolor = self.spells[group][spell][2] end
	elseif self.db.profile.barcolor == "school" then
		barcolor = self:GetSchoolColor(self.spells[group][spell][3])
	elseif self.db.profile.barcolor == "group" then
		barcolor = self.colors[group]
	end
	
	local target = " "
	if group == "casts" then target = self:GetTargetOfTarget() end 
	
	local text = self.db.profile.pattern[group]
	text = gsub(text, "$n", unit)
	text = gsub(text, "$s", spell)
	text = gsub(text, "$t", target)
	
	local anchor = self.db.profile.showunder[group]
	if self.db.profile.titletext[anchor] then self.titles[anchor]:Show() end
	
	self:RegisterCandyBar(id, time, text, icon, barcolor, barcolor, barcolor, "red")
	self:SetCandyBarTexture(id, self.textures[self.db.profile.texture])
	self:SetCandyBarReversed(id, self.db.profile.reverse[group])
	self:SetCandyBarHeight(id, self.db.profile.barheight)
	self:SetCandyBarWidth(id, self.db.profile.barwidth)
	self:SetCandyBarFontSize(id, self.db.profile.textsize)
	self:SetCandyBarScale(id, self.db.profile.barscale)
	self:SetCandyBarCompletion(id, function(unit,spell,group) self:BarEnd(unit,spell,group) end, unit,spell,group)
	self:RegisterCandyBarWithGroup(id, "Antagonist-"..anchor)
	-- start this bitch!
	self:StartCandyBar(id, true)

	if not self.bars[unit] then self.bars[unit] = {} end
	self.bars[unit][id] = {}
	self.bars[unit][id].spell = spell
	self.bars[unit][id].group = group
end
function Antagonist:BarEnd(unit,spell,group) 
	local anchor = self.db.profile.showunder[group]

	if self.bars[unit] then
		for i in self.bars[unit] do
			self.bars[unit]["Antagonist-"..unit.."-"..spell.."-"..group] = nil
			if not i then self.bars[unit] = nil break end
		end
	end

	self:UpdateTitle(anchor)
end

function Antagonist:GetSpellIcon(spell, group)
	if self.spells[group][spell][4] then
		return "Interface\\Icons\\"..self.spells[group][spell][4]
	else
		return BS:GetSpellIcon(spell)
	end
end
function Antagonist:GetSchoolColor(school)
	if not school then return end

	if school == "fire" then return "red"
	elseif school == "frost" then return "blue"
	elseif school == "nature" then return "green"
	elseif school == "shadow" then return "warlock"
	elseif school == "arcane" then return "white"
	elseif school == "holy" then return "yellow"
	elseif school == "physical" then return "druid"
	elseif school == "magic" then return "cyan"
	else return "white" end
end
function Antagonist:GetTargetOfTarget()
	if UnitExists("targettarget") then return UnitName("targettarget") end
	return " "
end
--<< ====================================================================== >>--
-- Bar Processing                                                             --
--<< ====================================================================== >>--
-- Kill the given bar
function Antagonist:KillBar(unit, spell, group)
	local id = "Antagonist-"..unit.."-"..spell.."-"..group
	if self:IsCandyBarRegistered(id) then
		self:StopCandyBar(id)
		self:UpdateTitle(self.db.profile.showunder[group])
		if  self.bars[unit] then self.bars[unit][id] = nil end
		for i in self.bars[unit] do
			if not i then self.bars[unit] = nil break end
		end
	end
end
-- Kill all bars from the given unit
function Antagonist:KillBars(unit)
	if not self.bars[unit] then return end
	for i in self.bars[unit] do
		self:StopCandyBar(i)
	end
	self.bars[unit] = nil

	self:UpdateTitle(1)
	self:UpdateTitle(2)
	self:UpdateTitle(3)
end
-- Kill all bars and subsequently hide all titles
function Antagonist:KillAllBars()
	for i in self.bars do
		for j in self.bars[i] do
			if self:IsCandyBarRegistered(j) then 
				self:StopCandyBar(j)
			end
		end
	end
	self.bars = {}
	for i in self.titles do
		self.titles[i]:Hide()
	end
end
--<< ====================================================================== >>--
-- Anchor Processing                                                          --
--<< ====================================================================== >>--

-- Toggles the anchor frames
function Antagonist:ToggleAnchors()
	if self.anchors[1]:IsVisible() then
		for k, v in self.anchors do
			v:Hide()
		end
	else
		for k, v in self.anchors do
			v:Show()
		end
	end
end

-- Creates the anchor frames
function Antagonist:CreateAnchor(id, cRed, cGreen, cBlue, yoff)
	local f = CreateFrame("Button", nil, UIParent)
	f:SetWidth(100)
	f:SetHeight(25)
	
	f.owner = self
	
	if not self.db.profile.positions[id] then self.db.profile.positions[id] = {} end

	if self.db.profile.positions[id].x and self.db.profile.positions[id].y then
		f:ClearAllPoints()
		f:SetPoint("TOPLEFT", UIParent, "TOPLEFT", self.db.profile.positions[id].x, self.db.profile.positions[id].y)
	else
		f:SetPoint("TOP", UIErrorsFrame, "BOTTOM", 0, yoff)
	end
	
	f:SetScript("OnDragStart", function() this:StartMoving() end )
	f:SetScript("OnDragStop",
		function()
			this:StopMovingOrSizing()
			local _, _, _, x, y = this:GetPoint()
			this.owner.db.profile.positions[id].x = math.floor(x)
			this.owner.db.profile.positions[id].y = math.floor(y)
        end)

	f:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                                            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                                            tile = false, tileSize = 16, edgeSize = 16,
                                            insets = { left = 5, right =5, top = 5, bottom = 5 }})
	f:SetBackdropColor(cRed,cGreen,cBlue,.6)
	f:SetMovable(true)
	f:RegisterForDrag("LeftButton")

	f.Text = f:CreateFontString(nil, "OVERLAY")
	f.Text:SetFontObject(GameFontNormalSmall)
	f.Text:ClearAllPoints()
	f.Text:SetTextColor(1, 1, 1, 1)
	f.Text:SetWidth(100)
	f.Text:SetHeight(25)
	f.Text:SetPoint("TOPLEFT", f, "TOPLEFT")
	f.Text:SetJustifyH("CENTER")
	f.Text:SetJustifyV("MIDDLE")
	f.Text:SetText("Antagonist : "..id)
	
	f:Hide()

	return f
end
--<< ====================================================================== >>--
-- Title processing                                                           --
--<< ====================================================================== >>--
function Antagonist:UpdateTitle(anchor)
	if not anchor then return end
	for i in self.bars do
		for j in self.bars[i] do
			if self:IsCandyBarRegisteredWithGroup(j, "Antagonist-"..anchor) then return end
		end
	end
	self.titles[anchor]:Hide()
end

function Antagonist:CreateTitle(text, pframe, cRed,cGreen,cBlue)
	local f = CreateFrame("Button",nil,UIParent)
	f:EnableMouse(false)
	f:ClearAllPoints()
	f:SetWidth(200)
	f:SetHeight(25)
	f:SetPoint("TOP", pframe, "TOP", 0,0)

	f.Text = f:CreateFontString(nil, "OVERLAY")
	f.Text:SetFont(L["Fonts\\skurri.ttf"], self.db.profile.titlesize, "OUTLINE")
	f.Text:ClearAllPoints()
	f.Text:SetTextColor(cRed,cGreen,cBlue, 1)
	f.Text:SetWidth(200)
	f.Text:SetHeight(25)
	f.Text:SetPoint("CENTER", f, "CENTER")
	f.Text:SetJustifyH("CENTER")
	f.Text:SetJustifyV("MIDDLE")
	if text ~= "nil" then	f.Text:SetText(text) end
	
	f:Hide()

	return f
end