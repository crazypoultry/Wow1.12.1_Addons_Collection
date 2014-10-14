--[[
	Gypsy_General.lua
	GypsyVersion++2004.11.14++
	
	Functions for the general interface options add-on. 
	Lag meter, casting bar capsule, tooltip, quest log functions.
]]

-- ** DEFAULT SETTINGS ** --

-- Default setting for cast bar capsule lock
Gypsy_DefaultLockCastCapsule = 0;
-- Show lag meter by default
Gypsy_DefaultShowLagMeter = 1;
-- Enable casting bar capsule by default
Gypsy_DefaultAnchorCastingFrame = 1;
-- Do not fade quest text by default
Gypsy_DefaultFadeQuestText = 0;
-- Show quest levels by default
Gypsy_DefaultShowQuestLevels = 1;
-- Don't anchor game tooltip to top middle by default
Gypsy_DefaultTooltipAnchorTopMiddle = 0;
-- Anchor tooltip to cursor by default
Gypsy_DefaultTooltipAnchorCursor = 1;

-- ** GENERAL VARIABLES ** --

-- Save the original game tooltip anchor function
Gypsy_OriginalGameTooltip_SetDefaultAnchor = GameTooltip_SetDefaultAnchor
-- Save the original quest log update function
Gypsy_OriginalQuestLog_Update = QuestLog_Update;

-- ** GENERAL OPTIONS FUNCTIONS ** --

-- Setup variable loading for general options without a frame
function Gypsy_GeneralLoadsOnLoad ()
	this:RegisterEvent("VARIABLES_LOADED");
end

function Gypsy_GeneralLoadsOnEvent ()
	if (event == "VARIABLES_LOADED") then
		if (GYPSY_SHELL == 1) then
			-- Set defaults if there is no saved value
			--if (Gypsy_RetrieveSaved("FadeQuestText") == nil) then
			--	Gypsy_FadeQuestText = Gypsy_DefaultFadeQuestText;
			--else
			--	Gypsy_FadeQuestText = Gypsy_RetrieveSaved("FadeQuestText");
			--end
			if (Gypsy_RetrieveSaved("TooltipAnchorTopMiddle") == nil) then
				Gypsy_TooltipAnchorTopMiddle = Gypsy_DefaultTooltipAnchorTopMiddle;
			else
				Gypsy_TooltipAnchorTopMiddle = Gypsy_RetrieveSaved("TooltipAnchorTopMiddle");
			end
			if (Gypsy_RetrieveSaved("TooltipAnchorCursor") == nil) then
				Gypsy_TooltipAnchorCursor = Gypsy_DefaultTooltipAnchorCursor;
			else
				Gypsy_TooltipAnchorCursor = Gypsy_RetrieveSaved("TooltipAnchorCursor");
			end	
			if (Gypsy_RetrieveSaved("ShowQuestLevels") == nil) then
				Gypsy_ShowQuestLevels = Gypsy_DefaultShowQuestLevels;
			else
				Gypsy_ShowQuestLevels = Gypsy_RetrieveSaved("ShowQuestLevels");
			end
			Gypsy_RegisterOption(50, "category", nil, nil, nil, GYPSY_TEXT_GENERAL_TABLABEL, GYPSY_TEXT_GENERAL_TABTOOLTIP);
			--Gypsy_RegisterOption(56, "check", Gypsy_FadeQuestText, "FadeQuestText", Gypsy_QuestTextFade, GYPSY_TEXT_GENERAL_QUESTFADELABEL, GYPSY_TEXT_GENERAL_QUESTFADETOOLTIP);
			Gypsy_RegisterOption(57, "header", nil, nil, nil, GYPSY_TEXT_GENERAL_QUESTLOGHEADERLABEL, GYPSY_TEXT_GENERAL_QUESTLOGHEADERTOOLTIP);
			Gypsy_RegisterOption(58, "header", nil, nil, nil, GYPSY_TEXT_GENERAL_TOOLTIPHEADERLABEL, GYPSY_TEXT_GENERAL_TOOLTIPHEADERTOOLTIP);
			Gypsy_RegisterOption(59, "check", Gypsy_TooltipAnchorTopMiddle, "TooltipAnchorTopMiddle", Gypsy_AnchorTooltipTopMiddle, GYPSY_TEXT_GENERAL_TOPMIDDLELABEL, GYPSY_TEXT_GENERAL_TOPMIDDLETOOLTIP);
			Gypsy_RegisterOption(60, "check", Gypsy_TooltipAnchorCursor, "TooltipAnchorCursor", Gypsy_AnchorTooltipCursor, GYPSY_TEXT_GENERAL_CURSORLABEL, GYPSY_TEXT_GENERAL_CURSORTOOLTIP);
			Gypsy_RegisterOption(61, "check", Gypsy_ShowQuestLevels, "ShowQuestLevels", QuestLog_Update, GYPSY_TEXT_GENERAL_QUESTLEVELLABEL, GYPSY_TEXT_GENERAL_QUESTLEVELTOOLTIP);
		else
			--if (Gypsy_FadeQuestText == nil) then
			--	Gypsy_FadeQuestText = Gypsy_DefaultFadeQuestText;
			--end
			if (Gypsy_TooltipAnchorTopMiddle == nil) then
				Gypsy_TooltipAnchorTopMiddle = Gypsy_DefaultTooltipAnchorTopMiddle;
			end
			if (Gypsy_TooltipAnchorCursor == nil) then
				Gypsy_TooltipAnchorCursor = Gypsy_DefaultTooltipAnchorCursor;
			end
			if (Gypsy_ShowQuestLevels == nil) then
				Gypsy_ShowQuestLevels = Gypsy_DefaultShowQuestLevels;
			end
			--RegisterForSave("Gypsy_FadeQuestText");
			--RegisterForSave("Gypsy_TooltipAnchorTopMiddle");
			--RegisterForSave("Gypsy_TooltipAnchorCursor");
			--RegisterForSave("Gypsy_ShowQuestLevels");
			--SlashCmdList["GYPSY_FADEQUESTTEXT"] = Gypsy_FadeQuestTextSlashHandler;
			--SLASH_GYPSY_FADEQUESTTEXT1 = "/generalquestfade";
			--SLASH_GYPSY_FADEQUESTTEXT2 = "/genquestfade";
			SlashCmdList["GYPSY_TOOLTIPANCHORTOPMIDDLE"] = Gypsy_TooltipAnchorTopMiddleSlashHandler;
			SLASH_GYPSY_TOOLTIPANCHORTOPMIDDLE1 = "/generaltooltiptopmiddle";
			SLASH_GYPSY_TOOLTIPANCHORTOPMIDDLE2 = "/gentooltiptopmiddle";
			SlashCmdList["GYPSY_TOOLTIPANCHORCURSOR"] = Gypsy_TooltipAnchorCursorSlashHandler;
			SLASH_GYPSY_TOOLTIPANCHORCURSOR1 = "/generaltooltipcursor";
			SLASH_GYPSY_TOOLTIPANCHORCURSOR2 = "/gentooltipcursor";
			SlashCmdList["GYPSY_SHOWQUESTLEVELS"] = Gypsy_ShowQuestLevelsSlashHandler;
			SLASH_GYPSY_SHOWQUESTLEVELS1 = "/generalshowquestlevels";
			SLASH_GYPSY_SHOWQUESTLEVELS2 = "/genshowquestlevels";
			SlashCmdList["GYPSY_GENERAL"] = Gypsy_GeneralSlashHandler;
			SLASH_GYPSY_GENERAL1 = "/general";
			SLASH_GYPSY_GENERAL2 = "/gen";
		end
	end
