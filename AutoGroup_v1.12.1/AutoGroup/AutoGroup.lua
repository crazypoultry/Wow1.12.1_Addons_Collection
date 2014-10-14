AutoGroupOptions = {};
local gotVariables = false;
local gotPlayerName = false;
local Realm;
local Player;
AUTOGROUP_RightPopups = {"PARTY_INVITE"};
	
local function AutoGroup_InitializeSetup()
	Player=UnitName("player");	
	Realm=GetCVar("realmName");
	
	if AutoGroupOptions[Realm] == nil then
		AutoGroupOptions[Realm] = {}
	end

	if AutoGroupOptions[Realm][Player] == nil then
		AutoGroupOptions[Realm][Player] = {};
		AutoGroupOptions[Realm][Player].Enabled = true;
	end

	if (AutoGroupOptions[Realm][Player].Mode == nil) then
		AutoGroupOptions[Realm][Player].Mode = 'none';
	end
	
	if (AutoGroupOptions[Realm][Player].DeclineMode == nil) then
		AutoGroupOptions[Realm][Player].DeclineMode = 'none';
	end;
	
	if (AutoGroupOptions[Realm][Player].GuildList ~= nil) then
		AutoGroupOptions[Realm][Player].GuildList = nil;
	end;	
end;

function AutoGroup_OnLoad()
	this:RegisterEvent("PARTY_INVITE_REQUEST");
	--this:RegisterEvent("GUILD_ROSTER_SHOW");
	--this:RegisterEvent("GUILD_ROSTER_UPDATE");
	--this:RegisterEvent("PLAYER_GUILD_UPDATE");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	AutoGroup_Version = "AutoGroup v1.12.1";
	SlashCmdList["AutoGroup"] = AutoGroup_SlashHandler;
	SLASH_AutoGroup1 = "/AutoGroup";
	SLASH_AutoGroup2 = "/AG";
	DEFAULT_CHAT_FRAME:AddMessage(AutoGroup_Version);
	DEFAULT_CHAT_FRAME:AddMessage(AG_HELP_ONLOAD);
end

function AutoGroup_OnEvent(event)
	if (event == "PLAYER_ENTERING_WORLD") then
		AutoGroup_InitializeSetup();
	end;

	if (event == 'PARTY_INVITE_REQUEST') then
		if (AutoGroupOptions[Realm][Player].Enabled ) then
			if AutoGroup_WontGroup(arg1) then
				DeclineGroup();
				for index = 1, STATICPOPUP_NUMDIALOGS, 1 do
					local frame = getglobal("StaticPopup"..index);
					if( frame:IsVisible() and (AutoGroup_IsRightPopup(frame.which) ) ) then 
						frame:Hide();
					end	
				end
				if (AutoGroupOptions[Realm][Player].DeclineWhisper ) then
					SendChatMessage(AutoGroupOptions[Realm][Player].DeclineWhisper , "WHISPER", DEFAULT_CHAT_FRAME.language, arg1);
				end
				if (AutoGroupOptions[Realm][Player].DeclineEmote ) then
					if (string.upper(ag_Split(AutoGroupOptions[Realm][Player].DeclineEmote)[1]) == "EM") then
						SendChatMessage(AutoGroup_MakePhrase(ag_Split(AutoGroupOptions[Realm][Player].DeclineEmote), 2) , "EMOTE", DEFAULT_CHAT_FRAME.language, arg1)
					else
						DoEmote(AutoGroupOptions[Realm][Player].DeclineEmote ,arg1);
					end
				end
				DEFAULT_CHAT_FRAME:AddMessage(AG_AUTO_DECLINE .. arg1);
			elseif AutoGroup_WillGroup(arg1) then
				AcceptGroup();
				for index = 1, STATICPOPUP_NUMDIALOGS, 1 do
					local frame = getglobal("StaticPopup"..index);
					if( frame:IsVisible() and (AutoGroup_IsRightPopup(frame.which) ) ) then 
						frame:Hide();
					end	
				end
				if (AutoGroupOptions[Realm][Player].Whisper ) then
					SendChatMessage(AutoGroupOptions[Realm][Player].Whisper , "WHISPER", DEFAULT_CHAT_FRAME.language, arg1);
				end
				if (AutoGroupOptions[Realm][Player].Emote ) then
					if (string.upper(ag_Split(AutoGroupOptions[Realm][Player].Emote)[1]) == "EM") then
						SendChatMessage(AutoGroup_MakePhrase(ag_Split(AutoGroupOptions[Realm][Player].Emote), 2) , "EMOTE", DEFAULT_CHAT_FRAME.language, arg1)
					else
						DoEmote(AutoGroupOptions[Realm][Player].Emote ,arg1);
					end
				end
				DEFAULT_CHAT_FRAME:AddMessage(AG_AUTO_ACCEPT .. arg1);
			end
		end
	end
