--WintersaberTrainersGrinder 1.0
--Written By Tiok - US Thrall

WTG_INITIALREP = 0;

WTG_NOW_GRINDING = false;
WTG_PREVIOUS_GRINDING_TIME = 0;
WTG_GRINDING_STARTED_AT = 0;
WTG_PREVIOUS_REP_GROUND = 0;

WTG_GRIND_UPDATE_INTERVAL = 1;
WTG_NEXT_GRIND_UPDATE = 0;

WTG_REP_VALUE = 0;

WTG_TEXT = 
{
    ["Wintersaber Trainers Faction Name"] = "Wintersaber Trainers";
    ["WT Rep"] = "WT Rep";

    ["Frostsaber Provisions"] = "Frostsaber Provisions";
    ["Chillwind Meat"] = "Chillwind Meat";
    ["Shardtooth Meat"] = "Shardtooth Meat";

    ["Winterfall Intrusion"] = "Winterfall Intrusion";
    ["Winterfall Shaman slain"] = "Winterfall Shaman slain";
    ["Winterfall Ursa slain"] = "Winterfall Ursa slain";

    ["Rampaging Giants"] = "Rampaging Giants";
    ["Frostmaul Giant slain"] = "Frostmaul Giant slain";
    ["Frostmaul Preserver slain"] = "Frostmaul Preserver slain";

    ["Quests to Rep-up"] = "Quests to Rep-up";
    ["Quests to Exalted"] = "Quests to Exalted";
}

function WintersaberTrainersGrinder_RegisterEvents()
    this:RegisterEvent("ADDON_LOADED");
    this:RegisterEvent("VARIABLES_LOADED");
    this:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE");
    this:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE");
    this:RegisterEvent("QUEST_LOG_UPDATE");
    this:RegisterEvent("PLAYER_LEAVING_WORLD");
    --add event registrations here
end

function WintersaberTrainersGrinder_Init()
    WTG_NEXT_GRIND_UPDATE = GetTime()+WTG_GRIND_UPDATE_INTERVAL;
    --add variable initializations here

    GrinderCore_RegisterItem("WintersaberTrainersGrinder","Chillwind Meat","12623");
    GrinderCore_RegisterItem("WintersaberTrainersGrinder","Shardtooth Meat","12622");

    WintersaberTrainersGrinder_UpdateDisplayData();
    WintersaberTrainersGrinder_UpdateRepBars();
end

