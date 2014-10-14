------------------------------------------------------------------------------------------------------------------------
--	FearDance is a stance-switching macro to aid warriors when using Berserker Rage.
--	For each button click, it switches from:
--		Original Stance -> Berserker Stance -> Berserker Rage -> Original Stance
--
--	As a precautionary measure, FearDance does not trigger unless the "Berserker Rage" cooldown is complete.
--	It also prevents you from using "Berserker Rage" if you currently have protection to fear active.
--
--	Use "/fd help" to see options and settings.
--
--	By Toggol of Stormrage
------------------------------------------------------------------------------------------------------------------------

-- Default saved variables
debugMode = FEARDANCE_OFF;

-- Define warrior stances & skills
stanceBattle = 1;
stanceDefence = 2;
stanceBerserk = 3;
playerUnit = "player";


------------------------------------------------------------------------------------------------------------------------
-- Main Function: Perform Stance Dancing & Rage
function FearDance_UseAction()
	local inBerserkStance = 0;
	local isBerserkStanceActive;
	local isBattleStanceActive;
	local rageId;
	local hasFearProtection = false;
	local start;
	local duration;

	-- Check if player is in "Berserker Stance"
	_, _, isBerserkStanceActive, _ = GetShapeshiftFormInfo(stanceBerserk);
	if isBerserkStanceActive then
		inBerserkStance = 1;
	else
		inBerserkStance = 0;
	end;

	-- Get SpellId of "Berserker Rage"
	rageId = FearDance_GetSpellId(FEARDANCE_BERSERKER_RAGE);

	-- Check for fear protection
	hasFearProtection = FearDance_HasFearProtection();

	-- Check if the cooldown for "Berserker Rage" is ready.
	local start, duration = GetSpellCooldown(rageId, BOOKTYPE_SPELL);
	if ( start > 2 and duration > 2) then
		-- Check if player is in Berserk Stance
		if inBerserkStance == 1 then
			-- Set player to their "Original Stance"
			FearDance_SetStance(stanceOriginal);
		else
			-- The cooldown is not yet complete. Calculate & round the cooldown for display.
			FearDance_ShowCooldown(start, duration);
		end;
	else
		-- Check if player is in Berserk Stance
		if inBerserkStance == 1 and not hasFearProtection then
			-- Cast "Berserker Rage"
			FearDance_CastRage();
		else
			-- Save the player's "Original Stance"
			_, _, isBattleStanceActive, _ = GetShapeshiftFormInfo(stanceBattle);
			if isBattleStanceActive then
				stanceOriginal = stanceBattle;
			else
				stanceOriginal = stanceDefence;
			end;

			-- Verify that the player does not have fear protection
			if hasFearProtection then
				-- Player already has fear protection
				DEFAULT_CHAT_FRAME:AddMessage(FEARDANCE_MSG_FEARLESS);
			else
				-- Cancel any skills in progress
				SpellStopCasting();

				-- Set player to "Berserker Stance"
				FearDance_SetStance(stanceBerserk);
			end;
		end;
	end;
end


------------------------------------------------------------------------------------------------------------------------
-- Switch to Specified Warrior Stance
function FearDance_SetStance(stanceId)
	-- Debug message
	if debugMode == FEARDANCE_ON then
		DEFAULT_CHAT_FRAME:AddMessage(string.format(FEARDANCE_MSG_STANCE, FEARDANCE_STANCES[stanceId]));
	end;

	CastSpellByName(FEARDANCE_STANCES[stanceId]);
end


------------------------------------------------------------------------------------------------------------------------
-- Cast "Berserker Rage"
function FearDance_CastRage()
	-- Debug message
	if debugMode == FEARDANCE_ON then
		DEFAULT_CHAT_FRAME:AddMessage(string.format(FEARDANCE_MSG_RAGED, FEARDANCE_BERSERKER_RAGE));
	end;

	CastSpellByName(FEARDANCE_BERSERKER_RAGE);
end


------------------------------------------------------------------------------------------------------------------------
-- Check if any player has fear protection
-- Skills / Items to support in the future:
--	Fear Ward (Skill) - Done
--	Berserker Rage (Skill) - Done
--	Will of the Forsaken (Skill)
--	Death Wish (Skill)
--	Recklessness? (Skill)
--	Insignia of the Alliance (Item)
--	Glimmering Mithril Insignia (Item) - Uses "Ability_Warrior_BattleShout" icon which conflict with BattleShout. Blech.
------------------------------------------------------------------------------------------------------------------------

function FearDance_HasFearProtection()
	local hasFearProtection = false;
	local hasFearWard = false;

	-- Check for each type of fear protection
	hasFearWard = FearDance_IsBuffActive(playerUnit, FEARDANCE_PROTECTION_FEARWARD);
	hasBerserkerRage = FearDance_IsBuffActive(playerUnit, FEARDANCE_PROTECTION_RAGE);

	-- Final Fear-Protection Check
	if hasFearWard or hasBerserkerRage then
		return true;
	end;

	return false;
end


------------------------------------------------------------------------------------------------------------------------
-- Calculate and display the cooldown for "Berserker Rage"
function FearDance_ShowCooldown(startTime, duration)
	local decimalPlaces = 1;
	local cooldown;
	local shift;

	-- Calculate & round the cooldown
	cooldown = duration - ( GetTime() - startTime);
	shift = 10 ^ decimalPlaces;
	cooldown = floor( cooldown * shift + 0.5 ) / shift;

	DEFAULT_CHAT_FRAME:AddMessage(string.format(FEARDANCE_COOLDOWN, cooldown));
