-- Squeaky_CustomOnClickFunction, CT_RA_CustomOnClickFunction
-- SqueakyWheel takes advantage of any settings to CT_RA_CustomOnClickFunction

-- If distinct behavior from CT_RA is desired, any changes to
-- Squeaky_CustomOnClickFunction take priority over CT_RA_CustomOnClickFunction
-- note:  Squeaky_CustomOnClickFunction will take priority over CT_RA_CustomOnclickFunction in the integrated CT_RA Emergency Monitor

-- Set this variable (Squeaky_CustomOnClickFunction) in your own mod to your function to handle OnClicks.
-- Two arguments are passed, button and unitid.
-- Button is a string that refers to the mouse button pressed, "LeftButton" or "RightButton".
-- unitid is a string with the unit id, such as "raid1".

-- Example: function MyFunction(button, unitid) doStuff(); end
-- Squeaky_CustomOnClickFunction = MyFunction;

-- SqueakyWheel_Translator can be configured to produce text customization.
-- One argument is passed, unitid.
-- unitid is a string with the unit id, such as "raid1".

-- internal version numbers -- do not edit
local _eventlist = {"UNIT_NAME_UPDATE","PARTY_MEMBERS_CHANGED","RAID_ROSTER_UPDATE","UNIT_PET",
                    "UNIT_HEALTH","UNIT_COMBAT","SPELLCAST_FAILED","SPELLCAST_INTERRUPTED","SPELLCAST_STOP"}

local _solo_unit = {"player"}
local _solo_unit_pet = {"player","pet"}
local _party_unit = {"player","party1","party2","party3","party4"}
local _party_unit_pet = {"player","party1","party2","party3","party4","pet","partypet1","partypet2","partypet3","partypet4"}
local _raid_unit = {"player","raid1","raid2","raid3","raid4","raid5","raid6","raid7","raid8","raid9","raid10","raid11","raid12","raid13","raid14","raid15","raid16","raid17","raid18","raid19","raid20","raid21","raid22","raid23","raid24","raid25","raid26","raid27","raid28","raid29","raid30","raid31","raid32","raid33","raid34","raid35","raid36","raid37","raid38","raid39","raid40" }
local _raid_unit_pet = {"player","raid1","raid2","raid3","raid4","raid5","raid6","raid7","raid8","raid9","raid10","raid11","raid12","raid13","raid14","raid15","raid16","raid17","raid18","raid19","raid20","raid21","raid22","raid23","raid24","raid25","raid26","raid27","raid28","raid29","raid30","raid31","raid32","raid33","raid34","raid35","raid36","raid37","raid38","raid39","raid40","pet","raid1pet","raid2pet","raid3pet","raid4pet","raid5pet","raid6pet","raid7pet","raid8pet","raid9pet","raid10pet","raid11pet","raid12pet","raid13pet","raid14pet","raid15pet","raid16pet","raid17pet","raid18pet","raid19pet","raid20pet","raid21pet","raid22pet","raid23pet","raid24pet","raid25pet","raid26pet","raid27pet","raid28pet","raid29pet","raid30pet","raid31pet","raid32pet","raid33pet","raid34pet","raid35pet","raid36pet","raid37pet","raid38pet","raid39pet","raid40pet"}
local _units = {_solo_unit,_party_unit,_raid_unit,_solo_unit_pet,_party_unit_pet,_raid_unit_pet}

local _mode = 1  -- 1=solo, 2=party, 3=raid, 4=solopet, 5=partypet, 6=raidpet
local _available_unit = _solo_unit
local _sort_order =  {"player"}

_squeakiness = {}
local _last_squeak = {}
local _blacklist = {}
local _lastHealTarget = nil
local _isHealing = nil
local _clear = nil
local _update = nil
local _subgroup = {}
local _aggro = {}

local SQUEAK_INVALID = -99999
local SQUEAK_HIDE = -999

if not SqueakyWheel then SqueakyWheel = {} end

local COMBAT_LOG_FRAME=getglobal("ChatFrame2")
function SqueakyWheel.Debug(msg)
  if SqueakyConfig and SqueakyConfig.debugMode then
    COMBAT_LOG_FRAME:AddMessage(msg)
  end
