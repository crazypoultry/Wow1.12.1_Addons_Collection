--[[
	WarriorAlert 0.9.2 by BAW
	
	Check out readme.txt for more info
]]

WarriorAlert_ConfigDefault = {
	["Overpower"] = {
		["Message"] = true,
		["Sound"] = true,
		[1] = true,
		[2] = true,
		[3] = true
	},
	["MortalStrike"] = {
		["Message"] = true,
		["Sound"] = true,
		[1] = true,
		[2] = true,
		[3] = true
	},
	["Execute"] = {
		["Message"] = true,
		["Sound"] = true,
		[1] = true,
		[2] = true,
		[3] = true
	},
	["Revenge"] = {
		["Message"] = true,
		["Sound"] = true,
		[1] = false,
		[2] = true,
		[3] = false
	},
	["Bloodthirst"] = {
		["Message"] = true,
		["Sound"] = true,
		[1] = true,
		[2] = true,
		[3] = true
	}
};

WarriorAlert_SpellPos = { 
		[WARRIORALERT_EXECUTE_SPELLNAME] = {
			["pos"] = 0,
			["inCooldown"] = 0,
			["sekCooldown"] = 0,
			["startTime"] = 0,
			["tab"] = 2,
			["messageShown"] = 0,
			["slot"] = 0,
			["canCast"] = 0
		},
		[WARRIORALERT_MORTALSTRIKE_SPELLNAME] = {
			["pos"] = 0,
			["inCooldown"] = 0,
			["sekCooldown"] = 0,
			["startTime"] = 0,
			["tab"] = 4,
			["messageShown"] = 0,
			["slot"] = 0,
			["canCast"] = 0
		},
		[WARRIORALERT_BLOODTHIRST_SPELLNAME] = {
			["pos"] = 0,
			["inCooldown"] = 0,
			["sekCooldown"] = 0,
			["startTime"] = 0,
			["tab"] = 2,
			["messageShown"] = 0,
			["slot"] = 0,
			["canCast"] = 0
		},
		[WARRIORALERT_OVERPOWER_SPELLNAME] = {
			["pos"] = 0,
			["inCooldown"] = 0,
			["sekCooldown"] = 0,
			["startTime"] = 0,
			["tab"] = 4,
			["messageShown"] = 0,
			["slot"] = 0,
			["canCast"] = 0
		},
		[WARRIORALERT_REVENGE_SPELLNAME] = {
			["pos"] = 0,
			["inCooldown"] = 0,
			["sekCooldown"] = 0,
			["startTime"] = 0,
			["tab"] = 3,
			["messageShown"] = 0,
			["slot"] = 0,
			["canCast"] = 0
		}
	};

WarriorAlert_timeSinceLastUpdate = 0;
WarriorAlert_LookupDone = 0;

WarriorAlert_spellName = {	WARRIORALERT_EXECUTE_SPELLNAME,
	WARRIORALERT_OVERPOWER_SPELLNAME,
	WARRIORALERT_MORTALSTRIKE_SPELLNAME,
	WARRIORALERT_REVENGE_SPELLNAME,
	WARRIORALERT_BLOODTHIRST_SPELLNAME
};



function WarriorAlert_Instant()
	for s=1, 5 do
		if(WarriorAlert_SpellPos[ WarriorAlert_spellName[s] ]["pos"] > 0 and WarriorAlert_SpellPos[ WarriorAlert_spellName[s] ]["inCooldown"] == 0) then
			local start, duration, flag = GetSpellCooldown(WarriorAlert_SpellPos[ WarriorAlert_spellName[s] ]["pos"], WarriorAlert_SpellPos[ WarriorAlert_spellName[s] ]["tab"]);
		
			if(WarriorAlert_SpellPos[ WarriorAlert_spellName[s] ]["sekCooldown"] == duration and start > 0) then
				WarriorAlert_SpellPos[ WarriorAlert_spellName[s] ]["startTime"] = start;
				WarriorAlert_SpellPos[ WarriorAlert_spellName[s] ]["inCooldown"] = 1;
				WarriorAlert_SpellPos[ WarriorAlert_spellName[s] ]["canCast"] = 0;
				WarriorAlert_SpellPos[ WarriorAlert_spellName[s] ]["messageShown"] = 0;
			end
		end
	end
