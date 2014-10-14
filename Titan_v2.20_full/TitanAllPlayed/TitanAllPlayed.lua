--[[

Titan Panel [All Played]
Plug-in for Titan Panel that displays played time for all characters. 
You will need to log in to each character to get it added to the display


Author: Riboflavin on Bloodhoof
v1.3.1
- Level now reflected in tooltip on level up
- Added color option for rested %
- Calculated current players rested on tooltip (no longer have to click to update)
v1.3
- Added ignore feature (and actually used the upgrade method that I never called!)
- Added sorting!
- Lined up gold amount when hiding rested state for level 60.
- Added option to show more time than blizzard normally gives
v1.2
- Added a slew of menu options
v1.1.2 - 01/23/2006
- Changed rested calculation based on logging out in an inn.  Log characters to update status.
v1.1.1 1/21/2006
- Cannot be more than 100% rested
v1.1 1/20/2006
- Added "Restimate"
v1.0 1/18/2006
- Initial Release

Requires Titan Panel!  (As if the name didn't clue you in)
Includes support for myAddOns

]]--

--debug output
local function
  debug(message) DEFAULT_CHAT_FRAME:AddMessage(message, 0.1, 0.4, 0.8); 
end

--Initialize our variables
TitanAllPlayedCharacters = {};
TitanAllPlayedSettings = {};
grandTotal = 0;
netWorth = 0;

TAP_UNIQUE_ID = "AllPlayed";
TAP_VERSION_ID = "1.3.1";
TAP_FREQUENCY = 10;

TAP_MAX_CHARACTER_LEVEL = 60;
TAP_MINUTE_SECONDS = 60;
TAP_HOUR_SECONDS = 3600;
TAP_DAY_SECONDS = 86400;

TAP_ABOUT_TEXT = TitanUtils_GetGreenText(TAP_MENU_TEXT)  .. "\n" .. 
                 TitanUtils_GetNormalText(TAP_STRING_VERSION) .. TitanUtils_GetHighlightText(TAP_VERSION_ID) .. "\n" ..
		 TitanUtils_GetNormalText(TAP_STRING_AUTHOR) .. TitanUtils_GetHighlightText("Riboflavin - Bloodhoof");

--Table of my help messages to be displayed
--myAddOns can't handle scrollbars for long text so we need to 
--manually break up the messages
helpTable = 
{
  TAP_HELP_LINE_1,
  TAP_HELP_LINE_2,
  TAP_HELP_LINE_3,
  TAP_HELP_LINE_4,
  TAP_HELP_LINE_5,
  TAP_HELP_LINE_6,
  TAP_HELP_LINE_7
 };

--myAddons support
TitanAllPlayedDetails = 
{
  name = "TitanAllPlayed",
  version = TAP_VERSION_ID,
  releaseDate = "January 18, 2006",
  author = "Riboflavin - Bloodhoof",
  category = MYADDONS_CATEGORY_OTHERS,
  --optionsframe = "HelloWorldOptionsFrame"
};

TitanAllPlayedHelp = {};
TitanAllPlayedHelp[1] = table.concat(helpTable, "\n\n");

--OnLoad
function TitanAllPlayedButton_OnLoad()
  --Register for the events we care about
  this:RegisterEvent("TIME_PLAYED_MSG");
  this:RegisterEvent("ADDON_LOADED");
  --v1.3.1 two events we want to capure
  this:RegisterEvent("PLAYER_LEVEL_UP");
  this:RegisterEvent("PLAYER_XP_UPDATE");
  this:RegisterEvent("PLAYER_MONEY");

  --Register for Titan
  this.registry =
  {
    id = TAP_UNIQUE_ID,
    menuText = TAP_MENU_TEXT,
    buttonTextFunction = "TitanPanelAllPlayedButton_GetButtonText",
    tooltipTitle = TAP_TOOLTIP_TITLE,
    tooltipTextFunction = "TitanPanelAllPlayedButton_GetTooltipText",
    category = "Information",
    version = TAP_VERSION_ID,
    frequency = TAP_FREQUENCY,
    icon = "Interface\\Icons\\INV_Misc_PocketWatch_01.blp";
    iconWidth = 16,
    savedVariables = 
    {
      ShowIcon = 1,
      ShowLabelText = 1,
      ShowLevel = TITAN_NIL,
    }
  }

  --lets see if I can get this hook thing to work
  TitanAllPlayedLogout = Logout;
  Logout = function() RequestTimePlayed(); TitanAllPlayedLogout(); end
  -- quitting too
  TitanAllPlayedQuit = Quit;
  Quit = function() RequestTimePlayed(); TitanAllPlayedQuit(); end;

end

--the main event!
function TitanAllPlayedButton_OnEvent()
  local thisRealm = GetRealmName();
  local thisPlayer = UnitName("player");
  if (event == "TIME_PLAYED_MSG") then
    --Save (update) our entry for this player
    if (TitanAllPlayedCharacters[thisRealm] == nil) then
      TitanAllPlayedCharacters[thisRealm] = {thisPlayer};
    end

    --v1.1.2 - add is resting so we can tell how fast we are gaining rest state.
    if (TitanAllPlayedCharacters[thisRealm][thisPlayer] == nil) then
      TitanAllPlayedCharacters[thisRealm][thisPlayer] = {realm, name, level, secondsPlayed, coin, rested, maxRested, faction, lastUpdate, isResting, ignore};
    end
    
    --set the data
    TitanAllPlayedCharacters[thisRealm][thisPlayer].realm = thisRealm;
    TitanAllPlayedCharacters[thisRealm][thisPlayer].name = thisPlayer;
    TitanAllPlayedCharacters[thisRealm][thisPlayer].level = UnitLevel("player");
    TitanAllPlayedCharacters[thisRealm][thisPlayer].secondsPlayed = arg1;
    TitanAllPlayedCharacters[thisRealm][thisPlayer].coin = GetMoney();
    local restXP = GetXPExhaustion();
    if (restXP == nil) then
      restXP = 0;
    end
    TitanAllPlayedCharacters[thisRealm][thisPlayer].rested = restXP;
    TitanAllPlayedCharacters[thisRealm][thisPlayer].maxRested = UnitXPMax("player") * 1.5;
    TitanAllPlayedCharacters[thisRealm][thisPlayer].faction = UnitFactionGroup("player");
    TitanAllPlayedCharacters[thisRealm][thisPlayer].lastUpdate = time();
    TitanAllPlayedCharacters[thisRealm][thisPlayer].isResting = IsResting();
    --make sure the grandTotal is clear so we don't add everytime we call this
    getGrandTotals();
  end

  --Once our add on is loaded, get our user settings and our saved times
  if ((event == "ADDON_LOADED") and (arg1 == "TitanAllPlayed"))then
    --See if we have settings..
    if (TitanAllPlayedSettings["playerOptions"] == nil) then
      --Create our options table
      createOptionsTable();
    end

    --myAddOns Support
    if (myAddOnsFrame_Register) then
      myAddOnsFrame_Register(TitanAllPlayedDetails, TitanAllPlayedHelp);
    end

    --Might actually help to call this so people upgrading don't get errors (luckily most of my new additions default to false)
    upgradeVersion();
  end

  if (event == "PLAYER_LEVEL_UP" or event == "PLAYER_XP_UPDATE") then
    --if the player levels, then change their level, rested and max rested data. (why not isResting too)
    --I believe I can update the same data for xp update (level is redundant here, but harmless)
    TitanAllPlayedCharacters[thisRealm][thisPlayer].level = UnitLevel("player");
    local restXP = GetXPExhaustion();
    if (restXP == nil) then
      restXP = 0;
    end
    TitanAllPlayedCharacters[thisRealm][thisPlayer].rested = restXP;
    TitanAllPlayedCharacters[thisRealm][thisPlayer].maxRested = UnitXPMax("player") * 1.5;
    TitanAllPlayedCharacters[thisRealm][thisPlayer].isResting = IsResting();
  end

  --why not update the coin too
  if (event == "PLAYER_MONEY") then
    TitanAllPlayedCharacters[thisRealm][thisPlayer].coin = GetMoney();
  end
end

--
-- Titan functions
--
function TitanPanelAllPlayedButton_GetButtonText(id)
  --get a displayable version of our time
  local timeText = "";
  local currentCharacter = UnitName("player");
  local currentRealm = GetRealmName();

  --bug!  for some reason, I see the time being requested, but not caught, and therefore we never
  --update this character.  if it's a new character we don't have data for them yet..
  --fix that by returning from this method (I KNOW, multiple returns are bad) and requesting time.
  if (TitanAllPlayedCharacters[currentRealm] == nil or TitanAllPlayedCharacters[currentRealm][currentCharacter] == nil) then
    RequestTimePlayed();
    return;
  end
  local currentSeconds = TitanAllPlayedCharacters[currentRealm][currentCharacter].secondsPlayed;
  
  --If they turn everything off, then we get into a state where it's very hard to turn things back on.
  --Stop that from happening
  if ((not TitanGetVar(TAP_UNIQUE_ID, "ShowIcon")) and (not TitanGetVar(TAP_UNIQUE_ID, "ShowLabelText"))  ) then
    TitanAllPlayedSettings["playerOptions"].showLabelValue = true;
    --if we are in this state, close the menu so it is updated and painted properly.
    TitanPanelRightClickMenu_Close();
  end

  if (TitanAllPlayedSettings["playerOptions"].showLabelValue) then
    --v1.3 - show which time?
    if (TitanAllPlayedSettings["playerOptions"].timeBar) then
      timeText = TitanUtils_GetHighlightText(secondsToAllTime(grandTotal));
    else
      timeText = TitanUtils_GetHighlightText(SecondsToTime(grandTotal));
    end
  end

  --v1.2 we may not want to show the grand total.  check here
  --only show when we want to see the label 
  if (TitanAllPlayedSettings["playerOptions"].showCurrentOnlyLabel and TitanAllPlayedSettings["playerOptions"].showLabelValue) then
    --only show this character's time
    if (TitanAllPlayedSettings["playerOptions"].timeBar) then
      timeText = TitanUtils_GetHighlightText(secondsToAllTime(currentSeconds));
    else
      timeText = TitanUtils_GetHighlightText(SecondsToTime(currentSeconds));
    end
  end
  --v1.2 I think we can safely increment this players time since we do not run through the list, our grand total
  --should never interfere with our seconds played, so setting it will be ok.  We update this on login, logout and left click
  --(i hope :)
  TitanAllPlayedCharacters[currentRealm][currentCharacter].secondsPlayed = currentSeconds + TAP_FREQUENCY;

  --in order to NOT call /played (and see the display) over and over, I will
  --increment the grandtotal by our frequency, so our next update will 
  --reflect the time that has passed.
  grandTotal = grandTotal + TAP_FREQUENCY;
  return TAP_BUTTON_LABEL, timeText;
end

function TitanPanelAllPlayedButton_GetTooltipText()

  --Here I need to loop through my players and list out what we know.
  local tooltipData = "";

  --Do some crazy ass sorting thing to actually sort. 
  sortedServers = sortByName(TitanAllPlayedCharacters);
  for k, v in ipairs (sortedServers) do
    tooltipData = tooltipData .. displayServerCharacters(v, TitanAllPlayedCharacters[v]);
  end 
  --add our totals in a purty color
  if (TitanAllPlayedSettings["playerOptions"].timeGrand) then
    tooltipData = tooltipData .. "\n" .. TitanUtils_GetColoredText(TAP_LIFE_WASTED .. "\t" .. secondsToAllTime(grandTotal), {r=1.0, g=0.4, b=0.0});
  else
    tooltipData = tooltipData .. "\n" .. TitanUtils_GetColoredText(TAP_LIFE_WASTED .. "\t" .. SecondsToTime(grandTotal), {r=1.0, g=0.4, b=0.0});
  end
  
    if (TitanAllPlayedSettings["playerOptions"].showGold) then
      tooltipData = tooltipData .. "\n" .. TitanUtils_GetColoredText(TAP_FAKE_WORTH .. "\t".. getMoneyFormat(netWorth), {r=1.0, g=0.4, b=0.0});
    end
  return tooltipData;
end

--
-- create menus
--
function TitanPanelRightClickMenu_PrepareAllPlayedMenu()

  local info = {};
  
  if (UIDROPDOWNMENU_MENU_LEVEL == 3) then
    if (UIDROPDOWNMENU_MENU_VALUE == "TimeOptions") then
      --give this menu a heading
      info = {};
      info.text = TAP_MENU_TIME_TITLE;
      info.isTitle = 1;
      info.notClickable = 1;
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

      --4 place we show time in this mod
      info = {};
      info.text = TAP_MENU_TIME_TITAN_BAR;
      info.value = "TimeOnTitanBarToggle";
      info.func = timeOnTitanBarToggle;
      info.checked = (TitanAllPlayedSettings["playerOptions"].timeBar);
      info.keepShownOnClick = 1;
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

      info = {};
      info.text = TAP_MENU_TIME_SERVER;
      info.value = "TimeServerToggle";
      info.func = timeServerToggle;
      info.checked = (TitanAllPlayedSettings["playerOptions"].timeServer);
      info.keepShownOnClick = 1;
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

      info = {};
      info.text = TAP_MENU_TIME_CHARACTER;
      info.value = "TimeCharacterToggle";
      info.func = timeCharacterToggle;
      info.checked = (TitanAllPlayedSettings["playerOptions"].timeChar);
      info.keepShownOnClick = 1;
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

      info = {};
      info.text = TAP_MENU_TIME_GRAND_TOTAL;
      info.value = "TimeGrandTotalToggle";
      info.func = timeGrandTotalToggle;
      info.checked = (TitanAllPlayedSettings["playerOptions"].timeGrand);
      info.keepShownOnClick = 1;
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

      info = {};
      info.text = TAP_MENU_TIME_LINK;
      info.value = "TimeLinkToggle";
      info.func = timeLinkToggle;
      info.checked = (TitanAllPlayedSettings["playerOptions"].timeLink);
      info.keepShownOnClick = 1;
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

    elseif (UIDROPDOWNMENU_MENU_VALUE == "SortOptions") then
      --add our toggles for sorting.

      --toggle rested sort
      info = {};
      info.text = TAP_MENU_SORT_RESTED_OPTION;
      info.value = "SortRestedToggle";
      info.func = sortRestedToggle;
      info.checked = (TitanAllPlayedSettings["playerOptions"].listSort == TAP_ARG_RESTEDSORT);
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

      --toggle gold sort
      info = {};
      info.text = TAP_MENU_SORT_GOLD_OPTION;
      info.value = "SortGoldToggle";
      info.func = sortGoldToggle;
      info.checked = (TitanAllPlayedSettings["playerOptions"].listSort == TAP_ARG_GOLDSORT);
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

      --toggle time sort
      info = {};
      info.text = TAP_MENU_SORT_TIME_OPTION;
      info.value = "SortTimeToggle";
      info.func = sortTimeToggle;
      info.checked = (TitanAllPlayedSettings["playerOptions"].listSort == TAP_ARG_TIMESORT);
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

      --toggle level sort
      info = {};
      info.text = TAP_MENU_SORT_LEVEL_OPTION;
      info.value = "SortLevelToggle";
      info.func = sortLevelToggle;
      info.checked = (TitanAllPlayedSettings["playerOptions"].listSort == TAP_ARG_LEVELSORT);
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

    elseif (UIDROPDOWNMENU_MENU_VALUE == "ListOptions") then
      
      --toggle all servers
      info = {};
      info.text = TAP_MENU_ALLSERVERS_OPTION;
      info.value = "ShowAllServersToggle";
      info.func = showAllServersToggle;
      info.checked = (TitanAllPlayedSettings["playerOptions"].listScope == TAP_ARG_ALLSERVERS);
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

      --toggle current server display
      info = {};
      info.text = TAP_MENU_CURRENTSERVER_OPTION;
      info.value = "ShowCurrentServerToggle";
      info.func = showCurrentServerToggle;
      info.checked = (TitanAllPlayedSettings["playerOptions"].listScope == TAP_ARG_CURRENTSERVER);
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
      
      --toggle per server stats display
      info = {};
      info.text = TAP_MENU_SERVERTOTAL_OPTION;
      info.value = "ShowServerTotalsToggle";
      info.func = showServerTotalsToggle;
      info.checked = TitanAllPlayedSettings["playerOptions"].showServerTotals;
      info.keepShownOnClick = 1;
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

      --toggle per server gold total display
      info = {};
      info.text = TAP_MENU_SERVERTOTAL_GOLD_OPTION;
      info.value = "ShowServerGoldTotalsToggle";
      info.func = showServerGoldTotalsToggle;
      info.checked = TitanAllPlayedSettings["playerOptions"].showServerGoldTotals;
      info.keepShownOnClick = 1;
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

    elseif (UIDROPDOWNMENU_MENU_VALUE == "RestedOptions") then
      --toggle rested display
      info = {};
      info.text = TAP_MENU_RESTED_OPTION;
      info.value = "ShowRestedToggle";
      info.func = showRestedToggle;
      info.checked = TitanAllPlayedSettings["playerOptions"].showRested;
      info.keepShownOnClick = 1;
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

      --toggle fully rested display
      info = {};
      info.text = TAP_MENU_FULLYRESTED_OPTION;
      info.value = "ShowFullyRestedToggle";
      info.func = showFullyRestedToggle;
      info.checked = TitanAllPlayedSettings["playerOptions"].showFullyRested;
      info.keepShownOnClick = 1;
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

      --toggle fully rested for level 60 display
      info = {};
      info.text = TAP_MENU_SIXTYRESTED_OPTION;
      info.value = "Show60RestedToggle";
      info.func = show60RestedToggle;
      info.checked = TitanAllPlayedSettings["playerOptions"].hideIfSixty;
      info.keepShownOnClick = 1;
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

      --toggle color coding for rested state
      info = {};
      info.text = TAP_MENU_RESTEDCOLOR_OPTION;
      info.value = "ColorRestedToggle";
      info.func = colorRestedToggle;
      info.checked = TitanAllPlayedSettings["playerOptions"].colorRested;
      info.keepShownOnClick = 1;
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
    end
    return;
  end
  
  if (UIDROPDOWNMENU_MENU_LEVEL == 2) then
    if ( UIDROPDOWNMENU_MENU_VALUE == "DisplayAbout" ) then
      info = {};
      info.text = TAP_ABOUT_TEXT;
      info.value = "AboutTextPopUP";
      info.notClickable = 1;
      info.isTitle = 0;
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
    
    elseif ( UIDROPDOWNMENU_MENU_VALUE == "DisplayOptions" ) then
      --toggle level display
      info = {};
      info.text = TAP_MENU_LEVEL_OPTION;
      info.value = "ShowLevelToggle";
      info.func = showLevelToggle;
      info.checked = TitanAllPlayedSettings["playerOptions"].showLevel;
      info.keepShownOnClick = 1;
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

      --toggle gold display
      info = {};
      info.text = TAP_MENU_GOLD_OPTION;
      info.value = "ShowGoldToggle";
      info.func = showGoldToggle;
      info.checked = TitanAllPlayedSettings["playerOptions"].showGold;
      info.keepShownOnClick = 1;
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

      --include this character in our calculations?
      local thisRealm = GetRealmName();
      local thisPlayer = UnitName("player");
      info = {};
      info.text = TAP_MENU_IGNORE_OPTION;
      info.value = "ignoreCharacter";
      info.func = ignoreCharacterToggle;
      info.checked = TitanAllPlayedCharacters[thisRealm][thisPlayer].ignore;
      info.keepShownOnClick = 1;
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

      info = {};
      info.text = TAP_MENU_ONLYME_OPTION;
      info.value = "ShowThisCharToggle";
      info.func = showThisCharToggle;
      info.checked = TitanAllPlayedSettings["playerOptions"].showCurrentOnlyLabel;
      info.keepShownOnClick = 1;
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
      
      --Create a rested options menu
      info = {};
      info.text = TAP_MENU_RESTED_OPTIONS;
      info.value = "RestedOptions";
      info.hasArrow = 1;
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);   
      
      --Create a list scope options menu
      info = {};
      info.text = TAP_MENU_LISTSCOPE_OPTIONS;
      info.value = "ListOptions";
      info.hasArrow = 1;
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
      
      --Create a list sort options menu
      info = {};
      info.text = TAP_MENU_LISTSORT_OPTIONS;
      info.value = "SortOptions";
      info.hasArrow = 1;
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

      --Create a list sort options menu
      info = {};
      info.text = TAP_MENU_TIME_OPTIONS;
      info.value = "TimeOptions";
      info.hasArrow = 1;
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
      
      --reset button (shouldn't be necessary once I stop changing the saved vars)
      info = {};
      info.text = TAP_MENU_RESET_OPTION;
      info.value = "resetData";
      info.func = resetData;
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
      
    end
    return;
  end

  TitanPanelRightClickMenu_AddTitle(TitanPlugins[TAP_UNIQUE_ID].menuText);
  
  TitanPanelRightClickMenu_AddToggleIcon(TAP_UNIQUE_ID);
  TitanPanelRightClickMenu_AddToggleLabelText(TAP_UNIQUE_ID);
  --add the option to remove the data (presumably to just show the icon)
  info = {};
  info.text = TAP_MENU_VALUE_OPTION;
  info.value = "ShowLabelValueToggle";
  info.func = showLabelValueToggle;
  info.checked = TitanAllPlayedSettings["playerOptions"].showLabelValue;
  info.keepShownOnClick = 1;
  UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
  TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TAP_UNIQUE_ID, TITAN_PANEL_MENU_FUNC_HIDE);

  --Create an options menu
  info = {};
  info.text = TAP_MENU_OPTIONS;
  info.value = "DisplayOptions";
  info.hasArrow = 1;
  UIDropDownMenu_AddButton(info);

  -- info about plugin
  info = {};
  info.text = TAP_MENU_ABOUT_TEXT;
  info.value = "DisplayAbout";
  info.hasArrow = 1;
  UIDropDownMenu_AddButton(info);
