--[[

  LAX (Lunatari's Average XP Addon)
  Author: Lunatari on Al'Akir lunatari@cryptr.net
  Home: http://www.cryptr.net/wow.php

  Information:

  LAX is basically a shell around jINx's AvgXP version 0.421b.
  What LAX does is to add features to AvgXP that wasnt there before.
  LAX is aimed to support most of the function people want and well needed.
  I try to change as little as possible to the actual AvgXP code.

  Cosmetical changes:

  Different border UI.

  Features added:

  Graphical Total XP bar (AvgXP Plus style)
  Graphical Rested XP bar (how much rested left).
  Added Time to Level ontop on the Kills to Level, this is only shown in the tooltip.
  Rested XP counted when we show how many kills needed until level.
  Hide functions for both XP bars, show the one you like.
  Colour modes to both XP bars, red, green and so on.
  Font size options 8, 9 or 10.
  Bar width options between 400 to 1000 units.
  Brief mode support, shows less text (380 width).
  Docking support, docks LAX just above the MainMenuBar and locks it.
  Always ontop mode so that docking would be possible, else its under MainMenuBar.
  No Text at all option that only shows the bars and the infotext on mouseover.
  Tooltip relocation options, 5 different modes.
  No Tooltip support, option to turn Tooltip off.
  3 ways of showing experience to level.
   - 20 Bars mode, AvgXP Plus like mode and the default AvgXP mode.
   - 20 bars is how many bars out of 20 do i have left.
   - AvgXP Plus is how much percent xp left to level.
   - AvgXP normal is how much percent xp have i gained on this level.
  Dragging Lock as requested (/lax lock/unlock)
  Hidding mode (/lax hide/show)
  German support greatly improved.
  French support greatly improved.
  Disable Save mode, wont save the history and such to the SavedVariables.lua.
  Independent character savings, [realm][charactername].variable.

  Credits to:

  jINx for the initial work on AvgXP.
  Snakexc for UIMem, Great code to look at.
  Melavius for the German translation help.
  RaSk for the French translation help.
  The people at curse-gamin.com for all the info and suggestions.
  FuNkY MoOsE and Soulrender for the help with the 1.7 bug that was introduced.
  FuNkY MoOsE should have extra credits.
  The Creators of Titan Panel, I used 2 of their functions for formatting the time.
  Thanks to Blizzard for WoW.

]]

------------------------------------------------------
-- AvgXP Vars 
------------------------------------------------------
local jx_avgexp_version = 0.421;
local jx_avgexp_init
local jx_last_xp_gained 
local jx_avg_xp_per_mob 
local jx_num_mobs_left
local jx_rested_num_mobs_left
local jx_avgexp_stats 
local jx_target_stats
local jx_total_xp_gained
local jx_total_mobs_killed
local jx_kill_history = { }
local jx_kill_history_dep = { }
local jx_exp_history = { }
local jx_debug_threshold = 2;

------------------------------------------------------
-- Colors
------------------------------------------------------
local GRN="|cff20ff20";
local YEL="|cffffff40";
local RED="|cffff2020";
local WHT="|cffffffff";
local MAG="|cffff00ff";

------------------------------------------------------
-- LAX Added vars.
------------------------------------------------------
local LAX_Version = "0.9.4.1";
local LAX_Author = MAG.."Lunatari"..WHT.." (lunatari@cryptr.net)";
local LAX_BarNormalWidth = 560;
local LAX_BarBriefWidth = 385;
local LAX_BarDockedWidth = 1024;
local LAX_XPBarWidth = 12;
local LAX_OptionsLoaded = false;
local LAX_CheckVersion = 889;
local LAX_DEBUG = false;

------------------------------------------------------
-- LAX smaller Vars, none special, none interactive
------------------------------------------------------
local lax_sessionTime = 0;
local lax_levelTime = 0;
local lax_sessionExperience = 0;
local lax_sessionKills = 0;

------------------------------------------------------
-- Realm and Player Vars.
------------------------------------------------------
local rName;
local pName;

------------------------------------------------------
-- LAX Help/Splash
------------------------------------------------------
LAX_SPLASH = YEL.."LAX "..WHT.."("..MAG.."AvgXP"..WHT..")";
LAX_HELLO1 = LAX_SPLASH.." by Lunatari Version: "..GRN..LAX_Version;
LAX_HELLO2 = LAX_SPLASH.." Syntax: /lax ["..MAG.."command"..WHT.."] (eg. /lax "..MAG.."help"..WHT..")";
LAX_Help = {
  LAX_SPLASH..GRN.." Help:",
  YEL.."-"..WHT.."  /lax help "..GRN.."general"..WHT.." For gerneral help.",
  YEL.."-"..WHT.."  /lax help "..GRN.."avgxp"..WHT.." For help about AvgXP functions.",
  YEL.."-"..WHT.."  /lax help "..GRN.."visual"..WHT.." For help about LAX visual functions.",
};

-- LAX General commands.
-- Locking functions, status, version and such.
LAX_HelpGeneral = {
  LAX_SPLASH..GRN.." General functions:",
  YEL.."-"..WHT.."  /lax "..GRN.."defaults"..WHT.." Sets all special LAX options to defaults.",
  YEL.."-"..WHT.."  /lax "..GRN.."hide"..WHT.." or "..GRN.."show"..WHT.." To either hide or show.",
  YEL.."-"..WHT.."  /lax "..GRN.."lock"..WHT.." or "..GRN.."unlock"..WHT.." This will lock or unlock LAX.",
  YEL.."-"..WHT.."  /lax "..GRN.."version"..WHT.." Reports the current version.",
  YEL.."-"..WHT.."  /lax "..GRN.."status"..WHT.." Shows the current settings of all LAX options.",
};

-- LAX Visual commands.
-- The commands to change LAX look.
LAX_HelpVisual = {
  LAX_SPLASH..GRN.." Visual functions:",
  YEL.."-"..WHT.."  /lax "..GRN.."brief"..WHT.." [on or off] Toggles brief mode. (normal width "..LAX_BarNormalWidth..", brief "..LAX_BarBriefWidth..")",
  YEL.."-"..WHT.."  /lax "..GRN.."colour"..WHT.." To see more help on rested/xp colours.",
  YEL.."-"..WHT.."  /lax "..GRN.."infotext"..WHT.." [show, hide or hover] To show or hide the infotext, or show it on hover.",
  YEL.."-"..WHT.."  /lax "..GRN.."font"..WHT.." [8, 9 or 10] To set the font size of LAX.",
  YEL.."-"..WHT.."  /lax "..GRN.."hide"..WHT.." or "..GRN.."show"..WHT.." [restedxp or mainxp] To hide or show the mainxpbar or restedxpbar.",
  YEL.."-"..WHT.."  /lax "..GRN.."tooltip"..WHT.." [top, bottom, above, right, left or off] To set the position of Tooltip or turn it off.",
  YEL.."-"..WHT.."  /lax "..GRN.."width"..WHT.." [400 to 1200 or default] To set the width of LAX.",
  YEL.."-"..WHT.."  /lax "..GRN.."xptext"..WHT.." [normal,togo or bars] To change how LAX shows your progress.",

};

-- AvgXP help
-- Old standard avgxp functions.
LAX_HelpAvgXP = {
  LAX_SPLASH..GRN.." Experience functions:",
  YEL.."-"..WHT.."  /lax "..GRN.."debug"..WHT.." [enable or disable] "..MAG.."Turns AvgXP debugging on or off.",
  YEL.."-"..WHT.."  /lax "..GRN.."level"..WHT.." "..MAG.."Reports average xp per level.",
  YEL.."-"..WHT.."  /lax "..GRN.."party"..WHT.." or "..GRN.."guild"..WHT.." "..MAG.."Broadcasts stats to selected chat.",
  YEL.."-"..WHT.."  /lax "..GRN.."reset"..WHT.." [now, onload or disable] "..MAG.."To reset your history, disable nullifies onload.",
  YEL.."-"..WHT.."  /lax "..GRN.."save"..WHT.." [enable or disable] "..MAG.."Enabled or disable history savings.",
};

-- (Yes some of this is ridiculous but I was sick of having duplicated code)
------------------------------------------------------
local jx_best_average
local jx_best_average_str
local jx_rested_bonus
local jx_avg_xp_per_mob_str
local jx_kills_str
local jx_exp_togo
local jx_exp_pc
local msg
local pid
local is_loaded = false;
local is_saved = false;
local jx_oldversion = false;

-- Constants
------------------------------------------------------
local jx_commlang

------------------------------------------------------
-- Localization Constants
-- Load of German, English and French translation support.
------------------------------------------------------
local jx_alliedraces = { "Dwarf", "Gnome", "Human", "Night Elf" };

if ( GetLocale() == "deDE" ) then
  local jx_alliedraces = { "Zwerg", "Gnom", "Mensch", "Nachtelf" };
elseif ( GetLocale() == "frFR" ) then
  local jx_alliedraces = { "Nain", "Gnome", "Humain", "Elfe de la nuit" };
end

LAX_CommonLanguage = "COMMON";
LAX_OrcishLanguage = "ORCISH";

if ( GetLocale() == "deDE" ) then
  LAX_CommonLanguage = "GEMEINSPRACHE";
  LAX_OrcishLanguage = "ORKISCH";
elseif ( GetLocale() == "frFR" ) then
  LAX_CommonLanguage = "Commun";
  LAX_OrcishLanguage = "Orc";
end

EXP_GAIN_TEXT = "(.+) dies, you gain (%d+) experience.";

if ( GetLocale() == "deDE" ) then
  EXP_GAIN_TEXT = "(.+) stirbt, Ihr bekommt (%d+) Erfahrung.";
elseif ( GetLocale() == "frFR" ) then
  EXP_GAIN_TEXT = "(.+) meurt, vous gagnez (%d+) points d'expérience.";
end

RESTED_GAIN_TEXT = "(%d+) exp Rested bonus";

if ( GetLocale() == "deDE" ) then
  RESTED_GAIN_TEXT = "(%d+) Erf. Erholt Bonus";
elseif ( GetLocale() == "frFR" ) then
  RESTED_GAIN_TEXT = "(%d+) exp Bonus de repos";
end

------------------------------------------------------
-- Common functions
------------------------------------------------------
-- Print function, this basically just prints what we want to the chatframe.
-- Think i borrowed this from Teo too, its simple though.
local function Print(msg) 
  if not DEFAULT_CHAT_FRAME then return end
	
  DEFAULT_CHAT_FRAME:AddMessage(msg)	
end

------------------------------------------------------
-- LAX Defaults
-- Initialize default LAX Options aka Reset.
------------------------------------------------------
function LAX_InitDefaultOptions(mode)

  -- Init check.
  -- Mode just has to be set to init, realm or character.
  if ( mode ~= "init" and mode ~= "realm" and mode ~= "character" ) then
    return;
  end

  -- Set the defaults.
  -- Lets only "initialize" if no datafound or new release.
  if ( mode == "init" ) then
    LAX_Options = {};
    LAX_Options.Locked = false;
    LAX_Options.Version = LAX_CheckVersion;
  end

  -- Realm settings.
  if ( mode == "realm" or mode == "init" ) then
    LAX_Options[rName] = {};
  end

  -- Character settings.
  if ( mode == "character" or mode == "init" or mode == "realm" ) then
    LAX_Options[rName][pName] = {};
  end

  -- Well we always have to do this dont we.
  -- Basic character settings and so.
  LAX_Options[rName][pName].FontSize = "10";
  LAX_Options[rName][pName].InfoText = "on";
  LAX_Options[rName][pName].InfoTextMode = "normal";
  LAX_Options[rName][pName].BarWidth = LAX_BarNormalWidth;
  LAX_Options[rName][pName].Colour = "default";
  LAX_Options[rName][pName].RestedColour = "green";
  LAX_Options[rName][pName].ShowMain = "show";
  LAX_Options[rName][pName].ShowRested = "show";
  LAX_Options[rName][pName].Hidden = "show";
  LAX_Options[rName][pName].BriefMode = "off";
  LAX_Options[rName][pName].TooltipAnchor = "right";
  LAX_Options[rName][pName].SaveMode = "enable";
  LAX_Options[rName][pName].AutoReset = "disable";
end

------------------------------------------------------
-- LAX_DumpStatus
------------------------------------------------------
function LAX_DumpStatus()

  Print(LAX_SPLASH.." Current Settings:");
  Print(RED.."-  "..WHT.."Realm: "..rName);
  Print(RED.."-  "..WHT.."Character: "..pName);
  Print(RED.."-  "..WHT.."Settings Version: "..LAX_Options.Version);
  Print(RED.."-  "..WHT.."Hidden: "..LAX_Options[rName][pName].Hidden);
  Print(RED.."-  "..WHT.."Width: "..LAX_Options[rName][pName].BarWidth);
  Print(RED.."-  "..WHT.."InfoText: "..LAX_Options[rName][pName].InfoText);
  Print(RED.."-  "..WHT.."InfoText Mode: "..LAX_Options[rName][pName].InfoTextMode);
  Print(RED.."-  "..WHT.."Font Size: "..LAX_Options[rName][pName].FontSize);
  Print(RED.."-  "..WHT.."Brief Mode: "..LAX_Options[rName][pName].BriefMode);
  Print(RED.."-  "..WHT.."Tooltip Anchor: "..LAX_Options[rName][pName].TooltipAnchor);
  Print(RED.."-  "..WHT.."Save History: "..LAX_Options[rName][pName].SaveMode);
  Print(RED.."-  "..WHT.."Auto Reset: "..LAX_Options[rName][pName].AutoReset);
  Print(RED.."-  "..WHT.."XP Bar: "..LAX_Options[rName][pName].ShowMain);
  Print(RED.."-  "..WHT.."Rested XP Bar "..LAX_Options[rName][pName].ShowRested);
  Print(RED.."-  "..WHT.."XP Bar Colour: "..LAX_Options[rName][pName].Colour);
  Print(RED.."-  "..WHT.."Rested XP Bar Colour: "..LAX_Options[rName][pName].RestedColour);
end

------------------------------------------------------
-- jINx display function.
-- I like Print better.
------------------------------------------------------
local function display(output)
	local anyoutput = false;

	for msg in string.gfind(output,"(.+)\n") do
		DEFAULT_CHAT_FRAME:AddMessage(msg);
	end
end

------------------------------------------------------
-- To fill the XPBar with blue.
-- Creds to Tolin for this.
------------------------------------------------------
function LAX_XPBar_Update()

  local CXP = UnitXP("player");
  local NXP = UnitXPMax("player");
  local RXP = GetXPExhaustion();

  LAX_XPBar:SetMinMaxValues(min(0, CXP), NXP);
  LAX_XPBar:SetValue(CXP);

  if ( GetXPExhaustion() ~= nil ) then
    local xpBonus = CXP + RXP;
    LAX_XPBarRested:SetMinMaxValues(min(0, xpBonus), NXP);
    LAX_XPBarRested:SetValue(xpBonus);
  else
    LAX_XPBarRested:SetMinMaxValues(min(0, CXP), NXP);
    LAX_XPBarRested:SetValue(CXP);
   end
end

-- OnUpdate function to basically increase timer.
function LAX_OnUpdate(elapsed)
  	
  -- Update play time
	if (lax_sessionTime) then
		lax_sessionTime = lax_sessionTime + elapsed;
		lax_levelTime = lax_levelTime + elapsed;
	end

end

------------------------------------------------------
-- Used to set the briefmode.
------------------------------------------------------
function LAX_SetBarWidth()

 -- Damn DisableSave :)-
 -- We have to check this though since the feature is in the AddOn.
 if ( LAX_Options[rName][pName].BriefMode == "on" ) then
   LAXFrame:SetWidth(LAX_BarBriefWidth);
   LAX_XPBar:SetWidth(LAX_BarBriefWidth-LAX_XPBarWidth);
   LAX_XPBarRested:SetWidth(LAX_BarBriefWidth-LAX_XPBarWidth);
 elseif ( LAX_Options[rName][pName].BarWidth ) then
   LAXFrame:SetWidth(LAX_Options[rName][pName].BarWidth);
   LAX_XPBar:SetWidth(LAX_Options[rName][pName].BarWidth-LAX_XPBarWidth);
   LAX_XPBarRested:SetWidth(LAX_Options[rName][pName].BarWidth-LAX_XPBarWidth);
 else
   LAXFrame:SetWidth(LAX_BarNormalWidth);
   LAX_XPBar:SetWidth(LAX_BarNormalWidth-LAX_XPBarWidth);
   LAX_XPBarRested:SetWidth(LAX_BarNormalWidth-LAX_XPBarWidth);
 end
