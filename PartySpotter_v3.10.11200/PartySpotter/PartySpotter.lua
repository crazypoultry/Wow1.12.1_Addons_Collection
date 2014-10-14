
-- Saved Data

PartySpotterSettings = {};




-- Local Variables

local timeSinceLastUpdate = 0;
local iiInterval = 10;			-- update Ignores every 10 seconds (caters for ImprovedIgnore)
local pulloutInterval = 0.6;
local timeSinceLastWMUpdate = 0;
local timeSinceLastBFMUpdate = 0;
local timeSinceLastAMUpdate = 0;
local timeSinceMinimapUpdate = 0;
local timeSinceUnitUpdate = 0;
local minimapInterval = 0.25;
local unitInterval = 0.15;
local updateInterval;
local highlightedGroup = 0;
local singleOut = "";
local singleUnit = nil;
local colourNext = nil;
local pulloutTimer = 0;
local pulloutTracker = 0;
local clickedPlayer = "";
local gTipscale = nil;
local wmTipscale = nil;
local Minimap_InCity = false;

local PS_wmDefaultCoordsX = 970;
local PS_wmDefaultCoordsY = 136;

local PSTOPC = {};
PSTOPC.r = 0.64;
PSTOPC.g = 0.21;
PSTOPC.b = 0.93;

local yellowC	= { r = 1.0, g = 1.0, b = 0.4 };
local orangeC	= { r = 1.0, g = 0.6, b = 0.2 };
local lGroupC	= { r = 0.0, g = 0.45, b = 1.0 };

local defaultGroupTexture = "Interface\\Addons\\PartySpotter\\Artwork\\IconTemplate";
local defaultGroupColourCodes = {
	{ r = 1.0, g = 0.6, b = 0.0 },
	{ r = 0.6, g = 0.1, b = 0.6 },
	{ r = 0.0, g = 1.0, b = 1.0 },
	{ r = 1.0, g = 0.0, b = 0.0 },
	{ r = 0.0, g = 1.0, b = 0.0 },
	{ r = 1.0, g = 1.0, b = 1.0 },
	{ r = 1.0, g = 0.0, b = 1.0 }
	};

local groupNumbers = {
	"Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup1t",
	"Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup2t",
	"Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup3t",
	"Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup4t",
	"Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup5t",
	"Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup6t",
	"Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup7t",
	"Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup8t",
};

local friendA = {};
local numberOfFriends = 0;
local ignoreA = {};
local guildA = {};
local hRaidA = nil;
local numberOfGuildMembers = 0;

local pName;


UnitPopupButtons["RAID_PSPOT"] = { text = TEXT(PSPOT_HIGHLIGHT), dist = 0 };


-- Local Constants

local PSTOP_DEFAULT_INTERVAL = 10;		-- default of 1 update per 10 Seconds (Version 3 updates are more event driven)
local MAX_RAID_GROUPINGS = 8;



-- Hooks
local PSPOTOri_ChatFrame_OnEvent;
local PSPOTOri_UnitPopup_OnClick;



-- AddOn Functions

function PartySpotter_OnLoad()
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("FRIENDLIST_UPDATE");
	this:RegisterEvent("IGNORELIST_UPDATE");
	this:RegisterEvent("GUILD_ROSTER_UPDATE");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("RAID_ROSTER_UPDATE");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("MINIMAP_UPDATE_ZOOM");

	PSPOTOri_ChatFrame_OnEvent = ChatFrame_OnEvent;
	ChatFrame_OnEvent = PSPOTNew_ChatFrame_OnEvent;
	PSPOTOri_UnitPopup_OnClick = UnitPopup_OnClick;
	UnitPopup_OnClick = PSPOTNew_UnitPopup_OnClick;

	SlashCmdList["PTSPOT"] = function(pList)
		PartySpotter_CmdLine(pList);
	end
	SLASH_PTSPOT1 = "/pspot";
	SLASH_PTSPOT2 = "/partyspotter";

	DEFAULT_CHAT_FRAME:AddMessage("PartySpotter v3.10.11200", PSTOPC.r, PSTOPC.g, PSTOPC.b);
end

function WorldMapPartySpotterKey_OnLoad()
	WorldMapPartySpotterKeyBttn1IconsNumber:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup1t");
	WorldMapPartySpotterKeyBttn2IconsNumber:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup2t");
	WorldMapPartySpotterKeyBttn3IconsNumber:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup3t");
	WorldMapPartySpotterKeyBttn4IconsNumber:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup4t");
	WorldMapPartySpotterKeyBttn5IconsNumber:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup5t");
	WorldMapPartySpotterKeyBttn6IconsNumber:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup6t");
	WorldMapPartySpotterKeyBttn7IconsNumber:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup7t");
	WorldMapPartySpotterKeyBttn8IconsNumber:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup8t");
end

function AlphaMapPartySpotterKey_OnLoad()
	AlphaMapPartySpotterKeyBttn1IconsNumber:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup1t");
	AlphaMapPartySpotterKeyBttn2IconsNumber:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup2t");
	AlphaMapPartySpotterKeyBttn3IconsNumber:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup3t");
	AlphaMapPartySpotterKeyBttn4IconsNumber:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup4t");
	AlphaMapPartySpotterKeyBttn5IconsNumber:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup5t");
	AlphaMapPartySpotterKeyBttn6IconsNumber:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup6t");
	AlphaMapPartySpotterKeyBttn7IconsNumber:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup7t");
	AlphaMapPartySpotterKeyBttn8IconsNumber:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup8t");
end



function PartySpotter_OnEvent()
	if ( event == "ADDON_LOADED" ) then
		if ( ( arg1 ) and ( arg1 == "Blizzard_BattlefieldMinimap" ) ) then
			PartySpotter_LoadBFM();
		elseif ( ( arg1 ) and ( arg1 == "Blizzard_RaidUI" ) ) then
			PartySpotter_LoadRaidFrame();
		end

	elseif ( event == "FRIENDLIST_UPDATE" ) then
		PartySpotter_UpdateFriends();
		PartySpotter_ManualTrigger();

	elseif ( event == "IGNORELIST_UPDATE" ) then
		PartySpotter_UpdateIgnores();
		PartySpotter_ManualTrigger();

	elseif ( event == "GUILD_ROSTER_UPDATE" ) then
		PartySpotter_UpdateGuild();
		PartySpotter_ManualTrigger();

	elseif ( event == "PLAYER_ENTERING_WORLD" ) then
		PartySpotter_UpdateGuild();
		PartySpotter_UpdateIgnores();
		PartySpotter_UpdateFriends();
		PartySpotter_RaidControl_SetLabels();
		PartySpotter_ManualTrigger();

	elseif ( event == "RAID_ROSTER_UPDATE" ) then
		hRaidA = PartySpotter_RememberHighlighted(highlightedGroup);
		PartySpotter_CheckHighlighted();
		PartySpotter_ManualTrigger();
		PartySpotter_RaidControl_SetLabels();

	elseif ( event == "PARTY_MEMBERS_CHANGED" ) then
		hRaidA = PartySpotter_RememberHighlighted(highlightedGroup);
		PartySpotter_CheckHighlighted();
		PartySpotter_ManualTrigger();
		PartySpotter_RaidControl_SetLabels();

	elseif ( event == "MINIMAP_UPDATE_ZOOM" ) then
		Minimap_InCity = PartySpotter_MinimapInCity();

	elseif ( event == "VARIABLES_LOADED" ) then

		if ( not PartySpotterSettings ) then
			PartySpotterSettings = {};
		end

		if ( not PartySpotterSettings.updateInterval ) then
			updateInterval = PSTOP_DEFAULT_INTERVAL;
			PartySpotterSettings.updateInterval = updateInterval;
		else
			updateInterval = PartySpotterSettings.updateInterval;
		end

		if ( PartySpotterSettings.showKey == nil ) then
			PartySpotterSettings.showKey = true;
		elseif ( PartySpotterSettings.showKey == true ) then
			WorldMapPartySpotterKey:Show();
			AlphaMapPartySpotterKey:Show();
		else
			WorldMapPartySpotterKey:Hide();
			AlphaMapPartySpotterKey:Hide();
		end

		if ( PartySpotterSettings.showGroups == nil ) then
			PartySpotterSettings.showGroups = "Numbers";
		end

		if ( PartySpotterSettings.groupColours == nil ) then
			PartySpotterSettings.groupColours = defaultGroupColourCodes;
		end

		if ( PartySpotterSettings.lGroupC == nil ) then
			PartySpotterSettings.lGroupC = lGroupC;
		end

		if ( PartySpotterSettings.colouredChat == nil ) then
			PartySpotterSettings.colouredChat = true;
		end

		if ( PartySpotterSettings.numberedChat == nil ) then
			PartySpotterSettings.numberedChat = true;
		end

		if ( PartySpotterSettings.wmKeyLocX == nil ) then
			PartySpotterSettings.wmKeyLocX = PS_wmDefaultCoordsX;
		end
		if ( PartySpotterSettings.wmKeyLocY == nil ) then
			PartySpotterSettings.wmKeyLocY = PS_wmDefaultCoordsY;
		end
		PartySpotter_SetwmKeyPos();

		pName = UnitName("player");

		-- Add PartySpotter Options to Right Click Menus
		local nMenu = getn(UnitPopupMenus["RAID"]);
		local cMenu = nMenu + 1;
		if ( UnitPopupMenus["RAID"][nMenu] == "CANCEL" ) then
			UnitPopupMenus["RAID"][nMenu] = "RAID_PSPOT";
			UnitPopupMenus["RAID"][cMenu] = "CANCEL";
		else
			UnitPopupMenus["RAID"][cMenu] = "RAID_PSPOT";
		end

		nMenu = getn(UnitPopupMenus["PARTY"]);
		cMenu = nMenu + 1;
		if ( UnitPopupMenus["PARTY"][nMenu] == "CANCEL" ) then
			UnitPopupMenus["PARTY"][nMenu] = "RAID_PSPOT";
			UnitPopupMenus["PARTY"][cMenu] = "CANCEL";
		else
			UnitPopupMenus["PARTY"][cMenu] = "RAID_PSPOT";
		end

		nMenu = getn(UnitPopupMenus["PLAYER"]);
		cMenu = nMenu + 1;
		if ( UnitPopupMenus["PLAYER"][nMenu] == "CANCEL" ) then
			UnitPopupMenus["PLAYER"][nMenu] = "RAID_PSPOT";
			UnitPopupMenus["PLAYER"][cMenu] = "CANCEL";
		else
			UnitPopupMenus["PLAYER"][cMenu] = "RAID_PSPOT";
		end

	end
end



