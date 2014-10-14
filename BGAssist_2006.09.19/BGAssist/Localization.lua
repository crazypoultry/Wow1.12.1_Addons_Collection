BINDING_NAME_BGASSIST_TOGGLE = "Toggle BGAssist Window";

BGAssist_ItemTrack = {
	[17422] = "INV_Shoulder_19",		-- "Armor Scraps"
	-- Horde
	[17306] = "INV_Potion_50",		-- "Stormpike Soldier's Blood"
	[17642] = "INV_Misc_Pelt_Bear_02",	-- "Alterac Ram Hide"
	[18142] = "INV_Misc_Head_Elf_02",	-- "Severed Night Elf Head"
	[18143] = "INV_Misc_MonsterTail_02",	-- "Tuft of Gnome Hair"
	[18206] = "INV_Misc_Bone_03",		-- "Dwarf Spine"
	[18144] = "INV_Misc_Bone_07",		-- "Human Bone Chip"
	[17326] = "INV_Misc_Food_52",		-- "Stormpike Soldier's Flesh",
	[17327] = "INV_Misc_Food_72",		-- "Stormpike Lieutenant's Flesh"
	[17328] = "INV_Misc_Food_69",		-- "Stormpike Commander's Flesh",
	-- Alliance
	[17423] = "INV_Misc_Gem_Pearl_06",	-- "Storm Crystal"
	[17643] = "INV_Misc_Pelt_Bear_02",	-- "Frostwolf Hide"
	[18145] = "INV_Misc_Foot_Centaur",	-- "Tauren Hoof"
	[18146] = "INV_Potion_82",		-- "Darkspear Troll Mojo"
	[18207] = "INV_Misc_Bone_08",		-- "Orc Tooth"
	[18147] = "INV_Misc_Organ_01",		-- "Forsaken Heart"
	[17502] = "INV_Jewelry_Talisman_06", 	-- "Frostwolf Soldier's Medal"
	[17503] = "INV_Jewelry_Talisman_04",	-- "Frostwolf Lieutenant's Medal"
	[17504] = "INV_Jewelry_Talisman_12",	-- "Frostwolf Commander's Medal"
};
BGAssist_Alterac_Quests = {
	["Irondeep Supplies"] = true,
	["Coldtooth Supplies"] = true,
	["Master Ryson's All Seeing Eye"] = true,
	["Empty Stables"] = true,	-- Wolf/Ram turnin
	-- Horde
	["More Booty!"] 			= { item = 17422, min=20 },
	["Lokholar the Ice Lord"] 		= { item = 17306, max=4 },
	["A Gallon of Blood"] 			= { item = 17306, min=5 },
	["Ram Hide Harnesses"] 			= { item = 17642 },
	["Darkspear Defense"] 			= { item = 18142 },
	["Tuft it Out"] 			= { item = 18143 },
	["Wanted: MORE DWARVES!"] 		= { item = 18206 },
	["I've Got A Fever For More Bone Chips"]= { item = 18144 },
	["Call of Air - Guse's Fleet"]		= { item = 17326 },
	["Call of Air - Jeztor's Fleet"]	= { item = 17327 },
	["Call of Air - Mulverick's Fleet"]	= { item = 17328 },
	-- Alliance
	["More Armor Scraps"] 			= { item = 17422, min=20 },
	["Ivus the Forest Lord"] 		= { item = 17423, max=4 },
	["Crystal Cluster"] 			= { item = 17423, min=5 },
	["Ram Riding Harnesses"] 		= { item = 17643 },
	["What the Hoof?"] 			= { item = 18145 },
	["Staghelm's Mojo Jamboree"] 		= { item = 18146 },
	["Wanted: MORE ORCS!"] 			= { item = 18207 },
	["One Man's Love"] 			= { item = 18147 },
	["Call of Air - Slidore's Fleet"]	= { item = 17502 },
	["Call of Air - Vipore's Fleet"]	= { item = 17503 },
	["Call of Air - Ichman's Fleet"]	= { item = 17504 },
};
BGAssist_FlagRegexp = {
	["RESET"] = {	["regexp"] = "The flags are now placed at their bases." },
	["PICKED"] = {	["one"] = "FACTION", ["two"] = "PLAYER",
			["regexp"] = "The ([^ ]*) [fF]lag was picked up by ([^!]*)!" },
	["DROPPED"] = {	["one"] = "FACTION", ["two"] = "PLAYER",
			["regexp"] = "The ([^ ]*) [fF]lag was dropped by ([^!]*)!" },
	["RETURNED"] ={	["one"] = "FACTION", ["two"] = "PLAYER",
			["regexp"] = "The ([^ ]*) [fF]lag was returned to its base by ([^!]*)!" },
	["CAPTURED"] ={	["one"] = "PLAYER", ["two"] = "FACTION",
			["regexp"] = "([^ ]*) captured the ([^ ]*) flag!" },
};
ALTERACVALLEY 	= "Alterac Valley";
WARSONGGULCH 	= "Warsong Gulch";
ARATHIBASIN 	= "Arathi Basin";

