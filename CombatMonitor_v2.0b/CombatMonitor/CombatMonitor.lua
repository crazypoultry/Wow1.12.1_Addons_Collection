--
-- CombatMonitor
-- World of Warcraft UI AddOn to track defensive combat statistics
-- 2005-2006 Satrina@Stormrage
--

local parser = ParserLib:GetInstance("1.1");
local CMaddonID = "CombatMonitor";

CMON_version = 11200.01;
CMON_updateVersion = 11000.99;

-- Saved variables
CMVar = {};
--
CMON_player = nil;
CMON_debug = nil;
CMON_debugDestination = ChatFrame2;
CMON_OldUIOptionsFrame_Save = nil

function CombatMonitor_OnLoad()
	SlashCmdList["COMBATMONITOR"] = CombatMonitor_SlashCommandHandler;
	SLASH_COMBATMONITOR1 = "/combatmonitor";

	CombatMonitorSummaryFrame:RegisterEvent("ADDON_LOADED");
	CombatMonitorSummaryFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
	CombatMonitorSummaryFrame:RegisterEvent("PLAYER_LEAVING_WORLD");
	CombatMonitorSummaryFrame:RegisterForDrag("LeftButton");
end


function CombatMonitor_RegisterEvents(register)
	if register then

		parser:RegisterEvent(CMaddonID, "CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES",	CM_Combat_OnEvent);
		parser:RegisterEvent(CMaddonID, "CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS",	CM_Combat_OnEvent);
--		parser:RegisterEvent(CMaddonID, "CHAT_MSG_COMBAT_HOSTILE_PLAYER_MISSES",	CM_Combat_OnEvent);
--		parser:RegisterEvent(CMaddonID, "CHAT_MSG_COMBAT_HOSTILE_PLAYER_HITS",		CM_Combat_OnEvent);
		parser:RegisterEvent(CMaddonID, "CHAT_MSG_COMBAT_SELF_HITS",			CM_Combat_OnEvent);
		parser:RegisterEvent(CMaddonID, "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE",		CM_Combat_OnEvent);
		parser:RegisterEvent(CMaddonID, "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS",		CM_Combat_OnEvent);
		parser:RegisterEvent(CMaddonID, "CHAT_MSG_SPELL_AURA_GONE_SELF",		CM_Combat_OnEvent);
--		parser:RegisterEvent(CMaddonID, "CHAT_MSG_SPELL_PERIODIC_HOSTILE_PLAYER_DAMAGE",CM_Combat_OnEvent);
		parser:RegisterEvent(CMaddonID, "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE",	CM_Combat_OnEvent);
		parser:RegisterEvent(CMaddonID, "CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS",		CM_Combat_OnEvent);
		parser:RegisterEvent(CMaddonID, "CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES",		CM_Combat_OnEvent);
		parser:RegisterEvent(CMaddonID, "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE",		CM_Combat_OnEvent);
		parser:RegisterEvent(CMaddonID, "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE",	CM_Combat_OnEvent);

--		parser:RegisterEvent(CMaddonID, "CMON_player_LEAVE_COMBAT",			CM_Combat_OnEvent);
--		parser:RegisterEvent(CMaddonID, "UNIT_COMBAT",					CM_Combat_OnEvent);
--		parser:RegisterEvent(CMaddonID, "PLAYER_REGEN_DISABLED",			CM_Combat_OnEvent);
--		parser:RegisterEvent(CMaddonID, "PLAYER_REGEN_ENABLED",				CM_Combat_OnEvent);
--		parser:RegisterEvent(CMaddonID, "PLAYER_TARGET_CHANGED",			CM_Combat_OnEvent);


--		CombatMonitorSummaryFrame:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES");
--		CombatMonitorSummaryFrame:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS");
--		CombatMonitorSummaryFrame:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_PLAYER_MISSES");
--		CombatMonitorSummaryFrame:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_PLAYER_HITS");
--		CombatMonitorSummaryFrame:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS");
--		CombatMonitorSummaryFrame:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
--		CombatMonitorSummaryFrame:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
--		CombatMonitorSummaryFrame:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
--		CombatMonitorSummaryFrame:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILE_PLAYER_DAMAGE");
--		CombatMonitorSummaryFrame:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS");
--		CombatMonitorSummaryFrame:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES");
--		CombatMonitorSummaryFrame:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE");
--		CombatMonitorSummaryFrame:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");

		CombatMonitorSummaryFrame:RegisterEvent("CMON_player_LEAVE_COMBAT");
		CombatMonitorSummaryFrame:RegisterEvent("UNIT_COMBAT");
		CombatMonitorSummaryFrame:RegisterEvent("PLAYER_REGEN_DISABLED");
		CombatMonitorSummaryFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
		CombatMonitorSummaryFrame:RegisterEvent("PLAYER_TARGET_CHANGED");
	else
		parser:UnregisterAllEvents(CMaddonID);

--		CombatMonitorSummaryFrame:UnregisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES");
--		CombatMonitorSummaryFrame:UnregisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS");
--		CombatMonitorSummaryFrame:UnregisterEvent("CHAT_MSG_COMBAT_HOSTILE_PLAYER_MISSES");
--		CombatMonitorSummaryFrame:UnregisterEvent("CHAT_MSG_COMBAT_HOSTILE_PLAYER_HITS");
--		CombatMonitorSummaryFrame:UnregisterEvent("CHAT_MSG_COMBAT_SELF_HITS");
--		CombatMonitorSummaryFrame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
--		CombatMonitorSummaryFrame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
--		CombatMonitorSummaryFrame:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
--		CombatMonitorSummaryFrame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILE_PLAYER_DAMAGE");
--		CombatMonitorSummaryFrame:UnregisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS");
--		CombatMonitorSummaryFrame:UnregisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES");
--		CombatMonitorSummaryFrame:UnregisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE");
--		CombatMonitorSummaryFrame:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");

		CombatMonitorSummaryFrame:UnregisterEvent("CMON_player_LEAVE_COMBAT");
		CombatMonitorSummaryFrame:UnregisterEvent("UNIT_COMBAT");
		CombatMonitorSummaryFrame:UnregisterEvent("PLAYER_REGEN_DISABLED");
		CombatMonitorSummaryFrame:UnregisterEvent("PLAYER_REGEN_ENABLED");
		CombatMonitorSummaryFrame:UnregisterEvent("PLAYER_TARGET_CHANGED");
	end
end

function CombatMonitor_SlashCommandHandler(msg)
	if (string.lower(msg) == CMON_ON) then
		CMVar[CMON_player].enabled  = 1;
		CombatMonitor_Initialise();
		DEFAULT_CHAT_FRAME:AddMessage(CMON_ENABLED);
	elseif (string.lower(msg) == CMON_OFF) then
		CMVar[CMON_player].enabled  = nil;
		CombatMonitor_RegisterEvents(CMVar[CMON_player].enabled);
		CombatMonitorDetailsFrame:Hide();
		CombatMonitorOptionsFrame:Hide();
		CombatMonitorOpponentListFrame:Hide();
		DEFAULT_CHAT_FRAME:AddMessage(CMON_DISABLED);
	elseif (string.lower(msg) == CMON_RESET) then
		CombatMonitor_ClearAll();
		DEFAULT_CHAT_FRAME:AddMessage(CMON_RESET);
	elseif (string.lower(msg) == CMON_CENTER) then
		CombatMonitorSummaryFrame:ClearAllPoints();
		CombatMonitorSummaryFrame:SetPoint("CENTER", "UIParent", "CENTER");
	elseif (string.lower(msg) == CMON_VER) then
		DEFAULT_CHAT_FRAME:AddMessage(string.format("%s %.2f|r", CMON_VERSION, CMON_version));
	else
		DEFAULT_CHAT_FRAME:AddMessage(CMON_USAGE);
	end
	CombatMonitor_UpdateSummary();
