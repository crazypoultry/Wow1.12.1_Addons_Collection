--ArgentDawnGrinder 1.8
--Written By Tiok - US Thrall

ADG_INITIALREP = 0;

ADG_NOW_GRINDING = false;
ADG_PREVIOUS_GRINDING_TIME = 0;
ADG_GRINDING_STARTED_AT = 0;
ADG_PREVIOUS_REP_GROUND = 0;

ADG_GRIND_UPDATE_INTERVAL = 1;
ADG_NEXT_GRIND_UPDATE = 0;

ADG_TEXT = 
{
    ["Argent Dawn Faction Name"] = "Argent Dawn";
    ["AD Rep"] = "AD Rep";
    ["Superior"] = "Superior";
    ["Epic"] = "Epic";

    ["Minion's Scourgestone"] = "Minion's Scourgestone";
    ["Invader's Scourgestone"] = "Invader's Scourgestone";
    ["Corruptor's Scourgestone"] = "Corruptor's Scourgestone";
    ["Argent Dawn Valor Token"] = "Argent Dawn Valor Token";
    ["Core of Elements"] = "Core of Elements";
    ["Crypt Fiend Parts"] = "Crypt Fiend Parts";
    ["Bone Fragments"] = "Bone Fragments";
    ["Dark Iron Scraps"] = "Dark Iron Scraps";
    ["Savage Frond"] = "Savage Frond";
    ["Insignia of the Crusade"] = "Insignia of the Crusade";
    ["Insignia of the Dawn"] = "Insignia of the Dawn";
    ["Arcane Quickener"] = "Arcane Quickener";
    ["Osseous Agitator"] = "Osseous Agitator";
    ["Somatic Intensifier"] = "Somatic Intensifier";
    ["Ectoplasmic Resonator"] = "Ectoplasmic Resonator";
    ["Runecloth"] = "Runecloth";

    ["Felstone Field"] = "Felstone Field";
    ["Dalson's Tears or"] = "Dalson's Tears or";
    ["Writhing Haunt"] = "Writhing Haunt";
    ["Gahrron's Withering"] = "Gahrron's Withering";
}

function ArgentDawnGrinder_RegisterEvents()
    this:RegisterEvent("ADDON_LOADED");
    this:RegisterEvent("VARIABLES_LOADED");
    this:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE");
    this:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE");
    this:RegisterEvent("PLAYER_LEAVING_WORLD");
    --add event registrations here
end

REP_VALUE = 0;

function ArgentDawnGrinder_Init()
    ADG_NEXT_GRIND_UPDATE = GetTime()+ADG_GRIND_UPDATE_INTERVAL;
    --add variable initializations here

    GrinderCore_RegisterItem("ArgentDawnGrinder","Minion's Scourgestone","12840");
    GrinderCore_RegisterItem("ArgentDawnGrinder","Invader's Scourgestone","12841");
    GrinderCore_RegisterItem("ArgentDawnGrinder","Corruptor's Scourgestone","12843");
    GrinderCore_RegisterItem("ArgentDawnGrinder","Argent Dawn Valor Token","12844");
    GrinderCore_RegisterItem("ArgentDawnGrinder","Insignia of the Dawn","22523");
    GrinderCore_RegisterItem("ArgentDawnGrinder","Insignia of the Crusade","22524");
    GrinderCore_RegisterItem("ArgentDawnGrinder","Crypt Fiend Parts","22525");
    GrinderCore_RegisterItem("ArgentDawnGrinder","Bone Fragments","22526");
    GrinderCore_RegisterItem("ArgentDawnGrinder","Core of Elements","22527");
    GrinderCore_RegisterItem("ArgentDawnGrinder","Dark Iron Scraps","22528");
    GrinderCore_RegisterItem("ArgentDawnGrinder","Savage Frond","22529");
    GrinderCore_RegisterItem("ArgentDawnGrinder","Arcane Quickener","13320");
    GrinderCore_RegisterItem("ArgentDawnGrinder","Ectoplasmic Resonator","13354");
    GrinderCore_RegisterItem("ArgentDawnGrinder","Somatic Intensifier","13356");
    GrinderCore_RegisterItem("ArgentDawnGrinder","Osseous Agitator","13357");
    GrinderCore_RegisterItem("ArgentDawnGrinder","Runecloth","14047");

    ArgentDawnGrinder_UpdateDisplayData();
    ArgentDawnGrinder_UpdateRepBars();
end