end

-- ** TOOLTIP FUNCTIONS ** --

-- Update the cursor tooltip anchor setting when the top middle option is selected
function Gypsy_AnchorTooltipTopMiddle ()
	if (this:GetChecked()) then
		local button = getglobal("Gypsy_Option60");
		button:SetChecked(0);
		Gypsy_UpdateValue(60, 0);
	end
end
	
-- Update the top middle tooltip anchor setting when the cursor option is selected
function Gypsy_AnchorTooltipCursor ()
	if (this:GetChecked()) then
		local button = getglobal("Gypsy_Option59");
		button:SetChecked(0);
		Gypsy_UpdateValue(59, 0);
	end
end

-- Replacement of the default game tooltip anchor function
function GameTooltip_SetDefaultAnchor(tooltip, parent)	
	-- Check for registrations and update
	if (Gypsy_RetrieveOption ~= nil) then
		if (Gypsy_RetrieveOption(59) ~= nil) then
			Gypsy_TooltipAnchorTopMiddle = Gypsy_RetrieveOption(59)[GYPSY_VALUE];
		end
		if (Gypsy_RetrieveOption(60) ~= nil) then
			Gypsy_TooltipAnchorCursor = Gypsy_RetrieveOption(60)[GYPSY_VALUE];
		end
	end
	-- If the tooltip needs to be anchored to the top middle, do that
	if (Gypsy_TooltipAnchorTopMiddle == 1) then
		tooltip:SetOwner(parent, "ANCHOR_NONE");
		tooltip:SetPoint("TOP", "UIParent", "TOP", 0, -10);		
	elseif (Gypsy_TooltipAnchorCursor == 1) then
		-- Or to the cursor
		tooltip:SetOwner(parent, "ANCHOR_CURSOR");
	else
		-- Or the default
		Gypsy_OriginalGameTooltip_SetDefaultAnchor(tooltip, parent);
	end
end

-- ** QUEST FUNCTIONS ** --

-- Quest text fade update function
function Gypsy_QuestTextFade()
--[[	-- Check registrations and update variables
	if (Gypsy_RetrieveOption ~= nil) then
		if (Gypsy_RetrieveOption(56) ~= nil) then
			Gypsy_FadeQuestText = Gypsy_RetrieveOption(56)[GYPSY_VALUE];
		end
	end
	-- Update global variables as needed
	if (Gypsy_FadeQuestText == 1) then
		QUEST_FADING_ENABLE = 1;
		QUEST_DESCRIPTION_GRADIENT_CPS = 40;
	else
		QUEST_FADING_ENABLE = 0;
		QUEST_DESCRIPTION_GRADIENT_CPS = 20000;
	end]]
end

-- New quest log update wrapper
function QuestLog_Update ()
	-- Check registrations and update settings
	if (Gypsy_RetrieveOption ~= nil) then
		if (Gypsy_RetrieveOption(61) ~= nil) then
			Gypsy_ShowQuestLevels = Gypsy_RetrieveOption(61)[GYPSY_VALUE];
		end
	end
	-- If we're showing quest levels, run our update function, else run the old one
	if (Gypsy_ShowQuestLevels == 1) then
		Gypsy_QuestLog_Update();
	else
		Gypsy_OriginalQuestLog_Update();
	end
end

