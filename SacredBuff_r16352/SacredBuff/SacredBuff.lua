--[[---------------------------------------------------------------------------------
 ADDON DECLARATION && SAVED VARIABLES && MENU INITIALIZATION
------------------------------------------------------------------------------------]]
SacredBuff = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0")
local L = AceLibrary("AceLocale-2.2"):new("SacredBuff")
local PT = AceLibrary("PeriodicTable-Core-2.0")
local BS = AceLibrary("Babble-Spell-2.2")
local G = AceLibrary("Gratuity-2.0")
local D = AceLibrary("Dewdrop-2.0")
local _G = getfenv(0)
local _, _, rev = string.find("$Rev: 16352 $", "(%d+)")
SacredBuff.fileRevisions = {
	["SacredBuff.lua"] = tonumber(rev),
	["UI.lua"] = 0
}
rev = nil

-- BINDINGS
-----------------------------------------------------------
BINDING_HEADER_SACREDBUFF = L["SacredBuff"]
BINDING_NAME_MOUNT = L["Mount"]
BINDING_NAME_RESURRECTION = BS["Resurrection"]

-- SAVED VARIABLES
-----------------------------------------------------------
SacredBuff:RegisterDB("SBDB", "SBPCDB")

SacredBuff:RegisterDefaults("profile", {
	movable = true,
	tooltip = 2,
	toggle = true,
	scaleSize = 1,
	smartRes = false
})

SacredBuff:RegisterDefaults("char", {
	groupMode = true,
	candleCount = 0,
	spells = {
		[ BS["Inner Fire"] ] = false,
		[ BS["Resurrection"] ] = false, 
		
		[ BS["Divine Spirit"] ] = false,
		[ BS["Power Word: Fortitude"] ] = false,
		[ BS["Shadow Protection"] ] = false,
		
		[ BS["Prayer of Spirit"] ] = false,
		[ BS["Prayer of Fortitude"] ] = false,
		[ BS["Prayer of Shadow Protection"] ] = false
	}
})

-- MENU INITIALIZATION
-----------------------------------------------------------
SacredBuff:RegisterChatCommand(L["Chat_Commands"], {
	type = "group",
	args = {
		[ L["Lock"] ] = {
			name = L["Lock"], type = "toggle",
			desc = L["(Un)Lock the SacredBuff frame."],
			map = { [false] = "|cffff0000"..L["On"].."|r", [true] = "|cff00ff00"..L["Off"].."|r" },
			get = function()
				return SacredBuff.db.profile.movable
			end,
			set = function()
				SacredBuff.db.profile.movable = not SacredBuff.db.profile.movable
				if ( SacredBuff.db.profile.movable ) then
					SacredBuff.frame.title:Show()
					SacredBuff.frame:SetBackdropColor(0.00, 0.00, 0.00, 0.60)
				else
					SacredBuff.frame.title:Hide()
					SacredBuff.frame:SetBackdropColor(0.00, 0.00, 0.00, 0.00)
				end
			end
		},
		[ L["Scale"] ] = {
			name = L["Scale"], type = "range",
			desc = L["Set the frame's scale."],
			min = 0.50, max = 2.00, isPercent = true,
			get = function() return SacredBuff.db.profile.scaleSize end,
			set = function(v)
				SacredBuff.db.profile.scaleSize = v
				SacredBuff:ScaleFrame()
			end,
		},
		[ "SmartRes" ] = {
			name = "SmartRes", type = "toggle",
			desc = L["Use the SmartRes mod for resurrecting other players."],
			disabled = function()
				if ( not _G["SmartRes"] ) then
					return true
				end
			end,
			get = function() return SacredBuff.db.profile.smartRes end,
			set = function()
				SacredBuff.db.profile.smartRes = not SacredBuff.db.profile.smartRes
			end
		},
		[ L["Tooltip"] ] = {
			name = L["Tooltip Options"], type = "group",
			desc = L["Select what information the tooltip provides."],
			args = {
				[ L["None"] ] = {
					name = L["No Tooltip"], type = "execute",
					desc = L["No tooltip will be displayed over the spell icons."],
					func = function()
						if ( SacredBuff.db.profile.tooltip ~= 0 ) then
							SacredBuff.db.profile.tooltip = 0
							SacredBuff:Print(L["Tooltips turned off."])
						end
					end
				},
				[ MANA ] = {
					name = L["Mana Only"], type = "execute",
					desc = L["Only the mana cost of the spell will be displayed in its tooltip."],
					func = function()
						if ( SacredBuff.db.profile.tooltip ~= 1 ) then
							SacredBuff.db.profile.tooltip = 1
							SacredBuff:Print(L["Tooltips will now display the spell's mana cost."])
						end
					end
				},
				[ L["Full"] ] = {
					name = L["Full Tooltip"], type = "execute",
					desc = L["The spell's full tooltip will be displayed on mouseover."],
					func = function()
						if ( SacredBuff.db.profile.tooltip ~= 2 ) then
							SacredBuff.db.profile.tooltip = 2
							SacredBuff:Print(L["Full spell tooltips will now be displayed."])
						end
					end
				}
			}
		}
	}
})


