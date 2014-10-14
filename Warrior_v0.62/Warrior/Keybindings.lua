WARRIOR.Keybindings = {};
WARRIOR.Keybindings._index = {};
WARRIOR.Keybindings._max = 15;


-- keybinding headers
BINDING_HEADER_WARRIOR_BASIC = "Warrior: Basic Keybindings";
BINDING_HEADER_WARRIOR_STANCE = "Warrior: Stance Keybindings";
BINDING_HEADER_WARRIOR_CLASS = "Warrior: Class Keybindings";

local keybindings = {
	BASIC = {"Cast Active","Cast Alerted Spell","Cycle Class Forward","Cycle Class Backward","Assit Most Wounded","Toggle Configuration","Reload Interface"},
	STANCE = {"Battle Stance","Defensive Stance","Berserker Stance","Toggle Battle & Defensive","Toggle Battle & Berserker","Toggle Defensive & Berserker","Cycle Stances Forward","Cycle Stances Backward"},
};

-- set keybinding descriptions
for header,names in keybindings do for i,name in names do setglobal("BINDING_NAME_WARRIOR_"..header.."_"..i,name) end end


-- *****************************************************************************
-- Function: Save
-- Purpose: saves the keybindings and hooks the MainMenu KeyBindings
-- *****************************************************************************
function WARRIOR.Keybindings:Save()
	-- hook the keybinding so that class keybindings are saved when set from the Main Menu
	if (not WARRIOR_oldSetBinding) then
		WARRIOR.Utils:Hook("SetBinding",function(keypressed,keybinding)
			local result = WARRIOR_oldSetBinding(keypressed,keybinding);
			WARRIOR.Keybindings:Save();
			return result;
		end);
	end

	-- save each of the keybinding settings
	for i=1,self._max do
		local class = getglobal("BINDING_NAME_WARRIOR_CLASS_"..i);
		if (WARRIOR.Classes._database[class]) then
			WARRIOR.Classes._database[class].keybinding = WARRIOR.Utils.Table:Pack(GetBindingKey("WARRIOR_CLASS_"..i));
		end
	end
	
	WARRIOR.Settings:Save("WARRIOR.Classes._database");
end

-- *****************************************************************************
-- Function: Update
-- Purpose: updates the keybinding labels
-- *****************************************************************************
function WARRIOR.Keybindings:Update()
	for i=1,self._max do 
		setglobal("BINDING_NAME_WARRIOR_CLASS_"..i,"|cff333333Undefined"); 
		self:SetKey(tonumber(i));
	end
	
	-- create a index map of the classes
	self._index = {};
	for key,value in WARRIOR.Classes._database do
		if (value.type ~= "system") then 
			table.insert(self._index,key);
			self:SetKey(key,value.keybinding);
		end
	end
	
	-- set the keybinding names to the class names
	for key,value in self._index do setglobal("BINDING_NAME_WARRIOR_CLASS_"..key,value); end
end

-- *****************************************************************************
-- Function: Execute
-- Purpose: executes the keybinding mapped to that index
-- *****************************************************************************
function WARRIOR.Keybindings:Execute(index)
	WARRIOR.Classes:Cast(self._index[index]);
end

-- *****************************************************************************
-- Function: GetKey
-- Purpose: gets the key assigned to a class
-- *****************************************************************************
function WARRIOR.Keybindings:GetKey(class)
	if (not WARRIOR.Utils.Table:Find(self._index,class)) then return "" end
	return (GetBindingKey("WARRIOR_CLASS_" .. WARRIOR.Utils.Table:Find(self._index,class)) or "");
end

-- *****************************************************************************
-- Function: SetKey
-- Purpose: sets the key for a class
-- *****************************************************************************
function WARRIOR.Keybindings:SetKey(class,keypressed)
	local keybinding = "WARRIOR_CLASS_" .. WARRIOR.Utils.Table:Find(self._index,class);

	-- remove previous keybindings
	local keys = WARRIOR.Utils.Table:Pack(GetBindingKey(keybinding));
	for key,value in keys do SetBinding(value); end

	-- set/save the key binding
	if (keypressed) then
		if (type(keypressed) == "table") then
			for _,key in keypressed do SetBinding(key,keybinding); end
		else
			WARRIOR.Utils:Debug(3,"SetKey: keybinding type %s.",type(keypressed));
		end

		SaveBindings(2);
		WARRIOR.Classes._database[class].keybinding = keypressed;
		WARRIOR.Settings:Save("WARRIOR.Classes._database");
	end
end

