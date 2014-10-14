--CenarionCircleGrinder 1.0
--Written By Tiok - US Thrall

CCG_INITIALREP = 0;

CCG_NOW_GRINDING = false;
CCG_PREVIOUS_GRINDING_TIME = 0;
CCG_GRINDING_STARTED_AT = 0;
CCG_PREVIOUS_REP_GROUND = 0;

CCG_GRIND_UPDATE_INTERVAL = 1;
CCG_NEXT_GRIND_UPDATE = 0;

CCG_REP_VALUE = 0;

CCG_TWILIGHT_CULTIST_SETS = 0;
CCG_TWILIGHT_CULTIST_MEDALLIONS = 0;
CCG_TWILIGHT_CULTIST_RINGS = 0;
CCG_ABYSSAL_CRESTS = 0;
CCG_ABYSSAL_SIGNETS = 0;

CCG_TEXT = 
{
    ["Cenarion Circle Faction Name"] = "Cenarion Circle";
    ["CC Rep"] = "CC Rep";

    ["Encrypted Twilight Text"] = "Encrypted Twilight Text";
    ["Abyssal Crest"] = "Abyssal Crest";
    ["Abyssal Signet"] = "Abyssal Signet";
    ["Abyssal Scepter"] = "Abyssal Scepter";
    ["Cenarion Combat Badge"] = "Cenarion Combat Badge";
    ["Cenarion Logistics Badge"] = "Cenarion Logistics Badge";
    ["Cenarion Tactical Badge"] = "Cenarion Tactical Badge";
    ["Mark of Remulos"] = "Mark of Remulos";
    ["Mark of Cenarius"] = "Mark of Cenarius";
    ["Twilight Cultist Mantle"] = "Twilight Cultist Mantle";
    ["Twilight Cultist Cowl"] = "Twilight Cultist Cowl";
    ["Twilight Cultist Robe"] = "Twilight Cultist Robe";
    ["Twilight Cultist Medallion of Station"] = "Twilight Cultist Medallion of Station";
    ["Twilight Cultist Ring of Lordship"] = "Twilight Cultist Ring of Lordship";
    ["Large Brilliant Shard"] = "Large Brilliant Shard";

    ["You Can Summon"] = "You Can Summon";
    ["Templar"] = "Templar";
    ["Dukes"] = "Dukes";
    ["Lords"] = "Lords";

    ["One Mantle, Cowl, and Robe are needed for each summon"] = "One Mantle, Cowl, and Robe are needed for each summon";
    ["One Medallion is needed for each Duke summon"] = "One Medallion is needed for each Duke summon";
    ["One Ring needed for each Lord summon"] = "One Ring needed for each Lord summon";
    ["Three Crests are needed to make a Medallion of Station"] = "Three Crests are needed to make a Medallion of Station";
    ["Three Signets are needed to make a Ring of Lordship"] = "Three Signets are needed to make a Ring of Lordship";
    ["One Shard is needed to make a Medallion of Station"] = "One Shard is needed to make a Medallion of Station";
    ["Five Shards are needed to make a Ring of Lordship"] = "Five Shards are needed to make a Ring of Lordship";

    ["One of each badge"] = "One of each badge";
    ["badge sets"] = "badge sets";
    ["badge sets to rep-up"] = "badge sets to rep-up";

    ["Volunteer"] = "Volunteer";
    ["Veteran"] = "Veteran";
    ["Stalwart"] = "Stalwart";
    ["Champion"] = "Champion";

    ["One needed for Stalwart's Battlegear turnin"] = "One needed for Stalwart's Battlegear turnin";
    ["One needed for Champion's Battlegear turnin"] = "One needed for Champion's Battlegear turnin";
}

function CenarionCircleGrinder_RegisterEvents()
    this:RegisterEvent("ADDON_LOADED");
    this:RegisterEvent("VARIABLES_LOADED");
    this:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE");
    this:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE");
    this:RegisterEvent("PLAYER_LEAVING_WORLD");
    --add event registrations here
end

function CenarionCircleGrinder_Init()
    CCG_NEXT_GRIND_UPDATE = GetTime()+CCG_GRIND_UPDATE_INTERVAL;
    --add variable initializations here

    GrinderCore_RegisterItem("CenarionCircleGrinder","Encrypted Twilight Text","20404");
    GrinderCore_RegisterItem("CenarionCircleGrinder","Abyssal Crest","20513");
    GrinderCore_RegisterItem("CenarionCircleGrinder","Abyssal Signet","20514");
    GrinderCore_RegisterItem("CenarionCircleGrinder","Abyssal Scepter","20515");
    GrinderCore_RegisterItem("CenarionCircleGrinder","Cenarion Combat Badge","20802");
    GrinderCore_RegisterItem("CenarionCircleGrinder","Cenarion Logistics Badge","20800");
    GrinderCore_RegisterItem("CenarionCircleGrinder","Cenarion Tactical Badge","20801");
    GrinderCore_RegisterItem("CenarionCircleGrinder","Mark of Remulos","21515");
    GrinderCore_RegisterItem("CenarionCircleGrinder","Mark of Cenarius","21508");
    GrinderCore_RegisterItem("CenarionCircleGrinder","Twilight Cultist Mantle","20406");
    GrinderCore_RegisterItem("CenarionCircleGrinder","Twilight Cultist Cowl","20408");
    GrinderCore_RegisterItem("CenarionCircleGrinder","Twilight Cultist Robe","20407");
    GrinderCore_RegisterItem("CenarionCircleGrinder","Twilight Cultist Medallion of Station","20422");
    GrinderCore_RegisterItem("CenarionCircleGrinder","Twilight Cultist Ring of Lordship","20451");
    GrinderCore_RegisterItem("CenarionCircleGrinder","Large Brilliant Shard","14344");

    CenarionCircleGrinder_UpdateDisplayData();
    CenarionCircleGrinder_UpdateRepBars();
