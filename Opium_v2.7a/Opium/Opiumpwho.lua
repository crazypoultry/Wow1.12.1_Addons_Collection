--[[
OPIUM (Opium Personal Identification User Manager)
KoS manager and player info, by Oystein
]]

OPIUM_VERSION = "2.7a";

OPIUM_TITLE = "Opium " .. OPIUM_VERSION;


OPIUM_ITEM_HEIGHT = 16;
OPIUM_ITEMS_SHOWN = 23;


OPIUM_AUTOSTORE_NONE = 0;
OPIUM_AUTOSTORE_ALLIES = 1;
OPIUM_AUTOSTORE_ENEMIES = 2;
OPIUM_AUTOSTORE_ALL = 3;
OPIUM_AUTOSTORE_COMBAT = 4;

OPIUM_TIMEOFFSET = 1112600000;

OPIUM_INDEX_LEVEL = 0;
OPIUM_INDEX_RACE = 1;
OPIUM_INDEX_CLASS = 2;
OPIUM_INDEX_FACTION = 3;
OPIUM_INDEX_GUILD = 4;
OPIUM_INDEX_GUILDTITLE = 5;
OPIUM_INDEX_LASTSEEN = 6;
OPIUM_INDEX_LOSSES = 7;
OPIUM_INDEX_WINS = 8;
OPIUM_INDEX_PVPRANK = 9;

OPIUM_INDEX_REASON = 0;
OPIUM_INDEX_FLAG = 1;

local SEARCH_NAME = 1;
local SEARCH_MINLVL = 2;
local SEARCH_MAXLVL = 3;
local SEARCH_RACE = 4;
local SEARCH_CLASS = 5;
local SEARCH_GUILD = 6;
local SEARCH_FACTION = 7;
local SEARCH_MINDAYS = 8;
local SEARCH_MAXDAYS = 9;
local SEARCH_PVPSTATS = 10;

OPIUM_FACTIONINDEX["Alliance"] = 1;
OPIUM_FACTIONINDEX["Horde"] = 2;

OPIUM_FACTIONINDEX[1] = "Alliance";
OPIUM_FACTIONINDEX[2] = "Horde";


local Opium_origGetWhoInfo;

local pwhoDisplayIndices;
local lastUpdatedPlayer;
local searchPurpose = 1;

opiumLastDamagerToMe = nil;

local searchParams = { };
local purgeParams = { };


opiumDamagedTargets = { };

OPIUM_NUMDAMAGED = 5;

local OPIUM_DROPDOWN_LIST = {
        { name = OPIUM_TEXT_LASTSEEN, sortType = "lastseen" },
	{ name = OPIUM_TEXT_NAME, sortType = "name" },
	{ name = OPIUM_TEXT_LEVEL, sortType = "level" },
        { name = OPIUM_TEXT_CLASS, sortType = "class" },
	{ name = OPIUM_TEXT_GUILD, sortType = "guild" },
	{ name = OPIUM_TEXT_FACTION, sortType = "faction" },
        { name = OPIUM_TEXT_KILLS, sortType = "wins" },
        { name = OPIUM_TEXT_DEATHS, sortType = "losses" }
        
};



function OpiumSearch_LoadEmptyValues()
   OS_NameEditBox:SetText("");
   OS_MinimumLevelEditBox:SetText("");
   OS_MaximumLevelEditBox:SetText("");
   OS_GuildEditBox:SetText("");
   OS_MinDaysEditBox:SetText("");
   OS_MaxDaysEditBox:SetText("");
end



function OpiumSearchFrame_SaveSearchParams()

end

function OpiumSearchFrame_Cancel()
   HideUIPanel(OpiumSearchFrame);
end



function Opium_PurgeData()
   local timeNow = time() - OPIUM_TIMEOFFSET;

	for index, value in OpiumData.playerLinks[realmName] do
	   if( Opium_PlayerSearchMatch(index, purgeParams, timeNow) ) then
 	      OpiumData.playerLinks[realmName][index] = nil;
	   end
	end

      HideUIPanel(OpiumPurgeConfirmFrame);
      Opium_BuildDisplayIndices();
      Opium_Refresh();

end


function OpiumResetWindow()
   searchParams = { };
   Opium_BuildDisplayIndices();
   Opium_Refresh();
end




function OpiumGetSearchData(searchParams)

   local name = string.lower(OS_NameEditBox:GetText());
   if( name ~= "" ) then
      searchParams[SEARCH_NAME] = name;
   else
      searchParams[SEARCH_NAME] = nil;
   end

   searchParams[SEARCH_MINLVL] = tonumber(OS_MinimumLevelEditBox:GetText());
   searchParams[SEARCH_MAXLVL] = tonumber(OS_MaximumLevelEditBox:GetText());

   searchParams[SEARCH_MINDAYS] = tonumber(OS_MinDaysEditBox:GetText());
   searchParams[SEARCH_MAXDAYS] = tonumber(OS_MaxDaysEditBox:GetText());

   local pvpstats = UIDropDownMenu_GetSelectedID(OS_PvPStatsDropDown);
   if( pvpstats ~= nil and pvpstats ~= 1) then
      searchParams[SEARCH_PVPSTATS] = pvpstats - 1;
   else
      searchParams[SEARCH_PVPSTATS] = nil;
   end

   local race = UIDropDownMenu_GetSelectedID(OS_RaceDropDown);
   if( race ~= nil and race ~= 1) then
      searchParams[SEARCH_RACE] = race - 1;
   else
      searchParams[SEARCH_RACE] = nil;
   end

   local class = UIDropDownMenu_GetSelectedID(OS_ClassDropDown);
   if( class ~= nil and class ~= 1) then
      searchParams[SEARCH_CLASS] = class - 1;
   else
      searchParams[SEARCH_CLASS] = nil;
   end

   local guild = string.lower(OS_GuildEditBox:GetText());
   if( guild ~= "" ) then
      searchParams[SEARCH_GUILD] = guild;
   else
      searchParams[SEARCH_GUILD] = nil;
   end

   local faction = UIDropDownMenu_GetSelectedID(OS_FactionDropDown);
   if( faction ~= nil and faction ~= 1) then
      searchParams[SEARCH_FACTION] = faction - 1;
   else
      searchParams[SEARCH_FACTION] = nil;
   end

   HideUIPanel(OpiumSearchFrame);


end

function OpiumSearchFrame_Okay()
   if( searchPurpose == 1 ) then
      OpiumGetSearchData(searchParams);

      Opium_BuildDisplayIndices();
      Opium_Refresh();
   else
      OpiumGetSearchData(purgeParams);
      ShowUIPanel(OpiumPurgeConfirmFrame);
     
   end

end

function OpiumFactionDropDown_OnShow()
   UIDropDownMenu_Initialize(OS_FactionDropDown, OpiumFactionDropDown_Initialize);
   UIDropDownMenu_SetSelectedID(OS_FactionDropDown, 1);
end


function OpiumClassDropDown_OnShow()
   UIDropDownMenu_Initialize(OS_ClassDropDown, OpiumClassDropDown_Initialize);
   UIDropDownMenu_SetSelectedID(OS_ClassDropDown, 1);
end


function OpiumRaceDropDown_OnShow()
   UIDropDownMenu_Initialize(OS_RaceDropDown, OpiumRaceDropDown_Initialize);
   UIDropDownMenu_SetSelectedID(OS_RaceDropDown, 1);
end

function OpiumPvPStatsDropDown_OnShow()
   UIDropDownMenu_Initialize(OS_PvPStatsDropDown, OpiumPvPStatsDropDown_Initialize);
   UIDropDownMenu_SetSelectedID(OS_PvPStatsDropDown, 1);
end


function OpiumPvPStatsDropDown_Initialize()
   local info;

   info = { };
   info.func = OpiumPvPStatsDropDown_OnClick;

   info = { };
   info.func = OpiumPvPStatsDropDown_OnClick;
   info.text = OPIUM_TEXT_EITHER;
   UIDropDownMenu_AddButton(info);

   info = { };
   info.func = OpiumPvPStatsDropDown_OnClick;
   info.text = OPIUM_TEXT_YES;
   UIDropDownMenu_AddButton(info);

   info = { };
   info.func = OpiumPvPStatsDropDown_OnClick;
   info.text = OPIUM_TEXT_NO;
   UIDropDownMenu_AddButton(info);

end

function OpiumFactionDropDown_Initialize()
   local info;

   info = { };
   info.text = OPIUM_TEXT_ALL;
   info.func = OpiumFactionDropDown_OnClick;

   UIDropDownMenu_AddButton(info);

   for iItem = 1, table.getn(OPIUM_FACTIONINDEX), 1 do
      info = { };
      info.func = OpiumFactionDropDown_OnClick;
      info.text = OPIUM_FACTIONINDEX[iItem];
      UIDropDownMenu_AddButton(info);
   end
