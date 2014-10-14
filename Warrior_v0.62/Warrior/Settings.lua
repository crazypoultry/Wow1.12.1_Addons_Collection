WARRIOR.Settings = {};
WARRIOR.Settings._original = false;


-- *****************************************************************************
-- Function: Save
-- Purpose: saves all settings permanently
-- *****************************************************************************
function WARRIOR.Settings:Save(savekey)
	local SavedData = {
		{"WARRIOR.Actions._enabled", WARRIOR.Actions._enabled},
		{"WARRIOR.Alerts._database", WARRIOR.Alerts._database},
		{"WARRIOR.Alerts._enabled", WARRIOR.Alerts._enabled},
		{"WARRIOR.Alerts._type", WARRIOR.Alerts._type},
		{"WARRIOR.Alerts._fade", WARRIOR.Alerts._fade},
		{"WARRIOR.Classes._active", WARRIOR.Classes._active},
		{"WARRIOR.Classes._database", WARRIOR.Classes._database},
		{"WARRIOR.Conditions._database", WARRIOR.Conditions._database},
		{"WARRIOR.Immunities._enabled", WARRIOR.Immunities._enabled},
		{"WARRIOR.Immunities._database", WARRIOR.Immunities._database},
		{"WARRIOR.Player.Rage._enabled", WARRIOR.Player.Rage._enabled},
		{"WARRIOR.Player.Rage._limit", WARRIOR.Player.Rage._limit},
		{"WARRIOR.Player.Stances._auto", WARRIOR.Player.Stances._auto}
	};

	-- return the default settings on first load
	if (savekey == "PLAYER_ENTERING_WORLD") then return SavedData; end
	
	-- save all the keys
	if (not savekey or not WarriorSavedData) then
		WarriorSavedData = SavedData;
		WarriorSavedVersion = WARRIOR._version;
		return;
	end

	-- save a specific key of data
	for key,value in WarriorSavedData do
		if (value[1] == savekey) then 
			RunScript("WarriorSavedData[" .. key .. "][2] = " .. savekey .. ";");
			return;
		end
	end
end

-- *****************************************************************************
-- Function: Load
-- Purpose: loads settings from the previously saved ones
-- *****************************************************************************
function WARRIOR.Settings:Load(event)
	-- save the initialized data for a reset
	if (event == "PLAYER_ENTERING_WORLD") then self._original = self:Save(event); end

	-- load settings
	if (WarriorSavedData and ((not WARRIOR._erase and WarriorSavedVersion ~= nil) or WarriorSavedVersion == WARRIOR._version)) then
		for key,value in WarriorSavedData do
			RunScript(WarriorSavedData[key][1] .. " = WarriorSavedData[" .. key .. "][2];");
		end
	end

	self:Save();
	WARRIOR.Keybindings:Update();
end

-- *****************************************************************************
-- Function: Reset
-- Purpose: loads default settings
-- *****************************************************************************
function WARRIOR.Settings:Reset()
	WarriorSavedData = self._original;

	self:Load();
	self:Save();
	WARRIOR.Keybindings:Update();
end
