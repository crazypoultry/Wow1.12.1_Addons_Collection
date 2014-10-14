
--[[
LoadFirst.lua

This file essentially sets up the mod. All the variables in the mod are contained in one global variable. It is important that the hlobal variable <thismod> is defined. All the other modules use that to determine the name of the mod's table, which they have to add themself to.
]]

local namespace = "klhms" -- Change this ONE string to completely clone the mod!!

setglobal(namespace, { })
thismod = getglobal(namespace)
thismod.namespace = namespace