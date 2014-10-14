----------------------------------------------------------------------------------
--
-- GuildAds.lua
--
-- Author: Zarkan, Fkaï of European Ner'zhul (Horde)
-- URL : http://guildads.sourceforge.net
-- Email : guildads@gmail.com
-- Licence: GPL version 2 (General Public License)
----------------------------------------------------------------------------------

GUILDADS_VERSION          = 200.1;

GA_DEBUG_GLOBAL = 1;
GA_DEBUG_CHANNEL = 2;
GA_DEBUG_CHANNEL_HIGH = 3;
GA_DEBUG_PROTOCOL = 4;
GA_DEBUG_STORAGE = 5;
GA_DEBUG_GUI = 6;
GA_DEBUG_PLUGIN = 8;

GuildAds = AceAddon:new({
	name          = GUILDADS_TITLE,
    description   = GUILDADS_TITLE,
    version       = GUILDADS_REVISION_STRING or "2.0 beta",
    releaseDate   = GUILDADS_REVISION_DATE or "??",
    aceCompatible = 103,
    author        = "Zarkan, Fkai",
    email         = "guildads@gmail.com",
    website       = "http://guildads.sourceforge.net",
    category      = "guild",
    optionsFrame  = "GuildAdsOptionsWindowFrame",
    db            = AceDatabase:new("GuildAdsDatabase"),
    defaults      = DEFAULT_OPTIONS,
    cmd           = AceChatCmd:new(GUILDADS_CMD, GUILDADS_CMD_OPTIONS),
	
	channelName			= nil,
	channelPassword		= nil,
	channelNameFrom		= nil,				-- channel name from : user, guildInfo, guildName
	playerName 			= false,
	guildName			= false,
	windows				= {},
})

function GuildAds:Initialize()
	GuildAds_ChatDebug(GA_DEBUG_GLOBAL,"[GuildAds:Initialize] begin");
	
	-- Check if GuildAds is still GuildAds (not erased by SavedVariables/GuildAds.lua version 1)
	if GuildAds.aceCompatible then
		GuildAdsBackup = nil
	else
		GuildAds = GuildAdsBackup;
		self = GuildAds;
	end
	
	-- Init player name, faction name, realm name
	self.playerName = UnitName("player");
	self.factionName = UnitFactionGroup("player");
	self.realmName = GetCVar("realmName");
	if IsInGuild() then
		self.guildName = GetGuildInfo("player");
		if not self.guildName then
			GuildAdsTask:AddNamedSchedule("GetGuildName", 4, nil, nil, self.PLAYER_GUILD_UPDATE, self)
		end
	end
	
	-- RegisterEvent
	self:RegisterEvent("PLAYER_GUILD_UPDATE");
	self:RegisterEvent("GUILD_ROSTER_UPDATE");
	
	-- Initialize database
	GuildAdsDB:Initialize(); 
		
	-- Initialize network
	GuildAdsComm:Initialize()
	
	-- LoadGuildRosterTask
	self:LoadGuildRosterTask();
	GuildAdsTask:AddNamedSchedule("LoadGuildRosterTask", 240, true, nil, self.LoadGuildRosterTask, self);
	
	-- Register plugins
	GuildAds_ChatDebug(GA_DEBUG_GLOBAL,"[GuildAdsPlugin_RegisterPlugins] begin");
	GuildAdsPlugin_RegisterPlugins();
	GuildAds_ChatDebug(GA_DEBUG_GLOBAL,"[GuildAdsPlugin_RegisterPlugins] end");
	
	-- Initialize windows (main, options, inspect)
	GuildAds_ChatDebug(GA_DEBUG_GLOBAL,"[GuildAdsWindow:Create] begin");
	for _, window in self.windows do
		window:Create()
	end
	GuildAds_ChatDebug(GA_DEBUG_GLOBAL,"[GuildAdsWindow:Create] end");
	
	-- Initialize Plugins
	GuildAds_ChatDebug(GA_DEBUG_GLOBAL,"[GuildAdsPlugin_OnInit] begin");
  	GuildAdsPlugin_OnInit();
  	GuildAds_ChatDebug(GA_DEBUG_GLOBAL,"[GuildAdsPlugin_OnInit] end");
	
	-- Call GuildAds:JoinChannel() in 8 seconds
	GuildAdsSystem:Show();
	GuildAdsTask:AddNamedSchedule("JoinChannel", 8, nil, nil, self.JoinChannel, self)
	
	GuildAds_ChatDebug(GA_DEBUG_GLOBAL,"[GuildAds:Initialize] end");
end

function GuildAds:JoinChannel()
	GuildAds_ChatDebug(GA_DEBUG_GLOBAL,"[GuildAds:JoinChannel] begin");
	
	-- Init du channel
	self.channelName, self.channelPassword, self.channelNameFrom = self:GetDefaultChannel();
	
	if self.channelName then
		local command, alias = GuildAds:GetDefaultChannelAlias();
		GuildAdsComm:JoinChannel(self.channelName, self.channelPassword, command, alias);
	end
	
	GuildAds_ChatDebug(GA_DEBUG_GLOBAL,"[GuildAds:JoinChannel] end");
end

function GuildAds:LeaveChannel()
	GuildAdsComm:LeaveChannel();
end

function GuildAds:ToggleMainWindow()
	self:ToggleWindow("main");
end

function GuildAds:ToggleOptionsWindow()
	self:ToggleWindow("options");
end

