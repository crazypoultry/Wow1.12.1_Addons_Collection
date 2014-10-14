mrpWaitTime = GetTime();
mrpLongTextWaitTime = GetTime();
mrpUpdateWaitTime = GetTime();
mrpInitWaitTime = -10000;
mrpJoinFlagRSPChannelWaitTime = -10000;
mrpFlagRSPTime = GetTime();
mrpRespondWaitTime = GetTime();
mrpRefreshChannel = GetTime();
mrpSelfRefresh = GetTime();
mrpRSPLongTextWaitTime = GetTime();


MRP_GET_INFO = 0;
MRP_RESPOND = 1;

MRP_GET_DESC = 2;
MRP_GET_HIST = 3;

MRP_RESPOND_DESC_1 = 4;
MRP_RESPOND_DESC_2 = 5;
MRP_RESPOND_DESC_3 = 6;
MRP_RESPOND_DESC_4 = 7;
MRP_RESPOND_DESC_5 = 8;
MRP_RESPOND_DESC_6 = 9;

MRP_RESPOND_HIST_1 = 10;
MRP_RESPOND_HIST_2 = 11;
MRP_RESPOND_HIST_3 = 12;
MRP_RESPOND_HIST_4 = 13;
MRP_RESPOND_HIST_5 = 14;
MRP_RESPOND_HIST_6 = 15;

MRP_GET_APPEARANCE = 16;
MRP_RESPOND_APPEARANCE = 17;

MRP_GET_LORE = 18;
MRP_RESPOND_LORE = 19;

MRP_GET_FLAGRSP_DESC = "<DP>";

MRP_RESPOND_FLAGRSP_DESC_1 = "<D01>";
MRP_RESPOND_FLAGRSP_DESC_2 = "<D02>";
MRP_RESPOND_FLAGRSP_DESC_3 = "<D03>";
MRP_RESPOND_FLAGRSP_DESC_4 = "<D04>";
MRP_RESPOND_FLAGRSP_DESC_5 = "<D05>";
MRP_RESPOND_FLAGRSP_DESC_6 = "<D06>";

mrpPlayerList = {};
mrpFlagRSPPlayerList = {};

mrpPlayerToSend = {};

mrpWaitingForDescList = {};
mrpWaitingForHistList = {};

mrpFlagRSPWaitingForDescList = {};

mrpDV = 1;

mrpFirstSkyCheck = 0;

mrpInitialized = 0;
mrpFirstRefresh = 0;

function mrpOnCommEvent(event)
	
end


mrpOriginalChatFrame_OnEvent = ChatFrame_OnEvent;

function ChatFrame_OnEvent(event)
	if (event == "CHAT_MSG_CHANNEL_LIST") then
		local mrpIndexOfFlagRSPChannel = GetChannelName("xtensionxtooltip2");
		mrpPlayerExistsInList = false;

		if (mrpIndexOfFlagRSPChannel ~= nil) then
			if (arg4 == mrpIndexOfFlagRSPChannel .. ". xtensionxtooltip2") then
				mrpTempPlayerList = string.split(arg1, ", ");
				mrpNumInTable = table.getn(mrpTempPlayerList);
				for i = 1, mrpNumInTable do
					mrpTempPlayerList[i] = { CharacterName = string.gsub(mrpTempPlayerList[i], "[%*]", "") };
					mrpTempPlayerList[i].CharacterName = string.gsub(mrpTempPlayerList[i].CharacterName, "[@]", "");
					
					for j = 1, table.getn(mrpFlagRSPPlayerList) do
						if (mrpFlagRSPPlayerList[j].CharacterName == mrpTempPlayerList[i].CharacterName) then
							mrpPlayerExistsInList = true;
							break;
						end
					end

					if (mrpPlayerExistsInList == false) then
						local index = table.getn(mrpFlagRSPPlayerList) + 1;
						table.setn(mrpFlagRSPPlayerList, index);
						mrpFlagRSPPlayerList[index] = {};
						mrpFlagRSPPlayerList[index].CharacterName = mrpTempPlayerList[i].CharacterName;
						mrpFlagRSPPlayerList[index].Title = "";
						mrpFlagRSPPlayerList[index].Surname = "";
						mrpFlagRSPPlayerList[index].Roleplay = "";
						mrpFlagRSPPlayerList[index].Character = "";
						mrpFlagRSPPlayerList[index].HasInfo = false;
					end
				end
			end
		end

		local mrpIndexOfChannel = GetChannelName("MyRolePlay");
		mrpPlayerExistsInList = false;
		if (mrpIndexOfChannel ~= nil) then
			if (arg4 == mrpIndexOfChannel .. ". MyRolePlay") then
				mrpTempPlayerList = string.split(arg1, ", ");
				mrpNumInTable = table.getn(mrpTempPlayerList)
				for i = 1, mrpNumInTable do
					mrpTempPlayerList[i] = { CharacterName = string.gsub(mrpTempPlayerList[i], "[%*]", "") };
					mrpTempPlayerList[i].CharacterName = string.gsub(mrpTempPlayerList[i].CharacterName, "[@]", "");
					
					for j = 1, table.getn(mrpPlayerList) do
						if (mrpPlayerList[j].CharacterName == mrpTempPlayerList[i].CharacterName) then
							mrpPlayerExistsInList = true;
							break;
						end
					end

					if (mrpPlayerExistsInList == false) then
						mrpPlayerList[table.getn(mrpPlayerList) + 1] = {};
						mrpPlayerList[table.getn(mrpPlayerList)].CharacterName = mrpTempPlayerList[i].CharacterName;
						mrpPlayerList[table.getn(mrpPlayerList)].Title = "";
						mrpPlayerList[table.getn(mrpPlayerList)].Surname = "";
						mrpPlayerList[table.getn(mrpPlayerList)].Roleplay = "";
						mrpPlayerList[table.getn(mrpPlayerList)].Character = "";
						mrpPlayerList[table.getn(mrpPlayerList)].Firstname = "";
						mrpPlayerList[table.getn(mrpPlayerList)].Middlename = "";
						mrpPlayerList[table.getn(mrpPlayerList)].Nickname = "";
						mrpPlayerList[table.getn(mrpPlayerList)].Prefix = "";
						mrpPlayerList[table.getn(mrpPlayerList)].Housename = "";
						mrpPlayerList[table.getn(mrpPlayerList)].EyeColour = "";
						mrpPlayerList[table.getn(mrpPlayerList)].Height = "";
						mrpPlayerList[table.getn(mrpPlayerList)].Weight = "";
						mrpPlayerList[table.getn(mrpPlayerList)].CurrentEmotion = "";
						mrpPlayerList[table.getn(mrpPlayerList)].HasInfo = false;
					end
				end
			end
		end

		if (arg4 ~= mrpIndexOfChannel .. ". MyRolePlay") then
			if (mrpIndexOfFlagRSPChannel ~= nil) then
				if (arg4 ~= mrpIndexOfFlagRSPChannel .. ". xtensionxtooltip2") then
					mrpOriginalChatFrame_OnEvent(event);
				end
			else
				mrpOriginalChatFrame_OnEvent(event);
			end			
		end

	else
		mrpOriginalChatFrame_OnEvent(event);
	end
end