end

function SqueakyWheel.UpdateRaidSubgroups()
  local index,subgroup
  for i=1,40 do
    index = "raid"..i
    _,_,subgroup,_,_,_,_,_,_ = GetRaidRosterInfo(i)
    _subgroup[index] = subgroup
    if UnitIsUnit("player",index) then
      _subgroup["player"] = index
    end
  end
end

function SqueakyWheel.GetRaidSubgroup(index)
  return _subgroup[index]
end

function SqueakyWheel.UpdateAggro()
  local targettarget
  _aggro = {}
  for i,unit in _available_unit do
    if UnitCanAttack(unit,unit.."target") then
      targettarget=UnitName(unit.."targettarget") or "nil"
      _aggro[targettarget] = true
    end
  end
end

-- Squeakiness calculations
-- dead people are not squeaky.
-- people on blacklist are not squeaky.
-- wounded people are squeaky (0-99 based on health)
-- wounded party members are squeaky
-- people not in LOS are -50 squeakiness
-- people within 10m are +deltaMax squeakiness
-- people that took damage within ~30m are +deltaMax squeakiness (decays 1/sec)
-- CT_RA Main Tanks and PTargets are squeaky
-- TBD:  rage is squeaky
-- TBD:  warlock/mage/priest/shaman mana is squeaky
function SqueakyWheel.GetSqueakiness(unit)
  local healthPct = UnitHealth(unit)/UnitHealthMax(unit)
  local injuryFactor = 0
  local timeFactor = 0
  local miscFactor = 0
  local squeakiness = 0
  local isMT = 0
  local name = UnitName(unit)
  if UnitIsDeadOrGhost(unit) then
--     name == nil or
--     name == UKNOWNBEING or
--     name == UNKNOWNOBJECT or
    healthPct = 1
    _last_squeak[unit]=nil
    squeakiness = SQUEAK_INVALID
  end
  if healthPct>SqueakyConfig.minHealth then
    squeakiness = SQUEAK_HIDE
  end

-- people within follow distance are very squeaky
  if CheckInteractDistance(unit,4) then
--    _blacklist[unit] = nil
    _last_squeak[unit]=GetTime()+(SqueakyConfig.deltaMax/5)
  end
-- people who have been in combat log recently are somewhat squeaky
  if _last_squeak[unit] then
    timeFactor = SqueakyConfig.deltaMax - (GetTime() - _last_squeak[unit])
    if timeFactor < 0 then
      timeFactor = 0
      _last_squeak[unit]=nil
    else
      timeFactor = timeFactor * SqueakyConfig.deltaWeight
    end
  end
  injuryFactor = (1-healthPct)*100
-- Power calculation
  if UnitManaMax(unit) > 0 then
    miscFactor = miscFactor+UnitMana(unit)/UnitManaMax(unit)*100 * SqueakyConfig.priorityPower[UnitPowerType(unit)]
  end
-- aggro
  if _aggro[name] then
    miscFactor = miscFactor+SqueakyConfig.priorityAggro
  end
-- Are priorities enabled?
  if SqueakyConfig.priority then
-- you are squeakier than raid members
    if UnitIsUnit("player",unit) then
      injuryFactor = injuryFactor * (1 + SqueakyConfig.prioritySELF)
    end
-- party members are squeakier than raid members
    if UnitInParty(unit) then
      injuryFactor = injuryFactor * (1 + SqueakyConfig.priorityPARTY)
    end
-- certain classes are squeakier
-- pets do not have classes
    local _,unitClass = UnitClass(unit)
    if not UnitIsPlayer(unit) then
      injuryFactor = injuryFactor * (1 + SqueakyConfig.priorityPET)
    elseif unitClass and SqueakyConfig["priority"..unitClass] then
      injuryFactor = injuryFactor * (1 + SqueakyConfig["priority"..unitClass])
    end
-- group assignments are squeaky
   if GetNumRaidMembers()>0 then
     injuryFactor = injuryFactor * (1 + (SqueakyConfig.prioritySubgroup[SqueakyWheel.GetRaidSubgroup(unit)] or 0))
   end
