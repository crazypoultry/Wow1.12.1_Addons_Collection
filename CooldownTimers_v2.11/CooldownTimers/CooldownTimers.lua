--[[--------------------------------------------------------------------------------
CooldownTimers -  Main File
Version: 2.$Revision: 12000 $
Author: Krsnik
Credits: Sole for HostelBar where I got most of the stuff I used, Ammo for CandyBar :) and of course the Ace community
----------------------------------------------------------------------------------]]
local defaults = {
	-- general opts
	mintime = 2,			-- min time to show a bar
	maxtime = 1800,			-- max time to show a bar
	bgalpha = 1, 			-- background opacity of the bars, ranges from 0.0 to 1.0 
	bargrowth = false,		-- direction the bars will grow in,  true = up, false = down
	barcolor = "green",		-- possible values: white, black, blue, green, yellow, orange, red, magenta, cyan
	bgcolor = "cyan",		-- possible values: white, black, blue, green, yellow, orange, red, magenta, cyan
	textcolor = "white",	-- possible values: white, black, blue, green, yellow, orange, red, magenta, cyan
	barscale = 1.0,			-- size of the bars
	barheight = 12,			-- height of the bars
	barwidth = 150,			-- width of the bars
	barposition = {},		-- stored position of the anchor frame
	alertposition = {},		-- stored position of the alert frame
	ignore = {},			-- ignored spells
	alert = false,			-- toggle alerts
	alertdelay = 2,			-- how long the alerts stay on screen	
	barfont = 10,			-- font size on cooldown bars
	alertfont = 20,			-- font size of alerts
	bartex = "default",		-- bar texture (Default nil: CandyBar default)
	alertframe = "default"	-- where our alert msgs go (SCT/MikSBT/self.alert)
}

local resetSpells = {
	["Preparation"] = {
		[1] = "Vanish",
		[2] = "Cold Blood",
		[3] = "Sprint",
		[4] = "Premeditation",
		[5] = "Blind",
		[6] = "Evasion",
		[7] = "Kick",
		[8] = "Kidney Shot",
		[9] = "Ghostly Strike",
		[10] = "Distract",
		[11] = "Feint",
	},
	["Cold Snap"] = {
		[1] = "Frost Nova",
		[2] = "Ice Barrier",
		[3] = "Cone of Cold",
		[4] = "Ice Block",
		[5] = "Frost Ward",
	},
}

local delayedSpells = {
	["Stealth"] = true,
	["Shadowmeld"] = true,
	["Prowl"] = true,
	["Cold Blood"] = true,
	["Nature's Swiftness"] = true,
	["Inner Focus"] = true,
	["Elemental Mastery"] = true,
	["Divine Favor"] = true,
	["Amplify Curse"] = true,
	["Presence of Mind"] = true,
	["Combustion"] = true,
	["Feign Death"] = true,
}

--[[--------------------------------------------------------------------------------
  Class Setup
-----------------------------------------------------------------------------------]]
CooldownTimers = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0", "AceDebug-2.0", "Metrognome-2.0")
-- embedded libs
local L = AceLibrary("AceLocale-2.0"):new("CooldownTimers")
local BS = AceLibrary("Babble-Spell-2.0")

