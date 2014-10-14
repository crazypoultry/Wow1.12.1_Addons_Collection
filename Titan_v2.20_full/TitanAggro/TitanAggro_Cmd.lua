function TitanAggro_CommandHandler(msg)
	if (msg) then
		local command = string.lower(msg);

		if (strfind(command, "(.+) (.+)") ~= nil) then
			_,_,command, arg = strfind(command, "(.+) (.+)");
		else
			if (string.lower(msg) == "help") then
				command = "help";
			else
				command = "";
			end
		end

		if (command == "rtp") then
			if (AggroVars.ReportTypes[tonumber(arg or 100)]) then
				TitanAggroSetVar("ReportType", tonumber(arg));
				DEFAULT_CHAT_FRAME:AddMessage(TITAN_AGGRO_NAME..": Report type set");
			else command = "help"; end;
		end
		if (command == "rc") then
			if (AggroVars.ReportChans[tonumber(arg or 100)]) then
				local report_chans = TitanAggroGetVar("ReportChans");
				if (report_chans[tonumber(arg)]) then
					report_chans[tonumber(arg)] = false;
					DEFAULT_CHAT_FRAME:AddMessage(TITAN_AGGRO_NAME..": Reporting to '"..AggroVars.ReportChans[tonumber(arg or 100)].."' OFF");
				else
					report_chans[tonumber(arg)] = true;
					DEFAULT_CHAT_FRAME:AddMessage(TITAN_AGGRO_NAME..": Reporting to '"..AggroVars.ReportChans[tonumber(arg or 100)].."' ON");
				end
				TitanAggroSetVar("ReportChans", report_chans);
			else command = "help"; end;
		end
		if (command == "rtm") then
			if (AggroVars.ReportTimes[tonumber(arg or 100)]) then
				TitanAggroSetVar("ReportTime", tonumber(arg));
				TitanAggroSetVar("ReportTimeSec", AggroVars.ReportTimes[TitanAggroGetVar("ReportTime")]);
				DEFAULT_CHAT_FRAME:AddMessage(TITAN_AGGRO_NAME..": Option set");
			else command = "help"; end;
		end
		if (command == "rf") then
			if (AggroVars.ReportFormats[tonumber(arg or 100)]) then
				TitanAggroSetVar("ReportFormat", tonumber(arg));
				DEFAULT_CHAT_FRAME:AddMessage(TITAN_AGGRO_NAME..": Report format set");
			else command = "help"; end;
		end
		if (command == "reports") then
			if (arg == "on") then
				TitanAggroSetVar("DoReports", 1);
				DEFAULT_CHAT_FRAME:AddMessage(TITAN_AGGRO_NAME..": Reports ON");
			elseif (arg == "off") then
				TitanAggroSetVar("DoReports", 0);
				DEFAULT_CHAT_FRAME:AddMessage(TITAN_AGGRO_NAME..": Reports OFF");
			end
		end
		if (command == "sounds") then
			if (AggroVars.SoundOptions[tonumber(arg or 100)]) then
				TitanAggroSetVar("Sounds", tonumber(arg));
				DEFAULT_CHAT_FRAME:AddMessage(TITAN_AGGRO_NAME..": Sounds set to "..AggroVars.SoundOptions[TitanAggroGetVar("Sounds")]);
			else command = "help"; end;
		end
		if (command == "tank") then
			if (arg == "on") then
				TitanAggroSetVar("TankMode", 1);
				DEFAULT_CHAT_FRAME:AddMessage(TITAN_AGGRO_NAME..": Tank Mode ON");
			elseif (arg == "off") then
				TitanAggroSetVar("TankMode", 0);
				DEFAULT_CHAT_FRAME:AddMessage(TITAN_AGGRO_NAME..": Tank Mode OFF");
			else command = "help"; end;
		end
		if (command == "showtt") then
			if (arg == "on") then
				TitanAggroSetVar("DragableTT_HP", 0);
				TitanAggroSetVar("ShowTT_HP", 1);
				DEFAULT_CHAT_FRAME:AddMessage(TITAN_AGGRO_NAME..": Show target frame ON");
			elseif (arg == "off") then
				TitanAggroSetVar("DragableTT_HP", 0);
				TitanAggroSetVar("ShowTT_HP", 0);
				DEFAULT_CHAT_FRAME:AddMessage(TITAN_AGGRO_NAME..": Show target frame ON");
			else command = "help"; end;
		end
		if (command == "reloctt") then
			if (arg == "on") then
				TitanAggroSetVar("RelocateTT_HP", 1);
				TitanAggroSetVar("DragableTT_HP", 0);
				TitanAggroSetVar("MoveableTT_HP", 0);
				DEFAULT_CHAT_FRAME:AddMessage(TITAN_AGGRO_NAME..": Relocate target frame ON");
			elseif (arg == "off") then
				TitanAggroSetVar("RelocateTT_HP", 0);
				DEFAULT_CHAT_FRAME:AddMessage(TITAN_AGGRO_NAME..": Relocate target frame OFF");
			else command = "help"; end;
		end
		if (command == "pos") then
			if (arg == "move") then
				TitanAggroSetVar("DragableTT_HP", 1);
				TitanAggroSetVar("MoveableTT_HP", 1);
				TitanAggroSetVar("RelocateTT_HP", 0);
				TitanAggro_ToTText:SetText("Drag me");
				TitanAggro_AggroStatusBG:SetStatusBarColor(1,0,0,1);
				TitanAggro_ToT:Show();
				DEFAULT_CHAT_FRAME:AddMessage(TITAN_AGGRO_NAME..": Move the frame until you find the best postion. Then type '/aggro pos fix'.");
			elseif (arg == "fix") then
				TitanAggroSetVar("DragableTT_HP", 0);
				TitanAggroSetVar("MoveableTT_HP", 1);
				TitanAggroSetVar("RelocateTT_HP", 0);
				TitanAggro_AggroStatusBG:SetStatusBarColor(0,0,0,0);
				TitanAggro_ToT:Hide();
				DEFAULT_CHAT_FRAME:AddMessage(TITAN_AGGRO_NAME..": Frame position was fixed");
			elseif (arg == "reset") then
				TitanAggro_HPStatusBar:ClearAllPoints();
				TitanAggro_HPStatusBar:SetPoint("BOTTOM", "TargetFrame", "TOPLEFT", 62, 2);
				TitanAggro_ToT:ClearAllPoints();
				TitanAggro_ToT:SetPoint("TOP", "TitanAggro_HPStatusBar", "TOP", 1, -16);
				TitanAggroSetVar("DragableTT_HP", 0);
				TitanAggroSetVar("MoveableTT_HP", 0);
				TitanAggroSetVar("RelocateTT_HP", 1);
				TitanAggro_AggroStatusBG:SetStatusBarColor(0,0,0,0);
				TitanAggro_ToT:Hide();
				DEFAULT_CHAT_FRAME:AddMessage(TITAN_AGGRO_NAME..": Frame position was reset");
			else command = "help"; end;
		end
		if (command == "ad") then
			if (AggroVars.AggroDetectGroups[tonumber(arg or 100)]) then
				TitanAggroSetVar("AggroDetect", tonumber(arg));
				DEFAULT_CHAT_FRAME:AddMessage(TITAN_AGGRO_NAME..": Aggro Detect set to "..AggroVars.AggroDetectGroups[tonumber(arg or 100)]);
			else command = "help"; end;
		end

		if (command == "help") then
			local text = "";
			text = TitanAggro_GetNormalText(AggroVars.ReportTypes_Text.." - '/aggro rtp [option]'\n");
			text = text..TitanAggro_GetHighlightText(AggroVars.PossibleOptions..": ");
			for i=0, 10 do
				if (AggroVars.ReportTypes[i]) then
					text= text..TitanAggro_GetGreenText(i)..TitanAggro_GetHighlightText(" - "..AggroVars.ReportTypes[i]..", ");
				end
			end
			DEFAULT_CHAT_FRAME:AddMessage(text);


			text = TitanAggro_GetNormalText(AggroVars.ReportChans_Text.." - '/aggro rc [option]'\n");
			text = text..TitanAggro_GetHighlightText(AggroVars.PossibleOptions..": ");
			for i=0, 10 do
				if (AggroVars.ReportChans[i]) then
					text= text..TitanAggro_GetGreenText(i)..TitanAggro_GetHighlightText(" - "..AggroVars.ReportChans[i]..", ");
				end
			end
			DEFAULT_CHAT_FRAME:AddMessage(text);

			text = TitanAggro_GetNormalText(AggroVars.ReportTimes_Text.." - '/aggro rtm [option]'\n");
			text = text..TitanAggro_GetHighlightText(AggroVars.PossibleOptions..": ");
			for i=0, 10 do
				if (AggroVars.ReportTimes[i]) then
					text= text..TitanAggro_GetGreenText(i)..TitanAggro_GetHighlightText(" - "..AggroVars.ReportTimes[i]..", ");
				end
			end
			DEFAULT_CHAT_FRAME:AddMessage(text);

			text = TitanAggro_GetNormalText(AggroVars.ReportFormats_Text.." - '/aggro rf [option]'\n");
			text = text..TitanAggro_GetHighlightText(AggroVars.PossibleOptions..": ");
			for i=0, 10 do
				if (AggroVars.ReportFormats[i]) then
					text= text..TitanAggro_GetGreenText(i)..TitanAggro_GetHighlightText(" - "..format(AggroVars.ReportFormats[i], "'mob'", "'player'")..", ");
				end
			end
			DEFAULT_CHAT_FRAME:AddMessage(text);

			text = TitanAggro_GetNormalText(AggroVars.AggroDetect_Text.." - '/aggro ad [option]'\n");
			text = text..TitanAggro_GetHighlightText(AggroVars.PossibleOptions..": ");
			for i=0, 10 do
				if (AggroVars.AggroDetectGroups[i]) then
					text= text..TitanAggro_GetGreenText(i)..TitanAggro_GetHighlightText(" - "..AggroVars.AggroDetectGroups[i]..", ");
				end
			end
			DEFAULT_CHAT_FRAME:AddMessage(text);


			DEFAULT_CHAT_FRAME:AddMessage(TitanAggro_GetNormalText(AggroVars.DoReports_Text.." - '/aggro reports [On/Off]'"));

			text = TitanAggro_GetNormalText(AggroVars.Sounds_Text.." - '/aggro sounds [option]'\n");
			text = text..TitanAggro_GetHighlightText(AggroVars.PossibleOptions..": ");
			for i=0, 10 do
				if (AggroVars.SoundOptions[i]) then
					text= text..TitanAggro_GetGreenText(i)..TitanAggro_GetHighlightText(" - "..AggroVars.SoundOptions[i]..", ");
				end
			end
			DEFAULT_CHAT_FRAME:AddMessage(text);

			DEFAULT_CHAT_FRAME:AddMessage(TitanAggro_GetNormalText(AggroVars.TankMode_Text.." - '/aggro tank [On/Off]'"));
			DEFAULT_CHAT_FRAME:AddMessage(TitanAggro_GetNormalText(AggroVars.ShowTTStatus_Text.." - '/aggro showtt [On/Off]'"));
			DEFAULT_CHAT_FRAME:AddMessage(TitanAggro_GetNormalText(AggroVars.RelocateTTStatus_Text.." - '/aggro reloctt [On/Off]'"));
			DEFAULT_CHAT_FRAME:AddMessage(TitanAggro_GetNormalText(AggroVars.MoveableTT_HP_Text.." - '/aggro pos [Move/Fix/Reset]'"));

		end
		if (command == "") then
			DEFAULT_CHAT_FRAME:AddMessage(TitanAggro_GetGreenText(TITAN_AGGRO_MENU_TEXT..": Current Titan Aggro Configuration"));
			DEFAULT_CHAT_FRAME:AddMessage(TitanAggro_GetConfig(1));
			DEFAULT_CHAT_FRAME:AddMessage(TitanAggro_GetGreenText("Try '/aggro help' for help"));
		end
	end
end