end

function showGoldToggle()
  TitanAllPlayedSettings["playerOptions"].showGold = not TitanAllPlayedSettings["playerOptions"].showGold;

  TitanPanelButton_UpdateButton(TAP_UNIQUE_ID);
end

function showLevelToggle()
  TitanAllPlayedSettings["playerOptions"].showLevel = not TitanAllPlayedSettings["playerOptions"].showLevel;

  TitanPanelButton_UpdateButton(TAP_UNIQUE_ID);
end

function showRestedToggle()
  TitanAllPlayedSettings["playerOptions"].showRested = not TitanAllPlayedSettings["playerOptions"].showRested;

  TitanPanelButton_UpdateButton(TAP_UNIQUE_ID);
end

function showFullyRestedToggle()
  TitanAllPlayedSettings["playerOptions"].showFullyRested = not TitanAllPlayedSettings["playerOptions"].showFullyRested;

  TitanPanelButton_UpdateButton(TAP_UNIQUE_ID);
end

function show60RestedToggle()
  TitanAllPlayedSettings["playerOptions"].hideIfSixty = not TitanAllPlayedSettings["playerOptions"].hideIfSixty;

  TitanPanelButton_UpdateButton(TAP_UNIQUE_ID);
end

function showAllServersToggle()
  if (TitanAllPlayedSettings["playerOptions"].listScope == TAP_ARG_ALLSERVERS) then
    --if we turn off an option, we will automatically set the value to be current char
    TitanAllPlayedSettings["playerOptions"].listScope = TAP_ARG_CURRENTPLAYER;
  else
    --set it to be all servers
    TitanAllPlayedSettings["playerOptions"].listScope = TAP_ARG_ALLSERVERS
  end
