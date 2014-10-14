ccopts = {};
ccchat = {};
cctchat= {};

function ChatCopy_Command(cmd)
	-- local lcmd=strlower(cmd);
	if (cmd == "") then
		ChatCopy_Options:Hide();
		if (ChatCopy_Core:IsVisible()) then
			ChatCopy_Core:Hide();
		else
			ChatCopy_Core:Show();
			ChatCopyInitText();
		end
	end
end

function ChatCopy_AddMessage(message)
	tinsert(ccchat,1,message);
	if (ccopts.memorylimit>0 and getn(ccchat)>ccopts.memorylimit) then
		tremove(ccchat, ccopts.memorylimit+1);
	end
end

function CCAdd(message)
	ChatCopy_AddMessage(message)
end

function ChatCopy_OnEvent(event, arg1)
	if (event == "PLAYER_ENTERING_WORLD") then
		ChatCopy_Core:RegisterForDrag("LeftButton");
		ChatCopy_Title:SetText("ChatCopy  - by bitbiter - [Shift]+[Click] to move");
		ChatCopy_OptionsTitle:SetText("Options");
		ChatCopy_OpenerTitle:SetText("...");
		SlashCmdList["ChatCopy"] = ChatCopy_Command;
		SLASH_ChatCopy1 = "/chatcopy";
		SLASH_ChatCopy2 = "/cc";
		if (ccopts.memorylimit == nil) then
			ccopts.showsay     =1;
			ccopts.showsay     =1;
			ccopts.showyell    =1;
			ccopts.showemote   =1;
			ccopts.showwhisper =1;
			ccopts.showguild   =1;
			ccopts.showparty   =1;
			ccopts.showraid    =1;
			ccopts.showsystem  =1;
			ccopts.showother   =1;
			ccopts.memorylimit =50;
			ccopts.lines       =10;
			ccopts.cpos        =0;
		end
		if (ccopts.fixchans == nil) then
			ccopts.fixchans    =0;
		end
		CCSayCheck:SetChecked(ccopts.showsay);
		CCYellCheck:SetChecked(ccopts.showyell);
		CCEmoteCheck:SetChecked(ccopts.showemote);
		CCWhisperCheck:SetChecked(ccopts.showwhisper);
		CCGuildCheck:SetChecked(ccopts.showguild);
		CCPartyCheck:SetChecked(ccopts.showparty);
		CCRaidCheck:SetChecked(ccopts.showraid);
		CCSystemCheck:SetChecked(ccopts.showsystem);
		CCOtherCheck:SetChecked(ccopts.showother);
		CCFixChansCheck:SetChecked(ccopts.fixchans);
		ChatCopy_OptionsLines:SetText(tostring(ccopts.lines));
		ChatCopyMemoryLabel();
		local font,size,flags = ChatFrame1:GetFont();
		ChatCopy_Edit:SetFont(font,size,flags);
		ChatCopy_Core:SetHeight(ChatCopy_Core:GetTop()-ChatCopy_Edit:GetTop()+(ccopts.lines*size)+13);
	elseif (event == "PLAYER_LEAVING_WORLD") then
		ccopts.showsay = CCSayCheck:GetChecked();
		ccopts.showyell = CCYellCheck:GetChecked();
		ccopts.showemote = CCEmoteCheck:GetChecked();
		ccopts.showwhisper = CCWhisperCheck:GetChecked();
		ccopts.showguild = CCGuildCheck:GetChecked();
		ccopts.showparty = CCPartyCheck:GetChecked();
		ccopts.showraid = CCRaidCheck:GetChecked();
		ccopts.showsystem = CCSystemCheck:GetChecked();
		ccopts.showother = CCOtherCheck:GetChecked();
		ccopts.fixchans = CCFixChansCheck:GetChecked();
	elseif (event == "CHAT_MSG_AFK") then
		CCSystem(arg2,arg1);
	elseif (event == "CHAT_MSG_CHANNEL") then
		CCOther(arg2,arg1,arg4);
	elseif (event == "CHAT_MSG_DND") then
		CCSystem(arg2,arg1);
	elseif (event == "CHAT_MSG_EMOTE") then
		CCCustomEmote(arg2,arg1);
	elseif (event == "CHAT_MSG_GUILD") then
		CCGuild(arg2,arg1);
	elseif (event == "CHAT_MSG_IGNORED") then
		CCSystem(arg2,arg1);
	elseif (event == "CHAT_MSG_OFFICER") then
		CCGuildExt(arg2,arg1);
	elseif (event == "CHAT_MSG_PARTY") then
		CCParty(arg2,arg1);
	elseif (event == "CHAT_MSG_RAID") then
		CCRaid(arg2,arg1);
	elseif (event == "CHAT_MSG_RAID_LEADER") then
		CCRaid(arg2,arg1);
	elseif (event == "CHAT_MSG_RAID_WARNING") then
		CCRaidWarning(arg2,arg1);
	elseif (event == "CHAT_MSG_SAY") then
		CCSay(arg2,arg1);
	elseif (event == "CHAT_MSG_TEXT_EMOTE") then
		CCEmote(arg2,arg1);
	elseif (event == "CHAT_MSG_WHISPER") then
		CCWhisper(arg2,arg1);
	elseif (event == "CHAT_MSG_WHISPER_INFORM") then
		CCWhisperTo(arg2,arg1);
	elseif (event == "CHAT_MSG_YELL") then
		CCYell(arg2,arg1);
	end
