SMARTPET_VERSION = "2.5.2b";

-- KeyBinding Info
BINDING_HEADER_SMARTPET = "SmartPet";
BINDING_NAME_OPTIONSMENU = SMARTPET_BINDING_NAME_OPTIONSMENU;
BINDING_NAME_TOGGLETAUNT = SMARTPET_BINDING_NAME_TOGGLETAUNT;
BINDING_NAME_CHASETOGGLE = SMARTPET_BINDING_NAME_CHASETOGGLE;
BINDING_NAME_SCATTERSHOT = SMARTPET_BINDING_NAME_SCATTERSHOT;
BINDING_NAME_THEBUTTON = SMARTPET_BINDING_NAME_THEBUTTON;
BINDING_NAME_FEEDPET = SMARTPET_BINDING_NAME_FEEDPET;

-- Config Options
SmartPet_Config = {};

-- General Variables
SmartPet_Vars = {};
SmartPet_Vars.Class = nil;		--What is the player's class
SmartPet_Vars.MainAction = "";		--Main Action for pet to use (Growl/Cower)
SmartPet_Vars.InCombat = false;		--Is pet in combat
SmartPet_Vars.InPVP = false;		--Is combat PVP
SmartPet_Vars.UseTaunt = false;		--Useing Growl
SmartPet_Vars.Detaunt = false;		--Useing Cower
SmartPet_Vars.AutoCower = false;	--Useing Autocower
SmartPet_Vars.LastDetauntWarning = 0;	--Keep track of the time when the last detaunt warning is being shown
SmartPet_Vars.LastHealthWarning = 0;
SmartPet_Vars.LastHealthPercent = 0;
SmartPet_Vars.CombatStartTime = 0;
SmartPet_Vars.Party = {};		--Storage for party info
SmartPet_Vars.PetSkills = {};		--Storage for pet skill info
SmartPet_Vars.PickedUp_Spell = "";	--Index of spell picked up from spell book
SmartPet_Vars.PickedUp_SpellBook = "";	--Name of spell book that spell was picked up from
SmartPet_Vars.CursorItem = { bag = 0, slot = 0 }; -- Item in cursor picked up from container
SmartPet_Vars.TheButton = "";		--What should "The Button" do when pressed
SmartPet_Vars.LastAttack = 0;
SmartPet_Vars.FocusManager = 0;		--variable is used to determine how much time is left in pet skill the cooldown 
SmartPet_Vars.CurrentFocusTime = 0;
SmartPet_Vars.NextFocusTime = 0;
SmartPet_Vars.PetFocus1 = 100;
SmartPet_Vars.PetFocus2 = 100;

-- Debug Variables
SmartPet_Vars.FirstAttackTime = 0;
SmartPet_Vars.LastAttackTime = 0;
SmartPet_Vars.SpellDamage = 0;
SmartPet_Vars.SimSpellDamage = 0;

-- Local Variables
--Pre_SmartPet_PetAttack;
local Pre_SmartPet_CastPetAction;
local Pre_SmartPet_ShowUIPanel;
local Pre_SmartPet_PickupSpell;
local Pre_SmartPet_PickupContainerItem;
local SP_CFG = nil;


-- Pet Abilities
SmartPet_Actions = {};
SmartPet_Actions["Attack"] = { name = "PET_ACTION_ATTACK", id = 0};
SmartPet_Actions["Taunt"] = { name = SMARTPET_ACTIONS_GROWL, id = 0, index = 0, cost = 15, lastTime = 0} ;
SmartPet_Actions["Detaunt"] = { name = SMARTPET_ACTIONS_COWER, id = 0, index = 0, cost = 15, lastTime = 0 };
SmartPet_Actions["Burst"] = { name = SMARTPET_ACTIONS_CLAW, id = 0, index = 0, cost = 25, lastTime = 0 };
SmartPet_Actions["Sustain"] = { name = SMARTPET_ACTIONS_BITE, id = 0, index = 0, cost = 35, lastTime = 0 };
SmartPet_Actions["Nochase"] = { name = SMARTPET_ACTION_NOCHASE, id = 0, index = 0, cost = 0, lastTime = 0 };
SmartPet_Actions["Dash"] = { name = SMARTPET_ACTION_DASH, id = 0, index = 0, cost = 20, lastTime = 0 };
SmartPet_Actions["Dive"] = { name = SMARTPET_ACTION_DIVE, id = 0, index = 0, cost = 20, lastTime = 0 };

-- Slash Commands are in Localization file
-- Misc
SMARTPET_FOCUSREGEN = 5;

-- ==[Function Hooks]==

--Modified to catch casting attack from the PetAction Bar and use modifed pet attack
function SmartPet_CastPetAction(id)
	SmartPet_AddDebugMessage(id, "spew");
	if (id  == SmartPet_Actions["Attack"].id ) then
		PetAttack();
	else
		Pre_SmartPet_CastPetAction(id);
	end
end

--Modified to record Spell id and Spell book Type when picking up a spell from the spell book
function SmartPet_PickupSpell(id, bookType)
	Pre_SmartPet_PickupSpell(id, bookType);	
	SmartPet_Vars.PickedUp_Spell = id;
	SmartPet_Vars.PickedUp_SpellBook = bookType;
end

--Modified to record item id and bag when picking up a food from the inventory
function SmartPet_PickupContainerItem(bag, slot)
	
	Pre_SmartPet_PickupContainerItem(bag, slot);

	if (CursorHasItem()) then
		SmartPet_Vars.CursorItem = { bag = bag, slot = slot};
	else
		-- If the selected Food is moved to another slot in the bag, update the configuration
		if (SmartPet_Config.Food.bag == SmartPet_Vars.CursorItem.bag and 
		    SmartPet_Config.Food.slot == SmartPet_Vars.CursorItem.slot and
		    (SmartPet_Config.Food.bag ~= bag or SmartPet_Config.Food.slot ~= slot)) then
			SmartPet_Config.Food.bag = bag;
			SmartPet_Config.Food.slot = slot;
		end
		SmartPet_ClearCursorItem();
	end
end

-- Modifies UI To display checkboxes on pet spell book
function SmartPet_ShowUIPanel(frame, force)
	Pre_SmartPet_ShowUIPanel(frame, force);
	SmartPet_PetSkillsLoad();
end

--Pet Attack Hook. Modifies the default PetAttack() function for added functionality 
--See SmartPetAttack.lua


--==[Handlers]==

-- Load Handler
function SmartPet_OnLoad()
	this:RegisterEvent("UNIT_FOCUS");
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("CHAT_MSG_SPELL_PET_DAMAGE");
	this:RegisterEvent("CHAT_MSG_MONSTER_EMOTE");
	this:RegisterEvent("PET_ATTACK_START");
	this:RegisterEvent("PET_ATTACK_STOP");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PET_BAR_UPDATE");
	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("PET_UI_UPDATE");
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS");
	this:RegisterEvent("PLAYER_DEAD");
	this:RegisterEvent("UNIT_COMBAT");

	SmartPet_ResetConfig();

	Pre_SmartPet_PetAttack = PetAttack;
	PetAttack = SmartPet_Attack;

	Pre_SmartPet_CastPetAction = CastPetAction;
	CastPetAction = SmartPet_CastPetAction;

	Pre_SmartPet_PickupSpell = PickupSpell;
	PickupSpell = SmartPet_PickupSpell;
	
	Pre_SmartPet_PickupContainerItem = PickupContainerItem;
	PickupContainerItem = SmartPet_PickupContainerItem;

	Pre_SmartPet_ShowUIPanel = ShowUIPanel;
	ShowUIPanel = SmartPet_ShowUIPanel;

	SLASH_SMARTPET1 = "/smartpet";
	SLASH_SMARTPET2 = "/sp";
	SlashCmdList["SMARTPET"] = function(msg)
	SmartPet_OnSlashCommand(msg);
	end

	SmartPet_AddInfoMessage(string.gsub(SMARTPET_VERSION_RUNNING, '%%v', SMARTPET_VERSION));
