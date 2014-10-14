-- Saved Variables
ZHunterMod_Saved["ZHunterAIAmmo"] = {}
ZHunterMod_Saved["ZHunterAIAmmo"]["smartammo"] = nil
ZHunterMod_Saved["ZHunterAIAmmo"]["reload"] = nil

-- Bullet List
ZHunterAIAmmo_Bullets = {}
ZHunterAIAmmo_Bullets[ZHUNTER_BULLETS_LIGHT] = 1
ZHunterAIAmmo_Bullets[ZHUNTER_BULLETS_CRAFTLIGHT] = 2
ZHunterAIAmmo_Bullets[ZHUNTER_BULLETS_FLASH] = 3
ZHunterAIAmmo_Bullets[ZHUNTER_BULLETS_HEAVY] = 4
ZHunterAIAmmo_Bullets[ZHUNTER_BULLETS_PEBBLE] = 5
ZHunterAIAmmo_Bullets[ZHUNTER_BULLETS_CRAFTHEAVY] = 6
ZHunterAIAmmo_Bullets[ZHUNTER_BULLETS_SOLID] = 7
ZHunterAIAmmo_Bullets[ZHUNTER_BULLETS_CRAFTSOLID] = 8
ZHunterAIAmmo_Bullets[ZHUNTER_BULLETS_EXPLODING] = 9
ZHunterAIAmmo_Bullets[ZHUNTER_BULLETS_MITHRILSLUG] = 10
ZHunterAIAmmo_Bullets[ZHUNTER_BULLETS_ACCURATE] = 11
ZHunterAIAmmo_Bullets[ZHUNTER_BULLETS_GYROSHOT] = 12
ZHunterAIAmmo_Bullets[ZHUNTER_BULLETS_ICETHREADED] = 13
ZHunterAIAmmo_Bullets[ZHUNTER_BULLETS_THORIUM] = 14
ZHunterAIAmmo_Bullets[ZHUNTER_BULLETS_ROCKSHARD] = 15
ZHunterAIAmmo_Bullets[ZHUNTER_BULLETS_CANNONBALL] = 16

-- Arrow List
ZHunterAIAmmo_Arrows = {}
ZHunterAIAmmo_Arrows[ZHUNTER_ARROWS_ROUGH] = 1
ZHunterAIAmmo_Arrows[ZHUNTER_ARROWS_SHARP] = 2
ZHunterAIAmmo_Arrows[ZHUNTER_ARROWS_RAZOR] = 3
ZHunterAIAmmo_Arrows[ZHUNTER_ARROWS_FEATHER] = 4
ZHunterAIAmmo_Arrows[ZHUNTER_ARROWS_PRECISION] = 5
ZHunterAIAmmo_Arrows[ZHUNTER_ARROWS_JAGGED] = 6
ZHunterAIAmmo_Arrows[ZHUNTER_ARROWS_ICETHREADED] = 7
ZHunterAIAmmo_Arrows[ZHUNTER_ARROWS_THORIUM] = 8
ZHunterAIAmmo_Arrows[ZHUNTER_ARROWS_DOOMSHOT] = 9

-- Shots and Stings that do not use weapon damage
ZHunterAIAmmo_JunkShots = {}
ZHunterAIAmmo_JunkShots[ZHUNTER_SERPENT] = 1
ZHunterAIAmmo_JunkShots[ZHUNTER_SCORPID] = 1
ZHunterAIAmmo_JunkShots[ZHUNTER_VIPER] = 1
ZHunterAIAmmo_JunkShots[ZHUNTER_ARCANE] = 1
ZHunterAIAmmo_JunkShots[ZHUNTER_CONCUSSIVE] = 1
ZHunterAIAmmo_JunkShots[ZHUNTER_TRANQUILIZING] = 1
ZHunterAIAmmo_JunkShots[ZHUNTER_DISTRACTING] = 1

