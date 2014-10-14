--
--	AutoTrinketBar: Looks up your equipped trinkets and makes a button for them.
--
--	Author: Dassem on Daggerspine (EU) / Ganrod on Skullcrusher (old)
--
--	26102005 - Version 1.22 - Fixed some bugs again.
--
--      29092005 - Version 1.21 - Fixed a problem introduced in patch 1.7 (atleast I hope :))
--
--	10012005 - Version 1.2 - Added an option to hide AutoTrinketBar from view
--
--	08012005 - Version 1.11 - Keybinding problem fixed
--
--	08012005 - Version 1.1 - Bar can now be dragged by holding a button
--			       - Trinket can be dragged on a button and it will be equipped
--			       - Data saved for each character
--			       - Option to anchor tooltip to the left or right of the button
--			       - Bar starts unlocked and default now moves and unlocks the bar
--
--	04012005 - Version 1.0 - initial version

--------------------------------------------------------------------------------------------------
-- variables
--------------------------------------------------------------------------------------------------

local TrinketSlots = {
	{ name = "Trinket0Slot" },
	{ name = "Trinket1Slot" },
};

AutoTrinketBar_Version = "1.1";	-- this version is only changed when the saved data is not backwards compatible
AutoTrinketBar_LastUpdate = 0;
AutoTrinketBar_Config_Loaded = nil;
AutoTrinketBar_DefaultX = 300;
AutoTrinketBar_DefaultY = 300;

--------------------------------------------------------------------------------------------------
-- Binding stuff
--------------------------------------------------------------------------------------------------

BINDING_HEADER_AUTOTRINKETBAR_SEP = "Auto Trinket Bar";
BINDING_NAME_AUTOTRINKETBAR_BUTTON_TRINKET1 = "Trinket Right";
BINDING_NAME_AUTOTRINKETBAR_BUTTON_TRINKET2 = "Trinket Left";

function AutoTrinketBar_Down(info)
	local button;
	if (info == "Trinket1") then
		button = getglobal("AutoTrinketBar_Button1");
	elseif (info == "Trinket2") then
		button = getglobal("AutoTrinketBar_Button2");
	end

	if (button and button:GetButtonState() == "NORMAL") then
		button:SetButtonState("PUSHED");
	end
end

function AutoTrinketBar_Up(info)
	local button;
	if (info == "Trinket1") then
		button = getglobal("AutoTrinketBar_Button1");
	elseif (info == "Trinket2") then
		button = getglobal("AutoTrinketBar_Button2");
	end
	if (button and button:GetButtonState() == "PUSHED") then
		button:SetButtonState("NORMAL");
	end

	AutoTrinketBar_UseTrinket(button);
end

function AutoTrinketBarButton_UpdateHotkeys()
	local name = this:GetName();
	local hotkey = getglobal(name.."HotKey");
	local action = "AUTOTRINKETBAR_BUTTON_TRINKET1";
	if (name == "AutoTrinketBar_Button2") then
		action = "AUTOTRINKETBAR_BUTTON_TRINKET2";
	end

	local text = GetBindingKey(action);
	--local text = KeyBindingFrame_GetLocalizedName(GetBindingKey(action), "KEY_");
	--local text = KeyBindingFrame_GetLocalizedName(KeyBindingFrame_GetLocalizedName(GetBindingKey(action), "KEY_"));
	
	if (text) then
		text = string.gsub(text, "CTRL", "C");
		text = string.gsub(text, "ALT", "A");
		text = string.gsub(text, "SHIFT", "S");
		text = string.gsub(text, "Num Pad", "NP");
		text = string.gsub(text, "Backspace", "Bksp");
		text = string.gsub(text, "Spacebar", "Space");
		text = string.gsub(text, "Page", "Pg");
		text = string.gsub(text, "Down", "Dn");
		text = string.gsub(text, "Arrow", "");
		text = string.gsub(text, "Insert", "Ins");
		text = string.gsub(text, "Delete", "Del");
	
		hotkey:SetText(text);
	else
		hotkey:SetText("");
	end
end

--------------------------------------------------------------------------------------------------
-- Internal functions
--------------------------------------------------------------------------------------------------

local function AutoTrinketBar_SetTooltip(button)
	if ( button.id ) then
		if (AutoTrinketBar_Config[AutoTrinketBar_Player].tooltip == "LEFT") then
			GameTooltip:SetOwner(button, "ANCHOR_LEFT");
		elseif (AutoTrinketBar_Config[AutoTrinketBar_Player].tooltip == "RIGHT") then
			GameTooltip:SetOwner(button, "ANCHOR_RIGHT");
		end
		GameTooltip:SetInventoryItem("player", button.id);
	end
