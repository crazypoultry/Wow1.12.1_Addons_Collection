local dewdrop = AceLibrary("Dewdrop-2.0")
local tablet = AceLibrary("Tablet-2.0")
local jostle = AceLibrary("Jostle-2.0")
local crayon = AceLibrary:HasInstance("Crayon-2.0") and AceLibrary("Crayon-2.0") or nil

FuXP = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceDB-2.0", "AceEvent-2.0", "AceConsole-2.0")

local defaults = {
	FuBarFactionLink = false,
	TekAutoRepLink = false,
	WatchedFaction = false,
	Faction = -1,
	ShowText = "None",
	ShowRep = false,
	ShowXP = true,
	Shadow = true,
	Thickness = 2,
	Spark = 1,
	Spark2 = 1,
	BorderTop = true,
	XP = {0, 0.4,.9,1},
	Rest = {1, 0.2, 1, 1},
	None = {0.3,0.3,0.3,1},
	Rep = {1, 0.2, 1, 1},
	NoRep = {0, 0.3, 1, 1}
}
FuXP:RegisterDB("FuXPDB")
FuXP:RegisterDefaults('profile', defaults)

local L = AceLibrary("AceLocale-2.2"):new("FuXP")

function FuXP:GetXPColor()
	return self.db.profile.XP[1], self.db.profile.XP[2], self.db.profile.XP[3], self.db.profile.XP[4]
end

function FuXP:SetXPColor(r, g, b, a)
	self.db.profile.XP[1] = r
	self.db.profile.XP[2] = g
	self.db.profile.XP[3] = b
	self.db.profile.XP[4] = a
	self.XPBarTex:SetVertexColor(r, g, b, a)
	self.Spark:SetVertexColor(r, g, b, a)
end

function FuXP:GetRepColor()
	return self.db.profile.Rep[1], self.db.profile.Rep[2], self.db.profile.Rep[3], self.db.profile.Rep[4]
end

function FuXP:SetRepColor(r, g, b, a)
	self.db.profile.Rep[1] = r
	self.db.profile.Rep[2] = g
	self.db.profile.Rep[3] = b
	self.db.profile.Rep[4] = a
	self.RepBarTex:SetVertexColor(r, g, b, a)
	self.RepSpark:SetVertexColor(r, g, b, a)
end

function FuXP:GetNoRepColor()
	return self.db.profile.NoRep[1], self.db.profile.NoRep[2], self.db.profile.NoRep[3], self.db.profile.NoRep[4]
end

function FuXP:SetNoRepColor(r, g, b, a)
	self.db.profile.NoRep[1] = r
	self.db.profile.NoRep[2] = g
	self.db.profile.NoRep[3] = b
	self.db.profile.NoRep[4] = a
	self.NoRepTex:SetVertexColor(r, g, b, a)
end

function FuXP:GetRestColor()
	return self.db.profile.Rest[1], self.db.profile.Rest[2], self.db.profile.Rest[3], self.db.profile.Rest[4]
end

function FuXP:SetRestColor(r, g, b, a)
	self.db.profile.Rest[1] = r
	self.db.profile.Rest[2] = g
	self.db.profile.Rest[3] = b
	self.db.profile.Rest[4] = a
	self.RestedXPTex:SetVertexColor(r, g, b, a)
end

function FuXP:GetNoXPColor()
	return self.db.profile.None[1], self.db.profile.None[2], self.db.profile.None[3], self.db.profile.None[4]
end

function FuXP:SetNoXPColor(r, g, b, a)
	self.db.profile.None[1] = r
	self.db.profile.None[2] = g
	self.db.profile.None[3] = b
	self.db.profile.None[4] = a
	self.NoXPTex:SetVertexColor(r, g, b, a)
end

FuXP.hasIcon = true
FuXP.cannotDetachTooltip = true
FuXP.defaultPosition = "LEFT"
FuXP.hideWithoutStandby = true
FuXP.cannotAttachToMinimap = true

