--[[
--
--	Phoenix DevPad
--
--	By Andrew Savinykh
--      wowaddons @ brutsoft . com
--
--	Phoenix allows to write, store and execute named code snippets,
--	hook up code snippets to different warcraft events.
--
--	It has some routines to facilitate AddOn debuging and development process
--
--	Please see below or see readme.txt for details.
--      Version 17-Sep-2005 1.7.0.1
--
--]]

Phoenix_Config = {}

local Phoenix_ErrorColor = RED_FONT_COLOR_CODE;

--[[ General infrastructure code
--]]
function Phoenix_OnLoad()
	this:RegisterForDrag("LeftButton");
	this:RegisterEvent("VARIABLES_LOADED");

	local orig = ToggleGameMenu;
	ToggleGameMenu = function(clicked)
		if ( Phoenix_EscapeHide() ) then
			return orig(clicked);
		end
	end
	Phoenix_RegisterChatCommands();
	Phoenix_UpdateEntryList();
end

Phoenix_VarsLoaded = 0;

function Phoenix_OnEvent(event)
	if (event == "VARIABLES_LOADED") then
		if (Phoenix_VarsLoaded == 0) then
			Phoenix_UpdateEntryList();
			if ( Phoenix_Config.selectedEntry ~= 0 ) then
				Phoenix_LoadEntry(Phoenix_Config.selectedEntry);
			end
			Phoenix_VarsLoaded = 1;
			Phoenix_InitEventHookups();
			Phoenix_RunScriptByName("Startup",nil,true);
			if (Phoenix_Config.chatErrorsOn) then
				Phoenix_OldERRORMESSAGE = _ERRORMESSAGE;
				Phoenix_OldMessage = message;
				_ERRORMESSAGE = Phoenix_ERRORMESSAGE;
				message = Phoenix_message;
			end
		end
	else
		Phoenix_ProcessEventHookup(event);
	end
end

function Phoenix_Trim(text)
   -- Remove trailing spaces from a string
   if(text == nil) then return; end;
   local _,_,trimmed = string.find(text,"^%s*(.-)%s*$");
   return trimmed;
end


--[[ UI code
--]]

function Phoenix_EscapeHide()
	if ( PhoenixFrame:IsVisible() ) then
		PhoenixFrame:Hide();
		return false;
	else
		return true;
	end
end

-- Currently selected entry. 0 = no/new entry.
Phoenix_Config.selectedEntry = 0;

-- this is the max number of buttons that we have available, numbered 1 through this value
PHOENIX_MAX_BUTTONS = 25;

local Phoenix_NumVisibleEntryButtons = 0;
local Phoenix_ScrollFrameOffset = 0;

Phoenix_Config.entries = {};

function Phoenix_Restart()
	ReloadUI();
end

function Phoenix_Toggle()
	if (PhoenixFrame:IsVisible()) then
      		PhoenixFrame:Hide();
	else
      		PhoenixFrame:Show();
	end
end

function Phoenix_UpdateEntryButtonVisibility()
	local buttonHeight, frameHeight, numButtons, numEntries;

	local uiScale = GetCVar("uiscale");

	buttonHeight = 20;
	frameHeight = PhoenixEntriesScrollFrame:GetHeight() + 5; -- 5 seems to be a magic fudge factor!
	if ( GetCVar("useUiScale") == "1" ) then
		if (uiScale) then
			frameHeight = frameHeight / uiScale;
		end
	end

	numButtons = frameHeight / buttonHeight;
	numEntries = getn(Phoenix_Config.entries);

	for i=1, PHOENIX_MAX_BUTTONS do
		local theButton = getglobal ("PhoenixEntry" .. i);
		if ( i <= numButtons and i <= numEntries ) then
			theButton:Show();
		else
			theButton:Hide();
		end
	end

	Phoenix_NumVisibleEntryButtons = floor(numButtons);
end

function Phoenix_UpdateScrollFrame()
	FauxScrollFrame_Update(PhoenixEntriesScrollFrame,table.getn(Phoenix_Config.entries),Phoenix_NumVisibleEntryButtons,32);
end

