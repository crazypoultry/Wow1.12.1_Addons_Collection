--[[

KnownPaths.lua

This segment deals with who knows what flight path.

]]

-- Function: Record that the player knows this flight master.
function EFM_KP_AddLocation(myContinent, myNode)
	if (not EFM_KP_CheckPaths(myContinent, myNode)) then
		table.insert(EFM_MyNodes[myContinent], myNode);
	end
end

-- Function: Check if player knows the flight path, return true if known, false otherwise.
function EFM_KP_CheckPaths(myContinent, myNode)
	for key, val in pairs(EFM_MyNodes[myContinent]) do
		if (val == myNode) then
			return true;
		end
	end
	return false;	
end
