--[[
    MatLink - A Tradeskill Material Linking Addon
    Author: Rylas of Bonechewer
--]]

-- Version string

ML_VERSION = "0.5";

-- Is Advanced Trade Skill Window loaded?

ATSW_LOADED = IsAddOnLoaded("AdvancedTradeSkillWindow");

-- Local variables

local btn_Trade;
local btn_Craft;
local ml_ProductText;

-- Loading procedure

function ml_OnLoad()
    if (ATSW_LOADED) then
        btn_Trade = "ATSWSkillIcon";
        btn_Craft = "ATSWSkillIcon";
    else
        btn_Trade = "TradeSkillSkillIcon";
        btn_Craft = "CraftIcon";
    end;
    this:RegisterEvent("TRADE_SKILL_SHOW");
    this:RegisterEvent("CRAFT_SHOW");
    if (DEFAULT_CHAT_FRAME) then
        DEFAULT_CHAT_FRAME:AddMessage("MatLink " .. ML_VERSION .. " successfully loaded!");
    end;
end

-- Event handling

function ml_OnEvent(event)
    if (event == "TRADE_SKILL_SHOW") then
        ml_HookTrade();
    elseif (event == "CRAFT_SHOW") then
        ml_HookCraft();
    end;
end

-- Tradeskill window click handling

function ml_ClickTrade()
    local id = TradeSkillFrame.selectedSkill;
    local name;
    if (ATSW_LOADED) then
        if (IsAltKeyDown() and ChatFrameEditBox:IsVisible()) then
            ml_PrintReagents(this:GetName(), id);
        elseif (IsShiftKeyDown() and ChatFrameEditBox:IsVisible()) then
            ChatFrameEditBox:Insert(ATSW_GetTradeSkillItemLink(id));
        elseif (IsControlKeyDown()) then
            DressUpItemLink(ATSW_GetTradeSkillItemLink(id));
        end;
    else
        if (IsAltKeyDown() and ChatFrameEditBox:IsVisible()) then
            ml_PrintReagents(this:GetName(), id);
        elseif (IsShiftKeyDown() and ChatFrameEditBox:IsVisible()) then
            ChatFrameEditBox:Insert(GetTradeSkillItemLink(id));
        elseif (IsControlKeyDown()) then
            DressUpItemLink(GetTradeSkillItemLink(id));
        end;
    end;
end

-- Crafting window click handling

function ml_ClickCraft()
    if (IsAltKeyDown() and ChatFrameEditBox:IsVisible()) then
        ml_PrintReagents(this:GetName(), GetCraftSelectionIndex());
    elseif (IsShiftKeyDown() and ChatFrameEditBox:IsVisible()) then
        local link = GetCraftItemLink(GetCraftSelectionIndex())
        if (link) then
            ChatFrameEditBox.Insert(link);
        end;
    end;
end

-- Send the messages through the chat window

function ml_SendChat(skill_Id, chat_Table)
    local last_Tell = ChatFrameEditBox.channelTarget;
    local chan_Type = ChatFrameEditBox.chatType;
    if (chan_Type == "REPLY") then
        last_Tell = ChatEdit_GetLastTellTarget(ChatFrameEditBox);
    elseif (chan_Type == "WHISPER") then
        last_Tell = ChatFrameEditBox.tellTarget;
    end;
    ml_ProdFunction(this:GetName());
    local product = ml_ProductText(skill_Id);
    SendChatMessage("Materials needed for " .. product .. " are:", chan_Type, this.language, last_Tell);
    for i = 1, table.getn(chat_Table), 1 do
        SendChatMessage(chat_Table[i], chan_Type, this.language, last_Tell);
    end;
end

function ml_ProdFunction(btn_Name)
    if (btn_Name == btn_Trade) then
        if (ATSW_LOADED) then
            ml_ProductText = ATSW_GetTradeSkillItemLink;
        else
            ml_ProductText = GetTradeSkillItemLink;
        end;
    else
        ml_ProductText = ml_CraftProduct;
    end;
end

-- Function to store formatted reagents in a table

