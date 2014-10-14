-- BigMacro by Jooky.
-- Download the latest version at:
-- http://www.curse-gaming.com/mod.php?addid=381

-- Initialize variables
BM_NameRegistered = 0;
BM_Echo = 0;
BM_SpellIDs = {};
BM_BestSpellIDs = {};

-- OnLoad, register for events to see if the game feels like giving us the player's name
function BigMacro_OnLoad()
	--Create slash commands
	SLASH_BIGMACRO1							= "/bigmacro";
	SLASH_BIGMACRO2							= "/bm";
	SlashCmdList["BIGMACRO"] = function(msg)
		BigMacro_SlashHandler(msg);
	end
	
	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("SPELLS_CHANGED");
	DEFAULT_CHAT_FRAME:AddMessage(BM_LOADED_MESSAGE,1.0,1.0,0.0);
end

function BigMacro_OnEvent(event)
	if (event=="UNIT_NAME_UPDATE") or (event=="PLAYER_ENTERING_WORLD") then
		local playerName = UnitName("player");
		if ((playerName == nil) or (playerName == UNKNOWNOBJECT) or (playerName == UNKNOWNBEING)) then
			BM_NameRegistered = 0;
			return;
		end
		if (BM_NameRegistered == 1) then
			return;
		end
		BM_NameRegistered = 1;
		BigMacro_LoadSpellIds();
		return;
	end
	local playerName = UnitName("player");
	if ((playerName == nil) or (playerName == UNKNOWNOBJECT) or (playerName == UNKNOWNBEING)) then
		BM_NameRegistered = 0;
		return;
	end
	if (event=="SPELLS_CHANGED") then
		BigMacro_LoadSpellIds();
		return;
	end
end

function BigMacro_SlashHandler(msg)
	--Convert empty msg to string
	if (msg==nil) then
		msg = "";
	end
	--Strip leading and trailing spaces
	while (string.sub(msg,1,1)==" ") do
		msg = string.sub(msg,2);
	end
	while (string.sub(msg,-1,-1)==" ") do
		msg = string.sub(msg,-2);
	end
	--If msg is a number, then make sure it's between 1 and 10, inclusive.  Execute that numbered macro.
	if (tonumber(msg)) then
		if (tonumber(msg) >= 1) and (tonumber(msg) <= 30) then
			if (tonumber(msg) < 10) then
				msg="0"..msg;
			end
			BigMacro_Execute("macro"..msg);
			return;
		end
		DEFAULT_CHAT_FRAME:AddMessage(BM_USAGE_MESSAGE,1.0,0.5,0.0);
		return;
	end
	if (string.lower(msg)==string.lower(BM_ECHO_ON_COMMAND)) then
		BM_Echo = 1;
		DEFAULT_CHAT_FRAME:AddMessage(BM_ECHO_ON_MESSAGE,1.0,1.0,0.0);
		return;
	elseif (string.lower(msg)==string.lower(BM_ECHO_OFF_COMMAND)) then
		BM_Echo = 0;
		DEFAULT_CHAT_FRAME:AddMessage(BM_ECHO_OFF_MESSAGE,1.0,1.0,0.0);
		return;
	end
	for i=1,table.getn(BM_HELP_MESSAGE) do
		DEFAULT_CHAT_FRAME:AddMessage(BM_HELP_MESSAGE[i],1.0,1.0,0.0);
	end
end

function BigMacro_Execute(whatMacro)
	if (BM_NameRegistered==0) then
		return;
	end
	local playerName = string.lower(UnitName("player"));
	local serverName = string.lower(GetCVar("realmName"));
	--Look for current player in list.  If found, then execute macro for that player.
	for i=1,table.getn(BM_MACROS) do
		if (playerName==string.lower(BM_MACROS[i].CharacterName)) then
			local thisServerName = BM_MACROS[i].ServerName;
			if (thisServerName==nil) then
				thisServerName = "";
			end
			thisServerName = string.lower(thisServerName);
			if ((thisServerName==serverName) or (thisServerName=="")) then
				BigMacro_Exec_Macro(i,whatMacro);
				return;
			end
		end
	end
	--If player isn't found, then execute macro for ALL_OTHER_CHARACTERS
	local playerName = string.lower("ALL_OTHER_CHARACTERS");
		for i=1,table.getn(BM_MACROS) do
		if (playerName==string.lower(BM_MACROS[i].CharacterName)) then
			BigMacro_Exec_Macro(i,whatMacro);
			return;
		end
	end
