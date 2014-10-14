DMF_ATTACKING = nil;
DMF_INCOMBAT = nil;
DMF_PET_ATTACKING = nil;
DMF_REGEN = true;

function DMF_OnLoad()
	this:RegisterEvent("PET_ATTACK_START");
	this:RegisterEvent("PET_ATTACK_STOP");
	this:RegisterEvent("PLAYER_ENTER_COMBAT");
	this:RegisterEvent("PLAYER_LEAVE_COMBAT");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");

	SlashCmdList["DMF"] = _Slash_Handler;
	SLASH_1 = "/dmf";
	SLASH_2 = "/discordmacrofunctions";
end

function DMF_OnEvent(event)
	if (event == "PET_ATTACK_START") then
		DMF_PET_ATTACKING = true;
	elseif (event == "PLAYER_ENTERING_WORLD") then
		DMF_ATTACKING = nil;
		DMF_INCOMBAT = nil;
		DMF_REGEN = true;
		DMF_Tooltip:SetOwner(UIParent, "ANCHOR_NONE");
	elseif (event == "PET_ATTACK_STOP") then
		DMF_PET_ATTACKING = nil;
	elseif (event == "PLAYER_ENTER_COMBAT") then
		DMF_ATTACKING = true;
		DMF_INCOMBAT = true;
	elseif (event == "PLAYER_LEAVE_COMBAT") then
		DMF_ATTACKING = nil;
		if (DMF_REGEN) then
			DMF_INCOMBAT = nil;
		end
	elseif (event == "PLAYER_REGEN_ENABLED") then
		DMF_REGEN = true;
		if (not DMF_ATTACKING) then
			DMF_INCOMBAT = nil;
		end
	elseif (event == "PLAYER_REGEN_DISABLED") then
		DMF_REGEN = nil;
		DMF_INCOMBAT = true;
	end
end

function DMF_OnUpdate()
	
end

function DMF_Slash_Handler(msg)
	local command, arg;
	local index = string.find(msg, " ");

	if( index) then
		command = string.sub(msg, 1, (index - 1));
		param = string.sub(msg, (index + 1)  );
	else
		command = msg;
	end
   
	if ( command == "" ) then

	end
end

function DMF_Debug(msg)
	DEFAULT_CHAT_FRAME:AddMessage( msg, 1.0, 0.0, 0.0 );
end

function DMF_Feedback(msg)
	DEFAULT_CHAT_FRAME:AddMessage( msg, 1.0, 1.0, 0.0 );
end

-- Macro functions start here

function DMF_IA()
	return DMF_ATTACKING;
end
ImAttacking = DMF_IA;

function DMF_IIC()
	return DMF_INCOMBAT;
end
ImInCombat = DMF_IIC;

function DMF_HP(unit)
	if (not unit) then unit = "player"; end
	if (UnitHealth(unit) and UnitHealthMax(unit) and UnitHealthMax(unit) > 0) then
		return UnitHealth(unit) / UnitHealthMax(unit);
	else
		return 0;
	end
end
HealthPercent = DMF_HP;

function DMF_MP(unit)
	if (not unit) then unit = "player"; end
	if (UnitMana(unit) and UnitManaMax(unit) and UnitManaMax(unit) > 0) then
		return UnitMana(unit) / UnitManaMax(unit);
	else
		return 0;
	end
end
ManaPercent = DMF_MP;

function DMF_Buff(buffname, unit)
	if (not unit) then unit = "player"; end
	if (not UnitName(unit)) then return; end
	if (DL_CheckBuff) then
		return DL_CheckBuff(unit, buffname);
	end
	buffname = string.upper(buffname);
	local text;
	for i = 1, 16 do
		if (UnitBuff(unit, i)) then
			DMF_Tooltip:SetUnitBuff(unit, i);
			if (DMF_TooltipTextLeft1:IsShown()) then
				text = string.upper(DMF_TooltipTextLeft1:GetText());
				if (string.find(text, buffname, 1, true)) then
					return true;
				end
			end
		else
			return;
		end
	end
end
CheckForBuff = DMF_Buff;