function mrpOnCommUpdate(elapsed)

	if (mrpSendDataFlagRSPInit == 1 and GetTime() >= mrpInitWaitTime + 2) then
		local mrpIndexOfChannel = GetChannelName("xtensionxtooltip2");	

		if (mrpIndexOfChannel ~= nil) then
			SendChatMessage("<N>" .. MyRolePlay.Identification.Surname .. "<T>" .. MyRolePlay.Identification.Title, "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfChannel);
			SendChatMessage("<CSTATUS>" .. mrpEncodeStatus(MyRolePlay.Status.Character), "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfChannel);
			SendChatMessage("<" .. mrpEncodeStatus(MyRolePlay.Status.Roleplay) .. ">", "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfChannel);
			SendChatMessage("<DV>" .. mrpDV, "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfChannel);
		end
		mrpFlagRSPTime = GetTime();
		mrpSendDataFlagRSPInit = 0;
	end

	if (mrpSendDataInit == 1 and GetTime() >= mrpInitWaitTime + 10) then
		mrpSendMessage(MRP_RESPOND);
		mrpSendDataInit = 0;
	end

	if (mrpSendInfoTime == 1 and GetTime() >= mrpSelfRefresh + 1) then
		mrpSendMessage(MRP_RESPOND);
		mrpSendInfoTime = 0;
	end

	if (GetTime() >= mrpInitWaitTime + .25) then
		PlayerName:SetText(MyRolePlay.Identification.Firstname);
	end

	if (GetTime() >= mrpInitWaitTime + 5) then
		if (mrpInitialized == 0) then
			if (GetChannelName("MyRolePlay") == 0) then
				local mrpDidJoin = JoinChannelByName("MyRolePlay", "", DEFAULT_CHAT_FRAME:GetID());
				if (mrpDidJoin == nil) then
					mrpDisplayMessage(MRP_LOCALE_Fail_To_Init_Fail_Join_Channel);
					mrpDisplayMessage(MRP_LOCALE_Free_One_Channel);
				else
					mrpDisplayMessage(MRP_LOCALE_Initializing);
				end
			else
				mrpDisplayMessage(MRP_LOCALE_Initializing);
			end

			RemoveChatWindowChannel(DEFAULT_CHAT_FRAME:GetID(), "MyRolePlay");			

			if (GetChannelName("xtensionxtooltip2") == 0) then
				JoinChannelByName("xtensionxtooltip2", "", DEFAULT_CHAT_FRAME:GetID());
			end

			RemoveChatWindowChannel(DEFAULT_CHAT_FRAME:GetID(), "xtensionxtooltip2");
			
			mrpInitialized = 1;
			mrpRefreshChannel = GetTime();			
		end
	end	

	if (GetTime() >= mrpRefreshChannel + 3 and mrpFirstRefresh == 0 and mrpInitialized == 1) then
		mrpUpdatePlayerList("MyRolePlay");
		mrpUpdatePlayerList("xtensionxtooltip2");
		mrpDisplayMessage(MRP_LOCALE_Success_Init);
		mrpFirstRefresh = 1;
	end

	if (GetTime() >= mrpFlagRSPTime + 300) then
		local mrpIndexOfChannel = GetChannelName("xtensionxtooltip2");	

		if (mrpIndexOfChannel ~= nil) then
			SendChatMessage("<N>" .. MyRolePlay.Identification.Surname .. "<T>" .. MyRolePlay.Identification.Title, "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfChannel);
			SendChatMessage("<CSTATUS>" .. mrpEncodeStatus(MyRolePlay.Status.Character), "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfChannel);
			SendChatMessage("<" .. mrpEncodeStatus(MyRolePlay.Status.Roleplay) .. ">", "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfChannel);
			SendChatMessage("<DV>" .. mrpDV, "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfChannel);
		end
		mrpFlagRSPTime = GetTime();
	end


	if (GetTime() >= mrpLongTextWaitTime + 1) then
		if (mrpPlayerToSend[1] ~= nil) then
			local i = nil;

			if (mrpPlayerToSend[1].SendDesc1 == true) then
				mrpSendMessage(MRP_RESPOND_DESC_1, mrpPlayerToSend[1].name);
				for i = 1, table.getn(mrpPlayerToSend), 1 do
					if (table.getn(mrpPlayerToSend) > 1) then
						if (i < table.getn(mrpPlayerToSend)) then
							mrpPlayerToSend[i] = mrpPlayerToSend[i + 1];
							table.remove(mrpPlayerToSend, 1);
						end						
					end
				end
				return;
			elseif (mrpPlayerToSend[1].SendDesc2 == true) then
				mrpSendMessage(MRP_RESPOND_DESC_2, mrpPlayerToSend[1].name);
				for i = 1, table.getn(mrpPlayerToSend), 1 do
					if (table.getn(mrpPlayerToSend) > 1) then
						if (i < table.getn(mrpPlayerToSend)) then
							mrpPlayerToSend[i] = mrpPlayerToSend[i + 1];
							table.remove(mrpPlayerToSend, 1);
						end						
					end
				end
				return;
			elseif (mrpPlayerToSend[1].SendDesc3 == true) then
				mrpSendMessage(MRP_RESPOND_DESC_3, mrpPlayerToSend[1].name);
				for i = 1, table.getn(mrpPlayerToSend), 1 do
					if (table.getn(mrpPlayerToSend) > 1) then
						if (i < table.getn(mrpPlayerToSend)) then
							mrpPlayerToSend[i] = mrpPlayerToSend[i + 1];
							table.remove(mrpPlayerToSend, 1);
						end						
					end
				end
				return;
			elseif (mrpPlayerToSend[1].SendDesc4 == true) then
				mrpSendMessage(MRP_RESPOND_DESC_4, mrpPlayerToSend[1].name);
				for i = 1, table.getn(mrpPlayerToSend), 1 do
					if (table.getn(mrpPlayerToSend) > 1) then
						if (i < table.getn(mrpPlayerToSend)) then
							mrpPlayerToSend[i] = mrpPlayerToSend[i + 1];
							table.remove(mrpPlayerToSend, 1);
						end						
					end
				end
				return;
			elseif (mrpPlayerToSend[1].SendDesc5 == true) then
				mrpSendMessage(MRP_RESPOND_DESC_5, mrpPlayerToSend[1].name);
				for i = 1, table.getn(mrpPlayerToSend), 1 do
					if (table.getn(mrpPlayerToSend) > 1) then
						if (i < table.getn(mrpPlayerToSend)) then
							mrpPlayerToSend[i] = mrpPlayerToSend[i + 1];
							table.remove(mrpPlayerToSend, 1);
						end						
					end
				end
				return;
			elseif (mrpPlayerToSend[1].SendDesc6 == true) then
				mrpSendMessage(MRP_RESPOND_DESC_6, mrpPlayerToSend[1].name);
				for i = 1, table.getn(mrpPlayerToSend), 1 do
					if (table.getn(mrpPlayerToSend) > 1) then
						if (i < table.getn(mrpPlayerToSend)) then
							mrpPlayerToSend[i] = mrpPlayerToSend[i + 1];
							table.remove(mrpPlayerToSend, 1);
						end						
					end
				end
				return;
			elseif (mrpPlayerToSend[1].SendHist1 == true) then
				mrpSendMessage(MRP_RESPOND_HIST_1, mrpPlayerToSend[1].name);
				for i = 1, table.getn(mrpPlayerToSend), 1 do
					if (table.getn(mrpPlayerToSend) > 1) then
						if (i < table.getn(mrpPlayerToSend)) then
							mrpPlayerToSend[i] = mrpPlayerToSend[i + 1];
							table.remove(mrpPlayerToSend, 1);
						end						
					end
				end
				return;
			elseif (mrpPlayerToSend[1].SendHist2 == true) then
				mrpSendMessage(MRP_RESPOND_HIST_2, mrpPlayerToSend[1].name);
				for i = 1, table.getn(mrpPlayerToSend), 1 do
					if (table.getn(mrpPlayerToSend) > 1) then
						if (i < table.getn(mrpPlayerToSend)) then
							mrpPlayerToSend[i] = mrpPlayerToSend[i + 1];
							table.remove(mrpPlayerToSend, 1);
						end						
					end
				end
				return;
			elseif (mrpPlayerToSend[1].SendHist3 == true) then
				mrpSendMessage(MRP_RESPOND_HIST_3, mrpPlayerToSend[1].name);
				for i = 1, table.getn(mrpPlayerToSend), 1 do
					if (table.getn(mrpPlayerToSend) > 1) then
						if (i < table.getn(mrpPlayerToSend)) then
							mrpPlayerToSend[i] = mrpPlayerToSend[i + 1];
							table.remove(mrpPlayerToSend, 1);
						end						
					end
				end
				return;
			elseif (mrpPlayerToSend[1].SendHist4 == true) then
				mrpSendMessage(MRP_RESPOND_HIST_4, mrpPlayerToSend[1].name);
				for i = 1, table.getn(mrpPlayerToSend), 1 do
					if (table.getn(mrpPlayerToSend) > 1) then
						if (i < table.getn(mrpPlayerToSend)) then
							mrpPlayerToSend[i] = mrpPlayerToSend[i + 1];
							table.remove(mrpPlayerToSend, 1);
						end						
					end
				end
				return;
			elseif (mrpPlayerToSend[1].SendHist5 == true) then
				mrpSendMessage(MRP_RESPOND_HIST_5, mrpPlayerToSend[1].name);
				for i = 1, table.getn(mrpPlayerToSend), 1 do
					if (table.getn(mrpPlayerToSend) > 1) then
						if (i < table.getn(mrpPlayerToSend)) then
							mrpPlayerToSend[i] = mrpPlayerToSend[i + 1];
							table.remove(mrpPlayerToSend, 1);
						end						
					end
				end
				return;
			elseif (mrpPlayerToSend[1].SendHist6 == true) then
				mrpSendMessage(MRP_RESPOND_HIST_6, mrpPlayerToSend[1].name);
				for i = 1, table.getn(mrpPlayerToSend), 1 do
					if (table.getn(mrpPlayerToSend) > 1) then
						if (i < table.getn(mrpPlayerToSend)) then
							mrpPlayerToSend[i] = mrpPlayerToSend[i + 1];
							table.remove(mrpPlayerToSend, 1);
						end						
					end
				end
				return;
			end
			mrpLongTextWaitTime = GetTime();
			return;
		end
		
		local mrpIndexOfFlagRSPChannel = GetChannelName("xtensionxtooltip2");	

		if (mrpIndexOfFlagRSPChannel ~= nil) then
			if (mrpFlagRSPSendDesc2 == true) then
				SendChatMessage("<D02>" .. MyRolePlay.Appearance.Description2, "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfFlagRSPChannel);
				mrpFlagRSPSendDesc3 = true;
				mrpFlagRSPSendDesc2 = false;
				mrpRSPLongTextWaitTime = GetTime();
			elseif (mrpFlagRSPSendDesc3 == true) then
				SendChatMessage("<D03>" .. MyRolePlay.Appearance.Description3, "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfFlagRSPChannel);
				mrpFlagRSPSendDesc4 = true;
				mrpFlagRSPSendDesc3 = false;
				mrpRSPLongTextWaitTime = GetTime();
			elseif (mrpFlagRSPSendDesc4 == true) then
				SendChatMessage("<D04>" .. MyRolePlay.Appearance.Description4, "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfFlagRSPChannel);
				mrpFlagRSPSendDesc5 = true;
				mrpFlagRSPSendDesc4 = false;
				mrpRSPLongTextWaitTime = GetTime();
			elseif (mrpFlagRSPSendDesc5 == true) then
				SendChatMessage("<D05>" .. MyRolePlay.Appearance.Description5, "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfFlagRSPChannel);
				mrpFlagRSPSendDesc6 = true;
				mrpFlagRSPSendDesc5 = false;
				mrpRSPLongTextWaitTime = GetTime();
			elseif (mrpFlagRSPSendDesc6 == true) then
				SendChatMessage("<D06>" .. MyRolePlay.Appearance.Description6 .. "\\eod", "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfFlagRSPChannel);
				mrpFlagRSPSendDesc6 = false;
				mrpRSPLongTextWaitTime = GetTime();
			end
		end
	end
end

function mrpUpdatePlayerList(whichPlayerList)
	local mrpIndexOfChannel = GetChannelName(whichPlayerList);	
	local i = 1;

	if (mrpIndexOfChannel ~= nil) then
		mrpListChannelByName(mrpIndexOfChannel);
	end	
end

function mrpListChannelByName(index)
	ListChannelByName(index);
end

function mrpSendMessage(message, mrpToWho)
	if (mrpToWho == nil) then
		mrpToWho = "";
	end
	local mrpIndexOfChannel = GetChannelName("MyRolePlay");	
	if (mrpIndexOfChannel ~= nil) then
		if (message == MRP_GET_INFO) then		
			if (GetTime() >= mrpWaitTime + .5) then				
					SendChatMessage(message .. UnitName("mouseover"), "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfChannel);
					mrpWaitTime = GetTime();					
			end
		elseif (message == MRP_RESPOND) then
			if (GetTime() >= mrpRespondWaitTime + 1) then
				SendChatMessage(MRP_RESPOND .. "<F>" .. MyRolePlay.Identification.Firstname .. "<M>" .. MyRolePlay.Identification.Middlename .. "<S>" .. MyRolePlay.Identification.Surname .. "<P>" .. MyRolePlay.Identification.Prefix .. "<T>" .. MyRolePlay.Identification.Title .. "<N>" .. MyRolePlay.Identification.Nickname .. "<H>" .. MyRolePlay.Identification.Housename .. "<RP>" .. MyRolePlay.Status.Roleplay .. "<CS>" .. MyRolePlay.Status.Character, "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfChannel);
				SendChatMessage(MRP_RESPOND_APPEARANCE .. "<E>" .. MyRolePlay.Appearance.EyeColour .. "<H>" .. MyRolePlay.Appearance.Height .. "<W>" .. MyRolePlay.Appearance.Weight .. "<CE>" .. MyRolePlay.Appearance.CurrentEmotion .. "<B>" .. MyRolePlay.Lore.Birthcity .. "<C>" .. MyRolePlay.Lore.Homecity .. "<M>" .. MyRolePlay.Lore.Motto, "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfChannel);
				mrpRespondWaitTime = GetTime();
			end			
		elseif (message == MRP_GET_DESC) then
			mrpWaitingForDescList[table.getn(mrpWaitingForDescList) + 1] = mrpToWho;
			table.setn(mrpWaitingForDescList, table.getn(mrpWaitingForDescList) + 1);
			SendChatMessage(MRP_GET_DESC .. mrpToWho, "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfChannel);
		elseif (message == MRP_GET_HIST) then
			mrpWaitingForHistList[table.getn(mrpWaitingForHistList) + 1] = mrpToWho;
			table.setn(mrpWaitingForHistList, table.getn(mrpWaitingForHistList) + 1);
			SendChatMessage(MRP_GET_HIST .. mrpToWho, "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfChannel);
		elseif (message == MRP_RESPOND_DESC_1) then
			SendChatMessage(MRP_RESPOND_DESC_1 .. "<>" .. mrpEncodeText(MyRolePlay.Appearance.Description1), "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfChannel);
			mrpPlayerToSend[table.getn(mrpPlayerToSend) + 1] = {};
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].name = mrpToWho;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc1 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc2 = true;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc3 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc4 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc5 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc6 = false;
			mrpLongTextWaitTime = GetTime();
		elseif (message == MRP_RESPOND_DESC_2) then
			SendChatMessage(MRP_RESPOND_DESC_2 .. "<>" .. mrpEncodeText(MyRolePlay.Appearance.Description2), "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfChannel);
			mrpPlayerToSend[table.getn(mrpPlayerToSend) + 1] = {};
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].name = mrpToWho;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc1 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc2 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc3 = true;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc4 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc5 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc6 = false;
			mrpLongTextWaitTime = GetTime();
		elseif (message == MRP_RESPOND_DESC_3) then
			SendChatMessage(MRP_RESPOND_DESC_3 .. "<>" .. mrpEncodeText(MyRolePlay.Appearance.Description3), "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfChannel);
			mrpPlayerToSend[table.getn(mrpPlayerToSend) + 1] = {};
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].name = mrpToWho;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc1 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc2 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc3 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc4 = true;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc5 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc6 = false;
			mrpLongTextWaitTime = GetTime();
		elseif (message == MRP_RESPOND_DESC_4) then
			SendChatMessage(MRP_RESPOND_DESC_4 .. "<>" .. mrpEncodeText(MyRolePlay.Appearance.Description4), "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfChannel);
			mrpPlayerToSend[table.getn(mrpPlayerToSend) + 1] = {};
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].name = mrpToWho;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc1 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc2 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc3 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc4 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc5 = true;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc6 = false;
			mrpLongTextWaitTime = GetTime();
		elseif (message == MRP_RESPOND_DESC_5) then
			SendChatMessage(MRP_RESPOND_DESC_5 .. "<>" .. mrpEncodeText(MyRolePlay.Appearance.Description5), "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfChannel);
			mrpPlayerToSend[table.getn(mrpPlayerToSend) + 1] = {};
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].name = mrpToWho;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc1 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc2 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc3 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc4 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc5 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc6 = true;
			mrpLongTextWaitTime = GetTime();
		elseif (message == MRP_RESPOND_DESC_6) then
			SendChatMessage(MRP_RESPOND_DESC_6 .. "<>" .. mrpEncodeText(MyRolePlay.Appearance.Description6), "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfChannel);
			mrpPlayerToSend[table.getn(mrpPlayerToSend) + 1] = {};
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].name = mrpToWho;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc1 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc2 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc3 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc4 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc5 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendDesc6 = false;
			mrpLongTextWaitTime = GetTime();
		elseif (message == MRP_RESPOND_HIST_1) then
			SendChatMessage(MRP_RESPOND_HIST_1 .. "<>" .. mrpEncodeText(MyRolePlay.Lore.History1), "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfChannel);
			mrpPlayerToSend[table.getn(mrpPlayerToSend) + 1] = {};
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].name = mrpToWho;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist1 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist2 = true;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist3 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist4 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist5 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist6 = false;
			mrpLongTextWaitTime = GetTime();
		elseif (message == MRP_RESPOND_HIST_2) then
			SendChatMessage(MRP_RESPOND_HIST_2 .. "<>" .. mrpEncodeText(MyRolePlay.Lore.History2), "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfChannel);
			mrpPlayerToSend[table.getn(mrpPlayerToSend) + 1] = {};
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].name = mrpToWho;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist1 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist2 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist3 = true;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist4 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist5 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist6 = false;
			mrpLongTextWaitTime = GetTime();
		elseif (message == MRP_RESPOND_HIST_3) then
			SendChatMessage(MRP_RESPOND_HIST_3 .. "<>" .. mrpEncodeText(MyRolePlay.Lore.History3), "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfChannel);
			mrpPlayerToSend[table.getn(mrpPlayerToSend) + 1] = {};
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].name = mrpToWho;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist1 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist2 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist3 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist4 = true;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist5 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist6 = false;
			mrpLongTextWaitTime = GetTime();
		elseif (message == MRP_RESPOND_HIST_4) then
			SendChatMessage(MRP_RESPOND_HIST_4 .. "<>" .. mrpEncodeText(MyRolePlay.Lore.History4), "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfChannel);
			mrpPlayerToSend[table.getn(mrpPlayerToSend) + 1] = {};
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].name = mrpToWho;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist1 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist2 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist3 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist4 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist5 = true;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist6 = false;
			mrpLongTextWaitTime = GetTime();
		elseif (message == MRP_RESPOND_HIST_5) then
			SendChatMessage(MRP_RESPOND_HIST_5 .. "<>" .. mrpEncodeText(MyRolePlay.Lore.History5), "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfChannel);
			mrpPlayerToSend[table.getn(mrpPlayerToSend) + 1] = {};
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].name = mrpToWho;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist1 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist2 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist3 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist4 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist5 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist6 = true;
			mrpLongTextWaitTime = GetTime();
		elseif (message == MRP_RESPOND_HIST_6) then
			SendChatMessage(MRP_RESPOND_HIST_6 .. "<>" .. mrpEncodeText(MyRolePlay.Lore.History6), "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfChannel);
			mrpPlayerToSend[table.getn(mrpPlayerToSend) + 1] = {};
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].name = mrpToWho;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist1 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist2 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist3 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist4 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist5 = false;
			mrpPlayerToSend[table.getn(mrpPlayerToSend)].SendHist6 = false;
			mrpLongTextWaitTime = GetTime();		
		end
	end

	local mrpIndexOfChannel = GetChannelName("xtensionxtooltip2");	
	if (mrpIndexOfChannel ~= nil) then
		if (message == MRP_GET_FLAGRSP_DESC) then
			mrpFlagRSPWaitingForDescList[table.getn(mrpFlagRSPWaitingForDescList) + 1] = mrpToWho;
			table.setn(mrpFlagRSPWaitingForDescList, table.getn(mrpFlagRSPWaitingForDescList) + 1);
			SendChatMessage(MRP_GET_FLAGRSP_DESC .. mrpToWho, "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfChannel);
		end
	end
end

function mrpChannelEvent(event)
	local mrpIndexOfChannelExists = nil;
	local mrpIndexOfFlagRSPChannelExists = nil;
	local mrpIndexOfChannel = GetChannelName("MyRolePlay");
	local mrpIndexOfFlagRSPChannel = GetChannelName("xtensionxtooltip2");

	if (mrpIndexOfChannel ~= nil) then
		mrpIndexOfChannelExists = 1;
	end
	if (mrpIndexOfFlagRSPChannel ~= nil) then
		mrpIndexOfFlagRSPChannelExists = 1;
	end

	if (mrpIndexOfChannelExists == 1 and arg8 == mrpIndexOfChannel) then
		local preMessage = string.sub(arg1, 1, 2);

		if (string.find(preMessage, MRP_GET_INFO .. ".")) then
			local mrpTempTarget = nil;
			local i = nil;
			local index = nil;

			for i in string.gfind(arg1, MRP_GET_INFO .. "[%a%s]*") do
				mrpTempTarget = i;
				mrpTempTarget = string.gsub(mrpTempTarget, MRP_GET_INFO, "");
			end
			
			if (UnitName("player") == mrpTempTarget) then
				mrpSendMessage(MRP_RESPOND, arg2);
			end			

		elseif (string.find(preMessage, MRP_RESPOND .. "<")) then

			for i = 1, table.getn(mrpPlayerList) do
				if (arg2 == mrpPlayerList[i].CharacterName) then
					mrpIndex = i;
					break;
				end
			end

			if (mrpIndex == nil) then
				return;				
			end
			
			for i in string.gfind(arg1, "<F>[^<.]*") do
				mrpPlayerList[mrpIndex].Firstname = i;
				mrpPlayerList[mrpIndex].Firstname = string.gsub(mrpPlayerList[mrpIndex].Firstname, "<F>", "");
				mrpPlayerList[mrpIndex].HasInfo = true;
			end			
			for i in string.gfind(arg1, "<M>[^<.]*") do
				mrpPlayerList[mrpIndex].Middlename = i;
				mrpPlayerList[mrpIndex].Middlename = string.gsub(mrpPlayerList[mrpIndex].Middlename, "<M>", "");
				mrpPlayerList[mrpIndex].HasInfo = true;
			end
			for i in string.gfind(arg1, "<S>[^<.]*") do
				mrpPlayerList[mrpIndex].Surname = i;
				mrpPlayerList[mrpIndex].Surname = string.gsub(mrpPlayerList[mrpIndex].Surname, "<S>", "");
				mrpPlayerList[mrpIndex].HasInfo = true;
			end
			for i in string.gfind(arg1, "<P>[^<.%.]*") do
				mrpPlayerList[mrpIndex].Prefix = i;
				mrpPlayerList[mrpIndex].Prefix = string.gsub(mrpPlayerList[mrpIndex].Prefix, "<P>", "");
				mrpPlayerList[mrpIndex].HasInfo = true;
			end
			for i in string.gfind(arg1, "<T>[^<.]*") do
				mrpPlayerList[mrpIndex].Title = i;
				mrpPlayerList[mrpIndex].Title = string.gsub(mrpPlayerList[mrpIndex].Title, "<T>", "");
				mrpPlayerList[mrpIndex].HasInfo = true;
			end
			for i in string.gfind(arg1, "<N>[^<.]*") do
				mrpPlayerList[mrpIndex].Nickname = i;
				mrpPlayerList[mrpIndex].Nickname = string.gsub(mrpPlayerList[mrpIndex].Nickname, "<N>", "");
				mrpPlayerList[mrpIndex].HasInfo = true;
			end
			for i in string.gfind(arg1, "<H>[^<.]*") do
				mrpPlayerList[mrpIndex].Housename = i;
				mrpPlayerList[mrpIndex].Housename = string.gsub(mrpPlayerList[mrpIndex].Housename, "<H>", "");
				mrpPlayerList[mrpIndex].HasInfo = true;
			end
			for i in string.gfind(arg1, "<RP>[^<.]*") do
				mrpPlayerList[mrpIndex].Roleplay = i;
				mrpPlayerList[mrpIndex].Roleplay = string.gsub(mrpPlayerList[mrpIndex].Roleplay, "<RP>", "");
				mrpPlayerList[mrpIndex].HasInfo = true;
				mrpPlayerList[mrpIndex].Roleplay = mrpDecodeStatus(mrpPlayerList[mrpIndex].Roleplay);
			end
			for i in string.gfind(arg1, "<CS>[^<.]*") do
				mrpPlayerList[mrpIndex].Character = i;
				mrpPlayerList[mrpIndex].Character = string.gsub(mrpPlayerList[mrpIndex].Character, "<CS>", "");
				mrpPlayerList[mrpIndex].HasInfo = true;
				mrpPlayerList[mrpIndex].Character = mrpDecodeStatus(mrpPlayerList[mrpIndex].Character);
			end
			if (UnitExists("mouseover")) then
				if (UnitIsPlayer("mouseover")) then
					if (UnitName("mouseover") == arg2) then
						mrpDisplayTooltip("mouseover", "MOUSEOVER");
					end
				end					
			end
		elseif (string.find(preMessage, MRP_GET_DESC .. ".")) then
			local mrpTempTarget = nil;
			local i = nil;

			for i in string.gfind(arg1, MRP_GET_DESC .. "[%a%s]*") do
				mrpTempTarget = i;
				mrpTempTarget = string.gsub(mrpTempTarget, MRP_GET_DESC, "");
			end
			
			if (UnitName("player") == mrpTempTarget) then
				mrpSendMessage(MRP_RESPOND_DESC_1, arg2);
			end
		elseif (string.find(preMessage, MRP_RESPOND_DESC_1 .. "<")) then
			for i = 1, table.getn(mrpWaitingForDescList) do
				if (mrpWaitingForDescList[i] == arg2) then
					mrpTarget.Appearance.Description1 = mrpDecodeText(string.gsub(arg1, MRP_RESPOND_DESC_1 .. "<>", "", 1));
					mrpCharSheet1DescBox:SetText(mrpTarget.Appearance.Description1);
					if (mrpTarget.Appearance.Description1 ~= "") then
						if (MyRolePlay.Settings.PopupDescriptions == 1) then
							mrpTargetCharacterSheetTooltip:SetText(mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.PrefixNonPvp.red, MyRolePlay.Settings.Colours.PrefixNonPvp.green, MyRolePlay.Settings.Colours.PrefixNonPvp.blue) .. mrpTarget.Identification.Prefix .. " " .. mrpHexEnd .. mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.FirstnameNonPvp.red, MyRolePlay.Settings.Colours.FirstnameNonPvp.green, MyRolePlay.Settings.Colours.FirstnameNonPvp.blue) .. mrpTarget.Identification.Firstname .. " " .. mrpHexEnd .. mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.MiddlenameNonPvp.red, MyRolePlay.Settings.Colours.MiddlenameNonPvp.green, MyRolePlay.Settings.Colours.MiddlenameNonPvp.blue) .. mrpTarget.Identification.Middlename .. " " .. mrpHexEnd .. mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.SurnameNonPvp.red, MyRolePlay.Settings.Colours.SurnameNonPvp.green, MyRolePlay.Settings.Colours.SurnameNonPvp.blue) .. mrpTarget.Identification.Surname .. " " .. mrpHexEnd, 1, 1, 1);
							mrpTargetCharacterSheetTooltip:AddLine("Character Physical Description:\n", 1, 1, 1, 1);
							mrpTargetCharacterSheetTooltip:AddLine(mrpTarget.Appearance.Description1, 1, 1, 1, 1);
							mrpTargetCharacterSheetTooltip:Show();
						end
					end

					break;
				end
			end
		elseif (string.find(preMessage, MRP_RESPOND_DESC_2 .. "<")) then
			for i = 1, table.getn(mrpWaitingForDescList) do
				if (mrpWaitingForDescList[i] == arg2) then
					mrpTarget.Appearance.Description2 = mrpDecodeText(string.gsub(arg1, MRP_RESPOND_DESC_2 .. "<>", "", 1))
					mrpCharSheet1DescBox:SetText(mrpCharSheet1DescBox:GetText() .. mrpTarget.Appearance.Description2);
					if (mrpTargetCharacterSheetTooltip:IsShown()) then
						mrpTargetCharacterSheetTooltipTextLeft3:SetText(mrpTargetCharacterSheetTooltipTextLeft3:GetText() .. mrpTarget.Appearance.Description2 .. "-");
						mrpTargetCharacterSheetTooltip:Show();
					end
					break;
				end
			end
		elseif (string.find(preMessage, MRP_RESPOND_DESC_3 .. "<")) then
			for i = 1, table.getn(mrpWaitingForDescList) do
				if (mrpWaitingForDescList[i] == arg2) then
					mrpTarget.Appearance.Description3 = mrpDecodeText(string.gsub(arg1, MRP_RESPOND_DESC_3 .. "<>", "", 1))
					mrpCharSheet1DescBox:SetText(mrpCharSheet1DescBox:GetText() .. mrpTarget.Appearance.Description3);
					if (mrpTargetCharacterSheetTooltip:IsShown()) then
						mrpTargetCharacterSheetTooltip:AddLine(mrpTarget.Appearance.Description3, 1, 1, 1, 1);
						mrpTargetCharacterSheetTooltip:Show();
					end
					break;
				end
			end
		elseif (string.find(preMessage, MRP_RESPOND_DESC_4 .. "<")) then
			for i = 1, table.getn(mrpWaitingForDescList) do
				if (mrpWaitingForDescList[i] == arg2) then
					mrpTarget.Appearance.Description4 = mrpDecodeText(string.gsub(arg1, MRP_RESPOND_DESC_4 .. "<>", "", 1))
					mrpCharSheet1DescBox:SetText(mrpCharSheet1DescBox:GetText() .. mrpTarget.Appearance.Description4);
					if (mrpTargetCharacterSheetTooltip:IsShown() and mrpTargetCharacterSheetTooltipTextLeft4:IsShown()) then
						mrpTargetCharacterSheetTooltipTextLeft4:SetText(mrpTargetCharacterSheetTooltipTextLeft4:GetText() .. mrpTarget.Appearance.Description4);
						mrpTargetCharacterSheetTooltip:Show();
					end
					break;
				end
			end
		elseif (string.find(preMessage, MRP_RESPOND_DESC_5 .. "<")) then
			for i = 1, table.getn(mrpWaitingForDescList) do
				if (mrpWaitingForDescList[i] == arg2) then
					mrpTarget.Appearance.Description5 = mrpDecodeText(string.gsub(arg1, MRP_RESPOND_DESC_5 .. "<>", "", 1))
					mrpCharSheet1DescBox:SetText(mrpCharSheet1DescBox:GetText() .. mrpTarget.Appearance.Description5);
					if (mrpTargetCharacterSheetTooltip:IsShown() and mrpTargetCharacterSheetTooltipTextLeft4:IsShown()) then
						mrpTargetCharacterSheetTooltipTextLeft4:SetText(mrpTargetCharacterSheetTooltipTextLeft4:GetText() .. mrpTarget.Appearance.Description5 .. "-");
						mrpTargetCharacterSheetTooltip:Show();
					end
					break;
				end
			end
		elseif (string.find(preMessage, MRP_RESPOND_DESC_6 .. "<")) then
			for i = 1, table.getn(mrpWaitingForDescList) do
				if (mrpWaitingForDescList[i] == arg2) then
					mrpTarget.Appearance.Description6 = mrpDecodeText(string.gsub(arg1, MRP_RESPOND_DESC_6 .. "<>", "", 1))
					mrpCharSheet1DescBox:SetText(mrpCharSheet1DescBox:GetText() .. mrpTarget.Appearance.Description6);
					if (mrpTargetCharacterSheetTooltip:IsShown() and mrpTargetCharacterSheetTooltipTextLeft4:IsShown()) then
						mrpTargetCharacterSheetTooltip:AddLine(mrpTarget.Appearance.Description6, 1, 1, 1, 1);
						mrpTargetCharacterSheetTooltip:Show();
					end
					table.remove(mrpWaitingForDescList, i);
					break;
				end
			end
		elseif (string.find(preMessage, MRP_RESPOND_APPEARANCE)) then
			for i = 1, table.getn(mrpPlayerList) do
				if (arg2 == mrpPlayerList[i].CharacterName) then
					mrpIndex = i;
					break;
				end
			end

			if (mrpIndex == nil) then
				return;				
			end
			
			for i in string.gfind(arg1, "<E>[^<.]*") do
				mrpPlayerList[mrpIndex].EyeColour = i;
				mrpPlayerList[mrpIndex].EyeColour = string.gsub(mrpPlayerList[mrpIndex].EyeColour, "<E>", "");
				mrpPlayerList[mrpIndex].HasInfo = true;
			end
			for i in string.gfind(arg1, "<H>[^<.]*") do
				mrpPlayerList[mrpIndex].Height = i;
				mrpPlayerList[mrpIndex].Height = string.gsub(mrpPlayerList[mrpIndex].Height, "<H>", "");
				mrpPlayerList[mrpIndex].HasInfo = true;
			end
			for i in string.gfind(arg1, "<W>[^<.]*") do
				mrpPlayerList[mrpIndex].Weight = i;
				mrpPlayerList[mrpIndex].Weight = string.gsub(mrpPlayerList[mrpIndex].Weight, "<W>", "");
				mrpPlayerList[mrpIndex].HasInfo = true;
			end
			for i in string.gfind(arg1, "<CE>[^<.]*") do
				mrpPlayerList[mrpIndex].CurrentEmotion = i;
				mrpPlayerList[mrpIndex].CurrentEmotion = string.gsub(mrpPlayerList[mrpIndex].CurrentEmotion, "<CE>", "");
				mrpPlayerList[mrpIndex].HasInfo = true;
			end
			for i in string.gfind(arg1, "<B>[^<.]*") do
				mrpPlayerList[mrpIndex].Birthcity = i;
				mrpPlayerList[mrpIndex].Birthcity = string.gsub(mrpPlayerList[mrpIndex].Birthcity, "<B>", "");
				mrpPlayerList[mrpIndex].HasInfo = true;
			end
			for i in string.gfind(arg1, "<C>[^<.]*") do
				mrpPlayerList[mrpIndex].Homecity = i;
				mrpPlayerList[mrpIndex].Homecity = string.gsub(mrpPlayerList[mrpIndex].Homecity, "<C>", "");
				mrpPlayerList[mrpIndex].HasInfo = true;
			end
			for i in string.gfind(arg1, "<M>[^<.]*") do
				mrpPlayerList[mrpIndex].Motto = i;
				mrpPlayerList[mrpIndex].Motto = string.gsub(mrpPlayerList[mrpIndex].Motto, "<M>", "");
				mrpPlayerList[mrpIndex].HasInfo = true;
			end
		elseif (string.find(preMessage, MRP_GET_HIST .. ".")) then
			local mrpTempTarget = nil;
			local i = nil;

			for i in string.gfind(arg1, MRP_GET_HIST .. "[%a%s]*") do
				mrpTempTarget = i;
				mrpTempTarget = string.gsub(mrpTempTarget, MRP_GET_HIST, "");
			end
			
			if (UnitName("player") == mrpTempTarget) then
				mrpSendMessage(MRP_RESPOND_HIST_1, arg2);
			end	
		elseif (string.find(preMessage, MRP_RESPOND_HIST_1)) then
			for i = 1, table.getn(mrpWaitingForHistList) do
				if (mrpWaitingForHistList[i] == arg2) then
					mrpTarget.Appearance.History1 = mrpDecodeText(string.gsub(arg1, MRP_RESPOND_HIST_1 .. "<>", "", 1));
					mrpCharSheet1HistBox:SetText(mrpTarget.Appearance.History1);
					break;
				end
			end
		elseif (string.find(preMessage, MRP_RESPOND_HIST_2)) then
			for i = 1, table.getn(mrpWaitingForHistList) do
				if (mrpWaitingForHistList[i] == arg2) then
					mrpTarget.Appearance.History2 = mrpDecodeText(string.gsub(arg1, MRP_RESPOND_HIST_2 .. "<>", "", 1));
					mrpCharSheet1HistBox:SetText(mrpCharSheet1HistBox:GetText() .. mrpTarget.Appearance.History2);
					break;
				end
			end
		elseif (string.find(preMessage, MRP_RESPOND_HIST_3)) then
			for i = 1, table.getn(mrpWaitingForHistList) do
				if (mrpWaitingForHistList[i] == arg2) then
					mrpTarget.Appearance.History3 = mrpDecodeText(string.gsub(arg1, MRP_RESPOND_HIST_3 .. "<>", "", 1));
					mrpCharSheet1HistBox:SetText(mrpCharSheet1HistBox:GetText() .. mrpTarget.Appearance.History3);
					break;
				end
			end
		elseif (string.find(preMessage, MRP_RESPOND_HIST_4)) then
			for i = 1, table.getn(mrpWaitingForHistList) do
				if (mrpWaitingForHistList[i] == arg2) then
					mrpTarget.Appearance.History4 = mrpDecodeText(string.gsub(arg1, MRP_RESPOND_HIST_4 .. "<>", "", 1));
					mrpCharSheet1HistBox:SetText(mrpCharSheet1HistBox:GetText() .. mrpTarget.Appearance.History4);
					break;
				end
			end
		elseif (string.find(preMessage, MRP_RESPOND_HIST_5)) then
			for i = 1, table.getn(mrpWaitingForHistList) do
				if (mrpWaitingForHistList[i] == arg2) then
					mrpTarget.Appearance.History5 = mrpDecodeText(string.gsub(arg1, MRP_RESPOND_HIST_5 .. "<>", "", 1));
					mrpCharSheet1HistBox:SetText(mrpCharSheet1HistBox:GetText() .. mrpTarget.Appearance.History5);
					break;
				end
			end
		elseif (string.find(preMessage, MRP_RESPOND_HIST_6)) then
			for i = 1, table.getn(mrpWaitingForHistList) do
				if (mrpWaitingForHistList[i] == arg2) then
					mrpTarget.Appearance.History6 = mrpDecodeText(string.gsub(arg1, MRP_RESPOND_HIST_6 .. "<>", "", 1));
					mrpCharSheet1HistBox:SetText(mrpCharSheet1HistBox:GetText() .. mrpTarget.Appearance.History6);
					table.remove(mrpWaitingForHistList, i);
					break;
				end
			end
		end
	end

	if (mrpIndexOfFlagRSPChannelExists == 1 and arg8 == mrpIndexOfFlagRSPChannel) then
		local index = nil;

		for j = 1, table.getn(mrpFlagRSPPlayerList) do
			if (mrpFlagRSPPlayerList[j].CharacterName == arg2) then
				index = j;
			end
		end

		if (string.find(arg1, "<DP>" .. UnitName("player"))) then
			if (GetTime() >= mrpRSPLongTextWaitTime + 10) then
				SendChatMessage("<D01>" .. MyRolePlay.Appearance.Description1, "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfFlagRSPChannel);
				mrpFlagRSPSendDesc2 = true;
				mrpRSPLongTextWaitTime = GetTime();
			end			
		end

		if (string.find(arg1, "<DPULL>" .. UnitName("player"))) then
			if (GetTime() >= mrpRSPLongTextWaitTime + 10) then
				SendChatMessage("<D01>" .. MyRolePlay.Appearance.Description1, "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfFlagRSPChannel);
				mrpFlagRSPSendDesc2 = true;
				mrpRSPLongTextWaitTime = GetTime();
			end			
		end
		if (mrpFlagRSPPlayerList[index] ~= nil) then
			for i in string.gfind(arg1, "<T>[^<.]*") do
				mrpFlagRSPPlayerList[index].Title = i;
				mrpFlagRSPPlayerList[index].Title = string.gsub(mrpFlagRSPPlayerList[index].Title, "<T>", "");
				mrpFlagRSPPlayerList[index].HasInfo = true;
			end
			for i in string.gfind(arg1, "<TITEL>[^<.]*") do
				mrpFlagRSPPlayerList[index].Title = i;
				mrpFlagRSPPlayerList[index].Title = string.gsub(mrpFlagRSPPlayerList[index].Title, "<TITEL>", "");
				mrpFlagRSPPlayerList[index].HasInfo = true;
			end
			for i in string.gfind(arg1, "<N>[^<.]*") do
				mrpFlagRSPPlayerList[index].Surname = i;
				mrpFlagRSPPlayerList[index].Surname = string.gsub(mrpFlagRSPPlayerList[index].Surname, "<N>", "");
				mrpFlagRSPPlayerList[index].HasInfo = true;
			end
			for i in string.gfind(arg1, "<CSTATUS>[%a%-]*") do
				mrpFlagRSPPlayerList[index].Character = i;
				mrpFlagRSPPlayerList[index].Character = string.gsub(mrpFlagRSPPlayerList[index].Character, "<CSTATUS>", "");
				mrpFlagRSPPlayerList[index].HasInfo = true;
			end
			for i in string.gfind(arg1, "<CS%d>") do
				mrpFlagRSPPlayerList[index].Character = i;
				mrpFlagRSPPlayerList[index].Character = string.gsub(mrpFlagRSPPlayerList[index].Character, "<", "");
				mrpFlagRSPPlayerList[index].Character = string.gsub(mrpFlagRSPPlayerList[index].Character, ">", "");
				mrpFlagRSPPlayerList[index].HasInfo = true;
			end
			for i in string.gfind(arg1, "<RP%d->") do
				mrpFlagRSPPlayerList[index].Roleplay = i;
				mrpFlagRSPPlayerList[index].Roleplay = string.gsub(mrpFlagRSPPlayerList[index].Roleplay, "<", "");
				mrpFlagRSPPlayerList[index].Roleplay = string.gsub(mrpFlagRSPPlayerList[index].Roleplay, ">", "");
				mrpFlagRSPPlayerList[index].HasInfo = true;
			end
		end

		if (string.find(arg1, MRP_RESPOND_FLAGRSP_DESC_1)) then
			for i = 1, table.getn(mrpFlagRSPWaitingForDescList) do
				if (mrpFlagRSPWaitingForDescList[i] == arg2) then
					mrpTarget.Appearance.Description1 = string.gsub(arg1, MRP_RESPOND_FLAGRSP_DESC_1, "", 1);
					mrpTarget.Appearance.Description1 = string.gsub(mrpTarget.Appearance.Description1, "\\l", "\r");
					if (string.find(mrpTarget.Appearance.Description1, "\\eod")) then
						table.remove(mrpFlagRSPWaitingForDescList, i);
						mrpTarget.Appearance.Description1 = string.gsub(mrpTarget.Appearance.Description1, "\\eod", "");
					end
					mrpCharSheet1DescBox:SetText(mrpTarget.Appearance.Description1);

					if (mrpTarget.Appearance.Description1 ~= "") then
						if (MyRolePlay.Settings.PopupDescriptions == 1) then
							mrpTargetCharacterSheetTooltip:SetText(mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.PrefixNonPvp.red, MyRolePlay.Settings.Colours.PrefixNonPvp.green, MyRolePlay.Settings.Colours.PrefixNonPvp.blue) .. mrpTarget.Identification.Prefix .. " " .. mrpHexEnd .. mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.FirstnameNonPvp.red, MyRolePlay.Settings.Colours.FirstnameNonPvp.green, MyRolePlay.Settings.Colours.FirstnameNonPvp.blue) .. mrpTarget.Identification.Firstname .. " " .. mrpHexEnd .. mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.MiddlenameNonPvp.red, MyRolePlay.Settings.Colours.MiddlenameNonPvp.green, MyRolePlay.Settings.Colours.MiddlenameNonPvp.blue) .. mrpTarget.Identification.Middlename .. " " .. mrpHexEnd .. mrpHexStart .. mrpColourToHex(MyRolePlay.Settings.Colours.SurnameNonPvp.red, MyRolePlay.Settings.Colours.SurnameNonPvp.green, MyRolePlay.Settings.Colours.SurnameNonPvp.blue) .. mrpTarget.Identification.Surname .. " " .. mrpHexEnd, 1, 1, 1);
							mrpTargetCharacterSheetTooltip:AddLine("Character Physical Description:\n", 1, 1, 1, 1);
							mrpTargetCharacterSheetTooltip:AddLine(mrpTarget.Appearance.Description1, 1, 1, 1, 1);
							mrpTargetCharacterSheetTooltip:Show();
						end
					end

					break;
				end
			end
		elseif (string.find(arg1, MRP_RESPOND_FLAGRSP_DESC_2)) then
			for i = 1, table.getn(mrpFlagRSPWaitingForDescList) do
				if (mrpFlagRSPWaitingForDescList[i] == arg2) then
					mrpTarget.Appearance.Description2 = string.gsub(arg1, MRP_RESPOND_FLAGRSP_DESC_2, "", 1);
					mrpTarget.Appearance.Description2 = string.gsub(mrpTarget.Appearance.Description2, "\\l", "\r");
					if (string.find(mrpTarget.Appearance.Description2, "\\eod")) then
						table.remove(mrpFlagRSPWaitingForDescList, i);
						mrpTarget.Appearance.Description2 = string.gsub(mrpTarget.Appearance.Description2, "\\eod", "");
					end
					mrpCharSheet1DescBox:SetText(mrpCharSheet1DescBox:GetText() .. mrpTarget.Appearance.Description2);

					if (mrpTargetCharacterSheetTooltip:IsShown()) then
						mrpTargetCharacterSheetTooltipTextLeft3:SetText(mrpTargetCharacterSheetTooltipTextLeft3:GetText() .. mrpTarget.Appearance.Description2 .. "-");
						mrpTargetCharacterSheetTooltip:Show();
					end

					break;
				end
			end
		elseif (string.find(arg1, MRP_RESPOND_FLAGRSP_DESC_3)) then
			for i = 1, table.getn(mrpFlagRSPWaitingForDescList) do
				if (mrpFlagRSPWaitingForDescList[i] == arg2) then
					mrpTarget.Appearance.Description3 = string.gsub(arg1, MRP_RESPOND_FLAGRSP_DESC_3, "", 1);
					mrpTarget.Appearance.Description3 = string.gsub(mrpTarget.Appearance.Description3, "\\l", "\r");
					if (string.find(mrpTarget.Appearance.Description3, "\\eod")) then
						table.remove(mrpFlagRSPWaitingForDescList, i);
						mrpTarget.Appearance.Description3 = string.gsub(mrpTarget.Appearance.Description3, "\\eod", "");
					end
					mrpCharSheet1DescBox:SetText(mrpCharSheet1DescBox:GetText() .. mrpTarget.Appearance.Description3);

					if (mrpTargetCharacterSheetTooltip:IsShown()) then
						mrpTargetCharacterSheetTooltip:AddLine(mrpTarget.Appearance.Description3, 1, 1, 1, 1);
						mrpTargetCharacterSheetTooltip:Show();
					end

					break;
				end
			end
		elseif (string.find(arg1, MRP_RESPOND_FLAGRSP_DESC_4)) then
			for i = 1, table.getn(mrpFlagRSPWaitingForDescList) do
				if (mrpFlagRSPWaitingForDescList[i] == arg2) then
					mrpTarget.Appearance.Description4 = string.gsub(arg1, MRP_RESPOND_FLAGRSP_DESC_4, "", 1);
					mrpTarget.Appearance.Description4 = string.gsub(mrpTarget.Appearance.Description4, "\\l", "\r");
					if (string.find(mrpTarget.Appearance.Description4, "\\eod")) then
						table.remove(mrpFlagRSPWaitingForDescList, i);
						mrpTarget.Appearance.Description4 = string.gsub(mrpTarget.Appearance.Description4, "\\eod", "");
					end
					mrpCharSheet1DescBox:SetText(mrpCharSheet1DescBox:GetText() .. mrpTarget.Appearance.Description4);

					if (mrpTargetCharacterSheetTooltip:IsShown() and mrpTargetCharacterSheetTooltipTextLeft4:IsShown()) then
						mrpTargetCharacterSheetTooltipTextLeft4:SetText(mrpTargetCharacterSheetTooltipTextLeft4:GetText() .. mrpTarget.Appearance.Description4);
						mrpTargetCharacterSheetTooltip:Show();
					end

					break;
				end
			end
		elseif (string.find(arg1, MRP_RESPOND_FLAGRSP_DESC_5)) then
			for i = 1, table.getn(mrpFlagRSPWaitingForDescList) do
				if (mrpFlagRSPWaitingForDescList[i] == arg2) then
					mrpTarget.Appearance.Description5 = string.gsub(arg1, MRP_RESPOND_FLAGRSP_DESC_5, "", 1);
					mrpTarget.Appearance.Description5 = string.gsub(mrpTarget.Appearance.Description5, "\\l", "\r");
					if (string.find(mrpTarget.Appearance.Description5, "\\eod")) then
						table.remove(mrpFlagRSPWaitingForDescList, i);
						mrpTarget.Appearance.Description5 = string.gsub(mrpTarget.Appearance.Description5, "\\eod", "");
					end
					mrpCharSheet1DescBox:SetText(mrpCharSheet1DescBox:GetText() .. mrpTarget.Appearance.Description5);

					if (mrpTargetCharacterSheetTooltip:IsShown() and mrpTargetCharacterSheetTooltipTextLeft4:IsShown()) then
						mrpTargetCharacterSheetTooltipTextLeft4:SetText(mrpTargetCharacterSheetTooltipTextLeft4:GetText() .. mrpTarget.Appearance.Description5 .. "-");
						mrpTargetCharacterSheetTooltip:Show();
					end

					break;
				end
			end
		elseif (string.find(arg1, MRP_RESPOND_FLAGRSP_DESC_6)) then
			for i = 1, table.getn(mrpFlagRSPWaitingForDescList) do
				if (mrpFlagRSPWaitingForDescList[i] == arg2) then
					mrpTarget.Appearance.Description6 = string.gsub(arg1, MRP_RESPOND_FLAGRSP_DESC_6, "", 1);
					mrpTarget.Appearance.Description6 = string.gsub(mrpTarget.Appearance.Description6, "\\l", "\r");
					if (string.find(mrpTarget.Appearance.Description6, "\\eod")) then
						table.remove(mrpFlagRSPWaitingForDescList, i);
						mrpTarget.Appearance.Description6 = string.gsub(mrpTarget.Appearance.Description6, "\\eod", "");
					end
					mrpCharSheet1DescBox:SetText(mrpCharSheet1DescBox:GetText() .. mrpTarget.Appearance.Description6);

					if (mrpTargetCharacterSheetTooltip:IsShown() and mrpTargetCharacterSheetTooltipTextLeft4:IsShown()) then
						mrpTargetCharacterSheetTooltip:AddLine(mrpTarget.Appearance.Description6, 1, 1, 1, 1);
						mrpTargetCharacterSheetTooltip:Show();
					end

					break;
				end
			end
		end
	end
end