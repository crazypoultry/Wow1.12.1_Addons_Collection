-- Global Variables
TITAN_PVPLOG_ID = "PvPLog";
TITAN_PVPLOG_TITLE = "Titan PvPLog";
VERSION = "1.3.1";
PVPSTATS_TOTAL_WINS = "0";
PVPSTATS_TOTAL_LOSSES = "0";
PVPSTATS_TOTAL_LEVEL_DIFF = "0";
PVPSTATS_PVP_WINS = "0";
PVPSTATS_PVP_LOSSES = "0";
PVPSTATS_PVP_LEVEL_DIFF = "0";
PVPSTATS_DUEL_WINS = "0";
PVPSTATS_DUEL_LOSSES = "0";
PVPSTATS_DUEL_LEVEL_DIFF = "0";
PVPSTATS_GANK_NAME = "";

-- Local Variables
local statsText = "";
local lvlDiff = 0;
local stats = { };
local GREEN   = "|cff6bb700";
local RED     = "|cffbe0303";

-- [[
-- Titan Panel Registration
-- ]]
function TitanPanelPvPLogButton_OnLoad()
    this.registry = { 
		id = TITAN_PVPLOG_ID,
		menuText = TITAN_PVPLOG_TITLE .. VERSION,
		buttonTextFunction = "TitanPanelPvPLogButton_GetButtonText", 
		tooltipTitle = TITAN_PVPLOG_TITLE .. VERSION,
		tooltipTextFunction = "TitanPanelPvPLogButton_GetTooltipText", 
		category = "Combat",
		savedVariables = {
			ShowIcon = 0,
			ShowLabelText = 1,
			ShowColoredText = 1,
		}
	};
 	this:RegisterEvent("PLAYER_LEAVING_WORLD");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
end

function TitanPanelPvPLogButton_OnEvent()
	if (event == "PLAYER_LEAVING_WORLD") then
		this:UnregisterEvent("PLAYER_DEAD");
		this:UnregisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");
		this:UnregisterEvent("PLAYER_PVP_KILLS_CHANGED");
		this:UnregisterEvent("DUEL_FINISHED");
    end    
    if (event == "PLAYER_ENTERING_WORLD") then
        this:RegisterEvent("PLAYER_DEAD");
		this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");
		this:RegisterEvent("PLAYER_PVP_KILLS_CHANGED");
		this:RegisterEvent("DUEL_FINISHED");
    end    
    TitanPanelButton_UpdateButton(TITAN_PVPLOG_ID);
end

-- [[
-- Titan Panel Button Text
-- ]]
function TitanPanelPvPLogButton_GetButtonText(TITAN_PVPLOG_ID)
	updateAllStats();
	if (TitanGetVar(TITAN_PVPLOG_ID, "ShowLabelText")) then
		statsText = format(TitanUtils_GetNormalText(WINS) .. ": " .. "%s  " .. TitanUtils_GetNormalText(LOSSES) .. ": " .. "%s  " .. TitanUtils_GetNormalText(AVERAGE_DIFF) .. ": " .. "%s", PVPSTATS_TOTAL_WINS, PVPSTATS_TOTAL_LOSSES, PVPSTATS_TOTAL_LEVEL_DIFF);
	else
		statsText = format(TitanUtils_GetNormalText(WINS_SHORT) .. ": " .. "%s  " .. TitanUtils_GetNormalText(LOSSES_SHORT) .. ": " .. "%s  " .. TitanUtils_GetNormalText(AVERAGE_DIFF_SHORT) .. ": " .. "%s", PVPSTATS_TOTAL_WINS, PVPSTATS_TOTAL_LOSSES, PVPSTATS_TOTAL_LEVEL_DIFF);
	end
	return (statsText)
end

