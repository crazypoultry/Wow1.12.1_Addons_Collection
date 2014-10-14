BINDING_HEADER_EASYTAB = "EasyTab";
BINDING_NAME_EASYTAB = "Find Target";
BINDING_NAME_EASYTAB_SET = "Set/Clear Assist";

EASYTAB_VERSION = "v0.3.1";
EASYTAB_LOADED_TEXT = "Sledge's |cff0000ffEasyTab |r|cffffff00" .. EASYTAB_VERSION .. " |rloaded!";
EASYTAB_ASSIST_SET_TEXT = "|cff0000ffEasyTab:|r Main Assist set to: |cffff0000";
EASYTAB_ASSIST_DISP_TEXT = "|cff0000ffEasyTab:|r Main Assist is: |cffff0000";
EASYTAB_ASSIST_NONE_TEXT = "|cff0000ffEasyTab:|r Main Assist not set!";
EASYTAB_ASSIST_FOUND_TEXT = "|cff0000ffEasyTab:|r Assisting |cffff0000";
EASYTAB_ASSIST_NOTFOUND_TEXT1 = "|cff0000ffEasyTab:|r Could not assist |cffff0000";
EASYTAB_ASSIST_NOTFOUND_TEXT2 = "|r, blacklisted for |cffff0000";
EASYTAB_ASSIST_NOTFOUND_TEXT3 = "|r seconds.";
EASYTAB_ASSIST_CLEAR_TEXT = "|cff0000ffEasyTab:|r Main Assist has been cleared.";
EASYTAB_BLACKLIST_SET_TEXT = "|cff0000ffEasyTab:|r Blacklist duration has been set to: |cffff0000";
EASYTAB_BLACKLIST_UNSET_TEXT = "|cff0000ffEasyTab:|r Blacklisting has been turned off.";
EASYTAB_BLACKLIST_SHOWDUR_TEXT = "|cff0000ffEasyTab:|r Blacklist duration is currently: |cffff0000";

EASYTAB_HELP1 = "|cff0000ffEasyTab |r" .. EASYTAB_VERSION .. " |cffffff00----------";
EASYTAB_HELP2 = "Created by Sledge, US-Eredar";
EASYTAB_HELP3 = "|cffffff00Usage:";
EASYTAB_HELP4 = "|cffffff00/easytab config|r : Open the configuration panel."
EASYTAB_HELP5 = "|cffffff00/easytab assist|r : Set the Main Assist to the currently selected player. If no player is selected, the current Main Assist will be displayed.";
EASYTAB_HELP6 = "|cffffff00/easytab assist <player>|r : Set the Main Assist to <player>.";
EASYTAB_HELP7 = "|cffffff00/easytab clear|r : Clear the current Main Assist.";
EASYTAB_HELP8 = "|cffffff00/easytab target|r : Attempt to select a target.";
EASYTAB_HELP9 = "|cffffff00/easytab help|r : Display this help message.";

local blTime = time();
EasyTab_variablesLoaded = false;
local myRealm = GetCVar("realmName");
local myChar = UnitName("player");

local blDuration_default = 2;
local ignorePets_default = false;
local ignoreMinions_default = false;
local ignoreCC_default = false;
local ignoreTapped_default = false;

EasyTab_Config = {
	blduration = 2
}

function EasyTab_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	-- Register slash commands
	SLASH_EASYTAB1 = "/easytab";
	SLASH_EASYTAB2 = "/et";
	SLASH_EASYTAB3 = "/eztab";
	SLASH_EASYTAB4 = "/etab";
	SlashCmdList["EASYTAB"] = function(msg)
		EasyTab_SlashHandler(msg);
	end

	-- It's loaded!
	DEFAULT_CHAT_FRAME:AddMessage(EASYTAB_LOADED_TEXT);
end

-- Event handler
function EasyTab_OnEvent()
	if ( event == "VARIABLES_LOADED" ) then
		EasyTab_VARIABLES_LOADED();
	end
end

-- Once variables are loaded, set up configuration if necessary
function EasyTab_VARIABLES_LOADED()
	if ( not EasyTab_Config ) then
		EasyTab_Config = {};
	end
	if ( not EasyTab_Config[myRealm] ) then
		EasyTab_Config[myRealm] = {};
	end
	if ( not EasyTab_Config[myRealm][myChar] ) then
		EasyTab_Config[myRealm][myChar] = {};
	end
	if ( not EasyTab_Config[myRealm][myChar].blDuration ) then
		EasyTab_Config[myRealm][myChar].blDuration = blDuration_default;
	end
	if ( not EasyTab_Config[myRealm][myChar].ignorePets ) then
		EasyTab_Config[myRealm][myChar].ignorePets = ignorePets_default;
	end
	if ( not EasyTab_Config[myRealm][myChar].ignoreMinions ) then
		EasyTab_Config[myRealm][myChar].ignoreMinions = ignoreMinions_default;
	end
	if ( not EasyTab_Config[myRealm][myChar].ignoreCC ) then
		EasyTab_Config[myRealm][myChar].ignoreCC = ignoreCC_default;
	end
	if ( not EasyTab_Config[myRealm][myChar].ignoreTapped ) then
		EasyTab_Config[myRealm][myChar].ignoreTapped = ignoreTapped_default;
	end
	EasyTab_variablesLoaded = true;
