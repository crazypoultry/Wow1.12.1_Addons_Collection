local DEFAULT_OPTIONS = {
	ingoreOffline = TRUE,
	sound = 1,
	address = ": ",
	
}

Tab = AceAddon:new{
	name 			= "Tab",
	description		= "Adds tab completion of friends, guild mates, and party/raid members to chat.",
	author			= "tard",
	releaseDate		= "01/22/2006",
	version			= "0.3",
	category		= "chat",
	email			= "tardmrr@gmail.com",

	aceCompatible	= "103",
	db				= AceDatabase:new("TabDB"),
	defaults		= DEFAULT_OPTIONS,
	cmd				= AceChatCmd:new({"/tab"}),
	registry		= {},
	tellNames		= {},
	
	iter = function(prefix)
		local i = 0
		return function()
			i = i + 1
			return UnitName(prefix..i)			
		end
	end,
	
	noop = function()end,
	
}

Tab:RegisterForLoad()

Ace:RegisterFunctions(Tab,{
	version = 1.0,

	Get = function(self, var)
		return self.db:get(self.profilePath, var)
   	end,

	TogC = function(self, v, c)
		self.cmd:result(format(c, self.db:toggle(self.profilePath, v) and
			"|cff00ff00"..ACEG_ON.."|r" or "|cffff0000"..ACEG_OFF.."|r"))
	end,
})

function Tab:Enable()
	for k in self.registry do
		self:RegisterEditBox(k)
	end
	GuildRoster()
	self:RegisterEvent("CHAT_MSG_SYSTEM")
	self:RegisterEvent("CHAT_MSG_WHISPER","Whisper")
	self:RegisterEvent("CHAT_MSG_WHISPER_INFORM","Whisper")
end

function Tab:Initialize()
	self.registry[ChatFrameEditBox] = TRUE
	if VisorEditBox then
		self.registry[VisorEditBox] = TRUE
	end
end

function Tab:Disable()

end

function Tab:RegisterEditBox(editbox)
	self:HookScript(editbox,"OnTabPressed","OnTabPressed")
	self.registry[editbox] = TRUE
end

function Tab:UnregisterEditBox(editbox)
	self:UnhookScript(editbox,"OnTabPressed")
	self.registry[editbox] = FALSE
end

function Tab:Complete(name,edit,left,len)
	edit:HighlightText(left - 1,left + len)
	edit:Insert(name)
end

function Tab:OnTabPressed()
	local pos = self:GetCaret(this)
	local text = this:GetText()
	
	if(pos == 0 and this.chatType == "WHISPER") then
		self:debug("Redirecting to default handler; should cycle tell targets")
		self:CallScript(this,"OnTabPressed")
		return
	end
	
	local left = string.find(string.sub(text,0,pos),"[^%s]+$")
	
	if(not left) then 
		if(this.chatType == "WHISPER") then
			self:debug("Redirecting to default handler; should cycle tell targets")
			self:CallScript(this,"OnTabPressed")
			return
		else	
			return
		end
	end	
	
	local _,_,word = string.find(string.sub(text,left),"^([^%s]+)")
	
	-- This check is probably redundant
	if (not word or word == "") then return	end
	
		
	if((left == 1) and string.sub(word,1,1) == "/") then
		self:debug("Redirecting to default handler; this is a slash command.")
		self:CallScript(this,"OnTabPressed")
		return
	end

	
	--[[
	if((word == self.matches[self.pressed] or word == self.word) and (GetTime() - self.time) < 3) then
		self.pressed = self.pressed + 1
		if(self.pressed > table.getn(self.matches)) then
			self.pressed = 1
		end
		self.time = GetTime()
		
		self:Complete(self.matches[self.pressed],this,left,string.len(word))
		
		return
	end
	]]
	--[[
	if(string.sub(word,1,1) == "[") then
		self:MatchItems(word,left,this)
		return
	end
	]]
	local matches = {}
	local numMatches = 0
	local ignoreOffline = self:Get("ignoreOffline")
	for name in self.tellNames do
		if(string.find(strlower(name),strlower(word),nil,1) == 1) then
			if(not matches[name]) then numMatches = numMatches + 1 end 
			matches[name] = TRUE
		end	
	end	
	
	for i=1,GetNumGuildMembers(not ignoreOffline) do
		local name = GetGuildRosterInfo(i)
		if(string.find(strlower(name),strlower(word),nil,1) == 1) then
			if(not matches[name]) then numMatches = numMatches + 1 end 
			matches[name] = TRUE
		end
	end
	for i=1,GetNumFriends() do
		local name,_,_,_,online = GetFriendInfo(i)
		if(ignoreOffline and not online) then break end
		if(string.find(strlower(name),strlower(word),nil,1) == 1) then
			if(not matches[name]) then numMatches = numMatches + 1 end
			matches[name] = TRUE
		end
	end
	local prefix = UnitExists("raid1") and "raid" or "party"
	
	for name in self.iter(prefix) do
		if(string.find(strlower(name),strlower(word),nil,1) == 1) then
			if(not matches[name]) then numMatches = numMatches + 1 end
			matches[name] = TRUE
		end
	end
	
	if(numMatches == 1) then
		self:Complete(next(matches),this,left,string.len(word))
	elseif(numMatches > 1) then
		--[[
		self.pressed = 0
		self.time = GetTime()
		self.word = word
		self.matches = {}
		]]
		
		local ordered = {}
		for k in matches do
			table.insert(ordered,k)			
		end
		table.sort(ordered)
		self.cmd:msg(table.concat(ordered,", "))
		self:Complete(self.LCS(ordered),this,left,string.len(word))
	elseif(self:Get("playSound")) then
		--TODO: play a sound here if no matches
	end
	
