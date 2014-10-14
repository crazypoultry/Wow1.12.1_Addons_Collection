
-------------------------------------------------------------------------------
-- WoW constants. Items based on the way that wow does things.
-------------------------------------------------------------------------------
HateMe_MAXDEBUFFS   = 16;
HateMe_MAXBUFFS     = 16;
HateMe_START_SLOT   = 1;
HateMe_END_SLOT     = 120;
HateMe_OFFHAND_SLOT = 17;

HateMe_Debug_Flag = false;
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- variables/contants we use internally.
-------------------------------------------------------------------------------
BINDING_HEADER_HateMe = "Hate Me!"; -- this can not be local... key binding!
local HateMe_VERSION_STRING = GetAddOnMetadata("HateMe", "Title").." "..GetAddOnMetadata("HateMe", "Version").." by "..GetAddOnMetadata("HateMe", "Author");
local HateMe_MACRO_COMMAND  = "/HateMe";
local HateYou_MACRO_COMMAND	= "/HateYou";

local HateMe_MelleeMode = false;
local HateMe_CurrentForm = nil;

-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- global variables
-------------------------------------------------------------------------------

HateMe_Default = {
	["ExecuteBonusRage"]	= 10, -- default for how much extra rage to store up for execute
	["Rend"]				= true,
	["Taunt"]				= true,
	["Sunder"]				= false,
	["HSBetween"]			= false,
	["BattleShout"]			= true,
	["ImmuneCheck"]			= true,
	["TestMode"]			= false,
}


HateMe_ShieldBlockAdvance   = 1; -- how many seconds before revenge is ready to use the block

HateMe_SunderMaxCount       = 5;

HateMe_Bloodrage_MinHealth  = 0.5;
HateMe_BloodRage_MinRage    = 30;

HateMe_SpellCooldownLag     = 0.5;

HateMe_SpellBook = nil;
HateMe_RageCost = nil;
HateMe_FunctionLinks = { };
HateMe_SpellTextureCache = nil;

HateMe_Type = nil;

-------------------------------------------------------------------------------



-- this is the spells that we can cast
HateMe_SpellToCast = {
	[HateMe_SPELL_REVENGE]				= true,
	[HateMe_SPELL_OVERPOWER]          	= true,
	[HateMe_SPELL_EXECUTE]            	= true,
	[HateMe_SPELL_BERSERKER_RAGE]     	= true,
	[HateMe_SPELL_BATTLE_SHOUT]       	= true,
	[HateMe_SPELL_PUMMEL]             	= true,
	[HateMe_SPELL_SHIELD_BASH]        	= true,
	[HateMe_SPELL_CONCUSSION_BLOW]    	= true,
	[HateMe_SPELL_MORTAL_STRIKE]      	= true,
	[HateMe_SPELL_REND]               	= true,  -- This value is overwritten by HateMe_Settings[HateMe_SPELL_REND] or HateMe_Default["Rend"].
	[HateMe_SPELL_WHIRLWIND]          	= true,
	[HateMe_SPELL_SHIELD_BLOCK]       	= true,
	[HateMe_SPELL_SUNDER_ARMOR]       	= true,
	[HateMe_SPELL_MOCKING_BLOW]       	= true,  -- This value is overwritten by HateMe_Settings[HateMe_SPELL_TAUNT] or HateMe_Default["Taunt"].
	[HateMe_SPELL_TAUNT]              	= true,  -- This value is overwritten by HateMe_Settings[HateMe_SPELL_TAUNT] or HateMe_Default["Taunt"].
	[HateMe_SPELL_HEROIC_STRIKE]      	= true,
	[HateMe_SPELL_DEMORALIZING_SHOUT] 	= true,
	[HateMe_SPELL_BLOODRAGE]          	= true,
	[HateMe_SPELL_CLEAVE]             	= true,
	[HateMe_SPELL_THUNDER_CLAP]       	= true,
	[HateMe_SPELL_HAMSTRING]          	= true,
	[HateMe_SPELL_SWEEPING_STRIKES]   	= true,
	[HateMe_SPELL_SLAM]               	= true,
	[HateMe_SPELL_BLOODTHIRST]        	= true,
	[HateMe_SPELL_PIERCING_HOWL]      	= true,
	[HateMe_SPELL_SHIELD_SLAM]        	= true,
	[HateMe_SPELL_RAKE]   	          	= true,
    [HateMe_SPELL_SHRED]       	      	= true,
    [HateMe_SPELL_RIP]                  = true,
	[HateMe_SPELL_TIGER_FURY]         	= true,
	[HateMe_SPELL_CLAW]               	= true,
	[HateMe_SPELL_FAERIE_FIRE_BEAR]   	= true,
	[HateMe_SPELL_BASH]               	= true,
	[HateMe_SPELL_SWIPE]              	= true,
	[HateMe_SPELL_GROWL]              	= true,  -- This value is overwritten by HateMe_Settings[HateMe_SPELL_TAUNT] or HateMe_Default["Taunt"].
	[HateMe_SPELL_MAUL]               	= true,
	[HateMe_SPELL_DEMORALIZING_ROAR]  	= true,
	[HateMe_SPELL_ENRAGE]               = true,
	[HateMe_CAT]						= true,
	[HateMe_BEAR1]                  	= true,
	[HateMe_BEAR2]                  	= true,
}

