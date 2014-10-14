-- PocketHelper implementation code
--
-- These are set up by localization.lua:
--   PocketHelper.PICKPOCKET_TEXTURE = "Interface\\Icons\\INV_Misc_Bag_11";
--   PocketHelper.PICKPOCKET_NAME = "Pick Pocket";
--
-- These are set up here for access from the .xml file
--   PocketHelper.OnEvent       -- Event handler for main frame
--   PocketHelper.OnLoad        -- On load handler for main frame
--   PocketHelper.ActionOnShow  -- OnShow handler for Action frame

-- Grab a local reference to the PocketHelper global table to avoid
-- extra lookups.
local PH = PocketHelper;

---------------------------------------------------------------------------
-- Local state variables
-- Action ID for the skill, or 0 if not found
local PocketHelper_ActionID=0;
-- Slot ID for the loot window, or 0 if unknown
local PocketHelper_LootID=0;

-- Indicate if PocketHelper should be active at all
local PocketHelper_IsActive=false;
-- Indicate if PocketHelper loot button should be active
local PocketHelper_LootActive=false;

-- Indicate that OnUpdate handler needs to do loot update
local PocketHelper_DoLoot=false;
-- Indicate that OnUpdate handler needs to do action find update
local PocketHelper_DoFind=false;
-- Indicate that OnUpdate handler needs to do check active update
local PocketHelper_DoActive=false;

local PocketHelper_Config_Scale = 1.25;
local PocketHelper_Config_Alpha = 0.5;
local PocketHelper_Config_X_Offset = 0;
local PocketHelper_Config_Y_Offset = 0;
local PocketHelper_Config_Disabled = nil;
local PocketHelper_Config_In_Range = nil;
local PocketHelper_Config_Check_Combat = nil;

local PocketHelper_Toggle_Hidden = nil;

--local function debug(msg)
--   DEFAULT_CHAT_FRAME:AddMessage("PH: " .. msg);
--end

---------------------------------------------------------------------------
-- Hook the GetPagedID function, since this is the only way of doing
-- a 'free' button that I know of
local Old_ActionButton_GetPagedID = ActionButton_GetPagedID;
local function PH_ActionButton_GetPagedID(button)
   if (button == PocketHelperAction) then
      if (PocketHelper_ActionID == 0) then
	 -- Make sure the return is always valid
	 return 1;
      else
	 return PocketHelper_ActionID;
      end
   end
   return Old_ActionButton_GetPagedID(button);
end
ActionButton_GetPagedID = PH_ActionButton_GetPagedID;

-- Hook the UpdateHotkeys function so that we can display range indicator
local Old_ActionButton_UpdateHotkeys = ActionButton_UpdateHotkeys;
local function PH_ActionButton_UpdateHotkeys(actionButtonType)
   if (this == PocketHelperAction) then
      PocketHelperActionHotKey:SetText("PH");
      return;
   end
   return Old_ActionButton_UpdateHotkeys(actionButtonType);
end
ActionButton_UpdateHotkeys = PH_ActionButton_UpdateHotkeys;

-- Return message from message catalog
function PH.GetMessage(msgKey, ...)
   local msg = PH.MSG[msgKey];
   if (msg == nil) then
      if (msgKey == "MissingMessage") then
	 return nil;
      end
      local missing = PH.GetMessage("MissingMessage", msgKey);
      if (not missing) then
	 return "[[MISSING POCKETHELPER MESSAGE - " .. msgKey .. "]]";
      end
      return missing;
   elseif (arg.n > 0) then
      return string.format(msg, unpack(arg));
   end
   return msg;
end

-- Show notification message from message catalog
function PH.Write(msgKey, ...)
   local msg = PH.GetMessage(msgKey,unpack(arg));
   if( DEFAULT_CHAT_FRAME ) then
      DEFAULT_CHAT_FRAME:AddMessage(msg);
   end
end