end

function CenarionCircleGrinder_UpdateDisplayData()
    local repValue = 0;

    local itemCount, itemName;

    itemName = "Encrypted Twilight Text";
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(itemName);
    else
	itemCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    if(FactionGrinderSettings["Include Items on Alts"])then
	itemCount = itemCount + GrinderCore_AltTotalCount(itemName);
    end
    repValue = repValue + (math.floor(itemCount/10)*100);
    getglobal("CCG_EncryptedTwilightTextCount"):SetText(itemCount.."/10");

    itemName = "Abyssal Crest";
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(itemName);
    else
	itemCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    if(FactionGrinderSettings["Include Items on Alts"])then
	itemCount = itemCount + GrinderCore_AltTotalCount(itemName);
    end
    repValue = repValue + (math.floor(itemCount/3)*50);
    CCG_ABYSSAL_CRESTS = itemCount;
    getglobal("CCG_AbyssalCrestCount"):SetText(itemCount);
    getglobal("CCG_AbyssalCrestUpgradeCount"):SetText(itemCount.."/3");

    itemName = "Abyssal Signet";
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(itemName);
    else
	itemCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    if(FactionGrinderSettings["Include Items on Alts"])then
	itemCount = itemCount + GrinderCore_AltTotalCount(itemName);
    end
    repValue = repValue + (math.floor(itemCount/3)*100);
    CCG_ABYSSAL_SIGNETS = itemCount;
    getglobal("CCG_AbyssalSignetCount"):SetText(itemCount);
    getglobal("CCG_AbyssalSignetUpgradeCount"):SetText(itemCount.."/3");

    itemName = "Abyssal Scepter";
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(itemName);
    else
	itemCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    if(FactionGrinderSettings["Include Items on Alts"])then
	itemCount = itemCount + GrinderCore_AltTotalCount(itemName);
    end
    repValue = repValue + (math.floor(itemCount/3)*150);
    getglobal("CCG_AbyssalScepterCount"):SetText(itemCount);

    itemName = "Cenarion Combat Badge";
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(itemName);
    else
	itemCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    getglobal("CCG_CenarionCombatBadgeCount"):SetText(itemCount);
    local CombatBadgeCount = itemCount;

    itemName = "Cenarion Logistics Badge";
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(itemName);
    else
	itemCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    getglobal("CCG_CenarionLogisticsBadgeCount"):SetText(itemCount);
    local LogisticsBadgeCount = itemCount;

    itemName = "Cenarion Tactical Badge";
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(itemName);
    else
	itemCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    getglobal("CCG_CenarionTacticalBadgeCount"):SetText(itemCount);
    local TacticalBadgeCount = itemCount;

    itemCount = math.min(CombatBadgeCount,math.min(LogisticsBadgeCount,TacticalBadgeCount));
    repValue = repValue + (itemCount * 200);

    getglobal("CCG_Volunteer"):SetText(FG_SUPERIOR..CCG_TEXT["Volunteer"].."  "..FG_WHITE..CombatBadgeCount.."/5  "..FG_GREY..LogisticsBadgeCount.."/3  "..FG_WHITE..TacticalBadgeCount.."/7");
    getglobal("CCG_Veteran"):SetText(FG_SUPERIOR..CCG_TEXT["Veteran"].."  "..FG_WHITE..CombatBadgeCount.."/7  "..FG_GREY..LogisticsBadgeCount.."/4  "..FG_WHITE..TacticalBadgeCount.."/4");
    getglobal("CCG_Stalwart"):SetText(FG_EPIC..CCG_TEXT["Stalwart"].."  "..FG_WHITE..CombatBadgeCount.."/15  "..FG_GREY..LogisticsBadgeCount.."/20  "..FG_WHITE..TacticalBadgeCount.."/17");
    getglobal("CCG_Champion"):SetText(FG_EPIC..CCG_TEXT["Champion"].."  "..FG_WHITE..CombatBadgeCount.."/15  "..FG_GREY..LogisticsBadgeCount.."/20  "..FG_WHITE..TacticalBadgeCount.."/20");

    local race = UnitRace("player");
    if race == FG_TEXT["Human"] then
        repValue = math.floor(repValue * 1.1);
    end

    getglobal("CCG_RepValue"):SetText(FG_TEXT["Rep Value"].." : "..repValue);
    if(CCG_REP_VALUE ~= repValue)then
        CCG_REP_VALUE = repValue;
	CenarionCircleGrinder_UpdateRepBars();
    end

    itemName = "Mark of Remulos";
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(itemName);
    else
	itemCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    getglobal("CCG_MarkofRemulosCount"):SetText(itemCount);

    itemName = "Mark of Cenarius";
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(itemName);
    else
	itemCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    getglobal("CCG_MarkofCenariusCount"):SetText(itemCount);

    itemName = "Twilight Cultist Mantle";
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(itemName);
    else
	itemCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    if(FactionGrinderSettings["Include Items on Alts"])then
	itemCount = itemCount + GrinderCore_AltTotalCount(itemName);
    end
    CCG_TWILIGHT_CULTIST_SETS = itemCount;
    getglobal("CCG_TwilightCultistMantleCount"):SetText(itemCount);

    itemName = "Twilight Cultist Cowl";
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(itemName);
    else
	itemCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    if(FactionGrinderSettings["Include Items on Alts"])then
	itemCount = itemCount + GrinderCore_AltTotalCount(itemName);
    end
    CCG_TWILIGHT_CULTIST_SETS = math.min(CCG_TWILIGHT_CULTIST_SETS,itemCount);
    getglobal("CCG_TwilightCultistCowlCount"):SetText(itemCount);

    itemName = "Twilight Cultist Robe";
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(itemName);
    else
	itemCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    if(FactionGrinderSettings["Include Items on Alts"])then
	itemCount = itemCount + GrinderCore_AltTotalCount(itemName);
    end
    CCG_TWILIGHT_CULTIST_SETS = math.min(CCG_TWILIGHT_CULTIST_SETS,itemCount);
    getglobal("CCG_TwilightCultistRobeCount"):SetText(itemCount);
    getglobal("CCG_Templar"):SetText(CCG_TWILIGHT_CULTIST_SETS.." "..CCG_TEXT["Templar"]);

    itemName = "Twilight Cultist Medallion of Station";
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(itemName);
    else
	itemCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    if(FactionGrinderSettings["Include Items on Alts"])then
	itemCount = itemCount + GrinderCore_AltTotalCount(itemName);
    end
    getglobal("CCG_TwilightCultistMedallionofStationCount"):SetText(itemCount);
    getglobal("CCG_Dukes"):SetText(math.min(CCG_TWILIGHT_CULTIST_SETS,itemCount).." "..CCG_TEXT["Dukes"]);

    itemName = "Twilight Cultist Ring of Lordship";
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(itemName);
    else
	itemCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    if(FactionGrinderSettings["Include Items on Alts"])then
	itemCount = itemCount + GrinderCore_AltTotalCount(itemName);
    end
    getglobal("CCG_TwilightCultistRingofLordshipCount"):SetText(itemCount);
    getglobal("CCG_Lords"):SetText(math.min(CCG_TWILIGHT_CULTIST_SETS,itemCount).." "..CCG_TEXT["Lords"]);

    itemName = "Large Brilliant Shard";
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(itemName);
    else
	itemCount = GrinderCore_PlayerInventoryCount(itemName);
    end
    if(FactionGrinderSettings["Include Items on Alts"])then
	itemCount = itemCount + GrinderCore_AltTotalCount(itemName);
    end
    getglobal("CCG_LBSDukesCount"):SetText(itemCount.."/1");
    getglobal("CCG_LBSLordsCount"):SetText(itemCount.."/5");
