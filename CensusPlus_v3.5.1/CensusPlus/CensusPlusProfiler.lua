--[[
	CensusPlus for World of Warcraft(tm).
	
	Copyright 2005 - 2006 Cooper Sellers and WarcraftRealms.com

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GLP.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
]]


CensusPlus_DoThisCharacter = false;
CensusPlus_Profile = {};
CensusPlus_Profile[GetCVar("realmName")]		= {} ;
local myCPProfile_LOADED				=  nil;		-- Successful load of the script

--	//////////////////////////////////////////////
--		    Configuration Variables
--	//////////////////////////////////////////////
-- 	  set to nil to disable any of the following

 myCPProfile_ENABLED 				= 	1;	-- Enable the profiler?

local myCPProfile_DoScanInventory 	= 	0;	-- get inventory?
local myCPProfile_DoScanBank 		= 	0;	-- get bank?
local myCPProfile_DoScanEquipment 	= 	1;	-- get equipment?
local myCPProfile_DoScanSkills 		=   0;	-- get skills?
local myCPProfile_DoScanTalents 	= 	0;	-- get talents?
local myCPProfile_DoScanProfessions	= 	0;	-- output known tradeskill recipies
local myCPProfile_DoScanReputation	=	0;	-- get reputation?
local myCPProfile_DoScanQuestLog	=	0;	-- get quests?
local myCPProfile_DoScanHonor		=	0;	-- get honor?

local myCPProfile_HTML_Tooltips 	= 	1;	-- make html tooltips (non-array format) - separate lines with <br>
local myCPProfile_TALENTS_Full 		= 	1;	-- output all talents and tooltips


local myCPProfile_DEBUG 			= 	1;	-- enable debugging? unused at this time
local myCPProfile_ALLEVENTS 		= 	nil;	-- enable all event catching? for debugging only

--	//////////////////////////////////////////////

local TradeSkillDifficultyCode = {};
TradeSkillDifficultyCode['optimal'] 	= 	4;
TradeSkillDifficultyCode['medium'] 		= 	3;
TradeSkillDifficultyCode['easy'] 		= 	2;
TradeSkillDifficultyCode['trivial']		=	1;
TradeSkillDifficultyCode['header'] 		= 	0;

local myCPProfile_VERSION = "1.0.0";	-- this only changes when a new variable is added to the output

local timePlayed = -1;
local timeLevelPlayed = -1;

-- array of inventory slot names
local Profile_slots = {
  "Head",          -- 1
  "Neck",          -- 2
  "Shoulder",      -- 3
  "Shirt",         -- 4
  "Chest",         -- 5
  "Waist",         -- 6
  "Legs",          -- 7
  "Feet",          -- 8
  "Wrist",         -- 9
  "Hands",         -- 10
  "Finger0",       -- 11
  "Finger1",       -- 12
  "Trinket0",      -- 13
  "Trinket1",      -- 14
  "Back",          -- 15
  "MainHand",      -- 16
  "SecondaryHand", -- 17
  "Ranged",        -- 18
  "Tabard",        -- 19
};

function CP_ProfileFrame_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	if ( myCPProfile_ALLEVENTS ) then					-- unused, but keep for testing
		this:RegisterEvent("PLAYER_GUILD_UPDATE");
		this:RegisterEvent("UNIT_INVENTORY_CHANGED");
		this:RegisterEvent("VARIABLES_LOADED");
		this:RegisterEvent("TRAINER_CLOSED");
		this:RegisterEvent("PLAYER_LEVEL_UP");
	end
	this:RegisterEvent("TIME_PLAYED_MSG");
	this:RegisterEvent("BANKFRAME_CLOSED");		-- 12/17, was OPENED, will it work with closed only?

	this:RegisterEvent("TRADE_SKILL_SHOW");
	this:RegisterEvent("CRAFT_SHOW");
end

-- since PLAYER_QUITTING and PLAYER_CAMPING events don't work, hook the functions
-- NOTE: Due to server lag, this could be a cause of the client not actually logging the character out until the server catches up
--[[
oldLogout = Logout;
oldQuit = Quit;
function Quit()
	RequestTimePlayed();
	oldQuit();
end
function Logout()
	RequestTimePlayed();
	oldLogout();
end
]]--

function CP_ProfileFrame_OnEvent(event, arg1, arg2)
	-- crapout if we're not ready to process, or if not enabled
	if ( ( event == "UNIT_INVENTORY_CHANGED" and arg1 ~= "player" ) or not myCPProfile_ENABLED or not UnitName("player") or UnitName("player") == UNKNOWNOBJECT or not GetCVar("realmName") or not CensusPlus_DoThisCharacter ) then
		return;
	end
	
--	CensusPlus_Msg( "PROF TEST : " .. event );

	-- Got a unit name, now we're loaded
	if (event == "VARIABLES_LOADED" and not myCPProfile_LOADED) then
		myCPProfile_LOADED = 1;
		PaperDollFrame_SetDamage();
		PaperDollFrame_SetRangedDamage();
	elseif (event == "VARIABLES_LOADED" and myCPProfile_LOADED) then
		return;
	end

	if (event == "TIME_PLAYED_MSG") then
	  	timePlayed = arg1;
	  	timeLevelPlayed = arg2;
	end

	-- Event hit, process profile
	if (myCPProfile_LOADED) then
		Profile_InitProfile();		-- Always do this first, creates a profile is it doesn't exist

		if( ( event == "BANKFRAME_CLOSED" or event == "BANKFRAME_OPENED" or event == "PLAYERBANKSLOTS_CHANGED" ) and myCPProfile_DoScanBank ) then
			Profile_ScanBank();
			CP_ProfHidden:ClearLines();
			CP_ProfHidden:Hide();
			return;
		end
		if ( not myCPProfile_DoScanBank and CensusPlus_Profile[GetCVar("realmName")][UnitName("player")] ) then
			CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Bank"] = nil;
		end
		if ( myCPProfile_DoScanProfessions ) then
			if ( event == "TRADE_SKILL_SHOW" ) then
				Profile_ScanTradeSkill();
				CP_ProfHidden:ClearLines();
				CP_ProfHidden:Hide();
				return;
			end

			if ( event == "CRAFT_SHOW" ) then
				Profile_ScanCraft();
				CP_ProfHidden:ClearLines();
				CP_ProfHidden:Hide();
				return;
			end
		elseif ( CensusPlus_Profile[GetCVar("realmName")][UnitName("player")] ) then
			CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Professions"] = nil;
		end
		
		CP_ProfHidden:ClearLines();
		CP_ProfHidden:Hide();
	end