end

local function AutoTrinketBar_SetItem(button, id)
	button.texture = GetInventoryItemTexture("player", id);
	button.id = id;
	if (button.texture) then
		button:Show();
		getglobal(button:GetName().."Icon"):SetTexture(button.texture);
	else
		button:Hide();
	end
end

local function AutoTrinketBar_Button_UpdateCooldown()
	local cooldown = getglobal(this:GetName().."Cooldown");

	local start, duration, enable;

	if (this:GetName() == "AutoTrinketBar_Button1") then
		start, duration, enable = GetInventoryItemCooldown("player", getglobal("CharacterTrinket0Slot"):GetID());
	elseif (this:GetName() == "AutoTrinketBar_Button2") then
		start, duration, enable = GetInventoryItemCooldown("player", getglobal("CharacterTrinket1Slot"):GetID());
	end

	CooldownFrame_SetTimer(cooldown, start, duration, enable);
end

local function AutoTrinketBar_SetButtons()
	local index = {};
	local n;
	local button
	
	n = 1
	for index = 1, getn(TrinketSlots), 1 do
		if( TrinketSlots[index].id ) then
			button = getglobal("AutoTrinketBar_Button"..n);
			AutoTrinketBar_SetItem(button, TrinketSlots[index].id);
		end
		n = n + 1;
	end
end

--------------------------------------------------------------------------------------------------
-- OnFoo functions
--------------------------------------------------------------------------------------------------
-- Button ----------------------------------------------------------------------------------------

function AutoTrinketBar_Button_OnLoad()
	this:RegisterEvent("ADDON_LOADED")
	this:RegisterEvent("UNIT_INVENTORY_CHANGED");
--	this:RegisterEvent("BAG_UPDATE");
	this:RegisterEvent("UPDATE_BINDINGS");
--	this:RegisterEvent("UPDATE_INVENTORY_ALERTS");
	this:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	this:RegisterForDrag("LeftButton");

	local index;
	
	for index = 1, getn(TrinketSlots), 1 do
		TrinketSlots[index].id = GetInventorySlotInfo(TrinketSlots[index].name);
	end

	AutoTrinketBarButton_UpdateHotkeys();
	AutoTrinketBar_Button_UpdateCooldown();
end

function AutoTrinketBar_Button_OnShow()
	AutoTrinketBar_Button_Update(1);
end

function AutoTrinketBar_Button_Update(elapsed)
	AutoTrinketBar_LastUpdate = AutoTrinketBar_LastUpdate + elapsed;
	if (AutoTrinketBar_LastUpdate < 0.25) then
		return;
	end
	AutoTrinketBar_LastUpdate = 0;
	AutoTrinketBar_Button_UpdateCooldown();
end

function AutoTrinketBar_Button_OnEvent(event)
	if ( event == "ADDON_LOADED" and arg1 == "AutoTrinketBar" ) then
		AutoTrinketBar_SetButtons();
		AutoTrinketBar_SetPosition("NORMAL");
		return;
	elseif( event == "UNIT_INVENTORY_CHANGED" ) then
		if( arg1 == "player" ) then
			AutoTrinketBar_SetButtons();
		end
		return;
	elseif (event == "UPDATE_BINDINGS") then
		AutoTrinketBarButton_UpdateHotkeys();
		return;
--	elseif (event == "BAG_UPDATE") then
--		return;
--	elseif (event == "UPDATE_INVENTORY_ALERTS") then
	end
end

function AutoTrinketBar_Button_OnClick(button)
	if (AutoTrinketBar_Config[AutoTrinketBar_Player].droppable == "NO") then
		AutoTrinketBar_UseTrinket(this);
	elseif (AutoTrinketBar_Config[AutoTrinketBar_Player].droppable == "YES") then
		if (button == "LeftButton") then
			if (this:GetName() == "AutoTrinketBar_Button1") then
				PickupInventoryItem(getglobal("CharacterTrinket0Slot"):GetID());
			elseif (this:GetName() == "AutoTrinketBar_Button2") then
				PickupInventoryItem(getglobal("CharacterTrinket1Slot"):GetID());
			end			
		elseif (button == "RightButton") then
			AutoTrinketBar_UseTrinket(this);
		end
	end

	if (button == "LeftButtonUp") then
		ChatFrame1:AddMessage("LeftButtonUp");
	elseif (button == "RightButtonUp") then
		ChatFrame1:AddMessage("RightButtonUp");
	end
