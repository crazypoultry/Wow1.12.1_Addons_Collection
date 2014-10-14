--[[
--
--	Sea.util
--
--	Useful data manipulation functions
--
--	$LastChangedBy: legorol $
--	$Rev: 2577 $
--	$Date: 2005-10-10 14:44:01 -0700 (Mon, 10 Oct 2005) $
--]]

Sea.util = {

	--[[ Function Hooking ]]--
	
	--
	-- hook( string originalFunctionNameOrFrameName, string newFunction, string hooktype, string scriptElementName )
	--
	-- 	Hooks a function.
	--
	-- 	Example: 
	-- 		hook("some_blizzard_function","my_function","before|after|hide|replace");
	--		hook("some_frame_name","my_function","before|after|hide|replace", "some_script_element_name");
	--		
	--		
	-- 	Calls "my_function" before/after "some_blizzard_function".
	-- 	If type is "hide", calls "my_function" before all others, and only continues if it returns true.
	-- 	If type is "replace", calls "my_function" instead of the origional function, but will also call the origional function afterwards if it returns true.
	--    You can also return a list of values to be returned, but only if you don't return true as the first return.  Ex. return false, { val1, val2 };
	-- 	This method is used so the hook can be later undone without screwing up someone else's later hook.
	--
	hook = function ( original, new, hooktype, scriptElementName ) 
		Sea.util.hookFunction( original, new, hooktype, scriptElementName );
	end;

	-- 
	-- unhook( string originalFunctionNameOrFrameName, string newFunction, string hooktype, string scriptElementName )
	-- 
	--	Unhooks a function
	--
	--	Example:
	-- 		unhook("some_blizzard_function","my_function","before|after|hide|replace");
	--		unhook("some_frame_name","my_function","before|after|hide|replace", "some_script_element_name");
	--
	-- 	This will remove a function hooked by hook.
	-- 
	unhook = function ( original, new, hooktype, scriptElementName )
		Sea.util.unhookFunction ( original, new, hooktype, scriptElementName );
	end;

	--[[ Hyperlinks ]] --
	--
	-- makeHyperlink(string type, string linkText, Table[r,g,b] color)
	--
	-- 	Creates a hyperlink string which is returned to you.
	--
	-- Args:
	--   (string type, string linkText, Table[r,g,b] color, boolean braces, table[left,right] braceString)
	--   type - the Hyperlink type.
	--   linkText - the text shown in the link
	--   color - color of the link
	--   braces - if true, add braces
	--   braceString - table with .left for left brace and .right for right brace
	--
	makeHyperlink = function (type, linkText, color, braces, braceString)
		local link = linkText;
		if ( braces ) then 
			if ( braceString == nil ) then braceString = {}; end
			if ( braceString.left == nil ) then braceString.left="["; end
			if ( braceString.right == nil ) then braceString.right="]"; end

			link = braceString.left..link..braceString.right;
		end
		if (color) then
			link = "|cFF"..color..link.."|r";
		end
		return "|H"..type.."|h"..link.."|h";
	end;
	--[[ Candidates for String ]]--
	
	-- 
	-- join(list,separator)
	--
	-- Arguments: 
	-- 	(table list, String separator)
	-- 	list 	- table of things to join
	-- 	separator 	- the separator to place between objects
	--
	-- Returns:
	-- 	(string joinedstring)
	--	joinedstring - the list.toString() joined by separator(s)
	-- 
	-- Written by Thott (thott@thottbot.com)
	join = function (list, separator)
		-- Type check
		if ( type(list) ~= "table" and type(list) ~= nil ) then 
			ChatFrame1:AddMessage("Non-table passed to Sea.util.join");
			return nil;
		end
		if ( not list.n ) then 
			ChatFrame1:AddMessage("Custom table without .n passed to Sea.util.join");
			return "";
		end
		if ( separator == nil ) then separator = ""; end
		
		local i;
		local c = "";
		local msg = "";
		for i=1, list.n, 1 do
			if(type(list[i]) ~= "nil" ) then
				if(type(list[i]) == "boolean" ) then 
					msg = msg .. c .. "(";
					if ( list[i] ) then
						msg = msg .. "true";
					else
						msg = msg .. "false";
					end
					msg = msg .. ")";
				elseif(type(list[i]) ~= "string" and type(list[i]) ~= "number") then
        				msg = msg .. c .. "(" .. type(list[i]) .. ")";
				else
					msg = msg .. c .. list[i];
				end
			else
				msg = msg .. c .. "(nil)";
			end
				c = separator;
		end
		return msg;		
	end;

	-- 
	-- split(string text, string separator [, table oldTable [, boolean noPurge] ] )
	--
	-- 	Splits a string into a table by separators
	--
	-- Args:
	--  (string text, string separator, table oldTable, boolean noPurge)
	-- 	text - string containing input
	-- 	separator - separators
	--  oldTable (optional) - table to fill with the results
	--  noPurge (optional) - do not clear extraneous entries in oldTable
	--
	-- Returns:
	-- 	(table)
	-- 	table - the table containing the exploded strings, which is freshly
	-- 		created if oldTable wasn't passed
	--
	-- Aliases:
	-- 	Sea.string.split
	-- 	Sea.string.explode
	--
	-- Notes:
	-- 	In the interests of avoiding garbage generation, whenever possible pass
	-- 	a table for split to reuse.
	--
	-- Written by Thott (thott@thottbot.com)
	-- Modified by Legorol (legorol@cosmosui.org)
	split = function ( text, separator, oldTable, noPurge ) 
		local value;
    	local init, mstart, mend = 1;
		local t, oldn = oldTable, 0;
		
		if ( not t ) then
			t = {};
		else
			oldn = table.getn(t);
			table.setn(t, 0);
		end
		
		-- Using string.find instead of string.gfind to avoid garbage generation		
    	repeat
			mstart, mend, value = string.find(text, "([^"..separator.."]+)", init);
			if ( value ) then
				table.insert(t, value)
				init = mend + 1;
			end
    	until not value;
		
		if ( not noPurge ) then
			for i = table.getn(t)+1, oldn do
				t[i] = nil;
			end
		end
		
		return t;
	end;
	
	--[[ Nil in Array Fixing Functions ]]--
	
	--
	-- fixnil (...)
	-- 
	-- 	Converts all nils to "(nil)" strings
	--
	-- Arguments:
	-- 	() arg
	--	arg - the list
	--
	-- Written by Thott (thott@thottbot.com)
	-- 
	fixnil = function(...)
		return Sea.util.fixnilSub("(nil)", unpack(arg));
	end;


	--
	-- Fixes nils with empty strings
	--
	-- Written by Thott (thott@thottbot.com)

	fixnilEmptyString = function (...)
		return Sea.util.fixnilSub("", unpack(arg));
	end;

	-- 
	-- Fixes nils with 0s
	-- 
	-- Written by Thott (thott@thottbot.com)
	fixnilZero = function (...)
		return Sea.util.fixnilSub(0, unpack(arg));
	end;
		
	--
	-- fixnilsub (sub, ... )
	--
	--	replaces nils with a substitute
	--	
	--
	-- Written by Thott (thott@thottbot.com)
	fixnilSub = function(sub, ... )
		for i=1, arg.n, 1 do
			if(not arg[i]) then
				arg[i] = sub;
			end
		end
		return arg;
	end;

	--[[ Variable Referencing ]]--
	
	--
	-- getValue( string variableName )
	--
	-- 	Obtains the value of a variable given its name.
	--
	-- 	Examples: 
	-- 		getValue("ChatFrame_OnLoad");
	-- 		getValue("Class.subclass.element");
	-- 	
	-- Args:
	-- 	(string) variableName - the name of the variable
	-- 	
	-- Returns:
	-- 	value - the value that variable has
	-- 	
	-- 	This function obtains the value that variableName contains.
	-- 	It is able to return the value for both a global variable or for
	-- 	the element of a table. If variableName doesn't exist, it returns nil.
	--
	-- Written by Legorol (legorol@cosmosui.org),
	-- based on ideas by Mugendai	
	getValue = function ( variableName ) 
		if ( type(variableName) ~= "string" ) then
			return nil;
		end;
		
		-- Table we reuse with calls to split
		if ( not Sea.util.valueTable ) then
			Sea.util.valueTable = {};
		end
		
		-- Split the variable name at ".", first field is a global name
		local fields = Sea.util.split(variableName, ".", Sea.util.valueTable);
		local encloser, member = getglobal(fields[1]), fields[2];
		
		-- If encloser is the only field, it's a global, return its value
		if ( not member ) then
			return encloser;
		end
		
		-- If there are subsequent fields present, get to deeper levels
		for i = 3, table.getn(fields) do
			if ( type(encloser) ~= "table" ) then
				return nil;
			end
			encloser = encloser[member];
			member = fields[i];
		end
		
		-- Encloser is now the last but one field, member is the last field
		if ( type(encloser) == "table" ) then
			return encloser[member];
		end
		-- Error occured, encloser is not a table, return nil
	end;
	
	--
	-- setValue( string variableName, value )
	--
	-- 	Sets the value of a variable given its name.
	--
	-- 	Examples: 
	-- 		setValue("ChatFrame_OnLoad", MyChatFrame_OnLoad);
	-- 		setValue("Class.subclass.element", 5);
	-- 		setValue("Class.subclass.function", function() dostuff; end);
	-- Args:
	-- 	(string) variableName - the name of the variable to change
	-- 	value - the new value of the variable
	-- 	
	-- Returns:
	-- 	(boolean) success - true if the operation succeeded
	-- 	
	-- 	This function sets the value of variableName.
	-- 	It is able to set the value for both a global variable or for
	-- 	the element of a table, including functions. If variableName
	-- 	already exists, it is overwritten.
	--
	-- Written by Legorol (legorol@cosmosui.org),
	-- based on ideas by Mugendai	
	setValue = function ( variableName, value ) 
		if ( type(variableName) ~= "string" ) then
			return false;
		end;
		
		-- Table we reuse with calls to split
		if ( not Sea.util.valueTable ) then
			Sea.util.valueTable = {};
		end
		
		-- Split the variable name at ".", first field is a global name
		local fields = Sea.util.split(variableName, ".", Sea.util.valueTable);
		local encloser, member = getglobal(fields[1]), fields[2];
		
		-- If encloser is the only field, variable is a global, set its value
		if ( not member ) then
			setglobal(variableName, value);
			return true;
		end
		
		-- If there are subsequent fields present, get to deeper levels
		for i = 3, table.getn(fields) do
			if ( type(encloser) ~= "table" ) then
				return false;
			end
			encloser = encloser[member];
			member = fields[i];
		end
		
		-- Encloser is now the last but one field, member is the last field
		if ( type(encloser) == "table" ) then
			encloser[member] = value;
			return true;
		end
		
		-- Error occured, encloser is not a table
		return false;
	end;

};