function FuXP:SetupMenu()
	FuXP:QueryFactions()
	local optionsTable = {
	type = 'group',
	args = {
		colours = {
			type = 'group',
			name = L["Colours"],
			desc = L["Set the Bar Colours"],
			args = {
				currentXP = {
					type = "color",
					name = L["Current XP"],
					desc = L["Sets the color of the XP Bar"],
					hasAlpha = true,
					get = "GetXPColor",
					set = "SetXPColor",
					order = 110,
				},
				restedXP = {
					type = 'color',
					name = L["Rested XP"],
					desc = L["Sets the color of the Rested Bar"],
					hasAlpha = true,
					get = "GetRestColor",
					set = "SetRestColor",
					order = 111,
				},
				color = {
					type = 'color',
					name = L["No XP"],
					desc = L["Sets the empty color of the XP Bar"],
					hasAlpha = true,
					get = "GetNoXPColor",
					set = "SetNoXPColor",
					order = 112,
				},
				rep = {
					type = 'color',
					name = L["Reputation"],
					desc = L["Sets the color of the Rep Bar"],
					hasAlpha = true,
					get = "GetRepColor",
					set = "SetRepColor",
					order = 113,
				},
				norep = {
					type = 'color',
					name = L["No Rep"],
					desc = L["Sets the empty color of the Reputation Bar"],
					hasAlpha = true,
					get = "GetNoRepColor",
					set = "SetNoRepColor",
					order = 114,
				},
			},
		},
		properties = {
			type = 'group',
			name = L["Properties"],
			desc = L["Set the Bar Properties"],
			args = {
				spark = {
					type = 'range',
					name = L["Spark intensity"],
					desc = L["Brightness level of Spark"],
					get = function() return FuXP.db.profile.Spark end,
					set = function(v) 
						FuXP.db.profile.Spark = v
						FuXP.Spark:SetAlpha(v)
						FuXP.Spark2:SetAlpha(v)
						FuXP.RepSpark:SetAlpha(v)
						FuXP.RepSpark2:SetAlpha(v)
					end,
					min = 0,
					max = 1,
					step = 0.05,
					order = 115
				},
				thickness = {
					type = 'range',
					name = L["Thickness"],
					desc = L["Sets thickness of XP Bar"],
					get = function() return FuXP.db.profile.Thickness end,
					set = function(v)
						FuXP:SetThickness(v)
					end,
					min = 1.5,
					max = 8,
					step = 0.1,
					order = 116
				},
				shadow = {
					type = 'toggle',
					name = L["Shadow"],
					desc = L["Toggles Shadow under XP Bar"],
					get = function() return FuXP.db.profile.Shadow end,
					set = function()
						FuXP.db.profile.Shadow = not FuXP.db.profile.Shadow
						if FuXP.db.profile.Shadow then FuXP.Border:Show() else FuXP.Border:Hide() end
					end,
					order = 117
				},
				showxp = {
					type = 'toggle',
					name = L["Show XP Bar"],
					desc = L["Show the XP Bar"],
					get = function() return FuXP.db.profile.ShowXP end,
					set = function()
						FuXP.db.profile.ShowXP = not FuXP.db.profile.ShowXP
						FuXP:Reanchor()
					end,
					order = 119
				},
				showrep = {
					type = 'toggle',
					name = L["Show Rep Bar"],
					desc = L["Show the Reputation Bar"],
					get = function() return FuXP.db.profile.ShowRep end,
					set = function()
						FuXP.db.profile.ShowRep = not FuXP.db.profile.ShowRep
						FuXP:Reanchor()
					end,
					order = 120
				},
				undocked = {
					type = 'text',
					usage = '<'..L['Location']..'>',
					name = L["Undocked Position"],
					desc = L["Selects which side of an undocked panel you want the bars on."],
					get = function() return FuXP.db.profile.UndockedLoc end,
					set = function(loc) 
						FuXP.db.profile.UndockedLoc = loc
						FuXP:Reanchor()
					end,
					validate = { ["Top"] = L["Top"], ["Bottom"] = L["Bottom"] },
					order = 123,
				}
			},
		},
		faction = {
			type = 'text',
			usage = '<'.. L["Faction"].. '>',
			name = L["Faction"],
			desc = L["Select Faction"],
			get = function() 
					if (FuXP.db.profile.WatchedFaction) then
						return "-2"
					else
						return FuXP.db.profile.Faction 
					end
				end,
			set = function(v) 
					if (v == "-2") then
						FuXP.db.profile.WatchedFaction = true
					else
						FuXP.db.profile.WatchedFaction = false
						FuXP.db.profile.Faction = v 
					end
					FuXP:QueryFactions()
					FuXP:Reanchor() end,
			validate = FuXP.FactionTable, 
			order = 121,
		},
		showtext = {
			type = 'text',
			usage = '<'..L["XP|Rep|None"]..'>',
			name = L["Show Text"],
			desc = L["Show the XP or Rep"],
			get = function() return FuXP.db.profile.ShowText end,
			set = function(show) FuXP.db.profile.ShowText = show end,
			validate = { ["XP"] = L["XP"], ["Rep"] = L["Rep"], ["None"] = L["None"] },
			order = 122
		},
	}
}
	if (FuBar_Factions or tekAutoRep) then
		optionsTable["args"]["hookins"] = {
			type = 'group',
			name = L["Hook-ins"],
			desc = L["Options to hook in other addons"],
			args = {},
			order = 123,
		}
	end

	-- If we have Fubar Factions... link them up or not...
	if (FuBar_Factions) then
		optionsTable["args"]["hookins"]["args"]["fubarfaction"] = {
			type = 'toggle',
			name = L["FuBar Faction Link"],
			desc = L["Link to FubBar Factions"],
			get  = function() return FuXP.db.profile.FuBarFactionLink end,
			set = function() 
					FuXP.db.profile.FuBarFactionLink = not FuXP.db.profile.FuBarFactionLink
					FuXP:QueryFactions()
			end,
			order = 124,
		}
	end

	-- if we have TekAutoRep... hook that up too...
	if (tekAutoRep) then
		optionsTable["args"]["hookins"]["args"]["tekautorep"] = {
			type = 'toggle',
			name = L["Tek AutoRep"],
			desc = L["Hook into TekAutoRep's automatic rep changes"],
			get = function() return FuXP.db.profile.TekAutoRepLink end,
			set = function()
					FuXP.db.profile.TekAutoRepLink = not FuXP.db.profile.TekAutoRepLink
					FuXP:QueryFactions()
			end,
			order = 125,
		}
	end

	FuXP.OnMenuRequest = optionsTable
	FuXP:RegisterChatCommand(L["AceConsole-commands"], optionsTable)
