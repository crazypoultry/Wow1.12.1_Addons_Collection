ENR_Version = "1.1.1";
ENR_AddonId = "ENR";
ENR_AddonName = "Enigma Ninja Rate";
ENR_SUITES_AMPLIFIER = 9;
ENR_TOOPTIP_MAXLINES = 30;
ENR_RAIDMEMBER_MAX = 40;
ENR_GROUPMEMBER_MAX = 4;
ENR_EXTRAPROPERTY_AMPLIFIER = 9;
ENR_SPECIALITEM_AMPLIFIER = 9;
ENR_PROPERTY_AMPLIFIER_LVL40 = 0.5;
ENR_DEBUG = 0;

ENR_CLASS_PROPERTY_RULES = {
--	                       AGI INT STA SPR STR RMA BOW
	[ENR_CLASS_MAGE]    = "1997190",
	[ENR_CLASS_ROGUE]   = "9197500", 
	[ENR_CLASS_HUNTER]  = "9497309",
	[ENR_CLASS_PRIEST]  = "1999190",
	[ENR_CLASS_WARRIOR] = "5197900",
	[ENR_CLASS_WARLOCK] = "1997190",
	[ENR_CLASS_PALADIN] = "3798700",
	[ENR_CLASS_DRUID]   = "1798590",
	[ENR_CLASS_SHAMAN]  = "5798590",
	
}

ENR_CLASS_EXTRAPROPERTY_RULES = {
--	                       ALL SHD CUR FIR FRS ARC NAT PET POW RAG CUE
	[ENR_CLASS_MAGE]    = "50055500000",
	[ENR_CLASS_ROGUE]   = "00000000600", 
	[ENR_CLASS_HUNTER]  = "00000509790",
	[ENR_CLASS_PRIEST]  = "55500500009",
	[ENR_CLASS_WARRIOR] = "00000000900",
	[ENR_CLASS_WARLOCK] = "55050500000",
	[ENR_CLASS_PALADIN] = "50500500807",
	[ENR_CLASS_DRUID]   = "40000550707",
	[ENR_CLASS_SHAMAN]  = "30005500707",
}

ENR_CLASS_ITEM_RULES_LVL40 = {
	[ENR_CLASS_MAGE]    = 0,
	[ENR_CLASS_ROGUE]   = 0, 
	[ENR_CLASS_HUNTER]  = 2,
	[ENR_CLASS_PRIEST]  = 0,
	[ENR_CLASS_WARRIOR] = 3,
	[ENR_CLASS_WARLOCK] = 0,
	[ENR_CLASS_PALADIN] = 3,
	[ENR_CLASS_DRUID]   = 0,
	[ENR_CLASS_SHAMAN]  = 2,
}

ENR_CLASS_ITEM_RULES = {
	--                     CFMPM12BDM12SM12GWTPFCS
	--                     LEALAAAWAMMMTSSSNDHAWBH
	[ENR_CLASS_MAGE]    = "90000000300093300900000",
	[ENR_CLASS_ROGUE]   = "19000003955005505050530", 
	[ENR_CLASS_HUNTER]  = "18907779300017779057090",
	[ENR_CLASS_PRIEST]  = "90000000577080000900000",
	[ENR_CLASS_WARRIOR] = "12395555577711190119119",
	[ENR_CLASS_WARLOCK] = "90000000300093300900000",
	[ENR_CLASS_PALADIN] = "12890070099909990005007",
	[ENR_CLASS_DRUID]   = "19000000799910000000700",
	[ENR_CLASS_SHAMAN]  = "18905500777710000000507",
}

ENR_CLASS_SPECIALITEM_RULES = {
	--                     123456789ROYGBBPGS901234567
	[ENR_CLASS_MAGE]    = "515919551151115119155159111",
	[ENR_CLASS_ROGUE]   = "195195515111115591911155115", 
	[ENR_CLASS_HUNTER]  = "955559111115511119955511111",
	[ENR_CLASS_PRIEST]  = "159515195155191111911511551",
	[ENR_CLASS_WARRIOR] = "511951559115591111511159115",
	[ENR_CLASS_WARLOCK] = "551191559551111119111519155",
	[ENR_CLASS_PALADIN] = "111955955511111591155111911",
	[ENR_CLASS_DRUID]   = "955519511511591111151515911",
	[ENR_CLASS_SHAMAN]  = "595151195111115591151151951",
}

