--TimbermawHoldGrinder 1.0
--Written By Tiok - US Thrall

THG_INITIALREP = 0;

THG_NOW_GRINDING = false;
THG_PREVIOUS_GRINDING_TIME = 0;
THG_GRINDING_STARTED_AT = 0;
THG_PREVIOUS_REP_GROUND = 0;

THG_GRIND_UPDATE_INTERVAL = 1;
THG_NEXT_GRIND_UPDATE = 0;

THG_REP_VALUE = 0;

THG_TEXT = 
{
    ["Timbermaw Hold Faction Name"] = "Timbermaw Hold";
    ["TH Rep"] = "TH Rep";

    ["Deadwood Headdress Feather"] = "Deadwood Headdress Feather";
    ["Winterfall Spirit Beads"] = "Winterfall Spirit Beads";
}

function TimbermawHoldGrinder_RegisterEvents()
    this:RegisterEvent("ADDON_LOADED");
    this:RegisterEvent("VARIABLES_LOADED");
    this:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE");
    this:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE");
    this:RegisterEvent("PLAYER_LEAVING_WORLD");
    --add event registrations here
end

function TimbermawHoldGrinder_Init()
    THG_NEXT_GRIND_UPDATE = GetTime()+THG_GRIND_UPDATE_INTERVAL;
    --add variable initializations here

    GrinderCore_RegisterItem("TimbermawHoldGrinder","Deadwood Headdress Feather","21377");
    GrinderCore_RegisterItem("TimbermawHoldGrinder","Winterfall Spirit Beads","21383");

    TimbermawHoldGrinder_UpdateDisplayData();
    TimbermawHoldGrinder_UpdateRepBars();
end

function TimbermawHoldGrinder_UpdateDisplayData()
    local repValue = 0;

    local itemCount, itemName;

    itemName = "Deadwood Headdress Feather";
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(itemName);
    else
	itemCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    repValue = repValue + (math.floor(itemCount/5)*50);
    getglobal("THG_DeadwoodHeaddressFeatherCount"):SetText(itemCount);

    itemName = "Winterfall Spirit Beads";
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(itemName);
    else
	itemCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    repValue = repValue + (math.floor(itemCount/5)*50);
    getglobal("THG_WinterfallSpiritBeadsCount"):SetText(itemCount);

   local race = UnitRace("player");
   if race == FG_TEXT["Human"] then
       repValue = math.floor(repValue * 1.1);
   end

    getglobal("THG_RepValue"):SetText(FG_TEXT["Rep Value"].." : "..repValue);
    if(THG_REP_VALUE ~= repValue)then
        THG_REP_VALUE = repValue;
	TimbermawHoldGrinder_UpdateRepBars();
    end
end

function TimbermawHoldGrinder_ToggleDisplay(frameName)
   local frame = getglobal(frameName)
   if (frame) then
   if(frame:IsVisible()) then
      frame:Hide();
   else
      frame:Show();
   end
   end
end

function TimbermawHoldGrinder_OnLoad()
    TimbermawHoldGrinder_RegisterEvents();
end

function TimbermawHoldGrinder_OnEvent()
    if ( event == "VARIABLES_LOADED" ) then    
        TimbermawHoldGrinder_Init();
    elseif((event == "ADDON_LOADED") and (arg1 == "FactionGrinder"))then
	TimbermawHoldGrinder_LoadConfiguration();
    elseif(event == "CHAT_MSG_CHANNEL_NOTICE")then
	this:UnregisterEvent("CHAT_MSG_CHANNEL_NOTICE");
	TimbermawHoldGrinder_UpdateDisplayData();
	TimbermawHoldGrinder_UpdateRepBars();
    elseif( event == "CHAT_MSG_COMBAT_FACTION_CHANGE")then
	TimbermawHoldGrinder_UpdateRepBars();
    elseif( event == "PLAYER_LEAVING_WORLD" )then
	GrinderCore_SetGrindingTime("Timbermaw Hold",GrinderCore_GetGrindingTime("Timbermaw Hold")+THG_PREVIOUS_GRINDING_TIME);
	GrinderCore_SetRepGround("Timbermaw Hold",GrinderCore_GetRepGround("Timbermaw Hold")+THG_PREVIOUS_REP_GROUND);
	if(THG_NOW_GRINDING)then
	    GrinderCore_SetGrindingTime("Timbermaw Hold",GrinderCore_GetGrindingTime("Timbermaw Hold")+(GetTime()-THG_GRINDING_STARTED_AT));
	    GrinderCore_SetRepGround("Timbermaw Hold",GrinderCore_GetRepGround("Timbermaw Hold")+(THG_GetCurrentRepTotal() - THG_INITIALREP));
	end
    end
