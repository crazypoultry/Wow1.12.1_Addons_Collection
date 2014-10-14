--	///////////////////////////////////////////////////////////////////////////////////////////
--	
--	WatchTower:	Developed for use in Realm Defense.  WatchTower allows you to automatically announce all pertinant
--			information about the invaders to the Local Defense channel (or any 2 custom channels).  Simply click
--			on the invader and use your binded key to report an enemy.  Or, you may use your multiple reporting
--			key, mouseover all enemies you wish to report, and then hit the key again to report multiple enemies
--			at once.
--
--			The default information includes Race, Class, Level, Current Subzone, Coordinates, and can be easily
--			configured using a selection menu.  Optionally, the user can make a custom output string with any of
--			the above information.
--
--			Output can be made to /s, /g, /p, /ra, /bg, Local Defense, or any 2 custom channels.
--
--
--			Currently, when using multiple enemy reporting, the output is automatically formatted to give less
--			specific data with more enemies.  This may be customized more in future versions.
--
--			KNOWN BUGS:  Local defense channel does not work in Battlegrounds.  Use /bg instead.  I'm not going
--			to bother fixing this unless someone gives me a really good reason.
--
--			NOTE:  The coordinates reported by the addon are YOUR coordinates.  It is impossible to get the
--			coordinates of your enemy.
--
--			REMEMBER:  This addon is intended to provide your allies with USEFUL information, NOT SPAM.  It is
--			SOMETIMES useful to know information such as player name, guild, class, and race, but be considerate.
--			Please make use of the multiple enemy reporting function to minimalize spam.  If it is necessary to
--			give an updated report on an already reported enemy, try to be considerate and configure your settings
--			to be less irritating (ie. "Flag carrier spotted at %l (%x, %y)")
--
--			Setup:  Create a keybinding or use the macros /script Sancho_ReportToggle(); or /script WTReportEnemy();
--
--	Official Site: 	www.grimeygames.com/wow
--
--	Current Team Members:  Clangadin, Sancho, Aragent, Nathanmx
--		
--	Contributions:	Rowne's Variable Saves/Loads and GUI Detection.
--			Sancho's multiple enemy reporting code.
--			Jhax's PvP enabled/disabled report fix.
--			Torgo's AlarmSystem code (and voozoodoo for helping rip some)
--			Torgo's RadarBlip
--	
--	License: You are hereby authorized to freely modify and/or distribute all files of this add-on, in whole or in part,
--		providing that this header stays intact, and that you do not claim ownership of this Add-on.
--		
--		Additionally, the original owner wishes to be notified by email if you make any improvements to this add-on.
--		Any positive alterations will be added to a future release, and any contributing authors will be 
--		identified in the section above. Contact at fcarentz@grimeygames.com
--	
--	Changelog:
--			v11200-2
--				Radarblip no longer included since it uses a redundant addon
--				11200-2 Bug Fixes
--					--Options menu should now only come up the first time the addon is loaded, or after a
--					  new version is installed
--			v11200  Added custom channel feature (finally)
--			        Added custom message feature
--				Menu button added in Cosmos menu (Khaos menu scrapped)
--				Option added to output to battleground chat (1.12 /bg)
--				Option added to report a player's server (1.12 cross realm BG)
--				11200 Bug Fixes
--					-Lots
--			v1.7 	Added Cosmos (Khaos) and UUI compatibility
--				Added tons of various fixes and changes
--			v1.6 	Additions by Sancho:  Changed addon to use UnitLevel() appropriately (changed by blizzard
--				to return -1 when the enemy is 10 levels above you).  Added Verbose and Debug Modes.  Added
--				output options for single enemy reporting.  Added Player Name/Guild info to output options.
--				Coordinate functionality taken from AlarmSystem, thanks to Torgo, the author, and voozoodoo
--				for ripping it.
--				1.6 Bug Fixes
--					-Removed Heading functionality (UnitFacing() taken out by blizzard)
--					-Fixed typo that was messing up raid channel reporting
--					-Fix by Jhax: Now reports pvp enabled/disabled correctly
--			v1.5 	Additions by Sancho:  Multiple enemy reporting, Raid channel broadcasting
--				1.5 Bug Fixes
--					-Fixed faction auto-detection (hopefully) and removed from saved variable list
--					-Fixed language auto-detection (hopefully) and removed from saved variable list
--			v1.4 	Added detection for GUI to show saved settings. Added Rownes Variable saves and GUI detection.
--				1.4 Bug Fixes
--					- Auto Language detection to determine what language the message should be sent in.
--					- Removed bug causing error on NPC Targeting. Will now display message that player can only
--					  target players of the selected enemy faction.
--
--			v1.3 	Added GUI interface...and options to send message to Party, Guild and Local Def. 
--						added Simple slash commands.
--			v1.2 	Corrected Autofaction code. Added Message notification of Enemy Faction, also added 
--					 	message telling user if Target is currently PVP enabled or not. 
--			v1.1 	Removed the Player Set variable of WTChannel to allow program to post to Local Defense.
--						Added autodetect for faction on load of Watch Tower. WatchTower will now automatically
--						set your enemy faction to the opposite of that which you are playing.
--
--         		v1.0  Sends message containing targets Faction, Race, Level, Subzone and Heading (Compass Style)
--	
--	///////////////////////////////////////////////////////////////////////////////////////////


	
	