--
-- Hook Function
-- 
-- Written by Thott (thott@thottbot.com)
Sea.util.hookFunction = function ( orig, new, type, scriptElementName )
	if(not type) then
		type = "before";
	end
	Sea.IO.dprint(nil, "Hooking ", orig, " to ", new, ", type ", type, ", scriptElementName ", scriptElementName);
	if(not Sea.util.Hooks) then
		Sea.util.Hooks = {};
	end
	local origCopy = orig;
	if (scriptElementName) then
		orig = orig.."."..scriptElementName;
	end
	if(not Sea.util.Hooks[orig]) then
		Sea.util.Hooks[orig] = {};
		Sea.util.Hooks[orig].before = {};
		Sea.util.Hooks[orig].before.n = 0;
		Sea.util.Hooks[orig].after = {};
		Sea.util.Hooks[orig].after.n = 0;
		Sea.util.Hooks[orig].hide = {};
		Sea.util.Hooks[orig].hide.n = 0;
		Sea.util.Hooks[orig].replace = {};
		Sea.util.Hooks[orig].replace.n = 0;
		-- Set up the hook the first time
		if (scriptElementName) then
			Sea.util.Hooks[orig].orig = Sea.util.getValue(origCopy):GetScript(scriptElementName);
			Sea.util.getValue(origCopy):SetScript(scriptElementName, function(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20) return Sea.util.hookHandler(orig,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20); end);
		else
			Sea.util.Hooks[orig].orig = Sea.util.getValue(origCopy);
			Sea.util.setValue(orig,function(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20) return Sea.util.hookHandler(orig,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20); end);
		end
	else
		for key,value in Sea.util.Hooks[orig][type] do
			-- NOTE THIS SHOULD BE VALUE! VALUE! *NOT* KEY!
			if(value == Sea.util.getValue(new)) then
				Sea.IO.dprint(nil, "already hooked ",new,", skipping");
				return;
			end
		end
	end
	-- intentionally will error if bad type is passed
	Sea.table.push(Sea.util.Hooks[orig][type],Sea.util.getValue(new));
