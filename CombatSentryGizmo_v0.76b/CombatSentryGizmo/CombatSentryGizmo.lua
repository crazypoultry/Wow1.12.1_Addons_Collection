--[[

	Combat Sentry Gizmo: ---------
		copyright 2005 by Chester

]]--

------------------------------------------------------------------

CSG_MAXATTACKFRAMES = 30;
--CSG_MAXVISIBLEFRAMES = 10;
CSG_MAXTARGETHOPS = 3;
--CSG_FRAMEVISIBLE_TIME = 20;
CSG_CLEANUP_TIME = 3;
CSG_MAINFLASHIN_TIME = 0.4;
CSG_MAINFLASHOUT_TIME = 0.8;
CSG_HEALTHMANA_STAY_TIME = 2;
CSG_HEALTHMANA_FADE_TIME = 5;
CSG_NONATTACKER_SCALE = 0.7;

AttackerList = {};
CSG_CurList = 0;
CSG_CurDamagers = 0;

if (not CSG) then
	CSG = {
	["gathering"] = 0,
	["party"] = {},
	};
end

CSG[CSG_DRUID]		= { i1 = 0.7421875, i2 = 0.98828125, i3 = 0, i4 = 0.25,		r = 0.9, g = 0.55, b = 0.1 };
CSG[CSG_HUNTER]		= { i1 = 0, i2 = 0.25, i3 = 0.25, i4 = 0.5,			r = 0.1, g = 0.85, b = 0.1 };
CSG[CSG_MAGE]		= { i1 = 0.25, i2 = 0.49609375, i3 = 0, i4 = 0.25,		r = 0.5, g = 1, b = 1 };
CSG[CSG_PRIEST]		= { i1 = 0.49609375, i2 = 0.7421875, i3 = 0.25, i4 = 0.5,	r = 0.8, g = 0.8, b = 0.8 };
CSG[CSG_ROGUE]		= { i1 = 0.49609375, i2 = 0.7421875, i3 = 0, i4 = 0.25,		r = 0.95, g = 0.9, b = 0.1 };
CSG[CSG_WARLOCK]	= { i1 = 0.7421875, i2 = 0.98828125, i3 = 0.25, i4 = 0.5,	r = 0.5, g = 0.26, b = 0.9 };
CSG[CSG_WARRIOR]	= { i1 = 0, i2 = 0.25, i3 = 0, i4 = 0.25,			r = 0.7, g = 0.5, b = 0.25 };
CSG[CSG_PALADIN]	= { i1 = 0, i2 = 0.25, i3 = 0.5, i4 = 0.75,			r = 1, g = 0.4, b = 0.58 };
CSG[CSG_SHAMAN]		= { i1 = 0.25, i2 = 0.49609375, i3 = 0.25, i4 = 0.5,		r = 0.9, g = 0.4, b = 0.65 };
CSG[CSG_UNKNOWN]	= { i1 = 0, i2 = 1, i3 = 0, i4 = 1,				r = 1, g = 1, b = 1 };

CSG_OptionsFrame_Sliders = {
	{ text = CSG_MENU_SCALE, var = "scale", minValue = 0.5, maxValue = 1.5, valueStep = 0.1, tooltipText = CSG_MENU_SCALE_TOOLTIP},
	{ text = CSG_MENU_MAX_F, var = "max_f", minValue = 1, maxValue = 20, valueStep = 1, tooltipText = CSG_MENU_MAX_F_TOOLTIP},
	{ text = CSG_MENU_MAX_NA, var = "max_na", minValue = 1, maxValue = 10, valueStep = 1, tooltipText = CSG_MENU_MAX_NA_TOOLTIP},
	{ text = CSG_MENU_MAX_A, var = "max_a", minValue = 1, maxValue = 10, valueStep = 1, tooltipText = CSG_MENU_MAX_A_TOOLTIP},
	{ text = CSG_MENU_TIMEOUT_NA, var = "time_na", minValue = 5, maxValue = 60, valueStep = 1, tooltipText = CSG_MENU_TIMEOUT_NA_TOOLTIP},
	{ text = CSG_MENU_TIMEOUT_A, var = "time_a", minValue = 5, maxValue = 60, valueStep = 1, tooltipText = CSG_MENU_TIMEOUT_A_TOOLTIP},
	{ text = CSG_MENU_TIMEOUT_H, var = "time_h", minValue = 5, maxValue = 60, valueStep = 1, tooltipText = CSG_MENU_TIMEOUT_H_TOOLTIP},
};

CSG_OptionsFrame_CheckButtons = { 
	{ frame = "CSG_OptionsFrame_CheckButton1", text = CSG_MENU_SOUNDS_ALL, var = "sound_all", tooltipText = CSG_MENU_SOUNDS_ALL_TOOLTIP },
};

function CSG_AddMessage( text )
	if (CSGiz.debug) then
		if (text) then
			ChatFrame3:AddMessage(GREEN_FONT_COLOR_CODE..""..text.."");	
		end	
	end
end

function tablecopy( t, lookup_table )
	local copy = {};
	for i,v in t do
		if ( type(v) ~= "table" ) then
			copy[i] = v;
		else
			lookup_table = lookup_table or {};
			lookup_table[t] = copy;
			if ( lookup_table[v] ) then
				copy[i] = lookup_table[v];
			else
				copy[i] = tablecopy(v,lookup_table);
			end
		end
	end

	return copy;
end

function CSG_GetEffectiveScale(frame)
    return frame:GetEffectiveScale()
end

function CSG_SetEffectiveScale(frame, scale, parentframe)
    frame.scale = scale;  -- Saved in case it needs to be re-calculated when the parent's scale changes.
    local parent = getglobal(parentframe);
    if ( parent ) then
        scale = scale / GetEffectiveScale(parent);
    end
    frame:SetScale(scale);
end

--HIGHLIGHT_FONT_COLOR_CODE = "|cffffffff";
--RED_FONT_COLOR_CODE = "|cffff2020";
--NORMAL_FONT_COLOR_CODE = "|cffffd200";

function CSG_OnLoad()

	-- Register events
	this:RegisterForDrag("LeftButton");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTER_COMBAT");
	this:RegisterEvent("PLAYER_LEAVE_COMBAT");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");

	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES");
	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS");

	--this:RegisterEvent("CHAT_MSG_COMBAT_PET_MISSES");
	--this:RegisterEvent("CHAT_MSG_COMBAT_PET_HITS");
	--this:RegisterEvent("CHAT_MSG_SPELL_PET_DAMAGE");

	this:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN");

	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF");
	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS");
	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_PARTY_MISSES");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE");

	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");

	this:RegisterEvent("SPELLCAST_CHANNEL_START");
	this:RegisterEvent("SPELLCAST_START");
	this:RegisterEvent("SPELLCAST_FAILED");

	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF");
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS");
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES");
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");

	--debugging
	--this:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF");
	--this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS");
	--this:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE");
	--

	this:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");

	SLASH_CSGIZMO1 = "/combatsentrygizmo";
	SLASH_CSGIZMO1 = "/csgizmo";
	SLASH_CSGIZMO2 = "/csg";
	SlashCmdList["CSGIZMO"] = function(msg)
		CSG_SlashCommand(msg);
	end
end

function CSG_OnEvent()
--DEFAULT_CHAT_FRAME:AddMessage(event..", "..arg1);

	if( event == "VARIABLES_LOADED" ) then
		DEFAULT_CHAT_FRAME:AddMessage(CSG_TEXT_WELCOME);
		
		if (not CSGiz) then
			CSGiz = {
				["on"] = 1,
				["creatures"] = 1,
				["detect"] = 1,
				["anchor"] = 0,
				["infotarget"] = 1,
				};
		end
		if (not CSGiz.on) then
			CSGiz.on = 1;	
		end
		if (not CSGiz.creatures) then
			CSGiz.creatures = 0;	
		end
		if (not CSGiz.detect) then
			CSGiz.detect = 1;	
		end
		if (not CSGiz.anchor) then
			CSGiz.anchor = 0;	
		end
		if (not CSGiz.infotarget) then
			CSGiz.infotarget = 0;	
		end
		if (not CSGiz.max_f) then
			CSGiz.max_f = 10;
			CSGiz.max_na = 10;	
			CSGiz.max_a = 10;
			CSGiz.time_na = 20;
			CSGiz.time_a = 20;
			CSGiz.time_h = 20;
		end
		if (not CSGiz.sound_all) then
			CSGiz.sound_all = 1;	
		end
		if (not CSG.gathering) then
			CSG.gathering = 0;
		end
		if (not CSG.party) then
			CSG.party = {};
		end
		if (not CSG.partypet) then
			CSG.partypet = {};
		end
		if (CSGiz.framepos_Op_L or CSGiz.framepos_Op_T) then
			CSG_OptionsBarParent:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", CSGiz.framepos_Op_L, CSGiz.framepos_Op_T);
		end
		if (CSGiz.framepos_L or CSGiz.framepos_T) then
			CSG_Parent_Frame:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", CSGiz.framepos_L, CSGiz.framepos_T);
		end
		if (CSGiz.scale) then
			CSG_SetEffectiveScale(CSG_Main_Frame, CSGiz.scale, UIParent);
		else
			CSGiz.scale = 1;
		end
		CSG_OptionsBar_UpdateCheckboxes();

--[[		if (CSGiz.debug) then
			DEFAULT_CHAT_FRAME:AddMessage(GREEN_FONT_COLOR_CODE.."CSG Debug mode: ON");
			
			this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE");
			this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS");
			this:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE");
			this:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF");
			
			this:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS");
			this:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF");
		end
		return;]]
	end
	
	if (not CSGiz.on or CSGiz.on == 0) then
		return;	
	end	
	
	CSG_Parse(event, arg1);	
	if( event == "PLAYER_ENTER_COMBAT" ) then
		CSG_AddMessage("|cff3366ffEntering Combat");
		CSGiz.inCombat = 1;
		if (UnitAffectingCombat("target") and CSGiz.inCombat ~= 1) then
			CSG_CaptureAttack(UnitName("target"), "you", 0, nil);
		end
		return;
	elseif( event == "PLAYER_LEAVE_COMBAT" ) then
		CSGiz.inCombat = nil;
		CSG_AddMessage("|cff3366ffLEAVING COMBAT!");
		return;
	elseif( event == "PLAYER_REGEN_DISABLED" and CSGiz.inCombat ~= 1) then
		CSGiz.onHate = 1;
		if (UnitAffectingCombat("target") ) then
			CSG_CaptureAttack(UnitName("target"), "you", 0, nil);
		end
		return;
	elseif( event == "PLAYER_REGEN_ENABLED" ) then
		CSGiz.onHate = nil;
		CSG_AddMessage("|cff3366ffLEAVING COMBAT!");
		return;
	elseif( event == "UPDATE_MOUSEOVER_UNIT" ) then
--		if (UnitIsFriend("mouseover", "player" ) or not UnitIsEnemy( "player", "mouseover" ) or not UnitAffectingCombat("mouseover") or not UnitPlayerControlled("mouseover")) then
		if (UnitAffectingCombat("mouseover") and UnitName("mouseovertarget") == UnitName("player") and UnitIsEnemy( "player", "mouseover" )) then
			--CSG_AddMessage("mouseover is not enemy, ABORTING!");
			CSG_CaptureAttack(UnitName("mouseover"), "you", nil, "mouseover");
			return;
		elseif (UnitIsEnemy( "player", "mouseover" ) and UnitPlayerControlled("mouseover")) then
			CSG_AddMessage("adding enemy player : mouseover");
			CSG_CaptureAttack(UnitName("mouseover"), "you", nil, "mouseover", nil, 1);
			return;
		end
		--UNCOMMENT ME
		--if (CSGiz.infotarget == 1 or CSG_CurList == 0) then
		--	return;
		--else
			--see if the name exists on our list
			--CSG_CaptureAttack(UnitName("mouseover"), "you", nil, "mouseover");
		--end
		return;
	elseif( event == "PLAYER_TARGET_CHANGED" ) then
		if (CSG.gathering == 1) then
			CSG_AddMessage("PLAYER_TARGET_CHANGED: Returning due to gathering");
			return;
		else
			CSG.curtarget = UnitName("target");
			if (CSG.curtarget) then
				CSG_AddMessage("PLAYER_TARGET_CHANGED: "..CSG.curtarget);
			else
				CSG_AddMessage("PLAYER_TARGET_CHANGED: (no target)");
			end
		end
--		if (UnitIsFriend("target", "player" ) or not UnitIsEnemy( "player", "target" ) or not UnitAffectingCombat("target") or not UnitPlayerControlled("mouseover")) then
		if (UnitAffectingCombat("target") and UnitName("targettarget") == UnitName("player") and UnitIsEnemy( "player", "target" )) then
			--CSG_AddMessage("target is not enemy, ABORTING!");

			CSG_CaptureAttack(UnitName("target"), "you", nil, "target");	
			return;
		elseif (UnitIsEnemy( "player", "target" ) and UnitPlayerControlled("target")) then
			CSG_AddMessage("adding enemy player : target");
			CSG_CaptureAttack(UnitName("target"), "you", nil, "target");
			return;
		end
		--UNCOMMENT ME
		--if (CSGiz.infotarget == 1 or CSG_CurList == 0) then
		--	return;
		--else
			--see if the name exists on our list
			--local unitName = UnitName("target");
			--CSG_CaptureAttack(UnitName("target"), "you", nil, nil);			
		--end
		return;
	end
end

