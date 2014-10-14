-- QuickLoot Plus by Joel Senecal-Phinn
-- Originally coded by Telo, I found the AddOn needed a GUI with options to enabled/disable certain features.

--------------------------------------------------------------------------------------------------
-- Function hooks.
--------------------------------------------------------------------------------------------------
local QLP_ADDON_NAME = "QuickLoot Plus";

--------------------------------------------------------------------------------------------------
-- Slash Command functions
--------------------------------------------------------------------------------------------------
function QuickLootPlus_Slash()
	SlashCmdList["QUICKLOOTPLUS"] = QLP_FrameShow;
	SLASH_QUICKLOOTPLUS1 = "/QLP";
end

function QLP_FrameShow()
	QLP_Frame:Show();
end

--------------------------------------------------------------------------------------------------
-- Variable functions.
--------------------------------------------------------------------------------------------------
function Toggle_QLP_AutoClose()
	if (QLP_AutoClose_CheckBox:GetChecked() == 1) then
		QLP_AutoClose = 1;
	else
		QLP_AutoClose = 0;
	end
end

function Toggle_QLP_FrameUnder()
	if (QLP_FrameUnder_CheckBox:GetChecked() == 1) then
		QLP_FrameUnder = 1;
		QLP_DynamicLoot_CheckBox:Enable()
	else
		QLP_FrameUnder = 0;
		QLP_DynamicLoot = 2;
		QLP_DynamicLoot_CheckBox:Disable()
	end
end

function Toggle_QLP_DynamicLoot()
	if (QLP_DynamicLoot_CheckBox:GetChecked() == 1) then
		QLP_DynamicLoot = 1;
	else
		QLP_DynamicLoot = 0;
	end
end

--------------------------------------------------------------------------------------------------
-- OnLoad function - Event Registration.
--------------------------------------------------------------------------------------------------
function QuickLootPlus_OnLoad()
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("LOOT_OPENED");
	this:RegisterEvent("LOOT_SLOT_CLEARED");
end

--------------------------------------------------------------------------------------------------
-- OnEvent function.
--------------------------------------------------------------------------------------------------
function QuickLootPlus_Event()
	if (event == "ADDON_LOADED") then
    		if (arg1 == QLP_ADDON_NAME) then
      			DEFAULT_CHAT_FRAME:AddMessage(QUICK_HELLO, 0.4, 0.6, 1.0);
    		end
	end
	if (event == "LOOT_OPENED") then
		LootFrameOpened();
	end
	if (event == "LOOT_SLOT_CLEARED") then
		if(QLP_DynamicLoot == 1) then
			LootFrameOpened();
		end
	end
	
	
	if (QLP_AutoClose == 1) then
		QLP_AutoClose_CheckBox:SetChecked(1);
	elseif (QLP_AutoClose == 0) then
		QLP_AutoClose_CheckBox:SetChecked(0);
	end
	
	
	if (QLP_FrameUnder == 1 and QLP_DynamicLoot == 0) then
		QLP_FrameUnder_CheckBox:SetChecked(1);
		QLP_DynamicLoot_CheckBox:SetChecked(0);
	elseif (QLP_FrameUnder == 0 and QLP_DynamicLoot == 0) then
		QLP_FrameUnder_CheckBox:SetChecked(0);
		QLP_DynamicLoot_CheckBox:SetChecked(0);
		QLP_DynamicLoot_CheckBox:Disable()
	elseif (QLP_FrameUnder == 0 and QLP_DynamicLoot == 2) then
		QLP_FrameUnder_CheckBox:SetChecked(0);
		QLP_DynamicLoot_CheckBox:SetChecked(1);
		QLP_DynamicLoot_CheckBox:Disable()
	elseif (QLP_FrameUnder == 1 and QLP_DynamicLoot == 1) then
		QLP_FrameUnder_CheckBox:SetChecked(1);
		QLP_DynamicLoot_CheckBox:SetChecked(1);
	elseif (QLP_FrameUnder == 1 and QLP_DynamicLoot == 2) then
		QLP_DynamicLoot = 1;
	end
end

--------------------------------------------------------------------------------------------------
-- Internal functions
--------------------------------------------------------------------------------------------------
function LootFrameOpened()
	if (QLP_AutoClose == 1 and GetNumLootItems() == 0) then
		HideUIPanel(LootFrame);
		return;
	end
	if (QLP_FrameUnder == 1) then
		local index;
		local x, y = GetCursorPosition();
		local scale = LootFrame:GetEffectiveScale();

		x = x / scale;
		y = y / scale;
		
		LootFrame:ClearAllPoints();

		for index = 1, LOOTFRAME_NUMBUTTONS, 1 do
			local button = getglobal("LootButton"..index);
			if(button:IsVisible()) then
				x = x - 42;
				y = y + 56 + (40 * index);
				LootFrame:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", x, y);
				return;
			end
		end
		LootFrame:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", x, y);
	end
end