--[[---------------------------------------------------------------------------------
 LOCAL FUNCTIONS
------------------------------------------------------------------------------------]]
local function table_getn(t)
	local v = GetBuildInfo()
	if ( not string.find(v, "^2%.") ) then
		return table.getn(t)
	end
	return function() end
	-- return #t
end

local function newFindSpell(spell)
	local tbl
	local i = 1
	while true do
		local sName, sRank = GetSpellName(i, BOOKTYPE_SPELL)
		if ( not sName ) then
			do break end
		end
		if ( sName == spell ) then
			local rank
			if ( sRank ) then
				local _, _, r = string.find(sRank, RANK.."%s(%d+)")
				if ( r ) then
					rank = r
				end
			end
			if ( not rank ) then
				rank = 0
			end
			G:Erase()
			G:SetSpell(i, BOOKTYPE_SPELL)
			local _, _, manaCost = G:Find("(%d+)%s"..MANA, 2, 2, false, true)
			if ( not manaCost ) then
				manaCost = "0"
			end
			if ( not tbl ) then
				tbl = { i, rank, manaCost, sName }
			else
				if ( tbl[2] < rank ) then
					tbl[1] = i
					tbl[2] = rank
					tbl[3] = manaCost
				end
			end
		end
		i = i + 1
	end
	if ( tbl ) then
		return tbl
	end
	return false
end

local function finditem(id, literal, count, list)
	local iS
	if ( literal ) then
		iS = "item:"..id..":"
	end
	local c = 0
	local t
	if ( list ) then
		t = {}
	end
	for b = 0, NUM_BAG_FRAMES, 1 do
		for s = 1, GetContainerNumSlots(b), 1 do
			local iL = GetContainerItemLink(b, s)
			if ( iL ) then
				local f
				if ( literal ) then
					if ( string.find(iL, iS) ) then
						f = true
					end
				else
					if ( string.find(iL, id) ) then
						f = true
					end
				end
				if ( f ) then
					if ( list ) then
						table.insert(t, id)
					elseif ( count ) then
						local _, c2 = GetContainerItemInfo(b, s)
						c = c + c2
					else
						return b, s
					end
				end
			end
		end
	end
	if ( list ) then
		return t
	elseif ( count ) then
		return c
	end
end

local function ismounted()
	G:Erase()
	local c = 0
	while ( GetPlayerBuff(c, "HELPFUL|HARMFUL|PASSIVE") ~= -1 ) do
		local i = GetPlayerBuff(c, "HELPFUL|HARMFUL|PASSIVE")
		G:SetPlayerBuff(i)
		if ( G:Find(L["Increases speed by"]) ) then
			return i
		end
		c = c + 1
	end
end


--[[---------------------------------------------------------------------------------
 ADDON INITIALIZATION && ACTIVATION
------------------------------------------------------------------------------------]]
function SacredBuff:OnInitialize()
	self:CreateMainFrame()
	local _, class = UnitClass("player")
	if ( class ~= "PRIEST" ) then
		self:Print(L["You are not a Priest."])
		self:ToggleActive(false)
		self:Print(L["This addon has been disabled."])
		return
	else
		self:ToggleActive(true)
	end
	if ( self.db.profile.smartRes ) and ( not _G["SmartRes"] ) then
		self.db.profile.smartRes = not self.db.profile.smartRes
	end