function CSG_SlashCommand(msg)
	if( not msg or msg == "" ) then
		CSG_OptionsBarSml:Show();
		DEFAULT_CHAT_FRAME:AddMessage(CSG_TEXT_SLASHCOMMAND);	
	end
	if( msg == "menu" ) then
		CSG_ToggleOptionsFrame();
	end
	if( msg == "detect" ) then
		CSG_DetectEnemies_Toggle();
	end
	if( msg == "creatures" ) then
		CSG_ShowCreatures_Toggle();
	end
	if( msg == "off" ) then
		CSG_Disable();
	end
	if( msg == "on" ) then
		CSG_Enable();
	end
	if( msg == "infotarget" ) then
		CSG_InfoTarget_Toggle();
	end
	if( msg == "toggle" ) then
		CSG_EnableDisable_Toggle();
	end
	if( msg == "resetpanel" ) then
		CSG_ResetControlPanel_1();
	end
	if( msg == "resetpanel2" ) then
		CSG_ResetControlPanel_2();
	end
	if (string.find(msg, "addtarget") ~= nil) then
		
		--if (damage) then
			--CSG_AddTargetToList(tonumber(j));
		
			for damage in string.gfind(msg, "addtarget%s(%d+)") do
				CSG.d = damage;
				--CSG_CaptureAttack(UnitName("target"), targetName, tonumber(damage), "target", 1);
			end
			for targetName in string.gfind(msg, "addtarget%s%d+%s(.+)") do
				CSG.t = targetName;
				--CSG_CaptureAttack(UnitName("target"), targetName, tonumber(damage), "target", 1);
			end
			if (not CSG.t) then
				CSG.t = "you";	
			end
			CSG_CaptureAttack(UnitName("target"), CSG.t, tonumber(CSG.d), "target", 1);
		--end
		return;
--/script CSG_Main_Frame:SetScale(UIParent:GetScale() * 0.75);
	end
	if (string.find(msg, "scale") ~= nil) then
		--local i, s = string.find(msg, "%d+");
		for scale in string.gfind(msg, "scale%s(%d.*)") do
			CSG.s = tonumber(scale);
		end
		if (CSG.s) then
			if (CSG.s > 2) then
				CSG.s = 2;
			elseif (CSG.s < 0.25) then
				CSG.s = 0.25;
			end
			CSG_SetEffectiveScale(CSG_Main_Frame, CSG.s, UIParent);
			CSGiz.scale = (CSG.s);
		else
			DEFAULT_CHAT_FRAME:AddMessage(CSG_TITLE_CHAT.."Please type a scale number after 'scale' (valid numbers: 0.25-2)");
		end
		return;
--/script CSG_Main_Frame:SetScale(UIParent:GetScale() * 0.75);
	end
end

function CSG_DetectEnemies_Toggle()
	if ( CSGiz.detect == 1 ) then
		CSGiz.detect = 0;
		CSG_Button_Detect:SetChecked( 1 );
		DEFAULT_CHAT_FRAME:AddMessage(CSG_TEXT_ENEMYDETECTION_OFF);
	else
		CSGiz.detect = 1;
		CSG_Button_Detect:SetChecked( 0 );
		DEFAULT_CHAT_FRAME:AddMessage(CSG_TEXT_ENEMYDETECTION_ON);
	end
end

function CSG_ShowCreatures_Toggle()
	if ( CSGiz.creatures == 1 ) then
		CSGiz.creatures = 0;
		CSG_Button_Creatures:SetChecked( 1 );
		DEFAULT_CHAT_FRAME:AddMessage(CSG_TEXT_CREATURES_OFF);
	else
		CSGiz.creatures = 1;
		CSG_Button_Creatures:SetChecked( 0 );
		DEFAULT_CHAT_FRAME:AddMessage(CSG_TEXT_CREATURES_ON);
	end
end

function CSG_Enable()
	CSGiz.on = 1;
	CSG_Button_On:SetChecked( 0 );
	DEFAULT_CHAT_FRAME:AddMessage(CSG_TEXT_CSG_ON);
end

function CSG_Disable()
	CSGiz.on = 0;
	CSG_Button_On:SetChecked( 1 );
	DEFAULT_CHAT_FRAME:AddMessage(CSG_TEXT_CSG_OFF);
end

function CSG_EnableDisable_Toggle()
	if ( CSGiz.on == 1 ) then
		CSGiz.on = 0;
		CSG_Button_On:SetChecked( 1 );
		DEFAULT_CHAT_FRAME:AddMessage(CSG_TEXT_CSG_OFF);
	else
		CSGiz.on = 1;
		CSG_Button_On:SetChecked( 0 );
		DEFAULT_CHAT_FRAME:AddMessage(CSG_TEXT_CSG_ON);
	end
end

function CSG_InfoTarget_Toggle()
	if ( CSGiz.infotarget == 1 ) then
		CSGiz.infotarget = 0;
		CSG_Button_InfoTarget:SetChecked( 1 );
		DEFAULT_CHAT_FRAME:AddMessage(CSG_TITLE_CHAT.."Auto Targeting Info is now: |cffff2020-OFF-");
	else
		CSGiz.infotarget = 1;
		CSG_Button_InfoTarget:SetChecked( 0 );
		DEFAULT_CHAT_FRAME:AddMessage(CSG_TITLE_CHAT.."Auto Targeting Info is now: |cff20ff20-ON-");
	end
end

--[[ NOT USED 
function CSG_EnableDisable_Anchor()
	if ( CSGiz.anchor == 1 ) then
		CSGiz.anchor = 0;
		CSG_Button_OptionsMenu:SetChecked( 1 );
		DEFAULT_CHAT_FRAME:AddMessage(CSG_TITLE_CHAT.."Always Show Anchor is now: |cffff2020-OFF-");
		CSG_MainFrame_Toggle();
	else
		CSGiz.anchor = 1;
		DEFAULT_CHAT_FRAME:AddMessage(CSG_TITLE_CHAT.."Always Show Anchor is now: |cff20ff20-ON-");
		CSG_Button_OptionsMenu:SetChecked( 0 );
		CSG_Main_Frame:Show();
		CSG_MainFrame_Toggle();
	end
end
]]
-------------------------
---- SAVE FRAME POSITION
-------------------------
-- this function is called when the frame should be dragged around
function CSG_OptionsOnMouseDown(arg1)
	if (arg1 == "LeftButton") then
		CSG_OptionsBarParent:StartMoving();
	end
end

-- this function is called when the frame is stopped being dragged around
function CSG_OptionsOnMouseUp(arg1)

	if (arg1 == "LeftButton") then
		CSG_OptionsBarParent:StopMovingOrSizing();
		
		-- save the position 
		CSGiz.framePos_Op_L = CSG_OptionsBarParent:GetLeft();
		CSGiz.framePos_Op_T = CSG_OptionsBarParent:GetTop();

--		CSG_AddMessage("SAVING FRAME");
	end
end

function CSG_ResetControlPanel_1()
	CSG_OptionsBarParent:Hide();
	CSG_OptionsBarParent:Show();
	CSG_OptionsBarParent:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", 202, 400);

	-- save the position 
	CSGiz.framePos_Op_L = CSG_OptionsBarParent:GetLeft();
	CSGiz.framePos_Op_T = CSG_OptionsBarParent:GetTop();
end

function CSG_ResetControlPanel_2()
	CSG_OptionsBarParent:Hide();
	CSG_OptionsBarParent:Show();
	CSG_OptionsBarParent:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", 400, 600);

	-- save the position 
	CSGiz.framePos_Op_L = CSG_OptionsBarParent:GetLeft();
	CSGiz.framePos_Op_T = CSG_OptionsBarParent:GetTop();
end

-- this function is called when the frame should be dragged around
function CSG_OnMouseDown(arg1)
	if (arg1 == "LeftButton") then
		CSG_AddMessage("MOUSE DOWN");
		CSG_Parent_Frame:StartMoving();
		CSG.mousedown = 1;
	end
end

-- this function is called when the frame is stopped being dragged around
function CSG_OnMouseUp(arg1)
	if (arg1 == "LeftButton") then
		CSG_Parent_Frame:StopMovingOrSizing();
		
		-- save the position 
		CSGiz.framePos_L = CSG_Parent_Frame:GetLeft();
		CSGiz.framePos_T = CSG_Parent_Frame:GetTop();

--		CSG_AddMessage("SAVING FRAME");
		CSG.mousedown = nil;
		CSG_MainFrame_Toggle();
	end
end

CSGDifficultyColor = { };
CSGDifficultyColor["impossible"] = { r = 0.4, g = 0.0, b = 0.0 };
CSGDifficultyColor["verydifficult"] = { r = 0.40, g = 0.18, b = 0.0 };
CSGDifficultyColor["difficult"] = { r = 0.40, g = 0.40, b = 0.00 };
CSGDifficultyColor["standard"] = { r = 0.05, g = 0.3, b = 0.05 };
CSGDifficultyColor["trivial"]	= { r = 0.10, g = 0.10, b = 0.10 };
CSGDifficultyColor["header"]	= { r = 0.7, g = 0.7, b = 0.7 };

function CSG_GetDifficultyColor(level)
	local levelDiff = level - UnitLevel("player");
	if ( levelDiff >= 5 ) then
		color = CSGDifficultyColor["impossible"];
	elseif ( levelDiff >= 3 ) then
		color = CSGDifficultyColor["verydifficult"];
	elseif ( levelDiff >= -2 ) then
		color = CSGDifficultyColor["difficult"];
	elseif ( -levelDiff <= GetQuestGreenRange() ) then
		color = CSGDifficultyColor["standard"];
	else
		color = CSGDifficultyColor["trivial"];
	end
	return color;
end


-------------------------------
function CSG_StartFight()
	if (UnitIsFriend("player", "target") or not UnitAffectingCombat("target")) then
		return;
	else
		CSG_CaptureAttack(UnitName("target"), nil, nil, "target");
	end
end


-------------------------------
---  CaptureAttack
-------------------------------
function CSG_CaptureAttack(unitName, targetName, damage, type, skipcheck, pvp, spell)
	if (spell) then
		CSG_AddMessage(CSG_YLW_TXT..spell);	
	end
	for i=1, GetNumPartyMembers(), 1 do
		CSG.party[i] = UnitName("party"..i);
		CSG.partypet[i] = UnitName("partypet"..i);
	end

	if (targetName and targetName == CSG_L_YOU or targetName == YOU) then
	else
		damage = 0;
	end

	local partyname;
	if (not skipcheck) then
		--checks to make sure this isnt a party member or a friendly ('skipcheck' skips this)
		for i=1, GetNumPartyMembers(), 1 do
			if (unitName == CSG.party[i] or unitName == CSG.partypet[i]) then
				return;
			end
			if (targetName and (targetName == CSG.party[i] or targetName == CSG.partypet[i])) then
				partyname = targetName;
			end
		end
	
		local unit;
		if (not type) then
			unit = "target";
		else
			unit = type;
		end
		if (unitName == UnitName("player") or unitName == UnitName("pet") or unitName == UNKNOWNOBJECT) then
			return;
		elseif (UnitName(unit) == unitName) then
			if (UnitIsFriend(unit, "player") or (not UnitPlayerControlled(unit) and not UnitAffectingCombat(unit))) then
				return;			
			elseif (CSGiz.creatures == 0 and not UnitPlayerControlled(unit)) then
				return;
			end
		end
	end

	if (CSGiz.debug == 1) then
		local dam_debug = damage;
		local targ_debug = targetName;
		if (not targ_debug) then targ_debug = "unknown";	end
		if (not dam_debug) then dam_debug = "0";	end
		--CSG_AddMessage("captured: "..dam_debug.." damage for "..unitName.." against "..targ_debug);
	end
	local found, occupied, slot;
	local num = 0;
	if (CSG_CurList == 0) then
		CSG_ShowNewName(unitName, tonumber(damage), 1, type, partyname, skipcheck, pvp, spell);
	else
		--see if the name exists on our list
		for i=1, CSG_MAXATTACKFRAMES, 1 do
			if (AttackerList[i]) then
				num = num + 1;
				occupied = i;
			--CSG_AddMessage("slot "..i.." occupied by "..AttackerList[i].name);
				if (unitName == AttackerList[i].name) then
					--CSG_AddMessage("slot "..i.." matches attacker name: "..unitName);
					CSG_UpdateAttackerData(unitName, tonumber(damage), i, type, partyname, pvp, spell);
					CSG_UpdateTargetHealthMana( unitName, i, type );
					found = 1;
					break;
				end
			end
			if (num >= CSG_CurList) then
				break;	
			end
	--	CSG_AddMessage(i);
		end
		num = 0;
		if (not found) then
			--if no visible frames or we've hit our max, then insert into the first blank one we find
			if (occupied) then
				if (CSG_CurList == CSGiz.max_f) then
					CSG_MaxFramesReplaceDamager(unitName, targetName, tonumber(damage), type, skipcheck, pvp, spell);
				else
					--name wasn't found, but there are visible frames so insert the new frame after the last visible
					CSG_ShowNewName(unitName, tonumber(damage), (occupied + 1), type, partyname, skipcheck, pvp, spell);
				end

			elseif (occupied == CSG_MAXATTACKFRAMES or occupied == nil) then
				for i=1, CSG_MAXATTACKFRAMES, 1 do
					if (not AttackerList[i]) then
						if (CSG_CurList == CSGiz.max_f) then
							CSG_MaxFramesReplaceDamager(unitName, targetName, tonumber(damage), type, skipcheck, pvp, spell);
						else
							CSG_ShowNewName(unitName, tonumber(damage), i, type, partyname, skipcheck, pvp, spell);
						end
						break;
					end
				end			
			end
		end
	end
end

function CSG_CheckValidAttacker(unitName, targetName, damage, type, skipcheck, pvp)

end

