TITAN_AGGRO_VERSION = "2.8.9";
TITAN_AGGRO_ID = "Aggro";
TITAN_AGGRO_NAME = "Titan [Aggro]";
TITAN_AGGRO_MENU_TEXT = "Titan Aggro v"..TITAN_AGGRO_VERSION;
TITAN_AGGRO_BUTTON_TEXT = "%s";
TITAN_AGGRO_FREQUENCY=1;
--TITAN_AGGRO_DEBUG=1;

AggroVars = {};
AggroVars.ReportMatrix = {
-- tanks
	["WARRIOR"] = { [8] = true, [9] = true },
	["PALADIN"] = { [2] = true, [8] = true },
-- melee/ranged
	["HUNTER"] = { [2] = true, [3] = true, [4] = true },
	["ROGUE"] = { [2] = true, [3] = true, [4] = true },
	["SHAMAN"] = { [2] = true, [3] = true, [5] = true  },
-- casters
	["MAGE"] = { [2] = true, [3] = true, [5] = true, [6] = true },
	["WARLOCK"] = { [2] = true, [3] = true, [5] = true, [6] = true },
-- healers
	["DRUID"] = { [2] = true, [5] = true, [7] = true },
	["PRIEST"] = { [2] = true, [5] = true, [7] = true },
}

AggroVars.Classes = {
	[1] = "DRUID",
	[2] = "HUNTER",
	[3] = "MAGE",
	[4] = "PALADIN",
	[5] = "PRIEST",
	[6] = "ROGUE",
	[7] = "SHAMAN",
	[8] = "WARRIOR",
	[9] = "WARLOCK",
	[10] = "PLAYER",
}

AggroVars.ColorizeManaBar = {
	["WARRIOR"] = { r=0.5, g=0, b=0  },
	["ROGUE"] =   { r=0.5, g=0.5, b=0 },
	["PALADIN"] = { r=0, g=0, b=0.5 },
	["HUNTER"] =  { r=0, g=0, b=0.5 },
	["MAGE"] =    { r=0, g=0, b=0.5 },
	["WARLOCK"] = { r=0, g=0, b=0.5 },
	["DRUID"] =   { r=0, g=0, b=0.5 },
	["PRIEST"] =  { r=0, g=0, b=0.5 },
}

-- Do not touch any of those below
AggroVars.Cycles=0;
AggroVars.LastReport=0;
AggroVars.LastTitanPanel_Pos=nil;
AggroVars.PrevTarget = { name = "", source = "", class = "" };
AggroVars.LastSavedTarget = nil;
AggroVars.ConfigLoaded = nil;
AggroVars.LastColor = GRAY_FONT_COLOR;
AggroVars.LastTargetIsPlayer = nil;
AggroVars.UseCache = nil;
AggroVars.Inactive = nil;
AggroVars.ToTTable = {};
AggroVars.MobToTTable = {};
AggroVars.LastUpdateAggroList = 0;
AggroVars.ScanFreq = 1;
AggroVars.TitanPanel = nil;
AggroVars.Timer = 0;
if (TITAN_VERSION or TITAN_PANEL_FROM_TOP_MAIN or TitanPanelBarButton_OnEvent) then
	AggroVars.TitanPanel = 1;
else
	AggroVars.TTHP_Relocated = 100;
end
AggroVars.SessionSettings = {};
AggroVars.LastReportedSource = "";
AggroVars.LastReportedTarget = "";

if (not RED_FONT_COLOR_CODE) then
	RED_FONT_COLOR_CODE = "|cffff2020";
end
if (not NORMAL_FONT_COLOR_CODE) then
	NORMAL_FONT_COLOR_CODE = "|cffffd200";
end
if (not WHITE_FONT_COLOR_CODE) then
	WHITE_FONT_COLOR_CODE = "|cffffffff";
end
if (not GREEN_FONT_COLOR_CODE) then
	GREEN_FONT_COLOR_CODE = "|cff20ff20";
end
if (not BLUE_FONT_COLOR_CODE) then
	BLUE_FONT_COLOR_CODE = "|cff2020ff";
end
AggroVars.ReportChans2Command = {
	[0] = "Console",
	[1] = "Screen",
	[2] = "Say",
	[3] = "Yell",
	[4] = "Party",
	[5] = "Raid",
	[6] = "Guild",
	[7] = "CT_RaidAssist",
}
if (not ADDON_MENU) then
	ADDON_MENU = "Addon Config";
end