ENR_RATE_SAFE   = "SAFE";
ENR_RATE_NORMAL = "NORMAL";
ENR_RATE_DANGER = "DANGER";
ENR_RATE_DATA = {
	[ENR_RATE_SAFE]   = {
		["PERCENT"] = 85, 
		["COLOR"]   = { R=0, G=1, B=0 },
		["TEXTURE"] = "Interface\\AddOns\\EN_NinjaRate\\EN_IconSafe",
		["SUGGEST"] = ENR_SUGGEST_SAFE,
	},
	[ENR_RATE_NORMAL] = {
		["PERCENT"] = 40,
		["COLOR"] = { R=1, G=1, B=0 },
		["TEXTURE"] = "Interface\\AddOns\\EN_NinjaRate\\EN_IconNormal",
		["SUGGEST"] = ENR_SUGGEST_NORMAL,
	},
	[ENR_RATE_DANGER] = {
		["PERCENT"] = 0,
		["COLOR"] = { R=1, G=0, B=0 },
		["TEXTURE"] = "Interface\\AddOns\\EN_NinjaRate\\EN_IconDanger",
		["SUGGEST"] = ENR_SUGGEST_DANGER,
	},
}

ENR_RATES = {
	[0] = {},
	[1] = {},
	[2] = {},
	[3] = {},
	[4] = {},
}

function ENR_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	EN_RegisterAddon(ENR_AddonId, ENR_AddonName, ENR_Version);
end;

function ENR_OnEvent(event)
	if (event == "VARIABLES_LOADED") then
		EN_Copyrights(ENR_AddonId);
	end;
end;

function ENR_NinjaRateFrame_OnLoad()
	this:RegisterEvent("START_LOOT_ROLL");
	ENR_NinjaRateFrame_Initialize();
end;

function ENR_NinjaRateFrame_OnEvent(event)
	if (event == "START_LOOT_ROLL") then
		ENR_LootRoll_Update(event);
	end;
end;