-- this functions trims string tail to make it fit into a buatton of specified width
function Phoenix_ChopButtonText(val, width)
	width = width - 5;
	local runningValue = val;
	local result = val;
	PhoenixHelperButton:SetText(val);
	while (PhoenixHelperButton:GetTextWidth() > width) do
		runningValue = string.sub(runningValue,1,string.len(runningValue)-1);
		result = runningValue .. "...";
		PhoenixHelperButton:SetText(result);
	end
	return result;
end

function Phoenix_UpdateEntriesScrollFrame()
	Phoenix_ScrollFrameOffset = FauxScrollFrame_GetOffset(PhoenixEntriesScrollFrame);
	for i=1, min(Phoenix_NumVisibleEntryButtons, table.getn(Phoenix_Config.entries)) do
		local button = getglobal("PhoenixEntry" .. i);
		button:SetText(Phoenix_ChopButtonText(Phoenix_Config.entries[Phoenix_ScrollFrameOffset + i].title, button:GetWidth()));
	end
end

function Phoenix_UpdateEntryList()
	Phoenix_UpdateEntryButtonVisibility();
	Phoenix_UpdateScrollFrame();
	Phoenix_UpdateEntriesScrollFrame();
end

function Phoenix_SaveCurrentEntry()
	local title = PhoenixEntryTitleEditBox:GetText();
	local body = PhoenixEntryEditBox:GetText();
	local event = PhoenixEventCheckButton:GetChecked();

	-- If the body and title are empty, we don't save
	if (title == "" and body == "") then
		return;
	end

	-- Otherwise
	local entryIndex = Phoenix_Config.selectedEntry;
	if ( entryIndex == 0 ) then
		entryIndex = table.getn(Phoenix_Config.entries) + 1;
		table.setn(Phoenix_Config.entries, entryIndex);
	end

	Phoenix_DeRegisterEventHookup(entryIndex);
	local entry = {};
	entry.title = title;
	entry.body = body;
	entry.event = event;
	Phoenix_Config.entries[entryIndex] = entry;
	Phoenix_Config.selectedEntry = entryIndex;

	Phoenix_RegisterEventHookup(entryIndex);
	Phoenix_UpdateEntryList();
end

function Phoenix_LoadEntry(aEntryId)
	Phoenix_Config.selectedEntry = aEntryId;
	PhoenixEventCheckButton:SetChecked(Phoenix_Config.entries[aEntryId].event);
	PhoenixEntryTitleEditBox:SetText(Phoenix_Config.entries[aEntryId].title);
	PhoenixEntryEditBox:SetText(Phoenix_Config.entries[aEntryId].body);
end

function Phoenix_ClearEntry()
	Phoenix_Config.selectedEntry = 0;
	PhoenixEntryTitleEditBox:SetText("");
	PhoenixEntryEditBox:SetText("");
	PhoenixEventCheckButton:SetChecked(0);
	PhoenixEntryTitleEditBox:SetFocus();
end

function Phoenix_OnNewButtonClick()
	Phoenix_SaveCurrentEntry();
	Phoenix_ClearEntry();
end

function Phoenix_OnDeleteButtonClick()
	if ( Phoenix_Config.selectedEntry ~= 0 ) then
		table.remove(Phoenix_Config.entries, Phoenix_Config.selectedEntry);
	end

	Phoenix_ClearEntry();
	Phoenix_UpdateEntryList();
end

function Phoenix_OnEntryClick(aButtonID)
	Phoenix_SaveCurrentEntry();

	local entryId = Phoenix_ScrollFrameOffset + aButtonID;
	Phoenix_LoadEntry(entryId);
end

function Phoenix_OnCloseButtonClick(aArg)
	PhoenixFrame:Hide();
end

function Phoenix_OnEventButtonClick()
	Phoenix_SaveCurrentEntry();
end

function Phoenix_OnEntryBodyTextChanged()
	-- borrowed from MailFrame.xml; update the scrollbar
	local scrollBar = getglobal(this:GetParent():GetParent():GetName().."ScrollBar");
	this:GetParent():GetParent():UpdateScrollChildRect();
	local min, max
	min, max = scrollBar:GetMinMaxValues();
	if ( max > 0 and (this.max ~= max) ) then
		this.max = max
		scrollBar:SetValue(max);
	end
end