function WintersaberTrainersGrinder_UpdateDisplayData()
    local repValue = 0;

    local textColor, itemName;

    local ChillwindMeatCount;
    itemName = "Chillwind Meat";
    if(FactionGrinderSettings["Include Bank Bags"])then
	ChillwindMeatCount = GrinderCore_PlayerTotalCount(itemName);
    else
	ChillwindMeatCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    if(ChillwindMeatCount == 5)then
	ChillwindMeatCount = FG_WHITE..ChillwindMeatCount;
    else
	ChillwindMeatCount = FG_GREY..ChillwindMeatCount;
    end
    getglobal("WTG_ChillwindMeatCount"):SetText(ChillwindMeatCount.."/5");

    local ShardtoothMeatCount;
    itemName = "Shardtooth Meat";
    if(FactionGrinderSettings["Include Bank Bags"])then
	ShardtoothMeatCount = GrinderCore_PlayerTotalCount(itemName);
    else
	ShardtoothMeatCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    if(ShardtoothMeatCount == 5)then
	ShardtoothMeatCount = FG_WHITE..ShardtoothMeatCount;
    else
	ShardtoothMeatCount = FG_GREY..ShardtoothMeatCount;
    end
    getglobal("WTG_ShardtoothMeatCount"):SetText(ShardtoothMeatCount.."/5");

    if(ShardtoothMeatCount == FG_WHITE..(5))and(ChillwindMeatCount == FG_WHITE..(5)) then
	repValue = repValue + 50;
    end

    --Now check if the two kill quests are in the log.  If they are, then show the number of kills.
    local WinterfallIntrusionIndex = -1;
    local RampagingGiantsIndex = -1;

    for qi=1,GetNumQuestLogEntries(),1 do
	if(GetQuestLogTitle(qi) == WTG_TEXT["Winterfall Intrusion"])then
	    WinterfallIntrusionIndex = qi;
	    local o1done,o2done;
	    local desc,_,o1done = GetQuestLogLeaderBoard(1,qi);
	    local count = string.sub(desc,string.len(desc)-2,string.len(desc));
	    if(count=="5/5")then desc = FG_WHITE..desc; else desc = FG_GREY..desc; end
	    getglobal("WTG_WinterfallIntrusionObjective1"):SetText(desc);
	    desc,_,o2done = GetQuestLogLeaderBoard(2,qi);
	    count = string.sub(desc,string.len(desc)-2,string.len(desc))
	    if(count=="5/5")then desc = FG_WHITE..desc; else desc = FG_GREY..desc; end
	    getglobal("WTG_WinterfallIntrusionObjective2"):SetText(desc);
	    if(o1done==1)and(o2done==1)then
		repValue = repValue + 50;
	    end
        elseif(GetQuestLogTitle(qi) == WTG_TEXT["Rampaging Giants"])then
	    RampagingGiantsIndex = qi;
	    local o1done,o2done;
	    local desc,_,o1done = GetQuestLogLeaderBoard(1,qi);
	    local count = string.sub(desc,string.len(desc)-2,string.len(desc));
	    if(count=="5/5")then desc = FG_WHITE..desc; else desc = FG_GREY..desc; end
	    getglobal("WTG_RampagingGiantsObjective1"):SetText(desc);
	    desc,_,o2done = GetQuestLogLeaderBoard(2,qi);
	    count = string.sub(desc,string.len(desc)-2,string.len(desc))
	    if(count=="5/5")then desc = FG_WHITE..desc; else desc = FG_GREY..desc; end
	    getglobal("WTG_RampagingGiantsObjective2"):SetText(desc);
	    if(o1done==1)and(o2done==1)then
		repValue = repValue + 50;
	    end
	end
    end

    if(WinterfallIntrusionIndex == -1)then
	getglobal("WTG_WinterfallIntrusionObjective1"):SetText(FG_GREY..WTG_TEXT["Winterfall Shaman slain"]..": 0/5");
	getglobal("WTG_WinterfallIntrusionObjective2"):SetText(FG_GREY..WTG_TEXT["Winterfall Ursa slain"]..": 0/5");
    end

    if(RampagingGiantsIndex == -1)then
	getglobal("WTG_RampagingGiantsObjective1"):SetText(FG_GREY..WTG_TEXT["Frostmaul Giant slain"]..": 0/5");
	getglobal("WTG_RampagingGiantsObjective2"):SetText(FG_GREY..WTG_TEXT["Frostmaul Preserver slain"]..": 0/5");
    end

    if(UnitRace("player") == FG_TEXT["Human"])then
	repValue = repValue * 1.1;
    end

    getglobal("WTG_RepValue"):SetText(FG_TEXT["Rep Value"].." : "..repValue);
    if(WTG_REP_VALUE ~= repValue)then
        WTG_REP_VALUE = repValue;
	WintersaberTrainersGrinder_UpdateRepBars();
    end

    --Calculate how many quests to rep-up and exalted.
    local RepToRepUp=0;
    local RepToExalted=0;
    for factionIndex = 1, GetNumFactions() do
        factionName, description, standingId, bottomValue, topValue, earnedValue, atWarWith,
        canToggleAtWar, isHeader, isCollapsed, isWatched = GetFactionInfo(factionIndex)
        if ((isHeader == nil)and(string.find(factionName, WTG_TEXT["Wintersaber Trainers Faction Name"]))) then
	    if(standingId == 8)then --exalted
		break;
	    else
		RepToRepUp = math.max(topValue-earnedValue-WTG_REP_VALUE,0);
		RepToExalted = math.max(42000-earnedValue-WTG_REP_VALUE,0);
	    end
	end
    end

    local fifty=50;
    if(UnitRace("player")==FG_TEXT["Human"])then fifty=55; end

    getglobal("WTG_QuestsToRepUp"):SetText(WTG_TEXT["Quests to Rep-up"]..": "..math.floor((RepToRepUp/fifty)+0.9999));
    getglobal("WTG_QuestsToExalted"):SetText(WTG_TEXT["Quests to Exalted"]..": "..math.floor((RepToExalted/fifty)+0.9999));