ZHunterAIAmmo = {}
ZHunterAIAmmoLastCheck = 0

ZHunterAIAmmo_Tooltip = CreateFrame("GameTooltip", "ZHunterAIAmmo_Tooltip", nil, "GameTooltipTemplate")
ZHunterAIAmmo_Tooltip:Hide()

function ZHunterAIAmmo_GetAmmoType()
	local itemlink = GetInventoryItemLink("player", 18)
	if not itemlink then return end
	local _, _, itemid = string.find(itemlink, "item:(%d+)")
	if not itemid then return end
	local _, _, _, _, _, wpntype = GetItemInfo(itemid)
	if wpntype == ZHUNTER_BOWS or wpntype == ZHUNTER_CROSSBOWS then
		return "Arrows"
	elseif wpntype == ZHUNTER_GUNS then
		return "Bullets"
	end
end

function ZHunterAIAmmo_GetEquippedAmmo()
	ZHunterAIAmmo_Tooltip:SetOwner(UIParent, "ANCHOR_NONE")
	if ZHunterAIAmmo_Tooltip:SetInventoryItem("player", 0) then
		return ZHunterAIAmmo_TooltipTextLeft1:GetText()
	end
end

function ZHunterAIAmmo_ContainerItemName(bag, slot)
	if not (bag and slot) then return end
	local item = GetContainerItemLink(bag, slot)
	local _, _, name = string.find(item or "", "%[(.+)%]")
	return name
end

function ZHunterAIAmmo_EquipAmmo(junk)
	if not (ZHunterAIAmmo_Check() or ZHunterAIAmmo_FindAmmo()) then return end
	local bag, slot
	if junk then
		if ZHunterAIAmmo_GetEquippedAmmo() ~= ZHunterAIAmmo.cur and GetTime()-ZHunterAIAmmoLastSwitch > 0.5 then
			if not ZHunterAIAmmo_FindAmmo() then
				return
			end
		end
		bag, slot = ZHunterAIAmmo.junkbag, ZHunterAIAmmo.junkslot
	else
		bag, slot = ZHunterAIAmmo.curbag, ZHunterAIAmmo.curslot
	end
	PickupContainerItem(bag, slot)
	AutoEquipCursorItem()
	ZHunterAIAmmoLastSwitch = GetTime()
end

function ZHunterAIAmmo_FindAmmo()
	ZHunterAIAmmo = {}
	local ammotype = ZHunterAIAmmo_GetAmmoType()
	if not ammotype then return end
	local curammo = ZHunterAIAmmo_GetEquippedAmmo()
	if not curammo and not ZHunterMod_Saved["ZHunterAIAmmo"]["reload"] then return end
	local ammolist = getglobal("ZHunterAIAmmo_"..ammotype)
	local item, value
	local junkvalue = 999
	local goodvalue
	for bag=4, 0, -1 do
		for slot=GetContainerNumSlots(bag), 1, -1 do
			item = ZHunterAIAmmo_ContainerItemName(bag, slot)
			if item then
				value = ammolist[item]
				if value then
					if not goodvalue and item == curammo then
						ZHunterAIAmmo.cur = item
						ZHunterAIAmmo.curbag = bag
						ZHunterAIAmmo.curslot = slot
						goodvalue = value
						if junkvalue == 1 then
							return 1
						end
					end
					if value < junkvalue then
						ZHunterAIAmmo.junk = item
						ZHunterAIAmmo.junkbag = bag
						ZHunterAIAmmo.junkslot = slot
						junkvalue = value
						if not curammo then
							ZHunterAIAmmo.cur = item
							ZHunterAIAmmo.curbag = bag
							ZHunterAIAmmo.curslot = slot
							goodvalue = value
						end
						if junkvalue == 1 and goodvalue then
							return 1
						end
					end
				end
			end
		end
	end
	if not goodvalue or junkvalue > goodvalue then
		ZHunterAIAmmo.error = 1
		return
	end
	return 1
