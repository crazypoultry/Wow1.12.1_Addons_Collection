--[[

Name: DakSmak
Revision: $Rev: 0.7.6. $
Date:  $Date: $
Author:  Daklu
Description: A FuBar plugin designed to display combat tables for the player and player's target.
First Tier Dependencies:  AceLibrary-2.0, AceAddon-2.0, AceLocale-2.2, AceDebug-2.0, AceConsole-2.0, 
	AceEvent-2.0, AceDB-2.0, Tablet-2.0, ItemBonusLib-1.0
Second Tier Dependencies:  AceOO, FuBarPlugin, DewDrop, Gratuity, Deformat
Download:  www.wowinterface.com
AceLibrary, AceOO, AceLocale, AceAddon, AceConsole, AceDebug,
	AceEvent, Tablet, 

]]

DakSmak = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0",
										 "AceDebug-2.0",
										 "AceConsole-2.0",
										 "AceEvent-2.0",
										 "AceDB-2.0"
)

-- Localization support, tablet to display the tables, and BonusItems library instance
local L = AceLibrary("AceLocale-2.2"):new("DakSmak")
local tablet = AceLibrary("Tablet-2.0")
--local ItemBonus = AceLibrary("ItemBonusLib-1.0")


-- PLAYER and TARGET structures to hold important player & target information
local player = {unitID = L["player"]}
local target = {unitID = L["target"]}

-- Table to hold localized text constants
local cText = {}


DakSmak.hasIcon = "Interface\\Icons\\Ability_Warrior_Challange.blp"
DakSmak:SetDebugging(false)

DakSmak:RegisterDB("DakSmakDB", "DakSmakPCDB")
DakSmak:RegisterDefaults("profile", {
	showShortText = false,
	showSummary = false,
	isHorizontal = false,
	showIcon = true,
	showTitle = true,
	}
)

-- Sets up right click menu.  
RightClickOptions = {
	type = 'group',
	args = {
		shtText = {
			type = "toggle",
			name = "Short text",
			desc = "Use abbreviated text in the combat tables",
			get = "IsShortText",
			set = "ToggleShortText",
		},
		summary = {
			type = "toggle",
			name = "Summarize table",
			desc = "Display only total chance to make contact and total chance avoid contact",
			get = "IsSummary",
			set = "ToggleSummary",
		},
		orientation = {
			type = "toggle",
			name = "Side-by-side",
			desc = "Puts the tables next to each other rather than on top of each other",
			get = "IsHorizontal",
			set = "ToggleHorizontal",
		}
	}
}

function DakSmak:OnInitialize()
	self:Debug("Initialized")
	self:UpdateTooltip()
end

function DakSmak:OnEnable()
	self:UpdateTooltip()
	self:Print("Debug mode: " .. tostring(DakSmak:IsDebugging()))
	if DakSmak:IsDebugging() then
		self:RegisterEvent("PLAYER_TARGET_CHANGED")		-- Fired when the player's target changes or is lost
		self:RegisterEvent("SKILL_LINES_CHANGED")		-- Fired when one of the skills changes value.  Also fires (with "LeftButton" as p1) when using the mouse to interact with the Skills panel.
		self:RegisterEvent("UNIT_AURA")		-- Fired when a buff, debuff, status, or item bonus was gained by or faded from a player, pet, NPC, or mob.  Passed UnitID (Confirmed player, target, mouseover)
		self:RegisterEvent("PLAYER_AURAS_CHANGED")		-- Fired when a buff or debuff is either applied to a unit or is removed from the player.
	else
		-- Register all events that cause a change in the combat table.  (Most likely not all of these are needed.)
		self:RegisterEvent("PLAYER_TARGET_CHANGED", 	"Update")		-- Fired when the player's target changes or is lost
		self:RegisterEvent("SKILL_LINES_CHANGED", 		"Update")		-- Fired when one of the skills changes value.  Also fires (with "LeftButton" as p1) when using the mouse to interact with the Skills panel.
		self:RegisterEvent("UNIT_AURA", 				"Update")		-- Fired when a buff, debuff, status, or item bonus was gained by or faded from a player, pet, NPC, or mob.  Passed UnitID (Confirmed player, target, mouseover)
		self:RegisterEvent("PLAYER_AURAS_CHANGED", 		"Update")		-- Fired when a buff or debuff is either applied to a unit or is removed from the player.
	end