end

function CenarionCircleGrinder_ToggleDisplay(frameName)
   local frame = getglobal(frameName)
   if (frame) then
   if(frame:IsVisible()) then
      frame:Hide();
   else
      frame:Show();
   end
   end
end

function CenarionCircleGrinder_OnLoad()
    CenarionCircleGrinder_RegisterEvents();
end

function CenarionCircleGrinder_OnEvent()
    if ( event == "VARIABLES_LOADED" ) then    
        CenarionCircleGrinder_Init();
    elseif((event == "ADDON_LOADED") and (arg1 == "FactionGrinder"))then
	CenarionCircleGrinder_LoadConfiguration();
    elseif(event == "CHAT_MSG_CHANNEL_NOTICE")then
	this:UnregisterEvent("CHAT_MSG_CHANNEL_NOTICE");
	CenarionCircleGrinder_UpdateDisplayData();
	CenarionCircleGrinder_UpdateRepBars();
    elseif( event == "CHAT_MSG_COMBAT_FACTION_CHANGE")then
	CenarionCircleGrinder_UpdateRepBars();
    elseif( event == "PLAYER_LEAVING_WORLD" )then
	GrinderCore_SetGrindingTime("Cenarion Circle",GrinderCore_GetGrindingTime("Cenarion Circle")+CCG_PREVIOUS_GRINDING_TIME);
	GrinderCore_SetRepGround("Cenarion Circle",GrinderCore_GetRepGround("Cenarion Circle")+CCG_PREVIOUS_REP_GROUND);
	if(CCG_NOW_GRINDING)then
	    GrinderCore_SetGrindingTime("Cenarion Circle",GrinderCore_GetGrindingTime("Cenarion Circle")+(GetTime()-CCG_GRINDING_STARTED_AT));
	    GrinderCore_SetRepGround("Cenarion Circle",GrinderCore_GetRepGround("Cenarion Circle")+(CCG_GetCurrentRepTotal() - CCG_INITIALREP));
	end
    end
end