end

function Profile_InitProfile()
	if ( not CensusPlus_Profile ) then
		CensusPlus_Profile = {};
	end
	
	if ( not CensusPlus_Profile[GetCVar("realmName")] ) then
		CensusPlus_Profile[GetCVar("realmName")] = {};
	end

	if ( not CensusPlus_Profile[GetCVar("realmName")][UnitName("player")] ) then
		CensusPlus_Profile[GetCVar("realmName")][UnitName("player")] = {};
	else
		local tmpBank = CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Bank"];
		local tmpProfessions = CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Professions"];

		CensusPlus_Profile[GetCVar("realmName")][UnitName("player")] = { };
		CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Bank"] = tmpBank;
		CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Professions"] = tmpProfessions;
	end
	
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["ProfilerVersion"] = myCPProfile_VERSION;	-- keep track of version and don't work with old data
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Name"] = playerName;
	
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["DateUpdated"] = date();
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["TimePlayed"] = timePlayed;
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["TimeLevelPlayed"] = timeLevelPlayed;
	
	local sex = "";
	if (UnitSex("player") == 0) then
		sex = "Male";
	else
		sex = "Female";
	end
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Sex"] = sex;
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Race"] = UnitRace("player");
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Class"] = UnitClass("player");
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Level"] = UnitLevel("player");
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Guild"] = {} ;
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Guild"]["GuildName"], CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Guild"]["Title"], CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Guild"]["Rank"] = GetGuildInfo("player");
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Server"] = GetCVar("realmName");
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["TalentPoints"] = UnitCharacterPoints("player");
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Zone"] = GetZoneText();
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["SubZone"] = GetSubZoneText();

	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Experience"] = UnitXP("player") .. ":" .. UnitXPMax("player");

	local money = GetMoney();
	local gold = floor(money / (COPPER_PER_SILVER * SILVER_PER_GOLD));
	local silver = floor((money - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER);
	local copper = mod(money, COPPER_PER_SILVER);

	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Money"] = {};
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Money"]["Gold"] = gold;
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Money"]["Silver"] = silver;
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Money"]["Copper"] = copper;

	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Stats"] = {};

	-- "stat" is the same as effectiveStat...
	-- problem here is if they have a debuff spell on, the values saved will be wrong
	local stat, effectiveStat, posBuff, negBuff = UnitStat("player", 1);
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Stats"]["Strength"] = (stat - posBuff - negBuff) .. ":" .. effectiveStat .. ":" .. posBuff .. ":" .. negBuff;
	stat, effectiveStat, posBuff, negBuff = UnitStat("player", 2);
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Stats"]["Agility"] = (stat - posBuff - negBuff) .. ":" .. effectiveStat .. ":" .. posBuff .. ":" .. negBuff;
	stat, effectiveStat, posBuff, negBuff = UnitStat("player", 3);
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Stats"]["Stamina"] = (stat - posBuff - negBuff) .. ":" .. effectiveStat .. ":" .. posBuff .. ":" .. negBuff;
	stat, effectiveStat, posBuff, negBuff = UnitStat("player", 4);
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Stats"]["Intellect"] = (stat - posBuff - negBuff) .. ":" .. effectiveStat .. ":" .. posBuff .. ":" .. negBuff;
	stat, effectiveStat, posBuff, negBuff = UnitStat("player", 5);
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Stats"]["Spirit"] = (stat - posBuff - negBuff) .. ":" .. effectiveStat .. ":" .. posBuff .. ":" .. negBuff;

	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Resists"] = {};
	local base, resistance, positive, negative = UnitResistance("player", 6);
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Resists"]["Arcane"] = base .. ":" .. resistance .. ":" .. positive .. ":" .. negative;
	base, resistance, positive, negative = UnitResistance("player", 2);
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Resists"]["Fire"] = base .. ":" .. resistance .. ":" .. positive .. ":" .. negative;
	base, resistance, positive, negative = UnitResistance("player", 3);
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Resists"]["Nature"] = base .. ":" .. resistance .. ":" .. positive .. ":" .. negative;
	base, resistance, positive, negative = UnitResistance("player", 4);
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Resists"]["Frost"] = base .. ":" .. resistance .. ":" .. positive .. ":" .. negative;
	base, resistance, positive, negative = UnitResistance("player", 5);
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Resists"]["Shadow"] = base .. ":" .. resistance .. ":" .. positive .. ":" .. negative;

	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Mana"] = UnitManaMax("player");
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Health"] = UnitHealthMax("player");
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Defense"] = UnitDefense("player");

	local baseArm, effectiveArmor, armor, positiveArm, negativeArm = UnitArmor("player");
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Armor"] = baseArm .. ":" .. (baseArm + positiveArm) .. ":" .. positiveArm .. ":" .. negativeArm; -- if they have a debuf on, don't save it

	local minDamage, maxDamage, physicalBonusPos, physicalBonusNeg, percent = UnitDamage("player");
--	local baseDamage = (minDamage + maxDamage) * 0.5;
--	local fullDamage = (baseDamage + physicalBonusPos + physicalBonusNeg) * percent;
--	local totalBonus = (fullDamage - baseDamage);
--	local displayMin = floor(minDamage + totalBonus);
--	local displayMax = ceil(maxDamage + totalBonus);

	CP_ProfHidden:SetOwner(CensusPlus_ProfileFrame, "ANCHOR_CURSOR");

	CP_ProfHidden:SetText(INVTYPE_WEAPONMAINHAND, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	CP_ProfHidden:AddDoubleLine(ATTACK_SPEED_COLON, string.format("%.2f", CharacterDamageFrame.attackSpeed), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	CP_ProfHidden:AddDoubleLine(DAMAGE_COLON, CharacterDamageFrame.damage, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	CP_ProfHidden:AddDoubleLine(DAMAGE_PER_SECOND, string.format("%.1f", CharacterDamageFrame.dps), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	-- Check for offhand weapon
	if ( CharacterDamageFrame.offhandAttackSpeed ) then
		CP_ProfHidden:AddLine("<br>");
		CP_ProfHidden:AddLine(INVTYPE_WEAPONOFFHAND, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		CP_ProfHidden:AddDoubleLine(ATTACK_SPEED_COLON, string.format("%.2f", CharacterDamageFrame.offhandAttackSpeed), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		CP_ProfHidden:AddDoubleLine(DAMAGE_COLON, CharacterDamageFrame.offhandDamage, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		CP_ProfHidden:AddDoubleLine(DAMAGE_PER_SECOND, string.format("%.1f", CharacterDamageFrame.offhandDps), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	end

	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Melee Attack"] = {};
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Melee Attack"]["AttackRating"] = UnitAttackBothHands("player");
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Melee Attack"]["DamageRange"] = floor(minDamage) .. ":" .. ceil(maxDamage);
	local base, posBuff, negBuff = UnitAttackPower("player");
	local effective = base + posBuff + negBuff;	
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Melee Attack"]["AttackPower"] = base .. ":" .. effective .. ":" .. posBuff .. ":" .. negBuff;
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Melee Attack"]["DamageRangeTooltip"] = CP_Tooltipscan();
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Melee Attack"]["AttackPowerTooltip"] = CharacterAttackPowerFrame.tooltipSubtext;

	-- Ranged not saved if there is no ranged weapon equipped
	if ( PaperDollFrame.noRanged ) then
		CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Ranged Attack"] = nil;
	else
		CP_ProfHidden:SetText(INVTYPE_RANGED, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		CP_ProfHidden:AddDoubleLine(ATTACK_SPEED_COLON, string.format("%.2f", CharacterRangedDamageFrame.attackSpeed), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		CP_ProfHidden:AddDoubleLine(DAMAGE_COLON, CharacterRangedDamageFrame.damage, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		CP_ProfHidden:AddDoubleLine(DAMAGE_PER_SECOND, string.format("%.1f", CharacterRangedDamageFrame.dps), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);

		CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Ranged Attack"] = {};
		CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Ranged Attack"]["AttackPowerTooltip"] = CharacterRangedAttackPowerFrame.tooltipSubtext;
		CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Ranged Attack"]["DamageRangeTooltip"] = CP_Tooltipscan();

		local RangeSpeeed, RangeMinDMG,RangeMaxDMG = UnitRangedDamage("player");
		CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Ranged Attack"]["DamageRange"] = max(floor(RangeMinDMG),1) .. ":" .. max(ceil(RangeMaxDMG),1);
		local base, pos, neg = UnitRangedAttackPower("player");
		local effective = base + pos + neg;	
		CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Ranged Attack"]["AttackPower"] = base .. ":" .. effective .. ":"  .. pos .. ":" .. neg;
		local base, pos, neg = UnitRangedAttack("player");
		if (not neg) then neg = 0; end;
		CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Ranged Attack"]["AttackRating"] = base;
	end

	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["DodgePercent"] = strsub(GetDodgeChance(), 0, 5);
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["ParryPercent"] = strsub(GetParryChance(), 0, 5);
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["BlockPercent"] = strsub(GetBlockChance(), 0, 5);

	local MainAC, EffAC, AC, PosAC, NegAC = UnitArmor("player");
	local Level = UnitLevel("player");
	local Mitigation = (EffAC)/((85 * Level)+400);
	Mitigation = 100 * (Mitigation/(Mitigation + 1));
	Mitigation = strsub(Mitigation, 0, 5);
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["MitigationPercent"] = Mitigation;
	
	local spellIndex = 1;
	local spellName, subSpellName = GetSpellName(spellIndex,BOOKTYPE_SPELL);
	local tmpStr = nil;
	while spellName do	
		if (spellName == "Attack") then
			CP_ProfHidden:SetSpell(spellIndex, BOOKTYPE_SPELL);
			if( CP_Tooltipscan() ~= nil ) then
				tmpStr = string.gsub(CP_Tooltipscan(), ".*<br/?>(%d?%d?%d%.%d%d?)%%.*", "%1");
				CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["CritPercent"] = tmpStr;
			end
		end
		spellIndex = spellIndex + 1;
		spellName,subSpellName = nil;
		spellName,subSpellName = GetSpellName(spellIndex,BOOKTYPE_SPELL);
	end
--[[	
	local speed, offhandSpeed = UnitAttackSpeed("player");
	local minDamage, maxDamage, minOffHandDamage, maxOffHandDamage, physicalBonusPos, physicalBonusNeg, percent = UnitDamage("player");
	local baseDamage = (minDamage + maxDamage) * 0.5;
	local fullDamage = (baseDamage + physicalBonusPos + physicalBonusNeg) * percent;
	local damagePerSecond = max( fullDamage, 1 ) / speed;
		minDamage = max( floor( minDamage ), 1 );
		maxDamage = max( ceil( maxDamage ),1 );
		speed = string.format( "%.2f", speed );
		damagePerSecond = string.format( "%.1f", damagePerSecond );
	local damagerange = minDamage.." - "..maxDamage;
	local output = INVTYPE_WEAPONMAINHAND .. "<br>" 
					.. ATTACK_SPEED_COLON .. speed .. "<br>"
					.. DAMAGE_COLON .. damagerange .. "<br>"
					.. DAMAGE_PER_SECOND .. damagePerSecond
	if ( offhandSpeed ) then
		local offhandBaseDamage = (minOffHandDamage + maxOffHandDamage) * 0.5;
		local offhandFullDamage = (offhandBaseDamage + physicalBonusPos + physicalBonusNeg) * percent;
		local offhandDamagePerSecond = (max(offhandFullDamage,1) / offhandSpeed);
			minOffHandDamage=max(floor(minOffHandDamage),1);
			maxOffHandDamage=max(ceil(maxOffHandDamage),1);
		local damagerange = minOffHandDamage.." - "..maxOffHandDamage;
		offhandDamagePerSecond = string.format( "%.1f", offhandDamagePerSecond );
		offhandSpeed=string.format("%.2f", offhandSpeed);
		output = output .. INVTYPE_WEAPONOFFHAND .. "<br>"
						.. ATTACK_SPEED_COLON    .. offhandSpeed .. "<br>"
						.. DAMAGE_COLON			 .. damagerange .. "<br>"
						.. DAMAGE_PER_SECOND     .. offhandDamagePerSecond;
	end
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Melee Attack"]["DamageRangeTooltip"] = output;

	local speed, minDamage, maxDamage = UnitRangedDamage("player");
	minDamage = (minDamage / percent) - physicalBonusPos - physicalBonusNeg;
	maxDamage = (maxDamage / percent) - physicalBonusPos - physicalBonusNeg;
	local baseDamage = (minDamage + maxDamage) * 0.5;
	local fullDamage = (baseDamage + physicalBonusPos + physicalBonusNeg) * percent;
	local damagePerSecond = (max(fullDamage,1) / speed);
		minDamage = max(floor(minDamage),1);
		maxDamage = max(ceil(maxDamage),1);
		speed=string.format("%.2f", speed);
		damagePerSecond=string.format("%.1f", damagePerSecond);
	local damagerange = max(floor(minDamage),1).." - "..max(ceil(maxDamage),1);
	output = INVTYPE_RANGED .. "<br>"
			 .. ATTACK_SPEED_COLON .. speed .. "<br>"
			 .. DAMAGE_COLON .. damagerange .. "<br>"
			 .. DAMAGE_PER_SECOND .. damagePerSecond;
	local base,pos,neg=UnitRangedAttack( "player" );
	if(base==0) then
		CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Ranged Attack"]["DamageRangeTooltip"] = "";
	else
		CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Ranged Attack"]["DamageRangeTooltip"] = output;
	end
]]--
-- put in dps?

	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Locale"] = GetLocale();
	Profile_DoBuffs();

	if ( myCPProfile_DoScanSkills ) then
		Profile_GetSkills();
	end
	if ( myCPProfile_DoScanEquipment) then
		Profile_UpdateInventory();
	end
	if ( myCPProfile_DoScanInventory ) then
		Profile_ScanInventory();
	end
	if ( myCPProfile_DoScanTalents and UnitLevel("player") > 9 ) then
		Profile_GetTalents();
	end
	if ( myCPProfile_DoScanReputation ) then
		Profile_ScanReputation();
	end
	if ( myCPProfile_DoScanQuestLog ) then
		Profile_ScanQuests();
	end
	if ( myCPProfile_DoScanHonor ) then
		Profile_ScanHonor();
	end
end

function Profile_ScanQuests() 
	local header = "Unknown"; 

	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Quests"] = {}; 
	local slot = 1;
	for i=1, GetNumQuestLogEntries(), 1 do 
		local text, level, questtag, isHeader, isCollapsed = GetQuestLogTitle(i); 
		if ( isHeader ) then 
			header = text; 
			CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Quests"][header] = {} 
		else 
			if ( text ) then           
				CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Quests"][header][slot] = {} 
				CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Quests"][header][slot]["Title"] = text; 
				CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Quests"][header][slot]["Level"] = level; 
				if ( questtag ) then 
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Quests"][header][slot]["Tag"] = questtag; 
				end 
			end 
			slot = slot + 1;
		end 
	end 
end

function Profile_ScanHonor()
	-- save the honor data
	local lastweekHK, lastweekDK, lastweekContribution, lastweekRank = GetPVPLastWeekStats();
	local lifetimeHK, lifetimeDK, lifetimeHighestRank = GetPVPLifetimeStats();
	local sessionHK, sessionDK = GetPVPSessionStats();
	local yesterdayHK, yesterdayDK, yesterdayContribution = GetPVPYesterdayStats();
	local lifetimeRankName, lifetimeRankNumber = GetPVPRankInfo(lifetimeHighestRank);
	if ( not lifetimeRankName ) then
		lifetimeRankName = NONE;
	end

	local rankName, rankNumber = GetPVPRankInfo(UnitPVPRank("player"));
	if ( not rankName ) then
		rankName = NONE;
	end
	local rankInfo = "("..RANK.." "..rankNumber..")";

	-- set icon
	local rankIcon = "";
	if ( rankNumber > 0 ) then
		rankIcon = string.format("%s%02d","Interface\\PvPRankBadges\\PvPRank", rankNumber);
	end

	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Honor"] = {} ;
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Honor"]["LifetimeHighestRank"] = lifetimeHighestRank;
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Honor"]["LifetimeRankName"] = lifetimeRankName;
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Honor"]["LifetimeHK"] = lifetimeHK;
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Honor"]["LifetimeDK"] = lifetimeDK;
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Honor"]["SessionHK"] = sessionHK;
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Honor"]["SessionDK"] = sessionDK;
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Honor"]["YesterdayHK"] = yesterdayHK;
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Honor"]["YesterdayDK"] = yesterdayDK;
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Honor"]["YesterdayContribution"] = yesterdayContribution;
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Honor"]["LastWeekHK"] = lastweekHK;
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Honor"]["LastWeekDK"] = lastweekDK;
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Honor"]["LastWeekContribution"] = lastweekContribution;
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Honor"]["LastWeekRank"] = lastweekRank;
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Honor"]["RankName"] = rankName;
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Honor"]["RankInfo"] = rankInfo;
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Honor"]["RankIcon"] = rankIcon;
end


function Profile_ScanReputation()		-- Originally by Leronflon, modified to fit my style =)
	local count;
	local name, standing, rep, atWar, canToggle, foo2, foo3, thisHeader, isHeader;
	
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Reputation"] = {};
	
	count = GetNumFactions();
	
	if( count == nil ) then
		return;
	end
		
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Reputation"]["Count"] = count;

	local Units = { };
	Units[1] = 36000; -- Hated
	Units[2] = 3000; -- Hostile
	Units[3] = 3000; -- Unfriendly
	Units[4] = 3000; -- Neutral
	Units[5] = 6000; -- Friendly
	Units[6] = 12000; -- Honored
	Units[7] = 21000; -- Revered
	Units[8] = 1000; -- Exaulted

	local ReputationKey = { [0] = "Unknown", [1] = "Hated", [2] = "Hostile", [3] = "Unfriendly", [4] = "Neutral", [5] = "Friendly", [6] = "Honored", [7] = "Revered", [8] = "Exaulted" };


	thisHeader = "none";
	for i = 1, count do
		name, description, standing, barValue, atWar, canToggle, isHeader, isCollapsed = GetFactionInfo(i);
		
		if( name ~= nil ) then		
			if (atWar == nil) then
				atWar = 0;
			end
			if (rep == nil) then
				rep = 0;
			end
			if (standing == nil) then
				standing = 0;
			end
			if (isHeader == nil ) then
				thisHeader = name;
				CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Reputation"][thisHeader] = {};
			else
				CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Reputation"][thisHeader][name] = {};
				CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Reputation"][thisHeader][name]["Standing"] = ReputationKey[standing];
				CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Reputation"][thisHeader][name]["AtWar"] = atWar;
				CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Reputation"][thisHeader][name]["Value"] = round(barValue*Units[standing]).."/"..Units[standing];
		--		CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Reputation"][thisHeader][name]["canToggle"] = canToggle;
		--		CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Reputation"][thisHeader][name]["Order"] = i;
			end
		end
	end
end

function Profile_GetTalents()
	local numTabs = GetNumTalentTabs();
	local name, iconTexture, tier, column, rank, maxRank;
	local numTalents;
	local tabname, texture, points, fileName;

    --  Make sure the right frame is loaded
    if( not CensusPlus_IsTalentLoaded() ) then
		return;
	end

	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Talents"] = {};

	for x=1, numTabs do
		PanelTemplates_SetTab(TalentFrame, x);
		numTalents = GetNumTalents(PanelTemplates_GetSelectedTab(TalentFrame));
		tabname, texture, points, fileName = GetTalentTabInfo(PanelTemplates_GetSelectedTab(TalentFrame));
		CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Talents"][tabname] = {};
		CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Talents"][tabname]["PointsSpent"] = points;
		CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Talents"][tabname]["Background"] = "Interface\\TalentFrame\\" .. fileName;
		CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Talents"][tabname]["Order"] = x;
		for i=1, numTalents do
			name, iconTexture, tier, column, rank, maxRank = GetTalentInfo(PanelTemplates_GetSelectedTab(TalentFrame), i);
			if (rank > 0 or myCPProfile_TALENTS_Full) then
				CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Talents"][tabname][name] = { };
				CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Talents"][tabname][name]["Rank"] = rank .. ":" .. maxRank;
				CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Talents"][tabname][name]["Location"] = tier .. ":" .. column;
				CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Talents"][tabname][name]["Texture"] = iconTexture;
			end

			if ( myCPProfile_TALENTS_Full ) then
				-- double check
				if ( not CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Talents"][tabname][name] ) then
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Talents"][tabname][name] = {}; 
				end
				CP_ProfHidden:SetTalent(PanelTemplates_GetSelectedTab(TalentFrame), i)
				CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Talents"][tabname][name]["Tooltip"] = CP_Tooltipscan();
			end
		end
	end
end

function Profile_DoBuffs()
	local iIterator = 0;
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Buffs"] = {};
	while( GetPlayerBuffTexture( iIterator ) ) do
		buffText = GetPlayerBuffTexture( iIterator);
		iIterator = iIterator + 1
		CP_ProfHidden:SetUnitBuff( "player", iIterator );

		CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Buffs"][iIterator] = {};
		CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Buffs"][iIterator]["Tooltip"] = CP_Tooltipscan();
		CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Buffs"][iIterator]["Texture"] = buffText;
	end
--[[
	iIterator = 1;
	while( UnitDebuff( "player", iIterator ) ) do
		debuffTexture, debuffApplications = UnitDebuff(unitName, debuffIndex);	
		CP_ProfHidden:SetUnitDebuff( "player", iIterator-1 );

		CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Debuffs"][iIterator] = {};
		CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Debuffs"][iIterator]["Tooltip"] = CP_Tooltipscan();
		CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Debuffs"][iIterator]["Texture"] = debuffTexture;
		iIterator = iIterator + 1
	end
]]--
end

function Profile_GetSkills()
	-- Reset/Initialize
   	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Skills"] = {};
	local skillheader = '';
	local skillinfo = nil;
	local rank, maxRank = 0;
	local order = 1;			-- order in which the headers appear
	for i=1, GetNumSkillLines(), 1 do
		skillinfo = fixnilempty(GetSkillLineInfo(i));
		rank = skillinfo[4];
		maxRank = skillinfo[7];
		if(skillinfo[2] == 1) then		-- if it is a header
			skillheader = skillinfo[1];
			CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Skills"][skillheader] = { };
			CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Skills"][skillheader]["Order"] = order;
			order = order + 1;
		else 
			CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Skills"][skillheader][skillinfo[1]] = rank .. ":" .. maxRank;
		end
	end   
end


---------------------------------------------
--	Process Inventory
---------------------------------------------

function Profile_UpdateInventory()
	local link;
	local texture;

	-- Reset/Initialize
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Equipment"] = {};

	for index,slot in Profile_slots do
		link = GetInventoryItemLink("player", index);
		texture = GetInventoryItemTexture("player", index);
		if( link ) then
			for color, item, name in string.gfind(link, "|c(%x+)|Hitem:(%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r") do
				if( color ~= nil and item ~= nil and name ~= nil ) then
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Equipment"][slot] = { };
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Equipment"][slot]["Texture"] = texture;
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Equipment"][slot]["Color"] = color;
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Equipment"][slot]["Item"] = item;
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Equipment"][slot]["Name"] = name;
					-- Build Tooltip
					--CP_ProfHidden:SetHyperlink("item:" .. item);
					CP_ProfHidden:SetInventoryItem("player", index);
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Equipment"][slot]["Tooltip"] = CP_Tooltipscan();

				end
			end
		end		  
	end
end

function Profile_ScanInventory()
	local bag, bagname, link, texture, color, item, strings, str;

	-- Reset/Initialize
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Inventory"] = {}

	for bag = 0,4 do
		if (bag == 0) then
			bagname = "Backpack";
			CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Inventory"]["Bag" .. bag] = { };
			CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Inventory"]["Bag" .. bag]["Name"] = "Backpack";
			CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Inventory"]["Bag" .. bag]["Item"] = "Backpack";
			if ( myCPProfile_HTML_Tooltips ) then
				CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Inventory"]["Bag" .. bag]["Tooltip"] = "Backpack";
			else
				CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Inventory"]["Bag" .. bag]["Tooltip"] = {};
				CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Inventory"]["Bag" .. bag]["Tooltip"][1] = "Backpack";
			end
			CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Inventory"]["Bag" .. bag]["Color"] = "ffffffff";
			CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Inventory"]["Bag" .. bag]["Slots"] = 16;
			CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Inventory"]["Bag" .. bag]["Texture"] = "Interface\\Buttons\\Button-Backpack-Up";
			ProcessBagItems(bag, bagname);
		else
			link = GetInventoryItemLink("player", (bag+19));
			texture = GetInventoryItemTexture("player", (bag+19));
			if( link ) then
				for color, item, bagname in string.gfind(link, "|c(%x+)|Hitem:(%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r") do
					if( color ~= nil and item ~= nil and bagname ~= nil ) then
						CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Inventory"]["Bag" .. bag] = { };
						CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Inventory"]["Bag" .. bag]["Item"] = item;
						CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Inventory"]["Bag" .. bag]["Color"] = color;
						CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Inventory"]["Bag" .. bag]["Texture"] = texture;
						CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Inventory"]["Bag" .. bag]["Name"] = bagname;
						CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Inventory"]["Bag" .. bag]["Slots"] = GetContainerNumSlots(bag);
						CP_ProfHidden:SetInventoryItem("player", (bag+19))
						CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Inventory"]["Bag" .. bag]["Tooltip"] = CP_Tooltipscan();
						ProcessBagItems(bag);
					end
				end
			end			
		end
	end	
end

function ProcessBagItems(bag)
	local slot, strings, str, texture, itemCount, locked, quality, link, color, item, name;
	
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Inventory"]["Bag" .. bag]["Contents"] = {};

	for slot = 1,GetContainerNumSlots(bag) do	-- loop through all slots in this bag and get items

		CP_ProfHidden:SetBagItem(bag, slot);

		texture, itemCount, locked, quality = GetContainerItemInfo(bag,slot);
		link = GetContainerItemLink(bag, slot);
		if( link ) then
			for color, item, name in string.gfind(link, "|c(%x+)|Hitem:(%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r") do
				if( color ~= nil and item ~= nil and name ~= nil ) then
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Inventory"]["Bag" .. bag]["Contents"][slot] = {};
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Inventory"]["Bag" .. bag]["Contents"][slot]["Tooltip"] = CP_Tooltipscan();
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Inventory"]["Bag" .. bag]["Contents"][slot]["Texture"] = texture;
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Inventory"]["Bag" .. bag]["Contents"][slot]["Quantity"] = itemCount;
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Inventory"]["Bag" .. bag]["Contents"][slot]["Name"] = name;
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Inventory"]["Bag" .. bag]["Contents"][slot]["Color"] = color;
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Inventory"]["Bag" .. bag]["Contents"][slot]["Item"] = item;
				end
			end
		end
	end
end


-- From CosmosCommonFunctions.lua
-- Clears a tooltip for usage.
function ClearTooltip(TooltipNameBase)
	for i=1, 15, 1 do
		getglobal(TooltipNameBase.."TextLeft"..i):SetText("");
		getglobal(TooltipNameBase.."TextRight"..i):SetText("");
	end
end


function Profile_ScanBank()
-- Borrowed from Telo's LootLink and restructured to fit my data
	local oldBank = nil;
	if (CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Bank"]) then
		oldBank = CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Bank"];
	end
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Bank"] = {}
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Bank"]["Contents"] = {}

	local bag, size, slot, link;
	
	-- First the bank container itself
	size = GetContainerNumSlots(BANK_CONTAINER);
	for slot = size, 1, -1 do
		link = GetContainerItemLink(BANK_CONTAINER, slot);
		local texture, itemCount, locked = GetContainerItemInfo(BANK_CONTAINER, slot);
		if( link ) then
			for color, item, name in string.gfind(link, "|c(%x+)|Hitem:(%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r") do
				if( color ~= nil and item ~= nil and name ~= nil ) then
					oldBank = nil;			-- When we find items, remove the oldBank variable
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Bank"]["Contents"][slot] = {};
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Bank"]["Contents"][slot]["Texture"] = texture;
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Bank"]["Contents"][slot]["Quantity"] = itemCount;
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Bank"]["Contents"][slot]["Name"] = name;
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Bank"]["Contents"][slot]["Color"] = color;
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Bank"]["Contents"][slot]["Item"] = item;
					CP_ProfHidden:SetHyperlink("item:" .. item);
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Bank"]["Contents"][slot]["Tooltip"] = CP_Tooltipscan();
				end
			end
		end
	end

	-- Now the bank bags
	for bag = 5, 10 do
		link = GetContainerItemLink(BANK_CONTAINER, (bag+20));
		texture, itemCount, locked, quality = GetContainerItemInfo(BANK_CONTAINER, (bag+20));
		if( link ) then
			for color, item, bagname in string.gfind(link, "|c(%x+)|Hitem:(%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r") do
				if( color ~= nil and item ~= nil and bagname ~= nil ) then
					oldBank = nil;			-- When we find items, remove the oldBank variable
					bagnum = bag-4;
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Bank"]["Bag" .. bagnum] = {};
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Bank"]["Bag" .. bagnum]["Name"] = bagname;
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Bank"]["Bag" .. bagnum]["Slots"] = GetContainerNumSlots(bag);
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Bank"]["Bag" .. bagnum]["Texture"] = texture;
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Bank"]["Bag" .. bagnum]["Color"] = color;
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Bank"]["Bag" .. bagnum]["Item"] = item;
					CP_ProfHidden:SetHyperlink("item:" .. item);
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Bank"]["Bag" .. bagnum]["Tooltip"] = CP_Tooltipscan();

					ProcessBankBagItems(bag, bagnum);
				end
			end
		end			
	end
	
	if ( oldBank ) then
		CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Bank"] = oldBank;
	end
end

function ProcessBankBagItems(bag, bagnum)

	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Bank"]["Bag" .. bagnum]["Contents"] = {};

	for slot = 1,GetContainerNumSlots(bag) do	-- loop through all slots in this bag and get items
--		CP_ProfHidden:SetBagItem(bag, slot);
		texture, itemCount, locked, quality = GetContainerItemInfo(bag,slot);
		link = GetContainerItemLink(bag, slot);
		if( link ) then
			for color, item, name in string.gfind(link, "|c(%x+)|Hitem:(%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r") do
				if( color ~= nil and item ~= nil and name ~= nil ) then
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Bank"]["Bag" .. bagnum]["Contents"][slot] = {};
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Bank"]["Bag" .. bagnum]["Contents"][slot]["Texture"] = texture;
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Bank"]["Bag" .. bagnum]["Contents"][slot]["Quantity"] = itemCount;
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Bank"]["Bag" .. bagnum]["Contents"][slot]["Name"] = name;
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Bank"]["Bag" .. bagnum]["Contents"][slot]["Color"] = color;
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Bank"]["Bag" .. bagnum]["Contents"][slot]["Item"] = item;
					CP_ProfHidden:SetBagItem(bag, slot);
--					CP_ProfHidden:SetHyperlink("item:" .. item);
					CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Bank"]["Bag" .. bagnum]["Contents"][slot]["Tooltip"] = CP_Tooltipscan();
				end
			end
		end
	end
end


function Profile_ScanTradeSkill()
	local skillLineName, skillLineRank, skillLineMaxRank = GetTradeSkillLine();

	if( (not skillLineName) or (skillLineName == "") or (skillLineName == "UNKNOWN")) then
		return;
	end
	-- we don't bother saving the following tradeskills
	if( (skillLineName == "Fishing") or (skillLineName == "Mining") or (skillLineName == "Herbalism") or (skillLineName == "Skinning") ) then
		return;
	end

	if ( not CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Professions"] ) then
		CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Professions"] = {};
	end
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Professions"][skillLineName] = {};

	-- expand the tree so we can see all the recipes
	ExpandTradeSkillSubClass(0);

	-- get the number of recipes and loop through each one
	local numTradeSkills = GetNumTradeSkills();
	local skillHeader = skillLineName;
	for itemIndex=1, numTradeSkills, 1 do
	    if( itemIndex == nil or skillLineName==nil or skillHeader==nil ) then
	        return;
	    end	    
		local skillText = "";
		local skillName, skillDifficulty, numAvailable, isExpanded = GetTradeSkillInfo(itemIndex);
		if( skillDifficulty ~= "header" and skillLineName ~= nil and skillLineName ~= "" and skillHeader ~= nil and skillHeader ~= "" and skillName ~= nil and skillName ~= "" ) then
			if( not CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Professions"][skillLineName][skillHeader] ) then
				CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Professions"][skillLineName][skillHeader] = {};
			end
			CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Professions"][skillLineName][skillHeader][skillName] = {};
			local skillIcon = GetTradeSkillIcon(itemIndex);
			if( not skillIcon ) then
				skillIcon = "";
			end

			CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Professions"][skillLineName][skillHeader][skillName]["Texture"] = skillIcon;

			CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Professions"][skillLineName][skillHeader][skillName]["Difficulty"] = TradeSkillDifficultyCode[skillDifficulty];

			CP_ProfHidden:SetTradeSkillItem(itemIndex);
			CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Professions"][skillLineName][skillHeader][skillName]["Tooltip"] = CP_Tooltipscan();


		
			local numReagents = GetTradeSkillNumReagents(itemIndex);
			local reagents = '';
			for reagentIndex=1, numReagents, 1 do
				local reagentName, reagentTexture, reagentCount, playerReagentCount = GetTradeSkillReagentInfo(itemIndex, reagentIndex);
				if( not reagentTexture ) then
					reagentTexture = "";
				end
				if( not reagentName ) then
					reagentName = "Unknown";
				end
				
				if (reagentIndex == numReagents) then
					reagents = reagents .. reagentName .. " x" .. reagentCount;
				else
					reagents = reagents .. reagentName .. " x" .. reagentCount .. "<br>";
				end				
			end
			CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Professions"][skillLineName][skillHeader][skillName]["Reagents"] = reagents;
		else
			skillHeader = skillName;
			CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Professions"][skillLineName][skillHeader] = {};
		end
	end
end
	
-- is this ever called?!
function Profile_ScanCraft()
	local skillLineName, skillLineRank, skillLineMaxRank = GetCraftDisplaySkillLine();

	if( (not skillLineName) or (skillLineName == "") or (skillLineName == "UNKNOWN")) then
		return;
	end

	if ( not CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Professions"] ) then
		CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Professions"] = {};
	end
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Professions"][skillLineName] = {};

	-- expand the tree so we can see all the recipes
	-- ExpandCraftSubClass(0);

	-- get the number of recipes and loop through each one
	local numCrafts = GetNumCrafts();
	local skillHeader = skillLineName;	-- default it, enchanting doesn't have categories?
	CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Professions"][skillLineName][skillHeader] = {};
	for itemIndex=1, numCrafts, 1 do
		local skillText = "";
		local skillName, craftSubSpellName, skillDifficulty, numAvailable, isExpanded = GetCraftInfo(itemIndex);
		--Debug(skillName .. ":" .. craftSubSpellName);
		if( skillDifficulty ~= "header" and skillLineName and skillLineName ~= "" and skillHeader and skillHeader ~= "" and skillName and skillName ~= "" ) then
			CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Professions"][skillLineName][skillHeader][skillName] = {};
			local skillIcon = GetCraftIcon(itemIndex);
			if( not skillIcon ) then
				skillIcon = "";
			end
			local description = GetCraftDescription(itemIndex);
			if (description == nil) then
				description = "";
			end

			CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Professions"][skillLineName][skillHeader][skillName]["Texture"] = skillIcon;

			CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Professions"][skillLineName][skillHeader][skillName]["Difficulty"] = TradeSkillDifficultyCode[skillDifficulty];

			-- CP_ProfHidden:SetCraftItem(itemIndex);
			CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Professions"][skillLineName][skillHeader][skillName]["Tooltip"] = description;
			--Debug(description);
		
			local numReagents = GetCraftNumReagents(itemIndex);
			local reagents = '';
			for reagentIndex=1, numReagents, 1 do
				local reagentName, reagentTexture, reagentCount, playerReagentCount = GetCraftReagentInfo(itemIndex, reagentIndex);
				if( not reagentTexture ) then
					reagentTexture = "";
				end
				if( not reagentName ) then
					reagentName = "Unknown";
				end
				
				if (reagentIndex == numReagents) then
					reagents = reagents .. reagentName .. " x" .. reagentCount;
				else
					reagents = reagents .. reagentName .. " x" .. reagentCount .. "<br>";
				end				
			end
			CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Professions"][skillLineName][skillHeader][skillName]["Reagents"] = reagents;
		else
			local skillHeader = skillName;
			CensusPlus_Profile[GetCVar("realmName")][UnitName("player")]["Professions"][skillLineName][skillHeader] = {};
		end
	end
end


-- Utilities go below
-- From CosmosCommonFunctions.lua
-- Gets all lines out of a tooltip.

function CP_Tooltipscan()
--CP_ProfHidden:Show();

	local TooltipNameBase = "CP_ProfHidden";
	local tooltipFrame = getglobal(TooltipNameBase);
	local strings = {};
	local htmlstr = nil;
	
--	CensusPlus_Msg( "NUM LINES: " .. CP_ProfHidden:NumLines() );
	
	for idx = 1, CP_ProfHidden:NumLines() do
		local textLeft = nil;
		local textRight = nil;
		ttext = getglobal(TooltipNameBase.."TextLeft"..idx);
		
		if(ttext and ttext:IsVisible() and ttext:GetText() ~= nil) then
			textLeft = ttext:GetText();
		end
		
--if( textLeft ~= nil ) then
--	CensusPlus_Msg( "LEFT TEXT: " .. textLeft );
--end		
		
		ttext = getglobal(TooltipNameBase.."TextRight"..idx);
		if(ttext and ttext:IsVisible() and ttext:GetText() ~= nil) then
			textRight = ttext:GetText();
		end
--if( textRight ~= nil ) then
--	CensusPlus_Msg( "RIGHT TEXT: " .. textRight );
--end		
		
		if (textLeft or textRight) then
			if ( textRight) then
				textRight = "\t"..textRight;
			else
				textRight = "";
			end

			if ( htmlstr ~= nil ) then
				htmlstr = htmlstr .. "<br>" .. textLeft .. textRight;
			else
				htmlstr = textLeft .. textRight;
			end
		end
	end

--	CP_ProfHidden:ClearLines();
--	ClearTooltip( "CP_ProfHidden" );

	return htmlstr;	
end

function round(x)
  if(x - math.floor(x) > 0.5) then
    x = x + 0.5;
  end
  return math.floor(x);
end

if (not fixnilempty) then
	fixnilempty = function(...)
	  for i=1, arg.n, 1 do
	    if(not arg[i]) then
	      arg[i] = "";
	    end
	  end
	  return arg;
	end
end


