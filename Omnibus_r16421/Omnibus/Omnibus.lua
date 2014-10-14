
local function debug(msg) end
local OB_RELEASE = nil
if not OB_RELEASE then
	debug = function(msg) DEFAULT_CHAT_FRAME:AddMessage(msg) end
end

-- current number of temp frames for the dropdown.
local maxtempframes = 0

local L = AceLibrary("AceLocale-2.2"):new("Omnibus")

BINDING_HEADER_OMNIBUS = L["Omnibus"]
BINDING_NAME_OBUS_TOGGLE = L["Toggle Omnibus Window"]
BINDING_NAME_OBUS_EXEC = L["Execute Current Page"]
BINDING_NAME_OBUS_SEARCH = L["Toggle Omnibus Search Window"]

-- tooltip info for controls
local controls = {
	OmnibusNew={L["New Page"],L["Create a new Untitled page."]},
	OmnibusDelete={L["Delete Page"],L["Permanently remove this page.  Hold Shift to delete without confirmation."]},
	OmnibusRun={L["Run Page"],L["Run this page as a script."]},
	OmnibusStart={L["First Page"],L["Go to first page"]},
	OmnibusLeft={L["Flip Back"],L["Go back one page."]},
	OmnibusRight={L["Flip Forward"],L["Go forward one page."]},
	OmnibusEnd={L["Last Page"],L["Go to the last page."]},
	OmnibusClose={L["Close Omnibus"],L["Close the book."]},
	OmnibusLock={L["Lock"],L["Lock or Unlock window."]},
	OmnibusFont={L["Font"],L["Cycle through different fonts."]},
	OmnibusSearch={L["Options"],L["Search pages for text, change fonts or lock window."]},
	OmnibusSearchNext={L["Find Next"],L["Find next page with this text"]},
	OmnibusSearchEditBox={L["Search Criteria"],L["Enter the text to search for here."]},
	OmnibusTitleEditBox={L["Page Title"],L["Change the Page Title here."]},
	OmnibusSendToEditBox={L["Send Page To"],L["Send this page to someone else, who is using Omnibus also.  Tab Completion Enabled."]},
	OmnibusUndo={L["Undo"],L["Revert page to last saved text."]},
	OmnibusSendTo={L["Send To Toggle"],L["Click to show the Send To field."]},
	OmnibusImport={L["Import Pages"],L["Import pages from TinyPad."]},
	OmnibusDropButton={L["List Omnibus Pages"],L["Lists your Omnibus pages in a dropdown box so you can go to the exact one you want."]},
	OmnibusSetDefault={L["Set New Page Template"],L["Sets your template for new pages equal to the content of your current page."]},
}

-- list of fonts to cycle through
local fonts = {
	{"Interface\\AddOns\\Omnibus\\VeraMono.ttf",10},
	{"Interface\\AddOns\\Omnibus\\VeraMono.ttf",12},
	{"Interface\\AddOns\\Omnibus\\VeraMono.ttf",16},
	{"Fonts\\FRIZQT__.TTF",10},
	{"Fonts\\FRIZQT__.TTF",12},
	{"Fonts\\FRIZQT__.TTF",16},
	{"Fonts\\ARIALN.TTF",12},
	{"Fonts\\ARIALN.TTF",16},
	{"Fonts\\ARIALN.TTF",20},
	{"Fonts\\MORPHEUS.ttf",16,"OUTLINE"},
	{"Fonts\\MORPHEUS.ttf",24,"OUTLINE"},
	-- add fonts here
}

Omnibus = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "FuBarPlugin-2.0", "AceComm-2.0", "AceConsole-2.0")
Omnibus.hasNoText = true
Omnibus.hasIcon = true
Omnibus.defaultPosition = "RIGHT"
Omnibus.defaultMinimapPosition = 270
Omnibus.tooltipHiddenWhenEmpty = true
Omnibus.clickableTooltip = true

Omnibus.OnMenuRequest = {
	type = 'group',
	args = {
		toggle = {
			name = L["Toggle"],
			type = "execute",
			desc = L["Toggle the Omnibus Window"],
			func = function()
				Omnibus:Toggle()
			end
		},
	}
}
Omnibus:RegisterChatCommand({ "/omnibus", "/ob" }, Omnibus.OnMenuRequest)

local tablet = AceLibrary("Tablet-2.0")