function DMF_Debuff(buffname, unit)
	if (not unit) then unit = "player"; end
	if (not UnitName(unit)) then return; end
	if (DL_CheckDebuff) then
		return DL_CheckDebuff(unit, buffname);
	end
	buffname = string.upper(buffname);
	local text;
	for i = 1, 16 do
		if (UnitDebuff(unit, i)) then
			DMF_Tooltip:SetUnitDebuff(unit, i);
			if (DMF_TooltipTextLeft1:IsShown()) then
				text = string.upper(DMF_TooltipTextLeft1:GetText());
				if (string.find(text, buffname, 1, true)) then
					return i;
				end
			end
		else
			return;
		end
	end
end
CheckForDebuff = DMF_Debuff;

function DMF_XDebuff(buffname, lines, unit)
	if (not unit) then unit = "player"; end
	if (not UnitName(unit)) then return; end
	if ((not lines) or lines < 1) then
		lines = 5;
	elseif (lines > 30) then
		lines = 30;
	end
	buffname = string.upper(buffname);
	local text;
	local line;
	for i = 1, 16 do
		if (UnitDebuff(unit, i)) then
			DMF_Tooltip:SetUnitDebuff(unit, i);
			for t = 1, lines do
				line = getglobal("DMF_TooltipTextLeft"..t);
				if (line:IsShown()) then
					text = string.upper(line:GetText());
					if (text and string.find(text, buffname, 1, true)) then
						return true;
					end
				end
			end
			for t = 1, lines do
				line = getglobal("DMF_TooltipTextRight"..t);
				if (line:IsShown()) then
					text = string.upper(line:GetText());
					if (text and string.find(text, buffname, 1, true)) then
						return true;
					end
				end
			end
		else
			return;
		end
	end
end
ExtendedCheckForDebuff = DMF_XDebuff;

function DMF_Status(buffname, unit)
	if (not unit) then unit = "player"; end
	if (not UnitName(unit)) then return 0; end
	if (DL_CheckStatus) then
		return DL_CheckStatus(unit, buffname);
	end
	local count = 0;
	buffname = string.upper(buffname);
	local text;
	for i = 1, 16 do
		if (UnitDebuff(unit, i)) then
			DMF_Tooltip:SetUnitDebuff(unit, i);
			if (DMF_TooltipTextRight1:IsShown()) then
				text = string.upper(DMF_TooltipTextRight1:GetText());
				if (string.find(text, buffname, 1, true)) then
					count = count + 1;
				end
			end
		else
			return count;
		end
	end
	return count;
end
CheckForStatus = DMF_Status;

function DMF_ACD(action)
	if (tonumber(action)) then
		action = tonumber(action);
		local start = GetActionCooldown(action);
		if (start > 0) then
			return true;
		else
			return;
		end
	else
		action = string.upper(action);
		for i = 1, 120 do
			if (HasAction(i)) then
				DMF_Tooltip:SetAction(i);
				if (DMF_TooltipTextLeft1:IsShown()) then
					text = string.upper(DMF_TooltipTextLeft1:GetText());
					if (string.find(text, action, 1, true)) then
						local start = GetActionCooldown(i);
						if (start > 0) then
							return true;
						else
							return;
						end
					end
				end
			end
		end
	end
end
IsActionCoolingDown = DMF_ACD;

function DMF_TLHP(party, raid, pets, actualhealth, unitIDonly)
	local health, lowesthealth;
	local lowestunit, unit = "player";
	lowesthealth = DMF_GetHealth(lowestunit, actualhealth);
	if (raid == 1) then
		for i=1, GetNumRaidMembers() do
			unit = "raid"..i;
			health = DMF_GetHealth(unit, actualhealth);
			if (UnitIsVisible(unit) and UnitIsConnected(unit) and health > 0 and health < lowesthealth) then
				lowesthealth = health;
				lowestunit = unit;
			end
			if (pets == 1) then
				unit = "raidpet"..i;
				health = DMF_GetHealth(unit, actualhealth);
				if (UnitIsVisible(unit) and UnitIsConnected(unit) and health > 0 and health < lowesthealth) then
					lowesthealth = health;
					lowestunit = unit;
				end
			end
		end
	elseif (party == 1) then
		for i=1, GetNumPartyMembers() do
			unit = "party"..i;
			health = DMF_GetHealth(unit, actualhealth);
			if (UnitIsVisible(unit) and UnitIsConnected(unit) and health > 0 and health < lowesthealth) then
				lowesthealth = health;
				lowestunit = unit;
			end
			if (pets == 1) then
				unit = "partypet"..i;
				health = DMF_GetHealth(unit, actualhealth);
				if (UnitIsVisible(unit) and UnitIsConnected(unit) and health > 0 and health < lowesthealth) then
					lowesthealth = health;
					lowestunit = unit;
				end
			end
		end
	end
	if (unitIDonly == 1) then
		return lowestunit;
	else
		TargetUnit(lowestunit);
	end