end

function TimbermawHoldGrinder_LoadConfiguration()
    --this is where we would load the localization values if needed
    if(GetLocale() == "deDE") then
    	THG_TEXT = THG_TEXT_DE;

	--Reconstruct Grind-Tracker frame
	getglobal("TimbermawHoldGrinderGrindFrame"):SetWidth(215);
	getglobal("THG_TimeTodayVal"):SetPoint("TOPLEFT","TimbermawHoldGrinderGrindFrame","TOPLEFT",108,-68);
	getglobal("THG_RepTodayVal"):SetPoint("TOPLEFT","TimbermawHoldGrinderGrindFrame","TOPLEFT",108,-79);
	getglobal("THG_RepPerHourTodayVal"):SetPoint("TOPLEFT","TimbermawHoldGrinderGrindFrame","TOPLEFT",108,-90);
	getglobal("THG_TimeToRepUpTodayVal"):SetPoint("TOPLEFT","TimbermawHoldGrinderGrindFrame","TOPLEFT",108,-101);
	getglobal("THG_TimeTotalVal"):SetPoint("TOPLEFT","TimbermawHoldGrinderGrindFrame","TOPLEFT",108,-133);
	getglobal("THG_RepTotalVal"):SetPoint("TOPLEFT","TimbermawHoldGrinderGrindFrame","TOPLEFT",108,-144);
	getglobal("THG_RepPerHourTotalVal"):SetPoint("TOPLEFT","TimbermawHoldGrinderGrindFrame","TOPLEFT",108,-155);
	getglobal("THG_TimeToRepUpTotalVal"):SetPoint("TOPLEFT","TimbermawHoldGrinderGrindFrame","TOPLEFT",108,-166);
    elseif(GetLocale() == "frFR")then
	THG_TEXT = THG_TEXT_FR;

	--Reconstruct Grind-Tracker frame
	getglobal("THG_BU_ToggleGrinding"):SetWidth(144);
    elseif(GetLocale() == "zhTW")then
	THG_TEXT = THG_TEXT_ZHTW;

	getglobal("THG_RepValue"):SetFontObject(GameFontNormalSmall);
	getglobal("THG_THRep"):SetFontObject(GameFontNormalSmall);

	--Reconstruct Grind-Tracker frame
        getglobal("THGToRepUpFrame"):SetWidth(90);
    	getglobal("THG_SB_ActualRep"):SetWidth(80);
    	getglobal("THG_SB_RepWithItems"):SetWidth(80);

	getglobal("TimbermawHoldGrinderGrindFrame"):SetWidth(215);
	getglobal("THG_CurrentlyGrinding"):SetFontObject(GameFontNormalSmall);
	getglobal("THG_Today"):SetFontObject(GameFontNormalSmall);
	getglobal("THG_TimeToday"):SetFontObject(GameFontNormalSmall);
	getglobal("THG_RepToday"):SetFontObject(GameFontNormalSmall);
	getglobal("THG_RepPerHourToday"):SetFontObject(GameFontNormalSmall);
	getglobal("THG_TimeToRepUpToday"):SetFontObject(GameFontNormalSmall);
	getglobal("THG_Total"):SetFontObject(GameFontNormalSmall);
	getglobal("THG_TimeTotal"):SetFontObject(GameFontNormalSmall);
	getglobal("THG_RepTotal"):SetFontObject(GameFontNormalSmall);
	getglobal("THG_RepPerHourTotal"):SetFontObject(GameFontNormalSmall);
	getglobal("THG_TimeToRepUpTotal"):SetFontObject(GameFontNormalSmall);
        getglobal("THG_TimeTodayVal"):SetPoint("TOPLEFT","TimbermawHoldGrinderGrindFrame","TOPLEFT",108,-68);
	getglobal("THG_RepTodayVal"):SetPoint("TOPLEFT","TimbermawHoldGrinderGrindFrame","TOPLEFT",108,-79);
	getglobal("THG_RepPerHourTodayVal"):SetPoint("TOPLEFT","TimbermawHoldGrinderGrindFrame","TOPLEFT",108,-90);
	getglobal("THG_TimeToRepUpTodayVal"):SetPoint("TOPLEFT","TimbermawHoldGrinderGrindFrame","TOPLEFT",108,-101);
	getglobal("THG_TimeTotalVal"):SetPoint("TOPLEFT","TimbermawHoldGrinderGrindFrame","TOPLEFT",108,-133);
	getglobal("THG_RepTotalVal"):SetPoint("TOPLEFT","TimbermawHoldGrinderGrindFrame","TOPLEFT",108,-144);
	getglobal("THG_RepPerHourTotalVal"):SetPoint("TOPLEFT","TimbermawHoldGrinderGrindFrame","TOPLEFT",108,-155);
	getglobal("THG_TimeToRepUpTotalVal"):SetPoint("TOPLEFT","TimbermawHoldGrinderGrindFrame","TOPLEFT",108,-166);
    end
    
    --now that the localization has been loaded, let's set all text variables appropriately
    
    getglobal("THG_THRep"):SetText(THG_TEXT["TH Rep"]);
    
    getglobal("THG_BU_ToggleGrinding"):SetText(FG_TEXT["Start Grinding"]);
    getglobal("THG_CurrentlyGrinding"):SetText(FG_RED..FG_TEXT["Not Grinding"]);

    getglobal("THG_Today"):SetText(FG_WHITE..FG_TEXT["Today's Grinding"]);
    getglobal("THG_TimeToday"):SetText(FG_GREY..FG_TEXT["Time"].." :");
    getglobal("THG_RepToday"):SetText(FG_GREY..FG_TEXT["Rep"].." :");
    getglobal("THG_RepPerHourToday"):SetText(FG_GREY..FG_TEXT["Rep/Hour"].." :");
    getglobal("THG_Total"):SetText(FG_WHITE..FG_TEXT["Total Grinding"]);
    getglobal("THG_TimeTotal"):SetText(FG_GREY..FG_TEXT["Time"].." :");
    getglobal("THG_RepTotal"):SetText(FG_GREY..FG_TEXT["Rep"].." :");
    getglobal("THG_RepPerHourTotal"):SetText(FG_GREY..FG_TEXT["Rep/Hour"].." :");
    getglobal("THG_TimeToRepUpToday"):SetText(FG_GREY..FG_TEXT["Rep-up In"].." :");
    getglobal("THG_TimeToRepUpTotal"):SetText(FG_GREY..FG_TEXT["Rep-up In"].." :");
