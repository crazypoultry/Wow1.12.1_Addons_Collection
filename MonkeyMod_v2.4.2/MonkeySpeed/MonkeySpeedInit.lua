--[[

	MonkeySpeed:
	A simple speedometer.
	
	Author: Trentin

	Resurected by: Quel

--]]


-- define the dialog box for reseting config
StaticPopupDialogs["MONKEYSPEED_RESET"] = {
	text = TEXT(MONKEYSPEED_CONFIRM_RESET),
	button1 = TEXT(OKAY),
	button2 = TEXT(CANCEL),
	OnAccept = function()
		MonkeySpeed_ResetConfig();
	end,
	timeout = 0,
	exclusive = 1
};


-- Script array, not saved
MonkeySpeed = {};
MonkeySpeed.m_iDeltaTime = 0;

MonkeySpeed.m_fSpeed = 0.0;
MonkeySpeed.m_fSpeedDist = 0.0;
MonkeySpeed.m_bLoaded = false;
MonkeySpeed.m_bVariablesLoaded = false;
MonkeySpeed.m_strPlayer = "";
MonkeySpeed.m_vCurrPos = {};
MonkeySpeed.m_bCalibrate = false;


function MonkeySpeed_Init()
		
	-- double check that we didn't already load
	if ((MonkeySpeed.m_bLoaded == false) and (MonkeySpeed.m_bVariablesLoaded == true)) then
		
		-- add the realm to the "player's name" for the config settings
		MonkeySpeed.m_strPlayer = GetCVar("realmName").."|"..MonkeySpeed.m_strPlayer;
		
		if (not MonkeySpeedConfig) then
			MonkeySpeedConfig = { };
		end
		
		-- now we're ready to calculate speed
		MonkeySpeed.m_vLastPos = {};
		MonkeySpeed.m_vLastPos.x, MonkeySpeed.m_vLastPos.y = GetPlayerMapPosition("player");

		-- if there's not an entry for this
		if (not MonkeySpeedConfig[MonkeySpeed.m_strPlayer]) then
			MonkeySpeedConfig[MonkeySpeed.m_strPlayer] = {};
		end
		
		-- set the defaults if the values weren't loaded by the SavedVariables.lua
		if (MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplay == nil) then
			MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplay = true;
		end
		if (MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplayPercent == nil) then
			MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplayPercent = true;
		end
		if (MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplayBar == nil) then
			MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplayBar = true;
		end
		if (MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_fUpdateRate == nil) then
			MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_fUpdateRate = 0.5;
		end
		if (MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDebugMode == nil) then
			MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDebugMode = false;
		end
		if (MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bLocked == nil) then
			MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bLocked = false;
		end
		if (MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_iFrameWidth == nil) then
			MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_iFrameWidth = 96;
		end

		if (MonkeySpeedConfig.m_ZoneBaseline1 == nil) then
			MonkeySpeedConfig.m_ZoneBaseline1 = {
					{zid=1, rate=0.00182}, -- Ashenvale
					{zid=2, rate=0.00207}, -- Azshara
					{zid=3, rate=0.00160}, -- Darkshore
					{zid=4, rate=0.00992}, -- Darnassus
					{zid=5, rate=0.00234}, -- Desolace
					{zid=6, rate=0.00199}, -- Durotar
					{zid=7, rate=0.00200}, -- Dustwallow Marsh
					{zid=8, rate=0.00183}, -- Felwood
					{zid=9, rate=0.00151}, -- Feralas
					{zid=10, rate=0.00455}, -- Moonglade
					{zid=11, rate=0.00204}, -- Mulgore
					{zid=12, rate=0.00748}, -- Orgrimmar
					{zid=13, rate=0.00151}, -- Silithus
					{zid=14, rate=0.00215}, -- Stonetalon Mtns
					{zid=15, rate=0.00152}, -- Tanaris
					{zid=16, rate=0.00206}, -- Rut'theran Village
					{zid=17, rate=0.00104}, -- The Barrens
					{zid=18, rate=0.00239}, -- Thousand Needles
					{zid=19, rate=0.01006}, -- Thunderbluff
					{zid=20, rate=0.00284}, -- Un'Goro Crater
					{zid=21, rate=0.00148}, -- Winterspring
					{zid=22, rate=0.0001},
					{zid=23, rate=0.0001},
					{zid=24, rate=0.0001},
					{zid=25, rate=0.0001}
			};
		end

		if (MonkeySpeedConfig.m_ZoneBaseline2 == nil) then
			MonkeySpeedConfig.m_ZoneBaseline2 = {
					{zid=1, rate=0.00375}, -- Alterac Mtns
					{zid=2, rate=0.00292}, -- Arathi Highlands
					{zid=3, rate=0.0042}, -- Badlands
					{zid=4, rate=0.00313}, -- Blasted Lands
					{zid=5, rate=0.00359}, -- Burning Steppes
					{zid=6, rate=0.00420}, -- Deadwind Pass
					{zid=7, rate=0.00213}, -- Dun Morogh
					{zid=8, rate=0.00389}, -- Duskwood
					{zid=9, rate=0.00271}, -- Eastern Plaguelands
					{zid=10, rate=0.00302}, -- Elwynn Forest
					{zid=11, rate=0.00328}, -- Hillsbrad
					{zid=12, rate=0.01327}, -- Ironforge
					{zid=13, rate=0.00381}, -- Loch Modan
					{zid=14, rate=0.00484}, -- Redridge Mtns
					{zid=15, rate=0.00471}, -- Searing Gorge
					{zid=16, rate=0.00250}, -- Silverpine Forest
					{zid=17, rate=0.00781}, -- Stormwind
					{zid=18, rate=0.00165}, -- Stranglethorn Vale
					{zid=19, rate=0.00458}, -- Swamp of Sorrows
					{zid=20, rate=0.00273}, -- Hinterlands
					{zid=21, rate=0.00232}, -- Tirisfal Glades
					{zid=22, rate=0.01094}, -- Undercity
					{zid=23, rate=0.00244}, -- Western Plaguelands
					{zid=24, rate=0.00300}, -- Westfall
					{zid=25, rate=0.00254} -- Wetlands
			};
		end
		
		if (MonkeySpeedConfig.m_SpecialZoneBaseline == nil) then
			MonkeySpeedConfig.m_SpecialZoneBaseline = {
					[MONKEYSPEED_BLACKROCK] = 0.0002983199214410154,
					[MONKEYSPEED_WARSONG] = 0.009159138767039199,
					[MONKEYSPEED_ALTERAC] = 0.002477872662261515,
					[MONKEYSPEED_ARATHI] = 0.005978692329518227
			};
		end
		
		-- show or hide the right options
		if (MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplay) then
			MonkeySpeedFrame:Show();
		else
			MonkeySpeedFrame:Hide();
		end
		
		if (MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplayPercent) then
			MonkeySpeedText:Show();
		else
			MonkeySpeedText:Hide();
		end
		
		if (MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplayBar) then
			MonkeySpeedBar:Show();
		else
			MonkeySpeedBar:Hide();
		end

		MonkeySpeedSlash_CmdSetWidth(MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_iFrameWidth);
		
		-- All variables are loaded now
		MonkeySpeed.m_bLoaded = true;
		
		-- print out a nice message letting the user know the addon loaded
		if (DEFAULT_CHAT_FRAME) then
			DEFAULT_CHAT_FRAME:AddMessage(MONKEYSPEED_LOADED);
		end
	end
end

function MonkeySpeed_ResetConfig()
	-- set the defaults if the values weren't loaded by the SavedVariables.lua
	MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplay = true;
	MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplayPercent = true;
	MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplayBar = true;
	MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_fUpdateRate = 0.5;
	MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDebugMode = false;
	MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bLocked = false;
	MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_iFrameWidth = 96;
	
	-- show or hide the right options
	-- update the frame
	MonkeySpeedFrame:ClearAllPoints();
	MonkeySpeedFrame:SetPoint("TOP", "UIParent", "BOTTOMLEFT", 400, 384);
	MonkeySpeedFrame:Show();
	
	MonkeySpeedText:Show();
	MonkeySpeedBar:Show();

	MonkeySpeedSlash_CmdSetWidth(MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_iFrameWidth);
	
	-- check for MonkeyBuddy
	if (MonkeyBuddySpeedFrame_Refresh ~= nil) then
		MonkeyBuddySpeedFrame_Refresh();
	end
end