end

--------------------------------------------------------------------------------
-- Misc functions --------------------------------------------------------------
--------------------------------------------------------------------------------
function WarriorAlert_Init()
	local i;
	local _, class = UnitClass("player");
	
	if(class == "WARRIOR") then
		WarriorAlert:RegisterEvent("VARIABLES_LOADED");
		WarriorAlert:RegisterEvent("UNIT_HEALTH");
		WarriorAlert:RegisterEvent("UNIT_RAGE");
		WarriorAlert:RegisterEvent("PLAYER_TARGET_CHANGED");
		WarriorAlert:RegisterEvent("CHAT_MSG_COMBAT_SELF_MISSES");
		WarriorAlert:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES");
		WarriorAlert:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN");
		WarriorAlert:RegisterEvent("SPELL_UPDATE_COOLDOWN");
		WarriorAlert:RegisterEvent("ADDON_LOADED");
		WarriorAlert:RegisterEvent("ACTIONBAR_SLOT_CHANGED");
		WarriorAlert:RegisterEvent("PLAYER_REGEN_DISABLED");
		WarriorAlert:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
	
		SLASH_WARRIORALERT1 = "/warrioralert";
		SLASH_WARRIORALERT2 = "/walert"; -- A shortcut or alias
		SlashCmdList["WARRIORALERT"] = WarriorAlert_Command;
	
		for i=1, 120 do
			WarriorAlert_GetSlots(i);
		end
	end
	
	WarriorAlert_Command("lock");
	WarriorAlert_Loaded();
	
	if(class == "WARRIOR") then
		DEFAULT_CHAT_FRAME:AddMessage(WARRIORALERT_WELCOME);
	else
		DEFAULT_CHAT_FRAME:AddMessage(WARRIORALERT_WELCOME_NO_WARRIOR);
	end
end



function WarriorAlert_Command(cmd)
	if(cmd == "") then
		WarriorAlert_ConfigFrame:Show();
	end
	
	if(cmd == "unlock") then
		WarriorAlert_MessageFrame:RegisterForDrag("LeftButton");
		WarriorAlert_MessageFrame:EnableMouse(true);
		WarriorAlert_MessageFrame:SetBackdrop({bgFile = "Interface/DialogFrame/UI-DialogBox-Background", 
                                            edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
                                            tile = true, tileSize = 32, edgeSize = 32, 
                                            insets = { left = 8, right = 8, top = 8, bottom = 8 }});
	end
	
	if(cmd == "lock") then
		WarriorAlert_MessageFrame:RegisterForDrag();
		WarriorAlert_MessageFrame:SetBackdrop(nil);
		WarriorAlert_MessageFrame:EnableMouse(false);
	end
end


function WarriorAlert_GetSlots(slot)
	WarriorAlert_Tooltip:SetOwner(WarriorAlert_Tooltip, "ANCHOR_NONE");
	WarriorAlert_Tooltip:SetAction(slot);
	local n = WarriorAlert_TooltipTextLeft1:GetText();
	local j = WarriorAlert_TooltipTextRight3:GetText();
	
	for s in WarriorAlert_spellName do
		if(n == WarriorAlert_spellName[s]) then
			WarriorAlert_SpellPos[ WarriorAlert_spellName[s] ]["slot"] = slot;
			WarriorAlert_SpellPos[ WarriorAlert_spellName[s] ]["sekCooldown"] = string.gfind(j, "%d")() + 0;

			if(WarriorAlert_SpellPos[ WarriorAlert_spellName[s] ]["sekCooldown"] < 1.5) then
				WarriorAlert_SpellPos[ WarriorAlert_spellName[s] ]["sekCooldown"] = 1.5;
			end

			WarriorAlert_CheckSpells();
		end
	end
end



function WarriorAlert_CurrentStance()
	for x=1, GetNumShapeshiftForms() do
		_, _, active = GetShapeshiftFormInfo(x);
		
		if(active == 1) then
			return x;
		end
	end
	
	return 0;
end