end

function OpiumClassDropDown_Initialize()
   local info;

   info = { };
   info.text = OPIUM_TEXT_ALL;
   info.func = OpiumClassDropDown_OnClick;
   UIDropDownMenu_AddButton(info);

   for iItem = 1, table.getn(OPIUM_CLASSINDEX), 1 do
      info = { };
      info.func = OpiumClassDropDown_OnClick;
      info.text = OPIUM_CLASSINDEX[iItem];
      UIDropDownMenu_AddButton(info);
   end
end

function OpiumRaceDropDown_Initialize()
   local info;

   info = { };
   info.text = OPIUM_TEXT_ALL;
   info.func = OpiumRaceDropDown_OnClick;

   UIDropDownMenu_AddButton(info);

   for iItem = 1, table.getn(OPIUM_RACEINDEX), 1 do	
      info = { };
      info.func = OpiumRaceDropDown_OnClick;
      info.text = OPIUM_RACEINDEX[iItem];
      UIDropDownMenu_AddButton(info);
   end
end

function OpiumFactionDropDown_OnClick()
   UIDropDownMenu_SetSelectedID(OS_FactionDropDown, this:GetID());
end

function OpiumClassDropDown_OnClick()
   UIDropDownMenu_SetSelectedID(OS_ClassDropDown, this:GetID());
end

function OpiumRaceDropDown_OnClick()
   UIDropDownMenu_SetSelectedID(OS_RaceDropDown, this:GetID());
end

function OpiumPvPStatsDropDown_OnClick()
   UIDropDownMenu_SetSelectedID(OS_PvPStatsDropDown, this:GetID());
end



function ToggleOpiumSearch()
   if( OpiumSearchFrame:IsVisible() ) then
      HideUIPanel(OpiumSearchFrame);
   else
      OS_TitleText:SetText(OPIUM_TEXT_PLAYERSEARCH);
      searchPurpose = 1;
      OpiumSearch_LoadEmptyValues();
      ShowUIPanel(OpiumSearchFrame);
   end
end

function ToggleOpiumPurge()
   if( OpiumSearchFrame:IsVisible() ) then
      HideUIPanel(OpiumSearchFrame);
   else
      OS_TitleText:SetText(OPIUM_TEXT_PLAYERPURGE);
      searchPurpose = 2;
      OpiumSearch_LoadEmptyValues();
      ShowUIPanel(OpiumSearchFrame);
   end
end




function OpiumFrameDropDownButton_OnClick()
   local oldID = UIDropDownMenu_GetSelectedID(OpiumFrameDropDown);
	UIDropDownMenu_SetSelectedID(OpiumFrameDropDown, this:GetID());
	if( oldID ~= this:GetID() ) then
	   OpiumData.config.currentsort = this:GetID();
   	   Opium_Refresh();
	end
end

local function Opium_UIDropDownMenu_SetSelectedID(frame, id, names)
	UIDropDownMenu_SetSelectedID(frame, id);
	if( not frame ) then
		frame = this;
	end
	UIDropDownMenu_SetText(names[id].name, frame);
end

local function OpiumFrameDropDown_Initialize()
	local info;
	for i = 1, getn(OPIUM_DROPDOWN_LIST), 1 do
		info = { };
		info.text = OPIUM_DROPDOWN_LIST[i].name;
		info.func = OpiumFrameDropDownButton_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function OpiumFrameDropDown_SetSearch()
   if( OpiumData and OpiumData.config.currentsort ) then
      Opium_UIDropDownMenu_SetSelectedID(OpiumFrameDropDown, OpiumData.config.currentsort, OPIUM_DROPDOWN_LIST);
   end
end


function OpiumFrameDropDown_OnLoad()
	UIDropDownMenu_Initialize(OpiumFrameDropDown, OpiumFrameDropDown_Initialize);
        Opium_UIDropDownMenu_SetSelectedID(OpiumFrameDropDown, 1, OPIUM_DROPDOWN_LIST);
	UIDropDownMenu_SetWidth(80);
	UIDropDownMenu_SetButtonWidth(24);
	UIDropDownMenu_JustifyText("LEFT", OpiumFrameDropDown)
end


function Opium_GenericComparison(elem1, elem2, v1, v2)
	if( v1 == v2 ) then
		return elem1 < elem2;
	end
	if( not v1 ) then
		return 1;
	end
	if( not v2 ) then
		return nil;
	end
	return v1 < v2;
end

function Opium_FactionComparison(elem1, elem2)
   v1 = OpiumData.playerLinks[realmName][elem1][OPIUM_INDEX_FACTION];
   v2 = OpiumData.playerLinks[realmName][elem2][OPIUM_INDEX_FACTION];

   return Opium_GenericComparison(elem1, elem2, v1, v2)
end

function Opium_ClassComparison(elem1, elem2)
   v1 = OpiumData.playerLinks[realmName][elem1][OPIUM_INDEX_CLASS];
   v2 = OpiumData.playerLinks[realmName][elem2][OPIUM_INDEX_CLASS];

   return Opium_GenericComparison(elem1, elem2, v1, v2)
end


function Opium_GuildComparison(elem1, elem2)
   v1 = OpiumData.playerLinks[realmName][elem1][OPIUM_INDEX_GUILD];
   v2 = OpiumData.playerLinks[realmName][elem2][OPIUM_INDEX_GUILD];

   return Opium_GenericComparison(elem1, elem2, v1, v2)
end


function Opium_LastSeenComparison(elem1, elem2)
   v1 = OpiumData.playerLinks[realmName][elem1][OPIUM_INDEX_LASTSEEN];
   v2 = OpiumData.playerLinks[realmName][elem2][OPIUM_INDEX_LASTSEEN];

   return Opium_GenericComparison(elem2, elem1, v2, v1)
end

function Opium_LossesComparison(elem1, elem2)
   v1 = OpiumData.playerLinks[realmName][elem1][OPIUM_INDEX_LOSSES];
   v2 = OpiumData.playerLinks[realmName][elem2][OPIUM_INDEX_LOSSES];

   return Opium_GenericComparison(elem2, elem1, v2, v1)
end

function Opium_WinsComparison(elem1, elem2)
   v1 = OpiumData.playerLinks[realmName][elem1][OPIUM_INDEX_WINS];
   v2 = OpiumData.playerLinks[realmName][elem2][OPIUM_INDEX_WINS];

   return Opium_GenericComparison(elem2, elem1, v2, v1)
end

function Opium_LevelComparison(elem1, elem2)
   v1 = OpiumData.playerLinks[realmName][elem1][OPIUM_INDEX_LEVEL];
   v2 = OpiumData.playerLinks[realmName][elem2][OPIUM_INDEX_LEVEL];

   return Opium_GenericComparison(elem1, elem2, v1, v2)
end

local function Opium_Sort()
	if( OPIUM_DROPDOWN_LIST[UIDropDownMenu_GetSelectedID(OpiumFrameDropDown)].sortType ) then
		local sortType = OPIUM_DROPDOWN_LIST[UIDropDownMenu_GetSelectedID(OpiumFrameDropDown)].sortType;

		if( sortType == "name" ) then
                   table.sort(pwhoDisplayIndices);
		elseif( sortType == "level" ) then
                   table.sort(pwhoDisplayIndices, Opium_LevelComparison);
		elseif( sortType == "guild" ) then
                   table.sort(pwhoDisplayIndices, Opium_GuildComparison);
		elseif( sortType == "faction" ) then
		   table.sort(pwhoDisplayIndices, Opium_FactionComparison);
   		elseif( sortType == "class" ) then
		   table.sort(pwhoDisplayIndices, Opium_ClassComparison);
     		elseif( sortType == "lastseen" ) then
		   table.sort(pwhoDisplayIndices, Opium_LastSeenComparison);
     		elseif( sortType == "wins" ) then
		   table.sort(pwhoDisplayIndices, Opium_WinsComparison);
     		elseif( sortType == "losses" ) then
		   table.sort(pwhoDisplayIndices, Opium_LossesComparison);

		end

	end
end


