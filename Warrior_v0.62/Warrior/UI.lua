WARRIOR.UI = {};


-- *****************************************************************************
-- Function: Alerts
-- Purpose: all the commands related to alerts
-- *****************************************************************************
function WARRIOR.UI:Alerts(msg)
	local _,_, msg = string.find(msg,'^alerts (.+)$');
	if (not msg) then return false; end

	-- TOGGLE THE SETTING OF ALERTS
	if (msg == "on") then
		WARRIOR.Alerts._enabled = true;
		WARRIOR.Utils:Print("Alerts have been enabled.");
		WARRIOR.Settings:Save("WARRIOR.Alerts._enabled");
		return true;
	end
	if (msg == "off") then
		WARRIOR.Alerts._enabled = false;
		WARRIOR.Utils:Print("Alerts have been disabled.");
		WARRIOR.Settings:Save("WARRIOR.Alerts._enabled");
		return true;
	end

	-- TOGGLE ALERT DISPLAY TYPE
	if (msg == "class") then
		WARRIOR.Alerts._type = "class";
		WARRIOR.Utils:Print("Only alerts for spells in the active class will be shown.");
		WARRIOR.Settings:Save("WARRIOR.Alerts._type");
		return true;
	end
	if (msg == "all") then
		WARRIOR.Alerts._type = "all";
		WARRIOR.Utils:Print("Alerts will be shown even if they are not in the active class.");
		WARRIOR.Settings:Save("WARRIOR.Alerts._type");
		return true;
	end

	-- TOGGLE THE MOVING OF THE ALERTS
	if (msg == "unlock") then 
		WARRIOR.Alerts:Unlock();
		WARRIOR.Utils:Print("Alerts have been unlocked, you may now reposition them.");
		return true;
	end
	if (msg == "lock") then 
		WARRIOR.Alerts:Lock();
		WARRIOR.Utils:Print("Alerts have been repositioned and locked into place.");
		return true; 
	end

	-- SET THE ALERT FADEOUT
	local _, _, fadeout = string.find(msg,'^fade ([0-9.]+)$');
	if (fadeout) then
		local fade = tonumber(fadeout);
		if (fade == 0) then
			WARRIOR.Utils:Print("The alert fade cannot be set to %d.",0);
			return true;
		end

		WARRIOR.Alerts._fade = fade;
		WARRIOR.Utils:Print("The alert fade has been set to %d seconds.",fade);
		WARRIOR.Settings:Save("WARRIOR.Alerts._fade");
		return true;
	end
	
	return false;
end

-- *****************************************************************************
-- Function: Immunities
-- Purpose: all the commands related to immunities
-- *****************************************************************************
function WARRIOR.UI:Immunities(message)
	local _,_, msg = string.find(message,'^immunities (.+)$');
	if (not msg) then return false; end
	
	-- TOGGLE THE IMMUNITIES DATABASE ON AND OFF
	if (msg == "on") then
		WARRIOR.Immunities._enabled = true;
		WARRIOR.Utils:Print("Immunity tracking has been enabled.");
		WARRIOR.Settings:Save("WARRIOR.Immunities._enabled");
		return true;
	end
	if (msg == "off") then
		WARRIOR.Immunities._enabled = false;
		WARRIOR.Utils:Print("Immunity tracking has been disabled.");
		WARRIOR.Settings:Save("WARRIOR.Immunities._enabled");
		return true;
	end
	
	-- CLEAN ALL THE TEMPORARY IMMUNITIES FROM THE DATABASE
	if (msg == "wipe") then
		WARRIOR.Immunities.Effects:Wipe();
		WARRIOR.Utils:Print("All temporary immunities have been purged.");
		WARRIOR.Settings:Save("WARRIOR.Immunities._database");
		return true;
	end
	
	-- PURGE THE ENTIRE IMMUNITIES DATABASE
	if (msg == "purge") then
		WARRIOR.Immunities._database = {};
		WARRIOR.Utils:Print("The entire immunity database has been purged.");
		WARRIOR.Settings:Save("WARRIOR.Immunities._database");
		return true;
	end
	
	return false;
end

