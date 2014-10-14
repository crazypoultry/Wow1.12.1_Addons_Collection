-------------------------------------------------------------------------------
-- English/Default
-------------------------------------------------------------------------------

-- Bindings
BINDING_HEADER_BFC_HEADER = "Battlefield Commander";
BINDING_NAME_BFC_GLOBALCOMMSMENU = "Global Comms Menu";
BINDING_NAME_BFC_LOCALCOMMSMENU = "Local Comms Menu";
BINDING_NAME_BFC_TOGGLEMAP = "Toggle Map";
BINDING_NAME_BFC_VIEWMAP = "View Map";

BFC_Strings = {
	bfcommander = "Battlefield Commander",
};

-- Tab dropdown menu
BFC_Strings.Menu = {
	narrowmode = "Narrow Mode",
	autoshowbg = "BG Auto Show",
	options = "Options...",
};


-- Log message prefixes
BFC_Strings.LogPrefix = {
	"<BFC>Debug: ",
	"<BFC>Warning: ",
	"<BFC>Error: ",
	"<BFC> ",
};


-- Error messages
BFC_Strings.Errors = {
	cannotshow = "BFC cannot be displayed when in an instance.",
	notingroup = "You must be in a party or raid to use that function.",
	
	-- timer
	uninitialized = "Cannot start uninitialized timer. Use SetTime first.",
	
	-- common
	modinuse = "Cannot register module %q, name already in use.",
	unknownmodtype = "Cannot register module %q, unknown type %q.",
	nomodname = "Cannot register module - no name and/or type found.",
	noupdatefunc = "No update function named %q is registered.",
	updatefuncregistered = "An update function named %q is already registered.",
	
	-- comms
	ccpairregistered = "The component-command pair %q is already registered.",
	noccpairregistered = "No component-command pair %q is registered.",
	
	-- radio
	msgnotfound = "Message not found.",
	
	-- options
	defaultoptions = "Loading default options",
	
	-- info frame
	nilobject = "Cannot register a nil object",
};


-- Options interface
BFC_Strings.Options = {
	nooptions = "This module has no options.",
};

BFC_Strings.Factions = {
	alliance = "Alliance",
	horde = "Horde",
};


-- General battleground plugin stuff
BFC_Strings.BG_Base = {
	elapsed = "Elapsed: %s min",
	acount = "Ap: %s",
	hcount = "Hp: %s",
	apug = "As: %s%%",
	hpug = "Hs: %s%%",
	apugheader = "Alliance Servers",
	hpugheader = "Horde Servers",
	players = "Players",
	team = "Team",
};


-- Info frame dropdown
BFC_Strings.InfoFrame = {
	lock = "Lock Frame",
	hidedefaultscore = "Hide Default Score Frame",
	hideborder = "Hide Border",
	hideframe = "Hide Frame",
	cancel = "Cancel",
};


-- Things that the WSG herald yells
BFC_Strings.WSG = {
	modname = "Warsong Gulch Helper",
	zone = "Warsong Gulch",

	event_picked = "was picked up by ([^!]+)!",
	event_dropped = "was dropped by",
	event_returned = "returned",
	event_captured = "captured",
	event_placed = "placed at",
	
	
	atbase = "At base",
	dropped = "Dropped",
	unknown = "Unknown",
	captured = "Captured",
	
	rezwavedefault = "Rez wave in: unknown",
	rezwave = "Rez wave in: %ss",
	
	scorestring = "Score: %s/%s",
	score = "Score",
};


-- Arathi Basin stuff
BFC_Strings.AB = {
	modname = "Arathi Basin Helper",
	zone = "Arathi Basin",
	
	event_assaulted = "assaulted the ([^!]+)!",
	event_taken = "has taken the ([^!]+)!",
	event_defended = "has defended the ([^!]+)!", -- some weirdness with this one. eg, the farm is "the southern farm". seems to always be sent with a taken event, so can probably be ignored
	event_claims = "claims the ([^!]+)!",
	
	-- These have changed!! They should now match the text you see when you mouse
	-- over the node on the main map.
	farm = "Farm",
	blacksmith = "Blacksmith",
	mill = "Lumber Mill",
	stables = "Stables",
	mine = "Gold Mine",
	trollbane = "Trollbane Hall",
	defilers = "Defilers Den",
	
	rezloc = "Rez at: %s",
	
	scorestring = "Score: %s/%s",
	score = "Score",
	scorepattern = "Bases: (%d)  Resources: (%d+)/2000",
	alliancetimetowin = "Alliance wins in",
	hordetimetowin = "Horde wins in",
	basestowin = "Bases to win",
};

-- These need to exactly match the text in the event strings above
BFC_Strings.AB_Nodes = {
	farm = "farm",
	blacksmith = "blacksmith",
	mill = "lumber mill",
	stables = "stables",
	mine = "mine",
};

-- AB options dropdown
BFC_Strings.AB_Options = {
	showscore = "Show Score",
	lockwindow = "Lock Window",
	showtimers = "Show Timers",
	hidewindow = "|c00FF8080Hide Window|r",
	hidescoreboard = "Hide Scoreboard",
};


-- Alterac Valley stuff
BFC_Strings.AV = {
	modname = "Alterac Valley Helper",
	--zone = "Alterac Valley",
	zone = "Orgrimmar",
	herald = "Herald",
	
	event_destroyed = "The (.+) was destroyed by the ([^!]+)!",
	--event_taken = "The (.+)! was taken by the ([^!]+)!",
	event_attack = "The (.+) is under attack! If left unchecked, the ([.+]) will capture it!",
	event_taken = "The ([.+]) has taken the ([^!]+)!",
	event_claims = "claims the ([^!]+)!",
	
	
	
	-- These are for display, they don't need to match the event strings
	farm = "Farm",
	blacksmith = "Blacksmith",
	mill = "Mill",
	stables = "Stables",
	mine = "Mine",
	trollbane = "Trollbane Hall",
	defilers = "Defilers Den",
	
	rezloc = "Rez at: %s",
};

-- These need to exactly match the text in the event strings above
BFC_Strings.AV_Nodes = {
	farm = "Stonehearth Graveyard",
	blacksmith = "blacksmith",
	mill = "lumber mill",
	stables = "stables",
	mine = "mine",
};


-- The names of the classes
BFC_Strings.Classes = {
	WARLOCK = "Warlock",
	WARRIOR = "Warrior",
	HUNTER = "Hunter",
	MAGE = "Mage",
	PRIEST = "Priest",
	DRUID = "Druid",
	PALADIN = "Paladin",
	SHAMAN = "Shaman",
	ROGUE = "Rogue",
};


-- Just a plain old array with up to 5 entries, same for the zone-specific ones
BFC_Strings.CommsMenu = {
	"Enemy spotted!",
	"Situation under control.",
	"Need reinforcements!",
	"Roger that!",
	"Negative.",
};


-- gulch-specific comms menu
BFC_Strings.CommsMenu_WSG = {
	"Ramp",
	"Tunnel",
	"Graveyard",
	"Flag Room",
	"Balcony",
	"Roof",
	"Midfield",
};

BFC_Strings.CommsMenu_AB = {
	"Blacksmith",
	"Farm",
	"Lumber Mill",
	"Mine",
	"Stables",
};