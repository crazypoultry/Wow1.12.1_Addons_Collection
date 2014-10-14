--------------------------------------------
-- SmartExplosives for WoW
-- By ScepraX
--------------------------------------------
SMARTEXPLOSIVES_VERSION = GetAddOnMetadata("SmartExplosives", "Version");
BINDING_HEADER_SMARTEXPLOSIVES = "SmartExplosives v" .. SMARTEXPLOSIVES_VERSION;

local debugMode = false;

-- Initialization code for this addon
function SmartExplosivesInitialization()
	SlashCmdList["SMARTEXPLOSIVES"] = SmartExplosivesCommand;
	SLASH_SMARTEXPLOSIVES1 = "/se";
	SLASH_SMARTEXPLOSIVES2 = "/SE";
	SLASH_SMARTEXPLOSIVES3 = "/smartexplosives";
	
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("TRADE_SKILL_UPDATE");
	if( DEFAULT_CHAT_FRAME ) then
		SE_PrintSettings("SmartExplosives Mod v" .. SMARTEXPLOSIVES_VERSION .. " loaded!");
	end 
end

--------------------------------------------
-- General functions
--------------------------------------------

-- Event handler. Sets the first aid iLevel and all adjustable settings.
function SE_OnEvent(event)
	if (event == "TRADE_SKILL_UPDATE") then 
		local skillName, skillLevel = GetTradeSkillLine();
		if (string.find(skillName, "Engineering"))then
			if(SE_EngineerSkill ~= skillLevel)then
				SE_PrintDebug("Updating Engineering skilllevel to " .. skillLevel .. "!");	
				SE_EngineerSkill = skillLevel;
			end
		end
   elseif (event == "VARIABLES_LOADED") then
		--if(SE_Version == nil)then
		if(SE_Version == nil or SE_Version ~= SMARTEXPLOSIVES_VERSION)then
			SE_Reset();
		end
		SE_Version = SMARTEXPLOSIVES_VERSION;
	end
end 	

-- Function to reset all variables.
function SE_Reset()
	SE_PrintSettings("Resetting all variables!");
	SE_EngineerSkill = -1;
	SE_Text = true;
	SE_UseDynamite = true;
	SE_UseBombs = true;
	SE_UseCharges = false;
	SE_UseAbnormals = false;
	SE_UseSheep = true;
	SE_UseFlashBomb = false;
	SE_UseLandMine = true;
	SE_UseSapperCharge = true;
	SE_UseArcaneBomb = true;
end 	

-- Function to get the item id from a link.
function SE_GetItemID(link)
	if (link) then
		local _, _, id, name = string.find(link,"|Hitem:(%d+):%d+:%d+:%d+|h%[([^]]+)%]|h|r$");
		if (id and name) then
			return tonumber(id);
		end
	end
end

-- Function to print debug messages.
function SE_PrintDebug(sMessage)
	if(debugMode)then
		DEFAULT_CHAT_FRAME:AddMessage(sMessage, 0, 0.5, 1);
	end
end

-- Function to print default messages.
function SE_PrintDefault(sMessage)
	if(SE_Text)then
		DEFAULT_CHAT_FRAME:AddMessage(sMessage, 1, 1, 0.5);
	end
end

-- Function to print error messages.
function SE_PrintError(sMessage)
	if(SE_Text or debugMode)then
		DEFAULT_CHAT_FRAME:AddMessage(sMessage, 1, 0, 0);
	end
end

-- Prints the settings etc.
function SE_PrintSettings(sMessage)
	DEFAULT_CHAT_FRAME:AddMessage(sMessage, 1, 0.5, 0);
end

-- Print an error sMessage
function SE_PrintNotFound(sMessage)
	SE_PrintError("No " .. sMessage .. " available!");
end

		
-----------------------------------------------------------------------------------------------------------
-- Explosive Section
-----------------------------------------------------------------------------------------------------------

