--[[--------------------------
Titan information
--------------------------]]--

TITANDKP_ID = "TITANDKP";
TITANDKP_ICON = "Interface\\Icons\\INV_Misc_Head_Dragon_01";
TITANDKP_RED = 1;
TITANDKP_GREEN = 1;
TITANDKP_BLUE = 0;
TITANDKP_ALPHA = 1;

--[[--------------------------
Version: English
--------------------------]]--
-- Information
TITANDKP_CATEGORY = "Information";
TITANDKP_RARITY = {
	[0] = "Trash",
	["Trash"] = 0,
	["ff9d9d9d"] = 0,
	[1] = "Standard",
	["Standard"] = 1,
	["ffffffff"] = 1,
	[2] = "Good",
	["Good"] = 2,
	["ff1eff00"] = 2,
	[3] = "Superior",
	["Superior"] = 3,
	["ff0070dd"] = 3,
	[4] = "Epic",
	["Epic"] = 4,
	["ffa335ee"] = 4,
	[5] = "Legendary",
	["Legendary"] = 5,
	["ffff8000"] = 5,
};
TITANDKP_CLASSES = {
	["Unknown"] = "Unknown",
	["Druid"] = "Druid",
	["Hunter"] = "Hunter",
	["Mage"] = "Mage",
	["Paladin"] = "Paladin",
	["Priest"] = "Priest",
	["Rogue"] = "Rogue",
	["Shaman"] = "Shaman",
	["Warlock"] = "Warlock",
	["Warrior"] = "Warrior",
};

-- special strings
TITANDKP_LOOT = "([^%s]+) receives loot: (.+)%.";
TITANDKP_SELFLOOT = "You receive loot: (.+)%.";
TITANDKP_ITEMSTRING = "|c(%x+)|Hitem:(%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r";
TITANDKP_DATE = "%m/%d/%y";

-- slash commands
TITANDKP_HELPCOMMAND = "help";
TITANDKP_ADDCOMMAND = "add";
TITANDKP_REMOVECOMMAND = "remove";
TITANDKP_SYSTEMCOMMAND = "system";
TITANDKP_PERSONCOMMAND = "player";
TITANDKP_SEARCHCOMMAND = "search";
TITANDKP_CHANGECOMMAND = "change";
TITANDKP_RAIDCOMMAND = "raid";
TITANDKP_HELP1 = "DKP Commands:";
TITANDKP_HELP2 = "[add/remove] system [name] - adds/remove a system";
TITANDKP_HELP3 = "[add/change/remove] player [name] <class> <value> - adds/remove a player or change player data";
TITANDKP_HELP4 = "change raid [value] - Add points to all raid members";
TITANDKP_HELP5 = "search <raid> [searchstring] ... - search for names/classes in raid or all";
TITANDKP_HELP6 = "[value] - Any other value will be evaluated and added to the DKP";
TITANDKP_ADDCOMMANDCOMPLETE1 = "Added ";
TITANDKP_CHANGECOMMANDCOMPLETE1 = "Changed ";
TITANDKP_CALCCOMMANDCOMPLETE2 = " points to DKP";
TITANDKP_CHANGECOMMANDCOMPLETE2 = " points to ";
TITANDKP_CHANGECOMMANDCOMPLETE3 = " points to raid successfully";
TITANDKP_REMOVECOMMANDCOMPLETE1 = "Removed ";
TITANDKP_ADDCOMMANDCOMPLETE2 = " successfully";
TITANDKP_SYSTEMADDCOMMANDCOMPLETE1 = "Added DKP System ";
TITANDKP_SYSTEMREMOVECOMMANDCOMPLETE2 = " DKP System";
TITANDKP_SEARCHCOMMANDCOMPLETE1 = "Found:";
TITANDKP_CHANGECOMMANDFAILED1 = "Command failed: Name not found";
TITANDKP_CHANGECOMMANDFAILED2 = "Command failed: value not correctly input";
TITANDKP_COMMANDFAILED1 = "Command failed: Incorrect format";
TITANDKP_ADDCOMMANDFAILED1 = "Command Failed: Player ";
TITANDKP_ADDCOMMANDFAILED2 = " is already saved";
TITANDKP_SYSTEMADDCOMMANDFAILED1 = "Command Failed: System ";
TITANDKP_SYSTEMREMOVECOMMANDFAILED1 = " does not exist";
TITANDKP_SEARCHCOMMANDFAILED1 = "No results found";

