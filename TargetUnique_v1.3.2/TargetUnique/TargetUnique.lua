
--[[
TargetUnique, a simple mod to select as your target the next
thing you mouseover that is not targeted by any other member of
your raid or party.
--]]

-- messages; these will go in localization
BINDING_HEADER_TARGETUNIQUE = "TargetUnique"
BINDING_NAME_TUQ_TOGGLETARGET = TUQ_STRING_BINDING_NAME_TUQ_TOGGLETARGET
BINDING_NAME_TUQ_NEARESTUNIQUE = TUQ_STRING_BINDING_NAME_TUQ_NEARESTUNIQUE
BINDING_NAME_TUQ_OPENCONFIG = TUQ_STRING_BINDING_NAME_TUQ_OPENCONFIG
BINDING_NAME_TUQ_PAINT = TUQ_STRING_BINDING_NAME_TUQ_PAINT
BINDING_NAME_TUQ_ERASE = TUQ_STRING_BINDING_NAME_TUQ_ERASE

TUQ_ID = "TARGETUNIQUE"
TUQ_VERSION = 130
TUQ_LOG = false
TUQ_IS_TARGETING = false
TUQ_IS_PAINTING = false
TUQ_IS_ERASING = false
TUQ_NEXT_PAINT_INDEX = 1
TUQ_JUST_CHECK_CTRA_TANKS = false
TUQ_CHECK_BY_CLASS = false
TUQ_CLASSES = {
   ["Druid"]=false,
   ["Hunter"]=false,
   ["Mage"]=false,
   ["Paladin"]=false,
   ["Priest"]=false,
   ["Rogue"]=false,
   ["Shaman"]=false,
   ["Warlock"]=false,
   ["Warrior"]=false
}

TUQ_RAID_TARGETS = {8,7,6,5,4,3,2,1}

TUQ_LOGGER = YAK_LOGGER:Create(TUQ_LOG, {0.5,0.5,0.5})

function TUQ_Log( msg ) 
   TUQ_LOGGER:Log(msg)
end

function TUQ_OnLoad()
   this:RegisterEvent("ADDON_LOADED")
   this:RegisterEvent("VARIABLES_LOADED")
   this:RegisterEvent("UPDATE_MOUSEOVER_UNIT")

   -- slash commands
   SLASH_TARGETUNIQUE1 = "/targetunique"
   SLASH_TARGETUNIQUE2 = "/tuq"
   SlashCmdList["TARGETUNIQUE"] = TUQ_ConsoleCommand
end

function TUQ_BoolString(f)
   if (f) then
      return "True"
   else
      return "False"
   end
end

function TUQ_OnEvent(event)
   -- process our incoming events
   if ( event == "ADDON_LOADED" ) then
      TUQ_Log("Addon Loaded")
   elseif ( event == "VARIABLES_LOADED" ) then
      TUQ_Log("Variables Loaded; TargetUnique ready to go")
   elseif (event == "UPDATE_MOUSEOVER_UNIT") then
      TUQ_Log("Moused over " .. UnitName("mouseover" ))
      TUQ_OnMouseover()
   end
end

function TUQ_IsCheckablePlayerClass( playerID )
   -- Checks class of player (unitID) to see if it's 
   -- acceptable to check for unique units
   if TUQ_CHECK_BY_CLASS then
      for key,value in TUQ_CLASSES do
	 if value and key == UnitClass(playerID) then
	    return true
	 end
      end
   else 
      return true
   end
   return false
end

function TUQ_IsPlayersTargetMyMouseover( playerID, unit )
   -- Passed a player's unitId, checks to see if their class
   -- is acceptable, then checks to see if their target
   -- is the same as the current mouseover
   return TUQ_IsCheckablePlayerClass( playerID ) and UnitIsUnit(unit, playerID.."target")
end

function TUQ_IsUniqueMouseoverHelper(player_unit, target_unit, check_useful)
   if TUQ_IsPlayersTargetMyMouseover(player_unit, target_unit) then
      if check_useful then
	 if TUQ_IsUsefulTank(player_unit) then
	    TUQ_Log(UnitName(player_unit).." is useful")
	    return false
	 end
      else
	 return false
      end
   end
   return true
end

function TUQ_IsUniqueMouseover(unit, check_useful)
   --pass the unit that you want to check
   unit = unit or "mouseover"
   check_useful = check_useful or false
   if (TUQ_IsInGroup()) then
      if (UnitInParty(unit)) then
	 return false
      else
	 for k,unitId in yak_eachPartyID() do
	    TUQ_Log("Checking against "..UnitName(unitId))
	    if not TUQ_IsUniqueMouseoverHelper( unitId, unit, check_useful ) then
	       return false
	    end
	 end
      end
   elseif (TUQ_IsInRaid()) then
      if UnitInRaid(unit) then
	 -- don't target members of the raid!
	 return false
      elseif TUQ_JUST_CHECK_CTRA_TANKS then
	 TUQ_Log("Checking tanks")
	 -- just iterate over the CTRA tanks list
	 for k, unitId in yak_eachCTRATankID() do
	    if not TUQ_IsUniqueMouseoverHelper( unitId, unit, check_useful ) then
	       return false
	    end
	 end
      else
	 -- nope, we want to check the WHOLE raid
	 TUQ_Log("Checking whole raid")
	 for k, unitId in yak_eachRaidID() do
	    TUQ_Log("Checking "..UnitName(unitId))
	    if TUQ_IsPlayersTargetMyMouseover(unitId,unit) then
	       TUQ_Log(UnitName(unitId).. " is targeting " .. tostring(UnitName(unit)))
	       if not TUQ_IsUniqueMouseoverHelper( unitId, unit, check_useful ) then
		  return false
	       end
	    end
	 end
      end
   end
   return true;
