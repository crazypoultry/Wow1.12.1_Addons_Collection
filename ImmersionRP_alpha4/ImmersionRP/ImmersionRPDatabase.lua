--[[
	ImmersionRP Alpha 4 database handler file.
	Purpose: Manage the player information database for ImmersionRP.
	Author: Seagale.
	Last update: March 10th, 2007.
	
	NOTE: The database handler ONLY handles the current realm. It will allow NO access to data
		  from other realms to avoid errors. The realm name variable CANNOT be passed to the functions
		  and is hardcoded.
]]
ImmersionRPDatabase = {};
ImmersionRPDatabaseHandler = {};
ImmersionRPDatabaseHandler.PurgeInterval = 1209600; -- Flags older than 14 days (1209600 seconds) will be deleted. Previously 30 days (2592000 seconds)

function ImmersionRPDatabaseHandler.InitialiseDatabase()
	if (ImmersionRPDatabase[ImmersionRP.RealmName] == nil) then
		ImmersionRPDatabase[ImmersionRP.RealmName] = {};
	end
end

function ImmersionRPDatabaseHandler.PurgePlayers()
	local entriespurged = 0;
	local lasttimestamp = time() - ImmersionRPDatabaseHandler.PurgeInterval;
	
	for name, entry in pairs(ImmersionRPDatabase[ImmersionRP.RealmName]) do
		if (entry["LASTSEEN"] == nil or entry["LASTSEEN"] <= lasttimestamp) then
			ImmersionRPDatabase[ImmersionRP.RealmName][name] = nil;
			entriespurged = entriespurged + 1;
		else
			if (entry["EXTRANAME1"] ~= nil and entry["EXTRANAME1"] ~= "") then
				if (entry["NAMETYPE"] == 0 or entry["NAMETYPE"] == nil) then
					ImmersionRPDatabase[ImmersionRP.RealmName][name]["LASTNAME"] = entry["EXTRANAME1"];
				else
					ImmersionRPDatabase[ImmersionRP.RealmName][name]["FIRSTNAME"] = entry["EXTRANAME1"];
				end
				ImmersionRPDatabase[ImmersionRP.RealmName][name]["EXTRANAME1"] = nil;
				ImmersionRPDatabase[ImmersionRP.RealmName][name]["NAMETYPE"] = nil;
			end
		end
	end
	ImmersionRP.PrintMessage(string.format(IRP_STRING_PURGED_FLAGS, entriespurged, ( ImmersionRPDatabaseHandler.PurgeInterval / 86400 )));
end

function ImmersionRPDatabaseHandler.ClearFlags(player)
	ImmersionRPDatabase[ImmersionRP.RealmName][player] = nil;
end

function ImmersionRPDatabaseHandler.ClearRealm()
	ImmersionRPDatabase[ImmersionRP.RealmName] = nil;
	ImmersionRPDatabase[ImmersionRP.RealmName] = {};
end

function ImmersionRPDatabaseHandler.SetFlag(player, flag, value)
	if (ImmersionRPDatabase[ImmersionRP.RealmName][player] == nil) then
		ImmersionRPDatabase[ImmersionRP.RealmName][player] = {};
	end
	
	ImmersionRPDatabase[ImmersionRP.RealmName][player][flag] = value;
	ImmersionRPDatabase[ImmersionRP.RealmName][player]["LASTSEEN"] = time();
end

function ImmersionRPDatabaseHandler.AppendFlag(player, flag, value)
	if (ImmersionRPDatabase[ImmersionRP.RealmName][player] == nil) then
		ImmersionRPDatabase[ImmersionRP.RealmName][player] = {};
	end
	
	if (ImmersionRPDatabase[ImmersionRP.RealmName][player][flag] == nil) then
		ImmersionRPDatabase[ImmersionRP.RealmName][player][flag] = "";
	end
	
	ImmersionRPDatabase[ImmersionRP.RealmName][player][flag] = ImmersionRPDatabase[ImmersionRP.RealmName][player][flag] .. value;
	ImmersionRPDatabase[ImmersionRP.RealmName][player]["LASTSEEN"] = time();
end

function ImmersionRPDatabaseHandler.GetFlag(player, flag)
	if (ImmersionRPDatabase[ImmersionRP.RealmName][player] == nil) then
		return nil;
	end
	if (ImmersionRPDatabase[ImmersionRP.RealmName][player][flag] ~= "") then
		return ImmersionRPDatabase[ImmersionRP.RealmName][player][flag];
	else
		return nil;
	end 
