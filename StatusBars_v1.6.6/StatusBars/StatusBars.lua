-- StatusBars.lua, Daniel Wesslén <wesslen@users.sourceforge.net>

-- fixed defaults
local BarSpacing = 18;
local DefaultBGAlpha = 0.35;
local FlashBGAlpha = 0.8;
local FlashDuration = 0.5;
local ComboFlashDuration = 0.25;
local MaxBuffs = 8; 			-- requires StatusBars.php
local FadeInDuration = 0.2;
local FadeOutDuration = 1.5;

-- possible values for the 'enable' setting
local EnableAlways = 'always';
local EnableInCombat = 'combat';
local EnableInCombatOnly = 'combatonly';
local EnableNondefault = 'auto';
local EnableNever = 'never';

-- possible values for the 'percentage' setting
local PercentageLeft = 'left';
local PercentageRight = 'right';
local PercentageNone = 'none';

-- defaults for user-configurable settings
local DefaultEnable = EnableInCombat;
local DefaultWarnLimit = 0.6;
local DefaultText = '&cur / &max';
local DefaultPercentage = PercentageRight;
local DefaultPercentageText = '&frac%';
local DefaultAlpha = 1;

local DefaultTextColor = 'white';
local DefaultPercentageTextColor = 'ffd100';
local DefaultHealthColor = '<25%:red <50%:orange <75%:yellow green';
local DefaultManaColor = 'blue';
local DefaultRageColor = 'red';
local DefaultEnergyColor = 'yellow';
local DefaultFocusColor = 'orange';
local DefaultComboColor = 'red';
local DefaultHappinessColor = '<50%:red <90%:yellow green';

-- bar information containers
local health = {};
local power = {}; -- mana/rage/energy depending on class
local combo = {};
local druid = {};
local buff = {};
local debuff = {};
local targetHealth = {};
local targetPower = {};
local targetBuff = {};
local targetDebuff = {};
local petHealth = {};
local petPower = {};
local happiness = {};
local petBuff = {};
local petDebuff = {};

local bars = {
	health, power, combo, druid, buff, debuff,
	targetHealth, targetPower, targetDebuff, targetBuff,
	petHealth, petPower, happiness, petBuff, petDebuff
};

local playerLogicals = { 'health', 'mana', 'rage', 'energy', 'focus', 'combo', 'druid', 'buff', 'debuff' };
local targetLogicals = { 'thealth', 'tmana', 'trage', 'tenergy', 'tfocus', 'tdebuff', 'tbuff' };
local petLogicals = { 'phealth', 'pmana', 'prage', 'penergy', 'pfocus', 'phappy', 'pbuff', 'pdebuff' };

local groupedBars = {};
local tickingBars = {};

local groupContainers = {
	Player = true,
	Target = true,
	Pet = true,
	Group1 = true,
	Group2 = true,
	Group3 = true,
	Group4 = true,
	Group5 = true
};

-- Settings:
--
--	enable: when the bar should be visible
--	   EnableAlways
--	   EnableInCombat:	when in combat and when the property has a non-default value
--	   EnableNondefault:	when the property has a non-default value
--	   EnableNever
--	flash: if the bar should flash when the property is far from the default value
--	warn: distance from the default value at which the bad will flash (i.e. 0.6 = 40% left)
--	text: if current / max should be written on the bar
--	percentage: percentage display (none/left/right)
--	color: (for health only) if the bar should change color ti illustrate the value
--
StatusBars_Settings5 = {};
StatusBars_locked = false;

local playerName = '';
local variables_loaded = false;
local load_time = 0;
local fully_initialized = false;

-- default settings
local function defaultMana() return {
	flash = true,
	color = DefaultManaColor,
}; end
local function defaultRage() return {
	color = DefaultRageColor,
}; end
local function defaultEnergy() return {
	color = DefaultEnergyColor,
}; end
local function defaultFocus() return {
	color = DefaultFocusColor,
}; end
local function defaultBuff(visible)
	t = {
		text = '',
		ptext = '',
	};
	if visible then
		t.enable = EnableInCombatOnly;
	else
		t.enable = EnableNever;
	end
	return t;
end
local function targetDefaultBuff() return {
	text = '',
	ptext = '',
}; end
local defaultSettings = {
	health = {
		flash = true,
		color = DefaultHealthColor,
	},
	mana = defaultMana(),
	rage = defaultRage(),
	energy = defaultEnergy(),
	focus = defaultFocus(),
	combo = {
		text = '',
		percentage = PercentageNone,
		color = DefaultComboColor,
	},
	druid = {
		color = DefaultManaColor,
		enable = EnableNondefault,
	},
	buff = defaultBuff(false),
	debuff = defaultBuff(),
	thealth = {
		text = '&rank &name',
		color = DefaultHealthColor,
	},
	tmana = defaultMana(),
	trage = defaultRage(),
	tenergy = defaultEnergy(),
	tfocus = defaultFocus(),
	tbuff = targetDefaultBuff(),
	tdebuff = targetDefaultBuff(),
	phealth = {
		text = '&name',
		color = DefaultHealthColor,
	},
	pmana = defaultMana(),
	prage = defaultRage(),
	penergy = defaultEnergy(),
	phappy = {
		text = '&happy',
		flash = true,
		warn = 0.5,
		color = DefaultHappinessColor,
		percentage = PercentageNone,
		enable = EnableNondefault,
	},
	pfocus = defaultFocus(),
	pbuff = defaultBuff(false),
	pdebuff = defaultBuff(),
};

local function consolePrint(msg)
	DEFAULT_CHAT_FRAME:AddMessage('StatusBars: ' .. msg);
end

local function clone(x)
	if type(x) == 'table' then
		local t = {};
		table.foreach(x,
			function(key, val)
				t[key] = clone(val);
			end
		);
		return t;
	else
		return x;
	end
end

-- set global defaults (does not override already set values)
local function setDefault(which, value)
	table.foreach(defaultSettings,
		function(logical, ops)
			if ops[which] == nil then
				ops[which] = value;
			end
		end
	);
end
local function setDefaultGroup(group, logicals)
	table.foreach(logicals,
		function(i, logical)
			defaultSettings[logical]['group'] = group;
		end
	);
