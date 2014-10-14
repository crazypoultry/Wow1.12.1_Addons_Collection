
-- module setup
local me = { name = "trace"}
local mod = thismod
mod[me.name] = me

--[[ 
Trace.lua.

	This module controls printing. For a normal print to the user that will always occur, call mod.out.print(<message>).
	The second part of this module is trace printing. This is a printout that assists with debugging, which you might not want most users to see. The module provides methods to determine which debug prints should be sent to the user. Then to make a debug print, first call mod.out.checktrace(). If it returns non-nil, call mod.out.printtrace() with the actual message.
	Defaults are set by <me.default> around line 27, overrides are set by <me.setprintstatus()> calls around line 128.
]]

--[[ 
--------------------------------------------------------------------------
			Trace Printing for Debugging or Extra Information
--------------------------------------------------------------------------

	The idea of this section is to provide a detailed method to evaluate whether a specific trace message should be printed. We have a few data structures that are print options of the form "if the print is <x>, do / dont print it".
	The more specific a print option is, the higher the priority it has. So the defaults, which just say "always print on <error>" or "never print on <info>" are the least specific and will be overridden by <me.setprintstatus>.
	For a release version, it is sufficient to set "error" = true, and the rest = "false", but for a debug version, you might only want to focus on specific sections of code for trace prints.

]]

-- These are default printing options. For a release version, error only. For a debug version, maybe warnings too.
me.default = 
{
	info = false,
	warning = true,
	error = true,
}

me.onload = function()

	-- optional debug specification
	me.setprintstatus("save", nil, "info", true)

end

--[[  
Suppose the following method calls were made:
	me.setprintstatus("boss", nil, "warning", true)
	me.setprintstatus("boss", "event", "info", true)
	
Then me.override would look like
me.override = 
{
	boss = 
	{
		warning = true
		error = true
		sections = 
		{
			event = 
			{
				info = true
				warning = true
				error = true
			}
		}
	}
}

See <me.setprintstatus> for more information
]]
me.override = {  }

--[[ 
me.setprintstatus(modulename, sectionname, messagetype, value)
Overrides the default print option for a specific trace print.
<modulename> is a string, the source of the print, e.g. "out" for this module.
<sectionname> is a string, a feature in the source module. e.g. "trace" for this section.
<messagetype> is either "info" or "warning" or "error".
<value> is a boolean, true to enable the print, false to disable it.

<sectionname> is an optional parameter. If it is nil, the override will apply to the whole module, but it is now less specific, so an individual section inside that module may be overriden again.
<messagetype> will automatically cascade. "error" is assumed to be more important than "warning", which is more important than "info". So if you turn "warning" off, it will turn "info off as well"; if you turn "info" on, "warning" and "error" will be turned on too.
]]
me.setprintstatus = function(modulename, sectionname, messagetype, value)

	-- check module exists
	if me.override[modulename] == nil then
		me.override[modulename] = { }
	end
	
	local printdata = me.override[modulename]
	
	-- is this for the whole module, or more specific?
	if sectionname then
		
		-- check whether any sections have been defined for this module
		if printdata.sections == nil then
			printdata.sections = { }
		end
		
		printdata = printdata.sections
		
		-- check whether this section has been defined in the sections list
		if printdata[sectionname] == nil then
			printdata[sectionname] = { }
		end
		
		printdata = printdata[sectionname]
	end
	
	-- set
	printdata[messagetype] = value
	
	-- cascade
	if value == true then
		if messagetype == "info" then
			printdata.warning = true
			messagetype = "warning"
		end
		
		if messagetype == "warning" then
			printdata.error = true
		end
	
	elseif value == false then
		if messagetype == "error" then
			printdata.warning = false
			messagetype = "warning"
		end
		
		if messagetype == "warning" then
			printdata.info = false
		end
	end

end


--[[
This is a reverse lookup of the top level of the list <mod>. <mod> has keys that are strings like "out", and values that are modules (lists), like <me>. <me.modulelookup> reverses this, giving us the name of a module from a reference to it.
Calls to <me.checktrace> supply a module reference and we might like to name the module. However we wouldn't want to search for the module name every time that method is called, since we want it in particular to be fast. 
We don't fill me.modulelookup at runtime, but each time <me.checktrace> is called with a <module> parameter that is not a key to <me.modulelookup>, we will search to find that module.
]]
me.modulelookup = { }

--[[
me.getmodulename(module)
Given a reference to a module (subtree of <local mod>), returns the name, which is the key in <mod> of the module.
]]
me.getmodulename = function(module)
	
	-- have we already found this module before?
	local try = me.modulelookup[module]
	if try then
		return try
	end
	
	-- manual search
	local key, value
	
	for key, value in mod do
		if value == module then
			me.modulelookup[module] = key
			return key
		end
	end
	
	return "unknown"
	
end

--[[ 
mod.out.checktrace(messagetype, module, sectionname)
Checks whether a debug print with the given properties should be printed.
Return: non-nil iff the message should be printed.
<messagetype> must be one of "error", "warning" or "info"
<module> should always be <me> in the calling context
<sectionname> is a description of the feature in <module> that the message concerns.
]]
me.check = function(messagetype, module, sectionname)
	
	-- start with default print value
	local value = me.default[messagetype]
	me.printargs.overridelevel = "default"
	
	-- convert module reference to name
	local modulename = me.getmodulename(module)
	
	-- are there any overrides for that module?
	local printdata = me.override[modulename]
	
	if printdata then
		if printdata[messagetype] then
			value = printdata[messagetype]
			me.printargs.overridelevel = "module"
		end
		
		-- are there overrides for this section of the module?		
		if printdata.sections and printdata.sections[sectionname] and (printdata.sections[sectionname][messagetype] ~= nil) then
			value = printdata.sections[sectionname][messagetype]
			me.printargs.overridelevel = "section"
		end
	end
	
	-- pre-return: load arguments for me.printtrace
	me.printargs.modulename = modulename
	me.printargs.sectionname = sectionname
	me.printargs.messagetype = messagetype
	
	-- return: nil or non-nil
	if value == true then
		return true
	end
	
end

-- This stores the options supplied to <me.checktrace>, which will slightly affect the printout.
me.printargs = 
{
	messagetype = "",
	modulename = "",
	sectionname = "",
	overridelevel = "",
}

--[[
mod.out.printtrace(message)
Prints a message that has been OK'd by <me.check>.
]]
me.print = function(message)

	-- setup the colour. Error = red, warning = yellow, info = blue. Lightish colours.
	local header = ""
	
	if me.printargs.messagetype == "info" then
		header = "|cff8888ff"
	
	elseif me.printargs.messagetype == "warning" then
		header = "|cffffff44"
	
	elseif me.printargs.messagetype == "error" then
		header = "|cffff8888"
	end
	
	--	convert |r in the message to the header colouring
	message = string.gsub(message, "|r", header)
	
	-- add the header
	message = string.format("%s<%s.%s> %s", header, me.printargs.modulename, me.printargs.sectionname, message)
		
	-- print!
	mod.print(message)
	
end
