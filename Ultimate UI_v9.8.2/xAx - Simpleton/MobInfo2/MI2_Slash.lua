--constanst
mifontBlue = "|cff00ccff";
mifontGreen = "|cff00ff00";
mifontRed = "|cffff0000";
mifontGold = "|cffffcc00";
mifontGray = "|cff888888";
mifontWhite = "|cffffffff";
mifontSubWhite = "|cffbbbbbb";
mifontMageta = "|cffff00ff";
mifontYellow  = "|cffffff00";
mifontCyan   = "|cff00ffff";

miVersionNo = ' 2.23'

miVersion = mifontYellow..'MobInfo-2 Version '..miVersionNo..mifontGreen..' http://dizzarian.com';
miPatchNotes = mifontYellow..
  'MobInfo-2 Version '..miVersionNo..'\n\n'..
  '  ver 2.23\n'..
  '    - fixed kill counting for Mobs without XP (wasnt working)\n'..
  '    - fixed show tooltip on Alt (wasnt working)\n\n'..
  '  ver 2.22\n'..
  '    - fixed a nil bug related to running an external MobHealth\n'..
  '    - disabled a debug message that managed to sneak in\n\n'..
  '  ver 2.21\n'..
  '    - fixed nil error some got for optValue in MI2_Slash\n'..
  '    - fixed the buttons for All On, Default, etc \n\n'..
  '  ver 2.2\n'..
  '    - new feature: display mana values in target frame\n'..
  '    - new feature: option to display health/mana percent\n'..
  '    - new feature: more health/mana position options\n'..
  '    - updated French translation (thanks Sasmira!)\n'..
  '    - fixed: occasional Health without value in tooltip\n'..
  '    - restructured slash option handling, chat feedback now translated\n'..
  '    - full integration of MobHealth slash commands (had to rename them)\n'..
  '    - changed names of some slash cmnd options\n\n'..
  '  For all previous patch notes and to report bugs please visit http://www.dizzarian.com/forums/viewforum.php?f=16';
  

local   MI2_SLASH_OPT = {};
local   MI2_SLASH_VAL = {};


miSlashCommands = 
  mifontYellow.. 'Usage /mobinfo <cmd> or /mi <cmd>\n'..
  'Where <cmd> is any of the following\n'..
  mifontGreen..'  help - '..mifontYellow..'This information screen\n'..
  mifontGreen..'  config - '..mifontYellow..'Shows the MobInfo Config Screen\n'..
  mifontGreen..'  clear - '..mifontYellow..'Clears the mobinfo database\n'..
  mifontGreen..'  version - '..mifontYellow..'Displays the current version of the mod\n'..
  mifontGreen..'  notes - '..mifontYellow..'Displays the current patch notes\n'..
  mifontGreen..'  addcustom - '..mifontYellow..'Add Custom tracking item. This is case sensitive\n'..
  mifontGreen..'  removecustom - '..mifontYellow..'Remove Custom tracking item. This is case sensitive\n'..
  mifontGreen..'  listcustom - '..mifontYellow..'List all custom items that you are tracking\n'..
  mifontGreen..'  showclass - '..mifontYellow..'Toggles the mob\'s health on and off\n'..
  mifontGreen..'  showhealth - '..mifontYellow..'Toggles the mob\'s health on and off\n'..
  mifontGreen..'  showdamage - '..mifontYellow..'Toggles the mob\'s damage range on and off\n'..
  mifontGreen..'  showkills - '..mifontYellow..'Toggles the total kills on and off\n'..
  mifontGreen..'  showloots - '..mifontYellow..'Toggles the number of times you looted the mob on and off\n'..
  mifontGreen..'  showempty - '..mifontYellow..'Toggles the number of times you looted an empty corpse on and off\n'..
  mifontGreen..'  showxp - '..mifontYellow..'Toggles the last mob xp amount on and off\n'..
  mifontGreen..'  showno2lev - '..mifontYellow..'Toggles the number of kills needed to level on and off\n'..
  mifontGreen..'  showcoin - '..mifontYellow..'Toggles the average coin drop from mob on and off\n'..
  mifontGreen..'  showiv - '..mifontYellow..'Toggles the average total item value drop on and off\n'..
  mifontGreen..'  showtotal - '..mifontYellow..'Toggles the total mob value on and off\n'..
  mifontGreen..'  showquality - '..mifontYellow..'Toggles the quality of loot drops on and off\n'..
  mifontGreen..'  showcloth - '..mifontYellow..'Toggles cloth drops on and off\n'..
  mifontGreen..'  showblanklines - '..mifontYellow..'Toggles the extra blank lines onand off\n'..
  mifontGreen..'  combinedmode - '..mifontYellow..'combine data for Mobs with same name\n'..
  mifontGreen..'  keypressmode - '..mifontYellow..'show mob info only when ALT key is pressed\n'..
  mifontGreen..'  saveallvalues - '..mifontYellow..'Saves all values reguardless of if they are shown or not\n'..
  mifontGreen..'  clearonexit - '..mifontYellow..'Clears mobinfo all data on exit so that nothing is stored in your savedvariables\n'..
  mifontGreen..'  disablehealth - '..mifontYellow..'completely disable built-in MobHealth functionality\n'..
  mifontGreen..'  default - '..mifontYellow..'Sets mobinfo to it\'s default values\n'..
  mifontGreen..'  allOn - '..mifontYellow..'Sets mobinfo to all values on\n'..
  mifontGreen..'  allOff - '..mifontYellow..'Sets mobinfo to all values on\n'..
  mifontGreen..'  minimal - '..mifontYellow..'Sets mobinfo to minimal values\n';

