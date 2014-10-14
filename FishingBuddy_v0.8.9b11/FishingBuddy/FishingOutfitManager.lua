-- Manage outfits, whether they're from OutfitDisplayFrame or something else
FishingBuddy.OutfitManager = {};

-- Inferred from Draznar's Fishing FAQ
local Accessories = {
   [6256] = { ["n"] = "Fishing Pole", ["score"] = 0, },
   [12225] = { ["n"] = "Blump Family Fishing Pole", ["score"] = 3, },
   [6365] = { ["n"] = "Stong Fishing Pole", ["score"] = 5, },
   [6366] = { ["n"] = "Darkwood Fishing Pole", ["score"] = 40, },
   [6367] = { ["n"] = "Big Iron Fishing Pole", ["score"] = 20, },
   [19022] = { ["n"] = "Nat Pagle's Extreme Angler FC-5000", ["score"] = 25, },
   [19970] = { ["n"] = "Arcanite Fishing Pole", ["score"] = 35, },
   [19944] = { ["n"] = "Nat Pagle's Fish Terminator", ["score"] = 45, },
   [19971] = { ["n"] = "High Test Eternium Fishing Line", ["score"] = 5, },
   [11152] = { ["n"] = "Formula: Enchant Gloves - Fishing", ["score"] = 2, },
   [19979] = { ["n"] = "Hook of the Master Angler", ["score"] = 5, },
   [19947] = { ["n"] = "Nat Pagle's Broken Reel", ["score"] = 4, },
   [19972] = { ["n"] = "Lucky Fishing Hat", ["score"] = 5, },
   [7996] = { ["n"] = "Lucky Fishing Hat", ["score"] = 10, },
   [8749] = { ["n"] = "Crochet Hat", ["score"] = 3, },
   [19039] = { ["n"] = "Zorbin's Water Resistant Hat", ["score"] = 3, },
   [3889] = { ["n"] = "Russet Hat", ["score"] = 3, },
   [14584] = { ["n"] = "Dokebi Hat", ["score"] = 2, },
   [4048] = { ["n"] = "Emblazoned Hat", ["score"] = 1, },
   [10250] = { ["n"] = "Masters Hat of the Whale", ["score"] = 1, },
   [6263] = { ["n"] = "Blue Overalls", ["score"] = 4, },
   [9508] = { ["n"] = "Mechbuilder's Overalls", ["score"] = 3, },
   [3342] = { ["n"] = "Captain Sander's Shirt", ["score"] = 4, },
   [5107] = { ["n"] = "Deckhand's Shirt", ["score"] = 2, },
   [6795] = { ["n"] = "White Swashbuckler's Shirt", ["score"] = 1, },
   [2576] = { ["n"] = "White Linen Shirt", ["score"] = 1, },
   [15405] = { ["n"] = "Shucking Gloves", ["score"] = 5, },
   [6202] = { ["n"] = "Fingerless Gloves", ["score"] = 3, },
   [19969] = { ["n"] = "Nat Pagle's Extreme Anglin' Boots", ["score"] = 5, },
   [792] = { ["n"] = "Knitted Sandals", ["score"] = 4, },
   [1560] = { ["n"] = "Bluegill Sandals", ["score"] = 4, },
   [15406] = { ["n"] = "Crustacean Boots", ["score"] = 3, },
   [13402] = { ["n"] = "Timmy's Galoshes", ["score"] = 2, },
   [10658] = { ["n"] = "Quagmire Galoshes", ["score"] = 2, },
   [1678] = { ["n"] = "Black Ogre Kickers", ["score"] = 1, },
   [5310] = { ["n"] = "Sea Dog Britches", ["score"] = 4, },
   [3287] = { ["n"] = "Tribal Pants", ["score"] = 2, },
   [6179] = { ["n"] = "Privateer's Cape", ["score"] = 1, },
};

FishingBuddy.Commands[FBConstants.SWITCH] = {};
FishingBuddy.Commands[FBConstants.SWITCH].func = function()
					FishingBuddy.OutfitManager.Switch();
					return true;
				     end;

local OutfitManagers = {};
local OutfitManagerCount = 0;
FishingBuddy.OutfitManager.RegisterManager = function(name, init, choose, switch)
   if ( not OutfitManagers[name] ) then
      OutfitManagers[name] = {};
      OutfitManagerCount = OutfitManagerCount + 1;
   end
   OutfitManagers[name].Initialize = init;
   OutfitManagers[name].Choose = choose;
   OutfitManagers[name].Switch = switch;
end

FishingBuddy.OutfitManager.ItemStylePoints = function(itemno, enchant)
   local points = 0;
   if ( itemno ) then
      itemno = tonumber(itemno);
      enchant = tonumber(enchant);
      if (Accessories[itemno]) then
	 points = points + Accessories[itemno].score;
      end
      if ( enchant == 846 ) then
         -- bonus for being enchanted with Fishing +2
         points = points + 2;
      end
   end
   return points;
