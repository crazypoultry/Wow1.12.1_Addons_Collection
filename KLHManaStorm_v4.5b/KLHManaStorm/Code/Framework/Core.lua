
--[[
Framework\Core.lua

This file is the backbone of the addon. It provides <OnEvent>, <OnUpdate> and <OnLoad> services, and mediates Printing, Saved Variables, and Diagnostics.

To become a module of the addon, add a table containing all the code of your addon to the <thismod> variable. The top of the file should look like this:

		-- module setup
		local me = { name = "spell"}
		local mod = thismod
		mod[me.name] = me
	
The only thing that changes from file to file is the part in inverted commas, "spell" here. That is the name of your module. Other modules would reference you by that name, e.g. <mod.spell> . As a result, the name has to be unique among all files.

The following services are provided by Core.lua

1) OnLoad handler. Implement a method called "onload" in your module and it will get called when the OnLoad handler runs. e.g.

		me.onload = function()
			(stuff)
		end

Note that the order in which OnLoad handlers are run on modules is not defined. Having said that:

2) OnLoadComplete handler. Implement a method called "onloadcomplete" in your module and it will get called after the OnLoad handlers have been run on every module. This is useful if your module's initialisation code requires another module to be initialised, but in general try to avoid this.

3) OnUpdate handler. Implement a method called "onupdate" in your module and it will get called on every OnUpdate trigger. Note that OnUpdates will not run until after all OnLoadComplete handlers have run.

Alternatively, if you have a number of different methods that you want called periodically with different, specific periods, implement a table "myonupdates" as in this example

		me.myonupdates = 
		{
			updatescores = 0.0,
			updatenames = 0.5,
		}
		
		me.updatescores = function()
			(...)
		end
		
		me.updatenames = function()
			(...)
		end
		
The keys of the table must match functions in your module. The values are the minimum number of seconds allowed between subsequent method calls. 

4) OnEvent handler. First implement a list of strings "myevents" with the names of the events you want, e.g.

		me.myevents = { "CHAT_MSG_SPELL_SELF_BUFF", "CHAT_MSG_SYSTEM", }
	
Then implement a method "onevent", e.g.

		me.onevent = function()
			(...)
		end
		
No arguments will be passed to this method, so you'll have to refer to the global variables event, arg1, arg2, etc. Make sure not to edit them, since other addons might need them!

5) Saved Variables Service. Implement a table "save" with anything you want maintained when the user logs out in key-value pairs, e.g.

		me.save = 
		{
			hits = 100,
			moves = 
			{
				physical = 42,
				spell = 20,
			},
		}

This table will be automatically saved. You should put the default values into this table. Note that the saved variables will only be written into the table when the VARIABLES_LOADED event is received, which will occur after your OnLoad handler has fired. See Framework\SavedVariables.lua for more info.

6) Print Service. The method <mod.print(message, [...])> exists. See below in Core.lua.
]]

-- table setup
local me = thismod
local mod = me

-- Mod Version
me.release = 4
me.revision = 5
me.build = 15

--[[
Release	Build
	 1	     1
	 2		  7
	 3		 10
	 4		 14 
]]

me.events = { } 
--[[ 
Remember which module wants which events.
It will look like
{
	["combat"] = 
	{
		["CHAT_MSG_SPELL_SELF_BUFF"] = true,
	},
}
if the combat module has registered CHAT_MSG_SPELL_SELF_BUFF
]]

me.onupdates = { }
--[[
Remembers which module's methods will update when.
It will look like
{
	["combat"] = 
	{
		updatedamage = 
		{
			lastupdate = 1234.203,
			interval = 0.4,
		},
		updatehealth = 
		{
			lastupdate = 1235.120,
			interval = 0.0,
		}
	}
}
if there is a method <mod.combat.updatedamage()> that should be called at most every 0.4 seconds, and a method <mod.combat.updatehealth()> that should be called every OnUpdate.
]]

me.isloaded = false -- true when .onload has been called for all sub-modules
me.isenabled = true -- iif false, onupdate and onevent will not be called

