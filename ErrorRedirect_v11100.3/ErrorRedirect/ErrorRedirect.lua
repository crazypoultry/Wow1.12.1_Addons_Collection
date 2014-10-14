--
-- Error Redirect with GUI
--
-- by Thomas Watts
-- Original Error Redirect by Bastian Pflieger <wb@illogical.de>
-- Credits: Idea by Bunny, compiling original default filter lists
--
-- supports "myAddOns": http://www.curse-gaming.com/en/wow/addons-358-1-myaddons.html
--

ERRORREDIRECT_FIXEDFILTERS = "FixedFilters";
ERRORREDIRECT_PARTIALFILTERS = "PartialFilters";
ErrorRedirect_AvailableFrames = 0;

local function ErrorRedirect_BinarySearch(tFind)
	local currArr = ErrorRedirect_Options[ERRORREDIRECT_FIXEDFILTERS];
	if( not currArr ) then
		return -1;
	end
	local start, curr, last, cStr;
  
	start = 1;
	last = ErrorRedirect_Options[ERRORREDIRECT_FIXEDFILTERS.."Length"];
	curr = math.ceil((last + start) / 2);
  
	while(start <= last) do
		cStr = currArr[curr];
		if( not cStr and curr ~= last ) then
			cStr = currArr[curr + 1];
		end
		if( not cStr ) then
			local errH = geterrorhandler();
			errH("BinarySearch failed on "..tFind.." Fixed filter "..(curr + 1).." does not exist.");
			return -1;
		end
		cStr = cStr["String"];
		if( cStr == tFind ) then
			return curr;
		elseif( tFind > cStr ) then
			start = curr + 1;
		else
			last = curr - 1;
		end
		curr = math.ceil((last + start) / 2);
	end
	return curr;
end

local function ErrorRedirect_TableSort(arr, tLen)
	local hasSwapped = false;
	local cLast;
	local curr = 1;
	local swapTempStr, swapTempAct, swapTempCol;

	if( not tLen ) then
		tLen = 0;
		for i, _ in arr do
			tLen = i;
		end
	end
	cLast = tLen;
	if( cLast <= curr ) then
		return 0;
	end
	while( true ) do
		if( arr[curr]["String"] > arr[curr+1]["String"] ) then
			hasSwapped = true;
			swapTempStr = arr[curr+1]["String"];
			swapTempAct = arr[curr+1]["Active"];
			swapTempCol = arr[curr+1]["Color"];
			arr[curr+1]["String"] = arr[curr]["String"];
			arr[curr+1]["Active"] = arr[curr]["Active"];
			arr[curr+1]["Color"] = arr[curr]["Color"];
			arr[curr]["String"] = swapTempStr;
			arr[curr]["Active"] = swapTempAct;
			arr[curr]["Color"] = swapTempCol;
		end
		curr = curr + 1;
		if( curr >= cLast ) then
			curr = 1;
			cLast = cLast - 1;
			if( not hasSwapped ) then
				break;
			end
			hasSwapped = false;
		end
	end
	return tLen;
end

function ErrorRedirect_TableRemove(wlist, index)
	local arr = ErrorRedirect_Options[wlist];
	local tLen = ErrorRedirect_Options[wlist.."Length"];
	if( not index ) then
		local errH = geterrorhandler();
		errH("ErrorRedirect_TableRemove bad argument #2, nil passed, integer expected");
		return;
	end
	table.remove(arr, index);
	ErrorRedirect_Options[wlist.."Length"] = tLen - 1;
end

