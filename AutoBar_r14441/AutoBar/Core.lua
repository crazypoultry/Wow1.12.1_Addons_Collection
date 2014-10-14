--
--  AutoBar
--  Copyright 2004, 2005, 2006 original author.
--  New Stuff Copyright 2006 Toadkiller of Proudmoore.

--  Configurable set of 24 buttons that seeks out configured items
--  in your pack for use. Intended primarily for consumables. Not
--  for use with spells, skills, trinkets, or powers.
--
--  Maintained by Azethoth / Toadkiller of Proudmoore.  Original author Saien of Hyjal
--  http://www.curse-gaming.com/en/wow/addons-4430-1-autobar-toadkiller.html

-- Coming Attractions:
-- Don't show buff items if buffed already
-- On click bring config to front.
-- Set operations / calculated categories.
-- Multible bars or individually draggable buttons?
-- Exchange profiles
-- Hide Microbuttons option
-- Indication of when an object being edited is obscured by a higher layer.
-- Named Custom Categories, Named button ranges.

-- Next Up:
-- ItemClasses-2.0, UseItem-2.0, CursorItem-2.0, Tablet-2.0, Ace Locale
-- Bartender support?
-- Named Slots

-- 1.12.06.10 beta
-- Make Drag Handle hideable again
-- Dock to bottom right action bar, left or right side of it.

-- 1.12.06.09
-- Switch to Ace Event for timers
-- Upgrade align buttons option to have any combination of vertical and horizontal alignment (9 options).
-- Fix toc for Ace svn

-- 1.12.06.08
-- Korean + some more incremental ACE Locale changes for all languages.

-- 1.12.06.07
-- Renamed files ACE Locale style + some incremental ACE Locale changes for all languages.
-- Deleted obsolete dependencies and files.
-- Toc changes to support ace & ace wiki.

-- 1.12.06.06
-- Actually separate display editing from slots editing for Character vs Shared.
-- This clears up a crasher & some non-obvious behavior after a reset.

-- 1.12.06.05
-- Lock all bars option for drag handle + 30 second timeout on the unlock.  No more accidentally dragging action bar items around!
-- Cleared up a case of algorithm necrosis
-- Looks like Character layout got broken.  Will be fixed next version.  Use Shared layout for now.

-- 1.12.06.04
-- Fixed some Compost library issues.
-- Fixed a couple of spots where non tables were fed into the slots list again.

-- 1.12.06.03
-- Remove single item slot option.  Its pretty pointless & prevents all kinds of options.
-- Compost-2.0
-- oSkin support checkbox on profile tab.  Random results on choose category / view category dialog though.

-- 1.12.06.02
-- Fix embedded library issue

-- 1.12.06.01
-- Ace 2
-- Dewdrop-2.0
-- Boiled clams moved to bonus category
-- Do not flash the popup when using keybinding
-- Harvest festival foods
-- Korean, tx Sayclub!

-- 1.12.05
-- Ok, here it is: the release version of the profiling system.
-- Changed defaults so profile is Single for people with existing Character layer buttons, and Standard profile if not.
-- Dense Dynamite
-- Default noPopup for mount changed to arrangeOnUse.  A better way to go now that mounts are cheap.

-- 1.12.04.12
-- Korean
-- Label Combined Layer View & Layer Edit Sections.
-- Hide edit layer buttons that are not enabled.
-- Config Tooltips.

-- 1.12.04.11
-- View Slot now has a red background and appropriate title and the errant button is now properly hidden.
-- Added some text directing you to the Slots tab for editing as well.
-- Edit Slot dialog has a slightly green background to indicate editing is possible.

-- 1.12.04.10
-- Winterfall Firewater
-- Removed some duplicates in the pet food meat section
-- Revert Button for config so you can undo unintended changes & experiment more freely
-- Basic and Class layers now editable as well
-- Quick Setup & Reset buttons: Single, Shared, Custom as well as blank slate button.

-- 1.12.04.09
-- Chinese & Korean courtesy of the usual suspects
-- Runes added to potion slot

-- 1.12.04.08
-- Fixed dragging slots around on the slots tab.
-- Can now drag from the slot view at the top to the slots being edited at the bottom as well.
-- Fixed slot view not updating when selecting profile layers in the profile

-- 1.12.04.07
-- Added a zeroing out category called "Clear Slot" as well as a button for it on the edit slot dialog.

-- 1.12.04.06
-- Simplified profile interface
-- Now has 4 shared profiles, selectable under profile tab
-- Fixed Smart Self Cast bug.
-- Added Smart Self Cast to defaults
-- Smart Self Cast remains partly broken in its current implementation until it gets a rewrite
-- You can turn the individual ones on but not necessarily off if they are part of the defaults etc.

-- 1.12.04.05
-- Added Clear Slot category.

-- 1.12.04.04
-- Fixed warrior rage potion slot conflicting with heal potions

-- 1.12.04.03
-- Class default bug fix
-- Arathi Basin Food upgrade, tx Ghoschdi
-- Korean, tx Sayclub
-- Expanded slot list to 16.  Removed the clunky movement buttons.  Use drag & drop to reorder instead.
-- Split out more code for the various frames
-- Fixed autoselfcast for now.  Needs a better implementation.
-- Slot View area has tooltips again & clicking them brings up a non-editable Slot View.

-- 1.12.04.01
-- Profile Tab: 4 layers, current edit layer picked at top of dialog.  Class & Basic defaults (not editable)
-- Display settings are either character specific or shared.  No layering.
-- Fixed frame strata for bar & popup
-- Seperated code for ChooseCategory and ConfigSlot.
-- Some lua changes for 2.0
-- Hourglass Sand
-- Casting Cursor used for button interaction
-- Removed custom item insertion.  Cumbersome and not needed if u can drag & drop.
-- Align center button is not functional.  Renamed from "reverse buttons"
-- Slots tab for editing character or shared slots.  Old slots section is now display only, still needs work.

-- 1.12.03
-- Korean thanks to Sayclub
-- Disabled code that hid character buttons when docking to main menu.  These have unintended side effects.

-- 1.12.02.05
-- Chinese Simplified & Traditional (Thanks PDI175)
-- Fixed some typos in localization.

-- 1.12.02.04
-- Pet feed on right click should now work.  Tx Kerrang.  Still need to upgrade the pet food category handling itself.

-- 1.12.02.03
-- Fixed onload issue that broke slash commands
-- AutoBar now dismisses with the escape key as it should
-- Added click for config show / hide

-- 1.12.02.02
-- New 1.12 function ClearCursor() called after drag & drop.
-- Juju
-- First cut of tabbed interface for config
-- 24 buttons
-- Arathi Basin Field Ration
-- Config dialog is now draggable
-- Hunter Pet Food & Feeding
-- First cut at blizzard style dialog.  A frustrating thing as texcoords don't act as expected.

-- 1.12.02
-- Dock to is now list based with a drop down.  I will make the drop down pretty some other time.  Needs settings for various bars.
-- Empty Slot button added.
-- Popup Z order increased so its in front of other mods

-- 1.12.01
-- Chinese Simplified & Traditional (Thanks PDI175)
-- TOC updated.
-- Fixed plain buttons bug
-- Improved config layout for Korean.

-- 1.11.16.01
-- Fixed popup click bug.  Apparently mouseup events do not allow casting like click events.  Strange.
-- Disabled some config checkboxes for single category slots.  Fixes crash.
-- Fixed keybinding screwup.
-- Some more hunter pet foods added.  meats aren't done yet.
-- Added a drag handle for the bar.  Left click to lock right click to bring up options.  Handle can be hidden.
-- Slot specific option to disable popup.
-- Slot specific option to rearrange category priority on use.
-- Increased max popup buttons to 12.

-- 1.11.15.04
-- Done button on config panel to avoid confusion.
-- Option to show Category Icon for slots with 0 item count.  Displayed dark & with -- to distinguish them from regular slots.
-- Scale item count, hotKey and Cooldown Clock text beyond size 36 and up to size 72
-- First cut at a popup list for slots with 2 or more available items
-- Added some unsorted items to pet foods.  These will be broken till sorted.
-- Config for popup direction
-- Fixed popup button scaling
-- Popup on modifier key
-- Popup disable
-- Tooltip for popup buttons
-- Added Jungle Remedy
-- Popup hit rect overlap fixed

-- 1.11.14.03
-- New User / deleted wtf config file bug fix.  tx Xavior for finding it.
-- Ahn Qirajh translation for Chinese. Thanks PDI175.
-- Typo fixed
-- Working Korean I think.  Thanks to Sayclub

-- 1.11.13
-- Deutch! Ser gut Teodred!

