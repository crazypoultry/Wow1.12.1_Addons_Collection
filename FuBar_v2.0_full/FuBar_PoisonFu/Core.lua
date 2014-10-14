--[[-------------------------------------------------------------------------
-- PoisonFu - A rogue poison alert addon for FuBar
--  by The Lithe Development Team
--  http://www.wowace.com/index.php/Lithe_Development_Team
--
--  Last Modified: $Date: 2006-09-24 14:04:56 -0400 (Sun, 24 Sep 2006) $
--  Revision: $Revision: 11920 $
--  This software is licensed under a zlib/linpng license.
--
-- Development Todo/Ideas:
--  * Convert from my table based system to using Ace PeriodicTable
--  * Add support for weightstones, oils, etc.
--  * Add support for shaman item buff spells
--  * Show all available item buffs in the FuBar tooltip. Also show the current default.
--  * Show the current item effect (line 6 from Game Tooltip) in the FuBar tooltip
--  * Consider switching to Abacus for formatting and adding options to let the user
--    control the display
--
-- Known Bugs
--  * N/A
--
--]]-------------------------------------------------------------------------

-- Local constants
local MAJOR_VERSION = "1.6"
local MINOR_VERSION = tonumber((string.gsub("$Revision: 11920 $", "^.-(%d+).-$", "%1")))
local TIMER_NAME = "PoisonFuTimer"
local TIMER_INTERVAL = 1.0

-- This table contains the supported item buffs' ItemIds (as used with GetItemInfo). Among other things, these Ids are used to index into
-- the ItemBuffEffects localization table.
local ITEM_BUFFS = {
	Poisons = { 3775 --[["Crippling Poison"]], 3776 --[["Crippling Poison II"]], 2892 --[["Deadly Poison"]], 2893 --[["Deadly Poison II"]], 8984 --[["Deadly Poison III"]],
		8985 --[["Deadly Poison IV"]], 20844 --[["Deadly Poison V"]], 6947 --[["Instant Poison"]], 6949 --[["Instant Poison II"]], 6950 --[["Instant Poison III"]], 8926 --[["Instant Poison IV"]],
		8927 --[["Instant Poison V"]], 8928 --[["Instant Poison VI"]], 5237 --[["Mind-numbing Poison"]], 6951 --[["Mind-numbing Poison II"]], 9186 --[["Mind-numbing Poison III"]],
		10918 --[["Wound Poison"]], 10920 --[["Wound Poison II"]], 10921 --[["Wound Poison III"]], 10922 --[["Wound Poison IV"]], },

	SharpeningStones = {
		2862 --[["Rough Sharpening Stone"]],
		2863 --[["Coarse Sharpening Stone"]],
		2871 --[["Heavy Sharpening Stone"]],
		7964 --[["Solid Sharpening Stone"]],
		12404 --[["Dense Sharpening Stone"]],
		18262 --[["Elemental Sharpening Stone"]],
		23122 --[["Consecrated Sharpening Stone"]],
	},

	WizardOils = { 20746 --[["Lesser Wizard Oil"]], 20744 --[["Minor Wizard Oil"]], 20750 --[["Wizard Oil"]], 20749 --[["Briliant Wizard Oil"]], 23123 --[["Blessed Wizard Oil"]], },
}

-- Utility Libraries
local Tablet = AceLibrary("Tablet-2.0")
local Gratuity = AceLibrary("Gratuity-2.0")
local Dewdrop = AceLibrary("Dewdrop-2.0")
local Metrognome = AceLibrary("Metrognome-2.0")
local Crayon = AceLibrary("Crayon-2.0")
local L = AceLibrary("AceLocale-2.0"):new("FuBar_PoisonFu_Locales")
local ItemBuffEffects = AceLibrary("AceLocale-2.0"):new("FuBar_PoisonFu_ItemBuffEffects")

