--[[ >> cerenity Circled (cyCircled) << ]]

cyCircled = AceLibrary("AceAddon-2.0"):new(
    "AceHook-2.1", 
    "AceConsole-2.0", 
    "AceDB-2.0", 
    "AceEvent-2.0",
	"AceModuleCore-2.0",
	"FuBarPlugin-2.0"
)
cyCircled:SetModuleMixins("AceHook-2.1")

local _G = getfenv(0)
local L = AceLibrary("AceLocale-2.2"):new("cyCircled")

cyCircled.name = "cyCircled"
cyCircled.defaultPosition = "CENTER"
cyCircled.tooltipHiddenWhenEmpty = true
cyCircled.hasIcon = "Interface\\Icons\\INV_Egg_02"
cyCircled.defaultMinimapPosition = 285
cyCircled.cannotDetachTooltip = false
cyCircled.hasNoColor = true
cyCircled.clickableTooltip = false

function cyCircled:OnInitialize()
	self:RegisterDB("cyCircledDB")
	self:RegisterDefaults("profile", {
		colors = {
			normal 		= { r = 1.0, g = 1.0, b = 1.0, },
			hover 		= { r = 75/255, g = 216/255, b = 241/255, },
			equipped 	= { r = 28/255, g = 224/255, b = 18/255,},
		},
		skin = "Serenity",
	})
	self.elements = {}
	
	-- After everything is loaded, activate the plugins
	self:RegisterEvent("AceEvent_FullyInitialized", "LoadPlugins")
end

function cyCircled:OnEnable()
	self:Hook("ActionButton_Update")
end

function cyCircled:LoadPlugins()
	self:Print("|cffff0000I'm a BETA VERSION! Bugs guaranteed.|r")
	
	for k, v in self:IterateModules() do
		if IsAddOnLoaded(k) then
			local pluginName = k
			local module = v
			
			-- Addon exists, setup plugin
			module.loaded = true
			module:AddonLoaded()
			
			-- Activate plugin
			if self:IsModuleActive(pluginName) then
				module:OnEnable()
			end
			
			-- Default menu entry (toggle all)
			self.options.args.elements.args[pluginName] = {
				name = pluginName, desc = pluginName, type = "group",
				args = {
					toggle = {
						name = L["Toggle plugin"], desc = L["toggleallDesc"], type = "toggle", order = 1,
						get = function() return cyCircled:IsModuleActive(pluginName) end,
						set = function() cyCircled:ToggleModuleActive(pluginName) end,
					},
					spacer = { type = "header", order = 2, }
				},
			}
			
			-- Elements menu
			local i = 3
			for k, label in pairs(module:GetElements()) do
				
				local element = k
				if type(label) == "boolean" then label = element end
				
				self.options.args.elements.args[pluginName].args[element] = {
					name = label, desc = format(L["toggleskinDesc"], label), type = "toggle", order = i,
					get = function() return module.db.profile[element] end,
					set = function(v)
						module.db.profile[element] = v
						module:ApplySkin()
						module:ApplyColors()
						if module.ApplyCustom then
							module:ApplyCustom()
						end
					end,
				}
				i = i + 1
			end
		end
	end
end

function cyCircled:ChangeSkin()
	for plugin, module in self:IterateModules() do
		module:ApplySkin()
	end
end

function cyCircled:ChangeColors()
	for plugin, module in self:IterateModules() do
		module:ApplyColors()
	end
end

