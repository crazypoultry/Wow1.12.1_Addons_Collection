--
-- CombatMonitor v2.0
-- World of Warcraft UI AddOn to track defensive combat statistics
-- 2005 Satrina@Stormrage
--

CMON_opponentListSize = 18;
CMON_opponentListHeight = 16;
CMON_opponentList = {};

function CombatMonitor_SelectOpponent()
	if CombatMonitorOpponentListFrame:IsVisible() then
		CombatMonitorOpponentListFrame:Hide();
	else
		CombatMonitorOpponentListFrame:Show();
		CombatMonitor_UpdateOpponentList();
	end
end

function CombatMonitor_OpponentListButtonOnClick(button)
	if (button == "LeftButton") then
		CMVar[CMON_player].currentIndex = this.index;
		CombatMonitor_UpdateSummary()
		CombatMonitor_UpdateDetails();
		if CombatMonitorCopyFrame:IsVisible() then
			CombatMonitor_CopyFrame();
		end
	else
		if (this.index > 1) then
			if this.check then
				this.check = nil;
			else
				this.check = 1;
			end
			CMVar[CMON_player].defenseStats[this.index].save = this.check;
		end
	end
	CombatMonitor_UpdateOpponentList();
end

function CombatMonitor_UpdateOpponentList()
	local offset = FauxScrollFrame_GetOffset(CombatMonitorOpponentListScrollFrame);
	local listIndex;
	local statsIndex;
	
	CombatMonitor_OpponentListSort();
	
	if (table.getn(CMVar[CMON_player].defenseStats) > CMON_opponentListSize) then
		CombatMonitorOpponentListFrame:SetWidth(225);
	else
		CombatMonitorOpponentListFrame:SetWidth(200);
	end

	for i=1,CMON_opponentListSize do
		listIndex = offset + i;
		button = getglobal("CombatMonitorOpponentListFrameButton"..i);
		buttonCheck = getglobal("CombatMonitorOpponentListFrameButton"..i.."Check");
		
		if (listIndex <= table.getn(CMVar[CMON_player].defenseStats)) then
			statsIndex = CMON_opponentList[listIndex];
			button:Show();
			button.index = statsIndex;
			button.check = CMVar[CMON_player].defenseStats[statsIndex].save;
			if button.check then
				buttonCheck:Show();
			else
				buttonCheck:Hide();
			end
			
			name = getglobal("CombatMonitorOpponentListFrameButton"..i.."Name");
			name:SetText(CMVar[CMON_player].defenseStats[statsIndex].name);
			
			-- Highlight the selected name
			if (CMVar[CMON_player].currentIndex == statsIndex) then
				button:LockHighlight();
				name:SetTextColor(1, 1, 1);
				else
				button:UnlockHighlight();
				name:SetTextColor(1, 0.82, 0);
			end
		else	
			button:Hide();
		end
	end
	FauxScrollFrame_Update(CombatMonitorOpponentListScrollFrame, table.getn(CMVar[CMON_player].defenseStats), CMON_opponentListSize, CMON_opponentListHeight);
end

function CombatMonitor_OpponentListSortFunction(a, b)
	-- Index 1 is "All Opponents", so make sure it always goes before whatever it may be compared against
	-- otherwise return the true name comparison for sorting.
	if (a == 1) then
		return true;
	elseif (b == 1) then
		return false;
	else
		return CMVar[CMON_player].defenseStats[a].name < CMVar[CMON_player].defenseStats[b].name;
	end
end

function CombatMonitor_OpponentListSort()
	-- Make sure everyone is in the indexing table
	if (table.getn(CMON_opponentList) ~= table.getn(CMVar[CMON_player].defenseStats)) then
		CMON_opponentList = {};	
		for i=1,table.getn(CMVar[CMON_player].defenseStats) do
			table.insert(CMON_opponentList, i);
		end
	end
	
	table.sort(CMON_opponentList, CombatMonitor_OpponentListSortFunction);
end

function CombatMonitor_ToggleSave()
	
end