end

function FuXP:OnInitialize()
	FuXP.version = "2.1.".. string.sub("$Revision: 18668 $", 12, -3)
	local XPBar = CreateFrame("Frame", "FuXPBar", UIParent)
	local tex = XPBar:CreateTexture("XPBarTex")
	XPBar:SetFrameStrata("HIGH")
	tex:SetTexture("Interface\\AddOns\\FuBar_FuXPFu\\Textures\\texture.tga")
	tex:SetVertexColor(self.db.profile.XP[1], self.db.profile.XP[2], self.db.profile.XP[3], self.db.profile.XP[4])
	tex:ClearAllPoints()
	tex:SetAllPoints(XPBar)
	tex:Show()
	XPBar:SetHeight(self.db.profile.Thickness)
	
	local spark = XPBar:CreateTexture("XPSpark", "OVERLAY")
	spark:SetTexture("Interface\\AddOns\\FuBar_FuXPFu\\Textures\\glow.tga")
	spark:SetWidth(128)
	spark:SetHeight((self.db.profile.Thickness) * 8)
	spark:SetVertexColor(self.db.profile.XP[1], self.db.profile.XP[2], self.db.profile.XP[3], self.db.profile.Spark or 1)
	spark:SetBlendMode("ADD")

	local spark2 = XPBar:CreateTexture("XPSpark2", "OVERLAY")
	spark2:SetTexture("Interface\\AddOns\\FuBar_FuXPFu\\Textures\\glow2.tga")
	spark2:SetWidth(128)
	spark2:SetAlpha(self.db.profile.Spark or 1)
	spark2:SetHeight((self.db.profile.Thickness) * 8)
	spark2:SetBlendMode("ADD")

	local RestedXP = CreateFrame("Frame", "FuRestXPBar", UIParent)
	local restex = RestedXP:CreateTexture("RestedXPTex")
	restex:SetTexture("Interface\\AddOns\\FuBar_FuXPFu\\Textures\\texture.tga")
	restex:SetVertexColor(self.db.profile.Rest[1], self.db.profile.Rest[2], self.db.profile.Rest[3], self.db.profile.Rest[4])
	restex:ClearAllPoints()
	restex:Show()
	restex:SetAllPoints(RestedXP)
	RestedXP:SetHeight(self.db.profile.Thickness)

	local NoXP = CreateFrame("Frame", "FuNoXPBar", UIParent)
	local notex = NoXP:CreateTexture("NoXPTex")
	notex:SetTexture("Interface\\AddOns\\FuBar_FuXPFu\\Textures\\texture.tga")
	notex:SetVertexColor(self.db.profile.None[1], self.db.profile.None[2], self.db.profile.None[3], self.db.profile.None[4])
	notex:ClearAllPoints()
	notex:Show()
	notex:SetAllPoints(NoXP)
	NoXP:SetHeight(self.db.profile.Thickness)
	
	local Rep = CreateFrame("Frame", "FuRepBar", UIParent)
	Rep:SetFrameStrata("HIGH")
	local reptex = Rep:CreateTexture("RepTex")
	reptex:SetTexture("Interface\\AddOns\\FuBar_FuXPFu\\Textures\\texture.tga")
	reptex:SetVertexColor(self.db.profile.Rep[1], self.db.profile.Rep[2], self.db.profile.Rep[3], self.db.profile.Rep[4])
	reptex:ClearAllPoints()
	reptex:Show()
	reptex:SetAllPoints(Rep)
	Rep:SetHeight(self.db.profile.Thickness)

	local rspark = Rep:CreateTexture("RepSpark", "OVERLAY")
	rspark:SetTexture("Interface\\AddOns\\FuBar_FuXPFu\\Textures\\glow.tga")
	rspark:SetWidth(128)
	rspark:SetHeight((self.db.profile.Thickness) * 8)
	rspark:SetVertexColor(self.db.profile.Rep[1], self.db.profile.Rep[2], self.db.profile.Rep[3], self.db.profile.Spark or 1)
	rspark:SetBlendMode("ADD")

	local rspark2 = Rep:CreateTexture("RepSpark2", "OVERLAY")
	rspark2:SetTexture("Interface\\AddOns\\FuBar_FuXPFu\\Textures\\glow2.tga")
	rspark2:SetWidth(128)
	rspark2:SetAlpha(self.db.profile.Spark or 1)
	rspark2:SetHeight((self.db.profile.Thickness) * 8)
	rspark2:SetBlendMode("ADD")

	local NoRep = CreateFrame("Frame", "FuNoRepBar", UIParent)
	local noreptex = NoRep:CreateTexture("NoRepTex")
	noreptex:SetTexture("Interface\\AddOns\\FuBar_FuXPFu\\Textures\\texture.tga")
	noreptex:SetVertexColor(self.db.profile.NoRep[1], self.db.profile.NoRep[2], self.db.profile.NoRep[3], self.db.profile.NoRep[4])
	noreptex:ClearAllPoints()
	noreptex:Show()
	noreptex:SetAllPoints(NoRep)
	NoRep:SetHeight(self.db.profile.Thickness)

	Rep:SetFrameLevel(NoRep:GetFrameLevel() + 1) -- An attempt to fix the spark...

	local Border = CreateFrame("Frame", "BottomBorder", UIParent)
	local bordtex = Border:CreateTexture("BottomBorderTex")
	bordtex:SetTexture("Interface\\AddOns\\FuBar_FuXPFu\\Textures\\border.tga")
	bordtex:SetVertexColor(0, 0, 0, 1)
	bordtex:ClearAllPoints()
	bordtex:SetAllPoints(Border)
	Border:SetHeight(5)

	if not self.db.profile.Shadow then
		Border:Hide()
	end


	self.XPBar = XPBar
	self.XPBarTex = tex
	self.Spark = spark
	self.Spark2 = spark2
	self.NoXP = NoXP
	self.NoXPTex = notex
	self.RestedXP = RestedXP
	self.RestedXPTex = restex
	self.RepBar = Rep
	self.RepBarTex = reptex
	self.RepSpark = rspark
	self.RepSpark2 = rspark2
	self.NoRep = NoRep
	self.NoRepTex = noreptex
	self.Border = Border
	self.BorderTex = bordtex
	self.Spark:SetParent(self.XPBar)
	self.Spark2:SetParent(self.XPBar)
	self.RestedXP:SetParent(self.XPBar)
	self.NoXP:SetParent(self.XPBar)
	self.RepBar:SetParent(self.XPBar)
	self.RepSpark:SetParent(self.RepBar)
	self.RepSpark2:SetParent(self.RepBar)
	self.NoRep:SetParent(self.RepBar)
	self.Border:SetParent(self.XPBar)
