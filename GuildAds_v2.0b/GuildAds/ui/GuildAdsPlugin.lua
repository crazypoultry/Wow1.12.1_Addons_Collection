----------------------------------------------------------------------------------
--
-- GuildAdsPlugin.lua
--
-- Author: Zarkan, Fkaï of European Ner'zhul (Horde)
-- URL : http://guildads.sourceforge.net
-- Email : guildads@gmail.com
-- Licence: GPL version 2 (General Public License)
----------------------------------------------------------------------------------

--[[
Plugin = {
	metaInformations = {
		name = "GuildAdsPlayerTracker",
		guildadsCompatible = 100,
	}

	getCommands = function()
		return {
			[GUILDADSPLAYERTRACKER_CMD_LOC] = {
				[1] = { ["key"]="continent", 
						["fout"]=GuildAdsPlugin.serializeInteger,
						["fin"]=GuildAdsPlugin.unserializeInteger }
					} ...
			}
			};
	end;

	getAdTypes = function()
	end
	
	-- others functions that can be defined
	-- those functions will be called when the event occured
	onChannelJoin();
	onChannelLeave();
	onOnline(playerName, status)
}
]]

GAS_EVENT_ITEMINFOREADY = 7;		-- TODO : Event associé à data\GuildAdsItem
GAS_EVENT_ONLINE = 6;				-- TODO : Event associé à network\GuildAdsComm
GAS_EVENT_CONNECTION = 8;			-- TODO : Event associé à network\GuildAdsComm
GAS_EVENT_CHANNELSTATUSCHANGED = 9;	-- TODO : Event associé à network\GuildAdsComm

local pluginsToRegister = {};

GuildAdsPlugin = {

	debugOn = false;

	PluginsList = {};
	
	-- SerializeObj
	serializeObj = GAC_SerializeObj;
	unserializeObj = GAC_UnserializeObj;
	
	-- SerializeString
	serializeString = GAC_SerializeString;
	unserializeString = GAC_UnserializeString;
	
	-- SerializeInteger
	serializeInteger = GAC_SerializeInteger;
	unserializeInteger = GAC_UnserializeInteger;
	
	-- SerializeColor
	serializeColor = GAC_SerializeColor;
	unserializeColor = GAC_UnserializeColor;
	
	isPluginValid  = function(plugin)
    	-- Every plugin needs to be a table
        if type(plugin) ~= "table" then
            return false, "Plugin type check failed.";
        end

    	-- Check metainformations
        if type(plugin.metaInformations) == "table" then
			local metainfo = plugin.metaInformations;
			-- check name
			if type(metainfo.name)~="string" then
				return false, "Plugin name check failed.";
			end
			-- check version
			if type(metainfo.guildadsCompatible)~="number" or metainfo.guildadsCompatible>GUILDADS_VERSION then
				return false, "Plugin incompatible with this version of GuildAds";
			end
		else
            return false, "Plugin Metainformations check failed.";
        end

        return true;
	end;
	
	_register = function(plugin)
		local valid, errorMessage = GuildAdsPlugin.isPluginValid(plugin);
		if valid then
			-- register commands
			if type(plugin.getCommands)=="function" then
				local commands = plugin.getCommands();
				for command, spec in commands do
					local status, errorMessage = GuildAdsPlugin.registerCommand(command, spec[1], spec[2]);
					if not status then
						return false, errorMessage;
					end
				end
			end
			
			-- register adtypes
			if type(plugin.getAdTypes)=="function" then
				local adtypes = plugin.getAdTypes();
				for adtype, spec in adtypes do
					local status, errorMessage = GAC_RegisterAdtype(adtype, spec[1], spec[2]);
					if not status then
						return false, errorMessage;
					end
				end
			end
			
			local pluginName = plugin.metaInformations.name;
			
			-- add plugin to GuildAdsPlugin.PluginsList
			GuildAdsPlugin.PluginsList[pluginName] = plugin;
			
			-- set debug function
			plugin.debug = function(message)
				GuildAdsPlugin.debug(pluginName..":"..message);
			end;
			
			-- set config function
			plugin.setConfigValue = function(path, key, value)
				if GuildAdsDB:SetConfigValue({ GuildAdsDB.CONFIG_PATH, pluginName, path }, key, value) then
					if type(plugin.onConfigChanged) == "function" then
						plugin.onConfigChanged(path, key, value);
					end
				end
				return value;
			end;
	
			plugin.getConfigValue = function(path, key, defaultValue)
				return GuildAdsDB:GetConfigValue({ GuildAdsDB.CONFIG_PATH, pluginName, path }, key, defaultValue)
			end;
			
			plugin.setProfileValue = function(path, key, value)
				if GuildAdsDB:SetConfigValue({ GuildAdsDB.PROFILE_PATH, pluginName, path}, key, value) then
					if type(plugin.onConfigChanged) == "function" then
						plugin.onConfigChanged(path, key, value);
					end
				end
				return value;
			end;
	
			plugin.getProfileValue = function(path, key, defaultValue)
				return GuildAdsDB:GetConfigValue({ GuildAdsDB.PROFILE_PATH, pluginName, path}, key, defaultValue)
			end;
			
			-- call onChannelJoin() ??
			
			GuildAds_ChatDebug(GA_DEBUG_PLUGIN, "Register plugin: "..pluginName);
			return true;
		else
			return false, errorMessage;
		end
	end;
	
    register = function(plugin)
  	    if pluginsToRegister then
			tinsert(pluginsToRegister, plugin)
  	        return true;
		else
			return GuildAdsPlugin._register(plugin);
		end
	end;
	
	UIregister = function(plugin)
		status, errorMessage = GuildAdsPlugin.register(plugin);
		if not status then
			if errorMessage then
				error(errorMessage,2);
			else
				error("error", 2);
			end
		end
	end;
	
	deregister = function(plugin)
		local valid, errorMessage = GuildAdsPlugin.isPluginValid (plugin);
		if valid then
			GuildAdsPlugin.PluginsList[plugin.metaInformations.name] = nil;
			-- call onChannelLeave()
			return true;
		else
			return false, errorMessage;
		end
	end;
	
	registerCommand = function(command, serializeInfo, onMessage)
		return GAC_RegisterCommand(command, serializeInfo, onMessage);
	end;

	deregisterCommand = function(command)
		return GAC_UnregisterCommand(command);
	end;

	registerAdtype = function(adtype, serializeInfo, onMessage)
		return GAC_RegisterAdtype(adtype, serializeInfo, onMessage);
	end;

	deregisterAdtype = function(adtype)
		return GAC_UnregisterAdtype(adtype);
	end;
	
	-- send(who, obj, delay)
	send = function(who, obj, delay)
		if obj.command and GAC_IsRegisteredCommand(obj.command) then
			SimpleComm_SendMessage(who, obj, delay);
			return true;
		else
			return false;
		end
	end;
	
	-- sendRaw
	sendRaw = function(who, message, delay)
		if type(message) == "string" then
			SimpleComm_SendRawMessage(who, message, delay);
			return true;
		else
			return false;
		end
	end;
	
	-- setDebug
	setDebug = function(status)
		if status then
			GuildAdsPlugin.debugOn = true;
		else
			GuildAdsPlugin.debugOn = false;
		end
	end;
	
	-- debug
	debug = function(message)
		GuildAds_ChatDebug(GA_DEBUG_PLUGIN, message);
	end
};

