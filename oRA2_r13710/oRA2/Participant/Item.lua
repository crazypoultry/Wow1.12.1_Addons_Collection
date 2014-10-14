
assert( oRA, "oRA not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.0"):new("oRAPItem")

-- DO NOT translate these, use the locale tables below
local reagents = {
	["PRIEST"] = "SacredCandle",
	["MAGE"] = "ArcanePowder",
	["DRUID"] = "WildThornroot",
	["WARLOCK"] = "SoulShard",
	["SHAMAN"] = "Ankh",
	["PALADIN"] = "SymbolofDivinity",
	["ROGUE"] = "FlashPowder",
}

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["itemparticipant"] = true,
	["item"] = true,
	["Options for item checks."] = true,
	["SacredCandle"] = "Sacred Candle",
	["ArcanePowder"] = "Arcane Powder",
	["WildThornroot"] = "Wild Thornroot",
	["Ankh"] = "Ankh",
	["SoulShard"] = "Soul Shard",
	["SymbolofDivinity"] = "Symbol of Divinity",
	["FlashPowder"] = "Flash Powder",
	["Participant/Item"] = true,
} end )

L:RegisterTranslations("koKR", function() return {
--	["itemparticipant"] = "아이템부분",
--	["item"] = "아이템",

	["Options for item checks."] = "아이템 확인 설정",
	["SacredCandle"] = "성스러운 양초",
	["ArcanePowder"] = "불가사의한 가루",
	["WildThornroot"] = "야생 가시",
	["Ankh"] = "십자가",
	["SoulShard"] = "영혼의 조각",
	["SymbolofDivinity"] = "신앙의 징표",
	["FlashPowder"] = "섬광 화약",
	["Participant/Item"] = "부분/아이템",
} end )

L:RegisterTranslations("zhCN", function() return {
	["itemparticipant"] = "itemparticipant",
	["item"] = "物品",
	["Options for item checks."] = "物品检查选项",
	["SacredCandle"] = "神圣蜡烛",
	["ArcanePowder"] = "魔粉",
	["WildThornroot"] = "野生荆根草",
	["Ankh"] = "十字章",
	["SoulShard"] = "灵魂碎片",
	["SymbolofDivinity"] = "神圣符印",
	["FlashPowder"] = "闪光粉",
	["Participant/Item"] = "Participant/Item",
} end )

L:RegisterTranslations("deDE", function() return {
	["SacredCandle"] = "Hochheilige Kerze",
	["ArcanePowder"] = "Arkanes Pulver",
	["WildThornroot"] = "Wilder Dornwurz",
	["Ankh"] = "Ankh",
	["SymbolofDivinity"] = "Symbol der Offenbarung",
	["FlashPowder"] = "Blitzstrahlpulver",
	["SoulShard"] = "Seelensplitter",
} end )

L:RegisterTranslations("frFR", function() return {
	["SacredCandle"] = "Bougie sacr\195\169e",
	["ArcanePowder"] = "Poudre des arcanes",
	["WildThornroot"] = "Ronceterre sauvage",
	["Ankh"] = "Ankh",
	["SoulShard"] = "Fragment d'\195\162me",
	["SymbolofDivinity"] = "Symbole de divinit\195\169",
	["FlashPowder"] = "Poudre aveuglante",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

oRAPItem = oRA:NewModule(L["itemparticipant"])
oRAPItem.defaults = {
}
oRAPItem.participant = true
oRAPItem.name = L["Participant/Item"]
-- oRAPItem.consoleCmd = L"item"
-- oRAPItem.consoleOptions = {
-- 	type = "group",
-- 	desc = L"Options for item checks.",
-- 	args = {
--	}
-- }

------------------------------
--      Initialization      --
------------------------------

function oRAPItem:OnInitialize()
	self.debugFrame = ChatFrame5
end

function oRAPItem:OnEnable()
	self:RegisterCheck("ITMC", "oRA_ItemCheck")
	self:RegisterCheck("REAC", "oRA_ReagentCheck")
end

function oRAPItem:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterCheck("ITMC")
	self:UnregisterCheck("REAC")
end


-------------------------
--   Event Handlers    --
-------------------------

function oRAPItem:oRA_ItemCheck( msg, author)
	if not self:IsValidRequest(author) then return end
	msg = self:CleanMessage(msg)
	local _, _, itemname = string.find(msg, "^ITMC (.+)$")
	if itemname then
		local numitems = self:GetItems(itemname)
		if numitems and numitems > 0 then
			self:SendMessage("ITM "..numitems.." "..itemname.." "..author)
		end
	end

end

function oRAPItem:oRA_ReagentCheck(msg, author)
	if not self:IsValidRequest(author) then return end
	msg = self:CleanMessage(msg)
	local numitems = self:GetReagents()
	if numitems and numitems > 0 then
		self:SendMessage("REA " .. numitems .. " " .. author )
	end
end


-------------------------
--  Utility Functions  --
-------------------------

function oRAPItem:GetItems( itemname )
	local numitems = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag)
		if size > 0 then
			for slot=1, size, 1 do
				local ilink = GetContainerItemLink(bag,slot)
				if ilink then
					local _, _, name = string.find(ilink, "%[(.+)%]")
					
					if string.find(name, itemname) then
						local _, itemcount, _, _, _ = GetContainerItemInfo(bag,slot)
						numitems = numitems + itemcount
					end
				end
			end
		end
	end
	return numitems
end

function oRAPItem:GetReagents()
	local numitems = -1
	if UnitClass("player") then
		local _,class = UnitClass("player")
		if reagents[class] then
			numitems = self:GetItems( L(reagents[class]) )
		end
	end
	return numitems
end