function ArgentDawnGrinder_UpdateDisplayData()
    local repValue = 0;

    local itemCount, itemName;

    itemName = "Bone Fragments";
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(itemName);
    else
	itemCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    if(FactionGrinderSettings["Include Items on Alts"])then
	itemCount = itemCount + GrinderCore_AltTotalCount(itemName);
    end
    repValue = repValue + (math.floor(itemCount/30)*10);
    getglobal("ADG_BoneFragmentCount"):SetText(itemCount);

    itemName = "Core of Elements";
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(itemName);
    else
	itemCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    if(FactionGrinderSettings["Include Items on Alts"])then
	itemCount = itemCount + GrinderCore_AltTotalCount(itemName);
    end
    repValue = repValue + (math.floor(itemCount/30)*10);
    getglobal("ADG_CoreofElementsCount"):SetText(itemCount);

    itemName = "Crypt Fiend Parts";
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(itemName);
    else
	itemCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    if(FactionGrinderSettings["Include Items on Alts"])then
	itemCount = itemCount + GrinderCore_AltTotalCount(itemName);
    end
    repValue = repValue + (math.floor(itemCount/30)*10);
    getglobal("ADG_CryptFiendPartsCount"):SetText(itemCount);

    itemName = "Dark Iron Scraps";
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(itemName);
    else
	itemCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    if(FactionGrinderSettings["Include Items on Alts"])then
	itemCount = itemCount + GrinderCore_AltTotalCount(itemName);
    end
    repValue = repValue + (math.floor(itemCount/30)*10);
    getglobal("ADG_DarkIronScrapsCount"):SetText(itemCount);

    itemName = "Savage Frond";
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(itemName);
    else
	itemCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    if(FactionGrinderSettings["Include Items on Alts"])then
	itemCount = itemCount + GrinderCore_AltTotalCount(itemName);
    end
    repValue = repValue + (math.floor(itemCount/30)*10);
    getglobal("ADG_SavageFrondCount"):SetText(itemCount);

    itemName = "Minion's Scourgestone";
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(itemName);
    else
	itemCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    repValue = repValue + (math.floor(itemCount/20)*50);
    getglobal("ADG_MinionsScourgestoneCount"):SetText(itemCount);

    itemName = "Invader's Scourgestone";
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(itemName);
    else
	itemCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    repValue = repValue + (math.floor(itemCount/10)*50);
    getglobal("ADG_InvadersScourgestoneCount"):SetText(itemCount);
 
    itemName = "Corruptor's Scourgestone";
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(itemName);
    else
	itemCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    repValue = repValue + (itemCount*50);
    getglobal("ADG_CorruptorsScourgestoneCount"):SetText(itemCount);

    itemName = "Argent Dawn Valor Token";
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(itemName);
    else
	itemCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    repValue = repValue + (itemCount*25);
    getglobal("ADG_ArgentDawnValorTokenCount"):SetText(itemCount);

    itemName = "Arcane Quickener";
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(itemName);
    else
	itemCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    local ArcaneQuickenerCount = itemCount;

    itemName = "Runecloth";
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(itemName);
    else
	itemCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    if(FactionGrinderSettings["Include Items on Alts"])then
	itemCount = itemCount + GrinderCore_AltTotalCount(itemName);
    end
    local RuneclothCount = itemCount;

    itemName = "Osseous Agitator";
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(itemName);
    else
	itemCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    repValue = repValue + (math.floor(itemCount/6)*15);
    getglobal("ADG_OsseousAgitator"):SetText(itemCount.."/6");
    getglobal("ADG_ArcaneQuickener1"):SetText(ArcaneQuickenerCount.."/"..(math.floor(itemCount/6)));
    getglobal("ADG_Runecloth1"):SetText(RuneclothCount.."/"..(math.floor(itemCount/6)*4));

    itemName = "Somatic Intensifier";
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(itemName);
    else
	itemCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    repValue = repValue + (math.floor(itemCount/5)*25);
    getglobal("ADG_SomaticIntensifier"):SetText(itemCount.."/5");
    getglobal("ADG_ArcaneQuickener2"):SetText(ArcaneQuickenerCount.."/"..(math.floor(itemCount/5)));
    getglobal("ADG_Runecloth2"):SetText(RuneclothCount.."/"..(math.floor(itemCount/5)*4));

    itemName = "Ectoplasmic Resonator";
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(itemName);
    else
	itemCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    repValue = repValue + (math.floor(itemCount/4)*25);
    getglobal("ADG_EctoplasmicResonator"):SetText(itemCount.."/4");
    getglobal("ADG_ArcaneQuickener3"):SetText(ArcaneQuickenerCount.."/"..(math.floor(itemCount/4)));
    getglobal("ADG_Runecloth3"):SetText(RuneclothCount.."/"..(math.floor(itemCount/4)*4));

   local race = UnitRace("player");
   if race == FG_TEXT["Human"] then
       repValue = math.floor(repValue * 1.1);
   end

    getglobal("ADG_RepValue"):SetText(FG_TEXT["Rep Value"].." : "..repValue);
    if(REP_VALUE ~= repValue)then
        REP_VALUE = repValue;
	ArgentDawnGrinder_UpdateRepBars();
    end

    local repLevel = "";
    local superiorOutOf = 0;
    local epicOutOf = 0;

    for factionIndex = 1, GetNumFactions() do
        factionName, description, standingId, bottomValue, topValue, earnedValue, atWarWith,
        canToggleAtWar, isHeader, isCollapsed, isWatched = GetFactionInfo(factionIndex)
        if ((isHeader == nil)and(string.find(factionName, ADG_TEXT["Argent Dawn Faction Name"]))) then
            if(standingId==8)then --Exalted
		superiorOutOf = 6;
		epicOutOf = 27;
	    elseif(standingId==7)then --Revered
		superiorOutOf = 7;
		epicOutOf = 45;
	    elseif(standingId==6)then --Honored
		superiorOutOf = 20;
		epicOutOf = 75;
	    elseif(standingId==5)then --Friendly
		superiorOutOf = 30;
		epicOutOf = 110;
	    elseif(standingID==4)then --Neutral
		superiorOutOf = "\226\136\158";
		epicOutOf = "\226\136\158";
            end
        end
    end

    itemName = "Insignia of the Crusade";
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(itemName);
    else
	itemCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    getglobal("ADG_SuperiorSCCount"):SetText(itemCount.."/"..superiorOutOf);
    getglobal("ADG_EpicSCCount"):SetText(itemCount.."/"..epicOutOf);

    itemName = "Insignia of the Dawn";
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(itemName);
    else
	itemCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    getglobal("ADG_SuperiorADCount"):SetText(itemCount.."/"..superiorOutOf);
    getglobal("ADG_EpicADCount"):SetText(itemCount.."/"..epicOutOf);
