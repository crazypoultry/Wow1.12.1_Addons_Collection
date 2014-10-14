-----------------------
-- TeamSpeak monitor --
-----------------------

local meSpeaking = false
local meSpeakChannel
local endSpeaking
local speakerIcons = {}
local Speaking = {}
local functions = {}
local tsFrame

if (not XPerlColourTable) then
	local function MashXX(class)
		local c = RAID_CLASS_COLORS[class]
		XPerlColourTable[class] = string.format("|c00%02X%02X%02X", 255 * c.r, 255 * c.g, 255 * c.b)
	end
	XPerlColourTable = {}
	MashXX("HUNTER")
	MashXX("WARLOCK")
	MashXX("PRIEST")
	MashXX("PALADIN")
	MashXX("MAGE")
	MashXX("ROGUE")
	MashXX("DRUID")
	MashXX("SHAMAN")
	MashXX("WARRIOR")
end

XPerlTeamSpeak = {}

-- CheckOnUpdate
local function CheckOnUpdate()
	local any
	if (endSpeaking) then
		any = true
	else
		for k,v in pairs(speakerIcons) do
			any = true
			break
		end
	end

	if (any) then
		XPerl_TeamSpeak_Events:SetScript("OnUpdate", XPerl_TeamSpeak_OnUpdate)
	else
		XPerl_TeamSpeak_Events:SetScript("OnUpdate", nil)
		XPerl_TeamSpeakIcon:SetTexCoord(0.75, 1, 0, 1)
	end
end

-- XPerl_BarUpdate
local speakerTimer = 0
local speakerCycle = 0
function XPerl_TeamSpeak_OnUpdate()

	if (endSpeaking) then
		if (GetTime() >= endSpeaking) then
			endSpeaking = nil
			if (meSpeakChannel) then
				SendAddonMessage(XPERL_COMMS_PREFIX, "NOSPEAK", meSpeakChannel)
			end
			CheckOnUpdate()
		end
	end

	speakerTimer = speakerTimer + arg1
	if (speakerTimer >= 0.1) then
		speakerTimer = 0
		speakerCycle = speakerCycle + 1
		if (speakerCycle > 6) then
			speakerCycle = 0
		end

		local left
		if (speakerCycle > 3) then
			left = (6 - speakerCycle) / 4
		else
			left = speakerCycle / 4
		end
		local right = left + 0.25

		local any
		for k,v in pairs(speakerIcons) do
			v:SetTexCoord(left, right, 0, 1)
			any = true
		end
		if (any) then
			XPerl_TeamSpeakIcon:SetTexCoord(left, right, 0, 1)
		else
			XPerl_TeamSpeakIcon:SetTexCoord(0.75, 1, 0, 1)
		end
	end
end

-- SetInfoText
local function SetInfoText()
	local sorter = {}
	for k,v in pairs(Speaking) do
		tinsert(sorter, {name = k, time = GetTime()})
	end
	sort(sorter, function(a,b) return a.time < b.time end)

	local text = ""
	for k,v in pairs(sorter) do
		if (text ~= "") then
			text = text..", "
		end

		if (UnitName("player") == v.name) then
			local _, class = UnitClass("player")
			text = text..XPerlColourTable[class]
		elseif (UnitInRaid("player")) then
			local name, rank, subgroup, level, _, class
			for i = 1,GetNumRaidMembers() do
				name, rank, subgroup, level, _, class = GetRaidRosterInfo(i)
				if (name == v.name) then
					text = text..XPerlColourTable[class]
					break
				end
			end
		elseif (UnitInParty("player")) then
			for i = 1,GetNumPartyMembers() do
				if (UnitName("party"..i) == v.name) then
					local _, class = UnitClass("party"..i)
					text = text..XPerlColourTable[class]
					break
				end
			end
		end

		text = text..v.name
	end
	XPerl_TeamSpeakText:SetText(text)
end


-- It won't send repetative SPEAK, NOSPEAK messages if you spam the button.
-- Will instead join them together until speak button released for at least 1 second