-- Initialize the addon instance
PoisonFu = AceLibrary("AceAddon-2.0"):new("AceDB-2.0", "FuBarPlugin-2.0", "AceDebug-2.0", "AceConsole-2.0")
PoisonFu:RegisterDB("PoisonFuDB")
PoisonFu:RegisterDefaults("profile", { default = {
	["MAINHANDSLOT"] = nil,
	["SECONDARYHANDSLOT"] = nil,
} } )
PoisonFu.version = MAJOR_VERSION .. "." .. MINOR_VERSION
PoisonFu.date = string.gsub("$Date: 2006-09-24 14:04:56 -0400 (Sun, 24 Sep 2006) $", "^.-(%d%d%d%d%-%d%d%-%d%d).-$", "%1")

-- Primary addon initialization function.
function PoisonFu:OnInitialize()
	Metrognome:Register(TIMER_NAME, self.TimerCallback, TIMER_INTERVAL, self)
	PoisonFu.hasIcon = true
	PoisonFu:SetIcon(true)

	self.mainHandBuffedOnLastUpdate = false
	self.offHandBuffedOnLastUpdate = false
end

-- Called by Ace/FuBar when the user enables the addon.
function PoisonFu:OnEnable()
	Metrognome:Start(TIMER_NAME)
end

-- Called by Ace/FuBar when the use disables the addon.
function PoisonFu:OnDisable()
	Metrognome:Stop(TIMER_NAME)
end

-- Called by FuBar to ask the addon to paint the Dewdrop menu.
function PoisonFu:OnMenuRequest(level, value, inTooltip)
	if level == 1 then

		-- Apply to Weapon...
		Dewdrop:AddLine()
		Dewdrop:AddLine('text', L["APPLY_TITLE_TEXT"], 'isTitle', true)
		local itemType = self:GetInventorySlotType("MAINHANDSLOT")
		if itemType == "Weapon" then
			Dewdrop:AddLine( 'text', L["MAINHAND_MENU_TEXT"], 'hasArrow', true, 'value', "POISONFU_APPLY_MAINHANDSLOT", 'disabled', not itemType)
		else
			Dewdrop:AddLine( 'text', L["MAINHAND_NOT_EQUIPPED"], 'notClickable', true)
		end

		itemType = self:GetInventorySlotType("SECONDARYHANDSLOT")
		if itemType == "Weapon" then
			Dewdrop:AddLine( 'text', L["OFFHAND_MENU_TEXT"], 'hasArrow', true, 'value', "POISONFU_APPLY_SECONDARYHANDSLOT", 'disabled', not itemType)
		else
			Dewdrop:AddLine( 'text', L["OFFHAND_NOT_EQUIPPED"], 'notClickable', true)
		end

		-- Set Default...
		Dewdrop:AddLine()
		Dewdrop:AddLine('text', L["DEFAULT_TITLE_TEXT"], 'isTitle', true)
		local itemType = self:GetInventorySlotType("MAINHANDSLOT")
		if itemType == "Weapon" then
			Dewdrop:AddLine( 'text', L["MAINHAND_MENU_TEXT"], 'hasArrow', true, 'value', "POISONFU_DEFAULT_MAINHANDSLOT", 'disabled', not itemType)
		else
			Dewdrop:AddLine( 'text', L["MAINHAND_NOT_EQUIPPED"], 'notClickable', true)
		end

		itemType = self:GetInventorySlotType("SECONDARYHANDSLOT")
		if itemType == "Weapon" then
			Dewdrop:AddLine( 'text', L["OFFHAND_MENU_TEXT"], 'hasArrow', true, 'value', "POISONFU_DEFAULT_SECONDARYHANDSLOT", 'disabled', not itemType)
		else
			Dewdrop:AddLine( 'text', L["OFFHAND_NOT_EQUIPPED"], 'notClickable', true)
		end

		Dewdrop:AddLine()

	elseif level == 2 then
		local _, _, menuType, slotName = string.find(value, "POISONFU_(%a*)_(%a*)")
		if menuType and slotName then
			local firstComplete = false
			for buffType, buffIds in pairs(ITEM_BUFFS) do
				if self:AreBuffsAvailable(buffType) then
					if firstComplete then Dewdrop:AddLine() else firstComplete = true end
					Dewdrop:AddLine('text', buffType, 'isTitle', true)

					local addedBuffsToType = false
					for index, buffId in ipairs(buffIds) do
						local itemBuffName = GetItemInfo(buffId)

						if (self:FindItemInInventory(itemBuffName)) or (self:IsPoisonApplied(slotName, itemBuffName)) then
							addedBuffsToType = true
							if menuType == "APPLY" then
								Dewdrop:AddLine(
									'text', self:GetMenuText(buffId),
									'func', "ApplyItemBuff", 'arg1', self, 'arg2', slotName, 'arg3', itemBuffName,
									'closeWhenClicked', true,
									'checked', self:IsPoisonApplied(slotName, itemBuffName),
									'tooltipFunc', self.ShowGameTooltip, 'tooltipArg1', self, 'tooltipArg2', itemBuffName
								)
							elseif menuType == "DEFAULT" then
								Dewdrop:AddLine(
									'text', self:GetMenuText(buffId),
									'func', "SetDefaultItemBuff", 'arg1', self, 'arg2', slotName, 'arg3', buffId,
									'closeWhenClicked', false,
									'isRadio', true,
									'checked', self:IsDefaultItemBuff(slotName, buffId),
									'tooltipFunc', self.ShowGameTooltip, 'tooltipArg1', self, 'tooltipArg2', itemBuffName
								)
							end
						end
					end
				end
			end
		end
	end
