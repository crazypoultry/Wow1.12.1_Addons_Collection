BM_VERSION_MESSAGE			= "1.1";
BM_LOADED_MESSAGE			= "BigMacro v"..BM_VERSION_MESSAGE.." loaded.";

--Key bindings
BINDING_HEADER_BM_HEADER		= "BigMacro Macros";
BINDING_NAME_BM_MACRO1			= "Execute Macro 1";
BINDING_NAME_BM_MACRO2			= "Execute Macro 2";
BINDING_NAME_BM_MACRO3			= "Execute Macro 3";
BINDING_NAME_BM_MACRO4			= "Execute Macro 4";
BINDING_NAME_BM_MACRO5			= "Execute Macro 5";
BINDING_NAME_BM_MACRO6			= "Execute Macro 6";
BINDING_NAME_BM_MACRO7			= "Execute Macro 7";
BINDING_NAME_BM_MACRO8			= "Execute Macro 8";
BINDING_NAME_BM_MACRO9			= "Execute Macro 9";
BINDING_NAME_BM_MACRO10			= "Execute Macro 10";
BINDING_NAME_BM_MACRO11			= "Execute Macro 11";
BINDING_NAME_BM_MACRO12			= "Execute Macro 12";
BINDING_NAME_BM_MACRO13			= "Execute Macro 13";
BINDING_NAME_BM_MACRO14			= "Execute Macro 14";
BINDING_NAME_BM_MACRO15			= "Execute Macro 15";
BINDING_NAME_BM_MACRO16			= "Execute Macro 16";
BINDING_NAME_BM_MACRO17			= "Execute Macro 17";
BINDING_NAME_BM_MACRO18			= "Execute Macro 18";
BINDING_NAME_BM_MACRO19			= "Execute Macro 19";
BINDING_NAME_BM_MACRO20			= "Execute Macro 20";
BINDING_NAME_BM_MACRO21			= "Execute Macro 21";
BINDING_NAME_BM_MACRO22			= "Execute Macro 22";
BINDING_NAME_BM_MACRO23			= "Execute Macro 23";
BINDING_NAME_BM_MACRO24			= "Execute Macro 24";
BINDING_NAME_BM_MACRO25			= "Execute Macro 25";
BINDING_NAME_BM_MACRO26			= "Execute Macro 26";
BINDING_NAME_BM_MACRO27			= "Execute Macro 27";
BINDING_NAME_BM_MACRO28			= "Execute Macro 28";
BINDING_NAME_BM_MACRO29			= "Execute Macro 29";
BINDING_NAME_BM_MACRO30			= "Execute Macro 30";


BM_USAGE_MESSAGE			= "Usage: /bm 1  -thru-  /bm 30";
BM_ECHO_ON_COMMAND			= "echo on";
BM_ECHO_ON_MESSAGE			= "BigMacro will echo commands to the screen.";
BM_ECHO_OFF_COMMAND			= "echo off";
BM_ECHO_OFF_MESSAGE			= "BigMacro will not echo commands to the screen.";
BM_HELP_MESSAGE={
	"BigMacro Usage:",
	"---------------",
	"/bigmacro <command> or /bm <command>",
	"Commands:",
	"1 thru 30 - Execute the numbered macro.",
	"echo on - Displays macros as they are executed.",
	"echo off - Turns off displaying of macros as they are executed.",
	"Examples: ",
	"/bm 5 - Executes macro 5.",
	"/bm echo off - Turns off echoing."
};

--Spell casting workaround
BM_CAST_COMMAND				= "/cast";
BM_SCRIPTCAST_COMMAND			= "/script CastSpellByName";
BM_SCRIPT_COMMAND			= "/script ";
BM_CAST_NORANK_ERROR			= "You must specify a rank when casting a spell.";
BM_DEFAULT_RANK				= "Rank 1";