end

------------------------------------------------------
-- Color Settings
-- Default is Blue and only valid for Main XPBar.
------------------------------------------------------
function LAX_SetColour(bar, colour)

  if ( bar == LAX_XPBar ) then
    if ( colour == "default" ) then
    bar:SetStatusBarColor(0.0, 0.5, 1.0 );
    end
  end

  if ( colour == "green" ) then
    bar:SetStatusBarColor(0.0, 1.0 ,0.0 );

  elseif ( colour == "magenta" ) then
    bar:SetStatusBarColor(1.0, 0.0 ,1.0 );

  elseif ( colour == "orange" ) then
    bar:SetStatusBarColor(1.0, 0.5 ,0.0 );

  elseif ( colour == "cyan" ) then
    bar:SetStatusBarColor(0.0, 1.0 ,1.0 );

  elseif ( colour == "yellow" ) then
    bar:SetStatusBarColor(1.0, 1.0 ,0.0 );

  elseif ( colour == "red" ) then
      bar:SetStatusBarColor(1.0, 0.0 ,0.0 );    

  end
 
end

-- Enter function, will be ran on mouseover.
function LAX_OnEnter()
  if ( LAX_Options[rName][pName].TooltipAnchor ~= "off" ) then
  	JX_AvgXP_SetTooltip();
  end

  if ( LAX_Options[rName][pName].InfoText == "hover" ) then
   	AvgXPText:Show();
  end
end

-- Leave function, will be ran on mouseoverleave.
function LAX_OnLeave()
  if ( LAX_Options[rName][pName].TooltipAnchor ~= "off" ) then
  	GameTooltip:Hide();
  end

	if ( LAX_Options[rName][pName].InfoText == "hover" ) then
   	AvgXPText:Hide();
  end