end

function showCurrentServerToggle()
  if (TitanAllPlayedSettings["playerOptions"].listScope == TAP_ARG_CURRENTSERVER) then
    --if we turn off an option, we will automatically set the value to be current char
    TitanAllPlayedSettings["playerOptions"].listScope = TAP_ARG_CURRENTPLAYER;
  else
    TitanAllPlayedSettings["playerOptions"].listScope = TAP_ARG_CURRENTSERVER
  end
end

function showServerTotalsToggle()
  TitanAllPlayedSettings["playerOptions"].showServerTotals = not TitanAllPlayedSettings["playerOptions"].showServerTotals;

  TitanPanelButton_UpdateButton(TAP_UNIQUE_ID);
end

function showServerGoldTotalsToggle()
  TitanAllPlayedSettings["playerOptions"].showServerGoldTotals = not TitanAllPlayedSettings["playerOptions"].showServerGoldTotals;
  TitanPanelButton_UpdateButton(TAP_UNIQUE_ID);
end

function showLabelValueToggle()
  if (TitanAllPlayedSettings["playerOptions"].showLabelValue) then
   TitanAllPlayedSettings["playerOptions"].showLabelValue = false;
  else
   TitanAllPlayedSettings["playerOptions"].showLabelValue = true;
  end

  TitanPanelButton_UpdateButton(TAP_UNIQUE_ID);
