local compost = AceLibrary("Compost-2.0");
local dewdrop = AceLibrary("Dewdrop-2.0");
local L = AceLibrary("AceLocale-2.0");

HeyFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceDB-2.0", "AceDebug-2.0")
HeyFu.History = {}
HeyFu.hasNoneIcon = "Interface\\Icons\\Spell_Shadow_PsychicScream";
HeyFu.hasChatIcon = "Interface\\Icons\\Ability_Physical_Taunt";
HeyFu.hasIcon = HeyFu.hasNoneIcon;
HeyFu.Unread = 0;


StaticPopupDialogs["HEYFUCONFIRM"] = { 
				text = "Clear the Archive?", 
				button1 = "Yea", 
				button2 = "Nay", 
				timeout = 0, 
				whileDead = 1, 
				OnAccept = function() HeyFu.db.char.Conversations = {} dewdrop:Refresh(1) end
			}
local History = HeyFu.History;
local TimePeriod = { Week = 7*24*60*60, Day = 24*60*60, Hour = 60*60, Recent = 60*15 }
local PreviousPeriod = {Week = "Day", Day = "Hour", Hour = "Recent"}

AceLibrary("AceEvent-2.0"):embed(History);
AceLibrary("AceDebug-2.0"):embed(History);


function HeyFu:OnInitialize()
	self:SetDebugging(true);
	self.version = HeyFu.version..".".. string.sub("$Revision: 12402 $", 12, -3);
	self:RegisterDB("HeyFuDB", "HeyFuCharDB" );
	self:RegisterDefaults('realm', {NameList = compost:Acquire()});
	self:RegisterDefaults('char', {
				Conversations = compost:Acquire(), 
				LastSpoken = "", 
				NamePrefix = false,
				Secretary = false,
				Notification = true,
				DirectionIndicator = compost:Acquire("",""),
				Filters = {GuildAds = false, Exclaim = false, SimpleComm = false} });

	History:Initialize(self.db.realm, self.db.char);
	History:CHAT_MSG_SYSTEM("You are no longer AFK.");
	if(DEFAULT_CHAT_FRAME.editBox.lastTell[1] == "") then
		local count = 1;
		for Reply,_ in History:GetRecent() do
			DEFAULT_CHAT_FRAME.editBox.lastTell[count] = Reply
			count = count + 1;
		end
	end
end
		
