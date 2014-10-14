--FactionGrinder 1.0
--Written By Tiok - US Thrall

FACTIONGRINDER_PREFIX = "FACTIONGRINDER";

FG_RED      = "|cffff0000";
FG_GREEN    = "|cff00ff00";
FG_BLUE     = "|cff0000ff";
FG_YELLOW   = "|cffffff00";
FG_WHITE    = "|cffffffff";
FG_GREY     = "|cffaaaaaa";
FG_GRELLOW  = "|cffaaff00";
FG_GRUE     = "|cff00ff50";
FG_EPIC     = "|cffa436ee"; --that epic purpley color
FG_SUPERIOR = "|cff0071df"; --that superior bluey color

FG_TEXT=
{
    ["Faction Grinder"] = "Faction Grinder";
    ["Display Settings"] = "Display Settings";
    ["General Settings"] = "General Settings";
    ["Turn-ins"] = "Turn-ins";
    ["Grind Stats"] = "Grind Stats";

    ["Include Bank Bags"] = "Include Bank Bags";
    ["Include Items on Alts"] = "Include Items on Alts";
    ["Recount Items"] = "Recount Items";

    ["Toggle Selected Trackers\tLeft-Click\nToggle Settings Screen\tRight-Click"] = "Toggle Selected Trackers\tLeft-Click\nToggle Settings Screen\tRight-Click";
    ["FUBAR_Toggle Selected Trackers\tLeft-Click\nToggle Settings Screen\tRight-Click"] = "Toggle Selected Trackers     Left-Click\nToggle Settings Screen     Right-Click";

    ["Argent Dawn"] = "Argent Dawn";
    ["Argent Dawn Cauldrons"] = "Argent Dawn Cauldrons";
    ["Cenarion Circle"] = "Cenarion Circle";
    ["Cenarion Circle Summons"] = "Cenarion Circle Summons";
    ["Timbermaw Hold"] = "Timbermaw Hold";
    ["Wildhammer Clan"] = "Wildhammer Clan";
    ["Wintersaber Trainers"] = "Wintersaber Trainers";

    ["Not Grinding"] = "Not Grinding";
    ["Grinding"] = "Grinding";
    ["Start Grinding"] = "Start Grinding";
    ["Stop Grinding"] = "Stop Grinding";
    ["Today's Grinding"] = "Today's Grinding";
    ["Total Grinding"] = "Total Grinding";
    ["Time"] = "Time";
    ["Rep"] = "Rep";
    ["rep"] = "rep";
    ["Rep Value"] = "Rep Value";
    ["Rep/Hour"] = "Rep/Hour";
    ["Rep-up In"] = "Rep-up In";
    ["to rep-up"] = "to rep-up";

    ["day abbreviation"] = "d";
    ["hour abbreviation"] = "h";
    ["minute abbreviation"] = "m";
    ["second abbreviation"] = "s";

    ["Human"] = "Human";
};

function FactionGrinder_OnLoad()
    FactionGrinder_RegisterEvents();
    FactionGrinder_RegisterSlashCommands();
end

function FactionGrinder_RegisterEvents()
    this:RegisterEvent("VARIABLES_LOADED");
    this:RegisterEvent("ADDON_LOADED");
end

function FactionGrinder_RegisterSlashCommands()
    SLASH_fgShow1 = "/fg";
    SlashCmdList["fgShow"] = function()
	FactionGrinder_ToggleFrameDisplay(not FactionGrinderSettings["Show Frames"]);
    end

    SLASH_fgSettings1 = "/fgs";
    SlashCmdList["fgSettings"] = function()
	local frame = getglobal("FactionGrinderSettingsFrame");
	if(frame:IsVisible())then
	    frame:Hide();
	else
	    frame:Show();
	end
    end
end

function FactionGrinder_Init()
    if((FactionGrinderSettings==nil)or(FactionGrinderSettings["Version"] < 1.0))then
	FactionGrinderSettings = 
	{
	    ["Version"] = 1.0;
	    ["Include Bank Bags"] = false;
	    ["Include Items on Alts"] = false;
	    ["Show Frames"] = false;

	    ["Show"]=
	    {
		--Argent Dawn
		["ArgentDawnGrinderDisplayFrame"] = 0;
		["ArgentDawnGrinderCauldronFrame"] = 0;
		["ArgentDawnGrinderGrindFrame"] = 0;
		--Cenarion Circle
		["CenarionCircleGrinderDisplayFrame"] = 0;
		["CenarionCircleGrinderSummonsFrame"] = 0;
		["CenarionCircleGrinderGrindFrame"] = 0;
		--Timbermaw Hold
		["TimbermawHoldGrinderDisplayFrame"] = 0;
		["TimbermawHoldGrinderGrindFrame"] = 0;
		--Wintersaber Trainers
		["WintersaberTrainersGrinderDisplayFrame"] = 0;
		["WintersaberTrainersGrinderGrindFrame"] = 0;
	    };
	};
    end
end

function FactionGrinder_OnEvent()
    if ( event == "VARIABLES_LOADED" ) then
        FactionGrinder_Init();
    elseif((event=="ADDON_LOADED")and(arg1=="FactionGrinder"))then
	FactionGrinder_LoadConfiguration();
    end
end