end
TargetLowestHealthPlayer = DMF_TLHP;

function DMF_GetHealth(unit, toggle)
	if (toggle) then
		return UnitHealth(unit);
	else
		if (UnitHealthMax(unit) > 0) then
			return UnitHealth(unit) / UnitHealthMax(unit);
		else
			return 100;
		end
	end
end

function DMF_IPA()
	return DMF_PET_ATTACKING;
end
IsPetAttacking = DMF_IPA;

function DMF_TLHT(party, raid, pets, unitIDonly)
	local health, lowesthealth;
	local lowestunit, unit = "target";
	lowesthealth = UnitHealth(lowestunit);
	if (raid == 1) then
		for i=1, GetNumRaidMembers() do
			unit = "raid"..i.."target";
			health = UnitHealth(unit);
			if (UnitIsShown(unit) and health > 0 and health < lowesthealth) then
				lowesthealth = health;
				lowestunit = unit;
			end
			if (pets == 1) then
				unit = "raidpet"..i.."target";
				health = UnitHealth(unit);
				if (UnitIsShown(unit) and health > 0 and health < lowesthealth) then
					lowesthealth = health;
					lowestunit = unit;
				end
			end
		end
	elseif (party == 1) then
		for i=1, GetNumPartyMembers() do
			unit = "party"..i.."target";
			health = UnitHealth(unit);
			if (UnitIsShown(unit) and health > 0 and health < lowesthealth) then
				lowesthealth = health;
				lowestunit = unit;
			end
			if (pets == 1) then
				unit = "partypet"..i.."target";
				health = DMF_GetHealth(unit, actualhealth);
				if (UnitIsShown(unit) and health > 0 and health < lowesthealth) then
					lowesthealth = health;
					lowestunit = unit;
				end
			end
		end
	end
	if (unitIDonly == 1) then
		return lowestunit;
	else
		TargetUnit(lowestunit);
	end
end
TargetLowestHealthTarget = DMF_TLHT;

