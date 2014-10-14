function StunWatch_OnLoad()
	StunWatch_Globals()
	StunWatch_Config()

	this:RegisterEvent("UNIT_AURA");
	this:RegisterEvent("UNIT_COMBAT");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
	this:RegisterEvent("CHAT_MSG_SPELL_BREAK_AURA");

	SLASH_STUNWATCH1 = "/stunwatch";
	SLASH_STUNWATCH2 = "/sw";
	SlashCmdList["STUNWATCH"] = function(msg)
		StunWatch_SlashCommandHandler(msg);
	end

	DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_VERSION..STUNWATCH_LOADED);
end

function StunWatch_SlashCommandHandler(msg)
	if( msg ) then
		local command = string.lower(msg);
		if( command == "on" ) then
			if( STUNWATCH.STATUS == 0 ) then
				STUNWATCH.STATUS = 1;
				StunWatch_Save[STUNWATCH.PROFILE].status = STUNWATCH.STATUS;
				DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_ENABLED);
			end
		elseif( command == "off" ) then
			if( STUNWATCH.STATUS ~= 0 ) then
				STUNWATCH.STATUS = 0;
				StunWatch_Save[STUNWATCH.PROFILE].status = STUNWATCH.STATUS;
				DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_DISABLED);
			end
		elseif( command == "unlock" ) then
			STUNWATCH.STATUS = 2;
			StunWatch:EnableMouse(1);
			StunWatchBar1:Show();
			StunWatchBar2:Show();
			StunWatchBar3:Show();
			StunWatchBar4:Show();
			StunWatchBar5:Show();
			DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_UNLOCKED);
		elseif( command == "lock" ) then
			STUNWATCH.STATUS = 1;
			StunWatch:EnableMouse(0);
			StunWatchBar1:Hide();
			StunWatchBar2:Hide();
			StunWatchBar3:Hide();
			StunWatchBar4:Hide();
			StunWatchBar5:Hide();
			DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_LOCKED);
		elseif( command == "invert" ) then
			STUNWATCH.INVERT = not STUNWATCH.INVERT;
			StunWatch_Save[STUNWATCH.PROFILE].invert = STUNWATCH.INVERT;
			if STUNWATCH.INVERT then
				DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_INVERSION_ON);
			else
				DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_INVERSION_OFF);
			end
		elseif( command == "grow off" ) then
			StunWatch_Save[STUNWATCH.PROFILE].growth = 0;
			STUNWATCH.GROWTH = StunWatch_Save[STUNWATCH.PROFILE].growth;
			DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_GROW_OFF)
		elseif( command == "grow up" ) then
			StunWatch_Save[STUNWATCH.PROFILE].growth = 1;
			STUNWATCH.GROWTH = StunWatch_Save[STUNWATCH.PROFILE].growth;
			DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_GROW_UP)
		elseif( command == "grow down" ) then
			StunWatch_Save[STUNWATCH.PROFILE].growth = 2;
			STUNWATCH.GROWTH = StunWatch_Save[STUNWATCH.PROFILE].growth;
			DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_GROW_DOWN)
		elseif( command == "clear" ) then
			StunWatch_Save[STUNWATCH.PROFILE] = nil;
			StunWatch_Globals();
			StunWatch_Config();
			STUNWATCH.VARIABLES_LOADED = false;
			StunWatch_LoadVariables(2);

		elseif( command == "g" ) then
			StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_GOUGE].LENGTH = nil;
			StunWatch_UpdateImpGouge();
			STUNWATCH.STUNS[STUNWATCH_GOUGE].LENGTH = StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_GOUGE].LENGTH;
		elseif( command == "g0" ) then
			StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_GOUGE].LENGTH = 4.0;
			STUNWATCH.STUNS[STUNWATCH_GOUGE].LENGTH = StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_GOUGE].LENGTH;
		elseif( command == "g1" ) then
			StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_GOUGE].LENGTH = 4.5;
			STUNWATCH.STUNS[STUNWATCH_GOUGE].LENGTH = StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_GOUGE].LENGTH;
		elseif( command == "g2" ) then
			StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_GOUGE].LENGTH = 5.0;
			STUNWATCH.STUNS[STUNWATCH_GOUGE].LENGTH = StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_GOUGE].LENGTH;
		elseif( command == "g3" ) then
			StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_GOUGE].LENGTH = 5.5;
			STUNWATCH.STUNS[STUNWATCH_GOUGE].LENGTH = StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_GOUGE].LENGTH;

		elseif( command == "k" ) then
			StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_KS].LENGTH = nil;
			StunWatch_UpdateKidneyShot();
			STUNWATCH.STUNS[STUNWATCH_KS].LENGTH = StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_KS].LENGTH;
		elseif( command == "k1" ) then
			StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_KS].LENGTH = 0;
			STUNWATCH.STUNS[STUNWATCH_KS].LENGTH = StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_KS].LENGTH;
		elseif( command == "k2" ) then
			StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_KS].LENGTH = 1;
			STUNWATCH.STUNS[STUNWATCH_KS].LENGTH = StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_KS].LENGTH;

		elseif( command == "s" ) then
			StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_SAP].LENGTH = nil;
			StunWatch_UpdateSap();
			STUNWATCH.STUNS[STUNWATCH_SAP].LENGTH = StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_SAP].LENGTH;
		elseif( command == "s1" ) then
			StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_SAP].LENGTH = 25;
			STUNWATCH.STUNS[STUNWATCH_SAP].LENGTH = StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_SAP].LENGTH;
		elseif( command == "s2" ) then
			StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_SAP].LENGTH = 35;
			STUNWATCH.STUNS[STUNWATCH_SAP].LENGTH = StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_SAP].LENGTH;
		elseif( command == "s3" ) then
			StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_SAP].LENGTH = 45;
			STUNWATCH.STUNS[STUNWATCH_SAP].LENGTH = StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_SAP].LENGTH;

		elseif( string.sub(command, 1, 5) == "scale" ) then
			local scale = tonumber(string.sub(command, 7))
			if( scale <= 3.0 and scale >= 0.25 ) then
				StunWatch_Save[STUNWATCH.PROFILE].scale = scale;
				STUNWATCH.SCALE = scale;
				StunWatch:SetScale(STUNWATCH.SCALE * UIParent:GetScale());
				DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_SCALE..scale);
			else
				StunWatch_Help()
			end

		elseif( string.sub(command, 1, 5) == "width" ) then
			local width = tonumber(string.sub(command, 7))
			if( width <= 300 and width >= 50 ) then
				StunWatch_Save[STUNWATCH.PROFILE].width = width;
				STUNWATCH.WIDTH = width;
				StunWatch_SetWidth(STUNWATCH.WIDTH);
				DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_WIDTH..width);
			else
				StunWatch_Help()
			end

		elseif( string.sub(command, 1, 5) == "alpha" ) then
			local alpha = tonumber(string.sub(command, 7))
			if( alpha <= 1 and alpha >= 0 ) then
				StunWatch_Save[STUNWATCH.PROFILE].alpha = alpha;
				STUNWATCH.ALPHA = alpha;
				DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_ALPHA..alpha);
			else
				StunWatch_Help()
			end

		elseif( command == "print" ) then
			DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_PROFILE_TEXT..STUNWATCH.PROFILE);
			if( STUNWATCH.STATUS == 0 ) then
				DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_DISABLED);
			elseif( STUNWATCH.STATUS == 2 ) then
				DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_UNLOCKED);
			else
				DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_ENABLED);
			end
			if STUNWATCH.INVERT then
				DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_INVERSION_ON);
			else
				DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_INVERSION_OFF);
			end
			if STUNWATCH.GROWTH == 0 then
				DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_GROW_OFF);
			elseif STUNWATCH.GROWTH == 1 then
				DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_GROW_UP);
			else
				DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_GROW_DOWN);
			end
			DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_GOUGE_RANK..": "..((STUNWATCH.STUNS[STUNWATCH_GOUGE].LENGTH - 4) * 2));
			DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_KS_RANK..": "..(STUNWATCH.STUNS[STUNWATCH_KS].LENGTH + 1));
			DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_SAP_RANK..": "..((STUNWATCH.STUNS[STUNWATCH_SAP].LENGTH - 15)/10));

			DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_SCALE..STUNWATCH.SCALE);
			DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_WIDTH..STUNWATCH.WIDTH);
			DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_ALPHA..STUNWATCH.ALPHA);
		else
			StunWatch_Help();
		end
	end
