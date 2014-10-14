WARRIOR.Classes = {};
WARRIOR.Classes._database = {};
WARRIOR.Classes._active = "Basic";

-- default alert class
WARRIOR.Classes._database["ALERTS"] = {type = "system", spells = {}};

-- default rage class
WARRIOR.Classes._database["RAGE"] = {type = "system", spells = {}};

-- default active class
WARRIOR.Classes._database["Basic"] = {type = "default", spells = {}};


-- *****************************************************************************
-- Function: Add
-- Purpose: adds a class
-- *****************************************************************************
function WARRIOR.Classes:Add(class)
	if (not class or class == "") then return nil; end

	if (not self._database[class]) then
		self._database[class] = {type="default",spells={},conditions={}};
		WARRIOR.Settings:Save("WARRIOR.Classes._database");	
		WARRIOR.Keybindings:Update();
	end
	
	return self._database[class];
end

-- *****************************************************************************
-- Function: Remove
-- Purpose: removes a spell from a class
-- *****************************************************************************
function WARRIOR.Classes:Remove(class)
	-- system classes can not be removed
	if (not class or not self._database[class] or self._database[class].type == "system") then return false; end

	-- remove the class
	self._database[class] = nil;
	table.sort(self._database);

	-- save the change and update the keybindings
	WARRIOR.Settings:Save("WARRIOR.Classes._database");
	WARRIOR.Keybindings:Update();
		
	-- if the removed class is the active class deactivate it
	if (class == WARRIOR.Classes._active) then WARRIOR.Classes._active = false; end
	return true;
end

-- *****************************************************************************
-- Function: AddSpell
-- Purpose: adds a spell to a class
-- *****************************************************************************
function WARRIOR.Classes:AddSpell(class,spell)
	if (not class or not spell or not WARRIOR.Spells._spellbook[spell]) then return false; end
	
	-- create class if it does not exist
	if (not self._database[class]) then self:Add(class); end

	if (not WARRIOR.Utils.Table:Find(self._database[class].spells,spell)) then
		table.insert(self._database[class].spells,spell);
		WARRIOR.Settings:Save("WARRIOR.Classes._database");
		return true;
	end
	
	return false;
end

-- *****************************************************************************
-- Function: RemoveSpell
-- Purpose: removes a spell from a class
-- *****************************************************************************
function WARRIOR.Classes:RemoveSpell(class,spell)
	if (not class or not spell or not WARRIOR.Spells._spellbook[spell]) then return false; end

	local key = WARRIOR.Utils.Table:Find(self._database[class].spells,spell);
	if (key) then 	
		table.remove(self._database[class].spells,key);
		WARRIOR.Settings:Save("WARRIOR.Classes._database");
		return true;
	end
	
	return false;
end

-- *****************************************************************************
-- Function: Activate
-- Purpose: set the active or secondary spell class
-- *****************************************************************************
function WARRIOR.Classes:Activate(class)
	-- system classes can not be active
	if (not class or not self._database[class] or self._database[class].type == "system") then return false; end

	WARRIOR.Classes._active = class;
	WARRIOR.Settings:Save("WARRIOR.Classes._active");
	return true;
end

-- *****************************************************************************
-- Function: Reset
-- Purpose: resets all the fifo indecies
-- *****************************************************************************
function WARRIOR.Classes:Reset()
	for _,class in self._database do class.index = 1; end
end

-- *****************************************************************************
-- Function: Cycle
-- Purpose: cycles between all classes
-- *****************************************************************************
function WARRIOR.Classes:Cycle(direction)
	local activate = function(current,next)
		WARRIOR.Utils:Print("Cycling stances from %s to %s.",WARRIOR.Classes._active,next);
		WARRIOR.Classes:Activate(next);
		return current;
	end

	local prev = nil;
	while true do
		for class,value in self._database do
			if (value.type ~= "system") then
				if (direction == "forward" and prev == self._active) then
					return activate(self._active,class);
				end
				if (direction == "backward" and class == self._active and prev) then
					return activate(self._active,prev);
				end
				prev = class;
			end
		end
	end
end

-- *****************************************************************************
-- Function: Cast
-- Purpose: cast one of the classes
-- *****************************************************************************
function WARRIOR.Classes:Cast(class)
	if (not class or not self._database[class] or not UnitExists("target") or UnitIsDead("target")) then return; end
	if (UnitIsFriend("player","target") and not WARRIOR.Player._dueling) then return; end

	-- cast the spell if it is ready
	local cast = function(spell,class)
		if (not WARRIOR.Conditions:Validate(class,spell)) then
			WARRIOR.Utils:Debug(2,"Cast: testing %s. Failed, conditions not met.",spell);
			return nil;
		end

		local error = WARRIOR.Spells:IsReady(spell,class);
		if (error) then 
			WARRIOR.Utils:Debug(2,"Cast: testing %s. Failed, %s.",spell,error);
			return nil;
		end
		
		WARRIOR.Utils:Debug(2,"Cast: testing %s. Passed, attempting to cast.",spell);
		return WARRIOR.Spells:Cast(spell);
	end

	-- cast from class if the type is default
	if (self._database[class].type == "default") then 
		for _,spell in self._database[class].spells do 
			if (cast(spell,class)) then return true; end
		end 
	end
	
	-- cast from class if the type is fifo
	if (self._database[class].type == "fifo") then
		if (self._database[class].index > table.getn(self._database[class].spells)) then self._database[class].index = 1 end

		if (cast(self._database[class].spells[self._database[class].index],class)) then 
			self._database[class].index = self._database[class].index + 1; 
		end
	end
end