end

-- Slash Command Handler
function SmartPet_OnSlashCommand(msg)

	if (not msg) then
		return;
	end

	if ( SmartPet_Config.AcceptedClass == false ) then
		SmartPet_AddInfoMessage(SMARTPET_ONLY_FOR_HUNTER);
		return;
	end

	local command = string.lower(msg);

if ((SmartPet_Vars.Class == "HUNTER") or (SmartPet_Vars.Class == "WARLOCK")) then
	-- Enable/Disable the SmartPet AddOn
	if (command == SMARTPET_ENABLE or command == SMARTPET_ON) then
		SmartPet_Config.Enabled = true;
		SmartPet_AddInfoMessage(SMARTPET_COMMANDS_SMARTPET_ENABLED);
	elseif (command == SMARTPET_DISABLE or command == SMARTPET_OFF  ) then
		SmartPet_Config.Enabled = false;
		SmartPet_AddInfoMessage(SMARTPET_COMMANDS_SMARTPET_DISABLED);

	-- Enable/Disable Mouse Over Tooltips
	elseif (strsub(command, 1, strlen(SMARTPET_TOOLTIPS)) == SMARTPET_TOOLTIPS) then
		if (SmartPet_Config.ToolTips) then
			SmartPet_Config.ToolTips = false;
			SmartPet_AddInfoMessage(SMARTPET_COMMANDS_TOOLTIPS_DISABLED);
		else
			SmartPet_Config.ToolTips = true;
			SmartPet_AddInfoMessage(SMARTPET_COMMANDS_TOOLTIPS_ENABLED);
		end

	-- Health Warning
	elseif (strsub(command, 1, strlen(SMARTPET_AUTOWARN )) == SMARTPET_AUTOWARN  ) then
		if (SmartPet_ToggleOption(command, SmartPet_Config.AutoWarn)) then
			SmartPet_Config.AutoWarn = true;
			SmartPet_AddInfoMessage(SMARTPET_COMMANDS_AUTOWARN_ENABLED);
		else
			SmartPet_Config.AutoWarn = false;
			SmartPet_AddInfoMessage(SMARTPET_COMMANDS_AUTOWARN_DISABLED);
		end

	-- Health Warning Channel
	elseif (strsub(command, 1, strlen(SMARTPET_CHANNEL)) == SMARTPET_CHANNEL ) then
		if (strfind(command, "party")) then
			SmartPet_Config.Channel = "party";
		elseif (strfind(command, "say")) then
			SmartPet_Config.Channel = "say";
		elseif (strfind(command, "guild")) then
			SmartPet_Config.Channel = "guild";
		else
	        firsti, lasti, value = strfind(command, "(%d+)");
	        if (value) then
	        	SmartPet_Config.ChannelNumber = tonumber(value);
			SmartPet_Config.Channel = "channel";
	        else
	        	SmartPet_Config.Channel = "say";
	        end
		end
		SmartPet_AddInfoMessage(string.gsub(SMARTPET_COMMANDS_CHANNEL, '%%c', SmartPet_Config.Channel));

	-- Health Warning Threshold
	elseif (strsub(command, 1, strlen(SMARTPET_WARNHEALTH)) == SMARTPET_WARNHEALTH ) then
        firsti, lasti, value = strfind(command, "(%d+)");
        if (value) then
        	SmartPet_Config.WarnHealth = tonumber(value);
    	else
    		SmartPet_Config.WarnHealth = 30;
    	end
		SmartPet_AddInfoMessage(string.gsub(SMARTPET_COMMANDS_WARNHEALTH, '%%h', SmartPet_Config.WarnHealth));

	-- No Chase
	elseif (strsub(command, 1, strlen(SMARTPET_NOCHASE)) == SMARTPET_NOCHASE ) then
		if (SmartPet_Config.NoChase) then
			SmartPet_Config.NoChase = false;
			SmartPet_AddInfoMessage(SMARTPET_COMMANDS_NOCHASE_DISABLED);
		else
			PetFollow();
			SmartPet_Config.NoChase = true;
			SmartPet_AddInfoMessage(SMARTPET_COMMANDS_NOCHASE_ENABLED);
		end

			-- Debug Text
	elseif (strsub(command, 1, 9) == SMARTPET_SHOWDEBUG) then
		if (command == SMARTPET_SHOWDEBUG) then
			SmartPet_Config.ShowDebug = false;
			SmartPet_AddInfoMessage(SMARTPET_COMMANDS_SHOWDEBUG_DISABLED);
		else
			SmartPet_Config.ShowDebug = true;
			SmartPet_Config.ShowDebugString = command;
			SmartPet_AddInfoMessage(SMARTPET_COMMANDS_SHOWDEBUG_ENABLED);
		end

	elseif ((SmartPet_Vars.Class == "HUNTER") and (SmartPet_Vars.Class ~= "WARLOCK")) then
	
	-- Focus Management
	if (strsub(command, 1, strlen(SMARTPET_SMARTFOCUS )) == SMARTPET_SMARTFOCUS  ) then
		if (SmartPet_ToggleOption(command, SmartPet_Config.SmartFocus)) then
			SmartPet_Config.SmartFocus = true;
			SmartPet_AddInfoMessage(SMARTPET_COMMANDS_SMARTFOCUS_ENABLED);
		else
			SmartPet_Config.SmartFocus = false;
			SmartPet_AddInfoMessage(SMARTPET_COMMANDS_SMARTFOCUS_DISABLED);
		end


	-- Cower Mode
	elseif (strsub(command, 1, strlen(SMARTPET_AUTOCOWER)) == SMARTPET_AUTOCOWER ) then
		if (SmartPet_Config.AutoCower) then
			SmartPet_Config.AutoCower = false;
			SmartPet_AddInfoMessage(SMARTPET_COMMANDS_AUTOCOWER_DISABLED);
		else
			SmartPet_Config.AutoCower = true;
			SmartPet_AddInfoMessage(SMARTPET_COMMANDS_AUTOCOWER_ENABLED);
		end

	--Auto Cower Threshold
	elseif (strsub(command, 1, strlen(SMARTPET_COWERHEALTH)) == SMARTPET_COWERHEALTH ) then
		firsti, lasti, value = strfind(command, "(%d+)");
		if (value) then
        		SmartPet_Config.CowerHealth = tonumber(value);
    		else
    			SmartPet_Config.CowerHealth = 30;
    		end
		SmartPet_AddInfoMessage(string.gsub(SMARTPET_COMMANDS_COWERHEALTH, '%%h', SmartPet_Config.CowerHealth));
	
	-- Auto Feed
	elseif (strsub(command, 1, strlen(SMARTPET_AUTOFEED)) == SMARTPET_AUTOFEED ) then
		SmartPet_ToggleAutoFeed();

	-- Feed Pet
	elseif (command == SMARTPET_FEED) then
		SmartPet_Feed();

	--Options gui
	elseif (command == "options") then
		SmartPet_Options_Toggle();

			--Options gui
	elseif (command == "show") then
		--SmartPetDefendOptionsFrame:Show();

	--resets config to deal with not huntter error
	elseif (command == "reset") then
		SmartPet_ResetConfig();



	-- Help Text
	elseif (command == SMARTPET_HELP) then
		SmartPet_AddInfoMessage(SMARTPET_HELP_TITLE);
		SmartPet_AddHelpMessage(SMARTPET_HELP_TAUNTMAN1,SMARTPET_HELP_TAUNTMAN2);
		SmartPet_AddHelpMessage(SMARTPET_HELP_SMARTFOCUS1,SMARTPET_HELP_SMARTFOCUS2);
		SmartPet_AddHelpMessage(SMARTPET_HELP_AUTOHEALTH1,SMARTPET_HELP_AUTOHEALTH2);
		SmartPet_AddHelpMessage(SMARTPET_HELP_AUTOCOWER1,SMARTPET_HELP_AUTOCOWER2);

	
	-- Typos and Default

	 elseif (command == "show") then
		DEFAULT_CHAT_FRAME:AddMessage(" ");
		SmartPet_AddInfoMessage("SmartPet Status:");
		DEFAULT_CHAT_FRAME:AddMessage(COLOR_GREEN.."Use "..COLOR_CLOSE..COLOR_WHITE.."/smartpet <command> "..COLOR_CLOSE..COLOR_GREEN.."or "..COLOR_CLOSE..COLOR_WHITE.."/sp <command> "..COLOR_CLOSE..COLOR_GREEN.."to perform the following commands:"..COLOR_CLOSE);
		SmartPet_AddHelpMessage(SMARTPET_ENABLE.."|"..SMARTPET_DISABLE, SMARTPET_USAGE_SMARTPET, nil, SmartPet_Config.Enabled);
		SmartPet_AddHelpMessage(SMARTPET_SMARTFOCUS, SMARTPET_USAGE_SMARTFOCUS, nil, SmartPet_Config.SmartFocus);
		SmartPet_AddHelpMessage(SMARTPET_AUTOWARN, SMARTPET_USAGE_AUTOWARN, nil, SmartPet_Config.AutoWarn);
		SmartPet_AddHelpMessage(SMARTPET_WARNHEALTH .. " " .. SMARTPET_USAGE_PERCENT, SMARTPET_USAGE_WARNHEALTH, "("..SmartPet_Config.WarnHealth.."%)", SmartPet_Config.AutoWarn);
		SmartPet_AddHelpMessage(SMARTPET_CHANNEL.." <say|party|guild|#>", SMARTPET_USAGE_CHANNEL, "("..SmartPet_Config.Channel..")", SmartPet_Config.AutoWarn);
		SmartPet_AddHelpMessage(SMARTPET_AUTOCOWER, SMARTPET_USAGE_AUTOCOWER, nil, SmartPet_Config.AutoCower);
		SmartPet_AddHelpMessage(SMARTPET_COWERHEALTH .. " " .. SMARTPET_USAGE_PERCENT, SMARTPET_USAGE_COWERHEALTH, "("..SmartPet_Config.CowerHealth.."%)", SmartPet_Config.AutoCower);
		SmartPet_AddHelpMessage(SMARTPET_NOCHASE, SMARTPET_USAGE_NOCHASE, nil, SmartPet_Config.NoChase);
		SmartPet_AddHelpMessage(SMARTPET_HELP, SMARTPET_USEAGE_HELP, nil, nil);
		SmartPet_AddHelpMessage(SMARTPET_TOOLTIPS, SMARTPET_USAGE_TOOLTIPS, nil, SmartPet_Config.Tooltips);
		DEFAULT_CHAT_FRAME:AddMessage(" ");
		DEFAULT_CHAT_FRAME:AddMessage(COLOR_GREEN.."For example: "..COLOR_CLOSE..COLOR_WHITE.."/smartpet warnhealth 40 "..COLOR_CLOSE..COLOR_GREEN.."will make your pet warn the party when it's health is below 40%."..COLOR_CLOSE);

	else 
	SmartPetOptionsFrame:Show();

	end

	 else  	

	 --[[
		DEFAULT_CHAT_FRAME:AddMessage(" ");
		SmartPet_AddInfoMessage(SMARTPET_WARLOCK_MEMO);
		SmartPet_AddInfoMessage("SmartPet Status:");
		DEFAULT_CHAT_FRAME:AddMessage(COLOR_GREEN.."Use "..COLOR_CLOSE..COLOR_WHITE.."/smartpet <command> "..COLOR_CLOSE..COLOR_GREEN.."or "..COLOR_CLOSE..COLOR_WHITE.."/sp <command> "..COLOR_CLOSE..COLOR_GREEN.."to perform the following commands:"..COLOR_CLOSE);
		SmartPet_AddHelpMessage(SMARTPET_ENABLE.."|"..SMARTPET_DISABLE, SMARTPET_USAGE_SMARTPET, nil, SmartPet_Config.Enabled);
		SmartPet_AddHelpMessage(SMARTPET_AUTOWARN, SMARTPET_USAGE_AUTOWARN, nil, SmartPet_Config.AutoWarn);
		SmartPet_AddHelpMessage(SMARTPET_WARNHEALTH .. " " .. SMARTPET_USAGE_PERCENT, SMARTPET_USAGE_WARNHEALTH, "("..SmartPet_Config.WarnHealth.."%)", SmartPet_Config.AutoWarn);
		SmartPet_AddHelpMessage(SMARTPET_CHANNEL.." <say|party|guild|#>", SMARTPET_USAGE_CHANNEL, "("..SmartPet_Config.Channel..")", SmartPet_Config.AutoWarn);
		SmartPet_AddHelpMessage(SMARTPET_NOCHASE, SMARTPET_USAGE_NOCHASE, nil, SmartPet_Config.NoChase);
		SmartPet_AddHelpMessage(SMARTPET_TOOLTIPS, SMARTPET_USAGE_TOOLTIPS, nil, SmartPet_Config.Tooltips);
		DEFAULT_CHAT_FRAME:AddMessage(" ");
		DEFAULT_CHAT_FRAME:AddMessage(COLOR_GREEN.."For example: "..COLOR_CLOSE..COLOR_WHITE.."/smartpet warnhealth 40 "..COLOR_CLOSE..COLOR_GREEN.."will make your pet warn the party when it's health is below 40%."..COLOR_CLOSE);
	]]
	
	end