end

function AutoTrinketBar_Button_OnEnter()
	this.tooltip = 1;
	AutoTrinketBar_SetTooltip(this);
end

function AutoTrinketBar_Button_OnLeave()
	if( this.tooltip ) then
		this.tooltip = nil;
		GameTooltip:Hide();
	end
end

--function AutoTrinketBar_Button_OnRecieveDrag()
--	if (this:GetName() == "AutoTrinketBar_Button1") then
--		PickupInventoryItem(getglobal("CharacterTrinket0Slot"):GetID());
--	elseif (this:GetName() == "AutoTrinketBar_Button2") then
--		PickupInventoryItem(getglobal("CharacterTrinket1Slot"):GetID());
--	end
--end

-- TrinketBar-------------------------------------------------------------------------------------

function AutoTrinketBar_OnLoad()
	AutoTrinketBar:RegisterForDrag("LeftButton");

	this:RegisterEvent("VARIABLES_LOADED");
--	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("UNIT_NAME_UPDATE");

	SLASH_AUTOTRINKETBAR1 = "/autotrinketbar";
	SLASH_AUTOTRINKETBAR2 = "/trinketbar";
	SLASH_AUTOTRINKETBAR3 = "/atb";
	SlashCmdList["AUTOTRINKETBAR"] = function (msg)
		AutoTrinketBar_SlashCmd(msg);
	end

	local playerName = UnitName("player");
	if (playerName ~= UKNOWNBEING and playerName ~= UNKNOWNOBJECT) then
		AutoTrinketBar_Player = playerName;
	end
end

function AutoTrinketBar_OnShow()
--	ChatFrame1:AddMessage("OnShow");
	if (AutoTrinketBar_Config_Loaded and AutoTrinketBar_Player) then
		if (AutoTrinketBar_Config[AutoTrinketBar_Player].visible == "YES") then
			AutoTrinketBar_SetPosition("NORMAL");
		elseif (AutoTrinketBar_Config[AutoTrinketBar_Player].visible == "NO") then
			AutoTrinketBar_SetPosition("HIDDEN");
		end
		if (AutoTrinketBar_Config[AutoTrinketBar_Player].lock == "UNLOCKED") then
			getglobal("AutoTrinketBar_Background"):Show();
		elseif (AutoTrinketBar_Config[AutoTrinketBar_Player].lock == "LOCKED") then
			getglobal("AutoTrinketBar_Background"):Hide();
		end
	end
end

function AutoTrinketBar_OnEvent()
	if (event == "VARIABLES_LOADED") then
--		ChatFrame1:AddMessage("VARIABLES_LOADED");
		AutoTrinketBar_Config_Loaded = 1;
		if (AutoTrinketBar_Player) then
			AutoTrinketBar_ConfigInit();
		else
			DEFAULT_CHAT_FRAME:AddMessage("AutoTrinketBar - Could not determine player.");
		end
--		AutoTrinketBar_Player = UnitName("player");
		-- TESTI
--	elseif (event == "UNIT_NAME_UPDATE" and arg1 == "player") then
--		local playerName = UnitName("player");
--		if (playerName ~= UKNOWNBEING and playerName ~= "Unknown Entity") then
--			ChatFrame1:AddMessage("UNIT_NAME_UPDATE - not UE");
--			AutoTrinketBar_Player = playerName;
--		end
--		if (AutoTrinketBar_Player and AutoTrinketBar_Config_Loaded) then
--			AutoTrinketBar_ConfigInit();
--			AutoTrinketBar_OnShow();
--		end
--	elseif (event == "PLAYER_ENTERING_WORLD") then
--		AutoTrinketBar_OnShow();
	end
end

function AutoTrinketBar_OnUpdate(arg1)
end

function AutoTrinketBar_OnDragStart(frame)
	if (AutoTrinketBar_Config[AutoTrinketBar_Player].lock == "UNLOCKED") then
		getglobal("AutoTrinketBar_Background"):Hide();
		frame.BeingDragged = 1;
		frame:StartMoving();
		getglobal("AutoTrinketBar_Background").BeingDragged = 1;
		getglobal("AutoTrinketBar_Background"):StartMoving();
	end
end