function Phoenix_OnEntryBodyTextUpdate()
	ScrollingEdit_OnUpdate();	
	PhoenixEntryEditBox:SetWidth(PhoenixFrame:GetWidth() - 220);
end

function Phoenix_OnEntryTitleEditFocusLost()
	Phoenix_SaveCurrentEntry();
end

function Phoenix_OnEntryBodyEditFocusLost()
	Phoenix_SaveCurrentEntry();
end


function Phoenix_OnResizeButtonMouseDown(aWhichCorner)
	this:GetParent():StartSizing(aWhichCorner);
end

function Phoenix_OnResizeButtonMouseUp()
	this:GetParent():StopMovingOrSizing();
end

function Phoenix_OnDragStart()
	this:StartMoving();
end

function Phoenix_OnDragStop()
	this:StopMovingOrSizing();
end

function Phoenix_OnRunButtonClick()
	Phoenix_SaveCurrentEntry();
	Phoenix_RunScript(Phoenix_Config.selectedEntry);
end

--[[ Chat commands registration and handling
--]]

function Phoenix_RegisterChatCommands()
	SLASH_PHOENIX_HELP1 = "/phoenix";
	SLASH_PHOENIX_HELP2 = "/px";

	SlashCmdList["PHOENIX_HELP"] = function(msg)
		Phoenix_SlashCommandHandler(msg);
	end

	SLASH_PHOENIX_TOGGLE1 = "/pxt";
	SLASH_PHOENIX_TOGGLE2 = "/pxtoggle";

	SlashCmdList["PHOENIX_TOGGLE"] = function(msg)
		Phoenix_Toggle();
	end

	SLASH_PHOENIX_OVERRIDE1 = "/pxv";
	SLASH_PHOENIX_OVERRIDE2 = "/pxoverride";

	SlashCmdList["PHOENIX_OVERRIDE"] = function(msg)
		Phoenix_EventHookupsOvverrideToggle();
	end

	SLASH_PHOENIX_RELOAD1 = "/pxr";
	SLASH_PHOENIX_RELOAD2 = "/pxreload";

	SlashCmdList["PHOENIX_RELOAD"] = function(msg)
		Phoenix_Restart();
	end

	SLASH_PHOENIX_LIST1 = "/pxl";
	SLASH_PHOENIX_LIST2 = "/pxlist";

	SlashCmdList["PHOENIX_LIST"] = function(msg)
		Phoenix_PrintEventHookups();
	end

	SLASH_PHOENIX_SCRIPT1 = "/pxs";
	SLASH_PHOENIX_SCRIPT2 = "/pxscript";

	SlashCmdList["PHOENIX_SCRIPT"] = function(msg)
		Phoenix_RunScriptByName(Phoenix_Trim(msg));
	end

	SLASH_PHOENIX_ERRORS1 = "/pxe";
	SLASH_PHOENIX_ERRORS2 = "/pxerrors";

	SlashCmdList["PHOENIX_ERRORS"] = function(msg)
		Phoenix_PrintErrors(msg);
	end

	SLASH_PHOENIX_CHATERRORSTOGGLE1 = "/pxc";
	SLASH_PHOENIX_CHATERRORSTOGGLE2 = "/pxchaterrorstoggle";

	SlashCmdList["PHOENIX_CHATERRORSTOGGLE"] = function(msg)
		Phoenix_ToggleChatErrors();
	end

	SLASH_PHOENIX_DUMP1 = "/pxd";
	SLASH_PHOENIX_DUMP2 = "/pxdump";

	SlashCmdList["PHOENIX_DUMP"] = function(msg)
		Phoenix_Dump(msg);
	end
end