function CSG_CaptureHealer(unitName, targetName, damage)
	if (unitName == UNKNOWNOBJECT or targetName == UNKNOWNOBJECT) then
		return;
	end

	for i=1, CSG_MAXATTACKFRAMES, 1 do
		if (AttackerList[i]) then
			if (targetName == AttackerList[i].name) then
				if (unitName == AttackerList[i].h1) then
					CSG_ShowHealFrame( getglobal("CSG_Attacker"..i.."_Heal_1"), getglobal("CSG_Attacker"..i.."_Heal_1_NameFrame_Icon"), tonumber(damage), i );
					break;
				elseif (unitName == AttackerList[i].h2) then
					CSG_ShowHealFrame( getglobal("CSG_Attacker"..i.."_Heal_2"), getglobal("CSG_Attacker"..i.."_Heal_2_NameFrame_Icon"), tonumber(damage), i );
					break;
				else
					CSG_ShowNewHealer(unitName, i, tonumber(damage));
					break;
				end
			end		
		end
		if (i == CSG_MAXATTACKFRAMES) then
			break;
		end
	end
end

function CSG_MaxFramesReplaceDamager(unitName, targetName, damage, type, skipcheck, pvp, spell)
	if (not damage or damage == 0) then
		return;
	end
	for i=1, CSG_MAXATTACKFRAMES, 1 do
		if (AttackerList[i]) then
		--CSG_AddMessage("slot "..i.." occupied by "..AttackerList[i].name);
			if (AttackerList[i].dam == nil or AttackerList[i].dam == 0) then
				--CSG_AddMessage("slot "..i.." matches attacker name: "..unitName);
				local frame = getglobal("CSG_Attacker"..i);
				frame:Hide();
				CSG_ShowNewName(unitName, tonumber(damage), i, type, partyname, skipcheck, pvp, spell);
				break;
			end
		end
	end
end

-- /script CSG_AddMessage(GetNumFactions());
-- /script CSG_AddMessage(GetFactionInfo(12)); 
-- /script CSG_AddMessage(GetActiveTitle(1)); 
 -- /script CSG_AddMessage(GetAvailableTitle(1)); 

function CSG_ShowNewName(unitName, damage, slot, type, partyname, skipcheck, pvp, spell)
	if (damage and tonumber(damage) > 0) then
		if (CSG_CurDamagers >= CSGiz.max_a) then
			return;				
		end
	elseif ((CSG_CurList - CSG_CurDamagers) >= CSGiz.max_na) then
		return;
	end
	
	if (CSG_CurList == 0) then
		if (CSGiz.sound_all == 1) then
			PlaySoundFile("Sound\\Interface\\TalentScreenOpen.wav");
		end
	else
		if (CSGiz.sound_all == 1) then
			PlaySoundFile("Sound\\Interface\\MouseOverTarget.wav");
		end
	end
	
	AttackerList[slot] = {name = unitName, dam = tonumber(damage)};

	CSG_CurList = CSG_CurList + 1;
	CSG_GetAttackerInfo( unitName, slot, type, partyname, skipcheck, pvp, spell );

	local mFrame = getglobal("CSG_Attacker"..slot);
	local gFrame = getglobal("CSG_Attacker"..slot.."_Glow");
	local nFrame = getglobal("CSG_Attacker"..slot.."_Text_NameText");
	local dFrame = getglobal("CSG_Attacker"..slot.."_DMGText");

	if (not slot or not mFrame or not nFrame) then
		return;
	end
	nFrame:SetText(unitName);
	if (not damage or damage == 0) then
		dFrame:SetText("");
	else
		dFrame:SetText(damage);
	end

	UIFrameFlash(gFrame, 0.2, 2, 2.3, nil, 0.1, 0);

	CSG_ShowFrame( slot, damage, partyname );
end

function CSG_ShowNewHealer(healerName, slot, damage)

	local mFrame1 = getglobal("CSG_Attacker"..slot.."_Heal_1");
	local mFrame2 = getglobal("CSG_Attacker"..slot.."_Heal_2");
	local nFrame1 = getglobal("CSG_Attacker"..slot.."_Heal_1_NameFrameNameText");
	local nFrame2 = getglobal("CSG_Attacker"..slot.."_Heal_2_NameFrameNameText");
	local aFrame1 = getglobal("CSG_Attacker"..slot.."_Heal_1_NameFrame_Icon");
	local aFrame2 = getglobal("CSG_Attacker"..slot.."_Heal_2_NameFrame_Icon");

--Interface\Icons\Spell_Holy_Heal
--Interface\Icons\INV_Enchant_EssenceMysticalLarge

	if (mFrame1:IsVisible()) then
		if (mFrame2:IsVisible()) then
			if (mFrame1.startTime < mFrame2.startTime) then
				AttackerList[slot].h1 = healerName;
				CSG_HideHealFrame( mFrame1 );
				nFrame1:SetText(healerName);
				CSG_ShowHealFrame( mFrame1, aFrame1, damage, slot );
			else
				AttackerList[slot].h2 = healerName;
				CSG_HideHealFrame( mFrame2 );
				nFrame2:SetText(healerName);
				CSG_ShowHealFrame( mFrame2, aFrame2, damage, slot );
			end
		else
			AttackerList[slot].h2 = healerName;
			nFrame2:SetText(healerName);
			CSG_ShowHealFrame( mFrame2, aFrame2, damage, slot );
		end
	else
		AttackerList[slot].h1 = healerName;
		nFrame1:SetText(healerName);
		CSG_ShowHealFrame( mFrame1, aFrame1, damage, slot );
--		CSG_AddMessage(healerName);
	end
	
--	UIFrameFlash(gFrame, 0.2, 2, 2.3, nil, 0.1, 0);
	if (CSGiz.sound_all == 1) then
		PlaySoundFile("Sound\\Interface\\MapPing.wav");
	end
end

function CSG_UpdateAttackerData(unitName, damage, slot, type, partyname, pvp, spell)
	local frame = getglobal("CSG_Attacker"..slot);
	local dFrame = getglobal("CSG_Attacker"..slot.."_DMGText");
	if (unitName == AttackerList[slot].name) then
		--CSG_AddMessage("Updating attacker data for "..unitName);
		if (not AttackerList[slot].dam) then
			AttackerList[slot].dam = 0;	
		end
		if (damage == nil) then
			damage = 0;
		end
		--CSG_AddMessage(".dam = "..AttackerList[slot].dam..", damage = "..damage);
		if (AttackerList[slot].dam == 0 and damage > 0) then
			if (CSG_CurDamagers >= CSGiz.max_a) then
				frame:Hide();
				return;				
			end
		end
		AttackerList[slot].dam = AttackerList[slot].dam + damage;
		dFrame:SetText(AttackerList[slot].dam);		

		CSG_ShowFrame( slot, AttackerList[slot].dam, partyname );

		if (type) then
			CSG_GetAttackerInfo( unitName, slot, type, nil, nil, pvp, spell );
			CSG_AddMessage("type = "..type);
		elseif (CSGiz.infotarget == 1) then
			if (AttackerList[slot] and AttackerList[slot].lvl ~= nil and AttackerList[slot].cls ~= CSG_UNKNOWN) then
				CSG_SetAttackerInfo( unitName, slot, nil, partyname, pvp, spell );
			elseif (type or AttackerList[slot].lvl == nil) then
				CSG_GetAttackerInfo( unitName, slot, type, partyname, nil, pvp, spell );
			end
		else
			CSG_SetAttackerInfo( unitName, slot, nil, nil, pvp, spell );
		end

		local mFrame1 = getglobal("CSG_Attacker"..slot.."_Heal_1");
		local mFrame2 = getglobal("CSG_Attacker"..slot.."_Heal_2");
		local nFrame1 = getglobal("CSG_Attacker"..slot.."_Heal_1_NameFrameNameText");
		local nFrame2 = getglobal("CSG_Attacker"..slot.."_Heal_2_NameFrameNameText");
		local aFrame1 = getglobal("CSG_Attacker"..slot.."_Heal_1_NameFrame_Icon");
		local aFrame2 = getglobal("CSG_Attacker"..slot.."_Heal_2_NameFrame_Icon");

		if (AttackerList[slot] and AttackerList[slot].h1) then
			--CSG_AddMessage("Healer showing in slot: "..slot);
			if (AttackerList[slot].h1_heal) then
				damage = 1;	
			else
				damage = 0;
			end
			nFrame1:SetText(AttackerList[slot].h1);
			CSG_ShowHealFrame( mFrame1, aFrame1, damage, slot );
		else
			CSG_HideHealFrame( mFrame1 );
		end
		if (AttackerList[slot] and AttackerList[slot].h2) then
			if (AttackerList[slot].h2_heal) then
				damage = 1;
			else
				damage = 0;
			end
			nFrame2:SetText(AttackerList[slot].h2);
			CSG_ShowHealFrame( mFrame2, aFrame2, damage, slot );	
		else
			CSG_HideHealFrame( mFrame2 );
		end
	end
end

function CSG_SetDMGWidth( slot )
	local dWidth = getglobal("CSG_Attacker"..slot.."_DMGText"):GetStringWidth();
	local dFrame = getglobal("CSG_Attacker"..slot.."_DMG");
	if (dWidth < 20) then
		dWidth = 20;
	end
	--dFrame:ClearAllPoints();
	dFrame:SetWidth(dWidth + 16);
end

--[[
function CSG_SetKillStats( unitName, slot )
	if (tf_user_data) then
		local fw_PlayerName = UnitName("player");
		local fw_PlayerRealm = GetCVar("realmName"); 
		local killFrame = getglobal("CSG_Attacker"..slot.."_Kills");
		local kills = getglobal("CSG_Attacker"..slot.."_KillsPlus");
		local killed = getglobal("CSG_Attacker"..slot.."_KillsMinus");
		local found = 0;
		for i=1, table.getn(tf_user_data[fw_PlayerRealm][fw_PlayerName].pvpKilledByEnemyName), 1 do
			if (tf_user_data[fw_PlayerRealm][fw_PlayerName].pvpKilledByEnemyName[i] == unitName) then
				killed:SetText(tf_user_data[fw_PlayerRealm][fw_PlayerName].pvpKilledByEnemyTotal[i]);
				found = found + 1;
				break;	
			end
		end
		for i=1, table.getn(tf_user_data[fw_PlayerRealm][fw_PlayerName].pvpKilledEnemyName), 1 do
			if (tf_user_data[fw_PlayerRealm][fw_PlayerName].pvpKilledEnemyName[i] == unitName) then
				killed:SetText(tf_user_data[fw_PlayerRealm][fw_PlayerName].pvpKilledEnemyTotal[i]);
				found = found + 1;
				break;	
			end
		end
		if (found > 0) then
			killFrame:Show();
		else
			killFrame:Hide();
		end	
	end
	return;
end
]]

function CSG_GetAttackerInfo( unitName, slot, type, partyname, skipcheck, pvp, spell )
	if (unitName == UnitName("target")) then
		type = "target";	
	end
	
	if (not CSG.curtarget) then
		CSG.curtarget = UnitName("target");
	end
	local portrait = getglobal("CSG_Attacker"..slot.."_PortraitArt");
	if (not portrait) then
		portrait = getglobal("CSG_Attacker1_PortraitArt");	
	end
	
	local enemy, failed; 

	if (CSG.curtarget) then
		--CSG_AddMessage("Old Target = "..CSG.curtarget);	
	end

	--CSG_AddMessage(CSGiz.infotarget);
	--CSG_AddMessage("IT: "..CSGiz.infotarget..", curtarg: "..CSG.curtarget..", unitName: "..unitName);
	if (CSGiz.infotarget == 1 and (type ~= "mouseover" or not type)) then
		if (not CSGiz.inCombat and not CSGiz.onHate) then
			if (CSG.curtarget ~= unitName) then
				enemy = UnitAffectingCombat("target");
				CSG_AddMessage(CSG_YLW_TXT.."--START GATHERTING--");
				CSG.gathering = 1;
				for i=1, CSG_MAXTARGETHOPS, 1 do
					TargetByName(unitName);
					if (UnitName("target") == unitName) then
						--CSG_AddMessage("hopped: "..i.." times trying to target: "..unitName);
						break;	
					elseif (i == CSG_MAXTARGETHOPS) then
						--CSG_AddMessage("hopped: "..CSG_MAXTARGETHOPS.." times, couldn't target: "..unitName);
						failed = 1;
					end
				end
				--CSG_AddMessage("targeting: "..unitName);
				--CSG_AddMessage("combat = "..combat);
			end
		else
			if (UnitName("target") ~= unitName) then
				failed = 1;	
			end
			
		end
	end
	--CSG_AddMessage("targetType = "..targetType);