-- [[
-- Titan Panel Tooltip Text
-- ]]
function TitanPanelPvPLogButton_GetTooltipText()
	updateAllStats();
	statsText = format("\n" .. TitanUtils_GetNormalText(AVERAGE_DIFF) .. "\t%s\n%s\n\n" .. TitanUtils_GetNormalText(PVP) .. " " .. TitanUtils_GetNormalText(WINS) .. "\t%s\n" .. TitanUtils_GetNormalText(PVP) .. " " .. TitanUtils_GetNormalText(LOSSES) .. "\t%s\n" .. TitanUtils_GetNormalText(PVP) .. " " .. TitanUtils_GetNormalText(AVERAGE_DIFF) .. "\t%s\n\n" .. TitanUtils_GetNormalText(DUEL) .. " " .. TitanUtils_GetNormalText(WINS) .. "\t%s\n" .. TitanUtils_GetNormalText(DUEL) .. " " .. TitanUtils_GetNormalText(LOSSES) .. "\t%s\n" .. TitanUtils_GetNormalText(DUEL) .. " " .. TitanUtils_GetNormalText(AVERAGE_DIFF) .. "\t%s\n\n" .. TitanUtils_GetNormalText(TOTAL) .. " " .. TitanUtils_GetNormalText(WINS) .. "\t%s\n" .. TitanUtils_GetNormalText(TOTAL) .. " " .. TitanUtils_GetNormalText(LOSSES) .. "\t%s\n" .. TitanUtils_GetNormalText(TOTAL) .. " " .. TitanUtils_GetNormalText(AVERAGE_DIFF) .. "\t%s", PVPSTATS_TOTAL_LEVEL_DIFF, PVPSTATS_GANK_NAME, PVPSTATS_PVP_WINS, PVPSTATS_PVP_LOSSES, PVPSTATS_PVP_LEVEL_DIFF, PVPSTATS_DUEL_WINS, PVPSTATS_DUEL_LOSSES, PVPSTATS_DUEL_LEVEL_DIFF, PVPSTATS_TOTAL_WINS, PVPSTATS_TOTAL_LOSSES, PVPSTATS_TOTAL_LEVEL_DIFF);
	return (statsText)
end

-- [[
-- Titan Panel Right-Click Menu
-- ]]
function TitanPanelRightClickMenu_PreparePvPLogMenu()

	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_PVPLOG_ID].menuText);
	
	TitanPanelRightClickMenu_AddSpacer();

	local info = {};
	info.text = PVP .. STATS;
	info.func = TitanPanelShowPvPStats;
	UIDropDownMenu_AddButton(info);

	local info = {};
	info.text = DUEL .. STATS;
	info.func = TitanPanelShowDuelStats;
	UIDropDownMenu_AddButton(info);
	
	TitanPanelRightClickMenu_AddSpacer();

	local info = {};
	info.text = SETTINGS;
	info.func = PvPLogConfigShow;
	UIDropDownMenu_AddButton(info);
	
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddToggleColoredText(TITAN_PVPLOG_ID);
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_PVPLOG_ID);
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_PVPLOG_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

function TitanPanelShowPvPStats()
	PvPLogStatsFrame:Hide();
	PVPLOG_STATS_TYPE = PVP;
	PvPLogStatsFrame:Show();
end

function TitanPanelShowDuelStats()
	PvPLogStatsFrame:Hide();
	PVPLOG_STATS_TYPE = DUEL;
	PvPLogStatsFrame:Show();
end

-- [[
-- Gather and Format PvP/Duel Stats
-- ]]
function updateAllStats()
	stats = PvPLogGetStats();
	
	PVPSTATS_PVP_WINS = stats.pvpWins;
	PVPSTATS_PVP_LOSSES = stats.pvpLoss;
	PVPSTATS_PVP_LEVEL_DIFF = (stats.pvpWinAvgLevelDiff + stats.pvpLossAvgLevelDiff);
	if(PVPSTATS_PVP_LEVEL_DIFF < 0) or (PVPSTATS_PVP_LEVEL_DIFF > 0) then
		PVPSTATS_PVP_LEVEL_DIFF = (floor((PVPSTATS_PVP_LEVEL_DIFF/2)*100)/100);
	else
		PVPSTATS_PVP_LEVEL_DIFF = 0;
	end
	PVPSTATS_DUEL_WINS = stats.duelWins;
	PVPSTATS_DUEL_LOSSES = stats.duelLoss;
	PVPSTATS_DUEL_LEVEL_DIFF = (stats.duelWinAvgLevelDiff + stats.duelLossAvgLevelDiff);
	if(PVPSTATS_DUEL_LEVEL_DIFF < 0) or (PVPSTATS_DUEL_LEVEL_DIFF > 0) then
		PVPSTATS_DUEL_LEVEL_DIFF = (floor((PVPSTATS_DUEL_LEVEL_DIFF/2)*100)/100);
	else
		PVPSTATS_DUEL_LEVEL_DIFF = 0;
	end
	PVPSTATS_TOTAL_WINS = stats.totalWins;
	PVPSTATS_TOTAL_LOSSES = stats.totalLoss;
	PVPSTATS_TOTAL_LEVEL_DIFF = (stats.totalWinAvgLevelDiff + stats.totalLossAvgLevelDiff);
	if(PVPSTATS_TOTAL_LEVEL_DIFF < 0) or (PVPSTATS_TOTAL_LEVEL_DIFF > 0) then
		PVPSTATS_TOTAL_LEVEL_DIFF = (math.floor((PVPSTATS_TOTAL_LEVEL_DIFF/2)*100)/100);
	else
		PVPSTATS_TOTAL_LEVEL_DIFF = 0;
	end
	setGankName(PVPSTATS_TOTAL_LEVEL_DIFF);
	fixStatColors();
