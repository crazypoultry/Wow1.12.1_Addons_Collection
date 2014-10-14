--------------------------------------------------------------------------------
-- 
-- Name: TravelerGlobals.lua
-- Author: Malex
-- Date: 11/21/2006
--
--------------------------------------------------------------------------------




--------------------------------------------------------------------------------
--
-- Method:
-- Description:
-- Arguments:
-- Notes:
--
--------------------------------------------------------------------------------

-- Globals
--TravelerOptions = {};
TravelerChannel = "TravelerChannel";
TravelerVersion = 1;

TravelerLastBroadcastTime = 0;

-- This determines the frequency that the tab frames
-- update themselves
--
TravelerOnUpdateFrequency = 1.0; -- seconds

-- This determines how often broadcasts get sent
-- 
TravelerBroadcastFrequency = 30.0; -- 30 seconds

-- This determines how often advertisments are checked for
-- expiration
--
TravelerExpirationCheckFrequency = 1.0; -- 1 second

TravelerProtocolUpdateDetected = false;

TravelerDestinationExpiration = 300; -- 5 minutes
TravelerCustomerExpiration = 120; -- 60 seconds
TravelerBroadcastEnabled = false;
TravelerNotes = "";
TravelerInstanceId = 0;
TravelerContinentId = 0;
TravelerZoneId = 0;
TravelerDestinationId = 0;
TravelerCustomerId = 0;
TravelerBanId = 0;
TravelerAdInstanceId = 0;
TravelerChatFrameOnEventOriginal = nil;

TravelerRandomPortResponse = " is not available.  Get the Traveler addon available at www.curse-gaming.com if you want to find mages.";

TravelerSuppliers = { Size = 0};
TravelerCustomers = { Size = 0};
TravelerBanList = { Size = 0 };

TravelerHasSummon = false;

-- If the average message count in the channel exceeds the peak,
-- throttle back the send rate, otherwise increase
--
TravelerChannelLastSampleTime = time();
TravelerChannelMessagesThisSecond = 0;
TravelerChannelRunningAverageTotal = 0;
TravelerChannelRunningAverage = {};
TravelerChannelRunningAverageNextIndex = 0;
TravelerChannelRunningAverageSamples = 10;
TravelerChannelMessagePeak = 5;


TravelerInstances = 
{
	"Blackfathom Deeps",
	"Blackrock Depths",
	"Blackrock Spire (Lower)",
	"Blackrock Spire (Upper)",
	"Blackwing Lair",
	"Dire Maul (East)",
	"Dire Maul (North)",
	"Dire Maul (West)",
	"Gnomeregan",
	"Maraudon",
	"Molten Core",
	"Onyxia's Lair",
	"Ragefire Chasm",
	"Razorfen Downs",
	"Razorfen Kraul",
	"Scarlet Monastery",
	"Scholomance",
	"Shadowfang Keep",
	"Stratholme",
	"The Deadmines",
	"The Stockade",
	"The Sunken Temple",
	"Uldaman",
	"Wailing Caverns",
	"Zul'Farrak",
	"Zul'Gurub",
	"The Temple of Ahn'Qiraj",
	"The Ruins of Ahn'Qiraj",
	"Naxxramas",
	"HC: The Blood Furnaces",
	"HC: The Shattered Halls"
};

TravelerRaces = 
{
	["Human"] = 1,
	["Dwarf"] = 2,
	["Gnome"] = 3,
	["NightElf"] = 4,
	["Tauren"] = 5,
	["Scourge"] = 6,
	["Troll"] = 7,
	["Orc"] = 8	
};

TravelerRandomPortKeywords = 
{
	"port"
};	