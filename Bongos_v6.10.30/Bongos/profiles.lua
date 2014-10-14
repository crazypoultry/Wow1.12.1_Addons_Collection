--[[
	BProfile
		Functions for saving and loading BONGOS settings
--]]

local savedList = {}
local startupActions = {}
local postLogin

local function StartUp()
	postLogin = true
	for _, action in pairs(startupActions) do
		action()
	end
end

BProfile = {
	AddStartup = function(action)
		table.insert(startupActions, action)
		if postLogin then action() end
	end,

	Load = function(name)
		if not BongosProfiles then
			BMsg(BONGOS_NO_PROFILES)
		elseif not name then
			BMsg(BONGOS_NO_PROFILE_NAME)
		elseif not BongosProfiles[name] then
			BMsg(format(BONGOS_INVALID_PROFILE, name or 'nil'))
		else
			--'delete' all bars
			BBar.ForAllIDs(BBar.Delete)

			--copy all settings
			for field, value in pairs(BongosProfiles[name]) do
				TLib.SetField(field, TLib.TCopy(value))
			end

			--call startup functions
			StartUp()
			BBar.ForAll(BBar.Reanchor)
			BMsg(format(BONGOS_PROFILE_LOADED, name))
		end
	end,

	Save = function(name)
		if not BongosProfiles then BongosProfiles = {} end
		BongosProfiles[name] = {}

		--save all bar and position information
		for _, bar in BBar.GetAll() do
			BongosProfiles[name][bar.setsGlobal] = TLib.TCopy(bar.sets) or {}
		end
		for var in pairs(savedList) do
			BongosProfiles[name][var] = TLib.TCopy(TLib.GetField(var))
		end

		BMsg(format(BONGOS_PROFILE_SAVED, name))
	end,

	Delete = function(name)
		if not BongosProfiles then
			BMsg(BONGOS_NO_PROFILES)
		elseif not name then
			BMsg(BONGOS_NO_PROFILE_NAME)
		elseif not BongosProfiles[name] then
			BMsg(format(BONGOS_INVALID_PROFILE, name or 'nil'))
		else
			BongosProfiles[name] = nil
			BMsg(format(BONGOS_PROFILE_DELETED, name))
		end
	end,

	SetDefault = function(name)
		if not name then
			if BongosProfiles then
				BongosProfiles.default = nil
				BMsg(BONGOS_PROFILE_DEFAULT_DISABLED)
			end
		elseif BongosProfiles and BongosProfiles[name] then
			BongosProfiles.default = name
			BMsg(format(BONGOS_PROFILE_DEFAULT_SET, name))
		else
			BMsg(format(BONGOS_INVALID_PROFILE, name or 'nil'))
		end
	end,

	GetDefault = function()
		if BongosProfiles then
			return BongosProfiles.default
		end
	end,

	RegisterForSave = function(varName)
		if not savedList[varName] then
			savedList[varName] = true
		end
	end,

	GetDefaultValue = function(varName)
		if varName and BongosProfiles and BongosProfiles.default and BongosProfiles[BongosProfiles.default] then
			local defaults = BongosProfiles[BongosProfiles.default][varName]
			if defaults then
				return TLib.TCopy(defaults)
			end
		end
	end,

	Reset = function()
		if BProfile.GetDefault() then
			BProfile.SetDefault(nil)
		end

		BBar.ForAllIDs(BBar.Delete)
		for var in pairs(savedList) do
			TLib.SetField(var, nil)
		end
		StartUp()
	end,
}
BEvent:AddAction("PLAYER_LOGIN", StartUp)