function WarriorAlert_CheckCooldowns(elapsed)
	local updateInterval = 0.25;
	
	WarriorAlert_timeSinceLastUpdate = WarriorAlert_timeSinceLastUpdate + elapsed; 	
	
	if (WarriorAlert_timeSinceLastUpdate > updateInterval) then
		WarriorAlert_timeSinceLastUpdate = 0;
		
		for s=1, 5 do
			if(WarriorAlert_SpellPos[ WarriorAlert_spellName[s] ]["inCooldown"] == 1) then
				if((WarriorAlert_SpellPos[ WarriorAlert_spellName[s] ]["sekCooldown"] - (GetTime() - WarriorAlert_SpellPos[ WarriorAlert_spellName[s] ]["startTime"])) <= 0) then
					WarriorAlert_SpellPos[ WarriorAlert_spellName[s] ]["inCooldown"] = 0;
					WarriorAlert_SpellPos[ WarriorAlert_spellName[s] ]["messageShown"] = 0;
				end
			end
		end
		
		WarriorAlert_MortalStrike();
		WarriorAlert_Execute();
		WarriorAlert_Revenge("");
		WarriorAlert_Overpower("");
	end
end



function WarriorAlert_Loaded()
	local i;
	
	if(WarriorAlert_Config == nil) then
		WarriorAlert_Config = WarriorAlert_ConfigDefault;
	end
	
	if(WarriorAlert_Config["Overpower"] == nil) then
		WarriorAlert_Config["Overpower"] = {
			["Message"] = true,
			["Sound"] = true,
			[1] = true,
			[2] = true,
			[3] = true
		};
	end

	if(WarriorAlert_Config["MortalStrike"] == nil) then
		WarriorAlert_Config["MortalStrike"] = {
			["Message"] = true,
			["Sound"] = true,
			[1] = true,
			[2] = true,
			[3] = true
		};
	end

	if(WarriorAlert_Config["Execute"] == nil) then
		WarriorAlert_Config["Execute"] = {
			["Message"] = true,
			["Sound"] = true,
			[1] = true,
			[2] = true,
			[3] = true
		};
	end
	
	if(WarriorAlert_Config["Revenge"] == nil) then
		WarriorAlert_Config["Revenge"] = {
			["Message"] = true,
			["Sound"] = true,
			[1] = false,
			[2] = true,
			[3] = false
		};
	end

	if(WarriorAlert_Config["Bloodthirst"] == nil) then
		WarriorAlert_Config["Bloodthirst"] = {
			["Message"] = true,
			["Sound"] = true,
			[1] = true,
			[2] = true,
			[3] = true
		};
	end
	
	WarriorAlert_CBShowMessage1:SetChecked(WarriorAlert_Config["Overpower"]["Message"]);
	WarriorAlert_CBPlaySound1:SetChecked(WarriorAlert_Config["Overpower"]["Sound"]);
	WarriorAlert_CBBattleStance1:SetChecked(WarriorAlert_Config["Overpower"][1]);
	WarriorAlert_CBDefensiveStance1:SetChecked(WarriorAlert_Config["Overpower"][2]);
	WarriorAlert_CBBerserkerStance1:SetChecked(WarriorAlert_Config["Overpower"][3]);
	
	WarriorAlert_CBShowMessage2:SetChecked(WarriorAlert_Config["MortalStrike"]["Message"]);
	WarriorAlert_CBPlaySound2:SetChecked(WarriorAlert_Config["MortalStrike"]["Sound"]);
	WarriorAlert_CBBattleStance2:SetChecked(WarriorAlert_Config["MortalStrike"][1]);
	WarriorAlert_CBDefensiveStance2:SetChecked(WarriorAlert_Config["MortalStrike"][2]);
	WarriorAlert_CBBerserkerStance2:SetChecked(WarriorAlert_Config["MortalStrike"][3]);

	WarriorAlert_CBShowMessage3:SetChecked(WarriorAlert_Config["Execute"]["Message"]);
	WarriorAlert_CBPlaySound3:SetChecked(WarriorAlert_Config["Execute"]["Sound"]);
	WarriorAlert_CBBattleStance3:SetChecked(WarriorAlert_Config["Execute"][1]);
	WarriorAlert_CBDefensiveStance3:SetChecked(WarriorAlert_Config["Execute"][2]);
	WarriorAlert_CBBerserkerStance3:SetChecked(WarriorAlert_Config["Execute"][3]);

	WarriorAlert_CBShowMessage4:SetChecked(WarriorAlert_Config["Revenge"]["Message"]);
	WarriorAlert_CBPlaySound4:SetChecked(WarriorAlert_Config["Revenge"]["Sound"]);
	WarriorAlert_CBBattleStance4:SetChecked(WarriorAlert_Config["Revenge"][1]);
	WarriorAlert_CBDefensiveStance4:SetChecked(WarriorAlert_Config["Revenge"][2]);
	WarriorAlert_CBBerserkerStance4:SetChecked(WarriorAlert_Config["Revenge"][3]);
	
	WarriorAlert_CBShowMessage5:SetChecked(WarriorAlert_Config["Bloodthirst"]["Message"]);
	WarriorAlert_CBPlaySound5:SetChecked(WarriorAlert_Config["Bloodthirst"]["Sound"]);
	WarriorAlert_CBBattleStance5:SetChecked(WarriorAlert_Config["Bloodthirst"][1]);
	WarriorAlert_CBDefensiveStance5:SetChecked(WarriorAlert_Config["Bloodthirst"][2]);
	WarriorAlert_CBBerserkerStance5:SetChecked(WarriorAlert_Config["Bloodthirst"][3]);