function Phoenix_SlashCommandHandler(msg)
	if ((not msg) or (msg == "")) then
		Phoenix_PrintChatCommandHelp();
		return;
	end

	if (msg == "script") then
		Phoenix_PrintScriptCommandHelp();
		return;
	end

	if (msg == "dump") then
		Phoenix_PrintDumpOptionsHelp();
		return;
	end

	if ( string.sub(msg, 1, string.len("dump ")) == "dump ") then
		local submsg = string.sub(msg, string.len("dump ")+1,-1);
			Phoenix_DumpOptionsCommandHandler(submsg);
		return;
	end

	if (msg == "chat") then
		if (Phoenix_Config.defaultChatFrameName) then
			if( DEFAULT_CHAT_FRAME ) then
				DEFAULT_CHAT_FRAME:AddMessage(PHOENIX_CHAT_FRAME_MESSAGE .. ": '" .. Phoenix_Config.defaultChatFrameName .. "'");
			end
		else
			if( DEFAULT_CHAT_FRAME ) then
				DEFAULT_CHAT_FRAME:AddMessage(PHOENIX_CHAT_FRAME_MESSAGE ..  ": default");
			end
		end
		return;
	end

	if ( string.sub(msg, 1, string.len("chat ")) == "chat ") then
		Phoenix_Config.defaultChatFrameName = string.sub(msg, string.len("chat ")+1,-1);
		if( DEFAULT_CHAT_FRAME ) then
			DEFAULT_CHAT_FRAME:AddMessage(PHOENIX_CHAT_FRAME_MESSAGE .. ": '" .. Phoenix_Config.defaultChatFrameName .. "'");
		end
		return;
	end

	if (msg == "timeout") then
		Phoenix_Print(PHOENIX_TIMEOUT_MESSAGE, nil, Phoenix_Config.errorTiemout)
		return;
	end

	if ( string.sub(msg, 1, string.len("timeout ")) == "timeout ") then
		local timeoutString = string.sub(msg, string.len("timeout ")+1,-1);
		if (tonumber(timeoutString)) then
			Phoenix_Config.errorTiemout = tonumber(timeoutString);
		end
		Phoenix_Print(PHOENIX_TIMEOUT_MESSAGE, nil, Phoenix_Config.errorTiemout)
		return;
	end

	Phoenix_Print(Phoenix_ErrorColor .. PHOENIX_UNKNOWN_COMMAND_MESSAGE .. FONT_COLOR_CODE_CLOSE);
end

function Phoenix_ToBoolean(val)
	if (val=="true") then
		return true;
	elseif (val=="false") then
		return false
	else
		return nil;
	end
end

function Phoenix_DumpOptionsCommandHandler(msg)
	local optionTable =
	{
		entrylimit = { convertor = tonumber; value = "dumpMaxEntryCutoff"; };
		stringlimit = {	convertor = tonumber; value = "dumpLongStringCutoff"; };
		depthlimit = { convertor = tonumber; value = "dumpDepthCutoff"; };
		ident = { convertor = tonumber; value = "dumpIdent"; };
		trackloops = { convertor = Phoenix_ToBoolean; value = "dumpUseTableCache"; };
	};

	if (msg == "show") then
		for index, entry in pairs(optionTable) do
			Phoenix_Print(index .. "=" .. tostring(Phoenix_Config[entry.value]))
		end
		return;
	end

	for index, entry in pairs(optionTable) do
		if (msg == index) then
			Phoenix_Print(index .. "=" .. tostring(Phoenix_Config[entry.value]))
			return;
		end
		local messagePrefix = index .. " "
		if ( string.sub(msg, 1, string.len(messagePrefix)) == messagePrefix) then
			local newVal = string.sub(msg, string.len(messagePrefix)+1,-1);
			if (entry.convertor(newVal)) then
				Phoenix_Config[entry.value] = entry.convertor(newVal);
			else
				Phoenix_Print(Phoenix_ErrorColor .. PHOENIX_UNKNOWN_DUMP_VALUE_MESSAGE  .. FONT_COLOR_CODE_CLOSE, nil, newVal, index);
			end
			return;
		end

	end
	Phoenix_Print(Phoenix_ErrorColor .. PHOENIX_UNKNOWN_DUMP_OPTION_MESSAGE .. FONT_COLOR_CODE_CLOSE);
end

-- submits a chat command
function Phoenix_RunChatCommand(command)
	PhoenixHelperEditBox:SetText(command);
	ChatEdit_SendText(PhoenixHelperEditBox);
end

--[[ Code snippets execution code
--]]

function Phoenix_RunScript(entryId)
	if (entryId > 0) then
		local body = Phoenix_Config.entries[entryId].body;
		if (body and body ~= "") then
			Phoenix_Script_Name = Phoenix_Config.entries[entryId].title;
			local curPxname = pxname;
			pxname = Phoenix_Script_Name;
			RunScript(body);
			pxname = curPxname;
		end
	end
