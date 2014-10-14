function NoJoinSpam_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("CHAT_MSG_CHANNEL_JOIN");
	this:RegisterEvent("CHAT_MSG_CHANNEL_LEAVE");
	this:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE_USER");
end

local ChatFrame_OnEvent_Old;
function NoJoinSpam_OnEvent()
	if strsub(event, 1, 16) == "VARIABLES_LOADED" then
		if ChatFrame_OnEvent_Old == nil then
			ChatFrame_OnEvent_Old = ChatFrame_OnEvent;
			ChatFrame_OnEvent = ChatFrame_OnEvent_New;
		end
	end
end

function ChatFrame_OnEvent_New()
	if event == "CHAT_MSG_CHANNEL_JOIN" or event == "CHAT_MSG_CHANNEL_LEAVE" or arg1 == "OWNER_CHANGED" then
	else
		ChatFrame_OnEvent_Old(event);
	end
end

local f=CreateFrame("frame");
f:RegisterEvent("VARIABLES_LOADED");
f:RegisterEvent("CHAT_MSG_CHANNEL_JOIN");
f:RegisterEvent("CHAT_MSG_CHANNEL_LEAVE");
f:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE_USER");

f:SetScript("OnEvent",NoJoinSpam_OnEvent)