end

function ZHunterAIAmmo_Check()
	if not ZHunterAIAmmo.error and ZHunterAIAmmo.cur and ZHunterAIAmmo.junk then
		if ZHunterAIAmmo.cur == ZHunterAIAmmo_ContainerItemName(ZHunterAIAmmo.curbag, ZHunterAIAmmo.curslot) and
		ZHunterAIAmmo.junk == ZHunterAIAmmo_ContainerItemName(ZHunterAIAmmo.junkbag, ZHunterAIAmmo.junkslot) then
			return 1
		end
	end
end

ZHunterAIAmmo_CastSpell = CastSpell
function CastSpell(spell, tab, a, b, c, d, e)
	if ZHunterMod_Saved["ZHunterAIAmmo"]["smartammo"] then
		local name = GetSpellName(spell, tab)
		if name and ZHunterAIAmmo_JunkShots[name] then
			if ZHunterAIAmmo_Check() or ZHunterAIAmmo_FindAmmo() then
				ZHunterAIAmmo_EquipAmmo(1)
				name = ZHunterAIAmmo_CastSpell(spell, tab, a, b, c, d, e)
				ZHunterAIAmmo_EquipAmmo()
				return name
			end
		end
	end
	return ZHunterAIAmmo_CastSpell(spell, tab, a, b, c, d, e)
end

ZHunterAIAmmo_UseAction = UseAction
function UseAction(slot, checkCursor, onSelf, a, b, c, d, e)
	if not GetActionText(slot) and ZHunterMod_Saved["ZHunterAIAmmo"]["smartammo"] then
		ZHunterAIAmmo_Tooltip:SetOwner(UIParent, "ANCHOR_NONE")
		ZHunterAIAmmo_Tooltip:SetAction(slot)
		local name = ZHunterAIAmmo_TooltipTextLeft1:GetText()
		if name and ZHunterAIAmmo_JunkShots[name] then
			if ZHunterAIAmmo_Check() or ZHunterAIAmmo_FindAmmo() then
				ZHunterAIAmmo_EquipAmmo(1)
				name = ZHunterAIAmmo_UseAction(slot, checkCursor, onSelf, a, b, c, d, e)
				ZHunterAIAmmo_EquipAmmo()
				return name
			end
		end
	end
	return ZHunterAIAmmo_UseAction(slot, checkCursor, onSelf, a, b, c, d, e)
end

ZHunterAIAmmo_CastSpellByName = CastSpellByName
function CastSpellByName(spell, onSelf, a, b, c, d, e)
	local _, _, name = string.find(spell or "", "([%w%'%s]+)")
	if name and ZHunterMod_Saved["ZHunterAIAmmo"]["smartammo"] and ZHunterAIAmmo_JunkShots[name] then
		if ZHunterAIAmmo_Check() or ZHunterAIAmmo_FindAmmo() then
			ZHunterAIAmmo_EquipAmmo(1)
			name = ZHunterAIAmmo_CastSpellByName(spell, onSelf, a, b, c, d, e)
			ZHunterAIAmmo_EquipAmmo()
			return name
		end
	end
	return ZHunterAIAmmo_CastSpellByName(spell, onSelf, a, b, c, d, e)
end

SLASH_ZHunterAIAmmo1 = "/zammo"
SlashCmdList["ZHunterAIAmmo"] = function(msg)
	if ZHunterMod_Saved["ZHunterAIAmmo"]["smartammo"] then
		ZHunterMod_Saved["ZHunterAIAmmo"]["smartammo"] = nil
		DEFAULT_CHAT_FRAME:AddMessage("Smart Ammo is now off.", 0, 1, 1)
	else
		ZHunterMod_Saved["ZHunterAIAmmo"]["smartammo"] = 1
		DEFAULT_CHAT_FRAME:AddMessage("Shots that don't do weapon damage will use the worst ammo found.", 0, 1, 1)
	end
end