end

function Phoenix_RunScriptByName(name, asEvent, dontReportAbsense)
	local index, entry;
	local executed;
	for index, entry in pairs(Phoenix_Config.entries) do
		if (entry.title == name) then
			if (asEvent) then
				if (entry.event == 1) then
					local curPxevent = pxevent;
					Phoenix_Script_Is_Event = true;
					pxevent = Phoenix_Script_Is_Event;
					executed = true;
					Phoenix_RunScript(index);
					Phoenix_Script_Is_Event = curPxevent;
					pxevent = Phoenix_Script_Is_Event;
				end
			else
				Phoenix_Script_Is_Event = false;
				pxevent = Phoenix_Script_Is_Event;
				executed = true;
				Phoenix_RunScript(index);
				Phoenix_Script_Is_Event = curPxevent;
				pxevent = Phoenix_Script_Is_Event;
			end
		end
	end
	if (not executed and not dontReportAbsense) then
		local message;
		if (asEvent) then
			message = string.format(PHOENIX_NO_HANDLER_MESSAGE, name);
		else
			message = string.format(PHOENIX_NO_SCRIPT_MESSAGE, name);
		end
		Phoenix_Print(Phoenix_ErrorColor .. message .. FONT_COLOR_CODE_CLOSE);
	end
end

--[[ Event Hook up code
--]]

Phoenix_Config.eventHookupsOverride = nil;

function Phoenix_EventHookupsOvverrideToggle()
	if (Phoenix_Config.eventHookupsOverride) then
		Phoenix_Print(PHOENIX_EVENTS_ON_MESSAGE);
      		Phoenix_Config.eventHookupsOverride = nil;
	else
		Phoenix_Print(PHOENIX_EVENTS_OFF_MESSAGE);
      		Phoenix_Config.eventHookupsOverride = true;
	end
end

function Phoenix_RegisterEventHookup(entryId)
	if (Phoenix_Config.entries[entryId].event == 1) then
		PhoenixFrame:RegisterEvent(Phoenix_Config.entries[entryId].title);
	end
end

function Phoenix_ProcessEventHookup(event)
	if ( not Phoenix_Config.eventHookupsOverride) then
		Phoenix_RunScriptByName(event, true)
	end
end

function Phoenix_DeRegisterEventHookup(entryId)
	if (Phoenix_Config.entries[entryId] and (Phoenix_Config.entries[entryId].event == 1)) then
		PhoenixFrame:UnregisterEvent(Phoenix_Config.entries[entryId].title);
	end
end

function Phoenix_InitEventHookups()
	table.foreach(Phoenix_Config.entries,Phoenix_RegisterEventHookup)
end

function Phoenix_PrintEventHookups()
	Phoenix_Print(PHOENIX_EVENT_LIST_MESSAGE)
	for index, entry in pairs(Phoenix_Config.entries) do
		if (entry.event == 1) then
			Phoenix_Print(entry.title);
		end
	end
end

--[[ Target chat frame handling code
--]]

Phoenix_Config.defaultChatFrameName = nil;

function Phoenix_GetChatFrameByName(name)
	for i=1, NUM_CHAT_WINDOWS do
		local chatFrameTab = getglobal("ChatFrame" .. i .. "Tab");
		if (chatFrameTab:GetText() == name) then
			return getglobal("ChatFrame" .. i);
		end
	end
end

function Phoenix_Print(msg, chatFrameName, ...)
   if( not chatFrameName ) then
   	chatFrameName = Phoenix_Config.defaultChatFrameName;
   end

   local chatFrame = Phoenix_GetChatFrameByName(chatFrameName);

   if( not chatFrame ) then
	chatFrame = DEFAULT_CHAT_FRAME;
   end

   if( chatFrame ) then
      if (arg and (table.getn(arg) > 0)) then
        chatFrame:AddMessage(string.format(msg,unpack(arg)));
      else
        chatFrame:AddMessage(msg);
      end
   end
end

function Phoenix_SetDefaultChatFrameName(chatFrameName)
	Phoenix_Config.defaultChatFrameName = chatFrameName;
end

--[[ Redirection of errors to a chat frame code
--]]