end
setDefault('enable', DefaultEnable);
setDefault('text', DefaultText);
setDefault('warn', DefaultWarnLimit);
setDefault('flash', false);
setDefault('alpha', DefaultAlpha);
setDefault('percentage', DefaultPercentage);
setDefault('ptext', DefaultPercentageText);
setDefault('scale', 1);
setDefault('tcolor', DefaultTextColor);
setDefault('pcolor', DefaultPercentageTextColor);
setDefaultGroup('player', playerLogicals);
setDefaultGroup('target', targetLogicals);
setDefaultGroup('pet', petLogicals);

defaultSettings.tbuff.warn = nil;
defaultSettings.tbuff.flash = nil;

local function round(x) return floor(x + 0.5); end
local function trim(text) return string.gsub(text, "%s*(.-)%s*$", "%1", 1); end

-- get option
local function optionT(logical, which)
	local value = nil;
	local t;
	if playerName ~= '' then
		t = StatusBars_Settings5[playerName];
		if t ~= nil then
			t = t[logical];
			if t ~= nil then
				value = t[which];
			end
		end
	end
	if value == nil then
		t = defaultSettings[logical];
		if t == nil then
			return nil;
		elseif (logical == 'thealth' or logical == 'phealth')
			and which == 'text' and MobHealthFrame ~= nil then
			return DefaultText;
		else
			return t[which];
		end
	else
		return value;
	end
end
local function option(vars, which)
	return optionT(vars.logical, which);
end

--set option
local function setOptionT(logical, which, value)
	local char = StatusBars_Settings5[playerName];
	if char == nil then
		char = {};
		StatusBars_Settings5[playerName] = char;
	end
	local l = char[logical];
	if l == nil then
		l = {};
		char[logical] = l;
	end
	l[which] = value;
end

local function assignGroups()
	groupedBars = {};
	table.foreach(groupContainers,
		function(uname, t)
			local lname = string.lower(uname);
			groupedBars[lname] = { n = 0, name = uname };
		end
	);
	table.foreachi(bars,
		function(i, vars)
			local vars = bars[i];
			if vars.logical == nil then
				-- not fully loaded yet
				return;
			end
			local g = option(vars, 'group');
			table.insert(groupedBars[g], vars);
		end
	);
end

-- place the active bars
-- used to remove the empty space where the combo bar would be when in bear form
local function sortBars(gbars, container)
	local pos = 0;
	local cname = 'StatusBars_' .. container .. 'Container';
	local cvar = getglobal(cname);
	table.foreachi(gbars,
		function(i, vars)
			if not vars.never and (vars.visible or (vars.softEnable and not vars.nospace)) then
				vars.frame:SetPoint('TOP', cname, 'TOP', 0, pos);
				pos = pos - BarSpacing;
			end
		end
	);
	cvar:SetHeight(abs(pos)+1);
end
local function sortGroupBars(name)
	local g = groupedBars[name];
	if g then
		sortBars(g, g.name);
	end
end
local function sortNeighborBars(vars)
	sortGroupBars(option(vars, 'group'));
end
local function sortAllBars()
	table.foreach(groupContainers,
		function(uname, t)
			local lname = string.lower(uname);
			sortGroupBars(lname);
		end
	);
end

-- show or hide frame
local function showFrame(frame, visible)
	if visible then frame:Show(); else frame:Hide(); end
end

-- common text visibility update (for when settings changed)
local function updateTextVisibility(vars)
	local p = option(vars, 'percentage');
	showFrame(vars.text, option(vars, 'text') ~= '');
	showFrame(vars.ptext, p ~= PercentageNone and option(vars, 'ptext') ~= '');
	if p == PercentageLeft then
		vars.ptext:SetPoint('CENTER', '$Parent', 'CENTER', -171, 1);
		vars.ptext:SetJustifyH('RIGHT');
	elseif p == PercentageRight then
		vars.ptext:SetPoint('CENTER', '$Parent', 'CENTER', 170, 1);
		vars.ptext:SetJustifyH('LEFT');
	end
end

-- get the color a bar or text is supposed to have
local function getBarColor(vars, prefix)
	local colt = vars[prefix .. 'colorrules'];
	local rules = colt.rules;
	local i;
	for i = 1, table.getn(rules) do
		local rule = rules[i];
		c = rule(vars);
		if c ~= nil then
			return c;
		end
	end
	return colt.default;
end
local function updateTextColors(vars)
	local tc = getBarColor(vars, 't');
	local pc = getBarColor(vars, 'p');
	vars.text:SetTextColor(tc[1], tc[2], tc[3]);
	vars.ptext:SetTextColor(pc[1], pc[2], pc[3]);
end

-- return a { r,g,b } table representing the color mentioned in the string
-- accepts named colors and rgb/rrggbb hexadecimal
local function parseColor(s)
	if s == 'red' then
		return { 1, 0, 0 };
	elseif s == 'green' then
		return { 0, 1, 0 };
	elseif s == 'blue' then
		return { 0, 0, 1 };
	elseif s == 'cyan' then
		return { 0, 1, 1 };
	elseif s == 'magenta' then
		return { 1, 0, 1 };
	elseif s == 'yellow' then
		return { 1, 1, 0 };
	elseif s == 'orange' then
		return { 1, 0.5, 0 };
	elseif s == 'white' then
		return { 1, 1, 1 };
	elseif s == 'black' then
		return { 0, 0, 0 };
	else
		local i,j, r,g,b = string.find(s, '^(%x)(%x)(%x)$');
		if i then
			return { tonumber(r, 16) / 15, tonumber(g, 16) / 15, tonumber(b, 16) / 15 };
		end
		i,j, r,g,b = string.find(s, '^(%x%x)(%x%x)(%x%x)$');
		if i then
			return { tonumber(r, 16) / 255, tonumber(g, 16) / 255, tonumber(b, 16) / 255 };
		end
		consolePrint(STATUSBARS_INVALID_COLOR .. s .. '".');
	end
end