HateMe_SpellsForFree = {
	[HateMe_SPELL_TAUNT]              	= true,
	[HateMe_SPELL_GROWL]              	= true,
	[HateMe_SPELL_BLOODRAGE]          	= true,
	[HateMe_SPELL_ENRAGE]               = true,
}





-------------------------------------------------------------------------------
-- setup and configuration function
-------------------------------------------------------------------------------
function HateMe_Init()
	local playerClass;
	_, playerClass = UnitClass("player");

	HateMe_println(HateMe_VERSION_STRING);

	-- Register our slash commands
	SLASH_HateMe1 = HateMe_MACRO_COMMAND;
	SlashCmdList["HateMe"] = function(msg)
		HateMe_Commands(msg);
	end
	SLASH_HateYou1 = HateYou_MACRO_COMMAND;
	SlashCmdList["HateYou"] = function(msg)
		HateYou_Commands(msg);
	end

	HateMe_Configure();
end

function HateYou_Commands(msg)
	if( msg ) then
		local command = string.lower(msg);

		if( command == "" ) then
			HateMe_FeelTheHate("HateYou");
		else
			HateMe_Setting_Commands(command);
		end
	end
end

function HateMe_Commands(msg)
	if( msg ) then
		local command = string.lower(msg);

		if( command == "" ) then
			HateMe_FeelTheHate("HateMe");
		else
			HateMe_Setting_Commands(command);
		end
	end
end



-- this is a debug function only... this is for internal testing!
-- this is called with "/script HateMe_DEBUG_PrintSpells();"
function HateMe_DEBUG_PrintSpells()
	if (HateMe_SpellBook) then
		for name, spellindex in HateMe_SpellBook do
			local spellName = GetSpellName(spellindex, BOOKTYPE_SPELL);
			if (spellName ~= name) then
				HateMe_debug( "Spell "..name.." does not match "..spellName);
			else
				HateMe_debug( "Spell found "..name.." - "..spellindex);
			end
		end
	else
		HateMe_debug( "no spells");
	end
end
-------------------------------------------------------------------------------