-- 1.11.12
-- Korean thanks to Sayclub!

-- 1.11.11
-- Ooh, Traditional Chinese thanks to PDI175
-- Roasted Quail added to pet meats
-- Use the highest priority item for the icon.  (ie. the bottom one in the category list).

-- 1.11.10
-- More Drag & Drop: rearrange button categories now as well
-- Drag from inventory into a button's items (or click on an item then click on category button)
-- Potions: Holy Protection, Agility, Strength, Fortitude, Intellect, Wisdom, Defense, Troll Blood

-- 1.11.09
-- Anti-Venom
-- Global smart self cast checkbox
-- Scrolls of Agility, Intellect, Protection, Stamina, Strength, Spirit
-- Food categories for no bonus food so hunters can feed themselves

-- 1.11.08
-- Drag & Drop to rearrange slot category order in the config dialog.
-- Close button added to config
-- Updated some category icons.

-- 1.11.07
-- Row & column sliders in the config panel are now freely slideable.

-- 1.11.06
-- Fixed glitch at 6 columns

-- 1.11.05
-- Friendship Bread, Freshly Squeezed Lemonade, Wildvine Potion, Sagefish Delight, Smoked Sagefish
-- Dirge's Kickin' Chimaerok Chops,
-- Fixed: Essence Mango,

-- 1.11.04
-- Reset to default button for the buttons
-- Hide tooltips option
-- Demonic and Dark Runes, Battle Standards, Invulnerability Potions

-- 1.11.03.01
-- Deathcharger's Reins, Qiraji Mounts
-- Reworked defaults a bit.

-- 1.11.02
-- Mojos of Zanza & essence mangos; arcane, fire, frost, nature, shadow, spell Protection Potions.
-- Dreamless sleep
-- First cut of cooldown.

-- 1.11.01
-- Added new AD oil & sharpening stone.
-- Expand up to 18 buttons.
-- Rolled in the nurfed version's changes for pvp potions
-- Chocolate Square

--  2006.03.31
--    Minor category changes
-- Last version by Saien

local L = AceLibrary("AceLocale-2.1"):GetInstance("AutoBar", true);

BINDING_HEADER_AUTOBAR_SEP = L["AUTOBAR"];
BINDING_NAME_AUTOBAR_CONFIG = L["CONFIG_WINDOW"];
BINDING_NAME_AUTOBAR_BUTTON1 = L["BUTTON"] .. " 1";
BINDING_NAME_AUTOBAR_BUTTON2 = L["BUTTON"] .. " 2";
BINDING_NAME_AUTOBAR_BUTTON3 = L["BUTTON"] .. " 3";
BINDING_NAME_AUTOBAR_BUTTON4 = L["BUTTON"] .. " 4";
BINDING_NAME_AUTOBAR_BUTTON5 = L["BUTTON"] .. " 5";
BINDING_NAME_AUTOBAR_BUTTON6 = L["BUTTON"] .. " 6";
BINDING_NAME_AUTOBAR_BUTTON7 = L["BUTTON"] .. " 7";
BINDING_NAME_AUTOBAR_BUTTON8 = L["BUTTON"] .. " 8";
BINDING_NAME_AUTOBAR_BUTTON9 = L["BUTTON"] .. " 9";
BINDING_NAME_AUTOBAR_BUTTON10 = L["BUTTON"] .. " 10";
BINDING_NAME_AUTOBAR_BUTTON11 = L["BUTTON"] .. " 11";
BINDING_NAME_AUTOBAR_BUTTON12 = L["BUTTON"] .. " 12";
BINDING_NAME_AUTOBAR_BUTTON13 = L["BUTTON"] .. " 13";
BINDING_NAME_AUTOBAR_BUTTON14 = L["BUTTON"] .. " 14";
BINDING_NAME_AUTOBAR_BUTTON15 = L["BUTTON"] .. " 15";
BINDING_NAME_AUTOBAR_BUTTON16 = L["BUTTON"] .. " 16";
BINDING_NAME_AUTOBAR_BUTTON17 = L["BUTTON"] .. " 17";
BINDING_NAME_AUTOBAR_BUTTON18 = L["BUTTON"] .. " 18";
BINDING_NAME_AUTOBAR_BUTTON19 = L["BUTTON"] .. " 19";
BINDING_NAME_AUTOBAR_BUTTON20 = L["BUTTON"] .. " 20";
BINDING_NAME_AUTOBAR_BUTTON21 = L["BUTTON"] .. " 21";
BINDING_NAME_AUTOBAR_BUTTON22 = L["BUTTON"] .. " 22";
BINDING_NAME_AUTOBAR_BUTTON23 = L["BUTTON"] .. " 23";
BINDING_NAME_AUTOBAR_BUTTON24 = L["BUTTON"] .. " 24";

local options = {
    type = 'execute',
    desc = "Toggle the config panel",
    func = function()
        getglobal("AutoBarConfig_Toggle")();
    end
}

-- If the Debug library is available then use it
if AceLibrary:HasInstance("AceDebug-2.0") then
	AutoBar = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceEvent-2.0", "AceDebug-2.0");
else
	AutoBar = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceEvent-2.0");
end
AutoBar:RegisterChatCommand({L["SLASHCMD_SHORT"], L["SLASHCMD_LONG"]}, options)

AUTOBAR_MAXBUTTONS = 24;
AUTOBAR_MAXPOPUPBUTTONS = 12;
AUTOBAR_MAXSLOTCATEGORIES = 16;

AutoBar_Debug = nil;

AutoBar_SearchedForItems = {};
local AutoBar_ButtonItemList = {};
local AutoBar_ButtonItemList_Reversed = {};
local AutoBar_Buttons_CurrentItems = {};


function AutoBar:OnInitialize()
	AutoBar.currentPlayer = UnitName("player") .. " - " .. GetCVar("realmName");

	AutoBar.inWorld = false;
	AutoBar.inCombat = false;	-- For item use restrictions
	AutoBar.inBG = false;		-- For battleground only items

	AutoBarItemList:OnInitialize();
end


function AutoBar:OnEnable()
    -- Called when the addon is enabled
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("PLAYER_LEAVING_WORLD")
    self:RegisterEvent("BAG_UPDATE")
    self:RegisterEvent("UPDATE_BINDINGS")

	-- For item use restrictions
    self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
    self:RegisterEvent("PLAYER_REGEN_ENABLED")
    self:RegisterEvent("PLAYER_REGEN_DISABLED")
    self:RegisterEvent("UNIT_MANA")
    self:RegisterEvent("UNIT_HEALTH")
    self:RegisterEvent("PLAYER_ALIVE")
    self:RegisterEvent("BAG_UPDATE_COOLDOWN")
    self:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
end


function AutoBar:OnDisable()
    -- Called when the addon is disabled
end


function AutoBar:PLAYER_ENTERING_WORLD()
	AutoBar.inCombat = false;
	local scanned = false;
	if (not AutoBar.initialized) then
		AutoBarProfile.Initialize();
		AutoBar.ConfigChanged();
		profileLoaded = true;
		AutoBar_ScanBags();
		scanned = true;
		AutoBarConfig:TabButtonInitialize();
		AutoBar.initialized = true;
	end

	if (not AutoBar.inWorld) then
		AutoBar.inWorld = true;
		if (not scanned) then
			AutoBar_ScanBags();
		end
		AutoBar:ButtonsUpdate();
	end
end


function AutoBar:PLAYER_LEAVING_WORLD()
	AutoBar.inWorld = false;
end


function AutoBar:BAG_UPDATE()
	if (AutoBar.inWorld and arg1 < 5) then
		AutoBar_ScanBags(arg1);
	end
end


function AutoBar:UPDATE_BINDINGS()
	AutoBar:ButtonsUpdate();
end


function AutoBar:ZONE_CHANGED_NEW_AREA()
	AutoBar:ButtonsUpdate();
end


function AutoBar:PLAYER_REGEN_ENABLED()
	AutoBar.inCombat = false;
	AutoBar:ButtonsUpdate();
end


function AutoBar:PLAYER_REGEN_DISABLED()
	AutoBar.inCombat = true;
	AutoBar:ButtonsUpdate();
end


function AutoBar:UNIT_MANA()
	if (arg1 == "player") then
		AutoBar:ButtonsUpdate();
	end
end


function AutoBar:UNIT_HEALTH()
	if (arg1 == "player") then
		AutoBar:ButtonsUpdate();
	end
end


function AutoBar:PLAYER_ALIVE()
	AutoBar:ButtonsUpdate();
end


function AutoBar:BAG_UPDATE_COOLDOWN()
	AutoBar:ButtonsUpdate();