function DMF_CB(name, dontcast)
	local level = UnitLevel("target");
	if (level == -1 or (not UnitName("target"))) then
		level = 60;
	end
	local ranknum = 0;
	if (name==DMF_MINLVL_SPELLS.Renew) then
		if (level < 4) then ranknum = 1;
		elseif (level < 10) then ranknum = 2;
		elseif (level < 16) then ranknum = 3;
		elseif (level < 22) then ranknum = 4;
		elseif (level < 28) then ranknum = 5;
		elseif (level < 34) then ranknum = 6;
		elseif (level < 40) then ranknum = 7;
		elseif (level < 46) then ranknum = 8;
		else ranknum = 9; end
	elseif (name==DMF_MINLVL_SPELLS.PWFortitude) then
		if (level < 2) then ranknum = 1;
		elseif (level < 14) then ranknum = 2;
		elseif (level < 26) then ranknum = 3;
		elseif (level < 38) then ranknum = 4;
		elseif (level < 50) then ranknum = 5;
		else ranknum = 6; end
	elseif (name==DMF_MINLVL_SPELLS.DampenMagic) then
		if (level < 2) then ranknum = 0;
		elseif (level < 14) then ranknum = 1;
		elseif (level < 26) then ranknum = 2;
		elseif (level < 38) then ranknum = 3;
		elseif (level < 50) then ranknum = 4;
		else ranknum = 5; end
	elseif (name==DMF_MINLVL_SPELLS.AmplifyMagic) then
		if (level < 8) then ranknum = 0;
		elseif (level < 20) then ranknum = 1;
		elseif (level < 32) then ranknum = 2;
		elseif (level < 44) then ranknum = 3;
		else ranknum = 4; end
	elseif (name==DMF_MINLVL_SPELLS.DivineSpirit) then
		if (level < 30) then ranknum = 0;
		elseif (level < 32) then ranknum = 1;
		elseif (level < 44) then ranknum = 2;
		else ranknum = 3; end
	elseif (name==DMF_MINLVL_SPELLS.ShadowProtection) then
		if (level < 20) then ranknum = 0;
		elseif (level < 32) then ranknum = 1;
		elseif (level < 46) then ranknum = 2;
		else ranknum = 3; end
	elseif (name==DMF_MINLVL_SPELLS.PWShield) then
		if (level < 2) then ranknum = 1;
		elseif (level < 8) then ranknum = 2;
		elseif (level < 14) then ranknum = 3;
		elseif (level < 20) then ranknum = 4;
		elseif (level < 26) then ranknum = 5;
		elseif (level < 32) then ranknum = 6;
		elseif (level < 38) then ranknum = 7;
		elseif (level < 44) then ranknum = 8;
		elseif (level < 50) then ranknum = 9;
		else ranknum = 10; end
	elseif (name==DMF_MINLVL_SPELLS.MarkOfTheWild) then
		if (level < 10) then ranknum = 2;
		elseif (level < 20) then ranknum = 3;
		elseif (level < 30) then ranknum = 4;
		elseif (level < 40) then ranknum = 5;
		elseif (level < 50) then ranknum = 6;
		else ranknum = 7; end
	elseif (name==DMF_MINLVL_SPELLS.Rejuvenation) then
		if (level < 6) then ranknum = 2;
		elseif (level < 12) then ranknum = 3;
		elseif (level < 18) then ranknum = 4;
		elseif (level < 24) then ranknum = 5;
		elseif (level < 30) then ranknum = 6;
		elseif (level < 36) then ranknum = 7;
		elseif (level < 42) then ranknum = 8;
		elseif (level < 48) then ranknum = 9;
		else ranknum = 10; end
	elseif (name==DMF_MINLVL_SPELLS.Thorns) then
		if (level < 4) then ranknum = 1;
		elseif (level < 14) then ranknum = 2;
		elseif (level < 24) then ranknum = 3;
		elseif (level < 34) then ranknum = 4;
		elseif (level < 44) then ranknum = 5;
		else ranknum = 6; end
	elseif (name==DMF_MINLVL_SPELLS.Regrowth) then
		if (level < 2) then ranknum = 0;
		elseif (level < 8) then ranknum = 1;
		elseif (level < 14) then ranknum = 2;
		elseif (level < 20) then ranknum = 3;
		elseif (level < 26) then ranknum = 4;
		elseif (level < 32) then ranknum = 5;
		elseif (level < 38) then ranknum = 6;
		elseif (level < 44) then ranknum = 7;
		elseif (level < 50) then ranknum = 8;
		else ranknum = 9; end
	elseif (name==DMF_MINLVL_SPELLS.ArcaneIntellect) then
		if (level < 4) then ranknum = 1;
		elseif (level < 18) then ranknum = 2;
		elseif (level < 32) then ranknum = 3;
		elseif (level < 46) then ranknum = 4;
		else ranknum = 5; end
	elseif (name==DMF_MINLVL_SPELLS.BlessingMight) then
		if (level < 2) then ranknum = 1;
		elseif (level < 12) then ranknum = 2;
		elseif (level < 22) then ranknum = 3;
		elseif (level < 32) then ranknum = 4;
		elseif (level < 42) then ranknum = 5;
		elseif (level < 52) then ranknum = 6;
		else ranknum = 7; end
	elseif (name==DMF_MINLVL_SPELLS.BlessingProtection) then
		if (level < 14) then ranknum = 1;
		elseif (level < 28) then ranknum = 2;
		else ranknum = 3; end
	elseif (name==DMF_MINLVL_SPELLS.BlessingWisdom) then
		if (level < 4) then ranknum = 0;
		elseif (level < 14) then ranknum = 1;
		elseif (level < 24) then ranknum = 2;
		elseif (level < 34) then ranknum = 3;
		elseif (level < 44) then ranknum = 4;
		else ranknum = 5; end
	elseif (name==DMF_MINLVL_SPELLS.BlessingFreedom) then
		if (level < 8) then ranknum = 0; end
	elseif (name==DMF_MINLVL_SPELLS.BlessingSalvation) then
		if (level < 16) then ranknum = 0; end
	elseif (name==DMF_MINLVL_SPELLS.AbolishDisease) then
		if (level < 22) then ranknum = 0; end
	elseif (name==DMF_MINLVL_SPELLS.AbolishPoison) then
		if (level < 16) then ranknum = 0; end
	elseif (name==DMF_MINLVL_SPELLS.BlessingSanctuary) then
		if (level < 20) then ranknum = 0;
		elseif (level < 30) then ranknum = 1;
		elseif (level < 40) then ranknum = 2;
		elseif (level < 50) then ranknum = 3;
		else ranknum = 4; end
	elseif (name==DMF_MINLVL_SPELLS.BlessingLight) then
		if (level < 30) then ranknum = 0;
		elseif (level < 40) then ranknum = 1;
		elseif (level < 50) then ranknum = 2;
		else ranknum = 3; end
	elseif (name==DMF_MINLVL_SPELLS.BlessingKings) then
		if (level < 30) then ranknum = 0; end
	elseif (name==DMF_MINLVL_SPELLS.BlessingSacrifice) then
		if (level < 36) then ranknum = 0;
		elseif (level < 44) then ranknum = 1;
		else ranknum = 2; end
	end
	if ( ranknum == 0 ) then
		DMF_Feedback(DMF_TEXT.LevelTooLow);
		return false;
	else
		for r=ranknum, 1, -1 do
			local spellid = DMF_GetSpellID(name.."("..DMF_TEXT.Rank..r..")");
			if (spellid) then
				if (not dontcast) then
					CastSpell( spellid, "BOOKTYPE_SPELL" );
				end
				return spellid;
			end
		end
	end
