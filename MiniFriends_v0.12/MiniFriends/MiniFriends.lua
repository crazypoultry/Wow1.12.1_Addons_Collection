-- MiniFriends by Hedyn Brand

BINDING_HEADER_MINIFRIENDS = "MiniFriends"
MINIFRIENDS_VERSION = "0.12"

MiniFriendsCount = 0
inviter = nil

MFFlags = {}
MFF_Locked = 1 --Make window unmovable
MFF_Visible = 2 --Shown or hidden
MFF_Splash = 3 --Big banners when friends log in or out
MFF_Big = 4 --Even bigger banners
MFF_HideParty = 5 --Don't show friends when you're in a group/raid with them
MFF_AcceptFriends = 6 --Automatically accept party-invitations from friends

MF_Friends = {}
MF_Status = {}
MF_Zone = {}
MF_AllFriends = {}
MF_Party = {} --List of friends in party

local function print(text)
	DEFAULT_CHAT_FRAME:AddMessage(text, 0.75, 0.75, 1)
end

local function banner(text)
	if(MFFlags[MFF_Splash]==false) then
		return
	end
	if(MFFlags[MFF_Big]==true) then
		MiniFriendsSplashFrame:AddMessage(text, 0.75, 0.75, 1, 5.0, UIERRORS_HOLD_TIME)
	else
		UIErrorsFrame:AddMessage(text, 0.75, 0.75, 1, 5.0, UIERRORS_HOLD_TIME)
	end
end

-- Taken from Sea (and modified)
local function split(text, separator)
	local value
   	local mstart, mend = 1
	local oldn, numMatches = 0, 0
	local regexKey = "([^"..separator.."]+)"
	local t = {}

	-- Using string.find instead of string.gfind to avoid garbage generation
	mstart, mend, value = strfind(text, regexKey, mstart)
   	while (value) do
		numMatches = numMatches + 1
		t[numMatches] = value
		mstart = mend + 1
		mstart, mend, value = strfind(text, regexKey, mstart)
   	end

	table.setn(t, numMatches)
	return t
end

function MiniFriends_IsFriend(name)
	for i=1,table.getn(MF_AllFriends) do
		if(MF_AllFriends[i] == name) then
			return true
		end
	end
	return false
end

function MiniFriends_IsParty(name)
	for i=1,table.getn(MF_Party) do
		if(MF_Party[i] == name) then
			return true
		end
	end
	return false
end

function MiniFriends_OnLoad()
	this:RegisterForDrag("LeftButton")
	this:RegisterEvent("VARIABLES_LOADED")
	this:RegisterEvent("CHAT_MSG_SYSTEM")
	this:RegisterEvent("FRIENDLIST_UPDATE")
	this:RegisterEvent("PARTY_MEMBERS_CHANGED")
	this:RegisterEvent("PARTY_INVITE_REQUEST")

	SLASH_MINIFRIENDS1 = "/minifriends"
	SlashCmdList["MINIFRIENDS"] = MiniFriends_Command

--	NewInvite = StaticPopupDialogs["PARTY_INVITE"]
--	OldOnshow = NewInvite.OnShow
--	NewInvite.Onshow = MiniFriends_AcceptInvite

	print("MiniFriends "..MINIFRIENDS_VERSION.." loaded.")
end

local function MiniFriends_AcceptInvite()
print("MiniFriends_AcceptInvite() fired")
	if(MFFlags[MFF_AcceptFriends]) then
print("MiniFriends_AcceptInvite() accepting friends")
		if(MiniFriends_IsFriend(inviter)) then
print("MiniFriends_AcceptInvite() recognised friend")
			this:Hide()
		end
	else
print("MiniFriends_AcceptInvite() found a stranger")
		OldOnShow()
	end
	inviter = 0
end