-- *****************************************************************************
-- Function: Classes
-- Purpose: all the commands related to classes
-- *****************************************************************************
function WARRIOR.UI:Classes(msg)
	-- DISPLAY ALL THE CLASSES
	if (msg == "list") then	
		WARRIOR.Utils:Print("Classes:");
		for i=1,2 do
			for class,_ in WARRIOR.Classes._database do
				if ((i == 1 and WARRIOR.Classes._database[class].type == "system") or (i == 2 and WARRIOR.Classes._database[class].type ~= "system")) then
					local name = class;
					if (WARRIOR.Classes._active == class) then name = "|cffFF0099" .. class; end
					WARRIOR.Utils:Print("%s class [%s]: %s.", name, WARRIOR.Classes._database[class].type, table.concat(WARRIOR.Classes._database[class].spells,", "));
				end
			end
		end
		
		return true;
	end
	
	-- DISPLAY A CLASS
	local _, _, class = string.find(msg,'^'..WARRIOR.Utils._regex.entry..' list$');
	if (class and WARRIOR.Classes._database[class]) then
		WARRIOR.Utils:Print("%s class [%s]: %s.", class, WARRIOR.Classes._database[class].type, table.concat(WARRIOR.Classes._database[class].spells,", "));
		return true;
	end

	-- SET THE ACTIVE CLASS
	local _, _, class = string.find(msg,'^use '..WARRIOR.Utils._regex.entry..'$');
	if (class) then
		if (WARRIOR.Classes:Activate(class)) then
			WARRIOR.Utils:Print("The active class has been set to %s.",class);
			return true;
		end
		
		WARRIOR.Utils:Print("The active class could not be set.");
		return true;
	end
	
	-- SET THE CLASS TYPE
	local _, _, class, type = string.find(msg,'^'..WARRIOR.Utils._regex.entry..' type is (%w+)$');
	if (class and type) then
		if (type == "fifo" or type == "default") then
			if (not WARRIOR.Classes._database[class]) then
				WARRIOR.Utils:Print("The specified class (%s) does not exist.",class);
				return true;
			end
		
			WARRIOR.Classes._database[class].type = type;
			WARRIOR.Settings:Save("WARRIOR.Classes._database");
			WARRIOR.Utils:Print("The type of the %s class has been set to %s.",class,type);
			return true;
		end
		
		WARRIOR.Utils:Print("The invalid type (%s) specified.",type);
		return true;
	end
	
	-- REMOVE CLASS
	local _, _, class = string.find(msg,'^remove '..WARRIOR.Utils._regex.entry..'$');
	if (class) then
		if (WARRIOR.Classes:Remove(class)) then
			WARRIOR.Utils:Print("The %s class has been removed.",class);
			return true;
		end
		
		WARRIOR.Utils:Print("The %s class could not be removed.",class);
		return true;
	end

	-- ADD SPELL TO CLASS
	local _, _, class, cmd = string.find(msg,'^'..WARRIOR.Utils._regex.entry..' add (.+)$');
	if (class and cmd) then		
		local _, _, spell = string.find(cmd,'^'.. WARRIOR.Utils._regex.entry ..'$');
		if (spell) then
			if (WARRIOR.Classes:AddSpell(class,spell)) then
				WARRIOR.Utils:Print("%s has been added to the %s class.",spell,class);
				return true;
			end
			
			WARRIOR.Utils:Print("%s could not be added to the %s class.",spell,class);
			return true;
		end

		local add = function(a)
			if (WARRIOR.Classes:AddSpell(getglobal("WARRIORTEMP"),a)) then
				WARRIOR.Utils:Print("%s has been added to the %s class.",a,getglobal("WARRIORTEMP"));
			else
				WARRIOR.Utils:Print("%s could not be added to the %s class.",a,getglobal("WARRIORTEMP"));
			end
		end

		setglobal("WARRIORTEMP",class);
		string.gsub(cmd, WARRIOR.Utils._regex.list, add);
		setglobal("WARRIORTEMP",nil);

		return true;
	end
	
	-- REMOVE SPELL FROM CLASS
	local _, _, class, cmd = string.find(msg,'^'..WARRIOR.Utils._regex.entry..' remove (.+)$');
	if (class and cmd) then		
		local _, _, spell = string.find(cmd,'^'.. WARRIOR.Utils._regex.entry ..'$');
		if (spell) then
			if (WARRIOR.Classes:RemoveSpell(class,spell)) then
				WARRIOR.Utils:Print("%s has been removed fron the %s class.",spell,class);
				return true;
			end
			
			WARRIOR.Utils:Print("%s could not be removed from the %s class.",spell,class);
			return true;
		end

		local remove = function(a)
			if (WARRIOR.Classes:RemoveSpell(getglobal("WARRIORTEMP"),a)) then
				WARRIOR.Utils:Print("%s has been removed fron the %s class.",a,getglobal("WARRIORTEMP"));
			else
				WARRIOR.Utils:Print("%s could not be removed from the %s class.",a,getglobal("WARRIORTEMP"));
			end
		end

		setglobal("WARRIORTEMP",class);
		string.gsub(cmd, WARRIOR.Utils._regex.list, remove);
		setglobal("WARRIORTEMP",nil);
		
		return true;
	end
	
	return false;
