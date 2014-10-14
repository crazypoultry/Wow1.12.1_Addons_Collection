--[[ simpleMinimap ]]--
simpleMinimap = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "AceEvent-2.0", "AceHook-2.1", "AceModuleCore-2.0")
simpleMinimap:SetModuleMixins("AceEvent-2.0", "AceHook-2.1")
local L = AceLibrary("AceLocale-2.2"):new("simpleMinimap")


--[[ setup ]]--
--
function simpleMinimap:OnInitialize()
	self.inside = true
	self.buttons = {
		bgs = MiniMapBattlefieldFrame,
		meet = MiniMapMeetingStoneFrame,
		mail = MiniMapMailFrame,
		time = GameTimeFrame,
		track = MiniMapTrackingFrame,
		zoomin = MinimapZoomIn,
		zoomout = MinimapZoomOut
	}
	self.stratas = { "BACKGROUND", "LOW", "MEDIUM", "HIGH", "DIALOG", "FULLSCREEN", "FULLSCREEN_DIALOG", "TOOLTIP" }
	self.defaults = {
		alpha=1, lock=false, mapPosition=false, scale=1, strata=1,
		buttonPos = { bgs=302, meet=189, mail=169, time=137, track=38, zoomin=209, zoomout=235 },
		show = { bgs=true, location=true, locationText=true, mail=true, meet=true, time=true, track=true, zoom=true }
	}
	self.options = {
		type="group",
		args={
			title={
				type="header", order=1, name="simpleMinimap |cFFFFFFCCv"..self.version
			},
			spacer1={
				type="header", order=2
			},
			modules={
				type="group", order=3, name=L.modules, desc=L.modules_desc, args = {}
			},
			spacer2={
				type="header", order=4, name="---"
			},
			alpha={
				type="range", order=10, name=L.alpha, desc=L.alpha_desc,
				min=0, max=1, step=0.05, isPercent=true,
				get=function() return(self.db.profile.alpha) end,
				set=function(x) self.db.profile.alpha=x self:UpdateScreen() end
			},
			scale={
				type="range", order=11, name=L.scale, desc=L.scale_desc,
				min=0.5, max=2, step=0.05,
				get=function() return(self.db.profile.scale) end,
				set=function(x)
					if(self.db.profile.mapPosition) then
						self.db.profile.mapPosition.x = (self.db.profile.scale / x) * self.db.profile.mapPosition.x
						self.db.profile.mapPosition.y = (self.db.profile.scale / x) * self.db.profile.mapPosition.y
					end
					self.db.profile.scale = x
					self:UpdateScreen()
				end
			},
			show={
				type="group", order=12, name=L.show, desc=L.show_desc,
				args={
					bgs={
						type="toggle", order=1, name=L.bgs, desc=L.bgs_desc,
						get=function() return(self.db.profile.show.bgs) end,
						set=function(x) self.db.profile.show.bgs=x self:UpdateScreen() end
					},
					location={
						type="toggle", order=2, name=L.location, desc=L.location_desc,
						get=function() return(self.db.profile.show.location) end,
						set=function(x) self.db.profile.show.location=x self:UpdateScreen() end
					},
					locationText={
						type="toggle", order=3, name=L.locationText, desc=L.locationText_desc,
						get=function() return(self.db.profile.show.locationText) end,
						set=function(x) self.db.profile.show.locationText=x self:UpdateScreen() end
					},
					mail={
						type="toggle", order=4, name=L.mail, desc=L.mail_desc,
						get=function() return(self.db.profile.show.mail) end,
						set=function(x) self.db.profile.show.mail=x self:UpdateScreen() end
					},
					meet={
						type= "toggle", order=5, name=L.meet, desc=L.meet_desc,
						get=function() return(self.db.profile.show.meet) end,
						set=function(x) self.db.profile.show.meet=x self:UpdateScreen() end
					},
					time={
						type="toggle", order=6, name=L.time, desc=L.time_desc,
						get=function() return(self.db.profile.show.time) end,
						set=function(x) self.db.profile.show.time=x self:UpdateScreen() end
					},
					track={
						type="toggle", order=7, name=L.track, desc=L.track_desc,
						get=function() return(self.db.profile.show.track) end,
						set=function(x) self.db.profile.show.track=x self:UpdateScreen() end
					},
					zoom={
						type="toggle", order=8, name=L.zoom, desc=L.zoom_desc,
						get=function() return(self.db.profile.show.zoom) end,
						set=function(x) self.db.profile.show.zoom=x self:UpdateScreen() end
					}
				}
			},
			strata={
				type="range", order=13, name=L.strata, desc=L.strata,
				min=1, max=8, step=1,
				get=function() return(self.db.profile.strata) end,
				set=function(x) self.db.profile.strata=x self:UpdateScreen() end
			},
			spacer3={
				type="header", order=97, name="---"
			},
			lock={
				type="toggle", order=98, name=L.lock, desc=L.lock_desc,
				get=function() return(self.db.profile.lock) end,
				set=function(x) self.db.profile.lock=x self:UpdateScreen() end
			},
			reset={
				type="execute", order=99, name=L.reset, desc=L.reset_desc,
				func=function() StaticPopup_Show("smmRESET") end
			}
		}
	}
	self:RegisterDB("smmConfig", "smmConfigPC")
	self:RegisterDefaults("profile", self.defaults)
	self:RegisterChatCommand({"/simpleminimap", "/smm"}, self.options)
	StaticPopupDialogs["smmRESET"] = {
		text = L.reset_popup, button1 = TEXT(ACCEPT), button2 = TEXT(CANCEL),
		timeout = 30, whileDead = 1, hideOnEscape = 1,
		OnAccept = function() self:ResetDB("profile") self:UpdateScreen() end
	}
	if(self.db.profile.mapPosition) then self:LockFrame(MinimapCluster) self:LockFrame(Minimap) end