end

function ArgentDawnGrinder_ToggleDisplay(frameName)
   local frame = getglobal(frameName)
   if (frame) then
   if(frame:IsVisible()) then
      frame:Hide();
   else
      frame:Show();
   end
   end
end

function ArgentDawnGrinder_OnLoad()
    ArgentDawnGrinder_RegisterEvents();
end

function ArgentDawnGrinder_OnEvent()
    if ( event == "VARIABLES_LOADED" ) then    
        ArgentDawnGrinder_Init();
    elseif((event == "ADDON_LOADED") and (arg1 == "FactionGrinder"))then
	ArgentDawnGrinder_LoadConfiguration();
    elseif(event == "CHAT_MSG_CHANNEL_NOTICE")then
	this:UnregisterEvent("CHAT_MSG_CHANNEL_NOTICE");
	ArgentDawnGrinder_UpdateDisplayData();
	ArgentDawnGrinder_UpdateRepBars();
    elseif( event == "CHAT_MSG_COMBAT_FACTION_CHANGE")then
	ArgentDawnGrinder_UpdateRepBars();
    elseif( event == "PLAYER_LEAVING_WORLD" )then
	GrinderCore_SetGrindingTime("Argent Dawn",GrinderCore_GetGrindingTime("Argent Dawn")+ADG_PREVIOUS_GRINDING_TIME);
	GrinderCore_SetRepGround("Argent Dawn",GrinderCore_GetRepGround("Argent Dawn")+ADG_PREVIOUS_REP_GROUND);
	if(ADG_NOW_GRINDING)then
	    GrinderCore_SetGrindingTime("Argent Dawn",GrinderCore_GetGrindingTime("Argent Dawn")+(GetTime()-ADG_GRINDING_STARTED_AT));
	    GrinderCore_SetRepGround("Argent Dawn",GrinderCore_GetRepGround("Argent Dawn")+(ADG_GetCurrentRepTotal() - ADG_INITIALREP));
	end
    end
end