end;

--runs through our player list and adds up our data
function calculateTotals(tableIndex, tableData)
  --our index here is our servers, loop through the characters for each server
  foreach(tableData, calculateServerTotal);  
end

--loops though all characters on a single server
function calculateServerTotal(tableIndex, tableData)
  --someone tell me why the ! I have a 1... I don't understand
  if (tableIndex ~= 1 and not tableData.ignore) then
    grandTotal = grandTotal + tableData.secondsPlayed;
    netWorth = netWorth + tableData.coin;
  end
end

function resetData()
  TitanAllPlayedCharacters = {};
  TitanAllPlayedSettings = {};
  createOptionsTable();
  --if they do a reset, repopulate with current char
  RequestTimePlayed();
end

function createOptionsTable()
  TitanAllPlayedSettings["playerOptions"] = {showGold, listScope, showRested, showFullyRested, showLevel, hideIfSixty, showServerTotals, 
                                             showLabelValue, showServerGoldTotals, showCurrentOnlyLabel, listSort, timeBar, timeServer,
					     timeChar, timeGrand, timeLink, colorRested};
  --Give it some default options
  TitanAllPlayedSettings["playerOptions"].showGold = true;
  TitanAllPlayedSettings["playerOptions"].listScope = TAP_ARG_ALLSERVERS;
  TitanAllPlayedSettings["playerOptions"].showRested = true;
  TitanAllPlayedSettings["playerOptions"].showFullyRested = true;
  TitanAllPlayedSettings["playerOptions"].showLevel = true;
  TitanAllPlayedSettings["playerOptions"].hideIfSixty = false;
  TitanAllPlayedSettings["playerOptions"].showServerTotals = true;
  TitanAllPlayedSettings["playerOptions"].showLabelValue = true;
  TitanAllPlayedSettings["playerOptions"].showServerGoldTotals = false;
  TitanAllPlayedSettings["playerOptions"].showCurrentOnlyLabel = false;
  TitanAllPlayedSettings["playerOptions"].listSort = TAP_ARG_CHARACTER;
  TitanAllPlayedSettings["playerOptions"].timeBar = false;
  TitanAllPlayedSettings["playerOptions"].timeServer = false;
  TitanAllPlayedSettings["playerOptions"].timeChar = false;
  TitanAllPlayedSettings["playerOptions"].timeGrand = false;
  TitanAllPlayedSettings["playerOptions"].timeLink = false;
  TitanAllPlayedSettings["playerOptions"].colorRested = false;
