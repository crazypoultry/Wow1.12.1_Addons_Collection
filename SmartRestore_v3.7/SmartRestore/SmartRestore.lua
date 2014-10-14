--------------------------------------------
-- SmartRestore for WoW
-- By ScepraX
--------------------------------------------
SMARTRESTORE_VERSION = GetAddOnMetadata("SmartRestore", "Version");
BINDING_HEADER_SMARTRESTORE = "SmartRestore v" .. SMARTRESTORE_VERSION;

local debugMode = 0;

local ALTERACVALLEY = "Alterac Valley";
local WARSONGGULCH = "Warsong Gulch";
local ARATHIBASIN = "Arathi Basin";
if (GetLocale() == "frFR") then
	ALTERACVALLEY = "Vall\195\169e d'Alterac";
	WARSONGGULCH = "Goulet des Warsong";
	ARATHIBASIN = "Bassin d'Arathi";
elseif (GetLocale() == "deDE") then
	ALTERACVALLEY = "Alteractal";
	WARSONGGULCH = "Warsongschlucht";
	ARATHIBASIN = "Arathibecken";
end

-- Initialization code for this addon
function SR_Initialization()
	SlashCmdList["SMARTRESTORE"] = SmartRestoreCommand;
	SLASH_SMARTRESTORE1 = "/sr";
	SLASH_SMARTRESTORE2 = "/SR";
	SLASH_SMARTRESTORE3 = "/smartrestore";
	
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("TRADE_SKILL_UPDATE");
	if( DEFAULT_CHAT_FRAME ) then
		SR_PrintSettings("SmartRestore Mod v" .. SMARTRESTORE_VERSION .. " loaded!");
	end 
end

--------------------------------------------
-- Initialization functions
--------------------------------------------

-- Event handler. Sets the first aid iLevel and all adjustable settings.
function SR_OnEvent(event)
	if (event == "TRADE_SKILL_UPDATE") then 
		local skillName, skillLevel = GetTradeSkillLine();
		if (skillName == "First Aid") then
			if(SR_BandageSkill ~= skillLevel)then
				SR_PrintDebug("Updating First Aid skilllevel to " .. skillLevel .. ".");	
				SR_BandageSkill = skillLevel;
			end
		end
  elseif (event == "VARIABLES_LOADED") then
		--if(SR_Version == nil)then
		if(SR_Version == nil or SR_Version ~= SMARTRESTORE_VERSION)then
			SR_Reset();
		end
		SR_Version = SMARTRESTORE_VERSION;
	end
end 	

-- Function to reset all variables.
function SR_Reset()
	SR_PrintSettings("Resetting all variables!");
	SR_BandageSkill = -1;
	SR_BuffTime = 60;
	SR_Text = true;
	SR_CookingFood = false;
	SR_MaxUse = false;
	SR_SlowFoodMultiplier = 2;
	SR_AntiPoisonBeforeBandage = false;
	SR_BuffFood = true;
	SR_HealthPCT = 90;
	SR_ManaPCT = 75;
	SR_MinHealthPCT = 35;
	SR_Smart = 0;
	SR_Force = false;
	SR_Conjured = false;
	SR_QuestFood = false;
	SR_Emotes = false;
	SR_PetHappiness = 0;
	SR_PetFeedMode = 0;
	SR_PetBuffFood = false;
	SR_PetCookingFood = false;
	SR_PetFoodList = {};
	SR_AutoFeed = false;
	
	local localizedClass, englishClass = UnitClass("player");	
	SR_PlayerClass = englishClass;
	-- For healing classes, mana has more priority then other classes.
	if(	string.find(SR_PlayerClass,"DRUID") or 
		string.find(SR_PlayerClass, "PRIEST") or 
		string.find(SR_PlayerClass, "SHAMAN") or 
		string.find(SR_PlayerClass, "PALADIN"))then
		SR_MinHealthPCT = 10;
		SR_HealthPCT = 75;
		SR_ManaPCT = 90;
		SR_Smart = 1;
	-- Mage always uses conjured food. So stack based selection and conjured last.
	elseif(string.find(SR_PlayerClass, "MAGE"))then
		SR_Conjured = true;
		SR_Smart = 2;
	-- Melee classes wish to use potions out of combat often and don't have mana.
	elseif(string.find(SR_PlayerClass, "ROGUE") or string.find(SR_PlayerClass, "WARRIOR"))then
		SR_ManaPCT = 0;
		SR_MinHealthPCT = 100;
		SR_Force = true;
	-- A hunter has a pet that needs food too, so he shouldn't use food that much. He also's capable of using potions out of combat, as a pet doesn't use those.
	elseif(string.find(SR_PlayerClass, "HUNTER"))then
		SR_HealthPCT = 75;
		SR_Force = true;
		SR_PetHappiness = 3;
		SR_AutoFeed = true;	
	elseif(string.find(SR_PlayerClass, "WARLOCK"))then
		SR_Force = true;
		SR_Smart = 1;	
	end
end 	

--------------------------------------------
-- Global used Functions
--------------------------------------------

-- Function to get the item id from a link.
function SR_GetItemID(link)
	if (link) then
		local _, _, id, name = string.find(link,"|Hitem:(%d+):%d+:%d+:%d+|h%[([^]]+)%]|h|r$");
		if (id and name) then
			return tonumber(id);
		end
	end
end

-- Returns the amount of health needed by the target.
function SR_NeedHealth(unit)
	if(UnitIsDeadOrGhost(unit))then
		return 0;
	elseif(SR_MaxUse)then
		return 99999;
	elseif(UnitHealthMax(unit) * SR_HealthPCT / 100 > UnitHealth(unit)) then
		return UnitHealthMax(unit) - UnitHealth(unit);
	else
		return 0;
	end
end

-- Returns the amount of mana needed by the target.
function SR_NeedMana()
	local classname, targetclass = UnitClass("player");
	if(UnitIsDeadOrGhost("player"))then
		return 0;
	elseif(UnitPowerType("player") ~= 0)then
		return 0;
	elseif(SR_MaxUse)then
		return 99999;
	elseif(UnitManaMax("player") * SR_ManaPCT / 100 > UnitMana("player")) then
		return UnitManaMax("player") - UnitMana("player");
	else
		return 0;
	end
end

-- Will try to find a Id in a list
-- Needs an ItemID and the name of the list to search in.
-- Returns true if found in the list, false otherwise.
function SR_ContainsItem(ItemID, identifier)
	if (SmartRestore_Category_Info and SmartRestore_Category_Info[identifier]) then
		local SRTable = SmartRestore_Category_Info[identifier];
		local index, j;
		for index, j in SRTable do
			if (ItemID == tonumber(SRTable[index])) then	
				return true;
			end
		end
	end
	return false;
end

-- Returns the name of the battleground or nil
function SR_GetBattleground()
	local Battleground = nil;
	for i = 0, MAX_BATTLEFIELD_QUEUES do
		local status, mapName, instanceID = GetBattlefieldStatus(i);
		if (status == "active") then
			Battleground = mapName;
		end
	end
	if(Battleground ~= nil)then
		SR_PrintDebug("You're in the " .. Battleground .. " battleground!");
	end
	return Battleground;
end

function SR_BooleanToString(BOOLEAN)
	if(BOOLEAN)then
		return "on";
	else
		return "off";
	end
end

--------------------------------------------
-- Checks for buffs/debuffs.
--------------------------------------------

-- Returns true is a target is currently eating.
function SR_IsEating()
	local index = 0;
	local loop = true;
	while (loop) do
		local buff = GetPlayerBuffTexture(index);
		if (buff) then
			if (string.find(buff, "INV_Misc_Fork&Knife")) then
				return true;
			end
		else
			if(index ~= 0)then
				loop = false;
			end
		end
		index = index+1;
	end
	return false;
end
						
-- Returns true is a target is currently drinking.
function SR_IsDrinking()
	local index = 0;
	local loop = true;
	while (loop) do
		local buff = GetPlayerBuffTexture(index);
		if (buff) then
			if (string.find(buff, "INV_Drink_07")) then
				return true;
			end
		else
			if(index ~= 0)then
				loop = false;
			end
		end
		index = index+1;
	end
	return false;
end

-- Returns true if a target is foodbuffed. (This works through the texture, which is different for some buffs.)
function SR_BuffTimeLeft()
	local timeleft = 0;
	local index = 0;
	local loop = true;
	while (loop) do
		local buff = GetPlayerBuffTexture(index);
		if (buff) then
			local isFoodBuff = false;
		--	if (string.find(buff, "Misc_Food") or string.find(buff, "ManaRegenTotem") or string.find(buff, "HealingAura") or string.find(buff, "Misc_Orb") or string.find(buff, "Boots_Plate"))then 
			if (string.find(buff, "Misc_Food"))then 
				timeleft = floor(GetPlayerBuffTimeLeft(index));
				SR_PrintDebug("Found a foodbuff with " .. timeleft .. " time left!");
				return timeleft;
			end
		else
			if(index ~= 0)then
				loop = false;
			end
		end
		index = index+1;
	end
	return timeleft;
end

-- Returns true if a target is currently poisoned.
function SR_IsPoisoned(target)
	local index = 0;
	local loop = true;
	while (loop) do
		local texture, app, debufftype = UnitDebuff(target,index);
		if (texture) then
			if(debugMode > 1)then
				local sMessage = "Looking at debuff: " .. texture;
				if(debufftype)then
					sMessage = sMessage .. " with debufftype: " .. debufftype;
				end
				SR_PrintDebug(sMessage);
			end
			if (debufftype and string.find(debufftype, "Poison")) then
				return true;
			end
		else
			if(index ~= 0)then
				loop = false;
			end
		end
		index = index+1;
	end
	return false;
end

--------------------------------------------
-- iPower Calculation functions
--------------------------------------------

-- Returns a positive value how much the need differs from health the item supplies. (The smaller the better) Zero would mean a perfect fit.
function SR_GetPower(need, health, iLevel)
	local returnvalue = 99999;
	if(need > health)then -- If the need is more then the health this item can give
		returnvalue = need - health; -- Check what the need would be after this item.
		if(iLevel)then
			if(returnvalue > iLevel)then
				returnvalue = returnvalue - iLevel;
			else
				returnvalue = iLevel - returnvalue;
			end
		end
	else
		returnvalue = health - need; -- Check the amount of overheal.
		if(iLevel)then
			if(returnvalue > iLevel)then
				returnvalue = returnvalue - iLevel;
			else
				returnvalue = iLevel - returnvalue;
			end
		end
	end
	return returnvalue;
end

-- Returns a positive value how much the need differs from health the item supplies. (The smaller the better) Zero would mean a perfect fit.
function SR_GetPowerSlow(need, health, iLevel)
	local returnvalue = 99999;
	health = health * SR_SlowFoodMultiplier;
	if(need > health)then -- If the need is more then the health this item can give
		returnvalue = need - health; -- Check what the need would be after this item.
		if(iLevel)then
			if(returnvalue > iLevel)then
				returnvalue = returnvalue - iLevel;
			else
				returnvalue = iLevel - returnvalue;
			end
		end
	else
		returnvalue = health - need;
		if(iLevel)then
			if(returnvalue > iLevel)then
				returnvalue = returnvalue - iLevel;
			else
				returnvalue = iLevel - returnvalue;
			end
		end
	end
	return returnvalue;
end

-- Will return the average of two values.
function SR_Average(value, value2)
	return floor((value + value2) / 2);
end

--------------------------------------------
-- Print functions
--------------------------------------------

-- Function to print debug messages.
function SR_PrintDebug(sMessage)
	if(debugMode > 0)then
		DEFAULT_CHAT_FRAME:AddMessage(sMessage, 0, 0.5, 1);
	end
end

-- Function to print default messages.
function SR_PrintDefault(sMessage)
	if(SR_Text)then
		DEFAULT_CHAT_FRAME:AddMessage(sMessage, 1, 1, 0.5);
	end
end

-- Function to print default messages.
function SR_PrintEmote(sMessage)
	if(SR_Emotes)then
		SendChatMessage(sMessage, "EMOTE");
	end
end

-- Function to print error messages.
function SR_PrintError(sMessage)
	if(SR_Text or debugMode > 0)then
		DEFAULT_CHAT_FRAME:AddMessage(sMessage, 1, 0, 0);
	end
end

-- Prints the settings etc.
function SR_PrintSettings(sMessage)
	DEFAULT_CHAT_FRAME:AddMessage(sMessage, 1, 0.5, 0);
end

-- Prints the amount of health needed
function SR_PrintHealth(health)
	if(not SR_MaxUse)then
		SR_PrintDebug("You need " .. health .. " health!");
	end
end

-- Prints the amount of mana needed
function SR_PrintMana(iMana)
	if(not SR_MaxUse)then
		SR_PrintDebug("You need " .. iMana .. " mana!");
	end
end

-- Prints the amount of health needed
function SR_PrintHealthMana(health, iMana)
	if(not SR_MaxUse)then
		SR_PrintDebug("You need " .. health .. " health and " .. iMana .. " mana!");
	end
end

-- Print an error sMessage
function SR_PrintNotFound(sMessage)
	SR_PrintError("No " .. sMessage .. " available!");
end

function SR_PrintNotInCombat()
	SR_PrintError("You're not in combat!");
end

