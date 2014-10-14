CCWatchDetails = {
	name = "CCWatch",
	version = CWATCH_VERSION,
	releaseDate = "January 22, 2006",
	author = "Elwen",
	website = "http://www.curse-gaming.com/mod.php?addid=2572",
	category = MYADDONS_CATEGORY_COMBAT,
	description = CCWATCH_DESCRIPTION,
	optionsframe = "CCWatchOptionsFrame"
};

CCWatchHelp = {
	"/ccw : affiche les commandes possibles\n"..
	"/ccw config : affiche l'interface graphique\n"..
	"\n"..
	""
}

CCWatchObject = nil;

function CCWatch_Config()
	CCWATCH.CCS = {}

	if CCWatch_ConfigCC ~= nil then
		CCWatch_ConfigCC();
	else
		CCWatch_AddMessage("No CC config");
	end
	if CCWatch_ConfigDebuff ~= nil then
		CCWatch_ConfigDebuff();
	else
		CCWatch_AddMessage("No Debuff config");
	end
	if CCWatch_ConfigBuff ~= nil then
		CCWatch_ConfigBuff();
	else
		CCWatch_AddMessage("No Buff config");
	end
end

function CCWatch_OnLoad()
	CCWatch_Globals();
	CCWatch_Config();

--	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_LOGIN");
	this:RegisterEvent("UNIT_AURA");
	this:RegisterEvent("UNIT_COMBAT");

	if UnitLevel("player") < 60 then
		this:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN");
-- TODO : add this
--		this:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN");
 	end
-- register this also for < 60 (pvp)
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");

	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
	this:RegisterEvent("CHAT_MSG_SPELL_BREAK_AURA");

	this:RegisterEvent("SPELLCAST_START");
	this:RegisterEvent("SPELLCAST_STOP");
	this:RegisterEvent("SPELLCAST_FAILED");
	this:RegisterEvent("SPELLCAST_INTERRUPTED");

	this:RegisterEvent("PLAYER_TARGET_CHANGED");

	SLASH_CCWATCH1 = "/ccwatch";
	SLASH_CCWATCH2 = "/ccw";
	SlashCmdList["CCWATCH"] = function(msg)
		CCWatch_SlashCommandHandler(msg);
	end
end

function CCWatch_BarUnlock()
	CCWATCH.STATUS = 2;
	CCWatchCC:EnableMouse(1);
	CCWatchDebuff:EnableMouse(1);
	CCWatchBuff:EnableMouse(1);

	CCWatchBarCC1:Show();
	CCWatchBarCC2:Show();
	CCWatchBarCC3:Show();
	CCWatchBarCC4:Show();
	CCWatchBarCC5:Show();

	CCWatchBarDebuff1:Show();
	CCWatchBarDebuff2:Show();
	CCWatchBarDebuff3:Show();
	CCWatchBarDebuff4:Show();
	CCWatchBarDebuff5:Show();

	CCWatchBarBuff1:Show();
	CCWatchBarBuff2:Show();
	CCWatchBarBuff3:Show();
	CCWatchBarBuff4:Show();
	CCWatchBarBuff5:Show();
--
end

function CCWatch_BarLock()
	CCWATCH.STATUS = 1;
	CCWatchCC:EnableMouse(0);
	CCWatchDebuff:EnableMouse(0);
	CCWatchBuff:EnableMouse(0);

	CCWatchBarCC1:Hide();
	CCWatchBarCC2:Hide();
	CCWatchBarCC3:Hide();
	CCWatchBarCC4:Hide();
	CCWatchBarCC5:Hide();

	CCWatchBarDebuff1:Hide();
	CCWatchBarDebuff2:Hide();
	CCWatchBarDebuff3:Hide();
	CCWatchBarDebuff4:Hide();
	CCWatchBarDebuff5:Hide();

	CCWatchBarBuff1:Hide();
	CCWatchBarBuff2:Hide();
	CCWatchBarBuff3:Hide();
	CCWatchBarBuff4:Hide();
	CCWatchBarBuff5:Hide();

end

