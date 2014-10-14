
-- Initialize the BFC namespace
BFC = {};
BFC.Version = 2.0;
BFC.SettingsVersion = 1;


-- Set up some logging variables
BFC.LOG_DEBUG = 1;
BFC.LOG_WARN = 2;
BFC.LOG_ERROR = 3;
BFC.LOG_PRINT = 4;

BFC.LogLevel = BFC.LOG_WARN;

BFC_Common = {};

BFC_Common.COLOR_ALLIANCE = ChatTypeInfo["BG_SYSTEM_ALLIANCE"];
BFC_Common.COLOR_HORDE = ChatTypeInfo["BG_SYSTEM_HORDE"];

local UpdateFunctionTable = {}; -- contains functions to be called every OnUpdate, as name:function pairs
local ZoneHelperModules = {}; -- contains all of the registered "ZONE_HELPER" modules
local EventsTable = {}; -- contains all the events to be dispatched

function BFC_Common.HandleEvent(event, ...)
	--BFC.Log(BFC.LOG_DEBUG, "Handling event '" .. event .. "'.");
	if(event == "VARIABLES_LOADED") then
		--BFC.Log(BFC.LOG_DEBUG, "Handling event '" .. event .. "'.");
		BFC_Common.Init(); -- Core functionality
		BFC_Util.Init(); -- Utility functions
		BFC_Options.Init(); -- Mod options
		BFC_Comms.Init(); -- Mod communications
		BFC_Map.Init(); -- Minimap/player blips/pings
		BFC_Radio.Init(); -- Radio messages
		BFC_Waypoints.Init(); -- Draggable waypoints
		BFC_InfoFrame.Init(); -- Zone information frame
		BFC.Log(BFC.LOG_DEBUG, "BFC2 loaded.");
	elseif(event == "PLAYER_ENTERING_WORLD") then
		BFC_Common.DispatchModules();
	elseif(event == "ZONE_CHANGED_NEW_AREA") then
		BFC_Common.DispatchModules();
	end
end

function BFC_Common.Init()
	BFC_Common.RegisterEvent("PLAYER_ENTERING_WORLD", BFC_Common.HandleEvent);
	BFC_Common.RegisterEvent("ZONE_CHANGED_NEW_AREA", BFC_Common.HandleEvent);
end


-- Functions registered in the UpdateFunctionTable will be executed every OnUpdate.
-- This is provided so that components can continue to do time-sensitive stuff even when they
-- have no visible frames.
function BFC_Common.OnUpdate(elapsed)
	for name, func in pairs(UpdateFunctionTable) do
		func(elapsed);
	end
end


-- Each function is registered with a unique name, so they can be unregistered again when
-- they're not needed.
function BFC_Common.RegisterUpdateFunction(name, func)
	if(UpdateFunctionTable[name]) then
		BFC.Log(BFC.LOG_ERROR, string.format(BFC_Strings.Errors.updatefuncregistered, name));
		return false;
	end
	
	--BFC.Log(BFC.LOG_DEBUG, "Registering update function '" .. name .. "'.");
	UpdateFunctionTable[name] = func;
end


function BFC_Common.UnregisterUpdateFunction(name)
	if(not UpdateFunctionTable[name]) then
		BFC.Log(BFC.LOG_ERROR, string.format(BFC_Strings.Errors.noupdatefunc, name));
		return false;
	end
	
	--BFC.Log(BFC.LOG_DEBUG, "Unregistering update function '" .. name .. "'.");
	UpdateFunctionTable[name] = nil;
end


-- Register a helper module
function BFC_Common.RegisterHelperModule(mod)
	-- if module doesn't have a name, fail hard
	if(not mod.Name or not mod.Type) then
		BFC.Log(BFC.LOG_ERROR, BFC_Strings.Errors.nomodname);
		return false;
	end
	
	if(ZoneHelperModules[mod.Name]) then
		BFC.Log(BFC.LOG_ERROR, string.format(BFC_Strings.Errors.modinuse, mod.Name));
		return false;
	end
	
	if(mod.Type ~= "ZONE_HELPER") then
		BFC.Log(BFC.LOG_ERROR, string.format(BFC_Strings.Errors.unknownmodtype, mod.Name, mod.Type));
		return false;
	end
	
	BFC.Log(BFC.LOG_DEBUG, "Registering helper '" .. mod.Name .. "'.");
	mod.Active = false;
	ZoneHelperModules[mod.Name] = mod;