end
CorrectBuff = DMF_CB;

function DMF_GetSpellID(name)
	local id = 1;
	while (true) do
		local spellName, spellRank = GetSpellName(id, BOOKTYPE_SPELL);
		if (not spellName) then
			return;
		end
		if (spellName.."("..spellRank..")" == name) then
			return id;
		end
		id = id + 1;
	end
end

function DMF_Get_ItemName(bag, slot)
	local itemname, itemlink;
	if (slot) then
		itemlink = GetContainerItemLink(bag,slot);
	else
		itemlink = GetInventoryItemLink("player", bag);
	end
	if (itemlink) then
		itemname = string.sub(itemlink, string.find(itemlink, "[", 1, true) + 1, string.find(itemlink, "]", 1, true) - 1);
	end
	return itemname;
end

function DMF_UIBN(name, dontuse)
	local itemlink, itemname, itemid;
	for _, slot in DMF_SLOTS do
		itemid = GetInventorySlotInfo(slot);
		itemname = DMF_Get_ItemName(itemid);
		if (itemname and string.find(itemname, name, 1, true)) then
			if (not dontuse) then
				UseInventoryItem(itemid);
			end
			return itemid, slot;
		end
	end
	for bag = 0,  4 do
		local bagslots = GetContainerNumSlots(bag);
		if (bagslots) then
			for slot = 1, bagslots do
				itemname = DMF_Get_ItemName(bag, slot);
				if (itemname and string.find(itemname, name, 1, true)) then
					if (not dontuse) then
						UseContainerItem(bag, slot);
					end
					return bag, slot;
				end
			end
		end
	end
end
UseItemByName = DMF_UIBN;

