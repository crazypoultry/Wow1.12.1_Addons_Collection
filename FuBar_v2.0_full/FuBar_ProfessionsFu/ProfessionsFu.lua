local dewdrop = AceLibrary("Dewdrop-2.0")
local tablet = AceLibrary("Tablet-2.0")
local crayon = AceLibrary("Crayon-2.0")
local L = AceLibrary("AceLocale-2.1"):GetInstance("FuBar_ProfessionsFu", true)
local BS = AceLibrary("AceLocale-2.1"):GetInstance("Babble-Spell-2.1")
local BC = AceLibrary("AceLocale-2.1"):GetInstance("Babble-Class-2.1")

ProfessionsFu = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0", "FuBarPlugin-2.0")

ProfessionsFu.version = "2.0." .. string.sub("$Rev: 10573 $", 12, -3)
ProfessionsFu.date = string.sub("$Date: 2006-09-09 00:48:06 -0400 (Sat, 09 Sep 2006) $", 8, 17)
ProfessionsFu.hasIcon = "Interface\\Icons\\Ability_Repair"
ProfessionsFu.defaultPosition = "LEFT"

local defaults = {
	showLevel = true
}

function ProfessionsFu:OnInitialize()

    self:RegisterDB("ProfessionsFuDB")
    self:RegisterDefaults("profile", defaults)
    
    self.textValue = self:GetTitle()
    
end

function ProfessionsFu:OnEnable()
		self:RegisterEvent("VARIABLES_LOADED", "Update")
		self:RegisterEvent("SKILL_LINES_CHANGED", "Update")
	if (self.db.profile.showLevel) then
		self:RegisterEvent("CHARACTER_POINTS_CHANGED", "Update")
	end
end

function ProfessionsFu:OnDisable()
    self:UnregisterAllEvents()
end

function ProfessionsFu:SetProfession(clickedProfession, clickedIcon)
	self.textValue = clickedProfession
	self:UpdateText()
	self:SetIcon(clickedIcon)
	dewdrop:Close()
end

function ProfessionsFu:ToggleLevelDisplay()
	self.db.profile.showLevel = not self.db.profile.showLevel
	if not (self.db.profile.showLevel) then 
		self:UnregisterEvent("CHARACTER_POINTS_CHANGED", "Update")
	else
		self:RegisterEvent("CHARACTER_POINTS_CHANGED", "Update")
	end
	self:Update()
	return self.db.profile.showLevel
end	

function ProfessionsFu:UpdateText()
	self:SetText(crayon:White(self.textValue))
end

function ProfessionsFu:OnTooltipUpdate()
	if (self.db.profile.showLevel) then
	local cat = tablet:AddCategory(
			"columns", 2,
			"child_textR", 1,
			"child_textG", 1,
			"child_textB", 0,
			"child_text2R", 1,
			"child_text2G", 1,
			"child_text2B", 1
		)
	if (UnitClass("player") == BC["Rogue"]) then
		cat:AddLine("text", crayon:Green(BC["Rogue"]))
		cat:AddLine("text", BS["Poisons"], "text2", self.PoisonsLevel)
		cat:AddLine("text", BS["Lockpicking"], "text2", self.LockpickingLevel)
	end
	if (self.hasAlchemy or self.hasBlacksmithing or self.hasEnchanting or self.hasEngineering or self.hasHerbalism or self.hasJewelcrafting or self.hasLeatherworking or self.hasMining or self.hasSkinning or self.hasTailoring) then
		cat:AddLine("text", crayon:Green(L["Primary"]))
		if self.hasAlchemy then
			cat:AddLine("text", BS["Alchemy"], "text2", self.AlchemyLevel)
		end
		if self.hasBlacksmithing then
			cat:AddLine("text", BS["Blacksmithing"], "text2", self.BlacksmithingLevel)
		end
		if self.hasEnchanting then
			cat:AddLine("text", BS["Enchanting"], "text2", self.EnchantingLevel)
		end
		if self.hasEngineering then
			cat:AddLine("text", BS["Engineering"], "text2", self.EngineeringLevel)
		end
		if self.hasHerbalism then
			cat:AddLine("text", BS["Herbalism"], "text2", self.HerbalismLevel)
		end
		if self.hasJewelcrafting then
			cat:AddLine("text", BS["Jewelcrafting"], "text2", self.JewelcraftingLevel)
		end
		if self.hasLeatherworking then
			cat:AddLine("text", BS["Leatherworking"], "text2", self.LeatherworkingLevel)
		end
		if self.hasSkinning then
			cat:AddLine("text", BS["Skinning"], "text2", self.SkinningLevel)
		end
		if self.hasMining then
			cat:AddLine("text", BS["Mining"], "text2", self.MiningLevel)
		end
		if self.hasTailoring then
			cat:AddLine("text", BS["Tailoring"], "text2", self.TailoringLevel)
		end
	end
	if (self.hasCooking or self.hasFirstAid or self.hasFishing) then
		cat:AddLine("text", crayon:Green(L["Secondary"]))
		if self.hasCooking then
			cat:AddLine("text", BS["Cooking"], "text2", self.CookingLevel)
		end
		if self.hasFirstAid then
			cat:AddLine("text", BS["First Aid"], "text2", self.FirstAidLevel)
		end
		if self.hasFishing then
			cat:AddLine("text", BS["Fishing"], "text2", self.FishingLevel)
		end
	end
	end
	tablet:SetHint(L["Tip Hint"])