function Opium_PlayerSearchMatch(index, searchParams, timeNow)
   local add = 1;
   local currentPlayer = OpiumData.playerLinks[realmName][index];

   local days = nil;
   if( currentPlayer[OPIUM_INDEX_LASTSEEN] ) then
      days = floor( (timeNow - currentPlayer[OPIUM_INDEX_LASTSEEN]) / 86400 );
   end

	   if( days and add ~= 0 and searchParams[SEARCH_MINDAYS] ~= nil ) then
	      if( days < searchParams[SEARCH_MINDAYS] ) then
	         add = 0;
	      end
	   end

	   if( days and add ~= 0 and searchParams[SEARCH_MAXDAYS] ~= nil ) then
	      if( days > searchParams[SEARCH_MAXDAYS] ) then
	         add = 0;
	      end
	   end

	   if( searchParams[SEARCH_NAME] ~= nil ) then
	      if( string.find(index, searchParams[SEARCH_NAME]) == nil ) then
	         add = 0;
	      end
	   end
 
	   if( add ~= 0 and searchParams[SEARCH_MINLVL] ~= nil ) then
	      if( currentPlayer[OPIUM_INDEX_LEVEL] < searchParams[SEARCH_MINLVL] ) then
	         add = 0;
	      end
	   end

	   if( add ~= 0 and searchParams[SEARCH_MAXLVL] ~= nil ) then
	      if( currentPlayer[OPIUM_INDEX_LEVEL] > searchParams[SEARCH_MAXLVL] ) then
	         add = 0;
	      end
	   end

	   if( add ~= 0 and searchParams[SEARCH_RACE] ~= nil ) then
	      if( currentPlayer[OPIUM_INDEX_RACE] ~= searchParams[SEARCH_RACE] ) then
	         add = 0;
	      end
	   end

	   if( add ~= 0 and searchParams[SEARCH_CLASS] ~= nil ) then
	      if( currentPlayer[OPIUM_INDEX_CLASS] ~= searchParams[SEARCH_CLASS] ) then
	         add = 0;
	      end
	   end

	   if( add ~= 0 and searchParams[SEARCH_GUILD] ~= nil ) then
	      if( currentPlayer[OPIUM_INDEX_GUILD] == nil ) then
	         add = 0;
	      elseif( string.find(string.lower(currentPlayer[OPIUM_INDEX_GUILD]), 
	                               searchParams[SEARCH_GUILD]) == nil ) then
	         add = 0;
	      end
	   end

	   if( add ~= 0 and searchParams[SEARCH_FACTION] ~= nil ) then
	      if( currentPlayer[OPIUM_INDEX_FACTION] ~= searchParams[SEARCH_FACTION] ) then
	         add = 0;
	      end
	   end

	   if( add ~= 0 and searchParams[SEARCH_PVPSTATS] ~= nil ) then
	      if( searchParams[SEARCH_PVPSTATS] == 1) then
	         if( not ( currentPlayer[OPIUM_INDEX_WINS] or currentPlayer[OPIUM_INDEX_LOSSES] ) ) then
		    add = 0;
		 end
	      elseif( currentPlayer[OPIUM_INDEX_WINS] or currentPlayer[OPIUM_INDEX_LOSSES] ) then
	         add = 0;
	      end
	   end

   if( add == 1) then
      return true;
   else
      return false;
   end

end



function Opium_BuildDisplayIndices()
	local iNew = 1;

        if( OpiumData.playerLinks[realmName] == nil ) then
	   return;
	end


        FauxScrollFrame_SetOffset(OpiumListScrollFrame, 0);
	getglobal("OpiumListScrollFrameScrollBar"):SetValue(0);

	pwhoDisplayIndices = { };
        local timeNow = time() - OPIUM_TIMEOFFSET;

	for index, value in OpiumData.playerLinks[realmName] do

           if( Opium_PlayerSearchMatch(index, searchParams, timeNow) ) then
              pwhoDisplayIndices[iNew] = index;
	      iNew = iNew + 1;
	   end

	end

	pwhoDisplayIndices.onePastEnd = iNew;
        table.setn(pwhoDisplayIndices, iNew - 1);
        Opium_Sort();
end


function Opium_Refresh()
   FauxScrollFrame_SetOffset(OpiumListScrollFrame, 0);
   getglobal("OpiumListScrollFrameScrollBar"):SetValue(0);
   Opium_BuildDisplayIndices();
   Opium_Update();
end


function Opium_Update()
   local iItem;

   if( pwhoDisplayIndices == nil ) then
      Opium_BuildDisplayIndices();
   end

   if( pwhoDisplayIndices == nil ) then
      return;
   end

   FauxScrollFrame_Update(OpiumListScrollFrame, pwhoDisplayIndices.onePastEnd - 1,
      OPIUM_ITEMS_SHOWN, OPIUM_ITEM_HEIGHT);

   OpiumTitleText:SetText(OPIUM_TITLE .. " -- " .. getn(pwhoDisplayIndices) .. " " .. OPIUM_TEXT_MATCHES);

   local playerFaction = UnitFactionGroup("player");
   local timeNow = time() - OPIUM_TIMEOFFSET;

	for iItem = 1, OPIUM_ITEMS_SHOWN, 1 do
		local itemIndex = iItem + FauxScrollFrame_GetOffset(OpiumListScrollFrame);
		local playerDBItem = getglobal("OpiumItem"..iItem);
                -- KRIS 1/02/2006 10:18:47 AM
                local name = pwhoDisplayIndices[itemIndex];
                local currentPlayer = nil;

		if( itemIndex < pwhoDisplayIndices.onePastEnd ) then
                        currentPlayer = OpiumData.playerLinks[realmName][name];
                end

                if (currentPlayer ~= nil) then
                        local playerDBItemName = getglobal("OpiumItem" .. iItem .. "Name");
                -- KRIS

			playerDBItemName:SetText(opiumCapitalizeWords(name));
			if( currentPlayer[OPIUM_INDEX_LEVEL] == -1 ) then
			   getglobal("OpiumItem" .. iItem .. "Level"):SetText("?");
			else
                           getglobal("OpiumItem" .. iItem .. "Level"):SetText(
			                 currentPlayer[OPIUM_INDEX_LEVEL]);
		        end

                        getglobal("OpiumItem" .. iItem .. "Group"):SetText(
			                 currentPlayer[OPIUM_INDEX_GUILD]);
                        getglobal("OpiumItem" .. iItem .. "Class"):SetText(
			                 OPIUM_CLASSINDEX[currentPlayer[OPIUM_INDEX_CLASS]] );
			if( OpiumData.playerLinks[realmName][name][OPIUM_INDEX_LASTSEEN] ~= nil ) then
                          getglobal("OpiumItem" .. iItem .. "LastSeen"):SetText(
			                 Opium_TimeToString(timeNow - currentPlayer[OPIUM_INDEX_LASTSEEN] ));
                        else
			   getglobal("OpiumItem" .. iItem .. "LastSeen"):SetText("");
			end

			if( OpiumData.config.trackpvpstats ) then
                           getglobal("OpiumItem" .. iItem .. "Kills"):SetText(Opium_PvPStats(currentPlayer));
			else
   			   getglobal("OpiumItem" .. iItem .. "Kills"):SetText("");
			end

                         if( OPIUM_FACTIONINDEX[currentPlayer[OPIUM_INDEX_FACTION]] == playerFaction ) then
				playerDBItemName:SetTextColor(0.4, 0.4, 1);
                         else
				playerDBItemName:SetTextColor(1, 0.4, 0.4);
                         end

			playerDBItem:Show();
		else
			playerDBItem:Hide();
		end
	end
end


function OpiumItemButton_OnEnter()
   local buttonID = this:GetID();
   local name = pwhoDisplayIndices[buttonID + FauxScrollFrame_GetOffset(OpiumListScrollFrame) ];
   OpiumPlayerListTooltip(name);
end