end

function CombatMonitor_OnClick(button)
	if not CMVar[CMON_player].enabled then
		CombatMonitor_Options();
	else
		if CombatMonitorDetailsFrame:IsVisible() then
			CombatMonitorDetailsFrame:Hide();
			CombatMonitorOptionsFrame:Hide();
			CombatMonitorCopyFrame:Hide();
			CombatMonitorOpponentListFrame:Hide();
		else
			CombatMonitor_UpdateDetails();
			CombatMonitorDetailsFrame:Show();
		end
	end
end

----------------------------
-- Utility
----------------------------
function CombatMonitor_DamageTypeFromNumber(damageType)
	if (damageType == 1) then
		return TYPE_HOLY;
	elseif (damageType == 2) then
		return TYPE_FIRE;
	elseif (damageType == 3) then
		return TYPE_NATURE;
	elseif (damageType == 4) then
		return TYPE_FROST;
	elseif (damageType == 5) then
		return TYPE_SHADOW;
	elseif (damageType == 6) then
		return TYPE_ARCANE;
	else
		return TYPE_PHYSICAL;
	end
end

function CombatMonitor_DamageTypeFromString(damageType)
	if (string.lower(damageType) == SEARCH_TYPE_SHORT_FIRE) then
		return TYPE_FIRE;
	elseif (string.lower(damageType) == SEARCH_TYPE_SHORT_FROST) then
		return TYPE_FROST;
	elseif (string.lower(damageType) == SEARCH_TYPE_SHORT_NATURE) then
		return TYPE_NATURE;
	elseif (string.lower(damageType) == SEARCH_TYPE_SHORT_HOLY) then
		return TYPE_HOLY;
	elseif (string.lower(damageType) == SEARCH_TYPE_SHORT_SHADOW) then
		return TYPE_SHADOW;
	elseif (string.lower(damageType) == SEARCH_TYPE_SHORT_ARCANE) then
		return TYPE_ARCANE;
	else
		return TYPE_PHYSICAL;
	end
end

function CM_Round(x)
	return math.floor(x+0.5);
end

function CM_Percent(stat1, stat2)
	local x = 0;
	if (stat2 > 0) then
		x = 100 * stat1 / stat2;
	end
	return(string.format("%2.2f%%", x));
end

----------------------------
-- Display
----------------------------
function CombatMonitor_Average(numerator, denominator)
	if (denominator == 0) then
		denominator = 1;
	end
	return floor(numerator/denominator);
end

function CombatMonitor_UpdateSummary()
	if CombatMonitor_Enabled() then
		CombatMonitorSummaryText:SetText(CMON_TOTALDAMAGELABEL.." "..CMVar[CMON_player].defenseStats[CMVar[CMON_player].currentIndex].meleeTotalDamage);
	else
		CombatMonitorSummaryText:SetText(CMON_DISABLED);	
	end
end

