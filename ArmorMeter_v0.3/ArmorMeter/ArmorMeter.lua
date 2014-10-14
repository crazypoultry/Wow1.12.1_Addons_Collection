--[[
	Hunter
		Wing Clip
		Mongoose Bite
		Counterattack
	Rogue
		Kick [Last Rank Done]
		Gouge (Account for Lethality) [Last Rank Done]
	Warrior
		Pummel
		Shield Bash
		Hamstring (?)
		Mocking Blow
		Bloodthirst (?)
		Execute
	Druid
		Swipe (Have to deal with hitting other targets)
		Rake (Initial damage)
		Autoattack? Need to check druid damage mechanics.
]]--

AM_VERSION = 0.3			-- Incrementing this wipes the set data

AMTalentData = {}
AMBuffData = {}
AMRanks = {
	["Gouge"] = {
		["Rank 1"] = 10,
		["Rank 2"] = 20,
		["Rank 3"] = 32,
		["Rank 4"] = 55,
		["Rank 5"] = 75
	},
	["Kick"] = {
		["Rank 1"] = 15,
		["Rank 2"] = 30,
		["Rank 3"] = 45,
		["Rank 4"] = 80
	},
	["Pummel"] = {
		["Rank 1"] = 20,
		["Rank 2"] = 50
	},
	["Hamstring"] = {
		["Rank 1"] = 5,
		["Rank 2"] = 15,
		["Rank 3"] = 45
	},		
	["Expose Armor"] = {
		["Rank 1"] = {0, 80, 160, 240, 340, 400},
		["Rank 2"] = {0, 145, 290, 435, 580, 725},
		["Rank 3"] = {0, 210, 420, 630, 840, 1050},
		["Rank 4"] = {0, 275, 550, 825, 1100, 1375},
		["Rank 5"] = {0, 340, 680, 1020, 1360, 1700}
	},
	["Sunder Armor"] = {
		["Rank 1"] = {0, 90, 180, 270, 360, 450},
		["Rank 2"] = {0, 180, 360, 420, 600, 780},
		["Rank 3"] = {0, 270, 520, 790, 1060, 1330},
		["Rank 4"] = {0, 360, 720, 1080, 1440, 1800},
		["Rank 5"] = {0, 450, 900, 1350, 1800, 2250}
	}
}

AMSkillRanks = {}

local function getMaxBloodthirstDamage(crit)
	local ap, bonusAP = UnitAttackPower("player")
	ap = ap + bonusAP
	local mx = (ap * 0.45)
	if AMBuffData["Enrage"] then
		mx = mx * (1 + (AMTalentData["Enrage"] * 0.05))
	end

	if crit then
		mx = mx * 2 * (1 + (AMTalentData["Impale"] * 0.05))
	end
	
	if AMBuffData["DeathWish"] then
		mx = mx * 1.2
	end
	
	return mx
end

local function getMaxKickDamage(crit)
	local mx = AMRanks["Kick"][AMSkillRanks["Kick"]]
	if crit then
		mx = mx * 2
	end
	return mx
end

local function getMaxPummelDamage(crit)
	local mx = AMRanks["Pummel"][AMSkillRanks["Pummel"]]
	if crit then
		mx = mx * 2 * (1 + (AMTalentData["Impale"] * 0.05))
	end
	if AMBuffData["Enrage"] then
		mx = mx * (1 + (AMTalentData["Enrage"] * 0.05))
	end
	return mx
end

local function getMaxGougeDamage(crit)
	local mx = AMRanks["Gouge"][AMSkillRanks["Gouge"]]
	if crit then
		mx = mx * 2 * (1 + (0.03 * AMTalentData["Lethality"]))
	end
	return mx
end

local function getMaxHamstringDamage(crit)
	local mx = AMRanks["Hamstring"][AMSkillRanks["Hamstring"]]
	if crit then
		mx = mx * 2 * (1 + (AMTalentData["Impale"] * 0.05))
	end
	if AMBuffData["Enrage"] then
		mx = mx * (1 + (AMTalentData["Enrage"] * 0.05))
	end
	return mx
end