function CCWatch_SlashCommandHandler(msg)
	if( msg ) then
		local command = string.lower(msg);
		if( command == "on" ) then
			if( CCWATCH.STATUS == 0 ) then
				CCWATCH.STATUS = 1;
				CCWatch_Save[CCWATCH.PROFILE].status = CCWATCH.STATUS;
				CCWatch_AddMessage(CCWATCH_ENABLED);
			end
		elseif( command == "off" ) then
			if( CCWATCH.STATUS ~= 0 ) then
				CCWATCH.STATUS = 0;
				CCWatch_Save[CCWATCH.PROFILE].status = CCWATCH.STATUS;
				CCWatch_AddMessage(CCWATCH_DISABLED);
			end
		elseif( command == "unlock" ) then
			CCWatch_BarUnlock();
			CCWatch_AddMessage(CCWATCH_UNLOCKED);
			CCWatchOptionsFrameUnlock:SetChecked(true);
		elseif( command == "lock" ) then
			CCWatch_BarLock();
			CCWatch_AddMessage(CCWATCH_LOCKED);
			CCWatchOptionsFrameUnlock:SetChecked(false);
		elseif( command == "invert" ) then
			CCWATCH.INVERT = not CCWATCH.INVERT;
			CCWatch_Save[CCWATCH.PROFILE].invert = CCWATCH.INVERT;
			if CCWATCH.INVERT then
				CCWatch_AddMessage(CCWATCH_INVERSION_ON);
			else
				CCWatch_AddMessage(CCWATCH_INVERSION_OFF);
			end
			CCWatchOptionsFrameInvert:SetChecked(CCWATCH.INVERT);
		elseif( command == "timers off" ) then
			CCWatch_Save[CCWATCH.PROFILE].timers = 0;
			CCWATCH.TIMERS = CCWatch_Save[CCWATCH.PROFILE].timers;
			CCWatch_AddMessage(CCWATCH_TIMERS_OFF)
			CCWatchTimersDropDownText:SetText(CCWATCH_OPTION_TIMERS_OFF);
		elseif( command == "timers on" ) then
			CCWatch_Save[CCWATCH.PROFILE].timers = 1;
			CCWATCH.TIMERS = CCWatch_Save[CCWATCH.PROFILE].timers;
			CCWatch_AddMessage(CCWATCH_TIMERS_ON)
			CCWatchTimersDropDownText:SetText(CCWATCH_OPTION_TIMERS_ON);
		elseif( command == "timers rev" ) then
			CCWatch_Save[CCWATCH.PROFILE].timers = 2;
			CCWATCH.TIMERS = CCWatch_Save[CCWATCH.PROFILE].timers;
			CCWatch_AddMessage(CCWATCH_TIMERS_REVERSE)
			CCWatchTimersDropDownText:SetText(CCWATCH_OPTION_TIMERS_REVERSE);
		elseif( command == "grow off" ) then
			CCWatch_Save[CCWATCH.PROFILE].growth = 0;
			CCWATCH.GROWTH = CCWatch_Save[CCWATCH.PROFILE].growth;
			CCWatch_AddMessage(CCWATCH_GROW_OFF)
			CCWatchGrowthDropDownText:SetText(CCWATCH_OPTION_GROWTH_OFF);
		elseif( command == "grow up" ) then
			CCWatch_Save[CCWATCH.PROFILE].growth = 1;
			CCWATCH.GROWTH = CCWatch_Save[CCWATCH.PROFILE].growth;
			CCWatch_AddMessage(CCWATCH_GROW_UP)
			CCWatchGrowthDropDownText:SetText(CCWATCH_OPTION_GROWTH_UP);
		elseif( command == "grow down" ) then
			CCWatch_Save[CCWATCH.PROFILE].growth = 2;
			CCWATCH.GROWTH = CCWatch_Save[CCWATCH.PROFILE].growth;
			CCWatch_AddMessage(CCWATCH_GROW_DOWN)
			CCWatchGrowthDropDownText:SetText(CCWATCH_OPTION_GROWTH_DOWN);
		elseif( command == "clear" ) then
			CCWatch_Save[CCWATCH.PROFILE] = nil;
			CCWatch_SavedCC = nil;
			CCWatch_Globals();
			CCWatch_Config();
			CCWatch_LoadVariables();
		elseif( command == "u" ) then
			CCWatch_Config();
			CCWatch_UpdateClassSpells(true);
		elseif( command == "config" ) then
			CCWatchOptionsFrame:Show();
		elseif( string.sub(command, 1, 5) == "scale" ) then
			local scale = tonumber(string.sub(command, 7))
			if( scale <= 3.0 and scale >= 0.25 ) then
				CCWatch_Save[CCWATCH.PROFILE].scale = scale;
				CCWATCH.SCALE = scale;
				CCWatchCC:SetScale(CCWATCH.SCALE);
				CCWatchDebuff:SetScale(CCWATCH.SCALE);
				CCWatchBuff:SetScale(CCWATCH.SCALE);
				CCWatch_AddMessage(CCWATCH_SCALE..scale);
				CCWatchSliderScale:SetValue(CCWATCH.SCALE);
			else
				CCWatch_Help()
			end
		elseif( string.sub(command, 1, 5) == "width" ) then
			local width = tonumber(string.sub(command, 7))
			if( width <= 300 and width >= 50 ) then
				CCWatch_Save[CCWATCH.PROFILE].width = width;
				CCWATCH.WIDTH = width;
				CCWatch_SetWidth(CCWATCH.WIDTH);
				CCWatch_AddMessage(CCWATCH_WIDTH..width);
				CCWatchSliderWidth:SetValue(CCWATCH.WIDTH);
			else
				CCWatch_Help()
			end
		elseif( string.sub(command, 1, 5) == "alpha" ) then
			local alpha = tonumber(string.sub(command, 7))
			if( alpha <= 1 and alpha >= 0 ) then
				CCWatch_Save[CCWATCH.PROFILE].alpha = alpha;
				CCWATCH.ALPHA = alpha;
				CCWatch_AddMessage(CCWATCH_ALPHA..alpha);
				CCWatchSliderAlpha:SetValue(CCWATCH.ALPHA);
			else
				CCWatch_Help()
			end
		elseif( command == "print" ) then
			CCWatch_AddMessage(CCWATCH_PROFILE_TEXT..CCWATCH.PROFILE);
			if( CCWATCH.STATUS == 0 ) then
				CCWatch_AddMessage(CCWATCH_DISABLED);
			elseif( CCWATCH.STATUS == 2 ) then
				CCWatch_AddMessage(CCWATCH_UNLOCKED);
			else
				CCWatch_AddMessage(CCWATCH_ENABLED);
			end
			if CCWATCH.INVERT then
				CCWatch_AddMessage(CCWATCH_INVERSION_ON);
			else
				CCWatch_AddMessage(CCWATCH_INVERSION_OFF);
			end
			if CCWATCH.TIMERS == 0 then
				CCWatch_AddMessage(CCWATCH_TIMERS_OFF);
			elseif CCWATCH.TIMERS == 1 then
				CCWatch_AddMessage(CCWATCH_TIMERS_ON);
			else
				CCWatch_AddMessage(CCWATCH_TIMERS_REVERSE);
			end
			if CCWATCH.GROWTH == 0 then
				CCWatch_AddMessage(CCWATCH_GROW_OFF);
			elseif CCWATCH.GROWTH == 1 then
				CCWatch_AddMessage(CCWATCH_GROW_UP);
			else
				CCWatch_AddMessage(CCWATCH_GROW_DOWN);
			end
			CCWatch_Config();
			CCWatch_UpdateClassSpells(true); -- Update at the same time

			CCWatch_AddMessage(CCWATCH_SCALE..CCWATCH.SCALE);
			CCWatch_AddMessage(CCWATCH_WIDTH..CCWATCH.WIDTH);
			CCWatch_AddMessage(CCWATCH_ALPHA..CCWATCH.ALPHA);
		else
			CCWatch_Help();
		end
	end
end

function CCWatch_OnEvent(event)
	if ( CCWATCH.STATUS == 0 and event ~= "PLAYER_LOGIN" ) then
		return
	end

	CCWatch_EventHandler[event](arg1, arg2, arg3, arg4, arg5);
end

CCWatch_EventHandler = {}

local SpellCast = nil;

CCWatch_EventHandler["PLAYER_LOGIN"] = function()
	if(myAddOnsFrame_Register) then
		myAddOnsFrame_Register(CCWatchDetails, CCWatchHelp);
	end
	CCWatch_LoadVariables();
end

CCWatch_EventHandler["SPELLCAST_START"] = function()
	SpellCast = arg1;
--	duration = arg2;	-- might wanna play with it to deduce the used rank
end

CCWatch_EventHandler["SPELLCAST_STOP"] = function()
	local effect;
	effect = SpellCast;
	local target = UnitName("target");
	if effect ~= nil and target ~= nil then
		if CCWATCH.CCS[effect] then
			local group = CCWATCH.CCS[effect].GROUP;
			local etype = CCWATCH.CCS[effect].ETYPE;
			local index = 0;
			-- find the effect in the queue, if it's not there index stays 0
			if etype == ETYPE_BUFF then
				table.foreach( CCWATCH.GROUPSBUFF[group].EFFECT, function(k,v) if( v == effect ) then index = k end end );
			elseif etype == ETYPE_DEBUFF then
				table.foreach( CCWATCH.GROUPSDEBUFF[group].EFFECT, function(k,v) if( v == effect ) then index = k end end );
			else
				table.foreach( CCWATCH.GROUPSCC[group].EFFECT, function(k,v) if( v == effect ) then index = k end end );
			end

			if( index ~= 0 ) then
-- Found the effect in a group, hence it is active, hence we are resetting it
				CCWATCH.UNIT_AURA.TIME = GetTime();
				CCWATCH.UNIT_AURA.TARGET = target;
				CCWATCH.CCS[effect].TARGET = target;
				local diff = CCWATCH.UNIT_AURA.TIME - CCWATCH.CCS[effect].TIMER_START;
				CCWATCH.CCS[effect].TIMER_START = CCWATCH.CCS[effect].TIMER_START + diff;
				CCWATCH.CCS[effect].TIMER_END = CCWATCH.CCS[effect].TIMER_END + diff;
			end
		end
	end
	SpellCast = nil;
end

CCWatch_EventHandler["SPELLCAST_FAILED"] = function()
	SpellCast = nil;
end

CCWatch_EventHandler["SPELLCAST_INTERRUPTED"] = function()
	SpellCast = nil;
end

CCWatch_EventHandler["UNIT_AURA"] = function()
	if( arg1 == "target") then
		CCWATCH.UNIT_AURA.TARGET = UnitName("target");
		CCWATCH.UNIT_AURA.TIME = GetTime();

		-- get rid of any old events so they don't clutter the queue
		while table.getn(CCWATCH.EFFECT) > 0 and (CCWATCH.UNIT_AURA.TIME - CCWATCH.EFFECT[1].TIME) > CCWATCH.THRESHOLD do
			CCWatch_UnqueueEvent();
		end

		if table.getn(CCWATCH.EFFECT) > 0 then
			CCWatch_EffectHandler[CCWATCH.EFFECT[1].STATUS]();
		end
	end
end

CCWatch_EventHandler["PLAYER_TARGET_CHANGED"] = function()
	if not UnitCanAttack("player", "target") then
		return;
	end
	local index = 0;
	local target = UnitName("target");
-- 1. Check if current target is present in the list
	table.foreach( CCWATCH.LASTTARGETS, function(k,v) if( v.TARGET == target ) then index = k end end );
	local ltime = GetTime();
	if index == 0 then
-- 2. add it
		CCWatch_AddLastTarget(target, ltime);
	else