-----------------------------------------------------------------------------------------------------------
--DO NOT EDIT BELOW THIS LINE UNLESS YOU KNOW WHAT YOU ARE DOING--
-----------------------------------------------------------------------------------------------------------
FactionSetTo = "";
WT_Language= "";

local HasCheckedFaction = false;
local PlayerCollectionEnabled = false;
local ReportOwnFaction = false;
local ClassOrder = {"Warrior", "Paladin", "Priest", "Hunter", "Rogue", "Shaman", "Mage", "Warlock", "Druid"};
local NumOfPlayers = 0;
local PlayerNames = { "" };
local PlayerRealms = { "" };
local PlayerLevels = { };
local SortedPlayerLevels = { };
local AverageLevel = 0;
local PlayerClasses = { };
local SortedPlayerClasses = { };
local PlayerRaces = { };
local SortedPlayerRaces = { };
local PlayerClassCounts = {0, 0, 0, 0, 0, 0, 0, 0, 0};

-- support for Cosmos
function WatchTower_Register_Khaos()
	if ( EarthFeature_AddButton ) then
		EarthFeature_AddButton( {
			id="WatchTower";
			name=TEXT(WATCHTOWER_BUTTON_NAME);
			subtext=TEXT(WATCHTOWER_BUTTON_DESC);
			tooltip=TEXT(WATCHTOWER_BUTTON_LONGDESC);
			icon="Interface\\AddOns\\WatchTower\\Watchtower_Icon";
			callback=WT_Menu_Toggle;
		} );
	end;

end