-- XPerl_TeamSpeakToggle
function XPerl_TeamSpeakToggle(keystate)
	local myName = UnitName("player")

	if (keystate == "down") then
		meSpeaking = true
		Speaking[myName] = GetTime()
		if (not endSpeaking) then
			if (UnitInRaid("player")) then
				meSpeakChannel = "RAID"
			elseif (UnitInParty("player")) then
				meSpeakChannel = "PARTY"
			end
			if (meSpeakChannel) then
				SendAddonMessage(XPERL_COMMS_PREFIX, "SPEAK", meSpeakChannel)
			end
		else
			endSpeaking = nil
		end
	else
		Speaking[myName] = nil
		if (meSpeaking) then
			meSpeaking = false
			-- We speak for at least 1 second. This way spamming the speak button won't send a lot of traffic out
			endSpeaking = GetTime() + 1
		end
	end

	if (functions.player) then
		functions.player(meSpeaking)
	end
	if (functions.raid) then
		functions.raid(myName, meSpeaking)
	end
	if (XPerl_TeamSpeak_Frame:IsShown()) then
		SetInfoText()
	end

	CheckOnUpdate()
end

-- UpdateSpeakers
local function UpdateSpeaker(name, speaking)
	if (functions.player and name == UnitName("player")) then
		functions.player(speaking)
	end
	if (functions.party) then
		functions.party(name, speaking)
	end
	if (functions.raid) then
		functions.raid(name, speaking)
	end

	if (XPerl_TeamSpeak_Frame:IsShown()) then
		SetInfoText()
	end

	CheckOnUpdate()
end

-- XPerl_TeamspeakMessage
local function XPerl_TeamspeakMessage(name, msg, channel)
	if (name ~= UnitName("player")) then
		if (msg == "SPEAK") then
			if (not Speaking[name]) then
				Speaking[name] = GetTime()
				UpdateSpeaker(name, true)
			end

		elseif (msg == "NOSPEAK") then
			if (Speaking[name]) then
				Speaking[name] = nil
				UpdateSpeaker(name)
			end
		end
	end
end

-- XPerl_ActivateSpeaker
function XPerl_ActivateSpeaker(frame, speaking, anchor)
	if (frame) then
		if (not frame.SpeakerIcon) then
			if (not anchor) then
				anchor = "LEFT"
			end

			frame.SpeakerIcon = frame:CreateTexture(nil, "OVERLAY")
			frame.SpeakerIcon:SetWidth(20)
			frame.SpeakerIcon:SetHeight(20)
			frame.SpeakerIcon:SetPoint(anchor, frame, anchor, 5, -1)
			frame.SpeakerIcon:SetTexture("Interface\\Addons\\XPerl_TeamSpeak\\XPerl_Speakers")
			frame.SpeakerIcon:SetTexCoord(0, 0.25, 0, 1)
		end

		if (speaking) then
			speakerIcons[frame] = frame.SpeakerIcon
			frame.SpeakerIcon:Show()
		else
			speakerIcons[frame] = nil
			frame.SpeakerIcon:Hide()
		end

		CheckOnUpdate()
	end
end

-- XPerl_TeamSpeak_Register
-- Parameters:
--     group = "player"		func = function(speaking)
--     group = "party"		func = function(name, speaking)
--     group = "raid"		func = function(name, speaking)
function XPerl_TeamSpeak_Register(group, func)
	functions[group] = func
end

-- SetupAnchor()
local function SetupAnchor()

	XPerl_TeamSpeakText:ClearAllPoints()

	local r, jH, jV
	if (XPerlTeamSpeak.Anchor == "TOPLEFT") then
		r = "BOTTOMLEFT"
		jH = "LEFT"
		jV = "TOP"
	elseif (XPerlTeamSpeak.Anchor == "TOPRIGHT") then
		r = "BOTTOMRIGHT"
		jH = "RIGHT"
		jV = "TOP"
	elseif (XPerlTeamSpeak.Anchor == "BOTTOMLEFT") then
		r = "TOPLEFT"
		jH = "LEFT"
		jV = "BOTTOM"
	elseif (XPerlTeamSpeak.Anchor == "BOTTOMRIGHT") then
		r = "TOPRIGHT"
		jH = "RIGHT"
		jV = "BOTTOM"
	end

	XPerl_TeamSpeakText:SetPoint(XPerlTeamSpeak.Anchor, XPerl_TeamSpeakIcon, r, 0, 0)
	XPerl_TeamSpeakText:SetJustifyH(jH)
	XPerl_TeamSpeakText:SetJustifyV(jV)