end

--Slash Handler
function EasyTab_SlashHandler(msg)
	if ( msg ) then
		local cmd, subcmd = EasyTab_GetCmd(string.lower(msg));

		if ( cmd == "assist" ) then
			if ( ( subcmd and string.len(subcmd) > 0 ) or ( UnitIsPlayer("target") ) ) then
				EasyTab_SetAssist(subcmd);
			else
				if ( EasyTab_AssistTarget and string.len(EasyTab_AssistTarget) > 0 ) then
					DEFAULT_CHAT_FRAME:AddMessage(EASYTAB_ASSIST_DISP_TEXT .. EasyTab_AssistTarget);
				else
					DEFAULT_CHAT_FRAME:AddMessage(EASYTAB_ASSIST_NONE_TEXT);
				end
			end
		elseif ( cmd == "target" ) then
			EasyTab_Target();
		elseif ( cmd == "clear" ) then
			EasyTab_ClearAssist();
		elseif ( cmd == "blacklist" ) then
			if ( subcmd == "" ) then
				DEFAULT_CHAT_FRAME:AddMessage(EASYTAB_BLACKLIST_SHOWDUR_TEXT .. EasyTab_Config[myRealm][myChar].blDuration);
			else
				EasyTab_SetBlacklist(subcmd);
			end
		-- I use this for testing the target checking algorithms
		-- elseif ( cmd == "check" ) then
		--	DEFAULT_CHAT_FRAME:AddMessage("Target check return: " .. tostring(EasyTab_ValidTarget("target")) .. " (" .. tostring(UnitIsPlayer("target")) .. " " .. tostring(UnitPlayerControlled("target")) .. " " .. tostring(UnitPowerType("target")) .. ")");
		elseif ( cmd == "options" or cmd == "config" ) then
			EasyTab_ConfigFrame:Show();
		else
			EasyTab_Help();
		end
	end
end

-- Set the Blacklist duration
function EasyTab_SetBlacklist(duration)
	blduration = tonumber(duration);
	if ( blduration ~= nil ) then
		if ( blduration > 0 ) then
			EasyTab_Config[myRealm][myChar].blDuration = blduration;
			DEFAULT_CHAT_FRAME:AddMessage(EASYTAB_BLACKLIST_SET_TEXT .. blduration);
		else
			EasyTab_Config[myRealm][myChar].blDuration = 0;
			DEFAULT_CHAT_FRAME:AddMessage(EASYTAB_BLACKLIST_UNSET_TEXT);
		end
	else
		EasyTab_Config[myRealm][myChar].blDuration = 0;
		DEFAULT_CHAT_FRAME:AddMessage(EASYTAB_BLACKLIST_UNSET_TEXT);
	end
end

-- Set the EasyTab_AssistTarget
function EasyTab_SetAssist(assist)
	if ( assist and string.len(assist) > 0 ) then
		EasyTab_AssistTarget = string.upper(string.sub(assist, 1, 1)) .. string.sub(assist, 2);
		DEFAULT_CHAT_FRAME:AddMessage(EASYTAB_ASSIST_SET_TEXT .. EasyTab_AssistTarget);
	elseif ( UnitIsPlayer("target") and not UnitIsUnit("target", "player") ) then
		EasyTab_AssistTarget = UnitName("target");
		DEFAULT_CHAT_FRAME:AddMessage(EASYTAB_ASSIST_SET_TEXT .. EasyTab_AssistTarget);
	else
		EasyTab_ClearAssist();
	end
end

-- Clear the EasyTab_AssistTarget
function EasyTab_ClearAssist()
	EasyTab_AssistTarget = nil;
	DEFAULT_CHAT_FRAME:AddMessage(EASYTAB_ASSIST_CLEAR_TEXT);
end

-- Pick a target!
function EasyTab_Target()
	local Blacklisted = false;
	local blDuration = EasyTab_Config[myRealm][myChar].blDuration;
	local hadTarget = false;
	if ( UnitExists("target") ) then
		hadTarget = true;
	end
	if ( blDuration ~= nil ) then
		if ( time() - blTime <= blDuration ) then
			Blacklisted = true;
		end
	end

	TargetNearestEnemy();

	-- Try to assist the EasyTab_AssistTarget
	if ( ( EasyTab_AssistTarget and string.len(EasyTab_AssistTarget) > 0 ) and Blacklisted == false ) then
		ClearTarget();
		TargetByName(EasyTab_AssistTarget, 1);
		if ( ( UnitExists("target") and UnitExists("targettarget") ) and not ( UnitIsCorpse("targettarget") or UnitIsDead("targettarget") ) ) then
			AssistUnit("target");
			DEFAULT_CHAT_FRAME:AddMessage(EASYTAB_ASSIST_FOUND_TEXT .. EasyTab_AssistTarget);
			return;
		else
			-- Blacklist the Assist Target as of now
			blTime = time();
			DEFAULT_CHAT_FRAME:AddMessage(EASYTAB_ASSIST_NOTFOUND_TEXT1 .. EasyTab_AssistTarget .. EASYTAB_ASSIST_NOTFOUND_TEXT2 .. blDuration .. EASYTAB_ASSIST_NOTFOUND_TEXT3);
			if ( hadTarget ) then
				TargetLastTarget();
			else
				ClearTarget();
			end
			TargetNearestEnemy();
		end
	end
	
	local i = 0;
	while i < 5 do
		i = i+1;
		if ( not EasyTab_ValidTarget("target") ) then
			TargetNearestEnemy();
		end
	end