end



-- Default event handlers only used for debugging
function DakSmak:PLAYER_TARGET_CHANGED()
	if UnitExists(L["target"]) then
		if UnitIsPlayer(L["target"]) then
			self:Debug("Acquired new player target")
		else
			self:Debug("Acquired new non-player target")
		end
	else
		self:Debug("Released target")
	end
	DakSmak:Update()
end

function DakSmak:SKILL_LINES_CHANGED()
	self:Debug("Skill Lines Changed")
	DakSmak:Update()
end

function DakSmak:UNIT_AURA()
	self:Debug("Unit Aura Changed")
	DakSmak:Update()
end

function DakSmak:PLAYER_AURAS_CHANGED()
	self:Debug("Player Aura Changed")
	DakSmak:Update()
end



-- Event handlers for the DakSmak frame
function DakSmak:OnDataUpdate()
-- Event handler.  Called by...
-- UpdateData()
-- Update() - Calls UpdateData(), UpdateText(), and UpdateTooltip() in order

	self:Debug("Entered OnDataUpdate")
	
	player.level = UnitLevel(L["player"])
	player.maxSkill = 5 * UnitLevel(L["player"])
	
	-- Find variable PLAYER base values via the wow api
	--  Defense Skill
	local base, bonus = UnitDefense(L["player"])
	if base 	== nil then base 	= 0 end
	if bonus 	== nil then bonus 	= 0 end
	player.defenseSkill = base + bonus
	
	-- Main Hand Attack Skill
	local base, bonus, _, _ = UnitAttackBothHands(L["player"])
	if base 	== nil then base 	= 0 end
	if bonus 	== nil then bonus 	= 0 end
	player.attackSkill = base + bonus
	
	-- Base Dodge, Parry, and Block are taken directly from API calls.  
	player.dodgeRate 	= GetDodgeChance(L["player"])
	player.parryRate 	= GetParryChance(L["player"])
	player.blockRate 	= GetBlockChance(L["player"])

	-- find variable TARGET base skills
	-- If no target exists, assume target is a normal mob the same level as the player
	if UnitExists(L["target"]) then
		target.defenseSkill 	= 5 * UnitLevel(L["target"])
		target.attackSkill 		= 5 * UnitLevel(L["target"])
	else
		target.defenseSkill 	= 5 * player.level
		target.attackSkill 		= 5 * player.level
	end	
	
	-- Standard base rate for  mobs of equal level as the player.  Modified by relative attack and defense skills.
	target.dodgeRate 			= 5			-- 5 + 0.04*(target.level*5 - player.attack)
	target.parryRate 			= 5			-- 5 + 0.04*(target.level*5 - player.attack)
	target.blockRate 			= 5			-- 5 + 0.04*(target.level*5 - player.attack)
	
	-- Attack modifiers based on the difference between attack skill and defense skill
	player.attackModifier		= 0.04 * (player.attackSkill - target.defenseSkill)
	target.attackModifier		= 0.04 * (target.attackSkill - player.defenseSkill)
	
	-- Attack and Defend table calculations are executed in order to allow calculations to take
	-- previous results into account.
	player.missRate 	= self:CalcMissChance(player, target)	-- Attack table
	target.missRate 	= self:CalcMissChance(target, player)	-- Defend table

	target.dodgeRate 	= self:CalcDodgeChance(player, target)	-- Attack table
	player.dodgeRate 	= self:CalcDodgeChance(target, player)	-- Defend table

	target.parryRate 	= self:CalcParryChance(player, target)	-- Attack table
	player.parryRate 	= self:CalcParryChance(target, player)	-- Defend table

	target.blockRate 	= self:CalcBlockChance(player, target)	-- Attack table
	player.blockRate 	= self:CalcBlockChance(target, player)	-- Defend table

	player.glancingRate = self:CalcGlancingChance(player, target)	-- Attack table
	target.crushRate 	= self:CalcCrushingChance(target, player)	-- Defend table
	
	player.uniqueRate	= self:CalcUniqueAttackChance(player, target)	-- Attack table
	target.uniqueRate	= self:CalcUniqueAttackChance(target, player)	-- Defend table

	player.critRate 	= self:CalcCritChance(player, target)	-- Attack table
	target.critRate 	= self:CalcCritChance(target, player)	-- Defend table

	player.hitRate 		= self:CalcHitChance(player, target)	-- Attack table
	target.hitRate 		= self:CalcHitChance(target, player)	-- Defend table
	
	self:Debug("Leaving OnDataUpdate")