end
--
function simpleMinimap:OnEnable()
	MinimapCluster:SetMovable(true)
	Minimap:RegisterForDrag("LeftButton")
	Minimap:SetScript("OnDragStart", function() self:MapDrag(true) end)
	Minimap:SetScript("OnDragStop", function() self:MapDrag(false) end)
	MinimapZoneTextButton:RegisterForDrag("LeftButton")
	MinimapZoneTextButton:SetScript("OnDragStart", function() self:MapDrag(true) end)
	MinimapZoneTextButton:SetScript("OnDragStop", function() self:MapDrag(false) end)
	for _, f in pairs(self.buttons) do
		f:SetMovable(true)
		f:RegisterForDrag("LeftButton")
		f:SetScript("OnDragStart", function() self:ButtonDrag(true) end)
		f:SetScript("OnDragStop", function() self:ButtonDrag(false) end)
	end
	self:RegisterEvent("MINIMAP_UPDATE_ZOOM")
	for n in self:IterateModules() do self:ToggleModuleActive(self:GetModule(n),true) end
	self:UpdateScreen()
end
--
function simpleMinimap:OnDisable()
	for n in self:IterateModules() do self:ToggleModuleActive(self:GetModule(n),false) end
	self:UpdateScreen()
	MinimapCluster:SetMovable(false)
	Minimap:RegisterForDrag(nil)
	MinimapZoneTextButton:RegisterForDrag(nil)
	for _, f in pairs(self.buttons) do
		f:SetMovable(false)
		f:RegisterForDrag(nil)
	end
end
--
function simpleMinimap:Debug(text)
	if(ChatFrame2) then ChatFrame2:AddMessage(text, 0, 0.8, 1.0) end
end


--[[ events ]]--
--
function simpleMinimap:MINIMAP_UPDATE_ZOOM()
	local z = Minimap:GetZoom()
	if (GetCVar("minimapZoom") == GetCVar("minimapInsideZoom")) then
		if (z < 3) then
			Minimap:SetZoom(z + 1)
		else
			Minimap:SetZoom(z - 1)
		end
	else
		z = nil
	end
	if (tonumber(GetCVar("minimapInsideZoom")) == Minimap:GetZoom()) then
		self.inside = true
	else
		self.inside = false
	end
	if(MinimapCluster.smm_SetAlpha) then
		if(self.inside) then
			MinimapCluster:smm_SetAlpha(1)
		else
			MinimapCluster:smm_SetAlpha(self.db.profile.alpha)
		end
	end
	if(z) then Minimap:SetZoom(z) end
