RAIDHEALER_NUM_INFOBARS = 10;
RAIDHEALER_MAX_HEALINFOS = 5;
RAIDHEALER_MAX_MANAINFOS = 5;

RAIDHEALER_INNERVATE_BUFF = "Spell_Nature_Lightning";

RaidHealer_PlayerAssignment = {
	["HEAL"] = {},
	["BUFF"] = {}
}

RaidHealer_LowestPriest = nil;

-- vars for event registering
RaidHealer_EnteredRaid = nil;
RaidHealer_LeavedRaid = true;

function RaidHealer_InfoFrame_OnLoad()
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("RAID_ROSTER_UPDATE");
	this:RegisterEvent("CHAT_MSG_ADDON");
	
	getglobal(this:GetName().."_Title_TitleText"):SetText(RAIDHEALER_NAME.." ("..RAIDHEALER_VERSION..")");
end

function RaidHealer_InfoFrame_OnEvent()
	if (event == "ADDON_LOADED" and arg1=="RaidHealer") then
		--
	elseif (event == "PLAYER_ENTERING_WORLD") then
		-- show info frame
		RaidHealer_ShowInfoFrame();
		
		-- request initial assignents
		if ( UnitInRaid("player") ) then
			-- register raid events
			RaidHealer_RegisterRaidEvents();
			
			if ( RaidHealer_CharacterConfig["LAST_ANNOUNCER_HEAL"] == nil or RaidHealer_CharacterConfig["LAST_ANNOUNCER_HEAL"] ~= "") then
				if (RaidHealer_PlayerInRaid(RaidHealer_CharacterConfig["LAST_ANNOUNCER_HEAL"])) then
					RaidHealer_SendAddonMessage("RQ HEAL "..RaidHealer_CharacterConfig["LAST_ANNOUNCER_HEAL"]);
				end
			end
		end
	elseif (event == "RAID_ROSTER_UPDATE" or event == "UNIT_HEALTH" or event == "UNIT_MAXHEALTH" or event == "UNIT_MANA" or event == "UNIT_MAXMANA") then
		if (UnitInRaid("player")) then
			-- register raid events
			RaidHealer_RegisterRaidEvents();
			-- show Info Frame on entering raid
			RaidHealer_ShowInfoFrame();
			
			-- cath health changes
			if ( event == "UNIT_HEALTH" or event == "UNIT_MAXHEALTH" ) then
			
				RaidHealer_PurgePlayerAssignments("HEAL");
				if (type(RaidHealer_PlayerAssignment["HEAL"]) == "table") then
					for i=1, RAIDHEALER_MAX_HEALINFOS, 1 do
						if ( i <= table.getn(RaidHealer_PlayerAssignment["HEAL"]) ) then
							local rosterID = RaidHealer_GetRaidRosterIDByName(RaidHealer_PlayerAssignment["HEAL"][i]);
							if (rosterID) then
								if (event == "RAID_ROSTER_UPDATE" or "raid"..rosterID == arg1) then
									RaidHealer_RefreshStatusBar(i, rosterID);
								end
							end
						end
					end
				end
			-- catch mana changes
			elseif ( event == "UNIT_MANA" or event == "UNIT_MAXMANA" ) then

				if ( RaidHealer_User.class == RAIDHEALER_CLASS_DRUID and arg1) then
					RaidHealer_SetManaInfoBars();
				end
			end
		else
			-- No Lowest Priest
			RaidHealer_LowestPriest = nil;
			-- diable all bars if not in raid
			RaidHealer_DisableAllStatusBars();
			-- hide info frame
			RaidHealer_InfoFrame:Hide();
			-- unregister events
			RaidHealer_UnregisterRaidEvents();
		end
	elseif ( event == "CHAT_MSG_ADDON" and arg1 == "RAIDHEALER" and arg3 == "RAID" ) then

		local msg = arg2;
		local name = arg4;
		
		if ( msg == "RESETHEAL" ) then
			RaidHealer_PlayerAssignment["HEAL"] = {};
			RaidHealer_DisableAllStatusBars();
		elseif ( strsub(msg, 1, 5) == "HEAL " ) then
			local _, _, healer, healTargets = string.find(msg, "^HEAL (.+) (.+)$");

			if (healer == UnitName("player")) then
				RaidHealer_DisableAllStatusBars();
				
				if ( string.find(healTargets, ",") ) then
					RaidHealer_PlayerAssignment["HEAL"] = RaidHealer_Split(healTargets, ",");
				else
					if (type(healTargets) == "string" and string.len(healTargets) > 0) then
						RaidHealer_PlayerAssignment["HEAL"] = { healTargets };
					end
				end
				RaidHealer_SetHealInfoTargets("HEAL");
				RaidHealer_CharacterConfig["LAST_ANNOUNCER_HEAL"] = name;
			end
		elseif ( strsub(msg, 1, 3) == "RQ " ) then
			local _, _, aType, aName = string.find(msg, "^RQ (.+) (.+)$");
			-- if player is the announce 
			if ( aName == UnitName("player") ) then
				if (RaidHealer_Assignments[aType]) then
					for healer, targets in pairs(RaidHealer_Assignments[aType]) do
						if (healer == name) then
							RaidHealer_SendAddonMessage("HEAL "..healer.." "..table.concat(targets, ","));
						end
					end
				end
			end
		end
	end
