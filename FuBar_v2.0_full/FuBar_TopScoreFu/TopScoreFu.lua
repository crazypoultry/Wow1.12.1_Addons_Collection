local compost = AceLibrary("Compost-2.0")
local deformat = AceLibrary("Deformat-2.0")
local S = AceLibrary("Babble-Spell-2.0")
local babbleClass = AceLibrary("Babble-Class-2.0")
local tablet = AceLibrary("Tablet-2.0")
local dewdrop = AceLibrary("Dewdrop-2.0")
local L = AceLibrary("AceLocale-2.0"):new("TopScoreFu")

TopScoreFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceDB-2.0", "AceEvent-2.0", "AceConsole-2.0")
TopScoreFu.hasIcon = true
TopScoreFu.canHideText = true
TopScoreFu:RegisterDB("TopScoreFuDB", "TopScoreFuPCDB")
TopScoreFu:RegisterDefaults('profile', {
	splash = true,
	noise = true,
	screenshot = false,
	includeHeals = true,
	includeDamage = true,
	onlyPvP = false,
	showTrivial = false,
	posX = 0,
	posY = 0,
	filters = {}
})
TopScoreFu:RegisterDefaults('char', {
	hits = {}
})
TopScoreFu:RegisterChatCommand(L["COMMANDS"], {
	desc = L["DESCRIPTION"],
	type = "group",
	args = {},
})

function TopScoreFu:SetPosition(text)
	local _,_,x,y = string.find(text, "(%-?%d+),? (%-?%d+)")
	x, y = tonumber(x), tonumber(y)
	if x == nil or y == nil then
		self.cmd:msg(L["TEXT_SET_POSITION_ERROR"])
	else
		self.db.profile.posX = x
		self.db.profile.posY = y
		TopScoreFuSplash:ClearAllPoints()
		TopScoreFuSplash:SetPoint("CENTER", UIParent, "CENTER", self.db.profile.posX, self.db.profile.posY)
		self.cmd:msg(L["PATTERN_SET_POSITION"], x, y)
	end
end

function TopScoreFu:ResetScores()
	compost:Erase(self.db.char.hits)
	self:Update()
end

function TopScoreFu:ToggleShowingSplash()
	self.db.profile.splash = not self.db.profile.splash
	return self.db.profile.splash
end

function TopScoreFu:ToggleShowingTrivial()
	self.db.profile.showTrivial = not self.db.profile.showTrivial
	self:Update()
	return self.db.profile.showTrivial
end

function TopScoreFu:TogglePlayingNoise()
	self.db.profile.noise = not self.db.profile.noise
	return self.db.profile.noise
end

function TopScoreFu:ToggleTakingScreenshots(loud)
	self.db.profile.screenshot = not self.db.profile.screenshot
	return self.db.profile.screenshot
end

function TopScoreFu:ToggleIncludingHeals()
	self.db.profile.includeHeals = not self.db.profile.includeHeals
	self:Update()
	return self.db.profile.includeHeals
end

function TopScoreFu:ToggleIncludingDamage()
	self.db.profile.includeDamage = not self.db.profile.includeDamage
	self:Update()
	return self.db.profile.includeDamage
end

function TopScoreFu:ToggleOnlyPvP()
	self.db.profile.onlyPvP = not self.db.profile.onlyPvP
	self:Update()
	return self.db.profile.onlyPvP
end

function TopScoreFu:IsFiltering(spell)
	return self.db.profile.filters[spell]
end

function TopScoreFu:ToggleFiltering(spell)
	self.db.profile.filters[spell] = not self.db.profile.filters[spell]
	self:Update()
	return self.db.profile.filters[spell]
end

function TopScoreFu:Purge(spell)
	self.db.profile.filters[spell] = nil
	self.db.char.hits[spell] = nil
	if not next(self.db.char.hits) then
		dewdrop:Close(2)
		dewdrop:Refresh(1)
	end
end

function TopScoreFu:OnInitialize()
	local frame = CreateFrame("MessageFrame", "TopScoreFuSplash", UIParent)
	frame:SetWidth(GetScreenWidth())
	frame:SetHeight(100)
	frame:SetPoint("CENTER", UIParent, "CENTER")
	frame:SetFontObject(NumberFontNormalHuge)
	frame:SetFrameStrata("LOW")
	
	for spell, _ in pairs(self.db.char.hits) do
		if not self:DoesSpellExist(spell) then
			self.db.char.hits[spell] = false
		end
	end