end

SmartPet_UpdateActionIcons(true);
end


-- Main Event Handler
function SmartPet_OnEvent()
	if (event == "VARIABLES_LOADED") then 

		-- Add SmartPet to myAddOns addons list
		if(myAddOnsFrame) then
			myAddOnsList.SmartPet = {
				name = "SmartPet",
				description = "Addon to make you pet more useful",
				version = SMARTPET_VERSION,
				category = MYADDONS_CATEGORY_CLASS,
				frame = "SmartPetFrame",
				optionsframe = "SmartPetOptionsFrame"
			};
				--myAddOnsList.SmartPetDefend = {
				--name = "SmartPet Defend",
				--description = "Have your pet defend party members",
				--version = SMARTPET_VERSION,
				--category = MYADDONS_CATEGORY_CLASS,
				--frame = "SmartPetFrame",
				--optionsframe = "SmartPetDefendOptionsFrame"
		--	};
		end

		if (not SP_CFG) then

			if (not SmartPet_Player_Config) then
				SmartPet_Player_Config = {};
			end

			profile = UnitName("player").." of "..GetCVar("RealmName");

			if (not SmartPet_Player_Config[profile]) then
				SmartPet_Player_Config[profile] = {['SP_Config'] = SmartPet_Config};
				--SmartPet_ResetConfig();
			end
			SP_CFG = SmartPet_Player_Config[profile];
			SmartPet_Config = SP_CFG.SP_Config ;
		end

		--Version Check
		if (not SmartPet_Config.Version or SmartPet_Config.Version ~= SMARTPET_VERSION) then
			SmartPet_AddInfoMessage(SMARTPET_VERSION_CHANGED);
			SmartPet_ResetConfig();
		end

		--RegisterForSave("SmartPet_Config");
		SmartPet_UpdateActionIcons(false);

		if (not SmartPet_Config.Enabled) then
			return;
		end
		
		if (SmartPet_Config.Icon == true) then
			SmartPetOptionButton:Show();
		else
			SmartPetOptionButton:Hide();
		end
	
		if (not SmartPet_Vars.Class) then
			if ((UnitName("player")) and (UnitName("player") ~= "") and (UnitName("player") ~= UNKNOWNOBJECT) and (UnitName("player") ~= UKNOWNBEING)) then
				local localizedClass, englishClass = UnitClass("player");
				if ((localizedClass) and (englishClass)) then
					if (englishClass ~= "") then
						SmartPet_Vars.Class = englishClass;
					end
				end
			end
		end

		if (not SmartPet_Vars.Class) then
			return;
		end