function CombatMonitor_UpdateDetails()
	local str, hits
	local id = CMVar[CMON_player].currentIndex;
	
	if (id == 1) then
		CombatMonitor_CalculateAllOpponents()
		CombatMonitor_UpdateSummary()
	end
	
	CombatMonitorSelectOpponentButton:SetText(CMVar[CMON_player].defenseStats[id].name);
	
	hits = CMVar[CMON_player].defenseStats[id].meleeAttacks - CMVar[CMON_player].defenseStats[id].meleeMisses - CMVar[CMON_player].defenseStats[id].meleeDodges - CMVar[CMON_player].defenseStats[id].meleeParries;

	str = string.format("|cff00ff00%d|r", CMVar[CMON_player].defenseStats[id].meleeAttacks)
	CombatMonitorMeleeTotalAttacksValue:SetText(str);
	str = string.format("|cff00ff00%d|r  (%s)", CMVar[CMON_player].defenseStats[id].meleeMisses, CM_Percent(CMVar[CMON_player].defenseStats[id].meleeMisses, CMVar[CMON_player].defenseStats[id].meleeAttacks));
	CombatMonitorMeleeTotalMissesValue:SetText(str);
	str = string.format("|cff00ff00%d|r  (%s)", CMVar[CMON_player].defenseStats[id].meleeDodges, CM_Percent(CMVar[CMON_player].defenseStats[id].meleeDodges, CMVar[CMON_player].defenseStats[id].meleeAttacks));
	CombatMonitorMeleeTotalDodgesValue:SetText(str);
	str = string.format("|cff00ff00%d|r  (%s)", CMVar[CMON_player].defenseStats[id].meleeParries, CM_Percent(CMVar[CMON_player].defenseStats[id].meleeParries, CMVar[CMON_player].defenseStats[id].meleeAttacks));
	CombatMonitorMeleeTotalParriesValue:SetText(str);

	str = string.format("|cff00ff00%d|r  (|cffffff00%s|r)", 
CMVar[CMON_player].defenseStats[id].meleeFullBlocks, CM_Percent(CMVar[CMON_player].defenseStats[id].meleeFullBlocks, CMVar[CMON_player].defenseStats[id].meleeAttacks));
	CombatMonitorMeleeFullBlocksValue:SetText(str);
	str = string.format("%d  (|cffffff00%s|r) (|cffffff00%s|r)", CMVar[CMON_player].defenseStats[id].meleeBlocks, CM_Percent(CMVar[CMON_player].defenseStats[id].meleeBlocks, CMVar[CMON_player].defenseStats[id].meleeAttacks), CM_Percent(CMVar[CMON_player].defenseStats[id].meleeBlocks + CMVar[CMON_player].defenseStats[id].meleeFullBlocks, CMVar[CMON_player].defenseStats[id].meleeAttacks));
	CombatMonitorMeleePartialBlocksValue:SetText(str);

	str = string.format("%d  (%s)", CMVar[CMON_player].defenseStats[id].meleeCriticals, CM_Percent(CMVar[CMON_player].defenseStats[id].meleeCriticals, CMVar[CMON_player].defenseStats[id].meleeAttacks));
	CombatMonitorMeleeTotalCritsValue:SetText(str);
	str = string.format("%d  (%s)", CMVar[CMON_player].defenseStats[id].meleeCrushing, CM_Percent(CMVar[CMON_player].defenseStats[id].meleeCrushing, CMVar[CMON_player].defenseStats[id].meleeAttacks));
	CombatMonitorMeleeTotalCrushValue:SetText(str);

	for i=TYPE_PHYSICAL,TYPE_SHADOW do
		total = getglobal("CombatMonitorMelee"..i.."Taken");
		if CMVar[CMON_player].showPercent and (i ~= TYPE_PHYSICAL) then
			str = CM_Percent(CMVar[CMON_player].defenseStats[id].meleeDamage[i], CMVar[CMON_player].defenseStats[id].meleeDamage[i]+CMVar[CMON_player].defenseStats[id].resistedMelee[i]);
		else
			str = CMVar[CMON_player].defenseStats[id].meleeDamage[i];
		end
		total:SetText(str);

		hits = getglobal("CombatMonitorMelee"..i.."Hits");
		str = ""
		if (i == TYPE_PHYSICAL) then
			str = "|cff00ff00"
		end
		str = str..CMVar[CMON_player].defenseStats[id].meleeHits[i]
		if (i == TYPE_PHYSICAL) then
			str = str.."|r"
		end
		hits:SetText(str);

		average = getglobal("CombatMonitorMelee"..i.."Average");
		avg = CombatMonitor_Average(CMVar[CMON_player].defenseStats[id].meleeDamage[i], CMVar[CMON_player].defenseStats[id].meleeHits[i]);
		average:SetText(avg);

		if (i ~= TYPE_PHYSICAL) then
			resisted = getglobal("CombatMonitorMelee"..i.."Resisted");
			if CMVar[CMON_player].showPercent then
				str = CM_Percent(CMVar[CMON_player].defenseStats[id].resistedMelee[i], CMVar[CMON_player].defenseStats[id].meleeDamage[i]+CMVar[CMON_player].defenseStats[id].resistedMelee[i]);
			else
				str = CMVar[CMON_player].defenseStats[id].resistedMelee[i];
			end
			resisted:SetText(str);
		end
	end

	hits = CMVar[CMON_player].defenseStats[id].spellAttacks - CMVar[CMON_player].defenseStats[id].spellMisses - CMVar[CMON_player].defenseStats[id].spellDodges - CMVar[CMON_player].defenseStats[id].spellParries;

	str = string.format("|cffff0000%d|r", CMVar[CMON_player].defenseStats[id].spellAttacks)
	CombatMonitorSpellTotalAttacksValue:SetText(str);
	str = string.format("|cffff0000%d|r  (%s)", CMVar[CMON_player].defenseStats[id].spellMisses, CM_Percent(CMVar[CMON_player].defenseStats[id].spellMisses, CMVar[CMON_player].defenseStats[id].spellAttacks));
	CombatMonitorSpellTotalMissesValue:SetText(str);
	str = string.format("|cffff0000%d|r  (%s)", CMVar[CMON_player].defenseStats[id].spellDodges, CM_Percent(CMVar[CMON_player].defenseStats[id].spellDodges, CMVar[CMON_player].defenseStats[id].spellAttacks));
	CombatMonitorSpellTotalDodgesValue:SetText(str);
	str = string.format("|cffff0000%d|r  (%s)", CMVar[CMON_player].defenseStats[id].spellParries, CM_Percent(CMVar[CMON_player].defenseStats[id].spellParries, CMVar[CMON_player].defenseStats[id].spellAttacks));
	CombatMonitorSpellTotalParriesValue:SetText(str);

	str = string.format("|cffff0000%d|r  (|cffffff00%s|r)", 
CMVar[CMON_player].defenseStats[id].spellFullBlocks, CM_Percent(CMVar[CMON_player].defenseStats[id].spellFullBlocks, CMVar[CMON_player].defenseStats[id].spellAttacks));
	CombatMonitorSpellFullBlocksValue:SetText(str);
	str = string.format("%d  (|cffffff00%s|r) (|cffffff00%s|r)", CMVar[CMON_player].defenseStats[id].spellBlocks, CM_Percent(CMVar[CMON_player].defenseStats[id].spellBlocks, CMVar[CMON_player].defenseStats[id].spellAttacks), CM_Percent(CMVar[CMON_player].defenseStats[id].spellBlocks + CMVar[CMON_player].defenseStats[id].spellFullBlocks, CMVar[CMON_player].defenseStats[id].spellAttacks));
	CombatMonitorSpellPartialBlocksValue:SetText(str);

	str = string.format("%d  (%s)", CMVar[CMON_player].defenseStats[id].spellCriticals, CM_Percent(CMVar[CMON_player].defenseStats[id].spellCriticals, CMVar[CMON_player].defenseStats[id].spellAttacks));
	CombatMonitorSpellTotalCritsValue:SetText(str);
	str = string.format("%d  (%s)", CMVar[CMON_player].defenseStats[id].spellCrushing, CM_Percent(CMVar[CMON_player].defenseStats[id].spellCrushing, CMVar[CMON_player].defenseStats[id].spellAttacks));
	CombatMonitorSpellTotalCrushValue:SetText(str);

	for i=TYPE_PHYSICAL,TYPE_SHADOW do
		total = getglobal("CombatMonitorSpell"..i.."Taken");
		if CMVar[CMON_player].showPercent and (i ~= TYPE_PHYSICAL) then
			str = CM_Percent(CMVar[CMON_player].defenseStats[id].spellDamage[i], CMVar[CMON_player].defenseStats[id].spellDamage[i]+CMVar[CMON_player].defenseStats[id].resistedSpell[i]);
		else
			str = CMVar[CMON_player].defenseStats[id].spellDamage[i];
		end
		total:SetText(str);

		hits = getglobal("CombatMonitorSpell"..i.."Hits");
		str = ""
		if (i == TYPE_PHYSICAL) then
			str = "|cffff0000"
		end
		str = str .. CMVar[CMON_player].defenseStats[id].spellHits[i]
		str = str .. "|r"
		hits:SetText(str);

		average = getglobal("CombatMonitorSpell"..i.."Average");
		avg = CombatMonitor_Average(CMVar[CMON_player].defenseStats[id].spellDamage[i], CMVar[CMON_player].defenseStats[id].spellHits[i]);
		average:SetText(avg);

		if (i ~= TYPE_PHYSICAL) then
			resisted = getglobal("CombatMonitorSpell"..i.."Resisted");
			if CMVar[CMON_player].showPercent then
				str = CM_Percent(CMVar[CMON_player].defenseStats[id].resistedSpell[i], CMVar[CMON_player].defenseStats[id].spellDamage[i]+CMVar[CMON_player].defenseStats[id].resistedSpell[i]);
			else
				str = CMVar[CMON_player].defenseStats[id].resistedSpell[i];
			end
			resisted:SetText(str);
		end
	end

	local blocked = CMVar[CMON_player].defenseStats[id].meleeBlocked + CMVar[CMON_player].defenseStats[id].meleeFullBlocks * CMVar[CMON_player].blockValue
	blocked = blocked + CMVar[CMON_player].defenseStats[id].spellBlocked + CMVar[CMON_player].defenseStats[id].spellFullBlocks * CMVar[CMON_player].blockValue
	str = string.format("%d", blocked);
	CombatMonitorDamageBlockedValue:SetText(str);

	str = string.format("%s", CM_Percent(blocked, (CMVar[CMON_player].defenseStats[id].meleeDamage[TYPE_PHYSICAL] + CMVar[CMON_player].defenseStats[id].spellDamage[TYPE_PHYSICAL] + blocked)));
	CombatMonitorBlockMitigationValue:SetText(str);

	str = string.format("%d", CMVar[CMON_player].defenseStats[id].doubleCrits);
	CombatMonitorDoubleCritsValue:SetText(str);
	str = string.format("%d", CMVar[CMON_player].defenseStats[id].tripleCrits);
	CombatMonitorTripleCritsValue:SetText(str);
	str = string.format("%d", CMVar[CMON_player].defenseStats[id].resists);
	CombatMonitorResistsValue:SetText(str);
	str = string.format("%d", CMVar[CMON_player].defenseStats[id].meleeTotalDamage);
	CombatMonitorTotalDamageValue:SetText(str);
end