function SR_PrintCombat()
	SR_PrintError("You're in combat!");
end

function SR_PrintNoManaNeed()
	SR_PrintError("You don't need mana!");
end

function SR_PrintNoHealthNeed()
	SR_PrintError("You don't need health!");
end
	
-----------------------------------------------------------------------------------------------------------
-- Bandage Section
-----------------------------------------------------------------------------------------------------------
-- Returns the bandagelevel required to use the bandage. Name of bandage is required.
function SR_GetBandageLevel(sName)
	local bandageLevel = 0;
	if(string.find(sName, "Bandage"))then
		if (string.find(sName, "Heavy")) then					
			if (string.find(sName, "Linen")) then
				bandageLevel = 20;
			elseif (string.find(sName, "Wool")) then
				bandageLevel = 75;
			elseif (string.find(sName, "Silk")) then
				bandageLevel = 125;
			elseif (string.find(sName, "Mageweave")) then
				bandageLevel = 175;
			elseif (string.find(sName, "Runecloth")) then
				bandageLevel = 225;
			end
		else
			if (string.find(sName, "Linen")) then
				bandageLevel = 1;
			elseif (string.find(sName, "Wool")) then
				bandageLevel = 50;
			elseif (string.find(sName, "Silk")) then
				bandageLevel = 100;
			elseif (string.find(sName, "Mageweave")) then
				bandageLevel = 150;
			elseif (string.find(sName, "Runecloth")) then
				bandageLevel = 200;
			end
		end
	end
	return bandageLevel;
end 						

-- Returns the health value according to the bandagelevel
function SR_GetHealFromBandageLevel(iLevel)
	if(iLevel < 20)then
		return 66;
	elseif(iLevel < 50)then
		return 114;
	elseif(iLevel < 75)then
		return 161;
	elseif(iLevel < 100)then
		return 301;
	elseif(iLevel < 125)then
		return 400;
	elseif(iLevel < 150)then
		return 640;
	elseif(iLevel < 175)then
		return 800;
	elseif(iLevel < 200)then
		return 1104;
	elseif(iLevel < 225)then
		return 1360;
	elseif(iLevel < 300)then
		return 2000;
	else
		return 0;
	end
end

-- Function to check where a bandage can be used in general.
function SR_BandageCooldownTimeLeft(target)
	local index = 0;
	local loop = true;
	while (loop) do
		index = index+1;
		local debuff = UnitDebuff(target,index);
		if (debuff) then
			if (string.find(debuff, "INV_Misc_Bandage")) then
				return floor(GetPlayerBuffTimeLeft(index));
			end
		else
			loop = false;
		end
	end
	return nil;
end

-- Function to use the best available bandage.
function SR_Bandage()
	if(SR_BandageSkill == -1)then
		SR_PrintError("You don't have a registered First Aid iLevel! (Open your First Aid window once or get the skill from a First Aid trainer.)");
		return false;
	end	 
	local TargetEnemy = false;	
	local TargetFriend = false;	
	local returnValue = true;
	
	-- If there is no target we target the player 
	if (not UnitName("target")) then
		TargetUnit("player");
	end
	-- If the target is an enemy we remember that and change target to player.
	if (not UnitIsFriend("player","target")) then
		TargetUnit("player");
		TargetEnemy = true;
	-- If the target is a friend and not the player self, we remember we targetted a friend. This is because we don't want this target cleared.
	elseif (UnitIsFriend("player","target") and not UnitIsUnit("player","target")) then
		TargetFriend = true;
	end
	
	if(SR_AntiPoisonBeforeBandage and SR_IsPoisoned("target"))then
		SR_AntiVenom();
		return false; -- Because the anti-poison has it's own clearing.
	end	
	
	local iHealthneed = SR_NeedHealth("target");
	-- Since version 2.7 added a pet check here. Only to be used if player is selected.
	if(UnitIsUnit("player","target"))then 
		if(iHealthneed == 0)then
			if(UnitExists("pet"))then
				TargetUnit("pet");
				if(SR_AntiPoisonBeforeBandage and SR_IsPoisoned("pet"))then
					SR_AntiVenom();
					return false; -- Because the anti-poison has it's own clearing.
				end	
				iHealthneed = SR_NeedHealth("pet");
				if(iHealthneed == 0)then
					SR_PrintError("Neither you or your pet need health!");
					returnValue = false;
				end
			else
				SR_PrintNoHealthNeed();
				returnValue = false;
			end
		end
	end
	
	if(returnValue)then -- In case none need health
		if(UnitIsUnit("player","target"))then 
			if(iHealthneed > 0)then 
				SR_PrintHealth(iHealthneed);
				local iTimeLeft = SR_BandageCooldownTimeLeft("player");
				if(iTimeLeft == nil) then
					local bag, slot, name, iPower, iHealPower = SR_FindBestBandage(iHealthneed);
					if (bag == false) then
						SR_PrintNotFound("bandages");
						returnValue = false;
					else
						UseContainerItem(bag,slot);
						if(SR_Emotes)then
							SR_PrintEmote("is using " .. name .. ".");
						elseif(SR_Text)then
							SR_PrintDefault("Using " .. name);
						end
						returnValue = true;
					end
				else				
					SR_PrintError("Can't use a bandage for another " .. iTimeLeft .. " seconds!");
					returnValue = false;
				end
			else
				SR_PrintNoHealthNeed();
				returnValue = false;
			end
		else
			local unitName = UnitName("target");
			if(iHealthneed > 0)then 
				SR_PrintDebug(unitName .. " needs " .. iHealthneed .. " health!");
				local iTimeLeft = SR_BandageCooldownTimeLeft("target");
				if(iTimeLeft == nil) then
					local bag, slot, name, iPower, iHealPower = SR_FindBestBandage(iHealthneed);
					if (bag == false) then
						SR_PrintNotFound("bandages");
						returnValue = false;
					else
						UseContainerItem(bag,slot);
						if(SR_Emotes)then
							SR_PrintEmote("is using " .. name .. " on " .. unitName .. ".");
						elseif(SR_Text)then
							SR_PrintDefault("Using " .. name .. " on " .. unitName);
						end
						returnValue = true;
					end
				else
					SR_PrintError("Can't use a bandage for another " .. iTimeLeft .. " seconds!");
					returnValue = false;
				end
			else
				SR_PrintError(unitName .. " doesn't need health!");
				returnValue = false;
			end
		end
	end
	
	if(not TargetFriend)then
		ClearTarget();		
	end
	if(TargetEnemy)then
		TargetLastEnemy();
		if (UnitHealth("target") == 0) then
			ClearTarget();
			TargetNearestEnemy();
		end
	end
	return returnValue;
end

-- Will find the best bandage for the player.
function SR_FindBestBandage(iHealthneed)
	local finalName;
	local finalSlot = 99;
	local finalBag = false;
	local finalHeal = 0;
	local finalPower = 99999;
	local mapName = SR_GetBattleground();
	if(SR_Smart ~= 1)then
		local finalCount = 99999;		
		finalBag, finalSlot, finalName, finalHeal, finalPower, finalCount = SR_FindBandage(iHealthneed, "BANDAGES");	
				
		if(mapName ~= nil)then
			local bag2, slot2, name2, power2, heal2, count2;
			if(string.find(mapName,ALTERACVALLEY))then
				bag2, slot2, name2, power2, heal2, count2 = SR_FindBandage(iHealthneed, "ALTERAC_BANDAGES");
			elseif(string.find(mapName,WARSONGGULCH))then
				bag2, slot2, name2, power2, heal2, count2 = SR_FindBandage(iHealthneed, "WARSONG_BANDAGES");
			elseif(string.find(mapName,ARATHIBASIN))then
				bag2, slot2, name2, power2, heal2, count2 = SR_FindBandage(iHealthneed, "ARATHI_BANDAGES");
			end
			
			if(bag2 and (power2 < finalPower or (power2 == finalPower and count2 < finalCount)))then
				finalBag = bag2;
				finalSlot = slot2;
				finalName = name2;
				finalHeal = heal2;
				finalPower = power2;
				finalCount = count2;
			end
		end
	else
		local useNormal = true;
		if(mapName ~= nil)then
			useNormal = false;
			if(string.find(mapName,ALTERACVALLEY))then
				finalBag, finalSlot, finalName, finalPower, finalHeal = SR_FindBandage(iHealthneed, "ALTERAC_BANDAGES");
			elseif(string.find(mapName,WARSONGGULCH))then
				finalBag, finalSlot, finalName, finalPower, finalHeal = SR_FindBandage(iHealthneed, "WARSONG_BANDAGES");
			elseif(string.find(mapName,ARATHIBASIN))then
				finalBag, finalSlot, finalName, finalPower, finalHeal = SR_FindBandage(iHealthneed, "ARATHI_BANDAGES");
			end
			
			if (finalBag == false) then
				useNormal = true;
			end
		end
		
		if(useNormal)then
			finalBag, finalSlot, finalName, finalPower, finalHeal = SR_FindBandage(iHealthneed, "BANDAGES");		
		end
	end
	
	if (finalSlot == 99) then
		return false, false, "", 99999, 0;
	else
		return finalBag, finalSlot, finalName, finalPower, finalHeal;
	end
end

-- Will find the best bandage in a certain given category.
function SR_FindBandage(iHealthneed, sCategory)
	SR_PrintDebug("Scanning " .. sCategory .. ".");
	local finalName;
	local finalSlot = 99;
	local finalBag = 0;
	local finalHeal = 0;
	local finalPower = 99999;
	local finalCount = 99;
	for bag=0,NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag), 1 do
			local link = GetContainerItemLink(bag,slot);
			if (link) then
				local ItemID = SR_GetItemID(link); 							
				local sName, iLink, iQuality, iLevel, sClass, sSubClass = GetItemInfo("item:"..ItemID); 	
				if (sName and (string.find(sClass, "Consumable") or (SR_QuestFood and string.find(sClass, "Quest")))) then
					-- Assembly looking at sMessage with info
					local sMessage = "Looking at " .. sName .. " (" .. ItemID .. ")";
					local bandageLevel = 0;
					local iPower = 99999;
					local health = 0;
					-- Get health and iPower
					if(SR_ContainsItem(ItemID, sCategory)) then
						bandageLevel = SR_GetBandageLevel(sName);
						health = SR_GetHealFromBandageLevel(bandageLevel);
						sMessage = sMessage .. ", bandagelevel " .. bandageLevel .. ", with " .. health .. " health";
						if(SR_Smart == 2)then
							iPower = 0;
						else																
							iPower = SR_GetPower(iHealthneed,health,bandageLevel);
							sMessage = sMessage .. " and " .. iPower .. " power";
						end
					end	
					
					if (iPower ~= 99999 and iPower <= finalPower and SR_BandageSkill >= bandageLevel and UnitLevel("player") >= iLevel) then
						local texture, count = GetContainerItemInfo(bag,slot);
						local continue = true;
						sMessage = sMessage .. " in a stack of " .. count;
						if(iPower == finalPower)then
							continue = count < finalCount;
						end
						if(continue)then
							finalPower = iPower;
							finalBag = bag;
							finalSlot = slot;
							finalName = link;
							finalHeal = health;
							finalCount = count;
						end
					end
					if(debugMode > 2)then
						SR_PrintDebug(sMessage .. ".");
					end
				end 				
			end
		end
	end
	if (finalSlot == 99) then
		return false, false, "", 99999, 0, 0;
	else
		if(debugMode > 1)then
			SR_PrintDebug("Found " .. finalName .. ", with " .. finalPower .. " power in a stack of " .. finalCount .. ".");
		end
		return finalBag, finalSlot, finalName, finalPower, finalHeal, finalCount;
	end
end 

-----------------------------------------------------------------------------------------------------------
-- Mana Section
-----------------------------------------------------------------------------------------------------------
-- Tries to find the best out of all categories.
function SR_FindBestMana(iMananeed)
	local iFinalName;
	local bag = false;
	local slot = false;
	local iPower = 99999;
	local iManapower = 0;
	if(SR_Smart ~= 1)then
		local count = 99999;
		if(string.find(SR_PlayerClass, "MAGE"))then
			bag, slot, iFinalName, iPower, iManapower, count = SR_FindManaItem(iMananeed, "MANASTONE");
		end
		if(SR_GetBattleground() ~= nil)then
			local bag2, slot2, name2, power2, manapower2, count2 = SR_FindManaItem(iMananeed, "PVP_MANAPOTIONS");
			if(power2 < iPower or (power2 == iPower and count2 < count))then
				bag = bag2;
				slot = slot2;
				iFinalName = name2;
				iPower = power2;
				iManapower = manapower2;
				count = count2;
			end
		end
		local bag2, slot2, name2, power2, manapower2, count2 = SR_FindManaItem(iMananeed, "MANAPOTIONS");		
		if(power2 < iPower or (power2 == iPower and count2 < count))then
			bag = bag2;
			slot = slot2;
			iFinalName = name2;
			iPower = power2;
			iManapower = manapower2;
			count = count2;
		end
	else
		if(string.find(SR_PlayerClass, "MAGE"))then
			bag, slot, iFinalName, iPower, iManapower = SR_FindManaItem(iMananeed, "MANASTONE");
		end

		if (SR_GetBattleground() ~= nil and bag == false) then
			bag, slot, iFinalName, iPower, iManapower = SR_FindManaItem(iMananeed, "PVP_MANAPOTIONS");
		end
		
		if (bag == false) then
			bag, slot, iFinalName, iPower, iManapower = SR_FindManaItem(iMananeed, "MANAPOTIONS");
		end
	end
	return bag, slot, iFinalName, iPower, iManapower;