function WT_OnEvent()
	-- Register command handler and new commands
	SlashCmdList["WatchTowerCOMMAND"] = WTStatusSlashHandler;
	SLASH_WatchTowerCOMMAND1 = "/watchtower";
	SLASH_WatchTowerCOMMAND2 = "/wt";
	if (event == "VARIABLES_LOADED") then
		if (WatchTowerEnabled == nil) then
			WatchTowerEnabled = true;
		end
		if (WTVersion == nil or WTVersion ~= WT_VERSION) then
			WTVersion = WT_VERSION;
			if (WatchTower_Verbose == nil) then
				WatchTower_Verbose = true;
			end
			if (WatchTower_Debug == nil) then
				WatchTower_Debug = false;
			end
			if (WatchTower_SendParty == nil) then WatchTower_SendParty = false; end
			if (WatchTower_SendRaid == nil) then WatchTower_SendRaid = false; end
			if (WatchTower_SendGuild == nil) then WatchTower_SendGuild = false; end 
			if (WatchTower_SendLocal == nil) then WatchTower_SendLocal = true; end
			if (WatchTower_SendCustom1 == nil) then WatchTower_SendCustom1 = false; end
			if (WatchTower_SendCustom2 == nil) then WatchTower_SendCustom2 = false; end
			if (WatchTower_ReportPvP == nil) then WatchTower_ReportPvP = false; end
			if (WatchTower_ReportFaction == nil) then WatchTower_ReportFaction = true; end
			if (WatchTower_ReportGuild == nil) then WatchTower_ReportGuild = false; end
			if (WatchTower_ReportName == nil) then WatchTower_ReportName = false; end
			if (WatchTower_ReportRealm == nil) then WatchTower_ReportRealm = false; end
			if (WatchTower_ReportRace == nil) then WatchTower_ReportRace = false; end
			if (WatchTower_ReportClass == nil) then WatchTower_ReportClass = true; end
			if (WatchTower_ReportLevel == nil) then WatchTower_ReportLevel = true; end
			if (WatchTower_ReportLocation == nil) then WatchTower_ReportLocation = true; end
			if (WatchTower_ReportCoordinates == nil) then WatchTower_ReportCoordinates = true; end
			if (WatchTower_UseCustomMessage == nil) then WatchTower_UseCustomMessage = false; end
			if (WatchTower_SendBG == nil) then WatchTower_SendBG = false; end
			if (WatchTower_CustomMessage1 == nil) then
				WatchTower_CustomMessage1 = "%n of the guild %g / %f %r %c (lvl: %l) last seen in %d at (%x,%y)";
			end
			if (WatchTower_CustomChannel1 == nil) then
				WatchTower_CustomChannel1 = "";
			end
			if (WatchTower_CustomChannel2 == nil) then
				WatchTower_CustomChannel2 = "";
			end
			ShowUIPanel(WT_FrameTemplate);
		end


		--Let the player know that WatchTower has Loaded.
		if (WatchTowerEnabled == false) then
			this:UnregisterEvent("UPDATE_MOUSEOVER_UNIT");
		else
			WatchTowerStatusChatMsg("WatchTower loaded. Type /wt to display options.");
			WatchTowerStatusChatMsg("Remember to set up your Key Bindings.");
		end
		WT_SetCheckBox();
	end
	if(PlayerCollectionEnabled and WatchTowerEnabled and event == "UPDATE_MOUSEOVER_UNIT" and UnitExists("mouseover")) then
		TargetUnit("mouseover");
		WatchTowerDebugChatMsg("UNIT SELECTED", 0, 0, 1);
		Sancho_VerifyUnit();
	end
end

function Sancho_VerifyUnit()
	if (UnitFactionGroup("target") == FactionSetTo) then					
		WatchTowerDebugChatMsg("IN " .. string.upper(FactionSetTo), 0, 0, 1);
		if (UnitPlayerControlled("target")) then					
			WatchTowerDebugChatMsg("PLAYERCONTROLLED", 0, 0, 1);				
			if (UnitIsPlayer("target")) then					
				WatchTowerDebugChatMsg("NOT A PET", 0, 0, 1);
					local tempname, realmName = UnitName("target");  --FIXME
					local isNew = true;
					for i=1, NumOfPlayers + 1 do
						if (PlayerNames[i] == tempname and PlayerRealms[i] == realmName) then
							isNew = false;
						end
					end
					if(isNew) then
						Sancho_AddPlayer();
					else
						WatchTowerVerboseChatMsg("PLAYER ALREADY ADDED");
					end							
			else									
				WatchTowerDebugChatMsg("IS A PET", 1, 0, 0);				
			end									
		else										
			WatchTowerDebugChatMsg("NOT PLAYERCONTROLLED", 1, 0, 0);			
		end										
	else											
		WatchTowerDebugChatMsg("NOT IN " .. string.upper(FactionSetTo), 1, 0, 0);
	end
end

function WT_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	if (Khaos) then
		WatchTower_Register_Khaos();
        elseif ( Cosmos_RegisterButton ) then
                   Cosmos_RegisterButton (TEXT(WATCHTOWER_BUTTON_NAME),
                                          TEXT(WATCHTOWER_BUTTON_DESC),
                                          TEXT(WATCHTOWER_BUTTON_LONGDESC),
                                          "Interface\\AddOns\\WatchTower\\Watchtower_Icon",
                                          WT_Menu_Toggle);
	end
	SLASH_WATCHTOWER1 = "/watchtower";
	SLASH_WATCHTOWER2 = "/wt";
	SlashCmdList["WATCHTOWER"] = WatchTower_ShowUI;
	if ( UltimateUI_RegisterButton ) then
		UltimateUI_RegisterButton (
			"Watch Tower",
			"Config",
			"|cFF00CC00Watch Tower|r\nAllows you to report information \nabout enemy targets in various chat channels",
			"Interface\\Icons\\Ability_Seal",
			ShowUIPanel(WT_FrameTemplate),
			function()
			return true; -- The button is enabled
			end
		);
	end