function CombatMonitor_Dump(toSummary)
	local str;
	
	id = CMVar[CMON_player].currentIndex;
	str = "CombatMonitor Stats:"
	CombatMonitor_DumpMessage(str, toSummary);
	str = CMON_player.." vs. "..CMVar[CMON_player].defenseStats[id].name;
	CombatMonitor_DumpMessage(str, toSummary);
	CombatMonitor_DumpMessage(" ", toSummary);

	hits = CMVar[CMON_player].defenseStats[id].meleeAttacks - CMVar[CMON_player].defenseStats[id].meleeMisses - CMVar[CMON_player].defenseStats[id].meleeDodges - CMVar[CMON_player].defenseStats[id].meleeParries;

	str = string.format("%s %d", CMON_TOTALATTACKSLABEL, CMVar[CMON_player].defenseStats[id].meleeAttacks);
	CombatMonitor_DumpMessage(str, toSummary);
	str = string.format("%s %d (%s)", CMON_MISSESLABEL, CMVar[CMON_player].defenseStats[id].meleeMisses, CM_Percent(CMVar[CMON_player].defenseStats[id].meleeMisses, CMVar[CMON_player].defenseStats[id].meleeAttacks));
	CombatMonitor_DumpMessage(str, toSummary);
	str = string.format("%s %d (%s)", CMON_DODGESLABEL, CMVar[CMON_player].defenseStats[id].meleeDodges, CM_Percent(CMVar[CMON_player].defenseStats[id].meleeDodges, CMVar[CMON_player].defenseStats[id].meleeAttacks));
	CombatMonitor_DumpMessage(str, toSummary);
	str = string.format("%s %d (%s)", CMON_PARRIESLABEL, CMVar[CMON_player].defenseStats[id].meleeParries, CM_Percent(CMVar[CMON_player].defenseStats[id].meleeParries, CMVar[CMON_player].defenseStats[id].meleeAttacks));
	CombatMonitor_DumpMessage(str, toSummary);
	str = string.format("%s %d (%s)", CMON_BLOCKSLABEL, CMVar[CMON_player].defenseStats[id].meleeBlocks, CM_Percent(CMVar[CMON_player].defenseStats[id].meleeBlocks, CMVar[CMON_player].defenseStats[id].meleeAttacks));
	CombatMonitor_DumpMessage(str, toSummary);

	local blocked = CMVar[CMON_player].defenseStats[id].meleeBlocked + CMVar[CMON_player].defenseStats[id].meleeFullBlocks * CombatMonitor_Average(CMVar[CMON_player].defenseStats[id].meleeDamage[TYPE_PHYSICAL], CMVar[CMON_player].defenseStats[id].meleeHits[TYPE_PHYSICAL])
	str = string.format("%s %d", CMON_DAMAGEBLOCKEDLABEL, blocked);
	CombatMonitor_DumpMessage(str, toSummary);

	str = string.format("%s %s", CMON_BLOCKMITIGATIONLABEL, CM_Percent(blocked, (CMVar[CMON_player].defenseStats[id].meleeDamage[TYPE_PHYSICAL] + blocked)));
	CombatMonitor_DumpMessage(str, toSummary);

	str = string.format("%s %d (%s)", CMON_CRUSHINGBLOWSLABEL, CMVar[CMON_player].defenseStats[id].meleeCrushing, CM_Percent(CMVar[CMON_player].defenseStats[id].meleeCrushing, CMVar[CMON_player].defenseStats[id].meleeAttacks));
	CombatMonitor_DumpMessage(str, toSummary);
	str = string.format("%s %d (%s)", CMON_CRITICALHITSLABEL, CMVar[CMON_player].defenseStats[id].meleeCriticals, CM_Percent(CMVar[CMON_player].defenseStats[id].meleeCriticals, CMVar[CMON_player].defenseStats[id].meleeAttacks));
	CombatMonitor_DumpMessage(str, toSummary);

	if (CMVar[CMON_player].defenseStats[id].doubleCrits > 0) then
		str = string.format("%s %d", CMON_DOUBLECRITICALSLABEL, CMVar[CMON_player].defenseStats[id].doubleCrits);
		CombatMonitor_DumpMessage(str, toSummary);
	end
	if (CMVar[CMON_player].defenseStats[id].tripleCrits > 0) then
		str = string.format("%s %d", CMON_TRIPLECRITICALSLABEL, CMVar[CMON_player].defenseStats[id].tripleCrits);
		CombatMonitor_DumpMessage(str, toSummary);
	end

	local headerShown = nil;
	for i=TYPE_PHYSICAL,TYPE_SHADOW do
		if (CMVar[CMON_player].defenseStats[id].meleeDamage[i] > 0) then
			if not headerShown then
				CombatMonitor_DumpMessage(" ", toSummary);
				CombatMonitor_DumpMessage(CMON_MELEEHEADER, toSummary);
				headerShown = 1;
			end
			str = CombatMonitor_LabelFromID(i).." "..CMVar[CMON_player].defenseStats[id].meleeDamage[i].." "..CMON_TAKENEKEY;
			if (CMVar[CMON_player].defenseStats[id].resistedMelee[i] > 0) then
				str = str.." : "..CMVar[CMON_player].defenseStats[id].resistedMelee[i].." "..CMON_RESISTEDKEY;
			end
			CombatMonitor_DumpMessage(str, toSummary);
		end
	end	

	headerShown = nil;
	for i=TYPE_PHYSICAL,TYPE_SHADOW do
		if (CMVar[CMON_player].defenseStats[id].spellDamage[i] > 0) then
			if not headerShown then
				CombatMonitor_DumpMessage(" ", toSummary);
				CombatMonitor_DumpMessage(CMON_SPELLHEADER, toSummary);
				headerShown = 1;
			end
			str = CombatMonitor_LabelFromID(i).." "..CMVar[CMON_player].defenseStats[id].spellDamage[i].." "..CMON_TAKENEKEY;
			if (CMVar[CMON_player].defenseStats[id].resistedSpell[i] > 0) then
				str = str.." : "..CMVar[CMON_player].defenseStats[id].resistedSpell[i].." "..CMON_RESISTEDKEY;
			end
			CombatMonitor_DumpMessage(str, toSummary);
		end
	end	
	CombatMonitor_DumpMessage(" ", toSummary);
	str = string.format("%s %d", CMON_SPELLRESISTSLABEL, CMVar[CMON_player].defenseStats[id].resists);
	CombatMonitor_DumpMessage(str, toSummary);
	str = string.format("%s %d", CMON_TOTALDAMAGELABEL, CMVar[CMON_player].defenseStats[id].meleeTotalDamage);
	CombatMonitor_DumpMessage(str, toSummary);
end

function CombatMonitor_LabelFromID(id)
	if (id == TYPE_ARCANE) then
		return CMON_ARCANEDAMAGELABEL;
	elseif (id == TYPE_HOLY) then
		return CMON_HOLYDAMAGELABEL;
	elseif (id == TYPE_FIRE) then
		return CMON_FIREDAMAGELABEL;
	elseif (id == TYPE_FROST) then
		return CMON_FROSTDAMAGELABEL;
	elseif (id == TYPE_NATURE) then
		return CMON_NATUREDAMAGELABEL;
	elseif (id == TYPE_SHADOW) then
		return CMON_SHADOWDAMAGELABEL;
	else
		return CMON_PHYSICALDAMAGELABEL;
	end
end