end

function AutoGroup_SlashHandler(msg)

	if (msg == '') then msg = nil end
	
	if msg then
		local command = ag_Split(msg, " ")
		local current = string.lower(command[1]);
		if (command[2] == '') then
			command[2] = nil;
		end
	
		if (current == 'accept') then	
			if (command[2] == 'all') then
				AutoGroupOptions[Realm][Player].Mode = 'all';	
				DEFAULT_CHAT_FRAME:AddMessage(AG_ALL_MODE);
			end
			if (command[2] == 'friend') then
				AutoGroupOptions[Realm][Player].Mode = 'friend';
				DEFAULT_CHAT_FRAME:AddMessage(AG_FRIEND_MODE);
			end
			if (command[2] == 'guild') and (IsInGuild()) then
				AutoGroupOptions[Realm][Player].Mode = 'guild';
				DEFAULT_CHAT_FRAME:AddMessage(AG_GUILD_MODE);
				--if (AutoGroupOptions[Realm][Player].GuildList == nil) and (IsInGuild()) then
				--	DEFAULT_CHAT_FRAME:AddMessage(AG_GUILD_POPULATE);
				--	GuildRoster();
				--end		
			end
			if (command[2] == 'both') and (IsInGuild()) then
				AutoGroupOptions[Realm][Player].Mode = 'both';
				DEFAULT_CHAT_FRAME:AddMessage(AG_BOTH_MODE);
				--if (AutoGroupOptions[Realm][Player].GuildList == nil) and (IsInGuild()) then
				--	DEFAULT_CHAT_FRAME:AddMessage(AG_GUILD_POPULATE);
				--	GuildRoster();
				--end	
			end
			if ((command[2] == 'guild') or (command[2] == 'both')) and not (IsInGuild()) then
				DEFAULT_CHAT_FRAME:AddMessage(AG_NOT_GUILDED);
			end
			if (command[2] == 'none') then
				AutoGroupOptions[Realm][Player].Mode = 'none';
				DEFAULT_CHAT_FRAME:AddMessage(AG_NONE_MODE);
			end
			
			if (command[2] == 'emote') then
				if (command[3]==nil) then
					AutoGroupOptions[Realm][Player].Emote  = false;
					DEFAULT_CHAT_FRAME:AddMessage(AG_EMOTE_DISABLED);
				else
					AutoGroupOptions[Realm][Player].Emote  = AutoGroup_MakePhrase(command, 3);
					DEFAULT_CHAT_FRAME:AddMessage(AG_EMOTE_ENABLED.."("..AutoGroupOptions[Realm][Player].Emote ..")");
					if (AutoGroupOptions[Realm][Player].Enabled ==false) then
						AutoGroupOptions[Realm][Player].Enabled  = true;
						DEFAULT_CHAT_FRAME:AddMessage(AG_ENABLED);
					end
				end
			end
		
			if (command[2] == 'whisper') then
				if (command[3]==nil) then
					AutoGroupOptions[Realm][Player].Whisper  = false;
					DEFAULT_CHAT_FRAME:AddMessage(AG_WHISPER_DISABLED);
				
				else
					AutoGroupOptions[Realm][Player].Whisper  = AutoGroup_MakePhrase(command, 3);
					DEFAULT_CHAT_FRAME:AddMessage(AG_WHISPER_ENABLED.."("..AutoGroupOptions[Realm][Player].Whisper ..")");
					if (AutoGroupOptions[Realm][Player].Enabled ==false) then
						AutoGroupOptions[Realm][Player].Enabled  = true;
						DEFAULT_CHAT_FRAME:AddMessage(AG_ENABLED);
					end
				end
			end
			if (command[2] == 'help') then
				DEFAULT_CHAT_FRAME:AddMessage(AG_HELP_LINE6);
				DEFAULT_CHAT_FRAME:AddMessage(AG_HELP_LINE7);
				DEFAULT_CHAT_FRAME:AddMessage(AG_HELP_LINE8);
				DEFAULT_CHAT_FRAME:AddMessage(AG_HELP_LINE9);
				DEFAULT_CHAT_FRAME:AddMessage(AG_HELP_LINE10);
				DEFAULT_CHAT_FRAME:AddMessage(AG_HELP_LINE11);
				DEFAULT_CHAT_FRAME:AddMessage(AG_HELP_LINE12);
				DEFAULT_CHAT_FRAME:AddMessage(AG_HELP_LINE13);
				DEFAULT_CHAT_FRAME:AddMessage(AG_HELP_LINE14);			
				DEFAULT_CHAT_FRAME:AddMessage(AG_HELP_LINE15);
				DEFAULT_CHAT_FRAME:AddMessage(AG_HELP_LINE16);
			end
		end

		if (current == 'decline') then
			if (command[2] == 'all') then
				AutoGroupOptions[Realm][Player].DeclineMode = 'all';	
				DEFAULT_CHAT_FRAME:AddMessage(AG_ALL_DECLINE_MODE);
			end
			if (command[2] == 'nonfriend') then
				AutoGroupOptions[Realm][Player].DeclineMode = 'nonfriend';
				DEFAULT_CHAT_FRAME:AddMessage(AG_NONFRIEND_DECLINE_MODE);
			end
			if (command[2] == 'none') then
				AutoGroupOptions[Realm][Player].DeclineMode = 'none';
				DEFAULT_CHAT_FRAME:AddMessage(AG_NONE_DECLINE_MODE);
			end
			if (command[2] == 'nonguild')and (IsInGuild())  then
				AutoGroupOptions[Realm][Player].DeclineMode = 'nonguild';
				DEFAULT_CHAT_FRAME:AddMessage(AG_NONGUILD_DECLINE_MODE);
				--if (AutoGroupOptions[Realm][Player].GuildList == nil) then
				--	DEFAULT_CHAT_FRAME:AddMessage(AG_GUILD_POPULATE);
				--	GuildRoster();
				--end	
			end
			if (command[2] == 'both') and (IsInGuild())  then
				AutoGroupOptions[Realm][Player].DeclineMode = 'both';
				DEFAULT_CHAT_FRAME:AddMessage(AG_BOTH_DECLINE_MODE);
				--if (AutoGroupOptions[Realm][Player].GuildList == nil) then
				--	DEFAULT_CHAT_FRAME:AddMessage(AG_GUILD_POPULATE);
				--	GuildRoster();			
				--end	
			end
			if ((command[2] == 'nonguild') or (command[2] == 'both')) and not (IsInGuild()) then
				DEFAULT_CHAT_FRAME:AddMessage(AG_NOT_GUILDED);
			end
			if (command[2] == 'emote') then
				if (command[3]==nil) then
					AutoGroupOptions[Realm][Player].DeclineEmote  = false;
					DEFAULT_CHAT_FRAME:AddMessage(AG_DECLINE_EMOTE_DISABLED);
				else
					AutoGroupOptions[Realm][Player].DeclineEmote  = AutoGroup_MakePhrase(command, 3);
					DEFAULT_CHAT_FRAME:AddMessage(AG_DECLINE_EMOTE_ENABLED.."("..AutoGroupOptions[Realm][Player].DeclineEmote ..")");
					if (AutoGroupOptions[Realm][Player].Enabled == false) then
						AutoGroupOptions[Realm][Player].Enabled  = true;
						DEFAULT_CHAT_FRAME:AddMessage(AG_ENABLED);
					end
				end
			end
			if (command[2] == 'whisper') then
				if (command[3]==nil) then
					AutoGroupOptions[Realm][Player].DeclineWhisper  = false;
					DEFAULT_CHAT_FRAME:AddMessage(AG_DECLINE_WHISPER_DISABLED);
				else
					AutoGroupOptions[Realm][Player].DeclineWhisper  = AutoGroup_MakePhrase(command, 3);
					DEFAULT_CHAT_FRAME:AddMessage(AG_DECLINE_WHISPER_ENABLED.."("..AutoGroupOptions[Realm][Player].DeclineWhisper ..")");
					if (AutoGroupOptions[Realm][Player].Enabled ==false) then
						AutoGroupOptions[Realm][Player].Enabled  = true;
						DEFAULT_CHAT_FRAME:AddMessage(AG_ENABLED);
					end
				end
			end			
			if (command[2] == 'help') then
			DEFAULT_CHAT_FRAME:AddMessage(AG_HELP_LINE17);
			DEFAULT_CHAT_FRAME:AddMessage(AG_HELP_LINE18);
			DEFAULT_CHAT_FRAME:AddMessage(AG_HELP_LINE19);
			DEFAULT_CHAT_FRAME:AddMessage(AG_HELP_LINE20);
			DEFAULT_CHAT_FRAME:AddMessage(AG_HELP_LINE21);
			DEFAULT_CHAT_FRAME:AddMessage(AG_HELP_LINE22);
			DEFAULT_CHAT_FRAME:AddMessage(AG_HELP_LINE23);
			DEFAULT_CHAT_FRAME:AddMessage(AG_HELP_LINE24);
			DEFAULT_CHAT_FRAME:AddMessage(AG_HELP_LINE25);
			DEFAULT_CHAT_FRAME:AddMessage(AG_HELP_LINE26);
			DEFAULT_CHAT_FRAME:AddMessage(AG_HELP_LINE27);
			end
		end

		if (current == 'on') then
			AutoGroupOptions[Realm][Player].Enabled  = true;
			DEFAULT_CHAT_FRAME:AddMessage(AG_ENABLED);
		end

		if (current == 'off') then
			AutoGroupOptions[Realm][Player].Enabled  = false;
			DEFAULT_CHAT_FRAME:AddMessage(AG_DISABLED);
		end

		if (current == 'status') then
			AutoGroup_ShowStatus();
		end

		if (current == 'help') then
			DEFAULT_CHAT_FRAME:AddMessage(AutoGroup_Version);
			DEFAULT_CHAT_FRAME:AddMessage(AG_HELP_LINE1);
			DEFAULT_CHAT_FRAME:AddMessage(AG_HELP_LINE2);
			DEFAULT_CHAT_FRAME:AddMessage(AG_HELP_LINE3);
			DEFAULT_CHAT_FRAME:AddMessage(AG_HELP_LINE4);
			DEFAULT_CHAT_FRAME:AddMessage(AG_HELP_LINE5);
		end
				
	else
		DEFAULT_CHAT_FRAME:AddMessage(AutoGroup_Version);
		AutoGroup_ShowStatus();
		DEFAULT_CHAT_FRAME:AddMessage(AG_VALID_PARAMETERS);
	end