function ENR_NinjaRateFrame_OnEnter()
	local frameId = this:GetID();
	local groupType = ENR_GROUPTYPE_SOLO;
	local ratePercent, rateLevel, rateColor;
	local playerRateSuggest, playerRateColor;
	
	currentTooltip = ENR_NinjaRateTooltip;
	currentTooltip:SetOwner(this, "ANCHOR_TOPLEFT");
	currentTooltip:ClearLines();
	currentTooltip:AddLine("Ninja Rate");
	local currentLines = 2;
	
	-- Phase 1: Display player info
	playerName = UnitName("player");
	playerClass = UnitClass("player");
	if (playerClass and ENR_RATES[frameId][playerClass]) then
		ratePercent, rateLevel = ENR_GetRatePercentLevel(ENR_RATES[frameId][playerClass], ENR_RATES[frameId]["Max"])
		rateColor = ENR_RATE_DATA[rateLevel]["COLOR"];
		currentTooltip:AddDoubleLine(string.format("%s|cff999999(%s)|r", playerName, playerClass), string.format("%d (%d%%)", ENR_RATES[frameId][playerClass], ratePercent), 1, 1, 1, rateColor.R, rateColor.G, rateColor.B);
		playerRateColor = rateColor;
		playerRateSuggest = ENR_RATE_DATA[rateLevel]["SUGGEST"];
	else
		-- Data not initialized.
		return;
	end;

	-- Phase 2: Display raid info
	for index = 1, ENR_RAIDMEMBER_MAX, 1 do
		if (UnitExists("raid" .. index)) then
			groupType = ENR_GROUPTYPE_RAID;
			playerName, playerRank, playerSubgroup, playerLevel, playerClass, playerFileName, playerZone, playerOnline = GetRaidRosterInfo(index);
			if (playerClass and ENR_RATES[frameId][playerClass] and playerName ~= UnitName("player")) then
				ratePercent, rateLevel = ENR_GetRatePercentLevel(ENR_RATES[frameId][playerClass], ENR_RATES[frameId]["Max"])
				rateColor = ENR_RATE_DATA[rateLevel]["COLOR"];
				currentTooltip:AddDoubleLine(string.format("%s|cff999999(%s)|r", playerName, playerClass), string.format("%d (%d%%)", ENR_RATES[frameId][playerClass], ratePercent), 1, 1, 1, rateColor.R, rateColor.G, rateColor.B);
				currentLines = currentLines + 1;
				if (currentLines > ENR_TOOPTIP_MAXLINES) then
					currentTooltip:Show();
					currentTooltip = ENR_NinjaRateTooltip2;
					currentLines = 0;
					currentTooltip:SetOwner(ENR_NinjaRateTooltip, "ANCHOR_BOTTOMRIGHT");
					currentTooltip:ClearAllPoints();
					currentTooltip:SetPoint("TOPRIGHT","ENR_NinjaRateTooltip", "TOPLEFT",-0,0);
				end;				
			end;
		end;
	end;
	
	-- Phase 3: Display group info
	if (groupType == ENR_GROUPTYPE_SOLO) then
		for index = 1, ENR_GROUPMEMBER_MAX, 1 do
			if (GetPartyMember(index)) then
				groupType = ENR_GROUPTYPE_GROUP;
				playerName = UnitName("party" .. index);
				playerClass = UnitClass("party" .. index);
				if (playerClass and ENR_RATES[frameId][playerClass]) then
					ratePercent, rateLevel = ENR_GetRatePercentLevel(ENR_RATES[frameId][playerClass], ENR_RATES[frameId]["Max"])
					rateColor = ENR_RATE_DATA[rateLevel]["COLOR"];
					currentTooltip:AddDoubleLine(string.format("%s|cff999999(%s)|r", playerName, playerClass), string.format("%d (%d%%)", ENR_RATES[frameId][playerClass], ratePercent), 1, 1, 1, rateColor.R, rateColor.G, rateColor.B);
				end;
			end;
		end;
	end;
	
	-- Phase 3: Display footer
	currentTooltip:AddLine(ENR_RATES[frameId]["Desc"], 0, 1, 0);
	currentTooltip:AddLine(playerRateSuggest, playerRateColor.R, playerRateColor.G, playerRateColor.B);
	currentTooltip:AddLine(ENR_TOOLTIP_WARNING);
	ENR_NinjaRateTooltipTextLeft1:SetText(string.format("Ninja Rate(%s)", groupType));

	currentTooltip:Show();
	ENR_NinjaRateItemtip:SetOwner(this, "ANCHOR_LEFT");
	if (frameId > 0) then
		ENR_NinjaRateItemtip:SetLootRollItem(this:GetParent().rollID);
	end;
	ENR_NinjaRateItemtip:Show();
end;

function ENR_NinjaRateFrame_OnLeave()
	ENR_NinjaRateItemtip:Hide();
	ENR_NinjaRateTooltip:Hide();
	ENR_NinjaRateTooltip2:Hide();
end;

function ENR_NinjaRateFrame_Initialize()
	ENR_ClearRates();
end;

function ENR_LootRoll_Update(event)
	if (not arg1) then
		return;
	end;
	if (not this:GetParent().rollID) then
		return;
	end;
	local rollId = tonumber(arg1);
	if (rollId ~= tonumber(this:GetParent().rollID)) then
		return;
	end;
	
	ENR_NinjaRateItemtip:Hide();
	ENR_NinjaRateItemtip:SetLootRollItem(rollId);
	local frameId = this:GetID();
	
	ENR_NinjaRateFrame_Update(frameId);
end;

