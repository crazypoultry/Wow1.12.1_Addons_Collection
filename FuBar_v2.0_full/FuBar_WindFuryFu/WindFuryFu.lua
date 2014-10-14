local L = AceLibrary("AceLocale-2.2"):new("WindFuryFu")
local BS = AceLibrary("Babble-Spell-2.2")
local compost = AceLibrary("Compost-2.0")
local dewdrop = AceLibrary("Dewdrop-2.0")
local gratuity = AceLibrary("Gratuity-2.0")
local tablet = AceLibrary("Tablet-2.0")

WindFuryFu = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0")

WindFuryFu.version = "2.0"
WindFuryFu.date = "2006-10-31"
WindFuryFu.hasIcon = "Interface\\Icons\\Spell_Nature_Cyclone.blp"
WindFuryFu.independentProfile = true

function WindFuryFu:OnInitialize()
	self.options = {
		handler = WindFuryFu,
		type = 'group',
		args = {
			display = {
				type = 'group',
				name = L["Display Options"],
				desc = L["Set the Display Properties"],
				args = {
					label = {
						type = 'toggle',
						name = L["Show Label Text"],
						desc = L["Toggle text labels on FuBar"],
						get = function() return self.db.profile.showLabel end,
						set = function(v)
							self.db.profile.showLabel = v
							self:UpdateText()
						end,
					},
					last = {
						type = 'toggle',
						name = L["Show Last WF Hit"],
						desc = L["Toggle showing your LAST Windfury hit"],
						get = function() return self.db.profile.displayLast end,
						set = function(v)
							self.db.profile.displayLast = v
							self:UpdateText()
						end,
					},
					best = {
						type = 'toggle',
						name = L["Show Best WF Hit"],
						desc = L["Toggle showing your BEST Windfury hit"],
						get = function() return self.db.profile.displayBest end,
						set = function(v)
							self.db.profile.displayBest = v
							self:UpdateText()
						end,
					},
					lastfive = {
						type = 'toggle',
						name = L["Show Five Last WF Hits"],
						desc = L["Toggle showing the last five Windfury hits in the tooltip"],
						get = function() return self.db.profile.tooltipLastFive end,
						set = function(v)
							self.db.profile.tooltipLastFive = v
							self:UpdateTooltip()
						end,
					},
				},
			},
			reset = {
				type = 'group',
				name = L["Reset Scores"],
				desc = L["Reset your Windfury scores"],
				args = {
					session = {
						type = 'execute',
						name = L["Session"],
						desc = L["Reset your Windfury stats for this session"],
						func = function()
							self:ResetStats("session")
						end
					},
					lifetime = {
						type = 'execute',
						name = L["Lifetime"],
						desc = L["Reset your lifetime Windfury stats"],
						func = function()
							self:ResetStats("lifetime")
						end
					},
				},
			},
		},
	}

	self:RegisterDB("WindFuryFuDB")
	self:RegisterDefaults('profile', {
		showLabel = true,
		displayLast = true,
		displayBest = true,
		tooltipLastFive = true,
	})
	self:RegisterDefaults("char", {
		WF = {},
		WFS = {},
	})
	self:RegisterChatCommand({L["SLASHCMD_LONG"], L["SLASHCMD_SHORT"]}, self.options)

	self.OnMenuRequest = self.options
end

function WindFuryFu:OnEnable()
	--self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnPlayerEnteringWorld")
	--self:RegisterEvent("PLAYER_LEAVING_WORLD", "OnPlayerLeavingWorld")

	self:RegisterEvent("UNIT_INVENTORY_CHANGED", "InventoryChanged")
	self:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF", "SpellSelfBuff")
	self:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS", "CombatSelfHit")
	self:RegisterEvent("CHAT_MSG_COMBAT_SELF_MISSES", "CombatSelfMiss")

	self.charData = {
		WF = {},
		WFS = {},
	}

	self.WF_WEAPON_NAME = ""
	self.WF_STATUS = FALSE
	self.WF_SHIT = 0
	self.WF_CRIT = 0
	self.WF_LEFT = 0
	self.WF_THIS = 0

	self:WeaponCheck()
