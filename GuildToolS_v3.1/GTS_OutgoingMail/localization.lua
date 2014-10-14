GTS_OM_VER = GetAddOnMetadata("GTS_OutgoingMail", "Version");

GTS_MSG["OM_GREETING"] = "GTS_OutgoingMail v" .. GTS_OM_VER .. " is loaded.";
GTS_MSG["OM_CLEARED"]  = "OutgoingMail varibles are cleared for this character.";
GTS_MSG["OM_RESET"]    = "All OutgoingMail varibles are cleared.";
GTS_MSG["OM_REEVAL"]   = "All prices were updated.";
GTS_MSG["OM_NOLL"]     = "Error: LootLink is not installed.";

GTS_MSG["OM_INFO"] = {};
GTS_MSG["OM_INFO"][1] = "Stores info about all the outgoing items in SV.lua.";
GTS_MSG["OM_INFO"][2] = "Available commands:";
GTS_MSG["OM_INFO"][3] = "/gts omclear    clears database for this character.";
GTS_MSG["OM_INFO"][4] = "/gts omreeval   updates all the vendor prices for items in SV.lua (LootLink required).";
GTS_MSG["OM_INFO"][5] = "/gts ominfo     shows this screen.";

GTS_MSG["TODAY"] 	= "Today.";
GTS_MSG["NEVER"] 	= "Never.";

GTS_GUITEXT["GTS_Menu_OM_loadOMText"]	= " load on log-in.";
GTS_GUITEXT["GTS_Menu_OM_loadNow"]	= "Load Now";
GTS_GUITEXT["GTS_Menu_OM_Scan"]	= "Update";
GTS_GUITEXT["GTS_Menu_OM_Clear"]	= "Clear";
GTS_GUITEXT["GTS_Menu_OM_Header"]	= "Outgoing Mail.";
GTS_GUITEXT["GTS_Menu_OM_Ver"]	= "ver";
GTS_GUITEXT["GTS_Menu_OM_Loaded"]	= "[Loaded]";
GTS_GUITEXT["GTS_Menu_OM_history"]	= "Outgoing mail history recorded from                    to";
GTS_GUITEXT["GTS_Menu_OM_numVendorPrice"]	= "There are       /       items with non-zero vendor prices.";
GTS_GUITEXT["GTS_Menu_OM_VendorAddon"]	= "Addon used for vendor pricing: ";
GTS_GUITEXT["GTS_Menu_OM_numVendorPrice1"]	= "";
GTS_GUITEXT["GTS_Menu_OM_numVendorPrice2"]	= "";
GTS_GUITEXT["GTS_Menu_OM_fromDate"]	= "Never.";
GTS_GUITEXT["GTS_Menu_OM_toDate"]	= "Never.";
GTS_GUITEXT["GTS_Menu_OM_VendorAddonStatus"]	= "None.";