end

function RaidHealer_PurgePlayerAssignments(hType)
	if (type(RaidHealer_PlayerAssignment[hType]) == "table") then
		local newPlayerAssignments = {};
		for i=1, table.getn(RaidHealer_PlayerAssignment[hType]), 1 do
			if ( RaidHealer_PlayerInRaid(RaidHealer_PlayerAssignment[hType][i]) ) then
				table.insert(newPlayerAssignments, RaidHealer_PlayerAssignment[hType][i]);
			end
		end
		RaidHealer_PlayerAssignment[hType] = newPlayerAssignments;
	end
end

function RaidHealer_InfoFrame_OnUpdate()
	-- RH_Debug("OnUpdate");
end

function RaidHealer_SetHealInfoTargets(hType)
	if (type(RaidHealer_PlayerAssignment[hType]) == "table") then
		for i=1, table.getn(RaidHealer_PlayerAssignment[hType]), 1 do
			RaidHealer_DrawStatusBar(i, RaidHealer_GetRaidRosterIDByName(RaidHealer_PlayerAssignment[hType][i]));
		end
	end
end

function RaidHealer_SetManaInfoBars()
	local barID = table.getn(RaidHealer_PlayerAssignment["HEAL"]) + 1;
	
	RaidHealer_LowestPriest = RaidHealer_GetLowestPriest();
	
	if (not RaidHealer_LowestPriest) then
		RaidHealer_DisableStatusBar(barID);
		return;
	end
	
	local rosterID = tonumber(string.sub(RaidHealer_LowestPriest, 5));
	local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(rosterID);
	
	if ( fileName == RAIDHEALER_CLASS_PRIEST ) then
		local manaCur = UnitMana(RaidHealer_LowestPriest);
		local manaMax = UnitManaMax(RaidHealer_LowestPriest);
		
		if ( manaCur / manaMax < RaidHealer_GetGC("INNERVATE_ALERT_VALUE") and not RaidHealer_PlayerHasBuff(RaidHealer_LowestPriest, RAIDHEALER_INNERVATE_BUFF)) then
			RaidHealer_DrawManaStatusBar(barID, rosterID);
		else
			RaidHealer_DisableStatusBar(barID);
		end
	end
end

function RaidHealer_GetLowestPriest()
	local lowestUnit = 0;
	local lowestMana = 1;
	
	if ( UnitInRaid("player") ) then
		local nrm = GetNumRaidMembers();
		if (nrm > 0) then
			for n = 1, nrm, 1 do
				local _,_,_,_,_, fileName,_, online, isDead = GetRaidRosterInfo(n);
				if ( fileName == RAIDHEALER_CLASS_PRIEST and online and not isDead and not UnitIsGhost("raid"..n) ) then
					local mana = UnitMana("raid"..n)/UnitManaMax("raid"..n);
					if (mana < lowestMana and not RaidHealer_PlayerHasBuff("raid"..n, RAIDHEALER_INNERVATE_BUFF)) then
						lowestUnit = n;
					end
				end
			end
		end
	end
	
	if ( lowestUnit ~= 0 ) then
		return "raid"..lowestUnit;
	end
	
	return nil;
end

function RaidHealer_HealTargetStatusBar_OnClick()
	local mouseButton = arg1;
	local uName = RaidHealer_PlayerAssignment["HEAL"][tonumber(this:GetID())];
	local uID = nil;
	
	if ( UnitInRaid("player") ) then
		uID = RaidHealer_GetUnitIDByName(uName);
	else
		if ( UnitName("player") == uName ) then
			uID = "player";
		end
	end

	if ( uID ~= nil ) then
		if (SpellIsTargeting()) then
			SpellTargetUnit(uID)
		else
			TargetUnit(uID);
		end
	else
		-- set uID to lowest Priest
		uID = RaidHealer_LowestPriest;
		if (uID) then
			if ( mouseButton == "LeftButton" ) then
				if (SpellIsTargeting()) then
					SpellTargetUnit(uID)
				else
					TargetUnit(uID);
				end
			elseif ( mouseButton == "RightButton" ) then
				RaidHealer_CastInnervate(uID);
			end
		end
	end