end

function DakSmak:OnTextUpdate()
-- Event Handler.  Called by...
-- UpdateText()
-- UpdateDisplay() - Calls UpdateText(), UpdateTooltip in order()
-- Update() - Calls UpdateData(), UpdateText(), and UpdateTooltip() in order

	self:Debug("Entered OnTextUpdate")
	self:SetText("DakSmak")
	self:Debug("Leaving OnTextUpdate")
end

function DakSmak:OnTooltipUpdate()	
-- Event Handler.  Called by...
-- UpdateTooltip()
-- Update() - Calls UpdateData(), UpdateText(), and UpdateTooltip() in order

	self:SetDebugging(self:IsDebugging())
	self:Debug("Entered OnTooltipUpdate")
	
	-- Must register tablet to be able to change background color
	tablet:Register("FuBarPluginDakSmakFrame")

	self:Debug("Target: " .. L["target"] or "none")
	self:Debug("UnitisPlayer: " .. tostring(UnitIsPlayer(L["target"])))
	self:Debug("UnitIsPlusMob: " .. tostring(UnitIsPlusMob(L["target"])))

	--Set tooltip background to red if calculations are expected to be incorrect
	if UnitExists(L["target"]) and (UnitIsPlayer(L["target"]) or UnitIsPlusMob(L["target"])) then
		-- Background color to red 
		local cRed, cGrn, cBlu = tablet:GetColor(FuBarPluginDakSmakFrame)
		self:Debug("Current frame color: " .. cRed .. ", " .. cGrn .. ", " .. cBlu)
		self:Debug("Background to red")
		tablet:SetColor(FuBarPluginDakSmakFrame, .9, .15, 0)
		cRed, cGrn, cBlu = tablet:GetColor(FuBarPluginDakSmakFrame)
		self:Debug("New frame color: " .. cRed .. ", " .. cGrn .. ", " .. cBlu)
	else
		-- Background color back to normal
		self:Debug("Background to black")
		tablet:SetColor(FuBarPluginDakSmakFrame, 0, 0, 0)
	end
	
	--self:SetDebugging(false)
	
	-- Pulled out of OnTextUpdate
	if self:IsShortText() == true then		-- Use shortened version of text in the table
		cText.attackTable 	= L["AttTblAbb"]
		cText.defendTable 	= L["DefTblAbb"]
		cText.miss			= L["M"]
		cText.dodge			= L["D"]
		cText.parry			= L["P"]
		cText.block			= L["B"]
		cText.glance		= L["G"]
		cText.crush			= L["Csh"]
		cText.crit			= L["Crt"]
		cText.hit			= L["H"]
		cText.weaponSkill	= L["WepSkilAbb"]
		cText.defenseSkill	= L["DefSkilAbb"]
		cText.glanceCrush	= L["G/C"]
	else							-- Use long names in the table
		cText.attackTable 	= L["Attack Table"]
		cText.defendTable 	= L["Defend Table"]
		cText.miss			= L["Miss"]
		cText.dodge			= L["Dodge"]
		cText.parry			= L["Parry"]
		cText.block			= L["Block"]
		cText.glance		= L["Glance"]
		cText.crush			= L["Crush"]
		cText.crit			= L["Crit"]
		cText.hit			= L["Hit"]
		cText.weaponSkill	= L["Weapon Skill"]
		cText.defenseSkill	= L["Defensive Skill"]
		cText.glanceCrush	= L["Glance/Crush"]
	end

	
	-- Check for horizontal or veritcal table orientation
	self:SetDebugging(true)
	self:Debug("IsHorizontal: " .. tostring(self.db.profile.isHorizontal))
	if self.db.profile.isHorizontal then
		
		-- Build main part of a 3 column attack table
		local cat = tablet:AddCategory('columns', 3,
									   'text2', cText.attackTable,
									   'child_justify2', "RIGHT",
									   'text3', cText.defendTable)
		cat:AddLine('text', cText.miss,
					'text2', string.format("%.2f %%",player.missRate),
					'text3', string.format("%.2f %%",target.missRate))
		cat:AddLine('text', cText.dodge,
					'text2', string.format("%.2f %%",target.dodgeRate),
					'text3', string.format("%.2f %%",player.dodgeRate))
		cat:AddLine('text', cText.parry,
					'text2', string.format("%.2f %%",target.parryRate),
					'text3', string.format("%.2f %%",player.parryRate))
		cat:AddLine('text', cText.block,
					'text2', string.format("%.2f %%",target.blockRate),
					'text3', string.format("%.2f %%",player.blockRate))
		cat:AddLine('text', cText.glanceCrush,
					'text2', string.format("%.2f %%",player.uniqueRate),
					'text3', string.format("%.2f %%",target.uniqueRate))
		cat:AddLine('text', cText.crit,
					'text2', string.format("%.2f %%",player.critRate),
					'text3', string.format("%.2f %%",target.critRate))
		cat:AddLine('text', cText.hit,
					'text2', string.format("%.2f %%",player.hitRate),
					'text3', string.format("%.2f %%",target.hitRate))
					
		-- Add Weapon skill and defense skill at the bottom
		local cat = tablet:AddCategory('columns', 2,
									   'child_textR', .3,
									   'child_textG', .6,
									   'child_textB', .9,
									   'child_textR2', .3,
									   'child_textG2', .6,
									   'child_textB2', .9
		)
		cat:AddLine('text', cText.weaponSkill,
			'text2', player.attackSkill .. " / " .. player.maxSkill)
		cat:AddLine(							-- Defense skill
			'text', cText.defenseSkill,
			'text2', player.defenseSkill .. " / " .. player.maxSkill) 
	else
	
		-- Attack table heading.  This is done so the heading will be centered
		local cat = tablet:AddCategory('columns', 1)
		cat:AddLine('text',cText.attackTable,
					'justify', "CENTER")
		
		-- Create the formatting for the tablet object
		local cat = tablet:AddCategory(			
			'hideBlankLine', true,
			'columns', 2
		)
		cat:AddLine(							-- Miss
			'columns', 2,
			'text', cText.miss,
			'text2', string.format("%.2f %%",player.missRate)
		)
		cat:AddLine(							-- Dodge
			'text', cText.dodge,
			'text2', string.format("%.2f %%",target.dodgeRate)
		)
		cat:AddLine(							-- Parry
			'text', cText.parry,
			'text2', string.format("%.2f %%",target.parryRate)
		)
		cat:AddLine(							-- Block
			'text', cText.block,
			'text2', string.format("%.2f %%",target.blockRate)
		)
		cat:AddLine(							-- Glancing Blow
			'text', cText.glance,
			'text2', string.format("%.2f %%",player.uniqueRate)
		)
		cat:AddLine(							-- Crit
			'text', cText.crit,
			'text2', string.format("%.2f %%",player.critRate)
		)
		cat:AddLine(							-- Hit
			'text', cText.hit,
			'text2', string.format("%.2f %%",player.hitRate)
		)
		
		-- Defend table heading.  This is done so the heading will be centered
		local cat = tablet:AddCategory('columns', 1)
		cat:AddLine('text',cText.defendTable,
					'justify', "CENTER")
		
		-- Create the formatting for the tablet object
		local cat = tablet:AddCategory(			
			'hideBlankLine', true,
			'columns', 2
		)
		cat:AddLine(							-- Miss
			'text', cText.miss,
			'text2', string.format("%.2f %%",target.missRate)
		)
		cat:AddLine(							-- Dodge
			'text', cText.dodge,
			'text2', string.format("%.2f %%",player.dodgeRate)
		)
		cat:AddLine(							-- Parry
			'text', cText.parry,
			'text2', string.format("%.2f %%",player.parryRate)
		)
		cat:AddLine(							-- Block
			'text', cText.block,
			'text2', string.format("%.2f %%",player.blockRate)
		)
		cat:AddLine(							-- Crushing Blow
			'text', cText.crush,
			'text2', string.format("%.2f %%",target.uniqueRate)
		)
		cat:AddLine(							-- Crit
			'text', cText.crit,
			'text2', string.format("%.2f %%",target.critRate)
		)
		cat:AddLine(							-- Hit
			'text', cText.hit,
			'text2', string.format("%.2f %%",target.hitRate)
		)
		
		local cat = tablet:AddCategory(			-- Weapon and Defense skill
			'columns', 2,
			'child_textR', .3,
			'child_textG', .6,
			'child_textB', .9,
			'child_textR2', .3,
			'child_textG2', .6,
			'child_textB2', .9
		)
		cat:AddLine(							-- Weapon skill
			'text', cText.weaponSkill,
			'text2', player.attackSkill .. " / " .. player.maxSkill
		)
		cat:AddLine(							-- Defense skill
			'text', cText.defenseSkill,
			'text2', player.defenseSkill .. " / " .. player.maxSkill
		)
	end
	
	self:Debug("Leaving OnTooltipUpdate")
