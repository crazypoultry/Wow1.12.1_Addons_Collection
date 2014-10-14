local FBFRAMES = {
   [1] = {
      ["frame"] = "FishingLocationsFrame",
      ["name"] = FBConstants.LOCATIONS_TAB,
      ["tooltip"] = FBConstants.LOCATIONS_INFO,
      ["toggle"] = "_LOC",
   },
   [2] = {
      ["frame"] = "FishingOptionsFrame",
      ["name"] = FBConstants.OPTIONS_TAB,
      ["tooltip"] = FBConstants.OPTIONS_INFO,
      ["toggle"] = "_OPT",
   }
};

local function GetFrameInfo(f)
   local n;
   if ( type(f) == "string" ) then
      n = f;
      f = getglobal(f);
   else
      n = f:GetName();
   end
   return f, n;
end

local TabFrames = {};
local next_frameid = 1;
local function CreateTabFrame(target, tabname)
   local id = next_frameid;
   local framename = string.format("FishingBuddyFrameTab%d", id);
   local frame = CreateFrame("Button", framename,
			     UIParent, "FishingBuddyTabButtonTemplate");
   TabFrames[id] = frame;

   frame:SetID(id);
   frame:SetText(tabname);
   frame:SetParent(FishingBuddyFrame);
   frame:SetFrameLevel(target:GetFrameLevel()+1);
   frame.enabled = true;

   next_frameid = next_frameid + 1;

   return frame;
end

local function ResetTabFrames()
   local lastFrame = nil;

   -- Tab Handling code
   PanelTemplates_SetNumTabs(FishingBuddyFrame, next_frameid-1);

   if ( not currentTab ) then
      currentTab = TabFrames[1].frame;
   end
   for id=1,next_frameid-1 do
      local tab = TabFrames[id];
      if ( tab.enabled ) then
         tab:Show();
         if ( lastFrame ) then
	     tab:SetPoint("LEFT", lastFrame, "RIGHT", -18, 0);
         else
	    tab:SetPoint("CENTER", FishingBuddyFrame, "BOTTOMLEFT", 55, 60);
	 end
	 lastFrame = tab;
      else
         if ( tab == currentTab ) then
            currentTab = lastFrame;
         end
         tab:Hide();
      end
      if ( tab.managedFrame ) then
	 tab.managedFrame:Hide();
      end
   end
   -- FishingOptionsFrame:SetPoint("LEFT", lastFrame, "RIGHT", -18, 0);
   PanelTemplates_SetTab(FishingBuddyFrame, currentTab:GetID());
   currentTab:Show();
   if ( currentTab.managedFrame ) then
      currentTab.managedFrame:Show();
   end
end

local ManagedFrames = {};
local function DisableSubFrame(target)
   local frame, frameName = GetFrameInfo(target);
   local tab = ManagedFrames[frameName];
   if ( tab ) then
      tab.enabled = false;
      ResetTabFrames();
   end
end
FishingBuddy.DisableSubFrame = DisableSubFrame;

local function EnableSubFrame(target)
   local frame, frameName = GetFrameInfo(target);
   local info = ManagedFrames[frameName];
   if ( tab ) then
      tab.enabled = true;
      ResetTabFrames();
   end
end
FishingBuddy.EnableSubFrame = EnableSubFrame;

local function ShowSubFrame(target)
   local frame, frameName = GetFrameInfo(target);
   local ctab;
   for id=1,next_frameid-1 do
      local tab = TabFrames[id];
      if ( tab.enabled and tab.managedFrame ) then
         if ( tab.managedFrame == frame ) then
            ctab = tab;
         end
      end
   end
   if ( not ctab ) then
      ctab = TabFrames[1];
   end
   currentTab = ctab;
   ResetTabFrames();
end

local function MakeFrameTab(target, tabname, tooltip, toggle)
   local frame,_ = GetFrameInfo(target);
   local tab = CreateTabFrame(frame, tabname);
   if ( tooltip ) then
      tab.tooltip = tooltip;
   end
   if ( toggle ) then
      tab.toggle = "TOGGLEFISHINGBUDDY"..toggle;
   end
   tab.managedFrame = frame;
   return tab;
end

local function FindTab(frame)
   for id=1,next_frameid-1 do
      tab = TabFrames[id];
      if ( tab.managedFrame == frame ) then
         return tab;
      end
   end
-- return nil;
end

local function ManageFrame(target, tabname, tooltip, toggle)
   local frame, frameName = GetFrameInfo(target);
   if ( not ManagedFrames[frameName] ) then
      ManagedFrames[frameName] = MakeFrameTab(frame, tabname, tooltip, toggle);
      EnableSubFrame(frameName);
   end
end
FishingBuddy.ManageFrame = ManageFrame;

function ToggleFishingBuddyFrame(target)
   local frame, frameName = GetFrameInfo(target);
   local tab = FindTab(frame);
   if ( tab ) then
      currentTab = tab;
      if ( FishingBuddyFrame:IsVisible() ) then
	 if ( frame:IsVisible() ) then
	    HideUIPanel(FishingBuddyFrame);	
	 end
      else
	 ShowUIPanel(FishingBuddyFrame);
      end
      ResetTabFrames();
   end   
end

function FishingBuddyFrameTab_OnClick()
   currentTab = this;
   ResetTabFrames();
   PlaySound("igCharacterInfoTab");
end

function FishingBuddyFrame_OnLoad()
   -- Act like Blizzard windows
   UIPanelWindows["FishingBuddyFrame"] = { area = "left", pushable = 999 }; 
   -- Close with escape key
   tinsert(UISpecialFrames, "FishingBuddyFrame"); 

   this:RegisterEvent("VARIABLES_LOADED");
end

function FishingBuddyFrame_OnEvent(event)
   if ( event == "VARIABLES_LOADED" ) then
      -- set up mappings
      for idx,info in pairs(FBFRAMES) do
         MakeFrameTab(info.frame, info.name, info.tooltip, info.toggle);
      end
      ShowSubFrame("FishingLocationsFrame");
   end
end

function FishingBuddyFrame_OnShow()
   FishingBuddyFramePortrait:SetTexture("Interface\\LootFrame\\FishingLoot-Icon");
   FishingBuddyNameText:SetText(FBConstants.WINDOW_TITLE);
   UpdateMicroButtons();
   ResetTabFrames();
end

function FishingBuddyFrame_OnHide()
   UpdateMicroButtons();
end