end

function PoisonFu:SetDefaultItemBuff(slotName, itemId)
	self.db.profile.default[slotName] = itemId
end

function PoisonFu:IsDefaultItemBuff(slotName, itemId)
	return self.db.profile.default[slotName] == itemId
end

function PoisonFu:GetInventorySlotType(slotName)
	local slotId = GetInventorySlotInfo(slotName)
	local link = GetInventoryItemLink("player", slotId)
	if link then
		local _, _, _, _, itemType = self:GetItemInfoFromItemLink(link)
		return itemType
	end
end

-- Called by FuBar when the addon UI needs to be updated
function PoisonFu:OnTextUpdate()
	local hasMainHandEnchant, mainHandExpiration, mainHandCharges, hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo()
	local mainHandText, mainHandColor = self:GetTextForWeaponSlot("MAINHANDSLOT", hasMainHandEnchant==1, mainHandExpiration, mainHandCharges);
	local offHandText, offHandColor = self:GetTextForWeaponSlot("SECONDARYHANDSLOT", hasOffHandEnchant==1, offHandExpiration, offHandCharges);

	self:SetText(Crayon:Colorize(mainHandColor, mainHandText) .. self:GetSpacer() .. Crayon:Colorize(offHandColor,offHandText))
end

function PoisonFu:OnClick()
	local hasMainHandEnchant, _, _, hasOffHandEnchant = GetWeaponEnchantInfo()
	local applied = false
	if (hasMainHandEnchant or not self:GetEquippedWeaponInfo("MAINHANDSLOT")) and (hasOffHandEnchant or not self:GetEquippedWeaponInfo("SECONDARYHANDSLOT")) then return end
	if not hasMainHandEnchant then
		slotName = "MAINHANDSLOT"
		slotDesc = "main-hand"
	elseif not hasOffHandEnchant then
		slotName = "SECONDARYHANDSLOT"
		slotDesc = "off-hand"
	end

	local itemId = self.db.profile.default[slotName]
	self:Print("Applying %s to %s weapon.", GetItemInfo(itemId), slotDesc)
	self:ApplyItemBuff(slotName, itemId)

	return true
end

-- Timer callback function for refreshing the text in the bar
function PoisonFu:TimerCallback()
	self:WarnIfPoisonExpired()
	self:UpdateDisplay()
end