function OpiumPlayerListTooltip(name)
   local currentPlayer = OpiumData.playerLinks[realmName][name];
   local tooltip, reasonp, reasong;

   if( not currentPlayer ) then
      return;
   end

   GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
   
   tooltip = "|c00ffff00";


   if( currentPlayer[OPIUM_INDEX_PVPRANK] and currentPlayer[OPIUM_INDEX_PVPRANK] > 0) then
 --     Opium_PrintMessage("Faction: " .. currentPlayer[OPIUM_INDEX_FACTION] .. 
 --                        ", rank: " .. currentPlayer[OPIUM_INDEX_PVPRANK]);

      if( OPIUM_RANKTITLE[currentPlayer[OPIUM_INDEX_FACTION]] and
            OPIUM_RANKTITLE[currentPlayer[OPIUM_INDEX_FACTION]][currentPlayer[OPIUM_INDEX_PVPRANK]]) then
         tooltip = tooltip .. OPIUM_RANKTITLE[currentPlayer[OPIUM_INDEX_FACTION]][currentPlayer[OPIUM_INDEX_PVPRANK]] .. " ";
      else
         tooltip = tooltip .. "UNKNOWN ";
      end
   end


   tooltip = tooltip .. opiumCapitalizeWords(name) .. "\n|cffffffff" .. OPIUM_TEXT_LEVEL .. " ";
   if( currentPlayer[OPIUM_INDEX_LEVEL] > 0 ) then
      tooltip = tooltip .. currentPlayer[OPIUM_INDEX_LEVEL];
   else
      tooltip = tooltip .. "?";
   end
   
   tooltip = tooltip .. " ";

      if( currentPlayer[OPIUM_INDEX_RACE] ) then
         tooltip = tooltip .. OPIUM_RACEINDEX[currentPlayer[OPIUM_INDEX_RACE]] .. " ";
      end

      if( currentPlayer[OPIUM_INDEX_CLASS] ) then
         tooltip = tooltip .. OPIUM_CLASSINDEX[currentPlayer[OPIUM_INDEX_CLASS]];
      end
   
   tooltip = tooltip .. "\n";

   if( currentPlayer[OPIUM_INDEX_GUILD] ) then
      if( currentPlayer[OPIUM_INDEX_GUILDTITLE] ) then
         tooltip = tooltip .. currentPlayer[OPIUM_INDEX_GUILDTITLE] .. " " .. OPIUM_TEXT_OF .. " ";
      end

      tooltip = tooltip .. currentPlayer[OPIUM_INDEX_GUILD] .. "\n";
   end

   reasonp = OpiumData.kosPlayer[realmName][name];

   if( currentPlayer[OPIUM_INDEX_GUILD] ) then
      reasong = OpiumData.kosGuild[realmName][ string.gsub(string.lower(currentPlayer[OPIUM_INDEX_GUILD]), "%s", "_") ];
   end
  

   if( reasonp and reasonp[OPIUM_INDEX_REASON] ) then
      tooltip =  tooltip .. Opium_GetKoSFlag(reasonp[OPIUM_INDEX_FLAG]) .. " " .. OPIUM_TEXT_PLAYER .. 
              ": " .. reasonp[OPIUM_INDEX_REASON] .. "\n";
   elseif( reasonp ) then
      tooltip =  tooltip .. Opium_GetKoSFlag(reasonp[OPIUM_INDEX_FLAG]) .. " " .. OPIUM_TEXT_PLAYER .. "\n";     
   end

   if( reasong and reasong[OPIUM_INDEX_REASON] ) then
      tooltip =  tooltip .. Opium_GetKoSFlag(reasong[OPIUM_INDEX_FLAG]) .. " " .. OPIUM_TEXT_GUILD .. 
            ": " .. reasong[OPIUM_INDEX_REASON] .. "\n";
   elseif( reasong ) then
      tooltip =  tooltip .. Opium_GetKoSFlag(reasong[OPIUM_INDEX_FLAG]) .. " " .. OPIUM_TEXT_GUILD .. "\n";
   end

   if( OpiumData.config.trackpvpstats and (currentPlayer[OPIUM_INDEX_WINS] or currentPlayer[OPIUM_INDEX_LOSSES]) ) then
      tooltip = tooltip  .. OPIUM_TEXT_KILLSDEATHS .. ": " .. Opium_PvPStats(currentPlayer) .. "\n";
   end

   if( currentPlayer[OPIUM_INDEX_LASTSEEN] ) then
      tooltip = tooltip .. OPIUM_TEXT_LASTSEEN .. ": " .. Opium_TimeToString(time() - 
                      OPIUM_TIMEOFFSET - currentPlayer[OPIUM_INDEX_LASTSEEN]) .. " " .. OPIUM_TEXT_AGO;
   end


   GameTooltip:SetText(tooltip);

   playerFaction = UnitFactionGroup("player");
   if( playerFaction == OPIUM_FACTIONINDEX[ currentPlayer[OPIUM_INDEX_FACTION]] ) then
      GameTooltip:SetBackdropColor(0.2, 0.2, 1);
   else
      GameTooltip:SetBackdropColor(1, 0.2, 0.2);
   end

   GameTooltip:Show();
  
end

function OpiumItemButton_OnLeave()
   GameTooltip:Hide();
end

function OpiumItemButton_OnClick(arg1)
	if( arg1 == "LeftButton" ) then
                local buttonID = this:GetID();
                local name = pwhoDisplayIndices[buttonID + FauxScrollFrame_GetOffset(OpiumListScrollFrame) ];
         	local player = OpiumData.playerLinks[realmName][name];
		if( player == nil ) then
		   return;
		end

		if( IsShiftKeyDown() and ChatFrameEditBox:IsVisible() ) then

                   local msg = "";

                   if( player[OPIUM_INDEX_PVPRANK] and player[OPIUM_INDEX_PVPRANK] > 0) then
                      msg = msg .. OPIUM_RANKTITLE[player[OPIUM_INDEX_FACTION]][player[OPIUM_INDEX_PVPRANK]] .. " ";
                   end

		   msg = msg .. opiumCapitalizeWords(name) .. ", " .. player[OPIUM_INDEX_LEVEL] .. " ";

		   if( player[OPIUM_INDEX_CLASS] and player[OPIUM_INDEX_RACE] ) then
		      msg = msg .. OPIUM_RACEINDEX[player[OPIUM_INDEX_RACE]] .. " " .. OPIUM_CLASSINDEX[player[OPIUM_INDEX_CLASS]] .. ", ";
		   end

		   if( player[OPIUM_INDEX_GUILD] and player[OPIUM_INDEX_GUILDTITLE]) then
		      msg = msg .. player[OPIUM_INDEX_GUILDTITLE] .. " " .. OPIUM_TEXT_OF .. " " .. player[OPIUM_INDEX_GUILD] .. ", ";
		   end

                  if( player[OPIUM_INDEX_WINS] or player[OPIUM_INDEX_LOSSES] ) then
                     msg = msg ..  OPIUM_TEXT_KILLSDEATHS .. ": " .. Opium_PvPStats(player) .. ", ";
                  end

		   msg = msg .. OPIUM_TEXT_SEEN .. " " .. Opium_TimeToString(time() - OPIUM_TIMEOFFSET - player[OPIUM_INDEX_LASTSEEN]) .. " ago.";

		   ChatFrameEditBox:Insert(msg);
		
		elseif( IsControlKeyDown() ) then
                        -- KRIS 17/01/2006 12:15:13 PM
                        opiumKosCurrentList = 2;
                        -- KRIS
           	   opiumStatsCurrentList = 2;
		   OpiumAddKosEntry(opiumCapitalizeWords(name));
  		elseif( IsAltKeyDown()  ) then
		   if( player[OPIUM_INDEX_GUILD] ) then
                        -- KRIS 17/01/2006 12:15:13 PM
                        opiumKosCurrentList = 1;
                        -- KRIS
              	      opiumStatsCurrentList = 1;
		      OpiumAddKosEntry(  opiumCapitalizeWords(string.gsub(player[OPIUM_INDEX_GUILD], "_", " ")) );
		   end

		end
	end
end



function ToggleOpium()
   if( OpiumFrame:IsVisible() ) then
      HideUIPanel(OpiumFrame);
   else
      searchParams = { };
      OpiumFrameDropDown_SetSearch();
      Opium_BuildDisplayIndices();
      Opium_Update();
      ShowUIPanel(OpiumFrame);
   end
end

-- Split, from the Sea library.
opiumSplit = function ( text, separator )
		local t = {};
		t.n = 0;
		for value in string.gfind(text,"[^"..separator.."]+") do
			t.n = t.n + 1;
			t[t.n] = value;
		end
		return t;
	end;

-- opiumCapitalizeWords, also from the Sea library.

opiumCapitalizeWords = function ( phrase )
	local words = opiumSplit(phrase, " ");
	local capitalizedPhrase = "";

	for i=1,words.n do 
		local v = words[i];
		if ( i ~= 1 ) then
			capitalizedPhrase = capitalizedPhrase.." ";
		end
		capitalizedPhrase = capitalizedPhrase..string.upper(string.sub(v,1,1))..string.sub(v,2);
	end

	return capitalizedPhrase;
end;