end


--[[   Main calculation and processing functions.  These are used to calculate final combat rates based on who the intended
target is.  All functions take arguments "attacker" and "defender," either of which can be the 'player' or 'target' table. ]]

function DakSmak:CalcMissChance(attacker, defender)
-- Calculate the chance for the attacker to miss his attack
	
	local UnitID = attacker.unitID
	local missChance = 5								-- Base miss rate.  Unchangable.
	
	-- Miss rate modifier based on the difference between the attacker's weapon skill and defender's defense skill.
	--local skillDifferenceModifier = 					
	--	.04*(attacker.attackSkill - defender.defenseSkill)
	
	missChance = missChance									
		- attacker.attackModifier						-- Weapon vs. Defense modifier
		- self:toHitEquipmentBonus(unitID)				-- Subtract and '+Hit' equipment bonuses 	[NOT YET IMPLEMENTED]
		- self:toHitTalentBonus(unitID)					-- Subtract any '+Hit' talents			 [NOT YET IMPLEMENTED]
		+ self:dualWeildingPenalty(aunitID)				-- Add a penalty for dual weilding		 [NOT YET IMPLEMENTED]
		+ self:toHitDebuffPenalty(UnitID)				-- Add a penalty for debuffs			[NOT YET IMPLEMENTED]
	
	if missChance < 0 then missChance = 0 end			-- Avoid negative miss rates
	
	--attacker.missRate = missChance
	return missChance