-- Below we can be sure our unit is loaded and we have a class set!
	--Checks to see if player is a class that can use SmartPet.
		SmartPet_AddDebugMessage("Class is " .. SmartPet_Vars.Class, "spew");
		if (SmartPet_Vars.Class == "HUNTER") then
			SmartPet_Config.AcceptedClass = true;
		elseif (SmartPet_Vars.Class == "WARLOCK") then
			SmartPet_Config.AcceptedClass = true;
		else
			SmartPet_Config.AcceptedClass = false;
		end

		if  (SmartPet_Vars.Class == "WARLOCK") then
			SmartPet_Config.ToolTips = false;
			SmartPet_Config.TauntMan = false;
			SmartPet_Config.SmartFocus = false;
			SmartPet_Config.AutoCower = false;
			SmartPet_Config.UseTaunt = false;
			SmartPet_Config.UseDetaunt = false;
			SmartPet_Config.UseBurst = false;
			SmartPet_Config.UseSustain = false;
			SmartPet_Config.RushAttack = false;
			SmartPet_Config.Scatter = false;
			SmartPet_AddInfoMessage(SMARTPET_WARLOCK_MEMO);
		end


	--Unregister events if our class is not a hunter so we don't generate any overhead.
		if (SmartPet_Config.AcceptedClass == false) then
			this:UnregisterEvent("UNIT_FOCUS");
			this:UnregisterEvent("UNIT_HEALTH");
			this:UnregisterEvent("CHAT_MSG_SPELL_PET_DAMAGE");
			this:UnregisterEvent("CHAT_MSG_MONSTER_EMOTE");
			this:UnregisterEvent("PET_ATTACK_START");
			this:UnregisterEvent("PET_ATTACK_STOP");
			this:UnregisterEvent("VARIABLES_LOADED");
			this:UnregisterEvent("PET_BAR_UPDATE");
			this:UnregisterEvent("UNIT_NAME_UPDATE");
			this:UnregisterEvent("PET_UI_UPDATE");
			this:UnregisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
			this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
			this:UnregisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS");
			this:UnregisterEvent("PLAYER_DEAD");
			return;
		end
	end
 
	if (event == "PET_UI_UPDATE") then
		SmartPet_PetSkillsLoad();
	end

	if (event == "PET_BAR_UPDATE") then
		SmartPet_UpdateActionIcons(false);
		SmartPet_PetSkillsLoad();
	end

	if (event == "PET_ATTACK_START") then
		SmartPet_InitActions();
		SmartPet_Vars.inCombat = true;
		SmartPet_Vars.CombatStartTime = GetTime();
		SmartPet_Vars.LastHealthPercent = (100 * UnitHealth("pet") / UnitHealthMax("pet"));
		SmartPet_Vars.TheButton = "";
		-- Debug Variables
		SmartPet_Vars.FirstAttackTime = 0;
		SmartPet_Vars.LastAttackTime = 0;
		SmartPet_Vars.SpellDamage = 0;
		SmartPet_Vars.SimSpellDamage = 0;
	end

	if ((event == "PET_ATTACK_STOP") or (event == "PLAYER_DEAD"))then
		SmartPet_Vars.inCombat = false;
		--SmartPetDefend_Vars.MemberAssisting = "";
		if (SmartPet_Vars.InPVP) then
			SmartPet_EndPVP();
		end
		SmartPet_Vars.TheButton = "";
		SmartPet_SetActionByUse("Taunt", SmartPet_Config.UseTaunt);
		SmartPet_SetActionByUse("Detaunt", SmartPet_Config.UseDetaunt);
		SmartPet_SetActionByUse("Burst", SmartPet_Config.UseBurst);
		SmartPet_SetActionByUse("Sustain", SmartPet_Config.UseSustain);
		SmartPet_AddDebugMessage("Combat Time: "..(SmartPet_Vars.LastAttackTime - SmartPet_Vars.FirstAttackTime), "dps");
		SmartPet_AddDebugMessage("Spell DPS: "..SmartPet_Vars.SpellDamage / (SmartPet_Vars.LastAttackTime - SmartPet_Vars.FirstAttackTime), "dps");
		SmartPet_AddDebugMessage("Sim Spell DPS: "..SmartPet_Vars.SimSpellDamage / (SmartPet_Vars.LastAttackTime - SmartPet_Vars.FirstAttackTime), "dps");
	end

	if (event == "CHAT_MSG_SPELL_PET_DAMAGE") then
		SmartPet_OnPetSpellEvent(arg1);	
	end

	if (event == "CHAT_MSG_MONSTER_EMOTE") then
		SmartPet_OnMonsterEmote(arg1, arg2);
	end

	if (event == "UNIT_FOCUS" and arg1 == "pet" and (SmartPet_Config.TauntMan or SmartPet_Config.SmartFocus)) then
		SmartPet_OnFocusEvent(arg1, arg2);
	end

	if ((event == "UNIT_HEALTH") and (arg1 == "pet") and (SmartPet_Config.AutoWarn or SmartPet_Config.AutoCower)) then
		SmartPet_OnHealthEvent(arg1, arg2);
	end

	--Causes Pet to Stop Attack when using Scatter Shot
	if ( event == "CHAT_MSG_SPELL_SELF_DAMAGE") then
		if (strfind (arg1, "Your Scatter Shot")) then
			if (keym) then
				keym.whack.add(TRUE, SmartPetScatterShot);
			end

		end
	end

	if ( event == "UNIT_COMBAT" ) then
	--SmartPetDefendTest(arg1, arg2);
	end
	