function DMF_IVT(name)
	if (not DMF_TARGET_SPELLS[name]) then return true; end
	local creatureType = UnitCreatureType("target");
	if (not creatureType) then creatureType = DMF_TEXT.Humanoid; end
	if (DMF_TARGET_SPELLS[name] == "MANA") then
		if (UnitPowerType("target") == 0 and UnitManaMax("target") > 0) then
			return true;
		else
			return;
		end
	elseif (DMF_TARGET_SPELLS[name] == "PARTY") then
		if (UnitInParty("target") or UnitInRaid("target")) then
			return true;
		else
			return;
		end
	elseif (DMF_TARGET_SPELLS[name] == "PLAYER") then
		if (UnitIsPlayer("target")) then
			return true;
		else
			return;
		end
	elseif (DMF_TARGET_SPELLS[name][creatureType]) then
		return true;
	end
end
IsValidTarget = DMF_IVT;

function DMF_GCSF()
	for i=1,GetNumShapeshiftForms() do
		local _, name, isActive = GetShapeshiftFormInfo(i);
		if isActive == 1 then return name, i; end
	end
	return DMF_TEXT.Humanoid, 0;
end
GetCurrentShapeshiftForm = DMF_GCSF;

function DMF_GCT()
	
end
GetCurrentTracking = DMF_GCT;

function DMF_GAI(action)
	action = string.upper(action);
	local text;
	for i = 1, 120 do
		DMF_Tooltip:SetAction(i);
		if (DMF_TooltipTextLeft1:IsShown()) then
			text = DMF_TooltipTextLeft1:GetText();
			if (text) then
				text = string.upper(text);
				if (string.find(text, action, 1, true)) then
					return i;
				end
			end
		end
	end
end
GetActionID = DMF_GAI;

function DMF_HL(unit)
	if (not unit) then unit = "player"; end
	return UnitHealthMax(unit) - UnitHealth(unit);
end
HealthLost = DMF_HL;

function DMF_ML(unit)
	if (not unit) then unit = "player"; end
	return UnitManaMax(unit) - UnitMana(unit);
end
ManaLost = DMF_ML;

function DMF_EMH(name)
	for bag = 0,  4 do
		local bagslots = GetContainerNumSlots(bag);
		if (bagslots) then
			for slot = 1, bagslots do
				itemname = DMF_Get_ItemName(bag, slot);
				if (itemname and string.find(itemname, name, 1, true)) then
					PickupContainerItem(bag, slot);
					PickupInventoryItem(16);
					return;
				end
			end
		end
	end
end
EquipMainHand = DMF_EMH;

function DMF_EOH(name, same)
	for bag = 0,  4 do
		local bagslots = GetContainerNumSlots(bag);
		if (bagslots) then
			for slot = 1, bagslots do
				itemname = DMF_Get_ItemName(bag, slot);
				if (itemname and string.find(itemname, name, 1, true)) then
					local _, _, locked = GetContainerItemInfo(bag, slot);
					if (not locked) then
						PickupContainerItem(bag, slot);
						PickupInventoryItem(17);
						return;
					end
				end
			end
		end
	end
end
EquipOffHand = DMF_EOH;

function DMF_EBH(name, name2)
	local same;
	if (name == name2) then same = 1; end
	DMF_EMH(name);
	DMF_EOH(name2, same);
end
EquipBothHands = DMF_EBH;

function DMF_CR(action)
	if (not tonumber(action)) then
		action = GetActionID(action);
	end
	if (not action) then return; end
	local start, duration, enable = GetActionCooldown(action);
	if (start and duration) then
		local remaining = duration - (GetTime() - start);
		if (remaining > 0) then
			return remaining;
		else
			return 0;
		end
	else
		return 0;
	end
end
CooldownRemaining = DMF_CR;

function DMF_IGC(action)
	if (not tonumber(action)) then
		action = GetActionID(action);
	end
	if (not action) then return; end
	local start, duration, enable = GetActionCooldown(action);
	if (duration and duration > 2) then
		return true;
	end
end
IsGlobalCooldown = DMF_IGC;

function DMF_FP(foodname, foodname2, foodname3, foodname4, foodname5)
	local bag, slot = UseItemByName(foodname, 1);
	if ((not bag) and foodname2) then
		bag, slot = UseItemByName(foodname2, 1);
	end
	if ((not bag) and foodname3) then
		bag, slot = UseItemByName(foodname3, 1);
	end
	if ((not bag) and foodname4) then
		bag, slot = UseItemByName(foodname4, 1);
	end
	if ((not bag) and foodname5) then
		bag, slot = UseItemByName(foodname5, 1);
	end
	if (bag) then
		PickupContainerItem(bag, slot);
		DropItemOnUnit("pet");
		if (CursorHasItem()) then
			PickupContainerItem(bag, slot);
		end
	end