function ErrorRedirect_TableInsert(wlist, value)
	local arr = ErrorRedirect_Options[wlist];
	local tLen = ErrorRedirect_Options[wlist.."Length"];
	if( not value or not value["String"] ) then
		local errH = geterrorhandler();
		errH("ErrorRedirect_TableInsert bad argument #2, "..(value and (value["String"] or "nil passed, string value expected") or "nil passed, table expected"));
		return;
	end
	if( wlist == ERRORREDIRECT_PARTIALFILTERS ) then
		table.insert(arr, value);
		ErrorRedirect_Options[wlist.."Length"] = tLen + 1;
		return;
	end
	local pos = ErrorRedirect_BinarySearch(value["String"]);
	table.insert(arr, pos, value);
	ErrorRedirect_Options[wlist.."Length"] = tLen + 1;
end

local function ErrorRedirect_FindChatFrames()
	--changed from GetChildren because patch 1.11 will hide unnamed objects until query
	--this would just cause memory usage to go up, so any redirect can only goto Blizzards chat frames
	--SORRY!
	--local auipc = { UIParent:GetChildren() };
	local ltmp1, ltmp2, cfr;

	ErrorRedirect_AvailableFrames =
		{
			{ 0, ERRORREDIRECT_DEFAULT },
			{ ERRORREDIRECT_DISCARDFILTER, ERRORREDIRECT_DISCARD },
			{ ERRORREDIRECT_PERFILTER, ERRORREDIRECT_NOREDIRECT },
		};
	--for ci,cfr in ipairs(auipc) do
	for i = 1, NUM_CHAT_WINDOWS, 1 do
		--if( cfr:GetFrameType() == "ScrollingMessageFrame" ) then
		cfr = getglobal("ChatFrame"..i);
		if( cfr ) then
			ltmp1 = cfr:GetName();
			ltmp2 = getglobal(ltmp1.."Tab"):GetText();
			if( not ltmp2 or string.len(ltmp2) <= 0 ) then
				ltmp2 = "General";
			end
			table.insert(ErrorRedirect_AvailableFrames, { ltmp1, ltmp2 });
		end
	end
end

function ErrorRedirect_RetrieveIndex(ind, wlist)
	local clist = ErrorRedirect_Options[wlist];
	local last  = ErrorRedirect_Options[wlist.."Length"];
	local iT = tonumber(ind);

	if( iT ) then
		if( iT < 1 or iT > last ) then -- bounds checkings
			return nil;
		end
		return iT;
	else
		--Searches through all filters for the partial word
		for i, ck in ipairs(clist) do
			if( ck["String"] ~= "" and string.find(ck["String"], ind) ) then
				return i;
			end
		end
	end
	return nil; -- this will throw an error
end

local function ErrorRedirect_ShowFilterInformation(wlist, sz)
	local tmp = ErrorRedirect_Options[wlist][sz];
	local bfa;
	local col = tmp["Color"];

	if( tmp["Active"] ) then
		bfa = "Yes";
	else
		bfa = "No";
	end
	if( not col ) then
		col = "red";
	end
	DEFAULT_CHAT_FRAME:AddMessage("Filter: "..sz.."\nString: "..tmp["String"].."\nActive: "..bfa.."\nColor: "..col);
end