end

function RaidHealer_DrawStatusBar(id, rosterID)
	-- check for max info bars
	if (tonumber(id) > RAIDHEALER_MAX_HEALINFOS or not rosterID) then
		return;
	end
	
	local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(rosterID);
	local uID = "raid"..rosterID;
	
	local barName = "RaidHealer_InfoFrame_Target"..id;
	
	local min = 0;
	local max = UnitHealthMax(uID);
	local val = UnitHealth(uID);
	local player = UnitName(uID);
	local _, class = UnitClass(uID);
	
	getglobal(barName.."_PlayerName"):SetText("|cffffcc00"..name);
	RaidHealer_SetClassIcon(getglobal(barName.."_Icon"), fileName);
	-- refresh status bar
	RaidHealer_RefreshStatusBar(id, rosterID);
	getglobal(barName):Show();
end

function RaidHealer_RefreshStatusBar(id, rosterID)
	-- check for max info bars
	if (tonumber(id) > RAIDHEALER_MAX_HEALINFOS or not rosterID) then
		return;
	end
	
	local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(rosterID);
	local uID = "raid"..rosterID;
	
	local barName = "RaidHealer_InfoFrame_Target"..id;
	
	if (not online) then
		RaidHealer_OfflineDeadStatusBar(id, "OFFLINE");
		return;
	end
	if (isDead or UnitIsGhost(uID)) then
		RaidHealer_OfflineDeadStatusBar(id, "DEAD");
		return;
	end

	local min = 0;
	local max = UnitHealthMax(uID);
	local val = UnitHealth(uID);
	
	getglobal(barName.."_StatusBar"):SetMinMaxValues(min, max);
	getglobal(barName.."_StatusBar"):SetValue(val);
	getglobal(barName.."_StatusBar"):SetStatusBarColor((1-(val/max)), (val/max), 0);
	getglobal(barName.."_Text"):SetText("|cffffffaaHP: |cffffcc00"..val.."/"..max);
end

function RaidHealer_OfflineDeadStatusBar(id, text)
	local barName = "RaidHealer_InfoFrame_Target"..id;
	
	getglobal(barName.."_StatusBar"):SetMinMaxValues(0, 1);
	getglobal(barName.."_StatusBar"):SetValue(0);
	getglobal(barName.."_StatusBar"):SetStatusBarColor(0, 0, 0);
	getglobal(barName.."_Text"):SetText("|cffffffaa"..text);
end

function RaidHealer_DisableStatusBar(id)
	local barName = "RaidHealer_InfoFrame_Target"..id;
	
	getglobal(barName.."_StatusBar"):SetMinMaxValues(0, 1);
	getglobal(barName.."_StatusBar"):SetValue(0);
	getglobal(barName.."_StatusBar"):SetStatusBarColor(0, 0, 0);
	getglobal(barName.."_Text"):SetText("");
	getglobal(barName):Hide();
end

function RaidHealer_DisableAllStatusBars()
	for i=1, RAIDHEALER_NUM_INFOBARS, 1 do
		RaidHealer_DisableStatusBar(i);
	end
end

function RaidHealer_DrawManaStatusBar(id, rosterID)
	-- check for max info bars
	if (not id or not rosterID) then
		return;
	end
	
	local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(rosterID);
	local uID = "raid"..rosterID;
	
	local barName = "RaidHealer_InfoFrame_Target"..id;
	
	local min = 0;
	local max = UnitManaMax(uID);
	local val = UnitMana(uID);
	local player = UnitName(uID);
	local _, class = UnitClass(uID);
	
	getglobal(barName.."_PlayerName"):SetText("|cffffcc00"..name);
	RaidHealer_SetClassIcon(getglobal(barName.."_Icon"), fileName);
	-- refresh status bar
	RaidHealer_RefreshManaStatusBar(id, rosterID);
	getglobal(barName):Show();
end

function RaidHealer_RefreshManaStatusBar(id, rosterID)
	-- check for max info bars
	if (not id or not rosterID) then
		return;
	end
	
	local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(rosterID);
	local uID = "raid"..rosterID;
	
	local barName = "RaidHealer_InfoFrame_Target"..id;
	
	if (not online) then
		RaidHealer_OfflineDeadStatusBar(id, "OFFLINE");
		return;
	end
	if (isDead or UnitIsGhost(uID)) then
		RaidHealer_OfflineDeadStatusBar(id, "DEAD");
		return;
	end

	local min = 0;
	local max = UnitManaMax(uID);
	local val = UnitMana(uID);
	
	getglobal(barName.."_StatusBar"):SetMinMaxValues(min, max);
	getglobal(barName.."_StatusBar"):SetValue(val);
	getglobal(barName.."_StatusBar"):SetStatusBarColor(0, 0, 1);
	getglobal(barName.."_Text"):SetText("|cffffffaaMana: |cffffcc00"..val.."/"..max);