end

-- XPerlTeamspeakSlashCmd()
local function XPerlTeamspeakSlashCmd()
	XPerl_TeamSpeak_Frame:Show()
	SetupAnchor()
end

-- XPerl_GetRaidPosition
if (not XPerl_GetRaidPosition) then
	function XPerl_GetRaidPosition(findName)
		for i = 1,GetNumRaidMembers() do
			if (UnitName("raid"..i) == findName) then
				return i
			end
		end
	end
end

if (not XPerl_GetPartyPosition) then
	function XPerl_GetPartyPosition(findName)
		for i = 1,GetNumPartyMembers() do
			if (UnitName("party"..i) == findName) then
				return i
			end
		end
	end
end

-- SetDefaultHandlers()
local function SetDefaultHandlers()

	if (not functions.player) then
		if (XPerl_Player) then
			functions.player = function(speaking)
				XPerl_ActivateSpeaker(XPerl_Player_NameFrame, speaking)
			end
		elseif (Perl_Player_Frame) then
			functions.player = function(speaking)
				XPerl_ActivateSpeaker(Perl_Player_NameFrame, speaking)
			end
		elseif (Nurfed_player) then
			functions.player = function(speaking)
				XPerl_ActivateSpeaker(Nurfed_player, speaking)
			end
		elseif (NUFPlayerFrame) then
			functions.player = function(speaking)
				XPerl_ActivateSpeaker(NUI_Player_ClickNDragFrame, speaking, "CENTER")
			end
		elseif (PlayerFrame) then
			functions.player = function(speaking)
				XPerl_ActivateSpeaker(PlayerFrame, speaking, "TOP")
			end
		end

		if (XPerl_party1) then
			functions.party = function(name, speaking)
				local id = XPerl_GetPartyPosition(name)
				if (id) then
					local nameFrame = getglobal("XPerl_party"..id.."_NameFrame")
					XPerl_ActivateSpeaker(nameFrame, speaking)
				end
			end
		elseif (Perl_party1) then
			functions.party = function(name, speaking)
				local id = XPerl_GetPartyPosition(name)
				if (id) then
					local nameFrame = getglobal("Perl_party"..id.."_NameFrame")
					XPerl_ActivateSpeaker(nameFrame, speaking)
				end
			end
		elseif (Nurfed_party1) then
			functions.party = function(name, speaking)
				local id = XPerl_GetPartyPosition(name)
				if (id) then
					local frame = getglobal("Nurfed_party"..id)
					XPerl_ActivateSpeaker(frame, speaking)
				end
			end
		elseif (NUFPartyMemberFrame1) then
			functions.party = function(name, speaking)
				local id = XPerl_GetPartyPosition(name)
				if (id) then
					local frame = getglobal("NUIPartyClickNDragFrame"..id)
					XPerl_ActivateSpeaker(frame, speaking, "CENTER")
				end
			end
		elseif (PartyMemberFrame1) then
			functions.party = function(name, speaking)
				local id = XPerl_GetPartyPosition(name)
				if (id) then
					local frame = getglobal("PartyMemberFrame"..id.."Disconnect"):GetParent():GetParent()
					XPerl_ActivateSpeaker(frame, speaking, "LEFT")
				end
			end
		end

		if (XPerl_Raid_Frame) then
			functions.raid = function(name, speaking)
				local id = XPerl_GetRaidPosition(name)
				if (id) then
					local frame = getglobal("XPerl_raid"..id.."_NameFrame")
					if (frame) then
						XPerl_ActivateSpeaker(frame, speaking)
					end
				end
			end
			return
		elseif (Perl_Raid1) then
			functions.raid = function(name, speaking)
				local id = XPerl_GetRaidPosition(name)
				if (id) then
					local frame = getglobal("Perl_Raid"..id.."_NameFrame")
					if (frame) then
						XPerl_ActivateSpeaker(frame, speaking)
					end
				end
			end
		elseif (CT_RAMember1) then
			functions.raid = function(name, speaking)
				local id = XPerl_GetRaidPosition(name)
				if (id) then
					local frame = getglobal("CT_RAMember"..id)
					if (frame) then
						XPerl_ActivateSpeaker(frame, speaking, "TOP")
					end
				end
			end
		elseif (Nurfed_RaidUnit1) then
			functions.raid = function(name, speaking)
				local id = XPerl_GetRaidPosition(name)
				if (id) then
					for i = 1,400 do
						local button = getglobal("Nurfed_RaidUnit"..i)
						if (not button) then
							break
						end
						if (button.id == id) then
							XPerl_ActivateSpeaker(button, speaking, "CENTER")
						end
					end
				end
			end
		end
	end