DISPLAY_MENU_LOCKWINDOW 		= "Lock window position";
DISPLAY_MENU_AUTOSHOW 		= "Auto show window when entering BG";
DISPLAY_MENU_AUTOBGMINIMAP 		= "Auto show BG mini map when entering BG";
DISPLAY_MENU_AUTORELEASE 		= "Auto release in BG";
DISPLAY_MENU_AUTOQUEST 		= "Auto confirm quests";
DISPLAY_MENU_AUTOENTER 		= "Auto enter BG";
DISPLAY_MENU_AUTOSIGNUP 		= "Auto signup for BG";
DISPLAY_MENU_TIMERSHOW 		= "Show capture timers";
DISPLAY_MENU_ABTIMELEFTSHOW 	= "Show time till end";
DISPLAY_MENU_ITEMSHOW 		= "Show BG item counts";
DISPLAY_MENU_GYCOUNTDOWN 		= "Show timer for GY rezzing";
DISPLAY_MENU_FLAGTRACKING 	= "Track flags";
DISPLAY_MENU_TARGETTINGASSISTANCE = "Use targetting assistance window";

DISPLAY_MENU_NOPREEXISTING 	= "No pre-existing instances";
DISPLAY_MENU_SHOWCAPTUREDFLAGS 	= "Show flags already captured";
DISPLAY_TITLEDISPLAY_CAPTURE 	= "Captures";
DISPLAY_TITLEDISPLAY_ITEMS   	= "Items";
DISPLAY_TITLEDISPLAY_TARGETS 	= "Targets";
DISPLAY_TEXT_PREEXISTING 		= "Offered BG instance is pre-existing";
DISPLAY_TEXT_ENTERINGBATTLEGROUNDS = "Entering battlegrounds";
DISPLAY_TEXT_LEFTBATTLEGROUNDS 	= "Left battlegrounds";
DISPLAY_TEXT_TIMEUNTILREZ 	= "Time until ressurection";
DISPLAY_TEXT_TIMELEFT 		= "Time left";
DISPLAY_TEXT_SECONDS 		= "seconds";
DISPLAY_TEXT_MINUTES 		= "minutes";
DISPLAY_TEXT_NOTENTERINGAFK 	= "Not entering BG because you are AFK";
DISPLAY_TEXT_FLAGHOLDERNOTCLOSEENOUGH = "Flag holder not close enough to target.";
BATTLEGROUND_GOSSIP_TEXT 	= "I would like to go to the battleground.";
MATCHING_MARKED_AFK 	= "You are now AFK";
MATCHING_CLEARED_AFK 	= "You are no longer AFK.";
FACTION_ALLIANCE 	= "Alliance";
FACTION_HORDE 	= "Horde";
CLASS_WARRIOR 	= "Warrior";
CLASS_MAGE 	= "Mage";
CLASS_ROGUE 	= "Rogue";
CLASS_DRUID 	= "Druid";
CLASS_HUNTER 	= "Hunter";
CLASS_SHAMAN 	= "Shaman";
CLASS_PRIEST 	= "Priest";
CLASS_WARLOCK 	= "Warlock";
CLASS_PALADIN 	= "Paladin";

-- ABTimeLeft
INFINITY		= "infinity";
END_OF_GAME		= "End-of-game";
BASES			= "Bases"
RESOURCES		= "Resources";
REPUTATION		= "Reputation"
RESOURCE_DISPLAY	= BASES .. ": (%d+)  " .. RESOURCES .. ": (%d+)/2000";