function CombatMonitor_DumpMessage(str, toSummary)
	if not toSummary then
		channel = string.upper(CMVar[CMON_player].dumpChannel);
		if(channel == "SAY" or channel == "GUILD" or channel == "RAID" or channel == "PARTY" or channel == "OFFICER") then
			SendChatMessage(str, channel);
		else
			SendChatMessage(str, "CHANNEL", GetDefaultLanguage("player"), channel);
		end
	else
		CombatMonitorCopyText:Insert(str);
		CombatMonitorCopyText:Insert("\r\n");
	end
end

----------------------------
-- Initialisation
----------------------------
function CombatMonitor_SetLabels()
	CombatMonitorMeleeTotalAttacksLabel:SetText(CMON_TOTALATTACKSLABEL);
	CombatMonitorMeleeTotalMissesLabel:SetText(CMON_MISSESLABEL);
	CombatMonitorMeleeTotalDodgesLabel:SetText(CMON_DODGESLABEL);
	CombatMonitorMeleeTotalParriesLabel:SetText(CMON_PARRIESLABEL);
	CombatMonitorMeleePartialBlocksLabel:SetText(CMON_BLOCKSLABEL);
	CombatMonitorMeleeFullBlocksLabel:SetText(CMON_FULLBLOCKSLABEL);
	CombatMonitorMeleeTotalCritsLabel:SetText(CMON_CRITICALHITSLABEL);
	CombatMonitorMeleeTotalCrushLabel:SetText(CMON_CRUSHINGBLOWSLABEL);

	CombatMonitorSpellTotalAttacksLabel:SetText(CMON_TOTALATTACKSLABEL);
	CombatMonitorSpellTotalMissesLabel:SetText(CMON_MISSESLABEL);
	CombatMonitorSpellTotalDodgesLabel:SetText(CMON_DODGESLABEL);
	CombatMonitorSpellTotalParriesLabel:SetText(CMON_PARRIESLABEL);
	CombatMonitorSpellPartialBlocksLabel:SetText(CMON_BLOCKSLABEL);
	CombatMonitorSpellFullBlocksLabel:SetText(CMON_FULLBLOCKSLABEL);
	CombatMonitorSpellTotalCritsLabel:SetText(CMON_CRITICALHITSLABEL);
	CombatMonitorSpellTotalCrushLabel:SetText(CMON_CRUSHINGBLOWSLABEL);

	CombatMonitorDamageBlockedLabel:SetText(CMON_DAMAGEBLOCKEDLABEL);
	CombatMonitorBlockMitigationLabel:SetText(CMON_BLOCKMITIGATIONLABEL);
	CombatMonitorDoubleCritsLabel:SetText(CMON_DOUBLECRITICALSLABEL);
	CombatMonitorTripleCritsLabel:SetText(CMON_TRIPLECRITICALSLABEL);

	CombatMonitorMelee1Label:SetText(CMON_PHYSICALDAMAGELABEL);
	CombatMonitorMelee2Label:SetText(CMON_ARCANEDAMAGELABEL);	
	CombatMonitorMelee3Label:SetText(CMON_FIREDAMAGELABEL);	
	CombatMonitorMelee4Label:SetText(CMON_FROSTDAMAGELABEL);	
	CombatMonitorMelee5Label:SetText(CMON_HOLYDAMAGELABEL);
	CombatMonitorMelee6Label:SetText(CMON_NATUREDAMAGELABEL);	
	CombatMonitorMelee7Label:SetText(CMON_SHADOWDAMAGELABEL);	

	CombatMonitorSpell1Label:SetText(CMON_PHYSICALDAMAGELABEL);	
	CombatMonitorSpell2Label:SetText(CMON_ARCANEDAMAGELABEL);	
	CombatMonitorSpell3Label:SetText(CMON_FIREDAMAGELABEL);	
	CombatMonitorSpell4Label:SetText(CMON_FROSTDAMAGELABEL);	
	CombatMonitorSpell5Label:SetText(CMON_HOLYDAMAGELABEL);
	CombatMonitorSpell6Label:SetText(CMON_NATUREDAMAGELABEL);	
	CombatMonitorSpell7Label:SetText(CMON_SHADOWDAMAGELABEL);	

	CombatMonitorResistsLabel:SetText(CMON_SPELLRESISTSLABEL);	
	CombatMonitorTotalDamageLabel:SetText(CMON_TOTALDAMAGELABEL);	

	CombatMonitorMeleeKey:SetText(CMON_MELEE);
	CombatMonitorDamageTakenKey:SetText(CMON_TAKENEKEY);
	CombatMonitorDamageResistedKey:SetText(CMON_RESISTEDKEY);
	CombatMonitorDamageHitsKey:SetText(CMON_HITSKEY);
	CombatMonitorDamageAverageKey:SetText(CMON_AVERAGEKEY);

	CombatMonitorSpellKey:SetText(CMON_SPELL);
	CombatMonitorSpellTakenKey:SetText(CMON_TAKENEKEY);
	CombatMonitorSpellResistedKey:SetText(CMON_RESISTEDKEY);
	CombatMonitorSpellHitsKey:SetText(CMON_HITSKEY);
	CombatMonitorSpellAverageKey:SetText(CMON_AVERAGEKEY);
	
	CombatMonitorCopyCloseButton:SetText(CLOSE);
	CombatMonitorOptionsCloseButton:SetText(CLOSE);
	CombatMonitorDumpButton:SetText(CMON_DUMP);
	CombatMonitorSummaryButton:SetText(CMON_COPY);
	CombatMonitorOptionsButton:SetText(CMON_OPTIONS);
	CombatMonitorSelectOpponentButton:SetText(CMON_ALL_OPPONENTS);
	CombatMonitorResetAllButton:SetText(RESET);
	CombatMonitorResetCurrentButton:SetText(CMON_RESET_CURRENT);
	
	CombatMonitorVersionString:SetText(string.format("%s %.2f|r", CMON_VERSION, CMON_version));
	CombatMonitorDumpChannelLabel:SetText(CMON_DUMPCHANNEL);
end

function CombatMonitor_Enabled()
	if CMVar[CMON_player].enabled then
		return 1;
	else
		return nil;
	end
end

function CombatMonitor_Initialise()
	if not CMVar then
		CMVar = { version = CMON_version }
	elseif not CMVar.version or (tonumber(CMVar.version) <= CMON_updateVersion) then
		-- Changes that need data reset
		UIErrorsFrame:AddMessage(CMON_VERSIONERROR1..CMON_version..CMON_VERSIONERROR2, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);	
		CMVar = { version = CMON_version }
	elseif (CMVar.version < CMON_version) then
		-- Changes that don't need data reset
		UIErrorsFrame:AddMessage(CMON_UPDATING.." "..CMON_version, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);	
		if not CMVar[CMON_player].blockValue then
			CMVar[CMON_player].blockValue = 0
		end
		CMVar.version = CMON_version
	end
	
	if not CMVar[CMON_player] then
		UIErrorsFrame:AddMessage(CMON_NEWPLAYER..CMON_player, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);	
		CombatMonitor_NewPlayer();
	end

	CMON_OldUIOptionsFrame_Save = UIOptionsFrame_Save
	UIOptionsFrame_Save = CMON_UIOptionsFrame_Save

	CombatMonitor_EnableLogOptions();	
	CombatMonitor_SetLabels();
	CMVar[CMON_player].currentIndex = 1;
	CombatMonitor_UpdateSummary();
	CombatMonitor_UpdateDetails();
	CombatMonitor_InitialiseOptions();
end

