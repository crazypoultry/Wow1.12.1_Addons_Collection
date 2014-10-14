--[[
Enigma WoW Addons
Base library 1.0.1

http://luodan.com/wow/addons
2005.10.21.

]]

function EN_Base_Init()
	if EN_Base and EN_Base > "1.0.1" then
		return;
	end;
	EN_Base = "1.0.1";
	
	-- Consts
	EN_PLAYERLEVEL_MAX = 60;

	-- Realm Name
	EN_RealmName = GetCVar("realmName");
	if not EN_RealmName then
		EN_RealmName = "Enigma";
	end;

	-- Player Name
	EN_PlayerName = UnitName("player");
	if not EN_PlayerName then
		EN_PlayerName = "Unknown";
	end;
	
	EN_PlayerId = EN_RealmName .. "." .. EN_PlayerName;
	
	--Slash	
	SLASH_ENIGMA1 = "/ea";
	SLASH_ENIGMA2 = "/enigma";
	SlashCmdList["ENIGMA"] = function(msg)
		EN_SlashCommandHandler(msg);
	end;

	EN_SlashCommandHandler = function(msg)
		DEFAULT_CHAT_FRAME:AddMessage("HERE");
	end;
	
	EN_Msg = function(Msg1, Msg2)
		local msg = "";
		if Msg2 then
			msg = Msg2;
		end;
		if Msg1 then
			if msg == "" then
				msg = "|cffff9900" .. Msg1 .. "|r"
			else
				msg = "|cffff9900[" .. Msg1 .. "]|r " .. msg;
			end;
		end;
		DEFAULT_CHAT_FRAME:AddMessage(msg);
	end;
	
	EN_Debug = function(AddonId, var, value)
		DEFAULT_CHAT_FRAME:AddMessage("[|cffffcc00" .. AddonId .. "_DEBUG|r]" .. var .. "=" .. value);
	end;
	
	err = function()
		DEFAULT_CHAT_FRAME:AddMessage(ScriptErrors_Message:GetText());
	end;
	
	showmsg = function(msg)
		DEFAULT_CHAT_FRAME:AddMessage(msg);
	end;
	
	EN_RegisterAddon = function(AddonId, name, version)
		if not EN_Addons then
			EN_Addons = {};
		end;
		if AddonId then
			EN_Addons[AddonId] = {};
			EN_Addons[AddonId]["NAME"] = name;
			EN_Addons[AddonId]["VERSION"] = version;
		end;
	end;
	
	EN_Copyrights = function(addonId)
		local index, value;
		local tempstring = "";
		if (addonId) then
			DEFAULT_CHAT_FRAME:AddMessage(EN_Addons[addonId]["NAME"] .. " " .. EN_Addons[addonId]["VERSION"] .. " loaded.");
		else
			if EN_CopyrightsDisplayed ~= 1 then
				for index, value in EN_Addons do
					if value then
						if value["NAME"] then
							tempstring = tempstring .. string.gsub(value["NAME"], "Enigma ", "");
						end;
						if value["VERSION"] then
							tempstring =tempstring .. " " .. value["VERSION"];
						end;
						tempstring = tempstring .. ", ";
					end;
				end;
				if tempstring ~= "" then
					tempstring = "|cffffcc00Enigma Addons: |r" .. string.sub(tempstring, 1, string.len(tempstring) - 2) .. " loaded. |cffffcc00http://luodan.com/wow/addons|r";
				end;
			end;
			DEFAULT_CHAT_FRAME:AddMessage(tempstring, 1, 1, 1);
			EN_CopyrightsDisplayed = 1;
		end;
	end;

	-- function
	EN_GetPercentString = function(value, valueMax)
		local percent = 0;
		if (value and valueMax) then
			percent =  tonumber(value) * 100 / tonumber(valueMax);
		end;
		percent = math.floor(percent);
		return percent;
	end;		
	
	EN_GetPercentColor = function(value, valueMax)
		local r = 0;
		local g = 1;
		local b = 0;
		if (value and valueMax) then
			local valuePercent =  tonumber(value) / tonumber(valueMax);
			if (valuePercent >= 0 and valuePercent <= 1) then
				if (valuePercent > 0.5) then
					r = (1.0 - valuePercent) * 2;
					g = 1.0;
				else
					r = 1.0;
					g = valuePercent * 2;
				end;
			end;
		end;
		if r < 0 then
			r = 0;
		end;
		if g < 0 then
			g = 0;
		end;
		if b < 0 then
			b = 0;
		end;
		if r > 1 then
			r = 1;
		end;
		if g > 1 then
			g = 1;
		end;
		if b > 1 then
			b = 1;
		end;	
		return r, g, b;
	end;

	EN_GetUnitInfoString = function(unit, withLevel, withLevelTag, withRace, withClass, withElite)
		local tempstring = "";
		local isElite = 0;
		if (withLevel == 1) then
			local level= UnitLevel(unit);	
			if ( not (level and level >= 1)) then
				level = "??";
			end
			if (withLevelTag == 1) then
				level = string.format(EN_TEXT_LEVELTAG, level);
			end
			tempstring = tempstring .. level .. " ";
		end
		
		if (withElite == 1) then
			if (UnitClassification(unit) and UnitClassification(unit) ~= "normal" and UnitHealth(unit) > 0) then
				isElite = 1;
				if (UnitClassification(unit) == "elite") then
					tempstring = tempstring .. EN_TEXT_ELITE .. " ";
				elseif (UnitClassification(unit) == "worldboss") then
					tempstring = tempstring .. "|cffffffff" .. EN_TEXT_WORLDBOSS .. "|r ";
				elseif (UnitClassification(unit) == "rare") then
					tempstring = tempstring .. "|cffffffff" .. EN_TEXT_RARE .. "|r ";
				elseif (UnitClassification(unit) == "rareelite") then
					tempstring = tempstring .. "|cffffffff" .. EN_TEXT_RAREELITE .. "|r ";
				end
			end
		end
	
		if (withRace == 1 and isElite == 0) then
			if (UnitRace(unit) and UnitIsPlayer(unit)) then
				tempstring = tempstring .. UnitRace(unit) .. " ";
			elseif (UnitPlayerControlled(unit)) then
				if (UnitCreatureFamily(unit)) then
					tempstring = tempstring .. UnitCreatureFamily(unit) .. " ";
				end
			else
				if (UnitCreatureType(unit)) then
					tempstring = tempstring .. UnitCreatureType(unit) .. " ";
				end
			end
		end
	
		if (withClass == 1) then
			if (UnitClass(unit)) then
				tempstring = tempstring .. UnitClass(unit);
			end
		end
	
		return tempstring;
	end
	
	EN_GetUnitTargetInfo = function(unit)
		local unitTarget = unit .. "target";
		local targetName = "";
		local targetIsFriend; --, targetCanAttack, targetCanAttackMe;
		if (UnitExists(unitTarget)) then 
			targetName = UnitName(unitTarget);
	      		targetIsFriend = UnitIsFriend(unitTarget, "player");
			--targetCanAttack = UnitCanAttack("player", unitTarget);
			--targetCanAttackMe = UnitCanAttack(unitTarget, "player");
	
		end;
		return targetName, targetIsFriend; --, targetCanAttack, targetCanAttackMe;
	end
end

EN_Base_Init();



