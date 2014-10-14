GTS_BS_VER = GetAddOnMetadata("GTS_BankScan", "Version");

GTS_MSG["BS_GREETING"]   = "GTS_BankScan v" .. GTS_BS_VER .. " is loaded.";
GTS_MSG["BS_DONE"]       = "BankScan | Success : scan was successful, now you can log out and run BankParser.bat to get html file.";
GTS_MSG["BS_BANKCLOSED"] = "BankScan | Error : bank must be opened for this script to work.";
GTS_MSG["BS_SORTON"]     = "BankScan's sort function is ENABLED";
GTS_MSG["BS_SORTOFF"]    = "BankScan varibles are cleared for this character.";

GTS_MSG["BS_INFO"]	= {};
GTS_MSG["BS_INFO"][1] = "Scans possesions of the char, including bank into SV.lua.";
GTS_MSG["BS_INFO"][2] = "Available commands:";
GTS_MSG["BS_INFO"][3] = "/gts bssort     tuggles the BankScan's sorting function on/off for this char.";
GTS_MSG["BS_INFO"][4] = "/gts bscan      performs the scan of possesions of this char for parsing into SV.lua.";
GTS_MSG["BS_INFO"][5] = "/gts bsclear    clears all the data scanned for this character form SV.lua.";
GTS_MSG["BS_INFO"][6] = "/gts bsinfo     shows this screen.";

GTS_MSG["OPEN"]		= "Open.";
GTS_MSG["CLOSED"] 	= "Closed.";
GTS_MSG["TODAY"] 	= "Today.";
GTS_MSG["NEVER"] 	= "Never.";

GTS_GUITEXT["GTS_Menu_BS_loadBSText"]	= " load on log-in.";
GTS_GUITEXT["GTS_Menu_BS_scanOnOpenText"]	= " scan on bank open.";
GTS_GUITEXT["GTS_Menu_BS_useSortText"]	= " use sort.";
GTS_GUITEXT["GTS_Menu_BS_loadNow"]	= "Load Now";
GTS_GUITEXT["GTS_Menu_BS_Scan"]	= "Scan Now";
GTS_GUITEXT["GTS_Menu_BS_Update"]	= "Update";
GTS_GUITEXT["GTS_Menu_BS_Clear"]	= "Clear";
GTS_GUITEXT["GTS_Menu_BS_Header"]	= "Bank Scan.";
GTS_GUITEXT["GTS_Menu_BS_Ver"]	=  "ver";
GTS_GUITEXT["GTS_Menu_BS_Loaded"]	= "[Loaded]";
GTS_GUITEXT["GTS_Menu_BS_LastScan"]	= "Last scan was on ";
GTS_GUITEXT["GTS_Menu_BS_BankFrame"]	= "Bank Frame is ";
GTS_GUITEXT["GTS_Menu_BS_numVendorPrice"]	= "There are       /       items with non-zero vendor prices.";
GTS_GUITEXT["GTS_Menu_BS_VendorAddon"]	= "Addon used for vendor pricing: ";
GTS_GUITEXT["GTS_Menu_BS_LastScanStatus"]	= "Never.";
GTS_GUITEXT["GTS_Menu_BS_BankFrameStatus"]	= "Closed.";
GTS_GUITEXT["GTS_Menu_BS_numVendorPrice1"]	= "";
GTS_GUITEXT["GTS_Menu_BS_numVendorPrice2"]	= "";
GTS_GUITEXT["GTS_Menu_BS_VendorAddonStatus"]	= "None.";