function PartySpotter_CmdLine(pList)
	nList = tonumber(pList);
	if ( nList == nil ) then
		nList = -1;
	end
	pList = string.lower(pList);
	local t2 = string.sub(pList, 1, 2);
	local tCap = string.sub(pList, 4, 4);
	local tRest = string.sub(pList, 5);
	local tName = "";

	if ( ( tCap ) and ( tRest ) ) then
		tCap = string.upper(tCap);
		tName = tCap..tRest;
	end

	if ( ( nList > 0 ) and ( nList < 10.001 ) ) then
		updateInterval = nList;
		PartySpotterSettings.updateInterval = updateInterval;
		DEFAULT_CHAT_FRAME:AddMessage("PartySpotter On : "..updateInterval..PSPOT_DELAY_SUFFIX, PSTOPC.r, PSTOPC.g, PSTOPC.b);

	elseif ( t2 == "-l" ) then
		if ( PartySpotterSettings.showLeader ) then
			PartySpotterSettings.showLeader = nil;
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_LEADER.." "..PSPOT_OFF, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		else
			PartySpotterSettings.showLeader = true;
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_LEADER, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		end

	elseif ( t2 == "-t" ) then
		if ( ( tName ) and ( tName ~= "" ) and ( tName ~= singleOut ) ) then
			singleOut = tName;
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_INDI.." "..singleOut, PSTOPC.r, PSTOPC.g, PSTOPC.b);
			PartySpotter_InitTarget();
		else
			singleOut = "";
			singleUnit = nil;
			PartySpotter_MiniMapTarget:Hide();
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_INDI.." "..PSPOT_OFF, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		end

	elseif ( t2 == "-c" ) then
		if ( PartySpotterSettings.colouredChat ) then
			PartySpotterSettings.colouredChat = false;
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_COLOUR_CHAT.." "..PSPOT_OFF, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		else
			PartySpotterSettings.colouredChat = true;
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_COLOUR_CHAT, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		end

	elseif ( t2 == "-n" ) then
		if ( PartySpotterSettings.numberedChat ) then
			PartySpotterSettings.numberedChat = false;
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_NUMBERED_CHAT.." "..PSPOT_OFF, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		else
			PartySpotterSettings.numberedChat = true;
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_NUMBERED_CHAT, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		end

	elseif ( nList == 0 ) then
		updateInterval = 0;
		PartySpotterSettings.updateInterval = 0;
		DEFAULT_CHAT_FRAME:AddMessage("PartySpotter "..PSPOT_OFF, PSTOPC.r, PSTOPC.g, PSTOPC.b);

	elseif ( pList == "reset" ) then
		PartySpotter_Reset();
		DEFAULT_CHAT_FRAME:AddMessage(PSPOT_HELP_TEXT);
		PartySpotter_ReportStatus();

	elseif ( pList == "showgroups icons" ) then
		PartySpotterSettings.showGroups = "Icons";
		DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_COLOUR_GROUPS, PSTOPC.r, PSTOPC.g, PSTOPC.b);

	elseif ( pList == "showgroups numbers" ) then
		PartySpotterSettings.showGroups = "Numbers";
		DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_NUMBER_GROUPS, PSTOPC.r, PSTOPC.g, PSTOPC.b);

	elseif ( pList == "showgroups off" ) then
		PartySpotterSettings.showGroups = "Nil";
		DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_DFLT_GROUPS, PSTOPC.r, PSTOPC.g, PSTOPC.b);

	elseif ( ( pList == "showfriends" ) or ( pList == "togglefriends" ) ) then
		PartySpotterSettings.showIgnores = nil;
		PartySpotterSettings.showGuild = nil;
		if ( pList == "showfriends" ) then
			if ( PartySpotterSettings.showFriends ) then
				PartySpotterSettings.showFriends = nil;
				DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_SHOW_FRIENDS.." " ..PSPOT_OFF, PSTOPC.r, PSTOPC.g, PSTOPC.b);
			else
				PartySpotterSettings.showFriends = "1";
				DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_SHOW_FRIENDS, PSTOPC.r, PSTOPC.g, PSTOPC.b);
			end
		else
			PartySpotterSettings.showFriends = "1";
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_SHOW_FRIENDS, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		end

	elseif ( ( pList == "showignores" ) or ( pList == "toggleignores" ) ) then
		PartySpotterSettings.showFriends = nil;
		PartySpotterSettings.showGuild = nil;
		if ( pList == "showignores" ) then
			if ( PartySpotterSettings.showIgnores ) then
				PartySpotterSettings.showIgnores = nil;
				DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_SHOW_IGNORES.." " ..PSPOT_OFF, PSTOPC.r, PSTOPC.g, PSTOPC.b);
			else
				PartySpotterSettings.showIgnores = "1";
				DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_SHOW_IGNORES, PSTOPC.r, PSTOPC.g, PSTOPC.b);
			end
		else
			PartySpotterSettings.showIgnores = "1";
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_SHOW_IGNORES, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		end

	elseif ( ( pList == "showguild" ) or ( pList == "toggleguild" ) ) then
		PartySpotterSettings.showFriends = nil;
		PartySpotterSettings.showIgnores = nil;
		if ( pList == "showguild" ) then
			if ( PartySpotterSettings.showGuild ) then
				PartySpotterSettings.showGuild = nil;
				DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_SHOW_GUILD.." " ..PSPOT_OFF, PSTOPC.r, PSTOPC.g, PSTOPC.b);
			else
				PartySpotterSettings.showGuild = "1";
				DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_SHOW_GUILD, PSTOPC.r, PSTOPC.g, PSTOPC.b);
			end
		else
			PartySpotterSettings.showGuild = "1";
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_SHOW_GUILD, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		end

	else
		DEFAULT_CHAT_FRAME:AddMessage(PSPOT_HELP_TEXT);
		PartySpotter_ReportStatus();
		local index = 0;
		local value = getglobal("PSPOT_HELP_TEXT"..index);
		while( value ) do
			DEFAULT_CHAT_FRAME:AddMessage(value);
			index = index + 1;
			value = getglobal("PSPOT_HELP_TEXT"..index);
		end
		DEFAULT_CHAT_FRAME:AddMessage(PSPOT_HELP_TEXT);
	end

	PartySpotter_RaidControl_SetLabels();
	PartySpotter_ManualTrigger();
end

function PartySpotter_ReportStatus()
	if ( PartySpotterSettings.updateInterval > 0 ) then
		DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PartySpotterSettings.updateInterval..PSPOT_DELAY_SUFFIX, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		if ( singleOut == "" ) then
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_INDI.." "..PSPOT_OFF, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		else
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_INDI.." "..singleOut, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		end
		if ( PartySpotterSettings.showLeader ) then
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_LEADER, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		else
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_LEADER.." "..PSPOT_OFF, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		end
		if ( PartySpotterSettings.showFriends ) then
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_SHOW_FRIENDS, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		elseif ( PartySpotterSettings.showIgnores ) then
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_SHOW_IGNORES, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		elseif ( PartySpotterSettings.showGuild ) then
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_SHOW_GUILD, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		else
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_NO_HLIGHTS, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		end
		if ( PartySpotterSettings.showGroups == "Icons" ) then
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_COLOUR_GROUPS, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		elseif ( PartySpotterSettings.showGroups == "Numbers" ) then
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_NUMBER_GROUPS, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		else
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_DFLT_GROUPS, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		end
		if ( PartySpotterSettings.colouredChat == true ) then
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_COLOUR_CHAT, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		else
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_COLOUR_CHAT.." "..PSPOT_OFF, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		end
		if ( PartySpotterSettings.numberedChat == true ) then
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_NUMBERED_CHAT, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		else
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_NUMBERED_CHAT.." "..PSPOT_OFF, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		end
		if ( PartySpotterSettings.showKey == true ) then
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..BINDING_NAME_PSPOT_TOGGLE_KEY.." : "..PSPOT_SHOWING, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		else
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..BINDING_NAME_PSPOT_TOGGLE_KEY.." : "..PSPOT_HIDING, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_OFF, PSTOPC.r, PSTOPC.g, PSTOPC.b);
	end
end



function PartySpotter_OnUpdate(arg1)
	timeSinceLastUpdate = timeSinceLastUpdate + arg1;
	if ( timeSinceLastUpdate > iiInterval ) then
		PartySpotter_UpdateIgnores();
		timeSinceLastUpdate = 0;
	end
	pulloutTimer = pulloutTimer + arg1;
	if ( pulloutTimer > pulloutInterval ) then
		PartySpotter_CheckPulloutNames();
		pulloutTimer = 0;
	end
	if ( singleOut ~= "" ) then
		if ( not singleUnit ) then
			PartySpotter_Update("WorldMap");
		end
		if ( singleUnit ) then
			timeSinceMinimapUpdate = timeSinceMinimapUpdate + arg1;
			if ( timeSinceMinimapUpdate > minimapInterval ) then
				PartySpotter_UpdateMinimapHighlight();
				timeSinceMinimapUpdate = 0;
			end
		end
	elseif ( singleUnit ) then
		singleUnit = nil;
		PartySpotter_MiniMapTarget:Hide();
	else
		PartySpotter_MiniMapTarget:Hide();
	end
end

function PartySpotterWM_OnUpdate(arg1)
	timeSinceLastWMUpdate = timeSinceLastWMUpdate + arg1;
	if ( timeSinceLastWMUpdate > updateInterval ) then
		if ( ( PartySpotterSettings.showKey == true ) and ( not WorldMapPartySpotterKey:IsVisible() ) ) then
			WorldMapPartySpotterKey:Show();
			AlphaMapPartySpotterKey:Show();
		end
		PartySpotter_Update("WorldMap");
		timeSinceLastWMUpdate = 0;
	end
end

function PartySpotterBFM_OnUpdate(arg1)
	timeSinceLastBFMUpdate = timeSinceLastBFMUpdate + arg1;
	if ( timeSinceLastBFMUpdate > updateInterval ) then
		if ( ( PartySpotterSettings.showKey == true ) and ( not AlphaMapPartySpotterKey:IsVisible() ) ) then
			if ( not AlphaMapPartySpotterKey:IsUserPlaced() ) then
				AlphaMapPartySpotterKey:ClearAllPoints();
				AlphaMapPartySpotterKey:SetPoint("RIGHT", "BattlefieldMinimap", "LEFT");
			end
			WorldMapPartySpotterKey:Show();
			AlphaMapPartySpotterKey:Show();
		end
		PartySpotter_Update("BattlefieldMinimap");
		timeSinceLastBFMUpdate = 0;
	end
end