function CenarionCircleGrinder_LoadConfiguration()
    --this is where we would load the localization values if needed
    if(GetLocale() == "deDE") then
    	CCG_TEXT = CCG_TEXT_DE;

	getglobal("CenarionCircleGrinderDisplayFrame"):SetWidth(207);

	--Reconstruct Grind-Tracker frame
	getglobal("CenarionCircleGrinderGrindFrame"):SetWidth(215);
	getglobal("CCG_TimeTodayVal"):SetPoint("TOPLEFT","CenarionCircleGrinderGrindFrame","TOPLEFT",108,-68);
	getglobal("CCG_RepTodayVal"):SetPoint("TOPLEFT","CenarionCircleGrinderGrindFrame","TOPLEFT",108,-79);
	getglobal("CCG_RepPerHourTodayVal"):SetPoint("TOPLEFT","CenarionCircleGrinderGrindFrame","TOPLEFT",108,-90);
	getglobal("CCG_TimeToRepUpTodayVal"):SetPoint("TOPLEFT","CenarionCircleGrinderGrindFrame","TOPLEFT",108,-101);
	getglobal("CCG_TimeTotalVal"):SetPoint("TOPLEFT","CenarionCircleGrinderGrindFrame","TOPLEFT",108,-133);
	getglobal("CCG_RepTotalVal"):SetPoint("TOPLEFT","CenarionCircleGrinderGrindFrame","TOPLEFT",108,-144);
	getglobal("CCG_RepPerHourTotalVal"):SetPoint("TOPLEFT","CenarionCircleGrinderGrindFrame","TOPLEFT",108,-155);
	getglobal("CCG_TimeToRepUpTotalVal"):SetPoint("TOPLEFT","CenarionCircleGrinderGrindFrame","TOPLEFT",108,-166);
    elseif(GetLocale() == "frFR")then
	CCG_TEXT = CCG_TEXT_FR;

	--Reconstruct Grind-Tracker frame
	getglobal("CCG_BU_ToggleGrinding"):SetWidth(144);
    elseif(GetLocale() == "zhTW")then
	CCG_TEXT = CCG_TEXT_ZHTW;

	getglobal("CCG_Volunteer"):SetFontObject(GameFontNormalSmall);
	getglobal("CCG_Veteran"):SetFontObject(GameFontNormalSmall);
	getglobal("CCG_Stalwart"):SetFontObject(GameFontNormalSmall);
	getglobal("CCG_Champion"):SetFontObject(GameFontNormalSmall);
	getglobal("CCG_RepValue"):SetFontObject(GameFontNormalSmall);
	getglobal("CCG_CCRep"):SetFontObject(GameFontNormalSmall);

	--Reconstruct Grind-Tracker frame
        getglobal("CCGToRepUpFrame"):SetWidth(90);
    	getglobal("CCG_SB_ActualRep"):SetWidth(80);
    	getglobal("CCG_SB_RepWithItems"):SetWidth(80);

	getglobal("CenarionCircleGrinderGrindFrame"):SetWidth(215);
	getglobal("CCG_CurrentlyGrinding"):SetFontObject(GameFontNormalSmall);
	getglobal("CCG_Today"):SetFontObject(GameFontNormalSmall);
	getglobal("CCG_TimeToday"):SetFontObject(GameFontNormalSmall);
	getglobal("CCG_RepToday"):SetFontObject(GameFontNormalSmall);
	getglobal("CCG_RepPerHourToday"):SetFontObject(GameFontNormalSmall);
	getglobal("CCG_TimeToRepUpToday"):SetFontObject(GameFontNormalSmall);
	getglobal("CCG_Total"):SetFontObject(GameFontNormalSmall);
	getglobal("CCG_TimeTotal"):SetFontObject(GameFontNormalSmall);
	getglobal("CCG_RepTotal"):SetFontObject(GameFontNormalSmall);
	getglobal("CCG_RepPerHourTotal"):SetFontObject(GameFontNormalSmall);
	getglobal("CCG_TimeToRepUpTotal"):SetFontObject(GameFontNormalSmall);
        getglobal("CCG_TimeTodayVal"):SetPoint("TOPLEFT","CenarionCircleGrinderGrindFrame","TOPLEFT",108,-68);
	getglobal("CCG_RepTodayVal"):SetPoint("TOPLEFT","CenarionCircleGrinderGrindFrame","TOPLEFT",108,-79);
	getglobal("CCG_RepPerHourTodayVal"):SetPoint("TOPLEFT","CenarionCircleGrinderGrindFrame","TOPLEFT",108,-90);
	getglobal("CCG_TimeToRepUpTodayVal"):SetPoint("TOPLEFT","CenarionCircleGrinderGrindFrame","TOPLEFT",108,-101);
	getglobal("CCG_TimeTotalVal"):SetPoint("TOPLEFT","CenarionCircleGrinderGrindFrame","TOPLEFT",108,-133);
	getglobal("CCG_RepTotalVal"):SetPoint("TOPLEFT","CenarionCircleGrinderGrindFrame","TOPLEFT",108,-144);
	getglobal("CCG_RepPerHourTotalVal"):SetPoint("TOPLEFT","CenarionCircleGrinderGrindFrame","TOPLEFT",108,-155);
	getglobal("CCG_TimeToRepUpTotalVal"):SetPoint("TOPLEFT","CenarionCircleGrinderGrindFrame","TOPLEFT",108,-166);
    end
    
    --now that the localization has been loaded, let's set all text variables appropriately
    
    getglobal("CCG_CCRep"):SetText(CCG_TEXT["CC Rep"]);
    getglobal("CCG_YouCanSummon"):SetText(CCG_TEXT["You Can Summon"]);
    
    getglobal("CCG_BU_ToggleGrinding"):SetText(FG_TEXT["Start Grinding"]);
    getglobal("CCG_CurrentlyGrinding"):SetText(FG_RED..FG_TEXT["Not Grinding"]);

    getglobal("CCG_Today"):SetText(FG_WHITE..FG_TEXT["Today's Grinding"]);
    getglobal("CCG_TimeToday"):SetText(FG_GREY..FG_TEXT["Time"].." :");
    getglobal("CCG_RepToday"):SetText(FG_GREY..FG_TEXT["Rep"].." :");
    getglobal("CCG_RepPerHourToday"):SetText(FG_GREY..FG_TEXT["Rep/Hour"].." :");
    getglobal("CCG_Total"):SetText(FG_WHITE..FG_TEXT["Total Grinding"]);
    getglobal("CCG_TimeTotal"):SetText(FG_GREY..FG_TEXT["Time"].." :");
    getglobal("CCG_RepTotal"):SetText(FG_GREY..FG_TEXT["Rep"].." :");
    getglobal("CCG_RepPerHourTotal"):SetText(FG_GREY..FG_TEXT["Rep/Hour"].." :");
    getglobal("CCG_TimeToRepUpToday"):SetText(FG_GREY..FG_TEXT["Rep-up In"].." :");
    getglobal("CCG_TimeToRepUpTotal"):SetText(FG_GREY..FG_TEXT["Rep-up In"].." :");