function FactionGrinder_LoadConfiguration()
    --Match the "settings" display to the saved variables.
    if(FactionGrinderSettings ~= nil)and(FactionGrinderSettings["Show"] ~= nil)then
    	for frame,frameshow in pairs(FactionGrinderSettings["Show"])do
	    getglobal("FG_CB_"..frame):SetChecked(frameshow);
    	end
    	FactionGrinder_ToggleFrameDisplay(FactionGrinderSettings["Show Frames"]);
    end
    if(FactionGrinderSettings ~= nil)then
    	getglobal("FG_CB_IncludeBankBags"):SetChecked(FactionGrinderSettings["Include Bank Bags"]);
    	getglobal("FG_CB_IncludeItemsOnAlts"):SetChecked(FactionGrinderSettings["Include Items on Alts"]);
    end

    if(GetLocale()=="deDE")then
	FG_TEXT = FG_TEXT_DE;

	getglobal("FG_GrindStatsLabel"):SetPoint("TOPLEFT","FactionGrinderSettingsFrame","TOPLEFT",200,-32);
	getglobal("FG_CB_IncludeBankBags"):SetPoint("TOPLEFT","FactionGrinderGeneralSettingsFrame","TOPLEFT",20,-33);
	getglobal("FG_CB_IncludeItemsOnAlts"):SetPoint("TOPLEFT","FactionGrinderGeneralSettingsFrame","TOPLEFT",20,-53);
	getglobal("FG_BU_RecountItems"):SetWidth(180);
    elseif(GetLocale()=="frFR")then
	FG_TEXT = FG_TEXT_FR;
    elseif(GetLocale()=="zhTW")then
	FG_TEXT = FG_TEXT_ZHTW;

	getglobal("FactionGrinderSettingsFrame"):SetWidth(300);
	getglobal("FG_TurninLabel"):SetPoint("TOPLEFT","FactionGrinderSettingsFrame","TOPLEFT",160,-42);
	getglobal("FG_GrindStatsLabel"):SetPoint("TOPLEFT","FactionGrinderSettingsFrame","TOPLEFT",225,-42);
	getglobal("ArgentDawnTexture"):SetPoint("TOPLEFT","FactionGrinderSettingsFrame","TOPLEFT",208,-60)
	getglobal("CenarionCircleTexture"):SetPoint("TOPLEFT","FactionGrinderSettingsFrame","TOPLEFT",208,-100)
	getglobal("TimbermawHoldTexture"):SetPoint("TOPLEFT","FactionGrinderSettingsFrame","TOPLEFT",208,-135)
	getglobal("WintersaberTrainersTexture"):SetPoint("TOPLEFT","FactionGrinderSettingsFrame","TOPLEFT",208,-165);
    end

    --Localize all text variables.
    getglobal("FG_SettingsFrameHeader"):SetText(FG_TEXT["Faction Grinder"]);
    getglobal("FG_DisplaySettingsHeader"):SetText(FG_TEXT["Display Settings"]);
    getglobal("FG_GeneralSettingsHeader"):SetText(FG_TEXT["General Settings"]);
    getglobal("FG_CB_IncludeBankBagsText"):SetText(FG_TEXT["Include Bank Bags"]);
    getglobal("FG_CB_IncludeItemsOnAltsText"):SetText(FG_TEXT["Include Items on Alts"]);
    getglobal("FG_BU_RecountItemsText"):SetText(FG_TEXT["Recount Items"]);
    getglobal("FG_TurninLabel"):SetText(FG_TEXT["Turn-ins"]);
    getglobal("FG_GrindStatsLabel"):SetText(FG_TEXT["Grind Stats"]);

    getglobal("FG_ArgentDawnLabel"):SetText(FG_TEXT["Argent Dawn"]);
    getglobal("FG_ArgentDawnCauldronsLabel"):SetText(FG_TEXT["Argent Dawn Cauldrons"]);
    getglobal("FG_CenarionCircleLabel"):SetText(FG_TEXT["Cenarion Circle"]);
    getglobal("FG_CenarionCircleSummonsLabel"):SetText(FG_TEXT["Cenarion Circle Summons"]);
    getglobal("FG_TimbermawHoldLabel"):SetText(FG_TEXT["Timbermaw Hold"]);
    getglobal("FG_WintersaberTrainersLabel"):SetText(FG_TEXT["Wintersaber Trainers"]);
end

function FactionGrinder_SetShowVar(frame,frameshow)
    if(frameshow)then
        FactionGrinderSettings["Show"][frame] = 1;
    else
	FactionGrinderSettings["Show"][frame] = 0;
    end
end

function FactionGrinder_ToggleFrameDisplay(show)
    local AtLeastOneDisplayed = false;
    FactionGrinderSettings["Show Frames"] = show;

    for frame,frameshow in pairs(FactionGrinderSettings["Show"])do
	AtLeastOneDisplayed = AtLeastOneDisplayed or frameshow;
	if(show)and(frameshow==1)then
	    getglobal(frame):Show();
	else
	    getglobal(frame):Hide();
	end
    end

    FactionGrinderSettings["Show Frames"] = (show and AtLeastOneDisplayed);
end

function FactionGrinder_SecondsToTime(seconds)
    seconds = math.floor(seconds);
    local daysonly = math.floor(seconds/86400);
    seconds = seconds - (daysonly*86400);
    local hoursonly = math.floor(seconds/3600);
    seconds = seconds - (hoursonly*3600);
    local minutesonly = math.floor(seconds/60);
    seconds = seconds - (minutesonly*60);

    return daysonly..FG_TEXT["day abbreviation"].." "..hoursonly..FG_TEXT["hour abbreviation"].." "..minutesonly..FG_TEXT["minute abbreviation"].." "..seconds..FG_TEXT["second abbreviation"];
end