end


-- Get number of modules
function BFC_Common.GetNumHelperModules()
	return BFC_Util.TableCount(ZoneHelperModules);
end


-- Get a module by index
function BFC_Common.GetHelperModule(index)
	return BFC_Util.GetTableItem(ZoneHelperModules, index);
end


-- Enable/disable modules on zone change
function BFC_Common.DispatchModules()
	local zone = GetZoneText();
	
	-- deactivate any modules, unless they're still active in this zone
	for name, mod in pairs(ZoneHelperModules) do
		if(mod.Active == true and not mod.IsActiveZone(zone)) then
			mod.SetActive(false);
			mod.Active = false;
			BFC.Log(BFC.LOG_DEBUG, "Deactivating module '" .. mod.Name .. "'.");
		end
	end
	
	-- activate any new modules (done in 2 stages to avoid races setting radio menus, etc)
	
	for name, mod in pairs(ZoneHelperModules) do
		if(mod.IsActiveZone(zone) and not mod.Active) then
			mod.Active = true;
			mod.SetActive(true);
			BFC.Log(BFC.LOG_DEBUG, "Activating module '" .. mod.Name .. "'.");
		end
	end
end


-- Handle output to the screen
function BFC.Log(level, message)
	if(level >= BFC.LogLevel) then
		if (DEFAULT_CHAT_FRAME) then
			DEFAULT_CHAT_FRAME:AddMessage(BFC_Strings.LogPrefix[level] .. message);
		end
	end
end


-- Register an event with the event dispatcher
function BFC_Common.RegisterEvent(event, callback)
	-- if something else has already registered the same event, tack the callback onto the list
	if(EventsTable[event]) then
		--BFC.Log(BFC.LOG_DEBUG, "Registering existing event '" .. event .. "'.");
		table.insert(EventsTable[event], callback);
	else
		--BFC.Log(BFC.LOG_DEBUG, "Registering new event '" .. event .. "'.");
		EventsTable[event] = { };
		table.insert(EventsTable[event], callback);
		BFC_UpdateFrame:RegisterEvent(event);
	end
end


function BFC_Common.UnregisterEvent(event, callback)
	if(not EventsTable[event]) then return end
	
	--BFC.Log(BFC.LOG_DEBUG, "Unegistering existing event '" .. event .. "'.");
	for i, v in ipairs(EventsTable[event]) do
		if(v == callback) then
			table.remove(EventsTable[event], i);
			if(table.getn(EventsTable[event]) == 0) then
				EventsTable[event] = nil;
				BFC_UpdateFrame:UnregisterEvent(event)
			end
		end
	end
end


function BFC_Common.DispatchEvent(event, ...)
	--BFC.Log(BFC.LOG_DEBUG, "Dispatching event '" .. event .. "'.");
	if(not EventsTable[event]) then return end
	
	--[[if (arg == nil) then
		BFC.Log(BFC.LOG_DEBUG, "Arg nil");
	else
		BFC.Log(BFC.LOG_DEBUG, "Arg not nil, n = " .. table.getn(arg));
	end
	
	for i, v in ipairs(arg) do
		BFC.Log(BFC.LOG_DEBUG, "Arg " .. i .. " = " .. v);
	end]]
	
	--BFC.Log(BFC.LOG_DEBUG, "Dispatching event '" .. event .. "'.");
	for i, v in ipairs(EventsTable[event]) do
		--BFC.Log(BFC.LOG_DEBUG, "Dispatch to '" .. i .. "'.");
		v(event, unpack(arg));
	end
end