function AutoTrinketBar_OnDragStop(frame)
	if (AutoTrinketBar_Config[AutoTrinketBar_Player].lock == "UNLOCKED") then
		if( frame.BeingDragged ) then
			frame:StopMovingOrSizing();
			frame.BeingDragged = nil;
		end

		if( getglobal("AutoTrinketBar_Background").BeingDragged ) then
			getglobal("AutoTrinketBar_Background"):StopMovingOrSizing();
			getglobal("AutoTrinketBar_Background").BeingDragged = nil;
		end

		AutoTrinketBar_SavePosition();
		getglobal("AutoTrinketBar_Background"):Show();
	end
end

function AutoTrinketBar_SavePosition()
	if (AutoTrinketBar_Config_Loaded and AutoTrinketBar_Player) then
		AutoTrinketBar_Config[AutoTrinketBar_Player].x = getglobal("AutoTrinketBar"):GetRight();
		AutoTrinketBar_Config[AutoTrinketBar_Player].y = getglobal("AutoTrinketBar"):GetBottom();
	end
end

function AutoTrinketBar_SetPosition(forced)
	if (AutoTrinketBar_Config_Loaded) then
		local atb = getglobal("AutoTrinketBar");
		if (forced == "FORCED") then
			atb:ClearAllPoints();
			atb:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMLEFT", AutoTrinketBar_DefaultX, AutoTrinketBar_DefaultY);
		elseif (forced == "NORMAL") then
			atb:ClearAllPoints();
			atb:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMLEFT",
				     AutoTrinketBar_Config[AutoTrinketBar_Player].x, AutoTrinketBar_Config[AutoTrinketBar_Player].y);
		elseif (forced == "HIDDEN") then
			atb:ClearAllPoints();
			atb:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", 50, -50);
		end
	end
end

--------------------------------------------------------------------------------------------------
-- Not so internal functions
--------------------------------------------------------------------------------------------------

function AutoTrinketBar_SlashCmd(msg)
	msg = string.lower (msg);
	if (msg == "") then
--		ChatFrame1:AddMessage("/trinketbar and /atb are aliases for /autotrinketbar");
		ChatFrame1:AddMessage("/atb unlock - unlocks AutoTrinketBar so it can be moved around");
		ChatFrame1:AddMessage("/atb lock - locks the AutoTrinketBar in place and saves position");
		ChatFrame1:AddMessage("/atb ttleft - anchors the tooltip to the left of the button");
		ChatFrame1:AddMessage("/atb ttright - anchors the tooltip to the right of the button");
		ChatFrame1:AddMessage("/atb nodrop - enables/disables trinket dragging to buttons");
		ChatFrame1:AddMessage("/atb show - makes AutoTrinketBar visible if it was hidden");
		ChatFrame1:AddMessage("/atb hide - hides AutoTrinketBar");
		ChatFrame1:AddMessage("/atb default - moves AutoTrinketBar to default location regardless of lock/unlock status and unlocks it");
	elseif (msg == "unlock") then
		ChatFrame1:AddMessage("AutoTrinketBar unlocked for moving");
		AutoTrinketBar_Unlock();
	elseif (msg == "lock") then
		ChatFrame1:AddMessage("AutoTrinketBar locked in place");
		AutoTrinketBar_Lock();
	elseif (msg == "default") then
		ChatFrame1:AddMessage("AutoTrinketBar moved to default position and unlocked");
		AutoTrinketBar_Default();
	elseif (msg == "ttleft") then
		ChatFrame1:AddMessage("AutoTrinketBar tooltip anchored to the left of the button");
		AutoTrinketBar_Config[AutoTrinketBar_Player].tooltip = "LEFT";
	elseif (msg == "ttright") then
		ChatFrame1:AddMessage("AutoTrinketBar tooltip anchored to the right of the button");
		AutoTrinketBar_Config[AutoTrinketBar_Player].tooltip = "RIGHT";
	elseif (msg == "nodrop") then
		AutoTrinketBar_ToggleNoDrop();
	elseif (msg == "hide") then
		ChatFrame1:AddMessage("AutoTrinketBar hidden from view");
		AutoTrinketBar_Config[AutoTrinketBar_Player].visible = "NO";
		AutoTrinketBar_SetPosition("HIDDEN");
--		AutoTrinketBar_OnShow();
	elseif (msg == "show") then
		ChatFrame1:AddMessage("AutoTrinketBar is visible again");
		AutoTrinketBar_Config[AutoTrinketBar_Player].visible = "YES";
		AutoTrinketBar_SetPosition("NORMAL");
