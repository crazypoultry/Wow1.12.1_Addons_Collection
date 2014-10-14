local L = AceLibrary("AceLocale-2.2"):new("NinjutFu")
local crayon = AceLibrary("Crayon-2.0")

NinjutFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceDB-2.0", "AceEvent-2.0")
NinjutFu.hasIcon = "Interface\\Icons\\Ability_Vanish"
NinjutFu.itemCounts = {}

NinjutFu:RegisterDB("NinjutFuDB")
NinjutFu:RegisterDefaults("profile", {
	threshCount = 20,
	blindCount = 20,
	teaCount = 10,
	buyFlash = true,
	showFlash = true,
	showBlind = true,
	showTea = true,
	compactMode = false,
	showTipPowders = true,
	showTipTea = true,
	showTipPoisons = true,
	showTipTitles = true,
	highend = false,
})


function NinjutFu:OnInitialize()
end

function NinjutFu:OnEnable()
	self.itemCounts = {}
	self.itemCounts[L["Flash Powder"]] = 0
	self.itemCounts[L["Blinding Powder"]] = 0
	self.itemCounts[L["Thistle Tea"]] = 0
	self.itemCounts[L["Crippling Poison"]] = 0
	self.itemCounts[L["Crippling Poison II"]] = 0
	self.itemCounts[L["Deadly Poison IV"]] = 0
	self.itemCounts[L["Deadly Poison V"]] = 0
	self.itemCounts[L["Instant Poison VI"]] = 0
	self.itemCounts[L["Mind-numbing Poison III"]] = 0
	self.itemCounts[L["Wound Poison IV"]] = 0
	self.itemCounts[L["Dense Sharpening Stone"]] = 0
	self.itemCounts[L["Consecrated Sharpening Stone"]] = 0
	self.itemCounts[L["Elemental Sharpening Stone"]] = 0
	self.itemCounts[L["Dense Weightstone"]] = 0

	self:SetHighend()
	self:SetHighendMenu()

	self:RegisterBucketEvent("BAG_UPDATE", 0.5, "Update")
	self:RegisterEvent("MERCHANT_SHOW", "RefillFlash")
end

function NinjutFu:OnDisable()
	self.itemCounts = nil
end

function NinjutFu:SetHighend()
	if (self.db.profile.highend) then
		self.itemCounts[L["Deadly Poison"]] = nil
		self.itemCounts[L["Deadly Poison II"]] = nil
		self.itemCounts[L["Deadly Poison III"]] = nil
		self.itemCounts[L["Instant Poison"]] = nil
		self.itemCounts[L["Instant Poison II"]] = nil
		self.itemCounts[L["Instant Poison III"]] = nil
		self.itemCounts[L["Instant Poison IV"]] = nil
		self.itemCounts[L["Instant Poison V"]] = nil
		self.itemCounts[L["Mind-numbing Poison"]] = nil
		self.itemCounts[L["Mind-numbing Poison II"]] = nil
		self.itemCounts[L["Wound Poison"]] = nil
		self.itemCounts[L["Wound Poison II"]] = nil
		self.itemCounts[L["Wound Poison III"]] = nil
		self.itemCounts[L["Rough Sharpening Stone"]] = nil
		self.itemCounts[L["Coarse Sharpening Stone"]] = nil
		self.itemCounts[L["Heavy Sharpening Stone"]] = nil
		self.itemCounts[L["Solid Sharpening Stone"]] = nil
		self.itemCounts[L["Rough Weightstone"]] = nil
		self.itemCounts[L["Coarse Weightstone"]] = nil
		self.itemCounts[L["Heavy Weightstone"]] = nil
		self.itemCounts[L["Solid Weightstone"]] = nil
	else
		self.itemCounts[L["Deadly Poison"]] = 0
		self.itemCounts[L["Deadly Poison II"]] = 0
		self.itemCounts[L["Deadly Poison III"]] = 0
		self.itemCounts[L["Instant Poison"]] = 0
		self.itemCounts[L["Instant Poison II"]] = 0
		self.itemCounts[L["Instant Poison III"]] = 0
		self.itemCounts[L["Instant Poison IV"]] = 0
		self.itemCounts[L["Instant Poison V"]] = 0
		self.itemCounts[L["Mind-numbing Poison"]] = 0
		self.itemCounts[L["Mind-numbing Poison II"]] = 0
		self.itemCounts[L["Wound Poison"]] = 0
		self.itemCounts[L["Wound Poison II"]] = 0
		self.itemCounts[L["Wound Poison III"]] = 0
		self.itemCounts[L["Rough Sharpening Stone"]] = 0
		self.itemCounts[L["Coarse Sharpening Stone"]] = 0
		self.itemCounts[L["Heavy Sharpening Stone"]] = 0
		self.itemCounts[L["Solid Sharpening Stone"]] = 0
		self.itemCounts[L["Rough Weightstone"]] = 0
		self.itemCounts[L["Coarse Weightstone"]] = 0
		self.itemCounts[L["Heavy Weightstone"]] = 0
		self.itemCounts[L["Solid Weightstone"]] = 0
	end
