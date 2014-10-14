-- Binding Configuration
BINDING_HEADER_PHOENIX		= "Phoenix Devpad";
BINDING_NAME_PHOENIXSHOW	= "Toggle Phoenix Devpad";
BINDING_NAME_PHOENIXEVENTOVERRIDE = "Toggle event hooks override";
BINDING_NAME_PHOENIXRESTART	= "Reload UI";
BINDING_NAME_PHOENIXCHATERRORS  = "Toggle chat errors";

-- Interface Configuration
PHOENIX_NEW_SCRIPT		= "New Script";
PHOENIX_DELETE_SCRIPT		= "Delete Script";
PHOENIX_RUN_SCRIPT		= "Run Script";

PHOENIX_NAME			= "Name:";
PHOENIX_EVENT                   = "Event";

PHOENIX_FILE		= "File:";
PHOENIX_STRING		= "String:";
PHOENIX_LINE		= "Line:";
PHOENIX_COUNT		= "Count:";
PHOENIX_ERROR		= "Error:";

PHOENIX_CHAT_FRAME_MESSAGE = "Phoenix chat frame is";
PHOENIX_TIMEOUT_MESSAGE = "Phoenix error timeout is set to %d seconds";
PHOENIX_UNKNOWN_COMMAND_MESSAGE = "Unknown Phoenix command. Type '/px' for a brief help"
PHOENIX_UNKNOWN_DUMP_VALUE_MESSAGE = "Value '%s' is not recognized as valid for dump option '%s'. Type '/px dump' for a brief help"
PHOENIX_UNKNOWN_DUMP_OPTION_MESSAGE = "Unknown dump option. Type /px dump for a brief help"
PHOENIX_NO_HANDLER_MESSAGE = "No acive event handler for '%s' was found";
PHOENIX_NO_SCRIPT_MESSAGE = "No script named '%s' was found";
PHOENIX_EVENTS_ON_MESSAGE = "Phoenix events is turned on";
PHOENIX_EVENTS_OFF_MESSAGE = "Phoenix events is turned off";
PHOENIX_EVENT_LIST_MESSAGE = "Following events are hooked up:";
PHOENIX_ERRORS_REGISTERED_MESSAGE = " errors registered";
PHOENIX_ERRORS_LAST_MESSAGE = "Printing last ";
PHOENIX_CHAT_ON_MESSAGE = "Chat errors is turned on";
PHOENIX_CHAT_OFF_MESSAGE = "Chat errors is turned off";
PHOENIX_NO_TABLE_MESSAGE = "Can't find table '%s' in the last dump cache";
PHOENIX_TABLE_TOO_DEEP_MESSAGE = "<table (too deep)>";
PHOENIX_SKIPPED_MESSAGE = "< skipped %d>";
PHOENIX_UNKNOWN_TYPE_MESSAGE = "Unknown flat type: ";


--[[ Help printouts
--]]

