
GTS_GRS_VER = GetAddOnMetadata("GTS_GuildRosterScan", "Version");

GTS_MSG["GRS_GREETING"]   = "GTS_GuildRosterScan v" .. GTS_GRS_VER .. " is loaded.";
GTS_MSG["GRS_DONE"]       = "GuildRosterScan | Success : scan was successful, now you can log out and run GuildRosterParser.exe to get html file.";
GTS_MSG["GRS_NOGUILD"]    = "GuildRosterScan | Error : this character does not belong to any guild.";
GTS_MSG["GRS_CLEARED"]     = "GuildRosterScan varibles are cleared for this character.";

GTS_PROF	= {};
GTS_PROF["A"]	= "Alchemy";
GTS_PROF["B"]	= "Blacksmith";
GTS_PROF["BM"]	= "Macesmith";
GTS_PROF["BS"]	= "Swordsmith";
GTS_PROF["BA"]	= "Axesmith";
GTS_PROF["Q"]	= "Armorsmith";
GTS_PROF["C"]	= "Enchanting";
GTS_PROF["E"]	= "Engineering";
GTS_PROF["EN"]	= "Gnome Engineering";
GTS_PROF["EO"]	= "Goblin Engineering";
GTS_PROF["H"]	= "Herbalism";
GTS_PROF["L"]	= "Leatherworking";
GTS_PROF["LE"]	= "Elemental Leatherworking";
GTS_PROF["LD"]	= "Dragonscale Leatherworking";
GTS_PROF["LT"]	= "Tribal Leatherworking";
GTS_PROF["M"]	= "Mining";
GTS_PROF["S"]	= "Skinning";
GTS_PROF["T"]	= "Tailoring";
GTS_PROF["N"]	= "None";

GTS_CLASS	= {};
GTS_CLASS["Druid"]		= "Druid";
GTS_CLASS["Hunter"]		= "Hunter";
GTS_CLASS["Mage"]		= "Mage";
GTS_CLASS["Paladin"]	= "Paladin";
GTS_CLASS["Priest"]		= "Priest";
GTS_CLASS["Rogue"]		= "Rogue";
GTS_CLASS["Shaman"]		= "Shaman";
GTS_CLASS["Warlock"]	= "Warlock";
GTS_CLASS["Warrior"]	= "Warrior";

GTS_MSG["NONE"]	= "None";
GTS_MSG["PLAYERSSCANNED"]	= " players scanned.";
GTS_MSG["TODAY"] 	= "Today.";
GTS_MSG["NEVER"] 	= "Never.";

GTS_MSG["GRS_INFO"]	= {};
GTS_MSG["GRS_INFO"][1]	= "Stores info about all guildmembers in SV.lua.";
GTS_MSG["GRS_INFO"][2]	= "Available commands:";
GTS_MSG["GRS_INFO"][3]	= "/gts grscan     performs a guild roster scan (make sure you load guildroster beforehand).";
GTS_MSG["GRS_INFO"][4]	= "/gts grsclear   clears database for this character.";
GTS_MSG["GRS_INFO"][5]	= "/gts grsinfo    shows this screen.";

GTS_GUITEXT["GTS_Menu_GRS_loadGRSText"]	= " load on log-in.";
GTS_GUITEXT["GTS_Menu_GRS_scanOnOpenText"]	= " scan on guild roster update (not recomended).";
GTS_GUITEXT["GTS_Menu_GRS_loadNow"]	= "Load Now";
GTS_GUITEXT["GTS_Menu_GRS_Scan"]	= "Scan Now";
GTS_GUITEXT["GTS_Menu_GRS_Clear"]	= "Clear";
GTS_GUITEXT["GTS_Menu_GRS_Header"]	= "Guild Roster Scan.";
GTS_GUITEXT["GTS_Menu_GRS_Ver"]	= "ver";
GTS_GUITEXT["GTS_Menu_GRS_Loaded"]	= "[Loaded]";
GTS_GUITEXT["GTS_Menu_GRS_LastScan"]	= "Last scan was on ";
GTS_GUITEXT["GTS_Menu_GRS_numMem"]	= "There were       /       members with GTS guild note filled out.";
GTS_GUITEXT["GTS_Menu_GRS_LastScanStatus"]	= "Never.";
GTS_GUITEXT["GTS_Menu_GRS_numMem1"]	= "";
GTS_GUITEXT["GTS_Menu_GRS_numMem2"]	= "";