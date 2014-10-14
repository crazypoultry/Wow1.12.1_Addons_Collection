--
-- RogueSpam
-- by Allara
--


-- The filters (using global strings so it automatically localizes)
-- You can put regular strings here to filter out as well.
-- This only gets populated the first time this add-on loads. After that
-- it gets loaded from the saved copy.
ROGUESPAM_FILTERS = {
	ERR_ABILITY_COOLDOWN, 					-- Ability is not ready yet.
	ERR_OUT_OF_ENERGY,							-- Not enough energy
	ERR_NO_ATTACK_TARGET,						-- There is nothing to attack.
	SPELL_FAILED_NO_COMBO_POINTS,		-- That ability requires combo points
	SPELL_FAILED_TARGETS_DEAD,			-- Your target is dead
	SPELL_FAILED_SPELL_IN_PROGRESS,	-- Another action is in progress
};


-- Localizable strings
-- (Starts in English by default. The RogueSpam_Localize function replaces these with translations.)
ROGUESPAM_ROGUESPAM = "RogueSpam";
ROGUESPAM_INIT1 = "Allara's RogueSpam ";
ROGUESPAM_V = "v";
ROGUESPAM_INIT2 = " loaded. Type /roguespam or /rs for options.";
ROGUESPAM_STATUS1 = "[RogueSpam is currently ";
ROGUESPAM_STATUS2 = "]";
ROGUESPAM_ENABLED = "enabled";
ROGUESPAM_DISABLED = "disabled";
ROGUESPAM_HELP = "help";
ROGUESPAM_USAGE1 = "Type /roguespam or /rs followed by one of the following commands:";
ROGUESPAM_USAGE2 = "  enable - Enables RogueSpam";
ROGUESPAM_USAGE3 = "  disable - Disables RogueSpam";
ROGUESPAM_USAGE4 = "  toggle - Toggles RogueSpam on/off";
ROGUESPAM_USAGE5 = "  list - Shows the current filters and their ID number";
ROGUESPAM_USAGE6 = "  add [message] - Adds [message] to the filter list";
ROGUESPAM_USAGE7 = "  remove [id] - Removes the message [id] from the filter list";
ROGUESPAM_ENABLE = "enable";
ROGUESPAM_DISABLE = "disable";
ROGUESPAM_FILTERSCMD = "list";
ROGUESPAM_ADD = "add";
ROGUESPAM_REMOVE = "remove";
ROGUESPAM_TOGGLE = "toggle";
ROGUESPAM_UNKNOWNCOMMAND = "RogueSpam: Unknown command. Type /roguespam or /rs for help.";
ROGUESPAM_CURRENTFILTERS = "Current RogueSpam filters:";
ROGUESPAM_SLASHCOMMAND1 = "/roguespam";
ROGUESPAM_SLASHCOMMAND2 = "/rs";
ROGUESPAM_ADDUSAGE1 = "Usage: /roguespam add [msg]";
ROGUESPAM_ADDUSAGE2 = "Example: /roguespam add Hello, world!";
ROGUESPAM_ADDEDFILTER = "RogueSpam added filter: ";
ROGUESPAM_REMOVEUSAGE1 = "Usage: /roguespam remove [id]";
ROGUESPAM_REMOVEUSAGE2 = "Example: /roguespam remove 2";
ROGUESPAM_REMOVEUSAGE3 = "Use /roguespam list to see the ID's of every filter";
ROGUESPAM_FILTERNOTFOUND = "RogueSpam: filter not found";
ROGUESPAM_REMOVEDFILTER = "Removed filter ";
ROGUESPAM_COSMOSTOGGLEINFO = "Toggles RogueSpam on/off";
ROGUESPAM_COSMOSENABLE = "Enable RogueSpam";



-- Global states
RogueSpam_Version = "1.5";
RogueSpam_Enabled = 1;
RS_NameRegistered = 0;
RS_CosmosRegistered = 0;


-- Returns a chat color code string
function RS_BCC(r, g, b)
	return string.format("|cff%02x%02x%02x", (r*255), (g*255), (b*255));
end

-- Standard colors to use
local RSC = RS_BCC(.3, .3, 1);
local RSW = RS_BCC(1, 1, 1);


-- Just prints a message to the default chat frame
function RS_Print(msg)
	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(msg);
	end
end