end

function DakSmak:CalcDodgeChance(attacker, defender)
-- Calculate the chance for the defender to dodge the attack
	
	local attMissRate = attacker.missRate
	--local skillDifferenceModifier = 					
	--	.04*(attacker.attackSkill - defender.defenseSkill)
	
	-- Dodge rate modifier based on the difference between the attacker's weapon skill and defender's defense skill.	
	local dodgeChance = defender.dodgeRate - attacker.attackModifier
	
	if dodgeChance < 0 then dodgeChance = 0 end			-- Avoid negative dodge rates
	
	-- Prevents the sum of all calculations from being > 100
	if attMissRate + dodgeChance > 100 then	
		dodgeChance = 100 - attMissRate
	end
	
	--defender.dodgeRate = dodgeChance
	return dodgeChance
end

function DakSmak:CalcParryChance(attacker, defender)
-- Calculate the chance for the defender to parry the attack

	-- Player will have a base parry rate of zero if they do not have that ability yet.
	-- In those cases, return parryRate=0.
	if attacker.parryRate == 0 then return 0 end
	
	-- Parry rate modifier based on the difference between the attacker's weapon skill and defender's defense skill.
	--local skillDifferenceModifier = 					
	--	.04*(attacker.attackSkill - defender.defenseSkill)
	local attMissRate = attacker.missRate
	local defDodgeRate = defender.dodgeRate
	
	local parryChance = defender.parryRate - attacker.attackModifier
	
	if parryChance < 0 then parryChance = 0 end			-- Avoid negative parry rates
	
	-- Prevents the sum of all calculations from being > 100
	if attMissRate + defDodgeRate + parryChance > 100 then	
		parryChance = 100 - attMissRate - defDodgeRate
	end
	
	--defender.parryRate = parryChance
	return parryChance
end