end

------------------------------------------------------
-- Dragging function.
------------------------------------------------------
function LAX_OnDragStart()

  -- Should we allow moving? perhaps not.
  -- We also check for DisableSave here.
  if ( not LAX_Options.Locked ) then
    LAXFrame:StartMoving()
  else
    Print(LAX_SPLASH..' is locked /lax unlock to move it.');
  end
end

-- Prevent moving of LAX
function LAX_OnDragStop()

  LAXFrame:StopMovingOrSizing()
end

-- Toggle hide/show of LAX
function LAX_ToggleVisable(cmd)

  -- Well hide/show it.
  if ( cmd == "show" ) then
    Print(LAX_SPLASH..' is now shown.');
    LAX_Options[rName][pName].Hidden = "show";
    LAXFrame:Show();
  elseif ( cmd == "hide" ) then
    Print(LAX_SPLASH..' is now hidden.');
    LAX_Options[rName][pName].Hidden = "hide";
    LAXFrame:Hide();
  end
end

------------------------------------------------------
-- Toggle the visability of the two xp bars.
------------------------------------------------------
function LAX_ToggleVisableXPBar(cmd, params)

  -- Well hide/show it.
  if ( cmd == "show" ) then
    if ( params == "restedxp" ) then
       Print(LAX_SPLASH..' Rested XPBar is now shown.');
       LAX_XPBarRested:Show();
       LAX_Options[rName][pName].ShowRested = "show";
    elseif ( params == "mainxp" ) then
       Print(LAX_SPLASH..' Main XPBar is now shown.');
       LAX_XPBar:Show();
       LAX_Options[rName][pName].ShowMain = "show";
    end
  elseif ( cmd == "hide" ) then
    if ( params == "restedxp" ) then
       Print(LAX_SPLASH..' Rested XPBar is now hidden.');
       LAX_XPBarRested:Hide();
       LAX_Options[rName][pName].ShowRested = "hide";
    elseif ( params == "mainxp" ) then
       Print(LAX_SPLASH..' Main XPBar is now hidden.');
       LAX_XPBar:Hide();
       LAX_Options[rName][pName].ShowMain = "hide";
    end
  end
end

------------------------------------------------------
-- Loads the LAX Specific Options
-- LAX_Options....
------------------------------------------------------
function LAX_LoadOptions() 

  -- Get our RealmName and PlayerName
  -- These has to be set to something.
  rName = GetCVar("realmName");
  pName = UnitName("player");       

  -- Check so names and realm is really there.
  -- We also check if we passed this once already.
  if ( LAX_OptionsLoaded or ( not is_loaded ) or ( not rName ) or ( not pName )  or ( pName == UNKNOWNOBJECT ) ) then
    return;
  end

  -- We wont be able to come back after this
  LAX_OptionsLoaded = true;

  -- Show for whom we loaded the settings.
  Print(LAX_SPLASH.." loaded settings for "..pName.." on "..rName);

  -- LAX Extra OPTIONS
  -- I have to check this, else there will be loads of errors
  -- when we try to play the game.
  if ( not LAX_Options ) then
    Print(LAX_SPLASH.." no previous LAX data found, setting defaults!");
    LAX_InitDefaultOptions("init");
  end

  -- Well if we changed version of LAX we might need to upgrade some 
  -- saved variables, this we do here.
  if ( ( not LAX_Options.Version ) or ( LAX_Options.Version < LAX_CheckVersion ) ) then
    Print(LAX_SPLASH.." new version of LAX loaded, updating settings!");
    LAX_InitDefaultOptions("init");
  end

  -- Ok new realm, lets set it up.
  -- Oohhh might be a new character! lets set it up.
  if ( not LAX_Options[rName] ) then
    Print(LAX_SPLASH.." no LAX data found for realm "..rName..", setting defaults!");
    LAX_InitDefaultOptions("realm");
  elseif ( not LAX_Options[rName][pName] ) then
    Print(LAX_SPLASH.." no LAX data found for character "..pName..", setting defaults!");
    LAX_InitDefaultOptions("character");
  end

  -- Init part, here we created or checked all needed things so now
  -- we can actually move on to the LAX init part and load it up set 
  -- all the saved options we had and so on.

  -- Show or Hide rested/mainbars ?
  if ( LAX_Options[rName][pName].ShowMain == "hide" ) then
    LAX_ToggleVisableXPBar("hide", "mainxp");
  end

  if ( LAX_Options[rName][pName].ShowRested == "hide" ) then
    LAX_ToggleVisableXPBar("hide", "restedxp");
  end

  -- Set Colour of XP Bar
  LAX_SetColour(LAX_XPBar, LAX_Options[rName][pName].Colour);
  LAX_SetColour(LAX_XPBarRested, LAX_Options[rName][pName].RestedColour);

  -- Set width and font size of LAX
  AvgXPText:SetTextHeight(LAX_Options[rName][pName].FontSize);
  LAX_SetBarWidth();

  -- Ok! lets check if we have AutoReset enabled!
  -- If this is the case we will cleanse the SavedVariables.lua from all 
  -- the now used character specific data.
  if ( LAX_Options[rName][pName].AutoReset == "enable" ) then
    JX_AvgXP_Reset();
  end

  -- Well perhaps we are 60 and want to hide LAX well if /lax hide was used
  -- then LAX wont be shown the next time you logon either, until you do /lax show
  if ( LAX_Options[rName][pName].Hidden == "hide" ) then
    LAX_ToggleVisable("hide");
  end

  -- Do we want to show the infotext or not?
  -- Someone wanted it to be hidden so well I added the function to do it.
  if ( LAX_Options[rName][pName].InfoText == "hide" or LAX_Options[rName][pName].InfoText == "hover") then
   	AvgXPText:Hide();
  end

end

------------------------------------------------------
-- AvgXP Functions Following now, very little has changed from 0.421b
-- Development
------------------------------------------------------
local function debug(level,msg)
  if LAX_DEBUG then
    if (level >= jx_debug_threshold) then
      msg = LAX_SPLASH.." Debug: "..msg;
      display(msg);
    end
  end
end

------------------------------------------------------
-- History Functions
------------------------------------------------------
local function JX_AvgXP_Depricate_History()
  for i,v in pairs(jx_kill_history) do
    jx_kill_history_dep[ i ] = { };
    jx_kill_history_dep[ i ] = v;
  end

  jx_kill_history = { };
end

local function JX_AvgXP_AddKill(mobile_name,xp)
	local exp = 0
	local kills = 0
	local target = mobile_name;
	
	if (not jx_kill_history[ target ] ) then
		debug(2,string.format("Created kill record for %s\n",mobile_name));
		jx_kill_history[ target ] = { };
		jx_kill_history[ target ] = { level = UnitLevel("player"), total_xp = 0, total_kills = 0 };
	end

	if (xp > 0) then
		exp = jx_kill_history[ target ].total_xp;
		kills = jx_kill_history[ target ].total_kills;
		jx_kill_history[ target ].total_xp = exp + xp;
		jx_kill_history[ target ].total_kills = kills + 1;
		jx_kill_history[ target ].level = UnitLevel("player");
		avg = (jx_kill_history[ target ].total_xp / jx_kill_history[ target ].total_kills);		
	
		-- If we have a new best average, update it
		if ( (avg > jx_best_average) and (kills > 1) ) then
			jx_best_average = avg;
			jx_best_average_str = target;
		end

		debug(2,string.format("Adding kill for %s for %d exp, total exp now %d and kills %d :: Current average %.1f\n",mobile_name, xp, jx_kill_history[ target ].total_xp , jx_kill_history[ target ].total_kills, avg));
	else
		debug(2,string.format("No exp awarded for kill for %s\n",mobile_name));
	end
end

local function JX_AvgXP_Kill_Reset()
	jx_kill_history = { };
	output(YEL.."Average Exp Kill History has been reset.\n");
end

local function JX_AvgXP_FindBestAvg()
	jx_best_average = 0
	jx_best_average_str = "Not Available"
	local avg
	
	if (not jx_kill_history) then
		debug(2,"No kill history available for Best Average\n");
		return;
	end
	
	for k,v in pairs(jx_kill_history) do
		avg = (v.total_xp / v.total_kills);
		if( (avg > jx_best_average) and (v.total_kills > 1) ) then
			jx_best_average = avg;
			jx_best_average_str = k;
		end
	end
	debug(1,string.format("Set Best Average to %s at %.1f\n",jx_best_average_str,jx_best_average));
end

------------------------------------------------------
-- Utility
------------------------------------------------------
local function JX_AvgXP_MobXP(plevel, mlevel)
	return (plevel * 5) + 45 + ( ( mlevel - plevel) * 17);
end

function JX_SetCommLang()
	for i, nextRace in ipairs(jx_alliedraces) do
		if (string.find(UnitRace("player"),nextRace)~=nil) then
			jx_commlang = LAX_CommonLanguage;
		end
	end
	if (not jx_commlang) then
		jx_commlang = LAX_OrcishLanguage;
	end
end