Omnibus:RegisterDB("OmnibusDB")
Omnibus:RegisterDefaults("account",{
	current_page = 1,
	Font = 2,
	book = {{"Untitled",""}},
})

StaticPopupDialogs["OMNIBUSCONFIRM"] = {
	text = L["Delete this page?"],
	button1 = L["Yes"],
	button2 = L["No"],
	timeout = 0,
	whileDead = 1,
	OnAccept = function() Omnibus:DeletePage() end
}

StaticPopupDialogs["OMNIBUSNOTINYPAD"] = {
	text = L["Cannot find TinyPad data.  Check that TinyPad is installed and active."],
	button1 = L["OK"],
	timeout = 10,
	whileDead = 1,
}

StaticPopupDialogs["OMNIBUSNOSENDTORESPONSE"] = {
	text = L["%s does not appear to have Omnibus installed.  (No Response)"],
	button1 = L["OK"],
	timeout = 10,
	whileDead = 1,
}

StaticPopupDialogs["OMNIBUSPAGEACCEPTED"] = {
	text = L["%s has accepted your page."],
	button1 = L["OK"],
	timeout = 10,
	whileDead = 1,
}

StaticPopupDialogs["OMNIBUSPAGEDECLINED"] = {
	text = L["%s has declined your page."],
	button1 = L["OK"],
	timeout = 10,
	whileDead = 1,
}

StaticPopupDialogs["OMNIBUSSNDCONFIRM"] = {
	text = L["Send this page to %s?\nWARNING: Users not running AceComm or an Ace2 Addon\nthat uses AceComm will see some strange whispers."],
	button1 = L["Yes"],
	button2 = L["No"],
	timeout = 0,
	whileDead = 1,
	OnAccept = function() Omnibus:SendTo(true) end
}

StaticPopupDialogs["OMNIBUSRCVCONFIRM"] = {
	text = L["%s has sent you an Omnibus page, Accept it?"],
	button1 = L["Yes"],
	button2 = L["No"],
	timeout = 0,
	whileDead = 1,
	OnAccept = function() Omnibus:AcceptReceivedPage() end,
	OnCancel = function() Omnibus:CancelReceivedPage() end
}

StaticPopupDialogs["OMNIBUSSETDEFAULTTEXT"] = {
	text = L["Overwrite Current Default Page Text?"],
	button1 = L["Yes"],
	button2 = L["No"],
	timeout = 0,
	whileDead = 1,
	OnAccept = function(data) Omnibus:SetDefaultText(data) end,
}

function Omnibus:OnInitialize()
	OmnibusFrame:SetMinResize(436,96)
	table.insert(UISpecialFrames,"OmnibusFrame")
	table.insert(UISpecialFrames,"OmnibusSearchFrame")
end

function Omnibus:OnEnable()
	self.lastFUpdate = time()
	self.lastGRUpdate = self.lastFUpdate
	self:UpdateFont()
	self:UpdateLock()
	-- Check for IndentationLib from "For all Indents and Purposes" mod.
	if type(IndentationLib) == "table" and IndentationLib.revision >= 14 then
		IndentationLib.addSmartCode(OmnibusEditBox)
	end
	-- Register for Page Transfer Communications.
	self:RegisterComm("Omnibus","WHISPER")
	self:SetCommPrefix("Omnibus")
	-- Guild roster and friends list update.
	self:RegisterEvent("PLAYER_GUILD_UPDATE")
	if IsInGuild() then
		self:ScheduleRepeatingEvent("ScheduledGuildRoster", GuildRoster, 15)
		self:RegisterEvent("GUILD_ROSTER_UPDATE")
		GuildRoster()
	end
	self:ScheduleRepeatingEvent(ShowFriends, 15)
	self:RegisterEvent("FRIENDLIST_UPDATE")
	ShowFriends()
	-- Tab Completion
	AceLibrary("AceTab-2.0"):RegisterTabCompletion("OmnibusSendTo","",function(t) Omnibus:FillSendToList(t) end,true,{"OmnibusSendToEditBox"})
end