end



function AutoGroup_ShowStatus()
	if (AutoGroupOptions[Realm][Player].Enabled ) then
		DEFAULT_CHAT_FRAME:AddMessage(AG_STATUS_ON);
		if (AutoGroupOptions[Realm][Player].Mode == 'friend') then
			DEFAULT_CHAT_FRAME:AddMessage(AG_FRIEND_MODE);
		end
		if (AutoGroupOptions[Realm][Player].Mode == 'all') then
			DEFAULT_CHAT_FRAME:AddMessage(AG_ALL_MODE);
		end
		if (AutoGroupOptions[Realm][Player].Mode == 'guild') then
			DEFAULT_CHAT_FRAME:AddMessage(AG_GUILD_MODE);
		end
		if (AutoGroupOptions[Realm][Player].Mode == 'both') then
			DEFAULT_CHAT_FRAME:AddMessage(AG_BOTH_MODE);
		end		
		if (AutoGroupOptions[Realm][Player].Mode == 'none') then
			DEFAULT_CHAT_FRAME:AddMessage(AG_NONE_MODE);
		end
		if (AutoGroupOptions[Realm][Player].DeclineMode == 'all') then
			DEFAULT_CHAT_FRAME:AddMessage(AG_ALL_DECLINE_MODE);
		end
		if (AutoGroupOptions[Realm][Player].DeclineMode == 'nonfriend') then
			DEFAULT_CHAT_FRAME:AddMessage(AG_NONFRIEND_DECLINE_MODE);
		end
		if (AutoGroupOptions[Realm][Player].DeclineMode == 'nonguild') then
			DEFAULT_CHAT_FRAME:AddMessage(AG_NONGUILD_DECLINE_MODE);
		end
		if (AutoGroupOptions[Realm][Player].DeclineMode == 'both') then
			DEFAULT_CHAT_FRAME:AddMessage(AG_BOTH_DECLINE_MODE);
		end
		if (AutoGroupOptions[Realm][Player].DeclineMode == 'none') then
			DEFAULT_CHAT_FRAME:AddMessage(AG_NONE_DECLINE_MODE);
		end		
		if (AutoGroupOptions[Realm][Player].Emote ) then
			DEFAULT_CHAT_FRAME:AddMessage(AG_STATUS_EMOTE_ON.." ("..AutoGroupOptions[Realm][Player].Emote ..")");
		else
			DEFAULT_CHAT_FRAME:AddMessage(AG_STATUS_EMOTE_OFF);
		end
		if (AutoGroupOptions[Realm][Player].Whisper ) then
			DEFAULT_CHAT_FRAME:AddMessage(AG_STATUS_WHISPER_ON.." ("..AutoGroupOptions[Realm][Player].Whisper ..")");
		else
			DEFAULT_CHAT_FRAME:AddMessage(AG_STATUS_WHISPER_OFF);
		end
		if (AutoGroupOptions[Realm][Player].DeclineEmote ) then
			DEFAULT_CHAT_FRAME:AddMessage(AG_STATUS_DECLINE_EMOTE_ON.." ("..AutoGroupOptions[Realm][Player].DeclineEmote ..")");
		else
			DEFAULT_CHAT_FRAME:AddMessage(AG_STATUS_DECLINE_EMOTE_OFF);
		end
		if (AutoGroupOptions[Realm][Player].DeclineWhisper ) then
			DEFAULT_CHAT_FRAME:AddMessage(AG_STATUS_DECLINE_WHISPER_ON.." ("..AutoGroupOptions[Realm][Player].DeclineWhisper ..")");
		else
			DEFAULT_CHAT_FRAME:AddMessage(AG_STATUS_DECLINE_WHISPER_OFF);
		end

	else
		DEFAULT_CHAT_FRAME:AddMessage(AG_STATUS_OFF);
	end