end



function WarriorAlert_TargetChanged(unit)
	for s=1, 5 do
		WarriorAlert_SpellPos[ WarriorAlert_spellName[s] ]["messageShown"] = 0;
		WarriorAlert_SpellPos[ WarriorAlert_spellName[s] ]["canCast"] = 0;
	end

	WarriorAlert_Execute();
end



function WarriorAlert_CheckSpells()
	local pos = 1;
	local spellCount = 0;

	for x=1, GetNumSpellTabs() do
		_, _, _, numSpells = GetSpellTabInfo(x);
		spellCount = spellCount + numSpells
	end

	for x=1, spellCount do
		for s=1, 5 do
			if(string.find(GetSpellName(x, BOOKTYPE_SPELL), WarriorAlert_spellName[s])) then
				WarriorAlert_SpellPos[ WarriorAlert_spellName[s] ]["pos"] = x;
			end
		end
	end
end



function WarriorAlert_LookupActions()
	if(WarriorAlert_LookupDone == 1) then
		return;
	end
	
	WarriorAlert_LookupDone = 1;
	
	DEFAULT_CHAT_FRAME:AddMessage(WARRIORALERT_LOOKUP_ACTIONS);
	
	for i=1, 120 do
		WarriorAlert_GetSlots(i);
	end
end



--------------------------------------------------------------------------------
-- Config functions ------------------------------------------------------------
--------------------------------------------------------------------------------
function WarriorAlert_CheckboxClick(arg1, arg2)
	if(this:GetChecked() ~= nil) then
		WarriorAlert_Config[arg1][arg2] = true;
	else
		WarriorAlert_Config[arg1][arg2] = false;
	end
end



--------------------------------------------------------------------------------
-- Execute functions -----------------------------------------------------------
--------------------------------------------------------------------------------
function WarriorAlert_Execute()
	if(WarriorAlert_Config["Execute"][ WarriorAlert_CurrentStance() ] == false) then
		return;
	end
	
	if(WarriorAlert_SpellPos[ WARRIORALERT_EXECUTE_SPELLNAME ]["pos"] == 0 or
		WarriorAlert_SpellPos[ WARRIORALERT_EXECUTE_SPELLNAME ]["inCooldown"] == 1 or
		WarriorAlert_SpellPos[ WARRIORALERT_EXECUTE_SPELLNAME ]["messageShown"] == 1 or
		IsActionInRange(WarriorAlert_SpellPos[ WARRIORALERT_EXECUTE_SPELLNAME ]["slot"]) ~= 1 or
		UnitCanAttack("player", "target") == false) then
		return;
	end

	if(UnitHealth("target") > 0 and UnitHealth("target") < 20 and UnitMana("player") >= 15) then
		WarriorAlert_SpellPos[ WARRIORALERT_EXECUTE_SPELLNAME ]["messageShown"] = 1;
		
		if(WarriorAlert_Config["Execute"]["Message"] == true) then
			WarriorAlert_MessageFrame:AddMessage(WARRIORALERT_EXECUTE, 1.0, 1.0, 1.0, 1.0, 1);
		end

		if(WarriorAlert_Config["Execute"]["Sound"] == true) then
			PlaySound("igQuestLogAbandonQuest");
		end
	end
