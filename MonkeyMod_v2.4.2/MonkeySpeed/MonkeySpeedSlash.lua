--[[

	MonkeySpeed:
	A simple speedometer.
	
	Author: Trentin

	Resurected by: Quel

--]]

function MonkeySpeed_TogglePercent()
	-- if not loaded yet then get out
	if (MonkeySpeed.m_bLoaded == false) then
		return;
	end
	
	if (MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplayPercent) then
		MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplayPercent = false;
		MonkeySpeedText:Hide();
	else
		MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplayPercent = true;
		MonkeySpeedText:Show();
	end
	
	-- check for MonkeyBuddy
	if (MonkeyBuddySpeedFrame_Refresh ~= nil) then
		MonkeyBuddySpeedFrame_Refresh();
	end
end

function MonkeySpeed_ToggleBar()
	-- if not loaded yet then get out
	if (MonkeySpeed.m_bLoaded == false) then
		return;
	end
	
	if (MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplayBar) then
		MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplayBar = false;
		MonkeySpeedBar:Hide();
	else
		MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplayBar = true;
		MonkeySpeedBar:Show();
	end
	
	-- check for MonkeyBuddy
	if (MonkeyBuddySpeedFrame_Refresh ~= nil) then
		MonkeyBuddySpeedFrame_Refresh();
	end
end

function MonkeySpeed_ToggleDisplay()
	-- if not loaded yet then get out
	if (MonkeySpeed.m_bLoaded == false) then
		return;
	end
	
	if (MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplay) then
		MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplay = false;
		MonkeySpeedFrame:Hide();
	else
		MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplay = true;
		MonkeySpeedFrame:Show();
	end
	
	-- check for MonkeyBuddy
	if (MonkeyBuddySpeedFrame_Refresh ~= nil) then
		MonkeyBuddySpeedFrame_Refresh();
	end
end

function MonkeySpeed_ToggleDebug()
	-- if not loaded yet then get out
	if (MonkeySpeed.m_bLoaded == false) then
		return;
	end
	
	MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDebugMode = not MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDebugMode;
end

function MonkeySpeed_ToggleLock()
	-- if not loaded yet then get out
	if (MonkeySpeed.m_bLoaded == false) then
		return;
	end
	
	MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bLocked = not MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bLocked;
	
	-- check for MonkeyBuddy
	if (MonkeyBuddySpeedFrame_Refresh ~= nil) then
		MonkeyBuddySpeedFrame_Refresh();
	end
end

function MonkeySpeedSlash_CmdShowPercent(bShow)
	-- if not loaded yet then get out
	if (MonkeySpeed.m_bLoaded == false) then
		return;
	end
	
	if (bShow == true) then
		MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplayPercent = true;
		MonkeySpeedText:Show();
	else
		MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplayPercent = false;
		MonkeySpeedText:Hide();
	end
	
	-- check for MonkeyBuddy
	if (MonkeyBuddySpeedFrame_Refresh ~= nil) then
		MonkeyBuddySpeedFrame_Refresh();
	end
end

function MonkeySpeedSlash_CmdShowBar(bShow)
	-- if not loaded yet then get out
	if (MonkeySpeed.m_bLoaded == false) then
		return;
	end
	
	if (bShow == true) then
		MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplayBar = true;
		MonkeySpeedBar:Show();
	else
		MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplayBar = false;
		MonkeySpeedBar:Hide();
	end
	
	-- check for MonkeyBuddy
	if (MonkeyBuddySpeedFrame_Refresh ~= nil) then
		MonkeyBuddySpeedFrame_Refresh();
	end
end

function MonkeySpeedSlash_CmdOpen(bOpen)
	-- if not loaded yet then get out
	if (MonkeySpeed.m_bLoaded == false) then
		return;
	end
	
	if (bOpen == true) then
		MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplay = true;
		MonkeySpeedFrame:Show();
	else
		MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplay = false;
		MonkeySpeedFrame:Hide();
	end
	
	-- check for MonkeyBuddy
	if (MonkeyBuddySpeedFrame_Refresh ~= nil) then
		MonkeyBuddySpeedFrame_Refresh();
	end
end

function MonkeySpeedSlash_CmdLock(bLock)
	-- if not loaded yet then get out
	if (MonkeySpeed.m_bLoaded == false) then
		return;
	end
	
	MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bLocked = bLock;
	
	-- check for MonkeyBuddy
	if (MonkeyBuddySpeedFrame_Refresh ~= nil) then
		MonkeyBuddySpeedFrame_Refresh();
	end
end

function MonkeySpeedSlash_CmdCalibrate()
	-- if not loaded yet then get out
	if (MonkeySpeed.m_bLoaded == false) then
		return;
	end
	
	-- next update, recalibrate MonkeySpeed
	MonkeySpeed.m_bCalibrate = true;
end

function MonkeySpeedSlash_CmdSetWidth(iWidth)
	if (iWidth >= 48 and iWidth <= 256) then
		MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_iFrameWidth = iWidth;
		MonkeySpeedFrame:SetWidth(MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_iFrameWidth);
		MonkeySpeedBar:SetWidth(MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_iFrameWidth - 10);
		--MonkeySpeed_Refresh();
	end
	
	-- check for MonkeyBuddy
	if (MonkeyBuddySpeedFrame_Refresh ~= nil) then
		MonkeyBuddySpeedFrame_Refresh();
	end
end

function MonkeySpeedSlash_CmdReset()
	-- if not loaded yet then get out
	if (MonkeySpeed.m_bLoaded == false) then
		return;
	end
	
	StaticPopup_Show("MONKEYSPEED_RESET");
end