end

--Checks monster's emote to see if it is fleeing
function SmartPet_OnMonsterEmote(arg1, arg2)
	local target = "target";
	local petTarget = "pettarget";

	if (not SmartPet_Config.NoChase) then
		return
	end
	
	if (arg2 == UnitName("pettarget")  and strfind (arg1, SMARTPET_SEARCH_RUNAWAY)) then
		--SmartPet_AddInfoMessage(string.gsub(SMARTPET_PET_BREAKS_COMBAT, '%%n', UnitName("pet")));
		--SmartPet_AddInfoMessage(UnitAffectingCombat("target"));
		--SmartPet_AddInfoMessage(UnitAffectingCombat("pettarget"));
		--if (UnitHealth("target") > UnitHealth("pettarget"))  or not (UnitExists("target"))then
		--PetFollow();
		if (keym) then
			keym.whack.add(TRUE, PetFollow);
		end
		if (SmartPet_Config.RecallWarn) then
			UIErrorsFrame:AddMessage(string.gsub(SMARTPET_PET_RECALL, '%%n', UnitName("pet")), 0, 0, 1, 1.0, UIERRORS_HOLD_TIME);
		end

		SmartPet_Vars.TheButton = "recall";
		
	end
end

-- Spell Damage Event Handler
function SmartPet_OnPetSpellEvent(arg1)
	if (strfind (arg1, SmartPet_Actions["Taunt"].name)) then
		SmartPet_ProcessSpellEvent("Taunt");
	end
	if (strfind (arg1, SmartPet_Actions["Sustain"].name)) then
		SmartPet_ProcessSpellEvent("Sustain");
	end
	if (strfind (arg1, SmartPet_Actions["Burst"].name)) then
		SmartPet_ProcessSpellEvent("Burst");
	end
	if (strfind (arg1, SmartPet_Actions["Detaunt"].name)) then
		SmartPet_ProcessSpellEvent("Detaunt");
	end
end

--??
function SmartPet_ProcessSpellEvent(action)
	SmartPet_AddDebugMessage(SmartPet_Actions[action].name..": Time Since Last: "..GetTime() - SmartPet_Actions[action].lastTime, "usage");
	if (SmartPet_Vars.FirstAttackTime == 0) then
		SmartPet_Vars.FirstAttackTime = GetTime();
	end
	SmartPet_Actions[action].lastTime = GetTime();
	SmartPet_Vars.LastAttackTime = SmartPet_Actions[action].lastTime;

	firsti, lasti, value = strfind(arg1, "(%d+)");
	if (value) then
		SmartPet_Vars.SpellDamage = SmartPet_Vars.SpellDamage + tonumber(value);
		if (action == "Burst") then
			SmartPet_Vars.SimSpellDamage = SmartPet_Vars.SimSpellDamage + 31;
		elseif (action == "Sustain") then
			SmartPet_Vars.SimSpellDamage = SmartPet_Vars.SimSpellDamage + 54;
		end
	end
end

-- Focus Event Handler
function SmartPet_OnFocusEvent(arg1, arg2)

-- This will estimate at what time focus regen will occur
SmartPet_Vars.PetFocus2 = SmartPet_Vars.PetFocus1;
SmartPet_Vars.PetFocus1 = UnitMana("pet");
	if (SmartPet_Vars.PetFocus1 > SmartPet_Vars.PetFocus2) then
		SmartPet_Vars.CurrentFocusTime = GetTime();
		SmartPet_Vars.NextFocusTime = SmartPet_Vars.CurrentFocusTime + 4.5;
	end


	if (not SmartPet_Vars.inCombat) then
		return;
	end

	if (SmartPet_Vars.InPVP) then
		SmartPet_SetActionByFocus("Burst");
		SmartPet_AddDebugMessage("pvp focus ", "spew");
		return
	end


-- The FocusManager variable is used to determine how much time is left in the cooldown 
-- (so we can estimate focus that will be regened during cooldown)
-- First it will set FocusManager to 0 if there is no cooldown on bite
-- Then it will calculate the amount of cooldown left
-- If there is less than 4 seconds remaining (focus regens every 5 seconds)
-- It will set FocusManager to 0 so bite will have a max of 1 second delay in casting (next strike)
local startTime2, duration2, enable2 = GetPetActionCooldown(SmartPet_Actions["Sustain"].index);
	if (startTime2 == 0) then
		SmartPet_Vars.FocusManager  = 0;
	else
		SmartPet_Vars.FocusManager  = (10 - (GetTime() - startTime2));
	end
	if ((SmartPet_Vars.FocusManager  + SmartPet_Vars.CurrentFocusTime) < SmartPet_Vars.NextFocusTime) then
		SmartPet_Vars.FocusManager  = 0;
	end

	if (SmartPet_Config.SmartFocus and SmartPet_Config.UseSustain and SmartPet_Config.UseBurst) then
		if (UnitMana("pet") + (SmartPet_Vars.FocusManager * 4.8) < 60) then
			SmartPet_DisableAction("Burst");
			SmartPet_SetActionByFocus("Sustain");
		else
			SmartPet_SetActionByFocus("Burst");
			SmartPet_SetActionByFocus("Sustain"); 

		end

	elseif (SmartPet_Config.TauntMan) then
		if (SmartPet_Config.UseSustain) then
			SmartPet_SetActionByFocus("Sustain");
		end
	
		if (SmartPet_Config.UseBurst) then
			SmartPet_SetActionByFocus("Burst");
		end
	end
end



