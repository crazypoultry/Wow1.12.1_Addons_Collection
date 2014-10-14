
-- module setup
local me = { name = "save"}
local mod = thismod
mod[me.name] = me

--[[
Framework\SavedVariables.lua

This module manages your saved variables. Here's how it works:

1) Other modules define a table <me.savedvariables> with key-value pairs, key = name of the variable, value = default value. e.g. in module bob there might be
	me.mysavedvariables = 
	{
		number = 12
		name = "bil"
	}
This means the <bob> module is defining a saved variable <number>, default value 12, and a variable <name>, default value "bil"

2) When the Core module loads, it reads your <me.mysavedvariables> table if it exists, and calls <save.registervariable> to tell the saved variables manager to define that variable. It will stick the value in <me.defaults>

3) The VARIABLES_LOADED event is received by this module (this will always happen after OnLoad). The <me.data> variable is set to the savedvariable. Then the <me.defaults> are merged with the loaded data. If any value is missing in <me.data>, it will be set to its corresponding value in <me.defaults>

4) Other modules get and set their saved variables by calling the <read> and <write> methods. e.g. for the bob module to get the value of its <number> variable, it should call mod.save.read(me, "number").

]]

me.myevents = { "VARIABLES_LOADED" }

-- special OnEvent() method called from Core.lua
me.onevent = function()
	
	me.data = getglobal(mod.global.savedvariables)
	
	if me.data == nil then
		
		-- trace print
		if mod.trace.check("warning", me, "load") then
			mod.trace.print(mod.string.get("trace", me.name, "nosavedvariables"))
		end
		
		-- create fresh
		me.data = {  }
		setglobal(mod.global.savedvariables, me.data)
	end
		
	-- Now merge the saved variables with the default values
	local module, variable, value, data
	
	-- iterate over all items in the mod
	for name, module in mod do
		
		-- only get modules with saved variables
		if type(module) == "table" and (module.name == name) and type(module.save) == "table" then
			
			-- no saved data for this module
			if me.data[name] == nil then
				me.data[name] = module.save
				
			-- otherwise merge
			else
				me.mergetables(me.data[name], module.save)
				module.save = me.data[name]
			end
		end
	end
	
end

--[[
me.mergetables(saved, default)
	Given a set of saved data and the defaults, puts the default value into the saved data if it is missing or of a different type. Works recursively on tables.  
]]
me.mergetables = function(saved, default)
	
	local key, value
	
	for key, value in default do
		
		-- if default value has a different type, update
		if type(saved[key]) ~= type(value) then
			saved[key] = value
		
		-- if they are tables, recurse
		elseif (type(saved[key]) == "table") and (type(value) == "table") then
			me.mergetables(saved[key], value)
		end
	end
	
end