end

function TUQ_IsUsefulTank(unit)
   return (not UnitIsDeadOrGhost(unit)) and (not UnitIsCharmed(unit)) and (UnitIsConnected(unit))
end

function TUQ_ToggleTarget()
  if (TUQ_IS_TARGETING) then
     yak_print(TUQ_STRING_STOPPING_ACQUISITION)
--     SetCursor(ATTACK_CURSOR)
     TUQ_IS_TARGETING = false
  else
     yak_print(TUQ_STRING_STARTING_ACQUISITION)
--     SetCursor("Interface\\Addons\\TargetUnique\\Cursor\\tuq_cursor.blp")
     TUQ_IS_TARGETING = true
     ClearTarget()
  end
end

function TUQ_ToggleErase()
   if (TUQ_IS_PAINTING) then
      TUQ_IS_PAINTING = false
      TUQ_IS_ERASING = true
      yak_print(TUQ_STRING_STARTING_ERASING)
   else
      if TUQ_IS_ERASING then
	 TUQ_IS_ERASING = false
	 yak_print(TUQ_STRING_STOPPING_ERASING)
      else
	 TUQ_IS_ERASING = true
	 yak_print(TUQ_STRING_STARTING_ERASING)
      end
   end
end

function TUQ_TogglePaint()
   if (TUQ_IS_ERASING) then
      TUQ_IS_ERASING = false
      TUQ_IS_PAINTING = true
      yak_print(TUQ_STRING_STARTING_PAINTING)
   else
      if (TUQ_IS_PAINTING) then
	 yak_print(TUQ_STRING_STOPPING_PAINTING)
	 TUQ_IS_PAINTING = false
      else
	 yak_print(TUQ_STRING_STARTING_PAINTING)
	 TUQ_IS_PAINTING = true
	 TUQ_NEXT_PAINT_INDEX = 1
      end
   end
end

function TUQ_PaintMouseover()
   if (TUQ_NEXT_PAINT_INDEX < 9) then
      SetRaidTarget("mouseover", TUQ_RAID_TARGETS[TUQ_NEXT_PAINT_INDEX])
      TUQ_NEXT_PAINT_INDEX = TUQ_NEXT_PAINT_INDEX + 1
   else
      TUQ_TogglePaint()
   end
end

function TUQ_EraseMouseover()
   SetRaidTarget("mouseover", 0)
end

function TUQ_TargetNearestUnique()
   found_target = false
   ClearTarget()
   local counter = 0
   while counter < 10 and (not found_target) do
      counter = counter + 1
      TargetNearestEnemy()
      TUQ_Log("Checking " .. tostring(UnitName("target")))
      if TUQ_IsUniqueMouseover("target", true) then
	 found_target = true
      end
   end
   -- no target found
   if not found_target then
      ClearTarget()
   end
end

function TUQ_ToggleConfig()
   if TargetUniqueConfigFrame:IsVisible() then
      TargetUniqueConfigFrame:Hide()
   else
      TargetUniqueConfigFrame:Show()
   end
end
   
function TUQ_ConsoleCommand( message )
   -- parse and act on our console commands
   -- an empty command (/tuq) prints help text
   -- right now, just lets us try targeting
   local command
   local args
   TUQ_Log("TUQ Received Command: " .. message )
   command, args = yak_console_command_string( message )
   TUQ_Log("TUQ Command: " .. tostring(command) )
   if command == "target" then
      TUQ_ToggleTarget()
   elseif command == "nearest" then
      TUQ_TargetNearestUnique()
   elseif command == "log" then
      if TUQ_LOG then
	 TUQ_LOG = false
	 yak_print("TargetUnique: Logging Disabled")
      else
	 TUQ_LOG = true
	 yak_print("TargetUnique: Logging Enabled")
      end
      TUQ_LOGGER:SetLog(TUQ_LOG)
   elseif command == "toggletanks" then
      if TUQ_JUST_CHECK_CTRA_TANKS then
	 TUQ_JUST_CHECK_CTRA_TANKS = false
	 yak_print(TUQ_STRING_NOW_CHECKING_ENTIRE_RAID)
      else
	 TUQ_JUST_CHECK_CTRA_TANKS = true
	 yak_print(TUQ_STRING_NOW_CHECKING_ONLY_TANK_LIST)
      end
   elseif command == "config" then
      TUQ_ToggleConfig()
   elseif command == "paint" then
      TUQ_TogglePaint()
   elseif command == "erase" then
      TUQ_ToggleErase()
   elseif command == "raidtargets" then
      TUQ_Log("RaidTargets selected--incomplete")
   else
      -- print usage
      yak_print(TUQ_STRING_HELP_1)
      yak_print(TUQ_STRING_HELP_2)
      yak_print(TUQ_STRING_HELP_3)
      yak_print(TUQ_STRING_HELP_4)
      yak_print(TUQ_STRING_HELP_5)
      if (TUQ_JUST_CHECK_CTRA_TANKS) then
	 yak_print(TUQ_STRING_CHECKING_ONLY_TANKS)
      else
	 yak_print(TUQ_STRING_CHECKING_ENTIRE_RAID)
      end
   end