end

function CenarionCircleGrinder_UpdateRepBars()
    local repPercent = 0;
    local itemPercent = 0;
    local totalPercent = 0;
    for factionIndex = 1, GetNumFactions() do
        factionName,_,standingId,_,_,earnedValue,_,_,isHeader,_,_ = GetFactionInfo(factionIndex)
        if ((isHeader == nil)and(string.find(factionName, CCG_TEXT["Cenarion Circle Faction Name"]))) then
            if(standingId==8)then --Exalted
		getglobal("CCG_SB_ActualRep"):SetValue(100);
		repPercent = 100;
		itemPercent = math.floor(CCG_REP_VALUE/42)/10;
	    elseif(standingId==7)then --Revered
		getglobal("CCG_SB_ActualRep"):SetValue(math.floor((earnedValue-21000)/21000*100));
		getglobal("CCG_SB_RepWithItems"):SetValue(math.min(100,math.floor((earnedValue+CCG_REP_VALUE-21000)/210)));
		repPercent = math.floor((earnedValue-21000)/21)/10;
		itemPercent = math.floor(CCG_REP_VALUE/21)/10;
	    elseif(standingId==6)then --Honored
		getglobal("CCG_SB_ActualRep"):SetValue(math.floor((earnedValue-9000)/12000*100));
		getglobal("CCG_SB_RepWithItems"):SetValue(math.min(100,math.floor((earnedValue+CCG_REP_VALUE-9000)/120)));
		repPercent = math.floor((earnedValue-9000)/12)/10;
		itemPercent = math.floor(CCG_REP_VALUE/12)/10;
	    elseif(standingId==5)then --Friendly
		getglobal("CCG_SB_ActualRep"):SetValue(math.floor((earnedValue-3000)/6000*100));
		getglobal("CCG_SB_RepWithItems"):SetValue(math.min(100,math.floor((earnedValue+CCG_REP_VALUE-3000)/60)));
		repPercent = math.floor((earnedValue-3000)/6)/10;
		itemPercent = math.floor(CCG_REP_VALUE/6)/10;
	    elseif(standingId==4)then --Neutral
		getglobal("CCG_SB_ActualRep"):SetValue(math.floor(earnedValue/3000*100));
		getglobal("CCG_SB_RepWithItems"):SetValue(math.min(100,math.floor((earnedValue+CCG_REP_VALUE)/30)));
		repPercent = math.floor(earnedValue/3)/10;
		itemPercent = math.floor(CCG_REP_VALUE/3)/10;
	    elseif(standingId==3)then --Unfriendly (-3000 to 0)
		getglobal("CCG_SB_ActualRep"):SetValue(math.floor((3000+earnedValue)/3000*100));
		getglobal("CCG_SB_RepWithItems"):SetValue(math.min(100,math.floor((3000+earnedValue+CCG_REP_VALUE)/30)));
		repPercent = math.floor((3000+earnedValue)/3)/10;
		itemPercent = math.floor(CCG_REP_VALUE/3)/10;
	    elseif(standingId==2)then --Hostile (-6000 to -3000)
		getglobal("CCG_SB_ActualRep"):SetValue(math.floor((6000+earnedValue)/3000*100));
		getglobal("CCG_SB_RepWithItems"):SetValue(math.min(100,math.floor((6000+earnedValue+CCG_REP_VALUE)/30)));
		repPercent = math.floor((6000+earnedValue)/3)/10;
		itemPercent = math.floor(CCG_REP_VALUE/3)/10;
	    elseif(standingId==1)then --Hated (-42000 to -6000)
		getglobal("CCG_SB_ActualRep"):SetValue(math.floor((42000+earnedValue)/36000*100));
		getglobal("CCG_SB_RepWithItems"):SetValue(math.min(100,math.floor((42000+earnedValue+CCG_REP_VALUE)/360)));
		repPercent = math.floor((42000+earnedValue)/36)/10;
		itemPercent = math.floor(CCG_REP_VALUE/36)/10;
            end
        end
    end
    totalPercent = repPercent + itemPercent;
    getglobal("CCG_RepPercent"):SetText("|cff00ff00"..repPercent.."% |caaaaaaaa+ |cffffff00"..itemPercent.."% |caaaaaaaa\226\137\136 |cff88ff00"..totalPercent.."%");
end

