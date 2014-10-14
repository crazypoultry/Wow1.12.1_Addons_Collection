ReagentFu = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "FuBarPlugin-2.0")

local L = AceLibrary("AceLocale-2.2"):new("ReagentFu");
local dewdrop = AceLibrary("Dewdrop-2.0");
local tablet = AceLibrary("Tablet-2.0");
local crayon = AceLibrary("Crayon-2.0");

local playerClass = nil;
local reagentCount = {};
local fullCount = {
		["Rune of Portals"] = 10,
		["Rune of Teleportation"] = 10,
		["Thistle Tea"] = 10,
		["Ankh"] = 5,
		["Soul Shard"] = 10,
		["Soulstone"] = 1,
		["Healthstone"] = 1,
		["Firestone"] = 1,
		["Spellstone"] = 1,
		["Infernal Stone"] = 5
	};

ReagentFu.hasIcon = "Interface\\Icons\\INV_Misc_Book_09"
ReagentFu.defaultPosition = "LEFT"

ReagentFu:RegisterDB("ReagentFuDB", "ReagentFuCharDB")
ReagentFu:RegisterDefaults("profile", {
	showShortNames = false,
});
ReagentFu:RegisterDefaults("char", {
	showReagent = {},
});

local options = {
    type='group',
    args = {
		shortnames = {
			type = "toggle",
			name = L["Show short names"],
			desc = L["Show short reagent names in FuBar text"],
			get = function() return ReagentFu.db.profile.showShortNames end,
			set = function()
				ReagentFu.db.profile.showShortNames = not ReagentFu.db.profile.showShortNames
				ReagentFu:Update()
			end,
		},
	}
}

	-- Methods
function ReagentFu:IsShowingShortNames()
	return self.db.profile.showShortNames
end

function ReagentFu:ToggleShowingShortNames()
	self.db.profile.showShortNames = not self.db.profile.showShortNames
	self:Update()
	return self.db.profile.showShortNames
end

function ReagentFu:IsShowing(reagent)
	return self.db.char.showReagent[reagent]
end

function ReagentFu:ToggleShowing(reagent)
	self.db.char.showReagent[reagent] = not self.db.char.showReagent[reagent]
	self:Update()
	return self.db.char.showReagent[reagent]
end