-- or update target time effect
		CCWATCH.LASTTARGETS[index].TIME = ltime;
	end
end

local function DebugCompareStrings(str1, str2)
	local str = "";
	if str1 == str2 then
		test = str1.." == "..str2;
	else
		local str = "";
		local len = string.len(str1);
		if len > string.len(str2) then
			len = string.len(str2);
		end
		for i=1,len do
			s1char = string.sub(str1, i, i);
			s2char = string.sub(str1, i, i);
			str = i.." : "..s1char.." ["..string.byte(s1char) .."] -> "..s2char.." ["..string.byte(s2char).."]";
			if s1char ~= s2char then
				str = str.." => DIFFERENT";
			end
			CCWatch_AddMessage(str);
		end
	end
end

CCWatch_EventHandler["CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE"] = function()
	for mobname, effect in string.gfind( arg1, CCWATCH_TEXT_ON ) do
		if( CCWATCH.STYLE > 1 or CCWatch_CheckRecentTargets(mobname) ) then
--	DebugCompareStrings(CCWATCH_SHADOWWORDPAIN, effect);
			if CCWATCH.CCS[effect] and CCWATCH.CCS[effect].MONITOR and bit.band(CCWATCH.CCS[effect].ETYPE, CCWATCH.MONITORING) ~= 0 then
				CCWatch_QueueEvent(effect, mobname, GetTime(), 1)

				CCWatch_EffectHandler[1]();
			end
		end
	end
end

CCWatch_EventHandler["CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS"] = function()
	for mobname, effect in string.gfind( arg1, CCWATCH_TEXT_BUFF_ON ) do
		if( CCWATCH.STYLE > 1 or CCWatch_CheckRecentTargets(mobname) ) then
			if CCWATCH.CCS[effect] and CCWATCH.CCS[effect].MONITOR and bit.band(CCWATCH.CCS[effect].ETYPE, CCWATCH.MONITORING) ~=0 then
				CCWatch_QueueEvent(effect, mobname, GetTime(), 1)

				CCWatch_EffectHandler[1]();
			end
		end
	end
end

CCWatch_EventHandler["CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS"] = CCWatch_EventHandler["CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS"];
CCWatch_EventHandler["CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE"] = CCWatch_EventHandler["CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE"];

CCWatch_EventHandler["CHAT_MSG_SPELL_AURA_GONE_OTHER"] = function()
	for effect, mobname in string.gfind( arg1, CCWATCH_TEXT_OFF ) do
		if CCWATCH.CCS[effect] then
			if( CCWATCH.CCS[effect].TARGET == mobname ) then
				CCWatch_QueueEvent(effect, mobname, GetTime(), 2)

				CCWatch_EffectHandler[2]();
			end
		end
	end
end

CCWatch_EventHandler["CHAT_MSG_SPELL_BREAK_AURA"] = function()
	for mobname, effect in string.gfind( arg1, CCWATCH_TEXT_BREAK ) do
		if( CCWATCH.CCS[effect] ) then
			if( CCWATCH.CCS[effect].TARGET == mobname ) then
			CCWatch_QueueEvent(effect, mobname, GetTime(), 3)

			CCWatch_EffectHandler[3]();
			end
		end
	end
end

local DeadMob = "";
local function CCWHandleTargetDeath(k, v)
	if( v ) then
		if( v.TARGET == DeadMob ) then
--CCWatch_AddMessage("Removing effect "..k);
			CCWATCH.CCS[k].TIMER_END = GetTime();
			CCWatch_RemoveEffect(k, false);
		end
	end
end

CCWatch_EventHandler["CHAT_MSG_COMBAT_HOSTILE_DEATH"] = function()
	for mobname in string.gfind( arg1, CCWATCH_TEXT_DIE ) do
-- for each effect (arg oO) check if target is current
		DeadMob = mobname;
		table.foreach(CCWATCH.CCS, CCWHandleTargetDeath);
	end
end

CCWatch_EventHandler["CHAT_MSG_COMBAT_XP_GAIN"] = function()
	for mobname in string.gfind( arg1, CCWATCH_TEXT_DIEXP ) do
-- for each effect (arg oO) check if target is current
		DeadMob = mobname;
		table.foreach(CCWATCH.CCS, CCWHandleTargetDeath);
	end
end

CCWatch_EventHandler["UNIT_COMBAT"] = function()
	if( GetComboPoints() > 0 ) then
		CCWATCH.COMBO = GetComboPoints();
	end
end

CCWatch_EffectHandler = {}

CCWatch_EffectHandler[0] = function()
-- no effect

end

CCWatch_EffectHandler[1] = function()
-- applied
	if( CCWATCH.STYLE ~= 0 or math.abs( CCWATCH.UNIT_AURA.TIME - CCWATCH.EFFECT[1].TIME ) < CCWATCH.THRESHOLD ) then
		local effect = CCWATCH.EFFECT[1].TYPE
		local mobname = CCWATCH.EFFECT[1].TARGET

		if( GetTime() > ( CCWATCH.CCS[effect].TIMER_END + 15 ) or mobname ~= CCWATCH.CCS[effect].TARGET ) then
-- quick & dirty hack for shared DR between Seduce & Fear)
			if( effect == CCWATCH_FEAR or effect == CCWATCH_SEDUCE ) then
				CCWATCH.CCS[CCWATCH_FEAR].DIMINISH = 1;
				CCWATCH.CCS[CCWATCH_SEDUCE].DIMINISH = 1;
			else
				CCWATCH.CCS[effect].DIMINISH = 1;
			end
		end

		CCWATCH.CCS[effect].TARGET = mobname;
		CCWATCH.CCS[effect].PLAYER = UnitIsPlayer("target");
		CCWATCH.CCS[effect].TIMER_START = GetTime();
		if( CCWATCH.CCS[effect].PVPCC and CCWATCH.CCS[effect].PLAYER ) then
			CCWATCH.CCS[effect].TIMER_END = CCWATCH.CCS[effect].TIMER_START + (CCWATCH.CCS[effect].PVPCC / CCWATCH.CCS[effect].DIMINISH);
		else
			CCWATCH.CCS[effect].TIMER_END = CCWATCH.CCS[effect].TIMER_START + (CCWATCH.CCS[effect].LENGTH / CCWATCH.CCS[effect].DIMINISH);
		end
		if( CCWATCH.CCS[effect].COMBO ) then
			CCWATCH.CCS[effect].TIMER_END = CCWATCH.CCS[effect].TIMER_END + CCWATCH.CCS[effect].A * CCWATCH.COMBO;
		end

		CCWatch_AddEffect(effect);

		CCWatch_UnqueueEvent();
	end
end

CCWatch_EffectHandler[2] = function()
-- faded
	if( CCWATCH.CCS[CCWATCH.EFFECT[1].TYPE].TARGET == CCWATCH.EFFECT[1].TARGET ) then
	-- target and CC target names match, wait for UNIT_AURA to ensure target match
		if( CCWATCH.STYLE ~= 0 or math.abs( CCWATCH.UNIT_AURA.TIME - CCWATCH.EFFECT[1].TIME ) < CCWATCH.THRESHOLD ) then
			CCWATCH.CCS[CCWATCH.EFFECT[1].TYPE].TIMER_END = GetTime();
			CCWatch_RemoveEffect(CCWATCH.EFFECT[1].TYPE, false);
			CCWatch_UnqueueEvent();
	-- unless the debuff is gone from the target, then no need for UNIT_AURA to confirm it
		elseif CCWATCH.STYLE == 0 and CCWatch_EffectGone(CCWATCH.EFFECT[1].TYPE) then
			CCWATCH.CCS[CCWATCH.EFFECT[1].TYPE].TIMER_END = GetTime()
			CCWatch_RemoveEffect(CCWATCH.EFFECT[1].TYPE, false);
			CCWatch_UnqueueEvent();
		end
	else
	-- target and CC target names don't match, retargetting has occured, no need to wait for UNIT_AuRA
		CCWATCH.CCS[CCWATCH.EFFECT[1].TYPE].TIMER_END = GetTime();
		CCWatch_RemoveEffect(CCWATCH.EFFECT[1].TYPE, false);
		CCWatch_UnqueueEvent();
	end