end

function WindFuryFu:OnPlayerEnteringWorld()
	self:RegisterEvent("UNIT_INVENTORY_CHANGED", "InventoryChanged")
end

function WindFuryFu:OnPlayerLeavingWorld()
	self:UnregisterEvent("UNIT_INVENTORY_CHANGED")
end

function WindFuryFu:InventoryChanged()
	if (arg1 == "player") then
		self:WeaponCheck()
	end
end

function WindFuryFu:OnClick()
	if (IsShiftKeyDown()) and (ChatFrameEditBox:IsVisible()) then
		message = self.WF_WEAPON_NAME .. " Stats - Best WF: " .. self.db.char.WFS[self.WF_WEAPON_NAME]["WF_ALL_BEST"] .. " - Average WF dmg: " .. self.WF_ALL_AVERAGE .. " - Best hit during WF: " .. self.db.char.WFS[self.WF_WEAPON_NAME]["WF_ALL_SHIT"]
		ChatFrameEditBox:Insert(message)
	end
end

function WindFuryFu:ResetStats(type)
	if (type == "session") then
		self:Setup(self.WF_WEAPON_NAME, "session")
	elseif (type == "LIFETIME") then
		self:Setup(self.WF_WEAPON_NAME, "lifetime")
	end
	self:Update()
end

function WindFuryFu:UpdateData()
	if (self.db.char.WF[self.WF_WEAPON_NAME]["TOTAL"] == 0) then
		self.WF_AVERAGE = "0"
	else
		self.WF_AVERAGE = ceil(self.db.char.WF[self.WF_WEAPON_NAME]["TOTAL"] / self.db.char.WF[self.WF_WEAPON_NAME]["PROCS"])
	end
	if (self.db.char.WFS[self.WF_WEAPON_NAME]["WF_ALL_TOTAL"] == 0) then
		self.WF_ALL_AVERAGE = "0"
	else
		self.WF_ALL_AVERAGE = ceil(self.db.char.WFS[self.WF_WEAPON_NAME]["WF_ALL_TOTAL"] / self.db.char.WFS[self.WF_WEAPON_NAME]["WF_ALL_PROCS"])
	end
	if (self.db.char.WF[self.WF_WEAPON_NAME]["CRITS"] == 0) then
		self.WF_OUT_CRITS = "0"
	else
		self.WF_OUT_CRITS = ceil((self.db.char.WF[self.WF_WEAPON_NAME]["CRITS"] / (self.db.char.WF[self.WF_WEAPON_NAME]["PROCS"]*3)) * 100)
	end
	if (self.db.char.WF[self.WF_WEAPON_NAME]["PROCS"] == 0) then
		self.WF_OUT_PROCS = "0"
	else
		self.WF_OUT_PROCS = ceil((self.db.char.WF[self.WF_WEAPON_NAME]["PROCS"] / self.db.char.WF[self.WF_WEAPON_NAME]["HITS"]) * 100)
	end
	if (self.db.char.WFS[self.WF_WEAPON_NAME]["WF_ALL_PROCS"] == 0) then
		self.WF_ALL_OUT_PROCS = "0"
	else
		self.WF_ALL_OUT_PROCS = ceil((self.db.char.WFS[self.WF_WEAPON_NAME]["WF_ALL_PROCS"] / self.db.char.WFS[self.WF_WEAPON_NAME]["WF_ALL_HITS"]) * 100)
	end
	if (self.db.char.WFS[self.WF_WEAPON_NAME]["WF_ALL_CRITS"] == 0) then
		self.WF_ALL_OUT_CRITS = "0"
	else
		self.WF_ALL_OUT_CRITS = ceil((self.db.char.WFS[self.WF_WEAPON_NAME]["WF_ALL_CRITS"] / (self.db.char.WFS[self.WF_WEAPON_NAME]["WF_ALL_PROCS"]*3)) * 100)
	end