end

function StunWatch_OnEvent(event)
	if( STUNWATCH.STATUS == 0 ) then
		return
	end

	StunWatch_EventHandler[event](arg1, arg2, arg3, arg4, arg5);
end

StunWatch_EventHandler = {}

StunWatch_EventHandler["UNIT_AURA"] = function()
	if( arg1 == "target" ) then
		STUNWATCH.UNIT_AURA.TARGET = UnitName("target");
		STUNWATCH.UNIT_AURA.TIME = GetTime();

		-- get rid of any old events so they don't clutter the queue
		while table.getn(STUNWATCH.EFFECT) > 0 and (STUNWATCH.UNIT_AURA.TIME - STUNWATCH.EFFECT[1].TIME) > STUNWATCH.THRESHOLD do
			StunWatch_UnqueueEvent();
		end

		if table.getn(STUNWATCH.EFFECT) > 0 then
			StunWatch_EffectHandler[STUNWATCH.EFFECT[1].STATUS]();
		end
	end
end

function StunWatch_QueueEvent(effect, mobname, time, status)
	local effect_structure = {}
	effect_structure.TYPE = effect;
	effect_structure.TARGET = mobname;
	effect_structure.TIME = time;
	effect_structure.STATUS = status
	table.insert( STUNWATCH.EFFECT, effect_structure )