function Opium_OpiumCommandHandler(msg)
   local i;

   args = opiumSplit(msg, " ");

   if( not args[1] ) then
      Opium_PrintMessage(OPIUM_TEXT_OPIUMHELP);
      Opium_PrintMessage("'/op stats': " .. OPIUM_TEXT_HELP1);
      Opium_PrintMessage("'/op autostore [none|allies|enemies|all]': " .. OPIUM_TEXT_HELP2 );
      Opium_PrintMessage("'/op resetall': " .. OPIUM_TEXT_HELP3);
      Opium_PrintMessage("'/op resetlastseen': " .. OPIUM_TEXT_HELP4);
      Opium_PrintMessage("'/pwho <\"player\">': " .. OPIUM_TEXT_HELP5);
      Opium_PrintMessage("'/kosg <\"guild\",\"reason\">': " .. OPIUM_TEXT_HELP6);
      Opium_PrintMessage("'/kosp <\"player\",\"reason\">': " .. OPIUM_TEXT_HELP7);
      Opium_PrintMessage("'/op toggleguilddisplay': " .. OPIUM_TEXT_HELP8);
      Opium_PrintMessage("'/op trackpvpstats': " .. OPIUM_TEXT_HELP9);
      Opium_PrintMessage("'/op chatframe': " .. OPIUM_TEXT_HELP10);
      Opium_PrintMessage("'/op textalert': " .. OPIUM_TEXT_HELP11);
      Opium_PrintMessage("'/op soundalert': " .. OPIUM_TEXT_HELP12);
      Opium_PrintMessage("'/op import': " .. OPIUM_TEXT_HELP13);
      Opium_PrintMessage("'/op mmbutton': " .. OPIUM_TEXT_HELP14);
      Opium_PrintMessage("'/op addflag <\"newflag\">': " .. OPIUM_TEXT_HELP15);
      return;
   end

   if( args[1] == "addflag" ) then
      if( not args[2] ) then
         Opium_PrintMessage("Syntax: /op addflag <\"flagname\">");
         return;
      end

      tinsert(OpiumData.flags, {name = args[2]});
      Opium_PrintMessage("Flag '" .. args[2] .. "' added.");
      return;
   end

   if( args[1] == "import" ) then
      Opium_PrintMessage(OPIUM_TEXT_IMPORTINGDATA);

      for realmName1, value in kosData do
         i = 0;
         for index2, value2 in kosData[realmName1]["kos"] do

	    if( OpiumData.kosGuild[realmName1] == nil ) then
	       OpiumData.kosGuild[realmName1] = { };
	    end

	    if( OpiumData.kosPlayer[realmName1] == nil ) then
	       OpiumData.kosPlayer[realmName1] = { };
	    end

	    if( value2['guild'] ) then
               Opium_PrintMessage("Guild: " .. index2);
	       OpiumData.kosGuild[realmName1][string.gsub(string.lower(index2), "%s", "_")] = " ";
            else
               Opium_PrintMessage("Player: " .. index2 .. ": " .. value2['notes']);
               OpiumData.kosPlayer[realmName1][string.gsub(string.lower(index2), "%s", "_")] = value2['notes'];
	    end
            i = i + 1;
         end
         Opium_PrintMessage(realmName1 .. ": " .. i .. " " .. OPIUM_TEXT_RECORDSIMPORTED);
      end
      return;
   end

   if( args[1] == "mmbutton" ) then
      if( not OpiumData.config.mmbutton ) then
         OpiumData.config.mmbutton = true;
	 Opium_PrintMessage(OPIUM_TEXT_MINIMAPBUTTONSHOWN);
      else
         OpiumData.config.mmbutton = false;
	 	 Opium_PrintMessage(OPIUM_TEXT_MINIMAPBUTTONNOTSHOWN);
      end
      OpiumButton_Toggle();
      return;
   end

   if( args[1] == "textalert" ) then
      if( OpiumData.config.textalert == false ) then
         OpiumData.config.textalert = true;
	 Opium_PrintMessage(OPIUM_TEXT_SHOWTEXTALERT);
      else
         OpiumData.config.textalert = false;
	 	 Opium_PrintMessage(OPIUM_TEXT_NOTSHOWTEXTALERT);
      end
      return;
   end

   if( args[1] == "soundalert" ) then
      if( OpiumData.config.soundalert == false ) then
         OpiumData.config.soundalert = true;
	 Opium_PrintMessage(OPIUM_TEXT_SOUNDALERT);
      else
         OpiumData.config.soundalert = false;
	 	 Opium_PrintMessage(OPIUM_TEXT_NOTSOUNDALERT);
      end
      return;
   end

   if( args[1] == "chatframe" ) then
      if( not args[2] ) then
         Opium_PrintMessage("Syntax: /op chatframe <\"framenumber\">");
	 Opium_PrintMessage("Current chatframe is " .. OpiumData.config.chatframe);
         return;
      end
      OpiumData.config.chatframe = args[2];
      Opium_PrintMessage(OPIUM_TEXT_CHATFRAMEISNOW .. " " .. OpiumData.config.chatframe);
      return;
   end

   if( args[1] == "trackpvpstats" ) then
      if( not OpiumData.config.trackpvpstats ) then
         OpiumData.config.trackpvpstats = true;
	 Opium_PrintMessage(OPIUM_TEXT_TRACKPVPSTATS);
      else
         OpiumData.config.trackpvpstats = false;
 	 Opium_PrintMessage(OPIUM_TEXT_NOTPVPSTATS);
      end
      return;
   end

   if( args[1] == "toggleguilddisplay" ) then
      if( OpiumData.config.guilddisplay ) then
         OpiumData.config.guilddisplay = false;
	 Opium_PrintMessage(OPIUM_TEXT_NOTGUILDNAMES);
      else
         OpiumData.config.guilddisplay = true;
	 	 Opium_PrintMessage(OPIUM_TEXT_GUILDNAMES);
      end
      return;
   end


   if( args[1] == "stats" ) then
      Opium_PrintMessage(OPIUM_TEXT_DBRECORDS .. ":");

      for index, value in OpiumData.playerLinks do
         i = 0;
         for index2, value2 in OpiumData.playerLinks[index] do
            i = i + 1;
         end
         Opium_PrintMessage(index .. ": " .. i .. " " .. OPIUM_TEXT_PLAYERRECORDS);
      end

      for index, value in OpiumData.kosPlayer do
         i = 0;
         for index2, value2 in OpiumData.kosPlayer[index] do
            i = i + 1;
         end
         Opium_PrintMessage(index .. ": " .. i .. " " .. OPIUM_TEXT_KOSEDPLAYERS);
      end

      for index, value in OpiumData.kosGuild do
         i = 0;
         for index2, value2 in OpiumData.kosGuild[index] do
            i = i + 1;
         end
         Opium_PrintMessage(index .. ": " .. i .. " " .. OPIUM_TEXT_KOSEDGUILDS);
      end

      return;
   end

   if( args[1] == "resetlastseen" ) then
      Opium_PrintMessage(OPIUM_TEXT_DELETINGTIMESTAMPS);

      for index, value in OpiumData.playerLinks do
         for index2, value2 in OpiumData.playerLinks[index] do
            OpiumData.playerLinks[index][index2][OPIUM_INDEX_LASTSEEN] = nil;
         end
      end
      return;
   end
   
   if( args[1] == "autostore" ) then
      if( not args[2] ) then
         outmsg = OPIUM_TEXT_CURRENTLYSTORE .. " ";
	 if( OpiumData.config.autostore == OPIUM_AUTOSTORE_NONE ) then
	    outmsg = outmsg .. OPIUM_TEXT_NOTARGETS;
	 elseif( OpiumData.config.autostore == OPIUM_AUTOSTORE_ALLIES ) then
	    outmsg = outmsg .. OPIUM_TEXT_ALLIEDTARGETS;
	 elseif( OpiumData.config.autostore == OPIUM_AUTOSTORE_ENEMIES ) then
	    outmsg = outmsg .. OPIUM_TEXT_ENEMYTARGETS;
	 elseif( OpiumData.config.autostore == OPIUM_AUTOSTORE_COMBAT ) then
	 	    outmsg = outmsg .. " " .. OPIUM_TEXT_INCOMBATWITH;
	 elseif( OpiumData.config.autostore == OPIUM_AUTOSTORE_ALL ) then
	    outmsg = outmsg .. OPIUM_TEXT_ALLTARGETS;

	 else
	    outmsg = outmsg .. ERROR .. " " .. OpiumData.config.autostore .. " ";
	 end

	 Opium_PrintMessage("Syntax: /op autostore none|allies|enemies|all");
	 Opium_PrintMessage(outmsg);
      else
         newOpt = string.lower(args[2]);
         outmsg = OPIUM_TEXT_NOWSTORE;

         if( newOpt == "none" ) then
	    OpiumData.config.autostore = OPIUM_AUTOSTORE_NONE;
	    outmsg = outmsg .. OPIUM_TEXT_NOTARGETS;
	 elseif( newOpt == "allies" ) then
	    OpiumData.config.autostore = OPIUM_AUTOSTORE_ALLIES;
	    outmsg = outmsg .. OPIUM_TEXT_ALLIEDTARGETS;
	 elseif( newOpt == "enemies" ) then
	    OpiumData.config.autostore = OPIUM_AUTOSTORE_ENEMIES;
	    outmsg = outmsg .. OPIUM_TEXT_ENEMYTARGETS;
	 elseif( newOpt == "all" ) then
	    OpiumData.config.autostore = OPIUM_AUTOSTORE_ALL;
	    outmsg = outmsg .. OPIUM_TEXT_ALLTARGETS;
 	 elseif( newOpt == "combat" ) then
	    OpiumData.config.autostore = OPIUM_AUTOSTORE_COMBAT;
	    outmsg = outmsg .. OPIUM_TEXT_INCOMBATWITH;

	 else
	    Opium_PrintMessage("Syntax: /op autostore none|allies|enemies|all");
	    return;
         end

	 Opium_PrintMessage(outmsg);
      end
      return;
   end

   if( args[1] == "resetall" ) then
      if( not args[2] ) then
         Opium_PrintMessage(OPIUM_TEXT_DELETEALLWARNING);
	 Opium_PrintMessage(OPIUM_TEXT_CAPDO .. " '/op resetall confirm', " .. OPIUM_TEXT_DELETEALL);
      elseif( args[2] == "confirm" ) then
         OpiumData.playerLinks = { };
	 OpiumData.playerLinks[realmName] = { };
	 OpiumData.kosGuild = { };
	 OpiumData.kosGuild[realmName] = { };
	 OpiumData.kosPlayer = { };
	 OpiumData.kosPlayer[realmName] = { };
	 lastUpdatedPlayer = { };

	 Opium_PrintMessage(OPIUM_TEXT_LONGDELETIONMSG);
      else
         Opium_PrintMessage(OPIUM_TEXT_DELETEALLWARNING);
	 Opium_PrintMessage(OPIUM_TEXT_CAPDO .. " '/op resetall confirm', " .. OPIUM_TEXT_DELETEALL);
      end
      return;
   end

   Opium_PrintMessage(OPIUM_TEXT_INVALIDCOMMAND);
