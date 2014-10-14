--[[
	TLib
		Lua functions I use for one reason or another
--]]

--local msg = function(message)  ChatFrame1:AddMessage('TLib: ' .. (message or 'nil')) end

--[[ Functions TLib needs to load ]]--

--converts a version string into a number.  Yes, I'm lazy
local function VToN(versionString)
	if tonumber(versionString) then
		return tonumber(versionString)
	end

	local _, _, major, minor, point = string.find(versionString, "(%d+)%.(%d+)%.(%d+)")
	major = tonumber(major); minor = tonumber(minor); point = tonumber(point)
	if major and minor and point then
--		msg(major * 10000 + minor * 100 + point)
		return major * 10000 + minor * 100 + point
	end
end
local OlderIsBetter = function(lib, version) return lib and lib.version and VToN(lib.version) >= VToN(version) end

local VERSION = "6.10.22"
if OlderIsBetter(TLib, VERSION) then return end
if not TLib then TLib = {} end

TLib.version = version

--[[ Library Functions ]]--

TLib.VToN = VToN
TLib.OlderIsBetter = OlderIsBetter

--[[ Table Functions ]]--

--Adapted from http://www.lua.org/pil/14.1.html,
--sets a specific global variable string to the given value, with table.table.table access
function TLib.SetField(field, value)
	local var
	for i in string.gfind(field, "([%w_]+)(%.?)") do
		if not var then
			if i == field then
				setglobal(i, value)
				return
			else
				i = tonumber(i) or i
				var = getglobal(i)
			end
		elseif rest then
			i = tonumber(i) or i
			if not var[i] then
				var[i] = {}
			end
			var = var[i]
		else
			i = tonumber(i) or i
			var[i] = value
		end
	end
end

--Adapted from http://www.lua.org/pil/14.1.html, gets a specific field of a global variable string
function TLib.GetField(field)
	local var
	for i in string.gfind(field, "([%w_]+)") do
		if not var then
			var = getglobal(i)
		else
			i = tonumber(i) or i
			var = var[i]
		end
	end
	return var
end

--taken from http://lua-users.org/wiki/PitLibTablestuff, performs a deep table copy
function TLib.TCopy(t)
	if t then
		local copy = {}
		local lookup_table
		for i, v in pairs(t) do
			if type(v) ~= "table" then
				copy[i] = v
			else
				lookup_table = lookup_table or {}
				lookup_table[t] = copy
				if lookup_table[v] then
					copy[i] = lookup_table[v] -- we already copied this table. reuse the copy.
				else
					copy[i] = TLib.TCopy(v,lookup_table) -- not yet copied. copy it.
				end
			end
		end
		return copy
	end
end