end

-- Uses the best mana potion.
function SR_Mana()
	local iMananeed = SR_NeedMana();
	if(UnitAffectingCombat("player") or SR_Force)then
		if(iMananeed > 0)then
			SR_PrintMana(iMananeed);		
			local bag, slot, name, iPower, iManapower = SR_FindBestMana(iMananeed);
	
			if (bag == false) then
				SR_PrintNotFound("mana potions");
				return false;
			else
				UseContainerItem(bag,slot);
				if(SR_Emotes)then
					SR_PrintEmote("is using " .. name .. ".");
				elseif(SR_Text)then
					SR_PrintDefault("Using " .. name);
				end
				return true;
			end
		else
			SR_PrintNoManaNeed();
			return false;
		end
	else
		SR_PrintNotInCombat();
		return false;
	end
end

-- Uses the best mana potion.
function SR_Mana2(iMananeed)
	local bag, slot, name, iPower, iManapower = SR_FindBestMana(iMananeed);
	if (bag == false) then
		SR_PrintNotFound("mana potions");
		return false;
	else
		UseContainerItem(bag,slot);
		if(SR_Emotes)then
			SR_PrintEmote("is using " .. name .. ".");
		elseif(SR_Text)then
			SR_PrintDefault("Using " .. name);
		end
		return true;
	end
end

-- Finds the best mana potion.
function SR_FindManaItem(iMananeed, sCategory)
	SR_PrintDebug("Scanning " .. sCategory .. ".");
	local finalName;
	local finalSlot = 99;
	local finalBag = 0;
	local finalHeal = 0;
	local finalPower = 99999;
	local finalCount = 99999;
	for bag=0,NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag), 1 do
			local link = GetContainerItemLink(bag,slot);
			if (link) then
				local ItemID = SR_GetItemID(link); 							
				local sName, iLink, iQuality, iLevel, sClass, sSubClass = GetItemInfo("item:"..ItemID); 								
				if (sName and string.find(sClass, "Consumable")) then
					local sMessage = "Looking at " .. sName .. " (" .. ItemID .. "), level " .. iLevel;					
					if(SR_ContainsItem(ItemID, sCategory)) then
						local iMana = 0;
						local iPower = 99999;
						if(string.find(sCategory, "MANAPOTIONS") or string.find(sCategory, "PVP_MANAPOTIONS"))then
							iMana = SR_GetManaFromManaPotionLevel(iLevel);
						elseif(string.find(sCategory, "MANASTONE"))then
							iMana = SR_GetManaFromManaGemLevel(iLevel);
						end
						sMessage = sMessage .. " with " .. iMana .. " mana";
						if(SR_Smart == 2)then
							iPower = 0;
						else
							iPower = SR_GetPower(iMananeed,iMana,iLevel);
							sMessage = sMessage .. " and " .. iPower .. " power";
						end
						
						if (iPower <= finalPower and UnitLevel("player") >= iLevel and iPower ~= 99999) then
							local texture, count = GetContainerItemInfo(bag, slot);
							local continue = false;
							sMessage = sMessage .. " in a stack of " .. count;
							if(iPower == finalPower)then
								if(count < finalCount)then
									continue = true;
								end
							else
								continue = true;
							end
							if(continue)then
								finalPower = iPower;
								finalBag = bag;
								finalSlot = slot;
								finalName = link;
								finalHeal = iMana;
								finalCount = count;
							end
						end
					end
					if(debugMode > 2)then
						SR_PrintDebug(sMessage .. ".");
					end
				end
			end
		end
	end
	if (finalSlot == 99) then
		return false, false, "", 99999, 0, 99999;
	else
		if(debugMode > 1)then
			SR_PrintDebug("Found " .. finalName .. ", with " .. finalPower .. " power in a stack of " .. finalCount .. ".");
		end
		local start,duration = GetContainerItemCooldown(finalBag,finalSlot);
		if (start == 0) then
			return finalBag, finalSlot, finalName, finalPower, finalHeal, finalCount;
		else	
			SR_PrintError("Can't drink " .. finalName .. " for another " .. floor(duration - ( GetTime() - start)) .. " seconds!");
			return false, false, "", 99999, 0, 99999;
		end
	end
end 

-- Returns amount of mana that is restored according to iLevel of mana potion.
function SR_GetManaFromManaPotionLevel(iLevel)
	if(iLevel < 14)then
		return SR_Average(140,180);
	elseif(iLevel < 22)then
		return SR_Average(280,360);
	elseif(iLevel < 31)then
		return SR_Average(455,585);
	elseif(iLevel < 35)then
		return SR_Average(700,900);
	elseif(iLevel < 41)then
		return SR_Average(560, 720);
	elseif(iLevel < 45)then
		return SR_Average(900, 1500);
	elseif(iLevel < 49)then
		return SR_Average(980, 1260);
	elseif(iLevel < 70)then
		return SR_Average(1350, 2250);
	else
		return 0;
	end	
end

-- Returns amount of mana that is restored according to iLevel of mana gem.
function SR_GetManaFromManaGemLevel(iLevel)
	if(iLevel < 38)then
		return SR_Average(375,425);
	elseif(iLevel < 48)then
		return SR_Average(550,650);
	elseif(iLevel < 58)then
		return SR_Average(775,925);
	elseif(iLevel < 70)then
		return SR_Average(1000,1200);
	else
		return 0;
	end	
end

-----------------------------------------------------------------------------------------------------------
-- Health Section
-----------------------------------------------------------------------------------------------------------

function SR_FindBestHealth(iHealthneed)
	local iFinalName;
	local bag = false;
	local slot = false;
	local iPower = 99999;
	local iHealPower = 0;
	if(SR_Smart ~= 1)then
		local count = 99999;
		bag, slot, iFinalName, iPower, iHealPower, count = SR_FindHealItem(iHealthneed, "HEALTHSTONE");
		
		if(SR_GetBattleground() ~= nil)then
			local bag2, slot2, name2, power2, healpower2, count2 = SR_FindHealItem(iHealthneed, "PVP_HEALPOTIONS");
			if(power2 < iPower or (power2 == iPower and count2 < count))then
				bag = bag2;
				slot = slot2;
				iFinalName = name2;
				iPower = power2;
				iHealPower = healpower2;
				count = count2;
			end
		end
		
		local bag2, slot2, name2, power2, healpower2, count2 = SR_FindHealItem(iHealthneed, "HEALPOTIONS");
		if(power2 < iPower or (power2 == iPower and count2 < count))then
			bag = bag2;
			slot = slot2;
			iFinalName = name2;
			iPower = power2;
			iHealPower = healpower2;
			count = count2;
		end
	else
		bag, slot, iFinalName, iPower, iHealPower = SR_FindHealItem(iHealthneed, "HEALTHSTONE");
	
		if (SR_GetBattleground() ~= nil and bag == false) then
			bag, slot, iFinalName, iPower, iHealPower = SR_FindHealItem(iHealthneed, "PVP_HEALPOTIONS");
		end
		
		if (bag == false) then
			bag, slot, iFinalName, iPower, iHealPower = SR_FindHealItem(iHealthneed, "HEALPOTIONS");
		end
	end
	return bag, slot, iFinalName, iPower, iHealPower;
end

-- Will use the best heal potion.
function SR_Health()
	if(UnitAffectingCombat("player") or SR_Force)then
		local iHealthneed = SR_NeedHealth("player");
		if(iHealthneed > 0)then
			SR_PrintHealth(iHealthneed);
			local bag, slot, name, iPower, iHealPower = SR_FindBestHealth(iHealthneed);
			
			if (bag == false) then
				SR_PrintNotFound("healing potions");
				return false;
			else
				UseContainerItem(bag,slot);
				if(SR_Emotes)then
					SR_PrintEmote("is using " .. name .. ".");
				elseif(SR_Text)then
					SR_PrintDefault("Using " .. name);
				end
				return true;
			end
		else
			SR_PrintNoHealthNeed();
			return false;
		end
	else
		SR_PrintNotInCombat();
		return false;
	end
end

function SR_Health2(iHealthneed)
	local bag, slot, name, iPower, iHealPower = SR_FindBestHealth(iHealthneed);
	if (bag == false) then
		SR_PrintNotFound("healing potions");
		return false;
	else
		UseContainerItem(bag,slot);
		if(SR_Emotes)then
			SR_PrintEmote("is using " .. name .. ".");
		elseif(SR_Text)then
			SR_PrintDefault("Using " .. name);
		end
		return true;
	end
end

-- Finds the best heal potion.
function SR_FindHealItem(iHealthneed, sCategory)
	SR_PrintDebug("Scanning " .. sCategory .. ".");
	local finalName;
	local finalSlot = 99;
	local finalBag = 0;
	local finalHeal = 0;
	local finalPower = 99999;
	local finalCount = 99999;
	for bag=0,NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag), 1 do
			local link = GetContainerItemLink(bag,slot);
			if (link) then
				local ItemID = SR_GetItemID(link); 							
				local sName, iLink, iQuality, iLevel, sClass, sSubClass = GetItemInfo("item:"..ItemID); 								
				if (sName and string.find(sClass, "Consumable")) then
					local sMessage = "Looking at " .. sName .. " (" .. ItemID .. "), level " .. iLevel;					
					if(SR_ContainsItem(ItemID, sCategory)) then
						local iHealth = 0;
						local iPower = 99999;
						if(string.find(sCategory, "HEALPOTIONS"))then
							iHealth = SR_GetHealthFromHealPotionLevel(iLevel);
						elseif(string.find(sCategory, "PVP_HEALPOTIONS"))then
							iHealth = SR_GetHealthFromPVPHealPotionLevel(iLevel);
						elseif(string.find(sCategory, "HEALTHSTONE"))then	
							iHealth = SR_GetHealthFromHealthstoneLevel(iLevel);
						end
						sMessage = sMessage .. " with " .. iHealth .. " health";
						if(SR_Smart == 2)then
							iPower = 0;
						else
							iPower = SR_GetPower(iHealthneed,iHealth,iLevel);	
							sMessage = sMessage .. " and " .. iPower .. " power";
						end
						if (iPower <= finalPower and UnitLevel("player") >= iLevel and iPower ~= 99999) then
							local texture, count = GetContainerItemInfo(bag, slot);
							local continue = false;
							sMessage = sMessage .. " in a stack of " .. count;
							if(iPower == finalPower)then
								if(count < finalCount)then
									continue = true;
								end
							else
								continue = true;
							end
							if(continue)then
								finalPower = iPower;
								finalBag = bag;
								finalSlot = slot;
								finalName = link;
								finalHeal = iHealth;
								finalCount = count;
							end
						end
					end
					if(debugMode > 2)then
						SR_PrintDebug(sMessage .. ".");
					end
				end
			end
		end
	end
	if (finalSlot == 99) then
		return false, false, "", 99999, 0, 99999;
	else
		if(debugMode > 1)then
			SR_PrintDebug("Found " .. finalName .. ", with " .. finalPower .. " power in a stack of " .. finalCount .. ".");
		end
		local start,duration = GetContainerItemCooldown(finalBag,finalSlot);
		if (start == 0) then
			return finalBag, finalSlot, finalName, finalPower, finalHeal, finalCount;
		else	
			SR_PrintError("Can't drink " .. finalName .. " for another " .. floor(duration - ( GetTime() - start)) .. " seconds!");
			return false, false, "", 99999, 0, 99999;
		end
	end
end 

-- Returns the average amount the potion heals based on it's iLevel
function SR_GetHealthFromHealPotionLevel(iLevel)
	if(iLevel < 3)then
		return SR_Average(70,90);
	elseif(iLevel < 12)then
		return SR_Average(140,180);
	elseif(iLevel < 21)then
		return SR_Average(280,360);
	elseif(iLevel < 35)then
		return SR_Average(455,585);
	elseif(iLevel < 45)then
		return SR_Average(700, 900);
	elseif(iLevel < 70)then
		return SR_Average(1050, 1750);
	else
		return 0;
	end	
end

-- Returns the average amount the pvp potion heals based on it's iLevel
function SR_GetHealthFromPVPHealPotionLevel(iLevel)
	if(iLevel < 45)then
		return SR_Average(560, 720);
	elseif(iLevel < 70)then
		return SR_Average(980, 1260);
	else
		return 0;
	end	
end

-- Returns the average amount the healthstone heals based on it's iLevel
function SR_GetHealthFromHealthstoneLevel(iLevel)
	if(iLevel < 12)then
		return 100;
	elseif(iLevel < 24)then
		return 250;
	elseif(iLevel < 36)then
		return 500;
	elseif(iLevel < 48)then
		return 800;
	elseif(iLevel < 70)then
		return 1200;
	else
		return 0;
	end	