------------------------------------------------------
-- Time To Level stuff.
-- Borrowed from Titan.
-- I wont use the TITAN onces since then LAX will need
-- Titan to be installed and this is not at Titan Mod
------------------------------------------------------
function TitanUtils_GetEstTimeText(s)
	if (s < 0) then
		return "Infinite time";
	elseif (s < 60) then
		return format("%d seconds", s);
	elseif (s < 60*60) then
		return format("%.1f minutes", s/60);
	elseif (s < 24*60*60) then
		return format("%.1f hours", s/60/60);
	else
		return format("%.1f days", s/24/60/60);
	end
end

function TitanUtils_GetAbbrTimeText(s)
	if (s < 0) then
		return "Infinite time";
	end
	
	local days = floor(s/24/60/60); s = mod(s, 24*60*60);
	local hours = floor(s/60/60); s = mod(s, 60*60);
	local minutes = floor(s/60); s = mod(s, 60);
	local seconds = s;
	
	local timeText = "";
	if (days ~= 0) then
		timeText = timeText..format("%dd ", days);
	end
	if (days ~= 0 or hours ~= 0) then
		timeText = timeText..format("%dh ", hours);
	end
	if (days ~= 0 or hours ~= 0 or minutes ~= 0) then
		timeText = timeText..format("%dm ", minutes);
	end	
	timeText = timeText..format("%ds", seconds);
	
	return timeText;
end

------------------------------------------------------
-- Horrible way to comma delimit a number (this assumes its < 7 digits)
------------------------------------------------------
local function comma(val)
	local temp = tostring(val);
	if(string.len(temp) > 3) then
		return string.sub(temp,1,(string.len(temp) - 3))..","..string.sub(temp,(string.len(temp) - 3 + 1));
	else
		return temp;
	end
end

------------------------------------------------------
-- ToolTip
--
-- Holds and Controls all the fookking tooltip stuff
------------------------------------------------------
function JX_AvgXP_SetTooltip()

  -- Lets anchor the tooltip where we want it, if nothing
  -- found in the LAX_Options lets just default place it to the right.
  if ( LAX_Options[rName][pName].TooltipAnchor == "top") then
		GameTooltip:SetOwner(this, "ANCHOR_NONE");
		GameTooltip:SetPoint("TOP", "LAXFrame", "TOP", 0, 190);
  elseif ( LAX_Options[rName][pName].TooltipAnchor == "bottom") then
		GameTooltip:SetOwner(this, "ANCHOR_NONE");
		GameTooltip:SetPoint("BOTTOM", "LAXFrame", "BOTTOM", 0, -190);
  elseif ( LAX_Options[rName][pName].TooltipAnchor == "above") then
		GameTooltip:SetOwner(this, "ANCHOR_NONE");
		GameTooltip:SetPoint("BOTTOM", "LAXFrame", "BOTTOM", 0, -30);
  elseif ( LAX_Options[rName][pName].TooltipAnchor == "right") then
    GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
  elseif ( LAX_Options[rName][pName].TooltipAnchor == "left") then
    GameTooltip:SetOwner(this, "ANCHOR_LEFT");
  else
    GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
  end

  -- Clear the tooltip before we do anything.
  GameTooltip:ClearLines();

  -- Used to all.
  lax_xp_left = UnitXPMax("player") - UnitXP("player");

  if (not jx_target_stats) then

		GameTooltip:AddLine("Average Experience");
		--GameTooltip:AddLine(string.format("Total Kills: %d",jx_total_mobs_killed),1,1,1);

		if (not jx_rested_bonus) then
			jx_rested_bonus = 0;
		end
		
		if (jx_rested_bonus == nil) then
			msg = string.format("Total Kills: %d   Last Kill: %d exp",jx_total_mobs_killed, jx_last_xp_gained);
		else
			msg = string.format("Total Kills: %d   Last Kill: %d exp (%d rested bonus)",jx_total_mobs_killed, (jx_last_xp_gained+jx_rested_bonus),jx_rested_bonus);
		end

		GameTooltip:AddLine(msg,1,1,1);
	
		if( (jx_last_xp_gained < jx_avg_xp_per_mob) and (jx_last_xp_gained ~= 0) ) then
			msg = "Less than Avg";
		elseif (jx_last_xp_gained > jx_avg_xp_per_mob) then
			msg = "More than Avg";
  	else
			msg = "";
		end

  	GameTooltip:AddLine(msg,1,1,1);

    -- Best Average line.
    -- Prints the best average you got.
    GameTooltip:AddLine("Best Average",1,0.82,0);
		
  	msg = string.format("%s at %.1f exp per kill",jx_best_average_str,jx_best_average);
  	GameTooltip:AddLine(msg,1,1,1);

    -- This only shows when no target is active.
    lax_tp_msg = string.format("Experience to Level %d.", (UnitLevel("player")+1));
    GameTooltip:AddLine(lax_tp_msg);

    -- XP Left
    lax_exp_msg = string.format("%s experience left.", comma(lax_xp_left));
    GameTooltip:AddLine(lax_exp_msg,1,1,1);

    -- XP/Time and XP/Hour for this Session
    -- Time Played Session
    lax_session_time = string.format("%s spent this session.", TitanUtils_GetAbbrTimeText(lax_sessionTime));
    GameTooltip:AddLine(lax_session_time,1,1,1);

    -- XP this Session
    lax_session_xpmsg = string.format("%s experience this session.", comma(lax_sessionExperience));
    GameTooltip:AddLine(lax_session_xpmsg,1,1,1);
    
    -- XP / Hour this Session
    if ( lax_sessionExperience > 0 ) then
  		lax_xpHour = lax_sessionExperience / lax_sessionTime * 3600;
      lax_session_xphourmsg = string.format("%.1f xp/hour.", lax_xpHour);
      GameTooltip:AddLine(lax_session_xphourmsg,1,1,1);
    end

    -- Time to Level
    -- lax_xp_time = jx_total_xp_gained / LAX_SessionTime;
    if ( lax_sessionExperience > 0 ) then
    	lax_timeToLevel = (lax_xp_left / lax_sessionExperience * lax_sessionTime);
    else
      lax_timeToLevel = -1;
    end	

		lax_time_msg = TitanUtils_GetEstTimeText(lax_timeToLevel);
    lax_time_msg = string.format("%s left to level.", lax_time_msg);
    GameTooltip:AddLine(lax_time_msg,1,1,1);

    -- Normal
    lax_xp_normal = UnitXP("player") / UnitXPMax("player") * 100;
    lax_normal_msg = string.format("%.1f%% gained towards level.", lax_xp_normal);
    GameTooltip:AddLine(lax_normal_msg,1,1,1);

    -- Togo
    lax_xp_togo = lax_xp_left / UnitXPMax("player") * 100;
    lax_togo_msg = string.format("%.1f%% left to level.", lax_xp_togo);
    GameTooltip:AddLine(lax_togo_msg,1,1,1);

    -- Bars
    -- 20 bars meter.
    -- Shows how many bars you have left to level, out of 20 as 100%
    -- Same style as the regular XP bar from blizzard does but well not as fancy.
    lax_xp_bars = lax_xp_left / UnitXPMax("player") * 20;
    lax_bars_msg = string.format("%.1f bars left to level.", lax_xp_bars);
    GameTooltip:AddLine(lax_bars_msg,1,1,1);

  elseif ( (jx_kill_history_dep[ UnitName("target") ] ~= nil) and (not jx_kill_history[ UnitName("target") ]) ) then

	  -- Depricated Target Stats
  	GameTooltip:AddLine(UnitName("target"));
		
  	local avg = (jx_kill_history_dep[ UnitName("target") ].total_xp / jx_kill_history_dep[ UnitName("target") ].total_kills);
			
  	local approx_avg = avg - ( (UnitLevel("player") - jx_kill_history_dep[ UnitName("target") ].level) * 17);
			
  	GameTooltip:AddLine(string.format("Level %d Avg was %.1f",jx_kill_history_dep[ UnitName("target") ].level,avg),1,1,1);
  	GameTooltip:AddLine(string.format("Approx Avg now is %.1f",approx_avg),1,1,1);
  else 

    -- Target Stats
		GameTooltip:AddLine(UnitName("target"));
			
		local avg = (jx_kill_history[ UnitName("target") ].total_xp / jx_kill_history[ UnitName("target") ].total_kills);
		local kills = math.ceil( jx_exp_togo / avg );
		local kills_str = "kills";
			
		if (kills == 1) then
			kills_str = "kill";
		end
			
		GameTooltip:AddLine(string.format("Would take %d %s to level", kills, kills_str),1,1,1);
			
		if (kills < jx_num_mobs_left) then
			GameTooltip:AddLine("Faster than Average",1,1,1);
		elseif (kills == jx_num_mobs_left) then
			GameTooltip:AddLine("Same as Average",1,1,1);
		else
			GameTooltip:AddLine("Slower than Average",1,1,1);
		end
	
  	if (UnitName("target") == jx_best_average_str) then
  		GameTooltip:AddLine("Best Current Average",1,0.82,0);
  	else
  		msg = string.format("%.1f exp per kill less than %s",(jx_best_average - avg), jx_best_average_str);
  		GameTooltip:AddLine(msg,1,1,1);
  	end

		GameTooltip:AddLine("To Level");

    -- Normal
    lax_xp_normal = UnitXP("player") / UnitXPMax("player") * 100;
    lax_normal_msg = string.format("%.1f%% gained towards level.", lax_xp_normal);
    GameTooltip:AddLine(lax_normal_msg,1,1,1);

    -- Togo
    lax_xp_togo = lax_xp_left / UnitXPMax("player") * 100;
    lax_togo_msg = string.format("%.1f%% left to level.", lax_xp_togo);
    GameTooltip:AddLine(lax_togo_msg,1,1,1);

    -- Bars
    lax_xp_bars = lax_xp_left / UnitXPMax("player") * 20;
    lax_bars_msg = string.format("%.1f bars left to level.", lax_xp_bars);
    GameTooltip:AddLine(lax_bars_msg,1,1,1);

  end
	GameTooltip:Show();
