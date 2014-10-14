
NURFED_GENERAL_VERS = "07.06.2006";

NURFED_GENERAL_DEFAULT = {
	repair = 1,
	repairinv = 1,
	repairlimit = 20,
	ping = 1,
	traineravailable = 1,
	timestamps = 1,
	timeoffset = 0,
	ampm = 1,
	raidgroup = 1,
	raidclass = 1,
	hidechat = 1,
	chatfade = 1,
	chatfadetime = 120,
	autoinvite = 1,
	chatprefix = 1,
	keyword = "invite",
	timestampsformat = "[%#I:%M:%S]",
};

ChatTypeInfo["CHANNEL"].sticky = 1;
ChatTypeInfo["OFFICER"].sticky = 1;
ManaBarColor[0] = { r = 0.00, g = 1.00, b = 1.00, prefix = TEXT(MANA) };

local utility = Nurfed_Utility:New();
local unitlib = Nurfed_Units:New();
local framelib = Nurfed_Frames:New();
local lib = Nurfed_General:New();
local lastinvite = nil;
local afkstring = utility:FormatGS(RAID_MEMBERS_AFK, true);
local pingflood = {};
local raidtarget = {
	[RAID_TARGET_1] = 1,
	[RAID_TARGET_2] = 2,
	[RAID_TARGET_3] = 3,
	[RAID_TARGET_4] = 4,
	[RAID_TARGET_5] = 5,
	[RAID_TARGET_6] = 6,
	[RAID_TARGET_7] = 7,
	[RAID_TARGET_8] = 8,
};

for _, v in UIOptionsFrameSliders do
	if (v.text == MAX_FOLLOW_DIST) then
		v.maxValue = 3.4;
		v.tooltipText = OPTION_TOOLTIP_MAX_FOLLOW_DIST.."\n"
	end
end

--------------------------------------------------------------------------------------------------
--				Slash Commands
--------------------------------------------------------------------------------------------------

SLASH_NURFEDEQUIP1 = "/nequip";
SlashCmdList["NURFEDEQUIP"] = function(msg)
	lib:itemswitch(msg);
end

SLASH_NURFEDWHISPER1 = "/wtar";
SlashCmdList["NURFEDWHISPER"] = function(msg)
	if (UnitExists("target")) then
		SendChatMessage(msg, "WHISPER", this.language, UnitName("target"));
	end
end

SLASH_NURFEDRAIDTARGET1 = "/rtar";
SlashCmdList["NURFEDRAIDTARGET"] = function(msg)
	Nurfed_RaidTarget(msg);
end

SLASH_NURFEDRAIDTARGETCLEAR1 = "/rtarclear";
SlashCmdList["NURFEDRAIDTARGETCLEAR"] = function()
	for i = 1, GetNumRaidMembers() do
		local unit = "raid"..i;
		if (UnitExists(unit) and GetRaidTargetIndex(unit)) then
			SetRaidTarget(unit, 0)
		end
	end
end

--------------------------------------------------------------------------------------------------
--	Put a -- in front of DAMAGE_TEXT_FONT to change back the damage font (cannot be in game).
--------------------------------------------------------------------------------------------------

DAMAGE_TEXT_FONT = "Fonts\\skurri.ttf";

--------------------------------------------------------------------------------------------------
--				Chat Frame Functions
--------------------------------------------------------------------------------------------------


local function Nurfed_AddMessage(this, msg, r, g, b, id)
	if (msg) then
		local prefix = utility:GetOption("general", "chatprefix");
		local text = {};
		if(utility:GetOption("general", "timestamps") == 1) then
			local ts = utility:GetOption("general", "timestampsformat");
			local timestamp = date(ts);
			table.insert(text, timestamp);
		end

		if (string.find(msg, "["..CHAT_MSG_RAID.."]", 1, true) or string.find(msg, "["..CHAT_MSG_RAID_LEADER.."]", 1, true)) then
			local info = unitlib:GetUnit(arg2);
			if (info) then
				msg = string.gsub(msg, "%["..RAID.."%] ", "");
				msg = string.gsub(msg, "%["..CHAT_MSG_RAID_LEADER.."%] ", "");
				if (prefix == 1) then
					if (info.r == 2) then
						table.insert(text, "["..CHAT_MSG_RAID_LEADER.."]");
					else
						table.insert(text, "["..RAID.."]");
					end
					
				end
				if (utility:GetOption("general", "raidgroup") == 1) then
					table.insert(text, "["..info.g.."]");
				end
				if (utility:GetOption("general", "raidclass") == 1) then
					table.insert(text, "["..info.c.."]");
				end
			end
		end
		if (prefix ~= 1) then
			msg = string.gsub(msg, "%["..CHAT_MSG_OFFICER.."%] ", "");
			msg = string.gsub(msg, "%["..CHAT_MSG_GUILD.."%] ", "");
			msg = string.gsub(msg, "%["..CHAT_MSG_PARTY.."%] ", "");
			msg = string.gsub(msg, "%["..CHAT_MSG_RAID.."%] ", "");
			msg = string.gsub(msg, "%["..CHAT_MSG_RAID_LEADER.."%] ", "");
			msg = string.gsub(msg, "%["..CHAT_MSG_RAID_WARNING.."%] ", "");
			msg = string.gsub(msg, "%["..CHAT_MSG_BATTLEGROUND.."%] ", "");
			msg = string.gsub(msg, "%["..CHAT_MSG_BATTLEGROUND_LEADER.."%] ", "");
		end
		table.insert(text, msg);
		this:Original_AddMessage(table.concat(text, " "), r, g, b, id);
	end