--	/script CSG_AddMessage(UnitAffectingCombat("target"));
	local lvl = AttackerList[slot].lvl;
	if (not lvl) then
		lvl = 0;
	end
	
	if ( (failed and lvl == 0) or (CSGiz.infotarget == 0 and type == nil)) then
		if (not slot) then
			return;	
		end
		portrait:SetTexture("Interface\\CharacterFrame\\TempPortrait");
		portrait:SetDesaturated(1);
		portrait:SetVertexColor(0.2,0.2,0.2);

		AttackerList[slot].lvl = 0;
		if (spell and CSG_AbilityList[spell]) then
			AttackerList[slot].cls = CSG_AbilityList[spell].cl;
			CSG_AddMessage("+++CAPTURING "..CSG_AbilityList[spell].cl);	
			--/script CSG_AddMessage("+++CAPTURING "..CSG_AbilityList["Mind Blast"].cl);	
		else
			AttackerList[slot].cls = CSG_UNKNOWN;
			CSG_AddMessage("+++CAPTURING UNKNOWN");			
		end

		if (pvp) then
			CSG_AddMessage("+++SETTING PVP");
			AttackerList[slot].pvp = 1;	
		end
		CSG_SetAttackerInfo( unitName, slot, 1, partyname, pvp, spell );
		return;	
	end

	if (not type) then
		type = "target";
	end
	if (skipcheck or not UnitIsFriend(type, "player") or UnitAffectingCombat(type)) then
		if (AttackerList[slot] and unitName == UnitName(type)) then
			CSG_AddMessage("+++Setting info for: "..unitName.." : "..type);
			local rankName, rankNumber = GetPVPRankInfo(UnitPVPRank(type));

			AttackerList[slot].lvl = UnitLevel(type);
			AttackerList[slot].cls = UnitClass(type);
			AttackerList[slot].pvp = UnitPlayerControlled(type);
			AttackerList[slot].rnk = rankNumber;

			CSG_UpdateTargetHealthMana( unitName, slot, type );

			--portrait:SetTexture("Interface\\CharacterFrame\\TempPortrait");
			portrait:SetDesaturated(0);
			portrait:SetVertexColor(1,1,1);
			SetPortraitTexture(portrait, type);
			--if (CSG_CheckCorrectTarget( unitName, type )) then
				--SetPortraitTexture(portrait, type);
				CSG_SetAttackerInfo( unitName, slot, nil, partyname, pvp, spell );
			--else
			--	CSG_SetAttackerInfo( unitName, slot, 1, partyname, pvp );
			--end	
		else
			CSG_SetAttackerInfo( unitName, slot, 1, partyname, pvp, spell );
		end
	end

	if (CSGiz.infotarget == 0 or type == "mouseover") then
		CSG.gathering = nil;
		return;
	elseif (CSG.curtarget and CSG.curtarget == unitName) then
		--if (combat == 1 and combat ~= CSGiz.inCombat) then
		--	AttackTarget();	
			--CSG_AddMessage("attacking: "..unitName);
		--end
		CSG.gathering = nil;
		CSG_AddMessage("oldtarget = newtarget, KEEPING CURRENT TARGET");
		CSG_AddMessage(CSG_YLW_TXT.."--CLEARING GATHERING--");
	elseif (not CSG.curtarget) then
		for i=1, CSG_MAXTARGETHOPS, 1 do
			ClearTarget();
			if (not UnitName("target")) then
				--CSG_AddMessage("hopped: "..i.." times trying to clear target");
				break;	
			elseif (i == CSG_MAXTARGETHOPS) then
				--CSG_AddMessage("hopped: "..CSG_MAXTARGETHOPS.." times, couldn't clear target");
				CSG_AddMessage( CSG_WHT_TXT.."Failed to Clear OldTarget!");	
				--PlaySoundFile("Sound\\Spells\\EyeOfKilroggDeath.wav");
				CSG.gathering = nil;
				CSG_AddMessage(CSG_YLW_TXT.."--CLEARING GATHERING--");
			end
		end
		CSG.gathering = nil;
		CSG_AddMessage("CLEARING TARGET");
	else
		for i=1, CSG_MAXTARGETHOPS, 1 do
			TargetLastTarget();
			if (CSG.curtarget and CSG.curtarget == UnitName("target")) then
				--CSG_AddMessage("hopped: "..i.." times trying to target oldtarget: "..CSG.curtarget);
				--CSG_AddMessage("TARGETING PREVIOUS TARGET ("..CSG.curtarget..")");
				CSG.gathering = nil;
				--CSG_AddMessage(CSG_YLW_TXT.."--CLEARING GATHERING--");
				break;	
			elseif (i == CSG_MAXTARGETHOPS) then
				--CSG_AddMessage("hopped: "..CSG_MAXTARGETHOPS.." times, couldn't target oldtarget: "..CSG.curtarget);
				--CSG_AddMessage( CSG_WHT_TXT.."Failed to Select OldTarget!");	
				--PlaySoundFile("Sound\\Spells\\EyeOfKilroggDeath.wav");
				CSG.gathering = nil;
				CSG_AddMessage(CSG_YLW_TXT.."--CLEARING GATHERING--");
			end
		end	
		--if (combat == 1 and combat ~= CSGiz.inCombat) then
		--	AttackTarget();	
			--CSG_AddMessage("attacking: "..CSG.curtarget);
		--end
	end
end

function CSG_SetAttackerInfo( unitName, slot, unknown, partyname, pvp, spell )
	if (not slot or slot <= 0) then
		return;	
	end
	local frame = getglobal("CSG_Attacker"..slot);
	local ltext = getglobal("CSG_Attacker"..slot.."_Text_LevelText");
	--local ctext = getglobal("CSG_Attacker"..slot.."_ClassText");
	local rankicon = getglobal("CSG_Attacker"..slot.."_Text_RankIcon");
	local ptext = getglobal("CSG_Attacker"..slot.."_PARTYPartyText");
	local cframe = getglobal("CSG_Attacker"..slot.."_Portrait");
	local cicon = getglobal("CSG_Attacker"..slot.."_PortraitClassIcon");
	local hmframe = getglobal("CSG_Attacker"..slot.."_HealthManaFrame");
	local healthbar = getglobal("CSG_Attacker"..slot.."_HealthManaFrameHealthBar");

	if (not frame or not ltext) then
		return;	
	end
	if (unknown) then
		ltext:SetText("?");
		--ctext:SetText(Unknown);
		ltext:SetVertexColor(0.75, 0.75, 0.75);
		--ctext:SetVertexColor(0.75, 0.75, 0.75);
		frame:SetBackdropColor(0.4, 0.4, 0.4);	
		frame:SetBackdropBorderColor(0.2, 0.2, 0.2);
		--cframe:SetBackdropBorderColor(0.1, 0.1, 0.1);
		if (spell and CSG_AbilityList[spell]) then
			AttackerList[slot].cls = CSG_AbilityList[spell].cl;
			cicon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes");
			cicon:SetDesaturated(0);
			cicon:SetVertexColor(1,1,1);
			cicon:SetTexCoord(CSG[(AttackerList[slot].cls)].i1, CSG[(AttackerList[slot].cls)].i2, CSG[(AttackerList[slot].cls)].i3, CSG[(AttackerList[slot].cls)].i4 );
		else
			AttackerList[slot].cls = CSG_UNKNOWN;
			CSG_AddMessage("+++CAPTURING UNKNOWN");			
			cicon:SetTexture("Interface\\InventoryItems\\WoWUnknownItem01");
			cicon:SetDesaturated(1);
			cicon:SetVertexColor(0.2,0.2,0.2);
			cicon:SetTexCoord(0, 1, 0, 1 );
		end	
		rankicon:Hide();
		hmframe:Hide();
	else	
		if (AttackerList[slot].lvl == -1 or AttackerList[slot].lvl == 100) then
			ltext:SetText("??");
			AttackerList[slot].lvl = 100;
		elseif (AttackerList[slot].lvl == 0 or AttackerList[slot].lvl == nil) then
			AttackerList[slot].lvl = 0;
			ltext:SetText("?");
		else
			ltext:SetText(AttackerList[slot].lvl);
		end
		
		local color = CSG_GetDifficultyColor(AttackerList[slot].lvl);
		local hcolor = GetDifficultyColor(AttackerList[slot].lvl);

		--ctext:SetText(AttackerList[slot].cls);
		--ltext:SetVertexColor(0.75, 0.75, 0.75);
		--ctext:SetVertexColor(0.75, 0.75, 0.75);
		frame:SetBackdropColor(color.r, color.g, color.b);
		healthbar:SetStatusBarColor(hcolor.r, hcolor.g, hcolor.b);
		if (not AttackerList[slot].cls or AttackerList[slot].cls == CSG_UNKNOWN) then
			if (spell and CSG_AbilityList[spell]) then
				AttackerList[slot].cls = CSG_AbilityList[spell].cl;
				cicon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes");
				cicon:SetDesaturated(0);
				cicon:SetVertexColor(1,1,1);
			else
				AttackerList[slot].cls = CSG_UNKNOWN;
				CSG_AddMessage("+++CAPTURING UNKNOWN");			
				cicon:SetTexture("Interface\\InventoryItems\\WoWUnknownItem01");
				cicon:SetDesaturated(1);
				cicon:SetVertexColor(0.2,0.2,0.2);
				--cicon:SetTexCoord(0, 1, 0, 1 );
			end	
		else
			cicon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes");
			cicon:SetDesaturated(0);
			cicon:SetVertexColor(1,1,1);
		end
		--cframe:SetBackdropBorderColor(CSG[(AttackerList[slot].cls)].r, CSG[(AttackerList[slot].cls)].g, CSG[(AttackerList[slot].cls)].b);
		cicon:SetTexCoord(CSG[(AttackerList[slot].cls)].i1, CSG[(AttackerList[slot].cls)].i2, CSG[(AttackerList[slot].cls)].i3, CSG[(AttackerList[slot].cls)].i4 );
	end

	if (AttackerList[slot].pvp or pvp) then
		frame:SetBackdropBorderColor(1, 0.3, 0.3);
		--CSG_SetKillStats( unitName, slot );
	elseif (partyname) then
		frame:SetBackdropBorderColor(0.5, 0.5, 1);
	else
		frame:SetBackdropBorderColor(0.2, 0.2, 0.2);
	end
	-- Set icon
	if ( AttackerList[slot].rnk and AttackerList[slot].rnk > 0 ) then
		rankicon:SetTexture(format("%s%02d","Interface\\PvPRankBadges\\PvPRank", AttackerList[slot].rnk));
		rankicon:Show();
	else
		rankicon:Hide();
	end
	if (partyname) then
		frame.party = partyname;
		ptext:SetText(partyname);
	else
		frame.party = nil;
	end

	CSG_SetDMGWidth( slot );
	--CSG_AddMessage("CurDamagers: "..CSG_CurDamagers);
end

ManaTextColor = {};
ManaTextColor[0] = { r = 0.50, g = 0.50, b = 1.00, prefix = TEXT(MANA) };
ManaTextColor[1] = { r = 1.00, g = 0.00, b = 0.00, prefix = TEXT(RAGE_POINTS) };
ManaTextColor[2] = { r = 1.00, g = 0.50, b = 0.25, prefix = TEXT(FOCUS_POINTS) };
ManaTextColor[3] = { r = 1.00, g = 1.00, b = 0.00, prefix = TEXT(ENERGY_POINTS) };
ManaTextColor[4] = { r = 0.00, g = 1.00, b = 1.00, prefix = TEXT(HAPPINESS_POINTS) };

function CSG_UpdateTargetHealthMana( unitName, slot, type )
	if (not type) then
		type = "target";
	end
	if (unitName ~= UnitName(type)) then
		return;	
	end
	local frame = getglobal("CSG_Attacker"..slot);
	local hmframe = getglobal("CSG_Attacker"..slot.."_HealthManaFrame");
	local healthbar = getglobal("CSG_Attacker"..slot.."_HealthManaFrameHealthBar");
	--local manabar = getglobal("CSG_Attacker"..slot.."_HealthManaFrameManaBar");
	--local manatype = UnitPowerType(type);
	--local info = ManaBarColor[manatype];
	CSG_AddMessage(CSG_BLE_TXT.."--UPDATING H/M-- "..unitName.." == "..UnitName(type).." : "..type.." : "..hmframe:GetName());
	healthbar.unit = type;
	--manabar.unit = type;
	
	hmframe.fadingout = nil;
	UIFrameFadeRemoveFrame(hmframe);
	hmframe.startTime = GetTime();
	hmframe.endTime = hmframe.startTime + CSG_HEALTHMANA_STAY_TIME;
	hmframe:Show();
	healthbar:SetFrameLevel(frame:GetFrameLevel() + 1);
	--CSG_HealthManaFrame_FadeIn( hmframe );

	UnitFrameHealthBar_Update(healthbar, type);
	if (frame:GetAlpha() > 0.75) then
		hmframe:SetAlpha(0.45);	
	end
	--manabar:SetStatusBarColor(info.r, info.g, info.b);	
	--UnitFrameManaBar_Update(manabar, type);

end

function CSG_HealthManaFrame_OnUpdate()
	if ( this.fadingout ) then
		--CSG_AddMessage(CSG_WHT_TXT..this:GetName().." : alpha = "..this:GetAlpha());
		if ( this:GetAlpha() <= 0 ) then
			CSG_HealthManaFrame_FadeOut_Finished();
		end
		return;
	elseif ( this.fadingin ) then
		if ( this:GetAlpha() >= 1 ) then
			CSG_HealthManaFrame_FadeIn_Finished();
		end
		return;
	end
	if (this:IsVisible()) then
		local fraction = (GetTime() - this.startTime) / (this.endTime - this.startTime);
		--CSG_AddMessage(CSG_WHT_TXT..this:GetName().." : fraction = "..fraction);
		if ( fraction >= 1.0 ) then
			CSG_HealthManaFrame_FadeOut( this );
		end	
	end
end

function CSG_HealthManaFrame_FadeOut( frame, func )
	if ( frame.fadingout ) then
		return;
	end
	--CSG_AddMessage("CSG_HealthManaFrame_FadeOut : "..frame:GetName());

	frame.fadingout = 1;
	frame.fadingin = nil;
	frame.targetalpha = 0;
	frame.animfunc_fade = func;

	UIFrameFadeRemoveFrame(frame);
	UIFrameFadeOut( frame, CSG_HEALTHMANA_FADE_TIME, frame:GetAlpha(), frame.targetalpha );
end

function CSG_HealthManaFrame_FadeOut_Finished()
	--CSG_AddMessage("CSG_HealthManaFrame_FadeOut_Finished");
	this:Hide();
	this:SetAlpha( 0.6 );

	this.fadingout = nil;
	if ( this.animfunc_fade ) then
		this.animfunc_fade();
	end
end

function CSG_HealthManaFrame_FadeIn( frame, func )
	--CSG_AddMessage("CSG_HealthManaFrame_FadeIn");
	if ( frame.fadingin ) then
		return;
	end
	if ( frame.fadingout ) then
		UIFrameFadeRemoveFrame(frame);
	end

	frame.fadingin = 1;
	frame.fadingout = nil;
	frame.targetalpha = 0.7;
	frame.animfunc_fade = func;
	UIFrameFadeRemoveFrame(frame);
	UIFrameFadeIn( frame, 0.1, 0.9, frame.targetalpha );
