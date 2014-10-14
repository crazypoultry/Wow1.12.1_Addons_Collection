BT2Circled = Bartender:NewModule("circled", "AceHook-2.1")

local L = AceLibrary("AceLocale-2.2"):new("BT2Circled")
local _G = getfenv(0)
local bars = {
	["Bar1"] = 12,
	["Bar2"] = 12,
	["Bar3"] = 12,
	["Bar4"] = 12,
	["Bar5"] = 12,
	
	["Bar6"] = 10,
	["Bar7"] = 10,
}
local skins = {
	["Serenity"] = {
		["icon"] 	= { w=26, h=25, x=6, y=-6, },
		["overlay"] = { w=43, h=43, x=-3, y=3, tex="Interface\\AddOns\\Bartender2_Circled\\textures\\serenity0", },
		["equip"] 	= { w=46, h=46, tex="Interface\\AddOns\\Bartender2_Circled\\textures\\serenity0", },
		["flash"]	= { w=30, h=30, x=3, y=-3, tex="Interface\\AddOns\\Bartender2_Circled\\textures\\overlayred" },
		["cooldown"]= { w=36, h=36, x=0, y=0, },
		["hotkey"]	= { x=3, y=-2, },
		["count"]	= { x=10, y=-6, },
		["bagicon"]	= { w=26, h=25, x=6, y=-6, },
		["autocast"]= { w=30, h=30, x=0, y=0, },
		["autocastable"]= { w=57, h=62, x=4, y=-4, },
		
		["NormalTexture"] 		= { w=1, h=1, x=-4, y=4, },
		["HighlightTexture"] 	= { w=43, h=43, x=-3, y=3, tex="Interface\\AddOns\\Bartender2_Circled\\textures\\serenity0", },
		["PushedTexture"] 		= { w=38, h=37, x=0, y=-1, tex="Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", },
		["CheckedTexture"]		= { w=38, h=37, x=0, y=-1, tex="Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", },
	},
	["Sprocket"] = {
		["icon"] 	= { w=26, h=25, x=6, y=-6, },
		["overlay"] = { w=43, h=43, x=-3, y=3, tex="Interface\\AddOns\\Bartender2_Circled\\textures\\Sprocket", },
		["equip"] 	= { w=46, h=46, tex="Interface\\AddOns\\Bartender2_Circled\\textures\\Sprocket", },
		["flash"]	= { w=30, h=30, x=3, y=-3, tex="Interface\\AddOns\\Bartender2_Circled\\textures\\overlayred" },
		["cooldown"]= { w=36, h=36, x=0, y=0, },
		["hotkey"]	= { x=3, y=-2, },
		["count"]	= { x=10, y=-6, },
		["bagicon"]	= { w=26, h=25, x=6, y=-6, },
		["autocast"]= { w=30, h=30, x=0, y=0, },
		["autocastable"]= { w=57, h=62, x=4, y=-4, },
		
		["NormalTexture"] 		= { w=1, h=1, x=-4, y=4, },
		["HighlightTexture"] 	= { w=43, h=43, x=-3, y=3, tex="Interface\\AddOns\\Bartender2_Circled\\textures\\Sprocket", },
		["PushedTexture"] 		= { w=38, h=37, x=0, y=-1, tex="Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", },
		["CheckedTexture"]		= { w=38, h=37, x=0, y=-1, tex="Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", },
	},
	["SprocketBlack"] = {
		["icon"] 	= { w=26, h=25, x=6, y=-6, },
		["overlay"] = { w=43, h=43, x=-3, y=3, tex="Interface\\AddOns\\Bartender2_Circled\\textures\\SprocketBlack", },
		["equip"] 	= { w=46, h=46, tex="Interface\\AddOns\\Bartender2_Circled\\textures\\SprocketBlack", },
		["flash"]	= { w=30, h=30, x=3, y=-3, tex="Interface\\AddOns\\Bartender2_Circled\\textures\\overlayred" },
		["cooldown"]= { w=36, h=36, x=0, y=0, },
		["hotkey"]	= { x=3, y=-2, },
		["count"]	= { x=10, y=-6, },
		["bagicon"]	= { w=26, h=25, x=6, y=-6, },
		["autocast"]= { w=30, h=30, x=0, y=0, },
		["autocastable"]= { w=57, h=62, x=4, y=-4, },
		
		["NormalTexture"] 		= { w=1, h=1, x=-4, y=4, },
		["HighlightTexture"] 	= { w=43, h=43, x=-3, y=3, tex="Interface\\AddOns\\Bartender2_Circled\\textures\\SprocketBlack", },
		["PushedTexture"] 		= { w=38, h=37, x=0, y=-1, tex="Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", },
		["CheckedTexture"]		= { w=38, h=37, x=0, y=-1, tex="Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", },
	},
	["SprocketSpark"] = {
		["icon"] 	= { w=26, h=25, x=6, y=-6, },
		["overlay"] = { w=43, h=43, x=-3, y=3, tex="Interface\\AddOns\\Bartender2_Circled\\textures\\SprocketSpark", },
		["equip"] 	= { w=46, h=46, tex="Interface\\AddOns\\Bartender2_Circled\\textures\\SprocketSpark", },
		["flash"]	= { w=30, h=30, x=3, y=-3, tex="Interface\\AddOns\\Bartender2_Circled\\textures\\overlayred" },
		["cooldown"]= { w=36, h=36, x=0, y=0, },
		["hotkey"]	= { x=3, y=-2, },
		["count"]	= { x=10, y=-6, },
		["bagicon"]	= { w=26, h=25, x=6, y=-6, },
		["autocast"]= { w=30, h=30, x=0, y=0, },
		["autocastable"]= { w=57, h=62, x=4, y=-4, },
		
		["NormalTexture"] 		= { w=1, h=1, x=-4, y=4, },
		["HighlightTexture"] 	= { w=43, h=43, x=-3, y=3, tex="Interface\\AddOns\\Bartender2_Circled\\textures\\SprocketSpark", },
		["PushedTexture"] 		= { w=38, h=37, x=0, y=-1, tex="Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", },
		["CheckedTexture"]		= { w=38, h=37, x=0, y=-1, tex="Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", },
	},
}