end

function FuXP:OnEnable()
	self:RegisterEvent("UPDATE_EXHAUSTION", "UpdateBars")
	self:RegisterEvent("PLAYER_XP_UPDATE", "UpdateBars")
	self:RegisterEvent("UPDATE_FACTION", "UpdateBars")
	self:RegisterEvent("FuBar_ChangedPanels")
	self:RegisterEvent("tekAutoRep_NewFaction", "SetupMenu")

	self:ScheduleRepeatingEvent("XPFuBar", self.Reanchor, 3, self)
	self:ScheduleRepeatingEvent(self.name, self.Update, 1, self)

	MainMenuExpBar:Hide()
	ReputationWatchBar:Hide()
	ExhaustionTick:Hide()
end

function FuXP:OnDisable()
	-- you do not need to unregister the event here, all events/hooks are unregistered on disable implicitly.
	--self:Print("Disabling")
	self:HideBar()
	MainMenuExpBar:Show()
	ReputationWatchBar:Show()
	ExhaustionTick:Show()
end

function FuXP:FuBar_ChangedPanels()
	if (self.Loaded) then
		self:Reanchor()
		self:SetupMenu()
	end
end

function FuXP:Reanchor()
	local point, relpoint, y

	if (self.panel and self.panel["GetAttachPoint"]) then 
		self:CancelScheduledEvent("XPFuBar") 
	else return end

	self.Loaded = true
	self.Panel = self.panel
	self:SetupMenu()

	if (self.Panel:GetAttachPoint() == "BOTTOM") then
		self.Side = "BOTTOM"
		self.FuPanel = FuBar:GetTopmostBottomPanel()
		point = "BOTTOMLEFT"
		relpoint = "TOPLEFT"
		self.BorderTex:SetTexCoord(1,0,1,0)
		jostle:RegisterBottom(self.XPBar)
		jostle:RegisterBottom(self.RepBar)
		y = 1
	elseif (self.Panel:GetAttachPoint() == "TOP") then
		self.Side = "TOP"
		self.FuPanel = FuBar:GetBottommostTopPanel()
		point = "TOPLEFT"
		relpoint = "BOTTOMLEFT"
		self.BorderTex:SetTexCoord(1,0,0,1)
		jostle:RegisterTop(self.XPBar)
		jostle:RegisterTop(self.RepBar)
		y = -1
	else
		if (FuXP.db.profile.UndockedLoc == "Top") then
			self.Side = "BOTTOM"
			point = "BOTTOMLEFT"
			relpoint = "TOPLEFT"
			self.BorderTex:SetTexCoord(1,0,1,0)
			y = 1
		else
			self.Side = "TOP"
			point = "TOPLEFT"
			relpoint = "BOTTOMLEFT"
			self.BorderTex:SetTexCoord(1,0,0,1)
			y = -1
		end
		jostle:Unregister(self.XPBar)
		jostle:Unregister(self.RepBar)
		
	end
	if (not self.FuPanel) then
		self.FuPanel = self.panel
	end
	self.XPBar:ClearAllPoints()
	self.Spark:ClearAllPoints()
	self.NoXP:ClearAllPoints()
	self.Spark2:ClearAllPoints()
	self.RestedXP:ClearAllPoints()

	self.RepBar:ClearAllPoints()
	self.NoRep:ClearAllPoints()
	self.RepSpark:ClearAllPoints()
	self.RepSpark2:ClearAllPoints()

	self.Border:ClearAllPoints()
	if (self.db.profile.ShowXP) then
		self.XPBar:SetParent(self.FuPanel.frame)
		self.XPBar:SetPoint(point, self.FuPanel.frame, relpoint, 0, 0)
		self.Spark:SetPoint("RIGHT", self.XPBar, "RIGHT",11,0)
		self.Spark2:SetPoint("RIGHT", self.XPBar, "RIGHT",11,0)
		self.RestedXP:SetPoint("LEFT", self.XPBar, "RIGHT")
		self.NoXP:SetPoint("LEFT", self.RestedXP, "RIGHT")
	end
	if (self.db.profile.ShowRep) then
		if (self.db.profile.ShowXP) then
			self.RepBar:SetParent(self.FuPanel.frame)
			self.RepBar:SetPoint(point, self.FuPanel.frame, relpoint, 0, y * self.XPBar:GetHeight())
		else
			self.RepBar:SetParent(self.FuPanel.frame)
			self.RepBar:SetPoint(point, self.FuPanel.frame, relpoint, 0, 0)
		end
		self.NoRep:SetPoint("LEFT", self.RepBar, "RIGHT")
		self.RepSpark:SetPoint("RIGHT", self.RepBar, "RIGHT", 11, 0)
		self.RepSpark2:SetPoint("RIGHT", self.RepBar, "RIGHT", 11, 0)
	end
	self.Border:SetParent(self.db.profile.ShowRep and self.RepBar or self.XPBar)
	self.Border:SetPoint(point, self.db.profile.ShowRep and self.RepBar or self.XPBar, relpoint)
	self.RepBar:SetFrameLevel(self.NoRep:GetFrameLevel() + 1)
	self:ShowBar()
	self:UpdateBars()
	jostle:Refresh()
