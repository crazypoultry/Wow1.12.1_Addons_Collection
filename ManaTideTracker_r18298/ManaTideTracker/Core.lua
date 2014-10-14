local L = AceLibrary("AceLocale-2.2"):new("ManaTideTracker")

ManaTideTracker = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceEvent-2.0", "AceDB-2.0", "AceHook-2.1", "AceComm-2.0")

function ManaTideTracker:OnInitialize()
	local opts = {
		type='group',
		args = {
			anchor = {
				type = 'execute',
				name = L["Anchor"],
				desc = L["Shows the dragable anchor."],
				func = "ToggleAnchor"
			},
			
			showTimerBars = {
				type = 'toggle',
				name = L["Show Timer Bars"],
				desc = L["If set, timer bars will be displayed."],
				get = "IsShowTimerBars",
				set = "ToggleShowTimerBars"
			},
			
			verboseText = {
				type = 'toggle',
				name = L["Verbose Bar Text"],
				desc = L["If set, timer bar text will contain the name of the spell."],
				get = "IsVerboseText",
				set = "ToggleVerboseText"
			},
			
			growUp = {
				type = 'toggle',
				name = L["Grow Up"],
				desc = L["If set, timer bars will grow up instead of down."],
				get = "IsGrowUp",
				set = "ToggleGrowUp"
			},
		},
	}
	
	local defaults = {
		showTimerBars = true,
		verboseText = true,
		growUp = false,
		barposition = {},
	}
	
	self.paint = AceLibrary("PaintChips-2.0")
	self.candy = AceLibrary("CandyBar-2.0")
	self.gratuity = AceLibrary("Gratuity-2.0")
	self.spellcache = AceLibrary("SpellCache-1.0")
	
	self:SetCommPrefix("ManaTideTracker")
	self:SetDefaultCommPriority("ALERT")
	
	ManaTideTracker:RegisterChatCommand(L["Slash-Commands"], opts)
	
	ManaTideTracker:RegisterDB("ManaTideTrackerDB", "ManaTideTrackerDBPC")
	ManaTideTracker:RegisterDefaults("profile", defaults)
	
	self.anchor = self:CreateAnchor(L["ManaTideTracker"], 0, 1, 0)
	self.candy:RegisterCandyBarGroup("ManaTideTracker")
	if self.db.profile.growUp then
		self.candy:SetCandyBarGroupPoint("ManaTideTracker", "BOTTOM", self.anchor, "TOP", -7, 0)
		self.candy:SetCandyBarGroupGrowth("ManaTideTracker", true)
	else
		self.candy:SetCandyBarGroupPoint("ManaTideTracker", "TOP", self.anchor, "BOTTOM", -7, 0)
		self.candy:SetCandyBarGroupGrowth("ManaTideTracker", false)
	end
end

function ManaTideTracker:OnEnable()
	if UnitClass("player") == "Shaman" then
		self:Hook("UseAction")
		self:Hook("CastSpell")
		self:Hook("CastSpellByName")
		self:Hook("UseInventoryItem")
	end
	self:RegisterComm(self.commPrefix, "GROUP", "ReceiveMessage")
end

-- Anchor stuff --
function ManaTideTracker:ToggleAnchor()
	if self.anchor:IsVisible() then
		self.anchor:Hide()
	else
		self.anchor:Show()
	end
end