function BT2Circled:OnInitialize()
	self.db = Bartender:AcquireDBNamespace('Circled')
	Bartender:RegisterDefaults('Circled', 'profile', {
		colors = {
			normal 		= { r = 1.0, g = 1.0, b = 1.0, },
			hover 		= { r = 75/255, g = 216/255, b = 241/255, },
			equipped 	= { r = 28/255, g = 224/255, b = 18/255,},
		},
		applyskin = {
			Bar1 = true,
			Bar2 = true,
			Bar3 = true,
			Bar4 = true,
			Bar5 = true,
			Bar6 = true,
			Bar7 = true,
			bagbar = true,
		},
		skin = "Serenity",
	})
	
	if not skins[self.db.profile.skin] then
		self.db.profile.skin = "Serenity"
	end
	
	Bartender.options.args.circled = {
		name = L["Circled skin"],
		desc = L["Config for Circled skin"],
		type = "group",
		args = {
			skin = {
				name = L["Skin"], type = "text",
				desc = L["Select button skin."],
				get = function() return self.db.profile.skin end,
				set = function(v)
					self.db.profile.skin = v
					self:ChangeSkin()
				end,
				validate = {},
				order = 1,
			},
			colors = {
				name = L["Colors"], desc = L["Change ring colors."], type = "group", order = 2,
				args = {
					normal = {
						name = L["Normal"], desc = L["Normal ring color."], type = "color", order = 1,
						get = function()
							return self.db.profile.colors.normal.r, self.db.profile.colors.normal.g, self.db.profile.colors.normal.b
						end,
						set = function(r, g, b)
							self.db.profile.colors.normal.r, self.db.profile.colors.normal.g, self.db.profile.colors.normal.b = r, g, b
							self:UpdateColors()
						end,
					},
					hover = {
						name = L["Hover"], desc = L["Hover ring color."], type = "color", order = 2,
						get = function()
							return self.db.profile.colors.hover.r, self.db.profile.colors.hover.g, self.db.profile.colors.hover.b
						end,
						set = function(r, g, b)
							self.db.profile.colors.hover.r, self.db.profile.colors.hover.g, self.db.profile.colors.hover.b = r, g, b
							self:UpdateColors()
						end,
					},
					equipped = {
						name = L["Equipped"], desc = L["Equipped ring color."], type = "color", order = 3,
						get = function()
							return self.db.profile.colors.equipped.r, self.db.profile.colors.equipped.g, self.db.profile.colors.equipped.b
						end,
						set = function(r, g, b)
							self.db.profile.colors.equipped.r, self.db.profile.colors.equipped.g, self.db.profile.colors.equipped.b = r, g, b
							self:UpdateColors()
						end,
					},
				},
			},
			toggleskin = {
				name = L["Toggle"],
				desc = L["Toggle skin per bar."],
				type = "group",
				args = {
					bar8 = {
						name = L["bagbar"], type = "toggle",
						desc = L["Toggle skin on bagbar"],
						get = function()
							return self.db.profile.applyskin.bagbar
						end,
						set = function(v)
							self.db.profile.applyskin.bagbar = v
						end,
					},
				},
				order = 3,
			},
		}
	}
	
	for k in skins do
		table.insert(Bartender.options.args.circled.args.skin.validate, k)
	end
	
	for k in pairs(bars) do
		local barname = k
		Bartender.options.args.circled.args.toggleskin.args[barname] = {
			name = barname, type = "toggle",
			desc = string.format(L["Toggle skin on %s"], barname),
			get = function()
				return self.db.profile.applyskin[barname]
			end,
			set = function(v)
				self.db.profile.applyskin[barname] = v
			end,
		}
	end
	
	self:Hook("ActionButton_Update")
	self.applied = false
