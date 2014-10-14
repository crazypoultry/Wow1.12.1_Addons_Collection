-----------------------------------------------------------
-- Wowhead DB By: UniRing
-----------------------------------------------------------
function WHDB_QuestLog_UpdateQuestDetails(prefix, doNotScroll)
	if (getglobal(prefix.."QuestLogFrame"):IsVisible()) then
	WHDB_MAP_NOTES = {};
	local questID = GetQuestLogSelection();
	local questTitle = GetQuestLogTitle(questID);
	if ( not questTitle ) then
		questTitle = "";
	end
	if ( IsCurrentQuestFailed() ) then
		questTitle = questTitle.." - ("..TEXT(FAILED)..")";
	end
	getglobal(prefix.."QuestLogQuestTitle"):SetText(questTitle);

	local questDescription;
	local questObjectives;
	questDescription, questObjectives = GetQuestLogQuestText();
	getglobal(prefix.."QuestLogObjectivesText"):SetText(questObjectives);
	
	local questTimer = GetQuestLogTimeLeft();
	if ( questTimer ) then
		getglobal(prefix.."QuestLogFrame").hasTimer = 1;
		getglobal(prefix.."QuestLogFrame").timePassed = 0;
		getglobal(prefix.."QuestLogTimerText"):Show();
		getglobal(prefix.."QuestLogTimerText"):SetText(TEXT(TIME_REMAINING).." "..SecondsToTime(questTimer));
		getglobal(prefix.."QuestLogObjective1"):SetPoint("TOPLEFT", prefix.."QuestLogTimerText", "BOTTOMLEFT", 0, -10);
	else
		getglobal(prefix.."QuestLogFrame").hasTimer = nil;
		getglobal(prefix.."QuestLogTimerText"):Hide();
		getglobal(prefix.."QuestLogObjective1"):SetPoint("TOPLEFT", prefix.."QuestLogObjectivesText", "BOTTOMLEFT", 0, -10);
	end
	
	local numObjectives = GetNumQuestLeaderBoards();
	
	local monsterName, zoneName, noteAdded, showMap, noteID;
	for i=1, numObjectives, 1 do
		local string = getglobal(prefix.."QuestLogObjective"..i);
		local text;
		local type;
		local finished;
		text, type, finished = GetQuestLogLeaderBoard(i);
		if ( not text or strlen(text) == 0 ) then
			text = type;
		end
		local i, j, itemName, numItems, numNeeded = strfind(text, "(.*):%s*([%d]+)%s*/%s*([%d]+)");
		
		if ( finished ) then
			string:SetTextColor(0.2, 0.2, 0.2);
			text = text.." ("..TEXT(COMPLETE)..")";
		else
			string:SetTextColor(0, 0, 0);
		end

		string:SetText(text);
		string:Show();
		QuestFrame_SetAsLastShown(string);
	end

	for i=numObjectives + 1, MAX_OBJECTIVES, 1 do
		getglobal(prefix.."QuestLogObjective"..i):Hide();
	end

	if ( GetQuestLogRequiredMoney() > 0 ) then
		if ( numObjectives > 0 ) then
			getglobal(prefix.."QuestLogRequiredMoneyText"):SetPoint("TOPLEFT", "QuestLogObjective"..numObjectives, "BOTTOMLEFT", 0, -4);
		else
			getglobal(prefix.."QuestLogRequiredMoneyText"):SetPoint("TOPLEFT", "QuestLogObjectivesText", "BOTTOMLEFT", 0, -10);
		end
		
		MoneyFrame_Update(prefix.."QuestLogRequiredMoneyFrame", GetQuestLogRequiredMoney());
		
		if ( GetQuestLogRequiredMoney() > GetMoney() ) then
			-- Not enough money
			getglobal(prefix.."QuestLogRequiredMoneyText"):SetTextColor(0, 0, 0);
			SetMoneyFrameColor(prefix.."QuestLogRequiredMoneyFrame", 1.0, 0.1, 0.1);
		else
			getglobal(prefix.."QuestLogRequiredMoneyText"):SetTextColor(0.2, 0.2, 0.2);
			SetMoneyFrameColor(prefix.."QuestLogRequiredMoneyFrame", 1.0, 1.0, 1.0);
		end
		getglobal(prefix.."QuestLogRequiredMoneyText"):Show();
		getglobal(prefix.."QuestLogRequiredMoneyFrame"):Show();
	else
		getglobal(prefix.."QuestLogRequiredMoneyText"):Hide();
		getglobal(prefix.."QuestLogRequiredMoneyFrame"):Hide();
	end

	if ( GetQuestLogRequiredMoney() > 0 ) then
		getglobal(prefix.."QuestLogDescriptionTitle"):SetPoint("TOPLEFT", prefix.."QuestLogRequiredMoneyText", "BOTTOMLEFT", 0, -10);
	elseif ( numObjectives > 0 ) then
		getglobal(prefix.."QuestLogDescriptionTitle"):SetPoint("TOPLEFT", prefix.."QuestLogObjective"..numObjectives, "BOTTOMLEFT", 0, -10);
	else
		if ( questTimer ) then
			getglobal(prefix.."QuestLogDescriptionTitle"):SetPoint("TOPLEFT", prefix.."QuestLogTimerText", "BOTTOMLEFT", 0, -10);
		else
			getglobal(prefix.."QuestLogDescriptionTitle"):SetPoint("TOPLEFT", prefix.."QuestLogObjectivesText", "BOTTOMLEFT", 0, -10);
		end
	end
	if ( questDescription ) then
		getglobal(prefix.."QuestLogQuestDescription"):SetText(questDescription);
		QuestFrame_SetAsLastShown(getglobal(prefix.."QuestLogQuestDescription"));
	end	
	
	local questComments = WHDB_GetComments(questTitle);

	if (getglobal(prefix.."QuestLogCommentsTitle") == nil) then
		-- getglobal(prefix.."QuestLogDetailScrollChildFrame"):CreateFontString(prefix.."QuestLogMapButtonsTitle","","QuestTitleFont");
		getglobal(prefix.."QuestLogDetailScrollChildFrame"):CreateFontString(prefix.."QuestLogCommentsTitle","","QuestTitleFont");
		getglobal(prefix.."QuestLogDetailScrollChildFrame"):CreateFontString(prefix.."QuestLogCommentsDescription","","QuestFont");
	end

	-- Copy description font color. (for skinner like addons)
	local r, g, b, a = getglobal(prefix.."QuestLogQuestDescription"):GetTextColor();
	
	getglobal(prefix.."QuestLogDescriptionTitle"):SetText("Описание");
	getglobal(prefix.."QuestLogRewardTitleText"):SetText("Награда");

	getglobal(prefix.."QuestLogCommentsTitle"):SetHeight(0);
	getglobal(prefix.."QuestLogCommentsTitle"):SetWidth(285);
	getglobal(prefix.."QuestLogCommentsTitle"):SetPoint("TOPLEFT", prefix.."QuestLogQuestDescription", "BOTTOMLEFT", 0, -13);
	getglobal(prefix.."QuestLogCommentsTitle"):SetJustifyH("LEFT");
	getglobal(prefix.."QuestLogCommentsTitle"):SetText("Комментарии");
	getglobal(prefix.."QuestLogCommentsTitle"):SetTextColor(r, g, b, a);

	getglobal(prefix.."QuestLogCommentsDescription"):SetHeight(0);
	getglobal(prefix.."QuestLogCommentsDescription"):SetWidth(270);
	getglobal(prefix.."QuestLogCommentsDescription"):SetPoint("TOPLEFT", prefix.."QuestLogCommentsTitle", "BOTTOMLEFT", 0, -5);
	getglobal(prefix.."QuestLogCommentsDescription"):SetJustifyH("LEFT");
	getglobal(prefix.."QuestLogCommentsDescription"):SetText(questComments);
	getglobal(prefix.."QuestLogCommentsDescription"):SetTextColor(r, g, b, a);
	
	getglobal(prefix.."QuestLogRewardTitleText"):SetPoint("TOPLEFT", prefix.."QuestLogCommentsDescription", "BOTTOMLEFT", 0, -15);

	QuestFrame_SetAsLastShown(getglobal(prefix.."QuestLogCommentsDescription"));

	local numRewards = GetNumQuestLogRewards();
	local numChoices = GetNumQuestLogChoices();
	local money = GetQuestLogRewardMoney();

	if ( (numRewards + numChoices + money) > 0 ) then
		getglobal(prefix.."QuestLogRewardTitleText"):Show();
		QuestFrame_SetAsLastShown(getglobal(prefix.."QuestLogRewardTitleText"));
	else
		getglobal(prefix.."QuestLogRewardTitleText"):Hide();
	end
	
	QuestFrameItems_Update("QuestLog");
	if ( not doNotScroll ) then
		getglobal(prefix.."QuestLogDetailScrollFrameScrollBar"):SetValue(0);
	end
	getglobal(prefix.."QuestLogDetailScrollFrame"):UpdateScrollChildRect();	
	end