end

function StunWatch_UnqueueEvent()
	table.remove( STUNWATCH.EFFECT, 1)
end

StunWatch_EventHandler["CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE"] = function()
	for mobname, effect in string.gfind( arg1, STUNWATCH_TEXT_ON ) do
		if( UnitName("target") == mobname ) then
			if STUNWATCH.STUNS[effect] then
				StunWatch_QueueEvent(effect, mobname, GetTime(), 1)

				StunWatch_EffectHandler[1]();
			end
		end
	end
end

StunWatch_EventHandler["CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE"] = StunWatch_EventHandler["CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE"];

StunWatch_EventHandler["CHAT_MSG_SPELL_AURA_GONE_OTHER"] = function()
	for mobname, effect in string.gfind( arg1, STUNWATCH_TEXT_OFF ) do
		if( STUNWATCH.STUNS[effect] ) then
			if( STUNWATCH.STUNS[effect].TARGET == mobname ) then
			StunWatch_QueueEvent(effect, mobname, GetTime(), 2)

			StunWatch_EffectHandler[2]();
			end
		end
	end
end

StunWatch_EventHandler["CHAT_MSG_SPELL_BREAK_AURA"] = function()
	for mobname, effect in string.gfind( arg1, STUNWATCH_TEXT_BREAK ) do
		if( STUNWATCH.STUNS[effect] ) then
			if( STUNWATCH.STUNS[effect].TARGET == mobname ) then
			StunWatch_QueueEvent(effect, mobname, GetTime(), 3)

			StunWatch_EffectHandler[3]();
			end
		end
	end

end

StunWatch_EventHandler["UNIT_COMBAT"] = function()
	if( GetComboPoints() > 0 ) then
		STUNWATCH.COMBO = GetComboPoints();
	end
end

StunWatch_EffectHandler = {}

StunWatch_EffectHandler[0] = function()
-- no effect
end

