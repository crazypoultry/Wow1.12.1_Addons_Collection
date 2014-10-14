local Defaults = {
	min = 1.5,
	max = 600,
	growth = true,
}

oCD = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDebug-2.0", "AceDB-2.0", "AceHook-2.0", "AceConsole-2.0", "CandyBar-2.0")
oCD:RegisterDB("oCDDB")
oCD:RegisterDefaults('profile', Defaults)

function oCD:OnInitialize()
	local Options = {
		type="group",
		args = {
			lock = {
				name = "Lock", type = "toggle",
				desc = "Lock the frame",
				get = function() return self.db.profile.locked end,
				set = function(v) self:toggleMove(v) end,
			},
			min = {
				name = "Minimum cooldown", type = 'range',
				desc = "Set the minimum cooldown that will be shown (seconds).",
				get = function() return self.db.profile.min end,
				set = function(v) self.db.profile.min = v end,
				min = 0,
				max = 120,
			},
			max = {
				name = "Maximum cooldown", type = 'range',
				desc = "Set the maximum cooldown that will be shown (seconds).",
				get = function() return self.db.profile.max end,
				set = function(v) self.db.profile.max = v end,
				min = 120,
				max = 86400,
			},
			growth = {
				name = "Bars", type = "toggle",
				message = "%s will grow: [%s]",
				map = { [false] = "Down", [true] = "Up" },
				desc = "Bar growth direction",
				get = function() return self.db.profile.growth end,
				set = function(v)
					self.db.profile.growth = v
					self:SetCandyBarGroupGrowth("oCD", self.db.profile.growth)
				end,
			},
		}
	}
	
	self.gra = AceLibrary("Gratuity-2.0")
	self.def = AceLibrary("Deformat-2.0")
	
	self:CreateFrame()
	
	self:RegisterCandyBarGroup("oCD")
	self:SetCandyBarGroupPoint("oCD", "TOP", self.frame, "TOP", 0, -12)
	self:RegisterChatCommand({ "/oCD"}, Options)
	
	self.debugFrame = ChatFrame7
end

function oCD:OnEnable()
	if( not self.spells) then self.spells = {} end
	
	self:SetCandyBarGroupGrowth("oCD", self.db.profile.growth)
	
	self:Events()
	
	self:Hook("CooldownFrame_SetTimer")
end

function oCD:Events()
	self:RegisterEvent("SPELLS_CHANGED", "parseSpells")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", function() self:parseSpells() self:UnregisterEvent("PLAYER_ENTERING_WORLD") end)
end

function oCD:parseSpells()
	self:ParseSpellBook(BOOKTYPE_PET)
	self:ParseSpellBook(BOOKTYPE_SPELL)
end

function oCD:CreateFrame()
	self.frame = CreateFrame("Frame", "oCDFrame", UIParent)
	self.frame:EnableMouse(true)
	self.frame:SetMovable(true)
        self.frame:SetWidth(236)
        self.frame:SetHeight(56)
	
	self.frame.title = self.frame:CreateFontString(nil, "ARTWORK","TextStatusBarText")
	self.frame.title:SetText("oCD")
	self.frame.title:SetPoint("TOP",0, 0)
	
	self.frame:SetBackdrop( { 
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", 
		edgeFile = "", tile = true, tileSize = 16, edgeSize = 16, 
		insets = { left = 5, right = 5, top = 5, bottom = 5 }
	})
	self.frame:SetBackdropColor(0, 0, 0, .6)
	
	self.frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	self.frame:SetScript("OnMouseDown",function()
		if ( arg1 == "LeftButton" ) then
			this:StartMoving()
		end
	end)
	self.frame:SetScript("OnMouseUp",function()
		if ( arg1 == "LeftButton" ) then
			this:StopMovingOrSizing()
			self:savePosition()
		end
	end)
	
	if(self.db.profile.locked) then
		self.frame:Hide()
	end
	
	self:updatePositions()
end

function oCD:toggleMove(a1)
	self.db.profile.locked = a1
	if a1 then
		self.frame:Hide()
	else
		self.frame:Show()
	end
end

function oCD:updatePositions()
	if(self.db.profile.pos) then
		local z = self:Split(self.db.profile.pos, " ")
		local s = self.frame:GetEffectiveScale()
		
		self.frame:ClearAllPoints()
		self.frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", z[1]/s, z[2]/s)
	else
		self.frame:ClearAllPoints()
		self.frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	end
end

function oCD:savePosition()
	local f = self.frame
	local x,y = f:GetLeft(), f:GetTop()
	local s = f:GetEffectiveScale()
	
	x,y = x*s,y*s
	
	self.db.profile.pos = string.format("%s %s", x, y)
end

function oCD:ParseSpellBook(type)
	local i, n, n2, r, cd = 1
	self:Debug("Running - ParseSpellBook - %s", type)
	while true do
		n, r = GetSpellName(i, type)
		n2 = GetSpellName(i+1, type)
		if not n then
			do break end
		end
		
		if(n ~= n2) then
			self.gra:SetSpell(i, type)
			
			cd = self.gra:GetLine(3, 1) or self.gra:GetLine(2, 1)
			
			if(cd) then
				if(self.def(cd, SPELL_RECAST_TIME_SEC)) then
					self.spells[n]= GetSpellTexture(i, type)
					self:Debug("%s has %s sec cooldown on %s || %s", n, self.def(cd, SPELL_RECAST_TIME_SEC), r, cd)
				elseif(self.def(cd, SPELL_RECAST_TIME_MIN)) then
					self.spells[n] = GetSpellTexture(i, type)
					self:Debug("%s has %s sec cooldown on %s || %s", n, self.def(cd, SPELL_RECAST_TIME_MIN)*60, r, cd)
				end
			end
		end
		
		i = i + 1
	end
end

function oCD:StartBar(id, time, text, icon)
	id = "oCD_"..id
	if(self:IsCandyBarRegistered(id)) then return end
	
	if(time > tonumber(self.db.profile.min) and time < tonumber(self.db.profile.max)) then
		self:Debug("StartBar - %s | %s", text, time)
		
		self:RegisterCandyBar(id, time, text, icon, "Green", "Orange", "Red")
		self:RegisterCandyBarWithGroup(id, "oCD")
		self:SetCandyBarFade(id, 1)
		self:StartCandyBar(id, 1)
	end
end

function oCD:Split(msg, char)
	local arr = { };
	while (string.find(msg, char) ) do
		local iStart, iEnd = string.find(msg, char);
		tinsert(arr, strsub(msg, 1, iStart-1));
		msg = strsub(msg, iEnd+1, strlen(msg));
	end
	if ( strlen(msg) > 0 ) then
		tinsert(arr, msg);
	end
	return arr;
end