ArmorMeterData = {}
ArmorMeterSearchStrings = {
	{"Your Kick (hits) .+ for (%d+)", getMaxKickDamage},
	{"Your Kick (crits) .+ for (%d+)", getMaxKickDamage},
	{"Your Gouge (hits) .+ for (%d+)", getMaxGougeDamage},
	{"Your Gouge (crits) .+ for (%d+)", getMaxGougeDamage},
	{"Your Pummel (hits) .+ for (%d+)", getMaxPummelDamage},
	{"Your Pummel (crits) .+ for (%d+)", getMaxPummelDamage},
	{"Your Hamstring (hits) .+ for (%d+)", getMaxHamstringDamage},
	{"Your Hamstring (crits) .+ for (%d+)", getMaxHamstringDamage},
	{"Your Bloodthirst (hits) .+ for (%d+)", getMaxBloodthirstDamage},
	{"Your Bloodthirst (crits) .+ for (%d+)", getMaxBloodthirstDamage}
}
local ImpXARank = 0;

local function DetectTalents()
	if UnitClass("player") == "Rogue" then
		local nameTalent, icon, tier, column, currRank, maxRank= GetTalentInfo(1,9);		-- Lethality
		AMTalentData["Lethality"] = currRank
		
		local nameTalent, icon, tier, column, currRank, maxRank= GetTalentInfo(1,8);		-- Imp XA
		AMTalentData["ExposeArmor"] = currRank
	elseif UnitClass("player") == "Warrior" then
		local nameTalent, icon, tier, column, currRank, maxRank= GetTalentInfo(2,11);		-- Enrage
		AMTalentData["Enrage"] = currRank

		local nameTalent, icon, tier, column, currRank, maxRank= GetTalentInfo(1,11);		-- Impale
		AMTalentData["Impale"] = currRank
	end
end

local function DetectSkills()
	local i = 1
	while true do
	   local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL)
	   if not spellName then
	      do break end
	   end
	   AMSkillRanks[spellName] = spellRank
	   i = i + 1
	end
end

local function CalcReduction(armor, level)
	local r = armor / (armor + (85*level) + 400)
	return r
end

local function CalcArmor(reduction, level)
	local armor = ((85 * level * reduction) + (400 * reduction)) / (1-reduction)
	return ceil(armor)
end

local function CheckDebuffsForArmorReducers()
	for i = 1,16 do
		local debuffTexture, debuffApplications, debuffDispelType = UnitDebuff("target", i);
		DEFAULT_CHAT_FRAME:AddMessage(debuffTexture);
	end
end

local function HasBuff(spell,unit) -- Adapted from ZFunctions
	if not spell then
		return
	end
	if not unit then
		unit = "player"
	end
	local text = ""
	local i = 1
	while (UnitBuff(unit, i)) do
		ArmorMeterTip:SetOwner(UIParent,"ANCHOR_NONE")
		ArmorMeterTip:SetUnitBuff(unit,i)
		text = ArmorMeterTipTextLeft1:GetText()
		if string.find(text or "", spell) then
			return i, UnitBuff(unit, i)
		end
		i = i + 1
	end
end

local function HasDebuff(spell,unit) -- Adapted from ZFunctions
	if not spell then
		return
	end
	if not unit then
		unit = "player"
	end
	local text = ""
	local i = 1
	while (UnitDebuff(unit, i)) do
		ArmorMeterTip:SetOwner(UIParent,"ANCHOR_NONE")
		ArmorMeterTip:SetUnitDebuff(unit,i)
		text = ArmorMeterTipTextLeft1:GetText()
		if string.find(text or "", spell) then
			return i, UnitDebuff(unit, i), ArmorMeterTipTextLeft2:GetText()
		end
		i = i + 1
	end
end

function ArmorMeter_OnLoad()
	SlashCmdList["ARMORMETER"] = ArmorMeter_SlashHandler;
	SLASH_ARMORMETER1 = "/am";

	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")
	this:RegisterEvent("CHAT_MSG_COMBAT_MISC_INFO")
	this:RegisterEvent("CHAT_MSG_ADDON")
	this:RegisterEvent("PLAYER_AURAS_CHANGED")
	this:RegisterEvent("PLAYER_TARGET_CHANGED")
	this:RegisterEvent("VARIABLES_LOADED")
	-- ArmorMeterBaseBar:EnableMouse(false)
	--this:RegisterEvent()
	--this:RegisterEvent()
	--this:RegisterEvent()
	--this:RegisterEvent()
end

local function AMToggle()
	if ArmorMeterVisFrame:IsVisible() then
		ArmorMeterVisFrame:Hide()
	else
		ArmorMeterVisFrame:Show()
	end
