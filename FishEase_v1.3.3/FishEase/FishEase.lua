local _DEBUG = false;
local profile = nil;	-- profile string name for the current character
local cfg = nil;		-- reference to the current character's config
local fishingID = 0;	-- index of the Fishing skill
local mainSID = nil;	-- main hand slot ID
local offSID = nil;		-- off hand slot ID
local gloveSID = nil;	-- glove slot ID
local hatSlotID = nil;	-- hat slot ID
local bootSID = nil;	-- boot slot ID
local box = nil;		-- reference to the FishEaseFishBox button object
local skipSpellChange = nil;	-- whether to ignore the next SPELLS_CHANGED event
local lastClick = 0;			-- the time LeftButton was last clicked
local maxClickDelta = 0.3;		-- the max allowed time delta to qualify as a double click
-- these are for the un-safe right-click cast feature
local downTime = 0;
local clickToMove = nil;
FE_OldTOABIND = nil;
local isChanneling = nil;

local function Print(msg)
	if (not msg) then return; end
	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage(msg,1.0,1.0,1.0);
	end
end
local function Debug(msg)
	if (not _DEBUG) then return; end
	if (not msg) then return; end
	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage("FE: "..GetTime()..": "..msg,1.0,0.0,0.0);
	end
end
local function ToggleDebug()
	_DEBUG = not _DEBUG;
	Print("Debug output is now "..(_DEBUG and "on" or "off"));
end

-- Toggles the specified option and informs the user of the new state
local function ToggleOption(togVar, optName, optSyntax, optOutString)
	if (not togVar) then
		cfg[optName] = not cfg[optName];
	elseif (string.lower(togVar) == "on") then
		cfg[optName] = true;
	elseif (togVar == "off") then
		cfg[optName] = false;
	else
		Print(FE_SYNTAX_ERROR);
		Print(optSyntax);
		return;
	end
	Print(string.format(optOutString, (cfg[optName] and FE_OUT_ON or FE_OUT_OFF)));
end

-- Resets this character's saved fishing gear sets
local function ResetGear()
	cfg["normMain"]  = nil;
	cfg["normOff"]   = nil;
	cfg["normGlove"] = nil;
	cfg["normHat"]   = nil;
	cfg["fishPole"]  = nil;
	cfg["fishGlove"] = nil;
	cfg["fishHat"]   = nil;
	cfg["fishBoot"]  = nil;
	Print(FE_OUT_RESET);
end

-- begins dragging the fish box
local function BoxOnMouseDown()
	if ( ((not this.isLocked) or (this.isLocked == 0)) and (arg1 == "LeftButton") ) then
		this:StartMoving();
		this.isMoving = 1;
	end
end

-- stops dragging the fish box
local function BoxOnMouseUpOrHide()
	if (this.isMoving) then
		this:StopMovingOrSizing();
		this.isMoving = nil;

		-- save the position of the box
		Debug("new home position: "..this:GetLeft()..","..this:GetTop());
		cfg["homeX"] = this:GetLeft();
		cfg["homeY"] = this:GetBottom();
	end
end

-- moves the fish box to its saved home position
function MoveBoxHome()
	if (not box) then return; end
	box:ClearAllPoints();
	box:SetPoint("BOTTOMLEFT", "UIParent", cfg["homeX"], cfg["homeY"]);
end

-- moves the fish box to be centered under the mouse (assuming full size)
local function MoveBoxToMouse()

	if (not box) then return; end

	-- get mouse position and correct it for the UI scale
	local x,y = GetCursorPosition(UIParent);
	x = x / UIParent:GetScale();
	y = y / UIParent:GetScale();

	-- add adjustments to center based on button size
	x = x - 18;
	y = y - 18;

	-- and finally move the button to the coordinates
	box:ClearAllPoints();
	box:SetPoint("BOTTOMLEFT", "UIParent", x, y);

end