end



--------------------------------------------------------------------------------
-- Mortal Strike functions -----------------------------------------------------
--------------------------------------------------------------------------------
function WarriorAlert_MortalStrike()
	if(WarriorAlert_Config["MortalStrike"][ WarriorAlert_CurrentStance() ] == false) then
		return;
	end

	if(UnitMana("player") < 30 and WarriorAlert_SpellPos[ WARRIORALERT_MORTALSTRIKE_SPELLNAME ]["inCooldown"] == 0) then
		WarriorAlert_SpellPos[ WARRIORALERT_MORTALSTRIKE_SPELLNAME ]["messageShown"] = 0;
	end
	
	if(WarriorAlert_SpellPos[ WARRIORALERT_MORTALSTRIKE_SPELLNAME ]["pos"] == 0 or
		WarriorAlert_SpellPos[ WARRIORALERT_MORTALSTRIKE_SPELLNAME ]["inCooldown"] == 1 or
		WarriorAlert_SpellPos[ WARRIORALERT_MORTALSTRIKE_SPELLNAME ]["messageShown"] == 1 or
		IsActionInRange(WarriorAlert_SpellPos[ WARRIORALERT_MORTALSTRIKE_SPELLNAME ]["slot"]) ~= 1 or
		UnitCanAttack("player", "target") == false) then
		return;
	end
	
	if(UnitHealth("target") > 0 and UnitMana("player") >= 30) then
		WarriorAlert_SpellPos[ WARRIORALERT_MORTALSTRIKE_SPELLNAME ]["messageShown"] = 1;
		
		if(WarriorAlert_Config["MortalStrike"]["Message"] == true) then
			WarriorAlert_MessageFrame:AddMessage(WARRIORALERT_MORTALSTRIKE, 1.0, 1.0, 1.0, 1.0, 1);
		end

		if(WarriorAlert_Config["MortalStrike"]["Sound"] == true) then
			PlaySound("igQuestLogAbandonQuest");
		end
	end

end



--------------------------------------------------------------------------------
-- Bloodthirst functions -------------------------------------------------------
--------------------------------------------------------------------------------
function WarriorAlert_Bloodthirst()
	if(WarriorAlert_Config["Bloodthirst"][ WarriorAlert_CurrentStance() ] == false) then
		return;
	end
	
	if(WarriorAlert_SpellPos[ WARRIORALERT_BLOODTHIRST_SPELLNAME ]["pos"] == 0 or
		WarriorAlert_SpellPos[ WARRIORALERT_BLOODTHIRST_SPELLNAME ]["inCooldown"] == 1 or
		WarriorAlert_SpellPos[ WARRIORALERT_BLOODTHIRST_SPELLNAME ]["messageShown"] == 1 or
		IsActionInRange(WarriorAlert_SpellPos[ WARRIORALERT_BLOODTHIRST_SPELLNAME ]["slot"]) ~= 1 or
		UnitCanAttack("player", "target") == false) then
		return;
	end
	
	if(UnitHealth("target") > 0 and UnitMana("player") >= 30) then
		WarriorAlert_SpellPos[ WARRIORALERT_BLOODTHIRST_SPELLNAME ]["messageShown"] = 1;
		
		if(WarriorAlert_Config["Bloodthirst"]["Message"] == true) then
			WarriorAlert_MessageFrame:AddMessage(WARRIORALERT_BLOODTHIRST, 1.0, 1.0, 1.0, 1.0, 0.1);
		end
		
		if(WarriorAlert_Config["Bloodthirst"]["Sound"] == true) then
			PlaySound("igQuestLogAbandonQuest");
		end
	end
end



