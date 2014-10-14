-- Wrap OutfitDisplayFrame with our "improvements"
FishingBuddy.OutfitFrame = {};

local DEFAULTUPDATE_WAIT = 0.1;

local function StylePoints(outfit)
   local isp = FishingBuddy.OutfitManager.ItemStylePoints;
   local points = 0;
   if ( outfit )then
      for slot in outfit do
	 if ( outfit[slot].item ) then
	    local _,_,check, enchant = string.find(outfit[slot].item,
						   "^(%d+):(%d+)");
	    points = points + isp(check, enchant);
	 end
      end
   end
   return points;
end

local match;
local function ItemBonusPoints(item)
   local points = 0;
   if ( item and item ~= "" ) then
      if ( not match ) then
	 match = FishingBuddy.GetFishingSkillName().." %+(%d+)";
      end
      FishingOutfitTooltip:SetHyperlink("item:"..item);
      local bodyslot = FishingOutfitTooltipTextLeft2:GetText();
      local textline = 2;
      while (bodyslot) do
	 local _,_,bonus = string.find(bodyslot, match);
	 if bonus then
	    points = points + bonus;
	 end
	 textline = textline + 1;
	 bodyslot = getglobal("FishingOutfitTooltipTextLeft"..textline):GetText();
      end
      -- See if the Eternium Fishing Line has been applied
      local _,_,check, enchant = string.find(item, "^(%d+):(%d+)");
      if ( enchant == "2603" ) then
	 points = points + 5;
      end
   end
   return points;
end

local function BonusPoints(outfit)
   local points = 0;
   if ( outfit )then
      for slot in outfit do
	 points = points + ItemBonusPoints(outfit[slot].item);
      end
   end
   return points;
end

local function UpdateSwitchButton(outfit)
   local msg = OutfitDisplayFrame_SwitchWillFail(FishingOutfitFrame, outfit);
   if ( outfit and not msg ) then
      FishingOutfitSwitchButton:Enable();
   else
      FishingOutfitSwitchButton:Disable();
   end
end

-- outfit support functions
local function GetWasWearing()
   if FishingBuddy_Player["WasWearing"] then
      return FishingBuddy_Player["WasWearing"];
   end
end

local function SetWasWearing(outfit)
   FishingBuddy_Player["WasWearing"] = outfit;
end

local function GetOutfit()
   return FishingBuddy_Player["Outfit"];
end

local saved_outfit;
local function SetOutfit(outfit)
   saved_outfit = outfit;
   FishingBuddy_Player["Outfit"] = outfit;
end

local updateWait = DEFAULTUPDATE_WAIT;
FishingBuddy.OutfitFrame.Update = function(elapsed)
   updateWait = updateWait - elapsed;
   if ( updateWait <= 0 ) then
      UpdateSwitchButton(saved_outfit);
      FishingOutfitUpdate:Hide();
   end
end

local function UpdateStyleInfo()
   local points = BonusPoints(outfit);
   if ( points >= 0 ) then
      points = "+"..points;
   else
      points = 0 - points;
      points = "-"..points;
   end
   FishingOutfitSkill:SetText(FishingBuddy.CONFIG_SKILL_TEXT..points);
   points = StylePoints(outfit);
   local pstring;
   if ( points == 1 ) then
      pstring = FishingBuddy.POINT;
   else
      pstring = FishingBuddy.POINTS;
   end
   FishingOutfitStyle:SetText(FishingBuddy.CONFIG_STYLISH_TEXT..points.." "..pstring);
end

local function OutfitChanged(button)
   local outfit = OutfitDisplayFrame_GetOutfit(FishingOutfitFrame);
   if ( outfit ) then
      SetOutfit(outfit);
   end
   UpdateStyleInfo();
   FishingOutfitFrame.valid = true;
   updateWait = DEFAULTUPDATE_WAIT;
   FishingOutfitUpdate:Show();
end

FishingBuddy.OutfitFrame.OnShow = function()
   if ( not this.valid ) then
      saved_outfit = GetOutfit();
   end
   OutfitDisplayFrame_SetOutfit(FishingOutfitFrame, saved_outfit);
   UpdateSwitchButton(saved_outfit);
   if ( not this.valid ) then
      OutfitChanged();
   end
end