-- Displays a warning message int he UIErrorsFrame if an item buff has expired
function PoisonFu:WarnIfPoisonExpired()
	local hasMainHandEnchant, mainHandExpiration, mainHandCharges, hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo()
	if ((self.mainHandBuffedOnLastUpdate == true) and (hasMainHandEnchant ~= 1)) or
		((self.offHandBuffedOnLastUpdate == true) and (hasOffHandEnchant ~= 1)) then
		UIErrorsFrame:AddMessage(L["BUFFEXPIRED_MESSAGE"], 1.0, 0.0, 0.0, 1.0, 5)
	end

	self.mainHandBuffedOnLastUpdate = (hasMainHandEnchant == 1)
	self.offHandBuffedOnLastUpdate = (hasOffHandEnchant == 1)
end

function PoisonFu:GetItemCountByItemId(itemId)
	local totalCount = 0
	for bag=0,4 do
		for slot=1,GetContainerNumSlots(bag) do
			local link = GetContainerItemLink(bag,slot)
			if link then
				local bagItemId = self:GetItemIdFromItemLink(link)
				if itemId == bagItemId then
					local _,count = GetContainerItemInfo(bag,slot)
					totalCount = totalCount + count
				end
			end
		end
	end
	return totalCount
end

function PoisonFu:GetMenuText(itemId)
	local itemName = GetItemInfo(itemId)
	if itemName then
		local count = self:GetItemCountByItemId(itemId)
		if count and count > 0 then
			return string.format("%s (x%d)", itemName, count)
		else
			return string.format("%s (N/A)", itemName)
		end
	end
end

function PoisonFu:ShowGameTooltip(poison)
	GameTooltip_SetDefaultAnchor(GameTooltip, this)
	GameTooltip:SetBagItem(self:FindItemInInventory(poison))
end

function PoisonFu:AreBuffsAvailable(buffType)
	for index, buffId in ipairs(ITEM_BUFFS[buffType]) do
		if self:FindItemInInventory(GetItemInfo(buffId)) then
			return true
		end
	end
end

-- Returns true if the given poison is applied to the weapon in the
-- provided slot name.
function PoisonFu:IsPoisonApplied(slotName, poisonName)
	local _, appliedPoison = self:GetEquippedWeaponInfo(slotName)
	return appliedPoison and appliedPoison == poisonName
end


function PoisonFu:GetSpacer()
	return self:GetEquippedWeaponInfo("SECONDARYHANDSLOT") and " | " or ""
end

-- Helper function to create the text,color for the given weapon slot
function PoisonFu:GetTextForWeaponSlot(slotName, hasEnchant, expiration, charges)
	-- [i] mm (charges) | mm (charges)

	local result = ""
	local color = "ffffff"
	local weapon, _ = self:GetEquippedWeaponInfo(slotName)
	if weapon then
		if hasEnchant  then
			self:Debug("GetTextForWeaponSlot - charges = %d", charges)
			result = self:FormatTime(expiration, "m", "s")
			if charges > 0 then
				result = result .. string.format(" (%d)", charges)
			end
			-- Red if < 1 min or < 5 charges
			if expiration < 60000 or (charges > 0 and charges < 5) then
				color = "ff0000"
			-- Yellow if < 5 mins or < 15 charges
			elseif (expiration < (60000*5)) or (charges > 0 and charges < 15) then
				color = "ffff00"
			-- Green otherwise
			else
				color = "00ff00"
			end
		else
			-- Red if nothing applied and weapon equipped
			result = result .. "N/A"
			color = "ff0000"
		end
	end
	return result, color
end

-- Helper function for formatting time
function PoisonFu:FormatTime( milisecs, minSuffix, secSuffix )
	if milisecs < 60000 then
		return string.format("%d%s",  floor(mod(milisecs, 60000)/1000), secSuffix)
	else
		return string.format("%d%s", ceil(milisecs/60000), minSuffix)
	end
end

-- Called by FuBar when the tooltip needs to be updated.
function PoisonFu:OnTooltipUpdate()
	local hasMainHandEnchant, mainHandExpiration, mainHandCharges, hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo()

	self:AddWeaponSectionToTooltip(L["MAINHAND_MENU_TEXT"], "MAINHANDSLOT", hasMainHandEnchant==1, mainHandExpiration, mainHandCharges);
	self:AddWeaponSectionToTooltip(L["OFFHAND_MENU_TEXT"], "SECONDARYHANDSLOT", hasOffHandEnchant==1, offHandExpiration, offHandCharges);