end

function WindFuryFu:OnTextUpdate()
	local str = ""

	if (self.db.profile.showLabel) then
		if (self.db.profile.displayLast) then
			str = str .. L["Last"] .. ": |c00FFFFFF" .. self.db.char.WF[self.WF_WEAPON_NAME]["LAST"][1] .. "|r"
		end
		if (self.db.profile.displayBest) then
			if (strlen(str) > 4) then
				str = str .. "  "
			end
			if (self.db.char.WFS[self.WF_WEAPON_NAME]["WF_ALL_BEST"] < self.db.char.WF[self.WF_WEAPON_NAME]["BEST"]) then
				str = str .. L["Best"] ..": |c00FFFFFF" .. self.db.char.WF[self.WF_WEAPON_NAME]["BEST"] .. "|r"
			else
				str = str .. L["Best"] ..": |c00FFFFFF" .. self.db.char.WFS[self.WF_WEAPON_NAME]["WF_ALL_BEST"] .. "|r"
			end
		end
		if (self.WF_STATUS) then
			str = str .. " " .. L["Status"] .. ": |cff20ff20ON|r"
		else
			str = str .. " " .. L["Status"] .. ": |cffff2020OFF|r"
		end
	else
		if (self.db.profile.displayLast) then
			str = str .. "|c00FFFFFF" .. self.db.char.WF[self.WF_WEAPON_NAME]["LAST"][1] .. "|r/"
		end
		if (self.db.profile.displayBest) then
			if (self.db.char.WFS[self.WF_WEAPON_NAME]["WF_ALL_BEST"] < self.db.char.WF[self.WF_WEAPON_NAME]["BEST"]) then
				str = str .. "|c00FFFFFF" .. self.db.char.WF[self.WF_WEAPON_NAME]["BEST"] .. "|r/"
			else
				str = str .. "|c00FFFFFF" .. self.db.char.WFS[self.WF_WEAPON_NAME]["WF_ALL_BEST"] .. "|r/"
			end
		end
		if (self.WF_STATUS) then
			str = str .. "|cff20ff20ON|r"
		else
			str = str .. "|cffff2020OFF|r"
		end
	end
	self:SetText(str)
end

