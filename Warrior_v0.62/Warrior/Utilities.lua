WARRIOR.Utils = {};
WARRIOR.Utils.List = {};
WARRIOR.Utils.Table = {};
WARRIOR.Utils.String = {};

-- regular expression for a comma delimited list
WARRIOR.Utils._regex = {}
WARRIOR.Utils._regex.entry = '["\']?([^"\',]+)["\']?';
WARRIOR.Utils._regex.list = '%s*' .. WARRIOR.Utils._regex.entry .. ',?%s*';


-- *****************************************************************************
-- Function: Print
-- Purpose: prints a message to the chat window
-- *****************************************************************************
function WARRIOR.Utils:Print(format,...)
	if (not format) then 
		message("WARRIOR.Utils:Print() tried to print nil message."); 
		return;
	end
	
	if (DEFAULT_CHAT_FRAME) then 
		format = string.gsub(format,"(%%%w)","|cffFF6600%1|cff0099FF");
		if (arg) then format = string.format(format, unpack(arg)); end
		DEFAULT_CHAT_FRAME:AddMessage("|cff0033ffWarrior: |cff0099FF" .. format); 
	end
end

-- *****************************************************************************
-- Function: Debug
-- Purpose: prints debug a message to the chat window
-- *****************************************************************************
function WARRIOR.Utils:Debug(level,format,...)
	if (not format) then 
		message("WARRIOR.Utils:Debug() tried to print nil message."); 
		return;
	end

	if (WARRIOR._debug >= level and DEFAULT_CHAT_FRAME) then
		format = string.gsub(format,"(%%%w)","|cffFF6600%1|cff0099FF");
		format = string.gsub(format, "^(.-:)(.+)$", "|cff0033ffWarrior: |cff0066FF%1|cff0099FF%2") or format;
		if (arg) then format = string.format(format, unpack(arg)); end
		DEFAULT_CHAT_FRAME:AddMessage(format); 
	end
end

-- *****************************************************************************
-- Function: Hook 
-- Purpose: hook a function with a new function
-- *****************************************************************************
function WARRIOR.Utils:Hook(name,func)
	setglobal("WARRIOR_old"..name,getglobal(name));
	setglobal(name,func);
end

-- *****************************************************************************
-- Function: UnHook 
-- Purpose: unhook a hooked function
-- *****************************************************************************
function WARRIOR.Utils:UnHook(name,func)
	setglobal(name,getglobal("WARRIOR_old"..name));
	setglobal("WARRIOR_old"..name,nil);
end

-- *****************************************************************************
-- Function: FlopBool
-- Purpose: flops a boolean value
-- *****************************************************************************
function WARRIOR.Utils:FlopBool(value)
	if (not value) then return true; end
	return false;
end

-- *****************************************************************************
-- Function: HasValue
-- Purpose: checks for a value in a comma delimitted list
-- *****************************************************************************
function WARRIOR.Utils.List:HasValue(list,value)
	if (not value) then return nil; end
	
	local _,_, found = string.find(list, "%s?(" .. value .. "),?");
	if (found == nil) then return false; end
	
	return found;
end

-- *****************************************************************************
-- Function: ToTable
-- Purpose: converts a comma delimitted list into a table
-- *****************************************************************************
function WARRIOR.Utils.List:ToTable(list)
	setglobal("___WARRIORTEMPLIST",{});
	string.gsub(list, WARRIOR.Utils._regex.list, function(a) table.insert(getglobal("___WARRIORTEMPLIST"),a); end);
	
	local list = ___WARRIORTEMPLIST;
	___WARRIORTEMPLIST = nil;
	
	if (table.getn(list) > 0) then return list; end
	return nil;
end

-- *****************************************************************************
-- Function: Find
-- Purpose: finds a value in a table and returns the key
-- *****************************************************************************
function WARRIOR.Utils.Table:Find(haystack,needle)
	if (needle == nil) then return nil; end
	if (type(needle) == "string") then
		for key,value in haystack do if (needle == value) then return key; end end
		return false;
	end
	return needle;
end

-- *****************************************************************************
-- Function: Pack
-- Purpose: packs arguments into a table
-- *****************************************************************************
function WARRIOR.Utils.Table:Pack(...)
	arg["n"] = nil;
	return arg;
end

-- *****************************************************************************
-- Function: Find
-- Purpose: finds a value in a table and returns the key
-- *****************************************************************************
function WARRIOR.Utils.Table:ToString(t)
	if (t == nil) then return ""; end
	return table.concat(t,", ");
end

-- *****************************************************************************
-- Function: Trim
-- Purpose: trims a string of the whitespace at the beginning and the end
-- *****************************************************************************
function WARRIOR.Utils.String:Trim(s)
  return string.gsub(s, "^%s*(.-)%s*$", "%1")
end