end

--Executed by the user via bindable key

function Sancho_ReportToggle()
	if(PlayerCollectionEnabled == false) then
		WT_FrameTemplate:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
		PlayerCollectionEnabled = true;
		if(HasCheckedFaction == false) then
			SetFaction(UnitFactionGroup("player"));
			HasCheckedFaction = true;
		end
		WatchTowerVerboseChatMsg("WatchTower player collection enabled");
		WatchTowerDebugChatMsg("Reporting " .. FactionSetTo .. " enemies", 1, 1, 1);
		if(UnitName("target") ~= nil) then
			Sancho_VerifyUnit();
		end
		if(UnitExists("mouseover")) then
			TargetUnit("mouseover");
			WatchTowerDebugChatMsg("UNIT SELECTED", 0, 0, 1);
			Sancho_VerifyUnit();
		end
	else
		WT_FrameTemplate:UnregisterEvent("UPDATE_MOUSEOVER_UNIT");
		PlayerCollectionEnabled = false;
		Sancho_PrintData();
		Sancho_ClearData();
	end
end

--Function assumes that an enemy unit is selected which is not already in the tables

function Sancho_AddPlayer()
	NumOfPlayers = NumOfPlayers + 1;
	PlayerNames[NumOfPlayers], PlayerRealms[NumOfPlayers] = UnitName("target");
	PlayerClasses[NumOfPlayers] = UnitClass("target");
	PlayerLevels[NumOfPlayers] = UnitLevel("target");
	PlayerRaces[NumOfPlayers] = UnitRace("target");
	WatchTowerVerboseChatMsg("Added (" .. NumOfPlayers .. " Players)");
end

--Prints results, will only be done after data collection has been stopped