function MiniFriends_OnEvent()
	local name, i, maxmembers

	if(event == "VARIABLES_LOADED") then
		if(not MFFlags[MFF_Locked]) then
			MFFlags[MFF_Locked] = false
			MFFlags[MFF_Visible] = true
			MFFlags[MFF_Splash] = true
			MFFlags[MFF_Big] = false
			MFFlags[MFF_HideParty] = false
			MFFlags[MFF_AcceptFriends] = false
		end
		MiniFriendsList_Update()
	end
	if(event == "FRIENDLIST_UPDATE") then
		MiniFriends_RebuildList()
	end
	if(event == "CHAT_MSG_SYSTEM") then
	-- Check for login/logout, but ignore guildies not in friends list
		local myargs = split(arg1, " ")
		if(myargs[4] == "online.") then
			name = gsub(myargs[1], "%[", "")
			name = gsub(name, "%]", "")
			if(MiniFriends_IsFriend(name)) then
				banner(name .. " just logged in")
			end
			return
		end
		if(myargs[4] == "offline.") then
			--name = gsub(myargs[1], "%[", "")
			--name = gsub(name, "%]", "")
			if(MiniFriends_IsFriend(name)) then
				banner(name .. " just logged out")
			end
			return
		end
		ShowFriends()
	end
	if(event == "PARTY_MEMBERS_CHANGED") then
	-- This event is fired quite a bit, but hopefully it won't be
	-- too much of a strain on the system to gather a partylist here
		maxmembers = GetNumRaidMembers()
		MF_Party = {}
		if(maxmembers > 0) then --We're in a raid if this is non-zero
			for i=1,maxmembers,1 do
				name = GetRaidRosterInfo(i)
				MiniFriends_HideIfFriend(name)
			end
		else --Regular group, or alone
			maxmembers = GetNumPartyMembers()
			for i=1,maxmembers,1 do
				name = GetPartyMember(i)
				MiniFriends_HideIfFriend(name)
			end
		end
		MiniFriendsList_Update()
	end
	if(event == "PARTY_INVITE_REQUEST") then
		inviter = arg1
		if(MFFlags[MFF_AcceptFriends]) then
			if(MiniFriends_IsFriend(arg1)) then
				local inv=StaticPopupDialogs["PARTY_INVITE"]
				inv.Hide()
--if(not AUTOACCEPTPARTY)then 
--	AUTOACCEPTPARTY=t.OnShow 
--	t.OnShow=function()
--	AcceptGroup()
--	this:Hide()
--end
--else
--	t.OnShow=AUTOACCEPTPARTY
--	AUTOACCEPTPARTY=nil

				AcceptGroup()
			end
		end
	end
end

-- Check if a name is a friend, and add to list of grouped friends if it is,
-- and the HideParty flag is also true
function MiniFriends_HideIfFriend(name)
	if(MiniFriends_IsFriend(name)) then
		if (MFFlags[HideParty]) then
			table.insert(MF_Party, name)
		end
	end
end

function MiniFriends_Command(cmd)
	if(cmd == "on") then
		MiniFriendsFrame:Show()
		return
	end
	if(cmd == "off") then
		MiniFriendsFrame:Hide()
		return
	end
	if(cmd == "lock") then
		MFFlags[MFF_Locked] = true
		print("MiniFriends window locked")
		return
	end
	if(cmd == "unlock") then
		MFFlags[MFF_Locked] = false
		print("MiniFriends window can now be moved")
		return
	end
	if(cmd == "nosplash") then
		MFFlags[MFF_Splash] = false
		print("MiniFriends splash messages have been turned off")
		return
	end
	if(cmd == "splash") then
		MFFlags[MFF_Splash] = true
		print("MiniFriends splash messages have been turned on")
		return
	end
	if(cmd == "nobig") then
		MFFlags[MFF_Big] = false
		print("MiniFriends now displays small splash messages")
		return
	end
	if(cmd == "big") then
		MFFlags[MFF_Big] = true
		print("MiniFriends now displays big splash messages")
		return
	end
	if(cmd == "hideparty") then
		MFFlags[MFF_HideParty] = true
		print("MiniFriends will hide friends who are in your group or raid")
		return
	end
	if(cmd == "showparty") then
		MFFlags[MFF_HideParty] = false
		print("MiniFriends will show friends who are in your group or raid")
		return
	end
	if(cmd == "autoacceptfriends") then
		MFFlags[MFF_AcceptFriends] = true
		print("Group invitations from friends will automatically be accepted")
		return
	end
	if(cmd == "noautoacceptfriends") then
		MFFlags[MFF_AcceptFriends] = false
		print("Group invitations from friends will automatically be accepted")
		return
	end
	print("MiniFriends "..MINIFRIENDS_VERSION.." options:")
	print("/minifriends on - shows the window")
	print("/minifriends off - hides the window")
	print("/minifriends lock - makes the window unmovable")
	print("/minifriends unlock - makes it movable again")
	print("/minifriends nosplash - switches off the large banner when friends log in or out")
	print("/minifriends splash - enables the banner again")
	print("/minifriends nobig - displays small banners")
	print("/minifriends big - makes the banners grow again")
	print("/minifriends hideparty - hide friends that are in your group or raid")
	print("/minifriends showparty - show friends even when grouped")
	print("/minifriends autoacceptfriends - Accept group invitations from friends unquestioningly")
	print("/minifriends noautoacceptfriends - Pop up group invitation box even for friends")
end

function MiniFriends_Toggle()
	if (MFFlags[MFF_Visible] == false) then
		MiniFriendsFrame:Show()
	else
		MiniFriendsFrame:Hide()
	end
end