-- CT_RA Main Tanks and PTargets are extra squeaky
-- Warning:  A CT_RA Main Tank that is also a PTarget is counted twice.
    unitName = UnitName(unit)
    local MTfactor = 0
    for k, v in (CT_RA_MainTanks or {}) do
      if ( v == unitName ) then
        injuryFactor = injuryFactor* (1 + SqueakyConfig.priorityMT)
        break;
      end
    end
    for k, v in (CT_RA_PTargets or {}) do
      if ( v == unitName ) then
        injuryFactor = injuryFactor* (1 + SqueakyConfig.priorityMT)
        break;
      end
    end
  end
-- unsqueak people on blacklist and clean up blacklist
  if _blacklist[unit] then
    injuryFactor = injuryFactor / 10
    timeFactor = timeFactor / 10
    miscFactor = miscFactor / 10
    _last_squeak[unit]=nil
    if GetTime()-_blacklist[unit]>SqueakyConfig.blacklistDuration then
      _blacklist[unit]=nil
    end
  end
-- members not visible are not very squeaky
  if not UnitIsVisible(unit) then
    injuryFactor = injuryFactor / 10
    timeFactor = timeFactor / 10
    miscFactor = miscFactor / 10
  end
-- final calculation
  squeakiness = squeakiness + injuryFactor + timeFactor + miscFactor
  return squeakiness
end

function SqueakyWheel.DoSqueak(unit)
  _last_squeak[unit or "nil"]=GetTime()
end

function SqueakyWheel.UpdateSqueakiness()
  for i,unit in _available_unit do
    _squeakiness[unit] = SqueakyWheel.GetSqueakiness(unit)
  end
end

-- comparator to sort by highest squeakiness
function SqueakyWheel.squeakySortComparator(a,b)
  return (_squeakiness[a] or SQUEAK_INVALID)>(_squeakiness[b] or SQUEAK_INVALID)
end

function SqueakyWheel.SortUnits()
  table.sort(_sort_order,SqueakyWheel.squeakySortComparator)
end

-- comparator for CT_RA Emergency Monitor
function SqueakyWheel.EMSortComparator(v1,v2)
  return (_squeakiness[v1[3]] or SQUEAK_INVALID)>(_squeakiness[v2[3]] or SQUEAK_INVALID)
end

function SqueakyWheel.Register(toggle)
  for i,f in _eventlist do
    if toggle then
      this:RegisterEvent(f)
    else
      this:UnregisterEvent(f)
    end
  end
end

function SqueakyWheel.OnLoad()
  -- init
  this:RegisterEvent("ADDON_LOADED")
  this:RegisterEvent("PLAYER_ENTERING_WORLD")
  this:RegisterEvent("PLAYER_LEAVING_WORLD")

  SLASH_SQUEAKYWHEEL1 = "/squeakywheel"
  SLASH_SQUEAKYWHEEL2 = "/squeaky"
  SLASH_SQUEAKYWHEEL3 = "/squeak"
  SlashCmdList["SQUEAKYWHEEL"] = SqueakyWheel.SlashCmd
end

function SqueakyWheel.OnEvent(event,arg1,arg2)
  unit = nil
  target = nil
  local _found = false
  if (event=="UNIT_HEALTH") or 
     (event=="UNIT_AURA") then
    SqueakyWheel.Update()
  elseif (event=="UNIT_NAME_UPDATE") or
         (event=="UNIT_PET") or
         (event=="RAID_ROSTER_UPDATE") or
         (event=="PARTY_MEMBERS_CHANGED") then
    SqueakyWheel.Clear()
  elseif (event=="SPELLCAST_STOP") then
    _isHealing = false
  elseif (event=="SPELLCAST_FAILED") or
         (event=="SPELLCAST_INTERRUPTED") then
    if _isHealing and _lastHealTarget then
      SqueakyWheel.Debug("Out of Range:  ".._lastHealTarget)
      _isHealing = false
      _blacklist[_lastHealTarget]=GetTime()
      _last_squeak[_lastHealTarget]=nil
      SqueakyWheel.Update()
    end
  elseif (event=="UNIT_COMBAT") then
    SqueakyWheel.DoSqueak(arg1)
    SqueakyWheel.Update()
  elseif (event=="PLAYER_ENTERING_WORLD") then
    SqueakyWheel.Register(true)
  elseif (event=="PLAYER_LEAVING_WORLD") then
    SqueakyWheel.Register(false)
  elseif (event=="ADDON_LOADED") and
         (arg1=="SqueakyWheel") then
    local _version = GetAddOnMetadata("SqueakyWheel","Version")
    if not SqueakyConfig or 
       not SqueakyConfig.version or
       SqueakyConfig.version ~= _version then
      SqueakyConfig = SqueakyConfigDefaults
      DEFAULT_CHAT_FRAME:AddMessage(SqueakyLoc.ResetMsg)
      DEFAULT_CHAT_FRAME:AddMessage(SqueakyLoc.ResetMsg2)
    end
    SqueakyWheel.Init()
    DEFAULT_CHAT_FRAME:AddMessage(SqueakyLoc.Name.." ".._version..SqueakyLoc.Load)
  end
