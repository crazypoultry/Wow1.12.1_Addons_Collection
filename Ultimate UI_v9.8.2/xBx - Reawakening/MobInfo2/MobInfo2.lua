 
--
-- MobInfo2.lua
--
-- Main module of MobInfo-2 AddOn
-- for version information see MobInfoSlash.lua
--

-- global vars
local lMi2GameTooltip_OnEvent_Orig;

local lMobInfo, lCurTarget;
local lLastTarget;
local lLastRecordedKill = "";
local lLastLooted = "";
local lLastLoot1 = "";
local lLastLoot2 = "";
local lLastLootNum = 1;
local lPlayer, lPlayerLevel;
local lmiVarLoaded;
local lMiHealthLine = 0;
local lMiMouseoverIndex = "";
local lEventHandlers = {};

local lFetch_Timer=0
local lFetch_Done=nil
local lMiDebug = 0;  -- 0=no debug info, 1=minimal debug info, 2=extensive debug info, 3=more extensive+event info


-----------------------------------------------------------------------------
-- ShowMIOptions()
--
-- toggles the options panel... -nathamx
-----------------------------------------------------------------------------
function ShowMIOptions()
	if( frmMIConfig:IsVisible() )  then
		frmMIConfig:Hide();
	else
		frmMIConfig:Show();
	end
end



-----------------------------------------------------------------------------
-- chattext()
--
-- spits out msg to the chat channel. used in debuging
-----------------------------------------------------------------------------
function chattext(txt)
  if( DEFAULT_CHAT_FRAME ) then
    DEFAULT_CHAT_FRAME:AddMessage(txt);
  end
end  -- of chattext()


-----------------------------------------------------------------------------
-- MI2_CheckForSeparateMobHealth()
--
-- Detect the presence of separate MobHelath AddOns and disable the internal
-- MobHealth functionality if found
-----------------------------------------------------------------------------
function MI2_CheckForSeparateMobHealth()
  if  MobHealth_OnLoad  then
      if  MobInfoConfig.DisableHealth ~= 2  then
        MobInfoConfig.DisableHealth = 2;
        UIErrorsFrame:AddMessage("MobInfo WARNING: Separate MobHealth AddOn found. The internal MobHealth functionality is disabled until the separate MobHealth AddOn is removed.", 0.0, 1.0, 1.0, 1.0, 30 );
      end
  else
    if  MobInfoConfig.DisableHealth == 2  then
      MobInfoConfig.DisableHealth = 0;
    end
  end
end  -- MI2_CheckForSeparateMobHealth


-----------------------------------------------------------------------------
-- MobInfo_Initialize()  
--
-- Main Entry point to frame.. see mobinfo.xml
-----------------------------------------------------------------------------
function MobInfo_Initialize()  

  -- initialize MobInfoConfig
  if  not MobInfoConfig  or  not MobInfoConfig.ShowLoots  then	
    MobInfoConfig = { };  
    MobInfoConfig.CustomTracks = {};
    miAllConfig();
    miDefaultConfig();  
  end  

  -- new values still lacking on some installations
  if not MobInfoConfig.SaveAllValues  then  MobInfoConfig.SaveAllValues = 1;   end
  if not MobInfoConfig.ShowBlankLines then  MobInfoConfig.ShowBlankLines = 1;  end
  if not MobInfoConfig.ClearOnExit    then  MobInfoConfig.ClearOnExit = 0;     end

  -- new config values since 1.7
  if not MobInfoConfig.ShowDamage    then  MobInfoConfig.ShowDamage = 1;     end
  if not MobInfoConfig.ShowEmpty     then  MobInfoConfig.ShowEmpty = 0;      end
  if not MobInfoConfig.CombinedMode  then  MobInfoConfig.CombinedMode = 0;   end
  if not MobInfoConfig.ShowCombined  then  MobInfoConfig.ShowCombined = 1;   end
  if not MobInfoConfig.KeypressMode  then  MobInfoConfig.KeypressMode = 0;   end
  if not MobInfoConfig.ShowPercent   then  MobInfoConfig.ShowPercent = 1;    end
  if not MobInfoConfig.HealthPosX    then  MobInfoConfig.HealthPosX = -7;    end
  if not MobInfoConfig.HealthPosY    then  MobInfoConfig.HealthPosY = 11;    end
  if not MobInfoConfig.ManaDistance  then  MobInfoConfig.ManaDistance = -11; end
  if not MobInfoConfig.DisableHealth then  
    MobInfoConfig.DisableHealth = (MobInfoConfig.HealthOff or 0);
    MobInfoConfig.HealthOff     = nil;
  end
  
  -- initialize MobHealth if not disabled
  if  MobInfoConfig.DisableHealth < 2  then
    MI2_MobHealth_VariablesLoaded();
  end

  -- MobHealth option compatibility
  if  not MobInfoConfig.StableMax  then
    if  MobHealthConfig["unstablemax"]  then
      MobInfoConfig.StableMax = 0;
    else
      MobInfoConfig.StableMax = 1;
    end
  end

  -- clear MobInfo DB if it does not exist or if started with "ClearOnExit" set
  if  not MobInfoDB  or  MobInfoConfig.ClearOnExit == 1  then
  	MobInfoDB = { };
  end

  -- hook 
  lMi2GameTooltip_OnEvent_Orig = GameTooltip:GetScript("OnEvent");
  GameTooltip:SetScript( "OnEvent", MI2_GameTooltip_OnEvent );

  -- Register with myAddons mod
  if(myAddOnsFrame) then
    myAddOnsList.MobInfo = {
      name = "MobInfo-2",
      description = MI_DESCRIPTION,
      version = miVersionNo,
      category = MYADDONS_CATEGORY_OTHERS,
      frame = "MI2_MobInfoFrame",
      optionsframe = "frmMIConfig" };
  end

  -- obtain player name and realm name  
  local playerName=UnitName("player")
  local realm  = GetCVar( "realmName" );
  lPlayerLevel = UnitLevel( "player" );
  lPlayer = realm..':'..playerName;

  -- check for presence of separate interferring MobHealth AddOns
  -- initialize slash commands processing
  -- initialize options processing
  MI2_CheckForSeparateMobHealth();
  MI2_SlashInit();	

  -- hide MobHealth frame if MobHealth is disabled
  if  MobInfoConfig.DisableHealth > 0  then
    MI2_MobHealthFrame:Hide();
  end
  
  -- update position of health / mana values
  MI2_MobHealth_SetPos(0);

  -- ensure that MobHealthFrame get set correctly (if we have to set it for compatibility)
  if  MobHealthFrame == "MI2"  then
    MobHealthFrame = MI2_MobHealthFrame;
  end
      
  -- chattext("MobInfo-2 "..miVersionNo.." Loaded. http://dizzarian.com ".. mifontGreen..'/mobinfo2 or /mi2 for help');
end  -- of MobInfo_Initialize()


-----------------------------------------------------------------------------
-- Retrieves mob xp from MobInfoDb
-----------------------------------------------------------------------------
function GetMobXP(index)
  if MobInfoDB[index] then
    if not UnitIsFriend("player","target") then 
      if MobInfoDB[index].xp then
        return MobInfoDB[index].xp;
      end
    end
  end
  return 0;