function MiniFriends_OnEnter(friend, myframe)
	local cname, name, class, level, loc, status, surname, guild, count, f

	ShowFriends()
	local anchorstyle = "ANCHOR_LEFT"
	local x,y = MiniFriendsFrame:GetCenter()
	local sw = UIParent:GetWidth()
	if (x~=nil and sw~=nil) then
		if (x < (sw / 2)) then
			anchorstyle = "ANCHOR_RIGHT"
		end
	end

	count = GetNumFriends()
	for f=1,count do
		name, level, class, loc, _, status = GetFriendInfo(f)
		if (friend == name) then
			break
		end
	end

	surname = nil
	firstname = name
	title = nil

	--Check for FlagRSP and add lastname
	if(IsAddOnLoaded("FlagRSP")) then
		guild = Friendlist.getGuild(name)
		if(guild and guild~="") then
			guild = "<"..guild..">"
		end
		surname = TooltipHandler.getSurname(name)
		if(surname) then
			name = name .." ".. surname
		end
	end

--ImmersionRPCharacterInfo["NAMETYPE"]
	--Same for ImmersionRP
	if(IsAddOnLoaded("ImmersionRP")) then
		name = ImmersionRPDatabaseHandler.GetPlayerName(firstname)
		title = ImmersionRPDatabaseHandler.GetFlag(firstname, "TITLE")
--		guild = GetGuildInfo(firstname)
	end

	MiniFriendsTooltip:SetOwner(myframe, anchorstyle)
	MiniFriendsTooltip:SetText(name)
	if(title) then
		MiniFriendsTooltip:AddLine(title)
	end
	if(guild) then
		guild = "Member of "..guild
		MiniFriendsTooltip:AddLine(guild)
	end
	MiniFriendsTooltip:AddLine(class.."("..level..")")
	MiniFriendsTooltip:AddLine(loc)
	if(status) then
		MiniFriendsTooltip:AddLine(status)
	end

	--Check for CT_PlayerNotes and add these
	if(IsAddOnLoaded("CT_PlayerNotes")) then
		if ( CT_PlayerNotes[firstname] ) then
			MiniFriendsTooltip:AddLine(CT_PlayerNotes[firstname])
		end
	end

	MiniFriendsTooltip:Show()
end

function MiniFriends_OnLeave()
	MiniFriendsTooltip:Hide()
end

function MiniFriends_MenuOffset()
	local xoffset = -30
	local yoffset = 20
	local x,y,sw

	x,y = MiniFriendsFrame:GetCenter()
	sw = UIParent:GetWidth()
	if (x~=nil and sw~=nil) then
		if (sw-x < 100) then
			xoffset = xoffset-50
		end
	end
	return xoffset,yoffset
end

function MiniFriends_OnClick(friend, button)
	if(button == "LeftButton") then
		if(not ChatFrameEditBox:IsVisible() ) then
			ChatFrame_OpenChat("/w "..friend.." ")
		else
			ChatFrameEditBox:SetText("/w "..friend.." ")
		end
		ChatEdit_ParseText(ChatFrame1.editBox, 0)
	else
		HideDropDownMenu(1)
		MiniFriendsTooltip:Hide()
		MiniFriendsMenu.initialize = MiniFriends_MenuInit
		MiniFriendsMenu.displayMode = "MENU"
		MiniFriendsMenu.name = friend
		local xoffset, yoffset = MiniFriends_MenuOffset()
		ToggleDropDownMenu(1, nil, MiniFriendsMenu, "cursor", xoffset, yoffset)
	end
end

function MiniFriends_OnClickOptions(button)
	if(button == "LeftButton") then
	else
		HideDropDownMenu(1)
		MiniFriendsTooltip:Hide()
		MiniFriendsMenu.initialize = MiniFriends_MainMenuInit
		MiniFriendsMenu.displayMode = "MENU"
		MiniFriendsMenu.name = "MiniFriends"
		local xoffset, yoffset = MiniFriends_MenuOffset()
		ToggleDropDownMenu(1, nil, MiniFriendsMenu, "cursor", xoffset, yoffset)
	end
end

