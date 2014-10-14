--[[
	Events.lua
		The main event handler for Bagnon and Banknon.
		It controls when the frames update, and when and when they are not shown.

		The UI by default partially supports showing/hiding at the mailbox, and fully supports the inventory frame showing/hiding at a vendor.

		I've extended the behavior in the following ways:
			If a frame was previously shown by a user, it will not automatically close.
			The events of showing the bank, tradeskill, auction, and trading can also be set to open the inventory or bank windows.
--]]

bgn_atBank = nil --a flag for if the player is at the bank or not

--[[ Local Functions ]]--

local function ShouldUpdateBag(frame, bag)
	return (frame and frame:IsVisible() and Bagnon_FrameHasBag(frame:GetName(), bag))
end

local function OpenIF(frameName, condition)
	if condition then
		BagnonFrame_Open(frameName, 1)
		return true
	end
end

local function CloseIF(frameName, condition)
	if condition then
		BagnonFrame_Close(frameName, 1)
		return true
	end
end

--[[
	Taken from Blizzard's code
	Shows the normal bank frame
--]]
local function ShowBlizBank()
	BankFrameTitleText:SetText(UnitName("npc"))
	SetPortraitTexture(BankPortraitTexture,"npc")
	ShowUIPanel(BankFrame)
	if not BankFrame:IsVisible() then
		CloseBankFrame()
	end
	UpdateBagSlotStatus()
end

--[[ Variable Loading ]]--

local function LoadVariables()
	local currentVersion = GetAddOnMetadata("Bagnon_Core", "Version")
	if not BagnonSets then
		BagnonSets = {
			showBagsAtBank = 1,
			showBagsAtAH = 1,
			showBankAtBank = 1,
			showTooltips = 1,
			qualityBorders = 1,
			showForeverTooltips = 1,
			version = currentVersion,
		}
		BagnonMsg(BAGNON_INITIALIZED)
	elseif BagnonSets.version ~= currentVersion then
		BagnonSets.version = currentVersion
		BagnonMsg(format(BAGNON_UPDATED, currentVersion))
	end
end

local function HaveLocalizedInfo()
	local locale = GetLocale()
	return (locale == "enUS" or
			locale == "deDE" or
			locale == "frFR" or
			locale == "zhCN" or
			locale == "zhTW" or
			locale == "esES" or
			BagnonSets.noDebug)
end

--try and get localized names, so that its possible to do special bag coloring
local function ObtainLocalizedNames()
	local haveInfo = HaveLocalizedInfo()
	if not haveInfo then
		BagnonMsg("Obtaining localized data.  Please report the following to where you downloaded Bagnon from.")
		BagnonMsg(GetLocale())
	end

	--backpack
	local name, _, _, _, iType, subType = GetItemInfo(4500)
	if name then
		if not haveInfo then
			BagnonMsg("Backpack:  " .. (iType or "null") .. ", " .. (subType or "null"))
		end
		if iType then
			BAGNON_ITEMTYPE_CONTAINER = iType
			BAGNON_SUBTYPE_BAG = subType
		end
	end

	--ammo
	name, _, _, _, iType, subType = GetItemInfo(8218)
	if name then
		if not haveInfo then
			BagnonMsg("Ammo:  " .. (iType or "null") .. ", " .. (subType or "null"))
		end
		if iType then
			BAGNON_ITEMTYPE_QUIVER = iType
		end
	end

	--soul pouch
	name, _, _, _, iType, subType = GetItemInfo(21340)
	if name then
		if not haveInfo then
			BagnonMsg("Soul Bag:  " .. (iType or "null") .. ", " .. (subType or "null"))
		end
		if subType then
			BAGNON_SUBTYPE_SOULBAG = subType
		end
	end
end

local function Load(eventFrame)
	BankFrame:UnregisterEvent("BANKFRAME_OPENED")

	LoadVariables()
	ObtainLocalizedNames()

	Infield.AddRescaleAction(function()
		if Bagnon then
			BagnonFrame_Reposition(Bagnon)
		end
		if Banknon then
			BagnonFrame_Reposition(Banknon)
		end
	end)

	eventFrame:RegisterEvent("BAG_UPDATE")
	eventFrame:RegisterEvent("PLAYERBANKSLOTS_CHANGED")
	eventFrame:RegisterEvent("ITEM_LOCK_CHANGED")
	eventFrame:RegisterEvent("BAG_UPDATE_COOLDOWN")
	eventFrame:RegisterEvent("PLAYER_LEVEL_UP")
	eventFrame:RegisterEvent("BANKFRAME_OPENED")
	eventFrame:RegisterEvent("BANKFRAME_CLOSED")
	eventFrame:RegisterEvent("TRADE_SHOW")
	eventFrame:RegisterEvent("TRADE_CLOSED")
	eventFrame:RegisterEvent("TRADE_SKILL_SHOW")
	eventFrame:RegisterEvent("TRADE_SKILL_CLOSE")
	eventFrame:RegisterEvent("AUCTION_HOUSE_SHOW")
	eventFrame:RegisterEvent("AUCTION_HOUSE_CLOSED")
	eventFrame:RegisterEvent("MAIL_SHOW")
	eventFrame:RegisterEvent("MAIL_CLOSED")
	eventFrame:RegisterEvent("MERCHANT_SHOW")
	eventFrame:RegisterEvent("MERCHANT_CLOSED")