function ENR_NinjaRateFrame_Update(frameId)
	if (not frameId) then
		frameId = this:GetID();
	end;
	local tempText;
	local ItemDesc = "";
	
	ENR_ClearRates();

	for lineIndex = 1, ENR_NinjaRateItemtip:NumLines(), 1 do
		tempText = getglobal("ENR_NinjaRateItemtipTextLeft" .. lineIndex):GetText();
		if tempText then
			ItemDesc = ItemDesc .. tempText .. ENR_ITEMDESC_DELIMITER;
		end;
		tempText = getglobal("ENR_NinjaRateItemtipTextRight" .. lineIndex):GetText();
		if tempText then
			ItemDesc = ItemDesc .. tempText .. ENR_ITEMDESC_DELIMITER;
		end;
	end
	
	local groupType = ENR_GROUPTYPE_SOLO;
	ENR_RATES[frameId]["Max"] = 0;
	local playerClass;	

	-- Phase 1: Process Raid
	for index = 1, ENR_RAIDMEMBER_MAX, 1 do
		if (UnitExists("raid" .. index)) then
			groupType = ENR_GROUPTYPE_RAID;
			playerClass = UnitClass("raid" .. index);
			playerLevel = UnitLevel("raid" .. index);			
			if (playerClass and not ENR_RATES[frameId][playerClass]) then
				ENR_RATES[frameId][playerClass] = ENR_CalcRate(playerClass, playerLevel, ItemDesc);
			end;
		end;
	end;
	
	-- Phase 2: Process Group
	if (groupType == ENR_GROUPTYPE_SOLO) then
		for index = 1, ENR_GROUPMEMBER_MAX, 1 do
			if GetPartyMember(index) then
				groupType = ENR_GROUPTYPE_GROUP;
				playerClass = UnitClass("party" .. index);
				playerLevel = UnitLevel("raid" .. index);
				if (playerClass and not ENR_RATES[frameId][playerClass]) then
					ENR_RATES[frameId][playerClass] = ENR_CalcRate(playerClass, playerLevel, ItemDesc);
				end;
			end;
		end;
	end;
	
	-- Phase 3: Process Solo (to get Desc)
	playerClass = UnitClass("player");
	playerLevel = UnitLevel("player");
	ENR_RATES[frameId][playerClass], ENR_RATES[frameId]["Desc"] = ENR_CalcRate(playerClass, playerLevel, ItemDesc);

	-- Calc max rate
	for index, value in ENR_RATES[frameId] do
		if (index ~= "Max" and index ~= "Desc" and ENR_RATES[frameId]["Max"] < value) then
			ENR_RATES[frameId]["Max"] = value;
		end;
	end;
		
	if (ENR_RATES[frameId]["Max"] == 0) then
		for index, value in ENR_RATES[frameId] do
			if (index ~= "Desc") then
				ENR_RATES[frameId][index] = 100;
			end;
		end;
	end
	
	-- Set frame interface
	local ratePercent, rateLevel = ENR_GetRatePercentLevel(ENR_RATES[frameId][playerClass], ENR_RATES[frameId]["Max"]);
	local rateColor = ENR_RATE_DATA[rateLevel]["COLOR"];

	rateLabel = getglobal("ENR_NinjaRateFrame" .. frameId .. "RateLabel");
	rateLabel:SetText(string.format("%d%%", ratePercent));
	rateLabel:SetTextColor(rateColor.R, rateColor.G, rateColor.B);
	getglobal("ENR_NinjaRateFrame" .. frameId .. "RateIcon"):SetTexture(ENR_RATE_DATA[rateLevel]["TEXTURE"]);
end;

function ENR_ClearRates()
	ENR_RATES[this:GetID()] = {};
end;