function SE_GetAbnormalLevel(sName)
	local iLevel = -1;
	if (SE_UseSheep and string.find(sName, "Explosive Sheep")) then
		iLevel = 300;
	elseif (SE_UseFlashBomb and string.find(sName, "Flash Bomb")) then
		iLevel = 0;
	elseif (SE_UseLandMine and string.find(sName, "Goblin Land Mine")) then
		iLevel = 195;
	elseif (SE_UseSapperCharge and string.find(sName, "Goblin Sapper Charge")) then
		iLevel = 205;
	elseif (SE_UseArcaneBomb and string.find(sName, "Arcane Bomb")) then
		iLevel = 300;
	end
	return iLevel;
end 	

function SE_GetChargeLevel(sName)
	local iLevel = -1;
	if(string.find(sName, "Charge"))then -- Charge
		if (string.find(sName, "Small Seaforium")) then
			iLevel = 100;
		elseif (string.find(sName, "Large Seaforium")) then
			iLevel = 200;
		elseif (string.find(sName, "Powerful Seaforium")) then
			iLevel = 275;
		end
	end
	return iLevel;
end 	

function SE_GetBombLevel(sName)
	local iLevel = -1;
	if(string.find(sName, "Bomb"))then -- Bombs
		if (string.find(sName, "Rough Copper")) then
			iLevel = 30;
		elseif (string.find(sName, "Large Copper")) then
			iLevel = 105;
		elseif (string.find(sName, "Small Bronze")) then
			iLevel = 120;
		elseif (string.find(sName, "Big Bronze")) then
			iLevel = 140;
		elseif (string.find(sName, "Big Iron")) then
			iLevel = 190;
		elseif (string.find(sName, "Mithril Frag")) then
			iLevel = 205;
		elseif (string.find(sName, "Hi-Explosive")) then
			iLevel = 235;
		elseif (string.find(sName, "Dark Iron")) then
			iLevel = 285;
		end
	else -- Other explosives that can be used as bombs
		if (string.find(sName, "Iron Grenade")) then
			iLevel = 175;
		elseif (string.find(sName, "The Big One")) then
			iLevel = 225;	
		elseif (string.find(sName, "Thorium Grenade")) then
			iLevel = 260;
		end	
	end
	return iLevel;
end 	

function SE_GetDynamiteLevel(sName)
	local iLevel = -1;
	if(string.find(sName, "Dynamite"))then -- Only dynamite
		if (string.find(sName, "Rough")) then
			iLevel = 1;
		elseif (string.find(sName, "Coarse")) then
			iLevel = 75;
		elseif (string.find(sName, "Heavy")) then
			iLevel = 125;
		elseif (string.find(sName, "Solid")) then
			iLevel = 175;
		elseif (string.find(sName, "Dense")) then
			iLevel = 250;
		elseif(string.find(sName, "Ez-Thro"))then
			iLevel = 0;
		end	
	end
	return iLevel;
end 	

--	ExplosiveType
--	0: All explosives. All other classes can be disabled by using commands.
--	1: Dynamite	(Cheapest Explosives)
--	2: Bombs and Grenades (The ones stunning)
--	3: Charges (Lock Openers)
--	4: Sheep and others (Explosive Sheep, Arcane Bomb, Flash Bomb, Goblin Land Mine, Goblin Sapper Charge)