end

-- *****************************************************************************
-- Function: Conditions
-- Purpose: all the commands related to conditions
-- *****************************************************************************
function WARRIOR.UI:Conditions(msg)
	-- ADD A POOL CONDITION
	local _, _, class, spell, target, pool, flop, operation, value, percentage = string.find(msg,'^'..WARRIOR.Utils._regex.entry..' use '..WARRIOR.Utils._regex.entry..' when (%w+) (%w+) is (n?o?t?%s?)(%w+) ([%d.]+)(%%?)$');
	if (class and spell and target and pool and operation and value) then
		if (operation == "ver") then operation = "over"; flop = ""; end
		if (flop == "") then flop = false; else flop = true; end
		if (percentage == "") then percentage = false; else percentage = true; end
		if (target ~= "player" and target ~= "target" and target ~= "targettarget") then return; end
		if (operation ~= "over" and operation ~= "around" and operation ~= "under") then return; end
		if (pool ~= "rage" and pool ~= "health" and pool ~= "mana" and pool ~= "energy") then return; end
		if (WARRIOR.Conditions:Add(class,spell,{index="Pool",parameters={pool=pool,target=target,percentage=percentage,operation=operation,flop=flop,value=tonumber(value)}})) then
			WARRIOR.Utils:Print("condition added to %s in %s.",spell,class);
			return true;
		end
		
		WARRIOR.Utils:Print("condition could not be added to %s in %s.",spell,class);
		return true;
	end

	-- ADD A BUFF CONDITION
	local _, _, class, spell, buffs = string.find(msg,'^'..WARRIOR.Utils._regex.entry..' use '..WARRIOR.Utils._regex.entry..' when player has (.+)$');
	if (class and spell and buffs) then
		if (WARRIOR.Conditions:Add(class,spell,{index="Buff",parameters={buffs=buffs}})) then
			WARRIOR.Utils:Print("condition added to %s in %s.",spell,class);
			return true;
		end
		
		WARRIOR.Utils:Print("condition could not be added to %s in %s.",spell,class);
		return true;
	end

	-- ADD A COOLDOWN CONDITION
	local _, _, class, spell, spells, flop = string.find(msg,'^'..WARRIOR.Utils._regex.entry..' use '..WARRIOR.Utils._regex.entry..' when (.+) i?s?a?r?e? (n?o?t?%s?)on cooldown$');
	if (class and spell and spells) then
		if (flop == "") then flop = false; else flop = true; end
		if (WARRIOR.Conditions:Add(class,spell,{index="Cooldown",parameters={spells=spells,spell=spell,flop=flop}})) then
			WARRIOR.Utils:Print("condition added to %s in %s.",spell,class);
			return true;
		end
		
		WARRIOR.Utils:Print("condition could not be added to %s in %s.",spell,class);
		return true;
	end
	
	-- ADD A CASTING CONDITION
	local _, _, class, spell, spells = string.find(msg,'^'..WARRIOR.Utils._regex.entry..' use '..WARRIOR.Utils._regex.entry..' when targets casting(.*)$');
	if (class and spell) then
		if (not spells or spells == "") then spells = "warriorattack"; end
		if (WARRIOR.Conditions:Add(class,spell,{index="Casting",parameters={spells=spells,spell=spell}})) then
			WARRIOR.Utils:Print("condition added to %s in %s.",spell,class);
			return true;
		end
		
		WARRIOR.Utils:Print("condition could not be added to %s in %s.",spell,class);
		return true;
	end

	-- ADD A CLASS CONDITION
	local _, _, class, spell, target, flop, classes = string.find(msg,'^'..WARRIOR.Utils._regex.entry..' use '..WARRIOR.Utils._regex.entry..' when (%w+) is(%s?n?o?t?) a (.+)$');
	if (class and spell and target and classes) then
		if (flop == "") then flop = false; else flop = true; end
		if (target ~= "target" and target ~= "targettarget") then return; end
		if (WARRIOR.Conditions:Add(class,spell,{index="Class",parameters={classes=classes,target=target,flop=flop}})) then
			WARRIOR.Utils:Print("condition added to %s in %s.",spell,class);
			return true;
		end
		
		WARRIOR.Utils:Print("condition could not be added to %s in %s.",spell,class);
		return true;
	end

	-- ADD A STANCE CONDITION
	local _, _, class, spell, flop, stance = string.find(msg,'^'..WARRIOR.Utils._regex.entry..' use '..WARRIOR.Utils._regex.entry..' when (n?o?t?%s?)in (%w+ Stance)$');
	if (class and spell and stance) then
		if (flop == "") then flop = false; else flop = true; end
		if (WARRIOR.Conditions:Add(class,spell,{index="Stance",parameters={stance=stance,flop=flop}})) then
			WARRIOR.Utils:Print("condition added to %s in %s.",spell,class);
			return true;
		end
		
		WARRIOR.Utils:Print("condition could not be added to %s in %s.",spell,class);
		return true;
	end

	-- ADD A RUNNER CONDITION
	local _, _, class, spell, flop = string.find(msg,'^'..WARRIOR.Utils._regex.entry..' use '..WARRIOR.Utils._regex.entry..' when target is(%s?n?o?t?) fleeing$');
	if (class and spell) then
		if (flop == "") then flop = false; else flop = true; end
		if (WARRIOR.Conditions:Add(class,spell,{index="Runner",parameters={flop=flop}})) then
			WARRIOR.Utils:Print("condition added to %s in %s.",spell,class);
			return true;
		end
		
		WARRIOR.Utils:Print("condition could not be added to %s in %s.",spell,class);
		return true;
	end

	-- ADD A TIMER CONDITION
	local _, _, class, spell, seconds = string.find(msg,'^'..WARRIOR.Utils._regex.entry..' use '..WARRIOR.Utils._regex.entry..' every (%d+) seconds$');
	if (class and spell and seconds) then
		if (WARRIOR.Conditions:Add(class,spell,{index="Timer",parameters={spell=spell,seconds=tonumber(seconds)}})) then
			WARRIOR.Utils:Print("condition added to %s in %s.",spell,class);
			return true;
		end
		
		WARRIOR.Utils:Print("condition could not be added to %s in %s.",spell,class);
		return true;
	end
	
	-- ADD A SUNDER CONDITION
	local _, _, class, spell, times = string.find(msg,'^'..WARRIOR.Utils._regex.entry..' use ["\']?(Sunder Armor)["\']? (.+) times$');
	if (class and spell and times) then
		if (WARRIOR.Conditions:Add(class,spell,{index="Sunder",parameters={times=times}})) then
			WARRIOR.Utils:Print("condition added to %s in %s.",spell,class);
			return true;
		end
		
		WARRIOR.Utils:Print("condition could not be added to %s in %s.",spell,class);
		return true;
	end

	-- REMOVE A CONDITION FROM A SPELL
	local _, _, class, spell, value = string.find(msg,'^'..WARRIOR.Utils._regex.entry..' remove '..WARRIOR.Utils._regex.entry..' condition (%d+)$');
	if (class and spell and value) then
		if (WARRIOR.Conditions:Remove(class,spell,tonumber(value))) then
			WARRIOR.Utils:Print("condition removed from %s in %s.",spell,class);
			return true;
		end
		
		WARRIOR.Utils:Print("condition could not be removed from %s in %s.",spell,class);
		return true;
	end
	
	-- REMOVE ALL CONDITIONS FROM A SPELL
	local _, _, class, spell = string.find(msg,'^'..WARRIOR.Utils._regex.entry..' remove '..WARRIOR.Utils._regex.entry..' conditions$');
	if (class and spell) then	
		if (WARRIOR.Conditions:RemoveSpell(class,spell)) then
			WARRIOR.Utils:Print("all conditions removed from %s in %s.",spell,class);
			return true;
		end
		
		WARRIOR.Utils:Print("conditions could not be removed from %s in %s.",spell,class);
		return true;
	end
	
	-- REMOVE ALL CONDITIONS FROM ALL SPELLS IN A CLASS
	local _, _, class = string.find(msg,'^'..WARRIOR.Utils._regex.entry..' remove conditions$');
	if (class) then	
		if (WARRIOR.Conditions:RemoveClass(class)) then
			WARRIOR.Utils:Print("all conditions removed from the %s class.",class);
			return true;
		end
		
		WARRIOR.Utils:Print("conditions could not be removed from %s class.",class);
		return true;
	end

	-- PRINT OUT A CLASS
	local print = function(class)
		WARRIOR.Utils:Print("%s class conditions:",class);
		for spell,conditions in WARRIOR.Conditions._database[class] do
			for key,c in conditions do
				if (c.index == "Pool") then
					local flop,percentage = "","";
					if (c.parameters.flop) then flop = " not"; end
					if (c.parameters.percentage) then percentage = "%"; end
					WARRIOR.Utils:Print("%s condition %d: when %s %s is%s %s %d%s.",spell,key,c.parameters.target,c.parameters.pool,flop,c.parameters.operation,c.parameters.value,percentage);
				end
				if (c.index == "Stance") then
					local flop = "";
					if (c.parameters.flop) then flop = "not "; end
					WARRIOR.Utils:Print("%s condition %s: when %sin %s.",spell,key,flop,c.parameters.stance);
				end
				if (c.index == "Sunder") then
					WARRIOR.Utils:Print("%s condition %s: sunder %s times.",spell,key,c.parameters.times);
				end
				if (c.index == "Timer") then
					WARRIOR.Utils:Print("%s condition %s: use every %s seconds.",spell,key,c.parameters.seconds);
				end
				if (c.index == "Runner") then
					local flop = "";
					if (c.parameters.flop) then flop = " not"; end
					WARRIOR.Utils:Print("%s condition %s: is%s fleeing.",spell,key,flop);
				end
				if (c.index == "Cooldown") then
					local flop,adj = "","is";
					if (c.parameters.flop) then flop = " not"; end
					if (string.find(c.parameters.spells,",")) then adj = "are"; end
					WARRIOR.Utils:Print("%s condition %s: while %s "..adj.."%s on cooldown.",spell,key,c.parameters.spells,flop);
				end
				if (c.index == "Class") then
					local flop = "";
					if (c.parameters.flop) then flop = " not"; end
					WARRIOR.Utils:Print("%s condition %s: %s class is%s %s.",spell,key,c.parameters.target,flop,c.parameters.classes);
				end
				if (c.index == "Casting") then
					local spells = c.parameters.spells;
					if (spells == "warriorattack") then spells = "" else spells = " " .. spells end
					WARRIOR.Utils:Print("%s condition %s: when target is casting%s.",spell,key,spells);
				end
				if (c.index == "Buff") then
					WARRIOR.Utils:Print("%s condition %s: when player has %s.",spell,key,c.parameters.buffs);
				end
			end
		end
	end

	-- PRINT OUT THE CONDITIONS ON A CLASS
	local _, _, class = string.find(msg,'^'..WARRIOR.Utils._regex.entry..' conditions$');
	if (class) then	
		if (not WARRIOR.Conditions._database[class]) then
			WARRIOR.Utils:Print("The %s class has no conditions.",class);
			return true;
		end

		print(class);
		return true;
	end
	
	-- PRINT OUT ALL THE CONDITIONS
	if (msg == "conditions") then	
		for class,_ in WARRIOR.Conditions._database do print(class) end
		return true;
	end

	return false;
