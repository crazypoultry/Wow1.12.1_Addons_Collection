BN_TOAST_OFFLINE = "|cffff0000выходит из сети|r.";
BN_TOAST_ONLINE = "|cff00ff00входит в сеть|r.";

local friends = nil;
local friendsN = nil;

local sBNetEventFrame = 0;
local t1,t2,t3,t4 = nil;
local time = nil;
local loaded = false;

local friendsNamesOnline = {};

function BNet_OnLoad()
	friends = GetFriendsOnline();
	friendsN = GetNumFriends();
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("FRIENDLIST_UPDATE");
	updateFriendsTable();
end

function BNet_OnEvent()
	if (event == "FRIENDLIST_UPDATE") then
		if friends > GetFriendsOnline() and (not FriendsFrame:IsShown()) then
			BNToastFrame_Show(whichFriendIsOffline(),2)
-- Print(name)
			updateFriendsTable();
-- Print("Friend left the game.")
		elseif friends < GetFriendsOnline() and (not FriendsFrame:IsShown()) then
			BNToastFrame_Show(whichFriendIsOnline(),1)
-- Print(name)
			updateFriendsTable();
-- Print("Friend joined the game.")
		-- elseif friendsN > GetNumFriends() then
-- Print("Friend deleted from list.")
		-- elseif friendsN < GetNumFriends() then
-- Print("Friend added to list.")
		end
	friends = GetFriendsOnline();
	friendsN = GetNumFriends();
	end
end

function BNet_OnUpdate()
	ShowFriendsFrame();
end

function updateFriendsTable()
	friendsNamesOnline = {};
	local numberOfFriends = GetNumFriends();
	local fCount = 0;
	for i = 1, numberOfFriends, 1 do
		local name, level, class, loc, connected, status = GetFriendInfo(i);
			if connected == 1 then
				table.insert(friendsNamesOnline, name)
			end
	end
	table.sort(friendsNamesOnline)
end

function whichFriendIsOnline()
	local OldFriendsOnlineTable = friendsNamesOnline;
-- Print(getn(OldFriendsOnlineTable));
	updateFriendsTable();
	if getn(OldFriendsOnlineTable) ~= 0 then
		for i = 1, getn(friendsNamesOnline), 1 do
			if friendsNamesOnline[i] ~= OldFriendsOnlineTable[i] then
				return friendsNamesOnline[i];
			end
		end
	end
	return nil;
end

function whichFriendIsOffline()
	local OldFriendsOnlineTable = friendsNamesOnline;
	updateFriendsTable();
	for i = 1, getn(OldFriendsOnlineTable), 1 do
-- Print(OldFriendsOnlineTable[i]);
		if OldFriendsOnlineTable[i] ~= friendsNamesOnline[i] then
			return OldFriendsOnlineTable[i];
		end
	end
	return "nil";
end

function Print(str)
	if ( DEFAULT_CHAT_FRAME ) then 
		ChatFrame1:AddMessage("DEBUG: "..str, 0.67, 0.83, 0.45);
	end
end

function BNToastFrame_Show(string, type)
	if (string) then
		BNToastFrameGlowFrame:Hide();
		BNToastFrame:Hide();
		time = nil;
		t1 = 0;
		BNToastFrameGlowFrame:SetAlpha(0);
		BNToastFrameGlowFrame:Show();
		BNToastFrame:SetAlpha(1)
		BNToastFrame:Show();
		sBNetEventFrame = 1;

		local topLine = BNToastFrameTopLine;
		local middleLine = BNToastFrameMiddleLine;
		local bottomLine = BNToastFrameBottomLine;
		local oStr = nil;
		if type == 1 then
			oStr = BN_TOAST_ONLINE;
		elseif type == 2 then
			oStr = BN_TOAST_OFFLINE;
		end

		topLine:Show();
		topLine:SetText(string);
		bottomLine:Show();
		bottomLine:SetText(oStr);
	end
end

function ShowFriendsFrame()
	if sBNetEventFrame == 1 then
		BNToastFrame:Show();
		if (not time) then time = GetFramerate() * 0.2; end
		if (t1) and t1 < time then
			falpha = (1 / time) * t1;
			BNToastFrameGlowFrame:SetAlpha(falpha)
			t1 = t1 + 1;
		elseif (t1) and t1 > time then
			BNToastFrameGlowFrame:Hide();
			t1 = nil;
			t2 = 0;
			time = GetFramerate() * 0.5;
		elseif (t2) and t2 < time then
			falpha = 1 - (1 / time) * t2;
			BNToastFrameGlowFrame:SetAlpha(falpha)
			t2 = t2 + 1;
		elseif (t2) and t2 > time then
			BNToastFrameGlowFrame:Hide()
			t2 = nil;
			t3 = 0;
			time = GetFramerate() * 3;
		elseif (t3) and t3 < time then
			t3 = t3 + 1;
		elseif (t3) and t3 > time then
			t3 = nil;
			t4 = 0;
			time = GetFramerate() * 0.5;
		elseif (t4) and t4 < time then
			t4 = t4 + 1;
			falpha = 1 - (1 / time) * t4;
			BNToastFrame:SetAlpha(falpha)
		elseif (t4) and t4 > time then
			BNToastFrame:Hide();
			sBNetEventFrame = 0;
			time = nil;
			t4 = nil;
		end
	end
end