function ArgentDawnGrinder_LoadConfiguration()
    --this is where we would load the localization values if needed
    if(GetLocale() == "deDE") then
    	ADG_TEXT = ADG_TEXT_DE;

	--Reconstruct Grind-Tracker frame
	getglobal("ArgentDawnGrinderGrindFrame"):SetWidth(215);
	getglobal("ADG_TimeTodayVal"):SetPoint("TOPLEFT","ArgentDawnGrinderGrindFrame","TOPLEFT",108,-68);
	getglobal("ADG_RepTodayVal"):SetPoint("TOPLEFT","ArgentDawnGrinderGrindFrame","TOPLEFT",108,-79);
	getglobal("ADG_RepPerHourTodayVal"):SetPoint("TOPLEFT","ArgentDawnGrinderGrindFrame","TOPLEFT",108,-90);
	getglobal("ADG_TimeToRepUpTodayVal"):SetPoint("TOPLEFT","ArgentDawnGrinderGrindFrame","TOPLEFT",108,-101);
	getglobal("ADG_TimeTotalVal"):SetPoint("TOPLEFT","ArgentDawnGrinderGrindFrame","TOPLEFT",108,-133);
	getglobal("ADG_RepTotalVal"):SetPoint("TOPLEFT","ArgentDawnGrinderGrindFrame","TOPLEFT",108,-144);
	getglobal("ADG_RepPerHourTotalVal"):SetPoint("TOPLEFT","ArgentDawnGrinderGrindFrame","TOPLEFT",108,-155);
	getglobal("ADG_TimeToRepUpTotalVal"):SetPoint("TOPLEFT","ArgentDawnGrinderGrindFrame","TOPLEFT",108,-166);
    elseif(GetLocale() == "frFR")then
	ADG_TEXT = ADG_TEXT_FR;

	--Reconstruct Grind-Tracker frame
	getglobal("ADG_BU_ToggleGrinding"):SetWidth(144);
    elseif(GetLocale() == "zhTW")then
	ADG_TEXT = ADG_TEXT_ZHTW;

	getglobal("ADGToRepUpFrame"):SetWidth(90);
    	getglobal("ADG_SB_ActualRep"):SetWidth(80);
    	getglobal("ADG_SB_RepWithItems"):SetWidth(80);
	getglobal("ADG_Superior"):SetFontObject(GameFontNormalSmall);
	getglobal("ADG_Epic"):SetFontObject(GameFontNormalSmall);
	getglobal("ADG_RepValue"):SetFontObject(GameFontNormalSmall);
	getglobal("ADG_ADRep"):SetFontObject(GameFontNormalSmall);
	getglobal("ADGToRepUpFrame"):SetPoint("TOP","ArgentDawnGrinderDisplayFrame","TOP",30,-216);

	--Reconstruct Grind-Tracker frame
	getglobal("ArgentDawnGrinderGrindFrame"):SetWidth(215);
	getglobal("ADG_CurrentlyGrinding"):SetFontObject(GameFontNormalSmall);
	getglobal("ADG_Today"):SetFontObject(GameFontNormalSmall);
	getglobal("ADG_TimeToday"):SetFontObject(GameFontNormalSmall);
	getglobal("ADG_RepToday"):SetFontObject(GameFontNormalSmall);
	getglobal("ADG_RepPerHourToday"):SetFontObject(GameFontNormalSmall);
	getglobal("ADG_TimeToRepUpToday"):SetFontObject(GameFontNormalSmall);
	getglobal("ADG_Total"):SetFontObject(GameFontNormalSmall);
	getglobal("ADG_TimeTotal"):SetFontObject(GameFontNormalSmall);
	getglobal("ADG_RepTotal"):SetFontObject(GameFontNormalSmall);
	getglobal("ADG_RepPerHourTotal"):SetFontObject(GameFontNormalSmall);
	getglobal("ADG_TimeToRepUpTotal"):SetFontObject(GameFontNormalSmall);
        getglobal("ADG_TimeTodayVal"):SetPoint("TOPLEFT","ArgentDawnGrinderGrindFrame","TOPLEFT",108,-68);
	getglobal("ADG_RepTodayVal"):SetPoint("TOPLEFT","ArgentDawnGrinderGrindFrame","TOPLEFT",108,-79);
	getglobal("ADG_RepPerHourTodayVal"):SetPoint("TOPLEFT","ArgentDawnGrinderGrindFrame","TOPLEFT",108,-90);
	getglobal("ADG_TimeToRepUpTodayVal"):SetPoint("TOPLEFT","ArgentDawnGrinderGrindFrame","TOPLEFT",108,-101);
	getglobal("ADG_TimeTotalVal"):SetPoint("TOPLEFT","ArgentDawnGrinderGrindFrame","TOPLEFT",108,-133);
	getglobal("ADG_RepTotalVal"):SetPoint("TOPLEFT","ArgentDawnGrinderGrindFrame","TOPLEFT",108,-144);
	getglobal("ADG_RepPerHourTotalVal"):SetPoint("TOPLEFT","ArgentDawnGrinderGrindFrame","TOPLEFT",108,-155);
	getglobal("ADG_TimeToRepUpTotalVal"):SetPoint("TOPLEFT","ArgentDawnGrinderGrindFrame","TOPLEFT",108,-166);
    end
    
    --now that the localization has been loaded, let's set all text variables appropriately

    getglobal("ADG_Cauldron1"):SetText(ADG_TEXT["Felstone Field"]);
    getglobal("ADG_Cauldron2"):SetText(ADG_TEXT["Dalson's Tears or"]);
    getglobal("ADG_Cauldron3"):SetText(ADG_TEXT["Writhing Haunt"]);
    getglobal("ADG_Cauldron4"):SetText(ADG_TEXT["Gahrron's Withering"]);

    getglobal("ADG_Superior"):SetText(FG_SUPERIOR..ADG_TEXT["Superior"]);
    getglobal("ADG_Epic"):SetText(FG_EPIC..ADG_TEXT["Epic"]);
    getglobal("ADG_RepValue"):SetText(FG_YELLOW..FG_TEXT["Rep Value"].." : 0");
    getglobal("ADG_ADRep"):SetText(ADG_TEXT["AD Rep"]);
    
    getglobal("ADG_BU_ToggleGrinding"):SetText(FG_TEXT["Start Grinding"]);
    getglobal("ADG_CurrentlyGrinding"):SetText(FG_RED..FG_TEXT["Not Grinding"]);

    getglobal("ADG_Today"):SetText(FG_WHITE..FG_TEXT["Today's Grinding"]);
    getglobal("ADG_TimeToday"):SetText(FG_GREY..FG_TEXT["Time"].." :");
    getglobal("ADG_RepToday"):SetText(FG_GREY..FG_TEXT["Rep"].." :");
    getglobal("ADG_RepPerHourToday"):SetText(FG_GREY..FG_TEXT["Rep/Hour"].." :");
    getglobal("ADG_Total"):SetText(FG_WHITE..FG_TEXT["Total Grinding"]);
    getglobal("ADG_TimeTotal"):SetText(FG_GREY..FG_TEXT["Time"].." :");
    getglobal("ADG_RepTotal"):SetText(FG_GREY..FG_TEXT["Rep"].." :");
    getglobal("ADG_RepPerHourTotal"):SetText(FG_GREY..FG_TEXT["Rep/Hour"].." :");
    getglobal("ADG_TimeToRepUpToday"):SetText(FG_GREY..FG_TEXT["Rep-up In"].." :");
    getglobal("ADG_TimeToRepUpTotal"):SetText(FG_GREY..FG_TEXT["Rep-up In"].." :");
end