-- Frames
TITANDKP_BOSSTITLE = "Boss Kill:";
TITANDKP_INSTANCETITLE = "Attendance:";
TITANDKP_OKAY = "Okay";
TITANDKP_ADDBUTTON = "Add to All";
TITANDKP_PLAYERADDBUTTON = "Add Player";
TITANDKP_CANCEL = "Cancel";
TITANDKP_RAIDTITLE = "Raid Points:";
TITANDKP_SAVEDTITLE = "Saved Points:";
TITANDKP_NAMEHEADING = "Name";
TITANDKP_CLASSHEADING = "Class";
TITANDKP_DKPHEADING = "Points";
TITANDKP_FILTERTEXT = "Filter";
TITANDKP_INFOTITLE = "'s Alts";

-- mouse over
TITANDKP_TOOLTIPTITLE = "DKP History";
TITANDKP_STARTDKP = "Starting: ";
TITANDKP_CHANGEDDKP = "Changes: ";
TITANDKP_CURRENTDKP = "Current: ";
TITANDKP_NOTINRAID = "Not in a raid";
TITANDKP_THRESHOLDTIP = "Set Item Detection Threshold";
TITANDKP_EDITTIP = "Edit";
TITANDKP_INFOTIP = "Alt Info"

-- menu
TITANDKP_ALTLIST = "Alts";
TITANDKP_OPTIONLIST = "Options";
TITANDKP_ITEMLIST = "Record Item";
TITANDKP_SYSTEMLIST = "DKP System";
TITANDKP_SYSTEMADD = "Create";
TITANDKP_SYSTEMDEL = "Delete";
TITANDKP_REVERT = "Reset Raid's Points";
TITANDKP_REVERTCOMPLETE = "Raid's points reset";
TITANDKP_AUTOOPTIONS = "System Settings";
TITANDKP_RAIDOPTION = "View Raid Points";
TITANDKP_SAVEDOPTION = "View Saved Points";
TITANDKP_ENABLEOPTION = "Track DKP";
TITANDKP_IMPORTOPTION = "Import Web Data";
TITANDKP_STOPONKILLOPTION = "Stop giving instance points once a boss is killed";
TITANDKP_ADDBOXOPTION = "Only add positive points from alts";

-- automatic entry text
TITANDKP_KILLTEXT = " killed, added ";
TITANDKP_STARTTEXT1 = "Starting ";
TITANDKP_STARTTEXT2 = ", added ";
TITANDKP_ENDTEXT = " points to DKP";

-- Zone info
TITANDKP_ZONES = {
	["ZG"] = "Zul'Gurub",
	["AQ20"] = "Ruins of Ahn'Qiraj",
	["MC"] = "The Molten Core",
	["BWL"] = "Blackwing Lair",
	["AQ40"] = "Ahn'Qiraj",
	["NAXX"] = "Naxxramas",
	["DRAGON"] = "World Dragon",
};

-- Majordomo Fight
TITANDKP_MAJORDOMOYELL = "Impossible! Stay your attack, mortals... I submit! I submit!";
TITANDKP_MAJORDOMO = "Majordomo Executus";

-- Twin Emperors
TITANDKP_EMPEROR1 = "Emperor Vek'nilash";
TITANDKP_EMPEROR2 = "Emperor Vek'lor";

-- Lord Fight
TITANDKP_LORD1 = "Vem";
TITANDKP_LORD2 = "Princess Yauj";
TITANDKP_LORD3 = "Lord Kri";