end
-----------------------------------------------------------------------------------------------------------
-- Rejuvenation Section
-----------------------------------------------------------------------------------------------------------
function SR_SmartPotion()
	if(UnitAffectingCombat("player") or SR_Force)then
		local iHealthneed = SR_NeedHealth("player");
		local iMananeed = SR_NeedMana();
		if(iHealthneed > 0 and iMananeed > 0)then
			SR_PrintHealthMana(iHealthneed,iMananeed);
			local bag, slot, name, iPower, iHealPower, iManapower = SR_FindRejuvenationPotion(iHealthneed, iMananeed);
			if (bag == false) then
				--SR_PrintNotFound("rejuvenation potions");
				local healthpercent = UnitHealth("player") * 100 / UnitHealthMax("player"); -- The amount of health left * 100 / max health = amount health left in %
				local manapercent = UnitMana("player") * 100 / UnitManaMax("player"); -- Same as above but for mana.
				if(healthpercent <= manapercent or healthpercent <= SR_MinHealthPCT)then 
					if(not SR_Health2(iHealthneed))then
						return SR_Mana2(iMananeed);
					else 
						return true;
					end
				else
					if(not SR_Mana2(iMananeed))then
						return SR_Health2(iHealthneed);
					else 
						return true;
					end
				end
			else
				UseContainerItem(bag,slot);
				if(SR_Emotes)then
					SR_PrintEmote("is using " .. name .. ".");
				elseif(SR_Text)then
					SR_PrintDefault("Using " .. name);
				end
				return true;
			end
		elseif (iHealthneed > 0) then
			SR_PrintHealth(iHealthneed);
			return SR_Health2(iHealthneed);
		elseif (iMananeed > 0) then
			SR_PrintMana(iMananeed);
			return SR_Mana2(iMananeed); 	
		else
			SR_PrintError("You don't need health or mana!");
			return false;	
		end
	else
		SR_PrintNotInCombat();
		return false;
	end
end

function SR_FindRejuvenationPotion(iHealthneed, iMananeed)
	SR_PrintDebug("Scanning REJUVENATION_POTIONS...");
	local finalName;
	local finalSlot = 99;
	local finalBag = 0;
	local finalPower = 99999;
	local finalHeal = 0;
	local finalCount = 99999;
	for bag=0,NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag), 1 do
			local link = GetContainerItemLink(bag,slot);
			if (link) then
				local ItemID = SR_GetItemID(link); 							
				local sName, iLink, iQuality, iLevel, sClass, sSubClass = GetItemInfo("item:"..ItemID); 		
				if (sName and string.find(sClass, "Consumable")) then
					local sMessage = "Looking at " .. sName .. " (" .. ItemID .. "), level " .. iLevel;	
					if(SR_ContainsItem(ItemID, "REJUVENATION_POTIONS")) then 
						local value = SR_GetHealthAndManaFromRejuvenationPotionLevel(iLevel);
						local iPower = 99999;
						sMessage = sMessage .. " with " .. value .. " health and mana";
						if(SR_Smart == 2)then
							iPower = 0;
						else
							iPower = SR_GetPower(iHealthneed,value, iLevel) + SR_GetPower(iMananeed,value, iLevel);
							sMessage = sMessage .. " and " .. iPower .. " power";
						end
						if (iPower <= finalPower and UnitLevel("player") >= iLevel and iPower ~= 99999) then
							local texture, count = GetContainerItemInfo(bag, slot);
							sMessage = sMessage .. " in a stack of " .. count;
							if(iPower == finalPower)then
								if(count < finalCount)then
									continue = true;
								end
							else
								continue = true;
							end
							if(continue)then
								finalPower = iPower;
								finalBag = bag;
								finalSlot = slot;
								finalName = link;
								finalHeal = iHealth;
								finalCount = count;
							end
						end
					end
					if(debugMode > 2)then
						SR_PrintDebug(sMessage .. ".");
					end
				end
			end
		end
 	end
 	if (finalSlot == 99) then
		return false, false, "", 99999, 0, 0;
 	else
 		if(debugMode > 1)then
			SR_PrintDebug("Found " .. finalName .. ", with " .. finalPower .. " power in a stack of " .. finalCount .. ".");
		end
		local start,duration = GetContainerItemCooldown(finalBag,finalSlot);
		if (start == 0) then
			return finalBag, finalSlot, finalName, finalPower, finalHeal, finalCount;
		else	
			SR_PrintError("Can't drink " .. finalName .. " for another " .. floor(duration - ( GetTime() - start)) .. " seconds!");
			return false, false, "", 99999, 0, 99999;
		end
 	end
end 

-- Returns the average amount the potion heals based on it's iLevel
function SR_GetHealthAndManaFromRejuvenationPotionLevel(iLevel)
	if(iLevel < 35)then
		return SR_Average(90,150);
	elseif(iLevel < 50)then
		return SR_Average(1,1500);
	elseif(iLevel < 70)then
		return SR_Average(1440,1760);
	else
		return 0;
	end	
end

-----------------------------------------------------------------------------------------------------------
-- Food Section
-----------------------------------------------------------------------------------------------------------

function SR_FindBestFood(iHealthneed)
	local iFinalName = "";
	local bag = false;
	local slot = false;
	local iPower = 99999;
	local iHealPower = 0;
	if(SR_Smart ~= 1)then
		local count = 99999;
		local bag2, slot2, name2, power2, healpower2, count2;
		
		bag, slot, iFinalName, iPower, iHealPower, count = SR_FindFood(iHealthneed, "FOOD_CONJURED");	
					
		if (SR_BuffFood and SR_BuffTimeLeft() < SR_BuffTime) then
			bag2, slot2, name2, power2, healpower2, count2 = SR_FindFood(iHealthneed, "FOOD_BUFF");
			if(power2 < iPower or (power2 == iPower and count2 < count))then
				bag = bag2;
				slot = slot2;
				iFinalName = name2;
				iPower = power2;
				iHealPower = healpower2;
				count = count2;
			end
			
			bag2, slot2, name2, power2, healpower2, count2 = SR_FindFood(iHealthneed, "FOOD_BUFF_DYNAMIC");
			if(power2 < iPower or (power2 == iPower and count2 < count))then
				bag = bag2;
				slot = slot2;
				iFinalName = name2;
				iPower = power2;
				iHealPower = healpower2;
				count = count2;
			end
		end
		
		bag2, slot2, name2, power2, healpower2, count2 = SR_FindFood(iHealthneed, "FOOD");
		if(power2 < iPower or (power2 == iPower and count2 < count))then
			bag = bag2;
			slot = slot2;
			iFinalName = name2;
			iPower = power2;
			iHealPower = healpower2;
			count = count2;
		end
		
		bag2, slot2, name2, power2, healpower2, count2 = SR_FindFood(iHealthneed, "FOOD_DYNAMIC");
		if(power2 < iPower or (power2 == iPower and count2 < count))then
			bag = bag2;
			slot = slot2;
			iFinalName = name2;
			iPower = power2;
			iHealPower = healpower2;
			count = count2;
		end
		
		if (SR_CookingFood) then
			bag2, slot2, name2, power2, healpower2, count2 = SR_FindFood(iHealthneed, "FOOD_COOKING");
			if(power2 < iPower or (power2 == iPower and count2 < count))then
				bag = bag2;
				slot = slot2;
				iFinalName = name2;
				iPower = power2;
				iHealPower = healpower2;
				count = count2;
			end
		end	
		
		if (SR_BuffFood and bag == false) then
			bag2, slot2, name2, power2, healpower2, count2 = SR_FindFood(iHealthneed, "FOOD_BUFF");
			if(power2 < iPower or (power2 == iPower and count2 < count))then
				bag = bag2;
				slot = slot2;
				iFinalName = name2;
				iPower = power2;
				iHealPower = healpower2;
				count = count2;
			end
		end
	else			
		if (SR_BuffFood and bag == false and SR_BuffTimeLeft() < SR_BuffTime) then
			bag, slot, iFinalName, iPower, iHealPower = SR_FindFood(iHealthneed, "FOOD_BUFF");
		end
		
		if (SR_BuffFood and bag == false and SR_BuffTimeLeft() < SR_BuffTime) then
			bag, slot, iFinalName, iPower, iHealPower = SR_FindFood(iHealthneed, "FOOD_BUFF_DYNAMIC");
		end
		
		if (bag == false and not SR_Conjured) then
			bag, slot, iFinalName, iPower, iHealPower = SR_FindFood(iHealthneed, "FOOD_CONJURED");
		end
			
		if (bag == false) then
			bag, slot, iFinalName, iPower, iHealPower = SR_FindFood(iHealthneed, "FOOD");
		end
		
		if (bag == false) then
			bag, slot, iFinalName, iPower, iHealPower = SR_FindFood(iHealthneed, "FOOD_DYNAMIC");
		end
		
		if (bag == false and SR_Conjured) then
			bag, slot, iFinalName, iPower, iHealPower = SR_FindFood(iHealthneed, "FOOD_CONJURED");
		end
		
		if (SR_CookingFood and bag == false) then
			bag, slot, iFinalName, iPower, iHealPower = SR_FindFood(iHealthneed, "FOOD_COOKING");
		end	
		
		if (SR_BuffFood and bag == false) then
			bag, slot, iFinalName, iPower, iHealPower = SR_FindFood(iHealthneed, "FOOD_BUFF");
		end
		
		if (SR_BuffFood and bag == false) then
			bag, slot, iFinalName, iPower, iHealPower = SR_FindFood(iHealthneed, "FOOD_BUFF_DYNAMIC");
		end
	end
	return bag, slot, iFinalName, iPower, iHealPower;
end

function SR_Eat()
	if(not UnitAffectingCombat("player"))then
		if(string.find(SR_PlayerClass, "HUNTER") and SR_AutoFeed)then
			if(SR_SmartPetFeed())then
				return true;
			end
		end
		local iHealthneed = SR_NeedHealth("player");
		if(iHealthneed > 0)then
			if(not SR_IsEating())then
				SR_PrintHealth(iHealthneed);
				local bag, slot, name, iPower, iHealPower = SR_FindBestFood(iHealthneed);
				
				if (bag == false) then
					SR_PrintNotFound("food");
					return false;
				else
					UseContainerItem(bag,slot);				
					if(SR_Emotes)then
						SR_PrintEmote("is eating " .. name .. ".");
					elseif(SR_Text)then
						SR_PrintDefault("Eating " .. name);
					end
					return true;
				end
			else
				SR_PrintError("You're already eating!");
				return false;
			end		
		else
			SR_PrintNoHealthNeed();
			return false;
		end	
	else
		SR_PrintCombat();
		return false;
	end
end

function SR_Eat2(iHealthneed)
	local bag, slot, name, iPower, iHealPower = SR_FindBestFood(iHealthneed);
	if (bag == false) then
		SR_PrintNotFound("food");
		return false;
	else
		UseContainerItem(bag,slot);
		if(SR_Emotes)then
			SR_PrintEmote("is eating " .. name .. ".");
		elseif(SR_Text)then
			SR_PrintDefault("Eating " .. name);
		end
		return true;
	end
end

-- Finds the best food in a certain category.
function SR_FindFood(iHealthneed, sCategory)	
	SR_PrintDebug("Scanning " .. sCategory .. ".");
	local finalName;
	local finalSlot = 99;
	local finalBag = 0;
	local finalHeal = 0;
	local finalPower = 99999;
	local finalCount = 99999;
	for bag=0,NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag), 1 do
			local link = GetContainerItemLink(bag,slot);
			if (link) then
				local ItemID = SR_GetItemID(link); 							
				local sName, iLink, iQuality, iLevel, sClass, sSubClass = GetItemInfo("item:"..ItemID); 								
				if (sName and string.find(sClass, "Consumable") or (SR_QuestFood and string.find(sClass, "Quest"))) then
					local sMessage = "Looking at " .. sName .. " (" .. ItemID .. "), level " .. iLevel;					
					if(SR_ContainsItem(ItemID, sCategory)) then
						local iHealth = 0;
						local iPower = 99999;
						if(string.find(sCategory, "FOOD") or string.find(sCategory, "FOOD_CONJURED"))then
							iHealth = SR_GetHealFromFoodLevel(iLevel);
						elseif(string.find(sCategory, "FOOD_BUFF"))then
							iHealth = SR_GetHealFromBuffFoodLevel(iLevel);
						elseif(string.find(sCategory, "FOOD_COOKING"))then	
							iHealth = SR_GetHealFromCookingFoodLevel(iLevel);
						elseif(string.find(sCategory, "FOOD_DYNAMIC") or string.find(sCategory, "FOOD_BUFF_DYNAMIC"))then	
							iHealth = SR_GetHealFromDynamicFoodName();
						end
						sMessage = sMessage .. " with " .. iHealth .. " health";
						if(SR_Smart == 2)then
							iPower = 0;
						else
							iPower = SR_GetPower(iHealthneed,iHealth,iLevel);	
							sMessage = sMessage .. " and " .. iPower .. " power";
						end
						if (iPower <= finalPower and UnitLevel("player") >= iLevel and iPower ~= 99999) then
							local texture, count = GetContainerItemInfo(bag, slot);
							local continue = false;
							sMessage = sMessage .. " in a stack of " .. count;
							if(iPower == finalPower)then
								-- To see if food is acceptable.. only used if player is a hunter
								local approved = true;
								-- Check if player is hunter
								if(string.find(SR_PlayerClass, "HUNTER"))then
									-- Check if this new food is in diet list
									if(SR_InPetDietList(ItemID))then
										-- Don't use this food
										approved = false;
									end
									local templink = GetContainerItemLink(finalBag,finalSlot);
									local tempItemID = SR_GetItemID(templink); 
									local tempNotApproved = SR_InPetDietList(tempItemID);		
									if(approved)then
										-- If the original food wasn't approved, any food that arrives here and is approved should overwrite it no matter the stackcount.
										if(tempNotApproved)then
											continue = true;
										end
										-- Else if the original and new are approved, a normal stackcount should be applied.
									else
										-- If the new food and old food are both not approved, they should use the normal stackcount.
										if(tempNotApproved)then
											approved = true;
										end
										-- If the old was allright and the new is not, the approved is false, and therefor continue is false to and the food will not be used.
									end
								end
								if(approved and count < finalCount)then
									continue = true;
								end
							else
								continue = true;
							end
							if(continue)then
								finalPower = iPower;
								finalBag = bag;
								finalSlot = slot;
								finalName = link;
								finalHeal = iHealth;
								finalCount = count;
							end
						end
					end
					if(debugMode > 2)then
						SR_PrintDebug(sMessage .. ".");	
					end
				end
			end
		end
	end
	if (finalSlot == 99) then
		return false, false, "", 99999, 0, 99999;
	else
		if(debugMode > 1)then
			SR_PrintDebug("Found " .. finalName .. ", with " .. finalPower .. " power in a stack of " .. finalCount .. ".");
		end
		return finalBag, finalSlot, finalName, finalPower, finalHeal, finalCount;
	end