---------------------------------------------------------------------------
-- Check local state and show/hide the two buttons appropriately.
-- Only changes Show/Hide status if necessary unless force is true
local function PocketHelper_ShowHide(force)
   local showAction,showLoot;

   if (PocketHelper_IsActive) then
      if (PocketHelper_LootActive) then
	 showLoot = true;
      else
	 showAction = true;
      end
   end

   if (showAction) then
      if (not PocketHelperAction:IsShown() or force) then
	 PocketHelperAction:ClearAllPoints();
	 PocketHelperAction:SetPoint("CENTER", "UIParent", "CENTER",
				     PocketHelper_Config_X_Offset,
				     PocketHelper_Config_Y_Offset);
	 PocketHelperAction:SetScale(PocketHelper_Config_Scale);
	 PocketHelperAction:SetAlpha(PocketHelper_Config_Alpha);
	 PocketHelperAction:Show();
      end
   else
      if (PocketHelperAction:IsShown()) then
	 PocketHelperAction:Hide();
      end
   end

   if (showLoot) then
      if (not PocketHelperLoot:IsShown() or force) then
	 PocketHelperLoot:ClearAllPoints();
	 PocketHelperLoot:SetPoint("CENTER", "UIParent", "CENTER",
				   PocketHelper_Config_X_Offset,
				   PocketHelper_Config_Y_Offset);
	 PocketHelperLoot:SetScale(PocketHelper_Config_Scale);
	 PocketHelperLoot:Show();
      end
   else
      if (PocketHelperLoot:IsShown()) then
	 PocketHelperLoot:Hide();
      end
   end
end

-- Check to see if this should be visible at all, the force flag will
-- cause ShowHide to be executed even if there is no change.
local function PocketHelper_CheckActive(force)
   local newActive = 
      (not (PocketHelper_Config_Disabled or PocketHelper_Toggle_Hidden))
      and (PocketHelper_ActionID > 0) 
      and UnitExists("target") 
      and UnitCanAttack("player", "target")
      and (not UnitIsDead("target"))
      and (not UnitPlayerControlled("target"))
      and (PocketHelper_LootActive or IsUsableAction(PocketHelper_ActionID));

   -- Do these separately since we need to activate an OnUpdate handler when
   -- this check needs to be done.
   if (newActive and (PocketHelper_Config_In_Range 
		      or PocketHelper_Config_Check_Combat)) then
      PocketHelper_DoActive = true;
      if (not PocketHelperFrame:IsShown()) then
	 PocketHelperFrame:Show();
      end
      -- Need to check for 1 specifically with the range check
      if ((PocketHelper_Config_In_Range and 
	   (IsActionInRange(PocketHelper_ActionID) ~= 1)) 
	     or (PocketHelper_Config_Check_Combat and 
		 UnitAffectingCombat("target"))) then
	 if (not PocketHelper_LootActive) then
	    newActive = false;
	 end
      end
   else
      PocketHelper_DoActive = false;
   end

   -- Finally act on the result.
   if (force or (newActive ~= PocketHelper_IsActive)) then
      PocketHelper_IsActive = newActive;
      PocketHelper_ShowHide();
   end
end

-- Check to see if the loot window should be visible at all. Normally
-- this will defer itself for one frame via onUpdate, but the immediate flag
-- will force it to happen now.
local function PocketHelper_CheckLoot(immediate)
   if (not immediate) then
      PocketHelper_DoLoot = true;
      PocketHelperFrame:Show();
      return;
   end

   if (not PocketHelper_IsActive) then
      PocketHelper_LootActive = false;
      PocketHelper_ShowHide();
      return;  
   end
   
   if (not LootFrame:IsShown()) then
      PocketHelper_LootActive = false;
      -- Use CheckActive in case action was held open by loot.
      PocketHelper_CheckActive(true);
      return;
   end

   local oldLootID = PocketHelper_LootID;
   PocketHelper_LootID = nil;
   
   for slot = 1, GetNumLootItems() do
      local texture, item, quantity, quality = GetLootSlotInfo(slot)
      if (item and texture) then
	 color = ITEM_QUALITY_COLORS[quality];
	 PocketHelperLootIconTexture:SetTexture(texture);
	 PocketHelperLootText:SetText(item);
	 PocketHelperLootText:SetVertexColor(color.r, color.g, color.b);

	 local countString = PocketHelperLootCount;
	 if ( quantity > 1 ) then
	    countString:SetText(quantity);
	    countString:Show();
	 else
	    countString:Hide();
	 end

	 PocketHelper_LootID = slot;
	 PocketHelperLoot.slot = slot;
	 PocketHelperLoot:SetID(slot);
	 PocketHelperLoot:SetSlot(slot);
	 PocketHelper_LootActive = true;
	 break;
      end
   end

   PocketHelper_ShowHide();