--[[function Gypsy_QuestLog_Update()
	local numEntries, numQuests = GetNumQuestLogEntries();
	if ( numEntries == 0 ) then
		EmptyQuestLogFrame:Show();
		QuestLogFrameAbandonButton:Disable();
		QuestLogFrame.hasTimer = nil;
		QuestLogDetailScrollFrame:Hide();
		QuestLogExpandButtonFrame:Hide();
	else
		EmptyQuestLogFrame:Hide();
		QuestLogFrameAbandonButton:Enable();
		QuestLogDetailScrollFrame:Show();
		QuestLogExpandButtonFrame:Show();
	end

	-- Update Quest Count
	QuestLogQuestCount:SetText(format(QUEST_LOG_COUNT_TEMPLATE, numQuests, MAX_QUESTLOG_QUESTS));
	QuestLogCountMiddle:SetWidth(QuestLogQuestCount:GetWidth());

	-- ScrollFrame update
	FauxScrollFrame_Update(QuestLogListScrollFrame, numEntries, QUESTS_DISPLAYED, QUESTLOG_QUEST_HEIGHT, nil, nil, nil, QuestLogHighlightFrame, 293, 316 )
	
	-- Update the quest listing
	QuestLogHighlightFrame:Hide();
	
	local questIndex, questLogTitle, questTitleTag, questNumGroupMates, questNormalText, questHighlightText, questDisabledText, questHighlight, questCheck;
	local questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete, color;
	local numPartyMembers, isOnQuest, partyMembersOnQuest, tempWidth;
	for i=1, QUESTS_DISPLAYED, 1 do
		questIndex = i + FauxScrollFrame_GetOffset(QuestLogListScrollFrame);
		questLogTitle = getglobal("QuestLogTitle"..i);
		questTitleTag = getglobal("QuestLogTitle"..i.."Tag");
		questNumGroupMates = getglobal("QuestLogTitle"..i.."GroupMates");
		questCheck = getglobal("QuestLogTitle"..i.."Check");
		questNormalText = getglobal("QuestLogTitle"..i.."NormalText");
		questHighlightText = getglobal("QuestLogTitle"..i.."HighlightText");
		questDisabledText = getglobal("QuestLogTitle"..i.."DisabledText");
		questHighlight = getglobal("QuestLogTitle"..i.."Highlight");
		if ( questIndex <= numEntries ) then
			questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete = GetQuestLogTitle(questIndex);
			if ( isHeader ) then
				if ( questLogTitleText ) then
					questLogTitle:SetText(questLogTitleText);
				else
					questLogTitle:SetText("");
				end
				
				if ( isCollapsed ) then
					questLogTitle:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
				else
					questLogTitle:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
				end
				questHighlight:SetTexture("Interface\\Buttons\\UI-PlusButton-Hilight");
				questNumGroupMates:SetText("");
				questCheck:Hide();
			else
				questLogTitle:SetText("  [" .. level .. "] "..questLogTitleText);
				--Set Dummy text to get text width *SUPER HACK*
				QuestLogDummyText:SetText("  [" .. level .. "] "..questLogTitleText);

				questLogTitle:SetNormalTexture("");
				questHighlight:SetTexture("");

				-- If not a header see if any nearby group mates are on this quest
				numPartyMembers = GetNumPartyMembers();
				if ( numPartyMembers == 0 ) then
					--return;
				end
				partyMembersOnQuest = 0;
				for j=1, numPartyMembers do
					isOnQuest = IsUnitOnQuest(questIndex, "party"..j);
					if ( isOnQuest and isOnQuest == 1 ) then
						partyMembersOnQuest = partyMembersOnQuest + 1;
					end
				end
				if ( partyMembersOnQuest > 0 ) then
					questNumGroupMates:SetText("["..partyMembersOnQuest.."]");
				else
					questNumGroupMates:SetText("");
				end
			end
			-- Save if its a header or not
			questLogTitle.isHeader = isHeader;

			-- Set the quest tag
			if ( isComplete and isComplete < 0 ) then
				questTag = FAILED;
			elseif ( isComplete and isComplete > 0 ) then
				questTag = COMPLETE;
			end
			if ( questTag ) then
				questTitleTag:SetText("("..questTag..")");
				-- Shrink text to accomdate quest tags without wrapping
				tempWidth = 275 - 5 - questTitleTag:GetWidth();
				questNormalText:SetWidth(tempWidth);
				questHighlightText:SetWidth(tempWidth);
				questDisabledText:SetWidth(tempWidth);
				
				-- If there's quest tag position check accordingly
				questCheck:Hide();
				if ( IsQuestWatched(questIndex) ) then
					questCheck:SetPoint("LEFT", questLogTitle:GetName(), "LEFT", tempWidth+24, 0);
					questCheck:Show();
				end
			else
				questTitleTag:SetText("");
				-- Reset to max text width
				questNormalText:SetWidth(275);
				questHighlightText:SetWidth(275);
				questDisabledText:SetWidth(275);

				-- Show check if quest is being watched
				questCheck:Hide();
				if ( IsQuestWatched(questIndex) ) then
					questCheck:SetPoint("LEFT", questLogTitle:GetName(), "LEFT", QuestLogDummyText:GetWidth()+24, 0);
					questCheck:Show();
				end
			end

			-- Color the quest title and highlight according to the difficulty level
			local playerLevel = UnitLevel("player");
			if ( isHeader ) then
				color = QuestDifficultyColor["header"];
			else
				color = GetDifficultyColor(level);
			end
			questTitleTag:SetTextColor(color.r, color.g, color.b);
			questLogTitle:SetTextColor(color.r, color.g, color.b);
			questNumGroupMates:SetTextColor(color.r, color.g, color.b);
			questLogTitle.r = color.r;
			questLogTitle.g = color.g;
			questLogTitle.b = color.b;
			questLogTitle:Show();

			-- Place the highlight and lock the highlight state
			if ( QuestLogFrame.selectedButtonID and GetQuestLogSelection() == questIndex ) then
				QuestLogHighlightFrame:SetPoint("TOPLEFT", "QuestLogTitle"..i, "TOPLEFT", 0, 0);
				QuestLogHighlightFrame:Show();
				questTitleTag:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
				questLogTitle:LockHighlight();
			else
				questLogTitle:UnlockHighlight();
			end
		else
			questLogTitle:Hide();
		end
	end
		
	-- Set the expand/collapse all button texture
	local numHeaders = 0;
	local notExpanded = 0;
	-- Somewhat redundant loop, but cleaner than the alternatives
	for i=1, numEntries, 1 do
		local index = i;
		local questLogTitleText, level, questTag, isHeader, isCollapsed = GetQuestLogTitle(i);
		if ( questLogTitleText and isHeader ) then
			numHeaders = numHeaders + 1;
			if ( isCollapsed ) then
				notExpanded = notExpanded + 1;
			end
		end
	end
	-- If all headers are not expanded then show collapse button, otherwise show the expand button
	if ( notExpanded ~= numHeaders ) then
		QuestLogCollapseAllButton.collapsed = nil;
		QuestLogCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
	else
		QuestLogCollapseAllButton.collapsed = 1;
		QuestLogCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
	end

	-- Update Quest Count
	QuestLogQuestCount:SetText(format(QUEST_LOG_COUNT_TEMPLATE, numQuests, MAX_QUESTLOG_QUESTS));
	QuestLogCountMiddle:SetWidth(QuestLogQuestCount:GetWidth());

	-- If no selection then set it to the first available quest
	if ( GetQuestLogSelection() == 0 ) then
		QuestLog_SetFirstValidSelection();
	end

	-- Determine whether the selected quest is pushable or not
	if ( numEntries == 0 ) then
		QuestFramePushQuestButton:Disable();
	elseif ( GetQuestLogPushable() and GetNumPartyMembers() > 0 ) then
		QuestFramePushQuestButton:Enable();
	else
		QuestFramePushQuestButton:Disable();
	end
end]]