function MiniFriends_MainMenuInit()
	-- #1
	entry = {}
	entry.text = "Login banner"
	entry.value = MFF_Splash
	if(MFFlags[MFF_Splash]) then
		entry.checked = 1
	end
	entry.func = MiniFriends_ToggleVar
	entry.keepShownOnClick = 1
	UIDropDownMenu_AddButton(entry)

	-- #2
	entry = {}
	entry.text = "Big banner"
	entry.value = MFF_Big
	if(MFFlags[MFF_Big]) then
		entry.checked = 1
	end
	entry.func = MiniFriends_ToggleVar
	entry.keepShownOnClick = 1
	UIDropDownMenu_AddButton(entry)

	-- #3
	entry = {}
	entry.text = "Lock window"
	entry.value = MFF_Locked
	if(MFFlags[MFF_Locked]) then
		entry.checked = 1
	end
	entry.keepShownOnClick = 1
	entry.func = MiniFriends_ToggleVar
	UIDropDownMenu_AddButton(entry)

	-- #4
	entry = {}
	entry.text = "Hide friends in group"
	entry.value = MFF_HideParty
	if(MFFlags[MFF_HideParty]) then
		entry.checked = 1
	end
	entry.keepShownOnClick = 1
	entry.func = MiniFriends_ToggleVar
	UIDropDownMenu_AddButton(entry)

	-- #5
	entry = {}
	entry.text = "Accept friendly inv."
	entry.value = MFF_AcceptFriends
	if(MFFlags[MFF_AcceptFriends]) then
		entry.checked = 1
	end
	entry.keepShownOnClick = 1
	entry.func = MiniFriends_ToggleVar
	UIDropDownMenu_AddButton(entry)

	-- #6
	entry = {}
	entry.text = "Hide window"
	entry.func = MiniFriends_MainMenuHandler
	UIDropDownMenu_AddButton(entry)

	entry = {}
	entry.text = "Cancel"
	entry.func = MiniFriends_MainMenuHandler
	UIDropDownMenu_AddButton(entry)
end

function MiniFriends_MainMenuHandler()
	local menuid = this:GetID()
	if(menuid==6) then
		MiniFriendsFrame:Hide()
		return
	end
end

function MiniFriends_ToggleVar()
	myvar = this.value
	MFFlags[myvar] = not MFFlags[myvar]
end

function MiniFriends_MenuInit()
	entry = {}
	entry.text = "Remove"
	entry.func = MiniFriends_MenuHandler
	UIDropDownMenu_AddButton(entry)

	entry = {}
	entry.text = "Invite"
	entry.func = MiniFriends_MenuHandler
	UIDropDownMenu_AddButton(entry)

	entry = {}
	entry.text = "Cancel"
	entry.func = MiniFriends_MenuHandler
	UIDropDownMenu_AddButton(entry)
end

function MiniFriends_MenuHandler()
	local menuid = this:GetID()
	local friend = MiniFriendsMenu.name

	if(menuid==1) then
		StaticPopupDialogs["MINIFRIENDS_REMOVE"] = {
			text = "Do you really want to remove "..friend.." from your list?",
			button1 = "Yes",
			button2 = "No",
			OnAccept = function()
				RemoveFriend(friend)
				end,
			timeout = 0,
			whileDead = 1,
			hideOnEscape = 1
		}
		StaticPopup_Show("MINIFRIENDS_REMOVE")
	end
	if(menuid==2) then
		InviteByName(friend)
	end
end

function MiniFriends_RebuildList()
	local name, level, class, area, status

	MiniFriendsCount = GetNumFriends()
	MF_Friends = {}
	MF_Status = {}
	for f=1,MiniFriendsCount do
		name, level, class, area, connected, status = GetFriendInfo(f)
		MF_AllFriends[f] = name
		if(connected) then
			if(MiniFriends_IsParty(name)) then
				MiniFriendsCount = MiniFriendsCount -1
			else
				MF_Friends[f] = name
				if(status == "<AFK>") then
					MF_Status[f] = "AFK"
				end
				if(status == "<DND>") then
					MF_Status[f] = "DND"
				end
				MF_Zone[f] = area
			end
		else
			MiniFriendsCount = MiniFriendsCount -1
		end
	end
	MiniFriendsList_Update()
end

function MiniFriendsList_Update()
	local line
	local offset
	local max=MiniFriendsCount+1
	local myzone = GetZoneText()

	FauxScrollFrame_Update(MiniFriendsList,MiniFriendsCount,5,16)

	for line=1,5 do
		offset = line + FauxScrollFrame_GetOffset(MiniFriendsList)
		if(offset < max) then
			getglobal("FriendEntry" .. line .. "_Text"):SetTextColor(1,1,1)
			getglobal("FriendEntry" .. line .. "_Text"):SetText(MF_Friends[offset])
			if(MF_Zone[offset] == myzone) then
				getglobal("FriendEntry" .. line .. "_Text"):SetTextColor(0,0.75,0)
			end
			if(MF_Status[offset] == "AFK") then
				getglobal("FriendEntry" .. line .. "_Text"):SetTextColor(1,0,0)
			end
			if(MF_Status[offset] == "DND") then
				getglobal("FriendEntry" .. line .. "_Text"):SetTextColor(1,0,1)
			end
			getglobal("FriendEntry"..line):Show()
		else
			getglobal("FriendEntry" .. line):Hide()
		end
	end
end