end

function displayServerCharacters(index, characters)
  local tooltip = "";
  local indicies;
  
  --How does the user want to sort?
  if (TitanAllPlayedSettings["playerOptions"].listSort == TAP_ARG_RESTEDSORT) then
    indicies = sortByRestedPercent(characters);
  elseif (TitanAllPlayedSettings["playerOptions"].listSort == TAP_ARG_GOLDSORT) then
    indicies = sortByGold(characters);
  elseif (TitanAllPlayedSettings["playerOptions"].listSort == TAP_ARG_TIMESORT) then
    indicies = sortByTime(characters);
  elseif (TitanAllPlayedSettings["playerOptions"].listSort == TAP_ARG_LEVELSORT) then
    indicies = sortByLevel(characters);
  else
    indicies = sortByName(characters);
  end

  --display "headings" in a different color
  if (TitanAllPlayedSettings["playerOptions"].listScope == TAP_ARG_ALLSERVERS) then
    tooltip = tooltip .. "\n" .. TitanUtils_GetNormalText(index .. " " .. TAP_STRING_CHARACTERS);
    local servertip = "";
    --do we want to see server totals
    if (TitanAllPlayedSettings["playerOptions"].showServerTotals or TitanAllPlayedSettings["playerOptions"].showServerGoldTotals) then
      local serverTotals = 0;
      local serverGold = 0;
      --calculate the value
      for k, v in ipairs (indicies) do
        playerTime, playerGold = getPlayerDataForServer(v, characters[v])
        serverTotals = serverTotals + playerTime;
        serverGold = serverGold + playerGold;
      end -- for
      
      --we know one or more of these options is turned on, start the tooltip
      servertip = " [";
      
      --do we show time?
      if (TitanAllPlayedSettings["playerOptions"].showServerTotals) then
        if (TitanAllPlayedSettings["playerOptions"].timeServer) then
          servertip = servertip .. secondsToAllTime(serverTotals);
	else
	  servertip = servertip .. SecondsToTime(serverTotals);
	end
	--do we also need to put in the separator?
	if (TitanAllPlayedSettings["playerOptions"].showServerGoldTotals) then
	  servertip = servertip .. " : ";
	end 
      end

      --do we show gold?
      if (TitanAllPlayedSettings["playerOptions"].showServerGoldTotals) then
        servertip = servertip  .. getMoneyFormat(serverGold);
      end

      --we started a tooltip, end it
      servertip = servertip  .. "]";
    end
    
    tooltip = tooltip .. TitanUtils_GetGreenText(servertip) .. TitanUtils_GetNormalText(":") .."\n";
  end
  
  --I still need to loop through everything to get my grand totals
  --beats the hell out of me what this does, but it seems to work.  I mean really, what's wrong with
  --normal for loops.  
  for k, v in ipairs (indicies) do
    tooltip = tooltip .. displayAllPlayed(v, characters[v]);  
  end -- for

  return tooltip;
end