end


------------------------------------------------------------------------------------------------------------------------
-- Get the ID of the specified spell
function FearDance_GetSpellId(spellName)
	local n, spellTab, bookType, spellId, spellCount, spellCountOnTab = spellName, GetNumSpellTabs(), BOOKTYPE_SPELL, 0, 0;

	-- Loop through Spell Tabs
	for tempSpellId = 1, spellTab do
		_, _, _, spellCountOnTab = GetSpellTabInfo(tempSpellId);
		spellCount = spellCount + spellCountOnTab;
	end;

	-- Check each page for Spell Name
	for tempSpellId = 1, spellCount do
		if GetSpellName(tempSpellId, bookType) == n then
			spellId = tempSpellId;
			break;
		end;
	end;

	return spellId;
end


------------------------------------------------------------------------------------------------------------------------
-- Determine if the specified buff is active on the target
function FearDance_IsBuffActive(unitName, buffName)
	local i = 1;

	-- Parse all buffs on the target. Return "true" if specified buff is located.
	while UnitBuff(unitName, i) do

		if string.find(UnitBuff(unitName, i), buffName) ~= nil then
--			DEFAULT_CHAT_FRAME:AddMessage(COLOR_RED .. UnitBuff(unitName, i));
--			-- Display debug message
--			if debugMode == FEARDANCE_ON then
--				DEFAULT_CHAT_FRAME:AddMessage(string.format(FEARDANCE_MSG_BUFF_FOUND, buffName));
--			end;

			return true;
		end;
		i = i + 1;
	end;

--	-- Display debug message
--	if debugMode == FEARDANCE_ON then
--		DEFAULT_CHAT_FRAME:AddMessage(string.format(FEARDANCE_MSG_BUFF_NOTFOUND, buffName));
--	end;

	return false;
end


------------------------------------------------------------------------------------------------------------------------
-- Onload event
function FearDance_OnLoad()
	-- Register the event
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("VARIABLES_LOADED");

	-- Default the original stance to "Battle Stance"
	stanceOriginal = stanceBattle;

	-- Slash Commands
	SLASH_FEARDANCE1 = "/feardance";
	SLASH_FEARDANCE2 = "/fd";

	-- Slash Command
	SlashCmdList["FEARDANCE"] = function(command)
		FearDance_SlashCommand(command, value);
	end;

	-- Display the OnLoad message
	DEFAULT_CHAT_FRAME:AddMessage(string.format(FEARDANCE_LOADED, FEARDANCE_VERSION));
end


------------------------------------------------------------------------------------------------------------------------
-- Parse Slash Commands
function FearDance_SlashCommand(command)
	-- Extract value from command
	local value;
	local valueFound, valuePos, valueLength = strfind(command, "(%s+)");
	if valueFound then
		value = strsub(command, valuePos + 1);
		command = strsub(command, 1, strlen(command) - strlen(value) - 1);
	end;

	-- Set defaults for the variables
	if (command == nil) then command = FEARDANCE_EMPTY end;
	if (value == nil) then value = -1 end;

	-- Help command: Display the help options
	if (command == FEARDANCE_HELP_LONG) or (command == FEARDANCE_HELP_SHORT) then
		FearDance_ShowStatus();
	-- Command found: Set new variable value
	elseif (command ~= FEARDANCE_EMPTY) then
		FearDance_SetVariable(command, value);
	-- No command: Do FearDancing
	elseif (command == FEARDANCE_EMPTY) then
		FearDance_UseAction();
	-- Unknown command: Display Status
	else
		FearDance_ShowStatus();
	end;
end


------------------------------------------------------------------------------------------------------------------------
-- Setup Variables
function FearDance_SetVariable(name, value)

	-- DebugMode
	if (name == FEARDANCE_DEBUG_LONG) or (name == FEARDANCE_DEBUG_SHORT) then
		if (value == FEARDANCE_OFF) or (value == FEARDANCE_ON) then
			debugMode = value;
			DEFAULT_CHAT_FRAME:AddMessage(string.format(FEARDANCE_DEBUG_SET, debugMode));
		else
			DEFAULT_CHAT_FRAME:AddMessage(FEARDANCE_DEBUG_TITLE);
			DEFAULT_CHAT_FRAME:AddMessage(FEARDANCE_DEBUG_DESC1);
			DEFAULT_CHAT_FRAME:AddMessage(FEARDANCE_DEBUG_DESC2);
		end;
	else
		DEFAULT_CHAT_FRAME:AddMessage(FEARDANCE_MSG_NOVAR);
		DEFAULT_CHAT_FRAME:AddMessage(FEARDANCE_MSG_USEHELP);
	end;
end


------------------------------------------------------------------------------------------------------------------------
-- Display Status
function FearDance_ShowStatus()
	DEFAULT_CHAT_FRAME:AddMessage(string.format(FEARDANCE_LOADED, FEARDANCE_VERSION));
	DEFAULT_CHAT_FRAME:AddMessage(FEARDANCE_USAGE_TITLE);
	DEFAULT_CHAT_FRAME:AddMessage(FEARDANCE_USAGE_MAIN);
	DEFAULT_CHAT_FRAME:AddMessage(FEARDANCE_USAGE_HELP);
	DEFAULT_CHAT_FRAME:AddMessage(string.format(FEARDANCE_USAGE_DEBUG, debugMode));
end