function Gypsy_QuestLog_Update()
	local numEntries, numQuests = GetNumQuestLogEntries();
	if ( numEntries == 0 ) then
		EmptyQuestLogFrame:Show();
		QuestLogFrameAbandonButton:Disable();
		QuestLogFrame.hasTimer = nil;
		QuestLogDetailScrollFrame:Hide();
		QuestLogExpandButtonFrame:Hide();
	else
		EmptyQuestLogFrame:Hide();
		QuestLogFrameAbandonButton:Enable();
		QuestLogDetailScrollFrame:Show();
		QuestLogExpandButtonFrame:Show();
	end

	-- Update Quest Count
	QuestLogQuestCount:SetText(format(QUEST_LOG_COUNT_TEMPLATE, numQuests, MAX_QUESTLOG_QUESTS));
	QuestLogCountMiddle:SetWidth(QuestLogQuestCount:GetWidth());

	-- ScrollFrame update
	FauxScrollFrame_Update(QuestLogListScrollFrame, numEntries, QUESTS_DISPLAYED, QUESTLOG_QUEST_HEIGHT, nil, nil, nil, QuestLogHighlightFrame, 293, 316 )
	
	-- Update the quest listing
	QuestLogHighlightFrame:Hide();
	
	local questIndex, questLogTitle, questTitleTag, questNumGroupMates, questNormalText, questHighlight, questCheck;
	local questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete, color;
	local numPartyMembers, partyMembersOnQuest, tempWidth, textWidth;
	for i=1, QUESTS_DISPLAYED, 1 do
		questIndex = i + FauxScrollFrame_GetOffset(QuestLogListScrollFrame);
		questLogTitle = getglobal("QuestLogTitle"..i);
		questTitleTag = getglobal("QuestLogTitle"..i.."Tag");
		questNumGroupMates = getglobal("QuestLogTitle"..i.."GroupMates");
		questCheck = getglobal("QuestLogTitle"..i.."Check");
		questNormalText = getglobal("QuestLogTitle"..i.."NormalText");
		questHighlight = getglobal("QuestLogTitle"..i.."Highlight");
		if ( questIndex <= numEntries ) then
			questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete = GetQuestLogTitle(questIndex);
			if ( isHeader ) then
				if ( questLogTitleText ) then
					questLogTitle:SetText(questLogTitleText);
				else
					questLogTitle:SetText("");
				end
				
				if ( isCollapsed ) then
					questLogTitle:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
				else
					questLogTitle:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
				end
				questHighlight:SetTexture("Interface\\Buttons\\UI-PlusButton-Hilight");
				questNumGroupMates:SetText("");
				questCheck:Hide();
			else
				questLogTitle:SetText("  ["..level.."] "..questLogTitleText);
				--Set Dummy text to get text width *SUPER HACK*
				QuestLogDummyText:SetText("  ["..level.."] "..questLogTitleText);

				questLogTitle:SetNormalTexture("");
				questHighlight:SetTexture("");

				-- If not a header see if any nearby group mates are on this quest
				numPartyMembers = GetNumPartyMembers();
				if ( numPartyMembers == 0 ) then
					--return;
				end
				partyMembersOnQuest = 0;
				for j=1, numPartyMembers do
					if ( IsUnitOnQuest(questIndex, "party"..j) ) then
						partyMembersOnQuest = partyMembersOnQuest + 1;
					end
				end
				if ( partyMembersOnQuest > 0 ) then
					questNumGroupMates:SetText("["..partyMembersOnQuest.."]");
				else
					questNumGroupMates:SetText("");
				end
			end
			-- Save if its a header or not
			questLogTitle.isHeader = isHeader;

			-- Set the quest tag
			if ( isComplete and isComplete < 0 ) then
				questTag = FAILED;
			elseif ( isComplete and isComplete > 0 ) then
				questTag = COMPLETE;
			end
			if ( questTag ) then
				questTitleTag:SetText("("..questTag..")");
				-- Shrink text to accomdate quest tags without wrapping
				tempWidth = 275 - 15 - questTitleTag:GetWidth();
				
				if ( QuestLogDummyText:GetWidth() > tempWidth ) then
					textWidth = tempWidth;
				else
					textWidth = QuestLogDummyText:GetWidth();
				end
				
				questNormalText:SetWidth(tempWidth);
				
				-- If there's quest tag position check accordingly
				questCheck:Hide();
				if ( IsQuestWatched(questIndex) ) then
					questCheck:SetPoint("LEFT", questLogTitle, "LEFT", textWidth+24, 0);
					questCheck:Show();
				end
			else
				questTitleTag:SetText("");
				-- Reset to max text width
				questNormalText:SetWidth(275);

				-- Show check if quest is being watched
				questCheck:Hide();
				if ( IsQuestWatched(questIndex) ) then
					questCheck:SetPoint("LEFT", questLogTitle, "LEFT", QuestLogDummyText:GetWidth()+24, 0);
					questCheck:Show();
				end
			end

			-- Color the quest title and highlight according to the difficulty level
			local playerLevel = UnitLevel("player");
			if ( isHeader ) then
				color = QuestDifficultyColor["header"];
			else
				color = GetDifficultyColor(level);
			end
			questTitleTag:SetTextColor(color.r, color.g, color.b);
			questLogTitle:SetTextColor(color.r, color.g, color.b);
			questNumGroupMates:SetTextColor(color.r, color.g, color.b);
			questLogTitle.r = color.r;
			questLogTitle.g = color.g;
			questLogTitle.b = color.b;
			questLogTitle:Show();

			-- Place the highlight and lock the highlight state
			if ( QuestLogFrame.selectedButtonID and GetQuestLogSelection() == questIndex ) then
				QuestLogHighlightFrame:SetPoint("TOPLEFT", "QuestLogTitle"..i, "TOPLEFT", 0, 0);
				QuestLogHighlightFrame:Show();
				questTitleTag:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
				questLogTitle:LockHighlight();
			else
				questLogTitle:UnlockHighlight();
			end
		else
			questLogTitle:Hide();
		end
	end
		
	-- Set the expand/collapse all button texture
	local numHeaders = 0;
	local notExpanded = 0;
	-- Somewhat redundant loop, but cleaner than the alternatives
	for i=1, numEntries, 1 do
		local index = i;
		local questLogTitleText, level, questTag, isHeader, isCollapsed = GetQuestLogTitle(i);
		if ( questLogTitleText and isHeader ) then
			numHeaders = numHeaders + 1;
			if ( isCollapsed ) then
				notExpanded = notExpanded + 1;
			end
		end
	end
	-- If all headers are not expanded then show collapse button, otherwise show the expand button
	if ( notExpanded ~= numHeaders ) then
		QuestLogCollapseAllButton.collapsed = nil;
		QuestLogCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
	else
		QuestLogCollapseAllButton.collapsed = 1;
		QuestLogCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
	end

	-- Update Quest Count
	QuestLogQuestCount:SetText(format(QUEST_LOG_COUNT_TEMPLATE, numQuests, MAX_QUESTLOG_QUESTS));
	QuestLogCountMiddle:SetWidth(QuestLogQuestCount:GetWidth());

	-- If no selection then set it to the first available quest
	if ( GetQuestLogSelection() == 0 ) then
		QuestLog_SetFirstValidSelection();
	end

	-- Determine whether the selected quest is pushable or not
	if ( numEntries == 0 ) then
		QuestFramePushQuestButton:Disable();
	elseif ( GetQuestLogPushable() and GetNumPartyMembers() > 0 ) then
		QuestFramePushQuestButton:Enable();
	else
		QuestFramePushQuestButton:Disable();
	end
end

