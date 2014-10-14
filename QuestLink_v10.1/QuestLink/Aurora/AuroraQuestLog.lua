--[[
--
--	Aurora Quest Log
--
--		An simpler way of showing a custom quest
--
--		by Alexander Brazie
--
--]]

AURORAQUESTLOG_MAX_OBJECTIVES = 30;
AURORAQUESTLOG_MAX_ITEMS = 10;

-- Debug Toggles
AURORAQUESTLOG_DEBUG = true;
AQ_DEBUG = "AURORAQUESTLOG_DEBUG";

local AuroraQuestLog_InspectCursorNeeded = false
local AuroraQuestLog_InspectCursorSet = false
--
--[[ Update the new Quest Log Frame ]]--
--
function AuroraQuestLog_LoadQuest(questLogName, QuestData)
	local frame = getglobal(questLogName);

	if ( frame ) then 
		frame.QuestData = QuestData;
	end
end

--
--	Retrieves the current quest in the log
--
function AuroraQuestLog_GetQuest(questLogName)
	local frame = getglobal(questLogName);

	if ( frame ) then 
		return frame.QuestData;
	end
end

--
--[[ Update the new Quest Log Frame ]]--
--
function AuroraQuestLog_Clear(questLogName)
	local frame = getglobal(questLogName);

	if ( frame ) then 
		frame.QuestData = nil;
	end
	AuroraQuestLog_Update(questLogName);
end



--
-- Updates the quest log 
-- 

--(This is just a giant cut and paste from the 
-- Blizz version. Ugly, but effective! )

function AuroraQuestLog_Update(questLogName)
	local QuestData = getglobal(questLogName).QuestData;

	if ( not QuestData ) then 
		QuestData = {};
	end

	local questTitle = QuestData.title;
	if ( not questTitle ) then
		questTitle = "";
	end
	if ( QuestData.failed ) then
		questTitle = questTitle.." - ("..TEXT(FAILED)..")";
	end
	getglobal(questLogName.."QuestTitle"):SetText(questTitle);

	local questDescription, questObjectives = QuestData.description, QuestData.objective;
	getglobal(questLogName.."ObjectivesText"):SetText(questObjectives);
	
	local questTimer = QuestData.timer;
	if ( questTimer ) then
		getglobal(questLogName).hasTimer = 1;
		getglobal(questLogName).timePassed = 0;
		getglobal(questLogName.."TimerText"):Show();
		getglobal(questLogName.."TimerText"):SetText(TEXT(TIME_REMAINING).." "..SecondsToTime(questTimer));
		getglobal(questLogName.."Objective1"):SetPoint("TOPLEFT", questLogName.."TimerText", "BOTTOMLEFT", 0, -10);
	else
		getglobal(questLogName).hasTimer = nil;
		getglobal(questLogName.."TimerText"):Hide();
		getglobal(questLogName.."Objective1"):SetPoint("TOPLEFT", questLogName.."ObjectivesText", "BOTTOMLEFT", 0, -10);
	end
	
	local numObjectives = 0;
	if ( QuestData.objectives ) then numObjectives = table.getn(QuestData.objectives) end;
	for i=1, numObjectives, 1 do
		local string = getglobal(questLogName.."Objective"..i);
		local text;
		local type;
		local finished;
		text, type, finished = QuestData.objectives[i].text, QuestData.objectives[i].questType, QuestData.objectives[i].finished; 
		if ( not text or strlen(text) == 0 ) then
			text = type;
		end
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
		getglobal(questLogName.."Objective"..i):Hide();
	end
	
	-- If there's money required then anchor and display it
	if ( QuestData.requiredMoney ) then
		if ( numObjectives > 0 ) then
			getglobal(questLogName.."RequiredMoneyText"):SetPoint("TOPLEFT", questLogName.."Objective"..numObjectives, "BOTTOMLEFT", 0, -4);
		else
			getglobal(questLogName.."RequiredMoneyText"):SetPoint("TOPLEFT", questLogName.."ObjectivesText", "BOTTOMLEFT", 0, -10);
		end
		
		MoneyFrame_Update(questLogName.."RequiredMoneyFrame", QuestData.requiredMoney);
		
		if ( QuestData.requiredMoney > GetMoney() ) then
			-- Not enough money
			getglobal(questLogName.."RequiredMoneyText"):SetTextColor(0, 0, 0);
			SetMoneyFrameColor(questLogName.."RequiredMoneyFrame", 1.0, 0.1, 0.1);
		else
			getglobal(questLogName.."RequiredMoneyText"):SetTextColor(0.2, 0.2, 0.2);
			SetMoneyFrameColor(questLogName.."RequiredMoneyFrame", 1.0, 1.0, 1.0);
		end
		getglobal(questLogName.."RequiredMoneyText"):Show();
		getglobal(questLogName.."RequiredMoneyFrame"):Show();
	else
		getglobal(questLogName.."RequiredMoneyText"):Hide();
		getglobal(questLogName.."RequiredMoneyFrame"):Hide();
	end

	if ( QuestData.requiredMoney ) then
		getglobal(questLogName.."DescriptionTitle"):SetPoint("TOPLEFT", questLogName.."RequiredMoneyText", "BOTTOMLEFT", 0, -10);
	elseif ( numObjectives > 0 ) then
		getglobal(questLogName.."DescriptionTitle"):SetPoint("TOPLEFT", questLogName.."Objective"..numObjectives, "BOTTOMLEFT", 0, -10);
	else
		if ( questTimer ) then
			getglobal(questLogName.."DescriptionTitle"):SetPoint("TOPLEFT", questLogName.."TimerText", "BOTTOMLEFT", 0, -10);
		else
			getglobal(questLogName.."DescriptionTitle"):SetPoint("TOPLEFT", questLogName.."ObjectivesText", "BOTTOMLEFT", 0, -10);
		end
	end
	if ( questDescription ) then
		getglobal(questLogName.."QuestDescription"):SetText(questDescription);
		QuestFrame_SetAsLastShown(getglobal(questLogName.."QuestDescription"));
	else 
		getglobal(questLogName.."QuestDescription"):SetText("");
	end
	local numRewards = 0; 
	if ( QuestData.rewards ) then numRewards = table.getn(QuestData.rewards); end
	local numChoices = 0;
	if ( QuestData.choices ) then numChoices = table.getn(QuestData.choices); end
	local money;

	if ( QuestData.rewardMoney ) then
		money = QuestData.rewardMoney;
	else 
		money = 0;
	end

	if ( (numRewards + numChoices + money) > 0 ) then
		getglobal(questLogName.."RewardTitleText"):Show();
		QuestFrame_SetAsLastShown(getglobal(questLogName.."RewardTitleText"));
	else
		getglobal(questLogName.."RewardTitleText"):Hide();
	end

	AuroraQuestLog_QuestItems_Update(questLogName, QuestData);
	local parent = getglobal(questLogName):GetParent();
	--getglobal(questLogName.."DetailScrollFrameScrollBar"):SetValue(0);
	getglobal(parent:GetName().."ScrollBar"):SetValue(0);
	--getglobal(questLogName.."DetailScrollFrame"):UpdateScrollChildRect();
	getglobal(questLogName):GetParent():UpdateScrollChildRect();