function Omnibus:ImportTinyPadPage(page)
	local new_page = {format(L["TinyPad Page %d"],page),TinyPadPages[page]}
	table.insert(self.db.account.book,new_page)
	self:CompressPage(table.getn(self.db.account.book))
	self:SortPages()
	self.db.account.current_page = table.getn(self.db.account.book)
	self:ShowPage()
	if TinyPadPages[page+1] then
		self:ScheduleEvent(self.ImportTinyPadPage,0.1,self,page+1)
	else
		self:UpdateTooltip()
	end
end

function Omnibus:ImportTinyPadPages()
	-- Save The current page...
	self.db.account.book[self.db.account.current_page][2] = OmnibusEditBox:GetText()
	self.db.account.book[self.db.account.current_page].z = nil
	self:CompressPage(self.db.account.current_page)
	if type(TinyPadPages) == "table" then
		self:ImportTinyPadPage(1)
	else
		StaticPopup_Show("OMNIBUSNOTINYPAD")
	end
end

function Omnibus:DumpPages()
	for i, page in ipairs(self.db.account.book) do
		debug(page[1].." "..type(self:TempPageText(i)))
		debug(self:TempPageText(i))
	end
end

function Omnibus:FillSendToList(t)
	fplayers = self.fplayers or {}
	gplayers = self.gplayers or {}
	for name in pairs(fplayers) do
		table.insert(t,name)
	end
	for name in pairs(gplayers) do
		if not fplayers[name] then table.insert(t,name) end
	end
	-- fill in own name.
	local pname = UnitName("player")
	if not fplayers[pname] and not gplayers[pname] then
		table.insert(t,pname)
	end
	-- fill in target's name.
	if not UnitIsUnit("target","player") and UnitIsPlayer("target") and UnitIsFriend("player","target") then
		local tname = UnitName("target")
		if not fplayers[tname] and not gplayers[tname] then
			table.insert(t,tname)
		end
	end
end

function Omnibus:FRIENDLIST_UPDATE()
	if time() <= self.lastFUpdate + 1 then return end
	self.lastFUpdate = time()

	self.fplayers = {}

	local numFriends = GetNumFriends()
	local name, online, status
	for i = 1, numFriends do
		name, _, _, _, online, status = GetFriendInfo(i)
		if online and status == "" then
			self.fplayers[name] = true
		end
	end
end

function Omnibus:GUILD_ROSTER_UPDATE()
	if time() <= self.lastGRUpdate + 1 then return end
	self.lastGRUpdate = time()

	self.gplayers = {}

	if IsInGuild() then
		local numGuildMembers = GetNumGuildMembers(true)
		local name, online, status
		for i = 1, numGuildMembers do
			name, _, _, _, _, _, _, _, online, status = GetGuildRosterInfo(i)
			if online and status == "" then
				self.gplayers[name] = true
			end
		end
	end
end

function Omnibus:PLAYER_GUILD_UPDATE()
	if arg1 and arg1 ~= "player" then return end
	if IsInGuild() then
		if not self:IsEventRegistered("GUILD_ROSTER_UPDATE") then
			self:ScheduleRepeatingEvent("ScheduledGuildRoster", GuildRoster, 15)
			self:RegisterEvent("GUILD_ROSTER_UPDATE")
		end
		GuildRoster()
	else
		if self:IsEventRegistered("GUILD_ROSTER_UPDATE") then
			self:CancelScheduledEvent("ScheduledGuildRoster")
			self:UnregisterEvent("GUILD_ROSTER_UPDATE")
		end
	end
end

function Omnibus:OnCommReceive(prefix, sender, dist, cmd, title, text, z)
	if cmd == "PAGE" then
		local new_page = {[1] = title, [2] = text, z = z, sender = sender}
		self.rcvbook = self.rcvbook or {}
		table.insert(self.rcvbook,new_page)
		self:PopReceiveConfirm()
		-- send rcvd message to the other side.
		self:SendCommMessage("WHISPER",sender,"RCVD")
	elseif cmd == "RCVD" then
		-- cancel not received event quietly.
		self:CancelScheduledEvent("NOTRCVD")
	elseif cmd == "ACCEPTED" then
		-- popup the page accepted box
		StaticPopup_Show("OMNIBUSPAGEACCEPTED",sender)
	elseif cmd == "DECLINED" then
		-- popup the page declined box
		StaticPopup_Show("OMNIBUSPAGEDECLINED",sender)
	end
end

