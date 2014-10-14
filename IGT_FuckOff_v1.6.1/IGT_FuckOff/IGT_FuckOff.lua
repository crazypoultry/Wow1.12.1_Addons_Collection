-- Locals Defined --
function FuckOff_OnLoad()
    -- Loaded Warning --
    DEFAULT_CHAT_FRAME:AddMessage("|cFFAAAAFF»Ignasia«|r |cFFDDbb00Fuck Off|r - Loaded!");
    -- Slash Command Config --
    SLASH_FKO1 = "/igtfko";
    SLASH_FKO2 = "/igtfo";
    SLASH_FKO3 = "/igtfuckoff";
    SlashCmdList["FKO"] = FuckOff_Slash;
    -- Hook Incoming Whispers --
    if(event == "CHAT_MSG_WHISPER") then
	    FuckOffHook_OnEvent = ChatFrame_OnEvent;
	    ChatFrame_OnEvent = FuckOff_ChatFrame_OnEvent;
    end 
        this:RegisterEvent("CHAT_MSG_WHISPER");    
end

function FuckOff_Slash()
    -- Advertive Configuration --
    DEFAULT_CHAT_FRAME:AddMessage("|cFF7777FF»Ignasia«|r |cFFDDbb00Fuck Off|r - Configuration!");
    -- Open Config Window --
    IGT_FuckOff:Show();
end

function FuckOff_OnClose()
    -- Save Variables --
    local fo_editBox;
    fo_editBox = getglobal("IGT_FuckOff".."igtfo_string1_edit")
    igtfo_string1 = fo_editBox:GetText()
    
    fo_editBox = getglobal("IGT_FuckOff".."igtfo_whisper1_edit")
    igtfo_whisper1 = fo_editBox:GetText()
    -- Hide Config Frame --
    IGT_FuckOff:Hide();
    -- Anounce Saving --
    DEFAULT_CHAT_FRAME:AddMessage("|cFFAAAAFF»Ignasia«|r |cFFDDbb00Fuck Off|r - Configuration Saved!");
    
end

function FuckOff_OnEvent(event)
    -- Check for nil values and replace if found --
    if(event == "VARIABLES_LOADED") then
        if(igtfo_string1 == nil) then
            igtfo_string1 = "wanna join"
        end
        
        if(igtfo_whisper1 == nil) then
            igtfo_whisper1 = "No! Thx anyways and Good Luck!"
        end
        -- Set the text in the edit Boxes from variables --
        local fo_editBox;
        fo_editBox = getglobal("IGT_FuckOff".."igtfo_string1_edit")
        fo_editBox:SetText(igtfo_string1)
    
        fo_editBox = getglobal("IGT_FuckOff".."igtfo_whisper1_edit")
        fo_editBox:SetText(igtfo_whisper1)
    end
    -- Auto-Reply to Matching Whispers --
    if ((event == "CHAT_MSG_WHISPER")and(string.find(arg1, igtfo_string1)))then
        SendChatMessage(igtfo_whisper1, "WHISPER", "Common", arg2);
    end
    
end