-- Health Event Handler
function SmartPet_OnHealthEvent(arg1, arg2)
	if (not SmartPet_Vars.inCombat) then
		SmartPet_AddDebugMessage("Not checking health because we're not in combat", "spew");
		return;
	end

	healthPercent = (100 * UnitHealth("pet") / UnitHealthMax("pet"));
	SmartPet_AddDebugMessage("Pet Health : "..healthPercent.."%", "pet");

	if (healthPercent >= 60) then
		warnTime = 10;
	elseif (healthPercent >= 50) then
		warnTime = 8;
	elseif (healthPercent >= 30) then
		warnTime = 6;
	else
		warnTime = 4;
	end

	if (SmartPet_Actions["Detaunt"].index > 0) then
		local _, _, _, _, _, _, autoCastEnabled = GetPetActionInfo(SmartPet_Actions["Detaunt"].index);
		if (SmartPet_Config.AutoCower and not autoCastEnabled and (GetTime() - SmartPet_Vars.LastDetauntWarning) > warnTime ) then
			if (healthPercent < SmartPet_Config.CowerHealth) then
				SmartPet_AddDebugMessage("AutoCower Health Check Failed, switching to cower", "spew");
				SmartPet_DisableAction("Taunt");
				SmartPet_EnableAction("Detaunt");
				SmartPet_Vars.MainAction = "Detaunt";
				if (not keym) then
					UIErrorsFrame:AddMessage(string.gsub(SMARTPET_PET_DETAUNT, '%%n', UnitName("pet")), 0, 0, 1, 1.0, UIERRORS_HOLD_TIME);
				end
				SmartPet_Vars.LastDetauntWarning = GetTime();
			else
				SmartPet_SetActionByUse("Taunt", SmartPet_Config.UseTaunt);
				SmartPet_SetActionByUse("Detaunt", SmartPet_Config.UseDetaunt);
			end
		end
	end
	

	if (SmartPet_Config.AutoWarn) then

		if (healthPercent < SmartPet_Config.WarnHealth and ((GetTime() - SmartPet_Vars.LastHealthWarning) > warnTime) and SmartPet_Vars.LastHealthPercent > healthPercent ) then
			local m = SMARTPET_PET_NEEDS_HEALING;
			m = string.gsub(m, '%%n', UnitName("pet"));
			m = string.gsub(m, '%%h', string.format("%d", healthPercent));
			SmartPet_SendChatMessage(m,string.upper(SMARTPET_CHANNELS_DROPDOWN_LIST[SmartPet_Config.Channel]),SmartPet_Config.ChannelNumber);
			SmartPet_Vars.LastHealthWarning = GetTime();
		end
	end
	SmartPet_Vars.LastHealthPercent = healthPercent;
end


-- Stores pet skills from spell book and puts checkboxes next to them on the spellbook pet tab
function SmartPet_PetSkillsLoad()
	if (SpellBookFrame.bookType == BOOKTYPE_PET) then
		SmartPet_PetSkillsFrame:Show();
	else
		SmartPet_PetSkillsFrame:Hide();
	end
		SmartPet_Actions["Taunt"].id = -1;
		SmartPet_Actions["Detaunt"].id = -1;
		SmartPet_Actions["Burst"].id = -1;
		SmartPet_Actions["Sustain"].id = -1;
		SmartPet_Actions["Nochase"].id = -1;
		SmartPet_Actions["Dash"].id = -1;
		SmartPet_Actions["Dive"].id = -1;

	for index=1, 12, 1 do

	local spellName, spellRank = GetSpellName(index, BOOKTYPE_PET)
	local l_petActionButton = getglobal("PetSkillButton"..index);
	local texture = GetSpellTexture(index, BOOKTYPE_PET);

		if (spellName == SMARTPET_ACTIONS_GROWL) then
			l_petActionButton:Show();
			SmartPet_Actions["Taunt"].id = index;
			SmartPet_Vars.PetSkills[index] = SmartPet_Actions["Taunt"].index;
			l_petActionButton:SetChecked(SmartPet_Config.UseTaunt);

		elseif (SMARTPET_ACTIONS_COWER == spellName) then
			l_petActionButton:Show();
			SmartPet_Actions["Detaunt"].id = index;
			SmartPet_Vars.PetSkills[index] = SmartPet_Actions["Detaunt"].index;
			l_petActionButton:SetChecked(SmartPet_Config.UseDetaunt);

		elseif (SMARTPET_ACTIONS_CLAW == spellName) then
			SmartPet_Actions["Burst"].id = index;
			if (SmartPet_Config.TauntMan or SmartPet_Config.SmartFocus) then
				l_petActionButton:Show();
			else
				l_petActionButton:Hide();
			end
			SmartPet_Vars.PetSkills[index] = SmartPet_Actions["Burst"].index;
			l_petActionButton:SetChecked(SmartPet_Config.UseBurst);

		elseif (SMARTPET_ACTIONS_BITE == spellName) then
			SmartPet_Actions["Sustain"].id = index;
			if (SmartPet_Config.TauntMan or SmartPet_Config.SmartFocus) then
				l_petActionButton:Show();
			else
				l_petActionButton:Hide();
			end
			SmartPet_Vars.PetSkills[index] = SmartPet_Actions["Sustain"].index;
			l_petActionButton:SetChecked(SmartPet_Config.UseSustain);

		elseif (SMARTPET_ACTIONS_DASH == spellName) then
			SmartPet_Actions["Dash"].id = index;
			SmartPet_Vars.PetSkills[index] = SmartPet_Actions["Dash"].index;

			l_petActionButton:Hide();

		elseif (SMARTPET_ACTIONS_DIVE == spellName) then
			SmartPet_Actions["Dive"].id = index;
			SmartPet_Vars.PetSkills[index] = SmartPet_Actions["Dive"].index;
		else
			l_petActionButton:Hide();
		end
	end
end


-- 
-- General Functions
--
-- 
-- Casts Scattershot and set pets mood and command
function SmartPetScatterShot()
	--Causes Pet to Stop Attack when using Scatter Shot
	if  (SmartPet_Config.Scatter) then
		SmartPet_AddDebugMessage("Scatter Shot Cast, new variables being set","spew");
		if (SmartPet_Config.ScatterOrder ~= "") then
			if(SmartPet_Config.ScatterOrdersetting == 3) then
				PetFollow();
			elseif (SmartPet_Config.ScatterOrdersetting == 2) then
				PetWait();
			end
			--SmartPet_Config.ScatterOrder(); 
		end
		if (SmartPet_Config.ScatterMood ~= "") then
			if(SmartPet_Config.ScatterMoodsetting == 3) then
				PetPassiveMode();
			elseif (SmartPet_Config.ScatterMoodsetting == 2) then
				PetDefensiveMode();
			end
			--SmartPet_Config.ScatterMood();
		end
	end
	CastSpellByName(SMARTPET_SPELLS_SCATTERSHOT);
end


--Casts a Selected Spell on attack command
function SmartPetSpellAttack()
	if (SmartPet_Config.SpellAttack == false) or (SmartPet_Config.Spell == "") then
		return;
	end
	CastSpell(SmartPet_Config.Spell, SmartPet_Config.SpellBook);
end

-- Toggles Taunt Management between Growl & Cower
function SmartPet_TauntToggle()
	if (SmartPet_Config.UseTaunt and not (SmartPet_Actions["Detaunt"].index < 1)) then
		SmartPet_ToggleUse(SmartPet_Actions["Detaunt"].index);
		return;
	end

	if (SmartPet_Config.UseDetaunt and not (SmartPet_Actions["Taunt"].index < 1)) then 
		SmartPet_ToggleUse(SmartPet_Actions["Taunt"].index);
	end
end


-- Enables the specified pet ability based on available focus
function SmartPet_SetActionByFocus(action)
	
	if (SmartPet_Vars.MainAction == "") then
		--if (SmartPet_Vars.InPVP) then
			--if (action == "Burst") then
				--if ((UnitMana("pet") + SmartPet_FocusRegen("Sustain")) - SmartPet_Actions[action].cost < SmartPet_Actions["Sustain"].cost) then
				--	SmartPet_DisableAction(action);
				--else
				--	SmartPet_EnableAction(action);
				--end
			--end

			--else
		SmartPet_EnableAction(action);
			--end--
			return;	
	end
	
	if ((UnitMana("pet") + SmartPet_FocusRegen(SmartPet_Vars.MainAction)) - SmartPet_Actions[action].cost < SmartPet_Actions[SmartPet_Vars.MainAction].cost) then
		SmartPet_DisableAction(action);
	else
		SmartPet_EnableAction(action);
	end