function Sancho_PrintData()
	if(NumOfPlayers ~= 0) then
		Sancho_ClassBreakdown();
		Sancho_SortLevels();
	end
	local tMessage = "";
	
	-- From AlarmSystem, by Torgo, ripped with permission
	-- thanks voozoodoo for ripping!
	
	xME, yME = GetPlayerMapPosition("player"); 
	xME = math.floor(xME*100.0); 
	yME = math.floor(yME*100.0);
	tMessage = tMessage .. "WatchTower: " .. NumOfPlayers .. " " .. FactionSetTo ..
				" attacking " .. GetMinimapZoneText();
	if ((xME > 0) or (yME > 0)) then 
		tMessage = tMessage.." seen from ("..xME..","..yME..")! ";
	else
		tMessage = tMessage.."! ";
	end
	if(NumOfPlayers > 50) then
		Sancho_CalculateAverage();
		if(SortedPlayerLevels[NumOfPlayers] == -1) then
			tMessage = tMessage .. "Lowest level: " .. SortedPlayerLevels[1] ..
						" Highest level: " .. UnitLevel("player") + 10 ..
						"+ Average level of known players: " .. string.format("%.1f", AverageLevel);
		else
			tMessage = tMessage .. "Lowest level: " .. SortedPlayerLevels[1] ..
						" Highest level: " .. SortedPlayerLevels[NumOfPlayers] ..
						" Average level of known players: " .. string.format("%.1f", AverageLevel);
		end
	elseif(NumOfPlayers > 20) then
		tMessage = tMessage .. "lvls: ";
		for i=1, NumOfPlayers do
			if(SortedPlayerLevels[i] == -1) then
				tMessage = tMessage .. UnitLevel("player") + 10 .. "+ ";
			else
				tMessage = tMessage .. SortedPlayerLevels[i] .. " ";
			end
		end
	elseif(NumOfPlayers > 10) then
		local temporarycounter = 0; --<<keeps track of how many players are processed,
		for i=1, 9 do		    ----so that it knows if it should add a comma or not
			if(PlayerClassCounts[i] ~= 0) then
					--For the first loop, i = 1, ClassOrder[1] will be a Warrior
					--If there are 2 warriors, for example, the first loop will add
					--"2 Warrior" and "s" since there are more than one
					--and ", " if there are more than 2 total players
				tMessage = tMessage .. PlayerClassCounts[i] .. " " .. ClassOrder[i];
				if(PlayerClassCounts[i] > 1) then
					tMessage = tMessage .. "s";
				end
				temporarycounter = temporarycounter + PlayerClassCounts[i];
				if(temporarycounter < NumOfPlayers) then
					tMessage = tMessage .. ", ";
				end
			end
		end
		tMessage = tMessage .. " - lvls: ";
		for i=1, NumOfPlayers do
			if(SortedPlayerLevels[i] == -1) then
				tMessage = tMessage .. UnitLevel("player") + 10 .. "+ ";
			else
				tMessage = tMessage .. SortedPlayerLevels[i] .. " ";
			end
		end
	elseif(NumOfPlayers > 5) then
		for i=1, NumOfPlayers do
			if(SortedPlayerLevels[i] == -1) then
				tMessage = tMessage .. "lvl " .. UnitLevel("player") + 10 .. "+ " .. SortedPlayerClasses[i];
			else
				tMessage = tMessage .. "lvl " .. SortedPlayerLevels[i] .. " " .. SortedPlayerClasses[i];
			end
			if(i < NumOfPlayers) then
				tMessage = tMessage .. ", ";
			end
		end
	elseif(NumOfPlayers > 0) then
		for i=1, NumOfPlayers do
			if(SortedPlayerLevels[i] == -1) then
				tMessage = tMessage .. "Level " .. UnitLevel("player") + 10 .. "+ " .. SortedPlayerRaces[i] .. " " .. SortedPlayerClasses[i];
			else
				tMessage = tMessage .. "Level " .. SortedPlayerLevels[i] .. " " .. SortedPlayerRaces[i] .. " " .. SortedPlayerClasses[i];
			end
			if(i < NumOfPlayers) then
				tMessage = tMessage .. ", ";
			end
		end
	end
	--Actually sends the data to whichever channel is wanted
	if(NumOfPlayers ~= 0) then
		if (UnitFactionGroup("player") == "Horde") then
			WT_Language = "Orcish";
		else
			WT_Language = "Common";
		end
		if (WatchTower_SendLocal == true) then
			tempArray = { GetMapZones(GetCurrentMapContinent()) }; 
			mapZone = tempArray[GetCurrentMapZone()]; 
			localDef = GetChannelName("LocalDefense - " ..mapZone); 
			SendChatMessage(tMessage ,"CHANNEL", WT_Language, localDef);
		end

		if WatchTower_SendGuild == true then
			SendChatMessage(tMessage ,"Guild");
		end

		if WatchTower_SendParty == true then
			SendChatMessage(tMessage ,"Party");
		end
		
		if WatchTower_SendRaid == true then
			SendChatMessage(tMessage ,"Raid");
		end
		if WatchTower_SendBG == true then
			SendChatMessage(tMessage ,"BATTLEGROUND");
		end
		customchannel = GetChannelName(WatchTower_CustomChannel1);
		if WatchTower_SendCustom1 == true then
			SendChatMessage(tMessage ,"CHANNEL", WT_Language, customchannel);
		end
		customchannel = GetChannelName(WatchTower_CustomChannel2);
		if WatchTower_SendCustom2 == true then
			SendChatMessage(tMessage ,"CHANNEL", WT_Language, customchannel);
		end
		if(string.len(tMessage) < 256) then
			WatchTowerDebugChatMsg(tMessage, 1, 1, 1);
		else
			WatchTowerDebugChatMsg(string.sub(tMessage, 1, 255), 1, 1, 1);
			WatchTowerDebugChatMsg(string.sub(tMessage, 256), 1, 0, 0);
		end
	else
		WatchTowerStatusChatMsg("No enemies to report.  Is your faction set right?  Is PvP only reporting enabled?");
	end
end

--Run before the data is printed .. also sorts classes and races to match up with levels when needed

function Sancho_SortLevels()
	for i=1, NumOfPlayers do
		for j=1, i do
			if(SortedPlayerLevels[j] == nil or (SortedPlayerLevels[j] > PlayerLevels[i] and PlayerLevels[i] ~= -1)) then
				table.insert(SortedPlayerLevels, j, PlayerLevels[i]);
				table.insert(SortedPlayerClasses, j, PlayerClasses[i]);
				table.insert(SortedPlayerRaces, j, PlayerRaces[i]);
				break;
			end
		end
	end