-- compile the color selection rules in the string
-- returns a table containing default color and rule functions
local function compileColorRules(colorstring)
	local rules = {}
	local ruleslist = { n = 0 }
	-- for all spans
	for span in string.gfind(colorstring, '([^%s]+)') do
		-- find conditional color expression
		local i,j, op, value, percentage, col = string.find(span, '^([<>=!~]=?)(%d+)(%%?):(%w+)$');
		if i == nil then
			-- no conditional, look for default color
			i,j, col = string.find(span, '^(%w+)$');
			if i == nil then
				consolePrint(STATUSBARS_INVALID_COLOR .. colorstring .. '".');
				return;
			elseif rules.default ~= nil then
				consolePrint(STATUSBARS_MULTIPLE_DEFAULT_COLOR .. colorstring .. '".');
				return;
			else
				-- unique color found, set default if the color is valid
				col = parseColor(col);
				if col == nil then return end;
				rules.default = col;
			end
		else
			-- conditional found
			col = parseColor(col);
			if col == nil then return end;

			-- create limit value getter
			value = tonumber(value);
			local get;
			if percentage == '%' then
				get = function(vars) return vars.lastFraction*100 end;
			else
				get = function(vars) return vars.lastValue end;
			end

			-- create comparison function
			local cmp;
			if op == '=' or op == '==' then
				cmp = function(vars) return get(vars) == value end;
			elseif op == '!=' or op == '~=' then
				cmp = function(vars) return get(vars) ~= value end;
			elseif op == '<' then
				cmp = function(vars) return get(vars) < value end;
			elseif op == '>' then
				cmp = function(vars) return get(vars) > value end;
			elseif op == '<=' then
				cmp = function(vars) return get(vars) <= value end;
			elseif op == '>=' then
				cmp = function(vars) return get(vars) >= value end;
			else
				consolePrint(STATUSBARS_UNKNOWN_OPERATOR .. op .. '".');
				return;
			end

			-- create final rule
			local rule = function(vars)
				if cmp(vars) then
					return col;
				end
			end;
			table.insert(ruleslist, rule);
		end
	end

	-- check that there is a default color
	if rules.default == nil then
		consolePrint(STATUSBARS_NO_DEFAULT_COLOR .. colorstring .. '".');
		return;
	end

	rules.rules = ruleslist;
	return rules;
end

-- update background and flash texture
local function updateFlashDisplayCommon(vars, barvars)
	local level = vars._flashLevel;
	local extra = barvars._extraFlash or 0;
	local sum = level + extra;
	if sum > 0.01 then
		-- set background color
		barvars._flashActive = true;
		local a = level*FlashBGAlpha + (1-level)*DefaultBGAlpha;
		vars.frame:SetBackdropColor(level, 0, 0, a);

		-- show flash overlay and update color
		barvars.foverlay:SetVertexColor(level*FlashBGAlpha + extra, extra, extra);
		barvars.foverlay:Show();

	elseif barvars._flashActive ~= false then
		-- reset background color and hide flash overlay
		barvars._flashActive = false;
		barvars.frame:SetBackdropColor(0, 0, 0, DefaultBGAlpha);
		barvars.foverlay:Hide();
	end
end

-- stop flashing immediately
local function abortFlashCommon(vars)
	vars.flash = false;
	vars._flashing = false;
	vars._lastFlashTime = 0;
	vars._flashLevel = 0;
	vars:updateFlashDisplay();
end
-- update flashing background
local function updateFlashCommon(vars, force)
	if vars._flashing or force then
		local time = GetTime();
		local d = time - vars._lastFlashTime;
		if d < 0 or d > FlashDuration then
			d = 0;
			if vars.flash then
				vars._lastFlashTime = time;
			else
				vars._flashing = false;
				vars._lastFlashTime = 0;
				vars._flashLevel = 0;
				vars:updateFlashDisplay();
				return;
			end
		end
		local c = 1 - abs(d - FlashDuration*0.5) / (FlashDuration*0.5);
		vars._flashLevel = c;
		vars:updateFlashDisplay();
	end
end
-- start flashing
local function startFlash(vars)
	vars.flash = true;
	vars._flashing = true;
	vars:updateFlash();
end
-- stop flashing softly
local function stopFlash(vars)
	vars.flash = false;
	vars:updateFlash();
end

-- convenience function for updating all dynamic state of a bar
local function update(vars)
	-- dummy version, replaced by update_real when settings are loaded
end
local function update_real(vars)
	vars:onEvent(nil);
end

-- update bar to match new settings
local function updateSettings(vars)
	vars.never = option(vars, 'enable') == EnableNever;
	if vars.never then
		tickingBars[vars] = nil;
	end
	local cs = option(vars, 'color');
	if cs then
		vars.colorrules = compileColorRules(cs);
	end
	vars.tcolorrules = compileColorRules(option(vars, 'tcolor'));
	vars.pcolorrules = compileColorRules(option(vars, 'pcolor'));
	vars.settingsLoaded = true;
	updateTextVisibility(vars);
	vars:abortFlash();
	if vars.visible then
		vars.frame:SetAlpha(option(vars, 'alpha'));
	end
	update(vars);
	vars:updateColor();
	showFrame(vars.frame, not vars.never);
	assignGroups();
	sortNeighborBars(vars);
end
local function updateAllSettings()
	table.foreach(bars,
		function(key, val)
			updateSettings(val);
		end
	);
end

-- common OnEvent
local function eventCommon(vars, event)
	if event == 'VARIABLES_LOADED' then
		variables_loaded = true;
	end
	if variables_loaded and UnitExists('player') then
		local pn = UnitName('player');
		if playerName ~= pn and pn ~= nil and pn ~= UNKNOWNBEING and pn ~= UKNOWNBEING and pn ~= UNKNOWNOBJECT then
			playerName = pn;
			load_time = GetTime() + 1;
		end
	end
end
local function eventCommon_real(vars, event)
	if event == 'PLAYER_ENTERING_WORLD' then
		vars._inCombat = false;
		vars._hasAggro = false;
	elseif event == 'PLAYER_ENTER_COMBAT' then
		vars._inCombat = true;
	elseif event == 'PLAYER_LEAVE_COMBAT' then
		vars._inCombat = false;
	elseif event == 'PLAYER_REGEN_DISABLED' then
		vars._hasAggro = true;
	elseif event == 'PLAYER_REGEN_ENABLED' then
		vars._hasAggro = false;
	end
end