end

function AuroraQuestLog_QuestItems_Update(questLogName, QuestData)
	local numQuestRewards;
	local numQuestChoices;
	local numQuestSpellRewards = 0;
	local money;
	local spacerFrame;

	numQuestRewards = 0; 
	if ( QuestData.rewards ) then numQuestRewards = table.getn(QuestData.rewards); end
	numQuestChoices = 0;
	if ( QuestData.choices ) then numQuestChoices = table.getn(QuestData.choices); end

	if ( QuestData.spellReward ) then
		numQuestSpellRewards = 1;
	end
	money = 0;
	if ( QuestData.rewardMoney ) then money = QuestData.rewardMoney; end

	spacerFrame = QuestLogSpacerFrame;

	local totalRewards = numQuestRewards + numQuestChoices + numQuestSpellRewards;
	local questItemName = questLogName.."Item";
	local material = QuestFrame_GetMaterial();
	local  questItemReceiveText = getglobal(questLogName.."ItemReceiveText")
	if ( totalRewards == 0 and money == 0 ) then
		getglobal(questLogName.."RewardTitleText"):Hide();
	else
		getglobal(questLogName.."RewardTitleText"):Show();
		QuestFrame_SetTitleTextColor(getglobal(questLogName.."RewardTitleText"), material);
		QuestFrame_SetAsLastShown(getglobal(questLogName.."RewardTitleText"), spacerFrame);
	end
	if ( money == 0 ) then
		getglobal(questLogName.."MoneyFrame"):Hide();
	else
		getglobal(questLogName.."MoneyFrame"):Show();
		QuestFrame_SetAsLastShown(getglobal(questLogName.."MoneyFrame"), spacerFrame);
		MoneyFrame_Update(questLogName.."MoneyFrame", money);
	end
	
	for i=totalRewards + 1, MAX_NUM_ITEMS, 1 do
		getglobal(questItemName..i):Hide();
	end
	local questItem, name, texture, quality, isUsable, numItems = 1;
	if ( numQuestChoices > 0 ) then
		getglobal(questLogName.."ItemChooseText"):Show();
		QuestFrame_SetTextColor(getglobal(questLogName.."ItemChooseText"), material);
		QuestFrame_SetAsLastShown(getglobal(questLogName.."ItemChooseText"), spacerFrame);
		for i=1, numQuestChoices, 1 do	
			questItem = getglobal(questItemName..i);
			questItem.info = QuestData.choices[i].info;
			numItems = 1;

			name, texture, numItems, quality, isUsable = QuestData.choices[i].name, QuestData.choices[i].texture,  QuestData.choices[i].numItems,  QuestData.choices[i].quality,  QuestData.choices[i].isUsable;

			questItem:SetID(i)
			questItem:Show();

			-- For the tooltip
			questItem.rewardType = "item";

			QuestFrame_SetAsLastShown(questItem, spacerFrame);
			getglobal(questItemName..i.."Name"):SetText(name);
			SetItemButtonCount(questItem, numItems);
			SetItemButtonTexture(questItem, texture);
			if ( isUsable ) then
				SetItemButtonTextureVertexColor(questItem, 1.0, 1.0, 1.0);
				SetItemButtonNameFrameVertexColor(questItem, 1.0, 1.0, 1.0);
			else
				SetItemButtonTextureVertexColor(questItem, 0.9, 0, 0);
				SetItemButtonNameFrameVertexColor(questItem, 0.9, 0, 0);
			end
			if ( i > 1 ) then
				if ( mod(i,2) == 1 ) then
					questItem:SetPoint("TOPLEFT", questItemName..(i - 2), "BOTTOMLEFT", 0, -2);
				else
					questItem:SetPoint("TOPLEFT", questItemName..(i - 1), "TOPRIGHT", 1, 0);
				end
			else
				questItem:SetPoint("TOPLEFT", questLogName.."ItemChooseText", "BOTTOMLEFT", -3, -5);
			end
			
		end
	else
		getglobal(questLogName.."ItemChooseText"):Hide();
	end
	local rewardsCount = 0;
	if ( numQuestRewards > 0 or money > 0 or numQuestSpellRewards > 0) then
		QuestFrame_SetTextColor(questItemReceiveText, material);
		-- Anchor the reward text differently if there are choosable rewards
		if ( numQuestChoices > 0  ) then
			questItemReceiveText:SetText(TEXT(REWARD_ITEMS));
			local index = numQuestChoices;
			if ( mod(index, 2) == 0 ) then
				index = index - 1;
			end
			questItemReceiveText:SetPoint("TOPLEFT", questItemName..index, "BOTTOMLEFT", 3, -5);
		else 
			questItemReceiveText:SetText(TEXT(REWARD_ITEMS_ONLY));
			questItemReceiveText:SetPoint("TOPLEFT", questLogName.."RewardTitleText", "BOTTOMLEFT", 3, -5);
		end
		questItemReceiveText:Show();
		QuestFrame_SetAsLastShown(questItemReceiveText, spacerFrame);
		-- Setup mandatory rewards
		for i=1, numQuestRewards, 1 do
			questItem = getglobal(questItemName..(i + numQuestChoices));
			questItem.info = QuestData.rewards[i].info;
			numItems = 1;

			name, texture, numItems, quality, isUsable = QuestData.rewards[i].name, QuestData.rewards[i].texture,  QuestData.rewards[i].numItems,  QuestData.rewards[i].quality,  QuestData.rewards[i].isUsable;
			questItem:SetID(i)
			questItem:Show();
			-- For the tooltip
			questItem.rewardType = "item";
			QuestFrame_SetAsLastShown(questItem, spacerFrame);
			getglobal(questItemName..(i + numQuestChoices).."Name"):SetText(name);
			SetItemButtonCount(questItem, numItems);
			SetItemButtonTexture(questItem, texture);
			if ( isUsable ) then
				SetItemButtonTextureVertexColor(questItem, 1.0, 1.0, 1.0);
				SetItemButtonNameFrameVertexColor(questItem, 1.0, 1.0, 1.0);
			else
				SetItemButtonTextureVertexColor(questItem, 0.5, 0, 0);
				SetItemButtonNameFrameVertexColor(questItem, 1.0, 0, 0);
			end
			
			if ( i > 1 ) then
				if ( mod(i,2) == 1 ) then
					questItem:SetPoint("TOPLEFT", questItemName..((i + numQuestChoices) - 2), "BOTTOMLEFT", 0, -2);
				else
					questItem:SetPoint("TOPLEFT", questItemName..((i + numQuestChoices) - 1), "TOPRIGHT", 1, 0);
				end
			else
				questItem:SetPoint("TOPLEFT", questLogName.."ItemReceiveText", "BOTTOMLEFT", -3, -5);
			end
			rewardsCount = rewardsCount + 1;
		end
		-- Setup spell reward
		if ( numQuestSpellRewards > 0 ) then
			texture, name = QuestData.spellReward.texture, QuestData.spellReward.name;
			questItem = getglobal(questItemName..(rewardsCount + numQuestChoices + 1));
			questItem:Show();
			-- For the tooltip
			questItem.rewardType = "spell";
			SetItemButtonCount(questItem, 0);
			SetItemButtonTexture(questItem, texture);
			getglobal(questItemName..(rewardsCount + numQuestChoices + 1).."Name"):SetText(name);
			if ( rewardsCount > 0 ) then
				if ( mod(rewardsCount,2) == 0 ) then
					questItem:SetPoint("TOPLEFT", questItemName..((rewardsCount + numQuestChoices) - 1), "BOTTOMLEFT", 0, -2);
				else
					questItem:SetPoint("TOPLEFT", questItemName..((rewardsCount + numQuestChoices)), "TOPRIGHT", 1, 0);
				end
			else
				questItem:SetPoint("TOPLEFT", questLogName.."ItemReceiveText", "BOTTOMLEFT", -3, -5);
			end
		end
	else	
		questItemReceiveText:Hide();
	end
	