end


function AutoBar:UPDATE_BATTLEFIELD_STATUS()
	if (AutoBar.inWorld) then
		for i = 1, MAX_BATTLEFIELD_QUEUES do
			local status, mapName, instanceID = GetBattlefieldStatus(i);
			if (instanceID ~= 0) then
				AutoBar.inBG = true;
				return;
			else
				AutoBar.inBG = false;
			end
		end
	end
end


-- When dragging, contains { frameName, index }, otherwise nil
AutoBar.dragging = nil;
local draggingData = {};

function AutoBar.GetDraggingIndex(frameName)
	if (AutoBar.dragging and AutoBar.dragging.frameName == frameName) then
		return AutoBar.dragging.index;
	end
	return nil;
end


function AutoBar.SetDraggingIndex(frameName, index)
	draggingData.frameName = frameName;
	draggingData.index = index;
	AutoBar.dragging = draggingData;
end


function AutoBar.LinkDecode(link)
	if (link) then
		local _, _, id, name = string.find(link,"|Hitem:(%d+):%d+:%d+:%d+|h%[([^]]+)%]|h|r$");
		if (id and name) then
			return name, tonumber(id);
		end
	end
end


local function AutoBar_BuildItemList()
	local function AddItemInfo(identifier, buttonnum)
		if (AutoBar_Category_Info[identifier] and AutoBar_Category_Info[identifier].items) then
			local index, j;
			for index, j in pairs(AutoBar_Category_Info[identifier].items) do
				if (AutoBar_SearchedForItems[j]) then
					table.insert(AutoBar_SearchedForItems[j], buttonnum);
				else
					AutoBar_SearchedForItems[j] = { buttonnum, identifier, index };
				end
				table.insert(AutoBar_ButtonItemList[buttonnum], j);
			end
		else
			if (AutoBar_SearchedForItems[identifier]) then
				table.insert(AutoBar_SearchedForItems[identifier], buttonnum);
			else
				AutoBar_SearchedForItems[identifier] = { buttonnum, identifier, 0 };
			end
			table.insert(AutoBar_ButtonItemList[buttonnum], identifier);
		end
	end
	AutoBar_SearchedForItems = {};
	AutoBar_ButtonItemList_Reversed = {};
	local index;
	for index = 1, AUTOBAR_MAXBUTTONS, 1 do
		if (AutoBar.buttons[index]) then
			local i, j;
			AutoBar_ButtonItemList[index] = {};
			AutoBar_ButtonItemList_Reversed[index] = {};
			if (type(AutoBar.buttons[index]) == "table") then
				for i, j in pairs(AutoBar.buttons[index]) do
					AddItemInfo (j, index);
				end
			else
				AddItemInfo (AutoBar.buttons[index], index);
			end
			for i, j in pairs(AutoBar_ButtonItemList[index]) do
				AutoBar_ButtonItemList_Reversed[index][j] = i;
			end
		end
	end
end


function AutoBar_Button_GetDisplayItem(buttonnum)
	local index, bag, slot, rank, itemId, category, categoryIndex, acceptable, cooldowntime, level;
	local cooldownIndex, start, duration, enable, fallback;
	if (AutoBar_Buttons_CurrentItems[buttonnum]) then
		index = table.getn(AutoBar_Buttons_CurrentItems[buttonnum]);
	else
		index = 0;
	end
	while (index > 0 and not acceptable) do
		bag = AutoBar_Buttons_CurrentItems[buttonnum][index].items[1][1];
		slot = AutoBar_Buttons_CurrentItems[buttonnum][index].items[1][2];
		rank = AutoBar_Buttons_CurrentItems[buttonnum][index].rank;
		itemId = AutoBar_ButtonItemList[buttonnum][rank];
		if (type(itemId) == "number") then
			_,_,_,level = GetItemInfo(itemId);
		else
			level = 0;
		end
		if (AutoBar_SearchedForItems[itemId]) then
			category = AutoBar_SearchedForItems[itemId][2];
			categoryIndex = AutoBar_SearchedForItems[itemId][3];
		else
			category = nil;
			categoryIndex = nil;
		end
		--
		start, duration, enable = GetContainerItemCooldown(bag, slot);
		if (start > 0 and duration > 0) then
			local tmp = start - GetTime() + duration;
			if (not cooldowntime or tmp < cooldowntime) then
				cooldowntime = tmp;
				cooldownIndex = index;
			end
			index = index - 1;
		elseif (level > UnitLevel("player")) then
			index = index - 1;
		elseif (AutoBar_Category_Info[category] and AutoBar_Category_Info[category].location and AutoBar_Category_Info[category].location ~= GetRealZoneText()) then
			index = index - 1;
		elseif (AutoBar_Category_Info[category] and AutoBar_Category_Info[category].battleground and not AutoBar.inBG) then
			index = index - 1;
		elseif (AutoBar_Category_Info[category]) then
			if (not fallback) then
				fallback = index;
			end
			if (AutoBar_Category_Info[category].combatonly and not AutoBar.inCombat) then
				index = index - 1;
			elseif (AutoBar_Category_Info[category].noncombat and AutoBar.inCombat) then
				index = index - 1;
			elseif (AutoBar_Category_Info[category].limit) then
				local losthp = UnitHealthMax("player") - UnitHealth("player");
				local lostmana = UnitManaMax("player") - UnitMana("player");
				if (UnitPowerType("player") ~= 0 ) then
					--if (UnitClass("player") == "Druid") then
						-- Can't check mana in druid forms
					--	lostmana = 0;
					--else
						-- Class doesn't have mana, don't limit
						lostmana = 10000;
					--end
				end
				if (AutoBar_Category_Info[category].limit.downhp and AutoBar_Category_Info[category].limit.downhp[categoryIndex] > losthp) then
					index = index - 1
				elseif (AutoBar_Category_Info[category].limit.downmana and AutoBar_Category_Info[category].limit.downmana[categoryIndex] > lostmana) then
					index = index - 1
				else
					acceptable = true;
				end
			else
				acceptable = true;
			end
		else
			acceptable = true;
		end
	end
	if (not acceptable) then
		if (fallback) then
			index = fallback;
		elseif (cooldownIndex) then
			index = cooldownIndex;
		elseif (AutoBar_Buttons_CurrentItems[buttonnum]) then
			index = table.getn(AutoBar_Buttons_CurrentItems[buttonnum]);
		else
			index = nil;
		end
	end
	--
	if (index) then
		bag = AutoBar_Buttons_CurrentItems[buttonnum][index].items[1][1];
		slot = AutoBar_Buttons_CurrentItems[buttonnum][index].items[1][2];
		rank = AutoBar_Buttons_CurrentItems[buttonnum][index].rank;
	else
		bag = nil; slot = nil; rank = nil;
	end
	if (AutoBar_ButtonItemList[buttonnum]) then
		itemId = AutoBar_ButtonItemList[buttonnum][rank];
		if (AutoBar_SearchedForItems[itemId]) then
			category = AutoBar_SearchedForItems[itemId][2];
			categoryIndex = AutoBar_SearchedForItems[itemId][3];
		else
			category = nil;
			categoryIndex = nil;
		end
	else
		itemId = nil; category = nil; categoryIndex = nil;
	end
	return bag, slot, rank, itemId, category, categoryIndex, index, acceptable, cooldowntime;
end