end 

-- Returns the average amount the food heals based on it's iLevel
function SR_GetHealFromFoodLevel(iLevel)
	if(iLevel < 5)then
		return 61;
	elseif(iLevel < 10)then
		return 243;
	elseif(iLevel < 20)then
		return 552;
	elseif(iLevel < 35)then
		return 874;
	elseif(iLevel < 45)then
		return 1392;
	elseif(iLevel < 55)then
		return 2148;
	elseif(iLevel < 70)then
		return 3180;
	else
		return 0;
	end	
end

function SR_GetHealFromDynamicFoodName()
	return floor(25 * UnitHealthMax("player") * 0.02);
end

-- Returns the average amount the food heals based on it's iLevel
function SR_GetHealFromBuffFoodLevel(iLevel)
	if(iLevel < 5)then
		return 61;
	elseif(iLevel < 10)then
		return 243;
	elseif(iLevel < 20)then
		return 552;
	elseif(iLevel < 40)then
		return 874;
	elseif(iLevel < 45)then
		return 1392;
	elseif(iLevel < 55)then
		return 1933;
	elseif(iLevel < 70)then
		return 2550;
	else
		return 0;
	end	
end

-- Returns the average amount the cooking food heals based on it's iLevel
function SR_GetHealFromCookingFoodLevel(iLevel)
	if(iLevel < 5)then
		return 30;
	elseif(iLevel < 15)then
		return 61;
	elseif(iLevel < 25)then
		return 243;
	elseif(iLevel < 35)then
		return 552;
	elseif(iLevel < 45)then
		return 874;
	elseif(iLevel < 55)then
		return 1392;
	elseif(iLevel < 70)then
		return 2148;
	else
		return 0;
	end	
end

-----------------------------------------------------------------------------------------------------------
-- Drinks Section
-----------------------------------------------------------------------------------------------------------

function SR_FindBestDrink(iMananeed)
	local iFinalName = "";
	local bag = false;
	local slot = false;
	local iPower = 99999;
	local iManapower = 0;	
	if(SR_Smart ~= 1)then
		local count = 99999;
		local bag2, slot2, power2, manapower2, count2;
	
		bag, slot, iFinalName, iPower, iManapower, count = SR_FindDrink(iMananeed, "WATER_CONJURED");
								
		if (SR_BuffFood and SR_BuffTimeLeft() < SR_BuffTime) then
			bag2, slot2, name2, power2, manapower2, count2 = SR_FindDrink(iMananeed, "WATER_BUFF");
			if(power2 < iPower or (power2 == iPower and count2 < count))then
				bag = bag2;
				slot = slot2;
				iFinalName = name2;
				iPower = power2;
				iManapower = manapower2;
				count = count2;
			end
		end
		
		bag2, slot2, name2, power2, manapower2, count2 = SR_FindDrink(iMananeed, "WATER_DYNAMIC");
		if(power2 < iPower or (power2 == iPower and count2 < count))then
			bag = bag2;
			slot = slot2;
			iFinalName = name2;
			iPower = power2;
			iManapower = manapower2;
			count = count2;
		end
		
		bag2, slot2, name2, power2, manapower2, count2 = SR_FindDrink(iMananeed, "WATER");
		if(power2 < iPower or (power2 == iPower and count2 < count))then
			bag = bag2;
			slot = slot2;
			iFinalName = name2;
			iPower = power2;
			iManapower = manapower2;
			count = count2;
		end
		
		if (SR_BuffFood and bag == false) then
			bag2, slot2, name2, power2, manapower2, count2 = SR_FindDrink(iMananeed, "WATER_BUFF");
			if(power2 < iPower or (power2 == iPower and count2 < count))then
				bag = bag2;
				slot = slot2;
				iFinalName = name2;
				iPower = power2;
				iManapower = manapower2;
				count = count2;
			end
		end
	else		
		if (SR_BuffFood and bag == false and SR_BuffTimeLeft() < SR_BuffTime) then
			bag, slot, iFinalName, iPower, iManapower = SR_FindDrink(iMananeed, "WATER_BUFF");
		end
		
		if (bag == false and not SR_Conjured) then
			bag, slot, iFinalName, iPower, iManapower = SR_FindDrink(iMananeed, "WATER_CONJURED");
		end
		
		if (bag == false) then
			bag, slot, iFinalName, iPower, iManapower = SR_FindDrink(iMananeed, "WATER");
		end
		
		if (bag == false) then
			bag, slot, iFinalName, iPower, iManapower = SR_FindDrink(iMananeed, "WATER_DYNAMIC");
		end
		
		if (bag == false and SR_Conjured) then
			bag, slot, iFinalName, iPower, iManapower = SR_FindDrink(iMananeed, "WATER_CONJURED");
		end
		
		if (SR_BuffFood and bag == false) then
			bag, slot, iFinalName, iPower, iManapower = SR_FindDrink(iMananeed, "WATER_BUFF");
		end
	end
	return bag, slot, iFinalName, iPower, iManapower;
end

function SR_Drink()
	if(not UnitAffectingCombat("player"))then
		local iMananeed = SR_NeedMana();
		if(iMananeed > 0)then
			if(not SR_IsDrinking())then
				SR_PrintMana(iMananeed);
				local bag, slot, name, iPower, iManapower = SR_FindBestDrink(iMananeed);
									
				if (bag == false) then
					SR_PrintNotFound("drinks");
					return false;
				else
					UseContainerItem(bag,slot);
					if(SR_Emotes)then
						SR_PrintEmote("is drinking " .. name .. ".");
					elseif(SR_Text)then
						SR_PrintDefault("Drinking " .. name);
					end
					return true;
				end
			else
				SR_PrintError("You're already drinking!");
				return false;
			end
		else
			SR_PrintNoManaNeed();
			return false;
		end
	else
		SR_PrintCombat();
		return false;
	end
end

function SR_Drink2(iMananeed)
	local bag, slot, name, iPower, iManapower = SR_FindBestDrink(iMananeed);				
	if (bag == false) then
		SR_PrintNotFound("drinks");
		return false;
	else
		UseContainerItem(bag,slot);
		if(SR_Emotes)then
			SR_PrintEmote("is drinking " .. name .. ".");
		elseif(SR_Text)then
			SR_PrintDefault("Drinking " .. name);
		end
		return true;
	end
end

-- Finds the best drinks in a certain category.
function SR_FindDrink(iMananeed, sCategory)
	SR_PrintDebug("Scanning " .. sCategory .. ".");
	local finalName;
	local finalSlot = 99;
	local finalBag = 0;
	local finalHeal = 0;
	local finalPower = 99999;
	local finalCount = 99999;
	for bag=0,NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag), 1 do
			local link = GetContainerItemLink(bag,slot);
			if (link) then
				local ItemID = SR_GetItemID(link); 							
				local sName, iLink, iQuality, iLevel, sClass, sSubClass = GetItemInfo("item:"..ItemID); 								
				if (sName and string.find(sClass, "Consumable") or (SR_QuestFood and string.find(sClass, "Quest"))) then
					local sMessage = "Looking at " .. sName .. " (" .. ItemID .. "), level " .. iLevel;					
					if(SR_ContainsItem(ItemID, sCategory)) then
						local iMana = 0;
						local iPower = 99999;
						if(string.find(sCategory, "WATER") or string.find(sCategory, "WATER_CONJURED"))then
							iMana = SR_GetManaFromDrinkLevel(iLevel);
						elseif(string.find(sCategory, "WATER_BUFF"))then
							iMana = SR_GetManaFromBuffDrinkLevel(iLevel);
						elseif(string.find(sCategory, "WATER_DYNAMIC"))then
							iMana = SR_GetManaFromDynamicDrinkname();
						end
						sMessage = sMessage .. " with " .. iMana .. " mana";
						if(SR_Smart == 2)then
							iPower = 0;
						else
							iPower = SR_GetPower(iMananeed,iMana,iLevel);	
							sMessage = sMessage .. " and " .. iPower .. " power";
						end
						if (iPower <= finalPower and UnitLevel("player") >= iLevel and iPower ~= 99999) then
							local texture, count = GetContainerItemInfo(bag, slot);
							local continue = false;
							sMessage = sMessage .. " in a stack of " .. count;
							if(iPower == finalPower)then
								if(count < finalCount)then
									continue = true;
								end
							else
								continue = true;
							end
							if(continue)then
								finalPower = iPower;
								finalBag = bag;
								finalSlot = slot;
								finalName = link;
								finalHeal = iMana;
								finalCount = count;
							end
						end
					end
					if(debugMode > 2)then
						SR_PrintDebug(sMessage .. ".");
					end
				end
			end
		end
	end
	if (finalSlot == 99) then
		return false, false, "", 99999, 0, 99999;
	else
		if(debugMode > 1)then
			SR_PrintDebug("Found " .. finalName .. ", with " .. finalPower .. " power in a stack of " .. finalCount .. ".");
		end
		return finalBag, finalSlot, finalName, finalPower, finalHeal, finalCount;
	end
end 

-- Returns the average amount the water restores based on it's iLevel
function SR_GetManaFromDrinkLevel(iLevel)
	if(iLevel < 5)then
		return 151;
	elseif(iLevel < 15)then
		return 436;
	elseif(iLevel < 25)then
		return 835;
	elseif(iLevel < 35)then
		return 1344;
	elseif(iLevel < 45)then
		return 1992;
	elseif(iLevel < 55)then
		return 2934;
	elseif(iLevel < 70)then
		return 4200;
	else
		return 0;
	end	
end

function SR_GetManaFromDynamicDrinkname()
	return floor(30 * UnitManaMax("player") * 0.02);
end

-- Returns the average amount the water restores based on it's iLevel
function SR_GetManaFromBuffDrinkLevel(iLevel)
	if(iLevel < 70)then
		return 4410;
	else
		return 0;
	end	
end
-----------------------------------------------------------------------------------------------------------
-- Drinks & Food Section
-----------------------------------------------------------------------------------------------------------