end

function TUQ_IsInGroup()
   return ((not TUQ_IsInRaid()) and (GetNumPartyMembers() > 0))
end

function TUQ_IsInRaid()
   return (GetNumRaidMembers() > 0)
end

function TUQ_OnMouseover()
   if (TUQ_IS_TARGETING) then
      if (UnitIsEnemy("player","mouseover") and TUQ_IsUniqueMouseover()) then
	 TUQ_Log("UNIQUE MOUSEOVER--TARGETING " .. UnitName("mouseover"))
	 yak_print(TUQ_STRING_ACQUIRED .. UnitName("mouseover"))
	 TargetUnit("mouseover")
	 TUQ_IS_TARGETING = false
      end
   end
   if (TUQ_IS_PAINTING) then
      if UnitIsEnemy("player", "mouseover") and (GetRaidTargetIndex("mouseover")==0 or GetRaidTargetIndex("mouseover")==nil) then
	 TUQ_PaintMouseover()
      end
   elseif TUQ_IS_ERASING then
      if UnitIsEnemy("player", "mouseover") and (GetRaidTargetIndex("mouseover") ~= 0) then
	 TUQ_EraseMouseover()
      end
   end
end


--[[
Configuration functions.  For whatever reason, putting these in a
separate file simply causes them to not load.  I have no earthly
idea why yet.
--]]
function TUQConfig_OnShow()
   -- make sure profile is loaded
   -- read settings
   TUQ_Log("OnShow called")
   local var = function(name)
      return getglobal(this:GetName().."CheckButton"..name)
   end
   TUQ_Log("Setting JustTanks to " .. TUQ_BoolString(TUQ_JUST_CHECK_CTRA_TANKS ))
   var("JustTanks"):SetChecked( TUQ_JUST_CHECK_CTRA_TANKS );
   TUQ_Log("Setting ByClass to " .. TUQ_BoolString(TUQ_CHECK_BY_CLASS ))
   var("ByClass"):SetChecked( TUQ_CHECK_BY_CLASS );
   for key, value in TUQ_CLASSES do
      TUQ_Log("Setting "..key.." to "..TUQ_BoolString(value))
      var(key):SetChecked(TUQ_CLASSES[key])
      if TUQ_CHECK_BY_CLASS then
	 TUQ_Log("Enabling" .. key)
	 var(key):Enable()
      else
	 TUQ_Log("Disabling" .. key)
	 var(key):Disable()
      end
   end
end   

function TUQConfig_OnTankCheckboxClick()
   TUQ_Log("Checked Checkbox"..this:GetName())
   assert( this:GetName() == (this:GetParent():GetName().."CheckButtonJustTanks"))
   TUQ_Log("Setting to "..TUQ_BoolString(this:GetChecked()))
   TUQ_JUST_CHECK_CTRA_TANKS = this:GetChecked()
end

function TUQ_SetDefaults()
   TUQ_JUST_CHECK_CTRA_TANKS = true
   TUQ_CHECK_BY_CLASS = false
   for key, value in TUQ_CLASSES do
      TUQ_CLASSES[key]=false
   end
   TargetUniqueConfigFrameCheckButtonJustTanks:SetChecked( TUQ_JUST_CHECK_CTRA_TANKS )
   TargetUniqueConfigFrameCheckButtonByClass:SetChecked( TUQ_CHECK_BY_CLASS )
   for key,value in TUQ_CLASSES do
      getglobal("TargetUniqueConfigFrameCheckButton"..key):SetChecked(TUQ_CLASSES[key])
   end
end

function TUQConfig_OnClassesCheckboxClick()
   TUQ_Log("Checked 'by classes' checkbox")
   assert( this:GetName() == (this:GetParent():GetName().."CheckButtonByClass"))
   TUQ_Log("Setting to "..TUQ_BoolString(this:GetChecked()))
   TUQ_CHECK_BY_CLASS = this:GetChecked()
   for key,value in TUQ_CLASSES do
      local button_name = getglobal("TargetUniqueConfigFrameCheckButton"..key)
      if TUQ_CHECK_BY_CLASS then
	 button_name:Enable()
      else
	 button_name:Disable()
      end
   end
end

function TUQConfig_OnClassCheckboxClick(class)
   TUQ_Log("Checked class: " .. class)
   assert( this:GetName() == (this:GetParent():GetName().."CheckButton"..class))
   TUQ_Log("Setting to " ..TUQ_BoolString(this:GetChecked()))
   TUQ_CLASSES[class]=this:GetChecked()
end