end

CCWatch_EffectHandler[3] = function()
-- broken
	if( CCWATCH.CCS[CCWATCH.EFFECT[1].TYPE].TARGET == CCWATCH.EFFECT[1].TARGET ) then
	-- target and CC target names match, wait for UNIT_AURA to ensure target match
		if( CCWATCH.STYLE ~= 0 or math.abs( CCWATCH.UNIT_AURA.TIME - CCWATCH.EFFECT[1].TIME ) < CCWATCH.THRESHOLD ) then
			CCWATCH.CCS[CCWATCH.EFFECT[1].TYPE].TIMER_END = GetTime();
			CCWatch_RemoveEffect(CCWATCH.EFFECT[1].TYPE, false);
			CCWatch_UnqueueEvent();
	-- unless the debuff is gone from the target, then no need for UNIT_AURA to confirm it
		elseif CCWATCH.STYLE == 0 and CCWatch_EffectGone(CCWATCH.EFFECT[1].TYPE) then
			CCWATCH.CCS[CCWATCH.EFFECT[1].TYPE].TIMER_END = GetTime()
			CCWatch_RemoveEffect(CCWATCH.EFFECT[1].TYPE, false);
			CCWatch_UnqueueEvent();
		end
	else
	-- target and CC target names don't match, retargetting has occured, no need to wait for UNIT_AuRA
		CCWATCH.CCS[CCWATCH.EFFECT[1].TYPE].TIMER_END = GetTime();

		CCWatch_RemoveEffect(CCWATCH.EFFECT[1].TYPE, false);
		CCWatch_UnqueueEvent();
	end
end


function CCWatch_QueueEvent(effect, mobname, time, status)
	local effect_structure = {}
	effect_structure.TYPE = effect;
	effect_structure.TARGET = mobname;
	effect_structure.TIME = time;
	effect_structure.STATUS = status
	table.insert( CCWATCH.EFFECT, effect_structure )
end

function CCWatch_UnqueueEvent()
	table.remove( CCWATCH.EFFECT, 1)
end

function CCWatch_EffectGone(effect)
	local i;
	local effectgone = false; -- assume effect is gone unless we find it
	for i = 1,8 do
		if UnitDebuff("target", i) == CCWATCH.CCS[effect].TEXTURE then
			effectgone = true
		end
	end
	return effectgone;
end

function CCWatch_AddEffect(effect)
	-- first remove any old copies of this effect, to avoid nasty overlap and properly set diminishing returns for multi-CC
	local group = CCWATCH.CCS[effect].group
	local GROUPS;
	CCWatch_RemoveEffect(effect, true)

	if CCWATCH.CCS[effect].ETYPE == ETYPE_BUFF then
		GROUPS = CCWATCH.GROUPSBUFF;
	elseif CCWATCH.CCS[effect].ETYPE == ETYPE_DEBUFF then
		GROUPS = CCWATCH.GROUPSDEBUFF;
	else
		GROUPS = CCWATCH.GROUPSCC;
	end
	if CCWATCH.GROWTH == 1 then
		group = 1
		-- start at the bottom and find the first available bar, otherwise queue to #5
		while group < 5 and table.getn(GROUPS[group].EFFECT) > 0 do
			group = group + 1
		end
		CCWATCH.CCS[effect].GROUP = group
	elseif CCWATCH.GROWTH == 2 then
		group = 5
		-- start at the top and find the first available bar, otherwise queue to #1
		while group > 1 and table.getn(GROUPS[group].EFFECT) > 0 do
			group = group - 1
		end
		CCWATCH.CCS[effect].GROUP = group
	end

	-- new effect goes at the head of the queue... always displaying newest effect
	CCWatch_QueueEffect(effect)
end

function CCWatch_RemoveEffect(effect, dr)
	local group = CCWATCH.CCS[effect].GROUP;
	local GROUPS;

	CCWatch_UnqueueEffect(effect);

	if CCWATCH.CCS[effect].ETYPE == ETYPE_BUFF then
		GROUPS = CCWATCH.GROUPSBUFF;
	elseif CCWATCH.CCS[effect].ETYPE == ETYPE_DEBUFF then
		GROUPS = CCWATCH.GROUPSDEBUFF;
	else
		GROUPS = CCWATCH.GROUPSCC;
	end

	if CCWATCH.GROWTH == 1 then
		while group < 5 and table.getn(GROUPS[group].EFFECT) == 0 and table.getn(GROUPS[group+1].EFFECT) > 0 do
			local move_effect = GROUPS[group+1].EFFECT[1];
			CCWatch_UnqueueEffect(move_effect);
			CCWATCH.CCS[move_effect].GROUP = group
			CCWatch_QueueEffect(move_effect);
			group = group + 1
		end
	elseif CCWATCH.GROWTH == 2 then
		while group > 1 and table.getn(GROUPS[group].EFFECT) == 0 and table.getn(GROUPS[group-1].EFFECT) > 0 do
			local move_effect = GROUPS[group-1].EFFECT[1];
			CCWatch_UnqueueEffect(move_effect);
			CCWATCH.CCS[move_effect].GROUP = group
			CCWatch_QueueEffect(move_effect);
			group = group - 1
		end
	end

	-- set diminishing returns based on CCS[effect].DIMINISHES (documented in CCWatch_Config.lua)
	if( dr and ((CCWATCH.CCS[effect].PLAYER and CCWATCH.CCS[effect].DIMINISHES > 0) or CCWATCH.CCS[effect].DIMINISHES == 1) ) then
-- quick & dirty hack for shared DR between Seduce & Fear)
		if( effect == CCWATCH_FEAR or effect == CCWATCH_SEDUCE ) then
			CCWATCH.CCS[CCWATCH_FEAR].DIMINISH = 2 * CCWATCH.CCS[CCWATCH_FEAR].DIMINISH;
			CCWATCH.CCS[CCWATCH_SEDUCE].DIMINISH = 2 * CCWATCH.CCS[CCWATCH_SEDUCE].DIMINISH;
		else
			CCWATCH.CCS[effect].DIMINISH = 2 * CCWATCH.CCS[effect].DIMINISH;
		end
	end
end

function CCWatch_QueueEffect(effect)
	local group = CCWATCH.CCS[effect].GROUP;
	local GROUPS;
	local ext = "";

	if CCWATCH.CCS[effect].ETYPE == ETYPE_BUFF then
		GROUPS = CCWATCH.GROUPSBUFF;
		ext = "Buff";
	elseif CCWATCH.CCS[effect].ETYPE == ETYPE_DEBUFF then
		GROUPS = CCWATCH.GROUPSDEBUFF;
		ext = "Debuff";
	else
		GROUPS = CCWATCH.GROUPSCC;
		ext = "CC";
	end

	table.insert( GROUPS[group].EFFECT, 1, effect )

	local activebarText = getglobal("CCWatchBar"..ext..group.."Text");
	activebarText:SetText(effect..": "..CCWATCH.CCS[effect].TARGET);

	-- if queue was empty show bar
	if( table.getn(GROUPS[group].EFFECT) == 1 ) then
		local activebar = getglobal("CCWatchBar"..ext..group);
		activebar:Show();
	end
end