end

function Opium_ConvertDB_3to4()
   local tempTable = { };

   for index, value in OpiumData.kosPlayer do
      tempTable[index] = { };
      for index2, value2 in value do
         tempTable[index][index2] = { };
	 if( value2 ~= " " and value2 ~= "") then
            tempTable[index][index2][OPIUM_INDEX_REASON] = value2;
	 end
      end
   end

   OpiumData.kosPlayer = tempTable;
   tempTable = { };

   for index, value in OpiumData.kosGuild do
      tempTable[index] = { };
      for index2, value2 in value do
         tempTable[index][index2] = { };
	 if( value2 ~= " " and value2 ~= "") then
            tempTable[index][index2][OPIUM_INDEX_REASON] = value2;
	 end
      end
   end

   OpiumData.kosGuild = tempTable;
   tempTable = { };
   Opium_PrintMessage("Opium: Finished converting DB from version 3 to 4");

end



function Opium_ConvertDB_2to3()
   if( opiumConfig["autostore"] ) then
      OpiumData.config.autostore = opiumConfig["autostore"];
   end

   if( opiumConfig["chatframe"] ) then
      OpiumData.config.chatframe = opiumConfig["chatframe"];
   end

   if( opiumConfig["textalert"] ) then
       OpiumData.config.textalert = opiumConfig["textalert"];
   end

   if( opiumConfig["soundalert"] ) then
      OpiumData.config.soundalert = opiumConfig["soundalert"];
   end

   if( opiumConfig["trackpvpstats"] ) then
      OpiumData.config.trackpvpstats = opiumConfig["trackpvpstats"];
   end

   if( opiumConfig["targetbutton"] ) then
      OpiumData.config.targetbutton = opiumConfig["targetbutton"];
   end

   if( opiumConfig["mmbutton"] ) then
      OpiumData.config.mmbutton = opiumConfig["mmbutton"];
   end

   if( opiumConfig["mmbuttonposition"] ) then
      OpiumData.config.mmbuttonposition = opiumConfig["mmbuttonposition"];
   end

   for index, value in playerLinks do
      i = 0;
      OpiumData.playerLinks[index] = { };
      for index2, value2 in playerLinks[index] do
         OpiumData.playerLinks[index][index2] = value2;
         playerLinks[index][index2] = nil;
      end
   end

    OpiumData.kosPlayer = kosPlayer;
    OpiumData.kosGuild = kosGuild;


    if( opiumConfig["disableguilddisplay"] == nil ) then
       OpiumData.config.guilddisplay = true;
    else
       OpiumData.config.guilddisplay = false;
    end

   Opium_PrintMessage(OPIUM_TEXT_DATACONVERTED);
end


function Opium_ConvertDB_1to2()
   Opium_PrintMessage(OPIUM_TEXT_CONVERTINGTABLES);

   local newKos = { };

   for index, value in kosPlayer do
      newKos[index] = value;
   end

   kosPlayer = { };
   kosPlayer[realmName] = { };

   for index, value in newKos do
      kosPlayer[realmName][index] = value;
   end

   newKos = { };

   for index, value in kosGuild do
      newKos[index] = value;
   end

   kosGuild = { };
   kosGuild[realmName] = { };

   for index, value in newKos do
      kosGuild[realmName][index] = value;
   end

   Opium_PrintMessage(OPIUM_TEXT_CONVERSIONCOMPLETE);
end


function Opium_ConvertDB_0to1()

   Opium_PrintMessage(OPIUM_TEXT_CONVERTANDCOMPRESS);

   local newplayerLinks = { };

   for index, value in playerLinks do	   
      newplayerLinks[index] = { };
      newplayerLinks[index][OPIUM_INDEX_LEVEL] = value.level;
      newplayerLinks[index][OPIUM_INDEX_RACE] = OPIUM_RACEINDEX[value.race];  
      newplayerLinks[index][OPIUM_INDEX_CLASS] = OPIUM_CLASSINDEX[value.class];  
      newplayerLinks[index][OPIUM_INDEX_FACTION] = OPIUM_FACTIONINDEX[value.faction];
      newplayerLinks[index][OPIUM_INDEX_GUILD] = value.guild;  
      newplayerLinks[index][OPIUM_INDEX_GUILDTITLE] = value.guildtitle;  
   end


   playerLinks = { };
   playerLinks[realmName] = { };

   for index, value in newplayerLinks do
      playerLinks[realmName][index] = value;
   end

   Opium_PrintMessage(OPIUM_TEXT_CONVERSIONCOMPLETE);
end



function Opium_PwhoCommandHandler(msg)
  if( not msg or msg == "" ) then
     ToggleOpium();
   else
      if( OpiumData.playerLinks[realmName] ) then
         for index, value in OpiumData.playerLinks[realmName] do
	    if(  string.find(index, string.lower(msg)) ~= nil ) then
               Opium_PrintPlayer(index);
            end
	 end
      end
   end
end



function Opium_UnitFrame_OnEnter()
   origUnitFrame_OnEnter();
   --Opium_PrintMessage("Hello");
end


