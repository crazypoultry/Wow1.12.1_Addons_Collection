----------------------------------------------------------------------------------
--
-- GuildAdsDebug.lua
--
-- Author: Zarkan, Fkaï of European Ner'zhul (Horde)
-- URL : http://guildads.sourceforge.net
-- Email : guildads@gmail.com
-- Licence: GPL version 2 (General Public License)
----------------------------------------------------------------------------------

--[[
    Debug module
]]
GuildAds_DebugPlugin = {
	metaInformations = { 
		name = "Debug",
        guildadsCompatible = 200,
		ui = {
			main = {
				frame = "GuildAdsDebugFrame",
				tab = "GuildAdsDebugTab",
				priority = 10000
			}
		}
	};
	
	colors = {
		{0.57,0.57,0.11},
		{0.3, 0.3, 0.44},
		{0.23,0.34,0.44},
		{0.11,0.34,0.6},
		{0.1, 0.5, 0.1},
		{1,   0.5, 0},
		{1,   0,   1},
		{1,   1,   1},
	};
	
	showDebug = function()
		return GuildAdsDatabase and GuildAdsDatabase.Config and GuildAdsDatabase.Config.Debug;
	end;
	
	setShowDebug = function(status)
		if status then
			GuildAdsDB:SetConfigValue({"Config"}, "Debug", true);
		else
			GuildAdsDB:SetConfigValue({"Config"}, "Debug", nil);
		end
	end;
	
	onLoad = function()
		GuildAds_ChatDebug = GuildAds_DebugPlugin.addDebugMessageReal;
		this:RegisterEvent("VARIABLES_LOADED");
		GuildAdsPlugin.UIregister(GuildAds_DebugPlugin);
	end;
	
	onVariablesLoaded = function()
		if GuildAds_DebugPlugin.showDebug() then
			GuildAds_DebugPlugin.logMessages(true);
		else
			GuildAds_DebugPlugin.logMessages(false);
		end;
	end;
	
	logMessages = function(mode)
		if mode then
			if not GuildAds_DebugPlugin.showDebug() then
				GuildAds_DebugPlugin.addDebugMessageReal(GA_DEBUG_GLOBAL, "Log debug messages : true");
				GuildAds_DebugPlugin.setShowDebug(true);
			end
			GuildAds_ChatDebug = GuildAds_DebugPlugin.addDebugMessageReal;
			GuildAdsDebugTab:Show();
		else
			if GuildAds_DebugPlugin.showDebug() then
				GuildAds_DebugPlugin.addDebugMessageReal(GA_DEBUG_GLOBAL, "Log debug messages : false");
				GuildAds_DebugPlugin.setShowDebug(nil);
			end
			GuildAds_ChatDebug = GuildAds_DebugPlugin.addDebugMessageFake;
			GuildAdsDebugTab:Hide();
		end
	end;
	
	addDebugMessageFake = function(dbg_type, str)
	end;
	
	addDebugMessageReal = function(dbg_type, str)
		GuildAdsDebug_Log:AddMessage(date("[%H:%M:%S] ")..str, GuildAds_DebugPlugin.colors[dbg_type][1], GuildAds_DebugPlugin.colors[dbg_type][2], GuildAds_DebugPlugin.colors[dbg_type][3]);
	end;
}