end

function BigMacro_Exec_Macro(playerIndex,whatMacro)
	local thisCommandList = BM_MACROS[playerIndex][whatMacro];
	for i=1,table.getn(thisCommandList) do
		local thisCommand = thisCommandList[i]
		if (thisCommand==nil) then
			thisCommand = "";
		end
		if (BM_Echo==1) then
			-- Display the slash-command for the user
			DEFAULT_CHAT_FRAME:AddMessage(thisCommand);
		end
		-- parse the command string to see if it contains any spell-casting commands
		-- if it does, then get the spell name and the spell rank
		local spellName,spellRank = BigMacro_GetSpellAndRank(thisCommand);
		if (spellName == nil) then
			BigMacro_Exec_Command(thisCommand);
		else
			BM_CastSpellByName(spellName, spellRank);
		end
	end
	return;
end

function BigMacro_Exec_Command(whatCommand)
	-- If user uses a /script command, then let's send that straight to the RunScript function.  This accomplishes two things:
	-- 1. It's faster.
	-- 2. It breaks the 256 character barrier for a single line.
	if (string.lower(string.sub(whatCommand,1,string.len(BM_SCRIPT_COMMAND))) == string.lower(BM_SCRIPT_COMMAND)) then
		local thisScript = string.sub(whatCommand,string.len(BM_SCRIPT_COMMAND)+1);
		-- check if user has ChatAlias installed.  If so, then parse for aliases.  Otherwise, just execute the command.
		if (CA_ParseMessage ~= nil) then
			thisScript=CA_ParseMessage(thisScript);
		end
		RunScript(thisScript);
		return;
	end
	BM_EditBox:SetText(whatCommand);
	local editBox = BM_EditBox;
	-- Send the slash command to the chat box (yep, it's basically typing it for you and pressing enter... cool, huh?)
	ChatEdit_SendText(editBox);
	return;
end

-- Users should call this function instead of CastSpellByName or /cast if they want reliable results
function BM_CastSpellByName(spellName, spellRank)
	--BM_SpellIDs[spell_name .. ":" .. spell_rank] = { id = i, name = spell_name, rank = spell_rank }
	--BM_BestSpellIDs[spell_name] = { id = i, name = spell_name, rank = spell_rank }
	if (table.getn(BM_BestSpellIDs)==0) or (table.getn(BM_SpellIDs)==0) then
		return;
	end
	if (spellRank == nil) then
		spellRank = BM_BestSpellIDs[spellName].rank;
	end
	local spellIndex = BM_SpellIDs[spellName..":"..spellRank].id;
	CastSpell( spellIndex, SpellBookFrame.bookType );
end

--Swiped from Danboo's CastParty addon
--This function stores the player's spells and id's for later use,
--thus eliminating the need to search the spellbook everytime the user casts a spell
function BigMacro_LoadSpellIds()
	local i = 1
	while true do
		local spell_name, spell_rank = GetSpellName(i, SpellBookFrame.bookType)
		if not spell_name then
			break;
		end
		BM_SpellIDs[spell_name .. ":" .. spell_rank] = { id = i, name = spell_name, rank = spell_rank }
		BM_BestSpellIDs[spell_name] = { id = i, name = spell_name, rank = spell_rank }
		i = i + 1
	end
	--Xyzlor's fix to the getn problem
	table.setn(BM_SpellIDs, i);
	table.setn(BM_BestSpellIDs, i); 
end

-- The following mess is a super-kludge to hide the fact that /cast and CastSpellByName don't work from an addon...
-- If I see "/cast" or "/script CastSpellByName" then I parse the string to separate spell name and spell rank.
-- If you are reading my code for ideas or assistance, then ignore this function completely.  It is hideous to look upon.
function BigMacro_GetSpellAndRank(commandString)
	local castCommandFound = 0;
	-- Remove leading and trailing spaces from commandString
	while (string.sub(commandString,-1,-1) == " ") do
		commandString = string.sub(commandString,1,-2);
	end
	while (string.sub(commandString,1,1) == " ") do
		commandString = string.sub(commandString,2,-1);
	end
	--Check for "/cast"
	if (string.lower(string.sub(commandString, 1, string.len(BM_CAST_COMMAND))) == string.lower(BM_CAST_COMMAND)) then
		castCommandFound = 1;
		-- Remove "/cast"
		commandString = string.sub(commandString, string.len(BM_CAST_COMMAND)+2);
		-- Check for leading quote and remove it
		if (string.sub(commandString,1,1)=="\"") then
			commandString = string.sub(commandString,2);
		end
		-- Check for trailing quote and remove it
		if (string.sub(commandString,string.len(commandString))=="\"") then
			commandString = string.sub(commandString,1,-2);
		end
		-- If all went well, then we should have a string in the form of "Spell Name(Rank #)" (with no quotes)
	end
	--Check for "/script CastSpellByName"
	if (string.lower(string.sub(commandString, 1, string.len(BM_SCRIPTCAST_COMMAND))) == string.lower(BM_SCRIPTCAST_COMMAND)) then
		castCommandFound = 1;
		-- Remove "/script CastSpellByName"
		commandString = string.sub(commandString, string.len(BM_SCRIPTCAST_COMMAND)+1);
		-- Remove semicolon if it exists
		if (string.sub(commandString,-1,-1) == ";") then
			commandString = string.sub(commandString,1,-2);
		end
		-- Check for leading paren and remove it
		if (string.sub(commandString,1,1)=="(") then
			commandString = string.sub(commandString,2);
		end
		-- Check for trailing paren and remove it
		if (string.sub(commandString,string.len(commandString))==")") then
			commandString = string.sub(commandString,1,-2);
		end
		-- Check for leading quote and remove it
		if (string.sub(commandString,1,1)=="\"") then
			commandString = string.sub(commandString,2);
		end
		-- Check for trailing quote and remove it
		if (string.sub(commandString,string.len(commandString))=="\"") then
			commandString = string.sub(commandString,1,-2);
		end
		-- If all went well, then we should have a string in the form of "Spell Name(Rank #)" (with no quotes)
	end
	-- If we didn't find a command to cast a spell, then return nil
	if (castCommandFound == 0) then
		return nil;
	end
	-- If we make it this far, then we should have a string in the form of "Spell Name(Rank #)" (with no quotes)
	-- Now we have to separate it into a spell name and a rank.
	-- First, get the location of the parentheses around "Rank #"
	local openParenIndex = string.find(commandString,"%(");
	local closeParenIndex = string.len(commandString);
	if (openParenIndex == nil) then
		DEFAULT_CHAT_FRAME:AddMessage(BM_CAST_NORANK_ERROR,1.0,0.0,0.0);
		return nil;
	end
	-- Now return everything between the parentheses (should be "Rank #")
	local spellRank = string.sub(commandString,openParenIndex+1,closeParenIndex-1);
	-- Remove leading or trailing spaces from rank
	while (string.sub(spellRank,-1,-1) == " ") do
		spellRank = string.sub(spellRank,1,-2);
	end
	while (string.sub(spellRank,1,1) == " ") do
		spellRank = string.sub(spellRank,2,-1);
	end
	-- Now return everything from the 1st character to the first parenthesis (should be "Spell Name")
	local spellName = string.sub(commandString,1,openParenIndex-1);
	-- Remove leading or trailing spaces from spell name
	while (string.sub(spellName,-1,-1) == " ") do
		spellName = string.sub(spellName,1,-2);
	end
	while (string.sub(spellName,1,1) == " ") do
		spellName = string.sub(spellName,2,-1);
	end
	return spellName, spellRank;
end