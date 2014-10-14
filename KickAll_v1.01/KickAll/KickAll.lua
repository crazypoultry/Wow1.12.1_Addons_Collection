function KickAll_OnLoad()
	SlashCmdList["KICKALL"] = kickall;
	SLASH_KICKALL1 = "/kickall";
end


function kickall(args)
	
	for i = 1, 40 do
		local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i);
		if (rank ~= 2) then
			UninviteFromRaid(i)
		end

	end
end

