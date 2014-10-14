-- Wrap OutfitDisplayFrame with our "improvements"
FB_OutfitFrame = {};
FB_ODFConstants = {};

local DEFAULTUPDATE_WAIT = 0.1;

local function StylePoints(outfit)
   local isp = FishingBuddy.OutfitManager.ItemStylePoints;
   local points = 0;
   if ( outfit )then
      for slot in pairs(outfit) do
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
      for slot in pairs(outfit) do
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
   if FBODF_PlayerInfo["WasWearing"] then
      return FBODF_PlayerInfo["WasWearing"];
   end
end

local function SetWasWearing(outfit)
   FBODF_PlayerInfo["WasWearing"] = outfit;
end

local function GetOutfit()
   return FBODF_PlayerInfo["Outfit"];
end

local saved_outfit;
local function SetOutfit(outfit)
   saved_outfit = outfit;
   FBODF_PlayerInfo["Outfit"] = outfit;
end

local function StyleString(long, points)
  if ( points == 1 ) then
    pstring = FBConstants.POINT;
  else
    pstring = FBConstants.POINTS;
  end
  if ( long ) then
     return FB_ODFConstants.STYLEPOINTS..points.." "..pstring;
  else
     return FB_ODFConstants.CONFIG_STYLISH_TEXT..points.." "..pstring;
  end
end

local function UpdateStyleInfo(outfit)
   local points = BonusPoints(outfit);
   if ( points >= 0 ) then
      points = "+"..points;
   else
      points = 0 - points;
      points = "-"..points;
   end
   FishingOutfitSkill:SetText(FB_ODFConstants.CONFIG_SKILL_TEXT..points);
   points = StylePoints(outfit);
   FishingOutfitStyle:SetText(StyleString(false, points));
end

local function ODF_Initialize()
   OutfitDisplayFrame_SetOutfit(FishingOutfitFrame, saved_outfit);
end

-- the user has chosen us, make sure everything is set up the way we need
local function ODF_Choose(useme)
   if ( useme ) then
      FishingBuddy.EnableSubFrame("FishingOutfitFrame");
   else
      FishingBuddy.DisableSubFrame("FishingOutfitFrame");
   end
end
FB_OutfitFrame.Choose = ODF_Choose;

-- only have one outfit at the moment
-- don't switch if
-- we can't find everything in the outfit
-- we have saved stuff but we're not wearing everything in the outfit
-- We don't have the outfit display frame!
local function ODF_Switch()
   if (CursorHasItem()) then
      FishingBuddy.UIError(FB_ODFConstants.CURSORBUSYMSG);
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
	 msg = FB_ODFConstants.CANTSWITCHBACK;
	 SetWasWearing(nil);
      end
      
      if ( msg ) then
	 FishingBuddy.UIError(msg);
	 return false;
      end
      local check = OutfitDisplayFrame_SwitchOutfit(waswearing);
      if ( check ) then
	 SetWasWearing(nil);
      end
      return true; -- look for pole
   elseif ( outfit ) then
      local msg;
      if ( not isfishing ) then
	 msg = OutfitDisplayFrame_SwitchWillFail(FishingOutfitFrame, outfit);
      else
	 msg = FB_ODFConstants.POLEALREADYEQUIPPED;
      end
      if ( msg ) then
	 FishingBuddy.UIError(msg);
	 return false;
      end
      local waswearing = OutfitDisplayFrame_SwitchOutfit(outfit);
      if ( waswearing ) then
	 SetWasWearing(waswearing);
      end
      return false; -- look for no pole
   else
      FishingBuddy.UIError(FB_ODFConstants.NOOUTFITDEFINED);
   end
end

local updateWait = DEFAULTUPDATE_WAIT;
FB_OutfitFrame.Update = function(elapsed)
   updateWait = updateWait - elapsed;
   if ( updateWait <= 0 ) then
      UpdateSwitchButton(saved_outfit);
      UpdateStyleInfo(saved_outfit);
      FishingOutfitUpdate:Hide();
   end
end

local function CustomTooltip(button)
  if ( button and button.item ) then
    local _,_,check, enchant = string.find(button.item, "^(%d+):(%d+)");
    local points = FishingBuddy.OutfitManager.ItemStylePoints(check, enchant);
    if ( points > 0 ) then
       GameTooltip:AddLine(StyleString(true, points));
    end
  end
end

local function OutfitChanged(button)
   local outfit = OutfitDisplayFrame_GetOutfit(FishingOutfitFrame);
   if ( outfit ) then
      SetOutfit(outfit);
   end
   updateWait = DEFAULTUPDATE_WAIT;
   FishingOutfitUpdate:Show();
   FishingOutfitFrame.valid = true;
end

FB_OutfitFrame.OnShow = function()
   if ( not this.valid ) then
      saved_outfit = GetOutfit();
   end
   OutfitDisplayFrame_SetOutfit(FishingOutfitFrame, saved_outfit);
   UpdateSwitchButton(saved_outfit);
   if ( not this.valid ) then
      OutfitChanged();
   end
end

FB_OutfitFrame.OnLoad = function()
   -- Handle the override
   OutfitDisplayFrame_OnLoad();
   FishingOutfitSkill.tooltip = FB_ODFConstants.CONFIG_SKILL_INFO;
   FishingOutfitStyle.tooltip = FB_ODFConstants.CONFIG_STYLISH_INFO;
   FishingOutfitSwitchButton:SetText(FB_ODFConstants.SWITCHOUTFIT);
   FishingOutfitSwitchButton.tooltip = FB_ODFConstants.SWITCHOUTFIT_INFO;
   FishingOutfitFrame.OutfitChanged = OutfitChanged;
   FishingOutfitFrame.CustomTooltip = CustomTooltip;
   FishingBuddy.OutfitManager.RegisterManager("OutfitDisplayFrame",
                                              ODF_Initialize,
                                              ODF_Choose,
                                              ODF_Switch);
   this:RegisterEvent("VARIABLES_LOADED");
end

FB_OutfitFrame.OnEvent = function()
   if ( event == "VARIABLES_LOADED" ) then
      FishingBuddy.ManageFrame(this,
			       FB_ODFConstants.OUTFITS_TAB,
			       FB_ODFConstants.OUTFITS_INFO,
			       "_OUT");
      this:UnregisterEvent("VARIABLES_LOADED");
   end
end

FB_OutfitFrame.OnHide = function()
   -- OutfitChanged();
end

FB_OutfitFrame.Button_OnClick = function()
   -- make sure we have the current state
   SetOutfit(OutfitDisplayFrame_GetOutfit(FishingOutfitFrame));
   ODF_Switch();
end

-- outfit debugging functions
FishingBuddy.Commands["outfit"] = {};
FishingBuddy.Commands["outfit"].func =
   function(what)
      if ( what and OutfitDisplayFrame_OnLoad ) then
	 if ( what == FBConstants.RESET ) then
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

-- set up
FishingBuddy.Setup.Translate("FB_OutfitDisplayFrame", FB_ODFTranslations, FB_ODFConstants);
if ( not FBODF_PlayerInfo ) then
   FBODF_PlayerInfo = {};
   FBODF_PlayerInfo["Outfit"] = {};
end
if ( FishingBuddy_Player and FishingBuddy_Player["Outfit"] ) then
   for k,v in pairs(FishingBuddy_Player["Outfit"]) do
      FBODF_PlayerInfo["Outfit"][k] = v;
   end
   FishingBuddy_Player["Outfit"] = nil;
end
-- free up the space
FB_ODFTranslations = nil;