-- Same as the default quest log update function except the added quest text display
--[[function Gypsy_QuestLog_Update()
	local numEntries, numQuests = GetNumQuestLogEntries();
	if ( numEntries == 0 ) then
		EmptyQuestLogFrame:Show();
		QuestLogFrameAbandonButton:Disable();
		QuestLogFrame.hasTimer = nil;
		QuestLogDetailScrollFrame:Hide();
		QuestLogExpandButtonFrame:Hide();
	else
		EmptyQuestLogFrame:Hide();
		QuestLogFrameAbandonButton:Enable();
		QuestLogDetailScrollFrame:Show();
		QuestLogExpandButtonFrame:Show();
	end

	-- Update Quest Count
	QuestLogQuestCount:SetText(format(QUEST_LOG_COUNT_TEMPLATE, numQuests, MAX_QUESTLOG_QUESTS));
	QuestLogCountMiddle:SetWidth(QuestLogQuestCount:GetWidth());

	-- ScrollFrame update
	FauxScrollFrame_Update(QuestLogListScrollFrame, numEntries, QUESTS_DISPLAYED, QUESTLOG_QUEST_HEIGHT, QuestLogHighlightFrame, 293, 316 )
	
	-- Update the quest listing
	QuestLogHighlightFrame:Hide();
	
	local questIndex, questLogTitle, questTitleTag, questNumGroupMates, questNormalText, questHighlightText, questDisabledText, questHighlight, questCheck;
	local questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete, color;
	local numPartyMembers, isOnQuest, partyMembersOnQuest, tempWidth;
	for i=1, QUESTS_DISPLAYED, 1 do
		questIndex = i + FauxScrollFrame_GetOffset(QuestLogListScrollFrame);
		questLogTitle = getglobal("QuestLogTitle"..i);
		questTitleTag = getglobal("QuestLogTitle"..i.."Tag");
		questNumGroupMates = getglobal("QuestLogTitle"..i.."GroupMates");
		questCheck = getglobal("QuestLogTitle"..i.."Check");
		questNormalText = getglobal("QuestLogTitle"..i.."NormalText");
		questHighlightText = getglobal("QuestLogTitle"..i.."HighlightText");
		questDisabledText = getglobal("QuestLogTitle"..i.."DisabledText");
		questHighlight = getglobal("QuestLogTitle"..i.."Highlight");
		if ( questIndex <= numEntries ) then
			questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete = GetQuestLogTitle(questIndex);
			if ( isHeader ) then
				if ( questLogTitleText ) then
					questLogTitle:SetText(questLogTitleText);
				else
					questLogTitle:SetText("");
				end
				
				if ( isCollapsed ) then
					questLogTitle:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
				else
					questLogTitle:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
				end
				questHighlight:SetTexture("Interface\\Buttons\\UI-PlusButton-Hilight");
				questNumGroupMates:SetText("");
				questCheck:Hide();
			else
				-- Level text added
				questLogTitle:SetText("  ".. "[" .. level .. "] " .. questLogTitleText);
				--Set Dummy text to get text width *SUPER HACK*
				QuestLogDummyText:SetText("  ".. "[" .. level .. "] " .. questLogTitleText);

				questLogTitle:SetNormalTexture("");
				questHighlight:SetTexture("");

				-- If not a header see if any nearby group mates are on this quest
				numPartyMembers = GetNumPartyMembers();
				if ( numPartyMembers == 0 ) then
					--return;
				end
				partyMembersOnQuest = 0;
				for j=1, numPartyMembers do
					isOnQuest = IsUnitOnQuest(questIndex, "party"..j);
					if ( isOnQuest and isOnQuest == 1 ) then
						partyMembersOnQuest = partyMembersOnQuest + 1;
					end
				end
				if ( partyMembersOnQuest > 0 ) then
					questNumGroupMates:SetText("["..partyMembersOnQuest.."]");
				else
					questNumGroupMates:SetText("");
				end
			end
			-- Save if its a header or not
			questLogTitle.isHeader = isHeader;

			-- Set the quest tag
			if ( isComplete ) then
				questTag = COMPLETE;
			end
			if ( questTag ) then
				questTitleTag:SetText("("..questTag..")");
				-- Shrink text to accomdate quest tags without wrapping
				tempWidth = 275 - 5 - questTitleTag:GetWidth();
				questNormalText:SetWidth(tempWidth);
				questHighlightText:SetWidth(tempWidth);
				questDisabledText:SetWidth(tempWidth);
				
				-- If there's quest tag position check accordingly
				questCheck:Hide();
				if ( IsQuestWatched(questIndex) ) then
					questCheck:SetPoint("LEFT", questLogTitle:GetName(), "LEFT", tempWidth+24, 0);
					questCheck:Show();
				end
			else
				questTitleTag:SetText("");
				-- Reset to max text width
				questNormalText:SetWidth(275);
				questHighlightText:SetWidth(275);
				questDisabledText:SetWidth(275);

				-- Show check if quest is being watched
				questCheck:Hide();
				if ( IsQuestWatched(questIndex) ) then
					questCheck:SetPoint("LEFT", questLogTitle:GetName(), "LEFT", QuestLogDummyText:GetWidth()+24, 0);
					questCheck:Show();
				end
			end

			-- Color the quest title and highlight according to the difficulty level
			local playerLevel = UnitLevel("player");
			if ( isHeader ) then
				color = QuestDifficultyColor["header"];
			else
				color = GetDifficultyColor(level);
			end
			questTitleTag:SetTextColor(color.r, color.g, color.b);
			questLogTitle:SetTextColor(color.r, color.g, color.b);
			questNumGroupMates:SetTextColor(color.r, color.g, color.b);
			questLogTitle.r = color.r;
			questLogTitle.g = color.g;
			questLogTitle.b = color.b;
			questLogTitle:Show();

			-- Place the highlight and lock the highlight state
			if ( QuestLogFrame.selectedButtonID and GetQuestLogSelection() == questIndex ) then
				QuestLogHighlightFrame:SetPoint("TOPLEFT", "QuestLogTitle"..i, "TOPLEFT", 0, 0);
				QuestLogHighlightFrame:Show();
				questTitleTag:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
				questLogTitle:LockHighlight();
			else
				questLogTitle:UnlockHighlight();
			end
		else
			questLogTitle:Hide();
		end
	end
		
	-- Set the expand/collapse all button texture
	local numHeaders = 0;
	local notExpanded = 0;
	-- Somewhat redundant loop, but cleaner than the alternatives
	for i=1, numEntries, 1 do
		local index = i;
		local questLogTitleText, level, questTag, isHeader, isCollapsed = GetQuestLogTitle(i);
		if ( questLogTitleText and isHeader ) then
			numHeaders = numHeaders + 1;
			if ( isCollapsed ) then
				notExpanded = notExpanded + 1;
			end
		end
	end
	-- If all headers are not expanded then show collapse button, otherwise show the expand button
	if ( notExpanded ~= numHeaders ) then
		QuestLogCollapseAllButton.collapsed = nil;
		QuestLogCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
	else
		QuestLogCollapseAllButton.collapsed = 1;
		QuestLogCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
	end

	-- Update Quest Count
	QuestLogQuestCount:SetText(format(QUEST_LOG_COUNT_TEMPLATE, numQuests, MAX_QUESTLOG_QUESTS));
	QuestLogCountMiddle:SetWidth(QuestLogQuestCount:GetWidth());

	-- If no selection then set it to the first available quest
	if ( GetQuestLogSelection() == 0 ) then
		QuestLog_SetFirstValidSelection();
	end

	-- Determine whether the selected quest is pushable or not
	if ( numEntries == 0 ) then
		QuestFramePushQuestButton:Disable();
	elseif ( GetQuestLogPushable() and GetNumPartyMembers() > 0 ) then
		QuestFramePushQuestButton:Enable();
	else
		QuestFramePushQuestButton:Disable();
	end
end]]

-- ** CASTING BAR FUNCTIONS ** --

-- Setup variable loading for the cast bar capsule
function Gypsy_CastBarCapsuleOnLoad ()
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("SPELLCAST_START");
	this:RegisterEvent("SPELLCAST_STOP");
	this:RegisterEvent("SPELLCAST_FAILED");
	this:RegisterEvent("SPELLCAST_INTERRUPTED");
	this:RegisterEvent("SPELLCAST_DELAYED");
	this:RegisterEvent("SPELLCAST_CHANNEL_START");
	this:RegisterEvent("SPELLCAST_CHANNEL_UPDATE");
	Gypsy_CastBarCapsuleArt:SetBackdropBorderColor(0, 0, 0);
	Gypsy_CastBarCapsuleArt:SetBackdropColor(0, 0, 0);	
end