-- OnLoad function
function RogueSpam_OnLoad()
	-- Register events
	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");

	-- Add slash command
	SlashCmdList["ROGUESPAMCOMMAND"] = RogueSpam_SlashHandler;
	SLASH_ROGUESPAMCOMMAND1 = ROGUESPAM_SLASHCOMMAND1;
	SLASH_ROGUESPAMCOMMAND2 = ROGUESPAM_SLASHCOMMAND2;
	
	-- Hook function
	RS_Old_UIErrorsFrame_OnEvent = UIErrorsFrame_OnEvent;
	UIErrorsFrame_OnEvent = RS_New_UIErrorsFrame_OnEvent;
end


-- Localizes the add-on
function RogueSpam_Localize()
	if (GetLocale() == "frFR") then
		ROGUESPAM_ROGUESPAM = "RogueSpam";
		ROGUESPAM_INIT1 = "RogueSpam par Allara ";
		ROGUESPAM_V = "v";
		ROGUESPAM_INIT2 = " charg\195\169. Ecrivez /roguespam ou /rs pour options.";
		ROGUESPAM_STATUS1 = "[RogueSpam est actuellemnt ";
		ROGUESPAM_STATUS2 = "]";
		ROGUESPAM_ENABLED = "activ\195\169";
		ROGUESPAM_DISABLED = "d\195\169sactiv\195\169";
		ROGUESPAM_HELP = "aide";
		ROGUESPAM_USAGE1 = "Ecrivez /roguespam ou /rs suivit d'une des commandes suivantes :";
		ROGUESPAM_USAGE2 = "  activer - Active RogueSpam";
		ROGUESPAM_USAGE3 = "  d\195\169sactiver - D\195\169sactive RogueSpam";
		ROGUESPAM_USAGE4 = "  basculer - Basculer RogueSpam en Activ\195\169/D\195\169sactiv\195\169";
		ROGUESPAM_USAGE5 = "  liste - Affiche les filtres actuels et leur num\195\169ro d'ID ";
		ROGUESPAM_USAGE6 = "  ajouter [message] - Ajoute [message] \195\160 la liste des filtres";
		ROGUESPAM_USAGE7 = "  enlever [id] - Enl\195\168ve l'[id] du message de la liste des filtres";
		ROGUESPAM_ENABLE = "activer";
		ROGUESPAM_DISABLE = "d\195\169sactiver";
		ROGUESPAM_FILTERSCMD = "liste";
		ROGUESPAM_ADD = "ajouter";
		ROGUESPAM_REMOVE = "enlever";
		ROGUESPAM_TOGGLE = "basculer";
		ROGUESPAM_UNKNOWNCOMMAND = "RogueSpam : Commande inconnue. Ecrivez /roguespam ou /rs pour l'aide.";
		ROGUESPAM_CURRENTFILTERS = "Filtres actuels de RogueSpam:";
		ROGUESPAM_SLASHCOMMAND1 = "/roguespam";
		ROGUESPAM_SLASHCOMMAND2 = "/rs";
		ROGUESPAM_ADDUSAGE1 = "Utilisation : /roguespam ajouter [msg]";
		ROGUESPAM_ADDUSAGE2 = "Exemple : /roguespam ajouter Bonjour tout le monde !";
		ROGUESPAM_ADDEDFILTER = "RogueSpam ajoute le filtre : ";
		ROGUESPAM_REMOVEUSAGE1 = "Utilisation : /roguespam enl\195\168ve l'[id]";
		ROGUESPAM_REMOVEUSAGE2 = "Exemple : /roguespam enl\195\168ve 2";
		ROGUESPAM_REMOVEUSAGE3 = "Utiliser /roguespam liste, pour voir l'ID de tous les filtres";
		ROGUESPAM_FILTERNOTFOUND = "RogueSpam : filtre non trouv\195\169";
		ROGUESPAM_REMOVEDFILTER = "Filtre enlev\195\169 ";
		ROGUESPAM_COSMOSTOGGLEINFO = "Basculer RogueSpam en Activ\195\169/D\195\169sactiv\195\169";
		ROGUESPAM_COSMOSENABLE = "Activer RogueSpam";
	elseif (GetLocale() == "deDE") then
		ROGUESPAM_INIT1 = "Allara's RogueSpam ";
		ROGUESPAM_V = "v";
		ROGUESPAM_INIT2 = " geladen. /roguespam oder /rs zeigt die Optionen an.";
		ROGUESPAM_STATUS1 = "[RogueSpam ist ";
		ROGUESPAM_STATUS2 = "]";
		ROGUESPAM_ENABLED = "aktiv";
		ROGUESPAM_DISABLED = "inaktiv";
		ROGUESPAM_HELP = "Hilfe";
		ROGUESPAM_USAGE1 = "/roguespam oder /rs mit einem der folgenden Befehle eingeben:";
		ROGUESPAM_USAGE2 = " aktivieren - aktiviert RogueSpam";
		ROGUESPAM_USAGE3 = " deaktivieren - deaktiviert RogueSpam";
		ROGUESPAM_USAGE4 = " toggle - toggelt den Aktivzustand von RogueSpam";
		ROGUESPAM_USAGE5 = " liste - zeigt die aktuellen Filter und ihre IDs an";
		ROGUESPAM_USAGE6 = " add [nachricht] - F\195\188gt [message] der Filterliste hinzu";
		ROGUESPAM_USAGE7 = " remove [id] - L\195\182scht die Nachricht [id] von der Filterliste";
		ROGUESPAM_ENABLE = "aktivieren";
		ROGUESPAM_DISABLE = "deaktivieren";
		ROGUESPAM_FILTERSCMD = "liste";
		ROGUESPAM_ADD = "add";
		ROGUESPAM_REMOVE = "remove";
		ROGUESPAM_TOGGLE = "toggle";
		ROGUESPAM_UNKNOWNCOMMAND = "RogueSpam: Unbekannter Befehl. /roguespam oder /rs zeigt die Hilfe an.";
		ROGUESPAM_CURRENTFILTERS = "Momentane RogueSpam-Filter:";
		ROGUESPAM_SLASHCOMMAND1 = "/roguespam";
		ROGUESPAM_SLASHCOMMAND2 = "/rs";
		ROGUESPAM_ADDUSAGE1 = "Benutzung: /roguespam add [msg]";
		ROGUESPAM_ADDUSAGE2 = "Beispiel: /roguespam add Hallo!";
		ROGUESPAM_ADDEDFILTER = "RogueSpam f\195\188gte folgenden Filter der Liste hinzu: ";
		ROGUESPAM_REMOVEUSAGE1 = "Benutzung: /roguespam remove [id]";
		ROGUESPAM_REMOVEUSAGE2 = "Beispiel: /roguespam remove 2";
		ROGUESPAM_REMOVEUSAGE3 = "/roguespam liste um die IDs der Filter anzeigen";
		ROGUESPAM_FILTERNOTFOUND = "RogueSpam: Filter nicht gefunden";
		ROGUESPAM_REMOVEDFILTER = "Filter gel\195\182scht ";
		ROGUESPAM_COSMOSTOGGLEINFO = "Toggelt den Aktivzustand von RogueSpam";
		ROGUESPAM_COSMOSENABLE = "Aktiviert RogueSpam";
	end