function CooldownTimers:OnInitialize()
	--embedded libs
	self.candy = AceLibrary("CandyBar-2.0")
	self.gt = AceLibrary("Gratuity-2.0")
	self.def = AceLibrary("Deformat-2.0")

	-- set chat commands 
	local args = {
	type = "group",
	args = {
		ignore = {
			name = L["Ignore"], desc = L["DescIgnore"],	type = "group",	
			args = {
				add = {
					name = "Add",
					desc = "Add a spell to the ignore list.",
					usage = "<filter>",
					type = "text",
					get = false,
					set = function(v)
						if self.candy:IsCandyBarRegistered("CooldownTimers_"..v) then
							self.candy:StopCandyBar("CooldownTimers_"..v)
						end
						self.db.profile.ignore[string.lower(v)] = true
						self:Print("Added spell |cff00ff00%s|r to the list", v)
					end,
				},
				remove = {
					name = "Remove",
					desc = "Remove a spell from the ignore list",
					usage = "<filter>",
					aliases = "rm, del",
					type = "text",
					get = false,
					set = function(v)
						if self.db.profile.ignore[string.lower(v)] then
							self.db.profile.ignore[string.lower(v)] = nil
							self:Print("Spell |cff00ff00%s|r removed", v)
						else
							self:Print("Spell |cff00ff00%s|r |cffff0000not found|r in the list", v)
						end
					end,
				},
				list = {
					name = "List filters",
					desc = "Output the list of spells being ignored",
					aliases = "ls",
					type = "execute",
					func = function()
						local emptyCheck
						for k in pairs(self.db.profile.ignore) do
							self:Print("|cff00ff00%s|r", k)
							emptyCheck = true
						end
						if not emptyCheck then self:Print("You have no active filters") end
					end,
				},
				reset = {
					name = "Reset filters",
					desc = "Empty the ignore list",
					type = "execute",
					func = function()
						self.db.profile.ignore = {}
						self:Print("The ignore list is now empty")
					end,
				},
			},
		},
		bar = {
			name = L["Bar"], desc=L["DescBar"], type = "group",
			args = {
				bgalpha = {
					name = L["Background Alpha"],desc = L["DescBGAlpha"],type = "range",
					get = function () return self.db.profile.bgalpha end,
					set = function (v) self.db.profile.bgalpha = v end,
					min = 0.0, max = 1.0,
				},
				growth = {
					name = L["Bar Growth"], desc=L["DescBarGrowth"], type = "toggle",
					get = function () return self.db.profile.bargrowth end,
					set = function (v) self.db.profile.bargrowth = v  
					self.candy:SetCandyBarGroupGrowth("CooldownTimers", self.db.profile.bargrowth) end,
					map = { [false] = L["MapBarGrowthFalse"], [true] = L["MapBarGrowthTrue"],},
				},
				color = {
					name = L["Bar Color"], desc=L["DescBarColor"], type = "text",
					get = function () return self.db.profile.barcolor end,
					set = function (v) self.db.profile.barcolor = v end, 
					validate = { "white", "black", "blue", "green", "yellow", "orange", "red", "magenta", "cyan" },
				},
				bgcolor = {
					name = L["Background Color"], desc=L["DescBgColor"], type = "text",
					get = function () return self.db.profile.bgcolor end,
					set = function (v) self.db.profile.bgcolor = v end, 
					validate = { "white", "black", "blue", "green", "yellow", "orange", "red", "magenta", "cyan" },
				},
				texture = {
					name = L["Bar Texture"], desc = L["DescBarTexture"], type = "text",
					get = function () return self.db.profile.bartex end,
					set = function (v) self.db.profile.bartex = v end,
					validate = { "default", "smooth", "perl", "glaze", "cilo" },
				},
				textcolor = {
					name = L["Text Color"], desc=L["DescTextColor"], type = "text",
					get = function () return self.db.profile.textcolor end,
					set = function (v) self.db.profile.textcolor = v end, 
					validate = { "white", "black", "blue", "green", "yellow", "orange", "red", "magenta", "cyan" },
				},
				textsize = {
					name = L["Font Size"], desc = L["DescFontSize"], type = "range",
					get = function () return self.db.profile.barfont end,
					set = function (v) self.db.profile.barfont = v end,
					min = 8, max = 20,
				},
				height = {
					name = L["Bar Height"], desc=L["DescBarHeight"], type = "range",
					get = function () return self.db.profile.barheight end,
					set = function (v) self.db.profile.barheight = v end,
					min = 8, max = 30,
				},
				width = {
					name = L["Bar Width"], desc=L["DescBarWidth"], type = "range",
					get = function () return self.db.profile.barwidth end,
					set = function (v) self.db.profile.barwidth = v end,
					min = 50, max = 300,
				},
				scale = {
					name = L["Bar Scale"], desc=L["DescBarScale"], type = "range",
					get = function () return self.db.profile.barscale end,
					set = function (v) self.db.profile.barscale = v end,
					min = 0.5, max = 1.5,
				},
				mintime = {
					name = L["Min Time"],desc = L["DescMinTime"],type = "range",
					get = function () return self.db.profile.mintime end,
					set = function (v) self.db.profile.mintime = v end,
					min = 1.0, max = 10,
				},
				maxtime = {
					name = L["Max Time"],desc = L["DescMaxTime"],type = "range",
					get = function () return self.db.profile.maxtime end,
					set = function (v) self.db.profile.maxtime = v end,
					min = 2.0, max = 3600,
				},
			},
		},
		alert = {
			name = L["Alert"], desc = L["DescAlert"], type = "group",
			args = {
				delay = {
					name = L["Alert Delay"],desc = L["DescAlertDelay"],type = "range",
					get = function () return self.db.profile.alertdelay end,
					set = function (v) self.db.profile.alertdelay = v end,
					min = 1.0, max = 10,
				},		
				toggle = {
					name = L["Alert Toggle"], desc=L["DescAlertToggle"], type = "toggle",
					get = function () return self.db.profile.alert end,
					set = function (v) self.db.profile.alert = v end,
				},
				frame = {
					name = L["Alert Frame"], desc=L["DescAlertFrame"], type = "text",
					get = function () return self.db.profile.alertframe end,
					set = function (v) 
						if v == "msbt" or v == "sct" then
							if self.alert then self.alert = nil end
						elseif v == "default" then
							if not self.alert then 
								self.alert = self:CreateAlert("Alert will appear here!", 1,1,1)
							end
						end
						self.db.profile.alertframe = v 
					end, 
					validate = { "default", "sct", "msbt" },
				},
				fontsize = {
					name = L["Font Size"], desc = L["DescFontSize"], type = "range",
					get = function () return self.db.profile.alertfont end,
					set = function (v) 
						if self.alert then
							self.alert.Text:SetFont(L["Fonts\\skurri.ttf"], v, "THICKOUTLINE")
						end
						self.db.profile.alertfont = v 
					end,
					min = 8, max = 30,
				},
			},
		},				
		anchor = {name = L["Show Anchor"], desc = L["DescShowAnchor"], type = "execute", func = "ToggleAnchor"},
		test = {name = L["Test"],desc = L["DescTest"],type = "execute",func = "RunTestTimer"},
	}
	}

    -- register stuff 
	CooldownTimers:RegisterDB("CooldownTimersDB")
	CooldownTimers:RegisterDefaults('profile', defaults)

	CooldownTimers:RegisterChatCommand({"/cdt"}, args)
	
	-- create the anchor frame
	self.anchor = self:CreateAnchor(L["GUIAnchorString"], 0,1,0)
	
	-- create the alert frame
	if self.db.profile.alertframe == "default" then
		self.alert = self:CreateAlert("Alert will appear here!", 1,1,1)
	end
	
	-- bar textures
	self.textures = {
		["default"] = self.candy.var.defaults.texture, 
		["smooth"] = "Interface\\Addons\\CooldownTimers\\Textures\\smooth",
		["perl"] = "Interface\\Addons\\CooldownTimers\\Textures\\perl",
		["glaze"] = "Interface\\Addons\\CooldownTimers\\Textures\\glaze",
		["cilo"] = "Interface\\Addons\\CooldownTimers\\Textures\\cilo",
	}

	if( not self.spells ) then self.spells = {} end
	if( not self.delayed ) then self.delayed = {} end

	self:CreateCandyBarRegs()
	self:parseSpells()
