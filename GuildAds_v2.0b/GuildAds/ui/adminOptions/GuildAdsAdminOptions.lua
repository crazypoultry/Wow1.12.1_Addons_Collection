----------------------------------------------------------------------------------
--
-- GuildAdsAdminOptions.lua
--
-- Author: Zarkan, Fkaï of European Ner'zhul (Horde)
-- URL : http://guildads.sourceforge.net
-- Email : guildads@gmail.com
-- Licence: GPL version 2 (General Public License)
----------------------------------------------------------------------------------

GuildAdsChannelOptions = {
	
	metaInformations = { 
		name = "AdminOptions",
        guildadsCompatible = 200,
		ui = {
			options = {
				frame = "GuildAdsAdminOptionsFrame",
				tab = "GuildAdsAdminOptionsTab",
				tooltip = "Configuration du cannal à utiliser",
				priority = 2
			}
		}
	};
	
	defaultsOptions = function()
		--[[
			faire confiance à sa guilde
			faire confiance à ses amis ?
		]]
	end;
	
	saveOptions = function()
	end;
	
	onShowOptions = function()	
	end;
	
}

GuildAdsPlugin.UIregister(GuildAdsChannelOptions);