end

function ProfessionsFu:UpdateData()
    self:EnumProfessions()
end

function ProfessionsFu:OnClick()
	CastSpellByName(self.textValue)
end

function ProfessionsFu:EnumProfessions()
	self.hasAlchemy = false
	self.hasBlacksmithing = false
	self.hasCooking = false
	self.hasEnchanting = false
	self.hasEngineering = false
	self.hasFirstAid = false
	self.hasFishing = false
	self.hasHerbalism = false
	self.hasJewelcrafting = false
	self.hasLeatherworking = false
	self.hasLockpicking = false
	self.hasPoisons = false
	self.hasSkinning = false
	self.hasMining = false
	self.hasTailoring = false
	
	for i = 1, GetNumSkillLines() do
		local skillName, _, _, skillRank, _, _, skillMaxRank = GetSkillLineInfo(i)
		if (skillName == BS["Alchemy"]) then  
			self.hasAlchemy = true
			self.AlchemyLevel = skillRank.."/"..skillMaxRank
		end
		if (skillName == BS["Blacksmithing"]) then 
			self.hasBlacksmithing = true
			self.BlacksmithingLevel = skillRank.."/"..skillMaxRank
		end
		if (skillName == BS["Cooking"]) then  
			self.hasCooking = true
			self.CookingLevel = skillRank.."/"..skillMaxRank
		end
		if (skillName == BS["Enchanting"]) then  
			self.hasEnchanting = true
			self.EnchantingLevel = skillRank.."/"..skillMaxRank
		end
		if (skillName == BS["Engineering"]) then  
			self.hasEngineering = true
			self.EngineeringLevel = skillRank.."/"..skillMaxRank
		end
		if (skillName == BS["First Aid"]) then  
			self.hasFirstAid = true
			self.FirstAidLevel = skillRank.."/"..skillMaxRank
		end
		if (skillName == BS["Fishing"]) then  
			self.hasFishing = true
			self.FishingLevel = skillRank.."/"..skillMaxRank
		end
		if (skillName == BS["Herbalism"]) then  
			self.hasHerbalism = true
			self.HerbalismLevel = skillRank.."/"..skillMaxRank
		end
		if (skillName == BS["Jewelcrafting"]) then  
			self.hasJewelcrafting = true
			self.JewelcraftingLevel = skillRank.."/"..skillMaxRank
		end
		if (skillName == BS["Leatherworking"]) then  
			self.hasLeatherworking = true
			self.LeatherworkingLevel = skillRank.."/"..skillMaxRank
		end
		if (skillName == BS["Lockpicking"]) then  
			self.hasLockpicking = true
			self.LockpickingLevel = skillRank.."/"..skillMaxRank
		end
		if (skillName == BS["Poisons"]) then  
			self.hasPoisons = true
			self.PoisonsLevel = skillRank.."/"..skillMaxRank
		end
		if (skillName == BS["Skinning"]) then  
			self.hasSkinning = true
			self.SkinningLevel = skillRank.."/"..skillMaxRank
		end
		if (skillName == BS["Mining"]) then  
			self.hasMining = true
			self.MiningLevel = skillRank.."/"..skillMaxRank
		end
		if (skillName == BS["Tailoring"]) then  
			self.hasTailoring = true
			self.TailoringLevel = skillRank.."/"..skillMaxRank
		end
	end	
end

