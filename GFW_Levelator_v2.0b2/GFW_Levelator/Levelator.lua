------------------------------------------------------
-- Levelator.lua
------------------------------------------------------

function FLV_OnEvent(self, inEvent)
	if (inEvent == nil) then
		-- little hack to allow the same code to work on 1.12 and 2.0
		inEvent = event;
	end
	if (inEvent == "GOSSIP_SHOW") then
		local availibleList = {GetGossipAvailableQuests()};
		for i = 2, table.getn(availibleList), 2 do
			local button = getglobal("GossipTitleButton"..(i/2));
			button:SetText(string.format('[%d] %s', availibleList[i], availibleList[i-1]));
		end
		local activeList = {GetGossipActiveQuests()};
		for i = 2, table.getn(activeList), 2 do
			local buttonNum = (i/2);
			local availableCount = table.getn(availibleList);
			if (availableCount > 0) then
				buttonNum = buttonNum + availableCount / 2 + 1;
			end
			local button = getglobal("GossipTitleButton"..buttonNum);
			button:SetText(string.format('[%d] %s', activeList[i], activeList[i-1]));
		end
	elseif (inEvent == "QUEST_GREETING") then
		for i = 1, GetNumActiveQuests() do
			local level = GetActiveLevel(i);
			local title = GetActiveTitle(i);
			local button = getglobal("QuestTitleButton"..i);
			button:SetText(string.format('[%d] %s', level, title));
		end
		for i = 1, GetNumAvailableQuests() do
			local level = GetAvailableLevel(i);
			local title = GetAvailableTitle(i);
			local button = getglobal("QuestTitleButton"..i + (GetNumActiveQuests() or 0));
			button:SetText(string.format('[%d] %s', level, title));
		end
	end
end

function FLV_GetQuestLogTitle(questIndex)
	title, level, tag, isHeader, isCollapsed, isComplete = FLV_Orig_GetQuestLogTitle(questIndex);
	if (title and not isHeader) then
		if (tag) then
			title = "["..level.."+] "..title;
		else
			title = "["..level.."] "..title;
		end
	end
	return title, level, tag, isHeader, isCollapsed, isComplete;
end


FLV_EventFrame = CreateFrame("Frame", nil, nil);
FLV_EventFrame:SetScript("OnEvent", FLV_OnEvent);
FLV_EventFrame:RegisterEvent("GOSSIP_SHOW");
FLV_EventFrame:RegisterEvent("QUEST_GREETING");

FLV_Orig_GetQuestLogTitle = GetQuestLogTitle;
GetQuestLogTitle = FLV_GetQuestLogTitle;

local version = GetAddOnMetadata("GFW_Levelator", "Version");
GFWUtils.Print("Fizzwidget Levelator "..version.." initialized!");