Phoenix_Config.chatErrorsOn = nil;
Phoenix_Config.errorTiemout = 1;

NUMBER_ERROR_MESSAGE_MAX = 999;
NUMBER_ERROR_MESSAGE_INFINITE = 20;

Phoenix_ErrorMessageList = { };

function Phoenix_ERRORMESSAGE(message)
	debuginfo();
	if (not message) then
		return;
	end

	local suppressPrint = nil;
	local messageFound = nil;
	for index, entry in Phoenix_ErrorMessageList do
		if (entry.message == message) then
			if (entry.count < NUMBER_ERROR_MESSAGE_INFINITE) then
				entry.count = entry.count + 1;
			end
			local time = GetTime();
			if (time - entry.timestamp < Phoenix_Config.errorTiemout) then
				suppressPrint = true;
			end
			entry.timestamp = time;
			messageFound = entry;
			break;
		end
	end

	if (not messageFound) then
		while (table.getn(Phoenix_ErrorMessageList) >= NUMBER_ERROR_MESSAGE_MAX) do
			table.remove(Phoenix_ErrorMessageList,1);
		end
		table.insert(Phoenix_ErrorMessageList, {message = message; count = 1; timestamp = GetTime()});
		messageFound = Phoenix_ErrorMessageList[table.getn(Phoenix_ErrorMessageList)]
	end

	if (not suppressPrint) then
		Phoenix_PrintError(messageFound);
	end

end

function Phoenix_message(text)
	Phoenix_ERRORMESSAGE(text);
end

function Phoenix_PrintError(entry)
	local useless, useless, file, line, error = string.find(entry.message, "^%[string \"(.+)\"%]:([^:]+):(.+)");
	if (file) then
		local hasFileInfo = string.find(file, "%.lua$") or string.find(file, "%.xml$")
	end

	local message;
	local count;

	if (entry.count >= NUMBER_ERROR_MESSAGE_INFINITE) then
		count = "Infinite";
	else
		count = entry.count;
	end


	if (file) then
		if (hasFileInfo) then
			message = Phoenix_ErrorColor .. PHOENIX_FILE.." "..file..","..PHOENIX_LINE.." "..line..","..PHOENIX_COUNT.." "..count..","..PHOENIX_ERROR..error..FONT_COLOR_CODE_CLOSE;
		else
			message = Phoenix_ErrorColor .. PHOENIX_STRING.." "..file..","..PHOENIX_LINE.." "..line..","..PHOENIX_COUNT.." "..count..","..PHOENIX_ERROR..error..FONT_COLOR_CODE_CLOSE;
		end
	else
		message = Phoenix_ErrorColor .. PHOENIX_COUNT ..count..","..PHOENIX_ERROR..entry.message..FONT_COLOR_CODE_CLOSE;
	end
	Phoenix_Print(message);
end

function Phoenix_PrintErrors(msg)
	Phoenix_Print(table.getn(Phoenix_ErrorMessageList) .. PHOENIX_ERRORS_REGISTERED_MESSAGE)
	local start = 1;
	if (tonumber(msg)) then
		Phoenix_Print(PHOENIX_ERRORS_LAST_MESSAGE .. tonumber(msg));
		start = table.getn(Phoenix_ErrorMessageList) - tonumber(msg) + 1;
	end
	if(start < 1) then
		start = 1;
	end
	for i = start, table.getn(Phoenix_ErrorMessageList), 1 do
		Phoenix_PrintError(Phoenix_ErrorMessageList[i]);
	end
end

function Phoenix_ToggleChatErrors()
	if (Phoenix_Config.chatErrorsOn) then
		Phoenix_Config.chatErrorsOn = nil;
		Phoenix_Print(PHOENIX_CHAT_OFF_MESSAGE);
		_ERRORMESSAGE = Phoenix_OldERRORMESSAGE;
		message = Phoenix_OldMessage;
		Phoenix_OldERRORMESSAGE = nil;
		Phoenix_OldMessage = nil;
	else
		Phoenix_Config.chatErrorsOn = true;
		Phoenix_Print(PHOENIX_CHAT_ON_MESSAGE);
		Phoenix_OldERRORMESSAGE = _ERRORMESSAGE;
		Phoenix_OldMessage = message;
		_ERRORMESSAGE = Phoenix_ERRORMESSAGE;
		message = Phoenix_message;
	end