function AutoBar:ButtonsUpdate()
	if (not AutoBar.inWorld) then
		return
	end
	local buttonnum, i, button, icon, normalTexture, countText, bag, slot, index, items;
	local hotKey, count, itemCount, keyText, actioncommand, cooldown;
	for buttonnum = 1, AUTOBAR_MAXBUTTONS, 1 do
		button = getglobal("AutoBarFrameButton"..buttonnum);
		icon = getglobal("AutoBarFrameButton"..buttonnum.."Icon");
		normalTexture = getglobal("AutoBarFrameButton"..buttonnum.."NormalTexture");
		countText = getglobal("AutoBarFrameButton"..buttonnum.."Count");
		hotKey = getglobal("AutoBarFrameButton"..buttonnum.."HotKey");
		cooldown = getglobal("AutoBarFrameButton"..buttonnum.."Cooldown");
		if (not button.forceHidden and button.effectiveButton) then
			button:Show();
			bag, slot,_,_,_,_,index,enabled = AutoBar_Button_GetDisplayItem(button.effectiveButton)
			if (bag and slot) then
				local start, duration, enable = GetContainerItemCooldown(bag, slot);
				CooldownFrame_SetTimer(cooldown, start, duration, enable);
				items = AutoBar_Buttons_CurrentItems[button.effectiveButton][index].items
				count = 0;
				for i, bagSlot in pairs(items) do
					_, itemCount = GetContainerItemInfo(bagSlot[1], bagSlot[2]);
					if (itemCount) then
						count = count + itemCount;
					end
				end
				icon:SetTexture(GetContainerItemInfo(bag, slot));
				if (AutoBar.display.plainButtons) then
					icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
				else
					icon:SetTexCoord(0, 1, 0, 1)
				end
				if (count > 1) then
					countText:SetText(count);
				else
					countText:SetText("");
				end

				if (enabled) then
					icon:SetVertexColor(1, 1, 1);
					normalTexture:SetVertexColor(1, 1, 1);
				elseif (start > 0 and duration > 0) then
					icon:SetVertexColor(1, 1, 1);
					normalTexture:SetVertexColor(1, 1, 1);
				else
					icon:SetVertexColor(0.4, 0.4, 0.4);
					normalTexture:SetVertexColor(1, 1, 1);
				end

				actioncommand = "AUTOBAR_BUTTON"..button.effectiveButton;
				if (actioncommand) then
					keyText = GetBindingKey(actioncommand);
					if (keyText) then
						keyText = string.gsub(keyText, "CTRL", "C");
						keyText = string.gsub(keyText, "ALT", "A");
						keyText = string.gsub(keyText, "SHIFT", "S");
						keyText = string.gsub(keyText, "NUMPAD", "N");
						hotKey:SetText(keyText);
					else
						hotKey:SetText("");
					end
				end
			else
				CooldownFrame_SetTimer(cooldown, 0, 0, 0);
				if (AutoBar.display.showCategoryIcon and AutoBar.buttons[button.effectiveButton]) then
				    -- Button is empty so show Category Icon
					local buttonInfo = AutoBar.buttons[button.effectiveButton];
					icon:SetTexture(AutoBar_GetTexture(buttonInfo));
					countText:SetText("--");
					hotKey:SetText("");
					icon:SetVertexColor(0.2, 0.2, 0.2);
					normalTexture:SetVertexColor(1, 1, 1);
				else
				    -- Button is empty
					icon:SetTexture("");
					countText:SetText("");
					hotKey:SetText("");
				end
			end
		else
			button:Hide();
		end
	end
end


-- Assign display buttons to active slots and return the number of displayed buttons
function AutoBar:AssignButtons()
	local displayButton = 0;
	local buttonIndex, buttonInfo, rankIndex, items;
	for buttonIndex = 1, AUTOBAR_MAXBUTTONS, 1 do
		if (AutoBar.display.showEmptyButtons or AutoBar_Buttons_CurrentItems[buttonIndex]) then
			displayButton = displayButton + 1;
			local button = getglobal("AutoBarFrameButton"..displayButton);
			button.effectiveButton = buttonIndex;
		elseif (AutoBar.display.showCategoryIcon and AutoBar.buttons[buttonIndex]) then
			displayButton = displayButton + 1;
			local button = getglobal("AutoBarFrameButton"..displayButton);
			button.effectiveButton = buttonIndex;
		end
	end
	for buttonIndex = displayButton+1, AUTOBAR_MAXBUTTONS, 1 do
		local button = getglobal("AutoBarFrameButton"..buttonIndex);
		button.effectiveButton = nil;
	end
	return displayButton;
end


local function AutoBar_UpdateCategoryNameToID(name,id)
	local buttonnum, index;
	for buttonnum = 1, AUTOBAR_MAXBUTTONS, 1 do
		if (AutoBar.buttons[buttonnum]) then
			if (type(AutoBar.buttons[buttonnum]) == "table") then
				for index in pairs(AutoBar.buttons[buttonnum]) do
					if (AutoBar.buttons[buttonnum][index] == name) then
						AutoBar.buttons[buttonnum][index] = id;
						AutoBar_Msg(string.format(AUTOBAR_CHAT_MESSAGE2,buttonnum,idx));
					end
				end
			elseif (AutoBar.buttons[buttonnum] == name) then
				AutoBar.buttons[buttonnum] = id;
				AutoBar_Msg(string.format(AUTOBAR_CHAT_MESSAGE3,buttonnum));
			end
		end
	end
end


function AutoBar_ScanBags(specificbag)
	local function ClearOutBag(bag)
		local buttonnum, index, i, bagSlot, newitemlist, newranks;
		for buttonnum = 1, AUTOBAR_MAXBUTTONS, 1 do
			if (AutoBar_Buttons_CurrentItems[buttonnum]) then
				newranks = {};
				for index in pairs(AutoBar_Buttons_CurrentItems[buttonnum]) do
					newitemlist = {};
					for i, bagSlot in pairs(AutoBar_Buttons_CurrentItems[buttonnum][index].items) do
						if (bag ~= bagSlot[1]) then
							table.insert(newitemlist,bagSlot);
						end
					end
					if (table.getn(newitemlist) > 0) then
						AutoBar_Buttons_CurrentItems[buttonnum][index].items = newitemlist;
						table.insert(newranks,AutoBar_Buttons_CurrentItems[buttonnum][index]);
					end
				end
				if (table.getn(newranks) == 0) then
					AutoBar_Buttons_CurrentItems[buttonnum] = nil;
				else
					AutoBar_Buttons_CurrentItems[buttonnum] = newranks;
				end
			end
		end
	end
	local function AddItem(buttonnum, rank, bag, slot)
		if (AutoBar_Buttons_CurrentItems[buttonnum]) then
			local index, rec, findRank;
			for index, rec in pairs(AutoBar_Buttons_CurrentItems[buttonnum]) do
				if (rec.rank == rank) then
					findRank = index;
				end
			end
			if (findRank) then
				table.insert(AutoBar_Buttons_CurrentItems[buttonnum][findRank].items, { bag, slot } );
			else
				table.insert(AutoBar_Buttons_CurrentItems[buttonnum],
					{
				 		["rank"] = rank,
				 		["items"] = { { bag, slot } }
					}
				);
			end
		else
			AutoBar_Buttons_CurrentItems[buttonnum] = {
				[1] = {
					["rank"] = rank,
					["items"] = { { bag, slot } }
				},
			};
		end
	end
	local function SortByRank(a,b)
		if (a and b and a.rank and b.rank) then
			return a.rank < b.rank;
		else
			return true;
		end
	end

	local bag, slot, name, id, i;
	local minbag,maxbag = 0, 4;
	if (specificbag) then
		minbag = specificbag;
		maxbag = specificbag;
		ClearOutBag(specificbag);
	else
		AutoBar_Buttons_CurrentItems = {};
	end
	-- AutoBar_Buttons_CurrentItems = {
	--	buttonnum = {
	--		index = {
	--			"rank" = ranknum,
	--			"items" = { {bag,slot}, {bag,slot}, {bag, slot} }
	--		},
	--	},
	--};
	for bag = minbag, maxbag, 1 do
		for slot = 1, GetContainerNumSlots(bag), 1 do
			name, id = AutoBar.LinkDecode(GetContainerItemLink(bag,slot));
			if (name and AutoBar_SearchedForItems[name] and id) then
				if (not AutoBar_SearchedForItems[id]) then
					AutoBar_SearchedForItems[id] = { AutoBar_SearchedForItems[name][1], AutoBar_SearchedForItems[name][2], AutoBar_SearchedForItems[name][3] };
				end
				AutoBar_UpdateCategoryNameToID(name,id);
				AutoBar_SearchedForItems[name] = nil;
			end
			if (id and AutoBar_SearchedForItems[id]) then
				local button = AutoBar_SearchedForItems[id][1];
				local rank = AutoBar_ButtonItemList_Reversed[button][id];
				AddItem(button, rank, bag, slot)
				if (AutoBar_SearchedForItems[id][4]) then
					for i = 4, table.getn(AutoBar_SearchedForItems[id]), 1 do
						button = AutoBar_SearchedForItems[id][i];
						rank = AutoBar_ButtonItemList_Reversed[button][id];
						AddItem(button, rank, bag, slot)
					end
				end
			end
		end
	end
	local buttonnum;
	for buttonnum = 1, AUTOBAR_MAXBUTTONS, 1 do
	 	if (AutoBar_Buttons_CurrentItems[buttonnum]) then
			table.sort(AutoBar_Buttons_CurrentItems[buttonnum], SortByRank);
	 	end
	end
	AutoBar:AssignButtons();
	AutoBar:ButtonsUpdate();
end