function Omnibus:PopReceiveConfirm()
	self.rcvbook = self.rcvbook or {}
	if not self.showingReceiveConfirm then
		self.showingReceiveConfirm = true
		StaticPopup_Show("OMNIBUSRCVCONFIRM",self.rcvbook[1].sender)
	end
end

function Omnibus:AcceptReceivedPage()
	local new_page = self.rcvbook[1]
	self:SendCommMessage("WHISPER",new_page.sender,"ACCEPTED")
	table.remove(self.rcvbook,1)
	new_page.sender = nil
	table.insert(self.db.account.book,new_page)
	self:SortPages()
	self:SetPage(self:FindPageIndex(new_page))
	self:UpdateTooltip()
	if self.rcvbook[1] then
		self:ScheduleEvent(StaticPopup_Show,1,"OMNIBUSRCVCONFIRM",self.rcvbook[1].sender)
	else
		self.showingReceiveConfirm = nil
	end
end

function Omnibus:CancelReceivedPage()
	self:SendCommMessage("WHISPER",self.rcvbook[1].sender,"DECLINED")
	table.remove(self.rcvbook,1)
	if self.rcvbook[1] then
		self:ScheduleEvent(StaticPopup_Show,1,"OMNIBUSRCVCONFIRM",self.rcvbook[1].sender)
	else
		self.showingReceiveConfirm = nil
	end
end

function Omnibus:TempCompressPage(page)
	--debug("Omnibus:CompressPage("..page..")")
	--debug("self.db.account.book[page].z = "..tostring(self.db.account.book[page].z))
	--debug("self.db.account.book[page][2] = '"..self.db.account.book[page][2].."'")
	if not self.db.account.book[page].z and self.db.account.book[page][2] and self.db.account.book[page][2] ~= "" then
		ztext = lzw:compress(self.db.account.book[page][2])
		if strlen(ztext) < strlen(self.db.account.book[page][2]) then
			return ztext, true
		end
	end
	return self.db.account.book[page][2], self.db.account.book[page].z
end

function Omnibus:SendPage(pnum,sendto)
	local page = self.db.account.book[pnum]
	if page then
		self:SendCommMessage("WHISPER",sendto,"PAGE",page[1],self:TempCompressPage(pnum))
		self:ScheduleEvent("NOTRCVD",StaticPopup_Show, 3,"OMNIBUSNOSENDTORESPONSE",sendto)
	end
end

function Omnibus:SendTo(postpopup)
	if not postpopup then
		self.sendto = gsub(OmnibusSendToEditBox:GetText(),"%s","")
		self.sendpage = self.db.account.current_page
		OmnibusSendToEditBox:SetText(L["Send To:"])
		StaticPopup_Show("OMNIBUSSNDCONFIRM",self.sendto)
	else
		self:SendPage(self.sendpage,self.sendto)
		OmnibusEditBox:SetFocus()
		self.sendto = nil
		self.sendpage = nil
		OmnibusSendToEditBox:Hide()
		OmnibusStart:Show()
		OmnibusLeft:Show()
		OmnibusTitleEditBox:Show()
		OmnibusRight:Show()
		OmnibusEnd:Show()
		OmnibusDropButton:Show()
		self.sendToShown = not self.sendToShown
	end
end

function Omnibus:TempPageText(page)
	ptext = self.db.account.book[page][2]
	if self.db.account.book[page].z then
		ptext = lzw:decompress(ptext)
	end
	return ptext
end

function Omnibus:PageText(page)
	ptext = self.db.account.book[page][2]
	if self.db.account.book[page].z then
		ptext = lzw:decompress(ptext)
		self.db.account.book[page][2] = ptext
		self.db.account.book[page].z = nil
	end
	return ptext
end

function Omnibus:CompressPage(page)
	--debug("Omnibus:CompressPage("..page..")")
	--debug("self.db.account.book[page].z = "..tostring(self.db.account.book[page].z))
	--debug("self.db.account.book[page][2] = '"..self.db.account.book[page][2].."'")
	if not self.db.account.book[page].z and self.db.account.book[page][2] and self.db.account.book[page][2] ~= "" then
		ztext = lzw:compress(self.db.account.book[page][2])
		if strlen(ztext) < strlen(self.db.account.book[page][2]) then
			self.db.account.book[page][2] = ztext
			self.db.account.book[page].z = true
		end
	end
end