end

function BT2Circled:OnEnable()
	if not Bartender.db.profile.Extra.HideBorder then
		Bartender:ToggleBorder()
	end
	
	self:ChangeSkin()
	
	self.applied = true
end

function BT2Circled:ChangeSkin()
	local bar
	
	for bar in pairs(bars) do
		self:ApplySkin(bar)
	end
	
	self:ApplySkinBags()
	self:ApplySkinPet()
	self:UpdateColors()
end

function BT2Circled:ApplySkin(bar)
	if not self.db.profile.applyskin[bar] then return end
	local i, alias, name
	local buttonNum = bars[bar]

	for i=1, buttonNum do
		alias = format("%sButton%d", bar, i)
		name = _G[alias]:GetName()
		
		self:SkinNormalTexture(name)
		self:SkinHighlightTexture(name)
		self:SkinPushedTexture(name)
		self:SkinCheckedTexture(name)
		self:SkinFlashTexture(name)
		self:SkinIcon(name)
		self:SkinHotkey(name)
		self:SkinCount(name)
		self:SkinOverlay(name)
		self:SkinCooldown(name)
		self:SkinEquipBorder(name)
	end
end

function BT2Circled:ApplySkinBags()
	if not self.db.profile.applyskin.bagbar then return end
	
	local skin = skins[self.db.profile.skin].bagicon
	local i, alias, name
	
	for i=1, 5 do
		alias = format("Bar8Button%d", i)
		name = _G[alias]:GetName()

		_G[name.."IconTexture"]:SetWidth(skin.w)
		_G[name.."IconTexture"]:SetHeight(skin.h)
		_G[name.."IconTexture"]:ClearAllPoints()
		_G[name.."IconTexture"]:SetPoint("TOPLEFT", _G[name], "TOPLEFT", skin.x, skin.y)
		
		self:SkinNormalTexture(name)
		self:SkinHighlightTexture(name)
		self:SkinPushedTexture(name)
		self:SkinCheckedTexture(name)
		
		self:SkinOverlay(name)
	end
	
	self:SkinCheckedTexture("MainMenuBarBackpackButton")
end