end

--[[ Code for dumping expressions
--]]

local Phoenix_DumpColorUnprintable="|cff88ff88";
local Phoenix_DumpColorReference="|cffffcc00";
local Phoenix_DumpColorCutoff="|cffff0000";

Phoenix_LastDumpTableCache = nil;

Phoenix_Config.dumpMaxEntryCutoff = 30;
Phoenix_Config.dumpLongStringCutoff = 60;
Phoenix_Config.dumpDepthCutoff = 10;
Phoenix_Config.dumpIdent = 1;
Phoenix_Config.dumpUseTableCache = true;

-- the main dump function
function Phoenix_Dump(msg)
	if ( string.sub(msg, 1, string.len("table ")) == "table ") then
		local tableRef = string.sub(msg, string.len("table ")+1,-1);
		local table = nil;
		if (tonumber(tableRef)) then
			table = Phoenix_LastDumpTableCache[tonumber(tableRef)];
		else
			table = Phoenix_LastDumpTableCache[tableRef];
		end
		if (table) then
			Phoenix_Print(tableRef);
			Phoenix_DumpExpression(table);
		else
			Phoenix_Print(Phoenix_ErrorColor .. PHOENIX_NO_TABLE_MESSAGE .. FONT_COLOR_CODE_CLOSE, nil, tableRef);
		end
	else
		Phoenix_Print(msg);
		RunScript("Phoenix_DumpExpression(" .. msg .. ")");
	end
end

function Phoenix_DumpNil()
	return "nil";
end

function Phoenix_DumpBoolean(val)
	if (val) then
		return("true");
	else
		return("false");
	end
end

function Phoenix_DumpNumber(val)
	return tostring(val);
end

function Phoenix_DumpString(val)
	return "\"" .. Phoenix_DumpVanilaString(val) .. "\"";
end

function Phoenix_DumpVanilaString(val)
	local l = string.len(val);
	local more = "";
	if ((l > Phoenix_Config.dumpLongStringCutoff) and (Phoenix_Config.dumpLongStringCutoff > 0)) then
		more = "...+" .. (l - Phoenix_Config.dumpLongStringCutoff);
		val = string.sub(val, 1, Phoenix_Config.dumpLongStringCutoff);
	end
	-- this is for printing color codes instead of colors
	return string.gsub(val,"[|]", "||") .. more;
end

function Phoenix_GetInternalId(val)

	local strId = tostring(val);
	local start, finish = string.find(strId,": ",1,true);
	if (finish) then
		return string.sub(strId,finish+1);		
	end
	
end

function Phoenix_DumpUnprintable(val, cache)
	local index
	for k, v in pairs(cache) do
		if (v == val) then
			index = k;
			break;
		end
	end
	if (not index) then
		table.insert(cache,val);
		index = table.getn(cache);
	end

	return Phoenix_DumpColorUnprintable .. "<[" .. Phoenix_GetInternalId(val) .. "] " .. type(val) .. " " ..index .. ">"  .. FONT_COLOR_CODE_CLOSE;
end

function Phoenix_GetDepthIdent(depth)
	return string.rep(" ", depth*Phoenix_Config.dumpIdent );
end