end

-- *****************************************************************************
-- Function: Player
-- Purpose: all the commands related to players
-- *****************************************************************************
function WARRIOR.UI:Player(msg)
	-- PRINT OUT THE SETTING OF ALL THE BASIC WARRIOR SETTINGS
	if (msg == "status") then	
		local stance,alerts,type,immunities,rage;
		if (WARRIOR.Player.Stances._auto) then stance = "enabled" else stance = "disabled" end
		if (WARRIOR.Alerts._enabled) then alerts = "enabled" else alerts = "disabled" end
		if (WARRIOR.Alerts._type == "class") then type = "class" else type = "all" end
		if (WARRIOR.Immunities._enabled) then immunities = "enabled" else immunities = "disabled" end
		if (WARRIOR.Player.Rage._enabled) then rage = "enabled" else rage = "disabled" end

		WARRIOR.Utils:Print("Warrior Status:");								
		WARRIOR.Utils:Print("Active class: %s", WARRIOR.Classes._active);
		WARRIOR.Utils:Print("Auto stance: %s", stance);
		WARRIOR.Utils:Print("Alerts: %s", alerts);
		WARRIOR.Utils:Print("Alert type: %s", type);
		WARRIOR.Utils:Print("Alert fade: %d", WARRIOR.Alerts._fade);
		WARRIOR.Utils:Print("Immunity database: %s", immunities);
		WARRIOR.Utils:Print("Rage reserve: %s", rage);
		WARRIOR.Utils:Print("Rage reserve limit: %d", WARRIOR.Player.Rage._limit);
		return true;
	end
	
	-- RESTORE THE DEFAULT SETTINGS
	if (msg == "reset") then
		WARRIOR.Settings:Reset();
		WARRIOR.Utils:Print("settings have been reset to the defaults.");
		return true;
	end

	-- TOGGLE THE DEBUG SETTING
	if (msg == "debug") then
		if (WARRIOR._debug > -1) then 
			WARRIOR._debug = -1;
			WARRIOR.Utils:Print("debug messages have been disabled.");
		else
			WARRIOR._debug = 4; 
			WARRIOR.Utils:Print("debug messages have been enabled.");
		end
		return true;
	end
	
	-- PRINT OUT SPELLS
	if (msg == "spells") then
		if (not WARRIOR.Spells._loaded) then
			WARRIOR.Utils:Print("no spells found.");
			return true;
		end
		
		WARRIOR.Utils:Print("Known Spells:"); 
		for _,spell in WARRIOR.Spells._spellbook do
			WARRIOR.Utils:Print("%s is in action slot [%s].",spell.name,(spell.slot or "x"))
		end
		return true;
	end

	-- TOGGLE THE ACTIONBAR HOOKS
	if (msg == "actionbars on") then
		WARRIOR.Actions._enabled = true;
		WARRIOR.Actions:Activate();
		WARRIOR.Settings:Save("WARRIOR.Actions._enabled");
		WARRIOR.Utils:Print("action bars have been modified.");
		return true;
	end
	if (msg == "actionbars off") then
		WARRIOR.Actions._enabled = false;
		WARRIOR.Actions:Deactivate();
		WARRIOR.Settings:Save("WARRIOR.Actions._enabled");
		WARRIOR.Utils:Print("action bars have been restored.");
		return true;
	end

	-- TOGGLE THE AUTO CHANGE STANCE SETTING
	if (msg == "autostance on") then
		WARRIOR.Player.Stances._auto = 1;
		WARRIOR.Settings:Save("WARRIOR.Player.Stances._auto");
		WARRIOR.Utils:Print("stances will be changed if required by a spell.");
		return true;
	end
	if (msg == "autostance off") then
		WARRIOR.Player.Stances._auto = false;
		WARRIOR.Settings:Save("WARRIOR.Player.Stances._auto");
		WARRIOR.Utils:Print("stances will not be changed if required by a spell.");
		return true;
	end
	
	-- TOGGLE THE RAGE RESERVE
	if (msg == "rage on") then
		WARRIOR.Player.Rage._enabled = 1;
		WARRIOR.Settings:Save("WARRIOR.Player.Rage._enabled");
		WARRIOR.Utils:Print("rage reserve has been enabled.");
		return true;
	end
	if (msg == "rage off") then
		WARRIOR.Player.Rage._enabled = false;
		WARRIOR.Settings:Save("WARRIOR.Player.Rage._enabled");
		WARRIOR.Utils:Print("rage reserve has been disabled.");
		return true;
	end

	-- SET THE RAGE GLOBAL RAGE LIMIT
	local _, _, rage = string.find(msg,'^rage (%d+)$');
	if (rage) then
		WARRIOR.Player.Rage:SetReserve(tonumber(rage));
		WARRIOR.Utils:Print("rage reserve has been set at %s.",rage);
		return true;
	end

	return false;