end


--[[
--
--	Functions beyond this point are tool function and not meant for general use.
--
--	-Alex
--
--]]

--[[ Validates a Frame ]]--
function AuroraQuestLog_CheckFrame(frame)
	if ( frame ) then 
		return true;	
	else
		--Sea.io.error("Invalid frame passed to AuroraQuestLog_CheckFrame");
		return nil;
	end
end

--[[ Validates a Quest Entry ]]--
function AuroraQuestLog_CheckTable(QuestData)
	if ( not QuestData ) then 
		--Sea.io.error("QuestInfo sent to AuroraQuestLog is nil! Name:", this:GetName() );
		return false;
	end

	if ( type(QuestData) ~= "table" ) then 
		--Sea.io.error("QuestInfo sent to AuroraQuestLog is not a table! Name:", this:GetName() );
		return false;
	end

	for k,v in QuestData do 
		--Something
		if ( type(k) ~= "number" ) then 
			--Sea.io.error("Invalid index in data: ",this:GetName() );
			return false;
		end
	
		if ( AuroraTree_CheckItem(v) == false ) then
			--Sea.io.error("Invalid item: ",k);
			return false;
		end
	end

	return true;
end

--[[ Validates a Table Item ]]--
function AuroraTree_CheckItem(item)
	if ( not item.title and not item.right ) then 
		--Sea.io.error("No title or subtext provided: ",this:GetName() );
		return false;
	end

	-- Now subfunctioned, this may never be used.
	if ( not item.titleColor ) then 
		item.titleColor = AURORATREE_COLOR_STRING;
	end
		
	if ( not item.rightColor ) then 
		item.rightColor = AURORATREE_COLOR_STRING;
	end

	if ( item.children ) then 
		return AuroraTree_CheckTable(item.children);
	end