end

function Sancho_CalculateAverage()
	local count = 0
	for i=1, NumOfPlayers do
		if(PlayerLevels[i] ~= -1) then
			AverageLevel = AverageLevel + PlayerLevels[i];
			count = count + 1;
		end
	end
	AverageLevel = AverageLevel / count;
end

--Will make an array with elements based on the number of each class
--For example PlayerClasses[1] would equal the number of Warriors (see ClassOrder)

function Sancho_ClassBreakdown()
	for i=1, NumOfPlayers do
		for j=1, 9 do
			if(PlayerClasses[i] == ClassOrder[j]) then
				PlayerClassCounts[j] = PlayerClassCounts[j] + 1;
			end
		end
	end
end

function Sancho_ClearData()
	NumOfPlayers = 0;
	PlayerNames = { "" };
	PlayerLevels = { };
	SortedPlayerLevels = { };
	PlayerClasses = { };
	SortedPlayerClasses = { };
	PlayerRaces = { };
	SortedPlayerRaces = { };
	PlayerClassCounts = {0, 0, 0, 0, 0, 0, 0, 0, 0}
end

function WTReportEnemy()
	if(HasCheckedFaction == false) then
		SetFaction(UnitFactionGroup("player"));
		HasCheckedFaction = true;
	end
	if (WatchTowerEnabled == true) then
		if (UnitFactionGroup("target") == FactionSetTo and UnitPlayerControlled("target") and UnitIsPlayer("target")) then --make sure that the unit is the correct faction
			--Gather all the needed information about the target
			local tName, tRealm, tGuild, tClass, tLevel, tFaction, tRace, tLoc, tPvP;
			tName, tRealm = UnitName("target");
			if(tRealm == nil) then
				tRealm = GetRealmName();
			end
			tGuild = GetGuildInfo("target");
			if(tGuild == nil) then
				tGuild = "Unguilded"
			end
			tClass = UnitClass("target");
			tLevel = UnitLevel("target");
			tFaction = UnitFactionGroup("target");
			tRace = UnitRace("target");
			tLoc = GetMinimapZoneText();
			tSubZone = GetSubZoneText();
			xME, yME = GetPlayerMapPosition("player"); 
			tX = math.floor(xME*100.0); 
			tY = math.floor(yME*100.0);
			if (UnitIsPVP("target")) then --fix by Jhax
				tPvP = "enabled"
			else
				tPvP = "disabled"
			end

			--Construct message
			tMessage = "WatchTower: "

			if(WatchTower_UseCustomMessage1) then
				tMessage = tMessage .. WatchTower_CustomMessage1;
				tMessage = string.gsub(tMessage, '%%n', tName);
				tMessage = string.gsub(tMessage, '%%z', tRealm);
				tMessage = string.gsub(tMessage, '%%g', tGuild);
				tMessage = string.gsub(tMessage, '%%c', tClass);
				if(tLevel == -1) then
					tMessage = string.gsub(tMessage, '%%l', "??");
				else
					tMessage = string.gsub(tMessage, '%%l', tLevel);
				end
				tMessage = string.gsub(tMessage, '%%p', tPvP);
				tMessage = string.gsub(tMessage, '%%f', tFaction);
				tMessage = string.gsub(tMessage, '%%r', tRace);
				tMessage = string.gsub(tMessage, '%%d', tLoc);
				tMessage = string.gsub(tMessage, '%%s', tSubZone);
				tMessage = string.gsub(tMessage, '%%x', tX);
				tMessage = string.gsub(tMessage, '%%y', tY);
			else
				if(WatchTower_ReportRealm) then
					tName = tName .. "-" .. tRealm;
				end
				if(WatchTower_ReportName and WatchTower_ReportGuild) then
					if(tGuild == "Unguilded") then
						tMessage = tMessage .. tName .. " / ";
					else
						tMessage = tMessage .. tName .. " of the guild " .. tGuild .. " / ";
					end
				elseif(WatchTower_ReportName and not WatchTower_ReportGuild) then
					tMessage = tMessage .. tName .. " / ";
				elseif(not WatchTower_ReportName and WatchTower_ReportGuild) then
					if(tGuild ~= "Unguilded") then
						tMessage = tMessage .. tGuild .. " guild member / ";
					end
				end

				if(WatchTower_ReportPvP) then
					tMessage = tMessage .. "PvP " .. tPvP .. " ";
				end

				if(WatchTower_ReportFaction) then
					tMessage = tMessage .. tFaction .. " ";
				end

				if(WatchTower_ReportRace) then
					tMessage = tMessage .. tRace .. " ";
				end
				if(WatchTower_ReportClass) then
					tMessage = tMessage .. tClass .. " ";
				end

				if(WatchTower_ReportLevel) then
					if(tLevel ~= -1) then
						tMessage = tMessage .. "(lvl: " .. tLevel .. ") ";
					else
						tMessage = tMessage .. "(lvl: " .. UnitLevel("player") + 10 .. "+)";
					end
				end

				if(WatchTower_ReportLocation or WatchTower_ReportCoordinates) then
					if(WatchTower_ReportLocation) then
						tMessage = tMessage .. " in " .. tLoc .. " ";
					end
					-- From AlarmSystem, by Torgo, ripped with permission
					-- thanks voozoodoo for ripping! 
					if ((tX > 0) and (tY > 0)) then 
						if(WatchTower_ReportCoordinates) then
							tMessage = tMessage .. "spotted from ("..tX..","..tY..") ";
						end
					end
				end
			end
			if (UnitFactionGroup("player") == "Horde") then
				WT_Language = "Orcish";
			else
				WT_Language = "Common";
			end
			if (WatchTower_SendLocal == true) then
				tempArray = { GetMapZones(GetCurrentMapContinent()) }; 
				mapZone = tempArray[GetCurrentMapZone()];

				-- fix the output channel incase mapzone is nil (inside instances and whatnot)  -nathanmx
				if (mapZone) then
					localDef = GetChannelName("LocalDefense - " .. mapZone);
				else
					mapZone = GetMinimapZoneText();
					localDef = GetChannelName("LocalDefense - " .. mapZone);
				end
				SendChatMessage(tMessage ,"CHANNEL", WT_Language, localDef);
				
			end
			
			if WatchTower_SendGuild == true then
				SendChatMessage(tMessage ,"Guild");
			end
			
			if WatchTower_SendParty == true then
				SendChatMessage(tMessage ,"Party");
			end
			if WatchTower_SendRaid == true then
				SendChatMessage(tMessage ,"Raid");
			end
			if WatchTower_SendBG == true then
				SendChatMessage(tMessage ,"BATTLEGROUND");
			end
			customchannel = GetChannelName(WatchTower_CustomChannel1);
			if WatchTower_SendCustom1 == true then
				SendChatMessage(tMessage ,"CHANNEL", WT_Language, customchannel);
			end
			customchannel = GetChannelName(WatchTower_CustomChannel2);
			if WatchTower_SendCustom2 == true then
				SendChatMessage(tMessage ,"CHANNEL", WT_Language, customchannel);
			end
			if(string.len(tMessage) < 256) then
				WatchTowerDebugChatMsg(tMessage, 1, 1, 1);
			else
				WatchTowerDebugChatMsg(string.sub(tMessage, 1, 255), 1, 1, 1);
				WatchTowerDebugChatMsg(string.sub(tMessage, 256), 1, 0, 0);
			end
		else
			WatchTowerStatusChatMsg("You can only track player-controlled units of the "..FactionSetTo.." faction.");
		end 				 
	end