function ArgentDawnGrinder_UpdateRepBars()
    local repPercent = 0;
    local itemPercent = 0;
    local totalPercent = 0;
    for factionIndex = 1, GetNumFactions() do
        factionName,_,standingId,_,_,earnedValue,_,_,isHeader,_,_ = GetFactionInfo(factionIndex)
        if ((isHeader == nil)and(string.find(factionName, ADG_TEXT["Argent Dawn Faction Name"]))) then
            if(standingId==8)then --Exalted
		getglobal("ADG_SB_ActualRep"):SetValue(100);
		repPercent = 100;
		itemPercent = math.floor(REP_VALUE/42)/10;
	    elseif(standingId==7)then --Revered
		getglobal("ADG_SB_ActualRep"):SetValue(math.floor((earnedValue-21000)/21000*100));
		getglobal("ADG_SB_RepWithItems"):SetValue(math.min(100,math.floor((earnedValue+REP_VALUE-21000)/210)));
		repPercent = math.floor((earnedValue-21000)/21)/10;
		itemPercent = math.floor(REP_VALUE/21)/10;
	    elseif(standingId==6)then --Honored
		getglobal("ADG_SB_ActualRep"):SetValue(math.floor((earnedValue-9000)/12000*100));
		getglobal("ADG_SB_RepWithItems"):SetValue(math.min(100,math.floor((earnedValue+REP_VALUE-9000)/120)));
		repPercent = math.floor((earnedValue-9000)/12)/10;
		itemPercent = math.floor(REP_VALUE/12)/10;
	    elseif(standingId==5)then --Friendly
		getglobal("ADG_SB_ActualRep"):SetValue(math.floor((earnedValue-3000)/6000*100));
		getglobal("ADG_SB_RepWithItems"):SetValue(math.min(100,math.floor((earnedValue+REP_VALUE-3000)/60)));
		repPercent = math.floor((earnedValue-3000)/6)/10;
		itemPercent = math.floor(REP_VALUE/6)/10;
	    elseif(standingId==4)then --Neutral
		getglobal("ADG_SB_ActualRep"):SetValue(math.floor(earnedValue/3000*100));
		getglobal("ADG_SB_RepWithItems"):SetValue(math.min(100,math.floor((earnedValue+REP_VALUE)/30)));
		repPercent = math.floor(earnedValue/3)/10;
		itemPercent = math.floor(REP_VALUE/3)/10;
            end
        end
    end
    totalPercent = repPercent + itemPercent;
    getglobal("ADG_RepPercent"):SetText("|cff00ff00"..repPercent.."% |caaaaaaaa+ |cffffff00"..itemPercent.."% |caaaaaaaa\226\137\136 |cff88ff00"..totalPercent.."%");
end