FishingBuddy.OutfitFrame.OnLoad = function()
   -- Handle the override
   if ( OutfitDisplayFrame_OnLoad ) then
      OutfitDisplayFrame_OnLoad();
      FishingOutfitSkill.tooltip = FishingBuddy.CONFIG_SKILL_INFO;
      FishingOutfitStyle.tooltip = FishingBuddy.CONFIG_STYLISH_INFO;
      FishingOutfitSwitchButton:SetText(FishingBuddy.SWITCHOUTFIT);
      FishingOutfitFrame.OutfitChanged = OutfitChanged;
   else
      FishingBuddy.DisableSubFrame("FishingOutfitFrame");
   end
end

FishingBuddy.OutfitFrame.OnHide = function()
   -- OutfitChanged();
end

local function ODF_Initialize()
   OutfitDisplayFrame_SetOutfit(FishingOutfitFrame, saved_outfit);
end

-- the user has chosen us, make sure everything is set up the way we need
local function ODF_Choose(useme)
   if ( FishingOutfitFrame ) then
      if ( useme ) then
	 FishingBuddy.EnableSubFrame("FishingOutfitFrame");
      else
	 FishingBuddy.DisableSubFrame("FishingOutfitFrame");
      end
   end
end
FishingBuddy.OutfitFrame.Choose = ODF_Choose;

-- only have one outfit at the moment
-- don't switch if
-- we can't find everything in the outfit
-- we have saved stuff but we're not wearing everything in the outfit
-- We don't have the outfit display frame!
local function ODF_Switch()
   if (CursorHasItem()) then
      FishingBuddy.UIError(FishingBuddy.CURSORBUSYMSG);
      return false;
   end
   if ( OutfitDisplayFrame_IsSwapping() ) then
      FishingBuddy.UIError(OUTFITDISPLAYFRAME_TOOFASTMSG);
      return false;
   end
   
   local isfishing = FishingBuddy.API.IsFishingPole();
   local outfit = GetOutfit();
   local waswearing = GetWasWearing();
   if ( waswearing ) then
      local msg;
      
      if ( isfishing ) then
	 msg = OutfitDisplayFrame_SwitchWillFail(FishingOutfitFrame, waswearing);
      else
	 msg = FishingBuddy.CANTSWITCHBACK;
	 SetWasWearing(nil);
	 StartedFishing = nil;
      end
      
      if ( msg ) then
	 FishingBuddy.UIError(msg);
	 return false;
      end
      local check = OutfitDisplayFrame_SwitchOutfit(waswearing);
      if ( check ) then
	 SetWasWearing(nil);
	 FishingBuddy.OutfitManager.CheckSwitch(false);
      end
   elseif ( outfit ) then
      local msg;
      if ( not isfishing ) then
	 msg = OutfitDisplayFrame_SwitchWillFail(FishingOutfitFrame, outfit);
      else
	 msg = FishingBuddy.POLEALREADYEQUIPPED;
      end
      if ( msg ) then
	 FishingBuddy.UIError(msg);
	 return false;
      end
      local waswearing = OutfitDisplayFrame_SwitchOutfit(outfit);
      if ( waswearing ) then
	 SetWasWearing(waswearing);
	 FishingBuddy.OutfitManager.CheckSwitch(true);
      end
   else
      FishingBuddy.UIError(FishingBuddy.NOOUTFITDEFINED);
   end
   return true;
end

FishingBuddy.OutfitFrame.Button_OnClick = function()
   -- make sure we have the current state
   SetOutfit(OutfitDisplayFrame_GetOutfit(FishingOutfitFrame));
   ODF_Switch();
end

-- outfit debugging functions
FishingBuddy.Commands["outfit"] = {};
FishingBuddy.Commands["outfit"].func =
   function(what)
      if ( what and OutfitDisplayFrame_OnLoad ) then
	 if ( what == FishingBuddy.RESET ) then
	    SetWasWearing(nil);
	 elseif ( what == "dump" ) then
	    FishingBuddy.Debug("Outfit");
	    FishingBuddy.Dump(GetOutfit());
	    FishingBuddy.Debug("Was Wearing");
	    FishingBuddy.Dump(GetWasWearing());
	 end
      end
      return true;
   end;

if ( OutfitDisplayFrame_OnLoad ) then
   FishingBuddy.OutfitManager.RegisterManager("OutfitDisplayFrame",
                                              ODF_Initialize,
					      ODF_Choose,
                                              ODF_Switch);
end