end

function ToggleWatchTower()
   if (WatchTowerEnabled == true) then
		WatchTowerStatusChatMsg("WatchTower Disabled.");
		this:UnregisterEvent("UPDATE_MOUSEOVER_UNIT");
   else
		WatchTowerStatusChatMsg("WatchTower Enabled.");
		this:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
   end
   WatchTowerEnabled = not WatchTowerEnabled;
end

function WTStatusSlashHandler(msg)
	if (msg == nil) then 
		msg = "";
	end
	msg = string.lower(msg);
	local num, offset, command, args = string.find (msg, "(%w+) (%w+)");    
	if (msg == "verbose") then
		ToggleVerboseMode();
	elseif (msg == "debug") then
		ToggleDebugMode();
    	elseif (msg == "options") then
		ShowUIPanel(WT_FrameTemplate);
	else
		WatchTowerStatusChatMsg("/wt options - options menu for channel output and info to report");
		WatchTowerStatusChatMsg("/wt verbose - toggles verbose mode");
		WatchTowerStatusChatMsg("/wt debug - toggles debug mode");
	end
end

function WatchTowerStatusChatMsg(msg)
	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage(msg);
	end
end

function WatchTowerVerboseChatMsg(msg)
	if( DEFAULT_CHAT_FRAME ) then
		if(WatchTower_Verbose) then
			DEFAULT_CHAT_FRAME:AddMessage(msg);
		end
	end