end

function TopScoreFu:OnEnable()
	self:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF", "OnChatMsgSpellSelfBuff")
	self:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS", "OnChatMsgCombatSelfHits")
	self:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE", "OnChatMsgSpellSelfDamage")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE", "OnChatMsgSpellPeriodicHostileplayerDamage")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE", "OnChatMsgSpellPeriodicCreatureDamage")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS", "OnChatMsgSpellPeriodicSelfBuffs")
	TopScoreFuSplash:ClearAllPoints()
	TopScoreFuSplash:SetPoint("CENTER", UIParent, "CENTER", self.db.profile.posX, self.db.profile.posY)
end

function TopScoreFu:OnMenuRequest(level, value)
	if level == 1 then
		dewdrop:AddLine(
			'text', L["MENU_SHOW_SPLASH"],
			'arg1', self,
			'func', "ToggleShowingSplash",
			'checked', self.db.profile.splash
		)
		
		dewdrop:AddLine(
			'text', L["MENU_PLAY_NOISE"],
			'arg1', self,
			'func', "TogglePlayingNoise",
			'checked', self.db.profile.noise
		)
		
		dewdrop:AddLine(
			'text', L["MENU_TAKE_SCREENSHOTS"],
			'arg1', self,
			'func', "ToggleTakingScreenshots",
			'checked', self.db.profile.screenshot
		)
		
		dewdrop:AddLine(
			'text', L["MENU_RESET_SCORES"],
			'arg1', self,
			'func', "ResetScores",
			'closeWhenClicked', true
		)
		
		dewdrop:AddLine()
		
		dewdrop:AddLine(
			'text', L["MENU_FILTER"],
			'hasArrow', true,
			'value', "filter"
		)
		
		dewdrop:AddLine(
			'text', L["MENU_PURGE"],
			'hasArrow', next(self.db.char.hits),
			'value', "purge"
		)
	elseif level == 2 then
		if value == "filter" then
			dewdrop:AddLine(
				'text', L["MENU_VS_MONSTERS"],
				'arg1', self,
				'func', "ToggleOnlyPvP",
				'checked', not self.db.profile.onlyPvP
			)
			
			dewdrop:AddLine(
				'text', L["MENU_INCLUDE_HEALING"],
				'arg1', self,
				'func', "ToggleIncludingHeals",
				'checked', self.db.profile.includeHeals
			)
			
			dewdrop:AddLine(
				'text', L["MENU_INCLUDE_DAMAGE"],
				'arg1', self,
				'func', "ToggleIncludingDamage",
				'checked', self.db.profile.includeDamage
			)
			
			dewdrop:AddLine(
				'text', L["MENU_SHOW_TRIVIAL"],
				'arg1', self,
				'func', "ToggleShowingTrivial",
				'checked', self.db.profile.showTrivial
			)
			
			dewdrop:AddLine()
			
			for spell, t in pairs(self.db.char.hits) do
				dewdrop:AddLine(
					'text', spell,
					'arg1', self,
					'func', "ToggleFiltering",
					'arg2', spell,
					'checked', not self:IsFiltering(spell)
				)
			end
		elseif value == "purge" then
			for spell, t in pairs(self.db.char.hits) do
				dewdrop:AddLine(
					'text', spell,
					'arg1', self,
					'func', "Purge",
					'arg2', spell
				)
			end
		end
	end
end

function TopScoreFu:OnChatMsgSpellSelfBuff()
	local spell, target, amount, isCrit
	
	target = "self"
	isCrit = true
	spell, amount = deformat(arg1, HEALEDCRITSELFSELF)
	if not spell then
		isCrit = false
		spell, amount = deformat(arg1, HEALEDSELFSELF)
		if not spell then
			isCrit = true
			spell, target, amount = deformat(arg1, HEALEDCRITSELFOTHER)
			if not spell then
				isCrit = false
				spell, target, amount = deformat(arg1, HEALEDSELFOTHER)
				if not spell then
					target = "self"
					isCrit = true
					spell, amount = deformat(arg1, HEALEDCRITSELFSELF, RESIST_TRAILER)
					if not spell then
						isCrit = false
						spell, amount = deformat(arg1, HEALEDSELFSELF, RESIST_TRAILER)
						if not spell then
							isCrit = true
							spell, target, amount = deformat(arg1, HEALEDCRITSELFOTHER, RESIST_TRAILER)
							if not spell then
								isCrit = false
								spell, target, amount = deformat(arg1, HEALEDSELFOTHER, RESIST_TRAILER)
							end
						end
					end
				end
			end
		end
	end
	if spell then
		self:RecordHit(spell, tonumber(amount), target, isCrit, true)
	end