function Opium_Initialize()
	SLASH_PDBPWHO1 = "/pwho";
	SlashCmdList["PDBPWHO"] = function(msg)
		Opium_PwhoCommandHandler(msg);
	end

        SLASH_PDBKOSP1 = "/kosp";
	SlashCmdList["PDBKOSP"] = function(msg)
		Opium_KospCommandHandler(msg);
	end
	
        SLASH_PDBKOSG1 = "/kosg";
	SlashCmdList["PDBKOSG"] = function(msg)
		Opium_KosgCommandHandler(msg);
	end

        SLASH_PDBOPIUM1 = "/opium";
        SLASH_PDBOPIUM2 = "/op";
	SlashCmdList["PDBOPIUM"] = function(msg)
		Opium_OpiumCommandHandler(msg);
	end

        realmName = GetCVar("realmName");
        --player = UnitName("player");

        if( playerLinks and not opiumConfig ) then
	   Opium_ConvertDB_0to1();
	end

        if( opiumConfig and opiumConfig["dbVersion"] == 1 ) then
	   Opium_ConvertDB_1to2()
           opiumConfig["dbVersion"] = 2;
	end

        if( not OpiumData ) then
	   OpiumData = { };
	   OpiumData.playerLinks = { }
	   OpiumData.kosPlayer = { };
	   OpiumData.kosGuild = { };
	   OpiumData.config = { };
	   OpiumData.config.autostore = OPIUM_AUTOSTORE_ENEMIES;
	   OpiumData.config.chatframe = 2;
	   OpiumData.config.textalert = true;
           OpiumData.config.soundalert = false;
	   OpiumData.config.trackpvpstats = true;
	   OpiumData.config.targetbutton = true;
	   OpiumData.config.mmbutton = true;
	   OpiumData.config.mmbuttonposition = 320;
	   OpiumData.config.guilddisplay = true;
	   OpiumData.config.trackpvpranks = true;
	   OpiumData.config.blockallsends = false;
	   OpiumData.config.dbVersion = 4;
	end

        if( opiumConfig and opiumConfig["dbVersion"] == 2 ) then
	   Opium_ConvertDB_2to3();
	   opiumConfig = nil;
	   kosPlayer = nil;
	   kosGuild = nil;
	   playerLinks = nil;
           OpiumData.config.dbVersion = 3;
	end

	if( OpiumData.config.dbVersion == 3 ) then
	   Opium_ConvertDB_3to4();
           OpiumData.config.dbVersion = 4;
	end


        if( OpiumData.config.trackpvpranks == nil ) then
	   OpiumData.config.trackpvpranks = true;
	end

        if( OpiumData.config.mmbutton == 1 ) then
	   OpiumData.config.mmbutton = true;
	elseif( OpiumData.config.mmbutton == 0 ) then
	   OpiumData.config.mmbutton = false;
	end

        if( OpiumData.config.blockallsends == nil ) then
	   OpiumData.config.blockallsends = false;
	end

        if( OpiumData.config.colorwho == nil ) then
	   OpiumData.config.colorwho = true;
	end

        if( OpiumData.config.alertsonlyonenemy == nil ) then
	   OpiumData.config.alertsonlyonenemy = false;
	end



        if( not OpiumData.kosPlayer[realmName] ) then
	   OpiumData.kosPlayer[realmName] = { };
        end

        if( not OpiumData.kosGuild[realmName] ) then
	   OpiumData.kosGuild[realmName] = { };
        end

	
        if( not OpiumData.playerLinks[realmName] ) then
	   OpiumData.playerLinks[realmName] = { };
        end

        if( not OpiumData.flags ) then
	   OpiumData.flags = { };
	   tinsert(OpiumData.flags, { name = OPIUM_TEXT_KOS_FLAG_KOS} );
	   tinsert(OpiumData.flags, { name = OPIUM_TEXT_KOS_FLAG_FRIEND} );
        end

        if( GetLocale() == "deDE" and not OpiumData.clearedAllianceNils) then
           for index, value in OpiumData.playerLinks[realmName] do
              if( not value[OPIUM_INDEX_FACTION] ) then
	         value[OPIUM_INDEX_FACTION] = 1;
              end
	   end
	   OpiumData.clearedAllianceNils = 1;
	end


        OpiumTempData = { };
        OpiumTempData.CombatPlayers = { };
        OpiumTempData.AllPlayers = { };
        OpiumTempData.BlockedSenders = { };

        if( kosData ) then
	   Opium_PrintMessage(OPIUM_TEXT_KOSLISTFOUND);
	end

        if( OpiumData.config.mmbutton ) then
	   OpiumButtonFrame:Show();
	else
           OpiumButtonFrame:Hide();
	end


        if(myAddOnsFrame) then
           myAddOnsList.Opium = {
              name = "Opium",
              description = OPIUM_TEXT_MYADDONSDESCRIPTION,
              version = OPIUM_VERSION,
              category = MYADDONS_CATEGORY_OTHERS,
              frame = "OpiumFrame",
	      optionsframe = "OpiumOptionsFrame"
           };
       end

        if( Sky ) then
	   Sky.registerMailbox( 
              {
                 id = "Opium";
                 events = { SKY_PLAYER };
                 acceptTest = OpiumAcceptanceTest;
              }
           );
	end

        UnitPopupButtons["OPIUM_KOS"] = { text = TEXT("KoS"), dist = 0 };
	tinsert(UnitPopupMenus["PLAYER"], "OPIUM_KOS");

	

                if (Sea) then
                  	Sea.util.hook("ChatFrame_OnEvent", "Opium_ChatFrame_OnEvent", "after");
                  	Sea.util.hook("UnitPopup_OnClick", "Opium_UnitPopup_OnClick", "replace");
                else


                   local  origChatFrame_OnEvent = ChatFrame_OnEvent;
                   ChatFrame_OnEvent = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10) 
				   Opium_ChatFrame_OnEvent(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10);
                                   origChatFrame_OnEvent(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10);
                     		 end

                   local origUnitPopup_OnClick = UnitPopup_OnClick;
                   UnitPopup_OnClick = function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10) 
				   if( Opium_UnitPopup_OnClick(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10) ) then
                                      origUnitPopup_OnClick(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10);
				   end
                     		 end

                end


        Opium_origGetWhoInfo = GetWhoInfo;
	GetWhoInfo = Opium_GetWhoInfo;
   
        if( not DisableAddonWelcomeMessages ) then
   	   Opium_PrintMessage(OPIUM_TITLE .. " " .. OPIUM_TEXT_WELCOMEMSG);
	end
end


function Opium_UnitPopup_OnClick()
   if( UnitPopupMenus[this.owner][this.value] == "OPIUM_KOS" ) then
      local target = UnitName("target");
      if( target ) then
         local targetlc = string.lower(target);
	 local entry = OpiumData.kosPlayer[realmName][targetlc];
         if( entry ) then
            OpiumAddKosEntry(target, entry[OPIUM_INDEX_REASON], entry[OPIUM_INDEX_FLAG]); 
	 else
            OpiumAddKosEntry(target);
	 end
	
      end
      return false;
   else
      return true;
   end
end


function Opium_GetWhoInfo(whoIndex)
	name, guild, level, race, class, zone, group = Opium_origGetWhoInfo(whoIndex)

        if( OpiumData.config.colorwho and (name and OpiumData.kosPlayer[realmName][string.lower(name)] or
           (guild and OpiumData.kosGuild[realmName][string.lower(guild)] )) ) then
	   name = "|cffff6666" .. name;
	end
	
	return name, guild, level, race, class, zone, group
end

function Opium_PrintMessage(msg)
   local chatframe;

   if( OpiumData ) then
      chatframe = getglobal("ChatFrame" .. OpiumData.config.chatframe);
   else
      chatframe = DEFAULT_CHAT_FRAME;
   end

   if(chatframe) then
      chatframe:AddMessage(msg, 1.0, 1.0, 0.0);
   else
      DEFAULT_CHAT_FRAME:AddMessage(msg, 1.0, 1.0, 0.0);
   end

end




function Opium_TimeToString(time)
   local ret = "";
   local units = 0;

   if( time < 0 ) then
      return "";
   end

   local days = floor( time / 86400 );

   if( days > 0 ) then
      time = time - days * 86400;
      ret = days .. "d ";
      units = units + 1;
   end

   local hours = floor( time / 3600 );
   if( hours > 0 ) then
      time = time - hours * 3600;
      ret = ret .. hours .. "h ";
      units = units + 1;
   end

   if( units == 2 ) then
      return ret;
   end

   local minutes = floor ( time / 60 );
   if( minutes > 0 ) then
      time = time - minutes * 60;
      ret = ret .. minutes .. "m ";
      units = units + 1;
   end

   if( units == 2 ) then
      return ret;
   end

   return ret .. time .. "s";
end


function Opium_StoreTarget(target, entry)
      local guildName, guildTitle, guildRank = GetGuildInfo(target);
      local lastUpdatedPlayer, faction;
      
       if( target == lastUpdatedPlayer ) then
         return
      end

      lastUpdatedPlayer = target;

      faction = UnitFactionGroup(target);

      local level = UnitLevel(target);
      if( level ~= -1 ) then
         entry[OPIUM_INDEX_LEVEL] = level;
      elseif( entry[OPIUM_INDEX_LEVEL] == nil ) then
         entry[OPIUM_INDEX_LEVEL] = level;
      end

      entry[OPIUM_INDEX_RACE] = OPIUM_RACEINDEX[UnitRace(target)];
      entry[OPIUM_INDEX_CLASS] = OPIUM_CLASSINDEX[UnitClass(target)];
      entry[OPIUM_INDEX_FACTION] = OPIUM_FACTIONINDEX[faction];
      entry[OPIUM_INDEX_GUILD] = guildName;
      entry[OPIUM_INDEX_GUILDTITLE] = guildTitle;
      entry[OPIUM_INDEX_LASTSEEN] = time() - OPIUM_TIMEOFFSET;

      if( OpiumData.config.trackpvpranks ) then
         entry[OPIUM_INDEX_PVPRANK] =   UnitPVPRank(target);
      end

      local bigname = UnitName(target);
      if( OpiumTempData.CombatPlayers[bigname] ) then
         if( OpiumTempData.CombatPlayers[bigname].w and not entry[OPIUM_INDEX_WINS]) then
	   entry[OPIUM_INDEX_WINS] = OpiumTempData.CombatPlayers[bigname].w;
	 end
         if( OpiumTempData.CombatPlayers[bigname].l and not entry[OPIUM_INDEX_LOSSES]) then
	   entry[OPIUM_INDEX_LOSSES] = OpiumTempData.CombatPlayers[bigname].l;
	 end
      end