end

function FuXP:ShowBar()
	self:HideBar()	
	if (self.db.profile.ShowXP) then
		self.XPBar:Show()
		self.Spark:Show()
		self.Spark2:Show()
		self.RestedXP:Show()
		self.NoXP:Show()
	end
	if self.db.profile.Shadow then
		self.Border:Show()
	end
	if self.db.profile.ShowRep then
		self.RepBar:Show()
		self.RepSpark:Show()
		self.RepSpark2:Show()
		self.NoRep:Show()
	end
end

function FuXP:HideBar()
	self.XPBar:Hide()
	self.Spark:Hide()
	self.Spark2:Hide()
	self.RestedXP:Hide()
	self.NoXP:Hide()
	self.Border:Hide()
	self.RepBar:Hide()
	self.RepSpark:Hide()
	self.RepSpark2:Hide()
	self.NoRep:Hide()
end

function FuXP:SetThickness(thickness)
	self.XPBar:SetHeight(thickness)
	self.Spark:SetHeight((thickness) * 8)
	self.Spark2:SetHeight((thickness) * 8)
	self.RestedXP:SetHeight(thickness)
	self.NoXP:SetHeight(thickness)
	self.RepBar:SetHeight(thickness)
	self.RepSpark:SetHeight((thickness) * 8)
	self.RepSpark2:SetHeight((thickness) * 8)
	self.NoRep:SetHeight(thickness)
	self.db.profile.Thickness = thickness
	self:Reanchor()
	jostle:Refresh()