end
FeedPet = DMF_FP;

function DMF_SC(text, override, unit)
	if (not text) then return; end

	local target = "";
	local lang = ChatFrameEditBox.language;
	local channel = "SAY";
	if (GetNumPartyMembers() > 0) then channel = "PARTY"; end
	if (GetNumRaidMembers() > 0) then channel = "RAID"; end
	if (unit) then
		target = UnitName(unit);
		channel = "WHISPER";
	end

	if (override and channel=="SAY") then return; end

	SendChatMessage(text, channel, lang, target);
end
SmartChat = DMF_SC;

function DMF_RM(macroname)
	local _, _, body = GetMacroInfo(GetMacroIndexByName(macroname));

	if ( (not body) or body == "" ) then return; end

	local length = string.len(body);
	local text="";
	for i = 1, length do
		text=text..string.sub(body,i,i);
		if ( string.sub(body,i,i) == "\n" or i == length ) then
			if ( string.find(text,"/cast") ) then
				local i, booktype = DMF_GetSpell(gsub(text,"%s*/cast%s*(.*)%s;*.*","%1"));
				if ( i ) then
					RunScript("CastSpell("..i..",'"..booktype.."')");
				end
			else
				while ( string.find(text, "CastSpellByName")) do
					local spell = gsub(text,'.-CastSpellByName.-%(.-"(.-)".*','%1',1);
					local i, booktype = DMF_GetSpell(spell);
					if ( i ) then
						text = gsub(text,'CastSpellByName.-%(.-".-"','CastSpell('..i..','..'"'..booktype..'"',1);
					else
						text = gsub(text,'CastSpellByName.-%(.-".-"%)','',1);
					end
				end
				if ( string.find(text,"/script")) then
					RunScript(gsub(text,"%s*/script%s*(.*)","%1"));
				else
					DMF_MacroBox:SetText(text);
					ChatEdit_SendText(DMF_MacroBox);
				end
			end
			text="";
		end
	end
end
RunMacro = DMF_RM;

function DMF_GetSpell(spell)
	local s = gsub(spell, "%s-(.-)%s*%(.*","%1");
	local r;
	if ( string.find(spell, "%(%s*[Rr]acial")) then
		r = "racial"
	elseif ( string.find(spell, "%(%s*[Ss]ummon")) then
		r = "summon"
	elseif ( string.find(spell, "%(%s*[Aa]pprentice")) then
		r = "apprentice"
	elseif ( string.find(spell, "%(%s*[Jj]ourneyman")) then
		r = "journeyman"
	elseif ( string.find(spell, "%(%s*[Ee]xpert")) then
		r = "expert"
	elseif ( string.find(spell, "%(%s*[Aa]rtisan")) then
		r = "artisan"
	elseif ( string.find(spell, "%(%s*[Mm]aster")) then
		r = "master"
	elseif ( not string.find(spell, "%(")) then
		r = ""
	else
		r = gsub(spell, ".*%(.*[Rr]ank%s*(%d+).*", "Rank %1");
	end
	return DMF_FindSpell(s,r);
end

function DMF_FindSpell(spell, rank)
	local i = 1;
	local booktype = "spell";
	local s,r;
	local ys, yr;
	while true do
		s, r = GetSpellName(i,"spell");
		if ( not s ) then break; end
		if ( string.lower(s) == string.lower(spell)) then ys=true; end
		if ( (r == rank) or (r and rank and string.lower(r) == string.lower(rank))) then yr=true; end
		if ( ys and yr ) then
			return i,booktype;
		end
		i=i+1;
		ys = nil;
		yr = nil;
	end
	i = 1;
	while true do
		s, r = GetSpellName(i,"pet");
		if ( not s) then break; end
		if ( string.lower(s) == string.lower(spell)) then ys=true; end
		if ( (r == rank) or (r and rank and string.lower(r) == string.lower(rank))) then yr=true; end
		if ( ys and yr ) then
			booktype = "pet";
			return i,booktype;
		end
		i=i+1;
		ys = nil;
		yr = nil;
	end
	return nil, booktype;