StunWatch_EffectHandler[1] = function()
-- applied
	if( math.abs( STUNWATCH.UNIT_AURA.TIME - STUNWATCH.EFFECT[1].TIME ) < STUNWATCH.THRESHOLD ) then
		local effect = STUNWATCH.EFFECT[1].TYPE
		local mobname = STUNWATCH.EFFECT[1].TARGET

		if( GetTime() > ( STUNWATCH.STUNS[effect].TIMER_END + 15 ) or mobname ~= STUNWATCH.STUNS[effect].TARGET ) then
			STUNWATCH.STUNS[effect].DIMINISH = 1;
		end

		STUNWATCH.STUNS[effect].TARGET = mobname;
		STUNWATCH.STUNS[effect].PLAYER = UnitIsPlayer("target");
		STUNWATCH.STUNS[effect].TIMER_START = GetTime();
		if( STUNWATCH.STUNS[effect].PVPCC and STUNWATCH.STUNS[effect].PLAYER ) then
			STUNWATCH.STUNS[effect].TIMER_END = STUNWATCH.STUNS[effect].TIMER_START + (STUNWATCH.STUNS[effect].PVPCC / STUNWATCH.STUNS[effect].DIMINISH);
		else
			STUNWATCH.STUNS[effect].TIMER_END = STUNWATCH.STUNS[effect].TIMER_START + (STUNWATCH.STUNS[effect].LENGTH / STUNWATCH.STUNS[effect].DIMINISH);
		end
		if( STUNWATCH.STUNS[effect].COMBO ) then
			STUNWATCH.STUNS[effect].TIMER_END = STUNWATCH.STUNS[effect].TIMER_END + STUNWATCH.COMBO
		end

		StunWatch_AddEffect(effect);

		StunWatch_UnqueueEvent();
	end
end

StunWatch_EffectHandler[2] = function()
-- faded
	if( STUNWATCH.STUNS[STUNWATCH.EFFECT[1].TYPE].TARGET == STUNWATCH.EFFECT[1].TARGET ) then
	-- target and stun target names match, wait for UNIT_AURA to ensure target match
		if( math.abs( STUNWATCH.UNIT_AURA.TIME - STUNWATCH.EFFECT[1].TIME ) < STUNWATCH.THRESHOLD ) then
			STUNWATCH.STUNS[STUNWATCH.EFFECT[1].TYPE].TIMER_END = GetTime();
			StunWatch_RemoveEffect(STUNWATCH.EFFECT[1].TYPE);
			StunWatch_UnqueueEvent();
	-- unless the debuff is gone from the target, then no need for UNIT_AURA to confirm it
		elseif StunWatch_EffectGone(STUNWATCH.EFFECT[1].TYPE) then
			STUNWATCH.STUNS[STUNWATCH.EFFECT[1].TYPE].TIMER_END = GetTime()
			StunWatch_RemoveEffect(STUNWATCH.EFFECT[1].TYPE);
			StunWatch_UnqueueEvent();
		end
	else
	-- target and stun target names don't match, retargetting has occured, no need to wait for UNIT_AuRA
		STUNWATCH.STUNS[STUNWATCH.EFFECT[1].TYPE].TIMER_END = GetTime();

		StunWatch_RemoveEffect(STUNWATCH.EFFECT[1].TYPE);
		StunWatch_UnqueueEvent();
	end
end