end

-- Paints a single Tablet section using the given information
function PoisonFu:AddWeaponSectionToTooltip(sectionName, slotName, hasEnchant, expiration, charges)
	local category = Tablet:AddCategory("columns", 2, "text", sectionName);

	local weaponName, itemBuffName = self:GetEquippedWeaponInfo(slotName);
	weaponName = weaponName or Crayon:Silver("N/A")
	itemBuffName = itemBuffName or Crayon:Silver("N/A")

	category:AddLine("text", weaponName, "text2", itemBuffName)

	if hasEnchant then
		local timeAndCharges = self:FormatTime(expiration, " min", " sec")
		if charges and charges > 0 then
			timeAndCharges = timeAndCharges .. string.format(" (%d charges)", charges)
		end

		category:AddLine("text2", timeAndCharges)
	end
end

-- This method will use tooltip scanning to try to determine what the
-- weaponName,itemBuffName are in for the weapon in the given slot. Returns
-- nil if no weapon (1st tuple) and nil if no poison (2nd tuple).
function PoisonFu:GetEquippedWeaponInfo(slotName)
	local weaponName

	local slotId = GetInventorySlotInfo(slotName)
	local link = GetInventoryItemLink("player", slotId)
	local _, _, _, _, itemType = self:GetItemInfoFromItemLink(link)

	if link and itemType == "Weapon" then
		Gratuity:SetInventoryItem("player", slotId)
		weaponName = Gratuity:GetLine(1)
		local appliedBuffEffect = Gratuity:GetLine(6)

		if appliedBuffEffect then
			for itemBuffId, localizedEffect in ItemBuffEffects:GetIterator() do
				if string.find(appliedBuffEffect, localizedEffect) == 1 then
					return weaponName, GetItemInfo(itemBuffId)
				end
			end
		end
	end

	return weaponName
end

-- This function will apply the item named inventory item to the weapon in the
-- named slot.
function PoisonFu:ApplyItemBuff(slotName, inventoryItem)
	local bag, slot = self:FindItemInInventory(inventoryItem)

	-- In case we are at the bank, we don't want to send the item there
	CloseBankFrame()

	-- These two lines actually apply the bag item to the weapon in the slot by simulating
	-- what the user does... "use the item" == right click on it, "pickup the item" == left click.
	UseContainerItem(bag,slot)
	PickupInventoryItem(GetInventorySlotInfo(slotName))

	-- Re-equip the item in case Pickup actually "picked it up" instead of applying the item
	EquipCursorItem(slot)
end

-- Extract the item name from an Item Link
function PoisonFu:NameFromLink(link)
	local ITEM_LINK_PAT = ".c%x+.Hitem:%d+:%d+:%d+:%d+.h%[(.-)%].h.r"
	for name in string.gfind(link, ITEM_LINK_PAT) do
		return name
	end
end

-- This function will return the bag,slot for the itemName provided
-- or nil,nil otherwise.
function PoisonFu:FindItemInInventory(itemNameOrId)
	local link
	for bag=0,4 do
		for slot=1,GetContainerNumSlots(bag) do
			link = GetContainerItemLink(bag,slot)
			if link then
				if type(itemNameOrId) == "string" then
					if self:NameFromLink(link) == itemNameOrId then
						return bag, slot
					end
				elseif type(itemNameOrId) == "number" then
					if self:GetItemIdFromItemLink(link) == itemNameOrId then
						return bag,slot
					end
				end
			end
		end
	end
end

-- Given an item link, this will parse the link text for the itemid and
-- then use it to call GetItemInfo, returning the results of that call.
function PoisonFu:GetItemInfoFromItemLink(link)
	local itemId
	if type(link) == "string" then
		itemId = self:GetItemIdFromItemLink(link)
 		return GetItemInfo(itemId)
	end
end

function PoisonFu:GetItemIdFromItemLink(link)
	local _,_, itemId = string.find(link, "item:(%d+):")
	return tonumber(itemId)
end