function SR_FindBestSmartRestore(iHealthneed, iMananeed)
	local iFinalName = "";
	local bag = false;
	local slot = false;
	local iPower = 99999;
	local iHealPower = 0;
	local iManapower = 0;
	if(SR_Smart ~= 1)then
		local count = 99999;		
		local bag2, slot2, name2, power2, healpower2, manapower2, count2;
		local sBattleground = SR_GetBattleground();
		if(sBattleground ~= nil)then
			if(string.find(sBattleground,ARATHIBASIN))then
				bag2, slot2, name2, power2, healpower2, manapower2, count2 = SR_FindDrinkFood(iHealthneed, iMananeed, "FOOD_ARATHI");
			elseif(string.find(sBattleground,WARSONGGULCH))then
				bag2, slot2, name2, power2, healpower2, manapower2, count2 = SR_FindDrinkFood(iHealthneed, iMananeed, "FOOD_WARSONG");
			end		
			if(bag2 and (power2 < iPower or (power2 == iPower and count2 < count)))then
				bag = bag2;
				slot = slot2;
				iFinalName = name2;
				iPower = power2;
				iHealPower = healpower2;
				iManapower = manapower2;
				count = count2;
			end
		end
		
		if (SR_BuffFood and SR_BuffTimeLeft() < SR_BuffTime) then
			bag2, slot2, name2, power2, healpower2, manapower2, count2 = SR_FindDrinkFood(iHealthneed, iMananeed, "FOOD_WATER_BUFF");
			if(power2 < iPower or (power2 == iPower and count2 < count))then
				bag = bag2;
				slot = slot2;
				iFinalName = name2;
				iPower = power2;
				iHealPower = healpower2;
				iManapower = manapower2;
				count = count2;
			end
		end
		
		bag2, slot2, name2, power2, healpower2, manapower2, count2 = SR_FindDrinkFood(iHealthneed, iMananeed, "FOOD_WATER");
		if(power2 < iPower or (power2 == iPower and count2 < count))then
			bag = bag2;
			slot = slot2;
			iFinalName = name2;
			iPower = power2;
			iHealPower = healpower2;
			iManapower = manapower2;
			count = count2;
		end

		bag2, slot2, name2, power2, healpower2, manapower2, count2 = SR_FindDrinkFood(iHealthneed, iMananeed, "FOOD_WATER_DYNAMIC");
		if(power2 < iPower or (power2 == iPower and count2 < count))then
			bag = bag2;
			slot = slot2;
			iFinalName = name2;
			iPower = power2;
			iHealPower = healpower2;
			iManapower = manapower2;
			count = count2;
		end
		
		if (SR_CookingFood) then
			bag2, slot2, name2, power2, healpower2, manapower2, count2 = SR_FindDrinkFood(iHealthneed, iMananeed, "FOOD_WATER_COOKING");
			if(power2 < iPower or (power2 == iPower and count2 < count))then
				bag = bag2;
				slot = slot2;
				iFinalName = name2;
				iPower = power2;
				iHealPower = healpower2;
				iManapower = manapower2;
				count = count2;
			end
		end	
	else
		local sBattleground	= SR_GetBattleground();
		if(sBattleground ~= nil)then
			if(string.find(sBattleground,ARATHIBASIN))then
				bag, slot, iFinalName, iPower, iHealPower, iManapower = SR_FindDrinkFood(iHealthneed, iMananeed, "FOOD_ARATHI");
			elseif(string.find(sBattleground,WARSONGGULCH))then
				bag, slot, iFinalName, iPower, iHealPower, iManapower = SR_FindDrinkFood(iHealthneed, iMananeed, "FOOD_WARSONG");
			end	
		end
			
		if (SR_BuffFood and bag == false and SR_BuffTimeLeft() < SR_BuffTime) then
			bag, slot, iFinalName, iPower, iHealPower, iManapower = SR_FindDrinkFood(iHealthneed, iMananeed, "FOOD_WATER_BUFF");
		end
		
		if (bag == false) then
			bag, slot, iFinalName, iPower, iHealPower, iManapower = SR_FindDrinkFood(iHealthneed, iMananeed, "FOOD_WATER");
		end
		
		if (bag == false) then
			bag, slot, iFinalName, iPower, iHealPower, iManapower = SR_FindDrinkFood(iHealthneed, iMananeed, "FOOD_WATER_DYNAMIC");
		end

		if (SR_CookingFood and bag == false) then
			bag, slot, iFinalName, iPower, iHealPower, iManapower = SR_FindDrinkFood(iHealthneed, iMananeed, "FOOD_WATER_COOKING");
		end
	end
	return bag, slot, iFinalName, iPower, iHealPower, iManapower;
end

function SR_SmartRestore()
	if(not UnitAffectingCombat("player"))then
		if(string.find(SR_PlayerClass, "HUNTER") and SR_AutoFeed)then
			if(SR_SmartPetFeed())then
				return true;
			end
		end
		if(not(SR_IsEating() and SR_IsDrinking()))then -- Returns false when both eating and drinking, true otherwise.
			local iHealthneed = SR_NeedHealth("player");	-- Check if the player needs health.
			local iMananeed = SR_NeedMana();	-- Check if the player needs mana.
			if(iHealthneed > 0 or iMananeed > 0)then
				if((not SR_IsDrinking()) and (not SR_IsEating()) and iHealthneed > 0 and iMananeed > 0)then	-- If the player is not drinking and not eating and in need of both.
					SR_PrintHealthMana(iHealthneed,iMananeed);
					local bag, slot, name, iPower, iHealPower, iManapower = SR_FindBestSmartRestore(iHealthneed, iMananeed);
						
					if (bag == false) then
						return (SR_Eat2(iHealthneed) and SR_Drink2(iMananeed));
					else
						UseContainerItem(bag,slot);
						if(SR_Emotes)then
							SR_PrintEmote("is eating/drinking " .. name .. ".");
						elseif(SR_Text)then
							SR_PrintDefault("Eating/Drinking " .. name);
						end	
						return true;
					end
				else -- This is used when only mana or health is needed and when the player is not drinking or not eating.
					if(iHealthneed > 0 and not SR_IsEating())then
						SR_PrintHealth(iHealthneed);
						return SR_Eat2(iHealthneed);
					elseif(iMananeed > 0 and not SR_IsDrinking())then
						SR_PrintMana(iMananeed);
						return SR_Drink2(iMananeed);
					else
						return false;
					end
				end
			else
				SR_PrintError("You don't need health or mana!");
				return false;
			end
		else
			SR_PrintError("You're already eating and drinking!");
			return false;
		end
	else
		SR_PrintCombat();
		return false;
	end
end

-- Finds the best food & drink combo in a certain category.
function SR_FindDrinkFood(iHealthneed, iMananeed, sCategory)
	SR_PrintDebug("Scanning " .. sCategory .. ".");
	local finalName;
	local finalSlot = 99;
	local finalBag = 0;
	local finalHeal = 0;
	local finalHeal2 = 0;
	local finalPower = 99999;
	local finalCount = 99999;
	for bag=0,NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag), 1 do
			local link = GetContainerItemLink(bag,slot);
			if (link) then
				local ItemID = SR_GetItemID(link); 							
				local sName, iLink, iQuality, iLevel, sClass, sSubClass = GetItemInfo("item:"..ItemID); 								
				if (sName and string.find(sClass, "Consumable") or (SR_QuestFood and string.find(sClass, "Quest"))) then
					local sMessage = "Looking at " .. sName .. " (" .. ItemID .. "), level " .. iLevel;					
					if(SR_ContainsItem(ItemID, sCategory)) then
						local iMana = 0;
						local iHealth = 0;
						local iPower = 99999;
						if(string.find(sCategory, "FOOD_WATER") or string.find(sCategory, "FOOD_WATER_BUFF"))then
							iHealth, iMana = SR_GetHealAndManaFromDrinkFoodLevel(iLevel);
						elseif(string.find(sCategory, "FOOD_WATER_COOKING"))then
							iHealth, iMana = SR_GetHealAndManaFromCookingDrinkFoodLevel(iLevel);
						elseif(string.find(sCategory, "FOOD_ARATHI") or string.find(sCategory, "FOOD_WARSONG")) then 
							iHealth, iMana = SR_GetHealAndManaFromBattlegroundFoodLevel(iLevel);
						elseif(string.find(sCategory, "FOOD_WATER_DYNAMIC"))then
							iHealth, iMana = SR_GetHealAndManaFromDynamicDrinkFoodLevel();
						end
						sMessage = sMessage .. " with " .. iHealth .. " health, " .. iMana .. " mana";
						if(SR_Smart == 2)then
							iPower = 0;
						else
							iPower = SR_GetPowerSlow(iHealthneed,iHealth,iLevel) + SR_GetPowerSlow(iMananeed,iMana,iLevel);	
							sMessage = sMessage .. " and " .. iPower .. " power";
						end
						if (iPower <= finalPower and UnitLevel("player") >= iLevel and iPower ~= 99999) then
							local texture, count = GetContainerItemInfo(bag, slot);
							local continue = false;
							sMessage = sMessage .. " in a stack of " .. count;
							if(iPower == finalPower)then
								if(count < finalCount)then
									continue = true;
								end
							else
								continue = true;
							end
							if(continue)then
								finalPower = iPower;
								finalBag = bag;
								finalSlot = slot;
								finalName = link;
								finalHeal = iHealth;
								finalHeal2 = iMana;
								finalCount = count;
							end
						end
					end
					if(debugMode > 2)then
						SR_PrintDebug(sMessage .. ".");
					end
				end
			end
		end
	end
	if (finalSlot == 99) then
		return false, false, "", 99999, 0, 0, 99999;
	else
		if(debugMode > 1)then
			SR_PrintDebug("Found " .. finalName .. ", with " .. finalPower .. " power in a stack of " .. finalCount .. ".");
		end
		return finalBag, finalSlot, finalName, finalPower, finalHeal, finalHeal2, finalCount;
	end
end 


-- Returns the average amount the food heals based on it's iLevel
function SR_GetHealAndManaFromBattlegroundFoodLevel(iLevel)
	if(iLevel < 35)then
		return 1074, 2202;
	elseif(iLevel < 45)then
		return 1608, 3306;
	elseif(iLevel < 70)then
		return 2148, 4410;
	else
		return 0,0;
	end	
end

-- Returns the average amount the food heals based on it's iLevel
function SR_GetHealAndManaFromDrinkFoodLevel(iLevel)
	if(iLevel < 10)then
		return 294, 294;
	elseif(iLevel < 30)then
		return 378, 567;
	elseif(iLevel < 45)then
		return 840, 1260;
	elseif(iLevel < 51)then
		return 2148, 4410;
	elseif(iLevel < 55)then
		return 4410, 4410;
	elseif(iLevel < 70)then
		return 2550, 4410;
	else
		return 0,0;
	end	
end

-- Returns the average amount the food heals based on it's iLevel
function SR_GetHealAndManaFromCookingDrinkFoodLevel(iLevel)
	if(iLevel < 30)then
		return 155, 315;
	elseif(iLevel < 70)then
		return 567, 882;
	else
		return 0,0;
	end	
end

function SR_GetHealAndManaFromDynamicDrinkFoodLevel()
	return floor(25 * UnitHealthMax("player") * 0.03) , floor(25 * UnitManaMax("player") * 0.03);
end

-----------------------------------------------------------------------------------------------------------
-- Buff Section
-----------------------------------------------------------------------------------------------------------

function SR_Buff()
	if(not UnitAffectingCombat("player")) then
		local bag, slot, name = SR_FindDrinkFood(5000,5000, "FOOD_WATER_BUFF"); -- The 99999 is just a high value to get the best buffing food.
		if (bag == false) then
			--SR_PrintNotFound("buffing combo food & drinks");
			if(not SR_EatBuff()) then
				return SR_DrinkBuff();
			else
				return true;
			end
		else
			UseContainerItem(bag,slot);
			if(SR_Emotes)then
				SR_PrintEmote("is using " .. name .. ".");
			elseif(SR_Text)then
				SR_PrintDefault("Using " .. name);
			end
			return true;
		end
	else
		SR_PrintCombat();
		return false;
	end
end

function SR_DrinkBuff()
	local bag, slot, name = SR_FindDrinkFood(5000, 5000, "WATER_BUFF");
	if (bag == false) then
		SR_PrintNotFound("buffing drinks");
		return false;
	else
		UseContainerItem(bag,slot);
		if(SR_Emotes)then
			SR_PrintEmote("is drinking " .. name .. ".");
		elseif(SR_Text)then
			SR_PrintDefault("Drinking " .. name);
		end
		return true;
	end
end

function SR_EatBuff()
	local bag, slot, name = SR_FindDrinkFood(5000, 5000, "FOOD_BUFF_DYNAMIC");
	if (bag == false) then
		bag, slot, name = SR_FindDrinkFood(5000, 5000, "FOOD_BUFF");
	end
	if (bag == false) then
		SR_PrintNotFound("buffing food");
		return false;
	else
		UseContainerItem(bag,slot);
		if(SR_Emotes)then
			SR_PrintEmote("is eating " .. name .. ".");
		elseif(SR_Text)then
			SR_PrintDefault("Eating " .. name);
		end
		return true;
	end
end
-----------------------------------------------------------------------------------------------------------
-- Smart
-----------------------------------------------------------------------------------------------------------
function SR_SmartUse()
	if(UnitAffectingCombat("player")) then
		return SR_SmartPotion();
	else
		return SR_SmartRestore();
	end
end

-----------------------------------------------------------------------------------------------------------
-- Anti-Venom
-----------------------------------------------------------------------------------------------------------

function SR_GetAntiVenomLevel(sName)
	local bandageLevel = 0;
	if (string.find(sName, "Powerful")) then
		bandageLevel = 300;
	elseif (string.find(sName, "Strong")) then
		bandageLevel = 130;
	else
		bandageLevel = 80;
	end
	return bandageLevel;
end 	

function SR_AntiVenom()
	local TargetEnemy = false;	
	local TargetFriend = false;	
	local returnValue = false;
	
	if (not UnitName("target")) then
		TargetUnit("player");
	end
	
	if (not UnitIsFriend("player","target")) then
		TargetUnit("player");
		TargetEnemy = true;
	elseif (UnitIsFriend("player","target") and not UnitIsUnit("player","target")) then
		TargetFriend = true;
	end
		
	local poison = SR_IsPoisoned("target");
	if(poison)then
		SR_PrintDebug(UnitName("target") .. " needs anti-venom!");
		local bag, slot, name = SR_FindAntiVenom("target");
		if (bag == false) then
			SR_PrintNotFound("anti-venom");
			returnValue = false;
		else
			UseContainerItem(bag,slot);
			if(SR_Emotes)then
				SR_PrintEmote("is using " .. name .. " on " .. UnitName("target") .. ".");
			elseif(SR_Text)then
				SR_PrintDefault("Using " .. name .. " on " .. UnitName("target"));
			end
			returnValue = true;
		end
	else
		SR_PrintError(UnitName("target") .. " isn't poisoned!");
		returnValue = false;
	end
	
	if(not TargetFriend)then
		ClearTarget();		
	end
	if(TargetEnemy)then
		TargetLastEnemy();
		if (UnitHealth("target") == 0) then
			ClearTarget();
			TargetNearestEnemy();
		end
	end
	return returnValue;