end

------------------------------------------------------
-- JX_AvgXP_Reset()
-- no parms
-- desc: zeros out variables
------------------------------------------------------
local function JX_AvgXP_Reset()
 
  -- Total Reset!
  -- Changed from avgxp since that just removed the "stats" and not
  -- all the actual information that was saved in savedvariables.lua
  jx_kill_history_dep = { };
  jx_kill_history = { };
  jx_exp_history = { };
  jx_total_xp_gained = 0;
  jx_last_xp_gained = 0;
  jx_total_mobs_killed = 0;
  jx_avg_xp_per_mob = 0;
  jx_num_mobs_left = 0;
  jx_rested_num_mobs_left = 0;
end

------------------------------------------------------
-- Level Up functions
------------------------------------------------------
local function JX_Level_Display(i,val)
  if (val~=nil) then
    msg = string.format("  Level %d :: %1.f exp per kill :: %d kills total\n",i,val.avgxp,val.kills);
    display(WHT..msg);
  end
end

local function JX_AvgXP_Level_Report()
	msg = "none";
	display(YEL.."Average Exp gain per level::\n");
	table.foreachi(jx_exp_history, JX_Level_Display);
	if (msg=="none") then
		display(WHT.."  No records found in history.\n");
	end
end

local function JX_AvgXP_Level_Reset()
	jx_exp_history = { };
	display(YEL.."Average Exp gain per level reset.\n");
end

------------------------------------------------------
-- JX_Event_Player_Level_UP()
-- no parms
-- desc: Player Level Up, reset stats so we get Average Exp Gain across the entire level
-- ToDo: Store Average Exp Gain per level
------------------------------------------------------
function JX_Event_Player_Level_Up()
	-- Insert pair (level,average exp) into Exp History table
	table.insert(jx_exp_history, UnitLevel("player"), { avgxp = jx_avg_xp_per_mob, kills = jx_total_mobs_killed } )

	JX_AvgXP_Level_Report();

	-- Report statistics
	msg = string.format("%sXP Report: Average Exp per Kill for Level %d :: %1.f exp per kill\n",YEL,UnitLevel("player"),jx_avg_xp_per_mob);
	display(msg);

	JX_AvgXP_Depricate_History();	

	-- Reset average values for new level
	JX_AvgXP_Reset();
	display(YEL.."Average Exp settings have been reset due to level up.\n");
end

------------------------------------------------------
-- Core functions
------------------------------------------------------
function JX_AvgXP_FindPID()

  --Wait till VARIABLES_LOADED has fired
  if( ( UnitName("player") == nil ) or ( UnitName("player") == UNKNOWNOBJECT ) or (not GetCVar("realmName")) ) then
    return;
  end

  if (jx_avgxp_players == nil) then
    jx_avgxp_players = { };
    pid = -1;
    return;
  end

  -- If the table is empty why even recurse, no PID exists
  if( (table.getn(jx_avgxp_players) == 0) or (table.getn(jx_avgxp_players)==nil) ) then
    -- If PID == Nil when it enters JX_AvgXP_Calc it will fail
    -- We set to -1 to state that no pid currently exists, 
    -- and when it enters Calc it will initialize and then save after first calc
    pid = -1;
    return;
  end

  if( (pid==nil) or (pid==-1) )then
    pid = -1;
    debug(1,string.format("Looking for PID...%d\n",table.getn(jx_avgxp_players)));
    for i,v in ipairs(jx_avgxp_players) do
      if( (v.race == nil) and (v.realm == nil) and (v.name == UnitName("player")) ) then
        -- Using version 0.32 to 0.36
	jx_oldversion = true;
        pid = i;
      end

      -- Check Name, Race, and Realm
      if( (v.name == UnitName("player")) and (v.race == UnitRace("player")) and (v.realm == GetCVar("realmName")) ) then
        pid = i;
      end
    end
  end
  
  if (pid ~= -1) then
    debug(1,string.format("PID is %d\n",pid));
  else
    debug(1,"No PID found\n");
  end
end

------------------------------------------------------
-- Load Player vars for AvgXP
------------------------------------------------------
function JX_AvgXP_LoadPlayer()
	-- This calls after the player enters the world, 
  -- this is necessary to detect UnitRace
	if (not jx_commlang) then
		JX_SetCommLang();
	end	

	JX_AvgXP_FindPID();
	
	if( (pid ~= -1) and (pid ~= nil) ) then
		jx_avgexp_init = jx_avgxp_players[pid].init;
		jx_total_mobs_killed = jx_avgxp_players[pid].totalmobs;
		jx_total_xp_gained = jx_avgxp_players[pid].totalxp;
		if (jx_oldversion) then
			jx_exp_history = { };
			jx_kill_history = { };
			jx_kill_history_dep = { };
			display(GRN.."Exp History per level was reset due to an old version, to avoid corruption.\n");
		else
			jx_exp_history = jx_avgxp_players[pid].exphistory;
			jx_kill_history = jx_avgxp_players[pid].killhistory;
			if (not jx_kill_history) then
				jx_kill_history = { };
			end
			jx_kill_history_dep = jx_avgxp_players[pid].depkillhistory;
			if (not jx_kill_history_dep) then
				jx_kill_history_dep = { };
			end
		end
	else
		jx_avgexp_init = true;
		jx_total_mobs_killed = 0;
		jx_total_xp_gained = 0;
		jx_exp_history = { };
		jx_kill_history = { };
		jx_kill_history_dep = { };
	end

	jx_avg_xp_per_mob = 0;
	jx_num_mobs_left = 0;
	jx_rested_num_mobs_left = 0;
	jx_last_xp_gained = 0;

	debug(1,"Load fired.\n");
end

------------------------------------------------------
-- SavePlayer stats.
------------------------------------------------------
function JX_AvgXP_SavePlayer()
	-- Locate Player ID
	JX_AvgXP_FindPID();

	-- If No Player ID insert first values
	if (pid == -1) then
		local stats = {
			name = UnitName("player"),
			race = UnitRace("player"),
			realm = GetCVar("realmName"),
			init = jx_avgexp_init,
			totalmobs = jx_total_mobs_killed,
			totalxp = jx_total_xp_gained,
			exphistory = jx_exp_history, 
			killhistory = jx_kill_history,
			depkillhistory = jx_kill_history_dep };
		table.insert(jx_avgxp_players,stats);
	else
		-- Player existed overwrite old values
		jx_avgxp_players[pid].totalmobs = jx_total_mobs_killed;
		jx_avgxp_players[pid].totalxp = jx_total_xp_gained;
		jx_avgxp_players[pid].exphistory = jx_exp_history;
		jx_avgxp_players[pid].killhistory = jx_kill_history;
		jx_avgxp_players[pid].depkillhistory = jx_kill_history_dep;
		
		if (jx_oldversion) then
			jx_avgxp_players[pid].race = UnitRace("player");
			jx_avgxp_players[pid].realm = GetCVar("realmName");
		end
	end

	is_saved = true;

	debug(1,"Save fired.\n");
end

------------------------------------------------------
-- LAX_Initialize()
-- No Parms
-- Desc: Initializes all values, runs OnLoad
------------------------------------------------------
function LAX_Initialize()

	if(pid~=nil) then
		-- Check Player specific Init, if its false set default values
		if( (jx_avgexp_init==nil) or (jx_avgexp_init==false) ) then
			jx_total_mobs_killed = 0;
			jx_total_xp_gained = 0;
			jx_exp_history = { };
			jx_avgexp_init = true;
			JX_AvgXP_Reset();
			display(YEL.."Average Exp settings have been reset.\n");		
		end
	end

	-- Check Global init other initialize player table
	if( (jx_avgxp_globalinit==nil) or (jx_avgxp_globalinit==false) ) then
		jx_avgxp_players = { };
		jx_avgxp_globalinit = true;
	end

	-- Add /lax command line (/avgxp kept for backwards compability)
	SlashCmdList["LAX"] = LAX_Command;
	SLASH_LAX1 = "/lax";

	-- Calculate when Exp Gain. From Combat, XP Update (Quest / Exploration), Level Up
	this:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN");
	this:RegisterEvent("PLAYER_XP_UPDATE");
	this:RegisterEvent("PLAYER_LEVEL_UP");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("TIME_PLAYED_MSG");
  
	-- Run Calculation and update UI (This will Save the Player at the end)
	JX_AvgXP_Calc("JX_AVGXP_INIT");

  -- LAX Update
  LAX_XPBar_Update();
end