end

local PoleCheck = nil;

-- update the watcher when we're done switching outfits
FishingBuddy.OutfitManager.WaitForUpdate =
   function(arg1)
      local hasPole = FishingBuddy.API.IsFishingPole();
      if ( hasPole == PoleCheck ) then
	 FishingOutfitUpdateFrame:Hide();
	 FishingBuddy.API.FishingMode();
      end
   end

local function CheckSwitch(topole)
   PoleCheck = topole;
   FishingOutfitUpdateFrame:Show();
end
FishingBuddy.OutfitManager.CheckSwitch = CheckSwitch;

local function HasManager()
   return (OutfitManagerCount > 0);
end
FishingBuddy.OutfitManager.HasManager = HasManager;

FishingBuddy.OutfitManager.Switch = function(outfitname)
   if ( HasManager() ) then
      local outfitter = FishingBuddy.GetSetting("OutfitManager");
      if ( outfitter and OutfitManagers[outfitter] ) then
         local willBePole = OutfitManagers[outfitter].Switch(outfitname);
	 if ( willBePole ~= nil ) then
	    -- if we're now sporting a fishing pole, let's go fishing
	    CheckSwitch(willBePole);
	 end
      end
   else
      FishingBuddy.UIError(FBConstants.COMPATIBLE_SWITCHER);
   end
end

local current_manager;

local function OutfitManagerMenuSetup()
   for manager,_ in pairs(OutfitManagers) do
      local mgr = manager;
      local info = {};
      info.text = manager;
      info.func = function() FishingBuddy.OutfitManager.ChooseManager(mgr); end;
      info.checked = ( current_manager == manager )
      UIDropDownMenu_AddButton(info);
   end
end

local function SetOutfitManagerDisplay()
   if ( OutfitManagerCount == 0 ) then
      FishingBuddyOption_OutfitMenu:Hide();
      FishingBuddyOption_OutfitText:SetText(FBConstants.OUTFITS..": |c"..FBConstants.Colors.RED..FBConstants.NONEAVAILABLE_MSG.."|r");
   elseif ( OutfitManagerCount == 1 ) then
      FishingBuddyOption_OutfitMenu:Hide();
      FishingBuddyOption_OutfitText:SetText(FBConstants.OUTFITS..": |c"..FBConstants.Colors.GREEN..current_manager.."|r");
   else
      FishingBuddyOption_OutfitText:Hide();
      UIDropDownMenu_Initialize(FishingBuddyOption_OutfitMenu,
				OutfitManagerMenuSetup);
      local show = 1;
      for name,_ in pairs(OutfitManagers) do
	 if ( name == current_manager ) then
	    break;
	 end
	 show = show + 1;
      end
      local label = getglobal("FishingBuddyOption_OutfitMenuLabel");
      label:SetText(FBConstants.OUTFITS..": ");
      local menu = FishingBuddyOption_OutfitMenu;
      UIDropDownMenu_SetWidth(210, menu);
      UIDropDownMenu_SetSelectedValue(menu, show);
      UIDropDownMenu_SetText(current_manager, menu);
   end
end

local function ChooseManager(manager)
   if ( manager and OutfitManagers[manager] ) then
      current_manager = manager;
      if ( not OutfitManagers[manager].initialized ) then

	 FishingBuddy.Debug("ChooseManager "..manager);

         OutfitManagers[manager].Initialize();
         OutfitManagers[manager].initialized = 1;
      end
      for om,info in pairs(OutfitManagers) do
	 info.Choose(om == manager);
      end
      SetOutfitManagerDisplay();
      FishingBuddy.SetSetting("OutfitManager", current_manager);
      return true;
   end
end
FishingBuddy.OutfitManager.ChooseManager = ChooseManager;

FishingBuddy.OutfitManager.Initialize = function()
   -- no outfit managers, no outfit switching
   if ( not HasManager() ) then
      FishingBuddy.SetSetting("InfoBarClickToSwitch", 0);
      FishingBuddy.SetSetting("TitanClickToSwitch", 0);
      FishingBuddy.SetSetting("MinimapClickToSwitch", 0);
   else
      if ( OutfitManagerCount == 1 ) then
	 -- we pretty much have to use this one
	 current_manager = next(OutfitManagers);
      else
	 current_manager = FishingBuddy.GetSetting("OutfitManager");
	 if ( not current_manager or not OutfitManagers[current_manager] ) then
	    -- no valid ones, use the first one
	    current_manager = next(OutfitManagers);
	 end
      end
      ChooseManager(current_manager);
      -- in case we changed things (do we want/need to do this?)
      -- FishingBuddy.SetSetting("OutfitManager", current_manager);
   end
   SetOutfitManagerDisplay();
end

-- debugging
FishingBuddy.OutfitManagers = OutfitManagers;