end

function TimbermawHoldGrinder_UpdateRepBars()
    local repPercent = 0;
    local itemPercent = 0;
    local totalPercent = 0;
    for factionIndex = 1, GetNumFactions() do
        factionName,_,standingId,_,_,earnedValue,_,_,isHeader,_,_ = GetFactionInfo(factionIndex)
        if ((isHeader == nil)and(string.find(factionName, THG_TEXT["Timbermaw Hold Faction Name"]))) then
            if(standingId==8)then --Exalted
		getglobal("THG_SB_ActualRep"):SetValue(100);
		repPercent = 100;
		itemPercent = math.floor(THG_REP_VALUE/42)/10;
	    elseif(standingId==7)then --Revered
		getglobal("THG_SB_ActualRep"):SetValue(math.floor((earnedValue-21000)/21000*100));
		getglobal("THG_SB_RepWithItems"):SetValue(math.min(100,math.floor((earnedValue+THG_REP_VALUE-21000)/210)));
		repPercent = math.floor((earnedValue-21000)/21)/10;
		itemPercent = math.floor(THG_REP_VALUE/21)/10;
	    elseif(standingId==6)then --Honored
		getglobal("THG_SB_ActualRep"):SetValue(math.floor((earnedValue-9000)/12000*100));
		getglobal("THG_SB_RepWithItems"):SetValue(math.min(100,math.floor((earnedValue+THG_REP_VALUE-9000)/120)));
		repPercent = math.floor((earnedValue-9000)/12)/10;
		itemPercent = math.floor(THG_REP_VALUE/12)/10;
	    elseif(standingId==5)then --Friendly
		getglobal("THG_SB_ActualRep"):SetValue(math.floor((earnedValue-3000)/6000*100));
		getglobal("THG_SB_RepWithItems"):SetValue(math.min(100,math.floor((earnedValue+THG_REP_VALUE-3000)/60)));
		repPercent = math.floor((earnedValue-3000)/6)/10;
		itemPercent = math.floor(THG_REP_VALUE/6)/10;
	    elseif(standingId==4)then --Neutral
		getglobal("THG_SB_ActualRep"):SetValue(math.floor(earnedValue/3000*100));
		getglobal("THG_SB_RepWithItems"):SetValue(math.min(100,math.floor((earnedValue+THG_REP_VALUE)/30)));
		repPercent = math.floor(earnedValue/3)/10;
		itemPercent = math.floor(THG_REP_VALUE/3)/10;
	    elseif(standingId==3)then --Unfriendly (-3000 to 0)
		getglobal("THG_SB_ActualRep"):SetValue(math.floor((3000+earnedValue)/3000*100));
		getglobal("THG_SB_RepWithItems"):SetValue(math.min(100,math.floor((3000+earnedValue+THG_REP_VALUE)/30)));
		repPercent = math.floor((3000+earnedValue)/3)/10;
		itemPercent = math.floor(THG_REP_VALUE/3)/10;
	    elseif(standingId==2)then --Hostile (-6000 to -3000)
		getglobal("THG_SB_ActualRep"):SetValue(math.floor((6000+earnedValue)/3000*100));
		getglobal("THG_SB_RepWithItems"):SetValue(math.min(100,math.floor((6000+earnedValue+THG_REP_VALUE)/30)));
		repPercent = math.floor((6000+earnedValue)/3)/10;
		itemPercent = math.floor(THG_REP_VALUE/3)/10;
	    elseif(standingId==1)then --Hated (-42000 to -6000)
		getglobal("THG_SB_ActualRep"):SetValue(math.floor((42000+earnedValue)/36000*100));
		getglobal("THG_SB_RepWithItems"):SetValue(math.min(100,math.floor((42000+earnedValue+THG_REP_VALUE)/360)));
		repPercent = math.floor((42000+earnedValue)/36)/10;
		itemPercent = math.floor(THG_REP_VALUE/36)/10;
            end
        end
    end
    totalPercent = repPercent + itemPercent;
    getglobal("THG_RepPercent"):SetText("|cff00ff00"..repPercent.."% |caaaaaaaa+ |cffffff00"..itemPercent.."% |caaaaaaaa\226\137\136 |cff88ff00"..totalPercent.."%");