function Gypsy_CastBarCapsuleOnEvent (event)
	if (event == "VARIABLES_LOADED") then
		if (GYPSY_SHELL == 1) then
			-- Set defaults if there is no saved value
			if (Gypsy_RetrieveSaved("AnchorCastingFrame") == nil) then
				Gypsy_AnchorCastingFrame = Gypsy_DefaultAnchorCastingFrame;
			else
				Gypsy_AnchorCastingFrame = Gypsy_RetrieveSaved("AnchorCastingFrame");
			end

			-- Register with GypsyMod saving
			Gypsy_RegisterOption(52, "check", Gypsy_AnchorCastingFrame, "AnchorCastingFrame", Gypsy_UpdateCastFrameAnchor, GYPSY_TEXT_GENERAL_CASTCAPSULELABEL, GYPSY_TEXT_GENERAL_CASTCAPSULETOOLTIP);
			Gypsy_RegisterOption(53, "button", nil, nil, Gypsy_ResetCastBarCapsule, GYPSY_TEXT_GENERAL_RESETLABEL, GYPSY_TEXT_GENERAL_RESETTOOLTIP);
			Gypsy_RegisterOption(54, "header", nil, nil, nil, GYPSY_TEXT_GENERAL_CASTHEADERLABEL, GYPSY_TEXT_GENERAL_CASTHEADERTOOLTIP);	
		else
			if (Gypsy_AnchorCastingFrame == nil) then
				Gypsy_AnchorCastingFrame = Gypsy_DefaultAnchorCastingFrame;
			end			
			if (Gypsy_LockCastCapsule == nil) then
				Gypsy_LockCastCapsule = Gypsy_DefaultLockCastCapsule;
			end
			--RegisterForSave("Gypsy_AnchorCastingFrame");
			--RegisterForSave("Gypsy_LockCastCapsule");
			-- Register slash commands
			SlashCmdList["GYPSY_ANCHORCASTINGFRAME"] = Gypsy_AnchorCastingFrameSlashHandler;			
			SLASH_GYPSY_ANCHORCASTINGFRAME1 = "/generalenablecastcapsule";
			SLASH_GYPSY_ANCHORCASTINGFRAME2 = "/genenablecastcapsule";
			SlashCmdList["GYPSY_LOCKCASTCAPSULE"] = Gypsy_LockCastCapsuleSlashHandler;
			SLASH_GYPSY_LOCKCASTCAPSULE1 = "/generallockcastcapsule";
			SLASH_GYPSY_LOCKCASTCAPSULE2 = "/genlockcastcapsule";
			SlashCmdList["GYPSY_RESETCASTCAPSULE"] = Gypsy_ResetCastCapsuleSlashHandler;
			SLASH_GYPSY_RESETCASTCAPSULE1 = "/generalresetcastcapsule";
			SLASH_GYPSY_RESETCASTCAPSULE2 = "/genresetcastcapsule";			
		end		
		Gypsy_QuestTextFade();
		return;
	end
	if (event == "SPELLCAST_START" or event == "SPELLCAST_STOP" or event == "SPELLCAST_CHANNEL_START" or event == "SPELLCAST_CHANNEL_UPDATE" or event == "SPELLCAST_FAILED" or event == "SPELLCAST_DELAYED") then
		-- Watch for casting bar stuff to update our anchoring
		Gypsy_UpdateCastFrameAnchor();
		return;
	end
end

function Gypsy_CastBarCapsuleOnUpdate ()	
	-- Toggle the casting bar capsule, this will only occur if the UpdateCastFrameAnchor has determined to show the casting bar frame capsule
	Gypsy_ToggleCastBarCapsule();
	-- If the casting bar frame is visible then update our anchoring
	if (CastingBarFrame:IsVisible()) then
		Gypsy_UpdateCastFrameAnchor();
	end	
end

-- Reset casting bar position
function Gypsy_ResetCastBarCapsule ()
	-- Update either local or Shell values
	if (GYPSY_SHELL == 1) then
		Gypsy_UpdateValue(52, Gypsy_DefaultAnchorCastingFrame);
	else
		Gypsy_AnchorCastingFrame = Gypsy_DefaultAnchorCastingFrame;
	end
	Gypsy_CastBarCapsule:Show();
	Gypsy_CastBarCapsule:ClearAllPoints();
	Gypsy_CastBarCapsule:SetPoint("BOTTOM", "UIParent", "BOTTOM", 0, 100);
	Gypsy_UpdateCastFrameAnchor();
end

-- Update function for the casting frame anchoring
function Gypsy_UpdateCastFrameAnchor ()
	-- Retrieve GypsyMod shell value if applicable
	if (Gypsy_RetrieveOption ~= nil) then
		if (Gypsy_RetrieveOption(52) ~= nil) then
			Gypsy_AnchorCastingFrame = Gypsy_RetrieveOption(52)[GYPSY_VALUE];
		end
	end
	-- If we're using the capsule, show it, and anchor the casting bar frame, else hide it and set the cast bar in it's default position
	if (Gypsy_AnchorCastingFrame == 1) then
		Gypsy_CastBarCapsule:Show();
		CastingBarFrame:ClearAllPoints();
		CastingBarFrame:SetPoint("BOTTOM", "Gypsy_CastBarCapsule", "BOTTOM", 0, 15);
		--[[CastingBarFlash:ClearAllPoints();
		CastingBarFlash:SetPoint("CENTER", "Gypsy_CastBarCapsule", "CENTER", 0, -5);
		CastingBarFrameStatusBar:ClearAllPoints();
		CastingBarFrameStatusBar:SetPoint("CENTER", "Gypsy_CastBarCapsule", "CENTER", 0, -5);
		CastingBarText:ClearAllPoints();
		CastingBarText:SetPoint("CENTER", "Gypsy_CastBarCapsule", "CENTER", 0, -5);]]
	else
		Gypsy_CastBarCapsule:Hide();
		CastingBarFrame:ClearAllPoints();
		CastingBarFrame:SetPoint("BOTTOM", "UIParent", "BOTTOM", 0, 83);
		--[[CastingBarFlash:ClearAllPoints();
		CastingBarFlash:SetPoint("CENTER", "CastingBarFrame", "CENTER", 0, 4);
		CastingBarFrameStatusBar:ClearAllPoints();
		CastingBarFrameStatusBar:SetPoint("CENTER", "CastingBarFrame", "CENTER", 0, 4);
		CastingBarText:ClearAllPoints();
		CastingBarText:SetPoint("TOP", "CastingBarFrame", "TOP", 0, 0);]]
	end
end

-- Casting bar capsule toggle function
function Gypsy_ToggleCastBarCapsule ()
	-- Get value from the Shell if enabled
	if (Gypsy_RetrieveOption ~= nil) then
		if (Gypsy_RetrieveOption(52) ~= nil) then
			Gypsy_AnchorCastingFrame = Gypsy_RetrieveOption(52)[GYPSY_VALUE];
		end
	end
	-- Only toggle if the capsule is enabled
	if (Gypsy_AnchorCastingFrame == 1) then
		-- If the Shell is present, update the local lock variable
		if (GYPSY_SHELL ~= nil) then
			Gypsy_LockCastCapsule = GYPSY_LOCKALL;
		end
		-- Then, if GypsyMod is not locked, go ahead and show/hide or drag the capsule as needed, or if it is locked, hide the capsule so it can't be dragged
		if (Gypsy_LockCastCapsule == 0) then
			if (not Gypsy_CastBarCapsule:IsVisible()) then
				Gypsy_CastBarCapsule:Show();
			end
			if (MouseIsOver(Gypsy_CastBarCapsule)) then
				Gypsy_CastBarCapsuleArt:Show();
			else
				Gypsy_CastBarCapsuleArt:Hide();
			end
		else
			Gypsy_CastBarCapsule:Hide();
		end
	end
end

-- ** LAG METER FUNCTIONS ** --

-- Lag meter onLoad, register for variable loading seperately
function Gypsy_LagMeterOnLoad()	
	this:RegisterEvent("VARIABLES_LOADED");
end