--------------------------------------------------------------------------------
-- Overpower functions ---------------------------------------------------------
--------------------------------------------------------------------------------
function WarriorAlert_Overpower(msg)
	if(WarriorAlert_Config["Overpower"][ WarriorAlert_CurrentStance() ] == false) then
		return;
	end
	
	for s in WARRIORALERT_OVERPOWER_MSG do
		if(string.find(msg, WARRIORALERT_OVERPOWER_MSG[s])) then
			WarriorAlert_SpellPos[ WARRIORALERT_OVERPOWER_SPELLNAME ]["canCast"] = 1;
		end
	end
	
	if(WarriorAlert_SpellPos[ WARRIORALERT_OVERPOWER_SPELLNAME ]["pos"] == 0 or
		WarriorAlert_SpellPos[ WARRIORALERT_OVERPOWER_SPELLNAME ]["inCooldown"] == 1 or
		WarriorAlert_SpellPos[ WARRIORALERT_OVERPOWER_SPELLNAME ]["messageShown"] == 1 or
		IsActionInRange(WarriorAlert_SpellPos[ WARRIORALERT_OVERPOWER_SPELLNAME ]["slot"]) ~= 1) then
		return;
	end

	
--[[	for s in WARRIORALERT_OVERPOWER_MSG do
		if(string.find(msg, WARRIORALERT_OVERPOWER_MSG[s])) then
			WarriorAlert_SpellPos[ WARRIORALERT_OVERPOWER_SPELLNAME ]["messageShown"] = 1;
		
			if(WarriorAlert_Config["Overpower"]["Message"] == true) then
				WarriorAlert_MessageFrame:AddMessage(WARRIORALERT_OVERPOWER, 1.0, 1.0, 1.0, 1.0, 1);
			end
		
			if(WarriorAlert_Config["Overpower"]["Sound"] == true) then
				PlaySound("igQuestLogAbandonQuest");
			end
		end
	end ]]
	
	if(UnitMana("player") >= 5 and WarriorAlert_SpellPos[ WARRIORALERT_OVERPOWER_SPELLNAME ]["canCast"] == 1) then
		WarriorAlert_SpellPos[ WARRIORALERT_OVERPOWER_SPELLNAME ]["messageShown"] = 1;
		
		if(WarriorAlert_Config["Overpower"]["Message"] == true) then
			WarriorAlert_MessageFrame:AddMessage(WARRIORALERT_OVERPOWER, 1.0, 1.0, 1.0, 1.0, 1);
		end

		if(WarriorAlert_Config["Overpower"]["Sound"] == true) then
			PlaySound("igQuestLogAbandonQuest");
		end
	end
end



--------------------------------------------------------------------------------
-- Revenge functions -----------------------------------------------------------
--------------------------------------------------------------------------------
function WarriorAlert_Revenge(msg)
	if(WarriorAlert_Config["Revenge"][ WarriorAlert_CurrentStance() ] == false) then
		return;
	end
	
	for s in WARRIORALERT_REVENGE_MSG do
		if(string.find(msg, WARRIORALERT_REVENGE_MSG[s])) then
			WarriorAlert_SpellPos[ WARRIORALERT_REVENGE_SPELLNAME ]["canCast"] = 1;
		end
	end
	
	if(WarriorAlert_SpellPos[ WARRIORALERT_REVENGE_SPELLNAME ]["pos"] == 0 or
		WarriorAlert_SpellPos[ WARRIORALERT_REVENGE_SPELLNAME ]["messageShown"] == 1 or
		WarriorAlert_SpellPos[ WARRIORALERT_REVENGE_SPELLNAME ]["inCooldown"] == 1 or
		IsActionInRange(WarriorAlert_SpellPos[ WARRIORALERT_REVENGE_SPELLNAME ]["slot"]) ~= 1 or
		UnitCanAttack("player", "target") == false) then
		return;
	end

	if(UnitHealth("target") > 0 and UnitMana("player") >= 5 and WarriorAlert_SpellPos[ WARRIORALERT_REVENGE_SPELLNAME ]["canCast"] == 1) then
		WarriorAlert_SpellPos[ WARRIORALERT_REVENGE_SPELLNAME ]["messageShown"] = 1;
		
		if(WarriorAlert_Config["Revenge"]["Message"] == true) then
			WarriorAlert_MessageFrame:AddMessage(WARRIORALERT_REVENGE, 1.0, 1.0, 1.0, 1.0, 1);
		end

		if(WarriorAlert_Config["Revenge"]["Sound"] == true) then
			PlaySound("igQuestLogAbandonQuest");
		end
	end
end