end

-- run once
function SqueakyWheel.Init()
  local squeakyFrame = getglobal("SqueakyWheelFrame")
  squeakyFrame:SetFrameLevel(0)
  local rgba
  if SqueakyConfig.backdropColor then
    rgba = SqueakyConfig.backdropColor
    squeakyFrame:SetBackdropColor(rgba[1],rgba[2],rgba[3],rgba[4])
  end
  if SqueakyConfig.backdropBorderColor then
    rgba = SqueakyConfig.backdropBorderColor
    squeakyFrame:SetBackdropBorderColor(rgba[1],rgba[2],rgba[3],rgba[4])
  end
  SqueakyWheel.InitTranslator()
  SqueakyConfig.priorityPower = {}
  SqueakyConfig.prioritySubgroup = {}
  SqueakyWheel.Clear()
end

-- run on raid or config change
function SqueakyWheel.Reset()
  SqueakyWheel.Debug("Resetting SqueakyWheel")
  for i=1,SqueakyConfig.healthBars do
    healthParent = getglobal("SqueakyBar"..i)
    healthText = getglobal("SqueakyBar"..i.."_Text")
    healthBar = getglobal("SqueakyBar"..i.."_Health")
    healthParent:SetHeight(SqueakyConfig.barHeight)
    healthParent:SetWidth(SqueakyConfig.barWidth)
    healthBar:SetHeight(SqueakyConfig.barHeight)
    healthBar:SetWidth(SqueakyConfig.barWidth)
    healthBar:SetMinMaxValues(0,1)
    getglobal("SqueakyBar"..i):Show()
    healthBar:SetFrameLevel(1)
  end
  for i=2,SqueakyConfig.healthBars do
    getglobal("SqueakyBar"..i):SetPoint(
     "TOPLEFT","SqueakyBar"..(i-1),"BOTTOMLEFT",0,(1-SqueakyConfig.barSpacing))
  end
  for i=SqueakyConfig.healthBars+1,15 do
    getglobal("SqueakyBar"..i):Hide()
  end
  getglobal("SqueakyWheelFrame"):SetHeight(
      (SqueakyConfig.healthBars * 
        (SqueakyConfig.barHeight + SqueakyConfig.barSpacing - 1)) + 16)
  getglobal("SqueakyWheelFrame"):SetWidth(SqueakyConfig.barWidth + 20)
  if SqueakyWheel.CT_RA then
    SqueakyWheel.CT_RA()
  end
  SqueakyConfig.priorityPower[0] = SqueakyConfig.priorityMana
  SqueakyConfig.priorityPower[1] = SqueakyConfig.priorityRage
  SqueakyConfig.priorityPower[2] = SqueakyConfig.priorityFocus
  SqueakyConfig.priorityPower[3] = SqueakyConfig.priorityEnergy
  SqueakyConfig.priorityPower[4] = SqueakyConfig.priorityHappiness
  SqueakyConfig.prioritySubgroup[1] = SqueakyConfig.priorityGroup1 and SqueakyConfig.priorityGroups
  SqueakyConfig.prioritySubgroup[2] = SqueakyConfig.priorityGroup2 and SqueakyConfig.priorityGroups
  SqueakyConfig.prioritySubgroup[3] = SqueakyConfig.priorityGroup3 and SqueakyConfig.priorityGroups
  SqueakyConfig.prioritySubgroup[4] = SqueakyConfig.priorityGroup4 and SqueakyConfig.priorityGroups
  SqueakyConfig.prioritySubgroup[5] = SqueakyConfig.priorityGroup5 and SqueakyConfig.priorityGroups
  SqueakyConfig.prioritySubgroup[6] = SqueakyConfig.priorityGroup6 and SqueakyConfig.priorityGroups
  SqueakyConfig.prioritySubgroup[7] = SqueakyConfig.priorityGroup7 and SqueakyConfig.priorityGroups
  SqueakyConfig.prioritySubgroup[8] = SqueakyConfig.priorityGroup8 and SqueakyConfig.priorityGroups

  _mode = 0
  if SqueakyConfig.displayPets then
    _mode = 3
  end
  local _show = false
  if GetNumRaidMembers()>0 then
    SqueakyWheel.UpdateRaidSubgroups()
    _mode = _mode + 3
    _show = SqueakyConfig.displayRaid
  elseif GetNumPartyMembers()>0 then
    _mode = _mode + 2
    _show = SqueakyConfig.displayParty
  else
    _mode = _mode + 1
    _show = SqueakyConfig.displaySolo
  end
  if _show then
    SqueakyWheelFrame:Show()
  else
    SqueakyWheelFrame:Hide()
  end

  _last_squeak = {}
  _available_unit = {}
  _squeakiness = {}
  _sort_order = {}
  _aggro = {}
  _master = _units[_mode]
  for i=1,getn(_master) do
    if UnitExists(_master[i]) and
      (not UnitIsUnit("player",_master[i]) or _master[i]=="player")  then
      tinsert(_available_unit,_master[i])
      tinsert(_sort_order,_master[i])
      _squeakiness[i]=SQUEAK_INVALID
    end
  end
  _squeakiness["target"]=SQUEAK_INVALID
  for i=1,SqueakyConfig.healthBars do
    healthText = getglobal("SqueakyBar"..i.."_Text")
    healthBar = getglobal("SqueakyBar"..i.."_Health")
    healthText:SetText("")
    healthText:SetTextColor(SqueakyConfig.textColor[1],SqueakyConfig.textColor[2],SqueakyConfig.textColor[3])
    healthBar:SetValue(0)
  end