end

function RaidHealer_ShowInfoFrame()
	if ( UnitInRaid("player") and RaidHealer_GetCC("SHOW_INFOFRAME") ) then
		RaidHealer_InfoFrame:Show();
	end
end

function RaidHealer_ToggleInfoFrame()
	if (RaidHealer_InfoFrame:IsShown()) then
		RaidHealer_InfoFrame:Hide();
		RaidHealer_SetCC("SHOW_INFOFRAME", nil);
		RaidHealer_PrintLines(RAIDHEALER_SHOW_INFOFRAME_NOTE);
	else
		if (UnitInRaid("player")) then
			RaidHealer_InfoFrame:Show();
			RaidHealer_SetCC("SHOW_INFOFRAME", true);
		else
			RaidHealer_PrintLines(RAIDHEALER_ONLYINRAID_INFO);
		end
	end
end

function RaidHealer_ToggleInfoFrameLock()
	if (RaidHealer_InfoFrame.isLocked) then
		--
	end
end

function RaidHealer_CastInnervate(uID)
	-- check for enough mana to innervate
	if (RaidHealer_User.innervateId and not RaidHealer_SpellHasCooldown(RaidHealer_User.innervateId) ) then
		if UnitMana("player") >=62 then
			if (not RaidHealer_PlayerHasBuff(uID, RAIDHEALER_INNERVATE_BUFF)) then
				if (SpellIsTargeting()) then
					SpellStopCasting();
				end
				
				local oldTarget = UnitName("playerTarget");
				
				-- clear target to avoid innervating the wrong
				ClearTarget();
				-- cast spell
				CastSpellByName("Innervate");
				-- check for proper target
				if ( SpellCanTargetUnit(uID) ) then
					SpellTargetUnit(uID);
					-- check if cooldown
					if ( RaidHealer_SpellHasCooldown(RaidHealer_User.innervateId) ) then
						local msg = string.format(RAIDHEALER_INNERVATE_ANNOUNCES[math.random(1, table.getn(RAIDHEALER_INNERVATE_ANNOUNCES))], UnitName(uID));
						if ( RaidHealer_GetGC("INNERVATE_ANNOUNCE_RAID") ) then
							RaidHealer_SendToChannel("RAID", msg);
						end
						if ( RaidHealer_GetGC("INNERVATE_ANNOUNCE_SAY") ) then
							RaidHealer_SendToChannel("SAY", msg);
						end
					end
				else
					SpellStopTargeting();
				end	
				-- target the last target if there was one
				if (oldTarget) then
					TargetLastTarget();
				end
			else
				RaidHealer_PrintLines(RAIDHEALER_PLAYER_HAS_INNERVATE_ALREADY);
			end
		else
			RaidHealer_PrintLines(RAIDHEALER_NOT_ENOUGH_MANA);
		end
	end
end

function RaidHealer_RegisterRaidEvents()
	if (not RaidHealer_EnteredRaid) then
		RaidHealer_InfoFrame:RegisterEvent("UNIT_HEALTH");
		RaidHealer_InfoFrame:RegisterEvent("UNIT_MAXHEALTH");
		
		if (RaidHealer_User.class == RAIDHEALER_CLASS_DRUID) then
			RaidHealer_InfoFrame:RegisterEvent("UNIT_MANA");
			RaidHealer_InfoFrame:RegisterEvent("UNIT_MAXMANA");
		end
		
		RaidHealer_EnteredRaid = true;
		RaidHealer_LeavedRaid = nil;
	end
end

function RaidHealer_UnregisterRaidEvents()
	if (not RaidHealer_LeavedRaid) then
		RaidHealer_InfoFrame:UnregisterEvent("UNIT_HEALTH");
		RaidHealer_InfoFrame:UnregisterEvent("UNIT_MAXHEALTH");
		
		if (RaidHealer_User.class == RAIDHEALER_CLASS_DRUID) then
			RaidHealer_InfoFrame:UnregisterEvent("UNIT_MANA");
			RaidHealer_InfoFrame:UnregisterEvent("UNIT_MAXMANA");
		end
		
		RaidHealer_EnteredRaid = nil;
		RaidHealer_LeavedRaid = true;
	end
end