-- Configs
function miDefaultConfig()
    MobInfoConfig.ShowClass = 1;
    MobInfoConfig.ShowHealth = 1;
    MobInfoConfig.ShowDamage = 1;
    MobInfoConfig.ShowKills = 0;
    MobInfoConfig.ShowLoots = 1;
    MobInfoConfig.ShowEmpty = 0;
    MobInfoConfig.ShowXp = 1;
    MobInfoConfig.ShowNo2lev = 1;
    MobInfoConfig.ShowQuality = 1;
    MobInfoConfig.ShowCloth = 1;
    MobInfoConfig.ShowCoin = 0;
    MobInfoConfig.ShowIV = 0;
    MobInfoConfig.ShowTotal = 1;
    MobInfoConfig.ShowCombined = 0;
end
function miAllConfig()
    MobInfoConfig.ShowHealth = 1;
    MobInfoConfig.ShowClass = 1;
    MobInfoConfig.ShowKills = 1;
    MobInfoConfig.ShowDamage = 1;
    MobInfoConfig.ShowXp = 1;
    MobInfoConfig.ShowNo2lev = 1;
    MobInfoConfig.ShowLoots = 1;
    MobInfoConfig.ShowEmpty = 1;
    MobInfoConfig.ShowCoin = 1;
    MobInfoConfig.ShowIV = 1;
    MobInfoConfig.ShowTotal = 1;
    MobInfoConfig.ShowQuality = 1;
    MobInfoConfig.ShowCloth = 1;
    MobInfoConfig.ShowCombined = 1;
end
function miNoneConfig()
    MobInfoConfig.ShowHealth = 0;
    MobInfoConfig.ShowClass = 0;
    MobInfoConfig.ShowKills = 0;
    MobInfoConfig.ShowDamage = 0;
    MobInfoConfig.ShowXp = 0;
    MobInfoConfig.ShowNo2lev = 0;
    MobInfoConfig.ShowLoots = 0;
    MobInfoConfig.ShowEmpty = 0;
    MobInfoConfig.ShowCoin = 0;
    MobInfoConfig.ShowIV = 0;
    MobInfoConfig.ShowTotal = 0;
    MobInfoConfig.ShowQuality = 0;
    MobInfoConfig.ShowCloth = 0;
    MobInfoConfig.ShowCombined = 0;
end
function miMinimalConfig()
    MobInfoConfig.ShowHealth = 1;
    MobInfoConfig.ShowClass = 1;
    MobInfoConfig.ShowKills = 0;
    MobInfoConfig.ShowDamage = 0;
    MobInfoConfig.ShowXp = 0;
    MobInfoConfig.ShowNo2lev = 1;
    MobInfoConfig.ShowLoots = 0;
    MobInfoConfig.ShowEmpty = 0;
    MobInfoConfig.ShowCoin = 0;
    MobInfoConfig.ShowIV = 0;
    MobInfoConfig.ShowTotal = 1;
    MobInfoConfig.ShowQuality = 0;
    MobInfoConfig.ShowCloth = 0;
    MobInfoConfig.ShowCombined = 0;