end

function WintersaberTrainersGrinder_ToggleDisplay(frameName)
   local frame = getglobal(frameName)
   if (frame) then
   if(frame:IsVisible()) then
      frame:Hide();
   else
      frame:Show();
   end
   end
end

function WintersaberTrainersGrinder_OnLoad()
    WintersaberTrainersGrinder_RegisterEvents();
end

function WintersaberTrainersGrinder_OnEvent()
    if ( event == "VARIABLES_LOADED" ) then    
        WintersaberTrainersGrinder_Init();
    elseif((event == "ADDON_LOADED") and (arg1 == "FactionGrinder"))then
	WintersaberTrainersGrinder_LoadConfiguration();
    elseif(event == "CHAT_MSG_CHANNEL_NOTICE")then
	this:UnregisterEvent("CHAT_MSG_CHANNEL_NOTICE");
	WintersaberTrainersGrinder_UpdateDisplayData();
	WintersaberTrainersGrinder_UpdateRepBars();
    elseif( event == "CHAT_MSG_COMBAT_FACTION_CHANGE")then
	WintersaberTrainersGrinder_UpdateRepBars();
    elseif( event == "QUEST_LOG_UPDATE")then
	WintersaberTrainersGrinder_UpdateDisplayData();
    elseif( event == "PLAYER_LEAVING_WORLD" )then
	GrinderCore_SetGrindingTime("Wintersaber Trainers",GrinderCore_GetGrindingTime("Wintersaber Trainers")+WTG_PREVIOUS_GRINDING_TIME);
	GrinderCore_SetRepGround("Wintersaber Trainers",GrinderCore_GetRepGround("Wintersaber Trainers")+WTG_PREVIOUS_REP_GROUND);
	if(WTG_NOW_GRINDING)then
	    GrinderCore_SetGrindingTime("Wintersaber Trainers",GrinderCore_GetGrindingTime("Wintersaber Trainers")+(GetTime()-WTG_GRINDING_STARTED_AT));
	    GrinderCore_SetRepGround("Wintersaber Trainers",GrinderCore_GetRepGround("Wintersaber Trainers")+(WTG_GetCurrentRepTotal() - WTG_INITIALREP));
	end
    end
end