function WindFuryFu:OnTooltipUpdate()
	gratuity:SetInventoryItem("player", GetInventorySlotInfo("MainHandSlot"))
	local weaponName = gratuity:GetLine(1)

	if (weaponName == nil) then
		weaponName = L["No Weapon Equipped"]
	end

	local cat1 = tablet:AddCategory(
		'columns', 1,
		'text', L["Weapon"]
	)
	cat1:AddLine('text', weaponName)

	cat2 = tablet:AddCategory(
		'columns', 2,
		'text', L["This Session"],
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 0,
		'child_text2R', 1,
		'child_text2G', 1,
		'child_text2B', 1
	)

	if (self.db.profile.tooltipLastFive) then
		cat2:AddLine(
			'text', L["Last"] .. ":",
			'text2', "(" .. self.db.char.WF[self.WF_WEAPON_NAME]["CRIT"][1] .. ") " .. self.db.char.WF[self.WF_WEAPON_NAME]["LAST"][1]
		)
		cat2:AddLine(
			'text', L["2nd Last"] .. ":",
			'text2', "(" .. self.db.char.WF[self.WF_WEAPON_NAME]["CRIT"][2] .. ") " .. self.db.char.WF[self.WF_WEAPON_NAME]["LAST"][2]
		)
		cat2:AddLine(
			'text', L["3rd Last"] .. ":",
			'text2', "(" .. self.db.char.WF[self.WF_WEAPON_NAME]["CRIT"][3] .. ") " .. self.db.char.WF[self.WF_WEAPON_NAME]["LAST"][3]
		)
		cat2:AddLine(
			'text', L["4th Last"] .. ":",
			'text2', "(" .. self.db.char.WF[self.WF_WEAPON_NAME]["CRIT"][4] .. ") " .. self.db.char.WF[self.WF_WEAPON_NAME]["LAST"][4]
		)
		cat2:AddLine(
			'text', L["5th Last"] .. ":",
			'text2', "(" .. self.db.char.WF[self.WF_WEAPON_NAME]["CRIT"][5] .. ") " .. self.db.char.WF[self.WF_WEAPON_NAME]["LAST"][5]
		)
	else
		cat2:AddLine(
			'text', L["Last"] .. ":",
			'text2', "(" .. self.db.char.WF[self.WF_WEAPON_NAME]["CRIT"][1] .. ") " .. self.db.char.WF[self.WF_WEAPON_NAME]["LAST"][1]
		)
	end

	cat2:AddLine(
		'text', L["Best Single Hit"] .. ":",
		'text2', self.db.char.WF[self.WF_WEAPON_NAME]["SHIT"]
	)
	cat2:AddLine(
		'text', L["Best"] .. ":",
		'text2', self.db.char.WF[self.WF_WEAPON_NAME]["BEST"]
	)
	cat2:AddLine(
		'text', L["Procs"] .. ":",
		'text2', "(" .. self.db.char.WF[self.WF_WEAPON_NAME]["PROCS"] .. "/" .. self.db.char.WF[self.WF_WEAPON_NAME]["HITS"] .. ") " .. self.WF_OUT_PROCS .. "%"
	)
	cat2:AddLine(
		'text', L["Crits"] .. ":",
		'text2', "(" .. self.db.char.WF[self.WF_WEAPON_NAME]["CRITS"] .. "/" .. (self.db.char.WF[self.WF_WEAPON_NAME]["PROCS"]*3)..") " .. self.WF_OUT_CRITS .. "%"
	)
	cat2:AddLine(
		'text', L["Average"] .. ":",
		'text2', self.WF_AVERAGE
	)
	cat2:AddLine(
		'text', L["Total WF damage"] .. ":",
		'text2', self.db.char.WF[self.WF_WEAPON_NAME]["TOTAL"]
	)

	cat3 = tablet:AddCategory(
		'columns', 2,
		'text', L["Lifetime"],
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 0,
		'child_text2R', 1,
		'child_text2G', 1,
		'child_text2B', 1
	)
 
	cat3:AddLine(
		'text', L["Best Single Hit"] .. ":",
		'text2', self.db.char.WFS[self.WF_WEAPON_NAME]["WF_ALL_SHIT"]
	)
	cat3:AddLine(
		'text', L["Best"] .. ":",
		'text2', self.db.char.WFS[self.WF_WEAPON_NAME]["WF_ALL_BEST"]
	)
	cat3:AddLine(
		'text', L["Procs"] .. ":",
		'text2', "(" .. self.db.char.WFS[self.WF_WEAPON_NAME]["WF_ALL_PROCS"]..") " .. self.WF_ALL_OUT_PROCS .. "%"
	)
	cat3:AddLine(
		'text', L["Crits"] .. ":",
		'text2', "(" .. self.db.char.WFS[self.WF_WEAPON_NAME]["WF_ALL_CRITS"]..") " .. self.WF_ALL_OUT_CRITS .. "%"
	)
	cat3:AddLine(
		'text', L["Average"] .. ":",
		'text2', self.WF_ALL_AVERAGE
	)
	cat3:AddLine(
		'text', L["Total WF damage"] .. ":",
		'text2', self.db.char.WFS[self.WF_WEAPON_NAME]["WF_ALL_TOTAL"]
	)

	tablet:SetHint(L["Shift-Click to insert your stats into a chat message."])
end

