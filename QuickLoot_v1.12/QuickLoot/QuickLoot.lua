--[[

	QuickLoot: easier, faster looting
		copyright 2004 by Telo

	- Automatically positions the most relevant part of the loot window under your cursor
	
]]

--------------------------------------------------------------------------------------------------
-- Configuration variables
--------------------------------------------------------------------------------------------------

QuickLoot_AutoHide = 1;	-- set to 1 if you want the window to auto-hide when there's no loot or
						-- set to nil if you don't want this behavior

--------------------------------------------------------------------------------------------------
-- Local variables
--------------------------------------------------------------------------------------------------

-- Function hooks
local originalLootFrame_OnEvent;
local originalLootFrame_Update;

--------------------------------------------------------------------------------------------------
-- Internal functions
--------------------------------------------------------------------------------------------------
local function QuickLoot_ItemUnderCursor()
	local index;
	local x, y = GetCursorPosition();
	local scale = LootFrame:GetEffectiveScale();

	x = x / scale;
	y = y / scale;

	LootFrame:ClearAllPoints();

	for index = 1, LOOTFRAME_NUMBUTTONS, 1 do
		local button = getglobal("LootButton"..index);
		if( button:IsVisible() ) then
			x = x - 42;
			y = y + 56 + (40 * index);
			LootFrame:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", x, y);
			return;
		end
	end

	if( LootFrameDownButton:IsVisible() ) then
		-- If down arrow, position on it
		x = x - 158;
		y = y + 223;
	else
		if( QuickLoot_AutoHide and GetNumLootItems() == 0 ) then
			HideUIPanel(LootFrame);
			return
		end
		-- Otherwise, position on close box
		x = x - 173;
		y = y + 25;
	end
	
	LootFrame:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", x, y);
end

local function QuickLoot_LootFrame_OnEvent(event)
	originalLootFrame_OnEvent(event);
	if ( event == "LOOT_SLOT_CLEARED" ) then
		QuickLoot_ItemUnderCursor();
	end
end

local function QuickLoot_LootFrame_Update()
	originalLootFrame_Update();
	QuickLoot_ItemUnderCursor();
end

--------------------------------------------------------------------------------------------------
-- OnFoo functions
--------------------------------------------------------------------------------------------------
function QuickLoot_OnLoad()
	-- Hook the LootFrame_OnEvent function
	originalLootFrame_OnEvent = LootFrame_OnEvent;
	LootFrame_OnEvent = QuickLoot_LootFrame_OnEvent;
	
	-- Hook the LootFrame_Update function
	originalLootFrame_Update = LootFrame_Update;
	LootFrame_Update = QuickLoot_LootFrame_Update;
	
	-- Don't treat the LootFrame as a UI panel
	UIPanelWindows["LootFrame"] = nil;
	
	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage("Telo's QuickLoot AddOn loaded");
	end
	UIErrorsFrame:AddMessage("Telo's QuickLoot AddOn loaded", 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
end