end

function CooldownTimers:OnEnable()
	if( not self.spells ) then self.spells = {} end
	if( not self.delayed ) then self.delayed = {} end
	
	-- register events
	self:RefreshRegisteredEvents()
	
	-- parse spellbook
	self:parseSpells()
	
	-- reg metrognome for alert fadeout and item cds
	self:RegisterMetro("CooldownTimers_Alert", self.OnUpdate, .1, self) 
	self:RegisterMetro("CooldownTimers_Item", self.ScanBags, .1, self)
end
function CooldownTimers:OnDisable()
	-- unreg metro
	self:UnregisterMetro("CooldownTimers_Item")
	self:UnregisterMetro("CooldownTimers_Alert")
end
--[[--------------------------------------------------------------------------------
  Event Registering
-----------------------------------------------------------------------------------]]
-- CandyBar group registrations
function CooldownTimers:CreateCandyBarRegs()
	self.candy:RegisterCandyBarGroup("CooldownTimers")
	self.candy:SetCandyBarGroupPoint("CooldownTimers", "TOP", self.anchor, "BOTTOM", 0, 0)	
	self.candy:SetCandyBarGroupGrowth("CooldownTimers", self.db.profile.bargrowth) 
end

-- Event registrations
function CooldownTimers:RefreshRegisteredEvents()	
	self:RegisterEvent("AceEvent_FullyInitialized", "parseSpells")

	-- when addon taken out of standby
	if AceLibrary("AceEvent-2.0"):IsFullyInitialized() then
		self:parseSpells()
	end
	
	self:RegisterEvent("SPELLS_CHANGED", "parseSpells")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", function() self:parseSpells() self:UnregisterEvent("PLAYER_ENTERING_WORLD") end)
	
	-- delayed spells such as Cold Blood, Nature's Swiftness, Stealth and so on
	self:RegisterEvent("COMBAT_TEXT_UPDATE", "DelayedSpells")
	
	-- SpellStatus Events
	self:RegisterEvent("SpellStatus_SpellCastInstant", function (spellId, spellName) self:ParseSpellStatus(spellId, spellName) end)
	self:RegisterEvent("SpellStatus_SpellCastCastingFinish", function (spellId, spellName) self:ParseSpellStatus(spellId, spellName) end)
	self:RegisterEvent("SpellStatus_SpellCastChannelingStart", function (spellId, spellName) self:ParseSpellStatus(spellId, spellName) end)
		
	self:Debug("RefreshRegisteredEvents: Events registered")
	regevent = nil