function CMON_UIOptionsFrame_Save()
	CMON_OldUIOptionsFrame_Save();
	CombatMonitor_EnableLogOptions();
end

function CombatMonitor_EnableLogOptions()
	if (tonumber(getglobal("SHOW_DAMAGE")) == 0 or tonumber(GetCVar("CombatLogPeriodicSpells")) == 0) then
		DEFAULT_CHAT_FRAME:AddMessage(CMON_ENABLINGPERIODIC);
		setglobal("SHOW_DAMAGE", 1);
		SetCVar("CombatLogPeriodicSpells", "1")
	end
end

function CombatMonitor_InitDumpChannelDropDownList()
	if (GetNumPartyMembers() > 0) then
		info = {};
		info.func = CombatMonitorDumpChannelDropDown_OnClick;
		info.text = "Party";
		info.value = "PARTY";
		if (CMVar[CMON_player].dumpChannel == "PARTY") then
			info.checked = 1;
			CombatMonitorDumpChannelButton:SetText("Party");			
		else
			info.checked = nil;
		end
		UIDropDownMenu_AddButton(info);
	else
		if (CMVar[CMON_player].dumpChannel == "PARTY") then
			CMVar[CMON_player].dumpChannel = "SAY";
		end
	end
	
	if IsInGuild() then
		info = {};
		info.func = CombatMonitorDumpChannelDropDown_OnClick;
		info.text = "Guild";
		info.value = "GUILD";
		if (CMVar[CMON_player].dumpChannel == "GUILD") then
			info.checked = 1;
			CombatMonitorDumpChannelButton:SetText("Guild");			
		else
			info.checked = nil;
		end
		UIDropDownMenu_AddButton(info);

		if (CanEditOfficerNote() == 1) then
			info = {};
			info.func = CombatMonitorDumpChannelDropDown_OnClick;
			info.text = "Officer";
			info.value = "OFFICER";
			if (CMVar[CMON_player].dumpChannel == "OFFICER") then
				info.checked = 1;
				CombatMonitorDumpChannelButton:SetText("Officer");			
			else
				info.checked = nil;
			end
			UIDropDownMenu_AddButton(info);
		end
	else
		if (CMVar[CMON_player].dumpChannel == "GUILD") then
			CMVar[CMON_player].dumpChannel = "SAY";
		end
	end
	
	if (GetNumRaidMembers() > 0) then
		info = {};
		info.func = CombatMonitorDumpChannelDropDown_OnClick;
		info.text = "Raid";
		info.value = "RAID";
		if (CMVar[CMON_player].dumpChannel == "RAID") then
			info.checked = 1;
			CombatMonitorDumpChannelButton:SetText("Raid");			
		else
			info.checked = nil;
		end
		UIDropDownMenu_AddButton(info);
	else
		if (CMVar[CMON_player].dumpChannel == "RAID") then
			CMVar[CMON_player].dumpChannel = "SAY";
		end
	end
	
	for i=1,10 do
		id, name = GetChannelName(i)
		if(id > 0 and name ~= nil) then
			info = {};
			info.func = CombatMonitorDumpChannelDropDown_OnClick;
			info.text = name;
			info.value = id;
			if (CMVar[CMON_player].dumpChannel == name) then
				info.checked = 1;
				CombatMonitorDumpChannelButton:SetText(name);			
			else
				info.checked = nil;
			end
			UIDropDownMenu_AddButton(info);
		end
	end

	info = {};
	info.func = CombatMonitorDumpChannelDropDown_OnClick;
	info.text = "Say";
	info.value = "SAY";
	if (CMVar[CMON_player].dumpChannel == "SAY") then
		info.checked = 1;
		CombatMonitorDumpChannelButton:SetText("Say");			
	else
		info.checked = nil;
	end
	UIDropDownMenu_AddButton(info);
end

function CombatMonitorDumpChannelDropDown_OnClick()
	UIDropDownMenu_SetSelectedValue(CombatMonitorDumpChannelDropDown, this.value);	
	CMVar[CMON_player].dumpChannel = this.value;
	CombatMonitorDumpChannelButton:SetText(this:GetText());			
end

----------------------------
-- Options
----------------------------
function CombatMonitor_InitialiseOptions()
	if not CMVar[CMON_player].dumpChannel then
		CMVar[CMON_player].dumpChannel = "SAY";
	end
	UIDropDownMenu_Initialize(CombatMonitorDumpChannelDropDown, CombatMonitor_InitDumpChannelDropDownList);

	CombatMonitorEnableCheckButtonText:SetText(CMON_ENABLEBUTTON);
	CombatMonitorDPSCheckButtonText:SetText(CMON_SHOWDPS);
	CombatMonitorEnableCheckButton:SetChecked(CMVar[CMON_player].enabled);
	CombatMonitorTrackEnvironmentalCheckButton:SetChecked(CMVar[CMON_player].trackEnvironmental);
	CombatMonitorNewOpponentsCheckButton:SetChecked(CMVar[CMON_player].trackNew);
	CombatMonitorPercentCheckButton:SetChecked(CMVar[CMON_player].showPercent);
	
	if not CMVar[CMON_player].trackNew then
		CombatMonitorAddTarget:Show();
	end
	
	CombatMonitor_InitialiseDPS();
		
	CombatMonitorTrackEnvironmentalCheckButton.tooltipText = CMON_ENVIRONMENTTOOLTIP;
	CombatMonitorTrackEnvironmentalCheckButtonText:SetText(CMON_ENVIRONMENTBUTTON);
	CombatMonitorNewOpponentsCheckButtonText:SetText(CMON_NEWMOBS);
	CombatMonitorPercentCheckButtonText:SetText(CMON_SHOWPERCENT);
end

function CombatMonitor_Options()
	if not CombatMonitorOptionsFrame:IsVisible() then
		CombatMonitorOptionsFrame:Show();
	else
		CombatMonitorOptionsFrame:Hide();
	end
end

function CombatMonitor_CloseOptions()
	CombatMonitorOptionsFrame:Hide();
end

function CombatMonitor_EnableClick()
	if this:GetChecked() then
		PlaySound("igMainMenuOptionCheckBoxOff");
		CombatMonitor_SlashCommandHandler("on");
	else
		PlaySound("igMainMenuOptionCheckBoxOn");
		CombatMonitor_SlashCommandHandler("off");
	end
end

function CombatMonitor_ShowDPS()
	if this:GetChecked() then
		PlaySound("igMainMenuOptionCheckBoxOff");
		CMVar[CMON_player].showDPS = 1;
		CombatMonitorDPSFrame:Show();
	else
		PlaySound("igMainMenuOptionCheckBoxOn");
		CMVar[CMON_player].showDPS = nil;
		CombatMonitorDPSFrame:Hide();
	end
end

function CombatMonitor_TrackEnvironmentalClick()
	if this:GetChecked() then
		PlaySound("igMainMenuOptionCheckBoxOff");
		CMVar[CMON_player].trackEnvironmental = 1;
	else
		PlaySound("igMainMenuOptionCheckBoxOn");
		CMVar[CMON_player].trackEnvironmental = nil;
	end
end

function CombatMonitor_TrackNew()
	if this:GetChecked() then
		PlaySound("igMainMenuOptionCheckBoxOff");
		CMVar[CMON_player].trackNew = 1;
		CombatMonitorAddTarget:Hide();
	else
		PlaySound("igMainMenuOptionCheckBoxOn");
		CMVar[CMON_player].trackNew = nil;
		CombatMonitorAddTarget:Show();
	end