end

-- Enables the specified pet ability
function SmartPet_EnableAction(action)
	if (SmartPet_Actions[action].index < 1) then
		return;
	end
	local _, _, _, _, _, _, autoCastEnabled = GetPetActionInfo(SmartPet_Actions[action].index);
	if (not autoCastEnabled) then
		SmartPet_AddDebugMessage("Enabling Action: "..SmartPet_Actions[action].name, "spew");	
		if (keym) then
			keym.whack.add(TRUE, TogglePetAutocast, SmartPet_Actions[action].index);
		else	
			TogglePetAutocast(SmartPet_Actions[action].index);
		end
	end
end

-- Disables the specified pet ability
function SmartPet_DisableAction(action)
	local _, _, _, _, _, _, autoCastEnabled = GetPetActionInfo(SmartPet_Actions[action].index);
	if (autoCastEnabled) then
		SmartPet_AddDebugMessage("Disabling Action: "..SmartPet_Actions[action].name, "spew");		
		if (keym) then
			keym.whack.add(TRUE, TogglePetAutocast, SmartPet_Actions[action].index);
		else
			TogglePetAutocast(SmartPet_Actions[action].index);
		end
	end
end


-- Returns the estimated amount of focus that will be regen'd during this actions cooldown
function SmartPet_FocusRegen(action)
	startTime, duration, enable = GetActionCooldown(SmartPet_Actions[action].index);
	if (startTime == 0) then
		return 0;
	else
		return SMARTPET_FOCUSREGEN * (duration);
	end
end

-- Initialize the pet actions for combat
function SmartPet_InitActions()
	SmartPet_UpdateActionIcons(true);

	SmartPet_SetActionByUse("Taunt", SmartPet_Config.UseTaunt);	
	SmartPet_SetActionByUse("Detaunt", SmartPet_Config.UseDetaunt);

	if (SmartPet_Config.UseTaunt) then
		SmartPet_Vars.MainAction = "Taunt";
	elseif (SmartPet_Config.UseDetaunt) then
		SmartPet_Vars.MainAction = "Detaunt";
	else
		SmartPet_Vars.MainAction = "";
	end
	
	if (SmartPet_Config.SmartFocus and SmartPet_Config.UseBurst and SmartPet_Config.UseSustain) then
		SmartPet_EnableAction("Sustain");
		SmartPet_DisableAction("Burst");
	end
end


-- Determine if an action is to be used during this combat session

-- Enables/Disables the specified pet ability based on it's .use setting
function SmartPet_SetActionByUse(action, enabled)
	if (enabled) then
		SmartPet_EnableAction(action);		
	else
		SmartPet_DisableAction(action);
	end
end

-- Decide to toggle a variable based on its current state, or the command string
function SmartPet_ToggleOption(command, enabled)
	if (strfind(command, SMARTPET_ON) or strfind(command, SMARTPET_ENABLE)) then
		return true;
	elseif (strfind(command, SMARTPET_OFF) or strfind(command, SMARTPET_DISABLE)) then
		return false;
	else
		if (enabled) then
			return false;
		else
			return true;
		end
	end
end

-- Sends a message to the specified channel
function SmartPet_SendChatMessage(message, channel,channelNumber)


	-- add additional invalid channel error checking
	if ((channelNumber > 0) and (channel == "CHANNEL")) then
		SendChatMessage(message, channel, nil, channelNumber);
	else
		if (channel == 'PARTY') then
			if ((UnitInParty('player')) and (UnitInParty('party1'))) then
				SendChatMessage(message, channel);
			else
			SmartPet_AddDebugMessage("Not In A Party", "spew");
				SendChatMessage(message, "SAY");
			end
		elseif (channel == 'RAID') then
			if ((UnitInRaid('player'))) then
				SendChatMessage(message, channel);
			else
			SmartPet_AddDebugMessage("Not In A RAID", "spew");
				SendChatMessage(message, "SAY");
			end
		elseif (channel == 'GUILD') then
			if (IsInGuild()) then
				SendChatMessage(message, channel);
			else
				SendChatMessage(message, "SAY");
			end
		else 
			SendChatMessage(message, "SAY");
		end
	end
end

-- Toggles Settings 
function SmartPet_ToggleUse(id)
	if (id == SmartPet_Actions["Taunt"].index) then
		if (SmartPet_Config.UseTaunt or SmartPet_Config.UseDetaunt) then
			if (SmartPet_Config.UseTaunt) then
				SmartPet_Config.TauntMan = false; -- disable tauntman
				SmartPet_Config.UseTaunt = false; -- disable taunt
			else
				SmartPet_Config.TauntMan = true; -- enable tauntman
				SmartPet_Config.UseTaunt = true; -- enable taunt
				SmartPet_Config.UseDetaunt = false;-- disable detaunt
			end
		else
			SmartPet_Config.TauntMan = true; -- enable tauntman
			SmartPet_Config.UseTaunt = true;-- set tauntman to taunt
			SmartPet_Config.UseDetaunt = false;
		end

		SmartPet_SetActionByUse("Taunt", SmartPet_Config.UseTaunt);
		SmartPet_SetActionByUse("Detaunt", SmartPet_Config.UseDetaunt);

	elseif (id == SmartPet_Actions["Detaunt"].index) then
		if (SmartPet_Config.UseTaunt or SmartPet_Config.UseDetaunt) then
			if (SmartPet_Config.UseDetaunt) then
				SmartPet_Config.TauntMan = false; -- disable tauntman
				SmartPet_Config.UseDetaunt = false; -- disable taunt
			else
				SmartPet_Config.TauntMan = true; -- enable tauntman
				SmartPet_Config.UseDetaunt = true; -- enable taunt
				SmartPet_Config.UseTaunt = false;-- disable detaunt
			end
		else
			SmartPet_Config.TauntMan = true; -- enable tauntman
			SmartPet_Config.UseDetaunt = true;-- set tauntman to taunt
			SmartPet_Config.UseTaunt = false;
		end

		SmartPet_SetActionByUse("Taunt", SmartPet_Config.UseTaunt);
		SmartPet_SetActionByUse("Detaunt", SmartPet_Config.UseDetaunt);

	elseif (id == SmartPet_Actions["Burst"].index) then
		if (SmartPet_Config.UseBurst) then
			SmartPet_Config.UseBurst = false;
		else
			SmartPet_Config.UseBurst = true;
		end

		SmartPet_SetActionByUse("Burst", SmartPet_Config.UseBurst);

	elseif (id == SmartPet_Actions["Sustain"].index) then
		if (SmartPet_Config.UseSustain) then
			SmartPet_Config.UseSustain = false;
		else
			SmartPet_Config.UseSustain = true;
		end
		SmartPet_SetActionByUse("Sustain", SmartPet_Config.UseSustain);
	
	elseif (id == SmartPet_Actions["Nochase"].index) then
		if (SmartPet_Config.NoChase) then
			SmartPet_Config.NoChase = false;
		else
			SmartPet_Config.NoChase = true;
			PetFollow();
		end
	end
	SmartPet_UpdateActionIcons(true);
