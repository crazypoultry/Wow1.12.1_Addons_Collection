-- GridCore.lua
-- insert boilerplate here

--{{{ Libraries

local Compost = AceLibrary("Compost-2.0")
local RL = AceLibrary("RosterLib-2.0")
local L = AceLibrary("AceLocale-2.2"):new("Grid")

--}}}
--{{{ Grid
--{{{  Initialization

Grid = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceDebug-2.0", "AceModuleCore-2.0", "AceConsole-2.0", "FuBarPlugin-2.0")
Grid:SetModuleMixins("AceDebug-2.0", "AceEvent-2.0", "AceModuleCore-2.0")
Grid:RegisterDB("GridDB")
Grid.debugFrame = ChatFrame2
Grid.isTBC = string.find(GetBuildInfo(), "^2%.")

--{{{ AceOptions table

Grid.options = {
	type = "group",
	handler = Grid,
	args = {
		[L["debug"]] = {
			type = "group",
			name = L["Debugging"],
			desc = L["Module debugging menu."],
			args = {},
		},
	},
}

--}}}
--{{{ AceDB defaults

Grid.defaults = {
	debug = false,
}

--}}}
--{{{ FuBar settings

Grid.name                   = "Grid"
Grid.hasIcon                = true
Grid.defaultMinimapPosition = 240
Grid.cannotDetachTooltip    = true
Grid.independentProfile     = true
Grid.defaultPosition        = "RIGHT"
Grid.hideWithoutStandby     = true
Grid.OnMenuRequest          = Grid.options

--}}}
--}}}
--{{{  Module prototype

Grid.modulePrototype.core = Grid

function Grid.modulePrototype:OnInitialize()
	self.debugFrame = Grid.debugFrame
	self.debugging = self.db.profile.debug
	self:Debug("OnInitialize")
	self.core:AddModuleDebugMenu(self)
	self:RegisterModules()
	self:RegisterEvent("ADDON_LOADED")
end

function Grid.modulePrototype:OnEnable()
	self:EnableModules()
end

function Grid.modulePrototype:OnDisable()
	self:DisableModules()
end

function Grid.modulePrototype:Reset()
	self.debugging = self.db.profile.debug
	self:Debug("Reset")
	self:ResetModules()
end

function Grid.modulePrototype:RegisterModules()
	for name,module in self:IterateModules() do
		self:RegisterModule(name, module)
	end
end

function Grid.modulePrototype:RegisterModule(name, module)
	self:Debug("Registering "..name)

	if not module.db then
		self.core:RegisterDefaults(name, "profile", module.defaultDB or {})
		module.db = self.core:AcquireDBNamespace(name)
	end

	if module.options == nil then
		module.options = {
			type = "group",
			name = (module.menuName or module.name),
			desc = "Options for ".. module.name,
			args = {},
		}

	end

	if module.extraOptions then
		for name, option in pairs(module.extraOptions) do
			module.options.args[name] = option
		end
	end

	if module.options then
		self.options.args[name] = module.options
	end

	self.core:AddModuleDebugMenu(module)
end

function Grid.modulePrototype:EnableModules()
	for name,module in self:IterateModules() do
		self:ToggleModuleActive(module, true)
	end
end

function Grid.modulePrototype:DisableModules()
	for name,module in self:IterateModules() do
		self:ToggleModuleActive(module, false)
	end
end

function Grid.modulePrototype:ResetModules()
	for name,module in self:IterateModules() do
		module:Reset()
	end
end

function Grid.modulePrototype:ADDON_LOADED(addon)
	local name = GetAddOnMetadata(addon, "X-".. self.name .. "Module")
	if not name then return end

	local module = getglobal(name)
	if not module or not module.name then return end

	module.external = true

	self:RegisterModule(module.name, module)
end

--}}}

function Grid:OnInitialize()
	self:RegisterDefaults('profile', Grid.defaults )
	self:RegisterChatCommand({'/grid','/gr'}, self.options )

	-- we need to save debugging state over sessions :(
	self.debugging = self.db.profile.debug

	self:AddModuleDebugMenu(self)

	self:EnableClickCasting()
	self:RegisterModules()
	
	-- rename FuBar menu to avoid confusion
	-- this should be added to FuBarPlugin btw.
	if not FuBar then
		self.OnMenuRequest.args.hide.guiName = "Hide minimap icon"
		self.OnMenuRequest.args.hide.desc = "Hide minimap icon"
	end
	
	self:RegisterEvent("ADDON_LOADED")
end

function Grid:OnEnable()
	self:RegisterEvent("RosterLib_RosterChanged")
	self:EnableModules()
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:TriggerEvent("Grid_UpdateSort")
end

function Grid:OnDisable()
	self:Debug("OnDisable")
	self:DisableModules()
end

function Grid:OnProfileEnable()
	self.debugging = self.db.profile.debug
	self:Debug("Loaded profile", "(", self:GetProfile(),")")
	self:ResetModules()
end

-- only for WoW 1.x
function Grid:EnableClickCasting()
	if Clique and Clique.OnClick and not GridCustomClick then
		GridCustomClick = function (button, unit)
					  Clique:OnClick(button, unit)
				  end
	end
end

function Grid:RegisterModules()
	for name,module in self:IterateModules() do
		self:RegisterModule(name, module)
	end
end

function Grid:RegisterModule(name, module)
	self:Debug("Registering "..name)

	if not module.db then
		self:RegisterDefaults(name, "profile", module.defaultDB or {})
		module.db = self:AcquireDBNamespace(name)
	end

	if module.options then
		self.options.args[name] = module.options
	end

	self:AddModuleDebugMenu(module)
end

function Grid:AddModuleDebugMenu(module)
	local debugMenu = Grid.options.args.debug

	debugMenu.args[module.name] = {
		type = "toggle",
		name = module.name,
		desc = L["Toggle debugging for "].. module.name ..".",
		get = function ()
			      return module.db.profile.debug
		      end,
		set = function (v)
			      module.db.profile.debug = v
			      module.debugging = v
		      end,
	}

end

function Grid:EnableModules()
	for name,module in self:IterateModules() do
		self:ToggleModuleActive(module, true)
	end
end

function Grid:DisableModules()
	for name,module in self:IterateModules() do
		self:ToggleModuleActive(module, false)
	end
end

function Grid:ResetModules()
	for name,module in self:IterateModules() do
		module.db = self:AcquireDBNamespace(name)
		module:Reset()
	end
end

--{{{ Event handlers

function Grid:RosterLib_RosterChanged(tbl)
	local needsUpdate = false
	local name, u
	-- as this event is also triggered on pet events, we need to skip these first
	for name,u in pairs(tbl) do
		-- don't attempt to update frames if it's only a pet that died
		if u.class ~= "PET" and u.oldclass ~= "PET" then
			-- we need to update the frames
			needsUpdate = true

			if not u.name then
				self:Debug("UnitLeft "..(u.oldname))
				self:TriggerEvent("Grid_UnitLeft", u.oldname)
			elseif not u.oldname then
				self:Debug("UnitJoined "..(u.name))
				self:TriggerEvent("Grid_UnitJoined", u.name, u.unitid)
			else
				self:TriggerEvent("Grid_UnitChanged", u.name, u.unitid)
			end
		end
	end
	if needsUpdate then
		-- queue update for after leaving combat
		-- not that anything is actually registered for Grid_UpdateSort anymore
		if Grid.inCombat and Grid.isTBC then
			Grid.rosterNeedsUpdate = true
		else
			self:TriggerEvent("Grid_UpdateSort")
		end
	end
end

function Grid:PLAYER_REGEN_DISABLED()
	Grid.inCombat = true
	self:Debug("Entering combat")
end

function Grid:PLAYER_REGEN_ENABLED()
	Grid.inCombat = false
	self:Debug("Leaving combat")

	if Grid.rosterNeedsUpdate then
		self:Debug("Left combat, updating roster")
		Grid.rosterNeedsUpdate = false
		self:TriggerEvent("Grid_UpdateSort")
	end
end

function Grid:ADDON_LOADED(addon)
	local name = GetAddOnMetadata(addon, "X-".. self.name .. "Module")
	if not name then return end

	local module = getglobal(name)
	if not module or not module.name then return end

	module.external = true

	self:RegisterModule(module.name, module)
end

--}}}
--}}}