end

-- Check to see if the target is valid
function EasyTab_ValidTarget(unitid)
	-- Load settings (for readability)
	local ignorePets = EasyTab_Config[myRealm][myChar].ignorePets;
	local ignoreMinions = EasyTab_Config[myRealm][myChar].ignoreMinions;
	local ignoreTapped = EasyTab_Config[myRealm][myChar].ignoreTapped;
	local ignoreCC = EasyTab_Config[myRealm][myChar].ignoreCC;
	
	-- Corpses
	if ( UnitIsCorpse(unitid) ) then
		return false;
	-- Dead players
	elseif ( UnitIsDead(unitid) ) then
		return false;
	-- Hunter pets
	elseif ( ( ( UnitPlayerControlled(unitid) and not UnitIsPlayer(unitid) ) and UnitPowerType(unitid) == 2 ) and ignorePets ) then
		return false;
	-- Warlock pets
	elseif ( ( ( UnitPlayerControlled(unitid) and not UnitIsPlayer(unitid) ) and UnitPowerType(unitid) == 0 ) and ignoreMinions ) then
		return false;
	-- Enemies tapped by other players
	elseif ( ( UnitIsTapped(unitid) and not UnitIsTappedByPlayer(unitid) ) and ignoreTapped ) then
		return false;
	-- CC'ed targets (sheep/sap/etc)
	elseif ( ignoreCC ) then
		local i = 1;
		while (UnitDebuff(unitid,i)) do
			-- Sap
			if ( string.find(UnitDebuff(unitid, i), "Ability_Sap") ) then
				return false;
			end
			-- Polymorph (should catch Sheep, Pig, and Turtle)
			if ( string.find(UnitDebuff(unitid, i), "Polymorph") or string.find(UnitDebuff(unitid, i), "Ability_Hunter_Pet_Turtle") ) then
				return false;
			end
			-- Seduction (incidentally, this also works for Blind)
			if ( string.find(UnitDebuff(unitid, i), "Spell_Shadow_MindSteal") ) then
				return false;
			end
			-- Shackle - note that this may also detect other effects, but AFAIK they're only used by mobs
			-- and thus in most situations won't be on a desired target.
			if ( string.find(UnitDebuff(unitid, i), "Spell_Nature_Slow") ) then
				return false;
			end
			-- Freezing trap - may have similar behavior to Shackle, not sure.
			if ( string.find(UnitDebuff(unitid, i), "Spell_Frost_ChainsOfIce") ) then
				return false;
			end
			-- Scatter Shot
			if ( string.find(UnitDebuff(unitid, i), "Ability_GolemStormBolt") ) then
				return false;
			end
			-- Banish
			if ( string.find(UnitDebuff(unitid, i), "Shadow_Cripple") ) then
				return false;
			end
			-- Hibernate
			if ( string.find(UnitDebuff(unitid, i), "Spell_Nature_Sleep") ) then
				return false;
			end
			i = i+1;
		end
	end
	return true;
end

-- Help!
function EasyTab_Help()
	DEFAULT_CHAT_FRAME:AddMessage(EASYTAB_HELP1);
	DEFAULT_CHAT_FRAME:AddMessage(EASYTAB_HELP2);
	DEFAULT_CHAT_FRAME:AddMessage(EASYTAB_HELP3);
	DEFAULT_CHAT_FRAME:AddMessage(EASYTAB_HELP4);
	DEFAULT_CHAT_FRAME:AddMessage(EASYTAB_HELP5);
	DEFAULT_CHAT_FRAME:AddMessage(EASYTAB_HELP6);
	DEFAULT_CHAT_FRAME:AddMessage(EASYTAB_HELP7);
	DEFAULT_CHAT_FRAME:AddMessage(EASYTAB_HELP8);
	DEFAULT_CHAT_FRAME:AddMessage(EASYTAB_HELP9);
end

-- Blatantly robbed from www.wowwiki.com - thanks!
function EasyTab_GetCmd(msg)
	if msg then
 		local a,b,c=strfind(msg, "(%S+)"); --contiguous string of non-space characters
 		if a then
 			return c, strsub(msg, b+2);
 		else	
 			return "";
 		end
 	end
end