-- toggles window on/off screen
function Omnibus:Toggle()
	if OmnibusFrame:IsVisible() then
		OmnibusFrame:Hide()
	else
		OmnibusFrame:Show()
	end
end

-- window movement
function Omnibus:StartMoving(arg1)
	if arg1=="LeftButton" and not self.db.account.Lock then
		OmnibusFrame:StartMoving()
		self.moving = true
	end
end

function Omnibus:StopMoving(arg1)
	if arg1=="LeftButton" then
		OmnibusFrame:StopMovingOrSizing()
		self.moving = nil
	end
end

function Omnibus:GetMoving()
	return self.moving
end

function Omnibus:Tooltip(which)
	GameTooltip_SetDefaultAnchor(GameTooltip,UIParent)
	GameTooltip:AddLine(controls[which][1])
	GameTooltip:AddLine(controls[which][2],.85,.85,.85,1)
	GameTooltip:Show()
end

--Fubar click
function Omnibus:OnClick(button)
	if button ~= "LeftButton" then return end
	self:Toggle()
end

-- Titlebar button clicks
function Omnibus:ButtonClick(which)
	self[which.."OnClick"](self)
end

function Omnibus:OmnibusUndoOnClick()
	OmnibusEditBox:SetText(self:PageText(self.db.account.current_page))
	self:HideFileList()
end

function Omnibus:OmnibusNewOnClick()
	local new_page = {L["Untitled"],self.db.account.template or ""}
	table.insert(self.db.account.book,new_page)
	self:SortPages()
	self:SetPage(self:FindPageIndex(new_page))
	self:UpdateTooltip()
	self:HideFileList()
end

function Omnibus:FindPageIndex(page)
	for i,p in ipairs(self.db.account.book) do if p == page then return i end end
	return 0
end

function Omnibus:OmnibusDeleteOnClick()
	self:HideFileList()
	if not IsShiftKeyDown() and string.len(self.db.account.book[self.db.account.current_page][2])>0 then
		StaticPopup_Show("OMNIBUSCONFIRM")
	else
		self:DeletePage() -- delete empty pages without confirmation
	end
end

function Omnibus:OmnibusRunOnClick()
	self.db.account.book[self.db.account.current_page][2] = OmnibusEditBox:GetText()
	self.db.account.book[self.db.account.current_page].z = nil
	OmnibusUndo:Disable()
	self:HideFileList()
	RunScript(self.db.account.book[self.db.account.current_page][2])
end

function Omnibus:OmnibusStartOnClick()
	self:SetPage(1)
	self:HideFileList()
end

function Omnibus:OmnibusLeftOnClick()
	self:SetPage(self:PrevPage())
	self:HideFileList()
end

function Omnibus:PrevPage()
	return math.max(1,self.db.account.current_page-1)
end

function Omnibus:OmnibusRightOnClick()
	self:SetPage(self:NextPage())
	self:HideFileList()
end

function Omnibus:OmnibusSendToOnClick()
	-- toggle the send to box with the navigation stuff.
	self.sendToShown = not self.sendToShown
	if self.sendToShown then
		OmnibusSendToEditBox:SetText(L["Send To:"])
		OmnibusSendToEditBox:Show()
		OmnibusStart:Hide()
		OmnibusLeft:Hide()
		OmnibusTitleEditBox:Hide()
		OmnibusRight:Hide()
		OmnibusEnd:Hide()
		OmnibusDropButton:Hide()
	else
		OmnibusSendToEditBox:Hide()
		OmnibusStart:Show()
		OmnibusLeft:Show()
		OmnibusTitleEditBox:Show()
		OmnibusRight:Show()
		OmnibusEnd:Show()
		OmnibusDropButton:Show()
	end
	self:HideFileList()
end

function Omnibus:NextPage()
	return math.min(table.getn(self.db.account.book),self.db.account.current_page+1)
end

function Omnibus:OmnibusEndOnClick()
	self:SetPage(table.getn(self.db.account.book))
	self:HideFileList()
end

function Omnibus:OmnibusCloseOnClick()
	self.db.account.book[self.db.account.current_page][2] = OmnibusEditBox:GetText()
	self.db.account.book[self.db.account.current_page].z = nil
	OmnibusFrame:Hide()
end

function Omnibus:OmnibusLockOnClick()
	self.db.account.Lock = not self.db.account.Lock
	self:UpdateLock()
	self:HideFileList()