--		AutoTrinketBar_OnShow();
	end
end

function AutoTrinketBar_Unlock()
	AutoTrinketBar_Config[AutoTrinketBar_Player].lock = "UNLOCKED";
	getglobal("AutoTrinketBar_Background"):Show();
end

function AutoTrinketBar_Lock()
	AutoTrinketBar_Config[AutoTrinketBar_Player].lock = "LOCKED";
	getglobal("AutoTrinketBar_Background"):Hide();
end

function AutoTrinketBar_Default()
	AutoTrinketBar_SetPosition("FORCED");
	AutoTrinketBar_Config[AutoTrinketBar_Player].lock = "UNLOCKED";
	getglobal("AutoTrinketBar_Background"):Show();
	AutoTrinketBar_SavePosition();
end

function AutoTrinketBar_UseTrinket(button)
	local SlotID;
	if (button:GetName() == "AutoTrinketBar_Button1") then
		SlotID = getglobal("CharacterTrinket0Slot"):GetID();
	elseif (button:GetName() == "AutoTrinketBar_Button2") then
		SlotID = getglobal("CharacterTrinket1Slot"):GetID();
	end

	UseInventoryItem(SlotID);
end

function AutoTrinketBar_ConfigInit()
	if (not AutoTrinketBar_Player) then
		ChatFrame1:AddMessage("Config Init called with Player = nil");
		return;
	end
	if (not AutoTrinketBar_Config_Loaded) then
		ChatFrame1:AddMessage("Config Init called without config load");
	end
	if (AutoTrinketBar_Player and AutoTrinketBar_Config_Loaded) then
		if ((not AutoTrinketBar_Config) or
		    (not AutoTrinketBar_Config["AutoTrinketBar_Version"]) or
		    (AutoTrinketBar_Config["AutoTrinketBar_Version"] ~= AutoTrinketBar_Version)) then
			AutoTrinketBar_Config = {};
			AutoTrinketBar_Config["AutoTrinketBar_Version"] = AutoTrinketBar_Version;
		end
		if (not AutoTrinketBar_Config[AutoTrinketBar_Player]) then
			AutoTrinketBar_Config[AutoTrinketBar_Player] = {};
		end
		if (not AutoTrinketBar_Config[AutoTrinketBar_Player].x) then
			AutoTrinketBar_Config[AutoTrinketBar_Player].x = 300;
		end
		if (not AutoTrinketBar_Config[AutoTrinketBar_Player].y) then
			AutoTrinketBar_Config[AutoTrinketBar_Player].y = 300;
		end
		if (not AutoTrinketBar_Config[AutoTrinketBar_Player].lock) then
			AutoTrinketBar_Config[AutoTrinketBar_Player].lock = "UNLOCKED";
		end
--		if (not AutoTrinketBar_Config[AutoTrinketBar_Player].defaultx) then
--			AutoTrinketBar_Config[AutoTrinketBar_Player].defaultx = AutoTrinketBar_DefaultX;
--		end
--		if (not AutoTrinketBar_Config[AutoTrinketBar_Player].defaulty) then
--			AutoTrinketBar_Config[AutoTrinketBar_Player].defaulty = AutoTrinketBar_DefaultY;
--		end
		if (not AutoTrinketBar_Config[AutoTrinketBar_Player].tooltip) then
			AutoTrinketBar_Config[AutoTrinketBar_Player].tooltip = "LEFT";
		end
		if (not AutoTrinketBar_Config[AutoTrinketBar_Player].droppable) then
			AutoTrinketBar_Config[AutoTrinketBar_Player].droppable = "YES";
		end
		if (not AutoTrinketBar_Config[AutoTrinketBar_Player].visible) then
			AutoTrinketBar_Config[AutoTrinketBar_Player].visible = "YES";
		end
	end
end

function AutoTrinketBar_ToggleNoDrop()
	if (AutoTrinketBar_Config[AutoTrinketBar_Player].droppable == "YES") then
		AutoTrinketBar_Config[AutoTrinketBar_Player].droppable = "NO";
		ChatFrame1:AddMessage("Trinket dropping disabled, left click mapped to use");
	elseif (AutoTrinketBar_Config[AutoTrinketBar_Player].droppable == "NO") then
		AutoTrinketBar_Config[AutoTrinketBar_Player].droppable = "YES";
		ChatFrame1:AddMessage("You can now drop trinkets to buttons in AutoTrinketBar");
	end
end