end


-----------------------------------------------------------------------------
-- Retrieves mob kills from MobInfoDb
-----------------------------------------------------------------------------
function GetMobKills(index)
  if MobInfoDB[index] then
    if not UnitIsFriend("player","target") then 
      if MobInfoDB[index][lPlayer] then
        if MobInfoDB[index][lPlayer].kl then
          return MobInfoDB[index][lPlayer].kl;
        end
      end
    end
  end
  return 0;
end


-----------------------------------------------------------------------------
-- Retrieves # of times you looted the mob from MobInfoDb
-----------------------------------------------------------------------------
function GetMobLoots(index)
  if MobInfoDB[index] then
    if not UnitIsFriend("player","target") then 
      if MobInfoDB[index].lt then
        return MobInfoDB[index].lt;
      end
    end
  end
  return 0;
end


-----------------------------------------------------------------------------
-- Retrieves mob gold from MobInfoDb
-----------------------------------------------------------------------------
function GetMobCopper(index)
  if MobInfoDB[index] then
    if not UnitIsFriend("player","target") then 
      if MobInfoDB[index].cp then
        return MobInfoDB[index].cp;
      end
    end
  end
  return 0;
end


-----------------------------------------------------------------------------
-- Retrieves mob Item Value from MobInfoDb
-----------------------------------------------------------------------------
function GetMobIV(index)
  if MobInfoDB[index] then
    if not UnitIsFriend("player","target") then 
      if MobInfoDB[index].iv then
        return MobInfoDB[index].iv;
      end
    end
  end
  return 0;
end


-----------------------------------------------------------------------------
-- Retrieves mob Item Value from MobInfoDb
-----------------------------------------------------------------------------
function GetMobRarity(index, rareIndex)
  if MobInfoDB[index] then
    if not UnitIsFriend("player","target") then
      if MobInfoDB[index].r0 and rareIndex==1 then
        return MobInfoDB[index].r0;
      end
      if MobInfoDB[index].r1 and rareIndex==2 then
        return MobInfoDB[index].r1;
      end
      if MobInfoDB[index].r2 and rareIndex==3 then
        return MobInfoDB[index].r2;
      end
      if MobInfoDB[index].r3 and rareIndex==4 then
        return MobInfoDB[index].r3;
      end
      if MobInfoDB[index].r4 and rareIndex==5 then
        return MobInfoDB[index].r4;
      end
    end
  end
  return 0;
end


-----------------------------------------------------------------------------
-- GetMobCloth()
--
-- Get cloth loot counter for Mob
-----------------------------------------------------------------------------
function GetMobCloth(index)
  if MobInfoDB[index] then
    if not UnitIsFriend("player","target") then 
      if MobInfoDB[index].cc then
        return MobInfoDB[index].cc;
      end
    end
  end
  return 0;
end  -- of GetMobCloth()


-----------------------------------------------------------------------------
-- GetMobCustom()
--
-- Get custom tracked item
-----------------------------------------------------------------------------
function GetMobCustom(index, item)
  if MobInfoDB[index] then
    if not UnitIsFriend("player","target") then 
      if MobInfoDB[index][item] then
        return MobInfoDB[index][item];
      end
    end
  end
  return 0;
end  -- of GetMobCustom()


-----------------------------------------------------------------------------
-- Add custom tracked item
-----------------------------------------------------------------------------
function MobInfoDbSetCustom(index, customitem, amt)
  if index then
    if MobInfoDB[index] == nil then
      MobInfoDB[index] = { };
      MobInfoDB[index][customitem] = 0;
    end 

    local c = GetMobCustom(index, customitem);
    if (c + amt) > 0 then
      MobInfoDB[index][customitem] = (c + amt);      
    else
      MobInfoDB[index][customitem] = 0;
    end       
  end
end;


-----------------------------------------------------------------------------
-- MI2_MobDbCheck()
--
-- check if given Mob exists in DB, create a new Mob record in DB if not
-----------------------------------------------------------------------------
local function MI2_MobDbCheck( index, playerName )

  if MobInfoDB[index] == nil then
    MobInfoDB[index] = { };
    if lMiDebug > 0 then chattext( "MI_DBG : creating new DB record for ["..index.."]" ); end
  end  
    
  if  MobInfoDB[index][playerName] == nil  then
    MobInfoDB[index][playerName] = { };
  end
end  -- of MI2_MobDbCheck()


-----------------------------------------------------------------------------
-- MI2_RecordDamage()
--
-- record damage value for a mob
-----------------------------------------------------------------------------
local function MI2_RecordDamage( index, creatureName, damage )

  -- check: mob must eb current target, damage value must be > 0
  if  creatureName ~= lCurTarget.name  or  damage < 1  then
    return;
  end
  
  -- ensure that Mob is in DB (create new entry if new Mob)
  MI2_MobDbCheck( index, lPlayer );
  
  if lMiDebug > 1 then chattext( "MI_DBG : damage reported: mob=["..index.."], dmg="..damage ); end
  
  if MobInfoDB[index][lPlayer].dl then
    -- if mob already has recorded dmg check and set min/max
    if damage < MobInfoDB[index][lPlayer].dl then
      if lMiDebug > 0 then chattext( "MI_DBG : recording new MIN dmg "..damage.." for ["..index.."] (old="..MobInfoDB[index][lPlayer].dl..")" ); end
      MobInfoDB[index][lPlayer].dl = damage;
    else
      if damage > MobInfoDB[index][lPlayer].du then
        if lMiDebug > 0 then chattext( "MI_DBG : recording new MAX dmg "..damage.." for ["..index.."] (old="..MobInfoDB[index][lPlayer].du..")" ); end
        MobInfoDB[index][lPlayer].du = damage;
      end
    end
  else
    -- mob has no recorded dmg: create min/max dmg entries
    MobInfoDB[index][lPlayer].dl = damage;
    MobInfoDB[index][lPlayer].du = damage;
  end
end  -- of MI2_RecordDamage()


-----------------------------------------------------------------------------
-- MI2_RecordKill()
--
-- record one kill for the given mob / player
-- problem : WoW will often generate 2 kill messages per Mob : one with
-- XP and one without XP, this dow not not happen every time, but when
-- it happens the msg without XP is generated before the message with XP
-----------------------------------------------------------------------------
local function MI2_RecordKill( index, playerName, xp )
  -- ensure that Mob is in DB (create new entry if new Mob)
  MI2_MobDbCheck( index, playerName );

  -- record the XP value if option set
  if  xp > 0  and  (MobInfoConfig.SaveAllValues == 1 or MobInfoConfig.ShowXp == 1)  then
    if  MobInfoDB[index].xp ~= xp then
      if lMiDebug > 0 then chattext( "MI_DBG : recording XP "..xp.." for mob ["..index.."]" ); end
    end
    MobInfoDB[index].xp = xp;
  end
    
  -- exit at this point if recording of kills is disabled
  if  MobInfoConfig.SaveAllValues ~= 1  and  MobInfoConfig.ShowKills == 0  then
    return;
  end
  
  -- only count kill if it is a new kill
  if  xp <= 0  or index ~= lLastRecordedKill  then
    -- if kill count exists increment it by 1, if not initialise it to 1
    if  MobInfoDB[index][playerName].kl  then
      MobInfoDB[index][playerName].kl = MobInfoDB[index][playerName].kl + 1;
    else
      MobInfoDB[index][playerName].kl = 1;
    end
    if lMiDebug > 0 then chattext( "MI_DBG : recording mob kill for ["..index.."]" ); end
  end