function WintersaberTrainersGrinder_LoadConfiguration()
    --this is where we would load the localization values if needed
    if(GetLocale() == "deDE") then
    	WTG_TEXT = WTG_TEXT_DE;
	--Reconstruct Display frame
	getglobal("WintersaberTrainersGrinderDisplayFrame"):SetWidth(220);

	--Reconstruct Grind-Tracker frame
	getglobal("WintersaberTrainersGrinderGrindFrame"):SetWidth(215);
	getglobal("WTG_TimeTodayVal"):SetPoint("TOPLEFT","WintersaberTrainersGrinderGrindFrame","TOPLEFT",108,-68);
	getglobal("WTG_RepTodayVal"):SetPoint("TOPLEFT","WintersaberTrainersGrinderGrindFrame","TOPLEFT",108,-79);
	getglobal("WTG_RepPerHourTodayVal"):SetPoint("TOPLEFT","WintersaberTrainersGrinderGrindFrame","TOPLEFT",108,-90);
	getglobal("WTG_TimeToRepUpTodayVal"):SetPoint("TOPLEFT","WintersaberTrainersGrinderGrindFrame","TOPLEFT",108,-101);
	getglobal("WTG_TimeTotalVal"):SetPoint("TOPLEFT","WintersaberTrainersGrinderGrindFrame","TOPLEFT",108,-133);
	getglobal("WTG_RepTotalVal"):SetPoint("TOPLEFT","WintersaberTrainersGrinderGrindFrame","TOPLEFT",108,-144);
	getglobal("WTG_RepPerHourTotalVal"):SetPoint("TOPLEFT","WintersaberTrainersGrinderGrindFrame","TOPLEFT",108,-155);
	getglobal("WTG_TimeToRepUpTotalVal"):SetPoint("TOPLEFT","WintersaberTrainersGrinderGrindFrame","TOPLEFT",108,-166);
    elseif(GetLocale() == "frFR")then
	WTG_TEXT = WTG_TEXT_FR;

	--Reconstruct Grind-Tracker frame
	getglobal("WTG_BU_ToggleGrinding"):SetWidth(144);
    elseif(GetLocale() == "zhTW")then
	WTG_TEXT = WTG_TEXT_ZHTW;

	getglobal("WTG_RepValue"):SetFontObject(GameFontNormalSmall);
	getglobal("WTG_WTRep"):SetFontObject(GameFontNormalSmall);

	--Reconstruct Grind-Tracker frame
        getglobal("WTGToRepUpFrame"):SetWidth(90);
    	getglobal("WTG_SB_ActualRep"):SetWidth(80);
    	getglobal("WTG_SB_RepWithItems"):SetWidth(80);

	getglobal("WintersaberTrainersGrinderGrindFrame"):SetWidth(215);
	getglobal("WTG_CurrentlyGrinding"):SetFontObject(GameFontNormalSmall);
	getglobal("WTG_Today"):SetFontObject(GameFontNormalSmall);
	getglobal("WTG_TimeToday"):SetFontObject(GameFontNormalSmall);
	getglobal("WTG_RepToday"):SetFontObject(GameFontNormalSmall);
	getglobal("WTG_RepPerHourToday"):SetFontObject(GameFontNormalSmall);
	getglobal("WTG_TimeToRepUpToday"):SetFontObject(GameFontNormalSmall);
	getglobal("WTG_Total"):SetFontObject(GameFontNormalSmall);
	getglobal("WTG_TimeTotal"):SetFontObject(GameFontNormalSmall);
	getglobal("WTG_RepTotal"):SetFontObject(GameFontNormalSmall);
	getglobal("WTG_RepPerHourTotal"):SetFontObject(GameFontNormalSmall);
	getglobal("WTG_TimeToRepUpTotal"):SetFontObject(GameFontNormalSmall);
        getglobal("WTG_TimeTodayVal"):SetPoint("TOPLEFT","WintersaberTrainersGrinderGrindFrame","TOPLEFT",108,-68);
	getglobal("WTG_RepTodayVal"):SetPoint("TOPLEFT","WintersaberTrainersGrinderGrindFrame","TOPLEFT",108,-79);
	getglobal("WTG_RepPerHourTodayVal"):SetPoint("TOPLEFT","WintersaberTrainersGrinderGrindFrame","TOPLEFT",108,-90);
	getglobal("WTG_TimeToRepUpTodayVal"):SetPoint("TOPLEFT","WintersaberTrainersGrinderGrindFrame","TOPLEFT",108,-101);
	getglobal("WTG_TimeTotalVal"):SetPoint("TOPLEFT","WintersaberTrainersGrinderGrindFrame","TOPLEFT",108,-133);
	getglobal("WTG_RepTotalVal"):SetPoint("TOPLEFT","WintersaberTrainersGrinderGrindFrame","TOPLEFT",108,-144);
	getglobal("WTG_RepPerHourTotalVal"):SetPoint("TOPLEFT","WintersaberTrainersGrinderGrindFrame","TOPLEFT",108,-155);
	getglobal("WTG_TimeToRepUpTotalVal"):SetPoint("TOPLEFT","WintersaberTrainersGrinderGrindFrame","TOPLEFT",108,-166);
    end
    
    --now that the localization has been loaded, let's set all text variables appropriately
    
    getglobal("WTG_WTRep"):SetText(WTG_TEXT["WT Rep"]);
    getglobal("WTG_FrostsaberProvisions"):SetText(WTG_TEXT["Frostsaber Provisions"]);
    getglobal("WTG_WinterfallIntrusion"):SetText(WTG_TEXT["Winterfall Intrusion"]);
    getglobal("WTG_RampagingGiants"):SetText(WTG_TEXT["Rampaging Giants"]);
    
    getglobal("WTG_BU_ToggleGrinding"):SetText(FG_TEXT["Start Grinding"]);
    getglobal("WTG_CurrentlyGrinding"):SetText(FG_RED..FG_TEXT["Not Grinding"]);

    getglobal("WTG_Today"):SetText(FG_WHITE..FG_TEXT["Today's Grinding"]);
    getglobal("WTG_TimeToday"):SetText(FG_GREY..FG_TEXT["Time"].." :");
    getglobal("WTG_RepToday"):SetText(FG_GREY..FG_TEXT["Rep"].." :");
    getglobal("WTG_RepPerHourToday"):SetText(FG_GREY..FG_TEXT["Rep/Hour"].." :");
    getglobal("WTG_Total"):SetText(FG_WHITE..FG_TEXT["Total Grinding"]);
    getglobal("WTG_TimeTotal"):SetText(FG_GREY..FG_TEXT["Time"].." :");
    getglobal("WTG_RepTotal"):SetText(FG_GREY..FG_TEXT["Rep"].." :");
    getglobal("WTG_RepPerHourTotal"):SetText(FG_GREY..FG_TEXT["Rep/Hour"].." :");
    getglobal("WTG_TimeToRepUpToday"):SetText(FG_GREY..FG_TEXT["Rep-up In"].." :");
    getglobal("WTG_TimeToRepUpTotal"):SetText(FG_GREY..FG_TEXT["Rep-up In"].." :");
