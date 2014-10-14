--[[
-- Chatmats
--]]

local tradeBtnName;
local craftBtnName;
local chatmats_getProductText;

--====================================================================================
function chatmats_OnLoad()
    tradeBtnName = "TradeSkillSkillIcon";
    craftBtnName = "CraftIcon";

    this:RegisterEvent("TRADE_SKILL_SHOW");
    this:RegisterEvent("CRAFT_SHOW");
end

--====================================================================================
function chatmats_OnEvent(event)
    -- for myAddOns addon
    if(event == "ADDON_LOADED" and arg1 == "ChatMats") then
        if(myAddOnsFrame_Register) then
            myAddOnsFrame_Register(ChatMatsDetails);
        end;
    end;

    if(event == "TRADE_SKILL_SHOW") then
        chatmats_HookTradeSkillOnClick();
    elseif(event == "CRAFT_SHOW") then
        chatmats_HookCraftOnClick();
    end;

end

--====================================================================================
function chatmats_DoOnClickTrade()
    local id = TradeSkillFrame.selectedSkill;
    local name;
    if ( IsAltKeyDown() and ChatFrameEditBox:IsVisible() ) then
        chatmats_PrintReagents(this:GetName(), id);
    elseif ( IsShiftKeyDown() and ChatFrameEditBox:IsVisible() ) then
        ChatFrameEditBox:Insert(GetTradeSkillItemLink(id));
    elseif (IsControlKeyDown()) then
        DressUpItemLink(GetTradeSkillItemLink(id));
    end;
end

--====================================================================================
function chatmats_DoOnClickCraft()

    if ( IsAltKeyDown() and ChatFrameEditBox:IsVisible()) then
        chatmats_PrintReagents(this:GetName(), GetCraftSelectionIndex());
    elseif ( IsShiftKeyDown() and ChatFrameEditBox:IsVisible() ) then
        local link = GetCraftItemLink(GetCraftSelectionIndex())
        if ( link ) then
            ChatFrameEditBox:Insert(link);
        end
    end
end

--====================================================================================
-- send the chat msgs
function chatmats_SendChatMsg(skillId, chatMsgTable)

	local lastTell = ChatFrameEditBox.channelTarget;
	local channelType = ChatFrameEditBox.chatType;

	if(channelType == "REPLY") then
		lastTell = ChatEdit_GetLastTellTarget(ChatFrameEditBox);
	elseif(channelType == "WHISPER") then
		lastTell = ChatFrameEditBox.tellTarget;
	end;

    chatmats_setProductFunction(this:GetName());

    local product = chatmats_getProductText(skillId);

	-- print the product here

    SendChatMessage(product .. " requires:", channelType, this.language ,lastTell);

	for i=1, table.getn(chatMsgTable), 1 do
		-- maybe add a cmd line arg for preferred lang, but thats overkill.
		SendChatMessage(chatMsgTable[i], channelType, this.language ,lastTell);
	end;
end

--====================================================================================
function chatmats_setProductFunction(btnName)
    if(btnName == tradeBtnName) then
        chatmats_getProductText = GetTradeSkillItemLink;
    else
        chatmats_getProductText = chatmats_GetCraftProduct;
    end;
end

--====================================================================================
-- Create a table with each formatted reagent string
-- Allows more control for managing reagents
function chatmats_CreateReagentTable(btnName, skillId)
	local reagentTable = {};
	local numReagents;
	

	-- needed to switch between enchanting and all other trade skills
	if(btnName == tradeBtnName) then
		numReagents = GetTradeSkillNumReagents(skillId);
	else
		numReagents = GetCraftNumReagents(skillId);
	end;
	
	for i=1, numReagents, 1 do
		reagentTable[i] = chatmats_FormatReagent(btnName, skillId, i);
	end
		
	reagentTable.setn = numReagents;
	return reagentTable;
end

--====================================================================================
-- convert a table of formatted reagents into a table where
-- each entry is a chat message of 255 chars or less
function chatmats_MungeReagentTableIntoChatMsgTable(reagentTable)
	local chatMsgTable = {};
	local msg = "";
	local msgCount = 1;

	for i=1, table.getn(reagentTable), 1 do
		local msgLength = string.len(msg) + string.len(reagentTable[i]);

		if(msgLength < 255) then
			msg = msg..reagentTable[i].." ";
		else
			chatMsgTable[msgCount] = msg;
			msgCount = msgCount + 1;
			msg = reagentTable[i].." ";
		end;

	end;
	-- add in last part of msg
	chatMsgTable[msgCount] = msg;
	chatMsgTable.setn = msgCount;
	return chatMsgTable;
end

--====================================================================================
-- Format a single reagent
function chatmats_FormatReagent(btnName, skillId, reagentId)
	-- only using name and count for now
	local output = "";
	local reagentName, rTxtr, reagentCount, prCnt;
	local reagentMsg = "";

	-- needed to switch between enchanting and all other trade skills
	if(btnName == tradeBtnName) then
		reagentName, rTxtr, reagentCount, prCnt = GetTradeSkillReagentInfo(skillId, reagentId);
		reagentMsg = GetTradeSkillReagentItemLink(skillId, reagentId).."x"..reagentCount;

	else
		reagentName, rTxtr, reagentCount, prCnt = GetCraftReagentInfo(skillId, reagentId)
		reagentMsg = GetCraftReagentItemLink(skillId, reagentId).."x"..reagentCount;
	end;

	return reagentMsg;
end

--====================================================================================
function chatmats_GetCraftProduct(skillId)
    -- craft item is a linkable item
    local product = GetCraftItemLink(skillId);
    if(product) then
        return product;
    else
        -- craft item has no link
        product, craftSubSpellName, craftType, numAvailable, isExpanded = GetCraftInfo(skillId);
    end;

    return product;
end

--====================================================================================
function chatmats_HookTradeSkillOnClick()
    local chatMatsTradeSkillBtn = getglobal(tradeBtnName);
    if(chatMatsTradeSkillBtn) then
        chatMatsTradeSkillBtn:SetScript("OnClick", chatmats_DoOnClickTrade);
    end;
end

--====================================================================================
function chatmats_HookCraftOnClick()
    local chatMatsCraftSkillBtn = getglobal(craftBtnName);
    if(chatMatsCraftSkillBtn) then
        chatMatsCraftSkillBtn:SetScript("OnClick", chatmats_DoOnClickCraft);
    end;
end

--====================================================================================
function chatmats_PrintReagents(name, skill)
	local reagentTable = {};
	local chatTable = {};

	reagentTable 	= chatmats_CreateReagentTable(name, skill);
	chatTable 		= chatmats_MungeReagentTableIntoChatMsgTable(reagentTable);
	chatmats_SendChatMsg(skill, chatTable);
end
