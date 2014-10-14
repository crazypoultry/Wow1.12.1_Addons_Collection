--[[
	Banknon
		Combines the player's bank into a single frame
--]]

--[[ Loading Functions ]]--

function Banknon_OnLoad()
	--Create the confirmation dialog when purchasing a bank slot
	StaticPopupDialogs["CONFIRM_BUY_BANK_SLOT_BANKNON"] = {
		text = TEXT(CONFIRM_BUY_BANK_SLOT),
		button1 = TEXT(YES),
		button2 = TEXT(NO),

		OnAccept = function() PurchaseSlot() end,

		OnShow = function()
			MoneyFrame_Update(this:GetName().."MoneyFrame", GetBankSlotCost(GetNumBankSlots()))
		end,

		hasMoneyFrame = 1,
		timeout = 0,
		hideOnEscape = 1,
	}
	this:RegisterEvent("ADDON_LOADED")
end

--[[ Event Handler ]]--

function Banknon_OnEvent(event)
	if event == "PLAYER_MONEY" or event == "PLAYERBANKBAGSLOTS_CHANGED" then
		if this:IsShown() then
			Banknon_UpdateSlotCost()
		end
	elseif event == "BANKFRAME_OPENED" then
		if this:IsShown() then
			Banknon_UpdatePurchaseButtonVis()
		end
	elseif event == "BANKFRAME_CLOSED" then
		if this:IsShown() then
			BagnonFrame_Generate(this)
			Banknon_UpdatePurchaseButtonVis()
		end
	elseif event == "ADDON_LOADED" then
		if arg1 == "Banknon" then
			this:UnregisterEvent("ADDON_LOADED")
			Banknon_Load(this)
		end
	end
end

function Banknon_Load(frame)
	BagnonFrame_Load(frame, {-1, 5, 6, 7, 8, 9, 10}, BAGNON_BANK_TITLE)

	if CT_BankFrame_AcceptFrame then
		CT_BankFrame_AcceptFrame:SetParent(frame)
	end

	frame:RegisterEvent("PLAYER_MONEY")
	frame:RegisterEvent("PLAYERBANKBAGSLOTS_CHANGED")
	frame:RegisterEvent("BANKFRAME_OPENED")
	frame:RegisterEvent("BANKFRAME_CLOSED")

	Banknon_UpdateSlotCost()
end

--[[ UI Functions ]]--

--OnShow
function Banknon_OnShow()
	Banknon_UpdatePurchaseButtonVis()
	PlaySound("igMainMenuOpen")
end

--OnHide
function Banknon_OnHide()
	PlaySound("igMainMenuClose")
	if bgn_atBank then
		CloseBankFrame()
	end
end

--[[ Bank Slots functions ]]--

--Show/Hide the bag frame
function Banknon_ToggleSlots()
	if not BanknonBags:IsShown() then
		BanknonBags:Show()
		BagnonSets["Banknon"].bagsShown = 1
		this:SetText(BAGNON_HIDEBAGS)
	else
		BanknonBags:Hide()
		BagnonSets["Banknon"].bagsShown = nil
		this:SetText(BAGNON_SHOWBAGS)
	end

	Banknon_UpdatePurchaseButtonVis(not BagnonSets["Banknon"].bagsShown)
end

function Banknon_UpdateSlotCost()
	local cost = GetBankSlotCost(GetNumBankSlots())
	if GetMoney() >= cost then
		SetMoneyFrameColor("BanknonCost", 1.0, 1.0, 1.0)
	else
		SetMoneyFrameColor("BanknonCost", 1.0, 0.1, 0.1)
	end
	MoneyFrame_Update("BanknonCost", cost)

	Banknon_UpdatePurchaseButtonVis()
end

--yes, magic numbers are bad
function Banknon_UpdatePurchaseButtonVis(hide)
	if BanknonBags:IsVisible() or hide then
		local _, full = GetNumBankSlots()
		if bgn_atBank and not (full or hide) and (not Banknon.player or Banknon.player == UnitName("player")) then
			BanknonPurchase:Show()
			BanknonCost:Show()
			BanknonBags:SetHeight(68)
		else
			BanknonPurchase:Hide()
			BanknonCost:Hide()
			BanknonBags:SetHeight(42)
		end
	end
	BagnonFrame_TrimToSize(Banknon)
end