end

function FuXP:UpdateBars()
	if (not self.Loaded) then return end

	local name, description, standing, minRep, maxRep, currentRep = GetFactionInfo(self.db.profile.Faction)
	local total = self.Panel.frame:GetWidth()

	self.XPBar:SetWidth(0.001)
	self.RestedXP:SetWidth(0.001)
	self.NoXP:SetWidth(0.001)
	self.Border:SetWidth(total)
	if (self.db.profile.ShowXP) then
		if (UnitLevel("player") == MAX_PLAYER_LEVEL) then
			self.NoXP:SetWidth(total)
			return
		end
		local currentXP = UnitXP("player")
		local maxXP = UnitXPMax("player")
		local restXP = GetXPExhaustion() or 0
		local remainXP = maxXP - (currentXP + restXP)
		
		if (remainXP <= 0) then remainXP = 0 end

		self.XPBar:SetWidth((currentXP/maxXP)*total)
		if (((restXP + currentXP)/maxXP) > 1) then
			self.RestedXP:SetWidth(total - self.XPBar:GetWidth())
		else
			self.RestedXP:SetWidth((restXP/maxXP)*total + 0.001)
		end
		self.NoXP:SetWidth((remainXP/maxXP)*total)
	end
	if (self.db.profile.ShowRep) then
		self.RepBar:SetWidth(((currentRep - minRep)/(maxRep-minRep))*total)
		self.NoRep:SetWidth(((maxRep - currentRep)/(maxRep - minRep))*total)
	end