function ReagentFu:OnInitialize()
	_,playerClass = UnitClass("player")
	if playerClass == "DRUID" then
		if self.db.char.showReagent[L["Wild Berries"]] == nil then
			self.db.char.showReagent[L["Wild Berries"]] = true
		end
		if self.db.char.showReagent[L["Wild Thornroot"]] == nil then
			self.db.char.showReagent[L["Wild Thornroot"]] = true
		end
		if self.db.char.showReagent[L["Maple Seed"]] == nil then
			self.db.char.showReagent[L["Maple Seed"]] = true
		end
		if self.db.char.showReagent[L["Stranglethorn Seed"]] == nil then
			self.db.char.showReagent[L["Stranglethorn Seed"]] = true
		end
		if self.db.char.showReagent[L["Ashwood Seed"]] == nil then
			self.db.char.showReagent[L["Ashwood Seed"]] = true
		end
		if self.db.char.showReagent[L["Hornbeam Seed"]] == nil then
			self.db.char.showReagent[L["Hornbeam Seed"]] = true
		end
		if self.db.char.showReagent[L["Ironwood Seed"]] == nil then
			self.db.char.showReagent[L["Ironwood Seed"]] = true
		end
	elseif playerClass == "MAGE" then
		if self.db.char.showReagent[L["Arcane Powder"]] == nil then
			self.db.char.showReagent[L["Arcane Powder"]] = true
		end
		if self.db.char.showReagent[L["Rune of Teleportation"]] == nil then
			self.db.char.showReagent[L["Rune of Teleportation"]] = true
		end
		if self.db.char.showReagent[L["Rune of Portals"]] == nil then
			self.db.char.showReagent[L["Rune of Portals"]] = true
		end
		if self.db.char.showReagent[L["Light Feather"]] == nil then
			self.db.char.showReagent[L["Light Feather"]] = true
		end
	elseif playerClass == "PALADIN" then
		if self.db.char.showReagent[L["Symbol of Divinity"]] == nil then
			self.db.char.showReagent[L["Symbol of Divinity"]] = true
		end
		if self.db.char.showReagent[L["Symbol of Kings"]] == nil then
			self.db.char.showReagent[L["Symbol of Kings"]] = true
		end
	elseif playerClass == "PRIEST" then
		if self.db.char.showReagent[L["Holy Candle"]] == nil then
			self.db.char.showReagent[L["Holy Candle"]] = true
		end
		if self.db.char.showReagent[L["Sacred Candle"]] == nil then
			self.db.char.showReagent[L["Sacred Candle"]] = true
		end
		if self.db.char.showReagent[L["Light Feather"]] == nil then
			self.db.char.showReagent[L["Light Feather"]] = true
		end
	elseif playerClass == "ROGUE" then
		if self.db.char.showReagent[L["Flash Powder"]] == nil then
			self.db.char.showReagent[L["Flash Powder"]] = true
		end
		if self.db.char.showReagent[L["Blinding Powder"]] == nil then
			self.db.char.showReagent[L["Blinding Powder"]] = true
		end
		if self.db.char.showReagent[L["Thistle Tea"]] == nil then
			self.db.char.showReagent[L["Thistle Tea"]] = true
		end
		if self.db.char.showReagent[L["Instant Poison"]] == nil then
			self.db.char.showReagent[L["Instant Poison"]] = true
		end
		if self.db.char.showReagent[L["Deadly Poison"]] == nil then
			self.db.char.showReagent[L["Deadly Poison"]] = true
		end
		if self.db.char.showReagent[L["Crippling Poison"]] == nil then
			self.db.char.showReagent[L["Crippling Poison"]] = true
		end
		if self.db.char.showReagent[L["Mind-numbing Poison"]] == nil then
			self.db.char.showReagent[L["Mind-numbing Poison"]] = true
		end
		if self.db.char.showReagent[L["Wound Poison"]] == nil then
			self.db.char.showReagent[L["Wound Poison"]] = true
		end
	elseif playerClass == "SHAMAN" then
		if self.db.char.showReagent[L["Ankh"]] == nil then
			self.db.char.showReagent[L["Ankh"]] = true
		end
		if self.db.char.showReagent[L["Shiny Fish Scales"]] == nil then
			self.db.char.showReagent[L["Shiny Fish Scales"]] = true
		end
		if self.db.char.showReagent[L["Fish Oil"]] == nil then
			self.db.char.showReagent[L["Fish Oil"]] = true
		end
	elseif playerClass == "WARLOCK" then
		if self.db.char.showReagent[L["Soul Shard"]] == nil then
			self.db.char.showReagent[L["Soul Shard"]] = true
		end
		if self.db.char.showReagent[L["Healthstone"]] == nil then
			self.db.char.showReagent[L["Healthstone"]] = true
		end
		if self.db.char.showReagent[L["Soulstone"]] == nil then
			self.db.char.showReagent[L["Soulstone"]] = true
		end
		if self.db.char.showReagent[L["Spellstone"]] == nil then
			self.db.char.showReagent[L["Spellstone"]] = true
		end
		if self.db.char.showReagent[L["Firestone"]] == nil then
			self.db.char.showReagent[L["Firestone"]] = true
		end
		if self.db.char.showReagent[L["Infernal Stone"]] == nil then
			self.db.char.showReagent[L["Infernal Stone"]] = true
		end
	else
		self:Hide()
	end
	self.countValues = {}
end

function ReagentFu:OnEnable()
	if (playerClass == "DRUID") then
		self:SetIcon("Interface\\Icons\\INV_Misc_Branch_01")
	elseif (playerClass == "MAGE") then
		self:SetIcon("Interface\\Icons\\INV_Misc_Dust_01")
	elseif (playerClass == "PALADIN") then
		self:SetIcon("Interface\\Icons\\INV_Stone_WeightStone_05")
	elseif (playerClass == "PRIEST") then
		self:SetIcon("Interface\\Icons\\INV_Misc_Candle_03")
	elseif (playerClass == "ROGUE") then
		self:SetIcon("Interface\\Icons\\INV_Misc_Powder_Purple")
	elseif (playerClass == "SHAMAN") then
		self:SetIcon("Interface\\Icons\\INV_Jewelry_Talisman_06")
	elseif (playerClass == "WARLOCK") then
		self:SetIcon("Interface\\Icons\\INV_Misc_Gem_Amethyst_02")
	else
		self:SetIcon("Interface\\Icons\\INV_Misc_Book_09")
	end
	self:RegisterBucketEvent("BAG_UPDATE", 1, "Update")
end