end

function SacredBuff:OnEnable()
	if ( not self.db.char.numSpellTabs ) then
		self.db.char.numSpellTabs = GetNumSpellTabs()
	end

	self:LEARNED_SPELL_IN_TAB()
	
	self:RegisterBucketEvent("BAG_UPDATE", 2)
	self:RegisterEvent("ZONE_CHANGED", "BAG_UPDATE")
	self:RegisterEvent("LEARNED_SPELL_IN_TAB")
	
	local racials = {
		BS["Touch of Weakness"],
		BS["Shadowguard"],
		BS["Fear Ward"],
		BS["Elune's Grace"],
		BS["Feedback"]
	}
	for _, s in ipairs(racials) do
		local r = newFindSpell(s)
		if ( r ) then
			self.racial = r
			break
		end
	end
	
	self.frame:Show()
	
	self:UpdateButtons()
end

function SacredBuff:OnDisable()
	self.frame:Hide()
end


--[[---------------------------------------------------------------------------------
 EVENT HANDLERS
------------------------------------------------------------------------------------]]
function SacredBuff:BAG_UPDATE()
	self:UpdateCandleCount()
	if ( UnitLevel("player") < 40 ) then
		return
	end
	local t, aq = {}, nil
	if ( GetRealZoneText() ~= L["Ahn'Qiraj"] ) then
		for k in next, PT:GetSetTable("mounts") do
			table.insert(t, k)
		end
		aq = "preferredMount"
	else
		for k in next, PT:GetSetTable("mountsaq") do
			table.insert(t, k)
		end
		aq = "preferredAQMount"
	end
	self:FindMounts(t)
	if (( self.db.char[aq] ) and ( type(self.db.char[aq]) == "table" ) and ( table_getn(self.db.char[aq]) == 3 )) then
		self.db.char[aq][1], self.db.char[aq][2] = finditem(self.db.char[aq][3])
		if (( self.frame.mount ) and ( self.frame.mount.icon )) then
			local texture = GetContainerItemInfo(self.db.char[aq][1], self.db.char[aq][2])
			self.frame.mount.icon:SetTexture(texture)
		end
	end
end

local talents = {
	BS["Power Infusion"],
	BS["Lightwell"],
	BS["Shadowform"],
	BS["Inner Focus"]
}

function SacredBuff:LEARNED_SPELL_IN_TAB()
	for s in next, self.db.char.spells do
		local tbl = newFindSpell(s)
		if ( tbl ) then
			self.db.char.spells[s] = tbl
		else
			self.db.char.spells[s] = false
		end
	end
	for i = 1, 4, 1 do
		local tbl = newFindSpell(talents[i])
		if ( tbl ) then
			self.talent = tbl
			return
		end
	end
end


--[[---------------------------------------------------------------------------------
 MOUNT-RELATED FUNCTIONS
------------------------------------------------------------------------------------]]
function SacredBuff:UseMount()
	self:BAG_UPDATE()
	local isOnMount = ismounted()
	if ( isOnMount ) then
		CancelPlayerBuff(isOnMount)
		return
	end
	local aq = "preferredMount"
	if ( GetRealZoneText() == L["Ahn'Qiraj"] ) then
		aq = "preferredAQMount"
	end
	if (( self.db.char[aq] ) and ( type(self.db.char[aq]) == "table" ) and ( table_getn(self.db.char[aq]) == 3 )) then
		UseContainerItem(self.db.char[aq][1], self.db.char[aq][2])
		return true
	end
	local m
	local n = table_getn(self.mounts)
	if ( n == 0 ) then
		self:Print(L["There is no mount in your inventory."])
		return
	elseif ( n == 1 ) then
		m = self.mounts[1]
	else
		local t = GetTime()
		math.randomseed( math.random(1337) + GetTime() * 1000 )
		m = self.mounts[math.random(table_getn(self.mounts))]
	end
	UseContainerItem(m[1], m[2])
end