-- hides the fish box based on visibility settings
local function HideBox()

	if (not box) then return; end

	-- first move it home
	MoveBoxHome();

	-- now "hide" it
	if (cfg[FE_CMD_STICKYBOX]) then
		if (box.isActive) then
			box.isActive = nil;
			Debug("setting fish box inactive");
			box:SetWidth(20);
			box:SetHeight(20);
			box:SetAlpha(0.5);
		end
		if (not box:IsShown()) then box:Show(); end
	else
		Debug("hiding fish box");
		if (box and box:IsShown()) then box:Hide(); end
	end

end

-- activates the fish box
local function ActivateBox()

	if (not box) then return; end

	if (not box.isActive) then
		box.isActive = 1;
		Debug("activating fish box");
		box:SetWidth(37);
		box:SetHeight(37);
		box:SetAlpha(1.0);
	end
	if (not box:IsShown()) then box:Show(); end
end

-- called when either mouse button is release (can cast spells from this one)
local function BoxOnClick()
	if (arg1 == "LeftButton") then

		-- check for double click
		if ( (GetTime() - lastClick) <= maxClickDelta ) then
			FE_Switch();
		end
		lastClick = GetTime();

	else	-- RightButton

		FE_StartFishing();

	end
end

-- dynamically creates the fish box button
local function CreateFishBox()

	if (not FishEaseFishBox) then

		Debug("creating new fish box");
		box = CreateFrame("Button","FishEaseFishBox",UIParent);

		-- set the basic size and appearance
		box:SetFrameStrata("DIALOG");	-- on top of most everything
		box.isActive = 1;
		box:SetWidth(37);				-- standard button size
		box:SetHeight(37);				-- standard button size
		box:SetAlpha(1.0);
		local t = box:CreateTexture("FishEaseFishBoxBackground","BACKGROUND");
		t:SetTexture("Interface\\Icons\\Trade_Fishing");
		t:SetAllPoints(box);

		-- setup all of the mouse interaction
		box:EnableMouse(1);
		box:SetMovable(1);
		box:SetScript("OnMouseDown", BoxOnMouseDown);
		box:SetScript("OnMouseUp", BoxOnMouseUpOrHide);
		box:SetScript("OnHide", BoxOnMouseUpOrHide);
		box:RegisterForClicks("LeftButtonUp", "RightButtonUp");	-- which button actions will cause OnClick to fire
		box:SetScript("OnClick", BoxOnClick);

		-- set initial position if it has never been placed before
		if (not box:IsUserPlaced()) then
			--box:ClearAllPoints();
			box:SetPoint("CENTER",0,0);
		end

	end

	if (not box) then
		Debug("adding local reference to existing fish box");
		box = FishEaseFishBox;
	end

end

-- updates the visibility of the fishing box based on various options and gear state
local function UpdateFishBox()

	if (cfg[FE_CMD_SAFEMODE]) then

		CreateFishBox();

		-- set box's visible state
		if (not FE_IsPoleEquipped()) then
			HideBox();
		else
			ActivateBox();
		end

	else
		HideBox();
	end
end