function Phoenix_DumpTable(val, dumpConfig)

	local depth = dumpConfig.depth;
	local prefix = dumpConfig.prefix;

	if (depth >= Phoenix_Config.dumpDepthCutoff) then
		Phoenix_Print(Phoenix_GetDepthIdent(depth).."{");
		Phoenix_Print(Phoenix_DumpColorCutoff .. Phoenix_GetDepthIdent(depth+1) .. PHOENIX_TABLE_TOO_DEEP_MESSAGE .. FONT_COLOR_CODE_CLOSE);
		Phoenix_Print(Phoenix_GetDepthIdent(depth).."}");
		return;
	end

	dumpConfig.tableCache[prefix] = val;
	Phoenix_Print(Phoenix_GetDepthIdent(depth).."{");


	local counter = 0;
	for index, entry in pairs(val) do
		counter = counter + 1;
		if ((counter <= Phoenix_Config.dumpMaxEntryCutoff) or (Phoenix_Config.dumpMaxEntryCutoff <= 0)) then

			local currentString = Phoenix_GetDepthIdent(depth+1);
			local newPrefix;

			if (type(index)=="string") then
				newPrefix = "." .. index;
				currentString = currentString .. Phoenix_DumpVanilaString(index)  ..  " = ";
			elseif (type(index)=="table") then
				newPrefix = "[" .. Phoenix_DumpUnprintable(index, dumpConfig.tableCache) .. "]";
				currentString = currentString .. newPrefix .. " = ";
			else
				newPrefix = "[" .. Phoenix_GetFlatExpression(index, dumpConfig) .. "]";
				currentString = currentString .. newPrefix .. " = ";
			end

			local dumpRecursive = nil;

			if (type(entry)=="table") then
				local cahedEntryFound = nil;
				if (Phoenix_Config.dumpUseTableCache) then
					for k, v in pairs(dumpConfig.tableCache) do
						if (v == entry) then
							cahedEntryFound = k;
							break;
						end
					end
				end

				if (cahedEntryFound) then
					if (type(cahedEntryFound) == "number") then
						local indexToRemove = cahedEntryFound;
						cahedEntryFound = "table " .. cahedEntryFound;
						currentString = currentString .. "--[[" .. cahedEntryFound .. "]]";
						table.remove(dumpConfig.tableCache,indexToRemove);
						dumpRecursive = true;
					else
						currentString = currentString .. Phoenix_DumpColorReference .. cahedEntryFound .. FONT_COLOR_CODE_CLOSE .. ";";
					end
				else
					dumpRecursive = true;
				end
			else
				currentString = currentString .. Phoenix_GetFlatExpression(entry, dumpConfig) .. ";";
			end

			Phoenix_Print(currentString);

			if (dumpRecursive) then
				dumpConfig.depth = depth + 1;
				dumpConfig.prefix = prefix .. newPrefix;
				Phoenix_DumpTable(entry, dumpConfig)
			end
		end
	end

	local cutoff = counter - Phoenix_Config.dumpMaxEntryCutoff;
	if ((cutoff > 0) and (Phoenix_Config.dumpMaxEntryCutoff > 0)) then
		Phoenix_Print(Phoenix_DumpColorCutoff ..  Phoenix_GetDepthIdent(depth+1) .. PHOENIX_SKIPPED_MESSAGE .. FONT_COLOR_CODE_CLOSE, nil, cutoff);
	end

	Phoenix_Print(Phoenix_GetDepthIdent(depth).."}");
end

function Phoenix_DumpExpression(val)

	local dumpConfig =
		{
			userdataCache = {};
			functionCache = {};
			threadCache = {};
			tableCache = {};
			depth = 0;
			prefix = "this";
		}

	if (type(val)=="table") then
		Phoenix_DumpTable(val, dumpConfig);
	else
		Phoenix_Print(Phoenix_GetFlatExpression(val, dumpConfig));
	end

	Phoenix_LastDumpTableCache = dumpConfig.tableCache;
	return dumpConfig;
end

function Phoenix_GetFlatExpression(val, dumpConfig)

	if (type(val)=="nil") then
		return Phoenix_DumpNil();
	elseif (type(val)=="boolean") then
		return Phoenix_DumpBoolean(val);
	elseif (type(val)=="number") then
		return Phoenix_DumpNumber(val);
	elseif (type(val)=="string") then
		return Phoenix_DumpString(val);
	elseif (type(val)=="function") then
		return Phoenix_DumpUnprintable(val, dumpConfig.functionCache);
	elseif (type(val)=="userdata") then
		return Phoenix_DumpUnprintable(val, dumpConfig.userdataCache);
	elseif (type(val)=="thread") then
		return Phoenix_DumpUnprintable(val, dumpConfig.threadCache);
	else
		return Phoenix_ErrorColor .. PHOENIX_UNKNOWN_TYPE_MESSAGE .. type(val) .. FONT_COLOR_CODE_CLOSE;
	end
end

--[[ Shortcats for most usefull commands for the text editor
--]]

pxc = Phoenix_RunChatCommand;
pxs = Phoenix_RunScriptByName;
pxp = Phoenix_Print;
pxd = Phoenix_DumpExpression;