local function notifyingFade(vars, frame, mode, time, start, end_)
	vars.fading = true;
	local fade = {};
	fade.mode = mode;
	fade.timeToFade = time;
	fade.startAlpha = start;
	fade.endAlpha = end_;
	fade.finishedFunc = function()
		vars.fading = false;
		vars:onEvent();
		sortNeighborBars(vars);
	end;
	UIFrameFade(frame, fade);
end

-- fade frame in or out if needed
local function fadeFrame(vars, visible)
	local frame = vars.frame;
	local current = vars.targetVisibility;
	if current ~= visible then
		sortNeighborBars(vars);
		local alpha = option(vars, 'alpha');
		if visible then
			notifyingFade(vars, frame, 'IN', FadeInDuration, frame:GetAlpha(), alpha);
		else
			notifyingFade(vars, frame, 'OUT', FadeOutDuration, frame:GetAlpha(), 0);
		end
		vars.targetVisibility = visible;
	end
end

-- common bar update
-- determines visibility, updates text and handles flash activation
local function updateCommon(vars)
	-- dummy version, replaced by updateCommon_real when settings are loaded
end
local function updateCommon_real(vars)
	-- get values
	local curV = vars.getCurrent();
	local maxV = vars.getMax();
	local fraction = 0;
	if curV > 0.001 and maxV > 0.001 then
		fraction = curV / maxV;
	end

	local oldvis = vars.visible;

	-- store values
	vars.lastValue = curV;
	vars.lastMax = maxV;
	vars.lastFraction = fraction;

	-- determine visibility
	local enable = option(vars, 'enable');
	local show = false;
	local update = true;
	if vars.never or not vars.softEnable or maxV == 0 then
		show = false;
		update = false;
	elseif enable == EnableAlways then
		show = true;
	elseif UnitIsDeadOrGhost('player') then
		show = false;
	elseif (enable == EnableInCombat or enable == EnableInCombatOnly) and (vars._inCombat or vars._hasAggro) then
		show = true;
	elseif enable ~= EnableInCombatOnly then
		show = (fraction ~= vars.default);
	end

	-- update bar visibility
	fadeFrame(vars, show);
	vars.visible = show or vars.fading;

	if show or oldvis then
		-- update text and bar
		if update and vars.settingsLoaded then
			vars:updateValueDisplay();
		end

		-- update scale
		vars.frame:SetScale(option(vars, 'scale'));

		-- update flashing
		local d = abs(fraction - vars.default);
		if maxV == 0 then
			stopFlash(vars);
		elseif option(vars, 'flash') and d > option(vars, 'warn') then
			startFlash(vars);
		else
			stopFlash(vars);
		end
		vars:updateTickEnable();
	end
end

-- update power type (mana/rage/energy)
local function updatePowerType(vars, unit, logicalPrefix)
	local exists = UnitExists(unit);
	local index;

	-- update first time and when index has changed
	if exists and UnitManaMax(unit) > 0 then
		index = UnitPowerType(unit);
	else
		index = vars._lastIndex or 0;
	end
	if index == vars._lastIndex then
		return;
	end
	vars._lastIndex = index;

	-- update bar color and default value
	vars.default = 1;
	if index == 0 then
		-- mana
		vars.logical = logicalPrefix .. 'mana';
	elseif index == 1 then
		-- rage
		vars.default = 0;
		vars.logical = logicalPrefix .. 'rage';
	elseif index == 2 then
		-- focus
		vars.logical = logicalPrefix .. 'focus';
	elseif index == 3 then
		-- energy
		vars.logical = logicalPrefix .. 'energy';
	elseif index == 4 then
		-- happiness
		vars.logical = logicalPrefix .. 'mana';
	end

	updateSettings(vars);
end

-- determine if the combo bar should be visible and update if needed
local function updateComboEnable()
	local t = (UnitPowerType('player') == 3) or combo:getCurrent() > 0;
	if combo._hasCombo ~= t then
		combo._hasCombo = t;
		combo.softEnable = t;
		updateCommon(combo);
	end
end

-- update bar for other unit
local function updateOtherUnitCommon(vars)
	local t = UnitExists(vars.unit) and not UnitIsDeadOrGhost(vars.unit);
	if t ~= vars._unitExists then
		vars._unitExists = t;
		vars.softEnable = t;
		updateCommon(vars);
	end
end

-- detect druid mana updates
local function updateDruid()
	local c = druid:getCurrent();
	local m = druid:getMax();
	if c ~= druid.lastValue or m ~= druid.lastMax then
		updateCommon(druid);
	end
end
-- update druid mana visibility
local function updateDruidEnable()
	local hasDBar = DruidBar_keepthemana ~= nil or DruidBarKey ~= nil;
	local t = hasDBar and UnitPowerType('player') ~= 0 and UnitClass('player') == STATUSBARS_DRUID;
	if t ~= druid._druidEnabled then
		druid._druidEnabled = t;
		druid.softEnable = t;
		updateCommon(druid);
	end
end
-- update buff icons
local function updateBuffs(vars, display)
	local num = 0;
	local live = not UnitIsDeadOrGhost(vars.unit);
	for i = 1, MaxBuffs do
		local buff;
		if live then
			buff = vars.buffFunc(vars.unit, i);
		end
		if buff then
			num = num + 1;
		end
		if display then
			if buff then
				vars.textures[i]:Show();
				vars.textures[i]:SetTexture(buff);
			else
				vars.textures[i]:Hide();
			end
		end
	end
	vars._numBuffs = num;
end

-- print option value
local function printOption(target, cmd)
	local t = optionT(target, cmd);
	if type(t) == 'boolean' then
		if t == true then
			t = 'on';
		else
			t = 'off';
		end
	end
	consolePrint(target .. '.' .. cmd .. ' = ' .. t);