function CCWatch_UnqueueEffect(effect)
	local group = CCWATCH.CCS[effect].GROUP;
	local GROUPS;
	local ext = "";

	if CCWATCH.CCS[effect].ETYPE == ETYPE_BUFF then
		GROUPS = CCWATCH.GROUPSBUFF;
		ext = "Buff";
	elseif CCWATCH.CCS[effect].ETYPE == ETYPE_DEBUFF then
		GROUPS = CCWATCH.GROUPSDEBUFF;
		ext = "Debuff";
	else
		GROUPS = CCWATCH.GROUPSCC;
		ext = "CC";
	end

	local index = 0;
	-- find the effect in the queue, if it's not there index stays 0
	table.foreach( GROUPS[group].EFFECT, function(k,v) if( v == effect ) then index = k end end );
	if( index ~= 0 ) then
		CCWATCH.CCS[GROUPS[group].EFFECT[index]].TARGET = ""; -- resetting target for mob death removal
		table.remove( GROUPS[group].EFFECT, index );
	end

	-- if queue isn't empty set new name
	if( table.getn(GROUPS[group].EFFECT) > 0 ) then
		local activebarText = getglobal("CCWatchBar"..ext..group.."Text");
		local effect = GROUPS[group].EFFECT[1];
		activebarText:SetText(effect..": "..CCWATCH.CCS[effect].TARGET);
	else
		local activebarText = getglobal("CCWatchBar"..ext..group.."Text");
		activebarText:SetText("CCWatch "..ext.." Bar "..group);
	end
end

function CCWatchBarCC_OnShow(group)
	CCWatchBar_OnShow(group, CCWATCH.GROUPSCC, "CC");
end

function CCWatchBarDebuff_OnShow(group)
	CCWatchBar_OnShow(group, CCWATCH.GROUPSDEBUFF, "Debuff");
end

function CCWatchBarBuff_OnShow(group)
	CCWatchBar_OnShow(group, CCWATCH.GROUPSBUFF, "Buff");
end

function CCWatchBar_OnShow(group, GROUPS, ext)
	local barname = "CCWatch"..ext;
	getglobal(barname):SetScale(CCWATCH.SCALE);

--	local status = GetTime();

	barname = "CCWatchBar"..ext..group;
	local activebar = getglobal(barname);
	activebar:SetBackdropColor(0, 0, 0, 0.35);
	activebar:SetAlpha(CCWATCH.ALPHA);

	if( table.getn(GROUPS[group].EFFECT) == 0 ) then
		getglobal(barname.."Text"):SetText("CCWatch Bar "..ext.." "..group);
	end

	getglobal(barname.."StatusBar"):SetStatusBarColor(1, 1, 0);
	getglobal(barname.."StatusBarSpark"):SetPoint("CENTER", barname.."StatusBar", "LEFT", 0, 0);
end


function CCWatchBarCC1_OnShow() CCWatchBarCC_OnShow(1) end
function CCWatchBarCC2_OnShow() CCWatchBarCC_OnShow(2) end
function CCWatchBarCC3_OnShow() CCWatchBarCC_OnShow(3) end
function CCWatchBarCC4_OnShow() CCWatchBarCC_OnShow(4) end
function CCWatchBarCC5_OnShow() CCWatchBarCC_OnShow(5) end

function CCWatchBarDebuff1_OnShow() CCWatchBarDebuff_OnShow(1) end
function CCWatchBarDebuff2_OnShow() CCWatchBarDebuff_OnShow(2) end
function CCWatchBarDebuff3_OnShow() CCWatchBarDebuff_OnShow(3) end
function CCWatchBarDebuff4_OnShow() CCWatchBarDebuff_OnShow(4) end
function CCWatchBarDebuff5_OnShow() CCWatchBarDebuff_OnShow(5) end

function CCWatchBarBuff1_OnShow() CCWatchBarBuff_OnShow(1) end
function CCWatchBarBuff2_OnShow() CCWatchBarBuff_OnShow(2) end
function CCWatchBarBuff3_OnShow() CCWatchBarBuff_OnShow(3) end
function CCWatchBarBuff4_OnShow() CCWatchBarBuff_OnShow(4) end
function CCWatchBarBuff5_OnShow() CCWatchBarBuff_OnShow(5) end

function CCWatch_OnUpdate()
	if( CCWATCH.STATUS == 0 ) then
		return
	end

--	local status = GetTime();
	table.foreach( CCWATCH.GROUPSCC, CCWatch_GroupCCUpdate );
	table.foreach( CCWATCH.GROUPSDEBUFF, CCWatch_GroupDebuffUpdate );
	table.foreach( CCWATCH.GROUPSBUFF, CCWatch_GroupBuffUpdate );
end

function CCWatch_GroupCCUpdate(group)
	CCWatch_GroupUpdate(group, CCWATCH.GROUPSCC, "CC");
end

function CCWatch_GroupDebuffUpdate(group)
	CCWatch_GroupUpdate(group, CCWATCH.GROUPSDEBUFF, "Debuff");
end

function CCWatch_GroupBuffUpdate(group)
	CCWatch_GroupUpdate(group, CCWATCH.GROUPSBUFF, "Buff");
end

function CCWatch_GroupUpdate(group, GROUPS, ext)
	local activebar = getglobal("CCWatchBar"..ext..group)

	if( table.getn(GROUPS[group].EFFECT) > 0 ) then
	-- active effect on this bar
		activebar:SetAlpha(CCWATCH.ALPHA);

		local status = GetTime();
		local effect = GROUPS[group].EFFECT[1]
		local activebarStatusBar = getglobal("CCWatchBar"..ext..group.."StatusBar");
		local activebarTextBar = getglobal("CCWatchBar"..ext..group.."StatusBarText");
		local str = "";

		if( status <= CCWATCH.CCS[effect].TIMER_END  ) then
		-- CC hasn't expired
			activebarStatusBar:SetMinMaxValues(CCWATCH.CCS[effect].TIMER_START, CCWATCH.CCS[effect].TIMER_END);
			local sparkPosition = ((status - CCWATCH.CCS[effect].TIMER_START) / (CCWATCH.CCS[effect].TIMER_END - CCWATCH.CCS[effect].TIMER_START)) * CCWATCH.WIDTH;
			if( CCWATCH.INVERT ) then
				sparkPosition = CCWATCH.WIDTH - sparkPosition;
				activebarStatusBar:SetValue(CCWATCH.CCS[effect].TIMER_START + CCWATCH.CCS[effect].TIMER_END - status);
			else
				activebarStatusBar:SetValue(status);
			end
			if( sparkPosition < 1 ) then
				sparkPosition = 1;
			end
			local activebarSpark = getglobal("CCWatchBar"..ext..group.."StatusBarSpark");
			activebarSpark:SetPoint("CENTER", "CCWatchBar"..ext..group.."StatusBar", "LEFT", sparkPosition, 0);
			if CCWATCH.TIMERS == 1 then
				str = format("%.2f", status - CCWATCH.CCS[effect].TIMER_START);
			elseif CCWATCH.TIMERS == 2 then
				str = format("%.2f", CCWATCH.CCS[effect].TIMER_END - status);
			end
			activebarTextBar:SetText(str);

		else
		-- CC has expired
			CCWatch_RemoveEffect(effect, false)
		end

	elseif( activebar:GetAlpha() > 0 ) then
	-- otherwise fade out this bar if not unlocked
		if( CCWATCH.STATUS == 1 ) then
			local activebarText = getglobal("CCWatchBar"..ext..group.."Text");
			activebarText:SetText("TimeOut");
			local alpha = activebar:GetAlpha() - 0.2;
			if( alpha > 0 ) then
				activebar:SetAlpha(alpha);
			else
				activebar:Hide();
			end
		end
	else
	-- done fading, hide this bar
		activebar:Hide();
	end
end



local function GetSavedCC(k, v)
	if v == nil then
--CCWatch_AddMessage("Removing "..k);
		CCWATCH.CCS[k] = nil;
		return;
	end
	if v.GROUP == nil or v.ETYPE == nil or v.LENGTH == nil or v.DIMINISHES == nil then
		CCWATCH.CCS[k] = nil;
		return;
	end