function AutoBar_OnEvent(event)
	if (event == "PLAYER_ENTERING_WORLD") then
	elseif (event == "PLAYER_LEAVING_WORLD") then
		AutoBar.inWorld = nil;
	elseif (AutoBar.inWorld) then
		if (event == "BAG_UPDATE") then
			if (arg1 < 5) then
				AutoBar_ScanBags(arg1);
			end
		elseif (event == "UPDATE_BINDINGS") then
			AutoBar:ButtonsUpdate();
		elseif (event == "PLAYER_ALIVE") then
			AutoBar:ButtonsUpdate();
		elseif ((event == "UNIT_MANA" or event == "UNIT_HEALTH") and arg1=="player") then
			AutoBar:ButtonsUpdate();
		elseif (event == "PLAYER_REGEN_ENABLED") then
			AutoBar.inCombat = false;
			AutoBar:ButtonsUpdate();
		elseif (event == "PLAYER_REGEN_DISABLED") then
			AutoBar.inCombat = true;
			AutoBar:ButtonsUpdate();
		elseif (event == "ZONE_CHANGED_NEW_AREA") then
			AutoBar:ButtonsUpdate();
		elseif (event == "BAG_UPDATE_COOLDOWN") then
			AutoBar:ButtonsUpdate();
		elseif (event == "UPDATE_BATTLEFIELD_STATUS") then
			for i = 1, MAX_BATTLEFIELD_QUEUES do
				local status, mapName, instanceID = GetBattlefieldStatus(i);
				if (instanceID ~= 0) then
					AutoBar.inBG = true;
					return;
				else
					AutoBar.inBG = false;
				end
			end
		end
	end
end


function AutoBar:SlotUse(slotIndex)
	AutoBar_Button_OnClick("LeftButton", "CLICK", slotIndex);
end


function AutoBar_Button_OnClick(mousebutton, updown, override)
	local button, effectiveButton;
	if (override) then
		button = getglobal("AutoBarFrameButton"..override);
		effectiveButton = override;
	else
		button = this;
		effectiveButton = button.effectiveButton;
	end
	button:SetChecked(0);
	if (AutoBarFrame.moving) then
		if (updown == "CLICK") then
			AutoBarFrame.moving = nil;
			AutoBarFrame:StopMovingOrSizing();
			AutoBar.display.position = {};
			AutoBar.display.position.x,
			AutoBar.display.position.y = AutoBarFrame:GetCenter();
		end
	elseif (updown == "CLICK") then
		local bag, slot, rank, itemId, category, categoryIndex, index, acceptable = AutoBar_Button_GetDisplayItem(effectiveButton);
		if (bag and slot) then
			local buttonInfo = AutoBar.buttons[effectiveButton];

			if (mousebutton == "RightButton" and type(buttonInfo) == "table" and buttonInfo.rightClickTargetsPet and UnitExists("pet")) then
				PickupContainerItem(bag, slot);
				DropItemOnUnit("pet");
			else
				UseContainerItem(bag, slot);
			end

			if (AutoBar_Category_Info[category] and AutoBar_Category_Info[category].targetted == "WEAPON" and SpellIsTargeting()) then
				if (mousebutton == "LeftButton") then
					PickupInventoryItem(GetInventorySlotInfo("MainHandSlot"));
				elseif (mousebutton == "RightButton") then
					PickupInventoryItem(GetInventorySlotInfo("SecondaryHandSlot"));
				end
			elseif (AutoBar_Category_Info[category] and AutoBar_Category_Info[category].targetted and (AutoBar.display.autoSmartSelfCast or AutoBar.smartSelfcast and AutoBar.smartSelfcast[category]) and SpellIsTargeting()) then
				SpellTargetUnit("player");
			elseif (type(AutoBar.buttons[effectiveButton]) == "table" and AutoBar.buttons[effectiveButton].rightClickTargetsPet and SpellIsTargeting()) then
				SpellTargetUnit("pet");
			end
			AutoBarPopupFrame:Hide();
			if (not override) then
				AutoBar:SetPopupButton(button);
			end
		end
	elseif (mousebutton == "RightButton" and updown == "DOWN" and IsControlKeyDown()) then
		if (not AutoBar.display.docking) then
			AutoBarFrame.moving = true;
			AutoBarFrame:StartMoving();
		end
	end
end


-- Add tooltip info about the other categories in a slot to the current GameTooltip
function AutoBar_ButtonSetTooltipCategories(currentItems, categoryIndex)
	local count = 0;
	local itemCount;
	for index, bagSlot in pairs(currentItems.items) do
		_, itemCount = GetContainerItemInfo(bagSlot[1], bagSlot[2]);
		if (not itemCount) then
		    itemCount = 0;
		end
		count = count + itemCount;
	end
	local name, itemId = AutoBar.LinkDecode(GetContainerItemLink(currentItems.items[1][1], currentItems.items[1][2]));
	local category = AutoBar_SearchedForItems[itemId][2];
	local start, duration, enable = GetContainerItemCooldown(currentItems.items[1][1], currentItems.items[1][2]);
	local msg = name..AUTOBAR_TOOLTIP1..count..")";
	if (AutoBar_Debug) then
		msg = msg.." ["..currentItems.items[1][1]..","..currentItems.items[1][2].."]";
		if (rank) then
			msg = msg.." rank="..currentItems.rank;
		end
		if (cat) then
			msg = msg.." cat="..category;
		end
	end
	if (category == itemId and categoryIndex == 0) then
		msg = msg..AUTOBAR_TOOLTIP2
	end
	if (AutoBar_Category_Info[category]) then
		if (AutoBar_Category_Info[category].combatonly) then
			msg=msg..AUTOBAR_TOOLTIP3;
		end
		if (AutoBar_Category_Info[category].battleground) then
			msg=msg..AUTOBAR_TOOLTIP4;
		end
		if (AutoBar_Category_Info[category].noncombat) then
			msg=msg..AUTOBAR_TOOLTIP5;
		end
		if (AutoBar_Category_Info[category].limit) then
			msg=msg..AUTOBAR_TOOLTIP6;
		end
	end
	if (start > 0 and duration > 0) then
		msg = msg..AUTOBAR_TOOLTIP7;
	end
	GameTooltip:AddLine(msg);
	if (category and AutoBar_Category_Info[category] and AutoBar_Category_Info[category].targetted == "WEAPON") then
		GameTooltip:AddLine(AUTOBAR_TOOLTIP8);
	end
end


-- Set the tooltip for an AutoBarFrame or AutoBarPopupFrame button
function AutoBar.ButtonSetTooltip(button, elapsed)
	if (AutoBar.display.hideTooltips) then
		return;
	end
	if (not button) then
		button = this;
	end
	if (button:GetParent().updateTooltip and elapsed) then
		button.updateTooltip = button.updateTooltip - elapsed;
		if (button.updateTooltip > 0) then return; end
	end

	-- AutoBarFrame Button has effectiveButton, AutoBarPopupFrame Button has bagSlot
	local effectiveButton;
	if (button.effectiveButton or button.bagSlot) then
		if (GetCVar("UberTooltips") == "1") then
			GameTooltip_SetDefaultAnchor(GameTooltip, button);
		else
			GameTooltip:SetOwner(button, "ANCHOR_RIGHT");
		end
		button.updateTooltip = nil;

		local bag, slot, rank, itemId, category, categoryIndex;
		if (button.bagSlot) then
		    bag = button.bagSlot[1];
		    slot = button.bagSlot[2];
		    category = button.category;
		    effectiveButton = button:GetParent().popupButton;
		elseif (button.effectiveButton) then
		    effectiveButton = button.effectiveButton;
			bag, slot, rank, itemId, category, categoryIndex = AutoBar_Button_GetDisplayItem(button.effectiveButton)
		else
		    return;
		end
		if (bag and slot) then
			GameTooltip:SetBagItem(bag, slot);
			if (AutoBar_Debug) then
				if (rank) then
					GameTooltip:AddLine("DISPLAYED RANK: "..rank);
				end
				if (itemId) then
					GameTooltip:AddLine("DISPLAYED ITEMID: "..itemId);
				end
				if (category) then
					GameTooltip:AddLine("DISPLAYED CATEGORY: "..category);
				end
				if (categoryIndex) then
					GameTooltip:AddLine("DISPLAYED CATEGORY INDEX: "..categoryIndex);
				end
			end

			local start, duration, enable = GetContainerItemCooldown(bag, slot);
			if (start > 0 and duration > 0) then
				button.updateTooltip = TOOLTIP_UPDATE_TIME;
			end

			GameTooltip:AddLine("");
			local rankIndex, index, currentItems, bagSlot, count, itemCount, name, itemId, msg;
			for rankIndex, currentItems in pairs(AutoBar_Buttons_CurrentItems[effectiveButton]) do
			    -- Display all possible items for AutoBarFrame or just the specific item for AutoBarPopupFrame
			    if (button.effectiveButton or button.popupButtonIndex == rankIndex) then
					AutoBar_ButtonSetTooltipCategories(currentItems, categoryIndex);
				end
			end
			GameTooltip:Show();
		end
	else