end

function DMF_PABN(action)
	if (not action) then return; end
	if (action == "") then return; end
	action = string.upper(action);
	for i=1, GetNumMacros() do
		local name = GetMacroInfo(i);
		if (name and string.find(string.upper(name), action, 1, true)) then
			PickupMacro(i);
			return true;
		end
	end
	local spellID = 0;
	while (true) do
		spellID = spellID + 1;
		local spellName, spellRank = GetSpellName(spellID, BOOKTYPE_SPELL);
		if (not spellName) then
			break;
		end
		if (spellRank and spellRank ~= "") then
			spellName = string.upper(spellName.." ("..spellRank..")");
		else
			spellName = string.upper(spellName);
		end
		if (string.find(spellName, action, 1, true)) then
			PickupSpell(spellID, BOOKTYPE_SPELL);
			return true;
		end
	end
	if (HasPetSpells()) then
		local spellID = 0;
		while (true) do
			spellID = spellID + 1;
			local spellName, spellRank = GetSpellName(spellID, BOOKTYPE_PET);
			if (not spellName) then
				break;
			end
			if (spellRank and spellRank ~= "") then
				spellName = string.upper(spellName.." ("..spellRank..")");
			else
				spellName = string.upper(spellName);
			end
			if (string.find(spellName, action, 1, true)) then
				PickupSpell(spellID, BOOKTYPE_PET);
				return true;
			end
		end
	end
	for bag=0,4 do
		local bagslots = GetContainerNumSlots(bag);
		if (bagslots) then
			for slot = 1, bagslots do
				local itemname = DMF_Get_ItemName(bag, slot);
				if (itemname) then
					itemname = string.upper(itemname);
					if (string.find(itemname, action, 1, true)) then
						PickupContainerItem(bag, slot);
						return true, 1;
					end
				end
			end
		end
	end
	for _, slot in DMF_SLOTS do
		local itemid = GetInventorySlotInfo(slot);
		local itemname = DMF_Get_ItemName(itemid);
		if (itemname and string.find(string.upper(itemname), action, 1, true)) then
			PickupInventoryItem(itemid);
			return true, 1;
		end
	end
end
PickupActionByName = DMF_PABN;

function DMF_CA(actionID, actionName)
	if (not actionID) then return; end
	if (not tonumber(actionID)) then return; end
	if (actionID < 1 or actionID > 120) then return; end
	if ((not actionName) or actionName == "") then return; end
	local gotAction, actionType = DMF_PABN(actionName);
	if (gotAction) then
		PlaceAction(actionID);
		PickupSpell(999, BOOKTYPE_SPELL);
	end
end
ChangeAction = DMF_CA;

function DMF_CNB(buffname)
	buffname = string.upper(buffname);
	local text;
	local buffID;
	for i = 0, 15 do
		local buffIndex = GetPlayerBuff(i, "HELPFUL");
		DMF_Tooltip:SetPlayerBuff(buffIndex);
		if (DMF_TooltipTextLeft1:IsShown()) then
			text = string.upper(DMF_TooltipTextLeft1:GetText());
			if (string.find(text, buffname, 1, true)) then
				buffID = buffIndex;
				break;
			end
		end
	end
	if (buffID) then
		CancelPlayerBuff(buffID);
	end
end
CancelBuff = DMF_CNB;

function DMF_UID(name, override)
	local unitID;
	for i=1,40 do
		if (i < 5) then
			if (UnitName("party"..i) == name) then
				unitID = "party"..i;
				break;
			end
			if (UnitName("partypet"..i) == name) then
				unitID = "partypet"..i;
				break;
			end
		end
		if (UnitName("raid"..i) == name) then
			unitID = "raid"..i;
			break;
		end
	end
	if (unitID and not override) then
		DL_Feedback(name.."'s unit ID is "..unitID);
	end
	return unitID;
end
GetUnitID = DMF_UID;