end

function TopScoreFu:OnChatMsgCombatSelfHits()
	local target, amount, isCrit
	isCrit = true
	target, amount = deformat(arg1, COMBATHITCRITSCHOOLSELFOTHER)
	if not target then
		target, amount, _ = deformat(arg1, COMBATHITCRITSELFOTHER)
		if not target then
			isCrit = false
			target, amount = deformat(arg1, COMBATHITSCHOOLSELFOTHER)
			if not target then
				target, amount, _ = deformat(arg1, COMBATHITSELFOTHER)
				if not target then
					isCrit = true
					target, amount = deformat(arg1, COMBATHITCRITSCHOOLSELFOTHER, RESIST_TRAILER)
					if not target then
						target, amount, _ = deformat(arg1, COMBATHITCRITSELFOTHER, RESIST_TRAILER)
						if not target then
							isCrit = false
							target, amount = deformat(arg1, COMBATHITSCHOOLSELFOTHER, RESIST_TRAILER)
							if not target then
								target, amount, _ = deformat(arg1, COMBATHITSELFOTHER, RESIST_TRAILER)
							end
						end
					end
				end
			end
		end
	end
	if target then
		self:RecordHit(S"Attack", tonumber(amount), target, isCrit, false)
	end
end

function TopScoreFu:OnChatMsgSpellSelfDamage()
	local spell, target, amount, isCrit
	isCrit = true
	spell, target, amount = deformat(arg1, SPELLLOGCRITSCHOOLSELFOTHER)
	if not spell then
		spell, target, amount = deformat(arg1, SPELLLOGCRITSELFOTHER)
		if not spell then
			isCrit = false
			spell, target, amount = deformat(arg1, SPELLLOGSCHOOLSELFOTHER)
			if not spell then
				spell, target, amount = deformat(arg1, SPELLLOGSELFOTHER)
				if not spell then
					isCrit = true
					spell, target, amount = deformat(arg1, SPELLLOGCRITSCHOOLSELFOTHER, RESIST_TRAILER)
					if not spell then
						spell, target, amount = deformat(arg1, SPELLLOGCRITSELFOTHER, RESIST_TRAILER)
						if not spell then
							isCrit = false
							spell, target, amount = deformat(arg1, SPELLLOGSCHOOLSELFOTHER, RESIST_TRAILER)
							if not spell then
								spell, target, amount = deformat(arg1, SPELLLOGSELFOTHER, RESIST_TRAILER)
							end
						end
					end
				end
			end
		end
	end
	if spell then
		self:RecordHit(spell, tonumber(amount), target, isCrit, false)
	end
end

function TopScoreFu:OnChatMsgSpellPeriodicHostileplayerDamage()
	local target, amount, _, spell = deformat(arg1, PERIODICAURADAMAGESELFOTHER)
	if not target then
		target, amount, _, spell = deformat(arg1, PERIODICAURADAMAGESELFOTHER, RESIST_TRAILER)
	end
	if target then
		self:RecordHit(spell, tonumber(amount), target, false, false)
	end
end

function TopScoreFu:OnChatMsgSpellPeriodicCreatureDamage()
	self:OnChatMsgSpellPeriodicHostileplayerDamage()
end

function TopScoreFu:OnChatMsgSpellPeriodicSelfBuffs()
	local target = "self"
	local amount, spell = deformat(arg1, PERIODICAURAHEALSELFSELF)
	if not amount then
		target, amount, spell = deformat(arg1, PERIODICAURAHEALSELFOTHER)
		if not amount then
			target = "self"
			amount, spell = deformat(arg1, PERIODICAURAHEALSELFSELF, RESIST_TRAILER)
			if not amount then
				target, amount, spell = deformat(arg1, PERIODICAURAHEALSELFOTHER, RESIST_TRAILER)
			end
		end
	end
	if amount then
		self:RecordHit(spell, tonumber(amount), "self", false, true)
	end