end

function setGankName(lvlDiff)
	PVPSTATS_GANK_NAME = GANKLEVEL_A;
	if( lvlDiff <= -25 ) then
		PVPSTATS_GANK_NAME = GANKLEVEL_B;
	elseif( lvlDiff <= -20 ) then
		PVPSTATS_GANK_NAME = GANKLEVEL_C;
	elseif( lvlDiff <= -15 ) then
		PVPSTATS_GANK_NAME = GANKLEVEL_D;
	elseif( lvlDiff <= -12 ) then
		PVPSTATS_GANK_NAME = GANKLEVEL_E;
	elseif( lvlDiff <= -9 ) then
		PVPSTATS_GANK_NAME = GANKLEVEL_F;
	elseif( lvlDiff <= -6 ) then
		PVPSTATS_GANK_NAME = GANKLEVEL_G;
	elseif( lvlDiff <= -3 ) then
		PVPSTATS_GANK_NAME = GANKLEVEL_H;
	elseif( lvlDiff >= 8 ) then
		PVPSTATS_GANK_NAME = GANKLEVEL_I;
	elseif( lvlDiff >= 5 ) then
		PVPSTATS_GANK_NAME = GANKLEVEL_J;
	elseif( lvlDiff >= 4 ) then
		PVPSTATS_GANK_NAME = GANKLEVEL_K;
	elseif( lvlDiff >= 3 ) then
		PVPSTATS_GANK_NAME = GANKLEVEL_L;
	elseif( lvlDiff >= 2 ) then
		PVPSTATS_GANK_NAME = GANKLEVEL_M;
	elseif( lvlDiff >= 1 ) then
		PVPSTATS_GANK_NAME = GANKLEVEL_N;
	end
	if (TitanGetVar(TITAN_PVPLOG_ID, "ShowColoredText")) then
		if ( lvlDiff <= -3 ) then
			PVPSTATS_GANK_NAME = TitanUtils_GetRedText(PVPSTATS_GANK_NAME);
		else
			PVPSTATS_GANK_NAME = TitanUtils_GetGreenText(PVPSTATS_GANK_NAME);
		end
	end
end

function fixStatColors()
	if (TitanGetVar(TITAN_PVPLOG_ID, "ShowColoredText")) then
		PVPSTATS_TOTAL_WINS = TitanUtils_GetGreenText(PVPSTATS_TOTAL_WINS);
		PVPSTATS_TOTAL_LOSSES = TitanUtils_GetRedText(PVPSTATS_TOTAL_LOSSES);
		PVPSTATS_PVP_WINS = TitanUtils_GetGreenText(PVPSTATS_PVP_WINS);
		PVPSTATS_PVP_LOSSES = TitanUtils_GetRedText(PVPSTATS_PVP_LOSSES);
		PVPSTATS_DUEL_WINS = TitanUtils_GetGreenText(PVPSTATS_DUEL_WINS);
		PVPSTATS_DUEL_LOSSES = TitanUtils_GetRedText(PVPSTATS_DUEL_LOSSES);
		if (PVPSTATS_PVP_LEVEL_DIFF < 0) then
			PVPSTATS_PVP_LEVEL_DIFF = TitanUtils_GetRedText(PVPSTATS_PVP_LEVEL_DIFF);
		else
			PVPSTATS_PVP_LEVEL_DIFF = TitanUtils_GetGreenText(PVPSTATS_PVP_LEVEL_DIFF);
		end
		if (PVPSTATS_DUEL_LEVEL_DIFF < 0) then
			PVPSTATS_DUEL_LEVEL_DIFF  = TitanUtils_GetRedText(PVPSTATS_DUEL_LEVEL_DIFF);
		else
			PVPSTATS_DUEL_LEVEL_DIFF  = TitanUtils_GetGreenText(PVPSTATS_DUEL_LEVEL_DIFF);
		end
		if (PVPSTATS_TOTAL_LEVEL_DIFF < 0) then
			PVPSTATS_TOTAL_LEVEL_DIFF = TitanUtils_GetRedText(PVPSTATS_TOTAL_LEVEL_DIFF);
		else
			PVPSTATS_TOTAL_LEVEL_DIFF = TitanUtils_GetGreenText(PVPSTATS_TOTAL_LEVEL_DIFF);
		end
	end
end