end


function SqueakyWheel.Clear()
  _clear = true
  if not SqueakyWheelFrame:IsVisible() then
    SqueakyWheel.ClearNow()
  end
end

function SqueakyWheel.Update()
  _update = true
end

function SqueakyWheel.OnUpdate()
  if _clear then
    _clear = nil
    SqueakyWheel.ClearNow()
  end
  if _update then
    _update = nil
    SqueakyWheel.UpdateNow()
  end
end

-- configuration setting changed or display needs to be reset completely
function SqueakyWheel.ClearNow()
  SqueakyWheel.Reset()
  SqueakyWheel.Update()
end

-- health bar colorations
-- dark grey if dead or not visible
-- grey if no change in deltaMax seconds
-- red if nearly dead and recent change
-- green if healthy and recent change
-- red and greed fade to grey over time
function SqueakyWheel.UpdateNow()
  SqueakyWheel.UpdateSqueakiness()
  SqueakyWheel.SortUnits()
  local HealthPct
  local healthColor = {}
  local urgency
  local wtf
  local unit
  local uName
  local class
  local index=0
  local textColor
  for index=1,min(SqueakyConfig.healthBars,getn(_sort_order)) do
    unit = _sort_order[index]
    if not unit or not UnitExists(unit) then
      SqueakyWheel.Debug("SqueakyWheel: No unit found at index "..index)
      break
    end
    if (SqueakyConfig.showAll or _squeakiness[unit]>=0 ) then
      uName = UnitName(unit)-- or ""
      HealthPct = UnitHealth(unit)/UnitHealthMax(unit)
      if HealthPct and (HealthPct>=0) and (HealthPct<=1) then
        wtf = false
      else
        HealthPct = .5
        wtf = true
      end
      text = SqueakyWheel_Translator(unit) or UnitName(unit)
    else
      unit = nil
      HealthPct = 0
      text = ""
    end
    healthText = getglobal("SqueakyBar"..index.."_Text")
    healthText:SetText(text)
    if SqueakyConfig.textClassColor and unit then
      _,class = UnitClass(unit)
      textColor = RAID_CLASS_COLORS[class];
      if (textColor) then
        healthText:SetTextColor(textColor.r*SqueakyConfig.textClassColorIntensity,
                                textColor.g*SqueakyConfig.textClassColorIntensity,
                                textColor.b*SqueakyConfig.textClassColorIntensity);
      end
    end
    healthBar = getglobal("SqueakyBar"..index.."_Health")
    healthBar:SetValue(HealthPct)
    sinceLastSqueak = GetTime() - (_last_squeak[unit] or 0)
    if sinceLastSqueak > SqueakyConfig.deltaMax then sinceLastSqueak = SqueakyConfig.deltaMax end
    if sinceLastSqueak < 0 then sinceLastSqueak = 0 end
    if wtf then
      for i=1,3 do
        healthColor[i] = 1
      end
    else
      if SqueakyConfig.barClassColor and unit then
        _,class = UnitClass(unit)
        textColor = RAID_CLASS_COLORS[class];
        healthColor[1]=textColor.r*SqueakyConfig.barClassColorIntensity
        healthColor[2]=textColor.g*SqueakyConfig.barClassColorIntensity
        healthColor[3]=textColor.b*SqueakyConfig.barClassColorIntensity
      elseif UnitIsVisible(unit) and
         not UnitIsDeadOrGhost(unit) then
        for i=1,3 do
          -- base health percentage colors:  deadColor -- liveColor
          healthColor[i] = (SqueakyConfig.liveColor[i] * HealthPct) +
                           (SqueakyConfig.deadColor[i] * (1-HealthPct))
          -- time based fade to fadeColor
          healthColor[i] = (healthColor[i]*
            (SqueakyConfig.deltaMax-sinceLastSqueak)/SqueakyConfig.deltaMax)+
            (SqueakyConfig.fadeColor[i]*sinceLastSqueak/SqueakyConfig.deltaMax)
        end
      else
        -- definitely not visible, use goneColor
        for i=1,3 do
          healthColor[i] = SqueakyConfig.goneColor[i]
        end
      end
    end
    healthBar:SetStatusBarColor(healthColor[1],healthColor[2],healthColor[3])
  end