end  -- of MI2_RecordKill()


-----------------------------------------------------------------------------
-- MobInfoDbSet()
--
-- Add given values for the selected mob
-----------------------------------------------------------------------------
local function MobInfoDbSet(index, copper, itemvalue, loots, rareIndex, clothdrop, emptyloots )

  -- ensure that Mob is in DB (create new entry if new Mob)
  MI2_MobDbCheck( index, lPlayer );
    
    if copper and copper ~= 0 then
      if (MobInfoConfig.SaveAllValues == 1) or (MobInfoConfig.ShowCoin == 1) then
        local c = GetMobCopper(index);
        MobInfoDB[index].cp = c + copper;
      end
    end

    if itemvalue and itemvalue  > 0 then
      if (MobInfoConfig.SaveAllValues == 1) or (MobInfoConfig.ShowIV == 1) then
        local iv = GetMobIV(index);
        if (iv + itemvalue) > 0 then
          MobInfoDB[index].iv = iv + itemvalue; 
        else
          MobInfoDB[index].iv = 0;
        end        
      end
    end

    if loots and loots > 0 then
      local l = GetMobLoots(index); 
      MobInfoDB[index].lt = l + loots;   
    end
    
    if  emptyloots  and emptyloots > 0  then
      if MobInfoConfig.SaveAllValues == 1 or MobInfoConfig.ShowEmpty == 1 then
        if not MobInfoDB[index].el then
          MobInfoDB[index].el = 0;
        end
        MobInfoDB[index].el = MobInfoDB[index].el + 1;
      end
    end

    if rareIndex then
      if (MobInfoConfig.SaveAllValues == 1) or (MobInfoConfig.ShowQuality == 1) then
        local rn = GetMobRarity(index, rareIndex);
        if rareIndex == 1 then 
          MobInfoDB[index].r0 = rn + 1;
        elseif rareIndex == 2 then
          MobInfoDB[index].r1 = rn + 1;
        elseif rareIndex == 3 then
          MobInfoDB[index].r2 = rn + 1;
        elseif rareIndex == 4 then
          MobInfoDB[index].r3 = rn + 1;
        elseif rareIndex == 5 then
          MobInfoDB[index].r4 = rn + 1;
        end
      end
    end

    if clothdrop ~= nil and clothdrop ~= 0 then
      if (MobInfoConfig.SaveAllValues == 1) or (MobInfoConfig.ShowCloth == 1) then
        local cd = GetMobCloth(index);
        MobInfoDB[index].cc = cd + clothdrop;
      end
    end

    -- clean up from previous versions
    if MobInfoDB[index].class then
      MobInfoDB[index].class = nil;
    end    
end  -- of MobInfoDbSet()


-----------------------------------------------------------------------------
-- Clean the SavedVariables list up
-----------------------------------------------------------------------------
function miCleanSV(index)
  -- Upgrade any old keys to the new shorter version
  if MobInfoDB[index] then
    if MobInfoDB[index].itemvalue then
      MobInfoDB[index].iv = MobInfoDB[index].itemvalue;
      MobInfoDB[index].itemvalue = nil;
    end
    if MobInfoDB[index].copper then
      MobInfoDB[index].cp = MobInfoDB[index].copper;
      MobInfoDB[index].copper = nil;
    end
    if MobInfoDB[index][lPlayer] then
      if MobInfoDB[index][lPlayer].kills then
        MobInfoDB[index][lPlayer].kl = MobInfoDB[index][lPlayer].kills;
        MobInfoDB[index][lPlayer].kills = nil;
      end
    end
    if MobInfoDB[index].loots then
      MobInfoDB[index].lt = MobInfoDB[index].loots;
      MobInfoDB[index].loots = nil;
    end  
    if MobInfoDB[index].clothcnt then
      MobInfoDB[index].cc = MobInfoDB[index].clothcnt;
      MobInfoDB[index].clothcnt = nil;
    end
  end

  -- delete any unused keys if the user has save all values off  
  if MobInfoConfig.SaveAllValues == 0 then
    if MobInfoDB[index] then
      
      if MobInfoConfig.ShowNo2lev == 0 then -- not saved in sv
        if MobInfoConfig.ShowXp == 0 then -- can only remove it if show no2level is off also
          if MobInfoDB[index].xp then MobInfoDB[index].xp = nil end
          
          if MobInfoConfig.ShowKills == 0 then -- can only remove if the previous 2 are off
            if MobInfoDB[index][lPlayer].kl then MobInfoDB[index][lPlayer].kl = nil end 
          end
        end
      end

      if MobInfoConfig.ShowTotal == 0 then -- not saved in sv
        if MobInfoConfig.ShowCoin == 0 then -- can only remove it if show total is off also
          if MobInfoDB[index].cp then MobInfoDB[index].cp = nil end
        end
        if MobInfoConfig.ShowIV == 0 then -- can only remove if show total is also off
          if MobInfoDB[index].iv then MobInfoDB[index].iv = nil end
        end
      end

      if MobInfoConfig.ShowQuality == 0 then
        if MobInfoDB[index].r0 then MobInfoDB[index].r0 = nil end
        if MobInfoDB[index].r1 then MobInfoDB[index].r1 = nil end
        if MobInfoDB[index].r2 then MobInfoDB[index].r2 = nil end
        if MobInfoDB[index].r3 then MobInfoDB[index].r3 = nil end
        if MobInfoDB[index].r4 then MobInfoDB[index].r4 = nil end
      end

      if MobInfoConfig.ShowCloth == 0 then
        if MobInfoDB[index].cc then MobInfoDB[index].cc = nil end
      end

      if MobInfoConfig.ShowEmpty == 0 then
        if MobInfoDB[index].el then MobInfoDB[index].el = nil end
      end

      if MobInfoConfig.ShowDamage == 0 then
        if MobInfoDB[index][lPlayer].dl then MobInfoDB[index][lPlayer].dl = nil end
        if MobInfoDB[index][lPlayer].du then MobInfoDB[index][lPlayer].du = nil end
      end

      -- To turn off loots all the loot stuff must be turned off
      if  MobInfoConfig.ShowTotal == 0 and
          MobInfoConfig.ShowCoin == 0 and
          MobInfoConfig.ShowIV == 0 and
          MobInfoConfig.ShowCloth == 0 and
          MobInfoConfig.ShowLoots == 0 then
        if MobInfoDB[index].lt then MobInfoDB[index].lt = nil end
      end      
    end
  end
end