end


-- Toggles RogueSpam
function RogueSpam_Toggle()
	if (RogueSpam_Enabled == 1) then
		RogueSpam_Enabled = 0;
	else
		RogueSpam_Enabled = 1;
	end
	RS_PrintStatus();
end


-- Register with Cosmos
function RogueSpam_RegisterCosmos()
	if (Cosmos_UpdateValue and Cosmos_RegisterConfiguration and (RS_CosmosRegistered == 0)) then
		Cosmos_RegisterConfiguration(
			"COS_ROGUESPAM",
			"SECTION",
			ROGUESPAM_ROGUESPAM,
			""
		);
		Cosmos_RegisterConfiguration(
			"COS_ROGUESPAM_HEADER",
			"SEPARATOR",
			ROGUESPAM_ROGUESPAM,
			""
		);
		Cosmos_RegisterConfiguration(
			"COS_ROGUESPAM_ENABLED",
			"CHECKBOX",
			ROGUESPAM_COSMOSENABLE,
			ROGUESPAM_COSMOSTOGGLEINFO,
			RogueSpam_Toggle,
			RogueSpam_Enabled
		);
		RS_CosmosRegistered = 1;
	end
end


function RS_Initialize()
	this:UnregisterEvent("UNIT_NAME_UPDATE");
	this:UnregisterEvent("PLAYER_ENTERING_WORLD");
	RogueSpam_Localize();
	
	-- myAddOns support
	if(myAddOnsList) then
		myAddOnsList.RogueSpam = {
			name = "RogueSpam",
			description = "",
			version = RogueSpam_Version,
			frame = "RogueSpamFrame",
			category = MYADDONS_CATEGORY_CLASS
		};
	end
	
	-- Cosmos support (NOT DONE YET)
	--RogueSpam_RegisterCosmos();		-- The function itself checks for the existence of Cosmos
	
	RS_Print(RSC..ROGUESPAM_INIT1..RSW..ROGUESPAM_V..RogueSpam_Version..RSC..ROGUESPAM_INIT2);
end