-- Stolen from Chronometer
function ManaTideTracker:CreateAnchor(text, cRed, cGreen, cBlue)
	local f = CreateFrame("Button", nil, UIParent)
		f:SetWidth(160)
		f:SetHeight(25)
		
		f.owner = self
		
		if self.db.profile.barposition.x and self.db.profile.barposition.y then
			f:ClearAllPoints()
			f:SetPoint("TOPLEFT", UIParent, "TOPLEFT", self.db.profile.barposition.x, self.db.profile.barposition.y)
		else
			f:SetPoint("CENTER", UIParent, "CENTER", 0, 50)
		end
	
		f:SetScript("OnDragStart", function() this:StartMoving() end )
		f:SetScript("OnDragStop",
			function()
				this:StopMovingOrSizing()
				local _, _, _, x, y = this:GetPoint()
				this.owner.db.profile.barposition.x = math.floor(x)
				this.owner.db.profile.barposition.y = math.floor(y)
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
		f.Text:SetWidth(160)
		f.Text:SetHeight(25)
		f.Text:SetPoint("TOPLEFT", f, "TOPLEFT")
		f.Text:SetJustifyH("CENTER")
		f.Text:SetJustifyV("MIDDLE")
		f.Text:SetText(text)
		
		f:Hide()
	
	return f
end

-- some settings
function ManaTideTracker:IsVerboseText()
	return self.db.profile.verboseText
end

function ManaTideTracker:ToggleVerboseText()
	self.db.profile.verboseText = not self.db.profile.verboseText
end

function ManaTideTracker:IsGrowUp()
	return self.db.profile.growUp
end

function ManaTideTracker:ToggleGrowUp()
	self.db.profile.growUp = not self.db.profile.growUp
	if self.db.profile.growUp then
		self.candy:SetCandyBarGroupPoint("ManaTideTracker", "BOTTOM", self.anchor, "TOP", -7, 0)
		self.candy:SetCandyBarGroupGrowth("ManaTideTracker", true)
	else
		self.candy:SetCandyBarGroupPoint("ManaTideTracker", "TOP", self.anchor, "BOTTOM", -7, 0)
		self.candy:SetCandyBarGroupGrowth("ManaTideTracker", false)
	end
end

-- Bar stuff
local currentBars = { }

function ManaTideTracker:IsShowTimerBars()
	return self.db.profile.showTimerBars
end

function ManaTideTracker:ToggleShowTimerBars()
	self.db.profile.showTimerBars = not self.db.profile.showTimerBars
	if not self.db.profile.showTimerBars then
		for x = 1,30 do
			if currentBars[x] ~= nil then
				self.candy:UnregisterCandyBar(currentBars[x])
				currentBars[x] = nil
			end
		end
	end
end



function ManaTideTracker:AddCooldown(player, spell)
	if self.db.profile.showTimerBars then
		local free = 0
		for x = 1,30 do
			if currentBars[x] == nil then
				free = x
				break
			end
		end
		local id
		local text
		local duration
		local cooldown
		local durationColor
		local cooldownColor
		local coolFunc
		
		if spell == "tide" then
			id = player.."-tide"
			if self.db.profile.verboseText then
				text = player.."-Tide"
			else
				text = player
			end
			duration = 12
			cooldown = 300
			durationColor = "cyan"
			cooldownColor = "yellow"
		else if spell == "spirit" then
			id = player.."-spirit"
			if self.db.profile.verboseText then
				text = player.."-Trinket"
			else
				text = player
			end
			duration = 24
			cooldown = 180
			durationColor = "magenta"
			cooldownColor = "red"
		end end
		currentBars[free] = id
		
		coolFunc = function (id, text, duration, cooldown, player, color, bar)
			local endFunc = function (bar)
				currentBars[bar] = nil
			end
			currentBars[bar] = id
			self.candy:RegisterCandyBar(id, cooldown, text)
			self.candy:RegisterCandyBarWithGroup(id, "ManaTideTracker")
			self.candy:SetCandyBarColor(id, color)
			self.candy:SetWidth(id, 150)
			self.candy:SetCandyBarCompletion(id, endFunc, bar)
			self.candy:StartCandyBar(id, true)
			self.candy:SetCandyBarTimeLeft(id, cooldown - duration)
			
		end
		
		self.candy:RegisterCandyBar(id, duration, text)
		self.candy:RegisterCandyBarWithGroup(id, "ManaTideTracker")
		self.candy:SetCandyBarColor(id, durationColor)
		self.candy:SetWidth(id, 150)
		self.candy:SetCandyBarCompletion(id, coolFunc, id.."c", text, duration, cooldown, player, cooldownColor, free)
		self.candy:StartCandyBar(id, true)
	end
end

-- Catch spellcast
function ManaTideTracker:UseAction(slot, clicked, onself)
	if not GetActionText(slot) and HasAction(slot) then
		cooldown, _, _ = GetActionCooldown(slot)
		if cooldown == 0 then
			self.gratuity:SetAction(slot)
			spellName = self.gratuity:GetLine(1)
			self:CatchSpellcast(spellName)
		end
	end
	return self.hooks["UseAction"](slot, clicked, onself)
end

function ManaTideTracker:CastSpell(index, booktype)
	cooldown, _, _ = GetSpellCooldown(index, booktype)
	if cooldown == 0 then
		local name, rank = GetSpellName(index, booktype)
		self:CatchSpellcast(name)
	end
	return self.hooks["CastSpell"](index, booktype)
end

function ManaTideTracker:CastSpellByName(text, onself)
	local name, _, id, _, _ = self.spellcache:GetSpellData(text, nil)
	if name ~= nil then
		cooldown, _, _ = GetSpellCooldown(id, BOOKTYPE_SPELL)
		if cooldown == 0 then
			self:CatchSpellcast(name)
		end
	end
	return self.hooks["CastSpellByName"](text,onself)
end

function ManaTideTracker:UseInventoryItem(slotID)
	local link = GetInventoryItemLink("player", slotID)
	cooldown, _, _ = GetInventoryItemCooldown("player", slotID)
	if cooldown == 0 then
		self:CatchSpellcast(link)
	end
	return self.hooks["UseInventoryItem"](slotID)
end

function ManaTideTracker:CatchSpellcast(name)
	-- check if mounted
	for buffNum = 1,30 do
		buff, _ = UnitBuff("player", buffNum)
		if buff == nil then
			break
		end
		if string.find(buff, L["Mount"]) then
			return
		end
	end
	if string.find(string.lower(name), L["mana tide totem"]) then
		self:SendCommMessage("GROUP", "tide")
		self:AddCooldown(UnitName("player"), "tide")
	else if string.find(string.lower(name), L["enamored water spirit"]) then
		local trinketOne = GetInventoryItemLink("player", 13)
		local trinketTwo = GetInventoryItemLink("player", 14)
		if string.find(string.lower(trinketOne), L["enamored water spirit"]) or
		   string.find(string.lower(trinketTwo), L["enamored water spirit"]) then
			self:SendCommMessage("GROUP", "spirit")
			self:AddCooldown(UnitName("player"), "spirit")
		end
	end end
end

--communication stuff
function ManaTideTracker:ReceiveMessage(prefix, sender, distribution, message)
	self:AddCooldown(sender, message)
end