-----------------------------------------------------------------------------
-- MI2_GetMobHealthStr()
--
-- Returns the mobhealth in the form of xx/xx from the mobdb formed by
-- MobHealth mod Pulled from Telo's MobHealth
-----------------------------------------------------------------------------
local function MI2_GetMobHealthStr( index, healthPercent )
  if not UnitIsFriend("player","mouseover") then    
    local pointsPerPct = MobHealth_PPP( index );
    local currentPct = healthPercent;
	  if( pointsPerPct > 0 ) then	
		  if( currentPct ) then
			  return string.format("%d/%d", (currentPct * pointsPerPct) + 0.5, (100 * pointsPerPct) + 0.5);
		  else
			  return string.format("???/%d", (100 * pointsPerPct) + 0.5);
		  end
      end
  end
  return nil;
end  -- of MI2_GetMobHealthStr()


-----------------------------------------------------------------------------
-- Turns a full copper amount to a readable string.  10340 = 1g 3s 40c
-----------------------------------------------------------------------------
function copper2text(copper)
  local g,s,c;
		
	g = floor(copper / COPPER_PER_GOLD);
	s = floor(copper / COPPER_PER_SILVER) - g * SILVER_PER_GOLD;
	c = copper - g * COPPER_PER_GOLD - s * COPPER_PER_SILVER;

  if g ~= 0 then  
  	return mifontWhite..g..mifontYellow..'g '..mifontWhite..s ..mifontSubWhite..'s '..mifontWhite..c..mifontGold..'c ';
  end  
  if s ~= 0 then  
  	return mifontWhite..s ..mifontSubWhite..'s '..mifontWhite..c..mifontGold..'c ';
  end  
  if c ~= 0 then  
  	return mifontWhite..c..mifontGold..'c ';
  end
end


-----------------------------------------------------------------------------
-- lootName2Copper()
--
-- Turns a lootname like 1 Gold 3 Silver 40 Copper to total copper 10340
-----------------------------------------------------------------------------
function lootName2Copper(item)
  local i = 0;
  local g,s,c = 0;
  
  i = string.find(item, MI_TXT_GOLD  );
  if i then
    g = string.sub(item,0,i-1);
    item = string.sub(item,i+5,string.len(item));
  end
  i = 0;
  i = string.find(item, MI_TXT_SILVER );
  if i then
    s = string.sub(item,0,i-1);
    item = string.sub(item,i+7,string.len(item));
  end
  i = 0;
  i = string.find(item, MI_TXT_COPPER );
  if i then
    c = string.sub(item,0,i-1);
  end

  local money = 0;
  if c then
		money = money + c;
	end
	if s then
		money = money + (s * COPPER_PER_SILVER);
	end
	if g then
		money = money + (g * COPPER_PER_GOLD);
	end

  return money;