end
-- apply an option to a single target
local function applyOption(target, cmd, value, report)
	local current = optionT(target, cmd);
	if current == nil then
		consolePrint(STATUSBARS_INVALID_TARGET .. target .. STATUSBARS_OR_OPTION .. cmd .. '".');
		return false;
	end

	local t;
	if value == 'print' then
		printOption(target, cmd);
		return;
	elseif value == 'reset' then
		setOptionT(target, cmd, nil);
		printOption(target, cmd);
		return;
	elseif cmd == 'color' then
		if compileColorRules(value) then
			t = value;
		else
			return false;
		end
	elseif cmd == 'enable' then
		if value == EnableAlways or value == EnableInCombat or value == EnableInCombatOnly
			or value == EnableNondefault or value == EnableNever then
			t = value;
		end
	elseif cmd == 'group' then
		table.foreach(groupContainers,
			function(name, val)
				if string.lower(name) == value then
					t = value;
				end
			end
		);
	elseif type(current) == 'number' then
		if string.find(value, '^-?[0-9]+%.?[0-9]*$') then
			t = tonumber(value);
		end
	elseif type(current) == 'boolean' then
		if value == 'on' then
			t = true;
		elseif value == 'off' then
			t = false;
		end
	else
		t = value;
	end
	if t == nil then
		if report then
			consolePrint(STATUSBARS_INVALID_VALUE .. value .. STATUSBARS_FOR_OPTION .. cmd .. '".');
			return false;
		else
			return;
		end
	end
	setOptionT(target, cmd, t);
	printOption(target, cmd);
end

-- slash command handler
-- needs improvement
local function slashHandler(command)
	local i,j, target, cmd, value, name;
	i,j, cmd, name = string.find(command, '^([a-z]+)[ ]+([^ ]+)$');
	if command == 'lock' then
		StatusBars_locked = true;
		consolePrint(STATUSBARS_LOCKED);
		return;
	elseif command == 'unlock' then
		StatusBars_locked = false;
		consolePrint(STATUSBARS_UNLOCKED);
		return;
	elseif cmd == 'load' then
		local t = StatusBars_Settings5[name];
		if name == 'defaults' then
			StatusBars_Settings5[playerName] = {};
			consolePrint(STATUSBARS_DEFAULTS_LOADED);
			updateAllSettings();
		elseif t then
			StatusBars_Settings5[playerName] = clone(t);
			consolePrint(STATUSBARS_LOADED .. name .. '"');
			updateAllSettings();
		else
			consolePrint(STATUSBARS_LOAD_NONEXISTANT .. name .. '"');
		end
		return;
	elseif cmd == 'save' then
		if name == 'defaults' then
			consolePrint(STATUSBARS_NO_SAVEDEFAULTS);
		else
			StatusBars_Settings5[name] = clone(StatusBars_Settings5[playerName]);
			consolePrint(STATUSBARS_SAVED .. name .. '"');
		end
		return;
	end

	i,j, target, cmd, value = string.find(command, '^([a-z]+)[ ]+([a-z]+)[ ]*(.*)$');
	if value == '' and cmd ~= 'text' and cmd ~= 'ptext' then
		value = nil;
	end
	if value == nil then
		consolePrint(STATUSBARS_SYNTAX_LOCK);
		consolePrint(STATUSBARS_SYNTAX_LOAD);
		consolePrint(STATUSBARS_SYNTAX);
		consolePrint(STATUSBARS_TARGETS);
		consolePrint('  all, player, target, pet, power, tpower, ppower, ');
		consolePrint('  health, mana, rage, energy, focus, combo, druid, buff, debuff, ');
		consolePrint('  thealth, tmana, trage, tenergy, tfocus, tdebuff, tbuff, ');
		consolePrint('  phealth, pmana, prage, penergy, pfocus, phappy, pbuff, pdebuff');
		consolePrint(STATUSBARS_OPTIONS);
		consolePrint('  alpha (decimal, default=' .. DefaultAlpha .. ')');
		consolePrint('  enable (always/never/combat/combatonly/auto)');
		consolePrint('  color, tcolor, pcolor (string, see Readme.html)');
		consolePrint('  flash (on/off)');
		consolePrint('  group (player/target/pet/group1/group2/...)');
		consolePrint('  percentage (none/left/right, default=' .. DefaultPercentage .. ')');
		consolePrint('  ptext (string, default=' .. DefaultPercentageText .. ', see Readme.html)');
		consolePrint('  scale (decimal, default=1)');
		consolePrint('  text (string, see Readme.html or print the current value)');
		consolePrint('  warn (decimal, default=' .. DefaultWarnLimit .. ')');
	elseif target == 'all' then
		table.foreach(defaultSettings,
			function(key, val)
				return applyOption(key, cmd, value, false);
			end
		);
	elseif target == 'power' then
		applyOption('mana', cmd, value, true);
		applyOption('rage', cmd, value, true);
		applyOption('energy', cmd, value, true);
		applyOption('focus', cmd, value, true);
	elseif target == 'player' then
		applyOption('health', cmd, value, true);
		applyOption('mana', cmd, value, true);
		applyOption('rage', cmd, value, true);
		applyOption('energy', cmd, value, true);
		applyOption('focus', cmd, value, true);
		applyOption('combo', cmd, value, true);
		applyOption('druid', cmd, value, true);
		applyOption('buff', cmd, value, true);
		applyOption('debuff', cmd, value, true);
	elseif target == 'tpower' then
		applyOption('tmana', cmd, value, true);
		applyOption('trage', cmd, value, true);
		applyOption('tenergy', cmd, value, true);
		applyOption('tfocus', cmd, value, true);
	elseif target == 'target' then
		applyOption('thealth', cmd, value, true);
		applyOption('tmana', cmd, value, true);
		applyOption('trage', cmd, value, true);
		applyOption('tenergy', cmd, value, true);
		applyOption('tfocus', cmd, value, true);
		applyOption('tbuff', cmd, value, true);
		applyOption('tdebuff', cmd, value, true);
	elseif target == 'ppower' then
		applyOption('pmana', cmd, value, true);
		applyOption('prage', cmd, value, true);
		applyOption('penergy', cmd, value, true);
		applyOption('pfocus', cmd, value, true);
	elseif target == 'pet' then
		applyOption('phealth', cmd, value, true);
		applyOption('pmana', cmd, value, true);
		applyOption('prage', cmd, value, true);
		applyOption('penergy', cmd, value, true);
		applyOption('pfocus', cmd, value, true);
		applyOption('phappy', cmd, value, true);
		applyOption('pbuff', cmd, value, true);
		applyOption('pdebuff', cmd, value, true);
	else
		applyOption(target, cmd, value, true);
	end

	updateAllSettings();
end

-- returns a string representing the level of the unit
local function levelString(unit)
	if UnitExists(unit) then
		local l = UnitLevel(unit);
		local s = tostring(l);
		if l < 1 or l > 100 then
			s = '??';
		end
		if UnitIsPlusMob(unit) then
			s = s .. '+';
		end
		return s;
	else
		return '';
	end