end

-- 
-- Unhook function
-- 
-- Written by Thott (thott@thottbot.com)

Sea.util.unhookFunction = function ( orig, new, type, scriptElementName )
	-- same format as hookFunction
	if(not type) then
		type = "before";
	end
	local l,g;
	if(not Sea.util.Hooks) then
		Sea.util.Hooks = {};
	end
	local origCopy = orig;
	if (scriptElementName) then
		orig = orig.."."..scriptElementName;
	end
	if(not Sea.util.Hooks[orig]) then
		Sea.util.Hooks[orig] = {};
		Sea.util.Hooks[orig].before = {};
		Sea.util.Hooks[orig].before.n = 0;
		Sea.util.Hooks[orig].after = {};
		Sea.util.Hooks[orig].after.n = 0;
		Sea.util.Hooks[orig].hide = {};
		Sea.util.Hooks[orig].hide.n = 0;
		Sea.util.Hooks[orig].replace = {};
		Sea.util.Hooks[orig].replace.n = 0;
		if (scriptElementName) then
			Sea.util.Hooks[orig].orig = Sea.util.getValue(origCopy):GetScript(scriptElementName);
			Sea.util.getValue(origCopy):SetScript(scriptElementName, function(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20) return Sea.util.hookHandler(orig,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20); end);
		else
			Sea.util.Hooks[orig].orig = Sea.util.getValue(origCopy);
			Sea.util.setValue(orig,function(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20) return Sea.util.hookHandler(orig,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20); end);
		end
	end
	l = Sea.util.Hooks[orig][type];
	g = Sea.util.getValue(new);
	if ( l ) then 
		for key,value in l do
			if(value == g) then
				l[key] = nil;
				Sea.IO.dprint(nil, "found and unhooked ",new);
				return;
			end
		end
	end
