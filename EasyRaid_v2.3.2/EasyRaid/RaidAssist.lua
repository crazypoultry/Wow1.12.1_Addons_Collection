function ER_RaidAssistType()
	if ( CT_RA_VersionNumber ) then
		return "CT_RA";
	elseif ( oRA ) then
		return "oRA";
	end
end

function ER_RaidAssistIsAvailable()
	return ER_RaidAssistType() ~= nil;
end

function ER_RaidAssistVersion()
	if ( ER_RaidAssistType() == "CT_RA" ) then
		return "CT_RA "..CT_RA_VersionNumber;
	elseif ( ER_RaidAssistType() == "oRA" ) then
		return "oRA "..oRA.version;
	end
end

function ER_RaidAssistStatusRequest()
	if ( ER_RaidAssistType() == "CT_RA" ) then
		SlashCmdList["RAUPDATE"]();
	elseif ( ER_RaidAssistType() == "oRA" ) then
		oRA:RequestStatus();
	end
end

function ER_RaidAssistUnitIsAFK(unit)
	local name = UnitName(unit);
	if ( ER_RaidAssistType() == "CT_RA" ) then
		if ( CT_RA_Stats and CT_RA_Stats[name] ) then
			return CT_RA_Stats[name].AFK ~= nil;
		end
	elseif ( ER_RaidAssistType() == "oRA" ) then
		if ( oRA.roster ) then
			local u = oRA.roster:GetUnitObjectFromName(name);
			if ( u ) then
				return u.ora_afk == true;
			end
		end
	end
end

function ER_RaidAssistGetUnitBuffTimeLeft(unit, buffName)
	if ( not unit or not buffName ) then
		return;
	end

	if ( ER_RaidAssistType() == "CT_RA" ) then
		local stats = CT_RA_Stats[UnitName(unit)];
		if ( stats and stats["Buffs"][buffName] ) then
			local timeLeft = stats["Buffs"][buffName][2];
			if ( timeLeft and timeLeft > 0 ) then
				return timeLeft;
			end
		end
	end
end

function ER_RaidAssistHasMTSupport()
	return ER_RaidAssistType() == "CT_RA" or ER_RaidAssistType() == "oRA";
end

function ER_RaidAssistGetMainTanks()
	if ( ER_RaidAssistType() == "CT_RA" ) then
		return CT_RA_MainTanks or { };
	elseif ( ER_RaidAssistType() == "oRA" ) then
		return oRA.maintanktable or { };
	else
		return { };
	end
end

function ER_RaidAssistSetMainTank(number, name)
	if ( ER_RaidAssistType() == "CT_RA" ) then
		CT_RA_SendMessage("SET " .. number .. " " .. name, 1);
	elseif ( ER_RaidAssistType() == "oRA"  ) then
		oRALMainTank:SendMessage("SET " .. number .. " " .. name);
	end
end

function ER_RaidAssistRemoveMainTank(name)
	if ( ER_RaidAssistType() == "CT_RA" ) then
		CT_RA_SendMessage("R " .. name, 1);
	elseif ( ER_RaidAssistType() == "oRA"  ) then
		oRALMainTank:SendMessage("R " .. name);
	end
end