--CCWatch_AddMessage("Adding "..k.." ("..type(k)..")");
	CCWATCH.CCS[k] = {
		GROUP = v.GROUP,
		ETYPE = v.ETYPE,
		LENGTH = v.LENGTH,
		DIMINISHES = v.DIMINISHES,

		TARGET = "",
		PLAYER = nil,
		TIMER_START = 0,
		TIMER_END = 0,
		DIMINISH = 1,
		MONITOR = true
	}
end

function CCWatch_LoadVariables()
	CCWATCH.PROFILE = UnitName("player").." of "..GetCVar("RealmName");

	if CCWatch_Save[CCWATCH.PROFILE] == nil then
		CCWatch_Save[CCWATCH.PROFILE] = {}
	end

	if CCWatch_Save[CCWATCH.PROFILE].status == nil then
		CCWatch_Save[CCWATCH.PROFILE].status = CCWATCH.STATUS
	end

	if CCWatch_Save[CCWATCH.PROFILE].invert == nil then
		CCWatch_Save[CCWATCH.PROFILE].invert = false
	end

	if CCWatch_Save[CCWATCH.PROFILE].growth == nil then
		CCWatch_Save[CCWATCH.PROFILE].growth = 0
	end

	if CCWatch_Save[CCWATCH.PROFILE].scale == nil then
		CCWatch_Save[CCWATCH.PROFILE].scale = 1
	end

	if CCWatch_Save[CCWATCH.PROFILE].width == nil then
		CCWatch_Save[CCWATCH.PROFILE].width = 160
	end

	if CCWatch_Save[CCWATCH.PROFILE].alpha == nil then
		CCWatch_Save[CCWATCH.PROFILE].alpha = 1
	end

	if CCWatch_Save[CCWATCH.PROFILE].arcanist == nil then
		CCWatch_Save[CCWATCH.PROFILE].arcanist = false
	end

	if CCWatch_Save[CCWATCH.PROFILE].timers == nil then
		CCWatch_Save[CCWATCH.PROFILE].timers = 1
	end

	if CCWatch_Save[CCWATCH.PROFILE].MonitorMage == nil then
		CCWatch_Save[CCWATCH.PROFILE].MonitorMage = true
	end

	if CCWatch_Save[CCWATCH.PROFILE].MonitorPriest == nil then
		CCWatch_Save[CCWATCH.PROFILE].MonitorPriest = true
	end

	if CCWatch_Save[CCWATCH.PROFILE].MonitorDruid == nil then
		CCWatch_Save[CCWATCH.PROFILE].MonitorDruid = true
	end

	if CCWatch_Save[CCWATCH.PROFILE].MonitorHunter == nil then
		CCWatch_Save[CCWATCH.PROFILE].MonitorHunter = true
	end

	if CCWatch_Save[CCWATCH.PROFILE].MonitorPaladin == nil then
		CCWatch_Save[CCWATCH.PROFILE].MonitorPaladin = true
	end

	if CCWatch_Save[CCWATCH.PROFILE].MonitorWarlock == nil then
		CCWatch_Save[CCWATCH.PROFILE].MonitorWarlock = true
	end

	if CCWatch_Save[CCWATCH.PROFILE].MonitorWarrior == nil then
		CCWatch_Save[CCWATCH.PROFILE].MonitorWarrior = true
	end

	if CCWatch_Save[CCWATCH.PROFILE].MonitorRogue == nil then
		CCWatch_Save[CCWATCH.PROFILE].MonitorRogue = true
	end

	if CCWatch_Save[CCWATCH.PROFILE].MonitorMisc == nil then
		CCWatch_Save[CCWATCH.PROFILE].MonitorMisc = true
	end

	if CCWatch_Save[CCWATCH.PROFILE].style == nil then
		CCWatch_Save[CCWATCH.PROFILE].style = 0
	end

	if CCWatch_Save[CCWATCH.PROFILE].Monitoring == nil then
		CCWatch_Save[CCWATCH.PROFILE].Monitoring = bit.bor(ETYPE_CC, ETYPE_DEBUFF, ETYPE_BUFF);
	end

	CCWATCH.ARCANIST = CCWatch_Save[CCWATCH.PROFILE].arcanist

-- update array with saved CCs
	table.foreach(CCWatch_SavedCC, GetSavedCC);

	CCWatch_UpdateTextures();
	CCWatch_UpdateClassSpells(false);

	CCWATCH.STATUS = CCWatch_Save[CCWATCH.PROFILE].status
	CCWATCH.INVERT = CCWatch_Save[CCWATCH.PROFILE].invert
	CCWATCH.TIMERS = CCWatch_Save[CCWATCH.PROFILE].timers
	CCWATCH.GROWTH = CCWatch_Save[CCWATCH.PROFILE].growth
	CCWATCH.SCALE = CCWatch_Save[CCWATCH.PROFILE].scale
	CCWATCH.WIDTH = CCWatch_Save[CCWATCH.PROFILE].width
	CCWATCH.ALPHA = CCWatch_Save[CCWATCH.PROFILE].alpha

	CCWATCH.MONITORMAGE = CCWatch_Save[CCWATCH.PROFILE].MonitorMage
	CCWATCH.MONITORPRIEST = CCWatch_Save[CCWATCH.PROFILE].MonitorPriest
	CCWATCH.MONITORDRUID = CCWatch_Save[CCWATCH.PROFILE].MonitorDruid
	CCWATCH.MONITORHUNTER = CCWatch_Save[CCWATCH.PROFILE].MonitorHunter
	CCWATCH.MONITORPALADIN = CCWatch_Save[CCWATCH.PROFILE].MonitorPaladin
	CCWATCH.MONITORWARLOCK = CCWatch_Save[CCWATCH.PROFILE].MonitorWarlock
	CCWATCH.MONITORWARRIOR = CCWatch_Save[CCWATCH.PROFILE].MonitorWarrior
	CCWATCH.MONITORROGUE = CCWatch_Save[CCWATCH.PROFILE].MonitorRogue
	CCWATCH.MONITORMISC = CCWatch_Save[CCWATCH.PROFILE].MonitorMisc

	CCWATCH.MONITORING = CCWatch_Save[CCWATCH.PROFILE].Monitoring

	CCWatchObject = this;

	if bit.band(CCWATCH.MONITORING, ETYPE_CC) ~= 0 or bit.band(CCWATCH.MONITORING, ETYPE_DEBUFF) ~= 0 then
		CCWatchObject:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
		CCWatchObject:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
	end
	if bit.band(CCWATCH.MONITORING, ETYPE_BUFF) ~= 0 then
		CCWatchObject:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");
		CCWatchObject:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS");
	end

	CCWATCH.STYLE = CCWatch_Save[CCWATCH.PROFILE].style;

	CCWatchCC:SetScale(CCWATCH.SCALE);
	CCWatchDebuff:SetScale(CCWATCH.SCALE);
	CCWatchBuff:SetScale(CCWATCH.SCALE);
	CCWatch_SetWidth(CCWATCH.WIDTH);

	CCWatch_BarUnlock();
	CCWatch_BarLock();

	if( CCWATCH.STATUS == 2 ) then
		CCWatch_BarUnlock();
	end

	CCWatchOptions_Init();

-- Pure cosmetic for Unlock move
	CCWatchBarCC1StatusBarText:SetText("0.00");
	CCWatchBarCC2StatusBarText:SetText("0.00");
	CCWatchBarCC3StatusBarText:SetText("0.00");
	CCWatchBarCC4StatusBarText:SetText("0.00");
	CCWatchBarCC5StatusBarText:SetText("0.00");

	CCWatchBarDebuff1StatusBarText:SetText("0.00");
	CCWatchBarDebuff2StatusBarText:SetText("0.00");
	CCWatchBarDebuff3StatusBarText:SetText("0.00");
	CCWatchBarDebuff4StatusBarText:SetText("0.00");
	CCWatchBarDebuff5StatusBarText:SetText("0.00");

	CCWatchBarBuff1StatusBarText:SetText("0.00");
	CCWatchBarBuff2StatusBarText:SetText("0.00");
	CCWatchBarBuff3StatusBarText:SetText("0.00");
	CCWatchBarBuff4StatusBarText:SetText("0.00");
	CCWatchBarBuff5StatusBarText:SetText("0.00");