function GuildAds:ToggleWindow(name)
	if (self.channelName) then
		local frame = getglobal(self.windows[name].frame)
		if frame:IsVisible() then
			frame:Hide();
		else
			frame:Show();
		end
	else
		self.cmd:error(GUILDADS_ERROR_NOTINITIALIZED);
	end
end

function GuildAds:ShowWindow(name)
	if (self.channelName) then
		getglobal(self.windows[name].frame):Show();
	else
		self.cmd:error(GUILDADS_ERROR_NOTINITIALIZED);
	end
end

function GuildAds:HideWindow(name)
	if (self.channelName) then
		getglobal(self.windows[name].frame):Hide();
	else
		self.cmd:error(GUILDADS_ERROR_NOTINITIALIZED);
	end
end

function GuildAds:ToggleDebugOn()
	GuildAds_DebugPlugin.logMessages(true);
	self.cmd:status("Debug tab", TRUE, ACEG_MAP_ONOFF)
end

function GuildAds:ToggleDebugOff()
	GuildAds_DebugPlugin.logMessages(false);
	self.cmd:status("Debug tab", FALSE, ACEG_MAP_ONOFF)
end

function GuildAds:DisplayDebugInfo()
	local status, message = GuildAdsComm:GetChannelStatus();
	message = message and status.."("..message..")" or status;
	self.cmd:report({
		{text="version", val=GUILDADS_VERSION },
		{text="player name", val=tostring(self.playerName) },
		{text="guild name", val=tostring(self.guildName) },
		{text="account", val=tostring(GuildAdsDB.account) },
		{text="faction", val=tostring(self.factionName) },
		{text="realm", val=tostring(self.realmName) },
		{text="channel", val=tostring(self.channelName) },
		{text="channel status", val=tostring(message) }
	});
end

function GuildAds:ResetAll()
	GuildAdsDB:ResetAll();
end

function GuildAds:ResetChannel()
	GuildAdsDB:ResetChannel(self.channelName);
end

function GuildAds:ResetOthers()
	GuildAdsDB:ResetOthers();
end

function GuildAds:LoadGuildRosterTask()
	if IsInGuild() then
		GuildRoster();
	end
end

function GuildAds:PLAYER_GUILD_UPDATE()
	local guildName = GetGuildInfo("player");
	if guildName ~= self.guildName then
		self:LoadGuildRosterTask();
	end
	self:CheckChannelConfig();
end

function GuildAds:GUILD_ROSTER_UPDATE()
	self.guildName = GetGuildInfo("player");
	self:CheckChannelConfig();
end

function GuildAds:CheckChannelConfig()
	local channelName, channelPassword = self:GetDefaultChannel();
	if 		self.channelName 
		and (channelName ~= self.channelName or	channelPassword ~= self.channelPassword) then
		GuildAdsComm:LeaveChannel()
		if channelName then
			GuildAdsTask:AddNamedSchedule("JoinChannel", 2, nil, nil, self.JoinChannel, self)
		end
	end
end

function GuildAds:GetDefaultChannel()
	local configType = GuildAdsDB:GetConfigValue(GuildAdsDB.PROFILE_PATH, "ChannelConfig") or "automatic";
	local source, channel, password;
	if configType=="manual" then
		source="user"
		channel = GuildAdsDB:GetConfigValue(GuildAdsDB.PROFILE_PATH, "ChannelName");
		password = GuildAdsDB:GetConfigValue(GuildAdsDB.PROFILE_PATH, "ChannelPassword");		
	elseif configType=="automatic" then
		-- If in a guild
		if self.guildName then
			-- channel name bases on the guild info text
			local startIndex;
			startIndex, _, channel, password = string.find(GetGuildInfoText() or "", "%[GA:([^,%]]+),?([^%]]*)%]");
			if startIndex then
				if password=="" then
					password=nil;
				end
				source = "guildInfo"
			else
				-- channel name bases on the guild name
				channel = "GuildAds"..string.gsub(self.guildName, "\ ", "");
				if (strlen(channel) > 31) then
					channel = string.sub(channel, 0, 31);
				end
				source = "guildName";
			end
		end
	end
	
	-- For now, GuildAds doesn't work if there is no channel at all, so define a default one
	if not channel then
		channel = "GuildAds"..self.playerName;
	end
	
	return channel, password, source;
end

function GuildAds:GetDefaultChannelAlias()
	return GuildAdsDB:GetConfigValue(GuildAdsDB.PROFILE_PATH, "ChannelCommand", "ga"), GuildAdsDB:GetConfigValue(GuildAdsDB.PROFILE_PATH, "ChannelAlias", "GuildAds");
end

function GuildAds:SetDefaultChannelAlias(command, alias)
	if 		GuildAdsDB:SetConfigValue(GuildAdsDB.PROFILE_PATH, "ChannelCommand", command) 
		 or GuildAdsDB:SetConfigValue(GuildAdsDB.PROFILE_PATH, "ChannelAlias", alias) then
		SimpleComm_SetAlias(command, alias);
	end
end

GuildAds:RegisterForLoad()

---------------------------------------------------------------------------------
--
-- Debug function
-- 
---------------------------------------------------------------------------------
function GuildAds_ChatDebug()
end

---------------------------------------------------------------------------------
--
-- Create a copy of GuildAds table (may be erased by SavedVariables/GuildAds.lua version 1)
-- 
---------------------------------------------------------------------------------
GuildAdsBackup = {};
for k, v in pairs(GuildAds) do
	GuildAdsBackup[k] = v;
end
setmetatable(GuildAdsBackup, getmetatable(GuildAds));