function ENR_CalcRate(playerClass, playerLevel, itemDesc)
	if (ENR_DEBUG == 1) then
		DEFAULT_CHAT_FRAME:AddMessage(string.format("Class, Level, Dest = %s, %s, %s", playerClass, playerLevel, itemDesc));
	end;
	if (not playerClass) then
		return 0, "";
	end;
	if (not itemDesc) then
		return 0, "";
	end;
	
	local tooltipMsg = "";
	
	local patternIndex, propertyExists, propertyEnds, propertyValue;
	
	-- Phase 1: Get public power
	for index, value in ENR_PUBLIC_ITEMS do
		if (string.find(itemDesc, value)) then
			return 100, ENR_TOOLTIP_PUBLIC ;
		end;
	end;	
	
	-- Phase 2: Get suites power
	local suitePower = 1;
	for index, value in ENR_CLASS_SUITES do
		if (string.find(itemDesc, index) and playerClass == value) then
			suitePower = ENR_SUITES_AMPLIFIER;
		end;
	end; 
	
	-- Phase 3: Get item type power
	local testPattern = ENR_CLASS_ITEM_RULES[playerClass];
	local itemPower = 1;
	for patternIndex = 1 , string.len(testPattern), 1 do
		if (string.find(itemDesc, ENR_ITEM_INDEX[patternIndex], 1, true)) then
			itemPower = tonumber(string.sub(testPattern, patternIndex, patternIndex));
			if (playerLevel) then
				if (playerLevel >= 40 and patternIndex < ENR_CLASS_ITEM_RULES_LVL40[playerClass]) then
					itemPower = itemPower * ENR_PROPERTY_AMPLIFIER_LVL40;
				end;				
			end;		
		end;
	end;
	
	-- Phase 4: Get property power
	local propertyPower = 0;
	testPattern = ENR_CLASS_PROPERTY_RULES[playerClass];
	for patternIndex = 1, string.len(testPattern), 1 do
		propertyExists, propertyEnds, propertyValue = string.find(itemDesc, ENR_PROPERTY_INDEX[patternIndex]);
		if (propertyExists) then
			propertyPower = propertyPower + tonumber(propertyValue) * tonumber(string.sub(testPattern, patternIndex, patternIndex));
		end;
	end;

	-- Phase 5: Get special item power
	local specialPower = 0;
	testPattern = ENR_CLASS_SPECIALITEM_RULES[playerClass];
	for patternIndex = 1, string.len(testPattern), 1 do
		propertyExists, propertyEnds = string.find(itemDesc, ENR_SPECIALITEM_INDEX[patternIndex]);
		if (propertyExists) then
			specialPower = specialPower + ENR_SPECIALITEM_AMPLIFIER * tonumber(string.sub(testPattern, patternIndex, patternIndex));
		end;
	end;

	-- Phase 6: Get extra property power
	local extraPropertyPower = 0;
	testPattern = ENR_CLASS_EXTRAPROPERTY_RULES[playerClass];
	for patternIndex = 1, string.len(testPattern), 1 do
		if (string.find(itemDesc, ENR_EXTRAPROPERTY_INDEX[patternIndex])) then
			extraPropertyPower = extraPropertyPower + ENR_EXTRAPROPERTY_AMPLIFIER * tonumber(string.sub(testPattern, patternIndex, patternIndex));
		end;
	end;
	
	-- Phase 6: Get final power
	local totalPropertyPower = propertyPower + specialPower + extraPropertyPower;
	if (totalPropertyPower == 0) then
		totalPropertyPower = 1;
	end;
	local finalPower = suitePower * itemPower * totalPropertyPower;
	if (ENR_DEBUG == 1) then
		DEFAULT_CHAT_FRAME:AddMessage(string.format("total=suit*item*(prop+special+extra) %s=%s*%s*(%s+%s+%s)%s", finalPower, suitePower, itemPower, propertyPower, specialPower, extraPropertyPower, totalPropertyPower));
	end;

	return finalPower, "";	
end;

function ENR_GetRatePercentLevel(rate, maxRate)
	local ratePercent;
	if (not rate or not maxRate) then
		ratePercent = 100;
	else
		ratePercent = rate * 100 / maxRate;
	end;
	local rateLevel = ENR_RATE_SAFE;
	if ( ratePercent < ENR_RATE_DATA[ENR_RATE_SAFE]["PERCENT"] ) then
		rateLevel = ENR_RATE_NORMAL;
	end;
	if ( ratePercent < ENR_RATE_DATA[ENR_RATE_NORMAL]["PERCENT"] ) then
		rateLevel = ENR_RATE_DANGER;
	end;
	return ratePercent, rateLevel;
end;