end

-- pass through to CT_RA_CustomOnClickFunction if found
-- otherwise TargetUnit
function SqueakyWheel.OnClick(button, id)
  local result
  local unit = (id and _sort_order[id]) or id or _sort_order[this:GetID()]
  if not (unit and UnitExists(unit)) then
    return
  end
  SqueakyWheel.Debug("SqueakyWheel.OnClick: "..unit.." -- "..UnitName(unit))
  local result
  if type(Squeaky_CustomOnClickFunction) == "function" then
    _isHealing = true
    _lastHealTarget = unit
    SqueakyWheel.Debug("Squeaky_CustomOnClickFunction")
    result = Squeaky_CustomOnClickFunction(button,unit)
  elseif type(CT_RA_CustomOnClickFunction) == "function" and 
         not (CT_RA_CustomOnClickFunction == SqueakyWheel_OnClick) then
    _isHealing = true
    _lastHealTarget = unit
    SqueakyWheel.Debug("CT_RA_CustomOnClickFunction")
    result = CT_RA_CustomOnClickFunction(button,unit)
  else
    TargetUnit(unit)
  end
  if (SpellIsTargeting()) then
    SpellTargetUnit(unit)
  end
  return result
end

-- returns the unit in position x
function SqueakyWheel.GetSortOrder(index)
  if index then
    return _sort_order[index]
  end
end
-- deprecated
SqueakyWheel_GetSortOrder = SqueakyWheel.GetSortOrder