-- slash command handler
local function SlashCmdHandler(msg)
	if (not msg) then return; end
	local args = {};
	for arg in string.gfind(msg, "([%w]+)") do
		table.insert(args, arg);
	end
	if (not args[1]) then
		-- show the status of various options
		Print(string.format(FE_OUT_EASYCAST, (cfg[FE_CMD_EASYCAST] and FE_OUT_ON or FE_OUT_OFF)));
		--Print(string.format(FE_OUT_SHIFTCAST, (cfg[FE_CMD_SHIFTCAST] and FE_OUT_ON or FE_OUT_OFF)));
		--Print(string.format(FE_OUT_SAFEMODE, (cfg[FE_CMD_SAFEMODE] and FE_OUT_ON or FE_OUT_OFF)));
		--Print(string.format(FE_OUT_STICKYBOX, (cfg[FE_CMD_STICKYBOX] and FE_OUT_ON or FE_OUT_OFF)));
		return;
	end
	local cmd = string.lower(args[1]);

	if (cmd == string.lower(FE_CMD_EASYCAST)) then
		ToggleOption(args[2], FE_CMD_EASYCAST, FE_SYNTAX_EASYCAST, FE_OUT_EASYCAST);

	elseif (cmd == string.lower(FE_CMD_SHIFTCAST)) then
		ToggleOption(args[2], FE_CMD_SHIFTCAST, FE_SYNTAX_SHIFTCAST, FE_OUT_SHIFTCAST);

	elseif (cmd == string.lower(FE_CMD_SAFEMODE)) then
		ToggleOption(args[2], FE_CMD_SAFEMODE, FE_SYNTAX_SAFEMODE, FE_OUT_SAFEMODE);
		UpdateFishBox();

	elseif (cmd == string.lower(FE_CMD_STICKYBOX)) then
		ToggleOption(args[2], FE_CMD_STICKYBOX, FE_SYNTAX_STICKYBOX, FE_OUT_STICKYBOX);
		UpdateFishBox();

	elseif (cmd == string.lower(FE_CMD_LOCK)) then
		box.isLocked = true;
		Print(FE_OUT_LOCKED);

	elseif (cmd == string.lower(FE_CMD_UNLOCK)) then
		box.isLocked = false;
		Print(FE_OUT_UNLOCKED);

	elseif (cmd == string.lower(FE_CMD_FIX)) then
		box:ClearAllPoints();
		box:SetPoint("CENTER",0,0);
		box.isLocked = false;
		ActivateBox();

	elseif (cmd == string.lower(FE_CMD_SWITCH)) then
		FE_Switch();

	elseif (cmd == string.lower(FE_CMD_RESET)) then
		ResetGear();

	elseif (cmd == "debug") then
		ToggleDebug();

	else
		for index, value in FE_COMMAND_HELP do
			Print(value);
		end
	end
end

-- the first thing that happens when this addon is loaded
function FE_OnLoad()

	-- create slash commands
	SlashCmdList["FESLASH"] = SlashCmdHandler;
	SLASH_FESLASH1 = "/fishease";
	SLASH_FESLASH2 = "/fe";

	-- register for necessary events
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("SPELLS_CHANGED");
	this:RegisterEvent("UPDATE_INVENTORY_ALERTS");	-- fired when a visible equipment slot changes
	--this:RegisterEvent("UNIT_INVENTORY_CHANGED");
	this:RegisterEvent("SPELLCAST_CHANNEL_START");
	this:RegisterEvent("SPELLCAST_CHANNEL_STOP");
	this:RegisterEvent("LOOT_OPENED")
	this:RegisterEvent("LOOT_SLOT_CLEARED")
	this:RegisterEvent("LOOT_CLOSED")

	-- these are used for the un-safe right click casting mode
	WorldFrame:SetScript("OnMouseDown", FE_WorldMouseDown);
	WorldFrame:SetScript("OnMouseUp", FE_WorldMouseUp);

end

function FE_WorldMouseDown()

	-- make sure safe mode isn't on and we've got the right mouse button
	if (cfg[FE_CMD_SAFEMODE] or arg1 ~= "RightButton") then return; end

	if (cfg[FE_CMD_EASYCAST] and FE_IsPoleEquipped() and fishingID > 0) then

		-- Disable Click-to-Move if they have a fishing pole equipped
		if (cfg[FE_CMD_EASYCAST] and GetCVar("autointeract") == "1" and FE_IsPoleEquipped()) then
			clickToMove = "1";
			SetCVar("autointeract", "0");
		end

		-- Set the mouse down time
		if (cfg[FE_CMD_EASYCAST]) then
			if (GameTooltip:IsVisible() and (getglobal("GameTooltipTextLeft1"):GetText() == FE_BOBBER_NAME)) then
				Debug("tooltip vis and equal to bobber name");
				downTime = 0;
			else
				downTime = GetTime();
			end
		end

	end

end