end

function WintersaberTrainersGrinder_UpdateRepBars()
    local repPercent = 0;
    local itemPercent = 0;
    local totalPercent = 0;
    for factionIndex = 1, GetNumFactions() do
        factionName,_,standingId,_,_,earnedValue,_,_,isHeader,_,_ = GetFactionInfo(factionIndex)
        if ((isHeader == nil)and(string.find(factionName, WTG_TEXT["Wintersaber Trainers Faction Name"]))) then
            if(standingId==8)then --Exalted
		getglobal("WTG_SB_ActualRep"):SetValue(100);
		repPercent = 100;
		itemPercent = math.floor(WTG_REP_VALUE/42)/10;
	    elseif(standingId==7)then --Revered
		getglobal("WTG_SB_ActualRep"):SetValue(math.floor((earnedValue-21000)/21000*100));
		getglobal("WTG_SB_RepWithItems"):SetValue(math.min(100,math.floor((earnedValue+WTG_REP_VALUE-21000)/210)));
		repPercent = math.floor((earnedValue-21000)/21)/10;
		itemPercent = math.floor(WTG_REP_VALUE/21)/10;
	    elseif(standingId==6)then --Honored
		getglobal("WTG_SB_ActualRep"):SetValue(math.floor((earnedValue-9000)/12000*100));
		getglobal("WTG_SB_RepWithItems"):SetValue(math.min(100,math.floor((earnedValue+WTG_REP_VALUE-9000)/120)));
		repPercent = math.floor((earnedValue-9000)/12)/10;
		itemPercent = math.floor(WTG_REP_VALUE/12)/10;
	    elseif(standingId==5)then --Friendly
		getglobal("WTG_SB_ActualRep"):SetValue(math.floor((earnedValue-3000)/6000*100));
		getglobal("WTG_SB_RepWithItems"):SetValue(math.min(100,math.floor((earnedValue+WTG_REP_VALUE-3000)/60)));
		repPercent = math.floor((earnedValue-3000)/6)/10;
		itemPercent = math.floor(WTG_REP_VALUE/6)/10;
	    elseif(standingId==4)then --Neutral
		getglobal("WTG_SB_ActualRep"):SetValue(math.floor(earnedValue/3000*100));
		getglobal("WTG_SB_RepWithItems"):SetValue(math.min(100,math.floor((earnedValue+WTG_REP_VALUE)/30)));
		repPercent = math.floor(earnedValue/3)/10;
		itemPercent = math.floor(WTG_REP_VALUE/3)/10;
	    elseif(standingId==3)then --Unfriendly (-3000 to 0)
		getglobal("WTG_SB_ActualRep"):SetValue(math.floor((3000+earnedValue)/3000*100));
		getglobal("WTG_SB_RepWithItems"):SetValue(math.min(100,math.floor((3000+earnedValue+WTG_REP_VALUE)/30)));
		repPercent = math.floor((3000+earnedValue)/3)/10;
		itemPercent = math.floor(WTG_REP_VALUE/3)/10;
	    elseif(standingId==2)then --Hostile (-6000 to -3000)
		getglobal("WTG_SB_ActualRep"):SetValue(math.floor((6000+earnedValue)/3000*100));
		getglobal("WTG_SB_RepWithItems"):SetValue(math.min(100,math.floor((6000+earnedValue+WTG_REP_VALUE)/30)));
		repPercent = math.floor((6000+earnedValue)/3)/10;
		itemPercent = math.floor(WTG_REP_VALUE/3)/10;
	    elseif(standingId==1)then --Hated (-42000 to -6000)
		getglobal("WTG_SB_ActualRep"):SetValue(math.floor((42000+earnedValue)/36000*100));
		getglobal("WTG_SB_RepWithItems"):SetValue(math.min(100,math.floor((42000+earnedValue+WTG_REP_VALUE)/360)));
		repPercent = math.floor((42000+earnedValue)/36)/10;
		itemPercent = math.floor(WTG_REP_VALUE/36)/10;
            end
        end
    end
    totalPercent = repPercent + itemPercent;
    getglobal("WTG_RepPercent"):SetText("|cff00ff00"..repPercent.."% |caaaaaaaa+ |cffffff00"..itemPercent.."% |caaaaaaaa\226\137\136 |cff88ff00"..totalPercent.."%");