Phoenix_PrintChatCommandHelp = function()
	local cc = HIGHLIGHT_FONT_COLOR_CODE;
	local ct = FONT_COLOR_CODE_CLOSE;
	local yl = LIGHTYELLOW_FONT_COLOR_CODE;
	Phoenix_Print(cc .. "/px" .. ct .. yl .. " - Displays this help. Please read readme.txt for more details" .. ct);
	Phoenix_Print(cc .. "/px script" .. ct .. yl .. " - Displays script commands help" .. ct);
	Phoenix_Print(cc .. "/px dump" .. ct .. yl .. " - Displays dump options  help" .. ct);
	Phoenix_Print(cc .. "/px chat" .. ct .. yl .. " [name] - Sets/shows to which chat window Phoenix prints all the output" .. ct);
	Phoenix_Print(cc .. "/px timeout" .. ct .. yl .. " [length] - Sets/shows timeout in seconds to suppress repeated errors" .. ct);
	Phoenix_Print(cc .. "/pxr" .. ct .. yl .. " - Reloads ui (Shortcut to /console reload)" .. ct);
	Phoenix_Print(cc .. "/pxt" .. ct .. yl .. " - Toggles Phoenix DevPad" .. ct);
	Phoenix_Print(cc .. "/pxv" .. ct .. yl .. " - Toggles event override. When on no event handlers are invoked" .. ct);
	Phoenix_Print(cc .. "/pxl" .. ct .. yl .. " - Lists hooked up events" .. ct);
	Phoenix_Print(cc .. "/pxc" .. ct .. yl .. " - Toggles chat errors" .. ct);
	Phoenix_Print(cc .. "/pxe" .. ct .. yl .. " [last] - Displays all or specified number of last script errors" .. ct);
	Phoenix_Print(cc .. "/pxs" .. ct .. yl .. " script - Runs DevPad script by name" .. ct);
	Phoenix_Print(cc .. "/pxd" .. ct .. yl .. " expression - Dumps expression result" .. ct);
	Phoenix_Print(cc .. "/pxd table" .. ct .. yl .. " number||name - Dumps a named table from the previous dump" .. ct);
end

Phoenix_PrintScriptCommandHelp = function()
	local cc = HIGHLIGHT_FONT_COLOR_CODE;
	local ct = FONT_COLOR_CODE_CLOSE;
	local yl = LIGHTYELLOW_FONT_COLOR_CODE;
	Phoenix_Print(yl .. "Please read readme.txt for more details" .. ct);
	Phoenix_Print(yl .. "Functions:" .. ct);
	Phoenix_Print(cc .. "pxc(command)" .. ct .. yl .. " - run ñhat ñommand, ex: pxc(\"/say hello\")" .. ct);
	Phoenix_Print(cc .. "pxs(scriptName)" .. ct .. yl .. " - run script, ex: pxs(\"myScript\")" .. ct);
	Phoenix_Print(cc .. "pxp(msg, chatFrameName, ...)" .. ct .. yl .. " - print, ex: pxp(\"Val: %%d\",\"Combat\",val)" .. ct);
	Phoenix_Print(cc .. "pxd(expression)" .. ct .. yl .. " - dump expression, ex: pxd(DEFAULT_CHAT_FRAME)" .. ct);
	Phoenix_Print(yl .. "Variables:" .. ct);
	Phoenix_Print(cc .. "pxname" .. ct .. yl .. " - name of the current executing script" .. ct);
	Phoenix_Print(cc .. "pxevent" .. ct .. yl .. " - if current executing script is ececuted as a result of an event" .. ct);
end

Phoenix_PrintDumpOptionsHelp = function()
	local cc = HIGHLIGHT_FONT_COLOR_CODE;
	local ct = FONT_COLOR_CODE_CLOSE;
	local yl = LIGHTYELLOW_FONT_COLOR_CODE;
	Phoenix_Print(yl .. "Please read readme.txt for more details" .. ct);
	Phoenix_Print(yl .. "For numerical limit options zero means no limit" .. ct);
	Phoenix_Print(cc .. "/px dump show" .. ct .. yl .. " - Displays current dump options" .. ct);
	Phoenix_Print(cc .. "/px dump entrylimit" .. ct .. yl .. " [number] - Displays/sets the maximum number of table elemnts to dump" .. ct);
	Phoenix_Print(cc .. "/px dump stringlimit" .. ct .. yl .. " [number] - Displays/sets the maximum string length to dump" .. ct);
	Phoenix_Print(cc .. "/px dump depthlimit" .. ct .. yl .. " [number] - Displays/sets table nesting limit to dump" .. ct);
	Phoenix_Print(cc .. "/px dump ident" .. ct .. yl .. " [number] - Displays/sets hoe many ident spaces each level adds to the outptu" .. ct);
	Phoenix_Print(cc .. "/px dump trackloops" .. ct .. yl .. " [true|false] - Displays/sets if dump command suppress self-refrenced elements" .. ct);
end

