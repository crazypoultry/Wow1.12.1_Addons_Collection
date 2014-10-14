----------------------------------------------------------------------------------
--
-- GuildAdsMinimapButton.lua
--
-- Author: Zarkan, Fkaï of European Ner'zhul (Horde)
-- URL : http://guildads.sourceforge.net
-- Email : guildads@gmail.com
-- Licence: GPL version 2 (General Public License)
----------------------------------------------------------------------------------

GuildAdsMinimapButtonCore = {
	
	metaInformations = { 
		name = "MinimapButton",
        guildadsCompatible = 100,
		ui = {
			options = {
				frame = "GuildAdsMinimapButtonOptions",
				tab = "GuildAdsMinimapButtonTab",
				tooltip = GUILDADS_ICON_OPTIONS,
				priority = 4
			}
		}
	};
	
	onLoad = function()
		-- support for ButtonHole
		if ButtonHole then
			GuildAdsMinimapButton:Show();
			ButtonHole.application.RegisterMod({
				id="GUILDADS",
				name=GUILDADS_TITLE,
				tooltip=GUILDADS_TITLE,
				buttonFrame="GuildAdsMinimapButton",
				updateFunction="GuildAdsMinimapButton_Update"
			});
		end
		
		GuildAdsMinimapButton:SetAlpha(0.6);
		this:RegisterForClicks("LeftButtonDown", "RightButtonDown");
	end;
	
	onInit = function()
		-- init config value
		if not GuildAdsMinimapButtonCore.getConfigValue(nil, "RadiusOffset") then
			GuildAdsMinimapButtonCore.defaultsOptions();
		end
		
		if not ButtonHole then
			GuildAdsMinimapButtonCore.update();
			-- has GuildAds object : wait 8 seconds before initialization...
			GuildAdsTask:AddNamedSchedule("GuildAdsMinimapButtonShow", 8, nil, nil, GuildAdsMinimapButton.Show, GuildAdsMinimapButton)
		end
	end;
	
	onChannelJoin = function()
		GuildAdsMinimapButton:SetAlpha(1);
	end;
	
	onChannelLeave = function()
		GuildAdsMinimapButton:SetAlpha(0.6);
	end;
	
	onConfigChanged = function(path, key, value)
		GuildAdsMinimapButtonCore.update();
	end;
	
	update = function()
		local radius = GuildAdsMinimapButtonCore.getConfigValue(nil, "RadiusOffset");
		local arc = GuildAdsMinimapButtonCore.getConfigValue(nil, "ArcOffset");
		if radius and arc and not ButtonHole then
			GuildAdsMinimapButton:SetPoint( "TOPLEFT", "Minimap", "TOPLEFT",
				55 - ( radius * cos( arc ) ),
				( radius * sin( arc ) ) - 55
			);
		end
	end;
	
	defaultsOptions = function()
		GuildAdsMinimapButtonCore.setConfigValue(nil, "RadiusOffset", 77);
		GuildAdsMinimapButtonCore.setConfigValue(nil, "ArcOffset", 296);		
	end;
	
	onShowOptions = function()
		GuildAds_MinimapArcSlider:SetValue(GuildAdsMinimapButtonCore.getConfigValue(nil, "ArcOffset"));
		GuildAds_MinimapRadiusSlider:SetValue(GuildAdsMinimapButtonCore.getConfigValue(nil, "RadiusOffset"));
	end
	
};

GuildAdsMinimapButton_Update = GuildAdsMinimapButtonCore.update;
GuildAdsPlugin.UIregister(GuildAdsMinimapButtonCore);