function PartySpotterAM_OnUpdate(arg1)
	timeSinceLastAMUpdate = timeSinceLastAMUpdate + arg1;
	if ( timeSinceLastAMUpdate > updateInterval ) then
		if ( ( PartySpotterSettings.showKey == true ) and ( not AlphaMapPartySpotterKey:IsVisible() ) ) then
			if ( not AlphaMapPartySpotterKey:IsUserPlaced() ) then
				AlphaMapPartySpotterKey:ClearAllPoints();
				AlphaMapPartySpotterKey:SetPoint("BOTTOMRIGHT", "AlphaMapFrame", "BOTTOMLEFT", 0, 112);
			end
			WorldMapPartySpotterKey:Show();
			AlphaMapPartySpotterKey:Show();
		end
		PartySpotter_Update("AlphaMap");
		timeSinceLastAMUpdate = 0;
	end
end

function WorldMapPartySpotterKey_OnUpdate(mKey)
	if ( ( GetNumRaidMembers() == 0 ) and ( GetNumPartyMembers() == 0 ) ) then
		WorldMapPartySpotterKey:Hide();
		AlphaMapPartySpotterKey:Hide();
		return;
	end
	if ( mKey == AlphaMapPartySpotterKey ) then
		if ( ( ( not AlphaMapFrame ) or ( ( AlphaMapFrame ) and ( not AlphaMapFrame:IsVisible() ) ) ) and ( ( not BattlefieldMinimap ) or ( ( BattlefieldMinimap ) and ( not BattlefieldMinimap:IsVisible() ) ) ) ) then
			AlphaMapPartySpotterKey:Hide();
			return;
		end
	end
end



function PartySpotter_KeyButton_OnClick(mouseBttn, id)
	if ( mouseBttn == "LeftButton" ) then
		if ( highlightedGroup > 0 ) then
			local WMBttn = getglobal("WorldMapPartySpotterKeyBttn"..highlightedGroup);
			if ( WMBttn ) then
				WMBttn:UnlockHighlight();
			end
			local AMBttn = getglobal("AlphaMapPartySpotterKeyBttn"..highlightedGroup);
			if ( AMBttn ) then
				AMBttn:UnlockHighlight();
			end
		end
		if ( id == highlightedGroup ) then
			highlightedGroup = 0;
			hRaidA = nil;
		else
			highlightedGroup = id;
			local WMBttn = getglobal("WorldMapPartySpotterKeyBttn"..id);
			if ( WMBttn ) then
				WMBttn:LockHighlight();
			end
			local AMBttn = getglobal("AlphaMapPartySpotterKeyBttn"..id);
			if ( AMBttn ) then
				AMBttn:LockHighlight();
			end
			hRaidA = PartySpotter_RememberHighlighted(highlightedGroup);
		end
		PartySpotter_ManualTrigger();

	elseif ( mouseBttn == "RightButton" ) then
		local pIcon = getglobal( this:GetName() .. "IconsParty" );
		local oIcon = getglobal( this:GetName() .. "IconsOther" );
		if ( ( ( pIcon ) and ( pIcon:IsVisible() ) )   or   ( ( oIcon ) and ( oIcon:IsVisible() ) ) ) then
			local colourRef = id;
			local localGroup = PartySpotter_GetRaidGroup();
			if ( localGroup == id ) then
				colourRef = -1;
			elseif ( PartySpotterSettings.showGroups == "Nil" ) then
				colourRef = 1;
			elseif ( localGroup < id ) then
				colourRef = id - 1;
			end

			PartySpotter_SetUpColourPicker(id, colourRef);
		end
	end
end



function PartySpotter_Update(Map)
	local col;

	PartySpotter_ResetRaidSpots(Map);
	PartySpotter_ResetPartySpots(Map);
	singleUnit = nil;

	if ( PartySpotterSettings.updateInterval == 0 ) then
		WorldMapPartySpotterKey:Hide();
		AlphaMapPartySpotterKey:Hide();
		return;
	end

	-- If not in Raid / Party
	if ( ( GetNumRaidMembers() < 1 ) and ( GetNumPartyMembers() < 1 ) ) then
		WorldMapPartySpotterKey:Hide();
		AlphaMapPartySpotterKey:Hide();
		if ( ( singleOut ~= "" ) or ( PartySpotterSettings.showFriends ) or ( PartySpotterSettings.showIgnores ) or ( PartySpotterSettings.showGuild ) ) then
			for i=1, MAX_PARTY_MEMBERS, 1 do
				local partyIcon = getglobal(Map.."Party"..i);
				if ( ( partyIcon ) and ( partyIcon:IsVisible() ) ) then
					PartySpotter_UpdatePartyHighlight(Map, partyIcon, i);
				end

			end
			for i=1, MAX_RAID_MEMBERS, 1 do
				local raidIcon = getglobal(Map.."Raid"..i);
				if ( ( raidIcon ) and ( raidIcon:IsVisible() ) ) then
					PartySpotter_UpdateRaidHighlight(Map, raidIcon, i);
				end

			end
			return;
		end

	-- Else if In Raid/Party
	else
		-- Fetch Raid Information i.e. which Raid Group is the Player in
		local localGroup = PartySpotter_GetRaidGroup();

		-- Set up the Map Key depending on showing Coloured Icons/Numbers or Hide
		local lMap;
		if ( Map == "WorldMap" ) then
			lMap = Map;
		else
			lMap = "AlphaMap";	-- AlphaMapPartySpotter Key now used for AlphaMap AND BattelfieldMinimap
		end
		local mapKey = getglobal(lMap.."PartySpotterKey");

		if ( ( mapKey ) and ( PartySpotterSettings.showKey == true ) ) then
			for i = 1, MAX_RAID_GROUPINGS, 1 do
				local KeyOther = getglobal(lMap.."PartySpotterKeyBttn"..i.."IconsOther");
				local KeyNumber = getglobal(lMap.."PartySpotterKeyBttn"..i.."IconsNumber");
				local KeyParty = getglobal(lMap.."PartySpotterKeyBttn"..i.."IconsParty");
				if ( ( GetNumRaidMembers() < 1 ) and ( i == 1 ) ) then
					KeyParty:SetTexture(defaultGroupTexture);
					col = PartySpotterSettings.lGroupC;
					KeyParty:SetVertexColor(col.r, col.g, col.b);
					KeyParty:Show();
					KeyOther:Hide();

				elseif ( GetNumRaidMembers() < 1 ) then
					KeyParty:Hide();
					KeyOther:Hide();

				elseif ( i < localGroup ) then
					if ( PartySpotterSettings.showGroups == "Icons" ) then
						KeyOther:SetTexture(defaultGroupTexture);
						col = PartySpotterSettings.groupColours[i];
						KeyOther:SetVertexColor(col.r, col.g, col.b);
						KeyOther:Show();
					elseif ( PartySpotterSettings.showGroups == "Nil" ) then
						KeyOther:SetTexture(defaultGroupTexture);
						col = PartySpotterSettings.groupColours[1];
						KeyOther:SetVertexColor(col.r, col.g, col.b);
						KeyOther:Show();
					else
						KeyOther:Hide();
					end
					KeyParty:Hide();

				elseif ( i > localGroup ) then
					if ( PartySpotterSettings.showGroups == "Icons" ) then
						KeyOther:SetTexture(defaultGroupTexture);
						col = PartySpotterSettings.groupColours[(i-1)];
						KeyOther:SetVertexColor(col.r, col.g, col.b);
						KeyOther:Show();
					elseif ( PartySpotterSettings.showGroups == "Nil" ) then
						KeyOther:SetTexture(defaultGroupTexture);
						col = PartySpotterSettings.groupColours[1];
						KeyOther:SetVertexColor(col.r, col.g, col.b);
						KeyOther:Show();
					else
						KeyOther:Hide();
					end
					KeyParty:Hide();

				else
					KeyParty:SetTexture(defaultGroupTexture);
					col = PartySpotterSettings.lGroupC;
					KeyParty:SetVertexColor(col.r, col.g, col.b);
					KeyParty:Show();
					KeyOther:Hide();
				end
			end
			mapKey:Show();
		end

		if ( GetNumRaidMembers() > 0 ) then
			-- Set Map Icons accordingly
			for i=1, MAX_RAID_MEMBERS, 1 do
				local raidIcon = getglobal(Map.."Raid"..i);
				if ( raidIcon ) then
					local unitHighlighted = nil;
					if ( ( singleOut ~= "" ) or ( PartySpotterSettings.showFriends ) or ( PartySpotterSettings.showIgnores ) or ( PartySpotterSettings.showGuild ) ) then
						unitHighlighted = PartySpotter_UpdateRaidHighlight(Map, raidIcon, i);
					end
					if ( not unitHighlighted ) then
						local spotRaid = getglobal(Map.."SpotRaid"..i);
						if ( raidIcon.name ) then
							spotRaid:Hide();
						else
							local rName, rRank, rSubGroup = GetRaidRosterInfo(i);
							local spotRaidTextureParty = getglobal(Map.."SpotRaid"..i.."PartySpot");
							local spotRaidTextureRaid = getglobal(Map.."SpotRaid"..i.."RaidSpot");
							local gIndex = rSubGroup;
							local raidUnitName;
							local uType = raidIcon.unit;
							if ( ( not uType ) or ( uType == "" ) or ( uType == "unit" ) ) then
								raidUnitName = "~";
							else
								raidUnitName = UnitName(uType);
							end
							if ( ( PartySpotterSettings.showLeader ) and ( rRank == 2 ) ) then
								spotRaidTextureRaid:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotLeader");
								spotRaid:SetFrameLevel( raidIcon:GetFrameLevel() + 4 );
								spotRaidTextureParty:Hide();
								spotRaidTextureRaid:Show();
								spotRaid:Show();