end	


--
--	Sets the location of the Tooltip
--
function AuroraQuestLog_SetTooltip(frame, tooltipText) 
	if ( frame.tooltip ) then 
		local tooltip = getglobal(frame.tooltip);
		if ( tooltipText ) then 	
			-- Set the location of the tooltip
			if ( frame.tooltipPlacement == "cursor" ) then
				tooltip:SetOwner(UIParent,"ANCHOR_CURSOR");	
			elseif ( frame.tooltipPlacement == "button" ) then
				tooltip:SetOwner(this,frame.tooltipAnchor);	
			else
				tooltip:SetOwner(frame,frame.tooltipAnchor);				
			end

			tooltip:SetText(tooltipText, 0.8, 0.8, 1.0);
			tooltip:Show();		
		end
	end
end

--
--	Hides the location of the Tooltip
--
function AuroraQuestLog_HideTooltip(frame)
	if ( frame.tooltip ) then 		
		getglobal(frame.tooltip):Hide();
		getglobal(frame.tooltip):SetOwner(UIParent, "ANCHOR_RIGHT");
	end
end

--[[ Frame Event Handlers ]]--
function AuroraQuestLog_Frame_OnLoad()
	this.onClick = AuroraQuestLog_Frame_OnClick;
	this.onShow = AuroraQuestLog_Frame_OnShow;
	this.onEvent = AuroraQuestLog_Frame_OnEvent;

	-- Use any tooltip you'd like. I use my own
	this.tooltip = "AuroraTooltip";
	
	--
	-- Can be "button", "frame", "cursor"
	-- 
	this.tooltipPlacement = "cursor"; 	
	this.tooltipAnchor = "ANCHOR_RIGHT"; -- Can be any valid tooltip anchor
	this.activeTable = {};