function HateMe_Settings_Config()
	if not HateMe_Settings then
		HateMe_Settings = { };
	end

	if not HateMe_Immunity then
		HateMe_Immunity = { };
	end

	if not HateMe_Runners then
		HateMe_Runners = { };
	end

	if HateMe_Settings[HateMe_SPELL_EXECUTE.." bonus rage"] == nil then
		HateMe_Settings[HateMe_SPELL_EXECUTE.." bonus rage"] = HateMe_Default["ExecuteBonusRage"];
	end
	HateMeConfigSliderExecute:SetValue(HateMe_Settings[HateMe_SPELL_EXECUTE.." bonus rage"]);
	HateMeConfigSliderExecuteText:SetText(HateMe_SPELL_EXECUTE.." bonus rage".." : "..HateMe_Settings[HateMe_SPELL_EXECUTE.." bonus rage"]);

	if HateMe_Settings[HateMe_SPELL_REND] == nil then
		HateMe_Settings[HateMe_SPELL_REND] = HateMe_Default["Rend"];
	end
	HateMe_SpellToCast[HateMe_SPELL_REND] = HateMe_Settings[HateMe_SPELL_REND];
	HateMeConfigCheckButtonRend:SetChecked(HateMe_Settings[HateMe_SPELL_REND]);

	if HateMe_Settings[HateMe_SPELL_TAUNT] == nil then
		HateMe_Settings[HateMe_SPELL_TAUNT] = HateMe_Default["Taunt"];
	end
	HateMe_SpellToCast[HateMe_SPELL_TAUNT] = HateMe_Settings[HateMe_SPELL_TAUNT];
	HateMeConfigCheckButtonTaunt:SetChecked(HateMe_Settings[HateMe_SPELL_TAUNT]);
	
	if HateMe_Settings[HateMe_SPELL_SUNDER_ARMOR.." >5"] == nil then
		HateMe_Settings[HateMe_SPELL_SUNDER_ARMOR.." >5"] = HateMe_Default["Sunder"];
	end
	HateMeConfigCheckButtonSunder:SetChecked(HateMe_Settings[HateMe_SPELL_SUNDER_ARMOR.." >5"]);

	if HateMe_Settings[HateMe_SPELL_HEROIC_STRIKE.." between "..HateMe_SPELL_SUNDER_ARMOR] == nil then
		HateMe_Settings[HateMe_SPELL_HEROIC_STRIKE.." between "..HateMe_SPELL_SUNDER_ARMOR] = HateMe_Default["HSBetween"];
	end
	HateMeConfigCheckButtonHSBetween:SetChecked(HateMe_Settings[HateMe_SPELL_HEROIC_STRIKE.." between "..HateMe_SPELL_SUNDER_ARMOR]);

	if HateMe_Settings["Optimize "..HateMe_SPELL_BATTLE_SHOUT.." Threat"] == nil then
		HateMe_Settings["Optimize "..HateMe_SPELL_BATTLE_SHOUT.." Threat"] = HateMe_Default["BattleShout"];
	end
	HateMeConfigCheckButtonBattleShout:SetChecked(HateMe_Settings["Optimize "..HateMe_SPELL_BATTLE_SHOUT.." Threat"]);

	if HateMe_Settings["Immune Check"] == nil then
		HateMe_Immunity = nil;
		HateMe_Immunity = { };
		HateMe_println(HateMe_CLEAR_IMMUNE);
		HateMe_Settings["Immune Check"] = HateMe_Default["ImmuneCheck"];
	end
	HateMeConfigCheckButtonImmune:SetChecked(HateMe_Settings["Immune Check"]);
	
	if HateMe_Settings["Test Mode"] == nil then
		HateMe_Settings["Test Mode"] = HateMe_Default["TestMode"];
	end
	HateMeConfigCheckButtonTestMode:SetChecked(HateMe_Settings["Test Mode"]);

	if HateMe_Settings[HateMe_SPELL_MOCKING_BLOW] ~= nil then
		HateMe_Settings[HateMe_SPELL_MOCKING_BLOW] = nil
	end
	if HateMe_Settings[HateMe_SPELL_GROWL] ~= nil then
		HateMe_Settings[HateMe_SPELL_GROWL] = nil
	end
end

function HateMe_Default_Config()
	HateMe_Settings[HateMe_SPELL_EXECUTE.." bonus rage"] = HateMe_Default["ExecuteBonusRage"];

	HateMe_Settings[HateMe_SPELL_REND] = HateMe_Default["Rend"];
	HateMe_SpellToCast[HateMe_SPELL_REND] = HateMe_Settings[HateMe_SPELL_REND];

	HateMe_Settings[HateMe_SPELL_TAUNT] = HateMe_Default["Taunt"];
	HateMe_SpellToCast[HateMe_SPELL_TAUNT] = HateMe_Settings[HateMe_SPELL_TAUNT];
	
	HateMe_Settings[HateMe_SPELL_SUNDER_ARMOR.." >5"] = HateMe_Default["Sunder"];

	HateMe_Settings[HateMe_SPELL_HEROIC_STRIKE.." between "..HateMe_SPELL_SUNDER_ARMOR] = HateMe_Default["HSBetween"];

	HateMe_Settings["Optimize "..HateMe_SPELL_BATTLE_SHOUT.." Threat"] = HateMe_Default["BattleShout"];

	HateMe_Settings["Immune Check"] = HateMe_Default["ImmuneCheck"];
	
	HateMe_Settings["Test Mode"] = HateMe_Default["TestMode"];

	HateMe_println("Defaults set");
	HateMe_Configure();
end