end

function TimbermawHoldGrinder_ShowTurninToolTip(text,color)
    local RepToRepUp = 0;
    for factionIndex = 1, GetNumFactions() do
        factionName,_,standingId,_,topValue,earnedValue,_,_,isHeader,_,_ = GetFactionInfo(factionIndex)
        if ((isHeader == nil)and(string.find(factionName, THG_TEXT["Timbermaw Hold Faction Name"]))) then
	    if(standingId == 8)then --exalted
		RepToRepUp = 0;
	    else
		RepToRepUp = math.max(topValue-earnedValue-THG_REP_VALUE,0);
	    end
	end
    end

    local fifty = 50;

    local race = UnitRace("player");
    if race == FG_TEXT["Human"] then
	fifty = 55;
    end

    local tooltip = getglobal("THGToolTip");
    tooltip:SetOwner(button,"ANCHOR_TOPLEFT",0,0);
    tooltip:ClearLines();
    if(color=="white")then
	tooltip:AddLine(FG_WHITE..THG_TEXT[text]);
    elseif(color=="green")then
	tooltip:AddLine(FG_GREEN..THG_TEXT[text]);
    end

    local itemCount;
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(text);
    else
	itemCount = GrinderCore_PlayerInventoryCount(text);
    end

    if(text=="Deadwood Headdress Feather")then
	tooltip:AddLine(FG_GREY.."5 = "..fifty.." "..FG_TEXT["rep"]);
	tooltip:AddLine(FG_YELLOW..itemCount.."/5 = "..(math.floor(itemCount/5)*fifty).." "..FG_TEXT["rep"]);
	tooltip:AddLine(FG_GRUE..(math.max(0,math.floor((RepToRepUp/fifty)+0.9999)*5-math.mod(itemCount,5))).." "..FG_TEXT["to rep-up"]);
    elseif(text=="Winterfall Spirit Beads")then
	tooltip:AddLine(FG_GREY.."5 = "..fifty.." "..FG_TEXT["rep"]);
	tooltip:AddLine(FG_YELLOW..itemCount.."/5 = "..(math.floor(itemCount/5)*fifty).." "..FG_TEXT["rep"]);
	tooltip:AddLine(FG_GRUE..(math.max(0,math.floor((RepToRepUp/fifty)+0.9999)*5-math.mod(itemCount,5))).." "..FG_TEXT["to rep-up"]);
    end
    tooltip:Show();
    tooltip:ClearAllPoints();
    tooltip:SetPoint("BOTTOM","TimbermawHoldGrinderDisplayFrame","TOP",0,-5);