end


-----------------------------------------------------------------------------
-- MI2_SlashInit()
--
-- Add all Slash Commands
-----------------------------------------------------------------------------
function MI2_SlashInit()
  SlashCmdList["MOBINFO"] = MI2_SlashParse;
  SLASH_MOBINFO1 = "/mobinfo2"; 
  SLASH_MOBINFO2 = "/mi2"; 
  
  if  MobInfoConfig.DisableHealth < 2  then
	SlashCmdList["MOBHEALTH2"] = MI2_MobHealth_CMD;
	SLASH_MOBHEALTH21 = "/mobhealth2";
  end

  MI2_SLASH_OPT["showclass"] = "ShowClass";
  MI2_SLASH_OPT["showhealth"] = "ShowHealth";
  MI2_SLASH_OPT["showdamage"] = "ShowDamage";
  MI2_SLASH_OPT["showcombined"] = "ShowCombined";
  MI2_SLASH_OPT["showkills"] = "ShowKills";
  MI2_SLASH_OPT["showloots"] = "ShowLoots";
  MI2_SLASH_OPT["showempty"] = "ShowEmpty";
  MI2_SLASH_OPT["showxp"] = "ShowXp";
  MI2_SLASH_OPT["showno2lev"] = "ShowNo2lev";
  MI2_SLASH_OPT["showquality"] = "ShowQuality";
  MI2_SLASH_OPT["showcloth"] = "ShowCloth";
  MI2_SLASH_OPT["showcoin"] = "ShowCoin";
  MI2_SLASH_OPT["showiv"] = "ShowIV";
  MI2_SLASH_OPT["showtotal"] = "ShowTotal";
  MI2_SLASH_OPT["showblanklines"] = "ShowBlankLines";
  MI2_SLASH_OPT["saveallvalues"] = "SaveAllValues";
  MI2_SLASH_OPT["combinedmode"] = "CombinedMode";
  MI2_SLASH_OPT["keypressmode"] = "KeypressMode";
  MI2_SLASH_OPT["clearonexit"] = "ClearOnExit";
  MI2_SLASH_OPT["disablehealth"] = "DisableHealth";
  MI2_SLASH_OPT["stablemax"] = "StableMax";
  MI2_SLASH_OPT["showpercent"] = "ShowPercent";

  MI2_SLASH_VAL["healthposx"] = "HealthPosX";
  MI2_SLASH_VAL["healthposy"] = "HealthPosY";
  MI2_SLASH_VAL["manadistance"] = "ManaDistance";
  
  MI2_SLASH_OPT["Xallon"] = "AllOn";
  MI2_SLASH_OPT["Xalloff"] = "AllOff";
  MI2_SLASH_OPT["Xminimal"] = "Minimal";
  MI2_SLASH_OPT["Xdefault"] = "Default";
end