StunWatch_EffectHandler[3] = function()
-- broken
	if( STUNWATCH.STUNS[STUNWATCH.EFFECT[1].TYPE].TARGET == STUNWATCH.EFFECT[1].TARGET ) then
	-- target and stun target names match, wait for UNIT_AURA to ensure target match
		if( math.abs( STUNWATCH.UNIT_AURA.TIME - STUNWATCH.EFFECT[1].TIME ) < STUNWATCH.THRESHOLD ) then
			STUNWATCH.STUNS[STUNWATCH.EFFECT[1].TYPE].TIMER_END = GetTime();
			StunWatch_RemoveEffect(STUNWATCH.EFFECT[1].TYPE);
			StunWatch_UnqueueEvent();
	-- unless the debuff is gone from the target, then no need for UNIT_AURA to confirm it
		elseif StunWatch_EffectGone(STUNWATCH.EFFECT[1].TYPE) then
			STUNWATCH.STUNS[STUNWATCH.EFFECT[1].TYPE].TIMER_END = GetTime()
			StunWatch_RemoveEffect(STUNWATCH.EFFECT[1].TYPE);
			StunWatch_UnqueueEvent();
		end
	else
	-- target and stun target names don't match, retargetting has occured, no need to wait for UNIT_AuRA
		STUNWATCH.STUNS[STUNWATCH.EFFECT[1].TYPE].TIMER_END = GetTime();

		StunWatch_RemoveEffect(STUNWATCH.EFFECT[1].TYPE);
		StunWatch_UnqueueEvent();
	end
end

function StunWatch_EffectGone(effect)
	local i;
	local effectgone = false; -- assume effect is gone unless we find it
	for i = 1,8 do
		if UnitDebuff("target", i) == STUNWATCH.STUNS[effect].TEXTURE then
			effectgone = true
		end
	end
	return effectgone;
end

function StunWatch_AddEffect(effect)
	-- first remove any old copies of this effect, to avoid nasty overlap and properly set diminishing returns for multi-stun
	local group = STUNWATCH.STUNS[effect].group
	StunWatch_RemoveEffect(effect)

	if STUNWATCH.GROWTH == 1 then
		group = 1
		-- start at the bottom and find the first available bar, otherwise queue to #5
		while group < 5 and table.getn(STUNWATCH.GROUPS[group].EFFECT) > 0 do
			group = group + 1
		end
		STUNWATCH.STUNS[effect].GROUP = group
	elseif STUNWATCH.GROWTH == 2 then
		group = 5
		-- start at the top and find the first available bar, otherwise queue to #1
		while group > 1 and table.getn(STUNWATCH.GROUPS[group].EFFECT) > 0 do
			group = group - 1
		end
		STUNWATCH.STUNS[effect].GROUP = group
	end

	-- new effect goes at the head of the queue... always displaying newest effect
	StunWatch_QueueEffect(effect)
end

function StunWatch_RemoveEffect(effect)
	local group = STUNWATCH.STUNS[effect].GROUP;

	StunWatch_UnqueueEffect(effect);

	if STUNWATCH.GROWTH == 1 then
		while group < 5 and table.getn(STUNWATCH.GROUPS[group].EFFECT) == 0 and table.getn(STUNWATCH.GROUPS[group+1].EFFECT) > 0 do
			local move_effect = STUNWATCH.GROUPS[group+1].EFFECT[1];
			StunWatch_UnqueueEffect(move_effect);
			STUNWATCH.STUNS[move_effect].GROUP = group
			StunWatch_QueueEffect(move_effect);
			group = group + 1
		end
	elseif STUNWATCH.GROWTH == 2 then
		while group > 1 and table.getn(STUNWATCH.GROUPS[group].EFFECT) == 0 and table.getn(STUNWATCH.GROUPS[group-1].EFFECT) > 0 do
			local move_effect = STUNWATCH.GROUPS[group-1].EFFECT[1];
			StunWatch_UnqueueEffect(move_effect);
			STUNWATCH.STUNS[move_effect].GROUP = group
			StunWatch_QueueEffect(move_effect);
			group = group - 1
		end
	end

	-- set diminishing returns based on STUNS[effect].DIMINISHES (documented in StunWatch_Config.lua)
	if( (STUNWATCH.STUNS[effect].PLAYER and STUNWATCH.STUNS[effect].DIMINISHES > 0) or STUNWATCH.STUNS[effect].DIMINISHES == 1 ) then
		STUNWATCH.STUNS[effect].DIMINISH = 2 * STUNWATCH.STUNS[effect].DIMINISH;
	end
end