end


function SmartPet_SetupAction(name, index, enabled)
	local l_smartPetActionButton = getglobal("SmartPetActionButton"..index);
	if (enabled) then
		l_smartPetActionButton:SetChecked(1);
	else
		l_smartPetActionButton:SetChecked(nil);
	end
	SmartPet_Actions[name].index = index;
end

--Looks at icons on the pet action bar and places the check boxes above appropriate skills
function SmartPet_UpdateActionIcons(resetIDs)
	if (resetIDs) then
		SmartPet_Actions["Attack"].id = 0;
		SmartPet_Actions["Taunt"].index = -1;
		SmartPet_Actions["Detaunt"].index = -1;
		SmartPet_Actions["Burst"].index = -1;
		SmartPet_Actions["Sustain"].index = -1;
		SmartPet_Actions["Nochase"].index = -1;
		SmartPet_Actions["Dash"].index = -1;
		SmartPet_Actions["Dive"].index = -1;
	end

	for index=1, NUM_PET_ACTION_SLOTS, 1 do
		local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(index);
		local l_petActionButton = getglobal("SmartPetActionButton"..index);

		if (not SmartPet_Config.Enabled) then
			l_petActionButton:Hide();
		elseif (name == SmartPet_Actions["Taunt"].name) then
			l_petActionButton:Show();
			SmartPet_SetupAction("Taunt", index, SmartPet_Config.UseTaunt);
		elseif (name == SmartPet_Actions["Detaunt"].name) then
			l_petActionButton:Show();
			SmartPet_SetupAction("Detaunt", index, SmartPet_Config.UseDetaunt);
		elseif (name == SmartPet_Actions["Burst"].name) then
			if (SmartPet_Config.TauntMan or SmartPet_Config.SmartFocus) then
				l_petActionButton:Show();
			else
				l_petActionButton:Hide();
			end
			SmartPet_SetupAction("Burst", index, SmartPet_Config.UseBurst);
		elseif (name == SmartPet_Actions["Sustain"].name) then
			if (SmartPet_Config.TauntMan or SmartPet_Config.SmartFocus) then
				l_petActionButton:Show();
			else
				l_petActionButton:Hide();
			end
			SmartPet_SetupAction("Sustain", index, SmartPet_Config.UseSustain);

		elseif (name == SmartPet_Actions["Nochase"].name) then
			l_petActionButton:Show();
			SmartPet_SetupAction("Nochase", index, SmartPet_Config.NoChase);

		elseif (name == SmartPet_Actions["Attack"].name) then
--DEFAULT_CHAT_FRAME:AddMessage("attack Found");

		 SmartPet_Actions["Attack"].id = index;
		 

		else
			l_petActionButton:Hide();
		end
	end
	
	if (resetIDs) then
		if (SmartPet_Actions["Taunt"].index < 1) then
			SmartPet_Config.UseTaunt = false;
		end
		if (SmartPet_Actions["Detaunt"].index < 1) then
			SmartPet_Config.UseDetaunt = false;
		end
		if (SmartPet_Actions["Burst"].index < 1) then
			SmartPet_Config.UseBurst = false;
		end
		if (SmartPet_Actions["Sustain"].index < 1) then
			SmartPet_Config.UseSustain = false;
		end
		if (not SmartPet_Config.UseTaunt and not SmartPet_Config.UseDetaunt) then
			SmartPet_Config.TauntMan = false;
		end
	end
end


--Resets values to factory defaults
function SmartPet_ResetConfig()  
	SmartPet_Config.Enabled = true;		--SmartPet On/Off
	SmartPet_Config.Version = SMARTPET_VERSION;	--Version of SmartPet Running
	SmartPet_Config.AcceptedClass = false;	--Is Player a class that can use SmartPet
	SmartPet_Config.ToolTips = true;	--ToolTip On/Off
	SmartPet_Config.Icon = true;		--Icon on pet bar On/Off

	SmartPet_Config.TauntMan = true;	--Use Taunt Management ON/Off
	SmartPet_Config.SmartFocus = true;	--Use SmartFocus
	SmartPet_Config.WarnHealth = 30;	--% of pets health to start warning
	SmartPet_Config.AutoWarn = false;	--Give Warning if pet is hurt
	SmartPet_Config.CowerHealth = 30;	--% of pets health to start cowering at
	SmartPet_Config.AutoCower = false;	--Autocower On/Off
	SmartPet_Config.ShowDebug = false;	--Display Debug Info
	SmartPet_Config.Channel = 1;		--Type of channel to give warning on
	SmartPet_Config.ChannelNumber = 0;	--Specific numeric channel to use
	SmartPet_Config.NoChase = true;		--NoChase On/Off
	SmartPet_Config.RecallWarn = true;	--Displays Recall Warnings

	SmartPet_Config.UseTaunt = false;	--Always use Pets Taunt Skill
	SmartPet_Config.UseDetaunt = false;	--Always use Pets Detaunt Skill
	SmartPet_Config.UseBurst = false;	--Use Pets Burst Damge Skill
	SmartPet_Config.UseSustain = false;	--Use Pets Sustained Damage Skill

	SmartPet_Config.ShowDebugString = "";	--Type of Debug message being shown
	SmartPet_Config.RushAttack = false;	--Use Dash/Dive on attacking
	SmartPet_Config.Alert = false;		--Say an alert on attacking
	SmartPet_Config.AlertTimeout = 20;	--seconds, 
	SmartPet_Config.AlertChannel = 1;	--Type of channel to give warning on
	SmartPet_Config.AlertChannelNumber = 0;	--Specific numeric channel to use

	SmartPet_Config.Scatter = true;		--Have pet break off combat on use of Scatter Shot\
	SmartPet_Config.ScatterMoodsetting = 3;	--Mood to set on Scatter Shot [Passive/Defensive]
	SmartPet_Config.ScatterMood = PetPassiveMode;	--Mood to set on Scatter Shot [Passive/Defensive]
	SmartPet_Config.ScatterOrder = PetFollow;	--Command to set on Scatter Shot [Stay/Follow]
	SmartPet_Config.ScatterOrdersetting = 3; 

	SmartPet_Config.SpellAttack = false;	--Cast a spell when attacking
	SmartPet_Config.Spell = "";		--Id of Spell to cast
	SmartPet_Config.SpellBook = "";		--Id of Spellbook to be cast

	SmartPet_Config.DebufCheck = false;

	SmartPet_Config.PetFeed = false;	--Pet feed herself when low happiness
	SmartPet_Config.Food = { bag = 0, slot = 0, name = "", texture = ""}; --Food to feed pet
end


function SmartPetTheButton()
	if (SmartPet_Vars.TheButton == "recall" ) then
		PetFollow();
		SmartPet_Vars.TheButton = "";
	else
		PetAttack();
	end
end

--function SmartPetHeal();


Mend={};
Mend[7]={mana=480; health = 245};
Mend[6]={mana=385; health = 189};
Mend[5]={mana=300; health = 142};
Mend[4]={mana=225; health = 245};
Mend[3]={mana=155; health = 68};
Mend[2]={mana=90; health = 38};
Mend[1]={mana=50; health = 20};