end

function Omnibus:OmnibusFontOnClick()
	self.db.account.Font = self.db.account.Font+1
	self:UpdateFont()
	self:HideFileList()
end

function Omnibus:OmnibusSearchOnClick()
	if OmnibusSearchFrame:IsVisible() then
		OmnibusSearchFrame:Hide()
	else
		OmnibusSearchFrame:Show()
	end
	self:HideFileList()
end

function Omnibus:OmnibusSearchNextOnClick()
	self:DoSearch()
	self:HideFileList()
end

function Omnibus:OmnibusImportOnClick()
	self:ImportTinyPadPages()
	self:HideFileList()
end

function Omnibus:OmnibusSetDefaultOnClick()
	if IsControlKeyDown() then self:SetDefaultText(self:TempPageText(self.db.account.current_page)) end
	local dialog = StaticPopup_Show("OMNIBUSSETDEFAULTTEXT")
	dialog.data = self:TempPageText(self.db.account.current_page)
end

function Omnibus:SetDefaultText(text)
	self.db.account.template = text
end

function Omnibus:HideFileList()
	OmnibusFileList:Hide()
	for i = 1, maxtempframes do
		local entry = getglobal("OmnibusFileListEntry"..i)
		if entry then
			entry:Hide()
		end
	end
	OmnibusFileListFrame:Hide()
	self.dropFrameShown = nil
end

function Omnibus:ShowFileList()
	OmnibusFileList:Show()
	local offset = FauxScrollFrame_GetOffset(OmnibusFileList)
	for i = 1, maxtempframes do
		local entry = getglobal("OmnibusFileListEntry"..i)
		if entry and self.db.account.book[i+offset] then
			entry:Show()
		end
	end
	OmnibusFileListFrame:Show()
	self.dropFrameShown = true
end

function Omnibus:OmnibusDropButtonOnClick()
	if self.dropFrameShown then
		self:HideFileList()
	else
		self:ShowFileList()
	end
end

function Omnibus:StartDelayedHideFileList()
	self:ScheduleEvent("omnibusDelayedHideFiles",self.HideFileList,5,self,true)
end

function Omnibus:CancelDelayedHideFileList()
	self:CancelScheduledEvent("omnibusDelayedHideFiles")
end

function Omnibus:SetPage(new_page)
	self.db.account.book[self.db.account.current_page][2] = OmnibusEditBox:GetText()
	self.db.account.book[self.db.account.current_page].z = nil
	self:CompressPage(self.db.account.current_page)
	self.db.account.current_page = new_page
	self:ShowPage()
end

-- removes the current page
function Omnibus:DeletePage()
	table.remove(self.db.account.book,self.db.account.current_page)
	if table.getn(self.db.account.book) == 0 then
		table.insert(self.db.account.book,{L["Untitled"],self.db.account.template or ""})
	end
	self.db.account.current_page = math.min(self.db.account.current_page,table.getn(self.db.account.book))
	self:ShowPage()
	self:UpdateTooltip()
	--self:FileListUpdate()
end

-- disables/enables page movement buttons depending on page
function Omnibus:ValidateButtons()

	-- nil for disabled, 1 for enabled
	local function set_state(button,enabled)
		if enabled then
			button:SetAlpha(1)
			button:Enable()
		else
			button:SetAlpha(.5)
			button:Disable()
		end
	end

	set_state(OmnibusStart,1)
	set_state(OmnibusLeft,1)
	set_state(OmnibusRight,1)
	set_state(OmnibusEnd,1)

	if self.db.account.current_page == 1 then
		set_state(OmnibusStart)
		set_state(OmnibusLeft)
	end
	if self.db.account.current_page == table.getn(self.db.account.book) then
		set_state(OmnibusRight)
		set_state(OmnibusEnd)
	end
end

-- shows/updates the current page
function Omnibus:ShowPage()
	if not OmnibusFrame:IsVisible() then
		OmnibusFrame:Show()
	end
	if self.db.account.book[self.db.account.current_page] then
		OmnibusTitleEditBox:SetText(self.db.account.book[self.db.account.current_page][1])
		OmnibusEditBox:SetText(self:PageText(self.db.account.current_page))
		self:ValidateButtons()
	end
end