function SqueakyWheel.SlashCmd(msg)
  local index, value
  if (not msg or msg == "") then --Show Config
      SqueakyMenu:Show()
      DEFAULT_CHAT_FRAME:AddMessage(SqueakyLoc.Config)
  else
    local i,j, command, param = string.find(msg,"^([^ ]+) (.+)$")
    local numParam
    if param then
      numParam = tonumber(param)
    end
    if (not command) then
      command = msg
    end
    command=strlower(command)
    if (command == SqueakyLoc.Reset) then
      SqueakyConfig = SqueakyConfigDefaults
      DEFAULT_CHAT_FRAME:AddMessage(SqueakyLoc.ResetMsg2)
    elseif (command == SqueakyLoc.Config) or (command == SqueakyLoc.Config2) then
      SqueakyMenu:Show()
      DEFAULT_CHAT_FRAME:AddMessage(SqueakyLoc.Config)
    elseif (command == SqueakyLoc.On) then
      SqueakyConfig.displaySolo = true
      SqueakyConfig.displayParty = true
      SqueakyConfig.displayRaid = true
      SqueakyWheel.Clear()
      DEFAULT_CHAT_FRAME:AddMessage(SqueakyLoc.DisplayMode..SqueakyLoc.SetTo..SqueakyLoc.On)
    elseif (command == SqueakyLoc.Off) then
      SqueakyConfig.displaySolo = nil
      SqueakyConfig.displayParty = nil
      SqueakyConfig.displayRaid = nil
      SqueakyWheel.Clear()
      DEFAULT_CHAT_FRAME:AddMessage(SqueakyLoc.DisplayMode..SqueakyLoc.SetTo..SqueakyLoc.Off)
    elseif (command == SqueakyLoc.Bars) then
      if numParam and numParam>1 and numParam<=15 then
        SqueakyConfig.healthBars = numParam
        SqueakyWheel.Clear()
        DEFAULT_CHAT_FRAME:AddMessage(SqueakyLoc.Bars..SqueakyLoc.SetTo..numParam)
      end
    elseif (command == SqueakyLoc.DeltaMax) then
      if numParam and numParam>=1 and numParam<=30 then
        SqueakyConfig.deltaMax = numParam
        SqueakyWheel.Update()
        DEFAULT_CHAT_FRAME:AddMessage(SqueakyLoc.DeltaMax..SqueakyLoc.SetTo..numParam)
      end
    elseif (command == SqueakyLoc.DeltaWeight) then
      if numParam and numParam>=1 and numParam<=20 then
        SqueakyConfig.deltaWeight = numParam
        SqueakyWheel.Update()
        DEFAULT_CHAT_FRAME:AddMessage(SqueakyLoc.DeltaWeight..SqueakyLoc.SetTo..numParam)
      end
    elseif (command == SqueakyLoc.Blacklist) then
      if numParam and numParam>=0 and numParam<=15 then
        SqueakyConfig.blacklistDuration = numParam
        SqueakyWheel.Update()
        DEFAULT_CHAT_FRAME:AddMessage(SqueakyLoc.Blacklist..SqueakyLoc.SetTo..numParam)
      end
    elseif (command == SqueakyLoc.Spacing) then
      if numParam and numParam>=0 and numParam<=10 then
        SqueakyConfig.barSpacing = numParam
        SqueakyWheel.Clear()
        DEFAULT_CHAT_FRAME:AddMessage(SqueakyLoc.Spacing..SqueakyLoc.SetTo..numParam)
      end
    elseif (command == SqueakyLoc.Height) then
      if numParam and numParam>=6 and numParam<=30 then
        SqueakyConfig.barHeight = numParam
        SqueakyWheel.Clear()
        DEFAULT_CHAT_FRAME:AddMessage(SqueakyLoc.Height..SqueakyLoc.SetTo..numParam)
      end
    elseif (command == SqueakyLoc.Width) then
      if numParam and numParam>=10 and numParam<=300 then
        SqueakyConfig.barWidth = numParam
        SqueakyWheel.Clear()
        DEFAULT_CHAT_FRAME:AddMessage(SqueakyLoc.Width..SqueakyLoc.SetTo..numParam)
      end
    elseif (command == SqueakyLoc.CT_RA) then
      local outputMsg = SqueakyLoc.ctra..SqueakyLoc.SetTo
      SqueakyConfig.emergencyMonitor = not SqueakyConfig.emergencyMonitor
      if SqueakyConfig.emergencyMonitor then
        outputMsg = outputMsg..SqueakyLoc.SetToOn
      else
        outputMsg = outputMsg..SqueakyLoc.SetToOff
      end
      DEFAULT_CHAT_FRAME:AddMessage(outputMsg)
    elseif (command == SqueakyLoc.TextClassColor) then
      local outputMsg = SqueakyLoc.TextClassColor..SqueakyLoc.SetTo
      SqueakyConfig.textClassColor = not SqueakyConfig.textClassColor
      if SqueakyConfig.textClassColor then
        outputMsg = outputMsg..SqueakyLoc.SetToOn
      else
        outputMsg = outputMsg..SqueakyLoc.SetToOff
      end
      DEFAULT_CHAT_FRAME:AddMessage(outputMsg)
    elseif (command == SqueakyLoc.Debug) then
      local outputMsg = SqueakyLoc.Debug..SqueakyLoc.SetTo
      SqueakyConfig.debugMode = not SqueakyConfig.debugMode
      if SqueakyConfig.debugMode then
        outputMsg = outputMsg..SqueakyLoc.SetToOn
      else
        outputMsg = outputMsg..SqueakyLoc.SetToOff
      end
      DEFAULT_CHAT_FRAME:AddMessage(outputMsg)
    elseif (command == SqueakyLoc.Lock) then
      local outputMsg = SqueakyLoc.Lock..SqueakyLoc.SetTo
      SqueakyConfig.lock = not SqueakyConfig.lock
      if SqueakyConfig.lock then
        outputMsg = outputMsg..SqueakyLoc.SetToOn
      else
        outputMsg = outputMsg..SqueakyLoc.SetToOff
      end
      DEFAULT_CHAT_FRAME:AddMessage(outputMsg)
    elseif (command == SqueakyLoc.ShowAll) then
      local outputMsg = SqueakyLoc.ShowAll..SqueakyLoc.SetTo
      SqueakyConfig.showAll = not SqueakyConfig.showAll
      if SqueakyConfig.showAll then
        outputMsg = outputMsg..SqueakyLoc.SetToOn
      else
        outputMsg = outputMsg..SqueakyLoc.SetToOff
      end
      DEFAULT_CHAT_FRAME:AddMessage(outputMsg)
    else --Menu
      for index, value in SqueakyLoc.HelpText do
        DEFAULT_CHAT_FRAME:AddMessage(value)
      end
    end
  end