------------------------------------------------------
-- I borrowed this from UIMem.
-- Creds to Snakexc
------------------------------------------------------
function LAX_ExtractCMDParams(msg)
  local params = msg;
  local command = params;
  local index = strfind(command, " ");
  if ( index ) then
    command = strsub(command, 1, index-1);
    params = strsub(params, index+1);
  else
    params = "";
  end

  return command, params;

end

------------------------------------------------------
-- LAX_Command(msg)
-- msg : Command line parameter
-- Desc: Parses the /lax and /avgxp command
------------------------------------------------------
function LAX_Command(msg)

  -- Vars: removed all duplicate calculations, since nothing SHOULD change
  local output = "";

  if (not is_loaded) then
    return;
  end
	
  -- ToDo: Verify that "COMMON" in SendChatMessage works for Alliance and Horde
  if( (UnitName("target")~=nil) and (jx_target_stats~=nil) ) then
    output = jx_target_stats;
  else
    output = jx_avgexp_stats;
  end
	
  -- If msg converts to a number cleanly, assume its a channel id
  -- ToDo: Something with Cosmos breaks SendChatMessage() to a channel. Research?
  -- if ( ( tonumber(msg) ~= nil ) ) then
  --  SendChatMessage(output,"CHANNEL",jx_commlang,tonumber(msg));
  -- end

  -- Check for extra parameters in the msg.
  -- LAX needs variables to the /command.
  msg, params = LAX_ExtractCMDParams(string.lower(msg));

  -- Print the help functions.
  -- No Params prints regular help with links to real helps.
  --
  -- LAX had to much help so I had to split it into secions.
  --
  if( ( msg == nil ) or ( msg == "" ) or ( msg == "help" ) or ( msg == "?" ) ) then
    if ( params == "avgxp" ) then
      for i=0, table.getn(LAX_HelpAvgXP) do
        Print(LAX_HelpAvgXP[i]);
      end  

    elseif ( params == "general" ) then
      for i=0, table.getn(LAX_HelpGeneral) do
        Print(LAX_HelpGeneral[i]);
      end  

    elseif ( params == "visual" ) then
      for i=0, table.getn(LAX_HelpVisual) do
        Print(LAX_HelpVisual[i]);
      end  

    else
      -- Print the HELP
      for i=0, table.getn(LAX_Help) do
        Print(LAX_Help[i]);
      end

    end

  -- Reset parameter, clear stats
  elseif ( msg == "reset" ) then
    if ( params == "now" ) then
      JX_AvgXP_Reset();
      Print(LAX_SPLASH.." Average Experience has been reset.");

    elseif ( params == "onload" ) then
      Print(LAX_SPLASH.." Average Experience will be auto reset on load.");
      LAX_Options[rName][pName].AutoReset = "onload";

    elseif ( params == "disable" ) then 
      Print(LAX_SPLASH.." Average Experience auto reset has been disabled.");
      LAX_Options[rName][pName].AutoReset = "disable";

    else
      Print(LAX_SPLASH.." reset needs a value! /lax reset [onload|now|disable]");

    end

    -- Recalc and Update UI
    JX_AvgXP_Calc("JX_AVGXP_INIT");		

	
  -- Display Exp per Level Report
  elseif ( msg == "level" or msg == "l" ) then
    JX_AvgXP_Level_Report();

  -- Broadcast stats to party
  elseif ( msg == "party" or msg == "p" ) then
    -- Verify they are in a party, yes it is redundancy checking
    if ( (GetNumPartyMembers() == nil) or (GetNumPartyMembers() < 1) ) then
      msg="You are not in a party.";
      display(msg);
    else
      SendChatMessage(output,"PARTY",jx_commlang,"");
    end

  -- Broadcast stats to guild
  elseif ( msg == "guild" or msg == "g" ) then

    -- Verify they are in a guild, if you're reading this and didn't expect 
    -- this, you my friend have serious issues with short term memory
    if ( IsInGuild() ) then
      SendChatMessage(output,"GUILD",jx_commlang,"");
    else
      msg="You are not a member of a guild.\n";
      display(msg);
    end

  -- LAX Specific LOCKING function
  elseif ( msg == "lock" ) then

    Print(LAX_SPLASH.." is now locked.");
    LAX_Options.Locked = true;
    LAX_OnDragStop();
      
  -- LAX Unlock function
  elseif ( msg == "unlock" ) then
    Print(LAX_SPLASH.." is now unlocked.");
    LAX_Options.Locked = false;

  -- Show or hide it.
  elseif ( msg == "show" or msg == "hide" ) then
    if ( params == "restedxp" or params == "mainxp" ) then
      LAX_ToggleVisableXPBar(msg, params);
    else
      LAX_ToggleVisable( msg );
    end
	 
  -- Set tge width of LAX xpbar
  elseif ( msg == "width" ) then
    if ( tonumber(params) ~= nill ) then
      if ( tonumber(params) <= 1200 and tonumber(params) >= 400 ) then
        LAX_Options[rName][pName].BarWidth = tonumber(params);
        LAX_SetBarWidth();
        Print(LAX_SPLASH.." width set to "..tonumber(params));
      else
        Print(LAX_SPLASH.." width need to be between 400 and 1000 or default");
      end
    elseif ( params == "default" ) then
      LAX_Options[rName][pName].BarWidth = LAX_BarNormalWidth;
      LAX_SetBarWidth();
      Print(LAX_SPLASH.." width set to default ("..LAX_BarNormalWidth..")");
    else
      Print(LAX_SPLASH.." width need to be between 399 and 1001 or default");
    end

  -- Change what the XP text is showing in the info text.
  -- Experience on level, 20 bars mode or Experience togo.
  elseif ( msg == "xptext" ) then
    if ( params == "normal" ) then
      Print(LAX_SPLASH.." xptext set to normal mode, showing percent xp you have on this level.");
      LAX_Options[rName][pName].InfoTextMode = params;
      JX_AvgXP_Calc("JX_AVGXP_INIT");
    elseif ( params == "togo" ) then
      Print(LAX_SPLASH.." xptext set to togo, mode showing percent xp you need to the new level.");
      LAX_Options[rName][pName].InfoTextMode = params;
      JX_AvgXP_Calc("JX_AVGXP_INIT");
    elseif ( params == "bars" ) then
      Print(LAX_SPLASH.." xptext set to 20 bars mode, showing bars left to level (20 bars for max).");
      LAX_Options[rName][pName].InfoTextMode = params;
      JX_AvgXP_Calc("JX_AVGXP_INIT");
    else
      Print(LAX_SPLASH.." valid options are normal, togo or bars.");
    end

  -- Show hide textinfo
  elseif ( msg == "infotext" ) then
    if ( params == "show" ) then
      LAX_Options[rName][pName].InfoText = "show";
    	AvgXPText:Show();
      Print(LAX_SPLASH.." displaying of infotext turned on.");
    elseif (params == "hide" ) then
      LAX_Options[rName][pName].InfoText = "hide";
      AvgXPText:Hide();
      Print(LAX_SPLASH.." displaying of infotext turned off.");
    elseif (params == "hover" ) then
      LAX_Options[rName][pName].InfoText = "hover";
      AvgXPText:Hide();
      Print(LAX_SPLASH.." displaying of infotext set to hover.");
    else
      Print(LAX_SPLASH.." valid options are show, hide or hover.");
    end

  -- Font functions.
  elseif ( msg == "font" ) then
    if ( params == "8" ) then
      AvgXPText:SetTextHeight(8); 
      LAX_Options[rName][pName].FontSize = 8;
      Print(LAX_SPLASH.." font height set to "..params..".");
    elseif ( params == "9" ) then
      AvgXPText:SetTextHeight(9);
      LAX_Options[rName][pName].FontSize = 9;
      Print(LAX_SPLASH.." font height set to "..params..".");
    elseif ( params == "10" ) then
      AvgXPText:SetTextHeight(10); 
      LAX_Options[rName][pName].FontSize = 10;
      Print(LAX_SPLASH.." font height set to "..params..".");
    else
      Print(LAX_SPLASH.." valid font sizes are 8, 9, and 10.");
    end
  
  elseif ( msg == "colour" or msg == "color" ) then
    Print(LAX_SPLASH.." to change color use /lax mcolour|rcolour.");
    
  -- Colour functions
  -- Rested XP/Main XP Bar colour settings.
  elseif ( msg == "mcolour" or msg == "mcolor" ) then
    if ( params == "red" or params == "magenta" or params == "green" or params == "orange" or params == "yellow" or params == "cyan" or params == "default" ) then
      Print(LAX_SPLASH..' Rested XP BarColor set to '..params);
      LAX_SetColour(LAX_XPBar, params);
      LAX_Options[rName][pName].Colour = params;

    else
      Print(LAX_SPLASH..' not a valid colour!');
      Print(LAX_SPLASH..' valid colours: cyan, red, orange, yellow, green, magenta or default(blue).');

    end

  -- Colour functions
  -- Rested XP Bar colour settings.
  elseif ( msg == "rcolour" or msg == "rcolor" ) then
    if ( params == "red" or params == "magenta" or params == "green" or params == "orange" or params == "yellow" or params == "cyan" ) then
      Print(LAX_SPLASH..' Rested XP BarColor set to '..params);
      LAX_SetColour(LAX_XPBarRested, params);
      LAX_Options[rName][pName].RestedColour = params;

    else
      Print(LAX_SPLASH..' not a valid colour!');
      Print(LAX_SPLASH..' valid colours: cyan, red, orange, yellow, green or magenta.');

    end

  -- Brief/Verbose Mode
  elseif ( msg == "brief" ) then
    if ( params == "on" ) then
      LAX_Options[rName][pName].BriefMode = "on";
      LAX_SetBarWidth();
      Print(LAX_SPLASH..' brief set to on.');
      JX_AvgXP_Calc("JX_AVGXP_INIT");

    elseif ( params == "off" ) then
      LAX_Options[rName][pName].BriefMode = "off";
      LAX_SetBarWidth();
      Print(LAX_SPLASH..' brief set to off.');
      JX_AvgXP_Calc("JX_AVGXP_INIT");

    else
      Print(LAX_SPLASH..' brief on or off are valid.');

    end

  -- Tooltip function, change anchor.
  -- or since 0.8.8 also hide it or was it 0.8.7?
  elseif ( msg == "tooltip" ) then
    if ( params == "top" ) then
      LAX_Options[rName][pName].TooltipAnchor = "top";
      Print(LAX_SPLASH.." tooltip location set to "..params..".");
    elseif ( params == "bottom" ) then
      LAX_Options[rName][pName].TooltipAnchor = "bottom";
      Print(LAX_SPLASH.." tooltip location set to "..params..".");
    elseif ( params == "above" ) then
      LAX_Options[rName][pName].TooltipAnchor = "above";
      Print(LAX_SPLASH.." tooltip location set to "..params..".");
    elseif ( params == "left" ) then
      LAX_Options[rName][pName].TooltipAnchor = "left";
      Print(LAX_SPLASH.." tooltip location set to "..params..".");
    elseif ( params == "right" ) then
      LAX_Options[rName][pName].TooltipAnchor = "right";
      Print(LAX_SPLASH.." tooltip location set to "..params..".");
    elseif ( params == "off" ) then
      LAX_Options[rName][pName].TooltipAnchor = "off";
      Print(LAX_SPLASH.." tooltip set to "..params..".");

    else
      Print(LAX_SPLASH.." valid tooltip locations are top, bottom, above, left, right or off.");
    end

  -- LAX History savings, actually AvgXP savings.
  elseif ( msg == "save" ) then
    if ( params == "enable" ) then
      LAX_Options[rName][pName].SaveMode = "enable";
      Print(LAX_SPLASH.." history saving enabled.");
    elseif ( params == "disable" ) then
      LAX_Options[rName][pName].SaveMode = "disable";
      Print(LAX_SPLASH.." history saving disabled.");
    else
      Print(LAX_SPLASH.." valid options are enable or disable.");
    end

	-- Docking mode, just like AvgXPDeluxe.
  -- This was a request.
	elseif ( msg == "dock" ) then
		LAXFrame:ClearAllPoints();
    LAX_Options[rName][pName].BriefMode = "off";
    LAX_Options[rName][pName].BarWidth = 1024;
    LAX_Options.Locked = true;
    LAX_SetBarWidth();
		LAXFrame:ClearAllPoints();
		LAXFrame:SetPoint("TOP", "MainMenuBar", "TOP", 0, 5);
    Print(LAX_SPLASH.." docked and locked onto the MainMenuBar.");

  -- Version
  -- Show that we used AvgXP by jINx, credit is good to give.
  elseif ( msg == "version" ) then
    Print(LAX_SPLASH.." version "..LAX_Version.." by "..LAX_Author);
    Print(LAX_SPLASH.." is based on AvgXP v."..jx_avgexp_version.." by jINx");

  -- Defaults, set all realm and character settings to defaults.
  elseif ( msg == "defaults" or msg == "default" ) then
    Print(LAX_SPLASH.." resetting settings for "..pName.." on "..rName..".");
    LAX_InitDefaultOptions();

  -- Simple Status Dump
  elseif ( msg == "status" ) then
    LAX_DumpStatus();

  -- Refresh everything
  elseif ( msg == "update" or msg == "refresh" ) then
    Print(LAX_SPLASH.." Update and Refresh called.");
    LAX_XPBar_Update();
    JX_AvgXP_Calc("JX_AVGXP_INIT");

  -- Debugging, turn it on or off.
  elseif ( msg == "debug" ) then
    if ( params == "enable" ) then
      LAX_DEBUG = true;
      Print(LAX_SPLASH.." debugging enabled.");
    elseif ( params == "disable" ) then
      LAX_DEBUG = false;
      Print(LAX_SPLASH.." debugging disabled.");
    else
      Print(LAX_SPLASH.." valid options are enable or disable.");
    end

  -- Default Message when they failed to use any valid command.
  else
    Print(LAX_SPLASH.." "..MAG..msg..WHT.." is not a valid command.");

  end