function CenarionCircleGrinder_ShowTurninToolTip(text,color)
    local RepToRepUp = 0;
    for factionIndex = 1, GetNumFactions() do
        factionName,_,standingId,_,topValue,earnedValue,_,_,isHeader,_,_ = GetFactionInfo(factionIndex)
        if ((isHeader == nil)and(string.find(factionName, CCG_TEXT["Cenarion Circle Faction Name"]))) then
	    if(standingId == 8)then --exalted
		RepToRepUp = 0;
	    else
		RepToRepUp = math.max(topValue-earnedValue-CCG_REP_VALUE,0);
	    end
	end
    end

    local fifty = 50;
    local onehundred = 100;
    local onefifty = 150;
    local twohundred = 200;

    local race = UnitRace("player");
    if race == FG_TEXT["Human"] then
	fifty = 55;
	onehundred = 110;
	onefifty = 165;
	twohundred = 220;
    end

    local tooltip = getglobal("CCGToolTip");
    tooltip:SetOwner(button,"ANCHOR_TOPLEFT",0,0);
    tooltip:ClearLines();
    if(color=="white")then
	tooltip:AddLine(FG_WHITE..CCG_TEXT[text]);
    elseif(color=="green")then
	tooltip:AddLine(FG_GREEN..CCG_TEXT[text]);
    elseif(color=="blue")then
	tooltip:AddLine(FG_SUPERIOR..CCG_TEXT[text]);
    elseif(color=="purple")then
	tooltip:AddLine(FG_EPIC..CCG_TEXT[text]);
    end

    local itemCount;
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(text);
    else
	itemCount = GrinderCore_PlayerInventoryCount(text);
    end

    local BadgeCount = 0;
    if((text=="Cenarion Combat Badge")or(text=="Cenarion Logistics Badge")or(text=="Cenarion Tactical Badge"))then
	if(FactionGrinderSettings["Include Bank Bags"])then
	    BadgeCount = math.min(GrinderCore_PlayerTotalCount("Cenarion Combat Badge"),math.min(GrinderCore_PlayerTotalCount("Cenarion Logistics Badge"),GrinderCore_PlayerTotalCount("Cenarion Tactical Badge")));
	else
	    BadgeCount = math.min(GrinderCore_PlayerInventoryCount("Cenarion Combat Badge"),math.min(GrinderCore_PlayerInventoryCount("Cenarion Logistics Badge"),GrinderCore_PlayerInventoryCount("Cenarion Tactical Badge")));
	end
    end

    if(text=="Encrypted Twilight Text")then
	tooltip:AddLine(FG_GREY.."10 = "..onehundred.." "..FG_TEXT["rep"]);
	tooltip:AddLine(FG_YELLOW..itemCount.."/10 = "..(math.floor(itemCount/10)*onehundred).." "..FG_TEXT["rep"]);
	tooltip:AddLine(FG_GRUE..(math.floor((RepToRepUp/onehundred)+0.9999)*10-math.mod(itemCount,10)).." "..FG_TEXT["to rep-up"]);
    elseif(text=="Abyssal Crest")then
	tooltip:AddLine(FG_GREY.."3 = "..fifty.." "..FG_TEXT["rep"]);
	tooltip:AddLine(FG_YELLOW..itemCount.."/3 = "..(math.floor(itemCount/3)*fifty).." "..FG_TEXT["rep"]);
	tooltip:AddLine(FG_GRUE..(math.floor((RepToRepUp/fifty)+0.9999)*3-math.mod(itemCount,3)).." "..FG_TEXT["to rep-up"]);    
    elseif(text=="Abyssal Signet")then
	tooltip:AddLine(FG_GREY.."3 = "..onehundred.." "..FG_TEXT["rep"]);
	tooltip:AddLine(FG_YELLOW..itemCount.."/3 = "..(math.floor(itemCount/3)*onehundred).." "..FG_TEXT["rep"]);
	tooltip:AddLine(FG_GRUE..(math.floor((RepToRepUp/onehundred)+0.9999)*3-math.mod(itemCount,3)).." "..FG_TEXT["to rep-up"]);    
    elseif(text=="Abyssal Scepter")then
	tooltip:AddLine(FG_GREY.."3 = "..onefifty.." "..FG_TEXT["rep"]);
	tooltip:AddLine(FG_YELLOW..itemCount.."/3 = "..(math.floor(itemCount/3)*onefifty).." "..FG_TEXT["rep"]);
	tooltip:AddLine(FG_GRUE..(math.floor((RepToRepUp/onefifty)+0.9999)*3-math.mod(itemCount,3)).." "..FG_TEXT["to rep-up"]);    
    elseif(text=="Cenarion Combat Badge")then
	tooltip:AddLine(FG_GREY..CCG_TEXT["One of each badge"].." = "..twohundred.." "..FG_TEXT["rep"]);
	tooltip:AddLine(FG_YELLOW..BadgeCount.." "..CCG_TEXT["badge sets"].." = "..(BadgeCount*twohundred).." "..FG_TEXT["rep"]);
	tooltip:AddLine(FG_GRUE..(math.floor((RepToRepUp/twohundred)+0.9999)).." "..CCG_TEXT["badge sets to rep-up"]);    
    elseif(text=="Cenarion Logistics Badge")then
	tooltip:AddLine(FG_GREY..CCG_TEXT["One of each badge"].." = "..twohundred.." "..FG_TEXT["rep"]);
	tooltip:AddLine(FG_YELLOW..BadgeCount.." "..CCG_TEXT["badge sets"].." = "..(BadgeCount*twohundred).." "..FG_TEXT["rep"]);
	tooltip:AddLine(FG_GRUE..(math.floor((RepToRepUp/twohundred)+0.9999)).." "..CCG_TEXT["badge sets to rep-up"]);    
    elseif(text=="Cenarion Tactical Badge")then
	tooltip:AddLine(FG_GREY..CCG_TEXT["One of each badge"].." = "..twohundred.." "..FG_TEXT["rep"]);
	tooltip:AddLine(FG_YELLOW..BadgeCount.." "..CCG_TEXT["badge sets"].." = "..(BadgeCount*twohundred).." "..FG_TEXT["rep"]);
	tooltip:AddLine(FG_GRUE..(math.floor((RepToRepUp/twohundred)+0.9999)).." "..CCG_TEXT["badge sets to rep-up"]);    
    elseif(text=="Mark of Remulos")then
	tooltip:AddLine(FG_GREY..CCG_TEXT["One needed for Stalwart's Battlegear turnin"]);
    elseif(text=="Mark of Cenarius")then
	tooltip:AddLine(FG_GREY..CCG_TEXT["One needed for Champion's Battlegear turnin"]);
    end
    tooltip:Show();
    tooltip:ClearAllPoints();
    tooltip:SetPoint("BOTTOM","CenarionCircleGrinderDisplayFrame","TOP",0,-5);