end

function WintersaberTrainersGrinder_ShowTurninToolTip(text,color)
    local RepToRepUp = 0;
    for factionIndex = 1, GetNumFactions() do
        factionName,_,standingId,_,topValue,earnedValue,_,_,isHeader,_,_ = GetFactionInfo(factionIndex)
        if ((isHeader == nil)and(string.find(factionName, WTG_TEXT["Wintersaber Trainers Faction Name"]))) then
	    if(standingId == 8)then --exalted
		RepToRepUp = 0;
	    else
		RepToRepUp = math.max(topValue-earnedValue-WTG_REP_VALUE,0);
	    end
	end
    end

    local fifty = 50;

    local race = UnitRace("player");
    if race == FG_TEXT["Human"] then
	fifty = 55;
    end

    local tooltip = getglobal("WTGToolTip");
    tooltip:SetOwner(button,"ANCHOR_TOPLEFT",0,0);
    tooltip:ClearLines();
    if(color=="white")then
	tooltip:AddLine(FG_WHITE..WTG_TEXT[text]);
    elseif(color=="green")then
	tooltip:AddLine(FG_GREEN..WTG_TEXT[text]);
    end

    tooltip:Show();
    tooltip:ClearAllPoints();
    tooltip:SetPoint("BOTTOM","WintersaberTrainersGrinderDisplayFrame","TOP",0,-5);
end

function WintersaberTrainersGrinder_HideToolTip()
    getglobal("WTGToolTip"):Hide();
end