end

local Original_ChatFrame_OnEvent = ChatFrame_OnEvent;

local function Nurfed_ChatFrame_OnEvent(event)
	if (event == "CHAT_MSG_SYSTEM" and arg1 ~= nil) then
		if (arg1 == READY_CHECK_NO_AFK) then
			SendChatMessage(arg1, "RAID");
		elseif (string.find(arg1, afkstring)) then
			SendChatMessage(arg1, "RAID");
		else
			local _, _, name, id, days, hours, minutes, seconds = string.find(arg1, "(.+) %(ID=(%x+)%): (%d+)d (%d+)h (%d+)m (%d+)s")
			if (name ~= nil) then
				local timeTable = date("*t");
				timeTable["sec"] = timeTable["sec"] + (days * 86400) + (hours * 3600) + (minutes * 60) + seconds;
				arg1 = name.." (ID="..id.."): "..date("%A %B %d at %I:%M %p", time(timeTable)).."";
			end
			if (utility:GetOption("general", "autoinvite") == 1 and (IsPartyLeader() or IsRaidLeader() or IsRaidOfficer())) then
				if (string.find(arg1, ERR_GROUP_FULL, 1, true) and lastinvite) then
					local lastTell = ChatEdit_GetLastTellTarget(DEFAULT_CHAT_FRAME.editBox);
					if (lastTell ~= "") then
						SendChatMessage("Party Full", "WHISPER", this.language, lastTell);
					end
				else
					local ingroup = utility:FormatGS(ERR_ALREADY_IN_GROUP_S, true);
					local result = { string.find(arg1, ingroup) };
					if (result[1]) then
						SendChatMessage("Drop group and resend '"..utility:GetOption("general", "keyword").."'", "WHISPER", this.language, result[3]);
					end
				end
			end
		end
	elseif (event == "CHAT_MSG_WHISPER" and arg1 ~= nil) then
		if (utility:GetOption("general", "autoinvite") == 1 and (IsPartyLeader() or IsRaidLeader() or IsRaidOfficer())) then
			local text = string.lower(arg1);
			local keyword = string.lower(utility:GetOption("general", "keyword"));
			if (string.find(text, "^"..keyword)) then
				InviteByName(arg2);
				lastinvite = GetTime();
			end
		end
	elseif (event == "CHAT_MSG_WHISPER_INFORM") then
		if (string.find(arg1, "^!ndkp")) then
			return;
		end
	end
	Original_ChatFrame_OnEvent(event);
	if(not this.Original_AddMessage) then
		this.Original_AddMessage = this.AddMessage;
		this.AddMessage = Nurfed_AddMessage;
	end
end

utility:Hook("replace", "ChatFrame_OnEvent", Nurfed_ChatFrame_OnEvent);

--------------------------------------------------------------------------------------------------
--		Buff Duration Add Seconds
--------------------------------------------------------------------------------------------------

local function Nurfed_SecondsToTimeAbbrev(seconds)
	local time = "";
	local tempTime;
	local tempTime2;
	if ( seconds > 86400  ) then
		tempTime = ceil(seconds / 86400);
		time = tempTime.." "..DAY_ONELETTER_ABBR;
		return time;
	end
	if ( seconds > 3600  ) then
		tempTime = ceil(seconds / 3600);
		time = tempTime.." "..HOUR_ONELETTER_ABBR;
		return time;
	end
	if ( seconds > 60  ) then
		tempTime = floor(seconds / 60);
		tempTime2 = floor(seconds-(tempTime)*60);
		time = format("%02d:%02d", tempTime, tempTime2);
		return time;
	end
	time = format("00:%02d", seconds);
	return time;
end

SecondsToTimeAbbrev = Nurfed_SecondsToTimeAbbrev;

--------------------------------------------------------------------------------------------------
--				Create Frame
--------------------------------------------------------------------------------------------------

-- adds guild info to a line in the inspect frame
local function Nurfed_InspectOnShow()
	InspectPaperDollFrame_OnShow();
	local guildname, guildtitle = GetGuildInfo("target");
	if(guildname and guildtitle) then
		InspectTitleText:SetText(format(TEXT(GUILD_TITLE_TEMPLATE), guildtitle, guildname));
		InspectTitleText:Show();
	else
		InspectTitleText:Hide();
	end
end

local orig_chatframeOnShow = ChatFrame1:GetScript("OnShow");