end

function CCWatch_UpdateTextures()
	local i = 1
	while true do
		local name, rank = GetSpellName(i, BOOKTYPE_SPELL)
		if not name then return end
		if CCWATCH.CCS[name] then
			CCWATCH.CCS[name].TEXTURE = GetSpellTexture(i, BOOKTYPE_SPELL)
		elseif CCWATCH_SPELLS[name] then
			if CCWATCH_SPELLS[name].EFFECTNAME then
				CCWATCH.CCS[CCWATCH_SPELLS[name].EFFECTNAME].TEXTURE = GetSpellTexture(i, BOOKTYPE_SPELL);
			else
				CCWatch_AddMessage("Warning : ranked spell '"..name.."' has a different name from its effect, but no effect name in its definition.");
			end
		end
		i = i + 1
	end
end

function CCWatch_UpdateImpGouge(bPrint)
	local talentname, texture, _, _, rank, _, _, _ = GetTalentInfo( 2, 1 );
	if texture then
		if rank ~= 0 then
			if bPrint  then
				CCWatch_AddMessage(talentname.." "..CCWATCH_RANK.." "..rank.." "..CCWATCH_DETECTED);
			end
			CCWATCH.CCS[CCWATCH_GOUGE].LENGTH = 4 + rank * 0.5;
		end
	elseif CCWATCH.CCS[CCWATCH_GOUGE].LENGTH == nil then
		CCWATCH.CCS[CCWATCH_GOUGE].LENGTH = 4;
	end
end

function CCWatch_UpdateKidneyShot(bPrint)
	local i = 1
	while true do
		local name, rank = GetSpellName(i, BOOKTYPE_SPELL)
		if not name then
			if( CCWATCH.CCS[CCWATCH_KS].LENGTH == nil ) then
				CCWATCH.CCS[CCWATCH_KS].LENGTH = 1;
			end
			return
		end

		if( name == CCWATCH_KS ) then
			if bPrint then
				CCWatch_AddMessage(name.." "..CCWATCH_RANK.." "..rank.." "..CCWATCH_DETECTED);
			end
			if( string.sub(rank,string.len(rank)) == "1" ) then
				CCWATCH.CCS[CCWATCH_KS].LENGTH = 0;
			else
				CCWATCH.CCS[CCWATCH_KS].LENGTH = 1;
			end
			return
		end

		i = i + 1
	end
end

function CCWatch_UpdateImpTrap(bPrint)
	local talentname, texture, _, _, rank, _, _, _ = GetTalentInfo( 3, 7 );
	if texture then
		if rank ~= 0 then
			if bPrint then
				CCWatch_AddMessage(talentname.." "..CCWATCH_RANK.." "..rank.." "..CCWATCH_DETECTED);
			end
-- Freezing Trap is a true multi rank, hence already updated
			CCWATCH.CCS[CCWATCH_FREEZINGTRAP].LENGTH = CCWATCH.CCS[CCWATCH_FREEZINGTRAP].LENGTH * (1 + rank * 0.15);
		end
	end
end


function CCWatch_UpdateImpSeduce(bPrint)
	local talentname, texture, _, _, rank, _, _, _ = GetTalentInfo( 2, 7 );
	if texture then
		if rank ~= 0 then
			if bPrint then
				CCWatch_AddMessage(talentname.." "..CCWATCH_RANK.." "..rank.." "..CCWATCH_DETECTED);
			end
			CCWATCH.CCS[CCWATCH_SEDUCE].LENGTH = 15 * (1 + rank * 0.10);
		end
	end
end


function CCWatch_UpdateBrutalImpact(bPrint)
	local talentname, texture, _, _, rank, _, _, _ = GetTalentInfo( 2, 4 );
	if texture then
		if rank ~= 0 then
			if bPrint then
				CCWatch_AddMessage(talentname.." "..CCWATCH_RANK.." "..rank.." "..CCWATCH_DETECTED);
			end
-- Bash is a true multi rank, hence already updated
			CCWATCH.CCS[CCWATCH_POUNCE].LENGTH = 2 + rank * 0.50;
			CCWATCH.CCS[CCWATCH_BASH].LENGTH = CCWATCH.CCS[CCWATCH_BASH].LENGTH + rank * 0.50;
		end
	end
end


function CCWatch_UpdatePermafrost(bPrint)
	local talentname, texture, _, _, rank, _, _, _ = GetTalentInfo( 3, 2 );
	if texture then
		if rank ~= 0 then
			if bPrint then
				CCWatch_AddMessage(talentname.." "..CCWATCH_RANK.." "..rank.." "..CCWATCH_DETECTED);
			end
-- Frostbolt is a true multi rank, hence already updated
			CCWATCH.CCS[CCWATCH_CONEOFCOLD].LENGTH = 8 + 0.50 + rank * 0.50;
			CCWATCH.CCS[CCWATCH_FROSTBOLT].LENGTH = CCWATCH.CCS[CCWATCH_FROSTBOLT].LENGTH + 0.50 + rank * 0.50;
		end
	end
end

function CCWatch_UpdateImpShadowWordPain(bPrint)
	local talentname, texture, _, _, rank, _, _, _ = GetTalentInfo( 3, 4 );
	if texture then
		if rank ~= 0 then
			if bPrint then
				CCWatch_AddMessage(talentname.." "..CCWATCH_RANK.." "..rank.." "..CCWATCH_DETECTED);
			end
			CCWATCH.CCS[CCWATCH_SHADOWWORDPAIN].LENGTH = 8 + rank * 3;
		end
	end
end


function CCWatch_GetSpellRank(spellname, spelleffect, bPrint)
	local i = 1;
	local gotone = false;
	local maxrank = CCWATCH_SPELLS[spellname].RANKS;

	while true do
		local name, rank = GetSpellName(i, BOOKTYPE_SPELL)

		if not name then
			if not gotone then
--	CCWatch_AddMessage(spellname.." "..CCWATCH_NOTDETECTED);
				if( CCWATCH.CCS[spelleffect].LENGTH == nil ) then
					CCWATCH.CCS[spelleffect].LENGTH = CCWATCH_SPELLS[spellname].DURATION[maxrank];
				end
			end
			return
		end

		if( name == spellname ) then
			local currank = 1;
			while currank <= maxrank do
				if( tonumber(string.sub(rank,string.len(rank))) == currank) then
					if bPrint then
						CCWatch_AddMessage(spellname.." "..CCWATCH_RANK.." "..currank.." "..CCWATCH_DETECTED);
					end

					CCWATCH.CCS[spelleffect].LENGTH = CCWATCH_SPELLS[spellname].DURATION[currank];
					gotone = true;
				end
				currank = currank + 1;
			end
		end

		i = i + 1
	end
end

