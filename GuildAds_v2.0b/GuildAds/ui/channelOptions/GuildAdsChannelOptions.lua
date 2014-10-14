----------------------------------------------------------------------------------
--
-- GuildAdsChannelOptions.lua
--
-- Author: Zarkan, Fkaï of European Ner'zhul (Horde)
-- URL : http://guildads.sourceforge.net
-- Email : guildads@gmail.com
-- Licence: GPL version 2 (General Public License)
----------------------------------------------------------------------------------

GuildAdsChannelOptions = {
	
	metaInformations = { 
		name = "ChannelOptions",
        guildadsCompatible = 200,
		ui = {
			options = {
				frame = "GuildAdsChannelOptionsFrame",
				tab = "GuildAdsChannelOptionsTab",
				tooltip = "Configuration du cannal à utiliser",
				priority = 1
			}
		}
	};
	
	defaultsOptions = function()
		GuildAds_ChatAutoChannelConfig:SetChecked(true);
		GuildAds_ChatManualChannelConfig:SetChecked(false);
		GuildAds_ChannelCommandEditBox:SetText("ga");
		GuildAds_ChannelAliasEditBox:SetText("GuildAds");
	end;
	
	saveOptions = function()
		if GuildAds_ChatAutoChannelConfig:GetChecked() then
			GuildAdsDB:SetConfigValue(GuildAdsDB.PROFILE_PATH, "ChannelConfig", nil);
			GuildAdsDB:SetConfigValue(GuildAdsDB.PROFILE_PATH, "ChannelName", nil);
			GuildAdsDB:SetConfigValue(GuildAdsDB.PROFILE_PATH, "ChannelPassword", nil);
		elseif ( GuildAds_ChatManualChannelConfig:GetChecked() ) then
			local name = GuildAds_ChannelEditBox:GetText();
			local password = GuildAds_ChannelPasswordEditBox:GetText();
			if (name == "") then
				GuildAdsDB:SetConfigValue(GuildAdsDB.PROFILE_PATH, "ChannelConfig", "none");
			else
				GuildAdsDB:SetConfigValue(GuildAdsDB.PROFILE_PATH, "ChannelConfig", "manual");
				if (password == "") then
					password = nil;
				end
				GuildAdsDB:SetConfigValue(GuildAdsDB.PROFILE_PATH, "ChannelName", name);
				GuildAdsDB:SetConfigValue(GuildAdsDB.PROFILE_PATH, "ChannelPassword", password);
			end
		else
			GuildAdsDB:SetConfigValue(GuildAdsDB.PROFILE_PATH, "ChannelConfig", "none");
			GuildAdsDB:SetConfigValue(GuildAdsDB.PROFILE_PATH, "ChannelName", nil);
			GuildAdsDB:SetConfigValue(GuildAdsDB.PROFILE_PATH, "ChannelPassword", nil);
		end
		GuildAds:CheckChannelConfig();
	
		local channelCommand = GuildAds_ChannelCommandEditBox:GetText();
		local channelAlias = GuildAds_ChannelAliasEditBox:GetText();
		GuildAds:SetDefaultChannelAlias(channelCommand, channelAlias);
	end;
	
	onShowOptions = function()
		local configType = GuildAdsDB:GetConfigValue(GuildAdsDB.PROFILE_PATH, "ChannelConfig") or (IsInGuild() and "automatic") or "none";
		
		if IsInGuild() then
			GuildAds_ChatAutoChannelConfig:Enable();
			GuildAds_ChatAutoChannelConfigLabel:SetFontObject(GameFontNormalSmall);
			
		else
			GuildAds_ChatAutoChannelConfig:Disable();
			GuildAds_ChatAutoChannelConfigLabel:SetFontObject(GameFontDisableSmall);
		end
		
		if configType=="none" then
			GuildAds_ChatAutoChannelConfig:SetChecked(0);
			GuildAds_ChatManualChannelConfig:SetChecked(0);
			GuildAds_ChannelEditBox:Hide();
			GuildAds_ChannelPasswordEditBox:Hide();
		elseif configType=="automatic" then
			GuildAds_ChatAutoChannelConfig:SetChecked(1);
			GuildAds_ChatManualChannelConfig:SetChecked(0);
			GuildAds_ChannelEditBox:Hide();
			GuildAds_ChannelPasswordEditBox:Hide();
		elseif configType=="manual" then
			local channelName = GuildAdsDB:GetConfigValue(GuildAdsDB.PROFILE_PATH, "ChannelName") or "";
			local channelPassword = GuildAdsDB:GetConfigValue(GuildAdsDB.PROFILE_PATH, "ChannelPassword") or "";
			
			GuildAds_ChatAutoChannelConfig:SetChecked(0);
			GuildAds_ChatManualChannelConfig:SetChecked(1);
			GuildAds_ChannelEditBox:SetText(channelName);
			GuildAds_ChannelEditBox:Show();
			GuildAds_ChannelPasswordEditBox:SetText(channelPassword);
			GuildAds_ChannelPasswordEditBox:Show();
		end

		local channelCommand, channelAlias = GuildAds:GetDefaultChannelAlias();
		GuildAds_ChannelAliasEditBox:SetText(channelAlias);
		GuildAds_ChannelCommandEditBox:SetText(channelCommand);
		
		GuildAdsChannelOptions.onStatusChannelChange();
	end;
	
	onStatusChannelChange = function()
		local status, message = GuildAdsComm:GetChannelStatus();
		message = message and status.."("..message..")" or status;
		GuildAdsChannelOptionsFrameStatus:SetText(((GuildAdsComm.channelName and GuildAdsComm.channelName..": ") or "")..message);
	end
	
}

GuildAdsPlugin.UIregister(GuildAdsChannelOptions);