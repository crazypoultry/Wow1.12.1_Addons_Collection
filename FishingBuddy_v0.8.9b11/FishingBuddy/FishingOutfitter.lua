-- Interface with the Outfitter addon by mundocani

local function OutfitterSwitch(outfitName)
   -- this uses a static string of "Fishing" *not* the translation
   local vOut, vCat, vInd = Outfitter_FindOutfitByStatID("Fishing");
   if ( vOut ) then
      local wasPole = FishingBuddy.API.IsFishingPole();
      if ( wasPole ) then
	 Outfitter_RemoveOutfit(vOut);
      else
	 vOut.Disabled = nil;
	 Outfitter_WearOutfit(vOut, vCat);
      end
      Outfitter_Update(true);
      -- return true if we're expecting to have a pole equipped
      return (not wasPole);
   end
end

local function CleanOutDuplicates(vName)
   local count = 0;
   for vCategoryID, vOutfits in gOutfitter_Settings.Outfits do
      for vOutfitIndex, vOutfit in vOutfits do
	     if ( vOutfit.Name == vName ) then
			count = count + 1;
		 end
      end
   end
   if ( count > 0 ) then
      -- nuke all of the outfits named 'Fishing Buddy' since they're
      -- likely wrong, so that we can create a new 'good' one
      local vOut,_,_ = Outfitter_FindOutfitByName(vName);
      while ( vOut ) do
         Outfitter_DeleteOutfit(vOut);
         vOut,_,_ = Outfitter_FindOutfitByName(vName);
      end
   end
end

local function OutfitterInitialize()
   if ( gOutfitter_Settings ) then
      local vName = "Fishing Buddy";
      CleanOutDuplicates(vName);
      -- create the default fishing outfit, if it doesn't exist
      local vOut,_,_ = Outfitter_FindOutfitByStatID("Fishing");
      if ( not vOut ) then
         vOut = Outfitter_GenerateSmartOutfit(vName, "Fishing", OutfitterItemList_GetEquippableItems(true));
         if ( vOut ) then
            local vCategoryID = Outfitter_AddOutfit(vOut);
            -- we're done
         end
      end
   end
end

-- calculate scores based on Outfitter
local function StylePoints(outfit)
   local isp = FishingBuddy.OutfitManager.ItemStylePoints;
   local points = 0;
   if ( outfit )then
      for slot in outfit.Items do
	 points = points + isp(outfit.Items[slot].Code,
			       outfit.Items[slot].EnchantCode);
      end
   end
   return points;
end

local function BonusPoints(outfit, vStatID)
   local points = 0;
   if ( outfit )then
      for slot in outfit.Items do
	 if ( outfit.Items[slot][vStatID] ) then
	    points = points + outfit.Items[slot][vStatID];
	 end
	 -- Enternium Fishing Line
	 if ( outfit.Items[slot].EnchantCode == 2603 ) then
	    points = points + 5;
	 end
      end
   end
   return points;
end

-- Outfitter patches ( not needed in 1.2)
if ( not Outfitter_FindOutfitByStatID ) then
   Outfitter_FindOutfitByStatID = function(pStatID)
      if not pStatID or pStatID == "" then
         return nil;
      end

      for vCategoryID, vOutfits in gOutfitter_Settings.Outfits do
         for vOutfitIndex, vOutfit in vOutfits do
            if vOutfit.StatID and vOutfit.StatID == pStatID then
               return vOutfit, vCategoryID, vOutfitIndex;
            end
         end
      end

      -- return nil, nil, nil;
   end
end

local Saved_OutfitterItem_OnEnter = OutfitterItem_OnEnter;
local function Patch_OutfitterItem_OnEnter(pItem)
   Saved_OutfitterItem_OnEnter(pItem);
   if ( not pItem.isCategoryItem ) then
      local vOutfit = Outfitter_GetOutfitFromListItem(pItem);
      if ( vOutfit and vOutfit.StatID == "Fishing" ) then
	 local vDescription;
	 local bp = BonusPoints(vOutfit, "Fishing");
	 if ( bp >= 0 ) then
	    bp = "+"..bp;
	 else
	    bp = 0 - bp;
	    bp = "-"..bp;
	 end
	 bp = Outfitter_cFishingStatName.." "..bp;
	 local sp = StylePoints(vOutfit);
	 local pstring;
	 if ( points == 1 ) then
	    pstring = FBConstants.POINT;
	 else
	    pstring = FBConstants.POINTS;
	 end
	 vDescription = string.format(FBConstants.CONFIG_OUTFITTER_TEXT,
				      bp, sp)..pstring;
	 GameTooltip_AddNewbieTip(vOutfit.Name, 1.0, 1.0, 1.0, vDescription, 1);
      end
   end
end
-- point to our new function so we get our own tooltip
OutfitterItem_OnEnter = Patch_OutfitterItem_OnEnter;

if ( Outfitter_OnLoad ) then
   FishingBuddy.OutfitManager.RegisterManager("Outfitter",
					      OutfitterInitialize,
					      function(useme) end,
					      OutfitterSwitch);
end