function ArgentDawnGrinder_ShowTurninToolTip(text,color)
    local RepToRepUp = 0;
    for factionIndex = 1, GetNumFactions() do
        factionName,_,standingId,_,topValue,earnedValue,_,_,isHeader,_,_ = GetFactionInfo(factionIndex)
        if ((isHeader == nil)and(string.find(factionName, ADG_TEXT["Argent Dawn Faction Name"]))) then
	    if(standingId == 8)then --exalted
		RepToRepUp = 0;
	    else
		RepToRepUp = math.max(topValue-earnedValue-REP_VALUE,0);
	    end
	end
    end

    local fifty = 50;
    local twentyfive = 25;
    local ten = 10;

    local race = UnitRace("player");
    if race == FG_TEXT["Human"] then
	fifty = 55;
	twentyfive = 27.5
	ten = 11;
    end

    local tooltip = getglobal("ADGToolTip");
    tooltip:SetOwner(button,"ANCHOR_TOPLEFT",0,0);
    tooltip:ClearLines();
    if(color=="white")then
	tooltip:AddLine(FG_WHITE..ADG_TEXT[text]);
    elseif(color=="green")then
	tooltip:AddLine(FG_GREEN..ADG_TEXT[text]);
    end

    local itemCount;
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(text);
    else
	itemCount = GrinderCore_PlayerInventoryCount(text);
    end

    if(text=="Minion's Scourgestone")then
	tooltip:AddLine(FG_GREY.."20 = "..fifty.." "..FG_TEXT["rep"]);
	tooltip:AddLine(FG_YELLOW..itemCount.."/20 = "..(math.floor(itemCount/20)*fifty).." "..FG_TEXT["rep"]);
	tooltip:AddLine(FG_GRUE..(math.max(0,math.floor((RepToRepUp/fifty)+0.9999)*20-math.mod(itemCount,20))).." "..FG_TEXT["to rep-up"]);
    elseif(text=="Invader's Scourgestone")then
	tooltip:AddLine(FG_GREY.."10 = "..fifty.." "..FG_TEXT["rep"]); 
	tooltip:AddLine(FG_YELLOW..itemCount.."/10 = "..(math.floor(itemCount/10)*fifty).." "..FG_TEXT["rep"]);
	tooltip:AddLine(FG_GRUE..(math.max(0,math.floor((RepToRepUp/fifty)+0.9999)*10-math.mod(itemCount,10))).." "..FG_TEXT["to rep-up"]);
    elseif(text=="Corruptor's Scourgestone")then
	tooltip:AddLine(FG_GREY.."1 = "..fifty.." "..FG_TEXT["rep"]);
	tooltip:AddLine(FG_YELLOW..itemCount.."/1 = "..(itemCount*fifty).." "..FG_TEXT["rep"]);
	tooltip:AddLine(FG_GRUE..(math.floor((RepToRepUp/fifty)+0.9999)).." "..FG_TEXT["to rep-up"]);
    elseif(text=="Argent Dawn Valor Token")then
	tooltip:AddLine(FG_GREY.."1 = "..twentyfive.." "..FG_TEXT["rep"]); 
	tooltip:AddLine(FG_YELLOW..itemCount.."/1 = "..(itemCount*twentyfive).." "..FG_TEXT["rep"]);
    elseif(text=="Core of Elements")then
	if(FactionGrinderSettings["Include Items on Alts"])then
	    itemCount = itemCount + GrinderCore_AltTotalCount(text);
	end
	tooltip:AddLine(FG_GREY.."30 = "..ten.." "..FG_TEXT["rep"]);
	tooltip:AddLine(FG_YELLOW..itemCount.."/30 = "..(math.floor(itemCount/30)*ten).." "..FG_TEXT["rep"]);
	tooltip:AddLine(FG_GRUE..(math.max(0,math.floor((RepToRepUp/ten)+0.9999)*30-math.mod(itemCount,30))).." "..FG_TEXT["to rep-up"]);
    elseif(text=="Dark Iron Scraps")then
	if(FactionGrinderSettings["Include Items on Alts"])then
	    itemCount = itemCount + GrinderCore_AltTotalCount(text);
	end
	tooltip:AddLine(FG_GREY.."30 = "..ten.." "..FG_TEXT["rep"]);
	tooltip:AddLine(FG_YELLOW..itemCount.."/30 = "..(math.floor(itemCount/30)*ten).." "..FG_TEXT["rep"]);
	tooltip:AddLine(FG_GRUE..(math.max(0,math.floor((RepToRepUp/ten)+0.9999)*30-math.mod(itemCount,30))).." "..FG_TEXT["to rep-up"]);
    elseif(text=="Savage Frond")then
	if(FactionGrinderSettings["Include Items on Alts"])then
	    itemCount = itemCount + GrinderCore_AltTotalCount(text);
	end
	tooltip:AddLine(FG_GREY.."30 = "..ten.." "..FG_TEXT["rep"]); 
	tooltip:AddLine(FG_YELLOW..itemCount.."/30 = "..(math.floor(itemCount/30)*ten).." "..FG_TEXT["rep"]);
	tooltip:AddLine(FG_GRUE..(math.max(0,math.floor((RepToRepUp/ten)+0.9999)*30-math.mod(itemCount,30))).." "..FG_TEXT["to rep-up"]);
    elseif(text=="Bone Fragments")then
	if(FactionGrinderSettings["Include Items on Alts"])then
	    itemCount = itemCount + GrinderCore_AltTotalCount(text);
	end
	tooltip:AddLine(FG_GREY.."30 = "..ten.." "..FG_TEXT["rep"]); 
	tooltip:AddLine(FG_YELLOW..itemCount.."/30 = "..(math.floor(itemCount/30)*ten).." "..FG_TEXT["rep"]);
	tooltip:AddLine(FG_GRUE..(math.max(0,math.floor((RepToRepUp/ten)+0.9999)*30-math.mod(itemCount,30))).." "..FG_TEXT["to rep-up"]);
    elseif(text=="Crypt Fiend Parts")then
	if(FactionGrinderSettings["Include Items on Alts"])then
	    itemCount = itemCount + GrinderCore_AltTotalCount(text);
	end
	tooltip:AddLine(FG_GREY.."30 = "..ten.." "..FG_TEXT["rep"]); 
	tooltip:AddLine(FG_YELLOW..itemCount.."/30 = "..(math.floor(itemCount/30)*ten).." "..FG_TEXT["rep"]);
	tooltip:AddLine(FG_GRUE..(math.max(0,math.floor((RepToRepUp/ten)+0.9999)*30-math.mod(itemCount,30))).." "..FG_TEXT["to rep-up"]);
    elseif(text=="Insignia of the Dawn")then

    elseif(text=="Insignia of the Crusade")then

    end
    tooltip:Show();
    tooltip:ClearAllPoints();
    tooltip:SetPoint("BOTTOM","ArgentDawnGrinderDisplayFrame","TOP",0,-5);
end

