--[[
	Bags.lua
		Functions used by Bagnon Bags
--]]

--[[ Bag Frame Functions ]]--

local function ForAllBagSlots(bagFrame, action, arg1)
	local frameName = bagFrame:GetName()
	for i = 1, 10 do
		local bag = getglobal(frameName .. i)
		if bag then
			action(bag, arg1)
		end
	end
end

--this function is used when updating the frame's size based on a bag being replaced/removed/added, so we don't care about the keyring
local function UpdateFrameSize(bagFrame)
	local size = 0
	for i = 1, 10 do
		local bag = getglobal(bagFrame:GetName() .. i)
		if bag and GetInventoryItemTexture("player", ContainerIDToInventoryID(bag:GetID())) then
			size = size + GetContainerNumSlots(bag:GetID())
		end
	end
	local change = (size or 0) - (bagFrame.size or 0)

	--only generate the frame again if the size of the frame changed
	if change ~= 0 then
		bagFrame.size = size
		BagnonFrame_Generate(bagFrame:GetParent())
	end
end

function BagnonBagFrame_OnEvent()
	if not this:IsVisible() or Bagnon_IsCachedFrame(this:GetParent()) then return end

	if event == "BAG_UPDATE" or event == "PLAYERBANKSLOTS_CHANGED" or event == "PLAYERBANKBAGSLOTS_CHANGED" then
		--hack, the bank frame needs to always update due to unreliable events
		if not arg1 or this:GetParent() == Banknon then
			ForAllBagSlots(this, BagnonBag_Update)
		elseif tonumber(arg1) and arg1 > 0 then
			local bag = getglobal(this:GetName() .. arg1)
			if bag then
				BagnonBag_Update(bag)
			end
		end
		UpdateFrameSize(this)
	elseif event == "ITEM_LOCK_CHANGED" then
		ForAllBagSlots(this, BagnonBag_UpdateLock)
	elseif event == "CURSOR_UPDATE" then
		ForAllBagSlots(this, BagnonBag_UpdateCursor)
	end
end

function BagnonBagFrame_OnLoad()
	this:RegisterEvent("BAG_UPDATE")
	this:RegisterEvent("ITEM_LOCK_CHANGED")
	this:RegisterEvent("CURSOR_UPDATE")

	this:RegisterEvent("PLAYERBANKSLOTS_CHANGED")
	this:RegisterEvent("PLAYERBANKBAGSLOTS_CHANGED")
end

--[[ Individual Bag Slot Code ]]--

--[[ Update Functions ]]--

function BagnonBag_Update(bag)
	if not bag then return end

	local invID = ContainerIDToInventoryID(bag:GetID())

	local textureName = GetInventoryItemTexture("player", invID)
	if textureName then
		SetItemButtonTexture(bag, textureName)
		BagnonBag_SetCount(bag, GetInventoryItemCount("player", invID))

		if not IsInventoryItemLocked(invID) then
			SetItemButtonTextureVertexColor(bag, 1.0, 1.0, 1.0)
			SetItemButtonNormalTextureVertexColor(bag, 1.0, 1.0, 1.0)
		end
		bag.hasItem = 1
	else
		SetItemButtonTexture(bag, nil)
		BagnonBag_SetCount(bag, 0)
		SetItemButtonTextureVertexColor(bag, 1, 1, 1)
		SetItemButtonNormalTextureVertexColor(bag, 1, 1, 1)
		bag.hasItem = nil
	end
	if GameTooltip:IsOwned(bag) then
		if textureName then
			BagnonBag_OnEnter(bag)
		else
			GameTooltip:Hide()
			ResetCursor()
		end
	end
	BagnonBag_UpdateLock(bag)

	-- Update repair all button status
	if MerchantRepairAllIcon then
		local repairAllCost, canRepair = GetRepairAllCost()
		if canRepair then
			SetDesaturation(MerchantRepairAllIcon, nil)
			MerchantRepairAllButton:Enable()
		else
			SetDesaturation(MerchantRepairAllIcon, 1)
			MerchantRepairAllButton:Disable()
		end
	end
end

function BagnonBag_UpdateLock(bag)
	if IsInventoryItemLocked(ContainerIDToInventoryID(bag:GetID())) then
		SetItemButtonDesaturated(bag, 1, 0.5, 0.5, 0.5)
	else
		SetItemButtonDesaturated(bag, nil)
	end
end

function BagnonBag_UpdateCursor(bag)
	if CursorCanGoInSlot(ContainerIDToInventoryID(bag:GetID())) then
		bag:LockHighlight()
	else
		bag:UnlockHighlight()
	end
end