end

function Opium_ProcessPermTarget(target)

   if( UnitExists(target) and UnitIsPlayer(target) ) 
   then
	   
      name = string.lower(UnitName(target));


      if( OpiumData.playerLinks[realmName] == nil ) then
         OpiumData.playerLinks[realmName] = { };
      end

      if( OpiumData.playerLinks[realmName][name] == nil ) then
         OpiumData.playerLinks[realmName][name] = { };
      end

      Opium_StoreTarget(target, OpiumData.playerLinks[realmName][name])

   end
end

function Opium_ProcessTempTarget(target)

   if( UnitExists(target) and UnitIsPlayer(target) ) 
   then
	   
      name = string.lower(UnitName(target));

      if( OpiumTempData.AllPlayers[name] == nil ) then
         OpiumTempData.AllPlayers[name] = { };
      end

      Opium_StoreTarget(target, OpiumTempData.AllPlayers[name])

   end
end


function Opium_PrintPlayer(name)
   local str;

	if( not OpiumData.playerLinks ) then
           Opium_PrintMessage("Unitialized OpiumData.playerLinks, shouldn't happen");
           return;
	 elseif( OpiumData.playerLinks[realmName] == nil ) then
            Opium_PrintMessage(OPIUM_TEXT_PLAYERNOTINDB);
	    return;
         elseif( OpiumData.playerLinks[realmName][name] == nil ) then
           Opium_PrintMessage(OPIUM_TEXT_PLAYERNOTINDB);
           return;
         end           

         local currentPlayer = OpiumData.playerLinks[realmName][name];

         if( currentPlayer[OPIUM_INDEX_PVPRANK] ) then
	    str = OPIUM_RANKTITLE[currentPlayer[OPIUM_INDEX_FACTION]][currentPlayer[OPIUM_INDEX_PVPRANK]] .. " ";
	 else
	    str = "";
	 end

         str = str .. opiumCapitalizeWords(name);

	 if( currentPlayer[OPIUM_INDEX_LEVEL] == -1 ) then
            str = str .. " " .. OPIUM_TEXT_THEUNKNOWNLEVEL;
	 else
            str = str .. " " .. OPIUM_TEXT_THELEVEL .. " " .. currentPlayer[OPIUM_INDEX_LEVEL];
         end

         if( currentPlayer[OPIUM_INDEX_RACE] and currentPlayer[OPIUM_INDEX_CLASS] ) then
            str = str .. " " .. OPIUM_RACEINDEX[currentPlayer[OPIUM_INDEX_RACE]] .. " " .. 
                              OPIUM_CLASSINDEX[currentPlayer[OPIUM_INDEX_CLASS]];
         end

         if( currentPlayer[OPIUM_INDEX_GUILD] ) then
	    if( currentPlayer[OPIUM_INDEX_GUILDTITLE] ~= nil ) then
               str = str .. ", " .. currentPlayer[OPIUM_INDEX_GUILDTITLE] .. " " .. OPIUM_TEXT_OF .. " ";
	    end
	    str = str .. currentPlayer[OPIUM_INDEX_GUILD];
         end
       
        reasonp = OpiumData.kosPlayer[realmName][name];

	if( currentPlayer[OPIUM_INDEX_GUILD] ) then 
           reasong = OpiumData.kosGuild[realmName][ string.gsub(string.lower(currentPlayer[OPIUM_INDEX_GUILD]), "%s", "_") ];
        end

        if( reasonp ) then
	   if( reasonp[OPIUM_INDEX_REASON] ) then
	      str = str .. ". " .. Opium_GetKoSFlag(reasonp[OPIUM_INDEX_FLAG])  .. " " ..
	            OPIUM_TEXT_PLAYER .. ": " .. reasonp[OPIUM_INDEX_REASON];
	   else
	      str = str .. ". " .. Opium_GetKoSFlag(reasonp[OPIUM_INDEX_FLAG]) .. " " .. 
	             OPIUM_TEXT_PLAYER;
	   end
	elseif( reasong ) then
	   if( reasong[OPIUM_INDEX_REASON] ) then
   	      str = str .. ". " .. Opium_GetKoSFlag(reasong[OPIUM_INDEX_FLAG]) .. " " ..
	      OPIUM_TEXT_GUILD .. ": " .. reasong[OPIUM_INDEX_REASON];
	   else
              str = str .. ". " .. Opium_GetKoSFlag(reasong[OPIUM_INDEX_FLAG]) .. " " ..
	      OPIUM_TEXT_GUILD;
	   end
	end

        if( OpiumData.config.trackpvpstats and (currentPlayer[OPIUM_INDEX_WINS] or currentPlayer[OPIUM_INDEX_LOSSES]) ) then
           str = str .. ". " .. OPIUM_TEXT_KILLSDEATHS .. ": " .. Opium_PvPStats(currentPlayer);
	end

        if( currentPlayer[OPIUM_INDEX_LASTSEEN] ~= nil ) then 	 
           lastseen = (time() - OPIUM_TIMEOFFSET) - currentPlayer[OPIUM_INDEX_LASTSEEN];
           str = str .. ". " .. OPIUM_TEXT_LASTSEEN .. ": " .. Opium_TimeToString(lastseen) .. " " .. OPIUM_TEXT_AGO .. ".";
	end

        Opium_PrintMessage(str);             
end


function Opium_TestTarget(target)
   if( UnitExists(target) and UnitIsPlayer(target) ) then
      faction = UnitFactionGroup(target);


      if( OpiumData.config.autostore == OPIUM_AUTOSTORE_ALL ) then

      elseif( OpiumData.config.autostore == OPIUM_AUTOSTORE_NONE ) then         
         return;
      elseif( OpiumData.config.autostore == OPIUM_AUTOSTORE_COMBAT ) then  
         if( faction ~= UnitFactionGroup("player") ) then
	    if( OpiumData.playerLinks[realmName] and OpiumData.playerLinks[realmName][name] ) then
	       Opium_ProcessPermTarget(target);
	    else
  	       Opium_ProcessTempTarget(target);
	    end
	 end
         return;
      elseif( OpiumData.config.autostore == OPIUM_AUTOSTORE_ALLIES ) then
         if( faction ~= UnitFactionGroup("player") ) then
            return;
         end
      elseif( OpiumData.config.autostore == OPIUM_AUTOSTORE_ENEMIES ) then
         if( faction == UnitFactionGroup("player") ) then
            return;
         end
      elseif( OpiumData.config.autostore == OPIUM_AUTOSTORE_ENEMIES ) then
         if( OpiumTempData.CombatPlayers[results[UnitName(target)]] == nil ) then
	    return;
	 end
      end

      Opium_ProcessPermTarget(target);
   end

end


function Opium_OnLoad()
   this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");
   this:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
   this:RegisterEvent("VARIABLES_LOADED");
   this:RegisterEvent("PLAYER_TARGET_CHANGED");
   this:RegisterEvent("PLAYER_DEAD");

 --  this:RegisterEvent("PARTY_MEMBER_ENABLE");

   tinsert(UISpecialFrames, "OpiumFrame");
   tinsert(UISpecialFrames, "OpiumOptionsFrame");
   tinsert(UISpecialFrames, "OpiumKosFrame");
   tinsert(UISpecialFrames, "OpiumStatsFrame");
end






function Opium_OnEvent()
         
   if ( event == "UPDATE_MOUSEOVER_UNIT" ) then
      Opium_TestTarget("mouseover");
      Opium_DrawTooltip();

   elseif( event == "PLAYER_TARGET_CHANGED" ) then
      Opium_TestTarget("target");
      OpiumAlerts("target");
      Opium_DrawTargetText();

   elseif( event == "VARIABLES_LOADED" ) then
      Opium_Initialize();

   elseif( event == "PLAYER_DEAD" ) then
      Opium_RegisterDeath();         

   elseif( event == "CHAT_MSG_COMBAT_HOSTILE_DEATH" ) then
      Opium_RegisterKill();

   elseif( event == "PARTY_MEMBER_ENABLE" ) then
     -- Opium_PrintMessage("Member enabled: " .. arg1);



   end
end