end

function CSG_HealthManaFrame_FadeIn_Finished()
	--CSG_AddMessage("CSG_HealthManaFrame_FadeIn_Finished");
	this:SetAlpha( 0.7 );

	this.fadingin = nil;
	if ( this.animfunc_fade ) then
		this.animfunc_fade();
	end
end

function CSG_CheckCorrectTarget( unitName, type )
	if (not type) then
		type = "target";	
	end
	if ( unitName == UnitName(type)) then
		return 1;
	end
end

function CSG_UpdatePortrait( unitName, slot )
	local combat = CSGiz.inCombat;
	if (not CSG.curtarget) then
		CSG.curtarget = UnitName("target");
	end
	if (CSG.curtarget ~= unitName) then
		TargetByName(unitName);
	end

	local portrait = getglobal("CSG_Attacker"..slot.."_PortraitArt");
	portrait:SetTexture("Interface\\CharacterFrame\\TempPortrait");
	portrait:SetDesaturated(1);
	portrait:SetVertexColor(0.2,0.2,0.2);
	if (CSG_CheckCorrectTarget( unitName )) then
		SetPortraitTexture(portrait, "target");
		portrait:SetDesaturated(0);
		portrait:SetVertexColor(1,1,1);
	end

	if (CSG.curtarget == unitName or CSG.curtarget == nil) then
		if (combat == 1 and combat ~= CSGiz.inCombat) then
			AttackTarget();	
		end
		return;
	elseif (CSG.curtarget == nil) then
		ClearTarget();
		return;
	else
		TargetLastEnemy();
		if (combat == 1 and combat ~= CSGiz.inCombat) then
			AttackTarget();	
		end
	end
end

function CSG_MainFrame_OnShow()
	if (this:IsVisible()) then
		this.startTime = GetTime();
		this.endTime = this.startTime + CSG_CLEANUP_TIME;
	end
end

function CSG_MainFrame_Toggle()
	local frame = getglobal("CSG_Main_Frame");
	local flash = getglobal("CSG_MainFlash_Frame");
	local text = getglobal("CSG_Main_Frame_Text");
	--CSG_AddMessage("damagers = "..CSG_CurDamagers);
	if (CSGiz.anchor == 2) then
		CSG_Main_Frame:Show();
		flash:Hide();
		frame:SetBackdropBorderColor(0, 0, 0, 0);
		frame:SetBackdropColor(0, 0, 0, 0);
		text:SetText("");
	elseif (CSG_CurList >= 1) then
		flash:Show();
		flash.isFlashing = 1;
		CSG_MainFlashIn( this );
		CSG_Main_Frame:Show();
		if (CSG_CurDamagers > 0) then
			--CSG_AddMessage("damagers = "..CSG_CurDamagers);
			frame:SetBackdropBorderColor(0.8, 0.1, 0.1, 0.9);
			frame:SetBackdropColor(0.1, 0.1, 0.1, 0.9);
			text:SetText("Being Attacked!");
			text:SetTextColor(1, 0, 0);
		else
			frame:SetBackdropBorderColor(0.8, 0.8, 0.1, 0.9);
			frame:SetBackdropColor(0.1, 0.1, 0.1, 0.9);
			text:SetText("Caution!");
			text:SetTextColor(0.9, 0.9, 0);			
		end
	else
		flash.isFlashing = nil;
		frame.visible = nil;
		if (CSGiz.anchor == 1 or CSG.mousedown == 1) then
			CSG_Main_Frame:Show();
			frame:SetBackdropBorderColor(0.8, 0.8, 0.8, 0.9);
			frame:SetBackdropColor(0.1, 0.1, 0.1, 0.9);
			text:SetText(CSG_TITLE);
			flash:Hide();
			--return;
		else
			CSG_Main_Frame:Hide();
		end	
	end
	CSG_SetEffectiveScale(frame, CSGiz.scale, UIParent);
end

function CSG_ShowFrame( slot, damage, partyname )
	local frame = getglobal("CSG_Attacker"..slot);
	local dframe = getglobal("CSG_Attacker"..slot.."_DMG");
	local pframe = getglobal("CSG_Attacker"..slot.."_PARTY");
	local gframe = getglobal("CSG_Attacker"..slot.."_GlowArt");
	local hiart = getglobal("CSG_Attacker"..slot.."_HighlightArt");
	local ltext = getglobal("CSG_Attacker"..slot.."_Text_LevelText");
	local ntext = getglobal("CSG_Attacker"..slot.."_Text_NameText");
	local ctext = getglobal("CSG_Attacker"..slot.."_Text_ClassText");
	local hmframe = getglobal("CSG_Attacker"..slot.."_HealthManaFrame");
	local healthbar = getglobal("CSG_Attacker"..slot.."_HealthManaFrameHealthBar");
	local manabar = getglobal("CSG_Attacker"..slot.."_HealthManaFrameManaBar");

	if (not AttackerList[slot]) then
		return;
	end
	local dam;
	if (damage and damage > 0) then
		dam = damage;
	elseif (AttackerList[slot].dam and AttackerList[slot].dam > 0) then
		dam = AttackerList[slot].dam;
	else
		dam = nil;
	end

	if (not AttackerList[slot].cls) then
		AttackerList[slot].cls = CSG_UNKNOWN;	
	end

	if (partyname) then
		CSG_AddMessage(partyname.." is being attacked!");
	end
	if (dam and dam > 0) then
		CSG_Frame_AddDamager( slot );
		frame:SetAlpha(1);
		if (partyname) then
			dframe:Hide();
			pframe:Show();
			pframe:SetWidth(getglobal("CSG_Attacker"..slot.."_PARTYPartyText"):GetStringWidth() + 4);
		else
			dframe:Show();
			pframe:Hide();
		end
		ntext:ClearAllPoints();
		ltext:ClearAllPoints();
		ctext:ClearAllPoints();
		ntext:SetPoint("TOPLEFT", frame:GetName(), "TOPLEFT", 50, -3.5);
		ntext:SetTextHeight(10);
		ntext:SetWidth(100);
		ltext:SetPoint("BOTTOMRIGHT", frame:GetName(), "BOTTOMRIGHT", -8, 6);
		ltext:SetTextHeight(11);
		ctext:SetPoint("BOTTOMLEFT", frame:GetName(), "BOTTOMLEFT", 50, 6);
		ctext:SetTextHeight(11);
		ctext:SetText(AttackerList[slot].cls);
		ctext:SetTextColor(CSG[(AttackerList[slot].cls)].r, CSG[(AttackerList[slot].cls)].g, CSG[(AttackerList[slot].cls)].b);
		frame:SetWidth(CSG_Main_Frame:GetWidth());
		hiart:SetWidth(CSG_Main_Frame:GetWidth() + 8);
		gframe:SetWidth(CSG_Main_Frame:GetWidth() + 20);
		hmframe:SetWidth(CSG_Main_Frame:GetWidth() - 56);
		hmframe:SetPoint("RIGHT", frame:GetName(), "RIGHT", -6, 0);
		healthbar:SetWidth(CSG_Main_Frame:GetWidth() - 56);
		--manabar:SetWidth(CSG_Main_Frame:GetWidth() - 8);
	else
		if (partyname) then
			frame:SetAlpha(1);
			dframe:Hide();
			pframe:Show();
			pframe:SetWidth(getglobal("CSG_Attacker"..slot.."_PARTYPartyText"):GetStringWidth() + 10);
		else
			frame:SetAlpha(0.5);
			dframe:Hide();
			pframe:Hide();
		end
		ltext:SetAlpha(1);
		ntext:SetAlpha(1);
		ntext:ClearAllPoints();
		ltext:ClearAllPoints();
		ctext:ClearAllPoints();
		ntext:SetPoint("LEFT", frame:GetName(), "LEFT", 50, 6);
		ntext:SetTextHeight(14);
		ntext:SetWidth(149);
		ltext:SetPoint("RIGHT", frame:GetName(), "RIGHT", -8, 2);
		ltext:SetTextHeight(16);
		ctext:SetPoint("BOTTOMLEFT", frame:GetName(), "BOTTOMLEFT", 50, 4);
		ctext:SetTextHeight(13);
		ctext:SetText(AttackerList[slot].cls);
		ctext:SetTextColor(CSG[(AttackerList[slot].cls)].r, CSG[(AttackerList[slot].cls)].g, CSG[(AttackerList[slot].cls)].b);
		--CSG_AddMessage("Main Scale: "..CSG_Main_Frame:GetScale().." attackerframe scale: "..CSG_Main_Frame:GetScale() * CSG_NONATTACKER_SCALE);
		----frame:SetWidth(CSG_Main_Frame:GetWidth() / (UIParent:GetScale() * CSG_NONATTACKER_SCALE));
		frame:SetWidth(CSG_Main_Frame:GetWidth() / CSG_NONATTACKER_SCALE);
		hiart:SetWidth((CSG_Main_Frame:GetWidth() / CSG_NONATTACKER_SCALE) + (8 / CSG_NONATTACKER_SCALE));
		gframe:SetWidth((CSG_Main_Frame:GetWidth() / CSG_NONATTACKER_SCALE )+(20 / CSG_NONATTACKER_SCALE));
		hmframe:SetWidth((CSG_Main_Frame:GetWidth() / CSG_NONATTACKER_SCALE) - 56);
		hmframe:SetPoint("RIGHT", frame:GetName(), "RIGHT", -6, 0);
		healthbar:SetWidth((CSG_Main_Frame:GetWidth() / CSG_NONATTACKER_SCALE) - 56);
		--manabar:SetWidth((CSG_Main_Frame:GetWidth() / CSG_NONATTACKER_SCALE) - 8);
	end
	--CSG_Main_Frame:SetScale(0.1);
	--CSG_Main_Frame:SetScale(CSGiz.scale);

	frame.startTime = GetTime();
	if (AttackerList[slot].dam and AttackerList[slot].dam > 0) then
		frame.endTime = frame.startTime + CSGiz.time_a;
	else
		frame.endTime = frame.startTime + CSGiz.time_na;
	end
	frame:Show();

	CSG_MainFrame_Toggle();
	if (dam and dam > 0) then
		frame:SetScale(2);
		frame:SetScale(CSGiz.scale * 1);
	else
		frame:SetScale(2);
		CSG_SetEffectiveScale(frame, (CSG_Main_Frame:GetScale() * CSG_NONATTACKER_SCALE), UIParent);
	end
end

function CSG_HideFrame( frame )
	local slot = frame:GetID();
	CSG_UpdateFrameSlots( slot );
	
	frame:Hide();
--	CSG_AddMessage("Hiding Slot: "..slot);
--	CSG_AddMessage("Attackers in list: "..table.getn(AttackerList));
end

function CSG_Frame_OnShow( frame )
--	CSG_AddMessage("XML OnShow");
	if (frame.moving) then
		return;	
	end
	
	local slot = frame:GetID();

	local hFrame1 = getglobal("CSG_Attacker"..(slot - 1).."_Heal_1");
	local hFrame2 = getglobal("CSG_Attacker"..(slot - 1).."_Heal_2");
	local pFrame, cFrame;

	--sets how it attaches to the frame above it
	frame:ClearAllPoints();
	for i=(slot - 1), 0, -1 do
		--CSG_AddMessage("parent i = "..i);

		if (i < 1) then
			frame:SetPoint("TOPLEFT", "CSG_Main_Frame", "BOTTOMLEFT", 0, 0);
			--CSG_AddMessage("no visible frames above this one. attaching to ANCHOR.");
			break;
		end
		pFrame = getglobal("CSG_Attacker"..i);
		if (pFrame:IsVisible()) then
			if (AttackerList[i] and AttackerList[i].h2) then
				frame:SetPoint("TOPLEFT", "CSG_Attacker"..i.."_Heal_2", "BOTTOMLEFT", 0, 0);
			elseif (AttackerList[i] and AttackerList[i].h1) then
				frame:SetPoint("TOPLEFT", "CSG_Attacker"..i.."_Heal_1", "BOTTOMLEFT", 0, 0);
			else
				frame:SetPoint("TOPLEFT", "CSG_Attacker"..i, "BOTTOMLEFT", 0, 0);
			end
			--CSG_AddMessage("frame "..i.." IS visible.  attaching frame "..slot.." to frame "..i);
			break;
		end
		--CSG_AddMessage("frame "..i.." is not visible, moving up.");
	end
	--sets how the child frame attaches to it
	for i=(slot + 1), ( CSG_MAXATTACKFRAMES - (slot + 1)) , 1 do
		if (i > CSG_MAXATTACKFRAMES) then
			break;
		end
		cFrame = getglobal("CSG_Attacker"..i);
		if (cFrame:IsVisible()) then
			if (AttackerList[i] and AttackerList[i].h2) then
				cFrame:SetPoint("TOPLEFT", "CSG_Attacker"..slot.."_Heal_2", "BOTTOMLEFT", 0, 0);
			elseif (AttackerList[i] and AttackerList[i].h1) then
				cFrame:SetPoint("TOPLEFT", "CSG_Attacker"..slot.."_Heal_1", "BOTTOMLEFT", 0, 0);
			else
				cFrame:SetPoint("TOPLEFT", "CSG_Attacker"..slot, "BOTTOMLEFT", 0, 0);
			end
			break;
		end
	end
end

function CSG_Frame_AddDamager( slot )

	if (AttackerList[slot] == nil or (AttackerList[slot] and AttackerList[slot].dgr == 1)) then
		return;
	elseif (AttackerList[slot].dam and AttackerList[slot].dam > 0) then
		AttackerList[slot].dgr = 1;
		CSG_CurDamagers = CSG_CurDamagers + 1;	
		--CSG_AddMessage("|cffffff00Adding Damager");
		CSG_MainFrame_Toggle();
	end