function StunWatch_QueueEffect(effect)
	local group = STUNWATCH.STUNS[effect].GROUP;

	table.insert( STUNWATCH.GROUPS[group].EFFECT, 1, effect )

	local activebarText = getglobal("StunWatchBar"..group.."Text");
	activebarText:SetText(effect..": "..STUNWATCH.STUNS[effect].TARGET);

	-- if queue was empty show bar
	if( table.getn(STUNWATCH.GROUPS[group].EFFECT) == 1 ) then
		local activebar = getglobal("StunWatchBar"..group);
		activebar:Show();
	end
end

function StunWatch_UnqueueEffect(effect)
	local group = STUNWATCH.STUNS[effect].GROUP;

	local i = 0;
	-- find the effect in the queue, if it's not there index stays 0
	table.foreach( STUNWATCH.GROUPS[group].EFFECT, function(k,v) if( v == effect ) then i = k end end );
	if( i ~= 0 ) then
		table.remove( STUNWATCH.GROUPS[group].EFFECT, i );
	end

	-- if queue isn't empty set new name
	if( table.getn(STUNWATCH.GROUPS[group].EFFECT) > 0 ) then
		local activebarText = getglobal("StunWatchBar"..group.."Text");
		local effect = STUNWATCH.GROUPS[group].EFFECT[1];
		activebarText:SetText(effect..": "..STUNWATCH.STUNS[effect].TARGET);
	else
		local activebarText = getglobal("StunWatchBar"..group.."Text");
		activebarText:SetText("StunWatch Bar "..group);
	end
end

function StunWatchBar_OnShow(group)
	StunWatch:SetScale(STUNWATCH.SCALE * UIParent:GetScale());

	local status = GetTime();

	local activebar = getglobal("StunWatchBar"..group);
	activebar:SetBackdropColor(0, 0, 0, 0.35);

	if( table.getn(STUNWATCH.GROUPS[group].EFFECT) == 0 ) then
		local activebarText = getglobal("StunWatchBar"..group.."Text");
		activebarText:SetText("StunWatch Bar "..group);
	end

	activebar:SetAlpha(STUNWATCH.ALPHA);
	local activebarStatusBar = getglobal("StunWatchBar"..group.."StatusBar");
	activebarStatusBar:SetStatusBarColor(1, 1, 0);
	local activebarSpark = getglobal("StunWatchBar"..group.."StatusBarSpark");
	activebarSpark:SetPoint("CENTER", "StunWatchBar"..group.."StatusBar", "LEFT", 0, 0);

end

function StunWatchBar1_OnShow() StunWatchBar_OnShow(1) end
function StunWatchBar2_OnShow() StunWatchBar_OnShow(2) end
function StunWatchBar3_OnShow() StunWatchBar_OnShow(3) end
function StunWatchBar4_OnShow() StunWatchBar_OnShow(4) end
function StunWatchBar5_OnShow() StunWatchBar_OnShow(5) end

function StunWatch_OnUpdate()
	if( STUNWATCH.STATUS == 0 ) then
		return
	end

	local status = GetTime();
	table.foreach( STUNWATCH.GROUPS, StunWatch_GroupUpdate );
end

