
local borders = {
	["Rounded"] 	= {	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16,
						edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16,
						insets = {left = 5, right = 5, top = 5, bottom = 5}},

	["Square"]	 	= {	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16,
						edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", edgeSize = 16,
						insets = {left = 5, right = 5, top = 5, bottom = 5}},

	["Black"] 		= {	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16,
						edgeFile = "", edgeSize = 0,
						insets = {left = 3, right = 3, top = 3, bottom = 3}},
}


Squeenix = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceHook-2.0", "AceDB-2.0", "AceConsole-2.0")


function Squeenix:OnInitialize()
	self:RegisterDB("SqueenixDB")
	self:RegisterDefaults("profile", {
		scale = 1,
		alpha = 1,
		style = "Square",
		lock = true,
-- Insert into Wildgirl
		trackx = -36,
		tracky = 12,
		mailx = -29,
		maily = -20,
		battlex = -5,
		battley = -138,
		meetx = 0,
		meety = -2,
-- end
	})

-- Init Position - Insert into Wildgirl
	if not self.db.profile.trackx then self.db.profile.trackx = -36 end
	if not self.db.profile.tracky then self.db.profile.tracky = 12 end
	if not self.db.profile.mailx then self.db.profile.mailx = -29 end
	if not self.db.profile.maily then self.db.profile.maily = -20 end
	if not self.db.profile.battlex then self.db.profile.battlex = -5 end
	if not self.db.profile.battley then self.db.profile.battlex = -138 end
	if not self.db.profile.meetx then self.db.profile.meetx = 0 end
	if not self.db.profile.meety then self.db.profile.meety = -2 end