--DEFAULT_CHAT_FRAME:AddMessage("AutoBar.ButtonSetTooltip unhandled button ", 1, 0.5, 0);
	end
end


local function maxn(t)
	local n = 0;
	for i, v in pairs(t) do
		if (type(i) == "number" and i > n) then
			n = i;
		end
	end
	return n;
end


-- Return the display texture of the object
function AutoBar_GetTexture(id)
	if (not id) then
		return "";
	end

	-- Last item has priority so use its icon
	if (type(id) == "table" and id[1]) then
		local x = getn(id);
		if (x < 1) then
			x = maxn(id);
		end
	    id = id[x];
	end

	if (id and AutoBar_Category_Info[id]) then
		if (AutoBar_Category_Info[id].texture) then
			return "Interface\\Icons\\"..AutoBar_Category_Info[id].texture;
		else
			id = AutoBar_Category_Info[id].items[table.getn(AutoBar_Category_Info[id].items)];
		end
	end
	if (type(id)=="number" and id > 0) then
		local _,_,_,_,_,_,_,_,texture = GetItemInfo(tonumber(id));
		if (texture) then return texture; end
	end
	return "Interface\\Icons\\INV_Misc_Gift_01";
end


function AutoBar_Msg(...)
	local message = "";
	for i = 1, arg.n, 1 do
		if (type(arg[i]) == "string" or type(arg[i]) == "number") then
			message = message..arg[i];
		else
			message = message..string.upper(type(arg[i]));
		end
	end
	ChatFrame1:AddMessage(L["AUTOBAR"] .. ": " .. message);
end


function AutoBar.ConfigChanged()
	AutoBar_BuildItemList();
	AutoBar_ScanBags();
	AutoBar_SetupVisual();
end


--AutoBar.UpdateTalentButton = UpdateTalentButton;

-- Arrange the buttons using the various settings and alignment options
function AutoBar_SetupVisual()
	if (not AutoBar.display.rows) then
		AutoBar.display.rows = AutoBarConfig:SliderGetValue("rows");
	end
	if (not AutoBar.display.columns) then
		AutoBar.display.columns = AutoBarConfig:SliderGetValue("columns");
	end
	if (not AutoBar.display.gapping) then
		AutoBar.display.gapping = AutoBarConfig:SliderGetValue("gapping");
	end
	if (not AutoBar.display.alpha) then
		AutoBar.display.alpha = AutoBarConfig:SliderGetValue("alpha");
	end
	if (not AutoBar.display.buttonWidth) then
		AutoBar.display.buttonWidth = AutoBarConfig:SliderGetValue("buttonWidth");
	end
	if (not AutoBar.display.buttonHeight) then
		AutoBar.display.buttonHeight = AutoBarConfig:SliderGetValue("buttonHeight");
	end
	if (not AutoBar.display.dockShiftX) then
		AutoBar.display.dockShiftX = AutoBarConfig:SliderGetValue("dockShiftX");
	end
	if (not AutoBar.display.dockShiftY) then
		AutoBar.display.dockShiftY = AutoBarConfig:SliderGetValue("dockShiftY");
	end
	if (not (AutoBar.display.popupToTop or AutoBar.display.popupToLeft or AutoBar.display.popupToRight or AutoBar.display.popupToBottom)) then
		AutoBar.display.popupToTop = true;
	end

	local rows = AutoBar.display.rows;
	local columns = AutoBar.display.columns;
	local gapping = AutoBar.display.gapping;
	local centerShiftX = 0;
	local centerShiftY = 0;
	local buttonWidth = AutoBar.display.buttonWidth;
	local buttonHeight = AutoBar.display.buttonHeight;
	local point = "BOTTOMLEFT";
	local x = buttonWidth + gapping;
	local y = buttonHeight + gapping;

	local displayButtons = math.min(AutoBar:AssignButtons(), rows * columns);
	local displayedColumns = math.min(displayButtons, columns);
	local displayedRows = math.floor((displayButtons - 1) / columns) + 1;

	if (AutoBar.display.alignButtons == 1) then
		point = "BOTTOMLEFT";
	elseif (AutoBar.display.alignButtons == 2) then
		centerShiftX = -0.5 * displayedColumns * (buttonWidth + gapping) + gapping / 2;
		point = "BOTTOMLEFT";
	elseif (AutoBar.display.alignButtons == 3) then
		x = x * -1;
		point = "BOTTOMRIGHT";
	elseif (AutoBar.display.alignButtons == 4) then
		x = x * -1;
		point = "BOTTOMRIGHT";
		centerShiftY = -0.5 * displayedRows * (buttonHeight + gapping) + gapping / 2;
	elseif (AutoBar.display.alignButtons == 5) then
		point = "BOTTOMLEFT";
		centerShiftX = -0.5 * displayedColumns * (buttonWidth + gapping) + gapping / 2;
		centerShiftY = -0.5 * displayedRows * (buttonHeight + gapping) + gapping / 2;
	elseif (AutoBar.display.alignButtons == 6) then
		point = "BOTTOMLEFT";
		centerShiftY = -0.5 * displayedRows * (buttonHeight + gapping) + gapping / 2;
	elseif (AutoBar.display.alignButtons == 7) then
		x = x * -1;
		y = y * -1;
		point = "TOPRIGHT";
	elseif (AutoBar.display.alignButtons == 8) then
		y = y * -1;
		point = "TOPLEFT";
		centerShiftX = -0.5 * displayedColumns * (buttonWidth + gapping) + gapping / 2;
	elseif (AutoBar.display.alignButtons == 9) then
		y = y * -1;
		point = "TOPLEFT";
	end

	AutoBarFrame:Show();
	AutoBarFrame:ClearAllPoints();
	AutoBarAnchorFrame:Show();

	local i;
	local anchor = getglobal("AutoBarAnchorFrameHandle");
	for i = 1, AUTOBAR_MAXBUTTONS, 1 do
		local button = getglobal("AutoBarFrameButton"..i);
		if (i > (rows * columns)) then
			button:Hide();
			button.forceHidden = true;
		else
			AutoBar:ButtonSetup("AutoBarFrameButton"..i);

			-- Set the relative positions of the buttons
			button:ClearAllPoints();
			button:SetPoint(point, anchor, "CENTER", (math.mod(i - 1, columns) * x + centerShiftX), math.floor((i - 1) / columns) * y + centerShiftY);
		end
	end

	AutoBar:ButtonsUpdate();
	if (AutoBar.display.hideDragHandle) then
	    AutoBar:HideHandle(AutoBarFrame);
	else
	    AutoBar:ShowHandle(AutoBarFrame);
	end
	getglobal("AutoBarAnchorFrameHandle"):SetChecked(AutoBar.display.frameLocked);

	-- Handle docking
	local dockShiftX = AutoBar.display.dockShiftX;
	local dockShiftY = AutoBar.display.dockShiftY;

	if (AutoBar.display.docking == "CharacterMicroButton") then
		AutoBarFrame:SetFrameStrata("HIGH");
		AutoBarAnchorFrameHandle:SetFrameStrata("DIALOG");
--		AutoBar.UpdateTalentButton = UpdateTalentButton;
--		UpdateTalentButton = function() return; end
--		CharacterMicroButton:Hide();
--		SpellbookMicroButton:Hide();
--		TalentMicroButton:Hide();
--		QuestLogMicroButton:Hide();
--		SocialsMicroButton:Hide();
--		WorldMapMicroButton:Hide();
--		MainMenuMicroButton:Hide();
--		HelpMicroButton:Hide();
	else
		AutoBarFrame:SetFrameStrata("LOW");
		AutoBarAnchorFrameHandle:SetFrameStrata("MEDIUM");