function BT2Circled:ApplySkinPet()
	if not self.db.profile.applyskin.Bar7 then return end
	
	local skina = skins[self.db.profile.skin].autocastable
	local skinb = skins[self.db.profile.skin].autocast
	
	for i=1, 10 do
		alias = format("Bar7Button%d", i)
		name = _G[alias]:GetName()
		
		_G[name.."AutoCastable"]:ClearAllPoints()
		_G[name.."AutoCastable"]:SetWidth(57)
		_G[name.."AutoCastable"]:SetHeight(62)
		_G[name.."AutoCastable"]:SetDrawLayer("OVERLAY")
		_G[name.."AutoCastable"]:SetPoint("CENTER", _G[name], "CENTER", skina.x, skina.y)

		_G[name.."AutoCast"]:SetFrameLevel(2)
		_G[name.."AutoCast"]:SetWidth(30)
		_G[name.."AutoCast"]:SetHeight(30)
		_G[name.."AutoCast"]:ClearAllPoints()
		_G[name.."AutoCast"]:SetPoint("CENTER", _G[name.."Icon"], "CENTER", skinb.x, skinb.y)
	end
end

function BT2Circled:UpdateColors()
	local nc = self.db.profile.colors.normal
	local ec = self.db.profile.colors.equipped
	
	for bar, buttonNum in pairs(bars) do
		if self.db.profile.applyskin[bar] then
			for i=1, buttonNum do
				alias = format("%sButton%d", bar, i)
				name = _G[alias]:GetName()
				
				_G[name.."Overlay"]:SetVertexColor(nc.r, nc.g, nc.b)
				self:SkinHighlightTexture(name)
			end
		end
	end
	
	if self.db.profile.applyskin.bagbar then
		for i=1, 5 do
			alias = format("Bar8Button%d", i)
			name = _G[alias]:GetName()
			
			_G[name.."Overlay"]:SetVertexColor(nc.r, nc.g, nc.b)
			self:SkinHighlightTexture(name)
		end
	end
end

function BT2Circled:SkinNormalTexture(name)
	local skin = skins[self.db.profile.skin].NormalTexture
	local tex = _G[name]:GetNormalTexture()
	tex:SetTexture(skin.tex)
	tex:SetWidth(skin.w)
	tex:SetHeight(skin.h)
	tex:ClearAllPoints()
	tex:SetPoint("TOPLEFT", _G[name], "TOPLEFT", skin.x, skin.y)
	_G[name]:SetNormalTexture(tex)
end

function BT2Circled:SkinHighlightTexture(name)
	local hc = self.db.profile.colors.hover
	local skin = skins[self.db.profile.skin].HighlightTexture
	local tex = _G[name]:GetHighlightTexture()
	tex:SetVertexColor(hc.r, hc.g, hc.b)
	tex:SetTexture(skin.tex)
	tex:SetWidth(skin.w)
	tex:SetHeight(skin.h)
	tex:ClearAllPoints()
	tex:SetBlendMode("BLEND")
	tex:SetPoint("TOPLEFT", _G[name], "TOPLEFT", skin.x, skin.y)
	_G[name]:SetHighlightTexture(tex)
end

function BT2Circled:SkinPushedTexture(name)
	local skin = skins[self.db.profile.skin].PushedTexture
	local tex = _G[name]:GetPushedTexture()
	tex:SetTexture(skin.tex)
	tex:SetWidth(skin.w)
	tex:SetHeight(skin.h)
	tex:ClearAllPoints()
	if _G[name.."Icon"] then
		tex:SetPoint("CENTER", _G[name.."Icon"], "CENTER", skin.x, skin.y)
	elseif _G[name.."Icon"] then
		tex:SetPoint("CENTER", _G[name.."IconTexture"], "CENTER", skin.x, skin.y)
	end
	tex:SetDrawLayer("HIGHLIGHT")
	tex:SetBlendMode("ADD")
	_G[name]:SetPushedTexture(tex)
end