end

function CenarionCircleGrinder_ShowSummonsToolTip(text,color)
    local tooltip = getglobal("CCGToolTip");
    tooltip:SetOwner(button,"ANCHOR_TOPLEFT",0,0);
    tooltip:ClearLines();
    if(color=="white")then
	tooltip:AddLine(FG_WHITE..CCG_TEXT[text]);
    elseif(color=="green")then
	tooltip:AddLine(FG_GREEN..CCG_TEXT[text]);
    elseif(color=="blue")then
	tooltip:AddLine(FG_SUPERIOR..CCG_TEXT[text]);
    elseif(color=="purple")then
	tooltip:AddLine(FG_EPIC..CCG_TEXT[text]);
    end

    local itemCount;
    if(FactionGrinderSettings["Include Bank Bags"])then
	itemCount = GrinderCore_PlayerTotalCount(text);
    else
	itemCount = GrinderCore_PlayerInventoryCount(text);
    end
    if(FactionGrinderSettings["Include Items on Alts"])then
	itemCount = itemCount + GrinderCore_AltTotalCount(text);
    end

    if(text=="Twilight Cultist Mantle")then
	tooltip:AddLine(FG_GREY..CCG_TEXT["One Mantle, Cowl, and Robe are needed for each summon"]);
    elseif(text=="Twilight Cultist Cowl")then
	tooltip:AddLine(FG_GREY..CCG_TEXT["One Mantle, Cowl, and Robe are needed for each summon"]);
    elseif(text=="Twilight Cultist Robe")then
	tooltip:AddLine(FG_GREY..CCG_TEXT["One Mantle, Cowl, and Robe are needed for each summon"]);
    elseif(text=="Twilight Cultist Medallion of Station")then
	tooltip:AddLine(FG_GREY..CCG_TEXT["One Medallion is needed for each Duke summon"]);
    elseif(text=="Twilight Cultist Ring of Lordship")then
	tooltip:AddLine(FG_GREY..CCG_TEXT["One Ring needed for each Lord summon"]);
    elseif(text=="Abyssal Crest")then
	tooltip:AddLine(FG_GREY..CCG_TEXT["Three Crests are needed to make a Medallion of Station"]);
    elseif(text=="Abyssal Signet")then
	tooltip:AddLine(FG_GREY..CCG_TEXT["Three Signets are needed to make a Ring of Lordship"]);
    elseif(text=="Large Brilliant Shard")then
	tooltip:AddLine(FG_GREY..CCG_TEXT["One Shard is needed to make a Medallion of Station"]);
	tooltip:AddLine(FG_GREY..CCG_TEXT["Five Shards are needed to make a Ring of Lordship"]);
    end
    tooltip:Show();
    tooltip:ClearAllPoints();
    tooltip:SetPoint("BOTTOM","CenarionCircleGrinderSummonsFrame","TOP",0,-5);
end

function CenarionCircleGrinder_HideToolTip()
    getglobal("CCGToolTip"):Hide();
end

function CCG_GetCurrentRepTotal()
    for factionIndex = 1, GetNumFactions() do
        factionName,_,_,_,_,earnedValue,_,_,isHeader,_,_ = GetFactionInfo(factionIndex)
        if ((isHeader == nil)and(string.find(factionName, CCG_TEXT["Cenarion Circle Faction Name"]))) then
	    return earnedValue + CCG_REP_VALUE;
	end
    end
    return 0;
end

function CenarionCircleGrinder_ToggleGrinding()
    CCG_NOW_GRINDING = not CCG_NOW_GRINDING;

    local button = getglobal("CCG_BU_ToggleGrinding");
    if(CCG_NOW_GRINDING)then
	button:SetText(FG_TEXT["Stop Grinding"]);
	getglobal("CCG_CurrentlyGrinding"):SetText(FG_GREEN..FG_TEXT["Grinding"]);

	CCG_GRINDING_STARTED_AT = GetTime();
	CCG_INITIALREP = CCG_GetCurrentRepTotal();
    else
	button:SetText(FG_TEXT["Start Grinding"]);
	getglobal("CCG_CurrentlyGrinding"):SetText(FG_RED..FG_TEXT["Not Grinding"]);

	CCG_PREVIOUS_GRINDING_TIME = CCG_PREVIOUS_GRINDING_TIME + (GetTime()-CCG_GRINDING_STARTED_AT);
	CCG_PREVIOUS_REP_GROUND = CCG_PREVIOUS_REP_GROUND + (CCG_GetCurrentRepTotal() - CCG_INITIALREP); 
    end
end