--							elseif ( ( rSubGroup == localGroup ) and ( rSubGroup ~= highlightedGroup ) ) then
							elseif ( rSubGroup == localGroup ) then
								spotRaid:SetFrameLevel( raidIcon:GetFrameLevel() + 3 );
								if ( localGroup == highlightedGroup ) then
									spotRaidTextureRaid:SetTexture(groupNumbers[rSubGroup]);
									spotRaidTextureRaid:SetVertexColor(yellowC.r, yellowC.g, yellowC.b);
								else
									col = PartySpotterSettings.lGroupC;
									spotRaidTextureRaid:SetTexture(defaultGroupTexture);
									spotRaidTextureRaid:SetVertexColor(col.r, col.g, col.b);
								end
								spotRaidTextureRaid:Show();
								spotRaidTextureParty:Hide();
								spotRaid:Show();
							else
								if ( PartySpotterSettings.showGroups == "Icons" ) then
									if ( rSubGroup > localGroup ) then
										rSubGroup = rSubGroup - 1;
									end
									spotRaidTextureRaid:SetTexture(defaultGroupTexture);
									col = PartySpotterSettings.groupColours[rSubGroup];
									spotRaidTextureRaid:SetVertexColor(col.r, col.g, col.b);
								elseif ( PartySpotterSettings.showGroups == "Numbers" ) then
									spotRaidTextureRaid:SetTexture(groupNumbers[rSubGroup]);
									spotRaidTextureRaid:SetVertexColor(yellowC.r, yellowC.g, yellowC.b);
								else
									col = PartySpotterSettings.groupColours[1];
									spotRaidTextureRaid:SetTexture(defaultGroupTexture);
									spotRaidTextureRaid:SetVertexColor(col.r, col.g, col.b);
								end

								spotRaidTextureParty:Hide();

								if ( ( highlightedGroup > 0 ) and ( gIndex ~= highlightedGroup ) ) then
--									spotRaid:Hide();
									spotRaidTextureRaid:Hide();
									spotRaid:Show();
								elseif ( gIndex == highlightedGroup ) then
									spotRaidTextureRaid:SetTexture(groupNumbers[gIndex]);
									spotRaidTextureRaid:SetVertexColor(yellowC.r, yellowC.g, yellowC.b);
									spotRaidTextureRaid:Show();
									spotRaid:Show();
									spotRaid:SetFrameLevel( raidIcon:GetFrameLevel() + 4 );
								else
									spotRaidTextureRaid:Show();
									spotRaid:Show();
									spotRaid:SetFrameLevel( raidIcon:GetFrameLevel() + 1 );
								end
							end
						end
					end
				end
			end

		-- Else in a Party
		else
			for i = 1, MAX_PARTY_MEMBERS, 1 do
				local partyIcon = getglobal(Map.."Party"..i);
				if ( partyIcon ) then
					local unitHighlighted = nil;
					if ( ( singleOut ~= "" ) or ( PartySpotterSettings.showFriends ) or ( PartySpotterSettings.showIgnores ) or ( PartySpotterSettings.showGuild ) ) then
						unitHighlighted = PartySpotter_UpdatePartyHighlight(Map, partyIcon, i);
					end
					if ( not unitHighlighted ) then
						local spotParty = getglobal(Map.."SpotParty"..i);
						local spotPartyIcon = getglobal(Map.."SpotParty"..i.."PartySpot");
						spotParty:SetFrameLevel( partyIcon:GetFrameLevel() + 3 );
						col = PartySpotterSettings.lGroupC;
						spotPartyIcon:SetTexture(defaultGroupTexture);
						spotPartyIcon:SetVertexColor(col.r, col.g, col.b);
						spotPartyIcon:Show();
						spotParty:Show();
					end
				end
			end
		end
	end

	PartySpotter_RaidControl_SetLabels();
end



function PartySpotter_ResetRaidSpots(Map)
	for i=1, MAX_RAID_MEMBERS, 1 do
		local raidIcon = getglobal(Map.."Raid"..i);
		if ( ( raidIcon ) and ( raidIcon:IsVisible() ) ) then
			local spotRaid = getglobal(Map.."SpotRaid"..i);
			if ( spotRaid ) then
				spotRaid:SetFrameLevel( raidIcon:GetFrameLevel() + 1 );
				spotRaid:Hide();
			end
		else
			return;
		end
	end
end

function PartySpotter_ResetPartySpots(Map)
	for i=1, MAX_PARTY_MEMBERS, 1 do
		local partyIcon = getglobal(Map.."Party"..i);
		if ( ( partyIcon ) and ( partyIcon:IsVisible() ) ) then
			local spotParty = getglobal(Map.."SpotParty"..i);
			if ( spotParty ) then
				spotParty:SetFrameLevel( partyIcon:GetFrameLevel() + 1 );
				spotParty:Hide();
			end
		else
			return;
		end
	end
end



function PartySpotter_UpdateRaidHighlight(Map, raidIcon, raidIndex)
	local unitHighlighted = nil;
	local rName, spotRaid, spotRaidTextureParty, spotRaidTextureRaid;

	-- Fetch raid member name. Different method depending on whether a 'real' Raid member, or just a 'Battleground' member
	--  (Differences may no longer exist after patch 1.12, but still seems to work so left unchanged)
	rName = PartySpotter_GetIconName(raidIcon);
	if ( not rName ) then
		return nil;
	end

	-- If that player specifically targetted with /pspot -t <player name> slash command (or new targetting options)
	if ( rName == singleOut ) then
		spotRaid = getglobal(Map.."SpotRaid"..raidIndex);
		spotRaidTextureParty = getglobal(Map.."SpotRaid"..raidIndex.."PartySpot");
		spotRaidTextureRaid = getglobal(Map.."SpotRaid"..raidIndex.."RaidSpot");
		spotRaidTextureParty:Hide();
		spotRaidTextureRaid:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotTarget");
		spotRaidTextureRaid:SetVertexColor(1.0, 1.0, 1.0);
		spotRaid:SetFrameLevel( raidIcon:GetFrameLevel() + 4 );
		spotRaidTextureRaid:Show();
		spotRaid:Show();
		unitHighlighted = true;
		singleUnit = "raid"..raidIndex;

	elseif ( PartySpotterSettings.showFriends ) then
		if ( numberOfFriends == 0 ) then
			PartySpotter_UpdateFriends();
		end
		if ( friendA[rName] ) then
			spotRaid = getglobal(Map.."SpotRaid"..raidIndex);
			spotRaidTextureParty = getglobal(Map.."SpotRaid"..raidIndex.."PartySpot");
			spotRaidTextureRaid = getglobal(Map.."SpotRaid"..raidIndex.."RaidSpot");
			spotRaidTextureParty:Hide();
			spotRaidTextureRaid:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotFriend");
			spotRaidTextureRaid:SetVertexColor(1.0, 1.0, 1.0);
			spotRaid:SetFrameLevel( raidIcon:GetFrameLevel() + 3 );
			spotRaidTextureRaid:Show();
			spotRaid:Show();
			unitHighlighted = true;
		end

	elseif ( PartySpotterSettings.showIgnores ) then
		if ( ignoreA[rName] ) then
			spotRaid = getglobal(Map.."SpotRaid"..raidIndex);
			spotRaidTextureParty = getglobal(Map.."SpotRaid"..raidIndex.."PartySpot");
			spotRaidTextureRaid = getglobal(Map.."SpotRaid"..raidIndex.."RaidSpot");
			spotRaidTextureParty:Hide();
			spotRaidTextureRaid:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotIgnore");
			spotRaidTextureRaid:SetVertexColor(1.0, 1.0, 1.0);
			spotRaid:SetFrameLevel( raidIcon:GetFrameLevel() + 3 );
			spotRaidTextureRaid:Show();
			spotRaid:Show();
			unitHighlighted = true;
		end

	elseif ( PartySpotterSettings.showGuild ) then
		if ( numberOfGuildMembers == 0 ) then
			PartySpotter_UpdateGuild();
		end
		if ( guildA[rName] ) then
			spotRaid = getglobal(Map.."SpotRaid"..raidIndex);
			spotRaidTextureParty = getglobal(Map.."SpotRaid"..raidIndex.."PartySpot");
			spotRaidTextureRaid = getglobal(Map.."SpotRaid"..raidIndex.."RaidSpot");
			spotRaidTextureParty:Hide();
			spotRaidTextureRaid:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGuild");
			spotRaidTextureRaid:SetVertexColor(1.0, 1.0, 1.0);
			spotRaid:SetFrameLevel( raidIcon:GetFrameLevel() + 3 );
			spotRaidTextureRaid:Show();
			spotRaid:Show();
			unitHighlighted = true;
		end
	end

	return unitHighlighted;
end

function PartySpotter_UpdatePartyHighlight(Map, partyIcon, partyIndex)
	local unitHighlighted = nil;
	local spotParty, spotPartyTextureParty, spotPartyTextureRaid;
	local rName = PartySpotter_GetIconName(partyIcon);

	if ( not rName ) then
		return nil;
	end

	if ( rName == singleOut ) then
		spotParty = getglobal(Map.."SpotParty"..partyIndex);
		spotPartyTextureParty = getglobal(Map.."SpotParty"..partyIndex.."PartySpot");
		spotPartyTextureRaid = getglobal(Map.."SpotParty"..partyIndex.."RaidSpot");
		spotPartyTextureRaid:Hide();
		spotPartyTextureParty:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotTarget");
		spotPartyTextureParty:SetVertexColor(1.0, 1.0, 1.0);
		spotParty:SetFrameLevel( partyIcon:GetFrameLevel() + 4 );
		spotPartyTextureParty:Show();
		spotParty:Show();
		unitHighlighted = true;
		singleUnit = "party"..partyIndex;

	elseif ( PartySpotterSettings.showFriends ) then
		if ( numberOfFriends == 0 ) then
			PartySpotter_UpdateFriends();
		end
		if ( friendA[rName] ) then
			spotParty = getglobal(Map.."SpotParty"..partyIndex);
			spotPartyTextureParty = getglobal(Map.."SpotParty"..partyIndex.."PartySpot");
			spotPartyTextureRaid = getglobal(Map.."SpotParty"..partyIndex.."RaidSpot");
			spotPartyTextureRaid:Hide();
			spotPartyTextureParty:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotFriend");
			spotPartyTextureParty:SetVertexColor(1.0, 1.0, 1.0);
			spotParty:SetFrameLevel( partyIcon:GetFrameLevel() + 3 );
			spotPartyTextureParty:Show();
			spotParty:Show();
			unitHighlighted = true;
		end

	elseif ( PartySpotterSettings.showIgnores ) then
		if ( ignoreA[rName] ) then
			spotParty = getglobal(Map.."SpotParty"..partyIndex);
			spotPartyTextureParty = getglobal(Map.."SpotParty"..partyIndex.."PartySpot");
			spotPartyTextureRaid = getglobal(Map.."SpotParty"..partyIndex.."RaidSpot");
			spotPartyTextureRaid:Hide();
			spotPartyTextureParty:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotIgnore");
			spotPartyTextureParty:SetVertexColor(1.0, 1.0, 1.0);
			spotParty:SetFrameLevel( partyIcon:GetFrameLevel() + 3 );
			spotPartyTextureParty:Show();
			spotParty:Show();
			unitHighlighted = true;
		end

	elseif ( PartySpotterSettings.showGuild ) then
		if ( numberOfGuildMembers == 0 ) then
			PartySpotter_UpdateGuild();
		end
		if ( guildA[rName] ) then
			spotParty = getglobal(Map.."SpotParty"..partyIndex);
			spotPartyTextureParty = getglobal(Map.."SpotParty"..partyIndex.."PartySpot");
			spotPartyTextureRaid = getglobal(Map.."SpotParty"..partyIndex.."RaidSpot");
			spotPartyTextureRaid:Hide();
			spotPartyTextureParty:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGuild");
			spotPartyTextureParty:SetVertexColor(1.0, 1.0, 1.0);
			spotParty:SetFrameLevel( partyIcon:GetFrameLevel() + 3 );
			spotPartyTextureParty:Show();
			spotParty:Show();
			unitHighlighted = true;
		end
	end

	return unitHighlighted;