-- bosses
TITANDKP_BOSSES = {
	-- ZG
	["ZG"] = "ZG",
	["High Priestess Jeklik"] = "ZG",
	["High Priest Venoxis"] = "ZG",
	["High Priestess Mar'li"] = "ZG",
	["High Priest Thekal"] = "ZG",
	["High Priestess Arlokk"] = "ZG",
	["Hakkar"] = "ZG",
	["Bloodlord Mandokir"] = "ZG",
	["Jin'do the Hexxer"] = "ZG",
	["Gahz'ranka"] = "ZG",
	["Hazza'rah"] = "ZG",
	["Gri'lek"] = "ZG",
	["Renataki"] = "ZG",
	["Wushoolay"] = "ZG",
	
	-- AQ20
	["AQ20"] = "AQ20",
	["Kurinnaxx"] = "AQ20",
	["General Rajaxx"] = "AQ20",
	["Ayamiss the Hunter"] = "AQ20",
	["Moam"] = "AQ20",
	["Buru The Gorger"] = "AQ20",
	["Ossirian The Unscarred"] = "AQ20",
	
	-- MC
	["MC"] = "MC",
	["Lucifron"] = "MC",
	["Magmadar"] = "MC",
	["Gehennas"] = "MC",
	["Garr"] = "MC",
	["Baron Geddon"] = "MC",
	["Shazzrah"] = "MC",
	["Sulfuron Harbinger"] = "MC",
	["Golemagg the Incinerator"] = "MC",
	["Ragnaros"] = "MC",
	
	-- BWL
	["BWL"] = "BWL",
	["Razorgore the Untamed"] = "BWL",
	["Vaelastrasz the Corrupt"] = "BWL",
	["Broodlord Lashlayer"] = "BWL",
	["Firemaw"] = "BWL",
	["Ebonroc"] = "BWL",
	["Flamegor"] = "BWL",
	["Chromaggus"] = "BWL",
	["Nefarian"] = "BWL",
	["Lord Victor Nefarius"] = "BWL",
	
	-- AQ40
	["AQ40"] = "AQ40",
	["The Prophet Skeram"] = "AQ40",
	["Fankriss the Unyielding"] = "AQ40",
	["Battleguard Sartura"] = "AQ40",
	["Princess Huhuran"] = "AQ40",
	["C'Thun"] = "AQ40",
	["Viscidus"] = "AQ40",
	["Ouro"] = "AQ40",
	
	-- Lord Fight
	[TITANDKP_LORD1] = "LO",
	[TITANDKP_LORD2] = "LO",
	[TITANDKP_LORD3] = "LO",
	
	-- Twin Emperors
	[TITANDKP_EMPEROR1] = "TE",
	[TITANDKP_EMPEROR2] = "TE",
	
	-- Naxx
	["NAXX"] = "NAXX",
	["Patchwerk"] = "NAXX",
	["Grobbulus"] = "NAXX",
	["Gluth"] = "NAXX",
	["Thaddius"] = "NAXX",
	["Instructor Razuvious"] = "NAXX",
	["Gothik the Harvester"] = "NAXX",
	["Highlord Mograine"] = "NAXX",
	["Thane Korth'azz"] = "NAXX",
	["Lady Blaumeux"] = "NAXX",
	["Sir Zeliek"] = "NAXX",
	["Noth The Plaguebringer"] = "NAXX",
	["Heigan the Unclean"] = "NAXX",
	["Loatheb"] = "NAXX",
	["Anub'Rekhan"] = "NAXX",
	["Grand Widow Faerlina"] = "NAXX",
	["Maexxna"] = "NAXX",
	["Sapphiron"] = "NAXX",
	["Kel'Thuzad"] = "NAXX",
	
	-- Dragons
	["DRAGON"] = "DRAGON",
	["Ysondre"] = "DRAGON",
	["Taerar"] = "DRAGON",
	["Emeriss"] = "DRAGON",
	["Lethon"] = "DRAGON",
	["Onyxia"] = "DRAGON",
	["Azuregos"] = "DRAGON",
	["Lord Kazzak"] = "DRAGON",
};