end

local function SetNumBars(num)
	if num < 1 or num > 5 then
		DEFAULT_CHAT_FRAME:AddMessage("Usage: /am show [1-5]")
		return
	end
	for i = 2,6 do
		getglobal("ArmorMeterReduction" .. i):Hide()
	end
	
	for i =2, (2+num) do
		getglobal("ArmorMeterReduction" .. i):Show()
	end
	ArmorMeterVisFrame:SetHeight(175 - (19 * (5-num)))
end

function ArmorMeter_SlashHandler(msg)
	local words = {};
	for word in string.gfind(msg, "%w+") do
		table.insert(words, word);
	end
	if table.getn(words) == 0 then
		AMToggle();
	else
		if words[1] == "show" and table.getn(words) >= 2 then
			SetNumBars(words[2])
		end
	end
end

function ArmorMeter_getArmorReduction(i)
	if UnitClass("player") == "Rogue" then
		local XARanks = AMRanks["Expose Armor"][AMSkillRanks["Expose Armor"]]
		return (XARanks[i] * (0.03 * ImpXARank)) + XARanks[i]
	elseif UnitClass("player") == "Warrior" then
		local SunderRanks = AMRanks["Sunder Armor"][AMSkillRanks["Sunder Armor"]]
		return SunderRanks[i]
	end
end

function ArmorMeter_Update(key)
	local mitigation = 0
	local max = 1000000
	local AC = 0
	if ArmorMeterData[key] then
		-- mitigation = ArmorMeterData[key]["mitigation"]
		mitigation = CalcReduction(ArmorMeterData[key]["AC"], UnitLevel("player"))
		max = ArmorMeterData[key]["confidence"]
		AC = ArmorMeterData[key]["AC"]
	end
	local calcLevel = UnitLevel("player")
	ArmorMeterVisFrameTitle:SetText(key)
	
	local dMit = math.floor(mitigation * 10000)/100
	local err = (math.floor((1 / max) * 10000) / 100)
	
	local barWidth = 210
	ArmorMeterVisFrameAC:SetText("Reduction - " .. err .. "% err")
	local lAmts = {
		{0, "Base"},
		{2250, "Sunder"},
		{2250+505, "Sunder + FF"},
		{2250+640, "Sunder + CoR"},
		{2250+640+505, "Sunder + FF + CoR"},
		{0, "Unused"}
	}
	for i = 1,5 do
		local postXAArmor = AC - lAmts[i][1] -- AC - ArmorMeter_getArmorReduction(i)
		if postXAArmor < 0 then
			postXAArmor = 0
		end
		local postMitigation = CalcReduction(postXAArmor, calcLevel)
		local postXAValue = (math.floor(postMitigation * 10000)/100)
		getglobal("ArmorMeterReduction" .. i .. "Bar"):SetTexCoord(0.1, postMitigation / 0.75, 0.4453125, 0.5546875)
		getglobal("ArmorMeterReduction" .. i .. "Bar"):SetWidth((barWidth * postMitigation)+1)
		getglobal("ArmorMeterReduction" .. i .. "AC"):SetText(postXAValue .. "% (" .. postXAArmor .. " AC)")
		getglobal("ArmorMeterReduction" .. i .. "Label"):SetText(lAmts[i][2])
		if postXAArmor == AC then
			getglobal("ArmorMeterReduction" .. i .. "Reduction"):SetText("Unmodified")
		else
			getglobal("ArmorMeterReduction" .. i .. "Reduction"):SetText("" .. dMit - postXAValue .. "%")
		end
	end
end

local function strsplit(delimiter, text)
  local list = {}
  local pos = 1
  if strfind("", delimiter, 1) then -- this would result in endless loops
    error("delimiter matches empty string!")
  end
  while 1 do
    local first, last = strfind(text, delimiter, pos)
    if first then -- found?
      tinsert(list, strsub(text, pos, first-1))
      pos = last+1
    else
      tinsert(list, strsub(text, pos))
      break
    end
  end
  return list
end

function ArmorMeter_UpdateFromData(msg)
	bits = strsplit("#", msg)
	ArmorMeter_UpdateEntry(bits[1], bits[2], bits[3], bits[4])
	if UnitName("target") ~= nil and UnitName("target") .. " [" .. UnitLevel("target") .. "]" == bits[1] then
		ArmorMeter_Update(bits[1])
	end
