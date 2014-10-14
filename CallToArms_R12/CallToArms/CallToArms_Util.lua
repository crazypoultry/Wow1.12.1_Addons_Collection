CTA_MESSAGE					= "M";
CTA_GENERAL					= "I";
CTA_GROUP_UPDATE				= "G";
CTA_BLOCK					= "X";
CTA_SEARCH					= "S";

CTA_MESSAGE_COLOURS 		= {
	M = { r = 1,   b = 1,   g = 0.5 },
	I = { r = 1,   b = 0.5, g = 1   },
	G = { r = 0.5, b = 0.5, g = 1   },
	X = { r = 1,   b = 0.5, g = 0.5 },
	S = { r = 0.5, b = 1,   g = 0.5 },
	R = { r = 1,   b = 0,   g = 0   }
};

CTA_Classes					= {
	init = function()
		if( UnitFactionGroup(CTA_PLAYER) == CTA_ALLIANCE ) then
			CTA_Classes[8] = "PALADIN";
		else
			CTA_Classes[8] = "SHAMAN";
		end			
	end
};



CTA_Classes[1] = "PRIEST";
CTA_Classes[2] = "MAGE";
CTA_Classes[3] = "WARLOCK";
CTA_Classes[4] = "DRUID";
CTA_Classes[5] = "HUNTER";
CTA_Classes[6] = "ROGUE";
CTA_Classes[7] = "WARRIOR";
CTA_Classes[8] = "PALADIN";
CTA_Classes[9] = "SHAMAN";

CTA_Classes[CTA_PRIEST] 	= { id=1, txMin=0.50, txMax=0.75, tyMin=0.25, tyMax=0.50 };
CTA_Classes[CTA_MAGE] 		= { id=2, txMin=0.25, txMax=0.50, tyMin=0.00, tyMax=0.25 };
CTA_Classes[CTA_WARLOCK] 	= { id=3, txMin=0.75, txMax=1.00, tyMin=0.25, tyMax=0.50 };
CTA_Classes[CTA_DRUID] 		= { id=4, txMin=0.75, txMax=1.00, tyMin=0.00, tyMax=0.25 };
CTA_Classes[CTA_HUNTER] 	= { id=5, txMin=0.00, txMax=0.25, tyMin=0.25, tyMax=0.50 };
CTA_Classes[CTA_ROGUE] 		= { id=6, txMin=0.50, txMax=0.75, tyMin=0.00, tyMax=0.25 };
CTA_Classes[CTA_WARRIOR] 	= { id=7, txMin=0.00, txMax=0.25, tyMin=0.00, tyMax=0.25 };
CTA_Classes[CTA_PALADIN] 	= { id=8, txMin=0.00, txMax=0.25, tyMin=0.50, tyMax=0.75 };
CTA_Classes[CTA_SHAMAN] 	= { id=8, txMin=0.25, txMax=0.50, tyMin=0.25, tyMax=0.50 };	

CTA_Classes["PRIEST"]	 	= { localName=CTA_PRIEST, 	id=1, txMin=0.50, txMax=0.75, tyMin=0.25, tyMax=0.50, hex="ffffff" };
CTA_Classes["MAGE"] 		= { localName=CTA_MAGE, 	id=2, txMin=0.25, txMax=0.50, tyMin=0.00, tyMax=0.25, hex="68ccef" };
CTA_Classes["WARLOCK"] 		= { localName=CTA_WARLOCK, 	id=3, txMin=0.75, txMax=1.00, tyMin=0.25, tyMax=0.50, hex="9382c9" };
CTA_Classes["DRUID"] 		= { localName=CTA_DRUID, 	id=4, txMin=0.75, txMax=1.00, tyMin=0.00, tyMax=0.25, hex="ff7c0a" };
CTA_Classes["HUNTER"] 		= { localName=CTA_HUNTER, 	id=5, txMin=0.00, txMax=0.25, tyMin=0.25, tyMax=0.50, hex="aad372" };
CTA_Classes["ROGUE"] 		= { localName=CTA_ROGUE, 	id=6, txMin=0.50, txMax=0.75, tyMin=0.00, tyMax=0.25, hex="fff468" };
CTA_Classes["WARRIOR"]	 	= { localName=CTA_WARRIOR, 	id=7, txMin=0.00, txMax=0.25, tyMin=0.00, tyMax=0.25, hex="c69b6d" };
CTA_Classes["PALADIN"]	 	= { localName=CTA_PALADIN, 	id=8, txMin=0.00, txMax=0.25, tyMin=0.50, tyMax=0.75, hex="f48cba" };
CTA_Classes["SHAMAN"] 		= { localName=CTA_SHAMAN, 	id=8, txMin=0.25, txMax=0.50, tyMin=0.25, tyMax=0.50, hex="f48cba" };	


local trim;
local getOps;
local recursiveSearch; 
local cloneTable;
local dist;
local match_score;
local 

trim = function( s )
	if( not s ) then return nil; end
	return( string.gsub(s, "^%s*(.-)%s*$", "%1") or s );
end

getOps = function( source )
	local operatorFound = nil;
	local bracketCount = 0;
	local inQuote = 0;
	local pos = 0;
	
	local currentChar;
	local prevChar = "x";
	while( pos < string.len( source ) ) do
		currentChar = string.sub( source, pos, pos );
		if( ( currentChar == "+" or currentChar == "/" ) and bracketCount == 0 and inQuote == 0 ) then
			operatorFound = 1;
			break;
		elseif( currentChar == "(" ) then
			bracketCount = bracketCount + 1;
		elseif( currentChar == ")" ) then
			bracketCount = bracketCount - 1;
		elseif( currentChar == "\"" ) then
			inQuote = 1 - inQuote;
		else
			if( prevChar == " " and bracketCount == 0 and inQuote == 0 ) then
				operatorFound = 2;
				pos = pos - 1;
				break;
			end
		end
		prevChar = currentChar;
		pos = pos + 1;
	end
	if( operatorFound == 2 ) then	
		return "/", string.sub( source, 1, pos - 1 ), string.sub( source, pos + 1 );
	end
	if( operatorFound ) then	
		return currentChar, string.sub( source, 1, pos - 1 ), string.sub( source, pos + 1 );
	end
