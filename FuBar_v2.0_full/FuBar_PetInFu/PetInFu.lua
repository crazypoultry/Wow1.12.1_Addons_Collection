local tablet = AceLibrary("Tablet-2.0")

local L = AceLibrary("AceLocale-2.2"):new("PetInFu")

PetInFu = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0")

PetInFu.version = "2.0." .. string.sub("$Revision: 18195 $", 12, -3)
PetInFu.date = string.sub("$Date: 2006-11-27 12:02:58 -0500 (Mon, 27 Nov 2006) $", 8, 17)
PetInFu.hasIcon = L["DefaultIcon"]

function PetInFu:OnInitialize()
	PetInFu:RegisterDB("PetInFuDB")
	PetInFu:RegisterDefaults('profile', {
		toggleOnClick = false,
	})
	local optionsTable = {
		handler = PetInFu,
		type = 'group',
		args = {
			settings = {
				name = L["Settings"], desc = L["Configuration options"],
				type = 'group',
				args = {
					dismissOnClick = {
						name = L["Toggle on click"], desc = L["Toggle your pet by clicking on the panel"],
						type = 'toggle',
						get = function() return self.db.profile.toggleOnClick end,
						set = function(t) self.db.profile.toggleOnClick = t end,
					},
				},
			},
			dismiss = {
				name = L["Toggle pet"], desc = L["Summon/unsummon your pet"],
				type = 'execute', func = 'TogglePet',
			}
		},
	}
	PetInFu:RegisterChatCommand(L["ChatCommands"], optionsTable)
	PetInFu.OnMenuRequest = optionsTable
	_, self.playerclass = UnitClass('player')
end

function PetInFu:OnEnable()
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "Update")
	self:RegisterEvent("PLAYER_PET_CHANGED", "Update")
	self:RegisterEvent("UNIT_PET", "Update")
	self:RegisterEvent("UNIT_PET_EXPERIENCE", "Update")
	self:RegisterEvent("UNIT_PET_TRAINING_POINTS", "Update")
	self:RegisterEvent("UNIT_HAPPINESS", "Update")
end

function PetInFu:OnClick()
	if self.db.profile.toggleOnClick then
		self:TogglePet()
	end
end

function PetInFu:OnDataUpdate()
	local petIcon = GetPetIcon()
	if petIcon ~= nil then
		self:SetIcon(petIcon)
	end
end

