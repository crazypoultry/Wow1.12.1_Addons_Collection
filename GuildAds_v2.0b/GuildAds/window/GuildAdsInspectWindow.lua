----------------------------------------------------------------------------------
--
-- GuildAdsInspectWindow.lua
--
-- Author: Zarkan, Fkaï of European Ner'zhul (Horde)
-- URL : http://guildads.sourceforge.net
-- Email : guildads@gmail.com
-- Licence: GPL version 2 (General Public License)
----------------------------------------------------------------------------------

GuildAdsInspectWindow = GuildAdsWindow:new({ name="inspect", frame = "GuildAdsInspectWindowFrame" });

function GuildAdsInspectWindow:SetPlayer(playerName)
	self.playerName = playerName;
	-- 
	GuildAdsInspectName:SetText(playerName);
	local title = (GuildAdsDB.profile.Main:getClassNameFromId(GuildAdsDB.profile.Main:get(playerName, GuildAdsDB.profile.Main.Class)) or "")..
				  " "..(GuildAdsDB.profile.Main:getRaceNameFromId(GuildAdsDB.profile.Main:get(playerName, GuildAdsDB.profile.Main.Race)) or "")..
				  " "..LEVEL..
	              " "..GuildAdsDB.profile.Main:get(playerName, GuildAdsDB.profile.Main.Level)
				  
				  
	GuildAdsInspectTitle:SetText(title);
end

function GuildAdsInspectWindow:SetTime(timeStamp)
	if timeStamp then
		GuildAdsInspectTime:SetText(GuildAdsDB:FormatTime(timeStamp));
	else
		GuildAdsInspectTime:SetText("");
	end
end

function GuildAdsInspectWindow:Inspect(playerName)
	self:SetPlayer(playerName);
	self:SetTime(nil);
	GuildAds:ShowWindow("inspect");
end