end

--
-- Hook Handler
--
-- Handles the name and the argument table
-- 
-- Written by Thott (thott@thottbot.com)

Sea.util.hookHandler = function (name,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
	local called = false;
	local continue = true;
	local retval = nil;
	local ra1,ra2,ra3,ra4,ra5,ra6,ra7,ra8,ra9,ra10,ra11,ra12,ra13,ra14,ra15,ra16,ra17,ra18,ra19,ra20;
	if ( not Sea.util.Hooks[name] ) then
		Sea.util.Hooks[name] = {};
		Sea.util.Hooks[name].before = {};
		Sea.util.Hooks[name].before.n = 0;
		Sea.util.Hooks[name].after = {};
		Sea.util.Hooks[name].after.n = 0;
		Sea.util.Hooks[name].hide = {};
		Sea.util.Hooks[name].hide.n = 0;
		Sea.util.Hooks[name].replace = {};
		Sea.util.Hooks[name].replace.n = 0;
	end
	for key,value in Sea.util.Hooks[name].hide do
		if(type(value) == "function") then
			--Sea.IO.dprint(nil, "calling before ",name);
			if(not value(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)) then
				continue = false;
			end
			called = true;
		end
	end
	if(not continue) then
		Sea.IO.dprint(nil,"hide returned false, aborting call to ",name);
		return;
	end
	for key,value in Sea.util.Hooks[name].before do
		if(type(value) == "function") then
			--Sea.UI.dprint(nil, "calling before ",name);
			value(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20);
			called = true;
		end
	end
	continue = false;
	local replacedFunction = false;
	for key,value in Sea.util.Hooks[name].replace do
		if(type(value) == "function") then
			replacedFunction = true;
			--Sea.IO.dprint(nil, "calling before ",name);
			local callOrig = false;
			callOrig,ra1,ra2,ra3,ra4,ra5,ra6,ra7,ra8,ra9,ra10,ra11,ra12,ra13,ra14,ra15,ra16,ra17,ra18,ra19,ra20 = value(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20);
			if(callOrig) then
				continue = true;
			else
				retval = true;
			end
			called = true;
		end
	end
	if(continue or (not replacedFunction)) then
		--Sea.IO.dprint(nil, "calling original ",name);
		if (Sea.util.Hooks[name].orig) then
			ra1,ra2,ra3,ra4,ra5,ra6,ra7,ra8,ra9,ra10,ra11,ra12,ra13,ra14,ra15,ra16,ra17,ra18,ra19,ra20 = Sea.util.Hooks[name].orig(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20);
		end
		retval = true;
	end
	for key,value in Sea.util.Hooks[name].after do
		if(type(value) == "function") then
			value(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20);
			called = true;
		end
	end
	if(not called) then
		--[[ Disabled Complete Unhhoking Sept 17, 2005 - Incompatible with Frame Script Element Hooks - Liable to erase hooks loaded after the first hook.
		Sea.IO.dprint(nil,"no hooks left for ",name,", clearing");
		Sea.util.setValue(name,Sea.util.Hooks[name].orig);
		Sea.util.Hooks[name] = nil;
		]]--
	end
	if (retval) then
		if (type(ra1) == "table") then
			return unpack(ra1);
		else
			return ra1,ra2,ra3,ra4,ra5,ra6,ra7,ra8,ra9,ra10,ra11,ra12,ra13,ra14,ra15,ra16,ra17,ra18,ra19,ra20;
		end
	end
end

-- Alias table
Sea.string.split = Sea.util.split;
Sea.string.explode = Sea.util.split;