end



function PartySpotter_GetIconName(unitIcon)
	local rName;

	if ( unitIcon.name ) then
		rName = unitIcon.name;
	else
		local uType = unitIcon.unit;
		if ( ( uType == nil ) or ( uType == "" ) or ( uType == "unit" ) ) then
			return nil;
		end
		rName = UnitName(uType);
	end

	return rName;
end



function PartySpotter_LoadBFM()
	PartySpotterBFM:SetParent(BattlefieldMinimap);
	BattlefieldMinimapSpotParty1:SetParent(BattlefieldMinimapParty1);
	BattlefieldMinimapSpotParty2:SetParent(BattlefieldMinimapParty2);
	BattlefieldMinimapSpotParty3:SetParent(BattlefieldMinimapParty3);
	BattlefieldMinimapSpotParty4:SetParent(BattlefieldMinimapParty4);
	BattlefieldMinimapSpotRaid1:SetParent(BattlefieldMinimapRaid1);
	BattlefieldMinimapSpotRaid2:SetParent(BattlefieldMinimapRaid2);
	BattlefieldMinimapSpotRaid3:SetParent(BattlefieldMinimapRaid3);
	BattlefieldMinimapSpotRaid4:SetParent(BattlefieldMinimapRaid4);
	BattlefieldMinimapSpotRaid5:SetParent(BattlefieldMinimapRaid5);
	BattlefieldMinimapSpotRaid6:SetParent(BattlefieldMinimapRaid6);
	BattlefieldMinimapSpotRaid7:SetParent(BattlefieldMinimapRaid7);
	BattlefieldMinimapSpotRaid8:SetParent(BattlefieldMinimapRaid8);
	BattlefieldMinimapSpotRaid9:SetParent(BattlefieldMinimapRaid9);
	BattlefieldMinimapSpotRaid10:SetParent(BattlefieldMinimapRaid10);
	BattlefieldMinimapSpotRaid11:SetParent(BattlefieldMinimapRaid11);
	BattlefieldMinimapSpotRaid12:SetParent(BattlefieldMinimapRaid12);
	BattlefieldMinimapSpotRaid13:SetParent(BattlefieldMinimapRaid13);
	BattlefieldMinimapSpotRaid14:SetParent(BattlefieldMinimapRaid14);
	BattlefieldMinimapSpotRaid15:SetParent(BattlefieldMinimapRaid15);
	BattlefieldMinimapSpotRaid16:SetParent(BattlefieldMinimapRaid16);
	BattlefieldMinimapSpotRaid17:SetParent(BattlefieldMinimapRaid17);
	BattlefieldMinimapSpotRaid18:SetParent(BattlefieldMinimapRaid18);
	BattlefieldMinimapSpotRaid19:SetParent(BattlefieldMinimapRaid19);
	BattlefieldMinimapSpotRaid20:SetParent(BattlefieldMinimapRaid20);
	BattlefieldMinimapSpotRaid21:SetParent(BattlefieldMinimapRaid21);
	BattlefieldMinimapSpotRaid22:SetParent(BattlefieldMinimapRaid22);
	BattlefieldMinimapSpotRaid23:SetParent(BattlefieldMinimapRaid23);
	BattlefieldMinimapSpotRaid24:SetParent(BattlefieldMinimapRaid24);
	BattlefieldMinimapSpotRaid25:SetParent(BattlefieldMinimapRaid25);
	BattlefieldMinimapSpotRaid26:SetParent(BattlefieldMinimapRaid26);
	BattlefieldMinimapSpotRaid27:SetParent(BattlefieldMinimapRaid27);
	BattlefieldMinimapSpotRaid28:SetParent(BattlefieldMinimapRaid28);
	BattlefieldMinimapSpotRaid29:SetParent(BattlefieldMinimapRaid29);
	BattlefieldMinimapSpotRaid30:SetParent(BattlefieldMinimapRaid30);
	BattlefieldMinimapSpotRaid31:SetParent(BattlefieldMinimapRaid31);
	BattlefieldMinimapSpotRaid32:SetParent(BattlefieldMinimapRaid32);
	BattlefieldMinimapSpotRaid33:SetParent(BattlefieldMinimapRaid33);
	BattlefieldMinimapSpotRaid34:SetParent(BattlefieldMinimapRaid34);
	BattlefieldMinimapSpotRaid35:SetParent(BattlefieldMinimapRaid35);
	BattlefieldMinimapSpotRaid36:SetParent(BattlefieldMinimapRaid36);
	BattlefieldMinimapSpotRaid37:SetParent(BattlefieldMinimapRaid37);
	BattlefieldMinimapSpotRaid38:SetParent(BattlefieldMinimapRaid38);
	BattlefieldMinimapSpotRaid39:SetParent(BattlefieldMinimapRaid39);
	BattlefieldMinimapSpotRaid40:SetParent(BattlefieldMinimapRaid40);
	BattlefieldMinimapSpotParty1:SetPoint("CENTER", "BattlefieldMinimapParty1", "CENTER", 0, 0);
	BattlefieldMinimapSpotParty2:SetPoint("CENTER", "BattlefieldMinimapParty2", "CENTER", 0, 0);
	BattlefieldMinimapSpotParty3:SetPoint("CENTER", "BattlefieldMinimapParty3", "CENTER", 0, 0);
	BattlefieldMinimapSpotParty4:SetPoint("CENTER", "BattlefieldMinimapParty4", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid1:SetPoint("CENTER", "BattlefieldMinimapRaid1", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid2:SetPoint("CENTER", "BattlefieldMinimapRaid2", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid3:SetPoint("CENTER", "BattlefieldMinimapRaid3", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid4:SetPoint("CENTER", "BattlefieldMinimapRaid4", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid5:SetPoint("CENTER", "BattlefieldMinimapRaid5", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid6:SetPoint("CENTER", "BattlefieldMinimapRaid6", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid7:SetPoint("CENTER", "BattlefieldMinimapRaid7", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid8:SetPoint("CENTER", "BattlefieldMinimapRaid8", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid9:SetPoint("CENTER", "BattlefieldMinimapRaid9", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid10:SetPoint("CENTER", "BattlefieldMinimapRaid10", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid11:SetPoint("CENTER", "BattlefieldMinimapRaid11", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid12:SetPoint("CENTER", "BattlefieldMinimapRaid12", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid13:SetPoint("CENTER", "BattlefieldMinimapRaid13", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid14:SetPoint("CENTER", "BattlefieldMinimapRaid14", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid15:SetPoint("CENTER", "BattlefieldMinimapRaid15", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid16:SetPoint("CENTER", "BattlefieldMinimapRaid16", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid17:SetPoint("CENTER", "BattlefieldMinimapRaid17", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid18:SetPoint("CENTER", "BattlefieldMinimapRaid18", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid19:SetPoint("CENTER", "BattlefieldMinimapRaid19", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid20:SetPoint("CENTER", "BattlefieldMinimapRaid20", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid21:SetPoint("CENTER", "BattlefieldMinimapRaid21", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid22:SetPoint("CENTER", "BattlefieldMinimapRaid22", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid23:SetPoint("CENTER", "BattlefieldMinimapRaid23", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid24:SetPoint("CENTER", "BattlefieldMinimapRaid24", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid25:SetPoint("CENTER", "BattlefieldMinimapRaid25", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid26:SetPoint("CENTER", "BattlefieldMinimapRaid26", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid27:SetPoint("CENTER", "BattlefieldMinimapRaid27", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid28:SetPoint("CENTER", "BattlefieldMinimapRaid28", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid29:SetPoint("CENTER", "BattlefieldMinimapRaid29", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid30:SetPoint("CENTER", "BattlefieldMinimapRaid30", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid31:SetPoint("CENTER", "BattlefieldMinimapRaid31", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid32:SetPoint("CENTER", "BattlefieldMinimapRaid32", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid33:SetPoint("CENTER", "BattlefieldMinimapRaid33", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid34:SetPoint("CENTER", "BattlefieldMinimapRaid34", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid35:SetPoint("CENTER", "BattlefieldMinimapRaid35", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid36:SetPoint("CENTER", "BattlefieldMinimapRaid36", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid37:SetPoint("CENTER", "BattlefieldMinimapRaid37", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid38:SetPoint("CENTER", "BattlefieldMinimapRaid38", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid39:SetPoint("CENTER", "BattlefieldMinimapRaid39", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid40:SetPoint("CENTER", "BattlefieldMinimapRaid40", "CENTER", 0, 0);
	BattlefieldMinimapSpotParty1:SetFrameLevel( BattlefieldMinimapParty1:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotParty2:SetFrameLevel( BattlefieldMinimapParty2:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotParty3:SetFrameLevel( BattlefieldMinimapParty3:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotParty4:SetFrameLevel( BattlefieldMinimapParty4:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid1:SetFrameLevel( BattlefieldMinimapRaid1:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid2:SetFrameLevel( BattlefieldMinimapRaid2:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid3:SetFrameLevel( BattlefieldMinimapRaid3:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid4:SetFrameLevel( BattlefieldMinimapRaid4:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid5:SetFrameLevel( BattlefieldMinimapRaid5:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid6:SetFrameLevel( BattlefieldMinimapRaid6:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid7:SetFrameLevel( BattlefieldMinimapRaid7:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid8:SetFrameLevel( BattlefieldMinimapRaid8:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid9:SetFrameLevel( BattlefieldMinimapRaid9:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid10:SetFrameLevel( BattlefieldMinimapRaid10:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid11:SetFrameLevel( BattlefieldMinimapRaid11:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid12:SetFrameLevel( BattlefieldMinimapRaid12:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid13:SetFrameLevel( BattlefieldMinimapRaid13:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid14:SetFrameLevel( BattlefieldMinimapRaid14:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid15:SetFrameLevel( BattlefieldMinimapRaid15:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid16:SetFrameLevel( BattlefieldMinimapRaid16:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid17:SetFrameLevel( BattlefieldMinimapRaid17:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid18:SetFrameLevel( BattlefieldMinimapRaid18:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid19:SetFrameLevel( BattlefieldMinimapRaid19:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid20:SetFrameLevel( BattlefieldMinimapRaid20:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid21:SetFrameLevel( BattlefieldMinimapRaid21:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid22:SetFrameLevel( BattlefieldMinimapRaid22:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid23:SetFrameLevel( BattlefieldMinimapRaid23:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid24:SetFrameLevel( BattlefieldMinimapRaid24:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid25:SetFrameLevel( BattlefieldMinimapRaid25:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid26:SetFrameLevel( BattlefieldMinimapRaid26:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid27:SetFrameLevel( BattlefieldMinimapRaid27:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid28:SetFrameLevel( BattlefieldMinimapRaid28:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid29:SetFrameLevel( BattlefieldMinimapRaid29:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid30:SetFrameLevel( BattlefieldMinimapRaid30:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid31:SetFrameLevel( BattlefieldMinimapRaid31:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid32:SetFrameLevel( BattlefieldMinimapRaid32:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid33:SetFrameLevel( BattlefieldMinimapRaid33:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid34:SetFrameLevel( BattlefieldMinimapRaid34:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid35:SetFrameLevel( BattlefieldMinimapRaid35:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid36:SetFrameLevel( BattlefieldMinimapRaid36:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid37:SetFrameLevel( BattlefieldMinimapRaid37:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid38:SetFrameLevel( BattlefieldMinimapRaid38:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid39:SetFrameLevel( BattlefieldMinimapRaid39:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid40:SetFrameLevel( BattlefieldMinimapRaid40:GetFrameLevel() + 1 );

	BattlefieldMinimapSpotParty1:SetScale(0.6);
	BattlefieldMinimapSpotParty2:SetScale(0.6);
	BattlefieldMinimapSpotParty3:SetScale(0.6);
	BattlefieldMinimapSpotParty4:SetScale(0.6);
	BattlefieldMinimapSpotRaid1:SetScale(0.6);
	BattlefieldMinimapSpotRaid2:SetScale(0.6);
	BattlefieldMinimapSpotRaid3:SetScale(0.6);
	BattlefieldMinimapSpotRaid4:SetScale(0.6);
	BattlefieldMinimapSpotRaid5:SetScale(0.6);
	BattlefieldMinimapSpotRaid6:SetScale(0.6);
	BattlefieldMinimapSpotRaid7:SetScale(0.6);
	BattlefieldMinimapSpotRaid8:SetScale(0.6);
	BattlefieldMinimapSpotRaid9:SetScale(0.6);
	BattlefieldMinimapSpotRaid10:SetScale(0.6);
	BattlefieldMinimapSpotRaid11:SetScale(0.6);
	BattlefieldMinimapSpotRaid12:SetScale(0.6);
	BattlefieldMinimapSpotRaid13:SetScale(0.6);
	BattlefieldMinimapSpotRaid14:SetScale(0.6);
	BattlefieldMinimapSpotRaid15:SetScale(0.6);
	BattlefieldMinimapSpotRaid16:SetScale(0.6);
	BattlefieldMinimapSpotRaid17:SetScale(0.6);
	BattlefieldMinimapSpotRaid18:SetScale(0.6);
	BattlefieldMinimapSpotRaid19:SetScale(0.6);
	BattlefieldMinimapSpotRaid20:SetScale(0.6);
	BattlefieldMinimapSpotRaid21:SetScale(0.6);
	BattlefieldMinimapSpotRaid22:SetScale(0.6);
	BattlefieldMinimapSpotRaid23:SetScale(0.6);
	BattlefieldMinimapSpotRaid24:SetScale(0.6);
	BattlefieldMinimapSpotRaid25:SetScale(0.6);
	BattlefieldMinimapSpotRaid26:SetScale(0.6);
	BattlefieldMinimapSpotRaid27:SetScale(0.6);
	BattlefieldMinimapSpotRaid28:SetScale(0.6);
	BattlefieldMinimapSpotRaid29:SetScale(0.6);
	BattlefieldMinimapSpotRaid30:SetScale(0.6);
	BattlefieldMinimapSpotRaid31:SetScale(0.6);
	BattlefieldMinimapSpotRaid32:SetScale(0.6);
	BattlefieldMinimapSpotRaid33:SetScale(0.6);
	BattlefieldMinimapSpotRaid34:SetScale(0.6);
	BattlefieldMinimapSpotRaid35:SetScale(0.6);
	BattlefieldMinimapSpotRaid36:SetScale(0.6);
	BattlefieldMinimapSpotRaid37:SetScale(0.6);
	BattlefieldMinimapSpotRaid38:SetScale(0.6);
	BattlefieldMinimapSpotRaid39:SetScale(0.6);
	BattlefieldMinimapSpotRaid40:SetScale(0.6);

	PartySpotterBFM:Show();
	PartySpotter_ManualTrigger();
end

function PartySpotter_LoadRaidFrame()
	PartySpotter_RaidControl:SetParent( RaidFrame );
end

function PartySpotter_RaidControl_SetLabels()
	if ( ( GetNumRaidMembers() > 0 ) and ( PartySpotterSettings.lGroupC ) ) then
		local localGroup = PartySpotter_GetRaidGroup();

		local pulloutArray = {};
		local pullout;
		if ( NUM_RAID_PULLOUT_FRAMES ) then
			for i=1, NUM_RAID_PULLOUT_FRAMES, 1 do
				pullout = getglobal("RaidPullout"..i);
				if ( pullout ) then
					pulloutArray[pullout.filterID] = pullout;
				else
					break;
				end
			end
		end

		for i=1, MAX_RAID_GROUPINGS, 1 do
			local col = { r = 1.0, g = 0.9, b = 0.3 };
			if ( PartySpotterSettings.showGroups == "Icons" ) then
				if ( i < localGroup ) then
					col = PartySpotterSettings.groupColours[i];
				elseif ( i > localGroup ) then
					col = PartySpotterSettings.groupColours[i-1];
				else
					col = PartySpotterSettings.lGroupC;
				end
			end
			if ( col ) then
				PartySpotter_SetRaidLabelColour(i, col.r, col.g, col.b);
				if ( pulloutArray[i] ) then
					pullout = pulloutArray[i];
					getglobal(pullout:GetName().."Name"):SetTextColor(col.r, col.g, col.b);
				end
			end
		end
	end
end



function PartySpotter_UpdateFriends()
	friendA = {};
	numberOfFriends = 0;
	for i = 1, GetNumFriends(), 1 do
		local fName = GetFriendInfo(i);
		if ( ( fName ) and ( fName ~= "" ) ) then
			friendA[fName] = "1";
			numberOfFriends = numberOfFriends + 1;
		end
	end
end

function PartySpotter_UpdateIgnores()
	ignoreA = {};
	for i = 1, GetNumIgnores(), 1 do
		local iName = GetIgnoreName(i);
		if ( ( iName ) and ( iName ~= "" ) ) then
			ignoreA[iName] = "1";
		end
	end
	local pKey = GetCVar("realmName");
	if ( ( InfinateIgnore_Config ) and ( InfinateIgnore_Config[pKey] ) and ( InfinateIgnore_Config[pKey].Ignoring ) ) then
		local index, value;
		for index, value in InfinateIgnore_Config[pKey].Ignoring do
			local formattedCap = string.upper( string.sub(index, 1, 1) );
			local formattedRest = string.sub(index, 2, -1);
			local formattedName = formattedCap..formattedRest;
			ignoreA[formattedName] = "1";
		end
	end
end

function PartySpotter_UpdateGuild()
	if ( GetGuildInfo("player") ) then
		GuildRoster();
		guildA = {};
		numberOfGuildMembers = 0;
		for i = 1, GetNumGuildMembers(), 1 do
			local gName = GetGuildRosterInfo(i);
			if ( ( gName ) and ( gName ~= "" ) ) then
				guildA[gName] = "1";
				numberOfGuildMembers = numberOfGuildMembers + 1;
			end
		end
	end
end



function PartySpotter_Cycle_Mode()
	if ( PartySpotterSettings.showGroups == "Icons" ) then
		PartySpotter_CmdLine("showgroups off");
	elseif ( PartySpotterSettings.showGroups == "Numbers" ) then
		PartySpotter_CmdLine("showgroups icons");
	else
		PartySpotter_CmdLine("showgroups numbers");
	end
end

function PartySpotter_Cycle_Highlight()
	if ( PartySpotterSettings.showFriends ) then
		PartySpotter_CmdLine("toggleignores");
	elseif ( PartySpotterSettings.showIgnores ) then
		PartySpotter_CmdLine("toggleguild");
	elseif ( PartySpotterSettings.showGuild ) then
		PartySpotter_CmdLine("showguild");
	else
		PartySpotter_CmdLine("togglefriends");
	end
end





function PartySpotter_Reset()
	PartySpotterSettings.updateInterval = PSTOP_DEFAULT_INTERVAL;
	PartySpotterSettings.showGroups = "Numbers";
	PartySpotterSettings.showFriends = nil;
	PartySpotterSettings.showIgnores = nil;
	PartySpotterSettings.showGuild = nil;
	PartySpotterSettings.showLeader = nil;
	singleOut = "";
	singleUnit = nil;
	PartySpotter_MiniMapTarget:Hide();
	if ( highlightedGroup > 0 ) then
		local dummyBttn = "LeftButton";
		PartySpotter_KeyButton_OnClick(dummyBttn, highlightedGroup);
	end

	PartySpotterSettings.showKey = true;
	PartySpotterSettings.groupColours = defaultGroupColourCodes;
	PartySpotterSettings.lGroupC = lGroupC;
	PartySpotterSettings.colouredChat = true;
	PartySpotterSettings.numberedChat = true;

	PartySpotterSettings.wmKeyLocX = PS_wmDefaultCoordsX;
	PartySpotterSettings.wmKeyLocY = PS_wmDefaultCoordsY;
	PartySpotter_SetwmKeyPos();

	if ( AlphaMapFrame ) then
		AlphaMapPartySpotterKey:SetUserPlaced(0);
		AlphaMapPartySpotterKey:ClearAllPoints();
		AlphaMapPartySpotterKey:SetPoint("BOTTOMRIGHT", AlphaMapFrame, "BOTTOMRIGHT", 0, 0);
	end

	PartySpotter_ManualTrigger();
end


function PartySpotter_ToggleKey()
	if ( PartySpotterSettings.showKey == false ) then
		PartySpotterSettings.showKey = true;
		PartySpotter_ManualTrigger();
		DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..BINDING_NAME_PSPOT_TOGGLE_KEY.." : "..PSPOT_SHOWING, PSTOPC.r, PSTOPC.g, PSTOPC.b);
	else
		WorldMapPartySpotterKey:Hide();
		AlphaMapPartySpotterKey:Hide();
		PartySpotterSettings.showKey = false;
		DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..BINDING_NAME_PSPOT_TOGGLE_KEY.." : "..PSPOT_HIDING, PSTOPC.r, PSTOPC.g, PSTOPC.b);
	end
end


function PartySpotter_SetUpColourPicker(id, colourRef)
	local col;

	ColorPickerFrame.bttnId = id;
	ColorPickerFrame.colourRef = colourRef;
	ColorPickerFrame.hasOpacity = false;
	ColorPickerFrame.func = PartySpotter_AcceptColour;
	ColorPickerFrame.cancelFunc = PartySpotter_CancelColourPicker;
	if ( colourRef == -1 ) then
		col = PartySpotterSettings.lGroupC;
	else
		col = PartySpotterSettings.groupColours[colourRef];
	end
	ColorPickerFrame.previousValues = {col.r, col.g, col.b};
	ColorPickerFrame:SetFrameStrata("FULLSCREEN_DIALOG");
	ColorPickerFrame.opacity = 1.0;
	ColorPickerFrame:SetColorRGB(col.r, col.g, col.b);
	ColorPickerFrame:Show();
end

function PartySpotter_AcceptColour()
	local red, green, blue = ColorPickerFrame:GetColorRGB();
	PartySpotter_UpdateKeyButtonColour(ColorPickerFrame.bttnId, ColorPickerFrame.colourRef, red, green, blue);
end

function PartySpotter_CancelColourPicker(prevColors)
	local red, green, blue = unpack(prevColors);
	PartySpotter_UpdateKeyButtonColour(ColorPickerFrame.bttnId, ColorPickerFrame.colourRef, red, green, blue);

	ColorPickerFrame.bttnId = nil;
end

function PartySpotter_UpdateKeyButtonColour(id, colourRef, red, green, blue)
	if ( colourRef == -1 ) then
		PartySpotterSettings.lGroupC.r = red;
		PartySpotterSettings.lGroupC.g = green;
		PartySpotterSettings.lGroupC.b = blue;

		local bttnTexture = getglobal("WorldMapPartySpotterKeyBttn"..id.."IconsParty");
		bttnTexture:SetTexture(defaultGroupTexture);
		bttnTexture:SetVertexColor(red, green, blue);

		bttnTexture = getglobal("AlphaMapPartySpotterKeyBttn"..id.."IconsParty");
		bttnTexture:SetTexture(defaultGroupTexture);
		bttnTexture:SetVertexColor(red, green, blue);

	else
		PartySpotterSettings.groupColours[colourRef].r = red;
		PartySpotterSettings.groupColours[colourRef].g = green;
		PartySpotterSettings.groupColours[colourRef].b = blue;

		local bttnTexture = getglobal("WorldMapPartySpotterKeyBttn"..id.."IconsOther");
		bttnTexture:SetTexture(defaultGroupTexture);
		bttnTexture:SetVertexColor(red, green, blue);

		bttnTexture = getglobal("AlphaMapPartySpotterKeyBttn"..id.."IconsOther");
		bttnTexture:SetTexture(defaultGroupTexture);
		bttnTexture:SetVertexColor(red, green, blue);
	end

	PartySpotter_SetRaidLabelColour(id, red, green, blue);
	PartySpotter_ManualTrigger();
end

function PartySpotter_SetRaidLabelColour(id, red, green, blue)
	local raidLabel = getglobal("RaidGroup"..id.."Label");
	if ( raidLabel ) then
		raidLabel:SetTextColor(red, green, blue);
	end
end

function PartySpotter_CheckPulloutNames()
	local localGroup = PartySpotter_GetRaidGroup();
	local colRef;

	if ( NUM_RAID_PULLOUT_FRAMES ) then
		for i=1, NUM_RAID_PULLOUT_FRAMES, 1 do
			local col = { r = 1.0, g = 0.9, b = 0.3 };
			frame = getglobal("RaidPullout"..i);
			if ( ( type(frame.filterID) == "number" ) and ( frame:IsVisible() ) ) then
				if ( PartySpotterSettings.showGroups == "Icons" ) then
					colRef = frame.filterID;
					if ( colRef == localGroup ) then
						col = PartySpotterSettings.lGroupC;
					elseif ( colRef > localGroup ) then
						colRef = colRef - 1;
						col = PartySpotterSettings.groupColours[colRef];
					else
						col = PartySpotterSettings.groupColours[colRef];
					end
				end
			end
			getglobal("RaidPullout"..i.."Name"):SetTextColor(col.r, col.g, col.b);
		end
	end
end

function PartySpotter_SetPulloutLabelColour(id, red, green, blue)
	if ( NUM_RAID_PULLOUT_FRAMES ) then
		for i=1, NUM_RAID_PULLOUT_FRAMES, 1 do
			local pullout = getglobal("RaidPullout"..i);
			if ( ( pullout ) and ( pullout.filterID == id ) ) then
				getglobal("RaidPullout"..i.."Name"):SetTextColor(red, green, blue);
			end
		end
	end
end

function PartySpotter_GetRaidGroup()
	local localGroup = 1;

	for i=1, MAX_RAID_MEMBERS, 1 do
		local rName, rDiscard, rSubGroup = GetRaidRosterInfo(i);
		if ( rName == pName ) then
			localGroup = rSubGroup;
		end
	end

	return localGroup;
end



function PartySpotter_ManualTrigger()
	if ( updateInterval ) then
		timeSinceLastWMUpdate	= timeSinceLastWMUpdate  + updateInterval - 0.5;
		timeSinceLastBFMUpdate	= timeSinceLastBFMUpdate + updateInterval - 0.5;
		timeSinceLastAMUpdate	= timeSinceLastAMUpdate	 + updateInterval - 0.5;
	end
end



function PartySpotter_Unit_OnEnter(bttn)
	bttn.mouseOver = true;
	PartySpotter_Unit_OnUpdate( (unitInterval+1), bttn);
end

function PartySpotter_Unit_OnUpdate(elapsed, bttn)
	timeSinceUnitUpdate = timeSinceUnitUpdate + elapsed;
	if ( timeSinceUnitUpdate > unitInterval ) then
		if ( bttn ) and ( bttn.mouseOver ) then
			timeSinceUnitUpdate = 0;
			if ( ( MouseIsOver(WorldMapFrame) ) and ( WorldMapTooltip:IsVisible() ) ) then
				return;
			elseif ( GameTooltip:IsOwned(bttn) ) then
				return;
			end
			if ( not gTipscale ) then
				gTipscale = GameTooltip:GetScale();
			end
			if ( not wmTipscale ) then
				wmTipscale = WorldMapTooltip:GetScale();
			end
			PartySpotter_DisplayTooltip(bttn);
		end
	end
end


function PartySpotter_DisplayTooltip(bttn)
	this = bttn;
	local OnEnter_Func = this:GetScript("OnEnter");
	OnEnter_Func(bttn);

	local tt = GameTooltip;
	if ( ( WorldMapFrame:IsVisible() ) and ( MouseIsOver(WorldMapFrame) ) ) then
		tt = WorldMapTooltip;
	end
	local ttText = getglobal( tt:GetName() .. "TextLeft1"):GetText();
	if ( ( ttText ) and ( ttText ~= "" ) ) then
		local txt = "";
		local sep = "";
		tt:Hide();
		tt:SetFrameLevel( bttn:GetFrameLevel() + 6 );
		tt:SetOwner(bttn, "ANCHOR_CURSOR");
		if ( highlightedGroup > 0 ) then
			if ( not hRaidA ) then
				hRaidA = PartySpotter_RememberHighlighted(highlightedGroup);
			end
			if ( hRaidA ) then
				for name, members in hRaidA do
					if ( string.find(ttText, name) ) then
						txt = txt..sep..name;
						sep = "\n";
					end
				end
				if ( txt ~= "" ) then
					ttText = txt;
				else
					tt:Hide();
					return;
				end
			end
		end
		tt:SetText( ttText );
		tt:Show();

	end
end

function PartySpotter_Unit_OnLeave(bttn)
	if ( GameTooltip:IsVisible() ) then
		GameTooltip:Hide();
	end
	if ( WorldMapTooltip:IsVisible() ) then
		WorldMapTooltip:Hide();
	end
	bttn.mouseOver = nil;
	if ( gTipscale ) then
		GameTooltip:SetScale( gTipscale );
		gTipscale = nil;
	end
	if ( wmTipscale ) then
		WorldMapTooltip:SetScale( wmTipscale );
		wmTipscale = nil;
	end
end

function PartySpotter_Unit_OnClick(bttn)
	local tt = nil;

	if ( WorldMapTooltip:IsVisible() ) then
		tt = WorldMapTooltip;
	elseif ( GameTooltip:IsVisible() ) then
		tt = GameTooltip;
	end

	if ( ( tt ) and ( bttn == "LeftButton" ) ) then
		PartySpotter_TooltipTargets(tt);
	end
end


function PartySpotter_TooltipTargets(tt)
		local txt = getglobal( tt:GetName().."TextLeft1" ):GetText();
		local pArray = PartySpotter_ExtractPlayers(txt);
		local nPlayers = getn(pArray);
		local nxtPlayer = 1;
		for i=1, nPlayers, 1 do
			if ( ( pArray[i] == clickedPlayer ) and ( i < nPlayers ) ) then
				nxtPlayer = i + 1;
			end
		end
		clickedPlayer = pArray[nxtPlayer];
		TargetByName(clickedPlayer, true);
end


function PartySpotter_ExtractPlayers(txt)
	local pArray = {};

	local p1, i, p2 = 1, 0, string.find(txt, "\n");
	while ( p2 ) do
		i = i + 1;
		pArray[i] = string.sub(txt, p1, p2-1);
		p1 = p2 + 1;
		p2 = string.find(txt, "\n", p1);
	end
	i = i + 1;
	pArray[i] = string.sub(txt, p1);

	return pArray;
end


function PartySpotter_RememberKeyPos()
	if ( WorldMapPartySpotterKey.isMoving ) then
		if ( MouseIsOver(WorldMapButton) ) then
			WorldMapPartySpotterKey.startingX, WorldMapPartySpotterKey.startingY = PartySpotter_GetRelativeCoords(WorldMapButton);
		else
			WorldMapPartySpotterKey.startingX, WorldMapPartySpotterKey.startingY = PS_wmDefaultCoordsX, PS_wmDefaultCoordsY;
		end
		return;
	else
		local x, y;
		if ( MouseIsOver(WorldMapButton) ) then
			x, y = PartySpotter_GetRelativeCoords(WorldMapButton);
		else
			x, y = WorldMapPartySpotterKey.startingX, WorldMapPartySpotterKey.startingY;
		end
		if ( x < 31 ) then
			x = x + 31;
		end
		PartySpotterSettings.wmKeyLocX, PartySpotterSettings.wmKeyLocY = x, y;
		PartySpotter_SetwmKeyPos();
	end
end

function PartySpotter_GetRelativeCoords(rFrame)
		local x, y = GetCursorPosition();
		x = x / (rFrame:GetEffectiveScale());
		y = y / (rFrame:GetEffectiveScale());

		local centerX, centerY = rFrame:GetCenter();
		local width = rFrame:GetWidth();
		local height = rFrame:GetHeight();
		local adjustedX = (x - (centerX - (width/2))) / width;
		local adjustedY = (centerY + (height/2) - y ) / height;

		x = math.floor( width*adjustedX );
		y = math.floor( height - (height*adjustedY) );

		return x, y;
end


function PartySpotter_SetwmKeyPos()
	local x, y = PartySpotterSettings.wmKeyLocX, PartySpotterSettings.wmKeyLocY;

	WorldMapPartySpotterKey:ClearAllPoints();
	WorldMapPartySpotterKey:SetUserPlaced(false);
	WorldMapPartySpotterKey:SetParent(WorldMapButton);
	WorldMapPartySpotterKey:SetPoint("TOP", "WorldMapButton", "BOTTOMLEFT", x, y);
	WorldMapPartySpotterKey:SetFrameLevel( WorldMapButton:GetFrameLevel() + 2);
end



function PartySpotter_InitTarget()
	if ( GetNumRaidMembers() > 0 ) then
		for i=1, MAX_RAID_MEMBERS, 1 do
			local rName = GetRaidRosterInfo(i);
			if ( rName == singleOut ) then
				singleUnit = "raid"..i;
				PartySpotter_UpdateMinimapHighlight();
				break;
			end
		end

	elseif ( GetNumPartyMembers() > 0 ) then
		for i=1, MAX_PARTY_MEMBERS, 1 do
			local uName = UnitName("party"..i);
			if ( uName == singleOut ) then
				singleUnit = "party"..i;
				PartySpotter_UpdateMinimapHighlight();
				break;
			end
		end
	end
end

function PartySpotter_CheckHighlighted()
	if ( ( singleOut ~= "" ) and ( singleUnit ) ) then
		if ( GetNumRaidMembers() > 0 ) then
			for i=1, MAX_RAID_MEMBERS, 1 do
				local rName = GetRaidRosterInfo(i);
				if ( rName == singleOut ) then
					return;
				end
			end

		elseif ( GetNumPartyMembers() > 0 ) then
			for i=1, MAX_PARTY_MEMBERS, 1 do
				local uName = UnitName("party"..i);
				if ( uName == singleOut ) then
					return;
				end
			end
		end
	end

	singleOut = "";
	singleUnit = nil;
	PartySpotter_MiniMapTarget:Hide();
end


function PartySpotter_RememberHighlighted(id)
	local lA = {};
	local countHighlighted = 0;

	if ( GetNumRaidMembers() > 0 ) then
		for i=1, GetNumRaidMembers(), 1 do
			local raidName, raidRank, raidSubGroup = GetRaidRosterInfo(i);
			if ( raidSubGroup == id ) then
				lA[raidName] = true;
				countHighlighted = countHighlighted + 1;
			end
		end
	end

	if ( countHighlighted == 0 ) then
		return nil;
	else
		return lA;
	end
end


-----------------------------------------------------------------------------------------------
-- Hooked Functions
--  Chat Hooks Based on code from JoChatTimestamp
-----------------------------------------------------------------------------------------------

function PSPOTNew_ChatFrame_OnEvent(...)
	local eventDetails = unpack(arg);
	if ( ( eventDetails == "CHAT_MSG_BATTLEGROUND" ) or ( evenDetails == "CHAT_MSG_RAID" ) ) then
		if ( ( PartySpotterSettings.showGroups == "Icons" ) and ( PartySpotterSettings.colouredChat == true ) ) then
			colourNext = true;
		end
	else
		colourNext = nil;
	end

	if ( not this.PSPOTOri_AddMessage ) then
		this.PSPOTOri_AddMessage = this.AddMessage;
		this.AddMessage = PSPOTNew_AddMessage;
	end

	PSPOTOri_ChatFrame_OnEvent( unpack(arg) );
end

function PSPOTNew_AddMessage(this, msg, r, g, b, id)
	if ( msg ) then
		local altmsg = "";
		local msgColours = { r = r, g = g, b = b };

		if ( ( PartySpotterSettings.numberedChat ) or ( colourNext ) ) then
			local raidName, raidRank, raidSubGroup, localGroup, colourRef;

			if ( ( GetNumRaidMembers() > 0 ) and ( arg2 ) ) then
				local raidMembers = {};
				for i=1, GetNumRaidMembers(), 1 do
					raidName, raidRank, raidSubGroup = GetRaidRosterInfo(i);
					if ( raidName ) then
						raidMembers[raidName] = raidSubGroup;
						if ( raidName == pName ) then
							localGroup = raidSubGroup;
						end
					end
				end

				local checkName = arg2;
				local dash = string.find(arg2, "-");
				if ( dash ) then
					checkName = string.sub(arg2, 1, dash-1);
				end

				if ( raidMembers[checkName] ) then
					local fromGroup = raidMembers[checkName];
					if ( PartySpotterSettings.numberedChat ) then
						altmsg = "["..fromGroup.."]";
					end
					if ( colourNext ) then
						colourNext = nil;
						if ( fromGroup < localGroup ) then
							colourRef = fromGroup;
							msgColours = PartySpotterSettings.groupColours[colourRef];
						elseif ( fromGroup > localGroup ) then
							colourRef = fromGroup - 1;
							msgColours = PartySpotterSettings.groupColours[colourRef];
						else
							msgColours = PartySpotterSettings.lGroupC;
						end
						altmsg = altmsg.."*";
					else
						altmsg = altmsg.." ";
					end
				end
			end
		end

		altmsg = altmsg..msg;

		this:PSPOTOri_AddMessage(altmsg, msgColours.r, msgColours.g, msgColours.b, id);
	end
end

function PSPOTNew_UnitPopup_OnClick()
	local dropdownFrame = getglobal(UIDROPDOWNMENU_INIT_MENU);
	local button = this.value;
	local name = dropdownFrame.name;
	if ( button == "RAID_PSPOT" ) then
		PartySpotter_CmdLine("-t "..name);
	end

	PSPOTOri_UnitPopup_OnClick();
end



-------------------------------------------------------------------------------------------------------
-- Functionality shamelessly 'borrowed' from Gatherer, which shamelessly 'borrowed' it from MapNotes ;)
-------------------------------------------------------------------------------------------------------

function PartySpotter_MinimapInCity()
	local tempzoom = 0;
	local inCity = false;
	if (GetCVar("minimapZoom") == GetCVar("minimapInsideZoom")) then
		if (GetCVar("minimapInsideZoom")+0 >= 3) then
			Minimap:SetZoom(Minimap:GetZoom() - 1);
			tempzoom = 1;
		else
			Minimap:SetZoom(Minimap:GetZoom() + 1);
			tempzoom = -1;
		end
	end
	if (GetCVar("minimapInsideZoom")+0 == Minimap:GetZoom()) then inCity = true; end
	Minimap:SetZoom(Minimap:GetZoom() + tempzoom);
	return inCity;
end

function PartySpotter_UpdateMinimapHighlight()
	local px, py = GetPlayerMapPosition("player");

	if ( ( px == 0 ) and ( py == 0 ) ) then
		return;

	else
		local tx, ty = GetPlayerMapPosition(singleUnit);
		if ( ( tx == 0 ) and ( ty == 0 ) ) then
			return;

		else
			local zoomLevel = Minimap:GetZoom();
			local cont = GetCurrentMapContinent();
			local zone = GetCurrentMapZone();
			local map = GetMapInfo();
			local scaleInfo;

			if ( ( cont == - 1 ) and ( map ) ) then
				scaleInfo = MINIMAP_SCALES[map];
			elseif ( ( cont > 0 ) and ( zone > 0 ) ) then
				scaleInfo = MINIMAP_SCALES[cont][zone];
			end

			if ( ( scaleInfo ) and ( zoomLevel ) ) then
				local xScale, yScale;

				if ( cont == -1 ) then
					xScale = MINIMAP_SCALES[1].scales[zoomLevel].xscale;
					yScale = MINIMAP_SCALES[1].scales[zoomLevel].yscale;
				else
					xScale = MINIMAP_SCALES[cont].scales[zoomLevel].xscale;
					yScale = MINIMAP_SCALES[cont].scales[zoomLevel].yscale;
				end

				if ( Minimap_InCity ) then
					xScale = xScale * ( MINIMAP_SCALES.cityZoom[zoomLevel] );
					yScale = yScale * ( MINIMAP_SCALES.cityZoom[zoomLevel] );
				end

				px = ( px * scaleInfo.scale ) + scaleInfo.xoffset;
				py = ( py * scaleInfo.scale ) + scaleInfo.yoffset;

				tx = ( tx * scaleInfo.scale ) + scaleInfo.xoffset;
				ty = ( ty * scaleInfo.scale ) + scaleInfo.yoffset;

				local deltaX = ( tx - px ) * xScale;
				local deltaY = ( ty - py ) * yScale;

				if ( ( ( deltaX * deltaX ) + ( deltaY * deltaY ) ) > 3192.25 ) then
					local adjust = 1;
					if ( deltaX == 0 ) then
						deltaX = 0.0000000001;
					elseif ( deltaX < 0 ) then
						adjust = -1;
					end
					local tmp = math.atan(deltaY / deltaX);
					deltaX = math.cos(tmp) * 57 * adjust;
					deltaY = math.sin(tmp) * 57 * adjust;
				end

				PartySpotter_MiniMapTarget:ClearAllPoints();
				PartySpotter_MiniMapTarget:SetPoint( "CENTER", "MinimapCluster", "TOPLEFT", (105 + deltaX), (-93 - deltaY) );
				PartySpotter_MiniMapTarget:Show();
				PartySpotter_MiniMapTarget.name = singleOut;

			else
				PartySpotter_MiniMapTarget:Hide();
			end
		end
	end
end