-- using an AceOptions data table
function HeyFu:OnMenuRequest(level, value, inTooltip)
	if(level == 5) then
		if(value[1] == "text") then
			self:InsertConversations(value[2], value[3]);
		end
		if(value[1] == "purgeplayers") then
			HeyFu:InsertPurgePlayers(value[2], value[3]);
		end
	end
	if(level == 4) then
		if(value[1] == "text") then
			self:InsertConversations(value[2], value[3]);
		end
		if(value[1] == "weekday") then
			for i,v in pairs(History:GetRecent(value[2], value[3])) do
				dewdrop:AddLine(
				'text', History.NameList[i],
				'hasArrow', true,
				'value', compost:Acquire("text", v, i),
				'func', function(name) self:ReplyTo(name) end,
				'arg1', i
				);
			end
			dewdrop:AddLine(
				'text', 'Purge Day',
				'func', function(Previous, Time) self:Purge(Previous, Time) end,
				'arg1', value[2],
				'arg2', value[3],
				'tooltipTitle', "Warning!",
				'tooltipText', "This option will delete this entire day."
				);
			dewdrop:AddLine(
				'text', 'Purge specific players',
				'hasArrow', true,
				'value', compost:Acquire('purgeplayers', value[2], value[3])
				);
		end
		if(value[1] == "purgeplayers") then
			HeyFu:InsertPurgePlayers(value[2], value[3]);
		end
	end
	if(level == 3) then
		if(type(value) == "table" and value[1] == "Archive") then
			for i,v in pairs(History:GetRecent(TimePeriod[value[2]], TimePeriod[PreviousPeriod[value[2]]])) do
				dewdrop:AddLine(
				'text', History.NameList[i],
				'hasArrow', true,
				'value', compost:Acquire("text", v, i),
				'func', function(name) self:ReplyTo(name) end,
				'arg1', i
				);
			end
			dewdrop:AddLine(
				'text', 'Purge '..value[2],
				'func', function(Previous, Time) self:Purge(Previous, Time) end,
				'arg1', TimePeriod[value[2]],
				'arg2', TimePeriod[PreviousPeriod[value[2]]],
				'tooltipTitle', "Warning!",
				'tooltipText', "This option will delete this entire time period."
				);
			dewdrop:AddLine(
				'text', 'Purge specific players',
				'hasArrow', true,
				'value', compost:Acquire('purgeplayers', TimePeriod[value[2]], TimePeriod[PreviousPeriod[value[2]]])
				);
		end
		if(value == "week") then
			local Now = date("*t");
			Now.hour = 0;
			Now.minute = 0;
			Now.second = 0;
			Now = time(Now);
			local OneDay = 60*60*24;
			for i=1,7 do
				local Day = (i * OneDay);
				dewdrop:AddLine(
					'text', date("%A", Day),
					'hasArrow', true,
					'value', compost:Acquire("weekday", Day, Day - OneDay)
					);
			end
		end
		if(value == "filter") then
			dewdrop:AddLine(
				'text', 'GuildAds',
				'checked', self.db.char.Filters.GuildAds,
				'func', function() self.db.char.Filters.GuildAds = not self.db.char.Filters.GuildAds end
				);
			dewdrop:AddLine(
				'text', '!Prefix',
				'checked', self.db.char.Filters.Exclaim,
				'func', function() self.db.char.Filters.Exclaim = not self.db.char.Filters.Exclaim end
				);
			dewdrop:AddLine(
				'text', '-=Prefix',
				'checked', self.db.char.Filters.SimpleComm,
				'func', function() self.db.char.Filters.SimpleComm = not self.db.char.Filters.SimpleComm end
				);
			dewdrop:AddLine(
				'text', 'Single Word Filters',
				'hasEditBox', true,
				'hasArrow', true,
				'tooltipTitle', "Instructions:",
				'tooltipText', "Please ensure you enter your filters as a comma separated entry.",
				'editBoxText', self.db.char.Filters.SingleWord,
				'editBoxFunc', 
					function(text) 
						self.db.char.Filters.SingleWord = text 
					end
					);
		end
		if(value == "directions") then
			dewdrop:AddLine(
				'text', 'None',
				'checked', self.db.char.DirectionIndicator[1] == "" ,
				'isRadio', true,
				'func', function() self.db.char.DirectionIndicator = compost:Acquire("","") end
				);
			dewdrop:AddLine(
				'text', 'Arrows',
				'checked',  self.db.char.DirectionIndicator[1] == "->",
				'isRadio', true,
				'func', function() self.db.char.DirectionIndicator = compost:Acquire("->","<-") end
				);
			dewdrop:AddLine(
				'text', 'Words',
				'checked',  self.db.char.DirectionIndicator[1] == "From:",
				'isRadio', true,
				'func', function() self.db.char.DirectionIndicator = compost:Acquire("From:","To:") end
				);
		end
	end
	if(level == 2) then
		if(type(value) == "table" and value[1] == "text") then
			self:InsertConversations(value[2], value[3]);
		end
		if(value == 'archive') then
			dewdrop:AddLine(
				'text', 'Last...',
				'isTitle', true
				);
			dewdrop:AddLine(
				'text', 'Hour',
				'hasArrow', true,
				'value', {'Archive', 'Hour'}
				);
			dewdrop:AddLine(
				'text', 'Day',
				'hasArrow', true,
				'value', {'Archive', 'Day'}
				);
			dewdrop:AddLine(
				'text', 'Week',
				'hasArrow', true,
				'value', 'week'
				);
			dewdrop:AddLine(
				'text', 'Clear Archive',
				'func', function() StaticPopup_Show("HEYFUCONFIRM") end
				);
		elseif(value == "settings") then
			dewdrop:AddLine(
				'text', 'Filter',
				'hasArrow', true,
				'value', 'filter'
				);
			dewdrop:AddLine(
				'text', 'Directions',
				'hasArrow', true,
				'value', 'directions'
				);
			dewdrop:AddLine(
				'text', 'Paste Prefix',
				'checked', self.db.char.NamePrefix,
				'func', function() self.db.char.NamePrefix = not self.db.char.NamePrefix end,
				'tooltipTitle', "Paste Prefix",
				'tooltipText', "Prefix the pasted tells with your designated chatprefix."
				);
			dewdrop:AddLine(
				'text', 'Chat Notification',
				'tooltipTitle', 'Chat Notification',
				'tooltipText', 'Toggles whether you see the "X tells.. on the icon or not',
				'checked', self.db.char.Notification,
				'func', function() self.db.char.Notification = not self.db.char.Notification end
				);
			dewdrop:AddLine(
				'text', 'Personal Secretary',
				'checked', self.db.char.Secretary,
				'func', function() self.db.char.Secretary = not self.db.char.Secretary end,
				'tooltipTitle', "Personal Secretary",
				'tooltipText', "Have HeyFu record and playback tells made while AFK."
				);
		end

	end
	if(level == 1) then
		dewdrop:AddLine(
			'text', 'Recent Chats',
			'isTitle', true
			);
		for i,v in pairs(History:GetRecent()) do
			dewdrop:AddLine(
			'text', History.NameList[i],
			'hasArrow', true,
			'value', compost:Acquire("text", v, i),
			'func', function(name) self:ReplyTo(name) end,
			'arg1', i
			);
		end
		dewdrop:AddLine();
		dewdrop:AddLine(
			'text', 'Archive',
			'hasArrow', true,
			'value', 'archive'
			);
		dewdrop:AddLine(
			'text', 'Settings',
			'hasArrow', true,
			'value', 'settings'
			);
	end