function ReagentFu:OnMenuRequest(level, value, inTooltip)
	if level == 1 then
		dewdrop:AddLine(
			'text', L["Show short names"],
			'func', "ToggleShowingShortNames",
			'arg1', self,
			'checked', self:IsShowingShortNames(),
			'closeWhenClicked', false
		)
		
		dewdrop:AddLine()

		dewdrop:AddLine(
			'text', L["Reagents"],
			'hasArrow', true,
			'value', "filter"
		)

		dewdrop:AddLine()

	elseif level == 2 then
		if value == "filter" then
			for reagent, t in pairs(self.db.char.showReagent) do
				dewdrop:AddLine(
					'text', reagent,
					'func', "ToggleShowing",
					'arg1', self,
					'arg2', reagent,
					'checked', t
				)
			end
		end
	end
end

function ReagentFu:OnDataUpdate()
	self:GetReagentCount();
end

function ReagentFu:OnTextUpdate()
	local reverse;
	local count_string = "";
	local itemcount = 0;
	local maxcount;
	if (playerClass ~= "ROGUE") then
		for k, v in pairs(reagentCount) do
			if (v ~= nil) then
				reverse = L:GetReverseTranslation(k)
				if (count_string ~= "") then
					count_string = count_string.."/"
				end
				if self:IsShowingShortNames() then
					count_string = count_string..L[reverse .. ".SHORT"]
				end
				maxcount = fullCount[reverse]
				if maxcount == nil then maxcount = 20 end
				count_string = count_string..format("|cff%s%d|r", crayon:GetThresholdHexColor(v / maxcount), v)
			end
		end
	else
		local poisonCount = 0
		for k, v in pairs(reagentCount) do
			if v ~= nil then
				if	k == L["Instant Poison"] or
					k == L["Deadly Poison"] or
					k == L["Crippling Poison"] or
					k == L["Mind-numbing Poison"] or
					k == L["Wound Poison"] then
					poisonCount = poisonCount + v
				else
					reverse = L:GetReverseTranslation(k)
					maxcount = fullCount[reverse]
					if maxcount == nil then maxcount = 20 end
					if count_string ~= "" then
						count_string = count_string.."/"
					end
					if self:IsShowingShortNames() then
						count_string = count_string .. L[reverse .. ".SHORT"]
					end
					count_string = count_string..format("|cff%s%d|r", crayon:GetThresholdHexColor(v / maxcount), v)
				end
			end
		end

		if count_string ~= "" then
			count_string = count_string.."/"
		end
		if self:IsShowingShortNames() then
			count_string = count_string .. L["Poison: "]
		end
		count_string = count_string..format("|cff%s%d|r", crayon:GetThresholdHexColor(poisonCount / 10), poisonCount)
	end
	
	self:SetText(count_string)
end

function ReagentFu:OnTooltipUpdate()
	local cat = tablet:AddCategory(
		"columns", 2,
		"child_textR", 0, 
		"child_textG", 1,
		"child_textB", 0,
		"showWithoutChildren", false
	)
	local r, g, b;
	local itemcount = 0;
	local maxcount;
	for k, v in pairs(reagentCount) do
		if v ~= nil then
			maxcount = fullCount[L:GetReverseTranslation(k)]
			if maxcount == nil then maxcount = 20 end
			r, g, b = crayon:GetThresholdColor(v / maxcount)
			cat:AddLine("text", k, "text2", v, "text2R", r, "text2G", g, "text2B", b)
		end
	end
end

function ReagentFu:GetReagentCount()
	for reagent, active in pairs(self.db.char.showReagent) do
		reagentCount[reagent] = 0
	end
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot = 1, size, 1 do
				local _,itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = self:NameFromLink(GetContainerItemLink(bag, slot));
					if ((itemName) and (itemName ~= "")) then
						for reagent, active in pairs(self.db.char.showReagent) do
							if active then
								if reagent == itemName or string.find(itemName, reagent, 1, true) then
									reagentCount[reagent] = reagentCount[reagent] + itemCount
								end
							else
								reagentCount[reagent] = nil
							end
						end
					end
				end
			end
		end
	end
end

function ReagentFu:NameFromLink(link)
	if (link) then
		if (string.find(GetBuildInfo(), "^2%.")) then
			return GetItemInfo(link)
		else
			return GetItemInfo(tonumber(string.gsub(link, "|cff%x%x%x%x%x%x|Hitem:(%d+):%d+:%d+:%d+|h.*", "%1") or 0))
		end
	end
end