function CenarionCircleGrinder_UpdateGrindingStats()
    if(GrinderCore_FactionItemsChanged("CenarionCircleGrinder"))then	
	GrinderCore_AcknowledgeItemChange("CenarionCircleGrinder");
	CenarionCircleGrinder_UpdateDisplayData();
    end

    if(GetTime() > CCG_NEXT_GRIND_UPDATE)then
	CCG_NEXT_GRIND_UPDATE = CCG_NEXT_GRIND_UPDATE + CCG_GRIND_UPDATE_INTERVAL;
	local RepPerSecond = 0;

        if(CCG_NOW_GRINDING)then	
	    getglobal("CCG_TimeTodayVal"):SetText(FG_GREY..FactionGrinder_SecondsToTime(CCG_PREVIOUS_GRINDING_TIME + (GetTime()-CCG_GRINDING_STARTED_AT)));
	    getglobal("CCG_RepTodayVal"):SetText(FG_GREY..(CCG_PREVIOUS_REP_GROUND + (CCG_GetCurrentRepTotal() - CCG_INITIALREP)));
	    RepPerSecond = ((CCG_PREVIOUS_REP_GROUND + (CCG_GetCurrentRepTotal() - CCG_INITIALREP)) / 
                            math.max(math.floor(CCG_PREVIOUS_GRINDING_TIME + (GetTime()-CCG_GRINDING_STARTED_AT)),1));
	    getglobal("CCG_RepPerHourTodayVal"):SetText(FG_GREY..math.floor(RepPerSecond*3600));
	    getglobal("CCG_TimeToRepUpTodayVal"):SetText(FG_GREY..CCG_TimeToRepUp(RepPerSecond));

	    getglobal("CCG_TimeTotalVal"):SetText(FG_GREY..FactionGrinder_SecondsToTime(GrinderCore_GetGrindingTime("Cenarion Circle")+CCG_PREVIOUS_GRINDING_TIME + (GetTime()-CCG_GRINDING_STARTED_AT)));
	    getglobal("CCG_RepTotalVal"):SetText(FG_GREY..(GrinderCore_GetRepGround("Cenarion Circle")+CCG_PREVIOUS_REP_GROUND + (CCG_GetCurrentRepTotal() - CCG_INITIALREP)));
	    RepPerSecond = ((GrinderCore_GetRepGround("Cenarion Circle")+CCG_PREVIOUS_REP_GROUND + (CCG_GetCurrentRepTotal() - CCG_INITIALREP)) / 
                            math.max(math.floor(GrinderCore_GetGrindingTime("Cenarion Circle")+CCG_PREVIOUS_GRINDING_TIME + (GetTime()-CCG_GRINDING_STARTED_AT)),1));
	    getglobal("CCG_RepPerHourTotalVal"):SetText(FG_GREY..math.floor(RepPerSecond*3600));
	    getglobal("CCG_TimeToRepUpTotalVal"):SetText(FG_GREY..CCG_TimeToRepUp(RepPerSecond));
        else
	    getglobal("CCG_TimeTodayVal"):SetText(FG_GREY..FactionGrinder_SecondsToTime(CCG_PREVIOUS_GRINDING_TIME));
	    getglobal("CCG_RepTodayVal"):SetText(FG_GREY..(CCG_PREVIOUS_REP_GROUND));
	    RepPerSecond = (CCG_PREVIOUS_REP_GROUND / math.max(CCG_PREVIOUS_GRINDING_TIME,1));
	    getglobal("CCG_RepPerHourTodayVal"):SetText(FG_GREY..math.floor(RepPerSecond*3600));
	    getglobal("CCG_TimeToRepUpTodayVal"):SetText(FG_GREY..CCG_TimeToRepUp(RepPerSecond));

	    getglobal("CCG_TimeTotalVal"):SetText(FG_GREY..FactionGrinder_SecondsToTime(GrinderCore_GetGrindingTime("Cenarion Circle")+CCG_PREVIOUS_GRINDING_TIME));
	    getglobal("CCG_RepTotalVal"):SetText(FG_GREY..(GrinderCore_GetRepGround("Cenarion Circle")+CCG_PREVIOUS_REP_GROUND));
	    RepPerSecond = ((GrinderCore_GetRepGround("Cenarion Circle")+CCG_PREVIOUS_REP_GROUND) / 
                            math.max(math.floor(GrinderCore_GetGrindingTime("Cenarion Circle")+CCG_PREVIOUS_GRINDING_TIME),1));
	    getglobal("CCG_RepPerHourTotalVal"):SetText(FG_GREY..math.floor(RepPerSecond*3600));
	    getglobal("CCG_TimeToRepUpTotalVal"):SetText(FG_GREY..CCG_TimeToRepUp(RepPerSecond));
        end
    end
end

function CCG_TimeToRepUp(RepPerSecond)
    if(RepPerSecond==0)then
	return "-----"
    end

    for factionIndex = 1, GetNumFactions() do
        factionName, description, standingId, bottomValue, topValue, earnedValue, atWarWith,
        canToggleAtWar, isHeader, isCollapsed, isWatched = GetFactionInfo(factionIndex)
        if ((isHeader == nil)and(string.find(factionName, CCG_TEXT["Cenarion Circle Faction Name"]))) then
	    if(standingId == 8)then --exalted
		return "-----";
	    else
		local RepToRepUp = math.max(topValue-earnedValue-CCG_REP_VALUE,0);
		return FactionGrinder_SecondsToTime(RepToRepUp / RepPerSecond);
	    end
	end
    end
end

function CenarionCircleGrinder_ItemButtonClick(itemName, color)
    if(color == "white")then color = FG_WHITE;
    elseif(color == "green")then color = FG_GREEN;
    elseif(color == "blue")then color = FG_SUPERIOR;
    elseif(color == "purple")then color = FG_EPIC; end
    if(ChatFrameEditBox:IsVisible() and IsShiftKeyDown() and ((GrinderCore_PlayerInventoryCount(itemName) > 0)or(GrinderCore_PlayerTotalCount(itemName) > 0)or(GrinderCore_AltTotalCount(itemName) >0)))then
    	ChatFrameEditBox:Insert(color.."|Hitem:"..(GrinderCore_Settings["Item IDs"][itemName])..":0:0:0|h["..CCG_TEXT[itemName].."]|h|r");
    elseif(ChatFrameEditBox:IsVisible()) then
	ChatFrameEditBox:Insert(itemName);
    end
end
