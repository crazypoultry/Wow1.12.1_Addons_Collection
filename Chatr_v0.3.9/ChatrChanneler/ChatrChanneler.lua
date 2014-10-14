
function ChatrChanneler_Init()
	Chatr_CallMe("ShowSettings",ChatrChanneler_ShowSettings);
	Chatr_CallMe("SettingsLoaded",ChatrChanneler_PostInit);
	this:RegisterEvent("CHAT_MSG_CHANNEL");
	this:RegisterEvent("CHAT_MSG_PARTY");
	this:RegisterEvent("CHAT_MSG_RAID");
	this:RegisterEvent("CHAT_MSG_GUILD");
	this:RegisterEvent("CHAT_MSG_OFFICER");
	SLASH_CHATRCHANNELER1="/chch";
	SlashCmdList["CHATRCHANNELER"]=ChatrChanneler_Slash;
end

function ChatrChanneler_Slash(msg)
	if strlen(msg)>0 then
		Chatr_OpenFor("#"..gsub(strlower(msg),"#",""));
	end
end

function ChatrChanneler_PostInit()
	Chatr_Print(GetAddOnMetadata("ChatrChanneler","Title").." loaded.");
	ChatrChannelerOptionsTitle:SetText(GetAddOnMetadata("ChatrChanneler","Title"));	
	Chatr_AddPlugin("ChatrChanneler");
	Chatr_Senders["#"]=ChatrChanneler_Send;
end

function ChatrChanneler_ShowSettings(tab)
end

function ChatrChanneler_Recv(cn)
	local cp=Chatr_FindByName(cn);
	if cp==-1 then return; end
	name,msg=Chatr_CheckFilter(Chatr_InboundFilters,arg2,arg1);
	if name then
		if name==UnitName("player") then
			Chatr_AddWhisperTo(name,msg,cp);
		else
			Chatr_AddWhisper(name,msg,arg6,cp);
			if ChatrDock.minimized==1 and getglobal("Chatr"..cp).docked==1 then
				ChatrDockText:SetText("New message: "..name);
			end
		end
	end
end

function ChatrChanneler_Send(chatr)
	local cid,cname;
	if chatr.target=="#party" then
		SendChatMessage(chatr.editBox:GetText(), "PARTY", nil);
	elseif chatr.target=="#raid" then
		SendChatMessage(chatr.editBox:GetText(), "RAID", nil);
	elseif chatr.target=="#guild" then
		SendChatMessage(chatr.editBox:GetText(), "GUILD", nil);
	elseif chatr.target=="#officer" then
		SendChatMessage(chatr.editBox:GetText(), "OFFICER", nil);
	else
		cid,cname=GetChannelName(strsub(chatr.target,2));
		SendChatMessage(chatr.editBox:GetText(), "CHANNEL", nil, cid);
	end
end

function ChatrChanneler_Event()
	if event=="CHAT_MSG_CHANNEL" then
		ChatrChanneler_Recv("#"..strlower(arg9));
	elseif event=="CHAT_MSG_PARTY" then
		ChatrChanneler_Recv("#party");
	elseif event=="CHAT_MSG_RAID" then
		ChatrChanneler_Recv("#raid");
	elseif event=="CHAT_MSG_GUILD" then
		ChatrChanneler_Recv("#guild");
	elseif event=="CHAT_MSG_OFFICER" then
		ChatrChanneler_Recv("#officer");
	end
	
end