end

recursiveSearch = function( source, search ) 
	if( not ( source and search ) ) then
		return nil;
	end
	local s = trim( search );
	local operator, op1, op2 = getOps( s );
	
	if( operator ) then
		local op1Res = recursiveSearch( source, op1 );		
		if( not op1Res ) then
			return 0;
		elseif( op1Res > 0 and operator == "/" ) then
			return 1;
		elseif( op1Res == 0 and operator == "+" ) then
			return 0;
		end
		
		local op2Res = recursiveSearch( source, op2, verbose );
		if( not op2Res ) then
			return 0;
		elseif( op2Res > 0 and ( op1Res > 0 or operator == "/" ) ) then
			return 1;
		end
		return 0;
	else
		local literal;			
		if( string.sub( s, 1, 1 ) == "-" ) then
			return( 1 - recursiveSearch( source, trim( string.sub( s, 2 ) ) ) );
		elseif( string.sub( s, 1, 1 ) == "(" and string.sub( s, string.len( s ) ) == ")" ) then
			return recursiveSearch( source, trim( string.sub( s, 2, string.len( s ) - 1 ) ) );
		elseif( string.sub( s, 1, 1 ) == "\"" and string.sub( s, string.len( s ) ) == "\"" ) then
			s = trim( string.sub( s, 2, string.len( s ) - 1 ) );
			literal = 1;
		end
		if( literal ) then
			if( string.find( source, s ) ) then
				return 1;
			else
				return 0;
			end
		else
			if( string.find( source, s ) ) then
				return 1;
			else
				for word in string.gfind( s, "%w+" ) do
					if( string.find( source, "%s+"..word.."%s+" ) ) then
						return 1;
					elseif( string.find( source, "^"..word.."%s+" ) ) then
						return 1;
					elseif( string.find( source, "%s+"..word.."$" ) ) then
						return 1;
					end
				end
				return 0;
			end
		end
	end
end

cloneTable = function( t )
  local new = {};          
  local i, v;  
  for i, v in t do
  	if ( type(v)=="table" ) then 
   	   new[i] = cloneTable(v);
  	else
 	   new[i] = v;
  	end
  end
  return new;
end



--[[
	The CTA_Util table holds several utility functions.
	========================================================================================================================
--]]

CTA_Util = {};

--[[
	------------------------------------------------------------------------------------------------------------------------
	Time	
	Usage:		CTA_Util.getTime()
	Returns:	Current time in HH:MM
	------------------------------------------------------------------------------------------------------------------------
--]]

CTA_Util.getTime = function()
	local hour, minute = GetGameTime();
	if( hour < 10 ) then hour = "0"..hour; end
	if( minute < 10 ) then minute = "0"..minute; end
	return hour..":"..minute;
end

--[[
	------------------------------------------------------------------------------------------------------------------------
	Searching
	Usage:		CTA_Util.search( String , Query )
	Function:	Searches case-insensitive using regular expressions + (and) and / (or) e.G:
			"(Searching)+((one)/(last))
	Returns:	1 if search is successful else 0
	------------------------------------------------------------------------------------------------------------------------
--]]

CTA_Util.search = function ( s, q )
	local source =  string.lower( string.gsub( s, "|c(%w+)|H(%w+):(.+)|h(.+)|h|r", "%4" ) );	
	return recursiveSearch( source, string.lower( q ) ), source;
end

--[[
	------------------------------------------------------------------------------------------------------------------------
	Showing and filtering lists
	Usage:		CTA_Util.updateList
	Returns:	
	Usage:		CTA_Util.filterList
	Returns:	
	------------------------------------------------------------------------------------------------------------------------
--]]

CTA_Util.updateList = function ( list, first, UIListName, maxResults, offset, showResultItem, size )

	while( size <= offset ) do
		offset = offset - maxResults;
	end
	if( offset < 0 ) then offset = 0; end	

	local pos = 0;
	local current = first;
	while( current ~= 0 and pos < offset ) do
		pos = pos + 1;
		current = list[current].next;
	end
	pos = 0;
	while( current ~= 0 and pos < maxResults ) do
		pos = pos + 1;
		showResultItem( getglobal( UIListName..pos ), current );
		current = list[current].next;
	end
	while( pos < maxResults ) do
		pos = pos + 1;
		getglobal( UIListName..pos ):Hide();
	end
end

CTA_Util.filterList = function ( list, satisfiesFilter )
	local size = 0;
	local first = 0;
	local prev = 0;
	for key, data in list do
		if( not satisfiesFilter or satisfiesFilter( key ) ) then
			size = size + 1;
			if( first ~= 0 ) then
				list[prev].next = key;
			else
				first = key;
			end
			prev = key;
		end
		data.next = 0;	
	end
	return first, size;
end

--[[
	------------------------------------------------------------------------------------------------------------------------
	Output to chat, log and minimap
	Usage:		CTA_Util.errorPrintln
	Returns:	
	Usage:		CTA_Util.chatPrintln
	Returns:	
	Usage:		CTA_Util.iconPrintln
	Returns:	
	Usage:		CTA_Util.logPrintln
	Returns:	
	------------------------------------------------------------------------------------------------------------------------
--]]
		