end  -- of lootName2Copper(


-----------------------------------------------------------------------------
-- Find the item value in either the Auctioneer database or in out own copy
-- of the Auctioneer item value database
-----------------------------------------------------------------------------
function FindItemValue( itemID )
  local itemValue = 0;
  
  -- check whether we have to use our own copy of the Auctioneer item value
  -- database because the Auctioneer AddOn is not installed
  if Auctioneer_BasePrices  == nil and MobInfo_Auctioneer_BasePrices == nil then
    if lMiDebug > 0 then chattext( "MI_DBG : loading MOBINFO item sell value table" ); end
    MobInfo_Auctioneer_BuildBaseData();
  end
  
  -- check if Auctioneer is installed and knows the price
  if Auctioneer_BasePrices 
       and Auctioneer_BasePrices[itemID] 
       and Auctioneer_BasePrices[itemID].s then 
    return Auctioneer_BasePrices[itemID].s;
  end
  
  -- check if our own copy of the Auctioneer prices knows the item price
  if MobInfo_Auctioneer_BasePrices 
       and MobInfo_Auctioneer_BasePrices[itemID] 
       and MobInfo_Auctioneer_BasePrices[itemID].s then 
    return MobInfo_Auctioneer_BasePrices[itemID].s;
  end

  return 0;  
end


-----------------------------------------------------------------------------
-- GetLootId()
--
-- get loot ID code for given loot slot number
--
-----------------------------------------------------------------------------
local function GetLootId( slot )

  local idNumber = 0;

  local link = GetLootSlotLink( slot );
  if link then
    local d1, d2, idCode = string.find(link, "|Hitem:(%d+):(%d+):(%d+):");
    idNumber = tonumber( idCode or 0 );
  end
  
  return idNumber;
end  -- of GetLootId()
  

-----------------------------------------------------------------------------
-- MI2_GetCorpseId()
--
-- create a (hopefully) unique corpse ID out of the loot items found in 
-- the corpse loot window
-----------------------------------------------------------------------------
local function MI2_GetCorpseId( index )
  local corpseId = index;
  local numItems = 0;
  
  for slot = 1, GetNumLootItems(), 1 do
    -- obtain loot slot data from WoW
    local texture, item, quantity, quality = GetLootSlotInfo( slot );
    if  item ~= ""  then
      corpseId = corpseId.."_"..item;
      numItems = numItems + 1;
    end
  end
  
  return corpseId..numItems;
end -- of CheckForLastLoot()
  

-----------------------------------------------------------------------------
-- CheckForLastLoot()
--
-- check if the current open corpse is identical to the last opened corpse
-- return true if both are identical
-----------------------------------------------------------------------------
local function CheckForLastLoot( index )
  -- create corpse ID
  local corpseId = MI2_GetCorpseId( index );
  
  if lMiDebug > 1 then chattext( "MI_DBG : corpseId=["..corpseId.."], last1=["..lLastLoot1.."], last2=["..lLastLoot2.."]" ); end
  
  -- check for identical last loot and reset last loot buffer
  local isLastLoot =  corpseId == lLastLoot1  or  corpseId == lLastLoot2;
  
  if not isLastLoot then
    if lLastLootNum == 1 then
      lLastLoot1 = corpseId;
      lLastLootNum = 2;
    else
      lLastLoot2 = corpseId;
      lLastLootNum = 1;
    end
  end
  
  return isLastLoot;
end -- of CheckForLastLoot()
  

-----------------------------------------------------------------------------
-- MI2_CorpseOpened()
--
-- a corpse has been opened: increment loot counter and process all loot items
-----------------------------------------------------------------------------
local function MI2_CorpseOpened( index )

  local skin = 0; -- to detect whether its a skinning loot window
  
  if lMiDebug > 0 then chattext( "MI_DBG : corpse opened for : ["..index.."], numItems="..GetNumLootItems() ); end
 
  -- compare this loot to the last recorded Mob loot
  -- dont process this loot if its identical to last loot stored
  if CheckForLastLoot(index) then
    if lMiDebug > 0 then chattext( "MI_DBG : loot REOPEN detected" ); end
    return 0;
  end
  
  for slot = 1, GetNumLootItems(), 1 do
    local cloth  = 0;
    local iv     = 0;
    local copper = 0;

    -- obtain loot slot data from WoW
    local link = GetLootSlotLink( slot );
    local texture, item, quantity, quality = GetLootSlotInfo( slot );
    
    -- if we find skinning loot we do not increment the "looted" counter
    if  miSkinLoot[item]  and  slot == 1  then
      skin = 1;
    end

    -- process custom tracking items
    if MobInfoConfig.CustomTracks[item] then
      MobInfoDbSetCustom(index,item,quantity);
    end;

    -- check for cloth loot items
    if miClothLoot[item] then
      cloth = 1;
    end
  
    -- calculate value of coin loot
    if LootSlotIsCoin(slot) then
      copper = lootName2Copper(item);
      quality = -1;
    end
    
    -- calculate value of item loot, dont count qulity for items without value
    local itemID = GetLootId( slot );
    if LootSlotIsItem(slot) then
      iv = FindItemValue( itemID );
      if  iv <= 0 then
      quality = -1;
      end
    end
    
    -- add loot item data to MobInfoDB
    MobInfoDbSet( index, copper, iv, 0, quality+1, cloth );
    if lMiDebug > 1 then chattext( "MI_DBG : Loot: slot="..slot..", name=["..item.."], id=["..itemID.."], val=["..iv.."], q=["..(quality+1).."]" ); end
  end  -- of for loop
  
  -- add loot count to mob if its not a skinning loot
  if  skin == 0 then
    MobInfoDbSet(index,0,0,1);  -- add a loot to the mob
  end
end -- of MI2_CorpseOpened()  


-----------------------------------------------------------------------------
-- MI2_EventLootOpened()
--
-- WoW event notification that loot screen has been opened or closed
-----------------------------------------------------------------------------
local function MI2_EventLootOpened( )

  if lCurTarget  and  GetNumLootItems() > 0  then
    local index = lCurTarget.index;
    lLastLooted = index;

    -- process loot when opening a corpse we killed
    if UnitIsDead("target")  and UnitCreatureType("target") 
       and not UnitIsPlayer("target") 
       and not UnitIsFriend("player","target")
    then 
      MI2_CorpseOpened( index );
      return 0;
    end
  end
end  -- end of function MI2_EventLootOpened()


-----------------------------------------------------------------------------
-- MI2_EventLootClosed()
--
-- WoW event notification that loot screen has been closed
-- we use this event to detect empty loots : empty loots are loots where
-- no previous"LOOT_OPENED" has been recorded
-----------------------------------------------------------------------------
local function MI2_EventLootClosed( )

  if  lCurTarget  then
    local index = lCurTarget.index;
    if lMiDebug > 1 then chattext( "MI_DBG : loot closed : lastLoot=["..index.."], numItems="..GetNumLootItems() ); end
  
    if  lLastLooted == ""  then
      MobInfoDbSet( index,0,0,1,0,0,1 );  -- add a loot and emptyloot to the mob
      if lMiDebug > 0 then chattext( "MI_DBG : recording empty loot for ["..lLastTarget.."]" ); end
    end
  end
  
  lLastLooted = "";
end  -- end of function MI2_EventLootOpened(event)


-----------------------------------------------------------------------------
-- MI2_EventLootSlotCleared()
--
-- WoW event notification that one loot item has been looted
-----------------------------------------------------------------------------
local function MI2_EventLootSlotCleared( )
  local corpseId ="-";

  -- create new corpse ID
  if  lCurTarget  then
    corpseId = MI2_GetCorpseId( lCurTarget.index );
  end
  
  if lMiDebug > 1 then chattext( "MI_DBG : looting: id=["..corpseId.."], last1=["..lLastLoot1.."], last2=["..lLastLoot2.."]" ); end
  
  if lLastLootNum == 1 then
    lLastLoot2 = corpseId;
  else
    lLastLoot1 = corpseId;
  end
end  -- of MI2_EventLootSlotCleared


-----------------------------------------------------------------------------
-- MI2_AddDataToTooltip()
--
-- add all collected mob data to the game tooltip, data is only added if
-- corresponding "Show" flag is set
-----------------------------------------------------------------------------
local function MI2_AddDataToTooltip( mobData, mobIndex )
  local showNextBlankLine = false;
  
  if  mobData.class  and  MobInfoConfig.ShowClass == 1  then
    GameTooltip:AddDoubleLine( mifontGold..MI_TXT_CLASS, mifontWhite..mobData.class );
  end
  
  if  mobData.health  and  MobInfoConfig.ShowHealth == 1  then
    GameTooltip:AddDoubleLine( mifontGold..MI_TXT_HEALTH, mifontWhite..mobData.health );
    lMiHealthLine = GameTooltip:NumLines();
  end

  -- exit right here if no mob was added to mob data structure
  if  not mobData.color  then
    return;
  end

  local mobGivesXp = not (mobData.color.r == 0.5  and  mobData.color.g == 0.5  and  mobData.color.b == 0.5);

  if  mobGivesXp and mobData.xp > 0  and  MobInfoConfig.ShowXp == 1  then
    GameTooltip:AddDoubleLine( mifontGold.. "XP ", mifontWhite..mobData.xp );
    showNextBlankLine = true;
  end

  if  mobGivesXp and mobData.mob2Level > 0  and  MobInfoConfig.ShowNo2lev == 1  then
    GameTooltip:AddDoubleLine( mifontGold..MI_TXT_TO_LEVEL, mifontWhite..mobData.mob2Level );
    showNextBlankLine = true;
  end 
    
  if MobInfoConfig.ShowBlankLines == 1 then
    GameTooltip:AddLine("\n");
  end

  if  MobInfoConfig.CombinedMode == 1  and  MobInfoConfig.ShowCombined == 1  then
    GameTooltip:AddLine( mifontWhite.."["..MI_TXT_COMBINED..mobData.combinedStr.."]" );
  end

  if  mobData.kills > 0  and  MobInfoConfig.ShowKills == 1  then 
    GameTooltip:AddDoubleLine( mifontGold..MI_TXT_KILLS, mifontWhite..mobData.kills );
    showNextBlankLine = true;
  end          
    
  if  mobData.loots > 0  and  MobInfoConfig.ShowLoots == 1  then
    GameTooltip:AddDoubleLine( mifontGold..MI_TXT_TIMES_LOOTED, mifontWhite..mobData.loots );
    showNextBlankLine = true;
  end
  
  if  mobData.emptyLoots > 0  and  MobInfoConfig.ShowEmpty == 1  then
    local emptyLootsStr = mifontWhite..mobData.emptyLoots;
    if  mobData.loots > 0  then
      emptyLootsStr = emptyLootsStr.." ("..ceil((mobData.emptyLoots/mobData.loots)*100).."%) "
    end
    GameTooltip:AddDoubleLine( mifontGold..MI_TXT_EMPTY_LOOTS, emptyLootsStr );
    showNextBlankLine = true;
  end
  
  if  mobData.minDamage > 0  and  MobInfoConfig.ShowDamage == 1 then 
    GameTooltip:AddDoubleLine( mifontGold..MI_TXT_DAMAGE, mifontWhite..mobData.minDamage.." - "..mobData.maxDamage );
  end          
  
  if  MobInfoConfig.ShowBlankLines == 1  and  showNextBlankLine  then
    GameTooltip:AddLine("\n");
  end
    
  -- Add custom values
  for key, value in MobInfoConfig.CustomTracks do
    local c = GetMobCustom( mobIndex, key );
    if c > 0 and mobData.loots > 0 then
      GameTooltip:AddDoubleLine(mifontYellow..key,mifontWhite..c.." ("..ceil((c/mobData.loots)*100).."%) ");
    end
  end

  if  mobData.qualityStr ~= ""  and  MobInfoConfig.ShowQuality == 1  then
    GameTooltip:AddDoubleLine(mifontGold..MI_TXT_QUALITY, mobData.qualityStr);
  end
    
  if  mobData.clothcnt > 0  and  MobInfoConfig.ShowCloth == 1  then
    local clothStr = mifontWhite..mobData.clothcnt;
    if  mobData.loots > 0  then
      clothStr = clothStr.." ("..ceil((mobData.clothcnt/mobData.loots)*100).."%) "
    end
    GameTooltip:AddDoubleLine( mifontGold..MI_TXT_CLOTH_DROP, clothStr );
  end

  if  mobData.copper > 0  then
    if  mobData.loots > 0  then
      mobData.copper = ceil( mobData.copper / mobData.loots );
    end
    if  MobInfoConfig.ShowCoin == 1  then
      GameTooltip:AddDoubleLine(mifontGold..MI_TXT_COIN_DROP,mifontWhite..copper2text(mobData.copper));
    end
  end
  
  if  mobData.itemValue > 0  then
    if mobData.loots > 0 then
      mobData.itemValue = ceil( mobData.itemValue / mobData.loots );
    end
    if  MobInfoConfig.ShowIV == 1  then
      GameTooltip:AddDoubleLine(mifontGold..MI_TEXT_ITEM_VALUE,mifontWhite..copper2text(mobData.itemValue));
    end
  end

  local totalValue = mobData.copper + mobData.itemValue;
  if  totalValue > 0  and  MobInfoConfig.ShowTotal == 1  then
    GameTooltip:AddDoubleLine(mifontGold..MI_TXT_MOB_VALUE,mifontWhite..copper2text(totalValue));
  end    

  -----------------------------------------------------------------------
  -- debugging code : append actual database contents to end of tooltip
  -- enabled by setting local vairable "lMiDebug"
  if lMiDebug > 1 then
  GameTooltip:AddLine("\n");
  GameTooltip:AddDoubleLine("[DBG] "..mifontGold.."index",mobIndex);
  if MobInfoDB[mobIndex] and lPlayer then
    local index=mobIndex;
    if MobInfoDB[index].xp then GameTooltip:AddDoubleLine("[DBG] "..mifontGold.."experience(xp)",mifontWhite..MobInfoDB[index].xp); end;
    if MobInfoDB[index].cp then GameTooltip:AddDoubleLine("[DBG] "..mifontGold.."copper(cp)",mifontWhite..MobInfoDB[index].cp); end;
    if MobInfoDB[index].iv then GameTooltip:AddDoubleLine("[DBG] "..mifontGold.."itemvalue(iv)",mifontWhite..MobInfoDB[index].iv); end;
    if MobInfoDB[index].lt then GameTooltip:AddDoubleLine("[DBG] "..mifontGold.."loot(lt)",mifontWhite..MobInfoDB[index].lt); end;
    if MobInfoDB[index].cc then GameTooltip:AddDoubleLine("[DBG] "..mifontGold.."clothcount(cc)",mifontWhite..MobInfoDB[index].cc); end;
    if MobInfoDB[index].el then GameTooltip:AddDoubleLine("[DBG] "..mifontGold.."empty loots(el)",mifontWhite..MobInfoDB[index].el); end;
    GameTooltip:AddDoubleLine("[DBG] "..mifontGold.."quality(rx)",mifontWhite.."("..(MobInfoDB[index].r0 or 0)..","..(MobInfoDB[index].r1 or 0)..","..(MobInfoDB[index].r2 or 0)..","..(MobInfoDB[index].r3 or 0)..","..(MobInfoDB[index].r4 or 0)..")");
    if MobInfoDB[index][lPlayer].kl then GameTooltip:AddDoubleLine("[DBG] "..mifontGold.."kills(kl)",mifontWhite..MobInfoDB[index][lPlayer].kl); end;
    if MobInfoDB[index][lPlayer].dl then GameTooltip:AddDoubleLine("[DBG] "..mifontGold.."damage range min(dl)",mifontWhite..MobInfoDB[index][lPlayer].dl); end;
    if MobInfoDB[index][lPlayer].du then GameTooltip:AddDoubleLine("[DBG] "..mifontGold.."damage range max(du)",mifontWhite..MobInfoDB[index][lPlayer].du); end;
  end end
  -- end of debugging code
  -----------------------------------------------------------------------
end  -- of MI2_AddDataToTooltip()


-----------------------------------------------------------------------------
-- MI2_AddMobToData()
--
-- build mob data structure required for displaying game tooltip
-----------------------------------------------------------------------------
local function MI2_AddMobToData( mobName, mobLevel, mobData  )
  local mobIndex  = mobName..":"..mobLevel;
  
  -- exit here if mob does not exist in DB
  if  not MobInfoDB[mobIndex]  then
    return;
  end
  if lMiDebug > 2 then chattext( "MI_DBG : adding mob to data: name=["..mobName.."], level=["..mobLevel.."]" ); end
  
  mobData.color  = GetDifficultyColor( mobLevel );
  mobData.xp     = GetMobXP( mobIndex );
  
  if mobData.xp > 0 then
    local xpTotal = UnitXPMax("player");
    local xpCurrent = UnitXP("player") + mobData.xp;
    local xpToLevel = xpTotal - xpCurrent;
    mobData.mob2Level = ceil(abs(xpToLevel / mobData.xp))+1;
  end
  
  if  mobData.combinedStr  then
    mobData.combinedStr = mobData.combinedStr..", L"..mobLevel;
  else
    mobData.combinedStr = "L"..mobLevel;
  end
    
  mobData.kills     = mobData.kills + GetMobKills( mobIndex );
  mobData.loots     = mobData.loots + GetMobLoots( mobIndex );
  mobData.clothcnt  = mobData.clothcnt + GetMobCloth( mobIndex );
  mobData.r1        = mobData.r1 + GetMobRarity( mobIndex, 1 );
  mobData.r2        = mobData.r2 + GetMobRarity( mobIndex, 2 );
  mobData.r3        = mobData.r3 + GetMobRarity( mobIndex, 3 );
  mobData.r4        = mobData.r4 + GetMobRarity( mobIndex, 4 );
  mobData.r5        = mobData.r5 + GetMobRarity( mobIndex, 5 );
  mobData.copper    = mobData.copper + GetMobCopper(mobIndex);
  mobData.itemValue = mobData.itemValue + GetMobIV(mobIndex);

  if  MobInfoDB[mobIndex]  and  MobInfoDB[mobIndex][lPlayer]  and  MobInfoDB[mobIndex][lPlayer].dl  then 
    if  mobData.minDamage == 0  or  MobInfoDB[mobIndex][lPlayer].dl < mobData.minDamage  then
      mobData.minDamage = MobInfoDB[mobIndex][lPlayer].dl;
    end
    if  MobInfoDB[mobIndex][lPlayer].du > mobData.maxDamage  then
      mobData.maxDamage = MobInfoDB[mobIndex][lPlayer].du;
    end
  end

  if MobInfoDB[mobIndex]  and  MobInfoDB[mobIndex].el then
    mobData.emptyLoots = mobData.emptyLoots + MobInfoDB[mobIndex].el;
  end
end  -- MI2_AddMobToData


-----------------------------------------------------------------------------
-- MI2_CreateQualityString()
--
-- build mob data structure required for displaying game tooltip
-----------------------------------------------------------------------------
local function MI2_CreateQualityString( mobData )

  local rt = mobData.loots; 
  
  mobData.qualityStr = "";
  
  if  mobData.r1 > 0  then
    mobData.qualityStr = mobData.qualityStr ..mifontGray..mobData.r1.."("..ceil((mobData.r1/rt)*100).."%) ";
  end
  if  mobData.r2 > 0  then
    mobData.qualityStr = mobData.qualityStr ..mifontWhite..mobData.r2.."("..ceil((mobData.r2/rt)*100).."%) ";
  end
  if  mobData.r3 > 0  then
    mobData.qualityStr = mobData.qualityStr ..mifontGreen..mobData.r3.."("..ceil((mobData.r3/rt)*100).."%) ";
  end
  if  mobData.r4 > 0  then
    mobData.qualityStr = mobData.qualityStr ..mifontBlue..mobData.r4.."("..ceil((mobData.r4/rt)*100).."%) ";
  end
  if  mobData.r5 > 0  then
    mobData.qualityStr = mobData.qualityStr ..mifontMageta..mobData.r5.."("..ceil((mobData.r5/rt)*100).."%) ";
  end
  
end  -- MI2_CreateQualityString


-----------------------------------------------------------------------------
-- MI2_CreateTooltip()
--
-- create game tooltip contents
-----------------------------------------------------------------------------
local function MI2_CreateTooltip( name, mobLevel )
  -- create mostly empty mobData structure (required for adding mobs to it)
  local mobData   = { };
  mobData.class      = UnitClass("mouseover");  
  mobData.clothcnt   = 0;
  mobData.xp         = 0;
  mobData.copper     = 0;
  mobData.itemValue  = 0;
  mobData.minDamage  = 0;
  mobData.maxDamage  = 0;
  mobData.mob2Level  = 0;
  mobData.emptyLoots = 0;
  mobData.minDamage  = 0;
  mobData.maxDamage  = 0;
  mobData.kills      = 0;
  mobData.loots      = 0;
  mobData.r1         = 0;
  mobData.r2         = 0;
  mobData.r3         = 0;
  mobData.r4         = 0;
  mobData.r5         = 0;

  -- handle combined Mob mode : try to find the other Mobs with same
  -- name but differing level, add their data to the tooltip data
  for loopLevel = mobLevel-3, mobLevel+3, 1 do
    if  MobInfoConfig.CombinedMode == 1  and  loopLevel ~= mobLevel  then
      MI2_AddMobToData( name, loopLevel, mobData );
    end
  end

  -- add hovered Mob and build quality string and set health
  MI2_AddMobToData( name, mobLevel, mobData );
  MI2_CreateQualityString( mobData );
  mobData.health = MI2_GetMobHealthStr( lMiMouseoverIndex, UnitHealth("mouseover") );

  -- add collected Mob data to game tooltip
  MI2_AddDataToTooltip( mobData, lMiMouseoverIndex );

end  -- of MI2_CreateTooltip()


-----------------------------------------------------------------------------
-- MI2_GameTooltip_OnEvent()
--
-- Add new information to the game tip for the selected mob 
-----------------------------------------------------------------------------
function MI2_GameTooltip_OnEvent()
  lMi2GameTooltip_OnEvent_Orig(event);
  
  if  event ~= "CLEAR_TOOLTIP"  
      and UnitCreatureType("mouseover") 
      and (UnitIsFriend("player","mouseover") == nil)
      and (MobInfoConfig.KeypressMode == 0
           or MobInfoConfig.KeypressMode == 1 and IsAltKeyDown())  then
           
    local name     = UnitName("mouseover");
    local mobLevel = UnitLevel("mouseover");  
    lMiMouseoverIndex = name..":"..mobLevel;

    miCleanSV( lMiMouseoverIndex );
    MI2_CreateTooltip( name, mobLevel );
    GameTooltip:Show();
  end  
  
end  -- of MI2_GameTooltip_OnEvent()


-----------------------------------------------------------------------------
-- MI2_SetCurTarget()
--
-- The new UnitFrame_OnUpdate event.  Stores information for your selected
-- target
-----------------------------------------------------------------------------
local function MI2_SetCurTarget()

  MI2_MobHealth_OnTargetChange();
      
  if lCurTarget then
    lLastTarget = lCurTarget.index;
  end

  if UnitCreatureType("target") then
    lCurTarget = { };
    lCurTarget.name = UnitName("target");
    lCurTarget.level = UnitLevel("target");
    lCurTarget.index = lCurTarget.name..":"..lCurTarget.level;
    lCurTarget.class = UnitClass("target");
    lCurTarget.kills = GetMobKills(lCurTarget.index);    
    if lMiDebug > 0 then chattext( "MI_DBG : target=["..lCurTarget.index.."], last=["..(lLastTarget or "<none>").."]" ); end
  else
    lCurTarget = nil;
    if lMiDebug > 0 then chattext( "MI_DBG : target=<no target>, last=["..(lLastTarget or "<none>").."]" ); end
  end
end -- of MI2_SetCurTarget()


-----------------------------------------------------------------------------
-- MI2_EventSpellDamage()
--
-- handle spell damage chat message event : extract damage value
-----------------------------------------------------------------------------
local function MI2_EventSpellDamage( )
  local dmgText = arg1;
  
  -- parse the spell damage chat text, 
  -- for French client order of spell and creature must be swapped
  if lCurTarget and (MobInfoConfig.ShowDamage or MobInfoConfig.SaveAllValues) then
    if ( GetLocale() == "frFR" ) then
      for  spell, creature, damage in string.gfind( dmgText, MI_PARSE_SPELL_DMG ) do
        MI2_RecordDamage( lCurTarget.index, creature, tonumber( damage ) );
      end
    else
      for  creature, spell, damage in string.gfind( dmgText, MI_PARSE_SPELL_DMG) do
        MI2_RecordDamage( lCurTarget.index, creature, tonumber( damage ) );
      end
    end
  end
end  -- of MI2_EventSpellDamage(


-----------------------------------------------------------------------------
-- MI2_EventMeleeDamage()
--
-- handle melee damage chat message event : extract damage value
-----------------------------------------------------------------------------
local function MI2_EventMeleeDamage(  )
  local dmgText = arg1;

  -- parse melee damage chat messsage
  if lCurTarget and (MobInfoConfig.ShowDamage or MobInfoConfig.SaveAllValues) then
    for creature, damage in string.gfind( dmgText, MI_PARSE_COMBAT_DMG ) do
      MI2_RecordDamage( lCurTarget.index, creature, tonumber( damage ) );
    end
  end
end  -- of MI2_EventMeleeDamage()


-----------------------------------------------------------------------------
-- MI2_EventCreatureDiesXP()
--
-- event handler for the chat message telling us thta a creature died
-- and gave us XP points
-----------------------------------------------------------------------------
function MI2_EventCreatureDiesXP()

  if lLastTarget then
    local idx = lLastTarget;
    
    if lMiDebug > 0 then chattext( "MI_DBG : mob died with XP: args=["..arg1.."], target=["..lLastTarget.."], last=["..lLastRecordedKill.."]" ); end
  
    -- capture XP kills, only count them if they have not already been
    -- counted as non XP kills, otherwise merely log XP
    -- slightly modified algorithm : count all kills giving XP, not just the current target
    for creatureName, xp in string.gfind(arg1, MI_MOB_DIES_WITH_XP ) do
        MI2_RecordKill( idx, lPlayer, tonumber(xp) );
        lLastRecordedKill = "";
    end
  end
end  -- of MI2_EventCreatureDiesXP()


-----------------------------------------------------------------------------
-- MI2_CreatureDiesHostile()
--
-- event handler for chat message telling me that a hostile creature in
-- my vicinity has died, this message will only get processed if my current
-- target is identical to the last creature that attacked me
--
-- reason: if the crature which I am fighting dies I will still have it
-- as last target when this chat message event is issued
-----------------------------------------------------------------------------
function MI2_CreatureDiesHostile()

  if  lCurTarget  and  UnitIsDead("target")  and  lCurTarget.index ~= lLastRecordedKill  then
    local idx = lCurTarget.index;
    
    if lMiDebug > 1 then chattext( "MI_DBG : hostile mob died : target=["..idx.."], arg1=["..arg1.."]" ); end

    for creatureName in string.gfind(arg1, MI_MOB_DIES_WITHOUT_XP ) do
      if  creatureName == lCurTarget.name  then
        MI2_RecordKill( idx, lPlayer, 0 );
        lLastRecordedKill = idx;
      end
    end
  end
end  -- of MI2_CreatureDiesHostile()


-----------------------------------------------------------------------------
-- MI2_EventRegenDisabled()
--
-- event handler for regeneration disabled event, this event is received
-- whenever a player changes from not fighting to fighting mode
-----------------------------------------------------------------------------
function MI2_EventRegenDisabled()
  MI2_SetCurTarget();
  if lMiDebug > 0 then chattext( "MI_DBG : fight started, target=["..lCurTarget.index.."]" ); end
  lLastRecordedKill = "";
end  -- of MI2_EventRegenDisabled()


-----------------------------------------------------------------------------
-- MI2_EventUnitHealth()
--
-- event handler for unit health event
-- first call MobHealth event handler, then check for change to health value
-- if health value has changed update game tooltip
-----------------------------------------------------------------------------
function MI2_EventUnitHealth()
  if  MobInfoConfig.DisableHealth < 2  then
    local updated = MI2_MH_EventUnitHealth();
    if  GameTooltip:IsShown()  and  updated  and  lMiHealthLine > 1  then
      local healthLine = getglobal("GameTooltipTextRight"..lMiHealthLine);
      local healthText = MI2_GetMobHealthStr( lMiMouseoverIndex, UnitHealth("mouseover") )
      if  healthText  then
        healthLine:SetText( healthText );
      end
    end
  end
end  -- of MI2_EventRegenDisabled()


-----------------------------------------------------------------------------
-- MI2_OnLoad()
--
-- register all events that we want to receive and process, build table
-- of event handler functions for easy processing of events in "OnEvent"
-----------------------------------------------------------------------------
function MI2_OnLoad()

	if(UltimateUI_RegisterButton) then
		UltimateUI_RegisterButton ( 
			"MobInfo2", 
			"Options", 
			"|cFF00CC00MobInfo2|r\nAdds information to the tooltip about the target\nand shows approximate health value on target frame.", 
			"Interface\\Icons\\Spell_Misc_Drink", 
			ShowMIOptions
		);
	end

  -- register all events that we want to catch and process
  this:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN");
  this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");
  this:RegisterEvent("LOOT_OPENED");
  this:RegisterEvent("LOOT_CLOSED");
  this:RegisterEvent("LOOT_SLOT_CLEARED");
  this:RegisterEvent("PLAYER_TARGET_CHANGED");
  this:RegisterEvent("PLAYER_REGEN_DISABLED");
  this:RegisterEvent("VARIABLES_LOADED");
  this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");
  this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS");
  this:RegisterEvent("UNIT_COMBAT");
  this:RegisterEvent("UNIT_HEALTH");

  -- build event handler table for easy event processing (see "MI2_OnEvent()")
  lEventHandlers["CHAT_MSG_COMBAT_XP_GAIN"] = MI2_EventCreatureDiesXP;
  lEventHandlers["CHAT_MSG_COMBAT_HOSTILE_DEATH"] = MI2_CreatureDiesHostile;
  lEventHandlers["LOOT_OPENED"] = MI2_EventLootOpened;
  lEventHandlers["LOOT_CLOSED"] = MI2_EventLootClosed;
  lEventHandlers["LOOT_SLOT_CLEARED"] = MI2_EventLootSlotCleared;
  lEventHandlers["PLAYER_TARGET_CHANGED"] = MI2_SetCurTarget;
  lEventHandlers["PLAYER_REGEN_DISABLED"] = MI2_EventRegenDisabled;
  lEventHandlers["VARIABLES_LOADED"] = MobInfo_Initialize;
  lEventHandlers["CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE"] = MI2_EventSpellDamage;
  lEventHandlers["CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS"] = MI2_EventMeleeDamage;
  lEventHandlers["UNIT_COMBAT"] = MI2_MH_EventUnitCombat;
  lEventHandlers["UNIT_HEALTH"] = MI2_EventUnitHealth;

  -- set some stuff that is needed (only) for improved compatibility
  -- to other AddOns wanting to use MobHealth info
  if  not MobHealthFrame  then
    if lMiDebug > 0 then chattext( "MI_DBG : setting up compatibility variables" ); end
    MobHealthFrame = "MI2";
    MobHealth_OnEvent = MI2_OnEvent;
  end

  if lMiDebug > 0 then chattext( "MI_DBG : MobInfo_OnLoad: all events registered" ); end
end  -- of MI2_OnLoad()


-----------------------------------------------------------------------------
-- MI2_OnEvent()
--
-- MobInfo main event handler function, gets called for all registered events
-- uses table of event handlers which gets initialised in "OnLoad"
-----------------------------------------------------------------------------
function MI2_OnEvent( event )	

  if event then
    -- debug output section for testing/debugging
    if lMiDebug > 2 then
      if arg2 then chattext( "MI_DBG : event=["..event.."], arg1=["..arg1.."], arg2=["..arg2.."]" ); else
      if arg1 then chattext( "MI_DBG : event=["..event.."], arg1=["..arg1.."]" ); else
                   chattext( "MI_DBG : event=["..event.."]" ); end end
    end

    -- call event handler function for event
    if  lEventHandlers[event]  then
      lEventHandlers[event]();
      return 0;
    end
  end
end  -- of MI2_OnEvent