local function ErrorRedirect_DeployOptions(cmd)
	local sz = 0;
	local tokens = {};
	cmd = string.gsub(cmd, "([%S]+)", function(w) table.insert(tokens,w) end);

	sz = table.getn(tokens);
	if( sz <= 0 ) then
		DEFAULT_CHAT_FRAME:AddMessage(ERRORREDIRECT_CHATHELP1);
		return;
	end

	local word = string.lower(tokens[1]);
	if( word == "options" ) then
		local tmp = getglobal("ErrorRedirectOptionsFrame");
		if( tmp ) then
			ShowUIPanel(tmp);
		end
		return;
	end

	local wlist, isNum;
	if( word == "fixed" ) then
		wlist = ERRORREDIRECT_FIXEDFILTERS;
		isNum = false;
	elseif( word == "partial" ) then
		wlist = ERRORREDIRECT_PARTIALFILTERS;
		isNum = true;
	else
		DEFAULT_CHAT_FRAME:AddMessage(ERRORREDIRECT_CHATHELP1);
		return;
	end

	if( sz < 2 ) then
		DEFAULT_CHAT_FRAME:AddMessage(ERRORREDIRECT_CHATHELP1);
		return;
	end

	local word = string.lower(tokens[2]);
	if( word == "find" ) then
		if( sz == 3 ) then
			sz = ErrorRedirect_RetrieveIndex(tokens[3], wlist);
			if( not sz ) then
				DEFAULT_CHAT_FRAME:AddMessage(wlist .. " " .. tokens[3] .. " cannot be found.");
				return;
			end
			ErrorRedirect_ShowFilterInformation(wlist, sz);
		else
			DEFAULT_CHAT_FRAME:AddMessage(wlist.." list contains "..ErrorRedirect_Options[wlist.."Length"].." entries");
		end
	elseif( word == "reset" ) then
		ErrorRedirect_IntializeFilters(wlist, true);
		DEFAULT_CHAT_FRAME:AddMessage(wlist .. " reset to defaults.");
	elseif( word == "add" and sz >= 3 ) then
		cmd = table.concat(tokens, " ", 3);
		if( not cmd or cmd == "" ) then
			ErrorRedirect_ErrorMessage("String not accepted, filter was not added");
			return;
		end
		ErrorRedirect_TableInsert(wlist, { ["String"] = cmd, ["Active"] = true, } );
		DEFAULT_CHAT_FRAME:AddMessage("Filter " .. cmd .. " added to " .. wlist);
	elseif( word == "delete" and sz == 3 ) then
		sz = ErrorRedirect_RetrieveIndex(tokens[3], wlist);
		ErrorRedirect_TableRemove(wlist, sz);
		DEFAULT_CHAT_FRAME:AddMessage("Filter " .. sz .. " removed from " .. wlist);
	elseif( word == "toggle" and sz == 3 ) then
		sz = ErrorRedirect_RetrieveIndex(tokens[3], wlist);
		ErrorRedirect_Options[wlist][sz]["Active"] = not ErrorRedirect_Options[wlist][sz]["Active"];
		ErrorRedirect_ShowFilterInformation(wlist, sz);
	elseif( word == "color" and sz == 4 ) then
		sz = ErrorRedirect_RetrieveIndex(tokens[3], wlist);
		cmd = string.lower(tokens[4]);
		if( ErrorRedirect_Colors[cmd] ) then
			ErrorRedirect_Options[wlist][sz]["Color"] = cmd;
		end
		ErrorRedirect_ShowFilterInformation(wlist, sz);
	else
		DEFAULT_CHAT_FRAME:AddMessage(ERRORREDIRECT_CHATHELP1);
		return;
	end
	sz = getglobal("ErrorRedirectOptionsFilterParent");
	if( sz ) then
		sz:Hide();
		sz:Show();
	end
end

--should only use the error redirect frame if it exists and moderrors is enabled
function ErrorRedirect_ErrorMessage(text)
	if( ErrorRedirect_Options["ModErrors"] ) then
		local ggl = ErrorRedirect_Options["SuppressFrame"] or ErrorRedirect_Options["Frame"]
		ggl = getglobal(ggl);
		if( ggl ) then
			ggl:AddMessage(text, 1.0, 0.0, 0.0);
			return;
		end
	end
	_ERRORHANDLER(text);
end