end

function CCSay(from,message)
	CCAdd("[Say]["..from.."]: "..message);
end

function CCYell(from,message)
	CCAdd("[Yell]["..from.."]: "..message);
end

function CCEmote(from,message)
	CCAdd("[Emote]: "..message);
end

function CCCustomEmote(from,message)
	CCAdd("[Emote]: "..from.." "..message);
end

function CCGuild(from,message)
	CCAdd("[Guild]["..from.."]: "..message);
end

function CCGuildExt(from,message)
	CCAdd("[Officer]["..from.."]: "..message);
end

function CCWhisper(from,message)
	CCAdd("[Whisper]["..from.."]: "..message);
end

function CCWhisperTo(from,message)
	CCAdd("[Whisper]To ["..from.."]: "..message);
end

function CCParty(from,message)
	CCAdd("[Party]["..from.."]: "..message);
end

function CCRaid(from,message)
	CCAdd("[Raid]["..from.."]: "..message);
end

function CCRaidWarning(from,message)
	CCAdd("[Raid Warning]["..from.."]: "..message);
end

function CCSystem(from,message)
	CCAdd("[System]["..from.."]: "..message);
end

function CCOther(from,message,channel)
	if (CCFixChansCheck:GetChecked()~=nil) then
		if (strfind(channel,"General")~=nil) then
			CCAdd("["..channel.."]["..from.."]: "..message);
		elseif (strfind(channel,"Trade")~=nil) then
			CCAdd("["..channel.."]["..from.."]: "..message);
		elseif (strfind(channel,"LookingForGroup")~=nil) then
			CCAdd("["..channel.."]["..from.."]: "..message);
		elseif (strfind(channel,"LocalDefense")~=nil) then
			CCAdd("["..channel.."]["..from.."]: "..message);
		end
	else
		CCAdd("["..channel.."]["..from.."]: "..message);
	end
end

function CCTest(event,arg1,arg2,arg3,arg4,arg5)
	CCAdd(event..": "..tostring(arg1)..", "..tostring(arg2)..", "..tostring(arg3)..", "..tostring(arg4)..", "..tostring(arg5));
end