function StunWatch_GroupUpdate(group)
	local activebar = getglobal("StunWatchBar"..group)

	if( table.getn(STUNWATCH.GROUPS[group].EFFECT) > 0 ) then
	-- active effect on this bar
		activebar:SetAlpha(STUNWATCH.ALPHA);

		local status = GetTime();
		local effect = STUNWATCH.GROUPS[group].EFFECT[1]
		local activebarStatusBar = getglobal("StunWatchBar"..group.."StatusBar");

		if( status <= STUNWATCH.STUNS[effect].TIMER_END  ) then
		-- stun hasn't expired
			activebarStatusBar:SetMinMaxValues(STUNWATCH.STUNS[effect].TIMER_START, STUNWATCH.STUNS[effect].TIMER_END);
			local sparkPosition = ((status - STUNWATCH.STUNS[effect].TIMER_START) / (STUNWATCH.STUNS[effect].TIMER_END - STUNWATCH.STUNS[effect].TIMER_START)) * STUNWATCH.WIDTH;
			if( STUNWATCH.INVERT ) then
				sparkPosition = STUNWATCH.WIDTH - sparkPosition;
				activebarStatusBar:SetValue(STUNWATCH.STUNS[effect].TIMER_START + STUNWATCH.STUNS[effect].TIMER_END - status);
			else
				activebarStatusBar:SetValue(status);
			end
			if( sparkPosition < 1 ) then
				sparkPosition = 1;
			end
			local activebarSpark = getglobal("StunWatchBar"..group.."StatusBarSpark");
			activebarSpark:SetPoint("CENTER", "StunWatchBar"..group.."StatusBar", "LEFT", sparkPosition, 0);
		else
		-- stun has expired
			StunWatch_RemoveEffect(effect)
		end

	elseif( activebar:GetAlpha() > 0 ) then
	-- otherwise fade out this bar if not unlocked
		if( STUNWATCH.STATUS == 1 ) then
			local activebarText = getglobal("StunWatchBar"..group.."Text");
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


function StunWatch_LoadVariables(arg1)
	if STUNWATCH.VARIABLES_LOADED then
		return
	end

	STUNWATCH.VARIABLE_TIMER = STUNWATCH.VARIABLE_TIMER + arg1;
	if STUNWATCH.VARIABLE_TIMER < 0.2 then
		return
	end
	STUNWATCH.VARIABLE_TIMER = 0;

	STUNWATCH.PROFILE = UnitName("player").." of "..GetCVar("RealmName");

	if StunWatch_Save[STUNWATCH.PROFILE] == nil then
		StunWatch_Save[STUNWATCH.PROFILE] = {}
	end

	if StunWatch_Save[STUNWATCH.PROFILE].stuns == nil then
		StunWatch_Save[STUNWATCH.PROFILE].stuns = STUNWATCH.STUNS
	end

	-- bug fix for 2.0/2.1
	StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_BLIND].LENGTH = 10

	if StunWatch_Save[STUNWATCH.PROFILE].status == nil then
		StunWatch_Save[STUNWATCH.PROFILE].status = STUNWATCH.STATUS
	end

	if StunWatch_Save[STUNWATCH.PROFILE].invert == nil then
		StunWatch_Save[STUNWATCH.PROFILE].invert = false
	end

	if StunWatch_Save[STUNWATCH.PROFILE].growth == nil then
		StunWatch_Save[STUNWATCH.PROFILE].growth = 0
	end

	if StunWatch_Save[STUNWATCH.PROFILE].scale == nil then
		StunWatch_Save[STUNWATCH.PROFILE].scale = 1
	end

	if StunWatch_Save[STUNWATCH.PROFILE].width == nil then
		StunWatch_Save[STUNWATCH.PROFILE].width = 160
	end

	if StunWatch_Save[STUNWATCH.PROFILE].alpha == nil then
		StunWatch_Save[STUNWATCH.PROFILE].alpha = 1
	end

	StunWatch_UpdateTextures();
	StunWatch_UpdateImpGouge();
	StunWatch_UpdateKidneyShot();
	StunWatch_UpdateSap();

	STUNWATCH.STATUS = StunWatch_Save[STUNWATCH.PROFILE].status
	STUNWATCH.INVERT = StunWatch_Save[STUNWATCH.PROFILE].invert
	STUNWATCH.GROWTH = StunWatch_Save[STUNWATCH.PROFILE].growth
	STUNWATCH.SCALE = StunWatch_Save[STUNWATCH.PROFILE].scale
	STUNWATCH.WIDTH = StunWatch_Save[STUNWATCH.PROFILE].width
	STUNWATCH.ALPHA = StunWatch_Save[STUNWATCH.PROFILE].alpha
	STUNWATCH.STUNS = StunWatch_Save[STUNWATCH.PROFILE].stuns

	StunWatch:SetScale(STUNWATCH.SCALE * UIParent:GetScale());
	StunWatch_SetWidth(STUNWATCH.WIDTH);

	if( STUNWATCH.STATUS == 2 ) then
		StunWatch:EnableMouse(1);
	end

	STUNWATCH.VARIABLES_LOADED = true
	StunWatch_Variable_Frame:Hide()