function displayAllPlayed(index, data)
  local tooltip = "";
  --someone tell me why the ! I have a 1... I don't understand
  if (index ~= 1 and not data.ignore) then
    --build the output for this character
    --Here is the format (showing everything)
    --Player (level) Time Played with Gold : Rested 
    local output = data.name;

    --v1.2 attempt at some sort of formatting (output was original tooltip)
    local frontput = data.name;
    local backput = "";  

    --if we want to see level, show that here
    if (TitanAllPlayedSettings["playerOptions"].showLevel) then
      frontput = frontput .. " (" .. data.level .. ")";
    end

    if (TitanAllPlayedSettings["playerOptions"].timeChar) then
      frontput = frontput .. ": " .. secondsToAllTime(data.secondsPlayed);
    else
      frontput = frontput .. ": " .. SecondsToTime(data.secondsPlayed);
    end
    if (data.rested == nil) then
      data.rested = 0;
    end

    --if we want these options, show them
    if (TitanAllPlayedSettings["playerOptions"].showGold) then
      backput = backput .. getMoneyFormat(data.coin);
    end

    --Here is where we update our data with a "restimate".  If we are off a little
    --it won't matter, each character will be updated with real values when they log in
    local newRested = Restimate(data);

    if (TitanAllPlayedSettings["playerOptions"].showRested) then
      --if we are showing rested, we need to check to see if we want 60s and fully rested displays
      if (TitanAllPlayedSettings["playerOptions"].hideIfSixty == true or 
         (TitanAllPlayedSettings["playerOptions"].hideIfSixty == false and data.level ~= 60)) then
        backput = backput .. " : " .. newRested .. " " .. TAP_STRING_RESTEDXP;
      end
    end

    --do we have to add fully rested estimate?
    if (TitanAllPlayedSettings["playerOptions"].showFullyRested) then
      --if we are showing rested, we need to check to see if we want 60s and fully rested displays
      if (TitanAllPlayedSettings["playerOptions"].hideIfSixty == true or 
         (TitanAllPlayedSettings["playerOptions"].hideIfSixty == false and data.level ~= 60)) then
	local percentRested = floor(newRested / data.maxRested * 100);

	--This should have been taken care of in the Restimate method, yet somehow I saw my rested % more than 100
	--I'll fix it for good here!
	if (percentRested > 100) then
	  percentRested = 100;
	end

        --fake formatting 
	if (percentRested < 10) then
	  percentRested = "    " .. percentRested;
	elseif (percentRested < 100) then
	  percentRested = "  " .. percentRested;
	end

        --use rested color.  I think i can get away with adding color here, I'm not sure. 
	if (TitanAllPlayedSettings["playerOptions"].colorRested) then
	  backput = backput .. TitanUtils_GetColoredText(" (" .. percentRested .. "% " .. TAP_STRING_RESTED ..")", getRestedColor(percentRested));
	else
          backput = backput .. " (" .. percentRested .. "% " .. TAP_STRING_RESTED ..")";
	end
      else
        --format with a space for sixtys who don't show rested.
	backput = backput .. "                      ";
      end
    end

    local factionColor = {r=0.0, g=0.5, b=1.0};
    if (data.faction == "Horde") then
      factionColor = {r=1.0, g=0.0, b=0.0};
    end
    --check our list options
    if (printOutput(data)) then
      --Indent player
      tooltip = "  " .. TitanUtils_GetColoredText(frontput, factionColor) .. "\t" .. TitanUtils_GetColoredText(backput, factionColor)  .."\n";
    end;
  end
  return tooltip;
end

function printOutput(data)
  --don't print anything unless we determine we should
  local retValue = false;
  if (TitanAllPlayedSettings["playerOptions"].listScope == TAP_ARG_CURRENTPLAYER and
      data.name == UnitName("player") and data.realm == GetRealmName()) then
    retValue = true;
  elseif (TitanAllPlayedSettings["playerOptions"].listScope == TAP_ARG_CURRENTSERVER and
          data.realm == GetRealmName()) then
    retValue = true;
  elseif (TitanAllPlayedSettings["playerOptions"].listScope == TAP_ARG_ALLSERVERS) then
    retValue = true;
  end
  return retValue;
end

function sortByName(characters)
  --this is a table of characters, I copied this sort from a MUD website because 
  --I could not figure out a better way:
  t2 = {}
  
  table.foreach (characters, function (k) if (k ~= 1) then table.insert (t2, k) end end )

  table.sort (t2)
  return t2;
end

function getMoneyFormat(totalInCopper)
  local retValue = TAP_STRING_NO_MONEY;
  --only do this if we actually have money
  if (totalInCopper > 0) then
    --get the copper
    local copper = math.mod(totalInCopper, 100);

    totalInCopper = (totalInCopper - copper) / 100;

    --get the silver
    local silver = math.mod(totalInCopper, 100);

    totalInCopper = (totalInCopper - silver) / 100;

    --get the gold
    local gold = totalInCopper;
    
    --v1.2 attempt at a nicer format
    if (copper < 10) then
      copper = "  " .. copper;
    end

    if (silver < 10) then
      silver = "  " .. silver;
    end

    --now we can format a nice string
    retValue = gold .. TAP_INITIAL_GOLD .. " " .. silver .. TAP_INITIAL_SILVER .. " " .. copper .. TAP_INITIAL_COPPER;
  end
  return retValue;
end

--function for our per server stats.
function getPlayerDataForServer(tableIndex, tableData)
  --two returns here
  local retSeconds = 0;
  local retCoin = 0;
  --someone tell me why the ! I have a 1... I don't understand
  if (tableIndex ~= 1 and not tableData.ignore) then
    --return this player so we can get a separate server calculation
    retSeconds = tableData.secondsPlayed;
    retCoin = tableData.coin;
  end

  return retSeconds, retCoin;
end

--if we click the button, call /played.  this will refresh our rested and coin displays
function TitalAllPlayedButton_OnClick(arg1)
  if (arg1 == "LeftButton") then
    if (IsShiftKeyDown()) then
      if (ChatFrameEditBox:IsVisible()) then
        if (TitanAllPlayedSettings["playerOptions"].timeLink) then
          message = TAP_BUTTON_LABEL .. " " .. TitanUtils_ToString(secondsToAllTime(grandTotal));
	else
	  message = TAP_BUTTON_LABEL .. " " .. TitanUtils_ToString(SecondsToTime(grandTotal));
	end
	ChatFrameEditBox:Insert(message);
      end
    else
      RequestTimePlayed();
    end
  end
end

--Try to estimate rested % based on last login (Version 2 feature)
function Restimate(charData)
  local newRested = charData.rested;
  --only update for offline chars
  if (charData.name ~= UnitName("player")) then
    local currentTime = time();
    local tenDays = 864000 -- 30 days in seconds (time to get to 100%)
  
    --"restimate" the rested xp!  start with the time difference
    local timeDelta = currentTime - charData.lastUpdate;
    --we are very very accurate
    local xpPerSecond;

    --v1.1.2 if we are resting, then do the normal calculation.  if we are not (logged in the world)
    --then we gain rest at 1/4 the speed or 40 days to full instead of 10
    if (charData.isResting) then
      xpPerSecond = charData.maxRested / tenDays;
    else
      xpPerSecond = charData.maxRested / (tenDays * 4);
    end
    --what would the rested be if we were logged in now?
    newRested = floor(charData.rested + (timeDelta * xpPerSecond));

    --Bug fix - can't be more than 100% rested!
    if (newRested > charData.maxRested) then
      newRested = charData.maxRested;
    end
  end
  --I chose to do the calculation each time, as opposed to changing my data
  --because I was worried that I could potentially Floor the data to the same
  --rested value, and update the time.  This would leave me in a state where
  --I thought I was up to date, but my data would not change.  Probably not a 
  --big chance this would happen, but I'd rather work with known data.
  return newRested;
end