end

function WHDB_GetComments(questTitle)
	local questComments = "";
	
	questTitle = string.gsub(questTitle,"%[.*%]%s","");
	if questRu[questTitle] ~= nil then
		if questEng[questRu[questTitle]["id"]] ~= nil then
			questTitle = questEng[questRu[questTitle]["id"]]
		end
	end

	if (qData[UnitFactionGroup("player")][questTitle] ~= nil) then
		for id, comment in ipairs(qData[UnitFactionGroup("player")][questTitle]['comments']) do
			questComments = questComments .. comment .."\n\n";
		end
	else
		questComments = questComments  .. "Нет комментариев.\n\n";
	end
	questComments = questComments .. "";
	questComments = string.gsub(questComments, "^[\n]*", "");
	questComments = string.gsub(questComments, "[\n]*$", "");
	return questComments;
end

function QuestLog_UpdateQuestDetails(doNotScroll)
	if (EQL3_QuestLogFrame ~= nil) then
		WHDB_QuestLog_UpdateQuestDetails("EQL3_", doNotScroll);
	elseif (QuestGuru_QuestLogFrame ~= nil) then
		WHDB_QuestLog_UpdateQuestDetails("QuestGuru_", doNotScroll);
	else
		WHDB_QuestLog_UpdateQuestDetails("", doNotScroll);
	end
end

function Print( text )
	if (not text) then
		return;	
	end
		ChatFrame1:AddMessage(GREEN_FONT_COLOR_CODE..""..text.."");
end

-- local frame = CreateFrame"Frame";
-- frame:SetScript("OnEvent",function()
-- 	WHDB_Event(event);
-- 	Print(event)
-- end)