function cyCircled:ApplySkin(data)
	local args = data.args
	local alias = data.alias or {}
	-- elements
	for k, id in pairs(data.elements) do
		if _G[id] then
			if args.parentname then
				id = _G[id]:GetName()
			end
			-- button
			if args.button then
				if args.button.width then
					_G[id]:SetWidth(args.button.width)
				end
				if args.button.height then
					_G[id]:SetHeight(args.button.height)
				end
			end
			-- normal texture
			if args.nt ~= false then
				self:SkinNormalTexture(id)
			end
			-- highlight texture
			if args.ht ~= false then
				self:SkinHighlightTexture(id)
			end
			-- pushed texture
			if args.pt ~= false then
				self:SkinPushedTexture(id)
			end
			-- checked texture
			if args.ct ~= false then
				self:SkinCheckedTexture(id)
			end
			-- flash texture
			if args.ft ~= false then
				self:SkinFlashTexture(id)
			end
			-- icon
			if args.icon ~= false then
				if alias.icon then
					self:SkinIcon(id, alias.icon)
				else
					self:SkinIcon(id)
				end
			end
			-- hotkey
			if args.hotkey ~= false then
				self:SkinHotkey(id)
			end
			-- count
			if args.count ~= false then
				self:SkinCount(id)
			end
			-- cooldown
			if args.cooldown ~= false then
				self:SkinCooldown(id)
			end
			-- equip border
			if args.eborder ~= false then
				self:SkinEquipBorder(id)
			end
			-- autocast
			if args.autocast ~= false then
				self:SkinAutocast(id)
			end
			-- overlay
			self:SkinOverlay(id)
		end
	end
end

function cyCircled:ApplyColors(data)
	local nc = self.db.profile.colors.normal
	local ec = self.db.profile.colors.equipped
	
	local args = data.args
	-- elements
	for k, id in pairs(data.elements) do
		if args.parentname then
			id = _G[id]:GetName()
		end
		
		if _G[id.."Overlay"] then
			_G[id.."Overlay"]:SetVertexColor(nc.r, nc.g, nc.b)
		end
		-- highlight texture
		if args.ht ~= false then
			self:SkinHighlightTexture(id)
		end
	end
end

function cyCircled:SetTexture(obj, data)
	if type(obj) == "string" then
		obj = _G[obj]
	end
	
	if not obj then return end
	
	obj:SetTexture(data.tex)
	if data.a then
		obj:SetAlpha(data.a)
	end
	if data.bm then
		obj:SetBlendMode(data.bm)
	end
end

function cyCircled:SetPosition(obj, alignTo, data)
	if type(obj) == "string" then
		obj = _G[obj]
	end
	if type(alignTo) == "string" then
		alignTo = _G[alignTo]
	end
	
	if not obj then return end
	
	if data.s then
		obj:SetScale(data.s)
	end
	if data.fl then
		obj:SetFrameLevel(data.fl)
	end
	if data.dl then
		obj:SetDrawLayer(data.dl)
	end
	
	if data.w then
		obj:SetWidth(data.w)
	end
	if data.h then
		obj:SetHeight(data.h)
	end
	
	obj:ClearAllPoints()
	obj:SetPoint((data.p or "CENTER"), alignTo, (data.rp or "CENTER"), (data.x or 0), (data.y or 0))
end

function cyCircled:SkinNormalTexture(id)
	local skin = self.skins[self.db.profile.skin].NormalTexture
	
	local tex = _G[id]:GetNormalTexture()
	
	--self:SetTexture(tex, skin)
	self:SetPosition(tex, id, skin)
	
	_G[id]:SetNormalTexture(tex)
end

function cyCircled:SkinHighlightTexture(id)
	local hc = self.db.profile.colors.hover
	local skin = self.skins[self.db.profile.skin].HighlightTexture
	
	-- why is it needed to check again? hmpf -.-
	if not _G[id] then return end
	
	local tex = _G[id]:GetHighlightTexture()
	tex:SetVertexColor(hc.r, hc.g, hc.b)
	
	self:SetTexture(tex, skin)
	self:SetPosition(tex, id, skin)
	
	_G[id]:SetHighlightTexture(tex)
end

function cyCircled:SkinPushedTexture(id)
	local skin = self.skins[self.db.profile.skin].PushedTexture
	
	local tex = _G[id]:GetPushedTexture()
	if _G[id.."Icon"] then
		self:SetPosition(tex, id.."Icon", skin)
	elseif _G[id.."IconTexture"] then
		self:SetPosition(tex, id.."IconTexture", skin)
	else
		self:SetPosition(tex, id, skin)
	end
	self:SetTexture(tex, skin)
	
	_G[id]:SetPushedTexture(tex)