end

function WatchTowerDebugChatMsg(msg, red, green, blue)
	if( DEFAULT_CHAT_FRAME ) then
		if(WatchTower_Debug) then
			DEFAULT_CHAT_FRAME:AddMessage(msg, red, green, blue);
		end
	end
end

function ToggleVerboseMode()
   if (WatchTower_Verbose == true) then
		WatchTowerStatusChatMsg("Verbose Mode Disabled.");
   else
		WatchTowerStatusChatMsg("Verbose Mode Enabled.");
   end
   WatchTower_Verbose = not WatchTower_Verbose;
end

function ToggleDebugMode()
   if (WatchTower_Debug == true) then
		WatchTowerStatusChatMsg("Debug Mode Disabled.");
   else
		WatchTowerStatusChatMsg("Debug Mode Enabled.");
   end
   WatchTower_Debug = not WatchTower_Debug;
end

function ToggleFaction()  -- for debugging
	ReportOwnFaction = not ReportOwnFaction;
	SetFaction();
end

function SetFaction()
	local faction;
	-- Determine the Players Faction upon first report and automatically set 
	-- them to the correct enemy type.

	faction= UnitFactionGroup("player");
	if(ReportOwnFaction) then  -- for debugging
		FactionSetTo = faction;
		WatchTowerStatusChatMsg("Enemy set to " .. faction);
	elseif (faction == "Horde") then
		FactionSetTo = "Alliance";
		WatchTowerStatusChatMsg("Enemy set to Alliance");
	else
		FactionSetTo = "Horde";
		WatchTowerStatusChatMsg("Enemy set to Horde");
	end
end

function WT_Menu_Toggle()
        if (WT_FrameTemplate:IsVisible()) then
                WT_FrameTemplate:Hide();
        else
                WT_FrameTemplate:Show();
        end
end

function WT_SetCheckBox()
	--Make the GUI show if Options are selected or not 
	--dependant upon the variables.
	
	WT_Checkbox0:SetChecked(WatchTower_SendParty);
	WT_Checkbox1:SetChecked(WatchTower_SendRaid);
	WT_Checkbox19:SetChecked(WatchTower_SendBG);
	WT_Checkbox2:SetChecked(WatchTower_SendGuild);
	WT_Checkbox3:SetChecked(WatchTower_SendLocal);
	WT_Checkbox4:SetChecked(WatchTower_SendCustom1);
	WT_Checkbox5:SetChecked(WatchTower_SendCustom2);
	WT_Checkbox6:SetChecked(WatchTower_UseCustomMessage1);
	WT_Checkbox10:SetChecked(WatchTower_ReportPvP);
	WT_Checkbox11:SetChecked(WatchTower_ReportFaction);
	WT_Checkbox12:SetChecked(WatchTower_ReportGuild);
	WT_Checkbox13:SetChecked(WatchTower_ReportName);
	WT_Checkbox20:SetChecked(WatchTower_ReportRealm);
	WT_Checkbox14:SetChecked(WatchTower_ReportRace);
	WT_Checkbox15:SetChecked(WatchTower_ReportClass);
	WT_Checkbox16:SetChecked(WatchTower_ReportLevel);
	WT_Checkbox17:SetChecked(WatchTower_ReportLocation);
	WT_Checkbox18:SetChecked(WatchTower_ReportCoordinates);
	WT_Editbox0:SetText(WatchTower_CustomChannel1);
	WT_Editbox1:SetText(WatchTower_CustomChannel2);
	WT_Editbox2:SetText(WatchTower_CustomMessage1);
end