end

function CSG_Frame_RemoveDamager( slot )
	if (not AttackerList[slot]) then
		return;
	end
	if (AttackerList[slot].dgr == 1) then
		AttackerList[slot].dgr = nil;
		CSG_CurDamagers = CSG_CurDamagers - 1;
		--CSG_AddMessage("|cffff2020Hiding Frame, removing Damager");
		--CSG_AddMessage("|cffff2020damagers = "..CSG_CurDamagers);
		CSG_MainFrame_Toggle();
	end	
end

function CSG_AttackerFrame_OnClick()
	local slot = this:GetParent():GetID();
	if (this:GetParent().party) then
		AssistByName(this:GetParent().party);
		PlaySoundFile("Sound\\Interface\\uEscapeScreenOpen.wav");
		return;
	elseif (not slot or not AttackerList[slot] or not AttackerList[slot].pvp) then
		PlaySoundFile("Sound\\Interface\\Error.wav");
		return;	
	end

	TargetByName(AttackerList[slot].name);
	PlaySoundFile("Sound\\Interface\\uEscapeScreenOpen.wav");
end

function CSG_ShowHealFrame( frame, icon, damage, slot )
	frame.startTime = GetTime();
	frame.endTime = frame.startTime + CSGiz.time_h;
	CSG_SetHealIcon( icon, damage, slot );
	if (frame:IsVisible()) then
		CSG_HealFrame_OnShow( frame );
	else
		frame:Show();
	end
--	CSG_AddMessage("Showing heal frame");

	CSG_ShowFrame( slot );
end

function CSG_HideHealFrame( frame )
	local slot = frame:GetParent():GetID();
	local hslot = this:GetID();
	if (AttackerList[slot]) then
		if (hslot == 1) then
			AttackerList[slot].h1 = nil;
			AttackerList[slot].h1_heal = nil;
		else
			AttackerList[slot].h2 = nil;
			AttackerList[slot].h2_heal = nil;
		end
		frame:Hide();
	end
end

function CSG_SetHealIcon( icon, damage, slot )
	if (damage and damage > 0) then
		if (slot == 1) then
			AttackerList[slot].h1_heal = 1;
		else
			AttackerList[slot].h2_heal = 1;
		end
		icon:SetTexture("Interface\\Icons\\Spell_Holy_Heal");
	else
		icon:SetTexture("Interface\\Icons\\INV_Enchant_EssenceMysticalLarge");
	end
end

function CSG_HealFrame_OnShow( frame )
--	CSG_AddMessage("XML OnShow");
	local slot = frame:GetParent():GetID();
	local hslot = frame:GetID();
	local pFrame = getglobal("CSG_Attacker"..slot);
	local cFrame = getglobal("CSG_Attacker"..(slot + 1));
--	CSG_AddMessage("Child Frame = CSG_Attacker"..(slot + 1));
	local hFrame1, hFrame2; 
	if (hslot == 2) then
		hFrame1 = getglobal("CSG_Attacker"..slot.."_Heal_"..(hslot - 1));
		hFrame2 = getglobal("CSG_Attacker"..slot.."_Heal_"..hslot);
		if (hFrame1:IsVisible()) then
			hFrame2:SetPoint("TOPLEFT", "CSG_Attacker"..slot.."_Heal_"..(hslot - 1), "BOTTOMLEFT", 0, 0);
		else
			hFrame2:SetPoint("TOPLEFT", "CSG_Attacker"..slot, "BOTTOMLEFT", 0, 0);
		end
		cFrame:SetPoint("TOPLEFT", "CSG_Attacker"..slot.."_Heal_"..hslot, "BOTTOMLEFT", 0, 0);
	else
		hFrame1 = getglobal("CSG_Attacker"..slot.."_Heal_"..hslot);
		hFrame2 = getglobal("CSG_Attacker"..slot.."_Heal_"..(hslot + 1));
--		CSG_AddMessage("hFrame1 = CSG_Attacker"..slot.."_Heal_"..hslot);
		if (hFrame2:IsVisible()) then
			hFrame2:SetPoint("TOPLEFT", "CSG_Attacker"..slot.."_Heal_"..hslot, "BOTTOMLEFT", 0, 0);
			cFrame:SetPoint("TOPLEFT", "CSG_Attacker"..slot.."_Heal_"..(hslot + 1), "BOTTOMLEFT", 0, 0);
		else
			cFrame:SetPoint("TOPLEFT", "CSG_Attacker"..slot.."_Heal_"..hslot, "BOTTOMLEFT", 0, 0);
		end
	end
end

function CSG_HealFrame_OnHide()
	--FIX: C STACK OVERFLOW
	local slot = this:GetParent():GetID();
	local hslot = this:GetID();
	local pFrame = getglobal("CSG_Attacker"..slot);
	local cFrame = getglobal("CSG_Attacker"..(slot + 1));
	local hFrame1, hFrame2;
	if (hslot == 2) then
		hFrame1 = getglobal("CSG_Attacker"..slot.."_Heal_"..(hslot - 1));
		hFrame2 = getglobal("CSG_Attacker"..slot.."_Heal_"..hslot);
		if (hFrame1:IsVisible()) then
			cFrame:SetPoint("TOPLEFT", "CSG_Attacker"..slot.."_Heal_"..(hslot - 1), "BOTTOMLEFT", 0, 0);
		else
			cFrame:SetPoint("TOPLEFT", "CSG_Attacker"..slot, "BOTTOMLEFT", 0, 0);
		end
	else
		hFrame1 = getglobal("CSG_Attacker"..slot.."_Heal_"..hslot);
		hFrame2 = getglobal("CSG_Attacker"..slot.."_Heal_"..(hslot + 1));
		if (hFrame2:IsVisible()) then
			hFrame2:SetPoint("TOPLEFT", "CSG_Attacker"..slot, "BOTTOMLEFT", 0, 0);
		else
			cFrame:SetPoint("TOPLEFT", "CSG_Attacker"..slot, "BOTTOMLEFT", 0, 0);
		end
	end
	if (CSGiz.sound_all == 1) then
		PlaySoundFile("Sound\\Interface\\iDeselectTarget.wav");
	end
end

function CSG_HealFrame_OnClick()
	local slot = this:GetParent():GetParent():GetID();
	local hslot = this:GetParent():GetID();

	if (hslot == 1) then
		TargetByName(AttackerList[slot].h1);
	else
		TargetByName(AttackerList[slot].h2);
	end
end


function CSG_AttackerFrame_OnUpdate()
	if ( this.moving ) then
--		local prevId = (this:GetID() - 1);
		this:ClearAllPoints();

		local fraction = (GetTime() - this.animStartTime) / (this.animEndTime - this.animStartTime);
		if ( fraction >= 1.0 ) then
			CSG_AnimateFrameEnd( this );
		else
			local xpos = this.startxpos + (fraction * (this.targetxpos - this.startxpos));
			local ypos = this.startypos + (fraction * (this.targetypos - this.startypos));
			this:SetPoint("TOPLEFT", "CSG_Attacker"..this.prevId, "BOTTOMLEFT", xpos, ypos);
		end
	end
	if (this:IsVisible()) then
		local fraction = (GetTime() - this.startTime) / (this.endTime - this.startTime);
		if ( fraction >= 1.0 ) then
			CSG_HideFrame( this );
		else
			return;
		end
	end
end

function CSG_HealFrame_OnUpdate()
	if (this:IsVisible()) then
		local fraction = (GetTime() - this.startTime) / (this.endTime - this.startTime);
		if ( fraction >= 1.0 ) then
--			CSG_AddMessage("Timer Up, Hiding Healframe");
			CSG_HideHealFrame( this );
		else
			return;
		end
	end
end


function CSG_MainFlashIn( frame )
	frame.flashIn = 1;
	frame.startTime = GetTime();
	frame.endTime = frame.startTime + CSG_MAINFLASHIN_TIME;
--	CSG_AddMessage("Flashing IN");
end

function CSG_MainFlashOut( frame )
	frame.flashIn = 0;
	frame.startTime = GetTime();
	frame.endTime = frame.startTime + CSG_MAINFLASHOUT_TIME;
--	CSG_AddMessage("Flashing OUT");
end

function CSG_MainFlash_OnUpdate()
	if (this.isFlashing) then
		local fraction = (GetTime() - this.startTime) / (this.endTime - this.startTime);
		if (this.flashIn == 1) then
			if ( fraction >= 1.0 ) then
				CSG_MainFlashOut( this );
			else
				local alpha = fraction * 0.5;
				this:SetAlpha(alpha);
			end			
		else
			if ( fraction >= 1.0 ) then
				CSG_MainFlashIn( this );
			else
				local alpha = (1 + (fraction * -1)) * 0.5;
				this:SetAlpha(alpha);
			end			
		end
		return;
	end
end

function CSG_Main_OnUpdate()
	if (this:IsVisible()) then
		local fraction = (GetTime() - this.startTime) / (this.endTime - this.startTime);
		if ( fraction >= 1.0 ) then
			CSG_FrameCleanup();
		end			
		return;
	end
end

function CSG_FrameCleanup()
	--CSG_AddMessage("Cleaning up frames");
	local cFrame; 
	local f = 0;
	for i=1, 30, 1 do
		cFrame = getglobal("CSG_Attacker"..i);
		if (cFrame:IsVisible()) then
			CSG_Frame_OnShow( cFrame );
			f = f + 1;
		end
		if (f == CSG_CurList) then
			CSG_MainFrame_OnShow();
			break;
		end
	end
	if (f == 0 or CSG_CurList == 0) then
		CSG_CurList = 0;
		CSG_CurDamagers = 0;
		CSG_MainFrame_Toggle();
	end
end

function CSG_AnimateFrame( frame, x1,y1, x2,y2, duration )
	-- Move to the start point
	if (not frame.prevId or frame.prevId == 0) then
		frame.prevId = 1;	
	end
--	CSG_AddMessage("prevId: "..prevId);
--	CSG_AddMessage("CSG_Attacker"..prevId);

	frame.startxpos = x1;
	frame.startypos = y1;
	frame.targetxpos = x2;
	frame.targetypos = y2;
	frame.animStartTime = GetTime();
	frame.animEndTime = frame.animStartTime + duration;
	frame.moving = 1;
end

function CSG_AnimateFrameEnd( frame )
	frame.moving = nil;
	CSG_Frame_OnShow( frame );
end

function CSG_UpdateFrameSlots( slot, distance )
	if (not slot or slot == CSG_MAXATTACKFRAMES) then
		return;
	end
	
	local cFrame, frame, startPos;
	for i=(slot + 1), (CSG_MAXATTACKFRAMES - (slot + 1)) , 1 do
		frame = getglobal("CSG_Attacker"..slot);
		cFrame = getglobal("CSG_Attacker"..i);
		cFrame.prevId = slot;
		if (cFrame:IsVisible() and cFrame:GetTop() and cFrame:GetScale() and frame:GetBottom()) then
			if (not frame or not cFrame or not slot) then
				return;	
			end
			startPos = ((cFrame:GetTop() * cFrame:GetScale()) - (frame:GetBottom() * frame:GetScale()));
			CSG_AddMessage("cFrame Top: "..cFrame:GetTop().."frame Bottom: "..frame:GetBottom());
			CSG_AnimateFrame( cFrame, 0, startPos, 0, 32 * ((frame:GetScale()) - (cFrame:GetScale()) + 1) + (startPos * -1), 0.5 );
			break;
			--/script CSG_AddMessage("CSG_Attacker1 scale: "..CSG_Attacker1:GetHeight().."CSG_Attacker2 scale: "..CSG_Attacker2:GetHeight());
		end
	end
end

function CSG_CopyFrameSlots( slot )
	local frame;
	if (slot == CSG_MAXATTACKFRAMES) then
		CSG_Frame_RemoveDamager( slot );
		AttackerList[slot] = nil; 
		CSG_MainFrame_Toggle();	
	end
	for i=slot, (CSG_MAXATTACKFRAMES - slot), 1 do
		frame = getglobal("CSG_Attacker"..(i + 1));
		if (slot == CSG_MAXATTACKFRAMES) then
			return;
		end
		if (frame:IsVisible() or AttackerList[i + 1] ~= nil) then
			local newFrame = tablecopy( AttackerList[i + 1] );
			AttackerList[i] = newFrame;

			local nFrame = getglobal("CSG_Attacker"..i.."_Text_NameText");
			nFrame:SetText(AttackerList[i].name);
			CSG_UpdateAttackerData(AttackerList[i].name, nil, i);
			frame:Hide();
			
			--CSG_AddMessage("Frame "..(i + 1).." copied to slot: "..i);
		else
			--CSG_AddMessage("No more frames visible, deleting table: "..i);
			CSG_Frame_RemoveDamager( i );
			AttackerList[i] = nil; 
			CSG_MainFrame_Toggle();
			break;
		end
		if (i == CSG_MAXATTACKFRAMES) then
			break;
		end
	end
end

function CSG_UnitDeath( unitName )
	local frame;
	for i=1, CSG_MAXATTACKFRAMES, 1 do
		frame = getglobal("CSG_Attacker"..i);
		if (AttackerList[i] and unitName == AttackerList[i].name) then
			CSG_HideFrame( frame );			
		end
	end
end

function CSG_Parse(event, arg1)

	if (not arg1) then
		return;
	end

	------
	-- Begin processing chat events
	------
	local unitName, targetName, spell, damage;

