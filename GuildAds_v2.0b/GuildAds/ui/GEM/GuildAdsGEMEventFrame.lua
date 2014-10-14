----------------------------------------------------------------------------------
--
-- GuildAdsGEMEventFrame.lua
--
-- Author: Zarkan, Fkaï of European Ner'zhul (Horde)
-- URL : http://guildads.sourceforge.net
-- Email : guildads@gmail.com
-- Licence: GPL version 2 (General Public License)
----------------------------------------------------------------------------------

local oldGEMMain_SelectTab;
local firstShow = true;

GuildAdsGEMEvent = {
	metaInformations = { 
		name = "GuildEventManager",
        guildadsCompatible = 100,
		--
		ui = {
			main = {
				frame = "GuildAdsEventFrame",
				tab = "GuildAdsGEMEventTab",
				tooltip = "Event tab",
				priority = 3
			},
			options = {
				frame = "GEMOptionsFrame",
				tab = "GuildAdsGEMOptionTab",
				priority = 3
			}
		}
	
	};
	
	GUILDADSEVENT_TAB_EVENTLIST = 1;
	GUILDADSEVENT_TAB_NEW = 2;
	
	onLoad = function()
	    if GEMListFrame then 
			GuildAdsPlugin.setDebug(true);
			GuildAdsPlugin.UIregister(GuildAdsGEMEvent);
			
			-- hide minimap button
			GEMMinimapButton:Hide();
			
			-- hide tabs Event / New in GEM window
			GEMMainFrameTab1:Hide();
			GEMMainFrameTab2:Hide();
			GEMMainFrameTab4:Hide();
				
			-- change parents / location of GEMListFrame & GEMNewFrame
			GEMListFrame:SetParent("GuildListAdEventListFrame");
			GEMListFrame:ClearAllPoints();
		   	GEMListFrame:SetPoint("TOPLEFT","GuildAdsMainWindowFrame","TOPLEFT",25,-78);
 			GEMListFrame:SetFrameLevel(2);
			
			GEMNewFrame:SetParent("GuildListAdCustomEventFrame");
			GEMNewFrame:ClearAllPoints();
			GEMNewFrame:SetPoint("TOPLEFT","GuildAdsMainWindowFrame","TOPLEFT",22,-58);
			GEMNewFrame:SetFrameLevel(2);
			
			GEMOptionsFrame:SetParent("GuildAdsOptionsWindowFrame");
			GEMOptionsFrame:ClearAllPoints();
			GEMOptionsFrame:SetPoint("TOPLEFT","GuildAdsOptionsWindowFrame","TOPLEFT",-42, -30);
			GEM_MinimapArcSlider:Hide();
			GEM_MinimapRadiusSlider:Hide();
			i = 1;
			while getglobal("GEMOptions_Icon"..i) do
				getglobal("GEMOptions_Icon"..i):Hide();
				i=i+1;
			end
			GEMOptions_Validate:Hide();
			GEMOptionsFrame_IconChoice:Hide();
			GEMOptionsFrame:SetFrameLevel(2);
			
			-- init tab in GA
			PanelTemplates_SelectTab(GuildAds_GEMEventTab1);
			PanelTemplates_DeselectTab(GuildAds_GEMEventTab2);
			
			-- show GEMListFrame
			GuildListAdEventListFrame:Show();
			GEMListFrame:Show();
			
			-- hide GEMNewFrame
			GuildListAdCustomEventFrame:Hide();
			GEMNewFrame:Hide();
			
			-- select config tab on GEM window
			GEMMain_SelectTab(3);
			
			-- hook GEMMain_SelectTab
			oldGEMMain_SelectTab = GEMMain_SelectTab;
			GEMMain_SelectTab = GuildAdsGEMEvent.GEMSelectTab;
		else
			-- hide GEM messages
			GuildAdsGEMEvent.oldChatFrame_OnEvent =ChatFrame_OnEvent;
			ChatFrame_OnEvent = GuildAdsGEMEvent.newChatFrame_OnEvent;
		end;
	end;
	
	newChatFrame_OnEvent = function(event)
		if (event == "CHAT_MSG_CHANNEL") and (string.sub(arg1, 1, 4)=="<GEM") then
			return
		end
		GuildAdsGEMEvent.oldChatFrame_OnEvent(event);
	end;
	
	saveOptions = function()
		GEMOptions_Click_Validate();
		GEM_Toggle();
	end;
	
	defaultsOptions = function()
	end;
		
	onShow = function() 
		if firstShow then
			GEMListFrame:Show();
			firstShow = false;
		end
	end;
	
	onChannelJoin = function()
		local ChannelAddedByGA;
		local channelName, password = GuildAds:GetDefaultChannel();
		
		-- add GA channel to the GEM channel list
		if not GEM_IsChannelInList(string.lower(channelName)) then
			GEMOptions_AddChannel(channelName, password or "", "", "");	-- channelName, password, alias, slash
			ChannelAddedByGA = channelName;
		end
		-- update ChannelAddedByGA
		GuildAdsGEMEvent.setProfileValue(nil, "ChannelAddedByGA", ChannelAddedByGA);
	end;
	
	onChannelLeave = function()
		GuildAdsGEMEvent.debug("onChannelLeave");
--~ 		-- delete previous GA channel from the the GEM channel list
--~ 		if GuildAdsGEMEvent.getProfileValue(nil, "ChannelAddedByGA") then
--~ 			local channelName = GuildAdsGEMEvent.getProfileValue(nil, "ChannelAddedByGA");
--~ 			GuildAdsGEMEvent.debug("   - leave : "..channelName..","..tostring(GEM_COM_Channels[channelName]));
--~ 			GEMOptions_RemoveChannel(GuildAdsGEMEvent.getProfileValue(nil, "ChannelAddedByGA"));
--~ 		end
	end;
	
	GEMSelectTab = function(tab)
		if tab==1 or tab==2 then
			GuildAdsGEMEvent.selectTab(tab);
		else
			oldGEMMain_SelectTab(tab);
		end
	end;
	
	selectTab = function(tab)
		if (tab == GuildAdsGEMEvent.GUILDADSEVENT_TAB_EVENTLIST) then
			PanelTemplates_SelectTab(GuildAds_GEMEventTab1);
			PanelTemplates_DeselectTab(GuildAds_GEMEventTab2);
			GuildListAdCustomEventFrame:Hide();
			GEMNewFrame:Hide();
			GuildListAdEventListFrame:Show();
			GEMNew_CheckResetEdit();
			GEMListFrame:Show();
		elseif (tab == GuildAdsGEMEvent.GUILDADSEVENT_TAB_NEW) then 
			PanelTemplates_SelectTab(GuildAds_GEMEventTab2);
			PanelTemplates_DeselectTab(GuildAds_GEMEventTab1);
			GuildListAdEventListFrame:Hide();
			GEMListFrame:Hide();
			GuildListAdCustomEventFrame:Show();
			GEMNewFrame:Show();
		end
	end;
}