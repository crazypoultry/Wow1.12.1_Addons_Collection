--[[

  HealBot Contined
	
]]

local HB_scale=0;
local CalcEquipBonus=false;
local InitCalcEquipBonus=false;
local FlagEquipUpdate1=1;
local FlagEquipUpdate2=1;
local NeedEquipUpdate=0;
local HealValue=0;
local InitSpells=1;
local DebugDebuff=false;
local Delay_RecalcParty=0;
local HealBot_RequestVer=nil;


function HealBot_AddChat(msg)
  local chanid=HealBot_Get_DebugChan();
  if chanid and HealBot_SpamCnt < 3 then
    HealBot_SpamCnt=HealBot_SpamCnt+1;
    local hour,minute = GetGameTime();
	if minute==0 then
      msg="["..hour..":00] "..msg;
    elseif minute<10 then
      msg="["..hour..":0"..minute.."] "..msg; 
    else
      msg="["..hour..":"..minute.."] "..msg; 
    end
    SendChatMessage(msg , "CHANNEL", nil, chanid); 
  elseif ( DEFAULT_CHAT_FRAME ) then
    DEFAULT_CHAT_FRAME:AddMessage(msg);
  end
end


function HealBot_AddDebug(msg)
  local chanid=HealBot_Get_DebugChan();
  if chanid and HealBot_SpamCnt < 3 then
    HealBot_SpamCnt=HealBot_SpamCnt+1;
    local hour,minute = GetGameTime();
	if minute==0 then
      msg="["..hour..":00] DEBUG: "..msg;
    elseif minute<10 then
      msg="["..hour..":0"..minute.."] DEBUG: "..msg; 
    else
      msg="["..hour..":"..minute.."] DEBUG: "..msg; 
    end
    SendChatMessage(msg , "CHANNEL", nil, chanid);
  end
end

function HealBot_Report_Error(msg)
  if HealBot_ErrorCnt<28 then
    HealBot_ErrorCnt=HealBot_ErrorCnt+1;
    ShowUIPanel(HealBot_Error);
    HealBot_ErrorsIn(msg,HealBot_ErrorCnt);
  end
end