end

local function happinessString()
	local value = happiness.lastValue;
	if value > 0 then
		return getglobal("PET_HAPPINESS" .. value);
	else
		return '';
	end
end

-- default initialization for the bar information containers
local function init(this, vars, name)
	-- events
	this:RegisterEvent('PLAYER_ENTER_COMBAT');
	this:RegisterEvent('PLAYER_LEAVE_COMBAT');
	this:RegisterEvent('PLAYER_REGEN_ENABLED');
	this:RegisterEvent('PLAYER_REGEN_DISABLED');
	this:RegisterEvent('PLAYER_ALIVE');
	this:RegisterEvent('VARIABLES_LOADED');
	this:RegisterEvent('PLAYER_ENTERING_WORLD');
	this:RegisterEvent('UNIT_CLASSIFICATION_CHANGED');

	-- store ui elements
	local barname = 'StatusBars_' .. name .. 'Bar';
	vars.frame = getglobal(barname);
	vars.bar = getglobal(barname .. '_Status');
	vars.text = getglobal(barname .. '_Text');
	vars.ptext = getglobal(barname .. '_PercentageText');
	vars.foverlay = getglobal(barname .. '_FlashOverlay');
	assert(vars.frame);
	assert(vars.text);
	assert(vars.ptext);

	-- init display
	vars.frame:SetAlpha(0);
	vars.frame:Show();

	-- store variables for use in callbacks
	this._StatusBars_vars = vars;

	-- visibility
	vars.visible = false;		-- current visibility, changes are delayed if fading
	vars.targetVisibility = false;
	vars.fading = false;
	vars.softEnable = true;		-- visibility override, causes fade transitions

	-- value
	vars.lastValue = 0;		-- last property value
	vars.lastMax = 0;		-- last maximum property value
	vars.lastFraction = 0.5;	-- lastValue / lastMax
	vars.default = 1;		-- default fraction value of the property
					--   health, mana, energy = 1
					--   rage, combo = 0

	-- combat
	vars._inCombat = false;		-- in combat, as reported by PLAYER_ENTER_COMBAT
	vars._hasAggro = false;		-- in hate list

	-- color
	vars.colorrules = { default = { 0, 0, 0, }, rules = {} };

	function vars:getText(optionName)
		local str = option(self, optionName);
		if str == '' then
			return '';
		end
		str = string.gsub(str, '&cur', tostring(self.lastValue));
		str = string.gsub(str, '&max', tostring(self.lastMax));
		str = string.gsub(str, '&%-cur', tostring(self.lastMax - self.lastValue));
		str = string.gsub(str, '&frac', tostring(ceil(self.lastFraction*100)));
		str = string.gsub(str, '&name', tostring(UnitName(self.unit)));
		str = string.gsub(str, '&class', tostring(UnitClass(self.unit)));
		str = string.gsub(str, '&type', tostring(UnitCreatureType(self.unit)));
		str = string.gsub(str, '&rank', GetPVPRankInfo(UnitPVPRank(self.unit)) or '');
		str = string.gsub(str, '&lvl', levelString(self.unit));
		str = string.gsub(str, '&happy', happinessString());
		return trim(str);
	end
	function vars:updateColor()
		local c = getBarColor(self, '');
		self.bar:SetStatusBarColor(c[1], c[2], c[3]);
		updateTextColors(self);
	end
	if vars.foverlay then
		function vars:updateFlashDisplay()
			updateFlashDisplayCommon(self, self);
		end
	else
		function vars:updateFlashDisplay() end
	end
	function vars:updateTickEnable()
		if vars._flashing then
			tickingBars[self] = true;
		else
			tickingBars[self] = nil;
		end
	end
	function vars:updateFlash()
		updateFlashCommon(self);
	end
	function vars:abortFlash()
		abortFlashCommon(self);
	end

	-- behaviour
	function vars:updateTextDisplays()
		if self.text:IsVisible() then
			self.text:SetText(self:getText('text'));
		end
		if self.ptext:IsVisible() then
			self.ptext:SetText(self:getText('ptext'));
		end
	end
	function vars:updateValueDisplay()
		self:updateTextDisplays();
		self.bar:SetValue(self.lastFraction);
		self:updateColor();
	end
	function vars:onUpdate()
		self:updateFlash();
	end

	vars:abortFlash();
end

-- init combo bar
function StatusBars_ComboBar2_OnLoad()
	this:RegisterEvent('PLAYER_COMBO_POINTS');
	this:RegisterEvent('UNIT_DISPLAYPOWER');
	this:RegisterEvent('PLAYER_TARGET_CHANGED');

	function combo:getCurrent()
		if UnitIsDeadOrGhost('target') then
			return 0;
		else
			return GetComboPoints('player');
		end
	end
	function combo:getMax()
		return 5;
	end

	combo._flashing = false;
	init(this, combo, 'Combo');
	combo.unit = 'player';
	combo.default = 0;
	combo.logical = 'combo';
	combo._extraFlashEnd = 0;
	combo.minibars = { n = 5 };
	local i;
	for i = 1, 5 do
		local t = {};
		local base = 'StatusBars_Combo_' .. i;
		t.frame = getglobal(base);
		t.bar = getglobal(base.. '_Status');
		t.foverlay = getglobal(base .. '_Flash');
		t.frame:SetBackdropColor(0, 0, 0, DefaultBGAlpha);
		t._extraFlash = 0;
		t._extraFlashEnd = 0;
		combo.minibars[i] = t;
	end

	function combo:onEvent(event)
		if combo.never then return; end
		local v = combo:getCurrent();
		if v > combo.lastValue and v > 0 then
			combo._flashing = true;
			local endtime = GetTime() + ComboFlashDuration;
			combo._extraFlashEnd = endtime;
			combo.minibars[v]._extraFlashEnd = endtime;
		end
		eventCommon(combo, event);
		updateComboEnable();
		updateCommon(combo);
		combo:updateFlash();
	end
	function combo:updateValueDisplay()
		self:updateTextDisplays();
		local i;
		for i = 1, 5 do
			if combo.lastValue >= i then
				combo.minibars[i].bar:SetValue(1);
			else
				combo.minibars[i].bar:SetValue(0);
			end
		end
		combo:updateColor();
	end
	function combo:updateColor()
		local c = getBarColor(combo, '');
		local i;
		for i = 1, 5 do
			combo.minibars[i].bar:SetStatusBarColor(c[1], c[2], c[3]);
		end
		updateTextColors(combo);
	end
	function combo:updateFlashDisplay()
		local i;
		for i = 1, 5 do
			local bv = combo.minibars[i];
			updateFlashDisplayCommon(combo, bv);
		end
	end
	function combo:updateFlash()
		local t = GetTime();
		if t < combo._extraFlashEnd or combo._flashing or combo._extraFlashActive then
			combo._extraFlashActive = false;
			local i;
			for i = 1, 5 do
				local bv = combo.minibars[i];
				local et = bv._extraFlashEnd;
				local ef = 0;
				if t < et then
					local d = et - t;
					if d >= 0 and d <= ComboFlashDuration then
						ef = 1 - abs(d - ComboFlashDuration*0.5) / (ComboFlashDuration*0.5);
						combo._extraFlashActive = true;
					else
						bv._extraFlash = 0;
					end
				end
				bv._extraFlash = ef;
			end
			updateFlashCommon(combo, true);
		end
	end
	function combo:updateTickEnable()
		local t = GetTime();
		if t < combo._extraFlashEnd or combo._flashing or combo._extraFlashActive then
			tickingBars[combo] = true;
		else
			tickingBars[combo] = nil;
		end
	end
	function combo:abortFlash()
		local i;
		for i = 1, 5 do
			local bv = combo.minibars[i];
			bv._extraFlash = 0;
			bv._extraFlashEnd = 0;
		end
		abortFlashCommon(combo);
	end

	updateTextVisibility(combo);
	update(combo);