function DakSmak:CalcBlockChance(attacker, defender)
-- Calculate the chance for the defender to block the attack
	
	-- Block rate modifier based on the difference between the attacker's weapon skill and defender's defense skill.
	--local skillDifferenceModifier = 					
	--	.04*(attacker.attackSkill - defender.defenseSkill)
	local attMissRate = attacker.missRate
	local defDodgeRate = defender.dodgeRate
	local defParryRate = defender.parryRate
	
	local blockChance = defender.blockRate - attacker.attackModifier

	-- Prevents the sum of all calculations from being > 100
	if attMissRate + defDodgeRate + defParryRate + blockChance > 100 then	
		blockChance = 100 - attMissRate - defDodgeRate - defParryRate
	end
	
	-- Change block rate to zero if a shield is not equipped OR if the block value is less than zero
	if (defender.unitID == L["player"]) and (self:IsPlayerShieldEquipped() == nil) then
		blockChance = 0
	elseif 	blockChance < 0 then 
		blockChance = 0 
	end

	--defender.blockRate = blockChance
	return blockChance
end

function DakSmak:CalcUniqueAttackChance(attacker, defender)
-- Calculates the chance for a Glancing Blow if the attacker is the player.
-- Calculates the chance for a Crushing Blow if the attacker is a mob.
-- Directly modifies the attacker.uniqueRate value
	
	local uniqueChance
	local attMissRate = attacker.missRate
	local defDodgeRate = defender.dodgeRate
	local defParryRate = defender.parryRate
	local defBlockRate = defender.blockRate
	
	if attacker.unitID == L["player"] then
		-- Only players will land glancing blows
		-- Formula:  Glancing Blow Rate = 3% * (Mob Defense Skill - Attacker's Attack Skill - 5)
		uniqueChance = (defender.defenseSkill - attacker.attackSkill - 5) * .03
	else
		-- Only mobs will land crushing blows
		-- Formula:  Crush Rate = 2 * (Mob Att Skill - Max Std. Player Defense Skill) - 15
		-- where Max Std. Player Defense Skill = 5 * Player's Level OR Player's Current Defense Skill, whichever is lower.
		uniqueChance = (attacker.attackSkill - defender.defenseSkill) * 2 - 15
	end
		
	if uniqueChance < 0 then uniqueChance = 0 end

	-- Prevents the sum of all calculations from being > 100
	if attMissRate + defDodgeRate + defParryRate + defBlockRate + uniqueChance > 100 then	
		uniqueChance = 100 - attMissRate - defDodgeRate - defParryRate - defBlockRate
	end
	
	--attacker.uniqueRate = uniqueChance
	return uniqueChance		
end

function DakSmak:CalcGlancingChance(attacker, defender)
-- Calculates the chance for a player to land a glancing blow against a mob
	
	-- Only players will land glancing blows
	if attacker.unitID ~= L["player"] then
		return nil
	else
		-- Formula:  Glancing Blow Rate = 3% * (Max Std. Player Defense Skill - Attacker's Attack Skill - 5)
		-- where Max Std. Player Defense Skill = 5 * Player's Level OR Player's Current Defense Skill, whichever is lower.
		local glanceChance = (defender.defenseSkill - attacker.attackSkill - 5) * .03
		local attMissRate = attacker.missRate
		local defDodgeRate = defender.dodgeRate
		local defParryRate = defender.parryRate
		local defBlockRate = defender.blockRate
		
		if glanceChance < 0 then glanceChance = 0 end

		-- Prevents the sum of all calculations from being > 100
		if attMissRate + defDodgeRate + defParryRate + defBlockRate + glanceChance > 100 then	
			glanceChance = 100 - attMissRate - defDodgeRate - defParryRate - defBlockRate
		end

		--attacker.glanceRate = glanceChance
		return glanceChance		
	end
end

function DakSmak:CalcCrushingChance(attacker, defender)
-- Calculates the chance for a mob to land a crushing blow on the player
	
	-- Players cannot land crushing blows
	if attacker.unitID == L["player"] then
		return nil
	else
		-- Formula:  Crush Rate = 2 * (Mob Level - Player Defense Skill) - 15
		local crushChance = (UnitLevel(attacker.unitID)*5 - defender.defenseSkill) * 2 - 15
		local attMissRate = attacker.missRate
		local defDodgeRate = defender.dodgeRate
		local defParryRate = defender.parryRate
		local defBlockRate = defender.blockRate
		
		if crushChance < 0 then crushChance = 0 end

		-- Prevents the sum of all calculations from being > 100
		if attMissRate + defDodgeRate + defParryRate + defBlockRate + crushChance > 100 then	
			crushChance = 100 - attMissRate - defDodgeRate - defParryRate - defBlockRate
		end
		
		--attacker.crushRate = crushChance
		return crushChance
	end
end

function DakSmak:CalcCritChance(attacker, defender)
-- Calculates the chance for an attacker to land a critical blow
	
	local attMissRate 	= attacker.missRate
	local defDodgeRate 	= defender.dodgeRate
	local defParryRate 	= defender.parryRate
	local defBlockRate 	= defender.blockRate
	local attUniqueRate = attacker.uniqueRate
	
	local critChance
	if attacker.unitID == L["player"] then
		-- Reads unmodified Crit Rate from the "Attack" tooltip
		critChance = self:GetPlayerCritChance(L["player"])
	else
		-- Std Crit Rate for mobs
		critChance = 5 * UnitLevel(L["target"])
	end
	
	-- Modify Crit Chance according to skill level differences
	critChance 	= critChance + attacker.attackModifier
	
	-- Prevents negative crit rates
	if critChance < 0 then critChance = 0 end

	-- Prevents the sum of all calculations from being > 100
	if attMissRate + defDodgeRate + defParryRate + defBlockRate + attUniqueRate + critChance > 100 then	
		critChance = 100 - attMissRate - defDodgeRate - defParryRate - defBlockRate - attUniqueRate
	end

	--attacker.critRate = critChance
	return critChance
end
	
function DakSmak:CalcHitChance(attacker, defender)
	
	local hitChance = 100 			-- Hit Chance = 100% - All other combat rates
		- attacker.missRate
		- defender.dodgeRate
		- defender.parryRate
		- defender.blockRate
		- attacker.uniqueRate
		- attacker.critRate
		
	--attacker.hitRate = hitChance
	return hitChance
end


-- Helper functions to assist main processing functions.
function DakSmak:IsPlayerShieldEquipped()
-- Returns true if the player has a shield is equipped, nil otherwise
	
	-- GetPlayerItemInfo returns the name, item type and item subtype of the item in the given equippable slot
	local name, itemType, itemSubtype = self:GetPlayerItemInfo(L["SecondaryHandSlot"])
	
	if itemSubtype == L["Shields"] then
		return true
	else
		return nil
	end
end

function DakSmak:GetPlayerItemInfo(InventorySlotName)
-- Returns the item name, item type, and item subtype of the item in InventorySlotName
	
	-- Convert item string into something usable by GetItemInfo API call.
	local slotID = GetInventorySlotInfo(InventorySlotName)
	local itemLink = GetInventoryItemLink(L["player"], slotID)
	
	-- Return nil if there is no item in that slot
	if itemLink == nil then return nil end
	
	-- Retrieve the unique item code representing this item
	local _, _, itemCode = string.find(itemLink, "(%d+):")
	
	local name, _, _, _, itemType, itemSubtype, _, _, _ = GetItemInfo(itemCode)
	return name, itemType, itemSubtype
end

function DakSmak:GetSpellIndexByName(spellName)
-- Returns the ID of "spellName" and the name of the tab it is on.
	
	local spellBookTabNum, spellBookTabName
	local spellIndexOffset, numSpellsOnTab, lastIndexOnTab
	local currentSpellIndex
	
	-- Iterate through all spellbook tabs, scanning each spell to see if it matches spellName
	for spellBookTabNum = 1, MAX_SKILLLINE_TABS do

		spellBookTabName, _, spellIndexOffset, numSpellsOnTab = GetSpellTabInfo(spellBookTabNum)
		lastIndexOnTab = spellIndexOffset + numSpellsOnTab
		
		for currentSpellIndex = spellIndexOffset + 1, lastIndexOnTab do
			if GetSpellName(currentSpellIndex, BOOKTYPE_SPELL) == spellName then
				return currentSpellIndex, spellBookName
			end
		end
	end
end

function DakSmak:GetPlayerCritChance()
-- Finds the Attack spell in the spellbook and reads the crit chance off of the tooltip.

	local critChance, iCritInfo, critNum
	local id = 1
	local atkName = L["Attack"]
	local attackSpell = GetSpellName(id,BOOKTYPE_SPELL)

	if (attackSpell ~= atkName) then
	name, texture, offset, numSpells = GetSpellTabInfo(1)
		for i=1, numSpells do
			if (GetSpellName(i,BOOKTYPE_SPELL) == atkName) then
				id = i
			end
		end
	end
	
	GameTooltip:SetOwner(WorldFrame,"ANCHOR_NONE")
	GameTooltip:SetSpell(id, BOOKTYPE_SPELL)
	local spellName = GameTooltipTextLeft2:GetText()
	GameTooltip:Hide()
	iCritInfo = string.find(spellName, "%s")
	critNum = string.sub(spellName,0,(iCritInfo -2))
	return critNum
end

function DakSmak:IsPlayerDualWeilding()				-- [STUB - ALWAYS RETURNS 0]
	-- Return true if weapons are equipped in both hands
	return 0
end

function DakSmak:toHitEquipmentBonus(UnitID)	-- [STUB - ALWAYS RETURNS 0]
-- Cumulative +ToHit bonus from equipped items
	return 0
end

function DakSmak:toHitTalentBonus(UnitID)		-- [STUB - ALWAYS RETURNS 0]
-- Cumulative +ToHit bonus from Talents
	return 0
end

function DakSmak:dualWeildingPenalty(UnitID)	-- [STUB - ALWAYS RETURNS 0]
-- Cumulative ToHit penalty for dual weilding weapons, modified for bonuses
	return 0
end

function DakSmak:toHitDebuffPenalty(UnitID)		--[SUB - ALWAYS RETURNS 0]
-- Cumulative ToHit penalty for any debuffs
	return 0
end


-- Functions for handling menu options
function DakSmak:IsShortText()
	self:Debug("Entered IsShortText: " .. tostring(self.db.profile.showShortText))
	--self:Debug(self.db.profile.showShortText)
	return self.db.profile.showShortText
end

function DakSmak:ToggleShortText()
	self:Debug("Entered ToggleShortText: " .. tostring(self.db.profile.showShortText))
	self.db.profile.showShortText = not self.db.profile.showShortText
	self:Debug("Calling Update")
	self:Update()
	self:Debug("Leaving ToggleShortText: " .. tostring(self.db.profile.showShortText))
end

function DakSmak:IsSummary()
	return self.db.profile.isSummary
end

function DakSmak:ToggleSummary()
	self.db.profile.showSummary = not self.db.profile.showSummary
end

function DakSmak:IsHorizontal()
	return self.db.profile.isHorizontal
end

function DakSmak:ToggleHorizontal()
	self:Debug("Entered ToggleHorizontal: " .. tostring(self.db.profile.isHorizontal))
	self.db.profile.isHorizontal = not self.db.profile.isHorizontal
	self:Debug("Calling Update() from ToggleHorizontal")
	self:Update()
	self:Debug("Leaving ToggleHorizontal: " .. tostring(self.db.profile.isHorizontal))
end

DakSmak.OnMenuRequest = RightClickOptions
DakSmak:RegisterChatCommand({"/daksmak"}, RightClickOptions)


-- Specialized debugging function
function DakSmak:RecurseTable(t)
	for index,value in pairs(t) do 
		local keytype
		--[[  if (type(index) == "number") then
			keytype = "number"
			index = tostring(index)
		elseif (type(index) == "boolean") then
			keytype = "boolean"
			if (index) then
				index = "true"
			else
				index = "false"
			end  ]]
		if (type(value) == "string") then
			keytype = "string"
		elseif (type(value) == "function") then
			keytype = "function"
		elseif (type(value) == "table") then
			keytype = "table"
			self:Print("Recursing into " .. keytype .. ": " .. tostring(index))
			self:Debug(tostring(t[index]) .. "; " .. tostring(index))
			self:RecurseTables(t[index])
		end
		self:Print(tostring(keytype) .. ", " .. tostring(index).." : "..tostring(value))
	end
end