function HateMe_Configure()
	HateMe_Settings_Config();

	-- clear out the cache and the spell book
	HateMe_SpellBook = nil;
	HateMe_RageCost = nil;
	HateMe_SpellTextureCache = nil;

	local i = 1
	while (true) do
		-- we don't worry about ranks... since the last one listed is always the highest
		local spellName = GetSpellName(i, BOOKTYPE_SPELL);
		if (not spellName) then
			do break end
		end

		if (HateMe_SpellToCast[spellName]) then
			-- it is in our spell book of stuff to care about
			HateMe_debug( " found spell - "..spellName);

			-- setup the texture cache...
			-- this is for finding things faster (overpower, revenge) slot wise
			if (not HateMe_SpellTextureCache) then
				HateMe_SpellTextureCache = { };
			end
			local spellTexture = GetSpellTexture(i, BOOKTYPE_SPELL);
			HateMe_SpellTextureCache[spellName] = spellTexture;


			-- add it to the spellbook
			if (not HateMe_SpellBook) then
				HateMe_SpellBook = { };
			end
			HateMe_SpellBook[spellName] = i;

			-- add it to the ragebook
			if (not HateMe_RageCost) then
				HateMe_RageCost = { };
			end

			if (HateMe_SpellsForFree[spellName]) then
				HateMe_RageCost[spellName] = 0;
			else
				HateMe_Tooltip:ClearLines();
				HateMe_Tooltip:SetSpell(i, BOOKTYPE_SPELL);
				local buffer = HateMe_TooltipTextLeft2:GetText();
				local loc = string.find( buffer, " ");
				if (loc) then
					buffer = string.sub( buffer, 1, loc - 1 );
					HateMe_RageCost[spellName] = tonumber(buffer);
				else
					HateMe_RageCost[spellName] = 0;
				end
			end

		end

		i = i + 1
	end
end


-------------------------------------------------------------------------------
-- Commands
-------------------------------------------------------------------------------

function HateMe_Setting_Commands(command)
	if(command == "status") then
		HateMe_println("HateMe Settings")
		for x in HateMe_Settings do
			if (x == HateMe_SPELL_EXECUTE.." bonus rage") then
				HateMe_println("  "..x.." : "..HateMe_Settings[x])
			else
				if HateMe_Settings[x] then
					HateMe_println("  "..x.." : "..HateMe_ON)
				else
					HateMe_println("  "..x.." : "..HateMe_OFF)
				end
			end
		end

	elseif(command == "config" or command == "settings" or command == "options") then
		HateMeConfig:Show();

	elseif(string.sub(command,1,7) == "execute") then
		HateMe_Change_Execute(string.sub(command,9));

	elseif(string.sub(command,1,4) == "rend") then
		HateMe_Change_Rend(string.sub(command,6));

	elseif(string.sub(command,1,5) == "taunt") then
		HateMe_Change_Taunt(string.sub(command,7));

	elseif(string.sub(command,1,6) == "sunder") then
		HateMe_Change_Sunder(string.sub(command, 8));

	elseif(string.sub(command,1,2) == "hs") then
		HateMe_Change_HSBetween(string.sub(command,4));

	elseif(string.sub(command,1,2) == "bs") then
		HateMe_Change_BattleShout(string.sub(command,4));

	elseif(string.sub(command,1,6) == "immune") then
		HateMe_Change_Immune(string.sub(command,8));

	elseif(string.sub(command,1,4) == "test") then
		HateMe_Change_TestMode(string.sub(command,6));

	elseif(command == "clear") then
		HateMe_Clear();
	else
		HateMe_println(HateMe_MACRO_ERROR);
	end
end


-------------------------------------------------------------------------------
-- Setting Changes
-------------------------------------------------------------------------------

function HateMe_Change_Execute(state)
	if ((state * 1) >= 0 and (state * 1) <= 50) then
		HateMe_Settings[HateMe_SPELL_EXECUTE.." bonus rage"] = (state * 1)
		HateMeConfigSliderExecuteText:SetText(HateMe_SPELL_EXECUTE.." bonus rage".." : "..HateMe_Settings[HateMe_SPELL_EXECUTE.." bonus rage"]);
		--HateMe_println(HateMe_SPELL_EXECUTE.." bonus rage : "..state)
	else
		HateMe_println(HateMe_MACRO_ERROR);
	end
end

function HateMe_Change_Rend(state)
	if(state == "1" or state ==  HateMe_ON) then
 		HateMe_SpellToCast[HateMe_SPELL_REND] = true;
		HateMe_Settings[HateMe_SPELL_REND] = true;
		HateMe_println(HateMe_REND_ON)
		HateMe_Configure();
	elseif(state == "0" or state == HateMe_OFF) then
		HateMe_SpellToCast[HateMe_SPELL_REND] = false;
		HateMe_Settings[HateMe_SPELL_REND] = false;
		HateMe_println(HateMe_REND_OFF)
		HateMe_Configure();
	else
		HateMe_println(HateMe_MACRO_ERROR);
	end