end


--[[ frame events ]]--
--
function simpleMinimap:MinimapMousewheel(x)
	if(x > 0) then Minimap_ZoomIn() else Minimap_ZoomOut() end
end
--
function simpleMinimap:MapDrag(kick)
	if(kick and not self.db.profile.lock) then
		MinimapCluster.isMoving = true
		MinimapCluster:StartMoving()
	elseif(MinimapCluster.isMoving) then
		MinimapCluster.isMoving = false
		MinimapCluster:StopMovingOrSizing()
		self:LockFrame(MinimapCluster)
		self.db.profile.mapPosition = {}
		self.db.profile.mapPosition.x, self.db.profile.mapPosition.y = MinimapCluster:GetCenter()
	end
end
--
function simpleMinimap:ButtonDrag(kick)
	local function getPos()
		local cx, cy = GetCursorPosition(UIParent)
		local mx, my = Minimap:GetLeft(), Minimap:GetBottom()
		local z = Minimap:GetEffectiveScale()
		return(math.deg(math.atan2(cy / z - my - 70, mx - cx / z + 70)))
	end
	if(kick and not self.db.profile.lock) then
		this.isMoving = true
		this:SetScript("OnUpdate", function()
			local x, y = self:GetButtonPos(getPos())
      		this:ClearAllPoints()
			this:SetPoint("TOPLEFT", Minimap, "TOPLEFT", x, y)
		end)
		this:StartMoving()
	elseif(this.isMoving) then
		this.isMoving = false
		this:StopMovingOrSizing()
		this:SetScript("OnUpdate", nil)
		for n, f in pairs(self.buttons) do
			if(f == this) then self.db.profile.buttonPos[n] = getPos() break end
		end
	end
end