end

-- Find the pick pocket action amongst the player's action bars.
local function PocketHelper_FindAction()
   PocketHelper_DoFind = false;
   for i=1,120 do
      -- First step checks just the texture, to avoid spamming tooltips
      if (GetActionTexture(i) == PocketHelper.PICKPOCKET_TEXTURE) then
	 -- Then we need a tooltip check, because this is infrequent I'll
	 -- be using GameTooltip, however if it's currently visible then
	 -- wait a frame and try again.
	 if (GameTooltip:IsShown()) then
	    PocketHelper_DoFind = true;
	    PocketHelperFrame:Show();
	    return;
	 end

	 -- Now check the tooltip text
	 GameTooltip:SetOwner(UIParent, "ANCHOR_NONE");
	 GameTooltip:SetAction(i);
	 local oldAlpha = GameTooltip
	 if (GameTooltipTextLeft1:GetText() == 
	     PocketHelper.PICKPOCKET_NAME) then
	    if (i == PocketHelper_ActionID) then
	       return;
	    end
	    PocketHelper_ActionID = i;
	    -- Hide it so that it updates itself when it becomes shown again
	    PocketHelperAction:Hide();
	    PocketHelper_CheckActive(true);
	    return;
	 end
      end
   end

   -- If we get here, there's no action so make sure it's zeroed out.
   if (PocketHelper_ActionID ~= 0) then
      PocketHelper_ActionID = 0;
      PocketHelper_CheckActive(true);
   end
end

-- Load the configuration settings into the appropriate local variables.
function PH.UpdateConfig()
   local PHC = PocketHelperConfig or {};

   PocketHelper_Config_Disabled = PHC.disabled;
   PocketHelper_Config_Scale = PHC.scale or 1.25;
   PocketHelper_Config_Alpha = PHC.alpha or 0.5;
   PocketHelper_Config_X_Offset = PHC.xOffset or 0;
   PocketHelper_Config_Y_Offset = PHC.yOffset or 0;
   PocketHelper_Config_In_Range = PHC.inRange;
   PocketHelper_Config_Check_Combat = PHC.checkCombat;

   PocketHelper_CheckActive();
   PocketHelper_ShowHide(true);
end

-- Set a configuration setting, and update the local config (can be skipped)
function PH.SetConfig(setting, value, noUpdate)
   if (not PocketHelperConfig) then
      PocketHelperConfig = {};
   end
   if (PocketHelperConfig[setting] ~= value) then
      PocketHelperConfig[setting] = value;
      if (not noUpdate) then
	 PH.UpdateConfig();
      end
   end
end

-- Reset all configuratoin settings and update the local config
-- (can be skipped)
function PH.ResetConfig(noUpdate)
   PocketHelperConfig = {};
   if (not noUpdate) then
      PH.UpdateConfig();
   end
end

-- Toggle shown/hidden state
function PH.ToggleHidden()
   PocketHelper_Toggle_Hidden = not PocketHelper_Toggle_Hidden;
   PocketHelper_CheckActive();
end

-- Test a provided value is a number
local function ValidateNumber(value, label)
   local num = tonumber(value);
   if (num == nil) then
      PH.Write("InvalidNumberOption", label, value);
   end
   return num;
end