--		UpdateTalentButton = AutoBar.UpdateTalentButton;
--		CharacterMicroButton:Show();
--		SpellbookMicroButton:Show();
--		TalentMicroButton:Show();
--		QuestLogMicroButton:Show();
--		SocialsMicroButton:Show();
--		WorldMapMicroButton:Show();
--		MainMenuMicroButton:Show();
--		HelpMicroButton:Show();
	end

	-- Set frame to the size of one button so docking will offset by at least one button
	local frameWidth = displayedColumns * (buttonWidth + gapping) + 1;
	local frameHeight = displayedRows * (buttonHeight + gapping) + 1;
	AutoBarFrame:SetWidth(frameWidth);
	AutoBarFrame:SetHeight(frameHeight);

	AutoBarAnchorFrameHandle:ClearAllPoints();
	if (AutoBar.display.docking and getglobal(AutoBar.display.docking)) then
		local offset = AutoBarConfig.dockingFrames[AutoBar.display.docking].offset;
		AutoBarAnchorFrameHandle:SetPoint(offset.point, AutoBar.display.docking, offset.relative, dockShiftX + offset.x, dockShiftY + offset.y);
	elseif (AutoBar.display.position) then
		AutoBarAnchorFrameHandle:SetPoint("CENTER", "UIParent", "BOTTOMLEFT",
		AutoBar.display.position.x,
		AutoBar.display.position.y);
	else
		AutoBarAnchorFrameHandle:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
	end
	if (AutoBar.display.hideDragHandle) then
		AutoBarAnchorFrameHandle:Hide();
	else
		AutoBarAnchorFrameHandle:Show();
	end
end


-- Set the visual look and feel for the button
function AutoBar:ButtonSetup(buttonName)
	local button = getglobal(buttonName);
	local buttonWidth = AutoBar.display.buttonWidth;
	local buttonHeight = AutoBar.display.buttonHeight;
	local fontScale = buttonWidth / 36;
	local alpha = AutoBar.display.alpha / 10;

	local normalTexture = getglobal(buttonName.."NormalTexture");
	local countText = getglobal(buttonName.."Count");
	local hotKey = getglobal(buttonName.."HotKey");
	local cooldown = getglobal(buttonName.."Cooldown");
	local icon = getglobal(buttonName.."Icon");

	button.forceHidden = false;
	button:SetAlpha(alpha);
	normalTexture:SetAlpha(alpha);
	button:SetWidth(buttonWidth);
	button:SetHeight(buttonHeight);

	if (AutoBar.display.plainButtons) then
		button:SetNormalTexture("");
		icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
	else
		button:SetNormalTexture("Interface\\Buttons\\UI-Quickslot2");
		icon:SetTexCoord(0,1,0,1)
		normalTexture:SetWidth(buttonWidth * 1.833);  -- Mmm what is this magical scaling factor?
		normalTexture:SetHeight(buttonHeight * 1.833);
	end

	local fonttext, fontsize, fontoptions;
	if (AutoBar.display.hideKeyText) then
		hotKey:Hide();
	else
		fonttext, fontsize, fontoptions = hotKey:GetFont();
		hotKey:SetFont(fonttext, 12 * fontScale, fontoptions);
		hotKey:SetJustifyH("LEFT");
		hotKey:SetJustifyV("TOP");
		hotKey:SetPoint("TOPLEFT", buttonName, "TOPLEFT", 2, -2);
		hotKey:Show();
	end
	if (AutoBar.display.hideCount) then
		countText:Hide();
	else
		countText:Show();
		fonttext, fontsize, fontoptions = countText:GetFont();
		countText:SetFont(fonttext, 14 * fontScale, fontoptions);
	end

	cooldown:SetScale(math.max(buttonWidth-1, buttonHeight-1) / 36);
end


--
-- Popup Buttons
--

-- If eligible set the slot for which to do the popup for.  Only pop up for 2 or more items.
function AutoBar:SetPopupButton(button)
	if (not button) then
		button = this;
	end

	if (AutoBar.display.popupDisable) then
		return;
	end

	if (button.effectiveButton) then
		local buttonInfo = AutoBar.buttons[button.effectiveButton];
		if (type(buttonInfo) ~= "table") then
			AutoBarPopupFrame:Hide();
			return;
		end
		if (buttonInfo.noPopup) then
			return;
		elseif (AutoBar.display.popupOnShift) then
			-- Timer callback to detect shift key over bar
			local function PopupShiftkey()
				if (AutoBar.display.popupOnShift) then
					if (IsShiftKeyDown()) then
						if (GetMouseFocus() and GetMouseFocus():GetParent() == AutoBarFrame) then
							AutoBar:SetPopupButton(GetMouseFocus());
						elseif (GetMouseFocus() and GetMouseFocus():GetParent() == AutoBarPopupFrame) then
							return;
						else
							AutoBarPopupFrame:Hide();
							self:CancelScheduledEvent("PopupShiftkey");
							return;
						end
					else
						AutoBarPopupFrame:Hide();
						if (GetMouseFocus() and GetMouseFocus():GetParent() ~= AutoBarFrame and GetMouseFocus():GetParent() ~= AutoBarPopupFrame) then
							self:CancelScheduledEvent("PopupShiftkey");
						end
					end
				else
					AutoBarPopupFrame:Hide();
					self:CancelScheduledEvent("PopupShiftkey");
				end
			end

			self:ScheduleRepeatingEvent("PopupShiftkey", PopupShiftkey, 0.2);
			if (not IsShiftKeyDown()) then
				return;
			end
		end
		if (not AutoBar_Buttons_CurrentItems[button.effectiveButton] or type(AutoBar_Buttons_CurrentItems[button.effectiveButton]) ~= "table" or table.getn(AutoBar_Buttons_CurrentItems[button.effectiveButton]) <= 1) then
			AutoBarPopupFrame:Hide();
			return;
		end

		AutoBarPopupFrame.popupButton = button.effectiveButton;
		AutoBar:UpdatePopupButtons(button);
		AutoBarPopupFrame:Show();
		AutoBarPopupFrame:EnableMouse(true);
	end
end


-- Populate the popup list for the popupButton and display relative to baseButton
function AutoBar:UpdatePopupButtons(baseButton)
	local popupButtonIndex, button, hotKey, icon, countText, normalTexture, cooldown;
	local autoBarPopup = getglobal("AutoBarPopupFrame");
	local gapping = AutoBar.display.gapping;
	local buttonWidth = AutoBar.display.buttonWidth;
	local buttonHeight = AutoBar.display.buttonHeight;
	local hitRectOutside = -1 * math.ceil(math.max(buttonWidth, buttonHeight, 40, gapping) / 2);
	local hitRectInside = -1 * math.ceil(gapping / 2);

	for popupButtonIndex = 1, AUTOBAR_MAXPOPUPBUTTONS, 1 do
		button = getglobal("AutoBarPopupFrame_Button"..popupButtonIndex);
		button:Hide();
	end

	local currentItems, index, bagSlot, count, itemCount, name, itemId;
	local start, duration, enable;
	local _, _, _, baseItemId, _, _ = AutoBar_Button_GetDisplayItem(AutoBarPopupFrame.popupButton);
	local effectiveLocation = 1;

	for popupButtonIndex, currentItems in pairs(AutoBar_Buttons_CurrentItems[AutoBarPopupFrame.popupButton]) do
		if (popupButtonIndex > AUTOBAR_MAXPOPUPBUTTONS) then
			break;
		end
		name, itemId = AutoBar.LinkDecode(GetContainerItemLink(currentItems.items[1][1], currentItems.items[1][2]));
		category = AutoBar_SearchedForItems[itemId][2];
		button = getglobal("AutoBarPopupFrame_Button"..popupButtonIndex);
		hotKey = getglobal("AutoBarPopupFrame_Button"..popupButtonIndex.."HotKey");
		icon = getglobal("AutoBarPopupFrame_Button"..popupButtonIndex.."Icon");
		countText = getglobal("AutoBarPopupFrame_Button"..popupButtonIndex.."Count");
		normalTexture = getglobal("AutoBarPopupFrame_Button"..popupButtonIndex.."NormalTexture");
		cooldown = getglobal("AutoBarPopupFrame_Button"..popupButtonIndex.."Cooldown");
		button.popupButtonIndex = popupButtonIndex;

		count = 0;
		for index, bagSlot in pairs(currentItems.items) do
			_, itemCount = GetContainerItemInfo(bagSlot[1], bagSlot[2]);
			count = count + itemCount;
		end

		button:Show();
		button:SetWidth(buttonWidth);
		button:SetHeight(buttonHeight);
		hotKey:SetText("");

		if (count > 0) then
			icon:SetTexture(GetContainerItemInfo(currentItems.items[1][1], currentItems.items[1][2]));
			countText:SetText(count);
			button.bagSlot = currentItems.items[1];
			button.category = category;
		else
			if (category and AutoBar_Category_Info[category] and AutoBar_Category_Info[category].texture) then
				icon:SetTexture(AutoBar_Category_Info[category].texture);
			else
				icon:SetTexture("");
			end
			countText:SetText("--");
			button.bagSlot = nil;
			button.category = nil;
		end

		start, duration, enable = GetContainerItemCooldown(currentItems.items[1][1], currentItems.items[1][2]);
		CooldownFrame_SetTimer(cooldown, start, duration, enable);
		if (enable and count > 0) then
			icon:SetVertexColor(1, 1, 1);
			normalTexture:SetVertexColor(1, 1, 1);
		elseif (start > 0 and duration > 0) then
			icon:SetVertexColor(1, 1, 1);
			normalTexture:SetVertexColor(1, 1, 1);
		else
			icon:SetVertexColor(0.4, 0.4, 0.4);
			normalTexture:SetVertexColor(1, 1, 1);
		end

	    AutoBar:ButtonSetup("AutoBarPopupFrame_Button"..popupButtonIndex);

		-- Set the relative positions of the buttons
	    button:ClearAllPoints();
		-- For the popup expand the mouse hit area of the buttons so selection is easier
		if (effectiveLocation == 1) then
			if (AutoBar.display.popupToBottom) then
				button:SetHitRectInsets(hitRectOutside, hitRectOutside, -1 * gapping, hitRectInside);
				button:SetPoint("TOP", baseButton, "BOTTOM", 0, -1 * gapping);
			elseif (AutoBar.display.popupToLeft) then
				button:SetHitRectInsets(hitRectInside, -1 * gapping, hitRectOutside, hitRectOutside);
				button:SetPoint("RIGHT", baseButton, "LEFT", -1 * gapping, 0);
			elseif (AutoBar.display.popupToRight) then
				button:SetHitRectInsets(-1 * gapping, hitRectInside, hitRectOutside, hitRectOutside);
				button:SetPoint("LEFT", baseButton, "RIGHT", gapping, 0);
			else
				button:SetHitRectInsets(hitRectOutside, hitRectOutside, hitRectInside, -1 * gapping);
				button:SetPoint("BOTTOM", baseButton, "TOP", 0, gapping);
			end
		else
			if (AutoBar.display.popupToBottom) then
				button:SetHitRectInsets(hitRectOutside, hitRectOutside, hitRectInside, hitRectInside);
				button:SetPoint("TOP", "AutoBarPopupFrame_Button"..(effectiveLocation-1), "BOTTOM", 0, -1 * gapping);
			elseif (AutoBar.display.popupToLeft) then
				button:SetHitRectInsets(hitRectInside, hitRectInside, hitRectOutside, hitRectOutside);
				button:SetPoint("RIGHT", "AutoBarPopupFrame_Button"..(effectiveLocation-1), "LEFT", -1 * gapping, 0);
			elseif (AutoBar.display.popupToRight) then
				button:SetHitRectInsets(hitRectInside, hitRectInside, hitRectOutside, hitRectOutside);
				button:SetPoint("LEFT", "AutoBarPopupFrame_Button"..(effectiveLocation-1), "RIGHT", gapping, 0);
			else
				button:SetHitRectInsets(hitRectOutside, hitRectOutside, hitRectInside, hitRectInside);
				button:SetPoint("BOTTOM", "AutoBarPopupFrame_Button"..(effectiveLocation-1), "TOP", 0, gapping);
			end
		end
	    if (baseItemId == itemId) then
