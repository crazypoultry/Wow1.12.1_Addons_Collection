function AmmoExchange_OnLoad()
	AmmoExchange_Print("AmmoExchange 1.0 By Xanthos Loaded");
    this:RegisterEvent("QUEST_PROGRESS");
    this:RegisterEvent("QUEST_COMPLETE");
end

function AmmoExchange_Print(text)
    DEFAULT_CHAT_FRAME:AddMessage(text);
end

function AmmoExchange_OnEvent(event)
	if ( event == "QUEST_PROGRESS" ) then
		local QuestName = GetTitleText();
		if QuestName ~= nil then
			if ((QuestName == "Arrows Are For Sissies") or (QuestName == "A Fair Trade")) then
				if(IsQuestCompletable()) then
					CompleteQuest();
				end
			end
		end
	end
	
	if ( event == "QUEST_COMPLETE" ) then
		local QuestName = GetTitleText();
		if QuestName ~= nil then
			if ((QuestName == "Arrows Are For Sissies") or (QuestName == "A Fair Trade")) then
				if(IsQuestCompletable()) then
					GetQuestReward(1);
				end
			end
		end
	end
end