end
--[[--------------------------------------------------------------------------------
  Event Parsing
-----------------------------------------------------------------------------------]]

-- Parse SpellStatus events
function CooldownTimers:ParseSpellStatus(spellId, spellName)
	if not self.spells then return end
	self:Debug("SpellStatus: "..spellName)
	
	-- check for skills		
	if self.spells[spellName] then
		self:Debug("Spell Found: "..self.spells[spellName])
				
		-- check if skill used was Preparation/Cold Snap	
		for k in resetSpells do
			if self:ReverseTranslateSpell(spellName) == k then self:ResetSpells(k) end
		end
		
		self:Debug("SpellStatus: Skill")
		self:CheckInfo(spellName, false, nil)				
	end
	
	-- check for items
	if (not spellId) and spellName then
		self:Debug("SpellStatus: Item")
		
		self.item = spellName
		self.icount = 0
		
		-- start metro if it's not running
		local _, _, run, _, _ = self:MetroStatus("CooldownTimers_Item")
		if (not run) then
			self:StartMetro("CooldownTimers_Item", 10)
		end
	end
end

function CooldownTimers:DelayedSpells(arg1, arg2)
	if arg1 == "AURA_END" then
		for spell in self.delayed do
			if spell == self:ReverseTranslateSpell(arg2) then
				self:CheckInfo(arg2, false, nil)
			end
		end
	end
end

function CooldownTimers:ResetSpells(spell)
	self:Debug( spell.." used!" )	
	if not resetSpells[spell] then return end
	
	for k,v in resetSpells[spell] do		
		if self.candy:IsCandyBarRegistered("CooldownTimers_"..self:TranslateSpell(v)) then 
			self:Debug( "Reset Skill used! Killing Bar: "..self:TranslateSpell(v))
			self.candy:StopCandyBar("CooldownTimers_"..self:TranslateSpell(v)) 
		end
	end