end

------------------------------------------------------
-- JX_AvgXP_Calc()
-- no parms
-- Desc: Event that updates the calculation
------------------------------------------------------
function JX_AvgXP_Calc(event)

  -- vars: string initialization
  local jx_last_xp_str = "";
  local jx_isrested = false;
  local update = false;

  debug(1,string.format("%s Event Fired\n",event));

  -- Sanity Checks : 
  -- These are the things that drive you nuts because it makes the script 
  -- appear like its not working properly when it should be
  if ( event == "VARIABLES_LOADED" ) then

    -- Report Information so we can verify that initialize was called 
    -- and to show version
    Print(LAX_HELLO1);
    Print(LAX_HELLO2);
    
    -- Debug stuff
    debug(9,string.format("%sDebug is Enabled. Current Threshold is Level %d\n",GRN,jx_debug_threshold));
    debug(1,"Variables loaded, safe to load player and init\n");

    -- OK vars loaded, lets go.
    update = true;
    is_loaded = true;

    -- Check if we should load LAX saved options.
    -- Else we will use the "defaults".
    LAX_LoadOptions();
  end

  -- If Variables are not loaded do not process anything
  if (not is_loaded) then
    return;
  end

  -- Wait for the player to enter the world before loading 
  -- (otherwise UnitName("player") == Nil)	
  if ( event == "PLAYER_ENTERING_WORLD" ) then

		-- Initial session time 
		if (not lax_totalTime) then
			lax_sessionTime = 0;
			RequestTimePlayed();
		end

    -- Check if we should load LAX saved options.
    -- Else we will use the "defaults".
    LAX_LoadOptions();

    JX_AvgXP_LoadPlayer();

    -- Setup Best Average
    JX_AvgXP_FindBestAvg();

    if(not pid) then
      -- Don't need to update because PLAYER_XP_UPDATE will fire next (Correct)
    else
      -- However, on initial load of WoW, first login it goes: 
      -- Name Update, Xp Update, Name, Name, Name
      update = true;
    end
  end

  -- If something failed with LoadPlayer or its an event call prior to 
  -- UNIT_NAME_UPDATE do not process anything further
  if(not pid) then
    debug(1,"Breaking because pid is nil\n");
    return;
  end

  -- Chec for is_loaded and then if LAX Options loaded
  -- else fire up the LAX_LoadOptions.
  -- LAX_LoadOptions();

  -- Check: If not initialized, and we somehow got here, Initialize!
  -- Return to break out, as Initialize will recurse and call Calc again
  -- Note: Found this can occur because PLAYER_XP_UPDATE is called OnLoad
  if( (jx_avgexp_init==nil) or (jx_avgexp_init==false) ) then
    LAX_Initialize();
    return;
  end

  -- End of Sanity Checks
  
  -- 
  -- Event: Update display for Target info
  if ( event == "PLAYER_TARGET_CHANGED" ) then
    
    -- Sanity check
    if (UnitName("target")~=nil) then
	    
      -- If its Focus and not Losing Focus
      if (UnitIsEnemy("player","target")) then
	      
        -- Check if kill tracking exists and display 
        if (jx_kill_history[ UnitName("target") ] ~= nil) then
		
          if ( LAX_Options[rName][pName].BriefMode == "on" ) then
		  
            jx_target_stats = string.format("Target : %s : xp/kill %.1f : Kills %d", UnitName("target"), (jx_kill_history[ UnitName("target") ].total_xp / jx_kill_history[ UnitName("target") ].total_kills), jx_kill_history[ UnitName("target") ].total_kills);
	    
          else
		  
            jx_target_stats = string.format("Target :: %s :: Average Exp per Kill %.1f exp :: Total kills %d", UnitName("target"), (jx_kill_history[ UnitName("target") ].total_xp / jx_kill_history[ UnitName("target") ].total_kills), jx_kill_history[ UnitName("target") ].total_kills);
	    
          end
	  
          AvgXPText:SetText(jx_target_stats);
	  
        else		
		
          -- Check Depricated history
          if (jx_kill_history_dep[ UnitName("target") ] ~= nil) then
           if ( LAX_Options[rName][pName].BriefMode == "on" ) then
              jx_target_stats = string.format("Lvl %d : %s : xp/kill %.1f exp : Kills %d", jx_kill_history_dep[ UnitName("target") ].level, UnitName("target"), (jx_kill_history_dep[ UnitName("target") ].total_xp / jx_kill_history_dep[ UnitName("target") ].total_kills), jx_kill_history_dep[ UnitName("target") ].total_kills);
            else
             jx_target_stats = string.format("Level %d :: %s :: Average Exp per Kill %.1f exp :: Total kills %d", jx_kill_history_dep[ UnitName("target") ].level, UnitName("target"), (jx_kill_history_dep[ UnitName("target") ].total_xp / jx_kill_history_dep[ UnitName("target") ].total_kills), jx_kill_history_dep[ UnitName("target") ].total_kills);
            end
            AvgXPText:SetText(jx_target_stats);
          end
        end
      end
    else	
      -- If nil not displaying stats
      jx_target_stats = nil;
      -- Revert UI to standard Stats on losing focus
      AvgXPText:SetText(jx_avgexp_stats);
    end

  -- 
  -- Event: Self triggered Calc for the purpose of Updating the UI
  elseif ( event == "JX_AVGXP_INIT" ) then
    update = true;

  -- 
  -- Event: Gain exp from a quest or exploration, update the UI and Save
  elseif ( event == "PLAYER_XP_UPDATE" ) then
    update = true;

  -- 
  -- Event: Experience gain from Combat 
  -- (Don't count kills that don't result in Experience, 
  -- this would skew Average Exp Gain)
  elseif ( event == "CHAT_MSG_COMBAT_XP_GAIN" ) then
    jx_rested_bonus = 0;

    -- When you're rested don't count the rested exp into the average, 
    -- skews it horribly
    -- By removing rested_bonus from jx_last_xp_gained we essentially 
    -- process the rested_bonus as a standard PLAYER_XP_UPDATE event
    for rested_bonus in string.gfind(arg1, RESTED_GAIN_TEXT) do
      jx_isrested = true;
      jx_rested_bonus = tonumber(rested_bonus);
    end

    for mobile_name, xp in string.gfind(arg1, EXP_GAIN_TEXT) do
      jx_last_xp_gained = tonumber(xp);
      if (jx_isrested) then
      	jx_last_xp_gained = jx_last_xp_gained - jx_rested_bonus;
      	msg = string.format("Was Rested %d counted toward average (%d rested)",jx_last_xp_gained, jx_rested_bonus);
      	debug(2,msg);
      end

      -- LAX kill shit, added this to make some funky stuff.
      lax_sessionExperience = lax_sessionExperience + jx_last_xp_gained;
      lax_sessionKills = lax_sessionKills + 1;

      -- AVGxp shit, only works if you have savings on basically.
      jx_total_xp_gained = jx_total_xp_gained + jx_last_xp_gained;
      jx_total_mobs_killed = jx_total_mobs_killed + 1;

      -- Tally the Kill (does not include rested bonus)
      JX_AvgXP_AddKill(mobile_name,jx_last_xp_gained);
    end

    -- Update the UI and Save	
    update = true;

  --
  -- Event: Time Played
	elseif ( event == "TIME_PLAYED_MSG" ) then
		-- Remember play time
		-- lax_sessionTime = arg1;
		lax_levelTime = arg2;		

  --
  -- Event: Player Level Up, reset stats 
  -- so we get Average Exp Gain across the entire level
  elseif ( event == "PLAYER_LEVEL_UP" ) then

 		-- Reset level time
		lax_levelTime = 0;

    -- Run Level Up to store Level and Reset Avgs		
    JX_Event_Player_Level_Up();

    -- Update the UI and Save	
    update = true;
  end		

  -- If set variables have changed and should update the data, 
  -- otherwise it fires everytime an event occurs
  if ( update == true ) then
    
    -- LAX Update Bar.
    LAX_XPBar_Update();

    debug(1,string.format("Update is True - Event that fired is: %s\n",event));

    -- Calculate average (Exp Gained / Kills) 
    -- Check for Div by 0 (though LUA doesn't complain)
    if( (jx_total_mobs_killed > 0) and (jx_total_mobs_killed~=nil) ) then
      jx_avg_xp_per_mob = jx_total_xp_gained / jx_total_mobs_killed;
    end

    -- Calculate approximate kills to level - Check for Div by 0 again
    if( (jx_avg_xp_per_mob > 0) and (jx_avg_xp_per_mob ~= nil) ) then
      jx_num_mobs_left = ( UnitXPMax("player") - UnitXP("player") ) / jx_avg_xp_per_mob;
      jx_num_mobs_left = math.ceil(jx_num_mobs_left); -- Round up

      if (jx_num_mobs_left >= 2) then
        jx_rested_num_mobs_left = (jx_num_mobs_left) / 2;
        jx_rested_num_mobs_left = math.ceil(jx_rested_num_mobs_left);
      end
    end
	
    -- Personal pet pieve: Couldn't find a LUA inline conditional, 
    -- ie C. (jx_num_mobs_left==1?"kill":"kills") this possible? (Dejavu?)
    if (jx_num_mobs_left == 1) then
      jx_kills_str = "kill";
    else
      jx_kills_str = "kills";
    end
	
    -- If last exp gained was different than average, 
    -- show + for higher, - for lower
    if (jx_last_xp_gained < jx_avg_xp_per_mob) then
      jx_last_xp_str = "- ";
    else
      if (jx_last_xp_gained > jx_avg_xp_per_mob) then
        jx_last_xp_str = "+ ";
      else
        jx_last_xp_str = "  ";
      end
    end

    -- Original AvgXP stuff, needed.
    jx_exp_togo = UnitXPMax("player") - UnitXP("player");
    local RXP = GetXPExhaustion();

    -- Ok now we add the new feature from LAX 0.8.8
    -- Three different modes of showing how much xp you need to level.
    -- normal mode: percent xp on level 80%.
    -- togo mode: percent xp left to level 20%.
    -- bars mode: 20 bars is max (default blizzard "ui" mode).
    if ( LAX_Options[rName][pName].InfoTextMode == "normal" ) then
      jx_exp_pc = UnitXP("player") / UnitXPMax("player") * 100;
      lax_exp_pc = string.format("%.1f%%", jx_exp_pc);
    elseif ( LAX_Options[rName][pName].InfoTextMode == "togo" ) then
      jx_exp_pc = jx_exp_togo / UnitXPMax("player") * 100; 	  
      lax_exp_pc = string.format("%.1f%%", jx_exp_pc);
    elseif ( LAX_Options[rName][pName].InfoTextMode == "bars" ) then
      jx_exp_pc = jx_exp_togo / UnitXPMax("player") * 20; 	  
      lax_exp_pc = string.format("%.1f bars", jx_exp_pc);
    else
      jx_exp_pc = UnitXP("player") / UnitXPMax("player") * 100;
      lax_exp_pc = string.format("%.1f%%", jx_exp_pc);
    end
	
    -- Check: Cannot divide by 0, display N/A instead of attempting 
    -- to display numeric, will result in -1.#IND
    if( (jx_total_mobs_killed == 0) or (jx_total_mobs_killed == nil) ) then
      jx_avg_xp_per_mob_str = "N/A";
    else
      jx_avg_xp_per_mob_str = string.format("%.1f",jx_avg_xp_per_mob);
    end

    -- Setup stats output string
    -- Potential ToDo: Allow for custom string and .gsub to fill with values, possibly with tracking more this would be useful
    --
    -- LAX Modification done.
    -- Added Briefmode and 3 ways of showing how much to level.
    if ( RXP == nil ) then
      if ( LAX_Options[rName][pName].BriefMode == "on" ) then
        jx_avgexp_stats = string.format("%s to %d : %s xp left : xp/kill %s %s: %d %s left", lax_exp_pc, (UnitLevel("player")+1), comma(jx_exp_togo), jx_avg_xp_per_mob_str, jx_last_xp_str, jx_num_mobs_left, jx_kills_str);
      else
        jx_avgexp_stats = string.format("XP :: %s to Level %d :: %s exp left :: Avg Exp per Kill %s %s:: %d %s to level", lax_exp_pc, (UnitLevel("player")+1), comma(jx_exp_togo), jx_avg_xp_per_mob_str, jx_last_xp_str, jx_num_mobs_left, jx_kills_str);
     end
    else
      if ( LAX_Options[rName][pName].BriefMode == "on" ) then
        jx_avgexp_stats = string.format("%s to %d : %s(%s) xp left : xp/kill %s %s: %d %s left", lax_exp_pc, (UnitLevel("player")+1), comma(jx_exp_togo),comma(GetXPExhaustion()), jx_avg_xp_per_mob_str, jx_last_xp_str, jx_rested_num_mobs_left, jx_kills_str);
      else
        jx_avgexp_stats = string.format("XP :: %s to Level %d :: %s(%s) exp left :: Avg Exp per Kill %s %s:: %d %s to level", lax_exp_pc, (UnitLevel("player")+1), comma(jx_exp_togo),comma(GetXPExhaustion()), jx_avg_xp_per_mob_str, jx_last_xp_str, jx_rested_num_mobs_left, jx_kills_str);
      end
    end
	
    -- Update UI
    AvgXPText:SetText(jx_avgexp_stats);
	
    -- Update the Saved Table
    --
    -- LAX Modification.
    -- OK if No save mode is active, then dont run this.
    if ( LAX_Options[rName][pName].SaveMode == "enable" ) then
      JX_AvgXP_SavePlayer();	
    end
  end
end