end

function ag_Split(toCut, separator)
	local splitted = {};
	local i = 0;
	if (separator == nil) then
		 separator = " ";
	end
	local regEx = "([^" .. separator .. "]*)" .. separator .. "?";

	for item in string.gfind(toCut .. separator, regEx) do
		i = i + 1;
		splitted[i] = ag_Trim(item) or '';
	end
	splitted[i] = nil;
	return splitted;
end

function ag_Trim (s)
	return (string.gsub(s, "^%s*(.-)%s*$", "%1"));
end

function AutoGroup_IsGuildMember(ch)
	local IsGuild = false;
	local i;
	local OldShowOffline = GetGuildRosterShowOffline();
	SetGuildRosterShowOffline(true);
	GuildRoster();
	for i = 1, GetNumGuildMembers() do
		if GetGuildRosterInfo(i) == ch then
			IsGuild = true;
			break;
		end
	end
	SetGuildRosterShowOffline(OldShowOffline);
	return IsGuild;
end

function AutoGroup_IsFriend(ch)
	local NumFriends = GetNumFriends();
	local IsFriend = false;

	for i = 1, NumFriends do
		if GetFriendInfo(i) == ch then
			IsFriend = true;
			break;
		end
	end
	return IsFriend;
end

function AutoGroup_IsRightPopup(which)
	local isRightPopup = false;
	for k, v in AUTOGROUP_RightPopups do
		if ( which == v ) then
			isRightPopup = true;
			break;
		end
	end
	return isRightPopup;