end

-- Returns the best anti-venom available.
function SR_FindAntiVenom(target)
	SR_PrintDebug("Scanning ANTIVENOM...");
	local finalName;
	local finalSlot = 99;
	local finalBag = 0;
	local finalPower = 0;
	for bag=0,NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag), 1 do
			local link = GetContainerItemLink(bag,slot);
			if (link) then
				local ItemID = SR_GetItemID(link); 							
				local sName, iLink, iQuality, iLevel, sClass, sSubClass = GetItemInfo("item:"..ItemID); 					
				if (sName and string.find(sClass, "Reagent")) then
					local sMessage = "Looking at " .. sName .. " (" .. ItemID .. ")";			
					if(SR_ContainsItem(ItemID, "ANTIVENOM")) then
						local iPower = SR_GetAntiVenomLevel(sName);
						sMessage = sMessage .. " , with " .. iPower .. " power";
						local texture, count = GetContainerItemInfo(bag, slot);
						local continue = false;
						sMessage = sMessage .. " in a stack of " .. count;
						if(iPower == finalPower)then
							if(count < finalCount)then
								continue = true;
							end
						else
							continue = true;
						end
						if(continue)then
							finalPower = iPower;
							finalBag = bag;
							finalSlot = slot;
							finalName = link;
							finalHeal = iMana;
							finalCount = count;
						end
					end
					if(debugMode > 2)then
						SR_PrintDebug(sMessage .. ".");
					end
				end
			end
		end
 	end
 	if (finalSlot == 99) then
		return false, false, "", 0;
 	else
 		if(debugMode > 1)then
			SR_PrintDebug("Found " .. finalName .. ", with " .. finalPower .. " power in a stack of " .. finalCount .. ".");
		end
		local start,duration = GetContainerItemCooldown(finalBag,finalSlot);
		if (start == 0) then
			return finalBag, finalSlot, finalName, finalPower, finalHeal, finalCount;
		else	
			SR_PrintError("Can't drink " .. finalName .. " for another " .. floor(duration - ( GetTime() - start)) .. " seconds!");
			return false, false, "", 99999, 0, 99999;
		end
 	end
end

-----------------------------------------------------------------------------------------------------------
-- Smart Petfeed Section
-----------------------------------------------------------------------------------------------------------
-- The smart feed general function.
function SR_SmartPetFeed()
	if(string.find(SR_PlayerClass, "HUNTER") and UnitExists("pet") and not UnitIsDead("pet") and GetPetFoodTypes() ~= nil)then
		local happiness, damagePercentage, loyaltyRate = GetPetHappiness();
		-- Number - the numerical happiness value of the pet (1 = unhappy, 2 = content, 3 = happy) 
		if(happiness < SR_PetHappiness and not UnitAffectingCombat("pet") and not UnitAffectingCombat("player") and not SR_PetAlreadyFoodBuffed())then
			-- Only if FeedOMatic is available.
			if(FOM_VERSION)then
				FOM_Feed(nil); -- automatically find a food and feed it
				return true;
			-- Petfeeder support
			elseif(PETFEEDER_TAB_SUBFRAMES)then		
				PetFeeder_Feed();
				return true;
			-- My own petfeed mod. Nothing wrong with it, but I guess some people would prefer another mod.
			else	
				SR_PetFoodList = {GetPetFoodTypes()};
				-- Possibilities: Meat, Fish, Bread, Cheese, Fungus, Fruit 
				-- Have to do a check on Raw Fish. If that matters at all...
				local debugMessage;
				if(SR_PetFoodList[1] ~= nil)then
					debugMessage = "Pet diet: " .. SR_PetFoodList[1];
					local index, j;
					for index, j in SR_PetFoodList do
						if (SR_PetFoodList[index] ~= nil) then	
							debugMessage = debugMessage .. ", " .. SR_PetFoodList[index];
						end
					end
				end
				if(debugMessage ~= nil)then
					SR_PrintDebug(debugMessage);
				end
				local finalBag, finalSlot, finalName = SR_GetPetFood();
							
				-- Real feeding
				if(finalBag ~= false)then
					PickupContainerItem(finalBag,finalSlot);
	 				DropItemOnUnit("pet");
	 				if(SR_Emotes)then
						SR_PrintEmote("is using " .. finalName .. " to feed " .. UnitName("pet") .. ".");
					elseif(SR_Text)then
						SR_PrintDefault("Using " .. finalName .. " to feed " .. UnitName("pet"));
					end
	 				return true;
	 			else
	 				SR_PrintError("Didn't find anything to feed " .. UnitName("pet") .. " with!");
	 				return false;
				end
			end
			return false;
		end
	end
end

-- Finds the best food in one category.
function SR_GetPetFood()
	local finalName;
	local finalSlot = 99;
	local finalBag = 0;
	local finalPower = 99999;
	if(SR_PetFeedMode == 1)then
		finalPower = 0;
	end
	local finalCount = 99999;
	for bag=0,NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag), 1 do
			local link = GetContainerItemLink(bag,slot);
			if (link) then
				local ItemID = SR_GetItemID(link); 							
				local sName, iLink, iQuality, iLevel, sClass, sSubClass = GetItemInfo("item:"..ItemID); 								
				if (sName and (string.find(sClass, "Consumable") or string.find(sClass, "Trade Goods"))) then
					local sMessage = "Looking at " .. sName .. " (" .. ItemID .. "), level " .. iLevel;					
					if(SR_InPetDietList(ItemID)) then
						local continue = true;
						local iPower = iLevel;
						
						-- Check for buff food
						if(not SR_PetBuffFood)then
							if(SR_ContainsItem(ItemID, "FOOD_BUFF")) then
								continue = false;
							end
						end
						
						-- Check for cooking food.
						if(not SR_PetCookingFood)then -- If cookable food is not allowed
							if(not (SR_ContainsItem(ItemID, "FOOD") or SR_ContainsItem(ItemID, "FOOD_BUFF") or SR_ContainsItem(ItemID, "FOOD_CONJURED"))) then -- The food has to be cooked, and therefor eatable by the player.
								continue = false;
							end
						end
					
						-- If conjured, change the power according to the mode we're using. Conjured food is superior to everything else. Uch.
						if(SR_ContainsItem(ItemID, "FOOD_CONJURED"))then
							if(SR_PetFeedMode == 0)then
								iPower = iLevel - 100;
							else
								iPower = iLevel + 100;
							end
						end
												
						if (continue and ((SR_PetFeedMode == 0 and iPower <= finalPower) or (SR_PetFeedMode == 1 and iPower >= finalPower)) and UnitLevel("pet") >= iLevel and (iLevel >= UnitLevel("pet") -35 or (iLevel == 0 and string.find(sClass, "Trade Goods"))))then
							continue = false;													
							local texture, count = GetContainerItemInfo(bag, slot);
							sMessage = sMessage .. " in a stack of " .. count;
							if(iPower == finalPower)then
								if(count < finalCount)then
									continue = true;
								end
							else
								continue = true;
							end
							if(continue)then
								finalPower = iPower;
								finalBag = bag;
								finalSlot = slot;
								finalName = link;
								finalCount = count;
							end
						end
					end
					if(debugMode > 2)then
						SR_PrintDebug(sMessage .. ".");
					end
				end
			end
		end
	end
	if (finalSlot == 99) then
		return false, false, "";
	else
		if(debugMode > 1)then
			SR_PrintDebug("Found " .. finalName .. ", with " .. finalPower .. " power in a stack of " .. finalCount .. ".");
		end
		return finalBag, finalSlot, finalName;
	end
end

-- Returns true is the feedbuff is found on the hunter's pet.
function SR_PetAlreadyFoodBuffed()
	local index = 0;
	local loop = true;
	while (loop) do
		local buff = UnitBuff("pet", index);
		if (buff) then
			if (string.find(buff, "Ability_Hunter_BeastTraining"))then 
				SR_PrintDebug("Found active foodbuff on pet!");
				return true;
			end
		else
			if(index ~= 0)then
				loop = false;
			end
		end
		index = index+1;
	end
	return false;
end

-- This function returns true if the itemid is found in any of the lists with the food for the hunter's pet.
function SR_InPetDietList(ItemID)
	local index, j;
	for index, j in SR_PetFoodList do
		if (SR_PetFoodList[index] ~= nil) then	
			local sString = SR_PetFoodList[index];
			if(string.find("Meat", sString))then
				sCategory = "FOOD_PET_MEAT";	
			elseif(string.find("Fish", sString))then
				sCategory = "FOOD_PET_FISH";	
			elseif(string.find("Fruit", sString))then
				sCategory = "FOOD_PET_FRUIT";	
			elseif(string.find("Fungus", sString))then
				sCategory = "FOOD_PET_FUNGUS";	
			elseif(string.find("Bread", sString))then
				sCategory = "FOOD_PET_BREAD";	
			elseif(string.find("Cheese", sString))then
				sCategory = "FOOD_PET_CHEESE";	
			else
				return false;
			end
				
			if(SR_ContainsItem(ItemID, sCategory)) then
				return true;
			end
		end
	end
	return false;
end

-----------------------------------------------------------------------------------------------------------
-- Commands Section
-----------------------------------------------------------------------------------------------------------
function SR_SplitArgs(line)
  local args = {};
  for arg in string.gfind(line, "[^%s]+") do
	 table.insert(args, arg);
  end
  return args;
end