end

--[[--------------------------------------------------------------------------------
  Utility Functions
-----------------------------------------------------------------------------------]]
-- Parse SpellBook
function CooldownTimers:parseSpells()
	self:ParseSpellBook(BOOKTYPE_SPELL)
	--self:ParseSpellBook(BOOKTYPE_PET)
end

function CooldownTimers:ParseSpellBook(type)
	local i, n, n2, r, cd = 1
	self:Debug("Running - parseSpells")
	while true do
		n, r = GetSpellName(i, type)
		n2 = GetSpellName(i+1, type)
		
		if not n then do break end end
		
		if(n ~= n2) then
			self.gt:SetSpell(i, type)			
			cd = self.gt:GetLine(3, 1) or self.gt:GetLine(2, 1)
			
			if(cd) then
				local s = false
				local t = nil
				-- check for stealth/prowl/shadowmeld
				for k in delayedSpells do 
					if self:ReverseTranslateSpell(n) == k then s = true	end
				end	
				
				-- extract the cooldown in seconds
				if(self.def(cd, SPELL_RECAST_TIME_SEC)) then
					t = self.def(cd, SPELL_RECAST_TIME_SEC)
					self:Debug("%s has %s sec cooldown on %s", n, self.def(cd, SPELL_RECAST_TIME_SEC), r)
				elseif(self.def(cd, SPELL_RECAST_TIME_MIN)) then
					t = self.def(cd, SPELL_RECAST_TIME_MIN)*60
					self:Debug("%s has %s sec cooldown on %s", n, self.def(cd, SPELL_RECAST_TIME_MIN)*60, r)
				end
				
				-- insert into appropriate table
				if t then
					if s then
						self.delayed[n] = t
					else
						self.spells[n] = t
					end
				end
			end			
		end
		
		i = i + 1
	end
end

function CooldownTimers:ScanBags()
	if not (self.icount or self.item) then return end
	
	-- inc icount
	self.icount = self.icount + 1
	
	-- scan bags
	for b=0, 4 do
		for s=1, GetContainerNumSlots(b) do
			local texture = GetContainerItemInfo(b, s)
			if( texture ) then
				local _, duration, flag = GetContainerItemCooldown(b,s)
				if duration > self.db.profile.mintime and flag == 1 then
					local name = self:GetItemName(b, s)
					if string.find(name, self.item) then
						if not self.candy:IsCandyBarRegistered("CooldownTimers_"..name) then
							self:Debug("Found Item: "..name.." Duration: "..duration.." Cycles: "..self.icount)
							self:CheckInfo(name, duration, texture)		
							return	
						end						
					end
				end
			end
		end
	end
	
	-- scan inventory	
	for i=0, 19 do
		local texture = GetInventoryItemTexture("player", i)
		if( texture ) then
			local _, duration, flag = GetInventoryItemCooldown("player", i)
			if duration > self.db.profile.mintime and flag == 1 then
				local name = self:GetItemName(-1,i)
				if string.find(name, self.item) then
					if not self.candy:IsCandyBarRegistered("CooldownTimers_"..name) then
						self:Debug("Found Item: "..name.." Duration: "..duration.." Cycles: "..self.icount)
						self:CheckInfo(name, duration, texture)		
						return	
					end
				end
			end
		end
	end
	
	-- stop metro if item was not found
	if self.icount >= 9 then
		self:Debug("Stopping Metro! No Item Found.")		
		local _, _, run, _, _ = self:MetroStatus("CooldownTimers_Item")
		if run then
			self:StopMetro("CooldownTimers_Item")
		end
		
		-- nil out vars
		self.item = nil
		self.icount = nil
	end
end

-- returns the icon of a spell
function CooldownTimers:GetSpellIcon(spell)
	local icon = BS:GetSpellIcon(spell)
	return icon