end

local function OnEvent()
	--[[ Events For Updating Items ]]--
	if event == "BAG_UPDATE" or event == "BAG_UPDATE_COOLDOWN" then
		if ShouldUpdateBag(Bagnon, arg1) then
			BagnonFrame_Update(Bagnon, arg1)
		elseif ShouldUpdateBag(Banknon, arg1) then
			BagnonFrame_Update(Banknon, arg1)
		end
	elseif event == "PLAYERBANKSLOTS_CHANGED" then
		if ShouldUpdateBag(Banknon, -1) then
			BagnonFrame_Update(Banknon, -1)
		end
	elseif event == "ITEM_LOCK_CHANGED" then
		if Bagnon and Bagnon:IsVisible() then
			BagnonFrame_UpdateLock(Bagnon)
		end
		if Banknon and Banknon:IsVisible() then
			BagnonFrame_UpdateLock(Banknon)
		end
	--the keyring's size changes based on the player's level
	elseif event == "PLAYER_LEVEL_UP" then
		if ShouldUpdateBag(Bagnon, KEYRING_CONTAINER) then
			BagnonFrame_Generate(Bagnon)
		end
	--[[ Events for Automatically Opening and Closing Frames ]]--
	elseif event == "BANKFRAME_OPENED" then
		bgn_atBank = true
		OpenIF("Bagnon", BagnonSets.showBagsAtBank)
		if not OpenIF("Banknon", BagnonSets.showBankAtBank) then
			ShowBlizBank()
		end
	elseif event == "BANKFRAME_CLOSED" then
		bgn_atBank = nil
		CloseIF("Bagnon", BagnonSets.showBagsAtBank)
		CloseIF("Banknon", BagnonSets.showBankAtBank)
	elseif event == "TRADE_SHOW" then
		OpenIF("Bagnon", BagnonSets.showBagsAtTrade)
		OpenIF("Banknon", BagnonSets.showBankAtTrade)
	elseif event == "TRADE_CLOSED" then
		CloseIF("Bagnon", BagnonSets.showBagsAtTrade)
		CloseIF("Banknon", BagnonSets.showBankAtTrade)
	elseif event == "TRADE_SKILL_SHOW" then
		OpenIF("Bagnon", BagnonSets.showBagsAtCraft)
		OpenIF("Banknon", BagnonSets.showBankAtCraft)
	elseif event == "TRADE_SKILL_CLOSE" then
		CloseIF("Bagnon", BagnonSets.showBagsAtCraft)
		CloseIF("Banknon", BagnonSets.showBankAtCraft)
	elseif event == "AUCTION_HOUSE_SHOW" then
		OpenIF("Bagnon", BagnonSets.showBagsAtAH)
		OpenIF("Banknon", BagnonSets.showBankAtAH)
	elseif event == "AUCTION_HOUSE_CLOSED" then
		CloseIF("Bagnon", BagnonSets.showBagsAtAH)
		CloseIF("Banknon", BagnonSets.showBankAtAH)
	elseif event == "MAIL_SHOW" then
		OpenIF("Banknon", BagnonSets.showBankAtMail)
	elseif event == "MAIL_CLOSED" then
		CloseIF("Bagnon", true)
		CloseIF("Banknon", BagnonSets.showBankAtMail)
	elseif event == "MERCHANT_SHOW" then
		OpenIF("Banknon", BagnonSets.showBankAtVendor)
	elseif event == "MERCHANT_CLOSED" then
		CloseIF("Banknon", BagnonSets.showBankAtVendor)
	--Loading event
	elseif event == "ADDON_LOADED" and arg1 == "Bagnon_Core" then
		this:UnregisterEvent("ADDON_LOADED")
		Load(this)
	end
end

--create the event handler frame
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:SetScript("OnEvent", OnEvent)
eventFrame:Hide()