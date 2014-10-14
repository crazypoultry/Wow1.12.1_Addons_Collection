GTS_Core_VER = GetAddOnMetadata("GTS_Core", "Version");

GTS_MSG = {};

GTS_MSG["GREETING"]	= "GuildToolS v" .. GTS_Core_VER .. " is loaded.";
GTS_MSG["ADDONOFF"]	= "AddOn is turned off, use /gts on to turn it on for this character";
GTS_MSG["CLEARED"]	= "Variables have been cleared.";
GTS_MSG["INVALID"]	= "Not a valid command. See /gts info for list of commands.";
GTS_MSG["DEBUG_ON"]	= "Debug mode is now ENABLED for this character";
GTS_MSG["DEBUG_OFF"]= "Debug mode is now DISABLED for this character";

GTS_MSG["INFO"]	= {};
GTS_MSG["INFO"][1]	= "Tool for guild use that help export various info in SV.lua.";
GTS_MSG["INFO"][2]	= "List of components:";
GTS_MSG["INFO"][3]	= "BankScan - scanns possesions of char. See /gts bsinfo for more info.";
GTS_MSG["INFO"][4]	= "IncomingMail - tracks incoming mail. See /gts iminfo for more info.";
GTS_MSG["INFO"][5]	= "OutgoingMail - tracks outgoing mail. See /gts ominfo for more info.";
GTS_MSG["INFO"][6]	= "GuildRosterScaner - scans guild roster. See /gts grsinfo for more info.";
GTS_MSG["INFO"][7]	= "-------------------------------------------------------------------";
GTS_MSG["INFO"][8]	= "Available commands:";
GTS_MSG["INFO"][9]	= "/gts clear    clears all saved variables for this addon. If used all data will be lost.";
GTS_MSG["INFO"][10]	= "/gts debug    tuggles Debug Mode on/off.";
GTS_MSG["INFO"][11]	= "/gts info     shows this screen.";

GTS_GUITEXT = {};
--General
GTS_GUITEXT["GTS_MenuTab1"]	= "Info";
GTS_GUITEXT["GTS_MenuTab2"]	= "Bank management";
GTS_GUITEXT["GTS_MenuTab3"]	= "Guild manegement";

GTS_GUITEXT["GTS_Menu_Header"]	= "GuildToolS";
GTS_GUITEXT["GTS_Menu_Header2"]	= "Profile_: ";

--Tab 1
GTS_GUITEXT["GTS_Menu_Tab1_Header"]	= "Info";
GTS_GUITEXT["GTS_Menu_Tab1_Sig"]	= "GuildToolS  by  Roman Tarakanov (RTE/Arthas).";
GTS_GUITEXT["GTS_Menu_Tab1_Text"]	= "|nGuildToolS is the combination of tools for Guild use.|n|n";
GTS_GUITEXT["GTS_Menu_Tab1_Text"]	= GTS_GUITEXT["GTS_Menu_Tab1_Text"].."It contains components for bank manegement, such as|n";
GTS_GUITEXT["GTS_Menu_Tab1_Text"]	= GTS_GUITEXT["GTS_Menu_Tab1_Text"].."GTS_BankScan, which allows you to display content of guild bank on your website,|n";
GTS_GUITEXT["GTS_Menu_Tab1_Text"]	= GTS_GUITEXT["GTS_Menu_Tab1_Text"].."GTS_IncomingMail, which allows you to display all the incoming mail on your |n";
GTS_GUITEXT["GTS_Menu_Tab1_Text"]	= GTS_GUITEXT["GTS_Menu_Tab1_Text"].."guild's web-site, and|n";
GTS_GUITEXT["GTS_Menu_Tab1_Text"]	= GTS_GUITEXT["GTS_Menu_Tab1_Text"].."GTS_OutgoingMail, which allows you to display outgoing mail traffic on your |n";
GTS_GUITEXT["GTS_Menu_Tab1_Text"]	= GTS_GUITEXT["GTS_Menu_Tab1_Text"].."guild's web-site.|nAll of them can be found under Bank Manegement tab.|n|n";
GTS_GUITEXT["GTS_Menu_Tab1_Text"]	= GTS_GUITEXT["GTS_Menu_Tab1_Text"].."Also there are tools for guild manegement, such as|n";
GTS_GUITEXT["GTS_Menu_Tab1_Text"]	= GTS_GUITEXT["GTS_Menu_Tab1_Text"].."GTS_RosterScan, which allows you to scan the entire guild roster for later display |n";
GTS_GUITEXT["GTS_Menu_Tab1_Text"]	= GTS_GUITEXT["GTS_Menu_Tab1_Text"].."on the guild's web-site.|nIt can be found under Guild manegement tab.|n|n|n|n";
GTS_GUITEXT["GTS_Menu_Tab1_Text"]	= GTS_GUITEXT["GTS_Menu_Tab1_Text"].."For directions on use of the addon read Manual.html attached with the addon.";
--Tab 2
GTS_GUITEXT["GTS_Menu_BS_NL_loadBSText"]	= " load on log-in.";
GTS_GUITEXT["GTS_Menu_BS_NL_loadNow"]	= "Load Now";
GTS_GUITEXT["GTS_Menu_BS_NL_Header"]	= "Bank Scan.";
GTS_GUITEXT["GTS_Menu_BS_NL_Loaded"]	= "[Not Loaded]";

GTS_GUITEXT["GTS_Menu_IM_NL_loadIMText"]	= " load on log-in.";
GTS_GUITEXT["GTS_Menu_IM_NL_loadNow"]	= "Load Now";
GTS_GUITEXT["GTS_Menu_IM_NL_Header"]	= "Incoming Mail.";
GTS_GUITEXT["GTS_Menu_IM_NL_Loaded"]	= "[Not Loaded]";

GTS_GUITEXT["GTS_Menu_OM_NL_loadOMText"]	= " load on log-in.";
GTS_GUITEXT["GTS_Menu_OM_NL_loadNow"]	= "Load Now";
GTS_GUITEXT["GTS_Menu_OM_NL_Header"]	= "Outgoing Mail.";
GTS_GUITEXT["GTS_Menu_OM_NL_Loaded"]	= "[Not Loaded]";

GTS_GUITEXT["GTS_Menu_Tab2_Header"]	= "Bank management:";
--Tab 3 
GTS_GUITEXT["GTS_Menu_GRS_NL_loadGRSText"]	= " load on log-in.";
GTS_GUITEXT["GTS_Menu_GRS_NL_loadNow"]	= "Load Now";
GTS_GUITEXT["GTS_Menu_GRS_NL_Header"]	= "Guild Roster Scan.";
GTS_GUITEXT["GTS_Menu_GRS_NL_Loaded"]	= "[Not Loaded]";

GTS_GUITEXT["GTS_Menu_Tab3_Header"]	= "Guild management:";