function BT2Circled:SkinCheckedTexture(name)
	local skin = skins[self.db.profile.skin].CheckedTexture
	local tex = _G[name]:GetCheckedTexture()
	tex:SetTexture(skin.tex)
	tex:SetWidth(skin.w)
	tex:SetHeight(skin.h)
	tex:ClearAllPoints()
	if _G[name.."Icon"] then
		tex:SetPoint("CENTER", _G[name.."Icon"], "CENTER", skin.x, skin.y)
	elseif _G[name.."Icon"] then
		tex:SetPoint("CENTER", _G[name.."IconTexture"], "CENTER", skin.x, skin.y)
	end
	tex:SetDrawLayer("OVERLAY")
	_G[name]:SetCheckedTexture(tex)
end

function BT2Circled:SkinIcon(name)
	local skin = skins[self.db.profile.skin].icon
	_G[name.."Icon"]:SetWidth(skin.w)
	_G[name.."Icon"]:SetHeight(skin.h)
	_G[name.."Icon"]:ClearAllPoints()
	_G[name.."Icon"]:SetPoint("TOPLEFT", _G[name], "TOPLEFT", skin.x, skin.y)
end

function BT2Circled:SkinCooldown(name)
	local skin = skins[self.db.profile.skin].cooldown
	_G[name.."Cooldown"]:SetFrameLevel(2)
	_G[name.."Cooldown"]:SetWidth(skin.w)
	_G[name.."Cooldown"]:SetHeight(skin.h)
	_G[name.."Cooldown"]:ClearAllPoints()
	_G[name.."Cooldown"]:SetPoint("CENTER", _G[name.."Icon"], "CENTER", skin.x, skin.y)
	_G[name.."Cooldown"]:SetScale(.7)
end

function BT2Circled:SkinHotkey(name)
	local skin = skins[self.db.profile.skin].hotkey
	_G[name.."HotKey"]:ClearAllPoints()
	_G[name.."HotKey"]:SetPoint("TOPRIGHT", _G[name], "TOPRIGHT", skin.x, skin.y)
	_G[name.."HotKey"]:SetDrawLayer("OVERLAY")
end

function BT2Circled:SkinCount(name)
	local skin = skins[self.db.profile.skin].count
	_G[name.."Count"]:ClearAllPoints()
	_G[name.."Count"]:SetPoint("CENTER", _G[name], "CENTER", skin.x, skin.y)
	_G[name.."Count"]:SetDrawLayer("OVERLAY")
end

function BT2Circled:SkinOverlay(name)
	local skin = skins[self.db.profile.skin].overlay
	local overlay
	
	if not _G[name.."Overlay"] then
		overlay = _G[name]:CreateTexture(name.."Overlay", "OVERLAY")
	else
		overlay = _G[name.."Overlay"]
	end

	overlay:SetTexture(skin.tex)
	overlay:SetWidth(skin.w)
	overlay:SetHeight(skin.w)
	overlay:SetPoint("TOPLEFT", _G[name], "TOPLEFT", -3, 3)
end

function BT2Circled:SkinEquipBorder(name)
	_G[name.."Border"]:SetWidth(1)
	_G[name.."Border"]:SetHeight(1)
	_G[name.."Border"]:SetPoint("TOPLEFT", _G[name], "TOPLEFT", 4, -4)
end

function BT2Circled:ActionButton_Update()
	local nc = self.db.profile.colors.normal
	local ec = self.db.profile.colors.equipped
	
	if _G[this:GetName().."Overlay"] then
		if IsEquippedAction(ActionButton_GetPagedID(this)) then
			_G[this:GetName().."Overlay"]:SetVertexColor(ec.r, ec.g, ec.b)
		else
			_G[this:GetName().."Overlay"]:SetVertexColor(nc.r, nc.g, nc.b)
		end
	end

	self.hooks["ActionButton_Update"]()
end

function BT2Circled:SkinFlashTexture(name)
	local skin = skins[self.db.profile.skin].flash
	if skin.tex then
		_G[name.."Flash"]:SetTexture(skin.tex)
	end

	_G[name.."Flash"]:SetAlpha(0.6)
	_G[name.."Flash"]:SetWidth(skin.w)
	_G[name.."Flash"]:SetHeight(skin.h)
	_G[name.."Flash"]:ClearAllPoints()
	_G[name.."Flash"]:SetPoint("TOPLEFT", _G[name], "TOPLEFT", skin.x, skin.y)
end