end

function HateMe_Change_Taunt(state)
	if(state == "1" or state ==  HateMe_ON) then
		HateMe_Settings[HateMe_SPELL_TAUNT] = true;

		HateMe_SpellToCast[HateMe_SPELL_TAUNT] = true;
		HateMe_SpellToCast[HateMe_SPELL_MOCKING_BLOW] = true;
		HateMe_SpellToCast[HateMe_SPELL_GROWL] = true;

		HateMe_println(HateMe_TAUNT_ON)
		HateMe_Configure();
	elseif(state == "0" or state == HateMe_OFF) then
		HateMe_Settings[HateMe_SPELL_TAUNT] = false;

		HateMe_SpellToCast[HateMe_SPELL_TAUNT] = false;
		HateMe_SpellToCast[HateMe_SPELL_MOCKING_BLOW] = false;
		HateMe_SpellToCast[HateMe_SPELL_GROWL] = false;

		HateMe_println(HateMe_TAUNT_OFF)
		HateMe_Configure();
	else
		HateMe_println(HateMe_MACRO_ERROR);
	end
end

function HateMe_Change_Sunder(state)
	if(state == "5" or state == "=5" or state ==  HateMe_OFF or state == "0") then
		HateMe_Settings[HateMe_SPELL_SUNDER_ARMOR.." >5"] = false;
		HateMe_println(HateMe_SUNDER_OFF)
		HateMe_Configure();
	elseif(state == ">5" or state == "more" or state ==  HateMe_ON or state == "1") then
		HateMe_Settings[HateMe_SPELL_SUNDER_ARMOR.." >5"] = true;
		HateMe_println(HateMe_SUNDER_ON)
		HateMe_Configure();
	else
		HateMe_println(HateMe_MACRO_ERROR);
	end
end

function HateMe_Change_HSBetween(state)
	if(state == "between" or state ==  HateMe_ON or state == "1") then
		HateMe_Settings[HateMe_SPELL_HEROIC_STRIKE.." between "..HateMe_SPELL_SUNDER_ARMOR] = true;
		HateMe_println(HateMe_HS_ON);
		HateMe_Configure();
	elseif(state == "after" or state ==  HateMe_OFF or state == "0") then
		HateMe_Settings[HateMe_SPELL_HEROIC_STRIKE.." between "..HateMe_SPELL_SUNDER_ARMOR] = false;
		HateMe_println(HateMe_HS_OFF);
		HateMe_Configure();
	else
		HateMe_println(HateMe_MACRO_ERROR);
	end
end

function HateMe_Change_BattleShout(state)
	if(state ==  HateMe_ON or state == "1") then
		HateMe_Settings["Optimize "..HateMe_SPELL_BATTLE_SHOUT.." Threat"] = true;
		HateMe_println(HateMe_BS_ON);
		HateMe_Configure();
	elseif(state ==  HateMe_OFF or state == "0") then
		HateMe_Settings["Optimize "..HateMe_SPELL_BATTLE_SHOUT.." Threat"] = false;
		HateMe_println(HateMe_BS_OFF);
		HateMe_Configure();
	else
		HateMe_println(HateMe_MACRO_ERROR);
	end
end

function HateMe_Change_Immune(state)
	if(state ==  HateMe_ON or state == "1") then
		HateMe_Settings["Immune Check"] = true;
		HateMe_println(HateMe_IMMUNE_ON);
		HateMe_Configure();
	elseif(state ==  HateMe_OFF or state == "0") then
		HateMe_Settings["Immune Check"] = false;
		HateMe_println(HateMe_IMMUNE_OFF);
		HateMe_Configure();
	else
		HateMe_println(HateMe_MACRO_ERROR);
	end
end

function HateMe_Change_TestMode(state)
	if(state ==  HateMe_ON or state == "1") then
		HateMe_Settings["Test Mode"] = true;
		HateMe_println(HateMe_TEST_ON);
		HateMe_Configure();
	elseif(state ==  HateMe_OFF or state == "0") then
		HateMe_Settings["Test Mode"] = false;
		HateMe_println(HateMe_TEST_OFF);
		HateMe_Configure();
	else
		HateMe_println(HateMe_MACRO_ERROR);
	end
end

function HateMe_Clear()
		HateMe_Immunity = nil;
		HateMe_Immunity = { };
		HateMe_println(HateMe_CLEAR_IMMUNE);
		HateMe_Runners = nil;
		HateMe_Runners = { };
		HateMe_println(HateMe_CLEAR_RUNNERS);
end