--DEFAULT_CHAT_FRAME:AddMessage("AutoBar:UpdatePopupButtons baseItemId == itemId " .. baseItemId .. " " .. itemId, 1, 0.5, 0);
			button:Hide();
		else
		    effectiveLocation = effectiveLocation + 1;
	    end
	end

	AutoBarPopupFrame:Show();

	-- Detect mouse focus leaving
	local function PopupMouseover()
	   	local gapping = AutoBar.display.gapping;

	    if (GetMouseFocus() and GetMouseFocus():GetParent() ~= AutoBarFrame and GetMouseFocus():GetParent() ~= AutoBarPopupFrame) then
			self:CancelScheduledEvent("PopupMouseover");
			AutoBarPopupFrame:Hide();
		end
	end

	self:ScheduleRepeatingEvent("PopupMouseover", PopupMouseover, 1);
end


-- Handle a click on a popped up button
function AutoBar.PopupButtonOnClick(mousebutton)
	local button = this;
	button:SetChecked(0);
	if (button.bagSlot) then
		if (button.bagSlot[1] and button.bagSlot[2]) then
			local buttonInfo = AutoBar.buttons[AutoBarPopupFrame.popupButton];

			if (mousebutton == "RightButton" and type(buttonInfo) == "table" and buttonInfo.rightClickTargetsPet and UnitExists("pet")) then
				PickupContainerItem(button.bagSlot[1], button.bagSlot[2]);
				DropItemOnUnit("pet");
			else
				UseContainerItem(button.bagSlot[1], button.bagSlot[2]);
			end
			if (AutoBar_Category_Info[button.category] and AutoBar_Category_Info[button.category].targetted == "WEAPON" and SpellIsTargeting()) then
				if (mousebutton == "LeftButton") then
					PickupInventoryItem(GetInventorySlotInfo("MainHandSlot"));
				elseif (mousebutton == "RightButton") then
					PickupInventoryItem(GetInventorySlotInfo("SecondaryHandSlot"));
				end
			elseif (AutoBar_Category_Info[button.category] and AutoBar_Category_Info[button.category].targetted and (AutoBar.display.autoSmartSelfCast or AutoBar.smartSelfcast and AutoBar.smartSelfcast[category]) and SpellIsTargeting()) then
				SpellTargetUnit("player");
			end

			if (type(buttonInfo) == "table") then
				if (buttonInfo.arrangeOnUse) then
					local index;
					local currentItems = AutoBar_Buttons_CurrentItems[AutoBarPopupFrame.popupButton][button.popupButtonIndex];
					local _, itemId = AutoBar.LinkDecode(GetContainerItemLink(currentItems.items[1][1], currentItems.items[1][2]));
					local category = AutoBar_SearchedForItems[itemId][2];
					for index = 1, AUTOBAR_MAXSLOTCATEGORIES, 1 do
						if (buttonInfo[index] == category) then
							local targetIndex = table.getn(buttonInfo);
							local temp = buttonInfo[index];
							buttonInfo[index] = buttonInfo[targetIndex];
							buttonInfo[targetIndex] = temp;
							AutoBar.ConfigChanged();
							break;
						end
					end
				end
			end
		end
		AutoBarPopupFrame:Hide();
	end
end


--
-- Drag Handle.  (Sourced from GBars)
--

-- Lock & Unlock the frame on left click, and toggle config dialog with right click
function AutoBar:ClickHandle(button)
	local function RelockActionBars()
		self.display.frameLocked = true;
		LOCK_ACTIONBAR = "1";
		getglobal("AutoBarAnchorFrameHandle"):SetChecked(true);
	end

	if (button == "RightButton") then
		AutoBarConfig_Toggle();
		this:SetChecked(AutoBar.display.frameLocked);
	elseif (button == "LeftButton") then
		AutoBar.display.frameLocked = not AutoBar.display.frameLocked;
		if (AutoBar.display.frameLocked) then
			LOCK_ACTIONBAR = "1";
		else
			LOCK_ACTIONBAR = "0";
			self:ScheduleEvent("AutobarTemporaryUnlock", RelockActionBars, 30);
		end
		this:SetChecked(AutoBar.display.frameLocked);
	end
end


-- If the passed-in frame has a handle, show it
function AutoBar:ShowHandle(frame)
	local handle = getglobal(frame:GetName().."Handle")
	if (handle) then
		handle:SetScale(0.6)
		handle:Show();
	end
end


-- If the passed-in frame has a handle, hide it
function AutoBar:HideHandle(frame)
	local handle = getglobal(frame:GetName().."Handle")
	if (handle) then
		handle:Hide()
	end
end


-- Start dragging if not locked
function AutoBar:DragStart(frame)
	if (not frame) then frame = this:GetParent(); end
	if (not AutoBar.display.frameLocked) then
--DEFAULT_CHAT_FRAME:AddMessage("AutoBar:DragStart" .. frame:GetName(), 1, 0.5, 0);
		frame.isMoving = true;
		frame:StartMoving();
	end
end


-- End dragging
function AutoBar:DragStop(frame)
	if (not frame) then frame = this:GetParent(); end
	frame:StopMovingOrSizing()
	AutoBar.display.position = {};
	AutoBar.display.position.x,
	AutoBar.display.position.y = frame:GetCenter();
--DEFAULT_CHAT_FRAME:AddMessage("AutoBar:DragStop" .. frame:GetName() .. "x/y " .. tostring(AutoBar.display.position.x).. "/" ..tostring(AutoBar.display.position.y), 1, 0.5, 0);
	frame.isMoving = nil;
	AutoBar.display.docking = nil;
end