-- Take care of configuration things once variables are loaded
function Gypsy_LagMeterOnEvent (event)
	if (event == "VARIABLES_LOADED") then
		if (GYPSY_SHELL == 1) then			
			-- Set defaults if there is no saved value
			if (Gypsy_RetrieveSaved("ShowLagMeter") == nil) then
				Gypsy_ShowLagMeter = Gypsy_DefaultShowLagMeter;	
			else
				Gypsy_ShowLagMeter = Gypsy_RetrieveSaved("ShowLagMeter");
			end
			--Register with GypsyMod saving
			Gypsy_RegisterOption(51, "check", Gypsy_ShowLagMeter, "ShowLagMeter", Gypsy_ToggleLagMeter, GYPSY_TEXT_GENERAL_SHOWLAGMETERLABEL, GYPSY_TEXT_GENERAL_SHOWLAGMETERTOOLTIP);
			Gypsy_RegisterOption(55, "header", nil, nil, nil, GYPSY_TEXT_GENERAL_LAGHEADERLABEL, GYPSY_TEXT_GENERAL_LAGHEADERTOOLTIP);		
		else
			if (Gypsy_ShowLagMeter == nil) then
				Gypsy_ShowLagMeter = Gypsy_DefaultShowLagMeter;
			end
			--RegisterForSave("Gypsy_ShowLagMeter");
			-- Register slash commands
			SlashCmdList["GYPSY_SHOWLAGMETER"] = Gypsy_ShowLagMeterSlashHandler;			
			SLASH_GYPSY_SHOWLAGMETER1 = "/generallagmeter";
			SLASH_GYPSY_SHOWLAGMETER2 = "/genlagmeter";
		end
		Gypsy_ToggleLagMeter();
		return;
	end
end

-- Lag meter toggle function
function Gypsy_ToggleLagMeter ()
	-- Check for registrations and update
	if (Gypsy_RetrieveOption ~= nil) then
		if (Gypsy_RetrieveOption(51) ~= nil) then
			Gypsy_ShowLagMeter = Gypsy_RetrieveOption(51)[GYPSY_VALUE];
		end
	end
	-- Show or hide
	if (Gypsy_ShowLagMeter == 1) then
		Gypsy_PerformanceBarFrame:Show();
		MiniMapMailFrame:ClearAllPoints();
		MiniMapMailFrame:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", -24, -32);
		if (MiniMapMeetingStoneFrame) then
			MiniMapMeetingStoneFrame:ClearAllPoints();
			MiniMapMeetingStoneFrame:SetPoint("TOP", "MiniMapMailFrame", "BOTTOM", -3, 5);
		end
	else
		Gypsy_PerformanceBarFrame:Hide();
		MiniMapMailFrame:ClearAllPoints();
		MiniMapMailFrame:SetPoint("TOPRIGHT", "Minimap", "TOPRIGHT", 21, -38);
		if (MiniMapMeetingStoneFrame) then
			MiniMapMeetingStoneFrame:ClearAllPoints();
			MiniMapMeetingStoneFrame:SetPoint("TOPRIGHT", "Minimap", "TOPRIGHT", 23, -65);
		end
	end
end

-- ** SLASH HANDLER FUNCTIONS ** --

function Gypsy_AnchorCastingFrameSlashHandler(msg)
	-- Due to the nature of slash commands, 'msg' will never be nil, so we don't require a check
	msg = string.lower(msg);
	if (msg == "enable" or msg == "1" or msg == "true") then
		Gypsy_AnchorCastingFrame = 1;
		DEFAULT_CHAT_FRAME:AddMessage("Enabling cast bar capsule.", 1, 1, 1);
	elseif (msg == "disable" or msg == "0" or msg == "false") then
		Gypsy_AnchorCastingFrame = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Disabling cast bar capsule.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Gypsy_AnchorCastingFrame = Gypsy_DefaultAnchorCastingFrame;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting cast bar capsule state to default.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /generalenablecastcapsule /genenablecastcapsule", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   enable, true, or 1 - Enable casting bar capsule.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   disable, false, or 0 - Disable casting bar capsule.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	elseif (msg == "") then
		if (Gypsy_AnchorCastingFrame == 1) then 
			Gypsy_AnchorCastingFrame = 0; 
			DEFAULT_CHAT_FRAME:AddMessage("Disabling cast bar capsule.", 1, 1, 1);
		else 
			Gypsy_AnchorCastingFrame = 1; 
			DEFAULT_CHAT_FRAME:AddMessage("Enabling cast bar capsule.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /generalenablecastcapsule /genenablecastcapsule", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   enable, true, or 1 - Enable casting bar capsule.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   disable, false, or 0 - Disable casting bar capsule.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);	
	end
	Gypsy_UpdateCastFrameAnchor();
end

function Gypsy_ShowLagMeterSlashHandler(msg)
	-- Due to the nature of slash commands, 'msg' will never be nil, so we don't require a check
	msg = string.lower(msg);
	if (msg == "show" or msg == "1" or msg == "true") then
		Gypsy_ShowLagMeter = 1;
		DEFAULT_CHAT_FRAME:AddMessage("Showing GypsyMod lag meter.", 1, 1, 1);
	elseif (msg == "hide" or msg == "0" or msg == "false") then
		Gypsy_ShowLagMeter = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Hiding GypsyMod lag meter.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Gypsy_ShowLagMeter = Gypsy_DefaultShowLagMeter;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting lag meter state to default.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /generallagmeter /genlagmeter", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   show, true, or 1 - Show GypsyMod lag meter.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   hide, false, or 0 - Hide GypsyMod lag meter.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	elseif (msg == "") then
		if (Gypsy_ShowLagMeter == 1) then 
			Gypsy_ShowLagMeter = 0; 
			DEFAULT_CHAT_FRAME:AddMessage("Hiding GypsyMod lag meter.", 1, 1, 1);
		else 
			Gypsy_ShowLagMeter = 1; 
			DEFAULT_CHAT_FRAME:AddMessage("Showing GypsyMod lag meter.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /generallagmeter /genlagmeter", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   show, true, or 1 - Show GypsyMod lag meter.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   hide, false, or 0 - Hide GypsyMod lag meter.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);	
	end
	Gypsy_ToggleLagMeter();
end

function Gypsy_FadeQuestTextSlashHandler(msg)
	msg = string.lower(msg);
	if (msg == "yes" or msg == "1" or msg == "true") then
		Gypsy_FadeQuestText = 1;
		DEFAULT_CHAT_FRAME:AddMessage("Fading quest text according to normal behavior.", 1, 1, 1);
	elseif (msg == "no" or msg == "0" or msg == "false") then
		Gypsy_FadeQuestText = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Removing quest text fade time.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Gypsy_FadeQuestText = Gypsy_DefaultFadeQuestText;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting quest text fade option to default.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /generalquestfade /genquestfade", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Enable quest text fading.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Disable quest text fading.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	elseif (msg == "") then
		if (Gypsy_FadeQuestText == 1) then
			Gypsy_FadeQuestText = 0;
			DEFAULT_CHAT_FRAME:AddMessage("Removing quest text fade time.", 1, 1, 1);
		else
			Gypsy_FadeQuestText = 1;
			DEFAULT_CHAT_FRAME:AddMessage("Fading quest text according to normal behavior.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /generalquestfade /genquestfade", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Enable quest text fading.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Disable quest text fading.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);	
	end	
	Gypsy_QuestTextFade();
end