function FE_WorldMouseUp()

	-- make sure safe mode isn't on and we've got the right mouse button
	if (cfg[FE_CMD_SAFEMODE] or arg1 ~= "RightButton") then return; end

	-- hijack depends on no more than 1 modifier key being pressed
	if ((IsAltKeyDown() and (IsShiftKeyDown() or IsControlKeyDown())) or (IsShiftKeyDown() and IsControlKeyDown())) then
		return;
	end

	-- hijack the TurnOrAction binding
	-- (but only if we need to since the click doesn't pass through anymore)
	if (cfg[FE_CMD_EASYCAST] and not isChanneling) then
		local pressTime = GetTime() - downTime;
		if (fishingID > 0 and pressTime <= 0.2) then
			if (not cfg[FE_CMD_SHIFTCAST] or (cfg[FE_CMD_SHIFTCAST] and IsShiftKeyDown())) then
				if (FE_IsPoleEquipped()) then

					Debug("hijacking binding");
					if (not FE_OldTOABIND) then
						FE_OldTOABIND = GetBindingKey("TURNORACTION");
					end
					if (FE_OldTOABIND) then
						SetBinding(FE_OldTOABIND, "FE_TURNORACTION");
					end

				end
			end
		end
	elseif (isChanneling) then
		Debug("still channeling");
	end

end

function FE_RestoreBinding()
	if (FE_OldTOABIND) then
		SetBinding(FE_OldTOABIND, "TURNORACTION");
		FE_OldTOABIND = nil;
	end
end

function FE_TurnOrActionStop()

	-- make sure we emulate what would've happened
	MouselookStop();

	-- restore the hijacked binding
	FE_RestoreBinding();

	-- Cast the line
	Debug("attempting to cast");
	CastSpell(fishingID, BOOKTYPE_SPELL);

	-- Re-enable Click-to-Move if we changed it
	if (clickToMove and (GetCVar("autointeract") == "0")) then
		SetCVar("autointeract", "1");
	end

end

-- attempts to find the ID of the fishing skill in the spellbook
local function LearnFishingSkill()
	-- reset the fishingID in case they un-learned it
	fishingID = 0;

	--Loop through only the General tab looking for the Fishing skill
	local _, _, off, num = GetSpellTabInfo(1);
	local sIcon = nil;
	for i=(off+1), (off+num) do
		sIcon = GetSpellTexture(i,1);
		if (sIcon and sIcon == "Interface\\Icons\\Trade_Fishing") then
			fishingID = i;
			Debug("Fishing ID: "..fishingID);
			return;
		end
	end
end

-- called for all events we registered for in OnLoad
function FE_OnEvent(event)

	if (event == "ADDON_LOADED") then

		if (not arg1 or string.lower(arg1) ~= string.lower(FE_ADDON_NAME)) then return; end

Debug(event..": "..(arg1 or ""));

		-- initialize this character's config
		if (not cfg) then
			FishEase_Cfg = FishEase_Cfg or {};
			if (FishEase_Cfg["version"] ~= FE_ADDON_VER) then
				-- do older version cleanup here?
				FishEase_Cfg["version"] = FE_ADDON_VER;
			end

			profile = UnitName("player").." of "..GetCVar("RealmName");
			if (not FishEase_Cfg[profile]) then
				Debug("Setting FishEase defaults for "..profile);
				FishEase_Cfg[profile] = {
					[FE_CMD_EASYCAST] = true,
					[FE_CMD_SHIFTCAST] = false,
					[FE_CMD_SAFEMODE] = false,
					[FE_CMD_STICKYBOX] = false,
				};
			end
			cfg = FishEase_Cfg[profile];
		end

		-- get the Slot IDs for the slots we care about so we don't
		-- have to ask later.
		mainSID   = GetInventorySlotInfo("MainHandSlot");
		offSID    = GetInventorySlotInfo("SecondaryHandSlot");
		gloveSID  = GetInventorySlotInfo("HandsSlot");
		hatSlotID = GetInventorySlotInfo("HeadSlot");
		bootSID   = GetInventorySlotInfo("FeetSlot");

		LearnFishingSkill();

		UpdateFishBox();

		return;
	end

	if (event == "SPELLS_CHANGED") then
		if (skipSpellChange) then
			skipSpellChange = nil;
			return;
		end
		LearnFishingSkill();
		return;
	end

	if (event == "UPDATE_INVENTORY_ALERTS") then
		UpdateFishBox();
		return;
	end

	if (event == "SPELLCAST_CHANNEL_START") then
		Debug("channel start");
		isChanneling = 1;
		MoveBoxHome();
		return;
	end

	if (event == "SPELLCAST_CHANNEL_STOP") then
		Debug("channel stop");
		isChanneling = nil;
		MoveBoxToMouse();
		return;
	end

	-- show debug msg for anything we didn't explicitly catch
	Debug(event..": "..(arg1 or ""));
end

-- effectively a spam'able function that does what's needed in order
-- to start fishing
function FE_StartFishing()

	if (cfg[FE_CMD_SAFEMODE]) then ActivateBox(); end

	-- switch to fishing gear if needed
	if (not FE_IsPoleEquipped()) then
		FE_Switch();
		MoveBoxToMouse();
	else
		-- cast your line
		CastSpell(fishingID, BOOKTYPE_SPELL);
	end

end

-- searches through the player's bags for the itemID forwards or backwards
local function FindContainerItem(itemID, searchReverse)
	if (not itemID) then return nil,nil; end

	local foundBag = nil;
	local foundSlot = nil;
	local numSlots = 0;

	local startBag, endBag, bagStep = 0, NUM_BAG_FRAMES, 1;
	if (searchReverse) then
		startBag, endBag, bagStep = NUM_BAG_FRAMES, 0, -1;
	end

	-- check each of the bags on the player
	for i=startBag, endBag, bagStep do

		-- get the number of slots in the bag (0 if no bag)
		numSlots = GetContainerNumSlots(i);
		if (numSlots > 0) then

			-- check each slot in the bag
			local startSlot, endSlot, slotStep = 1, numSlots, 1;
			if (searchReverse) then
				startSlot, endSlot, slotStep = numSlots, 1, -1;
			end
			for j=startSlot, endSlot, slotStep do

				itemLink = GetContainerItemLink(i,j);
				if (itemLink) then

					-- check for the specified itemID
					if (string.find(itemLink, "item:"..itemID..":")) then
						foundBag = i;
						foundSlot = j;
						Debug("Found "..itemLink.." at bag"..foundBag.." slot"..foundSlot);
						-- break out of the slot loop
						break;
					end

				end
			end

			-- break out of the bag loop if we found the item
			if (foundBag) then break; end
		end
	end

	return foundBag, foundSlot;
end

-- tries to find and equip the given item into the given slot
local function EquipItem(itemID, equipSlot)
	-- fail if something's on the cursor
	if (CursorHasItem()) then
		return false;
	end
	-- make sure it's not already equipped
	local currentLink = GetInventoryItemLink("player",equipSlot);
	if (currentLink and string.find(currentLink, "item:"..itemID..":")) then
		return true;
	end
	-- try to find the item in their bags
	local bag, slot;
	if (equipSlot == mainSID and cfg["normMain"] == cfg["normOff"]) then
		bag, slot = FindContainerItem(itemID, true);
	else
		bag, slot = FindContainerItem(itemID);
	end
	if (bag and slot) then
		PickupContainerItem(bag, slot);
		if (equipSlot) then
			PickupInventoryItem(equipSlot);
		else
			AutoEquipCursorItem();
		end
		return true;
	end
	return false;
end

-- saves the current item in the specified slot to the character's config
local function SaveSwitchItem(itemID, slotID, saveName, setString)
	if (itemID and itemID ~= cfg[saveName]) then
		cfg[saveName] = itemID;
		if (itemID) then
			Print(string.format(setString,GetInventoryItemLink("player",slotID)));
		end
	end
end

-- swaps the saved itemID into the given slot and shows an optional output message
local function SwapSlot(saveName, slotID, setString)
	if (cfg[saveName]) then
		if (not EquipItem(cfg[saveName],slotID)) then
			-- couldn't equip item
			Debug("couldn't equip "..saveName.."("..cfg[saveName]..") into slot "..slotID);
			cfg[saveName] = nil;
		end
	end
	if (not cfg[saveName] and setString) then
		Print(setString);
	end
end

-- gets the item ID for the item in the given equipment slot
local function GetEquippedItemID(slotID)
	local link = GetInventoryItemLink("player", slotID);
	local id = nil;
	if (link) then
		for id in string.gfind(link, "item:(%d+):") do
			return tonumber(id);
		end
	end
	return id;
end

-- gets the item IDs for the currently equipped gear set
local function GetEquippedGear()
	local mainHandID, offHandID, gloveID, hatID, bootID = nil, nil, nil, nil, nil;
	mainHandID = GetEquippedItemID(mainSID);
	offHandID  = GetEquippedItemID(offSID);
	gloveID    = GetEquippedItemID(gloveSID);
	hatID      = GetEquippedItemID(hatSlotID);
	bootID     = GetEquippedItemID(bootSID);
	return mainHandID, offHandID, gloveID, hatID, bootID;
end

-- swaps between your fishing gear and normal gear
function FE_Switch()

	--[[
		Swapping your primary weapon generates a SPELLS_CHANGED event.  This
		is likely because the Attack icon in the spell book gets updated to
		use whatever icon your primary weapon has.  But since we know we
		generated it, we're going to ignore it.
	--]]
	skipSpellChange = true;

	local mainHandID, offHandID, gloveID, hatID, bootID = GetEquippedGear();

	if (FE_IsPoleEquipped()) then

		-- Save our current fishing gear
		SaveSwitchItem(mainHandID, mainSID, "fishPole", FE_OUT_SET_POLE);
		SaveSwitchItem(gloveID, gloveSID, "fishGlove", FE_OUT_SET_FISHING_GLOVES);
		SaveSwitchItem(hatID, hatSlotID, "fishHat", FE_OUT_SET_FISHING_HAT);
		SaveSwitchItem(bootID, bootSID, "fishBoot", FE_OUT_SET_FISHING_BOOT);

		-- Swap to normal gear
		SwapSlot("normMain", mainSID, FE_OUT_NEED_SET_NORMAL);
		SwapSlot("normOff", offSID, nil);
		SwapSlot("normGlove", gloveSID, nil);
		SwapSlot("normHat", hatSlotID, nil);
		SwapSlot("normBoot", bootSID, nil);

	else

		-- Save our current normal gear
		SaveSwitchItem(mainHandID, mainSID, "normMain", FE_OUT_SET_MAIN);
		SaveSwitchItem(offHandID, offSID, "normOff", FE_OUT_SET_SECONDARY);
		SaveSwitchItem(gloveID, gloveSID, "normGlove", FE_OUT_SET_GLOVES);
		SaveSwitchItem(hatID, hatSlotID, "normHat", FE_OUT_SET_HAT);
		SaveSwitchItem(bootID, bootSID, "normBoot", FE_OUT_SET_BOOT);

		-- Swap to fishing gear
		SwapSlot("fishPole", mainSID, FE_OUT_NEED_SET_POLE);
		SwapSlot("fishGlove", gloveSID, nil);
		SwapSlot("fishHat", hatSlotID, nil);
		SwapSlot("fishBoot", bootSID, nil);

	end

end

--[[ Keeping this for reference
	6256,	-- Fishing Pole
	6365,	-- Strong Fishing Pole
	6366,	-- Darkwood Fishing Pole
	6367,	-- Big Iron Fishing Pole
	12225,	-- Blump Family Fishing Pole
	19022,	-- Nat Pagle\'s Extreme Angler FC-5000
	19970,  -- Arcanite Fishing Pole
--]]
-- Checks the texture of the main hand item to see whether it's a fishing pole
function FE_IsPoleEquipped()
	local itemIcon = GetInventoryItemTexture("player", mainSID);
	if (itemIcon and string.find(itemIcon, "INV_Fishingpole")) then
		return true;
	else
		return nil;
	end
end