-- Test a provided value is a number in a given range
local function ValidateRange(value, lo, hi, label)
   local num = ValidateNumber(value, label);
   if (num == nil) then
      return nil;
   end
   if ((num < lo) or (num > hi)) then
      PH.Write("InvalidRangeOption", label, value, lo, hi);
      return nil;
   end
   return num;
end

-- Convert a provided value into a boolean (1/nil) value
local function DecodeFlag(value, label)
   if ((value == 'off')
       or (value == 'no')
	  or (value == 'false')
	  or (value == '0')) then
      return nil;
   else
      return 1;
   end
end

-- Encode a boolean value into 1 or 0
local function EncodeFlag(value)
   return (value and '1') or '0';
end

function PH.Command(msg)
   local b,e,command,rest = string.find(msg, "^%s*([^%s]+)%s*(.*)$");
   if (not b) then
      PH.Write("ConfigHeader","v0.7");
      if (PocketHelper_Config_Disabled) then
	 PH.Write("ConfigDisabled");
      else
	 PH.Write("ConfigEnabled");
      end
      if (PocketHelper_Toggle_Hidden) then
	 PH.Write("ToggleHidden");
      end

      PH.Write("ConfigScale", PocketHelper_Config_Scale);
      PH.Write("ConfigAlpha", PocketHelper_Config_Alpha);
      PH.Write("ConfigXOffset", PocketHelper_Config_X_Offset);
      PH.Write("ConfigYOffset", PocketHelper_Config_Y_Offset);
      PH.Write("ConfigInRange", EncodeFlag(PocketHelper_Config_In_Range));
      PH.Write("ConfigCheckCombat", 
	       EncodeFlag(PocketHelper_Config_Check_Combat));

      PH.Write("ConfigOtherCommands");
      return;
   end

   if (command == 'enable') then
      PH.SetConfig("disabled", nil);
      PH.Write("SetConfigEnabled");
      return;
   end

   if (command == 'disable') then
      PH.SetConfig("disabled", 1);
      PH.Write("SetConfigDisabled");
      return;
   end

   if (command == 'reset') then
      PH.ResetConfig();
      PH.Write("ResetConfig");
      return;
   end

   if (command == 'scale') then
      local scale = ValidateRange(rest or '', 0.01, 100, "scale");
      if (not scale) then
	 return;
      end
      PH.SetConfig("scale", scale);
      PH.Write("SetConfigScale", scale);
      return
   end

   if (command == 'alpha') then
      local alpha = ValidateRange(rest or '', 0, 1, "alpha");
      if (not alpha) then
	 return;
      end
      PH.SetConfig("alpha", alpha);
      PH.Write("SetConfigAlpha", alpha);
      return
   end

   if (command == 'xoffset') then
      local offset = ValidateNumber(rest or '', "xoffset");
      if (not offset) then
	 return;
      end
      PH.SetConfig("xOffset", offset);
      PH.Write("SetConfigXOffset", offset);
      return
   end

   if (command == 'yoffset') then
      local offset = ValidateNumber(rest or '', "yoffset");
      if (not offset) then
	 return;
      end
      PH.SetConfig("yOffset", offset);
      PH.Write("SetConfigYOffset", offset);
      return
   end

   if (command == 'inrange') then
      if ((not rest) or (rest == '')) then
	 PH.Write("MissingFlagOption", "inrange");
	 return;
      end
      local flag = DecodeFlag(rest);
      PH.SetConfig("inRange", flag);
      PH.Write("SetConfigInRange", EncodeFlag(flag));
      return
   end

   if (command == 'checkcombat') then
      if ((not rest) or (rest == '')) then
	 PH.Write("MissingFlagOption", "checkcombat");
	 return;
      end
      local flag = DecodeFlag(rest);
      PH.SetConfig("checkCombat", flag);
      PH.Write("SetConfigCheckCombat", EncodeFlag(flag));
      return
   end

   PH.Write("UnknownCommand", command);
end

