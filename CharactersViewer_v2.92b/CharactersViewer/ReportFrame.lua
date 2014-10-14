if ( CharactersViewer.ReportFrame == nil ) then
	CharactersViewer.ReportFrame = {}
end


function CharactersViewer.ReportFrame.OnShow()
	local playerlist = CharactersViewer.Api.GetCharactersList(CharactersViewerConfig.MultipleServer);
	local temp, level,race,class,server,name,location,resting,rank;
	local string1, string2;
	if ( CVReportFrame.tab == nil ) then
		CVReportFrame.tab = 1;
	end
	local i = 0;
		for index, charactername in playerlist do
			i = i + 1;

			level = CharactersViewer.Api.GetParam("level", charactername);
			race = CharactersViewer.Api.GetParam("race", charactername);
			class = CharactersViewer.Api.GetParam("class", charactername);
			server = CharactersViewer.Api.GetParam("server", charactername);
			name = CharactersViewer.Api.GetParam("name", charactername);
			location = CharactersViewer.Api.GetParam("location", charactername);
			if ( CharactersViewer.Api.GetParam("isresting", charactername) ~= nil ) then
				if ( CharactersViewer.Api.GetParam("xptimestamp", charactername) ~= nil and CharactersViewer.Api.GetParam("xp", charactername, server) ~= nil) then
					temp = CharactersViewer.Api.CalcRestedXP(CharactersViewer.Api.GetParam("xp", charactername, server), CharactersViewer.Api.GetParam("isresting", charactername, server), CharactersViewer.Api.GetParam("xptimestamp", charactername, server));
					if ( temp and tonumber(temp.estimated) > 0 ) then
					  resting = " - Resting (" .. temp.levelratio .. " " .. LEVEL .. ")";
					else
						resting = "";
					end
				else
					resting = " - Resting";
				end
			else
				resting = "";
			end
			if ( CVReportFrame.tab == 1 ) then
				string1 = name .. " - " .. format(TEXT(PLAYER_LEVEL), level, race, class);		
				string2 = location .. resting;
			elseif ( CVReportFrame.tab == 2 ) then
				rank = CharactersViewer.Api.GetParam("pvprank", charactername);
				if ( rank ~= "" ) then
					rank = rank .. " ";
				end
				
				string1 = rank .. name .. " - " .. format(TEXT(PLAYER_LEVEL), level, race, class);		
				string2 = format(CV_REPORT_HONOR, CharactersViewer.Api.GetParam("hk", charactername), CharactersViewer.Api.GetParam("dk", charactername), CharactersViewer.Api.GetParam("weekhk", charactername), CharactersViewer.Api.GetParam("weekcontrib", charactername));
			elseif ( CVReportFrame.tab == 3 ) then
				string1 = name .. " - " .. format(TEXT(PLAYER_LEVEL), level, race, class);		
				string2 = format(CV_REPORT_MONEY, CharactersViewer.Api.GetParam("splitmoney", charactername, server));
			end
				--[[
				Rank: Private 1/2 - HK / DK (week: ThisWeek.Contribution, ThisWeek.HK)
				
				Current.Description / Lifetime.LifetimeHighestRank
				Current.Description == (Rank 1);
				Current.Progress == 0.00
				Rank = Private
				Lifetime.LifetimeRankName == Private
				Lifetime.LifetimeHighestRank == 5
				ThisWeek.Contribution
				ThisWeek.HK
				Lifetime.DK
				Lifetime.HK
				]]--

			
			
			local button = getglobal("CVReportFrameButton" .. i);
			button:Show();

			button = getglobal("CVReportFrameButton" .. i .. "ButtonTextNameLocation");
			button:SetText( string1 );
			
			button = getglobal("CVReportFrameButton" .. i .. "ButtonTextInfo");
			button:SetText( string2 ); 

			--getglobal("CVReportFrameButton" .. i .. "NameLocation"):SetText(format(TEXT(PLAYER_LEVEL), level, race, class, name));
		end
		
		for index = i+1, 10 do
			local button = getglobal("CVReportFrameButton" .. index);		
			button:Hide();
		end
end


function CharactersViewer.ReportFrame.UpdateTab()
	--PanelTemplates_SelectTab(this);
	--PanelTemplates_TabResize(0);
	
	CVReportFrame.tab = this:GetID();
	tablist = { "CVReportFrameToggleTab1", "CVReportFrameToggleTab2", "CVReportFrameToggleTab3"};
	frameName = this:GetName();
	for index, value in tablist do
		if ( value == frameName ) then
			PanelTemplates_SelectTab(getglobal(value));
		else
			PanelTemplates_DeselectTab(getglobal(value));
		end	
	end 
	CharactersViewer.ReportFrame.OnShow();
end