local EventIdToMethod = {
	[GAS_EVENT_ONLINE] = "onOnline";
	[GAS_EVENT_CONNECTION] = "onConnection";
	[GAS_EVENT_ITEMINFOREADY] = "onItemInfoReady";
	[GAS_EVENT_CHANNELSTATUSCHANGED] = "onStatusChannelChange";
}

local function pluginToRealCommand(command)
	return "P"..command;
end

local function realToPluginCommand(command)
	local iStart, iEnd, realCommand = string.find(command, "P(.*)");
	if (iStart) then
		return realCommand;
	else
		return false;
	end
end

local function methodToEventId(method)
	for ltype, lmethod in EventIdToMethod do
		if method == lmethod then
			return ltype;
		end
	end
	return nil;
end

function GuildAdsPlugin_RegisterPlugins()
	-- register plugins
	if pluginsToRegister then
		for _, plugin in ipairs(pluginsToRegister) do
			local status, errorMessage = GuildAdsPlugin._register(plugin);
			if not status then
				local pluginName;
				if plugin.metaInformations and plugin.metaInformations.name then
					pluginName = plugin.metaInformations.name..": ";
				else
					pluginName = "GuildAds(unknown plugin):";
				end
				if errorMessage then
					message(pluginName..errorMessage);
				else
					message(pluginName.."error");
				end
			end
		end
	end
	
  	-- GuildAdsPlugin.register : now register immediatly
  	pluginsToRegister = nil;
end

function GuildAdsPlugin_OnInit()
	-- call onInit
  	for pluginName, plugin in GuildAdsPlugin.PluginsList do
		if type(plugin.onInit) == "function" then
			GuildAds_ChatDebug(GA_DEBUG_PLUGIN, "onInit: "..pluginName);
			plugin.onInit();
		end
	end
end

function GuildAdsPlugin_OnChannelJoin()
	for pluginName, plugin in GuildAdsPlugin.PluginsList do
		if type(plugin.onChannelJoin) == "function" then
			GuildAds_ChatDebug(GA_DEBUG_PLUGIN, "onChannelJoin: "..pluginName);
			plugin.onChannelJoin();
		end
	end
end

function GuildAdsPlugin_OnChannelLeave()
	for pluginName, plugin in GuildAdsPlugin.PluginsList do
		if type(plugin.onChannelLeave) == "function" then
			GuildAds_ChatDebug(GA_DEBUG_PLUGIN, "onChannelLeave: "..pluginName);
			plugin.onChannelLeave();
		end
	end
end

function GuildAdsPlugin_OnEvent(ltype, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
	local method = EventIdToMethod[ltype];
	for pluginName, plugin in GuildAdsPlugin.PluginsList do
		if type(plugin[method]) == "function" then
			plugin[method](arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
		end
	end
end

function GuildAdsPlugin_UIPredicate(a, b)
	-- nil references are always less than
	if (a == nil) then
		if (b == nil) then
			return false;
		else
			return true;
		end
	elseif (b == nil) then
		return false;
	end
	
	-- sort by prority
	if a.priority and b.priority then
		if a.priority < b.priority then
			return true;
		elseif a.priority > b.priority then
			return false;
		end
	end
	
	
	-- sort by frame name
	if a.frame and b.frame then
		if a.frame < b.frame then
			return true;
		elseif a.frame > b.frame then
			return false;
		end
	end

	-- twice the same plugin ?
	return false;
end

function GuildAdsPlugin_GetUI(where)
	local result = {};
	for pluginName, plugin in GuildAdsPlugin.PluginsList do
		if plugin.metaInformations and plugin.metaInformations.ui and plugin.metaInformations.ui[where] then
			tinsert(result, plugin.metaInformations.ui[where]);
		end
	end
	table.sort(result, GuildAdsPlugin_UIPredicate);
	return result;
end