end

function HeyFu:ReplyTo(person)
	local reply = "/w "..person.." ";
	if (not ChatFrameEditBox:IsShown()) then
		ChatFrame_OpenChat(reply, DEFAULT_CHAT_FRAME);
	else
		ChatFrameEditBox:SetText(reply..ChatFrameEditBox:GetText());
	end
end

function HeyFu:InsertTo(text, Name, Direction)
	if(self.db.char.NamePrefix) then
		text = Direction.." ["..Name.."]: "..text;
	end
	if (not ChatFrameEditBox:IsShown()) then
		ChatFrame_OpenChat(text, DEFAULT_CHAT_FRAME);
	else
		ChatFrameEditBox:Insert(text);
	end
end
function HeyFu:InsertConversations(Messages, Name)
	for _,v in ipairs(Messages) do
		local time, message = v:Info();
		if(not v:IsPlayer()) then
			dewdrop:AddLine(
				'text', self.db.char.DirectionIndicator[1]..date("[%X]: ", time)..message,
				'func', function(text, Name) self:InsertTo(text, Name, self.db.char.DirectionIndicator[1]) end,
				'arg1', message,
				'arg2', Name,
				'tooltipFunc', function(message) GameTooltip:AddLine(message, 1,1,1,1,true) end,
				'tooltipArg1', message
				);
		else
			dewdrop:AddLine(
				'text', self.db.char.DirectionIndicator[2]..date("[%X]: ", time)..message,
				'textR', 0.5,
				'textG', 0.5,
				'textB', 0.5,
				'func', function(text, Name) self:InsertTo(text, Name, self.db.char.DirectionIndicator[2]) end,
				'arg1', message,
				'arg2', Name,
				'tooltipFunc', function(message) GameTooltip:AddLine(message, 1,1,1,1,true) end,
				'tooltipArg1', message
				);
		end
	end
end

function HeyFu:InsertPurgePlayers(Time1, Time2)
	for target, convos in pairs(History:GetRecent(Time1, Time2)) do
		dewdrop:AddLine(
			'text', History.NameList[target],
			'func', function(Time1, Time2, Target) HeyFu:Purge(Time1, Time2, nil, Target) end,
			'arg1', Time1,
			'arg2', Time2, 
			'arg3', target
			);
	end
