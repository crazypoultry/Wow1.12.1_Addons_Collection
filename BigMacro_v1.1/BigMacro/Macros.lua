BM_MACROS = {

--Every line of your macro should be in double-brackets and separated by commas.
--Like this: [[/command blah blah blah]],
--Add as many lines as you like to your macro.

-- To cast spells, use the following command:
--		/script BM_CastSpellByName("Spell Name", "Rank #")
-- Example:	/script BM_CastSpellByName("Frost Armor", "Rank 1")
-- If no rank number is given, then this will cast the highest-ranking spell with that name.
-- This will be much more reliable than using "/cast" or "/script CastSpellByName". You've been warned!

-- To call other macros, use "/bm 1" through "/bm 30".
-- To call other macros from within a /script, use: BigMacro_Execute("macro01") through BigMacro_Execute("macro30")

	---------------------------
	--ALL CHARACTERS
	--These macros will be used if your character's name isn't in the "Specific Characters" section (scroll down).
	---------------------------
	{CharacterName="ALL_OTHER_CHARACTERS", --Don't change this Character Name!!!
	ServerName="", --Leave this blank!
	macro01={
	[[/me executes macro 1]],
	[[]],
	[[]]},
	macro02={
	[[/me executes macro 2]],
	[[]],
	[[]]},
	macro03={
	[[/me executes macro 3]],
	[[]],
	[[]]},
	macro04={
	[[/me executes macro 4]],
	[[]],
	[[]]},
	macro05={
	[[/me executes macro 5]],
	[[]],
	[[]]},
	macro06={
	[[/me executes macro 6]],
	[[]],
	[[]]},
	macro07={
	[[/me executes macro 7]],
	[[]],
	[[]]},
	macro08={
	[[/me executes macro 8]],
	[[]],
	[[]]},
	macro09={
	[[/me executes macro 9]],
	[[]],
	[[]]},
	macro10={
	[[/me executes macro 10]],
	[[]],
	[[]]},
	macro11={
	[[/me executes macro 11]],
	[[]],
	[[]]},
	macro12={
	[[/me executes macro 12]],
	[[]],
	[[]]},
	macro13={
	[[/me executes macro 13]],
	[[]],
	[[]]},
	macro14={
	[[/me executes macro 14]],
	[[]],
	[[]]},
	macro15={
	[[/me executes macro 15]],
	[[]],
	[[]]},
	macro16={
	[[/me executes macro 16]],
	[[]],
	[[]]},
	macro17={
	[[/me executes macro 17]],
	[[]],
	[[]]},
	macro18={
	[[/me executes macro 18]],
	[[]],
	[[]]},
	macro19={
	[[/me executes macro 19]],
	[[]],
	[[]]},
	macro20={
	[[/me executes macro 20]],
	[[]],
	[[]]},
	macro21={
	[[/me executes macro 21]],
	[[]],
	[[]]},
	macro22={
	[[/me executes macro 22]],
	[[]],
	[[]]},
	macro23={
	[[/me executes macro 23]],
	[[]],
	[[]]},
	macro24={
	[[/me executes macro 24]],
	[[]],
	[[]]},
	macro25={
	[[/me executes macro 25]],
	[[]],
	[[]]},
	macro26={
	[[/me executes macro 26]],
	[[]],
	[[]]},
	macro27={
	[[/me executes macro 27]],
	[[]],
	[[]]},
	macro28={
	[[/me executes macro 28]],
	[[]],
	[[]]},
	macro29={
	[[/me executes macro 29]],
	[[]],
	[[]]},
	macro30={
	[[/me executes macro 30]],
	[[]],
	[[]]}},
	
	---------------------------
	--SPECIFIC CHARACTERS
	--Add macros here that you want to be available to specific characters
	---------------------------
	{CharacterName="YOUR_CHARACTER_NAME_HERE", --Change this to your character's name
	ServerName="", --Leave this blank unless you use the same character name on more than one server
	macro01={
	[[/me executes a macro 1]],
	[[]],
	[[]],
	[[]]},
	macro02={
	[[/me executes macro 2]],
	[[]],
	[[]]},
	macro03={
	[[/me executes macro 3]],
	[[]],
	[[]]},
	macro04={
	[[/me executes macro 4]],
	[[]],
	[[]]},
	macro05={
	[[/me executes macro 5]],
	[[]],
	[[]]},
	macro06={
	[[/me executes macro 6]],
	[[]],
	[[]]},
	macro07={
	[[/me executes macro 7]],
	[[]],
	[[]]},
	macro08={
	[[/me executes macro 8]],
	[[]],
	[[]]},
	macro09={
	[[/me executes macro 9]],
	[[]],
	[[]]},
	macro10={
	[[/me executes macro 10]],
	[[]],
	[[]]},
	macro11={
	[[/me executes macro 11]],
	[[]],
	[[]]},
	macro12={
	[[/me executes macro 12]],
	[[]],
	[[]]},
	macro13={
	[[/me executes macro 13]],
	[[]],
	[[]]},
	macro14={
	[[/me executes macro 14]],
	[[]],
	[[]]},
	macro15={
	[[/me executes macro 15]],
	[[]],
	[[]]},	
	macro16={
	[[/me executes macro 16]],
	[[]],
	[[]]},
	macro17={
	[[/me executes macro 17]],
	[[]],
	[[]]},
	macro18={
	[[/me executes macro 18]],
	[[]],
	[[]]},
	macro19={
	[[/me executes macro 19]],
	[[]],
	[[]]},
	macro20={
	[[/me executes macro 20]],
	[[]],
	[[]]},
	macro21={
	[[/me executes macro 21]],
	[[]],
	[[]]},
	macro22={
	[[/me executes macro 22]],
	[[]],
	[[]]},
	macro23={
	[[/me executes macro 23]],
	[[]],
	[[]]},
	macro24={
	[[/me executes macro 24]],
	[[]],
	[[]]},
	macro25={
	[[/me executes macro 25]],
	[[]],
	[[]]},
	macro26={
	[[/me executes macro 26]],
	[[]],
	[[]]},
	macro27={
	[[/me executes macro 27]],
	[[]],
	[[]]},
	macro28={
	[[/me executes macro 28]],
	[[]],
	[[]]},
	macro29={
	[[/me executes macro 29]],
	[[]],
	[[]]},
	macro30={
	[[/me executes macro 30]],
	[[]],
	[[]]}},
	
	{CharacterName="ANOTHER_CHARACTER_NAME_HERE", --Change this to another character's name.
	ServerName="", --Leave this blank unless you use the same character name on more than one server
	macro01={[[]]},
	macro02={[[]]},
	macro03={[[]]},
	macro04={[[]]},
	macro05={[[]]},
	macro06={[[]]},
	macro07={[[]]},
	macro08={[[]]},
	macro09={[[]]},
	macro10={[[]]},
	macro11={[[]]},
	macro12={[[]]},
	macro13={[[]]},
	macro14={[[]]},
	macro15={[[]]},
	macro16={[[]]},
	macro17={[[]]},
	macro18={[[]]},
	macro19={[[]]},
	macro20={[[]]},
	macro21={[[]]},
	macro22={[[]]},
	macro23={[[]]},
	macro24={[[]]},
	macro25={[[]]},
	macro26={[[]]},
	macro27={[[]]},
	macro28={[[]]},
	macro29={[[]]},
	macro30={[[]]}},

	{CharacterName="ANOTHER_CHARACTER_NAME_HERE", --Change this to another character's name.
	ServerName="", --Leave this blank unless you use the same character name on more than one server
	macro01={[[]]},
	macro02={[[]]},
	macro03={[[]]},
	macro04={[[]]},
	macro05={[[]]},
	macro06={[[]]},
	macro07={[[]]},
	macro08={[[]]},
	macro09={[[]]},
	macro10={[[]]},
	macro11={[[]]},
	macro12={[[]]},
	macro13={[[]]},
	macro14={[[]]},
	macro15={[[]]},
	macro16={[[]]},
	macro17={[[]]},
	macro18={[[]]},
	macro19={[[]]},
	macro20={[[]]},
	macro21={[[]]},
	macro22={[[]]},
	macro23={[[]]},
	macro24={[[]]},
	macro25={[[]]},
	macro26={[[]]},
	macro27={[[]]},
	macro28={[[]]},
	macro29={[[]]},
	macro30={[[]]}},

};