-- refreshes window when shown
function Omnibus:OnShow()
	self:ShowPage()
	self:HideFileList()
	OmnibusEditBox:SetWidth(OmnibusFrame:GetWidth()-50)
	self.sendToShown = nil
	OmnibusSendToEditBox:Hide()
	OmnibusStart:Show()
	OmnibusLeft:Show()
	OmnibusTitleEditBox:Show()
	OmnibusRight:Show()
	OmnibusEnd:Show()
end

-- saves page when window hides
function Omnibus:OnHide()
	self.db.account.book[self.db.account.current_page][2] = OmnibusEditBox:GetText()
	self.db.account.book[self.db.account.current_page].z = nil
	OmnibusUndo:Disable()
	OmnibusEditBox:ClearFocus()
end

-- changes border and resize grip depending on lock status
function Omnibus:UpdateLock()
	if self.db.account.Lock then
		OmnibusFrame:SetBackdropBorderColor(0,0,0,1)
		OmnibusSearchFrame:SetBackdropBorderColor(0,0,0,1)
		OmnibusResizeGrip:Hide()
	else
		OmnibusFrame:SetBackdropBorderColor(1,1,1,1)
		OmnibusSearchFrame:SetBackdropBorderColor(1,1,1,1)
		OmnibusResizeGrip:Show()
	end
	self:MakeESCable("OmnibusFrame",self.db.account.Lock)
end

-- updates EditBox font to current settings
function Omnibus:UpdateFont()
	if self.db.account.Font > table.getn(fonts) then
		self.db.account.Font = 1
	end
	local font = self.db.account.Font
	OmnibusEditBox:SetFont(fonts[font][1],fonts[font][2],fonts[font][3])
end

-- adds frame to UISpecialFrames, removes frame if disable true
function Omnibus:MakeESCable(frame,disable)
	local idx
	for i=1,table.getn(UISpecialFrames) do
		if UISpecialFrames[i]==frame then
			idx = i
			break
		end
	end
	if idx and disable then
		table.remove(UISpecialFrames,idx)
	elseif not idx and not disable then
		table.insert(UISpecialFrames,1,frame)
	end
end
	
-- when search summoned, remove ESCability of main window (only search cleared with ESC)
function Omnibus:SearchOnShow()
	self:MakeESCable("OmnibusFrame","disable")
	if IsAddOnLoaded("TinyPad") then
		OmnibusImport:Show()
		OmnibusLock:SetPoint("TOPLEFT",OmnibusImport,"TOPRIGHT",2,0)
		OmnibusSearchNext:SetPoint("RIGHT",-86,0)
	else
		OmnibusImport:Hide()
		OmnibusLock:SetPoint("TOPLEFT",OmnibusSetDefault,"TOPRIGHT",2,0)
		OmnibusSearchNext:SetPoint("RIGHT",-66,0)
	end
end

-- when search dismissed, restore ESCability to main window and reset search elements
function Omnibus:SearchOnHide()
	if not self.db.account.Lock then
		self:MakeESCable("OmnibusFrame")
	end
	OmnibusSearchResults:SetText(L["Search:"])
	OmnibusSearchEditBox:ClearFocus()
end

-- does a count
function Omnibus:SearchEditBoxOnChange()
	local search = string.lower(OmnibusSearchEditBox:GetText() or "")
	if string.len(search)<1 then
		OmnibusSearchResults:SetText(L["Search:"])
	else
		local count = 0
		for i,page in pairs(self.db.account.book) do
			count = count + (string.find(string.lower(self:TempPageText(i)),search,1,1) and 1 or 0)
		end
		OmnibusSearchResults:SetText(format(L["%d found"],count))
	end
end

function Omnibus:ChangeTitle()
	local curpage = self.db.account.book[self.db.account.current_page]
	curpage[1] = OmnibusTitleEditBox:GetText()
	self:SortPages()
	self:SetPage(self:FindPageIndex(curpage))
	self:ValidateButtons()
	OmnibusEditBox:SetFocus()
end

function Omnibus:SortPages()
	table.sort(self.db.account.book,function(a,b) return a[1] < b[1] end)
	--self:FileListUpdate()
end