-- end

	self.borderList = {}
	for k in pairs(borders) do table.insert(self.borderList,k) end

	self:RegisterChatCommand({"/squeenix", "/squee"}, {
		type = 'group',
		handler = Squeenix,
		args = {
			Reload = {
				name = "Reload",
				type = "execute",
				desc = "Reload the minimap frame, should fix blanked out maps",
				func = function() Minimap:SetMaskTexture("Interface\\AddOns\\Squeenix\\Mask.blp") end,
				order = 15,
			},
			Style = {
				name = "Style",
				type = 'text',
				desc = "StyleDesc",
				get = function() return self.db.profile.style end,
				set = "SetBorder",
				validate = Squeenix.borderList,
				order = 1,
			},
			Scale = {
				name = "scale",
				type = 'range',
				desc = "ScaleDesc",
				min = 0.5,
				max = 2,
				step = 0.05,
				isPercent = true,
				get = function() return self.db.profile.scale end,
				set = "SetScale",
				order = 7,
			},
			Alpha = {
				name = "alpha",
				type = 'range',
				desc = "ScaleDesc",
				min = 0.5,
				max = 1,
				step = 0.05,
				isPercent = true,
				get = function() return self.db.profile.alpha end,
				set = "SetAlpha",
				order = 8,
			},
			Locked = {
				name = "lock",
				type = 'toggle',
				desc = "LockedDesc",
				get = function() return self.db.profile.lock end,
				set = function(v) self.db.profile.lock = v end,
				order = 12,
			},

-- Insert into Wildgirl			
			TrackX = {
				type = 'range',
				name = "Tracking X",
				desc = "Tracking X",
				get = function() return self.db.profile.trackx end,
				set = function(v) 
					self.db.profile.trackx = v
					MiniMapTrackingFrame:ClearAllPoints()
					MiniMapTrackingFrame:SetScale(0.85)
					MiniMapTrackingFrame:SetPoint("TOPLEFT", Minimap,"TOPLEFT", self.db.profile.trackx, self.db.profile.tracky)
				end,
				min = -200,
				max = 200,
				step = 1,
				isPercent = false,
				order = 16
			},
			TrackY = {
				type = 'range',
				name = "Tracking Y",
				desc = "Tracking Y",
				get = function() return self.db.profile.tracky end,
				set = function(v) 
					self.db.profile.tracky = v
					MiniMapTrackingFrame:ClearAllPoints()
					MiniMapTrackingFrame:SetScale(0.85)
					MiniMapTrackingFrame:SetPoint("TOPLEFT", Minimap,"TOPLEFT", self.db.profile.trackx, self.db.profile.tracky)
				end,
				min = -200,
				max = 200,
				step = 1,
				isPercent = false,
				order = 17
			},

			MailX = {
				type = 'range',
				name = "Mail X",
				desc = "Mail X",
				get = function() return self.db.profile.mailx end,
				set = function(v) 
					self.db.profile.mailx = v
					MiniMapMailFrame:ClearAllPoints()
					MiniMapMailFrame:SetPoint("TOPLEFT", Minimap,"TOPLEFT", self.db.profile.mailx, self.db.profile.maily)
				end,
				min = -200,
				max = 200,
				step = 1,
				isPercent = false,
				order = 18
			},
			MailY = {
				type = 'range',
				name = "Mail Y",
				desc = "Mail Y",
				get = function() return self.db.profile.maily end,
				set = function(v) 
					self.db.profile.maily = v
					MiniMapMailFrame:ClearAllPoints()
					MiniMapMailFrame:SetPoint("TOPLEFT", Minimap,"TOPLEFT", self.db.profile.mailx, self.db.profile.maily)
				end,
				min = -200,
				max = 200,
				step = 1,
				isPercent = false,
				order = 19
			},

			BattleX = {
				type = 'range',
				name = "Battle X",
				desc = "Battle X",
				get = function() return self.db.profile.battlex end,
				set = function(v) 
					self.db.profile.battlex = v
					MiniMapBattlefieldFrame:ClearAllPoints()
					MiniMapBattlefieldFrame:SetPoint("TOPLEFT", Minimap,"TOPLEFT", self.db.profile.battlex, self.db.profile.battley)
				end,
				min = -200,
				max = 200,
				step = 1,
				isPercent = false,
				order = 20
			},
			BattleY = {
				type = 'range',
				name = "Battle Y",
				desc = "Battle Y",
				get = function() return self.db.profile.battley end,
				set = function(v) 
					self.db.profile.battley = v
					MiniMapBattlefieldFrame:ClearAllPoints()
					MiniMapBattlefieldFrame:SetPoint("TOPLEFT", Minimap,"TOPLEFT", self.db.profile.battlex, self.db.profile.battley)
				end,
				min = -200,
				max = 200,
				step = 1,
				isPercent = false,
				order = 21
			},

			MeetX = {
				type = 'range',
				name = "Meet X",
				desc = "Meet X",
				get = function() return self.db.profile.meetx end,
				set = function(v) 
					self.db.profile.meetx = v
					MiniMapMeetingStoneFrame:ClearAllPoints()
					MiniMapMeetingStoneFrame:SetPoint("TOPLEFT", Minimap,"TOPLEFT", self.db.profile.meetx, self.db.profile.meety)
				end,
				min = -200,
				max = 200,
				step = 1,
				isPercent = false,
				order = 22
			},
			MeetY = {
				type = 'range',
				name = "Meet Y",
				desc = "Meet Y",
				get = function() return self.db.profile.meety end,
				set = function(v) 
					self.db.profile.meety = v
					MiniMapMeetingStoneFrame:ClearAllPoints()
					MiniMapMeetingStoneFrame:SetPoint("TOPLEFT", Minimap,"TOPLEFT", self.db.profile.meetx, self.db.profile.meety)
				end,
				min = -200,
				max = 200,
				step = 1,
				isPercent = false,
				order = 23
			},
--end
		}
	})
end