end

function CombatMonitor_ShowPercent()
	if this:GetChecked() then
		PlaySound("igMainMenuOptionCheckBoxOff");
		CMVar[CMON_player].showPercent = 1;
	else
		PlaySound("igMainMenuOptionCheckBoxOn");
		CMVar[CMON_player].showPercent = nil;
	end
	CombatMonitor_UpdateDetails();
end

----------------------------
-- Data Functions
----------------------------
function CombatMonitor_NewPlayer()
	CMVar[CMON_player] = 
	{
			enabled = 1,
			count = 0,
			defenseStats = {},
			currentIndex = nil,
			dumpChannel = "Say",
			trackEnvironmental = 1,
			showDPS = 1,
			trackNew = 1,
			blockValue = 0,
	};
	CombatMonitor_AddName(CMON_ALL_OPPONENTS);
end

function CombatMonitor_IDFromName(name)
	for i=1,table.getn(CMVar[CMON_player].defenseStats) do
		if (CMVar[CMON_player].defenseStats[i].name == name) then
			return i;
		end
	end
	return nil;
end

function CombatMonitor_CalculateAllOpponents()
	CMVar[CMON_player].defenseStats[1] = CombatMonitor_NewStats(CMON_ALL_OPPONENTS)
--	table.remove(CMVar[CMON_player].defenseStats, 1);
--	table.insert(CMVar[CMON_player].defenseStats, 1, CombatMonitor_NewStats(CMON_ALL_OPPONENTS));

	for id=2,table.getn(CMVar[CMON_player].defenseStats) do
		if (CMVar[CMON_player].defenseStats[id].name ~= "Environmental") then
			CMVar[CMON_player].defenseStats[1].meleeBlocked = CMVar[CMON_player].defenseStats[1].meleeBlocked + CMVar[CMON_player].defenseStats[id].meleeBlocked;

			if (CMVar[CMON_player].defenseStats[id].meleeFullBlocks > 0) then
				local fullBlocks = CMVar[CMON_player].defenseStats[id].meleeFullBlocks * CombatMonitor_Average(CMVar[CMON_player].defenseStats[id].meleeDamage[TYPE_PHYSICAL], CMVar[CMON_player].defenseStats[id].meleeHits[TYPE_PHYSICAL])
				CMVar[CMON_player].defenseStats[1].meleeBlocked = CMVar[CMON_player].defenseStats[1].meleeBlocked + fullBlocks;
			end
	
			CMVar[CMON_player].defenseStats[1].meleeAttacks = CMVar[CMON_player].defenseStats[1].meleeAttacks + CMVar[CMON_player].defenseStats[id].meleeAttacks;
			CMVar[CMON_player].defenseStats[1].meleeCriticals = CMVar[CMON_player].defenseStats[1].meleeCriticals + CMVar[CMON_player].defenseStats[id].meleeCriticals;
			CMVar[CMON_player].defenseStats[1].meleeCrushing = CMVar[CMON_player].defenseStats[1].meleeCrushing + CMVar[CMON_player].defenseStats[id].meleeCrushing;
			CMVar[CMON_player].defenseStats[1].meleeTotalDamage = CMVar[CMON_player].defenseStats[1].meleeTotalDamage + CMVar[CMON_player].defenseStats[id].meleeTotalDamage;
			CMVar[CMON_player].defenseStats[1].meleeFullBlocks = CMVar[CMON_player].defenseStats[1].meleeFullBlocks + CMVar[CMON_player].defenseStats[id].meleeFullBlocks;
			CMVar[CMON_player].defenseStats[1].meleeBlocks = CMVar[CMON_player].defenseStats[1].meleeBlocks + CMVar[CMON_player].defenseStats[id].meleeBlocks;
			CMVar[CMON_player].defenseStats[1].meleeDodges = CMVar[CMON_player].defenseStats[1].meleeDodges + CMVar[CMON_player].defenseStats[id].meleeDodges;
			CMVar[CMON_player].defenseStats[1].meleeParries = CMVar[CMON_player].defenseStats[1].meleeParries + CMVar[CMON_player].defenseStats[id].meleeParries;
			CMVar[CMON_player].defenseStats[1].meleeMisses = CMVar[CMON_player].defenseStats[1].meleeMisses + CMVar[CMON_player].defenseStats[id].meleeMisses;
	
			CMVar[CMON_player].defenseStats[1].doubleCrits = CMVar[CMON_player].defenseStats[1].doubleCrits + CMVar[CMON_player].defenseStats[id].doubleCrits;
			CMVar[CMON_player].defenseStats[1].tripleCrits = CMVar[CMON_player].defenseStats[1].tripleCrits + CMVar[CMON_player].defenseStats[id].tripleCrits;
			CMVar[CMON_player].defenseStats[1].critCount = CMVar[CMON_player].defenseStats[1].critCount + CMVar[CMON_player].defenseStats[id].critCount;
			CMVar[CMON_player].defenseStats[1].resists = CMVar[CMON_player].defenseStats[1].resists + CMVar[CMON_player].defenseStats[id].resists;
			
			CMVar[CMON_player].defenseStats[1].spellAttacks = CMVar[CMON_player].defenseStats[1].spellAttacks + CMVar[CMON_player].defenseStats[id].spellAttacks;
			CMVar[CMON_player].defenseStats[1].spellCriticals = CMVar[CMON_player].defenseStats[1].spellCriticals + CMVar[CMON_player].defenseStats[id].spellCriticals;
			CMVar[CMON_player].defenseStats[1].spellCrushing = CMVar[CMON_player].defenseStats[1].spellCrushing + CMVar[CMON_player].defenseStats[id].spellCrushing;
			CMVar[CMON_player].defenseStats[1].spellTotalDamage = CMVar[CMON_player].defenseStats[1].spellTotalDamage + CMVar[CMON_player].defenseStats[id].spellTotalDamage;
			CMVar[CMON_player].defenseStats[1].spellFullBlocks = CMVar[CMON_player].defenseStats[1].spellFullBlocks + CMVar[CMON_player].defenseStats[id].spellFullBlocks;
			CMVar[CMON_player].defenseStats[1].spellBlocks = CMVar[CMON_player].defenseStats[1].spellBlocks + CMVar[CMON_player].defenseStats[id].spellBlocks;
			CMVar[CMON_player].defenseStats[1].spellDodges = CMVar[CMON_player].defenseStats[1].spellDodges + CMVar[CMON_player].defenseStats[id].spellDodges;
			CMVar[CMON_player].defenseStats[1].spellParries = CMVar[CMON_player].defenseStats[1].spellParries + CMVar[CMON_player].defenseStats[id].spellParries;
			CMVar[CMON_player].defenseStats[1].spellMisses = CMVar[CMON_player].defenseStats[1].spellMisses + CMVar[CMON_player].defenseStats[id].spellMisses;
	
			for i=TYPE_PHYSICAL,TYPE_SHADOW do
				CMVar[CMON_player].defenseStats[1].meleeDamage[i] = CMVar[CMON_player].defenseStats[1].meleeDamage[i] + CMVar[CMON_player].defenseStats[id].meleeDamage[i];
				CMVar[CMON_player].defenseStats[1].resistedMelee[i] = CMVar[CMON_player].defenseStats[1].resistedMelee[i] + CMVar[CMON_player].defenseStats[id].resistedMelee[i];
				CMVar[CMON_player].defenseStats[1].meleeHits[i] = CMVar[CMON_player].defenseStats[1].meleeHits[i] + CMVar[CMON_player].defenseStats[id].meleeHits[i];
		
				CMVar[CMON_player].defenseStats[1].spellDamage[i] = CMVar[CMON_player].defenseStats[1].spellDamage[i] + CMVar[CMON_player].defenseStats[id].spellDamage[i];
				CMVar[CMON_player].defenseStats[1].resistedSpell[i] = CMVar[CMON_player].defenseStats[1].resistedSpell[i] + CMVar[CMON_player].defenseStats[id].resistedSpell[i];
				CMVar[CMON_player].defenseStats[1].spellHits[i] = CMVar[CMON_player].defenseStats[1].spellHits[i] + CMVar[CMON_player].defenseStats[id].spellHits[i];
			end
		end
	end
