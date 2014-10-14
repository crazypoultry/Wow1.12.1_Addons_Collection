----------------------------------------------------------------------------------
--
-- GuildAdsGCEventFrame.lua
--
-- Author: Zarkan, Fkaï of European Ner'zhul (Horde)
-- URL : http://guildads.sourceforge.net
-- Email : guildads@gmail.com
-- Licence: GPL version 2 (General Public License)
----------------------------------------------------------------------------------

local oldGCMain_SelectTab;
local firstShow = true;

GuildAdsGCEvent = {
	metaInformations = { 
		name = "GroupCalendar",
        guildadsCompatible = 100,
		--
		ui = {
			main = {
				frame = "GuildAdsGCEventFrame",
				tab = "GuildAdsGCEventTab",
				tooltip = "Event tab",
				priority = 3
			}
		}
	
	};
	
	GUILDADSEVENT_TAB_EVENTLIST = 1;
	GUILDADSEVENT_TAB_NEW = 2;
	
	onLoad = function()
		--[[
	    if (GroupCalendarFrame) then 
			GuildAdsPlugin.setDebug(true);
			GuildAdsPlugin.UIregister(GuildAdsGCEvent);
			
			-- hide gametime button
			GroupCalendarButton:Hide();
--~ 			GroupCalendar_OnLoad();
			GroupCalendarCalendarFrame:SetParent("GuildAdsGCFrame");
--~ 			GroupCalendarCalendarFrame:ClearAllPoints();
		   	GroupCalendarCalendarFrame:SetPoint("TOPLEFT","GuildAdsMainWindowFrame","TOPLEFT",25,-78);
--~  			GroupCalendarCalendarFrame:SetFrameLevel(1);
			GuildAdsGCFrame:Show();
			GroupCalendarCalendarFrame:Show();
			GroupCalendarMonthYearText:SetPoint("TOP","GroupCalendarCalendarFrame","TOPLEFT",155,-58)
			GroupCalendarTrustFrame:SetParent("GuildAdsGCFrame");
--~ 				GroupCalendarTrustFrame:ClearAllPoints();
		   	GroupCalendarTrustFrame:SetPoint("TOPLEFT","GuildAdsMainWindowFrame","TOPLEFT",25,-78);
--~  			GroupCalendarTrustFrame:SetFrameLevel(1);
			GuildAdsGCFrame:Show();
--~ 			CalendarEditorFrame:ClearAllPoints();
--~ 			CalendarEditorFrame:SetParent("GuildAdsGCEventFrame");
			CalendarEditorFrame:SetPoint("TOPLEFT","GuildAdsMainWindowFrame","TOPRIGHT",-2,-78);
			CalendarEventEditorFrame:SetPoint("TOPLEFT","GuildAdsMainWindowFrame","TOPRIGHT",-2,-78);

			-- init tab in GA
			PanelTemplates_SelectTab(GuildAds_GCEventTab1);
			PanelTemplates_DeselectTab(GuildAds_GCEventTab2);
		end;
		]]
	end;
		
	onShow = function() 
		GroupCalendar_OnShow();
		if firstShow then
			firstShow = false;
		end
	end;
	
	onHide = function()
		GroupCalendar_OnHide();
--~ 		CalendarEditorFrame:Hide();
--~ 		CalendarEventEditorFrame:Hide();
	end;
	
	onChannelJoin = function()
		-- simple integration : one channel
		local alias = ""; -- GEM_COM_Channels[GEM_DefaultSendChannel].alias;
		local slash = ""; -- GEM_COM_Channels[GEM_DefaultSendChannel].slash;
		local channel, password = GuildAds:GetDefaultChannel();
		
--~ 		if strupper(channel) ~= strupper(GC_DefaultSendChannel) then
--~ 			-- leave default channel
--~ 			GuildAdsGCEvent.debug("Remove channel :"..GC_DefaultSendChannel);
--~ 			GCOptions_RemoveChannel(GC_DefaultSendChannel);	
--~ 			-- join GuildAds channel
--~ 			GuildAdsGCEvent.debug("Add channel :"..channel);
--~ 			GCOptions_AddChannel(channel,password,alias,slash);
--~ 		end
--~ 		 CalendarNetwork_SetChannel(channel, password)
	end;
	
	onChannelLeave = function()
		local channel, password = GuildAds:GetDefaultChannel();
		GuildAdsGCEvent.debug("Remove channel :"..channel);
--~ 		GCOptions_RemoveChannel(channel);
	end;
	
	GCSelectTab = function(tab)
		if tab==1 or tab==2 then
			GuildAdsGCEvent.selectTab(tab);
		else
			oldGCMain_SelectTab(tab);
		end
	end;
	
	selectTab = function(tab)
		if (tab == GuildAdsGCEvent.GUILDADSEVENT_TAB_EVENTLIST) then
			PanelTemplates_SelectTab(GuildAds_GCEventTab1);
			PanelTemplates_DeselectTab(GuildAds_GCEventTab2);
			GuildListAdCustomEventFrame:Hide();
			GroupCalendarTrustFrame:Hide();
			GuildListAdEventListFrame:Show();
			--GEMNew_CheckResetEdit();
			GroupCalendarCalendarFrame:Show();
		elseif (tab == GuildAdsGCEvent.GUILDADSEVENT_TAB_NEW) then 
			PanelTemplates_SelectTab(GuildAds_GCEventTab2);
			PanelTemplates_DeselectTab(GuildAds_GCEventTab1);
			GuildListAdEventListFrame:Hide();
			GroupCalendarCalendarFrame:Hide();
			GuildListAdCustomEventFrame:Show();
			GroupCalendarTrustFrame:Show();
		end;
	end;
}