end

function FuXP:OnTextUpdate()
	if (not self.Loaded) then return end
	-- Setup watched factions
	if (self.db.profile.WatchedFaction) then
		self:QueryFactions(true)
	end
	if (self.db.profile.ShowText == "Rep") then
		local name, desc, standing, minRep, maxRep, currentRep = GetFactionInfo(self.db.profile.Faction)
		self:SetText(string.format(L["%s: %3.0f%% (%s/%s) %s left"], name, ((currentRep-minRep)/(maxRep-minRep))*100 , currentRep-minRep, maxRep-minRep, maxRep - currentRep))
	elseif (self.db.profile.ShowText == "XP") then
		local max, xp = UnitXPMax("player"), UnitXP("player")
		local toGo = max - xp
		local percentToGo = math.floor(toGo / max * 100)
		if crayon then
			toGo = "|cff"..crayon:GetThresholdHexColor(toGo, 0) .. toGo .. "|r"
			percentToGo = "|cff"..crayon:GetThresholdHexColor(percentToGo) .. percentToGo .. "|r"
		end
		self:SetText(string.format("%s (%s%%)", toGo, percentToGo))
	else
		self:SetText("FuXPFu")
	end
end

function FuXP:OnTooltipUpdate()
	if (not self.Loaded) then return end

	local totalXP = UnitXPMax("player")
	local currentXP = UnitXP("player")
	local toLevelXP = totalXP - currentXP
	local toLevelXPPercent = math.floor((currentXP / totalXP) * 100)
	local xp = tablet:AddCategory(
		'columns', 2
	)
	
	if (self.panel:GetAttachPoint() ~= self.Side) then
		self:Reanchor()
	end

	if (self.db.profile.ShowXP) then
		if (GetXPExhaustion()) then
			local xpEx = GetXPExhaustion()
			local xpExPercent = math.floor((GetXPExhaustion() / toLevelXP) * 100)
			if crayon then
				-- Scale: 1 - 100
				-- ExXP:  1 - toLevelXP
				xpEx = "|cff"..crayon:GetThresholdHexColor(xpEx, 1, toLevelXP * 0.25, toLevelXP * 0.5, toLevelXP * 0.75, toLevelXP) .. xpEx .. "|r"
				xpExPercent = "|cff"..crayon:GetThresholdHexColor(xpExPercent, 1, 25, 50, 75, 100) .. xpExPercent .. "|r"
			end
			xp:AddLine(
				'text', L["Rested XP"],
				'text2', string.format("%s (%s%%)", xpEx, xpExPercent)
			)
		end
		if crayon then
			-- /print "\124cff"..AceLibrary("Crayon-2.0"):GetThresholdHexColor(50, 1, 25, 50, 75, 100).."Test\124r"
			currentXP = "|cff"..crayon:GetThresholdHexColor(currentXP, 1, totalXP * 0.25, totalXP * 0.5, totalXP * 0.75, totalXP) .. currentXP .. "|r"
			toLevelXP = "|cff"..crayon:GetThresholdHexColor(toLevelXP, totalXP, totalXP * 0.75, totalXP * 0.5, totalXP * 0.25, 1) .. toLevelXP .. "|r"
			toLevelXPPercent = "|cff"..crayon:GetThresholdHexColor(toLevelXPPercent, 1, 25, 50, 75, 100) .. toLevelXPPercent .. "|r"
		end
		xp:AddLine(
			'text', L["Current XP"],
			'text2', string.format("%s/%s (%s%%)", currentXP, totalXP, toLevelXPPercent)
		)
		xp:AddLine(
			'text', L["To Level"],
			'text2', toLevelXP
		)
	end
	if (self.db.profile.ShowRep) then
		local name, desc, standing, minRep, maxRep, currentRep = GetFactionInfo(self.db.profile.Faction)
		xp:AddLine(
			'text', L["Faction"],
			'text2', name
		)
		xp:AddLine(
			'text', L["Rep to next standing"],
			'text2', maxRep - currentRep
		)
		xp:AddLine(
			'text', L["Current rep"],
			'text2', getglobal("FACTION_STANDING_LABEL"..standing)
		)
	end
	local Hint = ""

	Hint = L["Click to send your current xp to an open editbox."]
	Hint = Hint .. "\n"
	Hint = Hint ..L["Shift Click to send your current rep to an open editbox."]

	tablet:SetHint(Hint)