CTA_Util.errorPrintln = function ( s )
	UIErrorsFrame:AddMessage(s, 0.75, 0.75, 1.0, 1.0, UIERRORS_HOLD_TIME);
end

CTA_Util.chatPrintln = function ( s )
	DEFAULT_CHAT_FRAME:AddMessage( "[CTA] "..( s or "nil" ), 0.9, 0.75, 0.20 ); --, 1, 0.75, 0.0);
end

CTA_Util.iconPrintln = function ( s, t )
	if( not t ) then
		CTA_MinimapMessageFrame:AddMessage( ( s or "nil" ), 1.0, 1.0, 0.5, 1.0, UIERRORS_HOLD_TIME);
	else
		local r = CTA_MESSAGE_COLOURS[t].r;
		local g = CTA_MESSAGE_COLOURS[t].g;
		local b = CTA_MESSAGE_COLOURS[t].b;
		CTA_MinimapMessageFrame:AddMessage( ( s or "nil" ), r, g, b, 1.0, UIERRORS_HOLD_TIME);
	end
end

CTA_Util.logPrintln = function ( s, t )
	local m = s;
	if( not m ) then
		m = "nil";
	end
	m = "["..CTA_Util.getTime().."] "..( m or "nil" );
	
	if( not t ) then
		CTA_Log:AddMessage( m, 1.0, 1.0, 0.5 );	
	else
		local r = CTA_MESSAGE_COLOURS[t].r;
		local g = CTA_MESSAGE_COLOURS[t].g;
		local b = CTA_MESSAGE_COLOURS[t].b;
		CTA_Log:AddMessage( m, r, g, b );	
	end
end