end

function Tab:MatchItems(word,left,edit)
	if(not word or word == "[") then return end
	local pat = "^"..string.lower(string.sub(word,2))
	local matches = {}
	for i=1,25000 do -- This number is a guess, I really don't know what it should be
		local name,link,qual = GetItemInfo(i)
		if(name and string.find(string.lower(name),pat)) then
			local _,_,_,color = GetItemQualityColor(qual)
			table.insert(matches,color.."|H"..link.."|h["..name.."]|r|h")
		end
	end
	
	local numMatches = table.getn(matches)
	if(numMatches == 1) then
		self:Complete(matches[1],edit,left,string.len(word))
	elseif(numMatches > 1) then
		table.sort(matches)
		self:Complete(self.LCS(matches),edit,left,string.len(word))
		self.cmd:msg(table.concat(matches,", "))
	elseif(numMatches == 0) then
		
	end
end

function Tab.LCS(strings)
	
	local len = 0
	for _,s in strings do
		len = (string.len(s) > len)	and string.len(s) or len
	end
	
	local slen = table.getn(strings)
	
	for i=1,len do
		local c = string.sub(strings[1],i,i)
		for j=2,slen do
			if(string.sub(strings[j],i,i) ~= c) then
				return string.sub(strings[1],0,i-1)
			end
		end
	end
	return strings[1]
end


function Tab:GetCaret(edit)
	--local parsetext = ChatEdit_ParseText
	--ChatEdit_ParseText = self.noop
	
	local script = edit:GetScript("OnTextSet")
	if(script) then edit:SetScript("OnTextSet",nil) end
	
	local text = edit:GetText()
	edit:Insert("\1")
	local pos = string.find(edit:GetText(),"\1",1)
	edit:SetText(text)
	self:SetCaret(edit,pos-1)
	
	if(script) then edit:SetScript("OnTextSet",script) end
	
	--ChatEdit_ParseText = parsetext
	
	return pos - 1
end

function Tab:SetCaret(edit,pos)
	--local parsetext = ChatEdit_ParseText
	--ChatEdit_ParseText = self.noop
	
	local script = edit:GetScript("OnTextSet")
	if(script) then edit:SetScript("OnTextSet",nil) end
	
	local text = edit:GetText()
	edit:SetText(string.sub(text,0,pos).."a"..string.sub(text,pos+1))
	edit:HighlightText(pos,pos+1)
	edit:Insert("\0")
	
	--ChatEdit_ParseText = parsetext
	if(script) then edit:SetScript("OnTextSet",script) end
end

function Tab:CHAT_MSG_SYSTEM()
	local s = string.gsub(ERR_FRIEND_ONLINE_SS,"%%s",".*")
	if(string.find(arg1,s)) then
		GuildRoster()
	end
end
function Tab:Whisper()
	self.tellNames[arg2] = TRUE
end