end

local _,class = UnitClass("player")
function TopScoreFu:DoesSpellExist(spell)
	if spell == S"Attack" then
		return true
	elseif class == "PALADIN" then
		if spell == S"Judgement of Light" then
			spell = S"Seal of Light"
		elseif spell == S"Judgement of Righteousness" then
			spell = S"Seal of Righteousness"
		elseif spell == S"Judgement of Wisdom" then
			spell = S"Seal of Wisdom"
		elseif spell == S"Judgement of Justice" then
			spell = S"Seal of Justice"
		elseif spell == S"Judgement of Command" then
			spell = S"Seal of Command"
		elseif spell == S"Judgement of the Crusader" then
			spell = S"Seal of the Crusader"
		end
	end
	local i = 1
	while true do
		local name = GetSpellName(i, "spell")
		if name == nil or name == "" then
			return false
		elseif name == spell then
			return true
		end
		i = i + 1
	end
end

local function copyTable(t)
	local x = {}
	for k,v in pairs(t) do
		x[k] = v
	end
	table.setn(x, table.getn(t))
	setmetatable(x, getmetatable(t))
	return x
end

function TopScoreFu:RecordHit(spell, amount, target, isCritical, isHeal)
	if UnitIsCharmed("player") then
		return
	end
	local alpha = string.find(spell, "%s*%(")
	if alpha ~= nil then
		spell = string.sub(spell, alpha - 1)
	end
	if self.db.char.hits[spell] == false then
		return
	elseif self.db.char.hits[spell] == nil then
		if not self:DoesSpellExist(spell) then
			self.db.char.hits[spell] = false
			return
		end
		self.db.char.hits[spell] = {
			crit = {},
			critPvP = {},
			normal = {},
			normalPvP = {},
			isHeal = isHeal,
		}
	end
	local t
	local tPvP
	if isCritical then
		t = self.db.char.hits[spell].crit
		tPvP = self.db.char.hits[spell].critPvP
	else
		t = self.db.char.hits[spell].normal
		tPvP = self.db.char.hits[spell].normalPvP
	end
	if t.amount == nil or t.amount < amount then
		local level
		local class
		local gameTarget
		if target == "self" then
			gameTarget = "player"
		elseif UnitName("target") == target then
			gameTarget = "target"
		elseif isHeal then
			if UnitExists("raid1") then
				for i = 1, GetNumRaidMembers() do
					local name = UnitName("raid" .. i)
					if name == nil then
						break
					elseif name == target then
						gameTarget = "raid" .. i
						break
					elseif UnitName("raidpet" .. i) == target then
						gameTarget = "raidpet" .. i
						break
					end
				end
			elseif UnitExists("party1") then
				for i = 1, GetNumPartyMembers() do
					local name = UnitName("party" .. i)
					if name == nil then
						break
					elseif name == target then
						gameTarget = "party" .. i
						break
					elseif UnitName("partypet" .. i) == target then
						gameTarget = "partypet" .. i
						break
					end
				end
			end
		end
		if gameTarget ~= nil then
			level = UnitLevel(gameTarget)
			_,class = UnitClass(gameTarget)
			if not self.db.profile.showTrivial and UnitIsTrivial(gameTarget) then
				return
			end
			t.amount = amount
			t.target = target
			t.level = level
			t.class = class
			if UnitIsPVP(gameTarget) and UnitPlayerControlled(gameTarget) then
				tPvP = copyTable(t)
			end
			if not self:IsFiltering(spell) and (not isHeal or self.db.profile.includeHeals) and (isHeal or self.db.profile.includeDamage) and (UnitIsPVP(gameTarget) or not self.db.profile.onlyPvP) then
				if self.db.profile.splash then
					if isCritical then
						TopScoreFuSplash:AddMessage(format(L["PATTERN_NEW_CRITICAL_RECORD"], spell, amount), 1, 1, 0, 1, 3)
					else
						TopScoreFuSplash:AddMessage(format(L["PATTERN_NEW_NORMAL_RECORD"], spell, amount), 1, 1, 0, 1, 3)
					end
				end
				if self.db.profile.noise then
					PlaySound("LEVELUP")
				end
				if self.db.profile.screenshot then
					TakeScreenshot()
				end
				self:Update()
			end
		end
	end