-- Function to use the best available Explosive.
function SE_SmartExplosive(iExplosiveType)
	if(SE_EngineerSkill == -1)then
		SE_PrintError("You don't have a registered Engineering iLevel! (Open your Engineering window once or get the skill from a Engineering trainer.)");
	end	  
	local returnValue = true;
	local sExplosiveType;
	if(iExplosiveType == 1)then -- Dynamite
		sExplosiveType = "dynamite";
	elseif(iExplosiveType == 2)then
		sExplosiveType = "bombs or grenades";
	elseif(iExplosiveType == 3)then
		sExplosiveType = "charges";
	elseif(iExplosiveType == 4)then
		sExplosiveType = "abnormal explosives";
	else
		iExplosiveType = 0;
		sExplosiveType = "explosives";
	end
	
	local bag, slot, name, power = SE_FindExplosive(iExplosiveType);
	
	if (bag == false) then
		SE_PrintNotFound(sExplosiveType);
		returnValue = false;
	else
		local start,duration = GetContainerItemCooldown(bag,slot);
		if (start == 0) then
			local sMessage = "Using: " .. name;
			SE_PrintDefault(sMessage);
			UseContainerItem(bag,slot);
			returnValue = true;
		else
			SE_PrintError("Can't use " .. name .. " for another " .. floor(duration - ( GetTime() - start)) .. " seconds!");
			returnValue = false;
		end
	end
	return returnValue;
end

function SE_FindExplosive(iExplosiveType)
	local finalName = nil;
	local finalSlot = 0;
	local finalBag = 0;
	local finalPower = -1;
	local finalCount = 99;
	for bag=0, NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag), 1 do
			local link = GetContainerItemLink(bag,slot);
			if (link) then
				local ItemID = SE_GetItemID(link); 							
				local sName, iLink, iQuality, iLevel, sClass, sSubClass = GetItemInfo("item:"..ItemID); 		
				if (sName and (string.find(sClass, "Trade Goods") and string.find(sSubClass, "Explosives"))) then
					local sMessage = "Looking at " .. sName .. " (" .. ItemID .. ")";
					local iPower = -1;
					local bBetter = false; -- Is this item better then the previous?
					if(iExplosiveType == 1)then
						iPower = SE_GetDynamiteLevel(sName);
					elseif(iExplosiveType == 2)then
						iPower = SE_GetBombLevel(sName);
					elseif(iExplosiveType == 3)then
						iPower = SE_GetChargeLevel(sName);
					elseif(iExplosiveType == 4)then
						iPower = SE_GetAbnormalLevel(sName);
					else
						if(SE_UseDynamite)then
							iPower = SE_GetDynamiteLevel(sName);
						end
						if(iPower == -1 and SE_UseBombs)then
							iPower = SE_GetBombLevel(sName);
						end
						if(iPower == -1 and SE_UseAbnormals)then
							iPower = SE_GetAbnormalLevel(sName);
						end
						if(iPower == -1 and SE_UseCharges)then
							iPower = SE_GetChargeLevel(sName);
						end
					end
					
					if(iPower >= 0)then -- If in fact an explosive
						if (SE_EngineerSkill >= iPower and UnitLevel("player") >= iLevel and iPower >= finalPower) then
							bBetter = true;
						elseif(iPower == 0 and UnitLevel("player") >= iLevel)then
							iPower = (iLevel * 5);
							if(iPower >= finalPower)then
								bBetter = true;
							end
						end
						sMessage = sMessage ..  " with power " .. iPower;
					end
					
					local texture, count;					
					if(bBetter)then -- Check if item could replace the previous item.
						texture, count = GetContainerItemInfo(bag,slot); -- Count amount
						if(iPower == finalPower)then -- If same power as last
							bBetter = count < finalCount; -- Check if this new stack is in fact lower.
						end
						sMessage = sMessage ..  " in a stack of " .. count;
					end
					
					if(bBetter)then -- If really better
						finalPower = iPower;
						finalBag = bag;
						finalSlot = slot;
						finalName = sName;
						finalCount = count;
					end
					SE_PrintDebug(sMessage);
				end 				
			end
		end
	end
	if (finalName == nil) then
		return false, false, nil, 0, 0;
	else
		SE_PrintDebug("Found " .. finalName .. " with " .. finalPower .. " power in a stack of " .. finalCount);
		return finalBag, finalSlot, finalName, finalPower, finalCount;
	end
end 


-----------------------------------------------------------------------------------------------------------
-- Commands Section
-----------------------------------------------------------------------------------------------------------
function SE_SplitArgs(line)
   local args = {};
   for arg in string.gfind(line, "[^%s]+") do
	  table.insert(args, arg);
   end
   return args;
