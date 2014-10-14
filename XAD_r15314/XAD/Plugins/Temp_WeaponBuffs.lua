local AceOO = AceLibrary("AceOO-2.0")
local core = XAD

local template = AceOO.Mixin {
	"UseMain",
	"UseOffhand"
}
core:RegisterTemplate("WeaponBuffs", template)

function template:UseMain(bag, slot)
	if not bag then return end
	if not core.db.profile.quite then
		local link = GetContainerItemLink(bag,slot)
		if not link then return end
		DEFAULT_CHAT_FRAME:AddMessage('XAD - Applying '..link..' to Main hand weapon.', 1.0, 1.0, 0.5)
	end
	UseContainerItem(bag,slot)
	PickupInventoryItem(GetInventorySlotInfo("MAINHANDSLOT"))
	-- Re-equip the item in case Pickup actually "picked it up" instead of applying the item
	if CursorHasItem() then EquipCursorItem("MAINHANDSLOT")  end
end

function template:UseOffhand(bag, slot)
	if not bag then return end
	if not core.db.profile.quite then
		local link = GetContainerItemLink(bag,slot)
		if not link then return end
		DEFAULT_CHAT_FRAME:AddMessage('XAD - Applying '..link..' to Offhand weapon.', 1.0, 1.0, 0.5)
	end
	UseContainerItem(bag,slot)
	PickupInventoryItem(GetInventorySlotInfo("SECONDARYHANDSLOT"))
	-- Re-equip the item in case Pickup actually "picked it up" instead of applying the item
	if CursorHasItem() then EquipCursorItem("SECONDARYHANDSLOT") end
end