function HealBot_AddError(msg)
  UIErrorsFrame:AddMessage(msg, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
  HealBot_AddDebug(msg);
end

function HealBot_TogglePanel(panel)
  if (not panel) then return end
  if ( panel:IsVisible() ) then
    HideUIPanel(panel);
  else
    ShowUIPanel(panel);
  end
end

function HealBot_StartMoving(frame)
  if ( not frame.isMoving ) and ( frame.isLocked ~= 1 ) then
    frame:StartMoving();
    frame.isMoving = true;
  end
end

function HealBot_StopMoving(frame)
  if ( frame.isMoving ) then
    frame:StopMovingOrSizing();
    frame.isMoving = false;
  end
  if HealBot_Config.GrowUpwards==1 then
    local left,bottom = HealBot_Action:GetLeft(),HealBot_Action:GetBottom();
    if left and bottom then
      HealBot_Config.PanelAnchorX=left;
      HealBot_Config.PanelAnchorY=bottom;
    end
--    HealBot_AddDebug("Pos X="..HealBot_Config.PanelAnchorX.."  Pos Y="..HealBot_Config.PanelAnchorY)
  end

end

function HealBot_SlashCmd(cmd)
  if (cmd=="") then
    HealBot_TogglePanel(HealBot_Action);
    return
  end
  if (cmd=="options" or cmd=="opt" or cmd=="config" or cmd=="cfg") then
    HealBot_TogglePanel(HealBot_Options);
    return
  end

  if (cmd=="reset" or cmd=="recalc" or cmd=="defaults") then
    initSpells=2;
    HealBot_Options_Defaults_OnClick(HealBot_Options_Defaults);
    return
  end
  if (cmd=="ui") then
    ReloadUI();
    return;
  end
  if (cmd=="init") then
  	HealBot_RegisterThis(this);
  end
  if (cmd=="x") then
    initSpells=2;
	NeedEquipUpdate=1
  	HealBot_RecalcSpells();
    return;
  end
  if (cmd=="ver") then
    local text=UnitName("player");
    SendAddonMessage( "HealBot", ">> RequestVersion <<=>> "..text.." <<=>> nil <<", "RAID" );
    return;
  end
  if (cmd=="chan") then
    HealBot_AddDebug( "Channel active" );
    return;
  end
end

function HealBot_TargetName()
  if UnitIsEnemy("target","player") then return nil end
--  if not UnitPlayerControlled("target") then return nil end
  if (UnitIsPlayer("target")) then
    if UnitIsUnit("target","player") then return "player" end
    if (UnitInParty("target")) then 
      for i=1,4 do
        if UnitIsUnit("target","party"..i) then return "party"..i end
      end
    end
    if (UnitInRaid("target")) then 
      for i=1,40 do
        if UnitIsUnit("target","raid"..i) then return "raid"..i end
      end
    end
  else
    if UnitIsUnit("target","pet") then return "pet" end
    if (UnitInParty("player")) then 
      for i=1,4 do
        if UnitIsUnit("target","partypet"..i) then return "partypet"..i end
      end
    end
    if (UnitInRaid("player")) then 
      for i=1,40 do
        if UnitIsUnit("target","raidpet"..i) then return "raidpet"..i end
      end
    end
  end
  return nil
end



function HealBot_PackBagSlot(bag,slot)
  return bag*100+slot;
end

function HealBot_UnpackBagSlot(bagslot)
  return math.floor(bagslot/100),math.mod(bagslot,100);
end

function HealBot_GetItemName(bag,slot)
  local link = GetContainerItemLink(bag,slot);
  if not link then return nil end;
  local _,_,item = string.find(link,"%[(.*)%]");
  local _,count = GetContainerItemInfo(bag,slot);
  return item,count;
end

function HealBot_GetBagSlot(item)
  local BagSlot,BestCount;
  for bag=0,NUM_BAG_FRAMES do
    for slot=1,GetContainerNumSlots(bag) do
      local bagitem,count = HealBot_GetItemName(bag,slot);
      if (item==bagitem) then
        if not BestCount or BestCount>count then
          BagSlot = HealBot_PackBagSlot(bag,slot);
          BestCount = count;
        end
      end
    end
  end
  return BagSlot;
end

function HealBot_UseItem(item)
  local bagslot = HealBot_GetBagSlot(item);
  if not bagslot then return end;
  local bag,slot = HealBot_UnpackBagSlot(bagslot);
  local Link = GetContainerItemLink(bag,slot);
  UseContainerItem(bag,slot);
end

function HealBot_GetSpellName(id)
  if (not id) then
    return nil;
  end
  local spellName, subSpellName = GetSpellName(id,BOOKTYPE_SPELL);
  if (not spellName) then
    return nil;
  end
  if (not subSpellName or subSpellName=="") then
    return spellName;
  end
  return spellName .. "(" .. subSpellName .. ")";
end

function HealBot_GetSpellId(spell)
  local id,idd = 1,0; 
  while true do 
    local spellName, subSpellName = GetSpellName(id,BOOKTYPE_SPELL);
    if (spellName) then
      if (spell == spellName .. " (" .. subSpellName .. ")") or (spell == spellName .. "(" .. subSpellName .. ")") then
       return id;
      end
      if (spell == spellName) then
        idd=id;
      end   
    else
      do break end
    end
    id = id + 1;
  end
  if idd>0 then
    return idd
  else
    return nil;
  end
end

function HealBot_CastSpellByName(spell)
  if (HealBot_Spells[spell] and HealBot_Spells[spell].BagSlot) then
    HealBot_UseItem(spell);
    return;
  end
  local id;
  if not HealBot_Spells[spell] then
    id = HealBot_GetSpellId(spell);
  elseif HealBot_Spells[spell].id then
    id = HealBot_Spells[spell].id
  else
    id = HealBot_GetSpellId(spell);
  end
  if (not id) then
    return;
  end
  CastSpell(id,BOOKTYPE_SPELL);
end

HealBot_CastingSpell  = nil;
HealBot_CastingTarget = nil;

function HealBot_StartCasting(spell,target,ttype)
  HealBot_CastSpellByName(spell);
  HealBot_CastingSpell  = spell;
  HealBot_CastingTarget = target;
  if ( SpellCanTargetUnit(target)  ) then 
    SpellTargetUnit(target);
    ttype="fired";
  elseif SpellIsTargeting() then
    SpellTargetUnit(target);
    SpellStopTargeting()
  elseif ttype=="direct" then
    if ( CheckInteractDistance(target, 4) ) then
      ttype="fired";
    end
  end

  if HealBot_Config.CastNotify>1 then
    if target=="target" then target = HealBot_TargetName() or "target" end
    local Notify = HealBot_Config.CastNotify;
    if Notify==5 and GetNumRaidMembers()==0 then Notify = 4 end
    if Notify==4 and GetNumPartyMembers()==0 then Notify = 3 end
    if Notify==3 and not (UnitPlayerControlled(target) and target~='player' and target~='pet') then Notify = 2 end
    if Notify==3 then
      SendChatMessage(string.format(HEALBOT_CASTINGSPELLONYOU,spell),"WHISPER",nil,UnitName(target));
    elseif Notify==4 then
      SendChatMessage(string.format(HEALBOT_CASTINGSPELLONUNIT,spell,UnitName(target)),"PARTY",nil,nil);
    elseif Notify==5 then
      SendChatMessage(string.format(HEALBOT_CASTINGSPELLONUNIT,spell,UnitName(target)),"RAID",nil,nil);
    else
      HealBot_AddChat(string.format(HEALBOT_CASTINGSPELLONUNIT,spell,UnitName(target)));
    end
  end
  if ttype=="fired" and HealBot_Spells[spell] then
--    if not HealBot_Spells[spell].CastTime then
--      if HealBot_Spells[spell].id then 
--        HealBot_InitGetSpellData(spell, HealBot_Spells[spell].id, HealBot_UnitClass("player"))
--        HealBot_AddDebug("Requested init spell data for "..spell)
--      end
--      if not HealBot_Spells[spell].CastTime then
--        HealBot_Spells[spell].CastTime=0
--        HealBot_AddDebug("Unable to init spell data for "..spell)
--        InitSpells=2;
--        return
--      end
--    end
    if HealBot_Spells[spell].CastTime > 1 then
      HealValue=HealBot_Spells[spell].HealsDur;
      SendAddonMessage( HEALBOT_ADDON_ID, ">> "..UnitName(target).." <<=>> "..HealValue.." << ", "RAID" );
    end
  end
end

function HealBot_StopCasting()
  if HealBot_CastingTarget then
   if HealBot_HealsIn[UnitName(HealBot_CastingTarget)] then
    if HealValue > 0 then
	  SendAddonMessage( HEALBOT_ADDON_ID, ">> "..UnitName(HealBot_CastingTarget).." <<=>> "..0-HealValue.." << ", "RAID" );
      HealValue=0;
    end
   end
  end
  HealBot_CastingSpell  = nil;
  HealBot_CastingTarget = nil;
  local bar = HealBot_Action_HealthBar(HealBot_Action_AbortButton);
  local ar=HealBot_Config.babortcolr[HealBot_Config.Current_Skin] or 0.1;
  local ag=HealBot_Config.babortcolg[HealBot_Config.Current_Skin] or 0.1;
  local ab=HealBot_Config.babortcolb[HealBot_Config.Current_Skin] or 0.5;
  local aa=HealBot_Config.babortcola[HealBot_Config.Current_Skin] or 1;
  bar.txt = getglobal(bar:GetName().."_text");  bar:SetStatusBarColor(ar,ag,ab,0);
  local sr=HealBot_Config.btextdisbledcolr[HealBot_Config.Current_Skin];
  local sg=HealBot_Config.btextdisbledcolg[HealBot_Config.Current_Skin];
  local sb=HealBot_Config.btextdisbledcolb[HealBot_Config.Current_Skin];
  local sa=HealBot_Config.btextdisbledcola[HealBot_Config.Current_Skin];
  bar.txt:SetTextColor(sr,sg,sb,sa);
end


local HealBot_Health60 = {
  ["DRUID"]   = 3500,
  ["MAGE"]    = 2500,
  ["HUNTER"]  = 3500,
  ["PALADIN"] = 4000,
  ["PRIEST"]  = 2500,
  ["ROGUE"]   = 3500,
  ["SHAMAN"]  = 3800,
  ["WARLOCK"] = 3500,
  ["WARRIOR"] = 5000,
}
function HealBot_UnitHealth(unit)
  local Current,Desired = UnitHealth(unit),UnitHealthMax(unit);
  if unit=='target' and Desired==100 then
    local class,level = HealBot_UnitClass(unit),UnitLevel(unit);
    if HealBot_Health60[class] and level>0 then
      Desired = math.floor(HealBot_Health60[class]/60*level+0.5)
    else
      Desired = UnitHealthMax('player');
    end
    Current = Desired/100*Current;
  end
  return Current,Desired;
end

function HealBot_CheckCasting(unit)
  if not HealBot_CastingSpell or HealBot_AlwaysHeal() then return nil end
  if not HealBot_Spells[HealBot_CastingSpell] then return nil end
  if not unit then unit = HealBot_CastingTarget end
  if unit~=HealBot_CastingTarget then return nil end

  local bar = HealBot_Action_HealthBar(HealBot_Action_AbortButton);
  local ar=HealBot_Config.babortcolr[HealBot_Config.Current_Skin] or 0.1;
  local ag=HealBot_Config.babortcolg[HealBot_Config.Current_Skin] or 0.1;
  local ab=HealBot_Config.babortcolb[HealBot_Config.Current_Skin] or 0.5;
  local aa=HealBot_Config.babortcola[HealBot_Config.Current_Skin] or 1;
  bar.txt = getglobal(bar:GetName().."_text");  
  
  if HealBot_IsCasting==false and HealBot_AbortButton==0 then
    bar:SetStatusBarColor(ar,ag,ab,0);
    local sr=HealBot_Config.btextdisbledcolr[HealBot_Config.Current_Skin];
    local sg=HealBot_Config.btextdisbledcolg[HealBot_Config.Current_Skin];
    local sb=HealBot_Config.btextdisbledcolb[HealBot_Config.Current_Skin];
    local sa=HealBot_Config.btextdisbledcola[HealBot_Config.Current_Skin];  
    bar.txt:SetTextColor(sr,sg,sb,sa);
    return nil
  end

  local Current,Desired = HealBot_UnitHealth(unit)
  local Needed = Desired-Current;
  Needed = Needed * (1 + (HealBot_Config.OverHeal*4));
  if Needed<0 then Needed = 0 end
  if (Needed>HealBot_Spells[HealBot_CastingSpell].HealsDur) then 
    local sr=HealBot_Config.btextdisbledcolr[HealBot_Config.Current_Skin];
    local sg=HealBot_Config.btextdisbledcolg[HealBot_Config.Current_Skin];
    local sb=HealBot_Config.btextdisbledcolb[HealBot_Config.Current_Skin];
    local sa=HealBot_Config.btextdisbledcola[HealBot_Config.Current_Skin];
    bar.txt:SetTextColor(sr,sg,sb,sa);
    bar:SetStatusBarColor(ar,ag,ab,0);
    return nil 
  elseif HealBot_AbortButton==1 and HealBot_IsCasting==true then

    bar:SetStatusBarColor(ar,ag,ab,aa);
    local sr=HealBot_Config.btextenabledcolr[HealBot_Config.Current_Skin];
    local sg=HealBot_Config.btextenabledcolg[HealBot_Config.Current_Skin];
    local sb=HealBot_Config.btextenabledcolb[HealBot_Config.Current_Skin];
    local sa=HealBot_Config.btextenabledcola[HealBot_Config.Current_Skin];
    bar.txt = getglobal(bar:GetName().."_text");
    bar.txt:SetTextColor(sr,sg,sb,sa);
  end
end

function HealBot_CastSpellOnFriend(spell,target)
  local old;
  local ttype="other";
  if (not spell or not target or not UnitName(target)) then
    return;
  end
  if (UnitCanAttack("player","target")) then
    old = "enemy";
  else
    old = UnitName("target");
    if UnitName("target")~=UnitName(target) then
      ClearTarget();
    else
      ttype="direct";
    end
  end
  HealBot_StartCasting(spell,target,ttype);
  if (old=="enemy") then
    TargetLastEnemy();
  elseif (old) then
    TargetByName(old);
  else
    ClearTarget();
  end
end

function HealBot_UnitClass(unit)
  local playerClass, englishClass = UnitClass(unit);
  return englishClass;
end

-- TBD: use the event UNIT_AURA to keep track instead of querying each time

function HealBot_UnitAffected(unit,effect)
  if not effect then return nil; end
  local i = 1
  while true do
    local buff = UnitBuff(unit,i)
    if not buff then
      do break end
    end
    if buff==effect then
      return buff
    end
    i = i + 1
  end
  i = 1
  while true do
    local debuff = UnitDebuff(unit,i)
    if not debuff then
      do break end
    end
    if debuff==effect then
      return debuff
    end
    i = i + 1
  end
  return nil;
end
-- safer to use GameTooltip:SetUnitBuff and read the lines in the tooltip ...
-- maybe make an additional GameTooltip frame if possible ?

function HealBot_SetItemDefaults(spell)
  if not HealBot_Spells[spell].Target then
    HealBot_Spells[spell].Target = {"player","party","pet"};
  end
  if not HealBot_Spells[spell].Price then
    HealBot_Spells[spell].Price = 0;
  end
  if not HealBot_Spells[spell].CastTime then
    HealBot_Spells[spell].CastTime = 0;
  end
  if not HealBot_Spells[spell].Mana then
    HealBot_Spells[spell].Mana = 0;
  end
  if not HealBot_Spells[spell].Channel then
    HealBot_Spells[spell].Channel = HealBot_Spells[spell].CastTime;
  end
  if not HealBot_Spells[spell].Duration then
    HealBot_Spells[spell].Duration = HealBot_Spells[spell].Channel;
  end
  if not HealBot_Spells[spell].HealsMin then
    HealBot_Spells[spell].HealsMin = 0;
  end
  if not HealBot_Spells[spell].HealsMax then
    HealBot_Spells[spell].HealsMax = 0;
  end
  HealBot_Spells[spell].RealHealing=0;
  HealBot_Spells[spell].HealsCast = (HealBot_Spells[spell].HealsMin+HealBot_Spells[spell].HealsMax)/2;
  if not HealBot_Spells[spell].HealsExt then
    HealBot_Spells[spell].HealsExt = 0;
  end
end

function HealBot_SetSpellDefaults(spell)
  HealBot_Spells[spell].HealsDur = floor((HealBot_Spells[spell].HealsCast+HealBot_Spells[spell].HealsExt) + HealBot_Spells[spell].RealHealing);
end

function HealBot_AddHeal(spell)
  HealBot_SetSpellDefaults(spell);
  table.foreachi(HealBot_Spells[spell].Target,function (i,val)
    table.insert(HealBot_Heals[val],spell);
  end);
  HealBot_Spells[spell].BagSlot = HealBot_GetBagSlot(spell);
end


function HealBot_FindHealSpells()
  local id = 1;
  if InitSpells>0 then NeedEquipUpdate=1; return; end

  HealBot_Heals = { player = {}, pet = {}, party = {} };
  
  table.foreach(HealBot_CurrentSpells, function (index,spell)
    if (HealBot_Spells[spell]) then
      if CalcEquipBonus then
        local healingbonus_penalty=1;
        if HealBot_Spells[spell].Level < 20 then
          healingbonus_penalty=(1-((20-HealBot_Spells[spell].Level)*0.0375));
        end
        local temp_Spell_cast=3.5;
        if HealBot_Spells[spell].CastTime == 0 then
          temp_Spell_cast=3.5;
        end
        if not HealBot_Spells[spell].CastTime then
         -- HealBot_SetOldDefaults(spell);
--          HealBot_Report_Error( "================================" );
--          HealBot_Report_Error( "ERROR: HealBot_Spells[spell].CastTime == nil" );
--          HealBot_Report_Error( "ERROR: spell = "..spell );
          HealBot_Spells[spell].CastTime = 1.5;
        end          
        if HealBot_Spells[spell].CastTime >= 1.5 and HealBot_Spells[spell].CastTime < 3.5 then
          temp_Spell_cast=HealBot_Spells[spell].CastTime;
        end
        RealHealing = ((HealBot_GetBonus() * healingbonus_penalty) * (temp_Spell_cast/3.5));
        local playerClass, englishClass = UnitClass("player");
        local SpiBonus = 0;
        if (englishClass=="PRIEST") then
          SpiBonus = ((HealBot_SpiBonus(spell) * healingbonus_penalty) * (temp_Spell_cast/3.5))
          RealHealing = RealHealing + SpiBonus;
        end
        RealHealing = floor(RealHealing);
        HealBot_Spells[spell].RealHealing = RealHealing;
      end
      HealBot_AddHeal(spell);
    end
  end);

  local items = {};
  for bag=0,NUM_BAG_FRAMES do
    for slot=1,GetContainerNumSlots(bag) do
      local item = HealBot_GetItemName(bag,slot);
      if HealBot_Spells[item] and not items[item] then
        HealBot_SetItemDefaults(item);
        HealBot_AddHeal(item);
        items[item] = 1;
      end
    end
  end
  table.foreach(HealBot_Heals, function (key,val)
    if (table.getn(val)==0) then
      HealBot_Heals[key] = nil;
    end
  end);
  HealBot_Heals.target = HealBot_Heals.party;
  for i=1,4 do
    HealBot_Heals["party"..i] = HealBot_Heals.party;
    HealBot_Heals["partypet"..i] = HealBot_Heals.party;
  end
  for i=1,40 do
    HealBot_Heals["raid"..i] = HealBot_Heals.party;
    HealBot_Heals["raidpet"..i] = HealBot_Heals.party;
  end

  table.foreach(HealBot_Heals, function (key,val)
    table.foreachi(val, function (i,val)
    end);
  end);
  if CalcEquipBonus then
    HealBot_AddDebug("...Done Equip Bonus:"..RealHealing);
  end
  CalcEquipBonus=false;
end


function HealBot_GetShapeshiftForm()
  local forms = GetNumShapeshiftForms();
  if forms then
    local i;
    for i=1,forms do
      local icon,name,active = GetShapeshiftFormInfo(i);
      if active and not string.find(icon,"HumanoidForm") then return i; end
    end
  end
  return nil;
end

function HealBot_CanCastSpell(spell,unit)
  local this = HealBot_Spells[spell];
  if this.Mana>UnitMana("player") then return false end;
  if this.BagSlot then
    local bag,slot = HealBot_UnpackBagSlot(this.BagSlot);
    local start, duration, enable = GetContainerItemCooldown(bag,slot);
    if (start > 0 and duration > 0 and enable > 0) then
      return false;
    end
  end
  return true;
end


function HealBot_GetHealSpell(unit,pattern)
  if (not UnitName(unit)) then return nil end;
  if UnitOnTaxi("player") then return nil end;
  if HealBot_Config.ProtectPvP==1 and UnitIsPVP(unit) and not UnitIsPVP("player") then return nil end
  if HealBot_UnitClass("player")=="DRUID" then
    if HealBot_GetShapeshiftForm() then return nil end; 
  end    
  local spell = HealBot_GetSpellName(HealBot_GetSpellId(pattern))
  local range=40;
  if HealBot_Spells[spell] then
    if not HealBot_CanCastSpell(spell,unit) then return nil end;
    range=HealBot_Spells[spell].range;
  end
  if HealBot_Range_Check(unit, range)==0 then return nil end;
  return spell;
end

function HealBot_HealUnit(unit,pattern)
  HealBot_CastSpellOnFriend(HealBot_GetHealSpell(unit,pattern),unit);
end

function HealBot_RecalcHeals(unit)
  HealBot_Action_Refresh(unit);
end

function HealBot_RecalcParty()
  HealBot_Action_PartyChanged();
  HealBot_Action_RefreshButtons();
end

function HealBot_RecalcSpells()
  HealBot_FindHealSpells();
  HealBot_RecalcParty();
end

--------------------------------------------------------------------------------------------------
-- OnFoo functions
--------------------------------------------------------------------------------------------------

function HealBot_OnLoad(this)
  this:RegisterEvent("VARIABLES_LOADED");
  
  SLASH_HEALBOT1 = "/healbot";
  SLASH_HEALBOT2 = "/hb";
  SlashCmdList["HEALBOT"] = function(msg)
    HealBot_SlashCmd(msg);
  end
  HealBot_AddError(HEALBOT_ADDON .. HEALBOT_LOADED);
end

function HealBot_RegisterThis(this)

end 

local HealBot_Timer1,HealsIn_Timer = 0,0;
function HealBot_OnUpdate(this,arg1)
  HealBot_Timer1 = HealBot_Timer1+arg1;
  if HealBot_Timer1>=2.8 then
    if not HealBot_IsFighting then
      HealsIn_Timer=HealsIn_Timer+1;
	  if HealsIn_Timer>=25 then
        HealBot_HealsIn={};
        HealBot_Healers={};
	    HealsIn_Timer=0;
        InitCalcEquipBonus=true
      end
      if HealBot_RequestVer then
        SendAddonMessage( "HealBot", ">> SendVersion <<=>> "..HealBot_RequestVer.." <<=>> Version="..HEALBOT_VERSION, "RAID" );
        HealBot_RequestVer=nil;
      end
	  if FlagEquipUpdate1>0 and FlagEquipUpdate2>0 then
	    FlagEquipUpdate1=0;
	    FlagEquipUpdate2=0;
	    NeedEquipUpdate=1;
	  elseif FlagEquipUpdate1>0 then
	    FlagEquipUpdate1=FlagEquipUpdate1+1;
        if FlagEquipUpdate1>2 then
	      FlagEquipUpdate1=0;
	    end
      elseif FlagEquipUpdate2>0 then
	    FlagEquipUpdate2=FlagEquipUpdate2+1;
        if FlagEquipUpdate2>2 then
	      FlagEquipUpdate2=0;
	    end
	  end
      if NeedEquipUpdate>0 and InitCalcEquipBonus then
        HealBot_BonusScanner:ScanEquipment()
        CalcEquipBonus=true;
        InitCalcEquipBonus=false;
        NeedEquipUpdate=0; 
        HealBot_RecalcSpells();  
      end
      if InitSpells>1 then
         InitSpells=InitSpells+1;
         if InitSpells>3 then
           local cnt=HealBot_InitSpells();
           InitSpells=0;
           InitCalcEquipBonus=true;
         end
      end
      if Delay_RecalcParty>0 then
        Delay_RecalcParty=Delay_RecalcParty+1
        if Delay_RecalcParty>2 then
          Delay_RecalcParty=0;
          HealBot_RecalcParty();
        end
      end
    else
	  HealsIn_Timer=0;
    end
    HealBot_Timer1 = 0;
    HealBot_SpamCnt = 0;
  end
end

function HealBot_OnEvent(this, event, arg1,arg2,arg3,arg4)
  if (event=="CHAT_MSG_ADDON") then
    HealBot_OnEvent_AddonMsg(this,arg1,arg2,arg3,arg4);
  elseif (event=="UNIT_HEALTH") then
    HealBot_OnEvent_UnitHealth(this,arg1);
  elseif (event=="UNIT_MANA") then
    HealBot_OnEvent_UnitMana(this,arg1);
  elseif (event=="UNIT_AURA") then
    HealBot_OnEvent_UnitAura(this,arg1);
  elseif (event=="SPELLCAST_START") then
    HealBot_OnEvent_SpellcastStart(this,arg1,arg2);
  elseif (event=="SPELLCAST_STOP") then
    HealBot_OnEvent_SpellcastStop(this);
  elseif (event=="SPELLCAST_INTERRUPTED") then
    HealBot_OnEvent_SpellcastStop(this);
  elseif (event=="SPELLCAST_FAILED") then
    HealBot_OnEvent_SpellcastStop(this);
  elseif (event=="PLAYER_REGEN_DISABLED") then
    HealBot_OnEvent_PlayerRegenDisabled(this);
  elseif (event=="PLAYER_REGEN_ENABLED") then
    HealBot_OnEvent_PlayerRegenEnabled(this);
  elseif (event=="BAG_UPDATE_COOLDOWN") then
    HealBot_OnEvent_BagUpdateCooldown(this,arg1);
  elseif (event=="BAG_UPDATE") then
    HealBot_OnEvent_BagUpdate(this,arg1);
  elseif (event=="PARTY_MEMBER_DISABLE") then
    HealBot_OnEvent_PartyMemberDisable(this,arg1);
  elseif (event=="PARTY_MEMBER_ENABLE") then
    HealBot_OnEvent_PartyMemberEnable(this,arg1);
  elseif (event=="CHAT_MSG_SYSTEM") then
    HealBot_OnEvent_SystemMsg(this,arg1);
  elseif (event=="PARTY_MEMBERS_CHANGED") then
    HealBot_OnEvent_PartyMembersChanged(this);
  elseif (event=="PLAYER_TARGET_CHANGED") then
    HealBot_OnEvent_PlayerTargetChanged(this);
  elseif (event=="ZONE_CHANGED_NEW_AREA") then
    HealBot_OnEvent_ZoneChanged(this);
  elseif (event=="UPDATE_INVENTORY_ALERTS") then
    HealBot_OnEvent_PlayerEquipmentChanged(this);
  elseif (event=="UNIT_INVENTORY_CHANGED") then
    HealBot_OnEvent_PlayerEquipmentChanged2(this,arg1);
  elseif (event=="PET_BAR_SHOWGRID") then
    HealBot_OnEvent_PartyMembersChanged(this);
  elseif (event=="PET_BAR_HIDEGRID") then
    HealBot_OnEvent_PartyMembersChanged(this);
  elseif (event=="SPELLS_CHANGED") then
    HealBot_OnEvent_SpellsChanged(this,arg1);
  elseif (event=="PLAYER_ENTERING_WORLD") then
    HealBot_OnEvent_PlayerEnteringWorld(this);
--  elseif (event=="CHARACTER_POINTS_CHANGED") then
--    HealBot_OnEvent_TalentsChanged(this, arg1);
  elseif (event=="VARIABLES_LOADED") then
    HealBot_OnEvent_VariablesLoaded(this);
  else
    HealBot_AddDebug("OnEvent (" .. event .. ")");
  end
end

function HealBot_OnEvent_VariablesLoaded(this)

  local class=HealBot_UnitClass("player")

  table.foreach(HealBot_ConfigDefaults, function (key,val)
    if not HealBot_Config[key] then
      HealBot_Config[key] = val;
    end
  end);
  
  HealBot_InitData();
  
  if class=="PRIEST" or class=="DRUID" or class=="PALADIN" or class=="SHAMAN" then
    
    HealBot_BonusScanner:ScanEquipment();

    if HealBot_Config.ActionVisible==1 then HealBot_Action:Show() end

    this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
    this:RegisterEvent("PLAYER_REGEN_DISABLED");
    this:RegisterEvent("PLAYER_REGEN_ENABLED");
    this:RegisterEvent("PLAYER_TARGET_CHANGED");
    this:RegisterEvent("PARTY_MEMBERS_CHANGED");
    this:RegisterEvent("PARTY_MEMBER_DISABLE");
    this:RegisterEvent("PARTY_MEMBER_ENABLE");
    this:RegisterEvent("PET_BAR_SHOWGRID");
    this:RegisterEvent("PET_BAR_HIDEGRID");
    this:RegisterEvent("UNIT_HEALTH");
    this:RegisterEvent("UNIT_MANA");
    this:RegisterEvent("SPELLS_CHANGED");
    this:RegisterEvent("SPELLCAST_START");
    this:RegisterEvent("SPELLCAST_STOP");
    this:RegisterEvent("SPELLCAST_INTERRUPTED");
    this:RegisterEvent("SPELLCAST_FAILED");
    this:RegisterEvent("BAG_UPDATE");
    this:RegisterEvent("BAG_UPDATE_COOLDOWN");
    this:RegisterEvent("UNIT_AURA");
--    this:RegisterEvent("CHARACTER_POINTS_CHANGED");
    this:RegisterEvent("UPDATE_INVENTORY_ALERTS");
    this:RegisterEvent("UNIT_INVENTORY_CHANGED");
    this:RegisterEvent("CHAT_MSG_ADDON");
    this:RegisterEvent("CHAT_MSG_SYSTEM");
    this:RegisterEvent("PLAYER_ENTERING_WORLD");
    InitSpells=2;
  end
end

function HealBot_OnEvent_AddonMsg(this,addon_id,inc_msg,dist_target,sender_id)
  if addon_id==HEALBOT_ADDON_ID then
    local tmpTest, unitname, heal_val
	tmpTest,tmpTest,unitname,heal_val = string.find(inc_msg, ">> (%a+) <<=>> (.%d+) <<" );
	if heal_val then
      if not HealBot_HealsIn[unitname] then
		HealBot_HealsIn[unitname]=0;
      end
      HealBot_Healers[sender_id] = ">> "..unitname.." <<=>> "..heal_val.." <<";
      HealBot_HealsIn[unitname] = HealBot_HealsIn[unitname] + tonumber(heal_val);
      if tonumber(heal_val) > 0 then
        HealBot_RecalcHeals(HealBot_FindUnitID(unitname))
	  elseif HealBot_HealsIn[unitname] < 0 then
	    HealBot_HealsIn[unitname]=0;
      end
    end
  elseif addon_id=="HealBot" then
    local tmpTest, datatype, datamsg, sender
    local PName=UnitName("player");
    tmpTest, tmpTest, datatype, sender, datamsg = string.find(inc_msg, ">> (%a+) <<=>> (%a+) <<=>> (.+)");
    if datatype=="RequestVersion" then
      HealBot_RequestVer=sender;
    elseif datatype=="SendVersion" and PName==sender then
      HealBot_AddChat(sender_id..":  "..datamsg);
    end
  elseif addon_id=="CTRA" then
    if ( strsub(inc_msg, 1, 3) == "RES" ) then
      if ( inc_msg == "RESNO" ) then
        for j in pairs(HealBot_Ressing) do
          if HealBot_Ressing[j]==sender_id then
            HealBot_Ressing[j] = nil
            break
          end
        end
      else
        local unitname, tmpTest
        tmpTest, tmpTest, unitname = string.find(inc_msg, "^RES (.+)$");
        if ( unitname ) then
          HealBot_Ressing[unitname] = sender_id;
          HealBot_RecalcHeals(HealBot_FindUnitID(unitname));
         end
      end
    end
  end
end
	
  
function HealBot_OnEvent_UnitHealth(this,unit)
    if (not HealBot_Heals[unit]) then return end
    HealBot_CheckCasting(unit);
    HealBot_RecalcHeals(unit);
    if unit==HealBot_Action_TooltipUnit then
      HealBot_Action_RefreshTooltip(HealBot_Action_TooltipUnit);
    end
end

function HealBot_OnEvent_UnitMana(this,unit)
  if (unit~="player") then return end
  HealBot_RecalcHeals();
end

function HealBot_OnEvent_ZoneChanged(this)
--   HealBot_AddDebug("HB: ZoneChange");
   HB_scale = 0;
   Delay_RecalcParty=1;
end

function HealBot_OnEvent_UnitAura(this,unit)
  local DebuffType;
  
  if HealBot_Heals[unit] and unit~="target" then
    local i = 1;
    while true do
      local debuff, tmp, debuff_type = UnitDebuff(unit,i, 1)
      if debuff then
        if HealBot_CDCInc[UnitClass(unit)]==1 and HealBot_DebuffWatch[debuff_type]=="YES" then
          HealBot_UnitDebuff[unit]=debuff_type
--          HealBot_UnitDebuff[unit.."_debuff_texture"]=debuff
          DebuffType=debuff_type;
          if HealBot_DebuffPriority[debuff_type] then
            do break end
          end
        end
        i = i + 1;
      else
        if i==1 then HealBot_UnitDebuff[unit] = nil; end
        do break end
      end 
    end
    if HealBot_UnitDebuff[unit] then
      if DebuffType and HealBot_Range_Check(unit, 27)==1 then
        if HealBot_Config.ShowDebuffWarning==1 then
          UIErrorsFrame:AddMessage(UnitName(unit).." suffers from "..DebuffType, 
                                   HealBot_Config.CDCBarColour[DebuffType].R,
                                   HealBot_Config.CDCBarColour[DebuffType].G,
                                   HealBot_Config.CDCBarColour[DebuffType].B,
                                   1, UIERRORS_HOLD_TIME);
        end
        if HealBot_Config.SoundDebuffWarning==1 then HealBot_PlaySound(HealBot_Config.SoundDebuffPlay); end
      end
    end
    HealBot_RecalcHeals(unit);
  end
end

function HealBot_OnEvent_PlayerRegenDisabled(this)
  HealBot_RecalcParty();
  if (UnitIsDeadOrGhost("player")) or (UnitOnTaxi("player")) then
    if HealBot_Config.AutoClose==1 and HealBot_Config.ActionVisible~=0 then HideUIPanel(HealBot_Action); end;
  else
    ShowUIPanel(HealBot_Action);
    HealBot_IsFighting = true;
  end
--  HealBot_RecalcHeals();
end

function HealBot_OnEvent_PlayerRegenEnabled(this)
  HealBot_IsFighting = false;
  Delay_RecalcParty=1;
end

function HealBot_OnEvent_PlayerTargetChanged(this)
  HealBot_RecalcParty();
end

function HealBot_OnEvent_PartyMembersChanged(this)
  Delay_RecalcParty=2;
end

function HealBot_OnEvent_PartyMemberDisable(this,unit)
  HealBot_RecalcHeals();  
end

function HealBot_OnEvent_SystemMsg(this,msg)
  if type(msg)=="string" then
    local tmpTest, tmpTest, deserter = string.find(msg, HB_HASLEFTRAID);
    if not deserter then
      local tmpTest, tmpTest, deserter = string.find(msg, HB_HASLEFTPARTY);
    end
    if deserter then
      if (HealBot_Healers[deserter]) then
        local tmpTest, unitname, heal_val, heal_valn
        tmpTest,tmpTest,unitname,heal_val = string.find(HealBot_Healers[deserter], ">> (%a+) <<=>> (.%d+) <<" );
        heal_valn=tonumber(heal_val)
        HealBot_Healers[deserter]=nil;
        HealBot_AddDebug("Healer "..deserter.." left the group - Last known activity was heal "..unitname.." for "..heal_val.." << trapped in event SystemMsg");
        if heal_valn>0 and HealBot_HealsIn[unitname] then
          HealBot_HealsIn[unitname] = HealBot_HealsIn[unitname] - heal_valn;
          if HealBot_HealsIn[unitname] < 0 then
	        HealBot_HealsIn[unitname]=0;
          end
        end
      end
    elseif msg==HB_YOULEAVETHEGROUP or msg==HB_YOULEAVETHERAID then
        Delay_RecalcParty=1;
    else
      -- find other messges
    end
  end
end

function HealBot_OnEvent_PartyMemberEnable(this,unit)
  HealBot_RecalcHeals();
end

function HealBot_OnEvent_PlayerEquipmentChanged(this)
  FlagEquipUpdate1=1;
end

function HealBot_OnEvent_PlayerEquipmentChanged2(this,unit)
  if unit=="player" then
    FlagEquipUpdate2=1;
  end
end

function HealBot_OnEvent_SpellsChanged(this, arg1)
  if arg1 then return; end
  HealBot_AddDebug("HB: SpellsChanged");
  InitSpells=2;
end

function HealBot_OnEvent_TalentsChanged(this, arg1)
  HealBot_AddDebug("HB: TalentsChanged");
end

function HealBot_OnEvent_BagUpdate(this,bag)
  if FlagEquipUpdate1==0 and FlagEquipUpdate2==0 then
    HealBot_RecalcSpells();
  end
end

function HealBot_OnEvent_BagUpdateCooldown(this,bag)
  if not bag then 
    bag = "undef"
  elseif FlagEquipUpdate1==0 and FlagEquipUpdate2==0 then
    HealBot_RecalcSpells();
  end
end

function HealBot_OnEvent_PlayerEnteringWorld(this)
   HealBot_IsFighting = false;
end

function HealBot_OnEvent_SpellcastStart(this,spell,duration)
  HealBot_IsCasting = true;
  HealBot_RecalcHeals();
  HealBot_CheckCasting();
  if spell==HEALBOT_RESURRECTION or spell==HEALBOT_ANCESTRALSPIRIT or spell==HEALBOT_REBIRTH or spell==HEALBOT_REDEMPTION then
    if not HealBot_IamRessing then
      if UnitName("Target") then 
        HealBot_IamRessing = UnitName("Target")
      end
    end
    if HealBot_IamRessing then
      SendAddonMessage( "CTRA", "RES "..HealBot_IamRessing,"RAID");
    end
  end
end

function HealBot_OnEvent_SpellcastStop(this)
  HealBot_IsCasting = false;
  HealBot_StopCasting();
  HealBot_RecalcHeals();
  if HealBot_IamRessing then
    SendAddonMessage( "CTRA", "RESNO","RAID");
    HealBot_IamRessing=nil;
  end
end

function HealBot_SpiBonus(spell)
	local heals_modifer = 0;
    local base, stat, posBuff, negBuff = UnitStat("player",5);
	nameTalent, icon, tier, column, currRank, maxRank = GetTalentInfo(2,14); -- Spiritual guidence
	spiGuideBonus = stat * 0.05;
	heals_modifer = heals_modifer + (currRank * spiGuideBonus);
  	return heals_modifer;
end

function HealBot_GetBonus()
  local HealBonus=HealBot_BonusScanner:GetBonus();
  return HealBonus;
end

function HealBot_FindUnitID(unitname)
  local text;
  for _,unit in ipairs(HealBot_Action_HealGroup) do
    text = UnitName(unit);
	if text then
	  if text==unitname then
	    return unit;
	  end
	end
  end
  for i=1,40 do
    local unit = "raid"..i;
	text = UnitName(unit);
	if text then
      if text==unitname then
        return unit;
      end
	end
  end
  return nil;
end

function HealBot_PlaySound(id)
  if id==1 then
    PlaySoundFile("Sound\\Doodad\\BellTollTribal.wav");
  elseif id==2 then
    PlaySoundFile("Sound\\Spells\\Thorns.wav");
  elseif id==3 then
    PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");
  end
end

function HealBot_InitSpells()
  local id = 1
  local cnt = 0;
  local class=HealBot_UnitClass("player")
  HealBot_CurrentSpells = {};
  while true do
    local spell = HealBot_GetSpellName(id);
    if not spell then
      do break end
    end
    if (HealBot_Spells[spell]) then
      HealBot_Spells[spell].id = id;
      HealBot_InitGetSpellData(spell, id, class);
      table.insert(HealBot_CurrentSpells,spell);
      cnt = cnt + 1;
    end
    id = id + 1;
  end
  if class=="PRIEST" or class=="DRUID" or class=="PALADIN" or class=="SHAMAN" then
    HealBot_AddChat("Initiated HealBot_CurrentSpells with ".. cnt .." Spells");
  end
  return cnt;
end

function HealBot_InitData() 
  HealBot_Skins = HealBot_Config.Skins;
  if(CT_RegisterMod) then
    CT_RegisterMod(HEALBOT_ADDON,"HealBot Options",5,"Interface\\AddOns\\HealBot\\Images\\HealBot","Opens HealBot Options","off",nil,HealBot_ToggleOptions);
  end

--  remove after 1.126
  local tmp=HealBot_Config.ShowHeader[HealBot_Config.Current_Skin] or 0
  HealBot_Config.ShowHeader[HealBot_Config.Current_Skin]=tmp
  
  HealBot_Options_CDCMonitor_Reset()
  HealBot_Options_EmergencyFilter_Reset()
  HealBot_Options_Debuff_Reset()
end

function HealBot_Titan_OnLoad()
  this.registry = {
    id = "HealBot",
    menuText = "HealBot",
    version = string.sub(HEALBOT_VERSION,2),
    category = "Interface",
    tooltipTitle = "HealBot Options",
    tooltipTextFunction = "HealBot_Titan_GetTooltipText",
    frequency = 0,
	icon = "Interface\\AddOns\\HealBot\\Images\\HealBot"
  };
end

function HealBot_Titan_GetTooltipText()
    return "Click to toggle options panel";
end

function HealBot_ToggleOptions()
  HealBot_TogglePanel(HealBot_Options)
end
  
function HealBot_InitGetSpellData(spell, id, class)

  local i, HB_mana, HB_cast, HB_HealsMin, HB_HealsMax, HB_HealsExt, HB_duration, HB_range, HB_shield, HB_channel;
  local tooltip = getglobal( "HealBot_ScanTooltip" );
  local tmpText, line, tmpTest

  if ( not spell ) then
    return;
  end

  HealBot_ScanTooltip:SetOwner(HealBot_ScanTooltip, "ANCHOR_NONE")
  HealBot_ScanTooltip:SetSpell( id, BOOKTYPE_SPELL );
  tmpText = getglobal("HealBot_ScanTooltipTextLeft2");
  if (tmpText:GetText()) then
    line = tmpText:GetText();
    tmpTest,tmpTest,HB_mana = string.find(line, HB_TOOLTIP_MANA ); 
  else
    HealBot_Report_Error( "================================" );
    HealBot_Report_Error( "ERROR: HealBot_ScanTooltip is lost" );
    HealBot_Report_Error( "ERROR: If BonusScanner is used, try disabling BonusScanner" );
  end

  tmpText = getglobal("HealBot_ScanTooltipTextRight2");
  if (tmpText:GetText()) then
    line = tmpText:GetText();
    tmpTest,tmpTest,HB_range = string.find(line, HB_TOOLTIP_RANGE ); 
  else
    HealBot_Report_Error( "================================" );
    HealBot_Report_Error( "ERROR: HealBot_ScanTooltip is lost" );
    HealBot_Report_Error( "ERROR: If BonusScanner is used, try disabling BonusScanner" );
  end  

  tmpText = getglobal("HealBot_ScanTooltipTextLeft3");
  HB_cast = nil;
  if (tmpText:GetText()) then
    line = tmpText:GetText();
    if ( line == HB_TOOLTIP_INSTANT_CAST ) then
      HB_cast = 0;
    elseif line == HB_TOOLTIP_CHANNELED then
	  HB_cast = 0;
	elseif ( tmpText ) then
      tmpTest,tmpTest,HB_cast = string.find(line, HB_TOOLTIP_CAST_TIME ); 
    end
  else
    HealBot_Report_Error( "================================" );
    HealBot_Report_Error( "ERROR: HealBot_ScanTooltip is lost" );
    HealBot_Report_Error( "ERROR: If BonusScanner is used, try disabling BonusScanner" );
  end  

  tmpText = getglobal("HealBot_ScanTooltipTextLeft4");
  tmpTest = nil;
  if (tmpText:GetText()) then
    line = tmpText:GetText();
	if class == "PRIEST" then
      if strsub(spell, 0, 14) == strsub(HEALBOT_POWER_WORD_SHIELD, 0, 14) then
        tmpTest,tmpTest,HB_HealsMin,HB_shield = string.find(line, HB_SPELL_PATTERN_SHIELD );    
        HB_HealsExt=0;
	    HB_HealsMax=HB_HealsMin;
      elseif strsub(spell, 0, 4) == strsub(HEALBOT_RENEW, 0, 4) then
        tmpTest,tmpTest,HB_HealsExt,tmpTest,HB_duration = string.find(line, HB_SPELL_PATTERN_RENEW );  
        HB_HealsMin=0;
        HB_HealsMax=0;
        if ( HB_HealsExt == nil ) then
          tmpTest,tmpTest,HB_HealsExt,HB_duration = string.find(line, HB_SPELL_PATTERN_RENEW1 );
        end
        if ( HB_HealsExt == nil ) then
          tmpTest,tmpTest,HB_duration,HB_HealsExt = string.find(line, HB_SPELL_PATTERN_RENEW2 );
        end
        if ( HB_HealsExt == nil ) then
          tmpTest,tmpTest,HB_duration,HB_HealsExt = string.find(line, HB_SPELL_PATTERN_RENEW3 );
        end
      elseif strsub(spell, 0, 9) == strsub(HEALBOT_LESSER_HEAL, 0, 9) then
        tmpTest,HB_HealsMin,HB_HealsMax = HealBot_Generic_Patten(line,HB_SPELL_PATTERN_LESSER_HEAL); 
      elseif strsub(spell, 0, 9) == strsub(HEALBOT_GREATER_HEAL, 0, 9) then
        tmpTest,HB_HealsMin,HB_HealsMax = HealBot_Generic_Patten(line, HB_SPELL_PATTERN_GREATER_HEAL ); 
      elseif strsub(spell, 0, 9) == strsub(HEALBOT_FLASH_HEAL, 0, 9) then
        tmpTest,HB_HealsMin,HB_HealsMax = HealBot_Generic_Patten(line, HB_SPELL_PATTERN_FLASH_HEAL ); 
      elseif strsub(spell, 0, 4) == strsub(HEALBOT_HEAL, 0, 4) then
        tmpTest,HB_HealsMin,HB_HealsMax = HealBot_Generic_Patten(line, HB_SPELL_PATTERN_HEAL ); 
      end
    elseif class=="DRUID" then
      if strsub(spell, 0, 6) == strsub(HEALBOT_REGROWTH, 0, 6) then
        tmpTest,tmpTest,HB_HealsMin,HB_HealsMax,HB_HealsExt = string.find(line, HB_SPELL_PATTERN_REGROWTH );
        if ( tmpTest == nil ) then
          tmpTest,tmpTest,HB_HealsMin,HB_HealsMax,tmpTest,HB_HealsExt = string.find(line, HB_SPELL_PATTERN_REGROWTH1 );
        end
      elseif strsub(spell, 0, 9) == strsub(HEALBOT_REJUVENATION, 0, 9) then
        tmpTest,tmpTest,HB_HealsExt,HB_duration = string.find(line, HB_SPELL_PATTERN_REJUVENATION );  
        HB_HealsMin=0;
        HB_HealsMax=0;
        if ( HB_HealsExt == nil ) then
          tmpTest,tmpTest,HB_HealsExt,tmpTest,HB_duration = string.find(line, HB_SPELL_PATTERN_REJUVENATION1 );
        end
      elseif strsub(spell, 0, 7) == strsub(HEALBOT_HEALING_TOUCH, 0, 7) then
        tmpTest,HB_HealsMin,HB_HealsMax = HealBot_Generic_Patten(line, HB_SPELL_PATTERN_HEALING_TOUCH ); 
      end
	elseif class=="PALADIN" then
      if strsub(spell, 0, 9) == strsub(HEALBOT_HOLY_LIGHT, 0, 9) then
        tmpTest,HB_HealsMin,HB_HealsMax = HealBot_Generic_Patten(line, HB_SPELL_PATTERN_HOLY_LIGHT ); 
      elseif strsub(spell, 0, 9) == strsub(HEALBOT_FLASH_OF_LIGHT, 0, 9) then
        tmpTest,HB_HealsMin,HB_HealsMax = HealBot_Generic_Patten(line, HB_SPELL_PATTERN_FLASH_OF_LIGHT ); 
      end
	elseif class=="SHAMAN" then
      if strsub(spell, 0, 9) == strsub(HEALBOT_HEALING_WAVE, 0, 9) then
        tmpTest,HB_HealsMin,HB_HealsMax = HealBot_Generic_Patten(line, HB_SPELL_PATTERN_HEALING_WAVE ); 
      elseif strsub(spell, 0, 9) == strsub(HEALBOT_LESSER_HEALING_WAVE, 0, 9) then
        tmpTest,HB_HealsMin,HB_HealsMax = HealBot_Generic_Patten(line, HB_SPELL_PATTERN_LESSER_HEALING_WAVE ); 
      end
	end
  else
    HealBot_Report_Error( "================================" );
    HealBot_Report_Error( "ERROR: HealBot_ScanTooltip is lost" );
    HealBot_Report_Error( "ERROR: If BonusScanner is used, try disabling BonusScanner" );
  end  

  if ( HB_mana == nil ) then
    HealBot_Report_Error( "================================" );
    HealBot_Report_Error( "ERROR: HB_mana is NIL" );
    HealBot_Report_Error( "ERROR: Spell: "..spell );
    if HealBot_ScanTooltipTextLeft2:GetText() then
      HealBot_Report_Error( "ERROR: Tooltip = >> "..HealBot_ScanTooltipTextLeft2:GetText().." <<" );
    end
    HealBot_Report_Error( "ERROR: Patten = >> "..HB_TOOLTIP_MANA.." <<" );
  end
  if ( HB_range == nil ) then
    HealBot_Report_Error( "================================" );
    HealBot_Report_Error( "ERROR: HB_range is NIL" );
    HealBot_Report_Error( "ERROR: Spell: "..spell );
	if HealBot_ScanTooltipTextRight2:GetText() then
      HealBot_Report_Error( "ERROR: Tooltip = >> "..HealBot_ScanTooltipTextRight2:GetText().." <<" );
    end
    HealBot_Report_Error( "ERROR: Patten = >> "..HB_TOOLTIP_RANGE.." <<" );
  end  
  if ( HB_cast == nil ) then
    HealBot_Report_Error( "================================" );
    HealBot_Report_Error( "ERROR: HB_cast is NIL" );
    HealBot_Report_Error( "ERROR: Spell: "..spell );
	if HealBot_ScanTooltipTextLeft3:GetText() then
      HealBot_Report_Error( "ERROR: Tooltip = >> "..HealBot_ScanTooltipTextLeft3:GetText().." <<" );
    end
    HealBot_Report_Error( "ERROR: Patten = >> "..HB_TOOLTIP_CAST_TIME.." <<" );
  end  
  if ( tmpTest == nil ) then
    HealBot_Report_Error( "================================" );
    HealBot_Report_Error( "ERROR: tmpTest == nil" );
    HealBot_Report_Error( "ERROR: spell = "..spell );
    if line then
      HealBot_Report_Error( "ERROR: Tooltip = >> "..line.." <<" );
    end
  end  
  
  HealBot_Spells[spell].CastTime=tonumber(HB_cast);
  HealBot_Spells[spell].Mana=tonumber(HB_mana);
  HealBot_Spells[spell].Range=tonumber(HB_range);
  HealBot_Spells[spell].HealsMin=tonumber(HB_HealsMin);
  HealBot_Spells[spell].HealsMax=tonumber(HB_HealsMax);
  if HB_HealsExt then
    HealBot_Spells[spell].HealsExt=tonumber(HB_HealsExt);
  end
  if HB_duration then
    HealBot_Spells[spell].Duration=tonumber(HB_duration);
  end
  if HB_shield then
    HealBot_Spells[spell].Shield=tonumber(HB_shield);
  end
  if HB_channel then
    HealBot_Spells[spell].Channel=tonumber(HB_channel);
  end
  
  if not HealBot_Spells[spell].Target then
    HealBot_Spells[spell].Target = {"player","party","pet"};
  end
  if not HealBot_Spells[spell].Price then
    HealBot_Spells[spell].Price = 0;
  end
  if not HealBot_Spells[spell].Channel then
    HealBot_Spells[spell].Channel = HealBot_Spells[spell].CastTime;
  end
  if not HealBot_Spells[spell].Duration then
    HealBot_Spells[spell].Duration = HealBot_Spells[spell].Channel;
  end
  if not HealBot_Spells[spell].RealHealing then
    HealBot_Spells[spell].RealHealing=0;
  end
  HealBot_Spells[spell].HealsCast = (HealBot_Spells[spell].HealsMin+HealBot_Spells[spell].HealsMax)/2;
  if not HealBot_Spells[spell].HealsExt then
    HealBot_Spells[spell].HealsExt = 0;
  end

end

function HealBot_Generic_Patten(matchStr,matchPattern)
  local tmpTest,HB_HealsMin,HB_HealsMax,HB_HealsExt,HB_duration
    tmpTest,tmpTest,HB_HealsMin,HB_HealsMax = string.find(matchStr, matchPattern ); 
  if ( tmpTest == nil ) then
    HealBot_Report_Error( "================================" );
    HealBot_Report_Error( "ERROR: tmpTest == nil" );
    HealBot_Report_Error( "ERROR: pattern = "..matchPattern );
    HealBot_Report_Error( "ERROR: Tooltip = >> "..matchStr.." <<" );
  end
  return tmpTest,HB_HealsMin,HB_HealsMax;
end

function HealBot_Get_DebugChan()
	local index = GetChannelName("HBmsg");
	if (index>0) then
		return index;
	else
		return nil;
	end
end

function HealBot_Range_Check(unit, range)

  local return_val = 0;
  if not range then 
    range=40;
  end
  if ( unit=="player" ) then 
    return_val = 1;
  elseif ( UnitIsVisible(unit) == 1) then
    local tx, ty = GetPlayerMapPosition(unit)
    local dist
    if tx > 0 or ty > 0 then
      local px, py = GetPlayerMapPosition("player")
      dist = sqrt((px - tx)^2 + (py - ty)^2)
      if dist > HB_scale and (px > 0 or py > 0) then
        if (CheckInteractDistance(unit, 4)) then
          HB_scale = dist
        end
      end
      if dist <=(HB_scale*range/27) then
        return_val=1
      end
    else
      if (HealBot_Config.QualityRange == 1) or range <= 27 then
        if ( CheckInteractDistance(unit, 4) ) then
          return_val = 1;
        end                    
      else
        return_val = 1;
      end
    end
  end
  return return_val;
end
