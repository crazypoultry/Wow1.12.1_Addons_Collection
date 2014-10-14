GTS_IM_VER = GetAddOnMetadata("GTS_IncomingMail", "Version");

GTS_MSG["IM_GREETING"] = "GTS_IncomingMail v" .. GTS_IM_VER .. " is loaded.";
GTS_MSG["IM_CLEARED"]  = "IncomingMail varibles are cleared for this character.";
GTS_MSG["IM_RESET"]    = "All IncomingMail varibles are cleared.";
GTS_MSG["IM_REEVAL"]   = "All prices were updated.";
GTS_MSG["IM_NOLL"]     = "Error: LootLink is not installed.";

GTS_MSG["IM_INFO"] = {};
GTS_MSG["IM_INFO"][1] = "Stores info about all the incoming items in SV.lua.";
GTS_MSG["IM_INFO"][2] = "Available commands:";
GTS_MSG["IM_INFO"][3] = "/gts imclear    clears database for this character.";
GTS_MSG["IM_INFO"][4] = "/gts imreeval   updates all the vendor prices for items in SV.lua (LootLink required).";
GTS_MSG["IM_INFO"][5] = "/gts iminfo     shows this screen.";

GTS_MSG["TODAY"] 	= "Today.";
GTS_MSG["NEVER"] 	= "Never.";

GTS_GUITEXT["GTS_Menu_IM_loadIMText"]	= " load on log-in.";
GTS_GUITEXT["GTS_Menu_IM_loadNow"]	= "Load Now";
GTS_GUITEXT["GTS_Menu_IM_Scan"]	= "Update";
GTS_GUITEXT["GTS_Menu_IM_Clear"]	= "Clear";
GTS_GUITEXT["GTS_Menu_IM_Header"]	= "Incoming Mail.";
GTS_GUITEXT["GTS_Menu_IM_Ver"]	= "ver";
GTS_GUITEXT["GTS_Menu_IM_Loaded"]	= "[Loaded]";
GTS_GUITEXT["GTS_Menu_IM_history"]	= "Incoming mail history recorded from                    to";
GTS_GUITEXT["GTS_Menu_IM_numVendorPrice"]	= "There are       /       items with non-zero vendor prices.";
GTS_GUITEXT["GTS_Menu_IM_VendorAddon"]	= "Addon used for vendor pricing: ";
GTS_GUITEXT["GTS_Menu_IM_numVendorPrice1"]	= "";
GTS_GUITEXT["GTS_Menu_IM_numVendorPrice2"]	= "";
GTS_GUITEXT["GTS_Menu_IM_fromDate"]	= "Never.";
GTS_GUITEXT["GTS_Menu_IM_toDate"]	= "Never.";
GTS_GUITEXT["GTS_Menu_IM_VendorAddonStatus"]	= "None.";