end
-- init druid mana bar
function StatusBars_DruidBar_OnLoad()
	this:RegisterEvent('UPDATE_SHAPESHIFT_FORMS');
	this:RegisterEvent('UNIT_DISPLAYPOWER');

	function druid:getCurrent()
		if DruidBarKey ~= nil then
			return round(DruidBarKey.keepthemana or 0);
		elseif DruidBar_keepthemana ~= nil then
			return round(DruidBar_keepthemana);
		else
			return 0;
		end
	end
	function druid:getMax()
		if DruidBarKey ~= nil then
			return round(DruidBarKey.maxmana or 0);
		elseif DruidBar_maxmana ~= nil then
			return round(DruidBar_maxmana);
		else
			return 0;
		end
	end

	init(this, druid, 'Druid');
	druid.logical = 'druid';
	druid.unit = 'player';

	function druid:onEvent(event)
		if druid.never then return; end
		eventCommon(druid, event);
		updateDruidEnable();
		updateCommon(druid);
	end
	function druid:onUpdate()
		updateDruid();
		druid:updateFlash();
	end
	function druid:updateTickEnable()
		if druid.softEnable then
			tickingBars[self] = true;
		else
			tickingBars[self] = nil;
		end
	end

	updateTextVisibility(druid);
	updateCommon(druid);
	update(druid);
end
-- init pet happiness bar
function StatusBars_HappinessBar_OnLoad()
	this:RegisterEvent('UNIT_HAPPINESS');
	this:RegisterEvent('PLAYER_PET_CHANGED');

	consolePrint('happy');

	function happiness:getCurrent()
		return GetPetHappiness() or 0;
	end
	function happiness:getMax()
		if GetPetHappiness() then
			return 3;
		else
			return 0;
		end
	end

	init(this, happiness, 'Happiness');
	happiness.logical = 'phappy';
	happiness.unit = 'pet';
	happiness.nospace = true;

	function happiness:onEvent(event)
		if happiness.never then return; end
		eventCommon(happiness, event);
		updateOtherUnitCommon(happiness);
		updateCommon(happiness);
	end

	updateTextVisibility(happiness);
	update(happiness);
end
-- init health bar
function initOtherUnitHealthBar(vars, name, logical, unit)
	this:RegisterEvent('UNIT_HEALTH');
	this:RegisterEvent('UNIT_MAXHEALTH');

	function vars:getCurrent()
		if UnitExists(unit) then
			return UnitHealth(unit);
		else
			return 0;
		end
	end
	function vars:getMax()
		if UnitExists(unit) then
			return UnitHealthMax(unit);
		else
			return 0;
		end
	end

	init(this, vars, name);
	vars.logical = logical;
	vars.unit = unit;

	function vars:onEvent(event)
		if vars.never then return; end
		eventCommon(vars, event);
		updateOtherUnitCommon(vars);
		updateCommon(vars);
	end

	updateTextVisibility(vars);
	update(vars);
end

-- init power bar
function initOtherUnitPowerBar(vars, name, unit, prefix)
	this:RegisterEvent('UNIT_ENERGY');
	this:RegisterEvent('UNIT_MAXENERGY');
	this:RegisterEvent('UNIT_MANA');
	this:RegisterEvent('UNIT_MAXMANA');
	this:RegisterEvent('UNIT_RAGE');
	this:RegisterEvent('UNIT_MAXRAGE');
	this:RegisterEvent('UNIT_DISPLAYPOWER');

	function vars:getCurrent()
		if UnitExists(unit) then
			return UnitMana(unit);
		else
			return 0;
		end
	end
	function vars:getMax()
		if UnitExists(unit) then
			return UnitManaMax(unit);
		else
			return 0;
		end
	end

	init(this, vars, name);
	vars.unit = unit;
	vars.prefix = prefix;

	function vars:onEvent(event)
		if vars.never then return; end
		eventCommon(self, event);
		updatePowerType(self, unit, self.prefix);
		updateOtherUnitCommon(self);
		if UnitManaMax(self.unit) < 1 then
			self.softEnable = false;
		end
		updateCommon(self);
	end

	update(vars);
	updateTextVisibility(vars);
end