end

function TimbermawHoldGrinder_HideToolTip()
    getglobal("THGToolTip"):Hide();
end

function THG_GetCurrentRepTotal()
    for factionIndex = 1, GetNumFactions() do
        factionName,_,_,_,_,earnedValue,_,_,isHeader,_,_ = GetFactionInfo(factionIndex)
        if ((isHeader == nil)and(string.find(factionName, THG_TEXT["Timbermaw Hold Faction Name"]))) then
	    return earnedValue + THG_REP_VALUE;
	end
    end
    return 0;
end

function TimbermawHoldGrinder_ToggleGrinding()
    THG_NOW_GRINDING = not THG_NOW_GRINDING;

    local button = getglobal("THG_BU_ToggleGrinding");
    if(THG_NOW_GRINDING)then
	button:SetText(FG_TEXT["Stop Grinding"]);
	getglobal("THG_CurrentlyGrinding"):SetText(FG_GREEN..FG_TEXT["Grinding"]);

	THG_GRINDING_STARTED_AT = GetTime();
	THG_INITIALREP = THG_GetCurrentRepTotal();
    else
	button:SetText(FG_TEXT["Start Grinding"]);
	getglobal("THG_CurrentlyGrinding"):SetText(FG_RED..FG_TEXT["Not Grinding"]);

	THG_PREVIOUS_GRINDING_TIME = THG_PREVIOUS_GRINDING_TIME + (GetTime()-THG_GRINDING_STARTED_AT);
	THG_PREVIOUS_REP_GROUND = THG_PREVIOUS_REP_GROUND + (THG_GetCurrentRepTotal() - THG_INITIALREP); 
    end
end