end

function CombatMonitor_ClearCurrentUnit()
	if (CMVar[CMON_player].currentIndex == 1) then
		UIErrorsFrame:AddMessage(CMON_CLEARALLERR, 1.0, 0.0, 0.0, 1.0, UIERRORS_HOLD_TIME);	
		return;
	end
	table.remove(CMVar[CMON_player].defenseStats, CMVar[CMON_player].currentIndex);
	CMVar[CMON_player].currentIndex = CMVar[CMON_player].currentIndex - 1;
	CombatMonitor_CalculateAllOpponents()
	CombatMonitor_UpdateOpponentList();
	CombatMonitor_UpdateDetails();
	CombatMonitor_UpdateSummary();
end

function CombatMonitor_Clear()
	oldStats = CMVar[CMON_player].defenseStats;
	CMVar[CMON_player].defenseStats = {};
	CombatMonitor_AddName(CMON_ALL_OPPONENTS);
	CMVar[CMON_player].currentIndex = 1;

	for i=2,table.getn(oldStats) do
		if oldStats[i].save then
			table.insert(CMVar[CMON_player].defenseStats, oldStats[i]);
		end
	end
	oldStats = {};
	CMON_opponentList = {};
	CombatMonitor_CalculateAllOpponents();
	CombatMonitor_UpdateOpponentList();
	CombatMonitor_UpdateDetails();
	CombatMonitor_UpdateSummary();
end

function CombatMonitor_ClearAll()
	CMON_opponentList = {};
	CMVar[CMON_player].defenseStats = {};
	CombatMonitor_AddName(CMON_ALL_OPPONENTS);
	CMVar[CMON_player].currentIndex = 1;
	CombatMonitor_UpdateDetails();
	CombatMonitor_UpdateSummary();
end


function CombatMonitor_NewStats(name)
	x = 
	{
			name = name;
			meleeAttacks = 0;
			meleeCriticals = 0;
			meleeCrushing = 0;
			meleeTotalDamage = 0;
			meleeBlocks = 0;
			meleeFullBlocks = 0;
			meleeBlocked = 0;
			meleeDodges = 0;
			meleeParries = 0;
			meleeMisses = 0;

			doubleCrits = 0;
			tripleCrits = 0;
			critCount = 0;
			
			spellAttacks = 0;
			spellCriticals = 0;
			spellCrushing = 0;
			spellTotalDamage = 0;
			spellBlocks = 0;
			spellFullBlocks = 0;
			spellBlocked = 0;
			spellDodges = 0;
			spellParries = 0;
			spellMisses = 0;
			resists = 0;

			meleeDamage = {};
			resistedMelee = {};
			meleeHits = {};
			spellDamage = {};
			resistedSpell = {};
			spellHits = {};
	};

	for i=TYPE_PHYSICAL,TYPE_SHADOW do
		x.meleeDamage[i] = 0;
		x.resistedMelee[i] = 0;
		x.meleeHits[i] = 0;

		x.spellDamage[i] = 0;
		x.resistedSpell[i] = 0;
		x.spellHits[i] = 0;
	end

	return x;
end

function CombatMonitor_AddName(name)
	if not name then
		return nil;
	end

	id = CombatMonitor_IDFromName(name);
	if id then
		return id;
	end

	table.insert(CMVar[CMON_player].defenseStats, CombatMonitor_NewStats(name));
	index = table.getn(CMVar[CMON_player].defenseStats);

	if (CombatMonitorOpponentListFrame:IsVisible()) then
		CombatMonitor_UpdateOpponentList();
	end

	return index;
end

----------------------------
-- DPS Monitor
----------------------------
CMON_combatTime = 0;
CMON_trackingDPS = nil;
CMON_damage = 0;
CMON_lastDamage = 0;
CMON_delta = {};
CMON_peakDPS = 0;
CMON_deltaSize = 3;

function CombatMonitor_OnClickDPS(button)
	if (button == "LeftButton") then
		CombatMonitor_ToggleDPS(0);
	end
end

function CombatMonitor_ToggleDPS(on)
	if not CMVar[CMON_player].showDPS then
		return;
	end
	
	if (on == 1) then
		CMON_trackingDPS = 1;	
		CMON_combatTime = 0;
		CMON_damage = 0;
		CMON_lastDamage = 0;
		for i=1,CMON_deltaSize do
			CMON_delta[i] = 0;
		end
		CMON_peakDPS = 0;
		CombatMonitorPDPSValue:SetText(CMON_peakDPS.." DPS");
	else
		if (CMON_trackingDPS and CMON_damage > 0) then
			str = CMON_combatTime.." seconds - "..CMON_damage.." damage - ";
			str = str..CM_Round(CMON_damage/CMON_combatTime).." DPS average - "..CMON_peakDPS.." DPS peak";
			DEFAULT_CHAT_FRAME:AddMessage(str);
		end
		CMON_trackingDPS = nil;
	end
end

function CombatMonitor_TimerIncrement()
	-- Called from CombatMonitor_OnUpdate every second

	local dps = 0;
	for i=1,CMON_deltaSize do
		dps = dps + CMON_delta[i];
	end
	dps = CM_Round(dps/CMON_deltaSize);
	if (dps > CMON_peakDPS) then
		CMON_peakDPS = dps;
		CombatMonitorPDPSValue:SetText(CMON_peakDPS.." DPS");
	end
	CombatMonitorIDPSValue:SetText(dps.." DPS");
	if (CMON_combatTime > 0) then
		CombatMonitorADPSValue:SetText(CM_Round(CMON_damage/CMON_combatTime).." DPS");
	end
	for i=CMON_deltaSize,2,-1 do
		CMON_delta[i] = CMON_delta[i-1];
	end
	CMON_delta[1] = CMON_damage - CMON_lastDamage;
	CMON_lastDamage = CMON_damage;
	CMON_combatTime = CMON_combatTime + 1;
end

function CombatMonitor_InitialiseDPS()
	CombatMonitorDPSBanner:SetText(CMON_DPSBANNER);
	CombatMonitorPDPSLabel:SetText(CMON_PEAK);
	CombatMonitorIDPSLabel:SetText(CMON_INSTANTANEOUS);
	CombatMonitorADPSLabel:SetText(CMON_AVERAGE);
	if CMVar[CMON_player].showDPS then
		CombatMonitorDPSCheckButton:SetChecked(1);
		CombatMonitorDPSFrame:Show();
	else
		CombatMonitorDPSFrame:Hide();
	end
end


function CombatMonitor_CopyFrame()
	CombatMonitorCopyFrame:Show();
	CombatMonitorCopyText:SetText("");
	CombatMonitor_Dump(1);
end