--Might be a better way to do this, but as I add features and items to the saved variables, I want
--to make sure we have valid data for all versions.  Starting this for v1.2
function upgradeVersion()
  --added a way to show/hide the data values, need to make sure we default to true
  if (TitanAllPlayedSettings["playerOptions"].showLabelValue == nil) then
    TitanAllPlayedSettings["playerOptions"].showLabelValue = true;
  end

  --Server gold totals, we default to false so the check will be ok, but lets be consistant
  if (TitanAllPlayedSettings["playerOptions"].showServerGoldTotals == nil) then
    TitanAllPlayedSettings["playerOptions"].showServerGoldTotals = false;
  end

  --another easy false default.
  if (TitanAllPlayedSettings["playerOptions"].showCurrentOnlyLabel == nil) then
    TitanAllPlayedSettings["playerOptions"].showCurrentOnlyLabel = false;
  end

  --v1.3 added sorting!
  if (TitanAllPlayedSettings["playerOptions"].listSort == nil) then
    TitanAllPlayedSettings["playerOptions"].listSort = TAP_ARG_CHARACTER;
  end

  --more time!  only check one
  if (TitanAllPlayedSettings["playerOptions"].timeBar == nil) then
    TitanAllPlayedSettings["playerOptions"].timeBar = false;
    TitanAllPlayedSettings["playerOptions"].timeServer = false;
    TitanAllPlayedSettings["playerOptions"].timeChar = false;
    TitanAllPlayedSettings["playerOptions"].timeGrand = false;
  end

  --v1.3.1 color rested state
  if (TitanAllPlayedSettings["playerOptions"].colorRested == nil) then
    TitanAllPlayedSettings["playerOptions"].colorRested = true;
  end
end

--v1.2 request to show only current character time in the titan bar
--I wouldn't use it personally but whatever, it's a user option
function showThisCharToggle()
  TitanAllPlayedSettings["playerOptions"].showCurrentOnlyLabel = not TitanAllPlayedSettings["playerOptions"].showCurrentOnlyLabel;

  TitanPanelButton_UpdateButton(TAP_UNIQUE_ID);
end

function ignoreCharacterToggle()
  local thisRealm = GetRealmName();
  local thisPlayer = UnitName("player");

  TitanAllPlayedCharacters[thisRealm][thisPlayer].ignore = not TitanAllPlayedCharacters[thisRealm][thisPlayer].ignore;

  --we have changed our calculations, make sure we update our button
  getGrandTotals();

  TitanPanelButton_UpdateButton(TAP_UNIQUE_ID);
end

--gets our grand totals 
function getGrandTotals()
  grandTotal = 0;
  netWorth = 0;

  --calculate our totals
  foreach(TitanAllPlayedCharacters, calculateTotals);
end

function sortByRestedPercent(characters)
  local nameTable = {};
  local percentTable = {};
  table.foreach(characters, function(k)
                              if (k ~= 1 and not characters[k].ignore) then
			        --get the rested percent number
				local newRested = Restimate(characters[k]);
				local kPercent = floor(newRested / characters[k].maxRested * 100);
                                local charLevel = characters[k].level;
				--where should this entry go?
				local tableIndex, kPercent = getIndexForRested(percentTable, kPercent, charLevel);
				--insert data into our two tables.
				table.insert(nameTable, tableIndex, k);
				table.insert(percentTable, tableIndex, kPercent);
		              end
			    end);
  return nameTable;
end

function sortByGold(characters)
  local nameTable = {};
  local goldTable = {};
  table.foreach(characters, function(k)
                              if (k ~= 1) then
			        --get the gold number
				local goldAmount = characters[k].coin;
				--where should this entry go?
				local tableIndex = getIndex(goldTable, goldAmount);
				--insert data into our two tables.
				table.insert(nameTable, tableIndex, k);
				table.insert(goldTable, tableIndex, goldAmount);
		              end
			    end);
  return nameTable;
end

function sortByTime(characters)
  local nameTable = {};
  local timeTable = {};
  table.foreach(characters, function(k)
                              if (k ~= 1) then
			        --get the time number
				local timeAmount = characters[k].secondsPlayed;
				--where should this entry go?
				local tableIndex = getIndex(timeTable, timeAmount);
				--insert data into our two tables.
				table.insert(nameTable, tableIndex, k);
				table.insert(timeTable, tableIndex, timeAmount);
		              end
			    end);
  return nameTable;
end

function sortByLevel(characters)
  local nameTable = {};
  local levelTable = {};
  table.foreach(characters, function(k)
                              if (k ~= 1) then
			        --get the level number
				local charLevel = characters[k].level;
				--where should this entry go?
				local tableIndex = getIndex(levelTable, charLevel);
				--insert data into our two tables.
				table.insert(nameTable, tableIndex, k);
				table.insert(levelTable, tableIndex, charLevel);
		              end
			    end);
  return nameTable;
end

function getIndex(pTable, pValue)
  --loop through the table and find out where this needs to go.
  local retIndex = 1;
  for k, v in pairs (pTable) do
    --we are in the table, loop until we find a bigger value
    if (pValue <= v) then
      retIndex = retIndex + 1;
    end
  end

  return retIndex
end

function getIndexForRested(pTable, pValue, charLevel)
  --if we are hiding rested for level 60, then don't group them
  --with the others, put them at the bottom.  what we'll do is detect
  --this case and trick it into thinking the rested value is -1 
  --this should put the character at the bottom
  
  --first, are we hiding 60s?
  if (not TitanAllPlayedSettings["playerOptions"].hideIfSixty) then
    --we are hiding level 60s... but is this player a 60?
    if (charLevel == TAP_MAX_CHARACTER_LEVEL) then
      --yes they are, value is now -1 so they go below 0
      pValue = -1;
    end
  end
  
  --loop through the table and find out where this needs to go.
  local retIndex = 1;
  for k, v in pairs (pTable) do
    --we are in the table, loop until we find a bigger value
    if (pValue <= v) then
      retIndex = retIndex + 1;
    end
  end

  return retIndex, pValue;
end

--guess we do need special indexing methods, er functions, based on how we sort.
--this method puts hidden 60s rested at the bottom.

--these will work like the list scoping options.  if you turn one off, we'll set it to be alphabetical
function sortRestedToggle()
  if (TitanAllPlayedSettings["playerOptions"].listSort == TAP_ARG_RESTEDSORT) then
    --if we turn off an option, we will automatically set the value to be current char
    TitanAllPlayedSettings["playerOptions"].listSort = TAP_ARG_ALPHASORT;
  else
    --set it to be all servers
    TitanAllPlayedSettings["playerOptions"].listSort = TAP_ARG_RESTEDSORT;
  end