--	if (event == "CHAT_MSG_COMBAT_SELF_HITS") then
--			CSG_CaptureAttack(UnitName("player"), nil, 0);
--			return;
--	end
--
--	if (event == "CHAT_MSG_SPELL_SELF_BUFF") then
--			CSG_CaptureHealer(UnitName("player"), UnitName("player"), 1);
--			return;
--	end

	if (event == "CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS"
	--or event == "CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS"
	) then
		CSG_AddMessage(CSG_GRY_TXT.."SPELL - HOSTILE PLAYER_HITS");

		for unitName, targetName, damage in string.gfind(arg1, CSG_DAM_HIT) do
			--XX falls and loses
			if (CSGiz.detect == 0 and targetName ~= CSG_L_YOU) then
				return;
			elseif (targetName ~= CSG_L_YOU) then
				damage = nil;
			end
			CSG_CaptureAttack(unitName, targetName, damage, nil, nil, 1);
			return;
		end
		for unitName, targetName, damage in string.gfind(arg1, CSG_DAM_CRIT) do
			if (CSGiz.detect == 0 and targetName ~= CSG_L_YOU) then
				return;
			elseif (targetName ~= CSG_L_YOU) then
				damage = nil;
			end
			CSG_CaptureAttack(unitName, targetName, damage, nil, nil, 1);
			return;
		end

	elseif (event == "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE"
	--or event == "CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE"
	) then
	CSG_AddMessage(CSG_GRY_TXT.."SPELL - HOSTILE PLAYER_DAMAGE");

		if (GetLocale() == "enUS") then
			-- 1 3 2 for german
			for unitName, spell, targetName, damage in string.gfind(arg1, CSG_SDAM_HIT) do
				if (CSGiz.detect == 0 and targetName ~= CSG_L_YOU) then
					return;
				elseif (targetName ~= CSG_L_YOU) then
					damage = nil;
				end
				CSG_CaptureAttack(unitName, targetName, damage, nil, nil, 1, spell);
				return;
			end
			-- 1 and 2 switched for german
			for unitName, spell, targetName in string.gfind(arg1, CSG_SDAM_DODGEBY) do
				if (CSGiz.detect == 0 and targetName ~= CSG_L_YOU) then
					return;
				end
				CSG_CaptureAttack(unitName, targetName, damage, nil, nil, 1, spell);
				return;
			end
			-- 1 and 2 switched for german
			for unitName, spell, targetName in string.gfind(arg1, CSG_SDAM_EVADEBY) do
				if (CSGiz.detect == 0 and targetName ~= CSG_L_YOU) then
					return;
				end
				CSG_CaptureAttack(unitName, targetName, damage, nil, nil, 1, spell);
				return;
			end
		elseif (GetLocale() == "deDE") then
			for unitName, targetName, spell, damage in string.gfind(arg1, CSG_SDAM_HIT) do
				if (CSGiz.detect == 0 and targetName ~= CSG_L_YOU) then
					return;
				elseif (targetName ~= CSG_L_YOU) then
					damage = nil;
				end
				CSG_CaptureAttack(unitName, targetName, damage, nil, nil, 1, spell);
				return;
			end
			-- 1 and 2 switched for german
			for spell, unitName, targetName in string.gfind(arg1, CSG_SDAM_DODGEBY) do
				if (CSGiz.detect == 0 and targetName ~= CSG_L_YOU) then
					return;
				end
				CSG_CaptureAttack(unitName, targetName, nil, nil, nil, 1, spell);
				return;
			end
			-- 1 and 2 switched for german
			for spell, unitName, targetName in string.gfind(arg1, CSG_SDAM_EVADEBY) do
				if (CSGiz.detect == 0 and targetName ~= CSG_L_YOU) then
					return;
				end
				CSG_CaptureAttack(unitName, targetName, nil, nil, nil, 1, spell);
				return;
			end
		end
		for unitName, spell, targetName, damage in string.gfind(arg1, CSG_SDAM_CRIT) do
			if (CSGiz.detect == 0 and targetName ~= CSG_L_YOU) then
				return;
			elseif (targetName ~= CSG_L_YOU) then
				damage = nil;
			end
			CSG_CaptureAttack(unitName, targetName, damage, nil, nil, 1, spell);
			return;
		end
	     
		for unitName, spell in string.gfind(arg1, CSG_SDAM_BLOCK) do
			CSG_CaptureAttack(unitName, nil, nil, nil, nil, 1);
			return;
		end
		for unitName, spell, targetName in string.gfind(arg1, CSG_SDAM_BLOCKBY) do
			if (CSGiz.detect == 0 and targetName ~= CSG_L_YOU) then
				return;
			end
			CSG_CaptureAttack(unitName, targetName, nil, nil, nil, 1, spell);
			return;
		end
		for unitName, spell in string.gfind(arg1, CSG_SDAM_DEFLECT) do
			CSG_CaptureAttack(unitName, nil, nil, nil, nil, 1, spell);
			return;
		end
		for unitName, spell, targetName in string.gfind(arg1, CSG_SDAM_DEFLECTBY) do
			if (CSGiz.detect == 0 and targetName ~= CSG_L_YOU) then
				return;
			end
			CSG_CaptureAttack(unitName, targetName, nil, nil, nil, 1, spell);
			return;
		end
		for unitName, spell in string.gfind(arg1, CSG_SDAM_DODGE) do
			CSG_CaptureAttack(unitName, nil, nil, nil, nil, 1, spell);
			return;
		end

		for unitName, spell in string.gfind(arg1, CSG_SDAM_EVADE) do
			CSG_CaptureAttack(unitName, nil, nil, nil, nil, 1, spell);
			return;
		end

		for unitName, spell in string.gfind(arg1, CSG_SDAM_FAIL) do
			CSG_CaptureAttack(unitName, nil, nil, nil, nil, 1, spell);
			return;
		end
		for unitName, spell in string.gfind(arg1, CSG_SDAM_MISS) do
			CSG_CaptureAttack(unitName, nil, nil, nil, nil, 1, spell);
			return;
		end
		for unitName, spell in string.gfind(arg1, CSG_SDAM_PARRY) do
			CSG_CaptureAttack(unitName, nil, nil, nil, nil, 1, spell);
			return;
		end
		for unitName, spell in string.gfind(arg1, CSG_SDAM_RESIST) do
			CSG_CaptureAttack(unitName, nil, nil, nil, nil, 1, spell);
			return;
		end
		for unitName, spell, targetName in string.gfind(arg1, CSG_SDAM_RESISTBY) do
			if (CSGiz.detect == 0 and (targetName ~= CSG_L_YOU or targetName ~= YOU)) then
				return;
			end
			CSG_CaptureAttack(unitName, targetName, nil, nil, nil, 1, spell);
			return;
		end

	elseif (event == "CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES") then