function TimbermawHoldGrinder_UpdateGrindingStats()
    if(GrinderCore_FactionItemsChanged("TimbermawHoldGrinder"))then	
	GrinderCore_AcknowledgeItemChange("TimbermawHoldGrinder");
	TimbermawHoldGrinder_UpdateDisplayData();
    end

    if(GetTime() > THG_NEXT_GRIND_UPDATE)then
	THG_NEXT_GRIND_UPDATE = THG_NEXT_GRIND_UPDATE + THG_GRIND_UPDATE_INTERVAL;
	local RepPerSecond = 0;

        if(THG_NOW_GRINDING)then	
	    getglobal("THG_TimeTodayVal"):SetText(FG_GREY..FactionGrinder_SecondsToTime(THG_PREVIOUS_GRINDING_TIME + (GetTime()-THG_GRINDING_STARTED_AT)));
	    getglobal("THG_RepTodayVal"):SetText(FG_GREY..(THG_PREVIOUS_REP_GROUND + (THG_GetCurrentRepTotal() - THG_INITIALREP)));
	    RepPerSecond = ((THG_PREVIOUS_REP_GROUND + (THG_GetCurrentRepTotal() - THG_INITIALREP)) / 
                            math.max(math.floor(THG_PREVIOUS_GRINDING_TIME + (GetTime()-THG_GRINDING_STARTED_AT)),1));
	    getglobal("THG_RepPerHourTodayVal"):SetText(FG_GREY..math.floor(RepPerSecond*3600));
	    getglobal("THG_TimeToRepUpTodayVal"):SetText(FG_GREY..THG_TimeToRepUp(RepPerSecond));

	    getglobal("THG_TimeTotalVal"):SetText(FG_GREY..FactionGrinder_SecondsToTime(GrinderCore_GetGrindingTime("Timbermaw Hold")+THG_PREVIOUS_GRINDING_TIME + (GetTime()-THG_GRINDING_STARTED_AT)));
	    getglobal("THG_RepTotalVal"):SetText(FG_GREY..(GrinderCore_GetRepGround("Timbermaw Hold")+THG_PREVIOUS_REP_GROUND + (THG_GetCurrentRepTotal() - THG_INITIALREP)));
	    RepPerSecond = ((GrinderCore_GetRepGround("Timbermaw Hold")+THG_PREVIOUS_REP_GROUND + (THG_GetCurrentRepTotal() - THG_INITIALREP)) / 
                            math.max(math.floor(GrinderCore_GetGrindingTime("Timbermaw Hold")+THG_PREVIOUS_GRINDING_TIME + (GetTime()-THG_GRINDING_STARTED_AT)),1));
	    getglobal("THG_RepPerHourTotalVal"):SetText(FG_GREY..math.floor(RepPerSecond*3600));
	    getglobal("THG_TimeToRepUpTotalVal"):SetText(FG_GREY..THG_TimeToRepUp(RepPerSecond));
        else
	    getglobal("THG_TimeTodayVal"):SetText(FG_GREY..FactionGrinder_SecondsToTime(THG_PREVIOUS_GRINDING_TIME));
	    getglobal("THG_RepTodayVal"):SetText(FG_GREY..(THG_PREVIOUS_REP_GROUND));
	    RepPerSecond = (THG_PREVIOUS_REP_GROUND / math.max(THG_PREVIOUS_GRINDING_TIME,1));
	    getglobal("THG_RepPerHourTodayVal"):SetText(FG_GREY..math.floor(RepPerSecond*3600));
	    getglobal("THG_TimeToRepUpTodayVal"):SetText(FG_GREY..THG_TimeToRepUp(RepPerSecond));

	    getglobal("THG_TimeTotalVal"):SetText(FG_GREY..FactionGrinder_SecondsToTime(GrinderCore_GetGrindingTime("Timbermaw Hold")+THG_PREVIOUS_GRINDING_TIME));
	    getglobal("THG_RepTotalVal"):SetText(FG_GREY..(GrinderCore_GetRepGround("Timbermaw Hold")+THG_PREVIOUS_REP_GROUND));
	    RepPerSecond = ((GrinderCore_GetRepGround("Timbermaw Hold")+THG_PREVIOUS_REP_GROUND) / 
                            math.max(math.floor(GrinderCore_GetGrindingTime("Timbermaw Hold")+THG_PREVIOUS_GRINDING_TIME),1));
	    getglobal("THG_RepPerHourTotalVal"):SetText(FG_GREY..math.floor(RepPerSecond*3600));
	    getglobal("THG_TimeToRepUpTotalVal"):SetText(FG_GREY..THG_TimeToRepUp(RepPerSecond));
        end
    end
end

function THG_TimeToRepUp(RepPerSecond)
    if(RepPerSecond==0)then
	return "-----"
    end

    for factionIndex = 1, GetNumFactions() do
        factionName, description, standingId, bottomValue, topValue, earnedValue, atWarWith,
        canToggleAtWar, isHeader, isCollapsed, isWatched = GetFactionInfo(factionIndex)
        if ((isHeader == nil)and(string.find(factionName, THG_TEXT["Timbermaw Hold Faction Name"]))) then
	    if(standingId == 8)then --exalted
		return "-----";
	    else
		local RepToRepUp = math.max(topValue-earnedValue-THG_REP_VALUE,0);
		return FactionGrinder_SecondsToTime(RepToRepUp / RepPerSecond);
	    end
	end
    end
end

function TimbermawHoldGrinder_ItemButtonClick(itemName, color)
    if(color == "white")then color = FG_WHITE;
    elseif(color == "green")then color = FG_GREEN; end
    if(ChatFrameEditBox:IsVisible() and IsShiftKeyDown() and ((GrinderCore_PlayerInventoryCount(itemName) > 0)or(GrinderCore_PlayerTotalCount(itemName) > 0)or(GrinderCore_AltTotalCount(itemName) >0)))then
    	ChatFrameEditBox:Insert(color.."|Hitem:"..(GrinderCore_Settings["Item IDs"][itemName])..":0:0:0|h["..THG_TEXT[itemName].."]|h|r");
    elseif(ChatFrameEditBox:IsVisible()) then
	ChatFrameEditBox:Insert(itemName);
    end
end