local function PocketHelper_WorldEntry()
   PocketHelper_FindAction();
   PocketHelper_CheckActive(true);
   if (PocketHelper_IsActive) then
      PocketHelper_CheckLoot(true);
   end
end

-- Event handler
function PH.OnEvent(event)
   -- Try and set everything up on login
   if (event == "PLAYER_ENTERING_WORLD") then
      PocketHelper_WorldEntry();
      return;
   end

   if (event == "ADDON_LOADED") then
      if (arg1 == "PocketHelper") then
	 PH.UpdateConfig();
	 -- Prepared for on-demand loading (kinda, still XML template issues)
	 if (UnitExists("player")) then
	    PocketHelper_WorldEntry();
	 end
      end
      return;
   end

   -- Things which are likely to cause the action to become valid/invalid
   if ((event == "PLAYER_AURAS_CHANGED") 
       or (event == "ACTIONBAR_UPDATE_USABLE")
       or (event == "PLAYER_ENTER_COMBAT")
       or (event == "PLAYER_LEAVE_COMBAT")
       or (event == "PLAYER_TARGET_CHANGED")) then
      PocketHelper_CheckActive();
      return;
   end

   -- Loot events
   if ((event == "LOOT_OPENED") 
       or (event == "LOOT_CLOSED") 
       or (event == "LOOT_SLOT_CLEARED")) then
      PocketHelper_CheckLoot();
      return;
   end

   -- Action change events - Attempt to only do action finding
   -- when absolutely necessaary.
   if (event == "ACTIONBAR_SLOT_CHANGED") then
      if ((arg1 == -1) 
	  or (PocketHelper_ActionID == 0)
	     or (PocketHelper_ActionID == arg1)) then
	 PocketHelper_FindAction();
      end
      return;
   end
   
   -- This should never be called in reality, but it's a cheap
   -- bug detection line.
   DEFAULT_CHAT_FRAME:AddMessage("PocketHelper dropped event " .. event);
end

-- OnUpdate handler, invoked for various tasks, but will hide itself if
-- it's invoked unnecessarily.
function PocketHelper_OnUpdate()
   local noHide = false;
   if (PocketHelper_DoFind) then
      if (not GameTooltip:IsShown()) then
	 PocketHelper_DoFind = false;
	 PocketHelper_FindAction();
      end
      noHide = true;
   end

   if (PocketHelper_DoLoot) then
      PocketHelper_DoLoot = false;
      PocketHelper_CheckLoot(true);
      noHide = true;
   end

   if (PocketHelper_DoActive) then
      PocketHelper_CheckActive();
      if (PocketHelper_Config_In_Range
       or PocketHelper_Config_Check_Combat) then
	 noHide = true;
      end
   end

   if (not noHide) then
      this:Hide();
   end
end

-- Sanity check to hide the action button if it shows itself for
-- some reason when it's not wanted.
function PH.ActionOnShow()
   if (not PocketHelper_IsActive) then
      PocketHelper_ShowHide();
   end
end

-- OnLoad simply register events, PLAYER_ENTERING_WORLD will catch
-- everything else.
function PH.OnLoad()
   this:RegisterEvent("ADDON_LOADED")

   this:RegisterEvent("PLAYER_AURAS_CHANGED")
   this:RegisterEvent("PLAYER_TARGET_CHANGED")
   this:RegisterEvent("PLAYER_ENTER_COMBAT")
   this:RegisterEvent("PLAYER_LEAVE_COMBAT")
   this:RegisterEvent("ACTIONBAR_UPDATE_USABLE")
   this:RegisterEvent("PLAYER_TARGET_CHANGED")
   this:RegisterEvent("LOOT_OPENED")
   this:RegisterEvent("LOOT_SLOT_CLEARED")
   this:RegisterEvent("LOOT_CLOSED")
   this:RegisterEvent("PLAYER_ENTERING_WORLD")
   this:RegisterEvent("ACTIONBAR_SLOT_CHANGED")

   SlashCmdList["POCKETHELPERCOMMAND"] = PH.Command;
end

