-- Buff Checking --

function isUnitBuffUp(sUnitname, sBuffname) 
	local iIterator = 1
		while (UnitBuff(sUnitname, iIterator)) do
			if (string.find(UnitBuff(sUnitname, iIterator), sBuffname)) then
				return true
			end
			iIterator = iIterator + 1
		end
	return false
end

function isPlayerBuffUp(sBuffname)
	return isUnitBuffUp("player", sBuffname) 
end

function  GetPlayerBuff_IFA(buffId, buffFilter)
	local i,a = GetPlayerBuff(buffId, buffFilter);
	return i;
end

function GetBuffTimeleft(sBuffname)
	local iTemp,iTimeleft,iIndex
	local iIterator,iBuff = 0,1
	
	while ( GetPlayerBuff_IFA(iIterator, "HELPFUL") >= 0 ) do
		iIndex, iTemp = GetPlayerBuff(iIterator, "HELPFUL")
		iBuff = GetPlayerBuffTexture(iIndex)
		iTimeleft = GetPlayerBuffTimeLeft(iIndex)
		
		if (string.find(iBuff, sBuffname)) then
			return iTimeleft
		end
		
		iIterator = iIterator + 1
	end
	return 0
end


-- End Buff Checking --


-- Misc Functions --

function AbbrTimeText(s)
	if (not s) then return "N/A"
	elseif (s <= 0) then return "N/A"
	end
	
	local days = floor(s/24/60/60); s = mod(s, 24*60*60);
	local hours = floor(s/60/60); s = mod(s, 60*60);
	local minutes = floor(s/60); s = mod(s, 60);
	local seconds = s;
	
	local timeText = "";
	if (days ~= 0) then
		timeText = timeText..format("%d"..TITAN_DAYS_ABBR.." ", days);
	end
	if (days ~= 0 or hours ~= 0) then
		timeText = timeText..format("%d"..TITAN_HOURS_ABBR.." ", hours);
	end
	if (days ~= 0 or hours ~= 0 or minutes ~= 0) then
		timeText = timeText..format("%d"..TITAN_MINUTES_ABBR.." ", minutes);
	end	
	timeText = timeText..format("%d"..TITAN_SECONDS_ABBR, seconds);
	
	return timeText;
end

-- End Misc Functions --


-- Slash Handler (Testing Purposes) --

function InnerfireAlert_Initialize()
	SLASH_INNERFA1 = "/innerfirealert";
	SLASH_INNERFA2 = "/ifa";
	SlashCmdList["INNERFA"] = InnerfireAlert_Slash_Command;
end

function InnerfireAlert_Slash_Command(msg)
-- Nil --
end

-- End Slash Handler --



-- Titan Functions --

function TitanPanelRightClickMenu_PrepareInnerfireAlertMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_IFA_ID].menuText);
	TitanPanelRightClickMenu_AddToggleIcon(TITAN_IFA_ID);
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_IFA_ID);
	TitanPanelRightClickMenu_AddToggleColoredText(TITAN_IFA_ID);
	
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_IFA_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end