function ChatCopyTextUpdate()
	local i=1;
	local TextShown="";
	local AddMsg=1;
	local j=0;
	for i=1,getn(cctchat),1 do
		AddMsg=0;
		if (cctchat[i]~=nil) then
			if (strsub(cctchat[i],1,5) == "[Say]" and CCSayCheck:GetChecked()~=nil) then
				AddMsg=1;
			elseif (strsub(cctchat[i],1,6) == "[Yell]" and CCYellCheck:GetChecked()~=nil) then
				AddMsg=1;
			elseif (strsub(cctchat[i],1,7) == "[Emote]" and CCEmoteCheck:GetChecked()~=nil) then
				AddMsg=1;
			elseif (strsub(cctchat[i],1,9) == "[Whisper]" and CCWhisperCheck:GetChecked()~=nil) then
				AddMsg=1;
			elseif (strsub(cctchat[i],1,7) == "[Guild]" and CCGuildCheck:GetChecked()~=nil) then
				AddMsg=1;
			elseif (strsub(cctchat[i],1,9) == "[Officer]" and CCGuildCheck:GetChecked()~=nil) then
				AddMsg=1;
			elseif (strsub(cctchat[i],1,7) == "[Party]" and CCPartyCheck:GetChecked()~=nil) then
				AddMsg=1;
			elseif (strsub(cctchat[i],1,6) == "[Raid]" and CCRaidCheck:GetChecked()~=nil) then
				AddMsg=1;
			elseif (strsub(cctchat[i],1,14) == "[Raid Warning]" and CCRaidCheck:GetChecked()~=nil) then
				AddMsg=1;
			elseif (strsub(cctchat[i],1,8) == "[System]" and CCSystemCheck:GetChecked()~=nil) then
				AddMsg=1;
			elseif (strsub(cctchat[i],3,3) == "." and CCOtherCheck:GetChecked()~=nil) then
				AddMsg=1;
			end
		end
		if (AddMsg == 1) then
			if (j>=ccopts.cpos) then
				if (TextShown~="") then
					TextShown = "\n"..TextShown;
				end
				TextShown=cctchat[i]..TextShown;
			end
			j=j+1;
		end
		if (j>=ccopts.lines+ccopts.cpos) then
			break;
		end
	end
	ChatCopy_Edit:SetText(TextShown);
end

function ChatCopyInitText()
	-- cctchat = ccchat;
	local i = 1;
	cctchat = {};
	for i = 1,getn(ccchat),1 do
		cctchat[i] = ccchat[i];
	end
	ccopts.cpos=0;
	ChatCopyTextUpdate();
end

function ChatCopyResetScroll()
	ccopts.cpos = 0;
	ChatCopyTextUpdate();
end

function ChatCopyScrollUp()
	if (ccopts.cpos + ccopts.lines < getn(cctchat)) then
		ccopts.cpos = ccopts.cpos + 1;
	end
	ChatCopyTextUpdate();
end

function ChatCopyScrollDown()
	if (ccopts.cpos > 0) then
		ccopts.cpos = ccopts.cpos - 1;
	end
	ChatCopyTextUpdate();
end

function ChatCopyAddLine()
	ccopts.lines = ccopts.lines + 1;
	ChatCopy_OptionsLines:SetText(tostring(ccopts.lines));
	local font,size,flags = ChatFrame1:GetFont();
	ChatCopy_Core:SetHeight(ChatCopy_Core:GetTop()-ChatCopy_Edit:GetTop()+(ccopts.lines*size)+13);
	ChatCopyTextUpdate();
end

function ChatCopyRemoveLine()
	if (ccopts.lines > 8) then
		ccopts.lines = ccopts.lines - 1;
		ChatCopy_OptionsLines:SetText(tostring(ccopts.lines));
		local font,size,flags = ChatFrame1:GetFont();
		ChatCopy_Core:SetHeight(ChatCopy_Core:GetTop()-ChatCopy_Edit:GetTop()+(ccopts.lines*size)+13);
		ChatCopyTextUpdate();
	end
end

function ChatCopyAddMemory()
	ccopts.memorylimit = ccopts.memorylimit + 5;
	ChatCopyMemoryLabel();
end

function ChatCopyRemoveMemory()
	if (ccopts.memorylimit > 5) then
		ccopts.memorylimit = ccopts.memorylimit - 5;
		if (getn(ccchat) > ccopts.memorylimit) then
			local i=1;
			for i=1,getn(ccchat)-ccopts.memorylimit,1 do
				tremove(ccchat,ccopts.memorylimit+i);
			end
		end
	else
		ccopts.memorylimit = 0;
	end
	ChatCopyMemoryLabel();
end

function ChatCopyMemoryLabel()
	if (ccopts.memorylimit == 0) then
		ChatCopy_OptionsMemoryLabel:SetText("(all)");
	else
		ChatCopy_OptionsMemoryLabel:SetText(tostring(ccopts.memorylimit));
	end
end