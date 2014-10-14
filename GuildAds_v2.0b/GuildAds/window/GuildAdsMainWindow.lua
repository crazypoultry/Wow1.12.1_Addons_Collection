----------------------------------------------------------------------------------
--
-- GuildAdsMainWindow.lua
--
-- Author: Zarkan, Fkaï of European Ner'zhul (Horde)
-- URL : http://guildads.sourceforge.net
-- Email : guildads@gmail.com
-- Licence: GPL version 2 (General Public License)
----------------------------------------------------------------------------------

GuildAdsMainWindow = GuildAdsWindow:new({ name="main", frame = "GuildAdsMainWindowFrame" });

function GuildAdsMainWindow:Create()
	-- Call parent method
	GuildAdsWindow.Create(GuildAdsMainWindow);
	-- Update version number
	GuildAdsVersion:SetText(GuildAds.version);
end