function ErrorRedirect_OnLoad()
	ErrorRedirect_FindChatFrames();

	ErrorRedirect_Options = {
		["IsEnabled"] = true,
		["Frame"] = "ChatFrame1", -- General chat frame
		["Highlight"] = true,
		["ModErrors"] = false,
		["SuppressFrame"] = "ChatFrame1";
		[ERRORREDIRECT_FIXEDFILTERS] = false,
		[ERRORREDIRECT_PARTIALFILTERS] = false,
		[ERRORREDIRECT_FIXEDFILTERS.."Start"] = 1,
		[ERRORREDIRECT_PARTIALFILTERS.."Start"] = 1,
		[ERRORREDIRECT_FIXEDFILTERS.."Length"] = 0,
		[ERRORREDIRECT_PARTIALFILTERS.."Length"] = 0,
	};

	--this:RegisterEvent("SYSMSG");
	this:RegisterEvent("UI_INFO_MESSAGE");
	this:RegisterEvent("UI_ERROR_MESSAGE");
	UIErrorsFrame:UnregisterEvent("UI_INFO_MESSAGE");
	UIErrorsFrame:UnregisterEvent("UI_ERROR_MESSAGE");
	--Don't need to unregister SYSMSG for UIErrorsFrame
	--UIErrorsFrame:UnregisterAllEvents();

	SLASH_ERROR_REDIRECT1 = "/error_redirect";
	SLASH_ERROR_REDIRECT2 = "/err";
	--SLASH_ERROR_REDIRECT2 = "/config_redirect";
	SlashCmdList["ERROR_REDIRECT"] = ErrorRedirect_DeployOptions;

	--this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_LOGIN");
end

local function ErrorRedirect_GetIndividualColors(msg, pColor, r, g, b, a)
	local colrgba;
	if( ErrorRedirect_Options["Highlight"] ) then
		if( not (pColor and ErrorRedirect_Colors[pColor]) ) then
			pColor = "red";
		end
		colrgba = ErrorRedirect_Colors[pColor];
		r = colrgba.r;
		g = colrgba.g;
		b = colrgba.b;
		a = colrgba.a;
	end
	return r, g, b, a;
end

local function ErrorRedirect_MatchesFixedString(msg, ignoreDisabled)
	local curr = ErrorRedirect_BinarySearch(msg);
	curr = ErrorRedirect_RetrieveIndex(curr, ERRORREDIRECT_FIXEDFILTERS);
	if( not curr ) then
		return nil;
	end

	local filter = ErrorRedirect_Options[ERRORREDIRECT_FIXEDFILTERS][curr];
  
	if( filter["String"] == msg and (filter["Active"] or ignoreDisabled) ) then
		return filter;
	end
	return nil;
end

local function ErrorRedirect_MatchesPartialString(msg, ignoreDisabled)
	local filter = ErrorRedirect_Options[ERRORREDIRECT_PARTIALFILTERS];

	if( not filter ) then
		return nil;
	end
	for i, ck in ipairs(filter) do
		if( (ck["Active"] or ignoreDisabled) and string.find(msg, ck["String"]) ) then
			return filter[i];
		end
	end
	return nil;
end

local function ErrorRedirect_AddMessage(msg, r, g, b, a, holdTime)
	local gblFrame = ErrorRedirect_Options["Frame"];
	local isPF = (gblFrame == ERRORREDIRECT_PERFILTER or false);
	if( ErrorRedirect_Options["IsEnabled"] or isPF ) then
		local arr = ErrorRedirect_MatchesFixedString(msg, false);
		if( not arr ) then
			arr = ErrorRedirect_MatchesPartialString(msg, false);
		end
		if( arr ) then
			local ggl = nil;
			local arrF = arr["Frame"] or gblFrame;
			if( arrF == ERRORREDIRECT_DISCARDFILTER ) then
				return;
			end
			if( arrF ~= ERRORREDIRECT_PERFILTER ) then
				ggl = getglobal(arrF);
			else
				isPF = true;
			end
			r, g, b, a = ErrorRedirect_GetIndividualColors(msg, arr["Color"], r, g, b, a);
			if( ggl ) then
				ggl:AddMessage(msg, r, g, b, a);
				return;
			elseif( not isPF ) then --Discarded messages reach here.  Could error out here, too.
				return;
			end
		end
	end
	UIErrorsFrame:AddMessage(msg, r, g, b, a, holdTime);
end