end

function FuXP:OnClick()
	local totalXP = UnitXPMax("player")
	local currentXP = UnitXP("player")
	local toLevelXP = totalXP - currentXP
	local name, desc, standing, minRep, maxRep, currentRep = GetFactionInfo(self.db.profile.Faction)

	if (not IsShiftKeyDown()) then
		DEFAULT_CHAT_FRAME.editBox:SetText(string.format(L["%s/%s (%3.0f%%) %d to go"], currentXP,totalXP, (currentXP/totalXP)*100, totalXP - currentXP))
	else
		DEFAULT_CHAT_FRAME.editBox:SetText(string.format(L["%s:%s/%s (%3.2f%%) Currently %s with %d to go"],
					name,
					currentRep - minRep,
					maxRep - minRep, 
					(currentRep-minRep)/(maxRep-minRep)*100,
					getglobal("FACTION_STANDING_LABEL"..standing),
					maxRep - currentRep))
	end
end

function FuXP:QueryFactions(noupdate)
	local watchedFaction
	FuXP.FactionTable = {["-2"] = L["Watched Faction"]}
	for factionIndex = 1, GetNumFactions() do
		local name, _, _, _, _ , _ ,_ ,_, isHeader = GetFactionInfo(factionIndex)

		if (self.db.profile.TekAutoRepLink or self.db.profile.Faction == -1 or self.db.profile.WatchedFaction) then
			watchedFaction = GetWatchedFactionInfo()
			if (name == watchedFaction) then
				self.db.profile.Faction = factionIndex
				if (noupdate) then return end
			end
		end

		if (self.db.profile.FuBarFactionLink and FuBar_Factions and FuBar_Factions.data and FuBar_Factions.data.monitor) then
			if (string.find(FuBar_Factions.data.monitor, name)) then
				self.db.profile.Faction = tostring(factionIndex)
			end
		end

		if (not isHeader) then
			self.FactionTable[tostring(factionIndex)] = name
		end
	end
end