end

function HeyFu:Purge(Time1, Time2, Period, Specific)
	for target,convos in pairs(Specific and compost:AcquireHash(Specific, HeyFu.db.char.Conversations[Specific]) or HeyFu.db.char.Conversations) do
		local bin = compost:Acquire();
		for i,v in ipairs(convos) do
			if(v:Within(Time1, Time2)) then
				table.insert(bin, i);
				self:Debug("removing: "..v.message);
			end
		end
		table.sort(bin, function(a,b) return a > b end);
		for i,v in ipairs(bin) do
			table.remove(HeyFu.db.char.Conversations[target], v);
		end
	end
end

function HeyFu:OnTextUpdate()
	if(HeyFu.db.char.Notification and HeyFu.Unread > 0) then
		self:SetText( HeyFu.Unread > 1 and HeyFu.Unread.." tells..." or "1 tell...")
		self:SetIcon(self.hasChatIcon);
	else
		self:SetIcon(self.hasNoneIcon);
		self:SetText( "HeyFu" );
	end
end

local tablet = AceLibrary("Tablet-2.0")
function HeyFu:OnTooltipUpdate()
    local Tooltip = tablet:AddCategory(
        'id', "Alpha",
        'columns', 2,
        'child_textR', 1,
        'child_textG', 1,
        'child_textB', 0,
        'child_textR2', 1,
        'child_textG2', 1,
        'child_textB2', 1)

	local Convos = History:GetRecent(time() - (60*15), nil, History.db.LastSpoken)[History.db.LastSpoken];
	if(Convos and HeyFu.Unread > 0) then
		
		while(table.getn(Convos) > 10) do table.remove(Convos, 1) end

		Tooltip:AddLine(
				'text', History.db.LastSpoken
				);
		local count = 10;
		for i,v in pairs(Convos or {}) do
			local time, message = v:Info();
			if(not v:IsPlayer()) then
				Tooltip:AddLine(
					'text', self.db.char.DirectionIndicator[1]..date("[%X]:",time),
					'text2', message,
					'wrap2', true
			         );
			else
				Tooltip:AddLine(
					'text', self.db.char.DirectionIndicator[2]..date("[%X]:", time),
					'text2', message,
					'wrap2', true,
					'textR2', 0.5,
					'textG2', 0.5,
					'textB2', 0.5
					);
			end
			if(count == 0) then break; end
			count = count - 1
		end
	end
    
    tablet:SetHint("Click to clear the unread count.")
    -- as a rule, if you have an OnClick or OnDoubleClick or OnMouseUp or OnMouseDown, you should set a hint.
end

function HeyFu:OnClick()
	if(self.db.char.Notification) then
		HeyFu.Unread = 0;
	end
	if(IsShiftKeyDown()) then
		self.db.char.Notification = not self.db.char.Notification
	end
	self:UpdateText();
end


function History:ToString()
	return "History";
end

--
--
-- Conversation history management section
--
--

History.Message = {}

-- Message metatable so we can use +/- time to store who's saying what
function History.Message:New(time, message)
	o = compost:Acquire();
	o.message	= message;
	o.time		= time;
	setmetatable(o, self);
	self.__index = self
	return o;
end

-- Return actual time
function History.Message:Info()
	return math.abs(self.time), self.message;
end

function History.Message:__tostring()
	
end

function History.Message:IsPlayer()
	return self.time < 0;
end

function History.Message:Within(time1, time2)
	local myTime = math.abs(self.time);
	if(not time2) then
		if(myTime > (time() - time1)) then
			return true
		else
			return false
		end
	else
		if(myTime > (time() - time1) and myTime < (time() - time2)) then
			return true
		else
			return false
		end
	end
end

function History:Initialize(RealmDB, CharDB)
	self.db = CharDB;
	self.NameList = RealmDB.NameList; -- Realm specific
	self:RestoreMetatables();
	self:SetDebugging(true);
	self.CheckTime = time();
	self:RegisterEvent("CHAT_MSG_WHISPER");
	self:RegisterEvent("CHAT_MSG_WHISPER_INFORM");
	self:RegisterEvent("CHAT_MSG_SYSTEM");
