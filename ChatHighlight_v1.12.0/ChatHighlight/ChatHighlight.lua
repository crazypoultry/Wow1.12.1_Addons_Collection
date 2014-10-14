-- ChatHighlight by Link

local VERSION = "1.12.0";
local RELEASEDATE = "October 11, 2006";
local CONFIGVERSION = 4;
local Original_ChatFrame_OnEvent;
KEYWORDS = {};
LOG = "\n";
local soundFile = "Sound/Event Sounds/Wisp/WispYes2.wav";

UIPanelWindows["ChatHighlightLog"] = { area = "left", pushable = 5 };

-- myAddons support variables
ChatHighlightDetails = {
	name = "ChatHighlight",
	description = "Highlights chat that contains player name and a list of keywords",
	version = VERSION,
	releaseDate = RELEASEDATE,
	author = "Link Dupont",
	email = "link.dupont@gmail.com",
	website = "http://link.stikipad.com/wiki/show/WowAddOns",
	category = MYADDONS_CATEGORY_CHAT,
	frame = "ChatHighlightFrame",
	optionsframe = "ChatHighlightOptions"
};

function ChatHighlight_OnLoad()
	SLASH_CHATHIGHLIGHT1 = "/chathighlight";
	SLASH_CHATHIGHLIGHT2 = "/ch";
	SlashCmdList["CHATHIGHLIGHT"] = ChatHighlight_SlashCmd;

	if(string.find(VERSION, "UNSTABLE$") or string.find(VERSION, "BETA$")) then
		SLASH_CHATHIGHLIGHTDATA1 = "/chathighlightdata";
		SLASH_CHATHIGHLIGHTDATA2 = "/chdata";
		SlashCmdList["CHATHIGHLIGHTDATA"] = ChatHighlight_DataSlashCmd;
	end

	this:RegisterEvent("VARIABLES_LOADED");

	ChatFrame_OnEvent_Old = ChatFrame_OnEvent;
	ChatFrame_OnEvent = ChatHighlight_ChatFrame_OnEvent;
	
	if ( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage("ChatHighlight " .. VERSION .. " loaded.");
	end
end

--Stolen from TextFilter.lua
function TextFilter_CanFilter(event)
	chatEvents = {
		--possible filtered events
		"CHAT_MSG_SAY",
		"CHAT_MSG_YELL",
		"CHAT_MSG_PARTY",
		"CHAT_MSG_RAID",
		"CHAT_MSG_WHISPER",
		"CHAT_MSG_WHISPER_INFORM",
		"CHAT_MSG_EMOTE",
		"CHAT_MSG_TEXT_EMOTE",
		"CHAT_MSG_GUILD",
		"CHAT_MSG_OFFICER",
		"GUILD_MOTD",
		"CHAT_MSG_CHANNEL",
	};
	for key,value in chatEvents do
		if(event == value) then
			return true;
		end
	end
	return false;
end

function ChatHighlight_CheckIncoming(arg1)
   	warnings = {
		"inc",
		"incoming",
		"add",
		"adds",
		"roamer",
		"patrol",
	};
	for key,value in warnings do
		if(arg1 == value) then
			return true;
		end
	end
	return false;
end

function ChatHighlight_AddMessage(this, msg, r, g, b, id)
	local matched;
	if(TextFilter_CanFilter(event) and (arg2 ~= UnitName("player")))  then
		if(ChatHighlightSettings["EnableNick"] == 1 ) then
			if(ChatHighlightSettings["CaseSensitive"] == 1) then -- We don't want to normalize the text
				if(string.find(msg, UnitName("player"))) then
					r = ChatHighlightSettings["Color"]["R"];
					g = ChatHighlightSettings["Color"]["G"];
					b = ChatHighlightSettings["Color"]["B"];
					matched = true;
				end
			else -- Case insensitive, normalize the text
				if(string.find(string.lower(msg), string.lower(UnitName("player")))) then
					r = ChatHighlightSettings["Color"]["R"];
					g = ChatHighlightSettings["Color"]["G"];
					b = ChatHighlightSettings["Color"]["B"];
					matched = true;
				end
			end
		end

		-- Draw in the error frame if message is from a Raid leader
		if ( event == "CHAT_MSG_RAID" and ChatHighlightSettings["RaidMessages"] == 1) then
			showInErrorsFrame = false;
			for i = 1, GetNumRaidMembers(), 1 do
				local name, rank = GetRaidRosterInfo(i);
				if ( rank >= 1 and name == arg2 and ChatHighlightSettings["RaidLeader"] == 1) then
					showInErrorsFrame = true;
					r = ChatHighlightSettings["RaidColor"]["R"];
					g = ChatHighlightSettings["RaidColor"]["G"];
					b = ChatHighlightSettings["RaidColor"]["B"];
					matched = true;
				end
			end
			if (ChatHighlight_CheckIncoming(arg1) and alreadyDisplayed) then
				-- Draw in the error frame if message contains inc, patrol, etc. See CheckIncoming.
				showInErrorsFrame = true;
				r = ChatHighlightSettings["RaidColor"]["R"];
				g = ChatHighlightSettings["RaidColor"]["G"];
				b = ChatHighlightSettings["RaidColor"]["B"];
				matched = true;
			end

			if(showInErrorsFrame and ChatHighlightSettings["RaidPopup"] == 1) then
				UIErrorsFrame:AddMessage(msg, 1, 1, 1, 1.0, UIERRORS_HOLD_TIME);
			end
		end

		if(ChatHighlightSettings["Enabled"] == 1) then
			for key,needle in KEYWORDS do
				if(ChatHighlightSettings["CaseSensitive"] == 1) then
					if(string.find(msg, "[^%a]" .. needle .. "[^%a]") or string.find(msg, "[^%a]" .. needle .. "$")) then
						r = ChatHighlightSettings["Color"]["R"];
						g = ChatHighlightSettings["Color"]["G"];
						b = ChatHighlightSettings["Color"]["B"];
						matched = true;
					end
				else
					if(string.find(string.lower(msg), "[^%a]" .. string.lower(needle) .. "[^%a]") or string.find(string.lower(msg), "[^%a]" .. string.lower(needle) .. "$")) then
						r = ChatHighlightSettings["Color"]["R"];
						g = ChatHighlightSettings["Color"]["G"];
						b = ChatHighlightSettings["Color"]["B"];
						matched = true;
					end
				end
			end
		end

		if(ChatHighlightSettings.EnableLogging == 1 and matched) then
			local hour, minute = GetGameTime();
			if(minute <= 9) then
				minute = "0" .. minute;
			end
			LOG = LOG .. string.format("(%s:%s) [%s]: %s\n", hour, minute, arg2, arg1);
		end
	end

	if(ChatHighlightSettings.EnableSounds == 1 and matched) then
		PlaySoundFile(soundFile);
	end
	this:ChatHighlight_Original_AddMessage(msg, r, g, b, id);
end

function ChatHighlight_ChatFrame_OnEvent(event)
	if(not this.ChatHighlight_Original_AddMessage) then
		this.ChatHighlight_Original_AddMessage = this.AddMessage;
		this.AddMessage = ChatHighlight_AddMessage;
	end
	ChatFrame_OnEvent_Old(event);
end

function ChatHighlight_SlashCmd(cmd)
	if(cmd == "version") then
		DEFAULT_CHAT_FRAME:AddMessage("ChatHighlight version " .. VERSION);
		return;
	elseif(cmd == "config") then
		if ChatHighlightOptions:IsVisible() then
			HideUIPanel(ChatHighlightOptions);
		else
			ShowUIPanel(ChatHighlightOptions);
		end
		return;
	end
	
	if ChatHighlightLog:IsVisible() then
		HideUIPanel(ChatHighlightLog);
	else
		ShowUIPanel(ChatHighlightLog);
	end
end

function ChatHighlight_DataSlashCmd(cmd)
	if(cmd == "dump") then
		ChatHighlight_DumpSettings();
	elseif(cmd == "send") then
		ChatHighlight_SendSettings();
	end
end

function ChatHighlight_ConfigOnShow()
	ChatHighlightOptionsChatSettingsChatHighlighting:SetChecked(ChatHighlightSettings["Enabled"]);
	ChatHighlightOptionsChatSettingsNickHighlighting:SetChecked(ChatHighlightSettings["EnableNick"]);
	ChatHighlightOptionsChatSettingsCaseSensitive:SetChecked(ChatHighlightSettings["CaseSensitive"]);
	ChatHighlightOptionsChatSettingsSoundNotification:SetChecked(ChatHighlightSettings["EnableSounds"]);
	ChatHighlightOptionsChatSettingsLogging:SetChecked(ChatHighlightSettings["EnableLogging"]);
	
	ChatHighlightOptionsRaidSettingsRaidHighlighting:SetChecked(ChatHighlightSettings["RaidMessages"]);
	ChatHighlightOptionsRaidSettingsRaidLeader:SetChecked(ChatHighlightSettings["RaidLeader"]);
	ChatHighlightOptionsRaidSettingsRaidPopup:SetChecked(ChatHighlightSettings["RaidPopup"]);
	
	ChatHighlightOptionsKeywordsScrollFrameText:SetText(ChatHighlightSettings["Keywords"]);
	
	ChatHighlightOptionsColorsEditColorButtonNormalTexture:SetVertexColor(ChatHighlightSettings["Color"]["R"],ChatHighlightSettings["Color"]["G"],ChatHighlightSettings["Color"]["B"]);
	ChatHighlightOptionsColorsEditRaidColorButtonNormalTexture:SetVertexColor(ChatHighlightSettings["RaidColor"]["R"],ChatHighlightSettings["RaidColor"]["G"],ChatHighlightSettings["RaidColor"]["B"]);
end

function ChatHighlight_LogOnShow()
	ChatHighlightLogText:SetText(LOG);
end

function ChatHighlight_ClearLog()
	LOG = "\n";
	ChatHighlight_LogOnShow();
end

function ChatHighlight_ToggleChatHighlighting()
	if ( ChatHighlightSettings["Enabled"] == 1) then
		ChatHighlightSettings["Enabled"] = 0;
	else
		ChatHighlightSettings["Enabled"] = 1;
	end
end

function ChatHighlight_ToggleNickHighlighting()
	if ( ChatHighlightSettings["EnableNick"] == 1) then
		ChatHighlightSettings["EnableNick"] = 0;
	else
		ChatHighlightSettings["EnableNick"] = 1;
	end
end

function ChatHighlight_ToggleCaseSensitive()
	if ( ChatHighlightSettings["CaseSensitive"] == 1) then
		ChatHighlightSettings["CaseSensitive"] = 0;
	else
		ChatHighlightSettings["CaseSensitive"] = 1;
	end
end

function ChatHighlight_ToggleRaidHighlighting()
	if ( ChatHighlightSettings["RaidMessages"] == 1) then
		ChatHighlightSettings["RaidMessages"] = 0;
	else
		ChatHighlightSettings["RaidMessages"] = 1;
	end
end

function ChatHighlight_ToggleRaidLeader()
	if ( ChatHighlightSettings["RaidLeader"] == 1) then
		ChatHighlightSettings["RaidLeader"] = 0;
	else
		ChatHighlightSettings["RaidLeader"] = 1;
	end
end

function ChatHighlight_ToggleRaidPopup()
	if ( ChatHighlightSettings["RaidPopup"] == 1) then
		ChatHighlightSettings["RaidPopup"] = 0;
	else
		ChatHighlightSettings["RaidPopup"] = 1;
	end
end

function ChatHighlight_ToggleSoundNotification()
	if ( ChatHighlightSettings["EnableSounds"] == 1) then
		ChatHighlightSettings["EnableSounds"] = 0;
	else
		ChatHighlightSettings["EnableSounds"] = 1;
	end
end

function ChatHighlight_ToggleLogging()
	if ( ChatHighlightSettings["EnableLogging"] == 1) then
		ChatHighlightSettings["EnableLogging"] = 0;
	else
		ChatHighlightSettings["EnableLogging"] = 1;
	end
end

function ChatHighlight_LoadKeywords()
	ChatHighlightOptionsKeywords:SetText(ChatHighlightSettings["Keywords"]);
end

function ChatHighlight_UpdateKeywords()
	ChatHighlightSettings["Keywords"] = ChatHighlightOptionsKeywordsScrollFrameText:GetText();
	KEYWORDS = {};
	for v in string.gfind(ChatHighlightSettings["Keywords"],"[^%s]+") do
		table.insert(KEYWORDS, v);
	end
end

function ChatHighlight_SetColor()
	local r, g, b = ColorPickerFrame:GetColorRGB();
	ChatHighlightSettings.Color["R"] = r;
	ChatHighlightSettings.Color["G"] = g;
	ChatHighlightSettings.Color["B"] = b;
	ChatHighlightColorFrame.r = r;
	ChatHighlightColorFrame.g = g;
	ChatHighlightColorFrame.b = b;

	ChatHighlightOptionsColorsEditColorButtonNormalTexture:SetVertexColor(r, g, b);
end

function ChatHighlight_ShowColorPicker(frame)
	frame.r = ChatHighlightSettings.Color["R"];
	frame.g = ChatHighlightSettings.Color["G"];
	frame.b = ChatHighlightSettings.Color["B"];
	frame.opacity = 1.0;
	frame.opacityFunc = nil;
	frame.swatchFunc = ChatHighlight_SetColor;
	frame.hasOpacity = 0;
	UIDropDownMenuButton_OpenColorPicker(frame);
end

function ChatHighlight_SetRaidColor()
	local r, g, b = ColorPickerFrame:GetColorRGB();
	ChatHighlightSettings.RaidColor["R"] = r;
	ChatHighlightSettings.RaidColor["G"] = g;
	ChatHighlightSettings.RaidColor["B"] = b;
	ChatHighlightColorFrame.r = r;
	ChatHighlightColorFrame.g = g;
	ChatHighlightColorFrame.b = b;

	ChatHighlightOptionsColorsEditRaidColorButtonNormalTexture:SetVertexColor(r, g, b);
end

function ChatHighlight_ShowRaidColorPicker(frame)
	frame.r = ChatHighlightSettings.RaidColor["R"];
	frame.g = ChatHighlightSettings.RaidColor["G"];
	frame.b = ChatHighlightSettings.RaidColor["B"];
	frame.opacity = 1.0;
	frame.opacityFunc = nil;
	frame.swatchFunc = ChatHighlight_SetRaidColor;
	frame.hasOpacity = 0;
	UIDropDownMenuButton_OpenColorPicker(frame);
end

function ChatHighlight_OnEvent()
	if ( event == "VARIABLES_LOADED" ) then
		if ( not ChatHighlightSettings ) then
			ChatHighlightSettings = {
				["Version"] = CONFIGVERSION,-- Internal config version to enable proper upgrading
				["Enabled"] = 1,            -- Whether to highlight on any keywords or player name
				["EnableNick"] = 1,         -- Whether to highlight on player name or not
				["Color"] = {               -- Highlight color
					["R"] = "0.0",      -- The Red component
					["G"] = "1.0",      -- The Green component
					["B"] = "1.0",      -- The Blue component
				},
				["RaidColor"] = {           -- Raid highlight color
					["R"] = "0.0",      -- The Red component
					["G"] = "0.0",      -- The Green component
					["B"] = "1.0",      -- The Blue component
				},
				["Keywords"] = "LFG WTS",   -- A space-separated string of keywords
				["CaseSensitive"] = 1,      -- Case sensitivity in matching
				["RaidMessages"] = 0,       -- Raid messages like inc, patrol, add, etc
				["RaidLeader"] = 0,         -- Highlight raid leader messages
				["RaidPopup"] = 0,          -- Display raid text in UIErrors
				["EnableSounds"] = 0,       -- Added sound notification
				["EnableLogging"] = 1,      -- Log matches within a session
			}
		end
		if ( not ChatHighlightSettings["Version"]) then -- Handle upgrade from versionless config
			ChatHighlightSettings["CaseSensitive"] = 1;
			ChatHighlightSettings["RaidMessages"] = 1;
			ChatHighlightSettings["Version"] = CONFIGVERSION;
			ChatHighlightSettings["RaidColor"] = {
				["R"] = "0.0",
				["G"] = "0.0",
				["B"] = "1.0",
			};
			ChatHighlightSettings["RaidLeader"] = 0;
			ChatHighlightSettings["RaidPopup"] = 0;
			ChatHighlightSettings["EnableLogging"] = 1;
		end

		if( ChatHighlightSettings["Version"] == 2) then -- Upgrade from Version 2
			ChatHighlightSettings["Version"] = CONFIGVERSION;
			ChatHighlightSettings["EnableSounds"] = 0;
			ChatHighlightSettings["RaidLeader"] = 0;
			ChatHighlightSettings["RaidPopup"] = 0;
			ChatHighlightSettings["EnableLogging"] = 1;
		end

		if( ChatHighlightSettings["Version"] == 3) then
			ChatHighlightSettings["Version"] = CONFIGVERSION;
			ChatHighlightSettings["RaidLeader"] = 0;
			ChatHighlightSettings["RaidPopup"] = 0;
			ChatHighlightSettings["EnableLogging"] = 1;
		end

		KEYWORDS = {};
		for v in string.gfind(ChatHighlightSettings["Keywords"],"[^%s]+") do
			table.insert(KEYWORDS, v);
		end

		-- Register the addon in myAddOns
		if(myAddOnsFrame_Register) then
			myAddOnsFrame_Register(ChatHighlightDetails, nil);
		end
		
	end
end

function ChatHighlight_DumpSettings()
	DEFAULT_CHAT_FRAME:AddMessage("ChatHighlightSettings.Enabled = " .. string.format("%i", ChatHighlightSettings.Enabled));
	DEFAULT_CHAT_FRAME:AddMessage("ChatHighlightSettings.EnableNick = " .. string.format("%i", ChatHighlightSettings.EnableNick));
	DEFAULT_CHAT_FRAME:AddMessage("ChatHighlightSettings.Keywords = " .. ChatHighlightSettings.Keywords);
	DEFAULT_CHAT_FRAME:AddMessage("ChatHighlightSettings.CaseSensitive = " .. string.format("%i", ChatHighlightSettings.CaseSensitive));
	DEFAULT_CHAT_FRAME:AddMessage("ChatHighlightSettings.RaidMessages = " .. string.format("%i", ChatHighlightSettings.RaidMessages));
	DEFAULT_CHAT_FRAME:AddMessage("ChatHighlightSettings.Color = " .. string.format("%f,%f,%f", ChatHighlightSettings.Color["R"],ChatHighlightSettings.Color["G"],ChatHighlightSettings.Color["B"]));
	DEFAULT_CHAT_FRAME:AddMessage("ChatHighlightSettings.Version = " .. string.format("%i", ChatHighlightSettings.Version));
	DEFAULT_CHAT_FRAME:AddMessage("ChatHighlightSettings.EnableSounds = " .. string.format("%i", ChatHighlightSettings.EnableSounds));

	for v in string.gfind(ChatHighlightSettings["Keywords"],"[^%s]+") do
		DEFAULT_CHAT_FRAME:AddMessage(v);
	end
end

function ChatHighlight_SendSettings()
	SendChatMessage("ChatHighlightSettings.Enabled = " .. string.format("%i", ChatHighlightSettings.Enabled), "WHISPER","Common","Altariel");
	SendChatMessage("ChatHighlightSettings.EnableNick = " .. string.format("%i", ChatHighlightSettings.EnableNick), "WHISPER","Common","Altariel");
	SendChatMessage("ChatHighlightSettings.Keywords = " .. ChatHighlightSettings.Keywords, "WHISPER","Common","Altariel");
	SendChatMessage("ChatHighlightSettings.CaseSensitive = " .. string.format("%i", ChatHighlightSettings.CaseSensitive), "WHISPER","Common","Altariel");
	SendChatMessage("ChatHighlightSettings.RaidMessages = " .. string.format("%i", ChatHighlightSettings.RaidMessages), "WHISPER","Common","Altariel");
	SendChatMessage("ChatHighlightSettings.Color = " .. string.format("%f,%f,%f", ChatHighlightSettings.Color["R"],ChatHighlightSettings.Color["G"],ChatHighlightSettings.Color["B"]), "WHISPER","Common","Altariel");
	SendChatMessage("ChatHighlightSettings.Version = " .. string.format("%i", ChatHighlightSettings.Version), "WHISPER","Common","Altariel");
	SendChatMessage("ChatHighlightSettings.EnableSounds = " .. string.format("%i", ChatHighlightSettings.EnableSounds), "WHISPER","Common","Altariel");
end