function ArgentDawnGrinder_ShowCauldronToolTip(text,color)
    local RepToRepUp = 0;
    for factionIndex = 1, GetNumFactions() do
        factionName,_,standingId,_,topValue,earnedValue,_,_,isHeader,_,_ = GetFactionInfo(factionIndex)
        if ((isHeader == nil)and(string.find(factionName, ADG_TEXT["Argent Dawn Faction Name"]))) then
	    if(standingId == 8)then --exalted
		RepToRepUp = 0;
	    else
		RepToRepUp = math.max(topValue-earnedValue-REP_VALUE,0);
	    end
	end
    end

    local tooltip = getglobal("ADGToolTip");
    tooltip:SetOwner(button,"ANCHOR_TOPLEFT",0,0);

    local twentyfive = 25;
    local fifteen = 15;

    local race = UnitRace("player");
    if race == FG_TEXT["Human"] then
	twentyfive = 27.5
	fifteen = 16.5;
    end

    tooltip:ClearLines();
    if(color=="white")then
	tooltip:AddLine(FG_WHITE..ADG_TEXT[text]);
    elseif(color=="green")then
	tooltip:AddLine(FG_GREEN..ADG_TEXT[text]);
    end

    local itemCount;
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(text);
    else
	itemCount = GrinderCore_PlayerInventoryCount(text);
    end

    if(text=="Osseous Agitator")then
	if(FactionGrinderSettings["Include Items on Alts"])then
	    itemCount = itemCount + GrinderCore_AltTotalCount(text);
	end
	tooltip:AddLine(FG_GREY.."6 = "..fifteen.." "..FG_TEXT["rep"]); 
	tooltip:AddLine(FG_YELLOW..itemCount.."/6 = "..(math.floor(itemCount/6)*fifteen).." "..FG_TEXT["rep"]);
	tooltip:AddLine(FG_GRUE..(math.max(0,math.floor((RepToRepUp/fifteen)+0.9999)*6-math.mod(itemCount,6))).." "..FG_TEXT["to rep-up"]);
    elseif(text=="Somatic Intensifier")then
	if(FactionGrinderSettings["Include Items on Alts"])then
	    itemCount = itemCount + GrinderCore_AltTotalCount(text);
	end
	tooltip:AddLine(FG_GREY.."5 = "..twentyfive.." "..FG_TEXT["rep"]); 
	tooltip:AddLine(FG_YELLOW..itemCount.."/5 = "..(math.floor(itemCount/5)*twentyfive).." "..FG_TEXT["rep"]);
	tooltip:AddLine(FG_GRUE..(math.max(0,math.floor((RepToRepUp/twentyfive)+0.9999)*5-math.mod(itemCount,5))).." "..FG_TEXT["to rep-up"]);
    elseif(text=="Ectoplasmic Resonator")then
	if(FactionGrinderSettings["Include Items on Alts"])then
	    itemCount = itemCount + GrinderCore_AltTotalCount(text);
	end
	tooltip:AddLine(FG_GREY.."4 = "..twentyfive.." "..FG_TEXT["rep"]); 
	tooltip:AddLine(FG_YELLOW..itemCount.."/4 = "..(math.floor(itemCount/4)*twentyfive).." "..FG_TEXT["rep"]);
	tooltip:AddLine(FG_GRUE..(math.max(0,math.floor((RepToRepUp/twentyfive)+0.9999)*4-math.mod(itemCount,4))).." "..FG_TEXT["to rep-up"]);
    end

    tooltip:Show();
    tooltip:ClearAllPoints();
    tooltip:SetPoint("BOTTOM","ArgentDawnGrinderCauldronFrame","TOP",0,-5);
end

function ArgentDawnGrinder_HideToolTip()
    getglobal("ADGToolTip"):Hide();
end

function ADG_GetCurrentRepTotal()
    for factionIndex = 1, GetNumFactions() do
        factionName,_,_,_,_,earnedValue,_,_,isHeader,_,_ = GetFactionInfo(factionIndex)
        if ((isHeader == nil)and(string.find(factionName, ADG_TEXT["Argent Dawn Faction Name"]))) then
	    return earnedValue + REP_VALUE;
	end
    end
    return 0;
end

function ArgentDawnGrinder_ToggleGrinding()
    ADG_NOW_GRINDING = not ADG_NOW_GRINDING;

    local button = getglobal("ADG_BU_ToggleGrinding");
    if(ADG_NOW_GRINDING)then
	button:SetText(FG_TEXT["Stop Grinding"]);
	getglobal("ADG_CurrentlyGrinding"):SetText(FG_GREEN..FG_TEXT["Grinding"]);

	ADG_GRINDING_STARTED_AT = GetTime();
	ADG_INITIALREP = ADG_GetCurrentRepTotal();
    else
	button:SetText(FG_TEXT["Start Grinding"]);
	getglobal("ADG_CurrentlyGrinding"):SetText(FG_RED..FG_TEXT["Not Grinding"]);

	ADG_PREVIOUS_GRINDING_TIME = ADG_PREVIOUS_GRINDING_TIME + (GetTime()-ADG_GRINDING_STARTED_AT);
	ADG_PREVIOUS_REP_GROUND = ADG_PREVIOUS_REP_GROUND + (ADG_GetCurrentRepTotal() - ADG_INITIALREP); 
    end
end

