function bFriendsButton_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("FRIENDLIST_UPDATE");
end

function GetFriendsOnline()
	local numberOfFriends = GetNumFriends();
	local fCount = 0;
	for i = 1, numberOfFriends, 1 do
		local name, level, class, loc, connected, status = GetFriendInfo(i);
		if connected == 1 then fCount = fCount + 1; end
	end
	return fCount;
end
