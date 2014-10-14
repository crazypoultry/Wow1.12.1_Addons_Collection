--[[

shared_functions.lua

Various functions used by EFM.
]]

-- Function: Return the string value for slash command options...
function EFM_SF_SlashClean(commandString, msgLine)
	local tempValue;

	tempValue = string.sub(msgLine, (string.len(commandString) + 2));
	
	if (string.find(tempValue, "^\"") ~= nil) then
		tempValue = string.sub(tempValue, 2);
	end
	
	if (string.find(tempValue, "\"$") ~= nil) then
		tempValue = string.sub(tempValue, 1, (string.len(tempValue) - 1));
	end

	return tempValue;
end

-- Function: Check to see if a given string is in the table keys
function EFM_SF_StringInTableKeys(inputTable, inputString)
	for key, val in pairs(inputTable) do
		if (key == inputString) then
			return true;
		end
	end
	return false;	
end

-- Function: Check to see if a given string is in the table.
function EFM_SF_StringInTable(inputTable, inputString)
	for index in inputTable do
		if (inputTable[index] == inputString) then
			return true;
		end
	end
	return false;
end

-- Function: Merge two LUA tables
function EFM_SF_mergeTable(src,dest)
	for key,val in pairs(src) do
--		DEFAULT_CHAT_FRAME:AddMessage("Key: "..key);
		local dval = dest[key];
		if (type(val) == "table") then
			if (dval == nil) then
				dval = {};
				dest[key] = dval;
			end
			EFM_SF_mergeTable(val, dval)
		else
			if ((dval == nil) and (dval ~= val)) then
				dest[key] = val;
			end
		end
	end
end

-- Function: Format an input number to return a human-readable time format.
function EFM_SF_FormatTime(duration)
   local minutes	= floor(duration / 60);
   local seconds	= duration - (minutes * 60);
   local tens	= floor(seconds/10);
   local single	= seconds - (tens * 10);
   return minutes..":"..tens..single;
end

-- Function: Return the value to the given precision
function EFM_SF_ValueToPrecision(value, precision)
	local precValue = 10 ^ precision;
	
	value = floor(value * precValue) / precValue;
	
	return value;
end