-- performs a search for the text in the search box
function Omnibus:DoSearch()
	local start = self.db.account.current_page + 1
	if start > table.getn(self.db.account.book) then start = 1 end
	self.db.account.book[self.db.account.current_page][2] = OmnibusEditBox:GetText()
	self.db.account.book[self.db.account.current_page].z = nil
	local search = string.lower(OmnibusSearchEditBox:GetText() or "")
	if string.len(search)<1 then
		return
	end
	for i = start, table.getn(self.db.account.book) do
		if string.find(string.lower(self:TempPageText(i)),search,1,1) then
			self:CompressPage(self.db.account.current_page)
			self.db.account.current_page = i
			self:ShowPage()
			return
		end
	end
	for i = 1, start - 1 do
		if string.find(string.lower(self:TempPageText(i)),search,1,1) then
			self:CompressPage(self.db.account.current_page)
			self.db.account.current_page = i
			self:ShowPage()
			return
		end
	end
end

function Omnibus:OnTextChanged()
	local scrollBar = getglobal(this:GetParent():GetName().."ScrollBar")
	this:GetParent():UpdateScrollChildRect()
	local min, max = scrollBar:GetMinMaxValues()
	if ( max > 0 and (this.max ~= max) ) then
		this.max = max
		scrollBar:SetValue(max)
	end
	if this:GetText()~=self.db.account.book[self.db.account.current_page][2] then
		OmnibusUndo:Enable()
	else
		OmnibusUndo:Disable()
	end
end

function Omnibus:FileListUpdate()
	local numlines = 10
	if numlines > maxtempframes then
		for i = maxtempframes+1, numlines do
			local f = CreateFrame("Button","OmnibusFileListEntry"..i,OmnibusFrame,"OmnibusFileListEntryTemplate")
			if i == 1 then
				-- need to anchor this to the correct location.  This is different than the other entries.
				f:SetPoint("TOPLEFT",OmnibusFileList,"TOPLEFT",4,-4)
				f:SetPoint("BOTTOMRIGHT",OmnibusFileList,"TOPRIGHT",-4,-22)
			else
				f:SetPoint("TOPLEFT","OmnibusFileListEntry"..(i-1),"BOTTOMLEFT")
				f:SetPoint("BOTTOMRIGHT","OmnibusFileListEntry"..(i-1),"BOTTOMRIGHT",0,-18)
			end
			local highlight = f:CreateTexture(nil, "HIGHLIGHT")
			highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
			f.highlight = highlight
			highlight:SetBlendMode("ADD")
			highlight:SetAllPoints(f)
		end
		maxtempframes = numlines
	elseif numlines < maxtempframes then
		for i = numlines+1, maxtempframes do
			getglobal("OmnibusFileListEntry"..i):Hide()
		end
	end
	FauxScrollFrame_Update(OmnibusFileList,table.getn(self.db.account.book),numlines,18)
	local start = 1 + FauxScrollFrame_GetOffset(OmnibusFileList)
	local stop = start - 1 + numlines
	local framenum = 1
	for line = start, stop do
		if line <= table.getn(self.db.account.book) then
			getglobal("OmnibusFileListEntry"..framenum.."_Text"):SetText(self.db.account.book[line][1])
			getglobal("OmnibusFileListEntry"..framenum):Show()
		else
			getglobal("OmnibusFileListEntry"..framenum):Hide()
		end
		framenum = framenum + 1
	end
end

function Omnibus:FileListEntryClick(framename)
	-- determine the index from the offset of the scrollframe, and the one number to be found in the framename
	local n
	_,_,n = strfind(framename,"(%d+)")
	if not n then return end
	n = n + FauxScrollFrame_GetOffset(OmnibusFileList)
	if n > 0 and n <= table.getn(self.db.account.book) then
		self:SetPage(n)
	end
end

function Omnibus:OnTooltipUpdate()
	local cat = tablet:AddCategory("columns",1)
	cat:AddLine("text",L["Toggle Omnibus Window"],'func',function() Omnibus:Toggle() end)
	cat = tablet:AddCategory("columns",1,"text",L["Pages"])
	for i, page in ipairs(self.db.account.book) do
		local page = page
		cat:AddLine("text",page[1],"func",function()
			if IsControlKeyDown() then
				self:SetPage(self:FindPageIndex(page))
				self:ShowPage()
			else
				if page.z then
					RunScript(lzw:decompress(page[2]))
				else
					RunScript(page[2])
				end
			end
		end)
	end
	tablet:SetHint(L["Click a page to execute it, Ctrl-Click a page to edit."])
end