function SacredBuff:FindMounts(tbl)
	if ( self.mounts ) then
		local n = table_getn(self.mounts)
		for j = n, 1, -1 do
			self.mounts[j] = nil
		end
	end
	self.mounts = {}
	for i in ipairs(tbl) do
		local b, s = finditem(tbl[i], true)
		if (( b ) and ( s )) then
			local _, _, nm = string.find(GetContainerItemLink(b, s), "%[(.-)%]")
			table.insert(self.mounts, {b, s, nm})
		end
	end
	self:UpdateMountMenu()
end

function SacredBuff:UpdateMountMenu()
	if ( self.mountMenu ) then
		self.mountMenu = nil
	end
	self.mountMenu = {
		type = "group",
		args = {}
	}
	local aq = "preferredMount"
	if ( GetRealZoneText() == L["Ahn'Qiraj"] ) then
		aq = "preferredAQMount"
	end
	for i in ipairs(self.mounts) do
		local tbl = self.mounts[i]
		if ( not tbl[3] ) then
			return
		end
		self.mountMenu.args[string.gsub(tbl[3], "%s", "")] = {
			name = tbl[3], type = "toggle",
			desc = L["Select your preferred mount."],
			isRadio = true,
			get = function()
				if ( not SacredBuff.db.char[aq] ) then
					return false
				elseif ( SacredBuff.db.char[aq][3] ) then
					if ( SacredBuff.db.char[aq][3] == tbl[3] ) then
						return true
					end
				end
			end,
			set = function()
				SacredBuff.db.char[aq] = { tbl[1], tbl[2], tbl[3] }
				D:Refresh(1)
			end
		}
	end
	if (( SacredBuff.db.char[aq] ) and ( SacredBuff.frame.mount )) then
		local tbl = SacredBuff.db.char[aq]
		local texture = GetContainerItemInfo(tbl[1], tbl[2])
		SacredBuff.frame.mount.icon:SetTexture(texture)
	end
end


--[[---------------------------------------------------------------------------------
 OTHER MISCELLANEOUS YET REALLY NEAT-O FUNCTIONS
------------------------------------------------------------------------------------]]
function SacredBuff:UpdateSpellIcons()
	for k in next, self.frame do
		if (( k == "spirit" ) or ( k == "fort" ) or ( k == "shadow" )) then
			local t = self.frame[k]
			local i = 1
			if ( self.db.char.groupMode ) then
				i = i + 2
			end
			t.icon:SetTexture(t.info[i + 1])
			t:SetScript("OnClick", function()
				local onSelf
				if ( arg1 == "RightButton" ) then
					onSelf = true
				end
				CastSpellByName(t.info[i], onSelf)
			end)
			t:SetScript("OnEnter", function()
				if ( self.db.profile.tooltip == 0 ) then
					return
				end
				GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT")
				if ( self.db.profile.tooltip == 2 ) then
					GameTooltip:SetSpell(self.db.char.spells[ t.info[i] ][1], BOOKTYPE_SPELL)
				elseif ( self.db.profile.tooltip == 1 ) then
					GameTooltip:AddLine(self.db.char.spells[ t.info[i] ][3])
					GameTooltip:Show()
				end
			end)
		end
	end
end

function SacredBuff:UpdateCandleCount()
	self.db.char.candleCount = finditem(17029, true, true)
	if ( self.frame.main:GetText() ~= self.db.char.candleCount ) then
		self.frame.main:SetText(self.db.char.candleCount)
	end
end

function SacredBuff:Rezz()
	if (( self.db.profile.smartRes ) and ( _G["SmartRes"] ) and ( GetNumRaidMembers() > 0 )) then
		_G["SmartRes"]:Resurrect()
	else
		CastSpellByName(BS["Resurrection"])
	end
end

function SacredBuff:OnClick()
	if ( arg1 == "RightButton" ) then
		local x, y = finditem(6948, true)
		if ( y ) then
			UseContainerItem(x, y)
			return
		end
		SacredBuff:Print(L["There is no Hearthstone in your inventory."])
	else
		self.db.char.groupMode = not self.db.char.groupMode
		self:UpdateSpellIcons()
	end
end