end

function History:AddMessage(time, message, name)
	if(self.db.Filters.GuildAds and string.sub(message, 1, 3) == "<GA") then
		return;
	end
	if(self.db.Filters.Exclaim and  string.sub(message, 1, 1) == "!") then
		return;
	end
	if(self.db.Filters.SimpleComm and string.sub(message, 1, 2) == "-=") then
		return;
	end
	if(self.db.Filters.SingleWord) then
		for filter in string.gfind(self.db.Filters.SingleWord, "(%w+),") do
			if(message == filter) then
				return;
			end
		end
	end

	local Message = History.Message:New(time, message);
	table.insert(self.db.Conversations[name], Message);
	if(not Message:IsPlayer()) then
		self.db.LastSpoken = name;
		HeyFu.Unread = HeyFu.Unread + 1;
		HeyFu:UpdateText();
	end
end

function History:GetRecent(time1, time2, specificName)
	local Recent = compost:Acquire();

	for name,convos in pairs(specificName and {[specificName] = self.db.Conversations[specificName]} or self.db.Conversations) do
		for _,Message in ipairs(convos) do
			if(Message:Within(time1 or (15 * 60), time2)) then
				if(not Recent[name]) then Recent[name] = compost:Acquire() end
				table.insert(Recent[name], Message);
			end
		end
		if(Recent[name]) then
			table.sort(Recent[name], 
						function(a, b) 
							local atime = a:Info()
							local btime = b:Info()
							return atime < btime
						end);
		end
	end
	if(table.getn(Recent) > 0) then
		table.sort(Recent, function(a, b)
							local atime = a[1]:Info()
							local btime = b[1]:Info()
							return atime < btime
						end);
	end
	return Recent;
end

function History:CHAT_MSG_WHISPER(message, author)
	if(not self.db.Conversations[author]) then
		self.db.Conversations[author] = compost:Acquire();
	end
	self:UpdateColour(author);
	self:AddMessage(time(), message, author);
end

function History:CHAT_MSG_WHISPER_INFORM(message, target)
	if(not self.db.Conversations[target]) then
		self.db.Conversations[target] = compost:Acquire();
	end
	self:UpdateColour(target);
	self:AddMessage(time() * -1, message, target);
end

function History:CHAT_MSG_SYSTEM(message)
	if(self.db.Secretary and string.find(message, "^You are now AFK:")) then
		self.db.AFK = time()
	end
	if(self.db.Secretary and self.db.AFK and message == "You are no longer AFK.") then
		local info = ChatTypeInfo["WHISPER"]
		local listing = self:GetRecent(time() - self.db.AFK)
		local merged = compost:Acquire();
		for i,v in pairs(listing) do
			for _, Message in ipairs(v) do
				if(not Message:IsPlayer()) then
					local time, message = Message:Info();
					table.insert(merged, compost:Acquire(time, i, message));
				end
			end
		end
		table.sort(merged, function(a,b) return a[1] < b[1] end);
		if(table.getn(merged) > 0) then
			DEFAULT_CHAT_FRAME:AddMessage("HeyFu - Secretary (You have "..table.getn(merged).." messages):", 0.5, 0.7, 1); 
			for i,v in ipairs(merged) do
				DEFAULT_CHAT_FRAME:AddMessage(date("[%X] ", v[1])..self.NameList[v[2]]..": "..v[3],  info.r, info.g, info.b, info.id);
			end
		end
		self.db.AFK = nil;
	end
end

function History:RestoreMetatables()
	History.Message.__index = History.Message;
	for char, convos in pairs(self.db.Conversations) do
		for _,v in ipairs(convos) do 
			setmetatable(v, History.Message);
		end
	end
end

function History:UpdateColour(name)
	if(not self.NameList[name] or self.NameList[name] == name) then
		if(Teknicolor) then -- Take advantage of Teknicolor's color settings.
			if(Teknicolor.nametable[name]) then
				self.NameList[name] = Teknicolor.nametable[name];
				return;
			end
		end
		self.NameList[name] = name;
	end
end