-----------------------------------------------------------------------------
-- MI2_SlashParse()
--
-- Parses the msg sent from the option line
-----------------------------------------------------------------------------
function MI2_SlashParse( msg, updateOptions )

  -- extract option and argument from message string
  local _, _, cmd, param = string.find( string.lower(msg), "(%w+)[ ]*([-%w]*)"); 
  if  not cmd  then
    cmd = "";
    param = "";
  end
  
  if  cmd == "help"  then
    chattext(miSlashCommands)
    
  elseif  cmd == ""  or  cmd == "config"  then
    if  frmMIConfig:IsVisible()  then
		  frmMIConfig:Hide();
	  else
		  frmMIConfig:Show();
	  end
	  
  elseif  cmd == "clear"  then
    MobInfoDB = { };
    chattext('MobInfoDB Cleared');
    
  elseif  cmd == 'version'  then
    chattext( miVersion);
    
  elseif  cmd == 'notes'  then
    chattext(miPatchNotes);
    
  elseif  cmd == 'default'  then
    miDefaultConfig();
    chattext('Mobinfo defaults loaded.');
    
  elseif  cmd == 'allon'  then
    miAllConfig();
    chattext('Mobinfo all items on.');
    
  elseif  cmd == 'alloff'  then
    miNoneConfig();
    chattext('Mobinfo all items off.');
    
  elseif  cmd == 'minimal'  then
    miMinimalConfig();
    chattext('Mobinfo minimal items on');
    
  elseif  cmd == 'addcustom'  then
    for c in string.gfind(msg, "addcustom (.+)") do
      if (c ~= nil) then
        if MobInfoConfig.CustomTracks[c]==1 then
         chattext(c .. ' is already added to mobinfo')
        else
         MobInfoConfig.CustomTracks[c]=1;
         chattext(c .. ' has been added to mobinfo tracking');
        end
      end
    end
    
  elseif  cmd == 'removecustom'  then
    for c in string.gfind(msg, "removecustom (.+)") do
      if (c ~= nil) then
        if MobInfoConfig.CustomTracks[c]==1 then
          MobInfoConfig.CustomTracks[c]=nil
          -- go through entire mobinfodb to remove values since they no longer want
          -- it tracked.
          for k, v in MobInfoDB do 
            if MobInfoDB[k][c] then
              MobInfoDB[k][c] = nil
            end
          end
          chattext(c .. ' tracking has been removed from mobinfo')
        else
          chattext(c .. ' could not be found');
        end
      end
    end
    
  elseif  cmd == 'listcustom'  then
    chattext('Mob Info custom tracks:')
    for key, value in MobInfoConfig.CustomTracks do
      chattext(mifontGreen..key);
    end
    
  else
    -- if it wasnt anything else it is either and option or nonsense
    MI2_OptionParse( cmd, param, true );
  end
  
end -- MI2_SlashParse()


-----------------------------------------------------------------------------
-- MI2_OptionParse()
--
-- Parses command to toggle or set one specific option
-- Optionally update the options dialog (if flag set to true)
-----------------------------------------------------------------------------
function MI2_OptionParse( option, param, updateOptions )

  --chattext( "MI_DBG: cmd=["..option.."], param=["..param.."], val=["..(MI2_SLASH_OPT[option] or "<nil>").."]" );

  -- handle all on/off slash option	
  if  MI2_SLASH_OPT[option]  then
    local valTxt = { val0 = "-OFF-" ; val1 = "-ON-" };
    -- get current option value
    local optValue = MobInfoConfig[ MI2_SLASH_OPT[option] ];
    -- toggle option
    optValue = 1 - optValue;
    MobInfoConfig[ MI2_SLASH_OPT[option] ] = optValue;
    chattext( MI2_OPTIONS["MI2_Opt"..MI2_SLASH_OPT[option]].text.." : "..mifontGreen..valTxt["val"..optValue] );
  end

  -- handle all slash commands with value parameter
  if  MI2_SLASH_VAL[option]  and  MobInfoConfig.DisableHealth == 0  then
    -- get option value
    local optValue = tonumber( param ) or 0;
    -- set option value
    MobInfoConfig[ MI2_SLASH_VAL[option] ] = optValue;
    if  updateOptions  then
      chattext( MI2_OPTIONS["MI2_Opt"..MI2_SLASH_VAL[option]].text.." : "..mifontGreen..optValue );
    end
  end

  if  option == 'default'  then
    miDefaultConfig();
    updateOptions = true;
    chattext('Mobinfo defaults loaded.');
  elseif  option == 'allon' then
    miAllConfig();
    updateOptions = true;
    chattext('Mobinfo all items on.');
  elseif  option == 'alloff'  then
    miNoneConfig();
    updateOptions = true;
    chattext('Mobinfo all items off.');
  elseif  option == 'minimal'  then
    miMinimalConfig();
    updateOptions = true;
    chattext('Mobinfo minimal items on');
  end
 
   -- special treatment for enable/disable of entire health frame
  if  MobInfoConfig.DisableHealth == 0  and not MI2_MobHealthFrame:IsShown()  then
    MI2_MobHealthFrame:Show();
    MI2_UpdateOptions();
  elseif  MobInfoConfig.DisableHealth == 1  and  MI2_MobHealthFrame:IsShown()  then
    MI2_MobHealthFrame:Hide();
    MI2_UpdateOptions();
  end
  
  -- update position of health / mana texts
  MI2_MobHealth_SetPos();
  
  -- update options dialog if shown and if requested
  if  frmMIConfig:IsVisible()  and  updateOptions  then
    MI2_UpdateOptions();
  end
    
end  -- MI2_OptionParse()