end

function SmartExplosivesCommand(msg)
   local args = SE_SplitArgs(string.lower(msg));
   local cmd = args[1];	
	if( cmd == "smartexplosive" or cmd == "boom" or cmd == "smart") then
		SE_SmartExplosive(0);
	elseif(cmd == "dyna" or cmd == "dynamite")then
		SE_SmartExplosive(1);
	elseif(cmd == "bomb" or cmd == "grenade")then
		SE_SmartExplosive(2);
	elseif(cmd == "charge")then
		SE_SmartExplosive(3);
	elseif(cmd == "abnormal" or cmd == "other" or cmd == "sheep" or cmd == "landmine")then
		SE_SmartExplosive(4);
	elseif(cmd == "default" or cmd == "reset")then
		SE_Reset();
	elseif(cmd == "usedynamite")then
		if(SE_UseDynamite) then
			SE_UseDynamite = false;
			SE_PrintSettings("Not using dynamite!");
		else
			SE_UseDynamite = true;
			SE_PrintSettings("Using dynamite!");
		end
	elseif(cmd == "usebombs" or cmd == "usegrenades")then
		if(SE_UseBombs) then
			SE_UseBombs = false;
			SE_PrintSettings("Not using bombs and grenades!");
		else
			SE_UseBombs = true;
			SE_PrintSettings("Using bombs and grenades!");
		end
	elseif(cmd == "usecharges")then
		if(SE_UseCharges) then
			SE_UseCharges = false;
			SE_PrintSettings("Not using charges!");
		else
			SE_UseCharges = true;
			SE_PrintSettings("Using charges!");
		end
	elseif(cmd == "useabnormal" or cmd == "useother")then
		if(SE_UseAbnormals) then
			SE_UseAbnormals = false;
			SE_PrintSettings("Not using abnormal explosives!");
		else
			SE_UseAbnormals = true;
			SE_PrintSettings("Using abnormal explosives!");
		end
	elseif(cmd == "usesheeps")then
		if(SE_UseSheep) then
			SE_UseSheep = false;
			SE_PrintSettings("Not using exploding sheeps!");
		else
			SE_UseSheep = true;
			SE_PrintSettings("Using exploding sheeps!");
		end	
	elseif(cmd == "useflashbombs")then
		if(SE_UseFlashBomb) then
			SE_UseFlashBomb = false;
			SE_PrintSettings("Not using flash bombs!");
		else
			SE_UseFlashBomb = true;
			SE_PrintSettings("Using flash bombs!");	
		end
	elseif(cmd == "uselandmines")then
		if(SE_UseLandMine) then
			SE_UseLandMine = false;
			SE_PrintSettings("Not using land mines!");
		else
			SE_UseLandMine = true;
			SE_PrintSettings("Using land mines!");	
		end
	elseif(cmd == "usesappercharges")then
		if(SE_UseSapperCharge) then
			SE_UseSapperCharge = false;
			SE_PrintSettings("Not using sapper charges!");
		else
			SE_UseSapperCharge = true;
			SE_PrintSettings("Using sapper charges!");		
		end
	elseif(cmd == "usearcanebombs")then
		if(SE_UseArcaneBomb) then
			SE_UseArcaneBomb = false;
			SE_PrintSettings("Not using arcane bombs!");
		else
			SE_UseArcaneBomb = true;
			SE_PrintSettings("Using arcane bombs!");		
		end
	elseif(cmd == "text")then
		if(SE_Text) then
			SE_Text = false;
			SE_PrintSettings("Text is off!");
		else
			SE_Text = true;
			SE_PrintSettings("Text is on!");
		end
	 elseif (cmd == "debug")then
		if(not debugMode) then
			debugMode = true;
			SE_PrintSettings("Debugging is on!");
		else
			debugMode = false;
			SE_PrintSettings("Debugging is off!");
		end
	elseif (cmd == "status")then
		SE_PrintSettings("SmartExplosives " .. SMARTEXPLOSIVES_VERSION);
		SE_PrintSettings("Engineering skill: " .. SE_EngineerSkill);		
		if(SE_Text)then
			SE_PrintSettings("Text is activated.");
		else
			SE_PrintSettings("Text is deactivated.");
		end
		if(SE_UseDynamite)then
			SE_PrintSettings("Using dynamite.");
		else
			SE_PrintSettings("Not using dynamite.");
		end
		if(SE_UseBombs)then
			SE_PrintSettings("Using bombs and grenades.");
		else
			SE_PrintSettings("Not using bombs and grenades.");
		end
		if(SE_UseCharges)then
			SE_PrintSettings("Using charges.");
		else
			SE_PrintSettings("Not using charges.");
		end
		if(SE_UseAbnormals)then
			SE_PrintSettings("Using abnormal explosives.");
		else
			SE_PrintSettings("Not using abnormal explosives.");
		end
		if(not SE_UseSheep) then
			SE_PrintSettings("Not using exploding sheeps!");
		else
			SE_PrintSettings("Using exploding sheeps!");	
		end
		if(not SE_UseFlashBomb) then
			SE_PrintSettings("Not using flash bombs!");
		else
			SE_PrintSettings("Using flash bombs!");	
		end
		if(not SE_UseLandMine) then
			SE_PrintSettings("Not using land mines!");
		else
			SE_PrintSettings("Using land mines!");	
		end
		if(not SE_UseSapperCharge) then
			SE_PrintSettings("Not using sapper charges!");
		else
			SE_PrintSettings("Using sapper charges!");		
		end
		if(not SE_UseArcaneBomb) then
			SE_PrintSettings("Not using arcane bombs!");
		else
			SE_PrintSettings("Using arcane bombs!");	
		end
	else	
		SE_PrintSettings("SmartExplosives " .. SMARTEXPLOSIVES_VERSION);
		SE_PrintSettings("/se or /smartexplosives - Displays this list with commands.");
		SE_PrintSettings("/se smartexplosives or /se smart or /se boom - Will select the best explosive out of a selection (settable with commands beneath).");		
		SE_PrintSettings("/se dyna or /se dynamite - Will select the best dynamite.");
		SE_PrintSettings("/se bomb or /se grenade - Will select the best bomb or grenade (Not arcane bombs).");
		SE_PrintSettings("/se charge - Will select the best charge.");
		SE_PrintSettings("/se abnormal or /se other or /se sheep or /se landmine - Will select the best abnormal explosive and will in some cases instantly use it. For more information about this category see the readme.");
		
		SE_PrintSettings("/se usedynamite - When enabled allows the smart function to select dynamite. When disabled the smart function will never select dynamite. (Default is on.)");
		SE_PrintSettings("/se usebombs or /se usegrenades - Same as above but now for bombs and grenades. (Default is on.)");
		SE_PrintSettings("/se usecharges - Once again the same as above, but now for charges. (Default is off.)");
		SE_PrintSettings("/se useabnormal or /se useother - Same as above but now for the remaining explosives. (Default is off.)");
		
		SE_PrintSettings("/se usesheeps - Self-explanatory (Default is on.)");
		SE_PrintSettings("/se useflashbombs - Self-explanatory (Default is off.)");
		SE_PrintSettings("/se uselandmines - Self-explanatory (Default is on.)");
		SE_PrintSettings("/se usesappercharges - Self-explanatory (Default is on.)");
		SE_PrintSettings("/se usearcanebombs - Self-explanatory (Default is on.)");
		
		SE_PrintSettings("/se text - Display or don't display the messages in the chatframe. (Default is on.)");
		SE_PrintSettings("/se debug - (De)Activates debug mode. (Default is off.)");
		SE_PrintSettings("/se status - Prints all saved variables.");
		SE_PrintSettings("/se default or /se reset - Resets all saved variables to their default values.");
	end
end