end

function TopScoreFu:UpdateData()
	self.highCrit = 0
	self.highNormal = 0
	for spell, t in pairs(self.db.char.hits) do
		if t and not self:IsFiltering(spell) and (not t.isHeal or self.db.profile.includeHeals) and (t.isHeal or self.db.profile.includeDamage) then
			local crit = t.crit
			local normal = t.normal
			if self.db.profile.onlyPvP then
				crit = t.critPvP
				normal = t.normalPvP
			end
			if crit ~= nil and crit.amount ~= nil and self.highCrit < crit.amount then
				self.highCrit = crit.amount
			end
			if normal ~= nil and normal.amount ~= nil and self.highNormal < normal.amount then
				self.highNormal = normal.amount
			end
		end
	end
end

function TopScoreFu:UpdateText()
	self:SetText(format("|cffffffff%d|r/|cffffffff%d|r", self.highCrit, self.highNormal))
end

function TopScoreFu:OnTooltipUpdate()
	local addedHint = false
	for spell, t in pairs(self.db.char.hits) do
		if t and not self:IsFiltering(spell) and (not t.isHeal or self.db.profile.includeHeals) and (t.isHeal or self.db.profile.includeDamage) then
			local crit = t.crit
			local normal = t.normal
			if self.db.profile.onlyPvP then
				crit = t.critPvP
				normal = t.normalPvP
			end
			if (crit and crit.amount) or (normal and normal.amount) then
				local cat = tablet:AddCategory(
					'text', spell,
					'columns', 2,
					'child_textR', 1,
					'child_textG', 1,
					'child_textB', 0
				)
				
				if crit ~= nil and crit.amount ~= nil then
					local color = "ffffff"
					if crit.amount == self.highCrit then
						color = "00ff00"
					end
					local target = crit.target
					if target == "self" then
						target = UnitName("player")
					end
					local r2, g2, b2 = babbleClass:GetColor(crit.class)
					cat:AddLine(
						'text', L["TEXT_CRITICAL"] .. " [|cff" .. color .. crit.amount .. "|r]",
						'text2', target .. " [|cffffffff" .. crit.level .. "|r]",
						'text2R', r2,
						'text2G', g2,
						'text2B', b2
					)
				end
				if normal ~= nil and normal.amount ~= nil then
					local color = "ffffff"
					if crit.amount == self.highCrit then
						color = "00ff00"
					end
					local target = normal.target
					if target == "self" then
						target = UnitName("player")
					end
					local r2, g2, b2 = babbleClass:GetColor(normal.class)
					cat:AddLine(
						'text', L["TEXT_NORMAL"] .. " [|cff" .. color .. normal.amount .. "|r]",
						'text2', target .. " [|cffffffff" .. normal.level .. "|r]",
						'text2R', r2,
						'text2G', g2,
						'text2B', b2
					)
				end
			end
			if not addedHint then
				addedHint = true
				tablet:SetHint(L["HINT"])
			end
		end
	end
end
	
function TopScoreFu:OnClick()
	if IsShiftKeyDown() and ChatFrameEditBox:IsVisible() then
		local critSpell, critAmount, normalSpell, normalAmount
		self:UpdateData()
		for spell, t in pairs(self.db.char.hits) do
			if t and not self:IsFiltering(t) and (not t.isHeal or self.db.profile.includeHeals) and (t.isHeal or self.db.profile.includeDamage) then
				local crit = t.crit
				local normal = t.normal
				if self.db.profile.onlyPvP then
					crit = t.critPvP
					normal = t.normalPvP
				end
				if crit.amount == self.highCrit then
					critSpell = spell
					critAmount = crit.amount
				end
				if normal.amount == self.highNormal then
					normalSpell = spell
					normalAmount = normal.amount
				end
			end
		end
		local s = ""
		if normalSpell ~= nil then
			s = s .. format(L["PATTERN_NORMAL_SPELL"], normalSpell) .. ": " .. normalAmount
		end
		if critSpell ~= nil then
			if s ~= "" then
				s = s .. " || "
			end
			s = s .. format(L["PATTERN_CRITICAL_SPELL"], critSpell) .. ": " .. critAmount
		end
		ChatFrameEditBox:Insert(s)
	end
end