--[[
	------------------------------------------------------------------------------------------------------------------------
	Communication
	Usage:		CTA_Util.joinChannel( Channel Name )
	Returns:	1 (Also joins channel specified and hides it from sight
	Comments:	One line should be localized
	Usage:		CTA_Util.sendChatMessage( Message, Type, Channelname, Hidden )
			Message:	Message to be sent
			Type:		"SAY", "PARTY", "CHANNEL" etc.
			Channelname:	Name of Channel or Player to receive message
			Hidden:		if not nil it prefixes with "[CTA]" on 1 or "<CTA>" on other value
	Function:	Sends text using common language into channel specified. It breaks any hyperlinks contained
	Returns:	Nothing
	------------------------------------------------------------------------------------------------------------------------
--]]

CTA_Util.joinChannel = function( channel )
	JoinChannelByName( channel );
	RemoveChatWindowChannel( DEFAULT_CHAT_FRAME:GetID(), channel );
	CTA_Util.logPrintln( CTA_CALL_TO_ARMS_LOADED );
	CTA_Util.logPrintln( CTA_JOINED..channel );
	return 1;
end

CTA_Util.sendChatMessage = function( message, messageType, channel, hidden ) 
	local language = CTA_COMMON;
	if( UnitFactionGroup(CTA_PLAYER) ~= CTA_ALLIANCE ) then
		language = CTA_ORCISH;
	end
	if( not hidden ) then
		SendChatMessage( string.gsub( message, "|c(%w+)|H(%w+):(.+)|h(.+)|h|r", "%4" ), messageType, language, channel );
	elseif( hidden == 1 ) then
		SendChatMessage( "[CTA] "..string.gsub( message, "|c(%w+)|H(%w+):(.+)|h(.+)|h|r", "%4" ), messageType, language, channel );
	else
		SendChatMessage( "<CTA> "..string.gsub( message, "|c(%w+)|H(%w+):(.+)|h(.+)|h|r", "%4" ), messageType, language, channel );
	end
end

--[[
	------------------------------------------------------------------------------------------------------------------------
	Group
	Usage:		CTA_Util.getGroupMemberInfo ( Index Number )
	Returns:	Name, Level, Class (of Player with Index Number's position in RaidRoster or Party)
	Usage:		CTA_Util.getNumGroupMembers()
	Returns:	Number of People in group or raid with player (1 if player is alone)
	------------------------------------------------------------------------------------------------------------------------
--]]

CTA_Util.getGroupMemberInfo = function( index ) -- NOT IN USE
	local name, rank, subgroup, level, class, fileName, zone, online, isDead;
	if ( IsRaidLeader() and GetNumRaidMembers() > 0 ) then
		name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(index);	
	elseif ( IsPartyLeader() and GetNumPartyMembers() > 0 ) then
		local target = CTA_PLAYER;
		if( index > 1 and index < 6 ) then
			target = "PARTY"..(index-1);
		end
		name = UnitName(target);
		level = UnitLevel(target);
		class = UnitClass(target);
	elseif( GetNumRaidMembers() == 0  and GetNumPartyMembers() == 0 and index == 1 ) then
		local target = CTA_PLAYER;
		name = UnitName(target);
		level = UnitLevel(target);
		class = UnitClass(target);
	end
	return name, level, class;
end

CTA_Util.getNumGroupMembers = function() -- NOT IN USE
	if( GetNumRaidMembers() > 0 ) then
		return GetNumRaidMembers();
	elseif( GetNumPartyMembers() > 0 ) then
		return GetNumPartyMembers() + 1;
	else
		return 1;
	end
end

--[[
	------------------------------------------------------------------------------------------------------------------------
	Table functions
	Usage:		CTA_Util.getn( List )
	Returns:	Number of Elements in List
	Usage:		CTA_Util.cloneTable( Table )
	Returns:	Copy of table by value
	------------------------------------------------------------------------------------------------------------------------
--]]

CTA_Util.getn = function( list ) -- NOT IN USE
	local c = 0;
	for i, j in list do
		c = c + 1;
	end
	return c;
end

CTA_Util.cloneTable = function( t )
  return cloneTable( t );
end

--[[
	------------------------------------------------------------------------------------------------------------------------
	Class codec functions
	Usage:		CTA_Util.getClassCode( [Localized] Class Name )
	Returns:	Number encoding class specified by class name (1-8)
	Usage:		CTA_Util.getClassString( Number from 1-255 encoding a set of classes )
	Returns:	String with localized names of encoded classes separated by spaces
	------------------------------------------------------------------------------------------------------------------------
--]]

CTA_Util.getClassCode = function( className )
	return CTA_Classes[className].id;
end

CTA_Util.getClassString = function( classSet )
	local b = "";
	local c = classSet;
	
	while( c > 0 ) do
		local d = mod(c, 2);
		b = d..b;
		c = floor(c/2);
	end
	while(string.len(b) < 8 ) do
		b = "0"..b;
	end
	
	local pos = 8;
	local t = "";
	while( pos > 0 ) do
		if( string.sub(b, pos, pos) == "1" ) then 	
			t = t..CTA_Classes[ CTA_Classes[9-pos] ].localName.." ";
		end
		pos = pos - 1;
	end
	return t;
end

--[[
	------------------------------------------------------------------------------------------------------------------------
	Player information retrieval
	Usage: 		CTA_Util.getWhoInfo( Player Name )
	Returns: 	Name, Guild, Level, Race, Class, Zone, Group
	Comment:	May need restructuring to allow less obsessive use of /who
	------------------------------------------------------------------------------------------------------------------------
--]]
CTA_Util.getWhoInfo = function( playerName )
	local numWhos, totalCount = GetNumWhoResults();
	local name, guild, level, race, class, zone, group;
	for i=1, totalCount do
		name, guild, level, race, class, zone, group = GetWhoInfo(i);
		if( name == playerName ) then
			return name, guild, level, race, class, zone, group;
		end
	end
end



--[[
	------------------------------------------------------------------------------------------------------------------------
	Prefix and Suffix contents of CTA_TRIGGER_LIST with " " and convert them to lower case
	Usage:		CTA_ExpandStrings( Table, Length )
		Table:	Table filled with sub-tables and strings
		Length:	Length a string must have to skip the prefixing and suffixing
	Returns:	Modified table
	------------------------------------------------------------------------------------------------------------------------
--]]
function CTA_ExpandStrings(table, length)
	length = length or 5
	for index, content in table do
		if type(content) == "table" then
			table[index] = CTA_ExpandStrings(content, length)
		elseif type(content) == "string" then
			if string.len(content) < length then
				if string.sub(content, 1, 1) ~= " " then
					content = " " .. content
				end
				if string.sub(content, -1, -1) ~= " " then
					content = content .. " "
				end
				content = string.lower(content)
				table[index] = content
			end
		end
	end
	return table
end

CTA_TRIGGER_LIST = CTA_ExpandStrings(CTA_TRIGGER_LIST)


--[[
	------------------------------------------------------------------------------------------------------------------------
	Alignment function to score keyword hits
	Usage:		CTA_Util.align( String, Reference )
	Returns:	Score (0-100), Aligned String, Aligned Reference
	------------------------------------------------------------------------------------------------------------------------
--]]
CTA_Util.align = function (A, B)
	-- A : String
	-- B : Reference
	-- Sequence lengths:
	local m = string.len(A)
	local n = string.len(B)
	
	-- Initialize distance and trace matrices with Dimension (m+1)x(n+1)
	local D = {}
	local T = {}
	for i = 0, m  do
		D[i] = {}
		T[i] = {}
		for j = 0, n  do
			D[i][j] = 0
			T[i][j] = 0
		end
	end
	
	-- Dynamic programming: fill DP-Matrix
	local hiscore = {0, m, n}
	local d_horiz, d_diag, d_vert, d_swap  = 0, 0, 0, -100
	for i = 1, m do
		for j = 1, n do
			-- Calculate current characters and distances
			local a  = string.lower(string.sub(A, i, i))
			local ap = string.lower(string.sub(A, i-1, i-1))
			local b  = string.lower(string.sub(B, j, j))
			local bp = string.lower(string.sub(B, j-1, j-1))
			d_horiz = D[i-1][j]   + dist( a   , nil )
			d_diag  = D[i-1][j-1] + dist( a   , b   )
			d_vert  = D[i]  [j-1] + dist( nil , b   )
			if ap == b then
				if a == bp then					-- Swap
					d_swap = (match_score[a] or 1) + (match_score[b] or 1) + dist( nil , nil)
				elseif bp == "" then			-- Swap at first Reference letter
					d_swap = (match_score[b] or 1) + dist( nil , nil)	
				end
			elseif a == bp and ap == "" then 	-- Swap at first Message letter
				d_swap = (match_score[a] or 1) + dist( nil , nil)
			else								-- No swap
				d_swap = -100
			end
			
			-- Save max into distance matrix and save highscore position
			D[i][j] = math.max( 0 , d_diag , d_horiz , d_vert , d_swap)
			if hiscore[1] <= D[i][j] then
				hiscore = { D[i][j], i, j }
			end
			-- Save direction in traceback matrix
			if d_swap == D[i][j] then
				T[i-1][j-1] = 0
				T[i][j]     = 0
			elseif d_diag >= d_horiz and d_diag >= d_vert then
				T[i][j] =  0
			elseif d_horiz >= d_vert then
				T[i][j] = -1
			else
				T[i][j] =  1
			end
		end
	end
	
	-- Traceback from highscore position to upper or left edge
	local X = ""
	local Y = ""
	local i = hiscore[2]
	local j = hiscore[3]
	while i > 0 and j > 0 do
		if T[i][j] == 0 then   -- Diagonal: no Gaps
			X = string.sub(A, i, i) .. X
			Y = string.sub(B, j, j) .. Y
			i,j = i-1, j-1
		elseif T[i][j] == -1 then -- Left: Gap in B
	    	X = string.sub(A, i, i) .. X
	    	Y = "-" .. Y
	    	i = i - 1
		else              -- Up: Gap in A
			X = "-" .. X
			Y = string.sub(B, j, j) .. Y
			j = j -1
		end
	end
	
	X = string.sub(A, 0, i) .. X .. string.sub(A, hiscore[2] + 1)
	Y = string.sub(B, 0, j) .. Y .. string.sub(B, hiscore[3] + 1)
	X = string.rep(" ", j) .. X
	Y = string.rep(" ", i) .. Y

	-- Evaluate score relative to length of second parameter
	local scoremax = 0
	for i =  1, n do
		local s = string.lower(string.sub(B,i,i))
		scoremax = scoremax + (match_score[s] or 1 )
	end
	local score = 100 * hiscore[1] / scoremax
	
	-- Return score and alignment
	return score, X, Y
end


-- Distance function
dist = function(a, b)
	if not a then
		if not b then					-- Swap of a with b's predecessor and b with a's predecessor
			return -0.5				-- Swap cost recommendation (swap cost < mismatch cost < 2 * gap cost)
		else						-- deletion in A
			return -1
		end
	elseif not b then					-- Insertion into A
		return -1
	end
	if a == b then						-- Exact match
		return match_score[a] or 1
	else							-- Any Mismatch
		if string.find(a..b, "[%p%s][%p%s]") then	-- Whitespace & punctuation
			return 1
		else						-- Other mismatch
			return -1
		end
	end
end

-- Match score needs localization !!
match_score = {
	["e"] = 0.65, ["n"] = 0.80, ["i"] = 0.85, ["s"] = 0.85, ["r"] = 0.86, ["a"] = 0.87, 
	["t"] = 0.88, ["d"] = 0.90, ["h"] = 0.90, ["u"] = 0.91, ["l"] = 0.93, ["c"] = 0.94, 
	["g"] = 0.94, ["m"] = 0.95, ["o"] = 0.95, ["b"] = 0.96, ["w"] = 0.96, ["f"] = 0.97, 
	["k"] = 0.98, ["z"] = 0.98, ["p"] = 0.98, ["v"] = 0.99, ["j"] = 0.99, ["y"] = 1.00, 
	["x"] = 1.00, ["q"] = 1.00}





--[[
	------------------------------------------------------------------------------------------------------------------------
	DEVELOPMENT ONLY: Testing filters with test data (German only)
	Usage: 		CTA_Util.testRun(  )
	Returns: 	Name, Guild, Level, Race, Class, Zone, Group
	Comment:	May need restructuring to allow less obsessive use of /who
	------------------------------------------------------------------------------------------------------------------------
--]]
CTA_Util.testRun = function ( start, stop )
	if( not CTA_SavedVariables.lfmTrigger or strlen( CTA_SavedVariables.lfmTrigger ) < 3 ) then return; end
	
	start = start or 1
	stop = stop or table.getn(data_to_parse)
	
	local itemsdone		= 0
	local itemsadded	= 0
	local itemsfiltered	= 0
	local itemsfp		= 0
	local itemsfn		= 0
	
	CTA_Util.logPrintln( "Test-run startet from "..start.." to "..stop..".")
		
	for i = start, stop do -- FOR LOOP TO ADD DATA
			
		if data_to_parse[i] then
			message = data_to_parse[i]
		else
			break
		end
		
		local author = string.sub(message[1], 1, string.find(message[1], ": ")-1);
		local msg = string.sub(message[1], string.find(message[1], ": ")+1) .. " ";
		
-- Filter by keywords ----->
		
		local score, searchtype = CTA_Util.rateResults(msg)
		
-- <----- Filter by keywords
		
		if( score > 0 ) then
			
			-- Generate HHMM timestamp
			local tim, minute = GetGameTime();
			if( tim < 10 ) then tim = "0"..tim; end
			if( minute < 10 ) then tim = tim.."0"; end
			tim = tim..minute;	
		
			-- CTA_Util.logPrintln( "Picked up lfx msg from "..author.."."); -- R10
			-- /R7
		
			
			local whoData = nil;
			for i = 1, getn( CTA_CtaMessageList ) do
				local name = CTA_CtaMessageList[i].op or "?";
				if( name == author ) then -- TEST
					whoData = CTA_CtaMessageList[i].who;
					-- table.remove( CTA_CtaMessageList , i );
					break;
				end
			end
			
			--[[
			if CTA_CtaMessageList and CTA_CtaMessageList[1] then
				if not whoData then
					whodata = CTA_CtaMessageList[1].who
				end
			end
			--]]
		
			local entry = {};
			entry.ctaType = searchtype;
			entry.author = "Cantoria";
			entry.message = msg;
			entry.time = tim;
			entry.options = "x";
			entry.who = whoData;
					
			entry.op = author;
			

			table.insert( CTA_CtaMessageList, 1, entry );
			CTA_PollApplyFilters = 1;
			
			itemsadded = itemsadded + 1
			
			if message[2] == nil then
				CTA_Util.logPrintln( "False Positive : "..msg)
				itemsfp = itemsfp + 1
			end
			
		else
			if message[2] == true then
				CTA_Util.logPrintln( "False Negative : "..msg)
				itemsfn = itemsfn + 1
			end
			itemsfiltered = itemsfiltered + 1
		end -- if score > 0
		itemsdone = itemsdone + 1
	end -- FOR
	CTA_Util.logPrintln( "Parsed: "..itemsdone.." items.")
	CTA_Util.logPrintln( "Accepted: "..itemsadded.." items.")
	CTA_Util.logPrintln( "False Positives: "..itemsfp.." items.")
	CTA_Util.logPrintln( "Filtered: "..itemsfiltered.." items.")
	CTA_Util.logPrintln( "False Negatives: "..itemsfn.." items.")
end -- Function


--[[ Fallback original function
CTA_Util.rateResults = function ( msg )
	local type = "C"
	local score = CTA_Util.search( msg, CTA_SavedVariables.lfmTrigger );
	if( score == 0 ) then
		score = CTA_Util.search( msg, CTA_SavedVariables.lfgTrigger );
		type = "D"
	end
	return type , score
end -- Function CTA_Util.rateResults
-- Fallback original function ]]


-- New version
--[[
 	R11B1, Sacha: Original R10E CTA_Util.rateResults, 
	R11B1 CTA_Util.rateResults has a few changes to allow different levels of filtering.
--]]
--[[
CTA_Util.rateResults = function ( msg )
	
	local searchtype = "D"	-- Default to LFG if no other pointers found
	local lfx_score = 0
	local goal_score = 0
	local class_score = 0
	local spam_score = 0
	local level_score = 0
	local found = "" -- DEBUG

	-- Convert message to lower case and turn all punctuation to whitespace
	msg = " "..msg.." "
	local msgnew = string.lower(msg)
	msgnew = string.gsub(msgnew, "\195\150", "\195\182")
	msgnew = string.gsub(msgnew, "\195\132", "\195\164")
	msgnew = string.gsub(msgnew, "\195\156", "\195\188")
	msgnew = string.gsub(msgnew, "[%p%s´`]", " ")
	
	
	----->> LFX TRIGGERS <<-----
	scorenew = 0
	
	for _ , word in CTA_TRIGGER_LIST.LFM do
		if string.find(msgnew, word) then
			lfx_score = lfx_score + 1
			searchtype = "C"
			found = found .. " " ..word -- DEBUG
		end
	end

	for _ , word in CTA_TRIGGER_LIST.LFG do
		if string.find(msgnew, word) then
			lfx_score = lfx_score +1
			found = found .. " " ..word -- DEBUG
		end
	end
	
		
	----->> INSTANCE TRIGGERS <<-----
	for word in string.gfind(msg, "%[%d+[+D]?]") do
    		goal_score = goal_score +1
    		lfx_score = lfx_score + 1
  	end
	for _ , instance in CTA_TRIGGER_LIST.GOAL do
		for _ , word in instance do
			if string.find(msgnew, word) then
				goal_score = goal_score + 1
				found = found .. " " ..word -- DEBUG
			end
		end
	end
	for _ , instance in CTA_TRIGGER_LIST.ZONE do
		for _ , word in instance do
			if string.find(msgnew, word) then
				goal_score = goal_score + 1
				found = found .. " " ..word -- DEBUG
			end
		end
	end
	

	----->> CLASS TRIGGERS <<-----
	for _ , class in CTA_TRIGGER_LIST.CLASSES do
		for _ , word in class do
				if string.find(msgnew, word) then
					class_score = class_score + 1
					found = found .. " " ..word -- DEBUG
			end
		end
	end

	
	----->> SPAM TRIGGERS <<-----
	for _ , word in CTA_TRIGGER_LIST.SPAM do
		if string.find(msgnew, word) then
			spam_score = spam_score + 1
			found = found .. " " ..word -- DEBUG
		end
	end
	
	----->> LEVEL TRIGGERS <<-----
	for word in string.gfind(msgnew, "[^%d]%d%d[^%d]") do
		word = string.sub(word, 2, 3) + 0
		if word >= 10 and word <= 60 then
			level_score = level_score +1
		end
  	end
	
	--Print("L: ".. lfx_score .." G: ".. goal_score .." C: ".. class_score .." S: ".. spam_score .. " : ".. level_score .. " : ".. found) -- DEBUG
	
	local msg_ok = 0
	if lfx_score > 0 and class_score > 0 and level_score > 0 and searchtype == "D" then msg_ok = 1 end
	if goal_score > 0 and lfx_score > 0 						then msg_ok = 2 end
	if lfx_score > 0 and goal_score > 0 and class_score > 1 	then msg_ok = 3 end
	if spam_score > 0 											then msg_ok = 0 end
	
	if msg_ok < 2 and ( goal_score > 0 or lfx_score > 0 ) and spam_score == 0 then
		-- INSERT FUZZY SEARCH HERE!
	end
	
	if msg_ok == 0 and CTA_FilterChatCheckButton:GetChecked() then -- DEBUG
		CTA_Util.logPrintln("Filtered message: ".. msg, "R")
		CTA_Util.logPrintln("L: ".. lfx_score .." G: ".. goal_score .." C: ".. class_score .." S: ".. spam_score .. " : ".. level_score .. " : ".. found, "R")
		if CTA_SavedVariables.FilteredMessages then
			table.insert(CTA_SavedVariables.FilteredMessages, "L: ".. lfx_score .." G: ".. goal_score .." C: ".. class_score .." S: ".. spam_score .. " : ".. level_score .. " : ".. found .." --> ".. msg)
			if table.getn(CTA_SavedVariables.FilteredMessages) > 199 then
				local newtable = {}
				for i = 1, 100 do
					newtable[i] = CTA_SavedVariables.FilteredMessages[i+100]
				end
				CTA_SavedVariables.FilteredMessages = newtable
			end
		end
	end
	
	
	return msg_ok, searchtype
end -- Function CTA_Util.rateResults
--]]

-- R11B1 Version
--[[+
	CTA_Util.rateResults(  msg, fLevel ) 
	Filters a message and returns a rating for the message.
		
	@arg msg - the message to be filtered
	@arg fLevel - the level of the filter's aggressiveness (1-5)
	@return rating (0 if fail, 1 if passed), type ("C" or "D" )
	@Notes
	R10E: Initial, Eike
	R11: small changes for different levels of filtering, Sacha
--]]
--[[
CTA_Util.rateResults = function ( msg, fLevel )
	
	local searchtype = "D"	-- Default to LFG if no other pointers found
	local filterLevel = fLevel or 5;
	
	-- Convert message to lower case and turn all punctuation to whitespace
	msg = " "..msg.." "
	local msgnew = string.lower(msg)
	msgnew = string.gsub(msgnew, "\195\150", "\195\182")
	msgnew = string.gsub(msgnew, "\195\132", "\195\164")
	msgnew = string.gsub(msgnew, "\195\156", "\195\188")
	msgnew = string.gsub(msgnew, "[%p%s´`]", " ")	
	local found = "" -- DEBUG
	
	local lfx_score = 0
	local goal_score = 0
	local class_score = 0
	local spam_score = 0
	local level_score = 0
	
	
	----->> SPAM TRIGGERS <<-----
	if filterLevel > 1 then
		for _ , word in CTA_TRIGGER_LIST.SPAM do
			if string.find(msgnew, word) then
				spam_score = spam_score + 1
				found = found .. " " ..word -- DEBUG
			end
		end
		if( spam_score > 0 ) then  -- Immediately return upon finding Spam and filtering is above 1
			CTA_Util.logPrintln("Filtered message: ".. msg, "R")
			return 0
		end
	end


	----->> LFX TRIGGERS <<-----
	
	for _ , word in CTA_TRIGGER_LIST.LFM do
		if string.find(msgnew, word) then
			lfx_score = lfx_score + 1
			searchtype = "C"
			found = found .. " " ..word -- DEBUG
		end
	end
	
	for _ , word in CTA_TRIGGER_LIST.LFG do
		if string.find(msgnew, word) then
			lfx_score = lfx_score +1
			found = found .. " " ..word -- DEBUG
		end
	end
	
	if( filterLevel == 1 ) then -- Sacha: Level 1 - No filtering
		return 1, searchtype;
	end
	
	if( filterLevel == 2 ) then -- Sacha: Level 2 - No spam only
		if( spam_score == 0 ) then
			return 1, searchtype;
		else
			CTA_Util.logPrintln("Filtered message: ".. msg, "R")
			return 0;
		end
	end
			
	if( filterLevel == 3 ) then -- Sacha: Level 3 - No spam, >=1 Lfx only
		if( spam_score == 0 and lfx_score > 0 ) then
			return 1, searchtype;
		else
			CTA_Util.logPrintln("Filtered message: ".. msg, "R")
			return 0;
		end
	end
	
	----->> INSTANCE TRIGGERS <<-----
	for word in string.gfind(msg, "%[%d+[+D]?]") do
    		goal_score = goal_score +1
    		lfx_score = lfx_score + 1
  	end
	for _ , instance in CTA_TRIGGER_LIST.GOAL do
		for _ , word in instance do
			if string.find(msgnew, word) then
				goal_score = goal_score + 1
				found = found .. " " ..word -- DEBUG
			end
		end
	end
	for _ , instance in CTA_TRIGGER_LIST.ZONE do
		for _ , word in instance do
			if string.find(msgnew, word) then
				goal_score = goal_score + 1
				found = found .. " " ..word -- DEBUG
			end
		end
	end
	

	----->> CLASS TRIGGERS <<-----
	for _ , class in CTA_TRIGGER_LIST.CLASSES do
		for _ , word in class do
				if string.find(msgnew, word) then
					class_score = class_score + 1
					found = found .. " " ..word -- DEBUG
			end
		end
	end

		
	----->> LEVEL TRIGGERS <<-----
	for word in string.gfind(msgnew, "[^%d]%d%d[^%d]") do
		word = string.sub(word, 2, 3) + 0
		if word >= 10 and word <= 60 then
			level_score = level_score +1
		end
  	end
	
	if( filterLevel == 4 ) then -- Sacha: Level 4 - No spam, >=1 Lfx, and >=1 ( Instance or CLass or Level ) only
		if( spam_score == 0 and lfx_score > 0 and ( goal_score > 0 or class_score > 0 or level_score > 0 ) ) then
			return 1, searchtype;
		else
			CTA_Util.logPrintln("Filtered message: ".. msg, "R")
			return 0;
		end
	end

	--Print("L: ".. lfx_score .." G: ".. goal_score .." C: ".. class_score .." S: ".. spam_score .. " : ".. level_score .. " : ".. found) -- DEBUG
	
	local msg_ok = 0
	if lfx_score > 0 and class_score > 0 and level_score > 0 and searchtype == "D" then msg_ok = 1 end
	if goal_score > 0 and lfx_score > 0 						then msg_ok = 2 end
	if lfx_score > 0 and goal_score > 0 and class_score > 1 	then msg_ok = 3 end
	if spam_score > 0 											then msg_ok = 0 end
	
	if msg_ok < 2 and ( goal_score > 0 or lfx_score > 0 ) and spam_score == 0 then
		-- INSERT FUZZY SEARCH HERE!
	end
	
	if msg_ok == 0 then -- DEBUG
		CTA_Util.logPrintln("Filtered message: ".. msg, "R")
		--CTA_Util.logPrintln("L: ".. lfx_score .." G: ".. goal_score .." C: ".. class_score .." S: ".. spam_score .. " : ".. level_score .. " : ".. found, "R")
		--[[
		if CTA_SavedVariables.FilteredMessages then
			.insert(CTA_SavedVariables.FilteredMessages, "L: ".. lfx_score .." G: ".. goal_score .." C: ".. class_score .." S: ".. spam_score .. " : ".. level_score .. " : ".. found .." --> ".. msg)
			if table.getn(CTA_SavedVariables.FilteredMessages) > 199 then:
				local newtable = {}
				for i = 1, 100 do
					newtable[i] = CTA_SavedVariables.FilteredMessages[i+100]
				end
				CTA_SavedVariables.FilteredMessages = newtable
			end
		end
		--]]
	end
	
	
	return msg_ok, searchtype
end -- Function CTA_Util.rateResults
--]]

-- R11b2
CTA_Util.rateResults = function ( msg, fLevel )
	
	local searchtype = "C"	-- Default to LFM if no other pointers found
	local filterLevel = fLevel or 5;
	
	-- Convert message to lower case and turn all punctuation to whitespace
	msg = " "..msg.." "
	local msgnew = string.lower(msg)
	msgnew = string.gsub(msgnew, "\195\150", "\195\182")
	msgnew = string.gsub(msgnew, "\195\132", "\195\164")
	msgnew = string.gsub(msgnew, "\195\156", "\195\188")
	msgnew = string.gsub(msgnew, "[%p%s´`]", " ")	
	local found = "" -- DEBUG
	
	local lfx_score = 0
	local goal_score = 0
	local class_score = 0
	local spam_score = 0
	local level_score = 0
	
	
	----->> SPAM TRIGGERS <<-----
	if filterLevel > 1 then
		for _ , word in CTA_TRIGGER_LIST.SPAM do
			if string.find(msgnew, word) then
				spam_score = spam_score + 1
				found = found .. " " ..word -- DEBUG
			end
		end
		if( spam_score > 0 ) then  -- Immediately return upon finding Spam and filtering is above 1
			--CTA_Util.logPrintln("Filtered message: ".. msg, "R")
			return 0, "S";
		end
	end

	local slfx_score = 0
	local sgoal_score = 0
	local sclass_score = 0

	----->> LFX TRIGGERS <<-----
	
	for _ , word in CTA_TRIGGER_LIST.LFM do
		if string.find(msgnew, word) then
			lfx_score = lfx_score + 1
			found = found .. " " ..word -- DEBUG
			searchtype = "C";
			slfx_score = 1; 
		end
	end
	
	for _ , word in CTA_TRIGGER_LIST.LFG do
		if string.find(msgnew, word) then
			lfx_score = lfx_score +1
			slfx_score = 1; 
			searchtype = "D"
			found = found .. " " ..word -- DEBUG
		end
	end
	
	if( filterLevel == 1 ) then -- Sacha: Level 1 - No filtering
		return 1, searchtype;
	end
	
	if( filterLevel == 2 ) then -- Sacha: Level 2 - No spam only
		if( spam_score == 0 ) then
			return 1, searchtype;
		else
			--CTA_Util.logPrintln( CTA_Util.formatChatMessage(  ) );
			return 0, searchtype;
		end
	end
	
	----->> INSTANCE TRIGGERS <<-----
	for word in string.gfind(msg, "%[%d+[+D]?]") do
    		goal_score = goal_score +1
    		lfx_score = lfx_score + 1
  	end
	for _ , instance in CTA_TRIGGER_LIST.GOAL do
		for _ , word in instance do
			if string.find(msgnew, word) then
				goal_score = goal_score + 1
				found = found .. " " ..word -- DEBUG
				sgoal_score = 1;
			end
		end
	end
	for _ , instance in CTA_TRIGGER_LIST.ZONE do
		for _ , word in instance do
			if string.find(msgnew, word) then
				goal_score = goal_score + 1
				found = found .. " " ..word -- DEBUG
				sgoal_score = 1;
			end
		end
	end
	

	----->> CLASS TRIGGERS <<-----
	for _ , class in CTA_TRIGGER_LIST.CLASSES do
		for _ , word in class do
				if string.find(msgnew, word) then
					class_score = class_score + 1
					found = found .. " " ..word -- DEBUG
					sclass_score = 1;
			end
		end
	end

		
	----->> LEVEL TRIGGERS <<-----
	for word in string.gfind(msgnew, "[^%d]%d%d[^%d]") do
		word = string.sub(word, 2, 3) + 0
		if word >= 10 and word <= 60 then
			level_score = level_score +1
		end
  	end
	
	if( filterLevel == 3 ) then 
		if( spam_score == 0 and slfx_score + sgoal_score + class_score >= 1  ) then
			return 1, searchtype;
		else
			--CTA_Util.logPrintln("Filtered message: ".. msg, "R")
			return 0, searchType;
		end
	elseif( filterLevel == 4 ) then 
		if( spam_score == 0 and slfx_score + sgoal_score + sclass_score >= 2  ) then
			return 1, searchtype;
		else
			--CTA_Util.logPrintln("Filtered message: ".. msg, "R")
			return 0, searchType;
		end
	else 
		if( spam_score == 0 and slfx_score + sgoal_score + sclass_score >= 3  ) then
			return 1, searchtype;
		else
			--CTA_Util.logPrintln("Filtered message: ".. msg, "R")
			return 0, searchType;
		end
	end
	
	-- this line should never execute:
	CTA_Util.chatPrintln( "Huh? how did this happen?" );

end 