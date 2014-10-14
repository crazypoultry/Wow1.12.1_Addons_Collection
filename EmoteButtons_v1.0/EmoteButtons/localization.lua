-- Last update : 29/10/2006

-- <<--
--	Global info
-- -->>

EMOTEBUTTONS_NAME		= "EmoteButtons";
EMOTEBUTTONS_VERSION		= "1.0";

EMOTEBUTTONS_NAMEVERSION	= EMOTEBUTTONS_NAME.." v"..EMOTEBUTTONS_VERSION;

-- Version : English
-- Last update : 29/10/2006

-- <<--
--
-- -->>
EMOTEBUTTONS_ROTATION		= "Rotation";
EMOTEBUTTONS_SIZE		= "Size";
EMOTEBUTTONS_INIT_TEXT		= EMOTEBUTTONS_NAMEVERSION.." loaded";

EMOTEBUTTONS_SETTINGSWARN	= "|n|n|cff22ff22".."Shift-click to change this button!";

EMOTEBUTTONS_BUTTON		= "Button";

EMOTEBUTTONS_MAINHELP		= "|cFFFFFFFF"..EMOTEBUTTONS_NAME.."|n|n|r".."Right-click and drag to move|nShift-click a button for setup";

EMOTEBUTTONS_ERROR		= "Error";

EMOTEBUTTONS_SETACTION		= "Set Action";
EMOTEBUTTONS_SETTOOLTIP		= "Set Label";

EMOTEBUTTONS_OPENDECK		= "Open Deck";
EMOTEBUTTONS_SLASHCOMMAND	= "Do Emote";

EMOTEBUTTONS_CHANGELABEL	= "Change label to:";
EMOTEBUTTONS_CHANGECOMMAND	= "Change slash command to:";

EMOTEBUTTONS_OPENDECK1		= EMOTEBUTTONS_OPENDECK.." 1";
EMOTEBUTTONS_OPENDECK2		= EMOTEBUTTONS_OPENDECK.." 2";
EMOTEBUTTONS_OPENDECK3		= EMOTEBUTTONS_OPENDECK.." 3";
EMOTEBUTTONS_OPENDECK4		= EMOTEBUTTONS_OPENDECK.." 4";
EMOTEBUTTONS_OPENDECK5		= EMOTEBUTTONS_OPENDECK.." 5";
EMOTEBUTTONS_OPENDECK6		= EMOTEBUTTONS_OPENDECK.." 6";
EMOTEBUTTONS_OPENDECK7		= EMOTEBUTTONS_OPENDECK.." 7";
EMOTEBUTTONS_OPENDECK8		= EMOTEBUTTONS_OPENDECK.." 8";

EMOTEBUTTONS_SE = {
	["Main"] = {
		{action="Deck 1", tooltip="Flattering emotes"},
		{action="/laugh", tooltip="Laugh"},
		{action="/hi", tooltip="Greet"},
		{action="Deck 2", tooltip="Nice emotes"},
		{action="Deck 3", tooltip="Improper behaviour"},
		{action="/cry", tooltip="Cry"},
		{action="/bye", tooltip="Farewell"},
		{action="Deck 8", tooltip="Other functions"} },
	["Deck 1"] = { {action="/thank", tooltip="Thank"},
		{action="/welcome", tooltip="Welcome"},
		{action="/bow", tooltip="Bow"},
		{action="/whistle", tooltip="Whistle"},
		{action="/kneel", tooltip="Kneel down"},
		{action="/praise", tooltip="Praise"} },
	["Deck 2"] = { {action="/dance", tooltip="Dance"},
		{action="/salute", tooltip="Salute"},
		{action="/kiss", tooltip="Kiss"},
		{action="/wave", tooltip="Wave"},
		{action="/train", tooltip="Make train voices"},
		{action="/silly", tooltip="Tell a joke"} },
	["Deck 3"] = { {action="/angry", tooltip="Raise your fist"},
		{action="/shoo", tooltip="Shoo away"},
		{action="/rude", tooltip="Make a rude gesture"},
		{action="/doom", tooltip="Threaten"},
		{action="/bark", tooltip="Bark like a dog"},
		{action="/nosepick", tooltip="Pick your nose"} },
	["Deck 4"] = { {action="/cheer", tooltip="Cheer"},
		{action="/charge", tooltip="Charge"},
		{action="/congratulate", tooltip="Congratulate"},
		{action="/nod", tooltip="Nod"},
		{action="/flee", tooltip="Tell them to flee"},
		{action="/followme", tooltip="Tell them to follow you"} },
	["Deck 5"] = { {action="/flex", tooltip="Flex your muscles"},
		{action="/curious", tooltip="Look curious"},
		{action="/cuddle", tooltip="Cuddle"},
		{action="/drink", tooltip="Drink"},
		{action="/eat", tooltip="Eat"},
		{action="/calm", tooltip="Remain calm"} },
	["Deck 6"] = { {action="/burp", tooltip="Burp"},
		{action="/bounce", tooltip="Bounce"},
		{action="/drool", tooltip="Drool"},
		{action="/panic", tooltip="Panic"},
		{action="/frown", tooltip="Frown"},
		{action="/tired", tooltip="Look tired"} },
	["Deck 7"] = { {action="/ginfo", tooltip="Show information about your guild"},
		{action="/follow", tooltip="Follow your target"},
		{action="/inspect", tooltip="Inspect your target"},
		{action="/friend", tooltip="Add your target to your friendlist"},
		{action="/ignore", tooltip="Ignore target"},
		{action="/unignore", tooltip="Remove target from your ignore list"} },
	["Deck 8"] = { {action="/played", tooltip="Show played time"},
		{action="/raidinfo", tooltip="Show raid info"},
		{action="/who", tooltip="Do a who search"},
		{action="/macro", tooltip="Open macro UI"},
		{action="/console reloadui", tooltip="Reload the User Interface"},
		{action="/script EmoteButtons_Reset();", tooltip="Reset EmoteButtons standard emotes"} }	
}
