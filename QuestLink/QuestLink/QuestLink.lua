local old_ChatFrame_OnHyperlinkShow = ChatFrame_OnHyperlinkShow
ChatFrame_OnHyperlinkShow = function(link, text, button)
	if strsub(link, 1, 6) == "quest2" then
		if text then
			local ds = string.find(text, "quest2:", 1, true)
			local ns = string.find(text, "\124h[", 1, true)
			local ne = string.find(text, "]\124h\124r", 1, true)
			if not ns or not ne then
				return
			end
			local name = "\124cffffff00" .. strsub(text, ns+3, ne-1) .. "\124r"
			local desc = nil
			if ds then
				desc = strsub(text, ds+7, ns-1)
			end
			ShowUIPanel(QuestLinkTooltip);
			if ( not QuestLinkTooltip:IsVisible() ) then
				QuestLinkTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE");
			end
			QuestLinkTooltip:SetText(name)
			if desc then
				QuestLinkTooltip:AddLine(desc, 255, 255, 255, 255, 1)
				QuestLinkTooltip:Show()
			end
		end
		return
	end
	old_ChatFrame_OnHyperlinkShow(link, text, button)
end

if not IsAddOnLoaded("EQL3") then
	function QuestLogTitleButton_OnClick(button)
		local questName = this:GetText();
		local questIndex = this:GetID() + FauxScrollFrame_GetOffset(QuestLogListScrollFrame);
		if ( IsShiftKeyDown() ) then
			-- If header then return
			if ( this.isHeader ) then
				return;
			end
			-- Otherwise try to track it or put it into chat
			if ( ChatFrameEditBox:IsVisible() ) then
				local msg = "\124cffffff00\124Hquest2"
				local name = gsub(questName, " *(.*)", "%1")
				_, desc = GetQuestLogQuestText()
				if desc then
					msg = msg .. ":"
					if strlen(name) + strlen(desc) > 225 then
						msg = msg .. "Quest description too long"
					else
						msg = msg .. desc
					end
				end
				msg = msg .. "\124h[" .. name .. "]\124h\124r"
				ChatFrameEditBox:Insert(msg);
			else
				-- Shift-click toggles quest-watch on this quest.
				if ( IsQuestWatched(questIndex) ) then
					tremove(QUEST_WATCH_LIST, questIndex);
					RemoveQuestWatch(questIndex);
					QuestWatch_Update();
				else
					-- Set error if no objectives
					if ( GetNumQuestLeaderBoards(questIndex) == 0 ) then
						UIErrorsFrame:AddMessage(QUEST_WATCH_NO_OBJECTIVES, 1.0, 0.1, 0.1, 1.0);
						return;
					end
					-- Set an error message if trying to show too many quests
					if ( GetNumQuestWatches() >= MAX_WATCHABLE_QUESTS ) then
						UIErrorsFrame:AddMessage(format(QUEST_WATCH_TOO_MANY, MAX_WATCHABLE_QUESTS), 1.0, 0.1, 0.1, 1.0);
						return;
					end
					AutoQuestWatch_Insert(questIndex, QUEST_WATCH_NO_EXPIRE);
					QuestWatch_Update();
				end
			end
		end
		QuestLog_SetSelection(questIndex)
		QuestLog_Update();
	end
end

-- /script DEFAULT_CHAT_FRAME:AddMessage("\124cffffff00\124Hquest:8428:49\124h[Battle of Warsong Gulch]\124h\124r");