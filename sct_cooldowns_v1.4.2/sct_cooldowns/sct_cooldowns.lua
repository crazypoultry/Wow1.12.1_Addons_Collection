sctcVars = {};

minDuration = 2;
sctc_debug = false;

function sctc_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("SPELL_UPDATE_COOLDOWN");
	this:RegisterEvent("SPELLS_CHANGED");

	SLASH_SCTCCHAT1 = "/sctcooldowns";
	SLASH_SCTCCHAT2 = "/sctc";
	SlashCmdList["SCTCCHAT"] = function(msg)
		sctc_ChatHandler(msg);
	end
end

function sctc_OnEvent(event, arg1)
	if (event == "VARIABLES_LOADED") then
		if (not sctcOptions) then
			sctcOptions = {};
			sctcOptions.on = true;
		end

		if (not sctcOptions["version"]) then
			sctcOptions = nil;
			sctcOptions = {};
			sctcOptions.on = true;
			sctcOptions["version"] = SCTC_VERSION;
			sctcOptions["format"] = "[%s Ready]";
			sctcOptions["wformat"] = "[%s Ready In 10]";
			sctcOptions["color"] = {};
			sctcOptions["color"].r = 1.0;
			sctcOptions["color"].g = 1.0;
			sctcOptions["color"].b = 1.0;
			sctcOptions["crit"] = nil;
			sctcOptions["warning"] = nil;
			sctcOptions["disabled"] = {};
			sctcOptions["groups"] = {};
            		sctcOptions["members"] = {};
		end

		if (not sctcOptions["format"]) then
			sctcOptions["format"] = "[%s Ready]";
		end

		if (not sctcOptions["wformat"]) then
			sctcOptions["wformat"] = "[%s Ready In 10]";
		end

		if (not sctcOptions["color"]) then
			sctcOptions["color"] = {};
			sctcOptions["color"].r = 1.0;
			sctcOptions["color"].g = 1.0;
			sctcOptions["color"].b = 1.0;
		end

		if (not sctcOptions["crit"]) then	
			sctcOptions["crit"] = nil;
		end

		if (not sctcOptions["warning"]) then
			sctcOptions["warning"] = nil;
		end

		if (not sctcOptions["disabled"]) then
			sctcOptions["disabled"] = {};
		end

		if (not sctcOptions["groups"]) then
			sctcOptions["groups"] = {};
		end
        
        	if (not sctcOptions["members"]) then
            	sctcOptions["members"] = {};
       		end
		
		DEFAULT_CHAT_FRAME:AddMessage(SCTC_LOADMSG);
	end
	
	if (event == "SPELLS_CHANGED" or event == "PLAYER_ENTERING_WORLD") then
		sctc_init();
		sctc_updateCooldowns();
	elseif (event == "SPELL_UPDATE_COOLDOWN" and sctcOptions.on == true) then
		sctc_updateCooldowns();	
	end
end

function sctc_OnUpdate()
	for key, val in sctcVars.spells do
		local name = GetSpellName(val, BOOKTYPE_SPELL);
		if (sctcVars["cooldowns"][name] and not sctcOptions["disabled"][name]) then
			local startTime, duration, flag = GetSpellCooldown(val, BOOKTYPE_SPELL);
			local found = false;
			local group;
			for key in SCTC_GROUPS do	sctc_debugp("Checking for match in group: "..key);
				for val in SCTC_GROUPS[key] do
					if (name == SCTC_GROUPS[key][val]) then	sctc_debugp("Match found: "..SCTC_GROUPS[key][val]);
						found = true;
						group = key;
					end
				end
			end
			if (sctcOptions["warning"] ~= nil) then
				local timeleft;
				timeleft = floor(sctcVars["cooldowns"][name] + duration - GetTime());
				if (timeleft == sctcOptions["warning"] and sctcVars["warnings"][name]) then sctc_debugp("Time left: "..timeleft);
					if (found) then
						SCT_Display(string.format(sctcOptions["wformat"], group), sctcOptions["color"], sctcOptions["crit"]);
						for key, val in SCTC_GROUPS[group] do	sctc_debugp("Clearing warning: "..val);
							sctcVars["warnings"][val] = nil;
						end
					else
						SCT_Display(string.format(sctcOptions["wformat"], name), sctcOptions["color"], sctcOptions["crit"]);
						sctcVars["warnings"][name] = nil;
					end
				end
			end
			if (duration == 0) then	sctc_debugp(name.."'s duration is 0");
				if (found) then
					SCT_Display(string.format(sctcOptions["format"], group), sctcOptions["color"], sctcOptions["crit"]);
					for key, val in SCTC_GROUPS[group] do	sctc_debugp("Clearing cooldown: "..val);
						sctcVars["cooldowns"][val] = nil;
					end
				else
					SCT_Display(string.format(sctcOptions["format"], name), sctcOptions["color"], sctcOptions["crit"]);
					sctcVars["cooldowns"][name] = nil;
				end
				sctcVars.numCds = sctcVars.numCds - 1;
			end
		end
	end