function ml_ReagentTable(btn_Name, skill_Id)
    local r_Table = {};
    local n_Reagent;
    if (btn_Name == btn_Trade) then
        if (ATSW_LOADED) then
            n_Reagent = ATSW_GetTradeSkillNumReagents(skill_Id);
        else
            n_Reagent = GetTradeSkillNumReagents(skill_Id);
        end;
    else
        if (ATSW_LOADED) then
            n_Reagent = ATSW_GetCraftNumReagents(skill_Id);
        else
            n_Reagent = GetCraftNumReagents(skill_Id);
        end;
    end;
    for i = 1, n_Reagent, 1 do
        r_Table[i] = ml_ReagentFormat(btn_Name, skill_Id, i);
    end;
    r_Table.setn = n_Reagent;
    return r_Table;
end

-- Converts reagent-formatted tables to strings that are 255 or less characters

function ml_MungeChat(r_Table)
    local msg = "";
    local msg_Table = {};
    local msg_Count = 1;
    for i = 1, table.getn(r_Table), 1 do
        local msg_Length = string.len(msg) + string.len(r_Table[i]);
        if (msg_Length < 255) then
            msg = msg .. r_Table[i] .. " ";
        else
            msg_Table[msg_Count] = msg;
            msg_Count = msg_Count + 1;
            msg = r_Table[i] .. " ";
        end;
    end;
    msg_Table[msg_Count] = msg;
    msg_Table.setn = msg_Count;
    return msg_Table;
end

-- Format one single reagent and how many are required

function ml_ReagentFormat(btn_Name, skill_Id, reag_Id)
    local out = "";
    local reag_Name, r_Txtr, reag_Count, pr_Count;
    local reag_Msg = "";
    if (btn_Name == btn_Trade) then
        if (ATSW_LOADED) then
            reag_Name, r_Txtr, reag_Count, pr_Count = ATSW_GetTradeSkillReagentInfo(skill_Id, reag_Id);
            reag_Msg = ATSW_GetTradeSkillReagentItemLink(skill_Id, reag_Id) .. "x" .. reag_Count;
        else
            reag_Name, r_Txtr, reag_Count, pr_Count = GetTradeSkillReagentInfo(skill_Id, reag_Id);
            reag_Msg = GetTradeSkillReagentItemLink(skill_Id, reag_Id) .. "x" .. reag_Count;
        end;
    else
        if (ATSW_LOADED) then
            reag_Name, r_Txtr, reag_Count, pr_Count = ATSW_GetCraftReagentInfo(skill_Id, reag_Id);
            reag_Msg = ATSW_GetCraftReagentItemLink(skill_Id, reag_Id) .. "x" .. reag_Count;
        else
            reag_Name, r_Txtr, reag_Count, pr_Count = GetCraftReagentInfo(skill_Id, reag_Id);
            reag_Msg = GetCraftReagentItemLink(skill_Id, reag_Id) .. "x" .. reag_Count;
        end;
    end;
    return reag_Msg;
end

-- Retrieves information about given skill

function ml_GetProduct(skill_Id)
    local product = GetCraftItemLink(skill_Id);
    if (product) then
        return product;
    else
        product, craft_SubSpell, craft_Type, num_Avail, is_Exp = GetCraftInfo(skill_Id);
    end;
    return product;
end;

-- Hook onto tradeskill window when opened

function ml_HookTrade()
    local b_Trade = getglobal(btn_Trade);
    if (b_Trade) then
        b_Trade:SetScript("OnClick", ml_ClickTrade);
    end;
end

-- Hook onto crafting window when opened

function ml_HookCraft()
    local b_Craft = getglobal(btn_Craft);
    if (b_Craft) then
        b_Craft:SetScript("OnClick", ml_ClickCraft);
    end;
end

-- Prints reagents to the user's chat box

function ml_PrintReagents(name, skill)
    local r_Table = {};
    local c_Table = {};
    r_Table = ml_ReagentTable(name, skill);
    c_Table = ml_MungeChat(r_Table);
    ml_SendChat(skill, c_Table);
end