function Gypsy_TooltipAnchorTopMiddleSlashHandler(msg)
	msg = string.lower(msg);
	if (msg == "yes" or msg == "1" or msg == "true") then
		Gypsy_TooltipAnchorTopMiddle = 1;
		Gypsy_TooltipAnchorCursor = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Positioning tooltip at the top middle of the screen.", 1, 1, 1);
	elseif (msg == "no" or msg == "0" or msg == "false") then
		Gypsy_TooltipAnchorTopMiddle = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Positioning tooltip at the default position.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Gypsy_TooltipAnchorTopMiddle = Gypsy_DefaultTooltipAnchorTopMiddle;
		Gypsy_TooltipAnchorCursor = Gypsy_DefaultTooltipAnchorCursor;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting tooltip positioning option to default.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /generaltooltiptopmiddle /gentooltiptopmiddle", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Position the tooltip at the top middle of the screen.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Position the tooltip at the default location.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	elseif (msg == "") then
		if (Gypsy_TooltipAnchorTopMiddle == 1) then
			Gypsy_TooltipAnchorTopMiddle = 0;
			DEFAULT_CHAT_FRAME:AddMessage("Positioning tooltip at the default position.", 1, 1, 1);
		else
			Gypsy_TooltipAnchorTopMiddle = 1;
			Gypsy_TooltipAnchorCursor = 0;
			DEFAULT_CHAT_FRAME:AddMessage("Positioning tooltip at the top middle of the screen.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /generaltooltiptopmiddle /gentooltiptopmiddle", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Position the tooltip at the top middle of the screen.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Position the tooltip at the default location.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);	
	end	
end

function Gypsy_TooltipAnchorCursorSlashHandler(msg)
	msg = string.lower(msg);
	if (msg == "yes" or msg == "1" or msg == "true") then
		Gypsy_TooltipAnchorCursor = 1;
		Gypsy_TooltipAnchorTopMiddle = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Positioning tooltip to follow the cursor.", 1, 1, 1);
	elseif (msg == "no" or msg == "0" or msg == "false") then
		Gypsy_TooltipAnchorCursor = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Positioning tooltip at the default position.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Gypsy_TooltipAnchorCursor = Gypsy_DefaultTooltipAnchorCursor;
		Gypsy_TooltipAnchorTopMiddle = Gypsy_DefaultTooltipAnchorTopMiddle;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting tooltip positioning option to default.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /generaltooltipcursor /gentooltipcursor", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Position the tooltip to follow the cursor.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Position the tooltip at the default location.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	elseif (msg == "") then
		if (Gypsy_TooltipAnchorCursor == 1) then
			Gypsy_TooltipAnchorCursor = 0;
			DEFAULT_CHAT_FRAME:AddMessage("Positioning tooltip at the default position.", 1, 1, 1);
		else
			Gypsy_TooltipAnchorCursor = 1;
			Gypsy_TooltipAnchorTopMiddle = 0;
			DEFAULT_CHAT_FRAME:AddMessage("Positioning tooltip to follow the cursor.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /generaltooltipcursor /gentooltipcursor", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Position the tooltip to follow the cursor.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Position the tooltip at the default location.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	end	
end

function Gypsy_ShowQuestLevelsSlashHandler(msg)
	msg = string.lower(msg);
	if (msg == "yes" or msg == "1" or msg == "true") then
		Gypsy_ShowQuestLevels = 1;
		DEFAULT_CHAT_FRAME:AddMessage("Showing quest levels in the quest log.", 1, 1, 1);
	elseif (msg == "no" or msg == "0" or msg == "false") then
		Gypsy_ShowQuestLevels = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Hiding quest levels.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Gypsy_ShowQuestLevels = Gypsy_DefaultShowQuestLevels;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting quest level option to default.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /generalshowquestlevels /genshowquestlevels", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Show quest levels in quest log.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Do not show quest levels in quest log.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	elseif (msg == "") then
		if (Gypsy_ShowQuestLevels == 1) then
			Gypsy_ShowQuestLevels = 0;
			DEFAULT_CHAT_FRAME:AddMessage("Hiding quest levels.", 1, 1, 1);
		else
			Gypsy_ShowQuestLevels = 1;
			DEFAULT_CHAT_FRAME:AddMessage("Showing quest levels in the quest log.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /generalshowquestlevels /genshowquestlevels", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Show quest levels in quest log.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Do not show quest levels in quest log.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	end	
end

function Gypsy_LockCastCapsuleSlashHandler(msg)
	msg = string.lower(msg);
	if (msg == "yes" or msg == "1" or msg == "true") then
		Gypsy_LockCastCapsule = 1;
		DEFAULT_CHAT_FRAME:AddMessage("Locking casting bar capsule.", 1, 1, 1);
	elseif (msg == "no" or msg == "0" or msg == "false") then
		Gypsy_LockCastCapsule = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Unlocking casting bar capsule", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Gypsy_LockCastCapsule = Gypsy_DefaultLockCastCapsule;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting casting bar capsule lock state to default.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /generallockcastcapsule /genlockcastcapsule", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Lock casting bar capsule.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Unlock casting bar capsule.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	elseif (msg == "") then
		if (Gypsy_LockCastCapsule == 1) then
			Gypsy_LockCastCapsule = 0;
			DEFAULT_CHAT_FRAME:AddMessage("Unlocking casting bar capsule.", 1, 1, 1);
		else
			Gypsy_LockCastCapsule = 1;
			DEFAULT_CHAT_FRAME:AddMessage("Locking casting bar capsule.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /generallockcastcapsule /genlockcastcapsule", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Lock casting bar capsule.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Unlock casting bar capsule.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	end	
end

function Gypsy_ResetCastCapsuleSlashHandler(msg)
	Gypsy_ResetCastBarCapsule();
	DEFAULT_CHAT_FRAME:AddMessage("Resetting casting bar capsule.", 1, 1, 1);
end

function Gypsy_GeneralSlashHandler(msg)
	DEFAULT_CHAT_FRAME:AddMessage("Valid slash commands for the General add-on", 1, 0.89, 0.01);
	DEFAULT_CHAT_FRAME:AddMessage("All commands may begin with either /general or /gen, ex. /generalquestfade", 1, 0.80, 0.01);
	DEFAULT_CHAT_FRAME:AddMessage("Entering help after any command will display a list of valid parameters.", 1, 0.80, 0);
	DEFAULT_CHAT_FRAME:AddMessage("   enablecastcapsule - Enable/Disable casting bar capsule.", 1, 1, 1);
	DEFAULT_CHAT_FRAME:AddMessage("   lockcastcapsule - Lock/Unlock the casting bar capsule.", 1, 1, 1);
	DEFAULT_CHAT_FRAME:AddMessage("   resetcastcapsule - Reset the casting bar capsule.", 1, 1, 1);
	DEFAULT_CHAT_FRAME:AddMessage("   questfade - Enable/Disable quest text fading.", 1, 1, 1);
	DEFAULT_CHAT_FRAME:AddMessage("   showquestlevels - Show/Hide quest levels in the quest log.", 1, 1, 1);
	DEFAULT_CHAT_FRAME:AddMessage("   tooltiptopmiddle - Position the tooltip at the top middle of the screen.", 1, 1, 1);
	DEFAULT_CHAT_FRAME:AddMessage("   tooltipcursor - Position the tooltip to follow the cursor.", 1, 1, 1);
	DEFAULT_CHAT_FRAME:AddMessage("   lagmeter - Toggle the GypsyMod lag meter.", 1, 1, 1);	
end	