-- onload. Order is quite important here. Saved variables first. OnLoad second. Then the rest.
me.onload = function()
		
	-- initialise all submodules
	for key, subtable in me do
		if type(subtable) == "table" and subtable.onload and subtable.isenabled ~= "false" then
			subtable.onload()
		end
	end
	
	-- onloadcomplete
	for key, subtable in me do
		if type(subtable) == "table" and subtable.onloadcomplete and subtable.isenabled ~= "false" then
			subtable.onloadcomplete()
		end
	end
	
	me.isloaded = true 
		
	-- register events
	for key, subtable in me do
		if type(subtable) == "table" and subtable.myevents then
			
			me.events[key] = { }
			
			for _, event in subtable.myevents do
				me.frame:RegisterEvent(event)
				me.events[key][event] = true 
			end
		end
	end
	
	-- register onupdates.
	for key, subtable in me do
		if type(subtable) == "table" and subtable.myonupdates then
			
			me.onupdates[key] = { }
			
			for method, interval in subtable.myonupdates do
				
				if (subtable[method] == nil) or (type(subtable[method]) ~= "function") then
					-- the module has not defined the method it promised
					if mod.trace.check("error", me, "onupdates") then
						mod.trace.print(string.format(mod.string.get("trace", "core", "badonupdate"), method, key))
					end
					
				else
					me.onupdates[key][method] = 
					{
						lastupdate = 0,
						["interval"] = interval,
					}
				end
			end
		end
	end
	
	-- Print load message
	me.print(string.format(me.string.get("loadmessage"), me.global.name, me.release, me.revision, me.global.slash.short), true)
		
end

-- OnUpdate
me.onupdate = function()
		
	-- only call when everything has been loaded
	if me.isloaded ~= true then
		return
	end
	
	-- don't call if the entire addon is disabled
	if me.isenabled == false then
		return
	end
	
	-- call all onupdates
	for key, subtable in me do
		if type(subtable) == "table" and subtable.onupdate and subtable.isenabled ~= "false" then
			me.diag.logmethodcall(key, "onupdate")
		end
	end
	
	-- call all timed update methods
	local module, moduledata, functiondata
	local timenow = GetTime()
	
	for module, moduledata in me.onupdates do
		 
		for functionname, functiondata in moduledata do
			if timenow > functiondata.lastupdate + functiondata.interval then
				me.diag.logmethodcall(module, "onupdate", me[module][functionname])
				functiondata.lastupdate = timenow
			end
		end
	end
	
end

-- OnEvent
me.onevent = function()

	-- Call OnLoad when our addon is loaded
	if event == "ADDON_LOADED" then
		me.onload()
		me.frame:UnregisterEvent("ADDON_LOADED")
	end
	
	-- don't call if the entire addon is disabled
	if me.isenabled == false then
		return
	end

	for key, subtable in me do
		-- 1) The subtable is a valid module - is a table and has a .onevent property.
		-- 2) The subtable is not disabled
		-- 3) The subtable has registered the event
		if type(subtable) == "table" and subtable.onevent and (subtable.isenabled ~= "false") and me.events[key][event] then
			
			me.diag.logmethodcall(key, "onevent")
		end
	end
	
end

--[[ 
me.print(message, [chatframeindex, noheader])
Prints out <message> to chat.
To print to ChatFrame3, set <chatframeindex> to 3, etc.
Adds a header identifying the mod to the message, unless <noheader> is non-nil.
]]
me.print = function(message, noheader, chatframe)

	-- Get a Frame to write to
	local chatframe

	if chatframeindex == nil then
		chatframe = DEFAULT_CHAT_FRAME
		
	else
		chatframe = getglobal("ChatFrame" .. chatframeindex)
		
		if chatframe == nil then
			chatframe = DEFAULT_CHAT_FRAME
		end
	end

	-- touch up message
	message = message or "<nil>"
		
	if noheader == nil then
		message = mod.global.printheader .. message 
	end
	
	-- write
	chatframe:AddMessage(message)

end

-- Create a frame to handle events
me.frame = CreateFrame("Frame", mod.namespace .. "frame", UIParent)
me.frame:Show()

me.frame:SetScript("OnEvent", me.onevent)
me.frame:SetScript("OnUpdate", me.onupdate)

-- capture the ADDON_LOADED event for our mod and call me.onload()
me.frame:RegisterEvent("ADDON_LOADED")