--[[
	Update the texture and count of the bag
		Used mainly for cached bags
--]]
function BagnonBag_UpdateTexture(frame, bagID)
	local bag = getglobal(frame:GetName() .. "Bags" .. bagID)
	if not bag or bag:GetID() <= 0 then return end

	if Bagnon_IsCachedBag(frame.player, bagID) then
		local _, link, count = BagnonDB.GetBagData(frame.player, bagID)
		if link then
			local _, _, _, _, _, _, _, _, texture = GetItemInfo(link)
			SetItemButtonTexture(bag, texture)
		else
			SetItemButtonTexture(bag, nil)
		end
		if count then
			BagnonBag_SetCount(bag, count)
		end
	else
		local texture = GetInventoryItemTexture("player", ContainerIDToInventoryID(bagID))
		if texture then
			SetItemButtonTexture(bag, texture)
		else
			SetItemButtonTexture(bag, nil)
		end
		BagnonBag_SetCount(bag, GetInventoryItemCount("player", ContainerIDToInventoryID(bagID)))
	end
end

function BagnonBag_SetCount(button, count)
	if not button then return end
	if not count then count = 0 end

	button.count = count
	if count > 1 or (button.isBag and count > 0) then
		local countText = getglobal(button:GetName().."Count")
		if count > 9999 then
			countText:SetFont(NumberFontNormal:GetFont(), 10, "OUTLINE")
		elseif count > 999 then
			countText:SetFont(NumberFontNormal:GetFont(), 11, "OUTLINE")
		else
			countText:SetFont(NumberFontNormal:GetFont(), 12, "OUTLINE")
		end
		countText:SetText(count)
		countText:Show()
	else
		getglobal(button:GetName().."Count"):Hide()
	end
end

--[[ OnX Functions ]]--

function BagnonBag_OnLoad()
	this:RegisterForDrag("LeftButton")
	this:RegisterForClicks("LeftButtonUp", "RightButtonUp")
end

function BagnonBag_OnShow()
	BagnonBag_UpdateTexture(this:GetParent():GetParent(), this:GetID())
end

function BagnonBag_OnClick()
	if Bagnon_IsCachedBag(this:GetParent():GetParent().player, this:GetID()) then return end

	if not IsShiftKeyDown() then
		--damn you blizzard for making the keyring specific code!
		if this:GetID() == KEYRING_CONTAINER then
			PutKeyInKeyRing()
		elseif this:GetID() == 0 then
			PutItemInBackpack()
		else
			PutItemInBag(ContainerIDToInventoryID(this:GetID()))
		end
	else
		BagnonFrame_ToggleBag(this:GetParent():GetParent(), this:GetID())
	end
end

function BagnonBag_OnDrag()
	if Bagnon_IsCachedBag(this:GetParent():GetParent().player, this:GetID()) then return end

	PickupBagFromSlot(ContainerIDToInventoryID(this:GetID()))
	PlaySound("BAGMENUBUTTONPRESS")
end

--tooltip functions
function BagnonBag_OnEnter()
	local frame = this:GetParent():GetParent()

	BagnonFrame_HighlightSlots(frame, this:GetID())

	if this:GetLeft() < (UIParent:GetRight() / 2) then
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
	else
		GameTooltip:SetOwner(this, "ANCHOR_LEFT")
	end

	--mainmenubag specific code
	if this:GetID() == 0 then
		GameTooltip:SetText(TEXT(BACKPACK_TOOLTIP), 1, 1, 1)
	--keyring specific code...again
	elseif this:GetID() == KEYRING_CONTAINER then
		GameTooltip:SetText(KEYRING, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
	--cached bags
	elseif Bagnon_IsCachedBag(frame.player, this:GetID()) then
		local _, link = BagnonDB.GetBagData(frame.player, this:GetID())

		if link then
			GameTooltip:SetHyperlink(link)
			GameTooltip:Show()
		else
			GameTooltip:SetText(TEXT(EQUIP_CONTAINER), 1, 1, 1)
		end
	elseif not GameTooltip:SetInventoryItem("player", ContainerIDToInventoryID(this:GetID())) then
		GameTooltip:SetText(TEXT(EQUIP_CONTAINER), 1, 1, 1)
	end

	if not Bagnon_IsCachedBag(frame.player, this:GetID()) then
		--add the shift click to hide/show tooltip
		if BagnonSets.showTooltips then
			if Bagnon_FrameHasBag(frame:GetName(), this:GetID()) then
				GameTooltip:AddLine(BAGNON_BAGS_HIDE)
			else
				GameTooltip:AddLine(BAGNON_BAGS_SHOW)
			end
		end
	end
	GameTooltip:Show()
end

function BagnonBag_OnLeave()
	BagnonFrame_UnhighlightAll(this:GetParent():GetParent())
	GameTooltip:Hide()
end