function WindFuryFu:WeaponCheck()
	gratuity:SetInventoryItem("player", GetInventorySlotInfo("MainHandSlot"))
	local weaponName = gratuity:GetLine(1)

	self.WF_STATUS = self:IsBuffWF()

	if (weaponName == nil) then
		weaponName = L["No Weapon Equipped"]
	end

	self.WF_WEAPON_NAME = weaponName

	if (self.db.char.WFS[self.WF_WEAPON_NAME] == nil) then
		self:Setup(self.WF_WEAPON_NAME, "lifetime")
	end

	if (self.db.char.WF[self.WF_WEAPON_NAME] == nil) then
		self:Setup(self.WF_WEAPON_NAME, "session")
	end

	self:Update()
end

function WindFuryFu:IsBuffWF()
	if (GetWeaponEnchantInfo()) then
		local hasItem = gratuity:SetInventoryItem("player", GetInventorySlotInfo("MainHandSlot"))

		if (hasItem) then
			if (gratuity:Find(L["Windfury Totem"])) then
				return false
			elseif (gratuity:Find(L["Windfury"])) then
				return true
			end
		end
	end
	return false
end

function WindFuryFu:Setup(weapon, type)
	if (type == "lifetime") then
		self.db.char.WFS[weapon] = nil
		self.db.char.WFS[weapon] = {}
		self.db.char.WFS[weapon].WF_ALL_TOTAL = 0
		self.db.char.WFS[weapon].WF_ALL_PROCS = 0
		self.db.char.WFS[weapon].WF_ALL_HITS = 0
		self.db.char.WFS[weapon].WF_ALL_CRITS = 0
		self.db.char.WFS[weapon].WF_ALL_BEST = 0
		self.db.char.WFS[weapon].WF_ALL_SHIT = 0
	elseif (type == "session") then
		self.db.char.WF[weapon] = nil
		self.db.char.WF[weapon] = {}
		self.db.char.WF[weapon].BEST = 0
		self.db.char.WF[weapon].LAST = {0, 0, 0, 0, 0}
		self.db.char.WF[weapon].CRIT = {0, 0, 0, 0, 0}
		self.db.char.WF[weapon].HITS = 0
		self.db.char.WF[weapon].CRITS = 0
		self.db.char.WF[weapon].PROCS = 0
		self.db.char.WF[weapon].TOTAL = 0
		self.db.char.WF[weapon].SHIT = 0
	end
end


function WindFuryFu:SpellSelfBuff()
	if (strfind(arg1, L["You gain 2 extra attacks through Windfury Weapon"]) and self.WF_STATUS) then
		self.WF_LEFT = 3
		self.WF_THIS = 0
		
		self:WF_AddValue("HITS", 1, "session")
		self:WF_AddValue("WF_ALL_HITS", 1, "lifetime")

		self:WF_AddValue("PROCS", 1, "session")
		self:WF_AddValue("WF_ALL_PROCS", 1, "lifetime")
		self:Update()
	end
end