end

-- *****************************************************************************
-- Function: Help
-- Purpose: all the commands related to help
-- *****************************************************************************
function WARRIOR.UI:Help(msg)
	if (msg ~= "help" and msg ~= "examples") then return; end

	local help = {
		{"/warrior autostance <on/off>","/warrior autostance off"},
		{"/warrior rage <on/off>","/warrior rage on"},
		{"/warrior rage <value>","/warrior rage 35"},
		{"/warrior list"},
		{"/warrior <class> list","/warrior Basic list"},
		{"/warrior <class> add <list-of-spells>","/warrior PVE Tanker add Execute, Rend, Heroic Strike"},
		{"/warrior <class> remove <list-of-spells>","/warrior PVE Tanker remove Rend, Heroic Strike"},
		{"/warrior remove <class>","/warrior remove PVE Tank"},
		{"/warrior use <class>","/warrior use PVE Tank"},
		{"/warrior <class> is <default/fifo>","/warrior PVE Tank is fifo"},
		{"/warrior conditions"},
		{"/warrior <class> conditions","/warrior Basic conditions"},
		{"/warrior <class> remove conditions","/warrior Basic remove conditions"},
		{"/warrior <class> remove <spell> condition <value>","/warrior Basic remove Rend condition 1"},
		{"/warrior <class> use <spell> when <player/target/targettarget> <health/rage/mana/energy> is [not] <over/under/around> <value>[%%]","/warrior Basic use Mortal Stike when target health is over 50%%"},
		{"/warrior <class> use <spell> every <value> seconds","/warrior Basic use Heroic Strike every 20 seconds"},
		{"/warrior <class> use Sunder Armor <1,2,3,4,5,*> times","/warrior Basic use Sunder Armor * times"},
		{"/warrior <class> use <spell> when target is [not] fleeing","/warrior Basic use Hamstring when target is fleeing"},
		{"/warrior <class> use <spell> when <target/targettarget> is [not] a <list-of-classes>","/warrior Basic use Rend when target is not warrior, priest, paladin"},
		{"/warrior <class> use <spell> when [not] in <stance>","/warrior Basic use Shield Block when in Defensive Stance"},
		{"/warrior <class> use <spell> when <list-of-spells> <is/are> on cooldown","/warrior Basic use Heroic Strike when War Stomp, Bloodrage are on cooldown"},
		{"/warrior <class> use <spell> when targets casting [list-of-spells]","/warrior Basic use Pummel when targets casting"},
		{"/warrior <class> use <spell> when player has <list-of-buffs>","/warrior Advanced use Shield Slam when player has Holy Strength, Untamed Fury"},
		{"/warrior immunities <on/off>","/warrior immunities on"},
		{"/warrior immunities wipe"},
		{"/warrior immunities purge"},
		{"/warrior alerts <on/off>","/warrior alerts on"},
		{"/warrior alerts <class/all>","/warrior alerts class"},
		{"/warrior alerts <lock/unlock>","/warrior alerts unlock"},
		{"/warrior alerts fade <value>","/warrior alerts fade 3"},
		{"/warrior actionbars <on/off>","/warrior actionbars on"},
		{"/warrior debug"},
		{"/warrior spells"},
		{"/warrior reset"}
	}
	
	WARRIOR.Utils:Print("SLASH COMMAND GUIDE - for examples %s.","/warrior examples");
	for _,text in help do 
		if (msg == "help" or not text[2]) then WARRIOR.Utils:Print(text[1]) else WARRIOR.Utils:Print(text[2]) end
	end
	
	return true;
end

-- *****************************************************************************
-- Function: Command
-- Purpose: slash command used to interact with the mod
-- *****************************************************************************
function WARRIOR.UI:Command(msg)
	msg = WARRIOR.Utils.String:Trim(msg);

	if (self:Alerts(msg) or self:Conditions(msg) or self:Classes(msg) or self:Immunities(msg) or self:Player(msg) or self:Help(msg)) then
		return true;
	end

	WARRIOR.Utils:Print("Unkown or unsupported command.");
end