end

function cyCircled:SkinCheckedTexture(id)
	local skin = self.skins[self.db.profile.skin].CheckedTexture
	
	local tex = _G[id]:GetCheckedTexture()
	if _G[id.."Icon"] then
		self:SetPosition(tex, id.."Icon", skin)
	elseif _G[id.."IconTexture"] then
		self:SetPosition(tex, id.."IconTexture", skin)
	else
		self:SetPosition(tex, id, skin)
	end
	self:SetTexture(tex, skin)
	
	_G[id]:SetCheckedTexture(tex)
end

function cyCircled:SkinIcon(id, alias)
	local skin = self.skins[self.db.profile.skin].icon
	
	if not alias then alias = "Icon" end
	
	self:SetPosition(id..alias, id, skin)
end

function cyCircled:SkinCooldown(id)
	local skin = self.skins[self.db.profile.skin].cooldown
	local cooldown = id.."Cooldown"
	
	if _G[id.."Icon"] then
		self:SetPosition(cooldown, id.."Icon", skin)
	elseif _G[id.."IconTexture"] then
		self:SetPosition(cooldown, id.."IconTexture", skin)
	else
		self:SetPosition(cooldown, id, skin)
	end
end

function cyCircled:SkinHotkey(id)
	local skin = self.skins[self.db.profile.skin].hotkey
	self:SetPosition(id.."HotKey", id, skin)
end

function cyCircled:SkinCount(id)
	local skin = self.skins[self.db.profile.skin].count
	self:SetPosition(id.."Count", id, skin)
end

function cyCircled:SkinOverlay(id)
	local skin = self.skins[self.db.profile.skin].overlay
	
	if not _G[id.."Overlay"] then
		_G[id]:CreateTexture(id.."Overlay", "OVERLAY")
	end

	self:SetTexture(id.."Overlay", skin)
	self:SetPosition(id.."Overlay", id, skin)
end

function cyCircled:SkinEquipBorder(id)
	_G[id.."Border"]:SetAlpha(0)
	_G[id.."Border"]:SetWidth(1)
	_G[id.."Border"]:SetHeight(1)
	_G[id.."Border"]:SetPoint("TOPLEFT", _G[id], "TOPLEFT", 4, -4)
end

function cyCircled:SkinFlashTexture(id)
	local skin = self.skins[self.db.profile.skin].flash
	self:SetTexture(id.."Flash", skin)
	self:SetPosition(id.."Flash", id, skin)
end

function cyCircled:SkinAutocast(id)
	local animation = self.skins[self.db.profile.skin].autocast
	local symbol = self.skins[self.db.profile.skin].autocastable

	if _G[id.."AutoCastable"] then
		self:SetPosition(id.."AutoCastable", id, symbol)
	end
	
	if _G[id.."AutoCast"] then
		self:SetPosition(id.."AutoCast", id, animation)
	end
end

function cyCircled:ActionButton_Update()
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

--[[
	Module stuff
]]

function cyCircled.modulePrototype:OnInitialize()
	
end

function cyCircled.modulePrototype:OnEnable()
	if not self.loaded then return end
	self:ApplySkin()
	self:ApplyColors()
	if self.ApplyCustom then
		self:ApplyCustom()
	end
	if self.InitHooks then
		self:InitHooks()
	end
end

function cyCircled.modulePrototype:ApplySkin()
	if not self.elements then return end
	
	for k, data in pairs(self.elements) do
		if self.db.profile[k] then
			cyCircled:ApplySkin(data)
		end
	end
end

function cyCircled.modulePrototype:ApplyColors()
	if not self.elements then return end
	
	for k, data in pairs(self.elements) do
		if self.db.profile[k] then
			cyCircled:ApplyColors(data)
		end
	end
end