-- Event handler
function RogueSpam_OnEvent()
	-- Player loaded completely, time to load us
	if (event == "UNIT_NAME_UPDATE" and arg1 == "player") or (event=="PLAYER_ENTERING_WORLD") then
		if (RS_NameRegistered == 1) then
			return;
		end
		local playerName = UnitName("player");
		if (playerName ~= UNKNOWNBEING and playerName ~= "Unknown Entity" and playerName ~= nil ) then
			RS_NameRegistered = 1;
			RS_Initialize();
		end
	end
end


-- Prints the status
function RS_PrintStatus()
	s = RSC..ROGUESPAM_STATUS1..RSW;
	if (RogueSpam_Enabled == 1) then
		s = s..ROGUESPAM_ENABLED;
	else
		s = s..ROGUESPAM_DISABLED;
	end
	s = s..RSC..ROGUESPAM_STATUS2;
	RS_Print(s);
end


-- Slash command handler
function RogueSpam_SlashHandler(msg, arg1, arg2)
	local omsg = msg;
	if (msg) then
		msg = string.lower(msg);
		-- No command
		if (msg == "" or msg == ROGUESPAM_HELP) then
			RS_Print(RSC..ROGUESPAM_USAGE1);
			RS_Print(RSC..ROGUESPAM_USAGE2);
			RS_Print(RSC..ROGUESPAM_USAGE3);
			RS_Print(RSC..ROGUESPAM_USAGE4);
			RS_Print(RSC..ROGUESPAM_USAGE5);
			RS_Print(RSC..ROGUESPAM_USAGE6);
			RS_Print(RSC..ROGUESPAM_USAGE7);
			RS_PrintStatus();
		-- Disable
		elseif (msg == ROGUESPAM_DISABLE) then
			RogueSpam_Enabled = 0;
			RS_PrintStatus();
		-- Enable
		elseif (msg == ROGUESPAM_ENABLE) then
			RogueSpam_Enabled = 1;
			RS_PrintStatus();
		-- List filters
		elseif (msg == ROGUESPAM_FILTERSCMD) then
			RS_Print(RSW..ROGUESPAM_CURRENTFILTERS);
			for key, text in ROGUESPAM_FILTERS do
				RS_Print(RSC.."  ["..RSW..key..RSC.."] "..text);
			end
		-- Toggle
		elseif (msg == ROGUESPAM_TOGGLE) then
			RogueSpam_Toggle();
		elseif (string.sub(msg, 1, string.len(ROGUESPAM_ADD)) == ROGUESPAM_ADD) then
			if (string.sub(msg, 1, (string.len(ROGUESPAM_ADD)+1)) ~= (ROGUESPAM_ADD.." ")) then
				RS_Print(ROGUESPAM_ADDUSAGE1);
				RS_Print(ROGUESPAM_ADDUSAGE2);
			else
				str = string.sub(omsg, (string.len(ROGUESPAM_ADD)+2), -1);
				table.insert(ROGUESPAM_FILTERS, str);
				RS_Print(RSC..ROGUESPAM_ADDEDFILTER..RSW..str);
			end
		elseif (string.sub(msg, 1, string.len(ROGUESPAM_REMOVE)) == ROGUESPAM_REMOVE) then
			if (string.sub(msg, 1, (string.len(ROGUESPAM_REMOVE)+1)) ~= (ROGUESPAM_REMOVE.." ")) then
				RS_Print(ROGUESPAM_REMOVEUSAGE1);
				RS_Print(ROGUESPAM_REMOVEUSAGE2);
				RS_Print(ROGUESPAM_REMOVEUSAGE3);
			else
				str = string.sub(omsg, (string.len(ROGUESPAM_REMOVE)+2), -1);
				for key, text in ROGUESPAM_FILTERS do
					if (key == tonumber(str)) then
						table.remove(ROGUESPAM_FILTERS, key);
						RS_Print(RSC..ROGUESPAM_REMOVEDFILTER..RSW..text);
						return;
					end
				end
				RS_Print(ROGUESPAM_FILTERNOTFOUND);
			end
		-- Unknown command
		else
			RS_Print(ROGUESPAM_UNKNOWNCOMMAND);
		end
	end
end


-- Hooked function
function RS_New_UIErrorsFrame_OnEvent(event, message, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
	-- Filter
	if (RogueSpam_Enabled == 1) then
		for key, text in ROGUESPAM_FILTERS do
			if (text and message) then if (message == text) then return; end end
		end
	end
	-- Chain back
	RS_Old_UIErrorsFrame_OnEvent(event, message, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
end