function CCWatch_UpdateClassSpells(bPrint)
	local _, eclass = UnitClass("player");
	CCWatchOptionsFrameArcanist:Hide();
	if eclass == "ROGUE" then
		CCWatch_GetSpellRank(CCWATCH_SAP, CCWATCH_SAP, bPrint);
		CCWatch_UpdateImpGouge(bPrint);
		CCWatch_UpdateKidneyShot(bPrint);
	elseif eclass == "WARLOCK" then
		CCWatch_GetSpellRank(CCWATCH_FEAR, CCWATCH_FEAR, bPrint);
		CCWatch_GetSpellRank(CCWATCH_BANISH, CCWATCH_BANISH, bPrint);
		CCWatch_UpdateImpSeduce(bPrint);
	elseif eclass == "PALADIN" then
		CCWatch_GetSpellRank(CCWATCH_HOJ, CCWATCH_HOJ, bPrint);
		if CCWatch_ConfigBuff ~= nil then
			CCWatch_GetSpellRank(CCWATCH_DIVINESHIELD, CCWATCH_DIVINESHIELD, bPrint);
		end
	elseif eclass == "HUNTER" then
		CCWatch_GetSpellRank(CCWATCH_FREEZINGTRAP_SPELL, CCWATCH_FREEZINGTRAP, bPrint);
		CCWatch_GetSpellRank(CCWATCH_SCAREBEAST, CCWATCH_SCAREBEAST, bPrint);
		CCWatch_UpdateImpTrap(bPrint);
	elseif eclass == "PRIEST" then
		CCWatch_GetSpellRank(CCWATCH_SHACKLE, CCWATCH_SHACKLE, bPrint);
		if CCWatch_ConfigDebuff ~= nil then
			CCWatch_UpdateImpShadowWordPain(bPrint);
		end
	elseif eclass == "MAGE" then
		CCWatch_GetSpellRank(CCWATCH_POLYMORPH, CCWATCH_POLYMORPH, bPrint);
		if CCWatch_ConfigDebuff ~= nil then
			CCWatch_GetSpellRank(CCWATCH_FROSTBOLT, CCWATCH_FROSTBOLT, bPrint);
			CCWatch_GetSpellRank(CCWATCH_FIREBALL, CCWATCH_FIREBALL, bPrint);
			CCWatch_UpdatePermafrost(bPrint);
		end
		CCWatchOptionsFrameArcanist:Show();
		if CCWATCH.ARCANIST then
			CCWATCH.CCS[CCWATCH_POLYMORPH].LENGTH = CCWATCH.CCS[CCWATCH_POLYMORPH].LENGTH + 15;
		end
	elseif eclass == "DRUID" then
		CCWatch_GetSpellRank(CCWATCH_ROOTS, CCWATCH_ROOTS, bPrint);
		CCWatch_GetSpellRank(CCWATCH_HIBERNATE, CCWATCH_HIBERNATE, bPrint);
		CCWatch_GetSpellRank(CCWATCH_BASH, CCWATCH_BASH, bPrint);
		CCWatch_UpdateBrutalImpact(bPrint);
	end
end

function CCWatch_Help()
	CCWatch_AddMessage(CCWATCH_FULLVERSION..CCWATCH_HELP1);
	CCWatch_AddMessage(CCWATCH_HELP2);
	CCWatch_AddMessage(CCWATCH_HELP3);
	CCWatch_AddMessage(CCWATCH_HELP4);
	CCWatch_AddMessage(CCWATCH_HELP5);
	CCWatch_AddMessage(CCWATCH_HELP6);
	CCWatch_AddMessage(CCWATCH_HELP7);
	CCWatch_AddMessage(CCWATCH_HELP8);
	CCWatch_AddMessage(CCWATCH_HELP9);
	CCWatch_AddMessage(CCWATCH_HELP10);
	CCWatch_AddMessage(CCWATCH_HELP11);
	CCWatch_AddMessage(CCWATCH_HELP12);
	CCWatch_AddMessage(CCWATCH_HELP13);
	CCWatch_AddMessage(CCWATCH_HELP14);
	CCWatch_AddMessage(CCWATCH_HELP15);
end

function CCWatch_SetWidth(width)
	CCWatchBarCC1:SetWidth(width + 10);
	CCWatchBarCC1Text:SetWidth(width);
	CCWatchBarCC1StatusBar:SetWidth(width);
	CCWatchBarCC2:SetWidth(width + 10);
	CCWatchBarCC2Text:SetWidth(width);
	CCWatchBarCC2StatusBar:SetWidth(width);
	CCWatchBarCC3:SetWidth(width + 10);
	CCWatchBarCC3Text:SetWidth(width);
	CCWatchBarCC3StatusBar:SetWidth(width);
	CCWatchBarCC4:SetWidth(width + 10);
	CCWatchBarCC4Text:SetWidth(width);
	CCWatchBarCC4StatusBar:SetWidth(width);
	CCWatchBarCC5:SetWidth(width + 10);
	CCWatchBarCC5Text:SetWidth(width);
	CCWatchBarCC5StatusBar:SetWidth(width);
	CCWatchCC:SetWidth(width + 10);
--
	CCWatchBarDebuff1:SetWidth(width + 10);
	CCWatchBarDebuff1Text:SetWidth(width);
	CCWatchBarDebuff1StatusBar:SetWidth(width);
	CCWatchBarDebuff2:SetWidth(width + 10);
	CCWatchBarDebuff2Text:SetWidth(width);
	CCWatchBarDebuff2StatusBar:SetWidth(width);
	CCWatchBarDebuff3:SetWidth(width + 10);
	CCWatchBarDebuff3Text:SetWidth(width);
	CCWatchBarDebuff3StatusBar:SetWidth(width);
	CCWatchBarDebuff4:SetWidth(width + 10);
	CCWatchBarDebuff4Text:SetWidth(width);
	CCWatchBarDebuff4StatusBar:SetWidth(width);
	CCWatchBarDebuff5:SetWidth(width + 10);
	CCWatchBarDebuff5Text:SetWidth(width);
	CCWatchBarDebuff5StatusBar:SetWidth(width);
	CCWatchDebuff:SetWidth(width + 10);
--
	CCWatchBarBuff1:SetWidth(width + 10);
	CCWatchBarBuff1Text:SetWidth(width);
	CCWatchBarBuff1StatusBar:SetWidth(width);
	CCWatchBarBuff2:SetWidth(width + 10);
	CCWatchBarBuff2Text:SetWidth(width);
	CCWatchBarBuff2StatusBar:SetWidth(width);
	CCWatchBarBuff3:SetWidth(width + 10);
	CCWatchBarBuff3Text:SetWidth(width);
	CCWatchBarBuff3StatusBar:SetWidth(width);
	CCWatchBarBuff4:SetWidth(width + 10);
	CCWatchBarBuff4Text:SetWidth(width);
	CCWatchBarBuff4StatusBar:SetWidth(width);
	CCWatchBarBuff5:SetWidth(width + 10);
	CCWatchBarBuff5Text:SetWidth(width);
	CCWatchBarBuff5StatusBar:SetWidth(width);
	CCWatchBuff:SetWidth(width + 10);
end



function CCWatch_CheckRecentTargets(mobname)
	local target = UnitName("target");
-- Simple compare if using current target monitoring
	if CCWATCH.STYLE == 0 then
		return mobname == target;
	end
	local index = 0;
-- Check mobname against the list
	table.foreach( CCWATCH.LASTTARGETS, function(k,v) if( v.TARGET == mobname ) then index = k end end );
	if index ~= 0 then
		return true;
	end

-- return false if target not found
	return false;
end

function CCWatch_AddLastTarget(mobname, time)
	local lt_struct = {}
	lt_struct.TARGET = mobname;
	lt_struct.TIME = time;

--	CCWatch_AddMessage("Adding "..mobname);

-- if the array is full
	if table.getn(CCWATCH.LASTTARGETS) >= 5 then
-- remove the oldest target
		local oldest = 0;
		local index = 0;
		table.foreach(CCWATCH.LASTTARGETS, function(k,v) if oldest == 0 then oldest = v.TIME; index = k; elseif( v.TIME < oldest ) then oldest = v.TIME; index = k; end end);
--		CCWatch_AddMessage("Removing old target : "..CCWATCH.LASTTARGETS[index].TARGET);
		table.remove(CCWATCH.LASTTARGETS, index);
	end
	table.insert( CCWATCH.LASTTARGETS, lt_struct )
-- DEBUG :
--	local targets = "Current targets : "
--	table.foreach(CCWATCH.LASTTARGETS, function(k,v) targets = targets.."'"..v.TARGET.."',"; end);
--	CCWatch_AddMessage(targets);
end

function CCWatch_AddMessage(msg)
	DEFAULT_CHAT_FRAME:AddMessage("<CCWatch> "..msg);
end