end

-- XPerl_TeamSpeak_OnEvent
function XPerl_TeamSpeak_OnEvent(event)
	if (event == "CHAT_MSG_ADDON") then
		if (arg1 == "X-Perl") then
			XPerl_TeamspeakMessage(arg4, arg2, arg3)
		end
	elseif (event == "PLAYER_ENTERING_WORLD") then
		this:UnregisterEvent("PLAYER_ENTERING_WORLD")
		if (not XPerlTeamSpeak) then
			XPerlTeamSpeak = {}

			if (XPerl_Player == nil) then
				XPerlTeamSpeak.tsFrame = true
			end
			XPerlTeamSpeak.Anchor = "TOPLEFT"
		end

		SetDefaultHandlers()

		SlashCmdList["XPERL_TEAMSPEAK"] = XPerlTeamspeakSlashCmd
		SLASH_XPERL_TEAMSPEAK1 = "/ts"
		SLASH_XPERL_TEAMSPEAK2 = "/teamspeak"
		SLASH_XPERL_TEAMSPEAK3 = "/ventrilo"
		SLASH_XPERL_TEAMSPEAK4 = "/vent"

		if (XPerlTeamSpeak.tsFrame) then
			XPerl_TeamSpeak_Frame:Show()
			SetupAnchor()
		end
	end
end

-- XPerl_TeamSpeakMenu()
function XPerl_TeamSpeakMenu()
	ToggleDropDownMenu(1, nil, XPerl_TeamSpeak_DropDown, "XPerl_TeamSpeak_Frame", 0, 0)
end

-- XPerl_Teamspeak_Dropdown_OnLoad
function XPerl_Teamspeak_Dropdown_OnLoad()
	UIDropDownMenu_Initialize(this, XPerl_Teamspeak_Dropdown_Initialize, "MENU")
end

-- SetAnchor
local function SetAnchor(a)
	XPerlTeamSpeak.Anchor = a
	HideDropDownMenu(1)
	SetupAnchor()
end

function XPerl_Teamspeak_Dropdown_Initialize()

	local info = {}

	if (UIDROPDOWNMENU_MENU_LEVEL == 2) then
		if (UIDROPDOWNMENU_MENU_VALUE == XPERL_TSMENU_ANCHOR) then
			info = {}
			info.text = XPERL_TSMENU_ANCHOR_TL
			if (XPerlTeamSpeak.Anchor == "TOPLEFT") then
				info.checked = 1
			end
			info.func = function() SetAnchor("TOPLEFT") end
			UIDropDownMenu_AddButton(info, 2)

			info = {}
			info.text = XPERL_TSMENU_ANCHOR_TR
			if (XPerlTeamSpeak.Anchor == "TOPRIGHT") then
				info.checked = 1
			end
			info.func = function() SetAnchor("TOPRIGHT") end
			UIDropDownMenu_AddButton(info, 2)

			info = {}
			info.text = XPERL_TSMENU_ANCHOR_BL
			if (XPerlTeamSpeak.Anchor == "BOTTOMLEFT") then
				info.checked = 1
			end
			info.func = function() SetAnchor("BOTTOMLEFT") end
			UIDropDownMenu_AddButton(info, 2)

			info = {}
			info.text = XPERL_TSMENU_ANCHOR_BR
			if (XPerlTeamSpeak.Anchor == "BOTTOMRIGHT") then
				info.checked = 1
			end
			info.func = function() SetAnchor("BOTTOMRIGHT") end
			UIDropDownMenu_AddButton(info, 2)
		end
		return
	end

	info = {}
	info.text = XPERL_TSMENU_ANCHOR
	info.hasArrow = 1
	info.notCheckable = 1
	UIDropDownMenu_AddButton(info)

	info = {}
	info.text = CLOSE
	info.notCheckable = 1
	info.func = function() XPerl_TeamSpeak_Frame:Hide() end
	UIDropDownMenu_AddButton(info)
end
