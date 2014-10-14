AmmoFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceDB-2.0", "AceConsole-2.0", "AceEvent-2.0")

AmmoFu.version = "2.0." .. string.sub("$Revision: 9831 $", 12, -3)
AmmoFu.date = string.sub("$Date: 2006-09-02 11:25:04 -0700 (Sat, 02 Sep 2006) $", 8, 17)
AmmoFu.hasIcon = "Interface\\AddOns\\FuBar_AmmoFu\\arrow"
AmmoFu.cannotDetachTooltip = true

AmmoFu:RegisterDB("AmmoFuDB")
AmmoFu:RegisterDefaults('profile', {
	showPercent = false,
})

local Tablet = AceLibrary("Tablet-2.0")
local Crayon = AceLibrary("Crayon-2.0")

local L = AceLibrary("AceLocale-2.0"):new("FuBar_AmmoFu")

function AmmoFu:IsShowingPercent()
	return self.db.profile.showPercent
end

function AmmoFu:ToggleShowingPercent()
	self.db.profile.showPercent = not self.db.profile.showPercent
	self:Update()
end

function AmmoFu:OnEnable()
	self:RegisterEvent("ITEM_LOCK_CHANGED")
	self:RegisterEvent("UNIT_MODEL_CHANGED", "ITEM_LOCK_CHANGED")
	self:RegisterEvent("BAG_UPDATE", "ITEM_LOCK_CHANGED")
end

local options = {
	type = 'group',
	args = {
		percent = {
			type = 'toggle',
			name = L["Show as percentage"],
			desc = L["Toggle to show remaining ammunition as a percentage"],
			get = "IsShowingPercent",
			set = "ToggleShowingPercent",
		}
	},
	handler = AmmoFu
}
AmmoFu:RegisterChatCommand(L["AceConsole-Commands"], options)
AmmoFu.OnMenuRequest = options

function AmmoFu:ITEM_LOCK_CHANGED()
	self:ScheduleEvent(self.name, self.Update, 1, self)
end

function AmmoFu:OnClick()
	for i = 1, 4 do
		local link = GetInventoryItemLink("player", ContainerIDToInventoryID(i))
		if link ~= nil then
			local _,_,_,_,_,subtype = GetItemInfo(tonumber(string.gsub(link, "|cff%x%x%x%x%x%x|Hitem:(%d+):%d+:%d+:%d+|h.*", "%1") or 0))
			if subtype == L["Soul Bag"] or subtype == L["Ammo Pouch"] or subtype == L["Quiver"] then
				ToggleBag(i)
			end
		end
	end
end

function AmmoFu:OnTextUpdate()
	local ammoSlotId = GetInventorySlotInfo("ammoSlot")
	local rangedSlotId = GetInventorySlotInfo("rangedSlot")

	local isThrown = false
	local link = GetInventoryItemLink("player", rangedSlotId)
	if link ~= nil then
		local _,_,_,_,_,subtype = GetItemInfo(tonumber(string.gsub(link, "|cff%x%x%x%x%x%x|Hitem:(%d+):%d+:%d+:%d+|h.*", "%1") or 0))
		if GetInventoryItemQuality("player", rangedSlotId) ~= nil and subtype == L["Thrown"] then
			isThrown = true
		end
	end
	
	if not isThrown and GetInventoryItemQuality("player", ammoSlotId) ~= nil then
		isAmmo = true
	end
	
	local current = 0
	local total = 0
	local _,class = UnitClass("player")
	if class == "WARLOCK" then
		self:SetIcon("shard")
		for i = 0, 4 do
			if i >= 1 then
				local link = GetInventoryItemLink("player", ContainerIDToInventoryID(i))
				if link ~= nil then
					local itemId = tonumber(string.gsub(link, "|cff%x%x%x%x%x%x|Hitem:(%d+):%d+:%d+:%d+|h.*", "%1") or 0)
					local _,_,_,_,_,subtype = GetItemInfo(itemId)
					if subtype == L["Soul Bag"] then
						local size = GetContainerNumSlots(i)
						if size ~= nil and size > 0 then
							total = total + size
						end
					end
				end
			end
			for j = 1, GetContainerNumSlots(i) do
				local link = GetContainerItemLink(i, j)
				if link ~= nil and string.find(link, "|cff%x%x%x%x%x%x|Hitem:6265:%d+:%d+:%d+|h") then
					current = current + 1
				end
			end
		end
		if current > total then
			total = current
		end
		if total < 4 then
			total = 4
		end
	elseif isThrown then
		self:SetIcon("knife")
		current = GetInventoryItemCount("player", rangedSlotId)
		total = 200
	elseif isAmmo then
		self:SetIcon("arrow")
		current = GetInventoryItemCount("player", ammoSlotId)
		total = 0
		for i = 0, 4 do
			if i >= 1 then
				local link = GetInventoryItemLink("player", ContainerIDToInventoryID(i))
				if link ~= nil then
					local itemId = tonumber(string.gsub(link, "|cff%x%x%x%x%x%x|Hitem:(%d+):%d+:%d+:%d+|h.*", "%1") or 0)
					local _,_,_,_,_,subtype = GetItemInfo(itemId)
					if subtype == L["Quiver"] or subtype == L["Ammo Pouch"] then
						local size = GetContainerNumSlots(i)
						if size ~= nil and size > 0 then
							total = total + size * 200
						end
					end
				end
			end
		end
		if total == 0 then
			total = 200
		end
	else
		self:SetIcon("arrow")
		current = 0
		total = 0
	end
	
	local color
	if total == 0 then
		color = Crayon.COLOR_HEX_RED
	else
		color = Crayon:GetThresholdHexColor(current / total)
	end
	
	if self:IsShowingPercent() then
		self:SetText(format("|cff%s%d%%|r", color, current / total * 100))
	else
		self:SetText(format("|cff%s%d|r", color, current))
	end
end

function AmmoFu:OnTooltipUpdate()
	for i = 1, 4 do
		local link = GetInventoryItemLink("player", ContainerIDToInventoryID(i))
		if link ~= nil then
			local _,_,_,_,_,subtype = GetItemInfo(tonumber(string.gsub(link, "|cff%x%x%x%x%x%x|Hitem:(%d+):%d+:%d+:%d+|h.*", "%1") or 0))
			if subtype == L["Soul Bag"] then
				Tablet:SetHint(L["Click to open your shard bag"])
				break
			elseif subtype == L["Ammo Pouch"] or subtype == L["Quiver"] then
				Tablet:SetHint(L["Click to open your ammunition bag"])
				break
			end
		end
	end
end