function WindFuryFu:CombatSelfHit()
	if self.WF_STATUS then
		if (self.WF_LEFT > 0) then
			local tdamage = 0
			self.WF_SHIT = 0
			for creatureName, tdamage in string.gfind(arg1, L["You hit (.+) for (%d+)"]) do
				self.WF_THIS = self.WF_THIS + tdamage
				self.WF_SHIT = self.WF_SHIT + tdamage
				self:WF_AddValue("WF_ALL_TOTAL", tdamage, "lifetime")
				self:WF_AddValue("TOTAL", tdamage, "session")
			end

			for creatureName, tdamage in string.gfind(arg1, L["You crit (.+) for (%d+)"]) do
				self.WF_THIS = self.WF_THIS + tdamage
				self.WF_SHIT = self.WF_SHIT + tdamage
				self.WF_CRIT = self.WF_CRIT + 1

				self:WF_AddValue("WF_ALL_TOTAL", tdamage, "lifetime")
				self:WF_AddValue("TOTAL", tdamage, "session")

				self:WF_AddValue("CRITS", 1, "session")
				self:WF_AddValue("WF_ALL_CRITS", 1, "lifetime")
			end
			self.WF_LEFT = self.WF_LEFT - 1
			if ( self.WF_SHIT > self.db.char.WF[self.WF_WEAPON_NAME]["SHIT"] ) then
				self.db.char.WF[self.WF_WEAPON_NAME]["SHIT"] = self.WF_SHIT
			end
			if ( self.WF_SHIT > self.db.char.WFS[self.WF_WEAPON_NAME]["WF_ALL_SHIT"] ) then
				self.db.char.WFS[self.WF_WEAPON_NAME]["WF_ALL_SHIT"] = self.WF_SHIT
			end
			if ( self.WF_LEFT < 1 ) then
				self.db.char.WF[self.WF_WEAPON_NAME]["CRIT"][5] = self.db.char.WF[self.WF_WEAPON_NAME]["CRIT"][4]
				self.db.char.WF[self.WF_WEAPON_NAME]["CRIT"][4] = self.db.char.WF[self.WF_WEAPON_NAME]["CRIT"][3]
				self.db.char.WF[self.WF_WEAPON_NAME]["CRIT"][3] = self.db.char.WF[self.WF_WEAPON_NAME]["CRIT"][2]
				self.db.char.WF[self.WF_WEAPON_NAME]["CRIT"][2] = self.db.char.WF[self.WF_WEAPON_NAME]["CRIT"][1]
				self.db.char.WF[self.WF_WEAPON_NAME]["CRIT"][1] = self.WF_CRIT

				self.db.char.WF[self.WF_WEAPON_NAME]["LAST"][5] = self.db.char.WF[self.WF_WEAPON_NAME]["LAST"][4]
				self.db.char.WF[self.WF_WEAPON_NAME]["LAST"][4] = self.db.char.WF[self.WF_WEAPON_NAME]["LAST"][3]
				self.db.char.WF[self.WF_WEAPON_NAME]["LAST"][3] = self.db.char.WF[self.WF_WEAPON_NAME]["LAST"][2]
				self.db.char.WF[self.WF_WEAPON_NAME]["LAST"][2] = self.db.char.WF[self.WF_WEAPON_NAME]["LAST"][1]
				self.db.char.WF[self.WF_WEAPON_NAME]["LAST"][1] = self.WF_THIS

				self.WF_CRIT = 0
			end
			if ( self.db.char.WF[self.WF_WEAPON_NAME]["LAST"][1] > self.db.char.WF[self.WF_WEAPON_NAME]["BEST"] ) then
				self.db.char.WF[self.WF_WEAPON_NAME]["BEST"] = self.db.char.WF[self.WF_WEAPON_NAME]["LAST"][1]
			end
			if ( self.db.char.WF[self.WF_WEAPON_NAME]["LAST"][1] > self.db.char.WFS[self.WF_WEAPON_NAME]["WF_ALL_BEST"] ) then
				self.db.char.WFS[self.WF_WEAPON_NAME]["WF_ALL_BEST"] = self.db.char.WF[self.WF_WEAPON_NAME]["LAST"][1]
			end
		else
			self:WF_AddValue("HITS", 1, "session")
			self:WF_AddValue("WF_ALL_HITS", 1, "lifetime")
		end
		self:Update()
	end
end

function WindFuryFu:CombatSelfMiss()
	if self.WF_STATUS then
		if (self.WF_LEFT > 0) then
			self.WF_LEFT = self.WF_LEFT - 1
		else
			self:WF_AddValue("HITS", 1, "session")
			self:WF_AddValue("WF_ALL_HITS", 1, "lifetime")
		end
		self:Update()
	end
end

function WindFuryFu:WF_AddValue(var, val, type)
	if (type == "lifetime") then
		self.db.char.WFS[self.WF_WEAPON_NAME][var] = self.db.char.WFS[self.WF_WEAPON_NAME][var] + val
	elseif (type == "session") then
		self.db.char.WF[self.WF_WEAPON_NAME][var] = self.db.char.WF[self.WF_WEAPON_NAME][var] + val
	end
end
