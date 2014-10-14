
--[[
	Embedded Library Stub
]]

local libName, libMajor, libMinor = "CommChannel", "1.0", tonumber(string.sub("$Revision: 8922 $", 12, -3))

local libMetatable = {
	__call = function(stub, major, minor)
		if (minor) then
			stub[major] = { }
			stub[major].libVersion = minor
		end
		return stub[major]
	end,
}

if (getglobal(libName) == nil) then
	setglobal(libName, setmetatable({ }, libMetatable))
end

local stub = getglobal(libName)

local lib = stub(libMajor)
if (lib == nil) then
	lib = stub(libMajor, libMinor)
elseif (lib.libVersion >= libMinor) then
	return
else
	lib.libVersion = libMinor
end

--[[
	The AddOn
]]

local prefix = "⠀" -- U+2800 BRAILLE PATTERN BLANK

local sfind = string.find
local sformat = string.format
local sgsub = string.gsub
local slen = string.len
local ssub = string.sub

local argLists = { }
setmetatable(argLists, { __mode = "kv" })

local function loadArgs(s)
	if (argLists[s] == nil) then
		argFunc = loadstring("return "..s)
		if (argFunc) then
			setfenv(argFunc, { })
			argList = { pcall(argFunc) }
			if (argList[1]) then
				argLists[s] = argList
			end
		end
	end

	return argLists[s]
end

local function onEvent()
	if (arg1 == prefix) then
		local Channel = lib.Channels[arg3]
		local _, _, module, func, argString = sfind(arg2, "^(%a-):(%a-)%((.*)%)$")
		if (module and func and argString) then
			local object = Channel[module]
			if (object and object[func]) then
				local argList = loadArgs(argString)
				if (argList) then
					argList[1] = object
					object[func](unpack(argList))
				end
			end
		end
	end
end

if (lib.Channels == nil) then
	lib.Channels = { ["GUILD"] = { }, ["PARTY"] = { }, ["RAID"] = { }, ["BATTLEGROUND"] = { } }
	
	lib.Slave = CreateFrame("Frame")
	lib.Slave:RegisterEvent("CHAT_MSG_ADDON")
end
lib.Slave:SetScript("OnEvent", onEvent)


--[[
	Object Serialization
]]

local function getTableCount(luaTable)
	local tableCount = 0
	
	for _, _ in pairs(luaTable) do 
		tableCount = tableCount + 1
	end
	
	return tableCount
end

local function serializeObject(luaObject)
	if (luaObject == nil) then
		return "" 
	elseif type(luaObject) == "string" then
		return sformat("%q", luaObject)
	elseif type(luaObject) == "table" then
		local serializedString = "{"
		
		if (next(luaObject) == nil) then
			return "{}"
		elseif luaObject[1] and table.getn(luaObject) == getTableCount(luaObject) then
			for i = 1, table.getn(luaObject) do
				serializedString = serializedString..serializeObject(luaObject[i])..","
			end
		else
			for tableKey, tableValue in pairs(luaObject) do
				if (type(tableKey) == "number") then
					serializedString = serializedString.."["..tableKey.."]="
				elseif (type(tableKey) == "string") then
					serializedString = serializedString..tableKey.."="
				else
					error("table key has unsupported type: " .. type(luaObject))
				end

				serializedString = serializedString..serializeObject(tableValue)..","
			end
		end

		return ssub(serializedString, 0, slen(serializedString) - 1).."}"
	elseif type(luaObject) == "number" then
		return tostring(luaObject)
	elseif type(luaObject) == "boolean" then
		return luaObject and "true" or "false"
	else
		error("can't serialize a " .. type(luaObject))
	end
end



--[[
	Public Interface
]]

local clientInterface = { }
local clientMetatable = { __index = clientInterface }

function clientInterface:Call(func, ...)
	lib:Call(self.channel, self.module, func, unpack(arg))
end

function lib:Create(channel, module, iface)
	local sig = sformat("CommChannel:Create(%q, %q, [iface])", channel, module)
	local Channel = self.Channels[channel]
	if (Channel == nil) then
		DEFAULT_CHAT_FRAME:AddMessage(sig..": unknown channel")
		return
	end
	
	if (Channel[module]) then
		DEFAULT_CHAT_FRAME:AddMessage(sig..": module is already registered")
		return
	end
	
	if (type(iface) ~= "table") then
		DEFAULT_CHAT_FRAME:AddMessage(sig..": iface has wrong type")
		return
	end
	
	Channel[module] = iface

	local clientModule = { }
	setmetatable(clientModule, clientMetatable)
	clientModule.channel = channel
	clientModule.module = module

	return clientModule
end

function lib:Destroy(channel, module)
	local sig = sformat("CommChannel:Destroy(%q, %q)", channel, module)
	local Channel = self.Channels[channel]
	if (Channel == nil) then
		DEFAULT_CHAT_FRAME:AddMessage(sig..": unknown channel")
		return
	end
	
	if (Channel[module] == nil) then
		DEFAULT_CHAT_FRAME:AddMessage(sig..": module is not registered")
		return
	end
	
	Channel[module] = nil
end


function lib:Call(channel, module, func, ...)
	local sig = sformat("CommChannel:Call(%q, %q, %q, ...)", channel, module, func)
	local Channel = self.Channels[channel]
	if (Channel == nil) then
		DEFAULT_CHAT_FRAME:AddMessage(sig..": unknown channel")
		return
	end
	
	arg.n = nil
	local success, msg = pcall(serializeObject, arg)
	
	if (not success) then
		msg = sgsub(msg, "(.*)CommChannel.lua:(%d+): ", "")
		DEFAULT_CHAT_FRAME:AddMessage(sig..": error in serializeObject(): "..msg)
		return
	end
	
	local msg = module..":"..func.."("..ssub(msg, 2, slen(msg) - 1)..")"
	
	if (slen(msg) > (255 - 12)) then
		DEFAULT_CHAT_FRAME:AddMessage(sig..": channelMessage too big")
		return
	end
	
	SendAddonMessage(prefix, msg, channel)
end