end

function sctc_ChatHandler(msg)
	local command = "";

	if (msg) then
		command = string.lower(msg);
	end

	if (command == "on") then
		if (sctcOptions.on == false) then
			sctcOptions.on = true;
			DEFAULT_CHAT_FRAME:AddMessage(SCTC_TURNEDON);
		else
			DEFAULT_CHAT_FRAME:AddMessage(SCTC_ALREADYON);
		end
	elseif (command == "off") then
		if (sctcOptions.on == true) then
			sctcOptions.on = false;
			sctc_init();
			DEFAULT_CHAT_FRAME:AddMessage(SCTC_TURNEDOFF);
		else
			DEFAULT_CHAT_FRAME:AddMessage(SCTC_ALREADYOFF);
		end
	elseif (string.sub(command, 1, 6) == "format") then
		local formatstr = "";
		if (string.len(msg) > 7) then
			formatstr = string.sub(msg, 8);
		else
			DEFAULT_CHAT_FRAME:AddMessage(FORMATERROR);
			return;
		end

		if (formatstr == "reset") then
			sctcOptions["format"] = "[%s Ready]";
			DEFAULT_CHAT_FRAME:AddMessage(SCTC_FORMATRESET);
		else
			sctcOptions["format"] = formatstr;
			DEFAULT_CHAT_FRAME:AddMessage(SCTC_FORMATSET..sctcOptions["format"]);
		end
	elseif (string.sub(command, 1, 5) == "color") then
		for r,g,b in string.gfind( msg, "color ([%d.]+) ([%d.]+) ([%d.]+)" ) do
			sctcOptions["color"].r = r;
			sctcOptions["color"].g = g;
			sctcOptions["color"].b = b;
		end
		DEFAULT_CHAT_FRAME:AddMessage(SCTC_COLORSET);
	elseif (string.sub(command, 1, 4) == "crit") then
		local parameter = "";
		if (string.len(command) > 5) then
			parameter = string.sub(command, 6);
		else
			parameter = sctcOptions["crit"];
		end
		
		if (parameter == "true") then
			sctcOptions["crit"] = 1;
			DEFAULT_CHAT_FRAME:AddMessage(SCTC_CRITTRUE);
		elseif (parameter == "false") then
			sctcOptions["crit"] = nil;
			DEFAULT_CHAT_FRAME:AddMessage(SCTC_CRITFALSE);
		end
	elseif (string.sub(command, 1, 7) == "disable") then
		local parameter = "";
		if (string.len(command) > 8) then
			parameter = string.sub(msg, 9);
			if (not sctcOptions["disabled"][parameter]) then
				sctcOptions["disabled"][parameter] = true;
				DEFAULT_CHAT_FRAME:AddMessage(SCTC_DISABLED);
			else
				sctcOptions["disabled"][parameter] = nil;
				DEFAULT_CHAT_FRAME:AddMessage(SCTC_ENABLED);
			end
		else
			sctc_help();
			return;
		end
	elseif (command == "list") then
		DEFAULT_CHAT_FRAME:AddMessage(SCTC_DISABLEDLIST);
		for key, val in sctcOptions["disabled"] do
			DEFAULT_CHAT_FRAME:AddMessage("- "..key);
	 	end
	elseif (string.sub(command, 1, 7) == "warning") then
		local warningtime = "";
		for a in string.gfind(command, "warning (%d+)") do
			if (a == "0") then
				warningtime = nil;
				DEFAULT_CHAT_FRAME:AddMessage(SCTC_WARNINGDISABLED);
			elseif (a == nil) then
				warningtime = sctcOptions["warning"];
				DEFAULT_CHAT_FRAME:AddMessage(SCTC_WARNINGERROR);
			else
				warningtime = tonumber(a);
				DEFAULT_CHAT_FRAME:AddMessage(SCTC_WARNINGENABLED..a);
			end
		end
		sctcOptions["warning"] = warningtime;
	elseif (string.sub(command, 1, 7) == "wformat") then
		local formatstr = "";
		if (string.len(msg) > 8) then
			formatstr = string.sub(msg, 9);
		else
			DEFAULT_CHAT_FRAME:AddMessage(WFORMATERROR);
			return;
		end

		if (formatstr == "reset") then
			sctcOptions["wformat"] = "[%s Ready In 10]";
			DEFAULT_CHAT_FRAME:AddMessage(SCTC_FORMATRESET);
		else
			sctcOptions["wformat"] = formatstr;
			DEFAULT_CHAT_FRAME:AddMessage(SCTC_FORMATSET..sctcOptions["wformat"]);
		end
	elseif (string.sub(command, 1, 5) == "debug") then
		if (sctc_debug == false) then
			sctc_debug = true;
		else
			sctc_debug = false;
		end
	else
		sctc_help();
	end