function PetInFu:OnTooltipUpdate()
		if HasPetUI() then
			--local petSex = ""
			--if UnitSex("pet") == 2 then
			--	petSex = PETINFO_MENU_FEMALE;
			--else
			--	petSex = PETINFO_MENU_MALE;
			--end
			
			local cat = tablet:AddCategory(
				'columns', 2, text, L["Basics"],
				'child_textR', 0, 'child_textG', 1, 'child_textB', 0,
				'child_text2R', 1, 'child_text2G', 1, 'child_text2B', 0
			)
			cat:AddLine('text', L["Name"], 'text2', UnitName("pet"))
			cat:AddLine('text', L["Level"], 'text2', UnitLevel("pet"))
			
			if self:isHunter() then
				cat = tablet:AddCategory(
					'columns', 2, 'text', L["Hunter"],
					'child_textR', 0, 'child_textG', 1, 'child_textB', 0,
					'child_text2R', 1, 'child_text2G', 1, 'child_text2B', 0
				)
				cat:AddLine('text', L["Type"], 'text2', UnitCreatureFamily("pet"))
				--self.tooltip:AddDoubleLine(nil,self.loc.PETINFO_MENU_GENDER, petSex, 0, 1, 0, 1, 1, 0)
				cat:AddLine('text', L["Eats"], 'text2', BuildListString(GetPetFoodTypes()))
				cat:AddLine('text', L["Loyalty"], 'text2', GetPetLoyalty())
				cat:AddLine()
				
				local happiness, damagePercentage, loyaltyRate = GetPetHappiness()
				local happyText, loyaltyText = '', ''
				
				if happiness == 1 then
					happyText = L["Unhappy"]
				elseif happiness == 2 then
					happyText = L["Content"]
				elseif happiness == 3 then
					happyText = L["Happy"]
				end
				
				if loyaltyRate > 0 then
					loyaltyText = L["Gaining Loyalty"]
				else
					loyaltyText = L["Losing Loyalty"]
				end
				
				cat:AddLine('text', L["Happiness"], 'text2', happyText)
				cat:AddLine('text', L["Damage Percentage"], 'text2', damagePercentage.."%")
				cat:AddLine('text', L["Loyalty Rate"], 'text2', loyaltyText)
				
				local currentXP, totalXP = GetPetExperience()
				local toLevelXP = (totalXP - currentXP)
				local currentXPPercent = currentXP / totalXP * 100
				local toLevelXPPercent = toLevelXP / totalXP * 100
				
				cat:AddLine()
				
				cat:AddLine('text', L["Current XP"], 'text2', string.format("%d (%.1f%%)", currentXP, currentXPPercent))
				cat:AddLine('text', L["Needed XP"], 'text2', string.format("%d (%.1f%%)", toLevelXP, toLevelXPPercent))
				cat:AddLine('text', L["Total XP"], 'text2', totalXP)
				
				cat:AddLine()
				
				local totalTP, usedTP = GetPetTrainingPoints()
				local freeTP = totalTP - usedTP
				cat:AddLine('text', L["Training Points"], 'text2', freeTP)
			end
			
			-- Combat stats
			
			local atkSpeed = UnitAttackSpeed("pet")
			local lowDmg, hiDmg, offlowDmg, offhiDmg, posBuff, negBuff, percentMod = UnitDamage("pet")
			local listedDPS = (((lowDmg + hiDmg) * .5 + posBuff + negBuff) * percentMod) / atkSpeed
			
			cat = tablet:AddCategory(
				'columns', 2, text, L["Combat"],
				'child_textR', 0, 'child_textG', 1, 'child_textB', 0,
				'child_text2R', 1, 'child_text2G', 1, 'child_text2B', 0
			)
			cat:AddLine('text', L["Armor"], 'text2', UnitArmor("pet"))
			
			cat:AddLine('text', L["Attack Rating"], 'text2', UnitAttackBothHands("pet"))
			cat:AddLine('text', L["Attack Speed"], 'text2', string.format("%.2f", atkSpeed))
			cat:AddLine('text', L["Listed DPS"], 'text2', string.format("%.1f", listedDPS))
			--self.tooltip:AddDoubleLine(nil,self.loc.PETINFO_BUTTON_LABEL_DPS_ACTUAL, format(self.loc.PETINFO_DPS_FORMAT, actualDPS), 0, 1, 0, 1, 1, 0)
			
			local cat = tablet:AddCategory(
				'columns', 2, text, L["Stats"],
				'child_textR', 0, 'child_textG', 1, 'child_textB', 0,
				'child_text2R', 1, 'child_text2G', 1, 'child_text2B', 0
			)
			
			for i=1, NUM_PET_STATS, 1 do
				local attrbStr = TEXT(getglobal("SPELL_STAT"..(i-1).."_NAME"))..":"
				local baseStat, effectiveStat, posBuff, negBuff = UnitStat("pet", i)
				local r,g,b = 1,1,1
				
				if (posBuff ~= 0) or (negBuff ~= 0) then
					-- If there are any negative buffs then show the main number in red even if there are
					-- positive buffs. Otherwise show in green.
					if negBuff < 0 then
						r,g,b = 1,0,0
					else
						r,g,b = 0,1,0
					end
				end
				cat:AddLine('text', attrbStr, 'text2', effectiveStat, 'text2R', r, 'text2G', g, 'text2B', b)
			end
		else
			local cat = tablet:AddCategory('columns', 1, 'child_textR', 0, 'child_textG', 1, 'child_textB', 0)
			cat:AddLine('text', L["No pet"])
		end
		--tablet:SetHint(self.loc.TOOLTIP_HINT_TEXT)
end
	
function PetInFu:OnTextUpdate()
	if HasPetUI() then
		local happiness = GetPetHappiness()
		local happyColor = "%s:%d"
		if happiness == 1 then
			happyColor = "|c00ff0000%s:%d|r"
		elseif happiness == 2 then
			happyColor = "|c00ffffff%s:%d|r"
		elseif happiness == 3 then
			happyColor = "|c0000ff00%s:%d|r"
		end
		local petName = UnitName("pet")
		local petLevel = UnitLevel("pet")
		if petName ~= nil and petLevel ~= nil then
			if petName == UNKNOWNOBJECT then
				petName = L["Unknown"]
			end
			self:SetText(string.format(happyColor, petName, petLevel))
		else
			self:SetText(L["No pet"])
			self:SetIcon(L["DefaultIcon"])
		end
	else
		self:SetText(L["No pet"])
		self:SetIcon(L["DefaultIcon"])
	end
end

function PetInFu:isHunter()
	return self.playerclass == "HUNTER"
end

function PetInFu:isWarlock()
	return self.playerclass == "WARLOCK"
end

function PetInFu:TogglePet()
	if self:isHunter() then
		if HasPetUI() then
			CastSpellByName(L["Dismiss Pet"])
		else
			CastSpellByName(L["Call Pet"])
		end
	end
end