function WTG_GetCurrentRepTotal()
    for factionIndex = 1, GetNumFactions() do
        factionName,_,_,_,_,earnedValue,_,_,isHeader,_,_ = GetFactionInfo(factionIndex)
        if ((isHeader == nil)and(string.find(factionName, WTG_TEXT["Wintersaber Trainers Faction Name"]))) then
	    return earnedValue + WTG_REP_VALUE;
	end
    end
    return 0;
end

function WintersaberTrainersGrinder_ToggleGrinding()
    WTG_NOW_GRINDING = not WTG_NOW_GRINDING;

    local button = getglobal("WTG_BU_ToggleGrinding");
    if(WTG_NOW_GRINDING)then
	button:SetText(FG_TEXT["Stop Grinding"]);
	getglobal("WTG_CurrentlyGrinding"):SetText(FG_GREEN..FG_TEXT["Grinding"]);

	WTG_GRINDING_STARTED_AT = GetTime();
	WTG_INITIALREP = WTG_GetCurrentRepTotal();
    else
	button:SetText(FG_TEXT["Start Grinding"]);
	getglobal("WTG_CurrentlyGrinding"):SetText(FG_RED..FG_TEXT["Not Grinding"]);

	WTG_PREVIOUS_GRINDING_TIME = WTG_PREVIOUS_GRINDING_TIME + (GetTime()-WTG_GRINDING_STARTED_AT);
	WTG_PREVIOUS_REP_GROUND = WTG_PREVIOUS_REP_GROUND + (WTG_GetCurrentRepTotal() - WTG_INITIALREP); 
    end
end

function WintersaberTrainersGrinder_UpdateGrindingStats()
    if(GrinderCore_FactionItemsChanged("WintersaberTrainersGrinder"))then	
	GrinderCore_AcknowledgeItemChange("WintersaberTrainersGrinder");
	WintersaberTrainersGrinder_UpdateDisplayData();
    end

    if(GetTime() > WTG_NEXT_GRIND_UPDATE)then
	WTG_NEXT_GRIND_UPDATE = WTG_NEXT_GRIND_UPDATE + WTG_GRIND_UPDATE_INTERVAL;
	local RepPerSecond = 0;

        if(WTG_NOW_GRINDING)then	
	    getglobal("WTG_TimeTodayVal"):SetText(FG_GREY..FactionGrinder_SecondsToTime(WTG_PREVIOUS_GRINDING_TIME + (GetTime()-WTG_GRINDING_STARTED_AT)));
	    getglobal("WTG_RepTodayVal"):SetText(FG_GREY..(WTG_PREVIOUS_REP_GROUND + (WTG_GetCurrentRepTotal() - WTG_INITIALREP)));
	    RepPerSecond = ((WTG_PREVIOUS_REP_GROUND + (WTG_GetCurrentRepTotal() - WTG_INITIALREP)) / 
                            math.max(math.floor(WTG_PREVIOUS_GRINDING_TIME + (GetTime()-WTG_GRINDING_STARTED_AT)),1));
	    getglobal("WTG_RepPerHourTodayVal"):SetText(FG_GREY..math.floor(RepPerSecond*3600));
	    getglobal("WTG_TimeToRepUpTodayVal"):SetText(FG_GREY..WTG_TimeToRepUp(RepPerSecond));

	    getglobal("WTG_TimeTotalVal"):SetText(FG_GREY..FactionGrinder_SecondsToTime(GrinderCore_GetGrindingTime("Wintersaber Trainers")+WTG_PREVIOUS_GRINDING_TIME + (GetTime()-WTG_GRINDING_STARTED_AT)));
	    getglobal("WTG_RepTotalVal"):SetText(FG_GREY..(GrinderCore_GetRepGround("Wintersaber Trainers")+WTG_PREVIOUS_REP_GROUND + (WTG_GetCurrentRepTotal() - WTG_INITIALREP)));
	    RepPerSecond = ((GrinderCore_GetRepGround("Wintersaber Trainers")+WTG_PREVIOUS_REP_GROUND + (WTG_GetCurrentRepTotal() - WTG_INITIALREP)) / 
                            math.max(math.floor(GrinderCore_GetGrindingTime("Wintersaber Trainers")+WTG_PREVIOUS_GRINDING_TIME + (GetTime()-WTG_GRINDING_STARTED_AT)),1));
	    getglobal("WTG_RepPerHourTotalVal"):SetText(FG_GREY..math.floor(RepPerSecond*3600));
	    getglobal("WTG_TimeToRepUpTotalVal"):SetText(FG_GREY..WTG_TimeToRepUp(RepPerSecond));
        else
	    getglobal("WTG_TimeTodayVal"):SetText(FG_GREY..FactionGrinder_SecondsToTime(WTG_PREVIOUS_GRINDING_TIME));
	    getglobal("WTG_RepTodayVal"):SetText(FG_GREY..(WTG_PREVIOUS_REP_GROUND));
	    RepPerSecond = (WTG_PREVIOUS_REP_GROUND / math.max(WTG_PREVIOUS_GRINDING_TIME,1));
	    getglobal("WTG_RepPerHourTodayVal"):SetText(FG_GREY..math.floor(RepPerSecond*3600));
	    getglobal("WTG_TimeToRepUpTodayVal"):SetText(FG_GREY..WTG_TimeToRepUp(RepPerSecond));

	    getglobal("WTG_TimeTotalVal"):SetText(FG_GREY..FactionGrinder_SecondsToTime(GrinderCore_GetGrindingTime("Wintersaber Trainers")+WTG_PREVIOUS_GRINDING_TIME));
	    getglobal("WTG_RepTotalVal"):SetText(FG_GREY..(GrinderCore_GetRepGround("Wintersaber Trainers")+WTG_PREVIOUS_REP_GROUND));
	    RepPerSecond = ((GrinderCore_GetRepGround("Wintersaber Trainers")+WTG_PREVIOUS_REP_GROUND) / 
                            math.max(math.floor(GrinderCore_GetGrindingTime("Wintersaber Trainers")+WTG_PREVIOUS_GRINDING_TIME),1));
	    getglobal("WTG_RepPerHourTotalVal"):SetText(FG_GREY..math.floor(RepPerSecond*3600));
	    getglobal("WTG_TimeToRepUpTotalVal"):SetText(FG_GREY..WTG_TimeToRepUp(RepPerSecond));
        end
    end