function SmartRestoreCommand(msg)
  	local args = SR_SplitArgs(string.lower(msg));
  	local cmd = args[1];	
	if cmd == "bandage" then
		SR_Bandage();
	elseif( cmd == "smartrestore") then
		SR_SmartRestore();
	elseif(cmd == "mana")then
		SR_Mana();
	elseif (cmd == "health")then
		SR_Health();
	elseif (cmd == "smartpotion")then
		SR_SmartPotion();
	elseif (cmd == "eat")then
		SR_Eat();
	elseif (cmd == "drink") then
		SR_Drink();
	elseif (cmd == "smart")then
		SR_SmartUse();
	elseif (cmd == "petfeed" or cmd == "feed")then
		SR_SmartPetFeed();
	elseif (cmd == "buff")then
		SR_Buff();
	elseif (cmd == "antivenom")then
		SR_AntiVenom();
	elseif(cmd == "default" or cmd == "reset")then
		SR_Reset();
	elseif (cmd == "maxhealth" and args[2])then
		local newHealth = tonumber(args[2]);		
		if(newHealth > 100)then
			SR_HealthPCT = 100;
		elseif(newHealth < 10)then
			SR_HealthPCT = 10;
		else
			SR_HealthPCT = newHealth;
		end
		SR_PrintSettings("Health limit: " .. SR_HealthPCT);
	elseif (cmd == "maxmana" and args[2])then
		local newMana = tonumber(args[2]);		
		if(newMana > 100)then
			SR_ManaPCT = 100;
		elseif(newMana < 10)then
			SR_ManaPCT = 10;
		else
			SR_ManaPCT = newMana;
		end
		SR_PrintSettings("Mana limit: " .. SR_ManaPCT);
	elseif (cmd == "bufftime" and args[2])then
		local newTime = tonumber(args[2]);		
		if(newTime < 0)then
			SR_BuffTime = 0;
		else
			SR_BuffTime = newTime;
		end
		SR_PrintSettings("Buff time: " .. SR_BuffTime);
	elseif (cmd == "minhealth" and args[2])then
		local newMin = tonumber(args[2]);		
		if(newMin < 0)then
			SR_MinHealthPCT = 0;
		else
			SR_MinHealthPCT = newMin;
		end
		SR_PrintSettings("Minimum health limit: " .. SR_MinHealthPCT);
	elseif (cmd == "foodmultiplier" and args[2])then
		local new = tonumber(args[2]);		
		if(new < 1)then
			SR_SlowFoodMultiplier = 1;
		else
			SR_SlowFoodMultiplier = new;
		end
		SR_PrintSettings("Minimum health limit: " .. SR_MinHealthPCT);
	elseif(cmd == "text")then
		if(SR_Text) then
			SR_Text = false;
			SR_PrintSettings("Text is off!");
		else
			SR_Text = true;
			SR_PrintSettings("Text is on!");
		end
	elseif(cmd == "emotes")then
		if(SR_Emotes) then
			SR_Emotes = false;
			SR_PrintSettings("Emotes are off!");
		else
			SR_Emotes = true;
			SR_PrintSettings("Emotes are on!");
		end
	elseif(cmd == "quest")then
		if(SR_QuestFood) then
			SR_QuestFood = false;
			SR_PrintSettings("Not using quest food!");
		else
			SR_QuestFood = true;
			SR_PrintSettings("Using quest food!");
		end
	elseif (cmd == "cooking")then
		if(SR_CookingFood) then
			SR_CookingFood = false;
			SR_PrintSettings("Not using cooking food!");
		else
			SR_CookingFood = true;
			SR_PrintSettings("Using cooking food!");
		end
	elseif (cmd == "buffing")then
		if(SR_BuffFood) then
			SR_BuffFood = false;
			SR_PrintSettings("Not using buffing food!");
		else
			SR_BuffFood = true;
			SR_PrintSettings("Using buffing food!");
		end
	elseif (cmd == "petcooking")then
		if(SR_PetCookingFood) then
			SR_PetCookingFood = false;
			SR_PrintSettings("Not using cooking food for pet!");
		else
			SR_PetCookingFood = true;
			SR_PrintSettings("Using cooking food for pet!");
		end
	elseif (cmd == "petbuffing")then
		if(SR_PetBuffFood) then
			SR_PetBuffFood = false;
			SR_PrintSettings("Not using buffing food for pet!");
		else
			SR_PetBuffFood = true;
			SR_PrintSettings("Using buffing food for pet!");
		end
	elseif (cmd == "autofeed")then
		if(SR_AutoFeed) then
			SR_AutoFeed = false;
			SR_PrintSettings("Not feeding pet automatically!");
		else
			SR_AutoFeed = true;
			SR_PrintSettings("Feeding pet automatically!");
		end
	elseif(cmd == "forcepotion")then
		if(SR_Force) then
			SR_Force = false;
			SR_PrintSettings("Not using potions out of combat!");
		else
			SR_Force = true;
			SR_PrintSettings("Using potions out of combat!");
		end
	elseif(cmd == "antivenombeforebandage")then
		if(SR_AntiPoisonBeforeBandage) then
			SR_AntiPoisonBeforeBandage = false;
			SR_PrintSettings("Not applying anti-venom before bandaging!");
		else
			SR_AntiPoisonBeforeBandage = true;
			SR_PrintSettings("Applying anti-venom before bandaging!");
		end
	 elseif (cmd == "debug" and args[2])then
	 	local new = tonumber(args[2]);	
		if(new < 0) then
			debugMode = 0;
		else
			debugMode = new;
		end
		if(debugMode > 0)then
			SR_PrintSettings("Debug mode " .. debugMode .. " activated!");
		else
			SR_PrintSettings("Debug mode deactivated!");
		end
	elseif (cmd == "mode" and args[2])then
		local new = tonumber(args[2]);		
		if(new < 0)then
			SR_Smart = 0;
		elseif(new > 2)then
			SR_Smart = 0;
		else
			SR_Smart = new;
		end
		local sMessage = "Using mode: " .. SR_Smart;
		if(SR_Smart == 0)then
			sMessage = sMessage .. " (Restore value based)";
		elseif(SR_Smart == 1)then
			sMessage = sMessage .. " (Category based)";
		elseif(SR_Smart == 2)then
			sMessage = sMessage .. " (Stack size based)";
		end
		SR_PrintSettings(sMessage);
	 elseif (cmd == "pethappiness" and args[2])then
	 	local new = tonumber(args[2]);	
		if(new < 0) then
			SR_PetHappiness = 0;
		elseif(new > 3) then
			SR_PetHappiness = 3;
		else
			SR_PetHappiness = new;
		end
		if(SR_PetHappiness > 1)then
			local messageadd = "";
			if(SR_PetHappiness == 2)then
				messageadd = "content";
			else
				messageadd = "happy";
			end
			SR_PrintSettings("Pet happiness goal: " .. messageadd .. ".");
		else
			SR_PrintSettings("Pet feeding disabled!");
		end
	elseif (cmd == "bestfood")then
		if(SR_PetFeedMode == 1) then
			SR_PetFeedMode = 0;
		else
			SR_PetFeedMode = 1;
		end
		if(SR_PetFeedMode == 1)then
			SR_PrintSettings("Using best food for pet!");
		else
			SR_PrintSettings("Using worst food for pet!");
		end
	elseif (cmd == "conjuredlast")then
		if(SR_Conjured) then
			SR_Conjured = false;
			SR_PrintSettings("Using conjured food first!");
		else
			SR_Conjured = true;
			SR_PrintSettings("Using conjured food last!");
		end
	elseif (cmd == "maximumuse" or cmd == "maxuse")then
		if(SR_MaxUse) then
			SR_MaxUse = false;
			SR_PrintSettings("Using items based on the need of the player!");
		else
			SR_MaxUse = true;
			SR_PrintSettings("Always using the best items!");
		end
	elseif (cmd == "status")then
		SR_PrintSettings("SmartRestore " .. SMARTRESTORE_VERSION);
		SR_PrintSettings("Bandage skill: " .. SR_BandageSkill);
		SR_PrintSettings("Health percent: " .. SR_HealthPCT);
		SR_PrintSettings("Minimum Health: " .. SR_MinHealthPCT);
		SR_PrintSettings("Mana percent: " .. SR_ManaPCT);
		SR_PrintSettings("Buff threshhold: " .. SR_BuffTime);
		SR_PrintSettings("Food multiplier: " .. SR_SlowFoodMultiplier)
		
		if(SR_Text)then
			SR_PrintSettings("Text is activated.");
		else
			SR_PrintSettings("Text is deactivated.");
		end
		if(SR_Emotes)then
			SR_PrintSettings("Emotes are activated.");
		else
			SR_PrintSettings("Emotes are deactivated.");
		end	
		if(SR_CookingFood)then
			SR_PrintSettings("Using cookable food.");
		else
			SR_PrintSettings("Not using cookable food.");
		end
		if(SR_QuestFood)then
			SR_PrintSettings("Using quest food.");
		else
			SR_PrintSettings("Not using quest food.");
		end
		if(SR_BuffFood)then
			SR_PrintSettings("Using buffing food.");
		else
			SR_PrintSettings("Not using buffing food.");
		end
		if(SR_Smart == 0)then
			SR_PrintSettings("SmartRestore Mode: 0 (Restore value based)");
		elseif(SR_Smart == 1)then
			SR_PrintSettings("SmartRestore Mode: 1 (Category based)");
		elseif(SR_Smart == 2)then
			SR_PrintSettings("SmartRestore Mode: 2 (Stack size based)");
		end
		if(string.find(SR_PlayerClass, "HUNTER"))then
			if(SR_PetHappiness < 2)then
				SR_PrintSettings("Pet feeding disabled");
			elseif(SR_PetHappiness == 2)then
				SR_PrintSettings("Pet happiness goal: content");
			else
				SR_PrintSettings("Pet happiness goal: happy");
			end
			if(SR_PetFeedMode == 1)then
				SR_PrintSettings("Using best food for pet!");
			else
				SR_PrintSettings("Using worst food for pet!");
			end
			if(SR_PetCookingFood)then
				SR_PrintSettings("Using cookable food for pet.");
			else
				SR_PrintSettings("Not using cookable food for pet.");
			end
			if(SR_PetBuffFood)then
				SR_PrintSettings("Using buffing food for pet.");
			else
				SR_PrintSettings("Not using buffing food for pet.");
			end
			if(SR_AutoFeed)then
				SR_PrintSettings("Feeding pet automatically!");
			else
				SR_PrintSettings("Not feeding pet automatically!");
			end
		end
		if(SR_Force)then
			SR_PrintSettings("Using potions out of combat.");
		else
			SR_PrintSettings("Not using potions out of combat.");
		end
		if(SR_Conjured)then
			SR_PrintSettings("Using conjured food last!");
		else
			SR_PrintSettings("Using conjured food first!");
		end
		if(SR_MaxUse) then
			SR_PrintSettings("Always using the best items!");
		else
			SR_PrintSettings("Using items based on the need of the player!");
		end
		if(SR_AntiPoisonBeforeBandage) then
			SR_PrintSettings("Applying anti-venom before bandaging!");
		else
			SR_PrintSettings("Not applying anti-venom before bandaging!");
		end
	else	
		SR_PrintSettings("SmartRestore " .. SMARTRESTORE_VERSION);
		SR_PrintSettings("/sr or /smartrestore - Display this list with commands.");
		
		SR_PrintSettings("/sr smart - Triggers the smartrestore function if out combat, or the smartpotion function if in combat, thus always resulting in the best restoration.");
		SR_PrintSettings("/sr smartrestore - Triggers the smartrestore function resulting in drinking and eating simultaneously.");
		SR_PrintSettings("/sr smartpotion - Triggers the rejuvenation function resulting in using the best rejuvenation available.");
		SR_PrintSettings("/sr bandage - Triggers the bandage function resulting in using the best bandage available on a selected friendly player or the player self.");
		SR_PrintSettings("/sr mana - Triggers the mana function resulting in using the best mana potion. or conjured gem if available.");
		SR_PrintSettings("/sr health - Triggers the health function resulting in using the best healing potion or healthstone if available.");
		SR_PrintSettings("/sr eat - Triggers the eat function resulting in using the best food available.");
		SR_PrintSettings("/sr drink - Triggers the drink function resulting in using the best drink available.");
		SR_PrintSettings("/sr feed or /sr petfeed - Triggers the Pet Feed function resulting in trying to feed the player's pet if he has a pet and is a hunter.");
		SR_PrintSettings("/sr buff - Will try to eat the best available buff food.");
		SR_PrintSettings("/sr antivenom - Triggers the Anti-Venom function resulting in trying to use the Anti-Venom inventory items if the target is poisoned.");
		
		SR_PrintSettings("/sr mode ## - Allows the player to define the way the mod chooses items. In mode 0 the best food out of all categories will be used. In mode 1 the first found item will be used. In mode 2 the item from the smallest stack will be used. (Currently active is mode " .. SR_Smart .. ")");
		SR_PrintSettings("/sr maxhealth ## - Allows the player to define the percentage of health under which potions, food and bandages can be used. (80 would mean that only when current health of the player is below 80% healing will be applied.) Minimum value is 10%. (Currently " .. SR_HealthPCT .. "%)");
		SR_PrintSettings("/sr maxmana ## - Allows the player to define the percentage of mana under which potions and drinks can be used. (Currently " .. SR_ManaPCT .. "%)");
		SR_PrintSettings("/sr bufftime ## - Allows the player to define the time (in seconds) of the current foodbuff under which buffing food may be used. Minimum value is 0. (Currently " .. SR_BuffTime .. " seconds)");
		SR_PrintSettings("/sr minhealth ## - Allows the player to define the minimum amount of health the player should have to allow the use of mana potions through the smartpotion function. (Currently " .. SR_MinHealthPCT .. "%)");
		SR_PrintSettings("/sr foodmultiplier ## - Allows the player to define the multiplier used for power calculation of slow food. (Currently " .. SR_SlowFoodMultiplier .. ")");
		
		if(string.find(SR_PlayerClass, "HUNTER"))then
			SR_PrintSettings("/sr pethappiness ## - Allows the player to define the pet happiness goal. When set to 0 or 1 petfeeding is disabled. 2 means content is the goal when feeding. 3 is happy. (Currently " .. SR_PetHappiness .. ")");
			SR_PrintSettings("/sr bestfood - Allows the player to define how to choose food for the pet. On means best food will be choosen, off the worst available food. (Currently " .. SR_BooleanToString(SR_PetFeedMode) .. ")");
			SR_PrintSettings("/sr petcooking - (Dis)Allow the use of food that could be cooked first for your pet. (Currently " .. SR_BooleanToString(SR_PetCookingFood) .. ")");
			SR_PrintSettings("/sr petbuffing - (Dis)Allow the use of food that give bonusses for your pet. (Currently " .. SR_BooleanToString(SR_PetBuffFood) .. ")");
			SR_PrintSettings("/sr autofeed - (Dis)Allow autofeeding of your pet when eating. (Currently " .. SR_BooleanToString(SR_AutoFeed) .. ")");
		end
		
		SR_PrintSettings("/sr text - Display or don't display the messages in the chatframe. (Currently " .. SR_BooleanToString(SR_Text) .. ")");
		SR_PrintSettings("/sr emotes - Use emotes instead of text. (Visible to nearby players.) Will replace the text messages. (Currently " .. SR_BooleanToString(SR_Emotes) .. ")");
		SR_PrintSettings("/sr cooking - (Dis)Allow the use of food that could be cooked first. (Currently " .. SR_BooleanToString(SR_CookingFood) .. ")");
		SR_PrintSettings("/sr quest - (Dis)Allow the use of food that's used for quests. (Currently " .. SR_BooleanToString(SR_QuestFood) .. ")");
		SR_PrintSettings("/sr buffing - (Dis)Allow the use of food that give bonusses. (Currently " .. SR_BooleanToString(SR_BuffFood) .. ")");
		SR_PrintSettings("/sr forcepotion - (Dis)Allow the use of potions out of combat. (Currently " .. SR_BooleanToString(SR_Force) .. ")");
		SR_PrintSettings("/sr conjuredlast - (Dis)Allow the use of conjured food as last resort. (Currently " .. SR_BooleanToString(SR_Conjured) .. ")");
		SR_PrintSettings("/sr maximumuse or /sr maxuse - (Dis)Allow the use of items based upon the need of the player, or just use the best item available. (Currently " .. SR_BooleanToString(SR_MaxUse) .. ")");
		SR_PrintSettings("/sr antivenombeforebandage - (Dis)Allow the forced use of Anti-Venom before applying a bandage. (Currently " .. SR_BooleanToString(SR_AntiPoisonBeforeBandage) .. ")");
		
		SR_PrintSettings("/sr debug ## - Activates debug mode number ##. (Current active is mode " .. debugMode ..")");
		SR_PrintSettings("/sr status - Prints all saved variables.");
		SR_PrintSettings("/sr default or /sr reset - Resets all saved variables to their default values.");
	end
end