end

function AuroraQuestLog_Frame_OnShow()
end

function AuroraQuestLog_Frame_OnClick()
end

function AuroraQuestLog_Frame_OnEvent()
end

--[[ Item Texture Handlers ]]--
local function AuroraQuestLog_Item_OnEnter()
	if ( this:GetAlpha() > 0 ) then
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		if ( this.rewardType == "item" ) then
			GameTooltip:SetHyperlink(this.info.link);
		elseif ( this.rewardType == "spell" ) then
			GameTooltip:SetText(this.info.name);
		end
	end
end

local function AuroraQuestLog_Item_OnLeave()
	GameTooltip:Hide();
	ResetCursor()
end

local function AuroraQuestLog_Item_OnClick()
	local name, link, rarity, minLevel, rewardType, type, stackCount, equipLoc, texture = GetItemInfo( this.info.link );

	if ( IsControlKeyDown() and this.rewardType == "item" ) then
		DressUpItemLink(this.info.link);
	elseif ( IsShiftKeyDown() and this.rewardType == "item" and ChatFrameEditBox:IsVisible() ) then
		ChatFrameEditBox:Insert("|c"..this.info.color.."|H"..this.info.link.."|h"..this.info.linkname.."|h|r");
	end

end

local function AuroraQuestLog_Item_OnUpdate()
	if ( IsControlKeyDown() and this.rewardType == "item" ) then
		ShowInspectCursor()
	else
		ResetCursor()
	end
end

function AuroraQuestLog_Item_OnLoad()
	this.onEnter = AuroraQuestLog_Item_OnEnter;
	this.onLeave = AuroraQuestLog_Item_OnLeave;
	this.onClick = AuroraQuestLog_Item_OnClick;
	this.onUpdate = AuroraQuestLog_Item_OnUpdate;
	this:Hide();
end

--[[ RewardItem Texture Handlers ]]--
--
-- Tooltip setup, Inspect Cursor
--
local function AuroraQuestLog_RewardItem_OnEnter()
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	if ( this.rewardType == "item" ) then
		GameTooltip:SetHyperlink(this.info.link);
	elseif ( this.rewardType == "spell" ) then
		GameTooltip:SetText(this.info.name);
	end
end

--
-- Close tooltip and reset cursor to game default
--
local function AuroraQuestLog_RewardItem_OnLeave()
	GameTooltip:Hide();
	ResetCursor()
end

--
-- DressingRoom, Selection and paste to chat support
--
local function AuroraQuestLog_RewardItem_OnClick()
	if ( IsControlKeyDown() and this.rewardType == "item" ) then
		DressUpItemLink(this.info.link);
	elseif ( IsShiftKeyDown() and this.rewardType == "item" and ChatFrameEditBox:IsVisible() ) then
		ChatFrameEditBox:Insert("|c"..this.info.color.."|H"..this.info.link.."|h"..this.info.linkname.."|h|r");
	end

	if ( this.type == "choice" ) then
		QuestRewardItemHighlight:SetPoint("TOPLEFT", this:GetName(), "TOPLEFT", -8, 7);
		QuestRewardItemHighlight:Show();
		QuestFrameRewardPanel.itemChoice = this:GetID();
	end
end

--
-- Inspect Cursor support
--
local function AuroraQuestLog_RewardItem_OnUpdate()
	if ( IsControlKeyDown() and this.rewardType == "item" ) then
		ShowInspectCursor()
	else
		ResetCursor()
	end
end

--
-- Setup of on handlers
--
function AuroraQuestLog_RewardItem_OnLoad()
	this.onEnter = AuroraQuestLog_RewardItem_OnEnter;
	this.onLeave = AuroraQuestLog_RewardItem_OnLeave;
	this.onClick = AuroraQuestLog_RewardItem_OnClick;
	this.onUpdate = AuroraQuestLog_RewardItem_OnUpdate;
end