end

function StunWatch_UpdateTextures()
	local i = 1
	while true do
		local name, rank = GetSpellName(i, BOOKTYPE_SPELL)
		if not name then return end
		if StunWatch_Save[STUNWATCH.PROFILE].stuns[name] then
			StunWatch_Save[STUNWATCH.PROFILE].stuns[name].TEXTURE = GetSpellTexture(i, BOOKTYPE_SPELL)
		end
		i = i + 1
	end
end

function StunWatch_UpdateImpGouge()
	local _, texture, _, _, rank, _, _, _ = GetTalentInfo( 2, 1 );
	if texture then
		StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_GOUGE].LENGTH = 4 + rank*0.5;
	elseif StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_GOUGE].LENGTH == nil then
		StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_GOUGE].LENGTH = 4;
	end
end

function StunWatch_UpdateKidneyShot()
	local i = 1
	while true do
		local name, rank = GetSpellName(i, BOOKTYPE_SPELL)
		if not name then
			if( StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_KS].LENGTH == nil ) then
				StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_KS].LENGTH = 1;
			end
			return
		end

		if( name == STUNWATCH_KS ) then
			if( string.sub(rank,string.len(rank)) == "1" ) then
				StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_KS].LENGTH = 0;
			else
				StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_KS].LENGTH = 1;
			end
			return
		end

		i = i + 1
	end
end

function StunWatch_UpdateSap()
	local i = 1
	while true do
		local name, rank = GetSpellName(i, BOOKTYPE_SPELL)
		if not name then
			if( StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_SAP].LENGTH == nil ) then
				StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_SAP].LENGTH = 45;
			end
			return
		end

		if( name == STUNWATCH_SAP ) then
			if( string.sub(rank,string.len(rank)) == "1") then
				StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_SAP].LENGTH = 25;
			elseif( string.sub(rank,string.len(rank)) == "2") then
				StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_SAP].LENGTH = 35;
			else
				StunWatch_Save[STUNWATCH.PROFILE].stuns[STUNWATCH_SAP].LENGTH = 45;
			end
			return
		end

		i = i + 1
	end
end

function StunWatch_Help()
	DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_VERSION..STUNWATCH_HELP1);
	DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_HELP2);
	DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_HELP3);
	DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_HELP4);
	DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_HELP5);
	DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_HELP6);
	DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_HELP7);
	DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_HELP8);
	DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_HELP9);
	DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_HELP10);
	DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_HELP11);
	DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_HELP12);
	DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_HELP13);
	DEFAULT_CHAT_FRAME:AddMessage(STUNWATCH_HELP14);
end

function StunWatch_SetWidth(width)
	StunWatchBar1:SetWidth(width + 10);
	StunWatchBar1Text:SetWidth(width);
	StunWatchBar1StatusBar:SetWidth(width);
	StunWatchBar2:SetWidth(width + 10);
	StunWatchBar2Text:SetWidth(width);
	StunWatchBar2StatusBar:SetWidth(width);
	StunWatchBar3:SetWidth(width + 10);
	StunWatchBar3Text:SetWidth(width);
	StunWatchBar3StatusBar:SetWidth(width);
	StunWatchBar4:SetWidth(width + 10);
	StunWatchBar4Text:SetWidth(width);
	StunWatchBar4StatusBar:SetWidth(width);
	StunWatchBar5:SetWidth(width + 10);
	StunWatchBar5Text:SetWidth(width);
	StunWatchBar5StatusBar:SetWidth(width);
	StunWatch:SetWidth(width + 10);
end