end

function ArmorMeter_UpdateEntry(key, mitigation, confidence, AC)
	local data = ArmorMeterData[key]
	local margin = 1 / confidence
	mitigation = tonumber(mitigation)
	confidence = tonumber(confidence)
	AC = tonumber(AC)
	if data then
		local fallsOutsideError = (mitigation - margin > data["mitigation"]) or (mitigation + margin < data["mitigation"])
		if fallsOutsideError or (data["confidence"] < tonumber(confidence)) then
			ArmorMeterData[key]["mitigation"] = mitigation
			ArmorMeterData[key]["confidence"] = tonumber(confidence)
			ArmorMeterData[key]["AC"] = tonumber(AC)
		end
	else
		ArmorMeterData[key] = {
			["mitigation"] = mitigation,
		 	["confidence"] = tonumber(confidence),
		 	["AC"] = tonumber(AC)
		}
	end
end

function ArmorMeter_UpdateMitigation(mitigation, mx)
	if UnitName("target") == nil then
		return
	end
	
	local affected = 0
	local extraAC = 0
	local index, debuff, text = HasDebuff("Sunder Armor", "target")
	if index then
		affected = 1
		_,_,amt = string.find(text, "(%d+)")
		if amt then
			extraAC = extraAC + tonumber(amt)
		end
	end
	
	local index, debuff, text = HasDebuff("Faerie Fire", "target")
	if index then
		affected = 1
		_,_,amt = string.find(text, "target by (%d+)")
		if amt then
			extraAC = extraAC + tonumber(amt)
		end
	end

	local index, debuff, text = HasDebuff("Curse of Recklessness", "target")
	if index then
		affected = 1
		_,_,amt = string.find(text, "armor by (%d+)")
		if amt then
			extraAC = extraAC + tonumber(amt)
		end
	end
	
	local newAC = CalcArmor(mitigation, UnitLevel("player")) + extraAC -- Experimental!
	mitigation = CalcReduction(newAC, UnitLevel("player"))
	
	local calcLevel = UnitLevel("player")
	local key = UnitName("target") .. " [" .. UnitLevel("target") .. "]"
	
	ArmorMeter_UpdateEntry(key, mitigation, mx, newAC)
	local msg = key .. "#" .. mitigation .. "#" .. mx .. "#" .. newAC
	SendAddonMessage("ARMORMETER", msg, "RAID")
	ArmorMeter_Update(key)
end

function ArmorMeter_OnEvent(event, arg, arg2, arg3)
	if event == "CHAT_MSG_SPELL_SELF_DAMAGE" or event == "CHAT_MSG_COMBAT_MISC_INFO" then
		if table.getn(AMSkillRanks) == 0 then
			DetectSkills();
		end
		for idx, str in ArmorMeterSearchStrings do
			_,_, crit, cap = string.find(arg, str[1])
			if cap then
				local mx = str[2]
				if type(mx) == "function" then
					mx = mx(crit == "crits")
				end
				local mitigation = 1 - (tonumber(cap) / mx)
				ArmorMeter_UpdateMitigation(mitigation, mx)
				break
			end
		end
	elseif event == "PLAYER_AURAS_CHANGED" then
		AMBuffData["DeathWish"] = false
		if HasDebuff("Death Wish", "player") then
			AMBuffData["DeathWish"] = true
		end

		AMBuffData["Enrage"] = false
		if HasBuff("Enrage", "player") then
			AMBuffData["Enrage"] = true
		end
	elseif event == "CHAT_MSG_ADDON" then
		if arg == "ARMORMETER" then
			ArmorMeter_UpdateFromData(arg2)
		end
	elseif event == "PLAYER_TARGET_CHANGED" then
		if UnitName("target") ~= nil then
			ArmorMeter_Update(UnitName("target") .. " [" .. UnitLevel("target") .. "]")
		end
	elseif event == "VARIABLES_LOADED" then
		DetectTalents();
		DetectSkills();
		if not ArmorMeterVersion or ArmorMeterVersion < AM_VERSION then
			ArmorMeterData = {}
		end
		ArmorMeterVersion = AM_VERSION
	end
end

function ArmorMeter_GetAC(mitigation, level)
    return ( level * ( 85 * level + 400 ) ) / ( 1 - mitigation );
end