end

function sortGoldToggle()
  if (TitanAllPlayedSettings["playerOptions"].listSort == TAP_ARG_GOLDSORT) then
    --if we turn off an option, we will automatically set the value to be current char
    TitanAllPlayedSettings["playerOptions"].listSort = TAP_ARG_ALPHASORT;
  else
    --set it to be all servers
    TitanAllPlayedSettings["playerOptions"].listSort = TAP_ARG_GOLDSORT;
  end
end

function sortTimeToggle()
  if (TitanAllPlayedSettings["playerOptions"].listSort == TAP_ARG_TIMESORT) then
    --if we turn off an option, we will automatically set the value to be current char
    TitanAllPlayedSettings["playerOptions"].listSort = TAP_ARG_ALPHASORT;
  else
    --set it to be all servers
    TitanAllPlayedSettings["playerOptions"].listSort = TAP_ARG_TIMESORT;
  end
end

function sortLevelToggle()
  if (TitanAllPlayedSettings["playerOptions"].listSort == TAP_ARG_LEVELSORT) then
    --if we turn off an option, we will automatically set the value to be current char
    TitanAllPlayedSettings["playerOptions"].listSort = TAP_ARG_ALPHASORT;
  else
    --set it to be all servers
    TitanAllPlayedSettings["playerOptions"].listSort = TAP_ARG_LEVELSORT;
  end
end

function secondsToAllTime(secondsPlayed)
  local days, hours, minutes, seconds;
  local remainder = secondsPlayed;
  local timeFormatString = "";
  
  --do we have days?
  if (secondsPlayed > TAP_DAY_SECONDS) then
    --yes we do
    days = floor(secondsPlayed / TAP_DAY_SECONDS);
    --remove days from our calculations
    remainder = math.mod(secondsPlayed, TAP_DAY_SECONDS);
    --we have some days, add these to the tooltip
    if (days == 1) then
      timeFormatString = timeFormatString .. days .. " " .. TAP_STRING_DAY .. " ";
    else
      timeFormatString = timeFormatString .. days .. " " .. TAP_STRING_DAYS .. " ";
    end
  end

  --do we have hours?
  if (remainder > TAP_HOUR_SECONDS) then
    --yes we do
    hours = floor(remainder / TAP_HOUR_SECONDS);
    --remove hours from our calculation
    remainder = math.mod(remainder, TAP_HOUR_SECONDS);
    --add to our tooltip
    if (hours == 1) then
      timeFormatString = timeFormatString .. hours .. " " .. TAP_STRING_HOUR_ABB .. " ";
    else
      timeFormatString = timeFormatString .. hours .. " " .. TAP_STRING_HOURS_ABB .. " ";
    end
  else
    timeFormatString = timeFormatString .. "0 " .. TAP_STRING_HOURS_ABB .. " ";
  end

  --do we have minutes?
  if (remainder > TAP_MINUTE_SECONDS) then
    --yes we do
    minutes = floor(remainder / TAP_MINUTE_SECONDS);
    --add to our tooltip
    if (minutes == 1) then
      timeFormatString = timeFormatString .. minutes .. " " .. TAP_STRING_MINUTE_ABB .. " ";
    else
      timeFormatString = timeFormatString .. minutes .. " " .. TAP_STRING_MINUTES_ABB .. " ";
    end
  else
    timeFormatString = timeFormatString .. "0 " .. TAP_STRING_MINUTES_ABB .. " ";
  end

  --finally, the seconds
  seconds = math.mod(remainder, TAP_MINUTE_SECONDS);
  
  if (seconds == 1) then
    timeFormatString = timeFormatString .. seconds .. " " .. TAP_STRING_SECOND_ABB;
  else
    timeFormatString = timeFormatString .. seconds .. " " .. TAP_STRING_SECONDS_ABB;
  end

  return timeFormatString;
end

function timeOnTitanBarToggle()
  TitanAllPlayedSettings["playerOptions"].timeBar = not TitanAllPlayedSettings["playerOptions"].timeBar;
  TitanPanelButton_UpdateButton(TAP_UNIQUE_ID);
end

function timeServerToggle()
  TitanAllPlayedSettings["playerOptions"].timeServer = not TitanAllPlayedSettings["playerOptions"].timeServer;
  TitanPanelButton_UpdateButton(TAP_UNIQUE_ID);
end

function timeCharacterToggle()
  TitanAllPlayedSettings["playerOptions"].timeChar = not TitanAllPlayedSettings["playerOptions"].timeChar;
  TitanPanelButton_UpdateButton(TAP_UNIQUE_ID);
end

function timeGrandTotalToggle()
  TitanAllPlayedSettings["playerOptions"].timeGrand = not TitanAllPlayedSettings["playerOptions"].timeGrand;
  TitanPanelButton_UpdateButton(TAP_UNIQUE_ID);
end

function timeLinkToggle()
  TitanAllPlayedSettings["playerOptions"].timeLink = not TitanAllPlayedSettings["playerOptions"].timeLink;
  TitanPanelButton_UpdateButton(TAP_UNIQUE_ID);
end

function colorRestedToggle()
  TitanAllPlayedSettings["playerOptions"].colorRested = not TitanAllPlayedSettings["playerOptions"].colorRested;
  TitanPanelButton_UpdateButton(TAP_UNIQUE_ID);
end

function getRestedColor(restedPercent)
  restedColor = {r=1.0, g=1.0, b=0.0};  --50%

  --I'm too lazy to look and see if there is a switch statement in lua
  --round % to lower 10
  local thisRested = floor(restedPercent / 10) * 10  --turns 58 to 50

  --my tester says we don't need a gradient as fine as each 10%, 
  
  if (thisRested == 0) then
    restedColor.r = 1;
    restedColor.g = 0;
  elseif (thisRested <= 10) then
    restedColor.r = 1;
    restedColor.g = .2;
  elseif (thisRested <= 30) then
    restedColor.r = 1;
    restedColor.g = .5;
  elseif (thisRested <= 50) then
    restedColor.r = 1;
    restedColor.g = 1;
  elseif (thisRested <= 70) then
    restedColor.r = .8;
    restedColor.g = 1;
  elseif (thisRested <= 99) then
    restedColor.r = .5;
    restedColor.g = 1;
  elseif (thisRested == 100) then
    restedColor.r = 0;
    restedColor.g = 1;
  else
    --something went wrong
    restedColor.r = 1;
    restedColor.g = 0;
  end

  return restedColor;
end