-- init buff bar
function initOtherUnitBuffBar(vars, name, logical, unit)
	this:RegisterEvent('UNIT_AURA');

	function vars:getCurrent()
		return vars._numBuffs;
	end
	function vars:getMax()
		return MaxBuffs;
	end

	vars._numBuffs = 0;
	init(this, vars, name);
	vars.default = 0;
	vars.logical = logical;
	vars.unit = unit;

	vars.textures = {};
	local i;
	local base = 'StatusBars_' .. name .. '_Texture';
	for i = 1, MaxBuffs do
		local t = getglobal(base .. i);
		assert(t);
		vars.textures[i] = t;
	end

	-- behaviour
	function vars:updateFlash()
	end
	function vars:abortFlash()
	end
	function vars:updateValueDisplay()
		self:updateTextDisplays();
		updateBuffs(self, true);
	end
	function vars:onEvent(event)
		if vars.never then return; end
		if event == 'UNIT_AURA' and arg1 == self.unit then
			updateBuffs(self, false);
		elseif event == 'PLAYER_TARGET_CHANGED' and 'target' == self.unit then
			updateBuffs(self, false);
		end
		eventCommon(self, event);
		updateOtherUnitCommon(self);
		updateCommon(self);
	end
	function vars:updateColor()
	end

	updateBuffs(vars, true);
	update(vars);
end

-- health bars
function StatusBars_HealthBar_OnLoad()
	SlashCmdList['STATUSBARS'] = slashHandler;
	SLASH_STATUSBARS1 = '/statusbars';

	initOtherUnitHealthBar(health, 'Health', 'health', 'player');
end
function StatusBars_TargetHealthBar_OnLoad()
	this:RegisterEvent('PLAYER_TARGET_CHANGED');
	initOtherUnitHealthBar(targetHealth, 'TargetHealth', 'thealth', 'target');

	function getHPP()
		local m = UnitHealthMax('target');
		if m ~= 100 or MobHealthDB == nil then
			return;
		end
		local index = UnitName('target') .. ':' .. UnitLevel('target');
		local t = MobHealthDB[index];
		if t == nil then
			return;
		end
		local pts, pct;
		if type(t) == 'table' then
			pts = t.damPts or 0;
			pct = t.damPct or 0;
		else
			local i,j;
			i,j, pts, pct = string.find(t, "^(%d+)/(%d+)$");
			pct = tonumber(pct);
		end
		if pct ~= 0 then
			return pts / tonumber(pct);
		end
	end

	if MobHealthFrame ~= nil then
		consolePrint('MobHealth detected');
		function targetHealth:getCurrent()
			if UnitExists('target') then
				local v = UnitHealth('target');
				local hpp = getHPP();
				if hpp then
					return round(hpp * v);
				else
					return v;
				end
			else
				return 0;
			end
		end
		function targetHealth:getMax()
			if UnitExists('target') then
				local v = UnitHealthMax('target');
				local hpp = getHPP();
				if hpp then
					return round(hpp * v);
				else
					return v;
				end
			else
				return 0;
			end
		end
	end
end
function StatusBars_PetHealthBar_OnLoad()
	this:RegisterEvent('PLAYER_PET_CHANGED');
	this:RegisterEvent('UNIT_HAPPINESS');
	initOtherUnitHealthBar(petHealth, 'PetHealth', 'phealth', 'pet');
end

-- power bars
function StatusBars_PowerBar_OnLoad()
	initOtherUnitPowerBar(power, 'Power', 'player', '');
end
function StatusBars_TargetPowerBar_OnLoad()
	this:RegisterEvent('PLAYER_TARGET_CHANGED');
	initOtherUnitPowerBar(targetPower, 'TargetPower', 'target', 't');
end
function StatusBars_PetPowerBar_OnLoad()
	this:RegisterEvent('PLAYER_PET_CHANGED');
	this:RegisterEvent('UNIT_HAPPINESS');
	initOtherUnitPowerBar(petPower, 'PetPower', 'pet', 'p');
end

-- buff bars
function StatusBars_BuffBar_OnLoad()
	buff.buffFunc = UnitBuff;
	initOtherUnitBuffBar(buff, 'Buff', 'buff', 'player');
end
function StatusBars_DebuffBar_OnLoad()
	debuff.buffFunc = UnitDebuff;
	initOtherUnitBuffBar(debuff, 'Debuff', 'debuff', 'player');
end
function StatusBars_TargetBuffBar_OnLoad()
	this:RegisterEvent('PLAYER_TARGET_CHANGED');
	targetBuff.buffFunc = UnitBuff;
	initOtherUnitBuffBar(targetBuff, 'TargetBuff', 'tbuff', 'target');
end
function StatusBars_TargetDebuffBar_OnLoad()
	this:RegisterEvent('PLAYER_TARGET_CHANGED');
	targetDebuff.buffFunc = UnitDebuff;
	initOtherUnitBuffBar(targetDebuff, 'TargetDebuff', 'tdebuff', 'target');
end
function StatusBars_PetBuffBar_OnLoad()
	petBuff.buffFunc = UnitBuff;
	initOtherUnitBuffBar(petBuff, 'PetBuff', 'pbuff', 'pet');
end
function StatusBars_PetDebuffBar_OnLoad()
	petDebuff.buffFunc = UnitDebuff;
	initOtherUnitBuffBar(petDebuff, 'PetDebuff', 'pdebuff', 'pet');
end

local shiftIsDown = false;
function StatusBars_GlobalUpdate()
	if load_time > 0 and GetTime() > load_time then
		load_time = 0;
		fully_initialized = true;

		-- replace initialization stub functions with live versions
		update = update_real;
		updateCommon = updateCommon_real;
		eventCommon = eventCommon_real;
		StatusBars_GlobalUpdate = StatusBars_GlobalUpdate_real;

		consolePrint(STATUSBARS_LOADED .. playerName .. '"');

		updateAllSettings();
	end
end
function StatusBars_GlobalUpdate_real()
	local sd = IsShiftKeyDown() and not StatusBars_locked;
	if sd ~= shiftIsDown then
		shiftIsDown = sd;

		if sd then sd = 1 else sd = 0 end;
		table.foreach(groupContainers,
			function(name, t)
				local frame = getglobal('StatusBars_' .. name .. 'Container')
				frame:EnableMouse(sd);
				if not shiftIsDown then
					frame:StopMovingOrSizing();
				end
			end
		);
		if not shiftIsDown then
			StatusBars_moving = nil;
		end
	end
	table.foreach(tickingBars,
		function(vars, t)
			vars:onUpdate();
		end
	);
end