end

function CooldownTimers:GetItemName(bag, slot)
	local linktext = nil
  
	if (bag == -1) then
		linktext = GetInventoryItemLink("player", slot)
	else
		linktext = GetContainerItemLink(bag, slot)
	end

	if linktext then
		local _,_,name = string.find(linktext, "^.*%[(.*)%].*$")
		return name
	else
		return ""
	end
end

function CooldownTimers:ReverseTranslateSpell(spell)
	-- change spell to english if it isnt
	if GetLocale() ~= "enUS" or GetLocale() ~= "enGB" then	
		if BS:HasReverseTranslation(spell) then 
			spell = BS:GetReverseTranslation(spell) 
		elseif L:HasReverseTranslation("Spell"..spell) then
			spell = L:GetReverseTranslation("Spell"..spell)
		else
			self:Debug("ReverseTranslateSpell: no reverse translation for spell: "..spell)
		end 
	end
	return spell
end

-- returns translation of a spell if it exists
function CooldownTimers:TranslateSpell(spell)
	-- if the locale isnt english then translate the spell back to the original locale (we're now done with parsing)
	if GetLocale() ~= "enUS" or GetLocale() ~= "enGB" then	
		if BS:HasTranslation(spell) then
			spell = BS:GetTranslation(spell) 
		elseif L:HasTranslation("Spell"..spell) then
			spell = L:GetTranslation("Spell"..spell)
		else
			self:Debug("TranslateSpell: no translation for spell: "..spell)
		end
	end
	return spell
end

--[[--------------------------------------------------------------------------------
  Main Processing
-----------------------------------------------------------------------------------]]
function CooldownTimers:RefreshAlert(spell)		
	if MikSBT and self.db.profile.alertframe == "msbt" then
		MikSBT.DisplayMessage(spell.." ready!", MikSBT.DISPLAYTYPE_NOTIFICATION, false, 255, 240, 240)
		return	
	elseif ( SCT_Display or ( SCT and SCT.DisplayText ) ) and self.db.profile.alertframe == "sct" then
		if SCT_Display_Message or ( SCT and SCT.DisplayMessage ) then
			if SCT_Display_Message then 
				SCT_Display_Message(spell.." ready!", {1, .9, .9})
			else
				SCT:DisplayMessage(spell.." ready!", {1, .9, .9})
			end
		end
		return
	else 
		if not self.alert then 
			self.alert = self:CreateAlert("Alert will appear here!", 1,1,1) 
		end
		
		local frame = self.alert
		
		frame.Text:SetText("|cff02ADFF"..spell.." |cffffffffready!")
		frame.delay = self.db.profile.alertdelay
		frame.alpha = 1
		frame:SetAlpha(1)
		frame:Show()
		
		--Start up onUpdate
		local _, _, run, _, _ = self:MetroStatus("CooldownTimers_Alert")
		if (not run) then
			self:StartMetro("CooldownTimers_Alert")
		end
	end
end

function CooldownTimers:OnUpdate(elapsed)
	if not self.alert then return end
	local frame = self.alert

	if (frame:IsShown()) then
		frame.delay = frame.delay - elapsed
		if frame.delay <= 0 then
			frame.alpha = frame.alpha - .1
			frame:SetAlpha(frame.alpha)
		end
		if (frame.alpha <= 0) then
			frame:Hide()
			frame:SetAlpha(1)
		end
	end
	
	local _, _, run, _, _ = self:MetroStatus("CooldownTimers_Alert")
	--if none are active, stop onUpdate
	if (not frame:IsShown() and (run)) then
		self:StopMetro("CooldownTimers_Alert")
	end
end

function CooldownTimers:CheckInfo(spell, item, itemtex)
	
	-- stop metro if after item was found
	if item then		
		self:Debug("Stopping Metro! Item Found:")
		local _, _, run, _, _ = self:MetroStatus("CooldownTimers_Item")
		if run then
			self:StopMetro("CooldownTimers_Item")
		end	
		self.icount = nil
		self.item = nil
	end
	
	-- is this spell being ignored?
	if self.db.profile.ignore[string.lower(spell)] then self:Debug( "StartTimer: "..spell.." ignored") return end

	-- check if spell exists
	if not (self.spells[spell] or self.delayed[spell] or item) then return end
	
	-- Duration
	local time = self.spells[spell] or self.delayed[spell] or item
	
	-- check for min/max time
	if time >= self.db.profile.mintime and time <= self.db.profile.maxtime then
		self:Debug("Skill: "..spell.." Time: "..time)
		-- passed all checks, on to the formatting!
		self:FormatBar(spell, time, itemtex)
	end
end

-- Formats the bar's appearance
function CooldownTimers:FormatBar(spell, time, itemtex)
	
	-- set bar texture
	local bartex = self.textures[self.db.profile.bartex]

	-- apply the colors
	local textcolor = self.db.profile.textcolor
	local bgcolor = self.db.profile.bgcolor
	local barcolor = self.db.profile.barcolor
	
	-- font size
	local font = self.db.profile.barfont
	
	-- set alpha
	local bgalpha = self.db.profile.bgalpha
	
	-- set size
	local barwidth = self.db.profile.barwidth
	local barheight = self.db.profile.barheight
	
	local barscale = self.db.profile.barscale
	
	-- set the texture 
	local texture = self:GetSpellIcon(spell) or itemtex
	
	-- formatting complete, start the bar 
	self:StartBar(spell, time, texture, bartex, font, barcolor, textcolor, bgcolor, bgalpha, barwidth, barheight, barscale)

end

-- Register and start the timer
function CooldownTimers:StartBar(spell, time, texture, bartex, font, barcolor, textcolor, bgcolor, bgalpha, barwidth, barheight, barscale)

	-- declare id var for ease of use 
	local id = "CooldownTimers_"..spell

	-- register the bar
	self.candy:RegisterCandyBar(id, time, spell, texture, barcolor, barcolor, "orange", "red")
	
	self.candy:SetCandyBarTexture(id, bartex)
	
	self.candy:SetCandyBarTextColor(id, textcolor)
	--self.candy:SetCandyBarTimerTextColor(id, textcolor, 1)
	self.candy:SetCandyBarFontSize(id, font)
	
	self.candy:SetCandyBarBackgroundColor(id, bgcolor, bgalpha)
	
	self.candy:SetWidth(id, barwidth)
	self.candy:SetHeight(id, barheight)
	self.candy:SetCandyBarScale(id, barscale)	
	
	self.candy:SetCandyBarFade(id, .5) 
	
	if self.db.profile.alert then
		self:Debug("Alert started! Spell: "..spell )
		self.candy:SetCandyBarCompletion(id, function(spell) self:RefreshAlert(spell) end, spell)
	end

	-- register bar with group
	self.candy:RegisterCandyBarWithGroup(id, "CooldownTimers")
	
	-- start this bitch!
	self.candy:StartCandyBar(id, true)
	
	self:Debug("StartBar: Bar started [ Spell: "..spell..", Time: "..time.."]")

	-- reset variables
	id, spell, time, texture, barcolor, textcolor, bgcolor = nil
end

--[[--------------------------------------------------------------------------------
  Command Handlers
-----------------------------------------------------------------------------------]]
-- Runs test bars
function CooldownTimers:RunTestTimer()
	--[[self.candy:RegisterCandyBar("CooldownTimers_Test", 10, L["GUITestBarText"], "Interface\\Icons\\Spell_Fire_Fireball02", "green", "green","red")
	self.candy:RegisterCandyBarWithGroup("CooldownTimers_Test", "CooldownTimers")
	
	self.candy:SetWidth("CooldownTimers_Test", self.db.profile.barwidth)
	self.candy:SetHeight("CooldownTimers_Test", self.db.profile.barheight)
	self.candy:SetCandyBarScale("CooldownTimers_Test", self.db.profile.barscale)
		
	self.candy:StartCandyBar("CooldownTimers_Test", true)]]
	
	self:FormatBar(L["GUITestBarText"], 10, "Interface\\Icons\\Spell_Fire_Fireball02")
	
	self:Debug("RunTestTimer: test bar started")
end

-- Toggles the vis of the anchors
function CooldownTimers:ToggleAnchor()
	if self.anchor:IsVisible() then
		self.anchor:Hide()
		if self.alert then
			self.alert:Hide()
			self.alert:RegisterForDrag()
			self.alert:SetMovable(false)
		end
	else
		self.anchor:Show()
		if self.alert then
			self.alert:SetAlpha(1)
			self.alert:Show()
			self.alert:RegisterForDrag("LeftButton")
			self.alert:SetMovable(true)
		end
	end
end

--[[--------------------------------------------------------------------------------
  GUI Constructors
-----------------------------------------------------------------------------------]]

-- Creates the anchor frames
function CooldownTimers:CreateAnchor(text, cRed, cGreen, cBlue)
	local f = CreateFrame("Button", nil, UIParent)
	f:SetWidth(200)
	f:SetHeight(25)
	
	f.owner = self
	
	if self.db.profile.barposition.x and self.db.profile.barposition.y then
		self:RestorePosition(f, self.db.profile.barposition.x, self.db.profile.barposition.y) 
	else
		f:SetPoint("CENTER", UIParent, "CENTER", 0, 50)
	end

	f:SetScript("OnDragStart", function() this:StartMoving() end )
	f:SetScript("OnDragStop",
		function()
			this:StopMovingOrSizing()
			local x, y = self:GetPosition(this)
			this.owner.db.profile.barposition.x = x
			this.owner.db.profile.barposition.y = y
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
	f.Text:SetWidth(200)
	f.Text:SetHeight(25)
	f.Text:SetPoint("TOPLEFT", f, "TOPLEFT")
	f.Text:SetJustifyH("CENTER")
	f.Text:SetJustifyV("MIDDLE")
	f.Text:SetText(text)
	
	f:Hide()

	return f
end

-- Creates the Alert Frame
function CooldownTimers:CreateAlert(text, cRed, cGreen, cBlue)
	local f = CreateFrame("Button",nil,UIParent)
	f:SetHeight(30)
	
	f.owner = self
		
	if self.db.profile.alertposition.x and self.db.profile.alertposition.y then
		self:RestorePosition(f, self.db.profile.alertposition.x, self.db.profile.alertposition.y) 
	else
		f:SetPoint("CENTER", UIParent, "CENTER", 0, 150)
	end
	
	f:SetScript("OnDragStart", function() this:StartMoving() end )
	f:SetScript("OnDragStop",
		function()
			this:StopMovingOrSizing()
			local x, y = self:GetPosition(this)			
			this.owner.db.profile.alertposition.x = x
			this.owner.db.profile.alertposition.y = y
        end)
	
	f.Text = f:CreateFontString(nil, "OVERLAY")
	f.Text:SetFont(L["Fonts\\skurri.ttf"], self.db.profile.alertfont, "THICKOUTLINE")
	f.Text:ClearAllPoints()
	f.Text:SetTextColor(cRed,cGreen,cBlue, 1)
	f.Text:SetHeight(28)
	f.Text:SetPoint("CENTER", f, "CENTER")
	f.Text:SetJustifyH("CENTER")
	f.Text:SetJustifyV("MIDDLE")
	f.Text:SetText(text)
	
	f.Text:SetWidth(f.Text:GetStringWidth()+10)
	f:SetWidth(f.Text:GetStringWidth())
	
	f:Hide()
	
	return f
end

function CooldownTimers:RestorePosition(frame, x, y)
	frame:ClearAllPoints()
	frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x, y)	
end

function CooldownTimers:GetPosition(frame)
	local _,_,_,x, y = frame:GetPoint()
			
	return math.floor(x), math.floor(y)
end