function ErrorRedirect_IntializeFilters(erocfl, override)
	local setupStrings = ErrorRedirect_Options[erocfl];

	if( not setupStrings or override ) then
		local sortFL, lookup, lsiz, filter;
		if( erocfl == ERRORREDIRECT_FIXEDFILTERS ) then
			sortFL = ErrorRedirect_Filter_FixedErrorMessages;
			lookup = ErrorRedirect_MatchesFixedString;
		else
			sortFL = ErrorRedirect_Filter_PartialErrorMessages;
			lookup = ErrorRedirect_MatchesPartialString;
		end
		if( override ) then
			lsiz = ErrorRedirect_Options[erocfl.."Length"] or 0;
		end
		if( not lsiz or lsiz <= 0 ) then
			setupStrings = {};
			lsiz = 0;
			override = false;
		end
		for index, values in pairs(sortFL) do
			if( index and index ~= "" ) then
				if( values[2] == "red" ) then
					values[2] = nil;
				end
				if( override ) then
					filter = lookup(index, true);
				else
					filter = nil;
				end
				if( filter ) then
					filter["Active"] = values[1];
					filter["Color"] = values[2];
					filter["Frame"] = values[3];
				else
					table.insert(setupStrings, {
						["String"] = index,
						["Active"] = values[1],
						["Color"] = values[2],
						["Frame"] = values[3],
					} );
					lsiz = lsiz + 1;
				end
			end
		end
		--lsiz = lsiz - 1;
		if( erocfl == ERRORREDIRECT_FIXEDFILTERS ) then
			lsiz = ErrorRedirect_TableSort(setupStrings);
		end
		ErrorRedirect_Options[erocfl.."Length"] = lsiz;
		ErrorRedirect_Options[erocfl] = setupStrings;
	end
end

local function ErrorRedirect_RegisterMyAddons()
	if( myAddOnsFrame_Register ) then
		local ERdetails = {
			name = ERRORREDIRECT_NAME,
			version = ERRORREDIRECT_VERSION,
			releaseDate = ERRORREDIRECT_MYADDONS_RELEASEDATE,
			notes = "",
			author = "Thomas Watts",
			category = MYADDONS_CATEGORY_OTHERS,
			optionsframe = "ErrorRedirectOptionsFrame"
		};
		myAddOnsFrame_Register( ERdetails, { ERRORREDIRECT_CHATHELP1 } );
	end
end

function ErrorRedirect_OnEvent(event, arg1)
	--if ( event == "SYSMSG" ) then --possibly green messages too?
		--ErrorRedirect_AddMessage(arg1, arg2, arg3, arg4, 1.0, 5);
	if ( event == "UI_INFO_MESSAGE" ) then
		ErrorRedirect_AddMessage(arg1, 1.0, 1.0, 0.0, 1.0, 5); --yellow
	elseif ( event == "UI_ERROR_MESSAGE" ) then
		ErrorRedirect_AddMessage(arg1, 1.0, 0.1, 0.1, 1.0, 5); --red
	--elseif( event == "VARIABLES_LOADED" ) then
	--unregistering UIErrorsFrame events from here didn't always work
	elseif( event == "PLAYER_LOGIN" ) then
		--fired after VARIABLES_LOADED but before PLAYER_ENTERING_WORLD but still only once
		if( ErrorRedirect_Options["ModErrors"] ) then
			if( geterrorhandler() == _ERRORMESSAGE ) then
				seterrorhandler(ErrorRedirect_ErrorMessage);
			else
				DEFAULT_CHAT_FRAME:AddMessage("Set error handler failed.  Another MOD is already overriding.");
			end
		end
		if( not ErrorRedirect_Options["SuppressFrame"] ) then
			ErrorRedirect_Options["SuppressFrame"] = "ChatFrame1";
		end
		ErrorRedirect_RegisterMyAddons();
		ErrorRedirect_IntializeFilters(ERRORREDIRECT_FIXEDFILTERS, false);
		ErrorRedirect_IntializeFilters(ERRORREDIRECT_PARTIALFILTERS, false);
	end
end