end

function sctc_init()
	sctcVars.numSpells = 1;
	sctcVars.spells = {};
	sctcVars.cooldowns = {};
	sctcVars.warnings = {};
	sctcVars.numCds = 0;
	sctcVars.numTabs = 1;
	sctcVars.tabs = {};

	while (GetSpellTabInfo(sctcVars.numTabs)) do
		sctcVars.tabs[sctcVars.numTabs] = {};
		local name, _, offset, numSpells = GetSpellTabInfo(sctcVars.numTabs);

		sctcVars.tabs[sctcVars.numTabs].name = name;
		sctcVars.tabs[sctcVars.numTabs].offset_start = offset + 1;
		sctcVars.tabs[sctcVars.numTabs].offset_end = offset + numSpells;

		sctcVars.numTabs = sctcVars.numTabs + 1;
	end

	local currTab = 1;
	while (GetSpellName(sctcVars.numSpells, BOOKTYPE_SPELL)) do
		local name = GetSpellName(sctcVars.numSpells, BOOKTYPE_SPELL);
		local nextName = GetSpellName(sctcVars.numSpells+1, BOOKTYPE_SPELL);
		if (name ~= nextName) then
			table.insert(sctcVars.spells, sctcVars.numSpells);

			while (sctcVars.numSpells > sctcVars.tabs[currTab].offset_end) do
				currTab = currTab + 1;
			end
			
			if not sctcVars.tabs[currTab].spells then
				sctcVars.tabs[currTab].spells = {};
			end

			table.insert(sctcVars.tabs[currTab].spells, sctcVars.numSpells);
				
		end
		
		sctcVars.numSpells = sctcVars.numSpells + 1;
	end
end

function sctc_updateCooldowns()
	sctcVars.numCds = 0;
	for key, val in sctcVars.spells do
		local startTime, duration, flag = GetSpellCooldown(val, BOOKTYPE_SPELL);
		local name = GetSpellName(val, BOOKTYPE_SPELL);

		if (duration > minDuration) then
			if (startTime ~= sctcVars["cooldowns"][name]) then
				if (not sctcOptions["disabled"][name]) then
					sctcVars["cooldowns"][name] = startTime; sctc_debugp(name.." added to cooldowns");
					if (sctcOptions["warning"] ~= nil and duration > sctcOptions["warning"]) then
						sctcVars["warnings"][name] = startTime;	sctc_debugp(name.." added to warnings");
					end
					sctcVars.numCds = sctcVars.numCds + 1;
				end
			end
		end
	end	
end

function sctc_help()
	for key, val in SCTC_HELP do
		DEFAULT_CHAT_FRAME:AddMessage(val);
	end
end

function sctc_debugp(msg)
	if (sctc_debug == true) then
		ChatFrame2:AddMessage(SCTC_MSG..msg);
	end
end