end

function SqueakyWheel.test ()
  for i,j in _sort_order do
    SqueakyWheel.Debug("test: "..i..":"..j..":".._squeakiness[j])
  end
end

--  default text:  Name: Health%
function SqueakyWheel.TranslatorDefault(unit)
  local Name = UnitName(unit) or ""
  local HealthPct = string.format("%d",UnitHealth(unit)/UnitHealthMax(unit)*100).."%"
  local text = Name..": "..HealthPct
  return text
end

-- If CastParty is loaded, override text customization with CastParty's
function SqueakyWheel.InitTranslator()
  if CastPartyConfig and CastPartyConfig.unit_text_template and not SqueakyWheel_Translator then -- CastParty 3.9+
    SqueakyWheel_Translator = function(unit)
      CastParty_Translator(CastPartyConfig.unit_text_template,unit)
    end
  elseif _hpc and _hpc.unit_text_template and not SqueakyWheel_Translator then -- old CastParty
    SqueakyWheel_Translator = function(unit)
      CastParty_Translator(_hpc.unit_text_template,unit)
    end
  elseif not SqueakyWheel_Translator then
    SqueakyWheel_Translator = SqueakyWheel.TranslatorDefault
  end
end

-- alternate text for health deficit:  Name: HealthDeficit
-- uncomment to use
function SqueakyWheel.TranslatorDeficit(unit)
  local Name = UnitName(unit) or ""
  local HealthDeficit = UnitHealth(unit)-UnitHealthMax(unit)
  local text = Name..": "..HealthDeficit
  return text
end
--SqueakyWheel_Translator = SqueakyWheel.TranslatorDeficit