function nrf_togglechat()
	local hidden = utility:GetOption("general", "hidechat");
	local fade = utility:GetOption("general", "chatfade");
	local fadetime = utility:GetOption("general", "chatfadetime");
	for i = 1, 7 do
		local chatframe = getglobal("ChatFrame"..i);
		local up = getglobal("ChatFrame"..i.."UpButton");
		local down = getglobal("ChatFrame"..i.."DownButton");
		local bottom = getglobal("ChatFrame"..i.."BottomButton");
		if (hidden == 1) then
			chatframe:SetScript("OnShow", function() SetChatWindowShown(this:GetID(), 1) end);
				up:Hide();
				down:Hide();
				bottom:Hide();
			if (i == 1) then
				ChatFrameMenuButton:Hide();
			end
		else
			chatframe:SetScript("OnShow", orig_chatframeOnShow);
				up:Show();
				down:Show();
				bottom:Show();
			if (i == 1) then
				ChatFrameMenuButton:Show();
			end
		end
		chatframe:SetFading(fade);
		chatframe:SetTimeVisible(fadetime);
	end
end

local function Nurfed_General_OnEvent()
	if (event == "PLAYER_ENTERING_WORLD") then
		this:UnregisterEvent(event);
		nrf_togglechat();
	elseif (event == "TRAINER_SHOW") then
		if(utility:GetOption("general", "traineravailable") == 1) then
			SetTrainerServiceTypeFilter("unavailable",0);
		end
	elseif (event == "MERCHANT_SHOW") then
		if (utility:GetOption("general", "repair") == 1) then
			lib:repair(utility:GetOption("general", "repairlimit"), utility:GetOption("general", "repairinv"));
		end
	elseif (event == "MINIMAP_PING") then
		if(utility:GetOption("general", "ping") == 1) then
			local name = UnitName(arg1);
			if (name ~= UnitName("player") and not pingflood[name]) then
				utility:Print(name.." Ping.", 1, 1, 1, 0);
				pingflood[name] = GetTime();
			end
		end
	elseif (event == "ADDON_LOADED" and arg1 == "Blizzard_InspectUI") then
		InspectPaperDollFrame:SetScript("OnShow", Nurfed_InspectOnShow);
	end
end

function Nurfed_General_OnUpdate(arg1)
	this.update = this.update + arg1;
	if (this.update > 1) then
		local svol = GetCVar("MasterVolume")+0;
		if (svol > 0.5) then
			SetCVar("MasterVolume", svol-0.05);
		else
			SetCVar("MasterVolume", svol+0.05);
		end
		SetCVar("MasterVolume", svol);

		local now = GetTime();
		if (lastinvite) then
			if (now - lastinvite > 1) then
				lastinvite = nil;
			end
		end
		for n, t in pairs(pingflood) do
			if (now - t > 1) then
				pingflood[n] = nil;
			end
		end
	end
end

local tbl = {
	type = "Frame",
	events = {
		"PLAYER_ENTERING_WORLD",
		"MINIMAP_PING",
		"ADDON_LOADED",
		"TRAINER_SHOW",
		"MERCHANT_SHOW"
	},
	OnEvent = function() Nurfed_General_OnEvent() end,
	OnUpdate = function() Nurfed_General_OnUpdate(arg1) end,
	vars = { update = 0, lastmin = 0 },
};


local function chatOnMouseWheel()
	if (IsShiftKeyDown()) then
		if (arg1 > 0) then
			this:PageUp()
		elseif (arg1 < 0) then
			this:PageDown();
		end
	elseif (IsControlKeyDown()) then
		if (arg1 > 0) then
			this:ScrollToTop()
		elseif (arg1 < 0) then
			this:ScrollToBottom();
		end
	else
		if (arg1 > 0) then
			this:ScrollUp();
		elseif (arg1 < 0) then
			this:ScrollDown();
		end
	end
end

function Nurfed_General_Init()
	framelib:ObjectInit("Nurfed_GeneralFrame", tbl, UIParent);
	tbl = nil;
	lib:updatemount();
	lib:updateaqmount();

	for i = 1, 7 do
		local chatframe = getglobal("ChatFrame"..i);
		chatframe:EnableMouseWheel(1);
		chatframe:SetScript("OnMouseWheel", function() chatOnMouseWheel(); end);
		chatframe:UnregisterEvent("UPDATE_INSTANCE_INFO");
	end
	RaidWarningFrame:SetHeight(75);
end

--------------------------------------------------------------------------------------------------
--				Misc Functions
--------------------------------------------------------------------------------------------------

function Nurfed_Mount()
	local bag, slot = lib:getmount();
	if (bag and slot) then
		UseContainerItem(bag, slot);
	end
end

function Nurfed_RaidTarget(tar)
	if (not string.find(tar, "[1-9]")) then
		tar = string.lower(tar);
		tar = string.gsub(tar, "^%l", string.upper);
		if (raidtarget[tar]) then
			tar = raidtarget[tar];
		end
	end
	tar = tonumber(tar);
	for i = 1, GetNumRaidMembers() do
		local unit = "raid"..i;
		local target = "raid"..i.."target";
		if (UnitExists(unit) and UnitExists(target)) then
			if (GetRaidTargetIndex(target) == tar) then
				TargetUnit(target);
				return;
			end
		end
	end
end