function Squeenix:OnEnable()
	MinimapBorder:SetTexture("")
	MinimapBorderTop:Hide()

	self.frame = CreateFrame("Button", nil, Minimap)
	self.frame:SetPoint("TOPLEFT","Minimap",-5,5)
	self.frame:SetPoint("BOTTOMRIGHT","Minimap",5,-5)

	self:SetBorder()
	self.frame:SetBackdropColor(0,0,0,1)
	self.frame:SetFrameStrata("BACKGROUND")
	self.frame:SetFrameLevel(1)

	Minimap:SetMovable(true)
	Minimap:EnableMouse(true)
	Minimap:RegisterForDrag("LeftButton")

	Minimap:SetScript("OnDragStart", function() if not self.db.profile.lock then Minimap:StartMoving() end end)
	Minimap:SetScript("OnDragStop", function()
		Minimap:StopMovingOrSizing()
		self.db.profile.position.point = "CENTER"
		self.db.profile.position.relativePoint = "BOTTOMLEFT"
		self.db.profile.position.relativeTo = "UIParent"
		self.db.profile.position.x, self.db.profile.position.y = Minimap:GetCenter()
	end)

	Minimap:SetMaskTexture("Interface\\AddOns\\Squeenix\\Mask.blp")

	MinimapZoom = CreateFrame("Frame", nil, Minimap)
	MinimapZoom:SetFrameStrata("LOW")
	MinimapZoom:EnableMouse(false)
	MinimapZoom:SetPoint("TOPLEFT", Minimap, "TOPLEFT")
	MinimapZoom:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT")
	MinimapZoom:EnableMouseWheel(true)
	MinimapZoom:SetScript("OnMouseWheel", function() Squeenix:OnMouseWheel() end)

	MinimapZoneTextButton:SetPoint("CENTER", Minimap, "CENTER", -10, 83)
	MinimapZoneTextButton:SetScript("OnClick", ToggleMinimap)

	MinimapZoneText:SetPoint("TOP", MinimapZoneTextButton,"TOP",9,1)
	MiniMapTrackingFrame:SetPoint("TOPLEFT", Minimap,"TOPLEFT",0,-2)

	MinimapToggleButton:Hide()
	MinimapZoomIn:Hide()
	MinimapZoomOut:Hide()
	GameTimeFrame:Hide()

-- Insert into Wildgirl
	MiniMapTrackingFrame:ClearAllPoints()
	MiniMapTrackingFrame:SetScale(0.85)
	MiniMapTrackingFrame:SetPoint("TOPLEFT", Minimap,"TOPLEFT", self.db.profile.trackx, self.db.profile.tracky)
	MiniMapMailFrame:ClearAllPoints()
	MiniMapMailFrame:SetPoint("TOPLEFT", Minimap,"TOPLEFT", self.db.profile.mailx, self.db.profile.maily)
	MiniMapMeetingStoneFrame:ClearAllPoints()
	MiniMapMeetingStoneFrame:SetPoint("TOPLEFT", Minimap,"TOPLEFT", self.db.profile.meetx, self.db.profile.meety)
	MiniMapBattlefieldFrame:ClearAllPoints();
	MiniMapBattlefieldFrame:SetPoint("TOPLEFT", Minimap,"TOPLEFT", self.db.profile.battlex, self.db.profile.battley)
-- end
	if not self.db.profile.position then
		self.db.profile.position = {point = "CENTER", realtivePoint = "TOP", relativeTo="MinimapCluster", x = 9, y = -92}
	else
		Minimap:SetPoint(self.db.profile.position.point, self.db.profile.relativeTo, self.db.profile.position.relativePoint,
			self.db.profile.position.x, self.db.profile.position.y)
	end

	self:SetAlpha()
	self:SetScale()
end


function Squeenix:OnMouseWheel()
	if arg1 > 0 then MinimapZoomIn:Click()
	elseif arg1 < 0 then MinimapZoomOut:Click() end
end


function Squeenix:SetBorder(v)
	if v then self.db.profile.style = v end
	self.frame:SetBackdrop(borders[self.db.profile.style])
	self.frame:SetBackdropColor(0,0,0,1)
end


function Squeenix:SetAlpha(v)
	if v then self.db.profile.alpha = v end
	self.frame:SetAlpha(self.db.profile.alpha)
end


function Squeenix:SetScale(v)
	if v then self.db.profile.scale = v end
	Minimap:SetScale(self.db.profile.scale)
end