--[[ screen updates ]]--
--
function simpleMinimap:UpdateScreen()
	if(self:IsActive() and self.db.profile.scale ~= self.defaults.scale) then
		if(not MinimapCluster.smm_SetScale) then
			MinimapCluster.smm_SetScale = MinimapCluster.SetScale
			MinimapCluster.SetScale = function() end
		end
		MinimapCluster:smm_SetScale(self.db.profile.scale)
	elseif(MinimapCluster.smm_SetScale) then
		MinimapCluster.SetScale = MinimapCluster.smm_SetScale
		MinimapCluster.smm_SetScale = nil
		MinimapCluster:SetScale(1)
	end
	if(self:IsActive() and self.db.profile.strata ~= self.defaults.strata) then
		if(not MinimapCluster.smm_SetFrameStrata) then
			MinimapCluster.smm_SetFrameStrata = MinimapCluster.SetFrameStrata
			MinimapCluster.SetFrameStrata = function() end
		end
		MinimapCluster:smm_SetFrameStrata(self.stratas[self.db.profile.strata])
	elseif(MinimapCluster.smm_SetFrameStrata) then
		MinimapCluster.SetFrameStrata = MinimapCluster.smm_SetFrameStrata
		MinimapCluster.smm_SetFrameStrata = nil
		MinimapCluster:SetFrameStrata("BACKGROUND")
	end
	if(self:IsActive() and self.db.profile.alpha ~= self.defaults.alpha) then
		if(not MinimapCluster.smm_SetAlpha) then
			MinimapCluster.smm_SetAlpha = MinimapCluster.SetAlpha
			MinimapCluster.SetAlpha = function() end
		end
		if(self.inside) then
			MinimapCluster:smm_SetAlpha(1)
		else
			MinimapCluster:smm_SetAlpha(self.db.profile.alpha)
		end
	elseif(MinimapCluster.smm_SetAlpha) then
		MinimapCluster.SetAlpha = MinimapCluster.smm_SetAlpha
		MinimapCluster.smm_SetAlpha = nil
		MinimapCluster:SetAlpha(1)
	end
	if(self:IsActive() and self.db.profile.mapPosition) then
		self:LockFrame(MinimapCluster)
		self:LockFrame(Minimap)
		MinimapCluster:smm_ClearAllPoints()
		MinimapCluster:smm_SetPoint("CENTER", UIParent, "BOTTOMLEFT", self.db.profile.mapPosition.x, self.db.profile.mapPosition.y)
	elseif(MinimapCluster.smmTouched) then
		self:UnlockFrame(MinimapCluster)
		self:UnlockFrame(Minimap)
		MinimapCluster:ClearAllPoints()
		MinimapCluster:SetPoint("TOPRIGHT", UIParent)
		MinimapCluster:SetUserPlaced(false)
	end
	for n, f in pairs(self.buttons) do
		local x, y
		if(self:IsActive()) then
			x, y = self:GetButtonPos(self.db.profile.buttonPos[n])
		else
			x, y = self:GetButtonPos(self.defaults.buttonPos[n])
		end
		f:ClearAllPoints()
		f:SetPoint("TOPLEFT", Minimap, "TOPLEFT", x, y)
	end
	for n in self.db.profile.show do
		if(n == "location") then
			if(not self:IsActive() or self.db.profile.show.location) then
				MinimapToggleButton:Show()
				MinimapBorderTop:Show()
				MinimapZoneTextButton:Show()
			else
				MinimapToggleButton:Hide()
				MinimapBorderTop:Hide()
				if(self.db.profile.show.locationText) then
					MinimapZoneTextButton:Show()
				else
					MinimapZoneTextButton:Hide()
				end
			end
		elseif(n == "locationText") then
			if(not self:IsActive() or self.db.profile.show.locationText) then
				MinimapZoneTextButton:Show()
			else
				MinimapZoneTextButton:Hide()
			end
		elseif(n == "zoom") then
			if(not self:IsActive() or self.db.profile.show.zoom) then
				MinimapZoomIn:Show()
				MinimapZoomOut:Show()
			else
				MinimapZoomIn:Hide()
				MinimapZoomOut:Hide()
			end
		elseif(self.buttons[n]) then
			local f = self.buttons[n]
			if(self:IsActive() and not self.db.profile.show[n]) then
				if(not f.smmTouched) then
					f.smmShow = f:IsShown()
					f.smm_Hide = f.Hide
					f.Hide = function() this.smmShow = nil end
					f.smm_Show = f.Show
					f.Show = function() this.smmShow = true end
					f.smmTouched = true
				end
				f:smm_Hide()
			elseif(f.smmTouched) then
				f.Hide = f.smm_Hide
				f.smm_Hide = nil
				f.Show = f.smm_Show
				f.smm_Show = nil
				f.smmTouched = nil
				if(f.smmShow) then f:Show() end
				f:SetUserPlaced(false)
			end
		end
	end
	for n in self:IterateModules() do
		self:GetModule(n):UpdateScreen()
	end
end


--[[ internal functions ]]--
--
function simpleMinimap:LockFrame(frame)
	if(not frame.smmTouched) then
		frame.smm_ClearAllPoints = frame.ClearAllPoints
		frame.smm_SetAllPoints = frame.SetAllPoints
		frame.smm_SetPoint = frame.SetPoint
		frame.ClearAllPoints = function() end
		frame.SetAllPoints = function() end
		frame.SetPoint = function() end
		frame.smmTouched = true
	end
end
--
function simpleMinimap:UnlockFrame(frame)
	if(frame.smmTouched) then
		frame.ClearAllPoints = frame.smm_ClearAllPoints
		frame.SetAllPoints = frame.smm_SetAllPoints
		frame.SetPoint = frame.smm_SetPoint
		frame.smm_ClearAllPoints = nil
		frame.smm_SetAllPoints = nil
		frame.smm_SetPoint = nil
		frame.smmTouched = nil
	end
end
--
function simpleMinimap:GetButtonPos(vector)
	if(simpleMinimap_Skins) then
		return simpleMinimap_Skins:GetButtonPos(vector)
	else
		return 52 - 81 * cos(vector), 81 * sin(vector) - 54
	end
end


--[[ module stuff ]]--
--
function simpleMinimap.modulePrototype:UpdateScreen() end