function ArgentDawnGrinder_UpdateGrindingStats()
    if(GrinderCore_FactionItemsChanged("ArgentDawnGrinder"))then	
	GrinderCore_AcknowledgeItemChange("ArgentDawnGrinder");
	ArgentDawnGrinder_UpdateDisplayData();
    end

    if(GetTime() > ADG_NEXT_GRIND_UPDATE)then
	ADG_NEXT_GRIND_UPDATE = ADG_NEXT_GRIND_UPDATE + ADG_GRIND_UPDATE_INTERVAL;
	local RepPerSecond = 0;

        if(ADG_NOW_GRINDING)then	
	    getglobal("ADG_TimeTodayVal"):SetText(FG_GREY..FactionGrinder_SecondsToTime(ADG_PREVIOUS_GRINDING_TIME + (GetTime()-ADG_GRINDING_STARTED_AT)));
	    getglobal("ADG_RepTodayVal"):SetText(FG_GREY..(ADG_PREVIOUS_REP_GROUND + (ADG_GetCurrentRepTotal() - ADG_INITIALREP)));
	    RepPerSecond = ((ADG_PREVIOUS_REP_GROUND + (ADG_GetCurrentRepTotal() - ADG_INITIALREP)) / 
                            math.max(math.floor(ADG_PREVIOUS_GRINDING_TIME + (GetTime()-ADG_GRINDING_STARTED_AT)),1));
	    getglobal("ADG_RepPerHourTodayVal"):SetText(FG_GREY..math.floor(RepPerSecond*3600));
	    getglobal("ADG_TimeToRepUpTodayVal"):SetText(FG_GREY..ADG_TimeToRepUp(RepPerSecond));

	    getglobal("ADG_TimeTotalVal"):SetText(FG_GREY..FactionGrinder_SecondsToTime(GrinderCore_GetGrindingTime("Argent Dawn")+ADG_PREVIOUS_GRINDING_TIME + (GetTime()-ADG_GRINDING_STARTED_AT)));
	    getglobal("ADG_RepTotalVal"):SetText(FG_GREY..(GrinderCore_GetRepGround("Argent Dawn")+ADG_PREVIOUS_REP_GROUND + (ADG_GetCurrentRepTotal() - ADG_INITIALREP)));
	    RepPerSecond = ((GrinderCore_GetRepGround("Argent Dawn")+ADG_PREVIOUS_REP_GROUND + (ADG_GetCurrentRepTotal() - ADG_INITIALREP)) / 
                            math.max(math.floor(GrinderCore_GetGrindingTime("Argent Dawn")+ADG_PREVIOUS_GRINDING_TIME + (GetTime()-ADG_GRINDING_STARTED_AT)),1));
	    getglobal("ADG_RepPerHourTotalVal"):SetText(FG_GREY..math.floor(RepPerSecond*3600));
	    getglobal("ADG_TimeToRepUpTotalVal"):SetText(FG_GREY..ADG_TimeToRepUp(RepPerSecond));
        else
	    getglobal("ADG_TimeTodayVal"):SetText(FG_GREY..FactionGrinder_SecondsToTime(ADG_PREVIOUS_GRINDING_TIME));
	    getglobal("ADG_RepTodayVal"):SetText(FG_GREY..(ADG_PREVIOUS_REP_GROUND));
	    RepPerSecond = (ADG_PREVIOUS_REP_GROUND / math.max(ADG_PREVIOUS_GRINDING_TIME,1));
	    getglobal("ADG_RepPerHourTodayVal"):SetText(FG_GREY..math.floor(RepPerSecond*3600));
	    getglobal("ADG_TimeToRepUpTodayVal"):SetText(FG_GREY..ADG_TimeToRepUp(RepPerSecond));

	    getglobal("ADG_TimeTotalVal"):SetText(FG_GREY..FactionGrinder_SecondsToTime(GrinderCore_GetGrindingTime("Argent Dawn")+ADG_PREVIOUS_GRINDING_TIME));
	    getglobal("ADG_RepTotalVal"):SetText(FG_GREY..(GrinderCore_GetRepGround("Argent Dawn")+ADG_PREVIOUS_REP_GROUND));
	    RepPerSecond = ((GrinderCore_GetRepGround("Argent Dawn")+ADG_PREVIOUS_REP_GROUND) / 
                            math.max(math.floor(GrinderCore_GetGrindingTime("Argent Dawn")+ADG_PREVIOUS_GRINDING_TIME),1));
	    getglobal("ADG_RepPerHourTotalVal"):SetText(FG_GREY..math.floor(RepPerSecond*3600));
	    getglobal("ADG_TimeToRepUpTotalVal"):SetText(FG_GREY..ADG_TimeToRepUp(RepPerSecond));
        end
    end
end

function ADG_TimeToRepUp(RepPerSecond)
    if(RepPerSecond==0)then
	return "-----"
    end

    for factionIndex = 1, GetNumFactions() do
        factionName, description, standingId, bottomValue, topValue, earnedValue, atWarWith,
        canToggleAtWar, isHeader, isCollapsed, isWatched = GetFactionInfo(factionIndex)
        if ((isHeader == nil)and(string.find(factionName, ADG_TEXT["Argent Dawn Faction Name"]))) then
	    if(standingId == 8)then --exalted
		return "-----";
	    else
		local RepToRepUp = math.max(topValue-earnedValue-REP_VALUE,0);
		return FactionGrinder_SecondsToTime(RepToRepUp / RepPerSecond);
	    end
	end
    end
end

function ArgentDawnGrinder_ItemButtonClick(itemName, color)
    if(color == "white")then color = FG_WHITE;
    elseif(color == "green")then color = FG_GREEN; end
    if(ChatFrameEditBox:IsVisible() and IsShiftKeyDown() and ((GrinderCore_PlayerInventoryCount(itemName) > 0)or(GrinderCore_PlayerTotalCount(itemName) > 0)or(GrinderCore_AltTotalCount(itemName) >0)))then
    	ChatFrameEditBox:Insert(color.."|Hitem:"..(GrinderCore_Settings["Item IDs"][itemName])..":0:0:0|h["..ADG_TEXT[itemName].."]|h|r");
    elseif(ChatFrameEditBox:IsVisible()) then
	ChatFrameEditBox:Insert(itemName);
    end
end