end

function NinjutFu:OnDataUpdate()
	self:CountItems()
end

function NinjutFu:OnTextUpdate()
	local barText = self:GetTitle()

	local notFirst = false
	local seperator = self.db.profile.compactMode and "/" or " "

	if (self.db.profile.showFlash) then
		barText = self:Textify(self.itemCounts["Flash Powder"], "F", self.db.profile.threshCount)
		notFirst = true
	end
	if (self.db.profile.showBlind) then
		if (notFirst) then
			barText = barText .. seperator .. self:Textify(self.itemCounts["Blinding Powder"], "B", 20)
		else
			barText = self:Textify(self.itemCounts["Blinding Powder"], "B", 20)
			notFirst = true
		end
	end
	if (self.db.profile.showTea) then
		if (notFirst) then
			barText = barText .. seperator .. self:Textify(self.itemCounts["Thistle Tea"], "T", 10)
		else
			barText = self:Textify(self.itemCounts["Thistle Tea"], "T", 10)
		end
	end

	self:SetText(barText)
end

function NinjutFu:Textify(count, powder, stacksize)
	if (self.db.profile.compactMode) then
		return self:Colorize(count, stacksize)
	else
		return self:Colorize(count, stacksize) .. powder
	end
end

function NinjutFu:Colorize(count, stacksize)
	return crayon:Colorize(crayon:GetThresholdHexColor(count, stacksize/4, stacksize/2, stacksize*0.65, stacksize*0.8, stacksize*0.95), count)
end

function NinjutFu:OnClick()
	if IsControlKeyDown() then
		CastSpellByName(L["PoisonsTS"])
	else
		CastSpellByName(L["Pick Lock"])
	end
end

function NinjutFu:CountItems()
	local name, count

	for name in pairs(self.itemCounts) do
		self.itemCounts[name] = 0
	end


	for i = NUM_BAG_FRAMES, 0, -1 do
		for j = GetContainerNumSlots(i), 1, -1 do
			name = self:GetItemName(i, j)
			if (self.itemCounts[name]) then
				_, count = GetContainerItemInfo(i, j)
				self.itemCounts[name] = self.itemCounts[name] + count
			end
		end
	end
end

function NinjutFu:GetItemName(bag, slot)
	local linktext = GetContainerItemLink(bag, slot)
	if linktext then
		local _,_,name = string.find(linktext, "^.*%[(.*)%].*$")
		return name
	else
		return ""
	end
end

function NinjutFu:UseByName(item)
	local itemname
	for i=0, NUM_BAG_FRAMES do
		for j=1, GetContainerNumSlots(i) do
			itemname = self:GetItemName(i,j)
			if itemname == item then
				UseContainerItem(i,j)
			end
		end
	end
end

function NinjutFu:ApplyPoison(poison, slot)
	self:UseByName(poison)
	PickupInventoryItem(slot)
	EquipCursorItem(slot)
end


function NinjutFu:RefillFlash()
	if (self.db.profile.buyFlash) then
		local numItems = GetMerchantNumItems()
		local currentCount = self.itemCounts[L["Flash Powder"]]
		local diff = self.db.profile.threshCount - currentCount
		if (diff > 0) then
			local link, name
			for i=0, numItems do
				link = GetMerchantItemLink(i)
				if (link) then
					_,_,name = string.find(link, "^.*%[(.*)%].*$")
					if (strfind(name, L["Flash Powder"])) then
						while (diff > 20) do
							BuyMerchantItem(i, 20)
							diff = diff - 20
						end
						BuyMerchantItem(i, diff)
					end
				end
			end
		end
	end
end