end

function WTG_TimeToRepUp(RepPerSecond)
    if(RepPerSecond==0)then
	return "-----"
    end

    for factionIndex = 1, GetNumFactions() do
        factionName, description, standingId, bottomValue, topValue, earnedValue, atWarWith,
        canToggleAtWar, isHeader, isCollapsed, isWatched = GetFactionInfo(factionIndex)
        if ((isHeader == nil)and(string.find(factionName, WTG_TEXT["Wintersaber Trainers Faction Name"]))) then
	    if(standingId == 8)then --exalted
		return "-----";
	    else
		local RepToRepUp = math.max(topValue-earnedValue-WTG_REP_VALUE,0);
		return FactionGrinder_SecondsToTime(RepToRepUp / RepPerSecond);
	    end
	end
    end
end

function WintersaberTrainersGrinder_ItemButtonClick(itemName, color)
    if(color == "white")then color = FG_WHITE;
    elseif(color == "green")then color = FG_GREEN; end
    if(ChatFrameEditBox:IsVisible() and IsShiftKeyDown() and ((GrinderCore_PlayerInventoryCount(itemName) > 0)or(GrinderCore_PlayerTotalCount(itemName) > 0)or(GrinderCore_AltTotalCount(itemName) >0)))then
    	ChatFrameEditBox:Insert(color.."|Hitem:"..(GrinderCore_Settings["Item IDs"][itemName])..":0:0:0|h["..WTG_TEXT[itemName].."]|h|r");
    elseif(ChatFrameEditBox:IsVisible()) then
	ChatFrameEditBox:Insert(itemName);
    end
end
