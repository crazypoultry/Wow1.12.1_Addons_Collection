--[[

reports.lua

Handle the various program reports
]]

function EFM_Report_Flight(reportTo)
	local messageDest = string.lower(reportTo);

	if (EFM_TaxiDestination ~= nil) then
		local myReport;
		if (EFM_Timer_TimeKnown) then
			myReport = format(EFM_MSG_REPORT, EFM_TaxiDestination, EFM_SF_FormatTime(EFM_Timer_TimeRemaining));
		else
			myReport = format(EFM_MSG_REPORT, EFM_TaxiDestination, UNKNOWN);
		end

		if (messageDest == "guild") then
			SendChatMessage(myReport, "GUILD");
			return;

		elseif (messageDest== "party") then
			SendChatMessage(myReport, "PARTY");
			return;

		elseif (messageDest == "raid") then
			SendChatMessage(myReport, "RAID");
			return;

		elseif (messageDest ~= nil) then
			local chanNum = tonumber(reportTo);
			if (chanNum ~= nil) then
				if ((chanNum > 0) and (chanNum < 10)) then
					SendChatMessage(myReport, "CHANNEL", GetDefaultLanguage("player"), chanNum);
					return;
				end
			else
				SendChatMessage(myReport, "WHISPER", GetDefaultLanguage("player"), reportTo);
				return;
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage(myReport, 0.5, 1.0, 0.5);
			return;
		end
	end

	-- Error if we get to here.
	DEFAULT_CHAT_FRAME:AddMessage(EFM_MSG_REPORTERROR, 1.0, 0.2, 0.2);
end
