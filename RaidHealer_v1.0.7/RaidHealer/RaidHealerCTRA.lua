function RaidHealer_GetCTRA_MT_Number(name)
	if (CT_RA_MainTanks and table.getn(CT_RA_MainTanks) > 0) then
		for k, v in pairs(CT_RA_MainTanks) do
			if (v == name) then
				return k;
			end
		end
	end
	return 0
end

function RaidHealer_SetCTRA_MT_ByName(name, mtID)
	for k, v in pairs(RaidHealer_RaidMember) do
		if (v and type(v)=="table") then
			for i, p in pairs(v) do
				if (p["NAME"] == name) then
					-- set MT id
					RaidHealer_RaidMember[k][i]["CTRA_MT"] = mtID;
				else
					-- remove mtID from other players
					if (mtID ~= 0 and p["CTRA_MT"] == mtID) then
						RaidHealer_RaidMember[k][i]["CTRA_MT"] = 0;
					end
				end
			end
		end
	end
end

function RaidHealer_ParseCTRA_Message(msg)
	if ( strsub(msg, 1, 4) == "SET " ) then
		local _, _, num, name = string.find(msg, "^SET (%d+) (.+)$");
		if ( num and name ) then
			RaidHealer_SetCTRA_MT_ByName(name, tonumber(num));
		end
		return;
	end
	
	if ( strsub(msg, 1, 2) == "R " ) then
		local _, _, name = string.find(msg, "^R (.+)$");
		if ( name ) then
			RaidHealer_SetCTRA_MT_ByName(name, 0);
		end
		return;
	end
end