function ProfessionsFu:OnMenuRequest(level, value)
	if (self.hasAlchemy) then
	dewdrop:AddLine(
		"text", BS["Alchemy"],
		"func", function()
            CastSpellByName(BS["Alchemy"])
            self:SetProfession(BS["Alchemy"])
            BS:GetSpellIcon("Alchemy") end,
		"notcheckable", true
	)
	end
	if (self.hasBlacksmithing) then
	dewdrop:AddLine(
		"text", BS["Blacksmithing"],
		"func", function() CastSpellByName(BS["Blacksmithing"]); self:SetProfession(BS["Blacksmithing"]) BS:GetSpellIcon("Blacksmithing") end,
		"notcheckable", true
	)
	end
	if (self.hasCooking) then
	dewdrop:AddLine(
		"text", BS["Cooking"],
		"func", function() CastSpellByName(BS["Cooking"]); self:SetProfession(BS["Cooking"]) BS:GetSpellIcon("Cooking") end,
		"notcheckable", true
	)
	end
	if (self.hasEnchanting) then
	dewdrop:AddLine(
		"text", BS["Enchanting"],
		"func", function() CastSpellByName(BS["Enchanting"]); self:SetProfession(BS["Enchanting"]) BS:GetSpellIcon("Enchanting") end,
		"notcheckable", true
	)
	dewdrop:AddLine(
		"text", BS["Disenchant"],
		"func", function() CastSpellByName(BS["Disenchant"]); self:SetProfession(BS["Disenchant"]) BS:GetSpellIcon("Disenchant") end,
		"notcheckable", true
	)
	end
	if (self.hasEngineering) then
	dewdrop:AddLine(
		"text", BS["Engineering"],
		"func", function() CastSpellByName(BS["Engineering"]); self:SetProfession(BS["Engineering"]) BS:GetSpellIcon("Engineering") end,
		"notcheckable", true
	)
	end
	if (self.hasFirstAid) then
	dewdrop:AddLine(
		"text", BS["First Aid"],
		"func", function() CastSpellByName(BS["First Aid"]); self:SetProfession(BS["First Aid"]) BS:GetSpellIcon("First Aid") end,
		"notcheckable", true
	)
	end
	if (self.hasFishing) then
	dewdrop:AddLine(
		"text", BS["Fishing"],
		"func", function() CastSpellByName(BS["Fishing"]); self:SetProfession(BS["Fishing"]) BS:GetSpellIcon("Fishing") end,
		"notcheckable", true
	)
	end
	if (self.hasJewelcrafting) then
	dewdrop:AddLine(
		"text", BS["Jewelcrafting"],
		"func", function() CastSpellByName(BS["Jewelcrafting"]); self:SetProfession(BS["Jewelcrafting"]) BS:GetSpellIcon("Jewelcrafting") end,
		"notcheckable", true
	)
	end
	if (self.hasLeatherworking) then
	dewdrop:AddLine(
		"text", BS["Leatherworking"],
		"func", function() CastSpellByName(BS["Leatherworking"]); self:SetProfession(BS["Leatherworking"]) BS:GetSpellIcon("Leatherworking") end,
		"notcheckable", true
	)
	end
	if (self.hasLockpicking) then
	dewdrop:AddLine(
		"text", BS["Lockpicking"],
		"func", function() CastSpellByName(BS["Lockpicking"]); self:SetProfession(BS["Lockpicking"]) BS:GetSpellIcon("Lockpicking") end,
		"notcheckable", true
	)
	end
	if (self.hasPoisons) then
	dewdrop:AddLine(
		"text", BS["Poisons"],
		"func", function() CastSpellByName(BS["Poisons"]); self:SetProfession(BS["Poisons"]) BS:GetSpellIcon("Poisons") end,
		"notcheckable", true
	)
	end
	if (self.hasMining) then
	dewdrop:AddLine(
		"text", BS["Smelting"],
		"func", function() CastSpellByName(BS["Smelting"]); self:SetProfession(BS["Smelting"]) BS:GetSpellIcon("Smelting") end,
		"notcheckable", true
	)
	end
	if (self.hasTailoring) then
	dewdrop:AddLine(
		"text", BS["Tailoring"],
		"func", function() CastSpellByName(BS["Tailoring"]); self:SetProfession(BS["Tailoring"]) BS:GetSpellIcon("Tailoring") end,
		"notcheckable", true
	)
	end
	dewdrop:AddLine()
	dewdrop:AddLine(
		"text", L["Enhanced Tooltip"],
		"func", function() self:ToggleLevelDisplay() end,
		"checked", self.db.profile.showLevel
	)
end