end

function ImmersionRPDatabaseHandler.GetDescription(player)
	if (ImmersionRPDatabaseHandler.GetFlag(player, "DESCRIPTION") ~= nil) then
		return ImmersionRPDatabaseHandler.GetFlag(player, "DESCRIPTION");
	else
		return "";
	end
end

function ImmersionRPDatabaseHandler.GetNotes(player)
	if (ImmersionRPDatabaseHandler.GetFlag(player, "NOTES") ~= nil) then
		return ImmersionRPDatabaseHandler.GetFlag(player, "NOTES");
	else
		return "";
	end
end

function ImmersionRPDatabaseHandler.GetPlayerName(player)
	if (ImmersionRPDatabase[ImmersionRP.RealmName][player] == nil) then
		return player;
	end
	
	local retname = player;
	local firstname = ImmersionRPDatabaseHandler.GetFlag(player, "FIRSTNAME") or ImmersionRPDatabaseHandler.GetFlag(player, "FIRSTNAMEALTERNATE");
	local lastname = ImmersionRPDatabaseHandler.GetFlag(player, "LASTNAME") or ImmersionRPDatabaseHandler.GetFlag(player, "LASTNAMEALTERNATE");
	if (firstname ~= nil and firstname ~= "") then
		retname = firstname .. " " .. retname;
	end
	
	if (lastname ~= nil and lastname ~= "") then
		retname = retname .. " " .. lastname;
	end
	
	return retname;
end

function ImmersionRPDatabaseHandler.GetPlayerTitle(player)
--~ 	if (ImmersionRPDatabaseHandler.GetFlag(player, "TITLE") ~= nil and ImmersionRPDatabaseHandler.GetFlag(player, "TITLE") ~= "") then return ImmersionRPDatabaseHandler.GetFlag(player, "TITLE"); end
--~ 	return ImmersionRPDatabaseHandler.GetFlag(player, "TITLEALTERNATE");
		return ImmersionRPDatabaseHandler.GetFlag(player, "TITLE") or ImmersionRPDatabaseHandler.GetFlag(player, "TITLEALTERNATE");
end

function ImmersionRPDatabaseHandler.GetRPStyleString(player)
	local stylenumber = ImmersionRPDatabaseHandler.GetFlag(player, "RPSTYLE");
	if (stylenumber ~= nil) then
		if (ImmersionRPSettings["COMM_PROTOCOL"] == 2) then
			if (stylenumber == 0) then
				return "";
			elseif (stylenumber == 1) then
				return IRP_STRING_RSP_RP_TOOLTIP;
			elseif (stylenumber == 2) then
				return IRP_STRING_RSP_CASUALRP_TOOLTIP;
			elseif (stylenumber == 3) then
				return IRP_STRING_RSP_FULLTIMERP_TOOLTIP;
			elseif (stylenumber == 4) then
				return IRP_STRING_RSP_BEGINNERRP_TOOLTIP;
			end
		else
			-- TODO: Implement ImmersionRP RP-style strings
		end
	else
		return "";
	end
end

function ImmersionRPDatabaseHandler.GetRPStatusString(player)
	local stylenumber = ImmersionRPDatabaseHandler.GetFlag(player, "RPSTATUS");
	if (stylenumber ~= nil) then
		if (ImmersionRPSettings["COMM_PROTOCOL"] == 2) then
			if (stylenumber == 0) then
				return "";
			elseif (stylenumber == 1) then
				return IRP_STRING_RSP_OOC_TOOLTIP;
			elseif (stylenumber == 2) then
				return IRP_STRING_RSP_IC_TOOLTIP;
			elseif (stylenumber == 3) then
				return IRP_STRING_RSP_ICFFA_TOOLTIP;
			elseif (stylenumber == 4) then
				return IRP_STRING_RSP_STORYTELLER_TOOLTIP;
			end
		else
			-- TODO: Implement ImmersionRP character status strings
		end
	else
		return "";
	end
end

function ImmersionRPDatabaseHandler.DeleteFlag(player, flag)
	if (ImmersionRPDatabase[ImmersionRP.RealmName][player] ~= nil) then ImmersionRPDatabase[ImmersionRP.RealmName][player][flag] = nil; end
end