--	CSG_AddMessage("CREATURE_VS_SELF_MISSES");
		CSG_AddMessage(CSG_GRY_TXT.."COMBAT - HOSTILE PLAYER_MISSES");

		for unitName, targetName in string.gfind(arg1, CSG_MISS_MISS) do
			CSG_CaptureAttack(unitName, targetName, nil, nil, nil, 1);
			return;
		end
		for unitName, targetName in string.gfind(arg1, CSG_MISS_PARRY) do
			CSG_CaptureAttack(unitName, targetName, nil, nil, nil, 1);
			return;
		end
		for unitName, targetName in string.gfind(arg1, CSG_MISS_EVADE) do
			CSG_CaptureAttack(unitName, targetName, nil, nil, nil, 1);
			return;
		end
		for unitName, targetName in string.gfind(arg1, CSG_MISS_DODGE) do
			CSG_CaptureAttack(unitName, targetName, nil, nil, nil, 1);
			return;
		end
		for unitName, targetName in string.gfind(arg1, CSG_MISS_DEFLECT) do
			CSG_CaptureAttack(unitName, targetName, nil, nil, nil, 1);
			return;
		end
		for unitName, targetName in string.gfind(arg1, CSG_MISS_BLOCK) do
			CSG_CaptureAttack(unitName, targetName, nil, nil, nil, 1);
			return;
		end
		for unitName, targetName, damage in string.gfind(arg1, CSG_MISS_ABSORB) do
			if (CSGiz.detect == 0 and targetName ~= YOU) then
				return;
			elseif (targetName ~= YOU) then
				damage = nil;
			end
			CSG_CaptureAttack(unitName, targetName, damage, nil, nil, 1);
			return;
		end
		-- Events below here are used to detect healers and buffers
	elseif (event == "CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF" or event == "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS" 
	--or event == "CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS" 
	) then
		CSG_AddMessage(CSG_GRY_TXT.."SPELL - HOSTILE_PLAYER_BUFF");
		for unitName, spell, targetName, damage in string.gfind(arg1, CSG_SPLL_HEALCRIT) do
			if (not targetName or unitName == targetName or string.gfind(targetName, unitName)) then
				if (CSGiz.detect == 1) then
					CSG_CaptureAttack(unitName, nil, nil, nil, nil, 1, spell);
					return;
				end
			else
				if (targetName == YOU or targetName == CSG_L_YOU) then
					return;
				elseif (CSGiz.detect == 1) then
					CSG_CaptureAttack(unitName, nil, nil, nil, nil, 1, spell);
					CSG_CaptureAttack(targetName, nil, nil, nil, nil, 1, spell);		
					CSG_CaptureHealer(unitName, targetName, damage);
				else
					CSG_CaptureHealer(unitName, targetName, damage);
				end
				return;
			end
			return;
		end
		for unitName, spell, targetName, damage in string.gfind(arg1, CSG_SPLL_HEAL) do
			if (not targetName or unitName == targetName or string.gfind(targetName, unitName)) then
				if (CSGiz.detect == 1) then
					CSG_CaptureAttack(unitName, nil, nil, nil, nil, 1, spell);
					return;
				end
			else
				if (targetName == YOU or targetName == CSG_L_YOU) then
					return;
				elseif (CSGiz.detect == 1) then
					CSG_CaptureAttack(unitName, nil, nil, nil, nil, 1, spell);
					CSG_CaptureAttack(targetName, nil, nil, nil, nil, 1, spell);
					CSG_CaptureHealer(unitName, targetName, damage);
				else
					CSG_CaptureHealer(unitName, targetName, damage);
				end
				return;
			end
			return;
		end
		for unitName, spell, targetName in string.gfind(arg1, CSG_SPLL_CAST) do
			if (not targetName or unitName == targetName or string.gfind(targetName, unitName)) then
				if (CSGiz.detect == 1) then
					CSG_CaptureAttack(unitName, nil, nil, nil, nil, 1, spell);
					return;
				end
			else
				if (targetName == YOU or targetName == CSG_L_YOU) then
					return;
				elseif (CSGiz.detect == 1) then
					CSG_CaptureAttack(unitName, nil, nil, nil, nil, 1, spell);
					CSG_CaptureAttack(targetName, nil, nil, nil, nil, 1, spell);
					CSG_CaptureHealer(unitName, targetName);
				else
					CSG_CaptureHealer(unitName, targetName);
				end
				return;
			end
			return;
		end
		for unitName, spell, targetName in string.gfind(arg1, CSG_SPLL_CASTS) do
			if (not targetName or unitName == targetName or string.gfind(targetName, unitName)) then
				if (CSGiz.detect == 1) then
					CSG_CaptureAttack(unitName, nil, nil, nil, nil, 1, spell);
					return;
				end
			else
				if (targetName == YOU or targetName == CSG_L_YOU) then
					return;
				elseif (CSGiz.detect == 1) then
					CSG_CaptureAttack(unitName, nil, nil, nil, nil, 1, spell);
					CSG_CaptureAttack(targetName, nil, nil, nil, nil, 1, spell);
					CSG_CaptureHealer(unitName, targetName);
				else
					CSG_CaptureHealer(unitName, targetName);
				end
				return;
			end
			return;
		end
		for unitName, spell in string.gfind(arg1, CSG_SPLL_CASTS2) do
			if (CSGiz.detect == 1) then
				CSG_CaptureAttack(unitName, nil, nil, nil, nil, 1, spell);
				return;
			end
			return;
		end
		for unitName, spell in string.gfind(arg1, CSG_SPLL_GAINS) do
			--GAINS IS NOT WORKING
			if (CSGiz.detect == 1) then
				if (spell and CSG_AbilityList[spell] and CSG_AbilityList[spell].ob) then
					CSG_CaptureAttack(unitName, nil, nil, nil, nil, 1);
				else
					CSG_CaptureAttack(unitName, nil, nil, nil, nil, 1, spell);
				end	
				return;
			end
			return;
		end
		for unitName in string.gfind(arg1, CSG_SPLL_GAINS2) do
			--GAINS IS NOT WORKING
			if (CSGiz.detect == 1) then
				CSG_CaptureAttack(unitName, nil, nil, nil, nil, 1);
				return;
			end
			return;
		end
		for unitName, spell in string.gfind(arg1, CSG_SPLL_BPERFORM) do
			if (CSGiz.detect == 1) then
				CSG_CaptureAttack(unitName, nil, nil, nil, nil, 1, spell);
				return;
			end
			return;
		end
		for unitName, spell in string.gfind(arg1, CSG_SPLL_BCAST) do
			if (CSGiz.detect == 1) then
				CSG_CaptureAttack(unitName, nil, nil, nil, nil, 1, spell);
				return;
			end
			return;
		end

	-- CREATURES
	elseif (event == "CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS" or event == "CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS") then
		if (CSGiz.creatures == 0) then
			return;
		end

		for unitName, targetName, damage in string.gfind(arg1, CSG_DAM_HIT) do
			CSG_CaptureAttack(unitName, targetName, damage);
			return;
		end
		for unitName, targetName, damage in string.gfind(arg1, CSG_DAM_CRIT) do
			CSG_CaptureAttack(unitName, targetName, damage);
			return;
		end


	elseif (event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE") then
	--CSG_AddMessage("SPELL - CREATURE_DAMAGE");
		if (CSGiz.creatures == 0) then
			return;
		end

		for unitName, spell, targetName, damage in string.gfind(arg1, CSG_SDAM_HIT) do
			CSG_CaptureAttack(unitName, targetName, damage);
			return;
		end
		
		for unitName, spell, targetName, damage in string.gfind(arg1, CSG_SDAM_CRIT) do
			CSG_CaptureAttack(unitName, targetName, damage);
			return;
		end
	     
		for unitName, spell in string.gfind(arg1, CSG_SDAM_BLOCK) do
			CSG_CaptureAttack(unitName);
			return;
		end
		for unitName, spell in string.gfind(arg1, CSG_SDAM_DEFLECT) do
			CSG_CaptureAttack(unitName);
			return;
		end
		for unitName, spell in string.gfind(arg1, CSG_SDAM_DODGE) do
			CSG_CaptureAttack(unitName);
			return;
		end
		for unitName, spell in string.gfind(arg1, CSG_SDAM_EVADE) do
			CSG_CaptureAttack(unitName);
			return;
		end
		for unitName, spell in string.gfind(arg1, CSG_SDAM_FAIL) do
			CSG_CaptureAttack(unitName);
			return;
		end
		for unitName, spell in string.gfind(arg1, CSG_SDAM_MISS) do
			CSG_CaptureAttack(unitName);
			return;
		end
		for unitName, spell in string.gfind(arg1, CSG_SDAM_PARRY) do
			CSG_CaptureAttack(unitName);
			return;
		end
		for unitName, spell in string.gfind(arg1, CSG_SDAM_RESIST) do
			CSG_CaptureAttack(unitName);
			return;
		end


	elseif (event == "CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES" or event == "CHAT_MSG_COMBAT_CREATURE_VS_PARTY_MISSES") then
--	CSG_AddMessage("CREATURE_VS_SELF_MISSES");
		if (CSGiz.creatures == 0) then
			return;
		end

		for unitName, targetName in string.gfind(arg1, CSG_MISS_MISS) do
			if (CSGiz.detect == 0 and (targetName ~= YOU or targetName ~= CSG_L_YOU)) then
				return;
			end
			CSG_CaptureAttack(unitName, targetName);
			return;
		end
		for unitName, targetName in string.gfind(arg1, CSG_MISS_PARRY) do
			if (CSGiz.detect == 0 and (targetName ~= YOU or targetName ~= CSG_L_YOU)) then
				return;
			end
			CSG_CaptureAttack(unitName, targetName);
			return;
		end
		for unitName, targetName in string.gfind(arg1, CSG_MISS_EVADE) do
			if (CSGiz.detect == 0 and (targetName ~= YOU or targetName ~= CSG_L_YOU)) then
				return;
			end
			CSG_CaptureAttack(unitName, targetName);
			return;
		end
		for unitName, targetName in string.gfind(arg1, CSG_MISS_DODGE) do
			if (CSGiz.detect == 0 and (targetName ~= YOU or targetName ~= CSG_L_YOU)) then
				return;
			end
			CSG_CaptureAttack(unitName, targetName);
			return;
		end
		for unitName, targetName in string.gfind(arg1, CSG_MISS_DEFLECT) do
			if (CSGiz.detect == 0 and (targetName ~= YOU or targetName ~= CSG_L_YOU)) then
				return;
			end
			CSG_CaptureAttack(unitName, targetName);
			return;
		end
		for unitName, targetName in string.gfind(arg1, CSG_MISS_BLOCK) do
			if (CSGiz.detect == 0 and (targetName ~= YOU or targetName ~= CSG_L_YOU)) then
				return;
			end
			CSG_CaptureAttack(unitName, targetName);
			return;
		end
		for unitName, targetName, damage in string.gfind(arg1, CSG_MISS_ABSORB) do
			if (CSGiz.detect == 0 and (targetName ~= YOU or targetName ~= CSG_L_YOU)) then
				return;
			elseif (targetName == YOU or targetName == CSG_L_YOU) then
				CSG_CaptureAttack(unitName, targetName, damage);
				return;
			else
				damage = nil;
			end
			CSG_CaptureAttack(unitName, targetName, damage);
			return;
		end
		-- Events below here are used to detect healers and buffers
	elseif (event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_BUFF" or event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF") then
		--CSG_AddMessage("SPELL - CREATURE_BUFF");
		if (CSGiz.creatures == 0) then
			return;
		end
		for unitName, spell, targetName, damage in string.gfind(arg1, CSG_SPLL_HEALCRIT) do
			if (unitName == targetName) then
				return;
			else
				if (targetName == YOU or targetName == CSG_L_YOU) then
					return;
				end
				CSG_CaptureHealer(unitName, targetName, damage);
				return;
			end
		end
		for unitName, spell, targetName, damage in string.gfind(arg1, CSG_SPLL_HEAL) do
			if (unitName == targetName) then
				return;
			else
				if (targetName == YOU or targetName == CSG_L_YOU) then
					return;
				end
				CSG_CaptureHealer(unitName, targetName, damage);
				return;
			end
		end
		for unitName, spell, targetName in string.gfind(arg1, CSG_SPLL_CAST) do
			if (unitName == targetName) then
				return;

			else
				if (targetName == YOU or targetName == CSG_L_YOU) then
					return;
				end
				CSG_CaptureHealer(unitName, targetName);
				return;
			end
		end
		for unitName, spell, targetName in string.gfind(arg1, CSG_SPLL_CASTS) do
			if (unitName == targetName) then
				return;
			else
				if (targetName == YOU or targetName == CSG_L_YOU) then
					return;
				end
				CSG_CaptureHealer(unitName, targetName);
				return;
			end
		end


	elseif (event == "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE" 
	--or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE"
	) then
		--CSG_AddMessage("PERIODIC - PLAYER_DAMAGE");

	elseif (event == "SPELLCAST_CHANNEL_START") then
		--CSG_AddMessage("CHANNEL_START");

	elseif (event == "SPELLCAST_FAILED") then
		--CSG_AddMessage("SPELLCAST_FAILED");

	elseif (event == "SPELLCAST_START") then
		--CSG_AddMessage("SPELLCAST_START");

	
	-- Monster death
	elseif (event == "CHAT_MSG_COMBAT_HOSTILE_DEATH" or event == "CHAT_MSG_COMBAT_XP_GAIN") then
		for unitName in string.gfind(arg1, CSG_DIES) do 
			CSG_AddMessage("|cffff2020Capturing death of: "..unitName);
			CSG_UnitDeath( unitName );
			return;
		end	
		for unitName in string.gfind(arg1, CSG_SLAINBY) do 
			CSG_AddMessage("|cffff2020Capturing death of: "..unitName);
			CSG_UnitDeath( unitName );
			return;
		end
	end
end

function CSG_OptionsBar_UpdateCheckboxes()
	if ( CSGiz.on == 1 ) then
		CSG_Button_On:SetChecked( 0 );
	else
		CSG_Button_On:SetChecked( 1 );
	end
	if ( CSGiz.detect == 1 ) then
		CSG_Button_Detect:SetChecked( 0 );	
	else
		CSG_Button_Detect:SetChecked( 1 );
	end
	if ( CSGiz.creatures == 1 ) then
		CSG_Button_Creatures:SetChecked( 0 );	
	else
		CSG_Button_Creatures:SetChecked( 1 );
	end
	if ( CSGiz.infotarget == 1 ) then
		CSG_Button_InfoTarget:SetChecked( 0 );	
	else
		CSG_Button_InfoTarget:SetChecked( 1 );
	end
end

function CSG_ToggleOptionsFrame()
	if ( CSG_OptionsFrame:IsVisible() ) then
		HideUIPanel(CSG_OptionsFrame);
		PlaySound("gsTitleOptionExit");
		-- Check if the options frame was opened by myAddOns
--[[		if (MYADDONS_ACTIVE_OPTIONSFRAME == this) then
			ShowUIPanel(myAddOnsFrame);
		else
			ShowUIPanel(GameMenuFrame);
		end]]
	else
		CSG_OptionsFrame_UpdateCheckboxes();
		CSG_OptionsFrame_UpdateSliders();

		HideUIPanel(GameMenuFrame);
		ShowUIPanel(CSG_OptionsFrame);
		PlaySound("igMainMenuQuit");
	end
end

function CSG_OptionsFrame_OnLoad()
	CSG_OptionsFrameHeaderText:SetText(CSG_TITLE);
	--CSG_UpdateTabs_Initialize();
	--PanelTemplates_SetNumTabs(TipBuddy_OptionsFrame_PlayersFrame, 3);
	--PanelTemplates_SetNumTabs(TipBuddy_OptionsFrame_NPCsFrame, 3);
	--PanelTemplates_SetNumTabs(TipBuddy_OptionsFrame_PetsFrame, 2);
end

function CSG_OptionsFrame_UpdateCheckboxes()
	for index, value in CSG_OptionsFrame_CheckButtons do
		local button = getglobal( value.frame );
		local string = getglobal( value.frame.."Text");

		if (not button) then
			return;
		end

		button:SetChecked( CSGiz[value.var] );

		string:SetText( TEXT(value.text) );
		button.tooltipText = value.tooltipText;
		button.tooltipRequirement = value.tooltipRequirement;
		button.gxRestart = value.gxRestart;
		button.restartClient = value.restartClient;

		if ( button.disabled ) then
			button:Disable();
			string:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
		else
			button:Enable();
			string:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		end
	end
end

function CSG_OptionsFrame_UpdateSliders()
	if (not CSGiz.temp) then
		CSGiz.temp = 1;	
	end
	for index, value in CSG_OptionsFrame_Sliders do
		local slider = getglobal("CSG_OptionsFrame_Slider"..index);
		local string = getglobal("CSG_OptionsFrame_Slider"..index.."Text");
		local high = getglobal("CSG_OptionsFrame_Slider"..index.."High");
		local low = getglobal("CSG_OptionsFrame_Slider"..index.."Low");

		CSG_OptionsFrame_SliderCalcEnabled( slider );

		low:SetText( value.minValue );
		high:SetText( value.maxValue );			

		slider:SetMinMaxValues(value.minValue, value.maxValue);
		slider:SetValueStep(value.valueStep);
		--if (index == 1) then
		--	slider:SetValue( CSGiz[value.var] / UIParent:GetScale() ); 
		--else
			slider:SetValue( CSGiz[value.var] );
		--end
		string:SetText(TEXT(value.text));
		slider.tooltipText = value.tooltipText;
		slider.tooltipRequirement = value.tooltipRequirement;
		slider.gxRestart = value.gxRestart;
		slider.restartClient = value.restartClient;
	end
end

function CSG_OptionsFrame_SliderCalcEnabled( slider )
	local thumb = getglobal(slider:GetName().."Thumb");
	local string = getglobal(slider:GetName().."Text");
	local updatetext = getglobal(slider:GetName().."TextUpdate");
	local high = getglobal(slider:GetName().."High");
	local low = getglobal(slider:GetName().."Low");
	if ( slider.disabled ) then
		slider:EnableMouse(0);
		thumb:Hide();
		string:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
		updatetext:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
		low:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
		high:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
	else
		slider:EnableMouse(1);
		thumb:Show();
		string:SetVertexColor(NORMAL_FONT_COLOR.r , NORMAL_FONT_COLOR.g , NORMAL_FONT_COLOR.b);
		updatetext:SetVertexColor(NORMAL_FONT_COLOR.r , NORMAL_FONT_COLOR.g , NORMAL_FONT_COLOR.b);
		low:SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		high:SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	end
end


CSG_AnchorBar = {
	[1] = CSG_MENU_AB_OCCUPIED,
	[2] = CSG_MENU_AB_ALWAYS,
	[3] = CSG_MENU_AB_NEVER,
};

function CSG_AnchorBarDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, CSG_AnchorBarDropDown_Initialize);
	UIDropDownMenu_SetSelectedValue(this, CSGiz.anchor);
	UIDropDownMenu_SetWidth(120, CSG_AnchorBarDropDown);
end

function CSG_AnchorBarDropDown_OnClick()
	UIDropDownMenu_SetSelectedValue(CSG_AnchorBarDropDown, this.value);
	CSGiz.anchor = this.value;
end

function CSG_AnchorBarDropDown_Initialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue(CSG_AnchorBarDropDown);
	local info;

	info = {};
	info.text = CSG_AnchorBar[1];
	info.func = CSG_AnchorBarDropDown_OnClick;
	info.value = 0;
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	info.tooltipTitle = CSG_MENU_AB_OCCUPIED_TOOLTIP;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = CSG_AnchorBar[2];
	info.func = CSG_AnchorBarDropDown_OnClick;
	info.value = 1;
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	info.tooltipTitle = CSG_MENU_AB_ALWAYS_TOOLTIP;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = CSG_AnchorBar[3];
	info.func = CSG_AnchorBarDropDown_OnClick;
	info.value = 2;
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	info.tooltipTitle = CSG_MENU_AB_NEVER_TOOLTIP;
	UIDropDownMenu_AddButton(info);
end

---------------------------------------------------------------
-- SAVING DATA AFTER 'OK'
---------------------------------------------------------------
function CSG_OptionsFrame_OnSave()
	-- Checkboxes
	for index, value in CSG_OptionsFrame_CheckButtons do
		local button = getglobal( value.frame );		

		if ( button:GetChecked() ) then	
			CSGiz[value.var] = 1;
		else
			CSGiz[value.var] = 0;
		end
	end

	-- Sliders
	for index, value in CSG_OptionsFrame_Sliders do

		local slider = getglobal("CSG_OptionsFrame_Slider"..index);
		--if (index == 1) then
		--	CSGiz[value.var] = (UIParent:GetScale() * slider:GetValue());
		--else
			CSGiz[value.var] = slider:GetValue();
		--end
	end
	CSG_MainFrame_Toggle();
end