end

function AutoGroup_WillGroup(ch)
	local DoGroup = false;
	if (AutoGroupOptions[Realm][Player].Mode == 'all') or
		((AutoGroupOptions[Realm][Player].Mode == 'guild' or AutoGroupOptions[Realm][Player].Mode == 'both') and AutoGroup_IsGuildMember(ch)) or
		((AutoGroupOptions[Realm][Player].Mode == 'friend' or AutoGroupOptions[Realm][Player].Mode == 'both') and AutoGroup_IsFriend(ch)) then
		DoGroup = true;
	end
	return DoGroup;
end

function AutoGroup_WontGroup(ch)
	local DontGroup = false;
	if (AutoGroupOptions[Realm][Player].DeclineMode == 'all') or
		((AutoGroupOptions[Realm][Player].DeclineMode == 'nonguild') and not (AutoGroup_IsGuildMember(ch))) or
		((AutoGroupOptions[Realm][Player].DeclineMode == 'nonfriend') and not (AutoGroup_IsFriend(ch))) or
		((AutoGroupOptions[Realm][Player].DeclineMode == 'both') and not (AutoGroup_IsGuildMember(ch) or AutoGroup_IsFriend(ch))) then
		DontGroup = true;
	end
	return DontGroup;
end

function AutoGroup_MakePhrase(list, StartIndex)
	local phrase = list[StartIndex];
	for i = StartIndex + 1, table.getn(list), 1 do
		phrase = phrase .. " " .. list[i];
	end
	return phrase;
end